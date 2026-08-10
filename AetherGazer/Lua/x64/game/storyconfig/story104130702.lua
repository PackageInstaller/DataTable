return {
	Play413072001 = function(arg_1_0, arg_1_1)
		arg_1_1.time_ = 0
		arg_1_1.frameCnt_ = 0
		arg_1_1.state_ = "playing"
		arg_1_1.curTalkId_ = 413072001
		arg_1_1.duration_ = 5.57

		local var_1_0 = {
			zh = 4.332999999998,
			ja = 5.565999999998
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
				arg_1_0:Play413072002(arg_1_1)
			end
		end

		function arg_1_1.onSingleLineUpdate_(arg_4_0)
			local var_4_0 = "F08g"

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
				local var_4_5 = arg_1_1.bgs_.F08g

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
					if iter_4_0 ~= "F08g" then
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

			local var_4_24 = "10022"

			if arg_1_1.actors_[var_4_24] == nil then
				local var_4_25 = Asset.Load("Widget/System/Story/StoryExpression/" .. "10022")

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

			local var_4_28 = arg_1_1.actors_["10022"].transform
			local var_4_29 = 1.8

			if var_4_29 < arg_1_1.time_ and arg_1_1.time_ <= var_4_29 + arg_4_0 then
				arg_1_1.var_.moveOldPos10022 = var_4_28.localPosition
				var_4_28.localScale = Vector3.New(1, 1, 1)

				arg_1_1:CheckSpriteTmpPos("10022", 3)

				local var_4_30 = var_4_28.childCount

				for iter_4_4 = 0, var_4_30 - 1 do
					local var_4_31 = var_4_28:GetChild(iter_4_4)

					if var_4_31.name == "split_6" or not string.find(var_4_31.name, "split") then
						var_4_31.gameObject:SetActive(true)
					else
						var_4_31.gameObject:SetActive(false)
					end
				end
			end

			local var_4_32 = 0.001

			if var_4_29 <= arg_1_1.time_ and arg_1_1.time_ < var_4_29 + var_4_32 then
				local var_4_33 = (arg_1_1.time_ - var_4_29) / var_4_32
				local var_4_34 = Vector3.New(0, -315, -320)

				var_4_28.localPosition = Vector3.Lerp(arg_1_1.var_.moveOldPos10022, var_4_34, var_4_33)
			end

			if arg_1_1.time_ >= var_4_29 + var_4_32 and arg_1_1.time_ < var_4_29 + var_4_32 + arg_4_0 then
				var_4_28.localPosition = Vector3.New(0, -315, -320)
			end

			local var_4_35 = arg_1_1.actors_["10022"]
			local var_4_36 = 0

			if var_4_36 < arg_1_1.time_ and arg_1_1.time_ <= var_4_36 + arg_4_0 and not isNil(var_4_35) and arg_1_1.var_.actorSpriteComps10022 == nil then
				arg_1_1.var_.actorSpriteComps10022 = var_4_35:GetComponentsInChildren(typeof(Image), true)
			end

			local var_4_37 = 2

			if var_4_36 <= arg_1_1.time_ and arg_1_1.time_ < var_4_36 + var_4_37 and not isNil(var_4_35) then
				local var_4_38 = (arg_1_1.time_ - var_4_36) / var_4_37

				if arg_1_1.var_.actorSpriteComps10022 then
					for iter_4_5, iter_4_6 in pairs(arg_1_1.var_.actorSpriteComps10022:ToTable()) do
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

			if arg_1_1.time_ >= var_4_36 + var_4_37 and arg_1_1.time_ < var_4_36 + var_4_37 + arg_4_0 and not isNil(var_4_35) and arg_1_1.var_.actorSpriteComps10022 then
				for iter_4_7, iter_4_8 in pairs(arg_1_1.var_.actorSpriteComps10022:ToTable()) do
					if iter_4_8 then
						if arg_1_1.isInRecall_ then
							iter_4_8.color = arg_1_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_4_8.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_1_1.var_.actorSpriteComps10022 = nil
			end

			local var_4_43 = arg_1_1.actors_["10022"]
			local var_4_44 = 1.8

			if var_4_44 < arg_1_1.time_ and arg_1_1.time_ <= var_4_44 + arg_4_0 then
				local var_4_45 = var_4_43:GetComponentInChildren(typeof(CanvasGroup))

				if var_4_45 then
					arg_1_1.var_.alphaOldValue10022 = var_4_45.alpha
					arg_1_1.var_.characterEffect10022 = var_4_45
				end

				arg_1_1.var_.alphaOldValue10022 = 0
			end

			local var_4_46 = 0.5

			if var_4_44 <= arg_1_1.time_ and arg_1_1.time_ < var_4_44 + var_4_46 then
				local var_4_47 = (arg_1_1.time_ - var_4_44) / var_4_46
				local var_4_48 = Mathf.Lerp(arg_1_1.var_.alphaOldValue10022, 1, var_4_47)

				if arg_1_1.var_.characterEffect10022 then
					arg_1_1.var_.characterEffect10022.alpha = var_4_48
				end
			end

			if arg_1_1.time_ >= var_4_44 + var_4_46 and arg_1_1.time_ < var_4_44 + var_4_46 + arg_4_0 and arg_1_1.var_.characterEffect10022 then
				arg_1_1.var_.characterEffect10022.alpha = 1
			end

			local var_4_49 = 0
			local var_4_50 = 0.266666666666667

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

			local var_4_55 = 0.366666666666667
			local var_4_56 = 1

			if var_4_55 < arg_1_1.time_ and arg_1_1.time_ <= var_4_55 + arg_4_0 then
				local var_4_57 = "play"
				local var_4_58 = "music"

				arg_1_1:AudioAction(var_4_57, var_4_58, "bgm_activity_3_4_story_crete_intense", "bgm_activity_3_4_story_crete_intense", "bgm_activity_3_4_story_crete_intense.awb")

				local var_4_59 = ""
				local var_4_60 = manager.audio:GetAudioName("bgm_activity_3_4_story_crete_intense", "bgm_activity_3_4_story_crete_intense")

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

			local var_4_61 = 1.999999999998
			local var_4_62 = 0.3

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

				local var_4_64 = arg_1_1:FormatText(StoryNameCfg[614].name)

				arg_1_1.leftNameTxt_.text = var_4_64

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_1_1.leftNameTxt_.transform)

				arg_1_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_1_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_1_1:RecordName(arg_1_1.leftNameTxt_.text)
				SetActive(arg_1_1.iconTrs_.gameObject, false)
				arg_1_1.callingController_:SetSelectedState("normal")

				local var_4_65 = arg_1_1:GetWordFromCfg(413072001)
				local var_4_66 = arg_1_1:FormatText(var_4_65.content)

				arg_1_1.text_.text = var_4_66

				LuaForUtil.ClearLinePrefixSymbol(arg_1_1.text_)

				local var_4_67 = 12
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

				if manager.audio:GetVoiceLength("story_v_out_413072", "413072001", "story_v_out_413072.awb") ~= 0 then
					local var_4_70 = manager.audio:GetVoiceLength("story_v_out_413072", "413072001", "story_v_out_413072.awb") / 1000

					if var_4_70 + var_4_61 > arg_1_1.duration_ then
						arg_1_1.duration_ = var_4_70 + var_4_61
					end

					if var_4_65.prefab_name ~= "" and arg_1_1.actors_[var_4_65.prefab_name] ~= nil then
						local var_4_71 = LuaForUtil.PlayVoiceWithCriLipsync(arg_1_1.actors_[var_4_65.prefab_name].transform, "story_v_out_413072", "413072001", "story_v_out_413072.awb")

						arg_1_1:RecordAudio("413072001", var_4_71)
						arg_1_1:RecordAudio("413072001", var_4_71)
					else
						arg_1_1:AudioAction("play", "voice", "story_v_out_413072", "413072001", "story_v_out_413072.awb")
					end

					arg_1_1:RecordHistoryTalkVoice("story_v_out_413072", "413072001", "story_v_out_413072.awb")
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
				actorName = "10022",
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
	Play413072002 = function(arg_9_0, arg_9_1)
		arg_9_1.time_ = 0
		arg_9_1.frameCnt_ = 0
		arg_9_1.state_ = "playing"
		arg_9_1.curTalkId_ = 413072002
		arg_9_1.duration_ = 3.1

		local var_9_0 = {
			zh = 1.166,
			ja = 3.1
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
				arg_9_0:Play413072003(arg_9_1)
			end
		end

		function arg_9_1.onSingleLineUpdate_(arg_12_0)
			local var_12_0 = 0
			local var_12_1 = 0.175

			if var_12_0 < arg_9_1.time_ and arg_9_1.time_ <= var_12_0 + arg_12_0 then
				arg_9_1.talkMaxDuration = 0
				arg_9_1.dialogCg_.alpha = 1

				arg_9_1.dialog_:SetActive(true)
				SetActive(arg_9_1.leftNameGo_, true)

				local var_12_2 = arg_9_1:FormatText(StoryNameCfg[614].name)

				arg_9_1.leftNameTxt_.text = var_12_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_9_1.leftNameTxt_.transform)

				arg_9_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_9_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_9_1:RecordName(arg_9_1.leftNameTxt_.text)
				SetActive(arg_9_1.iconTrs_.gameObject, false)
				arg_9_1.callingController_:SetSelectedState("normal")

				local var_12_3 = arg_9_1:GetWordFromCfg(413072002)
				local var_12_4 = arg_9_1:FormatText(var_12_3.content)

				arg_9_1.text_.text = var_12_4

				LuaForUtil.ClearLinePrefixSymbol(arg_9_1.text_)

				local var_12_5 = 7
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

				if manager.audio:GetVoiceLength("story_v_out_413072", "413072002", "story_v_out_413072.awb") ~= 0 then
					local var_12_8 = manager.audio:GetVoiceLength("story_v_out_413072", "413072002", "story_v_out_413072.awb") / 1000

					if var_12_8 + var_12_0 > arg_9_1.duration_ then
						arg_9_1.duration_ = var_12_8 + var_12_0
					end

					if var_12_3.prefab_name ~= "" and arg_9_1.actors_[var_12_3.prefab_name] ~= nil then
						local var_12_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_9_1.actors_[var_12_3.prefab_name].transform, "story_v_out_413072", "413072002", "story_v_out_413072.awb")

						arg_9_1:RecordAudio("413072002", var_12_9)
						arg_9_1:RecordAudio("413072002", var_12_9)
					else
						arg_9_1:AudioAction("play", "voice", "story_v_out_413072", "413072002", "story_v_out_413072.awb")
					end

					arg_9_1:RecordHistoryTalkVoice("story_v_out_413072", "413072002", "story_v_out_413072.awb")
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
	Play413072003 = function(arg_13_0, arg_13_1)
		arg_13_1.time_ = 0
		arg_13_1.frameCnt_ = 0
		arg_13_1.state_ = "playing"
		arg_13_1.curTalkId_ = 413072003
		arg_13_1.duration_ = 4.3

		local var_13_0 = {
			zh = 3.733,
			ja = 4.3
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
				arg_13_0:Play413072004(arg_13_1)
			end
		end

		function arg_13_1.onSingleLineUpdate_(arg_16_0)
			local var_16_0 = arg_13_1.actors_["10022"].transform
			local var_16_1 = 0

			if var_16_1 < arg_13_1.time_ and arg_13_1.time_ <= var_16_1 + arg_16_0 then
				arg_13_1.var_.moveOldPos10022 = var_16_0.localPosition
				var_16_0.localScale = Vector3.New(1, 1, 1)

				arg_13_1:CheckSpriteTmpPos("10022", 3)

				local var_16_2 = var_16_0.childCount

				for iter_16_0 = 0, var_16_2 - 1 do
					local var_16_3 = var_16_0:GetChild(iter_16_0)

					if var_16_3.name == "split_6" or not string.find(var_16_3.name, "split") then
						var_16_3.gameObject:SetActive(true)
					else
						var_16_3.gameObject:SetActive(false)
					end
				end
			end

			local var_16_4 = 0.001

			if var_16_1 <= arg_13_1.time_ and arg_13_1.time_ < var_16_1 + var_16_4 then
				local var_16_5 = (arg_13_1.time_ - var_16_1) / var_16_4
				local var_16_6 = Vector3.New(0, -315, -320)

				var_16_0.localPosition = Vector3.Lerp(arg_13_1.var_.moveOldPos10022, var_16_6, var_16_5)
			end

			if arg_13_1.time_ >= var_16_1 + var_16_4 and arg_13_1.time_ < var_16_1 + var_16_4 + arg_16_0 then
				var_16_0.localPosition = Vector3.New(0, -315, -320)
			end

			local var_16_7 = arg_13_1.actors_["10022"]
			local var_16_8 = 0

			if var_16_8 < arg_13_1.time_ and arg_13_1.time_ <= var_16_8 + arg_16_0 and not isNil(var_16_7) and arg_13_1.var_.actorSpriteComps10022 == nil then
				arg_13_1.var_.actorSpriteComps10022 = var_16_7:GetComponentsInChildren(typeof(Image), true)
			end

			local var_16_9 = 2

			if var_16_8 <= arg_13_1.time_ and arg_13_1.time_ < var_16_8 + var_16_9 and not isNil(var_16_7) then
				local var_16_10 = (arg_13_1.time_ - var_16_8) / var_16_9

				if arg_13_1.var_.actorSpriteComps10022 then
					for iter_16_1, iter_16_2 in pairs(arg_13_1.var_.actorSpriteComps10022:ToTable()) do
						if iter_16_2 then
							if arg_13_1.isInRecall_ then
								local var_16_11 = Mathf.Lerp(iter_16_2.color.r, arg_13_1.hightColor2.r, var_16_10)
								local var_16_12 = Mathf.Lerp(iter_16_2.color.g, arg_13_1.hightColor2.g, var_16_10)
								local var_16_13 = Mathf.Lerp(iter_16_2.color.b, arg_13_1.hightColor2.b, var_16_10)

								iter_16_2.color = Color.New(var_16_11, var_16_12, var_16_13)
							else
								local var_16_14 = Mathf.Lerp(iter_16_2.color.r, 0.5, var_16_10)

								iter_16_2.color = Color.New(var_16_14, var_16_14, var_16_14)
							end
						end
					end
				end
			end

			if arg_13_1.time_ >= var_16_8 + var_16_9 and arg_13_1.time_ < var_16_8 + var_16_9 + arg_16_0 and not isNil(var_16_7) and arg_13_1.var_.actorSpriteComps10022 then
				for iter_16_3, iter_16_4 in pairs(arg_13_1.var_.actorSpriteComps10022:ToTable()) do
					if iter_16_4 then
						if arg_13_1.isInRecall_ then
							iter_16_4.color = arg_13_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_16_4.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_13_1.var_.actorSpriteComps10022 = nil
			end

			local var_16_15 = 0
			local var_16_16 = 0.425

			if var_16_15 < arg_13_1.time_ and arg_13_1.time_ <= var_16_15 + arg_16_0 then
				arg_13_1.talkMaxDuration = 0
				arg_13_1.dialogCg_.alpha = 1

				arg_13_1.dialog_:SetActive(true)
				SetActive(arg_13_1.leftNameGo_, true)

				local var_16_17 = arg_13_1:FormatText(StoryNameCfg[992].name)

				arg_13_1.leftNameTxt_.text = var_16_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_13_1.leftNameTxt_.transform)

				arg_13_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_13_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_13_1:RecordName(arg_13_1.leftNameTxt_.text)
				SetActive(arg_13_1.iconTrs_.gameObject, true)
				arg_13_1.iconController_:SetSelectedState("hero")

				arg_13_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_knightman1")

				arg_13_1.callingController_:SetSelectedState("normal")

				arg_13_1.keyicon_.color = Color.New(1, 1, 1)
				arg_13_1.icon_.color = Color.New(1, 1, 1)

				local var_16_18 = arg_13_1:GetWordFromCfg(413072003)
				local var_16_19 = arg_13_1:FormatText(var_16_18.content)

				arg_13_1.text_.text = var_16_19

				LuaForUtil.ClearLinePrefixSymbol(arg_13_1.text_)

				local var_16_20 = 17
				local var_16_21 = utf8.len(var_16_19)
				local var_16_22 = var_16_20 <= 0 and var_16_16 or var_16_16 * (var_16_21 / var_16_20)

				if var_16_22 > 0 and var_16_16 < var_16_22 then
					arg_13_1.talkMaxDuration = var_16_22

					if var_16_22 + var_16_15 > arg_13_1.duration_ then
						arg_13_1.duration_ = var_16_22 + var_16_15
					end
				end

				arg_13_1.text_.text = var_16_19
				arg_13_1.typewritter.percent = 0

				arg_13_1.typewritter:SetDirty()
				arg_13_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_413072", "413072003", "story_v_out_413072.awb") ~= 0 then
					local var_16_23 = manager.audio:GetVoiceLength("story_v_out_413072", "413072003", "story_v_out_413072.awb") / 1000

					if var_16_23 + var_16_15 > arg_13_1.duration_ then
						arg_13_1.duration_ = var_16_23 + var_16_15
					end

					if var_16_18.prefab_name ~= "" and arg_13_1.actors_[var_16_18.prefab_name] ~= nil then
						local var_16_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_13_1.actors_[var_16_18.prefab_name].transform, "story_v_out_413072", "413072003", "story_v_out_413072.awb")

						arg_13_1:RecordAudio("413072003", var_16_24)
						arg_13_1:RecordAudio("413072003", var_16_24)
					else
						arg_13_1:AudioAction("play", "voice", "story_v_out_413072", "413072003", "story_v_out_413072.awb")
					end

					arg_13_1:RecordHistoryTalkVoice("story_v_out_413072", "413072003", "story_v_out_413072.awb")
				end

				arg_13_1:RecordContent(arg_13_1.text_.text)
			end

			local var_16_25 = math.max(var_16_16, arg_13_1.talkMaxDuration)

			if var_16_15 <= arg_13_1.time_ and arg_13_1.time_ < var_16_15 + var_16_25 then
				arg_13_1.typewritter.percent = (arg_13_1.time_ - var_16_15) / var_16_25

				arg_13_1.typewritter:SetDirty()
			end

			if arg_13_1.time_ >= var_16_15 + var_16_25 and arg_13_1.time_ < var_16_15 + var_16_25 + arg_16_0 then
				arg_13_1.typewritter.percent = 1

				arg_13_1.typewritter:SetDirty()
				arg_13_1:ShowNextGo(true)
			end
		end

		arg_13_1.nodeConfigList_ = {
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

		arg_13_1:InitPlayNodeList()
	end,
	Play413072004 = function(arg_17_0, arg_17_1)
		arg_17_1.time_ = 0
		arg_17_1.frameCnt_ = 0
		arg_17_1.state_ = "playing"
		arg_17_1.curTalkId_ = 413072004
		arg_17_1.duration_ = 6.77

		local var_17_0 = {
			zh = 2.633,
			ja = 6.766
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
				arg_17_0:Play413072005(arg_17_1)
			end
		end

		function arg_17_1.onSingleLineUpdate_(arg_20_0)
			local var_20_0 = arg_17_1.actors_["10022"]
			local var_20_1 = 0

			if var_20_1 < arg_17_1.time_ and arg_17_1.time_ <= var_20_1 + arg_20_0 and not isNil(var_20_0) and arg_17_1.var_.actorSpriteComps10022 == nil then
				arg_17_1.var_.actorSpriteComps10022 = var_20_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_20_2 = 2

			if var_20_1 <= arg_17_1.time_ and arg_17_1.time_ < var_20_1 + var_20_2 and not isNil(var_20_0) then
				local var_20_3 = (arg_17_1.time_ - var_20_1) / var_20_2

				if arg_17_1.var_.actorSpriteComps10022 then
					for iter_20_0, iter_20_1 in pairs(arg_17_1.var_.actorSpriteComps10022:ToTable()) do
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

			if arg_17_1.time_ >= var_20_1 + var_20_2 and arg_17_1.time_ < var_20_1 + var_20_2 + arg_20_0 and not isNil(var_20_0) and arg_17_1.var_.actorSpriteComps10022 then
				for iter_20_2, iter_20_3 in pairs(arg_17_1.var_.actorSpriteComps10022:ToTable()) do
					if iter_20_3 then
						if arg_17_1.isInRecall_ then
							iter_20_3.color = arg_17_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_20_3.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_17_1.var_.actorSpriteComps10022 = nil
			end

			local var_20_8 = 0
			local var_20_9 = 0.375

			if var_20_8 < arg_17_1.time_ and arg_17_1.time_ <= var_20_8 + arg_20_0 then
				arg_17_1.talkMaxDuration = 0
				arg_17_1.dialogCg_.alpha = 1

				arg_17_1.dialog_:SetActive(true)
				SetActive(arg_17_1.leftNameGo_, true)

				local var_20_10 = arg_17_1:FormatText(StoryNameCfg[614].name)

				arg_17_1.leftNameTxt_.text = var_20_10

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_17_1.leftNameTxt_.transform)

				arg_17_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_17_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_17_1:RecordName(arg_17_1.leftNameTxt_.text)
				SetActive(arg_17_1.iconTrs_.gameObject, false)
				arg_17_1.callingController_:SetSelectedState("normal")

				local var_20_11 = arg_17_1:GetWordFromCfg(413072004)
				local var_20_12 = arg_17_1:FormatText(var_20_11.content)

				arg_17_1.text_.text = var_20_12

				LuaForUtil.ClearLinePrefixSymbol(arg_17_1.text_)

				local var_20_13 = 15
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

				if manager.audio:GetVoiceLength("story_v_out_413072", "413072004", "story_v_out_413072.awb") ~= 0 then
					local var_20_16 = manager.audio:GetVoiceLength("story_v_out_413072", "413072004", "story_v_out_413072.awb") / 1000

					if var_20_16 + var_20_8 > arg_17_1.duration_ then
						arg_17_1.duration_ = var_20_16 + var_20_8
					end

					if var_20_11.prefab_name ~= "" and arg_17_1.actors_[var_20_11.prefab_name] ~= nil then
						local var_20_17 = LuaForUtil.PlayVoiceWithCriLipsync(arg_17_1.actors_[var_20_11.prefab_name].transform, "story_v_out_413072", "413072004", "story_v_out_413072.awb")

						arg_17_1:RecordAudio("413072004", var_20_17)
						arg_17_1:RecordAudio("413072004", var_20_17)
					else
						arg_17_1:AudioAction("play", "voice", "story_v_out_413072", "413072004", "story_v_out_413072.awb")
					end

					arg_17_1:RecordHistoryTalkVoice("story_v_out_413072", "413072004", "story_v_out_413072.awb")
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
	Play413072005 = function(arg_21_0, arg_21_1)
		arg_21_1.time_ = 0
		arg_21_1.frameCnt_ = 0
		arg_21_1.state_ = "playing"
		arg_21_1.curTalkId_ = 413072005
		arg_21_1.duration_ = 5

		local var_21_0 = {
			zh = 2.2,
			ja = 5
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
				arg_21_0:Play413072006(arg_21_1)
			end
		end

		function arg_21_1.onSingleLineUpdate_(arg_24_0)
			local var_24_0 = 0
			local var_24_1 = 0.25

			if var_24_0 < arg_21_1.time_ and arg_21_1.time_ <= var_24_0 + arg_24_0 then
				arg_21_1.talkMaxDuration = 0
				arg_21_1.dialogCg_.alpha = 1

				arg_21_1.dialog_:SetActive(true)
				SetActive(arg_21_1.leftNameGo_, true)

				local var_24_2 = arg_21_1:FormatText(StoryNameCfg[614].name)

				arg_21_1.leftNameTxt_.text = var_24_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_21_1.leftNameTxt_.transform)

				arg_21_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_21_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_21_1:RecordName(arg_21_1.leftNameTxt_.text)
				SetActive(arg_21_1.iconTrs_.gameObject, false)
				arg_21_1.callingController_:SetSelectedState("normal")

				local var_24_3 = arg_21_1:GetWordFromCfg(413072005)
				local var_24_4 = arg_21_1:FormatText(var_24_3.content)

				arg_21_1.text_.text = var_24_4

				LuaForUtil.ClearLinePrefixSymbol(arg_21_1.text_)

				local var_24_5 = 10
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

				if manager.audio:GetVoiceLength("story_v_out_413072", "413072005", "story_v_out_413072.awb") ~= 0 then
					local var_24_8 = manager.audio:GetVoiceLength("story_v_out_413072", "413072005", "story_v_out_413072.awb") / 1000

					if var_24_8 + var_24_0 > arg_21_1.duration_ then
						arg_21_1.duration_ = var_24_8 + var_24_0
					end

					if var_24_3.prefab_name ~= "" and arg_21_1.actors_[var_24_3.prefab_name] ~= nil then
						local var_24_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_21_1.actors_[var_24_3.prefab_name].transform, "story_v_out_413072", "413072005", "story_v_out_413072.awb")

						arg_21_1:RecordAudio("413072005", var_24_9)
						arg_21_1:RecordAudio("413072005", var_24_9)
					else
						arg_21_1:AudioAction("play", "voice", "story_v_out_413072", "413072005", "story_v_out_413072.awb")
					end

					arg_21_1:RecordHistoryTalkVoice("story_v_out_413072", "413072005", "story_v_out_413072.awb")
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
	Play413072006 = function(arg_25_0, arg_25_1)
		arg_25_1.time_ = 0
		arg_25_1.frameCnt_ = 0
		arg_25_1.state_ = "playing"
		arg_25_1.curTalkId_ = 413072006
		arg_25_1.duration_ = 5.17

		local var_25_0 = {
			zh = 1.999999999999,
			ja = 5.166
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
				arg_25_0:Play413072007(arg_25_1)
			end
		end

		function arg_25_1.onSingleLineUpdate_(arg_28_0)
			local var_28_0 = arg_25_1.actors_["10022"]
			local var_28_1 = 0

			if var_28_1 < arg_25_1.time_ and arg_25_1.time_ <= var_28_1 + arg_28_0 and not isNil(var_28_0) and arg_25_1.var_.actorSpriteComps10022 == nil then
				arg_25_1.var_.actorSpriteComps10022 = var_28_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_28_2 = 2

			if var_28_1 <= arg_25_1.time_ and arg_25_1.time_ < var_28_1 + var_28_2 and not isNil(var_28_0) then
				local var_28_3 = (arg_25_1.time_ - var_28_1) / var_28_2

				if arg_25_1.var_.actorSpriteComps10022 then
					for iter_28_0, iter_28_1 in pairs(arg_25_1.var_.actorSpriteComps10022:ToTable()) do
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

			if arg_25_1.time_ >= var_28_1 + var_28_2 and arg_25_1.time_ < var_28_1 + var_28_2 + arg_28_0 and not isNil(var_28_0) and arg_25_1.var_.actorSpriteComps10022 then
				for iter_28_2, iter_28_3 in pairs(arg_25_1.var_.actorSpriteComps10022:ToTable()) do
					if iter_28_3 then
						if arg_25_1.isInRecall_ then
							iter_28_3.color = arg_25_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_28_3.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_25_1.var_.actorSpriteComps10022 = nil
			end

			local var_28_8 = 0
			local var_28_9 = 0.175

			if var_28_8 < arg_25_1.time_ and arg_25_1.time_ <= var_28_8 + arg_28_0 then
				arg_25_1.talkMaxDuration = 0
				arg_25_1.dialogCg_.alpha = 1

				arg_25_1.dialog_:SetActive(true)
				SetActive(arg_25_1.leftNameGo_, true)

				local var_28_10 = arg_25_1:FormatText(StoryNameCfg[992].name)

				arg_25_1.leftNameTxt_.text = var_28_10

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_25_1.leftNameTxt_.transform)

				arg_25_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_25_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_25_1:RecordName(arg_25_1.leftNameTxt_.text)
				SetActive(arg_25_1.iconTrs_.gameObject, true)
				arg_25_1.iconController_:SetSelectedState("hero")

				arg_25_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_knightman1")

				arg_25_1.callingController_:SetSelectedState("normal")

				arg_25_1.keyicon_.color = Color.New(1, 1, 1)
				arg_25_1.icon_.color = Color.New(1, 1, 1)

				local var_28_11 = arg_25_1:GetWordFromCfg(413072006)
				local var_28_12 = arg_25_1:FormatText(var_28_11.content)

				arg_25_1.text_.text = var_28_12

				LuaForUtil.ClearLinePrefixSymbol(arg_25_1.text_)

				local var_28_13 = 7
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

				if manager.audio:GetVoiceLength("story_v_out_413072", "413072006", "story_v_out_413072.awb") ~= 0 then
					local var_28_16 = manager.audio:GetVoiceLength("story_v_out_413072", "413072006", "story_v_out_413072.awb") / 1000

					if var_28_16 + var_28_8 > arg_25_1.duration_ then
						arg_25_1.duration_ = var_28_16 + var_28_8
					end

					if var_28_11.prefab_name ~= "" and arg_25_1.actors_[var_28_11.prefab_name] ~= nil then
						local var_28_17 = LuaForUtil.PlayVoiceWithCriLipsync(arg_25_1.actors_[var_28_11.prefab_name].transform, "story_v_out_413072", "413072006", "story_v_out_413072.awb")

						arg_25_1:RecordAudio("413072006", var_28_17)
						arg_25_1:RecordAudio("413072006", var_28_17)
					else
						arg_25_1:AudioAction("play", "voice", "story_v_out_413072", "413072006", "story_v_out_413072.awb")
					end

					arg_25_1:RecordHistoryTalkVoice("story_v_out_413072", "413072006", "story_v_out_413072.awb")
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
	Play413072007 = function(arg_29_0, arg_29_1)
		arg_29_1.time_ = 0
		arg_29_1.frameCnt_ = 0
		arg_29_1.state_ = "playing"
		arg_29_1.curTalkId_ = 413072007
		arg_29_1.duration_ = 11.27

		local var_29_0 = {
			zh = 7.1,
			ja = 11.266
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
				arg_29_0:Play413072008(arg_29_1)
			end
		end

		function arg_29_1.onSingleLineUpdate_(arg_32_0)
			local var_32_0 = "F08i"

			if arg_29_1.bgs_[var_32_0] == nil then
				local var_32_1 = Object.Instantiate(arg_29_1.paintGo_)

				var_32_1:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. var_32_0)
				var_32_1.name = var_32_0
				var_32_1.transform.parent = arg_29_1.stage_.transform
				var_32_1.transform.localPosition = Vector3.New(0, 100, 0)
				arg_29_1.bgs_[var_32_0] = var_32_1
			end

			local var_32_2 = 2

			if var_32_2 < arg_29_1.time_ and arg_29_1.time_ <= var_32_2 + arg_32_0 then
				local var_32_3 = manager.ui.mainCamera.transform.localPosition
				local var_32_4 = Vector3.New(0, 0, 10) + Vector3.New(var_32_3.x, var_32_3.y, 0)
				local var_32_5 = arg_29_1.bgs_.F08i

				var_32_5.transform.localPosition = var_32_4
				var_32_5.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_32_6 = var_32_5:GetComponent("SpriteRenderer")

				if var_32_6 and var_32_6.sprite then
					local var_32_7 = (var_32_5.transform.localPosition - var_32_3).z
					local var_32_8 = manager.ui.mainCameraCom_
					local var_32_9 = 2 * var_32_7 * Mathf.Tan(var_32_8.fieldOfView * 0.5 * Mathf.Deg2Rad)
					local var_32_10 = var_32_9 * var_32_8.aspect
					local var_32_11 = var_32_6.sprite.bounds.size.x
					local var_32_12 = var_32_6.sprite.bounds.size.y
					local var_32_13 = var_32_10 / var_32_11
					local var_32_14 = var_32_9 / var_32_12
					local var_32_15 = var_32_14 < var_32_13 and var_32_13 or var_32_14

					var_32_5.transform.localScale = Vector3.New(var_32_15, var_32_15, 0)
				end

				for iter_32_0, iter_32_1 in pairs(arg_29_1.bgs_) do
					if iter_32_0 ~= "F08i" then
						iter_32_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_32_16 = 4

			if var_32_16 < arg_29_1.time_ and arg_29_1.time_ <= var_32_16 + arg_32_0 then
				arg_29_1.allBtn_.enabled = false
			end

			local var_32_17 = 0.3

			if arg_29_1.time_ >= var_32_16 + var_32_17 and arg_29_1.time_ < var_32_16 + var_32_17 + arg_32_0 then
				arg_29_1.allBtn_.enabled = true
			end

			local var_32_18 = 0

			if var_32_18 < arg_29_1.time_ and arg_29_1.time_ <= var_32_18 + arg_32_0 then
				arg_29_1.mask_.enabled = true
				arg_29_1.mask_.raycastTarget = true

				arg_29_1:SetGaussion(false)
			end

			local var_32_19 = 2

			if var_32_18 <= arg_29_1.time_ and arg_29_1.time_ < var_32_18 + var_32_19 then
				local var_32_20 = (arg_29_1.time_ - var_32_18) / var_32_19
				local var_32_21 = Color.New(0, 0, 0)

				var_32_21.a = Mathf.Lerp(0, 1, var_32_20)
				arg_29_1.mask_.color = var_32_21
			end

			if arg_29_1.time_ >= var_32_18 + var_32_19 and arg_29_1.time_ < var_32_18 + var_32_19 + arg_32_0 then
				local var_32_22 = Color.New(0, 0, 0)

				var_32_22.a = 1
				arg_29_1.mask_.color = var_32_22
			end

			local var_32_23 = 2

			if var_32_23 < arg_29_1.time_ and arg_29_1.time_ <= var_32_23 + arg_32_0 then
				arg_29_1.mask_.enabled = true
				arg_29_1.mask_.raycastTarget = true

				arg_29_1:SetGaussion(false)
			end

			local var_32_24 = 2

			if var_32_23 <= arg_29_1.time_ and arg_29_1.time_ < var_32_23 + var_32_24 then
				local var_32_25 = (arg_29_1.time_ - var_32_23) / var_32_24
				local var_32_26 = Color.New(0, 0, 0)

				var_32_26.a = Mathf.Lerp(1, 0, var_32_25)
				arg_29_1.mask_.color = var_32_26
			end

			if arg_29_1.time_ >= var_32_23 + var_32_24 and arg_29_1.time_ < var_32_23 + var_32_24 + arg_32_0 then
				local var_32_27 = Color.New(0, 0, 0)
				local var_32_28 = 0

				arg_29_1.mask_.enabled = false
				var_32_27.a = var_32_28
				arg_29_1.mask_.color = var_32_27
			end

			local var_32_29 = arg_29_1.actors_["10022"].transform
			local var_32_30 = 1.966

			if var_32_30 < arg_29_1.time_ and arg_29_1.time_ <= var_32_30 + arg_32_0 then
				arg_29_1.var_.moveOldPos10022 = var_32_29.localPosition
				var_32_29.localScale = Vector3.New(1, 1, 1)

				arg_29_1:CheckSpriteTmpPos("10022", 7)

				local var_32_31 = var_32_29.childCount

				for iter_32_2 = 0, var_32_31 - 1 do
					local var_32_32 = var_32_29:GetChild(iter_32_2)

					if var_32_32.name == "split_3" or not string.find(var_32_32.name, "split") then
						var_32_32.gameObject:SetActive(true)
					else
						var_32_32.gameObject:SetActive(false)
					end
				end
			end

			local var_32_33 = 0.001

			if var_32_30 <= arg_29_1.time_ and arg_29_1.time_ < var_32_30 + var_32_33 then
				local var_32_34 = (arg_29_1.time_ - var_32_30) / var_32_33
				local var_32_35 = Vector3.New(0, -2000, 0)

				var_32_29.localPosition = Vector3.Lerp(arg_29_1.var_.moveOldPos10022, var_32_35, var_32_34)
			end

			if arg_29_1.time_ >= var_32_30 + var_32_33 and arg_29_1.time_ < var_32_30 + var_32_33 + arg_32_0 then
				var_32_29.localPosition = Vector3.New(0, -2000, 0)
			end

			local var_32_36 = arg_29_1.actors_["10022"]
			local var_32_37 = 1.966

			if var_32_37 < arg_29_1.time_ and arg_29_1.time_ <= var_32_37 + arg_32_0 and not isNil(var_32_36) and arg_29_1.var_.actorSpriteComps10022 == nil then
				arg_29_1.var_.actorSpriteComps10022 = var_32_36:GetComponentsInChildren(typeof(Image), true)
			end

			local var_32_38 = 0.034

			if var_32_37 <= arg_29_1.time_ and arg_29_1.time_ < var_32_37 + var_32_38 and not isNil(var_32_36) then
				local var_32_39 = (arg_29_1.time_ - var_32_37) / var_32_38

				if arg_29_1.var_.actorSpriteComps10022 then
					for iter_32_3, iter_32_4 in pairs(arg_29_1.var_.actorSpriteComps10022:ToTable()) do
						if iter_32_4 then
							if arg_29_1.isInRecall_ then
								local var_32_40 = Mathf.Lerp(iter_32_4.color.r, arg_29_1.hightColor1.r, var_32_39)
								local var_32_41 = Mathf.Lerp(iter_32_4.color.g, arg_29_1.hightColor1.g, var_32_39)
								local var_32_42 = Mathf.Lerp(iter_32_4.color.b, arg_29_1.hightColor1.b, var_32_39)

								iter_32_4.color = Color.New(var_32_40, var_32_41, var_32_42)
							else
								local var_32_43 = Mathf.Lerp(iter_32_4.color.r, 1, var_32_39)

								iter_32_4.color = Color.New(var_32_43, var_32_43, var_32_43)
							end
						end
					end
				end
			end

			if arg_29_1.time_ >= var_32_37 + var_32_38 and arg_29_1.time_ < var_32_37 + var_32_38 + arg_32_0 and not isNil(var_32_36) and arg_29_1.var_.actorSpriteComps10022 then
				for iter_32_5, iter_32_6 in pairs(arg_29_1.var_.actorSpriteComps10022:ToTable()) do
					if iter_32_6 then
						if arg_29_1.isInRecall_ then
							iter_32_6.color = arg_29_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_32_6.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_29_1.var_.actorSpriteComps10022 = nil
			end

			local var_32_44 = arg_29_1.actors_["10022"]
			local var_32_45 = 3.7

			if var_32_45 < arg_29_1.time_ and arg_29_1.time_ <= var_32_45 + arg_32_0 and not isNil(var_32_44) and arg_29_1.var_.actorSpriteComps10022 == nil then
				arg_29_1.var_.actorSpriteComps10022 = var_32_44:GetComponentsInChildren(typeof(Image), true)
			end

			local var_32_46 = 0.034

			if var_32_45 <= arg_29_1.time_ and arg_29_1.time_ < var_32_45 + var_32_46 and not isNil(var_32_44) then
				local var_32_47 = (arg_29_1.time_ - var_32_45) / var_32_46

				if arg_29_1.var_.actorSpriteComps10022 then
					for iter_32_7, iter_32_8 in pairs(arg_29_1.var_.actorSpriteComps10022:ToTable()) do
						if iter_32_8 then
							if arg_29_1.isInRecall_ then
								local var_32_48 = Mathf.Lerp(iter_32_8.color.r, arg_29_1.hightColor1.r, var_32_47)
								local var_32_49 = Mathf.Lerp(iter_32_8.color.g, arg_29_1.hightColor1.g, var_32_47)
								local var_32_50 = Mathf.Lerp(iter_32_8.color.b, arg_29_1.hightColor1.b, var_32_47)

								iter_32_8.color = Color.New(var_32_48, var_32_49, var_32_50)
							else
								local var_32_51 = Mathf.Lerp(iter_32_8.color.r, 1, var_32_47)

								iter_32_8.color = Color.New(var_32_51, var_32_51, var_32_51)
							end
						end
					end
				end
			end

			if arg_29_1.time_ >= var_32_45 + var_32_46 and arg_29_1.time_ < var_32_45 + var_32_46 + arg_32_0 and not isNil(var_32_44) and arg_29_1.var_.actorSpriteComps10022 then
				for iter_32_9, iter_32_10 in pairs(arg_29_1.var_.actorSpriteComps10022:ToTable()) do
					if iter_32_10 then
						if arg_29_1.isInRecall_ then
							iter_32_10.color = arg_29_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_32_10.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_29_1.var_.actorSpriteComps10022 = nil
			end

			local var_32_52 = arg_29_1.actors_["10022"].transform
			local var_32_53 = 3.7

			if var_32_53 < arg_29_1.time_ and arg_29_1.time_ <= var_32_53 + arg_32_0 then
				arg_29_1.var_.moveOldPos10022 = var_32_52.localPosition
				var_32_52.localScale = Vector3.New(1, 1, 1)

				arg_29_1:CheckSpriteTmpPos("10022", 3)

				local var_32_54 = var_32_52.childCount

				for iter_32_11 = 0, var_32_54 - 1 do
					local var_32_55 = var_32_52:GetChild(iter_32_11)

					if var_32_55.name == "split_8" or not string.find(var_32_55.name, "split") then
						var_32_55.gameObject:SetActive(true)
					else
						var_32_55.gameObject:SetActive(false)
					end
				end
			end

			local var_32_56 = 0.001

			if var_32_53 <= arg_29_1.time_ and arg_29_1.time_ < var_32_53 + var_32_56 then
				local var_32_57 = (arg_29_1.time_ - var_32_53) / var_32_56
				local var_32_58 = Vector3.New(0, -315, -320)

				var_32_52.localPosition = Vector3.Lerp(arg_29_1.var_.moveOldPos10022, var_32_58, var_32_57)
			end

			if arg_29_1.time_ >= var_32_53 + var_32_56 and arg_29_1.time_ < var_32_53 + var_32_56 + arg_32_0 then
				var_32_52.localPosition = Vector3.New(0, -315, -320)
			end

			local var_32_59 = arg_29_1.actors_["10022"]
			local var_32_60 = 3.7

			if var_32_60 < arg_29_1.time_ and arg_29_1.time_ <= var_32_60 + arg_32_0 then
				local var_32_61 = var_32_59:GetComponentInChildren(typeof(CanvasGroup))

				if var_32_61 then
					arg_29_1.var_.alphaOldValue10022 = var_32_61.alpha
					arg_29_1.var_.characterEffect10022 = var_32_61
				end

				arg_29_1.var_.alphaOldValue10022 = 0
			end

			local var_32_62 = 0.3

			if var_32_60 <= arg_29_1.time_ and arg_29_1.time_ < var_32_60 + var_32_62 then
				local var_32_63 = (arg_29_1.time_ - var_32_60) / var_32_62
				local var_32_64 = Mathf.Lerp(arg_29_1.var_.alphaOldValue10022, 1, var_32_63)

				if arg_29_1.var_.characterEffect10022 then
					arg_29_1.var_.characterEffect10022.alpha = var_32_64
				end
			end

			if arg_29_1.time_ >= var_32_60 + var_32_62 and arg_29_1.time_ < var_32_60 + var_32_62 + arg_32_0 and arg_29_1.var_.characterEffect10022 then
				arg_29_1.var_.characterEffect10022.alpha = 1
			end

			if arg_29_1.frameCnt_ <= 1 then
				arg_29_1.dialog_:SetActive(false)
			end

			local var_32_65 = 4
			local var_32_66 = 0.35

			if var_32_65 < arg_29_1.time_ and arg_29_1.time_ <= var_32_65 + arg_32_0 then
				arg_29_1.talkMaxDuration = 0

				arg_29_1.dialog_:SetActive(true)

				arg_29_1.dialogCg_.alpha = 0

				local var_32_67 = LeanTween.value(arg_29_1.dialog_, 0, 1, 0.3)

				var_32_67:setOnUpdate(LuaHelper.FloatAction(function(arg_33_0)
					arg_29_1.dialogCg_.alpha = arg_33_0
				end))
				var_32_67:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_29_1.dialog_)
					var_32_67:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_29_1.duration_ = arg_29_1.duration_ + 0.3

				SetActive(arg_29_1.leftNameGo_, true)

				local var_32_68 = arg_29_1:FormatText(StoryNameCfg[614].name)

				arg_29_1.leftNameTxt_.text = var_32_68

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_29_1.leftNameTxt_.transform)

				arg_29_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_29_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_29_1:RecordName(arg_29_1.leftNameTxt_.text)
				SetActive(arg_29_1.iconTrs_.gameObject, false)
				arg_29_1.callingController_:SetSelectedState("normal")

				local var_32_69 = arg_29_1:GetWordFromCfg(413072007)
				local var_32_70 = arg_29_1:FormatText(var_32_69.content)

				arg_29_1.text_.text = var_32_70

				LuaForUtil.ClearLinePrefixSymbol(arg_29_1.text_)

				local var_32_71 = 14
				local var_32_72 = utf8.len(var_32_70)
				local var_32_73 = var_32_71 <= 0 and var_32_66 or var_32_66 * (var_32_72 / var_32_71)

				if var_32_73 > 0 and var_32_66 < var_32_73 then
					arg_29_1.talkMaxDuration = var_32_73
					var_32_65 = var_32_65 + 0.3

					if var_32_73 + var_32_65 > arg_29_1.duration_ then
						arg_29_1.duration_ = var_32_73 + var_32_65
					end
				end

				arg_29_1.text_.text = var_32_70
				arg_29_1.typewritter.percent = 0

				arg_29_1.typewritter:SetDirty()
				arg_29_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_413072", "413072007", "story_v_out_413072.awb") ~= 0 then
					local var_32_74 = manager.audio:GetVoiceLength("story_v_out_413072", "413072007", "story_v_out_413072.awb") / 1000

					if var_32_74 + var_32_65 > arg_29_1.duration_ then
						arg_29_1.duration_ = var_32_74 + var_32_65
					end

					if var_32_69.prefab_name ~= "" and arg_29_1.actors_[var_32_69.prefab_name] ~= nil then
						local var_32_75 = LuaForUtil.PlayVoiceWithCriLipsync(arg_29_1.actors_[var_32_69.prefab_name].transform, "story_v_out_413072", "413072007", "story_v_out_413072.awb")

						arg_29_1:RecordAudio("413072007", var_32_75)
						arg_29_1:RecordAudio("413072007", var_32_75)
					else
						arg_29_1:AudioAction("play", "voice", "story_v_out_413072", "413072007", "story_v_out_413072.awb")
					end

					arg_29_1:RecordHistoryTalkVoice("story_v_out_413072", "413072007", "story_v_out_413072.awb")
				end

				arg_29_1:RecordContent(arg_29_1.text_.text)
			end

			local var_32_76 = var_32_65 + 0.3
			local var_32_77 = math.max(var_32_66, arg_29_1.talkMaxDuration)

			if var_32_76 <= arg_29_1.time_ and arg_29_1.time_ < var_32_76 + var_32_77 then
				arg_29_1.typewritter.percent = (arg_29_1.time_ - var_32_76) / var_32_77

				arg_29_1.typewritter:SetDirty()
			end

			if arg_29_1.time_ >= var_32_76 + var_32_77 and arg_29_1.time_ < var_32_76 + var_32_77 + arg_32_0 then
				arg_29_1.typewritter.percent = 1

				arg_29_1.typewritter:SetDirty()
				arg_29_1:ShowNextGo(true)
			end
		end

		arg_29_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10022",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 1.966,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			},
			{
				assetPath = "",
				actorName = "10022",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 3.7,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_29_1:InitPlayNodeList()
	end,
	Play413072008 = function(arg_35_0, arg_35_1)
		arg_35_1.time_ = 0
		arg_35_1.frameCnt_ = 0
		arg_35_1.state_ = "playing"
		arg_35_1.curTalkId_ = 413072008
		arg_35_1.duration_ = 3.87

		local var_35_0 = {
			zh = 2.566,
			ja = 3.866
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
				arg_35_0:Play413072009(arg_35_1)
			end
		end

		function arg_35_1.onSingleLineUpdate_(arg_38_0)
			local var_38_0 = 0
			local var_38_1 = 0.45

			if var_38_0 < arg_35_1.time_ and arg_35_1.time_ <= var_38_0 + arg_38_0 then
				arg_35_1.talkMaxDuration = 0
				arg_35_1.dialogCg_.alpha = 1

				arg_35_1.dialog_:SetActive(true)
				SetActive(arg_35_1.leftNameGo_, true)

				local var_38_2 = arg_35_1:FormatText(StoryNameCfg[614].name)

				arg_35_1.leftNameTxt_.text = var_38_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_35_1.leftNameTxt_.transform)

				arg_35_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_35_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_35_1:RecordName(arg_35_1.leftNameTxt_.text)
				SetActive(arg_35_1.iconTrs_.gameObject, false)
				arg_35_1.callingController_:SetSelectedState("normal")

				local var_38_3 = arg_35_1:GetWordFromCfg(413072008)
				local var_38_4 = arg_35_1:FormatText(var_38_3.content)

				arg_35_1.text_.text = var_38_4

				LuaForUtil.ClearLinePrefixSymbol(arg_35_1.text_)

				local var_38_5 = 18
				local var_38_6 = utf8.len(var_38_4)
				local var_38_7 = var_38_5 <= 0 and var_38_1 or var_38_1 * (var_38_6 / var_38_5)

				if var_38_7 > 0 and var_38_1 < var_38_7 then
					arg_35_1.talkMaxDuration = var_38_7

					if var_38_7 + var_38_0 > arg_35_1.duration_ then
						arg_35_1.duration_ = var_38_7 + var_38_0
					end
				end

				arg_35_1.text_.text = var_38_4
				arg_35_1.typewritter.percent = 0

				arg_35_1.typewritter:SetDirty()
				arg_35_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_413072", "413072008", "story_v_out_413072.awb") ~= 0 then
					local var_38_8 = manager.audio:GetVoiceLength("story_v_out_413072", "413072008", "story_v_out_413072.awb") / 1000

					if var_38_8 + var_38_0 > arg_35_1.duration_ then
						arg_35_1.duration_ = var_38_8 + var_38_0
					end

					if var_38_3.prefab_name ~= "" and arg_35_1.actors_[var_38_3.prefab_name] ~= nil then
						local var_38_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_35_1.actors_[var_38_3.prefab_name].transform, "story_v_out_413072", "413072008", "story_v_out_413072.awb")

						arg_35_1:RecordAudio("413072008", var_38_9)
						arg_35_1:RecordAudio("413072008", var_38_9)
					else
						arg_35_1:AudioAction("play", "voice", "story_v_out_413072", "413072008", "story_v_out_413072.awb")
					end

					arg_35_1:RecordHistoryTalkVoice("story_v_out_413072", "413072008", "story_v_out_413072.awb")
				end

				arg_35_1:RecordContent(arg_35_1.text_.text)
			end

			local var_38_10 = math.max(var_38_1, arg_35_1.talkMaxDuration)

			if var_38_0 <= arg_35_1.time_ and arg_35_1.time_ < var_38_0 + var_38_10 then
				arg_35_1.typewritter.percent = (arg_35_1.time_ - var_38_0) / var_38_10

				arg_35_1.typewritter:SetDirty()
			end

			if arg_35_1.time_ >= var_38_0 + var_38_10 and arg_35_1.time_ < var_38_0 + var_38_10 + arg_38_0 then
				arg_35_1.typewritter.percent = 1

				arg_35_1.typewritter:SetDirty()
				arg_35_1:ShowNextGo(true)
			end
		end

		arg_35_1.nodeConfigList_ = {}

		arg_35_1:InitPlayNodeList()
	end,
	Play413072009 = function(arg_39_0, arg_39_1)
		arg_39_1.time_ = 0
		arg_39_1.frameCnt_ = 0
		arg_39_1.state_ = "playing"
		arg_39_1.curTalkId_ = 413072009
		arg_39_1.duration_ = 3.77

		local var_39_0 = {
			zh = 2.233,
			ja = 3.766
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
				arg_39_0:Play413072010(arg_39_1)
			end
		end

		function arg_39_1.onSingleLineUpdate_(arg_42_0)
			local var_42_0 = 0
			local var_42_1 = 0.325

			if var_42_0 < arg_39_1.time_ and arg_39_1.time_ <= var_42_0 + arg_42_0 then
				arg_39_1.talkMaxDuration = 0
				arg_39_1.dialogCg_.alpha = 1

				arg_39_1.dialog_:SetActive(true)
				SetActive(arg_39_1.leftNameGo_, true)

				local var_42_2 = arg_39_1:FormatText(StoryNameCfg[614].name)

				arg_39_1.leftNameTxt_.text = var_42_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_39_1.leftNameTxt_.transform)

				arg_39_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_39_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_39_1:RecordName(arg_39_1.leftNameTxt_.text)
				SetActive(arg_39_1.iconTrs_.gameObject, false)
				arg_39_1.callingController_:SetSelectedState("normal")

				local var_42_3 = arg_39_1:GetWordFromCfg(413072009)
				local var_42_4 = arg_39_1:FormatText(var_42_3.content)

				arg_39_1.text_.text = var_42_4

				LuaForUtil.ClearLinePrefixSymbol(arg_39_1.text_)

				local var_42_5 = 13
				local var_42_6 = utf8.len(var_42_4)
				local var_42_7 = var_42_5 <= 0 and var_42_1 or var_42_1 * (var_42_6 / var_42_5)

				if var_42_7 > 0 and var_42_1 < var_42_7 then
					arg_39_1.talkMaxDuration = var_42_7

					if var_42_7 + var_42_0 > arg_39_1.duration_ then
						arg_39_1.duration_ = var_42_7 + var_42_0
					end
				end

				arg_39_1.text_.text = var_42_4
				arg_39_1.typewritter.percent = 0

				arg_39_1.typewritter:SetDirty()
				arg_39_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_413072", "413072009", "story_v_out_413072.awb") ~= 0 then
					local var_42_8 = manager.audio:GetVoiceLength("story_v_out_413072", "413072009", "story_v_out_413072.awb") / 1000

					if var_42_8 + var_42_0 > arg_39_1.duration_ then
						arg_39_1.duration_ = var_42_8 + var_42_0
					end

					if var_42_3.prefab_name ~= "" and arg_39_1.actors_[var_42_3.prefab_name] ~= nil then
						local var_42_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_39_1.actors_[var_42_3.prefab_name].transform, "story_v_out_413072", "413072009", "story_v_out_413072.awb")

						arg_39_1:RecordAudio("413072009", var_42_9)
						arg_39_1:RecordAudio("413072009", var_42_9)
					else
						arg_39_1:AudioAction("play", "voice", "story_v_out_413072", "413072009", "story_v_out_413072.awb")
					end

					arg_39_1:RecordHistoryTalkVoice("story_v_out_413072", "413072009", "story_v_out_413072.awb")
				end

				arg_39_1:RecordContent(arg_39_1.text_.text)
			end

			local var_42_10 = math.max(var_42_1, arg_39_1.talkMaxDuration)

			if var_42_0 <= arg_39_1.time_ and arg_39_1.time_ < var_42_0 + var_42_10 then
				arg_39_1.typewritter.percent = (arg_39_1.time_ - var_42_0) / var_42_10

				arg_39_1.typewritter:SetDirty()
			end

			if arg_39_1.time_ >= var_42_0 + var_42_10 and arg_39_1.time_ < var_42_0 + var_42_10 + arg_42_0 then
				arg_39_1.typewritter.percent = 1

				arg_39_1.typewritter:SetDirty()
				arg_39_1:ShowNextGo(true)
			end
		end

		arg_39_1.nodeConfigList_ = {}

		arg_39_1:InitPlayNodeList()
	end,
	Play413072010 = function(arg_43_0, arg_43_1)
		arg_43_1.time_ = 0
		arg_43_1.frameCnt_ = 0
		arg_43_1.state_ = "playing"
		arg_43_1.curTalkId_ = 413072010
		arg_43_1.duration_ = 3.2

		local var_43_0 = {
			zh = 2.666,
			ja = 3.2
		}
		local var_43_1 = manager.audio:GetLocalizationFlag()

		if var_43_0[var_43_1] ~= nil then
			arg_43_1.duration_ = var_43_0[var_43_1]
		end

		SetActive(arg_43_1.tipsGo_, false)

		function arg_43_1.onSingleLineFinish_()
			arg_43_1.onSingleLineUpdate_ = nil
			arg_43_1.onSingleLineFinish_ = nil
			arg_43_1.state_ = "waiting"
		end

		function arg_43_1.playNext_(arg_45_0)
			if arg_45_0 == 1 then
				arg_43_0:Play413072011(arg_43_1)
			end
		end

		function arg_43_1.onSingleLineUpdate_(arg_46_0)
			local var_46_0 = arg_43_1.actors_["10022"]
			local var_46_1 = 0

			if var_46_1 < arg_43_1.time_ and arg_43_1.time_ <= var_46_1 + arg_46_0 and not isNil(var_46_0) and arg_43_1.var_.actorSpriteComps10022 == nil then
				arg_43_1.var_.actorSpriteComps10022 = var_46_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_46_2 = 2

			if var_46_1 <= arg_43_1.time_ and arg_43_1.time_ < var_46_1 + var_46_2 and not isNil(var_46_0) then
				local var_46_3 = (arg_43_1.time_ - var_46_1) / var_46_2

				if arg_43_1.var_.actorSpriteComps10022 then
					for iter_46_0, iter_46_1 in pairs(arg_43_1.var_.actorSpriteComps10022:ToTable()) do
						if iter_46_1 then
							if arg_43_1.isInRecall_ then
								local var_46_4 = Mathf.Lerp(iter_46_1.color.r, arg_43_1.hightColor2.r, var_46_3)
								local var_46_5 = Mathf.Lerp(iter_46_1.color.g, arg_43_1.hightColor2.g, var_46_3)
								local var_46_6 = Mathf.Lerp(iter_46_1.color.b, arg_43_1.hightColor2.b, var_46_3)

								iter_46_1.color = Color.New(var_46_4, var_46_5, var_46_6)
							else
								local var_46_7 = Mathf.Lerp(iter_46_1.color.r, 0.5, var_46_3)

								iter_46_1.color = Color.New(var_46_7, var_46_7, var_46_7)
							end
						end
					end
				end
			end

			if arg_43_1.time_ >= var_46_1 + var_46_2 and arg_43_1.time_ < var_46_1 + var_46_2 + arg_46_0 and not isNil(var_46_0) and arg_43_1.var_.actorSpriteComps10022 then
				for iter_46_2, iter_46_3 in pairs(arg_43_1.var_.actorSpriteComps10022:ToTable()) do
					if iter_46_3 then
						if arg_43_1.isInRecall_ then
							iter_46_3.color = arg_43_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_46_3.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_43_1.var_.actorSpriteComps10022 = nil
			end

			local var_46_8 = 0
			local var_46_9 = 0.15

			if var_46_8 < arg_43_1.time_ and arg_43_1.time_ <= var_46_8 + arg_46_0 then
				arg_43_1.talkMaxDuration = 0
				arg_43_1.dialogCg_.alpha = 1

				arg_43_1.dialog_:SetActive(true)
				SetActive(arg_43_1.leftNameGo_, true)

				local var_46_10 = arg_43_1:FormatText(StoryNameCfg[993].name)

				arg_43_1.leftNameTxt_.text = var_46_10

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_43_1.leftNameTxt_.transform)

				arg_43_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_43_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_43_1:RecordName(arg_43_1.leftNameTxt_.text)
				SetActive(arg_43_1.iconTrs_.gameObject, true)
				arg_43_1.iconController_:SetSelectedState("hero")

				arg_43_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_citizenmb")

				arg_43_1.callingController_:SetSelectedState("normal")

				arg_43_1.keyicon_.color = Color.New(1, 1, 1)
				arg_43_1.icon_.color = Color.New(1, 1, 1)

				local var_46_11 = arg_43_1:GetWordFromCfg(413072010)
				local var_46_12 = arg_43_1:FormatText(var_46_11.content)

				arg_43_1.text_.text = var_46_12

				LuaForUtil.ClearLinePrefixSymbol(arg_43_1.text_)

				local var_46_13 = 6
				local var_46_14 = utf8.len(var_46_12)
				local var_46_15 = var_46_13 <= 0 and var_46_9 or var_46_9 * (var_46_14 / var_46_13)

				if var_46_15 > 0 and var_46_9 < var_46_15 then
					arg_43_1.talkMaxDuration = var_46_15

					if var_46_15 + var_46_8 > arg_43_1.duration_ then
						arg_43_1.duration_ = var_46_15 + var_46_8
					end
				end

				arg_43_1.text_.text = var_46_12
				arg_43_1.typewritter.percent = 0

				arg_43_1.typewritter:SetDirty()
				arg_43_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_413072", "413072010", "story_v_out_413072.awb") ~= 0 then
					local var_46_16 = manager.audio:GetVoiceLength("story_v_out_413072", "413072010", "story_v_out_413072.awb") / 1000

					if var_46_16 + var_46_8 > arg_43_1.duration_ then
						arg_43_1.duration_ = var_46_16 + var_46_8
					end

					if var_46_11.prefab_name ~= "" and arg_43_1.actors_[var_46_11.prefab_name] ~= nil then
						local var_46_17 = LuaForUtil.PlayVoiceWithCriLipsync(arg_43_1.actors_[var_46_11.prefab_name].transform, "story_v_out_413072", "413072010", "story_v_out_413072.awb")

						arg_43_1:RecordAudio("413072010", var_46_17)
						arg_43_1:RecordAudio("413072010", var_46_17)
					else
						arg_43_1:AudioAction("play", "voice", "story_v_out_413072", "413072010", "story_v_out_413072.awb")
					end

					arg_43_1:RecordHistoryTalkVoice("story_v_out_413072", "413072010", "story_v_out_413072.awb")
				end

				arg_43_1:RecordContent(arg_43_1.text_.text)
			end

			local var_46_18 = math.max(var_46_9, arg_43_1.talkMaxDuration)

			if var_46_8 <= arg_43_1.time_ and arg_43_1.time_ < var_46_8 + var_46_18 then
				arg_43_1.typewritter.percent = (arg_43_1.time_ - var_46_8) / var_46_18

				arg_43_1.typewritter:SetDirty()
			end

			if arg_43_1.time_ >= var_46_8 + var_46_18 and arg_43_1.time_ < var_46_8 + var_46_18 + arg_46_0 then
				arg_43_1.typewritter.percent = 1

				arg_43_1.typewritter:SetDirty()
				arg_43_1:ShowNextGo(true)
			end
		end

		arg_43_1.nodeConfigList_ = {}

		arg_43_1:InitPlayNodeList()
	end,
	Play413072011 = function(arg_47_0, arg_47_1)
		arg_47_1.time_ = 0
		arg_47_1.frameCnt_ = 0
		arg_47_1.state_ = "playing"
		arg_47_1.curTalkId_ = 413072011
		arg_47_1.duration_ = 5

		SetActive(arg_47_1.tipsGo_, false)

		function arg_47_1.onSingleLineFinish_()
			arg_47_1.onSingleLineUpdate_ = nil
			arg_47_1.onSingleLineFinish_ = nil
			arg_47_1.state_ = "waiting"
		end

		function arg_47_1.playNext_(arg_49_0)
			if arg_49_0 == 1 then
				arg_47_0:Play413072012(arg_47_1)
			end
		end

		function arg_47_1.onSingleLineUpdate_(arg_50_0)
			local var_50_0 = arg_47_1.actors_["10022"].transform
			local var_50_1 = 0

			if var_50_1 < arg_47_1.time_ and arg_47_1.time_ <= var_50_1 + arg_50_0 then
				arg_47_1.var_.moveOldPos10022 = var_50_0.localPosition
				var_50_0.localScale = Vector3.New(1, 1, 1)

				arg_47_1:CheckSpriteTmpPos("10022", 7)

				local var_50_2 = var_50_0.childCount

				for iter_50_0 = 0, var_50_2 - 1 do
					local var_50_3 = var_50_0:GetChild(iter_50_0)

					if var_50_3.name == "split_2" or not string.find(var_50_3.name, "split") then
						var_50_3.gameObject:SetActive(true)
					else
						var_50_3.gameObject:SetActive(false)
					end
				end
			end

			local var_50_4 = 0.001

			if var_50_1 <= arg_47_1.time_ and arg_47_1.time_ < var_50_1 + var_50_4 then
				local var_50_5 = (arg_47_1.time_ - var_50_1) / var_50_4
				local var_50_6 = Vector3.New(0, -2000, 0)

				var_50_0.localPosition = Vector3.Lerp(arg_47_1.var_.moveOldPos10022, var_50_6, var_50_5)
			end

			if arg_47_1.time_ >= var_50_1 + var_50_4 and arg_47_1.time_ < var_50_1 + var_50_4 + arg_50_0 then
				var_50_0.localPosition = Vector3.New(0, -2000, 0)
			end

			local var_50_7 = 0
			local var_50_8 = 1.45

			if var_50_7 < arg_47_1.time_ and arg_47_1.time_ <= var_50_7 + arg_50_0 then
				arg_47_1.talkMaxDuration = 0
				arg_47_1.dialogCg_.alpha = 1

				arg_47_1.dialog_:SetActive(true)
				SetActive(arg_47_1.leftNameGo_, false)

				arg_47_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_47_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_47_1:RecordName(arg_47_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_47_1.iconTrs_.gameObject, false)
				arg_47_1.callingController_:SetSelectedState("normal")

				local var_50_9 = arg_47_1:GetWordFromCfg(413072011)
				local var_50_10 = arg_47_1:FormatText(var_50_9.content)

				arg_47_1.text_.text = var_50_10

				LuaForUtil.ClearLinePrefixSymbol(arg_47_1.text_)

				local var_50_11 = 58
				local var_50_12 = utf8.len(var_50_10)
				local var_50_13 = var_50_11 <= 0 and var_50_8 or var_50_8 * (var_50_12 / var_50_11)

				if var_50_13 > 0 and var_50_8 < var_50_13 then
					arg_47_1.talkMaxDuration = var_50_13

					if var_50_13 + var_50_7 > arg_47_1.duration_ then
						arg_47_1.duration_ = var_50_13 + var_50_7
					end
				end

				arg_47_1.text_.text = var_50_10
				arg_47_1.typewritter.percent = 0

				arg_47_1.typewritter:SetDirty()
				arg_47_1:ShowNextGo(false)
				arg_47_1:RecordContent(arg_47_1.text_.text)
			end

			local var_50_14 = math.max(var_50_8, arg_47_1.talkMaxDuration)

			if var_50_7 <= arg_47_1.time_ and arg_47_1.time_ < var_50_7 + var_50_14 then
				arg_47_1.typewritter.percent = (arg_47_1.time_ - var_50_7) / var_50_14

				arg_47_1.typewritter:SetDirty()
			end

			if arg_47_1.time_ >= var_50_7 + var_50_14 and arg_47_1.time_ < var_50_7 + var_50_14 + arg_50_0 then
				arg_47_1.typewritter.percent = 1

				arg_47_1.typewritter:SetDirty()
				arg_47_1:ShowNextGo(true)
			end
		end

		arg_47_1.nodeConfigList_ = {
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

		arg_47_1:InitPlayNodeList()
	end,
	Play413072012 = function(arg_51_0, arg_51_1)
		arg_51_1.time_ = 0
		arg_51_1.frameCnt_ = 0
		arg_51_1.state_ = "playing"
		arg_51_1.curTalkId_ = 413072012
		arg_51_1.duration_ = 2.87

		local var_51_0 = {
			zh = 1.366,
			ja = 2.866
		}
		local var_51_1 = manager.audio:GetLocalizationFlag()

		if var_51_0[var_51_1] ~= nil then
			arg_51_1.duration_ = var_51_0[var_51_1]
		end

		SetActive(arg_51_1.tipsGo_, false)

		function arg_51_1.onSingleLineFinish_()
			arg_51_1.onSingleLineUpdate_ = nil
			arg_51_1.onSingleLineFinish_ = nil
			arg_51_1.state_ = "waiting"
		end

		function arg_51_1.playNext_(arg_53_0)
			if arg_53_0 == 1 then
				arg_51_0:Play413072013(arg_51_1)
			end
		end

		function arg_51_1.onSingleLineUpdate_(arg_54_0)
			local var_54_0 = 0
			local var_54_1 = 0.175

			if var_54_0 < arg_51_1.time_ and arg_51_1.time_ <= var_54_0 + arg_54_0 then
				arg_51_1.talkMaxDuration = 0
				arg_51_1.dialogCg_.alpha = 1

				arg_51_1.dialog_:SetActive(true)
				SetActive(arg_51_1.leftNameGo_, true)

				local var_54_2 = arg_51_1:FormatText(StoryNameCfg[614].name)

				arg_51_1.leftNameTxt_.text = var_54_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_51_1.leftNameTxt_.transform)

				arg_51_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_51_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_51_1:RecordName(arg_51_1.leftNameTxt_.text)
				SetActive(arg_51_1.iconTrs_.gameObject, true)
				arg_51_1.iconController_:SetSelectedState("hero")

				arg_51_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_10022_split_2")

				arg_51_1.callingController_:SetSelectedState("normal")

				arg_51_1.keyicon_.color = Color.New(1, 1, 1)
				arg_51_1.icon_.color = Color.New(1, 1, 1)

				local var_54_3 = arg_51_1:GetWordFromCfg(413072012)
				local var_54_4 = arg_51_1:FormatText(var_54_3.content)

				arg_51_1.text_.text = var_54_4

				LuaForUtil.ClearLinePrefixSymbol(arg_51_1.text_)

				local var_54_5 = 7
				local var_54_6 = utf8.len(var_54_4)
				local var_54_7 = var_54_5 <= 0 and var_54_1 or var_54_1 * (var_54_6 / var_54_5)

				if var_54_7 > 0 and var_54_1 < var_54_7 then
					arg_51_1.talkMaxDuration = var_54_7

					if var_54_7 + var_54_0 > arg_51_1.duration_ then
						arg_51_1.duration_ = var_54_7 + var_54_0
					end
				end

				arg_51_1.text_.text = var_54_4
				arg_51_1.typewritter.percent = 0

				arg_51_1.typewritter:SetDirty()
				arg_51_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_413072", "413072012", "story_v_out_413072.awb") ~= 0 then
					local var_54_8 = manager.audio:GetVoiceLength("story_v_out_413072", "413072012", "story_v_out_413072.awb") / 1000

					if var_54_8 + var_54_0 > arg_51_1.duration_ then
						arg_51_1.duration_ = var_54_8 + var_54_0
					end

					if var_54_3.prefab_name ~= "" and arg_51_1.actors_[var_54_3.prefab_name] ~= nil then
						local var_54_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_51_1.actors_[var_54_3.prefab_name].transform, "story_v_out_413072", "413072012", "story_v_out_413072.awb")

						arg_51_1:RecordAudio("413072012", var_54_9)
						arg_51_1:RecordAudio("413072012", var_54_9)
					else
						arg_51_1:AudioAction("play", "voice", "story_v_out_413072", "413072012", "story_v_out_413072.awb")
					end

					arg_51_1:RecordHistoryTalkVoice("story_v_out_413072", "413072012", "story_v_out_413072.awb")
				end

				arg_51_1:RecordContent(arg_51_1.text_.text)
			end

			local var_54_10 = math.max(var_54_1, arg_51_1.talkMaxDuration)

			if var_54_0 <= arg_51_1.time_ and arg_51_1.time_ < var_54_0 + var_54_10 then
				arg_51_1.typewritter.percent = (arg_51_1.time_ - var_54_0) / var_54_10

				arg_51_1.typewritter:SetDirty()
			end

			if arg_51_1.time_ >= var_54_0 + var_54_10 and arg_51_1.time_ < var_54_0 + var_54_10 + arg_54_0 then
				arg_51_1.typewritter.percent = 1

				arg_51_1.typewritter:SetDirty()
				arg_51_1:ShowNextGo(true)
			end
		end

		arg_51_1.nodeConfigList_ = {}

		arg_51_1:InitPlayNodeList()
	end,
	Play413072013 = function(arg_55_0, arg_55_1)
		arg_55_1.time_ = 0
		arg_55_1.frameCnt_ = 0
		arg_55_1.state_ = "playing"
		arg_55_1.curTalkId_ = 413072013
		arg_55_1.duration_ = 2.33

		local var_55_0 = {
			zh = 2.33333333333333,
			ja = 2.03333333333333
		}
		local var_55_1 = manager.audio:GetLocalizationFlag()

		if var_55_0[var_55_1] ~= nil then
			arg_55_1.duration_ = var_55_0[var_55_1]
		end

		SetActive(arg_55_1.tipsGo_, false)

		function arg_55_1.onSingleLineFinish_()
			arg_55_1.onSingleLineUpdate_ = nil
			arg_55_1.onSingleLineFinish_ = nil
			arg_55_1.state_ = "waiting"
		end

		function arg_55_1.playNext_(arg_57_0)
			if arg_57_0 == 1 then
				arg_55_0:Play413072014(arg_55_1)
			end
		end

		function arg_55_1.onSingleLineUpdate_(arg_58_0)
			local var_58_0 = manager.ui.mainCamera.transform
			local var_58_1 = 0

			if var_58_1 < arg_55_1.time_ and arg_55_1.time_ <= var_58_1 + arg_58_0 then
				local var_58_2 = arg_55_1.var_.effect233
				local var_58_3
				local var_58_4 = var_58_0

				if not var_58_2 then
					var_58_2 = Object.Instantiate(Asset.Load("Effect/Scene/fx_ui_slash_01"), var_58_4)
					var_58_2.name = "233"
					arg_55_1.var_.effect233 = var_58_2
				else
					var_58_2.transform:SetParent(var_58_4)
				end

				var_58_2.transform.localPosition = Vector3.New(0, 0, 0.44)
				var_58_2.transform.localRotation = Quaternion.Euler(0, 0, 0)
			end

			local var_58_5 = manager.ui.mainCamera.transform
			local var_58_6 = 0.633333333333333

			if var_58_6 < arg_55_1.time_ and arg_55_1.time_ <= var_58_6 + arg_58_0 then
				local var_58_7 = arg_55_1.var_.effect233

				if var_58_7 then
					Object.Destroy(var_58_7)

					arg_55_1.var_.effect233 = nil
				end
			end

			local var_58_8 = arg_55_1.actors_["10022"].transform
			local var_58_9 = 0

			if var_58_9 < arg_55_1.time_ and arg_55_1.time_ <= var_58_9 + arg_58_0 then
				arg_55_1.var_.moveOldPos10022 = var_58_8.localPosition
				var_58_8.localScale = Vector3.New(1, 1, 1)

				arg_55_1:CheckSpriteTmpPos("10022", 7)

				local var_58_10 = var_58_8.childCount

				for iter_58_0 = 0, var_58_10 - 1 do
					local var_58_11 = var_58_8:GetChild(iter_58_0)

					if var_58_11.name == "split_2" or not string.find(var_58_11.name, "split") then
						var_58_11.gameObject:SetActive(true)
					else
						var_58_11.gameObject:SetActive(false)
					end
				end
			end

			local var_58_12 = 0.001

			if var_58_9 <= arg_55_1.time_ and arg_55_1.time_ < var_58_9 + var_58_12 then
				local var_58_13 = (arg_55_1.time_ - var_58_9) / var_58_12
				local var_58_14 = Vector3.New(0, -2000, 0)

				var_58_8.localPosition = Vector3.Lerp(arg_55_1.var_.moveOldPos10022, var_58_14, var_58_13)
			end

			if arg_55_1.time_ >= var_58_9 + var_58_12 and arg_55_1.time_ < var_58_9 + var_58_12 + arg_58_0 then
				var_58_8.localPosition = Vector3.New(0, -2000, 0)
			end

			local var_58_15 = 0
			local var_58_16 = 0.733333333333333

			if var_58_15 < arg_55_1.time_ and arg_55_1.time_ <= var_58_15 + arg_58_0 then
				local var_58_17 = "play"
				local var_58_18 = "effect"

				arg_55_1:AudioAction(var_58_17, var_58_18, "se_story_10", "se_story_10_sword02", "")
			end

			local var_58_19 = 0.533333333333333
			local var_58_20 = 0.2

			if var_58_19 < arg_55_1.time_ and arg_55_1.time_ <= var_58_19 + arg_58_0 then
				arg_55_1.talkMaxDuration = 0
				arg_55_1.dialogCg_.alpha = 1

				arg_55_1.dialog_:SetActive(true)
				SetActive(arg_55_1.leftNameGo_, true)

				local var_58_21 = arg_55_1:FormatText(StoryNameCfg[614].name)

				arg_55_1.leftNameTxt_.text = var_58_21

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_55_1.leftNameTxt_.transform)

				arg_55_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_55_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_55_1:RecordName(arg_55_1.leftNameTxt_.text)
				SetActive(arg_55_1.iconTrs_.gameObject, true)
				arg_55_1.iconController_:SetSelectedState("hero")

				arg_55_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_10022_split_2")

				arg_55_1.callingController_:SetSelectedState("normal")

				arg_55_1.keyicon_.color = Color.New(1, 1, 1)
				arg_55_1.icon_.color = Color.New(1, 1, 1)

				local var_58_22 = arg_55_1:GetWordFromCfg(413072013)
				local var_58_23 = arg_55_1:FormatText(var_58_22.content)

				arg_55_1.text_.text = var_58_23

				LuaForUtil.ClearLinePrefixSymbol(arg_55_1.text_)

				local var_58_24 = 8
				local var_58_25 = utf8.len(var_58_23)
				local var_58_26 = var_58_24 <= 0 and var_58_20 or var_58_20 * (var_58_25 / var_58_24)

				if var_58_26 > 0 and var_58_20 < var_58_26 then
					arg_55_1.talkMaxDuration = var_58_26

					if var_58_26 + var_58_19 > arg_55_1.duration_ then
						arg_55_1.duration_ = var_58_26 + var_58_19
					end
				end

				arg_55_1.text_.text = var_58_23
				arg_55_1.typewritter.percent = 0

				arg_55_1.typewritter:SetDirty()
				arg_55_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_413072", "413072013", "story_v_out_413072.awb") ~= 0 then
					local var_58_27 = manager.audio:GetVoiceLength("story_v_out_413072", "413072013", "story_v_out_413072.awb") / 1000

					if var_58_27 + var_58_19 > arg_55_1.duration_ then
						arg_55_1.duration_ = var_58_27 + var_58_19
					end

					if var_58_22.prefab_name ~= "" and arg_55_1.actors_[var_58_22.prefab_name] ~= nil then
						local var_58_28 = LuaForUtil.PlayVoiceWithCriLipsync(arg_55_1.actors_[var_58_22.prefab_name].transform, "story_v_out_413072", "413072013", "story_v_out_413072.awb")

						arg_55_1:RecordAudio("413072013", var_58_28)
						arg_55_1:RecordAudio("413072013", var_58_28)
					else
						arg_55_1:AudioAction("play", "voice", "story_v_out_413072", "413072013", "story_v_out_413072.awb")
					end

					arg_55_1:RecordHistoryTalkVoice("story_v_out_413072", "413072013", "story_v_out_413072.awb")
				end

				arg_55_1:RecordContent(arg_55_1.text_.text)
			end

			local var_58_29 = math.max(var_58_20, arg_55_1.talkMaxDuration)

			if var_58_19 <= arg_55_1.time_ and arg_55_1.time_ < var_58_19 + var_58_29 then
				arg_55_1.typewritter.percent = (arg_55_1.time_ - var_58_19) / var_58_29

				arg_55_1.typewritter:SetDirty()
			end

			if arg_55_1.time_ >= var_58_19 + var_58_29 and arg_55_1.time_ < var_58_19 + var_58_29 + arg_58_0 then
				arg_55_1.typewritter.percent = 1

				arg_55_1.typewritter:SetDirty()
				arg_55_1:ShowNextGo(true)
			end
		end

		arg_55_1.nodeConfigList_ = {
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

		arg_55_1:InitPlayNodeList()
	end,
	Play413072014 = function(arg_59_0, arg_59_1)
		arg_59_1.time_ = 0
		arg_59_1.frameCnt_ = 0
		arg_59_1.state_ = "playing"
		arg_59_1.curTalkId_ = 413072014
		arg_59_1.duration_ = 5.6

		local var_59_0 = {
			zh = 3.966,
			ja = 5.6
		}
		local var_59_1 = manager.audio:GetLocalizationFlag()

		if var_59_0[var_59_1] ~= nil then
			arg_59_1.duration_ = var_59_0[var_59_1]
		end

		SetActive(arg_59_1.tipsGo_, false)

		function arg_59_1.onSingleLineFinish_()
			arg_59_1.onSingleLineUpdate_ = nil
			arg_59_1.onSingleLineFinish_ = nil
			arg_59_1.state_ = "waiting"
		end

		function arg_59_1.playNext_(arg_61_0)
			if arg_61_0 == 1 then
				arg_59_0:Play413072015(arg_59_1)
			end
		end

		function arg_59_1.onSingleLineUpdate_(arg_62_0)
			local var_62_0 = arg_59_1.actors_["10022"]
			local var_62_1 = 0

			if var_62_1 < arg_59_1.time_ and arg_59_1.time_ <= var_62_1 + arg_62_0 and not isNil(var_62_0) and arg_59_1.var_.actorSpriteComps10022 == nil then
				arg_59_1.var_.actorSpriteComps10022 = var_62_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_62_2 = 2

			if var_62_1 <= arg_59_1.time_ and arg_59_1.time_ < var_62_1 + var_62_2 and not isNil(var_62_0) then
				local var_62_3 = (arg_59_1.time_ - var_62_1) / var_62_2

				if arg_59_1.var_.actorSpriteComps10022 then
					for iter_62_0, iter_62_1 in pairs(arg_59_1.var_.actorSpriteComps10022:ToTable()) do
						if iter_62_1 then
							if arg_59_1.isInRecall_ then
								local var_62_4 = Mathf.Lerp(iter_62_1.color.r, arg_59_1.hightColor2.r, var_62_3)
								local var_62_5 = Mathf.Lerp(iter_62_1.color.g, arg_59_1.hightColor2.g, var_62_3)
								local var_62_6 = Mathf.Lerp(iter_62_1.color.b, arg_59_1.hightColor2.b, var_62_3)

								iter_62_1.color = Color.New(var_62_4, var_62_5, var_62_6)
							else
								local var_62_7 = Mathf.Lerp(iter_62_1.color.r, 0.5, var_62_3)

								iter_62_1.color = Color.New(var_62_7, var_62_7, var_62_7)
							end
						end
					end
				end
			end

			if arg_59_1.time_ >= var_62_1 + var_62_2 and arg_59_1.time_ < var_62_1 + var_62_2 + arg_62_0 and not isNil(var_62_0) and arg_59_1.var_.actorSpriteComps10022 then
				for iter_62_2, iter_62_3 in pairs(arg_59_1.var_.actorSpriteComps10022:ToTable()) do
					if iter_62_3 then
						if arg_59_1.isInRecall_ then
							iter_62_3.color = arg_59_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_62_3.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_59_1.var_.actorSpriteComps10022 = nil
			end

			local var_62_8 = 0
			local var_62_9 = 0.275

			if var_62_8 < arg_59_1.time_ and arg_59_1.time_ <= var_62_8 + arg_62_0 then
				arg_59_1.talkMaxDuration = 0
				arg_59_1.dialogCg_.alpha = 1

				arg_59_1.dialog_:SetActive(true)
				SetActive(arg_59_1.leftNameGo_, true)

				local var_62_10 = arg_59_1:FormatText(StoryNameCfg[993].name)

				arg_59_1.leftNameTxt_.text = var_62_10

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_59_1.leftNameTxt_.transform)

				arg_59_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_59_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_59_1:RecordName(arg_59_1.leftNameTxt_.text)
				SetActive(arg_59_1.iconTrs_.gameObject, true)
				arg_59_1.iconController_:SetSelectedState("hero")

				arg_59_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_citizenmb")

				arg_59_1.callingController_:SetSelectedState("normal")

				arg_59_1.keyicon_.color = Color.New(1, 1, 1)
				arg_59_1.icon_.color = Color.New(1, 1, 1)

				local var_62_11 = arg_59_1:GetWordFromCfg(413072014)
				local var_62_12 = arg_59_1:FormatText(var_62_11.content)

				arg_59_1.text_.text = var_62_12

				LuaForUtil.ClearLinePrefixSymbol(arg_59_1.text_)

				local var_62_13 = 11
				local var_62_14 = utf8.len(var_62_12)
				local var_62_15 = var_62_13 <= 0 and var_62_9 or var_62_9 * (var_62_14 / var_62_13)

				if var_62_15 > 0 and var_62_9 < var_62_15 then
					arg_59_1.talkMaxDuration = var_62_15

					if var_62_15 + var_62_8 > arg_59_1.duration_ then
						arg_59_1.duration_ = var_62_15 + var_62_8
					end
				end

				arg_59_1.text_.text = var_62_12
				arg_59_1.typewritter.percent = 0

				arg_59_1.typewritter:SetDirty()
				arg_59_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_413072", "413072014", "story_v_out_413072.awb") ~= 0 then
					local var_62_16 = manager.audio:GetVoiceLength("story_v_out_413072", "413072014", "story_v_out_413072.awb") / 1000

					if var_62_16 + var_62_8 > arg_59_1.duration_ then
						arg_59_1.duration_ = var_62_16 + var_62_8
					end

					if var_62_11.prefab_name ~= "" and arg_59_1.actors_[var_62_11.prefab_name] ~= nil then
						local var_62_17 = LuaForUtil.PlayVoiceWithCriLipsync(arg_59_1.actors_[var_62_11.prefab_name].transform, "story_v_out_413072", "413072014", "story_v_out_413072.awb")

						arg_59_1:RecordAudio("413072014", var_62_17)
						arg_59_1:RecordAudio("413072014", var_62_17)
					else
						arg_59_1:AudioAction("play", "voice", "story_v_out_413072", "413072014", "story_v_out_413072.awb")
					end

					arg_59_1:RecordHistoryTalkVoice("story_v_out_413072", "413072014", "story_v_out_413072.awb")
				end

				arg_59_1:RecordContent(arg_59_1.text_.text)
			end

			local var_62_18 = math.max(var_62_9, arg_59_1.talkMaxDuration)

			if var_62_8 <= arg_59_1.time_ and arg_59_1.time_ < var_62_8 + var_62_18 then
				arg_59_1.typewritter.percent = (arg_59_1.time_ - var_62_8) / var_62_18

				arg_59_1.typewritter:SetDirty()
			end

			if arg_59_1.time_ >= var_62_8 + var_62_18 and arg_59_1.time_ < var_62_8 + var_62_18 + arg_62_0 then
				arg_59_1.typewritter.percent = 1

				arg_59_1.typewritter:SetDirty()
				arg_59_1:ShowNextGo(true)
			end
		end

		arg_59_1.nodeConfigList_ = {}

		arg_59_1:InitPlayNodeList()
	end,
	Play413072015 = function(arg_63_0, arg_63_1)
		arg_63_1.time_ = 0
		arg_63_1.frameCnt_ = 0
		arg_63_1.state_ = "playing"
		arg_63_1.curTalkId_ = 413072015
		arg_63_1.duration_ = 5.6

		local var_63_0 = {
			zh = 3,
			ja = 5.6
		}
		local var_63_1 = manager.audio:GetLocalizationFlag()

		if var_63_0[var_63_1] ~= nil then
			arg_63_1.duration_ = var_63_0[var_63_1]
		end

		SetActive(arg_63_1.tipsGo_, false)

		function arg_63_1.onSingleLineFinish_()
			arg_63_1.onSingleLineUpdate_ = nil
			arg_63_1.onSingleLineFinish_ = nil
			arg_63_1.state_ = "waiting"
		end

		function arg_63_1.playNext_(arg_65_0)
			if arg_65_0 == 1 then
				arg_63_0:Play413072016(arg_63_1)
			end
		end

		function arg_63_1.onSingleLineUpdate_(arg_66_0)
			local var_66_0 = arg_63_1.actors_["10022"].transform
			local var_66_1 = 0

			if var_66_1 < arg_63_1.time_ and arg_63_1.time_ <= var_66_1 + arg_66_0 then
				arg_63_1.var_.moveOldPos10022 = var_66_0.localPosition
				var_66_0.localScale = Vector3.New(1, 1, 1)

				arg_63_1:CheckSpriteTmpPos("10022", 3)

				local var_66_2 = var_66_0.childCount

				for iter_66_0 = 0, var_66_2 - 1 do
					local var_66_3 = var_66_0:GetChild(iter_66_0)

					if var_66_3.name == "split_8" or not string.find(var_66_3.name, "split") then
						var_66_3.gameObject:SetActive(true)
					else
						var_66_3.gameObject:SetActive(false)
					end
				end
			end

			local var_66_4 = 0.001

			if var_66_1 <= arg_63_1.time_ and arg_63_1.time_ < var_66_1 + var_66_4 then
				local var_66_5 = (arg_63_1.time_ - var_66_1) / var_66_4
				local var_66_6 = Vector3.New(0, -315, -320)

				var_66_0.localPosition = Vector3.Lerp(arg_63_1.var_.moveOldPos10022, var_66_6, var_66_5)
			end

			if arg_63_1.time_ >= var_66_1 + var_66_4 and arg_63_1.time_ < var_66_1 + var_66_4 + arg_66_0 then
				var_66_0.localPosition = Vector3.New(0, -315, -320)
			end

			local var_66_7 = arg_63_1.actors_["10022"]
			local var_66_8 = 0

			if var_66_8 < arg_63_1.time_ and arg_63_1.time_ <= var_66_8 + arg_66_0 and not isNil(var_66_7) and arg_63_1.var_.actorSpriteComps10022 == nil then
				arg_63_1.var_.actorSpriteComps10022 = var_66_7:GetComponentsInChildren(typeof(Image), true)
			end

			local var_66_9 = 2

			if var_66_8 <= arg_63_1.time_ and arg_63_1.time_ < var_66_8 + var_66_9 and not isNil(var_66_7) then
				local var_66_10 = (arg_63_1.time_ - var_66_8) / var_66_9

				if arg_63_1.var_.actorSpriteComps10022 then
					for iter_66_1, iter_66_2 in pairs(arg_63_1.var_.actorSpriteComps10022:ToTable()) do
						if iter_66_2 then
							if arg_63_1.isInRecall_ then
								local var_66_11 = Mathf.Lerp(iter_66_2.color.r, arg_63_1.hightColor1.r, var_66_10)
								local var_66_12 = Mathf.Lerp(iter_66_2.color.g, arg_63_1.hightColor1.g, var_66_10)
								local var_66_13 = Mathf.Lerp(iter_66_2.color.b, arg_63_1.hightColor1.b, var_66_10)

								iter_66_2.color = Color.New(var_66_11, var_66_12, var_66_13)
							else
								local var_66_14 = Mathf.Lerp(iter_66_2.color.r, 1, var_66_10)

								iter_66_2.color = Color.New(var_66_14, var_66_14, var_66_14)
							end
						end
					end
				end
			end

			if arg_63_1.time_ >= var_66_8 + var_66_9 and arg_63_1.time_ < var_66_8 + var_66_9 + arg_66_0 and not isNil(var_66_7) and arg_63_1.var_.actorSpriteComps10022 then
				for iter_66_3, iter_66_4 in pairs(arg_63_1.var_.actorSpriteComps10022:ToTable()) do
					if iter_66_4 then
						if arg_63_1.isInRecall_ then
							iter_66_4.color = arg_63_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_66_4.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_63_1.var_.actorSpriteComps10022 = nil
			end

			local var_66_15 = 0
			local var_66_16 = 0.45

			if var_66_15 < arg_63_1.time_ and arg_63_1.time_ <= var_66_15 + arg_66_0 then
				arg_63_1.talkMaxDuration = 0
				arg_63_1.dialogCg_.alpha = 1

				arg_63_1.dialog_:SetActive(true)
				SetActive(arg_63_1.leftNameGo_, true)

				local var_66_17 = arg_63_1:FormatText(StoryNameCfg[614].name)

				arg_63_1.leftNameTxt_.text = var_66_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_63_1.leftNameTxt_.transform)

				arg_63_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_63_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_63_1:RecordName(arg_63_1.leftNameTxt_.text)
				SetActive(arg_63_1.iconTrs_.gameObject, false)
				arg_63_1.callingController_:SetSelectedState("normal")

				local var_66_18 = arg_63_1:GetWordFromCfg(413072015)
				local var_66_19 = arg_63_1:FormatText(var_66_18.content)

				arg_63_1.text_.text = var_66_19

				LuaForUtil.ClearLinePrefixSymbol(arg_63_1.text_)

				local var_66_20 = 18
				local var_66_21 = utf8.len(var_66_19)
				local var_66_22 = var_66_20 <= 0 and var_66_16 or var_66_16 * (var_66_21 / var_66_20)

				if var_66_22 > 0 and var_66_16 < var_66_22 then
					arg_63_1.talkMaxDuration = var_66_22

					if var_66_22 + var_66_15 > arg_63_1.duration_ then
						arg_63_1.duration_ = var_66_22 + var_66_15
					end
				end

				arg_63_1.text_.text = var_66_19
				arg_63_1.typewritter.percent = 0

				arg_63_1.typewritter:SetDirty()
				arg_63_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_413072", "413072015", "story_v_out_413072.awb") ~= 0 then
					local var_66_23 = manager.audio:GetVoiceLength("story_v_out_413072", "413072015", "story_v_out_413072.awb") / 1000

					if var_66_23 + var_66_15 > arg_63_1.duration_ then
						arg_63_1.duration_ = var_66_23 + var_66_15
					end

					if var_66_18.prefab_name ~= "" and arg_63_1.actors_[var_66_18.prefab_name] ~= nil then
						local var_66_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_63_1.actors_[var_66_18.prefab_name].transform, "story_v_out_413072", "413072015", "story_v_out_413072.awb")

						arg_63_1:RecordAudio("413072015", var_66_24)
						arg_63_1:RecordAudio("413072015", var_66_24)
					else
						arg_63_1:AudioAction("play", "voice", "story_v_out_413072", "413072015", "story_v_out_413072.awb")
					end

					arg_63_1:RecordHistoryTalkVoice("story_v_out_413072", "413072015", "story_v_out_413072.awb")
				end

				arg_63_1:RecordContent(arg_63_1.text_.text)
			end

			local var_66_25 = math.max(var_66_16, arg_63_1.talkMaxDuration)

			if var_66_15 <= arg_63_1.time_ and arg_63_1.time_ < var_66_15 + var_66_25 then
				arg_63_1.typewritter.percent = (arg_63_1.time_ - var_66_15) / var_66_25

				arg_63_1.typewritter:SetDirty()
			end

			if arg_63_1.time_ >= var_66_15 + var_66_25 and arg_63_1.time_ < var_66_15 + var_66_25 + arg_66_0 then
				arg_63_1.typewritter.percent = 1

				arg_63_1.typewritter:SetDirty()
				arg_63_1:ShowNextGo(true)
			end
		end

		arg_63_1.nodeConfigList_ = {
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

		arg_63_1:InitPlayNodeList()
	end,
	Play413072016 = function(arg_67_0, arg_67_1)
		arg_67_1.time_ = 0
		arg_67_1.frameCnt_ = 0
		arg_67_1.state_ = "playing"
		arg_67_1.curTalkId_ = 413072016
		arg_67_1.duration_ = 12.67

		local var_67_0 = {
			zh = 8.466,
			ja = 12.666
		}
		local var_67_1 = manager.audio:GetLocalizationFlag()

		if var_67_0[var_67_1] ~= nil then
			arg_67_1.duration_ = var_67_0[var_67_1]
		end

		SetActive(arg_67_1.tipsGo_, false)

		function arg_67_1.onSingleLineFinish_()
			arg_67_1.onSingleLineUpdate_ = nil
			arg_67_1.onSingleLineFinish_ = nil
			arg_67_1.state_ = "waiting"
		end

		function arg_67_1.playNext_(arg_69_0)
			if arg_69_0 == 1 then
				arg_67_0:Play413072017(arg_67_1)
			end
		end

		function arg_67_1.onSingleLineUpdate_(arg_70_0)
			local var_70_0 = 0
			local var_70_1 = 1.125

			if var_70_0 < arg_67_1.time_ and arg_67_1.time_ <= var_70_0 + arg_70_0 then
				arg_67_1.talkMaxDuration = 0
				arg_67_1.dialogCg_.alpha = 1

				arg_67_1.dialog_:SetActive(true)
				SetActive(arg_67_1.leftNameGo_, true)

				local var_70_2 = arg_67_1:FormatText(StoryNameCfg[614].name)

				arg_67_1.leftNameTxt_.text = var_70_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_67_1.leftNameTxt_.transform)

				arg_67_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_67_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_67_1:RecordName(arg_67_1.leftNameTxt_.text)
				SetActive(arg_67_1.iconTrs_.gameObject, false)
				arg_67_1.callingController_:SetSelectedState("normal")

				local var_70_3 = arg_67_1:GetWordFromCfg(413072016)
				local var_70_4 = arg_67_1:FormatText(var_70_3.content)

				arg_67_1.text_.text = var_70_4

				LuaForUtil.ClearLinePrefixSymbol(arg_67_1.text_)

				local var_70_5 = 45
				local var_70_6 = utf8.len(var_70_4)
				local var_70_7 = var_70_5 <= 0 and var_70_1 or var_70_1 * (var_70_6 / var_70_5)

				if var_70_7 > 0 and var_70_1 < var_70_7 then
					arg_67_1.talkMaxDuration = var_70_7

					if var_70_7 + var_70_0 > arg_67_1.duration_ then
						arg_67_1.duration_ = var_70_7 + var_70_0
					end
				end

				arg_67_1.text_.text = var_70_4
				arg_67_1.typewritter.percent = 0

				arg_67_1.typewritter:SetDirty()
				arg_67_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_413072", "413072016", "story_v_out_413072.awb") ~= 0 then
					local var_70_8 = manager.audio:GetVoiceLength("story_v_out_413072", "413072016", "story_v_out_413072.awb") / 1000

					if var_70_8 + var_70_0 > arg_67_1.duration_ then
						arg_67_1.duration_ = var_70_8 + var_70_0
					end

					if var_70_3.prefab_name ~= "" and arg_67_1.actors_[var_70_3.prefab_name] ~= nil then
						local var_70_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_67_1.actors_[var_70_3.prefab_name].transform, "story_v_out_413072", "413072016", "story_v_out_413072.awb")

						arg_67_1:RecordAudio("413072016", var_70_9)
						arg_67_1:RecordAudio("413072016", var_70_9)
					else
						arg_67_1:AudioAction("play", "voice", "story_v_out_413072", "413072016", "story_v_out_413072.awb")
					end

					arg_67_1:RecordHistoryTalkVoice("story_v_out_413072", "413072016", "story_v_out_413072.awb")
				end

				arg_67_1:RecordContent(arg_67_1.text_.text)
			end

			local var_70_10 = math.max(var_70_1, arg_67_1.talkMaxDuration)

			if var_70_0 <= arg_67_1.time_ and arg_67_1.time_ < var_70_0 + var_70_10 then
				arg_67_1.typewritter.percent = (arg_67_1.time_ - var_70_0) / var_70_10

				arg_67_1.typewritter:SetDirty()
			end

			if arg_67_1.time_ >= var_70_0 + var_70_10 and arg_67_1.time_ < var_70_0 + var_70_10 + arg_70_0 then
				arg_67_1.typewritter.percent = 1

				arg_67_1.typewritter:SetDirty()
				arg_67_1:ShowNextGo(true)
			end
		end

		arg_67_1.nodeConfigList_ = {}

		arg_67_1:InitPlayNodeList()
	end,
	Play413072017 = function(arg_71_0, arg_71_1)
		arg_71_1.time_ = 0
		arg_71_1.frameCnt_ = 0
		arg_71_1.state_ = "playing"
		arg_71_1.curTalkId_ = 413072017
		arg_71_1.duration_ = 8.77

		local var_71_0 = {
			zh = 3.966,
			ja = 8.766
		}
		local var_71_1 = manager.audio:GetLocalizationFlag()

		if var_71_0[var_71_1] ~= nil then
			arg_71_1.duration_ = var_71_0[var_71_1]
		end

		SetActive(arg_71_1.tipsGo_, false)

		function arg_71_1.onSingleLineFinish_()
			arg_71_1.onSingleLineUpdate_ = nil
			arg_71_1.onSingleLineFinish_ = nil
			arg_71_1.state_ = "waiting"
		end

		function arg_71_1.playNext_(arg_73_0)
			if arg_73_0 == 1 then
				arg_71_0:Play413072018(arg_71_1)
			end
		end

		function arg_71_1.onSingleLineUpdate_(arg_74_0)
			local var_74_0 = arg_71_1.actors_["10022"]
			local var_74_1 = 0

			if var_74_1 < arg_71_1.time_ and arg_71_1.time_ <= var_74_1 + arg_74_0 and not isNil(var_74_0) and arg_71_1.var_.actorSpriteComps10022 == nil then
				arg_71_1.var_.actorSpriteComps10022 = var_74_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_74_2 = 2

			if var_74_1 <= arg_71_1.time_ and arg_71_1.time_ < var_74_1 + var_74_2 and not isNil(var_74_0) then
				local var_74_3 = (arg_71_1.time_ - var_74_1) / var_74_2

				if arg_71_1.var_.actorSpriteComps10022 then
					for iter_74_0, iter_74_1 in pairs(arg_71_1.var_.actorSpriteComps10022:ToTable()) do
						if iter_74_1 then
							if arg_71_1.isInRecall_ then
								local var_74_4 = Mathf.Lerp(iter_74_1.color.r, arg_71_1.hightColor2.r, var_74_3)
								local var_74_5 = Mathf.Lerp(iter_74_1.color.g, arg_71_1.hightColor2.g, var_74_3)
								local var_74_6 = Mathf.Lerp(iter_74_1.color.b, arg_71_1.hightColor2.b, var_74_3)

								iter_74_1.color = Color.New(var_74_4, var_74_5, var_74_6)
							else
								local var_74_7 = Mathf.Lerp(iter_74_1.color.r, 0.5, var_74_3)

								iter_74_1.color = Color.New(var_74_7, var_74_7, var_74_7)
							end
						end
					end
				end
			end

			if arg_71_1.time_ >= var_74_1 + var_74_2 and arg_71_1.time_ < var_74_1 + var_74_2 + arg_74_0 and not isNil(var_74_0) and arg_71_1.var_.actorSpriteComps10022 then
				for iter_74_2, iter_74_3 in pairs(arg_71_1.var_.actorSpriteComps10022:ToTable()) do
					if iter_74_3 then
						if arg_71_1.isInRecall_ then
							iter_74_3.color = arg_71_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_74_3.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_71_1.var_.actorSpriteComps10022 = nil
			end

			local var_74_8 = 0
			local var_74_9 = 0.45

			if var_74_8 < arg_71_1.time_ and arg_71_1.time_ <= var_74_8 + arg_74_0 then
				arg_71_1.talkMaxDuration = 0
				arg_71_1.dialogCg_.alpha = 1

				arg_71_1.dialog_:SetActive(true)
				SetActive(arg_71_1.leftNameGo_, true)

				local var_74_10 = arg_71_1:FormatText(StoryNameCfg[993].name)

				arg_71_1.leftNameTxt_.text = var_74_10

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_71_1.leftNameTxt_.transform)

				arg_71_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_71_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_71_1:RecordName(arg_71_1.leftNameTxt_.text)
				SetActive(arg_71_1.iconTrs_.gameObject, true)
				arg_71_1.iconController_:SetSelectedState("hero")

				arg_71_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_citizenmb")

				arg_71_1.callingController_:SetSelectedState("normal")

				arg_71_1.keyicon_.color = Color.New(1, 1, 1)
				arg_71_1.icon_.color = Color.New(1, 1, 1)

				local var_74_11 = arg_71_1:GetWordFromCfg(413072017)
				local var_74_12 = arg_71_1:FormatText(var_74_11.content)

				arg_71_1.text_.text = var_74_12

				LuaForUtil.ClearLinePrefixSymbol(arg_71_1.text_)

				local var_74_13 = 18
				local var_74_14 = utf8.len(var_74_12)
				local var_74_15 = var_74_13 <= 0 and var_74_9 or var_74_9 * (var_74_14 / var_74_13)

				if var_74_15 > 0 and var_74_9 < var_74_15 then
					arg_71_1.talkMaxDuration = var_74_15

					if var_74_15 + var_74_8 > arg_71_1.duration_ then
						arg_71_1.duration_ = var_74_15 + var_74_8
					end
				end

				arg_71_1.text_.text = var_74_12
				arg_71_1.typewritter.percent = 0

				arg_71_1.typewritter:SetDirty()
				arg_71_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_413072", "413072017", "story_v_out_413072.awb") ~= 0 then
					local var_74_16 = manager.audio:GetVoiceLength("story_v_out_413072", "413072017", "story_v_out_413072.awb") / 1000

					if var_74_16 + var_74_8 > arg_71_1.duration_ then
						arg_71_1.duration_ = var_74_16 + var_74_8
					end

					if var_74_11.prefab_name ~= "" and arg_71_1.actors_[var_74_11.prefab_name] ~= nil then
						local var_74_17 = LuaForUtil.PlayVoiceWithCriLipsync(arg_71_1.actors_[var_74_11.prefab_name].transform, "story_v_out_413072", "413072017", "story_v_out_413072.awb")

						arg_71_1:RecordAudio("413072017", var_74_17)
						arg_71_1:RecordAudio("413072017", var_74_17)
					else
						arg_71_1:AudioAction("play", "voice", "story_v_out_413072", "413072017", "story_v_out_413072.awb")
					end

					arg_71_1:RecordHistoryTalkVoice("story_v_out_413072", "413072017", "story_v_out_413072.awb")
				end

				arg_71_1:RecordContent(arg_71_1.text_.text)
			end

			local var_74_18 = math.max(var_74_9, arg_71_1.talkMaxDuration)

			if var_74_8 <= arg_71_1.time_ and arg_71_1.time_ < var_74_8 + var_74_18 then
				arg_71_1.typewritter.percent = (arg_71_1.time_ - var_74_8) / var_74_18

				arg_71_1.typewritter:SetDirty()
			end

			if arg_71_1.time_ >= var_74_8 + var_74_18 and arg_71_1.time_ < var_74_8 + var_74_18 + arg_74_0 then
				arg_71_1.typewritter.percent = 1

				arg_71_1.typewritter:SetDirty()
				arg_71_1:ShowNextGo(true)
			end
		end

		arg_71_1.nodeConfigList_ = {}

		arg_71_1:InitPlayNodeList()
	end,
	Play413072018 = function(arg_75_0, arg_75_1)
		arg_75_1.time_ = 0
		arg_75_1.frameCnt_ = 0
		arg_75_1.state_ = "playing"
		arg_75_1.curTalkId_ = 413072018
		arg_75_1.duration_ = 4.9

		local var_75_0 = {
			zh = 2.366,
			ja = 4.9
		}
		local var_75_1 = manager.audio:GetLocalizationFlag()

		if var_75_0[var_75_1] ~= nil then
			arg_75_1.duration_ = var_75_0[var_75_1]
		end

		SetActive(arg_75_1.tipsGo_, false)

		function arg_75_1.onSingleLineFinish_()
			arg_75_1.onSingleLineUpdate_ = nil
			arg_75_1.onSingleLineFinish_ = nil
			arg_75_1.state_ = "waiting"
		end

		function arg_75_1.playNext_(arg_77_0)
			if arg_77_0 == 1 then
				arg_75_0:Play413072019(arg_75_1)
			end
		end

		function arg_75_1.onSingleLineUpdate_(arg_78_0)
			local var_78_0 = arg_75_1.actors_["10022"].transform
			local var_78_1 = 0

			if var_78_1 < arg_75_1.time_ and arg_75_1.time_ <= var_78_1 + arg_78_0 then
				arg_75_1.var_.moveOldPos10022 = var_78_0.localPosition
				var_78_0.localScale = Vector3.New(1, 1, 1)

				arg_75_1:CheckSpriteTmpPos("10022", 3)

				local var_78_2 = var_78_0.childCount

				for iter_78_0 = 0, var_78_2 - 1 do
					local var_78_3 = var_78_0:GetChild(iter_78_0)

					if var_78_3.name == "split_6" or not string.find(var_78_3.name, "split") then
						var_78_3.gameObject:SetActive(true)
					else
						var_78_3.gameObject:SetActive(false)
					end
				end
			end

			local var_78_4 = 0.001

			if var_78_1 <= arg_75_1.time_ and arg_75_1.time_ < var_78_1 + var_78_4 then
				local var_78_5 = (arg_75_1.time_ - var_78_1) / var_78_4
				local var_78_6 = Vector3.New(0, -315, -320)

				var_78_0.localPosition = Vector3.Lerp(arg_75_1.var_.moveOldPos10022, var_78_6, var_78_5)
			end

			if arg_75_1.time_ >= var_78_1 + var_78_4 and arg_75_1.time_ < var_78_1 + var_78_4 + arg_78_0 then
				var_78_0.localPosition = Vector3.New(0, -315, -320)
			end

			local var_78_7 = arg_75_1.actors_["10022"]
			local var_78_8 = 0

			if var_78_8 < arg_75_1.time_ and arg_75_1.time_ <= var_78_8 + arg_78_0 and not isNil(var_78_7) and arg_75_1.var_.actorSpriteComps10022 == nil then
				arg_75_1.var_.actorSpriteComps10022 = var_78_7:GetComponentsInChildren(typeof(Image), true)
			end

			local var_78_9 = 2

			if var_78_8 <= arg_75_1.time_ and arg_75_1.time_ < var_78_8 + var_78_9 and not isNil(var_78_7) then
				local var_78_10 = (arg_75_1.time_ - var_78_8) / var_78_9

				if arg_75_1.var_.actorSpriteComps10022 then
					for iter_78_1, iter_78_2 in pairs(arg_75_1.var_.actorSpriteComps10022:ToTable()) do
						if iter_78_2 then
							if arg_75_1.isInRecall_ then
								local var_78_11 = Mathf.Lerp(iter_78_2.color.r, arg_75_1.hightColor1.r, var_78_10)
								local var_78_12 = Mathf.Lerp(iter_78_2.color.g, arg_75_1.hightColor1.g, var_78_10)
								local var_78_13 = Mathf.Lerp(iter_78_2.color.b, arg_75_1.hightColor1.b, var_78_10)

								iter_78_2.color = Color.New(var_78_11, var_78_12, var_78_13)
							else
								local var_78_14 = Mathf.Lerp(iter_78_2.color.r, 1, var_78_10)

								iter_78_2.color = Color.New(var_78_14, var_78_14, var_78_14)
							end
						end
					end
				end
			end

			if arg_75_1.time_ >= var_78_8 + var_78_9 and arg_75_1.time_ < var_78_8 + var_78_9 + arg_78_0 and not isNil(var_78_7) and arg_75_1.var_.actorSpriteComps10022 then
				for iter_78_3, iter_78_4 in pairs(arg_75_1.var_.actorSpriteComps10022:ToTable()) do
					if iter_78_4 then
						if arg_75_1.isInRecall_ then
							iter_78_4.color = arg_75_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_78_4.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_75_1.var_.actorSpriteComps10022 = nil
			end

			local var_78_15 = 0
			local var_78_16 = 0.325

			if var_78_15 < arg_75_1.time_ and arg_75_1.time_ <= var_78_15 + arg_78_0 then
				arg_75_1.talkMaxDuration = 0
				arg_75_1.dialogCg_.alpha = 1

				arg_75_1.dialog_:SetActive(true)
				SetActive(arg_75_1.leftNameGo_, true)

				local var_78_17 = arg_75_1:FormatText(StoryNameCfg[614].name)

				arg_75_1.leftNameTxt_.text = var_78_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_75_1.leftNameTxt_.transform)

				arg_75_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_75_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_75_1:RecordName(arg_75_1.leftNameTxt_.text)
				SetActive(arg_75_1.iconTrs_.gameObject, false)
				arg_75_1.callingController_:SetSelectedState("normal")

				local var_78_18 = arg_75_1:GetWordFromCfg(413072018)
				local var_78_19 = arg_75_1:FormatText(var_78_18.content)

				arg_75_1.text_.text = var_78_19

				LuaForUtil.ClearLinePrefixSymbol(arg_75_1.text_)

				local var_78_20 = 13
				local var_78_21 = utf8.len(var_78_19)
				local var_78_22 = var_78_20 <= 0 and var_78_16 or var_78_16 * (var_78_21 / var_78_20)

				if var_78_22 > 0 and var_78_16 < var_78_22 then
					arg_75_1.talkMaxDuration = var_78_22

					if var_78_22 + var_78_15 > arg_75_1.duration_ then
						arg_75_1.duration_ = var_78_22 + var_78_15
					end
				end

				arg_75_1.text_.text = var_78_19
				arg_75_1.typewritter.percent = 0

				arg_75_1.typewritter:SetDirty()
				arg_75_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_413072", "413072018", "story_v_out_413072.awb") ~= 0 then
					local var_78_23 = manager.audio:GetVoiceLength("story_v_out_413072", "413072018", "story_v_out_413072.awb") / 1000

					if var_78_23 + var_78_15 > arg_75_1.duration_ then
						arg_75_1.duration_ = var_78_23 + var_78_15
					end

					if var_78_18.prefab_name ~= "" and arg_75_1.actors_[var_78_18.prefab_name] ~= nil then
						local var_78_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_75_1.actors_[var_78_18.prefab_name].transform, "story_v_out_413072", "413072018", "story_v_out_413072.awb")

						arg_75_1:RecordAudio("413072018", var_78_24)
						arg_75_1:RecordAudio("413072018", var_78_24)
					else
						arg_75_1:AudioAction("play", "voice", "story_v_out_413072", "413072018", "story_v_out_413072.awb")
					end

					arg_75_1:RecordHistoryTalkVoice("story_v_out_413072", "413072018", "story_v_out_413072.awb")
				end

				arg_75_1:RecordContent(arg_75_1.text_.text)
			end

			local var_78_25 = math.max(var_78_16, arg_75_1.talkMaxDuration)

			if var_78_15 <= arg_75_1.time_ and arg_75_1.time_ < var_78_15 + var_78_25 then
				arg_75_1.typewritter.percent = (arg_75_1.time_ - var_78_15) / var_78_25

				arg_75_1.typewritter:SetDirty()
			end

			if arg_75_1.time_ >= var_78_15 + var_78_25 and arg_75_1.time_ < var_78_15 + var_78_25 + arg_78_0 then
				arg_75_1.typewritter.percent = 1

				arg_75_1.typewritter:SetDirty()
				arg_75_1:ShowNextGo(true)
			end
		end

		arg_75_1.nodeConfigList_ = {
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

		arg_75_1:InitPlayNodeList()
	end,
	Play413072019 = function(arg_79_0, arg_79_1)
		arg_79_1.time_ = 0
		arg_79_1.frameCnt_ = 0
		arg_79_1.state_ = "playing"
		arg_79_1.curTalkId_ = 413072019
		arg_79_1.duration_ = 6.8

		local var_79_0 = {
			zh = 3.866,
			ja = 6.8
		}
		local var_79_1 = manager.audio:GetLocalizationFlag()

		if var_79_0[var_79_1] ~= nil then
			arg_79_1.duration_ = var_79_0[var_79_1]
		end

		SetActive(arg_79_1.tipsGo_, false)

		function arg_79_1.onSingleLineFinish_()
			arg_79_1.onSingleLineUpdate_ = nil
			arg_79_1.onSingleLineFinish_ = nil
			arg_79_1.state_ = "waiting"
		end

		function arg_79_1.playNext_(arg_81_0)
			if arg_81_0 == 1 then
				arg_79_0:Play413072020(arg_79_1)
			end
		end

		function arg_79_1.onSingleLineUpdate_(arg_82_0)
			local var_82_0 = arg_79_1.actors_["10022"]
			local var_82_1 = 0

			if var_82_1 < arg_79_1.time_ and arg_79_1.time_ <= var_82_1 + arg_82_0 and not isNil(var_82_0) and arg_79_1.var_.actorSpriteComps10022 == nil then
				arg_79_1.var_.actorSpriteComps10022 = var_82_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_82_2 = 2

			if var_82_1 <= arg_79_1.time_ and arg_79_1.time_ < var_82_1 + var_82_2 and not isNil(var_82_0) then
				local var_82_3 = (arg_79_1.time_ - var_82_1) / var_82_2

				if arg_79_1.var_.actorSpriteComps10022 then
					for iter_82_0, iter_82_1 in pairs(arg_79_1.var_.actorSpriteComps10022:ToTable()) do
						if iter_82_1 then
							if arg_79_1.isInRecall_ then
								local var_82_4 = Mathf.Lerp(iter_82_1.color.r, arg_79_1.hightColor2.r, var_82_3)
								local var_82_5 = Mathf.Lerp(iter_82_1.color.g, arg_79_1.hightColor2.g, var_82_3)
								local var_82_6 = Mathf.Lerp(iter_82_1.color.b, arg_79_1.hightColor2.b, var_82_3)

								iter_82_1.color = Color.New(var_82_4, var_82_5, var_82_6)
							else
								local var_82_7 = Mathf.Lerp(iter_82_1.color.r, 0.5, var_82_3)

								iter_82_1.color = Color.New(var_82_7, var_82_7, var_82_7)
							end
						end
					end
				end
			end

			if arg_79_1.time_ >= var_82_1 + var_82_2 and arg_79_1.time_ < var_82_1 + var_82_2 + arg_82_0 and not isNil(var_82_0) and arg_79_1.var_.actorSpriteComps10022 then
				for iter_82_2, iter_82_3 in pairs(arg_79_1.var_.actorSpriteComps10022:ToTable()) do
					if iter_82_3 then
						if arg_79_1.isInRecall_ then
							iter_82_3.color = arg_79_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_82_3.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_79_1.var_.actorSpriteComps10022 = nil
			end

			local var_82_8 = 0
			local var_82_9 = 0.15

			if var_82_8 < arg_79_1.time_ and arg_79_1.time_ <= var_82_8 + arg_82_0 then
				arg_79_1.talkMaxDuration = 0
				arg_79_1.dialogCg_.alpha = 1

				arg_79_1.dialog_:SetActive(true)
				SetActive(arg_79_1.leftNameGo_, true)

				local var_82_10 = arg_79_1:FormatText(StoryNameCfg[995].name)

				arg_79_1.leftNameTxt_.text = var_82_10

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_79_1.leftNameTxt_.transform)

				arg_79_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_79_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_79_1:RecordName(arg_79_1.leftNameTxt_.text)
				SetActive(arg_79_1.iconTrs_.gameObject, true)
				arg_79_1.iconController_:SetSelectedState("hero")

				arg_79_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_10096")

				arg_79_1.callingController_:SetSelectedState("normal")

				arg_79_1.keyicon_.color = Color.New(1, 1, 1)
				arg_79_1.icon_.color = Color.New(1, 1, 1)

				local var_82_11 = arg_79_1:GetWordFromCfg(413072019)
				local var_82_12 = arg_79_1:FormatText(var_82_11.content)

				arg_79_1.text_.text = var_82_12

				LuaForUtil.ClearLinePrefixSymbol(arg_79_1.text_)

				local var_82_13 = 6
				local var_82_14 = utf8.len(var_82_12)
				local var_82_15 = var_82_13 <= 0 and var_82_9 or var_82_9 * (var_82_14 / var_82_13)

				if var_82_15 > 0 and var_82_9 < var_82_15 then
					arg_79_1.talkMaxDuration = var_82_15

					if var_82_15 + var_82_8 > arg_79_1.duration_ then
						arg_79_1.duration_ = var_82_15 + var_82_8
					end
				end

				arg_79_1.text_.text = var_82_12
				arg_79_1.typewritter.percent = 0

				arg_79_1.typewritter:SetDirty()
				arg_79_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_413072", "413072019", "story_v_out_413072.awb") ~= 0 then
					local var_82_16 = manager.audio:GetVoiceLength("story_v_out_413072", "413072019", "story_v_out_413072.awb") / 1000

					if var_82_16 + var_82_8 > arg_79_1.duration_ then
						arg_79_1.duration_ = var_82_16 + var_82_8
					end

					if var_82_11.prefab_name ~= "" and arg_79_1.actors_[var_82_11.prefab_name] ~= nil then
						local var_82_17 = LuaForUtil.PlayVoiceWithCriLipsync(arg_79_1.actors_[var_82_11.prefab_name].transform, "story_v_out_413072", "413072019", "story_v_out_413072.awb")

						arg_79_1:RecordAudio("413072019", var_82_17)
						arg_79_1:RecordAudio("413072019", var_82_17)
					else
						arg_79_1:AudioAction("play", "voice", "story_v_out_413072", "413072019", "story_v_out_413072.awb")
					end

					arg_79_1:RecordHistoryTalkVoice("story_v_out_413072", "413072019", "story_v_out_413072.awb")
				end

				arg_79_1:RecordContent(arg_79_1.text_.text)
			end

			local var_82_18 = math.max(var_82_9, arg_79_1.talkMaxDuration)

			if var_82_8 <= arg_79_1.time_ and arg_79_1.time_ < var_82_8 + var_82_18 then
				arg_79_1.typewritter.percent = (arg_79_1.time_ - var_82_8) / var_82_18

				arg_79_1.typewritter:SetDirty()
			end

			if arg_79_1.time_ >= var_82_8 + var_82_18 and arg_79_1.time_ < var_82_8 + var_82_18 + arg_82_0 then
				arg_79_1.typewritter.percent = 1

				arg_79_1.typewritter:SetDirty()
				arg_79_1:ShowNextGo(true)
			end
		end

		arg_79_1.nodeConfigList_ = {}

		arg_79_1:InitPlayNodeList()
	end,
	Play413072020 = function(arg_83_0, arg_83_1)
		arg_83_1.time_ = 0
		arg_83_1.frameCnt_ = 0
		arg_83_1.state_ = "playing"
		arg_83_1.curTalkId_ = 413072020
		arg_83_1.duration_ = 6.77

		local var_83_0 = {
			zh = 6.633,
			ja = 6.766
		}
		local var_83_1 = manager.audio:GetLocalizationFlag()

		if var_83_0[var_83_1] ~= nil then
			arg_83_1.duration_ = var_83_0[var_83_1]
		end

		SetActive(arg_83_1.tipsGo_, false)

		function arg_83_1.onSingleLineFinish_()
			arg_83_1.onSingleLineUpdate_ = nil
			arg_83_1.onSingleLineFinish_ = nil
			arg_83_1.state_ = "waiting"
		end

		function arg_83_1.playNext_(arg_85_0)
			if arg_85_0 == 1 then
				arg_83_0:Play413072021(arg_83_1)
			end
		end

		function arg_83_1.onSingleLineUpdate_(arg_86_0)
			local var_86_0 = arg_83_1.actors_["10022"].transform
			local var_86_1 = 0

			if var_86_1 < arg_83_1.time_ and arg_83_1.time_ <= var_86_1 + arg_86_0 then
				arg_83_1.var_.moveOldPos10022 = var_86_0.localPosition
				var_86_0.localScale = Vector3.New(1, 1, 1)

				arg_83_1:CheckSpriteTmpPos("10022", 3)

				local var_86_2 = var_86_0.childCount

				for iter_86_0 = 0, var_86_2 - 1 do
					local var_86_3 = var_86_0:GetChild(iter_86_0)

					if var_86_3.name == "split_2" or not string.find(var_86_3.name, "split") then
						var_86_3.gameObject:SetActive(true)
					else
						var_86_3.gameObject:SetActive(false)
					end
				end
			end

			local var_86_4 = 0.001

			if var_86_1 <= arg_83_1.time_ and arg_83_1.time_ < var_86_1 + var_86_4 then
				local var_86_5 = (arg_83_1.time_ - var_86_1) / var_86_4
				local var_86_6 = Vector3.New(0, -315, -320)

				var_86_0.localPosition = Vector3.Lerp(arg_83_1.var_.moveOldPos10022, var_86_6, var_86_5)
			end

			if arg_83_1.time_ >= var_86_1 + var_86_4 and arg_83_1.time_ < var_86_1 + var_86_4 + arg_86_0 then
				var_86_0.localPosition = Vector3.New(0, -315, -320)
			end

			local var_86_7 = arg_83_1.actors_["10022"]
			local var_86_8 = 0

			if var_86_8 < arg_83_1.time_ and arg_83_1.time_ <= var_86_8 + arg_86_0 and not isNil(var_86_7) and arg_83_1.var_.actorSpriteComps10022 == nil then
				arg_83_1.var_.actorSpriteComps10022 = var_86_7:GetComponentsInChildren(typeof(Image), true)
			end

			local var_86_9 = 2

			if var_86_8 <= arg_83_1.time_ and arg_83_1.time_ < var_86_8 + var_86_9 and not isNil(var_86_7) then
				local var_86_10 = (arg_83_1.time_ - var_86_8) / var_86_9

				if arg_83_1.var_.actorSpriteComps10022 then
					for iter_86_1, iter_86_2 in pairs(arg_83_1.var_.actorSpriteComps10022:ToTable()) do
						if iter_86_2 then
							if arg_83_1.isInRecall_ then
								local var_86_11 = Mathf.Lerp(iter_86_2.color.r, arg_83_1.hightColor1.r, var_86_10)
								local var_86_12 = Mathf.Lerp(iter_86_2.color.g, arg_83_1.hightColor1.g, var_86_10)
								local var_86_13 = Mathf.Lerp(iter_86_2.color.b, arg_83_1.hightColor1.b, var_86_10)

								iter_86_2.color = Color.New(var_86_11, var_86_12, var_86_13)
							else
								local var_86_14 = Mathf.Lerp(iter_86_2.color.r, 1, var_86_10)

								iter_86_2.color = Color.New(var_86_14, var_86_14, var_86_14)
							end
						end
					end
				end
			end

			if arg_83_1.time_ >= var_86_8 + var_86_9 and arg_83_1.time_ < var_86_8 + var_86_9 + arg_86_0 and not isNil(var_86_7) and arg_83_1.var_.actorSpriteComps10022 then
				for iter_86_3, iter_86_4 in pairs(arg_83_1.var_.actorSpriteComps10022:ToTable()) do
					if iter_86_4 then
						if arg_83_1.isInRecall_ then
							iter_86_4.color = arg_83_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_86_4.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_83_1.var_.actorSpriteComps10022 = nil
			end

			local var_86_15 = 0
			local var_86_16 = 0.65

			if var_86_15 < arg_83_1.time_ and arg_83_1.time_ <= var_86_15 + arg_86_0 then
				arg_83_1.talkMaxDuration = 0
				arg_83_1.dialogCg_.alpha = 1

				arg_83_1.dialog_:SetActive(true)
				SetActive(arg_83_1.leftNameGo_, true)

				local var_86_17 = arg_83_1:FormatText(StoryNameCfg[614].name)

				arg_83_1.leftNameTxt_.text = var_86_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_83_1.leftNameTxt_.transform)

				arg_83_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_83_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_83_1:RecordName(arg_83_1.leftNameTxt_.text)
				SetActive(arg_83_1.iconTrs_.gameObject, false)
				arg_83_1.callingController_:SetSelectedState("normal")

				local var_86_18 = arg_83_1:GetWordFromCfg(413072020)
				local var_86_19 = arg_83_1:FormatText(var_86_18.content)

				arg_83_1.text_.text = var_86_19

				LuaForUtil.ClearLinePrefixSymbol(arg_83_1.text_)

				local var_86_20 = 26
				local var_86_21 = utf8.len(var_86_19)
				local var_86_22 = var_86_20 <= 0 and var_86_16 or var_86_16 * (var_86_21 / var_86_20)

				if var_86_22 > 0 and var_86_16 < var_86_22 then
					arg_83_1.talkMaxDuration = var_86_22

					if var_86_22 + var_86_15 > arg_83_1.duration_ then
						arg_83_1.duration_ = var_86_22 + var_86_15
					end
				end

				arg_83_1.text_.text = var_86_19
				arg_83_1.typewritter.percent = 0

				arg_83_1.typewritter:SetDirty()
				arg_83_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_413072", "413072020", "story_v_out_413072.awb") ~= 0 then
					local var_86_23 = manager.audio:GetVoiceLength("story_v_out_413072", "413072020", "story_v_out_413072.awb") / 1000

					if var_86_23 + var_86_15 > arg_83_1.duration_ then
						arg_83_1.duration_ = var_86_23 + var_86_15
					end

					if var_86_18.prefab_name ~= "" and arg_83_1.actors_[var_86_18.prefab_name] ~= nil then
						local var_86_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_83_1.actors_[var_86_18.prefab_name].transform, "story_v_out_413072", "413072020", "story_v_out_413072.awb")

						arg_83_1:RecordAudio("413072020", var_86_24)
						arg_83_1:RecordAudio("413072020", var_86_24)
					else
						arg_83_1:AudioAction("play", "voice", "story_v_out_413072", "413072020", "story_v_out_413072.awb")
					end

					arg_83_1:RecordHistoryTalkVoice("story_v_out_413072", "413072020", "story_v_out_413072.awb")
				end

				arg_83_1:RecordContent(arg_83_1.text_.text)
			end

			local var_86_25 = math.max(var_86_16, arg_83_1.talkMaxDuration)

			if var_86_15 <= arg_83_1.time_ and arg_83_1.time_ < var_86_15 + var_86_25 then
				arg_83_1.typewritter.percent = (arg_83_1.time_ - var_86_15) / var_86_25

				arg_83_1.typewritter:SetDirty()
			end

			if arg_83_1.time_ >= var_86_15 + var_86_25 and arg_83_1.time_ < var_86_15 + var_86_25 + arg_86_0 then
				arg_83_1.typewritter.percent = 1

				arg_83_1.typewritter:SetDirty()
				arg_83_1:ShowNextGo(true)
			end
		end

		arg_83_1.nodeConfigList_ = {
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

		arg_83_1:InitPlayNodeList()
	end,
	Play413072021 = function(arg_87_0, arg_87_1)
		arg_87_1.time_ = 0
		arg_87_1.frameCnt_ = 0
		arg_87_1.state_ = "playing"
		arg_87_1.curTalkId_ = 413072021
		arg_87_1.duration_ = 4.8

		local var_87_0 = {
			zh = 2.86666666666667,
			ja = 4.79966666666667
		}
		local var_87_1 = manager.audio:GetLocalizationFlag()

		if var_87_0[var_87_1] ~= nil then
			arg_87_1.duration_ = var_87_0[var_87_1]
		end

		SetActive(arg_87_1.tipsGo_, false)

		function arg_87_1.onSingleLineFinish_()
			arg_87_1.onSingleLineUpdate_ = nil
			arg_87_1.onSingleLineFinish_ = nil
			arg_87_1.state_ = "waiting"
		end

		function arg_87_1.playNext_(arg_89_0)
			if arg_89_0 == 1 then
				arg_87_0:Play413072022(arg_87_1)
			end
		end

		function arg_87_1.onSingleLineUpdate_(arg_90_0)
			local var_90_0 = arg_87_1.actors_["10022"].transform
			local var_90_1 = 0

			if var_90_1 < arg_87_1.time_ and arg_87_1.time_ <= var_90_1 + arg_90_0 then
				arg_87_1.var_.moveOldPos10022 = var_90_0.localPosition
				var_90_0.localScale = Vector3.New(1, 1, 1)

				arg_87_1:CheckSpriteTmpPos("10022", 7)

				local var_90_2 = var_90_0.childCount

				for iter_90_0 = 0, var_90_2 - 1 do
					local var_90_3 = var_90_0:GetChild(iter_90_0)

					if var_90_3.name == "split_2" or not string.find(var_90_3.name, "split") then
						var_90_3.gameObject:SetActive(true)
					else
						var_90_3.gameObject:SetActive(false)
					end
				end
			end

			local var_90_4 = 0.001

			if var_90_1 <= arg_87_1.time_ and arg_87_1.time_ < var_90_1 + var_90_4 then
				local var_90_5 = (arg_87_1.time_ - var_90_1) / var_90_4
				local var_90_6 = Vector3.New(0, -2000, 0)

				var_90_0.localPosition = Vector3.Lerp(arg_87_1.var_.moveOldPos10022, var_90_6, var_90_5)
			end

			if arg_87_1.time_ >= var_90_1 + var_90_4 and arg_87_1.time_ < var_90_1 + var_90_4 + arg_90_0 then
				var_90_0.localPosition = Vector3.New(0, -2000, 0)
			end

			local var_90_7 = manager.ui.mainCamera.transform
			local var_90_8 = 0

			if var_90_8 < arg_87_1.time_ and arg_87_1.time_ <= var_90_8 + arg_90_0 then
				arg_87_1.var_.shakeOldPos = var_90_7.localPosition
			end

			local var_90_9 = 0.6

			if var_90_8 <= arg_87_1.time_ and arg_87_1.time_ < var_90_8 + var_90_9 then
				local var_90_10 = (arg_87_1.time_ - var_90_8) / 0.066
				local var_90_11, var_90_12 = math.modf(var_90_10)

				var_90_7.localPosition = Vector3.New(var_90_12 * 0.13, var_90_12 * 0.13, var_90_12 * 0.13) + arg_87_1.var_.shakeOldPos
			end

			if arg_87_1.time_ >= var_90_8 + var_90_9 and arg_87_1.time_ < var_90_8 + var_90_9 + arg_90_0 then
				var_90_7.localPosition = arg_87_1.var_.shakeOldPos
			end

			local var_90_13 = 0

			if var_90_13 < arg_87_1.time_ and arg_87_1.time_ <= var_90_13 + arg_90_0 then
				arg_87_1.allBtn_.enabled = false
			end

			local var_90_14 = 1.06666666666667

			if arg_87_1.time_ >= var_90_13 + var_90_14 and arg_87_1.time_ < var_90_13 + var_90_14 + arg_90_0 then
				arg_87_1.allBtn_.enabled = true
			end

			if arg_87_1.frameCnt_ <= 1 then
				arg_87_1.dialog_:SetActive(false)
			end

			local var_90_15 = 0.566666666666667
			local var_90_16 = 0.25

			if var_90_15 < arg_87_1.time_ and arg_87_1.time_ <= var_90_15 + arg_90_0 then
				arg_87_1.talkMaxDuration = 0

				arg_87_1.dialog_:SetActive(true)

				arg_87_1.dialogCg_.alpha = 0

				local var_90_17 = LeanTween.value(arg_87_1.dialog_, 0, 1, 0.3)

				var_90_17:setOnUpdate(LuaHelper.FloatAction(function(arg_91_0)
					arg_87_1.dialogCg_.alpha = arg_91_0
				end))
				var_90_17:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_87_1.dialog_)
					var_90_17:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_87_1.duration_ = arg_87_1.duration_ + 0.3

				SetActive(arg_87_1.leftNameGo_, true)

				local var_90_18 = arg_87_1:FormatText(StoryNameCfg[614].name)

				arg_87_1.leftNameTxt_.text = var_90_18

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_87_1.leftNameTxt_.transform)

				arg_87_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_87_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_87_1:RecordName(arg_87_1.leftNameTxt_.text)
				SetActive(arg_87_1.iconTrs_.gameObject, true)
				arg_87_1.iconController_:SetSelectedState("hero")

				arg_87_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_10022_split_6")

				arg_87_1.callingController_:SetSelectedState("normal")

				arg_87_1.keyicon_.color = Color.New(1, 1, 1)
				arg_87_1.icon_.color = Color.New(1, 1, 1)

				local var_90_19 = arg_87_1:GetWordFromCfg(413072021)
				local var_90_20 = arg_87_1:FormatText(var_90_19.content)

				arg_87_1.text_.text = var_90_20

				LuaForUtil.ClearLinePrefixSymbol(arg_87_1.text_)

				local var_90_21 = 10
				local var_90_22 = utf8.len(var_90_20)
				local var_90_23 = var_90_21 <= 0 and var_90_16 or var_90_16 * (var_90_22 / var_90_21)

				if var_90_23 > 0 and var_90_16 < var_90_23 then
					arg_87_1.talkMaxDuration = var_90_23
					var_90_15 = var_90_15 + 0.3

					if var_90_23 + var_90_15 > arg_87_1.duration_ then
						arg_87_1.duration_ = var_90_23 + var_90_15
					end
				end

				arg_87_1.text_.text = var_90_20
				arg_87_1.typewritter.percent = 0

				arg_87_1.typewritter:SetDirty()
				arg_87_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_413072", "413072021", "story_v_out_413072.awb") ~= 0 then
					local var_90_24 = manager.audio:GetVoiceLength("story_v_out_413072", "413072021", "story_v_out_413072.awb") / 1000

					if var_90_24 + var_90_15 > arg_87_1.duration_ then
						arg_87_1.duration_ = var_90_24 + var_90_15
					end

					if var_90_19.prefab_name ~= "" and arg_87_1.actors_[var_90_19.prefab_name] ~= nil then
						local var_90_25 = LuaForUtil.PlayVoiceWithCriLipsync(arg_87_1.actors_[var_90_19.prefab_name].transform, "story_v_out_413072", "413072021", "story_v_out_413072.awb")

						arg_87_1:RecordAudio("413072021", var_90_25)
						arg_87_1:RecordAudio("413072021", var_90_25)
					else
						arg_87_1:AudioAction("play", "voice", "story_v_out_413072", "413072021", "story_v_out_413072.awb")
					end

					arg_87_1:RecordHistoryTalkVoice("story_v_out_413072", "413072021", "story_v_out_413072.awb")
				end

				arg_87_1:RecordContent(arg_87_1.text_.text)
			end

			local var_90_26 = var_90_15 + 0.3
			local var_90_27 = math.max(var_90_16, arg_87_1.talkMaxDuration)

			if var_90_26 <= arg_87_1.time_ and arg_87_1.time_ < var_90_26 + var_90_27 then
				arg_87_1.typewritter.percent = (arg_87_1.time_ - var_90_26) / var_90_27

				arg_87_1.typewritter:SetDirty()
			end

			if arg_87_1.time_ >= var_90_26 + var_90_27 and arg_87_1.time_ < var_90_26 + var_90_27 + arg_90_0 then
				arg_87_1.typewritter.percent = 1

				arg_87_1.typewritter:SetDirty()
				arg_87_1:ShowNextGo(true)
			end
		end

		arg_87_1.nodeConfigList_ = {
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

		arg_87_1:InitPlayNodeList()
	end,
	Play413072022 = function(arg_93_0, arg_93_1)
		arg_93_1.time_ = 0
		arg_93_1.frameCnt_ = 0
		arg_93_1.state_ = "playing"
		arg_93_1.curTalkId_ = 413072022
		arg_93_1.duration_ = 4.9

		local var_93_0 = {
			zh = 4.633,
			ja = 4.9
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
				arg_93_0:Play413072023(arg_93_1)
			end
		end

		function arg_93_1.onSingleLineUpdate_(arg_96_0)
			local var_96_0 = 0
			local var_96_1 = 0.15

			if var_96_0 < arg_93_1.time_ and arg_93_1.time_ <= var_96_0 + arg_96_0 then
				arg_93_1.talkMaxDuration = 0
				arg_93_1.dialogCg_.alpha = 1

				arg_93_1.dialog_:SetActive(true)
				SetActive(arg_93_1.leftNameGo_, true)

				local var_96_2 = arg_93_1:FormatText(StoryNameCfg[36].name)

				arg_93_1.leftNameTxt_.text = var_96_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_93_1.leftNameTxt_.transform)

				arg_93_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_93_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_93_1:RecordName(arg_93_1.leftNameTxt_.text)
				SetActive(arg_93_1.iconTrs_.gameObject, true)
				arg_93_1.iconController_:SetSelectedState("hero")

				arg_93_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_2123")

				arg_93_1.callingController_:SetSelectedState("normal")

				arg_93_1.keyicon_.color = Color.New(1, 1, 1)
				arg_93_1.icon_.color = Color.New(1, 1, 1)

				local var_96_3 = arg_93_1:GetWordFromCfg(413072022)
				local var_96_4 = arg_93_1:FormatText(var_96_3.content)

				arg_93_1.text_.text = var_96_4

				LuaForUtil.ClearLinePrefixSymbol(arg_93_1.text_)

				local var_96_5 = 6
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

				if manager.audio:GetVoiceLength("story_v_out_413072", "413072022", "story_v_out_413072.awb") ~= 0 then
					local var_96_8 = manager.audio:GetVoiceLength("story_v_out_413072", "413072022", "story_v_out_413072.awb") / 1000

					if var_96_8 + var_96_0 > arg_93_1.duration_ then
						arg_93_1.duration_ = var_96_8 + var_96_0
					end

					if var_96_3.prefab_name ~= "" and arg_93_1.actors_[var_96_3.prefab_name] ~= nil then
						local var_96_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_93_1.actors_[var_96_3.prefab_name].transform, "story_v_out_413072", "413072022", "story_v_out_413072.awb")

						arg_93_1:RecordAudio("413072022", var_96_9)
						arg_93_1:RecordAudio("413072022", var_96_9)
					else
						arg_93_1:AudioAction("play", "voice", "story_v_out_413072", "413072022", "story_v_out_413072.awb")
					end

					arg_93_1:RecordHistoryTalkVoice("story_v_out_413072", "413072022", "story_v_out_413072.awb")
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
	Play413072023 = function(arg_97_0, arg_97_1)
		arg_97_1.time_ = 0
		arg_97_1.frameCnt_ = 0
		arg_97_1.state_ = "playing"
		arg_97_1.curTalkId_ = 413072023
		arg_97_1.duration_ = 13.07

		local var_97_0 = {
			zh = 6,
			ja = 13.066
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
				arg_97_0:Play413072024(arg_97_1)
			end
		end

		function arg_97_1.onSingleLineUpdate_(arg_100_0)
			local var_100_0 = 0

			if var_100_0 < arg_97_1.time_ and arg_97_1.time_ <= var_100_0 + arg_100_0 then
				arg_97_1.allBtn_.enabled = false
			end

			local var_100_1 = 0.766666666666667

			if arg_97_1.time_ >= var_100_0 + var_100_1 and arg_97_1.time_ < var_100_0 + var_100_1 + arg_100_0 then
				arg_97_1.allBtn_.enabled = true
			end

			local var_100_2 = 0
			local var_100_3 = 0.575

			if var_100_2 < arg_97_1.time_ and arg_97_1.time_ <= var_100_2 + arg_100_0 then
				arg_97_1.talkMaxDuration = 0
				arg_97_1.dialogCg_.alpha = 1

				arg_97_1.dialog_:SetActive(true)
				SetActive(arg_97_1.leftNameGo_, true)

				local var_100_4 = arg_97_1:FormatText(StoryNameCfg[993].name)

				arg_97_1.leftNameTxt_.text = var_100_4

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_97_1.leftNameTxt_.transform)

				arg_97_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_97_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_97_1:RecordName(arg_97_1.leftNameTxt_.text)
				SetActive(arg_97_1.iconTrs_.gameObject, true)
				arg_97_1.iconController_:SetSelectedState("hero")

				arg_97_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_citizenmb")

				arg_97_1.callingController_:SetSelectedState("normal")

				arg_97_1.keyicon_.color = Color.New(1, 1, 1)
				arg_97_1.icon_.color = Color.New(1, 1, 1)

				local var_100_5 = arg_97_1:GetWordFromCfg(413072023)
				local var_100_6 = arg_97_1:FormatText(var_100_5.content)

				arg_97_1.text_.text = var_100_6

				LuaForUtil.ClearLinePrefixSymbol(arg_97_1.text_)

				local var_100_7 = 23
				local var_100_8 = utf8.len(var_100_6)
				local var_100_9 = var_100_7 <= 0 and var_100_3 or var_100_3 * (var_100_8 / var_100_7)

				if var_100_9 > 0 and var_100_3 < var_100_9 then
					arg_97_1.talkMaxDuration = var_100_9

					if var_100_9 + var_100_2 > arg_97_1.duration_ then
						arg_97_1.duration_ = var_100_9 + var_100_2
					end
				end

				arg_97_1.text_.text = var_100_6
				arg_97_1.typewritter.percent = 0

				arg_97_1.typewritter:SetDirty()
				arg_97_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_413072", "413072023", "story_v_out_413072.awb") ~= 0 then
					local var_100_10 = manager.audio:GetVoiceLength("story_v_out_413072", "413072023", "story_v_out_413072.awb") / 1000

					if var_100_10 + var_100_2 > arg_97_1.duration_ then
						arg_97_1.duration_ = var_100_10 + var_100_2
					end

					if var_100_5.prefab_name ~= "" and arg_97_1.actors_[var_100_5.prefab_name] ~= nil then
						local var_100_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_97_1.actors_[var_100_5.prefab_name].transform, "story_v_out_413072", "413072023", "story_v_out_413072.awb")

						arg_97_1:RecordAudio("413072023", var_100_11)
						arg_97_1:RecordAudio("413072023", var_100_11)
					else
						arg_97_1:AudioAction("play", "voice", "story_v_out_413072", "413072023", "story_v_out_413072.awb")
					end

					arg_97_1:RecordHistoryTalkVoice("story_v_out_413072", "413072023", "story_v_out_413072.awb")
				end

				arg_97_1:RecordContent(arg_97_1.text_.text)
			end

			local var_100_12 = math.max(var_100_3, arg_97_1.talkMaxDuration)

			if var_100_2 <= arg_97_1.time_ and arg_97_1.time_ < var_100_2 + var_100_12 then
				arg_97_1.typewritter.percent = (arg_97_1.time_ - var_100_2) / var_100_12

				arg_97_1.typewritter:SetDirty()
			end

			if arg_97_1.time_ >= var_100_2 + var_100_12 and arg_97_1.time_ < var_100_2 + var_100_12 + arg_100_0 then
				arg_97_1.typewritter.percent = 1

				arg_97_1.typewritter:SetDirty()
				arg_97_1:ShowNextGo(true)
			end
		end

		arg_97_1.nodeConfigList_ = {}

		arg_97_1:InitPlayNodeList()
	end,
	Play413072024 = function(arg_101_0, arg_101_1)
		arg_101_1.time_ = 0
		arg_101_1.frameCnt_ = 0
		arg_101_1.state_ = "playing"
		arg_101_1.curTalkId_ = 413072024
		arg_101_1.duration_ = 5

		SetActive(arg_101_1.tipsGo_, false)

		function arg_101_1.onSingleLineFinish_()
			arg_101_1.onSingleLineUpdate_ = nil
			arg_101_1.onSingleLineFinish_ = nil
			arg_101_1.state_ = "waiting"
		end

		function arg_101_1.playNext_(arg_103_0)
			if arg_103_0 == 1 then
				arg_101_0:Play413072025(arg_101_1)
			end
		end

		function arg_101_1.onSingleLineUpdate_(arg_104_0)
			local var_104_0 = arg_101_1.actors_["10022"].transform
			local var_104_1 = 0

			if var_104_1 < arg_101_1.time_ and arg_101_1.time_ <= var_104_1 + arg_104_0 then
				arg_101_1.var_.moveOldPos10022 = var_104_0.localPosition
				var_104_0.localScale = Vector3.New(1, 1, 1)

				arg_101_1:CheckSpriteTmpPos("10022", 0)

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
				local var_104_6 = Vector3.New(-5000, -315, -320)

				var_104_0.localPosition = Vector3.Lerp(arg_101_1.var_.moveOldPos10022, var_104_6, var_104_5)
			end

			if arg_101_1.time_ >= var_104_1 + var_104_4 and arg_101_1.time_ < var_104_1 + var_104_4 + arg_104_0 then
				var_104_0.localPosition = Vector3.New(-5000, -315, -320)
			end

			local var_104_7 = arg_101_1.actors_["10022"]
			local var_104_8 = 0

			if var_104_8 < arg_101_1.time_ and arg_101_1.time_ <= var_104_8 + arg_104_0 and not isNil(var_104_7) and arg_101_1.var_.actorSpriteComps10022 == nil then
				arg_101_1.var_.actorSpriteComps10022 = var_104_7:GetComponentsInChildren(typeof(Image), true)
			end

			local var_104_9 = 2

			if var_104_8 <= arg_101_1.time_ and arg_101_1.time_ < var_104_8 + var_104_9 and not isNil(var_104_7) then
				local var_104_10 = (arg_101_1.time_ - var_104_8) / var_104_9

				if arg_101_1.var_.actorSpriteComps10022 then
					for iter_104_1, iter_104_2 in pairs(arg_101_1.var_.actorSpriteComps10022:ToTable()) do
						if iter_104_2 then
							if arg_101_1.isInRecall_ then
								local var_104_11 = Mathf.Lerp(iter_104_2.color.r, arg_101_1.hightColor2.r, var_104_10)
								local var_104_12 = Mathf.Lerp(iter_104_2.color.g, arg_101_1.hightColor2.g, var_104_10)
								local var_104_13 = Mathf.Lerp(iter_104_2.color.b, arg_101_1.hightColor2.b, var_104_10)

								iter_104_2.color = Color.New(var_104_11, var_104_12, var_104_13)
							else
								local var_104_14 = Mathf.Lerp(iter_104_2.color.r, 0.5, var_104_10)

								iter_104_2.color = Color.New(var_104_14, var_104_14, var_104_14)
							end
						end
					end
				end
			end

			if arg_101_1.time_ >= var_104_8 + var_104_9 and arg_101_1.time_ < var_104_8 + var_104_9 + arg_104_0 and not isNil(var_104_7) and arg_101_1.var_.actorSpriteComps10022 then
				for iter_104_3, iter_104_4 in pairs(arg_101_1.var_.actorSpriteComps10022:ToTable()) do
					if iter_104_4 then
						if arg_101_1.isInRecall_ then
							iter_104_4.color = arg_101_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_104_4.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_101_1.var_.actorSpriteComps10022 = nil
			end

			local var_104_15 = 0.034
			local var_104_16 = 1

			if var_104_15 < arg_101_1.time_ and arg_101_1.time_ <= var_104_15 + arg_104_0 then
				local var_104_17 = "play"
				local var_104_18 = "effect"

				arg_101_1:AudioAction(var_104_17, var_104_18, "se_story_120_00", "se_story_120_00_sizzle", "")
			end

			local var_104_19 = 1
			local var_104_20 = 1

			if var_104_19 < arg_101_1.time_ and arg_101_1.time_ <= var_104_19 + arg_104_0 then
				local var_104_21 = "play"
				local var_104_22 = "effect"

				arg_101_1:AudioAction(var_104_21, var_104_22, "se_story_121_00", "se_story_121_00_suppress01_break", "")
			end

			local var_104_23 = 0
			local var_104_24 = 1.775

			if var_104_23 < arg_101_1.time_ and arg_101_1.time_ <= var_104_23 + arg_104_0 then
				arg_101_1.talkMaxDuration = 0
				arg_101_1.dialogCg_.alpha = 1

				arg_101_1.dialog_:SetActive(true)
				SetActive(arg_101_1.leftNameGo_, false)

				arg_101_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_101_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_101_1:RecordName(arg_101_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_101_1.iconTrs_.gameObject, false)
				arg_101_1.callingController_:SetSelectedState("normal")

				local var_104_25 = arg_101_1:GetWordFromCfg(413072024)
				local var_104_26 = arg_101_1:FormatText(var_104_25.content)

				arg_101_1.text_.text = var_104_26

				LuaForUtil.ClearLinePrefixSymbol(arg_101_1.text_)

				local var_104_27 = 65
				local var_104_28 = utf8.len(var_104_26)
				local var_104_29 = var_104_27 <= 0 and var_104_24 or var_104_24 * (var_104_28 / var_104_27)

				if var_104_29 > 0 and var_104_24 < var_104_29 then
					arg_101_1.talkMaxDuration = var_104_29

					if var_104_29 + var_104_23 > arg_101_1.duration_ then
						arg_101_1.duration_ = var_104_29 + var_104_23
					end
				end

				arg_101_1.text_.text = var_104_26
				arg_101_1.typewritter.percent = 0

				arg_101_1.typewritter:SetDirty()
				arg_101_1:ShowNextGo(false)
				arg_101_1:RecordContent(arg_101_1.text_.text)
			end

			local var_104_30 = math.max(var_104_24, arg_101_1.talkMaxDuration)

			if var_104_23 <= arg_101_1.time_ and arg_101_1.time_ < var_104_23 + var_104_30 then
				arg_101_1.typewritter.percent = (arg_101_1.time_ - var_104_23) / var_104_30

				arg_101_1.typewritter:SetDirty()
			end

			if arg_101_1.time_ >= var_104_23 + var_104_30 and arg_101_1.time_ < var_104_23 + var_104_30 + arg_104_0 then
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
			}
		}

		arg_101_1:InitPlayNodeList()
	end,
	Play413072025 = function(arg_105_0, arg_105_1)
		arg_105_1.time_ = 0
		arg_105_1.frameCnt_ = 0
		arg_105_1.state_ = "playing"
		arg_105_1.curTalkId_ = 413072025
		arg_105_1.duration_ = 4.6

		local var_105_0 = {
			zh = 4.6,
			ja = 3.933
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
				arg_105_0:Play413072026(arg_105_1)
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

					if var_108_3.name == "split_6" or not string.find(var_108_3.name, "split") then
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
			local var_108_16 = 0.575

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

				local var_108_18 = arg_105_1:GetWordFromCfg(413072025)
				local var_108_19 = arg_105_1:FormatText(var_108_18.content)

				arg_105_1.text_.text = var_108_19

				LuaForUtil.ClearLinePrefixSymbol(arg_105_1.text_)

				local var_108_20 = 23
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

				if manager.audio:GetVoiceLength("story_v_out_413072", "413072025", "story_v_out_413072.awb") ~= 0 then
					local var_108_23 = manager.audio:GetVoiceLength("story_v_out_413072", "413072025", "story_v_out_413072.awb") / 1000

					if var_108_23 + var_108_15 > arg_105_1.duration_ then
						arg_105_1.duration_ = var_108_23 + var_108_15
					end

					if var_108_18.prefab_name ~= "" and arg_105_1.actors_[var_108_18.prefab_name] ~= nil then
						local var_108_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_105_1.actors_[var_108_18.prefab_name].transform, "story_v_out_413072", "413072025", "story_v_out_413072.awb")

						arg_105_1:RecordAudio("413072025", var_108_24)
						arg_105_1:RecordAudio("413072025", var_108_24)
					else
						arg_105_1:AudioAction("play", "voice", "story_v_out_413072", "413072025", "story_v_out_413072.awb")
					end

					arg_105_1:RecordHistoryTalkVoice("story_v_out_413072", "413072025", "story_v_out_413072.awb")
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
	Play413072026 = function(arg_109_0, arg_109_1)
		arg_109_1.time_ = 0
		arg_109_1.frameCnt_ = 0
		arg_109_1.state_ = "playing"
		arg_109_1.curTalkId_ = 413072026
		arg_109_1.duration_ = 3.43

		local var_109_0 = {
			zh = 2.9,
			ja = 3.433
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
				arg_109_0:Play413072027(arg_109_1)
			end
		end

		function arg_109_1.onSingleLineUpdate_(arg_112_0)
			local var_112_0 = 0.8
			local var_112_1 = 0.2

			if var_112_0 < arg_109_1.time_ and arg_109_1.time_ <= var_112_0 + arg_112_0 then
				local var_112_2 = "play"
				local var_112_3 = "effect"

				arg_109_1:AudioAction(var_112_2, var_112_3, "minigame_activity_3_4", "minigame_activity_3_4_battle_bullet_30", "")
			end

			local var_112_4 = 0
			local var_112_5 = 0.375

			if var_112_4 < arg_109_1.time_ and arg_109_1.time_ <= var_112_4 + arg_112_0 then
				arg_109_1.talkMaxDuration = 0
				arg_109_1.dialogCg_.alpha = 1

				arg_109_1.dialog_:SetActive(true)
				SetActive(arg_109_1.leftNameGo_, true)

				local var_112_6 = arg_109_1:FormatText(StoryNameCfg[614].name)

				arg_109_1.leftNameTxt_.text = var_112_6

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_109_1.leftNameTxt_.transform)

				arg_109_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_109_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_109_1:RecordName(arg_109_1.leftNameTxt_.text)
				SetActive(arg_109_1.iconTrs_.gameObject, false)
				arg_109_1.callingController_:SetSelectedState("normal")

				local var_112_7 = arg_109_1:GetWordFromCfg(413072026)
				local var_112_8 = arg_109_1:FormatText(var_112_7.content)

				arg_109_1.text_.text = var_112_8

				LuaForUtil.ClearLinePrefixSymbol(arg_109_1.text_)

				local var_112_9 = 15
				local var_112_10 = utf8.len(var_112_8)
				local var_112_11 = var_112_9 <= 0 and var_112_5 or var_112_5 * (var_112_10 / var_112_9)

				if var_112_11 > 0 and var_112_5 < var_112_11 then
					arg_109_1.talkMaxDuration = var_112_11

					if var_112_11 + var_112_4 > arg_109_1.duration_ then
						arg_109_1.duration_ = var_112_11 + var_112_4
					end
				end

				arg_109_1.text_.text = var_112_8
				arg_109_1.typewritter.percent = 0

				arg_109_1.typewritter:SetDirty()
				arg_109_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_413072", "413072026", "story_v_out_413072.awb") ~= 0 then
					local var_112_12 = manager.audio:GetVoiceLength("story_v_out_413072", "413072026", "story_v_out_413072.awb") / 1000

					if var_112_12 + var_112_4 > arg_109_1.duration_ then
						arg_109_1.duration_ = var_112_12 + var_112_4
					end

					if var_112_7.prefab_name ~= "" and arg_109_1.actors_[var_112_7.prefab_name] ~= nil then
						local var_112_13 = LuaForUtil.PlayVoiceWithCriLipsync(arg_109_1.actors_[var_112_7.prefab_name].transform, "story_v_out_413072", "413072026", "story_v_out_413072.awb")

						arg_109_1:RecordAudio("413072026", var_112_13)
						arg_109_1:RecordAudio("413072026", var_112_13)
					else
						arg_109_1:AudioAction("play", "voice", "story_v_out_413072", "413072026", "story_v_out_413072.awb")
					end

					arg_109_1:RecordHistoryTalkVoice("story_v_out_413072", "413072026", "story_v_out_413072.awb")
				end

				arg_109_1:RecordContent(arg_109_1.text_.text)
			end

			local var_112_14 = math.max(var_112_5, arg_109_1.talkMaxDuration)

			if var_112_4 <= arg_109_1.time_ and arg_109_1.time_ < var_112_4 + var_112_14 then
				arg_109_1.typewritter.percent = (arg_109_1.time_ - var_112_4) / var_112_14

				arg_109_1.typewritter:SetDirty()
			end

			if arg_109_1.time_ >= var_112_4 + var_112_14 and arg_109_1.time_ < var_112_4 + var_112_14 + arg_112_0 then
				arg_109_1.typewritter.percent = 1

				arg_109_1.typewritter:SetDirty()
				arg_109_1:ShowNextGo(true)
			end
		end

		arg_109_1.nodeConfigList_ = {}

		arg_109_1:InitPlayNodeList()
	end,
	Play413072027 = function(arg_113_0, arg_113_1)
		arg_113_1.time_ = 0
		arg_113_1.frameCnt_ = 0
		arg_113_1.state_ = "playing"
		arg_113_1.curTalkId_ = 413072027
		arg_113_1.duration_ = 3.1

		local var_113_0 = {
			zh = 2.933,
			ja = 3.1
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
				arg_113_0:Play413072028(arg_113_1)
			end
		end

		function arg_113_1.onSingleLineUpdate_(arg_116_0)
			local var_116_0 = 0
			local var_116_1 = 0.275

			if var_116_0 < arg_113_1.time_ and arg_113_1.time_ <= var_116_0 + arg_116_0 then
				arg_113_1.talkMaxDuration = 0
				arg_113_1.dialogCg_.alpha = 1

				arg_113_1.dialog_:SetActive(true)
				SetActive(arg_113_1.leftNameGo_, true)

				local var_116_2 = arg_113_1:FormatText(StoryNameCfg[614].name)

				arg_113_1.leftNameTxt_.text = var_116_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_113_1.leftNameTxt_.transform)

				arg_113_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_113_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_113_1:RecordName(arg_113_1.leftNameTxt_.text)
				SetActive(arg_113_1.iconTrs_.gameObject, false)
				arg_113_1.callingController_:SetSelectedState("normal")

				local var_116_3 = arg_113_1:GetWordFromCfg(413072027)
				local var_116_4 = arg_113_1:FormatText(var_116_3.content)

				arg_113_1.text_.text = var_116_4

				LuaForUtil.ClearLinePrefixSymbol(arg_113_1.text_)

				local var_116_5 = 11
				local var_116_6 = utf8.len(var_116_4)
				local var_116_7 = var_116_5 <= 0 and var_116_1 or var_116_1 * (var_116_6 / var_116_5)

				if var_116_7 > 0 and var_116_1 < var_116_7 then
					arg_113_1.talkMaxDuration = var_116_7

					if var_116_7 + var_116_0 > arg_113_1.duration_ then
						arg_113_1.duration_ = var_116_7 + var_116_0
					end
				end

				arg_113_1.text_.text = var_116_4
				arg_113_1.typewritter.percent = 0

				arg_113_1.typewritter:SetDirty()
				arg_113_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_413072", "413072027", "story_v_out_413072.awb") ~= 0 then
					local var_116_8 = manager.audio:GetVoiceLength("story_v_out_413072", "413072027", "story_v_out_413072.awb") / 1000

					if var_116_8 + var_116_0 > arg_113_1.duration_ then
						arg_113_1.duration_ = var_116_8 + var_116_0
					end

					if var_116_3.prefab_name ~= "" and arg_113_1.actors_[var_116_3.prefab_name] ~= nil then
						local var_116_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_113_1.actors_[var_116_3.prefab_name].transform, "story_v_out_413072", "413072027", "story_v_out_413072.awb")

						arg_113_1:RecordAudio("413072027", var_116_9)
						arg_113_1:RecordAudio("413072027", var_116_9)
					else
						arg_113_1:AudioAction("play", "voice", "story_v_out_413072", "413072027", "story_v_out_413072.awb")
					end

					arg_113_1:RecordHistoryTalkVoice("story_v_out_413072", "413072027", "story_v_out_413072.awb")
				end

				arg_113_1:RecordContent(arg_113_1.text_.text)
			end

			local var_116_10 = math.max(var_116_1, arg_113_1.talkMaxDuration)

			if var_116_0 <= arg_113_1.time_ and arg_113_1.time_ < var_116_0 + var_116_10 then
				arg_113_1.typewritter.percent = (arg_113_1.time_ - var_116_0) / var_116_10

				arg_113_1.typewritter:SetDirty()
			end

			if arg_113_1.time_ >= var_116_0 + var_116_10 and arg_113_1.time_ < var_116_0 + var_116_10 + arg_116_0 then
				arg_113_1.typewritter.percent = 1

				arg_113_1.typewritter:SetDirty()
				arg_113_1:ShowNextGo(true)
			end
		end

		arg_113_1.nodeConfigList_ = {}

		arg_113_1:InitPlayNodeList()
	end,
	Play413072028 = function(arg_117_0, arg_117_1)
		arg_117_1.time_ = 0
		arg_117_1.frameCnt_ = 0
		arg_117_1.state_ = "playing"
		arg_117_1.curTalkId_ = 413072028
		arg_117_1.duration_ = 6

		SetActive(arg_117_1.tipsGo_, false)

		function arg_117_1.onSingleLineFinish_()
			arg_117_1.onSingleLineUpdate_ = nil
			arg_117_1.onSingleLineFinish_ = nil
			arg_117_1.state_ = "waiting"
		end

		function arg_117_1.playNext_(arg_119_0)
			if arg_119_0 == 1 then
				arg_117_0:Play413072029(arg_117_1)
			end
		end

		function arg_117_1.onSingleLineUpdate_(arg_120_0)
			local var_120_0 = arg_117_1.actors_["10022"].transform
			local var_120_1 = 0

			if var_120_1 < arg_117_1.time_ and arg_117_1.time_ <= var_120_1 + arg_120_0 then
				arg_117_1.var_.moveOldPos10022 = var_120_0.localPosition
				var_120_0.localScale = Vector3.New(1, 1, 1)

				arg_117_1:CheckSpriteTmpPos("10022", 0)

				local var_120_2 = var_120_0.childCount

				for iter_120_0 = 0, var_120_2 - 1 do
					local var_120_3 = var_120_0:GetChild(iter_120_0)

					if var_120_3.name == "" or not string.find(var_120_3.name, "split") then
						var_120_3.gameObject:SetActive(true)
					else
						var_120_3.gameObject:SetActive(false)
					end
				end
			end

			local var_120_4 = 0.001

			if var_120_1 <= arg_117_1.time_ and arg_117_1.time_ < var_120_1 + var_120_4 then
				local var_120_5 = (arg_117_1.time_ - var_120_1) / var_120_4
				local var_120_6 = Vector3.New(-5000, -315, -320)

				var_120_0.localPosition = Vector3.Lerp(arg_117_1.var_.moveOldPos10022, var_120_6, var_120_5)
			end

			if arg_117_1.time_ >= var_120_1 + var_120_4 and arg_117_1.time_ < var_120_1 + var_120_4 + arg_120_0 then
				var_120_0.localPosition = Vector3.New(-5000, -315, -320)
			end

			local var_120_7 = arg_117_1.actors_["10022"]
			local var_120_8 = 0

			if var_120_8 < arg_117_1.time_ and arg_117_1.time_ <= var_120_8 + arg_120_0 and not isNil(var_120_7) and arg_117_1.var_.actorSpriteComps10022 == nil then
				arg_117_1.var_.actorSpriteComps10022 = var_120_7:GetComponentsInChildren(typeof(Image), true)
			end

			local var_120_9 = 2

			if var_120_8 <= arg_117_1.time_ and arg_117_1.time_ < var_120_8 + var_120_9 and not isNil(var_120_7) then
				local var_120_10 = (arg_117_1.time_ - var_120_8) / var_120_9

				if arg_117_1.var_.actorSpriteComps10022 then
					for iter_120_1, iter_120_2 in pairs(arg_117_1.var_.actorSpriteComps10022:ToTable()) do
						if iter_120_2 then
							if arg_117_1.isInRecall_ then
								local var_120_11 = Mathf.Lerp(iter_120_2.color.r, arg_117_1.hightColor2.r, var_120_10)
								local var_120_12 = Mathf.Lerp(iter_120_2.color.g, arg_117_1.hightColor2.g, var_120_10)
								local var_120_13 = Mathf.Lerp(iter_120_2.color.b, arg_117_1.hightColor2.b, var_120_10)

								iter_120_2.color = Color.New(var_120_11, var_120_12, var_120_13)
							else
								local var_120_14 = Mathf.Lerp(iter_120_2.color.r, 0.5, var_120_10)

								iter_120_2.color = Color.New(var_120_14, var_120_14, var_120_14)
							end
						end
					end
				end
			end

			if arg_117_1.time_ >= var_120_8 + var_120_9 and arg_117_1.time_ < var_120_8 + var_120_9 + arg_120_0 and not isNil(var_120_7) and arg_117_1.var_.actorSpriteComps10022 then
				for iter_120_3, iter_120_4 in pairs(arg_117_1.var_.actorSpriteComps10022:ToTable()) do
					if iter_120_4 then
						if arg_117_1.isInRecall_ then
							iter_120_4.color = arg_117_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_120_4.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_117_1.var_.actorSpriteComps10022 = nil
			end

			local var_120_15 = manager.ui.mainCamera.transform
			local var_120_16 = 0

			if var_120_16 < arg_117_1.time_ and arg_117_1.time_ <= var_120_16 + arg_120_0 then
				local var_120_17 = arg_117_1.var_.effectliren1
				local var_120_18
				local var_120_19 = var_120_15

				if not var_120_17 then
					var_120_17 = Object.Instantiate(Asset.Load("Effect/Scene/fx_ui_slash_02"), var_120_19)
					var_120_17.name = "liren1"
					arg_117_1.var_.effectliren1 = var_120_17
				else
					var_120_17.transform:SetParent(var_120_19)
				end

				var_120_17.transform.localPosition = Vector3.New(0, 0, 0.44)
				var_120_17.transform.localRotation = Quaternion.Euler(0, 0, 0)
			end

			local var_120_20 = manager.ui.mainCamera.transform
			local var_120_21 = 1

			if var_120_21 < arg_117_1.time_ and arg_117_1.time_ <= var_120_21 + arg_120_0 then
				local var_120_22 = arg_117_1.var_.effectliren1

				if var_120_22 then
					Object.Destroy(var_120_22)

					arg_117_1.var_.effectliren1 = nil
				end
			end

			local var_120_23 = 0
			local var_120_24 = 1.2

			if var_120_23 < arg_117_1.time_ and arg_117_1.time_ <= var_120_23 + arg_120_0 then
				local var_120_25 = "play"
				local var_120_26 = "effect"

				arg_117_1:AudioAction(var_120_25, var_120_26, "c_10079", "c_10079_bullet_7", "")
			end

			if arg_117_1.frameCnt_ <= 1 then
				arg_117_1.dialog_:SetActive(false)
			end

			local var_120_27 = 1
			local var_120_28 = 1.675

			if var_120_27 < arg_117_1.time_ and arg_117_1.time_ <= var_120_27 + arg_120_0 then
				arg_117_1.talkMaxDuration = 0

				arg_117_1.dialog_:SetActive(true)

				arg_117_1.dialogCg_.alpha = 0

				local var_120_29 = LeanTween.value(arg_117_1.dialog_, 0, 1, 0.3)

				var_120_29:setOnUpdate(LuaHelper.FloatAction(function(arg_121_0)
					arg_117_1.dialogCg_.alpha = arg_121_0
				end))
				var_120_29:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_117_1.dialog_)
					var_120_29:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_117_1.duration_ = arg_117_1.duration_ + 0.3

				SetActive(arg_117_1.leftNameGo_, false)

				arg_117_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_117_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_117_1:RecordName(arg_117_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_117_1.iconTrs_.gameObject, false)
				arg_117_1.callingController_:SetSelectedState("normal")

				local var_120_30 = arg_117_1:GetWordFromCfg(413072028)
				local var_120_31 = arg_117_1:FormatText(var_120_30.content)

				arg_117_1.text_.text = var_120_31

				LuaForUtil.ClearLinePrefixSymbol(arg_117_1.text_)

				local var_120_32 = 67
				local var_120_33 = utf8.len(var_120_31)
				local var_120_34 = var_120_32 <= 0 and var_120_28 or var_120_28 * (var_120_33 / var_120_32)

				if var_120_34 > 0 and var_120_28 < var_120_34 then
					arg_117_1.talkMaxDuration = var_120_34
					var_120_27 = var_120_27 + 0.3

					if var_120_34 + var_120_27 > arg_117_1.duration_ then
						arg_117_1.duration_ = var_120_34 + var_120_27
					end
				end

				arg_117_1.text_.text = var_120_31
				arg_117_1.typewritter.percent = 0

				arg_117_1.typewritter:SetDirty()
				arg_117_1:ShowNextGo(false)
				arg_117_1:RecordContent(arg_117_1.text_.text)
			end

			local var_120_35 = var_120_27 + 0.3
			local var_120_36 = math.max(var_120_28, arg_117_1.talkMaxDuration)

			if var_120_35 <= arg_117_1.time_ and arg_117_1.time_ < var_120_35 + var_120_36 then
				arg_117_1.typewritter.percent = (arg_117_1.time_ - var_120_35) / var_120_36

				arg_117_1.typewritter:SetDirty()
			end

			if arg_117_1.time_ >= var_120_35 + var_120_36 and arg_117_1.time_ < var_120_35 + var_120_36 + arg_120_0 then
				arg_117_1.typewritter.percent = 1

				arg_117_1.typewritter:SetDirty()
				arg_117_1:ShowNextGo(true)
			end
		end

		arg_117_1.nodeConfigList_ = {
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

		arg_117_1:InitPlayNodeList()
	end,
	Play413072029 = function(arg_123_0, arg_123_1)
		arg_123_1.time_ = 0
		arg_123_1.frameCnt_ = 0
		arg_123_1.state_ = "playing"
		arg_123_1.curTalkId_ = 413072029
		arg_123_1.duration_ = 8.5

		SetActive(arg_123_1.tipsGo_, false)

		function arg_123_1.onSingleLineFinish_()
			arg_123_1.onSingleLineUpdate_ = nil
			arg_123_1.onSingleLineFinish_ = nil
			arg_123_1.state_ = "waiting"
		end

		function arg_123_1.playNext_(arg_125_0)
			if arg_125_0 == 1 then
				arg_123_0:Play413072030(arg_123_1)
			end
		end

		function arg_123_1.onSingleLineUpdate_(arg_126_0)
			local var_126_0 = "F10g"

			if arg_123_1.bgs_[var_126_0] == nil then
				local var_126_1 = Object.Instantiate(arg_123_1.paintGo_)

				var_126_1:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. var_126_0)
				var_126_1.name = var_126_0
				var_126_1.transform.parent = arg_123_1.stage_.transform
				var_126_1.transform.localPosition = Vector3.New(0, 100, 0)
				arg_123_1.bgs_[var_126_0] = var_126_1
			end

			local var_126_2 = 1.5

			if var_126_2 < arg_123_1.time_ and arg_123_1.time_ <= var_126_2 + arg_126_0 then
				local var_126_3 = manager.ui.mainCamera.transform.localPosition
				local var_126_4 = Vector3.New(0, 0, 10) + Vector3.New(var_126_3.x, var_126_3.y, 0)
				local var_126_5 = arg_123_1.bgs_.F10g

				var_126_5.transform.localPosition = var_126_4
				var_126_5.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_126_6 = var_126_5:GetComponent("SpriteRenderer")

				if var_126_6 and var_126_6.sprite then
					local var_126_7 = (var_126_5.transform.localPosition - var_126_3).z
					local var_126_8 = manager.ui.mainCameraCom_
					local var_126_9 = 2 * var_126_7 * Mathf.Tan(var_126_8.fieldOfView * 0.5 * Mathf.Deg2Rad)
					local var_126_10 = var_126_9 * var_126_8.aspect
					local var_126_11 = var_126_6.sprite.bounds.size.x
					local var_126_12 = var_126_6.sprite.bounds.size.y
					local var_126_13 = var_126_10 / var_126_11
					local var_126_14 = var_126_9 / var_126_12
					local var_126_15 = var_126_14 < var_126_13 and var_126_13 or var_126_14

					var_126_5.transform.localScale = Vector3.New(var_126_15, var_126_15, 0)
				end

				for iter_126_0, iter_126_1 in pairs(arg_123_1.bgs_) do
					if iter_126_0 ~= "F10g" then
						iter_126_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_126_16 = 3.5

			if var_126_16 < arg_123_1.time_ and arg_123_1.time_ <= var_126_16 + arg_126_0 then
				arg_123_1.allBtn_.enabled = false
			end

			local var_126_17 = 0.3

			if arg_123_1.time_ >= var_126_16 + var_126_17 and arg_123_1.time_ < var_126_16 + var_126_17 + arg_126_0 then
				arg_123_1.allBtn_.enabled = true
			end

			local var_126_18 = 0

			if var_126_18 < arg_123_1.time_ and arg_123_1.time_ <= var_126_18 + arg_126_0 then
				arg_123_1.mask_.enabled = true
				arg_123_1.mask_.raycastTarget = true

				arg_123_1:SetGaussion(false)
			end

			local var_126_19 = 1.500000000002

			if var_126_18 <= arg_123_1.time_ and arg_123_1.time_ < var_126_18 + var_126_19 then
				local var_126_20 = (arg_123_1.time_ - var_126_18) / var_126_19
				local var_126_21 = Color.New(0, 0, 0)

				var_126_21.a = Mathf.Lerp(0, 1, var_126_20)
				arg_123_1.mask_.color = var_126_21
			end

			if arg_123_1.time_ >= var_126_18 + var_126_19 and arg_123_1.time_ < var_126_18 + var_126_19 + arg_126_0 then
				local var_126_22 = Color.New(0, 0, 0)

				var_126_22.a = 1
				arg_123_1.mask_.color = var_126_22
			end

			local var_126_23 = 1.500000000001

			if var_126_23 < arg_123_1.time_ and arg_123_1.time_ <= var_126_23 + arg_126_0 then
				arg_123_1.mask_.enabled = true
				arg_123_1.mask_.raycastTarget = true

				arg_123_1:SetGaussion(false)
			end

			local var_126_24 = 2

			if var_126_23 <= arg_123_1.time_ and arg_123_1.time_ < var_126_23 + var_126_24 then
				local var_126_25 = (arg_123_1.time_ - var_126_23) / var_126_24
				local var_126_26 = Color.New(0.4185208, 0.4279335, 0.5377358)

				var_126_26.a = Mathf.Lerp(1, 0, var_126_25)
				arg_123_1.mask_.color = var_126_26
			end

			if arg_123_1.time_ >= var_126_23 + var_126_24 and arg_123_1.time_ < var_126_23 + var_126_24 + arg_126_0 then
				local var_126_27 = Color.New(0.4185208, 0.4279335, 0.5377358)
				local var_126_28 = 0

				arg_123_1.mask_.enabled = false
				var_126_27.a = var_126_28
				arg_123_1.mask_.color = var_126_27
			end

			local var_126_29 = manager.ui.mainCamera.transform
			local var_126_30 = 1.500000000002

			if var_126_30 < arg_123_1.time_ and arg_123_1.time_ <= var_126_30 + arg_126_0 then
				arg_123_1.var_.shakeOldPos = var_126_29.localPosition
			end

			local var_126_31 = 0.999999999999

			if var_126_30 <= arg_123_1.time_ and arg_123_1.time_ < var_126_30 + var_126_31 then
				local var_126_32 = (arg_123_1.time_ - var_126_30) / 0.066
				local var_126_33, var_126_34 = math.modf(var_126_32)

				var_126_29.localPosition = Vector3.New(var_126_34 * 0.13, var_126_34 * 0.13, var_126_34 * 0.13) + arg_123_1.var_.shakeOldPos
			end

			if arg_123_1.time_ >= var_126_30 + var_126_31 and arg_123_1.time_ < var_126_30 + var_126_31 + arg_126_0 then
				var_126_29.localPosition = arg_123_1.var_.shakeOldPos
			end

			local var_126_35 = manager.ui.mainCamera.transform
			local var_126_36 = 1.500000000001

			if var_126_36 < arg_123_1.time_ and arg_123_1.time_ <= var_126_36 + arg_126_0 then
				local var_126_37 = arg_123_1.var_.effectchuanyu1
				local var_126_38
				local var_126_39 = var_126_35

				if not var_126_37 then
					var_126_37 = Object.Instantiate(Asset.Load("Effect/Scene/fx_raindrop"), var_126_39)
					var_126_37.name = "chuanyu1"
					arg_123_1.var_.effectchuanyu1 = var_126_37
				else
					var_126_37.transform:SetParent(var_126_39)
				end

				var_126_37.transform.localPosition = Vector3.New(0, 0, 0)
				var_126_37.transform.localRotation = Quaternion.Euler(0, 0, 0)
			end

			local var_126_40 = 0.866666666666667
			local var_126_41 = 0.491666666666667

			if var_126_40 < arg_123_1.time_ and arg_123_1.time_ <= var_126_40 + arg_126_0 then
				local var_126_42 = "play"
				local var_126_43 = "effect"

				arg_123_1:AudioAction(var_126_42, var_126_43, "se_story_134_01", "se_story_134_01_wave", "")
			end

			if arg_123_1.frameCnt_ <= 1 then
				arg_123_1.dialog_:SetActive(false)
			end

			local var_126_44 = 3.5
			local var_126_45 = 0.9

			if var_126_44 < arg_123_1.time_ and arg_123_1.time_ <= var_126_44 + arg_126_0 then
				arg_123_1.talkMaxDuration = 0

				arg_123_1.dialog_:SetActive(true)

				arg_123_1.dialogCg_.alpha = 0

				local var_126_46 = LeanTween.value(arg_123_1.dialog_, 0, 1, 0.3)

				var_126_46:setOnUpdate(LuaHelper.FloatAction(function(arg_127_0)
					arg_123_1.dialogCg_.alpha = arg_127_0
				end))
				var_126_46:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_123_1.dialog_)
					var_126_46:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_123_1.duration_ = arg_123_1.duration_ + 0.3

				SetActive(arg_123_1.leftNameGo_, false)

				arg_123_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_123_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_123_1:RecordName(arg_123_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_123_1.iconTrs_.gameObject, false)
				arg_123_1.callingController_:SetSelectedState("normal")

				local var_126_47 = arg_123_1:GetWordFromCfg(413072029)
				local var_126_48 = arg_123_1:FormatText(var_126_47.content)

				arg_123_1.text_.text = var_126_48

				LuaForUtil.ClearLinePrefixSymbol(arg_123_1.text_)

				local var_126_49 = 36
				local var_126_50 = utf8.len(var_126_48)
				local var_126_51 = var_126_49 <= 0 and var_126_45 or var_126_45 * (var_126_50 / var_126_49)

				if var_126_51 > 0 and var_126_45 < var_126_51 then
					arg_123_1.talkMaxDuration = var_126_51
					var_126_44 = var_126_44 + 0.3

					if var_126_51 + var_126_44 > arg_123_1.duration_ then
						arg_123_1.duration_ = var_126_51 + var_126_44
					end
				end

				arg_123_1.text_.text = var_126_48
				arg_123_1.typewritter.percent = 0

				arg_123_1.typewritter:SetDirty()
				arg_123_1:ShowNextGo(false)
				arg_123_1:RecordContent(arg_123_1.text_.text)
			end

			local var_126_52 = var_126_44 + 0.3
			local var_126_53 = math.max(var_126_45, arg_123_1.talkMaxDuration)

			if var_126_52 <= arg_123_1.time_ and arg_123_1.time_ < var_126_52 + var_126_53 then
				arg_123_1.typewritter.percent = (arg_123_1.time_ - var_126_52) / var_126_53

				arg_123_1.typewritter:SetDirty()
			end

			if arg_123_1.time_ >= var_126_52 + var_126_53 and arg_123_1.time_ < var_126_52 + var_126_53 + arg_126_0 then
				arg_123_1.typewritter.percent = 1

				arg_123_1.typewritter:SetDirty()
				arg_123_1:ShowNextGo(true)
			end
		end

		arg_123_1.nodeConfigList_ = {}

		arg_123_1:InitPlayNodeList()
	end,
	Play413072030 = function(arg_129_0, arg_129_1)
		arg_129_1.time_ = 0
		arg_129_1.frameCnt_ = 0
		arg_129_1.state_ = "playing"
		arg_129_1.curTalkId_ = 413072030
		arg_129_1.duration_ = 3.97

		local var_129_0 = {
			zh = 3.96633333333333,
			ja = 3.89933333333333
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
				arg_129_0:Play413072031(arg_129_1)
			end
		end

		function arg_129_1.onSingleLineUpdate_(arg_132_0)
			local var_132_0 = "10093"

			if arg_129_1.actors_[var_132_0] == nil then
				local var_132_1 = Asset.Load("Widget/System/Story/StoryExpression/" .. "10093")

				if not isNil(var_132_1) then
					local var_132_2 = Object.Instantiate(var_132_1, arg_129_1.canvasGo_.transform)

					var_132_2.transform:SetSiblingIndex(1)

					var_132_2.name = var_132_0
					var_132_2.transform.localPosition = Vector3.New(0, 100000, 0)
					arg_129_1.actors_[var_132_0] = var_132_2

					local var_132_3 = var_132_2:GetComponentsInChildren(typeof(Image), true):ToTable()

					if arg_129_1.isInRecall_ then
						for iter_132_0, iter_132_1 in ipairs(var_132_3) do
							iter_132_1.color = arg_129_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						end
					end
				end
			end

			local var_132_4 = arg_129_1.actors_["10093"].transform
			local var_132_5 = 0

			if var_132_5 < arg_129_1.time_ and arg_129_1.time_ <= var_132_5 + arg_132_0 then
				arg_129_1.var_.moveOldPos10093 = var_132_4.localPosition
				var_132_4.localScale = Vector3.New(1, 1, 1)

				arg_129_1:CheckSpriteTmpPos("10093", 3)

				local var_132_6 = var_132_4.childCount

				for iter_132_2 = 0, var_132_6 - 1 do
					local var_132_7 = var_132_4:GetChild(iter_132_2)

					if var_132_7.name == "split_3" or not string.find(var_132_7.name, "split") then
						var_132_7.gameObject:SetActive(true)
					else
						var_132_7.gameObject:SetActive(false)
					end
				end
			end

			local var_132_8 = 0.001

			if var_132_5 <= arg_129_1.time_ and arg_129_1.time_ < var_132_5 + var_132_8 then
				local var_132_9 = (arg_129_1.time_ - var_132_5) / var_132_8
				local var_132_10 = Vector3.New(0, -345, -245)

				var_132_4.localPosition = Vector3.Lerp(arg_129_1.var_.moveOldPos10093, var_132_10, var_132_9)
			end

			if arg_129_1.time_ >= var_132_5 + var_132_8 and arg_129_1.time_ < var_132_5 + var_132_8 + arg_132_0 then
				var_132_4.localPosition = Vector3.New(0, -345, -245)
			end

			local var_132_11 = arg_129_1.actors_["10093"]
			local var_132_12 = 0

			if var_132_12 < arg_129_1.time_ and arg_129_1.time_ <= var_132_12 + arg_132_0 and not isNil(var_132_11) and arg_129_1.var_.actorSpriteComps10093 == nil then
				arg_129_1.var_.actorSpriteComps10093 = var_132_11:GetComponentsInChildren(typeof(Image), true)
			end

			local var_132_13 = 2

			if var_132_12 <= arg_129_1.time_ and arg_129_1.time_ < var_132_12 + var_132_13 and not isNil(var_132_11) then
				local var_132_14 = (arg_129_1.time_ - var_132_12) / var_132_13

				if arg_129_1.var_.actorSpriteComps10093 then
					for iter_132_3, iter_132_4 in pairs(arg_129_1.var_.actorSpriteComps10093:ToTable()) do
						if iter_132_4 then
							if arg_129_1.isInRecall_ then
								local var_132_15 = Mathf.Lerp(iter_132_4.color.r, arg_129_1.hightColor1.r, var_132_14)
								local var_132_16 = Mathf.Lerp(iter_132_4.color.g, arg_129_1.hightColor1.g, var_132_14)
								local var_132_17 = Mathf.Lerp(iter_132_4.color.b, arg_129_1.hightColor1.b, var_132_14)

								iter_132_4.color = Color.New(var_132_15, var_132_16, var_132_17)
							else
								local var_132_18 = Mathf.Lerp(iter_132_4.color.r, 1, var_132_14)

								iter_132_4.color = Color.New(var_132_18, var_132_18, var_132_18)
							end
						end
					end
				end
			end

			if arg_129_1.time_ >= var_132_12 + var_132_13 and arg_129_1.time_ < var_132_12 + var_132_13 + arg_132_0 and not isNil(var_132_11) and arg_129_1.var_.actorSpriteComps10093 then
				for iter_132_5, iter_132_6 in pairs(arg_129_1.var_.actorSpriteComps10093:ToTable()) do
					if iter_132_6 then
						if arg_129_1.isInRecall_ then
							iter_132_6.color = arg_129_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_132_6.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_129_1.var_.actorSpriteComps10093 = nil
			end

			local var_132_19 = arg_129_1.actors_["10093"]
			local var_132_20 = 0

			if var_132_20 < arg_129_1.time_ and arg_129_1.time_ <= var_132_20 + arg_132_0 then
				local var_132_21 = var_132_19:GetComponentInChildren(typeof(CanvasGroup))

				if var_132_21 then
					arg_129_1.var_.alphaOldValue10093 = var_132_21.alpha
					arg_129_1.var_.characterEffect10093 = var_132_21
				end

				arg_129_1.var_.alphaOldValue10093 = 0
			end

			local var_132_22 = 0.5

			if var_132_20 <= arg_129_1.time_ and arg_129_1.time_ < var_132_20 + var_132_22 then
				local var_132_23 = (arg_129_1.time_ - var_132_20) / var_132_22
				local var_132_24 = Mathf.Lerp(arg_129_1.var_.alphaOldValue10093, 1, var_132_23)

				if arg_129_1.var_.characterEffect10093 then
					arg_129_1.var_.characterEffect10093.alpha = var_132_24
				end
			end

			if arg_129_1.time_ >= var_132_20 + var_132_22 and arg_129_1.time_ < var_132_20 + var_132_22 + arg_132_0 and arg_129_1.var_.characterEffect10093 then
				arg_129_1.var_.characterEffect10093.alpha = 1
			end

			local var_132_25 = 0.333333333333333
			local var_132_26 = 0.3

			if var_132_25 < arg_129_1.time_ and arg_129_1.time_ <= var_132_25 + arg_132_0 then
				arg_129_1.talkMaxDuration = 0
				arg_129_1.dialogCg_.alpha = 1

				arg_129_1.dialog_:SetActive(true)
				SetActive(arg_129_1.leftNameGo_, true)

				local var_132_27 = arg_129_1:FormatText(StoryNameCfg[28].name)

				arg_129_1.leftNameTxt_.text = var_132_27

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_129_1.leftNameTxt_.transform)

				arg_129_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_129_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_129_1:RecordName(arg_129_1.leftNameTxt_.text)
				SetActive(arg_129_1.iconTrs_.gameObject, false)
				arg_129_1.callingController_:SetSelectedState("normal")

				local var_132_28 = arg_129_1:GetWordFromCfg(413072030)
				local var_132_29 = arg_129_1:FormatText(var_132_28.content)

				arg_129_1.text_.text = var_132_29

				LuaForUtil.ClearLinePrefixSymbol(arg_129_1.text_)

				local var_132_30 = 12
				local var_132_31 = utf8.len(var_132_29)
				local var_132_32 = var_132_30 <= 0 and var_132_26 or var_132_26 * (var_132_31 / var_132_30)

				if var_132_32 > 0 and var_132_26 < var_132_32 then
					arg_129_1.talkMaxDuration = var_132_32

					if var_132_32 + var_132_25 > arg_129_1.duration_ then
						arg_129_1.duration_ = var_132_32 + var_132_25
					end
				end

				arg_129_1.text_.text = var_132_29
				arg_129_1.typewritter.percent = 0

				arg_129_1.typewritter:SetDirty()
				arg_129_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_413072", "413072030", "story_v_out_413072.awb") ~= 0 then
					local var_132_33 = manager.audio:GetVoiceLength("story_v_out_413072", "413072030", "story_v_out_413072.awb") / 1000

					if var_132_33 + var_132_25 > arg_129_1.duration_ then
						arg_129_1.duration_ = var_132_33 + var_132_25
					end

					if var_132_28.prefab_name ~= "" and arg_129_1.actors_[var_132_28.prefab_name] ~= nil then
						local var_132_34 = LuaForUtil.PlayVoiceWithCriLipsync(arg_129_1.actors_[var_132_28.prefab_name].transform, "story_v_out_413072", "413072030", "story_v_out_413072.awb")

						arg_129_1:RecordAudio("413072030", var_132_34)
						arg_129_1:RecordAudio("413072030", var_132_34)
					else
						arg_129_1:AudioAction("play", "voice", "story_v_out_413072", "413072030", "story_v_out_413072.awb")
					end

					arg_129_1:RecordHistoryTalkVoice("story_v_out_413072", "413072030", "story_v_out_413072.awb")
				end

				arg_129_1:RecordContent(arg_129_1.text_.text)
			end

			local var_132_35 = math.max(var_132_26, arg_129_1.talkMaxDuration)

			if var_132_25 <= arg_129_1.time_ and arg_129_1.time_ < var_132_25 + var_132_35 then
				arg_129_1.typewritter.percent = (arg_129_1.time_ - var_132_25) / var_132_35

				arg_129_1.typewritter:SetDirty()
			end

			if arg_129_1.time_ >= var_132_25 + var_132_35 and arg_129_1.time_ < var_132_25 + var_132_35 + arg_132_0 then
				arg_129_1.typewritter.percent = 1

				arg_129_1.typewritter:SetDirty()
				arg_129_1:ShowNextGo(true)
			end
		end

		arg_129_1.nodeConfigList_ = {
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

		arg_129_1:InitPlayNodeList()
	end,
	Play413072031 = function(arg_133_0, arg_133_1)
		arg_133_1.time_ = 0
		arg_133_1.frameCnt_ = 0
		arg_133_1.state_ = "playing"
		arg_133_1.curTalkId_ = 413072031
		arg_133_1.duration_ = 5.3

		local var_133_0 = {
			zh = 5.3,
			ja = 2.9
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
				arg_133_0:Play413072032(arg_133_1)
			end
		end

		function arg_133_1.onSingleLineUpdate_(arg_136_0)
			local var_136_0 = 0
			local var_136_1 = 0.475

			if var_136_0 < arg_133_1.time_ and arg_133_1.time_ <= var_136_0 + arg_136_0 then
				arg_133_1.talkMaxDuration = 0
				arg_133_1.dialogCg_.alpha = 1

				arg_133_1.dialog_:SetActive(true)
				SetActive(arg_133_1.leftNameGo_, true)

				local var_136_2 = arg_133_1:FormatText(StoryNameCfg[28].name)

				arg_133_1.leftNameTxt_.text = var_136_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_133_1.leftNameTxt_.transform)

				arg_133_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_133_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_133_1:RecordName(arg_133_1.leftNameTxt_.text)
				SetActive(arg_133_1.iconTrs_.gameObject, false)
				arg_133_1.callingController_:SetSelectedState("normal")

				local var_136_3 = arg_133_1:GetWordFromCfg(413072031)
				local var_136_4 = arg_133_1:FormatText(var_136_3.content)

				arg_133_1.text_.text = var_136_4

				LuaForUtil.ClearLinePrefixSymbol(arg_133_1.text_)

				local var_136_5 = 19
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

				if manager.audio:GetVoiceLength("story_v_out_413072", "413072031", "story_v_out_413072.awb") ~= 0 then
					local var_136_8 = manager.audio:GetVoiceLength("story_v_out_413072", "413072031", "story_v_out_413072.awb") / 1000

					if var_136_8 + var_136_0 > arg_133_1.duration_ then
						arg_133_1.duration_ = var_136_8 + var_136_0
					end

					if var_136_3.prefab_name ~= "" and arg_133_1.actors_[var_136_3.prefab_name] ~= nil then
						local var_136_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_133_1.actors_[var_136_3.prefab_name].transform, "story_v_out_413072", "413072031", "story_v_out_413072.awb")

						arg_133_1:RecordAudio("413072031", var_136_9)
						arg_133_1:RecordAudio("413072031", var_136_9)
					else
						arg_133_1:AudioAction("play", "voice", "story_v_out_413072", "413072031", "story_v_out_413072.awb")
					end

					arg_133_1:RecordHistoryTalkVoice("story_v_out_413072", "413072031", "story_v_out_413072.awb")
				end

				arg_133_1:RecordContent(arg_133_1.text_.text)
			end

			local var_136_10 = math.max(var_136_1, arg_133_1.talkMaxDuration)

			if var_136_0 <= arg_133_1.time_ and arg_133_1.time_ < var_136_0 + var_136_10 then
				arg_133_1.typewritter.percent = (arg_133_1.time_ - var_136_0) / var_136_10

				arg_133_1.typewritter:SetDirty()
			end

			if arg_133_1.time_ >= var_136_0 + var_136_10 and arg_133_1.time_ < var_136_0 + var_136_10 + arg_136_0 then
				arg_133_1.typewritter.percent = 1

				arg_133_1.typewritter:SetDirty()
				arg_133_1:ShowNextGo(true)
			end
		end

		arg_133_1.nodeConfigList_ = {}

		arg_133_1:InitPlayNodeList()
	end,
	Play413072032 = function(arg_137_0, arg_137_1)
		arg_137_1.time_ = 0
		arg_137_1.frameCnt_ = 0
		arg_137_1.state_ = "playing"
		arg_137_1.curTalkId_ = 413072032
		arg_137_1.duration_ = 5

		SetActive(arg_137_1.tipsGo_, false)

		function arg_137_1.onSingleLineFinish_()
			arg_137_1.onSingleLineUpdate_ = nil
			arg_137_1.onSingleLineFinish_ = nil
			arg_137_1.state_ = "waiting"
		end

		function arg_137_1.playNext_(arg_139_0)
			if arg_139_0 == 1 then
				arg_137_0:Play413072033(arg_137_1)
			end
		end

		function arg_137_1.onSingleLineUpdate_(arg_140_0)
			local var_140_0 = arg_137_1.actors_["10093"]
			local var_140_1 = 0

			if var_140_1 < arg_137_1.time_ and arg_137_1.time_ <= var_140_1 + arg_140_0 and not isNil(var_140_0) and arg_137_1.var_.actorSpriteComps10093 == nil then
				arg_137_1.var_.actorSpriteComps10093 = var_140_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_140_2 = 2

			if var_140_1 <= arg_137_1.time_ and arg_137_1.time_ < var_140_1 + var_140_2 and not isNil(var_140_0) then
				local var_140_3 = (arg_137_1.time_ - var_140_1) / var_140_2

				if arg_137_1.var_.actorSpriteComps10093 then
					for iter_140_0, iter_140_1 in pairs(arg_137_1.var_.actorSpriteComps10093:ToTable()) do
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

			if arg_137_1.time_ >= var_140_1 + var_140_2 and arg_137_1.time_ < var_140_1 + var_140_2 + arg_140_0 and not isNil(var_140_0) and arg_137_1.var_.actorSpriteComps10093 then
				for iter_140_2, iter_140_3 in pairs(arg_137_1.var_.actorSpriteComps10093:ToTable()) do
					if iter_140_3 then
						if arg_137_1.isInRecall_ then
							iter_140_3.color = arg_137_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_140_3.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_137_1.var_.actorSpriteComps10093 = nil
			end

			local var_140_8 = 0
			local var_140_9 = 0.975

			if var_140_8 < arg_137_1.time_ and arg_137_1.time_ <= var_140_8 + arg_140_0 then
				arg_137_1.talkMaxDuration = 0
				arg_137_1.dialogCg_.alpha = 1

				arg_137_1.dialog_:SetActive(true)
				SetActive(arg_137_1.leftNameGo_, false)

				arg_137_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_137_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_137_1:RecordName(arg_137_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_137_1.iconTrs_.gameObject, false)
				arg_137_1.callingController_:SetSelectedState("normal")

				local var_140_10 = arg_137_1:GetWordFromCfg(413072032)
				local var_140_11 = arg_137_1:FormatText(var_140_10.content)

				arg_137_1.text_.text = var_140_11

				LuaForUtil.ClearLinePrefixSymbol(arg_137_1.text_)

				local var_140_12 = 39
				local var_140_13 = utf8.len(var_140_11)
				local var_140_14 = var_140_12 <= 0 and var_140_9 or var_140_9 * (var_140_13 / var_140_12)

				if var_140_14 > 0 and var_140_9 < var_140_14 then
					arg_137_1.talkMaxDuration = var_140_14

					if var_140_14 + var_140_8 > arg_137_1.duration_ then
						arg_137_1.duration_ = var_140_14 + var_140_8
					end
				end

				arg_137_1.text_.text = var_140_11
				arg_137_1.typewritter.percent = 0

				arg_137_1.typewritter:SetDirty()
				arg_137_1:ShowNextGo(false)
				arg_137_1:RecordContent(arg_137_1.text_.text)
			end

			local var_140_15 = math.max(var_140_9, arg_137_1.talkMaxDuration)

			if var_140_8 <= arg_137_1.time_ and arg_137_1.time_ < var_140_8 + var_140_15 then
				arg_137_1.typewritter.percent = (arg_137_1.time_ - var_140_8) / var_140_15

				arg_137_1.typewritter:SetDirty()
			end

			if arg_137_1.time_ >= var_140_8 + var_140_15 and arg_137_1.time_ < var_140_8 + var_140_15 + arg_140_0 then
				arg_137_1.typewritter.percent = 1

				arg_137_1.typewritter:SetDirty()
				arg_137_1:ShowNextGo(true)
			end
		end

		arg_137_1.nodeConfigList_ = {}

		arg_137_1:InitPlayNodeList()
	end,
	Play413072033 = function(arg_141_0, arg_141_1)
		arg_141_1.time_ = 0
		arg_141_1.frameCnt_ = 0
		arg_141_1.state_ = "playing"
		arg_141_1.curTalkId_ = 413072033
		arg_141_1.duration_ = 3.7

		local var_141_0 = {
			zh = 3.7,
			ja = 3.533
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
				arg_141_0:Play413072034(arg_141_1)
			end
		end

		function arg_141_1.onSingleLineUpdate_(arg_144_0)
			local var_144_0 = arg_141_1.actors_["10093"].transform
			local var_144_1 = 0

			if var_144_1 < arg_141_1.time_ and arg_141_1.time_ <= var_144_1 + arg_144_0 then
				arg_141_1.var_.moveOldPos10093 = var_144_0.localPosition
				var_144_0.localScale = Vector3.New(1, 1, 1)

				arg_141_1:CheckSpriteTmpPos("10093", 3)

				local var_144_2 = var_144_0.childCount

				for iter_144_0 = 0, var_144_2 - 1 do
					local var_144_3 = var_144_0:GetChild(iter_144_0)

					if var_144_3.name == "split_1" or not string.find(var_144_3.name, "split") then
						var_144_3.gameObject:SetActive(true)
					else
						var_144_3.gameObject:SetActive(false)
					end
				end
			end

			local var_144_4 = 0.001

			if var_144_1 <= arg_141_1.time_ and arg_141_1.time_ < var_144_1 + var_144_4 then
				local var_144_5 = (arg_141_1.time_ - var_144_1) / var_144_4
				local var_144_6 = Vector3.New(0, -345, -245)

				var_144_0.localPosition = Vector3.Lerp(arg_141_1.var_.moveOldPos10093, var_144_6, var_144_5)
			end

			if arg_141_1.time_ >= var_144_1 + var_144_4 and arg_141_1.time_ < var_144_1 + var_144_4 + arg_144_0 then
				var_144_0.localPosition = Vector3.New(0, -345, -245)
			end

			local var_144_7 = arg_141_1.actors_["10093"]
			local var_144_8 = 0

			if var_144_8 < arg_141_1.time_ and arg_141_1.time_ <= var_144_8 + arg_144_0 and not isNil(var_144_7) and arg_141_1.var_.actorSpriteComps10093 == nil then
				arg_141_1.var_.actorSpriteComps10093 = var_144_7:GetComponentsInChildren(typeof(Image), true)
			end

			local var_144_9 = 2

			if var_144_8 <= arg_141_1.time_ and arg_141_1.time_ < var_144_8 + var_144_9 and not isNil(var_144_7) then
				local var_144_10 = (arg_141_1.time_ - var_144_8) / var_144_9

				if arg_141_1.var_.actorSpriteComps10093 then
					for iter_144_1, iter_144_2 in pairs(arg_141_1.var_.actorSpriteComps10093:ToTable()) do
						if iter_144_2 then
							if arg_141_1.isInRecall_ then
								local var_144_11 = Mathf.Lerp(iter_144_2.color.r, arg_141_1.hightColor1.r, var_144_10)
								local var_144_12 = Mathf.Lerp(iter_144_2.color.g, arg_141_1.hightColor1.g, var_144_10)
								local var_144_13 = Mathf.Lerp(iter_144_2.color.b, arg_141_1.hightColor1.b, var_144_10)

								iter_144_2.color = Color.New(var_144_11, var_144_12, var_144_13)
							else
								local var_144_14 = Mathf.Lerp(iter_144_2.color.r, 1, var_144_10)

								iter_144_2.color = Color.New(var_144_14, var_144_14, var_144_14)
							end
						end
					end
				end
			end

			if arg_141_1.time_ >= var_144_8 + var_144_9 and arg_141_1.time_ < var_144_8 + var_144_9 + arg_144_0 and not isNil(var_144_7) and arg_141_1.var_.actorSpriteComps10093 then
				for iter_144_3, iter_144_4 in pairs(arg_141_1.var_.actorSpriteComps10093:ToTable()) do
					if iter_144_4 then
						if arg_141_1.isInRecall_ then
							iter_144_4.color = arg_141_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_144_4.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_141_1.var_.actorSpriteComps10093 = nil
			end

			local var_144_15 = 0
			local var_144_16 = 0.35

			if var_144_15 < arg_141_1.time_ and arg_141_1.time_ <= var_144_15 + arg_144_0 then
				arg_141_1.talkMaxDuration = 0
				arg_141_1.dialogCg_.alpha = 1

				arg_141_1.dialog_:SetActive(true)
				SetActive(arg_141_1.leftNameGo_, true)

				local var_144_17 = arg_141_1:FormatText(StoryNameCfg[28].name)

				arg_141_1.leftNameTxt_.text = var_144_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_141_1.leftNameTxt_.transform)

				arg_141_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_141_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_141_1:RecordName(arg_141_1.leftNameTxt_.text)
				SetActive(arg_141_1.iconTrs_.gameObject, false)
				arg_141_1.callingController_:SetSelectedState("normal")

				local var_144_18 = arg_141_1:GetWordFromCfg(413072033)
				local var_144_19 = arg_141_1:FormatText(var_144_18.content)

				arg_141_1.text_.text = var_144_19

				LuaForUtil.ClearLinePrefixSymbol(arg_141_1.text_)

				local var_144_20 = 14
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

				if manager.audio:GetVoiceLength("story_v_out_413072", "413072033", "story_v_out_413072.awb") ~= 0 then
					local var_144_23 = manager.audio:GetVoiceLength("story_v_out_413072", "413072033", "story_v_out_413072.awb") / 1000

					if var_144_23 + var_144_15 > arg_141_1.duration_ then
						arg_141_1.duration_ = var_144_23 + var_144_15
					end

					if var_144_18.prefab_name ~= "" and arg_141_1.actors_[var_144_18.prefab_name] ~= nil then
						local var_144_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_141_1.actors_[var_144_18.prefab_name].transform, "story_v_out_413072", "413072033", "story_v_out_413072.awb")

						arg_141_1:RecordAudio("413072033", var_144_24)
						arg_141_1:RecordAudio("413072033", var_144_24)
					else
						arg_141_1:AudioAction("play", "voice", "story_v_out_413072", "413072033", "story_v_out_413072.awb")
					end

					arg_141_1:RecordHistoryTalkVoice("story_v_out_413072", "413072033", "story_v_out_413072.awb")
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
				actorName = "10093",
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
	Play413072034 = function(arg_145_0, arg_145_1)
		arg_145_1.time_ = 0
		arg_145_1.frameCnt_ = 0
		arg_145_1.state_ = "playing"
		arg_145_1.curTalkId_ = 413072034
		arg_145_1.duration_ = 2.47

		local var_145_0 = {
			zh = 2.1,
			ja = 2.466
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
				arg_145_0:Play413072035(arg_145_1)
			end
		end

		function arg_145_1.onSingleLineUpdate_(arg_148_0)
			local var_148_0 = arg_145_1.actors_["10093"]
			local var_148_1 = 0

			if var_148_1 < arg_145_1.time_ and arg_145_1.time_ <= var_148_1 + arg_148_0 and not isNil(var_148_0) and arg_145_1.var_.actorSpriteComps10093 == nil then
				arg_145_1.var_.actorSpriteComps10093 = var_148_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_148_2 = 2

			if var_148_1 <= arg_145_1.time_ and arg_145_1.time_ < var_148_1 + var_148_2 and not isNil(var_148_0) then
				local var_148_3 = (arg_145_1.time_ - var_148_1) / var_148_2

				if arg_145_1.var_.actorSpriteComps10093 then
					for iter_148_0, iter_148_1 in pairs(arg_145_1.var_.actorSpriteComps10093:ToTable()) do
						if iter_148_1 then
							if arg_145_1.isInRecall_ then
								local var_148_4 = Mathf.Lerp(iter_148_1.color.r, arg_145_1.hightColor2.r, var_148_3)
								local var_148_5 = Mathf.Lerp(iter_148_1.color.g, arg_145_1.hightColor2.g, var_148_3)
								local var_148_6 = Mathf.Lerp(iter_148_1.color.b, arg_145_1.hightColor2.b, var_148_3)

								iter_148_1.color = Color.New(var_148_4, var_148_5, var_148_6)
							else
								local var_148_7 = Mathf.Lerp(iter_148_1.color.r, 0.5, var_148_3)

								iter_148_1.color = Color.New(var_148_7, var_148_7, var_148_7)
							end
						end
					end
				end
			end

			if arg_145_1.time_ >= var_148_1 + var_148_2 and arg_145_1.time_ < var_148_1 + var_148_2 + arg_148_0 and not isNil(var_148_0) and arg_145_1.var_.actorSpriteComps10093 then
				for iter_148_2, iter_148_3 in pairs(arg_145_1.var_.actorSpriteComps10093:ToTable()) do
					if iter_148_3 then
						if arg_145_1.isInRecall_ then
							iter_148_3.color = arg_145_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_148_3.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_145_1.var_.actorSpriteComps10093 = nil
			end

			local var_148_8 = 0
			local var_148_9 = 0.225

			if var_148_8 < arg_145_1.time_ and arg_145_1.time_ <= var_148_8 + arg_148_0 then
				arg_145_1.talkMaxDuration = 0
				arg_145_1.dialogCg_.alpha = 1

				arg_145_1.dialog_:SetActive(true)
				SetActive(arg_145_1.leftNameGo_, true)

				local var_148_10 = arg_145_1:FormatText(StoryNameCfg[994].name)

				arg_145_1.leftNameTxt_.text = var_148_10

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_145_1.leftNameTxt_.transform)

				arg_145_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_145_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_145_1:RecordName(arg_145_1.leftNameTxt_.text)
				SetActive(arg_145_1.iconTrs_.gameObject, true)
				arg_145_1.iconController_:SetSelectedState("hero")

				arg_145_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_knightman1")

				arg_145_1.callingController_:SetSelectedState("normal")

				arg_145_1.keyicon_.color = Color.New(1, 1, 1)
				arg_145_1.icon_.color = Color.New(1, 1, 1)

				local var_148_11 = arg_145_1:GetWordFromCfg(413072034)
				local var_148_12 = arg_145_1:FormatText(var_148_11.content)

				arg_145_1.text_.text = var_148_12

				LuaForUtil.ClearLinePrefixSymbol(arg_145_1.text_)

				local var_148_13 = 9
				local var_148_14 = utf8.len(var_148_12)
				local var_148_15 = var_148_13 <= 0 and var_148_9 or var_148_9 * (var_148_14 / var_148_13)

				if var_148_15 > 0 and var_148_9 < var_148_15 then
					arg_145_1.talkMaxDuration = var_148_15

					if var_148_15 + var_148_8 > arg_145_1.duration_ then
						arg_145_1.duration_ = var_148_15 + var_148_8
					end
				end

				arg_145_1.text_.text = var_148_12
				arg_145_1.typewritter.percent = 0

				arg_145_1.typewritter:SetDirty()
				arg_145_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_413072", "413072034", "story_v_out_413072.awb") ~= 0 then
					local var_148_16 = manager.audio:GetVoiceLength("story_v_out_413072", "413072034", "story_v_out_413072.awb") / 1000

					if var_148_16 + var_148_8 > arg_145_1.duration_ then
						arg_145_1.duration_ = var_148_16 + var_148_8
					end

					if var_148_11.prefab_name ~= "" and arg_145_1.actors_[var_148_11.prefab_name] ~= nil then
						local var_148_17 = LuaForUtil.PlayVoiceWithCriLipsync(arg_145_1.actors_[var_148_11.prefab_name].transform, "story_v_out_413072", "413072034", "story_v_out_413072.awb")

						arg_145_1:RecordAudio("413072034", var_148_17)
						arg_145_1:RecordAudio("413072034", var_148_17)
					else
						arg_145_1:AudioAction("play", "voice", "story_v_out_413072", "413072034", "story_v_out_413072.awb")
					end

					arg_145_1:RecordHistoryTalkVoice("story_v_out_413072", "413072034", "story_v_out_413072.awb")
				end

				arg_145_1:RecordContent(arg_145_1.text_.text)
			end

			local var_148_18 = math.max(var_148_9, arg_145_1.talkMaxDuration)

			if var_148_8 <= arg_145_1.time_ and arg_145_1.time_ < var_148_8 + var_148_18 then
				arg_145_1.typewritter.percent = (arg_145_1.time_ - var_148_8) / var_148_18

				arg_145_1.typewritter:SetDirty()
			end

			if arg_145_1.time_ >= var_148_8 + var_148_18 and arg_145_1.time_ < var_148_8 + var_148_18 + arg_148_0 then
				arg_145_1.typewritter.percent = 1

				arg_145_1.typewritter:SetDirty()
				arg_145_1:ShowNextGo(true)
			end
		end

		arg_145_1.nodeConfigList_ = {}

		arg_145_1:InitPlayNodeList()
	end,
	Play413072035 = function(arg_149_0, arg_149_1)
		arg_149_1.time_ = 0
		arg_149_1.frameCnt_ = 0
		arg_149_1.state_ = "playing"
		arg_149_1.curTalkId_ = 413072035
		arg_149_1.duration_ = 5

		SetActive(arg_149_1.tipsGo_, false)

		function arg_149_1.onSingleLineFinish_()
			arg_149_1.onSingleLineUpdate_ = nil
			arg_149_1.onSingleLineFinish_ = nil
			arg_149_1.state_ = "waiting"
		end

		function arg_149_1.playNext_(arg_151_0)
			if arg_151_0 == 1 then
				arg_149_0:Play413072036(arg_149_1)
			end
		end

		function arg_149_1.onSingleLineUpdate_(arg_152_0)
			local var_152_0 = arg_149_1.actors_["10093"].transform
			local var_152_1 = 0

			if var_152_1 < arg_149_1.time_ and arg_149_1.time_ <= var_152_1 + arg_152_0 then
				arg_149_1.var_.moveOldPos10093 = var_152_0.localPosition
				var_152_0.localScale = Vector3.New(1, 1, 1)

				arg_149_1:CheckSpriteTmpPos("10093", 7)

				local var_152_2 = var_152_0.childCount

				for iter_152_0 = 0, var_152_2 - 1 do
					local var_152_3 = var_152_0:GetChild(iter_152_0)

					if var_152_3.name == "" or not string.find(var_152_3.name, "split") then
						var_152_3.gameObject:SetActive(true)
					else
						var_152_3.gameObject:SetActive(false)
					end
				end
			end

			local var_152_4 = 0.001

			if var_152_1 <= arg_149_1.time_ and arg_149_1.time_ < var_152_1 + var_152_4 then
				local var_152_5 = (arg_149_1.time_ - var_152_1) / var_152_4
				local var_152_6 = Vector3.New(0, -2000, 0)

				var_152_0.localPosition = Vector3.Lerp(arg_149_1.var_.moveOldPos10093, var_152_6, var_152_5)
			end

			if arg_149_1.time_ >= var_152_1 + var_152_4 and arg_149_1.time_ < var_152_1 + var_152_4 + arg_152_0 then
				var_152_0.localPosition = Vector3.New(0, -2000, 0)
			end

			local var_152_7 = 0
			local var_152_8 = 0.666666666666667

			if var_152_7 < arg_149_1.time_ and arg_149_1.time_ <= var_152_7 + arg_152_0 then
				local var_152_9 = "play"
				local var_152_10 = "effect"

				arg_149_1:AudioAction(var_152_9, var_152_10, "se_story_134_01", "se_story_134_01_wave", "")
			end

			local var_152_11 = 0
			local var_152_12 = 1.075

			if var_152_11 < arg_149_1.time_ and arg_149_1.time_ <= var_152_11 + arg_152_0 then
				arg_149_1.talkMaxDuration = 0
				arg_149_1.dialogCg_.alpha = 1

				arg_149_1.dialog_:SetActive(true)
				SetActive(arg_149_1.leftNameGo_, false)

				arg_149_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_149_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_149_1:RecordName(arg_149_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_149_1.iconTrs_.gameObject, false)
				arg_149_1.callingController_:SetSelectedState("normal")

				local var_152_13 = arg_149_1:GetWordFromCfg(413072035)
				local var_152_14 = arg_149_1:FormatText(var_152_13.content)

				arg_149_1.text_.text = var_152_14

				LuaForUtil.ClearLinePrefixSymbol(arg_149_1.text_)

				local var_152_15 = 43
				local var_152_16 = utf8.len(var_152_14)
				local var_152_17 = var_152_15 <= 0 and var_152_12 or var_152_12 * (var_152_16 / var_152_15)

				if var_152_17 > 0 and var_152_12 < var_152_17 then
					arg_149_1.talkMaxDuration = var_152_17

					if var_152_17 + var_152_11 > arg_149_1.duration_ then
						arg_149_1.duration_ = var_152_17 + var_152_11
					end
				end

				arg_149_1.text_.text = var_152_14
				arg_149_1.typewritter.percent = 0

				arg_149_1.typewritter:SetDirty()
				arg_149_1:ShowNextGo(false)
				arg_149_1:RecordContent(arg_149_1.text_.text)
			end

			local var_152_18 = math.max(var_152_12, arg_149_1.talkMaxDuration)

			if var_152_11 <= arg_149_1.time_ and arg_149_1.time_ < var_152_11 + var_152_18 then
				arg_149_1.typewritter.percent = (arg_149_1.time_ - var_152_11) / var_152_18

				arg_149_1.typewritter:SetDirty()
			end

			if arg_149_1.time_ >= var_152_11 + var_152_18 and arg_149_1.time_ < var_152_11 + var_152_18 + arg_152_0 then
				arg_149_1.typewritter.percent = 1

				arg_149_1.typewritter:SetDirty()
				arg_149_1:ShowNextGo(true)
			end
		end

		arg_149_1.nodeConfigList_ = {
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

		arg_149_1:InitPlayNodeList()
	end,
	Play413072036 = function(arg_153_0, arg_153_1)
		arg_153_1.time_ = 0
		arg_153_1.frameCnt_ = 0
		arg_153_1.state_ = "playing"
		arg_153_1.curTalkId_ = 413072036
		arg_153_1.duration_ = 4.07

		local var_153_0 = {
			zh = 3.433,
			ja = 4.066
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
				arg_153_0:Play413072037(arg_153_1)
			end
		end

		function arg_153_1.onSingleLineUpdate_(arg_156_0)
			local var_156_0 = arg_153_1.actors_["10093"].transform
			local var_156_1 = 0

			if var_156_1 < arg_153_1.time_ and arg_153_1.time_ <= var_156_1 + arg_156_0 then
				arg_153_1.var_.moveOldPos10093 = var_156_0.localPosition
				var_156_0.localScale = Vector3.New(1, 1, 1)

				arg_153_1:CheckSpriteTmpPos("10093", 3)

				local var_156_2 = var_156_0.childCount

				for iter_156_0 = 0, var_156_2 - 1 do
					local var_156_3 = var_156_0:GetChild(iter_156_0)

					if var_156_3.name == "split_3" or not string.find(var_156_3.name, "split") then
						var_156_3.gameObject:SetActive(true)
					else
						var_156_3.gameObject:SetActive(false)
					end
				end
			end

			local var_156_4 = 0.001

			if var_156_1 <= arg_153_1.time_ and arg_153_1.time_ < var_156_1 + var_156_4 then
				local var_156_5 = (arg_153_1.time_ - var_156_1) / var_156_4
				local var_156_6 = Vector3.New(0, -345, -245)

				var_156_0.localPosition = Vector3.Lerp(arg_153_1.var_.moveOldPos10093, var_156_6, var_156_5)
			end

			if arg_153_1.time_ >= var_156_1 + var_156_4 and arg_153_1.time_ < var_156_1 + var_156_4 + arg_156_0 then
				var_156_0.localPosition = Vector3.New(0, -345, -245)
			end

			local var_156_7 = arg_153_1.actors_["10093"]
			local var_156_8 = 0

			if var_156_8 < arg_153_1.time_ and arg_153_1.time_ <= var_156_8 + arg_156_0 and not isNil(var_156_7) and arg_153_1.var_.actorSpriteComps10093 == nil then
				arg_153_1.var_.actorSpriteComps10093 = var_156_7:GetComponentsInChildren(typeof(Image), true)
			end

			local var_156_9 = 2

			if var_156_8 <= arg_153_1.time_ and arg_153_1.time_ < var_156_8 + var_156_9 and not isNil(var_156_7) then
				local var_156_10 = (arg_153_1.time_ - var_156_8) / var_156_9

				if arg_153_1.var_.actorSpriteComps10093 then
					for iter_156_1, iter_156_2 in pairs(arg_153_1.var_.actorSpriteComps10093:ToTable()) do
						if iter_156_2 then
							if arg_153_1.isInRecall_ then
								local var_156_11 = Mathf.Lerp(iter_156_2.color.r, arg_153_1.hightColor1.r, var_156_10)
								local var_156_12 = Mathf.Lerp(iter_156_2.color.g, arg_153_1.hightColor1.g, var_156_10)
								local var_156_13 = Mathf.Lerp(iter_156_2.color.b, arg_153_1.hightColor1.b, var_156_10)

								iter_156_2.color = Color.New(var_156_11, var_156_12, var_156_13)
							else
								local var_156_14 = Mathf.Lerp(iter_156_2.color.r, 1, var_156_10)

								iter_156_2.color = Color.New(var_156_14, var_156_14, var_156_14)
							end
						end
					end
				end
			end

			if arg_153_1.time_ >= var_156_8 + var_156_9 and arg_153_1.time_ < var_156_8 + var_156_9 + arg_156_0 and not isNil(var_156_7) and arg_153_1.var_.actorSpriteComps10093 then
				for iter_156_3, iter_156_4 in pairs(arg_153_1.var_.actorSpriteComps10093:ToTable()) do
					if iter_156_4 then
						if arg_153_1.isInRecall_ then
							iter_156_4.color = arg_153_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_156_4.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_153_1.var_.actorSpriteComps10093 = nil
			end

			local var_156_15 = 0
			local var_156_16 = 0.4

			if var_156_15 < arg_153_1.time_ and arg_153_1.time_ <= var_156_15 + arg_156_0 then
				arg_153_1.talkMaxDuration = 0
				arg_153_1.dialogCg_.alpha = 1

				arg_153_1.dialog_:SetActive(true)
				SetActive(arg_153_1.leftNameGo_, true)

				local var_156_17 = arg_153_1:FormatText(StoryNameCfg[28].name)

				arg_153_1.leftNameTxt_.text = var_156_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_153_1.leftNameTxt_.transform)

				arg_153_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_153_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_153_1:RecordName(arg_153_1.leftNameTxt_.text)
				SetActive(arg_153_1.iconTrs_.gameObject, false)
				arg_153_1.callingController_:SetSelectedState("normal")

				local var_156_18 = arg_153_1:GetWordFromCfg(413072036)
				local var_156_19 = arg_153_1:FormatText(var_156_18.content)

				arg_153_1.text_.text = var_156_19

				LuaForUtil.ClearLinePrefixSymbol(arg_153_1.text_)

				local var_156_20 = 16
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

				if manager.audio:GetVoiceLength("story_v_out_413072", "413072036", "story_v_out_413072.awb") ~= 0 then
					local var_156_23 = manager.audio:GetVoiceLength("story_v_out_413072", "413072036", "story_v_out_413072.awb") / 1000

					if var_156_23 + var_156_15 > arg_153_1.duration_ then
						arg_153_1.duration_ = var_156_23 + var_156_15
					end

					if var_156_18.prefab_name ~= "" and arg_153_1.actors_[var_156_18.prefab_name] ~= nil then
						local var_156_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_153_1.actors_[var_156_18.prefab_name].transform, "story_v_out_413072", "413072036", "story_v_out_413072.awb")

						arg_153_1:RecordAudio("413072036", var_156_24)
						arg_153_1:RecordAudio("413072036", var_156_24)
					else
						arg_153_1:AudioAction("play", "voice", "story_v_out_413072", "413072036", "story_v_out_413072.awb")
					end

					arg_153_1:RecordHistoryTalkVoice("story_v_out_413072", "413072036", "story_v_out_413072.awb")
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
				actorName = "10093",
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
	Play413072037 = function(arg_157_0, arg_157_1)
		arg_157_1.time_ = 0
		arg_157_1.frameCnt_ = 0
		arg_157_1.state_ = "playing"
		arg_157_1.curTalkId_ = 413072037
		arg_157_1.duration_ = 7.93

		local var_157_0 = {
			zh = 7.933,
			ja = 7.5
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
				arg_157_0:Play413072038(arg_157_1)
			end
		end

		function arg_157_1.onSingleLineUpdate_(arg_160_0)
			local var_160_0 = "10092"

			if arg_157_1.actors_[var_160_0] == nil then
				local var_160_1 = Asset.Load("Widget/System/Story/StoryExpression/" .. "10092")

				if not isNil(var_160_1) then
					local var_160_2 = Object.Instantiate(var_160_1, arg_157_1.canvasGo_.transform)

					var_160_2.transform:SetSiblingIndex(1)

					var_160_2.name = var_160_0
					var_160_2.transform.localPosition = Vector3.New(0, 100000, 0)
					arg_157_1.actors_[var_160_0] = var_160_2

					local var_160_3 = var_160_2:GetComponentsInChildren(typeof(Image), true):ToTable()

					if arg_157_1.isInRecall_ then
						for iter_160_0, iter_160_1 in ipairs(var_160_3) do
							iter_160_1.color = arg_157_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						end
					end
				end
			end

			local var_160_4 = arg_157_1.actors_["10092"].transform
			local var_160_5 = 2

			if var_160_5 < arg_157_1.time_ and arg_157_1.time_ <= var_160_5 + arg_160_0 then
				arg_157_1.var_.moveOldPos10092 = var_160_4.localPosition
				var_160_4.localScale = Vector3.New(1, 1, 1)

				arg_157_1:CheckSpriteTmpPos("10092", 3)

				local var_160_6 = var_160_4.childCount

				for iter_160_2 = 0, var_160_6 - 1 do
					local var_160_7 = var_160_4:GetChild(iter_160_2)

					if var_160_7.name == "" or not string.find(var_160_7.name, "split") then
						var_160_7.gameObject:SetActive(true)
					else
						var_160_7.gameObject:SetActive(false)
					end
				end
			end

			local var_160_8 = 0.001

			if var_160_5 <= arg_157_1.time_ and arg_157_1.time_ < var_160_5 + var_160_8 then
				local var_160_9 = (arg_157_1.time_ - var_160_5) / var_160_8
				local var_160_10 = Vector3.New(0, -300, -295)

				var_160_4.localPosition = Vector3.Lerp(arg_157_1.var_.moveOldPos10092, var_160_10, var_160_9)
			end

			if arg_157_1.time_ >= var_160_5 + var_160_8 and arg_157_1.time_ < var_160_5 + var_160_8 + arg_160_0 then
				var_160_4.localPosition = Vector3.New(0, -300, -295)
			end

			local var_160_11 = arg_157_1.actors_["10093"].transform
			local var_160_12 = 0

			if var_160_12 < arg_157_1.time_ and arg_157_1.time_ <= var_160_12 + arg_160_0 then
				arg_157_1.var_.moveOldPos10093 = var_160_11.localPosition
				var_160_11.localScale = Vector3.New(1, 1, 1)

				arg_157_1:CheckSpriteTmpPos("10093", 7)

				local var_160_13 = var_160_11.childCount

				for iter_160_3 = 0, var_160_13 - 1 do
					local var_160_14 = var_160_11:GetChild(iter_160_3)

					if var_160_14.name == "" or not string.find(var_160_14.name, "split") then
						var_160_14.gameObject:SetActive(true)
					else
						var_160_14.gameObject:SetActive(false)
					end
				end
			end

			local var_160_15 = 0.001

			if var_160_12 <= arg_157_1.time_ and arg_157_1.time_ < var_160_12 + var_160_15 then
				local var_160_16 = (arg_157_1.time_ - var_160_12) / var_160_15
				local var_160_17 = Vector3.New(0, -2000, 0)

				var_160_11.localPosition = Vector3.Lerp(arg_157_1.var_.moveOldPos10093, var_160_17, var_160_16)
			end

			if arg_157_1.time_ >= var_160_12 + var_160_15 and arg_157_1.time_ < var_160_12 + var_160_15 + arg_160_0 then
				var_160_11.localPosition = Vector3.New(0, -2000, 0)
			end

			local var_160_18 = arg_157_1.actors_["10092"]
			local var_160_19 = 2

			if var_160_19 < arg_157_1.time_ and arg_157_1.time_ <= var_160_19 + arg_160_0 and not isNil(var_160_18) and arg_157_1.var_.actorSpriteComps10092 == nil then
				arg_157_1.var_.actorSpriteComps10092 = var_160_18:GetComponentsInChildren(typeof(Image), true)
			end

			local var_160_20 = 2

			if var_160_19 <= arg_157_1.time_ and arg_157_1.time_ < var_160_19 + var_160_20 and not isNil(var_160_18) then
				local var_160_21 = (arg_157_1.time_ - var_160_19) / var_160_20

				if arg_157_1.var_.actorSpriteComps10092 then
					for iter_160_4, iter_160_5 in pairs(arg_157_1.var_.actorSpriteComps10092:ToTable()) do
						if iter_160_5 then
							if arg_157_1.isInRecall_ then
								local var_160_22 = Mathf.Lerp(iter_160_5.color.r, arg_157_1.hightColor1.r, var_160_21)
								local var_160_23 = Mathf.Lerp(iter_160_5.color.g, arg_157_1.hightColor1.g, var_160_21)
								local var_160_24 = Mathf.Lerp(iter_160_5.color.b, arg_157_1.hightColor1.b, var_160_21)

								iter_160_5.color = Color.New(var_160_22, var_160_23, var_160_24)
							else
								local var_160_25 = Mathf.Lerp(iter_160_5.color.r, 1, var_160_21)

								iter_160_5.color = Color.New(var_160_25, var_160_25, var_160_25)
							end
						end
					end
				end
			end

			if arg_157_1.time_ >= var_160_19 + var_160_20 and arg_157_1.time_ < var_160_19 + var_160_20 + arg_160_0 and not isNil(var_160_18) and arg_157_1.var_.actorSpriteComps10092 then
				for iter_160_6, iter_160_7 in pairs(arg_157_1.var_.actorSpriteComps10092:ToTable()) do
					if iter_160_7 then
						if arg_157_1.isInRecall_ then
							iter_160_7.color = arg_157_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_160_7.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_157_1.var_.actorSpriteComps10092 = nil
			end

			local var_160_26 = arg_157_1.actors_["10093"]
			local var_160_27 = 2

			if var_160_27 < arg_157_1.time_ and arg_157_1.time_ <= var_160_27 + arg_160_0 and not isNil(var_160_26) and arg_157_1.var_.actorSpriteComps10093 == nil then
				arg_157_1.var_.actorSpriteComps10093 = var_160_26:GetComponentsInChildren(typeof(Image), true)
			end

			local var_160_28 = 2

			if var_160_27 <= arg_157_1.time_ and arg_157_1.time_ < var_160_27 + var_160_28 and not isNil(var_160_26) then
				local var_160_29 = (arg_157_1.time_ - var_160_27) / var_160_28

				if arg_157_1.var_.actorSpriteComps10093 then
					for iter_160_8, iter_160_9 in pairs(arg_157_1.var_.actorSpriteComps10093:ToTable()) do
						if iter_160_9 then
							if arg_157_1.isInRecall_ then
								local var_160_30 = Mathf.Lerp(iter_160_9.color.r, arg_157_1.hightColor2.r, var_160_29)
								local var_160_31 = Mathf.Lerp(iter_160_9.color.g, arg_157_1.hightColor2.g, var_160_29)
								local var_160_32 = Mathf.Lerp(iter_160_9.color.b, arg_157_1.hightColor2.b, var_160_29)

								iter_160_9.color = Color.New(var_160_30, var_160_31, var_160_32)
							else
								local var_160_33 = Mathf.Lerp(iter_160_9.color.r, 0.5, var_160_29)

								iter_160_9.color = Color.New(var_160_33, var_160_33, var_160_33)
							end
						end
					end
				end
			end

			if arg_157_1.time_ >= var_160_27 + var_160_28 and arg_157_1.time_ < var_160_27 + var_160_28 + arg_160_0 and not isNil(var_160_26) and arg_157_1.var_.actorSpriteComps10093 then
				for iter_160_10, iter_160_11 in pairs(arg_157_1.var_.actorSpriteComps10093:ToTable()) do
					if iter_160_11 then
						if arg_157_1.isInRecall_ then
							iter_160_11.color = arg_157_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_160_11.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_157_1.var_.actorSpriteComps10093 = nil
			end

			local var_160_34 = arg_157_1.actors_["10092"]
			local var_160_35 = 2

			if var_160_35 < arg_157_1.time_ and arg_157_1.time_ <= var_160_35 + arg_160_0 then
				local var_160_36 = var_160_34:GetComponentInChildren(typeof(CanvasGroup))

				if var_160_36 then
					arg_157_1.var_.alphaOldValue10092 = var_160_36.alpha
					arg_157_1.var_.characterEffect10092 = var_160_36
				end

				arg_157_1.var_.alphaOldValue10092 = 0
			end

			local var_160_37 = 0.3

			if var_160_35 <= arg_157_1.time_ and arg_157_1.time_ < var_160_35 + var_160_37 then
				local var_160_38 = (arg_157_1.time_ - var_160_35) / var_160_37
				local var_160_39 = Mathf.Lerp(arg_157_1.var_.alphaOldValue10092, 1, var_160_38)

				if arg_157_1.var_.characterEffect10092 then
					arg_157_1.var_.characterEffect10092.alpha = var_160_39
				end
			end

			if arg_157_1.time_ >= var_160_35 + var_160_37 and arg_157_1.time_ < var_160_35 + var_160_37 + arg_160_0 and arg_157_1.var_.characterEffect10092 then
				arg_157_1.var_.characterEffect10092.alpha = 1
			end

			local var_160_40 = manager.ui.mainCamera.transform
			local var_160_41 = 0

			if var_160_41 < arg_157_1.time_ and arg_157_1.time_ <= var_160_41 + arg_160_0 then
				local var_160_42 = arg_157_1.var_.effectchuanyu1

				if var_160_42 then
					Object.Destroy(var_160_42)

					arg_157_1.var_.effectchuanyu1 = nil
				end
			end

			local var_160_43 = manager.ui.mainCamera.transform
			local var_160_44 = 0

			if var_160_44 < arg_157_1.time_ and arg_157_1.time_ <= var_160_44 + arg_160_0 then
				local var_160_45 = arg_157_1.var_.effect233
				local var_160_46
				local var_160_47 = var_160_43

				if not var_160_45 then
					var_160_45 = Object.Instantiate(Asset.Load("Effect/Scene/fx_ui_slash_01"), var_160_47)
					var_160_45.name = "233"
					arg_157_1.var_.effect233 = var_160_45
				else
					var_160_45.transform:SetParent(var_160_47)
				end

				var_160_45.transform.localPosition = Vector3.New(0, 0, 0.44)
				var_160_45.transform.localRotation = Quaternion.Euler(0, 0, 0)
			end

			local var_160_48 = manager.ui.mainCamera.transform
			local var_160_49 = 0.633333333333333

			if var_160_49 < arg_157_1.time_ and arg_157_1.time_ <= var_160_49 + arg_160_0 then
				local var_160_50 = arg_157_1.var_.effect233

				if var_160_50 then
					Object.Destroy(var_160_50)

					arg_157_1.var_.effect233 = nil
				end
			end

			local var_160_51 = 0

			if var_160_51 < arg_157_1.time_ and arg_157_1.time_ <= var_160_51 + arg_160_0 then
				arg_157_1.allBtn_.enabled = false
			end

			local var_160_52 = 2

			if arg_157_1.time_ >= var_160_51 + var_160_52 and arg_157_1.time_ < var_160_51 + var_160_52 + arg_160_0 then
				arg_157_1.allBtn_.enabled = true
			end

			local var_160_53 = manager.ui.mainCamera.transform
			local var_160_54 = 0

			if var_160_54 < arg_157_1.time_ and arg_157_1.time_ <= var_160_54 + arg_160_0 then
				arg_157_1.var_.shakeOldPos = var_160_53.localPosition
			end

			local var_160_55 = 0.6

			if var_160_54 <= arg_157_1.time_ and arg_157_1.time_ < var_160_54 + var_160_55 then
				local var_160_56 = (arg_157_1.time_ - var_160_54) / 0.066
				local var_160_57, var_160_58 = math.modf(var_160_56)

				var_160_53.localPosition = Vector3.New(var_160_58 * 0.13, var_160_58 * 0.13, var_160_58 * 0.13) + arg_157_1.var_.shakeOldPos
			end

			if arg_157_1.time_ >= var_160_54 + var_160_55 and arg_157_1.time_ < var_160_54 + var_160_55 + arg_160_0 then
				var_160_53.localPosition = arg_157_1.var_.shakeOldPos
			end

			if arg_157_1.frameCnt_ <= 1 then
				arg_157_1.dialog_:SetActive(false)
			end

			local var_160_59 = 2
			local var_160_60 = 0.7

			if var_160_59 < arg_157_1.time_ and arg_157_1.time_ <= var_160_59 + arg_160_0 then
				arg_157_1.talkMaxDuration = 0

				arg_157_1.dialog_:SetActive(true)

				arg_157_1.dialogCg_.alpha = 0

				local var_160_61 = LeanTween.value(arg_157_1.dialog_, 0, 1, 0.3)

				var_160_61:setOnUpdate(LuaHelper.FloatAction(function(arg_161_0)
					arg_157_1.dialogCg_.alpha = arg_161_0
				end))
				var_160_61:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_157_1.dialog_)
					var_160_61:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_157_1.duration_ = arg_157_1.duration_ + 0.3

				SetActive(arg_157_1.leftNameGo_, true)

				local var_160_62 = arg_157_1:FormatText(StoryNameCfg[996].name)

				arg_157_1.leftNameTxt_.text = var_160_62

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_157_1.leftNameTxt_.transform)

				arg_157_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_157_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_157_1:RecordName(arg_157_1.leftNameTxt_.text)
				SetActive(arg_157_1.iconTrs_.gameObject, false)
				arg_157_1.callingController_:SetSelectedState("normal")

				local var_160_63 = arg_157_1:GetWordFromCfg(413072037)
				local var_160_64 = arg_157_1:FormatText(var_160_63.content)

				arg_157_1.text_.text = var_160_64

				LuaForUtil.ClearLinePrefixSymbol(arg_157_1.text_)

				local var_160_65 = 28
				local var_160_66 = utf8.len(var_160_64)
				local var_160_67 = var_160_65 <= 0 and var_160_60 or var_160_60 * (var_160_66 / var_160_65)

				if var_160_67 > 0 and var_160_60 < var_160_67 then
					arg_157_1.talkMaxDuration = var_160_67
					var_160_59 = var_160_59 + 0.3

					if var_160_67 + var_160_59 > arg_157_1.duration_ then
						arg_157_1.duration_ = var_160_67 + var_160_59
					end
				end

				arg_157_1.text_.text = var_160_64
				arg_157_1.typewritter.percent = 0

				arg_157_1.typewritter:SetDirty()
				arg_157_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_413072", "413072037", "story_v_out_413072.awb") ~= 0 then
					local var_160_68 = manager.audio:GetVoiceLength("story_v_out_413072", "413072037", "story_v_out_413072.awb") / 1000

					if var_160_68 + var_160_59 > arg_157_1.duration_ then
						arg_157_1.duration_ = var_160_68 + var_160_59
					end

					if var_160_63.prefab_name ~= "" and arg_157_1.actors_[var_160_63.prefab_name] ~= nil then
						local var_160_69 = LuaForUtil.PlayVoiceWithCriLipsync(arg_157_1.actors_[var_160_63.prefab_name].transform, "story_v_out_413072", "413072037", "story_v_out_413072.awb")

						arg_157_1:RecordAudio("413072037", var_160_69)
						arg_157_1:RecordAudio("413072037", var_160_69)
					else
						arg_157_1:AudioAction("play", "voice", "story_v_out_413072", "413072037", "story_v_out_413072.awb")
					end

					arg_157_1:RecordHistoryTalkVoice("story_v_out_413072", "413072037", "story_v_out_413072.awb")
				end

				arg_157_1:RecordContent(arg_157_1.text_.text)
			end

			local var_160_70 = var_160_59 + 0.3
			local var_160_71 = math.max(var_160_60, arg_157_1.talkMaxDuration)

			if var_160_70 <= arg_157_1.time_ and arg_157_1.time_ < var_160_70 + var_160_71 then
				arg_157_1.typewritter.percent = (arg_157_1.time_ - var_160_70) / var_160_71

				arg_157_1.typewritter:SetDirty()
			end

			if arg_157_1.time_ >= var_160_70 + var_160_71 and arg_157_1.time_ < var_160_70 + var_160_71 + arg_160_0 then
				arg_157_1.typewritter.percent = 1

				arg_157_1.typewritter:SetDirty()
				arg_157_1:ShowNextGo(true)
			end
		end

		arg_157_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10092",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 2,
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

		arg_157_1:InitPlayNodeList()
	end,
	Play413072038 = function(arg_163_0, arg_163_1)
		arg_163_1.time_ = 0
		arg_163_1.frameCnt_ = 0
		arg_163_1.state_ = "playing"
		arg_163_1.curTalkId_ = 413072038
		arg_163_1.duration_ = 2.93

		local var_163_0 = {
			zh = 1,
			ja = 2.933
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
				arg_163_0:Play413072039(arg_163_1)
			end
		end

		function arg_163_1.onSingleLineUpdate_(arg_166_0)
			local var_166_0 = 0
			local var_166_1 = 0.125

			if var_166_0 < arg_163_1.time_ and arg_163_1.time_ <= var_166_0 + arg_166_0 then
				arg_163_1.talkMaxDuration = 0
				arg_163_1.dialogCg_.alpha = 1

				arg_163_1.dialog_:SetActive(true)
				SetActive(arg_163_1.leftNameGo_, true)

				local var_166_2 = arg_163_1:FormatText(StoryNameCfg[996].name)

				arg_163_1.leftNameTxt_.text = var_166_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_163_1.leftNameTxt_.transform)

				arg_163_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_163_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_163_1:RecordName(arg_163_1.leftNameTxt_.text)
				SetActive(arg_163_1.iconTrs_.gameObject, false)
				arg_163_1.callingController_:SetSelectedState("normal")

				local var_166_3 = arg_163_1:GetWordFromCfg(413072038)
				local var_166_4 = arg_163_1:FormatText(var_166_3.content)

				arg_163_1.text_.text = var_166_4

				LuaForUtil.ClearLinePrefixSymbol(arg_163_1.text_)

				local var_166_5 = 5
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

				if manager.audio:GetVoiceLength("story_v_out_413072", "413072038", "story_v_out_413072.awb") ~= 0 then
					local var_166_8 = manager.audio:GetVoiceLength("story_v_out_413072", "413072038", "story_v_out_413072.awb") / 1000

					if var_166_8 + var_166_0 > arg_163_1.duration_ then
						arg_163_1.duration_ = var_166_8 + var_166_0
					end

					if var_166_3.prefab_name ~= "" and arg_163_1.actors_[var_166_3.prefab_name] ~= nil then
						local var_166_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_163_1.actors_[var_166_3.prefab_name].transform, "story_v_out_413072", "413072038", "story_v_out_413072.awb")

						arg_163_1:RecordAudio("413072038", var_166_9)
						arg_163_1:RecordAudio("413072038", var_166_9)
					else
						arg_163_1:AudioAction("play", "voice", "story_v_out_413072", "413072038", "story_v_out_413072.awb")
					end

					arg_163_1:RecordHistoryTalkVoice("story_v_out_413072", "413072038", "story_v_out_413072.awb")
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
	Play413072039 = function(arg_167_0, arg_167_1)
		arg_167_1.time_ = 0
		arg_167_1.frameCnt_ = 0
		arg_167_1.state_ = "playing"
		arg_167_1.curTalkId_ = 413072039
		arg_167_1.duration_ = 3.67

		local var_167_0 = {
			zh = 3.1,
			ja = 3.666
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
				arg_167_0:Play413072040(arg_167_1)
			end
		end

		function arg_167_1.onSingleLineUpdate_(arg_170_0)
			local var_170_0 = arg_167_1.actors_["10092"].transform
			local var_170_1 = 0

			if var_170_1 < arg_167_1.time_ and arg_167_1.time_ <= var_170_1 + arg_170_0 then
				arg_167_1.var_.moveOldPos10092 = var_170_0.localPosition
				var_170_0.localScale = Vector3.New(1, 1, 1)

				arg_167_1:CheckSpriteTmpPos("10092", 4)

				local var_170_2 = var_170_0.childCount

				for iter_170_0 = 0, var_170_2 - 1 do
					local var_170_3 = var_170_0:GetChild(iter_170_0)

					if var_170_3.name == "" or not string.find(var_170_3.name, "split") then
						var_170_3.gameObject:SetActive(true)
					else
						var_170_3.gameObject:SetActive(false)
					end
				end
			end

			local var_170_4 = 0.001

			if var_170_1 <= arg_167_1.time_ and arg_167_1.time_ < var_170_1 + var_170_4 then
				local var_170_5 = (arg_167_1.time_ - var_170_1) / var_170_4
				local var_170_6 = Vector3.New(390, -300, -295)

				var_170_0.localPosition = Vector3.Lerp(arg_167_1.var_.moveOldPos10092, var_170_6, var_170_5)
			end

			if arg_167_1.time_ >= var_170_1 + var_170_4 and arg_167_1.time_ < var_170_1 + var_170_4 + arg_170_0 then
				var_170_0.localPosition = Vector3.New(390, -300, -295)
			end

			local var_170_7 = arg_167_1.actors_["10093"].transform
			local var_170_8 = 0

			if var_170_8 < arg_167_1.time_ and arg_167_1.time_ <= var_170_8 + arg_170_0 then
				arg_167_1.var_.moveOldPos10093 = var_170_7.localPosition
				var_170_7.localScale = Vector3.New(1, 1, 1)

				arg_167_1:CheckSpriteTmpPos("10093", 2)

				local var_170_9 = var_170_7.childCount

				for iter_170_1 = 0, var_170_9 - 1 do
					local var_170_10 = var_170_7:GetChild(iter_170_1)

					if var_170_10.name == "split_1" or not string.find(var_170_10.name, "split") then
						var_170_10.gameObject:SetActive(true)
					else
						var_170_10.gameObject:SetActive(false)
					end
				end
			end

			local var_170_11 = 0.001

			if var_170_8 <= arg_167_1.time_ and arg_167_1.time_ < var_170_8 + var_170_11 then
				local var_170_12 = (arg_167_1.time_ - var_170_8) / var_170_11
				local var_170_13 = Vector3.New(-390, -345, -245)

				var_170_7.localPosition = Vector3.Lerp(arg_167_1.var_.moveOldPos10093, var_170_13, var_170_12)
			end

			if arg_167_1.time_ >= var_170_8 + var_170_11 and arg_167_1.time_ < var_170_8 + var_170_11 + arg_170_0 then
				var_170_7.localPosition = Vector3.New(-390, -345, -245)
			end

			local var_170_14 = arg_167_1.actors_["10092"]
			local var_170_15 = 0

			if var_170_15 < arg_167_1.time_ and arg_167_1.time_ <= var_170_15 + arg_170_0 and not isNil(var_170_14) and arg_167_1.var_.actorSpriteComps10092 == nil then
				arg_167_1.var_.actorSpriteComps10092 = var_170_14:GetComponentsInChildren(typeof(Image), true)
			end

			local var_170_16 = 2

			if var_170_15 <= arg_167_1.time_ and arg_167_1.time_ < var_170_15 + var_170_16 and not isNil(var_170_14) then
				local var_170_17 = (arg_167_1.time_ - var_170_15) / var_170_16

				if arg_167_1.var_.actorSpriteComps10092 then
					for iter_170_2, iter_170_3 in pairs(arg_167_1.var_.actorSpriteComps10092:ToTable()) do
						if iter_170_3 then
							if arg_167_1.isInRecall_ then
								local var_170_18 = Mathf.Lerp(iter_170_3.color.r, arg_167_1.hightColor2.r, var_170_17)
								local var_170_19 = Mathf.Lerp(iter_170_3.color.g, arg_167_1.hightColor2.g, var_170_17)
								local var_170_20 = Mathf.Lerp(iter_170_3.color.b, arg_167_1.hightColor2.b, var_170_17)

								iter_170_3.color = Color.New(var_170_18, var_170_19, var_170_20)
							else
								local var_170_21 = Mathf.Lerp(iter_170_3.color.r, 0.5, var_170_17)

								iter_170_3.color = Color.New(var_170_21, var_170_21, var_170_21)
							end
						end
					end
				end
			end

			if arg_167_1.time_ >= var_170_15 + var_170_16 and arg_167_1.time_ < var_170_15 + var_170_16 + arg_170_0 and not isNil(var_170_14) and arg_167_1.var_.actorSpriteComps10092 then
				for iter_170_4, iter_170_5 in pairs(arg_167_1.var_.actorSpriteComps10092:ToTable()) do
					if iter_170_5 then
						if arg_167_1.isInRecall_ then
							iter_170_5.color = arg_167_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_170_5.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_167_1.var_.actorSpriteComps10092 = nil
			end

			local var_170_22 = arg_167_1.actors_["10093"]
			local var_170_23 = 0

			if var_170_23 < arg_167_1.time_ and arg_167_1.time_ <= var_170_23 + arg_170_0 and not isNil(var_170_22) and arg_167_1.var_.actorSpriteComps10093 == nil then
				arg_167_1.var_.actorSpriteComps10093 = var_170_22:GetComponentsInChildren(typeof(Image), true)
			end

			local var_170_24 = 2

			if var_170_23 <= arg_167_1.time_ and arg_167_1.time_ < var_170_23 + var_170_24 and not isNil(var_170_22) then
				local var_170_25 = (arg_167_1.time_ - var_170_23) / var_170_24

				if arg_167_1.var_.actorSpriteComps10093 then
					for iter_170_6, iter_170_7 in pairs(arg_167_1.var_.actorSpriteComps10093:ToTable()) do
						if iter_170_7 then
							if arg_167_1.isInRecall_ then
								local var_170_26 = Mathf.Lerp(iter_170_7.color.r, arg_167_1.hightColor1.r, var_170_25)
								local var_170_27 = Mathf.Lerp(iter_170_7.color.g, arg_167_1.hightColor1.g, var_170_25)
								local var_170_28 = Mathf.Lerp(iter_170_7.color.b, arg_167_1.hightColor1.b, var_170_25)

								iter_170_7.color = Color.New(var_170_26, var_170_27, var_170_28)
							else
								local var_170_29 = Mathf.Lerp(iter_170_7.color.r, 1, var_170_25)

								iter_170_7.color = Color.New(var_170_29, var_170_29, var_170_29)
							end
						end
					end
				end
			end

			if arg_167_1.time_ >= var_170_23 + var_170_24 and arg_167_1.time_ < var_170_23 + var_170_24 + arg_170_0 and not isNil(var_170_22) and arg_167_1.var_.actorSpriteComps10093 then
				for iter_170_8, iter_170_9 in pairs(arg_167_1.var_.actorSpriteComps10093:ToTable()) do
					if iter_170_9 then
						if arg_167_1.isInRecall_ then
							iter_170_9.color = arg_167_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_170_9.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_167_1.var_.actorSpriteComps10093 = nil
			end

			local var_170_30 = 0
			local var_170_31 = 0.3

			if var_170_30 < arg_167_1.time_ and arg_167_1.time_ <= var_170_30 + arg_170_0 then
				arg_167_1.talkMaxDuration = 0
				arg_167_1.dialogCg_.alpha = 1

				arg_167_1.dialog_:SetActive(true)
				SetActive(arg_167_1.leftNameGo_, true)

				local var_170_32 = arg_167_1:FormatText(StoryNameCfg[28].name)

				arg_167_1.leftNameTxt_.text = var_170_32

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_167_1.leftNameTxt_.transform)

				arg_167_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_167_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_167_1:RecordName(arg_167_1.leftNameTxt_.text)
				SetActive(arg_167_1.iconTrs_.gameObject, false)
				arg_167_1.callingController_:SetSelectedState("normal")

				local var_170_33 = arg_167_1:GetWordFromCfg(413072039)
				local var_170_34 = arg_167_1:FormatText(var_170_33.content)

				arg_167_1.text_.text = var_170_34

				LuaForUtil.ClearLinePrefixSymbol(arg_167_1.text_)

				local var_170_35 = 12
				local var_170_36 = utf8.len(var_170_34)
				local var_170_37 = var_170_35 <= 0 and var_170_31 or var_170_31 * (var_170_36 / var_170_35)

				if var_170_37 > 0 and var_170_31 < var_170_37 then
					arg_167_1.talkMaxDuration = var_170_37

					if var_170_37 + var_170_30 > arg_167_1.duration_ then
						arg_167_1.duration_ = var_170_37 + var_170_30
					end
				end

				arg_167_1.text_.text = var_170_34
				arg_167_1.typewritter.percent = 0

				arg_167_1.typewritter:SetDirty()
				arg_167_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_413072", "413072039", "story_v_out_413072.awb") ~= 0 then
					local var_170_38 = manager.audio:GetVoiceLength("story_v_out_413072", "413072039", "story_v_out_413072.awb") / 1000

					if var_170_38 + var_170_30 > arg_167_1.duration_ then
						arg_167_1.duration_ = var_170_38 + var_170_30
					end

					if var_170_33.prefab_name ~= "" and arg_167_1.actors_[var_170_33.prefab_name] ~= nil then
						local var_170_39 = LuaForUtil.PlayVoiceWithCriLipsync(arg_167_1.actors_[var_170_33.prefab_name].transform, "story_v_out_413072", "413072039", "story_v_out_413072.awb")

						arg_167_1:RecordAudio("413072039", var_170_39)
						arg_167_1:RecordAudio("413072039", var_170_39)
					else
						arg_167_1:AudioAction("play", "voice", "story_v_out_413072", "413072039", "story_v_out_413072.awb")
					end

					arg_167_1:RecordHistoryTalkVoice("story_v_out_413072", "413072039", "story_v_out_413072.awb")
				end

				arg_167_1:RecordContent(arg_167_1.text_.text)
			end

			local var_170_40 = math.max(var_170_31, arg_167_1.talkMaxDuration)

			if var_170_30 <= arg_167_1.time_ and arg_167_1.time_ < var_170_30 + var_170_40 then
				arg_167_1.typewritter.percent = (arg_167_1.time_ - var_170_30) / var_170_40

				arg_167_1.typewritter:SetDirty()
			end

			if arg_167_1.time_ >= var_170_30 + var_170_40 and arg_167_1.time_ < var_170_30 + var_170_40 + arg_170_0 then
				arg_167_1.typewritter.percent = 1

				arg_167_1.typewritter:SetDirty()
				arg_167_1:ShowNextGo(true)
			end
		end

		arg_167_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10092",
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

		arg_167_1:InitPlayNodeList()
	end,
	Play413072040 = function(arg_171_0, arg_171_1)
		arg_171_1.time_ = 0
		arg_171_1.frameCnt_ = 0
		arg_171_1.state_ = "playing"
		arg_171_1.curTalkId_ = 413072040
		arg_171_1.duration_ = 7.27

		local var_171_0 = {
			zh = 3.466,
			ja = 7.266
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
				arg_171_0:Play413072041(arg_171_1)
			end
		end

		function arg_171_1.onSingleLineUpdate_(arg_174_0)
			local var_174_0 = arg_171_1.actors_["10092"].transform
			local var_174_1 = 0

			if var_174_1 < arg_171_1.time_ and arg_171_1.time_ <= var_174_1 + arg_174_0 then
				arg_171_1.var_.moveOldPos10092 = var_174_0.localPosition
				var_174_0.localScale = Vector3.New(1, 1, 1)

				arg_171_1:CheckSpriteTmpPos("10092", 4)

				local var_174_2 = var_174_0.childCount

				for iter_174_0 = 0, var_174_2 - 1 do
					local var_174_3 = var_174_0:GetChild(iter_174_0)

					if var_174_3.name == "" or not string.find(var_174_3.name, "split") then
						var_174_3.gameObject:SetActive(true)
					else
						var_174_3.gameObject:SetActive(false)
					end
				end
			end

			local var_174_4 = 0.001

			if var_174_1 <= arg_171_1.time_ and arg_171_1.time_ < var_174_1 + var_174_4 then
				local var_174_5 = (arg_171_1.time_ - var_174_1) / var_174_4
				local var_174_6 = Vector3.New(390, -300, -295)

				var_174_0.localPosition = Vector3.Lerp(arg_171_1.var_.moveOldPos10092, var_174_6, var_174_5)
			end

			if arg_171_1.time_ >= var_174_1 + var_174_4 and arg_171_1.time_ < var_174_1 + var_174_4 + arg_174_0 then
				var_174_0.localPosition = Vector3.New(390, -300, -295)
			end

			local var_174_7 = arg_171_1.actors_["10093"].transform
			local var_174_8 = 0

			if var_174_8 < arg_171_1.time_ and arg_171_1.time_ <= var_174_8 + arg_174_0 then
				arg_171_1.var_.moveOldPos10093 = var_174_7.localPosition
				var_174_7.localScale = Vector3.New(1, 1, 1)

				arg_171_1:CheckSpriteTmpPos("10093", 2)

				local var_174_9 = var_174_7.childCount

				for iter_174_1 = 0, var_174_9 - 1 do
					local var_174_10 = var_174_7:GetChild(iter_174_1)

					if var_174_10.name == "" or not string.find(var_174_10.name, "split") then
						var_174_10.gameObject:SetActive(true)
					else
						var_174_10.gameObject:SetActive(false)
					end
				end
			end

			local var_174_11 = 0.001

			if var_174_8 <= arg_171_1.time_ and arg_171_1.time_ < var_174_8 + var_174_11 then
				local var_174_12 = (arg_171_1.time_ - var_174_8) / var_174_11
				local var_174_13 = Vector3.New(-390, -345, -245)

				var_174_7.localPosition = Vector3.Lerp(arg_171_1.var_.moveOldPos10093, var_174_13, var_174_12)
			end

			if arg_171_1.time_ >= var_174_8 + var_174_11 and arg_171_1.time_ < var_174_8 + var_174_11 + arg_174_0 then
				var_174_7.localPosition = Vector3.New(-390, -345, -245)
			end

			local var_174_14 = arg_171_1.actors_["10092"]
			local var_174_15 = 0

			if var_174_15 < arg_171_1.time_ and arg_171_1.time_ <= var_174_15 + arg_174_0 and not isNil(var_174_14) and arg_171_1.var_.actorSpriteComps10092 == nil then
				arg_171_1.var_.actorSpriteComps10092 = var_174_14:GetComponentsInChildren(typeof(Image), true)
			end

			local var_174_16 = 2

			if var_174_15 <= arg_171_1.time_ and arg_171_1.time_ < var_174_15 + var_174_16 and not isNil(var_174_14) then
				local var_174_17 = (arg_171_1.time_ - var_174_15) / var_174_16

				if arg_171_1.var_.actorSpriteComps10092 then
					for iter_174_2, iter_174_3 in pairs(arg_171_1.var_.actorSpriteComps10092:ToTable()) do
						if iter_174_3 then
							if arg_171_1.isInRecall_ then
								local var_174_18 = Mathf.Lerp(iter_174_3.color.r, arg_171_1.hightColor1.r, var_174_17)
								local var_174_19 = Mathf.Lerp(iter_174_3.color.g, arg_171_1.hightColor1.g, var_174_17)
								local var_174_20 = Mathf.Lerp(iter_174_3.color.b, arg_171_1.hightColor1.b, var_174_17)

								iter_174_3.color = Color.New(var_174_18, var_174_19, var_174_20)
							else
								local var_174_21 = Mathf.Lerp(iter_174_3.color.r, 1, var_174_17)

								iter_174_3.color = Color.New(var_174_21, var_174_21, var_174_21)
							end
						end
					end
				end
			end

			if arg_171_1.time_ >= var_174_15 + var_174_16 and arg_171_1.time_ < var_174_15 + var_174_16 + arg_174_0 and not isNil(var_174_14) and arg_171_1.var_.actorSpriteComps10092 then
				for iter_174_4, iter_174_5 in pairs(arg_171_1.var_.actorSpriteComps10092:ToTable()) do
					if iter_174_5 then
						if arg_171_1.isInRecall_ then
							iter_174_5.color = arg_171_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_174_5.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_171_1.var_.actorSpriteComps10092 = nil
			end

			local var_174_22 = arg_171_1.actors_["10093"]
			local var_174_23 = 0

			if var_174_23 < arg_171_1.time_ and arg_171_1.time_ <= var_174_23 + arg_174_0 and not isNil(var_174_22) and arg_171_1.var_.actorSpriteComps10093 == nil then
				arg_171_1.var_.actorSpriteComps10093 = var_174_22:GetComponentsInChildren(typeof(Image), true)
			end

			local var_174_24 = 2

			if var_174_23 <= arg_171_1.time_ and arg_171_1.time_ < var_174_23 + var_174_24 and not isNil(var_174_22) then
				local var_174_25 = (arg_171_1.time_ - var_174_23) / var_174_24

				if arg_171_1.var_.actorSpriteComps10093 then
					for iter_174_6, iter_174_7 in pairs(arg_171_1.var_.actorSpriteComps10093:ToTable()) do
						if iter_174_7 then
							if arg_171_1.isInRecall_ then
								local var_174_26 = Mathf.Lerp(iter_174_7.color.r, arg_171_1.hightColor2.r, var_174_25)
								local var_174_27 = Mathf.Lerp(iter_174_7.color.g, arg_171_1.hightColor2.g, var_174_25)
								local var_174_28 = Mathf.Lerp(iter_174_7.color.b, arg_171_1.hightColor2.b, var_174_25)

								iter_174_7.color = Color.New(var_174_26, var_174_27, var_174_28)
							else
								local var_174_29 = Mathf.Lerp(iter_174_7.color.r, 0.5, var_174_25)

								iter_174_7.color = Color.New(var_174_29, var_174_29, var_174_29)
							end
						end
					end
				end
			end

			if arg_171_1.time_ >= var_174_23 + var_174_24 and arg_171_1.time_ < var_174_23 + var_174_24 + arg_174_0 and not isNil(var_174_22) and arg_171_1.var_.actorSpriteComps10093 then
				for iter_174_8, iter_174_9 in pairs(arg_171_1.var_.actorSpriteComps10093:ToTable()) do
					if iter_174_9 then
						if arg_171_1.isInRecall_ then
							iter_174_9.color = arg_171_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_174_9.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_171_1.var_.actorSpriteComps10093 = nil
			end

			local var_174_30 = 0
			local var_174_31 = 0.325

			if var_174_30 < arg_171_1.time_ and arg_171_1.time_ <= var_174_30 + arg_174_0 then
				arg_171_1.talkMaxDuration = 0
				arg_171_1.dialogCg_.alpha = 1

				arg_171_1.dialog_:SetActive(true)
				SetActive(arg_171_1.leftNameGo_, true)

				local var_174_32 = arg_171_1:FormatText(StoryNameCfg[996].name)

				arg_171_1.leftNameTxt_.text = var_174_32

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_171_1.leftNameTxt_.transform)

				arg_171_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_171_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_171_1:RecordName(arg_171_1.leftNameTxt_.text)
				SetActive(arg_171_1.iconTrs_.gameObject, false)
				arg_171_1.callingController_:SetSelectedState("normal")

				local var_174_33 = arg_171_1:GetWordFromCfg(413072040)
				local var_174_34 = arg_171_1:FormatText(var_174_33.content)

				arg_171_1.text_.text = var_174_34

				LuaForUtil.ClearLinePrefixSymbol(arg_171_1.text_)

				local var_174_35 = 13
				local var_174_36 = utf8.len(var_174_34)
				local var_174_37 = var_174_35 <= 0 and var_174_31 or var_174_31 * (var_174_36 / var_174_35)

				if var_174_37 > 0 and var_174_31 < var_174_37 then
					arg_171_1.talkMaxDuration = var_174_37

					if var_174_37 + var_174_30 > arg_171_1.duration_ then
						arg_171_1.duration_ = var_174_37 + var_174_30
					end
				end

				arg_171_1.text_.text = var_174_34
				arg_171_1.typewritter.percent = 0

				arg_171_1.typewritter:SetDirty()
				arg_171_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_413072", "413072040", "story_v_out_413072.awb") ~= 0 then
					local var_174_38 = manager.audio:GetVoiceLength("story_v_out_413072", "413072040", "story_v_out_413072.awb") / 1000

					if var_174_38 + var_174_30 > arg_171_1.duration_ then
						arg_171_1.duration_ = var_174_38 + var_174_30
					end

					if var_174_33.prefab_name ~= "" and arg_171_1.actors_[var_174_33.prefab_name] ~= nil then
						local var_174_39 = LuaForUtil.PlayVoiceWithCriLipsync(arg_171_1.actors_[var_174_33.prefab_name].transform, "story_v_out_413072", "413072040", "story_v_out_413072.awb")

						arg_171_1:RecordAudio("413072040", var_174_39)
						arg_171_1:RecordAudio("413072040", var_174_39)
					else
						arg_171_1:AudioAction("play", "voice", "story_v_out_413072", "413072040", "story_v_out_413072.awb")
					end

					arg_171_1:RecordHistoryTalkVoice("story_v_out_413072", "413072040", "story_v_out_413072.awb")
				end

				arg_171_1:RecordContent(arg_171_1.text_.text)
			end

			local var_174_40 = math.max(var_174_31, arg_171_1.talkMaxDuration)

			if var_174_30 <= arg_171_1.time_ and arg_171_1.time_ < var_174_30 + var_174_40 then
				arg_171_1.typewritter.percent = (arg_171_1.time_ - var_174_30) / var_174_40

				arg_171_1.typewritter:SetDirty()
			end

			if arg_171_1.time_ >= var_174_30 + var_174_40 and arg_171_1.time_ < var_174_30 + var_174_40 + arg_174_0 then
				arg_171_1.typewritter.percent = 1

				arg_171_1.typewritter:SetDirty()
				arg_171_1:ShowNextGo(true)
			end
		end

		arg_171_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10092",
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

		arg_171_1:InitPlayNodeList()
	end,
	Play413072041 = function(arg_175_0, arg_175_1)
		arg_175_1.time_ = 0
		arg_175_1.frameCnt_ = 0
		arg_175_1.state_ = "playing"
		arg_175_1.curTalkId_ = 413072041
		arg_175_1.duration_ = 5.4

		local var_175_0 = {
			zh = 3.033,
			ja = 5.4
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
				arg_175_0:Play413072042(arg_175_1)
			end
		end

		function arg_175_1.onSingleLineUpdate_(arg_178_0)
			local var_178_0 = 0
			local var_178_1 = 0.375

			if var_178_0 < arg_175_1.time_ and arg_175_1.time_ <= var_178_0 + arg_178_0 then
				arg_175_1.talkMaxDuration = 0
				arg_175_1.dialogCg_.alpha = 1

				arg_175_1.dialog_:SetActive(true)
				SetActive(arg_175_1.leftNameGo_, true)

				local var_178_2 = arg_175_1:FormatText(StoryNameCfg[996].name)

				arg_175_1.leftNameTxt_.text = var_178_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_175_1.leftNameTxt_.transform)

				arg_175_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_175_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_175_1:RecordName(arg_175_1.leftNameTxt_.text)
				SetActive(arg_175_1.iconTrs_.gameObject, false)
				arg_175_1.callingController_:SetSelectedState("normal")

				local var_178_3 = arg_175_1:GetWordFromCfg(413072041)
				local var_178_4 = arg_175_1:FormatText(var_178_3.content)

				arg_175_1.text_.text = var_178_4

				LuaForUtil.ClearLinePrefixSymbol(arg_175_1.text_)

				local var_178_5 = 15
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

				if manager.audio:GetVoiceLength("story_v_out_413072", "413072041", "story_v_out_413072.awb") ~= 0 then
					local var_178_8 = manager.audio:GetVoiceLength("story_v_out_413072", "413072041", "story_v_out_413072.awb") / 1000

					if var_178_8 + var_178_0 > arg_175_1.duration_ then
						arg_175_1.duration_ = var_178_8 + var_178_0
					end

					if var_178_3.prefab_name ~= "" and arg_175_1.actors_[var_178_3.prefab_name] ~= nil then
						local var_178_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_175_1.actors_[var_178_3.prefab_name].transform, "story_v_out_413072", "413072041", "story_v_out_413072.awb")

						arg_175_1:RecordAudio("413072041", var_178_9)
						arg_175_1:RecordAudio("413072041", var_178_9)
					else
						arg_175_1:AudioAction("play", "voice", "story_v_out_413072", "413072041", "story_v_out_413072.awb")
					end

					arg_175_1:RecordHistoryTalkVoice("story_v_out_413072", "413072041", "story_v_out_413072.awb")
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
	Play413072042 = function(arg_179_0, arg_179_1)
		arg_179_1.time_ = 0
		arg_179_1.frameCnt_ = 0
		arg_179_1.state_ = "playing"
		arg_179_1.curTalkId_ = 413072042
		arg_179_1.duration_ = 6.17

		SetActive(arg_179_1.tipsGo_, false)

		function arg_179_1.onSingleLineFinish_()
			arg_179_1.onSingleLineUpdate_ = nil
			arg_179_1.onSingleLineFinish_ = nil
			arg_179_1.state_ = "waiting"
		end

		function arg_179_1.playNext_(arg_181_0)
			if arg_181_0 == 1 then
				arg_179_0:Play413072043(arg_179_1)
			end
		end

		function arg_179_1.onSingleLineUpdate_(arg_182_0)
			local var_182_0 = arg_179_1.actors_["10092"].transform
			local var_182_1 = 0.3

			if var_182_1 < arg_179_1.time_ and arg_179_1.time_ <= var_182_1 + arg_182_0 then
				arg_179_1.var_.moveOldPos10092 = var_182_0.localPosition
				var_182_0.localScale = Vector3.New(1, 1, 1)

				arg_179_1:CheckSpriteTmpPos("10092", 0)

				local var_182_2 = var_182_0.childCount

				for iter_182_0 = 0, var_182_2 - 1 do
					local var_182_3 = var_182_0:GetChild(iter_182_0)

					if var_182_3.name == "" or not string.find(var_182_3.name, "split") then
						var_182_3.gameObject:SetActive(true)
					else
						var_182_3.gameObject:SetActive(false)
					end
				end
			end

			local var_182_4 = 0.001

			if var_182_1 <= arg_179_1.time_ and arg_179_1.time_ < var_182_1 + var_182_4 then
				local var_182_5 = (arg_179_1.time_ - var_182_1) / var_182_4
				local var_182_6 = Vector3.New(-5000, -315, -320)

				var_182_0.localPosition = Vector3.Lerp(arg_179_1.var_.moveOldPos10092, var_182_6, var_182_5)
			end

			if arg_179_1.time_ >= var_182_1 + var_182_4 and arg_179_1.time_ < var_182_1 + var_182_4 + arg_182_0 then
				var_182_0.localPosition = Vector3.New(-5000, -315, -320)
			end

			local var_182_7 = arg_179_1.actors_["10093"].transform
			local var_182_8 = 0.3

			if var_182_8 < arg_179_1.time_ and arg_179_1.time_ <= var_182_8 + arg_182_0 then
				arg_179_1.var_.moveOldPos10093 = var_182_7.localPosition
				var_182_7.localScale = Vector3.New(1, 1, 1)

				arg_179_1:CheckSpriteTmpPos("10093", 0)

				local var_182_9 = var_182_7.childCount

				for iter_182_1 = 0, var_182_9 - 1 do
					local var_182_10 = var_182_7:GetChild(iter_182_1)

					if var_182_10.name == "" or not string.find(var_182_10.name, "split") then
						var_182_10.gameObject:SetActive(true)
					else
						var_182_10.gameObject:SetActive(false)
					end
				end
			end

			local var_182_11 = 0.001

			if var_182_8 <= arg_179_1.time_ and arg_179_1.time_ < var_182_8 + var_182_11 then
				local var_182_12 = (arg_179_1.time_ - var_182_8) / var_182_11
				local var_182_13 = Vector3.New(-5000, -345, -245)

				var_182_7.localPosition = Vector3.Lerp(arg_179_1.var_.moveOldPos10093, var_182_13, var_182_12)
			end

			if arg_179_1.time_ >= var_182_8 + var_182_11 and arg_179_1.time_ < var_182_8 + var_182_11 + arg_182_0 then
				var_182_7.localPosition = Vector3.New(-5000, -345, -245)
			end

			local var_182_14 = arg_179_1.actors_["10092"]
			local var_182_15 = 0.3

			if var_182_15 < arg_179_1.time_ and arg_179_1.time_ <= var_182_15 + arg_182_0 and not isNil(var_182_14) and arg_179_1.var_.actorSpriteComps10092 == nil then
				arg_179_1.var_.actorSpriteComps10092 = var_182_14:GetComponentsInChildren(typeof(Image), true)
			end

			local var_182_16 = 0.034

			if var_182_15 <= arg_179_1.time_ and arg_179_1.time_ < var_182_15 + var_182_16 and not isNil(var_182_14) then
				local var_182_17 = (arg_179_1.time_ - var_182_15) / var_182_16

				if arg_179_1.var_.actorSpriteComps10092 then
					for iter_182_2, iter_182_3 in pairs(arg_179_1.var_.actorSpriteComps10092:ToTable()) do
						if iter_182_3 then
							if arg_179_1.isInRecall_ then
								local var_182_18 = Mathf.Lerp(iter_182_3.color.r, arg_179_1.hightColor2.r, var_182_17)
								local var_182_19 = Mathf.Lerp(iter_182_3.color.g, arg_179_1.hightColor2.g, var_182_17)
								local var_182_20 = Mathf.Lerp(iter_182_3.color.b, arg_179_1.hightColor2.b, var_182_17)

								iter_182_3.color = Color.New(var_182_18, var_182_19, var_182_20)
							else
								local var_182_21 = Mathf.Lerp(iter_182_3.color.r, 0.5, var_182_17)

								iter_182_3.color = Color.New(var_182_21, var_182_21, var_182_21)
							end
						end
					end
				end
			end

			if arg_179_1.time_ >= var_182_15 + var_182_16 and arg_179_1.time_ < var_182_15 + var_182_16 + arg_182_0 and not isNil(var_182_14) and arg_179_1.var_.actorSpriteComps10092 then
				for iter_182_4, iter_182_5 in pairs(arg_179_1.var_.actorSpriteComps10092:ToTable()) do
					if iter_182_5 then
						if arg_179_1.isInRecall_ then
							iter_182_5.color = arg_179_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_182_5.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_179_1.var_.actorSpriteComps10092 = nil
			end

			local var_182_22 = arg_179_1.actors_["10093"]
			local var_182_23 = 0.3

			if var_182_23 < arg_179_1.time_ and arg_179_1.time_ <= var_182_23 + arg_182_0 and not isNil(var_182_22) and arg_179_1.var_.actorSpriteComps10093 == nil then
				arg_179_1.var_.actorSpriteComps10093 = var_182_22:GetComponentsInChildren(typeof(Image), true)
			end

			local var_182_24 = 0.034

			if var_182_23 <= arg_179_1.time_ and arg_179_1.time_ < var_182_23 + var_182_24 and not isNil(var_182_22) then
				local var_182_25 = (arg_179_1.time_ - var_182_23) / var_182_24

				if arg_179_1.var_.actorSpriteComps10093 then
					for iter_182_6, iter_182_7 in pairs(arg_179_1.var_.actorSpriteComps10093:ToTable()) do
						if iter_182_7 then
							if arg_179_1.isInRecall_ then
								local var_182_26 = Mathf.Lerp(iter_182_7.color.r, arg_179_1.hightColor2.r, var_182_25)
								local var_182_27 = Mathf.Lerp(iter_182_7.color.g, arg_179_1.hightColor2.g, var_182_25)
								local var_182_28 = Mathf.Lerp(iter_182_7.color.b, arg_179_1.hightColor2.b, var_182_25)

								iter_182_7.color = Color.New(var_182_26, var_182_27, var_182_28)
							else
								local var_182_29 = Mathf.Lerp(iter_182_7.color.r, 0.5, var_182_25)

								iter_182_7.color = Color.New(var_182_29, var_182_29, var_182_29)
							end
						end
					end
				end
			end

			if arg_179_1.time_ >= var_182_23 + var_182_24 and arg_179_1.time_ < var_182_23 + var_182_24 + arg_182_0 and not isNil(var_182_22) and arg_179_1.var_.actorSpriteComps10093 then
				for iter_182_8, iter_182_9 in pairs(arg_179_1.var_.actorSpriteComps10093:ToTable()) do
					if iter_182_9 then
						if arg_179_1.isInRecall_ then
							iter_182_9.color = arg_179_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_182_9.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_179_1.var_.actorSpriteComps10093 = nil
			end

			local var_182_30 = 0.3

			if var_182_30 < arg_179_1.time_ and arg_179_1.time_ <= var_182_30 + arg_182_0 then
				arg_179_1.mask_.enabled = true
				arg_179_1.mask_.raycastTarget = false

				arg_179_1:SetGaussion(false)
			end

			local var_182_31 = 1

			if var_182_30 <= arg_179_1.time_ and arg_179_1.time_ < var_182_30 + var_182_31 then
				local var_182_32 = (arg_179_1.time_ - var_182_30) / var_182_31
				local var_182_33 = Color.New(1, 1, 1)

				var_182_33.a = Mathf.Lerp(1, 0, var_182_32)
				arg_179_1.mask_.color = var_182_33
			end

			if arg_179_1.time_ >= var_182_30 + var_182_31 and arg_179_1.time_ < var_182_30 + var_182_31 + arg_182_0 then
				local var_182_34 = Color.New(1, 1, 1)
				local var_182_35 = 0

				arg_179_1.mask_.enabled = false
				var_182_34.a = var_182_35
				arg_179_1.mask_.color = var_182_34
			end

			local var_182_36 = 0

			if var_182_36 < arg_179_1.time_ and arg_179_1.time_ <= var_182_36 + arg_182_0 then
				arg_179_1.allBtn_.enabled = false
			end

			local var_182_37 = 0.833333333333333

			if arg_179_1.time_ >= var_182_36 + var_182_37 and arg_179_1.time_ < var_182_36 + var_182_37 + arg_182_0 then
				arg_179_1.allBtn_.enabled = true
			end

			local var_182_38 = 0.366666666666667
			local var_182_39 = 1

			if var_182_38 < arg_179_1.time_ and arg_179_1.time_ <= var_182_38 + arg_182_0 then
				local var_182_40 = "play"
				local var_182_41 = "effect"

				arg_179_1:AudioAction(var_182_40, var_182_41, "se_story_1211", "se_story_1211_explosionfar", "")
			end

			if arg_179_1.frameCnt_ <= 1 then
				arg_179_1.dialog_:SetActive(false)
			end

			local var_182_42 = 1.16666666666667
			local var_182_43 = 1.775

			if var_182_42 < arg_179_1.time_ and arg_179_1.time_ <= var_182_42 + arg_182_0 then
				arg_179_1.talkMaxDuration = 0

				arg_179_1.dialog_:SetActive(true)

				arg_179_1.dialogCg_.alpha = 0

				local var_182_44 = LeanTween.value(arg_179_1.dialog_, 0, 1, 0.3)

				var_182_44:setOnUpdate(LuaHelper.FloatAction(function(arg_183_0)
					arg_179_1.dialogCg_.alpha = arg_183_0
				end))
				var_182_44:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_179_1.dialog_)
					var_182_44:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_179_1.duration_ = arg_179_1.duration_ + 0.3

				SetActive(arg_179_1.leftNameGo_, false)

				arg_179_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_179_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_179_1:RecordName(arg_179_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_179_1.iconTrs_.gameObject, false)
				arg_179_1.callingController_:SetSelectedState("normal")

				local var_182_45 = arg_179_1:GetWordFromCfg(413072042)
				local var_182_46 = arg_179_1:FormatText(var_182_45.content)

				arg_179_1.text_.text = var_182_46

				LuaForUtil.ClearLinePrefixSymbol(arg_179_1.text_)

				local var_182_47 = 71
				local var_182_48 = utf8.len(var_182_46)
				local var_182_49 = var_182_47 <= 0 and var_182_43 or var_182_43 * (var_182_48 / var_182_47)

				if var_182_49 > 0 and var_182_43 < var_182_49 then
					arg_179_1.talkMaxDuration = var_182_49
					var_182_42 = var_182_42 + 0.3

					if var_182_49 + var_182_42 > arg_179_1.duration_ then
						arg_179_1.duration_ = var_182_49 + var_182_42
					end
				end

				arg_179_1.text_.text = var_182_46
				arg_179_1.typewritter.percent = 0

				arg_179_1.typewritter:SetDirty()
				arg_179_1:ShowNextGo(false)
				arg_179_1:RecordContent(arg_179_1.text_.text)
			end

			local var_182_50 = var_182_42 + 0.3
			local var_182_51 = math.max(var_182_43, arg_179_1.talkMaxDuration)

			if var_182_50 <= arg_179_1.time_ and arg_179_1.time_ < var_182_50 + var_182_51 then
				arg_179_1.typewritter.percent = (arg_179_1.time_ - var_182_50) / var_182_51

				arg_179_1.typewritter:SetDirty()
			end

			if arg_179_1.time_ >= var_182_50 + var_182_51 and arg_179_1.time_ < var_182_50 + var_182_51 + arg_182_0 then
				arg_179_1.typewritter.percent = 1

				arg_179_1.typewritter:SetDirty()
				arg_179_1:ShowNextGo(true)
			end
		end

		arg_179_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10092",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0.3,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			},
			{
				assetPath = "",
				actorName = "10093",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0.3,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_179_1:InitPlayNodeList()
	end,
	Play413072043 = function(arg_185_0, arg_185_1)
		arg_185_1.time_ = 0
		arg_185_1.frameCnt_ = 0
		arg_185_1.state_ = "playing"
		arg_185_1.curTalkId_ = 413072043
		arg_185_1.duration_ = 4.33

		local var_185_0 = {
			zh = 4.333,
			ja = 4.133
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
				arg_185_0:Play413072044(arg_185_1)
			end
		end

		function arg_185_1.onSingleLineUpdate_(arg_188_0)
			local var_188_0 = 0
			local var_188_1 = 0.6

			if var_188_0 < arg_185_1.time_ and arg_185_1.time_ <= var_188_0 + arg_188_0 then
				arg_185_1.talkMaxDuration = 0
				arg_185_1.dialogCg_.alpha = 1

				arg_185_1.dialog_:SetActive(true)
				SetActive(arg_185_1.leftNameGo_, true)

				local var_188_2 = arg_185_1:FormatText(StoryNameCfg[998].name)

				arg_185_1.leftNameTxt_.text = var_188_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_185_1.leftNameTxt_.transform)

				arg_185_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_185_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_185_1:RecordName(arg_185_1.leftNameTxt_.text)
				SetActive(arg_185_1.iconTrs_.gameObject, true)
				arg_185_1.iconController_:SetSelectedState("hero")

				arg_185_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_knightwoman1")

				arg_185_1.callingController_:SetSelectedState("normal")

				arg_185_1.keyicon_.color = Color.New(1, 1, 1)
				arg_185_1.icon_.color = Color.New(1, 1, 1)

				local var_188_3 = arg_185_1:GetWordFromCfg(413072043)
				local var_188_4 = arg_185_1:FormatText(var_188_3.content)

				arg_185_1.text_.text = var_188_4

				LuaForUtil.ClearLinePrefixSymbol(arg_185_1.text_)

				local var_188_5 = 24
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

				if manager.audio:GetVoiceLength("story_v_out_413072", "413072043", "story_v_out_413072.awb") ~= 0 then
					local var_188_8 = manager.audio:GetVoiceLength("story_v_out_413072", "413072043", "story_v_out_413072.awb") / 1000

					if var_188_8 + var_188_0 > arg_185_1.duration_ then
						arg_185_1.duration_ = var_188_8 + var_188_0
					end

					if var_188_3.prefab_name ~= "" and arg_185_1.actors_[var_188_3.prefab_name] ~= nil then
						local var_188_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_185_1.actors_[var_188_3.prefab_name].transform, "story_v_out_413072", "413072043", "story_v_out_413072.awb")

						arg_185_1:RecordAudio("413072043", var_188_9)
						arg_185_1:RecordAudio("413072043", var_188_9)
					else
						arg_185_1:AudioAction("play", "voice", "story_v_out_413072", "413072043", "story_v_out_413072.awb")
					end

					arg_185_1:RecordHistoryTalkVoice("story_v_out_413072", "413072043", "story_v_out_413072.awb")
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
	Play413072044 = function(arg_189_0, arg_189_1)
		arg_189_1.time_ = 0
		arg_189_1.frameCnt_ = 0
		arg_189_1.state_ = "playing"
		arg_189_1.curTalkId_ = 413072044
		arg_189_1.duration_ = 3.63

		local var_189_0 = {
			zh = 3.266,
			ja = 3.633
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
				arg_189_0:Play413072045(arg_189_1)
			end
		end

		function arg_189_1.onSingleLineUpdate_(arg_192_0)
			local var_192_0 = arg_189_1.actors_["10092"].transform
			local var_192_1 = 0

			if var_192_1 < arg_189_1.time_ and arg_189_1.time_ <= var_192_1 + arg_192_0 then
				arg_189_1.var_.moveOldPos10092 = var_192_0.localPosition
				var_192_0.localScale = Vector3.New(1, 1, 1)

				arg_189_1:CheckSpriteTmpPos("10092", 3)

				local var_192_2 = var_192_0.childCount

				for iter_192_0 = 0, var_192_2 - 1 do
					local var_192_3 = var_192_0:GetChild(iter_192_0)

					if var_192_3.name == "split_1_1" or not string.find(var_192_3.name, "split") then
						var_192_3.gameObject:SetActive(true)
					else
						var_192_3.gameObject:SetActive(false)
					end
				end
			end

			local var_192_4 = 0.001

			if var_192_1 <= arg_189_1.time_ and arg_189_1.time_ < var_192_1 + var_192_4 then
				local var_192_5 = (arg_189_1.time_ - var_192_1) / var_192_4
				local var_192_6 = Vector3.New(0, -300, -295)

				var_192_0.localPosition = Vector3.Lerp(arg_189_1.var_.moveOldPos10092, var_192_6, var_192_5)
			end

			if arg_189_1.time_ >= var_192_1 + var_192_4 and arg_189_1.time_ < var_192_1 + var_192_4 + arg_192_0 then
				var_192_0.localPosition = Vector3.New(0, -300, -295)
			end

			local var_192_7 = arg_189_1.actors_["10092"]
			local var_192_8 = 0

			if var_192_8 < arg_189_1.time_ and arg_189_1.time_ <= var_192_8 + arg_192_0 and not isNil(var_192_7) and arg_189_1.var_.actorSpriteComps10092 == nil then
				arg_189_1.var_.actorSpriteComps10092 = var_192_7:GetComponentsInChildren(typeof(Image), true)
			end

			local var_192_9 = 2

			if var_192_8 <= arg_189_1.time_ and arg_189_1.time_ < var_192_8 + var_192_9 and not isNil(var_192_7) then
				local var_192_10 = (arg_189_1.time_ - var_192_8) / var_192_9

				if arg_189_1.var_.actorSpriteComps10092 then
					for iter_192_1, iter_192_2 in pairs(arg_189_1.var_.actorSpriteComps10092:ToTable()) do
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

			if arg_189_1.time_ >= var_192_8 + var_192_9 and arg_189_1.time_ < var_192_8 + var_192_9 + arg_192_0 and not isNil(var_192_7) and arg_189_1.var_.actorSpriteComps10092 then
				for iter_192_3, iter_192_4 in pairs(arg_189_1.var_.actorSpriteComps10092:ToTable()) do
					if iter_192_4 then
						if arg_189_1.isInRecall_ then
							iter_192_4.color = arg_189_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_192_4.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_189_1.var_.actorSpriteComps10092 = nil
			end

			local var_192_15 = 0
			local var_192_16 = 0.425

			if var_192_15 < arg_189_1.time_ and arg_189_1.time_ <= var_192_15 + arg_192_0 then
				arg_189_1.talkMaxDuration = 0
				arg_189_1.dialogCg_.alpha = 1

				arg_189_1.dialog_:SetActive(true)
				SetActive(arg_189_1.leftNameGo_, true)

				local var_192_17 = arg_189_1:FormatText(StoryNameCfg[996].name)

				arg_189_1.leftNameTxt_.text = var_192_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_189_1.leftNameTxt_.transform)

				arg_189_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_189_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_189_1:RecordName(arg_189_1.leftNameTxt_.text)
				SetActive(arg_189_1.iconTrs_.gameObject, false)
				arg_189_1.callingController_:SetSelectedState("normal")

				local var_192_18 = arg_189_1:GetWordFromCfg(413072044)
				local var_192_19 = arg_189_1:FormatText(var_192_18.content)

				arg_189_1.text_.text = var_192_19

				LuaForUtil.ClearLinePrefixSymbol(arg_189_1.text_)

				local var_192_20 = 17
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

				if manager.audio:GetVoiceLength("story_v_out_413072", "413072044", "story_v_out_413072.awb") ~= 0 then
					local var_192_23 = manager.audio:GetVoiceLength("story_v_out_413072", "413072044", "story_v_out_413072.awb") / 1000

					if var_192_23 + var_192_15 > arg_189_1.duration_ then
						arg_189_1.duration_ = var_192_23 + var_192_15
					end

					if var_192_18.prefab_name ~= "" and arg_189_1.actors_[var_192_18.prefab_name] ~= nil then
						local var_192_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_189_1.actors_[var_192_18.prefab_name].transform, "story_v_out_413072", "413072044", "story_v_out_413072.awb")

						arg_189_1:RecordAudio("413072044", var_192_24)
						arg_189_1:RecordAudio("413072044", var_192_24)
					else
						arg_189_1:AudioAction("play", "voice", "story_v_out_413072", "413072044", "story_v_out_413072.awb")
					end

					arg_189_1:RecordHistoryTalkVoice("story_v_out_413072", "413072044", "story_v_out_413072.awb")
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
				actorName = "10092",
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
	Play413072045 = function(arg_193_0, arg_193_1)
		arg_193_1.time_ = 0
		arg_193_1.frameCnt_ = 0
		arg_193_1.state_ = "playing"
		arg_193_1.curTalkId_ = 413072045
		arg_193_1.duration_ = 4.6

		local var_193_0 = {
			zh = 4.533,
			ja = 4.6
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
				arg_193_0:Play413072046(arg_193_1)
			end
		end

		function arg_193_1.onSingleLineUpdate_(arg_196_0)
			local var_196_0 = arg_193_1.actors_["10092"].transform
			local var_196_1 = 0

			if var_196_1 < arg_193_1.time_ and arg_193_1.time_ <= var_196_1 + arg_196_0 then
				arg_193_1.var_.moveOldPos10092 = var_196_0.localPosition
				var_196_0.localScale = Vector3.New(1, 1, 1)

				arg_193_1:CheckSpriteTmpPos("10092", 3)

				local var_196_2 = var_196_0.childCount

				for iter_196_0 = 0, var_196_2 - 1 do
					local var_196_3 = var_196_0:GetChild(iter_196_0)

					if var_196_3.name == "split_1_1" or not string.find(var_196_3.name, "split") then
						var_196_3.gameObject:SetActive(true)
					else
						var_196_3.gameObject:SetActive(false)
					end
				end
			end

			local var_196_4 = 0.001

			if var_196_1 <= arg_193_1.time_ and arg_193_1.time_ < var_196_1 + var_196_4 then
				local var_196_5 = (arg_193_1.time_ - var_196_1) / var_196_4
				local var_196_6 = Vector3.New(0, -300, -295)

				var_196_0.localPosition = Vector3.Lerp(arg_193_1.var_.moveOldPos10092, var_196_6, var_196_5)
			end

			if arg_193_1.time_ >= var_196_1 + var_196_4 and arg_193_1.time_ < var_196_1 + var_196_4 + arg_196_0 then
				var_196_0.localPosition = Vector3.New(0, -300, -295)
			end

			local var_196_7 = arg_193_1.actors_["10092"]
			local var_196_8 = 0

			if var_196_8 < arg_193_1.time_ and arg_193_1.time_ <= var_196_8 + arg_196_0 and not isNil(var_196_7) and arg_193_1.var_.actorSpriteComps10092 == nil then
				arg_193_1.var_.actorSpriteComps10092 = var_196_7:GetComponentsInChildren(typeof(Image), true)
			end

			local var_196_9 = 2

			if var_196_8 <= arg_193_1.time_ and arg_193_1.time_ < var_196_8 + var_196_9 and not isNil(var_196_7) then
				local var_196_10 = (arg_193_1.time_ - var_196_8) / var_196_9

				if arg_193_1.var_.actorSpriteComps10092 then
					for iter_196_1, iter_196_2 in pairs(arg_193_1.var_.actorSpriteComps10092:ToTable()) do
						if iter_196_2 then
							if arg_193_1.isInRecall_ then
								local var_196_11 = Mathf.Lerp(iter_196_2.color.r, arg_193_1.hightColor2.r, var_196_10)
								local var_196_12 = Mathf.Lerp(iter_196_2.color.g, arg_193_1.hightColor2.g, var_196_10)
								local var_196_13 = Mathf.Lerp(iter_196_2.color.b, arg_193_1.hightColor2.b, var_196_10)

								iter_196_2.color = Color.New(var_196_11, var_196_12, var_196_13)
							else
								local var_196_14 = Mathf.Lerp(iter_196_2.color.r, 0.5, var_196_10)

								iter_196_2.color = Color.New(var_196_14, var_196_14, var_196_14)
							end
						end
					end
				end
			end

			if arg_193_1.time_ >= var_196_8 + var_196_9 and arg_193_1.time_ < var_196_8 + var_196_9 + arg_196_0 and not isNil(var_196_7) and arg_193_1.var_.actorSpriteComps10092 then
				for iter_196_3, iter_196_4 in pairs(arg_193_1.var_.actorSpriteComps10092:ToTable()) do
					if iter_196_4 then
						if arg_193_1.isInRecall_ then
							iter_196_4.color = arg_193_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_196_4.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_193_1.var_.actorSpriteComps10092 = nil
			end

			local var_196_15 = 0
			local var_196_16 = 0.55

			if var_196_15 < arg_193_1.time_ and arg_193_1.time_ <= var_196_15 + arg_196_0 then
				arg_193_1.talkMaxDuration = 0
				arg_193_1.dialogCg_.alpha = 1

				arg_193_1.dialog_:SetActive(true)
				SetActive(arg_193_1.leftNameGo_, true)

				local var_196_17 = arg_193_1:FormatText(StoryNameCfg[998].name)

				arg_193_1.leftNameTxt_.text = var_196_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_193_1.leftNameTxt_.transform)

				arg_193_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_193_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_193_1:RecordName(arg_193_1.leftNameTxt_.text)
				SetActive(arg_193_1.iconTrs_.gameObject, true)
				arg_193_1.iconController_:SetSelectedState("hero")

				arg_193_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_knightwoman1")

				arg_193_1.callingController_:SetSelectedState("normal")

				arg_193_1.keyicon_.color = Color.New(1, 1, 1)
				arg_193_1.icon_.color = Color.New(1, 1, 1)

				local var_196_18 = arg_193_1:GetWordFromCfg(413072045)
				local var_196_19 = arg_193_1:FormatText(var_196_18.content)

				arg_193_1.text_.text = var_196_19

				LuaForUtil.ClearLinePrefixSymbol(arg_193_1.text_)

				local var_196_20 = 22
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

				if manager.audio:GetVoiceLength("story_v_out_413072", "413072045", "story_v_out_413072.awb") ~= 0 then
					local var_196_23 = manager.audio:GetVoiceLength("story_v_out_413072", "413072045", "story_v_out_413072.awb") / 1000

					if var_196_23 + var_196_15 > arg_193_1.duration_ then
						arg_193_1.duration_ = var_196_23 + var_196_15
					end

					if var_196_18.prefab_name ~= "" and arg_193_1.actors_[var_196_18.prefab_name] ~= nil then
						local var_196_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_193_1.actors_[var_196_18.prefab_name].transform, "story_v_out_413072", "413072045", "story_v_out_413072.awb")

						arg_193_1:RecordAudio("413072045", var_196_24)
						arg_193_1:RecordAudio("413072045", var_196_24)
					else
						arg_193_1:AudioAction("play", "voice", "story_v_out_413072", "413072045", "story_v_out_413072.awb")
					end

					arg_193_1:RecordHistoryTalkVoice("story_v_out_413072", "413072045", "story_v_out_413072.awb")
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
				actorName = "10092",
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
	Play413072046 = function(arg_197_0, arg_197_1)
		arg_197_1.time_ = 0
		arg_197_1.frameCnt_ = 0
		arg_197_1.state_ = "playing"
		arg_197_1.curTalkId_ = 413072046
		arg_197_1.duration_ = 3.87

		local var_197_0 = {
			zh = 3.5,
			ja = 3.866
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
				arg_197_0:Play413072047(arg_197_1)
			end
		end

		function arg_197_1.onSingleLineUpdate_(arg_200_0)
			local var_200_0 = arg_197_1.actors_["10093"].transform
			local var_200_1 = 0

			if var_200_1 < arg_197_1.time_ and arg_197_1.time_ <= var_200_1 + arg_200_0 then
				arg_197_1.var_.moveOldPos10093 = var_200_0.localPosition
				var_200_0.localScale = Vector3.New(1, 1, 1)

				arg_197_1:CheckSpriteTmpPos("10093", 2)

				local var_200_2 = var_200_0.childCount

				for iter_200_0 = 0, var_200_2 - 1 do
					local var_200_3 = var_200_0:GetChild(iter_200_0)

					if var_200_3.name == "" or not string.find(var_200_3.name, "split") then
						var_200_3.gameObject:SetActive(true)
					else
						var_200_3.gameObject:SetActive(false)
					end
				end
			end

			local var_200_4 = 0.001

			if var_200_1 <= arg_197_1.time_ and arg_197_1.time_ < var_200_1 + var_200_4 then
				local var_200_5 = (arg_197_1.time_ - var_200_1) / var_200_4
				local var_200_6 = Vector3.New(-390, -345, -245)

				var_200_0.localPosition = Vector3.Lerp(arg_197_1.var_.moveOldPos10093, var_200_6, var_200_5)
			end

			if arg_197_1.time_ >= var_200_1 + var_200_4 and arg_197_1.time_ < var_200_1 + var_200_4 + arg_200_0 then
				var_200_0.localPosition = Vector3.New(-390, -345, -245)
			end

			local var_200_7 = arg_197_1.actors_["10093"]
			local var_200_8 = 0

			if var_200_8 < arg_197_1.time_ and arg_197_1.time_ <= var_200_8 + arg_200_0 and not isNil(var_200_7) and arg_197_1.var_.actorSpriteComps10093 == nil then
				arg_197_1.var_.actorSpriteComps10093 = var_200_7:GetComponentsInChildren(typeof(Image), true)
			end

			local var_200_9 = 2

			if var_200_8 <= arg_197_1.time_ and arg_197_1.time_ < var_200_8 + var_200_9 and not isNil(var_200_7) then
				local var_200_10 = (arg_197_1.time_ - var_200_8) / var_200_9

				if arg_197_1.var_.actorSpriteComps10093 then
					for iter_200_1, iter_200_2 in pairs(arg_197_1.var_.actorSpriteComps10093:ToTable()) do
						if iter_200_2 then
							if arg_197_1.isInRecall_ then
								local var_200_11 = Mathf.Lerp(iter_200_2.color.r, arg_197_1.hightColor1.r, var_200_10)
								local var_200_12 = Mathf.Lerp(iter_200_2.color.g, arg_197_1.hightColor1.g, var_200_10)
								local var_200_13 = Mathf.Lerp(iter_200_2.color.b, arg_197_1.hightColor1.b, var_200_10)

								iter_200_2.color = Color.New(var_200_11, var_200_12, var_200_13)
							else
								local var_200_14 = Mathf.Lerp(iter_200_2.color.r, 1, var_200_10)

								iter_200_2.color = Color.New(var_200_14, var_200_14, var_200_14)
							end
						end
					end
				end
			end

			if arg_197_1.time_ >= var_200_8 + var_200_9 and arg_197_1.time_ < var_200_8 + var_200_9 + arg_200_0 and not isNil(var_200_7) and arg_197_1.var_.actorSpriteComps10093 then
				for iter_200_3, iter_200_4 in pairs(arg_197_1.var_.actorSpriteComps10093:ToTable()) do
					if iter_200_4 then
						if arg_197_1.isInRecall_ then
							iter_200_4.color = arg_197_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_200_4.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_197_1.var_.actorSpriteComps10093 = nil
			end

			local var_200_15 = arg_197_1.actors_["10092"].transform
			local var_200_16 = 0

			if var_200_16 < arg_197_1.time_ and arg_197_1.time_ <= var_200_16 + arg_200_0 then
				arg_197_1.var_.moveOldPos10092 = var_200_15.localPosition
				var_200_15.localScale = Vector3.New(1, 1, 1)

				arg_197_1:CheckSpriteTmpPos("10092", 4)

				local var_200_17 = var_200_15.childCount

				for iter_200_5 = 0, var_200_17 - 1 do
					local var_200_18 = var_200_15:GetChild(iter_200_5)

					if var_200_18.name == "split_1_1" or not string.find(var_200_18.name, "split") then
						var_200_18.gameObject:SetActive(true)
					else
						var_200_18.gameObject:SetActive(false)
					end
				end
			end

			local var_200_19 = 0.001

			if var_200_16 <= arg_197_1.time_ and arg_197_1.time_ < var_200_16 + var_200_19 then
				local var_200_20 = (arg_197_1.time_ - var_200_16) / var_200_19
				local var_200_21 = Vector3.New(390, -300, -295)

				var_200_15.localPosition = Vector3.Lerp(arg_197_1.var_.moveOldPos10092, var_200_21, var_200_20)
			end

			if arg_197_1.time_ >= var_200_16 + var_200_19 and arg_197_1.time_ < var_200_16 + var_200_19 + arg_200_0 then
				var_200_15.localPosition = Vector3.New(390, -300, -295)
			end

			local var_200_22 = 0
			local var_200_23 = 0.525

			if var_200_22 < arg_197_1.time_ and arg_197_1.time_ <= var_200_22 + arg_200_0 then
				arg_197_1.talkMaxDuration = 0
				arg_197_1.dialogCg_.alpha = 1

				arg_197_1.dialog_:SetActive(true)
				SetActive(arg_197_1.leftNameGo_, true)

				local var_200_24 = arg_197_1:FormatText(StoryNameCfg[28].name)

				arg_197_1.leftNameTxt_.text = var_200_24

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_197_1.leftNameTxt_.transform)

				arg_197_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_197_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_197_1:RecordName(arg_197_1.leftNameTxt_.text)
				SetActive(arg_197_1.iconTrs_.gameObject, false)
				arg_197_1.callingController_:SetSelectedState("normal")

				local var_200_25 = arg_197_1:GetWordFromCfg(413072046)
				local var_200_26 = arg_197_1:FormatText(var_200_25.content)

				arg_197_1.text_.text = var_200_26

				LuaForUtil.ClearLinePrefixSymbol(arg_197_1.text_)

				local var_200_27 = 21
				local var_200_28 = utf8.len(var_200_26)
				local var_200_29 = var_200_27 <= 0 and var_200_23 or var_200_23 * (var_200_28 / var_200_27)

				if var_200_29 > 0 and var_200_23 < var_200_29 then
					arg_197_1.talkMaxDuration = var_200_29

					if var_200_29 + var_200_22 > arg_197_1.duration_ then
						arg_197_1.duration_ = var_200_29 + var_200_22
					end
				end

				arg_197_1.text_.text = var_200_26
				arg_197_1.typewritter.percent = 0

				arg_197_1.typewritter:SetDirty()
				arg_197_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_413072", "413072046", "story_v_out_413072.awb") ~= 0 then
					local var_200_30 = manager.audio:GetVoiceLength("story_v_out_413072", "413072046", "story_v_out_413072.awb") / 1000

					if var_200_30 + var_200_22 > arg_197_1.duration_ then
						arg_197_1.duration_ = var_200_30 + var_200_22
					end

					if var_200_25.prefab_name ~= "" and arg_197_1.actors_[var_200_25.prefab_name] ~= nil then
						local var_200_31 = LuaForUtil.PlayVoiceWithCriLipsync(arg_197_1.actors_[var_200_25.prefab_name].transform, "story_v_out_413072", "413072046", "story_v_out_413072.awb")

						arg_197_1:RecordAudio("413072046", var_200_31)
						arg_197_1:RecordAudio("413072046", var_200_31)
					else
						arg_197_1:AudioAction("play", "voice", "story_v_out_413072", "413072046", "story_v_out_413072.awb")
					end

					arg_197_1:RecordHistoryTalkVoice("story_v_out_413072", "413072046", "story_v_out_413072.awb")
				end

				arg_197_1:RecordContent(arg_197_1.text_.text)
			end

			local var_200_32 = math.max(var_200_23, arg_197_1.talkMaxDuration)

			if var_200_22 <= arg_197_1.time_ and arg_197_1.time_ < var_200_22 + var_200_32 then
				arg_197_1.typewritter.percent = (arg_197_1.time_ - var_200_22) / var_200_32

				arg_197_1.typewritter:SetDirty()
			end

			if arg_197_1.time_ >= var_200_22 + var_200_32 and arg_197_1.time_ < var_200_22 + var_200_32 + arg_200_0 then
				arg_197_1.typewritter.percent = 1

				arg_197_1.typewritter:SetDirty()
				arg_197_1:ShowNextGo(true)
			end
		end

		arg_197_1.nodeConfigList_ = {
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
				actorName = "10092",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_197_1:InitPlayNodeList()
	end,
	Play413072047 = function(arg_201_0, arg_201_1)
		arg_201_1.time_ = 0
		arg_201_1.frameCnt_ = 0
		arg_201_1.state_ = "playing"
		arg_201_1.curTalkId_ = 413072047
		arg_201_1.duration_ = 6.87

		local var_201_0 = {
			zh = 6.866,
			ja = 5.866
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
				arg_201_0:Play413072048(arg_201_1)
			end
		end

		function arg_201_1.onSingleLineUpdate_(arg_204_0)
			local var_204_0 = arg_201_1.actors_["10092"]
			local var_204_1 = 0

			if var_204_1 < arg_201_1.time_ and arg_201_1.time_ <= var_204_1 + arg_204_0 and not isNil(var_204_0) and arg_201_1.var_.actorSpriteComps10092 == nil then
				arg_201_1.var_.actorSpriteComps10092 = var_204_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_204_2 = 2

			if var_204_1 <= arg_201_1.time_ and arg_201_1.time_ < var_204_1 + var_204_2 and not isNil(var_204_0) then
				local var_204_3 = (arg_201_1.time_ - var_204_1) / var_204_2

				if arg_201_1.var_.actorSpriteComps10092 then
					for iter_204_0, iter_204_1 in pairs(arg_201_1.var_.actorSpriteComps10092:ToTable()) do
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

			if arg_201_1.time_ >= var_204_1 + var_204_2 and arg_201_1.time_ < var_204_1 + var_204_2 + arg_204_0 and not isNil(var_204_0) and arg_201_1.var_.actorSpriteComps10092 then
				for iter_204_2, iter_204_3 in pairs(arg_201_1.var_.actorSpriteComps10092:ToTable()) do
					if iter_204_3 then
						if arg_201_1.isInRecall_ then
							iter_204_3.color = arg_201_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_204_3.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_201_1.var_.actorSpriteComps10092 = nil
			end

			local var_204_8 = arg_201_1.actors_["10093"]
			local var_204_9 = 0

			if var_204_9 < arg_201_1.time_ and arg_201_1.time_ <= var_204_9 + arg_204_0 and not isNil(var_204_8) and arg_201_1.var_.actorSpriteComps10093 == nil then
				arg_201_1.var_.actorSpriteComps10093 = var_204_8:GetComponentsInChildren(typeof(Image), true)
			end

			local var_204_10 = 2

			if var_204_9 <= arg_201_1.time_ and arg_201_1.time_ < var_204_9 + var_204_10 and not isNil(var_204_8) then
				local var_204_11 = (arg_201_1.time_ - var_204_9) / var_204_10

				if arg_201_1.var_.actorSpriteComps10093 then
					for iter_204_4, iter_204_5 in pairs(arg_201_1.var_.actorSpriteComps10093:ToTable()) do
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

			if arg_201_1.time_ >= var_204_9 + var_204_10 and arg_201_1.time_ < var_204_9 + var_204_10 + arg_204_0 and not isNil(var_204_8) and arg_201_1.var_.actorSpriteComps10093 then
				for iter_204_6, iter_204_7 in pairs(arg_201_1.var_.actorSpriteComps10093:ToTable()) do
					if iter_204_7 then
						if arg_201_1.isInRecall_ then
							iter_204_7.color = arg_201_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_204_7.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_201_1.var_.actorSpriteComps10093 = nil
			end

			local var_204_16 = 0
			local var_204_17 = 0.875

			if var_204_16 < arg_201_1.time_ and arg_201_1.time_ <= var_204_16 + arg_204_0 then
				arg_201_1.talkMaxDuration = 0
				arg_201_1.dialogCg_.alpha = 1

				arg_201_1.dialog_:SetActive(true)
				SetActive(arg_201_1.leftNameGo_, true)

				local var_204_18 = arg_201_1:FormatText(StoryNameCfg[996].name)

				arg_201_1.leftNameTxt_.text = var_204_18

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_201_1.leftNameTxt_.transform)

				arg_201_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_201_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_201_1:RecordName(arg_201_1.leftNameTxt_.text)
				SetActive(arg_201_1.iconTrs_.gameObject, false)
				arg_201_1.callingController_:SetSelectedState("normal")

				local var_204_19 = arg_201_1:GetWordFromCfg(413072047)
				local var_204_20 = arg_201_1:FormatText(var_204_19.content)

				arg_201_1.text_.text = var_204_20

				LuaForUtil.ClearLinePrefixSymbol(arg_201_1.text_)

				local var_204_21 = 35
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

				if manager.audio:GetVoiceLength("story_v_out_413072", "413072047", "story_v_out_413072.awb") ~= 0 then
					local var_204_24 = manager.audio:GetVoiceLength("story_v_out_413072", "413072047", "story_v_out_413072.awb") / 1000

					if var_204_24 + var_204_16 > arg_201_1.duration_ then
						arg_201_1.duration_ = var_204_24 + var_204_16
					end

					if var_204_19.prefab_name ~= "" and arg_201_1.actors_[var_204_19.prefab_name] ~= nil then
						local var_204_25 = LuaForUtil.PlayVoiceWithCriLipsync(arg_201_1.actors_[var_204_19.prefab_name].transform, "story_v_out_413072", "413072047", "story_v_out_413072.awb")

						arg_201_1:RecordAudio("413072047", var_204_25)
						arg_201_1:RecordAudio("413072047", var_204_25)
					else
						arg_201_1:AudioAction("play", "voice", "story_v_out_413072", "413072047", "story_v_out_413072.awb")
					end

					arg_201_1:RecordHistoryTalkVoice("story_v_out_413072", "413072047", "story_v_out_413072.awb")
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
	Play413072048 = function(arg_205_0, arg_205_1)
		arg_205_1.time_ = 0
		arg_205_1.frameCnt_ = 0
		arg_205_1.state_ = "playing"
		arg_205_1.curTalkId_ = 413072048
		arg_205_1.duration_ = 9.63

		local var_205_0 = {
			zh = 5.833,
			ja = 9.633
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
				arg_205_0:Play413072049(arg_205_1)
			end
		end

		function arg_205_1.onSingleLineUpdate_(arg_208_0)
			local var_208_0 = 0
			local var_208_1 = 0.7

			if var_208_0 < arg_205_1.time_ and arg_205_1.time_ <= var_208_0 + arg_208_0 then
				arg_205_1.talkMaxDuration = 0
				arg_205_1.dialogCg_.alpha = 1

				arg_205_1.dialog_:SetActive(true)
				SetActive(arg_205_1.leftNameGo_, true)

				local var_208_2 = arg_205_1:FormatText(StoryNameCfg[996].name)

				arg_205_1.leftNameTxt_.text = var_208_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_205_1.leftNameTxt_.transform)

				arg_205_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_205_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_205_1:RecordName(arg_205_1.leftNameTxt_.text)
				SetActive(arg_205_1.iconTrs_.gameObject, false)
				arg_205_1.callingController_:SetSelectedState("normal")

				local var_208_3 = arg_205_1:GetWordFromCfg(413072048)
				local var_208_4 = arg_205_1:FormatText(var_208_3.content)

				arg_205_1.text_.text = var_208_4

				LuaForUtil.ClearLinePrefixSymbol(arg_205_1.text_)

				local var_208_5 = 28
				local var_208_6 = utf8.len(var_208_4)
				local var_208_7 = var_208_5 <= 0 and var_208_1 or var_208_1 * (var_208_6 / var_208_5)

				if var_208_7 > 0 and var_208_1 < var_208_7 then
					arg_205_1.talkMaxDuration = var_208_7

					if var_208_7 + var_208_0 > arg_205_1.duration_ then
						arg_205_1.duration_ = var_208_7 + var_208_0
					end
				end

				arg_205_1.text_.text = var_208_4
				arg_205_1.typewritter.percent = 0

				arg_205_1.typewritter:SetDirty()
				arg_205_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_413072", "413072048", "story_v_out_413072.awb") ~= 0 then
					local var_208_8 = manager.audio:GetVoiceLength("story_v_out_413072", "413072048", "story_v_out_413072.awb") / 1000

					if var_208_8 + var_208_0 > arg_205_1.duration_ then
						arg_205_1.duration_ = var_208_8 + var_208_0
					end

					if var_208_3.prefab_name ~= "" and arg_205_1.actors_[var_208_3.prefab_name] ~= nil then
						local var_208_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_205_1.actors_[var_208_3.prefab_name].transform, "story_v_out_413072", "413072048", "story_v_out_413072.awb")

						arg_205_1:RecordAudio("413072048", var_208_9)
						arg_205_1:RecordAudio("413072048", var_208_9)
					else
						arg_205_1:AudioAction("play", "voice", "story_v_out_413072", "413072048", "story_v_out_413072.awb")
					end

					arg_205_1:RecordHistoryTalkVoice("story_v_out_413072", "413072048", "story_v_out_413072.awb")
				end

				arg_205_1:RecordContent(arg_205_1.text_.text)
			end

			local var_208_10 = math.max(var_208_1, arg_205_1.talkMaxDuration)

			if var_208_0 <= arg_205_1.time_ and arg_205_1.time_ < var_208_0 + var_208_10 then
				arg_205_1.typewritter.percent = (arg_205_1.time_ - var_208_0) / var_208_10

				arg_205_1.typewritter:SetDirty()
			end

			if arg_205_1.time_ >= var_208_0 + var_208_10 and arg_205_1.time_ < var_208_0 + var_208_10 + arg_208_0 then
				arg_205_1.typewritter.percent = 1

				arg_205_1.typewritter:SetDirty()
				arg_205_1:ShowNextGo(true)
			end
		end

		arg_205_1.nodeConfigList_ = {}

		arg_205_1:InitPlayNodeList()
	end,
	Play413072049 = function(arg_209_0, arg_209_1)
		arg_209_1.time_ = 0
		arg_209_1.frameCnt_ = 0
		arg_209_1.state_ = "playing"
		arg_209_1.curTalkId_ = 413072049
		arg_209_1.duration_ = 4.23

		local var_209_0 = {
			zh = 4.233,
			ja = 3.1
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
				arg_209_0:Play413072050(arg_209_1)
			end
		end

		function arg_209_1.onSingleLineUpdate_(arg_212_0)
			local var_212_0 = arg_209_1.actors_["10093"].transform
			local var_212_1 = 0

			if var_212_1 < arg_209_1.time_ and arg_209_1.time_ <= var_212_1 + arg_212_0 then
				arg_209_1.var_.moveOldPos10093 = var_212_0.localPosition
				var_212_0.localScale = Vector3.New(1, 1, 1)

				arg_209_1:CheckSpriteTmpPos("10093", 2)

				local var_212_2 = var_212_0.childCount

				for iter_212_0 = 0, var_212_2 - 1 do
					local var_212_3 = var_212_0:GetChild(iter_212_0)

					if var_212_3.name == "split_6" or not string.find(var_212_3.name, "split") then
						var_212_3.gameObject:SetActive(true)
					else
						var_212_3.gameObject:SetActive(false)
					end
				end
			end

			local var_212_4 = 0.001

			if var_212_1 <= arg_209_1.time_ and arg_209_1.time_ < var_212_1 + var_212_4 then
				local var_212_5 = (arg_209_1.time_ - var_212_1) / var_212_4
				local var_212_6 = Vector3.New(-390, -345, -245)

				var_212_0.localPosition = Vector3.Lerp(arg_209_1.var_.moveOldPos10093, var_212_6, var_212_5)
			end

			if arg_209_1.time_ >= var_212_1 + var_212_4 and arg_209_1.time_ < var_212_1 + var_212_4 + arg_212_0 then
				var_212_0.localPosition = Vector3.New(-390, -345, -245)
			end

			local var_212_7 = arg_209_1.actors_["10092"]
			local var_212_8 = 0

			if var_212_8 < arg_209_1.time_ and arg_209_1.time_ <= var_212_8 + arg_212_0 and not isNil(var_212_7) and arg_209_1.var_.actorSpriteComps10092 == nil then
				arg_209_1.var_.actorSpriteComps10092 = var_212_7:GetComponentsInChildren(typeof(Image), true)
			end

			local var_212_9 = 2

			if var_212_8 <= arg_209_1.time_ and arg_209_1.time_ < var_212_8 + var_212_9 and not isNil(var_212_7) then
				local var_212_10 = (arg_209_1.time_ - var_212_8) / var_212_9

				if arg_209_1.var_.actorSpriteComps10092 then
					for iter_212_1, iter_212_2 in pairs(arg_209_1.var_.actorSpriteComps10092:ToTable()) do
						if iter_212_2 then
							if arg_209_1.isInRecall_ then
								local var_212_11 = Mathf.Lerp(iter_212_2.color.r, arg_209_1.hightColor2.r, var_212_10)
								local var_212_12 = Mathf.Lerp(iter_212_2.color.g, arg_209_1.hightColor2.g, var_212_10)
								local var_212_13 = Mathf.Lerp(iter_212_2.color.b, arg_209_1.hightColor2.b, var_212_10)

								iter_212_2.color = Color.New(var_212_11, var_212_12, var_212_13)
							else
								local var_212_14 = Mathf.Lerp(iter_212_2.color.r, 0.5, var_212_10)

								iter_212_2.color = Color.New(var_212_14, var_212_14, var_212_14)
							end
						end
					end
				end
			end

			if arg_209_1.time_ >= var_212_8 + var_212_9 and arg_209_1.time_ < var_212_8 + var_212_9 + arg_212_0 and not isNil(var_212_7) and arg_209_1.var_.actorSpriteComps10092 then
				for iter_212_3, iter_212_4 in pairs(arg_209_1.var_.actorSpriteComps10092:ToTable()) do
					if iter_212_4 then
						if arg_209_1.isInRecall_ then
							iter_212_4.color = arg_209_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_212_4.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_209_1.var_.actorSpriteComps10092 = nil
			end

			local var_212_15 = arg_209_1.actors_["10093"]
			local var_212_16 = 0

			if var_212_16 < arg_209_1.time_ and arg_209_1.time_ <= var_212_16 + arg_212_0 and not isNil(var_212_15) and arg_209_1.var_.actorSpriteComps10093 == nil then
				arg_209_1.var_.actorSpriteComps10093 = var_212_15:GetComponentsInChildren(typeof(Image), true)
			end

			local var_212_17 = 2

			if var_212_16 <= arg_209_1.time_ and arg_209_1.time_ < var_212_16 + var_212_17 and not isNil(var_212_15) then
				local var_212_18 = (arg_209_1.time_ - var_212_16) / var_212_17

				if arg_209_1.var_.actorSpriteComps10093 then
					for iter_212_5, iter_212_6 in pairs(arg_209_1.var_.actorSpriteComps10093:ToTable()) do
						if iter_212_6 then
							if arg_209_1.isInRecall_ then
								local var_212_19 = Mathf.Lerp(iter_212_6.color.r, arg_209_1.hightColor1.r, var_212_18)
								local var_212_20 = Mathf.Lerp(iter_212_6.color.g, arg_209_1.hightColor1.g, var_212_18)
								local var_212_21 = Mathf.Lerp(iter_212_6.color.b, arg_209_1.hightColor1.b, var_212_18)

								iter_212_6.color = Color.New(var_212_19, var_212_20, var_212_21)
							else
								local var_212_22 = Mathf.Lerp(iter_212_6.color.r, 1, var_212_18)

								iter_212_6.color = Color.New(var_212_22, var_212_22, var_212_22)
							end
						end
					end
				end
			end

			if arg_209_1.time_ >= var_212_16 + var_212_17 and arg_209_1.time_ < var_212_16 + var_212_17 + arg_212_0 and not isNil(var_212_15) and arg_209_1.var_.actorSpriteComps10093 then
				for iter_212_7, iter_212_8 in pairs(arg_209_1.var_.actorSpriteComps10093:ToTable()) do
					if iter_212_8 then
						if arg_209_1.isInRecall_ then
							iter_212_8.color = arg_209_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_212_8.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_209_1.var_.actorSpriteComps10093 = nil
			end

			local var_212_23 = 0
			local var_212_24 = 0.4

			if var_212_23 < arg_209_1.time_ and arg_209_1.time_ <= var_212_23 + arg_212_0 then
				arg_209_1.talkMaxDuration = 0
				arg_209_1.dialogCg_.alpha = 1

				arg_209_1.dialog_:SetActive(true)
				SetActive(arg_209_1.leftNameGo_, true)

				local var_212_25 = arg_209_1:FormatText(StoryNameCfg[28].name)

				arg_209_1.leftNameTxt_.text = var_212_25

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_209_1.leftNameTxt_.transform)

				arg_209_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_209_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_209_1:RecordName(arg_209_1.leftNameTxt_.text)
				SetActive(arg_209_1.iconTrs_.gameObject, false)
				arg_209_1.callingController_:SetSelectedState("normal")

				local var_212_26 = arg_209_1:GetWordFromCfg(413072049)
				local var_212_27 = arg_209_1:FormatText(var_212_26.content)

				arg_209_1.text_.text = var_212_27

				LuaForUtil.ClearLinePrefixSymbol(arg_209_1.text_)

				local var_212_28 = 16
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

				if manager.audio:GetVoiceLength("story_v_out_413072", "413072049", "story_v_out_413072.awb") ~= 0 then
					local var_212_31 = manager.audio:GetVoiceLength("story_v_out_413072", "413072049", "story_v_out_413072.awb") / 1000

					if var_212_31 + var_212_23 > arg_209_1.duration_ then
						arg_209_1.duration_ = var_212_31 + var_212_23
					end

					if var_212_26.prefab_name ~= "" and arg_209_1.actors_[var_212_26.prefab_name] ~= nil then
						local var_212_32 = LuaForUtil.PlayVoiceWithCriLipsync(arg_209_1.actors_[var_212_26.prefab_name].transform, "story_v_out_413072", "413072049", "story_v_out_413072.awb")

						arg_209_1:RecordAudio("413072049", var_212_32)
						arg_209_1:RecordAudio("413072049", var_212_32)
					else
						arg_209_1:AudioAction("play", "voice", "story_v_out_413072", "413072049", "story_v_out_413072.awb")
					end

					arg_209_1:RecordHistoryTalkVoice("story_v_out_413072", "413072049", "story_v_out_413072.awb")
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
				actorName = "10093",
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
	Play413072050 = function(arg_213_0, arg_213_1)
		arg_213_1.time_ = 0
		arg_213_1.frameCnt_ = 0
		arg_213_1.state_ = "playing"
		arg_213_1.curTalkId_ = 413072050
		arg_213_1.duration_ = 6.87

		local var_213_0 = {
			zh = 5.166,
			ja = 6.866
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
				arg_213_0:Play413072051(arg_213_1)
			end
		end

		function arg_213_1.onSingleLineUpdate_(arg_216_0)
			local var_216_0 = arg_213_1.actors_["10092"]
			local var_216_1 = 0

			if var_216_1 < arg_213_1.time_ and arg_213_1.time_ <= var_216_1 + arg_216_0 and not isNil(var_216_0) and arg_213_1.var_.actorSpriteComps10092 == nil then
				arg_213_1.var_.actorSpriteComps10092 = var_216_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_216_2 = 2

			if var_216_1 <= arg_213_1.time_ and arg_213_1.time_ < var_216_1 + var_216_2 and not isNil(var_216_0) then
				local var_216_3 = (arg_213_1.time_ - var_216_1) / var_216_2

				if arg_213_1.var_.actorSpriteComps10092 then
					for iter_216_0, iter_216_1 in pairs(arg_213_1.var_.actorSpriteComps10092:ToTable()) do
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

			if arg_213_1.time_ >= var_216_1 + var_216_2 and arg_213_1.time_ < var_216_1 + var_216_2 + arg_216_0 and not isNil(var_216_0) and arg_213_1.var_.actorSpriteComps10092 then
				for iter_216_2, iter_216_3 in pairs(arg_213_1.var_.actorSpriteComps10092:ToTable()) do
					if iter_216_3 then
						if arg_213_1.isInRecall_ then
							iter_216_3.color = arg_213_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_216_3.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_213_1.var_.actorSpriteComps10092 = nil
			end

			local var_216_8 = arg_213_1.actors_["10093"]
			local var_216_9 = 0

			if var_216_9 < arg_213_1.time_ and arg_213_1.time_ <= var_216_9 + arg_216_0 and not isNil(var_216_8) and arg_213_1.var_.actorSpriteComps10093 == nil then
				arg_213_1.var_.actorSpriteComps10093 = var_216_8:GetComponentsInChildren(typeof(Image), true)
			end

			local var_216_10 = 2

			if var_216_9 <= arg_213_1.time_ and arg_213_1.time_ < var_216_9 + var_216_10 and not isNil(var_216_8) then
				local var_216_11 = (arg_213_1.time_ - var_216_9) / var_216_10

				if arg_213_1.var_.actorSpriteComps10093 then
					for iter_216_4, iter_216_5 in pairs(arg_213_1.var_.actorSpriteComps10093:ToTable()) do
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

			if arg_213_1.time_ >= var_216_9 + var_216_10 and arg_213_1.time_ < var_216_9 + var_216_10 + arg_216_0 and not isNil(var_216_8) and arg_213_1.var_.actorSpriteComps10093 then
				for iter_216_6, iter_216_7 in pairs(arg_213_1.var_.actorSpriteComps10093:ToTable()) do
					if iter_216_7 then
						if arg_213_1.isInRecall_ then
							iter_216_7.color = arg_213_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_216_7.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_213_1.var_.actorSpriteComps10093 = nil
			end

			local var_216_16 = arg_213_1.actors_["10092"].transform
			local var_216_17 = 0

			if var_216_17 < arg_213_1.time_ and arg_213_1.time_ <= var_216_17 + arg_216_0 then
				arg_213_1.var_.moveOldPos10092 = var_216_16.localPosition
				var_216_16.localScale = Vector3.New(1, 1, 1)

				arg_213_1:CheckSpriteTmpPos("10092", 4)

				local var_216_18 = var_216_16.childCount

				for iter_216_8 = 0, var_216_18 - 1 do
					local var_216_19 = var_216_16:GetChild(iter_216_8)

					if var_216_19.name == "split_2" or not string.find(var_216_19.name, "split") then
						var_216_19.gameObject:SetActive(true)
					else
						var_216_19.gameObject:SetActive(false)
					end
				end
			end

			local var_216_20 = 0.001

			if var_216_17 <= arg_213_1.time_ and arg_213_1.time_ < var_216_17 + var_216_20 then
				local var_216_21 = (arg_213_1.time_ - var_216_17) / var_216_20
				local var_216_22 = Vector3.New(390, -300, -295)

				var_216_16.localPosition = Vector3.Lerp(arg_213_1.var_.moveOldPos10092, var_216_22, var_216_21)
			end

			if arg_213_1.time_ >= var_216_17 + var_216_20 and arg_213_1.time_ < var_216_17 + var_216_20 + arg_216_0 then
				var_216_16.localPosition = Vector3.New(390, -300, -295)
			end

			local var_216_23 = 0
			local var_216_24 = 0.675

			if var_216_23 < arg_213_1.time_ and arg_213_1.time_ <= var_216_23 + arg_216_0 then
				arg_213_1.talkMaxDuration = 0
				arg_213_1.dialogCg_.alpha = 1

				arg_213_1.dialog_:SetActive(true)
				SetActive(arg_213_1.leftNameGo_, true)

				local var_216_25 = arg_213_1:FormatText(StoryNameCfg[996].name)

				arg_213_1.leftNameTxt_.text = var_216_25

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_213_1.leftNameTxt_.transform)

				arg_213_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_213_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_213_1:RecordName(arg_213_1.leftNameTxt_.text)
				SetActive(arg_213_1.iconTrs_.gameObject, false)
				arg_213_1.callingController_:SetSelectedState("normal")

				local var_216_26 = arg_213_1:GetWordFromCfg(413072050)
				local var_216_27 = arg_213_1:FormatText(var_216_26.content)

				arg_213_1.text_.text = var_216_27

				LuaForUtil.ClearLinePrefixSymbol(arg_213_1.text_)

				local var_216_28 = 27
				local var_216_29 = utf8.len(var_216_27)
				local var_216_30 = var_216_28 <= 0 and var_216_24 or var_216_24 * (var_216_29 / var_216_28)

				if var_216_30 > 0 and var_216_24 < var_216_30 then
					arg_213_1.talkMaxDuration = var_216_30

					if var_216_30 + var_216_23 > arg_213_1.duration_ then
						arg_213_1.duration_ = var_216_30 + var_216_23
					end
				end

				arg_213_1.text_.text = var_216_27
				arg_213_1.typewritter.percent = 0

				arg_213_1.typewritter:SetDirty()
				arg_213_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_413072", "413072050", "story_v_out_413072.awb") ~= 0 then
					local var_216_31 = manager.audio:GetVoiceLength("story_v_out_413072", "413072050", "story_v_out_413072.awb") / 1000

					if var_216_31 + var_216_23 > arg_213_1.duration_ then
						arg_213_1.duration_ = var_216_31 + var_216_23
					end

					if var_216_26.prefab_name ~= "" and arg_213_1.actors_[var_216_26.prefab_name] ~= nil then
						local var_216_32 = LuaForUtil.PlayVoiceWithCriLipsync(arg_213_1.actors_[var_216_26.prefab_name].transform, "story_v_out_413072", "413072050", "story_v_out_413072.awb")

						arg_213_1:RecordAudio("413072050", var_216_32)
						arg_213_1:RecordAudio("413072050", var_216_32)
					else
						arg_213_1:AudioAction("play", "voice", "story_v_out_413072", "413072050", "story_v_out_413072.awb")
					end

					arg_213_1:RecordHistoryTalkVoice("story_v_out_413072", "413072050", "story_v_out_413072.awb")
				end

				arg_213_1:RecordContent(arg_213_1.text_.text)
			end

			local var_216_33 = math.max(var_216_24, arg_213_1.talkMaxDuration)

			if var_216_23 <= arg_213_1.time_ and arg_213_1.time_ < var_216_23 + var_216_33 then
				arg_213_1.typewritter.percent = (arg_213_1.time_ - var_216_23) / var_216_33

				arg_213_1.typewritter:SetDirty()
			end

			if arg_213_1.time_ >= var_216_23 + var_216_33 and arg_213_1.time_ < var_216_23 + var_216_33 + arg_216_0 then
				arg_213_1.typewritter.percent = 1

				arg_213_1.typewritter:SetDirty()
				arg_213_1:ShowNextGo(true)
			end
		end

		arg_213_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10092",
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
	Play413072051 = function(arg_217_0, arg_217_1)
		arg_217_1.time_ = 0
		arg_217_1.frameCnt_ = 0
		arg_217_1.state_ = "playing"
		arg_217_1.curTalkId_ = 413072051
		arg_217_1.duration_ = 5.13

		local var_217_0 = {
			zh = 3.733,
			ja = 5.133
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
				arg_217_0:Play413072052(arg_217_1)
			end
		end

		function arg_217_1.onSingleLineUpdate_(arg_220_0)
			local var_220_0 = 0
			local var_220_1 = 0.525

			if var_220_0 < arg_217_1.time_ and arg_217_1.time_ <= var_220_0 + arg_220_0 then
				arg_217_1.talkMaxDuration = 0
				arg_217_1.dialogCg_.alpha = 1

				arg_217_1.dialog_:SetActive(true)
				SetActive(arg_217_1.leftNameGo_, true)

				local var_220_2 = arg_217_1:FormatText(StoryNameCfg[996].name)

				arg_217_1.leftNameTxt_.text = var_220_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_217_1.leftNameTxt_.transform)

				arg_217_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_217_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_217_1:RecordName(arg_217_1.leftNameTxt_.text)
				SetActive(arg_217_1.iconTrs_.gameObject, false)
				arg_217_1.callingController_:SetSelectedState("normal")

				local var_220_3 = arg_217_1:GetWordFromCfg(413072051)
				local var_220_4 = arg_217_1:FormatText(var_220_3.content)

				arg_217_1.text_.text = var_220_4

				LuaForUtil.ClearLinePrefixSymbol(arg_217_1.text_)

				local var_220_5 = 21
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

				if manager.audio:GetVoiceLength("story_v_out_413072", "413072051", "story_v_out_413072.awb") ~= 0 then
					local var_220_8 = manager.audio:GetVoiceLength("story_v_out_413072", "413072051", "story_v_out_413072.awb") / 1000

					if var_220_8 + var_220_0 > arg_217_1.duration_ then
						arg_217_1.duration_ = var_220_8 + var_220_0
					end

					if var_220_3.prefab_name ~= "" and arg_217_1.actors_[var_220_3.prefab_name] ~= nil then
						local var_220_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_217_1.actors_[var_220_3.prefab_name].transform, "story_v_out_413072", "413072051", "story_v_out_413072.awb")

						arg_217_1:RecordAudio("413072051", var_220_9)
						arg_217_1:RecordAudio("413072051", var_220_9)
					else
						arg_217_1:AudioAction("play", "voice", "story_v_out_413072", "413072051", "story_v_out_413072.awb")
					end

					arg_217_1:RecordHistoryTalkVoice("story_v_out_413072", "413072051", "story_v_out_413072.awb")
				end

				arg_217_1:RecordContent(arg_217_1.text_.text)
			end

			local var_220_10 = math.max(var_220_1, arg_217_1.talkMaxDuration)

			if var_220_0 <= arg_217_1.time_ and arg_217_1.time_ < var_220_0 + var_220_10 then
				arg_217_1.typewritter.percent = (arg_217_1.time_ - var_220_0) / var_220_10

				arg_217_1.typewritter:SetDirty()
			end

			if arg_217_1.time_ >= var_220_0 + var_220_10 and arg_217_1.time_ < var_220_0 + var_220_10 + arg_220_0 then
				arg_217_1.typewritter.percent = 1

				arg_217_1.typewritter:SetDirty()
				arg_217_1:ShowNextGo(true)
			end
		end

		arg_217_1.nodeConfigList_ = {}

		arg_217_1:InitPlayNodeList()
	end,
	Play413072052 = function(arg_221_0, arg_221_1)
		arg_221_1.time_ = 0
		arg_221_1.frameCnt_ = 0
		arg_221_1.state_ = "playing"
		arg_221_1.curTalkId_ = 413072052
		arg_221_1.duration_ = 4.33

		local var_221_0 = {
			zh = 4.333,
			ja = 2.5
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
				arg_221_0:Play413072053(arg_221_1)
			end
		end

		function arg_221_1.onSingleLineUpdate_(arg_224_0)
			local var_224_0 = arg_221_1.actors_["10093"].transform
			local var_224_1 = 0

			if var_224_1 < arg_221_1.time_ and arg_221_1.time_ <= var_224_1 + arg_224_0 then
				arg_221_1.var_.moveOldPos10093 = var_224_0.localPosition
				var_224_0.localScale = Vector3.New(1, 1, 1)

				arg_221_1:CheckSpriteTmpPos("10093", 2)

				local var_224_2 = var_224_0.childCount

				for iter_224_0 = 0, var_224_2 - 1 do
					local var_224_3 = var_224_0:GetChild(iter_224_0)

					if var_224_3.name == "split_6" or not string.find(var_224_3.name, "split") then
						var_224_3.gameObject:SetActive(true)
					else
						var_224_3.gameObject:SetActive(false)
					end
				end
			end

			local var_224_4 = 0.001

			if var_224_1 <= arg_221_1.time_ and arg_221_1.time_ < var_224_1 + var_224_4 then
				local var_224_5 = (arg_221_1.time_ - var_224_1) / var_224_4
				local var_224_6 = Vector3.New(-390, -345, -245)

				var_224_0.localPosition = Vector3.Lerp(arg_221_1.var_.moveOldPos10093, var_224_6, var_224_5)
			end

			if arg_221_1.time_ >= var_224_1 + var_224_4 and arg_221_1.time_ < var_224_1 + var_224_4 + arg_224_0 then
				var_224_0.localPosition = Vector3.New(-390, -345, -245)
			end

			local var_224_7 = arg_221_1.actors_["10092"]
			local var_224_8 = 0

			if var_224_8 < arg_221_1.time_ and arg_221_1.time_ <= var_224_8 + arg_224_0 and not isNil(var_224_7) and arg_221_1.var_.actorSpriteComps10092 == nil then
				arg_221_1.var_.actorSpriteComps10092 = var_224_7:GetComponentsInChildren(typeof(Image), true)
			end

			local var_224_9 = 2

			if var_224_8 <= arg_221_1.time_ and arg_221_1.time_ < var_224_8 + var_224_9 and not isNil(var_224_7) then
				local var_224_10 = (arg_221_1.time_ - var_224_8) / var_224_9

				if arg_221_1.var_.actorSpriteComps10092 then
					for iter_224_1, iter_224_2 in pairs(arg_221_1.var_.actorSpriteComps10092:ToTable()) do
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

			if arg_221_1.time_ >= var_224_8 + var_224_9 and arg_221_1.time_ < var_224_8 + var_224_9 + arg_224_0 and not isNil(var_224_7) and arg_221_1.var_.actorSpriteComps10092 then
				for iter_224_3, iter_224_4 in pairs(arg_221_1.var_.actorSpriteComps10092:ToTable()) do
					if iter_224_4 then
						if arg_221_1.isInRecall_ then
							iter_224_4.color = arg_221_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_224_4.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_221_1.var_.actorSpriteComps10092 = nil
			end

			local var_224_15 = arg_221_1.actors_["10093"]
			local var_224_16 = 0

			if var_224_16 < arg_221_1.time_ and arg_221_1.time_ <= var_224_16 + arg_224_0 and not isNil(var_224_15) and arg_221_1.var_.actorSpriteComps10093 == nil then
				arg_221_1.var_.actorSpriteComps10093 = var_224_15:GetComponentsInChildren(typeof(Image), true)
			end

			local var_224_17 = 2

			if var_224_16 <= arg_221_1.time_ and arg_221_1.time_ < var_224_16 + var_224_17 and not isNil(var_224_15) then
				local var_224_18 = (arg_221_1.time_ - var_224_16) / var_224_17

				if arg_221_1.var_.actorSpriteComps10093 then
					for iter_224_5, iter_224_6 in pairs(arg_221_1.var_.actorSpriteComps10093:ToTable()) do
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

			if arg_221_1.time_ >= var_224_16 + var_224_17 and arg_221_1.time_ < var_224_16 + var_224_17 + arg_224_0 and not isNil(var_224_15) and arg_221_1.var_.actorSpriteComps10093 then
				for iter_224_7, iter_224_8 in pairs(arg_221_1.var_.actorSpriteComps10093:ToTable()) do
					if iter_224_8 then
						if arg_221_1.isInRecall_ then
							iter_224_8.color = arg_221_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_224_8.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_221_1.var_.actorSpriteComps10093 = nil
			end

			local var_224_23 = 0
			local var_224_24 = 0.45

			if var_224_23 < arg_221_1.time_ and arg_221_1.time_ <= var_224_23 + arg_224_0 then
				arg_221_1.talkMaxDuration = 0
				arg_221_1.dialogCg_.alpha = 1

				arg_221_1.dialog_:SetActive(true)
				SetActive(arg_221_1.leftNameGo_, true)

				local var_224_25 = arg_221_1:FormatText(StoryNameCfg[28].name)

				arg_221_1.leftNameTxt_.text = var_224_25

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_221_1.leftNameTxt_.transform)

				arg_221_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_221_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_221_1:RecordName(arg_221_1.leftNameTxt_.text)
				SetActive(arg_221_1.iconTrs_.gameObject, false)
				arg_221_1.callingController_:SetSelectedState("normal")

				local var_224_26 = arg_221_1:GetWordFromCfg(413072052)
				local var_224_27 = arg_221_1:FormatText(var_224_26.content)

				arg_221_1.text_.text = var_224_27

				LuaForUtil.ClearLinePrefixSymbol(arg_221_1.text_)

				local var_224_28 = 18
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

				if manager.audio:GetVoiceLength("story_v_out_413072", "413072052", "story_v_out_413072.awb") ~= 0 then
					local var_224_31 = manager.audio:GetVoiceLength("story_v_out_413072", "413072052", "story_v_out_413072.awb") / 1000

					if var_224_31 + var_224_23 > arg_221_1.duration_ then
						arg_221_1.duration_ = var_224_31 + var_224_23
					end

					if var_224_26.prefab_name ~= "" and arg_221_1.actors_[var_224_26.prefab_name] ~= nil then
						local var_224_32 = LuaForUtil.PlayVoiceWithCriLipsync(arg_221_1.actors_[var_224_26.prefab_name].transform, "story_v_out_413072", "413072052", "story_v_out_413072.awb")

						arg_221_1:RecordAudio("413072052", var_224_32)
						arg_221_1:RecordAudio("413072052", var_224_32)
					else
						arg_221_1:AudioAction("play", "voice", "story_v_out_413072", "413072052", "story_v_out_413072.awb")
					end

					arg_221_1:RecordHistoryTalkVoice("story_v_out_413072", "413072052", "story_v_out_413072.awb")
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
				actorName = "10093",
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
	Play413072053 = function(arg_225_0, arg_225_1)
		arg_225_1.time_ = 0
		arg_225_1.frameCnt_ = 0
		arg_225_1.state_ = "playing"
		arg_225_1.curTalkId_ = 413072053
		arg_225_1.duration_ = 7.57

		local var_225_0 = {
			zh = 5.9,
			ja = 7.566
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
				arg_225_0:Play413072054(arg_225_1)
			end
		end

		function arg_225_1.onSingleLineUpdate_(arg_228_0)
			local var_228_0 = arg_225_1.actors_["10092"].transform
			local var_228_1 = 0

			if var_228_1 < arg_225_1.time_ and arg_225_1.time_ <= var_228_1 + arg_228_0 then
				arg_225_1.var_.moveOldPos10092 = var_228_0.localPosition
				var_228_0.localScale = Vector3.New(1, 1, 1)

				arg_225_1:CheckSpriteTmpPos("10092", 7)

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
				local var_228_6 = Vector3.New(0, -2000, 0)

				var_228_0.localPosition = Vector3.Lerp(arg_225_1.var_.moveOldPos10092, var_228_6, var_228_5)
			end

			if arg_225_1.time_ >= var_228_1 + var_228_4 and arg_225_1.time_ < var_228_1 + var_228_4 + arg_228_0 then
				var_228_0.localPosition = Vector3.New(0, -2000, 0)
			end

			local var_228_7 = arg_225_1.actors_["10093"].transform
			local var_228_8 = 0

			if var_228_8 < arg_225_1.time_ and arg_225_1.time_ <= var_228_8 + arg_228_0 then
				arg_225_1.var_.moveOldPos10093 = var_228_7.localPosition
				var_228_7.localScale = Vector3.New(1, 1, 1)

				arg_225_1:CheckSpriteTmpPos("10093", 0)

				local var_228_9 = var_228_7.childCount

				for iter_228_1 = 0, var_228_9 - 1 do
					local var_228_10 = var_228_7:GetChild(iter_228_1)

					if var_228_10.name == "" or not string.find(var_228_10.name, "split") then
						var_228_10.gameObject:SetActive(true)
					else
						var_228_10.gameObject:SetActive(false)
					end
				end
			end

			local var_228_11 = 0.001

			if var_228_8 <= arg_225_1.time_ and arg_225_1.time_ < var_228_8 + var_228_11 then
				local var_228_12 = (arg_225_1.time_ - var_228_8) / var_228_11
				local var_228_13 = Vector3.New(-5000, -345, -245)

				var_228_7.localPosition = Vector3.Lerp(arg_225_1.var_.moveOldPos10093, var_228_13, var_228_12)
			end

			if arg_225_1.time_ >= var_228_8 + var_228_11 and arg_225_1.time_ < var_228_8 + var_228_11 + arg_228_0 then
				var_228_7.localPosition = Vector3.New(-5000, -345, -245)
			end

			local var_228_14 = "10094"

			if arg_225_1.actors_[var_228_14] == nil then
				local var_228_15 = Asset.Load("Widget/System/Story/StoryExpression/" .. "10094")

				if not isNil(var_228_15) then
					local var_228_16 = Object.Instantiate(var_228_15, arg_225_1.canvasGo_.transform)

					var_228_16.transform:SetSiblingIndex(1)

					var_228_16.name = var_228_14
					var_228_16.transform.localPosition = Vector3.New(0, 100000, 0)
					arg_225_1.actors_[var_228_14] = var_228_16

					local var_228_17 = var_228_16:GetComponentsInChildren(typeof(Image), true):ToTable()

					if arg_225_1.isInRecall_ then
						for iter_228_2, iter_228_3 in ipairs(var_228_17) do
							iter_228_3.color = arg_225_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						end
					end
				end
			end

			local var_228_18 = arg_225_1.actors_["10094"].transform
			local var_228_19 = 0

			if var_228_19 < arg_225_1.time_ and arg_225_1.time_ <= var_228_19 + arg_228_0 then
				arg_225_1.var_.moveOldPos10094 = var_228_18.localPosition
				var_228_18.localScale = Vector3.New(1, 1, 1)

				arg_225_1:CheckSpriteTmpPos("10094", 3)

				local var_228_20 = var_228_18.childCount

				for iter_228_4 = 0, var_228_20 - 1 do
					local var_228_21 = var_228_18:GetChild(iter_228_4)

					if var_228_21.name == "split_1" or not string.find(var_228_21.name, "split") then
						var_228_21.gameObject:SetActive(true)
					else
						var_228_21.gameObject:SetActive(false)
					end
				end
			end

			local var_228_22 = 0.001

			if var_228_19 <= arg_225_1.time_ and arg_225_1.time_ < var_228_19 + var_228_22 then
				local var_228_23 = (arg_225_1.time_ - var_228_19) / var_228_22
				local var_228_24 = Vector3.New(0, -340, -414)

				var_228_18.localPosition = Vector3.Lerp(arg_225_1.var_.moveOldPos10094, var_228_24, var_228_23)
			end

			if arg_225_1.time_ >= var_228_19 + var_228_22 and arg_225_1.time_ < var_228_19 + var_228_22 + arg_228_0 then
				var_228_18.localPosition = Vector3.New(0, -340, -414)
			end

			local var_228_25 = arg_225_1.actors_["10092"]
			local var_228_26 = 0

			if var_228_26 < arg_225_1.time_ and arg_225_1.time_ <= var_228_26 + arg_228_0 and not isNil(var_228_25) and arg_225_1.var_.actorSpriteComps10092 == nil then
				arg_225_1.var_.actorSpriteComps10092 = var_228_25:GetComponentsInChildren(typeof(Image), true)
			end

			local var_228_27 = 2

			if var_228_26 <= arg_225_1.time_ and arg_225_1.time_ < var_228_26 + var_228_27 and not isNil(var_228_25) then
				local var_228_28 = (arg_225_1.time_ - var_228_26) / var_228_27

				if arg_225_1.var_.actorSpriteComps10092 then
					for iter_228_5, iter_228_6 in pairs(arg_225_1.var_.actorSpriteComps10092:ToTable()) do
						if iter_228_6 then
							if arg_225_1.isInRecall_ then
								local var_228_29 = Mathf.Lerp(iter_228_6.color.r, arg_225_1.hightColor2.r, var_228_28)
								local var_228_30 = Mathf.Lerp(iter_228_6.color.g, arg_225_1.hightColor2.g, var_228_28)
								local var_228_31 = Mathf.Lerp(iter_228_6.color.b, arg_225_1.hightColor2.b, var_228_28)

								iter_228_6.color = Color.New(var_228_29, var_228_30, var_228_31)
							else
								local var_228_32 = Mathf.Lerp(iter_228_6.color.r, 0.5, var_228_28)

								iter_228_6.color = Color.New(var_228_32, var_228_32, var_228_32)
							end
						end
					end
				end
			end

			if arg_225_1.time_ >= var_228_26 + var_228_27 and arg_225_1.time_ < var_228_26 + var_228_27 + arg_228_0 and not isNil(var_228_25) and arg_225_1.var_.actorSpriteComps10092 then
				for iter_228_7, iter_228_8 in pairs(arg_225_1.var_.actorSpriteComps10092:ToTable()) do
					if iter_228_8 then
						if arg_225_1.isInRecall_ then
							iter_228_8.color = arg_225_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_228_8.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_225_1.var_.actorSpriteComps10092 = nil
			end

			local var_228_33 = arg_225_1.actors_["10093"]
			local var_228_34 = 0

			if var_228_34 < arg_225_1.time_ and arg_225_1.time_ <= var_228_34 + arg_228_0 and not isNil(var_228_33) and arg_225_1.var_.actorSpriteComps10093 == nil then
				arg_225_1.var_.actorSpriteComps10093 = var_228_33:GetComponentsInChildren(typeof(Image), true)
			end

			local var_228_35 = 2

			if var_228_34 <= arg_225_1.time_ and arg_225_1.time_ < var_228_34 + var_228_35 and not isNil(var_228_33) then
				local var_228_36 = (arg_225_1.time_ - var_228_34) / var_228_35

				if arg_225_1.var_.actorSpriteComps10093 then
					for iter_228_9, iter_228_10 in pairs(arg_225_1.var_.actorSpriteComps10093:ToTable()) do
						if iter_228_10 then
							if arg_225_1.isInRecall_ then
								local var_228_37 = Mathf.Lerp(iter_228_10.color.r, arg_225_1.hightColor2.r, var_228_36)
								local var_228_38 = Mathf.Lerp(iter_228_10.color.g, arg_225_1.hightColor2.g, var_228_36)
								local var_228_39 = Mathf.Lerp(iter_228_10.color.b, arg_225_1.hightColor2.b, var_228_36)

								iter_228_10.color = Color.New(var_228_37, var_228_38, var_228_39)
							else
								local var_228_40 = Mathf.Lerp(iter_228_10.color.r, 0.5, var_228_36)

								iter_228_10.color = Color.New(var_228_40, var_228_40, var_228_40)
							end
						end
					end
				end
			end

			if arg_225_1.time_ >= var_228_34 + var_228_35 and arg_225_1.time_ < var_228_34 + var_228_35 + arg_228_0 and not isNil(var_228_33) and arg_225_1.var_.actorSpriteComps10093 then
				for iter_228_11, iter_228_12 in pairs(arg_225_1.var_.actorSpriteComps10093:ToTable()) do
					if iter_228_12 then
						if arg_225_1.isInRecall_ then
							iter_228_12.color = arg_225_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_228_12.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_225_1.var_.actorSpriteComps10093 = nil
			end

			local var_228_41 = arg_225_1.actors_["10094"]
			local var_228_42 = 0

			if var_228_42 < arg_225_1.time_ and arg_225_1.time_ <= var_228_42 + arg_228_0 and not isNil(var_228_41) and arg_225_1.var_.actorSpriteComps10094 == nil then
				arg_225_1.var_.actorSpriteComps10094 = var_228_41:GetComponentsInChildren(typeof(Image), true)
			end

			local var_228_43 = 2

			if var_228_42 <= arg_225_1.time_ and arg_225_1.time_ < var_228_42 + var_228_43 and not isNil(var_228_41) then
				local var_228_44 = (arg_225_1.time_ - var_228_42) / var_228_43

				if arg_225_1.var_.actorSpriteComps10094 then
					for iter_228_13, iter_228_14 in pairs(arg_225_1.var_.actorSpriteComps10094:ToTable()) do
						if iter_228_14 then
							if arg_225_1.isInRecall_ then
								local var_228_45 = Mathf.Lerp(iter_228_14.color.r, arg_225_1.hightColor1.r, var_228_44)
								local var_228_46 = Mathf.Lerp(iter_228_14.color.g, arg_225_1.hightColor1.g, var_228_44)
								local var_228_47 = Mathf.Lerp(iter_228_14.color.b, arg_225_1.hightColor1.b, var_228_44)

								iter_228_14.color = Color.New(var_228_45, var_228_46, var_228_47)
							else
								local var_228_48 = Mathf.Lerp(iter_228_14.color.r, 1, var_228_44)

								iter_228_14.color = Color.New(var_228_48, var_228_48, var_228_48)
							end
						end
					end
				end
			end

			if arg_225_1.time_ >= var_228_42 + var_228_43 and arg_225_1.time_ < var_228_42 + var_228_43 + arg_228_0 and not isNil(var_228_41) and arg_225_1.var_.actorSpriteComps10094 then
				for iter_228_15, iter_228_16 in pairs(arg_225_1.var_.actorSpriteComps10094:ToTable()) do
					if iter_228_16 then
						if arg_225_1.isInRecall_ then
							iter_228_16.color = arg_225_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_228_16.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_225_1.var_.actorSpriteComps10094 = nil
			end

			local var_228_49 = 0
			local var_228_50 = 0.575

			if var_228_49 < arg_225_1.time_ and arg_225_1.time_ <= var_228_49 + arg_228_0 then
				arg_225_1.talkMaxDuration = 0
				arg_225_1.dialogCg_.alpha = 1

				arg_225_1.dialog_:SetActive(true)
				SetActive(arg_225_1.leftNameGo_, true)

				local var_228_51 = arg_225_1:FormatText(StoryNameCfg[259].name)

				arg_225_1.leftNameTxt_.text = var_228_51

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_225_1.leftNameTxt_.transform)

				arg_225_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_225_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_225_1:RecordName(arg_225_1.leftNameTxt_.text)
				SetActive(arg_225_1.iconTrs_.gameObject, false)
				arg_225_1.callingController_:SetSelectedState("normal")

				local var_228_52 = arg_225_1:GetWordFromCfg(413072053)
				local var_228_53 = arg_225_1:FormatText(var_228_52.content)

				arg_225_1.text_.text = var_228_53

				LuaForUtil.ClearLinePrefixSymbol(arg_225_1.text_)

				local var_228_54 = 23
				local var_228_55 = utf8.len(var_228_53)
				local var_228_56 = var_228_54 <= 0 and var_228_50 or var_228_50 * (var_228_55 / var_228_54)

				if var_228_56 > 0 and var_228_50 < var_228_56 then
					arg_225_1.talkMaxDuration = var_228_56

					if var_228_56 + var_228_49 > arg_225_1.duration_ then
						arg_225_1.duration_ = var_228_56 + var_228_49
					end
				end

				arg_225_1.text_.text = var_228_53
				arg_225_1.typewritter.percent = 0

				arg_225_1.typewritter:SetDirty()
				arg_225_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_413072", "413072053", "story_v_out_413072.awb") ~= 0 then
					local var_228_57 = manager.audio:GetVoiceLength("story_v_out_413072", "413072053", "story_v_out_413072.awb") / 1000

					if var_228_57 + var_228_49 > arg_225_1.duration_ then
						arg_225_1.duration_ = var_228_57 + var_228_49
					end

					if var_228_52.prefab_name ~= "" and arg_225_1.actors_[var_228_52.prefab_name] ~= nil then
						local var_228_58 = LuaForUtil.PlayVoiceWithCriLipsync(arg_225_1.actors_[var_228_52.prefab_name].transform, "story_v_out_413072", "413072053", "story_v_out_413072.awb")

						arg_225_1:RecordAudio("413072053", var_228_58)
						arg_225_1:RecordAudio("413072053", var_228_58)
					else
						arg_225_1:AudioAction("play", "voice", "story_v_out_413072", "413072053", "story_v_out_413072.awb")
					end

					arg_225_1:RecordHistoryTalkVoice("story_v_out_413072", "413072053", "story_v_out_413072.awb")
				end

				arg_225_1:RecordContent(arg_225_1.text_.text)
			end

			local var_228_59 = math.max(var_228_50, arg_225_1.talkMaxDuration)

			if var_228_49 <= arg_225_1.time_ and arg_225_1.time_ < var_228_49 + var_228_59 then
				arg_225_1.typewritter.percent = (arg_225_1.time_ - var_228_49) / var_228_59

				arg_225_1.typewritter:SetDirty()
			end

			if arg_225_1.time_ >= var_228_49 + var_228_59 and arg_225_1.time_ < var_228_49 + var_228_59 + arg_228_0 then
				arg_225_1.typewritter.percent = 1

				arg_225_1.typewritter:SetDirty()
				arg_225_1:ShowNextGo(true)
			end
		end

		arg_225_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10092",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.0166666666666667,
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

		arg_225_1:InitPlayNodeList()
	end,
	Play413072054 = function(arg_229_0, arg_229_1)
		arg_229_1.time_ = 0
		arg_229_1.frameCnt_ = 0
		arg_229_1.state_ = "playing"
		arg_229_1.curTalkId_ = 413072054
		arg_229_1.duration_ = 6.8

		local var_229_0 = {
			zh = 3.3,
			ja = 6.8
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
				arg_229_0:Play413072055(arg_229_1)
			end
		end

		function arg_229_1.onSingleLineUpdate_(arg_232_0)
			local var_232_0 = arg_229_1.actors_["10094"]
			local var_232_1 = 0

			if var_232_1 < arg_229_1.time_ and arg_229_1.time_ <= var_232_1 + arg_232_0 and not isNil(var_232_0) and arg_229_1.var_.actorSpriteComps10094 == nil then
				arg_229_1.var_.actorSpriteComps10094 = var_232_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_232_2 = 2

			if var_232_1 <= arg_229_1.time_ and arg_229_1.time_ < var_232_1 + var_232_2 and not isNil(var_232_0) then
				local var_232_3 = (arg_229_1.time_ - var_232_1) / var_232_2

				if arg_229_1.var_.actorSpriteComps10094 then
					for iter_232_0, iter_232_1 in pairs(arg_229_1.var_.actorSpriteComps10094:ToTable()) do
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

			if arg_229_1.time_ >= var_232_1 + var_232_2 and arg_229_1.time_ < var_232_1 + var_232_2 + arg_232_0 and not isNil(var_232_0) and arg_229_1.var_.actorSpriteComps10094 then
				for iter_232_2, iter_232_3 in pairs(arg_229_1.var_.actorSpriteComps10094:ToTable()) do
					if iter_232_3 then
						if arg_229_1.isInRecall_ then
							iter_232_3.color = arg_229_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_232_3.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_229_1.var_.actorSpriteComps10094 = nil
			end

			local var_232_8 = 0
			local var_232_9 = 0.4

			if var_232_8 < arg_229_1.time_ and arg_229_1.time_ <= var_232_8 + arg_232_0 then
				arg_229_1.talkMaxDuration = 0
				arg_229_1.dialogCg_.alpha = 1

				arg_229_1.dialog_:SetActive(true)
				SetActive(arg_229_1.leftNameGo_, true)

				local var_232_10 = arg_229_1:FormatText(StoryNameCfg[994].name)

				arg_229_1.leftNameTxt_.text = var_232_10

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_229_1.leftNameTxt_.transform)

				arg_229_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_229_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_229_1:RecordName(arg_229_1.leftNameTxt_.text)
				SetActive(arg_229_1.iconTrs_.gameObject, true)
				arg_229_1.iconController_:SetSelectedState("hero")

				arg_229_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_knightman1")

				arg_229_1.callingController_:SetSelectedState("normal")

				arg_229_1.keyicon_.color = Color.New(1, 1, 1)
				arg_229_1.icon_.color = Color.New(1, 1, 1)

				local var_232_11 = arg_229_1:GetWordFromCfg(413072054)
				local var_232_12 = arg_229_1:FormatText(var_232_11.content)

				arg_229_1.text_.text = var_232_12

				LuaForUtil.ClearLinePrefixSymbol(arg_229_1.text_)

				local var_232_13 = 16
				local var_232_14 = utf8.len(var_232_12)
				local var_232_15 = var_232_13 <= 0 and var_232_9 or var_232_9 * (var_232_14 / var_232_13)

				if var_232_15 > 0 and var_232_9 < var_232_15 then
					arg_229_1.talkMaxDuration = var_232_15

					if var_232_15 + var_232_8 > arg_229_1.duration_ then
						arg_229_1.duration_ = var_232_15 + var_232_8
					end
				end

				arg_229_1.text_.text = var_232_12
				arg_229_1.typewritter.percent = 0

				arg_229_1.typewritter:SetDirty()
				arg_229_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_413072", "413072054", "story_v_out_413072.awb") ~= 0 then
					local var_232_16 = manager.audio:GetVoiceLength("story_v_out_413072", "413072054", "story_v_out_413072.awb") / 1000

					if var_232_16 + var_232_8 > arg_229_1.duration_ then
						arg_229_1.duration_ = var_232_16 + var_232_8
					end

					if var_232_11.prefab_name ~= "" and arg_229_1.actors_[var_232_11.prefab_name] ~= nil then
						local var_232_17 = LuaForUtil.PlayVoiceWithCriLipsync(arg_229_1.actors_[var_232_11.prefab_name].transform, "story_v_out_413072", "413072054", "story_v_out_413072.awb")

						arg_229_1:RecordAudio("413072054", var_232_17)
						arg_229_1:RecordAudio("413072054", var_232_17)
					else
						arg_229_1:AudioAction("play", "voice", "story_v_out_413072", "413072054", "story_v_out_413072.awb")
					end

					arg_229_1:RecordHistoryTalkVoice("story_v_out_413072", "413072054", "story_v_out_413072.awb")
				end

				arg_229_1:RecordContent(arg_229_1.text_.text)
			end

			local var_232_18 = math.max(var_232_9, arg_229_1.talkMaxDuration)

			if var_232_8 <= arg_229_1.time_ and arg_229_1.time_ < var_232_8 + var_232_18 then
				arg_229_1.typewritter.percent = (arg_229_1.time_ - var_232_8) / var_232_18

				arg_229_1.typewritter:SetDirty()
			end

			if arg_229_1.time_ >= var_232_8 + var_232_18 and arg_229_1.time_ < var_232_8 + var_232_18 + arg_232_0 then
				arg_229_1.typewritter.percent = 1

				arg_229_1.typewritter:SetDirty()
				arg_229_1:ShowNextGo(true)
			end
		end

		arg_229_1.nodeConfigList_ = {}

		arg_229_1:InitPlayNodeList()
	end,
	Play413072055 = function(arg_233_0, arg_233_1)
		arg_233_1.time_ = 0
		arg_233_1.frameCnt_ = 0
		arg_233_1.state_ = "playing"
		arg_233_1.curTalkId_ = 413072055
		arg_233_1.duration_ = 4.23

		local var_233_0 = {
			zh = 4.233,
			ja = 3.266
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
				arg_233_0:Play413072056(arg_233_1)
			end
		end

		function arg_233_1.onSingleLineUpdate_(arg_236_0)
			local var_236_0 = arg_233_1.actors_["10094"].transform
			local var_236_1 = 0

			if var_236_1 < arg_233_1.time_ and arg_233_1.time_ <= var_236_1 + arg_236_0 then
				arg_233_1.var_.moveOldPos10094 = var_236_0.localPosition
				var_236_0.localScale = Vector3.New(1, 1, 1)

				arg_233_1:CheckSpriteTmpPos("10094", 7)

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
				local var_236_6 = Vector3.New(0, -2000, -180)

				var_236_0.localPosition = Vector3.Lerp(arg_233_1.var_.moveOldPos10094, var_236_6, var_236_5)
			end

			if arg_233_1.time_ >= var_236_1 + var_236_4 and arg_233_1.time_ < var_236_1 + var_236_4 + arg_236_0 then
				var_236_0.localPosition = Vector3.New(0, -2000, -180)
			end

			local var_236_7 = arg_233_1.actors_["10093"].transform
			local var_236_8 = 0

			if var_236_8 < arg_233_1.time_ and arg_233_1.time_ <= var_236_8 + arg_236_0 then
				arg_233_1.var_.moveOldPos10093 = var_236_7.localPosition
				var_236_7.localScale = Vector3.New(1, 1, 1)

				arg_233_1:CheckSpriteTmpPos("10093", 3)

				local var_236_9 = var_236_7.childCount

				for iter_236_1 = 0, var_236_9 - 1 do
					local var_236_10 = var_236_7:GetChild(iter_236_1)

					if var_236_10.name == "split_4" or not string.find(var_236_10.name, "split") then
						var_236_10.gameObject:SetActive(true)
					else
						var_236_10.gameObject:SetActive(false)
					end
				end
			end

			local var_236_11 = 0.001

			if var_236_8 <= arg_233_1.time_ and arg_233_1.time_ < var_236_8 + var_236_11 then
				local var_236_12 = (arg_233_1.time_ - var_236_8) / var_236_11
				local var_236_13 = Vector3.New(0, -345, -245)

				var_236_7.localPosition = Vector3.Lerp(arg_233_1.var_.moveOldPos10093, var_236_13, var_236_12)
			end

			if arg_233_1.time_ >= var_236_8 + var_236_11 and arg_233_1.time_ < var_236_8 + var_236_11 + arg_236_0 then
				var_236_7.localPosition = Vector3.New(0, -345, -245)
			end

			local var_236_14 = arg_233_1.actors_["10094"]
			local var_236_15 = 0

			if var_236_15 < arg_233_1.time_ and arg_233_1.time_ <= var_236_15 + arg_236_0 and not isNil(var_236_14) and arg_233_1.var_.actorSpriteComps10094 == nil then
				arg_233_1.var_.actorSpriteComps10094 = var_236_14:GetComponentsInChildren(typeof(Image), true)
			end

			local var_236_16 = 2

			if var_236_15 <= arg_233_1.time_ and arg_233_1.time_ < var_236_15 + var_236_16 and not isNil(var_236_14) then
				local var_236_17 = (arg_233_1.time_ - var_236_15) / var_236_16

				if arg_233_1.var_.actorSpriteComps10094 then
					for iter_236_2, iter_236_3 in pairs(arg_233_1.var_.actorSpriteComps10094:ToTable()) do
						if iter_236_3 then
							if arg_233_1.isInRecall_ then
								local var_236_18 = Mathf.Lerp(iter_236_3.color.r, arg_233_1.hightColor2.r, var_236_17)
								local var_236_19 = Mathf.Lerp(iter_236_3.color.g, arg_233_1.hightColor2.g, var_236_17)
								local var_236_20 = Mathf.Lerp(iter_236_3.color.b, arg_233_1.hightColor2.b, var_236_17)

								iter_236_3.color = Color.New(var_236_18, var_236_19, var_236_20)
							else
								local var_236_21 = Mathf.Lerp(iter_236_3.color.r, 0.5, var_236_17)

								iter_236_3.color = Color.New(var_236_21, var_236_21, var_236_21)
							end
						end
					end
				end
			end

			if arg_233_1.time_ >= var_236_15 + var_236_16 and arg_233_1.time_ < var_236_15 + var_236_16 + arg_236_0 and not isNil(var_236_14) and arg_233_1.var_.actorSpriteComps10094 then
				for iter_236_4, iter_236_5 in pairs(arg_233_1.var_.actorSpriteComps10094:ToTable()) do
					if iter_236_5 then
						if arg_233_1.isInRecall_ then
							iter_236_5.color = arg_233_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_236_5.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_233_1.var_.actorSpriteComps10094 = nil
			end

			local var_236_22 = arg_233_1.actors_["10093"]
			local var_236_23 = 0

			if var_236_23 < arg_233_1.time_ and arg_233_1.time_ <= var_236_23 + arg_236_0 and not isNil(var_236_22) and arg_233_1.var_.actorSpriteComps10093 == nil then
				arg_233_1.var_.actorSpriteComps10093 = var_236_22:GetComponentsInChildren(typeof(Image), true)
			end

			local var_236_24 = 2

			if var_236_23 <= arg_233_1.time_ and arg_233_1.time_ < var_236_23 + var_236_24 and not isNil(var_236_22) then
				local var_236_25 = (arg_233_1.time_ - var_236_23) / var_236_24

				if arg_233_1.var_.actorSpriteComps10093 then
					for iter_236_6, iter_236_7 in pairs(arg_233_1.var_.actorSpriteComps10093:ToTable()) do
						if iter_236_7 then
							if arg_233_1.isInRecall_ then
								local var_236_26 = Mathf.Lerp(iter_236_7.color.r, arg_233_1.hightColor1.r, var_236_25)
								local var_236_27 = Mathf.Lerp(iter_236_7.color.g, arg_233_1.hightColor1.g, var_236_25)
								local var_236_28 = Mathf.Lerp(iter_236_7.color.b, arg_233_1.hightColor1.b, var_236_25)

								iter_236_7.color = Color.New(var_236_26, var_236_27, var_236_28)
							else
								local var_236_29 = Mathf.Lerp(iter_236_7.color.r, 1, var_236_25)

								iter_236_7.color = Color.New(var_236_29, var_236_29, var_236_29)
							end
						end
					end
				end
			end

			if arg_233_1.time_ >= var_236_23 + var_236_24 and arg_233_1.time_ < var_236_23 + var_236_24 + arg_236_0 and not isNil(var_236_22) and arg_233_1.var_.actorSpriteComps10093 then
				for iter_236_8, iter_236_9 in pairs(arg_233_1.var_.actorSpriteComps10093:ToTable()) do
					if iter_236_9 then
						if arg_233_1.isInRecall_ then
							iter_236_9.color = arg_233_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_236_9.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_233_1.var_.actorSpriteComps10093 = nil
			end

			local var_236_30 = 0
			local var_236_31 = 0.45

			if var_236_30 < arg_233_1.time_ and arg_233_1.time_ <= var_236_30 + arg_236_0 then
				arg_233_1.talkMaxDuration = 0
				arg_233_1.dialogCg_.alpha = 1

				arg_233_1.dialog_:SetActive(true)
				SetActive(arg_233_1.leftNameGo_, true)

				local var_236_32 = arg_233_1:FormatText(StoryNameCfg[28].name)

				arg_233_1.leftNameTxt_.text = var_236_32

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_233_1.leftNameTxt_.transform)

				arg_233_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_233_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_233_1:RecordName(arg_233_1.leftNameTxt_.text)
				SetActive(arg_233_1.iconTrs_.gameObject, false)
				arg_233_1.callingController_:SetSelectedState("normal")

				local var_236_33 = arg_233_1:GetWordFromCfg(413072055)
				local var_236_34 = arg_233_1:FormatText(var_236_33.content)

				arg_233_1.text_.text = var_236_34

				LuaForUtil.ClearLinePrefixSymbol(arg_233_1.text_)

				local var_236_35 = 18
				local var_236_36 = utf8.len(var_236_34)
				local var_236_37 = var_236_35 <= 0 and var_236_31 or var_236_31 * (var_236_36 / var_236_35)

				if var_236_37 > 0 and var_236_31 < var_236_37 then
					arg_233_1.talkMaxDuration = var_236_37

					if var_236_37 + var_236_30 > arg_233_1.duration_ then
						arg_233_1.duration_ = var_236_37 + var_236_30
					end
				end

				arg_233_1.text_.text = var_236_34
				arg_233_1.typewritter.percent = 0

				arg_233_1.typewritter:SetDirty()
				arg_233_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_413072", "413072055", "story_v_out_413072.awb") ~= 0 then
					local var_236_38 = manager.audio:GetVoiceLength("story_v_out_413072", "413072055", "story_v_out_413072.awb") / 1000

					if var_236_38 + var_236_30 > arg_233_1.duration_ then
						arg_233_1.duration_ = var_236_38 + var_236_30
					end

					if var_236_33.prefab_name ~= "" and arg_233_1.actors_[var_236_33.prefab_name] ~= nil then
						local var_236_39 = LuaForUtil.PlayVoiceWithCriLipsync(arg_233_1.actors_[var_236_33.prefab_name].transform, "story_v_out_413072", "413072055", "story_v_out_413072.awb")

						arg_233_1:RecordAudio("413072055", var_236_39)
						arg_233_1:RecordAudio("413072055", var_236_39)
					else
						arg_233_1:AudioAction("play", "voice", "story_v_out_413072", "413072055", "story_v_out_413072.awb")
					end

					arg_233_1:RecordHistoryTalkVoice("story_v_out_413072", "413072055", "story_v_out_413072.awb")
				end

				arg_233_1:RecordContent(arg_233_1.text_.text)
			end

			local var_236_40 = math.max(var_236_31, arg_233_1.talkMaxDuration)

			if var_236_30 <= arg_233_1.time_ and arg_233_1.time_ < var_236_30 + var_236_40 then
				arg_233_1.typewritter.percent = (arg_233_1.time_ - var_236_30) / var_236_40

				arg_233_1.typewritter:SetDirty()
			end

			if arg_233_1.time_ >= var_236_30 + var_236_40 and arg_233_1.time_ < var_236_30 + var_236_40 + arg_236_0 then
				arg_233_1.typewritter.percent = 1

				arg_233_1.typewritter:SetDirty()
				arg_233_1:ShowNextGo(true)
			end
		end

		arg_233_1.nodeConfigList_ = {
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
				actorName = "10093",
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
	Play413072056 = function(arg_237_0, arg_237_1)
		arg_237_1.time_ = 0
		arg_237_1.frameCnt_ = 0
		arg_237_1.state_ = "playing"
		arg_237_1.curTalkId_ = 413072056
		arg_237_1.duration_ = 6.73

		local var_237_0 = {
			zh = 4.366,
			ja = 6.733
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
				arg_237_0:Play413072057(arg_237_1)
			end
		end

		function arg_237_1.onSingleLineUpdate_(arg_240_0)
			local var_240_0 = arg_237_1.actors_["10093"].transform
			local var_240_1 = 0

			if var_240_1 < arg_237_1.time_ and arg_237_1.time_ <= var_240_1 + arg_240_0 then
				arg_237_1.var_.moveOldPos10093 = var_240_0.localPosition
				var_240_0.localScale = Vector3.New(1, 1, 1)

				arg_237_1:CheckSpriteTmpPos("10093", 7)

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

				var_240_0.localPosition = Vector3.Lerp(arg_237_1.var_.moveOldPos10093, var_240_6, var_240_5)
			end

			if arg_237_1.time_ >= var_240_1 + var_240_4 and arg_237_1.time_ < var_240_1 + var_240_4 + arg_240_0 then
				var_240_0.localPosition = Vector3.New(0, -2000, 0)
			end

			local var_240_7 = arg_237_1.actors_["10093"]
			local var_240_8 = 0

			if var_240_8 < arg_237_1.time_ and arg_237_1.time_ <= var_240_8 + arg_240_0 and not isNil(var_240_7) and arg_237_1.var_.actorSpriteComps10093 == nil then
				arg_237_1.var_.actorSpriteComps10093 = var_240_7:GetComponentsInChildren(typeof(Image), true)
			end

			local var_240_9 = 2

			if var_240_8 <= arg_237_1.time_ and arg_237_1.time_ < var_240_8 + var_240_9 and not isNil(var_240_7) then
				local var_240_10 = (arg_237_1.time_ - var_240_8) / var_240_9

				if arg_237_1.var_.actorSpriteComps10093 then
					for iter_240_1, iter_240_2 in pairs(arg_237_1.var_.actorSpriteComps10093:ToTable()) do
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

			if arg_237_1.time_ >= var_240_8 + var_240_9 and arg_237_1.time_ < var_240_8 + var_240_9 + arg_240_0 and not isNil(var_240_7) and arg_237_1.var_.actorSpriteComps10093 then
				for iter_240_3, iter_240_4 in pairs(arg_237_1.var_.actorSpriteComps10093:ToTable()) do
					if iter_240_4 then
						if arg_237_1.isInRecall_ then
							iter_240_4.color = arg_237_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_240_4.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_237_1.var_.actorSpriteComps10093 = nil
			end

			local var_240_15 = arg_237_1.actors_["10094"]
			local var_240_16 = 0

			if var_240_16 < arg_237_1.time_ and arg_237_1.time_ <= var_240_16 + arg_240_0 and not isNil(var_240_15) and arg_237_1.var_.actorSpriteComps10094 == nil then
				arg_237_1.var_.actorSpriteComps10094 = var_240_15:GetComponentsInChildren(typeof(Image), true)
			end

			local var_240_17 = 2

			if var_240_16 <= arg_237_1.time_ and arg_237_1.time_ < var_240_16 + var_240_17 and not isNil(var_240_15) then
				local var_240_18 = (arg_237_1.time_ - var_240_16) / var_240_17

				if arg_237_1.var_.actorSpriteComps10094 then
					for iter_240_5, iter_240_6 in pairs(arg_237_1.var_.actorSpriteComps10094:ToTable()) do
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

			if arg_237_1.time_ >= var_240_16 + var_240_17 and arg_237_1.time_ < var_240_16 + var_240_17 + arg_240_0 and not isNil(var_240_15) and arg_237_1.var_.actorSpriteComps10094 then
				for iter_240_7, iter_240_8 in pairs(arg_237_1.var_.actorSpriteComps10094:ToTable()) do
					if iter_240_8 then
						if arg_237_1.isInRecall_ then
							iter_240_8.color = arg_237_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_240_8.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_237_1.var_.actorSpriteComps10094 = nil
			end

			local var_240_23 = arg_237_1.actors_["10094"].transform
			local var_240_24 = 0

			if var_240_24 < arg_237_1.time_ and arg_237_1.time_ <= var_240_24 + arg_240_0 then
				arg_237_1.var_.moveOldPos10094 = var_240_23.localPosition
				var_240_23.localScale = Vector3.New(1, 1, 1)

				arg_237_1:CheckSpriteTmpPos("10094", 3)

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
				local var_240_29 = Vector3.New(0, -340, -414)

				var_240_23.localPosition = Vector3.Lerp(arg_237_1.var_.moveOldPos10094, var_240_29, var_240_28)
			end

			if arg_237_1.time_ >= var_240_24 + var_240_27 and arg_237_1.time_ < var_240_24 + var_240_27 + arg_240_0 then
				var_240_23.localPosition = Vector3.New(0, -340, -414)
			end

			local var_240_30 = 0
			local var_240_31 = 0.55

			if var_240_30 < arg_237_1.time_ and arg_237_1.time_ <= var_240_30 + arg_240_0 then
				arg_237_1.talkMaxDuration = 0
				arg_237_1.dialogCg_.alpha = 1

				arg_237_1.dialog_:SetActive(true)
				SetActive(arg_237_1.leftNameGo_, true)

				local var_240_32 = arg_237_1:FormatText(StoryNameCfg[259].name)

				arg_237_1.leftNameTxt_.text = var_240_32

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_237_1.leftNameTxt_.transform)

				arg_237_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_237_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_237_1:RecordName(arg_237_1.leftNameTxt_.text)
				SetActive(arg_237_1.iconTrs_.gameObject, false)
				arg_237_1.callingController_:SetSelectedState("normal")

				local var_240_33 = arg_237_1:GetWordFromCfg(413072056)
				local var_240_34 = arg_237_1:FormatText(var_240_33.content)

				arg_237_1.text_.text = var_240_34

				LuaForUtil.ClearLinePrefixSymbol(arg_237_1.text_)

				local var_240_35 = 22
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

				if manager.audio:GetVoiceLength("story_v_out_413072", "413072056", "story_v_out_413072.awb") ~= 0 then
					local var_240_38 = manager.audio:GetVoiceLength("story_v_out_413072", "413072056", "story_v_out_413072.awb") / 1000

					if var_240_38 + var_240_30 > arg_237_1.duration_ then
						arg_237_1.duration_ = var_240_38 + var_240_30
					end

					if var_240_33.prefab_name ~= "" and arg_237_1.actors_[var_240_33.prefab_name] ~= nil then
						local var_240_39 = LuaForUtil.PlayVoiceWithCriLipsync(arg_237_1.actors_[var_240_33.prefab_name].transform, "story_v_out_413072", "413072056", "story_v_out_413072.awb")

						arg_237_1:RecordAudio("413072056", var_240_39)
						arg_237_1:RecordAudio("413072056", var_240_39)
					else
						arg_237_1:AudioAction("play", "voice", "story_v_out_413072", "413072056", "story_v_out_413072.awb")
					end

					arg_237_1:RecordHistoryTalkVoice("story_v_out_413072", "413072056", "story_v_out_413072.awb")
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
				actorName = "10094",
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
	Play413072057 = function(arg_241_0, arg_241_1)
		arg_241_1.time_ = 0
		arg_241_1.frameCnt_ = 0
		arg_241_1.state_ = "playing"
		arg_241_1.curTalkId_ = 413072057
		arg_241_1.duration_ = 3.87

		local var_241_0 = {
			zh = 1.933,
			ja = 3.866
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
				arg_241_0:Play413072058(arg_241_1)
			end
		end

		function arg_241_1.onSingleLineUpdate_(arg_244_0)
			local var_244_0 = 0
			local var_244_1 = 0.275

			if var_244_0 < arg_241_1.time_ and arg_241_1.time_ <= var_244_0 + arg_244_0 then
				arg_241_1.talkMaxDuration = 0
				arg_241_1.dialogCg_.alpha = 1

				arg_241_1.dialog_:SetActive(true)
				SetActive(arg_241_1.leftNameGo_, true)

				local var_244_2 = arg_241_1:FormatText(StoryNameCfg[259].name)

				arg_241_1.leftNameTxt_.text = var_244_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_241_1.leftNameTxt_.transform)

				arg_241_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_241_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_241_1:RecordName(arg_241_1.leftNameTxt_.text)
				SetActive(arg_241_1.iconTrs_.gameObject, false)
				arg_241_1.callingController_:SetSelectedState("normal")

				local var_244_3 = arg_241_1:GetWordFromCfg(413072057)
				local var_244_4 = arg_241_1:FormatText(var_244_3.content)

				arg_241_1.text_.text = var_244_4

				LuaForUtil.ClearLinePrefixSymbol(arg_241_1.text_)

				local var_244_5 = 11
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

				if manager.audio:GetVoiceLength("story_v_out_413072", "413072057", "story_v_out_413072.awb") ~= 0 then
					local var_244_8 = manager.audio:GetVoiceLength("story_v_out_413072", "413072057", "story_v_out_413072.awb") / 1000

					if var_244_8 + var_244_0 > arg_241_1.duration_ then
						arg_241_1.duration_ = var_244_8 + var_244_0
					end

					if var_244_3.prefab_name ~= "" and arg_241_1.actors_[var_244_3.prefab_name] ~= nil then
						local var_244_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_241_1.actors_[var_244_3.prefab_name].transform, "story_v_out_413072", "413072057", "story_v_out_413072.awb")

						arg_241_1:RecordAudio("413072057", var_244_9)
						arg_241_1:RecordAudio("413072057", var_244_9)
					else
						arg_241_1:AudioAction("play", "voice", "story_v_out_413072", "413072057", "story_v_out_413072.awb")
					end

					arg_241_1:RecordHistoryTalkVoice("story_v_out_413072", "413072057", "story_v_out_413072.awb")
				end

				arg_241_1:RecordContent(arg_241_1.text_.text)
			end

			local var_244_10 = math.max(var_244_1, arg_241_1.talkMaxDuration)

			if var_244_0 <= arg_241_1.time_ and arg_241_1.time_ < var_244_0 + var_244_10 then
				arg_241_1.typewritter.percent = (arg_241_1.time_ - var_244_0) / var_244_10

				arg_241_1.typewritter:SetDirty()
			end

			if arg_241_1.time_ >= var_244_0 + var_244_10 and arg_241_1.time_ < var_244_0 + var_244_10 + arg_244_0 then
				arg_241_1.typewritter.percent = 1

				arg_241_1.typewritter:SetDirty()
				arg_241_1:ShowNextGo(true)
			end
		end

		arg_241_1.nodeConfigList_ = {}

		arg_241_1:InitPlayNodeList()
	end,
	Play413072058 = function(arg_245_0, arg_245_1)
		arg_245_1.time_ = 0
		arg_245_1.frameCnt_ = 0
		arg_245_1.state_ = "playing"
		arg_245_1.curTalkId_ = 413072058
		arg_245_1.duration_ = 5.7

		local var_245_0 = {
			zh = 3.866,
			ja = 5.7
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
				arg_245_0:Play413072059(arg_245_1)
			end
		end

		function arg_245_1.onSingleLineUpdate_(arg_248_0)
			local var_248_0 = arg_245_1.actors_["10094"]
			local var_248_1 = 0

			if var_248_1 < arg_245_1.time_ and arg_245_1.time_ <= var_248_1 + arg_248_0 and not isNil(var_248_0) and arg_245_1.var_.actorSpriteComps10094 == nil then
				arg_245_1.var_.actorSpriteComps10094 = var_248_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_248_2 = 2

			if var_248_1 <= arg_245_1.time_ and arg_245_1.time_ < var_248_1 + var_248_2 and not isNil(var_248_0) then
				local var_248_3 = (arg_245_1.time_ - var_248_1) / var_248_2

				if arg_245_1.var_.actorSpriteComps10094 then
					for iter_248_0, iter_248_1 in pairs(arg_245_1.var_.actorSpriteComps10094:ToTable()) do
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

			if arg_245_1.time_ >= var_248_1 + var_248_2 and arg_245_1.time_ < var_248_1 + var_248_2 + arg_248_0 and not isNil(var_248_0) and arg_245_1.var_.actorSpriteComps10094 then
				for iter_248_2, iter_248_3 in pairs(arg_245_1.var_.actorSpriteComps10094:ToTable()) do
					if iter_248_3 then
						if arg_245_1.isInRecall_ then
							iter_248_3.color = arg_245_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_248_3.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_245_1.var_.actorSpriteComps10094 = nil
			end

			local var_248_8 = 0
			local var_248_9 = 0.45

			if var_248_8 < arg_245_1.time_ and arg_245_1.time_ <= var_248_8 + arg_248_0 then
				arg_245_1.talkMaxDuration = 0
				arg_245_1.dialogCg_.alpha = 1

				arg_245_1.dialog_:SetActive(true)
				SetActive(arg_245_1.leftNameGo_, true)

				local var_248_10 = arg_245_1:FormatText(StoryNameCfg[998].name)

				arg_245_1.leftNameTxt_.text = var_248_10

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_245_1.leftNameTxt_.transform)

				arg_245_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_245_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_245_1:RecordName(arg_245_1.leftNameTxt_.text)
				SetActive(arg_245_1.iconTrs_.gameObject, true)
				arg_245_1.iconController_:SetSelectedState("hero")

				arg_245_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_knightwoman1")

				arg_245_1.callingController_:SetSelectedState("normal")

				arg_245_1.keyicon_.color = Color.New(1, 1, 1)
				arg_245_1.icon_.color = Color.New(1, 1, 1)

				local var_248_11 = arg_245_1:GetWordFromCfg(413072058)
				local var_248_12 = arg_245_1:FormatText(var_248_11.content)

				arg_245_1.text_.text = var_248_12

				LuaForUtil.ClearLinePrefixSymbol(arg_245_1.text_)

				local var_248_13 = 18
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

				if manager.audio:GetVoiceLength("story_v_out_413072", "413072058", "story_v_out_413072.awb") ~= 0 then
					local var_248_16 = manager.audio:GetVoiceLength("story_v_out_413072", "413072058", "story_v_out_413072.awb") / 1000

					if var_248_16 + var_248_8 > arg_245_1.duration_ then
						arg_245_1.duration_ = var_248_16 + var_248_8
					end

					if var_248_11.prefab_name ~= "" and arg_245_1.actors_[var_248_11.prefab_name] ~= nil then
						local var_248_17 = LuaForUtil.PlayVoiceWithCriLipsync(arg_245_1.actors_[var_248_11.prefab_name].transform, "story_v_out_413072", "413072058", "story_v_out_413072.awb")

						arg_245_1:RecordAudio("413072058", var_248_17)
						arg_245_1:RecordAudio("413072058", var_248_17)
					else
						arg_245_1:AudioAction("play", "voice", "story_v_out_413072", "413072058", "story_v_out_413072.awb")
					end

					arg_245_1:RecordHistoryTalkVoice("story_v_out_413072", "413072058", "story_v_out_413072.awb")
				end

				arg_245_1:RecordContent(arg_245_1.text_.text)
			end

			local var_248_18 = math.max(var_248_9, arg_245_1.talkMaxDuration)

			if var_248_8 <= arg_245_1.time_ and arg_245_1.time_ < var_248_8 + var_248_18 then
				arg_245_1.typewritter.percent = (arg_245_1.time_ - var_248_8) / var_248_18

				arg_245_1.typewritter:SetDirty()
			end

			if arg_245_1.time_ >= var_248_8 + var_248_18 and arg_245_1.time_ < var_248_8 + var_248_18 + arg_248_0 then
				arg_245_1.typewritter.percent = 1

				arg_245_1.typewritter:SetDirty()
				arg_245_1:ShowNextGo(true)
			end
		end

		arg_245_1.nodeConfigList_ = {}

		arg_245_1:InitPlayNodeList()
	end,
	Play413072059 = function(arg_249_0, arg_249_1)
		arg_249_1.time_ = 0
		arg_249_1.frameCnt_ = 0
		arg_249_1.state_ = "playing"
		arg_249_1.curTalkId_ = 413072059
		arg_249_1.duration_ = 10.93

		local var_249_0 = {
			zh = 4.933,
			ja = 10.933
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
				arg_249_0:Play413072060(arg_249_1)
			end
		end

		function arg_249_1.onSingleLineUpdate_(arg_252_0)
			local var_252_0 = arg_249_1.actors_["10094"].transform
			local var_252_1 = 0

			if var_252_1 < arg_249_1.time_ and arg_249_1.time_ <= var_252_1 + arg_252_0 then
				arg_249_1.var_.moveOldPos10094 = var_252_0.localPosition
				var_252_0.localScale = Vector3.New(1, 1, 1)

				arg_249_1:CheckSpriteTmpPos("10094", 7)

				local var_252_2 = var_252_0.childCount

				for iter_252_0 = 0, var_252_2 - 1 do
					local var_252_3 = var_252_0:GetChild(iter_252_0)

					if var_252_3.name == "" or not string.find(var_252_3.name, "split") then
						var_252_3.gameObject:SetActive(true)
					else
						var_252_3.gameObject:SetActive(false)
					end
				end
			end

			local var_252_4 = 0.001

			if var_252_1 <= arg_249_1.time_ and arg_249_1.time_ < var_252_1 + var_252_4 then
				local var_252_5 = (arg_249_1.time_ - var_252_1) / var_252_4
				local var_252_6 = Vector3.New(0, -2000, -180)

				var_252_0.localPosition = Vector3.Lerp(arg_249_1.var_.moveOldPos10094, var_252_6, var_252_5)
			end

			if arg_249_1.time_ >= var_252_1 + var_252_4 and arg_249_1.time_ < var_252_1 + var_252_4 + arg_252_0 then
				var_252_0.localPosition = Vector3.New(0, -2000, -180)
			end

			local var_252_7 = arg_249_1.actors_["10092"].transform
			local var_252_8 = 0

			if var_252_8 < arg_249_1.time_ and arg_249_1.time_ <= var_252_8 + arg_252_0 then
				arg_249_1.var_.moveOldPos10092 = var_252_7.localPosition
				var_252_7.localScale = Vector3.New(1, 1, 1)

				arg_249_1:CheckSpriteTmpPos("10092", 3)

				local var_252_9 = var_252_7.childCount

				for iter_252_1 = 0, var_252_9 - 1 do
					local var_252_10 = var_252_7:GetChild(iter_252_1)

					if var_252_10.name == "" or not string.find(var_252_10.name, "split") then
						var_252_10.gameObject:SetActive(true)
					else
						var_252_10.gameObject:SetActive(false)
					end
				end
			end

			local var_252_11 = 0.001

			if var_252_8 <= arg_249_1.time_ and arg_249_1.time_ < var_252_8 + var_252_11 then
				local var_252_12 = (arg_249_1.time_ - var_252_8) / var_252_11
				local var_252_13 = Vector3.New(0, -300, -295)

				var_252_7.localPosition = Vector3.Lerp(arg_249_1.var_.moveOldPos10092, var_252_13, var_252_12)
			end

			if arg_249_1.time_ >= var_252_8 + var_252_11 and arg_249_1.time_ < var_252_8 + var_252_11 + arg_252_0 then
				var_252_7.localPosition = Vector3.New(0, -300, -295)
			end

			local var_252_14 = arg_249_1.actors_["10094"]
			local var_252_15 = 0

			if var_252_15 < arg_249_1.time_ and arg_249_1.time_ <= var_252_15 + arg_252_0 and not isNil(var_252_14) and arg_249_1.var_.actorSpriteComps10094 == nil then
				arg_249_1.var_.actorSpriteComps10094 = var_252_14:GetComponentsInChildren(typeof(Image), true)
			end

			local var_252_16 = 2

			if var_252_15 <= arg_249_1.time_ and arg_249_1.time_ < var_252_15 + var_252_16 and not isNil(var_252_14) then
				local var_252_17 = (arg_249_1.time_ - var_252_15) / var_252_16

				if arg_249_1.var_.actorSpriteComps10094 then
					for iter_252_2, iter_252_3 in pairs(arg_249_1.var_.actorSpriteComps10094:ToTable()) do
						if iter_252_3 then
							if arg_249_1.isInRecall_ then
								local var_252_18 = Mathf.Lerp(iter_252_3.color.r, arg_249_1.hightColor2.r, var_252_17)
								local var_252_19 = Mathf.Lerp(iter_252_3.color.g, arg_249_1.hightColor2.g, var_252_17)
								local var_252_20 = Mathf.Lerp(iter_252_3.color.b, arg_249_1.hightColor2.b, var_252_17)

								iter_252_3.color = Color.New(var_252_18, var_252_19, var_252_20)
							else
								local var_252_21 = Mathf.Lerp(iter_252_3.color.r, 0.5, var_252_17)

								iter_252_3.color = Color.New(var_252_21, var_252_21, var_252_21)
							end
						end
					end
				end
			end

			if arg_249_1.time_ >= var_252_15 + var_252_16 and arg_249_1.time_ < var_252_15 + var_252_16 + arg_252_0 and not isNil(var_252_14) and arg_249_1.var_.actorSpriteComps10094 then
				for iter_252_4, iter_252_5 in pairs(arg_249_1.var_.actorSpriteComps10094:ToTable()) do
					if iter_252_5 then
						if arg_249_1.isInRecall_ then
							iter_252_5.color = arg_249_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_252_5.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_249_1.var_.actorSpriteComps10094 = nil
			end

			local var_252_22 = arg_249_1.actors_["10092"]
			local var_252_23 = 0

			if var_252_23 < arg_249_1.time_ and arg_249_1.time_ <= var_252_23 + arg_252_0 and not isNil(var_252_22) and arg_249_1.var_.actorSpriteComps10092 == nil then
				arg_249_1.var_.actorSpriteComps10092 = var_252_22:GetComponentsInChildren(typeof(Image), true)
			end

			local var_252_24 = 2

			if var_252_23 <= arg_249_1.time_ and arg_249_1.time_ < var_252_23 + var_252_24 and not isNil(var_252_22) then
				local var_252_25 = (arg_249_1.time_ - var_252_23) / var_252_24

				if arg_249_1.var_.actorSpriteComps10092 then
					for iter_252_6, iter_252_7 in pairs(arg_249_1.var_.actorSpriteComps10092:ToTable()) do
						if iter_252_7 then
							if arg_249_1.isInRecall_ then
								local var_252_26 = Mathf.Lerp(iter_252_7.color.r, arg_249_1.hightColor1.r, var_252_25)
								local var_252_27 = Mathf.Lerp(iter_252_7.color.g, arg_249_1.hightColor1.g, var_252_25)
								local var_252_28 = Mathf.Lerp(iter_252_7.color.b, arg_249_1.hightColor1.b, var_252_25)

								iter_252_7.color = Color.New(var_252_26, var_252_27, var_252_28)
							else
								local var_252_29 = Mathf.Lerp(iter_252_7.color.r, 1, var_252_25)

								iter_252_7.color = Color.New(var_252_29, var_252_29, var_252_29)
							end
						end
					end
				end
			end

			if arg_249_1.time_ >= var_252_23 + var_252_24 and arg_249_1.time_ < var_252_23 + var_252_24 + arg_252_0 and not isNil(var_252_22) and arg_249_1.var_.actorSpriteComps10092 then
				for iter_252_8, iter_252_9 in pairs(arg_249_1.var_.actorSpriteComps10092:ToTable()) do
					if iter_252_9 then
						if arg_249_1.isInRecall_ then
							iter_252_9.color = arg_249_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_252_9.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_249_1.var_.actorSpriteComps10092 = nil
			end

			local var_252_30 = 0
			local var_252_31 = 0.75

			if var_252_30 < arg_249_1.time_ and arg_249_1.time_ <= var_252_30 + arg_252_0 then
				arg_249_1.talkMaxDuration = 0
				arg_249_1.dialogCg_.alpha = 1

				arg_249_1.dialog_:SetActive(true)
				SetActive(arg_249_1.leftNameGo_, true)

				local var_252_32 = arg_249_1:FormatText(StoryNameCfg[996].name)

				arg_249_1.leftNameTxt_.text = var_252_32

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_249_1.leftNameTxt_.transform)

				arg_249_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_249_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_249_1:RecordName(arg_249_1.leftNameTxt_.text)
				SetActive(arg_249_1.iconTrs_.gameObject, false)
				arg_249_1.callingController_:SetSelectedState("normal")

				local var_252_33 = arg_249_1:GetWordFromCfg(413072059)
				local var_252_34 = arg_249_1:FormatText(var_252_33.content)

				arg_249_1.text_.text = var_252_34

				LuaForUtil.ClearLinePrefixSymbol(arg_249_1.text_)

				local var_252_35 = 30
				local var_252_36 = utf8.len(var_252_34)
				local var_252_37 = var_252_35 <= 0 and var_252_31 or var_252_31 * (var_252_36 / var_252_35)

				if var_252_37 > 0 and var_252_31 < var_252_37 then
					arg_249_1.talkMaxDuration = var_252_37

					if var_252_37 + var_252_30 > arg_249_1.duration_ then
						arg_249_1.duration_ = var_252_37 + var_252_30
					end
				end

				arg_249_1.text_.text = var_252_34
				arg_249_1.typewritter.percent = 0

				arg_249_1.typewritter:SetDirty()
				arg_249_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_413072", "413072059", "story_v_out_413072.awb") ~= 0 then
					local var_252_38 = manager.audio:GetVoiceLength("story_v_out_413072", "413072059", "story_v_out_413072.awb") / 1000

					if var_252_38 + var_252_30 > arg_249_1.duration_ then
						arg_249_1.duration_ = var_252_38 + var_252_30
					end

					if var_252_33.prefab_name ~= "" and arg_249_1.actors_[var_252_33.prefab_name] ~= nil then
						local var_252_39 = LuaForUtil.PlayVoiceWithCriLipsync(arg_249_1.actors_[var_252_33.prefab_name].transform, "story_v_out_413072", "413072059", "story_v_out_413072.awb")

						arg_249_1:RecordAudio("413072059", var_252_39)
						arg_249_1:RecordAudio("413072059", var_252_39)
					else
						arg_249_1:AudioAction("play", "voice", "story_v_out_413072", "413072059", "story_v_out_413072.awb")
					end

					arg_249_1:RecordHistoryTalkVoice("story_v_out_413072", "413072059", "story_v_out_413072.awb")
				end

				arg_249_1:RecordContent(arg_249_1.text_.text)
			end

			local var_252_40 = math.max(var_252_31, arg_249_1.talkMaxDuration)

			if var_252_30 <= arg_249_1.time_ and arg_249_1.time_ < var_252_30 + var_252_40 then
				arg_249_1.typewritter.percent = (arg_249_1.time_ - var_252_30) / var_252_40

				arg_249_1.typewritter:SetDirty()
			end

			if arg_249_1.time_ >= var_252_30 + var_252_40 and arg_249_1.time_ < var_252_30 + var_252_40 + arg_252_0 then
				arg_249_1.typewritter.percent = 1

				arg_249_1.typewritter:SetDirty()
				arg_249_1:ShowNextGo(true)
			end
		end

		arg_249_1.nodeConfigList_ = {
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
				actorName = "10092",
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
	Play413072060 = function(arg_253_0, arg_253_1)
		arg_253_1.time_ = 0
		arg_253_1.frameCnt_ = 0
		arg_253_1.state_ = "playing"
		arg_253_1.curTalkId_ = 413072060
		arg_253_1.duration_ = 6.2

		local var_253_0 = {
			zh = 4.9,
			ja = 6.2
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
				arg_253_0:Play413072061(arg_253_1)
			end
		end

		function arg_253_1.onSingleLineUpdate_(arg_256_0)
			local var_256_0 = 0
			local var_256_1 = 0.625

			if var_256_0 < arg_253_1.time_ and arg_253_1.time_ <= var_256_0 + arg_256_0 then
				arg_253_1.talkMaxDuration = 0
				arg_253_1.dialogCg_.alpha = 1

				arg_253_1.dialog_:SetActive(true)
				SetActive(arg_253_1.leftNameGo_, true)

				local var_256_2 = arg_253_1:FormatText(StoryNameCfg[996].name)

				arg_253_1.leftNameTxt_.text = var_256_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_253_1.leftNameTxt_.transform)

				arg_253_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_253_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_253_1:RecordName(arg_253_1.leftNameTxt_.text)
				SetActive(arg_253_1.iconTrs_.gameObject, false)
				arg_253_1.callingController_:SetSelectedState("normal")

				local var_256_3 = arg_253_1:GetWordFromCfg(413072060)
				local var_256_4 = arg_253_1:FormatText(var_256_3.content)

				arg_253_1.text_.text = var_256_4

				LuaForUtil.ClearLinePrefixSymbol(arg_253_1.text_)

				local var_256_5 = 25
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

				if manager.audio:GetVoiceLength("story_v_out_413072", "413072060", "story_v_out_413072.awb") ~= 0 then
					local var_256_8 = manager.audio:GetVoiceLength("story_v_out_413072", "413072060", "story_v_out_413072.awb") / 1000

					if var_256_8 + var_256_0 > arg_253_1.duration_ then
						arg_253_1.duration_ = var_256_8 + var_256_0
					end

					if var_256_3.prefab_name ~= "" and arg_253_1.actors_[var_256_3.prefab_name] ~= nil then
						local var_256_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_253_1.actors_[var_256_3.prefab_name].transform, "story_v_out_413072", "413072060", "story_v_out_413072.awb")

						arg_253_1:RecordAudio("413072060", var_256_9)
						arg_253_1:RecordAudio("413072060", var_256_9)
					else
						arg_253_1:AudioAction("play", "voice", "story_v_out_413072", "413072060", "story_v_out_413072.awb")
					end

					arg_253_1:RecordHistoryTalkVoice("story_v_out_413072", "413072060", "story_v_out_413072.awb")
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
	Play413072061 = function(arg_257_0, arg_257_1)
		arg_257_1.time_ = 0
		arg_257_1.frameCnt_ = 0
		arg_257_1.state_ = "playing"
		arg_257_1.curTalkId_ = 413072061
		arg_257_1.duration_ = 7.57

		local var_257_0 = {
			zh = 5.633,
			ja = 7.566
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
				arg_257_0:Play413072062(arg_257_1)
			end
		end

		function arg_257_1.onSingleLineUpdate_(arg_260_0)
			local var_260_0 = arg_257_1.actors_["10092"].transform
			local var_260_1 = 0

			if var_260_1 < arg_257_1.time_ and arg_257_1.time_ <= var_260_1 + arg_260_0 then
				arg_257_1.var_.moveOldPos10092 = var_260_0.localPosition
				var_260_0.localScale = Vector3.New(1, 1, 1)

				arg_257_1:CheckSpriteTmpPos("10092", 3)

				local var_260_2 = var_260_0.childCount

				for iter_260_0 = 0, var_260_2 - 1 do
					local var_260_3 = var_260_0:GetChild(iter_260_0)

					if var_260_3.name == "split_2" or not string.find(var_260_3.name, "split") then
						var_260_3.gameObject:SetActive(true)
					else
						var_260_3.gameObject:SetActive(false)
					end
				end
			end

			local var_260_4 = 0.001

			if var_260_1 <= arg_257_1.time_ and arg_257_1.time_ < var_260_1 + var_260_4 then
				local var_260_5 = (arg_257_1.time_ - var_260_1) / var_260_4
				local var_260_6 = Vector3.New(0, -300, -295)

				var_260_0.localPosition = Vector3.Lerp(arg_257_1.var_.moveOldPos10092, var_260_6, var_260_5)
			end

			if arg_257_1.time_ >= var_260_1 + var_260_4 and arg_257_1.time_ < var_260_1 + var_260_4 + arg_260_0 then
				var_260_0.localPosition = Vector3.New(0, -300, -295)
			end

			local var_260_7 = 0
			local var_260_8 = 0.775

			if var_260_7 < arg_257_1.time_ and arg_257_1.time_ <= var_260_7 + arg_260_0 then
				arg_257_1.talkMaxDuration = 0
				arg_257_1.dialogCg_.alpha = 1

				arg_257_1.dialog_:SetActive(true)
				SetActive(arg_257_1.leftNameGo_, true)

				local var_260_9 = arg_257_1:FormatText(StoryNameCfg[996].name)

				arg_257_1.leftNameTxt_.text = var_260_9

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_257_1.leftNameTxt_.transform)

				arg_257_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_257_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_257_1:RecordName(arg_257_1.leftNameTxt_.text)
				SetActive(arg_257_1.iconTrs_.gameObject, false)
				arg_257_1.callingController_:SetSelectedState("normal")

				local var_260_10 = arg_257_1:GetWordFromCfg(413072061)
				local var_260_11 = arg_257_1:FormatText(var_260_10.content)

				arg_257_1.text_.text = var_260_11

				LuaForUtil.ClearLinePrefixSymbol(arg_257_1.text_)

				local var_260_12 = 31
				local var_260_13 = utf8.len(var_260_11)
				local var_260_14 = var_260_12 <= 0 and var_260_8 or var_260_8 * (var_260_13 / var_260_12)

				if var_260_14 > 0 and var_260_8 < var_260_14 then
					arg_257_1.talkMaxDuration = var_260_14

					if var_260_14 + var_260_7 > arg_257_1.duration_ then
						arg_257_1.duration_ = var_260_14 + var_260_7
					end
				end

				arg_257_1.text_.text = var_260_11
				arg_257_1.typewritter.percent = 0

				arg_257_1.typewritter:SetDirty()
				arg_257_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_413072", "413072061", "story_v_out_413072.awb") ~= 0 then
					local var_260_15 = manager.audio:GetVoiceLength("story_v_out_413072", "413072061", "story_v_out_413072.awb") / 1000

					if var_260_15 + var_260_7 > arg_257_1.duration_ then
						arg_257_1.duration_ = var_260_15 + var_260_7
					end

					if var_260_10.prefab_name ~= "" and arg_257_1.actors_[var_260_10.prefab_name] ~= nil then
						local var_260_16 = LuaForUtil.PlayVoiceWithCriLipsync(arg_257_1.actors_[var_260_10.prefab_name].transform, "story_v_out_413072", "413072061", "story_v_out_413072.awb")

						arg_257_1:RecordAudio("413072061", var_260_16)
						arg_257_1:RecordAudio("413072061", var_260_16)
					else
						arg_257_1:AudioAction("play", "voice", "story_v_out_413072", "413072061", "story_v_out_413072.awb")
					end

					arg_257_1:RecordHistoryTalkVoice("story_v_out_413072", "413072061", "story_v_out_413072.awb")
				end

				arg_257_1:RecordContent(arg_257_1.text_.text)
			end

			local var_260_17 = math.max(var_260_8, arg_257_1.talkMaxDuration)

			if var_260_7 <= arg_257_1.time_ and arg_257_1.time_ < var_260_7 + var_260_17 then
				arg_257_1.typewritter.percent = (arg_257_1.time_ - var_260_7) / var_260_17

				arg_257_1.typewritter:SetDirty()
			end

			if arg_257_1.time_ >= var_260_7 + var_260_17 and arg_257_1.time_ < var_260_7 + var_260_17 + arg_260_0 then
				arg_257_1.typewritter.percent = 1

				arg_257_1.typewritter:SetDirty()
				arg_257_1:ShowNextGo(true)
			end
		end

		arg_257_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10092",
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
	Play413072062 = function(arg_261_0, arg_261_1)
		arg_261_1.time_ = 0
		arg_261_1.frameCnt_ = 0
		arg_261_1.state_ = "playing"
		arg_261_1.curTalkId_ = 413072062
		arg_261_1.duration_ = 5

		SetActive(arg_261_1.tipsGo_, false)

		function arg_261_1.onSingleLineFinish_()
			arg_261_1.onSingleLineUpdate_ = nil
			arg_261_1.onSingleLineFinish_ = nil
			arg_261_1.state_ = "waiting"
		end

		function arg_261_1.playNext_(arg_263_0)
			if arg_263_0 == 1 then
				arg_261_0:Play413072063(arg_261_1)
			end
		end

		function arg_261_1.onSingleLineUpdate_(arg_264_0)
			local var_264_0 = arg_261_1.actors_["10092"].transform
			local var_264_1 = 0

			if var_264_1 < arg_261_1.time_ and arg_261_1.time_ <= var_264_1 + arg_264_0 then
				arg_261_1.var_.moveOldPos10092 = var_264_0.localPosition
				var_264_0.localScale = Vector3.New(1, 1, 1)

				arg_261_1:CheckSpriteTmpPos("10092", 0)

				local var_264_2 = var_264_0.childCount

				for iter_264_0 = 0, var_264_2 - 1 do
					local var_264_3 = var_264_0:GetChild(iter_264_0)

					if var_264_3.name == "" or not string.find(var_264_3.name, "split") then
						var_264_3.gameObject:SetActive(true)
					else
						var_264_3.gameObject:SetActive(false)
					end
				end
			end

			local var_264_4 = 0.001

			if var_264_1 <= arg_261_1.time_ and arg_261_1.time_ < var_264_1 + var_264_4 then
				local var_264_5 = (arg_261_1.time_ - var_264_1) / var_264_4
				local var_264_6 = Vector3.New(-5000, -315, -320)

				var_264_0.localPosition = Vector3.Lerp(arg_261_1.var_.moveOldPos10092, var_264_6, var_264_5)
			end

			if arg_261_1.time_ >= var_264_1 + var_264_4 and arg_261_1.time_ < var_264_1 + var_264_4 + arg_264_0 then
				var_264_0.localPosition = Vector3.New(-5000, -315, -320)
			end

			local var_264_7 = arg_261_1.actors_["10092"]
			local var_264_8 = 0

			if var_264_8 < arg_261_1.time_ and arg_261_1.time_ <= var_264_8 + arg_264_0 and not isNil(var_264_7) and arg_261_1.var_.actorSpriteComps10092 == nil then
				arg_261_1.var_.actorSpriteComps10092 = var_264_7:GetComponentsInChildren(typeof(Image), true)
			end

			local var_264_9 = 2

			if var_264_8 <= arg_261_1.time_ and arg_261_1.time_ < var_264_8 + var_264_9 and not isNil(var_264_7) then
				local var_264_10 = (arg_261_1.time_ - var_264_8) / var_264_9

				if arg_261_1.var_.actorSpriteComps10092 then
					for iter_264_1, iter_264_2 in pairs(arg_261_1.var_.actorSpriteComps10092:ToTable()) do
						if iter_264_2 then
							if arg_261_1.isInRecall_ then
								local var_264_11 = Mathf.Lerp(iter_264_2.color.r, arg_261_1.hightColor2.r, var_264_10)
								local var_264_12 = Mathf.Lerp(iter_264_2.color.g, arg_261_1.hightColor2.g, var_264_10)
								local var_264_13 = Mathf.Lerp(iter_264_2.color.b, arg_261_1.hightColor2.b, var_264_10)

								iter_264_2.color = Color.New(var_264_11, var_264_12, var_264_13)
							else
								local var_264_14 = Mathf.Lerp(iter_264_2.color.r, 0.5, var_264_10)

								iter_264_2.color = Color.New(var_264_14, var_264_14, var_264_14)
							end
						end
					end
				end
			end

			if arg_261_1.time_ >= var_264_8 + var_264_9 and arg_261_1.time_ < var_264_8 + var_264_9 + arg_264_0 and not isNil(var_264_7) and arg_261_1.var_.actorSpriteComps10092 then
				for iter_264_3, iter_264_4 in pairs(arg_261_1.var_.actorSpriteComps10092:ToTable()) do
					if iter_264_4 then
						if arg_261_1.isInRecall_ then
							iter_264_4.color = arg_261_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_264_4.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_261_1.var_.actorSpriteComps10092 = nil
			end

			local var_264_15 = 0
			local var_264_16 = 1.7

			if var_264_15 < arg_261_1.time_ and arg_261_1.time_ <= var_264_15 + arg_264_0 then
				arg_261_1.talkMaxDuration = 0
				arg_261_1.dialogCg_.alpha = 1

				arg_261_1.dialog_:SetActive(true)
				SetActive(arg_261_1.leftNameGo_, false)

				arg_261_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_261_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_261_1:RecordName(arg_261_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_261_1.iconTrs_.gameObject, false)
				arg_261_1.callingController_:SetSelectedState("normal")

				local var_264_17 = arg_261_1:GetWordFromCfg(413072062)
				local var_264_18 = arg_261_1:FormatText(var_264_17.content)

				arg_261_1.text_.text = var_264_18

				LuaForUtil.ClearLinePrefixSymbol(arg_261_1.text_)

				local var_264_19 = 68
				local var_264_20 = utf8.len(var_264_18)
				local var_264_21 = var_264_19 <= 0 and var_264_16 or var_264_16 * (var_264_20 / var_264_19)

				if var_264_21 > 0 and var_264_16 < var_264_21 then
					arg_261_1.talkMaxDuration = var_264_21

					if var_264_21 + var_264_15 > arg_261_1.duration_ then
						arg_261_1.duration_ = var_264_21 + var_264_15
					end
				end

				arg_261_1.text_.text = var_264_18
				arg_261_1.typewritter.percent = 0

				arg_261_1.typewritter:SetDirty()
				arg_261_1:ShowNextGo(false)
				arg_261_1:RecordContent(arg_261_1.text_.text)
			end

			local var_264_22 = math.max(var_264_16, arg_261_1.talkMaxDuration)

			if var_264_15 <= arg_261_1.time_ and arg_261_1.time_ < var_264_15 + var_264_22 then
				arg_261_1.typewritter.percent = (arg_261_1.time_ - var_264_15) / var_264_22

				arg_261_1.typewritter:SetDirty()
			end

			if arg_261_1.time_ >= var_264_15 + var_264_22 and arg_261_1.time_ < var_264_15 + var_264_22 + arg_264_0 then
				arg_261_1.typewritter.percent = 1

				arg_261_1.typewritter:SetDirty()
				arg_261_1:ShowNextGo(true)
			end
		end

		arg_261_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10092",
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
	Play413072063 = function(arg_265_0, arg_265_1)
		arg_265_1.time_ = 0
		arg_265_1.frameCnt_ = 0
		arg_265_1.state_ = "playing"
		arg_265_1.curTalkId_ = 413072063
		arg_265_1.duration_ = 5

		SetActive(arg_265_1.tipsGo_, false)

		function arg_265_1.onSingleLineFinish_()
			arg_265_1.onSingleLineUpdate_ = nil
			arg_265_1.onSingleLineFinish_ = nil
			arg_265_1.state_ = "waiting"
		end

		function arg_265_1.playNext_(arg_267_0)
			if arg_267_0 == 1 then
				arg_265_0:Play413072064(arg_265_1)
			end
		end

		function arg_265_1.onSingleLineUpdate_(arg_268_0)
			local var_268_0 = 0
			local var_268_1 = 1.425

			if var_268_0 < arg_265_1.time_ and arg_265_1.time_ <= var_268_0 + arg_268_0 then
				arg_265_1.talkMaxDuration = 0
				arg_265_1.dialogCg_.alpha = 1

				arg_265_1.dialog_:SetActive(true)
				SetActive(arg_265_1.leftNameGo_, false)

				arg_265_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_265_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_265_1:RecordName(arg_265_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_265_1.iconTrs_.gameObject, false)
				arg_265_1.callingController_:SetSelectedState("normal")

				local var_268_2 = arg_265_1:GetWordFromCfg(413072063)
				local var_268_3 = arg_265_1:FormatText(var_268_2.content)

				arg_265_1.text_.text = var_268_3

				LuaForUtil.ClearLinePrefixSymbol(arg_265_1.text_)

				local var_268_4 = 57
				local var_268_5 = utf8.len(var_268_3)
				local var_268_6 = var_268_4 <= 0 and var_268_1 or var_268_1 * (var_268_5 / var_268_4)

				if var_268_6 > 0 and var_268_1 < var_268_6 then
					arg_265_1.talkMaxDuration = var_268_6

					if var_268_6 + var_268_0 > arg_265_1.duration_ then
						arg_265_1.duration_ = var_268_6 + var_268_0
					end
				end

				arg_265_1.text_.text = var_268_3
				arg_265_1.typewritter.percent = 0

				arg_265_1.typewritter:SetDirty()
				arg_265_1:ShowNextGo(false)
				arg_265_1:RecordContent(arg_265_1.text_.text)
			end

			local var_268_7 = math.max(var_268_1, arg_265_1.talkMaxDuration)

			if var_268_0 <= arg_265_1.time_ and arg_265_1.time_ < var_268_0 + var_268_7 then
				arg_265_1.typewritter.percent = (arg_265_1.time_ - var_268_0) / var_268_7

				arg_265_1.typewritter:SetDirty()
			end

			if arg_265_1.time_ >= var_268_0 + var_268_7 and arg_265_1.time_ < var_268_0 + var_268_7 + arg_268_0 then
				arg_265_1.typewritter.percent = 1

				arg_265_1.typewritter:SetDirty()
				arg_265_1:ShowNextGo(true)
			end
		end

		arg_265_1.nodeConfigList_ = {}

		arg_265_1:InitPlayNodeList()
	end,
	Play413072064 = function(arg_269_0, arg_269_1)
		arg_269_1.time_ = 0
		arg_269_1.frameCnt_ = 0
		arg_269_1.state_ = "playing"
		arg_269_1.curTalkId_ = 413072064
		arg_269_1.duration_ = 12.27

		local var_269_0 = {
			zh = 6.066,
			ja = 12.266
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
				arg_269_0:Play413072065(arg_269_1)
			end
		end

		function arg_269_1.onSingleLineUpdate_(arg_272_0)
			local var_272_0 = arg_269_1.actors_["10092"].transform
			local var_272_1 = 0

			if var_272_1 < arg_269_1.time_ and arg_269_1.time_ <= var_272_1 + arg_272_0 then
				arg_269_1.var_.moveOldPos10092 = var_272_0.localPosition
				var_272_0.localScale = Vector3.New(1, 1, 1)

				arg_269_1:CheckSpriteTmpPos("10092", 4)

				local var_272_2 = var_272_0.childCount

				for iter_272_0 = 0, var_272_2 - 1 do
					local var_272_3 = var_272_0:GetChild(iter_272_0)

					if var_272_3.name == "split_1_1" or not string.find(var_272_3.name, "split") then
						var_272_3.gameObject:SetActive(true)
					else
						var_272_3.gameObject:SetActive(false)
					end
				end
			end

			local var_272_4 = 0.001

			if var_272_1 <= arg_269_1.time_ and arg_269_1.time_ < var_272_1 + var_272_4 then
				local var_272_5 = (arg_269_1.time_ - var_272_1) / var_272_4
				local var_272_6 = Vector3.New(390, -300, -295)

				var_272_0.localPosition = Vector3.Lerp(arg_269_1.var_.moveOldPos10092, var_272_6, var_272_5)
			end

			if arg_269_1.time_ >= var_272_1 + var_272_4 and arg_269_1.time_ < var_272_1 + var_272_4 + arg_272_0 then
				var_272_0.localPosition = Vector3.New(390, -300, -295)
			end

			local var_272_7 = arg_269_1.actors_["10092"]
			local var_272_8 = 0

			if var_272_8 < arg_269_1.time_ and arg_269_1.time_ <= var_272_8 + arg_272_0 and not isNil(var_272_7) and arg_269_1.var_.actorSpriteComps10092 == nil then
				arg_269_1.var_.actorSpriteComps10092 = var_272_7:GetComponentsInChildren(typeof(Image), true)
			end

			local var_272_9 = 2

			if var_272_8 <= arg_269_1.time_ and arg_269_1.time_ < var_272_8 + var_272_9 and not isNil(var_272_7) then
				local var_272_10 = (arg_269_1.time_ - var_272_8) / var_272_9

				if arg_269_1.var_.actorSpriteComps10092 then
					for iter_272_1, iter_272_2 in pairs(arg_269_1.var_.actorSpriteComps10092:ToTable()) do
						if iter_272_2 then
							if arg_269_1.isInRecall_ then
								local var_272_11 = Mathf.Lerp(iter_272_2.color.r, arg_269_1.hightColor1.r, var_272_10)
								local var_272_12 = Mathf.Lerp(iter_272_2.color.g, arg_269_1.hightColor1.g, var_272_10)
								local var_272_13 = Mathf.Lerp(iter_272_2.color.b, arg_269_1.hightColor1.b, var_272_10)

								iter_272_2.color = Color.New(var_272_11, var_272_12, var_272_13)
							else
								local var_272_14 = Mathf.Lerp(iter_272_2.color.r, 1, var_272_10)

								iter_272_2.color = Color.New(var_272_14, var_272_14, var_272_14)
							end
						end
					end
				end
			end

			if arg_269_1.time_ >= var_272_8 + var_272_9 and arg_269_1.time_ < var_272_8 + var_272_9 + arg_272_0 and not isNil(var_272_7) and arg_269_1.var_.actorSpriteComps10092 then
				for iter_272_3, iter_272_4 in pairs(arg_269_1.var_.actorSpriteComps10092:ToTable()) do
					if iter_272_4 then
						if arg_269_1.isInRecall_ then
							iter_272_4.color = arg_269_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_272_4.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_269_1.var_.actorSpriteComps10092 = nil
			end

			local var_272_15 = 0
			local var_272_16 = 0.775

			if var_272_15 < arg_269_1.time_ and arg_269_1.time_ <= var_272_15 + arg_272_0 then
				arg_269_1.talkMaxDuration = 0
				arg_269_1.dialogCg_.alpha = 1

				arg_269_1.dialog_:SetActive(true)
				SetActive(arg_269_1.leftNameGo_, true)

				local var_272_17 = arg_269_1:FormatText(StoryNameCfg[996].name)

				arg_269_1.leftNameTxt_.text = var_272_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_269_1.leftNameTxt_.transform)

				arg_269_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_269_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_269_1:RecordName(arg_269_1.leftNameTxt_.text)
				SetActive(arg_269_1.iconTrs_.gameObject, false)
				arg_269_1.callingController_:SetSelectedState("normal")

				local var_272_18 = arg_269_1:GetWordFromCfg(413072064)
				local var_272_19 = arg_269_1:FormatText(var_272_18.content)

				arg_269_1.text_.text = var_272_19

				LuaForUtil.ClearLinePrefixSymbol(arg_269_1.text_)

				local var_272_20 = 31
				local var_272_21 = utf8.len(var_272_19)
				local var_272_22 = var_272_20 <= 0 and var_272_16 or var_272_16 * (var_272_21 / var_272_20)

				if var_272_22 > 0 and var_272_16 < var_272_22 then
					arg_269_1.talkMaxDuration = var_272_22

					if var_272_22 + var_272_15 > arg_269_1.duration_ then
						arg_269_1.duration_ = var_272_22 + var_272_15
					end
				end

				arg_269_1.text_.text = var_272_19
				arg_269_1.typewritter.percent = 0

				arg_269_1.typewritter:SetDirty()
				arg_269_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_413072", "413072064", "story_v_out_413072.awb") ~= 0 then
					local var_272_23 = manager.audio:GetVoiceLength("story_v_out_413072", "413072064", "story_v_out_413072.awb") / 1000

					if var_272_23 + var_272_15 > arg_269_1.duration_ then
						arg_269_1.duration_ = var_272_23 + var_272_15
					end

					if var_272_18.prefab_name ~= "" and arg_269_1.actors_[var_272_18.prefab_name] ~= nil then
						local var_272_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_269_1.actors_[var_272_18.prefab_name].transform, "story_v_out_413072", "413072064", "story_v_out_413072.awb")

						arg_269_1:RecordAudio("413072064", var_272_24)
						arg_269_1:RecordAudio("413072064", var_272_24)
					else
						arg_269_1:AudioAction("play", "voice", "story_v_out_413072", "413072064", "story_v_out_413072.awb")
					end

					arg_269_1:RecordHistoryTalkVoice("story_v_out_413072", "413072064", "story_v_out_413072.awb")
				end

				arg_269_1:RecordContent(arg_269_1.text_.text)
			end

			local var_272_25 = math.max(var_272_16, arg_269_1.talkMaxDuration)

			if var_272_15 <= arg_269_1.time_ and arg_269_1.time_ < var_272_15 + var_272_25 then
				arg_269_1.typewritter.percent = (arg_269_1.time_ - var_272_15) / var_272_25

				arg_269_1.typewritter:SetDirty()
			end

			if arg_269_1.time_ >= var_272_15 + var_272_25 and arg_269_1.time_ < var_272_15 + var_272_25 + arg_272_0 then
				arg_269_1.typewritter.percent = 1

				arg_269_1.typewritter:SetDirty()
				arg_269_1:ShowNextGo(true)
			end
		end

		arg_269_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10092",
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
	Play413072065 = function(arg_273_0, arg_273_1)
		arg_273_1.time_ = 0
		arg_273_1.frameCnt_ = 0
		arg_273_1.state_ = "playing"
		arg_273_1.curTalkId_ = 413072065
		arg_273_1.duration_ = 2.83

		local var_273_0 = {
			zh = 2.266,
			ja = 2.833
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
				arg_273_0:Play413072066(arg_273_1)
			end
		end

		function arg_273_1.onSingleLineUpdate_(arg_276_0)
			local var_276_0 = arg_273_1.actors_["10094"].transform
			local var_276_1 = 0

			if var_276_1 < arg_273_1.time_ and arg_273_1.time_ <= var_276_1 + arg_276_0 then
				arg_273_1.var_.moveOldPos10094 = var_276_0.localPosition
				var_276_0.localScale = Vector3.New(1, 1, 1)

				arg_273_1:CheckSpriteTmpPos("10094", 2)

				local var_276_2 = var_276_0.childCount

				for iter_276_0 = 0, var_276_2 - 1 do
					local var_276_3 = var_276_0:GetChild(iter_276_0)

					if var_276_3.name == "" or not string.find(var_276_3.name, "split") then
						var_276_3.gameObject:SetActive(true)
					else
						var_276_3.gameObject:SetActive(false)
					end
				end
			end

			local var_276_4 = 0.001

			if var_276_1 <= arg_273_1.time_ and arg_273_1.time_ < var_276_1 + var_276_4 then
				local var_276_5 = (arg_273_1.time_ - var_276_1) / var_276_4
				local var_276_6 = Vector3.New(-390, -340, -414)

				var_276_0.localPosition = Vector3.Lerp(arg_273_1.var_.moveOldPos10094, var_276_6, var_276_5)
			end

			if arg_273_1.time_ >= var_276_1 + var_276_4 and arg_273_1.time_ < var_276_1 + var_276_4 + arg_276_0 then
				var_276_0.localPosition = Vector3.New(-390, -340, -414)
			end

			local var_276_7 = arg_273_1.actors_["10092"]
			local var_276_8 = 0

			if var_276_8 < arg_273_1.time_ and arg_273_1.time_ <= var_276_8 + arg_276_0 and not isNil(var_276_7) and arg_273_1.var_.actorSpriteComps10092 == nil then
				arg_273_1.var_.actorSpriteComps10092 = var_276_7:GetComponentsInChildren(typeof(Image), true)
			end

			local var_276_9 = 2

			if var_276_8 <= arg_273_1.time_ and arg_273_1.time_ < var_276_8 + var_276_9 and not isNil(var_276_7) then
				local var_276_10 = (arg_273_1.time_ - var_276_8) / var_276_9

				if arg_273_1.var_.actorSpriteComps10092 then
					for iter_276_1, iter_276_2 in pairs(arg_273_1.var_.actorSpriteComps10092:ToTable()) do
						if iter_276_2 then
							if arg_273_1.isInRecall_ then
								local var_276_11 = Mathf.Lerp(iter_276_2.color.r, arg_273_1.hightColor2.r, var_276_10)
								local var_276_12 = Mathf.Lerp(iter_276_2.color.g, arg_273_1.hightColor2.g, var_276_10)
								local var_276_13 = Mathf.Lerp(iter_276_2.color.b, arg_273_1.hightColor2.b, var_276_10)

								iter_276_2.color = Color.New(var_276_11, var_276_12, var_276_13)
							else
								local var_276_14 = Mathf.Lerp(iter_276_2.color.r, 0.5, var_276_10)

								iter_276_2.color = Color.New(var_276_14, var_276_14, var_276_14)
							end
						end
					end
				end
			end

			if arg_273_1.time_ >= var_276_8 + var_276_9 and arg_273_1.time_ < var_276_8 + var_276_9 + arg_276_0 and not isNil(var_276_7) and arg_273_1.var_.actorSpriteComps10092 then
				for iter_276_3, iter_276_4 in pairs(arg_273_1.var_.actorSpriteComps10092:ToTable()) do
					if iter_276_4 then
						if arg_273_1.isInRecall_ then
							iter_276_4.color = arg_273_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_276_4.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_273_1.var_.actorSpriteComps10092 = nil
			end

			local var_276_15 = arg_273_1.actors_["10094"]
			local var_276_16 = 0

			if var_276_16 < arg_273_1.time_ and arg_273_1.time_ <= var_276_16 + arg_276_0 and not isNil(var_276_15) and arg_273_1.var_.actorSpriteComps10094 == nil then
				arg_273_1.var_.actorSpriteComps10094 = var_276_15:GetComponentsInChildren(typeof(Image), true)
			end

			local var_276_17 = 2

			if var_276_16 <= arg_273_1.time_ and arg_273_1.time_ < var_276_16 + var_276_17 and not isNil(var_276_15) then
				local var_276_18 = (arg_273_1.time_ - var_276_16) / var_276_17

				if arg_273_1.var_.actorSpriteComps10094 then
					for iter_276_5, iter_276_6 in pairs(arg_273_1.var_.actorSpriteComps10094:ToTable()) do
						if iter_276_6 then
							if arg_273_1.isInRecall_ then
								local var_276_19 = Mathf.Lerp(iter_276_6.color.r, arg_273_1.hightColor1.r, var_276_18)
								local var_276_20 = Mathf.Lerp(iter_276_6.color.g, arg_273_1.hightColor1.g, var_276_18)
								local var_276_21 = Mathf.Lerp(iter_276_6.color.b, arg_273_1.hightColor1.b, var_276_18)

								iter_276_6.color = Color.New(var_276_19, var_276_20, var_276_21)
							else
								local var_276_22 = Mathf.Lerp(iter_276_6.color.r, 1, var_276_18)

								iter_276_6.color = Color.New(var_276_22, var_276_22, var_276_22)
							end
						end
					end
				end
			end

			if arg_273_1.time_ >= var_276_16 + var_276_17 and arg_273_1.time_ < var_276_16 + var_276_17 + arg_276_0 and not isNil(var_276_15) and arg_273_1.var_.actorSpriteComps10094 then
				for iter_276_7, iter_276_8 in pairs(arg_273_1.var_.actorSpriteComps10094:ToTable()) do
					if iter_276_8 then
						if arg_273_1.isInRecall_ then
							iter_276_8.color = arg_273_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_276_8.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_273_1.var_.actorSpriteComps10094 = nil
			end

			local var_276_23 = 0
			local var_276_24 = 0.275

			if var_276_23 < arg_273_1.time_ and arg_273_1.time_ <= var_276_23 + arg_276_0 then
				arg_273_1.talkMaxDuration = 0
				arg_273_1.dialogCg_.alpha = 1

				arg_273_1.dialog_:SetActive(true)
				SetActive(arg_273_1.leftNameGo_, true)

				local var_276_25 = arg_273_1:FormatText(StoryNameCfg[259].name)

				arg_273_1.leftNameTxt_.text = var_276_25

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_273_1.leftNameTxt_.transform)

				arg_273_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_273_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_273_1:RecordName(arg_273_1.leftNameTxt_.text)
				SetActive(arg_273_1.iconTrs_.gameObject, false)
				arg_273_1.callingController_:SetSelectedState("normal")

				local var_276_26 = arg_273_1:GetWordFromCfg(413072065)
				local var_276_27 = arg_273_1:FormatText(var_276_26.content)

				arg_273_1.text_.text = var_276_27

				LuaForUtil.ClearLinePrefixSymbol(arg_273_1.text_)

				local var_276_28 = 11
				local var_276_29 = utf8.len(var_276_27)
				local var_276_30 = var_276_28 <= 0 and var_276_24 or var_276_24 * (var_276_29 / var_276_28)

				if var_276_30 > 0 and var_276_24 < var_276_30 then
					arg_273_1.talkMaxDuration = var_276_30

					if var_276_30 + var_276_23 > arg_273_1.duration_ then
						arg_273_1.duration_ = var_276_30 + var_276_23
					end
				end

				arg_273_1.text_.text = var_276_27
				arg_273_1.typewritter.percent = 0

				arg_273_1.typewritter:SetDirty()
				arg_273_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_413072", "413072065", "story_v_out_413072.awb") ~= 0 then
					local var_276_31 = manager.audio:GetVoiceLength("story_v_out_413072", "413072065", "story_v_out_413072.awb") / 1000

					if var_276_31 + var_276_23 > arg_273_1.duration_ then
						arg_273_1.duration_ = var_276_31 + var_276_23
					end

					if var_276_26.prefab_name ~= "" and arg_273_1.actors_[var_276_26.prefab_name] ~= nil then
						local var_276_32 = LuaForUtil.PlayVoiceWithCriLipsync(arg_273_1.actors_[var_276_26.prefab_name].transform, "story_v_out_413072", "413072065", "story_v_out_413072.awb")

						arg_273_1:RecordAudio("413072065", var_276_32)
						arg_273_1:RecordAudio("413072065", var_276_32)
					else
						arg_273_1:AudioAction("play", "voice", "story_v_out_413072", "413072065", "story_v_out_413072.awb")
					end

					arg_273_1:RecordHistoryTalkVoice("story_v_out_413072", "413072065", "story_v_out_413072.awb")
				end

				arg_273_1:RecordContent(arg_273_1.text_.text)
			end

			local var_276_33 = math.max(var_276_24, arg_273_1.talkMaxDuration)

			if var_276_23 <= arg_273_1.time_ and arg_273_1.time_ < var_276_23 + var_276_33 then
				arg_273_1.typewritter.percent = (arg_273_1.time_ - var_276_23) / var_276_33

				arg_273_1.typewritter:SetDirty()
			end

			if arg_273_1.time_ >= var_276_23 + var_276_33 and arg_273_1.time_ < var_276_23 + var_276_33 + arg_276_0 then
				arg_273_1.typewritter.percent = 1

				arg_273_1.typewritter:SetDirty()
				arg_273_1:ShowNextGo(true)
			end
		end

		arg_273_1.nodeConfigList_ = {
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

		arg_273_1:InitPlayNodeList()
	end,
	Play413072066 = function(arg_277_0, arg_277_1)
		arg_277_1.time_ = 0
		arg_277_1.frameCnt_ = 0
		arg_277_1.state_ = "playing"
		arg_277_1.curTalkId_ = 413072066
		arg_277_1.duration_ = 9.33

		local var_277_0 = {
			zh = 5.8,
			ja = 9.333
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
				arg_277_0:Play413072067(arg_277_1)
			end
		end

		function arg_277_1.onSingleLineUpdate_(arg_280_0)
			local var_280_0 = arg_277_1.actors_["10092"]
			local var_280_1 = 0

			if var_280_1 < arg_277_1.time_ and arg_277_1.time_ <= var_280_1 + arg_280_0 and not isNil(var_280_0) and arg_277_1.var_.actorSpriteComps10092 == nil then
				arg_277_1.var_.actorSpriteComps10092 = var_280_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_280_2 = 2

			if var_280_1 <= arg_277_1.time_ and arg_277_1.time_ < var_280_1 + var_280_2 and not isNil(var_280_0) then
				local var_280_3 = (arg_277_1.time_ - var_280_1) / var_280_2

				if arg_277_1.var_.actorSpriteComps10092 then
					for iter_280_0, iter_280_1 in pairs(arg_277_1.var_.actorSpriteComps10092:ToTable()) do
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

			if arg_277_1.time_ >= var_280_1 + var_280_2 and arg_277_1.time_ < var_280_1 + var_280_2 + arg_280_0 and not isNil(var_280_0) and arg_277_1.var_.actorSpriteComps10092 then
				for iter_280_2, iter_280_3 in pairs(arg_277_1.var_.actorSpriteComps10092:ToTable()) do
					if iter_280_3 then
						if arg_277_1.isInRecall_ then
							iter_280_3.color = arg_277_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_280_3.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_277_1.var_.actorSpriteComps10092 = nil
			end

			local var_280_8 = arg_277_1.actors_["10094"]
			local var_280_9 = 0

			if var_280_9 < arg_277_1.time_ and arg_277_1.time_ <= var_280_9 + arg_280_0 and not isNil(var_280_8) and arg_277_1.var_.actorSpriteComps10094 == nil then
				arg_277_1.var_.actorSpriteComps10094 = var_280_8:GetComponentsInChildren(typeof(Image), true)
			end

			local var_280_10 = 2

			if var_280_9 <= arg_277_1.time_ and arg_277_1.time_ < var_280_9 + var_280_10 and not isNil(var_280_8) then
				local var_280_11 = (arg_277_1.time_ - var_280_9) / var_280_10

				if arg_277_1.var_.actorSpriteComps10094 then
					for iter_280_4, iter_280_5 in pairs(arg_277_1.var_.actorSpriteComps10094:ToTable()) do
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

			if arg_277_1.time_ >= var_280_9 + var_280_10 and arg_277_1.time_ < var_280_9 + var_280_10 + arg_280_0 and not isNil(var_280_8) and arg_277_1.var_.actorSpriteComps10094 then
				for iter_280_6, iter_280_7 in pairs(arg_277_1.var_.actorSpriteComps10094:ToTable()) do
					if iter_280_7 then
						if arg_277_1.isInRecall_ then
							iter_280_7.color = arg_277_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_280_7.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_277_1.var_.actorSpriteComps10094 = nil
			end

			local var_280_16 = 0
			local var_280_17 = 0.8

			if var_280_16 < arg_277_1.time_ and arg_277_1.time_ <= var_280_16 + arg_280_0 then
				arg_277_1.talkMaxDuration = 0
				arg_277_1.dialogCg_.alpha = 1

				arg_277_1.dialog_:SetActive(true)
				SetActive(arg_277_1.leftNameGo_, true)

				local var_280_18 = arg_277_1:FormatText(StoryNameCfg[996].name)

				arg_277_1.leftNameTxt_.text = var_280_18

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_277_1.leftNameTxt_.transform)

				arg_277_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_277_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_277_1:RecordName(arg_277_1.leftNameTxt_.text)
				SetActive(arg_277_1.iconTrs_.gameObject, false)
				arg_277_1.callingController_:SetSelectedState("normal")

				local var_280_19 = arg_277_1:GetWordFromCfg(413072066)
				local var_280_20 = arg_277_1:FormatText(var_280_19.content)

				arg_277_1.text_.text = var_280_20

				LuaForUtil.ClearLinePrefixSymbol(arg_277_1.text_)

				local var_280_21 = 32
				local var_280_22 = utf8.len(var_280_20)
				local var_280_23 = var_280_21 <= 0 and var_280_17 or var_280_17 * (var_280_22 / var_280_21)

				if var_280_23 > 0 and var_280_17 < var_280_23 then
					arg_277_1.talkMaxDuration = var_280_23

					if var_280_23 + var_280_16 > arg_277_1.duration_ then
						arg_277_1.duration_ = var_280_23 + var_280_16
					end
				end

				arg_277_1.text_.text = var_280_20
				arg_277_1.typewritter.percent = 0

				arg_277_1.typewritter:SetDirty()
				arg_277_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_413072", "413072066", "story_v_out_413072.awb") ~= 0 then
					local var_280_24 = manager.audio:GetVoiceLength("story_v_out_413072", "413072066", "story_v_out_413072.awb") / 1000

					if var_280_24 + var_280_16 > arg_277_1.duration_ then
						arg_277_1.duration_ = var_280_24 + var_280_16
					end

					if var_280_19.prefab_name ~= "" and arg_277_1.actors_[var_280_19.prefab_name] ~= nil then
						local var_280_25 = LuaForUtil.PlayVoiceWithCriLipsync(arg_277_1.actors_[var_280_19.prefab_name].transform, "story_v_out_413072", "413072066", "story_v_out_413072.awb")

						arg_277_1:RecordAudio("413072066", var_280_25)
						arg_277_1:RecordAudio("413072066", var_280_25)
					else
						arg_277_1:AudioAction("play", "voice", "story_v_out_413072", "413072066", "story_v_out_413072.awb")
					end

					arg_277_1:RecordHistoryTalkVoice("story_v_out_413072", "413072066", "story_v_out_413072.awb")
				end

				arg_277_1:RecordContent(arg_277_1.text_.text)
			end

			local var_280_26 = math.max(var_280_17, arg_277_1.talkMaxDuration)

			if var_280_16 <= arg_277_1.time_ and arg_277_1.time_ < var_280_16 + var_280_26 then
				arg_277_1.typewritter.percent = (arg_277_1.time_ - var_280_16) / var_280_26

				arg_277_1.typewritter:SetDirty()
			end

			if arg_277_1.time_ >= var_280_16 + var_280_26 and arg_277_1.time_ < var_280_16 + var_280_26 + arg_280_0 then
				arg_277_1.typewritter.percent = 1

				arg_277_1.typewritter:SetDirty()
				arg_277_1:ShowNextGo(true)
			end
		end

		arg_277_1.nodeConfigList_ = {}

		arg_277_1:InitPlayNodeList()
	end,
	Play413072067 = function(arg_281_0, arg_281_1)
		arg_281_1.time_ = 0
		arg_281_1.frameCnt_ = 0
		arg_281_1.state_ = "playing"
		arg_281_1.curTalkId_ = 413072067
		arg_281_1.duration_ = 5.23

		local var_281_0 = {
			zh = 4.066,
			ja = 5.233
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
			arg_281_1.auto_ = false
		end

		function arg_281_1.playNext_(arg_283_0)
			arg_281_1.onStoryFinished_()
		end

		function arg_281_1.onSingleLineUpdate_(arg_284_0)
			local var_284_0 = 0
			local var_284_1 = 0.35

			if var_284_0 < arg_281_1.time_ and arg_281_1.time_ <= var_284_0 + arg_284_0 then
				arg_281_1.talkMaxDuration = 0
				arg_281_1.dialogCg_.alpha = 1

				arg_281_1.dialog_:SetActive(true)
				SetActive(arg_281_1.leftNameGo_, true)

				local var_284_2 = arg_281_1:FormatText(StoryNameCfg[996].name)

				arg_281_1.leftNameTxt_.text = var_284_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_281_1.leftNameTxt_.transform)

				arg_281_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_281_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_281_1:RecordName(arg_281_1.leftNameTxt_.text)
				SetActive(arg_281_1.iconTrs_.gameObject, false)
				arg_281_1.callingController_:SetSelectedState("normal")

				local var_284_3 = arg_281_1:GetWordFromCfg(413072067)
				local var_284_4 = arg_281_1:FormatText(var_284_3.content)

				arg_281_1.text_.text = var_284_4

				LuaForUtil.ClearLinePrefixSymbol(arg_281_1.text_)

				local var_284_5 = 14
				local var_284_6 = utf8.len(var_284_4)
				local var_284_7 = var_284_5 <= 0 and var_284_1 or var_284_1 * (var_284_6 / var_284_5)

				if var_284_7 > 0 and var_284_1 < var_284_7 then
					arg_281_1.talkMaxDuration = var_284_7

					if var_284_7 + var_284_0 > arg_281_1.duration_ then
						arg_281_1.duration_ = var_284_7 + var_284_0
					end
				end

				arg_281_1.text_.text = var_284_4
				arg_281_1.typewritter.percent = 0

				arg_281_1.typewritter:SetDirty()
				arg_281_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_413072", "413072067", "story_v_out_413072.awb") ~= 0 then
					local var_284_8 = manager.audio:GetVoiceLength("story_v_out_413072", "413072067", "story_v_out_413072.awb") / 1000

					if var_284_8 + var_284_0 > arg_281_1.duration_ then
						arg_281_1.duration_ = var_284_8 + var_284_0
					end

					if var_284_3.prefab_name ~= "" and arg_281_1.actors_[var_284_3.prefab_name] ~= nil then
						local var_284_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_281_1.actors_[var_284_3.prefab_name].transform, "story_v_out_413072", "413072067", "story_v_out_413072.awb")

						arg_281_1:RecordAudio("413072067", var_284_9)
						arg_281_1:RecordAudio("413072067", var_284_9)
					else
						arg_281_1:AudioAction("play", "voice", "story_v_out_413072", "413072067", "story_v_out_413072.awb")
					end

					arg_281_1:RecordHistoryTalkVoice("story_v_out_413072", "413072067", "story_v_out_413072.awb")
				end

				arg_281_1:RecordContent(arg_281_1.text_.text)
			end

			local var_284_10 = math.max(var_284_1, arg_281_1.talkMaxDuration)

			if var_284_0 <= arg_281_1.time_ and arg_281_1.time_ < var_284_0 + var_284_10 then
				arg_281_1.typewritter.percent = (arg_281_1.time_ - var_284_0) / var_284_10

				arg_281_1.typewritter:SetDirty()
			end

			if arg_281_1.time_ >= var_284_0 + var_284_10 and arg_281_1.time_ < var_284_0 + var_284_10 + arg_284_0 then
				arg_281_1.typewritter.percent = 1

				arg_281_1.typewritter:SetDirty()
				arg_281_1:ShowNextGo(true)
			end
		end

		arg_281_1.nodeConfigList_ = {}

		arg_281_1:InitPlayNodeList()
	end,
	assets = {
		"TextureConfig/Background/F08g",
		"TextureConfig/Background/F08i",
		"TextureConfig/Background/F10g"
	},
	voices = {
		"story_v_out_413072.awb"
	}
}
