return {
	Play114251001 = function(arg_1_0, arg_1_1)
		arg_1_1.time_ = 0
		arg_1_1.frameCnt_ = 0
		arg_1_1.state_ = "playing"
		arg_1_1.curTalkId_ = 114251001
		arg_1_1.duration_ = 11.83

		local var_1_0 = {
			ja = 7.099999999999,
			ko = 10.232999999999,
			zh = 10.332999999999,
			en = 11.832999999999
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
				arg_1_0:Play114251002(arg_1_1)
			end
		end

		function arg_1_1.onSingleLineUpdate_(arg_4_0)
			local var_4_0 = "ST25"

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
				local var_4_5 = arg_1_1.bgs_.ST25

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
					if iter_4_0 ~= "ST25" then
						iter_4_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_4_16 = 0

			if var_4_16 < arg_1_1.time_ and arg_1_1.time_ <= var_4_16 + arg_4_0 then
				arg_1_1.mask_.enabled = true
				arg_1_1.mask_.raycastTarget = true

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

			local var_4_22 = "10018"

			if arg_1_1.actors_[var_4_22] == nil then
				local var_4_23 = Asset.Load("Widget/System/Story/StoryExpression/" .. "10018")

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

			local var_4_26 = arg_1_1.actors_["10018"].transform
			local var_4_27 = 1.8

			if var_4_27 < arg_1_1.time_ and arg_1_1.time_ <= var_4_27 + arg_4_0 then
				arg_1_1.var_.moveOldPos10018 = var_4_26.localPosition
				var_4_26.localScale = Vector3.New(1, 1, 1)

				arg_1_1:CheckSpriteTmpPos("10018", 2)

				local var_4_28 = var_4_26.childCount

				for iter_4_4 = 0, var_4_28 - 1 do
					local var_4_29 = var_4_26:GetChild(iter_4_4)

					if var_4_29.name == "split_1" or not string.find(var_4_29.name, "split") then
						var_4_29.gameObject:SetActive(true)
					else
						var_4_29.gameObject:SetActive(false)
					end
				end
			end

			local var_4_30 = 0.001

			if var_4_27 <= arg_1_1.time_ and arg_1_1.time_ < var_4_27 + var_4_30 then
				local var_4_31 = (arg_1_1.time_ - var_4_27) / var_4_30
				local var_4_32 = Vector3.New(-390, -350, -180)

				var_4_26.localPosition = Vector3.Lerp(arg_1_1.var_.moveOldPos10018, var_4_32, var_4_31)
			end

			if arg_1_1.time_ >= var_4_27 + var_4_30 and arg_1_1.time_ < var_4_27 + var_4_30 + arg_4_0 then
				var_4_26.localPosition = Vector3.New(-390, -350, -180)
			end

			local var_4_33 = arg_1_1.actors_["10018"]
			local var_4_34 = 1.8

			if var_4_34 < arg_1_1.time_ and arg_1_1.time_ <= var_4_34 + arg_4_0 and not isNil(var_4_33) and arg_1_1.var_.actorSpriteComps10018 == nil then
				arg_1_1.var_.actorSpriteComps10018 = var_4_33:GetComponentsInChildren(typeof(Image), true)
			end

			local var_4_35 = 0.034

			if var_4_34 <= arg_1_1.time_ and arg_1_1.time_ < var_4_34 + var_4_35 and not isNil(var_4_33) then
				local var_4_36 = (arg_1_1.time_ - var_4_34) / var_4_35

				if arg_1_1.var_.actorSpriteComps10018 then
					for iter_4_5, iter_4_6 in pairs(arg_1_1.var_.actorSpriteComps10018:ToTable()) do
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

			if arg_1_1.time_ >= var_4_34 + var_4_35 and arg_1_1.time_ < var_4_34 + var_4_35 + arg_4_0 and not isNil(var_4_33) and arg_1_1.var_.actorSpriteComps10018 then
				for iter_4_7, iter_4_8 in pairs(arg_1_1.var_.actorSpriteComps10018:ToTable()) do
					if iter_4_8 then
						if arg_1_1.isInRecall_ then
							iter_4_8.color = arg_1_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_4_8.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_1_1.var_.actorSpriteComps10018 = nil
			end

			local var_4_41 = arg_1_1.actors_["10018"]
			local var_4_42 = 1.8

			if var_4_42 < arg_1_1.time_ and arg_1_1.time_ <= var_4_42 + arg_4_0 then
				local var_4_43 = var_4_41:GetComponentInChildren(typeof(CanvasGroup))

				if var_4_43 then
					arg_1_1.var_.alphaOldValue10018 = var_4_43.alpha
					arg_1_1.var_.characterEffect10018 = var_4_43
				end

				arg_1_1.var_.alphaOldValue10018 = 0
			end

			local var_4_44 = 0.5

			if var_4_42 <= arg_1_1.time_ and arg_1_1.time_ < var_4_42 + var_4_44 then
				local var_4_45 = (arg_1_1.time_ - var_4_42) / var_4_44
				local var_4_46 = Mathf.Lerp(arg_1_1.var_.alphaOldValue10018, 1, var_4_45)

				if arg_1_1.var_.characterEffect10018 then
					arg_1_1.var_.characterEffect10018.alpha = var_4_46
				end
			end

			if arg_1_1.time_ >= var_4_42 + var_4_44 and arg_1_1.time_ < var_4_42 + var_4_44 + arg_4_0 and arg_1_1.var_.characterEffect10018 then
				arg_1_1.var_.characterEffect10018.alpha = 1
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
			local var_4_54 = 1.2

			if var_4_53 < arg_1_1.time_ and arg_1_1.time_ <= var_4_53 + arg_4_0 then
				local var_4_55 = "play"
				local var_4_56 = "music"

				arg_1_1:AudioAction(var_4_55, var_4_56, "bgm_activity_1_3_story_indoor", "bgm_activity_1_3_story_indoor", "bgm_activity_1_3_story_indoor.awb")

				local var_4_57 = ""
				local var_4_58 = manager.audio:GetAudioName("bgm_activity_1_3_story_indoor", "bgm_activity_1_3_story_indoor")

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
			local var_4_60 = 0.85

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

				local var_4_62 = arg_1_1:FormatText(StoryNameCfg[257].name)

				arg_1_1.leftNameTxt_.text = var_4_62

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_1_1.leftNameTxt_.transform)

				arg_1_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_1_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_1_1:RecordName(arg_1_1.leftNameTxt_.text)
				SetActive(arg_1_1.iconTrs_.gameObject, false)
				arg_1_1.callingController_:SetSelectedState("normal")

				local var_4_63 = arg_1_1:GetWordFromCfg(114251001)
				local var_4_64 = arg_1_1:FormatText(var_4_63.content)

				arg_1_1.text_.text = var_4_64

				LuaForUtil.ClearLinePrefixSymbol(arg_1_1.text_)

				local var_4_65 = 34
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

				if manager.audio:GetVoiceLength("story_v_out_114251", "114251001", "story_v_out_114251.awb") ~= 0 then
					local var_4_68 = manager.audio:GetVoiceLength("story_v_out_114251", "114251001", "story_v_out_114251.awb") / 1000

					if var_4_68 + var_4_59 > arg_1_1.duration_ then
						arg_1_1.duration_ = var_4_68 + var_4_59
					end

					if var_4_63.prefab_name ~= "" and arg_1_1.actors_[var_4_63.prefab_name] ~= nil then
						local var_4_69 = LuaForUtil.PlayVoiceWithCriLipsync(arg_1_1.actors_[var_4_63.prefab_name].transform, "story_v_out_114251", "114251001", "story_v_out_114251.awb")

						arg_1_1:RecordAudio("114251001", var_4_69)
						arg_1_1:RecordAudio("114251001", var_4_69)
					else
						arg_1_1:AudioAction("play", "voice", "story_v_out_114251", "114251001", "story_v_out_114251.awb")
					end

					arg_1_1:RecordHistoryTalkVoice("story_v_out_114251", "114251001", "story_v_out_114251.awb")
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
				actorName = "10018",
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
	Play114251002 = function(arg_9_0, arg_9_1)
		arg_9_1.time_ = 0
		arg_9_1.frameCnt_ = 0
		arg_9_1.state_ = "playing"
		arg_9_1.curTalkId_ = 114251002
		arg_9_1.duration_ = 7.5

		local var_9_0 = {
			ja = 7.5,
			ko = 5.333,
			zh = 6.366,
			en = 6.166
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
				arg_9_0:Play114251003(arg_9_1)
			end
		end

		function arg_9_1.onSingleLineUpdate_(arg_12_0)
			local var_12_0 = 0
			local var_12_1 = 0.775

			if var_12_0 < arg_9_1.time_ and arg_9_1.time_ <= var_12_0 + arg_12_0 then
				arg_9_1.talkMaxDuration = 0
				arg_9_1.dialogCg_.alpha = 1

				arg_9_1.dialog_:SetActive(true)
				SetActive(arg_9_1.leftNameGo_, true)

				local var_12_2 = arg_9_1:FormatText(StoryNameCfg[257].name)

				arg_9_1.leftNameTxt_.text = var_12_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_9_1.leftNameTxt_.transform)

				arg_9_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_9_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_9_1:RecordName(arg_9_1.leftNameTxt_.text)
				SetActive(arg_9_1.iconTrs_.gameObject, false)
				arg_9_1.callingController_:SetSelectedState("normal")

				local var_12_3 = arg_9_1:GetWordFromCfg(114251002)
				local var_12_4 = arg_9_1:FormatText(var_12_3.content)

				arg_9_1.text_.text = var_12_4

				LuaForUtil.ClearLinePrefixSymbol(arg_9_1.text_)

				local var_12_5 = 31
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

				if manager.audio:GetVoiceLength("story_v_out_114251", "114251002", "story_v_out_114251.awb") ~= 0 then
					local var_12_8 = manager.audio:GetVoiceLength("story_v_out_114251", "114251002", "story_v_out_114251.awb") / 1000

					if var_12_8 + var_12_0 > arg_9_1.duration_ then
						arg_9_1.duration_ = var_12_8 + var_12_0
					end

					if var_12_3.prefab_name ~= "" and arg_9_1.actors_[var_12_3.prefab_name] ~= nil then
						local var_12_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_9_1.actors_[var_12_3.prefab_name].transform, "story_v_out_114251", "114251002", "story_v_out_114251.awb")

						arg_9_1:RecordAudio("114251002", var_12_9)
						arg_9_1:RecordAudio("114251002", var_12_9)
					else
						arg_9_1:AudioAction("play", "voice", "story_v_out_114251", "114251002", "story_v_out_114251.awb")
					end

					arg_9_1:RecordHistoryTalkVoice("story_v_out_114251", "114251002", "story_v_out_114251.awb")
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
	Play114251003 = function(arg_13_0, arg_13_1)
		arg_13_1.time_ = 0
		arg_13_1.frameCnt_ = 0
		arg_13_1.state_ = "playing"
		arg_13_1.curTalkId_ = 114251003
		arg_13_1.duration_ = 8.87

		local var_13_0 = {
			ja = 7.466,
			ko = 8.833,
			zh = 8.866,
			en = 6.666
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
				arg_13_0:Play114251004(arg_13_1)
			end
		end

		function arg_13_1.onSingleLineUpdate_(arg_16_0)
			local var_16_0 = "10015"

			if arg_13_1.actors_[var_16_0] == nil then
				local var_16_1 = Asset.Load("Widget/System/Story/StoryExpression/" .. "10015")

				if not isNil(var_16_1) then
					local var_16_2 = Object.Instantiate(var_16_1, arg_13_1.canvasGo_.transform)

					var_16_2.transform:SetSiblingIndex(1)

					var_16_2.name = var_16_0
					var_16_2.transform.localPosition = Vector3.New(0, 100000, 0)
					arg_13_1.actors_[var_16_0] = var_16_2

					local var_16_3 = var_16_2:GetComponentsInChildren(typeof(Image), true):ToTable()

					if arg_13_1.isInRecall_ then
						for iter_16_0, iter_16_1 in ipairs(var_16_3) do
							iter_16_1.color = arg_13_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						end
					end
				end
			end

			local var_16_4 = arg_13_1.actors_["10015"].transform
			local var_16_5 = 0

			if var_16_5 < arg_13_1.time_ and arg_13_1.time_ <= var_16_5 + arg_16_0 then
				arg_13_1.var_.moveOldPos10015 = var_16_4.localPosition
				var_16_4.localScale = Vector3.New(1, 1, 1)

				arg_13_1:CheckSpriteTmpPos("10015", 4)

				local var_16_6 = var_16_4.childCount

				for iter_16_2 = 0, var_16_6 - 1 do
					local var_16_7 = var_16_4:GetChild(iter_16_2)

					if var_16_7.name == "split_1" or not string.find(var_16_7.name, "split") then
						var_16_7.gameObject:SetActive(true)
					else
						var_16_7.gameObject:SetActive(false)
					end
				end
			end

			local var_16_8 = 0.001

			if var_16_5 <= arg_13_1.time_ and arg_13_1.time_ < var_16_5 + var_16_8 then
				local var_16_9 = (arg_13_1.time_ - var_16_5) / var_16_8
				local var_16_10 = Vector3.New(390, -350, -180)

				var_16_4.localPosition = Vector3.Lerp(arg_13_1.var_.moveOldPos10015, var_16_10, var_16_9)
			end

			if arg_13_1.time_ >= var_16_5 + var_16_8 and arg_13_1.time_ < var_16_5 + var_16_8 + arg_16_0 then
				var_16_4.localPosition = Vector3.New(390, -350, -180)
			end

			local var_16_11 = arg_13_1.actors_["10018"]
			local var_16_12 = 0

			if var_16_12 < arg_13_1.time_ and arg_13_1.time_ <= var_16_12 + arg_16_0 and not isNil(var_16_11) and arg_13_1.var_.actorSpriteComps10018 == nil then
				arg_13_1.var_.actorSpriteComps10018 = var_16_11:GetComponentsInChildren(typeof(Image), true)
			end

			local var_16_13 = 0.034

			if var_16_12 <= arg_13_1.time_ and arg_13_1.time_ < var_16_12 + var_16_13 and not isNil(var_16_11) then
				local var_16_14 = (arg_13_1.time_ - var_16_12) / var_16_13

				if arg_13_1.var_.actorSpriteComps10018 then
					for iter_16_3, iter_16_4 in pairs(arg_13_1.var_.actorSpriteComps10018:ToTable()) do
						if iter_16_4 then
							if arg_13_1.isInRecall_ then
								local var_16_15 = Mathf.Lerp(iter_16_4.color.r, arg_13_1.hightColor2.r, var_16_14)
								local var_16_16 = Mathf.Lerp(iter_16_4.color.g, arg_13_1.hightColor2.g, var_16_14)
								local var_16_17 = Mathf.Lerp(iter_16_4.color.b, arg_13_1.hightColor2.b, var_16_14)

								iter_16_4.color = Color.New(var_16_15, var_16_16, var_16_17)
							else
								local var_16_18 = Mathf.Lerp(iter_16_4.color.r, 0.5, var_16_14)

								iter_16_4.color = Color.New(var_16_18, var_16_18, var_16_18)
							end
						end
					end
				end
			end

			if arg_13_1.time_ >= var_16_12 + var_16_13 and arg_13_1.time_ < var_16_12 + var_16_13 + arg_16_0 and not isNil(var_16_11) and arg_13_1.var_.actorSpriteComps10018 then
				for iter_16_5, iter_16_6 in pairs(arg_13_1.var_.actorSpriteComps10018:ToTable()) do
					if iter_16_6 then
						if arg_13_1.isInRecall_ then
							iter_16_6.color = arg_13_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_16_6.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_13_1.var_.actorSpriteComps10018 = nil
			end

			local var_16_19 = arg_13_1.actors_["10015"]
			local var_16_20 = 0

			if var_16_20 < arg_13_1.time_ and arg_13_1.time_ <= var_16_20 + arg_16_0 and not isNil(var_16_19) and arg_13_1.var_.actorSpriteComps10015 == nil then
				arg_13_1.var_.actorSpriteComps10015 = var_16_19:GetComponentsInChildren(typeof(Image), true)
			end

			local var_16_21 = 0.034

			if var_16_20 <= arg_13_1.time_ and arg_13_1.time_ < var_16_20 + var_16_21 and not isNil(var_16_19) then
				local var_16_22 = (arg_13_1.time_ - var_16_20) / var_16_21

				if arg_13_1.var_.actorSpriteComps10015 then
					for iter_16_7, iter_16_8 in pairs(arg_13_1.var_.actorSpriteComps10015:ToTable()) do
						if iter_16_8 then
							if arg_13_1.isInRecall_ then
								local var_16_23 = Mathf.Lerp(iter_16_8.color.r, arg_13_1.hightColor1.r, var_16_22)
								local var_16_24 = Mathf.Lerp(iter_16_8.color.g, arg_13_1.hightColor1.g, var_16_22)
								local var_16_25 = Mathf.Lerp(iter_16_8.color.b, arg_13_1.hightColor1.b, var_16_22)

								iter_16_8.color = Color.New(var_16_23, var_16_24, var_16_25)
							else
								local var_16_26 = Mathf.Lerp(iter_16_8.color.r, 1, var_16_22)

								iter_16_8.color = Color.New(var_16_26, var_16_26, var_16_26)
							end
						end
					end
				end
			end

			if arg_13_1.time_ >= var_16_20 + var_16_21 and arg_13_1.time_ < var_16_20 + var_16_21 + arg_16_0 and not isNil(var_16_19) and arg_13_1.var_.actorSpriteComps10015 then
				for iter_16_9, iter_16_10 in pairs(arg_13_1.var_.actorSpriteComps10015:ToTable()) do
					if iter_16_10 then
						if arg_13_1.isInRecall_ then
							iter_16_10.color = arg_13_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_16_10.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_13_1.var_.actorSpriteComps10015 = nil
			end

			local var_16_27 = arg_13_1.actors_["10015"]
			local var_16_28 = 0

			if var_16_28 < arg_13_1.time_ and arg_13_1.time_ <= var_16_28 + arg_16_0 then
				local var_16_29 = var_16_27:GetComponentInChildren(typeof(CanvasGroup))

				if var_16_29 then
					arg_13_1.var_.alphaOldValue10015 = var_16_29.alpha
					arg_13_1.var_.characterEffect10015 = var_16_29
				end

				arg_13_1.var_.alphaOldValue10015 = 0
			end

			local var_16_30 = 0.5

			if var_16_28 <= arg_13_1.time_ and arg_13_1.time_ < var_16_28 + var_16_30 then
				local var_16_31 = (arg_13_1.time_ - var_16_28) / var_16_30
				local var_16_32 = Mathf.Lerp(arg_13_1.var_.alphaOldValue10015, 1, var_16_31)

				if arg_13_1.var_.characterEffect10015 then
					arg_13_1.var_.characterEffect10015.alpha = var_16_32
				end
			end

			if arg_13_1.time_ >= var_16_28 + var_16_30 and arg_13_1.time_ < var_16_28 + var_16_30 + arg_16_0 and arg_13_1.var_.characterEffect10015 then
				arg_13_1.var_.characterEffect10015.alpha = 1
			end

			local var_16_33 = 0
			local var_16_34 = 0.9

			if var_16_33 < arg_13_1.time_ and arg_13_1.time_ <= var_16_33 + arg_16_0 then
				arg_13_1.talkMaxDuration = 0
				arg_13_1.dialogCg_.alpha = 1

				arg_13_1.dialog_:SetActive(true)
				SetActive(arg_13_1.leftNameGo_, true)

				local var_16_35 = arg_13_1:FormatText(StoryNameCfg[208].name)

				arg_13_1.leftNameTxt_.text = var_16_35

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_13_1.leftNameTxt_.transform)

				arg_13_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_13_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_13_1:RecordName(arg_13_1.leftNameTxt_.text)
				SetActive(arg_13_1.iconTrs_.gameObject, false)
				arg_13_1.callingController_:SetSelectedState("normal")

				local var_16_36 = arg_13_1:GetWordFromCfg(114251003)
				local var_16_37 = arg_13_1:FormatText(var_16_36.content)

				arg_13_1.text_.text = var_16_37

				LuaForUtil.ClearLinePrefixSymbol(arg_13_1.text_)

				local var_16_38 = 35
				local var_16_39 = utf8.len(var_16_37)
				local var_16_40 = var_16_38 <= 0 and var_16_34 or var_16_34 * (var_16_39 / var_16_38)

				if var_16_40 > 0 and var_16_34 < var_16_40 then
					arg_13_1.talkMaxDuration = var_16_40

					if var_16_40 + var_16_33 > arg_13_1.duration_ then
						arg_13_1.duration_ = var_16_40 + var_16_33
					end
				end

				arg_13_1.text_.text = var_16_37
				arg_13_1.typewritter.percent = 0

				arg_13_1.typewritter:SetDirty()
				arg_13_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_114251", "114251003", "story_v_out_114251.awb") ~= 0 then
					local var_16_41 = manager.audio:GetVoiceLength("story_v_out_114251", "114251003", "story_v_out_114251.awb") / 1000

					if var_16_41 + var_16_33 > arg_13_1.duration_ then
						arg_13_1.duration_ = var_16_41 + var_16_33
					end

					if var_16_36.prefab_name ~= "" and arg_13_1.actors_[var_16_36.prefab_name] ~= nil then
						local var_16_42 = LuaForUtil.PlayVoiceWithCriLipsync(arg_13_1.actors_[var_16_36.prefab_name].transform, "story_v_out_114251", "114251003", "story_v_out_114251.awb")

						arg_13_1:RecordAudio("114251003", var_16_42)
						arg_13_1:RecordAudio("114251003", var_16_42)
					else
						arg_13_1:AudioAction("play", "voice", "story_v_out_114251", "114251003", "story_v_out_114251.awb")
					end

					arg_13_1:RecordHistoryTalkVoice("story_v_out_114251", "114251003", "story_v_out_114251.awb")
				end

				arg_13_1:RecordContent(arg_13_1.text_.text)
			end

			local var_16_43 = math.max(var_16_34, arg_13_1.talkMaxDuration)

			if var_16_33 <= arg_13_1.time_ and arg_13_1.time_ < var_16_33 + var_16_43 then
				arg_13_1.typewritter.percent = (arg_13_1.time_ - var_16_33) / var_16_43

				arg_13_1.typewritter:SetDirty()
			end

			if arg_13_1.time_ >= var_16_33 + var_16_43 and arg_13_1.time_ < var_16_33 + var_16_43 + arg_16_0 then
				arg_13_1.typewritter.percent = 1

				arg_13_1.typewritter:SetDirty()
				arg_13_1:ShowNextGo(true)
			end
		end

		arg_13_1.nodeConfigList_ = {
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

		arg_13_1:InitPlayNodeList()
	end,
	Play114251004 = function(arg_17_0, arg_17_1)
		arg_17_1.time_ = 0
		arg_17_1.frameCnt_ = 0
		arg_17_1.state_ = "playing"
		arg_17_1.curTalkId_ = 114251004
		arg_17_1.duration_ = 5

		SetActive(arg_17_1.tipsGo_, false)

		function arg_17_1.onSingleLineFinish_()
			arg_17_1.onSingleLineUpdate_ = nil
			arg_17_1.onSingleLineFinish_ = nil
			arg_17_1.state_ = "waiting"
		end

		function arg_17_1.playNext_(arg_19_0)
			if arg_19_0 == 1 then
				arg_17_0:Play114251005(arg_17_1)
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

			if arg_17_1.time_ >= var_20_1 + var_20_2 and arg_17_1.time_ < var_20_1 + var_20_2 + arg_20_0 and not isNil(var_20_0) and arg_17_1.var_.actorSpriteComps10015 then
				for iter_20_2, iter_20_3 in pairs(arg_17_1.var_.actorSpriteComps10015:ToTable()) do
					if iter_20_3 then
						if arg_17_1.isInRecall_ then
							iter_20_3.color = arg_17_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_20_3.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_17_1.var_.actorSpriteComps10015 = nil
			end

			local var_20_8 = 0
			local var_20_9 = 0.9

			if var_20_8 < arg_17_1.time_ and arg_17_1.time_ <= var_20_8 + arg_20_0 then
				arg_17_1.talkMaxDuration = 0
				arg_17_1.dialogCg_.alpha = 1

				arg_17_1.dialog_:SetActive(true)
				SetActive(arg_17_1.leftNameGo_, false)

				arg_17_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_17_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_17_1:RecordName(arg_17_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_17_1.iconTrs_.gameObject, false)
				arg_17_1.callingController_:SetSelectedState("normal")

				local var_20_10 = arg_17_1:GetWordFromCfg(114251004)
				local var_20_11 = arg_17_1:FormatText(var_20_10.content)

				arg_17_1.text_.text = var_20_11

				LuaForUtil.ClearLinePrefixSymbol(arg_17_1.text_)

				local var_20_12 = 36
				local var_20_13 = utf8.len(var_20_11)
				local var_20_14 = var_20_12 <= 0 and var_20_9 or var_20_9 * (var_20_13 / var_20_12)

				if var_20_14 > 0 and var_20_9 < var_20_14 then
					arg_17_1.talkMaxDuration = var_20_14

					if var_20_14 + var_20_8 > arg_17_1.duration_ then
						arg_17_1.duration_ = var_20_14 + var_20_8
					end
				end

				arg_17_1.text_.text = var_20_11
				arg_17_1.typewritter.percent = 0

				arg_17_1.typewritter:SetDirty()
				arg_17_1:ShowNextGo(false)
				arg_17_1:RecordContent(arg_17_1.text_.text)
			end

			local var_20_15 = math.max(var_20_9, arg_17_1.talkMaxDuration)

			if var_20_8 <= arg_17_1.time_ and arg_17_1.time_ < var_20_8 + var_20_15 then
				arg_17_1.typewritter.percent = (arg_17_1.time_ - var_20_8) / var_20_15

				arg_17_1.typewritter:SetDirty()
			end

			if arg_17_1.time_ >= var_20_8 + var_20_15 and arg_17_1.time_ < var_20_8 + var_20_15 + arg_20_0 then
				arg_17_1.typewritter.percent = 1

				arg_17_1.typewritter:SetDirty()
				arg_17_1:ShowNextGo(true)
			end
		end

		arg_17_1.nodeConfigList_ = {}

		arg_17_1:InitPlayNodeList()
	end,
	Play114251005 = function(arg_21_0, arg_21_1)
		arg_21_1.time_ = 0
		arg_21_1.frameCnt_ = 0
		arg_21_1.state_ = "playing"
		arg_21_1.curTalkId_ = 114251005
		arg_21_1.duration_ = 7

		local var_21_0 = {
			ja = 7,
			ko = 2.666,
			zh = 2.466,
			en = 2.8
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
				arg_21_0:Play114251006(arg_21_1)
			end
		end

		function arg_21_1.onSingleLineUpdate_(arg_24_0)
			local var_24_0 = arg_21_1.actors_["10018"]
			local var_24_1 = 0

			if var_24_1 < arg_21_1.time_ and arg_21_1.time_ <= var_24_1 + arg_24_0 and not isNil(var_24_0) and arg_21_1.var_.actorSpriteComps10018 == nil then
				arg_21_1.var_.actorSpriteComps10018 = var_24_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_24_2 = 0.034

			if var_24_1 <= arg_21_1.time_ and arg_21_1.time_ < var_24_1 + var_24_2 and not isNil(var_24_0) then
				local var_24_3 = (arg_21_1.time_ - var_24_1) / var_24_2

				if arg_21_1.var_.actorSpriteComps10018 then
					for iter_24_0, iter_24_1 in pairs(arg_21_1.var_.actorSpriteComps10018:ToTable()) do
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

			if arg_21_1.time_ >= var_24_1 + var_24_2 and arg_21_1.time_ < var_24_1 + var_24_2 + arg_24_0 and not isNil(var_24_0) and arg_21_1.var_.actorSpriteComps10018 then
				for iter_24_2, iter_24_3 in pairs(arg_21_1.var_.actorSpriteComps10018:ToTable()) do
					if iter_24_3 then
						if arg_21_1.isInRecall_ then
							iter_24_3.color = arg_21_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_24_3.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_21_1.var_.actorSpriteComps10018 = nil
			end

			local var_24_8 = arg_21_1.actors_["10015"]
			local var_24_9 = 0

			if var_24_9 < arg_21_1.time_ and arg_21_1.time_ <= var_24_9 + arg_24_0 and not isNil(var_24_8) and arg_21_1.var_.actorSpriteComps10015 == nil then
				arg_21_1.var_.actorSpriteComps10015 = var_24_8:GetComponentsInChildren(typeof(Image), true)
			end

			local var_24_10 = 0.034

			if var_24_9 <= arg_21_1.time_ and arg_21_1.time_ < var_24_9 + var_24_10 and not isNil(var_24_8) then
				local var_24_11 = (arg_21_1.time_ - var_24_9) / var_24_10

				if arg_21_1.var_.actorSpriteComps10015 then
					for iter_24_4, iter_24_5 in pairs(arg_21_1.var_.actorSpriteComps10015:ToTable()) do
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

			if arg_21_1.time_ >= var_24_9 + var_24_10 and arg_21_1.time_ < var_24_9 + var_24_10 + arg_24_0 and not isNil(var_24_8) and arg_21_1.var_.actorSpriteComps10015 then
				for iter_24_6, iter_24_7 in pairs(arg_21_1.var_.actorSpriteComps10015:ToTable()) do
					if iter_24_7 then
						if arg_21_1.isInRecall_ then
							iter_24_7.color = arg_21_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_24_7.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_21_1.var_.actorSpriteComps10015 = nil
			end

			local var_24_16 = 0
			local var_24_17 = 0.275

			if var_24_16 < arg_21_1.time_ and arg_21_1.time_ <= var_24_16 + arg_24_0 then
				arg_21_1.talkMaxDuration = 0
				arg_21_1.dialogCg_.alpha = 1

				arg_21_1.dialog_:SetActive(true)
				SetActive(arg_21_1.leftNameGo_, true)

				local var_24_18 = arg_21_1:FormatText(StoryNameCfg[257].name)

				arg_21_1.leftNameTxt_.text = var_24_18

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_21_1.leftNameTxt_.transform)

				arg_21_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_21_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_21_1:RecordName(arg_21_1.leftNameTxt_.text)
				SetActive(arg_21_1.iconTrs_.gameObject, false)
				arg_21_1.callingController_:SetSelectedState("normal")

				local var_24_19 = arg_21_1:GetWordFromCfg(114251005)
				local var_24_20 = arg_21_1:FormatText(var_24_19.content)

				arg_21_1.text_.text = var_24_20

				LuaForUtil.ClearLinePrefixSymbol(arg_21_1.text_)

				local var_24_21 = 11
				local var_24_22 = utf8.len(var_24_20)
				local var_24_23 = var_24_21 <= 0 and var_24_17 or var_24_17 * (var_24_22 / var_24_21)

				if var_24_23 > 0 and var_24_17 < var_24_23 then
					arg_21_1.talkMaxDuration = var_24_23

					if var_24_23 + var_24_16 > arg_21_1.duration_ then
						arg_21_1.duration_ = var_24_23 + var_24_16
					end
				end

				arg_21_1.text_.text = var_24_20
				arg_21_1.typewritter.percent = 0

				arg_21_1.typewritter:SetDirty()
				arg_21_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_114251", "114251005", "story_v_out_114251.awb") ~= 0 then
					local var_24_24 = manager.audio:GetVoiceLength("story_v_out_114251", "114251005", "story_v_out_114251.awb") / 1000

					if var_24_24 + var_24_16 > arg_21_1.duration_ then
						arg_21_1.duration_ = var_24_24 + var_24_16
					end

					if var_24_19.prefab_name ~= "" and arg_21_1.actors_[var_24_19.prefab_name] ~= nil then
						local var_24_25 = LuaForUtil.PlayVoiceWithCriLipsync(arg_21_1.actors_[var_24_19.prefab_name].transform, "story_v_out_114251", "114251005", "story_v_out_114251.awb")

						arg_21_1:RecordAudio("114251005", var_24_25)
						arg_21_1:RecordAudio("114251005", var_24_25)
					else
						arg_21_1:AudioAction("play", "voice", "story_v_out_114251", "114251005", "story_v_out_114251.awb")
					end

					arg_21_1:RecordHistoryTalkVoice("story_v_out_114251", "114251005", "story_v_out_114251.awb")
				end

				arg_21_1:RecordContent(arg_21_1.text_.text)
			end

			local var_24_26 = math.max(var_24_17, arg_21_1.talkMaxDuration)

			if var_24_16 <= arg_21_1.time_ and arg_21_1.time_ < var_24_16 + var_24_26 then
				arg_21_1.typewritter.percent = (arg_21_1.time_ - var_24_16) / var_24_26

				arg_21_1.typewritter:SetDirty()
			end

			if arg_21_1.time_ >= var_24_16 + var_24_26 and arg_21_1.time_ < var_24_16 + var_24_26 + arg_24_0 then
				arg_21_1.typewritter.percent = 1

				arg_21_1.typewritter:SetDirty()
				arg_21_1:ShowNextGo(true)
			end
		end

		arg_21_1.nodeConfigList_ = {}

		arg_21_1:InitPlayNodeList()
	end,
	Play114251006 = function(arg_25_0, arg_25_1)
		arg_25_1.time_ = 0
		arg_25_1.frameCnt_ = 0
		arg_25_1.state_ = "playing"
		arg_25_1.curTalkId_ = 114251006
		arg_25_1.duration_ = 1.67

		local var_25_0 = {
			ja = 1.166,
			ko = 1.666,
			zh = 1.366,
			en = 1.433
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
				arg_25_0:Play114251007(arg_25_1)
			end
		end

		function arg_25_1.onSingleLineUpdate_(arg_28_0)
			local var_28_0 = arg_25_1.actors_["10018"]
			local var_28_1 = 0

			if var_28_1 < arg_25_1.time_ and arg_25_1.time_ <= var_28_1 + arg_28_0 and not isNil(var_28_0) and arg_25_1.var_.actorSpriteComps10018 == nil then
				arg_25_1.var_.actorSpriteComps10018 = var_28_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_28_2 = 0.034

			if var_28_1 <= arg_25_1.time_ and arg_25_1.time_ < var_28_1 + var_28_2 and not isNil(var_28_0) then
				local var_28_3 = (arg_25_1.time_ - var_28_1) / var_28_2

				if arg_25_1.var_.actorSpriteComps10018 then
					for iter_28_0, iter_28_1 in pairs(arg_25_1.var_.actorSpriteComps10018:ToTable()) do
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

			if arg_25_1.time_ >= var_28_1 + var_28_2 and arg_25_1.time_ < var_28_1 + var_28_2 + arg_28_0 and not isNil(var_28_0) and arg_25_1.var_.actorSpriteComps10018 then
				for iter_28_2, iter_28_3 in pairs(arg_25_1.var_.actorSpriteComps10018:ToTable()) do
					if iter_28_3 then
						if arg_25_1.isInRecall_ then
							iter_28_3.color = arg_25_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_28_3.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_25_1.var_.actorSpriteComps10018 = nil
			end

			local var_28_8 = arg_25_1.actors_["10015"]
			local var_28_9 = 0

			if var_28_9 < arg_25_1.time_ and arg_25_1.time_ <= var_28_9 + arg_28_0 and not isNil(var_28_8) and arg_25_1.var_.actorSpriteComps10015 == nil then
				arg_25_1.var_.actorSpriteComps10015 = var_28_8:GetComponentsInChildren(typeof(Image), true)
			end

			local var_28_10 = 0.034

			if var_28_9 <= arg_25_1.time_ and arg_25_1.time_ < var_28_9 + var_28_10 and not isNil(var_28_8) then
				local var_28_11 = (arg_25_1.time_ - var_28_9) / var_28_10

				if arg_25_1.var_.actorSpriteComps10015 then
					for iter_28_4, iter_28_5 in pairs(arg_25_1.var_.actorSpriteComps10015:ToTable()) do
						if iter_28_5 then
							if arg_25_1.isInRecall_ then
								local var_28_12 = Mathf.Lerp(iter_28_5.color.r, arg_25_1.hightColor1.r, var_28_11)
								local var_28_13 = Mathf.Lerp(iter_28_5.color.g, arg_25_1.hightColor1.g, var_28_11)
								local var_28_14 = Mathf.Lerp(iter_28_5.color.b, arg_25_1.hightColor1.b, var_28_11)

								iter_28_5.color = Color.New(var_28_12, var_28_13, var_28_14)
							else
								local var_28_15 = Mathf.Lerp(iter_28_5.color.r, 1, var_28_11)

								iter_28_5.color = Color.New(var_28_15, var_28_15, var_28_15)
							end
						end
					end
				end
			end

			if arg_25_1.time_ >= var_28_9 + var_28_10 and arg_25_1.time_ < var_28_9 + var_28_10 + arg_28_0 and not isNil(var_28_8) and arg_25_1.var_.actorSpriteComps10015 then
				for iter_28_6, iter_28_7 in pairs(arg_25_1.var_.actorSpriteComps10015:ToTable()) do
					if iter_28_7 then
						if arg_25_1.isInRecall_ then
							iter_28_7.color = arg_25_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_28_7.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_25_1.var_.actorSpriteComps10015 = nil
			end

			local var_28_16 = arg_25_1.actors_["10015"].transform
			local var_28_17 = 0

			if var_28_17 < arg_25_1.time_ and arg_25_1.time_ <= var_28_17 + arg_28_0 then
				arg_25_1.var_.moveOldPos10015 = var_28_16.localPosition
				var_28_16.localScale = Vector3.New(1, 1, 1)

				arg_25_1:CheckSpriteTmpPos("10015", 4)

				local var_28_18 = var_28_16.childCount

				for iter_28_8 = 0, var_28_18 - 1 do
					local var_28_19 = var_28_16:GetChild(iter_28_8)

					if var_28_19.name == "split_5" or not string.find(var_28_19.name, "split") then
						var_28_19.gameObject:SetActive(true)
					else
						var_28_19.gameObject:SetActive(false)
					end
				end
			end

			local var_28_20 = 0.001

			if var_28_17 <= arg_25_1.time_ and arg_25_1.time_ < var_28_17 + var_28_20 then
				local var_28_21 = (arg_25_1.time_ - var_28_17) / var_28_20
				local var_28_22 = Vector3.New(390, -350, -180)

				var_28_16.localPosition = Vector3.Lerp(arg_25_1.var_.moveOldPos10015, var_28_22, var_28_21)
			end

			if arg_25_1.time_ >= var_28_17 + var_28_20 and arg_25_1.time_ < var_28_17 + var_28_20 + arg_28_0 then
				var_28_16.localPosition = Vector3.New(390, -350, -180)
			end

			local var_28_23 = 0
			local var_28_24 = 0.075

			if var_28_23 < arg_25_1.time_ and arg_25_1.time_ <= var_28_23 + arg_28_0 then
				arg_25_1.talkMaxDuration = 0
				arg_25_1.dialogCg_.alpha = 1

				arg_25_1.dialog_:SetActive(true)
				SetActive(arg_25_1.leftNameGo_, true)

				local var_28_25 = arg_25_1:FormatText(StoryNameCfg[208].name)

				arg_25_1.leftNameTxt_.text = var_28_25

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_25_1.leftNameTxt_.transform)

				arg_25_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_25_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_25_1:RecordName(arg_25_1.leftNameTxt_.text)
				SetActive(arg_25_1.iconTrs_.gameObject, false)
				arg_25_1.callingController_:SetSelectedState("normal")

				local var_28_26 = arg_25_1:GetWordFromCfg(114251006)
				local var_28_27 = arg_25_1:FormatText(var_28_26.content)

				arg_25_1.text_.text = var_28_27

				LuaForUtil.ClearLinePrefixSymbol(arg_25_1.text_)

				local var_28_28 = 3
				local var_28_29 = utf8.len(var_28_27)
				local var_28_30 = var_28_28 <= 0 and var_28_24 or var_28_24 * (var_28_29 / var_28_28)

				if var_28_30 > 0 and var_28_24 < var_28_30 then
					arg_25_1.talkMaxDuration = var_28_30

					if var_28_30 + var_28_23 > arg_25_1.duration_ then
						arg_25_1.duration_ = var_28_30 + var_28_23
					end
				end

				arg_25_1.text_.text = var_28_27
				arg_25_1.typewritter.percent = 0

				arg_25_1.typewritter:SetDirty()
				arg_25_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_114251", "114251006", "story_v_out_114251.awb") ~= 0 then
					local var_28_31 = manager.audio:GetVoiceLength("story_v_out_114251", "114251006", "story_v_out_114251.awb") / 1000

					if var_28_31 + var_28_23 > arg_25_1.duration_ then
						arg_25_1.duration_ = var_28_31 + var_28_23
					end

					if var_28_26.prefab_name ~= "" and arg_25_1.actors_[var_28_26.prefab_name] ~= nil then
						local var_28_32 = LuaForUtil.PlayVoiceWithCriLipsync(arg_25_1.actors_[var_28_26.prefab_name].transform, "story_v_out_114251", "114251006", "story_v_out_114251.awb")

						arg_25_1:RecordAudio("114251006", var_28_32)
						arg_25_1:RecordAudio("114251006", var_28_32)
					else
						arg_25_1:AudioAction("play", "voice", "story_v_out_114251", "114251006", "story_v_out_114251.awb")
					end

					arg_25_1:RecordHistoryTalkVoice("story_v_out_114251", "114251006", "story_v_out_114251.awb")
				end

				arg_25_1:RecordContent(arg_25_1.text_.text)
			end

			local var_28_33 = math.max(var_28_24, arg_25_1.talkMaxDuration)

			if var_28_23 <= arg_25_1.time_ and arg_25_1.time_ < var_28_23 + var_28_33 then
				arg_25_1.typewritter.percent = (arg_25_1.time_ - var_28_23) / var_28_33

				arg_25_1.typewritter:SetDirty()
			end

			if arg_25_1.time_ >= var_28_23 + var_28_33 and arg_25_1.time_ < var_28_23 + var_28_33 + arg_28_0 then
				arg_25_1.typewritter.percent = 1

				arg_25_1.typewritter:SetDirty()
				arg_25_1:ShowNextGo(true)
			end
		end

		arg_25_1.nodeConfigList_ = {
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

		arg_25_1:InitPlayNodeList()
	end,
	Play114251007 = function(arg_29_0, arg_29_1)
		arg_29_1.time_ = 0
		arg_29_1.frameCnt_ = 0
		arg_29_1.state_ = "playing"
		arg_29_1.curTalkId_ = 114251007
		arg_29_1.duration_ = 7.47

		local var_29_0 = {
			ja = 7.366,
			ko = 7.266,
			zh = 6.633,
			en = 7.466
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
				arg_29_0:Play114251008(arg_29_1)
			end
		end

		function arg_29_1.onSingleLineUpdate_(arg_32_0)
			local var_32_0 = arg_29_1.actors_["10018"]
			local var_32_1 = 0

			if var_32_1 < arg_29_1.time_ and arg_29_1.time_ <= var_32_1 + arg_32_0 and not isNil(var_32_0) and arg_29_1.var_.actorSpriteComps10018 == nil then
				arg_29_1.var_.actorSpriteComps10018 = var_32_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_32_2 = 0.034

			if var_32_1 <= arg_29_1.time_ and arg_29_1.time_ < var_32_1 + var_32_2 and not isNil(var_32_0) then
				local var_32_3 = (arg_29_1.time_ - var_32_1) / var_32_2

				if arg_29_1.var_.actorSpriteComps10018 then
					for iter_32_0, iter_32_1 in pairs(arg_29_1.var_.actorSpriteComps10018:ToTable()) do
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

			if arg_29_1.time_ >= var_32_1 + var_32_2 and arg_29_1.time_ < var_32_1 + var_32_2 + arg_32_0 and not isNil(var_32_0) and arg_29_1.var_.actorSpriteComps10018 then
				for iter_32_2, iter_32_3 in pairs(arg_29_1.var_.actorSpriteComps10018:ToTable()) do
					if iter_32_3 then
						if arg_29_1.isInRecall_ then
							iter_32_3.color = arg_29_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_32_3.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_29_1.var_.actorSpriteComps10018 = nil
			end

			local var_32_8 = arg_29_1.actors_["10015"]
			local var_32_9 = 0

			if var_32_9 < arg_29_1.time_ and arg_29_1.time_ <= var_32_9 + arg_32_0 and not isNil(var_32_8) and arg_29_1.var_.actorSpriteComps10015 == nil then
				arg_29_1.var_.actorSpriteComps10015 = var_32_8:GetComponentsInChildren(typeof(Image), true)
			end

			local var_32_10 = 0.034

			if var_32_9 <= arg_29_1.time_ and arg_29_1.time_ < var_32_9 + var_32_10 and not isNil(var_32_8) then
				local var_32_11 = (arg_29_1.time_ - var_32_9) / var_32_10

				if arg_29_1.var_.actorSpriteComps10015 then
					for iter_32_4, iter_32_5 in pairs(arg_29_1.var_.actorSpriteComps10015:ToTable()) do
						if iter_32_5 then
							if arg_29_1.isInRecall_ then
								local var_32_12 = Mathf.Lerp(iter_32_5.color.r, arg_29_1.hightColor2.r, var_32_11)
								local var_32_13 = Mathf.Lerp(iter_32_5.color.g, arg_29_1.hightColor2.g, var_32_11)
								local var_32_14 = Mathf.Lerp(iter_32_5.color.b, arg_29_1.hightColor2.b, var_32_11)

								iter_32_5.color = Color.New(var_32_12, var_32_13, var_32_14)
							else
								local var_32_15 = Mathf.Lerp(iter_32_5.color.r, 0.5, var_32_11)

								iter_32_5.color = Color.New(var_32_15, var_32_15, var_32_15)
							end
						end
					end
				end
			end

			if arg_29_1.time_ >= var_32_9 + var_32_10 and arg_29_1.time_ < var_32_9 + var_32_10 + arg_32_0 and not isNil(var_32_8) and arg_29_1.var_.actorSpriteComps10015 then
				for iter_32_6, iter_32_7 in pairs(arg_29_1.var_.actorSpriteComps10015:ToTable()) do
					if iter_32_7 then
						if arg_29_1.isInRecall_ then
							iter_32_7.color = arg_29_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_32_7.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_29_1.var_.actorSpriteComps10015 = nil
			end

			local var_32_16 = 0
			local var_32_17 = 0.8

			if var_32_16 < arg_29_1.time_ and arg_29_1.time_ <= var_32_16 + arg_32_0 then
				arg_29_1.talkMaxDuration = 0
				arg_29_1.dialogCg_.alpha = 1

				arg_29_1.dialog_:SetActive(true)
				SetActive(arg_29_1.leftNameGo_, true)

				local var_32_18 = arg_29_1:FormatText(StoryNameCfg[257].name)

				arg_29_1.leftNameTxt_.text = var_32_18

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_29_1.leftNameTxt_.transform)

				arg_29_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_29_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_29_1:RecordName(arg_29_1.leftNameTxt_.text)
				SetActive(arg_29_1.iconTrs_.gameObject, false)
				arg_29_1.callingController_:SetSelectedState("normal")

				local var_32_19 = arg_29_1:GetWordFromCfg(114251007)
				local var_32_20 = arg_29_1:FormatText(var_32_19.content)

				arg_29_1.text_.text = var_32_20

				LuaForUtil.ClearLinePrefixSymbol(arg_29_1.text_)

				local var_32_21 = 32
				local var_32_22 = utf8.len(var_32_20)
				local var_32_23 = var_32_21 <= 0 and var_32_17 or var_32_17 * (var_32_22 / var_32_21)

				if var_32_23 > 0 and var_32_17 < var_32_23 then
					arg_29_1.talkMaxDuration = var_32_23

					if var_32_23 + var_32_16 > arg_29_1.duration_ then
						arg_29_1.duration_ = var_32_23 + var_32_16
					end
				end

				arg_29_1.text_.text = var_32_20
				arg_29_1.typewritter.percent = 0

				arg_29_1.typewritter:SetDirty()
				arg_29_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_114251", "114251007", "story_v_out_114251.awb") ~= 0 then
					local var_32_24 = manager.audio:GetVoiceLength("story_v_out_114251", "114251007", "story_v_out_114251.awb") / 1000

					if var_32_24 + var_32_16 > arg_29_1.duration_ then
						arg_29_1.duration_ = var_32_24 + var_32_16
					end

					if var_32_19.prefab_name ~= "" and arg_29_1.actors_[var_32_19.prefab_name] ~= nil then
						local var_32_25 = LuaForUtil.PlayVoiceWithCriLipsync(arg_29_1.actors_[var_32_19.prefab_name].transform, "story_v_out_114251", "114251007", "story_v_out_114251.awb")

						arg_29_1:RecordAudio("114251007", var_32_25)
						arg_29_1:RecordAudio("114251007", var_32_25)
					else
						arg_29_1:AudioAction("play", "voice", "story_v_out_114251", "114251007", "story_v_out_114251.awb")
					end

					arg_29_1:RecordHistoryTalkVoice("story_v_out_114251", "114251007", "story_v_out_114251.awb")
				end

				arg_29_1:RecordContent(arg_29_1.text_.text)
			end

			local var_32_26 = math.max(var_32_17, arg_29_1.talkMaxDuration)

			if var_32_16 <= arg_29_1.time_ and arg_29_1.time_ < var_32_16 + var_32_26 then
				arg_29_1.typewritter.percent = (arg_29_1.time_ - var_32_16) / var_32_26

				arg_29_1.typewritter:SetDirty()
			end

			if arg_29_1.time_ >= var_32_16 + var_32_26 and arg_29_1.time_ < var_32_16 + var_32_26 + arg_32_0 then
				arg_29_1.typewritter.percent = 1

				arg_29_1.typewritter:SetDirty()
				arg_29_1:ShowNextGo(true)
			end
		end

		arg_29_1.nodeConfigList_ = {}

		arg_29_1:InitPlayNodeList()
	end,
	Play114251008 = function(arg_33_0, arg_33_1)
		arg_33_1.time_ = 0
		arg_33_1.frameCnt_ = 0
		arg_33_1.state_ = "playing"
		arg_33_1.curTalkId_ = 114251008
		arg_33_1.duration_ = 9.33

		local var_33_0 = {
			ja = 9.266,
			ko = 9.333,
			zh = 8.366,
			en = 8
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
				arg_33_0:Play114251009(arg_33_1)
			end
		end

		function arg_33_1.onSingleLineUpdate_(arg_36_0)
			local var_36_0 = arg_33_1.actors_["10015"]
			local var_36_1 = 0

			if var_36_1 < arg_33_1.time_ and arg_33_1.time_ <= var_36_1 + arg_36_0 then
				local var_36_2 = var_36_0:GetComponentInChildren(typeof(CanvasGroup))

				if var_36_2 then
					arg_33_1.var_.alphaOldValue10015 = var_36_2.alpha
					arg_33_1.var_.characterEffect10015 = var_36_2
				end

				arg_33_1.var_.alphaOldValue10015 = 1
			end

			local var_36_3 = 0.5

			if var_36_1 <= arg_33_1.time_ and arg_33_1.time_ < var_36_1 + var_36_3 then
				local var_36_4 = (arg_33_1.time_ - var_36_1) / var_36_3
				local var_36_5 = Mathf.Lerp(arg_33_1.var_.alphaOldValue10015, 0, var_36_4)

				if arg_33_1.var_.characterEffect10015 then
					arg_33_1.var_.characterEffect10015.alpha = var_36_5
				end
			end

			if arg_33_1.time_ >= var_36_1 + var_36_3 and arg_33_1.time_ < var_36_1 + var_36_3 + arg_36_0 and arg_33_1.var_.characterEffect10015 then
				arg_33_1.var_.characterEffect10015.alpha = 0
			end

			local var_36_6 = arg_33_1.actors_["10018"]
			local var_36_7 = 0

			if var_36_7 < arg_33_1.time_ and arg_33_1.time_ <= var_36_7 + arg_36_0 then
				local var_36_8 = var_36_6:GetComponentInChildren(typeof(CanvasGroup))

				if var_36_8 then
					arg_33_1.var_.alphaOldValue10018 = var_36_8.alpha
					arg_33_1.var_.characterEffect10018 = var_36_8
				end

				arg_33_1.var_.alphaOldValue10018 = 1
			end

			local var_36_9 = 0.5

			if var_36_7 <= arg_33_1.time_ and arg_33_1.time_ < var_36_7 + var_36_9 then
				local var_36_10 = (arg_33_1.time_ - var_36_7) / var_36_9
				local var_36_11 = Mathf.Lerp(arg_33_1.var_.alphaOldValue10018, 0, var_36_10)

				if arg_33_1.var_.characterEffect10018 then
					arg_33_1.var_.characterEffect10018.alpha = var_36_11
				end
			end

			if arg_33_1.time_ >= var_36_7 + var_36_9 and arg_33_1.time_ < var_36_7 + var_36_9 + arg_36_0 and arg_33_1.var_.characterEffect10018 then
				arg_33_1.var_.characterEffect10018.alpha = 0
			end

			local var_36_12 = 0
			local var_36_13 = 0.95

			if var_36_12 < arg_33_1.time_ and arg_33_1.time_ <= var_36_12 + arg_36_0 then
				arg_33_1.talkMaxDuration = 0
				arg_33_1.dialogCg_.alpha = 1

				arg_33_1.dialog_:SetActive(true)
				SetActive(arg_33_1.leftNameGo_, true)

				local var_36_14 = arg_33_1:FormatText(StoryNameCfg[225].name)

				arg_33_1.leftNameTxt_.text = var_36_14

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_33_1.leftNameTxt_.transform)

				arg_33_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_33_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_33_1:RecordName(arg_33_1.leftNameTxt_.text)
				SetActive(arg_33_1.iconTrs_.gameObject, true)
				arg_33_1.iconController_:SetSelectedState("hero")

				arg_33_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_10005")

				arg_33_1.callingController_:SetSelectedState("normal")

				arg_33_1.keyicon_.color = Color.New(1, 1, 1)
				arg_33_1.icon_.color = Color.New(1, 1, 1)

				local var_36_15 = arg_33_1:GetWordFromCfg(114251008)
				local var_36_16 = arg_33_1:FormatText(var_36_15.content)

				arg_33_1.text_.text = var_36_16

				LuaForUtil.ClearLinePrefixSymbol(arg_33_1.text_)

				local var_36_17 = 38
				local var_36_18 = utf8.len(var_36_16)
				local var_36_19 = var_36_17 <= 0 and var_36_13 or var_36_13 * (var_36_18 / var_36_17)

				if var_36_19 > 0 and var_36_13 < var_36_19 then
					arg_33_1.talkMaxDuration = var_36_19

					if var_36_19 + var_36_12 > arg_33_1.duration_ then
						arg_33_1.duration_ = var_36_19 + var_36_12
					end
				end

				arg_33_1.text_.text = var_36_16
				arg_33_1.typewritter.percent = 0

				arg_33_1.typewritter:SetDirty()
				arg_33_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_114251", "114251008", "story_v_out_114251.awb") ~= 0 then
					local var_36_20 = manager.audio:GetVoiceLength("story_v_out_114251", "114251008", "story_v_out_114251.awb") / 1000

					if var_36_20 + var_36_12 > arg_33_1.duration_ then
						arg_33_1.duration_ = var_36_20 + var_36_12
					end

					if var_36_15.prefab_name ~= "" and arg_33_1.actors_[var_36_15.prefab_name] ~= nil then
						local var_36_21 = LuaForUtil.PlayVoiceWithCriLipsync(arg_33_1.actors_[var_36_15.prefab_name].transform, "story_v_out_114251", "114251008", "story_v_out_114251.awb")

						arg_33_1:RecordAudio("114251008", var_36_21)
						arg_33_1:RecordAudio("114251008", var_36_21)
					else
						arg_33_1:AudioAction("play", "voice", "story_v_out_114251", "114251008", "story_v_out_114251.awb")
					end

					arg_33_1:RecordHistoryTalkVoice("story_v_out_114251", "114251008", "story_v_out_114251.awb")
				end

				arg_33_1:RecordContent(arg_33_1.text_.text)
			end

			local var_36_22 = math.max(var_36_13, arg_33_1.talkMaxDuration)

			if var_36_12 <= arg_33_1.time_ and arg_33_1.time_ < var_36_12 + var_36_22 then
				arg_33_1.typewritter.percent = (arg_33_1.time_ - var_36_12) / var_36_22

				arg_33_1.typewritter:SetDirty()
			end

			if arg_33_1.time_ >= var_36_12 + var_36_22 and arg_33_1.time_ < var_36_12 + var_36_22 + arg_36_0 then
				arg_33_1.typewritter.percent = 1

				arg_33_1.typewritter:SetDirty()
				arg_33_1:ShowNextGo(true)
			end
		end

		arg_33_1.nodeConfigList_ = {}

		arg_33_1:InitPlayNodeList()
	end,
	Play114251009 = function(arg_37_0, arg_37_1)
		arg_37_1.time_ = 0
		arg_37_1.frameCnt_ = 0
		arg_37_1.state_ = "playing"
		arg_37_1.curTalkId_ = 114251009
		arg_37_1.duration_ = 8.67

		local var_37_0 = {
			ja = 8.366,
			ko = 8.666,
			zh = 8.333,
			en = 8.666
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
				arg_37_0:Play114251010(arg_37_1)
			end
		end

		function arg_37_1.onSingleLineUpdate_(arg_40_0)
			local var_40_0 = 0
			local var_40_1 = 0.975

			if var_40_0 < arg_37_1.time_ and arg_37_1.time_ <= var_40_0 + arg_40_0 then
				arg_37_1.talkMaxDuration = 0
				arg_37_1.dialogCg_.alpha = 1

				arg_37_1.dialog_:SetActive(true)
				SetActive(arg_37_1.leftNameGo_, true)

				local var_40_2 = arg_37_1:FormatText(StoryNameCfg[225].name)

				arg_37_1.leftNameTxt_.text = var_40_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_37_1.leftNameTxt_.transform)

				arg_37_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_37_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_37_1:RecordName(arg_37_1.leftNameTxt_.text)
				SetActive(arg_37_1.iconTrs_.gameObject, true)
				arg_37_1.iconController_:SetSelectedState("hero")

				arg_37_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_10005")

				arg_37_1.callingController_:SetSelectedState("normal")

				arg_37_1.keyicon_.color = Color.New(1, 1, 1)
				arg_37_1.icon_.color = Color.New(1, 1, 1)

				local var_40_3 = arg_37_1:GetWordFromCfg(114251009)
				local var_40_4 = arg_37_1:FormatText(var_40_3.content)

				arg_37_1.text_.text = var_40_4

				LuaForUtil.ClearLinePrefixSymbol(arg_37_1.text_)

				local var_40_5 = 39
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

				if manager.audio:GetVoiceLength("story_v_out_114251", "114251009", "story_v_out_114251.awb") ~= 0 then
					local var_40_8 = manager.audio:GetVoiceLength("story_v_out_114251", "114251009", "story_v_out_114251.awb") / 1000

					if var_40_8 + var_40_0 > arg_37_1.duration_ then
						arg_37_1.duration_ = var_40_8 + var_40_0
					end

					if var_40_3.prefab_name ~= "" and arg_37_1.actors_[var_40_3.prefab_name] ~= nil then
						local var_40_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_37_1.actors_[var_40_3.prefab_name].transform, "story_v_out_114251", "114251009", "story_v_out_114251.awb")

						arg_37_1:RecordAudio("114251009", var_40_9)
						arg_37_1:RecordAudio("114251009", var_40_9)
					else
						arg_37_1:AudioAction("play", "voice", "story_v_out_114251", "114251009", "story_v_out_114251.awb")
					end

					arg_37_1:RecordHistoryTalkVoice("story_v_out_114251", "114251009", "story_v_out_114251.awb")
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
	Play114251010 = function(arg_41_0, arg_41_1)
		arg_41_1.time_ = 0
		arg_41_1.frameCnt_ = 0
		arg_41_1.state_ = "playing"
		arg_41_1.curTalkId_ = 114251010
		arg_41_1.duration_ = 5

		SetActive(arg_41_1.tipsGo_, false)

		function arg_41_1.onSingleLineFinish_()
			arg_41_1.onSingleLineUpdate_ = nil
			arg_41_1.onSingleLineFinish_ = nil
			arg_41_1.state_ = "waiting"
		end

		function arg_41_1.playNext_(arg_43_0)
			if arg_43_0 == 1 then
				arg_41_0:Play114251011(arg_41_1)
			end
		end

		function arg_41_1.onSingleLineUpdate_(arg_44_0)
			local var_44_0 = 0
			local var_44_1 = 1.1

			if var_44_0 < arg_41_1.time_ and arg_41_1.time_ <= var_44_0 + arg_44_0 then
				arg_41_1.talkMaxDuration = 0
				arg_41_1.dialogCg_.alpha = 1

				arg_41_1.dialog_:SetActive(true)
				SetActive(arg_41_1.leftNameGo_, false)

				arg_41_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_41_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_41_1:RecordName(arg_41_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_41_1.iconTrs_.gameObject, false)
				arg_41_1.callingController_:SetSelectedState("normal")

				local var_44_2 = arg_41_1:GetWordFromCfg(114251010)
				local var_44_3 = arg_41_1:FormatText(var_44_2.content)

				arg_41_1.text_.text = var_44_3

				LuaForUtil.ClearLinePrefixSymbol(arg_41_1.text_)

				local var_44_4 = 44
				local var_44_5 = utf8.len(var_44_3)
				local var_44_6 = var_44_4 <= 0 and var_44_1 or var_44_1 * (var_44_5 / var_44_4)

				if var_44_6 > 0 and var_44_1 < var_44_6 then
					arg_41_1.talkMaxDuration = var_44_6

					if var_44_6 + var_44_0 > arg_41_1.duration_ then
						arg_41_1.duration_ = var_44_6 + var_44_0
					end
				end

				arg_41_1.text_.text = var_44_3
				arg_41_1.typewritter.percent = 0

				arg_41_1.typewritter:SetDirty()
				arg_41_1:ShowNextGo(false)
				arg_41_1:RecordContent(arg_41_1.text_.text)
			end

			local var_44_7 = math.max(var_44_1, arg_41_1.talkMaxDuration)

			if var_44_0 <= arg_41_1.time_ and arg_41_1.time_ < var_44_0 + var_44_7 then
				arg_41_1.typewritter.percent = (arg_41_1.time_ - var_44_0) / var_44_7

				arg_41_1.typewritter:SetDirty()
			end

			if arg_41_1.time_ >= var_44_0 + var_44_7 and arg_41_1.time_ < var_44_0 + var_44_7 + arg_44_0 then
				arg_41_1.typewritter.percent = 1

				arg_41_1.typewritter:SetDirty()
				arg_41_1:ShowNextGo(true)
			end
		end

		arg_41_1.nodeConfigList_ = {}

		arg_41_1:InitPlayNodeList()
	end,
	Play114251011 = function(arg_45_0, arg_45_1)
		arg_45_1.time_ = 0
		arg_45_1.frameCnt_ = 0
		arg_45_1.state_ = "playing"
		arg_45_1.curTalkId_ = 114251011
		arg_45_1.duration_ = 5

		SetActive(arg_45_1.tipsGo_, false)

		function arg_45_1.onSingleLineFinish_()
			arg_45_1.onSingleLineUpdate_ = nil
			arg_45_1.onSingleLineFinish_ = nil
			arg_45_1.state_ = "waiting"
		end

		function arg_45_1.playNext_(arg_47_0)
			if arg_47_0 == 1 then
				arg_45_0:Play114251012(arg_45_1)
			end
		end

		function arg_45_1.onSingleLineUpdate_(arg_48_0)
			local var_48_0 = 0
			local var_48_1 = 1.1

			if var_48_0 < arg_45_1.time_ and arg_45_1.time_ <= var_48_0 + arg_48_0 then
				arg_45_1.talkMaxDuration = 0
				arg_45_1.dialogCg_.alpha = 1

				arg_45_1.dialog_:SetActive(true)
				SetActive(arg_45_1.leftNameGo_, false)

				arg_45_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_45_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_45_1:RecordName(arg_45_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_45_1.iconTrs_.gameObject, false)
				arg_45_1.callingController_:SetSelectedState("normal")

				local var_48_2 = arg_45_1:GetWordFromCfg(114251011)
				local var_48_3 = arg_45_1:FormatText(var_48_2.content)

				arg_45_1.text_.text = var_48_3

				LuaForUtil.ClearLinePrefixSymbol(arg_45_1.text_)

				local var_48_4 = 44
				local var_48_5 = utf8.len(var_48_3)
				local var_48_6 = var_48_4 <= 0 and var_48_1 or var_48_1 * (var_48_5 / var_48_4)

				if var_48_6 > 0 and var_48_1 < var_48_6 then
					arg_45_1.talkMaxDuration = var_48_6

					if var_48_6 + var_48_0 > arg_45_1.duration_ then
						arg_45_1.duration_ = var_48_6 + var_48_0
					end
				end

				arg_45_1.text_.text = var_48_3
				arg_45_1.typewritter.percent = 0

				arg_45_1.typewritter:SetDirty()
				arg_45_1:ShowNextGo(false)
				arg_45_1:RecordContent(arg_45_1.text_.text)
			end

			local var_48_7 = math.max(var_48_1, arg_45_1.talkMaxDuration)

			if var_48_0 <= arg_45_1.time_ and arg_45_1.time_ < var_48_0 + var_48_7 then
				arg_45_1.typewritter.percent = (arg_45_1.time_ - var_48_0) / var_48_7

				arg_45_1.typewritter:SetDirty()
			end

			if arg_45_1.time_ >= var_48_0 + var_48_7 and arg_45_1.time_ < var_48_0 + var_48_7 + arg_48_0 then
				arg_45_1.typewritter.percent = 1

				arg_45_1.typewritter:SetDirty()
				arg_45_1:ShowNextGo(true)
			end
		end

		arg_45_1.nodeConfigList_ = {}

		arg_45_1:InitPlayNodeList()
	end,
	Play114251012 = function(arg_49_0, arg_49_1)
		arg_49_1.time_ = 0
		arg_49_1.frameCnt_ = 0
		arg_49_1.state_ = "playing"
		arg_49_1.curTalkId_ = 114251012
		arg_49_1.duration_ = 8.7

		local var_49_0 = {
			ja = 8.7,
			ko = 7.133,
			zh = 5.933,
			en = 8.066
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
				arg_49_0:Play114251013(arg_49_1)
			end
		end

		function arg_49_1.onSingleLineUpdate_(arg_52_0)
			local var_52_0 = 0
			local var_52_1 = 0.725

			if var_52_0 < arg_49_1.time_ and arg_49_1.time_ <= var_52_0 + arg_52_0 then
				arg_49_1.talkMaxDuration = 0
				arg_49_1.dialogCg_.alpha = 1

				arg_49_1.dialog_:SetActive(true)
				SetActive(arg_49_1.leftNameGo_, true)

				local var_52_2 = arg_49_1:FormatText(StoryNameCfg[225].name)

				arg_49_1.leftNameTxt_.text = var_52_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_49_1.leftNameTxt_.transform)

				arg_49_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_49_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_49_1:RecordName(arg_49_1.leftNameTxt_.text)
				SetActive(arg_49_1.iconTrs_.gameObject, true)
				arg_49_1.iconController_:SetSelectedState("hero")

				arg_49_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_10005")

				arg_49_1.callingController_:SetSelectedState("normal")

				arg_49_1.keyicon_.color = Color.New(1, 1, 1)
				arg_49_1.icon_.color = Color.New(1, 1, 1)

				local var_52_3 = arg_49_1:GetWordFromCfg(114251012)
				local var_52_4 = arg_49_1:FormatText(var_52_3.content)

				arg_49_1.text_.text = var_52_4

				LuaForUtil.ClearLinePrefixSymbol(arg_49_1.text_)

				local var_52_5 = 29
				local var_52_6 = utf8.len(var_52_4)
				local var_52_7 = var_52_5 <= 0 and var_52_1 or var_52_1 * (var_52_6 / var_52_5)

				if var_52_7 > 0 and var_52_1 < var_52_7 then
					arg_49_1.talkMaxDuration = var_52_7

					if var_52_7 + var_52_0 > arg_49_1.duration_ then
						arg_49_1.duration_ = var_52_7 + var_52_0
					end
				end

				arg_49_1.text_.text = var_52_4
				arg_49_1.typewritter.percent = 0

				arg_49_1.typewritter:SetDirty()
				arg_49_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_114251", "114251012", "story_v_out_114251.awb") ~= 0 then
					local var_52_8 = manager.audio:GetVoiceLength("story_v_out_114251", "114251012", "story_v_out_114251.awb") / 1000

					if var_52_8 + var_52_0 > arg_49_1.duration_ then
						arg_49_1.duration_ = var_52_8 + var_52_0
					end

					if var_52_3.prefab_name ~= "" and arg_49_1.actors_[var_52_3.prefab_name] ~= nil then
						local var_52_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_49_1.actors_[var_52_3.prefab_name].transform, "story_v_out_114251", "114251012", "story_v_out_114251.awb")

						arg_49_1:RecordAudio("114251012", var_52_9)
						arg_49_1:RecordAudio("114251012", var_52_9)
					else
						arg_49_1:AudioAction("play", "voice", "story_v_out_114251", "114251012", "story_v_out_114251.awb")
					end

					arg_49_1:RecordHistoryTalkVoice("story_v_out_114251", "114251012", "story_v_out_114251.awb")
				end

				arg_49_1:RecordContent(arg_49_1.text_.text)
			end

			local var_52_10 = math.max(var_52_1, arg_49_1.talkMaxDuration)

			if var_52_0 <= arg_49_1.time_ and arg_49_1.time_ < var_52_0 + var_52_10 then
				arg_49_1.typewritter.percent = (arg_49_1.time_ - var_52_0) / var_52_10

				arg_49_1.typewritter:SetDirty()
			end

			if arg_49_1.time_ >= var_52_0 + var_52_10 and arg_49_1.time_ < var_52_0 + var_52_10 + arg_52_0 then
				arg_49_1.typewritter.percent = 1

				arg_49_1.typewritter:SetDirty()
				arg_49_1:ShowNextGo(true)
			end
		end

		arg_49_1.nodeConfigList_ = {}

		arg_49_1:InitPlayNodeList()
	end,
	Play114251013 = function(arg_53_0, arg_53_1)
		arg_53_1.time_ = 0
		arg_53_1.frameCnt_ = 0
		arg_53_1.state_ = "playing"
		arg_53_1.curTalkId_ = 114251013
		arg_53_1.duration_ = 4.57

		local var_53_0 = {
			ja = 4.166,
			ko = 4.5,
			zh = 4.3,
			en = 4.566
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
				arg_53_0:Play114251014(arg_53_1)
			end
		end

		function arg_53_1.onSingleLineUpdate_(arg_56_0)
			local var_56_0 = 0
			local var_56_1 = 0.45

			if var_56_0 < arg_53_1.time_ and arg_53_1.time_ <= var_56_0 + arg_56_0 then
				arg_53_1.talkMaxDuration = 0
				arg_53_1.dialogCg_.alpha = 1

				arg_53_1.dialog_:SetActive(true)
				SetActive(arg_53_1.leftNameGo_, true)

				local var_56_2 = arg_53_1:FormatText(StoryNameCfg[225].name)

				arg_53_1.leftNameTxt_.text = var_56_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_53_1.leftNameTxt_.transform)

				arg_53_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_53_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_53_1:RecordName(arg_53_1.leftNameTxt_.text)
				SetActive(arg_53_1.iconTrs_.gameObject, true)
				arg_53_1.iconController_:SetSelectedState("hero")

				arg_53_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_10005")

				arg_53_1.callingController_:SetSelectedState("normal")

				arg_53_1.keyicon_.color = Color.New(1, 1, 1)
				arg_53_1.icon_.color = Color.New(1, 1, 1)

				local var_56_3 = arg_53_1:GetWordFromCfg(114251013)
				local var_56_4 = arg_53_1:FormatText(var_56_3.content)

				arg_53_1.text_.text = var_56_4

				LuaForUtil.ClearLinePrefixSymbol(arg_53_1.text_)

				local var_56_5 = 18
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

				if manager.audio:GetVoiceLength("story_v_out_114251", "114251013", "story_v_out_114251.awb") ~= 0 then
					local var_56_8 = manager.audio:GetVoiceLength("story_v_out_114251", "114251013", "story_v_out_114251.awb") / 1000

					if var_56_8 + var_56_0 > arg_53_1.duration_ then
						arg_53_1.duration_ = var_56_8 + var_56_0
					end

					if var_56_3.prefab_name ~= "" and arg_53_1.actors_[var_56_3.prefab_name] ~= nil then
						local var_56_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_53_1.actors_[var_56_3.prefab_name].transform, "story_v_out_114251", "114251013", "story_v_out_114251.awb")

						arg_53_1:RecordAudio("114251013", var_56_9)
						arg_53_1:RecordAudio("114251013", var_56_9)
					else
						arg_53_1:AudioAction("play", "voice", "story_v_out_114251", "114251013", "story_v_out_114251.awb")
					end

					arg_53_1:RecordHistoryTalkVoice("story_v_out_114251", "114251013", "story_v_out_114251.awb")
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
	Play114251014 = function(arg_57_0, arg_57_1)
		arg_57_1.time_ = 0
		arg_57_1.frameCnt_ = 0
		arg_57_1.state_ = "playing"
		arg_57_1.curTalkId_ = 114251014
		arg_57_1.duration_ = 5

		SetActive(arg_57_1.tipsGo_, false)

		function arg_57_1.onSingleLineFinish_()
			arg_57_1.onSingleLineUpdate_ = nil
			arg_57_1.onSingleLineFinish_ = nil
			arg_57_1.state_ = "waiting"
		end

		function arg_57_1.playNext_(arg_59_0)
			if arg_59_0 == 1 then
				arg_57_0:Play114251015(arg_57_1)
			end
		end

		function arg_57_1.onSingleLineUpdate_(arg_60_0)
			local var_60_0 = manager.ui.mainCamera.transform
			local var_60_1 = 0

			if var_60_1 < arg_57_1.time_ and arg_57_1.time_ <= var_60_1 + arg_60_0 then
				arg_57_1.var_.shakeOldPos = var_60_0.localPosition
			end

			local var_60_2 = 0.6

			if var_60_1 <= arg_57_1.time_ and arg_57_1.time_ < var_60_1 + var_60_2 then
				local var_60_3 = (arg_57_1.time_ - var_60_1) / 0.066
				local var_60_4, var_60_5 = math.modf(var_60_3)

				var_60_0.localPosition = Vector3.New(var_60_5 * 0.13, var_60_5 * 0.13, var_60_5 * 0.13) + arg_57_1.var_.shakeOldPos
			end

			if arg_57_1.time_ >= var_60_1 + var_60_2 and arg_57_1.time_ < var_60_1 + var_60_2 + arg_60_0 then
				var_60_0.localPosition = arg_57_1.var_.shakeOldPos
			end

			local var_60_6 = 0

			if var_60_6 < arg_57_1.time_ and arg_57_1.time_ <= var_60_6 + arg_60_0 then
				arg_57_1.allBtn_.enabled = false
			end

			local var_60_7 = 0.6

			if arg_57_1.time_ >= var_60_6 + var_60_7 and arg_57_1.time_ < var_60_6 + var_60_7 + arg_60_0 then
				arg_57_1.allBtn_.enabled = true
			end

			local var_60_8 = 0
			local var_60_9 = 1.3

			if var_60_8 < arg_57_1.time_ and arg_57_1.time_ <= var_60_8 + arg_60_0 then
				arg_57_1.talkMaxDuration = 0
				arg_57_1.dialogCg_.alpha = 1

				arg_57_1.dialog_:SetActive(true)
				SetActive(arg_57_1.leftNameGo_, false)

				arg_57_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_57_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_57_1:RecordName(arg_57_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_57_1.iconTrs_.gameObject, false)
				arg_57_1.callingController_:SetSelectedState("normal")

				local var_60_10 = arg_57_1:GetWordFromCfg(114251014)
				local var_60_11 = arg_57_1:FormatText(var_60_10.content)

				arg_57_1.text_.text = var_60_11

				LuaForUtil.ClearLinePrefixSymbol(arg_57_1.text_)

				local var_60_12 = 51
				local var_60_13 = utf8.len(var_60_11)
				local var_60_14 = var_60_12 <= 0 and var_60_9 or var_60_9 * (var_60_13 / var_60_12)

				if var_60_14 > 0 and var_60_9 < var_60_14 then
					arg_57_1.talkMaxDuration = var_60_14

					if var_60_14 + var_60_8 > arg_57_1.duration_ then
						arg_57_1.duration_ = var_60_14 + var_60_8
					end
				end

				arg_57_1.text_.text = var_60_11
				arg_57_1.typewritter.percent = 0

				arg_57_1.typewritter:SetDirty()
				arg_57_1:ShowNextGo(false)
				arg_57_1:RecordContent(arg_57_1.text_.text)
			end

			local var_60_15 = math.max(var_60_9, arg_57_1.talkMaxDuration)

			if var_60_8 <= arg_57_1.time_ and arg_57_1.time_ < var_60_8 + var_60_15 then
				arg_57_1.typewritter.percent = (arg_57_1.time_ - var_60_8) / var_60_15

				arg_57_1.typewritter:SetDirty()
			end

			if arg_57_1.time_ >= var_60_8 + var_60_15 and arg_57_1.time_ < var_60_8 + var_60_15 + arg_60_0 then
				arg_57_1.typewritter.percent = 1

				arg_57_1.typewritter:SetDirty()
				arg_57_1:ShowNextGo(true)
			end
		end

		arg_57_1.nodeConfigList_ = {}

		arg_57_1:InitPlayNodeList()
	end,
	Play114251015 = function(arg_61_0, arg_61_1)
		arg_61_1.time_ = 0
		arg_61_1.frameCnt_ = 0
		arg_61_1.state_ = "playing"
		arg_61_1.curTalkId_ = 114251015
		arg_61_1.duration_ = 7.17

		local var_61_0 = {
			ja = 7.166,
			ko = 3.533,
			zh = 3.733,
			en = 3.266
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
				arg_61_0:Play114251016(arg_61_1)
			end
		end

		function arg_61_1.onSingleLineUpdate_(arg_64_0)
			local var_64_0 = arg_61_1.actors_["10018"].transform
			local var_64_1 = 0

			if var_64_1 < arg_61_1.time_ and arg_61_1.time_ <= var_64_1 + arg_64_0 then
				arg_61_1.var_.moveOldPos10018 = var_64_0.localPosition
				var_64_0.localScale = Vector3.New(1, 1, 1)

				arg_61_1:CheckSpriteTmpPos("10018", 2)

				local var_64_2 = var_64_0.childCount

				for iter_64_0 = 0, var_64_2 - 1 do
					local var_64_3 = var_64_0:GetChild(iter_64_0)

					if var_64_3.name == "split_1" or not string.find(var_64_3.name, "split") then
						var_64_3.gameObject:SetActive(true)
					else
						var_64_3.gameObject:SetActive(false)
					end
				end
			end

			local var_64_4 = 0.001

			if var_64_1 <= arg_61_1.time_ and arg_61_1.time_ < var_64_1 + var_64_4 then
				local var_64_5 = (arg_61_1.time_ - var_64_1) / var_64_4
				local var_64_6 = Vector3.New(-390, -350, -180)

				var_64_0.localPosition = Vector3.Lerp(arg_61_1.var_.moveOldPos10018, var_64_6, var_64_5)
			end

			if arg_61_1.time_ >= var_64_1 + var_64_4 and arg_61_1.time_ < var_64_1 + var_64_4 + arg_64_0 then
				var_64_0.localPosition = Vector3.New(-390, -350, -180)
			end

			local var_64_7 = arg_61_1.actors_["10015"].transform
			local var_64_8 = 0

			if var_64_8 < arg_61_1.time_ and arg_61_1.time_ <= var_64_8 + arg_64_0 then
				arg_61_1.var_.moveOldPos10015 = var_64_7.localPosition
				var_64_7.localScale = Vector3.New(1, 1, 1)

				arg_61_1:CheckSpriteTmpPos("10015", 4)

				local var_64_9 = var_64_7.childCount

				for iter_64_1 = 0, var_64_9 - 1 do
					local var_64_10 = var_64_7:GetChild(iter_64_1)

					if var_64_10.name == "split_1" or not string.find(var_64_10.name, "split") then
						var_64_10.gameObject:SetActive(true)
					else
						var_64_10.gameObject:SetActive(false)
					end
				end
			end

			local var_64_11 = 0.001

			if var_64_8 <= arg_61_1.time_ and arg_61_1.time_ < var_64_8 + var_64_11 then
				local var_64_12 = (arg_61_1.time_ - var_64_8) / var_64_11
				local var_64_13 = Vector3.New(390, -350, -180)

				var_64_7.localPosition = Vector3.Lerp(arg_61_1.var_.moveOldPos10015, var_64_13, var_64_12)
			end

			if arg_61_1.time_ >= var_64_8 + var_64_11 and arg_61_1.time_ < var_64_8 + var_64_11 + arg_64_0 then
				var_64_7.localPosition = Vector3.New(390, -350, -180)
			end

			local var_64_14 = arg_61_1.actors_["10018"]
			local var_64_15 = 0

			if var_64_15 < arg_61_1.time_ and arg_61_1.time_ <= var_64_15 + arg_64_0 and not isNil(var_64_14) and arg_61_1.var_.actorSpriteComps10018 == nil then
				arg_61_1.var_.actorSpriteComps10018 = var_64_14:GetComponentsInChildren(typeof(Image), true)
			end

			local var_64_16 = 0.034

			if var_64_15 <= arg_61_1.time_ and arg_61_1.time_ < var_64_15 + var_64_16 and not isNil(var_64_14) then
				local var_64_17 = (arg_61_1.time_ - var_64_15) / var_64_16

				if arg_61_1.var_.actorSpriteComps10018 then
					for iter_64_2, iter_64_3 in pairs(arg_61_1.var_.actorSpriteComps10018:ToTable()) do
						if iter_64_3 then
							if arg_61_1.isInRecall_ then
								local var_64_18 = Mathf.Lerp(iter_64_3.color.r, arg_61_1.hightColor1.r, var_64_17)
								local var_64_19 = Mathf.Lerp(iter_64_3.color.g, arg_61_1.hightColor1.g, var_64_17)
								local var_64_20 = Mathf.Lerp(iter_64_3.color.b, arg_61_1.hightColor1.b, var_64_17)

								iter_64_3.color = Color.New(var_64_18, var_64_19, var_64_20)
							else
								local var_64_21 = Mathf.Lerp(iter_64_3.color.r, 1, var_64_17)

								iter_64_3.color = Color.New(var_64_21, var_64_21, var_64_21)
							end
						end
					end
				end
			end

			if arg_61_1.time_ >= var_64_15 + var_64_16 and arg_61_1.time_ < var_64_15 + var_64_16 + arg_64_0 and not isNil(var_64_14) and arg_61_1.var_.actorSpriteComps10018 then
				for iter_64_4, iter_64_5 in pairs(arg_61_1.var_.actorSpriteComps10018:ToTable()) do
					if iter_64_5 then
						if arg_61_1.isInRecall_ then
							iter_64_5.color = arg_61_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_64_5.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_61_1.var_.actorSpriteComps10018 = nil
			end

			local var_64_22 = arg_61_1.actors_["10015"]
			local var_64_23 = 0

			if var_64_23 < arg_61_1.time_ and arg_61_1.time_ <= var_64_23 + arg_64_0 and not isNil(var_64_22) and arg_61_1.var_.actorSpriteComps10015 == nil then
				arg_61_1.var_.actorSpriteComps10015 = var_64_22:GetComponentsInChildren(typeof(Image), true)
			end

			local var_64_24 = 0.034

			if var_64_23 <= arg_61_1.time_ and arg_61_1.time_ < var_64_23 + var_64_24 and not isNil(var_64_22) then
				local var_64_25 = (arg_61_1.time_ - var_64_23) / var_64_24

				if arg_61_1.var_.actorSpriteComps10015 then
					for iter_64_6, iter_64_7 in pairs(arg_61_1.var_.actorSpriteComps10015:ToTable()) do
						if iter_64_7 then
							if arg_61_1.isInRecall_ then
								local var_64_26 = Mathf.Lerp(iter_64_7.color.r, arg_61_1.hightColor2.r, var_64_25)
								local var_64_27 = Mathf.Lerp(iter_64_7.color.g, arg_61_1.hightColor2.g, var_64_25)
								local var_64_28 = Mathf.Lerp(iter_64_7.color.b, arg_61_1.hightColor2.b, var_64_25)

								iter_64_7.color = Color.New(var_64_26, var_64_27, var_64_28)
							else
								local var_64_29 = Mathf.Lerp(iter_64_7.color.r, 0.5, var_64_25)

								iter_64_7.color = Color.New(var_64_29, var_64_29, var_64_29)
							end
						end
					end
				end
			end

			if arg_61_1.time_ >= var_64_23 + var_64_24 and arg_61_1.time_ < var_64_23 + var_64_24 + arg_64_0 and not isNil(var_64_22) and arg_61_1.var_.actorSpriteComps10015 then
				for iter_64_8, iter_64_9 in pairs(arg_61_1.var_.actorSpriteComps10015:ToTable()) do
					if iter_64_9 then
						if arg_61_1.isInRecall_ then
							iter_64_9.color = arg_61_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_64_9.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_61_1.var_.actorSpriteComps10015 = nil
			end

			local var_64_30 = arg_61_1.actors_["10018"]
			local var_64_31 = 0

			if var_64_31 < arg_61_1.time_ and arg_61_1.time_ <= var_64_31 + arg_64_0 then
				local var_64_32 = var_64_30:GetComponentInChildren(typeof(CanvasGroup))

				if var_64_32 then
					arg_61_1.var_.alphaOldValue10018 = var_64_32.alpha
					arg_61_1.var_.characterEffect10018 = var_64_32
				end

				arg_61_1.var_.alphaOldValue10018 = 0
			end

			local var_64_33 = 0.5

			if var_64_31 <= arg_61_1.time_ and arg_61_1.time_ < var_64_31 + var_64_33 then
				local var_64_34 = (arg_61_1.time_ - var_64_31) / var_64_33
				local var_64_35 = Mathf.Lerp(arg_61_1.var_.alphaOldValue10018, 1, var_64_34)

				if arg_61_1.var_.characterEffect10018 then
					arg_61_1.var_.characterEffect10018.alpha = var_64_35
				end
			end

			if arg_61_1.time_ >= var_64_31 + var_64_33 and arg_61_1.time_ < var_64_31 + var_64_33 + arg_64_0 and arg_61_1.var_.characterEffect10018 then
				arg_61_1.var_.characterEffect10018.alpha = 1
			end

			local var_64_36 = arg_61_1.actors_["10015"]
			local var_64_37 = 0

			if var_64_37 < arg_61_1.time_ and arg_61_1.time_ <= var_64_37 + arg_64_0 then
				local var_64_38 = var_64_36:GetComponentInChildren(typeof(CanvasGroup))

				if var_64_38 then
					arg_61_1.var_.alphaOldValue10015 = var_64_38.alpha
					arg_61_1.var_.characterEffect10015 = var_64_38
				end

				arg_61_1.var_.alphaOldValue10015 = 0
			end

			local var_64_39 = 0.5

			if var_64_37 <= arg_61_1.time_ and arg_61_1.time_ < var_64_37 + var_64_39 then
				local var_64_40 = (arg_61_1.time_ - var_64_37) / var_64_39
				local var_64_41 = Mathf.Lerp(arg_61_1.var_.alphaOldValue10015, 1, var_64_40)

				if arg_61_1.var_.characterEffect10015 then
					arg_61_1.var_.characterEffect10015.alpha = var_64_41
				end
			end

			if arg_61_1.time_ >= var_64_37 + var_64_39 and arg_61_1.time_ < var_64_37 + var_64_39 + arg_64_0 and arg_61_1.var_.characterEffect10015 then
				arg_61_1.var_.characterEffect10015.alpha = 1
			end

			local var_64_42 = 0
			local var_64_43 = 0.4

			if var_64_42 < arg_61_1.time_ and arg_61_1.time_ <= var_64_42 + arg_64_0 then
				arg_61_1.talkMaxDuration = 0
				arg_61_1.dialogCg_.alpha = 1

				arg_61_1.dialog_:SetActive(true)
				SetActive(arg_61_1.leftNameGo_, true)

				local var_64_44 = arg_61_1:FormatText(StoryNameCfg[257].name)

				arg_61_1.leftNameTxt_.text = var_64_44

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_61_1.leftNameTxt_.transform)

				arg_61_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_61_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_61_1:RecordName(arg_61_1.leftNameTxt_.text)
				SetActive(arg_61_1.iconTrs_.gameObject, false)
				arg_61_1.callingController_:SetSelectedState("normal")

				local var_64_45 = arg_61_1:GetWordFromCfg(114251015)
				local var_64_46 = arg_61_1:FormatText(var_64_45.content)

				arg_61_1.text_.text = var_64_46

				LuaForUtil.ClearLinePrefixSymbol(arg_61_1.text_)

				local var_64_47 = 16
				local var_64_48 = utf8.len(var_64_46)
				local var_64_49 = var_64_47 <= 0 and var_64_43 or var_64_43 * (var_64_48 / var_64_47)

				if var_64_49 > 0 and var_64_43 < var_64_49 then
					arg_61_1.talkMaxDuration = var_64_49

					if var_64_49 + var_64_42 > arg_61_1.duration_ then
						arg_61_1.duration_ = var_64_49 + var_64_42
					end
				end

				arg_61_1.text_.text = var_64_46
				arg_61_1.typewritter.percent = 0

				arg_61_1.typewritter:SetDirty()
				arg_61_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_114251", "114251015", "story_v_out_114251.awb") ~= 0 then
					local var_64_50 = manager.audio:GetVoiceLength("story_v_out_114251", "114251015", "story_v_out_114251.awb") / 1000

					if var_64_50 + var_64_42 > arg_61_1.duration_ then
						arg_61_1.duration_ = var_64_50 + var_64_42
					end

					if var_64_45.prefab_name ~= "" and arg_61_1.actors_[var_64_45.prefab_name] ~= nil then
						local var_64_51 = LuaForUtil.PlayVoiceWithCriLipsync(arg_61_1.actors_[var_64_45.prefab_name].transform, "story_v_out_114251", "114251015", "story_v_out_114251.awb")

						arg_61_1:RecordAudio("114251015", var_64_51)
						arg_61_1:RecordAudio("114251015", var_64_51)
					else
						arg_61_1:AudioAction("play", "voice", "story_v_out_114251", "114251015", "story_v_out_114251.awb")
					end

					arg_61_1:RecordHistoryTalkVoice("story_v_out_114251", "114251015", "story_v_out_114251.awb")
				end

				arg_61_1:RecordContent(arg_61_1.text_.text)
			end

			local var_64_52 = math.max(var_64_43, arg_61_1.talkMaxDuration)

			if var_64_42 <= arg_61_1.time_ and arg_61_1.time_ < var_64_42 + var_64_52 then
				arg_61_1.typewritter.percent = (arg_61_1.time_ - var_64_42) / var_64_52

				arg_61_1.typewritter:SetDirty()
			end

			if arg_61_1.time_ >= var_64_42 + var_64_52 and arg_61_1.time_ < var_64_42 + var_64_52 + arg_64_0 then
				arg_61_1.typewritter.percent = 1

				arg_61_1.typewritter:SetDirty()
				arg_61_1:ShowNextGo(true)
			end
		end

		arg_61_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10018",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			},
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

		arg_61_1:InitPlayNodeList()
	end,
	Play114251016 = function(arg_65_0, arg_65_1)
		arg_65_1.time_ = 0
		arg_65_1.frameCnt_ = 0
		arg_65_1.state_ = "playing"
		arg_65_1.curTalkId_ = 114251016
		arg_65_1.duration_ = 8.87

		local var_65_0 = {
			ja = 4.2,
			ko = 8.866,
			zh = 7.9,
			en = 5.233
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
				arg_65_0:Play114251017(arg_65_1)
			end
		end

		function arg_65_1.onSingleLineUpdate_(arg_68_0)
			local var_68_0 = arg_65_1.actors_["10015"].transform
			local var_68_1 = 0

			if var_68_1 < arg_65_1.time_ and arg_65_1.time_ <= var_68_1 + arg_68_0 then
				arg_65_1.var_.moveOldPos10015 = var_68_0.localPosition
				var_68_0.localScale = Vector3.New(1, 1, 1)

				arg_65_1:CheckSpriteTmpPos("10015", 4)

				local var_68_2 = var_68_0.childCount

				for iter_68_0 = 0, var_68_2 - 1 do
					local var_68_3 = var_68_0:GetChild(iter_68_0)

					if var_68_3.name == "split_1" or not string.find(var_68_3.name, "split") then
						var_68_3.gameObject:SetActive(true)
					else
						var_68_3.gameObject:SetActive(false)
					end
				end
			end

			local var_68_4 = 0.001

			if var_68_1 <= arg_65_1.time_ and arg_65_1.time_ < var_68_1 + var_68_4 then
				local var_68_5 = (arg_65_1.time_ - var_68_1) / var_68_4
				local var_68_6 = Vector3.New(390, -350, -180)

				var_68_0.localPosition = Vector3.Lerp(arg_65_1.var_.moveOldPos10015, var_68_6, var_68_5)
			end

			if arg_65_1.time_ >= var_68_1 + var_68_4 and arg_65_1.time_ < var_68_1 + var_68_4 + arg_68_0 then
				var_68_0.localPosition = Vector3.New(390, -350, -180)
			end

			local var_68_7 = arg_65_1.actors_["10018"]
			local var_68_8 = 0

			if var_68_8 < arg_65_1.time_ and arg_65_1.time_ <= var_68_8 + arg_68_0 and not isNil(var_68_7) and arg_65_1.var_.actorSpriteComps10018 == nil then
				arg_65_1.var_.actorSpriteComps10018 = var_68_7:GetComponentsInChildren(typeof(Image), true)
			end

			local var_68_9 = 0.034

			if var_68_8 <= arg_65_1.time_ and arg_65_1.time_ < var_68_8 + var_68_9 and not isNil(var_68_7) then
				local var_68_10 = (arg_65_1.time_ - var_68_8) / var_68_9

				if arg_65_1.var_.actorSpriteComps10018 then
					for iter_68_1, iter_68_2 in pairs(arg_65_1.var_.actorSpriteComps10018:ToTable()) do
						if iter_68_2 then
							if arg_65_1.isInRecall_ then
								local var_68_11 = Mathf.Lerp(iter_68_2.color.r, arg_65_1.hightColor2.r, var_68_10)
								local var_68_12 = Mathf.Lerp(iter_68_2.color.g, arg_65_1.hightColor2.g, var_68_10)
								local var_68_13 = Mathf.Lerp(iter_68_2.color.b, arg_65_1.hightColor2.b, var_68_10)

								iter_68_2.color = Color.New(var_68_11, var_68_12, var_68_13)
							else
								local var_68_14 = Mathf.Lerp(iter_68_2.color.r, 0.5, var_68_10)

								iter_68_2.color = Color.New(var_68_14, var_68_14, var_68_14)
							end
						end
					end
				end
			end

			if arg_65_1.time_ >= var_68_8 + var_68_9 and arg_65_1.time_ < var_68_8 + var_68_9 + arg_68_0 and not isNil(var_68_7) and arg_65_1.var_.actorSpriteComps10018 then
				for iter_68_3, iter_68_4 in pairs(arg_65_1.var_.actorSpriteComps10018:ToTable()) do
					if iter_68_4 then
						if arg_65_1.isInRecall_ then
							iter_68_4.color = arg_65_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_68_4.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_65_1.var_.actorSpriteComps10018 = nil
			end

			local var_68_15 = arg_65_1.actors_["10015"]
			local var_68_16 = 0

			if var_68_16 < arg_65_1.time_ and arg_65_1.time_ <= var_68_16 + arg_68_0 and not isNil(var_68_15) and arg_65_1.var_.actorSpriteComps10015 == nil then
				arg_65_1.var_.actorSpriteComps10015 = var_68_15:GetComponentsInChildren(typeof(Image), true)
			end

			local var_68_17 = 0.034

			if var_68_16 <= arg_65_1.time_ and arg_65_1.time_ < var_68_16 + var_68_17 and not isNil(var_68_15) then
				local var_68_18 = (arg_65_1.time_ - var_68_16) / var_68_17

				if arg_65_1.var_.actorSpriteComps10015 then
					for iter_68_5, iter_68_6 in pairs(arg_65_1.var_.actorSpriteComps10015:ToTable()) do
						if iter_68_6 then
							if arg_65_1.isInRecall_ then
								local var_68_19 = Mathf.Lerp(iter_68_6.color.r, arg_65_1.hightColor1.r, var_68_18)
								local var_68_20 = Mathf.Lerp(iter_68_6.color.g, arg_65_1.hightColor1.g, var_68_18)
								local var_68_21 = Mathf.Lerp(iter_68_6.color.b, arg_65_1.hightColor1.b, var_68_18)

								iter_68_6.color = Color.New(var_68_19, var_68_20, var_68_21)
							else
								local var_68_22 = Mathf.Lerp(iter_68_6.color.r, 1, var_68_18)

								iter_68_6.color = Color.New(var_68_22, var_68_22, var_68_22)
							end
						end
					end
				end
			end

			if arg_65_1.time_ >= var_68_16 + var_68_17 and arg_65_1.time_ < var_68_16 + var_68_17 + arg_68_0 and not isNil(var_68_15) and arg_65_1.var_.actorSpriteComps10015 then
				for iter_68_7, iter_68_8 in pairs(arg_65_1.var_.actorSpriteComps10015:ToTable()) do
					if iter_68_8 then
						if arg_65_1.isInRecall_ then
							iter_68_8.color = arg_65_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_68_8.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_65_1.var_.actorSpriteComps10015 = nil
			end

			local var_68_23 = 0
			local var_68_24 = 0.725

			if var_68_23 < arg_65_1.time_ and arg_65_1.time_ <= var_68_23 + arg_68_0 then
				arg_65_1.talkMaxDuration = 0
				arg_65_1.dialogCg_.alpha = 1

				arg_65_1.dialog_:SetActive(true)
				SetActive(arg_65_1.leftNameGo_, true)

				local var_68_25 = arg_65_1:FormatText(StoryNameCfg[208].name)

				arg_65_1.leftNameTxt_.text = var_68_25

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_65_1.leftNameTxt_.transform)

				arg_65_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_65_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_65_1:RecordName(arg_65_1.leftNameTxt_.text)
				SetActive(arg_65_1.iconTrs_.gameObject, false)
				arg_65_1.callingController_:SetSelectedState("normal")

				local var_68_26 = arg_65_1:GetWordFromCfg(114251016)
				local var_68_27 = arg_65_1:FormatText(var_68_26.content)

				arg_65_1.text_.text = var_68_27

				LuaForUtil.ClearLinePrefixSymbol(arg_65_1.text_)

				local var_68_28 = 29
				local var_68_29 = utf8.len(var_68_27)
				local var_68_30 = var_68_28 <= 0 and var_68_24 or var_68_24 * (var_68_29 / var_68_28)

				if var_68_30 > 0 and var_68_24 < var_68_30 then
					arg_65_1.talkMaxDuration = var_68_30

					if var_68_30 + var_68_23 > arg_65_1.duration_ then
						arg_65_1.duration_ = var_68_30 + var_68_23
					end
				end

				arg_65_1.text_.text = var_68_27
				arg_65_1.typewritter.percent = 0

				arg_65_1.typewritter:SetDirty()
				arg_65_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_114251", "114251016", "story_v_out_114251.awb") ~= 0 then
					local var_68_31 = manager.audio:GetVoiceLength("story_v_out_114251", "114251016", "story_v_out_114251.awb") / 1000

					if var_68_31 + var_68_23 > arg_65_1.duration_ then
						arg_65_1.duration_ = var_68_31 + var_68_23
					end

					if var_68_26.prefab_name ~= "" and arg_65_1.actors_[var_68_26.prefab_name] ~= nil then
						local var_68_32 = LuaForUtil.PlayVoiceWithCriLipsync(arg_65_1.actors_[var_68_26.prefab_name].transform, "story_v_out_114251", "114251016", "story_v_out_114251.awb")

						arg_65_1:RecordAudio("114251016", var_68_32)
						arg_65_1:RecordAudio("114251016", var_68_32)
					else
						arg_65_1:AudioAction("play", "voice", "story_v_out_114251", "114251016", "story_v_out_114251.awb")
					end

					arg_65_1:RecordHistoryTalkVoice("story_v_out_114251", "114251016", "story_v_out_114251.awb")
				end

				arg_65_1:RecordContent(arg_65_1.text_.text)
			end

			local var_68_33 = math.max(var_68_24, arg_65_1.talkMaxDuration)

			if var_68_23 <= arg_65_1.time_ and arg_65_1.time_ < var_68_23 + var_68_33 then
				arg_65_1.typewritter.percent = (arg_65_1.time_ - var_68_23) / var_68_33

				arg_65_1.typewritter:SetDirty()
			end

			if arg_65_1.time_ >= var_68_23 + var_68_33 and arg_65_1.time_ < var_68_23 + var_68_33 + arg_68_0 then
				arg_65_1.typewritter.percent = 1

				arg_65_1.typewritter:SetDirty()
				arg_65_1:ShowNextGo(true)
			end
		end

		arg_65_1.nodeConfigList_ = {
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

		arg_65_1:InitPlayNodeList()
	end,
	Play114251017 = function(arg_69_0, arg_69_1)
		arg_69_1.time_ = 0
		arg_69_1.frameCnt_ = 0
		arg_69_1.state_ = "playing"
		arg_69_1.curTalkId_ = 114251017
		arg_69_1.duration_ = 5

		SetActive(arg_69_1.tipsGo_, false)

		function arg_69_1.onSingleLineFinish_()
			arg_69_1.onSingleLineUpdate_ = nil
			arg_69_1.onSingleLineFinish_ = nil
			arg_69_1.state_ = "waiting"
		end

		function arg_69_1.playNext_(arg_71_0)
			if arg_71_0 == 1 then
				arg_69_0:Play114251018(arg_69_1)
			end
		end

		function arg_69_1.onSingleLineUpdate_(arg_72_0)
			local var_72_0 = arg_69_1.actors_["10015"]
			local var_72_1 = 0

			if var_72_1 < arg_69_1.time_ and arg_69_1.time_ <= var_72_1 + arg_72_0 then
				local var_72_2 = var_72_0:GetComponentInChildren(typeof(CanvasGroup))

				if var_72_2 then
					arg_69_1.var_.alphaOldValue10015 = var_72_2.alpha
					arg_69_1.var_.characterEffect10015 = var_72_2
				end

				arg_69_1.var_.alphaOldValue10015 = 1
			end

			local var_72_3 = 0.5

			if var_72_1 <= arg_69_1.time_ and arg_69_1.time_ < var_72_1 + var_72_3 then
				local var_72_4 = (arg_69_1.time_ - var_72_1) / var_72_3
				local var_72_5 = Mathf.Lerp(arg_69_1.var_.alphaOldValue10015, 0, var_72_4)

				if arg_69_1.var_.characterEffect10015 then
					arg_69_1.var_.characterEffect10015.alpha = var_72_5
				end
			end

			if arg_69_1.time_ >= var_72_1 + var_72_3 and arg_69_1.time_ < var_72_1 + var_72_3 + arg_72_0 and arg_69_1.var_.characterEffect10015 then
				arg_69_1.var_.characterEffect10015.alpha = 0
			end

			local var_72_6 = arg_69_1.actors_["10018"]
			local var_72_7 = 0

			if var_72_7 < arg_69_1.time_ and arg_69_1.time_ <= var_72_7 + arg_72_0 then
				local var_72_8 = var_72_6:GetComponentInChildren(typeof(CanvasGroup))

				if var_72_8 then
					arg_69_1.var_.alphaOldValue10018 = var_72_8.alpha
					arg_69_1.var_.characterEffect10018 = var_72_8
				end

				arg_69_1.var_.alphaOldValue10018 = 1
			end

			local var_72_9 = 0.5

			if var_72_7 <= arg_69_1.time_ and arg_69_1.time_ < var_72_7 + var_72_9 then
				local var_72_10 = (arg_69_1.time_ - var_72_7) / var_72_9
				local var_72_11 = Mathf.Lerp(arg_69_1.var_.alphaOldValue10018, 0, var_72_10)

				if arg_69_1.var_.characterEffect10018 then
					arg_69_1.var_.characterEffect10018.alpha = var_72_11
				end
			end

			if arg_69_1.time_ >= var_72_7 + var_72_9 and arg_69_1.time_ < var_72_7 + var_72_9 + arg_72_0 and arg_69_1.var_.characterEffect10018 then
				arg_69_1.var_.characterEffect10018.alpha = 0
			end

			local var_72_12 = 0
			local var_72_13 = 1.625

			if var_72_12 < arg_69_1.time_ and arg_69_1.time_ <= var_72_12 + arg_72_0 then
				arg_69_1.talkMaxDuration = 0
				arg_69_1.dialogCg_.alpha = 1

				arg_69_1.dialog_:SetActive(true)
				SetActive(arg_69_1.leftNameGo_, false)

				arg_69_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_69_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_69_1:RecordName(arg_69_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_69_1.iconTrs_.gameObject, false)
				arg_69_1.callingController_:SetSelectedState("normal")

				local var_72_14 = arg_69_1:GetWordFromCfg(114251017)
				local var_72_15 = arg_69_1:FormatText(var_72_14.content)

				arg_69_1.text_.text = var_72_15

				LuaForUtil.ClearLinePrefixSymbol(arg_69_1.text_)

				local var_72_16 = 64
				local var_72_17 = utf8.len(var_72_15)
				local var_72_18 = var_72_16 <= 0 and var_72_13 or var_72_13 * (var_72_17 / var_72_16)

				if var_72_18 > 0 and var_72_13 < var_72_18 then
					arg_69_1.talkMaxDuration = var_72_18

					if var_72_18 + var_72_12 > arg_69_1.duration_ then
						arg_69_1.duration_ = var_72_18 + var_72_12
					end
				end

				arg_69_1.text_.text = var_72_15
				arg_69_1.typewritter.percent = 0

				arg_69_1.typewritter:SetDirty()
				arg_69_1:ShowNextGo(false)
				arg_69_1:RecordContent(arg_69_1.text_.text)
			end

			local var_72_19 = math.max(var_72_13, arg_69_1.talkMaxDuration)

			if var_72_12 <= arg_69_1.time_ and arg_69_1.time_ < var_72_12 + var_72_19 then
				arg_69_1.typewritter.percent = (arg_69_1.time_ - var_72_12) / var_72_19

				arg_69_1.typewritter:SetDirty()
			end

			if arg_69_1.time_ >= var_72_12 + var_72_19 and arg_69_1.time_ < var_72_12 + var_72_19 + arg_72_0 then
				arg_69_1.typewritter.percent = 1

				arg_69_1.typewritter:SetDirty()
				arg_69_1:ShowNextGo(true)
			end
		end

		arg_69_1.nodeConfigList_ = {}

		arg_69_1:InitPlayNodeList()
	end,
	Play114251018 = function(arg_73_0, arg_73_1)
		arg_73_1.time_ = 0
		arg_73_1.frameCnt_ = 0
		arg_73_1.state_ = "playing"
		arg_73_1.curTalkId_ = 114251018
		arg_73_1.duration_ = 3.8

		local var_73_0 = {
			ja = 3.8,
			ko = 2.1,
			zh = 3.1,
			en = 2.133
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
				arg_73_0:Play114251019(arg_73_1)
			end
		end

		function arg_73_1.onSingleLineUpdate_(arg_76_0)
			local var_76_0 = arg_73_1.actors_["10015"].transform
			local var_76_1 = 0

			if var_76_1 < arg_73_1.time_ and arg_73_1.time_ <= var_76_1 + arg_76_0 then
				arg_73_1.var_.moveOldPos10015 = var_76_0.localPosition
				var_76_0.localScale = Vector3.New(1, 1, 1)

				arg_73_1:CheckSpriteTmpPos("10015", 4)

				local var_76_2 = var_76_0.childCount

				for iter_76_0 = 0, var_76_2 - 1 do
					local var_76_3 = var_76_0:GetChild(iter_76_0)

					if var_76_3.name == "split_1" or not string.find(var_76_3.name, "split") then
						var_76_3.gameObject:SetActive(true)
					else
						var_76_3.gameObject:SetActive(false)
					end
				end
			end

			local var_76_4 = 0.001

			if var_76_1 <= arg_73_1.time_ and arg_73_1.time_ < var_76_1 + var_76_4 then
				local var_76_5 = (arg_73_1.time_ - var_76_1) / var_76_4
				local var_76_6 = Vector3.New(390, -350, -180)

				var_76_0.localPosition = Vector3.Lerp(arg_73_1.var_.moveOldPos10015, var_76_6, var_76_5)
			end

			if arg_73_1.time_ >= var_76_1 + var_76_4 and arg_73_1.time_ < var_76_1 + var_76_4 + arg_76_0 then
				var_76_0.localPosition = Vector3.New(390, -350, -180)
			end

			local var_76_7 = arg_73_1.actors_["10015"]
			local var_76_8 = 0

			if var_76_8 < arg_73_1.time_ and arg_73_1.time_ <= var_76_8 + arg_76_0 and not isNil(var_76_7) and arg_73_1.var_.actorSpriteComps10015 == nil then
				arg_73_1.var_.actorSpriteComps10015 = var_76_7:GetComponentsInChildren(typeof(Image), true)
			end

			local var_76_9 = 0.034

			if var_76_8 <= arg_73_1.time_ and arg_73_1.time_ < var_76_8 + var_76_9 and not isNil(var_76_7) then
				local var_76_10 = (arg_73_1.time_ - var_76_8) / var_76_9

				if arg_73_1.var_.actorSpriteComps10015 then
					for iter_76_1, iter_76_2 in pairs(arg_73_1.var_.actorSpriteComps10015:ToTable()) do
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

			if arg_73_1.time_ >= var_76_8 + var_76_9 and arg_73_1.time_ < var_76_8 + var_76_9 + arg_76_0 and not isNil(var_76_7) and arg_73_1.var_.actorSpriteComps10015 then
				for iter_76_3, iter_76_4 in pairs(arg_73_1.var_.actorSpriteComps10015:ToTable()) do
					if iter_76_4 then
						if arg_73_1.isInRecall_ then
							iter_76_4.color = arg_73_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_76_4.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_73_1.var_.actorSpriteComps10015 = nil
			end

			local var_76_15 = arg_73_1.actors_["10015"]
			local var_76_16 = 0

			if var_76_16 < arg_73_1.time_ and arg_73_1.time_ <= var_76_16 + arg_76_0 then
				local var_76_17 = var_76_15:GetComponentInChildren(typeof(CanvasGroup))

				if var_76_17 then
					arg_73_1.var_.alphaOldValue10015 = var_76_17.alpha
					arg_73_1.var_.characterEffect10015 = var_76_17
				end

				arg_73_1.var_.alphaOldValue10015 = 0
			end

			local var_76_18 = 0.5

			if var_76_16 <= arg_73_1.time_ and arg_73_1.time_ < var_76_16 + var_76_18 then
				local var_76_19 = (arg_73_1.time_ - var_76_16) / var_76_18
				local var_76_20 = Mathf.Lerp(arg_73_1.var_.alphaOldValue10015, 1, var_76_19)

				if arg_73_1.var_.characterEffect10015 then
					arg_73_1.var_.characterEffect10015.alpha = var_76_20
				end
			end

			if arg_73_1.time_ >= var_76_16 + var_76_18 and arg_73_1.time_ < var_76_16 + var_76_18 + arg_76_0 and arg_73_1.var_.characterEffect10015 then
				arg_73_1.var_.characterEffect10015.alpha = 1
			end

			local var_76_21 = 0
			local var_76_22 = 0.325

			if var_76_21 < arg_73_1.time_ and arg_73_1.time_ <= var_76_21 + arg_76_0 then
				arg_73_1.talkMaxDuration = 0
				arg_73_1.dialogCg_.alpha = 1

				arg_73_1.dialog_:SetActive(true)
				SetActive(arg_73_1.leftNameGo_, true)

				local var_76_23 = arg_73_1:FormatText(StoryNameCfg[208].name)

				arg_73_1.leftNameTxt_.text = var_76_23

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_73_1.leftNameTxt_.transform)

				arg_73_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_73_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_73_1:RecordName(arg_73_1.leftNameTxt_.text)
				SetActive(arg_73_1.iconTrs_.gameObject, false)
				arg_73_1.callingController_:SetSelectedState("normal")

				local var_76_24 = arg_73_1:GetWordFromCfg(114251018)
				local var_76_25 = arg_73_1:FormatText(var_76_24.content)

				arg_73_1.text_.text = var_76_25

				LuaForUtil.ClearLinePrefixSymbol(arg_73_1.text_)

				local var_76_26 = 13
				local var_76_27 = utf8.len(var_76_25)
				local var_76_28 = var_76_26 <= 0 and var_76_22 or var_76_22 * (var_76_27 / var_76_26)

				if var_76_28 > 0 and var_76_22 < var_76_28 then
					arg_73_1.talkMaxDuration = var_76_28

					if var_76_28 + var_76_21 > arg_73_1.duration_ then
						arg_73_1.duration_ = var_76_28 + var_76_21
					end
				end

				arg_73_1.text_.text = var_76_25
				arg_73_1.typewritter.percent = 0

				arg_73_1.typewritter:SetDirty()
				arg_73_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_114251", "114251018", "story_v_out_114251.awb") ~= 0 then
					local var_76_29 = manager.audio:GetVoiceLength("story_v_out_114251", "114251018", "story_v_out_114251.awb") / 1000

					if var_76_29 + var_76_21 > arg_73_1.duration_ then
						arg_73_1.duration_ = var_76_29 + var_76_21
					end

					if var_76_24.prefab_name ~= "" and arg_73_1.actors_[var_76_24.prefab_name] ~= nil then
						local var_76_30 = LuaForUtil.PlayVoiceWithCriLipsync(arg_73_1.actors_[var_76_24.prefab_name].transform, "story_v_out_114251", "114251018", "story_v_out_114251.awb")

						arg_73_1:RecordAudio("114251018", var_76_30)
						arg_73_1:RecordAudio("114251018", var_76_30)
					else
						arg_73_1:AudioAction("play", "voice", "story_v_out_114251", "114251018", "story_v_out_114251.awb")
					end

					arg_73_1:RecordHistoryTalkVoice("story_v_out_114251", "114251018", "story_v_out_114251.awb")
				end

				arg_73_1:RecordContent(arg_73_1.text_.text)
			end

			local var_76_31 = math.max(var_76_22, arg_73_1.talkMaxDuration)

			if var_76_21 <= arg_73_1.time_ and arg_73_1.time_ < var_76_21 + var_76_31 then
				arg_73_1.typewritter.percent = (arg_73_1.time_ - var_76_21) / var_76_31

				arg_73_1.typewritter:SetDirty()
			end

			if arg_73_1.time_ >= var_76_21 + var_76_31 and arg_73_1.time_ < var_76_21 + var_76_31 + arg_76_0 then
				arg_73_1.typewritter.percent = 1

				arg_73_1.typewritter:SetDirty()
				arg_73_1:ShowNextGo(true)
			end
		end

		arg_73_1.nodeConfigList_ = {
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

		arg_73_1:InitPlayNodeList()
	end,
	Play114251019 = function(arg_77_0, arg_77_1)
		arg_77_1.time_ = 0
		arg_77_1.frameCnt_ = 0
		arg_77_1.state_ = "playing"
		arg_77_1.curTalkId_ = 114251019
		arg_77_1.duration_ = 4.1

		local var_77_0 = {
			ja = 4.1,
			ko = 3.633,
			zh = 3.433,
			en = 3.2
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
				arg_77_0:Play114251020(arg_77_1)
			end
		end

		function arg_77_1.onSingleLineUpdate_(arg_80_0)
			local var_80_0 = arg_77_1.actors_["10018"].transform
			local var_80_1 = 0

			if var_80_1 < arg_77_1.time_ and arg_77_1.time_ <= var_80_1 + arg_80_0 then
				arg_77_1.var_.moveOldPos10018 = var_80_0.localPosition
				var_80_0.localScale = Vector3.New(1, 1, 1)

				arg_77_1:CheckSpriteTmpPos("10018", 2)

				local var_80_2 = var_80_0.childCount

				for iter_80_0 = 0, var_80_2 - 1 do
					local var_80_3 = var_80_0:GetChild(iter_80_0)

					if var_80_3.name == "split_2" or not string.find(var_80_3.name, "split") then
						var_80_3.gameObject:SetActive(true)
					else
						var_80_3.gameObject:SetActive(false)
					end
				end
			end

			local var_80_4 = 0.001

			if var_80_1 <= arg_77_1.time_ and arg_77_1.time_ < var_80_1 + var_80_4 then
				local var_80_5 = (arg_77_1.time_ - var_80_1) / var_80_4
				local var_80_6 = Vector3.New(-390, -350, -180)

				var_80_0.localPosition = Vector3.Lerp(arg_77_1.var_.moveOldPos10018, var_80_6, var_80_5)
			end

			if arg_77_1.time_ >= var_80_1 + var_80_4 and arg_77_1.time_ < var_80_1 + var_80_4 + arg_80_0 then
				var_80_0.localPosition = Vector3.New(-390, -350, -180)
			end

			local var_80_7 = arg_77_1.actors_["10018"]
			local var_80_8 = 0

			if var_80_8 < arg_77_1.time_ and arg_77_1.time_ <= var_80_8 + arg_80_0 and not isNil(var_80_7) and arg_77_1.var_.actorSpriteComps10018 == nil then
				arg_77_1.var_.actorSpriteComps10018 = var_80_7:GetComponentsInChildren(typeof(Image), true)
			end

			local var_80_9 = 0.034

			if var_80_8 <= arg_77_1.time_ and arg_77_1.time_ < var_80_8 + var_80_9 and not isNil(var_80_7) then
				local var_80_10 = (arg_77_1.time_ - var_80_8) / var_80_9

				if arg_77_1.var_.actorSpriteComps10018 then
					for iter_80_1, iter_80_2 in pairs(arg_77_1.var_.actorSpriteComps10018:ToTable()) do
						if iter_80_2 then
							if arg_77_1.isInRecall_ then
								local var_80_11 = Mathf.Lerp(iter_80_2.color.r, arg_77_1.hightColor1.r, var_80_10)
								local var_80_12 = Mathf.Lerp(iter_80_2.color.g, arg_77_1.hightColor1.g, var_80_10)
								local var_80_13 = Mathf.Lerp(iter_80_2.color.b, arg_77_1.hightColor1.b, var_80_10)

								iter_80_2.color = Color.New(var_80_11, var_80_12, var_80_13)
							else
								local var_80_14 = Mathf.Lerp(iter_80_2.color.r, 1, var_80_10)

								iter_80_2.color = Color.New(var_80_14, var_80_14, var_80_14)
							end
						end
					end
				end
			end

			if arg_77_1.time_ >= var_80_8 + var_80_9 and arg_77_1.time_ < var_80_8 + var_80_9 + arg_80_0 and not isNil(var_80_7) and arg_77_1.var_.actorSpriteComps10018 then
				for iter_80_3, iter_80_4 in pairs(arg_77_1.var_.actorSpriteComps10018:ToTable()) do
					if iter_80_4 then
						if arg_77_1.isInRecall_ then
							iter_80_4.color = arg_77_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_80_4.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_77_1.var_.actorSpriteComps10018 = nil
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
								local var_80_19 = Mathf.Lerp(iter_80_6.color.r, arg_77_1.hightColor2.r, var_80_18)
								local var_80_20 = Mathf.Lerp(iter_80_6.color.g, arg_77_1.hightColor2.g, var_80_18)
								local var_80_21 = Mathf.Lerp(iter_80_6.color.b, arg_77_1.hightColor2.b, var_80_18)

								iter_80_6.color = Color.New(var_80_19, var_80_20, var_80_21)
							else
								local var_80_22 = Mathf.Lerp(iter_80_6.color.r, 0.5, var_80_18)

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
							iter_80_8.color = arg_77_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_80_8.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_77_1.var_.actorSpriteComps10015 = nil
			end

			local var_80_23 = arg_77_1.actors_["10018"]
			local var_80_24 = 0

			if var_80_24 < arg_77_1.time_ and arg_77_1.time_ <= var_80_24 + arg_80_0 then
				local var_80_25 = var_80_23:GetComponentInChildren(typeof(CanvasGroup))

				if var_80_25 then
					arg_77_1.var_.alphaOldValue10018 = var_80_25.alpha
					arg_77_1.var_.characterEffect10018 = var_80_25
				end

				arg_77_1.var_.alphaOldValue10018 = 0
			end

			local var_80_26 = 0.5

			if var_80_24 <= arg_77_1.time_ and arg_77_1.time_ < var_80_24 + var_80_26 then
				local var_80_27 = (arg_77_1.time_ - var_80_24) / var_80_26
				local var_80_28 = Mathf.Lerp(arg_77_1.var_.alphaOldValue10018, 1, var_80_27)

				if arg_77_1.var_.characterEffect10018 then
					arg_77_1.var_.characterEffect10018.alpha = var_80_28
				end
			end

			if arg_77_1.time_ >= var_80_24 + var_80_26 and arg_77_1.time_ < var_80_24 + var_80_26 + arg_80_0 and arg_77_1.var_.characterEffect10018 then
				arg_77_1.var_.characterEffect10018.alpha = 1
			end

			local var_80_29 = 0
			local var_80_30 = 0.35

			if var_80_29 < arg_77_1.time_ and arg_77_1.time_ <= var_80_29 + arg_80_0 then
				arg_77_1.talkMaxDuration = 0
				arg_77_1.dialogCg_.alpha = 1

				arg_77_1.dialog_:SetActive(true)
				SetActive(arg_77_1.leftNameGo_, true)

				local var_80_31 = arg_77_1:FormatText(StoryNameCfg[257].name)

				arg_77_1.leftNameTxt_.text = var_80_31

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_77_1.leftNameTxt_.transform)

				arg_77_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_77_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_77_1:RecordName(arg_77_1.leftNameTxt_.text)
				SetActive(arg_77_1.iconTrs_.gameObject, false)
				arg_77_1.callingController_:SetSelectedState("normal")

				local var_80_32 = arg_77_1:GetWordFromCfg(114251019)
				local var_80_33 = arg_77_1:FormatText(var_80_32.content)

				arg_77_1.text_.text = var_80_33

				LuaForUtil.ClearLinePrefixSymbol(arg_77_1.text_)

				local var_80_34 = 14
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

				if manager.audio:GetVoiceLength("story_v_out_114251", "114251019", "story_v_out_114251.awb") ~= 0 then
					local var_80_37 = manager.audio:GetVoiceLength("story_v_out_114251", "114251019", "story_v_out_114251.awb") / 1000

					if var_80_37 + var_80_29 > arg_77_1.duration_ then
						arg_77_1.duration_ = var_80_37 + var_80_29
					end

					if var_80_32.prefab_name ~= "" and arg_77_1.actors_[var_80_32.prefab_name] ~= nil then
						local var_80_38 = LuaForUtil.PlayVoiceWithCriLipsync(arg_77_1.actors_[var_80_32.prefab_name].transform, "story_v_out_114251", "114251019", "story_v_out_114251.awb")

						arg_77_1:RecordAudio("114251019", var_80_38)
						arg_77_1:RecordAudio("114251019", var_80_38)
					else
						arg_77_1:AudioAction("play", "voice", "story_v_out_114251", "114251019", "story_v_out_114251.awb")
					end

					arg_77_1:RecordHistoryTalkVoice("story_v_out_114251", "114251019", "story_v_out_114251.awb")
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
				actorName = "10018",
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
	Play114251020 = function(arg_81_0, arg_81_1)
		arg_81_1.time_ = 0
		arg_81_1.frameCnt_ = 0
		arg_81_1.state_ = "playing"
		arg_81_1.curTalkId_ = 114251020
		arg_81_1.duration_ = 9.13

		local var_81_0 = {
			ja = 9.133,
			ko = 6.533,
			zh = 7.366,
			en = 7.333
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
				arg_81_0:Play114251021(arg_81_1)
			end
		end

		function arg_81_1.onSingleLineUpdate_(arg_84_0)
			local var_84_0 = arg_81_1.actors_["10015"]
			local var_84_1 = 0

			if var_84_1 < arg_81_1.time_ and arg_81_1.time_ <= var_84_1 + arg_84_0 and not isNil(var_84_0) and arg_81_1.var_.actorSpriteComps10015 == nil then
				arg_81_1.var_.actorSpriteComps10015 = var_84_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_84_2 = 0.034

			if var_84_1 <= arg_81_1.time_ and arg_81_1.time_ < var_84_1 + var_84_2 and not isNil(var_84_0) then
				local var_84_3 = (arg_81_1.time_ - var_84_1) / var_84_2

				if arg_81_1.var_.actorSpriteComps10015 then
					for iter_84_0, iter_84_1 in pairs(arg_81_1.var_.actorSpriteComps10015:ToTable()) do
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

			if arg_81_1.time_ >= var_84_1 + var_84_2 and arg_81_1.time_ < var_84_1 + var_84_2 + arg_84_0 and not isNil(var_84_0) and arg_81_1.var_.actorSpriteComps10015 then
				for iter_84_2, iter_84_3 in pairs(arg_81_1.var_.actorSpriteComps10015:ToTable()) do
					if iter_84_3 then
						if arg_81_1.isInRecall_ then
							iter_84_3.color = arg_81_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_84_3.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_81_1.var_.actorSpriteComps10015 = nil
			end

			local var_84_8 = arg_81_1.actors_["10018"]
			local var_84_9 = 0

			if var_84_9 < arg_81_1.time_ and arg_81_1.time_ <= var_84_9 + arg_84_0 and not isNil(var_84_8) and arg_81_1.var_.actorSpriteComps10018 == nil then
				arg_81_1.var_.actorSpriteComps10018 = var_84_8:GetComponentsInChildren(typeof(Image), true)
			end

			local var_84_10 = 0.034

			if var_84_9 <= arg_81_1.time_ and arg_81_1.time_ < var_84_9 + var_84_10 and not isNil(var_84_8) then
				local var_84_11 = (arg_81_1.time_ - var_84_9) / var_84_10

				if arg_81_1.var_.actorSpriteComps10018 then
					for iter_84_4, iter_84_5 in pairs(arg_81_1.var_.actorSpriteComps10018:ToTable()) do
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

			if arg_81_1.time_ >= var_84_9 + var_84_10 and arg_81_1.time_ < var_84_9 + var_84_10 + arg_84_0 and not isNil(var_84_8) and arg_81_1.var_.actorSpriteComps10018 then
				for iter_84_6, iter_84_7 in pairs(arg_81_1.var_.actorSpriteComps10018:ToTable()) do
					if iter_84_7 then
						if arg_81_1.isInRecall_ then
							iter_84_7.color = arg_81_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_84_7.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_81_1.var_.actorSpriteComps10018 = nil
			end

			local var_84_16 = 0
			local var_84_17 = 0.725

			if var_84_16 < arg_81_1.time_ and arg_81_1.time_ <= var_84_16 + arg_84_0 then
				arg_81_1.talkMaxDuration = 0
				arg_81_1.dialogCg_.alpha = 1

				arg_81_1.dialog_:SetActive(true)
				SetActive(arg_81_1.leftNameGo_, true)

				local var_84_18 = arg_81_1:FormatText(StoryNameCfg[208].name)

				arg_81_1.leftNameTxt_.text = var_84_18

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_81_1.leftNameTxt_.transform)

				arg_81_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_81_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_81_1:RecordName(arg_81_1.leftNameTxt_.text)
				SetActive(arg_81_1.iconTrs_.gameObject, false)
				arg_81_1.callingController_:SetSelectedState("normal")

				local var_84_19 = arg_81_1:GetWordFromCfg(114251020)
				local var_84_20 = arg_81_1:FormatText(var_84_19.content)

				arg_81_1.text_.text = var_84_20

				LuaForUtil.ClearLinePrefixSymbol(arg_81_1.text_)

				local var_84_21 = 29
				local var_84_22 = utf8.len(var_84_20)
				local var_84_23 = var_84_21 <= 0 and var_84_17 or var_84_17 * (var_84_22 / var_84_21)

				if var_84_23 > 0 and var_84_17 < var_84_23 then
					arg_81_1.talkMaxDuration = var_84_23

					if var_84_23 + var_84_16 > arg_81_1.duration_ then
						arg_81_1.duration_ = var_84_23 + var_84_16
					end
				end

				arg_81_1.text_.text = var_84_20
				arg_81_1.typewritter.percent = 0

				arg_81_1.typewritter:SetDirty()
				arg_81_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_114251", "114251020", "story_v_out_114251.awb") ~= 0 then
					local var_84_24 = manager.audio:GetVoiceLength("story_v_out_114251", "114251020", "story_v_out_114251.awb") / 1000

					if var_84_24 + var_84_16 > arg_81_1.duration_ then
						arg_81_1.duration_ = var_84_24 + var_84_16
					end

					if var_84_19.prefab_name ~= "" and arg_81_1.actors_[var_84_19.prefab_name] ~= nil then
						local var_84_25 = LuaForUtil.PlayVoiceWithCriLipsync(arg_81_1.actors_[var_84_19.prefab_name].transform, "story_v_out_114251", "114251020", "story_v_out_114251.awb")

						arg_81_1:RecordAudio("114251020", var_84_25)
						arg_81_1:RecordAudio("114251020", var_84_25)
					else
						arg_81_1:AudioAction("play", "voice", "story_v_out_114251", "114251020", "story_v_out_114251.awb")
					end

					arg_81_1:RecordHistoryTalkVoice("story_v_out_114251", "114251020", "story_v_out_114251.awb")
				end

				arg_81_1:RecordContent(arg_81_1.text_.text)
			end

			local var_84_26 = math.max(var_84_17, arg_81_1.talkMaxDuration)

			if var_84_16 <= arg_81_1.time_ and arg_81_1.time_ < var_84_16 + var_84_26 then
				arg_81_1.typewritter.percent = (arg_81_1.time_ - var_84_16) / var_84_26

				arg_81_1.typewritter:SetDirty()
			end

			if arg_81_1.time_ >= var_84_16 + var_84_26 and arg_81_1.time_ < var_84_16 + var_84_26 + arg_84_0 then
				arg_81_1.typewritter.percent = 1

				arg_81_1.typewritter:SetDirty()
				arg_81_1:ShowNextGo(true)
			end
		end

		arg_81_1.nodeConfigList_ = {}

		arg_81_1:InitPlayNodeList()
	end,
	Play114251021 = function(arg_85_0, arg_85_1)
		arg_85_1.time_ = 0
		arg_85_1.frameCnt_ = 0
		arg_85_1.state_ = "playing"
		arg_85_1.curTalkId_ = 114251021
		arg_85_1.duration_ = 8.45

		SetActive(arg_85_1.tipsGo_, false)

		function arg_85_1.onSingleLineFinish_()
			arg_85_1.onSingleLineUpdate_ = nil
			arg_85_1.onSingleLineFinish_ = nil
			arg_85_1.state_ = "waiting"
		end

		function arg_85_1.playNext_(arg_87_0)
			if arg_87_0 == 1 then
				arg_85_0:Play114251022(arg_85_1)
			end
		end

		function arg_85_1.onSingleLineUpdate_(arg_88_0)
			local var_88_0 = arg_85_1.actors_["10018"].transform
			local var_88_1 = 1.966

			if var_88_1 < arg_85_1.time_ and arg_85_1.time_ <= var_88_1 + arg_88_0 then
				arg_85_1.var_.moveOldPos10018 = var_88_0.localPosition
				var_88_0.localScale = Vector3.New(1, 1, 1)

				arg_85_1:CheckSpriteTmpPos("10018", 7)

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
				local var_88_6 = Vector3.New(0, -2000, -180)

				var_88_0.localPosition = Vector3.Lerp(arg_85_1.var_.moveOldPos10018, var_88_6, var_88_5)
			end

			if arg_85_1.time_ >= var_88_1 + var_88_4 and arg_85_1.time_ < var_88_1 + var_88_4 + arg_88_0 then
				var_88_0.localPosition = Vector3.New(0, -2000, -180)
			end

			local var_88_7 = arg_85_1.actors_["10015"].transform
			local var_88_8 = 1.966

			if var_88_8 < arg_85_1.time_ and arg_85_1.time_ <= var_88_8 + arg_88_0 then
				arg_85_1.var_.moveOldPos10015 = var_88_7.localPosition
				var_88_7.localScale = Vector3.New(1, 1, 1)

				arg_85_1:CheckSpriteTmpPos("10015", 7)

				local var_88_9 = var_88_7.childCount

				for iter_88_1 = 0, var_88_9 - 1 do
					local var_88_10 = var_88_7:GetChild(iter_88_1)

					if var_88_10.name == "split_1" or not string.find(var_88_10.name, "split") then
						var_88_10.gameObject:SetActive(true)
					else
						var_88_10.gameObject:SetActive(false)
					end
				end
			end

			local var_88_11 = 0.001

			if var_88_8 <= arg_85_1.time_ and arg_85_1.time_ < var_88_8 + var_88_11 then
				local var_88_12 = (arg_85_1.time_ - var_88_8) / var_88_11
				local var_88_13 = Vector3.New(0, -2000, 450)

				var_88_7.localPosition = Vector3.Lerp(arg_85_1.var_.moveOldPos10015, var_88_13, var_88_12)
			end

			if arg_85_1.time_ >= var_88_8 + var_88_11 and arg_85_1.time_ < var_88_8 + var_88_11 + arg_88_0 then
				var_88_7.localPosition = Vector3.New(0, -2000, 450)
			end

			local var_88_14 = "ST24"

			if arg_85_1.bgs_[var_88_14] == nil then
				local var_88_15 = Object.Instantiate(arg_85_1.paintGo_)

				var_88_15:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. var_88_14)
				var_88_15.name = var_88_14
				var_88_15.transform.parent = arg_85_1.stage_.transform
				var_88_15.transform.localPosition = Vector3.New(0, 100, 0)
				arg_85_1.bgs_[var_88_14] = var_88_15
			end

			local var_88_16 = 2

			if var_88_16 < arg_85_1.time_ and arg_85_1.time_ <= var_88_16 + arg_88_0 then
				local var_88_17 = manager.ui.mainCamera.transform.localPosition
				local var_88_18 = Vector3.New(0, 0, 10) + Vector3.New(var_88_17.x, var_88_17.y, 0)
				local var_88_19 = arg_85_1.bgs_.ST24

				var_88_19.transform.localPosition = var_88_18
				var_88_19.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_88_20 = var_88_19:GetComponent("SpriteRenderer")

				if var_88_20 and var_88_20.sprite then
					local var_88_21 = (var_88_19.transform.localPosition - var_88_17).z
					local var_88_22 = manager.ui.mainCameraCom_
					local var_88_23 = 2 * var_88_21 * Mathf.Tan(var_88_22.fieldOfView * 0.5 * Mathf.Deg2Rad)
					local var_88_24 = var_88_23 * var_88_22.aspect
					local var_88_25 = var_88_20.sprite.bounds.size.x
					local var_88_26 = var_88_20.sprite.bounds.size.y
					local var_88_27 = var_88_24 / var_88_25
					local var_88_28 = var_88_23 / var_88_26
					local var_88_29 = var_88_28 < var_88_27 and var_88_27 or var_88_28

					var_88_19.transform.localScale = Vector3.New(var_88_29, var_88_29, 0)
				end

				for iter_88_2, iter_88_3 in pairs(arg_85_1.bgs_) do
					if iter_88_2 ~= "ST24" then
						iter_88_3.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_88_30 = 0

			if var_88_30 < arg_85_1.time_ and arg_85_1.time_ <= var_88_30 + arg_88_0 then
				arg_85_1.mask_.enabled = true
				arg_85_1.mask_.raycastTarget = true

				arg_85_1:SetGaussion(false)
			end

			local var_88_31 = 2

			if var_88_30 <= arg_85_1.time_ and arg_85_1.time_ < var_88_30 + var_88_31 then
				local var_88_32 = (arg_85_1.time_ - var_88_30) / var_88_31
				local var_88_33 = Color.New(0, 0, 0)

				var_88_33.a = Mathf.Lerp(0, 1, var_88_32)
				arg_85_1.mask_.color = var_88_33
			end

			if arg_85_1.time_ >= var_88_30 + var_88_31 and arg_85_1.time_ < var_88_30 + var_88_31 + arg_88_0 then
				local var_88_34 = Color.New(0, 0, 0)

				var_88_34.a = 1
				arg_85_1.mask_.color = var_88_34
			end

			local var_88_35 = 2

			if var_88_35 < arg_85_1.time_ and arg_85_1.time_ <= var_88_35 + arg_88_0 then
				arg_85_1.mask_.enabled = true
				arg_85_1.mask_.raycastTarget = true

				arg_85_1:SetGaussion(false)
			end

			local var_88_36 = 2

			if var_88_35 <= arg_85_1.time_ and arg_85_1.time_ < var_88_35 + var_88_36 then
				local var_88_37 = (arg_85_1.time_ - var_88_35) / var_88_36
				local var_88_38 = Color.New(0, 0, 0)

				var_88_38.a = Mathf.Lerp(1, 0, var_88_37)
				arg_85_1.mask_.color = var_88_38
			end

			if arg_85_1.time_ >= var_88_35 + var_88_36 and arg_85_1.time_ < var_88_35 + var_88_36 + arg_88_0 then
				local var_88_39 = Color.New(0, 0, 0)
				local var_88_40 = 0

				arg_85_1.mask_.enabled = false
				var_88_39.a = var_88_40
				arg_85_1.mask_.color = var_88_39
			end

			local var_88_41 = 1
			local var_88_42 = 1

			if var_88_41 < arg_85_1.time_ and arg_85_1.time_ <= var_88_41 + arg_88_0 then
				local var_88_43 = "play"
				local var_88_44 = "effect"

				arg_85_1:AudioAction(var_88_43, var_88_44, "se_story_activity_1_4_3", "se_story_activity_1_4_3_door", "")
			end

			if arg_85_1.frameCnt_ <= 1 then
				arg_85_1.dialog_:SetActive(false)
			end

			local var_88_45 = 3.45
			local var_88_46 = 0.55

			if var_88_45 < arg_85_1.time_ and arg_85_1.time_ <= var_88_45 + arg_88_0 then
				arg_85_1.talkMaxDuration = 0

				arg_85_1.dialog_:SetActive(true)

				arg_85_1.dialogCg_.alpha = 0

				local var_88_47 = LeanTween.value(arg_85_1.dialog_, 0, 1, 0.3)

				var_88_47:setOnUpdate(LuaHelper.FloatAction(function(arg_89_0)
					arg_85_1.dialogCg_.alpha = arg_89_0
				end))
				var_88_47:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_85_1.dialog_)
					var_88_47:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_85_1.duration_ = arg_85_1.duration_ + 0.3

				SetActive(arg_85_1.leftNameGo_, false)

				arg_85_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_85_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_85_1:RecordName(arg_85_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_85_1.iconTrs_.gameObject, false)
				arg_85_1.callingController_:SetSelectedState("normal")

				local var_88_48 = arg_85_1:GetWordFromCfg(114251021)
				local var_88_49 = arg_85_1:FormatText(var_88_48.content)

				arg_85_1.text_.text = var_88_49

				LuaForUtil.ClearLinePrefixSymbol(arg_85_1.text_)

				local var_88_50 = 22
				local var_88_51 = utf8.len(var_88_49)
				local var_88_52 = var_88_50 <= 0 and var_88_46 or var_88_46 * (var_88_51 / var_88_50)

				if var_88_52 > 0 and var_88_46 < var_88_52 then
					arg_85_1.talkMaxDuration = var_88_52
					var_88_45 = var_88_45 + 0.3

					if var_88_52 + var_88_45 > arg_85_1.duration_ then
						arg_85_1.duration_ = var_88_52 + var_88_45
					end
				end

				arg_85_1.text_.text = var_88_49
				arg_85_1.typewritter.percent = 0

				arg_85_1.typewritter:SetDirty()
				arg_85_1:ShowNextGo(false)
				arg_85_1:RecordContent(arg_85_1.text_.text)
			end

			local var_88_53 = var_88_45 + 0.3
			local var_88_54 = math.max(var_88_46, arg_85_1.talkMaxDuration)

			if var_88_53 <= arg_85_1.time_ and arg_85_1.time_ < var_88_53 + var_88_54 then
				arg_85_1.typewritter.percent = (arg_85_1.time_ - var_88_53) / var_88_54

				arg_85_1.typewritter:SetDirty()
			end

			if arg_85_1.time_ >= var_88_53 + var_88_54 and arg_85_1.time_ < var_88_53 + var_88_54 + arg_88_0 then
				arg_85_1.typewritter.percent = 1

				arg_85_1.typewritter:SetDirty()
				arg_85_1:ShowNextGo(true)
			end
		end

		arg_85_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10018",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 1.966,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			},
			{
				assetPath = "",
				actorName = "10015",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 1.966,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_85_1:InitPlayNodeList()
	end,
	Play114251022 = function(arg_91_0, arg_91_1)
		arg_91_1.time_ = 0
		arg_91_1.frameCnt_ = 0
		arg_91_1.state_ = "playing"
		arg_91_1.curTalkId_ = 114251022
		arg_91_1.duration_ = 3

		local var_91_0 = {
			ja = 3,
			ko = 1.9,
			zh = 1.7,
			en = 1.533
		}
		local var_91_1 = manager.audio:GetLocalizationFlag()

		if var_91_0[var_91_1] ~= nil then
			arg_91_1.duration_ = var_91_0[var_91_1]
		end

		SetActive(arg_91_1.tipsGo_, false)

		function arg_91_1.onSingleLineFinish_()
			arg_91_1.onSingleLineUpdate_ = nil
			arg_91_1.onSingleLineFinish_ = nil
			arg_91_1.state_ = "waiting"
		end

		function arg_91_1.playNext_(arg_93_0)
			if arg_93_0 == 1 then
				arg_91_0:Play114251023(arg_91_1)
			end
		end

		function arg_91_1.onSingleLineUpdate_(arg_94_0)
			local var_94_0 = arg_91_1.actors_["10018"].transform
			local var_94_1 = 0

			if var_94_1 < arg_91_1.time_ and arg_91_1.time_ <= var_94_1 + arg_94_0 then
				arg_91_1.var_.moveOldPos10018 = var_94_0.localPosition
				var_94_0.localScale = Vector3.New(1, 1, 1)

				arg_91_1:CheckSpriteTmpPos("10018", 2)

				local var_94_2 = var_94_0.childCount

				for iter_94_0 = 0, var_94_2 - 1 do
					local var_94_3 = var_94_0:GetChild(iter_94_0)

					if var_94_3.name == "split_1" or not string.find(var_94_3.name, "split") then
						var_94_3.gameObject:SetActive(true)
					else
						var_94_3.gameObject:SetActive(false)
					end
				end
			end

			local var_94_4 = 0.001

			if var_94_1 <= arg_91_1.time_ and arg_91_1.time_ < var_94_1 + var_94_4 then
				local var_94_5 = (arg_91_1.time_ - var_94_1) / var_94_4
				local var_94_6 = Vector3.New(-390, -350, -180)

				var_94_0.localPosition = Vector3.Lerp(arg_91_1.var_.moveOldPos10018, var_94_6, var_94_5)
			end

			if arg_91_1.time_ >= var_94_1 + var_94_4 and arg_91_1.time_ < var_94_1 + var_94_4 + arg_94_0 then
				var_94_0.localPosition = Vector3.New(-390, -350, -180)
			end

			local var_94_7 = arg_91_1.actors_["10015"].transform
			local var_94_8 = 0

			if var_94_8 < arg_91_1.time_ and arg_91_1.time_ <= var_94_8 + arg_94_0 then
				arg_91_1.var_.moveOldPos10015 = var_94_7.localPosition
				var_94_7.localScale = Vector3.New(1, 1, 1)

				arg_91_1:CheckSpriteTmpPos("10015", 4)

				local var_94_9 = var_94_7.childCount

				for iter_94_1 = 0, var_94_9 - 1 do
					local var_94_10 = var_94_7:GetChild(iter_94_1)

					if var_94_10.name == "split_5" or not string.find(var_94_10.name, "split") then
						var_94_10.gameObject:SetActive(true)
					else
						var_94_10.gameObject:SetActive(false)
					end
				end
			end

			local var_94_11 = 0.001

			if var_94_8 <= arg_91_1.time_ and arg_91_1.time_ < var_94_8 + var_94_11 then
				local var_94_12 = (arg_91_1.time_ - var_94_8) / var_94_11
				local var_94_13 = Vector3.New(390, -350, -180)

				var_94_7.localPosition = Vector3.Lerp(arg_91_1.var_.moveOldPos10015, var_94_13, var_94_12)
			end

			if arg_91_1.time_ >= var_94_8 + var_94_11 and arg_91_1.time_ < var_94_8 + var_94_11 + arg_94_0 then
				var_94_7.localPosition = Vector3.New(390, -350, -180)
			end

			local var_94_14 = arg_91_1.actors_["10018"]
			local var_94_15 = 0

			if var_94_15 < arg_91_1.time_ and arg_91_1.time_ <= var_94_15 + arg_94_0 and not isNil(var_94_14) and arg_91_1.var_.actorSpriteComps10018 == nil then
				arg_91_1.var_.actorSpriteComps10018 = var_94_14:GetComponentsInChildren(typeof(Image), true)
			end

			local var_94_16 = 0.034

			if var_94_15 <= arg_91_1.time_ and arg_91_1.time_ < var_94_15 + var_94_16 and not isNil(var_94_14) then
				local var_94_17 = (arg_91_1.time_ - var_94_15) / var_94_16

				if arg_91_1.var_.actorSpriteComps10018 then
					for iter_94_2, iter_94_3 in pairs(arg_91_1.var_.actorSpriteComps10018:ToTable()) do
						if iter_94_3 then
							if arg_91_1.isInRecall_ then
								local var_94_18 = Mathf.Lerp(iter_94_3.color.r, arg_91_1.hightColor2.r, var_94_17)
								local var_94_19 = Mathf.Lerp(iter_94_3.color.g, arg_91_1.hightColor2.g, var_94_17)
								local var_94_20 = Mathf.Lerp(iter_94_3.color.b, arg_91_1.hightColor2.b, var_94_17)

								iter_94_3.color = Color.New(var_94_18, var_94_19, var_94_20)
							else
								local var_94_21 = Mathf.Lerp(iter_94_3.color.r, 0.5, var_94_17)

								iter_94_3.color = Color.New(var_94_21, var_94_21, var_94_21)
							end
						end
					end
				end
			end

			if arg_91_1.time_ >= var_94_15 + var_94_16 and arg_91_1.time_ < var_94_15 + var_94_16 + arg_94_0 and not isNil(var_94_14) and arg_91_1.var_.actorSpriteComps10018 then
				for iter_94_4, iter_94_5 in pairs(arg_91_1.var_.actorSpriteComps10018:ToTable()) do
					if iter_94_5 then
						if arg_91_1.isInRecall_ then
							iter_94_5.color = arg_91_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_94_5.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_91_1.var_.actorSpriteComps10018 = nil
			end

			local var_94_22 = arg_91_1.actors_["10015"]
			local var_94_23 = 0

			if var_94_23 < arg_91_1.time_ and arg_91_1.time_ <= var_94_23 + arg_94_0 and not isNil(var_94_22) and arg_91_1.var_.actorSpriteComps10015 == nil then
				arg_91_1.var_.actorSpriteComps10015 = var_94_22:GetComponentsInChildren(typeof(Image), true)
			end

			local var_94_24 = 0.034

			if var_94_23 <= arg_91_1.time_ and arg_91_1.time_ < var_94_23 + var_94_24 and not isNil(var_94_22) then
				local var_94_25 = (arg_91_1.time_ - var_94_23) / var_94_24

				if arg_91_1.var_.actorSpriteComps10015 then
					for iter_94_6, iter_94_7 in pairs(arg_91_1.var_.actorSpriteComps10015:ToTable()) do
						if iter_94_7 then
							if arg_91_1.isInRecall_ then
								local var_94_26 = Mathf.Lerp(iter_94_7.color.r, arg_91_1.hightColor1.r, var_94_25)
								local var_94_27 = Mathf.Lerp(iter_94_7.color.g, arg_91_1.hightColor1.g, var_94_25)
								local var_94_28 = Mathf.Lerp(iter_94_7.color.b, arg_91_1.hightColor1.b, var_94_25)

								iter_94_7.color = Color.New(var_94_26, var_94_27, var_94_28)
							else
								local var_94_29 = Mathf.Lerp(iter_94_7.color.r, 1, var_94_25)

								iter_94_7.color = Color.New(var_94_29, var_94_29, var_94_29)
							end
						end
					end
				end
			end

			if arg_91_1.time_ >= var_94_23 + var_94_24 and arg_91_1.time_ < var_94_23 + var_94_24 + arg_94_0 and not isNil(var_94_22) and arg_91_1.var_.actorSpriteComps10015 then
				for iter_94_8, iter_94_9 in pairs(arg_91_1.var_.actorSpriteComps10015:ToTable()) do
					if iter_94_9 then
						if arg_91_1.isInRecall_ then
							iter_94_9.color = arg_91_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_94_9.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_91_1.var_.actorSpriteComps10015 = nil
			end

			local var_94_30 = arg_91_1.actors_["10015"]
			local var_94_31 = 0

			if var_94_31 < arg_91_1.time_ and arg_91_1.time_ <= var_94_31 + arg_94_0 then
				local var_94_32 = var_94_30:GetComponentInChildren(typeof(CanvasGroup))

				if var_94_32 then
					arg_91_1.var_.alphaOldValue10015 = var_94_32.alpha
					arg_91_1.var_.characterEffect10015 = var_94_32
				end

				arg_91_1.var_.alphaOldValue10015 = 0
			end

			local var_94_33 = 0.5

			if var_94_31 <= arg_91_1.time_ and arg_91_1.time_ < var_94_31 + var_94_33 then
				local var_94_34 = (arg_91_1.time_ - var_94_31) / var_94_33
				local var_94_35 = Mathf.Lerp(arg_91_1.var_.alphaOldValue10015, 1, var_94_34)

				if arg_91_1.var_.characterEffect10015 then
					arg_91_1.var_.characterEffect10015.alpha = var_94_35
				end
			end

			if arg_91_1.time_ >= var_94_31 + var_94_33 and arg_91_1.time_ < var_94_31 + var_94_33 + arg_94_0 and arg_91_1.var_.characterEffect10015 then
				arg_91_1.var_.characterEffect10015.alpha = 1
			end

			local var_94_36 = arg_91_1.actors_["10018"]
			local var_94_37 = 0

			if var_94_37 < arg_91_1.time_ and arg_91_1.time_ <= var_94_37 + arg_94_0 then
				local var_94_38 = var_94_36:GetComponentInChildren(typeof(CanvasGroup))

				if var_94_38 then
					arg_91_1.var_.alphaOldValue10018 = var_94_38.alpha
					arg_91_1.var_.characterEffect10018 = var_94_38
				end

				arg_91_1.var_.alphaOldValue10018 = 0
			end

			local var_94_39 = 0.5

			if var_94_37 <= arg_91_1.time_ and arg_91_1.time_ < var_94_37 + var_94_39 then
				local var_94_40 = (arg_91_1.time_ - var_94_37) / var_94_39
				local var_94_41 = Mathf.Lerp(arg_91_1.var_.alphaOldValue10018, 1, var_94_40)

				if arg_91_1.var_.characterEffect10018 then
					arg_91_1.var_.characterEffect10018.alpha = var_94_41
				end
			end

			if arg_91_1.time_ >= var_94_37 + var_94_39 and arg_91_1.time_ < var_94_37 + var_94_39 + arg_94_0 and arg_91_1.var_.characterEffect10018 then
				arg_91_1.var_.characterEffect10018.alpha = 1
			end

			local var_94_42 = 0
			local var_94_43 = 0.125

			if var_94_42 < arg_91_1.time_ and arg_91_1.time_ <= var_94_42 + arg_94_0 then
				arg_91_1.talkMaxDuration = 0
				arg_91_1.dialogCg_.alpha = 1

				arg_91_1.dialog_:SetActive(true)
				SetActive(arg_91_1.leftNameGo_, true)

				local var_94_44 = arg_91_1:FormatText(StoryNameCfg[208].name)

				arg_91_1.leftNameTxt_.text = var_94_44

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_91_1.leftNameTxt_.transform)

				arg_91_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_91_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_91_1:RecordName(arg_91_1.leftNameTxt_.text)
				SetActive(arg_91_1.iconTrs_.gameObject, false)
				arg_91_1.callingController_:SetSelectedState("normal")

				local var_94_45 = arg_91_1:GetWordFromCfg(114251022)
				local var_94_46 = arg_91_1:FormatText(var_94_45.content)

				arg_91_1.text_.text = var_94_46

				LuaForUtil.ClearLinePrefixSymbol(arg_91_1.text_)

				local var_94_47 = 5
				local var_94_48 = utf8.len(var_94_46)
				local var_94_49 = var_94_47 <= 0 and var_94_43 or var_94_43 * (var_94_48 / var_94_47)

				if var_94_49 > 0 and var_94_43 < var_94_49 then
					arg_91_1.talkMaxDuration = var_94_49

					if var_94_49 + var_94_42 > arg_91_1.duration_ then
						arg_91_1.duration_ = var_94_49 + var_94_42
					end
				end

				arg_91_1.text_.text = var_94_46
				arg_91_1.typewritter.percent = 0

				arg_91_1.typewritter:SetDirty()
				arg_91_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_114251", "114251022", "story_v_out_114251.awb") ~= 0 then
					local var_94_50 = manager.audio:GetVoiceLength("story_v_out_114251", "114251022", "story_v_out_114251.awb") / 1000

					if var_94_50 + var_94_42 > arg_91_1.duration_ then
						arg_91_1.duration_ = var_94_50 + var_94_42
					end

					if var_94_45.prefab_name ~= "" and arg_91_1.actors_[var_94_45.prefab_name] ~= nil then
						local var_94_51 = LuaForUtil.PlayVoiceWithCriLipsync(arg_91_1.actors_[var_94_45.prefab_name].transform, "story_v_out_114251", "114251022", "story_v_out_114251.awb")

						arg_91_1:RecordAudio("114251022", var_94_51)
						arg_91_1:RecordAudio("114251022", var_94_51)
					else
						arg_91_1:AudioAction("play", "voice", "story_v_out_114251", "114251022", "story_v_out_114251.awb")
					end

					arg_91_1:RecordHistoryTalkVoice("story_v_out_114251", "114251022", "story_v_out_114251.awb")
				end

				arg_91_1:RecordContent(arg_91_1.text_.text)
			end

			local var_94_52 = math.max(var_94_43, arg_91_1.talkMaxDuration)

			if var_94_42 <= arg_91_1.time_ and arg_91_1.time_ < var_94_42 + var_94_52 then
				arg_91_1.typewritter.percent = (arg_91_1.time_ - var_94_42) / var_94_52

				arg_91_1.typewritter:SetDirty()
			end

			if arg_91_1.time_ >= var_94_42 + var_94_52 and arg_91_1.time_ < var_94_42 + var_94_52 + arg_94_0 then
				arg_91_1.typewritter.percent = 1

				arg_91_1.typewritter:SetDirty()
				arg_91_1:ShowNextGo(true)
			end
		end

		arg_91_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10018",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			},
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

		arg_91_1:InitPlayNodeList()
	end,
	Play114251023 = function(arg_95_0, arg_95_1)
		arg_95_1.time_ = 0
		arg_95_1.frameCnt_ = 0
		arg_95_1.state_ = "playing"
		arg_95_1.curTalkId_ = 114251023
		arg_95_1.duration_ = 5

		SetActive(arg_95_1.tipsGo_, false)

		function arg_95_1.onSingleLineFinish_()
			arg_95_1.onSingleLineUpdate_ = nil
			arg_95_1.onSingleLineFinish_ = nil
			arg_95_1.state_ = "waiting"
		end

		function arg_95_1.playNext_(arg_97_0)
			if arg_97_0 == 1 then
				arg_95_0:Play114251024(arg_95_1)
			end
		end

		function arg_95_1.onSingleLineUpdate_(arg_98_0)
			local var_98_0 = arg_95_1.actors_["10015"]
			local var_98_1 = 0

			if var_98_1 < arg_95_1.time_ and arg_95_1.time_ <= var_98_1 + arg_98_0 and not isNil(var_98_0) and arg_95_1.var_.actorSpriteComps10015 == nil then
				arg_95_1.var_.actorSpriteComps10015 = var_98_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_98_2 = 0.034

			if var_98_1 <= arg_95_1.time_ and arg_95_1.time_ < var_98_1 + var_98_2 and not isNil(var_98_0) then
				local var_98_3 = (arg_95_1.time_ - var_98_1) / var_98_2

				if arg_95_1.var_.actorSpriteComps10015 then
					for iter_98_0, iter_98_1 in pairs(arg_95_1.var_.actorSpriteComps10015:ToTable()) do
						if iter_98_1 then
							if arg_95_1.isInRecall_ then
								local var_98_4 = Mathf.Lerp(iter_98_1.color.r, arg_95_1.hightColor2.r, var_98_3)
								local var_98_5 = Mathf.Lerp(iter_98_1.color.g, arg_95_1.hightColor2.g, var_98_3)
								local var_98_6 = Mathf.Lerp(iter_98_1.color.b, arg_95_1.hightColor2.b, var_98_3)

								iter_98_1.color = Color.New(var_98_4, var_98_5, var_98_6)
							else
								local var_98_7 = Mathf.Lerp(iter_98_1.color.r, 0.5, var_98_3)

								iter_98_1.color = Color.New(var_98_7, var_98_7, var_98_7)
							end
						end
					end
				end
			end

			if arg_95_1.time_ >= var_98_1 + var_98_2 and arg_95_1.time_ < var_98_1 + var_98_2 + arg_98_0 and not isNil(var_98_0) and arg_95_1.var_.actorSpriteComps10015 then
				for iter_98_2, iter_98_3 in pairs(arg_95_1.var_.actorSpriteComps10015:ToTable()) do
					if iter_98_3 then
						if arg_95_1.isInRecall_ then
							iter_98_3.color = arg_95_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_98_3.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_95_1.var_.actorSpriteComps10015 = nil
			end

			local var_98_8 = 0
			local var_98_9 = 0.65

			if var_98_8 < arg_95_1.time_ and arg_95_1.time_ <= var_98_8 + arg_98_0 then
				arg_95_1.talkMaxDuration = 0
				arg_95_1.dialogCg_.alpha = 1

				arg_95_1.dialog_:SetActive(true)
				SetActive(arg_95_1.leftNameGo_, false)

				arg_95_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_95_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_95_1:RecordName(arg_95_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_95_1.iconTrs_.gameObject, false)
				arg_95_1.callingController_:SetSelectedState("normal")

				local var_98_10 = arg_95_1:GetWordFromCfg(114251023)
				local var_98_11 = arg_95_1:FormatText(var_98_10.content)

				arg_95_1.text_.text = var_98_11

				LuaForUtil.ClearLinePrefixSymbol(arg_95_1.text_)

				local var_98_12 = 26
				local var_98_13 = utf8.len(var_98_11)
				local var_98_14 = var_98_12 <= 0 and var_98_9 or var_98_9 * (var_98_13 / var_98_12)

				if var_98_14 > 0 and var_98_9 < var_98_14 then
					arg_95_1.talkMaxDuration = var_98_14

					if var_98_14 + var_98_8 > arg_95_1.duration_ then
						arg_95_1.duration_ = var_98_14 + var_98_8
					end
				end

				arg_95_1.text_.text = var_98_11
				arg_95_1.typewritter.percent = 0

				arg_95_1.typewritter:SetDirty()
				arg_95_1:ShowNextGo(false)
				arg_95_1:RecordContent(arg_95_1.text_.text)
			end

			local var_98_15 = math.max(var_98_9, arg_95_1.talkMaxDuration)

			if var_98_8 <= arg_95_1.time_ and arg_95_1.time_ < var_98_8 + var_98_15 then
				arg_95_1.typewritter.percent = (arg_95_1.time_ - var_98_8) / var_98_15

				arg_95_1.typewritter:SetDirty()
			end

			if arg_95_1.time_ >= var_98_8 + var_98_15 and arg_95_1.time_ < var_98_8 + var_98_15 + arg_98_0 then
				arg_95_1.typewritter.percent = 1

				arg_95_1.typewritter:SetDirty()
				arg_95_1:ShowNextGo(true)
			end
		end

		arg_95_1.nodeConfigList_ = {}

		arg_95_1:InitPlayNodeList()
	end,
	Play114251024 = function(arg_99_0, arg_99_1)
		arg_99_1.time_ = 0
		arg_99_1.frameCnt_ = 0
		arg_99_1.state_ = "playing"
		arg_99_1.curTalkId_ = 114251024
		arg_99_1.duration_ = 5

		SetActive(arg_99_1.tipsGo_, false)

		function arg_99_1.onSingleLineFinish_()
			arg_99_1.onSingleLineUpdate_ = nil
			arg_99_1.onSingleLineFinish_ = nil
			arg_99_1.state_ = "waiting"
		end

		function arg_99_1.playNext_(arg_101_0)
			if arg_101_0 == 1 then
				arg_99_0:Play114251025(arg_99_1)
			end
		end

		function arg_99_1.onSingleLineUpdate_(arg_102_0)
			local var_102_0 = 0
			local var_102_1 = 1.1

			if var_102_0 < arg_99_1.time_ and arg_99_1.time_ <= var_102_0 + arg_102_0 then
				arg_99_1.talkMaxDuration = 0
				arg_99_1.dialogCg_.alpha = 1

				arg_99_1.dialog_:SetActive(true)
				SetActive(arg_99_1.leftNameGo_, false)

				arg_99_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_99_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_99_1:RecordName(arg_99_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_99_1.iconTrs_.gameObject, false)
				arg_99_1.callingController_:SetSelectedState("normal")

				local var_102_2 = arg_99_1:GetWordFromCfg(114251024)
				local var_102_3 = arg_99_1:FormatText(var_102_2.content)

				arg_99_1.text_.text = var_102_3

				LuaForUtil.ClearLinePrefixSymbol(arg_99_1.text_)

				local var_102_4 = 43
				local var_102_5 = utf8.len(var_102_3)
				local var_102_6 = var_102_4 <= 0 and var_102_1 or var_102_1 * (var_102_5 / var_102_4)

				if var_102_6 > 0 and var_102_1 < var_102_6 then
					arg_99_1.talkMaxDuration = var_102_6

					if var_102_6 + var_102_0 > arg_99_1.duration_ then
						arg_99_1.duration_ = var_102_6 + var_102_0
					end
				end

				arg_99_1.text_.text = var_102_3
				arg_99_1.typewritter.percent = 0

				arg_99_1.typewritter:SetDirty()
				arg_99_1:ShowNextGo(false)
				arg_99_1:RecordContent(arg_99_1.text_.text)
			end

			local var_102_7 = math.max(var_102_1, arg_99_1.talkMaxDuration)

			if var_102_0 <= arg_99_1.time_ and arg_99_1.time_ < var_102_0 + var_102_7 then
				arg_99_1.typewritter.percent = (arg_99_1.time_ - var_102_0) / var_102_7

				arg_99_1.typewritter:SetDirty()
			end

			if arg_99_1.time_ >= var_102_0 + var_102_7 and arg_99_1.time_ < var_102_0 + var_102_7 + arg_102_0 then
				arg_99_1.typewritter.percent = 1

				arg_99_1.typewritter:SetDirty()
				arg_99_1:ShowNextGo(true)
			end
		end

		arg_99_1.nodeConfigList_ = {}

		arg_99_1:InitPlayNodeList()
	end,
	Play114251025 = function(arg_103_0, arg_103_1)
		arg_103_1.time_ = 0
		arg_103_1.frameCnt_ = 0
		arg_103_1.state_ = "playing"
		arg_103_1.curTalkId_ = 114251025
		arg_103_1.duration_ = 3.5

		local var_103_0 = {
			ja = 1.833,
			ko = 2.866,
			zh = 3.166,
			en = 3.5
		}
		local var_103_1 = manager.audio:GetLocalizationFlag()

		if var_103_0[var_103_1] ~= nil then
			arg_103_1.duration_ = var_103_0[var_103_1]
		end

		SetActive(arg_103_1.tipsGo_, false)

		function arg_103_1.onSingleLineFinish_()
			arg_103_1.onSingleLineUpdate_ = nil
			arg_103_1.onSingleLineFinish_ = nil
			arg_103_1.state_ = "waiting"
		end

		function arg_103_1.playNext_(arg_105_0)
			if arg_105_0 == 1 then
				arg_103_0:Play114251026(arg_103_1)
			end
		end

		function arg_103_1.onSingleLineUpdate_(arg_106_0)
			local var_106_0 = arg_103_1.actors_["10018"]
			local var_106_1 = 0

			if var_106_1 < arg_103_1.time_ and arg_103_1.time_ <= var_106_1 + arg_106_0 and not isNil(var_106_0) and arg_103_1.var_.actorSpriteComps10018 == nil then
				arg_103_1.var_.actorSpriteComps10018 = var_106_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_106_2 = 0.034

			if var_106_1 <= arg_103_1.time_ and arg_103_1.time_ < var_106_1 + var_106_2 and not isNil(var_106_0) then
				local var_106_3 = (arg_103_1.time_ - var_106_1) / var_106_2

				if arg_103_1.var_.actorSpriteComps10018 then
					for iter_106_0, iter_106_1 in pairs(arg_103_1.var_.actorSpriteComps10018:ToTable()) do
						if iter_106_1 then
							if arg_103_1.isInRecall_ then
								local var_106_4 = Mathf.Lerp(iter_106_1.color.r, arg_103_1.hightColor1.r, var_106_3)
								local var_106_5 = Mathf.Lerp(iter_106_1.color.g, arg_103_1.hightColor1.g, var_106_3)
								local var_106_6 = Mathf.Lerp(iter_106_1.color.b, arg_103_1.hightColor1.b, var_106_3)

								iter_106_1.color = Color.New(var_106_4, var_106_5, var_106_6)
							else
								local var_106_7 = Mathf.Lerp(iter_106_1.color.r, 1, var_106_3)

								iter_106_1.color = Color.New(var_106_7, var_106_7, var_106_7)
							end
						end
					end
				end
			end

			if arg_103_1.time_ >= var_106_1 + var_106_2 and arg_103_1.time_ < var_106_1 + var_106_2 + arg_106_0 and not isNil(var_106_0) and arg_103_1.var_.actorSpriteComps10018 then
				for iter_106_2, iter_106_3 in pairs(arg_103_1.var_.actorSpriteComps10018:ToTable()) do
					if iter_106_3 then
						if arg_103_1.isInRecall_ then
							iter_106_3.color = arg_103_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_106_3.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_103_1.var_.actorSpriteComps10018 = nil
			end

			local var_106_8 = 0
			local var_106_9 = 0.275

			if var_106_8 < arg_103_1.time_ and arg_103_1.time_ <= var_106_8 + arg_106_0 then
				arg_103_1.talkMaxDuration = 0
				arg_103_1.dialogCg_.alpha = 1

				arg_103_1.dialog_:SetActive(true)
				SetActive(arg_103_1.leftNameGo_, true)

				local var_106_10 = arg_103_1:FormatText(StoryNameCfg[257].name)

				arg_103_1.leftNameTxt_.text = var_106_10

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_103_1.leftNameTxt_.transform)

				arg_103_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_103_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_103_1:RecordName(arg_103_1.leftNameTxt_.text)
				SetActive(arg_103_1.iconTrs_.gameObject, false)
				arg_103_1.callingController_:SetSelectedState("normal")

				local var_106_11 = arg_103_1:GetWordFromCfg(114251025)
				local var_106_12 = arg_103_1:FormatText(var_106_11.content)

				arg_103_1.text_.text = var_106_12

				LuaForUtil.ClearLinePrefixSymbol(arg_103_1.text_)

				local var_106_13 = 11
				local var_106_14 = utf8.len(var_106_12)
				local var_106_15 = var_106_13 <= 0 and var_106_9 or var_106_9 * (var_106_14 / var_106_13)

				if var_106_15 > 0 and var_106_9 < var_106_15 then
					arg_103_1.talkMaxDuration = var_106_15

					if var_106_15 + var_106_8 > arg_103_1.duration_ then
						arg_103_1.duration_ = var_106_15 + var_106_8
					end
				end

				arg_103_1.text_.text = var_106_12
				arg_103_1.typewritter.percent = 0

				arg_103_1.typewritter:SetDirty()
				arg_103_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_114251", "114251025", "story_v_out_114251.awb") ~= 0 then
					local var_106_16 = manager.audio:GetVoiceLength("story_v_out_114251", "114251025", "story_v_out_114251.awb") / 1000

					if var_106_16 + var_106_8 > arg_103_1.duration_ then
						arg_103_1.duration_ = var_106_16 + var_106_8
					end

					if var_106_11.prefab_name ~= "" and arg_103_1.actors_[var_106_11.prefab_name] ~= nil then
						local var_106_17 = LuaForUtil.PlayVoiceWithCriLipsync(arg_103_1.actors_[var_106_11.prefab_name].transform, "story_v_out_114251", "114251025", "story_v_out_114251.awb")

						arg_103_1:RecordAudio("114251025", var_106_17)
						arg_103_1:RecordAudio("114251025", var_106_17)
					else
						arg_103_1:AudioAction("play", "voice", "story_v_out_114251", "114251025", "story_v_out_114251.awb")
					end

					arg_103_1:RecordHistoryTalkVoice("story_v_out_114251", "114251025", "story_v_out_114251.awb")
				end

				arg_103_1:RecordContent(arg_103_1.text_.text)
			end

			local var_106_18 = math.max(var_106_9, arg_103_1.talkMaxDuration)

			if var_106_8 <= arg_103_1.time_ and arg_103_1.time_ < var_106_8 + var_106_18 then
				arg_103_1.typewritter.percent = (arg_103_1.time_ - var_106_8) / var_106_18

				arg_103_1.typewritter:SetDirty()
			end

			if arg_103_1.time_ >= var_106_8 + var_106_18 and arg_103_1.time_ < var_106_8 + var_106_18 + arg_106_0 then
				arg_103_1.typewritter.percent = 1

				arg_103_1.typewritter:SetDirty()
				arg_103_1:ShowNextGo(true)
			end
		end

		arg_103_1.nodeConfigList_ = {}

		arg_103_1:InitPlayNodeList()
	end,
	Play114251026 = function(arg_107_0, arg_107_1)
		arg_107_1.time_ = 0
		arg_107_1.frameCnt_ = 0
		arg_107_1.state_ = "playing"
		arg_107_1.curTalkId_ = 114251026
		arg_107_1.duration_ = 9.53

		local var_107_0 = {
			ja = 9.533,
			ko = 5.233,
			zh = 5.033,
			en = 3.5
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
				arg_107_0:Play114251027(arg_107_1)
			end
		end

		function arg_107_1.onSingleLineUpdate_(arg_110_0)
			local var_110_0 = arg_107_1.actors_["10018"]
			local var_110_1 = 0

			if var_110_1 < arg_107_1.time_ and arg_107_1.time_ <= var_110_1 + arg_110_0 and not isNil(var_110_0) and arg_107_1.var_.actorSpriteComps10018 == nil then
				arg_107_1.var_.actorSpriteComps10018 = var_110_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_110_2 = 0.034

			if var_110_1 <= arg_107_1.time_ and arg_107_1.time_ < var_110_1 + var_110_2 and not isNil(var_110_0) then
				local var_110_3 = (arg_107_1.time_ - var_110_1) / var_110_2

				if arg_107_1.var_.actorSpriteComps10018 then
					for iter_110_0, iter_110_1 in pairs(arg_107_1.var_.actorSpriteComps10018:ToTable()) do
						if iter_110_1 then
							if arg_107_1.isInRecall_ then
								local var_110_4 = Mathf.Lerp(iter_110_1.color.r, arg_107_1.hightColor2.r, var_110_3)
								local var_110_5 = Mathf.Lerp(iter_110_1.color.g, arg_107_1.hightColor2.g, var_110_3)
								local var_110_6 = Mathf.Lerp(iter_110_1.color.b, arg_107_1.hightColor2.b, var_110_3)

								iter_110_1.color = Color.New(var_110_4, var_110_5, var_110_6)
							else
								local var_110_7 = Mathf.Lerp(iter_110_1.color.r, 0.5, var_110_3)

								iter_110_1.color = Color.New(var_110_7, var_110_7, var_110_7)
							end
						end
					end
				end
			end

			if arg_107_1.time_ >= var_110_1 + var_110_2 and arg_107_1.time_ < var_110_1 + var_110_2 + arg_110_0 and not isNil(var_110_0) and arg_107_1.var_.actorSpriteComps10018 then
				for iter_110_2, iter_110_3 in pairs(arg_107_1.var_.actorSpriteComps10018:ToTable()) do
					if iter_110_3 then
						if arg_107_1.isInRecall_ then
							iter_110_3.color = arg_107_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_110_3.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_107_1.var_.actorSpriteComps10018 = nil
			end

			local var_110_8 = arg_107_1.actors_["10015"]
			local var_110_9 = 0

			if var_110_9 < arg_107_1.time_ and arg_107_1.time_ <= var_110_9 + arg_110_0 and not isNil(var_110_8) and arg_107_1.var_.actorSpriteComps10015 == nil then
				arg_107_1.var_.actorSpriteComps10015 = var_110_8:GetComponentsInChildren(typeof(Image), true)
			end

			local var_110_10 = 0.034

			if var_110_9 <= arg_107_1.time_ and arg_107_1.time_ < var_110_9 + var_110_10 and not isNil(var_110_8) then
				local var_110_11 = (arg_107_1.time_ - var_110_9) / var_110_10

				if arg_107_1.var_.actorSpriteComps10015 then
					for iter_110_4, iter_110_5 in pairs(arg_107_1.var_.actorSpriteComps10015:ToTable()) do
						if iter_110_5 then
							if arg_107_1.isInRecall_ then
								local var_110_12 = Mathf.Lerp(iter_110_5.color.r, arg_107_1.hightColor1.r, var_110_11)
								local var_110_13 = Mathf.Lerp(iter_110_5.color.g, arg_107_1.hightColor1.g, var_110_11)
								local var_110_14 = Mathf.Lerp(iter_110_5.color.b, arg_107_1.hightColor1.b, var_110_11)

								iter_110_5.color = Color.New(var_110_12, var_110_13, var_110_14)
							else
								local var_110_15 = Mathf.Lerp(iter_110_5.color.r, 1, var_110_11)

								iter_110_5.color = Color.New(var_110_15, var_110_15, var_110_15)
							end
						end
					end
				end
			end

			if arg_107_1.time_ >= var_110_9 + var_110_10 and arg_107_1.time_ < var_110_9 + var_110_10 + arg_110_0 and not isNil(var_110_8) and arg_107_1.var_.actorSpriteComps10015 then
				for iter_110_6, iter_110_7 in pairs(arg_107_1.var_.actorSpriteComps10015:ToTable()) do
					if iter_110_7 then
						if arg_107_1.isInRecall_ then
							iter_110_7.color = arg_107_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_110_7.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_107_1.var_.actorSpriteComps10015 = nil
			end

			local var_110_16 = 0
			local var_110_17 = 0.45

			if var_110_16 < arg_107_1.time_ and arg_107_1.time_ <= var_110_16 + arg_110_0 then
				arg_107_1.talkMaxDuration = 0
				arg_107_1.dialogCg_.alpha = 1

				arg_107_1.dialog_:SetActive(true)
				SetActive(arg_107_1.leftNameGo_, true)

				local var_110_18 = arg_107_1:FormatText(StoryNameCfg[208].name)

				arg_107_1.leftNameTxt_.text = var_110_18

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_107_1.leftNameTxt_.transform)

				arg_107_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_107_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_107_1:RecordName(arg_107_1.leftNameTxt_.text)
				SetActive(arg_107_1.iconTrs_.gameObject, false)
				arg_107_1.callingController_:SetSelectedState("normal")

				local var_110_19 = arg_107_1:GetWordFromCfg(114251026)
				local var_110_20 = arg_107_1:FormatText(var_110_19.content)

				arg_107_1.text_.text = var_110_20

				LuaForUtil.ClearLinePrefixSymbol(arg_107_1.text_)

				local var_110_21 = 18
				local var_110_22 = utf8.len(var_110_20)
				local var_110_23 = var_110_21 <= 0 and var_110_17 or var_110_17 * (var_110_22 / var_110_21)

				if var_110_23 > 0 and var_110_17 < var_110_23 then
					arg_107_1.talkMaxDuration = var_110_23

					if var_110_23 + var_110_16 > arg_107_1.duration_ then
						arg_107_1.duration_ = var_110_23 + var_110_16
					end
				end

				arg_107_1.text_.text = var_110_20
				arg_107_1.typewritter.percent = 0

				arg_107_1.typewritter:SetDirty()
				arg_107_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_114251", "114251026", "story_v_out_114251.awb") ~= 0 then
					local var_110_24 = manager.audio:GetVoiceLength("story_v_out_114251", "114251026", "story_v_out_114251.awb") / 1000

					if var_110_24 + var_110_16 > arg_107_1.duration_ then
						arg_107_1.duration_ = var_110_24 + var_110_16
					end

					if var_110_19.prefab_name ~= "" and arg_107_1.actors_[var_110_19.prefab_name] ~= nil then
						local var_110_25 = LuaForUtil.PlayVoiceWithCriLipsync(arg_107_1.actors_[var_110_19.prefab_name].transform, "story_v_out_114251", "114251026", "story_v_out_114251.awb")

						arg_107_1:RecordAudio("114251026", var_110_25)
						arg_107_1:RecordAudio("114251026", var_110_25)
					else
						arg_107_1:AudioAction("play", "voice", "story_v_out_114251", "114251026", "story_v_out_114251.awb")
					end

					arg_107_1:RecordHistoryTalkVoice("story_v_out_114251", "114251026", "story_v_out_114251.awb")
				end

				arg_107_1:RecordContent(arg_107_1.text_.text)
			end

			local var_110_26 = math.max(var_110_17, arg_107_1.talkMaxDuration)

			if var_110_16 <= arg_107_1.time_ and arg_107_1.time_ < var_110_16 + var_110_26 then
				arg_107_1.typewritter.percent = (arg_107_1.time_ - var_110_16) / var_110_26

				arg_107_1.typewritter:SetDirty()
			end

			if arg_107_1.time_ >= var_110_16 + var_110_26 and arg_107_1.time_ < var_110_16 + var_110_26 + arg_110_0 then
				arg_107_1.typewritter.percent = 1

				arg_107_1.typewritter:SetDirty()
				arg_107_1:ShowNextGo(true)
			end
		end

		arg_107_1.nodeConfigList_ = {}

		arg_107_1:InitPlayNodeList()
	end,
	Play114251027 = function(arg_111_0, arg_111_1)
		arg_111_1.time_ = 0
		arg_111_1.frameCnt_ = 0
		arg_111_1.state_ = "playing"
		arg_111_1.curTalkId_ = 114251027
		arg_111_1.duration_ = 11.9

		local var_111_0 = {
			ja = 11.366,
			ko = 11.3,
			zh = 11.9,
			en = 11.8
		}
		local var_111_1 = manager.audio:GetLocalizationFlag()

		if var_111_0[var_111_1] ~= nil then
			arg_111_1.duration_ = var_111_0[var_111_1]
		end

		SetActive(arg_111_1.tipsGo_, false)

		function arg_111_1.onSingleLineFinish_()
			arg_111_1.onSingleLineUpdate_ = nil
			arg_111_1.onSingleLineFinish_ = nil
			arg_111_1.state_ = "waiting"
		end

		function arg_111_1.playNext_(arg_113_0)
			if arg_113_0 == 1 then
				arg_111_0:Play114251028(arg_111_1)
			end
		end

		function arg_111_1.onSingleLineUpdate_(arg_114_0)
			local var_114_0 = arg_111_1.actors_["10018"]
			local var_114_1 = 0

			if var_114_1 < arg_111_1.time_ and arg_111_1.time_ <= var_114_1 + arg_114_0 and not isNil(var_114_0) and arg_111_1.var_.actorSpriteComps10018 == nil then
				arg_111_1.var_.actorSpriteComps10018 = var_114_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_114_2 = 0.034

			if var_114_1 <= arg_111_1.time_ and arg_111_1.time_ < var_114_1 + var_114_2 and not isNil(var_114_0) then
				local var_114_3 = (arg_111_1.time_ - var_114_1) / var_114_2

				if arg_111_1.var_.actorSpriteComps10018 then
					for iter_114_0, iter_114_1 in pairs(arg_111_1.var_.actorSpriteComps10018:ToTable()) do
						if iter_114_1 then
							if arg_111_1.isInRecall_ then
								local var_114_4 = Mathf.Lerp(iter_114_1.color.r, arg_111_1.hightColor1.r, var_114_3)
								local var_114_5 = Mathf.Lerp(iter_114_1.color.g, arg_111_1.hightColor1.g, var_114_3)
								local var_114_6 = Mathf.Lerp(iter_114_1.color.b, arg_111_1.hightColor1.b, var_114_3)

								iter_114_1.color = Color.New(var_114_4, var_114_5, var_114_6)
							else
								local var_114_7 = Mathf.Lerp(iter_114_1.color.r, 1, var_114_3)

								iter_114_1.color = Color.New(var_114_7, var_114_7, var_114_7)
							end
						end
					end
				end
			end

			if arg_111_1.time_ >= var_114_1 + var_114_2 and arg_111_1.time_ < var_114_1 + var_114_2 + arg_114_0 and not isNil(var_114_0) and arg_111_1.var_.actorSpriteComps10018 then
				for iter_114_2, iter_114_3 in pairs(arg_111_1.var_.actorSpriteComps10018:ToTable()) do
					if iter_114_3 then
						if arg_111_1.isInRecall_ then
							iter_114_3.color = arg_111_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_114_3.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_111_1.var_.actorSpriteComps10018 = nil
			end

			local var_114_8 = arg_111_1.actors_["10015"]
			local var_114_9 = 0

			if var_114_9 < arg_111_1.time_ and arg_111_1.time_ <= var_114_9 + arg_114_0 and not isNil(var_114_8) and arg_111_1.var_.actorSpriteComps10015 == nil then
				arg_111_1.var_.actorSpriteComps10015 = var_114_8:GetComponentsInChildren(typeof(Image), true)
			end

			local var_114_10 = 0.034

			if var_114_9 <= arg_111_1.time_ and arg_111_1.time_ < var_114_9 + var_114_10 and not isNil(var_114_8) then
				local var_114_11 = (arg_111_1.time_ - var_114_9) / var_114_10

				if arg_111_1.var_.actorSpriteComps10015 then
					for iter_114_4, iter_114_5 in pairs(arg_111_1.var_.actorSpriteComps10015:ToTable()) do
						if iter_114_5 then
							if arg_111_1.isInRecall_ then
								local var_114_12 = Mathf.Lerp(iter_114_5.color.r, arg_111_1.hightColor2.r, var_114_11)
								local var_114_13 = Mathf.Lerp(iter_114_5.color.g, arg_111_1.hightColor2.g, var_114_11)
								local var_114_14 = Mathf.Lerp(iter_114_5.color.b, arg_111_1.hightColor2.b, var_114_11)

								iter_114_5.color = Color.New(var_114_12, var_114_13, var_114_14)
							else
								local var_114_15 = Mathf.Lerp(iter_114_5.color.r, 0.5, var_114_11)

								iter_114_5.color = Color.New(var_114_15, var_114_15, var_114_15)
							end
						end
					end
				end
			end

			if arg_111_1.time_ >= var_114_9 + var_114_10 and arg_111_1.time_ < var_114_9 + var_114_10 + arg_114_0 and not isNil(var_114_8) and arg_111_1.var_.actorSpriteComps10015 then
				for iter_114_6, iter_114_7 in pairs(arg_111_1.var_.actorSpriteComps10015:ToTable()) do
					if iter_114_7 then
						if arg_111_1.isInRecall_ then
							iter_114_7.color = arg_111_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_114_7.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_111_1.var_.actorSpriteComps10015 = nil
			end

			local var_114_16 = 0
			local var_114_17 = 1.15

			if var_114_16 < arg_111_1.time_ and arg_111_1.time_ <= var_114_16 + arg_114_0 then
				arg_111_1.talkMaxDuration = 0
				arg_111_1.dialogCg_.alpha = 1

				arg_111_1.dialog_:SetActive(true)
				SetActive(arg_111_1.leftNameGo_, true)

				local var_114_18 = arg_111_1:FormatText(StoryNameCfg[257].name)

				arg_111_1.leftNameTxt_.text = var_114_18

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_111_1.leftNameTxt_.transform)

				arg_111_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_111_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_111_1:RecordName(arg_111_1.leftNameTxt_.text)
				SetActive(arg_111_1.iconTrs_.gameObject, false)
				arg_111_1.callingController_:SetSelectedState("normal")

				local var_114_19 = arg_111_1:GetWordFromCfg(114251027)
				local var_114_20 = arg_111_1:FormatText(var_114_19.content)

				arg_111_1.text_.text = var_114_20

				LuaForUtil.ClearLinePrefixSymbol(arg_111_1.text_)

				local var_114_21 = 46
				local var_114_22 = utf8.len(var_114_20)
				local var_114_23 = var_114_21 <= 0 and var_114_17 or var_114_17 * (var_114_22 / var_114_21)

				if var_114_23 > 0 and var_114_17 < var_114_23 then
					arg_111_1.talkMaxDuration = var_114_23

					if var_114_23 + var_114_16 > arg_111_1.duration_ then
						arg_111_1.duration_ = var_114_23 + var_114_16
					end
				end

				arg_111_1.text_.text = var_114_20
				arg_111_1.typewritter.percent = 0

				arg_111_1.typewritter:SetDirty()
				arg_111_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_114251", "114251027", "story_v_out_114251.awb") ~= 0 then
					local var_114_24 = manager.audio:GetVoiceLength("story_v_out_114251", "114251027", "story_v_out_114251.awb") / 1000

					if var_114_24 + var_114_16 > arg_111_1.duration_ then
						arg_111_1.duration_ = var_114_24 + var_114_16
					end

					if var_114_19.prefab_name ~= "" and arg_111_1.actors_[var_114_19.prefab_name] ~= nil then
						local var_114_25 = LuaForUtil.PlayVoiceWithCriLipsync(arg_111_1.actors_[var_114_19.prefab_name].transform, "story_v_out_114251", "114251027", "story_v_out_114251.awb")

						arg_111_1:RecordAudio("114251027", var_114_25)
						arg_111_1:RecordAudio("114251027", var_114_25)
					else
						arg_111_1:AudioAction("play", "voice", "story_v_out_114251", "114251027", "story_v_out_114251.awb")
					end

					arg_111_1:RecordHistoryTalkVoice("story_v_out_114251", "114251027", "story_v_out_114251.awb")
				end

				arg_111_1:RecordContent(arg_111_1.text_.text)
			end

			local var_114_26 = math.max(var_114_17, arg_111_1.talkMaxDuration)

			if var_114_16 <= arg_111_1.time_ and arg_111_1.time_ < var_114_16 + var_114_26 then
				arg_111_1.typewritter.percent = (arg_111_1.time_ - var_114_16) / var_114_26

				arg_111_1.typewritter:SetDirty()
			end

			if arg_111_1.time_ >= var_114_16 + var_114_26 and arg_111_1.time_ < var_114_16 + var_114_26 + arg_114_0 then
				arg_111_1.typewritter.percent = 1

				arg_111_1.typewritter:SetDirty()
				arg_111_1:ShowNextGo(true)
			end
		end

		arg_111_1.nodeConfigList_ = {}

		arg_111_1:InitPlayNodeList()
	end,
	Play114251028 = function(arg_115_0, arg_115_1)
		arg_115_1.time_ = 0
		arg_115_1.frameCnt_ = 0
		arg_115_1.state_ = "playing"
		arg_115_1.curTalkId_ = 114251028
		arg_115_1.duration_ = 9.6

		local var_115_0 = {
			ja = 9.6,
			ko = 9.133,
			zh = 9.066,
			en = 9.4
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
				arg_115_0:Play114251029(arg_115_1)
			end
		end

		function arg_115_1.onSingleLineUpdate_(arg_118_0)
			local var_118_0 = 0
			local var_118_1 = 0.975

			if var_118_0 < arg_115_1.time_ and arg_115_1.time_ <= var_118_0 + arg_118_0 then
				arg_115_1.talkMaxDuration = 0
				arg_115_1.dialogCg_.alpha = 1

				arg_115_1.dialog_:SetActive(true)
				SetActive(arg_115_1.leftNameGo_, true)

				local var_118_2 = arg_115_1:FormatText(StoryNameCfg[257].name)

				arg_115_1.leftNameTxt_.text = var_118_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_115_1.leftNameTxt_.transform)

				arg_115_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_115_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_115_1:RecordName(arg_115_1.leftNameTxt_.text)
				SetActive(arg_115_1.iconTrs_.gameObject, false)
				arg_115_1.callingController_:SetSelectedState("normal")

				local var_118_3 = arg_115_1:GetWordFromCfg(114251028)
				local var_118_4 = arg_115_1:FormatText(var_118_3.content)

				arg_115_1.text_.text = var_118_4

				LuaForUtil.ClearLinePrefixSymbol(arg_115_1.text_)

				local var_118_5 = 39
				local var_118_6 = utf8.len(var_118_4)
				local var_118_7 = var_118_5 <= 0 and var_118_1 or var_118_1 * (var_118_6 / var_118_5)

				if var_118_7 > 0 and var_118_1 < var_118_7 then
					arg_115_1.talkMaxDuration = var_118_7

					if var_118_7 + var_118_0 > arg_115_1.duration_ then
						arg_115_1.duration_ = var_118_7 + var_118_0
					end
				end

				arg_115_1.text_.text = var_118_4
				arg_115_1.typewritter.percent = 0

				arg_115_1.typewritter:SetDirty()
				arg_115_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_114251", "114251028", "story_v_out_114251.awb") ~= 0 then
					local var_118_8 = manager.audio:GetVoiceLength("story_v_out_114251", "114251028", "story_v_out_114251.awb") / 1000

					if var_118_8 + var_118_0 > arg_115_1.duration_ then
						arg_115_1.duration_ = var_118_8 + var_118_0
					end

					if var_118_3.prefab_name ~= "" and arg_115_1.actors_[var_118_3.prefab_name] ~= nil then
						local var_118_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_115_1.actors_[var_118_3.prefab_name].transform, "story_v_out_114251", "114251028", "story_v_out_114251.awb")

						arg_115_1:RecordAudio("114251028", var_118_9)
						arg_115_1:RecordAudio("114251028", var_118_9)
					else
						arg_115_1:AudioAction("play", "voice", "story_v_out_114251", "114251028", "story_v_out_114251.awb")
					end

					arg_115_1:RecordHistoryTalkVoice("story_v_out_114251", "114251028", "story_v_out_114251.awb")
				end

				arg_115_1:RecordContent(arg_115_1.text_.text)
			end

			local var_118_10 = math.max(var_118_1, arg_115_1.talkMaxDuration)

			if var_118_0 <= arg_115_1.time_ and arg_115_1.time_ < var_118_0 + var_118_10 then
				arg_115_1.typewritter.percent = (arg_115_1.time_ - var_118_0) / var_118_10

				arg_115_1.typewritter:SetDirty()
			end

			if arg_115_1.time_ >= var_118_0 + var_118_10 and arg_115_1.time_ < var_118_0 + var_118_10 + arg_118_0 then
				arg_115_1.typewritter.percent = 1

				arg_115_1.typewritter:SetDirty()
				arg_115_1:ShowNextGo(true)
			end
		end

		arg_115_1.nodeConfigList_ = {}

		arg_115_1:InitPlayNodeList()
	end,
	Play114251029 = function(arg_119_0, arg_119_1)
		arg_119_1.time_ = 0
		arg_119_1.frameCnt_ = 0
		arg_119_1.state_ = "playing"
		arg_119_1.curTalkId_ = 114251029
		arg_119_1.duration_ = 4.73

		local var_119_0 = {
			ja = 4.233,
			ko = 3.966,
			zh = 4.1,
			en = 4.733
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
				arg_119_0:Play114251030(arg_119_1)
			end
		end

		function arg_119_1.onSingleLineUpdate_(arg_122_0)
			local var_122_0 = arg_119_1.actors_["10015"]
			local var_122_1 = 0

			if var_122_1 < arg_119_1.time_ and arg_119_1.time_ <= var_122_1 + arg_122_0 and not isNil(var_122_0) and arg_119_1.var_.actorSpriteComps10015 == nil then
				arg_119_1.var_.actorSpriteComps10015 = var_122_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_122_2 = 0.034

			if var_122_1 <= arg_119_1.time_ and arg_119_1.time_ < var_122_1 + var_122_2 and not isNil(var_122_0) then
				local var_122_3 = (arg_119_1.time_ - var_122_1) / var_122_2

				if arg_119_1.var_.actorSpriteComps10015 then
					for iter_122_0, iter_122_1 in pairs(arg_119_1.var_.actorSpriteComps10015:ToTable()) do
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

			if arg_119_1.time_ >= var_122_1 + var_122_2 and arg_119_1.time_ < var_122_1 + var_122_2 + arg_122_0 and not isNil(var_122_0) and arg_119_1.var_.actorSpriteComps10015 then
				for iter_122_2, iter_122_3 in pairs(arg_119_1.var_.actorSpriteComps10015:ToTable()) do
					if iter_122_3 then
						if arg_119_1.isInRecall_ then
							iter_122_3.color = arg_119_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_122_3.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_119_1.var_.actorSpriteComps10015 = nil
			end

			local var_122_8 = arg_119_1.actors_["10018"]
			local var_122_9 = 0

			if var_122_9 < arg_119_1.time_ and arg_119_1.time_ <= var_122_9 + arg_122_0 and not isNil(var_122_8) and arg_119_1.var_.actorSpriteComps10018 == nil then
				arg_119_1.var_.actorSpriteComps10018 = var_122_8:GetComponentsInChildren(typeof(Image), true)
			end

			local var_122_10 = 0.034

			if var_122_9 <= arg_119_1.time_ and arg_119_1.time_ < var_122_9 + var_122_10 and not isNil(var_122_8) then
				local var_122_11 = (arg_119_1.time_ - var_122_9) / var_122_10

				if arg_119_1.var_.actorSpriteComps10018 then
					for iter_122_4, iter_122_5 in pairs(arg_119_1.var_.actorSpriteComps10018:ToTable()) do
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

			if arg_119_1.time_ >= var_122_9 + var_122_10 and arg_119_1.time_ < var_122_9 + var_122_10 + arg_122_0 and not isNil(var_122_8) and arg_119_1.var_.actorSpriteComps10018 then
				for iter_122_6, iter_122_7 in pairs(arg_119_1.var_.actorSpriteComps10018:ToTable()) do
					if iter_122_7 then
						if arg_119_1.isInRecall_ then
							iter_122_7.color = arg_119_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_122_7.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_119_1.var_.actorSpriteComps10018 = nil
			end

			local var_122_16 = 0
			local var_122_17 = 0.475

			if var_122_16 < arg_119_1.time_ and arg_119_1.time_ <= var_122_16 + arg_122_0 then
				arg_119_1.talkMaxDuration = 0
				arg_119_1.dialogCg_.alpha = 1

				arg_119_1.dialog_:SetActive(true)
				SetActive(arg_119_1.leftNameGo_, true)

				local var_122_18 = arg_119_1:FormatText(StoryNameCfg[208].name)

				arg_119_1.leftNameTxt_.text = var_122_18

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_119_1.leftNameTxt_.transform)

				arg_119_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_119_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_119_1:RecordName(arg_119_1.leftNameTxt_.text)
				SetActive(arg_119_1.iconTrs_.gameObject, false)
				arg_119_1.callingController_:SetSelectedState("normal")

				local var_122_19 = arg_119_1:GetWordFromCfg(114251029)
				local var_122_20 = arg_119_1:FormatText(var_122_19.content)

				arg_119_1.text_.text = var_122_20

				LuaForUtil.ClearLinePrefixSymbol(arg_119_1.text_)

				local var_122_21 = 19
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

				if manager.audio:GetVoiceLength("story_v_out_114251", "114251029", "story_v_out_114251.awb") ~= 0 then
					local var_122_24 = manager.audio:GetVoiceLength("story_v_out_114251", "114251029", "story_v_out_114251.awb") / 1000

					if var_122_24 + var_122_16 > arg_119_1.duration_ then
						arg_119_1.duration_ = var_122_24 + var_122_16
					end

					if var_122_19.prefab_name ~= "" and arg_119_1.actors_[var_122_19.prefab_name] ~= nil then
						local var_122_25 = LuaForUtil.PlayVoiceWithCriLipsync(arg_119_1.actors_[var_122_19.prefab_name].transform, "story_v_out_114251", "114251029", "story_v_out_114251.awb")

						arg_119_1:RecordAudio("114251029", var_122_25)
						arg_119_1:RecordAudio("114251029", var_122_25)
					else
						arg_119_1:AudioAction("play", "voice", "story_v_out_114251", "114251029", "story_v_out_114251.awb")
					end

					arg_119_1:RecordHistoryTalkVoice("story_v_out_114251", "114251029", "story_v_out_114251.awb")
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
	Play114251030 = function(arg_123_0, arg_123_1)
		arg_123_1.time_ = 0
		arg_123_1.frameCnt_ = 0
		arg_123_1.state_ = "playing"
		arg_123_1.curTalkId_ = 114251030
		arg_123_1.duration_ = 4.7

		local var_123_0 = {
			ja = 4.7,
			ko = 3.566,
			zh = 3.833,
			en = 3.733
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
				arg_123_0:Play114251031(arg_123_1)
			end
		end

		function arg_123_1.onSingleLineUpdate_(arg_126_0)
			local var_126_0 = arg_123_1.actors_["10018"]
			local var_126_1 = 0

			if var_126_1 < arg_123_1.time_ and arg_123_1.time_ <= var_126_1 + arg_126_0 and not isNil(var_126_0) and arg_123_1.var_.actorSpriteComps10018 == nil then
				arg_123_1.var_.actorSpriteComps10018 = var_126_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_126_2 = 0.034

			if var_126_1 <= arg_123_1.time_ and arg_123_1.time_ < var_126_1 + var_126_2 and not isNil(var_126_0) then
				local var_126_3 = (arg_123_1.time_ - var_126_1) / var_126_2

				if arg_123_1.var_.actorSpriteComps10018 then
					for iter_126_0, iter_126_1 in pairs(arg_123_1.var_.actorSpriteComps10018:ToTable()) do
						if iter_126_1 then
							if arg_123_1.isInRecall_ then
								local var_126_4 = Mathf.Lerp(iter_126_1.color.r, arg_123_1.hightColor1.r, var_126_3)
								local var_126_5 = Mathf.Lerp(iter_126_1.color.g, arg_123_1.hightColor1.g, var_126_3)
								local var_126_6 = Mathf.Lerp(iter_126_1.color.b, arg_123_1.hightColor1.b, var_126_3)

								iter_126_1.color = Color.New(var_126_4, var_126_5, var_126_6)
							else
								local var_126_7 = Mathf.Lerp(iter_126_1.color.r, 1, var_126_3)

								iter_126_1.color = Color.New(var_126_7, var_126_7, var_126_7)
							end
						end
					end
				end
			end

			if arg_123_1.time_ >= var_126_1 + var_126_2 and arg_123_1.time_ < var_126_1 + var_126_2 + arg_126_0 and not isNil(var_126_0) and arg_123_1.var_.actorSpriteComps10018 then
				for iter_126_2, iter_126_3 in pairs(arg_123_1.var_.actorSpriteComps10018:ToTable()) do
					if iter_126_3 then
						if arg_123_1.isInRecall_ then
							iter_126_3.color = arg_123_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_126_3.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_123_1.var_.actorSpriteComps10018 = nil
			end

			local var_126_8 = arg_123_1.actors_["10015"]
			local var_126_9 = 0

			if var_126_9 < arg_123_1.time_ and arg_123_1.time_ <= var_126_9 + arg_126_0 and not isNil(var_126_8) and arg_123_1.var_.actorSpriteComps10015 == nil then
				arg_123_1.var_.actorSpriteComps10015 = var_126_8:GetComponentsInChildren(typeof(Image), true)
			end

			local var_126_10 = 0.034

			if var_126_9 <= arg_123_1.time_ and arg_123_1.time_ < var_126_9 + var_126_10 and not isNil(var_126_8) then
				local var_126_11 = (arg_123_1.time_ - var_126_9) / var_126_10

				if arg_123_1.var_.actorSpriteComps10015 then
					for iter_126_4, iter_126_5 in pairs(arg_123_1.var_.actorSpriteComps10015:ToTable()) do
						if iter_126_5 then
							if arg_123_1.isInRecall_ then
								local var_126_12 = Mathf.Lerp(iter_126_5.color.r, arg_123_1.hightColor2.r, var_126_11)
								local var_126_13 = Mathf.Lerp(iter_126_5.color.g, arg_123_1.hightColor2.g, var_126_11)
								local var_126_14 = Mathf.Lerp(iter_126_5.color.b, arg_123_1.hightColor2.b, var_126_11)

								iter_126_5.color = Color.New(var_126_12, var_126_13, var_126_14)
							else
								local var_126_15 = Mathf.Lerp(iter_126_5.color.r, 0.5, var_126_11)

								iter_126_5.color = Color.New(var_126_15, var_126_15, var_126_15)
							end
						end
					end
				end
			end

			if arg_123_1.time_ >= var_126_9 + var_126_10 and arg_123_1.time_ < var_126_9 + var_126_10 + arg_126_0 and not isNil(var_126_8) and arg_123_1.var_.actorSpriteComps10015 then
				for iter_126_6, iter_126_7 in pairs(arg_123_1.var_.actorSpriteComps10015:ToTable()) do
					if iter_126_7 then
						if arg_123_1.isInRecall_ then
							iter_126_7.color = arg_123_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_126_7.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_123_1.var_.actorSpriteComps10015 = nil
			end

			local var_126_16 = 0
			local var_126_17 = 0.375

			if var_126_16 < arg_123_1.time_ and arg_123_1.time_ <= var_126_16 + arg_126_0 then
				arg_123_1.talkMaxDuration = 0
				arg_123_1.dialogCg_.alpha = 1

				arg_123_1.dialog_:SetActive(true)
				SetActive(arg_123_1.leftNameGo_, true)

				local var_126_18 = arg_123_1:FormatText(StoryNameCfg[257].name)

				arg_123_1.leftNameTxt_.text = var_126_18

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_123_1.leftNameTxt_.transform)

				arg_123_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_123_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_123_1:RecordName(arg_123_1.leftNameTxt_.text)
				SetActive(arg_123_1.iconTrs_.gameObject, false)
				arg_123_1.callingController_:SetSelectedState("normal")

				local var_126_19 = arg_123_1:GetWordFromCfg(114251030)
				local var_126_20 = arg_123_1:FormatText(var_126_19.content)

				arg_123_1.text_.text = var_126_20

				LuaForUtil.ClearLinePrefixSymbol(arg_123_1.text_)

				local var_126_21 = 15
				local var_126_22 = utf8.len(var_126_20)
				local var_126_23 = var_126_21 <= 0 and var_126_17 or var_126_17 * (var_126_22 / var_126_21)

				if var_126_23 > 0 and var_126_17 < var_126_23 then
					arg_123_1.talkMaxDuration = var_126_23

					if var_126_23 + var_126_16 > arg_123_1.duration_ then
						arg_123_1.duration_ = var_126_23 + var_126_16
					end
				end

				arg_123_1.text_.text = var_126_20
				arg_123_1.typewritter.percent = 0

				arg_123_1.typewritter:SetDirty()
				arg_123_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_114251", "114251030", "story_v_out_114251.awb") ~= 0 then
					local var_126_24 = manager.audio:GetVoiceLength("story_v_out_114251", "114251030", "story_v_out_114251.awb") / 1000

					if var_126_24 + var_126_16 > arg_123_1.duration_ then
						arg_123_1.duration_ = var_126_24 + var_126_16
					end

					if var_126_19.prefab_name ~= "" and arg_123_1.actors_[var_126_19.prefab_name] ~= nil then
						local var_126_25 = LuaForUtil.PlayVoiceWithCriLipsync(arg_123_1.actors_[var_126_19.prefab_name].transform, "story_v_out_114251", "114251030", "story_v_out_114251.awb")

						arg_123_1:RecordAudio("114251030", var_126_25)
						arg_123_1:RecordAudio("114251030", var_126_25)
					else
						arg_123_1:AudioAction("play", "voice", "story_v_out_114251", "114251030", "story_v_out_114251.awb")
					end

					arg_123_1:RecordHistoryTalkVoice("story_v_out_114251", "114251030", "story_v_out_114251.awb")
				end

				arg_123_1:RecordContent(arg_123_1.text_.text)
			end

			local var_126_26 = math.max(var_126_17, arg_123_1.talkMaxDuration)

			if var_126_16 <= arg_123_1.time_ and arg_123_1.time_ < var_126_16 + var_126_26 then
				arg_123_1.typewritter.percent = (arg_123_1.time_ - var_126_16) / var_126_26

				arg_123_1.typewritter:SetDirty()
			end

			if arg_123_1.time_ >= var_126_16 + var_126_26 and arg_123_1.time_ < var_126_16 + var_126_26 + arg_126_0 then
				arg_123_1.typewritter.percent = 1

				arg_123_1.typewritter:SetDirty()
				arg_123_1:ShowNextGo(true)
			end
		end

		arg_123_1.nodeConfigList_ = {}

		arg_123_1:InitPlayNodeList()
	end,
	Play114251031 = function(arg_127_0, arg_127_1)
		arg_127_1.time_ = 0
		arg_127_1.frameCnt_ = 0
		arg_127_1.state_ = "playing"
		arg_127_1.curTalkId_ = 114251031
		arg_127_1.duration_ = 2.87

		local var_127_0 = {
			ja = 2.866,
			ko = 1.633,
			zh = 2.333,
			en = 1.833
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
				arg_127_0:Play114251032(arg_127_1)
			end
		end

		function arg_127_1.onSingleLineUpdate_(arg_130_0)
			local var_130_0 = arg_127_1.actors_["10015"].transform
			local var_130_1 = 0

			if var_130_1 < arg_127_1.time_ and arg_127_1.time_ <= var_130_1 + arg_130_0 then
				arg_127_1.var_.moveOldPos10015 = var_130_0.localPosition
				var_130_0.localScale = Vector3.New(1, 1, 1)

				arg_127_1:CheckSpriteTmpPos("10015", 4)

				local var_130_2 = var_130_0.childCount

				for iter_130_0 = 0, var_130_2 - 1 do
					local var_130_3 = var_130_0:GetChild(iter_130_0)

					if var_130_3.name == "split_1" or not string.find(var_130_3.name, "split") then
						var_130_3.gameObject:SetActive(true)
					else
						var_130_3.gameObject:SetActive(false)
					end
				end
			end

			local var_130_4 = 0.001

			if var_130_1 <= arg_127_1.time_ and arg_127_1.time_ < var_130_1 + var_130_4 then
				local var_130_5 = (arg_127_1.time_ - var_130_1) / var_130_4
				local var_130_6 = Vector3.New(390, -350, -180)

				var_130_0.localPosition = Vector3.Lerp(arg_127_1.var_.moveOldPos10015, var_130_6, var_130_5)
			end

			if arg_127_1.time_ >= var_130_1 + var_130_4 and arg_127_1.time_ < var_130_1 + var_130_4 + arg_130_0 then
				var_130_0.localPosition = Vector3.New(390, -350, -180)
			end

			local var_130_7 = arg_127_1.actors_["10018"]
			local var_130_8 = 0

			if var_130_8 < arg_127_1.time_ and arg_127_1.time_ <= var_130_8 + arg_130_0 and not isNil(var_130_7) and arg_127_1.var_.actorSpriteComps10018 == nil then
				arg_127_1.var_.actorSpriteComps10018 = var_130_7:GetComponentsInChildren(typeof(Image), true)
			end

			local var_130_9 = 0.034

			if var_130_8 <= arg_127_1.time_ and arg_127_1.time_ < var_130_8 + var_130_9 and not isNil(var_130_7) then
				local var_130_10 = (arg_127_1.time_ - var_130_8) / var_130_9

				if arg_127_1.var_.actorSpriteComps10018 then
					for iter_130_1, iter_130_2 in pairs(arg_127_1.var_.actorSpriteComps10018:ToTable()) do
						if iter_130_2 then
							if arg_127_1.isInRecall_ then
								local var_130_11 = Mathf.Lerp(iter_130_2.color.r, arg_127_1.hightColor2.r, var_130_10)
								local var_130_12 = Mathf.Lerp(iter_130_2.color.g, arg_127_1.hightColor2.g, var_130_10)
								local var_130_13 = Mathf.Lerp(iter_130_2.color.b, arg_127_1.hightColor2.b, var_130_10)

								iter_130_2.color = Color.New(var_130_11, var_130_12, var_130_13)
							else
								local var_130_14 = Mathf.Lerp(iter_130_2.color.r, 0.5, var_130_10)

								iter_130_2.color = Color.New(var_130_14, var_130_14, var_130_14)
							end
						end
					end
				end
			end

			if arg_127_1.time_ >= var_130_8 + var_130_9 and arg_127_1.time_ < var_130_8 + var_130_9 + arg_130_0 and not isNil(var_130_7) and arg_127_1.var_.actorSpriteComps10018 then
				for iter_130_3, iter_130_4 in pairs(arg_127_1.var_.actorSpriteComps10018:ToTable()) do
					if iter_130_4 then
						if arg_127_1.isInRecall_ then
							iter_130_4.color = arg_127_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_130_4.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_127_1.var_.actorSpriteComps10018 = nil
			end

			local var_130_15 = arg_127_1.actors_["10015"]
			local var_130_16 = 0

			if var_130_16 < arg_127_1.time_ and arg_127_1.time_ <= var_130_16 + arg_130_0 and not isNil(var_130_15) and arg_127_1.var_.actorSpriteComps10015 == nil then
				arg_127_1.var_.actorSpriteComps10015 = var_130_15:GetComponentsInChildren(typeof(Image), true)
			end

			local var_130_17 = 0.034

			if var_130_16 <= arg_127_1.time_ and arg_127_1.time_ < var_130_16 + var_130_17 and not isNil(var_130_15) then
				local var_130_18 = (arg_127_1.time_ - var_130_16) / var_130_17

				if arg_127_1.var_.actorSpriteComps10015 then
					for iter_130_5, iter_130_6 in pairs(arg_127_1.var_.actorSpriteComps10015:ToTable()) do
						if iter_130_6 then
							if arg_127_1.isInRecall_ then
								local var_130_19 = Mathf.Lerp(iter_130_6.color.r, arg_127_1.hightColor1.r, var_130_18)
								local var_130_20 = Mathf.Lerp(iter_130_6.color.g, arg_127_1.hightColor1.g, var_130_18)
								local var_130_21 = Mathf.Lerp(iter_130_6.color.b, arg_127_1.hightColor1.b, var_130_18)

								iter_130_6.color = Color.New(var_130_19, var_130_20, var_130_21)
							else
								local var_130_22 = Mathf.Lerp(iter_130_6.color.r, 1, var_130_18)

								iter_130_6.color = Color.New(var_130_22, var_130_22, var_130_22)
							end
						end
					end
				end
			end

			if arg_127_1.time_ >= var_130_16 + var_130_17 and arg_127_1.time_ < var_130_16 + var_130_17 + arg_130_0 and not isNil(var_130_15) and arg_127_1.var_.actorSpriteComps10015 then
				for iter_130_7, iter_130_8 in pairs(arg_127_1.var_.actorSpriteComps10015:ToTable()) do
					if iter_130_8 then
						if arg_127_1.isInRecall_ then
							iter_130_8.color = arg_127_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_130_8.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_127_1.var_.actorSpriteComps10015 = nil
			end

			local var_130_23 = 0
			local var_130_24 = 0.225

			if var_130_23 < arg_127_1.time_ and arg_127_1.time_ <= var_130_23 + arg_130_0 then
				arg_127_1.talkMaxDuration = 0
				arg_127_1.dialogCg_.alpha = 1

				arg_127_1.dialog_:SetActive(true)
				SetActive(arg_127_1.leftNameGo_, true)

				local var_130_25 = arg_127_1:FormatText(StoryNameCfg[208].name)

				arg_127_1.leftNameTxt_.text = var_130_25

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_127_1.leftNameTxt_.transform)

				arg_127_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_127_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_127_1:RecordName(arg_127_1.leftNameTxt_.text)
				SetActive(arg_127_1.iconTrs_.gameObject, false)
				arg_127_1.callingController_:SetSelectedState("normal")

				local var_130_26 = arg_127_1:GetWordFromCfg(114251031)
				local var_130_27 = arg_127_1:FormatText(var_130_26.content)

				arg_127_1.text_.text = var_130_27

				LuaForUtil.ClearLinePrefixSymbol(arg_127_1.text_)

				local var_130_28 = 9
				local var_130_29 = utf8.len(var_130_27)
				local var_130_30 = var_130_28 <= 0 and var_130_24 or var_130_24 * (var_130_29 / var_130_28)

				if var_130_30 > 0 and var_130_24 < var_130_30 then
					arg_127_1.talkMaxDuration = var_130_30

					if var_130_30 + var_130_23 > arg_127_1.duration_ then
						arg_127_1.duration_ = var_130_30 + var_130_23
					end
				end

				arg_127_1.text_.text = var_130_27
				arg_127_1.typewritter.percent = 0

				arg_127_1.typewritter:SetDirty()
				arg_127_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_114251", "114251031", "story_v_out_114251.awb") ~= 0 then
					local var_130_31 = manager.audio:GetVoiceLength("story_v_out_114251", "114251031", "story_v_out_114251.awb") / 1000

					if var_130_31 + var_130_23 > arg_127_1.duration_ then
						arg_127_1.duration_ = var_130_31 + var_130_23
					end

					if var_130_26.prefab_name ~= "" and arg_127_1.actors_[var_130_26.prefab_name] ~= nil then
						local var_130_32 = LuaForUtil.PlayVoiceWithCriLipsync(arg_127_1.actors_[var_130_26.prefab_name].transform, "story_v_out_114251", "114251031", "story_v_out_114251.awb")

						arg_127_1:RecordAudio("114251031", var_130_32)
						arg_127_1:RecordAudio("114251031", var_130_32)
					else
						arg_127_1:AudioAction("play", "voice", "story_v_out_114251", "114251031", "story_v_out_114251.awb")
					end

					arg_127_1:RecordHistoryTalkVoice("story_v_out_114251", "114251031", "story_v_out_114251.awb")
				end

				arg_127_1:RecordContent(arg_127_1.text_.text)
			end

			local var_130_33 = math.max(var_130_24, arg_127_1.talkMaxDuration)

			if var_130_23 <= arg_127_1.time_ and arg_127_1.time_ < var_130_23 + var_130_33 then
				arg_127_1.typewritter.percent = (arg_127_1.time_ - var_130_23) / var_130_33

				arg_127_1.typewritter:SetDirty()
			end

			if arg_127_1.time_ >= var_130_23 + var_130_33 and arg_127_1.time_ < var_130_23 + var_130_33 + arg_130_0 then
				arg_127_1.typewritter.percent = 1

				arg_127_1.typewritter:SetDirty()
				arg_127_1:ShowNextGo(true)
			end
		end

		arg_127_1.nodeConfigList_ = {
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

		arg_127_1:InitPlayNodeList()
	end,
	Play114251032 = function(arg_131_0, arg_131_1)
		arg_131_1.time_ = 0
		arg_131_1.frameCnt_ = 0
		arg_131_1.state_ = "playing"
		arg_131_1.curTalkId_ = 114251032
		arg_131_1.duration_ = 5

		SetActive(arg_131_1.tipsGo_, false)

		function arg_131_1.onSingleLineFinish_()
			arg_131_1.onSingleLineUpdate_ = nil
			arg_131_1.onSingleLineFinish_ = nil
			arg_131_1.state_ = "waiting"
		end

		function arg_131_1.playNext_(arg_133_0)
			if arg_133_0 == 1 then
				arg_131_0:Play114251033(arg_131_1)
			end
		end

		function arg_131_1.onSingleLineUpdate_(arg_134_0)
			local var_134_0 = arg_131_1.actors_["10015"]
			local var_134_1 = 0

			if var_134_1 < arg_131_1.time_ and arg_131_1.time_ <= var_134_1 + arg_134_0 and not isNil(var_134_0) and arg_131_1.var_.actorSpriteComps10015 == nil then
				arg_131_1.var_.actorSpriteComps10015 = var_134_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_134_2 = 0.034

			if var_134_1 <= arg_131_1.time_ and arg_131_1.time_ < var_134_1 + var_134_2 and not isNil(var_134_0) then
				local var_134_3 = (arg_131_1.time_ - var_134_1) / var_134_2

				if arg_131_1.var_.actorSpriteComps10015 then
					for iter_134_0, iter_134_1 in pairs(arg_131_1.var_.actorSpriteComps10015:ToTable()) do
						if iter_134_1 then
							if arg_131_1.isInRecall_ then
								local var_134_4 = Mathf.Lerp(iter_134_1.color.r, arg_131_1.hightColor2.r, var_134_3)
								local var_134_5 = Mathf.Lerp(iter_134_1.color.g, arg_131_1.hightColor2.g, var_134_3)
								local var_134_6 = Mathf.Lerp(iter_134_1.color.b, arg_131_1.hightColor2.b, var_134_3)

								iter_134_1.color = Color.New(var_134_4, var_134_5, var_134_6)
							else
								local var_134_7 = Mathf.Lerp(iter_134_1.color.r, 0.5, var_134_3)

								iter_134_1.color = Color.New(var_134_7, var_134_7, var_134_7)
							end
						end
					end
				end
			end

			if arg_131_1.time_ >= var_134_1 + var_134_2 and arg_131_1.time_ < var_134_1 + var_134_2 + arg_134_0 and not isNil(var_134_0) and arg_131_1.var_.actorSpriteComps10015 then
				for iter_134_2, iter_134_3 in pairs(arg_131_1.var_.actorSpriteComps10015:ToTable()) do
					if iter_134_3 then
						if arg_131_1.isInRecall_ then
							iter_134_3.color = arg_131_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_134_3.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_131_1.var_.actorSpriteComps10015 = nil
			end

			local var_134_8 = 0
			local var_134_9 = 0.4

			if var_134_8 < arg_131_1.time_ and arg_131_1.time_ <= var_134_8 + arg_134_0 then
				arg_131_1.talkMaxDuration = 0
				arg_131_1.dialogCg_.alpha = 1

				arg_131_1.dialog_:SetActive(true)
				SetActive(arg_131_1.leftNameGo_, false)

				arg_131_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_131_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_131_1:RecordName(arg_131_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_131_1.iconTrs_.gameObject, false)
				arg_131_1.callingController_:SetSelectedState("normal")

				local var_134_10 = arg_131_1:GetWordFromCfg(114251032)
				local var_134_11 = arg_131_1:FormatText(var_134_10.content)

				arg_131_1.text_.text = var_134_11

				LuaForUtil.ClearLinePrefixSymbol(arg_131_1.text_)

				local var_134_12 = 16
				local var_134_13 = utf8.len(var_134_11)
				local var_134_14 = var_134_12 <= 0 and var_134_9 or var_134_9 * (var_134_13 / var_134_12)

				if var_134_14 > 0 and var_134_9 < var_134_14 then
					arg_131_1.talkMaxDuration = var_134_14

					if var_134_14 + var_134_8 > arg_131_1.duration_ then
						arg_131_1.duration_ = var_134_14 + var_134_8
					end
				end

				arg_131_1.text_.text = var_134_11
				arg_131_1.typewritter.percent = 0

				arg_131_1.typewritter:SetDirty()
				arg_131_1:ShowNextGo(false)
				arg_131_1:RecordContent(arg_131_1.text_.text)
			end

			local var_134_15 = math.max(var_134_9, arg_131_1.talkMaxDuration)

			if var_134_8 <= arg_131_1.time_ and arg_131_1.time_ < var_134_8 + var_134_15 then
				arg_131_1.typewritter.percent = (arg_131_1.time_ - var_134_8) / var_134_15

				arg_131_1.typewritter:SetDirty()
			end

			if arg_131_1.time_ >= var_134_8 + var_134_15 and arg_131_1.time_ < var_134_8 + var_134_15 + arg_134_0 then
				arg_131_1.typewritter.percent = 1

				arg_131_1.typewritter:SetDirty()
				arg_131_1:ShowNextGo(true)
			end
		end

		arg_131_1.nodeConfigList_ = {}

		arg_131_1:InitPlayNodeList()
	end,
	Play114251033 = function(arg_135_0, arg_135_1)
		arg_135_1.time_ = 0
		arg_135_1.frameCnt_ = 0
		arg_135_1.state_ = "playing"
		arg_135_1.curTalkId_ = 114251033
		arg_135_1.duration_ = 12.73

		local var_135_0 = {
			ja = 12.166,
			ko = 11.8,
			zh = 11.433,
			en = 12.733
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
				arg_135_0:Play114251034(arg_135_1)
			end
		end

		function arg_135_1.onSingleLineUpdate_(arg_138_0)
			local var_138_0 = arg_135_1.actors_["10018"].transform
			local var_138_1 = 0

			if var_138_1 < arg_135_1.time_ and arg_135_1.time_ <= var_138_1 + arg_138_0 then
				arg_135_1.var_.moveOldPos10018 = var_138_0.localPosition
				var_138_0.localScale = Vector3.New(1, 1, 1)

				arg_135_1:CheckSpriteTmpPos("10018", 2)

				local var_138_2 = var_138_0.childCount

				for iter_138_0 = 0, var_138_2 - 1 do
					local var_138_3 = var_138_0:GetChild(iter_138_0)

					if var_138_3.name == "split_2" or not string.find(var_138_3.name, "split") then
						var_138_3.gameObject:SetActive(true)
					else
						var_138_3.gameObject:SetActive(false)
					end
				end
			end

			local var_138_4 = 0.001

			if var_138_1 <= arg_135_1.time_ and arg_135_1.time_ < var_138_1 + var_138_4 then
				local var_138_5 = (arg_135_1.time_ - var_138_1) / var_138_4
				local var_138_6 = Vector3.New(-390, -350, -180)

				var_138_0.localPosition = Vector3.Lerp(arg_135_1.var_.moveOldPos10018, var_138_6, var_138_5)
			end

			if arg_135_1.time_ >= var_138_1 + var_138_4 and arg_135_1.time_ < var_138_1 + var_138_4 + arg_138_0 then
				var_138_0.localPosition = Vector3.New(-390, -350, -180)
			end

			local var_138_7 = arg_135_1.actors_["10018"]
			local var_138_8 = 0

			if var_138_8 < arg_135_1.time_ and arg_135_1.time_ <= var_138_8 + arg_138_0 and not isNil(var_138_7) and arg_135_1.var_.actorSpriteComps10018 == nil then
				arg_135_1.var_.actorSpriteComps10018 = var_138_7:GetComponentsInChildren(typeof(Image), true)
			end

			local var_138_9 = 0.034

			if var_138_8 <= arg_135_1.time_ and arg_135_1.time_ < var_138_8 + var_138_9 and not isNil(var_138_7) then
				local var_138_10 = (arg_135_1.time_ - var_138_8) / var_138_9

				if arg_135_1.var_.actorSpriteComps10018 then
					for iter_138_1, iter_138_2 in pairs(arg_135_1.var_.actorSpriteComps10018:ToTable()) do
						if iter_138_2 then
							if arg_135_1.isInRecall_ then
								local var_138_11 = Mathf.Lerp(iter_138_2.color.r, arg_135_1.hightColor1.r, var_138_10)
								local var_138_12 = Mathf.Lerp(iter_138_2.color.g, arg_135_1.hightColor1.g, var_138_10)
								local var_138_13 = Mathf.Lerp(iter_138_2.color.b, arg_135_1.hightColor1.b, var_138_10)

								iter_138_2.color = Color.New(var_138_11, var_138_12, var_138_13)
							else
								local var_138_14 = Mathf.Lerp(iter_138_2.color.r, 1, var_138_10)

								iter_138_2.color = Color.New(var_138_14, var_138_14, var_138_14)
							end
						end
					end
				end
			end

			if arg_135_1.time_ >= var_138_8 + var_138_9 and arg_135_1.time_ < var_138_8 + var_138_9 + arg_138_0 and not isNil(var_138_7) and arg_135_1.var_.actorSpriteComps10018 then
				for iter_138_3, iter_138_4 in pairs(arg_135_1.var_.actorSpriteComps10018:ToTable()) do
					if iter_138_4 then
						if arg_135_1.isInRecall_ then
							iter_138_4.color = arg_135_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_138_4.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_135_1.var_.actorSpriteComps10018 = nil
			end

			local var_138_15 = 0
			local var_138_16 = 1.3

			if var_138_15 < arg_135_1.time_ and arg_135_1.time_ <= var_138_15 + arg_138_0 then
				arg_135_1.talkMaxDuration = 0
				arg_135_1.dialogCg_.alpha = 1

				arg_135_1.dialog_:SetActive(true)
				SetActive(arg_135_1.leftNameGo_, true)

				local var_138_17 = arg_135_1:FormatText(StoryNameCfg[257].name)

				arg_135_1.leftNameTxt_.text = var_138_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_135_1.leftNameTxt_.transform)

				arg_135_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_135_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_135_1:RecordName(arg_135_1.leftNameTxt_.text)
				SetActive(arg_135_1.iconTrs_.gameObject, false)
				arg_135_1.callingController_:SetSelectedState("normal")

				local var_138_18 = arg_135_1:GetWordFromCfg(114251033)
				local var_138_19 = arg_135_1:FormatText(var_138_18.content)

				arg_135_1.text_.text = var_138_19

				LuaForUtil.ClearLinePrefixSymbol(arg_135_1.text_)

				local var_138_20 = 52
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

				if manager.audio:GetVoiceLength("story_v_out_114251", "114251033", "story_v_out_114251.awb") ~= 0 then
					local var_138_23 = manager.audio:GetVoiceLength("story_v_out_114251", "114251033", "story_v_out_114251.awb") / 1000

					if var_138_23 + var_138_15 > arg_135_1.duration_ then
						arg_135_1.duration_ = var_138_23 + var_138_15
					end

					if var_138_18.prefab_name ~= "" and arg_135_1.actors_[var_138_18.prefab_name] ~= nil then
						local var_138_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_135_1.actors_[var_138_18.prefab_name].transform, "story_v_out_114251", "114251033", "story_v_out_114251.awb")

						arg_135_1:RecordAudio("114251033", var_138_24)
						arg_135_1:RecordAudio("114251033", var_138_24)
					else
						arg_135_1:AudioAction("play", "voice", "story_v_out_114251", "114251033", "story_v_out_114251.awb")
					end

					arg_135_1:RecordHistoryTalkVoice("story_v_out_114251", "114251033", "story_v_out_114251.awb")
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
				actorName = "10018",
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
	Play114251034 = function(arg_139_0, arg_139_1)
		arg_139_1.time_ = 0
		arg_139_1.frameCnt_ = 0
		arg_139_1.state_ = "playing"
		arg_139_1.curTalkId_ = 114251034
		arg_139_1.duration_ = 6.9

		local var_139_0 = {
			ja = 6.066,
			ko = 6.833,
			zh = 5.7,
			en = 6.9
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
				arg_139_0:Play114251035(arg_139_1)
			end
		end

		function arg_139_1.onSingleLineUpdate_(arg_142_0)
			local var_142_0 = arg_139_1.actors_["10015"].transform
			local var_142_1 = 0

			if var_142_1 < arg_139_1.time_ and arg_139_1.time_ <= var_142_1 + arg_142_0 then
				arg_139_1.var_.moveOldPos10015 = var_142_0.localPosition
				var_142_0.localScale = Vector3.New(1, 1, 1)

				arg_139_1:CheckSpriteTmpPos("10015", 4)

				local var_142_2 = var_142_0.childCount

				for iter_142_0 = 0, var_142_2 - 1 do
					local var_142_3 = var_142_0:GetChild(iter_142_0)

					if var_142_3.name == "split_1" or not string.find(var_142_3.name, "split") then
						var_142_3.gameObject:SetActive(true)
					else
						var_142_3.gameObject:SetActive(false)
					end
				end
			end

			local var_142_4 = 0.001

			if var_142_1 <= arg_139_1.time_ and arg_139_1.time_ < var_142_1 + var_142_4 then
				local var_142_5 = (arg_139_1.time_ - var_142_1) / var_142_4
				local var_142_6 = Vector3.New(390, -350, -180)

				var_142_0.localPosition = Vector3.Lerp(arg_139_1.var_.moveOldPos10015, var_142_6, var_142_5)
			end

			if arg_139_1.time_ >= var_142_1 + var_142_4 and arg_139_1.time_ < var_142_1 + var_142_4 + arg_142_0 then
				var_142_0.localPosition = Vector3.New(390, -350, -180)
			end

			local var_142_7 = arg_139_1.actors_["10018"]
			local var_142_8 = 0

			if var_142_8 < arg_139_1.time_ and arg_139_1.time_ <= var_142_8 + arg_142_0 and not isNil(var_142_7) and arg_139_1.var_.actorSpriteComps10018 == nil then
				arg_139_1.var_.actorSpriteComps10018 = var_142_7:GetComponentsInChildren(typeof(Image), true)
			end

			local var_142_9 = 0.034

			if var_142_8 <= arg_139_1.time_ and arg_139_1.time_ < var_142_8 + var_142_9 and not isNil(var_142_7) then
				local var_142_10 = (arg_139_1.time_ - var_142_8) / var_142_9

				if arg_139_1.var_.actorSpriteComps10018 then
					for iter_142_1, iter_142_2 in pairs(arg_139_1.var_.actorSpriteComps10018:ToTable()) do
						if iter_142_2 then
							if arg_139_1.isInRecall_ then
								local var_142_11 = Mathf.Lerp(iter_142_2.color.r, arg_139_1.hightColor2.r, var_142_10)
								local var_142_12 = Mathf.Lerp(iter_142_2.color.g, arg_139_1.hightColor2.g, var_142_10)
								local var_142_13 = Mathf.Lerp(iter_142_2.color.b, arg_139_1.hightColor2.b, var_142_10)

								iter_142_2.color = Color.New(var_142_11, var_142_12, var_142_13)
							else
								local var_142_14 = Mathf.Lerp(iter_142_2.color.r, 0.5, var_142_10)

								iter_142_2.color = Color.New(var_142_14, var_142_14, var_142_14)
							end
						end
					end
				end
			end

			if arg_139_1.time_ >= var_142_8 + var_142_9 and arg_139_1.time_ < var_142_8 + var_142_9 + arg_142_0 and not isNil(var_142_7) and arg_139_1.var_.actorSpriteComps10018 then
				for iter_142_3, iter_142_4 in pairs(arg_139_1.var_.actorSpriteComps10018:ToTable()) do
					if iter_142_4 then
						if arg_139_1.isInRecall_ then
							iter_142_4.color = arg_139_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_142_4.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_139_1.var_.actorSpriteComps10018 = nil
			end

			local var_142_15 = arg_139_1.actors_["10015"]
			local var_142_16 = 0

			if var_142_16 < arg_139_1.time_ and arg_139_1.time_ <= var_142_16 + arg_142_0 and not isNil(var_142_15) and arg_139_1.var_.actorSpriteComps10015 == nil then
				arg_139_1.var_.actorSpriteComps10015 = var_142_15:GetComponentsInChildren(typeof(Image), true)
			end

			local var_142_17 = 0.034

			if var_142_16 <= arg_139_1.time_ and arg_139_1.time_ < var_142_16 + var_142_17 and not isNil(var_142_15) then
				local var_142_18 = (arg_139_1.time_ - var_142_16) / var_142_17

				if arg_139_1.var_.actorSpriteComps10015 then
					for iter_142_5, iter_142_6 in pairs(arg_139_1.var_.actorSpriteComps10015:ToTable()) do
						if iter_142_6 then
							if arg_139_1.isInRecall_ then
								local var_142_19 = Mathf.Lerp(iter_142_6.color.r, arg_139_1.hightColor1.r, var_142_18)
								local var_142_20 = Mathf.Lerp(iter_142_6.color.g, arg_139_1.hightColor1.g, var_142_18)
								local var_142_21 = Mathf.Lerp(iter_142_6.color.b, arg_139_1.hightColor1.b, var_142_18)

								iter_142_6.color = Color.New(var_142_19, var_142_20, var_142_21)
							else
								local var_142_22 = Mathf.Lerp(iter_142_6.color.r, 1, var_142_18)

								iter_142_6.color = Color.New(var_142_22, var_142_22, var_142_22)
							end
						end
					end
				end
			end

			if arg_139_1.time_ >= var_142_16 + var_142_17 and arg_139_1.time_ < var_142_16 + var_142_17 + arg_142_0 and not isNil(var_142_15) and arg_139_1.var_.actorSpriteComps10015 then
				for iter_142_7, iter_142_8 in pairs(arg_139_1.var_.actorSpriteComps10015:ToTable()) do
					if iter_142_8 then
						if arg_139_1.isInRecall_ then
							iter_142_8.color = arg_139_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_142_8.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_139_1.var_.actorSpriteComps10015 = nil
			end

			local var_142_23 = 0
			local var_142_24 = 0.65

			if var_142_23 < arg_139_1.time_ and arg_139_1.time_ <= var_142_23 + arg_142_0 then
				arg_139_1.talkMaxDuration = 0
				arg_139_1.dialogCg_.alpha = 1

				arg_139_1.dialog_:SetActive(true)
				SetActive(arg_139_1.leftNameGo_, true)

				local var_142_25 = arg_139_1:FormatText(StoryNameCfg[208].name)

				arg_139_1.leftNameTxt_.text = var_142_25

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_139_1.leftNameTxt_.transform)

				arg_139_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_139_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_139_1:RecordName(arg_139_1.leftNameTxt_.text)
				SetActive(arg_139_1.iconTrs_.gameObject, false)
				arg_139_1.callingController_:SetSelectedState("normal")

				local var_142_26 = arg_139_1:GetWordFromCfg(114251034)
				local var_142_27 = arg_139_1:FormatText(var_142_26.content)

				arg_139_1.text_.text = var_142_27

				LuaForUtil.ClearLinePrefixSymbol(arg_139_1.text_)

				local var_142_28 = 26
				local var_142_29 = utf8.len(var_142_27)
				local var_142_30 = var_142_28 <= 0 and var_142_24 or var_142_24 * (var_142_29 / var_142_28)

				if var_142_30 > 0 and var_142_24 < var_142_30 then
					arg_139_1.talkMaxDuration = var_142_30

					if var_142_30 + var_142_23 > arg_139_1.duration_ then
						arg_139_1.duration_ = var_142_30 + var_142_23
					end
				end

				arg_139_1.text_.text = var_142_27
				arg_139_1.typewritter.percent = 0

				arg_139_1.typewritter:SetDirty()
				arg_139_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_114251", "114251034", "story_v_out_114251.awb") ~= 0 then
					local var_142_31 = manager.audio:GetVoiceLength("story_v_out_114251", "114251034", "story_v_out_114251.awb") / 1000

					if var_142_31 + var_142_23 > arg_139_1.duration_ then
						arg_139_1.duration_ = var_142_31 + var_142_23
					end

					if var_142_26.prefab_name ~= "" and arg_139_1.actors_[var_142_26.prefab_name] ~= nil then
						local var_142_32 = LuaForUtil.PlayVoiceWithCriLipsync(arg_139_1.actors_[var_142_26.prefab_name].transform, "story_v_out_114251", "114251034", "story_v_out_114251.awb")

						arg_139_1:RecordAudio("114251034", var_142_32)
						arg_139_1:RecordAudio("114251034", var_142_32)
					else
						arg_139_1:AudioAction("play", "voice", "story_v_out_114251", "114251034", "story_v_out_114251.awb")
					end

					arg_139_1:RecordHistoryTalkVoice("story_v_out_114251", "114251034", "story_v_out_114251.awb")
				end

				arg_139_1:RecordContent(arg_139_1.text_.text)
			end

			local var_142_33 = math.max(var_142_24, arg_139_1.talkMaxDuration)

			if var_142_23 <= arg_139_1.time_ and arg_139_1.time_ < var_142_23 + var_142_33 then
				arg_139_1.typewritter.percent = (arg_139_1.time_ - var_142_23) / var_142_33

				arg_139_1.typewritter:SetDirty()
			end

			if arg_139_1.time_ >= var_142_23 + var_142_33 and arg_139_1.time_ < var_142_23 + var_142_33 + arg_142_0 then
				arg_139_1.typewritter.percent = 1

				arg_139_1.typewritter:SetDirty()
				arg_139_1:ShowNextGo(true)
			end
		end

		arg_139_1.nodeConfigList_ = {
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

		arg_139_1:InitPlayNodeList()
	end,
	Play114251035 = function(arg_143_0, arg_143_1)
		arg_143_1.time_ = 0
		arg_143_1.frameCnt_ = 0
		arg_143_1.state_ = "playing"
		arg_143_1.curTalkId_ = 114251035
		arg_143_1.duration_ = 9.37

		local var_143_0 = {
			ja = 9.366,
			ko = 6.733,
			zh = 4.966,
			en = 5.333
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
				arg_143_0:Play114251036(arg_143_1)
			end
		end

		function arg_143_1.onSingleLineUpdate_(arg_146_0)
			local var_146_0 = 0
			local var_146_1 = 0.55

			if var_146_0 < arg_143_1.time_ and arg_143_1.time_ <= var_146_0 + arg_146_0 then
				arg_143_1.talkMaxDuration = 0
				arg_143_1.dialogCg_.alpha = 1

				arg_143_1.dialog_:SetActive(true)
				SetActive(arg_143_1.leftNameGo_, true)

				local var_146_2 = arg_143_1:FormatText(StoryNameCfg[208].name)

				arg_143_1.leftNameTxt_.text = var_146_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_143_1.leftNameTxt_.transform)

				arg_143_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_143_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_143_1:RecordName(arg_143_1.leftNameTxt_.text)
				SetActive(arg_143_1.iconTrs_.gameObject, false)
				arg_143_1.callingController_:SetSelectedState("normal")

				local var_146_3 = arg_143_1:GetWordFromCfg(114251035)
				local var_146_4 = arg_143_1:FormatText(var_146_3.content)

				arg_143_1.text_.text = var_146_4

				LuaForUtil.ClearLinePrefixSymbol(arg_143_1.text_)

				local var_146_5 = 22
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

				if manager.audio:GetVoiceLength("story_v_out_114251", "114251035", "story_v_out_114251.awb") ~= 0 then
					local var_146_8 = manager.audio:GetVoiceLength("story_v_out_114251", "114251035", "story_v_out_114251.awb") / 1000

					if var_146_8 + var_146_0 > arg_143_1.duration_ then
						arg_143_1.duration_ = var_146_8 + var_146_0
					end

					if var_146_3.prefab_name ~= "" and arg_143_1.actors_[var_146_3.prefab_name] ~= nil then
						local var_146_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_143_1.actors_[var_146_3.prefab_name].transform, "story_v_out_114251", "114251035", "story_v_out_114251.awb")

						arg_143_1:RecordAudio("114251035", var_146_9)
						arg_143_1:RecordAudio("114251035", var_146_9)
					else
						arg_143_1:AudioAction("play", "voice", "story_v_out_114251", "114251035", "story_v_out_114251.awb")
					end

					arg_143_1:RecordHistoryTalkVoice("story_v_out_114251", "114251035", "story_v_out_114251.awb")
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
	Play114251036 = function(arg_147_0, arg_147_1)
		arg_147_1.time_ = 0
		arg_147_1.frameCnt_ = 0
		arg_147_1.state_ = "playing"
		arg_147_1.curTalkId_ = 114251036
		arg_147_1.duration_ = 7.17

		local var_147_0 = {
			ja = 4.566,
			ko = 6.466,
			zh = 5.7,
			en = 7.166
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
				arg_147_0:Play114251037(arg_147_1)
			end
		end

		function arg_147_1.onSingleLineUpdate_(arg_150_0)
			local var_150_0 = arg_147_1.actors_["10018"]
			local var_150_1 = 0

			if var_150_1 < arg_147_1.time_ and arg_147_1.time_ <= var_150_1 + arg_150_0 and not isNil(var_150_0) and arg_147_1.var_.actorSpriteComps10018 == nil then
				arg_147_1.var_.actorSpriteComps10018 = var_150_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_150_2 = 0.034

			if var_150_1 <= arg_147_1.time_ and arg_147_1.time_ < var_150_1 + var_150_2 and not isNil(var_150_0) then
				local var_150_3 = (arg_147_1.time_ - var_150_1) / var_150_2

				if arg_147_1.var_.actorSpriteComps10018 then
					for iter_150_0, iter_150_1 in pairs(arg_147_1.var_.actorSpriteComps10018:ToTable()) do
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

			if arg_147_1.time_ >= var_150_1 + var_150_2 and arg_147_1.time_ < var_150_1 + var_150_2 + arg_150_0 and not isNil(var_150_0) and arg_147_1.var_.actorSpriteComps10018 then
				for iter_150_2, iter_150_3 in pairs(arg_147_1.var_.actorSpriteComps10018:ToTable()) do
					if iter_150_3 then
						if arg_147_1.isInRecall_ then
							iter_150_3.color = arg_147_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_150_3.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_147_1.var_.actorSpriteComps10018 = nil
			end

			local var_150_8 = arg_147_1.actors_["10015"]
			local var_150_9 = 0

			if var_150_9 < arg_147_1.time_ and arg_147_1.time_ <= var_150_9 + arg_150_0 and not isNil(var_150_8) and arg_147_1.var_.actorSpriteComps10015 == nil then
				arg_147_1.var_.actorSpriteComps10015 = var_150_8:GetComponentsInChildren(typeof(Image), true)
			end

			local var_150_10 = 0.034

			if var_150_9 <= arg_147_1.time_ and arg_147_1.time_ < var_150_9 + var_150_10 and not isNil(var_150_8) then
				local var_150_11 = (arg_147_1.time_ - var_150_9) / var_150_10

				if arg_147_1.var_.actorSpriteComps10015 then
					for iter_150_4, iter_150_5 in pairs(arg_147_1.var_.actorSpriteComps10015:ToTable()) do
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

			if arg_147_1.time_ >= var_150_9 + var_150_10 and arg_147_1.time_ < var_150_9 + var_150_10 + arg_150_0 and not isNil(var_150_8) and arg_147_1.var_.actorSpriteComps10015 then
				for iter_150_6, iter_150_7 in pairs(arg_147_1.var_.actorSpriteComps10015:ToTable()) do
					if iter_150_7 then
						if arg_147_1.isInRecall_ then
							iter_150_7.color = arg_147_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_150_7.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_147_1.var_.actorSpriteComps10015 = nil
			end

			local var_150_16 = 0
			local var_150_17 = 0.45

			if var_150_16 < arg_147_1.time_ and arg_147_1.time_ <= var_150_16 + arg_150_0 then
				arg_147_1.talkMaxDuration = 0
				arg_147_1.dialogCg_.alpha = 1

				arg_147_1.dialog_:SetActive(true)
				SetActive(arg_147_1.leftNameGo_, true)

				local var_150_18 = arg_147_1:FormatText(StoryNameCfg[257].name)

				arg_147_1.leftNameTxt_.text = var_150_18

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_147_1.leftNameTxt_.transform)

				arg_147_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_147_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_147_1:RecordName(arg_147_1.leftNameTxt_.text)
				SetActive(arg_147_1.iconTrs_.gameObject, false)
				arg_147_1.callingController_:SetSelectedState("normal")

				local var_150_19 = arg_147_1:GetWordFromCfg(114251036)
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

				if manager.audio:GetVoiceLength("story_v_out_114251", "114251036", "story_v_out_114251.awb") ~= 0 then
					local var_150_24 = manager.audio:GetVoiceLength("story_v_out_114251", "114251036", "story_v_out_114251.awb") / 1000

					if var_150_24 + var_150_16 > arg_147_1.duration_ then
						arg_147_1.duration_ = var_150_24 + var_150_16
					end

					if var_150_19.prefab_name ~= "" and arg_147_1.actors_[var_150_19.prefab_name] ~= nil then
						local var_150_25 = LuaForUtil.PlayVoiceWithCriLipsync(arg_147_1.actors_[var_150_19.prefab_name].transform, "story_v_out_114251", "114251036", "story_v_out_114251.awb")

						arg_147_1:RecordAudio("114251036", var_150_25)
						arg_147_1:RecordAudio("114251036", var_150_25)
					else
						arg_147_1:AudioAction("play", "voice", "story_v_out_114251", "114251036", "story_v_out_114251.awb")
					end

					arg_147_1:RecordHistoryTalkVoice("story_v_out_114251", "114251036", "story_v_out_114251.awb")
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
	Play114251037 = function(arg_151_0, arg_151_1)
		arg_151_1.time_ = 0
		arg_151_1.frameCnt_ = 0
		arg_151_1.state_ = "playing"
		arg_151_1.curTalkId_ = 114251037
		arg_151_1.duration_ = 5

		SetActive(arg_151_1.tipsGo_, false)

		function arg_151_1.onSingleLineFinish_()
			arg_151_1.onSingleLineUpdate_ = nil
			arg_151_1.onSingleLineFinish_ = nil
			arg_151_1.state_ = "waiting"
		end

		function arg_151_1.playNext_(arg_153_0)
			if arg_153_0 == 1 then
				arg_151_0:Play114251038(arg_151_1)
			end
		end

		function arg_151_1.onSingleLineUpdate_(arg_154_0)
			local var_154_0 = arg_151_1.actors_["10018"]
			local var_154_1 = 0

			if var_154_1 < arg_151_1.time_ and arg_151_1.time_ <= var_154_1 + arg_154_0 and not isNil(var_154_0) and arg_151_1.var_.actorSpriteComps10018 == nil then
				arg_151_1.var_.actorSpriteComps10018 = var_154_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_154_2 = 0.034

			if var_154_1 <= arg_151_1.time_ and arg_151_1.time_ < var_154_1 + var_154_2 and not isNil(var_154_0) then
				local var_154_3 = (arg_151_1.time_ - var_154_1) / var_154_2

				if arg_151_1.var_.actorSpriteComps10018 then
					for iter_154_0, iter_154_1 in pairs(arg_151_1.var_.actorSpriteComps10018:ToTable()) do
						if iter_154_1 then
							if arg_151_1.isInRecall_ then
								local var_154_4 = Mathf.Lerp(iter_154_1.color.r, arg_151_1.hightColor2.r, var_154_3)
								local var_154_5 = Mathf.Lerp(iter_154_1.color.g, arg_151_1.hightColor2.g, var_154_3)
								local var_154_6 = Mathf.Lerp(iter_154_1.color.b, arg_151_1.hightColor2.b, var_154_3)

								iter_154_1.color = Color.New(var_154_4, var_154_5, var_154_6)
							else
								local var_154_7 = Mathf.Lerp(iter_154_1.color.r, 0.5, var_154_3)

								iter_154_1.color = Color.New(var_154_7, var_154_7, var_154_7)
							end
						end
					end
				end
			end

			if arg_151_1.time_ >= var_154_1 + var_154_2 and arg_151_1.time_ < var_154_1 + var_154_2 + arg_154_0 and not isNil(var_154_0) and arg_151_1.var_.actorSpriteComps10018 then
				for iter_154_2, iter_154_3 in pairs(arg_151_1.var_.actorSpriteComps10018:ToTable()) do
					if iter_154_3 then
						if arg_151_1.isInRecall_ then
							iter_154_3.color = arg_151_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_154_3.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_151_1.var_.actorSpriteComps10018 = nil
			end

			local var_154_8 = 0
			local var_154_9 = 0.8

			if var_154_8 < arg_151_1.time_ and arg_151_1.time_ <= var_154_8 + arg_154_0 then
				arg_151_1.talkMaxDuration = 0
				arg_151_1.dialogCg_.alpha = 1

				arg_151_1.dialog_:SetActive(true)
				SetActive(arg_151_1.leftNameGo_, false)

				arg_151_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_151_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_151_1:RecordName(arg_151_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_151_1.iconTrs_.gameObject, false)
				arg_151_1.callingController_:SetSelectedState("normal")

				local var_154_10 = arg_151_1:GetWordFromCfg(114251037)
				local var_154_11 = arg_151_1:FormatText(var_154_10.content)

				arg_151_1.text_.text = var_154_11

				LuaForUtil.ClearLinePrefixSymbol(arg_151_1.text_)

				local var_154_12 = 32
				local var_154_13 = utf8.len(var_154_11)
				local var_154_14 = var_154_12 <= 0 and var_154_9 or var_154_9 * (var_154_13 / var_154_12)

				if var_154_14 > 0 and var_154_9 < var_154_14 then
					arg_151_1.talkMaxDuration = var_154_14

					if var_154_14 + var_154_8 > arg_151_1.duration_ then
						arg_151_1.duration_ = var_154_14 + var_154_8
					end
				end

				arg_151_1.text_.text = var_154_11
				arg_151_1.typewritter.percent = 0

				arg_151_1.typewritter:SetDirty()
				arg_151_1:ShowNextGo(false)
				arg_151_1:RecordContent(arg_151_1.text_.text)
			end

			local var_154_15 = math.max(var_154_9, arg_151_1.talkMaxDuration)

			if var_154_8 <= arg_151_1.time_ and arg_151_1.time_ < var_154_8 + var_154_15 then
				arg_151_1.typewritter.percent = (arg_151_1.time_ - var_154_8) / var_154_15

				arg_151_1.typewritter:SetDirty()
			end

			if arg_151_1.time_ >= var_154_8 + var_154_15 and arg_151_1.time_ < var_154_8 + var_154_15 + arg_154_0 then
				arg_151_1.typewritter.percent = 1

				arg_151_1.typewritter:SetDirty()
				arg_151_1:ShowNextGo(true)
			end
		end

		arg_151_1.nodeConfigList_ = {}

		arg_151_1:InitPlayNodeList()
	end,
	Play114251038 = function(arg_155_0, arg_155_1)
		arg_155_1.time_ = 0
		arg_155_1.frameCnt_ = 0
		arg_155_1.state_ = "playing"
		arg_155_1.curTalkId_ = 114251038
		arg_155_1.duration_ = 3.5

		local var_155_0 = {
			ja = 3.5,
			ko = 1.7,
			zh = 2.8,
			en = 1.7
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
				arg_155_0:Play114251039(arg_155_1)
			end
		end

		function arg_155_1.onSingleLineUpdate_(arg_158_0)
			local var_158_0 = arg_155_1.actors_["10015"].transform
			local var_158_1 = 0

			if var_158_1 < arg_155_1.time_ and arg_155_1.time_ <= var_158_1 + arg_158_0 then
				arg_155_1.var_.moveOldPos10015 = var_158_0.localPosition
				var_158_0.localScale = Vector3.New(1, 1, 1)

				arg_155_1:CheckSpriteTmpPos("10015", 4)

				local var_158_2 = var_158_0.childCount

				for iter_158_0 = 0, var_158_2 - 1 do
					local var_158_3 = var_158_0:GetChild(iter_158_0)

					if var_158_3.name == "split_5" or not string.find(var_158_3.name, "split") then
						var_158_3.gameObject:SetActive(true)
					else
						var_158_3.gameObject:SetActive(false)
					end
				end
			end

			local var_158_4 = 0.001

			if var_158_1 <= arg_155_1.time_ and arg_155_1.time_ < var_158_1 + var_158_4 then
				local var_158_5 = (arg_155_1.time_ - var_158_1) / var_158_4
				local var_158_6 = Vector3.New(390, -350, -180)

				var_158_0.localPosition = Vector3.Lerp(arg_155_1.var_.moveOldPos10015, var_158_6, var_158_5)
			end

			if arg_155_1.time_ >= var_158_1 + var_158_4 and arg_155_1.time_ < var_158_1 + var_158_4 + arg_158_0 then
				var_158_0.localPosition = Vector3.New(390, -350, -180)
			end

			local var_158_7 = arg_155_1.actors_["10015"]
			local var_158_8 = 0

			if var_158_8 < arg_155_1.time_ and arg_155_1.time_ <= var_158_8 + arg_158_0 and not isNil(var_158_7) and arg_155_1.var_.actorSpriteComps10015 == nil then
				arg_155_1.var_.actorSpriteComps10015 = var_158_7:GetComponentsInChildren(typeof(Image), true)
			end

			local var_158_9 = 0.034

			if var_158_8 <= arg_155_1.time_ and arg_155_1.time_ < var_158_8 + var_158_9 and not isNil(var_158_7) then
				local var_158_10 = (arg_155_1.time_ - var_158_8) / var_158_9

				if arg_155_1.var_.actorSpriteComps10015 then
					for iter_158_1, iter_158_2 in pairs(arg_155_1.var_.actorSpriteComps10015:ToTable()) do
						if iter_158_2 then
							if arg_155_1.isInRecall_ then
								local var_158_11 = Mathf.Lerp(iter_158_2.color.r, arg_155_1.hightColor1.r, var_158_10)
								local var_158_12 = Mathf.Lerp(iter_158_2.color.g, arg_155_1.hightColor1.g, var_158_10)
								local var_158_13 = Mathf.Lerp(iter_158_2.color.b, arg_155_1.hightColor1.b, var_158_10)

								iter_158_2.color = Color.New(var_158_11, var_158_12, var_158_13)
							else
								local var_158_14 = Mathf.Lerp(iter_158_2.color.r, 1, var_158_10)

								iter_158_2.color = Color.New(var_158_14, var_158_14, var_158_14)
							end
						end
					end
				end
			end

			if arg_155_1.time_ >= var_158_8 + var_158_9 and arg_155_1.time_ < var_158_8 + var_158_9 + arg_158_0 and not isNil(var_158_7) and arg_155_1.var_.actorSpriteComps10015 then
				for iter_158_3, iter_158_4 in pairs(arg_155_1.var_.actorSpriteComps10015:ToTable()) do
					if iter_158_4 then
						if arg_155_1.isInRecall_ then
							iter_158_4.color = arg_155_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_158_4.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_155_1.var_.actorSpriteComps10015 = nil
			end

			local var_158_15 = 0
			local var_158_16 = 0.225

			if var_158_15 < arg_155_1.time_ and arg_155_1.time_ <= var_158_15 + arg_158_0 then
				arg_155_1.talkMaxDuration = 0
				arg_155_1.dialogCg_.alpha = 1

				arg_155_1.dialog_:SetActive(true)
				SetActive(arg_155_1.leftNameGo_, true)

				local var_158_17 = arg_155_1:FormatText(StoryNameCfg[208].name)

				arg_155_1.leftNameTxt_.text = var_158_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_155_1.leftNameTxt_.transform)

				arg_155_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_155_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_155_1:RecordName(arg_155_1.leftNameTxt_.text)
				SetActive(arg_155_1.iconTrs_.gameObject, false)
				arg_155_1.callingController_:SetSelectedState("normal")

				local var_158_18 = arg_155_1:GetWordFromCfg(114251038)
				local var_158_19 = arg_155_1:FormatText(var_158_18.content)

				arg_155_1.text_.text = var_158_19

				LuaForUtil.ClearLinePrefixSymbol(arg_155_1.text_)

				local var_158_20 = 9
				local var_158_21 = utf8.len(var_158_19)
				local var_158_22 = var_158_20 <= 0 and var_158_16 or var_158_16 * (var_158_21 / var_158_20)

				if var_158_22 > 0 and var_158_16 < var_158_22 then
					arg_155_1.talkMaxDuration = var_158_22

					if var_158_22 + var_158_15 > arg_155_1.duration_ then
						arg_155_1.duration_ = var_158_22 + var_158_15
					end
				end

				arg_155_1.text_.text = var_158_19
				arg_155_1.typewritter.percent = 0

				arg_155_1.typewritter:SetDirty()
				arg_155_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_114251", "114251038", "story_v_out_114251.awb") ~= 0 then
					local var_158_23 = manager.audio:GetVoiceLength("story_v_out_114251", "114251038", "story_v_out_114251.awb") / 1000

					if var_158_23 + var_158_15 > arg_155_1.duration_ then
						arg_155_1.duration_ = var_158_23 + var_158_15
					end

					if var_158_18.prefab_name ~= "" and arg_155_1.actors_[var_158_18.prefab_name] ~= nil then
						local var_158_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_155_1.actors_[var_158_18.prefab_name].transform, "story_v_out_114251", "114251038", "story_v_out_114251.awb")

						arg_155_1:RecordAudio("114251038", var_158_24)
						arg_155_1:RecordAudio("114251038", var_158_24)
					else
						arg_155_1:AudioAction("play", "voice", "story_v_out_114251", "114251038", "story_v_out_114251.awb")
					end

					arg_155_1:RecordHistoryTalkVoice("story_v_out_114251", "114251038", "story_v_out_114251.awb")
				end

				arg_155_1:RecordContent(arg_155_1.text_.text)
			end

			local var_158_25 = math.max(var_158_16, arg_155_1.talkMaxDuration)

			if var_158_15 <= arg_155_1.time_ and arg_155_1.time_ < var_158_15 + var_158_25 then
				arg_155_1.typewritter.percent = (arg_155_1.time_ - var_158_15) / var_158_25

				arg_155_1.typewritter:SetDirty()
			end

			if arg_155_1.time_ >= var_158_15 + var_158_25 and arg_155_1.time_ < var_158_15 + var_158_25 + arg_158_0 then
				arg_155_1.typewritter.percent = 1

				arg_155_1.typewritter:SetDirty()
				arg_155_1:ShowNextGo(true)
			end
		end

		arg_155_1.nodeConfigList_ = {
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

		arg_155_1:InitPlayNodeList()
	end,
	Play114251039 = function(arg_159_0, arg_159_1)
		arg_159_1.time_ = 0
		arg_159_1.frameCnt_ = 0
		arg_159_1.state_ = "playing"
		arg_159_1.curTalkId_ = 114251039
		arg_159_1.duration_ = 9

		SetActive(arg_159_1.tipsGo_, false)

		function arg_159_1.onSingleLineFinish_()
			arg_159_1.onSingleLineUpdate_ = nil
			arg_159_1.onSingleLineFinish_ = nil
			arg_159_1.state_ = "waiting"
		end

		function arg_159_1.playNext_(arg_161_0)
			if arg_161_0 == 1 then
				arg_159_0:Play114251040(arg_159_1)
			end
		end

		function arg_159_1.onSingleLineUpdate_(arg_162_0)
			local var_162_0 = "ST24a"

			if arg_159_1.bgs_[var_162_0] == nil then
				local var_162_1 = Object.Instantiate(arg_159_1.paintGo_)

				var_162_1:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. var_162_0)
				var_162_1.name = var_162_0
				var_162_1.transform.parent = arg_159_1.stage_.transform
				var_162_1.transform.localPosition = Vector3.New(0, 100, 0)
				arg_159_1.bgs_[var_162_0] = var_162_1
			end

			local var_162_2 = 2

			if var_162_2 < arg_159_1.time_ and arg_159_1.time_ <= var_162_2 + arg_162_0 then
				local var_162_3 = manager.ui.mainCamera.transform.localPosition
				local var_162_4 = Vector3.New(0, 0, 10) + Vector3.New(var_162_3.x, var_162_3.y, 0)
				local var_162_5 = arg_159_1.bgs_.ST24a

				var_162_5.transform.localPosition = var_162_4
				var_162_5.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_162_6 = var_162_5:GetComponent("SpriteRenderer")

				if var_162_6 and var_162_6.sprite then
					local var_162_7 = (var_162_5.transform.localPosition - var_162_3).z
					local var_162_8 = manager.ui.mainCameraCom_
					local var_162_9 = 2 * var_162_7 * Mathf.Tan(var_162_8.fieldOfView * 0.5 * Mathf.Deg2Rad)
					local var_162_10 = var_162_9 * var_162_8.aspect
					local var_162_11 = var_162_6.sprite.bounds.size.x
					local var_162_12 = var_162_6.sprite.bounds.size.y
					local var_162_13 = var_162_10 / var_162_11
					local var_162_14 = var_162_9 / var_162_12
					local var_162_15 = var_162_14 < var_162_13 and var_162_13 or var_162_14

					var_162_5.transform.localScale = Vector3.New(var_162_15, var_162_15, 0)
				end

				for iter_162_0, iter_162_1 in pairs(arg_159_1.bgs_) do
					if iter_162_0 ~= "ST24a" then
						iter_162_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_162_16 = 0

			if var_162_16 < arg_159_1.time_ and arg_159_1.time_ <= var_162_16 + arg_162_0 then
				arg_159_1.mask_.enabled = true
				arg_159_1.mask_.raycastTarget = true

				arg_159_1:SetGaussion(false)
			end

			local var_162_17 = 2

			if var_162_16 <= arg_159_1.time_ and arg_159_1.time_ < var_162_16 + var_162_17 then
				local var_162_18 = (arg_159_1.time_ - var_162_16) / var_162_17
				local var_162_19 = Color.New(0, 0, 0)

				var_162_19.a = Mathf.Lerp(0, 1, var_162_18)
				arg_159_1.mask_.color = var_162_19
			end

			if arg_159_1.time_ >= var_162_16 + var_162_17 and arg_159_1.time_ < var_162_16 + var_162_17 + arg_162_0 then
				local var_162_20 = Color.New(0, 0, 0)

				var_162_20.a = 1
				arg_159_1.mask_.color = var_162_20
			end

			local var_162_21 = 2

			if var_162_21 < arg_159_1.time_ and arg_159_1.time_ <= var_162_21 + arg_162_0 then
				arg_159_1.mask_.enabled = true
				arg_159_1.mask_.raycastTarget = true

				arg_159_1:SetGaussion(false)
			end

			local var_162_22 = 2

			if var_162_21 <= arg_159_1.time_ and arg_159_1.time_ < var_162_21 + var_162_22 then
				local var_162_23 = (arg_159_1.time_ - var_162_21) / var_162_22
				local var_162_24 = Color.New(0, 0, 0)

				var_162_24.a = Mathf.Lerp(1, 0, var_162_23)
				arg_159_1.mask_.color = var_162_24
			end

			if arg_159_1.time_ >= var_162_21 + var_162_22 and arg_159_1.time_ < var_162_21 + var_162_22 + arg_162_0 then
				local var_162_25 = Color.New(0, 0, 0)
				local var_162_26 = 0

				arg_159_1.mask_.enabled = false
				var_162_25.a = var_162_26
				arg_159_1.mask_.color = var_162_25
			end

			local var_162_27 = arg_159_1.actors_["10018"].transform
			local var_162_28 = 1.966

			if var_162_28 < arg_159_1.time_ and arg_159_1.time_ <= var_162_28 + arg_162_0 then
				arg_159_1.var_.moveOldPos10018 = var_162_27.localPosition
				var_162_27.localScale = Vector3.New(1, 1, 1)

				arg_159_1:CheckSpriteTmpPos("10018", 7)

				local var_162_29 = var_162_27.childCount

				for iter_162_2 = 0, var_162_29 - 1 do
					local var_162_30 = var_162_27:GetChild(iter_162_2)

					if var_162_30.name == "split_2" or not string.find(var_162_30.name, "split") then
						var_162_30.gameObject:SetActive(true)
					else
						var_162_30.gameObject:SetActive(false)
					end
				end
			end

			local var_162_31 = 0.001

			if var_162_28 <= arg_159_1.time_ and arg_159_1.time_ < var_162_28 + var_162_31 then
				local var_162_32 = (arg_159_1.time_ - var_162_28) / var_162_31
				local var_162_33 = Vector3.New(0, -2000, -180)

				var_162_27.localPosition = Vector3.Lerp(arg_159_1.var_.moveOldPos10018, var_162_33, var_162_32)
			end

			if arg_159_1.time_ >= var_162_28 + var_162_31 and arg_159_1.time_ < var_162_28 + var_162_31 + arg_162_0 then
				var_162_27.localPosition = Vector3.New(0, -2000, -180)
			end

			local var_162_34 = arg_159_1.actors_["10015"].transform
			local var_162_35 = 1.966

			if var_162_35 < arg_159_1.time_ and arg_159_1.time_ <= var_162_35 + arg_162_0 then
				arg_159_1.var_.moveOldPos10015 = var_162_34.localPosition
				var_162_34.localScale = Vector3.New(1, 1, 1)

				arg_159_1:CheckSpriteTmpPos("10015", 7)

				local var_162_36 = var_162_34.childCount

				for iter_162_3 = 0, var_162_36 - 1 do
					local var_162_37 = var_162_34:GetChild(iter_162_3)

					if var_162_37.name == "split_5" or not string.find(var_162_37.name, "split") then
						var_162_37.gameObject:SetActive(true)
					else
						var_162_37.gameObject:SetActive(false)
					end
				end
			end

			local var_162_38 = 0.001

			if var_162_35 <= arg_159_1.time_ and arg_159_1.time_ < var_162_35 + var_162_38 then
				local var_162_39 = (arg_159_1.time_ - var_162_35) / var_162_38
				local var_162_40 = Vector3.New(0, -2000, 450)

				var_162_34.localPosition = Vector3.Lerp(arg_159_1.var_.moveOldPos10015, var_162_40, var_162_39)
			end

			if arg_159_1.time_ >= var_162_35 + var_162_38 and arg_159_1.time_ < var_162_35 + var_162_38 + arg_162_0 then
				var_162_34.localPosition = Vector3.New(0, -2000, 450)
			end

			if arg_159_1.frameCnt_ <= 1 then
				arg_159_1.dialog_:SetActive(false)
			end

			local var_162_41 = 4
			local var_162_42 = 0.05

			if var_162_41 < arg_159_1.time_ and arg_159_1.time_ <= var_162_41 + arg_162_0 then
				arg_159_1.talkMaxDuration = 0

				arg_159_1.dialog_:SetActive(true)

				arg_159_1.dialogCg_.alpha = 0

				local var_162_43 = LeanTween.value(arg_159_1.dialog_, 0, 1, 0.3)

				var_162_43:setOnUpdate(LuaHelper.FloatAction(function(arg_163_0)
					arg_159_1.dialogCg_.alpha = arg_163_0
				end))
				var_162_43:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_159_1.dialog_)
					var_162_43:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_159_1.duration_ = arg_159_1.duration_ + 0.3

				SetActive(arg_159_1.leftNameGo_, false)

				arg_159_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_159_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_159_1:RecordName(arg_159_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_159_1.iconTrs_.gameObject, false)
				arg_159_1.callingController_:SetSelectedState("normal")

				local var_162_44 = arg_159_1:GetWordFromCfg(114251039)
				local var_162_45 = arg_159_1:FormatText(var_162_44.content)

				arg_159_1.text_.text = var_162_45

				LuaForUtil.ClearLinePrefixSymbol(arg_159_1.text_)

				local var_162_46 = 2
				local var_162_47 = utf8.len(var_162_45)
				local var_162_48 = var_162_46 <= 0 and var_162_42 or var_162_42 * (var_162_47 / var_162_46)

				if var_162_48 > 0 and var_162_42 < var_162_48 then
					arg_159_1.talkMaxDuration = var_162_48
					var_162_41 = var_162_41 + 0.3

					if var_162_48 + var_162_41 > arg_159_1.duration_ then
						arg_159_1.duration_ = var_162_48 + var_162_41
					end
				end

				arg_159_1.text_.text = var_162_45
				arg_159_1.typewritter.percent = 0

				arg_159_1.typewritter:SetDirty()
				arg_159_1:ShowNextGo(false)
				arg_159_1:RecordContent(arg_159_1.text_.text)
			end

			local var_162_49 = var_162_41 + 0.3
			local var_162_50 = math.max(var_162_42, arg_159_1.talkMaxDuration)

			if var_162_49 <= arg_159_1.time_ and arg_159_1.time_ < var_162_49 + var_162_50 then
				arg_159_1.typewritter.percent = (arg_159_1.time_ - var_162_49) / var_162_50

				arg_159_1.typewritter:SetDirty()
			end

			if arg_159_1.time_ >= var_162_49 + var_162_50 and arg_159_1.time_ < var_162_49 + var_162_50 + arg_162_0 then
				arg_159_1.typewritter.percent = 1

				arg_159_1.typewritter:SetDirty()
				arg_159_1:ShowNextGo(true)
			end
		end

		arg_159_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10018",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 1.966,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			},
			{
				assetPath = "",
				actorName = "10015",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 1.966,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_159_1:InitPlayNodeList()
	end,
	Play114251040 = function(arg_165_0, arg_165_1)
		arg_165_1.time_ = 0
		arg_165_1.frameCnt_ = 0
		arg_165_1.state_ = "playing"
		arg_165_1.curTalkId_ = 114251040
		arg_165_1.duration_ = 8.3

		local var_165_0 = {
			ja = 8.3,
			ko = 6.5,
			zh = 6.6,
			en = 6.266
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
				arg_165_0:Play114251041(arg_165_1)
			end
		end

		function arg_165_1.onSingleLineUpdate_(arg_168_0)
			local var_168_0 = "10021"

			if arg_165_1.actors_[var_168_0] == nil then
				local var_168_1 = Asset.Load("Widget/System/Story/StoryExpression/" .. "10021")

				if not isNil(var_168_1) then
					local var_168_2 = Object.Instantiate(var_168_1, arg_165_1.canvasGo_.transform)

					var_168_2.transform:SetSiblingIndex(1)

					var_168_2.name = var_168_0
					var_168_2.transform.localPosition = Vector3.New(0, 100000, 0)
					arg_165_1.actors_[var_168_0] = var_168_2

					local var_168_3 = var_168_2:GetComponentsInChildren(typeof(Image), true):ToTable()

					if arg_165_1.isInRecall_ then
						for iter_168_0, iter_168_1 in ipairs(var_168_3) do
							iter_168_1.color = arg_165_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						end
					end
				end
			end

			local var_168_4 = arg_165_1.actors_["10021"].transform
			local var_168_5 = 0

			if var_168_5 < arg_165_1.time_ and arg_165_1.time_ <= var_168_5 + arg_168_0 then
				arg_165_1.var_.moveOldPos10021 = var_168_4.localPosition
				var_168_4.localScale = Vector3.New(1, 1, 1)

				arg_165_1:CheckSpriteTmpPos("10021", 2)

				local var_168_6 = var_168_4.childCount

				for iter_168_2 = 0, var_168_6 - 1 do
					local var_168_7 = var_168_4:GetChild(iter_168_2)

					if var_168_7.name == "split_1" or not string.find(var_168_7.name, "split") then
						var_168_7.gameObject:SetActive(true)
					else
						var_168_7.gameObject:SetActive(false)
					end
				end
			end

			local var_168_8 = 0.001

			if var_168_5 <= arg_165_1.time_ and arg_165_1.time_ < var_168_5 + var_168_8 then
				local var_168_9 = (arg_165_1.time_ - var_168_5) / var_168_8
				local var_168_10 = Vector3.New(-390, -350, -180)

				var_168_4.localPosition = Vector3.Lerp(arg_165_1.var_.moveOldPos10021, var_168_10, var_168_9)
			end

			if arg_165_1.time_ >= var_168_5 + var_168_8 and arg_165_1.time_ < var_168_5 + var_168_8 + arg_168_0 then
				var_168_4.localPosition = Vector3.New(-390, -350, -180)
			end

			local var_168_11 = arg_165_1.actors_["10021"]
			local var_168_12 = 0

			if var_168_12 < arg_165_1.time_ and arg_165_1.time_ <= var_168_12 + arg_168_0 and not isNil(var_168_11) and arg_165_1.var_.actorSpriteComps10021 == nil then
				arg_165_1.var_.actorSpriteComps10021 = var_168_11:GetComponentsInChildren(typeof(Image), true)
			end

			local var_168_13 = 0.034

			if var_168_12 <= arg_165_1.time_ and arg_165_1.time_ < var_168_12 + var_168_13 and not isNil(var_168_11) then
				local var_168_14 = (arg_165_1.time_ - var_168_12) / var_168_13

				if arg_165_1.var_.actorSpriteComps10021 then
					for iter_168_3, iter_168_4 in pairs(arg_165_1.var_.actorSpriteComps10021:ToTable()) do
						if iter_168_4 then
							if arg_165_1.isInRecall_ then
								local var_168_15 = Mathf.Lerp(iter_168_4.color.r, arg_165_1.hightColor1.r, var_168_14)
								local var_168_16 = Mathf.Lerp(iter_168_4.color.g, arg_165_1.hightColor1.g, var_168_14)
								local var_168_17 = Mathf.Lerp(iter_168_4.color.b, arg_165_1.hightColor1.b, var_168_14)

								iter_168_4.color = Color.New(var_168_15, var_168_16, var_168_17)
							else
								local var_168_18 = Mathf.Lerp(iter_168_4.color.r, 1, var_168_14)

								iter_168_4.color = Color.New(var_168_18, var_168_18, var_168_18)
							end
						end
					end
				end
			end

			if arg_165_1.time_ >= var_168_12 + var_168_13 and arg_165_1.time_ < var_168_12 + var_168_13 + arg_168_0 and not isNil(var_168_11) and arg_165_1.var_.actorSpriteComps10021 then
				for iter_168_5, iter_168_6 in pairs(arg_165_1.var_.actorSpriteComps10021:ToTable()) do
					if iter_168_6 then
						if arg_165_1.isInRecall_ then
							iter_168_6.color = arg_165_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_168_6.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_165_1.var_.actorSpriteComps10021 = nil
			end

			local var_168_19 = arg_165_1.actors_["10021"]
			local var_168_20 = 0

			if var_168_20 < arg_165_1.time_ and arg_165_1.time_ <= var_168_20 + arg_168_0 then
				local var_168_21 = var_168_19:GetComponentInChildren(typeof(CanvasGroup))

				if var_168_21 then
					arg_165_1.var_.alphaOldValue10021 = var_168_21.alpha
					arg_165_1.var_.characterEffect10021 = var_168_21
				end

				arg_165_1.var_.alphaOldValue10021 = 0
			end

			local var_168_22 = 0.5

			if var_168_20 <= arg_165_1.time_ and arg_165_1.time_ < var_168_20 + var_168_22 then
				local var_168_23 = (arg_165_1.time_ - var_168_20) / var_168_22
				local var_168_24 = Mathf.Lerp(arg_165_1.var_.alphaOldValue10021, 1, var_168_23)

				if arg_165_1.var_.characterEffect10021 then
					arg_165_1.var_.characterEffect10021.alpha = var_168_24
				end
			end

			if arg_165_1.time_ >= var_168_20 + var_168_22 and arg_165_1.time_ < var_168_20 + var_168_22 + arg_168_0 and arg_165_1.var_.characterEffect10021 then
				arg_165_1.var_.characterEffect10021.alpha = 1
			end

			local var_168_25 = 0
			local var_168_26 = 0.775

			if var_168_25 < arg_165_1.time_ and arg_165_1.time_ <= var_168_25 + arg_168_0 then
				arg_165_1.talkMaxDuration = 0
				arg_165_1.dialogCg_.alpha = 1

				arg_165_1.dialog_:SetActive(true)
				SetActive(arg_165_1.leftNameGo_, true)

				local var_168_27 = arg_165_1:FormatText(StoryNameCfg[226].name)

				arg_165_1.leftNameTxt_.text = var_168_27

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_165_1.leftNameTxt_.transform)

				arg_165_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_165_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_165_1:RecordName(arg_165_1.leftNameTxt_.text)
				SetActive(arg_165_1.iconTrs_.gameObject, false)
				arg_165_1.callingController_:SetSelectedState("normal")

				local var_168_28 = arg_165_1:GetWordFromCfg(114251040)
				local var_168_29 = arg_165_1:FormatText(var_168_28.content)

				arg_165_1.text_.text = var_168_29

				LuaForUtil.ClearLinePrefixSymbol(arg_165_1.text_)

				local var_168_30 = 30
				local var_168_31 = utf8.len(var_168_29)
				local var_168_32 = var_168_30 <= 0 and var_168_26 or var_168_26 * (var_168_31 / var_168_30)

				if var_168_32 > 0 and var_168_26 < var_168_32 then
					arg_165_1.talkMaxDuration = var_168_32

					if var_168_32 + var_168_25 > arg_165_1.duration_ then
						arg_165_1.duration_ = var_168_32 + var_168_25
					end
				end

				arg_165_1.text_.text = var_168_29
				arg_165_1.typewritter.percent = 0

				arg_165_1.typewritter:SetDirty()
				arg_165_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_114251", "114251040", "story_v_out_114251.awb") ~= 0 then
					local var_168_33 = manager.audio:GetVoiceLength("story_v_out_114251", "114251040", "story_v_out_114251.awb") / 1000

					if var_168_33 + var_168_25 > arg_165_1.duration_ then
						arg_165_1.duration_ = var_168_33 + var_168_25
					end

					if var_168_28.prefab_name ~= "" and arg_165_1.actors_[var_168_28.prefab_name] ~= nil then
						local var_168_34 = LuaForUtil.PlayVoiceWithCriLipsync(arg_165_1.actors_[var_168_28.prefab_name].transform, "story_v_out_114251", "114251040", "story_v_out_114251.awb")

						arg_165_1:RecordAudio("114251040", var_168_34)
						arg_165_1:RecordAudio("114251040", var_168_34)
					else
						arg_165_1:AudioAction("play", "voice", "story_v_out_114251", "114251040", "story_v_out_114251.awb")
					end

					arg_165_1:RecordHistoryTalkVoice("story_v_out_114251", "114251040", "story_v_out_114251.awb")
				end

				arg_165_1:RecordContent(arg_165_1.text_.text)
			end

			local var_168_35 = math.max(var_168_26, arg_165_1.talkMaxDuration)

			if var_168_25 <= arg_165_1.time_ and arg_165_1.time_ < var_168_25 + var_168_35 then
				arg_165_1.typewritter.percent = (arg_165_1.time_ - var_168_25) / var_168_35

				arg_165_1.typewritter:SetDirty()
			end

			if arg_165_1.time_ >= var_168_25 + var_168_35 and arg_165_1.time_ < var_168_25 + var_168_35 + arg_168_0 then
				arg_165_1.typewritter.percent = 1

				arg_165_1.typewritter:SetDirty()
				arg_165_1:ShowNextGo(true)
			end
		end

		arg_165_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10021",
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
	Play114251041 = function(arg_169_0, arg_169_1)
		arg_169_1.time_ = 0
		arg_169_1.frameCnt_ = 0
		arg_169_1.state_ = "playing"
		arg_169_1.curTalkId_ = 114251041
		arg_169_1.duration_ = 11

		local var_169_0 = {
			ja = 11,
			ko = 9.3,
			zh = 7.8,
			en = 10.666
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
				arg_169_0:Play114251042(arg_169_1)
			end
		end

		function arg_169_1.onSingleLineUpdate_(arg_172_0)
			local var_172_0 = arg_169_1.actors_["10018"].transform
			local var_172_1 = 0

			if var_172_1 < arg_169_1.time_ and arg_169_1.time_ <= var_172_1 + arg_172_0 then
				arg_169_1.var_.moveOldPos10018 = var_172_0.localPosition
				var_172_0.localScale = Vector3.New(1, 1, 1)

				arg_169_1:CheckSpriteTmpPos("10018", 4)

				local var_172_2 = var_172_0.childCount

				for iter_172_0 = 0, var_172_2 - 1 do
					local var_172_3 = var_172_0:GetChild(iter_172_0)

					if var_172_3.name == "split_1" or not string.find(var_172_3.name, "split") then
						var_172_3.gameObject:SetActive(true)
					else
						var_172_3.gameObject:SetActive(false)
					end
				end
			end

			local var_172_4 = 0.001

			if var_172_1 <= arg_169_1.time_ and arg_169_1.time_ < var_172_1 + var_172_4 then
				local var_172_5 = (arg_169_1.time_ - var_172_1) / var_172_4
				local var_172_6 = Vector3.New(390, -350, -180)

				var_172_0.localPosition = Vector3.Lerp(arg_169_1.var_.moveOldPos10018, var_172_6, var_172_5)
			end

			if arg_169_1.time_ >= var_172_1 + var_172_4 and arg_169_1.time_ < var_172_1 + var_172_4 + arg_172_0 then
				var_172_0.localPosition = Vector3.New(390, -350, -180)
			end

			local var_172_7 = arg_169_1.actors_["10021"]
			local var_172_8 = 0

			if var_172_8 < arg_169_1.time_ and arg_169_1.time_ <= var_172_8 + arg_172_0 and not isNil(var_172_7) and arg_169_1.var_.actorSpriteComps10021 == nil then
				arg_169_1.var_.actorSpriteComps10021 = var_172_7:GetComponentsInChildren(typeof(Image), true)
			end

			local var_172_9 = 0.034

			if var_172_8 <= arg_169_1.time_ and arg_169_1.time_ < var_172_8 + var_172_9 and not isNil(var_172_7) then
				local var_172_10 = (arg_169_1.time_ - var_172_8) / var_172_9

				if arg_169_1.var_.actorSpriteComps10021 then
					for iter_172_1, iter_172_2 in pairs(arg_169_1.var_.actorSpriteComps10021:ToTable()) do
						if iter_172_2 then
							if arg_169_1.isInRecall_ then
								local var_172_11 = Mathf.Lerp(iter_172_2.color.r, arg_169_1.hightColor2.r, var_172_10)
								local var_172_12 = Mathf.Lerp(iter_172_2.color.g, arg_169_1.hightColor2.g, var_172_10)
								local var_172_13 = Mathf.Lerp(iter_172_2.color.b, arg_169_1.hightColor2.b, var_172_10)

								iter_172_2.color = Color.New(var_172_11, var_172_12, var_172_13)
							else
								local var_172_14 = Mathf.Lerp(iter_172_2.color.r, 0.5, var_172_10)

								iter_172_2.color = Color.New(var_172_14, var_172_14, var_172_14)
							end
						end
					end
				end
			end

			if arg_169_1.time_ >= var_172_8 + var_172_9 and arg_169_1.time_ < var_172_8 + var_172_9 + arg_172_0 and not isNil(var_172_7) and arg_169_1.var_.actorSpriteComps10021 then
				for iter_172_3, iter_172_4 in pairs(arg_169_1.var_.actorSpriteComps10021:ToTable()) do
					if iter_172_4 then
						if arg_169_1.isInRecall_ then
							iter_172_4.color = arg_169_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_172_4.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_169_1.var_.actorSpriteComps10021 = nil
			end

			local var_172_15 = arg_169_1.actors_["10018"]
			local var_172_16 = 0

			if var_172_16 < arg_169_1.time_ and arg_169_1.time_ <= var_172_16 + arg_172_0 and not isNil(var_172_15) and arg_169_1.var_.actorSpriteComps10018 == nil then
				arg_169_1.var_.actorSpriteComps10018 = var_172_15:GetComponentsInChildren(typeof(Image), true)
			end

			local var_172_17 = 0.034

			if var_172_16 <= arg_169_1.time_ and arg_169_1.time_ < var_172_16 + var_172_17 and not isNil(var_172_15) then
				local var_172_18 = (arg_169_1.time_ - var_172_16) / var_172_17

				if arg_169_1.var_.actorSpriteComps10018 then
					for iter_172_5, iter_172_6 in pairs(arg_169_1.var_.actorSpriteComps10018:ToTable()) do
						if iter_172_6 then
							if arg_169_1.isInRecall_ then
								local var_172_19 = Mathf.Lerp(iter_172_6.color.r, arg_169_1.hightColor1.r, var_172_18)
								local var_172_20 = Mathf.Lerp(iter_172_6.color.g, arg_169_1.hightColor1.g, var_172_18)
								local var_172_21 = Mathf.Lerp(iter_172_6.color.b, arg_169_1.hightColor1.b, var_172_18)

								iter_172_6.color = Color.New(var_172_19, var_172_20, var_172_21)
							else
								local var_172_22 = Mathf.Lerp(iter_172_6.color.r, 1, var_172_18)

								iter_172_6.color = Color.New(var_172_22, var_172_22, var_172_22)
							end
						end
					end
				end
			end

			if arg_169_1.time_ >= var_172_16 + var_172_17 and arg_169_1.time_ < var_172_16 + var_172_17 + arg_172_0 and not isNil(var_172_15) and arg_169_1.var_.actorSpriteComps10018 then
				for iter_172_7, iter_172_8 in pairs(arg_169_1.var_.actorSpriteComps10018:ToTable()) do
					if iter_172_8 then
						if arg_169_1.isInRecall_ then
							iter_172_8.color = arg_169_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_172_8.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_169_1.var_.actorSpriteComps10018 = nil
			end

			local var_172_23 = arg_169_1.actors_["10018"]
			local var_172_24 = 0

			if var_172_24 < arg_169_1.time_ and arg_169_1.time_ <= var_172_24 + arg_172_0 then
				local var_172_25 = var_172_23:GetComponentInChildren(typeof(CanvasGroup))

				if var_172_25 then
					arg_169_1.var_.alphaOldValue10018 = var_172_25.alpha
					arg_169_1.var_.characterEffect10018 = var_172_25
				end

				arg_169_1.var_.alphaOldValue10018 = 0
			end

			local var_172_26 = 0.5

			if var_172_24 <= arg_169_1.time_ and arg_169_1.time_ < var_172_24 + var_172_26 then
				local var_172_27 = (arg_169_1.time_ - var_172_24) / var_172_26
				local var_172_28 = Mathf.Lerp(arg_169_1.var_.alphaOldValue10018, 1, var_172_27)

				if arg_169_1.var_.characterEffect10018 then
					arg_169_1.var_.characterEffect10018.alpha = var_172_28
				end
			end

			if arg_169_1.time_ >= var_172_24 + var_172_26 and arg_169_1.time_ < var_172_24 + var_172_26 + arg_172_0 and arg_169_1.var_.characterEffect10018 then
				arg_169_1.var_.characterEffect10018.alpha = 1
			end

			local var_172_29 = 0
			local var_172_30 = 1.025

			if var_172_29 < arg_169_1.time_ and arg_169_1.time_ <= var_172_29 + arg_172_0 then
				arg_169_1.talkMaxDuration = 0
				arg_169_1.dialogCg_.alpha = 1

				arg_169_1.dialog_:SetActive(true)
				SetActive(arg_169_1.leftNameGo_, true)

				local var_172_31 = arg_169_1:FormatText(StoryNameCfg[258].name)

				arg_169_1.leftNameTxt_.text = var_172_31

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_169_1.leftNameTxt_.transform)

				arg_169_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_169_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_169_1:RecordName(arg_169_1.leftNameTxt_.text)
				SetActive(arg_169_1.iconTrs_.gameObject, false)
				arg_169_1.callingController_:SetSelectedState("normal")

				local var_172_32 = arg_169_1:GetWordFromCfg(114251041)
				local var_172_33 = arg_169_1:FormatText(var_172_32.content)

				arg_169_1.text_.text = var_172_33

				LuaForUtil.ClearLinePrefixSymbol(arg_169_1.text_)

				local var_172_34 = 41
				local var_172_35 = utf8.len(var_172_33)
				local var_172_36 = var_172_34 <= 0 and var_172_30 or var_172_30 * (var_172_35 / var_172_34)

				if var_172_36 > 0 and var_172_30 < var_172_36 then
					arg_169_1.talkMaxDuration = var_172_36

					if var_172_36 + var_172_29 > arg_169_1.duration_ then
						arg_169_1.duration_ = var_172_36 + var_172_29
					end
				end

				arg_169_1.text_.text = var_172_33
				arg_169_1.typewritter.percent = 0

				arg_169_1.typewritter:SetDirty()
				arg_169_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_114251", "114251041", "story_v_out_114251.awb") ~= 0 then
					local var_172_37 = manager.audio:GetVoiceLength("story_v_out_114251", "114251041", "story_v_out_114251.awb") / 1000

					if var_172_37 + var_172_29 > arg_169_1.duration_ then
						arg_169_1.duration_ = var_172_37 + var_172_29
					end

					if var_172_32.prefab_name ~= "" and arg_169_1.actors_[var_172_32.prefab_name] ~= nil then
						local var_172_38 = LuaForUtil.PlayVoiceWithCriLipsync(arg_169_1.actors_[var_172_32.prefab_name].transform, "story_v_out_114251", "114251041", "story_v_out_114251.awb")

						arg_169_1:RecordAudio("114251041", var_172_38)
						arg_169_1:RecordAudio("114251041", var_172_38)
					else
						arg_169_1:AudioAction("play", "voice", "story_v_out_114251", "114251041", "story_v_out_114251.awb")
					end

					arg_169_1:RecordHistoryTalkVoice("story_v_out_114251", "114251041", "story_v_out_114251.awb")
				end

				arg_169_1:RecordContent(arg_169_1.text_.text)
			end

			local var_172_39 = math.max(var_172_30, arg_169_1.talkMaxDuration)

			if var_172_29 <= arg_169_1.time_ and arg_169_1.time_ < var_172_29 + var_172_39 then
				arg_169_1.typewritter.percent = (arg_169_1.time_ - var_172_29) / var_172_39

				arg_169_1.typewritter:SetDirty()
			end

			if arg_169_1.time_ >= var_172_29 + var_172_39 and arg_169_1.time_ < var_172_29 + var_172_39 + arg_172_0 then
				arg_169_1.typewritter.percent = 1

				arg_169_1.typewritter:SetDirty()
				arg_169_1:ShowNextGo(true)
			end
		end

		arg_169_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10018",
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
	Play114251042 = function(arg_173_0, arg_173_1)
		arg_173_1.time_ = 0
		arg_173_1.frameCnt_ = 0
		arg_173_1.state_ = "playing"
		arg_173_1.curTalkId_ = 114251042
		arg_173_1.duration_ = 3.63

		local var_173_0 = {
			ja = 3.066,
			ko = 1.766,
			zh = 2.033,
			en = 3.633
		}
		local var_173_1 = manager.audio:GetLocalizationFlag()

		if var_173_0[var_173_1] ~= nil then
			arg_173_1.duration_ = var_173_0[var_173_1]
		end

		SetActive(arg_173_1.tipsGo_, false)

		function arg_173_1.onSingleLineFinish_()
			arg_173_1.onSingleLineUpdate_ = nil
			arg_173_1.onSingleLineFinish_ = nil
			arg_173_1.state_ = "waiting"
		end

		function arg_173_1.playNext_(arg_175_0)
			if arg_175_0 == 1 then
				arg_173_0:Play114251043(arg_173_1)
			end
		end

		function arg_173_1.onSingleLineUpdate_(arg_176_0)
			local var_176_0 = arg_173_1.actors_["10021"]
			local var_176_1 = 0

			if var_176_1 < arg_173_1.time_ and arg_173_1.time_ <= var_176_1 + arg_176_0 and not isNil(var_176_0) and arg_173_1.var_.actorSpriteComps10021 == nil then
				arg_173_1.var_.actorSpriteComps10021 = var_176_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_176_2 = 0.034

			if var_176_1 <= arg_173_1.time_ and arg_173_1.time_ < var_176_1 + var_176_2 and not isNil(var_176_0) then
				local var_176_3 = (arg_173_1.time_ - var_176_1) / var_176_2

				if arg_173_1.var_.actorSpriteComps10021 then
					for iter_176_0, iter_176_1 in pairs(arg_173_1.var_.actorSpriteComps10021:ToTable()) do
						if iter_176_1 then
							if arg_173_1.isInRecall_ then
								local var_176_4 = Mathf.Lerp(iter_176_1.color.r, arg_173_1.hightColor1.r, var_176_3)
								local var_176_5 = Mathf.Lerp(iter_176_1.color.g, arg_173_1.hightColor1.g, var_176_3)
								local var_176_6 = Mathf.Lerp(iter_176_1.color.b, arg_173_1.hightColor1.b, var_176_3)

								iter_176_1.color = Color.New(var_176_4, var_176_5, var_176_6)
							else
								local var_176_7 = Mathf.Lerp(iter_176_1.color.r, 1, var_176_3)

								iter_176_1.color = Color.New(var_176_7, var_176_7, var_176_7)
							end
						end
					end
				end
			end

			if arg_173_1.time_ >= var_176_1 + var_176_2 and arg_173_1.time_ < var_176_1 + var_176_2 + arg_176_0 and not isNil(var_176_0) and arg_173_1.var_.actorSpriteComps10021 then
				for iter_176_2, iter_176_3 in pairs(arg_173_1.var_.actorSpriteComps10021:ToTable()) do
					if iter_176_3 then
						if arg_173_1.isInRecall_ then
							iter_176_3.color = arg_173_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_176_3.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_173_1.var_.actorSpriteComps10021 = nil
			end

			local var_176_8 = arg_173_1.actors_["10018"]
			local var_176_9 = 0

			if var_176_9 < arg_173_1.time_ and arg_173_1.time_ <= var_176_9 + arg_176_0 and not isNil(var_176_8) and arg_173_1.var_.actorSpriteComps10018 == nil then
				arg_173_1.var_.actorSpriteComps10018 = var_176_8:GetComponentsInChildren(typeof(Image), true)
			end

			local var_176_10 = 0.034

			if var_176_9 <= arg_173_1.time_ and arg_173_1.time_ < var_176_9 + var_176_10 and not isNil(var_176_8) then
				local var_176_11 = (arg_173_1.time_ - var_176_9) / var_176_10

				if arg_173_1.var_.actorSpriteComps10018 then
					for iter_176_4, iter_176_5 in pairs(arg_173_1.var_.actorSpriteComps10018:ToTable()) do
						if iter_176_5 then
							if arg_173_1.isInRecall_ then
								local var_176_12 = Mathf.Lerp(iter_176_5.color.r, arg_173_1.hightColor2.r, var_176_11)
								local var_176_13 = Mathf.Lerp(iter_176_5.color.g, arg_173_1.hightColor2.g, var_176_11)
								local var_176_14 = Mathf.Lerp(iter_176_5.color.b, arg_173_1.hightColor2.b, var_176_11)

								iter_176_5.color = Color.New(var_176_12, var_176_13, var_176_14)
							else
								local var_176_15 = Mathf.Lerp(iter_176_5.color.r, 0.5, var_176_11)

								iter_176_5.color = Color.New(var_176_15, var_176_15, var_176_15)
							end
						end
					end
				end
			end

			if arg_173_1.time_ >= var_176_9 + var_176_10 and arg_173_1.time_ < var_176_9 + var_176_10 + arg_176_0 and not isNil(var_176_8) and arg_173_1.var_.actorSpriteComps10018 then
				for iter_176_6, iter_176_7 in pairs(arg_173_1.var_.actorSpriteComps10018:ToTable()) do
					if iter_176_7 then
						if arg_173_1.isInRecall_ then
							iter_176_7.color = arg_173_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_176_7.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_173_1.var_.actorSpriteComps10018 = nil
			end

			local var_176_16 = 0
			local var_176_17 = 0.225

			if var_176_16 < arg_173_1.time_ and arg_173_1.time_ <= var_176_16 + arg_176_0 then
				arg_173_1.talkMaxDuration = 0
				arg_173_1.dialogCg_.alpha = 1

				arg_173_1.dialog_:SetActive(true)
				SetActive(arg_173_1.leftNameGo_, true)

				local var_176_18 = arg_173_1:FormatText(StoryNameCfg[226].name)

				arg_173_1.leftNameTxt_.text = var_176_18

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_173_1.leftNameTxt_.transform)

				arg_173_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_173_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_173_1:RecordName(arg_173_1.leftNameTxt_.text)
				SetActive(arg_173_1.iconTrs_.gameObject, false)
				arg_173_1.callingController_:SetSelectedState("normal")

				local var_176_19 = arg_173_1:GetWordFromCfg(114251042)
				local var_176_20 = arg_173_1:FormatText(var_176_19.content)

				arg_173_1.text_.text = var_176_20

				LuaForUtil.ClearLinePrefixSymbol(arg_173_1.text_)

				local var_176_21 = 9
				local var_176_22 = utf8.len(var_176_20)
				local var_176_23 = var_176_21 <= 0 and var_176_17 or var_176_17 * (var_176_22 / var_176_21)

				if var_176_23 > 0 and var_176_17 < var_176_23 then
					arg_173_1.talkMaxDuration = var_176_23

					if var_176_23 + var_176_16 > arg_173_1.duration_ then
						arg_173_1.duration_ = var_176_23 + var_176_16
					end
				end

				arg_173_1.text_.text = var_176_20
				arg_173_1.typewritter.percent = 0

				arg_173_1.typewritter:SetDirty()
				arg_173_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_114251", "114251042", "story_v_out_114251.awb") ~= 0 then
					local var_176_24 = manager.audio:GetVoiceLength("story_v_out_114251", "114251042", "story_v_out_114251.awb") / 1000

					if var_176_24 + var_176_16 > arg_173_1.duration_ then
						arg_173_1.duration_ = var_176_24 + var_176_16
					end

					if var_176_19.prefab_name ~= "" and arg_173_1.actors_[var_176_19.prefab_name] ~= nil then
						local var_176_25 = LuaForUtil.PlayVoiceWithCriLipsync(arg_173_1.actors_[var_176_19.prefab_name].transform, "story_v_out_114251", "114251042", "story_v_out_114251.awb")

						arg_173_1:RecordAudio("114251042", var_176_25)
						arg_173_1:RecordAudio("114251042", var_176_25)
					else
						arg_173_1:AudioAction("play", "voice", "story_v_out_114251", "114251042", "story_v_out_114251.awb")
					end

					arg_173_1:RecordHistoryTalkVoice("story_v_out_114251", "114251042", "story_v_out_114251.awb")
				end

				arg_173_1:RecordContent(arg_173_1.text_.text)
			end

			local var_176_26 = math.max(var_176_17, arg_173_1.talkMaxDuration)

			if var_176_16 <= arg_173_1.time_ and arg_173_1.time_ < var_176_16 + var_176_26 then
				arg_173_1.typewritter.percent = (arg_173_1.time_ - var_176_16) / var_176_26

				arg_173_1.typewritter:SetDirty()
			end

			if arg_173_1.time_ >= var_176_16 + var_176_26 and arg_173_1.time_ < var_176_16 + var_176_26 + arg_176_0 then
				arg_173_1.typewritter.percent = 1

				arg_173_1.typewritter:SetDirty()
				arg_173_1:ShowNextGo(true)
			end
		end

		arg_173_1.nodeConfigList_ = {}

		arg_173_1:InitPlayNodeList()
	end,
	Play114251043 = function(arg_177_0, arg_177_1)
		arg_177_1.time_ = 0
		arg_177_1.frameCnt_ = 0
		arg_177_1.state_ = "playing"
		arg_177_1.curTalkId_ = 114251043
		arg_177_1.duration_ = 9.2

		local var_177_0 = {
			ja = 7.866,
			ko = 8.733,
			zh = 9.2,
			en = 8.4
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
				arg_177_0:Play114251044(arg_177_1)
			end
		end

		function arg_177_1.onSingleLineUpdate_(arg_180_0)
			local var_180_0 = 0
			local var_180_1 = 1.225

			if var_180_0 < arg_177_1.time_ and arg_177_1.time_ <= var_180_0 + arg_180_0 then
				arg_177_1.talkMaxDuration = 0
				arg_177_1.dialogCg_.alpha = 1

				arg_177_1.dialog_:SetActive(true)
				SetActive(arg_177_1.leftNameGo_, true)

				local var_180_2 = arg_177_1:FormatText(StoryNameCfg[226].name)

				arg_177_1.leftNameTxt_.text = var_180_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_177_1.leftNameTxt_.transform)

				arg_177_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_177_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_177_1:RecordName(arg_177_1.leftNameTxt_.text)
				SetActive(arg_177_1.iconTrs_.gameObject, false)
				arg_177_1.callingController_:SetSelectedState("normal")

				local var_180_3 = arg_177_1:GetWordFromCfg(114251043)
				local var_180_4 = arg_177_1:FormatText(var_180_3.content)

				arg_177_1.text_.text = var_180_4

				LuaForUtil.ClearLinePrefixSymbol(arg_177_1.text_)

				local var_180_5 = 49
				local var_180_6 = utf8.len(var_180_4)
				local var_180_7 = var_180_5 <= 0 and var_180_1 or var_180_1 * (var_180_6 / var_180_5)

				if var_180_7 > 0 and var_180_1 < var_180_7 then
					arg_177_1.talkMaxDuration = var_180_7

					if var_180_7 + var_180_0 > arg_177_1.duration_ then
						arg_177_1.duration_ = var_180_7 + var_180_0
					end
				end

				arg_177_1.text_.text = var_180_4
				arg_177_1.typewritter.percent = 0

				arg_177_1.typewritter:SetDirty()
				arg_177_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_114251", "114251043", "story_v_out_114251.awb") ~= 0 then
					local var_180_8 = manager.audio:GetVoiceLength("story_v_out_114251", "114251043", "story_v_out_114251.awb") / 1000

					if var_180_8 + var_180_0 > arg_177_1.duration_ then
						arg_177_1.duration_ = var_180_8 + var_180_0
					end

					if var_180_3.prefab_name ~= "" and arg_177_1.actors_[var_180_3.prefab_name] ~= nil then
						local var_180_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_177_1.actors_[var_180_3.prefab_name].transform, "story_v_out_114251", "114251043", "story_v_out_114251.awb")

						arg_177_1:RecordAudio("114251043", var_180_9)
						arg_177_1:RecordAudio("114251043", var_180_9)
					else
						arg_177_1:AudioAction("play", "voice", "story_v_out_114251", "114251043", "story_v_out_114251.awb")
					end

					arg_177_1:RecordHistoryTalkVoice("story_v_out_114251", "114251043", "story_v_out_114251.awb")
				end

				arg_177_1:RecordContent(arg_177_1.text_.text)
			end

			local var_180_10 = math.max(var_180_1, arg_177_1.talkMaxDuration)

			if var_180_0 <= arg_177_1.time_ and arg_177_1.time_ < var_180_0 + var_180_10 then
				arg_177_1.typewritter.percent = (arg_177_1.time_ - var_180_0) / var_180_10

				arg_177_1.typewritter:SetDirty()
			end

			if arg_177_1.time_ >= var_180_0 + var_180_10 and arg_177_1.time_ < var_180_0 + var_180_10 + arg_180_0 then
				arg_177_1.typewritter.percent = 1

				arg_177_1.typewritter:SetDirty()
				arg_177_1:ShowNextGo(true)
			end
		end

		arg_177_1.nodeConfigList_ = {}

		arg_177_1:InitPlayNodeList()
	end,
	Play114251044 = function(arg_181_0, arg_181_1)
		arg_181_1.time_ = 0
		arg_181_1.frameCnt_ = 0
		arg_181_1.state_ = "playing"
		arg_181_1.curTalkId_ = 114251044
		arg_181_1.duration_ = 9.4

		local var_181_0 = {
			ja = 6.066,
			ko = 8.666,
			zh = 8.9,
			en = 9.4
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
				arg_181_0:Play114251045(arg_181_1)
			end
		end

		function arg_181_1.onSingleLineUpdate_(arg_184_0)
			local var_184_0 = 0
			local var_184_1 = 1.05

			if var_184_0 < arg_181_1.time_ and arg_181_1.time_ <= var_184_0 + arg_184_0 then
				arg_181_1.talkMaxDuration = 0
				arg_181_1.dialogCg_.alpha = 1

				arg_181_1.dialog_:SetActive(true)
				SetActive(arg_181_1.leftNameGo_, true)

				local var_184_2 = arg_181_1:FormatText(StoryNameCfg[226].name)

				arg_181_1.leftNameTxt_.text = var_184_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_181_1.leftNameTxt_.transform)

				arg_181_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_181_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_181_1:RecordName(arg_181_1.leftNameTxt_.text)
				SetActive(arg_181_1.iconTrs_.gameObject, false)
				arg_181_1.callingController_:SetSelectedState("normal")

				local var_184_3 = arg_181_1:GetWordFromCfg(114251044)
				local var_184_4 = arg_181_1:FormatText(var_184_3.content)

				arg_181_1.text_.text = var_184_4

				LuaForUtil.ClearLinePrefixSymbol(arg_181_1.text_)

				local var_184_5 = 42
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

				if manager.audio:GetVoiceLength("story_v_out_114251", "114251044", "story_v_out_114251.awb") ~= 0 then
					local var_184_8 = manager.audio:GetVoiceLength("story_v_out_114251", "114251044", "story_v_out_114251.awb") / 1000

					if var_184_8 + var_184_0 > arg_181_1.duration_ then
						arg_181_1.duration_ = var_184_8 + var_184_0
					end

					if var_184_3.prefab_name ~= "" and arg_181_1.actors_[var_184_3.prefab_name] ~= nil then
						local var_184_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_181_1.actors_[var_184_3.prefab_name].transform, "story_v_out_114251", "114251044", "story_v_out_114251.awb")

						arg_181_1:RecordAudio("114251044", var_184_9)
						arg_181_1:RecordAudio("114251044", var_184_9)
					else
						arg_181_1:AudioAction("play", "voice", "story_v_out_114251", "114251044", "story_v_out_114251.awb")
					end

					arg_181_1:RecordHistoryTalkVoice("story_v_out_114251", "114251044", "story_v_out_114251.awb")
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
	Play114251045 = function(arg_185_0, arg_185_1)
		arg_185_1.time_ = 0
		arg_185_1.frameCnt_ = 0
		arg_185_1.state_ = "playing"
		arg_185_1.curTalkId_ = 114251045
		arg_185_1.duration_ = 5.43

		local var_185_0 = {
			ja = 5.433,
			ko = 2.366,
			zh = 4.033,
			en = 3.633
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
				arg_185_0:Play114251046(arg_185_1)
			end
		end

		function arg_185_1.onSingleLineUpdate_(arg_188_0)
			local var_188_0 = arg_185_1.actors_["10018"].transform
			local var_188_1 = 0

			if var_188_1 < arg_185_1.time_ and arg_185_1.time_ <= var_188_1 + arg_188_0 then
				arg_185_1.var_.moveOldPos10018 = var_188_0.localPosition
				var_188_0.localScale = Vector3.New(1, 1, 1)

				arg_185_1:CheckSpriteTmpPos("10018", 4)

				local var_188_2 = var_188_0.childCount

				for iter_188_0 = 0, var_188_2 - 1 do
					local var_188_3 = var_188_0:GetChild(iter_188_0)

					if var_188_3.name == "split_2" or not string.find(var_188_3.name, "split") then
						var_188_3.gameObject:SetActive(true)
					else
						var_188_3.gameObject:SetActive(false)
					end
				end
			end

			local var_188_4 = 0.001

			if var_188_1 <= arg_185_1.time_ and arg_185_1.time_ < var_188_1 + var_188_4 then
				local var_188_5 = (arg_185_1.time_ - var_188_1) / var_188_4
				local var_188_6 = Vector3.New(390, -350, -180)

				var_188_0.localPosition = Vector3.Lerp(arg_185_1.var_.moveOldPos10018, var_188_6, var_188_5)
			end

			if arg_185_1.time_ >= var_188_1 + var_188_4 and arg_185_1.time_ < var_188_1 + var_188_4 + arg_188_0 then
				var_188_0.localPosition = Vector3.New(390, -350, -180)
			end

			local var_188_7 = arg_185_1.actors_["10021"]
			local var_188_8 = 0

			if var_188_8 < arg_185_1.time_ and arg_185_1.time_ <= var_188_8 + arg_188_0 and not isNil(var_188_7) and arg_185_1.var_.actorSpriteComps10021 == nil then
				arg_185_1.var_.actorSpriteComps10021 = var_188_7:GetComponentsInChildren(typeof(Image), true)
			end

			local var_188_9 = 0.034

			if var_188_8 <= arg_185_1.time_ and arg_185_1.time_ < var_188_8 + var_188_9 and not isNil(var_188_7) then
				local var_188_10 = (arg_185_1.time_ - var_188_8) / var_188_9

				if arg_185_1.var_.actorSpriteComps10021 then
					for iter_188_1, iter_188_2 in pairs(arg_185_1.var_.actorSpriteComps10021:ToTable()) do
						if iter_188_2 then
							if arg_185_1.isInRecall_ then
								local var_188_11 = Mathf.Lerp(iter_188_2.color.r, arg_185_1.hightColor2.r, var_188_10)
								local var_188_12 = Mathf.Lerp(iter_188_2.color.g, arg_185_1.hightColor2.g, var_188_10)
								local var_188_13 = Mathf.Lerp(iter_188_2.color.b, arg_185_1.hightColor2.b, var_188_10)

								iter_188_2.color = Color.New(var_188_11, var_188_12, var_188_13)
							else
								local var_188_14 = Mathf.Lerp(iter_188_2.color.r, 0.5, var_188_10)

								iter_188_2.color = Color.New(var_188_14, var_188_14, var_188_14)
							end
						end
					end
				end
			end

			if arg_185_1.time_ >= var_188_8 + var_188_9 and arg_185_1.time_ < var_188_8 + var_188_9 + arg_188_0 and not isNil(var_188_7) and arg_185_1.var_.actorSpriteComps10021 then
				for iter_188_3, iter_188_4 in pairs(arg_185_1.var_.actorSpriteComps10021:ToTable()) do
					if iter_188_4 then
						if arg_185_1.isInRecall_ then
							iter_188_4.color = arg_185_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_188_4.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_185_1.var_.actorSpriteComps10021 = nil
			end

			local var_188_15 = arg_185_1.actors_["10018"]
			local var_188_16 = 0

			if var_188_16 < arg_185_1.time_ and arg_185_1.time_ <= var_188_16 + arg_188_0 and not isNil(var_188_15) and arg_185_1.var_.actorSpriteComps10018 == nil then
				arg_185_1.var_.actorSpriteComps10018 = var_188_15:GetComponentsInChildren(typeof(Image), true)
			end

			local var_188_17 = 0.034

			if var_188_16 <= arg_185_1.time_ and arg_185_1.time_ < var_188_16 + var_188_17 and not isNil(var_188_15) then
				local var_188_18 = (arg_185_1.time_ - var_188_16) / var_188_17

				if arg_185_1.var_.actorSpriteComps10018 then
					for iter_188_5, iter_188_6 in pairs(arg_185_1.var_.actorSpriteComps10018:ToTable()) do
						if iter_188_6 then
							if arg_185_1.isInRecall_ then
								local var_188_19 = Mathf.Lerp(iter_188_6.color.r, arg_185_1.hightColor1.r, var_188_18)
								local var_188_20 = Mathf.Lerp(iter_188_6.color.g, arg_185_1.hightColor1.g, var_188_18)
								local var_188_21 = Mathf.Lerp(iter_188_6.color.b, arg_185_1.hightColor1.b, var_188_18)

								iter_188_6.color = Color.New(var_188_19, var_188_20, var_188_21)
							else
								local var_188_22 = Mathf.Lerp(iter_188_6.color.r, 1, var_188_18)

								iter_188_6.color = Color.New(var_188_22, var_188_22, var_188_22)
							end
						end
					end
				end
			end

			if arg_185_1.time_ >= var_188_16 + var_188_17 and arg_185_1.time_ < var_188_16 + var_188_17 + arg_188_0 and not isNil(var_188_15) and arg_185_1.var_.actorSpriteComps10018 then
				for iter_188_7, iter_188_8 in pairs(arg_185_1.var_.actorSpriteComps10018:ToTable()) do
					if iter_188_8 then
						if arg_185_1.isInRecall_ then
							iter_188_8.color = arg_185_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_188_8.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_185_1.var_.actorSpriteComps10018 = nil
			end

			local var_188_23 = 0
			local var_188_24 = 0.25

			if var_188_23 < arg_185_1.time_ and arg_185_1.time_ <= var_188_23 + arg_188_0 then
				arg_185_1.talkMaxDuration = 0
				arg_185_1.dialogCg_.alpha = 1

				arg_185_1.dialog_:SetActive(true)
				SetActive(arg_185_1.leftNameGo_, true)

				local var_188_25 = arg_185_1:FormatText(StoryNameCfg[258].name)

				arg_185_1.leftNameTxt_.text = var_188_25

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_185_1.leftNameTxt_.transform)

				arg_185_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_185_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_185_1:RecordName(arg_185_1.leftNameTxt_.text)
				SetActive(arg_185_1.iconTrs_.gameObject, false)
				arg_185_1.callingController_:SetSelectedState("normal")

				local var_188_26 = arg_185_1:GetWordFromCfg(114251045)
				local var_188_27 = arg_185_1:FormatText(var_188_26.content)

				arg_185_1.text_.text = var_188_27

				LuaForUtil.ClearLinePrefixSymbol(arg_185_1.text_)

				local var_188_28 = 10
				local var_188_29 = utf8.len(var_188_27)
				local var_188_30 = var_188_28 <= 0 and var_188_24 or var_188_24 * (var_188_29 / var_188_28)

				if var_188_30 > 0 and var_188_24 < var_188_30 then
					arg_185_1.talkMaxDuration = var_188_30

					if var_188_30 + var_188_23 > arg_185_1.duration_ then
						arg_185_1.duration_ = var_188_30 + var_188_23
					end
				end

				arg_185_1.text_.text = var_188_27
				arg_185_1.typewritter.percent = 0

				arg_185_1.typewritter:SetDirty()
				arg_185_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_114251", "114251045", "story_v_out_114251.awb") ~= 0 then
					local var_188_31 = manager.audio:GetVoiceLength("story_v_out_114251", "114251045", "story_v_out_114251.awb") / 1000

					if var_188_31 + var_188_23 > arg_185_1.duration_ then
						arg_185_1.duration_ = var_188_31 + var_188_23
					end

					if var_188_26.prefab_name ~= "" and arg_185_1.actors_[var_188_26.prefab_name] ~= nil then
						local var_188_32 = LuaForUtil.PlayVoiceWithCriLipsync(arg_185_1.actors_[var_188_26.prefab_name].transform, "story_v_out_114251", "114251045", "story_v_out_114251.awb")

						arg_185_1:RecordAudio("114251045", var_188_32)
						arg_185_1:RecordAudio("114251045", var_188_32)
					else
						arg_185_1:AudioAction("play", "voice", "story_v_out_114251", "114251045", "story_v_out_114251.awb")
					end

					arg_185_1:RecordHistoryTalkVoice("story_v_out_114251", "114251045", "story_v_out_114251.awb")
				end

				arg_185_1:RecordContent(arg_185_1.text_.text)
			end

			local var_188_33 = math.max(var_188_24, arg_185_1.talkMaxDuration)

			if var_188_23 <= arg_185_1.time_ and arg_185_1.time_ < var_188_23 + var_188_33 then
				arg_185_1.typewritter.percent = (arg_185_1.time_ - var_188_23) / var_188_33

				arg_185_1.typewritter:SetDirty()
			end

			if arg_185_1.time_ >= var_188_23 + var_188_33 and arg_185_1.time_ < var_188_23 + var_188_33 + arg_188_0 then
				arg_185_1.typewritter.percent = 1

				arg_185_1.typewritter:SetDirty()
				arg_185_1:ShowNextGo(true)
			end
		end

		arg_185_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10018",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_185_1:InitPlayNodeList()
	end,
	Play114251046 = function(arg_189_0, arg_189_1)
		arg_189_1.time_ = 0
		arg_189_1.frameCnt_ = 0
		arg_189_1.state_ = "playing"
		arg_189_1.curTalkId_ = 114251046
		arg_189_1.duration_ = 8.97

		local var_189_0 = {
			ja = 4.1,
			ko = 6.2,
			zh = 8.966,
			en = 5.933
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
				arg_189_0:Play114251047(arg_189_1)
			end
		end

		function arg_189_1.onSingleLineUpdate_(arg_192_0)
			local var_192_0 = arg_189_1.actors_["10018"].transform
			local var_192_1 = 0

			if var_192_1 < arg_189_1.time_ and arg_189_1.time_ <= var_192_1 + arg_192_0 then
				arg_189_1.var_.moveOldPos10018 = var_192_0.localPosition
				var_192_0.localScale = Vector3.New(1, 1, 1)

				arg_189_1:CheckSpriteTmpPos("10018", 4)

				local var_192_2 = var_192_0.childCount

				for iter_192_0 = 0, var_192_2 - 1 do
					local var_192_3 = var_192_0:GetChild(iter_192_0)

					if var_192_3.name == "split_1" or not string.find(var_192_3.name, "split") then
						var_192_3.gameObject:SetActive(true)
					else
						var_192_3.gameObject:SetActive(false)
					end
				end
			end

			local var_192_4 = 0.001

			if var_192_1 <= arg_189_1.time_ and arg_189_1.time_ < var_192_1 + var_192_4 then
				local var_192_5 = (arg_189_1.time_ - var_192_1) / var_192_4
				local var_192_6 = Vector3.New(390, -350, -180)

				var_192_0.localPosition = Vector3.Lerp(arg_189_1.var_.moveOldPos10018, var_192_6, var_192_5)
			end

			if arg_189_1.time_ >= var_192_1 + var_192_4 and arg_189_1.time_ < var_192_1 + var_192_4 + arg_192_0 then
				var_192_0.localPosition = Vector3.New(390, -350, -180)
			end

			local var_192_7 = arg_189_1.actors_["10018"]
			local var_192_8 = 0

			if var_192_8 < arg_189_1.time_ and arg_189_1.time_ <= var_192_8 + arg_192_0 and not isNil(var_192_7) and arg_189_1.var_.actorSpriteComps10018 == nil then
				arg_189_1.var_.actorSpriteComps10018 = var_192_7:GetComponentsInChildren(typeof(Image), true)
			end

			local var_192_9 = 0.034

			if var_192_8 <= arg_189_1.time_ and arg_189_1.time_ < var_192_8 + var_192_9 and not isNil(var_192_7) then
				local var_192_10 = (arg_189_1.time_ - var_192_8) / var_192_9

				if arg_189_1.var_.actorSpriteComps10018 then
					for iter_192_1, iter_192_2 in pairs(arg_189_1.var_.actorSpriteComps10018:ToTable()) do
						if iter_192_2 then
							if arg_189_1.isInRecall_ then
								local var_192_11 = Mathf.Lerp(iter_192_2.color.r, arg_189_1.hightColor1.r, var_192_10)
								local var_192_12 = Mathf.Lerp(iter_192_2.color.g, arg_189_1.hightColor1.g, var_192_10)
								local var_192_13 = Mathf.Lerp(iter_192_2.color.b, arg_189_1.hightColor1.b, var_192_10)

								iter_192_2.color = Color.New(var_192_11, var_192_12, var_192_13)
							else
								local var_192_14 = Mathf.Lerp(iter_192_2.color.r, 1, var_192_10)

								iter_192_2.color = Color.New(var_192_14, var_192_14, var_192_14)
							end
						end
					end
				end
			end

			if arg_189_1.time_ >= var_192_8 + var_192_9 and arg_189_1.time_ < var_192_8 + var_192_9 + arg_192_0 and not isNil(var_192_7) and arg_189_1.var_.actorSpriteComps10018 then
				for iter_192_3, iter_192_4 in pairs(arg_189_1.var_.actorSpriteComps10018:ToTable()) do
					if iter_192_4 then
						if arg_189_1.isInRecall_ then
							iter_192_4.color = arg_189_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_192_4.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_189_1.var_.actorSpriteComps10018 = nil
			end

			local var_192_15 = 0
			local var_192_16 = 0.575

			if var_192_15 < arg_189_1.time_ and arg_189_1.time_ <= var_192_15 + arg_192_0 then
				arg_189_1.talkMaxDuration = 0
				arg_189_1.dialogCg_.alpha = 1

				arg_189_1.dialog_:SetActive(true)
				SetActive(arg_189_1.leftNameGo_, true)

				local var_192_17 = arg_189_1:FormatText(StoryNameCfg[258].name)

				arg_189_1.leftNameTxt_.text = var_192_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_189_1.leftNameTxt_.transform)

				arg_189_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_189_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_189_1:RecordName(arg_189_1.leftNameTxt_.text)
				SetActive(arg_189_1.iconTrs_.gameObject, false)
				arg_189_1.callingController_:SetSelectedState("normal")

				local var_192_18 = arg_189_1:GetWordFromCfg(114251046)
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

				if manager.audio:GetVoiceLength("story_v_out_114251", "114251046", "story_v_out_114251.awb") ~= 0 then
					local var_192_23 = manager.audio:GetVoiceLength("story_v_out_114251", "114251046", "story_v_out_114251.awb") / 1000

					if var_192_23 + var_192_15 > arg_189_1.duration_ then
						arg_189_1.duration_ = var_192_23 + var_192_15
					end

					if var_192_18.prefab_name ~= "" and arg_189_1.actors_[var_192_18.prefab_name] ~= nil then
						local var_192_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_189_1.actors_[var_192_18.prefab_name].transform, "story_v_out_114251", "114251046", "story_v_out_114251.awb")

						arg_189_1:RecordAudio("114251046", var_192_24)
						arg_189_1:RecordAudio("114251046", var_192_24)
					else
						arg_189_1:AudioAction("play", "voice", "story_v_out_114251", "114251046", "story_v_out_114251.awb")
					end

					arg_189_1:RecordHistoryTalkVoice("story_v_out_114251", "114251046", "story_v_out_114251.awb")
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
				actorName = "10018",
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
	Play114251047 = function(arg_193_0, arg_193_1)
		arg_193_1.time_ = 0
		arg_193_1.frameCnt_ = 0
		arg_193_1.state_ = "playing"
		arg_193_1.curTalkId_ = 114251047
		arg_193_1.duration_ = 7.37

		local var_193_0 = {
			ja = 6.9,
			ko = 5.833,
			zh = 7.366,
			en = 6.2
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
				arg_193_0:Play114251048(arg_193_1)
			end
		end

		function arg_193_1.onSingleLineUpdate_(arg_196_0)
			local var_196_0 = arg_193_1.actors_["10021"]
			local var_196_1 = 0

			if var_196_1 < arg_193_1.time_ and arg_193_1.time_ <= var_196_1 + arg_196_0 and not isNil(var_196_0) and arg_193_1.var_.actorSpriteComps10021 == nil then
				arg_193_1.var_.actorSpriteComps10021 = var_196_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_196_2 = 0.034

			if var_196_1 <= arg_193_1.time_ and arg_193_1.time_ < var_196_1 + var_196_2 and not isNil(var_196_0) then
				local var_196_3 = (arg_193_1.time_ - var_196_1) / var_196_2

				if arg_193_1.var_.actorSpriteComps10021 then
					for iter_196_0, iter_196_1 in pairs(arg_193_1.var_.actorSpriteComps10021:ToTable()) do
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

			if arg_193_1.time_ >= var_196_1 + var_196_2 and arg_193_1.time_ < var_196_1 + var_196_2 + arg_196_0 and not isNil(var_196_0) and arg_193_1.var_.actorSpriteComps10021 then
				for iter_196_2, iter_196_3 in pairs(arg_193_1.var_.actorSpriteComps10021:ToTable()) do
					if iter_196_3 then
						if arg_193_1.isInRecall_ then
							iter_196_3.color = arg_193_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_196_3.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_193_1.var_.actorSpriteComps10021 = nil
			end

			local var_196_8 = arg_193_1.actors_["10018"]
			local var_196_9 = 0

			if var_196_9 < arg_193_1.time_ and arg_193_1.time_ <= var_196_9 + arg_196_0 and not isNil(var_196_8) and arg_193_1.var_.actorSpriteComps10018 == nil then
				arg_193_1.var_.actorSpriteComps10018 = var_196_8:GetComponentsInChildren(typeof(Image), true)
			end

			local var_196_10 = 0.034

			if var_196_9 <= arg_193_1.time_ and arg_193_1.time_ < var_196_9 + var_196_10 and not isNil(var_196_8) then
				local var_196_11 = (arg_193_1.time_ - var_196_9) / var_196_10

				if arg_193_1.var_.actorSpriteComps10018 then
					for iter_196_4, iter_196_5 in pairs(arg_193_1.var_.actorSpriteComps10018:ToTable()) do
						if iter_196_5 then
							if arg_193_1.isInRecall_ then
								local var_196_12 = Mathf.Lerp(iter_196_5.color.r, arg_193_1.hightColor2.r, var_196_11)
								local var_196_13 = Mathf.Lerp(iter_196_5.color.g, arg_193_1.hightColor2.g, var_196_11)
								local var_196_14 = Mathf.Lerp(iter_196_5.color.b, arg_193_1.hightColor2.b, var_196_11)

								iter_196_5.color = Color.New(var_196_12, var_196_13, var_196_14)
							else
								local var_196_15 = Mathf.Lerp(iter_196_5.color.r, 0.5, var_196_11)

								iter_196_5.color = Color.New(var_196_15, var_196_15, var_196_15)
							end
						end
					end
				end
			end

			if arg_193_1.time_ >= var_196_9 + var_196_10 and arg_193_1.time_ < var_196_9 + var_196_10 + arg_196_0 and not isNil(var_196_8) and arg_193_1.var_.actorSpriteComps10018 then
				for iter_196_6, iter_196_7 in pairs(arg_193_1.var_.actorSpriteComps10018:ToTable()) do
					if iter_196_7 then
						if arg_193_1.isInRecall_ then
							iter_196_7.color = arg_193_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_196_7.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_193_1.var_.actorSpriteComps10018 = nil
			end

			local var_196_16 = 0
			local var_196_17 = 0.875

			if var_196_16 < arg_193_1.time_ and arg_193_1.time_ <= var_196_16 + arg_196_0 then
				arg_193_1.talkMaxDuration = 0
				arg_193_1.dialogCg_.alpha = 1

				arg_193_1.dialog_:SetActive(true)
				SetActive(arg_193_1.leftNameGo_, true)

				local var_196_18 = arg_193_1:FormatText(StoryNameCfg[226].name)

				arg_193_1.leftNameTxt_.text = var_196_18

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_193_1.leftNameTxt_.transform)

				arg_193_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_193_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_193_1:RecordName(arg_193_1.leftNameTxt_.text)
				SetActive(arg_193_1.iconTrs_.gameObject, false)
				arg_193_1.callingController_:SetSelectedState("normal")

				local var_196_19 = arg_193_1:GetWordFromCfg(114251047)
				local var_196_20 = arg_193_1:FormatText(var_196_19.content)

				arg_193_1.text_.text = var_196_20

				LuaForUtil.ClearLinePrefixSymbol(arg_193_1.text_)

				local var_196_21 = 35
				local var_196_22 = utf8.len(var_196_20)
				local var_196_23 = var_196_21 <= 0 and var_196_17 or var_196_17 * (var_196_22 / var_196_21)

				if var_196_23 > 0 and var_196_17 < var_196_23 then
					arg_193_1.talkMaxDuration = var_196_23

					if var_196_23 + var_196_16 > arg_193_1.duration_ then
						arg_193_1.duration_ = var_196_23 + var_196_16
					end
				end

				arg_193_1.text_.text = var_196_20
				arg_193_1.typewritter.percent = 0

				arg_193_1.typewritter:SetDirty()
				arg_193_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_114251", "114251047", "story_v_out_114251.awb") ~= 0 then
					local var_196_24 = manager.audio:GetVoiceLength("story_v_out_114251", "114251047", "story_v_out_114251.awb") / 1000

					if var_196_24 + var_196_16 > arg_193_1.duration_ then
						arg_193_1.duration_ = var_196_24 + var_196_16
					end

					if var_196_19.prefab_name ~= "" and arg_193_1.actors_[var_196_19.prefab_name] ~= nil then
						local var_196_25 = LuaForUtil.PlayVoiceWithCriLipsync(arg_193_1.actors_[var_196_19.prefab_name].transform, "story_v_out_114251", "114251047", "story_v_out_114251.awb")

						arg_193_1:RecordAudio("114251047", var_196_25)
						arg_193_1:RecordAudio("114251047", var_196_25)
					else
						arg_193_1:AudioAction("play", "voice", "story_v_out_114251", "114251047", "story_v_out_114251.awb")
					end

					arg_193_1:RecordHistoryTalkVoice("story_v_out_114251", "114251047", "story_v_out_114251.awb")
				end

				arg_193_1:RecordContent(arg_193_1.text_.text)
			end

			local var_196_26 = math.max(var_196_17, arg_193_1.talkMaxDuration)

			if var_196_16 <= arg_193_1.time_ and arg_193_1.time_ < var_196_16 + var_196_26 then
				arg_193_1.typewritter.percent = (arg_193_1.time_ - var_196_16) / var_196_26

				arg_193_1.typewritter:SetDirty()
			end

			if arg_193_1.time_ >= var_196_16 + var_196_26 and arg_193_1.time_ < var_196_16 + var_196_26 + arg_196_0 then
				arg_193_1.typewritter.percent = 1

				arg_193_1.typewritter:SetDirty()
				arg_193_1:ShowNextGo(true)
			end
		end

		arg_193_1.nodeConfigList_ = {}

		arg_193_1:InitPlayNodeList()
	end,
	Play114251048 = function(arg_197_0, arg_197_1)
		arg_197_1.time_ = 0
		arg_197_1.frameCnt_ = 0
		arg_197_1.state_ = "playing"
		arg_197_1.curTalkId_ = 114251048
		arg_197_1.duration_ = 8.3

		local var_197_0 = {
			ja = 8.3,
			ko = 4.8,
			zh = 5.733,
			en = 6.133
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
				arg_197_0:Play114251049(arg_197_1)
			end
		end

		function arg_197_1.onSingleLineUpdate_(arg_200_0)
			local var_200_0 = 0
			local var_200_1 = 0.675

			if var_200_0 < arg_197_1.time_ and arg_197_1.time_ <= var_200_0 + arg_200_0 then
				arg_197_1.talkMaxDuration = 0
				arg_197_1.dialogCg_.alpha = 1

				arg_197_1.dialog_:SetActive(true)
				SetActive(arg_197_1.leftNameGo_, true)

				local var_200_2 = arg_197_1:FormatText(StoryNameCfg[226].name)

				arg_197_1.leftNameTxt_.text = var_200_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_197_1.leftNameTxt_.transform)

				arg_197_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_197_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_197_1:RecordName(arg_197_1.leftNameTxt_.text)
				SetActive(arg_197_1.iconTrs_.gameObject, false)
				arg_197_1.callingController_:SetSelectedState("normal")

				local var_200_3 = arg_197_1:GetWordFromCfg(114251048)
				local var_200_4 = arg_197_1:FormatText(var_200_3.content)

				arg_197_1.text_.text = var_200_4

				LuaForUtil.ClearLinePrefixSymbol(arg_197_1.text_)

				local var_200_5 = 27
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

				if manager.audio:GetVoiceLength("story_v_out_114251", "114251048", "story_v_out_114251.awb") ~= 0 then
					local var_200_8 = manager.audio:GetVoiceLength("story_v_out_114251", "114251048", "story_v_out_114251.awb") / 1000

					if var_200_8 + var_200_0 > arg_197_1.duration_ then
						arg_197_1.duration_ = var_200_8 + var_200_0
					end

					if var_200_3.prefab_name ~= "" and arg_197_1.actors_[var_200_3.prefab_name] ~= nil then
						local var_200_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_197_1.actors_[var_200_3.prefab_name].transform, "story_v_out_114251", "114251048", "story_v_out_114251.awb")

						arg_197_1:RecordAudio("114251048", var_200_9)
						arg_197_1:RecordAudio("114251048", var_200_9)
					else
						arg_197_1:AudioAction("play", "voice", "story_v_out_114251", "114251048", "story_v_out_114251.awb")
					end

					arg_197_1:RecordHistoryTalkVoice("story_v_out_114251", "114251048", "story_v_out_114251.awb")
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
	Play114251049 = function(arg_201_0, arg_201_1)
		arg_201_1.time_ = 0
		arg_201_1.frameCnt_ = 0
		arg_201_1.state_ = "playing"
		arg_201_1.curTalkId_ = 114251049
		arg_201_1.duration_ = 8.3

		local var_201_0 = {
			ja = 8.3,
			ko = 5.4,
			zh = 5.233,
			en = 4.8
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
				arg_201_0:Play114251050(arg_201_1)
			end
		end

		function arg_201_1.onSingleLineUpdate_(arg_204_0)
			local var_204_0 = arg_201_1.actors_["10021"]
			local var_204_1 = 0

			if var_204_1 < arg_201_1.time_ and arg_201_1.time_ <= var_204_1 + arg_204_0 and not isNil(var_204_0) and arg_201_1.var_.actorSpriteComps10021 == nil then
				arg_201_1.var_.actorSpriteComps10021 = var_204_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_204_2 = 0.034

			if var_204_1 <= arg_201_1.time_ and arg_201_1.time_ < var_204_1 + var_204_2 and not isNil(var_204_0) then
				local var_204_3 = (arg_201_1.time_ - var_204_1) / var_204_2

				if arg_201_1.var_.actorSpriteComps10021 then
					for iter_204_0, iter_204_1 in pairs(arg_201_1.var_.actorSpriteComps10021:ToTable()) do
						if iter_204_1 then
							if arg_201_1.isInRecall_ then
								local var_204_4 = Mathf.Lerp(iter_204_1.color.r, arg_201_1.hightColor2.r, var_204_3)
								local var_204_5 = Mathf.Lerp(iter_204_1.color.g, arg_201_1.hightColor2.g, var_204_3)
								local var_204_6 = Mathf.Lerp(iter_204_1.color.b, arg_201_1.hightColor2.b, var_204_3)

								iter_204_1.color = Color.New(var_204_4, var_204_5, var_204_6)
							else
								local var_204_7 = Mathf.Lerp(iter_204_1.color.r, 0.5, var_204_3)

								iter_204_1.color = Color.New(var_204_7, var_204_7, var_204_7)
							end
						end
					end
				end
			end

			if arg_201_1.time_ >= var_204_1 + var_204_2 and arg_201_1.time_ < var_204_1 + var_204_2 + arg_204_0 and not isNil(var_204_0) and arg_201_1.var_.actorSpriteComps10021 then
				for iter_204_2, iter_204_3 in pairs(arg_201_1.var_.actorSpriteComps10021:ToTable()) do
					if iter_204_3 then
						if arg_201_1.isInRecall_ then
							iter_204_3.color = arg_201_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_204_3.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_201_1.var_.actorSpriteComps10021 = nil
			end

			local var_204_8 = arg_201_1.actors_["10018"]
			local var_204_9 = 0

			if var_204_9 < arg_201_1.time_ and arg_201_1.time_ <= var_204_9 + arg_204_0 and not isNil(var_204_8) and arg_201_1.var_.actorSpriteComps10018 == nil then
				arg_201_1.var_.actorSpriteComps10018 = var_204_8:GetComponentsInChildren(typeof(Image), true)
			end

			local var_204_10 = 0.034

			if var_204_9 <= arg_201_1.time_ and arg_201_1.time_ < var_204_9 + var_204_10 and not isNil(var_204_8) then
				local var_204_11 = (arg_201_1.time_ - var_204_9) / var_204_10

				if arg_201_1.var_.actorSpriteComps10018 then
					for iter_204_4, iter_204_5 in pairs(arg_201_1.var_.actorSpriteComps10018:ToTable()) do
						if iter_204_5 then
							if arg_201_1.isInRecall_ then
								local var_204_12 = Mathf.Lerp(iter_204_5.color.r, arg_201_1.hightColor1.r, var_204_11)
								local var_204_13 = Mathf.Lerp(iter_204_5.color.g, arg_201_1.hightColor1.g, var_204_11)
								local var_204_14 = Mathf.Lerp(iter_204_5.color.b, arg_201_1.hightColor1.b, var_204_11)

								iter_204_5.color = Color.New(var_204_12, var_204_13, var_204_14)
							else
								local var_204_15 = Mathf.Lerp(iter_204_5.color.r, 1, var_204_11)

								iter_204_5.color = Color.New(var_204_15, var_204_15, var_204_15)
							end
						end
					end
				end
			end

			if arg_201_1.time_ >= var_204_9 + var_204_10 and arg_201_1.time_ < var_204_9 + var_204_10 + arg_204_0 and not isNil(var_204_8) and arg_201_1.var_.actorSpriteComps10018 then
				for iter_204_6, iter_204_7 in pairs(arg_201_1.var_.actorSpriteComps10018:ToTable()) do
					if iter_204_7 then
						if arg_201_1.isInRecall_ then
							iter_204_7.color = arg_201_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_204_7.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_201_1.var_.actorSpriteComps10018 = nil
			end

			local var_204_16 = 0
			local var_204_17 = 0.675

			if var_204_16 < arg_201_1.time_ and arg_201_1.time_ <= var_204_16 + arg_204_0 then
				arg_201_1.talkMaxDuration = 0
				arg_201_1.dialogCg_.alpha = 1

				arg_201_1.dialog_:SetActive(true)
				SetActive(arg_201_1.leftNameGo_, true)

				local var_204_18 = arg_201_1:FormatText(StoryNameCfg[258].name)

				arg_201_1.leftNameTxt_.text = var_204_18

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_201_1.leftNameTxt_.transform)

				arg_201_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_201_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_201_1:RecordName(arg_201_1.leftNameTxt_.text)
				SetActive(arg_201_1.iconTrs_.gameObject, false)
				arg_201_1.callingController_:SetSelectedState("normal")

				local var_204_19 = arg_201_1:GetWordFromCfg(114251049)
				local var_204_20 = arg_201_1:FormatText(var_204_19.content)

				arg_201_1.text_.text = var_204_20

				LuaForUtil.ClearLinePrefixSymbol(arg_201_1.text_)

				local var_204_21 = 27
				local var_204_22 = utf8.len(var_204_20)
				local var_204_23 = var_204_21 <= 0 and var_204_17 or var_204_17 * (var_204_22 / var_204_21)

				if var_204_23 > 0 and var_204_17 < var_204_23 then
					arg_201_1.talkMaxDuration = var_204_23

					if var_204_23 + var_204_16 > arg_201_1.duration_ then
						arg_201_1.duration_ = var_204_23 + var_204_16
					end
				end

				arg_201_1.text_.text = var_204_20
				arg_201_1.typewritter.percent = 0

				arg_201_1.typewritter:SetDirty()
				arg_201_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_114251", "114251049", "story_v_out_114251.awb") ~= 0 then
					local var_204_24 = manager.audio:GetVoiceLength("story_v_out_114251", "114251049", "story_v_out_114251.awb") / 1000

					if var_204_24 + var_204_16 > arg_201_1.duration_ then
						arg_201_1.duration_ = var_204_24 + var_204_16
					end

					if var_204_19.prefab_name ~= "" and arg_201_1.actors_[var_204_19.prefab_name] ~= nil then
						local var_204_25 = LuaForUtil.PlayVoiceWithCriLipsync(arg_201_1.actors_[var_204_19.prefab_name].transform, "story_v_out_114251", "114251049", "story_v_out_114251.awb")

						arg_201_1:RecordAudio("114251049", var_204_25)
						arg_201_1:RecordAudio("114251049", var_204_25)
					else
						arg_201_1:AudioAction("play", "voice", "story_v_out_114251", "114251049", "story_v_out_114251.awb")
					end

					arg_201_1:RecordHistoryTalkVoice("story_v_out_114251", "114251049", "story_v_out_114251.awb")
				end

				arg_201_1:RecordContent(arg_201_1.text_.text)
			end

			local var_204_26 = math.max(var_204_17, arg_201_1.talkMaxDuration)

			if var_204_16 <= arg_201_1.time_ and arg_201_1.time_ < var_204_16 + var_204_26 then
				arg_201_1.typewritter.percent = (arg_201_1.time_ - var_204_16) / var_204_26

				arg_201_1.typewritter:SetDirty()
			end

			if arg_201_1.time_ >= var_204_16 + var_204_26 and arg_201_1.time_ < var_204_16 + var_204_26 + arg_204_0 then
				arg_201_1.typewritter.percent = 1

				arg_201_1.typewritter:SetDirty()
				arg_201_1:ShowNextGo(true)
			end
		end

		arg_201_1.nodeConfigList_ = {}

		arg_201_1:InitPlayNodeList()
	end,
	Play114251050 = function(arg_205_0, arg_205_1)
		arg_205_1.time_ = 0
		arg_205_1.frameCnt_ = 0
		arg_205_1.state_ = "playing"
		arg_205_1.curTalkId_ = 114251050
		arg_205_1.duration_ = 5

		SetActive(arg_205_1.tipsGo_, false)

		function arg_205_1.onSingleLineFinish_()
			arg_205_1.onSingleLineUpdate_ = nil
			arg_205_1.onSingleLineFinish_ = nil
			arg_205_1.state_ = "waiting"
		end

		function arg_205_1.playNext_(arg_207_0)
			if arg_207_0 == 1 then
				arg_205_0:Play114251051(arg_205_1)
			end
		end

		function arg_205_1.onSingleLineUpdate_(arg_208_0)
			local var_208_0 = arg_205_1.actors_["10018"]
			local var_208_1 = 0

			if var_208_1 < arg_205_1.time_ and arg_205_1.time_ <= var_208_1 + arg_208_0 and not isNil(var_208_0) and arg_205_1.var_.actorSpriteComps10018 == nil then
				arg_205_1.var_.actorSpriteComps10018 = var_208_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_208_2 = 0.034

			if var_208_1 <= arg_205_1.time_ and arg_205_1.time_ < var_208_1 + var_208_2 and not isNil(var_208_0) then
				local var_208_3 = (arg_205_1.time_ - var_208_1) / var_208_2

				if arg_205_1.var_.actorSpriteComps10018 then
					for iter_208_0, iter_208_1 in pairs(arg_205_1.var_.actorSpriteComps10018:ToTable()) do
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

			if arg_205_1.time_ >= var_208_1 + var_208_2 and arg_205_1.time_ < var_208_1 + var_208_2 + arg_208_0 and not isNil(var_208_0) and arg_205_1.var_.actorSpriteComps10018 then
				for iter_208_2, iter_208_3 in pairs(arg_205_1.var_.actorSpriteComps10018:ToTable()) do
					if iter_208_3 then
						if arg_205_1.isInRecall_ then
							iter_208_3.color = arg_205_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_208_3.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_205_1.var_.actorSpriteComps10018 = nil
			end

			local var_208_8 = 0
			local var_208_9 = 1.1

			if var_208_8 < arg_205_1.time_ and arg_205_1.time_ <= var_208_8 + arg_208_0 then
				arg_205_1.talkMaxDuration = 0
				arg_205_1.dialogCg_.alpha = 1

				arg_205_1.dialog_:SetActive(true)
				SetActive(arg_205_1.leftNameGo_, false)

				arg_205_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_205_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_205_1:RecordName(arg_205_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_205_1.iconTrs_.gameObject, false)
				arg_205_1.callingController_:SetSelectedState("normal")

				local var_208_10 = arg_205_1:GetWordFromCfg(114251050)
				local var_208_11 = arg_205_1:FormatText(var_208_10.content)

				arg_205_1.text_.text = var_208_11

				LuaForUtil.ClearLinePrefixSymbol(arg_205_1.text_)

				local var_208_12 = 44
				local var_208_13 = utf8.len(var_208_11)
				local var_208_14 = var_208_12 <= 0 and var_208_9 or var_208_9 * (var_208_13 / var_208_12)

				if var_208_14 > 0 and var_208_9 < var_208_14 then
					arg_205_1.talkMaxDuration = var_208_14

					if var_208_14 + var_208_8 > arg_205_1.duration_ then
						arg_205_1.duration_ = var_208_14 + var_208_8
					end
				end

				arg_205_1.text_.text = var_208_11
				arg_205_1.typewritter.percent = 0

				arg_205_1.typewritter:SetDirty()
				arg_205_1:ShowNextGo(false)
				arg_205_1:RecordContent(arg_205_1.text_.text)
			end

			local var_208_15 = math.max(var_208_9, arg_205_1.talkMaxDuration)

			if var_208_8 <= arg_205_1.time_ and arg_205_1.time_ < var_208_8 + var_208_15 then
				arg_205_1.typewritter.percent = (arg_205_1.time_ - var_208_8) / var_208_15

				arg_205_1.typewritter:SetDirty()
			end

			if arg_205_1.time_ >= var_208_8 + var_208_15 and arg_205_1.time_ < var_208_8 + var_208_15 + arg_208_0 then
				arg_205_1.typewritter.percent = 1

				arg_205_1.typewritter:SetDirty()
				arg_205_1:ShowNextGo(true)
			end
		end

		arg_205_1.nodeConfigList_ = {}

		arg_205_1:InitPlayNodeList()
	end,
	Play114251051 = function(arg_209_0, arg_209_1)
		arg_209_1.time_ = 0
		arg_209_1.frameCnt_ = 0
		arg_209_1.state_ = "playing"
		arg_209_1.curTalkId_ = 114251051
		arg_209_1.duration_ = 1.9

		local var_209_0 = {
			ja = 1.233,
			ko = 1.9,
			zh = 0.999999999999,
			en = 1.6
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
				arg_209_0:Play114251052(arg_209_1)
			end
		end

		function arg_209_1.onSingleLineUpdate_(arg_212_0)
			local var_212_0 = arg_209_1.actors_["10021"]
			local var_212_1 = 0

			if var_212_1 < arg_209_1.time_ and arg_209_1.time_ <= var_212_1 + arg_212_0 and not isNil(var_212_0) and arg_209_1.var_.actorSpriteComps10021 == nil then
				arg_209_1.var_.actorSpriteComps10021 = var_212_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_212_2 = 0.034

			if var_212_1 <= arg_209_1.time_ and arg_209_1.time_ < var_212_1 + var_212_2 and not isNil(var_212_0) then
				local var_212_3 = (arg_209_1.time_ - var_212_1) / var_212_2

				if arg_209_1.var_.actorSpriteComps10021 then
					for iter_212_0, iter_212_1 in pairs(arg_209_1.var_.actorSpriteComps10021:ToTable()) do
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

			if arg_209_1.time_ >= var_212_1 + var_212_2 and arg_209_1.time_ < var_212_1 + var_212_2 + arg_212_0 and not isNil(var_212_0) and arg_209_1.var_.actorSpriteComps10021 then
				for iter_212_2, iter_212_3 in pairs(arg_209_1.var_.actorSpriteComps10021:ToTable()) do
					if iter_212_3 then
						if arg_209_1.isInRecall_ then
							iter_212_3.color = arg_209_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_212_3.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_209_1.var_.actorSpriteComps10021 = nil
			end

			local var_212_8 = 0
			local var_212_9 = 0.05

			if var_212_8 < arg_209_1.time_ and arg_209_1.time_ <= var_212_8 + arg_212_0 then
				arg_209_1.talkMaxDuration = 0
				arg_209_1.dialogCg_.alpha = 1

				arg_209_1.dialog_:SetActive(true)
				SetActive(arg_209_1.leftNameGo_, true)

				local var_212_10 = arg_209_1:FormatText(StoryNameCfg[226].name)

				arg_209_1.leftNameTxt_.text = var_212_10

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_209_1.leftNameTxt_.transform)

				arg_209_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_209_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_209_1:RecordName(arg_209_1.leftNameTxt_.text)
				SetActive(arg_209_1.iconTrs_.gameObject, false)
				arg_209_1.callingController_:SetSelectedState("normal")

				local var_212_11 = arg_209_1:GetWordFromCfg(114251051)
				local var_212_12 = arg_209_1:FormatText(var_212_11.content)

				arg_209_1.text_.text = var_212_12

				LuaForUtil.ClearLinePrefixSymbol(arg_209_1.text_)

				local var_212_13 = 2
				local var_212_14 = utf8.len(var_212_12)
				local var_212_15 = var_212_13 <= 0 and var_212_9 or var_212_9 * (var_212_14 / var_212_13)

				if var_212_15 > 0 and var_212_9 < var_212_15 then
					arg_209_1.talkMaxDuration = var_212_15

					if var_212_15 + var_212_8 > arg_209_1.duration_ then
						arg_209_1.duration_ = var_212_15 + var_212_8
					end
				end

				arg_209_1.text_.text = var_212_12
				arg_209_1.typewritter.percent = 0

				arg_209_1.typewritter:SetDirty()
				arg_209_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_114251", "114251051", "story_v_out_114251.awb") ~= 0 then
					local var_212_16 = manager.audio:GetVoiceLength("story_v_out_114251", "114251051", "story_v_out_114251.awb") / 1000

					if var_212_16 + var_212_8 > arg_209_1.duration_ then
						arg_209_1.duration_ = var_212_16 + var_212_8
					end

					if var_212_11.prefab_name ~= "" and arg_209_1.actors_[var_212_11.prefab_name] ~= nil then
						local var_212_17 = LuaForUtil.PlayVoiceWithCriLipsync(arg_209_1.actors_[var_212_11.prefab_name].transform, "story_v_out_114251", "114251051", "story_v_out_114251.awb")

						arg_209_1:RecordAudio("114251051", var_212_17)
						arg_209_1:RecordAudio("114251051", var_212_17)
					else
						arg_209_1:AudioAction("play", "voice", "story_v_out_114251", "114251051", "story_v_out_114251.awb")
					end

					arg_209_1:RecordHistoryTalkVoice("story_v_out_114251", "114251051", "story_v_out_114251.awb")
				end

				arg_209_1:RecordContent(arg_209_1.text_.text)
			end

			local var_212_18 = math.max(var_212_9, arg_209_1.talkMaxDuration)

			if var_212_8 <= arg_209_1.time_ and arg_209_1.time_ < var_212_8 + var_212_18 then
				arg_209_1.typewritter.percent = (arg_209_1.time_ - var_212_8) / var_212_18

				arg_209_1.typewritter:SetDirty()
			end

			if arg_209_1.time_ >= var_212_8 + var_212_18 and arg_209_1.time_ < var_212_8 + var_212_18 + arg_212_0 then
				arg_209_1.typewritter.percent = 1

				arg_209_1.typewritter:SetDirty()
				arg_209_1:ShowNextGo(true)
			end
		end

		arg_209_1.nodeConfigList_ = {}

		arg_209_1:InitPlayNodeList()
	end,
	Play114251052 = function(arg_213_0, arg_213_1)
		arg_213_1.time_ = 0
		arg_213_1.frameCnt_ = 0
		arg_213_1.state_ = "playing"
		arg_213_1.curTalkId_ = 114251052
		arg_213_1.duration_ = 5

		SetActive(arg_213_1.tipsGo_, false)

		function arg_213_1.onSingleLineFinish_()
			arg_213_1.onSingleLineUpdate_ = nil
			arg_213_1.onSingleLineFinish_ = nil
			arg_213_1.state_ = "waiting"
		end

		function arg_213_1.playNext_(arg_215_0)
			if arg_215_0 == 1 then
				arg_213_0:Play114251053(arg_213_1)
			end
		end

		function arg_213_1.onSingleLineUpdate_(arg_216_0)
			local var_216_0 = arg_213_1.actors_["10021"]
			local var_216_1 = 0

			if var_216_1 < arg_213_1.time_ and arg_213_1.time_ <= var_216_1 + arg_216_0 and not isNil(var_216_0) and arg_213_1.var_.actorSpriteComps10021 == nil then
				arg_213_1.var_.actorSpriteComps10021 = var_216_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_216_2 = 0.034

			if var_216_1 <= arg_213_1.time_ and arg_213_1.time_ < var_216_1 + var_216_2 and not isNil(var_216_0) then
				local var_216_3 = (arg_213_1.time_ - var_216_1) / var_216_2

				if arg_213_1.var_.actorSpriteComps10021 then
					for iter_216_0, iter_216_1 in pairs(arg_213_1.var_.actorSpriteComps10021:ToTable()) do
						if iter_216_1 then
							if arg_213_1.isInRecall_ then
								local var_216_4 = Mathf.Lerp(iter_216_1.color.r, arg_213_1.hightColor2.r, var_216_3)
								local var_216_5 = Mathf.Lerp(iter_216_1.color.g, arg_213_1.hightColor2.g, var_216_3)
								local var_216_6 = Mathf.Lerp(iter_216_1.color.b, arg_213_1.hightColor2.b, var_216_3)

								iter_216_1.color = Color.New(var_216_4, var_216_5, var_216_6)
							else
								local var_216_7 = Mathf.Lerp(iter_216_1.color.r, 0.5, var_216_3)

								iter_216_1.color = Color.New(var_216_7, var_216_7, var_216_7)
							end
						end
					end
				end
			end

			if arg_213_1.time_ >= var_216_1 + var_216_2 and arg_213_1.time_ < var_216_1 + var_216_2 + arg_216_0 and not isNil(var_216_0) and arg_213_1.var_.actorSpriteComps10021 then
				for iter_216_2, iter_216_3 in pairs(arg_213_1.var_.actorSpriteComps10021:ToTable()) do
					if iter_216_3 then
						if arg_213_1.isInRecall_ then
							iter_216_3.color = arg_213_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_216_3.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_213_1.var_.actorSpriteComps10021 = nil
			end

			local var_216_8 = 0
			local var_216_9 = 0.825

			if var_216_8 < arg_213_1.time_ and arg_213_1.time_ <= var_216_8 + arg_216_0 then
				arg_213_1.talkMaxDuration = 0
				arg_213_1.dialogCg_.alpha = 1

				arg_213_1.dialog_:SetActive(true)
				SetActive(arg_213_1.leftNameGo_, false)

				arg_213_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_213_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_213_1:RecordName(arg_213_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_213_1.iconTrs_.gameObject, false)
				arg_213_1.callingController_:SetSelectedState("normal")

				local var_216_10 = arg_213_1:GetWordFromCfg(114251052)
				local var_216_11 = arg_213_1:FormatText(var_216_10.content)

				arg_213_1.text_.text = var_216_11

				LuaForUtil.ClearLinePrefixSymbol(arg_213_1.text_)

				local var_216_12 = 33
				local var_216_13 = utf8.len(var_216_11)
				local var_216_14 = var_216_12 <= 0 and var_216_9 or var_216_9 * (var_216_13 / var_216_12)

				if var_216_14 > 0 and var_216_9 < var_216_14 then
					arg_213_1.talkMaxDuration = var_216_14

					if var_216_14 + var_216_8 > arg_213_1.duration_ then
						arg_213_1.duration_ = var_216_14 + var_216_8
					end
				end

				arg_213_1.text_.text = var_216_11
				arg_213_1.typewritter.percent = 0

				arg_213_1.typewritter:SetDirty()
				arg_213_1:ShowNextGo(false)
				arg_213_1:RecordContent(arg_213_1.text_.text)
			end

			local var_216_15 = math.max(var_216_9, arg_213_1.talkMaxDuration)

			if var_216_8 <= arg_213_1.time_ and arg_213_1.time_ < var_216_8 + var_216_15 then
				arg_213_1.typewritter.percent = (arg_213_1.time_ - var_216_8) / var_216_15

				arg_213_1.typewritter:SetDirty()
			end

			if arg_213_1.time_ >= var_216_8 + var_216_15 and arg_213_1.time_ < var_216_8 + var_216_15 + arg_216_0 then
				arg_213_1.typewritter.percent = 1

				arg_213_1.typewritter:SetDirty()
				arg_213_1:ShowNextGo(true)
			end
		end

		arg_213_1.nodeConfigList_ = {}

		arg_213_1:InitPlayNodeList()
	end,
	Play114251053 = function(arg_217_0, arg_217_1)
		arg_217_1.time_ = 0
		arg_217_1.frameCnt_ = 0
		arg_217_1.state_ = "playing"
		arg_217_1.curTalkId_ = 114251053
		arg_217_1.duration_ = 7.33

		local var_217_0 = {
			ja = 6.1,
			ko = 7.333,
			zh = 7.266,
			en = 6.533
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
				arg_217_0:Play114251054(arg_217_1)
			end
		end

		function arg_217_1.onSingleLineUpdate_(arg_220_0)
			local var_220_0 = arg_217_1.actors_["10021"]
			local var_220_1 = 0

			if var_220_1 < arg_217_1.time_ and arg_217_1.time_ <= var_220_1 + arg_220_0 and not isNil(var_220_0) and arg_217_1.var_.actorSpriteComps10021 == nil then
				arg_217_1.var_.actorSpriteComps10021 = var_220_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_220_2 = 0.034

			if var_220_1 <= arg_217_1.time_ and arg_217_1.time_ < var_220_1 + var_220_2 and not isNil(var_220_0) then
				local var_220_3 = (arg_217_1.time_ - var_220_1) / var_220_2

				if arg_217_1.var_.actorSpriteComps10021 then
					for iter_220_0, iter_220_1 in pairs(arg_217_1.var_.actorSpriteComps10021:ToTable()) do
						if iter_220_1 then
							if arg_217_1.isInRecall_ then
								local var_220_4 = Mathf.Lerp(iter_220_1.color.r, arg_217_1.hightColor1.r, var_220_3)
								local var_220_5 = Mathf.Lerp(iter_220_1.color.g, arg_217_1.hightColor1.g, var_220_3)
								local var_220_6 = Mathf.Lerp(iter_220_1.color.b, arg_217_1.hightColor1.b, var_220_3)

								iter_220_1.color = Color.New(var_220_4, var_220_5, var_220_6)
							else
								local var_220_7 = Mathf.Lerp(iter_220_1.color.r, 1, var_220_3)

								iter_220_1.color = Color.New(var_220_7, var_220_7, var_220_7)
							end
						end
					end
				end
			end

			if arg_217_1.time_ >= var_220_1 + var_220_2 and arg_217_1.time_ < var_220_1 + var_220_2 + arg_220_0 and not isNil(var_220_0) and arg_217_1.var_.actorSpriteComps10021 then
				for iter_220_2, iter_220_3 in pairs(arg_217_1.var_.actorSpriteComps10021:ToTable()) do
					if iter_220_3 then
						if arg_217_1.isInRecall_ then
							iter_220_3.color = arg_217_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_220_3.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_217_1.var_.actorSpriteComps10021 = nil
			end

			local var_220_8 = 0
			local var_220_9 = 0.725

			if var_220_8 < arg_217_1.time_ and arg_217_1.time_ <= var_220_8 + arg_220_0 then
				arg_217_1.talkMaxDuration = 0
				arg_217_1.dialogCg_.alpha = 1

				arg_217_1.dialog_:SetActive(true)
				SetActive(arg_217_1.leftNameGo_, true)

				local var_220_10 = arg_217_1:FormatText(StoryNameCfg[226].name)

				arg_217_1.leftNameTxt_.text = var_220_10

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_217_1.leftNameTxt_.transform)

				arg_217_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_217_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_217_1:RecordName(arg_217_1.leftNameTxt_.text)
				SetActive(arg_217_1.iconTrs_.gameObject, false)
				arg_217_1.callingController_:SetSelectedState("normal")

				local var_220_11 = arg_217_1:GetWordFromCfg(114251053)
				local var_220_12 = arg_217_1:FormatText(var_220_11.content)

				arg_217_1.text_.text = var_220_12

				LuaForUtil.ClearLinePrefixSymbol(arg_217_1.text_)

				local var_220_13 = 28
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

				if manager.audio:GetVoiceLength("story_v_out_114251", "114251053", "story_v_out_114251.awb") ~= 0 then
					local var_220_16 = manager.audio:GetVoiceLength("story_v_out_114251", "114251053", "story_v_out_114251.awb") / 1000

					if var_220_16 + var_220_8 > arg_217_1.duration_ then
						arg_217_1.duration_ = var_220_16 + var_220_8
					end

					if var_220_11.prefab_name ~= "" and arg_217_1.actors_[var_220_11.prefab_name] ~= nil then
						local var_220_17 = LuaForUtil.PlayVoiceWithCriLipsync(arg_217_1.actors_[var_220_11.prefab_name].transform, "story_v_out_114251", "114251053", "story_v_out_114251.awb")

						arg_217_1:RecordAudio("114251053", var_220_17)
						arg_217_1:RecordAudio("114251053", var_220_17)
					else
						arg_217_1:AudioAction("play", "voice", "story_v_out_114251", "114251053", "story_v_out_114251.awb")
					end

					arg_217_1:RecordHistoryTalkVoice("story_v_out_114251", "114251053", "story_v_out_114251.awb")
				end

				arg_217_1:RecordContent(arg_217_1.text_.text)
			end

			local var_220_18 = math.max(var_220_9, arg_217_1.talkMaxDuration)

			if var_220_8 <= arg_217_1.time_ and arg_217_1.time_ < var_220_8 + var_220_18 then
				arg_217_1.typewritter.percent = (arg_217_1.time_ - var_220_8) / var_220_18

				arg_217_1.typewritter:SetDirty()
			end

			if arg_217_1.time_ >= var_220_8 + var_220_18 and arg_217_1.time_ < var_220_8 + var_220_18 + arg_220_0 then
				arg_217_1.typewritter.percent = 1

				arg_217_1.typewritter:SetDirty()
				arg_217_1:ShowNextGo(true)
			end
		end

		arg_217_1.nodeConfigList_ = {}

		arg_217_1:InitPlayNodeList()
	end,
	Play114251054 = function(arg_221_0, arg_221_1)
		arg_221_1.time_ = 0
		arg_221_1.frameCnt_ = 0
		arg_221_1.state_ = "playing"
		arg_221_1.curTalkId_ = 114251054
		arg_221_1.duration_ = 10.07

		local var_221_0 = {
			ja = 10.066,
			ko = 7.366,
			zh = 6.233,
			en = 6.2
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
				arg_221_0:Play114251055(arg_221_1)
			end
		end

		function arg_221_1.onSingleLineUpdate_(arg_224_0)
			local var_224_0 = arg_221_1.actors_["10018"].transform
			local var_224_1 = 0

			if var_224_1 < arg_221_1.time_ and arg_221_1.time_ <= var_224_1 + arg_224_0 then
				arg_221_1.var_.moveOldPos10018 = var_224_0.localPosition
				var_224_0.localScale = Vector3.New(1, 1, 1)

				arg_221_1:CheckSpriteTmpPos("10018", 4)

				local var_224_2 = var_224_0.childCount

				for iter_224_0 = 0, var_224_2 - 1 do
					local var_224_3 = var_224_0:GetChild(iter_224_0)

					if var_224_3.name == "split_4" or not string.find(var_224_3.name, "split") then
						var_224_3.gameObject:SetActive(true)
					else
						var_224_3.gameObject:SetActive(false)
					end
				end
			end

			local var_224_4 = 0.001

			if var_224_1 <= arg_221_1.time_ and arg_221_1.time_ < var_224_1 + var_224_4 then
				local var_224_5 = (arg_221_1.time_ - var_224_1) / var_224_4
				local var_224_6 = Vector3.New(390, -350, -180)

				var_224_0.localPosition = Vector3.Lerp(arg_221_1.var_.moveOldPos10018, var_224_6, var_224_5)
			end

			if arg_221_1.time_ >= var_224_1 + var_224_4 and arg_221_1.time_ < var_224_1 + var_224_4 + arg_224_0 then
				var_224_0.localPosition = Vector3.New(390, -350, -180)
			end

			local var_224_7 = arg_221_1.actors_["10021"]
			local var_224_8 = 0

			if var_224_8 < arg_221_1.time_ and arg_221_1.time_ <= var_224_8 + arg_224_0 and not isNil(var_224_7) and arg_221_1.var_.actorSpriteComps10021 == nil then
				arg_221_1.var_.actorSpriteComps10021 = var_224_7:GetComponentsInChildren(typeof(Image), true)
			end

			local var_224_9 = 0.034

			if var_224_8 <= arg_221_1.time_ and arg_221_1.time_ < var_224_8 + var_224_9 and not isNil(var_224_7) then
				local var_224_10 = (arg_221_1.time_ - var_224_8) / var_224_9

				if arg_221_1.var_.actorSpriteComps10021 then
					for iter_224_1, iter_224_2 in pairs(arg_221_1.var_.actorSpriteComps10021:ToTable()) do
						if iter_224_2 then
							if arg_221_1.isInRecall_ then
								local var_224_11 = Mathf.Lerp(iter_224_2.color.r, arg_221_1.hightColor2.r, var_224_10)
								local var_224_12 = Mathf.Lerp(iter_224_2.color.g, arg_221_1.hightColor2.g, var_224_10)
								local var_224_13 = Mathf.Lerp(iter_224_2.color.b, arg_221_1.hightColor2.b, var_224_10)

								iter_224_2.color = Color.New(var_224_11, var_224_12, var_224_13)
							else
								local var_224_14 = Mathf.Lerp(iter_224_2.color.r, 0.5, var_224_10)

								iter_224_2.color = Color.New(var_224_14, var_224_14, var_224_14)
							end
						end
					end
				end
			end

			if arg_221_1.time_ >= var_224_8 + var_224_9 and arg_221_1.time_ < var_224_8 + var_224_9 + arg_224_0 and not isNil(var_224_7) and arg_221_1.var_.actorSpriteComps10021 then
				for iter_224_3, iter_224_4 in pairs(arg_221_1.var_.actorSpriteComps10021:ToTable()) do
					if iter_224_4 then
						if arg_221_1.isInRecall_ then
							iter_224_4.color = arg_221_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_224_4.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_221_1.var_.actorSpriteComps10021 = nil
			end

			local var_224_15 = arg_221_1.actors_["10018"]
			local var_224_16 = 0

			if var_224_16 < arg_221_1.time_ and arg_221_1.time_ <= var_224_16 + arg_224_0 and not isNil(var_224_15) and arg_221_1.var_.actorSpriteComps10018 == nil then
				arg_221_1.var_.actorSpriteComps10018 = var_224_15:GetComponentsInChildren(typeof(Image), true)
			end

			local var_224_17 = 0.034

			if var_224_16 <= arg_221_1.time_ and arg_221_1.time_ < var_224_16 + var_224_17 and not isNil(var_224_15) then
				local var_224_18 = (arg_221_1.time_ - var_224_16) / var_224_17

				if arg_221_1.var_.actorSpriteComps10018 then
					for iter_224_5, iter_224_6 in pairs(arg_221_1.var_.actorSpriteComps10018:ToTable()) do
						if iter_224_6 then
							if arg_221_1.isInRecall_ then
								local var_224_19 = Mathf.Lerp(iter_224_6.color.r, arg_221_1.hightColor1.r, var_224_18)
								local var_224_20 = Mathf.Lerp(iter_224_6.color.g, arg_221_1.hightColor1.g, var_224_18)
								local var_224_21 = Mathf.Lerp(iter_224_6.color.b, arg_221_1.hightColor1.b, var_224_18)

								iter_224_6.color = Color.New(var_224_19, var_224_20, var_224_21)
							else
								local var_224_22 = Mathf.Lerp(iter_224_6.color.r, 1, var_224_18)

								iter_224_6.color = Color.New(var_224_22, var_224_22, var_224_22)
							end
						end
					end
				end
			end

			if arg_221_1.time_ >= var_224_16 + var_224_17 and arg_221_1.time_ < var_224_16 + var_224_17 + arg_224_0 and not isNil(var_224_15) and arg_221_1.var_.actorSpriteComps10018 then
				for iter_224_7, iter_224_8 in pairs(arg_221_1.var_.actorSpriteComps10018:ToTable()) do
					if iter_224_8 then
						if arg_221_1.isInRecall_ then
							iter_224_8.color = arg_221_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_224_8.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_221_1.var_.actorSpriteComps10018 = nil
			end

			local var_224_23 = 0
			local var_224_24 = 0.75

			if var_224_23 < arg_221_1.time_ and arg_221_1.time_ <= var_224_23 + arg_224_0 then
				arg_221_1.talkMaxDuration = 0
				arg_221_1.dialogCg_.alpha = 1

				arg_221_1.dialog_:SetActive(true)
				SetActive(arg_221_1.leftNameGo_, true)

				local var_224_25 = arg_221_1:FormatText(StoryNameCfg[258].name)

				arg_221_1.leftNameTxt_.text = var_224_25

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_221_1.leftNameTxt_.transform)

				arg_221_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_221_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_221_1:RecordName(arg_221_1.leftNameTxt_.text)
				SetActive(arg_221_1.iconTrs_.gameObject, false)
				arg_221_1.callingController_:SetSelectedState("normal")

				local var_224_26 = arg_221_1:GetWordFromCfg(114251054)
				local var_224_27 = arg_221_1:FormatText(var_224_26.content)

				arg_221_1.text_.text = var_224_27

				LuaForUtil.ClearLinePrefixSymbol(arg_221_1.text_)

				local var_224_28 = 30
				local var_224_29 = utf8.len(var_224_27)
				local var_224_30 = var_224_28 <= 0 and var_224_24 or var_224_24 * (var_224_29 / var_224_28)

				if var_224_30 > 0 and var_224_24 < var_224_30 then
					arg_221_1.talkMaxDuration = var_224_30

					if var_224_30 + var_224_23 > arg_221_1.duration_ then
						arg_221_1.duration_ = var_224_30 + var_224_23
					end
				end

				arg_221_1.text_.text = var_224_27
				arg_221_1.typewritter.percent = 0

				arg_221_1.typewritter:SetDirty()
				arg_221_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_114251", "114251054", "story_v_out_114251.awb") ~= 0 then
					local var_224_31 = manager.audio:GetVoiceLength("story_v_out_114251", "114251054", "story_v_out_114251.awb") / 1000

					if var_224_31 + var_224_23 > arg_221_1.duration_ then
						arg_221_1.duration_ = var_224_31 + var_224_23
					end

					if var_224_26.prefab_name ~= "" and arg_221_1.actors_[var_224_26.prefab_name] ~= nil then
						local var_224_32 = LuaForUtil.PlayVoiceWithCriLipsync(arg_221_1.actors_[var_224_26.prefab_name].transform, "story_v_out_114251", "114251054", "story_v_out_114251.awb")

						arg_221_1:RecordAudio("114251054", var_224_32)
						arg_221_1:RecordAudio("114251054", var_224_32)
					else
						arg_221_1:AudioAction("play", "voice", "story_v_out_114251", "114251054", "story_v_out_114251.awb")
					end

					arg_221_1:RecordHistoryTalkVoice("story_v_out_114251", "114251054", "story_v_out_114251.awb")
				end

				arg_221_1:RecordContent(arg_221_1.text_.text)
			end

			local var_224_33 = math.max(var_224_24, arg_221_1.talkMaxDuration)

			if var_224_23 <= arg_221_1.time_ and arg_221_1.time_ < var_224_23 + var_224_33 then
				arg_221_1.typewritter.percent = (arg_221_1.time_ - var_224_23) / var_224_33

				arg_221_1.typewritter:SetDirty()
			end

			if arg_221_1.time_ >= var_224_23 + var_224_33 and arg_221_1.time_ < var_224_23 + var_224_33 + arg_224_0 then
				arg_221_1.typewritter.percent = 1

				arg_221_1.typewritter:SetDirty()
				arg_221_1:ShowNextGo(true)
			end
		end

		arg_221_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10018",
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
	Play114251055 = function(arg_225_0, arg_225_1)
		arg_225_1.time_ = 0
		arg_225_1.frameCnt_ = 0
		arg_225_1.state_ = "playing"
		arg_225_1.curTalkId_ = 114251055
		arg_225_1.duration_ = 6.97

		local var_225_0 = {
			ja = 6.966,
			ko = 4.833,
			zh = 2.966,
			en = 3
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
				arg_225_0:Play114251056(arg_225_1)
			end
		end

		function arg_225_1.onSingleLineUpdate_(arg_228_0)
			local var_228_0 = arg_225_1.actors_["10021"]
			local var_228_1 = 0

			if var_228_1 < arg_225_1.time_ and arg_225_1.time_ <= var_228_1 + arg_228_0 and not isNil(var_228_0) and arg_225_1.var_.actorSpriteComps10021 == nil then
				arg_225_1.var_.actorSpriteComps10021 = var_228_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_228_2 = 0.034

			if var_228_1 <= arg_225_1.time_ and arg_225_1.time_ < var_228_1 + var_228_2 and not isNil(var_228_0) then
				local var_228_3 = (arg_225_1.time_ - var_228_1) / var_228_2

				if arg_225_1.var_.actorSpriteComps10021 then
					for iter_228_0, iter_228_1 in pairs(arg_225_1.var_.actorSpriteComps10021:ToTable()) do
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

			if arg_225_1.time_ >= var_228_1 + var_228_2 and arg_225_1.time_ < var_228_1 + var_228_2 + arg_228_0 and not isNil(var_228_0) and arg_225_1.var_.actorSpriteComps10021 then
				for iter_228_2, iter_228_3 in pairs(arg_225_1.var_.actorSpriteComps10021:ToTable()) do
					if iter_228_3 then
						if arg_225_1.isInRecall_ then
							iter_228_3.color = arg_225_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_228_3.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_225_1.var_.actorSpriteComps10021 = nil
			end

			local var_228_8 = arg_225_1.actors_["10018"]
			local var_228_9 = 0

			if var_228_9 < arg_225_1.time_ and arg_225_1.time_ <= var_228_9 + arg_228_0 and not isNil(var_228_8) and arg_225_1.var_.actorSpriteComps10018 == nil then
				arg_225_1.var_.actorSpriteComps10018 = var_228_8:GetComponentsInChildren(typeof(Image), true)
			end

			local var_228_10 = 0.034

			if var_228_9 <= arg_225_1.time_ and arg_225_1.time_ < var_228_9 + var_228_10 and not isNil(var_228_8) then
				local var_228_11 = (arg_225_1.time_ - var_228_9) / var_228_10

				if arg_225_1.var_.actorSpriteComps10018 then
					for iter_228_4, iter_228_5 in pairs(arg_225_1.var_.actorSpriteComps10018:ToTable()) do
						if iter_228_5 then
							if arg_225_1.isInRecall_ then
								local var_228_12 = Mathf.Lerp(iter_228_5.color.r, arg_225_1.hightColor2.r, var_228_11)
								local var_228_13 = Mathf.Lerp(iter_228_5.color.g, arg_225_1.hightColor2.g, var_228_11)
								local var_228_14 = Mathf.Lerp(iter_228_5.color.b, arg_225_1.hightColor2.b, var_228_11)

								iter_228_5.color = Color.New(var_228_12, var_228_13, var_228_14)
							else
								local var_228_15 = Mathf.Lerp(iter_228_5.color.r, 0.5, var_228_11)

								iter_228_5.color = Color.New(var_228_15, var_228_15, var_228_15)
							end
						end
					end
				end
			end

			if arg_225_1.time_ >= var_228_9 + var_228_10 and arg_225_1.time_ < var_228_9 + var_228_10 + arg_228_0 and not isNil(var_228_8) and arg_225_1.var_.actorSpriteComps10018 then
				for iter_228_6, iter_228_7 in pairs(arg_225_1.var_.actorSpriteComps10018:ToTable()) do
					if iter_228_7 then
						if arg_225_1.isInRecall_ then
							iter_228_7.color = arg_225_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_228_7.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_225_1.var_.actorSpriteComps10018 = nil
			end

			local var_228_16 = 0
			local var_228_17 = 0.35

			if var_228_16 < arg_225_1.time_ and arg_225_1.time_ <= var_228_16 + arg_228_0 then
				arg_225_1.talkMaxDuration = 0
				arg_225_1.dialogCg_.alpha = 1

				arg_225_1.dialog_:SetActive(true)
				SetActive(arg_225_1.leftNameGo_, true)

				local var_228_18 = arg_225_1:FormatText(StoryNameCfg[226].name)

				arg_225_1.leftNameTxt_.text = var_228_18

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_225_1.leftNameTxt_.transform)

				arg_225_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_225_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_225_1:RecordName(arg_225_1.leftNameTxt_.text)
				SetActive(arg_225_1.iconTrs_.gameObject, false)
				arg_225_1.callingController_:SetSelectedState("normal")

				local var_228_19 = arg_225_1:GetWordFromCfg(114251055)
				local var_228_20 = arg_225_1:FormatText(var_228_19.content)

				arg_225_1.text_.text = var_228_20

				LuaForUtil.ClearLinePrefixSymbol(arg_225_1.text_)

				local var_228_21 = 14
				local var_228_22 = utf8.len(var_228_20)
				local var_228_23 = var_228_21 <= 0 and var_228_17 or var_228_17 * (var_228_22 / var_228_21)

				if var_228_23 > 0 and var_228_17 < var_228_23 then
					arg_225_1.talkMaxDuration = var_228_23

					if var_228_23 + var_228_16 > arg_225_1.duration_ then
						arg_225_1.duration_ = var_228_23 + var_228_16
					end
				end

				arg_225_1.text_.text = var_228_20
				arg_225_1.typewritter.percent = 0

				arg_225_1.typewritter:SetDirty()
				arg_225_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_114251", "114251055", "story_v_out_114251.awb") ~= 0 then
					local var_228_24 = manager.audio:GetVoiceLength("story_v_out_114251", "114251055", "story_v_out_114251.awb") / 1000

					if var_228_24 + var_228_16 > arg_225_1.duration_ then
						arg_225_1.duration_ = var_228_24 + var_228_16
					end

					if var_228_19.prefab_name ~= "" and arg_225_1.actors_[var_228_19.prefab_name] ~= nil then
						local var_228_25 = LuaForUtil.PlayVoiceWithCriLipsync(arg_225_1.actors_[var_228_19.prefab_name].transform, "story_v_out_114251", "114251055", "story_v_out_114251.awb")

						arg_225_1:RecordAudio("114251055", var_228_25)
						arg_225_1:RecordAudio("114251055", var_228_25)
					else
						arg_225_1:AudioAction("play", "voice", "story_v_out_114251", "114251055", "story_v_out_114251.awb")
					end

					arg_225_1:RecordHistoryTalkVoice("story_v_out_114251", "114251055", "story_v_out_114251.awb")
				end

				arg_225_1:RecordContent(arg_225_1.text_.text)
			end

			local var_228_26 = math.max(var_228_17, arg_225_1.talkMaxDuration)

			if var_228_16 <= arg_225_1.time_ and arg_225_1.time_ < var_228_16 + var_228_26 then
				arg_225_1.typewritter.percent = (arg_225_1.time_ - var_228_16) / var_228_26

				arg_225_1.typewritter:SetDirty()
			end

			if arg_225_1.time_ >= var_228_16 + var_228_26 and arg_225_1.time_ < var_228_16 + var_228_26 + arg_228_0 then
				arg_225_1.typewritter.percent = 1

				arg_225_1.typewritter:SetDirty()
				arg_225_1:ShowNextGo(true)
			end
		end

		arg_225_1.nodeConfigList_ = {}

		arg_225_1:InitPlayNodeList()
	end,
	Play114251056 = function(arg_229_0, arg_229_1)
		arg_229_1.time_ = 0
		arg_229_1.frameCnt_ = 0
		arg_229_1.state_ = "playing"
		arg_229_1.curTalkId_ = 114251056
		arg_229_1.duration_ = 5

		SetActive(arg_229_1.tipsGo_, false)

		function arg_229_1.onSingleLineFinish_()
			arg_229_1.onSingleLineUpdate_ = nil
			arg_229_1.onSingleLineFinish_ = nil
			arg_229_1.state_ = "waiting"
		end

		function arg_229_1.playNext_(arg_231_0)
			if arg_231_0 == 1 then
				arg_229_0:Play114251057(arg_229_1)
			end
		end

		function arg_229_1.onSingleLineUpdate_(arg_232_0)
			local var_232_0 = arg_229_1.actors_["10021"]
			local var_232_1 = 0

			if var_232_1 < arg_229_1.time_ and arg_229_1.time_ <= var_232_1 + arg_232_0 and not isNil(var_232_0) and arg_229_1.var_.actorSpriteComps10021 == nil then
				arg_229_1.var_.actorSpriteComps10021 = var_232_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_232_2 = 0.034

			if var_232_1 <= arg_229_1.time_ and arg_229_1.time_ < var_232_1 + var_232_2 and not isNil(var_232_0) then
				local var_232_3 = (arg_229_1.time_ - var_232_1) / var_232_2

				if arg_229_1.var_.actorSpriteComps10021 then
					for iter_232_0, iter_232_1 in pairs(arg_229_1.var_.actorSpriteComps10021:ToTable()) do
						if iter_232_1 then
							if arg_229_1.isInRecall_ then
								local var_232_4 = Mathf.Lerp(iter_232_1.color.r, arg_229_1.hightColor2.r, var_232_3)
								local var_232_5 = Mathf.Lerp(iter_232_1.color.g, arg_229_1.hightColor2.g, var_232_3)
								local var_232_6 = Mathf.Lerp(iter_232_1.color.b, arg_229_1.hightColor2.b, var_232_3)

								iter_232_1.color = Color.New(var_232_4, var_232_5, var_232_6)
							else
								local var_232_7 = Mathf.Lerp(iter_232_1.color.r, 0.5, var_232_3)

								iter_232_1.color = Color.New(var_232_7, var_232_7, var_232_7)
							end
						end
					end
				end
			end

			if arg_229_1.time_ >= var_232_1 + var_232_2 and arg_229_1.time_ < var_232_1 + var_232_2 + arg_232_0 and not isNil(var_232_0) and arg_229_1.var_.actorSpriteComps10021 then
				for iter_232_2, iter_232_3 in pairs(arg_229_1.var_.actorSpriteComps10021:ToTable()) do
					if iter_232_3 then
						if arg_229_1.isInRecall_ then
							iter_232_3.color = arg_229_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_232_3.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_229_1.var_.actorSpriteComps10021 = nil
			end

			local var_232_8 = 0
			local var_232_9 = 0.7

			if var_232_8 < arg_229_1.time_ and arg_229_1.time_ <= var_232_8 + arg_232_0 then
				arg_229_1.talkMaxDuration = 0
				arg_229_1.dialogCg_.alpha = 1

				arg_229_1.dialog_:SetActive(true)
				SetActive(arg_229_1.leftNameGo_, false)

				arg_229_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_229_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_229_1:RecordName(arg_229_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_229_1.iconTrs_.gameObject, false)
				arg_229_1.callingController_:SetSelectedState("normal")

				local var_232_10 = arg_229_1:GetWordFromCfg(114251056)
				local var_232_11 = arg_229_1:FormatText(var_232_10.content)

				arg_229_1.text_.text = var_232_11

				LuaForUtil.ClearLinePrefixSymbol(arg_229_1.text_)

				local var_232_12 = 28
				local var_232_13 = utf8.len(var_232_11)
				local var_232_14 = var_232_12 <= 0 and var_232_9 or var_232_9 * (var_232_13 / var_232_12)

				if var_232_14 > 0 and var_232_9 < var_232_14 then
					arg_229_1.talkMaxDuration = var_232_14

					if var_232_14 + var_232_8 > arg_229_1.duration_ then
						arg_229_1.duration_ = var_232_14 + var_232_8
					end
				end

				arg_229_1.text_.text = var_232_11
				arg_229_1.typewritter.percent = 0

				arg_229_1.typewritter:SetDirty()
				arg_229_1:ShowNextGo(false)
				arg_229_1:RecordContent(arg_229_1.text_.text)
			end

			local var_232_15 = math.max(var_232_9, arg_229_1.talkMaxDuration)

			if var_232_8 <= arg_229_1.time_ and arg_229_1.time_ < var_232_8 + var_232_15 then
				arg_229_1.typewritter.percent = (arg_229_1.time_ - var_232_8) / var_232_15

				arg_229_1.typewritter:SetDirty()
			end

			if arg_229_1.time_ >= var_232_8 + var_232_15 and arg_229_1.time_ < var_232_8 + var_232_15 + arg_232_0 then
				arg_229_1.typewritter.percent = 1

				arg_229_1.typewritter:SetDirty()
				arg_229_1:ShowNextGo(true)
			end
		end

		arg_229_1.nodeConfigList_ = {}

		arg_229_1:InitPlayNodeList()
	end,
	Play114251057 = function(arg_233_0, arg_233_1)
		arg_233_1.time_ = 0
		arg_233_1.frameCnt_ = 0
		arg_233_1.state_ = "playing"
		arg_233_1.curTalkId_ = 114251057
		arg_233_1.duration_ = 11.93

		local var_233_0 = {
			ja = 11.933,
			ko = 8.866,
			zh = 9.266,
			en = 8.9
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
				arg_233_0:Play114251058(arg_233_1)
			end
		end

		function arg_233_1.onSingleLineUpdate_(arg_236_0)
			local var_236_0 = arg_233_1.actors_["10021"]
			local var_236_1 = 0

			if var_236_1 < arg_233_1.time_ and arg_233_1.time_ <= var_236_1 + arg_236_0 and not isNil(var_236_0) and arg_233_1.var_.actorSpriteComps10021 == nil then
				arg_233_1.var_.actorSpriteComps10021 = var_236_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_236_2 = 0.034

			if var_236_1 <= arg_233_1.time_ and arg_233_1.time_ < var_236_1 + var_236_2 and not isNil(var_236_0) then
				local var_236_3 = (arg_233_1.time_ - var_236_1) / var_236_2

				if arg_233_1.var_.actorSpriteComps10021 then
					for iter_236_0, iter_236_1 in pairs(arg_233_1.var_.actorSpriteComps10021:ToTable()) do
						if iter_236_1 then
							if arg_233_1.isInRecall_ then
								local var_236_4 = Mathf.Lerp(iter_236_1.color.r, arg_233_1.hightColor1.r, var_236_3)
								local var_236_5 = Mathf.Lerp(iter_236_1.color.g, arg_233_1.hightColor1.g, var_236_3)
								local var_236_6 = Mathf.Lerp(iter_236_1.color.b, arg_233_1.hightColor1.b, var_236_3)

								iter_236_1.color = Color.New(var_236_4, var_236_5, var_236_6)
							else
								local var_236_7 = Mathf.Lerp(iter_236_1.color.r, 1, var_236_3)

								iter_236_1.color = Color.New(var_236_7, var_236_7, var_236_7)
							end
						end
					end
				end
			end

			if arg_233_1.time_ >= var_236_1 + var_236_2 and arg_233_1.time_ < var_236_1 + var_236_2 + arg_236_0 and not isNil(var_236_0) and arg_233_1.var_.actorSpriteComps10021 then
				for iter_236_2, iter_236_3 in pairs(arg_233_1.var_.actorSpriteComps10021:ToTable()) do
					if iter_236_3 then
						if arg_233_1.isInRecall_ then
							iter_236_3.color = arg_233_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_236_3.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_233_1.var_.actorSpriteComps10021 = nil
			end

			local var_236_8 = 0
			local var_236_9 = 1.125

			if var_236_8 < arg_233_1.time_ and arg_233_1.time_ <= var_236_8 + arg_236_0 then
				arg_233_1.talkMaxDuration = 0
				arg_233_1.dialogCg_.alpha = 1

				arg_233_1.dialog_:SetActive(true)
				SetActive(arg_233_1.leftNameGo_, true)

				local var_236_10 = arg_233_1:FormatText(StoryNameCfg[226].name)

				arg_233_1.leftNameTxt_.text = var_236_10

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_233_1.leftNameTxt_.transform)

				arg_233_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_233_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_233_1:RecordName(arg_233_1.leftNameTxt_.text)
				SetActive(arg_233_1.iconTrs_.gameObject, false)
				arg_233_1.callingController_:SetSelectedState("normal")

				local var_236_11 = arg_233_1:GetWordFromCfg(114251057)
				local var_236_12 = arg_233_1:FormatText(var_236_11.content)

				arg_233_1.text_.text = var_236_12

				LuaForUtil.ClearLinePrefixSymbol(arg_233_1.text_)

				local var_236_13 = 45
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

				if manager.audio:GetVoiceLength("story_v_out_114251", "114251057", "story_v_out_114251.awb") ~= 0 then
					local var_236_16 = manager.audio:GetVoiceLength("story_v_out_114251", "114251057", "story_v_out_114251.awb") / 1000

					if var_236_16 + var_236_8 > arg_233_1.duration_ then
						arg_233_1.duration_ = var_236_16 + var_236_8
					end

					if var_236_11.prefab_name ~= "" and arg_233_1.actors_[var_236_11.prefab_name] ~= nil then
						local var_236_17 = LuaForUtil.PlayVoiceWithCriLipsync(arg_233_1.actors_[var_236_11.prefab_name].transform, "story_v_out_114251", "114251057", "story_v_out_114251.awb")

						arg_233_1:RecordAudio("114251057", var_236_17)
						arg_233_1:RecordAudio("114251057", var_236_17)
					else
						arg_233_1:AudioAction("play", "voice", "story_v_out_114251", "114251057", "story_v_out_114251.awb")
					end

					arg_233_1:RecordHistoryTalkVoice("story_v_out_114251", "114251057", "story_v_out_114251.awb")
				end

				arg_233_1:RecordContent(arg_233_1.text_.text)
			end

			local var_236_18 = math.max(var_236_9, arg_233_1.talkMaxDuration)

			if var_236_8 <= arg_233_1.time_ and arg_233_1.time_ < var_236_8 + var_236_18 then
				arg_233_1.typewritter.percent = (arg_233_1.time_ - var_236_8) / var_236_18

				arg_233_1.typewritter:SetDirty()
			end

			if arg_233_1.time_ >= var_236_8 + var_236_18 and arg_233_1.time_ < var_236_8 + var_236_18 + arg_236_0 then
				arg_233_1.typewritter.percent = 1

				arg_233_1.typewritter:SetDirty()
				arg_233_1:ShowNextGo(true)
			end
		end

		arg_233_1.nodeConfigList_ = {}

		arg_233_1:InitPlayNodeList()
	end,
	Play114251058 = function(arg_237_0, arg_237_1)
		arg_237_1.time_ = 0
		arg_237_1.frameCnt_ = 0
		arg_237_1.state_ = "playing"
		arg_237_1.curTalkId_ = 114251058
		arg_237_1.duration_ = 8.27

		local var_237_0 = {
			ja = 6.5,
			ko = 6.733,
			zh = 8.266,
			en = 6.933
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
				arg_237_0:Play114251059(arg_237_1)
			end
		end

		function arg_237_1.onSingleLineUpdate_(arg_240_0)
			local var_240_0 = arg_237_1.actors_["10018"].transform
			local var_240_1 = 0

			if var_240_1 < arg_237_1.time_ and arg_237_1.time_ <= var_240_1 + arg_240_0 then
				arg_237_1.var_.moveOldPos10018 = var_240_0.localPosition
				var_240_0.localScale = Vector3.New(1, 1, 1)

				arg_237_1:CheckSpriteTmpPos("10018", 4)

				local var_240_2 = var_240_0.childCount

				for iter_240_0 = 0, var_240_2 - 1 do
					local var_240_3 = var_240_0:GetChild(iter_240_0)

					if var_240_3.name == "split_4" or not string.find(var_240_3.name, "split") then
						var_240_3.gameObject:SetActive(true)
					else
						var_240_3.gameObject:SetActive(false)
					end
				end
			end

			local var_240_4 = 0.001

			if var_240_1 <= arg_237_1.time_ and arg_237_1.time_ < var_240_1 + var_240_4 then
				local var_240_5 = (arg_237_1.time_ - var_240_1) / var_240_4
				local var_240_6 = Vector3.New(390, -350, -180)

				var_240_0.localPosition = Vector3.Lerp(arg_237_1.var_.moveOldPos10018, var_240_6, var_240_5)
			end

			if arg_237_1.time_ >= var_240_1 + var_240_4 and arg_237_1.time_ < var_240_1 + var_240_4 + arg_240_0 then
				var_240_0.localPosition = Vector3.New(390, -350, -180)
			end

			local var_240_7 = arg_237_1.actors_["10021"]
			local var_240_8 = 0

			if var_240_8 < arg_237_1.time_ and arg_237_1.time_ <= var_240_8 + arg_240_0 and not isNil(var_240_7) and arg_237_1.var_.actorSpriteComps10021 == nil then
				arg_237_1.var_.actorSpriteComps10021 = var_240_7:GetComponentsInChildren(typeof(Image), true)
			end

			local var_240_9 = 0.034

			if var_240_8 <= arg_237_1.time_ and arg_237_1.time_ < var_240_8 + var_240_9 and not isNil(var_240_7) then
				local var_240_10 = (arg_237_1.time_ - var_240_8) / var_240_9

				if arg_237_1.var_.actorSpriteComps10021 then
					for iter_240_1, iter_240_2 in pairs(arg_237_1.var_.actorSpriteComps10021:ToTable()) do
						if iter_240_2 then
							if arg_237_1.isInRecall_ then
								local var_240_11 = Mathf.Lerp(iter_240_2.color.r, arg_237_1.hightColor2.r, var_240_10)
								local var_240_12 = Mathf.Lerp(iter_240_2.color.g, arg_237_1.hightColor2.g, var_240_10)
								local var_240_13 = Mathf.Lerp(iter_240_2.color.b, arg_237_1.hightColor2.b, var_240_10)

								iter_240_2.color = Color.New(var_240_11, var_240_12, var_240_13)
							else
								local var_240_14 = Mathf.Lerp(iter_240_2.color.r, 0.5, var_240_10)

								iter_240_2.color = Color.New(var_240_14, var_240_14, var_240_14)
							end
						end
					end
				end
			end

			if arg_237_1.time_ >= var_240_8 + var_240_9 and arg_237_1.time_ < var_240_8 + var_240_9 + arg_240_0 and not isNil(var_240_7) and arg_237_1.var_.actorSpriteComps10021 then
				for iter_240_3, iter_240_4 in pairs(arg_237_1.var_.actorSpriteComps10021:ToTable()) do
					if iter_240_4 then
						if arg_237_1.isInRecall_ then
							iter_240_4.color = arg_237_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_240_4.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_237_1.var_.actorSpriteComps10021 = nil
			end

			local var_240_15 = arg_237_1.actors_["10018"]
			local var_240_16 = 0

			if var_240_16 < arg_237_1.time_ and arg_237_1.time_ <= var_240_16 + arg_240_0 and not isNil(var_240_15) and arg_237_1.var_.actorSpriteComps10018 == nil then
				arg_237_1.var_.actorSpriteComps10018 = var_240_15:GetComponentsInChildren(typeof(Image), true)
			end

			local var_240_17 = 0.034

			if var_240_16 <= arg_237_1.time_ and arg_237_1.time_ < var_240_16 + var_240_17 and not isNil(var_240_15) then
				local var_240_18 = (arg_237_1.time_ - var_240_16) / var_240_17

				if arg_237_1.var_.actorSpriteComps10018 then
					for iter_240_5, iter_240_6 in pairs(arg_237_1.var_.actorSpriteComps10018:ToTable()) do
						if iter_240_6 then
							if arg_237_1.isInRecall_ then
								local var_240_19 = Mathf.Lerp(iter_240_6.color.r, arg_237_1.hightColor1.r, var_240_18)
								local var_240_20 = Mathf.Lerp(iter_240_6.color.g, arg_237_1.hightColor1.g, var_240_18)
								local var_240_21 = Mathf.Lerp(iter_240_6.color.b, arg_237_1.hightColor1.b, var_240_18)

								iter_240_6.color = Color.New(var_240_19, var_240_20, var_240_21)
							else
								local var_240_22 = Mathf.Lerp(iter_240_6.color.r, 1, var_240_18)

								iter_240_6.color = Color.New(var_240_22, var_240_22, var_240_22)
							end
						end
					end
				end
			end

			if arg_237_1.time_ >= var_240_16 + var_240_17 and arg_237_1.time_ < var_240_16 + var_240_17 + arg_240_0 and not isNil(var_240_15) and arg_237_1.var_.actorSpriteComps10018 then
				for iter_240_7, iter_240_8 in pairs(arg_237_1.var_.actorSpriteComps10018:ToTable()) do
					if iter_240_8 then
						if arg_237_1.isInRecall_ then
							iter_240_8.color = arg_237_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_240_8.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_237_1.var_.actorSpriteComps10018 = nil
			end

			local var_240_23 = 0
			local var_240_24 = 0.75

			if var_240_23 < arg_237_1.time_ and arg_237_1.time_ <= var_240_23 + arg_240_0 then
				arg_237_1.talkMaxDuration = 0
				arg_237_1.dialogCg_.alpha = 1

				arg_237_1.dialog_:SetActive(true)
				SetActive(arg_237_1.leftNameGo_, true)

				local var_240_25 = arg_237_1:FormatText(StoryNameCfg[258].name)

				arg_237_1.leftNameTxt_.text = var_240_25

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_237_1.leftNameTxt_.transform)

				arg_237_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_237_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_237_1:RecordName(arg_237_1.leftNameTxt_.text)
				SetActive(arg_237_1.iconTrs_.gameObject, false)
				arg_237_1.callingController_:SetSelectedState("normal")

				local var_240_26 = arg_237_1:GetWordFromCfg(114251058)
				local var_240_27 = arg_237_1:FormatText(var_240_26.content)

				arg_237_1.text_.text = var_240_27

				LuaForUtil.ClearLinePrefixSymbol(arg_237_1.text_)

				local var_240_28 = 30
				local var_240_29 = utf8.len(var_240_27)
				local var_240_30 = var_240_28 <= 0 and var_240_24 or var_240_24 * (var_240_29 / var_240_28)

				if var_240_30 > 0 and var_240_24 < var_240_30 then
					arg_237_1.talkMaxDuration = var_240_30

					if var_240_30 + var_240_23 > arg_237_1.duration_ then
						arg_237_1.duration_ = var_240_30 + var_240_23
					end
				end

				arg_237_1.text_.text = var_240_27
				arg_237_1.typewritter.percent = 0

				arg_237_1.typewritter:SetDirty()
				arg_237_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_114251", "114251058", "story_v_out_114251.awb") ~= 0 then
					local var_240_31 = manager.audio:GetVoiceLength("story_v_out_114251", "114251058", "story_v_out_114251.awb") / 1000

					if var_240_31 + var_240_23 > arg_237_1.duration_ then
						arg_237_1.duration_ = var_240_31 + var_240_23
					end

					if var_240_26.prefab_name ~= "" and arg_237_1.actors_[var_240_26.prefab_name] ~= nil then
						local var_240_32 = LuaForUtil.PlayVoiceWithCriLipsync(arg_237_1.actors_[var_240_26.prefab_name].transform, "story_v_out_114251", "114251058", "story_v_out_114251.awb")

						arg_237_1:RecordAudio("114251058", var_240_32)
						arg_237_1:RecordAudio("114251058", var_240_32)
					else
						arg_237_1:AudioAction("play", "voice", "story_v_out_114251", "114251058", "story_v_out_114251.awb")
					end

					arg_237_1:RecordHistoryTalkVoice("story_v_out_114251", "114251058", "story_v_out_114251.awb")
				end

				arg_237_1:RecordContent(arg_237_1.text_.text)
			end

			local var_240_33 = math.max(var_240_24, arg_237_1.talkMaxDuration)

			if var_240_23 <= arg_237_1.time_ and arg_237_1.time_ < var_240_23 + var_240_33 then
				arg_237_1.typewritter.percent = (arg_237_1.time_ - var_240_23) / var_240_33

				arg_237_1.typewritter:SetDirty()
			end

			if arg_237_1.time_ >= var_240_23 + var_240_33 and arg_237_1.time_ < var_240_23 + var_240_33 + arg_240_0 then
				arg_237_1.typewritter.percent = 1

				arg_237_1.typewritter:SetDirty()
				arg_237_1:ShowNextGo(true)
			end
		end

		arg_237_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10018",
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
	Play114251059 = function(arg_241_0, arg_241_1)
		arg_241_1.time_ = 0
		arg_241_1.frameCnt_ = 0
		arg_241_1.state_ = "playing"
		arg_241_1.curTalkId_ = 114251059
		arg_241_1.duration_ = 9.33

		local var_241_0 = {
			ja = 9.333,
			ko = 8.1,
			zh = 7.366,
			en = 7.933
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
				arg_241_0:Play114251060(arg_241_1)
			end
		end

		function arg_241_1.onSingleLineUpdate_(arg_244_0)
			local var_244_0 = arg_241_1.actors_["10021"]
			local var_244_1 = 0

			if var_244_1 < arg_241_1.time_ and arg_241_1.time_ <= var_244_1 + arg_244_0 and not isNil(var_244_0) and arg_241_1.var_.actorSpriteComps10021 == nil then
				arg_241_1.var_.actorSpriteComps10021 = var_244_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_244_2 = 0.034

			if var_244_1 <= arg_241_1.time_ and arg_241_1.time_ < var_244_1 + var_244_2 and not isNil(var_244_0) then
				local var_244_3 = (arg_241_1.time_ - var_244_1) / var_244_2

				if arg_241_1.var_.actorSpriteComps10021 then
					for iter_244_0, iter_244_1 in pairs(arg_241_1.var_.actorSpriteComps10021:ToTable()) do
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

			if arg_241_1.time_ >= var_244_1 + var_244_2 and arg_241_1.time_ < var_244_1 + var_244_2 + arg_244_0 and not isNil(var_244_0) and arg_241_1.var_.actorSpriteComps10021 then
				for iter_244_2, iter_244_3 in pairs(arg_241_1.var_.actorSpriteComps10021:ToTable()) do
					if iter_244_3 then
						if arg_241_1.isInRecall_ then
							iter_244_3.color = arg_241_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_244_3.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_241_1.var_.actorSpriteComps10021 = nil
			end

			local var_244_8 = arg_241_1.actors_["10018"]
			local var_244_9 = 0

			if var_244_9 < arg_241_1.time_ and arg_241_1.time_ <= var_244_9 + arg_244_0 and not isNil(var_244_8) and arg_241_1.var_.actorSpriteComps10018 == nil then
				arg_241_1.var_.actorSpriteComps10018 = var_244_8:GetComponentsInChildren(typeof(Image), true)
			end

			local var_244_10 = 0.034

			if var_244_9 <= arg_241_1.time_ and arg_241_1.time_ < var_244_9 + var_244_10 and not isNil(var_244_8) then
				local var_244_11 = (arg_241_1.time_ - var_244_9) / var_244_10

				if arg_241_1.var_.actorSpriteComps10018 then
					for iter_244_4, iter_244_5 in pairs(arg_241_1.var_.actorSpriteComps10018:ToTable()) do
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

			if arg_241_1.time_ >= var_244_9 + var_244_10 and arg_241_1.time_ < var_244_9 + var_244_10 + arg_244_0 and not isNil(var_244_8) and arg_241_1.var_.actorSpriteComps10018 then
				for iter_244_6, iter_244_7 in pairs(arg_241_1.var_.actorSpriteComps10018:ToTable()) do
					if iter_244_7 then
						if arg_241_1.isInRecall_ then
							iter_244_7.color = arg_241_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_244_7.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_241_1.var_.actorSpriteComps10018 = nil
			end

			local var_244_16 = 0
			local var_244_17 = 0.95

			if var_244_16 < arg_241_1.time_ and arg_241_1.time_ <= var_244_16 + arg_244_0 then
				arg_241_1.talkMaxDuration = 0
				arg_241_1.dialogCg_.alpha = 1

				arg_241_1.dialog_:SetActive(true)
				SetActive(arg_241_1.leftNameGo_, true)

				local var_244_18 = arg_241_1:FormatText(StoryNameCfg[226].name)

				arg_241_1.leftNameTxt_.text = var_244_18

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_241_1.leftNameTxt_.transform)

				arg_241_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_241_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_241_1:RecordName(arg_241_1.leftNameTxt_.text)
				SetActive(arg_241_1.iconTrs_.gameObject, false)
				arg_241_1.callingController_:SetSelectedState("normal")

				local var_244_19 = arg_241_1:GetWordFromCfg(114251059)
				local var_244_20 = arg_241_1:FormatText(var_244_19.content)

				arg_241_1.text_.text = var_244_20

				LuaForUtil.ClearLinePrefixSymbol(arg_241_1.text_)

				local var_244_21 = 37
				local var_244_22 = utf8.len(var_244_20)
				local var_244_23 = var_244_21 <= 0 and var_244_17 or var_244_17 * (var_244_22 / var_244_21)

				if var_244_23 > 0 and var_244_17 < var_244_23 then
					arg_241_1.talkMaxDuration = var_244_23

					if var_244_23 + var_244_16 > arg_241_1.duration_ then
						arg_241_1.duration_ = var_244_23 + var_244_16
					end
				end

				arg_241_1.text_.text = var_244_20
				arg_241_1.typewritter.percent = 0

				arg_241_1.typewritter:SetDirty()
				arg_241_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_114251", "114251059", "story_v_out_114251.awb") ~= 0 then
					local var_244_24 = manager.audio:GetVoiceLength("story_v_out_114251", "114251059", "story_v_out_114251.awb") / 1000

					if var_244_24 + var_244_16 > arg_241_1.duration_ then
						arg_241_1.duration_ = var_244_24 + var_244_16
					end

					if var_244_19.prefab_name ~= "" and arg_241_1.actors_[var_244_19.prefab_name] ~= nil then
						local var_244_25 = LuaForUtil.PlayVoiceWithCriLipsync(arg_241_1.actors_[var_244_19.prefab_name].transform, "story_v_out_114251", "114251059", "story_v_out_114251.awb")

						arg_241_1:RecordAudio("114251059", var_244_25)
						arg_241_1:RecordAudio("114251059", var_244_25)
					else
						arg_241_1:AudioAction("play", "voice", "story_v_out_114251", "114251059", "story_v_out_114251.awb")
					end

					arg_241_1:RecordHistoryTalkVoice("story_v_out_114251", "114251059", "story_v_out_114251.awb")
				end

				arg_241_1:RecordContent(arg_241_1.text_.text)
			end

			local var_244_26 = math.max(var_244_17, arg_241_1.talkMaxDuration)

			if var_244_16 <= arg_241_1.time_ and arg_241_1.time_ < var_244_16 + var_244_26 then
				arg_241_1.typewritter.percent = (arg_241_1.time_ - var_244_16) / var_244_26

				arg_241_1.typewritter:SetDirty()
			end

			if arg_241_1.time_ >= var_244_16 + var_244_26 and arg_241_1.time_ < var_244_16 + var_244_26 + arg_244_0 then
				arg_241_1.typewritter.percent = 1

				arg_241_1.typewritter:SetDirty()
				arg_241_1:ShowNextGo(true)
			end
		end

		arg_241_1.nodeConfigList_ = {}

		arg_241_1:InitPlayNodeList()
	end,
	Play114251060 = function(arg_245_0, arg_245_1)
		arg_245_1.time_ = 0
		arg_245_1.frameCnt_ = 0
		arg_245_1.state_ = "playing"
		arg_245_1.curTalkId_ = 114251060
		arg_245_1.duration_ = 12.57

		local var_245_0 = {
			ja = 12.566,
			ko = 6.966,
			zh = 7.4,
			en = 6.4
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
				arg_245_0:Play114251061(arg_245_1)
			end
		end

		function arg_245_1.onSingleLineUpdate_(arg_248_0)
			local var_248_0 = 0
			local var_248_1 = 0.975

			if var_248_0 < arg_245_1.time_ and arg_245_1.time_ <= var_248_0 + arg_248_0 then
				arg_245_1.talkMaxDuration = 0
				arg_245_1.dialogCg_.alpha = 1

				arg_245_1.dialog_:SetActive(true)
				SetActive(arg_245_1.leftNameGo_, true)

				local var_248_2 = arg_245_1:FormatText(StoryNameCfg[226].name)

				arg_245_1.leftNameTxt_.text = var_248_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_245_1.leftNameTxt_.transform)

				arg_245_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_245_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_245_1:RecordName(arg_245_1.leftNameTxt_.text)
				SetActive(arg_245_1.iconTrs_.gameObject, false)
				arg_245_1.callingController_:SetSelectedState("normal")

				local var_248_3 = arg_245_1:GetWordFromCfg(114251060)
				local var_248_4 = arg_245_1:FormatText(var_248_3.content)

				arg_245_1.text_.text = var_248_4

				LuaForUtil.ClearLinePrefixSymbol(arg_245_1.text_)

				local var_248_5 = 38
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

				if manager.audio:GetVoiceLength("story_v_out_114251", "114251060", "story_v_out_114251.awb") ~= 0 then
					local var_248_8 = manager.audio:GetVoiceLength("story_v_out_114251", "114251060", "story_v_out_114251.awb") / 1000

					if var_248_8 + var_248_0 > arg_245_1.duration_ then
						arg_245_1.duration_ = var_248_8 + var_248_0
					end

					if var_248_3.prefab_name ~= "" and arg_245_1.actors_[var_248_3.prefab_name] ~= nil then
						local var_248_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_245_1.actors_[var_248_3.prefab_name].transform, "story_v_out_114251", "114251060", "story_v_out_114251.awb")

						arg_245_1:RecordAudio("114251060", var_248_9)
						arg_245_1:RecordAudio("114251060", var_248_9)
					else
						arg_245_1:AudioAction("play", "voice", "story_v_out_114251", "114251060", "story_v_out_114251.awb")
					end

					arg_245_1:RecordHistoryTalkVoice("story_v_out_114251", "114251060", "story_v_out_114251.awb")
				end

				arg_245_1:RecordContent(arg_245_1.text_.text)
			end

			local var_248_10 = math.max(var_248_1, arg_245_1.talkMaxDuration)

			if var_248_0 <= arg_245_1.time_ and arg_245_1.time_ < var_248_0 + var_248_10 then
				arg_245_1.typewritter.percent = (arg_245_1.time_ - var_248_0) / var_248_10

				arg_245_1.typewritter:SetDirty()
			end

			if arg_245_1.time_ >= var_248_0 + var_248_10 and arg_245_1.time_ < var_248_0 + var_248_10 + arg_248_0 then
				arg_245_1.typewritter.percent = 1

				arg_245_1.typewritter:SetDirty()
				arg_245_1:ShowNextGo(true)
			end
		end

		arg_245_1.nodeConfigList_ = {}

		arg_245_1:InitPlayNodeList()
	end,
	Play114251061 = function(arg_249_0, arg_249_1)
		arg_249_1.time_ = 0
		arg_249_1.frameCnt_ = 0
		arg_249_1.state_ = "playing"
		arg_249_1.curTalkId_ = 114251061
		arg_249_1.duration_ = 18.1

		local var_249_0 = {
			ja = 15.766,
			ko = 11.066,
			zh = 11.133,
			en = 18.1
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
				arg_249_0:Play114251062(arg_249_1)
			end
		end

		function arg_249_1.onSingleLineUpdate_(arg_252_0)
			local var_252_0 = 0
			local var_252_1 = 1.375

			if var_252_0 < arg_249_1.time_ and arg_249_1.time_ <= var_252_0 + arg_252_0 then
				arg_249_1.talkMaxDuration = 0
				arg_249_1.dialogCg_.alpha = 1

				arg_249_1.dialog_:SetActive(true)
				SetActive(arg_249_1.leftNameGo_, true)

				local var_252_2 = arg_249_1:FormatText(StoryNameCfg[226].name)

				arg_249_1.leftNameTxt_.text = var_252_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_249_1.leftNameTxt_.transform)

				arg_249_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_249_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_249_1:RecordName(arg_249_1.leftNameTxt_.text)
				SetActive(arg_249_1.iconTrs_.gameObject, false)
				arg_249_1.callingController_:SetSelectedState("normal")

				local var_252_3 = arg_249_1:GetWordFromCfg(114251061)
				local var_252_4 = arg_249_1:FormatText(var_252_3.content)

				arg_249_1.text_.text = var_252_4

				LuaForUtil.ClearLinePrefixSymbol(arg_249_1.text_)

				local var_252_5 = 54
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

				if manager.audio:GetVoiceLength("story_v_out_114251", "114251061", "story_v_out_114251.awb") ~= 0 then
					local var_252_8 = manager.audio:GetVoiceLength("story_v_out_114251", "114251061", "story_v_out_114251.awb") / 1000

					if var_252_8 + var_252_0 > arg_249_1.duration_ then
						arg_249_1.duration_ = var_252_8 + var_252_0
					end

					if var_252_3.prefab_name ~= "" and arg_249_1.actors_[var_252_3.prefab_name] ~= nil then
						local var_252_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_249_1.actors_[var_252_3.prefab_name].transform, "story_v_out_114251", "114251061", "story_v_out_114251.awb")

						arg_249_1:RecordAudio("114251061", var_252_9)
						arg_249_1:RecordAudio("114251061", var_252_9)
					else
						arg_249_1:AudioAction("play", "voice", "story_v_out_114251", "114251061", "story_v_out_114251.awb")
					end

					arg_249_1:RecordHistoryTalkVoice("story_v_out_114251", "114251061", "story_v_out_114251.awb")
				end

				arg_249_1:RecordContent(arg_249_1.text_.text)
			end

			local var_252_10 = math.max(var_252_1, arg_249_1.talkMaxDuration)

			if var_252_0 <= arg_249_1.time_ and arg_249_1.time_ < var_252_0 + var_252_10 then
				arg_249_1.typewritter.percent = (arg_249_1.time_ - var_252_0) / var_252_10

				arg_249_1.typewritter:SetDirty()
			end

			if arg_249_1.time_ >= var_252_0 + var_252_10 and arg_249_1.time_ < var_252_0 + var_252_10 + arg_252_0 then
				arg_249_1.typewritter.percent = 1

				arg_249_1.typewritter:SetDirty()
				arg_249_1:ShowNextGo(true)
			end
		end

		arg_249_1.nodeConfigList_ = {}

		arg_249_1:InitPlayNodeList()
	end,
	Play114251062 = function(arg_253_0, arg_253_1)
		arg_253_1.time_ = 0
		arg_253_1.frameCnt_ = 0
		arg_253_1.state_ = "playing"
		arg_253_1.curTalkId_ = 114251062
		arg_253_1.duration_ = 6.73

		local var_253_0 = {
			ja = 6.733,
			ko = 3.033,
			zh = 2.766,
			en = 3.666
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
				arg_253_0:Play114251063(arg_253_1)
			end
		end

		function arg_253_1.onSingleLineUpdate_(arg_256_0)
			local var_256_0 = arg_253_1.actors_["10021"]
			local var_256_1 = 0

			if var_256_1 < arg_253_1.time_ and arg_253_1.time_ <= var_256_1 + arg_256_0 and not isNil(var_256_0) and arg_253_1.var_.actorSpriteComps10021 == nil then
				arg_253_1.var_.actorSpriteComps10021 = var_256_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_256_2 = 0.034

			if var_256_1 <= arg_253_1.time_ and arg_253_1.time_ < var_256_1 + var_256_2 and not isNil(var_256_0) then
				local var_256_3 = (arg_253_1.time_ - var_256_1) / var_256_2

				if arg_253_1.var_.actorSpriteComps10021 then
					for iter_256_0, iter_256_1 in pairs(arg_253_1.var_.actorSpriteComps10021:ToTable()) do
						if iter_256_1 then
							if arg_253_1.isInRecall_ then
								local var_256_4 = Mathf.Lerp(iter_256_1.color.r, arg_253_1.hightColor2.r, var_256_3)
								local var_256_5 = Mathf.Lerp(iter_256_1.color.g, arg_253_1.hightColor2.g, var_256_3)
								local var_256_6 = Mathf.Lerp(iter_256_1.color.b, arg_253_1.hightColor2.b, var_256_3)

								iter_256_1.color = Color.New(var_256_4, var_256_5, var_256_6)
							else
								local var_256_7 = Mathf.Lerp(iter_256_1.color.r, 0.5, var_256_3)

								iter_256_1.color = Color.New(var_256_7, var_256_7, var_256_7)
							end
						end
					end
				end
			end

			if arg_253_1.time_ >= var_256_1 + var_256_2 and arg_253_1.time_ < var_256_1 + var_256_2 + arg_256_0 and not isNil(var_256_0) and arg_253_1.var_.actorSpriteComps10021 then
				for iter_256_2, iter_256_3 in pairs(arg_253_1.var_.actorSpriteComps10021:ToTable()) do
					if iter_256_3 then
						if arg_253_1.isInRecall_ then
							iter_256_3.color = arg_253_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_256_3.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_253_1.var_.actorSpriteComps10021 = nil
			end

			local var_256_8 = arg_253_1.actors_["10018"]
			local var_256_9 = 0

			if var_256_9 < arg_253_1.time_ and arg_253_1.time_ <= var_256_9 + arg_256_0 and not isNil(var_256_8) and arg_253_1.var_.actorSpriteComps10018 == nil then
				arg_253_1.var_.actorSpriteComps10018 = var_256_8:GetComponentsInChildren(typeof(Image), true)
			end

			local var_256_10 = 0.034

			if var_256_9 <= arg_253_1.time_ and arg_253_1.time_ < var_256_9 + var_256_10 and not isNil(var_256_8) then
				local var_256_11 = (arg_253_1.time_ - var_256_9) / var_256_10

				if arg_253_1.var_.actorSpriteComps10018 then
					for iter_256_4, iter_256_5 in pairs(arg_253_1.var_.actorSpriteComps10018:ToTable()) do
						if iter_256_5 then
							if arg_253_1.isInRecall_ then
								local var_256_12 = Mathf.Lerp(iter_256_5.color.r, arg_253_1.hightColor1.r, var_256_11)
								local var_256_13 = Mathf.Lerp(iter_256_5.color.g, arg_253_1.hightColor1.g, var_256_11)
								local var_256_14 = Mathf.Lerp(iter_256_5.color.b, arg_253_1.hightColor1.b, var_256_11)

								iter_256_5.color = Color.New(var_256_12, var_256_13, var_256_14)
							else
								local var_256_15 = Mathf.Lerp(iter_256_5.color.r, 1, var_256_11)

								iter_256_5.color = Color.New(var_256_15, var_256_15, var_256_15)
							end
						end
					end
				end
			end

			if arg_253_1.time_ >= var_256_9 + var_256_10 and arg_253_1.time_ < var_256_9 + var_256_10 + arg_256_0 and not isNil(var_256_8) and arg_253_1.var_.actorSpriteComps10018 then
				for iter_256_6, iter_256_7 in pairs(arg_253_1.var_.actorSpriteComps10018:ToTable()) do
					if iter_256_7 then
						if arg_253_1.isInRecall_ then
							iter_256_7.color = arg_253_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_256_7.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_253_1.var_.actorSpriteComps10018 = nil
			end

			local var_256_16 = arg_253_1.actors_["10018"]
			local var_256_17 = 0

			if var_256_17 < arg_253_1.time_ and arg_253_1.time_ <= var_256_17 + arg_256_0 then
				local var_256_18 = var_256_16:GetComponentInChildren(typeof(CanvasGroup))

				if var_256_18 then
					arg_253_1.var_.alphaOldValue10018 = var_256_18.alpha
					arg_253_1.var_.characterEffect10018 = var_256_18
				end

				arg_253_1.var_.alphaOldValue10018 = 0
			end

			local var_256_19 = 0.0166666666666667

			if var_256_17 <= arg_253_1.time_ and arg_253_1.time_ < var_256_17 + var_256_19 then
				local var_256_20 = (arg_253_1.time_ - var_256_17) / var_256_19
				local var_256_21 = Mathf.Lerp(arg_253_1.var_.alphaOldValue10018, 1, var_256_20)

				if arg_253_1.var_.characterEffect10018 then
					arg_253_1.var_.characterEffect10018.alpha = var_256_21
				end
			end

			if arg_253_1.time_ >= var_256_17 + var_256_19 and arg_253_1.time_ < var_256_17 + var_256_19 + arg_256_0 and arg_253_1.var_.characterEffect10018 then
				arg_253_1.var_.characterEffect10018.alpha = 1
			end

			local var_256_22 = 0
			local var_256_23 = 0.2

			if var_256_22 < arg_253_1.time_ and arg_253_1.time_ <= var_256_22 + arg_256_0 then
				arg_253_1.talkMaxDuration = 0
				arg_253_1.dialogCg_.alpha = 1

				arg_253_1.dialog_:SetActive(true)
				SetActive(arg_253_1.leftNameGo_, true)

				local var_256_24 = arg_253_1:FormatText(StoryNameCfg[258].name)

				arg_253_1.leftNameTxt_.text = var_256_24

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_253_1.leftNameTxt_.transform)

				arg_253_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_253_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_253_1:RecordName(arg_253_1.leftNameTxt_.text)
				SetActive(arg_253_1.iconTrs_.gameObject, false)
				arg_253_1.callingController_:SetSelectedState("normal")

				local var_256_25 = arg_253_1:GetWordFromCfg(114251062)
				local var_256_26 = arg_253_1:FormatText(var_256_25.content)

				arg_253_1.text_.text = var_256_26

				LuaForUtil.ClearLinePrefixSymbol(arg_253_1.text_)

				local var_256_27 = 8
				local var_256_28 = utf8.len(var_256_26)
				local var_256_29 = var_256_27 <= 0 and var_256_23 or var_256_23 * (var_256_28 / var_256_27)

				if var_256_29 > 0 and var_256_23 < var_256_29 then
					arg_253_1.talkMaxDuration = var_256_29

					if var_256_29 + var_256_22 > arg_253_1.duration_ then
						arg_253_1.duration_ = var_256_29 + var_256_22
					end
				end

				arg_253_1.text_.text = var_256_26
				arg_253_1.typewritter.percent = 0

				arg_253_1.typewritter:SetDirty()
				arg_253_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_114251", "114251062", "story_v_out_114251.awb") ~= 0 then
					local var_256_30 = manager.audio:GetVoiceLength("story_v_out_114251", "114251062", "story_v_out_114251.awb") / 1000

					if var_256_30 + var_256_22 > arg_253_1.duration_ then
						arg_253_1.duration_ = var_256_30 + var_256_22
					end

					if var_256_25.prefab_name ~= "" and arg_253_1.actors_[var_256_25.prefab_name] ~= nil then
						local var_256_31 = LuaForUtil.PlayVoiceWithCriLipsync(arg_253_1.actors_[var_256_25.prefab_name].transform, "story_v_out_114251", "114251062", "story_v_out_114251.awb")

						arg_253_1:RecordAudio("114251062", var_256_31)
						arg_253_1:RecordAudio("114251062", var_256_31)
					else
						arg_253_1:AudioAction("play", "voice", "story_v_out_114251", "114251062", "story_v_out_114251.awb")
					end

					arg_253_1:RecordHistoryTalkVoice("story_v_out_114251", "114251062", "story_v_out_114251.awb")
				end

				arg_253_1:RecordContent(arg_253_1.text_.text)
			end

			local var_256_32 = math.max(var_256_23, arg_253_1.talkMaxDuration)

			if var_256_22 <= arg_253_1.time_ and arg_253_1.time_ < var_256_22 + var_256_32 then
				arg_253_1.typewritter.percent = (arg_253_1.time_ - var_256_22) / var_256_32

				arg_253_1.typewritter:SetDirty()
			end

			if arg_253_1.time_ >= var_256_22 + var_256_32 and arg_253_1.time_ < var_256_22 + var_256_32 + arg_256_0 then
				arg_253_1.typewritter.percent = 1

				arg_253_1.typewritter:SetDirty()
				arg_253_1:ShowNextGo(true)
			end
		end

		arg_253_1.nodeConfigList_ = {}

		arg_253_1:InitPlayNodeList()
	end,
	Play114251063 = function(arg_257_0, arg_257_1)
		arg_257_1.time_ = 0
		arg_257_1.frameCnt_ = 0
		arg_257_1.state_ = "playing"
		arg_257_1.curTalkId_ = 114251063
		arg_257_1.duration_ = 5

		SetActive(arg_257_1.tipsGo_, false)

		function arg_257_1.onSingleLineFinish_()
			arg_257_1.onSingleLineUpdate_ = nil
			arg_257_1.onSingleLineFinish_ = nil
			arg_257_1.state_ = "waiting"
		end

		function arg_257_1.playNext_(arg_259_0)
			if arg_259_0 == 1 then
				arg_257_0:Play114251064(arg_257_1)
			end
		end

		function arg_257_1.onSingleLineUpdate_(arg_260_0)
			local var_260_0 = arg_257_1.actors_["10018"]
			local var_260_1 = 0

			if var_260_1 < arg_257_1.time_ and arg_257_1.time_ <= var_260_1 + arg_260_0 and not isNil(var_260_0) and arg_257_1.var_.actorSpriteComps10018 == nil then
				arg_257_1.var_.actorSpriteComps10018 = var_260_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_260_2 = 0.034

			if var_260_1 <= arg_257_1.time_ and arg_257_1.time_ < var_260_1 + var_260_2 and not isNil(var_260_0) then
				local var_260_3 = (arg_257_1.time_ - var_260_1) / var_260_2

				if arg_257_1.var_.actorSpriteComps10018 then
					for iter_260_0, iter_260_1 in pairs(arg_257_1.var_.actorSpriteComps10018:ToTable()) do
						if iter_260_1 then
							if arg_257_1.isInRecall_ then
								local var_260_4 = Mathf.Lerp(iter_260_1.color.r, arg_257_1.hightColor2.r, var_260_3)
								local var_260_5 = Mathf.Lerp(iter_260_1.color.g, arg_257_1.hightColor2.g, var_260_3)
								local var_260_6 = Mathf.Lerp(iter_260_1.color.b, arg_257_1.hightColor2.b, var_260_3)

								iter_260_1.color = Color.New(var_260_4, var_260_5, var_260_6)
							else
								local var_260_7 = Mathf.Lerp(iter_260_1.color.r, 0.5, var_260_3)

								iter_260_1.color = Color.New(var_260_7, var_260_7, var_260_7)
							end
						end
					end
				end
			end

			if arg_257_1.time_ >= var_260_1 + var_260_2 and arg_257_1.time_ < var_260_1 + var_260_2 + arg_260_0 and not isNil(var_260_0) and arg_257_1.var_.actorSpriteComps10018 then
				for iter_260_2, iter_260_3 in pairs(arg_257_1.var_.actorSpriteComps10018:ToTable()) do
					if iter_260_3 then
						if arg_257_1.isInRecall_ then
							iter_260_3.color = arg_257_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_260_3.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_257_1.var_.actorSpriteComps10018 = nil
			end

			local var_260_8 = 0
			local var_260_9 = 0.525

			if var_260_8 < arg_257_1.time_ and arg_257_1.time_ <= var_260_8 + arg_260_0 then
				arg_257_1.talkMaxDuration = 0
				arg_257_1.dialogCg_.alpha = 1

				arg_257_1.dialog_:SetActive(true)
				SetActive(arg_257_1.leftNameGo_, false)

				arg_257_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_257_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_257_1:RecordName(arg_257_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_257_1.iconTrs_.gameObject, false)
				arg_257_1.callingController_:SetSelectedState("normal")

				local var_260_10 = arg_257_1:GetWordFromCfg(114251063)
				local var_260_11 = arg_257_1:FormatText(var_260_10.content)

				arg_257_1.text_.text = var_260_11

				LuaForUtil.ClearLinePrefixSymbol(arg_257_1.text_)

				local var_260_12 = 21
				local var_260_13 = utf8.len(var_260_11)
				local var_260_14 = var_260_12 <= 0 and var_260_9 or var_260_9 * (var_260_13 / var_260_12)

				if var_260_14 > 0 and var_260_9 < var_260_14 then
					arg_257_1.talkMaxDuration = var_260_14

					if var_260_14 + var_260_8 > arg_257_1.duration_ then
						arg_257_1.duration_ = var_260_14 + var_260_8
					end
				end

				arg_257_1.text_.text = var_260_11
				arg_257_1.typewritter.percent = 0

				arg_257_1.typewritter:SetDirty()
				arg_257_1:ShowNextGo(false)
				arg_257_1:RecordContent(arg_257_1.text_.text)
			end

			local var_260_15 = math.max(var_260_9, arg_257_1.talkMaxDuration)

			if var_260_8 <= arg_257_1.time_ and arg_257_1.time_ < var_260_8 + var_260_15 then
				arg_257_1.typewritter.percent = (arg_257_1.time_ - var_260_8) / var_260_15

				arg_257_1.typewritter:SetDirty()
			end

			if arg_257_1.time_ >= var_260_8 + var_260_15 and arg_257_1.time_ < var_260_8 + var_260_15 + arg_260_0 then
				arg_257_1.typewritter.percent = 1

				arg_257_1.typewritter:SetDirty()
				arg_257_1:ShowNextGo(true)
			end
		end

		arg_257_1.nodeConfigList_ = {}

		arg_257_1:InitPlayNodeList()
	end,
	Play114251064 = function(arg_261_0, arg_261_1)
		arg_261_1.time_ = 0
		arg_261_1.frameCnt_ = 0
		arg_261_1.state_ = "playing"
		arg_261_1.curTalkId_ = 114251064
		arg_261_1.duration_ = 3.93

		local var_261_0 = {
			ja = 2.3,
			ko = 2.966,
			zh = 2.633,
			en = 3.933
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
				arg_261_0:Play114251065(arg_261_1)
			end
		end

		function arg_261_1.onSingleLineUpdate_(arg_264_0)
			local var_264_0 = arg_261_1.actors_["10018"].transform
			local var_264_1 = 0

			if var_264_1 < arg_261_1.time_ and arg_261_1.time_ <= var_264_1 + arg_264_0 then
				arg_261_1.var_.moveOldPos10018 = var_264_0.localPosition
				var_264_0.localScale = Vector3.New(1, 1, 1)

				arg_261_1:CheckSpriteTmpPos("10018", 4)

				local var_264_2 = var_264_0.childCount

				for iter_264_0 = 0, var_264_2 - 1 do
					local var_264_3 = var_264_0:GetChild(iter_264_0)

					if var_264_3.name == "split_2" or not string.find(var_264_3.name, "split") then
						var_264_3.gameObject:SetActive(true)
					else
						var_264_3.gameObject:SetActive(false)
					end
				end
			end

			local var_264_4 = 0.001

			if var_264_1 <= arg_261_1.time_ and arg_261_1.time_ < var_264_1 + var_264_4 then
				local var_264_5 = (arg_261_1.time_ - var_264_1) / var_264_4
				local var_264_6 = Vector3.New(390, -350, -180)

				var_264_0.localPosition = Vector3.Lerp(arg_261_1.var_.moveOldPos10018, var_264_6, var_264_5)
			end

			if arg_261_1.time_ >= var_264_1 + var_264_4 and arg_261_1.time_ < var_264_1 + var_264_4 + arg_264_0 then
				var_264_0.localPosition = Vector3.New(390, -350, -180)
			end

			local var_264_7 = arg_261_1.actors_["10018"]
			local var_264_8 = 0

			if var_264_8 < arg_261_1.time_ and arg_261_1.time_ <= var_264_8 + arg_264_0 and not isNil(var_264_7) and arg_261_1.var_.actorSpriteComps10018 == nil then
				arg_261_1.var_.actorSpriteComps10018 = var_264_7:GetComponentsInChildren(typeof(Image), true)
			end

			local var_264_9 = 0.034

			if var_264_8 <= arg_261_1.time_ and arg_261_1.time_ < var_264_8 + var_264_9 and not isNil(var_264_7) then
				local var_264_10 = (arg_261_1.time_ - var_264_8) / var_264_9

				if arg_261_1.var_.actorSpriteComps10018 then
					for iter_264_1, iter_264_2 in pairs(arg_261_1.var_.actorSpriteComps10018:ToTable()) do
						if iter_264_2 then
							if arg_261_1.isInRecall_ then
								local var_264_11 = Mathf.Lerp(iter_264_2.color.r, arg_261_1.hightColor1.r, var_264_10)
								local var_264_12 = Mathf.Lerp(iter_264_2.color.g, arg_261_1.hightColor1.g, var_264_10)
								local var_264_13 = Mathf.Lerp(iter_264_2.color.b, arg_261_1.hightColor1.b, var_264_10)

								iter_264_2.color = Color.New(var_264_11, var_264_12, var_264_13)
							else
								local var_264_14 = Mathf.Lerp(iter_264_2.color.r, 1, var_264_10)

								iter_264_2.color = Color.New(var_264_14, var_264_14, var_264_14)
							end
						end
					end
				end
			end

			if arg_261_1.time_ >= var_264_8 + var_264_9 and arg_261_1.time_ < var_264_8 + var_264_9 + arg_264_0 and not isNil(var_264_7) and arg_261_1.var_.actorSpriteComps10018 then
				for iter_264_3, iter_264_4 in pairs(arg_261_1.var_.actorSpriteComps10018:ToTable()) do
					if iter_264_4 then
						if arg_261_1.isInRecall_ then
							iter_264_4.color = arg_261_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_264_4.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_261_1.var_.actorSpriteComps10018 = nil
			end

			local var_264_15 = 0
			local var_264_16 = 0.325

			if var_264_15 < arg_261_1.time_ and arg_261_1.time_ <= var_264_15 + arg_264_0 then
				arg_261_1.talkMaxDuration = 0
				arg_261_1.dialogCg_.alpha = 1

				arg_261_1.dialog_:SetActive(true)
				SetActive(arg_261_1.leftNameGo_, true)

				local var_264_17 = arg_261_1:FormatText(StoryNameCfg[258].name)

				arg_261_1.leftNameTxt_.text = var_264_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_261_1.leftNameTxt_.transform)

				arg_261_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_261_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_261_1:RecordName(arg_261_1.leftNameTxt_.text)
				SetActive(arg_261_1.iconTrs_.gameObject, false)
				arg_261_1.callingController_:SetSelectedState("normal")

				local var_264_18 = arg_261_1:GetWordFromCfg(114251064)
				local var_264_19 = arg_261_1:FormatText(var_264_18.content)

				arg_261_1.text_.text = var_264_19

				LuaForUtil.ClearLinePrefixSymbol(arg_261_1.text_)

				local var_264_20 = 13
				local var_264_21 = utf8.len(var_264_19)
				local var_264_22 = var_264_20 <= 0 and var_264_16 or var_264_16 * (var_264_21 / var_264_20)

				if var_264_22 > 0 and var_264_16 < var_264_22 then
					arg_261_1.talkMaxDuration = var_264_22

					if var_264_22 + var_264_15 > arg_261_1.duration_ then
						arg_261_1.duration_ = var_264_22 + var_264_15
					end
				end

				arg_261_1.text_.text = var_264_19
				arg_261_1.typewritter.percent = 0

				arg_261_1.typewritter:SetDirty()
				arg_261_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_114251", "114251064", "story_v_out_114251.awb") ~= 0 then
					local var_264_23 = manager.audio:GetVoiceLength("story_v_out_114251", "114251064", "story_v_out_114251.awb") / 1000

					if var_264_23 + var_264_15 > arg_261_1.duration_ then
						arg_261_1.duration_ = var_264_23 + var_264_15
					end

					if var_264_18.prefab_name ~= "" and arg_261_1.actors_[var_264_18.prefab_name] ~= nil then
						local var_264_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_261_1.actors_[var_264_18.prefab_name].transform, "story_v_out_114251", "114251064", "story_v_out_114251.awb")

						arg_261_1:RecordAudio("114251064", var_264_24)
						arg_261_1:RecordAudio("114251064", var_264_24)
					else
						arg_261_1:AudioAction("play", "voice", "story_v_out_114251", "114251064", "story_v_out_114251.awb")
					end

					arg_261_1:RecordHistoryTalkVoice("story_v_out_114251", "114251064", "story_v_out_114251.awb")
				end

				arg_261_1:RecordContent(arg_261_1.text_.text)
			end

			local var_264_25 = math.max(var_264_16, arg_261_1.talkMaxDuration)

			if var_264_15 <= arg_261_1.time_ and arg_261_1.time_ < var_264_15 + var_264_25 then
				arg_261_1.typewritter.percent = (arg_261_1.time_ - var_264_15) / var_264_25

				arg_261_1.typewritter:SetDirty()
			end

			if arg_261_1.time_ >= var_264_15 + var_264_25 and arg_261_1.time_ < var_264_15 + var_264_25 + arg_264_0 then
				arg_261_1.typewritter.percent = 1

				arg_261_1.typewritter:SetDirty()
				arg_261_1:ShowNextGo(true)
			end
		end

		arg_261_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10018",
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
	Play114251065 = function(arg_265_0, arg_265_1)
		arg_265_1.time_ = 0
		arg_265_1.frameCnt_ = 0
		arg_265_1.state_ = "playing"
		arg_265_1.curTalkId_ = 114251065
		arg_265_1.duration_ = 2.23

		local var_265_0 = {
			ja = 1.7,
			ko = 1.4,
			zh = 2.233,
			en = 1.433
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
				arg_265_0:Play114251066(arg_265_1)
			end
		end

		function arg_265_1.onSingleLineUpdate_(arg_268_0)
			local var_268_0 = arg_265_1.actors_["10021"]
			local var_268_1 = 0

			if var_268_1 < arg_265_1.time_ and arg_265_1.time_ <= var_268_1 + arg_268_0 and not isNil(var_268_0) and arg_265_1.var_.actorSpriteComps10021 == nil then
				arg_265_1.var_.actorSpriteComps10021 = var_268_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_268_2 = 0.034

			if var_268_1 <= arg_265_1.time_ and arg_265_1.time_ < var_268_1 + var_268_2 and not isNil(var_268_0) then
				local var_268_3 = (arg_265_1.time_ - var_268_1) / var_268_2

				if arg_265_1.var_.actorSpriteComps10021 then
					for iter_268_0, iter_268_1 in pairs(arg_265_1.var_.actorSpriteComps10021:ToTable()) do
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

			if arg_265_1.time_ >= var_268_1 + var_268_2 and arg_265_1.time_ < var_268_1 + var_268_2 + arg_268_0 and not isNil(var_268_0) and arg_265_1.var_.actorSpriteComps10021 then
				for iter_268_2, iter_268_3 in pairs(arg_265_1.var_.actorSpriteComps10021:ToTable()) do
					if iter_268_3 then
						if arg_265_1.isInRecall_ then
							iter_268_3.color = arg_265_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_268_3.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_265_1.var_.actorSpriteComps10021 = nil
			end

			local var_268_8 = arg_265_1.actors_["10018"]
			local var_268_9 = 0

			if var_268_9 < arg_265_1.time_ and arg_265_1.time_ <= var_268_9 + arg_268_0 and not isNil(var_268_8) and arg_265_1.var_.actorSpriteComps10018 == nil then
				arg_265_1.var_.actorSpriteComps10018 = var_268_8:GetComponentsInChildren(typeof(Image), true)
			end

			local var_268_10 = 0.034

			if var_268_9 <= arg_265_1.time_ and arg_265_1.time_ < var_268_9 + var_268_10 and not isNil(var_268_8) then
				local var_268_11 = (arg_265_1.time_ - var_268_9) / var_268_10

				if arg_265_1.var_.actorSpriteComps10018 then
					for iter_268_4, iter_268_5 in pairs(arg_265_1.var_.actorSpriteComps10018:ToTable()) do
						if iter_268_5 then
							if arg_265_1.isInRecall_ then
								local var_268_12 = Mathf.Lerp(iter_268_5.color.r, arg_265_1.hightColor2.r, var_268_11)
								local var_268_13 = Mathf.Lerp(iter_268_5.color.g, arg_265_1.hightColor2.g, var_268_11)
								local var_268_14 = Mathf.Lerp(iter_268_5.color.b, arg_265_1.hightColor2.b, var_268_11)

								iter_268_5.color = Color.New(var_268_12, var_268_13, var_268_14)
							else
								local var_268_15 = Mathf.Lerp(iter_268_5.color.r, 0.5, var_268_11)

								iter_268_5.color = Color.New(var_268_15, var_268_15, var_268_15)
							end
						end
					end
				end
			end

			if arg_265_1.time_ >= var_268_9 + var_268_10 and arg_265_1.time_ < var_268_9 + var_268_10 + arg_268_0 and not isNil(var_268_8) and arg_265_1.var_.actorSpriteComps10018 then
				for iter_268_6, iter_268_7 in pairs(arg_265_1.var_.actorSpriteComps10018:ToTable()) do
					if iter_268_7 then
						if arg_265_1.isInRecall_ then
							iter_268_7.color = arg_265_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_268_7.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_265_1.var_.actorSpriteComps10018 = nil
			end

			local var_268_16 = 0
			local var_268_17 = 0.15

			if var_268_16 < arg_265_1.time_ and arg_265_1.time_ <= var_268_16 + arg_268_0 then
				arg_265_1.talkMaxDuration = 0
				arg_265_1.dialogCg_.alpha = 1

				arg_265_1.dialog_:SetActive(true)
				SetActive(arg_265_1.leftNameGo_, true)

				local var_268_18 = arg_265_1:FormatText(StoryNameCfg[226].name)

				arg_265_1.leftNameTxt_.text = var_268_18

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_265_1.leftNameTxt_.transform)

				arg_265_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_265_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_265_1:RecordName(arg_265_1.leftNameTxt_.text)
				SetActive(arg_265_1.iconTrs_.gameObject, false)
				arg_265_1.callingController_:SetSelectedState("normal")

				local var_268_19 = arg_265_1:GetWordFromCfg(114251065)
				local var_268_20 = arg_265_1:FormatText(var_268_19.content)

				arg_265_1.text_.text = var_268_20

				LuaForUtil.ClearLinePrefixSymbol(arg_265_1.text_)

				local var_268_21 = 6
				local var_268_22 = utf8.len(var_268_20)
				local var_268_23 = var_268_21 <= 0 and var_268_17 or var_268_17 * (var_268_22 / var_268_21)

				if var_268_23 > 0 and var_268_17 < var_268_23 then
					arg_265_1.talkMaxDuration = var_268_23

					if var_268_23 + var_268_16 > arg_265_1.duration_ then
						arg_265_1.duration_ = var_268_23 + var_268_16
					end
				end

				arg_265_1.text_.text = var_268_20
				arg_265_1.typewritter.percent = 0

				arg_265_1.typewritter:SetDirty()
				arg_265_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_114251", "114251065", "story_v_out_114251.awb") ~= 0 then
					local var_268_24 = manager.audio:GetVoiceLength("story_v_out_114251", "114251065", "story_v_out_114251.awb") / 1000

					if var_268_24 + var_268_16 > arg_265_1.duration_ then
						arg_265_1.duration_ = var_268_24 + var_268_16
					end

					if var_268_19.prefab_name ~= "" and arg_265_1.actors_[var_268_19.prefab_name] ~= nil then
						local var_268_25 = LuaForUtil.PlayVoiceWithCriLipsync(arg_265_1.actors_[var_268_19.prefab_name].transform, "story_v_out_114251", "114251065", "story_v_out_114251.awb")

						arg_265_1:RecordAudio("114251065", var_268_25)
						arg_265_1:RecordAudio("114251065", var_268_25)
					else
						arg_265_1:AudioAction("play", "voice", "story_v_out_114251", "114251065", "story_v_out_114251.awb")
					end

					arg_265_1:RecordHistoryTalkVoice("story_v_out_114251", "114251065", "story_v_out_114251.awb")
				end

				arg_265_1:RecordContent(arg_265_1.text_.text)
			end

			local var_268_26 = math.max(var_268_17, arg_265_1.talkMaxDuration)

			if var_268_16 <= arg_265_1.time_ and arg_265_1.time_ < var_268_16 + var_268_26 then
				arg_265_1.typewritter.percent = (arg_265_1.time_ - var_268_16) / var_268_26

				arg_265_1.typewritter:SetDirty()
			end

			if arg_265_1.time_ >= var_268_16 + var_268_26 and arg_265_1.time_ < var_268_16 + var_268_26 + arg_268_0 then
				arg_265_1.typewritter.percent = 1

				arg_265_1.typewritter:SetDirty()
				arg_265_1:ShowNextGo(true)
			end
		end

		arg_265_1.nodeConfigList_ = {}

		arg_265_1:InitPlayNodeList()
	end,
	Play114251066 = function(arg_269_0, arg_269_1)
		arg_269_1.time_ = 0
		arg_269_1.frameCnt_ = 0
		arg_269_1.state_ = "playing"
		arg_269_1.curTalkId_ = 114251066
		arg_269_1.duration_ = 5

		SetActive(arg_269_1.tipsGo_, false)

		function arg_269_1.onSingleLineFinish_()
			arg_269_1.onSingleLineUpdate_ = nil
			arg_269_1.onSingleLineFinish_ = nil
			arg_269_1.state_ = "waiting"
		end

		function arg_269_1.playNext_(arg_271_0)
			if arg_271_0 == 1 then
				arg_269_0:Play114251067(arg_269_1)
			end
		end

		function arg_269_1.onSingleLineUpdate_(arg_272_0)
			local var_272_0 = arg_269_1.actors_["10021"]
			local var_272_1 = 0

			if var_272_1 < arg_269_1.time_ and arg_269_1.time_ <= var_272_1 + arg_272_0 and not isNil(var_272_0) and arg_269_1.var_.actorSpriteComps10021 == nil then
				arg_269_1.var_.actorSpriteComps10021 = var_272_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_272_2 = 0.034

			if var_272_1 <= arg_269_1.time_ and arg_269_1.time_ < var_272_1 + var_272_2 and not isNil(var_272_0) then
				local var_272_3 = (arg_269_1.time_ - var_272_1) / var_272_2

				if arg_269_1.var_.actorSpriteComps10021 then
					for iter_272_0, iter_272_1 in pairs(arg_269_1.var_.actorSpriteComps10021:ToTable()) do
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

			if arg_269_1.time_ >= var_272_1 + var_272_2 and arg_269_1.time_ < var_272_1 + var_272_2 + arg_272_0 and not isNil(var_272_0) and arg_269_1.var_.actorSpriteComps10021 then
				for iter_272_2, iter_272_3 in pairs(arg_269_1.var_.actorSpriteComps10021:ToTable()) do
					if iter_272_3 then
						if arg_269_1.isInRecall_ then
							iter_272_3.color = arg_269_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_272_3.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_269_1.var_.actorSpriteComps10021 = nil
			end

			local var_272_8 = 0
			local var_272_9 = 0.875

			if var_272_8 < arg_269_1.time_ and arg_269_1.time_ <= var_272_8 + arg_272_0 then
				arg_269_1.talkMaxDuration = 0
				arg_269_1.dialogCg_.alpha = 1

				arg_269_1.dialog_:SetActive(true)
				SetActive(arg_269_1.leftNameGo_, false)

				arg_269_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_269_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_269_1:RecordName(arg_269_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_269_1.iconTrs_.gameObject, false)
				arg_269_1.callingController_:SetSelectedState("normal")

				local var_272_10 = arg_269_1:GetWordFromCfg(114251066)
				local var_272_11 = arg_269_1:FormatText(var_272_10.content)

				arg_269_1.text_.text = var_272_11

				LuaForUtil.ClearLinePrefixSymbol(arg_269_1.text_)

				local var_272_12 = 35
				local var_272_13 = utf8.len(var_272_11)
				local var_272_14 = var_272_12 <= 0 and var_272_9 or var_272_9 * (var_272_13 / var_272_12)

				if var_272_14 > 0 and var_272_9 < var_272_14 then
					arg_269_1.talkMaxDuration = var_272_14

					if var_272_14 + var_272_8 > arg_269_1.duration_ then
						arg_269_1.duration_ = var_272_14 + var_272_8
					end
				end

				arg_269_1.text_.text = var_272_11
				arg_269_1.typewritter.percent = 0

				arg_269_1.typewritter:SetDirty()
				arg_269_1:ShowNextGo(false)
				arg_269_1:RecordContent(arg_269_1.text_.text)
			end

			local var_272_15 = math.max(var_272_9, arg_269_1.talkMaxDuration)

			if var_272_8 <= arg_269_1.time_ and arg_269_1.time_ < var_272_8 + var_272_15 then
				arg_269_1.typewritter.percent = (arg_269_1.time_ - var_272_8) / var_272_15

				arg_269_1.typewritter:SetDirty()
			end

			if arg_269_1.time_ >= var_272_8 + var_272_15 and arg_269_1.time_ < var_272_8 + var_272_15 + arg_272_0 then
				arg_269_1.typewritter.percent = 1

				arg_269_1.typewritter:SetDirty()
				arg_269_1:ShowNextGo(true)
			end
		end

		arg_269_1.nodeConfigList_ = {}

		arg_269_1:InitPlayNodeList()
	end,
	Play114251067 = function(arg_273_0, arg_273_1)
		arg_273_1.time_ = 0
		arg_273_1.frameCnt_ = 0
		arg_273_1.state_ = "playing"
		arg_273_1.curTalkId_ = 114251067
		arg_273_1.duration_ = 2.03

		local var_273_0 = {
			ja = 1.5,
			ko = 1.566,
			zh = 1.433,
			en = 2.033
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
				arg_273_0:Play114251068(arg_273_1)
			end
		end

		function arg_273_1.onSingleLineUpdate_(arg_276_0)
			local var_276_0 = arg_273_1.actors_["10018"].transform
			local var_276_1 = 0

			if var_276_1 < arg_273_1.time_ and arg_273_1.time_ <= var_276_1 + arg_276_0 then
				arg_273_1.var_.moveOldPos10018 = var_276_0.localPosition
				var_276_0.localScale = Vector3.New(1, 1, 1)

				arg_273_1:CheckSpriteTmpPos("10018", 4)

				local var_276_2 = var_276_0.childCount

				for iter_276_0 = 0, var_276_2 - 1 do
					local var_276_3 = var_276_0:GetChild(iter_276_0)

					if var_276_3.name == "split_1" or not string.find(var_276_3.name, "split") then
						var_276_3.gameObject:SetActive(true)
					else
						var_276_3.gameObject:SetActive(false)
					end
				end
			end

			local var_276_4 = 0.001

			if var_276_1 <= arg_273_1.time_ and arg_273_1.time_ < var_276_1 + var_276_4 then
				local var_276_5 = (arg_273_1.time_ - var_276_1) / var_276_4
				local var_276_6 = Vector3.New(390, -350, -180)

				var_276_0.localPosition = Vector3.Lerp(arg_273_1.var_.moveOldPos10018, var_276_6, var_276_5)
			end

			if arg_273_1.time_ >= var_276_1 + var_276_4 and arg_273_1.time_ < var_276_1 + var_276_4 + arg_276_0 then
				var_276_0.localPosition = Vector3.New(390, -350, -180)
			end

			local var_276_7 = arg_273_1.actors_["10018"]
			local var_276_8 = 0

			if var_276_8 < arg_273_1.time_ and arg_273_1.time_ <= var_276_8 + arg_276_0 and not isNil(var_276_7) and arg_273_1.var_.actorSpriteComps10018 == nil then
				arg_273_1.var_.actorSpriteComps10018 = var_276_7:GetComponentsInChildren(typeof(Image), true)
			end

			local var_276_9 = 0.034

			if var_276_8 <= arg_273_1.time_ and arg_273_1.time_ < var_276_8 + var_276_9 and not isNil(var_276_7) then
				local var_276_10 = (arg_273_1.time_ - var_276_8) / var_276_9

				if arg_273_1.var_.actorSpriteComps10018 then
					for iter_276_1, iter_276_2 in pairs(arg_273_1.var_.actorSpriteComps10018:ToTable()) do
						if iter_276_2 then
							if arg_273_1.isInRecall_ then
								local var_276_11 = Mathf.Lerp(iter_276_2.color.r, arg_273_1.hightColor1.r, var_276_10)
								local var_276_12 = Mathf.Lerp(iter_276_2.color.g, arg_273_1.hightColor1.g, var_276_10)
								local var_276_13 = Mathf.Lerp(iter_276_2.color.b, arg_273_1.hightColor1.b, var_276_10)

								iter_276_2.color = Color.New(var_276_11, var_276_12, var_276_13)
							else
								local var_276_14 = Mathf.Lerp(iter_276_2.color.r, 1, var_276_10)

								iter_276_2.color = Color.New(var_276_14, var_276_14, var_276_14)
							end
						end
					end
				end
			end

			if arg_273_1.time_ >= var_276_8 + var_276_9 and arg_273_1.time_ < var_276_8 + var_276_9 + arg_276_0 and not isNil(var_276_7) and arg_273_1.var_.actorSpriteComps10018 then
				for iter_276_3, iter_276_4 in pairs(arg_273_1.var_.actorSpriteComps10018:ToTable()) do
					if iter_276_4 then
						if arg_273_1.isInRecall_ then
							iter_276_4.color = arg_273_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_276_4.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_273_1.var_.actorSpriteComps10018 = nil
			end

			local var_276_15 = 0
			local var_276_16 = 0.1

			if var_276_15 < arg_273_1.time_ and arg_273_1.time_ <= var_276_15 + arg_276_0 then
				arg_273_1.talkMaxDuration = 0
				arg_273_1.dialogCg_.alpha = 1

				arg_273_1.dialog_:SetActive(true)
				SetActive(arg_273_1.leftNameGo_, true)

				local var_276_17 = arg_273_1:FormatText(StoryNameCfg[258].name)

				arg_273_1.leftNameTxt_.text = var_276_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_273_1.leftNameTxt_.transform)

				arg_273_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_273_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_273_1:RecordName(arg_273_1.leftNameTxt_.text)
				SetActive(arg_273_1.iconTrs_.gameObject, false)
				arg_273_1.callingController_:SetSelectedState("normal")

				local var_276_18 = arg_273_1:GetWordFromCfg(114251067)
				local var_276_19 = arg_273_1:FormatText(var_276_18.content)

				arg_273_1.text_.text = var_276_19

				LuaForUtil.ClearLinePrefixSymbol(arg_273_1.text_)

				local var_276_20 = 4
				local var_276_21 = utf8.len(var_276_19)
				local var_276_22 = var_276_20 <= 0 and var_276_16 or var_276_16 * (var_276_21 / var_276_20)

				if var_276_22 > 0 and var_276_16 < var_276_22 then
					arg_273_1.talkMaxDuration = var_276_22

					if var_276_22 + var_276_15 > arg_273_1.duration_ then
						arg_273_1.duration_ = var_276_22 + var_276_15
					end
				end

				arg_273_1.text_.text = var_276_19
				arg_273_1.typewritter.percent = 0

				arg_273_1.typewritter:SetDirty()
				arg_273_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_114251", "114251067", "story_v_out_114251.awb") ~= 0 then
					local var_276_23 = manager.audio:GetVoiceLength("story_v_out_114251", "114251067", "story_v_out_114251.awb") / 1000

					if var_276_23 + var_276_15 > arg_273_1.duration_ then
						arg_273_1.duration_ = var_276_23 + var_276_15
					end

					if var_276_18.prefab_name ~= "" and arg_273_1.actors_[var_276_18.prefab_name] ~= nil then
						local var_276_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_273_1.actors_[var_276_18.prefab_name].transform, "story_v_out_114251", "114251067", "story_v_out_114251.awb")

						arg_273_1:RecordAudio("114251067", var_276_24)
						arg_273_1:RecordAudio("114251067", var_276_24)
					else
						arg_273_1:AudioAction("play", "voice", "story_v_out_114251", "114251067", "story_v_out_114251.awb")
					end

					arg_273_1:RecordHistoryTalkVoice("story_v_out_114251", "114251067", "story_v_out_114251.awb")
				end

				arg_273_1:RecordContent(arg_273_1.text_.text)
			end

			local var_276_25 = math.max(var_276_16, arg_273_1.talkMaxDuration)

			if var_276_15 <= arg_273_1.time_ and arg_273_1.time_ < var_276_15 + var_276_25 then
				arg_273_1.typewritter.percent = (arg_273_1.time_ - var_276_15) / var_276_25

				arg_273_1.typewritter:SetDirty()
			end

			if arg_273_1.time_ >= var_276_15 + var_276_25 and arg_273_1.time_ < var_276_15 + var_276_25 + arg_276_0 then
				arg_273_1.typewritter.percent = 1

				arg_273_1.typewritter:SetDirty()
				arg_273_1:ShowNextGo(true)
			end
		end

		arg_273_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10018",
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
	Play114251068 = function(arg_277_0, arg_277_1)
		arg_277_1.time_ = 0
		arg_277_1.frameCnt_ = 0
		arg_277_1.state_ = "playing"
		arg_277_1.curTalkId_ = 114251068
		arg_277_1.duration_ = 5.07

		local var_277_0 = {
			ja = 3.433,
			ko = 4.1,
			zh = 4.766,
			en = 5.066
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
				arg_277_0:Play114251069(arg_277_1)
			end
		end

		function arg_277_1.onSingleLineUpdate_(arg_280_0)
			local var_280_0 = arg_277_1.actors_["10018"]
			local var_280_1 = 0

			if var_280_1 < arg_277_1.time_ and arg_277_1.time_ <= var_280_1 + arg_280_0 and not isNil(var_280_0) and arg_277_1.var_.actorSpriteComps10018 == nil then
				arg_277_1.var_.actorSpriteComps10018 = var_280_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_280_2 = 0.034

			if var_280_1 <= arg_277_1.time_ and arg_277_1.time_ < var_280_1 + var_280_2 and not isNil(var_280_0) then
				local var_280_3 = (arg_277_1.time_ - var_280_1) / var_280_2

				if arg_277_1.var_.actorSpriteComps10018 then
					for iter_280_0, iter_280_1 in pairs(arg_277_1.var_.actorSpriteComps10018:ToTable()) do
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

			if arg_277_1.time_ >= var_280_1 + var_280_2 and arg_277_1.time_ < var_280_1 + var_280_2 + arg_280_0 and not isNil(var_280_0) and arg_277_1.var_.actorSpriteComps10018 then
				for iter_280_2, iter_280_3 in pairs(arg_277_1.var_.actorSpriteComps10018:ToTable()) do
					if iter_280_3 then
						if arg_277_1.isInRecall_ then
							iter_280_3.color = arg_277_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_280_3.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_277_1.var_.actorSpriteComps10018 = nil
			end

			local var_280_8 = 0
			local var_280_9 = 0.525

			if var_280_8 < arg_277_1.time_ and arg_277_1.time_ <= var_280_8 + arg_280_0 then
				arg_277_1.talkMaxDuration = 0
				arg_277_1.dialogCg_.alpha = 1

				arg_277_1.dialog_:SetActive(true)
				SetActive(arg_277_1.leftNameGo_, true)

				local var_280_10 = arg_277_1:FormatText(StoryNameCfg[258].name)

				arg_277_1.leftNameTxt_.text = var_280_10

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_277_1.leftNameTxt_.transform)

				arg_277_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_277_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_277_1:RecordName(arg_277_1.leftNameTxt_.text)
				SetActive(arg_277_1.iconTrs_.gameObject, false)
				arg_277_1.callingController_:SetSelectedState("normal")

				local var_280_11 = arg_277_1:GetWordFromCfg(114251068)
				local var_280_12 = arg_277_1:FormatText(var_280_11.content)

				arg_277_1.text_.text = var_280_12

				LuaForUtil.ClearLinePrefixSymbol(arg_277_1.text_)

				local var_280_13 = 21
				local var_280_14 = utf8.len(var_280_12)
				local var_280_15 = var_280_13 <= 0 and var_280_9 or var_280_9 * (var_280_14 / var_280_13)

				if var_280_15 > 0 and var_280_9 < var_280_15 then
					arg_277_1.talkMaxDuration = var_280_15

					if var_280_15 + var_280_8 > arg_277_1.duration_ then
						arg_277_1.duration_ = var_280_15 + var_280_8
					end
				end

				arg_277_1.text_.text = var_280_12
				arg_277_1.typewritter.percent = 0

				arg_277_1.typewritter:SetDirty()
				arg_277_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_114251", "114251068", "story_v_out_114251.awb") ~= 0 then
					local var_280_16 = manager.audio:GetVoiceLength("story_v_out_114251", "114251068", "story_v_out_114251.awb") / 1000

					if var_280_16 + var_280_8 > arg_277_1.duration_ then
						arg_277_1.duration_ = var_280_16 + var_280_8
					end

					if var_280_11.prefab_name ~= "" and arg_277_1.actors_[var_280_11.prefab_name] ~= nil then
						local var_280_17 = LuaForUtil.PlayVoiceWithCriLipsync(arg_277_1.actors_[var_280_11.prefab_name].transform, "story_v_out_114251", "114251068", "story_v_out_114251.awb")

						arg_277_1:RecordAudio("114251068", var_280_17)
						arg_277_1:RecordAudio("114251068", var_280_17)
					else
						arg_277_1:AudioAction("play", "voice", "story_v_out_114251", "114251068", "story_v_out_114251.awb")
					end

					arg_277_1:RecordHistoryTalkVoice("story_v_out_114251", "114251068", "story_v_out_114251.awb")
				end

				arg_277_1:RecordContent(arg_277_1.text_.text)
			end

			local var_280_18 = math.max(var_280_9, arg_277_1.talkMaxDuration)

			if var_280_8 <= arg_277_1.time_ and arg_277_1.time_ < var_280_8 + var_280_18 then
				arg_277_1.typewritter.percent = (arg_277_1.time_ - var_280_8) / var_280_18

				arg_277_1.typewritter:SetDirty()
			end

			if arg_277_1.time_ >= var_280_8 + var_280_18 and arg_277_1.time_ < var_280_8 + var_280_18 + arg_280_0 then
				arg_277_1.typewritter.percent = 1

				arg_277_1.typewritter:SetDirty()
				arg_277_1:ShowNextGo(true)
			end
		end

		arg_277_1.nodeConfigList_ = {}

		arg_277_1:InitPlayNodeList()
	end,
	Play114251069 = function(arg_281_0, arg_281_1)
		arg_281_1.time_ = 0
		arg_281_1.frameCnt_ = 0
		arg_281_1.state_ = "playing"
		arg_281_1.curTalkId_ = 114251069
		arg_281_1.duration_ = 4.83

		local var_281_0 = {
			ja = 3.333,
			ko = 4.133,
			zh = 4.833,
			en = 3.3
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
				arg_281_0:Play114251070(arg_281_1)
			end
		end

		function arg_281_1.onSingleLineUpdate_(arg_284_0)
			local var_284_0 = arg_281_1.actors_["10021"]
			local var_284_1 = 0

			if var_284_1 < arg_281_1.time_ and arg_281_1.time_ <= var_284_1 + arg_284_0 and not isNil(var_284_0) and arg_281_1.var_.actorSpriteComps10021 == nil then
				arg_281_1.var_.actorSpriteComps10021 = var_284_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_284_2 = 0.034

			if var_284_1 <= arg_281_1.time_ and arg_281_1.time_ < var_284_1 + var_284_2 and not isNil(var_284_0) then
				local var_284_3 = (arg_281_1.time_ - var_284_1) / var_284_2

				if arg_281_1.var_.actorSpriteComps10021 then
					for iter_284_0, iter_284_1 in pairs(arg_281_1.var_.actorSpriteComps10021:ToTable()) do
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

			if arg_281_1.time_ >= var_284_1 + var_284_2 and arg_281_1.time_ < var_284_1 + var_284_2 + arg_284_0 and not isNil(var_284_0) and arg_281_1.var_.actorSpriteComps10021 then
				for iter_284_2, iter_284_3 in pairs(arg_281_1.var_.actorSpriteComps10021:ToTable()) do
					if iter_284_3 then
						if arg_281_1.isInRecall_ then
							iter_284_3.color = arg_281_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_284_3.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_281_1.var_.actorSpriteComps10021 = nil
			end

			local var_284_8 = arg_281_1.actors_["10018"]
			local var_284_9 = 0

			if var_284_9 < arg_281_1.time_ and arg_281_1.time_ <= var_284_9 + arg_284_0 and not isNil(var_284_8) and arg_281_1.var_.actorSpriteComps10018 == nil then
				arg_281_1.var_.actorSpriteComps10018 = var_284_8:GetComponentsInChildren(typeof(Image), true)
			end

			local var_284_10 = 0.034

			if var_284_9 <= arg_281_1.time_ and arg_281_1.time_ < var_284_9 + var_284_10 and not isNil(var_284_8) then
				local var_284_11 = (arg_281_1.time_ - var_284_9) / var_284_10

				if arg_281_1.var_.actorSpriteComps10018 then
					for iter_284_4, iter_284_5 in pairs(arg_281_1.var_.actorSpriteComps10018:ToTable()) do
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

			if arg_281_1.time_ >= var_284_9 + var_284_10 and arg_281_1.time_ < var_284_9 + var_284_10 + arg_284_0 and not isNil(var_284_8) and arg_281_1.var_.actorSpriteComps10018 then
				for iter_284_6, iter_284_7 in pairs(arg_281_1.var_.actorSpriteComps10018:ToTable()) do
					if iter_284_7 then
						if arg_281_1.isInRecall_ then
							iter_284_7.color = arg_281_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_284_7.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_281_1.var_.actorSpriteComps10018 = nil
			end

			local var_284_16 = 0
			local var_284_17 = 0.375

			if var_284_16 < arg_281_1.time_ and arg_281_1.time_ <= var_284_16 + arg_284_0 then
				arg_281_1.talkMaxDuration = 0
				arg_281_1.dialogCg_.alpha = 1

				arg_281_1.dialog_:SetActive(true)
				SetActive(arg_281_1.leftNameGo_, true)

				local var_284_18 = arg_281_1:FormatText(StoryNameCfg[226].name)

				arg_281_1.leftNameTxt_.text = var_284_18

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_281_1.leftNameTxt_.transform)

				arg_281_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_281_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_281_1:RecordName(arg_281_1.leftNameTxt_.text)
				SetActive(arg_281_1.iconTrs_.gameObject, false)
				arg_281_1.callingController_:SetSelectedState("normal")

				local var_284_19 = arg_281_1:GetWordFromCfg(114251069)
				local var_284_20 = arg_281_1:FormatText(var_284_19.content)

				arg_281_1.text_.text = var_284_20

				LuaForUtil.ClearLinePrefixSymbol(arg_281_1.text_)

				local var_284_21 = 15
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

				if manager.audio:GetVoiceLength("story_v_out_114251", "114251069", "story_v_out_114251.awb") ~= 0 then
					local var_284_24 = manager.audio:GetVoiceLength("story_v_out_114251", "114251069", "story_v_out_114251.awb") / 1000

					if var_284_24 + var_284_16 > arg_281_1.duration_ then
						arg_281_1.duration_ = var_284_24 + var_284_16
					end

					if var_284_19.prefab_name ~= "" and arg_281_1.actors_[var_284_19.prefab_name] ~= nil then
						local var_284_25 = LuaForUtil.PlayVoiceWithCriLipsync(arg_281_1.actors_[var_284_19.prefab_name].transform, "story_v_out_114251", "114251069", "story_v_out_114251.awb")

						arg_281_1:RecordAudio("114251069", var_284_25)
						arg_281_1:RecordAudio("114251069", var_284_25)
					else
						arg_281_1:AudioAction("play", "voice", "story_v_out_114251", "114251069", "story_v_out_114251.awb")
					end

					arg_281_1:RecordHistoryTalkVoice("story_v_out_114251", "114251069", "story_v_out_114251.awb")
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
	Play114251070 = function(arg_285_0, arg_285_1)
		arg_285_1.time_ = 0
		arg_285_1.frameCnt_ = 0
		arg_285_1.state_ = "playing"
		arg_285_1.curTalkId_ = 114251070
		arg_285_1.duration_ = 4.47

		local var_285_0 = {
			ja = 3.566,
			ko = 3.766,
			zh = 4.466,
			en = 4.166
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
				arg_285_0:Play114251071(arg_285_1)
			end
		end

		function arg_285_1.onSingleLineUpdate_(arg_288_0)
			local var_288_0 = arg_285_1.actors_["10021"]
			local var_288_1 = 0

			if var_288_1 < arg_285_1.time_ and arg_285_1.time_ <= var_288_1 + arg_288_0 and not isNil(var_288_0) and arg_285_1.var_.actorSpriteComps10021 == nil then
				arg_285_1.var_.actorSpriteComps10021 = var_288_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_288_2 = 0.034

			if var_288_1 <= arg_285_1.time_ and arg_285_1.time_ < var_288_1 + var_288_2 and not isNil(var_288_0) then
				local var_288_3 = (arg_285_1.time_ - var_288_1) / var_288_2

				if arg_285_1.var_.actorSpriteComps10021 then
					for iter_288_0, iter_288_1 in pairs(arg_285_1.var_.actorSpriteComps10021:ToTable()) do
						if iter_288_1 then
							if arg_285_1.isInRecall_ then
								local var_288_4 = Mathf.Lerp(iter_288_1.color.r, arg_285_1.hightColor2.r, var_288_3)
								local var_288_5 = Mathf.Lerp(iter_288_1.color.g, arg_285_1.hightColor2.g, var_288_3)
								local var_288_6 = Mathf.Lerp(iter_288_1.color.b, arg_285_1.hightColor2.b, var_288_3)

								iter_288_1.color = Color.New(var_288_4, var_288_5, var_288_6)
							else
								local var_288_7 = Mathf.Lerp(iter_288_1.color.r, 0.5, var_288_3)

								iter_288_1.color = Color.New(var_288_7, var_288_7, var_288_7)
							end
						end
					end
				end
			end

			if arg_285_1.time_ >= var_288_1 + var_288_2 and arg_285_1.time_ < var_288_1 + var_288_2 + arg_288_0 and not isNil(var_288_0) and arg_285_1.var_.actorSpriteComps10021 then
				for iter_288_2, iter_288_3 in pairs(arg_285_1.var_.actorSpriteComps10021:ToTable()) do
					if iter_288_3 then
						if arg_285_1.isInRecall_ then
							iter_288_3.color = arg_285_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_288_3.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_285_1.var_.actorSpriteComps10021 = nil
			end

			local var_288_8 = arg_285_1.actors_["10018"]
			local var_288_9 = 0

			if var_288_9 < arg_285_1.time_ and arg_285_1.time_ <= var_288_9 + arg_288_0 and not isNil(var_288_8) and arg_285_1.var_.actorSpriteComps10018 == nil then
				arg_285_1.var_.actorSpriteComps10018 = var_288_8:GetComponentsInChildren(typeof(Image), true)
			end

			local var_288_10 = 0.034

			if var_288_9 <= arg_285_1.time_ and arg_285_1.time_ < var_288_9 + var_288_10 and not isNil(var_288_8) then
				local var_288_11 = (arg_285_1.time_ - var_288_9) / var_288_10

				if arg_285_1.var_.actorSpriteComps10018 then
					for iter_288_4, iter_288_5 in pairs(arg_285_1.var_.actorSpriteComps10018:ToTable()) do
						if iter_288_5 then
							if arg_285_1.isInRecall_ then
								local var_288_12 = Mathf.Lerp(iter_288_5.color.r, arg_285_1.hightColor1.r, var_288_11)
								local var_288_13 = Mathf.Lerp(iter_288_5.color.g, arg_285_1.hightColor1.g, var_288_11)
								local var_288_14 = Mathf.Lerp(iter_288_5.color.b, arg_285_1.hightColor1.b, var_288_11)

								iter_288_5.color = Color.New(var_288_12, var_288_13, var_288_14)
							else
								local var_288_15 = Mathf.Lerp(iter_288_5.color.r, 1, var_288_11)

								iter_288_5.color = Color.New(var_288_15, var_288_15, var_288_15)
							end
						end
					end
				end
			end

			if arg_285_1.time_ >= var_288_9 + var_288_10 and arg_285_1.time_ < var_288_9 + var_288_10 + arg_288_0 and not isNil(var_288_8) and arg_285_1.var_.actorSpriteComps10018 then
				for iter_288_6, iter_288_7 in pairs(arg_285_1.var_.actorSpriteComps10018:ToTable()) do
					if iter_288_7 then
						if arg_285_1.isInRecall_ then
							iter_288_7.color = arg_285_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_288_7.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_285_1.var_.actorSpriteComps10018 = nil
			end

			local var_288_16 = 0
			local var_288_17 = 0.4

			if var_288_16 < arg_285_1.time_ and arg_285_1.time_ <= var_288_16 + arg_288_0 then
				arg_285_1.talkMaxDuration = 0
				arg_285_1.dialogCg_.alpha = 1

				arg_285_1.dialog_:SetActive(true)
				SetActive(arg_285_1.leftNameGo_, true)

				local var_288_18 = arg_285_1:FormatText(StoryNameCfg[258].name)

				arg_285_1.leftNameTxt_.text = var_288_18

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_285_1.leftNameTxt_.transform)

				arg_285_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_285_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_285_1:RecordName(arg_285_1.leftNameTxt_.text)
				SetActive(arg_285_1.iconTrs_.gameObject, false)
				arg_285_1.callingController_:SetSelectedState("normal")

				local var_288_19 = arg_285_1:GetWordFromCfg(114251070)
				local var_288_20 = arg_285_1:FormatText(var_288_19.content)

				arg_285_1.text_.text = var_288_20

				LuaForUtil.ClearLinePrefixSymbol(arg_285_1.text_)

				local var_288_21 = 16
				local var_288_22 = utf8.len(var_288_20)
				local var_288_23 = var_288_21 <= 0 and var_288_17 or var_288_17 * (var_288_22 / var_288_21)

				if var_288_23 > 0 and var_288_17 < var_288_23 then
					arg_285_1.talkMaxDuration = var_288_23

					if var_288_23 + var_288_16 > arg_285_1.duration_ then
						arg_285_1.duration_ = var_288_23 + var_288_16
					end
				end

				arg_285_1.text_.text = var_288_20
				arg_285_1.typewritter.percent = 0

				arg_285_1.typewritter:SetDirty()
				arg_285_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_114251", "114251070", "story_v_out_114251.awb") ~= 0 then
					local var_288_24 = manager.audio:GetVoiceLength("story_v_out_114251", "114251070", "story_v_out_114251.awb") / 1000

					if var_288_24 + var_288_16 > arg_285_1.duration_ then
						arg_285_1.duration_ = var_288_24 + var_288_16
					end

					if var_288_19.prefab_name ~= "" and arg_285_1.actors_[var_288_19.prefab_name] ~= nil then
						local var_288_25 = LuaForUtil.PlayVoiceWithCriLipsync(arg_285_1.actors_[var_288_19.prefab_name].transform, "story_v_out_114251", "114251070", "story_v_out_114251.awb")

						arg_285_1:RecordAudio("114251070", var_288_25)
						arg_285_1:RecordAudio("114251070", var_288_25)
					else
						arg_285_1:AudioAction("play", "voice", "story_v_out_114251", "114251070", "story_v_out_114251.awb")
					end

					arg_285_1:RecordHistoryTalkVoice("story_v_out_114251", "114251070", "story_v_out_114251.awb")
				end

				arg_285_1:RecordContent(arg_285_1.text_.text)
			end

			local var_288_26 = math.max(var_288_17, arg_285_1.talkMaxDuration)

			if var_288_16 <= arg_285_1.time_ and arg_285_1.time_ < var_288_16 + var_288_26 then
				arg_285_1.typewritter.percent = (arg_285_1.time_ - var_288_16) / var_288_26

				arg_285_1.typewritter:SetDirty()
			end

			if arg_285_1.time_ >= var_288_16 + var_288_26 and arg_285_1.time_ < var_288_16 + var_288_26 + arg_288_0 then
				arg_285_1.typewritter.percent = 1

				arg_285_1.typewritter:SetDirty()
				arg_285_1:ShowNextGo(true)
			end
		end

		arg_285_1.nodeConfigList_ = {}

		arg_285_1:InitPlayNodeList()
	end,
	Play114251071 = function(arg_289_0, arg_289_1)
		arg_289_1.time_ = 0
		arg_289_1.frameCnt_ = 0
		arg_289_1.state_ = "playing"
		arg_289_1.curTalkId_ = 114251071
		arg_289_1.duration_ = 2.5

		local var_289_0 = {
			ja = 2.5,
			ko = 1.533,
			zh = 1.3,
			en = 0.999999999999
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
				arg_289_0:Play114251072(arg_289_1)
			end
		end

		function arg_289_1.onSingleLineUpdate_(arg_292_0)
			local var_292_0 = arg_289_1.actors_["10021"]
			local var_292_1 = 0

			if var_292_1 < arg_289_1.time_ and arg_289_1.time_ <= var_292_1 + arg_292_0 and not isNil(var_292_0) and arg_289_1.var_.actorSpriteComps10021 == nil then
				arg_289_1.var_.actorSpriteComps10021 = var_292_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_292_2 = 0.034

			if var_292_1 <= arg_289_1.time_ and arg_289_1.time_ < var_292_1 + var_292_2 and not isNil(var_292_0) then
				local var_292_3 = (arg_289_1.time_ - var_292_1) / var_292_2

				if arg_289_1.var_.actorSpriteComps10021 then
					for iter_292_0, iter_292_1 in pairs(arg_289_1.var_.actorSpriteComps10021:ToTable()) do
						if iter_292_1 then
							if arg_289_1.isInRecall_ then
								local var_292_4 = Mathf.Lerp(iter_292_1.color.r, arg_289_1.hightColor1.r, var_292_3)
								local var_292_5 = Mathf.Lerp(iter_292_1.color.g, arg_289_1.hightColor1.g, var_292_3)
								local var_292_6 = Mathf.Lerp(iter_292_1.color.b, arg_289_1.hightColor1.b, var_292_3)

								iter_292_1.color = Color.New(var_292_4, var_292_5, var_292_6)
							else
								local var_292_7 = Mathf.Lerp(iter_292_1.color.r, 1, var_292_3)

								iter_292_1.color = Color.New(var_292_7, var_292_7, var_292_7)
							end
						end
					end
				end
			end

			if arg_289_1.time_ >= var_292_1 + var_292_2 and arg_289_1.time_ < var_292_1 + var_292_2 + arg_292_0 and not isNil(var_292_0) and arg_289_1.var_.actorSpriteComps10021 then
				for iter_292_2, iter_292_3 in pairs(arg_289_1.var_.actorSpriteComps10021:ToTable()) do
					if iter_292_3 then
						if arg_289_1.isInRecall_ then
							iter_292_3.color = arg_289_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_292_3.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_289_1.var_.actorSpriteComps10021 = nil
			end

			local var_292_8 = arg_289_1.actors_["10018"]
			local var_292_9 = 0

			if var_292_9 < arg_289_1.time_ and arg_289_1.time_ <= var_292_9 + arg_292_0 and not isNil(var_292_8) and arg_289_1.var_.actorSpriteComps10018 == nil then
				arg_289_1.var_.actorSpriteComps10018 = var_292_8:GetComponentsInChildren(typeof(Image), true)
			end

			local var_292_10 = 0.034

			if var_292_9 <= arg_289_1.time_ and arg_289_1.time_ < var_292_9 + var_292_10 and not isNil(var_292_8) then
				local var_292_11 = (arg_289_1.time_ - var_292_9) / var_292_10

				if arg_289_1.var_.actorSpriteComps10018 then
					for iter_292_4, iter_292_5 in pairs(arg_289_1.var_.actorSpriteComps10018:ToTable()) do
						if iter_292_5 then
							if arg_289_1.isInRecall_ then
								local var_292_12 = Mathf.Lerp(iter_292_5.color.r, arg_289_1.hightColor2.r, var_292_11)
								local var_292_13 = Mathf.Lerp(iter_292_5.color.g, arg_289_1.hightColor2.g, var_292_11)
								local var_292_14 = Mathf.Lerp(iter_292_5.color.b, arg_289_1.hightColor2.b, var_292_11)

								iter_292_5.color = Color.New(var_292_12, var_292_13, var_292_14)
							else
								local var_292_15 = Mathf.Lerp(iter_292_5.color.r, 0.5, var_292_11)

								iter_292_5.color = Color.New(var_292_15, var_292_15, var_292_15)
							end
						end
					end
				end
			end

			if arg_289_1.time_ >= var_292_9 + var_292_10 and arg_289_1.time_ < var_292_9 + var_292_10 + arg_292_0 and not isNil(var_292_8) and arg_289_1.var_.actorSpriteComps10018 then
				for iter_292_6, iter_292_7 in pairs(arg_289_1.var_.actorSpriteComps10018:ToTable()) do
					if iter_292_7 then
						if arg_289_1.isInRecall_ then
							iter_292_7.color = arg_289_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_292_7.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_289_1.var_.actorSpriteComps10018 = nil
			end

			local var_292_16 = 0
			local var_292_17 = 0.125

			if var_292_16 < arg_289_1.time_ and arg_289_1.time_ <= var_292_16 + arg_292_0 then
				arg_289_1.talkMaxDuration = 0
				arg_289_1.dialogCg_.alpha = 1

				arg_289_1.dialog_:SetActive(true)
				SetActive(arg_289_1.leftNameGo_, true)

				local var_292_18 = arg_289_1:FormatText(StoryNameCfg[226].name)

				arg_289_1.leftNameTxt_.text = var_292_18

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_289_1.leftNameTxt_.transform)

				arg_289_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_289_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_289_1:RecordName(arg_289_1.leftNameTxt_.text)
				SetActive(arg_289_1.iconTrs_.gameObject, false)
				arg_289_1.callingController_:SetSelectedState("normal")

				local var_292_19 = arg_289_1:GetWordFromCfg(114251071)
				local var_292_20 = arg_289_1:FormatText(var_292_19.content)

				arg_289_1.text_.text = var_292_20

				LuaForUtil.ClearLinePrefixSymbol(arg_289_1.text_)

				local var_292_21 = 5
				local var_292_22 = utf8.len(var_292_20)
				local var_292_23 = var_292_21 <= 0 and var_292_17 or var_292_17 * (var_292_22 / var_292_21)

				if var_292_23 > 0 and var_292_17 < var_292_23 then
					arg_289_1.talkMaxDuration = var_292_23

					if var_292_23 + var_292_16 > arg_289_1.duration_ then
						arg_289_1.duration_ = var_292_23 + var_292_16
					end
				end

				arg_289_1.text_.text = var_292_20
				arg_289_1.typewritter.percent = 0

				arg_289_1.typewritter:SetDirty()
				arg_289_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_114251", "114251071", "story_v_out_114251.awb") ~= 0 then
					local var_292_24 = manager.audio:GetVoiceLength("story_v_out_114251", "114251071", "story_v_out_114251.awb") / 1000

					if var_292_24 + var_292_16 > arg_289_1.duration_ then
						arg_289_1.duration_ = var_292_24 + var_292_16
					end

					if var_292_19.prefab_name ~= "" and arg_289_1.actors_[var_292_19.prefab_name] ~= nil then
						local var_292_25 = LuaForUtil.PlayVoiceWithCriLipsync(arg_289_1.actors_[var_292_19.prefab_name].transform, "story_v_out_114251", "114251071", "story_v_out_114251.awb")

						arg_289_1:RecordAudio("114251071", var_292_25)
						arg_289_1:RecordAudio("114251071", var_292_25)
					else
						arg_289_1:AudioAction("play", "voice", "story_v_out_114251", "114251071", "story_v_out_114251.awb")
					end

					arg_289_1:RecordHistoryTalkVoice("story_v_out_114251", "114251071", "story_v_out_114251.awb")
				end

				arg_289_1:RecordContent(arg_289_1.text_.text)
			end

			local var_292_26 = math.max(var_292_17, arg_289_1.talkMaxDuration)

			if var_292_16 <= arg_289_1.time_ and arg_289_1.time_ < var_292_16 + var_292_26 then
				arg_289_1.typewritter.percent = (arg_289_1.time_ - var_292_16) / var_292_26

				arg_289_1.typewritter:SetDirty()
			end

			if arg_289_1.time_ >= var_292_16 + var_292_26 and arg_289_1.time_ < var_292_16 + var_292_26 + arg_292_0 then
				arg_289_1.typewritter.percent = 1

				arg_289_1.typewritter:SetDirty()
				arg_289_1:ShowNextGo(true)
			end
		end

		arg_289_1.nodeConfigList_ = {}

		arg_289_1:InitPlayNodeList()
	end,
	Play114251072 = function(arg_293_0, arg_293_1)
		arg_293_1.time_ = 0
		arg_293_1.frameCnt_ = 0
		arg_293_1.state_ = "playing"
		arg_293_1.curTalkId_ = 114251072
		arg_293_1.duration_ = 5

		SetActive(arg_293_1.tipsGo_, false)

		function arg_293_1.onSingleLineFinish_()
			arg_293_1.onSingleLineUpdate_ = nil
			arg_293_1.onSingleLineFinish_ = nil
			arg_293_1.state_ = "waiting"
		end

		function arg_293_1.playNext_(arg_295_0)
			if arg_295_0 == 1 then
				arg_293_0:Play114251073(arg_293_1)
			end
		end

		function arg_293_1.onSingleLineUpdate_(arg_296_0)
			local var_296_0 = arg_293_1.actors_["10021"]
			local var_296_1 = 0

			if var_296_1 < arg_293_1.time_ and arg_293_1.time_ <= var_296_1 + arg_296_0 and not isNil(var_296_0) and arg_293_1.var_.actorSpriteComps10021 == nil then
				arg_293_1.var_.actorSpriteComps10021 = var_296_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_296_2 = 0.034

			if var_296_1 <= arg_293_1.time_ and arg_293_1.time_ < var_296_1 + var_296_2 and not isNil(var_296_0) then
				local var_296_3 = (arg_293_1.time_ - var_296_1) / var_296_2

				if arg_293_1.var_.actorSpriteComps10021 then
					for iter_296_0, iter_296_1 in pairs(arg_293_1.var_.actorSpriteComps10021:ToTable()) do
						if iter_296_1 then
							if arg_293_1.isInRecall_ then
								local var_296_4 = Mathf.Lerp(iter_296_1.color.r, arg_293_1.hightColor2.r, var_296_3)
								local var_296_5 = Mathf.Lerp(iter_296_1.color.g, arg_293_1.hightColor2.g, var_296_3)
								local var_296_6 = Mathf.Lerp(iter_296_1.color.b, arg_293_1.hightColor2.b, var_296_3)

								iter_296_1.color = Color.New(var_296_4, var_296_5, var_296_6)
							else
								local var_296_7 = Mathf.Lerp(iter_296_1.color.r, 0.5, var_296_3)

								iter_296_1.color = Color.New(var_296_7, var_296_7, var_296_7)
							end
						end
					end
				end
			end

			if arg_293_1.time_ >= var_296_1 + var_296_2 and arg_293_1.time_ < var_296_1 + var_296_2 + arg_296_0 and not isNil(var_296_0) and arg_293_1.var_.actorSpriteComps10021 then
				for iter_296_2, iter_296_3 in pairs(arg_293_1.var_.actorSpriteComps10021:ToTable()) do
					if iter_296_3 then
						if arg_293_1.isInRecall_ then
							iter_296_3.color = arg_293_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_296_3.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_293_1.var_.actorSpriteComps10021 = nil
			end

			local var_296_8 = 0
			local var_296_9 = 0.775

			if var_296_8 < arg_293_1.time_ and arg_293_1.time_ <= var_296_8 + arg_296_0 then
				arg_293_1.talkMaxDuration = 0
				arg_293_1.dialogCg_.alpha = 1

				arg_293_1.dialog_:SetActive(true)
				SetActive(arg_293_1.leftNameGo_, false)

				arg_293_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_293_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_293_1:RecordName(arg_293_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_293_1.iconTrs_.gameObject, false)
				arg_293_1.callingController_:SetSelectedState("normal")

				local var_296_10 = arg_293_1:GetWordFromCfg(114251072)
				local var_296_11 = arg_293_1:FormatText(var_296_10.content)

				arg_293_1.text_.text = var_296_11

				LuaForUtil.ClearLinePrefixSymbol(arg_293_1.text_)

				local var_296_12 = 31
				local var_296_13 = utf8.len(var_296_11)
				local var_296_14 = var_296_12 <= 0 and var_296_9 or var_296_9 * (var_296_13 / var_296_12)

				if var_296_14 > 0 and var_296_9 < var_296_14 then
					arg_293_1.talkMaxDuration = var_296_14

					if var_296_14 + var_296_8 > arg_293_1.duration_ then
						arg_293_1.duration_ = var_296_14 + var_296_8
					end
				end

				arg_293_1.text_.text = var_296_11
				arg_293_1.typewritter.percent = 0

				arg_293_1.typewritter:SetDirty()
				arg_293_1:ShowNextGo(false)
				arg_293_1:RecordContent(arg_293_1.text_.text)
			end

			local var_296_15 = math.max(var_296_9, arg_293_1.talkMaxDuration)

			if var_296_8 <= arg_293_1.time_ and arg_293_1.time_ < var_296_8 + var_296_15 then
				arg_293_1.typewritter.percent = (arg_293_1.time_ - var_296_8) / var_296_15

				arg_293_1.typewritter:SetDirty()
			end

			if arg_293_1.time_ >= var_296_8 + var_296_15 and arg_293_1.time_ < var_296_8 + var_296_15 + arg_296_0 then
				arg_293_1.typewritter.percent = 1

				arg_293_1.typewritter:SetDirty()
				arg_293_1:ShowNextGo(true)
			end
		end

		arg_293_1.nodeConfigList_ = {}

		arg_293_1:InitPlayNodeList()
	end,
	Play114251073 = function(arg_297_0, arg_297_1)
		arg_297_1.time_ = 0
		arg_297_1.frameCnt_ = 0
		arg_297_1.state_ = "playing"
		arg_297_1.curTalkId_ = 114251073
		arg_297_1.duration_ = 16.67

		local var_297_0 = {
			ja = 11.833,
			ko = 12.2,
			zh = 16.1,
			en = 16.666
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
				arg_297_0:Play114251074(arg_297_1)
			end
		end

		function arg_297_1.onSingleLineUpdate_(arg_300_0)
			local var_300_0 = arg_297_1.actors_["10018"]
			local var_300_1 = 0

			if var_300_1 < arg_297_1.time_ and arg_297_1.time_ <= var_300_1 + arg_300_0 and not isNil(var_300_0) and arg_297_1.var_.actorSpriteComps10018 == nil then
				arg_297_1.var_.actorSpriteComps10018 = var_300_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_300_2 = 0.034

			if var_300_1 <= arg_297_1.time_ and arg_297_1.time_ < var_300_1 + var_300_2 and not isNil(var_300_0) then
				local var_300_3 = (arg_297_1.time_ - var_300_1) / var_300_2

				if arg_297_1.var_.actorSpriteComps10018 then
					for iter_300_0, iter_300_1 in pairs(arg_297_1.var_.actorSpriteComps10018:ToTable()) do
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

			if arg_297_1.time_ >= var_300_1 + var_300_2 and arg_297_1.time_ < var_300_1 + var_300_2 + arg_300_0 and not isNil(var_300_0) and arg_297_1.var_.actorSpriteComps10018 then
				for iter_300_2, iter_300_3 in pairs(arg_297_1.var_.actorSpriteComps10018:ToTable()) do
					if iter_300_3 then
						if arg_297_1.isInRecall_ then
							iter_300_3.color = arg_297_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_300_3.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_297_1.var_.actorSpriteComps10018 = nil
			end

			local var_300_8 = 0
			local var_300_9 = 1.65

			if var_300_8 < arg_297_1.time_ and arg_297_1.time_ <= var_300_8 + arg_300_0 then
				arg_297_1.talkMaxDuration = 0
				arg_297_1.dialogCg_.alpha = 1

				arg_297_1.dialog_:SetActive(true)
				SetActive(arg_297_1.leftNameGo_, true)

				local var_300_10 = arg_297_1:FormatText(StoryNameCfg[258].name)

				arg_297_1.leftNameTxt_.text = var_300_10

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_297_1.leftNameTxt_.transform)

				arg_297_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_297_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_297_1:RecordName(arg_297_1.leftNameTxt_.text)
				SetActive(arg_297_1.iconTrs_.gameObject, false)
				arg_297_1.callingController_:SetSelectedState("normal")

				local var_300_11 = arg_297_1:GetWordFromCfg(114251073)
				local var_300_12 = arg_297_1:FormatText(var_300_11.content)

				arg_297_1.text_.text = var_300_12

				LuaForUtil.ClearLinePrefixSymbol(arg_297_1.text_)

				local var_300_13 = 65
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

				if manager.audio:GetVoiceLength("story_v_out_114251", "114251073", "story_v_out_114251.awb") ~= 0 then
					local var_300_16 = manager.audio:GetVoiceLength("story_v_out_114251", "114251073", "story_v_out_114251.awb") / 1000

					if var_300_16 + var_300_8 > arg_297_1.duration_ then
						arg_297_1.duration_ = var_300_16 + var_300_8
					end

					if var_300_11.prefab_name ~= "" and arg_297_1.actors_[var_300_11.prefab_name] ~= nil then
						local var_300_17 = LuaForUtil.PlayVoiceWithCriLipsync(arg_297_1.actors_[var_300_11.prefab_name].transform, "story_v_out_114251", "114251073", "story_v_out_114251.awb")

						arg_297_1:RecordAudio("114251073", var_300_17)
						arg_297_1:RecordAudio("114251073", var_300_17)
					else
						arg_297_1:AudioAction("play", "voice", "story_v_out_114251", "114251073", "story_v_out_114251.awb")
					end

					arg_297_1:RecordHistoryTalkVoice("story_v_out_114251", "114251073", "story_v_out_114251.awb")
				end

				arg_297_1:RecordContent(arg_297_1.text_.text)
			end

			local var_300_18 = math.max(var_300_9, arg_297_1.talkMaxDuration)

			if var_300_8 <= arg_297_1.time_ and arg_297_1.time_ < var_300_8 + var_300_18 then
				arg_297_1.typewritter.percent = (arg_297_1.time_ - var_300_8) / var_300_18

				arg_297_1.typewritter:SetDirty()
			end

			if arg_297_1.time_ >= var_300_8 + var_300_18 and arg_297_1.time_ < var_300_8 + var_300_18 + arg_300_0 then
				arg_297_1.typewritter.percent = 1

				arg_297_1.typewritter:SetDirty()
				arg_297_1:ShowNextGo(true)
			end
		end

		arg_297_1.nodeConfigList_ = {}

		arg_297_1:InitPlayNodeList()
	end,
	Play114251074 = function(arg_301_0, arg_301_1)
		arg_301_1.time_ = 0
		arg_301_1.frameCnt_ = 0
		arg_301_1.state_ = "playing"
		arg_301_1.curTalkId_ = 114251074
		arg_301_1.duration_ = 5.87

		local var_301_0 = {
			ja = 5.866,
			ko = 2.533,
			zh = 2.766,
			en = 2.066
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
				arg_301_0:Play114251075(arg_301_1)
			end
		end

		function arg_301_1.onSingleLineUpdate_(arg_304_0)
			local var_304_0 = arg_301_1.actors_["10021"]
			local var_304_1 = 0

			if var_304_1 < arg_301_1.time_ and arg_301_1.time_ <= var_304_1 + arg_304_0 and not isNil(var_304_0) and arg_301_1.var_.actorSpriteComps10021 == nil then
				arg_301_1.var_.actorSpriteComps10021 = var_304_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_304_2 = 0.034

			if var_304_1 <= arg_301_1.time_ and arg_301_1.time_ < var_304_1 + var_304_2 and not isNil(var_304_0) then
				local var_304_3 = (arg_301_1.time_ - var_304_1) / var_304_2

				if arg_301_1.var_.actorSpriteComps10021 then
					for iter_304_0, iter_304_1 in pairs(arg_301_1.var_.actorSpriteComps10021:ToTable()) do
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

			if arg_301_1.time_ >= var_304_1 + var_304_2 and arg_301_1.time_ < var_304_1 + var_304_2 + arg_304_0 and not isNil(var_304_0) and arg_301_1.var_.actorSpriteComps10021 then
				for iter_304_2, iter_304_3 in pairs(arg_301_1.var_.actorSpriteComps10021:ToTable()) do
					if iter_304_3 then
						if arg_301_1.isInRecall_ then
							iter_304_3.color = arg_301_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_304_3.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_301_1.var_.actorSpriteComps10021 = nil
			end

			local var_304_8 = arg_301_1.actors_["10018"]
			local var_304_9 = 0

			if var_304_9 < arg_301_1.time_ and arg_301_1.time_ <= var_304_9 + arg_304_0 and not isNil(var_304_8) and arg_301_1.var_.actorSpriteComps10018 == nil then
				arg_301_1.var_.actorSpriteComps10018 = var_304_8:GetComponentsInChildren(typeof(Image), true)
			end

			local var_304_10 = 0.034

			if var_304_9 <= arg_301_1.time_ and arg_301_1.time_ < var_304_9 + var_304_10 and not isNil(var_304_8) then
				local var_304_11 = (arg_301_1.time_ - var_304_9) / var_304_10

				if arg_301_1.var_.actorSpriteComps10018 then
					for iter_304_4, iter_304_5 in pairs(arg_301_1.var_.actorSpriteComps10018:ToTable()) do
						if iter_304_5 then
							if arg_301_1.isInRecall_ then
								local var_304_12 = Mathf.Lerp(iter_304_5.color.r, arg_301_1.hightColor2.r, var_304_11)
								local var_304_13 = Mathf.Lerp(iter_304_5.color.g, arg_301_1.hightColor2.g, var_304_11)
								local var_304_14 = Mathf.Lerp(iter_304_5.color.b, arg_301_1.hightColor2.b, var_304_11)

								iter_304_5.color = Color.New(var_304_12, var_304_13, var_304_14)
							else
								local var_304_15 = Mathf.Lerp(iter_304_5.color.r, 0.5, var_304_11)

								iter_304_5.color = Color.New(var_304_15, var_304_15, var_304_15)
							end
						end
					end
				end
			end

			if arg_301_1.time_ >= var_304_9 + var_304_10 and arg_301_1.time_ < var_304_9 + var_304_10 + arg_304_0 and not isNil(var_304_8) and arg_301_1.var_.actorSpriteComps10018 then
				for iter_304_6, iter_304_7 in pairs(arg_301_1.var_.actorSpriteComps10018:ToTable()) do
					if iter_304_7 then
						if arg_301_1.isInRecall_ then
							iter_304_7.color = arg_301_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_304_7.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_301_1.var_.actorSpriteComps10018 = nil
			end

			local var_304_16 = 0
			local var_304_17 = 0.3

			if var_304_16 < arg_301_1.time_ and arg_301_1.time_ <= var_304_16 + arg_304_0 then
				arg_301_1.talkMaxDuration = 0
				arg_301_1.dialogCg_.alpha = 1

				arg_301_1.dialog_:SetActive(true)
				SetActive(arg_301_1.leftNameGo_, true)

				local var_304_18 = arg_301_1:FormatText(StoryNameCfg[226].name)

				arg_301_1.leftNameTxt_.text = var_304_18

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_301_1.leftNameTxt_.transform)

				arg_301_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_301_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_301_1:RecordName(arg_301_1.leftNameTxt_.text)
				SetActive(arg_301_1.iconTrs_.gameObject, false)
				arg_301_1.callingController_:SetSelectedState("normal")

				local var_304_19 = arg_301_1:GetWordFromCfg(114251074)
				local var_304_20 = arg_301_1:FormatText(var_304_19.content)

				arg_301_1.text_.text = var_304_20

				LuaForUtil.ClearLinePrefixSymbol(arg_301_1.text_)

				local var_304_21 = 12
				local var_304_22 = utf8.len(var_304_20)
				local var_304_23 = var_304_21 <= 0 and var_304_17 or var_304_17 * (var_304_22 / var_304_21)

				if var_304_23 > 0 and var_304_17 < var_304_23 then
					arg_301_1.talkMaxDuration = var_304_23

					if var_304_23 + var_304_16 > arg_301_1.duration_ then
						arg_301_1.duration_ = var_304_23 + var_304_16
					end
				end

				arg_301_1.text_.text = var_304_20
				arg_301_1.typewritter.percent = 0

				arg_301_1.typewritter:SetDirty()
				arg_301_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_114251", "114251074", "story_v_out_114251.awb") ~= 0 then
					local var_304_24 = manager.audio:GetVoiceLength("story_v_out_114251", "114251074", "story_v_out_114251.awb") / 1000

					if var_304_24 + var_304_16 > arg_301_1.duration_ then
						arg_301_1.duration_ = var_304_24 + var_304_16
					end

					if var_304_19.prefab_name ~= "" and arg_301_1.actors_[var_304_19.prefab_name] ~= nil then
						local var_304_25 = LuaForUtil.PlayVoiceWithCriLipsync(arg_301_1.actors_[var_304_19.prefab_name].transform, "story_v_out_114251", "114251074", "story_v_out_114251.awb")

						arg_301_1:RecordAudio("114251074", var_304_25)
						arg_301_1:RecordAudio("114251074", var_304_25)
					else
						arg_301_1:AudioAction("play", "voice", "story_v_out_114251", "114251074", "story_v_out_114251.awb")
					end

					arg_301_1:RecordHistoryTalkVoice("story_v_out_114251", "114251074", "story_v_out_114251.awb")
				end

				arg_301_1:RecordContent(arg_301_1.text_.text)
			end

			local var_304_26 = math.max(var_304_17, arg_301_1.talkMaxDuration)

			if var_304_16 <= arg_301_1.time_ and arg_301_1.time_ < var_304_16 + var_304_26 then
				arg_301_1.typewritter.percent = (arg_301_1.time_ - var_304_16) / var_304_26

				arg_301_1.typewritter:SetDirty()
			end

			if arg_301_1.time_ >= var_304_16 + var_304_26 and arg_301_1.time_ < var_304_16 + var_304_26 + arg_304_0 then
				arg_301_1.typewritter.percent = 1

				arg_301_1.typewritter:SetDirty()
				arg_301_1:ShowNextGo(true)
			end
		end

		arg_301_1.nodeConfigList_ = {}

		arg_301_1:InitPlayNodeList()
	end,
	Play114251075 = function(arg_305_0, arg_305_1)
		arg_305_1.time_ = 0
		arg_305_1.frameCnt_ = 0
		arg_305_1.state_ = "playing"
		arg_305_1.curTalkId_ = 114251075
		arg_305_1.duration_ = 11.57

		local var_305_0 = {
			ja = 8.8,
			ko = 10.266,
			zh = 11.566,
			en = 8.633
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
				arg_305_0:Play114251076(arg_305_1)
			end
		end

		function arg_305_1.onSingleLineUpdate_(arg_308_0)
			local var_308_0 = arg_305_1.actors_["10021"]
			local var_308_1 = 0

			if var_308_1 < arg_305_1.time_ and arg_305_1.time_ <= var_308_1 + arg_308_0 and not isNil(var_308_0) and arg_305_1.var_.actorSpriteComps10021 == nil then
				arg_305_1.var_.actorSpriteComps10021 = var_308_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_308_2 = 0.034

			if var_308_1 <= arg_305_1.time_ and arg_305_1.time_ < var_308_1 + var_308_2 and not isNil(var_308_0) then
				local var_308_3 = (arg_305_1.time_ - var_308_1) / var_308_2

				if arg_305_1.var_.actorSpriteComps10021 then
					for iter_308_0, iter_308_1 in pairs(arg_305_1.var_.actorSpriteComps10021:ToTable()) do
						if iter_308_1 then
							if arg_305_1.isInRecall_ then
								local var_308_4 = Mathf.Lerp(iter_308_1.color.r, arg_305_1.hightColor2.r, var_308_3)
								local var_308_5 = Mathf.Lerp(iter_308_1.color.g, arg_305_1.hightColor2.g, var_308_3)
								local var_308_6 = Mathf.Lerp(iter_308_1.color.b, arg_305_1.hightColor2.b, var_308_3)

								iter_308_1.color = Color.New(var_308_4, var_308_5, var_308_6)
							else
								local var_308_7 = Mathf.Lerp(iter_308_1.color.r, 0.5, var_308_3)

								iter_308_1.color = Color.New(var_308_7, var_308_7, var_308_7)
							end
						end
					end
				end
			end

			if arg_305_1.time_ >= var_308_1 + var_308_2 and arg_305_1.time_ < var_308_1 + var_308_2 + arg_308_0 and not isNil(var_308_0) and arg_305_1.var_.actorSpriteComps10021 then
				for iter_308_2, iter_308_3 in pairs(arg_305_1.var_.actorSpriteComps10021:ToTable()) do
					if iter_308_3 then
						if arg_305_1.isInRecall_ then
							iter_308_3.color = arg_305_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_308_3.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_305_1.var_.actorSpriteComps10021 = nil
			end

			local var_308_8 = arg_305_1.actors_["10018"]
			local var_308_9 = 0

			if var_308_9 < arg_305_1.time_ and arg_305_1.time_ <= var_308_9 + arg_308_0 and not isNil(var_308_8) and arg_305_1.var_.actorSpriteComps10018 == nil then
				arg_305_1.var_.actorSpriteComps10018 = var_308_8:GetComponentsInChildren(typeof(Image), true)
			end

			local var_308_10 = 0.034

			if var_308_9 <= arg_305_1.time_ and arg_305_1.time_ < var_308_9 + var_308_10 and not isNil(var_308_8) then
				local var_308_11 = (arg_305_1.time_ - var_308_9) / var_308_10

				if arg_305_1.var_.actorSpriteComps10018 then
					for iter_308_4, iter_308_5 in pairs(arg_305_1.var_.actorSpriteComps10018:ToTable()) do
						if iter_308_5 then
							if arg_305_1.isInRecall_ then
								local var_308_12 = Mathf.Lerp(iter_308_5.color.r, arg_305_1.hightColor1.r, var_308_11)
								local var_308_13 = Mathf.Lerp(iter_308_5.color.g, arg_305_1.hightColor1.g, var_308_11)
								local var_308_14 = Mathf.Lerp(iter_308_5.color.b, arg_305_1.hightColor1.b, var_308_11)

								iter_308_5.color = Color.New(var_308_12, var_308_13, var_308_14)
							else
								local var_308_15 = Mathf.Lerp(iter_308_5.color.r, 1, var_308_11)

								iter_308_5.color = Color.New(var_308_15, var_308_15, var_308_15)
							end
						end
					end
				end
			end

			if arg_305_1.time_ >= var_308_9 + var_308_10 and arg_305_1.time_ < var_308_9 + var_308_10 + arg_308_0 and not isNil(var_308_8) and arg_305_1.var_.actorSpriteComps10018 then
				for iter_308_6, iter_308_7 in pairs(arg_305_1.var_.actorSpriteComps10018:ToTable()) do
					if iter_308_7 then
						if arg_305_1.isInRecall_ then
							iter_308_7.color = arg_305_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_308_7.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_305_1.var_.actorSpriteComps10018 = nil
			end

			local var_308_16 = 0
			local var_308_17 = 1.05

			if var_308_16 < arg_305_1.time_ and arg_305_1.time_ <= var_308_16 + arg_308_0 then
				arg_305_1.talkMaxDuration = 0
				arg_305_1.dialogCg_.alpha = 1

				arg_305_1.dialog_:SetActive(true)
				SetActive(arg_305_1.leftNameGo_, true)

				local var_308_18 = arg_305_1:FormatText(StoryNameCfg[258].name)

				arg_305_1.leftNameTxt_.text = var_308_18

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_305_1.leftNameTxt_.transform)

				arg_305_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_305_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_305_1:RecordName(arg_305_1.leftNameTxt_.text)
				SetActive(arg_305_1.iconTrs_.gameObject, false)
				arg_305_1.callingController_:SetSelectedState("normal")

				local var_308_19 = arg_305_1:GetWordFromCfg(114251075)
				local var_308_20 = arg_305_1:FormatText(var_308_19.content)

				arg_305_1.text_.text = var_308_20

				LuaForUtil.ClearLinePrefixSymbol(arg_305_1.text_)

				local var_308_21 = 42
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

				if manager.audio:GetVoiceLength("story_v_out_114251", "114251075", "story_v_out_114251.awb") ~= 0 then
					local var_308_24 = manager.audio:GetVoiceLength("story_v_out_114251", "114251075", "story_v_out_114251.awb") / 1000

					if var_308_24 + var_308_16 > arg_305_1.duration_ then
						arg_305_1.duration_ = var_308_24 + var_308_16
					end

					if var_308_19.prefab_name ~= "" and arg_305_1.actors_[var_308_19.prefab_name] ~= nil then
						local var_308_25 = LuaForUtil.PlayVoiceWithCriLipsync(arg_305_1.actors_[var_308_19.prefab_name].transform, "story_v_out_114251", "114251075", "story_v_out_114251.awb")

						arg_305_1:RecordAudio("114251075", var_308_25)
						arg_305_1:RecordAudio("114251075", var_308_25)
					else
						arg_305_1:AudioAction("play", "voice", "story_v_out_114251", "114251075", "story_v_out_114251.awb")
					end

					arg_305_1:RecordHistoryTalkVoice("story_v_out_114251", "114251075", "story_v_out_114251.awb")
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
	Play114251076 = function(arg_309_0, arg_309_1)
		arg_309_1.time_ = 0
		arg_309_1.frameCnt_ = 0
		arg_309_1.state_ = "playing"
		arg_309_1.curTalkId_ = 114251076
		arg_309_1.duration_ = 4.23

		local var_309_0 = {
			ja = 4.233,
			ko = 3.033,
			zh = 3,
			en = 3.733
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
				arg_309_0:Play114251077(arg_309_1)
			end
		end

		function arg_309_1.onSingleLineUpdate_(arg_312_0)
			local var_312_0 = arg_309_1.actors_["10021"]
			local var_312_1 = 0

			if var_312_1 < arg_309_1.time_ and arg_309_1.time_ <= var_312_1 + arg_312_0 and not isNil(var_312_0) and arg_309_1.var_.actorSpriteComps10021 == nil then
				arg_309_1.var_.actorSpriteComps10021 = var_312_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_312_2 = 0.034

			if var_312_1 <= arg_309_1.time_ and arg_309_1.time_ < var_312_1 + var_312_2 and not isNil(var_312_0) then
				local var_312_3 = (arg_309_1.time_ - var_312_1) / var_312_2

				if arg_309_1.var_.actorSpriteComps10021 then
					for iter_312_0, iter_312_1 in pairs(arg_309_1.var_.actorSpriteComps10021:ToTable()) do
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

			if arg_309_1.time_ >= var_312_1 + var_312_2 and arg_309_1.time_ < var_312_1 + var_312_2 + arg_312_0 and not isNil(var_312_0) and arg_309_1.var_.actorSpriteComps10021 then
				for iter_312_2, iter_312_3 in pairs(arg_309_1.var_.actorSpriteComps10021:ToTable()) do
					if iter_312_3 then
						if arg_309_1.isInRecall_ then
							iter_312_3.color = arg_309_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_312_3.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_309_1.var_.actorSpriteComps10021 = nil
			end

			local var_312_8 = arg_309_1.actors_["10018"]
			local var_312_9 = 0

			if var_312_9 < arg_309_1.time_ and arg_309_1.time_ <= var_312_9 + arg_312_0 and not isNil(var_312_8) and arg_309_1.var_.actorSpriteComps10018 == nil then
				arg_309_1.var_.actorSpriteComps10018 = var_312_8:GetComponentsInChildren(typeof(Image), true)
			end

			local var_312_10 = 0.034

			if var_312_9 <= arg_309_1.time_ and arg_309_1.time_ < var_312_9 + var_312_10 and not isNil(var_312_8) then
				local var_312_11 = (arg_309_1.time_ - var_312_9) / var_312_10

				if arg_309_1.var_.actorSpriteComps10018 then
					for iter_312_4, iter_312_5 in pairs(arg_309_1.var_.actorSpriteComps10018:ToTable()) do
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

			if arg_309_1.time_ >= var_312_9 + var_312_10 and arg_309_1.time_ < var_312_9 + var_312_10 + arg_312_0 and not isNil(var_312_8) and arg_309_1.var_.actorSpriteComps10018 then
				for iter_312_6, iter_312_7 in pairs(arg_309_1.var_.actorSpriteComps10018:ToTable()) do
					if iter_312_7 then
						if arg_309_1.isInRecall_ then
							iter_312_7.color = arg_309_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_312_7.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_309_1.var_.actorSpriteComps10018 = nil
			end

			local var_312_16 = 0
			local var_312_17 = 0.3

			if var_312_16 < arg_309_1.time_ and arg_309_1.time_ <= var_312_16 + arg_312_0 then
				arg_309_1.talkMaxDuration = 0
				arg_309_1.dialogCg_.alpha = 1

				arg_309_1.dialog_:SetActive(true)
				SetActive(arg_309_1.leftNameGo_, true)

				local var_312_18 = arg_309_1:FormatText(StoryNameCfg[226].name)

				arg_309_1.leftNameTxt_.text = var_312_18

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_309_1.leftNameTxt_.transform)

				arg_309_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_309_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_309_1:RecordName(arg_309_1.leftNameTxt_.text)
				SetActive(arg_309_1.iconTrs_.gameObject, false)
				arg_309_1.callingController_:SetSelectedState("normal")

				local var_312_19 = arg_309_1:GetWordFromCfg(114251076)
				local var_312_20 = arg_309_1:FormatText(var_312_19.content)

				arg_309_1.text_.text = var_312_20

				LuaForUtil.ClearLinePrefixSymbol(arg_309_1.text_)

				local var_312_21 = 12
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

				if manager.audio:GetVoiceLength("story_v_out_114251", "114251076", "story_v_out_114251.awb") ~= 0 then
					local var_312_24 = manager.audio:GetVoiceLength("story_v_out_114251", "114251076", "story_v_out_114251.awb") / 1000

					if var_312_24 + var_312_16 > arg_309_1.duration_ then
						arg_309_1.duration_ = var_312_24 + var_312_16
					end

					if var_312_19.prefab_name ~= "" and arg_309_1.actors_[var_312_19.prefab_name] ~= nil then
						local var_312_25 = LuaForUtil.PlayVoiceWithCriLipsync(arg_309_1.actors_[var_312_19.prefab_name].transform, "story_v_out_114251", "114251076", "story_v_out_114251.awb")

						arg_309_1:RecordAudio("114251076", var_312_25)
						arg_309_1:RecordAudio("114251076", var_312_25)
					else
						arg_309_1:AudioAction("play", "voice", "story_v_out_114251", "114251076", "story_v_out_114251.awb")
					end

					arg_309_1:RecordHistoryTalkVoice("story_v_out_114251", "114251076", "story_v_out_114251.awb")
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
	Play114251077 = function(arg_313_0, arg_313_1)
		arg_313_1.time_ = 0
		arg_313_1.frameCnt_ = 0
		arg_313_1.state_ = "playing"
		arg_313_1.curTalkId_ = 114251077
		arg_313_1.duration_ = 5

		SetActive(arg_313_1.tipsGo_, false)

		function arg_313_1.onSingleLineFinish_()
			arg_313_1.onSingleLineUpdate_ = nil
			arg_313_1.onSingleLineFinish_ = nil
			arg_313_1.state_ = "waiting"
		end

		function arg_313_1.playNext_(arg_315_0)
			if arg_315_0 == 1 then
				arg_313_0:Play114251078(arg_313_1)
			end
		end

		function arg_313_1.onSingleLineUpdate_(arg_316_0)
			local var_316_0 = arg_313_1.actors_["10021"]
			local var_316_1 = 0

			if var_316_1 < arg_313_1.time_ and arg_313_1.time_ <= var_316_1 + arg_316_0 and not isNil(var_316_0) and arg_313_1.var_.actorSpriteComps10021 == nil then
				arg_313_1.var_.actorSpriteComps10021 = var_316_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_316_2 = 0.034

			if var_316_1 <= arg_313_1.time_ and arg_313_1.time_ < var_316_1 + var_316_2 and not isNil(var_316_0) then
				local var_316_3 = (arg_313_1.time_ - var_316_1) / var_316_2

				if arg_313_1.var_.actorSpriteComps10021 then
					for iter_316_0, iter_316_1 in pairs(arg_313_1.var_.actorSpriteComps10021:ToTable()) do
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

			if arg_313_1.time_ >= var_316_1 + var_316_2 and arg_313_1.time_ < var_316_1 + var_316_2 + arg_316_0 and not isNil(var_316_0) and arg_313_1.var_.actorSpriteComps10021 then
				for iter_316_2, iter_316_3 in pairs(arg_313_1.var_.actorSpriteComps10021:ToTable()) do
					if iter_316_3 then
						if arg_313_1.isInRecall_ then
							iter_316_3.color = arg_313_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_316_3.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_313_1.var_.actorSpriteComps10021 = nil
			end

			local var_316_8 = 0
			local var_316_9 = 0.8

			if var_316_8 < arg_313_1.time_ and arg_313_1.time_ <= var_316_8 + arg_316_0 then
				arg_313_1.talkMaxDuration = 0
				arg_313_1.dialogCg_.alpha = 1

				arg_313_1.dialog_:SetActive(true)
				SetActive(arg_313_1.leftNameGo_, false)

				arg_313_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_313_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_313_1:RecordName(arg_313_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_313_1.iconTrs_.gameObject, false)
				arg_313_1.callingController_:SetSelectedState("normal")

				local var_316_10 = arg_313_1:GetWordFromCfg(114251077)
				local var_316_11 = arg_313_1:FormatText(var_316_10.content)

				arg_313_1.text_.text = var_316_11

				LuaForUtil.ClearLinePrefixSymbol(arg_313_1.text_)

				local var_316_12 = 32
				local var_316_13 = utf8.len(var_316_11)
				local var_316_14 = var_316_12 <= 0 and var_316_9 or var_316_9 * (var_316_13 / var_316_12)

				if var_316_14 > 0 and var_316_9 < var_316_14 then
					arg_313_1.talkMaxDuration = var_316_14

					if var_316_14 + var_316_8 > arg_313_1.duration_ then
						arg_313_1.duration_ = var_316_14 + var_316_8
					end
				end

				arg_313_1.text_.text = var_316_11
				arg_313_1.typewritter.percent = 0

				arg_313_1.typewritter:SetDirty()
				arg_313_1:ShowNextGo(false)
				arg_313_1:RecordContent(arg_313_1.text_.text)
			end

			local var_316_15 = math.max(var_316_9, arg_313_1.talkMaxDuration)

			if var_316_8 <= arg_313_1.time_ and arg_313_1.time_ < var_316_8 + var_316_15 then
				arg_313_1.typewritter.percent = (arg_313_1.time_ - var_316_8) / var_316_15

				arg_313_1.typewritter:SetDirty()
			end

			if arg_313_1.time_ >= var_316_8 + var_316_15 and arg_313_1.time_ < var_316_8 + var_316_15 + arg_316_0 then
				arg_313_1.typewritter.percent = 1

				arg_313_1.typewritter:SetDirty()
				arg_313_1:ShowNextGo(true)
			end
		end

		arg_313_1.nodeConfigList_ = {}

		arg_313_1:InitPlayNodeList()
	end,
	Play114251078 = function(arg_317_0, arg_317_1)
		arg_317_1.time_ = 0
		arg_317_1.frameCnt_ = 0
		arg_317_1.state_ = "playing"
		arg_317_1.curTalkId_ = 114251078
		arg_317_1.duration_ = 12.93

		local var_317_0 = {
			ja = 9.966,
			ko = 12.933,
			zh = 12.466,
			en = 10.966
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
				arg_317_0:Play114251079(arg_317_1)
			end
		end

		function arg_317_1.onSingleLineUpdate_(arg_320_0)
			local var_320_0 = arg_317_1.actors_["10018"]
			local var_320_1 = 0

			if var_320_1 < arg_317_1.time_ and arg_317_1.time_ <= var_320_1 + arg_320_0 and not isNil(var_320_0) and arg_317_1.var_.actorSpriteComps10018 == nil then
				arg_317_1.var_.actorSpriteComps10018 = var_320_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_320_2 = 0.034

			if var_320_1 <= arg_317_1.time_ and arg_317_1.time_ < var_320_1 + var_320_2 and not isNil(var_320_0) then
				local var_320_3 = (arg_317_1.time_ - var_320_1) / var_320_2

				if arg_317_1.var_.actorSpriteComps10018 then
					for iter_320_0, iter_320_1 in pairs(arg_317_1.var_.actorSpriteComps10018:ToTable()) do
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

			if arg_317_1.time_ >= var_320_1 + var_320_2 and arg_317_1.time_ < var_320_1 + var_320_2 + arg_320_0 and not isNil(var_320_0) and arg_317_1.var_.actorSpriteComps10018 then
				for iter_320_2, iter_320_3 in pairs(arg_317_1.var_.actorSpriteComps10018:ToTable()) do
					if iter_320_3 then
						if arg_317_1.isInRecall_ then
							iter_320_3.color = arg_317_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_320_3.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_317_1.var_.actorSpriteComps10018 = nil
			end

			local var_320_8 = 0
			local var_320_9 = 1.3

			if var_320_8 < arg_317_1.time_ and arg_317_1.time_ <= var_320_8 + arg_320_0 then
				arg_317_1.talkMaxDuration = 0
				arg_317_1.dialogCg_.alpha = 1

				arg_317_1.dialog_:SetActive(true)
				SetActive(arg_317_1.leftNameGo_, true)

				local var_320_10 = arg_317_1:FormatText(StoryNameCfg[258].name)

				arg_317_1.leftNameTxt_.text = var_320_10

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_317_1.leftNameTxt_.transform)

				arg_317_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_317_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_317_1:RecordName(arg_317_1.leftNameTxt_.text)
				SetActive(arg_317_1.iconTrs_.gameObject, false)
				arg_317_1.callingController_:SetSelectedState("normal")

				local var_320_11 = arg_317_1:GetWordFromCfg(114251078)
				local var_320_12 = arg_317_1:FormatText(var_320_11.content)

				arg_317_1.text_.text = var_320_12

				LuaForUtil.ClearLinePrefixSymbol(arg_317_1.text_)

				local var_320_13 = 52
				local var_320_14 = utf8.len(var_320_12)
				local var_320_15 = var_320_13 <= 0 and var_320_9 or var_320_9 * (var_320_14 / var_320_13)

				if var_320_15 > 0 and var_320_9 < var_320_15 then
					arg_317_1.talkMaxDuration = var_320_15

					if var_320_15 + var_320_8 > arg_317_1.duration_ then
						arg_317_1.duration_ = var_320_15 + var_320_8
					end
				end

				arg_317_1.text_.text = var_320_12
				arg_317_1.typewritter.percent = 0

				arg_317_1.typewritter:SetDirty()
				arg_317_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_114251", "114251078", "story_v_out_114251.awb") ~= 0 then
					local var_320_16 = manager.audio:GetVoiceLength("story_v_out_114251", "114251078", "story_v_out_114251.awb") / 1000

					if var_320_16 + var_320_8 > arg_317_1.duration_ then
						arg_317_1.duration_ = var_320_16 + var_320_8
					end

					if var_320_11.prefab_name ~= "" and arg_317_1.actors_[var_320_11.prefab_name] ~= nil then
						local var_320_17 = LuaForUtil.PlayVoiceWithCriLipsync(arg_317_1.actors_[var_320_11.prefab_name].transform, "story_v_out_114251", "114251078", "story_v_out_114251.awb")

						arg_317_1:RecordAudio("114251078", var_320_17)
						arg_317_1:RecordAudio("114251078", var_320_17)
					else
						arg_317_1:AudioAction("play", "voice", "story_v_out_114251", "114251078", "story_v_out_114251.awb")
					end

					arg_317_1:RecordHistoryTalkVoice("story_v_out_114251", "114251078", "story_v_out_114251.awb")
				end

				arg_317_1:RecordContent(arg_317_1.text_.text)
			end

			local var_320_18 = math.max(var_320_9, arg_317_1.talkMaxDuration)

			if var_320_8 <= arg_317_1.time_ and arg_317_1.time_ < var_320_8 + var_320_18 then
				arg_317_1.typewritter.percent = (arg_317_1.time_ - var_320_8) / var_320_18

				arg_317_1.typewritter:SetDirty()
			end

			if arg_317_1.time_ >= var_320_8 + var_320_18 and arg_317_1.time_ < var_320_8 + var_320_18 + arg_320_0 then
				arg_317_1.typewritter.percent = 1

				arg_317_1.typewritter:SetDirty()
				arg_317_1:ShowNextGo(true)
			end
		end

		arg_317_1.nodeConfigList_ = {}

		arg_317_1:InitPlayNodeList()
	end,
	Play114251079 = function(arg_321_0, arg_321_1)
		arg_321_1.time_ = 0
		arg_321_1.frameCnt_ = 0
		arg_321_1.state_ = "playing"
		arg_321_1.curTalkId_ = 114251079
		arg_321_1.duration_ = 5.43

		local var_321_0 = {
			ja = 5.433,
			ko = 3.4,
			zh = 3.333,
			en = 3.1
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
				arg_321_0:Play114251080(arg_321_1)
			end
		end

		function arg_321_1.onSingleLineUpdate_(arg_324_0)
			local var_324_0 = arg_321_1.actors_["10021"]
			local var_324_1 = 0

			if var_324_1 < arg_321_1.time_ and arg_321_1.time_ <= var_324_1 + arg_324_0 and not isNil(var_324_0) and arg_321_1.var_.actorSpriteComps10021 == nil then
				arg_321_1.var_.actorSpriteComps10021 = var_324_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_324_2 = 0.034

			if var_324_1 <= arg_321_1.time_ and arg_321_1.time_ < var_324_1 + var_324_2 and not isNil(var_324_0) then
				local var_324_3 = (arg_321_1.time_ - var_324_1) / var_324_2

				if arg_321_1.var_.actorSpriteComps10021 then
					for iter_324_0, iter_324_1 in pairs(arg_321_1.var_.actorSpriteComps10021:ToTable()) do
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

			if arg_321_1.time_ >= var_324_1 + var_324_2 and arg_321_1.time_ < var_324_1 + var_324_2 + arg_324_0 and not isNil(var_324_0) and arg_321_1.var_.actorSpriteComps10021 then
				for iter_324_2, iter_324_3 in pairs(arg_321_1.var_.actorSpriteComps10021:ToTable()) do
					if iter_324_3 then
						if arg_321_1.isInRecall_ then
							iter_324_3.color = arg_321_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_324_3.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_321_1.var_.actorSpriteComps10021 = nil
			end

			local var_324_8 = arg_321_1.actors_["10018"]
			local var_324_9 = 0

			if var_324_9 < arg_321_1.time_ and arg_321_1.time_ <= var_324_9 + arg_324_0 and not isNil(var_324_8) and arg_321_1.var_.actorSpriteComps10018 == nil then
				arg_321_1.var_.actorSpriteComps10018 = var_324_8:GetComponentsInChildren(typeof(Image), true)
			end

			local var_324_10 = 0.034

			if var_324_9 <= arg_321_1.time_ and arg_321_1.time_ < var_324_9 + var_324_10 and not isNil(var_324_8) then
				local var_324_11 = (arg_321_1.time_ - var_324_9) / var_324_10

				if arg_321_1.var_.actorSpriteComps10018 then
					for iter_324_4, iter_324_5 in pairs(arg_321_1.var_.actorSpriteComps10018:ToTable()) do
						if iter_324_5 then
							if arg_321_1.isInRecall_ then
								local var_324_12 = Mathf.Lerp(iter_324_5.color.r, arg_321_1.hightColor2.r, var_324_11)
								local var_324_13 = Mathf.Lerp(iter_324_5.color.g, arg_321_1.hightColor2.g, var_324_11)
								local var_324_14 = Mathf.Lerp(iter_324_5.color.b, arg_321_1.hightColor2.b, var_324_11)

								iter_324_5.color = Color.New(var_324_12, var_324_13, var_324_14)
							else
								local var_324_15 = Mathf.Lerp(iter_324_5.color.r, 0.5, var_324_11)

								iter_324_5.color = Color.New(var_324_15, var_324_15, var_324_15)
							end
						end
					end
				end
			end

			if arg_321_1.time_ >= var_324_9 + var_324_10 and arg_321_1.time_ < var_324_9 + var_324_10 + arg_324_0 and not isNil(var_324_8) and arg_321_1.var_.actorSpriteComps10018 then
				for iter_324_6, iter_324_7 in pairs(arg_321_1.var_.actorSpriteComps10018:ToTable()) do
					if iter_324_7 then
						if arg_321_1.isInRecall_ then
							iter_324_7.color = arg_321_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_324_7.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_321_1.var_.actorSpriteComps10018 = nil
			end

			local var_324_16 = 0
			local var_324_17 = 0.35

			if var_324_16 < arg_321_1.time_ and arg_321_1.time_ <= var_324_16 + arg_324_0 then
				arg_321_1.talkMaxDuration = 0
				arg_321_1.dialogCg_.alpha = 1

				arg_321_1.dialog_:SetActive(true)
				SetActive(arg_321_1.leftNameGo_, true)

				local var_324_18 = arg_321_1:FormatText(StoryNameCfg[226].name)

				arg_321_1.leftNameTxt_.text = var_324_18

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_321_1.leftNameTxt_.transform)

				arg_321_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_321_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_321_1:RecordName(arg_321_1.leftNameTxt_.text)
				SetActive(arg_321_1.iconTrs_.gameObject, false)
				arg_321_1.callingController_:SetSelectedState("normal")

				local var_324_19 = arg_321_1:GetWordFromCfg(114251079)
				local var_324_20 = arg_321_1:FormatText(var_324_19.content)

				arg_321_1.text_.text = var_324_20

				LuaForUtil.ClearLinePrefixSymbol(arg_321_1.text_)

				local var_324_21 = 14
				local var_324_22 = utf8.len(var_324_20)
				local var_324_23 = var_324_21 <= 0 and var_324_17 or var_324_17 * (var_324_22 / var_324_21)

				if var_324_23 > 0 and var_324_17 < var_324_23 then
					arg_321_1.talkMaxDuration = var_324_23

					if var_324_23 + var_324_16 > arg_321_1.duration_ then
						arg_321_1.duration_ = var_324_23 + var_324_16
					end
				end

				arg_321_1.text_.text = var_324_20
				arg_321_1.typewritter.percent = 0

				arg_321_1.typewritter:SetDirty()
				arg_321_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_114251", "114251079", "story_v_out_114251.awb") ~= 0 then
					local var_324_24 = manager.audio:GetVoiceLength("story_v_out_114251", "114251079", "story_v_out_114251.awb") / 1000

					if var_324_24 + var_324_16 > arg_321_1.duration_ then
						arg_321_1.duration_ = var_324_24 + var_324_16
					end

					if var_324_19.prefab_name ~= "" and arg_321_1.actors_[var_324_19.prefab_name] ~= nil then
						local var_324_25 = LuaForUtil.PlayVoiceWithCriLipsync(arg_321_1.actors_[var_324_19.prefab_name].transform, "story_v_out_114251", "114251079", "story_v_out_114251.awb")

						arg_321_1:RecordAudio("114251079", var_324_25)
						arg_321_1:RecordAudio("114251079", var_324_25)
					else
						arg_321_1:AudioAction("play", "voice", "story_v_out_114251", "114251079", "story_v_out_114251.awb")
					end

					arg_321_1:RecordHistoryTalkVoice("story_v_out_114251", "114251079", "story_v_out_114251.awb")
				end

				arg_321_1:RecordContent(arg_321_1.text_.text)
			end

			local var_324_26 = math.max(var_324_17, arg_321_1.talkMaxDuration)

			if var_324_16 <= arg_321_1.time_ and arg_321_1.time_ < var_324_16 + var_324_26 then
				arg_321_1.typewritter.percent = (arg_321_1.time_ - var_324_16) / var_324_26

				arg_321_1.typewritter:SetDirty()
			end

			if arg_321_1.time_ >= var_324_16 + var_324_26 and arg_321_1.time_ < var_324_16 + var_324_26 + arg_324_0 then
				arg_321_1.typewritter.percent = 1

				arg_321_1.typewritter:SetDirty()
				arg_321_1:ShowNextGo(true)
			end
		end

		arg_321_1.nodeConfigList_ = {}

		arg_321_1:InitPlayNodeList()
	end,
	Play114251080 = function(arg_325_0, arg_325_1)
		arg_325_1.time_ = 0
		arg_325_1.frameCnt_ = 0
		arg_325_1.state_ = "playing"
		arg_325_1.curTalkId_ = 114251080
		arg_325_1.duration_ = 5

		SetActive(arg_325_1.tipsGo_, false)

		function arg_325_1.onSingleLineFinish_()
			arg_325_1.onSingleLineUpdate_ = nil
			arg_325_1.onSingleLineFinish_ = nil
			arg_325_1.state_ = "waiting"
		end

		function arg_325_1.playNext_(arg_327_0)
			if arg_327_0 == 1 then
				arg_325_0:Play114251081(arg_325_1)
			end
		end

		function arg_325_1.onSingleLineUpdate_(arg_328_0)
			local var_328_0 = arg_325_1.actors_["10021"]
			local var_328_1 = 0

			if var_328_1 < arg_325_1.time_ and arg_325_1.time_ <= var_328_1 + arg_328_0 and not isNil(var_328_0) and arg_325_1.var_.actorSpriteComps10021 == nil then
				arg_325_1.var_.actorSpriteComps10021 = var_328_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_328_2 = 0.034

			if var_328_1 <= arg_325_1.time_ and arg_325_1.time_ < var_328_1 + var_328_2 and not isNil(var_328_0) then
				local var_328_3 = (arg_325_1.time_ - var_328_1) / var_328_2

				if arg_325_1.var_.actorSpriteComps10021 then
					for iter_328_0, iter_328_1 in pairs(arg_325_1.var_.actorSpriteComps10021:ToTable()) do
						if iter_328_1 then
							if arg_325_1.isInRecall_ then
								local var_328_4 = Mathf.Lerp(iter_328_1.color.r, arg_325_1.hightColor2.r, var_328_3)
								local var_328_5 = Mathf.Lerp(iter_328_1.color.g, arg_325_1.hightColor2.g, var_328_3)
								local var_328_6 = Mathf.Lerp(iter_328_1.color.b, arg_325_1.hightColor2.b, var_328_3)

								iter_328_1.color = Color.New(var_328_4, var_328_5, var_328_6)
							else
								local var_328_7 = Mathf.Lerp(iter_328_1.color.r, 0.5, var_328_3)

								iter_328_1.color = Color.New(var_328_7, var_328_7, var_328_7)
							end
						end
					end
				end
			end

			if arg_325_1.time_ >= var_328_1 + var_328_2 and arg_325_1.time_ < var_328_1 + var_328_2 + arg_328_0 and not isNil(var_328_0) and arg_325_1.var_.actorSpriteComps10021 then
				for iter_328_2, iter_328_3 in pairs(arg_325_1.var_.actorSpriteComps10021:ToTable()) do
					if iter_328_3 then
						if arg_325_1.isInRecall_ then
							iter_328_3.color = arg_325_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_328_3.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_325_1.var_.actorSpriteComps10021 = nil
			end

			local var_328_8 = 0
			local var_328_9 = 0.375

			if var_328_8 < arg_325_1.time_ and arg_325_1.time_ <= var_328_8 + arg_328_0 then
				arg_325_1.talkMaxDuration = 0
				arg_325_1.dialogCg_.alpha = 1

				arg_325_1.dialog_:SetActive(true)
				SetActive(arg_325_1.leftNameGo_, false)

				arg_325_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_325_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_325_1:RecordName(arg_325_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_325_1.iconTrs_.gameObject, false)
				arg_325_1.callingController_:SetSelectedState("normal")

				local var_328_10 = arg_325_1:GetWordFromCfg(114251080)
				local var_328_11 = arg_325_1:FormatText(var_328_10.content)

				arg_325_1.text_.text = var_328_11

				LuaForUtil.ClearLinePrefixSymbol(arg_325_1.text_)

				local var_328_12 = 15
				local var_328_13 = utf8.len(var_328_11)
				local var_328_14 = var_328_12 <= 0 and var_328_9 or var_328_9 * (var_328_13 / var_328_12)

				if var_328_14 > 0 and var_328_9 < var_328_14 then
					arg_325_1.talkMaxDuration = var_328_14

					if var_328_14 + var_328_8 > arg_325_1.duration_ then
						arg_325_1.duration_ = var_328_14 + var_328_8
					end
				end

				arg_325_1.text_.text = var_328_11
				arg_325_1.typewritter.percent = 0

				arg_325_1.typewritter:SetDirty()
				arg_325_1:ShowNextGo(false)
				arg_325_1:RecordContent(arg_325_1.text_.text)
			end

			local var_328_15 = math.max(var_328_9, arg_325_1.talkMaxDuration)

			if var_328_8 <= arg_325_1.time_ and arg_325_1.time_ < var_328_8 + var_328_15 then
				arg_325_1.typewritter.percent = (arg_325_1.time_ - var_328_8) / var_328_15

				arg_325_1.typewritter:SetDirty()
			end

			if arg_325_1.time_ >= var_328_8 + var_328_15 and arg_325_1.time_ < var_328_8 + var_328_15 + arg_328_0 then
				arg_325_1.typewritter.percent = 1

				arg_325_1.typewritter:SetDirty()
				arg_325_1:ShowNextGo(true)
			end
		end

		arg_325_1.nodeConfigList_ = {}

		arg_325_1:InitPlayNodeList()
	end,
	Play114251081 = function(arg_329_0, arg_329_1)
		arg_329_1.time_ = 0
		arg_329_1.frameCnt_ = 0
		arg_329_1.state_ = "playing"
		arg_329_1.curTalkId_ = 114251081
		arg_329_1.duration_ = 4.23

		local var_329_0 = {
			ja = 3.666,
			ko = 4.233,
			zh = 2.966,
			en = 4.233
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
				arg_329_0:Play114251082(arg_329_1)
			end
		end

		function arg_329_1.onSingleLineUpdate_(arg_332_0)
			local var_332_0 = arg_329_1.actors_["10021"]
			local var_332_1 = 0

			if var_332_1 < arg_329_1.time_ and arg_329_1.time_ <= var_332_1 + arg_332_0 and not isNil(var_332_0) and arg_329_1.var_.actorSpriteComps10021 == nil then
				arg_329_1.var_.actorSpriteComps10021 = var_332_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_332_2 = 0.034

			if var_332_1 <= arg_329_1.time_ and arg_329_1.time_ < var_332_1 + var_332_2 and not isNil(var_332_0) then
				local var_332_3 = (arg_329_1.time_ - var_332_1) / var_332_2

				if arg_329_1.var_.actorSpriteComps10021 then
					for iter_332_0, iter_332_1 in pairs(arg_329_1.var_.actorSpriteComps10021:ToTable()) do
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

			if arg_329_1.time_ >= var_332_1 + var_332_2 and arg_329_1.time_ < var_332_1 + var_332_2 + arg_332_0 and not isNil(var_332_0) and arg_329_1.var_.actorSpriteComps10021 then
				for iter_332_2, iter_332_3 in pairs(arg_329_1.var_.actorSpriteComps10021:ToTable()) do
					if iter_332_3 then
						if arg_329_1.isInRecall_ then
							iter_332_3.color = arg_329_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_332_3.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_329_1.var_.actorSpriteComps10021 = nil
			end

			local var_332_8 = 0
			local var_332_9 = 0.45

			if var_332_8 < arg_329_1.time_ and arg_329_1.time_ <= var_332_8 + arg_332_0 then
				arg_329_1.talkMaxDuration = 0
				arg_329_1.dialogCg_.alpha = 1

				arg_329_1.dialog_:SetActive(true)
				SetActive(arg_329_1.leftNameGo_, true)

				local var_332_10 = arg_329_1:FormatText(StoryNameCfg[226].name)

				arg_329_1.leftNameTxt_.text = var_332_10

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_329_1.leftNameTxt_.transform)

				arg_329_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_329_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_329_1:RecordName(arg_329_1.leftNameTxt_.text)
				SetActive(arg_329_1.iconTrs_.gameObject, false)
				arg_329_1.callingController_:SetSelectedState("normal")

				local var_332_11 = arg_329_1:GetWordFromCfg(114251081)
				local var_332_12 = arg_329_1:FormatText(var_332_11.content)

				arg_329_1.text_.text = var_332_12

				LuaForUtil.ClearLinePrefixSymbol(arg_329_1.text_)

				local var_332_13 = 18
				local var_332_14 = utf8.len(var_332_12)
				local var_332_15 = var_332_13 <= 0 and var_332_9 or var_332_9 * (var_332_14 / var_332_13)

				if var_332_15 > 0 and var_332_9 < var_332_15 then
					arg_329_1.talkMaxDuration = var_332_15

					if var_332_15 + var_332_8 > arg_329_1.duration_ then
						arg_329_1.duration_ = var_332_15 + var_332_8
					end
				end

				arg_329_1.text_.text = var_332_12
				arg_329_1.typewritter.percent = 0

				arg_329_1.typewritter:SetDirty()
				arg_329_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_114251", "114251081", "story_v_out_114251.awb") ~= 0 then
					local var_332_16 = manager.audio:GetVoiceLength("story_v_out_114251", "114251081", "story_v_out_114251.awb") / 1000

					if var_332_16 + var_332_8 > arg_329_1.duration_ then
						arg_329_1.duration_ = var_332_16 + var_332_8
					end

					if var_332_11.prefab_name ~= "" and arg_329_1.actors_[var_332_11.prefab_name] ~= nil then
						local var_332_17 = LuaForUtil.PlayVoiceWithCriLipsync(arg_329_1.actors_[var_332_11.prefab_name].transform, "story_v_out_114251", "114251081", "story_v_out_114251.awb")

						arg_329_1:RecordAudio("114251081", var_332_17)
						arg_329_1:RecordAudio("114251081", var_332_17)
					else
						arg_329_1:AudioAction("play", "voice", "story_v_out_114251", "114251081", "story_v_out_114251.awb")
					end

					arg_329_1:RecordHistoryTalkVoice("story_v_out_114251", "114251081", "story_v_out_114251.awb")
				end

				arg_329_1:RecordContent(arg_329_1.text_.text)
			end

			local var_332_18 = math.max(var_332_9, arg_329_1.talkMaxDuration)

			if var_332_8 <= arg_329_1.time_ and arg_329_1.time_ < var_332_8 + var_332_18 then
				arg_329_1.typewritter.percent = (arg_329_1.time_ - var_332_8) / var_332_18

				arg_329_1.typewritter:SetDirty()
			end

			if arg_329_1.time_ >= var_332_8 + var_332_18 and arg_329_1.time_ < var_332_8 + var_332_18 + arg_332_0 then
				arg_329_1.typewritter.percent = 1

				arg_329_1.typewritter:SetDirty()
				arg_329_1:ShowNextGo(true)
			end
		end

		arg_329_1.nodeConfigList_ = {}

		arg_329_1:InitPlayNodeList()
	end,
	Play114251082 = function(arg_333_0, arg_333_1)
		arg_333_1.time_ = 0
		arg_333_1.frameCnt_ = 0
		arg_333_1.state_ = "playing"
		arg_333_1.curTalkId_ = 114251082
		arg_333_1.duration_ = 5.2

		local var_333_0 = {
			ja = 4.766,
			ko = 3.1,
			zh = 5.2,
			en = 4.733
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
				arg_333_0:Play114251083(arg_333_1)
			end
		end

		function arg_333_1.onSingleLineUpdate_(arg_336_0)
			local var_336_0 = arg_333_1.actors_["10021"]
			local var_336_1 = 0

			if var_336_1 < arg_333_1.time_ and arg_333_1.time_ <= var_336_1 + arg_336_0 and not isNil(var_336_0) and arg_333_1.var_.actorSpriteComps10021 == nil then
				arg_333_1.var_.actorSpriteComps10021 = var_336_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_336_2 = 0.034

			if var_336_1 <= arg_333_1.time_ and arg_333_1.time_ < var_336_1 + var_336_2 and not isNil(var_336_0) then
				local var_336_3 = (arg_333_1.time_ - var_336_1) / var_336_2

				if arg_333_1.var_.actorSpriteComps10021 then
					for iter_336_0, iter_336_1 in pairs(arg_333_1.var_.actorSpriteComps10021:ToTable()) do
						if iter_336_1 then
							if arg_333_1.isInRecall_ then
								local var_336_4 = Mathf.Lerp(iter_336_1.color.r, arg_333_1.hightColor2.r, var_336_3)
								local var_336_5 = Mathf.Lerp(iter_336_1.color.g, arg_333_1.hightColor2.g, var_336_3)
								local var_336_6 = Mathf.Lerp(iter_336_1.color.b, arg_333_1.hightColor2.b, var_336_3)

								iter_336_1.color = Color.New(var_336_4, var_336_5, var_336_6)
							else
								local var_336_7 = Mathf.Lerp(iter_336_1.color.r, 0.5, var_336_3)

								iter_336_1.color = Color.New(var_336_7, var_336_7, var_336_7)
							end
						end
					end
				end
			end

			if arg_333_1.time_ >= var_336_1 + var_336_2 and arg_333_1.time_ < var_336_1 + var_336_2 + arg_336_0 and not isNil(var_336_0) and arg_333_1.var_.actorSpriteComps10021 then
				for iter_336_2, iter_336_3 in pairs(arg_333_1.var_.actorSpriteComps10021:ToTable()) do
					if iter_336_3 then
						if arg_333_1.isInRecall_ then
							iter_336_3.color = arg_333_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_336_3.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_333_1.var_.actorSpriteComps10021 = nil
			end

			local var_336_8 = arg_333_1.actors_["10018"]
			local var_336_9 = 0

			if var_336_9 < arg_333_1.time_ and arg_333_1.time_ <= var_336_9 + arg_336_0 and not isNil(var_336_8) and arg_333_1.var_.actorSpriteComps10018 == nil then
				arg_333_1.var_.actorSpriteComps10018 = var_336_8:GetComponentsInChildren(typeof(Image), true)
			end

			local var_336_10 = 0.034

			if var_336_9 <= arg_333_1.time_ and arg_333_1.time_ < var_336_9 + var_336_10 and not isNil(var_336_8) then
				local var_336_11 = (arg_333_1.time_ - var_336_9) / var_336_10

				if arg_333_1.var_.actorSpriteComps10018 then
					for iter_336_4, iter_336_5 in pairs(arg_333_1.var_.actorSpriteComps10018:ToTable()) do
						if iter_336_5 then
							if arg_333_1.isInRecall_ then
								local var_336_12 = Mathf.Lerp(iter_336_5.color.r, arg_333_1.hightColor1.r, var_336_11)
								local var_336_13 = Mathf.Lerp(iter_336_5.color.g, arg_333_1.hightColor1.g, var_336_11)
								local var_336_14 = Mathf.Lerp(iter_336_5.color.b, arg_333_1.hightColor1.b, var_336_11)

								iter_336_5.color = Color.New(var_336_12, var_336_13, var_336_14)
							else
								local var_336_15 = Mathf.Lerp(iter_336_5.color.r, 1, var_336_11)

								iter_336_5.color = Color.New(var_336_15, var_336_15, var_336_15)
							end
						end
					end
				end
			end

			if arg_333_1.time_ >= var_336_9 + var_336_10 and arg_333_1.time_ < var_336_9 + var_336_10 + arg_336_0 and not isNil(var_336_8) and arg_333_1.var_.actorSpriteComps10018 then
				for iter_336_6, iter_336_7 in pairs(arg_333_1.var_.actorSpriteComps10018:ToTable()) do
					if iter_336_7 then
						if arg_333_1.isInRecall_ then
							iter_336_7.color = arg_333_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_336_7.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_333_1.var_.actorSpriteComps10018 = nil
			end

			local var_336_16 = 0
			local var_336_17 = 0.25

			if var_336_16 < arg_333_1.time_ and arg_333_1.time_ <= var_336_16 + arg_336_0 then
				arg_333_1.talkMaxDuration = 0
				arg_333_1.dialogCg_.alpha = 1

				arg_333_1.dialog_:SetActive(true)
				SetActive(arg_333_1.leftNameGo_, true)

				local var_336_18 = arg_333_1:FormatText(StoryNameCfg[258].name)

				arg_333_1.leftNameTxt_.text = var_336_18

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_333_1.leftNameTxt_.transform)

				arg_333_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_333_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_333_1:RecordName(arg_333_1.leftNameTxt_.text)
				SetActive(arg_333_1.iconTrs_.gameObject, false)
				arg_333_1.callingController_:SetSelectedState("normal")

				local var_336_19 = arg_333_1:GetWordFromCfg(114251082)
				local var_336_20 = arg_333_1:FormatText(var_336_19.content)

				arg_333_1.text_.text = var_336_20

				LuaForUtil.ClearLinePrefixSymbol(arg_333_1.text_)

				local var_336_21 = 10
				local var_336_22 = utf8.len(var_336_20)
				local var_336_23 = var_336_21 <= 0 and var_336_17 or var_336_17 * (var_336_22 / var_336_21)

				if var_336_23 > 0 and var_336_17 < var_336_23 then
					arg_333_1.talkMaxDuration = var_336_23

					if var_336_23 + var_336_16 > arg_333_1.duration_ then
						arg_333_1.duration_ = var_336_23 + var_336_16
					end
				end

				arg_333_1.text_.text = var_336_20
				arg_333_1.typewritter.percent = 0

				arg_333_1.typewritter:SetDirty()
				arg_333_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_114251", "114251082", "story_v_out_114251.awb") ~= 0 then
					local var_336_24 = manager.audio:GetVoiceLength("story_v_out_114251", "114251082", "story_v_out_114251.awb") / 1000

					if var_336_24 + var_336_16 > arg_333_1.duration_ then
						arg_333_1.duration_ = var_336_24 + var_336_16
					end

					if var_336_19.prefab_name ~= "" and arg_333_1.actors_[var_336_19.prefab_name] ~= nil then
						local var_336_25 = LuaForUtil.PlayVoiceWithCriLipsync(arg_333_1.actors_[var_336_19.prefab_name].transform, "story_v_out_114251", "114251082", "story_v_out_114251.awb")

						arg_333_1:RecordAudio("114251082", var_336_25)
						arg_333_1:RecordAudio("114251082", var_336_25)
					else
						arg_333_1:AudioAction("play", "voice", "story_v_out_114251", "114251082", "story_v_out_114251.awb")
					end

					arg_333_1:RecordHistoryTalkVoice("story_v_out_114251", "114251082", "story_v_out_114251.awb")
				end

				arg_333_1:RecordContent(arg_333_1.text_.text)
			end

			local var_336_26 = math.max(var_336_17, arg_333_1.talkMaxDuration)

			if var_336_16 <= arg_333_1.time_ and arg_333_1.time_ < var_336_16 + var_336_26 then
				arg_333_1.typewritter.percent = (arg_333_1.time_ - var_336_16) / var_336_26

				arg_333_1.typewritter:SetDirty()
			end

			if arg_333_1.time_ >= var_336_16 + var_336_26 and arg_333_1.time_ < var_336_16 + var_336_26 + arg_336_0 then
				arg_333_1.typewritter.percent = 1

				arg_333_1.typewritter:SetDirty()
				arg_333_1:ShowNextGo(true)
			end
		end

		arg_333_1.nodeConfigList_ = {}

		arg_333_1:InitPlayNodeList()
	end,
	Play114251083 = function(arg_337_0, arg_337_1)
		arg_337_1.time_ = 0
		arg_337_1.frameCnt_ = 0
		arg_337_1.state_ = "playing"
		arg_337_1.curTalkId_ = 114251083
		arg_337_1.duration_ = 5

		SetActive(arg_337_1.tipsGo_, false)

		function arg_337_1.onSingleLineFinish_()
			arg_337_1.onSingleLineUpdate_ = nil
			arg_337_1.onSingleLineFinish_ = nil
			arg_337_1.state_ = "waiting"
		end

		function arg_337_1.playNext_(arg_339_0)
			if arg_339_0 == 1 then
				arg_337_0:Play114251084(arg_337_1)
			end
		end

		function arg_337_1.onSingleLineUpdate_(arg_340_0)
			local var_340_0 = arg_337_1.actors_["10018"]
			local var_340_1 = 0

			if var_340_1 < arg_337_1.time_ and arg_337_1.time_ <= var_340_1 + arg_340_0 then
				local var_340_2 = var_340_0:GetComponentInChildren(typeof(CanvasGroup))

				if var_340_2 then
					arg_337_1.var_.alphaOldValue10018 = var_340_2.alpha
					arg_337_1.var_.characterEffect10018 = var_340_2
				end

				arg_337_1.var_.alphaOldValue10018 = 1
			end

			local var_340_3 = 0.5

			if var_340_1 <= arg_337_1.time_ and arg_337_1.time_ < var_340_1 + var_340_3 then
				local var_340_4 = (arg_337_1.time_ - var_340_1) / var_340_3
				local var_340_5 = Mathf.Lerp(arg_337_1.var_.alphaOldValue10018, 0, var_340_4)

				if arg_337_1.var_.characterEffect10018 then
					arg_337_1.var_.characterEffect10018.alpha = var_340_5
				end
			end

			if arg_337_1.time_ >= var_340_1 + var_340_3 and arg_337_1.time_ < var_340_1 + var_340_3 + arg_340_0 and arg_337_1.var_.characterEffect10018 then
				arg_337_1.var_.characterEffect10018.alpha = 0
			end

			local var_340_6 = arg_337_1.actors_["10021"]
			local var_340_7 = 0

			if var_340_7 < arg_337_1.time_ and arg_337_1.time_ <= var_340_7 + arg_340_0 then
				local var_340_8 = var_340_6:GetComponentInChildren(typeof(CanvasGroup))

				if var_340_8 then
					arg_337_1.var_.alphaOldValue10021 = var_340_8.alpha
					arg_337_1.var_.characterEffect10021 = var_340_8
				end

				arg_337_1.var_.alphaOldValue10021 = 1
			end

			local var_340_9 = 0.5

			if var_340_7 <= arg_337_1.time_ and arg_337_1.time_ < var_340_7 + var_340_9 then
				local var_340_10 = (arg_337_1.time_ - var_340_7) / var_340_9
				local var_340_11 = Mathf.Lerp(arg_337_1.var_.alphaOldValue10021, 0, var_340_10)

				if arg_337_1.var_.characterEffect10021 then
					arg_337_1.var_.characterEffect10021.alpha = var_340_11
				end
			end

			if arg_337_1.time_ >= var_340_7 + var_340_9 and arg_337_1.time_ < var_340_7 + var_340_9 + arg_340_0 and arg_337_1.var_.characterEffect10021 then
				arg_337_1.var_.characterEffect10021.alpha = 0
			end

			local var_340_12 = 0
			local var_340_13 = 0.925

			if var_340_12 < arg_337_1.time_ and arg_337_1.time_ <= var_340_12 + arg_340_0 then
				arg_337_1.talkMaxDuration = 0
				arg_337_1.dialogCg_.alpha = 1

				arg_337_1.dialog_:SetActive(true)
				SetActive(arg_337_1.leftNameGo_, false)

				arg_337_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_337_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_337_1:RecordName(arg_337_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_337_1.iconTrs_.gameObject, false)
				arg_337_1.callingController_:SetSelectedState("normal")

				local var_340_14 = arg_337_1:GetWordFromCfg(114251083)
				local var_340_15 = arg_337_1:FormatText(var_340_14.content)

				arg_337_1.text_.text = var_340_15

				LuaForUtil.ClearLinePrefixSymbol(arg_337_1.text_)

				local var_340_16 = 37
				local var_340_17 = utf8.len(var_340_15)
				local var_340_18 = var_340_16 <= 0 and var_340_13 or var_340_13 * (var_340_17 / var_340_16)

				if var_340_18 > 0 and var_340_13 < var_340_18 then
					arg_337_1.talkMaxDuration = var_340_18

					if var_340_18 + var_340_12 > arg_337_1.duration_ then
						arg_337_1.duration_ = var_340_18 + var_340_12
					end
				end

				arg_337_1.text_.text = var_340_15
				arg_337_1.typewritter.percent = 0

				arg_337_1.typewritter:SetDirty()
				arg_337_1:ShowNextGo(false)
				arg_337_1:RecordContent(arg_337_1.text_.text)
			end

			local var_340_19 = math.max(var_340_13, arg_337_1.talkMaxDuration)

			if var_340_12 <= arg_337_1.time_ and arg_337_1.time_ < var_340_12 + var_340_19 then
				arg_337_1.typewritter.percent = (arg_337_1.time_ - var_340_12) / var_340_19

				arg_337_1.typewritter:SetDirty()
			end

			if arg_337_1.time_ >= var_340_12 + var_340_19 and arg_337_1.time_ < var_340_12 + var_340_19 + arg_340_0 then
				arg_337_1.typewritter.percent = 1

				arg_337_1.typewritter:SetDirty()
				arg_337_1:ShowNextGo(true)
			end
		end

		arg_337_1.nodeConfigList_ = {}

		arg_337_1:InitPlayNodeList()
	end,
	Play114251084 = function(arg_341_0, arg_341_1)
		arg_341_1.time_ = 0
		arg_341_1.frameCnt_ = 0
		arg_341_1.state_ = "playing"
		arg_341_1.curTalkId_ = 114251084
		arg_341_1.duration_ = 5

		SetActive(arg_341_1.tipsGo_, false)

		function arg_341_1.onSingleLineFinish_()
			arg_341_1.onSingleLineUpdate_ = nil
			arg_341_1.onSingleLineFinish_ = nil
			arg_341_1.state_ = "waiting"
		end

		function arg_341_1.playNext_(arg_343_0)
			if arg_343_0 == 1 then
				arg_341_0:Play114251085(arg_341_1)
			end
		end

		function arg_341_1.onSingleLineUpdate_(arg_344_0)
			local var_344_0 = 0
			local var_344_1 = 1.3

			if var_344_0 < arg_341_1.time_ and arg_341_1.time_ <= var_344_0 + arg_344_0 then
				arg_341_1.talkMaxDuration = 0
				arg_341_1.dialogCg_.alpha = 1

				arg_341_1.dialog_:SetActive(true)
				SetActive(arg_341_1.leftNameGo_, false)

				arg_341_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_341_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_341_1:RecordName(arg_341_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_341_1.iconTrs_.gameObject, false)
				arg_341_1.callingController_:SetSelectedState("normal")

				local var_344_2 = arg_341_1:GetWordFromCfg(114251084)
				local var_344_3 = arg_341_1:FormatText(var_344_2.content)

				arg_341_1.text_.text = var_344_3

				LuaForUtil.ClearLinePrefixSymbol(arg_341_1.text_)

				local var_344_4 = 51
				local var_344_5 = utf8.len(var_344_3)
				local var_344_6 = var_344_4 <= 0 and var_344_1 or var_344_1 * (var_344_5 / var_344_4)

				if var_344_6 > 0 and var_344_1 < var_344_6 then
					arg_341_1.talkMaxDuration = var_344_6

					if var_344_6 + var_344_0 > arg_341_1.duration_ then
						arg_341_1.duration_ = var_344_6 + var_344_0
					end
				end

				arg_341_1.text_.text = var_344_3
				arg_341_1.typewritter.percent = 0

				arg_341_1.typewritter:SetDirty()
				arg_341_1:ShowNextGo(false)
				arg_341_1:RecordContent(arg_341_1.text_.text)
			end

			local var_344_7 = math.max(var_344_1, arg_341_1.talkMaxDuration)

			if var_344_0 <= arg_341_1.time_ and arg_341_1.time_ < var_344_0 + var_344_7 then
				arg_341_1.typewritter.percent = (arg_341_1.time_ - var_344_0) / var_344_7

				arg_341_1.typewritter:SetDirty()
			end

			if arg_341_1.time_ >= var_344_0 + var_344_7 and arg_341_1.time_ < var_344_0 + var_344_7 + arg_344_0 then
				arg_341_1.typewritter.percent = 1

				arg_341_1.typewritter:SetDirty()
				arg_341_1:ShowNextGo(true)
			end
		end

		arg_341_1.nodeConfigList_ = {}

		arg_341_1:InitPlayNodeList()
	end,
	Play114251085 = function(arg_345_0, arg_345_1)
		arg_345_1.time_ = 0
		arg_345_1.frameCnt_ = 0
		arg_345_1.state_ = "playing"
		arg_345_1.curTalkId_ = 114251085
		arg_345_1.duration_ = 4.3

		local var_345_0 = {
			ja = 3.133,
			ko = 3.6,
			zh = 4,
			en = 4.3
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
				arg_345_0:Play114251086(arg_345_1)
			end
		end

		function arg_345_1.onSingleLineUpdate_(arg_348_0)
			local var_348_0 = arg_345_1.actors_["10018"].transform
			local var_348_1 = 0

			if var_348_1 < arg_345_1.time_ and arg_345_1.time_ <= var_348_1 + arg_348_0 then
				arg_345_1.var_.moveOldPos10018 = var_348_0.localPosition
				var_348_0.localScale = Vector3.New(1, 1, 1)

				arg_345_1:CheckSpriteTmpPos("10018", 3)

				local var_348_2 = var_348_0.childCount

				for iter_348_0 = 0, var_348_2 - 1 do
					local var_348_3 = var_348_0:GetChild(iter_348_0)

					if var_348_3.name == "split_2" or not string.find(var_348_3.name, "split") then
						var_348_3.gameObject:SetActive(true)
					else
						var_348_3.gameObject:SetActive(false)
					end
				end
			end

			local var_348_4 = 0.001

			if var_348_1 <= arg_345_1.time_ and arg_345_1.time_ < var_348_1 + var_348_4 then
				local var_348_5 = (arg_345_1.time_ - var_348_1) / var_348_4
				local var_348_6 = Vector3.New(0, -350, -180)

				var_348_0.localPosition = Vector3.Lerp(arg_345_1.var_.moveOldPos10018, var_348_6, var_348_5)
			end

			if arg_345_1.time_ >= var_348_1 + var_348_4 and arg_345_1.time_ < var_348_1 + var_348_4 + arg_348_0 then
				var_348_0.localPosition = Vector3.New(0, -350, -180)
			end

			local var_348_7 = arg_345_1.actors_["10018"]
			local var_348_8 = 0

			if var_348_8 < arg_345_1.time_ and arg_345_1.time_ <= var_348_8 + arg_348_0 and not isNil(var_348_7) and arg_345_1.var_.actorSpriteComps10018 == nil then
				arg_345_1.var_.actorSpriteComps10018 = var_348_7:GetComponentsInChildren(typeof(Image), true)
			end

			local var_348_9 = 0.034

			if var_348_8 <= arg_345_1.time_ and arg_345_1.time_ < var_348_8 + var_348_9 and not isNil(var_348_7) then
				local var_348_10 = (arg_345_1.time_ - var_348_8) / var_348_9

				if arg_345_1.var_.actorSpriteComps10018 then
					for iter_348_1, iter_348_2 in pairs(arg_345_1.var_.actorSpriteComps10018:ToTable()) do
						if iter_348_2 then
							if arg_345_1.isInRecall_ then
								local var_348_11 = Mathf.Lerp(iter_348_2.color.r, arg_345_1.hightColor1.r, var_348_10)
								local var_348_12 = Mathf.Lerp(iter_348_2.color.g, arg_345_1.hightColor1.g, var_348_10)
								local var_348_13 = Mathf.Lerp(iter_348_2.color.b, arg_345_1.hightColor1.b, var_348_10)

								iter_348_2.color = Color.New(var_348_11, var_348_12, var_348_13)
							else
								local var_348_14 = Mathf.Lerp(iter_348_2.color.r, 1, var_348_10)

								iter_348_2.color = Color.New(var_348_14, var_348_14, var_348_14)
							end
						end
					end
				end
			end

			if arg_345_1.time_ >= var_348_8 + var_348_9 and arg_345_1.time_ < var_348_8 + var_348_9 + arg_348_0 and not isNil(var_348_7) and arg_345_1.var_.actorSpriteComps10018 then
				for iter_348_3, iter_348_4 in pairs(arg_345_1.var_.actorSpriteComps10018:ToTable()) do
					if iter_348_4 then
						if arg_345_1.isInRecall_ then
							iter_348_4.color = arg_345_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_348_4.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_345_1.var_.actorSpriteComps10018 = nil
			end

			local var_348_15 = arg_345_1.actors_["10018"]
			local var_348_16 = 0

			if var_348_16 < arg_345_1.time_ and arg_345_1.time_ <= var_348_16 + arg_348_0 then
				local var_348_17 = var_348_15:GetComponentInChildren(typeof(CanvasGroup))

				if var_348_17 then
					arg_345_1.var_.alphaOldValue10018 = var_348_17.alpha
					arg_345_1.var_.characterEffect10018 = var_348_17
				end

				arg_345_1.var_.alphaOldValue10018 = 0
			end

			local var_348_18 = 0.5

			if var_348_16 <= arg_345_1.time_ and arg_345_1.time_ < var_348_16 + var_348_18 then
				local var_348_19 = (arg_345_1.time_ - var_348_16) / var_348_18
				local var_348_20 = Mathf.Lerp(arg_345_1.var_.alphaOldValue10018, 1, var_348_19)

				if arg_345_1.var_.characterEffect10018 then
					arg_345_1.var_.characterEffect10018.alpha = var_348_20
				end
			end

			if arg_345_1.time_ >= var_348_16 + var_348_18 and arg_345_1.time_ < var_348_16 + var_348_18 + arg_348_0 and arg_345_1.var_.characterEffect10018 then
				arg_345_1.var_.characterEffect10018.alpha = 1
			end

			local var_348_21 = 0
			local var_348_22 = 0.3

			if var_348_21 < arg_345_1.time_ and arg_345_1.time_ <= var_348_21 + arg_348_0 then
				arg_345_1.talkMaxDuration = 0
				arg_345_1.dialogCg_.alpha = 1

				arg_345_1.dialog_:SetActive(true)
				SetActive(arg_345_1.leftNameGo_, true)

				local var_348_23 = arg_345_1:FormatText(StoryNameCfg[258].name)

				arg_345_1.leftNameTxt_.text = var_348_23

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_345_1.leftNameTxt_.transform)

				arg_345_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_345_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_345_1:RecordName(arg_345_1.leftNameTxt_.text)
				SetActive(arg_345_1.iconTrs_.gameObject, false)
				arg_345_1.callingController_:SetSelectedState("normal")

				local var_348_24 = arg_345_1:GetWordFromCfg(114251085)
				local var_348_25 = arg_345_1:FormatText(var_348_24.content)

				arg_345_1.text_.text = var_348_25

				LuaForUtil.ClearLinePrefixSymbol(arg_345_1.text_)

				local var_348_26 = 12
				local var_348_27 = utf8.len(var_348_25)
				local var_348_28 = var_348_26 <= 0 and var_348_22 or var_348_22 * (var_348_27 / var_348_26)

				if var_348_28 > 0 and var_348_22 < var_348_28 then
					arg_345_1.talkMaxDuration = var_348_28

					if var_348_28 + var_348_21 > arg_345_1.duration_ then
						arg_345_1.duration_ = var_348_28 + var_348_21
					end
				end

				arg_345_1.text_.text = var_348_25
				arg_345_1.typewritter.percent = 0

				arg_345_1.typewritter:SetDirty()
				arg_345_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_114251", "114251085", "story_v_out_114251.awb") ~= 0 then
					local var_348_29 = manager.audio:GetVoiceLength("story_v_out_114251", "114251085", "story_v_out_114251.awb") / 1000

					if var_348_29 + var_348_21 > arg_345_1.duration_ then
						arg_345_1.duration_ = var_348_29 + var_348_21
					end

					if var_348_24.prefab_name ~= "" and arg_345_1.actors_[var_348_24.prefab_name] ~= nil then
						local var_348_30 = LuaForUtil.PlayVoiceWithCriLipsync(arg_345_1.actors_[var_348_24.prefab_name].transform, "story_v_out_114251", "114251085", "story_v_out_114251.awb")

						arg_345_1:RecordAudio("114251085", var_348_30)
						arg_345_1:RecordAudio("114251085", var_348_30)
					else
						arg_345_1:AudioAction("play", "voice", "story_v_out_114251", "114251085", "story_v_out_114251.awb")
					end

					arg_345_1:RecordHistoryTalkVoice("story_v_out_114251", "114251085", "story_v_out_114251.awb")
				end

				arg_345_1:RecordContent(arg_345_1.text_.text)
			end

			local var_348_31 = math.max(var_348_22, arg_345_1.talkMaxDuration)

			if var_348_21 <= arg_345_1.time_ and arg_345_1.time_ < var_348_21 + var_348_31 then
				arg_345_1.typewritter.percent = (arg_345_1.time_ - var_348_21) / var_348_31

				arg_345_1.typewritter:SetDirty()
			end

			if arg_345_1.time_ >= var_348_21 + var_348_31 and arg_345_1.time_ < var_348_21 + var_348_31 + arg_348_0 then
				arg_345_1.typewritter.percent = 1

				arg_345_1.typewritter:SetDirty()
				arg_345_1:ShowNextGo(true)
			end
		end

		arg_345_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10018",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_345_1:InitPlayNodeList()
	end,
	Play114251086 = function(arg_349_0, arg_349_1)
		arg_349_1.time_ = 0
		arg_349_1.frameCnt_ = 0
		arg_349_1.state_ = "playing"
		arg_349_1.curTalkId_ = 114251086
		arg_349_1.duration_ = 5

		SetActive(arg_349_1.tipsGo_, false)

		function arg_349_1.onSingleLineFinish_()
			arg_349_1.onSingleLineUpdate_ = nil
			arg_349_1.onSingleLineFinish_ = nil
			arg_349_1.state_ = "waiting"
		end

		function arg_349_1.playNext_(arg_351_0)
			if arg_351_0 == 1 then
				arg_349_0:Play114251087(arg_349_1)
			end
		end

		function arg_349_1.onSingleLineUpdate_(arg_352_0)
			local var_352_0 = arg_349_1.actors_["10018"]
			local var_352_1 = 0

			if var_352_1 < arg_349_1.time_ and arg_349_1.time_ <= var_352_1 + arg_352_0 and not isNil(var_352_0) and arg_349_1.var_.actorSpriteComps10018 == nil then
				arg_349_1.var_.actorSpriteComps10018 = var_352_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_352_2 = 0.034

			if var_352_1 <= arg_349_1.time_ and arg_349_1.time_ < var_352_1 + var_352_2 and not isNil(var_352_0) then
				local var_352_3 = (arg_349_1.time_ - var_352_1) / var_352_2

				if arg_349_1.var_.actorSpriteComps10018 then
					for iter_352_0, iter_352_1 in pairs(arg_349_1.var_.actorSpriteComps10018:ToTable()) do
						if iter_352_1 then
							if arg_349_1.isInRecall_ then
								local var_352_4 = Mathf.Lerp(iter_352_1.color.r, arg_349_1.hightColor2.r, var_352_3)
								local var_352_5 = Mathf.Lerp(iter_352_1.color.g, arg_349_1.hightColor2.g, var_352_3)
								local var_352_6 = Mathf.Lerp(iter_352_1.color.b, arg_349_1.hightColor2.b, var_352_3)

								iter_352_1.color = Color.New(var_352_4, var_352_5, var_352_6)
							else
								local var_352_7 = Mathf.Lerp(iter_352_1.color.r, 0.5, var_352_3)

								iter_352_1.color = Color.New(var_352_7, var_352_7, var_352_7)
							end
						end
					end
				end
			end

			if arg_349_1.time_ >= var_352_1 + var_352_2 and arg_349_1.time_ < var_352_1 + var_352_2 + arg_352_0 and not isNil(var_352_0) and arg_349_1.var_.actorSpriteComps10018 then
				for iter_352_2, iter_352_3 in pairs(arg_349_1.var_.actorSpriteComps10018:ToTable()) do
					if iter_352_3 then
						if arg_349_1.isInRecall_ then
							iter_352_3.color = arg_349_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_352_3.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_349_1.var_.actorSpriteComps10018 = nil
			end

			local var_352_8 = 0
			local var_352_9 = 2.3

			if var_352_8 < arg_349_1.time_ and arg_349_1.time_ <= var_352_8 + arg_352_0 then
				arg_349_1.talkMaxDuration = 0
				arg_349_1.dialogCg_.alpha = 1

				arg_349_1.dialog_:SetActive(true)
				SetActive(arg_349_1.leftNameGo_, false)

				arg_349_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_349_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_349_1:RecordName(arg_349_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_349_1.iconTrs_.gameObject, false)
				arg_349_1.callingController_:SetSelectedState("normal")

				local var_352_10 = arg_349_1:GetWordFromCfg(114251086)
				local var_352_11 = arg_349_1:FormatText(var_352_10.content)

				arg_349_1.text_.text = var_352_11

				LuaForUtil.ClearLinePrefixSymbol(arg_349_1.text_)

				local var_352_12 = 92
				local var_352_13 = utf8.len(var_352_11)
				local var_352_14 = var_352_12 <= 0 and var_352_9 or var_352_9 * (var_352_13 / var_352_12)

				if var_352_14 > 0 and var_352_9 < var_352_14 then
					arg_349_1.talkMaxDuration = var_352_14

					if var_352_14 + var_352_8 > arg_349_1.duration_ then
						arg_349_1.duration_ = var_352_14 + var_352_8
					end
				end

				arg_349_1.text_.text = var_352_11
				arg_349_1.typewritter.percent = 0

				arg_349_1.typewritter:SetDirty()
				arg_349_1:ShowNextGo(false)
				arg_349_1:RecordContent(arg_349_1.text_.text)
			end

			local var_352_15 = math.max(var_352_9, arg_349_1.talkMaxDuration)

			if var_352_8 <= arg_349_1.time_ and arg_349_1.time_ < var_352_8 + var_352_15 then
				arg_349_1.typewritter.percent = (arg_349_1.time_ - var_352_8) / var_352_15

				arg_349_1.typewritter:SetDirty()
			end

			if arg_349_1.time_ >= var_352_8 + var_352_15 and arg_349_1.time_ < var_352_8 + var_352_15 + arg_352_0 then
				arg_349_1.typewritter.percent = 1

				arg_349_1.typewritter:SetDirty()
				arg_349_1:ShowNextGo(true)
			end
		end

		arg_349_1.nodeConfigList_ = {}

		arg_349_1:InitPlayNodeList()
	end,
	Play114251087 = function(arg_353_0, arg_353_1)
		arg_353_1.time_ = 0
		arg_353_1.frameCnt_ = 0
		arg_353_1.state_ = "playing"
		arg_353_1.curTalkId_ = 114251087
		arg_353_1.duration_ = 3.67

		local var_353_0 = {
			ja = 2.833,
			ko = 3.666,
			zh = 3.466,
			en = 3.166
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
				arg_353_0:Play114251088(arg_353_1)
			end
		end

		function arg_353_1.onSingleLineUpdate_(arg_356_0)
			local var_356_0 = arg_353_1.actors_["10018"].transform
			local var_356_1 = 0

			if var_356_1 < arg_353_1.time_ and arg_353_1.time_ <= var_356_1 + arg_356_0 then
				arg_353_1.var_.moveOldPos10018 = var_356_0.localPosition
				var_356_0.localScale = Vector3.New(1, 1, 1)

				arg_353_1:CheckSpriteTmpPos("10018", 3)

				local var_356_2 = var_356_0.childCount

				for iter_356_0 = 0, var_356_2 - 1 do
					local var_356_3 = var_356_0:GetChild(iter_356_0)

					if var_356_3.name == "split_1" or not string.find(var_356_3.name, "split") then
						var_356_3.gameObject:SetActive(true)
					else
						var_356_3.gameObject:SetActive(false)
					end
				end
			end

			local var_356_4 = 0.001

			if var_356_1 <= arg_353_1.time_ and arg_353_1.time_ < var_356_1 + var_356_4 then
				local var_356_5 = (arg_353_1.time_ - var_356_1) / var_356_4
				local var_356_6 = Vector3.New(0, -350, -180)

				var_356_0.localPosition = Vector3.Lerp(arg_353_1.var_.moveOldPos10018, var_356_6, var_356_5)
			end

			if arg_353_1.time_ >= var_356_1 + var_356_4 and arg_353_1.time_ < var_356_1 + var_356_4 + arg_356_0 then
				var_356_0.localPosition = Vector3.New(0, -350, -180)
			end

			local var_356_7 = arg_353_1.actors_["10018"]
			local var_356_8 = 0

			if var_356_8 < arg_353_1.time_ and arg_353_1.time_ <= var_356_8 + arg_356_0 and not isNil(var_356_7) and arg_353_1.var_.actorSpriteComps10018 == nil then
				arg_353_1.var_.actorSpriteComps10018 = var_356_7:GetComponentsInChildren(typeof(Image), true)
			end

			local var_356_9 = 0.034

			if var_356_8 <= arg_353_1.time_ and arg_353_1.time_ < var_356_8 + var_356_9 and not isNil(var_356_7) then
				local var_356_10 = (arg_353_1.time_ - var_356_8) / var_356_9

				if arg_353_1.var_.actorSpriteComps10018 then
					for iter_356_1, iter_356_2 in pairs(arg_353_1.var_.actorSpriteComps10018:ToTable()) do
						if iter_356_2 then
							if arg_353_1.isInRecall_ then
								local var_356_11 = Mathf.Lerp(iter_356_2.color.r, arg_353_1.hightColor1.r, var_356_10)
								local var_356_12 = Mathf.Lerp(iter_356_2.color.g, arg_353_1.hightColor1.g, var_356_10)
								local var_356_13 = Mathf.Lerp(iter_356_2.color.b, arg_353_1.hightColor1.b, var_356_10)

								iter_356_2.color = Color.New(var_356_11, var_356_12, var_356_13)
							else
								local var_356_14 = Mathf.Lerp(iter_356_2.color.r, 1, var_356_10)

								iter_356_2.color = Color.New(var_356_14, var_356_14, var_356_14)
							end
						end
					end
				end
			end

			if arg_353_1.time_ >= var_356_8 + var_356_9 and arg_353_1.time_ < var_356_8 + var_356_9 + arg_356_0 and not isNil(var_356_7) and arg_353_1.var_.actorSpriteComps10018 then
				for iter_356_3, iter_356_4 in pairs(arg_353_1.var_.actorSpriteComps10018:ToTable()) do
					if iter_356_4 then
						if arg_353_1.isInRecall_ then
							iter_356_4.color = arg_353_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_356_4.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_353_1.var_.actorSpriteComps10018 = nil
			end

			local var_356_15 = arg_353_1.actors_["10018"]
			local var_356_16 = 0

			if var_356_16 < arg_353_1.time_ and arg_353_1.time_ <= var_356_16 + arg_356_0 then
				local var_356_17 = var_356_15:GetComponentInChildren(typeof(CanvasGroup))

				if var_356_17 then
					arg_353_1.var_.alphaOldValue10018 = var_356_17.alpha
					arg_353_1.var_.characterEffect10018 = var_356_17
				end

				arg_353_1.var_.alphaOldValue10018 = 0
			end

			local var_356_18 = 0.0166666666666667

			if var_356_16 <= arg_353_1.time_ and arg_353_1.time_ < var_356_16 + var_356_18 then
				local var_356_19 = (arg_353_1.time_ - var_356_16) / var_356_18
				local var_356_20 = Mathf.Lerp(arg_353_1.var_.alphaOldValue10018, 1, var_356_19)

				if arg_353_1.var_.characterEffect10018 then
					arg_353_1.var_.characterEffect10018.alpha = var_356_20
				end
			end

			if arg_353_1.time_ >= var_356_16 + var_356_18 and arg_353_1.time_ < var_356_16 + var_356_18 + arg_356_0 and arg_353_1.var_.characterEffect10018 then
				arg_353_1.var_.characterEffect10018.alpha = 1
			end

			local var_356_21 = 0
			local var_356_22 = 0.275

			if var_356_21 < arg_353_1.time_ and arg_353_1.time_ <= var_356_21 + arg_356_0 then
				arg_353_1.talkMaxDuration = 0
				arg_353_1.dialogCg_.alpha = 1

				arg_353_1.dialog_:SetActive(true)
				SetActive(arg_353_1.leftNameGo_, true)

				local var_356_23 = arg_353_1:FormatText(StoryNameCfg[258].name)

				arg_353_1.leftNameTxt_.text = var_356_23

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_353_1.leftNameTxt_.transform)

				arg_353_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_353_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_353_1:RecordName(arg_353_1.leftNameTxt_.text)
				SetActive(arg_353_1.iconTrs_.gameObject, false)
				arg_353_1.callingController_:SetSelectedState("normal")

				local var_356_24 = arg_353_1:GetWordFromCfg(114251087)
				local var_356_25 = arg_353_1:FormatText(var_356_24.content)

				arg_353_1.text_.text = var_356_25

				LuaForUtil.ClearLinePrefixSymbol(arg_353_1.text_)

				local var_356_26 = 11
				local var_356_27 = utf8.len(var_356_25)
				local var_356_28 = var_356_26 <= 0 and var_356_22 or var_356_22 * (var_356_27 / var_356_26)

				if var_356_28 > 0 and var_356_22 < var_356_28 then
					arg_353_1.talkMaxDuration = var_356_28

					if var_356_28 + var_356_21 > arg_353_1.duration_ then
						arg_353_1.duration_ = var_356_28 + var_356_21
					end
				end

				arg_353_1.text_.text = var_356_25
				arg_353_1.typewritter.percent = 0

				arg_353_1.typewritter:SetDirty()
				arg_353_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_114251", "114251087", "story_v_out_114251.awb") ~= 0 then
					local var_356_29 = manager.audio:GetVoiceLength("story_v_out_114251", "114251087", "story_v_out_114251.awb") / 1000

					if var_356_29 + var_356_21 > arg_353_1.duration_ then
						arg_353_1.duration_ = var_356_29 + var_356_21
					end

					if var_356_24.prefab_name ~= "" and arg_353_1.actors_[var_356_24.prefab_name] ~= nil then
						local var_356_30 = LuaForUtil.PlayVoiceWithCriLipsync(arg_353_1.actors_[var_356_24.prefab_name].transform, "story_v_out_114251", "114251087", "story_v_out_114251.awb")

						arg_353_1:RecordAudio("114251087", var_356_30)
						arg_353_1:RecordAudio("114251087", var_356_30)
					else
						arg_353_1:AudioAction("play", "voice", "story_v_out_114251", "114251087", "story_v_out_114251.awb")
					end

					arg_353_1:RecordHistoryTalkVoice("story_v_out_114251", "114251087", "story_v_out_114251.awb")
				end

				arg_353_1:RecordContent(arg_353_1.text_.text)
			end

			local var_356_31 = math.max(var_356_22, arg_353_1.talkMaxDuration)

			if var_356_21 <= arg_353_1.time_ and arg_353_1.time_ < var_356_21 + var_356_31 then
				arg_353_1.typewritter.percent = (arg_353_1.time_ - var_356_21) / var_356_31

				arg_353_1.typewritter:SetDirty()
			end

			if arg_353_1.time_ >= var_356_21 + var_356_31 and arg_353_1.time_ < var_356_21 + var_356_31 + arg_356_0 then
				arg_353_1.typewritter.percent = 1

				arg_353_1.typewritter:SetDirty()
				arg_353_1:ShowNextGo(true)
			end
		end

		arg_353_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10018",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_353_1:InitPlayNodeList()
	end,
	Play114251088 = function(arg_357_0, arg_357_1)
		arg_357_1.time_ = 0
		arg_357_1.frameCnt_ = 0
		arg_357_1.state_ = "playing"
		arg_357_1.curTalkId_ = 114251088
		arg_357_1.duration_ = 5

		SetActive(arg_357_1.tipsGo_, false)

		function arg_357_1.onSingleLineFinish_()
			arg_357_1.onSingleLineUpdate_ = nil
			arg_357_1.onSingleLineFinish_ = nil
			arg_357_1.state_ = "waiting"
		end

		function arg_357_1.playNext_(arg_359_0)
			if arg_359_0 == 1 then
				arg_357_0:Play114251089(arg_357_1)
			end
		end

		function arg_357_1.onSingleLineUpdate_(arg_360_0)
			local var_360_0 = arg_357_1.actors_["10018"]
			local var_360_1 = 0

			if var_360_1 < arg_357_1.time_ and arg_357_1.time_ <= var_360_1 + arg_360_0 and not isNil(var_360_0) and arg_357_1.var_.actorSpriteComps10018 == nil then
				arg_357_1.var_.actorSpriteComps10018 = var_360_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_360_2 = 0.034

			if var_360_1 <= arg_357_1.time_ and arg_357_1.time_ < var_360_1 + var_360_2 and not isNil(var_360_0) then
				local var_360_3 = (arg_357_1.time_ - var_360_1) / var_360_2

				if arg_357_1.var_.actorSpriteComps10018 then
					for iter_360_0, iter_360_1 in pairs(arg_357_1.var_.actorSpriteComps10018:ToTable()) do
						if iter_360_1 then
							if arg_357_1.isInRecall_ then
								local var_360_4 = Mathf.Lerp(iter_360_1.color.r, arg_357_1.hightColor2.r, var_360_3)
								local var_360_5 = Mathf.Lerp(iter_360_1.color.g, arg_357_1.hightColor2.g, var_360_3)
								local var_360_6 = Mathf.Lerp(iter_360_1.color.b, arg_357_1.hightColor2.b, var_360_3)

								iter_360_1.color = Color.New(var_360_4, var_360_5, var_360_6)
							else
								local var_360_7 = Mathf.Lerp(iter_360_1.color.r, 0.5, var_360_3)

								iter_360_1.color = Color.New(var_360_7, var_360_7, var_360_7)
							end
						end
					end
				end
			end

			if arg_357_1.time_ >= var_360_1 + var_360_2 and arg_357_1.time_ < var_360_1 + var_360_2 + arg_360_0 and not isNil(var_360_0) and arg_357_1.var_.actorSpriteComps10018 then
				for iter_360_2, iter_360_3 in pairs(arg_357_1.var_.actorSpriteComps10018:ToTable()) do
					if iter_360_3 then
						if arg_357_1.isInRecall_ then
							iter_360_3.color = arg_357_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_360_3.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_357_1.var_.actorSpriteComps10018 = nil
			end

			local var_360_8 = 0
			local var_360_9 = 0.7

			if var_360_8 < arg_357_1.time_ and arg_357_1.time_ <= var_360_8 + arg_360_0 then
				arg_357_1.talkMaxDuration = 0
				arg_357_1.dialogCg_.alpha = 1

				arg_357_1.dialog_:SetActive(true)
				SetActive(arg_357_1.leftNameGo_, false)

				arg_357_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_357_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_357_1:RecordName(arg_357_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_357_1.iconTrs_.gameObject, false)
				arg_357_1.callingController_:SetSelectedState("normal")

				local var_360_10 = arg_357_1:GetWordFromCfg(114251088)
				local var_360_11 = arg_357_1:FormatText(var_360_10.content)

				arg_357_1.text_.text = var_360_11

				LuaForUtil.ClearLinePrefixSymbol(arg_357_1.text_)

				local var_360_12 = 28
				local var_360_13 = utf8.len(var_360_11)
				local var_360_14 = var_360_12 <= 0 and var_360_9 or var_360_9 * (var_360_13 / var_360_12)

				if var_360_14 > 0 and var_360_9 < var_360_14 then
					arg_357_1.talkMaxDuration = var_360_14

					if var_360_14 + var_360_8 > arg_357_1.duration_ then
						arg_357_1.duration_ = var_360_14 + var_360_8
					end
				end

				arg_357_1.text_.text = var_360_11
				arg_357_1.typewritter.percent = 0

				arg_357_1.typewritter:SetDirty()
				arg_357_1:ShowNextGo(false)
				arg_357_1:RecordContent(arg_357_1.text_.text)
			end

			local var_360_15 = math.max(var_360_9, arg_357_1.talkMaxDuration)

			if var_360_8 <= arg_357_1.time_ and arg_357_1.time_ < var_360_8 + var_360_15 then
				arg_357_1.typewritter.percent = (arg_357_1.time_ - var_360_8) / var_360_15

				arg_357_1.typewritter:SetDirty()
			end

			if arg_357_1.time_ >= var_360_8 + var_360_15 and arg_357_1.time_ < var_360_8 + var_360_15 + arg_360_0 then
				arg_357_1.typewritter.percent = 1

				arg_357_1.typewritter:SetDirty()
				arg_357_1:ShowNextGo(true)
			end
		end

		arg_357_1.nodeConfigList_ = {}

		arg_357_1:InitPlayNodeList()
	end,
	Play114251089 = function(arg_361_0, arg_361_1)
		arg_361_1.time_ = 0
		arg_361_1.frameCnt_ = 0
		arg_361_1.state_ = "playing"
		arg_361_1.curTalkId_ = 114251089
		arg_361_1.duration_ = 5

		SetActive(arg_361_1.tipsGo_, false)

		function arg_361_1.onSingleLineFinish_()
			arg_361_1.onSingleLineUpdate_ = nil
			arg_361_1.onSingleLineFinish_ = nil
			arg_361_1.state_ = "waiting"
		end

		function arg_361_1.playNext_(arg_363_0)
			if arg_363_0 == 1 then
				arg_361_0:Play114251090(arg_361_1)
			end
		end

		function arg_361_1.onSingleLineUpdate_(arg_364_0)
			local var_364_0 = arg_361_1.actors_["10018"]
			local var_364_1 = 0

			if var_364_1 < arg_361_1.time_ and arg_361_1.time_ <= var_364_1 + arg_364_0 then
				local var_364_2 = var_364_0:GetComponentInChildren(typeof(CanvasGroup))

				if var_364_2 then
					arg_361_1.var_.alphaOldValue10018 = var_364_2.alpha
					arg_361_1.var_.characterEffect10018 = var_364_2
				end

				arg_361_1.var_.alphaOldValue10018 = 1
			end

			local var_364_3 = 0.5

			if var_364_1 <= arg_361_1.time_ and arg_361_1.time_ < var_364_1 + var_364_3 then
				local var_364_4 = (arg_361_1.time_ - var_364_1) / var_364_3
				local var_364_5 = Mathf.Lerp(arg_361_1.var_.alphaOldValue10018, 0, var_364_4)

				if arg_361_1.var_.characterEffect10018 then
					arg_361_1.var_.characterEffect10018.alpha = var_364_5
				end
			end

			if arg_361_1.time_ >= var_364_1 + var_364_3 and arg_361_1.time_ < var_364_1 + var_364_3 + arg_364_0 and arg_361_1.var_.characterEffect10018 then
				arg_361_1.var_.characterEffect10018.alpha = 0
			end

			local var_364_6 = 0
			local var_364_7 = 1.075

			if var_364_6 < arg_361_1.time_ and arg_361_1.time_ <= var_364_6 + arg_364_0 then
				arg_361_1.talkMaxDuration = 0
				arg_361_1.dialogCg_.alpha = 1

				arg_361_1.dialog_:SetActive(true)
				SetActive(arg_361_1.leftNameGo_, false)

				arg_361_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_361_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_361_1:RecordName(arg_361_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_361_1.iconTrs_.gameObject, false)
				arg_361_1.callingController_:SetSelectedState("normal")

				local var_364_8 = arg_361_1:GetWordFromCfg(114251089)
				local var_364_9 = arg_361_1:FormatText(var_364_8.content)

				arg_361_1.text_.text = var_364_9

				LuaForUtil.ClearLinePrefixSymbol(arg_361_1.text_)

				local var_364_10 = 43
				local var_364_11 = utf8.len(var_364_9)
				local var_364_12 = var_364_10 <= 0 and var_364_7 or var_364_7 * (var_364_11 / var_364_10)

				if var_364_12 > 0 and var_364_7 < var_364_12 then
					arg_361_1.talkMaxDuration = var_364_12

					if var_364_12 + var_364_6 > arg_361_1.duration_ then
						arg_361_1.duration_ = var_364_12 + var_364_6
					end
				end

				arg_361_1.text_.text = var_364_9
				arg_361_1.typewritter.percent = 0

				arg_361_1.typewritter:SetDirty()
				arg_361_1:ShowNextGo(false)
				arg_361_1:RecordContent(arg_361_1.text_.text)
			end

			local var_364_13 = math.max(var_364_7, arg_361_1.talkMaxDuration)

			if var_364_6 <= arg_361_1.time_ and arg_361_1.time_ < var_364_6 + var_364_13 then
				arg_361_1.typewritter.percent = (arg_361_1.time_ - var_364_6) / var_364_13

				arg_361_1.typewritter:SetDirty()
			end

			if arg_361_1.time_ >= var_364_6 + var_364_13 and arg_361_1.time_ < var_364_6 + var_364_13 + arg_364_0 then
				arg_361_1.typewritter.percent = 1

				arg_361_1.typewritter:SetDirty()
				arg_361_1:ShowNextGo(true)
			end
		end

		arg_361_1.nodeConfigList_ = {}

		arg_361_1:InitPlayNodeList()
	end,
	Play114251090 = function(arg_365_0, arg_365_1)
		arg_365_1.time_ = 0
		arg_365_1.frameCnt_ = 0
		arg_365_1.state_ = "playing"
		arg_365_1.curTalkId_ = 114251090
		arg_365_1.duration_ = 15.5

		local var_365_0 = {
			ja = 15.5,
			ko = 2.8,
			zh = 3.933,
			en = 2.7
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
				arg_365_0:Play114251091(arg_365_1)
			end
		end

		function arg_365_1.onSingleLineUpdate_(arg_368_0)
			local var_368_0 = 0
			local var_368_1 = 0.25

			if var_368_0 < arg_365_1.time_ and arg_365_1.time_ <= var_368_0 + arg_368_0 then
				arg_365_1.talkMaxDuration = 0
				arg_365_1.dialogCg_.alpha = 1

				arg_365_1.dialog_:SetActive(true)
				SetActive(arg_365_1.leftNameGo_, true)

				local var_368_2 = arg_365_1:FormatText(StoryNameCfg[226].name)

				arg_365_1.leftNameTxt_.text = var_368_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_365_1.leftNameTxt_.transform)

				arg_365_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_365_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_365_1:RecordName(arg_365_1.leftNameTxt_.text)
				SetActive(arg_365_1.iconTrs_.gameObject, true)
				arg_365_1.iconController_:SetSelectedState("hero")

				arg_365_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_10021")

				arg_365_1.callingController_:SetSelectedState("normal")

				arg_365_1.keyicon_.color = Color.New(1, 1, 1)
				arg_365_1.icon_.color = Color.New(1, 1, 1)

				local var_368_3 = arg_365_1:GetWordFromCfg(114251090)
				local var_368_4 = arg_365_1:FormatText(var_368_3.content)

				arg_365_1.text_.text = var_368_4

				LuaForUtil.ClearLinePrefixSymbol(arg_365_1.text_)

				local var_368_5 = 10
				local var_368_6 = utf8.len(var_368_4)
				local var_368_7 = var_368_5 <= 0 and var_368_1 or var_368_1 * (var_368_6 / var_368_5)

				if var_368_7 > 0 and var_368_1 < var_368_7 then
					arg_365_1.talkMaxDuration = var_368_7

					if var_368_7 + var_368_0 > arg_365_1.duration_ then
						arg_365_1.duration_ = var_368_7 + var_368_0
					end
				end

				arg_365_1.text_.text = var_368_4
				arg_365_1.typewritter.percent = 0

				arg_365_1.typewritter:SetDirty()
				arg_365_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_114251", "114251090", "story_v_out_114251.awb") ~= 0 then
					local var_368_8 = manager.audio:GetVoiceLength("story_v_out_114251", "114251090", "story_v_out_114251.awb") / 1000

					if var_368_8 + var_368_0 > arg_365_1.duration_ then
						arg_365_1.duration_ = var_368_8 + var_368_0
					end

					if var_368_3.prefab_name ~= "" and arg_365_1.actors_[var_368_3.prefab_name] ~= nil then
						local var_368_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_365_1.actors_[var_368_3.prefab_name].transform, "story_v_out_114251", "114251090", "story_v_out_114251.awb")

						arg_365_1:RecordAudio("114251090", var_368_9)
						arg_365_1:RecordAudio("114251090", var_368_9)
					else
						arg_365_1:AudioAction("play", "voice", "story_v_out_114251", "114251090", "story_v_out_114251.awb")
					end

					arg_365_1:RecordHistoryTalkVoice("story_v_out_114251", "114251090", "story_v_out_114251.awb")
				end

				arg_365_1:RecordContent(arg_365_1.text_.text)
			end

			local var_368_10 = math.max(var_368_1, arg_365_1.talkMaxDuration)

			if var_368_0 <= arg_365_1.time_ and arg_365_1.time_ < var_368_0 + var_368_10 then
				arg_365_1.typewritter.percent = (arg_365_1.time_ - var_368_0) / var_368_10

				arg_365_1.typewritter:SetDirty()
			end

			if arg_365_1.time_ >= var_368_0 + var_368_10 and arg_365_1.time_ < var_368_0 + var_368_10 + arg_368_0 then
				arg_365_1.typewritter.percent = 1

				arg_365_1.typewritter:SetDirty()
				arg_365_1:ShowNextGo(true)
			end
		end

		arg_365_1.nodeConfigList_ = {}

		arg_365_1:InitPlayNodeList()
	end,
	Play114251091 = function(arg_369_0, arg_369_1)
		arg_369_1.time_ = 0
		arg_369_1.frameCnt_ = 0
		arg_369_1.state_ = "playing"
		arg_369_1.curTalkId_ = 114251091
		arg_369_1.duration_ = 2.33

		local var_369_0 = {
			ja = 2.333,
			ko = 1.533,
			zh = 0.999999999999,
			en = 1.233
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
				arg_369_0:Play114251092(arg_369_1)
			end
		end

		function arg_369_1.onSingleLineUpdate_(arg_372_0)
			local var_372_0 = arg_369_1.actors_["10018"]
			local var_372_1 = 0

			if var_372_1 < arg_369_1.time_ and arg_369_1.time_ <= var_372_1 + arg_372_0 and not isNil(var_372_0) and arg_369_1.var_.actorSpriteComps10018 == nil then
				arg_369_1.var_.actorSpriteComps10018 = var_372_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_372_2 = 0.034

			if var_372_1 <= arg_369_1.time_ and arg_369_1.time_ < var_372_1 + var_372_2 and not isNil(var_372_0) then
				local var_372_3 = (arg_369_1.time_ - var_372_1) / var_372_2

				if arg_369_1.var_.actorSpriteComps10018 then
					for iter_372_0, iter_372_1 in pairs(arg_369_1.var_.actorSpriteComps10018:ToTable()) do
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

			if arg_369_1.time_ >= var_372_1 + var_372_2 and arg_369_1.time_ < var_372_1 + var_372_2 + arg_372_0 and not isNil(var_372_0) and arg_369_1.var_.actorSpriteComps10018 then
				for iter_372_2, iter_372_3 in pairs(arg_369_1.var_.actorSpriteComps10018:ToTable()) do
					if iter_372_3 then
						if arg_369_1.isInRecall_ then
							iter_372_3.color = arg_369_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_372_3.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_369_1.var_.actorSpriteComps10018 = nil
			end

			local var_372_8 = 0
			local var_372_9 = 0.05

			if var_372_8 < arg_369_1.time_ and arg_369_1.time_ <= var_372_8 + arg_372_0 then
				arg_369_1.talkMaxDuration = 0
				arg_369_1.dialogCg_.alpha = 1

				arg_369_1.dialog_:SetActive(true)
				SetActive(arg_369_1.leftNameGo_, true)

				local var_372_10 = arg_369_1:FormatText(StoryNameCfg[258].name)

				arg_369_1.leftNameTxt_.text = var_372_10

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_369_1.leftNameTxt_.transform)

				arg_369_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_369_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_369_1:RecordName(arg_369_1.leftNameTxt_.text)
				SetActive(arg_369_1.iconTrs_.gameObject, true)
				arg_369_1.iconController_:SetSelectedState("hero")

				arg_369_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_10018")

				arg_369_1.callingController_:SetSelectedState("normal")

				arg_369_1.keyicon_.color = Color.New(1, 1, 1)
				arg_369_1.icon_.color = Color.New(1, 1, 1)

				local var_372_11 = arg_369_1:GetWordFromCfg(114251091)
				local var_372_12 = arg_369_1:FormatText(var_372_11.content)

				arg_369_1.text_.text = var_372_12

				LuaForUtil.ClearLinePrefixSymbol(arg_369_1.text_)

				local var_372_13 = 2
				local var_372_14 = utf8.len(var_372_12)
				local var_372_15 = var_372_13 <= 0 and var_372_9 or var_372_9 * (var_372_14 / var_372_13)

				if var_372_15 > 0 and var_372_9 < var_372_15 then
					arg_369_1.talkMaxDuration = var_372_15

					if var_372_15 + var_372_8 > arg_369_1.duration_ then
						arg_369_1.duration_ = var_372_15 + var_372_8
					end
				end

				arg_369_1.text_.text = var_372_12
				arg_369_1.typewritter.percent = 0

				arg_369_1.typewritter:SetDirty()
				arg_369_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_114251", "114251091", "story_v_out_114251.awb") ~= 0 then
					local var_372_16 = manager.audio:GetVoiceLength("story_v_out_114251", "114251091", "story_v_out_114251.awb") / 1000

					if var_372_16 + var_372_8 > arg_369_1.duration_ then
						arg_369_1.duration_ = var_372_16 + var_372_8
					end

					if var_372_11.prefab_name ~= "" and arg_369_1.actors_[var_372_11.prefab_name] ~= nil then
						local var_372_17 = LuaForUtil.PlayVoiceWithCriLipsync(arg_369_1.actors_[var_372_11.prefab_name].transform, "story_v_out_114251", "114251091", "story_v_out_114251.awb")

						arg_369_1:RecordAudio("114251091", var_372_17)
						arg_369_1:RecordAudio("114251091", var_372_17)
					else
						arg_369_1:AudioAction("play", "voice", "story_v_out_114251", "114251091", "story_v_out_114251.awb")
					end

					arg_369_1:RecordHistoryTalkVoice("story_v_out_114251", "114251091", "story_v_out_114251.awb")
				end

				arg_369_1:RecordContent(arg_369_1.text_.text)
			end

			local var_372_18 = math.max(var_372_9, arg_369_1.talkMaxDuration)

			if var_372_8 <= arg_369_1.time_ and arg_369_1.time_ < var_372_8 + var_372_18 then
				arg_369_1.typewritter.percent = (arg_369_1.time_ - var_372_8) / var_372_18

				arg_369_1.typewritter:SetDirty()
			end

			if arg_369_1.time_ >= var_372_8 + var_372_18 and arg_369_1.time_ < var_372_8 + var_372_18 + arg_372_0 then
				arg_369_1.typewritter.percent = 1

				arg_369_1.typewritter:SetDirty()
				arg_369_1:ShowNextGo(true)
			end
		end

		arg_369_1.nodeConfigList_ = {}

		arg_369_1:InitPlayNodeList()
	end,
	Play114251092 = function(arg_373_0, arg_373_1)
		arg_373_1.time_ = 0
		arg_373_1.frameCnt_ = 0
		arg_373_1.state_ = "playing"
		arg_373_1.curTalkId_ = 114251092
		arg_373_1.duration_ = 6.13

		local var_373_0 = {
			ja = 4.633,
			ko = 6.133,
			zh = 5.9,
			en = 5.6
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
				arg_373_0:Play114251093(arg_373_1)
			end
		end

		function arg_373_1.onSingleLineUpdate_(arg_376_0)
			local var_376_0 = 0
			local var_376_1 = 0.6

			if var_376_0 < arg_373_1.time_ and arg_373_1.time_ <= var_376_0 + arg_376_0 then
				arg_373_1.talkMaxDuration = 0
				arg_373_1.dialogCg_.alpha = 1

				arg_373_1.dialog_:SetActive(true)
				SetActive(arg_373_1.leftNameGo_, true)

				local var_376_2 = arg_373_1:FormatText(StoryNameCfg[258].name)

				arg_373_1.leftNameTxt_.text = var_376_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_373_1.leftNameTxt_.transform)

				arg_373_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_373_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_373_1:RecordName(arg_373_1.leftNameTxt_.text)
				SetActive(arg_373_1.iconTrs_.gameObject, true)
				arg_373_1.iconController_:SetSelectedState("hero")

				arg_373_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_10018")

				arg_373_1.callingController_:SetSelectedState("normal")

				arg_373_1.keyicon_.color = Color.New(1, 1, 1)
				arg_373_1.icon_.color = Color.New(1, 1, 1)

				local var_376_3 = arg_373_1:GetWordFromCfg(114251092)
				local var_376_4 = arg_373_1:FormatText(var_376_3.content)

				arg_373_1.text_.text = var_376_4

				LuaForUtil.ClearLinePrefixSymbol(arg_373_1.text_)

				local var_376_5 = 24
				local var_376_6 = utf8.len(var_376_4)
				local var_376_7 = var_376_5 <= 0 and var_376_1 or var_376_1 * (var_376_6 / var_376_5)

				if var_376_7 > 0 and var_376_1 < var_376_7 then
					arg_373_1.talkMaxDuration = var_376_7

					if var_376_7 + var_376_0 > arg_373_1.duration_ then
						arg_373_1.duration_ = var_376_7 + var_376_0
					end
				end

				arg_373_1.text_.text = var_376_4
				arg_373_1.typewritter.percent = 0

				arg_373_1.typewritter:SetDirty()
				arg_373_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_114251", "114251092", "story_v_out_114251.awb") ~= 0 then
					local var_376_8 = manager.audio:GetVoiceLength("story_v_out_114251", "114251092", "story_v_out_114251.awb") / 1000

					if var_376_8 + var_376_0 > arg_373_1.duration_ then
						arg_373_1.duration_ = var_376_8 + var_376_0
					end

					if var_376_3.prefab_name ~= "" and arg_373_1.actors_[var_376_3.prefab_name] ~= nil then
						local var_376_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_373_1.actors_[var_376_3.prefab_name].transform, "story_v_out_114251", "114251092", "story_v_out_114251.awb")

						arg_373_1:RecordAudio("114251092", var_376_9)
						arg_373_1:RecordAudio("114251092", var_376_9)
					else
						arg_373_1:AudioAction("play", "voice", "story_v_out_114251", "114251092", "story_v_out_114251.awb")
					end

					arg_373_1:RecordHistoryTalkVoice("story_v_out_114251", "114251092", "story_v_out_114251.awb")
				end

				arg_373_1:RecordContent(arg_373_1.text_.text)
			end

			local var_376_10 = math.max(var_376_1, arg_373_1.talkMaxDuration)

			if var_376_0 <= arg_373_1.time_ and arg_373_1.time_ < var_376_0 + var_376_10 then
				arg_373_1.typewritter.percent = (arg_373_1.time_ - var_376_0) / var_376_10

				arg_373_1.typewritter:SetDirty()
			end

			if arg_373_1.time_ >= var_376_0 + var_376_10 and arg_373_1.time_ < var_376_0 + var_376_10 + arg_376_0 then
				arg_373_1.typewritter.percent = 1

				arg_373_1.typewritter:SetDirty()
				arg_373_1:ShowNextGo(true)
			end
		end

		arg_373_1.nodeConfigList_ = {}

		arg_373_1:InitPlayNodeList()
	end,
	Play114251093 = function(arg_377_0, arg_377_1)
		arg_377_1.time_ = 0
		arg_377_1.frameCnt_ = 0
		arg_377_1.state_ = "playing"
		arg_377_1.curTalkId_ = 114251093
		arg_377_1.duration_ = 18.2

		local var_377_0 = {
			ja = 16.2,
			ko = 17.633,
			zh = 16.7,
			en = 18.2
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
				arg_377_0:Play114251094(arg_377_1)
			end
		end

		function arg_377_1.onSingleLineUpdate_(arg_380_0)
			local var_380_0 = 1.999999999999

			if var_380_0 < arg_377_1.time_ and arg_377_1.time_ <= var_380_0 + arg_380_0 then
				local var_380_1 = manager.ui.mainCamera.transform.localPosition
				local var_380_2 = Vector3.New(0, 0, 10) + Vector3.New(var_380_1.x, var_380_1.y, 0)
				local var_380_3 = arg_377_1.bgs_.ST24

				var_380_3.transform.localPosition = var_380_2
				var_380_3.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_380_4 = var_380_3:GetComponent("SpriteRenderer")

				if var_380_4 and var_380_4.sprite then
					local var_380_5 = (var_380_3.transform.localPosition - var_380_1).z
					local var_380_6 = manager.ui.mainCameraCom_
					local var_380_7 = 2 * var_380_5 * Mathf.Tan(var_380_6.fieldOfView * 0.5 * Mathf.Deg2Rad)
					local var_380_8 = var_380_7 * var_380_6.aspect
					local var_380_9 = var_380_4.sprite.bounds.size.x
					local var_380_10 = var_380_4.sprite.bounds.size.y
					local var_380_11 = var_380_8 / var_380_9
					local var_380_12 = var_380_7 / var_380_10
					local var_380_13 = var_380_12 < var_380_11 and var_380_11 or var_380_12

					var_380_3.transform.localScale = Vector3.New(var_380_13, var_380_13, 0)
				end

				for iter_380_0, iter_380_1 in pairs(arg_377_1.bgs_) do
					if iter_380_0 ~= "ST24" then
						iter_380_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_380_14 = 0

			if var_380_14 < arg_377_1.time_ and arg_377_1.time_ <= var_380_14 + arg_380_0 then
				arg_377_1.mask_.enabled = true
				arg_377_1.mask_.raycastTarget = true

				arg_377_1:SetGaussion(false)
			end

			local var_380_15 = 2

			if var_380_14 <= arg_377_1.time_ and arg_377_1.time_ < var_380_14 + var_380_15 then
				local var_380_16 = (arg_377_1.time_ - var_380_14) / var_380_15
				local var_380_17 = Color.New(0, 0, 0)

				var_380_17.a = Mathf.Lerp(0, 1, var_380_16)
				arg_377_1.mask_.color = var_380_17
			end

			if arg_377_1.time_ >= var_380_14 + var_380_15 and arg_377_1.time_ < var_380_14 + var_380_15 + arg_380_0 then
				local var_380_18 = Color.New(0, 0, 0)

				var_380_18.a = 1
				arg_377_1.mask_.color = var_380_18
			end

			local var_380_19 = 2

			if var_380_19 < arg_377_1.time_ and arg_377_1.time_ <= var_380_19 + arg_380_0 then
				arg_377_1.mask_.enabled = true
				arg_377_1.mask_.raycastTarget = true

				arg_377_1:SetGaussion(false)
			end

			local var_380_20 = 2

			if var_380_19 <= arg_377_1.time_ and arg_377_1.time_ < var_380_19 + var_380_20 then
				local var_380_21 = (arg_377_1.time_ - var_380_19) / var_380_20
				local var_380_22 = Color.New(0, 0, 0)

				var_380_22.a = Mathf.Lerp(1, 0, var_380_21)
				arg_377_1.mask_.color = var_380_22
			end

			if arg_377_1.time_ >= var_380_19 + var_380_20 and arg_377_1.time_ < var_380_19 + var_380_20 + arg_380_0 then
				local var_380_23 = Color.New(0, 0, 0)
				local var_380_24 = 0

				arg_377_1.mask_.enabled = false
				var_380_23.a = var_380_24
				arg_377_1.mask_.color = var_380_23
			end

			local var_380_25 = arg_377_1.actors_["10018"].transform
			local var_380_26 = 3.8

			if var_380_26 < arg_377_1.time_ and arg_377_1.time_ <= var_380_26 + arg_380_0 then
				arg_377_1.var_.moveOldPos10018 = var_380_25.localPosition
				var_380_25.localScale = Vector3.New(1, 1, 1)

				arg_377_1:CheckSpriteTmpPos("10018", 2)

				local var_380_27 = var_380_25.childCount

				for iter_380_2 = 0, var_380_27 - 1 do
					local var_380_28 = var_380_25:GetChild(iter_380_2)

					if var_380_28.name == "split_1" or not string.find(var_380_28.name, "split") then
						var_380_28.gameObject:SetActive(true)
					else
						var_380_28.gameObject:SetActive(false)
					end
				end
			end

			local var_380_29 = 0.001

			if var_380_26 <= arg_377_1.time_ and arg_377_1.time_ < var_380_26 + var_380_29 then
				local var_380_30 = (arg_377_1.time_ - var_380_26) / var_380_29
				local var_380_31 = Vector3.New(-390, -350, -180)

				var_380_25.localPosition = Vector3.Lerp(arg_377_1.var_.moveOldPos10018, var_380_31, var_380_30)
			end

			if arg_377_1.time_ >= var_380_26 + var_380_29 and arg_377_1.time_ < var_380_26 + var_380_29 + arg_380_0 then
				var_380_25.localPosition = Vector3.New(-390, -350, -180)
			end

			local var_380_32 = arg_377_1.actors_["10018"].transform
			local var_380_33 = 1.966

			if var_380_33 < arg_377_1.time_ and arg_377_1.time_ <= var_380_33 + arg_380_0 then
				arg_377_1.var_.moveOldPos10018 = var_380_32.localPosition
				var_380_32.localScale = Vector3.New(1, 1, 1)

				arg_377_1:CheckSpriteTmpPos("10018", 7)

				local var_380_34 = var_380_32.childCount

				for iter_380_3 = 0, var_380_34 - 1 do
					local var_380_35 = var_380_32:GetChild(iter_380_3)

					if var_380_35.name == "split_1" or not string.find(var_380_35.name, "split") then
						var_380_35.gameObject:SetActive(true)
					else
						var_380_35.gameObject:SetActive(false)
					end
				end
			end

			local var_380_36 = 0.001

			if var_380_33 <= arg_377_1.time_ and arg_377_1.time_ < var_380_33 + var_380_36 then
				local var_380_37 = (arg_377_1.time_ - var_380_33) / var_380_36
				local var_380_38 = Vector3.New(0, -2000, -180)

				var_380_32.localPosition = Vector3.Lerp(arg_377_1.var_.moveOldPos10018, var_380_38, var_380_37)
			end

			if arg_377_1.time_ >= var_380_33 + var_380_36 and arg_377_1.time_ < var_380_33 + var_380_36 + arg_380_0 then
				var_380_32.localPosition = Vector3.New(0, -2000, -180)
			end

			local var_380_39 = arg_377_1.actors_["10018"]
			local var_380_40 = 3.8

			if var_380_40 < arg_377_1.time_ and arg_377_1.time_ <= var_380_40 + arg_380_0 and not isNil(var_380_39) and arg_377_1.var_.actorSpriteComps10018 == nil then
				arg_377_1.var_.actorSpriteComps10018 = var_380_39:GetComponentsInChildren(typeof(Image), true)
			end

			local var_380_41 = 0.034

			if var_380_40 <= arg_377_1.time_ and arg_377_1.time_ < var_380_40 + var_380_41 and not isNil(var_380_39) then
				local var_380_42 = (arg_377_1.time_ - var_380_40) / var_380_41

				if arg_377_1.var_.actorSpriteComps10018 then
					for iter_380_4, iter_380_5 in pairs(arg_377_1.var_.actorSpriteComps10018:ToTable()) do
						if iter_380_5 then
							if arg_377_1.isInRecall_ then
								local var_380_43 = Mathf.Lerp(iter_380_5.color.r, arg_377_1.hightColor1.r, var_380_42)
								local var_380_44 = Mathf.Lerp(iter_380_5.color.g, arg_377_1.hightColor1.g, var_380_42)
								local var_380_45 = Mathf.Lerp(iter_380_5.color.b, arg_377_1.hightColor1.b, var_380_42)

								iter_380_5.color = Color.New(var_380_43, var_380_44, var_380_45)
							else
								local var_380_46 = Mathf.Lerp(iter_380_5.color.r, 1, var_380_42)

								iter_380_5.color = Color.New(var_380_46, var_380_46, var_380_46)
							end
						end
					end
				end
			end

			if arg_377_1.time_ >= var_380_40 + var_380_41 and arg_377_1.time_ < var_380_40 + var_380_41 + arg_380_0 and not isNil(var_380_39) and arg_377_1.var_.actorSpriteComps10018 then
				for iter_380_6, iter_380_7 in pairs(arg_377_1.var_.actorSpriteComps10018:ToTable()) do
					if iter_380_7 then
						if arg_377_1.isInRecall_ then
							iter_380_7.color = arg_377_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_380_7.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_377_1.var_.actorSpriteComps10018 = nil
			end

			local var_380_47 = arg_377_1.actors_["10018"]
			local var_380_48 = 3.8

			if var_380_48 < arg_377_1.time_ and arg_377_1.time_ <= var_380_48 + arg_380_0 then
				local var_380_49 = var_380_47:GetComponentInChildren(typeof(CanvasGroup))

				if var_380_49 then
					arg_377_1.var_.alphaOldValue10018 = var_380_49.alpha
					arg_377_1.var_.characterEffect10018 = var_380_49
				end

				arg_377_1.var_.alphaOldValue10018 = 0
			end

			local var_380_50 = 0.5

			if var_380_48 <= arg_377_1.time_ and arg_377_1.time_ < var_380_48 + var_380_50 then
				local var_380_51 = (arg_377_1.time_ - var_380_48) / var_380_50
				local var_380_52 = Mathf.Lerp(arg_377_1.var_.alphaOldValue10018, 1, var_380_51)

				if arg_377_1.var_.characterEffect10018 then
					arg_377_1.var_.characterEffect10018.alpha = var_380_52
				end
			end

			if arg_377_1.time_ >= var_380_48 + var_380_50 and arg_377_1.time_ < var_380_48 + var_380_50 + arg_380_0 and arg_377_1.var_.characterEffect10018 then
				arg_377_1.var_.characterEffect10018.alpha = 1
			end

			if arg_377_1.frameCnt_ <= 1 then
				arg_377_1.dialog_:SetActive(false)
			end

			local var_380_53 = 4
			local var_380_54 = 1.225

			if var_380_53 < arg_377_1.time_ and arg_377_1.time_ <= var_380_53 + arg_380_0 then
				arg_377_1.talkMaxDuration = 0

				arg_377_1.dialog_:SetActive(true)

				arg_377_1.dialogCg_.alpha = 0

				local var_380_55 = LeanTween.value(arg_377_1.dialog_, 0, 1, 0.3)

				var_380_55:setOnUpdate(LuaHelper.FloatAction(function(arg_381_0)
					arg_377_1.dialogCg_.alpha = arg_381_0
				end))
				var_380_55:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_377_1.dialog_)
					var_380_55:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_377_1.duration_ = arg_377_1.duration_ + 0.3

				SetActive(arg_377_1.leftNameGo_, true)

				local var_380_56 = arg_377_1:FormatText(StoryNameCfg[257].name)

				arg_377_1.leftNameTxt_.text = var_380_56

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_377_1.leftNameTxt_.transform)

				arg_377_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_377_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_377_1:RecordName(arg_377_1.leftNameTxt_.text)
				SetActive(arg_377_1.iconTrs_.gameObject, false)
				arg_377_1.callingController_:SetSelectedState("normal")

				local var_380_57 = arg_377_1:GetWordFromCfg(114251093)
				local var_380_58 = arg_377_1:FormatText(var_380_57.content)

				arg_377_1.text_.text = var_380_58

				LuaForUtil.ClearLinePrefixSymbol(arg_377_1.text_)

				local var_380_59 = 49
				local var_380_60 = utf8.len(var_380_58)
				local var_380_61 = var_380_59 <= 0 and var_380_54 or var_380_54 * (var_380_60 / var_380_59)

				if var_380_61 > 0 and var_380_54 < var_380_61 then
					arg_377_1.talkMaxDuration = var_380_61
					var_380_53 = var_380_53 + 0.3

					if var_380_61 + var_380_53 > arg_377_1.duration_ then
						arg_377_1.duration_ = var_380_61 + var_380_53
					end
				end

				arg_377_1.text_.text = var_380_58
				arg_377_1.typewritter.percent = 0

				arg_377_1.typewritter:SetDirty()
				arg_377_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_114251", "114251093", "story_v_out_114251.awb") ~= 0 then
					local var_380_62 = manager.audio:GetVoiceLength("story_v_out_114251", "114251093", "story_v_out_114251.awb") / 1000

					if var_380_62 + var_380_53 > arg_377_1.duration_ then
						arg_377_1.duration_ = var_380_62 + var_380_53
					end

					if var_380_57.prefab_name ~= "" and arg_377_1.actors_[var_380_57.prefab_name] ~= nil then
						local var_380_63 = LuaForUtil.PlayVoiceWithCriLipsync(arg_377_1.actors_[var_380_57.prefab_name].transform, "story_v_out_114251", "114251093", "story_v_out_114251.awb")

						arg_377_1:RecordAudio("114251093", var_380_63)
						arg_377_1:RecordAudio("114251093", var_380_63)
					else
						arg_377_1:AudioAction("play", "voice", "story_v_out_114251", "114251093", "story_v_out_114251.awb")
					end

					arg_377_1:RecordHistoryTalkVoice("story_v_out_114251", "114251093", "story_v_out_114251.awb")
				end

				arg_377_1:RecordContent(arg_377_1.text_.text)
			end

			local var_380_64 = var_380_53 + 0.3
			local var_380_65 = math.max(var_380_54, arg_377_1.talkMaxDuration)

			if var_380_64 <= arg_377_1.time_ and arg_377_1.time_ < var_380_64 + var_380_65 then
				arg_377_1.typewritter.percent = (arg_377_1.time_ - var_380_64) / var_380_65

				arg_377_1.typewritter:SetDirty()
			end

			if arg_377_1.time_ >= var_380_64 + var_380_65 and arg_377_1.time_ < var_380_64 + var_380_65 + arg_380_0 then
				arg_377_1.typewritter.percent = 1

				arg_377_1.typewritter:SetDirty()
				arg_377_1:ShowNextGo(true)
			end
		end

		arg_377_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10018",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 3.8,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			},
			{
				assetPath = "",
				actorName = "10018",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 1.966,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_377_1:InitPlayNodeList()
	end,
	Play114251094 = function(arg_383_0, arg_383_1)
		arg_383_1.time_ = 0
		arg_383_1.frameCnt_ = 0
		arg_383_1.state_ = "playing"
		arg_383_1.curTalkId_ = 114251094
		arg_383_1.duration_ = 7.67

		local var_383_0 = {
			ja = 7.5,
			ko = 7.366,
			zh = 7.666,
			en = 3.433
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
				arg_383_0:Play114251095(arg_383_1)
			end
		end

		function arg_383_1.onSingleLineUpdate_(arg_386_0)
			local var_386_0 = arg_383_1.actors_["10015"].transform
			local var_386_1 = 0

			if var_386_1 < arg_383_1.time_ and arg_383_1.time_ <= var_386_1 + arg_386_0 then
				arg_383_1.var_.moveOldPos10015 = var_386_0.localPosition
				var_386_0.localScale = Vector3.New(1, 1, 1)

				arg_383_1:CheckSpriteTmpPos("10015", 4)

				local var_386_2 = var_386_0.childCount

				for iter_386_0 = 0, var_386_2 - 1 do
					local var_386_3 = var_386_0:GetChild(iter_386_0)

					if var_386_3.name == "split_1" or not string.find(var_386_3.name, "split") then
						var_386_3.gameObject:SetActive(true)
					else
						var_386_3.gameObject:SetActive(false)
					end
				end
			end

			local var_386_4 = 0.001

			if var_386_1 <= arg_383_1.time_ and arg_383_1.time_ < var_386_1 + var_386_4 then
				local var_386_5 = (arg_383_1.time_ - var_386_1) / var_386_4
				local var_386_6 = Vector3.New(390, -350, -180)

				var_386_0.localPosition = Vector3.Lerp(arg_383_1.var_.moveOldPos10015, var_386_6, var_386_5)
			end

			if arg_383_1.time_ >= var_386_1 + var_386_4 and arg_383_1.time_ < var_386_1 + var_386_4 + arg_386_0 then
				var_386_0.localPosition = Vector3.New(390, -350, -180)
			end

			local var_386_7 = arg_383_1.actors_["10018"]
			local var_386_8 = 0

			if var_386_8 < arg_383_1.time_ and arg_383_1.time_ <= var_386_8 + arg_386_0 and not isNil(var_386_7) and arg_383_1.var_.actorSpriteComps10018 == nil then
				arg_383_1.var_.actorSpriteComps10018 = var_386_7:GetComponentsInChildren(typeof(Image), true)
			end

			local var_386_9 = 0.034

			if var_386_8 <= arg_383_1.time_ and arg_383_1.time_ < var_386_8 + var_386_9 and not isNil(var_386_7) then
				local var_386_10 = (arg_383_1.time_ - var_386_8) / var_386_9

				if arg_383_1.var_.actorSpriteComps10018 then
					for iter_386_1, iter_386_2 in pairs(arg_383_1.var_.actorSpriteComps10018:ToTable()) do
						if iter_386_2 then
							if arg_383_1.isInRecall_ then
								local var_386_11 = Mathf.Lerp(iter_386_2.color.r, arg_383_1.hightColor2.r, var_386_10)
								local var_386_12 = Mathf.Lerp(iter_386_2.color.g, arg_383_1.hightColor2.g, var_386_10)
								local var_386_13 = Mathf.Lerp(iter_386_2.color.b, arg_383_1.hightColor2.b, var_386_10)

								iter_386_2.color = Color.New(var_386_11, var_386_12, var_386_13)
							else
								local var_386_14 = Mathf.Lerp(iter_386_2.color.r, 0.5, var_386_10)

								iter_386_2.color = Color.New(var_386_14, var_386_14, var_386_14)
							end
						end
					end
				end
			end

			if arg_383_1.time_ >= var_386_8 + var_386_9 and arg_383_1.time_ < var_386_8 + var_386_9 + arg_386_0 and not isNil(var_386_7) and arg_383_1.var_.actorSpriteComps10018 then
				for iter_386_3, iter_386_4 in pairs(arg_383_1.var_.actorSpriteComps10018:ToTable()) do
					if iter_386_4 then
						if arg_383_1.isInRecall_ then
							iter_386_4.color = arg_383_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_386_4.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_383_1.var_.actorSpriteComps10018 = nil
			end

			local var_386_15 = arg_383_1.actors_["10015"]
			local var_386_16 = 0

			if var_386_16 < arg_383_1.time_ and arg_383_1.time_ <= var_386_16 + arg_386_0 and not isNil(var_386_15) and arg_383_1.var_.actorSpriteComps10015 == nil then
				arg_383_1.var_.actorSpriteComps10015 = var_386_15:GetComponentsInChildren(typeof(Image), true)
			end

			local var_386_17 = 0.034

			if var_386_16 <= arg_383_1.time_ and arg_383_1.time_ < var_386_16 + var_386_17 and not isNil(var_386_15) then
				local var_386_18 = (arg_383_1.time_ - var_386_16) / var_386_17

				if arg_383_1.var_.actorSpriteComps10015 then
					for iter_386_5, iter_386_6 in pairs(arg_383_1.var_.actorSpriteComps10015:ToTable()) do
						if iter_386_6 then
							if arg_383_1.isInRecall_ then
								local var_386_19 = Mathf.Lerp(iter_386_6.color.r, arg_383_1.hightColor1.r, var_386_18)
								local var_386_20 = Mathf.Lerp(iter_386_6.color.g, arg_383_1.hightColor1.g, var_386_18)
								local var_386_21 = Mathf.Lerp(iter_386_6.color.b, arg_383_1.hightColor1.b, var_386_18)

								iter_386_6.color = Color.New(var_386_19, var_386_20, var_386_21)
							else
								local var_386_22 = Mathf.Lerp(iter_386_6.color.r, 1, var_386_18)

								iter_386_6.color = Color.New(var_386_22, var_386_22, var_386_22)
							end
						end
					end
				end
			end

			if arg_383_1.time_ >= var_386_16 + var_386_17 and arg_383_1.time_ < var_386_16 + var_386_17 + arg_386_0 and not isNil(var_386_15) and arg_383_1.var_.actorSpriteComps10015 then
				for iter_386_7, iter_386_8 in pairs(arg_383_1.var_.actorSpriteComps10015:ToTable()) do
					if iter_386_8 then
						if arg_383_1.isInRecall_ then
							iter_386_8.color = arg_383_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_386_8.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_383_1.var_.actorSpriteComps10015 = nil
			end

			local var_386_23 = arg_383_1.actors_["10015"]
			local var_386_24 = 0

			if var_386_24 < arg_383_1.time_ and arg_383_1.time_ <= var_386_24 + arg_386_0 then
				local var_386_25 = var_386_23:GetComponentInChildren(typeof(CanvasGroup))

				if var_386_25 then
					arg_383_1.var_.alphaOldValue10015 = var_386_25.alpha
					arg_383_1.var_.characterEffect10015 = var_386_25
				end

				arg_383_1.var_.alphaOldValue10015 = 0
			end

			local var_386_26 = 0.5

			if var_386_24 <= arg_383_1.time_ and arg_383_1.time_ < var_386_24 + var_386_26 then
				local var_386_27 = (arg_383_1.time_ - var_386_24) / var_386_26
				local var_386_28 = Mathf.Lerp(arg_383_1.var_.alphaOldValue10015, 1, var_386_27)

				if arg_383_1.var_.characterEffect10015 then
					arg_383_1.var_.characterEffect10015.alpha = var_386_28
				end
			end

			if arg_383_1.time_ >= var_386_24 + var_386_26 and arg_383_1.time_ < var_386_24 + var_386_26 + arg_386_0 and arg_383_1.var_.characterEffect10015 then
				arg_383_1.var_.characterEffect10015.alpha = 1
			end

			local var_386_29 = 0
			local var_386_30 = 0.85

			if var_386_29 < arg_383_1.time_ and arg_383_1.time_ <= var_386_29 + arg_386_0 then
				arg_383_1.talkMaxDuration = 0
				arg_383_1.dialogCg_.alpha = 1

				arg_383_1.dialog_:SetActive(true)
				SetActive(arg_383_1.leftNameGo_, true)

				local var_386_31 = arg_383_1:FormatText(StoryNameCfg[208].name)

				arg_383_1.leftNameTxt_.text = var_386_31

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_383_1.leftNameTxt_.transform)

				arg_383_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_383_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_383_1:RecordName(arg_383_1.leftNameTxt_.text)
				SetActive(arg_383_1.iconTrs_.gameObject, false)
				arg_383_1.callingController_:SetSelectedState("normal")

				local var_386_32 = arg_383_1:GetWordFromCfg(114251094)
				local var_386_33 = arg_383_1:FormatText(var_386_32.content)

				arg_383_1.text_.text = var_386_33

				LuaForUtil.ClearLinePrefixSymbol(arg_383_1.text_)

				local var_386_34 = 34
				local var_386_35 = utf8.len(var_386_33)
				local var_386_36 = var_386_34 <= 0 and var_386_30 or var_386_30 * (var_386_35 / var_386_34)

				if var_386_36 > 0 and var_386_30 < var_386_36 then
					arg_383_1.talkMaxDuration = var_386_36

					if var_386_36 + var_386_29 > arg_383_1.duration_ then
						arg_383_1.duration_ = var_386_36 + var_386_29
					end
				end

				arg_383_1.text_.text = var_386_33
				arg_383_1.typewritter.percent = 0

				arg_383_1.typewritter:SetDirty()
				arg_383_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_114251", "114251094", "story_v_out_114251.awb") ~= 0 then
					local var_386_37 = manager.audio:GetVoiceLength("story_v_out_114251", "114251094", "story_v_out_114251.awb") / 1000

					if var_386_37 + var_386_29 > arg_383_1.duration_ then
						arg_383_1.duration_ = var_386_37 + var_386_29
					end

					if var_386_32.prefab_name ~= "" and arg_383_1.actors_[var_386_32.prefab_name] ~= nil then
						local var_386_38 = LuaForUtil.PlayVoiceWithCriLipsync(arg_383_1.actors_[var_386_32.prefab_name].transform, "story_v_out_114251", "114251094", "story_v_out_114251.awb")

						arg_383_1:RecordAudio("114251094", var_386_38)
						arg_383_1:RecordAudio("114251094", var_386_38)
					else
						arg_383_1:AudioAction("play", "voice", "story_v_out_114251", "114251094", "story_v_out_114251.awb")
					end

					arg_383_1:RecordHistoryTalkVoice("story_v_out_114251", "114251094", "story_v_out_114251.awb")
				end

				arg_383_1:RecordContent(arg_383_1.text_.text)
			end

			local var_386_39 = math.max(var_386_30, arg_383_1.talkMaxDuration)

			if var_386_29 <= arg_383_1.time_ and arg_383_1.time_ < var_386_29 + var_386_39 then
				arg_383_1.typewritter.percent = (arg_383_1.time_ - var_386_29) / var_386_39

				arg_383_1.typewritter:SetDirty()
			end

			if arg_383_1.time_ >= var_386_29 + var_386_39 and arg_383_1.time_ < var_386_29 + var_386_39 + arg_386_0 then
				arg_383_1.typewritter.percent = 1

				arg_383_1.typewritter:SetDirty()
				arg_383_1:ShowNextGo(true)
			end
		end

		arg_383_1.nodeConfigList_ = {
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

		arg_383_1:InitPlayNodeList()
	end,
	Play114251095 = function(arg_387_0, arg_387_1)
		arg_387_1.time_ = 0
		arg_387_1.frameCnt_ = 0
		arg_387_1.state_ = "playing"
		arg_387_1.curTalkId_ = 114251095
		arg_387_1.duration_ = 16.67

		local var_387_0 = {
			ja = 16.666,
			ko = 14.133,
			zh = 15.566,
			en = 13.466
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
				arg_387_0:Play114251096(arg_387_1)
			end
		end

		function arg_387_1.onSingleLineUpdate_(arg_390_0)
			local var_390_0 = arg_387_1.actors_["10018"]
			local var_390_1 = 0

			if var_390_1 < arg_387_1.time_ and arg_387_1.time_ <= var_390_1 + arg_390_0 and not isNil(var_390_0) and arg_387_1.var_.actorSpriteComps10018 == nil then
				arg_387_1.var_.actorSpriteComps10018 = var_390_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_390_2 = 0.034

			if var_390_1 <= arg_387_1.time_ and arg_387_1.time_ < var_390_1 + var_390_2 and not isNil(var_390_0) then
				local var_390_3 = (arg_387_1.time_ - var_390_1) / var_390_2

				if arg_387_1.var_.actorSpriteComps10018 then
					for iter_390_0, iter_390_1 in pairs(arg_387_1.var_.actorSpriteComps10018:ToTable()) do
						if iter_390_1 then
							if arg_387_1.isInRecall_ then
								local var_390_4 = Mathf.Lerp(iter_390_1.color.r, arg_387_1.hightColor1.r, var_390_3)
								local var_390_5 = Mathf.Lerp(iter_390_1.color.g, arg_387_1.hightColor1.g, var_390_3)
								local var_390_6 = Mathf.Lerp(iter_390_1.color.b, arg_387_1.hightColor1.b, var_390_3)

								iter_390_1.color = Color.New(var_390_4, var_390_5, var_390_6)
							else
								local var_390_7 = Mathf.Lerp(iter_390_1.color.r, 1, var_390_3)

								iter_390_1.color = Color.New(var_390_7, var_390_7, var_390_7)
							end
						end
					end
				end
			end

			if arg_387_1.time_ >= var_390_1 + var_390_2 and arg_387_1.time_ < var_390_1 + var_390_2 + arg_390_0 and not isNil(var_390_0) and arg_387_1.var_.actorSpriteComps10018 then
				for iter_390_2, iter_390_3 in pairs(arg_387_1.var_.actorSpriteComps10018:ToTable()) do
					if iter_390_3 then
						if arg_387_1.isInRecall_ then
							iter_390_3.color = arg_387_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_390_3.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_387_1.var_.actorSpriteComps10018 = nil
			end

			local var_390_8 = arg_387_1.actors_["10015"]
			local var_390_9 = 0

			if var_390_9 < arg_387_1.time_ and arg_387_1.time_ <= var_390_9 + arg_390_0 and not isNil(var_390_8) and arg_387_1.var_.actorSpriteComps10015 == nil then
				arg_387_1.var_.actorSpriteComps10015 = var_390_8:GetComponentsInChildren(typeof(Image), true)
			end

			local var_390_10 = 0.034

			if var_390_9 <= arg_387_1.time_ and arg_387_1.time_ < var_390_9 + var_390_10 and not isNil(var_390_8) then
				local var_390_11 = (arg_387_1.time_ - var_390_9) / var_390_10

				if arg_387_1.var_.actorSpriteComps10015 then
					for iter_390_4, iter_390_5 in pairs(arg_387_1.var_.actorSpriteComps10015:ToTable()) do
						if iter_390_5 then
							if arg_387_1.isInRecall_ then
								local var_390_12 = Mathf.Lerp(iter_390_5.color.r, arg_387_1.hightColor2.r, var_390_11)
								local var_390_13 = Mathf.Lerp(iter_390_5.color.g, arg_387_1.hightColor2.g, var_390_11)
								local var_390_14 = Mathf.Lerp(iter_390_5.color.b, arg_387_1.hightColor2.b, var_390_11)

								iter_390_5.color = Color.New(var_390_12, var_390_13, var_390_14)
							else
								local var_390_15 = Mathf.Lerp(iter_390_5.color.r, 0.5, var_390_11)

								iter_390_5.color = Color.New(var_390_15, var_390_15, var_390_15)
							end
						end
					end
				end
			end

			if arg_387_1.time_ >= var_390_9 + var_390_10 and arg_387_1.time_ < var_390_9 + var_390_10 + arg_390_0 and not isNil(var_390_8) and arg_387_1.var_.actorSpriteComps10015 then
				for iter_390_6, iter_390_7 in pairs(arg_387_1.var_.actorSpriteComps10015:ToTable()) do
					if iter_390_7 then
						if arg_387_1.isInRecall_ then
							iter_390_7.color = arg_387_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_390_7.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_387_1.var_.actorSpriteComps10015 = nil
			end

			local var_390_16 = 0
			local var_390_17 = 1.775

			if var_390_16 < arg_387_1.time_ and arg_387_1.time_ <= var_390_16 + arg_390_0 then
				arg_387_1.talkMaxDuration = 0
				arg_387_1.dialogCg_.alpha = 1

				arg_387_1.dialog_:SetActive(true)
				SetActive(arg_387_1.leftNameGo_, true)

				local var_390_18 = arg_387_1:FormatText(StoryNameCfg[257].name)

				arg_387_1.leftNameTxt_.text = var_390_18

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_387_1.leftNameTxt_.transform)

				arg_387_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_387_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_387_1:RecordName(arg_387_1.leftNameTxt_.text)
				SetActive(arg_387_1.iconTrs_.gameObject, false)
				arg_387_1.callingController_:SetSelectedState("normal")

				local var_390_19 = arg_387_1:GetWordFromCfg(114251095)
				local var_390_20 = arg_387_1:FormatText(var_390_19.content)

				arg_387_1.text_.text = var_390_20

				LuaForUtil.ClearLinePrefixSymbol(arg_387_1.text_)

				local var_390_21 = 71
				local var_390_22 = utf8.len(var_390_20)
				local var_390_23 = var_390_21 <= 0 and var_390_17 or var_390_17 * (var_390_22 / var_390_21)

				if var_390_23 > 0 and var_390_17 < var_390_23 then
					arg_387_1.talkMaxDuration = var_390_23

					if var_390_23 + var_390_16 > arg_387_1.duration_ then
						arg_387_1.duration_ = var_390_23 + var_390_16
					end
				end

				arg_387_1.text_.text = var_390_20
				arg_387_1.typewritter.percent = 0

				arg_387_1.typewritter:SetDirty()
				arg_387_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_114251", "114251095", "story_v_out_114251.awb") ~= 0 then
					local var_390_24 = manager.audio:GetVoiceLength("story_v_out_114251", "114251095", "story_v_out_114251.awb") / 1000

					if var_390_24 + var_390_16 > arg_387_1.duration_ then
						arg_387_1.duration_ = var_390_24 + var_390_16
					end

					if var_390_19.prefab_name ~= "" and arg_387_1.actors_[var_390_19.prefab_name] ~= nil then
						local var_390_25 = LuaForUtil.PlayVoiceWithCriLipsync(arg_387_1.actors_[var_390_19.prefab_name].transform, "story_v_out_114251", "114251095", "story_v_out_114251.awb")

						arg_387_1:RecordAudio("114251095", var_390_25)
						arg_387_1:RecordAudio("114251095", var_390_25)
					else
						arg_387_1:AudioAction("play", "voice", "story_v_out_114251", "114251095", "story_v_out_114251.awb")
					end

					arg_387_1:RecordHistoryTalkVoice("story_v_out_114251", "114251095", "story_v_out_114251.awb")
				end

				arg_387_1:RecordContent(arg_387_1.text_.text)
			end

			local var_390_26 = math.max(var_390_17, arg_387_1.talkMaxDuration)

			if var_390_16 <= arg_387_1.time_ and arg_387_1.time_ < var_390_16 + var_390_26 then
				arg_387_1.typewritter.percent = (arg_387_1.time_ - var_390_16) / var_390_26

				arg_387_1.typewritter:SetDirty()
			end

			if arg_387_1.time_ >= var_390_16 + var_390_26 and arg_387_1.time_ < var_390_16 + var_390_26 + arg_390_0 then
				arg_387_1.typewritter.percent = 1

				arg_387_1.typewritter:SetDirty()
				arg_387_1:ShowNextGo(true)
			end
		end

		arg_387_1.nodeConfigList_ = {}

		arg_387_1:InitPlayNodeList()
	end,
	Play114251096 = function(arg_391_0, arg_391_1)
		arg_391_1.time_ = 0
		arg_391_1.frameCnt_ = 0
		arg_391_1.state_ = "playing"
		arg_391_1.curTalkId_ = 114251096
		arg_391_1.duration_ = 12.87

		local var_391_0 = {
			ja = 11.166,
			ko = 12.866,
			zh = 9.233,
			en = 10.133
		}
		local var_391_1 = manager.audio:GetLocalizationFlag()

		if var_391_0[var_391_1] ~= nil then
			arg_391_1.duration_ = var_391_0[var_391_1]
		end

		SetActive(arg_391_1.tipsGo_, false)

		function arg_391_1.onSingleLineFinish_()
			arg_391_1.onSingleLineUpdate_ = nil
			arg_391_1.onSingleLineFinish_ = nil
			arg_391_1.state_ = "waiting"
		end

		function arg_391_1.playNext_(arg_393_0)
			if arg_393_0 == 1 then
				arg_391_0:Play114251097(arg_391_1)
			end
		end

		function arg_391_1.onSingleLineUpdate_(arg_394_0)
			local var_394_0 = 0
			local var_394_1 = 1.025

			if var_394_0 < arg_391_1.time_ and arg_391_1.time_ <= var_394_0 + arg_394_0 then
				arg_391_1.talkMaxDuration = 0
				arg_391_1.dialogCg_.alpha = 1

				arg_391_1.dialog_:SetActive(true)
				SetActive(arg_391_1.leftNameGo_, true)

				local var_394_2 = arg_391_1:FormatText(StoryNameCfg[257].name)

				arg_391_1.leftNameTxt_.text = var_394_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_391_1.leftNameTxt_.transform)

				arg_391_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_391_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_391_1:RecordName(arg_391_1.leftNameTxt_.text)
				SetActive(arg_391_1.iconTrs_.gameObject, false)
				arg_391_1.callingController_:SetSelectedState("normal")

				local var_394_3 = arg_391_1:GetWordFromCfg(114251096)
				local var_394_4 = arg_391_1:FormatText(var_394_3.content)

				arg_391_1.text_.text = var_394_4

				LuaForUtil.ClearLinePrefixSymbol(arg_391_1.text_)

				local var_394_5 = 41
				local var_394_6 = utf8.len(var_394_4)
				local var_394_7 = var_394_5 <= 0 and var_394_1 or var_394_1 * (var_394_6 / var_394_5)

				if var_394_7 > 0 and var_394_1 < var_394_7 then
					arg_391_1.talkMaxDuration = var_394_7

					if var_394_7 + var_394_0 > arg_391_1.duration_ then
						arg_391_1.duration_ = var_394_7 + var_394_0
					end
				end

				arg_391_1.text_.text = var_394_4
				arg_391_1.typewritter.percent = 0

				arg_391_1.typewritter:SetDirty()
				arg_391_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_114251", "114251096", "story_v_out_114251.awb") ~= 0 then
					local var_394_8 = manager.audio:GetVoiceLength("story_v_out_114251", "114251096", "story_v_out_114251.awb") / 1000

					if var_394_8 + var_394_0 > arg_391_1.duration_ then
						arg_391_1.duration_ = var_394_8 + var_394_0
					end

					if var_394_3.prefab_name ~= "" and arg_391_1.actors_[var_394_3.prefab_name] ~= nil then
						local var_394_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_391_1.actors_[var_394_3.prefab_name].transform, "story_v_out_114251", "114251096", "story_v_out_114251.awb")

						arg_391_1:RecordAudio("114251096", var_394_9)
						arg_391_1:RecordAudio("114251096", var_394_9)
					else
						arg_391_1:AudioAction("play", "voice", "story_v_out_114251", "114251096", "story_v_out_114251.awb")
					end

					arg_391_1:RecordHistoryTalkVoice("story_v_out_114251", "114251096", "story_v_out_114251.awb")
				end

				arg_391_1:RecordContent(arg_391_1.text_.text)
			end

			local var_394_10 = math.max(var_394_1, arg_391_1.talkMaxDuration)

			if var_394_0 <= arg_391_1.time_ and arg_391_1.time_ < var_394_0 + var_394_10 then
				arg_391_1.typewritter.percent = (arg_391_1.time_ - var_394_0) / var_394_10

				arg_391_1.typewritter:SetDirty()
			end

			if arg_391_1.time_ >= var_394_0 + var_394_10 and arg_391_1.time_ < var_394_0 + var_394_10 + arg_394_0 then
				arg_391_1.typewritter.percent = 1

				arg_391_1.typewritter:SetDirty()
				arg_391_1:ShowNextGo(true)
			end
		end

		arg_391_1.nodeConfigList_ = {}

		arg_391_1:InitPlayNodeList()
	end,
	Play114251097 = function(arg_395_0, arg_395_1)
		arg_395_1.time_ = 0
		arg_395_1.frameCnt_ = 0
		arg_395_1.state_ = "playing"
		arg_395_1.curTalkId_ = 114251097
		arg_395_1.duration_ = 13.5

		local var_395_0 = {
			ja = 13.5,
			ko = 11.966,
			zh = 11.5,
			en = 10.2
		}
		local var_395_1 = manager.audio:GetLocalizationFlag()

		if var_395_0[var_395_1] ~= nil then
			arg_395_1.duration_ = var_395_0[var_395_1]
		end

		SetActive(arg_395_1.tipsGo_, false)

		function arg_395_1.onSingleLineFinish_()
			arg_395_1.onSingleLineUpdate_ = nil
			arg_395_1.onSingleLineFinish_ = nil
			arg_395_1.state_ = "waiting"
		end

		function arg_395_1.playNext_(arg_397_0)
			if arg_397_0 == 1 then
				arg_395_0:Play114251098(arg_395_1)
			end
		end

		function arg_395_1.onSingleLineUpdate_(arg_398_0)
			local var_398_0 = 0
			local var_398_1 = 1.275

			if var_398_0 < arg_395_1.time_ and arg_395_1.time_ <= var_398_0 + arg_398_0 then
				arg_395_1.talkMaxDuration = 0
				arg_395_1.dialogCg_.alpha = 1

				arg_395_1.dialog_:SetActive(true)
				SetActive(arg_395_1.leftNameGo_, true)

				local var_398_2 = arg_395_1:FormatText(StoryNameCfg[257].name)

				arg_395_1.leftNameTxt_.text = var_398_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_395_1.leftNameTxt_.transform)

				arg_395_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_395_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_395_1:RecordName(arg_395_1.leftNameTxt_.text)
				SetActive(arg_395_1.iconTrs_.gameObject, false)
				arg_395_1.callingController_:SetSelectedState("normal")

				local var_398_3 = arg_395_1:GetWordFromCfg(114251097)
				local var_398_4 = arg_395_1:FormatText(var_398_3.content)

				arg_395_1.text_.text = var_398_4

				LuaForUtil.ClearLinePrefixSymbol(arg_395_1.text_)

				local var_398_5 = 51
				local var_398_6 = utf8.len(var_398_4)
				local var_398_7 = var_398_5 <= 0 and var_398_1 or var_398_1 * (var_398_6 / var_398_5)

				if var_398_7 > 0 and var_398_1 < var_398_7 then
					arg_395_1.talkMaxDuration = var_398_7

					if var_398_7 + var_398_0 > arg_395_1.duration_ then
						arg_395_1.duration_ = var_398_7 + var_398_0
					end
				end

				arg_395_1.text_.text = var_398_4
				arg_395_1.typewritter.percent = 0

				arg_395_1.typewritter:SetDirty()
				arg_395_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_114251", "114251097", "story_v_out_114251.awb") ~= 0 then
					local var_398_8 = manager.audio:GetVoiceLength("story_v_out_114251", "114251097", "story_v_out_114251.awb") / 1000

					if var_398_8 + var_398_0 > arg_395_1.duration_ then
						arg_395_1.duration_ = var_398_8 + var_398_0
					end

					if var_398_3.prefab_name ~= "" and arg_395_1.actors_[var_398_3.prefab_name] ~= nil then
						local var_398_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_395_1.actors_[var_398_3.prefab_name].transform, "story_v_out_114251", "114251097", "story_v_out_114251.awb")

						arg_395_1:RecordAudio("114251097", var_398_9)
						arg_395_1:RecordAudio("114251097", var_398_9)
					else
						arg_395_1:AudioAction("play", "voice", "story_v_out_114251", "114251097", "story_v_out_114251.awb")
					end

					arg_395_1:RecordHistoryTalkVoice("story_v_out_114251", "114251097", "story_v_out_114251.awb")
				end

				arg_395_1:RecordContent(arg_395_1.text_.text)
			end

			local var_398_10 = math.max(var_398_1, arg_395_1.talkMaxDuration)

			if var_398_0 <= arg_395_1.time_ and arg_395_1.time_ < var_398_0 + var_398_10 then
				arg_395_1.typewritter.percent = (arg_395_1.time_ - var_398_0) / var_398_10

				arg_395_1.typewritter:SetDirty()
			end

			if arg_395_1.time_ >= var_398_0 + var_398_10 and arg_395_1.time_ < var_398_0 + var_398_10 + arg_398_0 then
				arg_395_1.typewritter.percent = 1

				arg_395_1.typewritter:SetDirty()
				arg_395_1:ShowNextGo(true)
			end
		end

		arg_395_1.nodeConfigList_ = {}

		arg_395_1:InitPlayNodeList()
	end,
	Play114251098 = function(arg_399_0, arg_399_1)
		arg_399_1.time_ = 0
		arg_399_1.frameCnt_ = 0
		arg_399_1.state_ = "playing"
		arg_399_1.curTalkId_ = 114251098
		arg_399_1.duration_ = 5.4

		local var_399_0 = {
			ja = 5.4,
			ko = 4.433,
			zh = 4.6,
			en = 2.666
		}
		local var_399_1 = manager.audio:GetLocalizationFlag()

		if var_399_0[var_399_1] ~= nil then
			arg_399_1.duration_ = var_399_0[var_399_1]
		end

		SetActive(arg_399_1.tipsGo_, false)

		function arg_399_1.onSingleLineFinish_()
			arg_399_1.onSingleLineUpdate_ = nil
			arg_399_1.onSingleLineFinish_ = nil
			arg_399_1.state_ = "waiting"
		end

		function arg_399_1.playNext_(arg_401_0)
			if arg_401_0 == 1 then
				arg_399_0:Play114251099(arg_399_1)
			end
		end

		function arg_399_1.onSingleLineUpdate_(arg_402_0)
			local var_402_0 = arg_399_1.actors_["10015"]
			local var_402_1 = 0

			if var_402_1 < arg_399_1.time_ and arg_399_1.time_ <= var_402_1 + arg_402_0 and not isNil(var_402_0) and arg_399_1.var_.actorSpriteComps10015 == nil then
				arg_399_1.var_.actorSpriteComps10015 = var_402_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_402_2 = 0.034

			if var_402_1 <= arg_399_1.time_ and arg_399_1.time_ < var_402_1 + var_402_2 and not isNil(var_402_0) then
				local var_402_3 = (arg_399_1.time_ - var_402_1) / var_402_2

				if arg_399_1.var_.actorSpriteComps10015 then
					for iter_402_0, iter_402_1 in pairs(arg_399_1.var_.actorSpriteComps10015:ToTable()) do
						if iter_402_1 then
							if arg_399_1.isInRecall_ then
								local var_402_4 = Mathf.Lerp(iter_402_1.color.r, arg_399_1.hightColor1.r, var_402_3)
								local var_402_5 = Mathf.Lerp(iter_402_1.color.g, arg_399_1.hightColor1.g, var_402_3)
								local var_402_6 = Mathf.Lerp(iter_402_1.color.b, arg_399_1.hightColor1.b, var_402_3)

								iter_402_1.color = Color.New(var_402_4, var_402_5, var_402_6)
							else
								local var_402_7 = Mathf.Lerp(iter_402_1.color.r, 1, var_402_3)

								iter_402_1.color = Color.New(var_402_7, var_402_7, var_402_7)
							end
						end
					end
				end
			end

			if arg_399_1.time_ >= var_402_1 + var_402_2 and arg_399_1.time_ < var_402_1 + var_402_2 + arg_402_0 and not isNil(var_402_0) and arg_399_1.var_.actorSpriteComps10015 then
				for iter_402_2, iter_402_3 in pairs(arg_399_1.var_.actorSpriteComps10015:ToTable()) do
					if iter_402_3 then
						if arg_399_1.isInRecall_ then
							iter_402_3.color = arg_399_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_402_3.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_399_1.var_.actorSpriteComps10015 = nil
			end

			local var_402_8 = arg_399_1.actors_["10018"]
			local var_402_9 = 0

			if var_402_9 < arg_399_1.time_ and arg_399_1.time_ <= var_402_9 + arg_402_0 and not isNil(var_402_8) and arg_399_1.var_.actorSpriteComps10018 == nil then
				arg_399_1.var_.actorSpriteComps10018 = var_402_8:GetComponentsInChildren(typeof(Image), true)
			end

			local var_402_10 = 0.034

			if var_402_9 <= arg_399_1.time_ and arg_399_1.time_ < var_402_9 + var_402_10 and not isNil(var_402_8) then
				local var_402_11 = (arg_399_1.time_ - var_402_9) / var_402_10

				if arg_399_1.var_.actorSpriteComps10018 then
					for iter_402_4, iter_402_5 in pairs(arg_399_1.var_.actorSpriteComps10018:ToTable()) do
						if iter_402_5 then
							if arg_399_1.isInRecall_ then
								local var_402_12 = Mathf.Lerp(iter_402_5.color.r, arg_399_1.hightColor2.r, var_402_11)
								local var_402_13 = Mathf.Lerp(iter_402_5.color.g, arg_399_1.hightColor2.g, var_402_11)
								local var_402_14 = Mathf.Lerp(iter_402_5.color.b, arg_399_1.hightColor2.b, var_402_11)

								iter_402_5.color = Color.New(var_402_12, var_402_13, var_402_14)
							else
								local var_402_15 = Mathf.Lerp(iter_402_5.color.r, 0.5, var_402_11)

								iter_402_5.color = Color.New(var_402_15, var_402_15, var_402_15)
							end
						end
					end
				end
			end

			if arg_399_1.time_ >= var_402_9 + var_402_10 and arg_399_1.time_ < var_402_9 + var_402_10 + arg_402_0 and not isNil(var_402_8) and arg_399_1.var_.actorSpriteComps10018 then
				for iter_402_6, iter_402_7 in pairs(arg_399_1.var_.actorSpriteComps10018:ToTable()) do
					if iter_402_7 then
						if arg_399_1.isInRecall_ then
							iter_402_7.color = arg_399_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_402_7.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_399_1.var_.actorSpriteComps10018 = nil
			end

			local var_402_16 = 0
			local var_402_17 = 0.45

			if var_402_16 < arg_399_1.time_ and arg_399_1.time_ <= var_402_16 + arg_402_0 then
				arg_399_1.talkMaxDuration = 0
				arg_399_1.dialogCg_.alpha = 1

				arg_399_1.dialog_:SetActive(true)
				SetActive(arg_399_1.leftNameGo_, true)

				local var_402_18 = arg_399_1:FormatText(StoryNameCfg[208].name)

				arg_399_1.leftNameTxt_.text = var_402_18

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_399_1.leftNameTxt_.transform)

				arg_399_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_399_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_399_1:RecordName(arg_399_1.leftNameTxt_.text)
				SetActive(arg_399_1.iconTrs_.gameObject, false)
				arg_399_1.callingController_:SetSelectedState("normal")

				local var_402_19 = arg_399_1:GetWordFromCfg(114251098)
				local var_402_20 = arg_399_1:FormatText(var_402_19.content)

				arg_399_1.text_.text = var_402_20

				LuaForUtil.ClearLinePrefixSymbol(arg_399_1.text_)

				local var_402_21 = 18
				local var_402_22 = utf8.len(var_402_20)
				local var_402_23 = var_402_21 <= 0 and var_402_17 or var_402_17 * (var_402_22 / var_402_21)

				if var_402_23 > 0 and var_402_17 < var_402_23 then
					arg_399_1.talkMaxDuration = var_402_23

					if var_402_23 + var_402_16 > arg_399_1.duration_ then
						arg_399_1.duration_ = var_402_23 + var_402_16
					end
				end

				arg_399_1.text_.text = var_402_20
				arg_399_1.typewritter.percent = 0

				arg_399_1.typewritter:SetDirty()
				arg_399_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_114251", "114251098", "story_v_out_114251.awb") ~= 0 then
					local var_402_24 = manager.audio:GetVoiceLength("story_v_out_114251", "114251098", "story_v_out_114251.awb") / 1000

					if var_402_24 + var_402_16 > arg_399_1.duration_ then
						arg_399_1.duration_ = var_402_24 + var_402_16
					end

					if var_402_19.prefab_name ~= "" and arg_399_1.actors_[var_402_19.prefab_name] ~= nil then
						local var_402_25 = LuaForUtil.PlayVoiceWithCriLipsync(arg_399_1.actors_[var_402_19.prefab_name].transform, "story_v_out_114251", "114251098", "story_v_out_114251.awb")

						arg_399_1:RecordAudio("114251098", var_402_25)
						arg_399_1:RecordAudio("114251098", var_402_25)
					else
						arg_399_1:AudioAction("play", "voice", "story_v_out_114251", "114251098", "story_v_out_114251.awb")
					end

					arg_399_1:RecordHistoryTalkVoice("story_v_out_114251", "114251098", "story_v_out_114251.awb")
				end

				arg_399_1:RecordContent(arg_399_1.text_.text)
			end

			local var_402_26 = math.max(var_402_17, arg_399_1.talkMaxDuration)

			if var_402_16 <= arg_399_1.time_ and arg_399_1.time_ < var_402_16 + var_402_26 then
				arg_399_1.typewritter.percent = (arg_399_1.time_ - var_402_16) / var_402_26

				arg_399_1.typewritter:SetDirty()
			end

			if arg_399_1.time_ >= var_402_16 + var_402_26 and arg_399_1.time_ < var_402_16 + var_402_26 + arg_402_0 then
				arg_399_1.typewritter.percent = 1

				arg_399_1.typewritter:SetDirty()
				arg_399_1:ShowNextGo(true)
			end
		end

		arg_399_1.nodeConfigList_ = {}

		arg_399_1:InitPlayNodeList()
	end,
	Play114251099 = function(arg_403_0, arg_403_1)
		arg_403_1.time_ = 0
		arg_403_1.frameCnt_ = 0
		arg_403_1.state_ = "playing"
		arg_403_1.curTalkId_ = 114251099
		arg_403_1.duration_ = 13.5

		local var_403_0 = {
			ja = 13.5,
			ko = 13.233,
			zh = 11.433,
			en = 13.233
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
				arg_403_0:Play114251100(arg_403_1)
			end
		end

		function arg_403_1.onSingleLineUpdate_(arg_406_0)
			local var_406_0 = arg_403_1.actors_["10018"]
			local var_406_1 = 0

			if var_406_1 < arg_403_1.time_ and arg_403_1.time_ <= var_406_1 + arg_406_0 and not isNil(var_406_0) and arg_403_1.var_.actorSpriteComps10018 == nil then
				arg_403_1.var_.actorSpriteComps10018 = var_406_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_406_2 = 0.034

			if var_406_1 <= arg_403_1.time_ and arg_403_1.time_ < var_406_1 + var_406_2 and not isNil(var_406_0) then
				local var_406_3 = (arg_403_1.time_ - var_406_1) / var_406_2

				if arg_403_1.var_.actorSpriteComps10018 then
					for iter_406_0, iter_406_1 in pairs(arg_403_1.var_.actorSpriteComps10018:ToTable()) do
						if iter_406_1 then
							if arg_403_1.isInRecall_ then
								local var_406_4 = Mathf.Lerp(iter_406_1.color.r, arg_403_1.hightColor1.r, var_406_3)
								local var_406_5 = Mathf.Lerp(iter_406_1.color.g, arg_403_1.hightColor1.g, var_406_3)
								local var_406_6 = Mathf.Lerp(iter_406_1.color.b, arg_403_1.hightColor1.b, var_406_3)

								iter_406_1.color = Color.New(var_406_4, var_406_5, var_406_6)
							else
								local var_406_7 = Mathf.Lerp(iter_406_1.color.r, 1, var_406_3)

								iter_406_1.color = Color.New(var_406_7, var_406_7, var_406_7)
							end
						end
					end
				end
			end

			if arg_403_1.time_ >= var_406_1 + var_406_2 and arg_403_1.time_ < var_406_1 + var_406_2 + arg_406_0 and not isNil(var_406_0) and arg_403_1.var_.actorSpriteComps10018 then
				for iter_406_2, iter_406_3 in pairs(arg_403_1.var_.actorSpriteComps10018:ToTable()) do
					if iter_406_3 then
						if arg_403_1.isInRecall_ then
							iter_406_3.color = arg_403_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_406_3.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_403_1.var_.actorSpriteComps10018 = nil
			end

			local var_406_8 = arg_403_1.actors_["10015"]
			local var_406_9 = 0

			if var_406_9 < arg_403_1.time_ and arg_403_1.time_ <= var_406_9 + arg_406_0 and not isNil(var_406_8) and arg_403_1.var_.actorSpriteComps10015 == nil then
				arg_403_1.var_.actorSpriteComps10015 = var_406_8:GetComponentsInChildren(typeof(Image), true)
			end

			local var_406_10 = 0.034

			if var_406_9 <= arg_403_1.time_ and arg_403_1.time_ < var_406_9 + var_406_10 and not isNil(var_406_8) then
				local var_406_11 = (arg_403_1.time_ - var_406_9) / var_406_10

				if arg_403_1.var_.actorSpriteComps10015 then
					for iter_406_4, iter_406_5 in pairs(arg_403_1.var_.actorSpriteComps10015:ToTable()) do
						if iter_406_5 then
							if arg_403_1.isInRecall_ then
								local var_406_12 = Mathf.Lerp(iter_406_5.color.r, arg_403_1.hightColor2.r, var_406_11)
								local var_406_13 = Mathf.Lerp(iter_406_5.color.g, arg_403_1.hightColor2.g, var_406_11)
								local var_406_14 = Mathf.Lerp(iter_406_5.color.b, arg_403_1.hightColor2.b, var_406_11)

								iter_406_5.color = Color.New(var_406_12, var_406_13, var_406_14)
							else
								local var_406_15 = Mathf.Lerp(iter_406_5.color.r, 0.5, var_406_11)

								iter_406_5.color = Color.New(var_406_15, var_406_15, var_406_15)
							end
						end
					end
				end
			end

			if arg_403_1.time_ >= var_406_9 + var_406_10 and arg_403_1.time_ < var_406_9 + var_406_10 + arg_406_0 and not isNil(var_406_8) and arg_403_1.var_.actorSpriteComps10015 then
				for iter_406_6, iter_406_7 in pairs(arg_403_1.var_.actorSpriteComps10015:ToTable()) do
					if iter_406_7 then
						if arg_403_1.isInRecall_ then
							iter_406_7.color = arg_403_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_406_7.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_403_1.var_.actorSpriteComps10015 = nil
			end

			local var_406_16 = 0
			local var_406_17 = 1.075

			if var_406_16 < arg_403_1.time_ and arg_403_1.time_ <= var_406_16 + arg_406_0 then
				arg_403_1.talkMaxDuration = 0
				arg_403_1.dialogCg_.alpha = 1

				arg_403_1.dialog_:SetActive(true)
				SetActive(arg_403_1.leftNameGo_, true)

				local var_406_18 = arg_403_1:FormatText(StoryNameCfg[257].name)

				arg_403_1.leftNameTxt_.text = var_406_18

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_403_1.leftNameTxt_.transform)

				arg_403_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_403_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_403_1:RecordName(arg_403_1.leftNameTxt_.text)
				SetActive(arg_403_1.iconTrs_.gameObject, false)
				arg_403_1.callingController_:SetSelectedState("normal")

				local var_406_19 = arg_403_1:GetWordFromCfg(114251099)
				local var_406_20 = arg_403_1:FormatText(var_406_19.content)

				arg_403_1.text_.text = var_406_20

				LuaForUtil.ClearLinePrefixSymbol(arg_403_1.text_)

				local var_406_21 = 43
				local var_406_22 = utf8.len(var_406_20)
				local var_406_23 = var_406_21 <= 0 and var_406_17 or var_406_17 * (var_406_22 / var_406_21)

				if var_406_23 > 0 and var_406_17 < var_406_23 then
					arg_403_1.talkMaxDuration = var_406_23

					if var_406_23 + var_406_16 > arg_403_1.duration_ then
						arg_403_1.duration_ = var_406_23 + var_406_16
					end
				end

				arg_403_1.text_.text = var_406_20
				arg_403_1.typewritter.percent = 0

				arg_403_1.typewritter:SetDirty()
				arg_403_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_114251", "114251099", "story_v_out_114251.awb") ~= 0 then
					local var_406_24 = manager.audio:GetVoiceLength("story_v_out_114251", "114251099", "story_v_out_114251.awb") / 1000

					if var_406_24 + var_406_16 > arg_403_1.duration_ then
						arg_403_1.duration_ = var_406_24 + var_406_16
					end

					if var_406_19.prefab_name ~= "" and arg_403_1.actors_[var_406_19.prefab_name] ~= nil then
						local var_406_25 = LuaForUtil.PlayVoiceWithCriLipsync(arg_403_1.actors_[var_406_19.prefab_name].transform, "story_v_out_114251", "114251099", "story_v_out_114251.awb")

						arg_403_1:RecordAudio("114251099", var_406_25)
						arg_403_1:RecordAudio("114251099", var_406_25)
					else
						arg_403_1:AudioAction("play", "voice", "story_v_out_114251", "114251099", "story_v_out_114251.awb")
					end

					arg_403_1:RecordHistoryTalkVoice("story_v_out_114251", "114251099", "story_v_out_114251.awb")
				end

				arg_403_1:RecordContent(arg_403_1.text_.text)
			end

			local var_406_26 = math.max(var_406_17, arg_403_1.talkMaxDuration)

			if var_406_16 <= arg_403_1.time_ and arg_403_1.time_ < var_406_16 + var_406_26 then
				arg_403_1.typewritter.percent = (arg_403_1.time_ - var_406_16) / var_406_26

				arg_403_1.typewritter:SetDirty()
			end

			if arg_403_1.time_ >= var_406_16 + var_406_26 and arg_403_1.time_ < var_406_16 + var_406_26 + arg_406_0 then
				arg_403_1.typewritter.percent = 1

				arg_403_1.typewritter:SetDirty()
				arg_403_1:ShowNextGo(true)
			end
		end

		arg_403_1.nodeConfigList_ = {}

		arg_403_1:InitPlayNodeList()
	end,
	Play114251100 = function(arg_407_0, arg_407_1)
		arg_407_1.time_ = 0
		arg_407_1.frameCnt_ = 0
		arg_407_1.state_ = "playing"
		arg_407_1.curTalkId_ = 114251100
		arg_407_1.duration_ = 9.17

		local var_407_0 = {
			ja = 9.166,
			ko = 7.433,
			zh = 8.4,
			en = 6.133
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
				arg_407_0:Play114251101(arg_407_1)
			end
		end

		function arg_407_1.onSingleLineUpdate_(arg_410_0)
			local var_410_0 = arg_407_1.actors_["10015"].transform
			local var_410_1 = 0

			if var_410_1 < arg_407_1.time_ and arg_407_1.time_ <= var_410_1 + arg_410_0 then
				arg_407_1.var_.moveOldPos10015 = var_410_0.localPosition
				var_410_0.localScale = Vector3.New(1, 1, 1)

				arg_407_1:CheckSpriteTmpPos("10015", 4)

				local var_410_2 = var_410_0.childCount

				for iter_410_0 = 0, var_410_2 - 1 do
					local var_410_3 = var_410_0:GetChild(iter_410_0)

					if var_410_3.name == "split_4" or not string.find(var_410_3.name, "split") then
						var_410_3.gameObject:SetActive(true)
					else
						var_410_3.gameObject:SetActive(false)
					end
				end
			end

			local var_410_4 = 0.001

			if var_410_1 <= arg_407_1.time_ and arg_407_1.time_ < var_410_1 + var_410_4 then
				local var_410_5 = (arg_407_1.time_ - var_410_1) / var_410_4
				local var_410_6 = Vector3.New(390, -350, -180)

				var_410_0.localPosition = Vector3.Lerp(arg_407_1.var_.moveOldPos10015, var_410_6, var_410_5)
			end

			if arg_407_1.time_ >= var_410_1 + var_410_4 and arg_407_1.time_ < var_410_1 + var_410_4 + arg_410_0 then
				var_410_0.localPosition = Vector3.New(390, -350, -180)
			end

			local var_410_7 = arg_407_1.actors_["10015"]
			local var_410_8 = 0

			if var_410_8 < arg_407_1.time_ and arg_407_1.time_ <= var_410_8 + arg_410_0 and not isNil(var_410_7) and arg_407_1.var_.actorSpriteComps10015 == nil then
				arg_407_1.var_.actorSpriteComps10015 = var_410_7:GetComponentsInChildren(typeof(Image), true)
			end

			local var_410_9 = 0.034

			if var_410_8 <= arg_407_1.time_ and arg_407_1.time_ < var_410_8 + var_410_9 and not isNil(var_410_7) then
				local var_410_10 = (arg_407_1.time_ - var_410_8) / var_410_9

				if arg_407_1.var_.actorSpriteComps10015 then
					for iter_410_1, iter_410_2 in pairs(arg_407_1.var_.actorSpriteComps10015:ToTable()) do
						if iter_410_2 then
							if arg_407_1.isInRecall_ then
								local var_410_11 = Mathf.Lerp(iter_410_2.color.r, arg_407_1.hightColor1.r, var_410_10)
								local var_410_12 = Mathf.Lerp(iter_410_2.color.g, arg_407_1.hightColor1.g, var_410_10)
								local var_410_13 = Mathf.Lerp(iter_410_2.color.b, arg_407_1.hightColor1.b, var_410_10)

								iter_410_2.color = Color.New(var_410_11, var_410_12, var_410_13)
							else
								local var_410_14 = Mathf.Lerp(iter_410_2.color.r, 1, var_410_10)

								iter_410_2.color = Color.New(var_410_14, var_410_14, var_410_14)
							end
						end
					end
				end
			end

			if arg_407_1.time_ >= var_410_8 + var_410_9 and arg_407_1.time_ < var_410_8 + var_410_9 + arg_410_0 and not isNil(var_410_7) and arg_407_1.var_.actorSpriteComps10015 then
				for iter_410_3, iter_410_4 in pairs(arg_407_1.var_.actorSpriteComps10015:ToTable()) do
					if iter_410_4 then
						if arg_407_1.isInRecall_ then
							iter_410_4.color = arg_407_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_410_4.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_407_1.var_.actorSpriteComps10015 = nil
			end

			local var_410_15 = arg_407_1.actors_["10018"]
			local var_410_16 = 0

			if var_410_16 < arg_407_1.time_ and arg_407_1.time_ <= var_410_16 + arg_410_0 and not isNil(var_410_15) and arg_407_1.var_.actorSpriteComps10018 == nil then
				arg_407_1.var_.actorSpriteComps10018 = var_410_15:GetComponentsInChildren(typeof(Image), true)
			end

			local var_410_17 = 0.034

			if var_410_16 <= arg_407_1.time_ and arg_407_1.time_ < var_410_16 + var_410_17 and not isNil(var_410_15) then
				local var_410_18 = (arg_407_1.time_ - var_410_16) / var_410_17

				if arg_407_1.var_.actorSpriteComps10018 then
					for iter_410_5, iter_410_6 in pairs(arg_407_1.var_.actorSpriteComps10018:ToTable()) do
						if iter_410_6 then
							if arg_407_1.isInRecall_ then
								local var_410_19 = Mathf.Lerp(iter_410_6.color.r, arg_407_1.hightColor2.r, var_410_18)
								local var_410_20 = Mathf.Lerp(iter_410_6.color.g, arg_407_1.hightColor2.g, var_410_18)
								local var_410_21 = Mathf.Lerp(iter_410_6.color.b, arg_407_1.hightColor2.b, var_410_18)

								iter_410_6.color = Color.New(var_410_19, var_410_20, var_410_21)
							else
								local var_410_22 = Mathf.Lerp(iter_410_6.color.r, 0.5, var_410_18)

								iter_410_6.color = Color.New(var_410_22, var_410_22, var_410_22)
							end
						end
					end
				end
			end

			if arg_407_1.time_ >= var_410_16 + var_410_17 and arg_407_1.time_ < var_410_16 + var_410_17 + arg_410_0 and not isNil(var_410_15) and arg_407_1.var_.actorSpriteComps10018 then
				for iter_410_7, iter_410_8 in pairs(arg_407_1.var_.actorSpriteComps10018:ToTable()) do
					if iter_410_8 then
						if arg_407_1.isInRecall_ then
							iter_410_8.color = arg_407_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_410_8.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_407_1.var_.actorSpriteComps10018 = nil
			end

			local var_410_23 = 0
			local var_410_24 = 0.875

			if var_410_23 < arg_407_1.time_ and arg_407_1.time_ <= var_410_23 + arg_410_0 then
				arg_407_1.talkMaxDuration = 0
				arg_407_1.dialogCg_.alpha = 1

				arg_407_1.dialog_:SetActive(true)
				SetActive(arg_407_1.leftNameGo_, true)

				local var_410_25 = arg_407_1:FormatText(StoryNameCfg[208].name)

				arg_407_1.leftNameTxt_.text = var_410_25

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_407_1.leftNameTxt_.transform)

				arg_407_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_407_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_407_1:RecordName(arg_407_1.leftNameTxt_.text)
				SetActive(arg_407_1.iconTrs_.gameObject, false)
				arg_407_1.callingController_:SetSelectedState("normal")

				local var_410_26 = arg_407_1:GetWordFromCfg(114251100)
				local var_410_27 = arg_407_1:FormatText(var_410_26.content)

				arg_407_1.text_.text = var_410_27

				LuaForUtil.ClearLinePrefixSymbol(arg_407_1.text_)

				local var_410_28 = 35
				local var_410_29 = utf8.len(var_410_27)
				local var_410_30 = var_410_28 <= 0 and var_410_24 or var_410_24 * (var_410_29 / var_410_28)

				if var_410_30 > 0 and var_410_24 < var_410_30 then
					arg_407_1.talkMaxDuration = var_410_30

					if var_410_30 + var_410_23 > arg_407_1.duration_ then
						arg_407_1.duration_ = var_410_30 + var_410_23
					end
				end

				arg_407_1.text_.text = var_410_27
				arg_407_1.typewritter.percent = 0

				arg_407_1.typewritter:SetDirty()
				arg_407_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_114251", "114251100", "story_v_out_114251.awb") ~= 0 then
					local var_410_31 = manager.audio:GetVoiceLength("story_v_out_114251", "114251100", "story_v_out_114251.awb") / 1000

					if var_410_31 + var_410_23 > arg_407_1.duration_ then
						arg_407_1.duration_ = var_410_31 + var_410_23
					end

					if var_410_26.prefab_name ~= "" and arg_407_1.actors_[var_410_26.prefab_name] ~= nil then
						local var_410_32 = LuaForUtil.PlayVoiceWithCriLipsync(arg_407_1.actors_[var_410_26.prefab_name].transform, "story_v_out_114251", "114251100", "story_v_out_114251.awb")

						arg_407_1:RecordAudio("114251100", var_410_32)
						arg_407_1:RecordAudio("114251100", var_410_32)
					else
						arg_407_1:AudioAction("play", "voice", "story_v_out_114251", "114251100", "story_v_out_114251.awb")
					end

					arg_407_1:RecordHistoryTalkVoice("story_v_out_114251", "114251100", "story_v_out_114251.awb")
				end

				arg_407_1:RecordContent(arg_407_1.text_.text)
			end

			local var_410_33 = math.max(var_410_24, arg_407_1.talkMaxDuration)

			if var_410_23 <= arg_407_1.time_ and arg_407_1.time_ < var_410_23 + var_410_33 then
				arg_407_1.typewritter.percent = (arg_407_1.time_ - var_410_23) / var_410_33

				arg_407_1.typewritter:SetDirty()
			end

			if arg_407_1.time_ >= var_410_23 + var_410_33 and arg_407_1.time_ < var_410_23 + var_410_33 + arg_410_0 then
				arg_407_1.typewritter.percent = 1

				arg_407_1.typewritter:SetDirty()
				arg_407_1:ShowNextGo(true)
			end
		end

		arg_407_1.nodeConfigList_ = {
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

		arg_407_1:InitPlayNodeList()
	end,
	Play114251101 = function(arg_411_0, arg_411_1)
		arg_411_1.time_ = 0
		arg_411_1.frameCnt_ = 0
		arg_411_1.state_ = "playing"
		arg_411_1.curTalkId_ = 114251101
		arg_411_1.duration_ = 8.9

		local var_411_0 = {
			ja = 7.6,
			ko = 8.9,
			zh = 7.033,
			en = 7.8
		}
		local var_411_1 = manager.audio:GetLocalizationFlag()

		if var_411_0[var_411_1] ~= nil then
			arg_411_1.duration_ = var_411_0[var_411_1]
		end

		SetActive(arg_411_1.tipsGo_, false)

		function arg_411_1.onSingleLineFinish_()
			arg_411_1.onSingleLineUpdate_ = nil
			arg_411_1.onSingleLineFinish_ = nil
			arg_411_1.state_ = "waiting"
		end

		function arg_411_1.playNext_(arg_413_0)
			if arg_413_0 == 1 then
				arg_411_0:Play114251102(arg_411_1)
			end
		end

		function arg_411_1.onSingleLineUpdate_(arg_414_0)
			local var_414_0 = arg_411_1.actors_["10018"].transform
			local var_414_1 = 0

			if var_414_1 < arg_411_1.time_ and arg_411_1.time_ <= var_414_1 + arg_414_0 then
				arg_411_1.var_.moveOldPos10018 = var_414_0.localPosition
				var_414_0.localScale = Vector3.New(1, 1, 1)

				arg_411_1:CheckSpriteTmpPos("10018", 2)

				local var_414_2 = var_414_0.childCount

				for iter_414_0 = 0, var_414_2 - 1 do
					local var_414_3 = var_414_0:GetChild(iter_414_0)

					if var_414_3.name == "split_2" or not string.find(var_414_3.name, "split") then
						var_414_3.gameObject:SetActive(true)
					else
						var_414_3.gameObject:SetActive(false)
					end
				end
			end

			local var_414_4 = 0.001

			if var_414_1 <= arg_411_1.time_ and arg_411_1.time_ < var_414_1 + var_414_4 then
				local var_414_5 = (arg_411_1.time_ - var_414_1) / var_414_4
				local var_414_6 = Vector3.New(-390, -350, -180)

				var_414_0.localPosition = Vector3.Lerp(arg_411_1.var_.moveOldPos10018, var_414_6, var_414_5)
			end

			if arg_411_1.time_ >= var_414_1 + var_414_4 and arg_411_1.time_ < var_414_1 + var_414_4 + arg_414_0 then
				var_414_0.localPosition = Vector3.New(-390, -350, -180)
			end

			local var_414_7 = arg_411_1.actors_["10015"]
			local var_414_8 = 0

			if var_414_8 < arg_411_1.time_ and arg_411_1.time_ <= var_414_8 + arg_414_0 and not isNil(var_414_7) and arg_411_1.var_.actorSpriteComps10015 == nil then
				arg_411_1.var_.actorSpriteComps10015 = var_414_7:GetComponentsInChildren(typeof(Image), true)
			end

			local var_414_9 = 0.034

			if var_414_8 <= arg_411_1.time_ and arg_411_1.time_ < var_414_8 + var_414_9 and not isNil(var_414_7) then
				local var_414_10 = (arg_411_1.time_ - var_414_8) / var_414_9

				if arg_411_1.var_.actorSpriteComps10015 then
					for iter_414_1, iter_414_2 in pairs(arg_411_1.var_.actorSpriteComps10015:ToTable()) do
						if iter_414_2 then
							if arg_411_1.isInRecall_ then
								local var_414_11 = Mathf.Lerp(iter_414_2.color.r, arg_411_1.hightColor2.r, var_414_10)
								local var_414_12 = Mathf.Lerp(iter_414_2.color.g, arg_411_1.hightColor2.g, var_414_10)
								local var_414_13 = Mathf.Lerp(iter_414_2.color.b, arg_411_1.hightColor2.b, var_414_10)

								iter_414_2.color = Color.New(var_414_11, var_414_12, var_414_13)
							else
								local var_414_14 = Mathf.Lerp(iter_414_2.color.r, 0.5, var_414_10)

								iter_414_2.color = Color.New(var_414_14, var_414_14, var_414_14)
							end
						end
					end
				end
			end

			if arg_411_1.time_ >= var_414_8 + var_414_9 and arg_411_1.time_ < var_414_8 + var_414_9 + arg_414_0 and not isNil(var_414_7) and arg_411_1.var_.actorSpriteComps10015 then
				for iter_414_3, iter_414_4 in pairs(arg_411_1.var_.actorSpriteComps10015:ToTable()) do
					if iter_414_4 then
						if arg_411_1.isInRecall_ then
							iter_414_4.color = arg_411_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_414_4.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_411_1.var_.actorSpriteComps10015 = nil
			end

			local var_414_15 = arg_411_1.actors_["10018"]
			local var_414_16 = 0

			if var_414_16 < arg_411_1.time_ and arg_411_1.time_ <= var_414_16 + arg_414_0 and not isNil(var_414_15) and arg_411_1.var_.actorSpriteComps10018 == nil then
				arg_411_1.var_.actorSpriteComps10018 = var_414_15:GetComponentsInChildren(typeof(Image), true)
			end

			local var_414_17 = 0.034

			if var_414_16 <= arg_411_1.time_ and arg_411_1.time_ < var_414_16 + var_414_17 and not isNil(var_414_15) then
				local var_414_18 = (arg_411_1.time_ - var_414_16) / var_414_17

				if arg_411_1.var_.actorSpriteComps10018 then
					for iter_414_5, iter_414_6 in pairs(arg_411_1.var_.actorSpriteComps10018:ToTable()) do
						if iter_414_6 then
							if arg_411_1.isInRecall_ then
								local var_414_19 = Mathf.Lerp(iter_414_6.color.r, arg_411_1.hightColor1.r, var_414_18)
								local var_414_20 = Mathf.Lerp(iter_414_6.color.g, arg_411_1.hightColor1.g, var_414_18)
								local var_414_21 = Mathf.Lerp(iter_414_6.color.b, arg_411_1.hightColor1.b, var_414_18)

								iter_414_6.color = Color.New(var_414_19, var_414_20, var_414_21)
							else
								local var_414_22 = Mathf.Lerp(iter_414_6.color.r, 1, var_414_18)

								iter_414_6.color = Color.New(var_414_22, var_414_22, var_414_22)
							end
						end
					end
				end
			end

			if arg_411_1.time_ >= var_414_16 + var_414_17 and arg_411_1.time_ < var_414_16 + var_414_17 + arg_414_0 and not isNil(var_414_15) and arg_411_1.var_.actorSpriteComps10018 then
				for iter_414_7, iter_414_8 in pairs(arg_411_1.var_.actorSpriteComps10018:ToTable()) do
					if iter_414_8 then
						if arg_411_1.isInRecall_ then
							iter_414_8.color = arg_411_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_414_8.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_411_1.var_.actorSpriteComps10018 = nil
			end

			local var_414_23 = 0
			local var_414_24 = 0.6

			if var_414_23 < arg_411_1.time_ and arg_411_1.time_ <= var_414_23 + arg_414_0 then
				arg_411_1.talkMaxDuration = 0
				arg_411_1.dialogCg_.alpha = 1

				arg_411_1.dialog_:SetActive(true)
				SetActive(arg_411_1.leftNameGo_, true)

				local var_414_25 = arg_411_1:FormatText(StoryNameCfg[257].name)

				arg_411_1.leftNameTxt_.text = var_414_25

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_411_1.leftNameTxt_.transform)

				arg_411_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_411_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_411_1:RecordName(arg_411_1.leftNameTxt_.text)
				SetActive(arg_411_1.iconTrs_.gameObject, false)
				arg_411_1.callingController_:SetSelectedState("normal")

				local var_414_26 = arg_411_1:GetWordFromCfg(114251101)
				local var_414_27 = arg_411_1:FormatText(var_414_26.content)

				arg_411_1.text_.text = var_414_27

				LuaForUtil.ClearLinePrefixSymbol(arg_411_1.text_)

				local var_414_28 = 24
				local var_414_29 = utf8.len(var_414_27)
				local var_414_30 = var_414_28 <= 0 and var_414_24 or var_414_24 * (var_414_29 / var_414_28)

				if var_414_30 > 0 and var_414_24 < var_414_30 then
					arg_411_1.talkMaxDuration = var_414_30

					if var_414_30 + var_414_23 > arg_411_1.duration_ then
						arg_411_1.duration_ = var_414_30 + var_414_23
					end
				end

				arg_411_1.text_.text = var_414_27
				arg_411_1.typewritter.percent = 0

				arg_411_1.typewritter:SetDirty()
				arg_411_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_114251", "114251101", "story_v_out_114251.awb") ~= 0 then
					local var_414_31 = manager.audio:GetVoiceLength("story_v_out_114251", "114251101", "story_v_out_114251.awb") / 1000

					if var_414_31 + var_414_23 > arg_411_1.duration_ then
						arg_411_1.duration_ = var_414_31 + var_414_23
					end

					if var_414_26.prefab_name ~= "" and arg_411_1.actors_[var_414_26.prefab_name] ~= nil then
						local var_414_32 = LuaForUtil.PlayVoiceWithCriLipsync(arg_411_1.actors_[var_414_26.prefab_name].transform, "story_v_out_114251", "114251101", "story_v_out_114251.awb")

						arg_411_1:RecordAudio("114251101", var_414_32)
						arg_411_1:RecordAudio("114251101", var_414_32)
					else
						arg_411_1:AudioAction("play", "voice", "story_v_out_114251", "114251101", "story_v_out_114251.awb")
					end

					arg_411_1:RecordHistoryTalkVoice("story_v_out_114251", "114251101", "story_v_out_114251.awb")
				end

				arg_411_1:RecordContent(arg_411_1.text_.text)
			end

			local var_414_33 = math.max(var_414_24, arg_411_1.talkMaxDuration)

			if var_414_23 <= arg_411_1.time_ and arg_411_1.time_ < var_414_23 + var_414_33 then
				arg_411_1.typewritter.percent = (arg_411_1.time_ - var_414_23) / var_414_33

				arg_411_1.typewritter:SetDirty()
			end

			if arg_411_1.time_ >= var_414_23 + var_414_33 and arg_411_1.time_ < var_414_23 + var_414_33 + arg_414_0 then
				arg_411_1.typewritter.percent = 1

				arg_411_1.typewritter:SetDirty()
				arg_411_1:ShowNextGo(true)
			end
		end

		arg_411_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10018",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_411_1:InitPlayNodeList()
	end,
	Play114251102 = function(arg_415_0, arg_415_1)
		arg_415_1.time_ = 0
		arg_415_1.frameCnt_ = 0
		arg_415_1.state_ = "playing"
		arg_415_1.curTalkId_ = 114251102
		arg_415_1.duration_ = 2.3

		local var_415_0 = {
			ja = 2.3,
			ko = 2.133,
			zh = 1.2,
			en = 0.999999999999
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
				arg_415_0:Play114251103(arg_415_1)
			end
		end

		function arg_415_1.onSingleLineUpdate_(arg_418_0)
			local var_418_0 = arg_415_1.actors_["10015"].transform
			local var_418_1 = 0

			if var_418_1 < arg_415_1.time_ and arg_415_1.time_ <= var_418_1 + arg_418_0 then
				arg_415_1.var_.moveOldPos10015 = var_418_0.localPosition
				var_418_0.localScale = Vector3.New(1, 1, 1)

				arg_415_1:CheckSpriteTmpPos("10015", 4)

				local var_418_2 = var_418_0.childCount

				for iter_418_0 = 0, var_418_2 - 1 do
					local var_418_3 = var_418_0:GetChild(iter_418_0)

					if var_418_3.name == "split_1" or not string.find(var_418_3.name, "split") then
						var_418_3.gameObject:SetActive(true)
					else
						var_418_3.gameObject:SetActive(false)
					end
				end
			end

			local var_418_4 = 0.001

			if var_418_1 <= arg_415_1.time_ and arg_415_1.time_ < var_418_1 + var_418_4 then
				local var_418_5 = (arg_415_1.time_ - var_418_1) / var_418_4
				local var_418_6 = Vector3.New(390, -350, -180)

				var_418_0.localPosition = Vector3.Lerp(arg_415_1.var_.moveOldPos10015, var_418_6, var_418_5)
			end

			if arg_415_1.time_ >= var_418_1 + var_418_4 and arg_415_1.time_ < var_418_1 + var_418_4 + arg_418_0 then
				var_418_0.localPosition = Vector3.New(390, -350, -180)
			end

			local var_418_7 = arg_415_1.actors_["10015"]
			local var_418_8 = 0

			if var_418_8 < arg_415_1.time_ and arg_415_1.time_ <= var_418_8 + arg_418_0 and not isNil(var_418_7) and arg_415_1.var_.actorSpriteComps10015 == nil then
				arg_415_1.var_.actorSpriteComps10015 = var_418_7:GetComponentsInChildren(typeof(Image), true)
			end

			local var_418_9 = 0.034

			if var_418_8 <= arg_415_1.time_ and arg_415_1.time_ < var_418_8 + var_418_9 and not isNil(var_418_7) then
				local var_418_10 = (arg_415_1.time_ - var_418_8) / var_418_9

				if arg_415_1.var_.actorSpriteComps10015 then
					for iter_418_1, iter_418_2 in pairs(arg_415_1.var_.actorSpriteComps10015:ToTable()) do
						if iter_418_2 then
							if arg_415_1.isInRecall_ then
								local var_418_11 = Mathf.Lerp(iter_418_2.color.r, arg_415_1.hightColor1.r, var_418_10)
								local var_418_12 = Mathf.Lerp(iter_418_2.color.g, arg_415_1.hightColor1.g, var_418_10)
								local var_418_13 = Mathf.Lerp(iter_418_2.color.b, arg_415_1.hightColor1.b, var_418_10)

								iter_418_2.color = Color.New(var_418_11, var_418_12, var_418_13)
							else
								local var_418_14 = Mathf.Lerp(iter_418_2.color.r, 1, var_418_10)

								iter_418_2.color = Color.New(var_418_14, var_418_14, var_418_14)
							end
						end
					end
				end
			end

			if arg_415_1.time_ >= var_418_8 + var_418_9 and arg_415_1.time_ < var_418_8 + var_418_9 + arg_418_0 and not isNil(var_418_7) and arg_415_1.var_.actorSpriteComps10015 then
				for iter_418_3, iter_418_4 in pairs(arg_415_1.var_.actorSpriteComps10015:ToTable()) do
					if iter_418_4 then
						if arg_415_1.isInRecall_ then
							iter_418_4.color = arg_415_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_418_4.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_415_1.var_.actorSpriteComps10015 = nil
			end

			local var_418_15 = arg_415_1.actors_["10018"]
			local var_418_16 = 0

			if var_418_16 < arg_415_1.time_ and arg_415_1.time_ <= var_418_16 + arg_418_0 and not isNil(var_418_15) and arg_415_1.var_.actorSpriteComps10018 == nil then
				arg_415_1.var_.actorSpriteComps10018 = var_418_15:GetComponentsInChildren(typeof(Image), true)
			end

			local var_418_17 = 0.034

			if var_418_16 <= arg_415_1.time_ and arg_415_1.time_ < var_418_16 + var_418_17 and not isNil(var_418_15) then
				local var_418_18 = (arg_415_1.time_ - var_418_16) / var_418_17

				if arg_415_1.var_.actorSpriteComps10018 then
					for iter_418_5, iter_418_6 in pairs(arg_415_1.var_.actorSpriteComps10018:ToTable()) do
						if iter_418_6 then
							if arg_415_1.isInRecall_ then
								local var_418_19 = Mathf.Lerp(iter_418_6.color.r, arg_415_1.hightColor2.r, var_418_18)
								local var_418_20 = Mathf.Lerp(iter_418_6.color.g, arg_415_1.hightColor2.g, var_418_18)
								local var_418_21 = Mathf.Lerp(iter_418_6.color.b, arg_415_1.hightColor2.b, var_418_18)

								iter_418_6.color = Color.New(var_418_19, var_418_20, var_418_21)
							else
								local var_418_22 = Mathf.Lerp(iter_418_6.color.r, 0.5, var_418_18)

								iter_418_6.color = Color.New(var_418_22, var_418_22, var_418_22)
							end
						end
					end
				end
			end

			if arg_415_1.time_ >= var_418_16 + var_418_17 and arg_415_1.time_ < var_418_16 + var_418_17 + arg_418_0 and not isNil(var_418_15) and arg_415_1.var_.actorSpriteComps10018 then
				for iter_418_7, iter_418_8 in pairs(arg_415_1.var_.actorSpriteComps10018:ToTable()) do
					if iter_418_8 then
						if arg_415_1.isInRecall_ then
							iter_418_8.color = arg_415_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_418_8.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_415_1.var_.actorSpriteComps10018 = nil
			end

			local var_418_23 = 0
			local var_418_24 = 0.1

			if var_418_23 < arg_415_1.time_ and arg_415_1.time_ <= var_418_23 + arg_418_0 then
				arg_415_1.talkMaxDuration = 0
				arg_415_1.dialogCg_.alpha = 1

				arg_415_1.dialog_:SetActive(true)
				SetActive(arg_415_1.leftNameGo_, true)

				local var_418_25 = arg_415_1:FormatText(StoryNameCfg[208].name)

				arg_415_1.leftNameTxt_.text = var_418_25

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_415_1.leftNameTxt_.transform)

				arg_415_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_415_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_415_1:RecordName(arg_415_1.leftNameTxt_.text)
				SetActive(arg_415_1.iconTrs_.gameObject, false)
				arg_415_1.callingController_:SetSelectedState("normal")

				local var_418_26 = arg_415_1:GetWordFromCfg(114251102)
				local var_418_27 = arg_415_1:FormatText(var_418_26.content)

				arg_415_1.text_.text = var_418_27

				LuaForUtil.ClearLinePrefixSymbol(arg_415_1.text_)

				local var_418_28 = 4
				local var_418_29 = utf8.len(var_418_27)
				local var_418_30 = var_418_28 <= 0 and var_418_24 or var_418_24 * (var_418_29 / var_418_28)

				if var_418_30 > 0 and var_418_24 < var_418_30 then
					arg_415_1.talkMaxDuration = var_418_30

					if var_418_30 + var_418_23 > arg_415_1.duration_ then
						arg_415_1.duration_ = var_418_30 + var_418_23
					end
				end

				arg_415_1.text_.text = var_418_27
				arg_415_1.typewritter.percent = 0

				arg_415_1.typewritter:SetDirty()
				arg_415_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_114251", "114251102", "story_v_out_114251.awb") ~= 0 then
					local var_418_31 = manager.audio:GetVoiceLength("story_v_out_114251", "114251102", "story_v_out_114251.awb") / 1000

					if var_418_31 + var_418_23 > arg_415_1.duration_ then
						arg_415_1.duration_ = var_418_31 + var_418_23
					end

					if var_418_26.prefab_name ~= "" and arg_415_1.actors_[var_418_26.prefab_name] ~= nil then
						local var_418_32 = LuaForUtil.PlayVoiceWithCriLipsync(arg_415_1.actors_[var_418_26.prefab_name].transform, "story_v_out_114251", "114251102", "story_v_out_114251.awb")

						arg_415_1:RecordAudio("114251102", var_418_32)
						arg_415_1:RecordAudio("114251102", var_418_32)
					else
						arg_415_1:AudioAction("play", "voice", "story_v_out_114251", "114251102", "story_v_out_114251.awb")
					end

					arg_415_1:RecordHistoryTalkVoice("story_v_out_114251", "114251102", "story_v_out_114251.awb")
				end

				arg_415_1:RecordContent(arg_415_1.text_.text)
			end

			local var_418_33 = math.max(var_418_24, arg_415_1.talkMaxDuration)

			if var_418_23 <= arg_415_1.time_ and arg_415_1.time_ < var_418_23 + var_418_33 then
				arg_415_1.typewritter.percent = (arg_415_1.time_ - var_418_23) / var_418_33

				arg_415_1.typewritter:SetDirty()
			end

			if arg_415_1.time_ >= var_418_23 + var_418_33 and arg_415_1.time_ < var_418_23 + var_418_33 + arg_418_0 then
				arg_415_1.typewritter.percent = 1

				arg_415_1.typewritter:SetDirty()
				arg_415_1:ShowNextGo(true)
			end
		end

		arg_415_1.nodeConfigList_ = {
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

		arg_415_1:InitPlayNodeList()
	end,
	Play114251103 = function(arg_419_0, arg_419_1)
		arg_419_1.time_ = 0
		arg_419_1.frameCnt_ = 0
		arg_419_1.state_ = "playing"
		arg_419_1.curTalkId_ = 114251103
		arg_419_1.duration_ = 5

		SetActive(arg_419_1.tipsGo_, false)

		function arg_419_1.onSingleLineFinish_()
			arg_419_1.onSingleLineUpdate_ = nil
			arg_419_1.onSingleLineFinish_ = nil
			arg_419_1.state_ = "waiting"
		end

		function arg_419_1.playNext_(arg_421_0)
			if arg_421_0 == 1 then
				arg_419_0:Play114251104(arg_419_1)
			end
		end

		function arg_419_1.onSingleLineUpdate_(arg_422_0)
			local var_422_0 = arg_419_1.actors_["10015"]
			local var_422_1 = 0

			if var_422_1 < arg_419_1.time_ and arg_419_1.time_ <= var_422_1 + arg_422_0 and not isNil(var_422_0) and arg_419_1.var_.actorSpriteComps10015 == nil then
				arg_419_1.var_.actorSpriteComps10015 = var_422_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_422_2 = 0.034

			if var_422_1 <= arg_419_1.time_ and arg_419_1.time_ < var_422_1 + var_422_2 and not isNil(var_422_0) then
				local var_422_3 = (arg_419_1.time_ - var_422_1) / var_422_2

				if arg_419_1.var_.actorSpriteComps10015 then
					for iter_422_0, iter_422_1 in pairs(arg_419_1.var_.actorSpriteComps10015:ToTable()) do
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

			if arg_419_1.time_ >= var_422_1 + var_422_2 and arg_419_1.time_ < var_422_1 + var_422_2 + arg_422_0 and not isNil(var_422_0) and arg_419_1.var_.actorSpriteComps10015 then
				for iter_422_2, iter_422_3 in pairs(arg_419_1.var_.actorSpriteComps10015:ToTable()) do
					if iter_422_3 then
						if arg_419_1.isInRecall_ then
							iter_422_3.color = arg_419_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_422_3.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_419_1.var_.actorSpriteComps10015 = nil
			end

			local var_422_8 = 0
			local var_422_9 = 0.525

			if var_422_8 < arg_419_1.time_ and arg_419_1.time_ <= var_422_8 + arg_422_0 then
				arg_419_1.talkMaxDuration = 0
				arg_419_1.dialogCg_.alpha = 1

				arg_419_1.dialog_:SetActive(true)
				SetActive(arg_419_1.leftNameGo_, false)

				arg_419_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_419_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_419_1:RecordName(arg_419_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_419_1.iconTrs_.gameObject, false)
				arg_419_1.callingController_:SetSelectedState("normal")

				local var_422_10 = arg_419_1:GetWordFromCfg(114251103)
				local var_422_11 = arg_419_1:FormatText(var_422_10.content)

				arg_419_1.text_.text = var_422_11

				LuaForUtil.ClearLinePrefixSymbol(arg_419_1.text_)

				local var_422_12 = 21
				local var_422_13 = utf8.len(var_422_11)
				local var_422_14 = var_422_12 <= 0 and var_422_9 or var_422_9 * (var_422_13 / var_422_12)

				if var_422_14 > 0 and var_422_9 < var_422_14 then
					arg_419_1.talkMaxDuration = var_422_14

					if var_422_14 + var_422_8 > arg_419_1.duration_ then
						arg_419_1.duration_ = var_422_14 + var_422_8
					end
				end

				arg_419_1.text_.text = var_422_11
				arg_419_1.typewritter.percent = 0

				arg_419_1.typewritter:SetDirty()
				arg_419_1:ShowNextGo(false)
				arg_419_1:RecordContent(arg_419_1.text_.text)
			end

			local var_422_15 = math.max(var_422_9, arg_419_1.talkMaxDuration)

			if var_422_8 <= arg_419_1.time_ and arg_419_1.time_ < var_422_8 + var_422_15 then
				arg_419_1.typewritter.percent = (arg_419_1.time_ - var_422_8) / var_422_15

				arg_419_1.typewritter:SetDirty()
			end

			if arg_419_1.time_ >= var_422_8 + var_422_15 and arg_419_1.time_ < var_422_8 + var_422_15 + arg_422_0 then
				arg_419_1.typewritter.percent = 1

				arg_419_1.typewritter:SetDirty()
				arg_419_1:ShowNextGo(true)
			end
		end

		arg_419_1.nodeConfigList_ = {}

		arg_419_1:InitPlayNodeList()
	end,
	Play114251104 = function(arg_423_0, arg_423_1)
		arg_423_1.time_ = 0
		arg_423_1.frameCnt_ = 0
		arg_423_1.state_ = "playing"
		arg_423_1.curTalkId_ = 114251104
		arg_423_1.duration_ = 14.9

		local var_423_0 = {
			ja = 7.6,
			ko = 14.9,
			zh = 14.8,
			en = 12.4
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
			arg_423_1.auto_ = false
		end

		function arg_423_1.playNext_(arg_425_0)
			arg_423_1.onStoryFinished_()
		end

		function arg_423_1.onSingleLineUpdate_(arg_426_0)
			local var_426_0 = arg_423_1.actors_["10018"].transform
			local var_426_1 = 0

			if var_426_1 < arg_423_1.time_ and arg_423_1.time_ <= var_426_1 + arg_426_0 then
				arg_423_1.var_.moveOldPos10018 = var_426_0.localPosition
				var_426_0.localScale = Vector3.New(1, 1, 1)

				arg_423_1:CheckSpriteTmpPos("10018", 2)

				local var_426_2 = var_426_0.childCount

				for iter_426_0 = 0, var_426_2 - 1 do
					local var_426_3 = var_426_0:GetChild(iter_426_0)

					if var_426_3.name == "split_2" or not string.find(var_426_3.name, "split") then
						var_426_3.gameObject:SetActive(true)
					else
						var_426_3.gameObject:SetActive(false)
					end
				end
			end

			local var_426_4 = 0.001

			if var_426_1 <= arg_423_1.time_ and arg_423_1.time_ < var_426_1 + var_426_4 then
				local var_426_5 = (arg_423_1.time_ - var_426_1) / var_426_4
				local var_426_6 = Vector3.New(-390, -350, -180)

				var_426_0.localPosition = Vector3.Lerp(arg_423_1.var_.moveOldPos10018, var_426_6, var_426_5)
			end

			if arg_423_1.time_ >= var_426_1 + var_426_4 and arg_423_1.time_ < var_426_1 + var_426_4 + arg_426_0 then
				var_426_0.localPosition = Vector3.New(-390, -350, -180)
			end

			local var_426_7 = arg_423_1.actors_["10018"]
			local var_426_8 = 0

			if var_426_8 < arg_423_1.time_ and arg_423_1.time_ <= var_426_8 + arg_426_0 and not isNil(var_426_7) and arg_423_1.var_.actorSpriteComps10018 == nil then
				arg_423_1.var_.actorSpriteComps10018 = var_426_7:GetComponentsInChildren(typeof(Image), true)
			end

			local var_426_9 = 0.034

			if var_426_8 <= arg_423_1.time_ and arg_423_1.time_ < var_426_8 + var_426_9 and not isNil(var_426_7) then
				local var_426_10 = (arg_423_1.time_ - var_426_8) / var_426_9

				if arg_423_1.var_.actorSpriteComps10018 then
					for iter_426_1, iter_426_2 in pairs(arg_423_1.var_.actorSpriteComps10018:ToTable()) do
						if iter_426_2 then
							if arg_423_1.isInRecall_ then
								local var_426_11 = Mathf.Lerp(iter_426_2.color.r, arg_423_1.hightColor1.r, var_426_10)
								local var_426_12 = Mathf.Lerp(iter_426_2.color.g, arg_423_1.hightColor1.g, var_426_10)
								local var_426_13 = Mathf.Lerp(iter_426_2.color.b, arg_423_1.hightColor1.b, var_426_10)

								iter_426_2.color = Color.New(var_426_11, var_426_12, var_426_13)
							else
								local var_426_14 = Mathf.Lerp(iter_426_2.color.r, 1, var_426_10)

								iter_426_2.color = Color.New(var_426_14, var_426_14, var_426_14)
							end
						end
					end
				end
			end

			if arg_423_1.time_ >= var_426_8 + var_426_9 and arg_423_1.time_ < var_426_8 + var_426_9 + arg_426_0 and not isNil(var_426_7) and arg_423_1.var_.actorSpriteComps10018 then
				for iter_426_3, iter_426_4 in pairs(arg_423_1.var_.actorSpriteComps10018:ToTable()) do
					if iter_426_4 then
						if arg_423_1.isInRecall_ then
							iter_426_4.color = arg_423_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_426_4.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_423_1.var_.actorSpriteComps10018 = nil
			end

			local var_426_15 = arg_423_1.actors_["10015"]
			local var_426_16 = 0

			if var_426_16 < arg_423_1.time_ and arg_423_1.time_ <= var_426_16 + arg_426_0 and not isNil(var_426_15) and arg_423_1.var_.actorSpriteComps10015 == nil then
				arg_423_1.var_.actorSpriteComps10015 = var_426_15:GetComponentsInChildren(typeof(Image), true)
			end

			local var_426_17 = 0.034

			if var_426_16 <= arg_423_1.time_ and arg_423_1.time_ < var_426_16 + var_426_17 and not isNil(var_426_15) then
				local var_426_18 = (arg_423_1.time_ - var_426_16) / var_426_17

				if arg_423_1.var_.actorSpriteComps10015 then
					for iter_426_5, iter_426_6 in pairs(arg_423_1.var_.actorSpriteComps10015:ToTable()) do
						if iter_426_6 then
							if arg_423_1.isInRecall_ then
								local var_426_19 = Mathf.Lerp(iter_426_6.color.r, arg_423_1.hightColor2.r, var_426_18)
								local var_426_20 = Mathf.Lerp(iter_426_6.color.g, arg_423_1.hightColor2.g, var_426_18)
								local var_426_21 = Mathf.Lerp(iter_426_6.color.b, arg_423_1.hightColor2.b, var_426_18)

								iter_426_6.color = Color.New(var_426_19, var_426_20, var_426_21)
							else
								local var_426_22 = Mathf.Lerp(iter_426_6.color.r, 0.5, var_426_18)

								iter_426_6.color = Color.New(var_426_22, var_426_22, var_426_22)
							end
						end
					end
				end
			end

			if arg_423_1.time_ >= var_426_16 + var_426_17 and arg_423_1.time_ < var_426_16 + var_426_17 + arg_426_0 and not isNil(var_426_15) and arg_423_1.var_.actorSpriteComps10015 then
				for iter_426_7, iter_426_8 in pairs(arg_423_1.var_.actorSpriteComps10015:ToTable()) do
					if iter_426_8 then
						if arg_423_1.isInRecall_ then
							iter_426_8.color = arg_423_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_426_8.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_423_1.var_.actorSpriteComps10015 = nil
			end

			local var_426_23 = 0
			local var_426_24 = 1.1

			if var_426_23 < arg_423_1.time_ and arg_423_1.time_ <= var_426_23 + arg_426_0 then
				arg_423_1.talkMaxDuration = 0
				arg_423_1.dialogCg_.alpha = 1

				arg_423_1.dialog_:SetActive(true)
				SetActive(arg_423_1.leftNameGo_, true)

				local var_426_25 = arg_423_1:FormatText(StoryNameCfg[257].name)

				arg_423_1.leftNameTxt_.text = var_426_25

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_423_1.leftNameTxt_.transform)

				arg_423_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_423_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_423_1:RecordName(arg_423_1.leftNameTxt_.text)
				SetActive(arg_423_1.iconTrs_.gameObject, false)
				arg_423_1.callingController_:SetSelectedState("normal")

				local var_426_26 = arg_423_1:GetWordFromCfg(114251104)
				local var_426_27 = arg_423_1:FormatText(var_426_26.content)

				arg_423_1.text_.text = var_426_27

				LuaForUtil.ClearLinePrefixSymbol(arg_423_1.text_)

				local var_426_28 = 43
				local var_426_29 = utf8.len(var_426_27)
				local var_426_30 = var_426_28 <= 0 and var_426_24 or var_426_24 * (var_426_29 / var_426_28)

				if var_426_30 > 0 and var_426_24 < var_426_30 then
					arg_423_1.talkMaxDuration = var_426_30

					if var_426_30 + var_426_23 > arg_423_1.duration_ then
						arg_423_1.duration_ = var_426_30 + var_426_23
					end
				end

				arg_423_1.text_.text = var_426_27
				arg_423_1.typewritter.percent = 0

				arg_423_1.typewritter:SetDirty()
				arg_423_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_114251", "114251104", "story_v_out_114251.awb") ~= 0 then
					local var_426_31 = manager.audio:GetVoiceLength("story_v_out_114251", "114251104", "story_v_out_114251.awb") / 1000

					if var_426_31 + var_426_23 > arg_423_1.duration_ then
						arg_423_1.duration_ = var_426_31 + var_426_23
					end

					if var_426_26.prefab_name ~= "" and arg_423_1.actors_[var_426_26.prefab_name] ~= nil then
						local var_426_32 = LuaForUtil.PlayVoiceWithCriLipsync(arg_423_1.actors_[var_426_26.prefab_name].transform, "story_v_out_114251", "114251104", "story_v_out_114251.awb")

						arg_423_1:RecordAudio("114251104", var_426_32)
						arg_423_1:RecordAudio("114251104", var_426_32)
					else
						arg_423_1:AudioAction("play", "voice", "story_v_out_114251", "114251104", "story_v_out_114251.awb")
					end

					arg_423_1:RecordHistoryTalkVoice("story_v_out_114251", "114251104", "story_v_out_114251.awb")
				end

				arg_423_1:RecordContent(arg_423_1.text_.text)
			end

			local var_426_33 = math.max(var_426_24, arg_423_1.talkMaxDuration)

			if var_426_23 <= arg_423_1.time_ and arg_423_1.time_ < var_426_23 + var_426_33 then
				arg_423_1.typewritter.percent = (arg_423_1.time_ - var_426_23) / var_426_33

				arg_423_1.typewritter:SetDirty()
			end

			if arg_423_1.time_ >= var_426_23 + var_426_33 and arg_423_1.time_ < var_426_23 + var_426_33 + arg_426_0 then
				arg_423_1.typewritter.percent = 1

				arg_423_1.typewritter:SetDirty()
				arg_423_1:ShowNextGo(true)
			end
		end

		arg_423_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10018",
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
	assets = {
		"TextureConfig/Background/ST25",
		"TextureConfig/Background/ST24",
		"TextureConfig/Background/ST24a"
	},
	voices = {
		"story_v_out_114251.awb"
	}
}
