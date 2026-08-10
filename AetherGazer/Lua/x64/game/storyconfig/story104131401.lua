return {
	Play413141001 = function(arg_1_0, arg_1_1)
		arg_1_1.time_ = 0
		arg_1_1.frameCnt_ = 0
		arg_1_1.state_ = "playing"
		arg_1_1.curTalkId_ = 413141001
		arg_1_1.duration_ = 5.2

		local var_1_0 = {
			zh = 4.633,
			ja = 5.2
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
				arg_1_0:Play413141002(arg_1_1)
			end
		end

		function arg_1_1.onSingleLineUpdate_(arg_4_0)
			local var_4_0 = "ST0603a"

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
				local var_4_5 = arg_1_1.bgs_.ST0603a

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
					if iter_4_0 ~= "ST0603a" then
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

			local var_4_24 = "10093"

			if arg_1_1.actors_[var_4_24] == nil then
				local var_4_25 = Asset.Load("Widget/System/Story/StoryExpression/" .. "10093")

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

			local var_4_28 = arg_1_1.actors_["10093"].transform
			local var_4_29 = 1.73333333333333

			if var_4_29 < arg_1_1.time_ and arg_1_1.time_ <= var_4_29 + arg_4_0 then
				arg_1_1.var_.moveOldPos10093 = var_4_28.localPosition
				var_4_28.localScale = Vector3.New(1, 1, 1)

				arg_1_1:CheckSpriteTmpPos("10093", 3)

				local var_4_30 = var_4_28.childCount

				for iter_4_4 = 0, var_4_30 - 1 do
					local var_4_31 = var_4_28:GetChild(iter_4_4)

					if var_4_31.name == "split_4" or not string.find(var_4_31.name, "split") then
						var_4_31.gameObject:SetActive(true)
					else
						var_4_31.gameObject:SetActive(false)
					end
				end
			end

			local var_4_32 = 0.001

			if var_4_29 <= arg_1_1.time_ and arg_1_1.time_ < var_4_29 + var_4_32 then
				local var_4_33 = (arg_1_1.time_ - var_4_29) / var_4_32
				local var_4_34 = Vector3.New(0, -345, -245)

				var_4_28.localPosition = Vector3.Lerp(arg_1_1.var_.moveOldPos10093, var_4_34, var_4_33)
			end

			if arg_1_1.time_ >= var_4_29 + var_4_32 and arg_1_1.time_ < var_4_29 + var_4_32 + arg_4_0 then
				var_4_28.localPosition = Vector3.New(0, -345, -245)
			end

			local var_4_35 = arg_1_1.actors_["10093"]
			local var_4_36 = 1.73333333333333

			if var_4_36 < arg_1_1.time_ and arg_1_1.time_ <= var_4_36 + arg_4_0 and not isNil(var_4_35) and arg_1_1.var_.actorSpriteComps10093 == nil then
				arg_1_1.var_.actorSpriteComps10093 = var_4_35:GetComponentsInChildren(typeof(Image), true)
			end

			local var_4_37 = 2

			if var_4_36 <= arg_1_1.time_ and arg_1_1.time_ < var_4_36 + var_4_37 and not isNil(var_4_35) then
				local var_4_38 = (arg_1_1.time_ - var_4_36) / var_4_37

				if arg_1_1.var_.actorSpriteComps10093 then
					for iter_4_5, iter_4_6 in pairs(arg_1_1.var_.actorSpriteComps10093:ToTable()) do
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

			if arg_1_1.time_ >= var_4_36 + var_4_37 and arg_1_1.time_ < var_4_36 + var_4_37 + arg_4_0 and not isNil(var_4_35) and arg_1_1.var_.actorSpriteComps10093 then
				for iter_4_7, iter_4_8 in pairs(arg_1_1.var_.actorSpriteComps10093:ToTable()) do
					if iter_4_8 then
						if arg_1_1.isInRecall_ then
							iter_4_8.color = arg_1_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_4_8.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_1_1.var_.actorSpriteComps10093 = nil
			end

			local var_4_43 = arg_1_1.actors_["10093"]
			local var_4_44 = 1.73333333333333

			if var_4_44 < arg_1_1.time_ and arg_1_1.time_ <= var_4_44 + arg_4_0 then
				local var_4_45 = var_4_43:GetComponentInChildren(typeof(CanvasGroup))

				if var_4_45 then
					arg_1_1.var_.alphaOldValue10093 = var_4_45.alpha
					arg_1_1.var_.characterEffect10093 = var_4_45
				end

				arg_1_1.var_.alphaOldValue10093 = 0
			end

			local var_4_46 = 0.232666666666667

			if var_4_44 <= arg_1_1.time_ and arg_1_1.time_ < var_4_44 + var_4_46 then
				local var_4_47 = (arg_1_1.time_ - var_4_44) / var_4_46
				local var_4_48 = Mathf.Lerp(arg_1_1.var_.alphaOldValue10093, 1, var_4_47)

				if arg_1_1.var_.characterEffect10093 then
					arg_1_1.var_.characterEffect10093.alpha = var_4_48
				end
			end

			if arg_1_1.time_ >= var_4_44 + var_4_46 and arg_1_1.time_ < var_4_44 + var_4_46 + arg_4_0 and arg_1_1.var_.characterEffect10093 then
				arg_1_1.var_.characterEffect10093.alpha = 1
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

			local var_4_61 = 2
			local var_4_62 = 0.325

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

				local var_4_64 = arg_1_1:FormatText(StoryNameCfg[28].name)

				arg_1_1.leftNameTxt_.text = var_4_64

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_1_1.leftNameTxt_.transform)

				arg_1_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_1_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_1_1:RecordName(arg_1_1.leftNameTxt_.text)
				SetActive(arg_1_1.iconTrs_.gameObject, false)
				arg_1_1.callingController_:SetSelectedState("normal")

				local var_4_65 = arg_1_1:GetWordFromCfg(413141001)
				local var_4_66 = arg_1_1:FormatText(var_4_65.content)

				arg_1_1.text_.text = var_4_66

				LuaForUtil.ClearLinePrefixSymbol(arg_1_1.text_)

				local var_4_67 = 13
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

				if manager.audio:GetVoiceLength("story_v_out_413141", "413141001", "story_v_out_413141.awb") ~= 0 then
					local var_4_70 = manager.audio:GetVoiceLength("story_v_out_413141", "413141001", "story_v_out_413141.awb") / 1000

					if var_4_70 + var_4_61 > arg_1_1.duration_ then
						arg_1_1.duration_ = var_4_70 + var_4_61
					end

					if var_4_65.prefab_name ~= "" and arg_1_1.actors_[var_4_65.prefab_name] ~= nil then
						local var_4_71 = LuaForUtil.PlayVoiceWithCriLipsync(arg_1_1.actors_[var_4_65.prefab_name].transform, "story_v_out_413141", "413141001", "story_v_out_413141.awb")

						arg_1_1:RecordAudio("413141001", var_4_71)
						arg_1_1:RecordAudio("413141001", var_4_71)
					else
						arg_1_1:AudioAction("play", "voice", "story_v_out_413141", "413141001", "story_v_out_413141.awb")
					end

					arg_1_1:RecordHistoryTalkVoice("story_v_out_413141", "413141001", "story_v_out_413141.awb")
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
				actorName = "10093",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 1.73333333333333,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_1_1:InitPlayNodeList()
	end,
	Play413141002 = function(arg_9_0, arg_9_1)
		arg_9_1.time_ = 0
		arg_9_1.frameCnt_ = 0
		arg_9_1.state_ = "playing"
		arg_9_1.curTalkId_ = 413141002
		arg_9_1.duration_ = 5

		SetActive(arg_9_1.tipsGo_, false)

		function arg_9_1.onSingleLineFinish_()
			arg_9_1.onSingleLineUpdate_ = nil
			arg_9_1.onSingleLineFinish_ = nil
			arg_9_1.state_ = "waiting"
		end

		function arg_9_1.playNext_(arg_11_0)
			if arg_11_0 == 1 then
				arg_9_0:Play413141003(arg_9_1)
			end
		end

		function arg_9_1.onSingleLineUpdate_(arg_12_0)
			local var_12_0 = arg_9_1.actors_["10093"].transform
			local var_12_1 = 0

			if var_12_1 < arg_9_1.time_ and arg_9_1.time_ <= var_12_1 + arg_12_0 then
				arg_9_1.var_.moveOldPos10093 = var_12_0.localPosition
				var_12_0.localScale = Vector3.New(1, 1, 1)

				arg_9_1:CheckSpriteTmpPos("10093", 7)

				local var_12_2 = var_12_0.childCount

				for iter_12_0 = 0, var_12_2 - 1 do
					local var_12_3 = var_12_0:GetChild(iter_12_0)

					if var_12_3.name == "" or not string.find(var_12_3.name, "split") then
						var_12_3.gameObject:SetActive(true)
					else
						var_12_3.gameObject:SetActive(false)
					end
				end
			end

			local var_12_4 = 0.001

			if var_12_1 <= arg_9_1.time_ and arg_9_1.time_ < var_12_1 + var_12_4 then
				local var_12_5 = (arg_9_1.time_ - var_12_1) / var_12_4
				local var_12_6 = Vector3.New(0, -2000, 0)

				var_12_0.localPosition = Vector3.Lerp(arg_9_1.var_.moveOldPos10093, var_12_6, var_12_5)
			end

			if arg_9_1.time_ >= var_12_1 + var_12_4 and arg_9_1.time_ < var_12_1 + var_12_4 + arg_12_0 then
				var_12_0.localPosition = Vector3.New(0, -2000, 0)
			end

			local var_12_7 = arg_9_1.actors_["10093"]
			local var_12_8 = 0

			if var_12_8 < arg_9_1.time_ and arg_9_1.time_ <= var_12_8 + arg_12_0 and not isNil(var_12_7) and arg_9_1.var_.actorSpriteComps10093 == nil then
				arg_9_1.var_.actorSpriteComps10093 = var_12_7:GetComponentsInChildren(typeof(Image), true)
			end

			local var_12_9 = 2

			if var_12_8 <= arg_9_1.time_ and arg_9_1.time_ < var_12_8 + var_12_9 and not isNil(var_12_7) then
				local var_12_10 = (arg_9_1.time_ - var_12_8) / var_12_9

				if arg_9_1.var_.actorSpriteComps10093 then
					for iter_12_1, iter_12_2 in pairs(arg_9_1.var_.actorSpriteComps10093:ToTable()) do
						if iter_12_2 then
							if arg_9_1.isInRecall_ then
								local var_12_11 = Mathf.Lerp(iter_12_2.color.r, arg_9_1.hightColor2.r, var_12_10)
								local var_12_12 = Mathf.Lerp(iter_12_2.color.g, arg_9_1.hightColor2.g, var_12_10)
								local var_12_13 = Mathf.Lerp(iter_12_2.color.b, arg_9_1.hightColor2.b, var_12_10)

								iter_12_2.color = Color.New(var_12_11, var_12_12, var_12_13)
							else
								local var_12_14 = Mathf.Lerp(iter_12_2.color.r, 0.5, var_12_10)

								iter_12_2.color = Color.New(var_12_14, var_12_14, var_12_14)
							end
						end
					end
				end
			end

			if arg_9_1.time_ >= var_12_8 + var_12_9 and arg_9_1.time_ < var_12_8 + var_12_9 + arg_12_0 and not isNil(var_12_7) and arg_9_1.var_.actorSpriteComps10093 then
				for iter_12_3, iter_12_4 in pairs(arg_9_1.var_.actorSpriteComps10093:ToTable()) do
					if iter_12_4 then
						if arg_9_1.isInRecall_ then
							iter_12_4.color = arg_9_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_12_4.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_9_1.var_.actorSpriteComps10093 = nil
			end

			local var_12_15 = 0
			local var_12_16 = 1.25

			if var_12_15 < arg_9_1.time_ and arg_9_1.time_ <= var_12_15 + arg_12_0 then
				arg_9_1.talkMaxDuration = 0
				arg_9_1.dialogCg_.alpha = 1

				arg_9_1.dialog_:SetActive(true)
				SetActive(arg_9_1.leftNameGo_, false)

				arg_9_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_9_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_9_1:RecordName(arg_9_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_9_1.iconTrs_.gameObject, false)
				arg_9_1.callingController_:SetSelectedState("normal")

				local var_12_17 = arg_9_1:GetWordFromCfg(413141002)
				local var_12_18 = arg_9_1:FormatText(var_12_17.content)

				arg_9_1.text_.text = var_12_18

				LuaForUtil.ClearLinePrefixSymbol(arg_9_1.text_)

				local var_12_19 = 50
				local var_12_20 = utf8.len(var_12_18)
				local var_12_21 = var_12_19 <= 0 and var_12_16 or var_12_16 * (var_12_20 / var_12_19)

				if var_12_21 > 0 and var_12_16 < var_12_21 then
					arg_9_1.talkMaxDuration = var_12_21

					if var_12_21 + var_12_15 > arg_9_1.duration_ then
						arg_9_1.duration_ = var_12_21 + var_12_15
					end
				end

				arg_9_1.text_.text = var_12_18
				arg_9_1.typewritter.percent = 0

				arg_9_1.typewritter:SetDirty()
				arg_9_1:ShowNextGo(false)
				arg_9_1:RecordContent(arg_9_1.text_.text)
			end

			local var_12_22 = math.max(var_12_16, arg_9_1.talkMaxDuration)

			if var_12_15 <= arg_9_1.time_ and arg_9_1.time_ < var_12_15 + var_12_22 then
				arg_9_1.typewritter.percent = (arg_9_1.time_ - var_12_15) / var_12_22

				arg_9_1.typewritter:SetDirty()
			end

			if arg_9_1.time_ >= var_12_15 + var_12_22 and arg_9_1.time_ < var_12_15 + var_12_22 + arg_12_0 then
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
			}
		}

		arg_9_1:InitPlayNodeList()
	end,
	Play413141003 = function(arg_13_0, arg_13_1)
		arg_13_1.time_ = 0
		arg_13_1.frameCnt_ = 0
		arg_13_1.state_ = "playing"
		arg_13_1.curTalkId_ = 413141003
		arg_13_1.duration_ = 5

		SetActive(arg_13_1.tipsGo_, false)

		function arg_13_1.onSingleLineFinish_()
			arg_13_1.onSingleLineUpdate_ = nil
			arg_13_1.onSingleLineFinish_ = nil
			arg_13_1.state_ = "waiting"
		end

		function arg_13_1.playNext_(arg_15_0)
			if arg_15_0 == 1 then
				arg_13_0:Play413141004(arg_13_1)
			end
		end

		function arg_13_1.onSingleLineUpdate_(arg_16_0)
			local var_16_0 = 0
			local var_16_1 = 0.9

			if var_16_0 < arg_13_1.time_ and arg_13_1.time_ <= var_16_0 + arg_16_0 then
				arg_13_1.talkMaxDuration = 0
				arg_13_1.dialogCg_.alpha = 1

				arg_13_1.dialog_:SetActive(true)
				SetActive(arg_13_1.leftNameGo_, false)

				arg_13_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_13_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_13_1:RecordName(arg_13_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_13_1.iconTrs_.gameObject, false)
				arg_13_1.callingController_:SetSelectedState("normal")

				local var_16_2 = arg_13_1:GetWordFromCfg(413141003)
				local var_16_3 = arg_13_1:FormatText(var_16_2.content)

				arg_13_1.text_.text = var_16_3

				LuaForUtil.ClearLinePrefixSymbol(arg_13_1.text_)

				local var_16_4 = 36
				local var_16_5 = utf8.len(var_16_3)
				local var_16_6 = var_16_4 <= 0 and var_16_1 or var_16_1 * (var_16_5 / var_16_4)

				if var_16_6 > 0 and var_16_1 < var_16_6 then
					arg_13_1.talkMaxDuration = var_16_6

					if var_16_6 + var_16_0 > arg_13_1.duration_ then
						arg_13_1.duration_ = var_16_6 + var_16_0
					end
				end

				arg_13_1.text_.text = var_16_3
				arg_13_1.typewritter.percent = 0

				arg_13_1.typewritter:SetDirty()
				arg_13_1:ShowNextGo(false)
				arg_13_1:RecordContent(arg_13_1.text_.text)
			end

			local var_16_7 = math.max(var_16_1, arg_13_1.talkMaxDuration)

			if var_16_0 <= arg_13_1.time_ and arg_13_1.time_ < var_16_0 + var_16_7 then
				arg_13_1.typewritter.percent = (arg_13_1.time_ - var_16_0) / var_16_7

				arg_13_1.typewritter:SetDirty()
			end

			if arg_13_1.time_ >= var_16_0 + var_16_7 and arg_13_1.time_ < var_16_0 + var_16_7 + arg_16_0 then
				arg_13_1.typewritter.percent = 1

				arg_13_1.typewritter:SetDirty()
				arg_13_1:ShowNextGo(true)
			end
		end

		arg_13_1.nodeConfigList_ = {}

		arg_13_1:InitPlayNodeList()
	end,
	Play413141004 = function(arg_17_0, arg_17_1)
		arg_17_1.time_ = 0
		arg_17_1.frameCnt_ = 0
		arg_17_1.state_ = "playing"
		arg_17_1.curTalkId_ = 413141004
		arg_17_1.duration_ = 11.7

		local var_17_0 = {
			zh = 7.033,
			ja = 11.7
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
				arg_17_0:Play413141005(arg_17_1)
			end
		end

		function arg_17_1.onSingleLineUpdate_(arg_20_0)
			local var_20_0 = "10092_1"

			if arg_17_1.actors_[var_20_0] == nil then
				local var_20_1 = Asset.Load("Widget/System/Story/StoryExpression/" .. "10092_1")

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

			local var_20_4 = arg_17_1.actors_["10092_1"].transform
			local var_20_5 = 0

			if var_20_5 < arg_17_1.time_ and arg_17_1.time_ <= var_20_5 + arg_20_0 then
				arg_17_1.var_.moveOldPos10092_1 = var_20_4.localPosition
				var_20_4.localScale = Vector3.New(1, 1, 1)

				arg_17_1:CheckSpriteTmpPos("10092_1", 2)

				local var_20_6 = var_20_4.childCount

				for iter_20_2 = 0, var_20_6 - 1 do
					local var_20_7 = var_20_4:GetChild(iter_20_2)

					if var_20_7.name == "split_1_1" or not string.find(var_20_7.name, "split") then
						var_20_7.gameObject:SetActive(true)
					else
						var_20_7.gameObject:SetActive(false)
					end
				end
			end

			local var_20_8 = 0.001

			if var_20_5 <= arg_17_1.time_ and arg_17_1.time_ < var_20_5 + var_20_8 then
				local var_20_9 = (arg_17_1.time_ - var_20_5) / var_20_8
				local var_20_10 = Vector3.New(-389.49, -300, -295)

				var_20_4.localPosition = Vector3.Lerp(arg_17_1.var_.moveOldPos10092_1, var_20_10, var_20_9)
			end

			if arg_17_1.time_ >= var_20_5 + var_20_8 and arg_17_1.time_ < var_20_5 + var_20_8 + arg_20_0 then
				var_20_4.localPosition = Vector3.New(-389.49, -300, -295)
			end

			local var_20_11 = arg_17_1.actors_["10092_1"]
			local var_20_12 = 0

			if var_20_12 < arg_17_1.time_ and arg_17_1.time_ <= var_20_12 + arg_20_0 and not isNil(var_20_11) and arg_17_1.var_.actorSpriteComps10092_1 == nil then
				arg_17_1.var_.actorSpriteComps10092_1 = var_20_11:GetComponentsInChildren(typeof(Image), true)
			end

			local var_20_13 = 2

			if var_20_12 <= arg_17_1.time_ and arg_17_1.time_ < var_20_12 + var_20_13 and not isNil(var_20_11) then
				local var_20_14 = (arg_17_1.time_ - var_20_12) / var_20_13

				if arg_17_1.var_.actorSpriteComps10092_1 then
					for iter_20_3, iter_20_4 in pairs(arg_17_1.var_.actorSpriteComps10092_1:ToTable()) do
						if iter_20_4 then
							if arg_17_1.isInRecall_ then
								local var_20_15 = Mathf.Lerp(iter_20_4.color.r, arg_17_1.hightColor1.r, var_20_14)
								local var_20_16 = Mathf.Lerp(iter_20_4.color.g, arg_17_1.hightColor1.g, var_20_14)
								local var_20_17 = Mathf.Lerp(iter_20_4.color.b, arg_17_1.hightColor1.b, var_20_14)

								iter_20_4.color = Color.New(var_20_15, var_20_16, var_20_17)
							else
								local var_20_18 = Mathf.Lerp(iter_20_4.color.r, 1, var_20_14)

								iter_20_4.color = Color.New(var_20_18, var_20_18, var_20_18)
							end
						end
					end
				end
			end

			if arg_17_1.time_ >= var_20_12 + var_20_13 and arg_17_1.time_ < var_20_12 + var_20_13 + arg_20_0 and not isNil(var_20_11) and arg_17_1.var_.actorSpriteComps10092_1 then
				for iter_20_5, iter_20_6 in pairs(arg_17_1.var_.actorSpriteComps10092_1:ToTable()) do
					if iter_20_6 then
						if arg_17_1.isInRecall_ then
							iter_20_6.color = arg_17_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_20_6.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_17_1.var_.actorSpriteComps10092_1 = nil
			end

			local var_20_19 = 0
			local var_20_20 = 0.925

			if var_20_19 < arg_17_1.time_ and arg_17_1.time_ <= var_20_19 + arg_20_0 then
				arg_17_1.talkMaxDuration = 0
				arg_17_1.dialogCg_.alpha = 1

				arg_17_1.dialog_:SetActive(true)
				SetActive(arg_17_1.leftNameGo_, true)

				local var_20_21 = arg_17_1:FormatText(StoryNameCfg[996].name)

				arg_17_1.leftNameTxt_.text = var_20_21

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_17_1.leftNameTxt_.transform)

				arg_17_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_17_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_17_1:RecordName(arg_17_1.leftNameTxt_.text)
				SetActive(arg_17_1.iconTrs_.gameObject, false)
				arg_17_1.callingController_:SetSelectedState("normal")

				local var_20_22 = arg_17_1:GetWordFromCfg(413141004)
				local var_20_23 = arg_17_1:FormatText(var_20_22.content)

				arg_17_1.text_.text = var_20_23

				LuaForUtil.ClearLinePrefixSymbol(arg_17_1.text_)

				local var_20_24 = 37
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

				if manager.audio:GetVoiceLength("story_v_out_413141", "413141004", "story_v_out_413141.awb") ~= 0 then
					local var_20_27 = manager.audio:GetVoiceLength("story_v_out_413141", "413141004", "story_v_out_413141.awb") / 1000

					if var_20_27 + var_20_19 > arg_17_1.duration_ then
						arg_17_1.duration_ = var_20_27 + var_20_19
					end

					if var_20_22.prefab_name ~= "" and arg_17_1.actors_[var_20_22.prefab_name] ~= nil then
						local var_20_28 = LuaForUtil.PlayVoiceWithCriLipsync(arg_17_1.actors_[var_20_22.prefab_name].transform, "story_v_out_413141", "413141004", "story_v_out_413141.awb")

						arg_17_1:RecordAudio("413141004", var_20_28)
						arg_17_1:RecordAudio("413141004", var_20_28)
					else
						arg_17_1:AudioAction("play", "voice", "story_v_out_413141", "413141004", "story_v_out_413141.awb")
					end

					arg_17_1:RecordHistoryTalkVoice("story_v_out_413141", "413141004", "story_v_out_413141.awb")
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
				actorName = "10092_1",
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
	Play413141005 = function(arg_21_0, arg_21_1)
		arg_21_1.time_ = 0
		arg_21_1.frameCnt_ = 0
		arg_21_1.state_ = "playing"
		arg_21_1.curTalkId_ = 413141005
		arg_21_1.duration_ = 4.73

		local var_21_0 = {
			zh = 3.1,
			ja = 4.733
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
				arg_21_0:Play413141006(arg_21_1)
			end
		end

		function arg_21_1.onSingleLineUpdate_(arg_24_0)
			local var_24_0 = arg_21_1.actors_["10092_1"].transform
			local var_24_1 = 0

			if var_24_1 < arg_21_1.time_ and arg_21_1.time_ <= var_24_1 + arg_24_0 then
				arg_21_1.var_.moveOldPos10092_1 = var_24_0.localPosition
				var_24_0.localScale = Vector3.New(1, 1, 1)

				arg_21_1:CheckSpriteTmpPos("10092_1", 2)

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
				local var_24_6 = Vector3.New(-389.49, -300, -295)

				var_24_0.localPosition = Vector3.Lerp(arg_21_1.var_.moveOldPos10092_1, var_24_6, var_24_5)
			end

			if arg_21_1.time_ >= var_24_1 + var_24_4 and arg_21_1.time_ < var_24_1 + var_24_4 + arg_24_0 then
				var_24_0.localPosition = Vector3.New(-389.49, -300, -295)
			end

			local var_24_7 = arg_21_1.actors_["10093"].transform
			local var_24_8 = 0

			if var_24_8 < arg_21_1.time_ and arg_21_1.time_ <= var_24_8 + arg_24_0 then
				arg_21_1.var_.moveOldPos10093 = var_24_7.localPosition
				var_24_7.localScale = Vector3.New(1, 1, 1)

				arg_21_1:CheckSpriteTmpPos("10093", 4)

				local var_24_9 = var_24_7.childCount

				for iter_24_1 = 0, var_24_9 - 1 do
					local var_24_10 = var_24_7:GetChild(iter_24_1)

					if var_24_10.name == "split_4" or not string.find(var_24_10.name, "split") then
						var_24_10.gameObject:SetActive(true)
					else
						var_24_10.gameObject:SetActive(false)
					end
				end
			end

			local var_24_11 = 0.001

			if var_24_8 <= arg_21_1.time_ and arg_21_1.time_ < var_24_8 + var_24_11 then
				local var_24_12 = (arg_21_1.time_ - var_24_8) / var_24_11
				local var_24_13 = Vector3.New(390, -345, -245)

				var_24_7.localPosition = Vector3.Lerp(arg_21_1.var_.moveOldPos10093, var_24_13, var_24_12)
			end

			if arg_21_1.time_ >= var_24_8 + var_24_11 and arg_21_1.time_ < var_24_8 + var_24_11 + arg_24_0 then
				var_24_7.localPosition = Vector3.New(390, -345, -245)
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
								local var_24_26 = Mathf.Lerp(iter_24_7.color.r, arg_21_1.hightColor1.r, var_24_25)
								local var_24_27 = Mathf.Lerp(iter_24_7.color.g, arg_21_1.hightColor1.g, var_24_25)
								local var_24_28 = Mathf.Lerp(iter_24_7.color.b, arg_21_1.hightColor1.b, var_24_25)

								iter_24_7.color = Color.New(var_24_26, var_24_27, var_24_28)
							else
								local var_24_29 = Mathf.Lerp(iter_24_7.color.r, 1, var_24_25)

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
							iter_24_9.color = arg_21_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_24_9.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_21_1.var_.actorSpriteComps10093 = nil
			end

			local var_24_30 = 0
			local var_24_31 = 0.325

			if var_24_30 < arg_21_1.time_ and arg_21_1.time_ <= var_24_30 + arg_24_0 then
				arg_21_1.talkMaxDuration = 0
				arg_21_1.dialogCg_.alpha = 1

				arg_21_1.dialog_:SetActive(true)
				SetActive(arg_21_1.leftNameGo_, true)

				local var_24_32 = arg_21_1:FormatText(StoryNameCfg[28].name)

				arg_21_1.leftNameTxt_.text = var_24_32

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_21_1.leftNameTxt_.transform)

				arg_21_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_21_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_21_1:RecordName(arg_21_1.leftNameTxt_.text)
				SetActive(arg_21_1.iconTrs_.gameObject, false)
				arg_21_1.callingController_:SetSelectedState("normal")

				local var_24_33 = arg_21_1:GetWordFromCfg(413141005)
				local var_24_34 = arg_21_1:FormatText(var_24_33.content)

				arg_21_1.text_.text = var_24_34

				LuaForUtil.ClearLinePrefixSymbol(arg_21_1.text_)

				local var_24_35 = 13
				local var_24_36 = utf8.len(var_24_34)
				local var_24_37 = var_24_35 <= 0 and var_24_31 or var_24_31 * (var_24_36 / var_24_35)

				if var_24_37 > 0 and var_24_31 < var_24_37 then
					arg_21_1.talkMaxDuration = var_24_37

					if var_24_37 + var_24_30 > arg_21_1.duration_ then
						arg_21_1.duration_ = var_24_37 + var_24_30
					end
				end

				arg_21_1.text_.text = var_24_34
				arg_21_1.typewritter.percent = 0

				arg_21_1.typewritter:SetDirty()
				arg_21_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_413141", "413141005", "story_v_out_413141.awb") ~= 0 then
					local var_24_38 = manager.audio:GetVoiceLength("story_v_out_413141", "413141005", "story_v_out_413141.awb") / 1000

					if var_24_38 + var_24_30 > arg_21_1.duration_ then
						arg_21_1.duration_ = var_24_38 + var_24_30
					end

					if var_24_33.prefab_name ~= "" and arg_21_1.actors_[var_24_33.prefab_name] ~= nil then
						local var_24_39 = LuaForUtil.PlayVoiceWithCriLipsync(arg_21_1.actors_[var_24_33.prefab_name].transform, "story_v_out_413141", "413141005", "story_v_out_413141.awb")

						arg_21_1:RecordAudio("413141005", var_24_39)
						arg_21_1:RecordAudio("413141005", var_24_39)
					else
						arg_21_1:AudioAction("play", "voice", "story_v_out_413141", "413141005", "story_v_out_413141.awb")
					end

					arg_21_1:RecordHistoryTalkVoice("story_v_out_413141", "413141005", "story_v_out_413141.awb")
				end

				arg_21_1:RecordContent(arg_21_1.text_.text)
			end

			local var_24_40 = math.max(var_24_31, arg_21_1.talkMaxDuration)

			if var_24_30 <= arg_21_1.time_ and arg_21_1.time_ < var_24_30 + var_24_40 then
				arg_21_1.typewritter.percent = (arg_21_1.time_ - var_24_30) / var_24_40

				arg_21_1.typewritter:SetDirty()
			end

			if arg_21_1.time_ >= var_24_30 + var_24_40 and arg_21_1.time_ < var_24_30 + var_24_40 + arg_24_0 then
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
	Play413141006 = function(arg_25_0, arg_25_1)
		arg_25_1.time_ = 0
		arg_25_1.frameCnt_ = 0
		arg_25_1.state_ = "playing"
		arg_25_1.curTalkId_ = 413141006
		arg_25_1.duration_ = 8.5

		local var_25_0 = {
			zh = 7.466,
			ja = 8.5
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
				arg_25_0:Play413141007(arg_25_1)
			end
		end

		function arg_25_1.onSingleLineUpdate_(arg_28_0)
			local var_28_0 = arg_25_1.actors_["10092_1"].transform
			local var_28_1 = 0

			if var_28_1 < arg_25_1.time_ and arg_25_1.time_ <= var_28_1 + arg_28_0 then
				arg_25_1.var_.moveOldPos10092_1 = var_28_0.localPosition
				var_28_0.localScale = Vector3.New(1, 1, 1)

				arg_25_1:CheckSpriteTmpPos("10092_1", 2)

				local var_28_2 = var_28_0.childCount

				for iter_28_0 = 0, var_28_2 - 1 do
					local var_28_3 = var_28_0:GetChild(iter_28_0)

					if var_28_3.name == "" or not string.find(var_28_3.name, "split") then
						var_28_3.gameObject:SetActive(true)
					else
						var_28_3.gameObject:SetActive(false)
					end
				end
			end

			local var_28_4 = 0.001

			if var_28_1 <= arg_25_1.time_ and arg_25_1.time_ < var_28_1 + var_28_4 then
				local var_28_5 = (arg_25_1.time_ - var_28_1) / var_28_4
				local var_28_6 = Vector3.New(-389.49, -300, -295)

				var_28_0.localPosition = Vector3.Lerp(arg_25_1.var_.moveOldPos10092_1, var_28_6, var_28_5)
			end

			if arg_25_1.time_ >= var_28_1 + var_28_4 and arg_25_1.time_ < var_28_1 + var_28_4 + arg_28_0 then
				var_28_0.localPosition = Vector3.New(-389.49, -300, -295)
			end

			local var_28_7 = arg_25_1.actors_["10092_1"]
			local var_28_8 = 0

			if var_28_8 < arg_25_1.time_ and arg_25_1.time_ <= var_28_8 + arg_28_0 and not isNil(var_28_7) and arg_25_1.var_.actorSpriteComps10092_1 == nil then
				arg_25_1.var_.actorSpriteComps10092_1 = var_28_7:GetComponentsInChildren(typeof(Image), true)
			end

			local var_28_9 = 2

			if var_28_8 <= arg_25_1.time_ and arg_25_1.time_ < var_28_8 + var_28_9 and not isNil(var_28_7) then
				local var_28_10 = (arg_25_1.time_ - var_28_8) / var_28_9

				if arg_25_1.var_.actorSpriteComps10092_1 then
					for iter_28_1, iter_28_2 in pairs(arg_25_1.var_.actorSpriteComps10092_1:ToTable()) do
						if iter_28_2 then
							if arg_25_1.isInRecall_ then
								local var_28_11 = Mathf.Lerp(iter_28_2.color.r, arg_25_1.hightColor1.r, var_28_10)
								local var_28_12 = Mathf.Lerp(iter_28_2.color.g, arg_25_1.hightColor1.g, var_28_10)
								local var_28_13 = Mathf.Lerp(iter_28_2.color.b, arg_25_1.hightColor1.b, var_28_10)

								iter_28_2.color = Color.New(var_28_11, var_28_12, var_28_13)
							else
								local var_28_14 = Mathf.Lerp(iter_28_2.color.r, 1, var_28_10)

								iter_28_2.color = Color.New(var_28_14, var_28_14, var_28_14)
							end
						end
					end
				end
			end

			if arg_25_1.time_ >= var_28_8 + var_28_9 and arg_25_1.time_ < var_28_8 + var_28_9 + arg_28_0 and not isNil(var_28_7) and arg_25_1.var_.actorSpriteComps10092_1 then
				for iter_28_3, iter_28_4 in pairs(arg_25_1.var_.actorSpriteComps10092_1:ToTable()) do
					if iter_28_4 then
						if arg_25_1.isInRecall_ then
							iter_28_4.color = arg_25_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_28_4.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_25_1.var_.actorSpriteComps10092_1 = nil
			end

			local var_28_15 = arg_25_1.actors_["10093"]
			local var_28_16 = 0

			if var_28_16 < arg_25_1.time_ and arg_25_1.time_ <= var_28_16 + arg_28_0 and not isNil(var_28_15) and arg_25_1.var_.actorSpriteComps10093 == nil then
				arg_25_1.var_.actorSpriteComps10093 = var_28_15:GetComponentsInChildren(typeof(Image), true)
			end

			local var_28_17 = 2

			if var_28_16 <= arg_25_1.time_ and arg_25_1.time_ < var_28_16 + var_28_17 and not isNil(var_28_15) then
				local var_28_18 = (arg_25_1.time_ - var_28_16) / var_28_17

				if arg_25_1.var_.actorSpriteComps10093 then
					for iter_28_5, iter_28_6 in pairs(arg_25_1.var_.actorSpriteComps10093:ToTable()) do
						if iter_28_6 then
							if arg_25_1.isInRecall_ then
								local var_28_19 = Mathf.Lerp(iter_28_6.color.r, arg_25_1.hightColor2.r, var_28_18)
								local var_28_20 = Mathf.Lerp(iter_28_6.color.g, arg_25_1.hightColor2.g, var_28_18)
								local var_28_21 = Mathf.Lerp(iter_28_6.color.b, arg_25_1.hightColor2.b, var_28_18)

								iter_28_6.color = Color.New(var_28_19, var_28_20, var_28_21)
							else
								local var_28_22 = Mathf.Lerp(iter_28_6.color.r, 0.5, var_28_18)

								iter_28_6.color = Color.New(var_28_22, var_28_22, var_28_22)
							end
						end
					end
				end
			end

			if arg_25_1.time_ >= var_28_16 + var_28_17 and arg_25_1.time_ < var_28_16 + var_28_17 + arg_28_0 and not isNil(var_28_15) and arg_25_1.var_.actorSpriteComps10093 then
				for iter_28_7, iter_28_8 in pairs(arg_25_1.var_.actorSpriteComps10093:ToTable()) do
					if iter_28_8 then
						if arg_25_1.isInRecall_ then
							iter_28_8.color = arg_25_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_28_8.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_25_1.var_.actorSpriteComps10093 = nil
			end

			local var_28_23 = arg_25_1.actors_["10093"].transform
			local var_28_24 = 0

			if var_28_24 < arg_25_1.time_ and arg_25_1.time_ <= var_28_24 + arg_28_0 then
				arg_25_1.var_.moveOldPos10093 = var_28_23.localPosition
				var_28_23.localScale = Vector3.New(1, 1, 1)

				arg_25_1:CheckSpriteTmpPos("10093", 4)

				local var_28_25 = var_28_23.childCount

				for iter_28_9 = 0, var_28_25 - 1 do
					local var_28_26 = var_28_23:GetChild(iter_28_9)

					if var_28_26.name == "" or not string.find(var_28_26.name, "split") then
						var_28_26.gameObject:SetActive(true)
					else
						var_28_26.gameObject:SetActive(false)
					end
				end
			end

			local var_28_27 = 0.001

			if var_28_24 <= arg_25_1.time_ and arg_25_1.time_ < var_28_24 + var_28_27 then
				local var_28_28 = (arg_25_1.time_ - var_28_24) / var_28_27
				local var_28_29 = Vector3.New(390, -345, -245)

				var_28_23.localPosition = Vector3.Lerp(arg_25_1.var_.moveOldPos10093, var_28_29, var_28_28)
			end

			if arg_25_1.time_ >= var_28_24 + var_28_27 and arg_25_1.time_ < var_28_24 + var_28_27 + arg_28_0 then
				var_28_23.localPosition = Vector3.New(390, -345, -245)
			end

			local var_28_30 = 0
			local var_28_31 = 1

			if var_28_30 < arg_25_1.time_ and arg_25_1.time_ <= var_28_30 + arg_28_0 then
				arg_25_1.talkMaxDuration = 0
				arg_25_1.dialogCg_.alpha = 1

				arg_25_1.dialog_:SetActive(true)
				SetActive(arg_25_1.leftNameGo_, true)

				local var_28_32 = arg_25_1:FormatText(StoryNameCfg[996].name)

				arg_25_1.leftNameTxt_.text = var_28_32

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_25_1.leftNameTxt_.transform)

				arg_25_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_25_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_25_1:RecordName(arg_25_1.leftNameTxt_.text)
				SetActive(arg_25_1.iconTrs_.gameObject, false)
				arg_25_1.callingController_:SetSelectedState("normal")

				local var_28_33 = arg_25_1:GetWordFromCfg(413141006)
				local var_28_34 = arg_25_1:FormatText(var_28_33.content)

				arg_25_1.text_.text = var_28_34

				LuaForUtil.ClearLinePrefixSymbol(arg_25_1.text_)

				local var_28_35 = 40
				local var_28_36 = utf8.len(var_28_34)
				local var_28_37 = var_28_35 <= 0 and var_28_31 or var_28_31 * (var_28_36 / var_28_35)

				if var_28_37 > 0 and var_28_31 < var_28_37 then
					arg_25_1.talkMaxDuration = var_28_37

					if var_28_37 + var_28_30 > arg_25_1.duration_ then
						arg_25_1.duration_ = var_28_37 + var_28_30
					end
				end

				arg_25_1.text_.text = var_28_34
				arg_25_1.typewritter.percent = 0

				arg_25_1.typewritter:SetDirty()
				arg_25_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_413141", "413141006", "story_v_out_413141.awb") ~= 0 then
					local var_28_38 = manager.audio:GetVoiceLength("story_v_out_413141", "413141006", "story_v_out_413141.awb") / 1000

					if var_28_38 + var_28_30 > arg_25_1.duration_ then
						arg_25_1.duration_ = var_28_38 + var_28_30
					end

					if var_28_33.prefab_name ~= "" and arg_25_1.actors_[var_28_33.prefab_name] ~= nil then
						local var_28_39 = LuaForUtil.PlayVoiceWithCriLipsync(arg_25_1.actors_[var_28_33.prefab_name].transform, "story_v_out_413141", "413141006", "story_v_out_413141.awb")

						arg_25_1:RecordAudio("413141006", var_28_39)
						arg_25_1:RecordAudio("413141006", var_28_39)
					else
						arg_25_1:AudioAction("play", "voice", "story_v_out_413141", "413141006", "story_v_out_413141.awb")
					end

					arg_25_1:RecordHistoryTalkVoice("story_v_out_413141", "413141006", "story_v_out_413141.awb")
				end

				arg_25_1:RecordContent(arg_25_1.text_.text)
			end

			local var_28_40 = math.max(var_28_31, arg_25_1.talkMaxDuration)

			if var_28_30 <= arg_25_1.time_ and arg_25_1.time_ < var_28_30 + var_28_40 then
				arg_25_1.typewritter.percent = (arg_25_1.time_ - var_28_30) / var_28_40

				arg_25_1.typewritter:SetDirty()
			end

			if arg_25_1.time_ >= var_28_30 + var_28_40 and arg_25_1.time_ < var_28_30 + var_28_40 + arg_28_0 then
				arg_25_1.typewritter.percent = 1

				arg_25_1.typewritter:SetDirty()
				arg_25_1:ShowNextGo(true)
			end
		end

		arg_25_1.nodeConfigList_ = {
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

		arg_25_1:InitPlayNodeList()
	end,
	Play413141007 = function(arg_29_0, arg_29_1)
		arg_29_1.time_ = 0
		arg_29_1.frameCnt_ = 0
		arg_29_1.state_ = "playing"
		arg_29_1.curTalkId_ = 413141007
		arg_29_1.duration_ = 6.13

		local var_29_0 = {
			zh = 4.9,
			ja = 6.133
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
				arg_29_0:Play413141008(arg_29_1)
			end
		end

		function arg_29_1.onSingleLineUpdate_(arg_32_0)
			local var_32_0 = 0
			local var_32_1 = 0.675

			if var_32_0 < arg_29_1.time_ and arg_29_1.time_ <= var_32_0 + arg_32_0 then
				arg_29_1.talkMaxDuration = 0
				arg_29_1.dialogCg_.alpha = 1

				arg_29_1.dialog_:SetActive(true)
				SetActive(arg_29_1.leftNameGo_, true)

				local var_32_2 = arg_29_1:FormatText(StoryNameCfg[996].name)

				arg_29_1.leftNameTxt_.text = var_32_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_29_1.leftNameTxt_.transform)

				arg_29_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_29_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_29_1:RecordName(arg_29_1.leftNameTxt_.text)
				SetActive(arg_29_1.iconTrs_.gameObject, false)
				arg_29_1.callingController_:SetSelectedState("normal")

				local var_32_3 = arg_29_1:GetWordFromCfg(413141007)
				local var_32_4 = arg_29_1:FormatText(var_32_3.content)

				arg_29_1.text_.text = var_32_4

				LuaForUtil.ClearLinePrefixSymbol(arg_29_1.text_)

				local var_32_5 = 27
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

				if manager.audio:GetVoiceLength("story_v_out_413141", "413141007", "story_v_out_413141.awb") ~= 0 then
					local var_32_8 = manager.audio:GetVoiceLength("story_v_out_413141", "413141007", "story_v_out_413141.awb") / 1000

					if var_32_8 + var_32_0 > arg_29_1.duration_ then
						arg_29_1.duration_ = var_32_8 + var_32_0
					end

					if var_32_3.prefab_name ~= "" and arg_29_1.actors_[var_32_3.prefab_name] ~= nil then
						local var_32_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_29_1.actors_[var_32_3.prefab_name].transform, "story_v_out_413141", "413141007", "story_v_out_413141.awb")

						arg_29_1:RecordAudio("413141007", var_32_9)
						arg_29_1:RecordAudio("413141007", var_32_9)
					else
						arg_29_1:AudioAction("play", "voice", "story_v_out_413141", "413141007", "story_v_out_413141.awb")
					end

					arg_29_1:RecordHistoryTalkVoice("story_v_out_413141", "413141007", "story_v_out_413141.awb")
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
	Play413141008 = function(arg_33_0, arg_33_1)
		arg_33_1.time_ = 0
		arg_33_1.frameCnt_ = 0
		arg_33_1.state_ = "playing"
		arg_33_1.curTalkId_ = 413141008
		arg_33_1.duration_ = 18.27

		local var_33_0 = {
			zh = 12.4,
			ja = 18.266
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
				arg_33_0:Play413141009(arg_33_1)
			end
		end

		function arg_33_1.onSingleLineUpdate_(arg_36_0)
			local var_36_0 = 0
			local var_36_1 = 1.525

			if var_36_0 < arg_33_1.time_ and arg_33_1.time_ <= var_36_0 + arg_36_0 then
				arg_33_1.talkMaxDuration = 0
				arg_33_1.dialogCg_.alpha = 1

				arg_33_1.dialog_:SetActive(true)
				SetActive(arg_33_1.leftNameGo_, true)

				local var_36_2 = arg_33_1:FormatText(StoryNameCfg[996].name)

				arg_33_1.leftNameTxt_.text = var_36_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_33_1.leftNameTxt_.transform)

				arg_33_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_33_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_33_1:RecordName(arg_33_1.leftNameTxt_.text)
				SetActive(arg_33_1.iconTrs_.gameObject, false)
				arg_33_1.callingController_:SetSelectedState("normal")

				local var_36_3 = arg_33_1:GetWordFromCfg(413141008)
				local var_36_4 = arg_33_1:FormatText(var_36_3.content)

				arg_33_1.text_.text = var_36_4

				LuaForUtil.ClearLinePrefixSymbol(arg_33_1.text_)

				local var_36_5 = 61
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

				if manager.audio:GetVoiceLength("story_v_out_413141", "413141008", "story_v_out_413141.awb") ~= 0 then
					local var_36_8 = manager.audio:GetVoiceLength("story_v_out_413141", "413141008", "story_v_out_413141.awb") / 1000

					if var_36_8 + var_36_0 > arg_33_1.duration_ then
						arg_33_1.duration_ = var_36_8 + var_36_0
					end

					if var_36_3.prefab_name ~= "" and arg_33_1.actors_[var_36_3.prefab_name] ~= nil then
						local var_36_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_33_1.actors_[var_36_3.prefab_name].transform, "story_v_out_413141", "413141008", "story_v_out_413141.awb")

						arg_33_1:RecordAudio("413141008", var_36_9)
						arg_33_1:RecordAudio("413141008", var_36_9)
					else
						arg_33_1:AudioAction("play", "voice", "story_v_out_413141", "413141008", "story_v_out_413141.awb")
					end

					arg_33_1:RecordHistoryTalkVoice("story_v_out_413141", "413141008", "story_v_out_413141.awb")
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
	Play413141009 = function(arg_37_0, arg_37_1)
		arg_37_1.time_ = 0
		arg_37_1.frameCnt_ = 0
		arg_37_1.state_ = "playing"
		arg_37_1.curTalkId_ = 413141009
		arg_37_1.duration_ = 8.27

		local var_37_0 = {
			zh = 6.066,
			ja = 8.266
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
				arg_37_0:Play413141010(arg_37_1)
			end
		end

		function arg_37_1.onSingleLineUpdate_(arg_40_0)
			local var_40_0 = arg_37_1.actors_["10092_1"].transform
			local var_40_1 = 0

			if var_40_1 < arg_37_1.time_ and arg_37_1.time_ <= var_40_1 + arg_40_0 then
				arg_37_1.var_.moveOldPos10092_1 = var_40_0.localPosition
				var_40_0.localScale = Vector3.New(1, 1, 1)

				arg_37_1:CheckSpriteTmpPos("10092_1", 2)

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
				local var_40_6 = Vector3.New(-389.49, -300, -295)

				var_40_0.localPosition = Vector3.Lerp(arg_37_1.var_.moveOldPos10092_1, var_40_6, var_40_5)
			end

			if arg_37_1.time_ >= var_40_1 + var_40_4 and arg_37_1.time_ < var_40_1 + var_40_4 + arg_40_0 then
				var_40_0.localPosition = Vector3.New(-389.49, -300, -295)
			end

			local var_40_7 = arg_37_1.actors_["10092_1"]
			local var_40_8 = 0

			if var_40_8 < arg_37_1.time_ and arg_37_1.time_ <= var_40_8 + arg_40_0 and not isNil(var_40_7) and arg_37_1.var_.actorSpriteComps10092_1 == nil then
				arg_37_1.var_.actorSpriteComps10092_1 = var_40_7:GetComponentsInChildren(typeof(Image), true)
			end

			local var_40_9 = 2

			if var_40_8 <= arg_37_1.time_ and arg_37_1.time_ < var_40_8 + var_40_9 and not isNil(var_40_7) then
				local var_40_10 = (arg_37_1.time_ - var_40_8) / var_40_9

				if arg_37_1.var_.actorSpriteComps10092_1 then
					for iter_40_1, iter_40_2 in pairs(arg_37_1.var_.actorSpriteComps10092_1:ToTable()) do
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

			if arg_37_1.time_ >= var_40_8 + var_40_9 and arg_37_1.time_ < var_40_8 + var_40_9 + arg_40_0 and not isNil(var_40_7) and arg_37_1.var_.actorSpriteComps10092_1 then
				for iter_40_3, iter_40_4 in pairs(arg_37_1.var_.actorSpriteComps10092_1:ToTable()) do
					if iter_40_4 then
						if arg_37_1.isInRecall_ then
							iter_40_4.color = arg_37_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_40_4.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_37_1.var_.actorSpriteComps10092_1 = nil
			end

			local var_40_15 = 0
			local var_40_16 = 0.8

			if var_40_15 < arg_37_1.time_ and arg_37_1.time_ <= var_40_15 + arg_40_0 then
				arg_37_1.talkMaxDuration = 0
				arg_37_1.dialogCg_.alpha = 1

				arg_37_1.dialog_:SetActive(true)
				SetActive(arg_37_1.leftNameGo_, true)

				local var_40_17 = arg_37_1:FormatText(StoryNameCfg[996].name)

				arg_37_1.leftNameTxt_.text = var_40_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_37_1.leftNameTxt_.transform)

				arg_37_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_37_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_37_1:RecordName(arg_37_1.leftNameTxt_.text)
				SetActive(arg_37_1.iconTrs_.gameObject, false)
				arg_37_1.callingController_:SetSelectedState("normal")

				local var_40_18 = arg_37_1:GetWordFromCfg(413141009)
				local var_40_19 = arg_37_1:FormatText(var_40_18.content)

				arg_37_1.text_.text = var_40_19

				LuaForUtil.ClearLinePrefixSymbol(arg_37_1.text_)

				local var_40_20 = 32
				local var_40_21 = utf8.len(var_40_19)
				local var_40_22 = var_40_20 <= 0 and var_40_16 or var_40_16 * (var_40_21 / var_40_20)

				if var_40_22 > 0 and var_40_16 < var_40_22 then
					arg_37_1.talkMaxDuration = var_40_22

					if var_40_22 + var_40_15 > arg_37_1.duration_ then
						arg_37_1.duration_ = var_40_22 + var_40_15
					end
				end

				arg_37_1.text_.text = var_40_19
				arg_37_1.typewritter.percent = 0

				arg_37_1.typewritter:SetDirty()
				arg_37_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_413141", "413141009", "story_v_out_413141.awb") ~= 0 then
					local var_40_23 = manager.audio:GetVoiceLength("story_v_out_413141", "413141009", "story_v_out_413141.awb") / 1000

					if var_40_23 + var_40_15 > arg_37_1.duration_ then
						arg_37_1.duration_ = var_40_23 + var_40_15
					end

					if var_40_18.prefab_name ~= "" and arg_37_1.actors_[var_40_18.prefab_name] ~= nil then
						local var_40_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_37_1.actors_[var_40_18.prefab_name].transform, "story_v_out_413141", "413141009", "story_v_out_413141.awb")

						arg_37_1:RecordAudio("413141009", var_40_24)
						arg_37_1:RecordAudio("413141009", var_40_24)
					else
						arg_37_1:AudioAction("play", "voice", "story_v_out_413141", "413141009", "story_v_out_413141.awb")
					end

					arg_37_1:RecordHistoryTalkVoice("story_v_out_413141", "413141009", "story_v_out_413141.awb")
				end

				arg_37_1:RecordContent(arg_37_1.text_.text)
			end

			local var_40_25 = math.max(var_40_16, arg_37_1.talkMaxDuration)

			if var_40_15 <= arg_37_1.time_ and arg_37_1.time_ < var_40_15 + var_40_25 then
				arg_37_1.typewritter.percent = (arg_37_1.time_ - var_40_15) / var_40_25

				arg_37_1.typewritter:SetDirty()
			end

			if arg_37_1.time_ >= var_40_15 + var_40_25 and arg_37_1.time_ < var_40_15 + var_40_25 + arg_40_0 then
				arg_37_1.typewritter.percent = 1

				arg_37_1.typewritter:SetDirty()
				arg_37_1:ShowNextGo(true)
			end
		end

		arg_37_1.nodeConfigList_ = {
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

		arg_37_1:InitPlayNodeList()
	end,
	Play413141010 = function(arg_41_0, arg_41_1)
		arg_41_1.time_ = 0
		arg_41_1.frameCnt_ = 0
		arg_41_1.state_ = "playing"
		arg_41_1.curTalkId_ = 413141010
		arg_41_1.duration_ = 6.07

		local var_41_0 = {
			zh = 5.5,
			ja = 6.066
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
				arg_41_0:Play413141011(arg_41_1)
			end
		end

		function arg_41_1.onSingleLineUpdate_(arg_44_0)
			local var_44_0 = arg_41_1.actors_["10092_1"]
			local var_44_1 = 0

			if var_44_1 < arg_41_1.time_ and arg_41_1.time_ <= var_44_1 + arg_44_0 and not isNil(var_44_0) and arg_41_1.var_.actorSpriteComps10092_1 == nil then
				arg_41_1.var_.actorSpriteComps10092_1 = var_44_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_44_2 = 2

			if var_44_1 <= arg_41_1.time_ and arg_41_1.time_ < var_44_1 + var_44_2 and not isNil(var_44_0) then
				local var_44_3 = (arg_41_1.time_ - var_44_1) / var_44_2

				if arg_41_1.var_.actorSpriteComps10092_1 then
					for iter_44_0, iter_44_1 in pairs(arg_41_1.var_.actorSpriteComps10092_1:ToTable()) do
						if iter_44_1 then
							if arg_41_1.isInRecall_ then
								local var_44_4 = Mathf.Lerp(iter_44_1.color.r, arg_41_1.hightColor2.r, var_44_3)
								local var_44_5 = Mathf.Lerp(iter_44_1.color.g, arg_41_1.hightColor2.g, var_44_3)
								local var_44_6 = Mathf.Lerp(iter_44_1.color.b, arg_41_1.hightColor2.b, var_44_3)

								iter_44_1.color = Color.New(var_44_4, var_44_5, var_44_6)
							else
								local var_44_7 = Mathf.Lerp(iter_44_1.color.r, 0.5, var_44_3)

								iter_44_1.color = Color.New(var_44_7, var_44_7, var_44_7)
							end
						end
					end
				end
			end

			if arg_41_1.time_ >= var_44_1 + var_44_2 and arg_41_1.time_ < var_44_1 + var_44_2 + arg_44_0 and not isNil(var_44_0) and arg_41_1.var_.actorSpriteComps10092_1 then
				for iter_44_2, iter_44_3 in pairs(arg_41_1.var_.actorSpriteComps10092_1:ToTable()) do
					if iter_44_3 then
						if arg_41_1.isInRecall_ then
							iter_44_3.color = arg_41_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_44_3.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_41_1.var_.actorSpriteComps10092_1 = nil
			end

			local var_44_8 = arg_41_1.actors_["10093"]
			local var_44_9 = 0

			if var_44_9 < arg_41_1.time_ and arg_41_1.time_ <= var_44_9 + arg_44_0 and not isNil(var_44_8) and arg_41_1.var_.actorSpriteComps10093 == nil then
				arg_41_1.var_.actorSpriteComps10093 = var_44_8:GetComponentsInChildren(typeof(Image), true)
			end

			local var_44_10 = 2

			if var_44_9 <= arg_41_1.time_ and arg_41_1.time_ < var_44_9 + var_44_10 and not isNil(var_44_8) then
				local var_44_11 = (arg_41_1.time_ - var_44_9) / var_44_10

				if arg_41_1.var_.actorSpriteComps10093 then
					for iter_44_4, iter_44_5 in pairs(arg_41_1.var_.actorSpriteComps10093:ToTable()) do
						if iter_44_5 then
							if arg_41_1.isInRecall_ then
								local var_44_12 = Mathf.Lerp(iter_44_5.color.r, arg_41_1.hightColor1.r, var_44_11)
								local var_44_13 = Mathf.Lerp(iter_44_5.color.g, arg_41_1.hightColor1.g, var_44_11)
								local var_44_14 = Mathf.Lerp(iter_44_5.color.b, arg_41_1.hightColor1.b, var_44_11)

								iter_44_5.color = Color.New(var_44_12, var_44_13, var_44_14)
							else
								local var_44_15 = Mathf.Lerp(iter_44_5.color.r, 1, var_44_11)

								iter_44_5.color = Color.New(var_44_15, var_44_15, var_44_15)
							end
						end
					end
				end
			end

			if arg_41_1.time_ >= var_44_9 + var_44_10 and arg_41_1.time_ < var_44_9 + var_44_10 + arg_44_0 and not isNil(var_44_8) and arg_41_1.var_.actorSpriteComps10093 then
				for iter_44_6, iter_44_7 in pairs(arg_41_1.var_.actorSpriteComps10093:ToTable()) do
					if iter_44_7 then
						if arg_41_1.isInRecall_ then
							iter_44_7.color = arg_41_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_44_7.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_41_1.var_.actorSpriteComps10093 = nil
			end

			local var_44_16 = arg_41_1.actors_["10093"].transform
			local var_44_17 = 0

			if var_44_17 < arg_41_1.time_ and arg_41_1.time_ <= var_44_17 + arg_44_0 then
				arg_41_1.var_.moveOldPos10093 = var_44_16.localPosition
				var_44_16.localScale = Vector3.New(1, 1, 1)

				arg_41_1:CheckSpriteTmpPos("10093", 4)

				local var_44_18 = var_44_16.childCount

				for iter_44_8 = 0, var_44_18 - 1 do
					local var_44_19 = var_44_16:GetChild(iter_44_8)

					if var_44_19.name == "" or not string.find(var_44_19.name, "split") then
						var_44_19.gameObject:SetActive(true)
					else
						var_44_19.gameObject:SetActive(false)
					end
				end
			end

			local var_44_20 = 0.001

			if var_44_17 <= arg_41_1.time_ and arg_41_1.time_ < var_44_17 + var_44_20 then
				local var_44_21 = (arg_41_1.time_ - var_44_17) / var_44_20
				local var_44_22 = Vector3.New(390, -345, -245)

				var_44_16.localPosition = Vector3.Lerp(arg_41_1.var_.moveOldPos10093, var_44_22, var_44_21)
			end

			if arg_41_1.time_ >= var_44_17 + var_44_20 and arg_41_1.time_ < var_44_17 + var_44_20 + arg_44_0 then
				var_44_16.localPosition = Vector3.New(390, -345, -245)
			end

			local var_44_23 = 0
			local var_44_24 = 0.75

			if var_44_23 < arg_41_1.time_ and arg_41_1.time_ <= var_44_23 + arg_44_0 then
				arg_41_1.talkMaxDuration = 0
				arg_41_1.dialogCg_.alpha = 1

				arg_41_1.dialog_:SetActive(true)
				SetActive(arg_41_1.leftNameGo_, true)

				local var_44_25 = arg_41_1:FormatText(StoryNameCfg[28].name)

				arg_41_1.leftNameTxt_.text = var_44_25

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_41_1.leftNameTxt_.transform)

				arg_41_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_41_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_41_1:RecordName(arg_41_1.leftNameTxt_.text)
				SetActive(arg_41_1.iconTrs_.gameObject, false)
				arg_41_1.callingController_:SetSelectedState("normal")

				local var_44_26 = arg_41_1:GetWordFromCfg(413141010)
				local var_44_27 = arg_41_1:FormatText(var_44_26.content)

				arg_41_1.text_.text = var_44_27

				LuaForUtil.ClearLinePrefixSymbol(arg_41_1.text_)

				local var_44_28 = 30
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

				if manager.audio:GetVoiceLength("story_v_out_413141", "413141010", "story_v_out_413141.awb") ~= 0 then
					local var_44_31 = manager.audio:GetVoiceLength("story_v_out_413141", "413141010", "story_v_out_413141.awb") / 1000

					if var_44_31 + var_44_23 > arg_41_1.duration_ then
						arg_41_1.duration_ = var_44_31 + var_44_23
					end

					if var_44_26.prefab_name ~= "" and arg_41_1.actors_[var_44_26.prefab_name] ~= nil then
						local var_44_32 = LuaForUtil.PlayVoiceWithCriLipsync(arg_41_1.actors_[var_44_26.prefab_name].transform, "story_v_out_413141", "413141010", "story_v_out_413141.awb")

						arg_41_1:RecordAudio("413141010", var_44_32)
						arg_41_1:RecordAudio("413141010", var_44_32)
					else
						arg_41_1:AudioAction("play", "voice", "story_v_out_413141", "413141010", "story_v_out_413141.awb")
					end

					arg_41_1:RecordHistoryTalkVoice("story_v_out_413141", "413141010", "story_v_out_413141.awb")
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
				actorName = "10093",
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
	Play413141011 = function(arg_45_0, arg_45_1)
		arg_45_1.time_ = 0
		arg_45_1.frameCnt_ = 0
		arg_45_1.state_ = "playing"
		arg_45_1.curTalkId_ = 413141011
		arg_45_1.duration_ = 2.87

		local var_45_0 = {
			zh = 1.999999999999,
			ja = 2.866
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
				arg_45_0:Play413141012(arg_45_1)
			end
		end

		function arg_45_1.onSingleLineUpdate_(arg_48_0)
			local var_48_0 = arg_45_1.actors_["10092_1"].transform
			local var_48_1 = 0

			if var_48_1 < arg_45_1.time_ and arg_45_1.time_ <= var_48_1 + arg_48_0 then
				arg_45_1.var_.moveOldPos10092_1 = var_48_0.localPosition
				var_48_0.localScale = Vector3.New(1, 1, 1)

				arg_45_1:CheckSpriteTmpPos("10092_1", 2)

				local var_48_2 = var_48_0.childCount

				for iter_48_0 = 0, var_48_2 - 1 do
					local var_48_3 = var_48_0:GetChild(iter_48_0)

					if var_48_3.name == "" or not string.find(var_48_3.name, "split") then
						var_48_3.gameObject:SetActive(true)
					else
						var_48_3.gameObject:SetActive(false)
					end
				end
			end

			local var_48_4 = 0.001

			if var_48_1 <= arg_45_1.time_ and arg_45_1.time_ < var_48_1 + var_48_4 then
				local var_48_5 = (arg_45_1.time_ - var_48_1) / var_48_4
				local var_48_6 = Vector3.New(-389.49, -300, -295)

				var_48_0.localPosition = Vector3.Lerp(arg_45_1.var_.moveOldPos10092_1, var_48_6, var_48_5)
			end

			if arg_45_1.time_ >= var_48_1 + var_48_4 and arg_45_1.time_ < var_48_1 + var_48_4 + arg_48_0 then
				var_48_0.localPosition = Vector3.New(-389.49, -300, -295)
			end

			local var_48_7 = arg_45_1.actors_["10092_1"]
			local var_48_8 = 0

			if var_48_8 < arg_45_1.time_ and arg_45_1.time_ <= var_48_8 + arg_48_0 and not isNil(var_48_7) and arg_45_1.var_.actorSpriteComps10092_1 == nil then
				arg_45_1.var_.actorSpriteComps10092_1 = var_48_7:GetComponentsInChildren(typeof(Image), true)
			end

			local var_48_9 = 2

			if var_48_8 <= arg_45_1.time_ and arg_45_1.time_ < var_48_8 + var_48_9 and not isNil(var_48_7) then
				local var_48_10 = (arg_45_1.time_ - var_48_8) / var_48_9

				if arg_45_1.var_.actorSpriteComps10092_1 then
					for iter_48_1, iter_48_2 in pairs(arg_45_1.var_.actorSpriteComps10092_1:ToTable()) do
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

			if arg_45_1.time_ >= var_48_8 + var_48_9 and arg_45_1.time_ < var_48_8 + var_48_9 + arg_48_0 and not isNil(var_48_7) and arg_45_1.var_.actorSpriteComps10092_1 then
				for iter_48_3, iter_48_4 in pairs(arg_45_1.var_.actorSpriteComps10092_1:ToTable()) do
					if iter_48_4 then
						if arg_45_1.isInRecall_ then
							iter_48_4.color = arg_45_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_48_4.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_45_1.var_.actorSpriteComps10092_1 = nil
			end

			local var_48_15 = arg_45_1.actors_["10093"]
			local var_48_16 = 0

			if var_48_16 < arg_45_1.time_ and arg_45_1.time_ <= var_48_16 + arg_48_0 and not isNil(var_48_15) and arg_45_1.var_.actorSpriteComps10093 == nil then
				arg_45_1.var_.actorSpriteComps10093 = var_48_15:GetComponentsInChildren(typeof(Image), true)
			end

			local var_48_17 = 2

			if var_48_16 <= arg_45_1.time_ and arg_45_1.time_ < var_48_16 + var_48_17 and not isNil(var_48_15) then
				local var_48_18 = (arg_45_1.time_ - var_48_16) / var_48_17

				if arg_45_1.var_.actorSpriteComps10093 then
					for iter_48_5, iter_48_6 in pairs(arg_45_1.var_.actorSpriteComps10093:ToTable()) do
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

			if arg_45_1.time_ >= var_48_16 + var_48_17 and arg_45_1.time_ < var_48_16 + var_48_17 + arg_48_0 and not isNil(var_48_15) and arg_45_1.var_.actorSpriteComps10093 then
				for iter_48_7, iter_48_8 in pairs(arg_45_1.var_.actorSpriteComps10093:ToTable()) do
					if iter_48_8 then
						if arg_45_1.isInRecall_ then
							iter_48_8.color = arg_45_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_48_8.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_45_1.var_.actorSpriteComps10093 = nil
			end

			local var_48_23 = arg_45_1.actors_["10093"].transform
			local var_48_24 = 0

			if var_48_24 < arg_45_1.time_ and arg_45_1.time_ <= var_48_24 + arg_48_0 then
				arg_45_1.var_.moveOldPos10093 = var_48_23.localPosition
				var_48_23.localScale = Vector3.New(1, 1, 1)

				arg_45_1:CheckSpriteTmpPos("10093", 4)

				local var_48_25 = var_48_23.childCount

				for iter_48_9 = 0, var_48_25 - 1 do
					local var_48_26 = var_48_23:GetChild(iter_48_9)

					if var_48_26.name == "" or not string.find(var_48_26.name, "split") then
						var_48_26.gameObject:SetActive(true)
					else
						var_48_26.gameObject:SetActive(false)
					end
				end
			end

			local var_48_27 = 0.001

			if var_48_24 <= arg_45_1.time_ and arg_45_1.time_ < var_48_24 + var_48_27 then
				local var_48_28 = (arg_45_1.time_ - var_48_24) / var_48_27
				local var_48_29 = Vector3.New(390, -345, -245)

				var_48_23.localPosition = Vector3.Lerp(arg_45_1.var_.moveOldPos10093, var_48_29, var_48_28)
			end

			if arg_45_1.time_ >= var_48_24 + var_48_27 and arg_45_1.time_ < var_48_24 + var_48_27 + arg_48_0 then
				var_48_23.localPosition = Vector3.New(390, -345, -245)
			end

			local var_48_30 = 0
			local var_48_31 = 0.175

			if var_48_30 < arg_45_1.time_ and arg_45_1.time_ <= var_48_30 + arg_48_0 then
				arg_45_1.talkMaxDuration = 0
				arg_45_1.dialogCg_.alpha = 1

				arg_45_1.dialog_:SetActive(true)
				SetActive(arg_45_1.leftNameGo_, true)

				local var_48_32 = arg_45_1:FormatText(StoryNameCfg[996].name)

				arg_45_1.leftNameTxt_.text = var_48_32

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_45_1.leftNameTxt_.transform)

				arg_45_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_45_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_45_1:RecordName(arg_45_1.leftNameTxt_.text)
				SetActive(arg_45_1.iconTrs_.gameObject, false)
				arg_45_1.callingController_:SetSelectedState("normal")

				local var_48_33 = arg_45_1:GetWordFromCfg(413141011)
				local var_48_34 = arg_45_1:FormatText(var_48_33.content)

				arg_45_1.text_.text = var_48_34

				LuaForUtil.ClearLinePrefixSymbol(arg_45_1.text_)

				local var_48_35 = 7
				local var_48_36 = utf8.len(var_48_34)
				local var_48_37 = var_48_35 <= 0 and var_48_31 or var_48_31 * (var_48_36 / var_48_35)

				if var_48_37 > 0 and var_48_31 < var_48_37 then
					arg_45_1.talkMaxDuration = var_48_37

					if var_48_37 + var_48_30 > arg_45_1.duration_ then
						arg_45_1.duration_ = var_48_37 + var_48_30
					end
				end

				arg_45_1.text_.text = var_48_34
				arg_45_1.typewritter.percent = 0

				arg_45_1.typewritter:SetDirty()
				arg_45_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_413141", "413141011", "story_v_out_413141.awb") ~= 0 then
					local var_48_38 = manager.audio:GetVoiceLength("story_v_out_413141", "413141011", "story_v_out_413141.awb") / 1000

					if var_48_38 + var_48_30 > arg_45_1.duration_ then
						arg_45_1.duration_ = var_48_38 + var_48_30
					end

					if var_48_33.prefab_name ~= "" and arg_45_1.actors_[var_48_33.prefab_name] ~= nil then
						local var_48_39 = LuaForUtil.PlayVoiceWithCriLipsync(arg_45_1.actors_[var_48_33.prefab_name].transform, "story_v_out_413141", "413141011", "story_v_out_413141.awb")

						arg_45_1:RecordAudio("413141011", var_48_39)
						arg_45_1:RecordAudio("413141011", var_48_39)
					else
						arg_45_1:AudioAction("play", "voice", "story_v_out_413141", "413141011", "story_v_out_413141.awb")
					end

					arg_45_1:RecordHistoryTalkVoice("story_v_out_413141", "413141011", "story_v_out_413141.awb")
				end

				arg_45_1:RecordContent(arg_45_1.text_.text)
			end

			local var_48_40 = math.max(var_48_31, arg_45_1.talkMaxDuration)

			if var_48_30 <= arg_45_1.time_ and arg_45_1.time_ < var_48_30 + var_48_40 then
				arg_45_1.typewritter.percent = (arg_45_1.time_ - var_48_30) / var_48_40

				arg_45_1.typewritter:SetDirty()
			end

			if arg_45_1.time_ >= var_48_30 + var_48_40 and arg_45_1.time_ < var_48_30 + var_48_40 + arg_48_0 then
				arg_45_1.typewritter.percent = 1

				arg_45_1.typewritter:SetDirty()
				arg_45_1:ShowNextGo(true)
			end
		end

		arg_45_1.nodeConfigList_ = {
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

		arg_45_1:InitPlayNodeList()
	end,
	Play413141012 = function(arg_49_0, arg_49_1)
		arg_49_1.time_ = 0
		arg_49_1.frameCnt_ = 0
		arg_49_1.state_ = "playing"
		arg_49_1.curTalkId_ = 413141012
		arg_49_1.duration_ = 5

		SetActive(arg_49_1.tipsGo_, false)

		function arg_49_1.onSingleLineFinish_()
			arg_49_1.onSingleLineUpdate_ = nil
			arg_49_1.onSingleLineFinish_ = nil
			arg_49_1.state_ = "waiting"
		end

		function arg_49_1.playNext_(arg_51_0)
			if arg_51_0 == 1 then
				arg_49_0:Play413141013(arg_49_1)
			end
		end

		function arg_49_1.onSingleLineUpdate_(arg_52_0)
			local var_52_0 = arg_49_1.actors_["10092_1"].transform
			local var_52_1 = 0

			if var_52_1 < arg_49_1.time_ and arg_49_1.time_ <= var_52_1 + arg_52_0 then
				arg_49_1.var_.moveOldPos10092_1 = var_52_0.localPosition
				var_52_0.localScale = Vector3.New(1, 1, 1)

				arg_49_1:CheckSpriteTmpPos("10092_1", 7)

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
				local var_52_6 = Vector3.New(0, -2000, 0)

				var_52_0.localPosition = Vector3.Lerp(arg_49_1.var_.moveOldPos10092_1, var_52_6, var_52_5)
			end

			if arg_49_1.time_ >= var_52_1 + var_52_4 and arg_49_1.time_ < var_52_1 + var_52_4 + arg_52_0 then
				var_52_0.localPosition = Vector3.New(0, -2000, 0)
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
								local var_52_11 = Mathf.Lerp(iter_52_2.color.r, arg_49_1.hightColor2.r, var_52_10)
								local var_52_12 = Mathf.Lerp(iter_52_2.color.g, arg_49_1.hightColor2.g, var_52_10)
								local var_52_13 = Mathf.Lerp(iter_52_2.color.b, arg_49_1.hightColor2.b, var_52_10)

								iter_52_2.color = Color.New(var_52_11, var_52_12, var_52_13)
							else
								local var_52_14 = Mathf.Lerp(iter_52_2.color.r, 0.5, var_52_10)

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
							iter_52_4.color = arg_49_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_52_4.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_49_1.var_.actorSpriteComps10092_1 = nil
			end

			local var_52_15 = arg_49_1.actors_["10093"].transform
			local var_52_16 = 0

			if var_52_16 < arg_49_1.time_ and arg_49_1.time_ <= var_52_16 + arg_52_0 then
				arg_49_1.var_.moveOldPos10093 = var_52_15.localPosition
				var_52_15.localScale = Vector3.New(1, 1, 1)

				arg_49_1:CheckSpriteTmpPos("10093", 7)

				local var_52_17 = var_52_15.childCount

				for iter_52_5 = 0, var_52_17 - 1 do
					local var_52_18 = var_52_15:GetChild(iter_52_5)

					if var_52_18.name == "split_7" or not string.find(var_52_18.name, "split") then
						var_52_18.gameObject:SetActive(true)
					else
						var_52_18.gameObject:SetActive(false)
					end
				end
			end

			local var_52_19 = 0.001

			if var_52_16 <= arg_49_1.time_ and arg_49_1.time_ < var_52_16 + var_52_19 then
				local var_52_20 = (arg_49_1.time_ - var_52_16) / var_52_19
				local var_52_21 = Vector3.New(0, -2000, 0)

				var_52_15.localPosition = Vector3.Lerp(arg_49_1.var_.moveOldPos10093, var_52_21, var_52_20)
			end

			if arg_49_1.time_ >= var_52_16 + var_52_19 and arg_49_1.time_ < var_52_16 + var_52_19 + arg_52_0 then
				var_52_15.localPosition = Vector3.New(0, -2000, 0)
			end

			local var_52_22 = 0
			local var_52_23 = 1.25

			if var_52_22 < arg_49_1.time_ and arg_49_1.time_ <= var_52_22 + arg_52_0 then
				arg_49_1.talkMaxDuration = 0
				arg_49_1.dialogCg_.alpha = 1

				arg_49_1.dialog_:SetActive(true)
				SetActive(arg_49_1.leftNameGo_, false)

				arg_49_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_49_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_49_1:RecordName(arg_49_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_49_1.iconTrs_.gameObject, false)
				arg_49_1.callingController_:SetSelectedState("normal")

				local var_52_24 = arg_49_1:GetWordFromCfg(413141012)
				local var_52_25 = arg_49_1:FormatText(var_52_24.content)

				arg_49_1.text_.text = var_52_25

				LuaForUtil.ClearLinePrefixSymbol(arg_49_1.text_)

				local var_52_26 = 50
				local var_52_27 = utf8.len(var_52_25)
				local var_52_28 = var_52_26 <= 0 and var_52_23 or var_52_23 * (var_52_27 / var_52_26)

				if var_52_28 > 0 and var_52_23 < var_52_28 then
					arg_49_1.talkMaxDuration = var_52_28

					if var_52_28 + var_52_22 > arg_49_1.duration_ then
						arg_49_1.duration_ = var_52_28 + var_52_22
					end
				end

				arg_49_1.text_.text = var_52_25
				arg_49_1.typewritter.percent = 0

				arg_49_1.typewritter:SetDirty()
				arg_49_1:ShowNextGo(false)
				arg_49_1:RecordContent(arg_49_1.text_.text)
			end

			local var_52_29 = math.max(var_52_23, arg_49_1.talkMaxDuration)

			if var_52_22 <= arg_49_1.time_ and arg_49_1.time_ < var_52_22 + var_52_29 then
				arg_49_1.typewritter.percent = (arg_49_1.time_ - var_52_22) / var_52_29

				arg_49_1.typewritter:SetDirty()
			end

			if arg_49_1.time_ >= var_52_22 + var_52_29 and arg_49_1.time_ < var_52_22 + var_52_29 + arg_52_0 then
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

		arg_49_1:InitPlayNodeList()
	end,
	Play413141013 = function(arg_53_0, arg_53_1)
		arg_53_1.time_ = 0
		arg_53_1.frameCnt_ = 0
		arg_53_1.state_ = "playing"
		arg_53_1.curTalkId_ = 413141013
		arg_53_1.duration_ = 6.4

		local var_53_0 = {
			zh = 4.566,
			ja = 6.4
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
				arg_53_0:Play413141014(arg_53_1)
			end
		end

		function arg_53_1.onSingleLineUpdate_(arg_56_0)
			local var_56_0 = arg_53_1.actors_["10093"].transform
			local var_56_1 = 0

			if var_56_1 < arg_53_1.time_ and arg_53_1.time_ <= var_56_1 + arg_56_0 then
				arg_53_1.var_.moveOldPos10093 = var_56_0.localPosition
				var_56_0.localScale = Vector3.New(1, 1, 1)

				arg_53_1:CheckSpriteTmpPos("10093", 4)

				local var_56_2 = var_56_0.childCount

				for iter_56_0 = 0, var_56_2 - 1 do
					local var_56_3 = var_56_0:GetChild(iter_56_0)

					if var_56_3.name == "split_5" or not string.find(var_56_3.name, "split") then
						var_56_3.gameObject:SetActive(true)
					else
						var_56_3.gameObject:SetActive(false)
					end
				end
			end

			local var_56_4 = 0.001

			if var_56_1 <= arg_53_1.time_ and arg_53_1.time_ < var_56_1 + var_56_4 then
				local var_56_5 = (arg_53_1.time_ - var_56_1) / var_56_4
				local var_56_6 = Vector3.New(390, -345, -245)

				var_56_0.localPosition = Vector3.Lerp(arg_53_1.var_.moveOldPos10093, var_56_6, var_56_5)
			end

			if arg_53_1.time_ >= var_56_1 + var_56_4 and arg_53_1.time_ < var_56_1 + var_56_4 + arg_56_0 then
				var_56_0.localPosition = Vector3.New(390, -345, -245)
			end

			local var_56_7 = arg_53_1.actors_["10093"]
			local var_56_8 = 0

			if var_56_8 < arg_53_1.time_ and arg_53_1.time_ <= var_56_8 + arg_56_0 and not isNil(var_56_7) and arg_53_1.var_.actorSpriteComps10093 == nil then
				arg_53_1.var_.actorSpriteComps10093 = var_56_7:GetComponentsInChildren(typeof(Image), true)
			end

			local var_56_9 = 2

			if var_56_8 <= arg_53_1.time_ and arg_53_1.time_ < var_56_8 + var_56_9 and not isNil(var_56_7) then
				local var_56_10 = (arg_53_1.time_ - var_56_8) / var_56_9

				if arg_53_1.var_.actorSpriteComps10093 then
					for iter_56_1, iter_56_2 in pairs(arg_53_1.var_.actorSpriteComps10093:ToTable()) do
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

			if arg_53_1.time_ >= var_56_8 + var_56_9 and arg_53_1.time_ < var_56_8 + var_56_9 + arg_56_0 and not isNil(var_56_7) and arg_53_1.var_.actorSpriteComps10093 then
				for iter_56_3, iter_56_4 in pairs(arg_53_1.var_.actorSpriteComps10093:ToTable()) do
					if iter_56_4 then
						if arg_53_1.isInRecall_ then
							iter_56_4.color = arg_53_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_56_4.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_53_1.var_.actorSpriteComps10093 = nil
			end

			local var_56_15 = 0
			local var_56_16 = 0.475

			if var_56_15 < arg_53_1.time_ and arg_53_1.time_ <= var_56_15 + arg_56_0 then
				arg_53_1.talkMaxDuration = 0
				arg_53_1.dialogCg_.alpha = 1

				arg_53_1.dialog_:SetActive(true)
				SetActive(arg_53_1.leftNameGo_, true)

				local var_56_17 = arg_53_1:FormatText(StoryNameCfg[28].name)

				arg_53_1.leftNameTxt_.text = var_56_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_53_1.leftNameTxt_.transform)

				arg_53_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_53_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_53_1:RecordName(arg_53_1.leftNameTxt_.text)
				SetActive(arg_53_1.iconTrs_.gameObject, false)
				arg_53_1.callingController_:SetSelectedState("normal")

				local var_56_18 = arg_53_1:GetWordFromCfg(413141013)
				local var_56_19 = arg_53_1:FormatText(var_56_18.content)

				arg_53_1.text_.text = var_56_19

				LuaForUtil.ClearLinePrefixSymbol(arg_53_1.text_)

				local var_56_20 = 19
				local var_56_21 = utf8.len(var_56_19)
				local var_56_22 = var_56_20 <= 0 and var_56_16 or var_56_16 * (var_56_21 / var_56_20)

				if var_56_22 > 0 and var_56_16 < var_56_22 then
					arg_53_1.talkMaxDuration = var_56_22

					if var_56_22 + var_56_15 > arg_53_1.duration_ then
						arg_53_1.duration_ = var_56_22 + var_56_15
					end
				end

				arg_53_1.text_.text = var_56_19
				arg_53_1.typewritter.percent = 0

				arg_53_1.typewritter:SetDirty()
				arg_53_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_413141", "413141013", "story_v_out_413141.awb") ~= 0 then
					local var_56_23 = manager.audio:GetVoiceLength("story_v_out_413141", "413141013", "story_v_out_413141.awb") / 1000

					if var_56_23 + var_56_15 > arg_53_1.duration_ then
						arg_53_1.duration_ = var_56_23 + var_56_15
					end

					if var_56_18.prefab_name ~= "" and arg_53_1.actors_[var_56_18.prefab_name] ~= nil then
						local var_56_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_53_1.actors_[var_56_18.prefab_name].transform, "story_v_out_413141", "413141013", "story_v_out_413141.awb")

						arg_53_1:RecordAudio("413141013", var_56_24)
						arg_53_1:RecordAudio("413141013", var_56_24)
					else
						arg_53_1:AudioAction("play", "voice", "story_v_out_413141", "413141013", "story_v_out_413141.awb")
					end

					arg_53_1:RecordHistoryTalkVoice("story_v_out_413141", "413141013", "story_v_out_413141.awb")
				end

				arg_53_1:RecordContent(arg_53_1.text_.text)
			end

			local var_56_25 = math.max(var_56_16, arg_53_1.talkMaxDuration)

			if var_56_15 <= arg_53_1.time_ and arg_53_1.time_ < var_56_15 + var_56_25 then
				arg_53_1.typewritter.percent = (arg_53_1.time_ - var_56_15) / var_56_25

				arg_53_1.typewritter:SetDirty()
			end

			if arg_53_1.time_ >= var_56_15 + var_56_25 and arg_53_1.time_ < var_56_15 + var_56_25 + arg_56_0 then
				arg_53_1.typewritter.percent = 1

				arg_53_1.typewritter:SetDirty()
				arg_53_1:ShowNextGo(true)
			end
		end

		arg_53_1.nodeConfigList_ = {
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

		arg_53_1:InitPlayNodeList()
	end,
	Play413141014 = function(arg_57_0, arg_57_1)
		arg_57_1.time_ = 0
		arg_57_1.frameCnt_ = 0
		arg_57_1.state_ = "playing"
		arg_57_1.curTalkId_ = 413141014
		arg_57_1.duration_ = 11.1

		local var_57_0 = {
			zh = 7,
			ja = 11.1
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
				arg_57_0:Play413141015(arg_57_1)
			end
		end

		function arg_57_1.onSingleLineUpdate_(arg_60_0)
			local var_60_0 = arg_57_1.actors_["10092_1"]
			local var_60_1 = 0

			if var_60_1 < arg_57_1.time_ and arg_57_1.time_ <= var_60_1 + arg_60_0 and not isNil(var_60_0) and arg_57_1.var_.actorSpriteComps10092_1 == nil then
				arg_57_1.var_.actorSpriteComps10092_1 = var_60_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_60_2 = 2

			if var_60_1 <= arg_57_1.time_ and arg_57_1.time_ < var_60_1 + var_60_2 and not isNil(var_60_0) then
				local var_60_3 = (arg_57_1.time_ - var_60_1) / var_60_2

				if arg_57_1.var_.actorSpriteComps10092_1 then
					for iter_60_0, iter_60_1 in pairs(arg_57_1.var_.actorSpriteComps10092_1:ToTable()) do
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

			if arg_57_1.time_ >= var_60_1 + var_60_2 and arg_57_1.time_ < var_60_1 + var_60_2 + arg_60_0 and not isNil(var_60_0) and arg_57_1.var_.actorSpriteComps10092_1 then
				for iter_60_2, iter_60_3 in pairs(arg_57_1.var_.actorSpriteComps10092_1:ToTable()) do
					if iter_60_3 then
						if arg_57_1.isInRecall_ then
							iter_60_3.color = arg_57_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_60_3.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_57_1.var_.actorSpriteComps10092_1 = nil
			end

			local var_60_8 = arg_57_1.actors_["10093"]
			local var_60_9 = 0

			if var_60_9 < arg_57_1.time_ and arg_57_1.time_ <= var_60_9 + arg_60_0 and not isNil(var_60_8) and arg_57_1.var_.actorSpriteComps10093 == nil then
				arg_57_1.var_.actorSpriteComps10093 = var_60_8:GetComponentsInChildren(typeof(Image), true)
			end

			local var_60_10 = 2

			if var_60_9 <= arg_57_1.time_ and arg_57_1.time_ < var_60_9 + var_60_10 and not isNil(var_60_8) then
				local var_60_11 = (arg_57_1.time_ - var_60_9) / var_60_10

				if arg_57_1.var_.actorSpriteComps10093 then
					for iter_60_4, iter_60_5 in pairs(arg_57_1.var_.actorSpriteComps10093:ToTable()) do
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

			if arg_57_1.time_ >= var_60_9 + var_60_10 and arg_57_1.time_ < var_60_9 + var_60_10 + arg_60_0 and not isNil(var_60_8) and arg_57_1.var_.actorSpriteComps10093 then
				for iter_60_6, iter_60_7 in pairs(arg_57_1.var_.actorSpriteComps10093:ToTable()) do
					if iter_60_7 then
						if arg_57_1.isInRecall_ then
							iter_60_7.color = arg_57_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_60_7.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_57_1.var_.actorSpriteComps10093 = nil
			end

			local var_60_16 = arg_57_1.actors_["10092_1"].transform
			local var_60_17 = 0

			if var_60_17 < arg_57_1.time_ and arg_57_1.time_ <= var_60_17 + arg_60_0 then
				arg_57_1.var_.moveOldPos10092_1 = var_60_16.localPosition
				var_60_16.localScale = Vector3.New(1, 1, 1)

				arg_57_1:CheckSpriteTmpPos("10092_1", 2)

				local var_60_18 = var_60_16.childCount

				for iter_60_8 = 0, var_60_18 - 1 do
					local var_60_19 = var_60_16:GetChild(iter_60_8)

					if var_60_19.name == "" or not string.find(var_60_19.name, "split") then
						var_60_19.gameObject:SetActive(true)
					else
						var_60_19.gameObject:SetActive(false)
					end
				end
			end

			local var_60_20 = 0.001

			if var_60_17 <= arg_57_1.time_ and arg_57_1.time_ < var_60_17 + var_60_20 then
				local var_60_21 = (arg_57_1.time_ - var_60_17) / var_60_20
				local var_60_22 = Vector3.New(-389.49, -300, -295)

				var_60_16.localPosition = Vector3.Lerp(arg_57_1.var_.moveOldPos10092_1, var_60_22, var_60_21)
			end

			if arg_57_1.time_ >= var_60_17 + var_60_20 and arg_57_1.time_ < var_60_17 + var_60_20 + arg_60_0 then
				var_60_16.localPosition = Vector3.New(-389.49, -300, -295)
			end

			local var_60_23 = 0
			local var_60_24 = 0.925

			if var_60_23 < arg_57_1.time_ and arg_57_1.time_ <= var_60_23 + arg_60_0 then
				arg_57_1.talkMaxDuration = 0
				arg_57_1.dialogCg_.alpha = 1

				arg_57_1.dialog_:SetActive(true)
				SetActive(arg_57_1.leftNameGo_, true)

				local var_60_25 = arg_57_1:FormatText(StoryNameCfg[996].name)

				arg_57_1.leftNameTxt_.text = var_60_25

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_57_1.leftNameTxt_.transform)

				arg_57_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_57_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_57_1:RecordName(arg_57_1.leftNameTxt_.text)
				SetActive(arg_57_1.iconTrs_.gameObject, false)
				arg_57_1.callingController_:SetSelectedState("normal")

				local var_60_26 = arg_57_1:GetWordFromCfg(413141014)
				local var_60_27 = arg_57_1:FormatText(var_60_26.content)

				arg_57_1.text_.text = var_60_27

				LuaForUtil.ClearLinePrefixSymbol(arg_57_1.text_)

				local var_60_28 = 37
				local var_60_29 = utf8.len(var_60_27)
				local var_60_30 = var_60_28 <= 0 and var_60_24 or var_60_24 * (var_60_29 / var_60_28)

				if var_60_30 > 0 and var_60_24 < var_60_30 then
					arg_57_1.talkMaxDuration = var_60_30

					if var_60_30 + var_60_23 > arg_57_1.duration_ then
						arg_57_1.duration_ = var_60_30 + var_60_23
					end
				end

				arg_57_1.text_.text = var_60_27
				arg_57_1.typewritter.percent = 0

				arg_57_1.typewritter:SetDirty()
				arg_57_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_413141", "413141014", "story_v_out_413141.awb") ~= 0 then
					local var_60_31 = manager.audio:GetVoiceLength("story_v_out_413141", "413141014", "story_v_out_413141.awb") / 1000

					if var_60_31 + var_60_23 > arg_57_1.duration_ then
						arg_57_1.duration_ = var_60_31 + var_60_23
					end

					if var_60_26.prefab_name ~= "" and arg_57_1.actors_[var_60_26.prefab_name] ~= nil then
						local var_60_32 = LuaForUtil.PlayVoiceWithCriLipsync(arg_57_1.actors_[var_60_26.prefab_name].transform, "story_v_out_413141", "413141014", "story_v_out_413141.awb")

						arg_57_1:RecordAudio("413141014", var_60_32)
						arg_57_1:RecordAudio("413141014", var_60_32)
					else
						arg_57_1:AudioAction("play", "voice", "story_v_out_413141", "413141014", "story_v_out_413141.awb")
					end

					arg_57_1:RecordHistoryTalkVoice("story_v_out_413141", "413141014", "story_v_out_413141.awb")
				end

				arg_57_1:RecordContent(arg_57_1.text_.text)
			end

			local var_60_33 = math.max(var_60_24, arg_57_1.talkMaxDuration)

			if var_60_23 <= arg_57_1.time_ and arg_57_1.time_ < var_60_23 + var_60_33 then
				arg_57_1.typewritter.percent = (arg_57_1.time_ - var_60_23) / var_60_33

				arg_57_1.typewritter:SetDirty()
			end

			if arg_57_1.time_ >= var_60_23 + var_60_33 and arg_57_1.time_ < var_60_23 + var_60_33 + arg_60_0 then
				arg_57_1.typewritter.percent = 1

				arg_57_1.typewritter:SetDirty()
				arg_57_1:ShowNextGo(true)
			end
		end

		arg_57_1.nodeConfigList_ = {
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

		arg_57_1:InitPlayNodeList()
	end,
	Play413141015 = function(arg_61_0, arg_61_1)
		arg_61_1.time_ = 0
		arg_61_1.frameCnt_ = 0
		arg_61_1.state_ = "playing"
		arg_61_1.curTalkId_ = 413141015
		arg_61_1.duration_ = 2.8

		local var_61_0 = {
			zh = 1.999999999999,
			ja = 2.8
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
				arg_61_0:Play413141016(arg_61_1)
			end
		end

		function arg_61_1.onSingleLineUpdate_(arg_64_0)
			local var_64_0 = arg_61_1.actors_["10092_1"]
			local var_64_1 = 0

			if var_64_1 < arg_61_1.time_ and arg_61_1.time_ <= var_64_1 + arg_64_0 and not isNil(var_64_0) and arg_61_1.var_.actorSpriteComps10092_1 == nil then
				arg_61_1.var_.actorSpriteComps10092_1 = var_64_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_64_2 = 2

			if var_64_1 <= arg_61_1.time_ and arg_61_1.time_ < var_64_1 + var_64_2 and not isNil(var_64_0) then
				local var_64_3 = (arg_61_1.time_ - var_64_1) / var_64_2

				if arg_61_1.var_.actorSpriteComps10092_1 then
					for iter_64_0, iter_64_1 in pairs(arg_61_1.var_.actorSpriteComps10092_1:ToTable()) do
						if iter_64_1 then
							if arg_61_1.isInRecall_ then
								local var_64_4 = Mathf.Lerp(iter_64_1.color.r, arg_61_1.hightColor2.r, var_64_3)
								local var_64_5 = Mathf.Lerp(iter_64_1.color.g, arg_61_1.hightColor2.g, var_64_3)
								local var_64_6 = Mathf.Lerp(iter_64_1.color.b, arg_61_1.hightColor2.b, var_64_3)

								iter_64_1.color = Color.New(var_64_4, var_64_5, var_64_6)
							else
								local var_64_7 = Mathf.Lerp(iter_64_1.color.r, 0.5, var_64_3)

								iter_64_1.color = Color.New(var_64_7, var_64_7, var_64_7)
							end
						end
					end
				end
			end

			if arg_61_1.time_ >= var_64_1 + var_64_2 and arg_61_1.time_ < var_64_1 + var_64_2 + arg_64_0 and not isNil(var_64_0) and arg_61_1.var_.actorSpriteComps10092_1 then
				for iter_64_2, iter_64_3 in pairs(arg_61_1.var_.actorSpriteComps10092_1:ToTable()) do
					if iter_64_3 then
						if arg_61_1.isInRecall_ then
							iter_64_3.color = arg_61_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_64_3.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_61_1.var_.actorSpriteComps10092_1 = nil
			end

			local var_64_8 = arg_61_1.actors_["10093"]
			local var_64_9 = 0

			if var_64_9 < arg_61_1.time_ and arg_61_1.time_ <= var_64_9 + arg_64_0 and not isNil(var_64_8) and arg_61_1.var_.actorSpriteComps10093 == nil then
				arg_61_1.var_.actorSpriteComps10093 = var_64_8:GetComponentsInChildren(typeof(Image), true)
			end

			local var_64_10 = 2

			if var_64_9 <= arg_61_1.time_ and arg_61_1.time_ < var_64_9 + var_64_10 and not isNil(var_64_8) then
				local var_64_11 = (arg_61_1.time_ - var_64_9) / var_64_10

				if arg_61_1.var_.actorSpriteComps10093 then
					for iter_64_4, iter_64_5 in pairs(arg_61_1.var_.actorSpriteComps10093:ToTable()) do
						if iter_64_5 then
							if arg_61_1.isInRecall_ then
								local var_64_12 = Mathf.Lerp(iter_64_5.color.r, arg_61_1.hightColor1.r, var_64_11)
								local var_64_13 = Mathf.Lerp(iter_64_5.color.g, arg_61_1.hightColor1.g, var_64_11)
								local var_64_14 = Mathf.Lerp(iter_64_5.color.b, arg_61_1.hightColor1.b, var_64_11)

								iter_64_5.color = Color.New(var_64_12, var_64_13, var_64_14)
							else
								local var_64_15 = Mathf.Lerp(iter_64_5.color.r, 1, var_64_11)

								iter_64_5.color = Color.New(var_64_15, var_64_15, var_64_15)
							end
						end
					end
				end
			end

			if arg_61_1.time_ >= var_64_9 + var_64_10 and arg_61_1.time_ < var_64_9 + var_64_10 + arg_64_0 and not isNil(var_64_8) and arg_61_1.var_.actorSpriteComps10093 then
				for iter_64_6, iter_64_7 in pairs(arg_61_1.var_.actorSpriteComps10093:ToTable()) do
					if iter_64_7 then
						if arg_61_1.isInRecall_ then
							iter_64_7.color = arg_61_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_64_7.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_61_1.var_.actorSpriteComps10093 = nil
			end

			local var_64_16 = 0
			local var_64_17 = 0.2

			if var_64_16 < arg_61_1.time_ and arg_61_1.time_ <= var_64_16 + arg_64_0 then
				arg_61_1.talkMaxDuration = 0
				arg_61_1.dialogCg_.alpha = 1

				arg_61_1.dialog_:SetActive(true)
				SetActive(arg_61_1.leftNameGo_, true)

				local var_64_18 = arg_61_1:FormatText(StoryNameCfg[28].name)

				arg_61_1.leftNameTxt_.text = var_64_18

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_61_1.leftNameTxt_.transform)

				arg_61_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_61_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_61_1:RecordName(arg_61_1.leftNameTxt_.text)
				SetActive(arg_61_1.iconTrs_.gameObject, false)
				arg_61_1.callingController_:SetSelectedState("normal")

				local var_64_19 = arg_61_1:GetWordFromCfg(413141015)
				local var_64_20 = arg_61_1:FormatText(var_64_19.content)

				arg_61_1.text_.text = var_64_20

				LuaForUtil.ClearLinePrefixSymbol(arg_61_1.text_)

				local var_64_21 = 8
				local var_64_22 = utf8.len(var_64_20)
				local var_64_23 = var_64_21 <= 0 and var_64_17 or var_64_17 * (var_64_22 / var_64_21)

				if var_64_23 > 0 and var_64_17 < var_64_23 then
					arg_61_1.talkMaxDuration = var_64_23

					if var_64_23 + var_64_16 > arg_61_1.duration_ then
						arg_61_1.duration_ = var_64_23 + var_64_16
					end
				end

				arg_61_1.text_.text = var_64_20
				arg_61_1.typewritter.percent = 0

				arg_61_1.typewritter:SetDirty()
				arg_61_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_413141", "413141015", "story_v_out_413141.awb") ~= 0 then
					local var_64_24 = manager.audio:GetVoiceLength("story_v_out_413141", "413141015", "story_v_out_413141.awb") / 1000

					if var_64_24 + var_64_16 > arg_61_1.duration_ then
						arg_61_1.duration_ = var_64_24 + var_64_16
					end

					if var_64_19.prefab_name ~= "" and arg_61_1.actors_[var_64_19.prefab_name] ~= nil then
						local var_64_25 = LuaForUtil.PlayVoiceWithCriLipsync(arg_61_1.actors_[var_64_19.prefab_name].transform, "story_v_out_413141", "413141015", "story_v_out_413141.awb")

						arg_61_1:RecordAudio("413141015", var_64_25)
						arg_61_1:RecordAudio("413141015", var_64_25)
					else
						arg_61_1:AudioAction("play", "voice", "story_v_out_413141", "413141015", "story_v_out_413141.awb")
					end

					arg_61_1:RecordHistoryTalkVoice("story_v_out_413141", "413141015", "story_v_out_413141.awb")
				end

				arg_61_1:RecordContent(arg_61_1.text_.text)
			end

			local var_64_26 = math.max(var_64_17, arg_61_1.talkMaxDuration)

			if var_64_16 <= arg_61_1.time_ and arg_61_1.time_ < var_64_16 + var_64_26 then
				arg_61_1.typewritter.percent = (arg_61_1.time_ - var_64_16) / var_64_26

				arg_61_1.typewritter:SetDirty()
			end

			if arg_61_1.time_ >= var_64_16 + var_64_26 and arg_61_1.time_ < var_64_16 + var_64_26 + arg_64_0 then
				arg_61_1.typewritter.percent = 1

				arg_61_1.typewritter:SetDirty()
				arg_61_1:ShowNextGo(true)
			end
		end

		arg_61_1.nodeConfigList_ = {}

		arg_61_1:InitPlayNodeList()
	end,
	Play413141016 = function(arg_65_0, arg_65_1)
		arg_65_1.time_ = 0
		arg_65_1.frameCnt_ = 0
		arg_65_1.state_ = "playing"
		arg_65_1.curTalkId_ = 413141016
		arg_65_1.duration_ = 13.57

		local var_65_0 = {
			zh = 7.766,
			ja = 13.566
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
				arg_65_0:Play413141017(arg_65_1)
			end
		end

		function arg_65_1.onSingleLineUpdate_(arg_68_0)
			local var_68_0 = arg_65_1.actors_["10092_1"].transform
			local var_68_1 = 0

			if var_68_1 < arg_65_1.time_ and arg_65_1.time_ <= var_68_1 + arg_68_0 then
				arg_65_1.var_.moveOldPos10092_1 = var_68_0.localPosition
				var_68_0.localScale = Vector3.New(1, 1, 1)

				arg_65_1:CheckSpriteTmpPos("10092_1", 2)

				local var_68_2 = var_68_0.childCount

				for iter_68_0 = 0, var_68_2 - 1 do
					local var_68_3 = var_68_0:GetChild(iter_68_0)

					if var_68_3.name == "split_1_1" or not string.find(var_68_3.name, "split") then
						var_68_3.gameObject:SetActive(true)
					else
						var_68_3.gameObject:SetActive(false)
					end
				end
			end

			local var_68_4 = 0.001

			if var_68_1 <= arg_65_1.time_ and arg_65_1.time_ < var_68_1 + var_68_4 then
				local var_68_5 = (arg_65_1.time_ - var_68_1) / var_68_4
				local var_68_6 = Vector3.New(-389.49, -300, -295)

				var_68_0.localPosition = Vector3.Lerp(arg_65_1.var_.moveOldPos10092_1, var_68_6, var_68_5)
			end

			if arg_65_1.time_ >= var_68_1 + var_68_4 and arg_65_1.time_ < var_68_1 + var_68_4 + arg_68_0 then
				var_68_0.localPosition = Vector3.New(-389.49, -300, -295)
			end

			local var_68_7 = arg_65_1.actors_["10093"].transform
			local var_68_8 = 0

			if var_68_8 < arg_65_1.time_ and arg_65_1.time_ <= var_68_8 + arg_68_0 then
				arg_65_1.var_.moveOldPos10093 = var_68_7.localPosition
				var_68_7.localScale = Vector3.New(1, 1, 1)

				arg_65_1:CheckSpriteTmpPos("10093", 4)

				local var_68_9 = var_68_7.childCount

				for iter_68_1 = 0, var_68_9 - 1 do
					local var_68_10 = var_68_7:GetChild(iter_68_1)

					if var_68_10.name == "split_4" or not string.find(var_68_10.name, "split") then
						var_68_10.gameObject:SetActive(true)
					else
						var_68_10.gameObject:SetActive(false)
					end
				end
			end

			local var_68_11 = 0.001

			if var_68_8 <= arg_65_1.time_ and arg_65_1.time_ < var_68_8 + var_68_11 then
				local var_68_12 = (arg_65_1.time_ - var_68_8) / var_68_11
				local var_68_13 = Vector3.New(390, -345, -245)

				var_68_7.localPosition = Vector3.Lerp(arg_65_1.var_.moveOldPos10093, var_68_13, var_68_12)
			end

			if arg_65_1.time_ >= var_68_8 + var_68_11 and arg_65_1.time_ < var_68_8 + var_68_11 + arg_68_0 then
				var_68_7.localPosition = Vector3.New(390, -345, -245)
			end

			local var_68_14 = arg_65_1.actors_["10092_1"]
			local var_68_15 = 0

			if var_68_15 < arg_65_1.time_ and arg_65_1.time_ <= var_68_15 + arg_68_0 and not isNil(var_68_14) and arg_65_1.var_.actorSpriteComps10092_1 == nil then
				arg_65_1.var_.actorSpriteComps10092_1 = var_68_14:GetComponentsInChildren(typeof(Image), true)
			end

			local var_68_16 = 2

			if var_68_15 <= arg_65_1.time_ and arg_65_1.time_ < var_68_15 + var_68_16 and not isNil(var_68_14) then
				local var_68_17 = (arg_65_1.time_ - var_68_15) / var_68_16

				if arg_65_1.var_.actorSpriteComps10092_1 then
					for iter_68_2, iter_68_3 in pairs(arg_65_1.var_.actorSpriteComps10092_1:ToTable()) do
						if iter_68_3 then
							if arg_65_1.isInRecall_ then
								local var_68_18 = Mathf.Lerp(iter_68_3.color.r, arg_65_1.hightColor1.r, var_68_17)
								local var_68_19 = Mathf.Lerp(iter_68_3.color.g, arg_65_1.hightColor1.g, var_68_17)
								local var_68_20 = Mathf.Lerp(iter_68_3.color.b, arg_65_1.hightColor1.b, var_68_17)

								iter_68_3.color = Color.New(var_68_18, var_68_19, var_68_20)
							else
								local var_68_21 = Mathf.Lerp(iter_68_3.color.r, 1, var_68_17)

								iter_68_3.color = Color.New(var_68_21, var_68_21, var_68_21)
							end
						end
					end
				end
			end

			if arg_65_1.time_ >= var_68_15 + var_68_16 and arg_65_1.time_ < var_68_15 + var_68_16 + arg_68_0 and not isNil(var_68_14) and arg_65_1.var_.actorSpriteComps10092_1 then
				for iter_68_4, iter_68_5 in pairs(arg_65_1.var_.actorSpriteComps10092_1:ToTable()) do
					if iter_68_5 then
						if arg_65_1.isInRecall_ then
							iter_68_5.color = arg_65_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_68_5.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_65_1.var_.actorSpriteComps10092_1 = nil
			end

			local var_68_22 = arg_65_1.actors_["10093"]
			local var_68_23 = 0

			if var_68_23 < arg_65_1.time_ and arg_65_1.time_ <= var_68_23 + arg_68_0 and not isNil(var_68_22) and arg_65_1.var_.actorSpriteComps10093 == nil then
				arg_65_1.var_.actorSpriteComps10093 = var_68_22:GetComponentsInChildren(typeof(Image), true)
			end

			local var_68_24 = 2

			if var_68_23 <= arg_65_1.time_ and arg_65_1.time_ < var_68_23 + var_68_24 and not isNil(var_68_22) then
				local var_68_25 = (arg_65_1.time_ - var_68_23) / var_68_24

				if arg_65_1.var_.actorSpriteComps10093 then
					for iter_68_6, iter_68_7 in pairs(arg_65_1.var_.actorSpriteComps10093:ToTable()) do
						if iter_68_7 then
							if arg_65_1.isInRecall_ then
								local var_68_26 = Mathf.Lerp(iter_68_7.color.r, arg_65_1.hightColor2.r, var_68_25)
								local var_68_27 = Mathf.Lerp(iter_68_7.color.g, arg_65_1.hightColor2.g, var_68_25)
								local var_68_28 = Mathf.Lerp(iter_68_7.color.b, arg_65_1.hightColor2.b, var_68_25)

								iter_68_7.color = Color.New(var_68_26, var_68_27, var_68_28)
							else
								local var_68_29 = Mathf.Lerp(iter_68_7.color.r, 0.5, var_68_25)

								iter_68_7.color = Color.New(var_68_29, var_68_29, var_68_29)
							end
						end
					end
				end
			end

			if arg_65_1.time_ >= var_68_23 + var_68_24 and arg_65_1.time_ < var_68_23 + var_68_24 + arg_68_0 and not isNil(var_68_22) and arg_65_1.var_.actorSpriteComps10093 then
				for iter_68_8, iter_68_9 in pairs(arg_65_1.var_.actorSpriteComps10093:ToTable()) do
					if iter_68_9 then
						if arg_65_1.isInRecall_ then
							iter_68_9.color = arg_65_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_68_9.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_65_1.var_.actorSpriteComps10093 = nil
			end

			local var_68_30 = 0
			local var_68_31 = 0.825

			if var_68_30 < arg_65_1.time_ and arg_65_1.time_ <= var_68_30 + arg_68_0 then
				arg_65_1.talkMaxDuration = 0
				arg_65_1.dialogCg_.alpha = 1

				arg_65_1.dialog_:SetActive(true)
				SetActive(arg_65_1.leftNameGo_, true)

				local var_68_32 = arg_65_1:FormatText(StoryNameCfg[996].name)

				arg_65_1.leftNameTxt_.text = var_68_32

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_65_1.leftNameTxt_.transform)

				arg_65_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_65_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_65_1:RecordName(arg_65_1.leftNameTxt_.text)
				SetActive(arg_65_1.iconTrs_.gameObject, false)
				arg_65_1.callingController_:SetSelectedState("normal")

				local var_68_33 = arg_65_1:GetWordFromCfg(413141016)
				local var_68_34 = arg_65_1:FormatText(var_68_33.content)

				arg_65_1.text_.text = var_68_34

				LuaForUtil.ClearLinePrefixSymbol(arg_65_1.text_)

				local var_68_35 = 33
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

				if manager.audio:GetVoiceLength("story_v_out_413141", "413141016", "story_v_out_413141.awb") ~= 0 then
					local var_68_38 = manager.audio:GetVoiceLength("story_v_out_413141", "413141016", "story_v_out_413141.awb") / 1000

					if var_68_38 + var_68_30 > arg_65_1.duration_ then
						arg_65_1.duration_ = var_68_38 + var_68_30
					end

					if var_68_33.prefab_name ~= "" and arg_65_1.actors_[var_68_33.prefab_name] ~= nil then
						local var_68_39 = LuaForUtil.PlayVoiceWithCriLipsync(arg_65_1.actors_[var_68_33.prefab_name].transform, "story_v_out_413141", "413141016", "story_v_out_413141.awb")

						arg_65_1:RecordAudio("413141016", var_68_39)
						arg_65_1:RecordAudio("413141016", var_68_39)
					else
						arg_65_1:AudioAction("play", "voice", "story_v_out_413141", "413141016", "story_v_out_413141.awb")
					end

					arg_65_1:RecordHistoryTalkVoice("story_v_out_413141", "413141016", "story_v_out_413141.awb")
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

		arg_65_1:InitPlayNodeList()
	end,
	Play413141017 = function(arg_69_0, arg_69_1)
		arg_69_1.time_ = 0
		arg_69_1.frameCnt_ = 0
		arg_69_1.state_ = "playing"
		arg_69_1.curTalkId_ = 413141017
		arg_69_1.duration_ = 11.3

		local var_69_0 = {
			zh = 11.3,
			ja = 11.133
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
				arg_69_0:Play413141018(arg_69_1)
			end
		end

		function arg_69_1.onSingleLineUpdate_(arg_72_0)
			local var_72_0 = arg_69_1.actors_["10092_1"].transform
			local var_72_1 = 0

			if var_72_1 < arg_69_1.time_ and arg_69_1.time_ <= var_72_1 + arg_72_0 then
				arg_69_1.var_.moveOldPos10092_1 = var_72_0.localPosition
				var_72_0.localScale = Vector3.New(1, 1, 1)

				arg_69_1:CheckSpriteTmpPos("10092_1", 2)

				local var_72_2 = var_72_0.childCount

				for iter_72_0 = 0, var_72_2 - 1 do
					local var_72_3 = var_72_0:GetChild(iter_72_0)

					if var_72_3.name == "" or not string.find(var_72_3.name, "split") then
						var_72_3.gameObject:SetActive(true)
					else
						var_72_3.gameObject:SetActive(false)
					end
				end
			end

			local var_72_4 = 0.001

			if var_72_1 <= arg_69_1.time_ and arg_69_1.time_ < var_72_1 + var_72_4 then
				local var_72_5 = (arg_69_1.time_ - var_72_1) / var_72_4
				local var_72_6 = Vector3.New(-389.49, -300, -295)

				var_72_0.localPosition = Vector3.Lerp(arg_69_1.var_.moveOldPos10092_1, var_72_6, var_72_5)
			end

			if arg_69_1.time_ >= var_72_1 + var_72_4 and arg_69_1.time_ < var_72_1 + var_72_4 + arg_72_0 then
				var_72_0.localPosition = Vector3.New(-389.49, -300, -295)
			end

			local var_72_7 = "10092"

			if arg_69_1.actors_[var_72_7] == nil then
				local var_72_8 = Asset.Load("Widget/System/Story/StoryExpression/" .. "10092")

				if not isNil(var_72_8) then
					local var_72_9 = Object.Instantiate(var_72_8, arg_69_1.canvasGo_.transform)

					var_72_9.transform:SetSiblingIndex(1)

					var_72_9.name = var_72_7
					var_72_9.transform.localPosition = Vector3.New(0, 100000, 0)
					arg_69_1.actors_[var_72_7] = var_72_9

					local var_72_10 = var_72_9:GetComponentsInChildren(typeof(Image), true):ToTable()

					if arg_69_1.isInRecall_ then
						for iter_72_1, iter_72_2 in ipairs(var_72_10) do
							iter_72_2.color = arg_69_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						end
					end
				end
			end

			local var_72_11 = arg_69_1.actors_["10092"]
			local var_72_12 = 0

			if var_72_12 < arg_69_1.time_ and arg_69_1.time_ <= var_72_12 + arg_72_0 and not isNil(var_72_11) and arg_69_1.var_.actorSpriteComps10092 == nil then
				arg_69_1.var_.actorSpriteComps10092 = var_72_11:GetComponentsInChildren(typeof(Image), true)
			end

			local var_72_13 = 2

			if var_72_12 <= arg_69_1.time_ and arg_69_1.time_ < var_72_12 + var_72_13 and not isNil(var_72_11) then
				local var_72_14 = (arg_69_1.time_ - var_72_12) / var_72_13

				if arg_69_1.var_.actorSpriteComps10092 then
					for iter_72_3, iter_72_4 in pairs(arg_69_1.var_.actorSpriteComps10092:ToTable()) do
						if iter_72_4 then
							if arg_69_1.isInRecall_ then
								local var_72_15 = Mathf.Lerp(iter_72_4.color.r, arg_69_1.hightColor1.r, var_72_14)
								local var_72_16 = Mathf.Lerp(iter_72_4.color.g, arg_69_1.hightColor1.g, var_72_14)
								local var_72_17 = Mathf.Lerp(iter_72_4.color.b, arg_69_1.hightColor1.b, var_72_14)

								iter_72_4.color = Color.New(var_72_15, var_72_16, var_72_17)
							else
								local var_72_18 = Mathf.Lerp(iter_72_4.color.r, 1, var_72_14)

								iter_72_4.color = Color.New(var_72_18, var_72_18, var_72_18)
							end
						end
					end
				end
			end

			if arg_69_1.time_ >= var_72_12 + var_72_13 and arg_69_1.time_ < var_72_12 + var_72_13 + arg_72_0 and not isNil(var_72_11) and arg_69_1.var_.actorSpriteComps10092 then
				for iter_72_5, iter_72_6 in pairs(arg_69_1.var_.actorSpriteComps10092:ToTable()) do
					if iter_72_6 then
						if arg_69_1.isInRecall_ then
							iter_72_6.color = arg_69_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_72_6.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_69_1.var_.actorSpriteComps10092 = nil
			end

			local var_72_19 = 0
			local var_72_20 = 1.275

			if var_72_19 < arg_69_1.time_ and arg_69_1.time_ <= var_72_19 + arg_72_0 then
				arg_69_1.talkMaxDuration = 0
				arg_69_1.dialogCg_.alpha = 1

				arg_69_1.dialog_:SetActive(true)
				SetActive(arg_69_1.leftNameGo_, true)

				local var_72_21 = arg_69_1:FormatText(StoryNameCfg[996].name)

				arg_69_1.leftNameTxt_.text = var_72_21

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_69_1.leftNameTxt_.transform)

				arg_69_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_69_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_69_1:RecordName(arg_69_1.leftNameTxt_.text)
				SetActive(arg_69_1.iconTrs_.gameObject, false)
				arg_69_1.callingController_:SetSelectedState("normal")

				local var_72_22 = arg_69_1:GetWordFromCfg(413141017)
				local var_72_23 = arg_69_1:FormatText(var_72_22.content)

				arg_69_1.text_.text = var_72_23

				LuaForUtil.ClearLinePrefixSymbol(arg_69_1.text_)

				local var_72_24 = 51
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

				if manager.audio:GetVoiceLength("story_v_out_413141", "413141017", "story_v_out_413141.awb") ~= 0 then
					local var_72_27 = manager.audio:GetVoiceLength("story_v_out_413141", "413141017", "story_v_out_413141.awb") / 1000

					if var_72_27 + var_72_19 > arg_69_1.duration_ then
						arg_69_1.duration_ = var_72_27 + var_72_19
					end

					if var_72_22.prefab_name ~= "" and arg_69_1.actors_[var_72_22.prefab_name] ~= nil then
						local var_72_28 = LuaForUtil.PlayVoiceWithCriLipsync(arg_69_1.actors_[var_72_22.prefab_name].transform, "story_v_out_413141", "413141017", "story_v_out_413141.awb")

						arg_69_1:RecordAudio("413141017", var_72_28)
						arg_69_1:RecordAudio("413141017", var_72_28)
					else
						arg_69_1:AudioAction("play", "voice", "story_v_out_413141", "413141017", "story_v_out_413141.awb")
					end

					arg_69_1:RecordHistoryTalkVoice("story_v_out_413141", "413141017", "story_v_out_413141.awb")
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

		arg_69_1.nodeConfigList_ = {
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

		arg_69_1:InitPlayNodeList()
	end,
	Play413141018 = function(arg_73_0, arg_73_1)
		arg_73_1.time_ = 0
		arg_73_1.frameCnt_ = 0
		arg_73_1.state_ = "playing"
		arg_73_1.curTalkId_ = 413141018
		arg_73_1.duration_ = 7.33

		local var_73_0 = {
			zh = 7.333,
			ja = 4.7
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
				arg_73_0:Play413141019(arg_73_1)
			end
		end

		function arg_73_1.onSingleLineUpdate_(arg_76_0)
			local var_76_0 = arg_73_1.actors_["10092_1"]
			local var_76_1 = 0

			if var_76_1 < arg_73_1.time_ and arg_73_1.time_ <= var_76_1 + arg_76_0 and not isNil(var_76_0) and arg_73_1.var_.actorSpriteComps10092_1 == nil then
				arg_73_1.var_.actorSpriteComps10092_1 = var_76_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_76_2 = 2

			if var_76_1 <= arg_73_1.time_ and arg_73_1.time_ < var_76_1 + var_76_2 and not isNil(var_76_0) then
				local var_76_3 = (arg_73_1.time_ - var_76_1) / var_76_2

				if arg_73_1.var_.actorSpriteComps10092_1 then
					for iter_76_0, iter_76_1 in pairs(arg_73_1.var_.actorSpriteComps10092_1:ToTable()) do
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

			if arg_73_1.time_ >= var_76_1 + var_76_2 and arg_73_1.time_ < var_76_1 + var_76_2 + arg_76_0 and not isNil(var_76_0) and arg_73_1.var_.actorSpriteComps10092_1 then
				for iter_76_2, iter_76_3 in pairs(arg_73_1.var_.actorSpriteComps10092_1:ToTable()) do
					if iter_76_3 then
						if arg_73_1.isInRecall_ then
							iter_76_3.color = arg_73_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_76_3.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_73_1.var_.actorSpriteComps10092_1 = nil
			end

			local var_76_8 = arg_73_1.actors_["10093"]
			local var_76_9 = 0

			if var_76_9 < arg_73_1.time_ and arg_73_1.time_ <= var_76_9 + arg_76_0 and not isNil(var_76_8) and arg_73_1.var_.actorSpriteComps10093 == nil then
				arg_73_1.var_.actorSpriteComps10093 = var_76_8:GetComponentsInChildren(typeof(Image), true)
			end

			local var_76_10 = 2

			if var_76_9 <= arg_73_1.time_ and arg_73_1.time_ < var_76_9 + var_76_10 and not isNil(var_76_8) then
				local var_76_11 = (arg_73_1.time_ - var_76_9) / var_76_10

				if arg_73_1.var_.actorSpriteComps10093 then
					for iter_76_4, iter_76_5 in pairs(arg_73_1.var_.actorSpriteComps10093:ToTable()) do
						if iter_76_5 then
							if arg_73_1.isInRecall_ then
								local var_76_12 = Mathf.Lerp(iter_76_5.color.r, arg_73_1.hightColor1.r, var_76_11)
								local var_76_13 = Mathf.Lerp(iter_76_5.color.g, arg_73_1.hightColor1.g, var_76_11)
								local var_76_14 = Mathf.Lerp(iter_76_5.color.b, arg_73_1.hightColor1.b, var_76_11)

								iter_76_5.color = Color.New(var_76_12, var_76_13, var_76_14)
							else
								local var_76_15 = Mathf.Lerp(iter_76_5.color.r, 1, var_76_11)

								iter_76_5.color = Color.New(var_76_15, var_76_15, var_76_15)
							end
						end
					end
				end
			end

			if arg_73_1.time_ >= var_76_9 + var_76_10 and arg_73_1.time_ < var_76_9 + var_76_10 + arg_76_0 and not isNil(var_76_8) and arg_73_1.var_.actorSpriteComps10093 then
				for iter_76_6, iter_76_7 in pairs(arg_73_1.var_.actorSpriteComps10093:ToTable()) do
					if iter_76_7 then
						if arg_73_1.isInRecall_ then
							iter_76_7.color = arg_73_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_76_7.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_73_1.var_.actorSpriteComps10093 = nil
			end

			local var_76_16 = arg_73_1.actors_["10093"].transform
			local var_76_17 = 0

			if var_76_17 < arg_73_1.time_ and arg_73_1.time_ <= var_76_17 + arg_76_0 then
				arg_73_1.var_.moveOldPos10093 = var_76_16.localPosition
				var_76_16.localScale = Vector3.New(1, 1, 1)

				arg_73_1:CheckSpriteTmpPos("10093", 4)

				local var_76_18 = var_76_16.childCount

				for iter_76_8 = 0, var_76_18 - 1 do
					local var_76_19 = var_76_16:GetChild(iter_76_8)

					if var_76_19.name == "split_5" or not string.find(var_76_19.name, "split") then
						var_76_19.gameObject:SetActive(true)
					else
						var_76_19.gameObject:SetActive(false)
					end
				end
			end

			local var_76_20 = 0.001

			if var_76_17 <= arg_73_1.time_ and arg_73_1.time_ < var_76_17 + var_76_20 then
				local var_76_21 = (arg_73_1.time_ - var_76_17) / var_76_20
				local var_76_22 = Vector3.New(390, -345, -245)

				var_76_16.localPosition = Vector3.Lerp(arg_73_1.var_.moveOldPos10093, var_76_22, var_76_21)
			end

			if arg_73_1.time_ >= var_76_17 + var_76_20 and arg_73_1.time_ < var_76_17 + var_76_20 + arg_76_0 then
				var_76_16.localPosition = Vector3.New(390, -345, -245)
			end

			local var_76_23 = 0
			local var_76_24 = 0.775

			if var_76_23 < arg_73_1.time_ and arg_73_1.time_ <= var_76_23 + arg_76_0 then
				arg_73_1.talkMaxDuration = 0
				arg_73_1.dialogCg_.alpha = 1

				arg_73_1.dialog_:SetActive(true)
				SetActive(arg_73_1.leftNameGo_, true)

				local var_76_25 = arg_73_1:FormatText(StoryNameCfg[28].name)

				arg_73_1.leftNameTxt_.text = var_76_25

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_73_1.leftNameTxt_.transform)

				arg_73_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_73_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_73_1:RecordName(arg_73_1.leftNameTxt_.text)
				SetActive(arg_73_1.iconTrs_.gameObject, false)
				arg_73_1.callingController_:SetSelectedState("normal")

				local var_76_26 = arg_73_1:GetWordFromCfg(413141018)
				local var_76_27 = arg_73_1:FormatText(var_76_26.content)

				arg_73_1.text_.text = var_76_27

				LuaForUtil.ClearLinePrefixSymbol(arg_73_1.text_)

				local var_76_28 = 31
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

				if manager.audio:GetVoiceLength("story_v_out_413141", "413141018", "story_v_out_413141.awb") ~= 0 then
					local var_76_31 = manager.audio:GetVoiceLength("story_v_out_413141", "413141018", "story_v_out_413141.awb") / 1000

					if var_76_31 + var_76_23 > arg_73_1.duration_ then
						arg_73_1.duration_ = var_76_31 + var_76_23
					end

					if var_76_26.prefab_name ~= "" and arg_73_1.actors_[var_76_26.prefab_name] ~= nil then
						local var_76_32 = LuaForUtil.PlayVoiceWithCriLipsync(arg_73_1.actors_[var_76_26.prefab_name].transform, "story_v_out_413141", "413141018", "story_v_out_413141.awb")

						arg_73_1:RecordAudio("413141018", var_76_32)
						arg_73_1:RecordAudio("413141018", var_76_32)
					else
						arg_73_1:AudioAction("play", "voice", "story_v_out_413141", "413141018", "story_v_out_413141.awb")
					end

					arg_73_1:RecordHistoryTalkVoice("story_v_out_413141", "413141018", "story_v_out_413141.awb")
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
				actorName = "10093",
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
	Play413141019 = function(arg_77_0, arg_77_1)
		arg_77_1.time_ = 0
		arg_77_1.frameCnt_ = 0
		arg_77_1.state_ = "playing"
		arg_77_1.curTalkId_ = 413141019
		arg_77_1.duration_ = 9.57

		local var_77_0 = {
			zh = 8.2,
			ja = 9.566
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
				arg_77_0:Play413141020(arg_77_1)
			end
		end

		function arg_77_1.onSingleLineUpdate_(arg_80_0)
			local var_80_0 = arg_77_1.actors_["10092_1"].transform
			local var_80_1 = 0

			if var_80_1 < arg_77_1.time_ and arg_77_1.time_ <= var_80_1 + arg_80_0 then
				arg_77_1.var_.moveOldPos10092_1 = var_80_0.localPosition
				var_80_0.localScale = Vector3.New(1, 1, 1)

				arg_77_1:CheckSpriteTmpPos("10092_1", 2)

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
				local var_80_6 = Vector3.New(-389.49, -300, -295)

				var_80_0.localPosition = Vector3.Lerp(arg_77_1.var_.moveOldPos10092_1, var_80_6, var_80_5)
			end

			if arg_77_1.time_ >= var_80_1 + var_80_4 and arg_77_1.time_ < var_80_1 + var_80_4 + arg_80_0 then
				var_80_0.localPosition = Vector3.New(-389.49, -300, -295)
			end

			local var_80_7 = arg_77_1.actors_["10092_1"]
			local var_80_8 = 0

			if var_80_8 < arg_77_1.time_ and arg_77_1.time_ <= var_80_8 + arg_80_0 and not isNil(var_80_7) and arg_77_1.var_.actorSpriteComps10092_1 == nil then
				arg_77_1.var_.actorSpriteComps10092_1 = var_80_7:GetComponentsInChildren(typeof(Image), true)
			end

			local var_80_9 = 2

			if var_80_8 <= arg_77_1.time_ and arg_77_1.time_ < var_80_8 + var_80_9 and not isNil(var_80_7) then
				local var_80_10 = (arg_77_1.time_ - var_80_8) / var_80_9

				if arg_77_1.var_.actorSpriteComps10092_1 then
					for iter_80_1, iter_80_2 in pairs(arg_77_1.var_.actorSpriteComps10092_1:ToTable()) do
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

			if arg_77_1.time_ >= var_80_8 + var_80_9 and arg_77_1.time_ < var_80_8 + var_80_9 + arg_80_0 and not isNil(var_80_7) and arg_77_1.var_.actorSpriteComps10092_1 then
				for iter_80_3, iter_80_4 in pairs(arg_77_1.var_.actorSpriteComps10092_1:ToTable()) do
					if iter_80_4 then
						if arg_77_1.isInRecall_ then
							iter_80_4.color = arg_77_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_80_4.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_77_1.var_.actorSpriteComps10092_1 = nil
			end

			local var_80_15 = arg_77_1.actors_["10093"]
			local var_80_16 = 0

			if var_80_16 < arg_77_1.time_ and arg_77_1.time_ <= var_80_16 + arg_80_0 and not isNil(var_80_15) and arg_77_1.var_.actorSpriteComps10093 == nil then
				arg_77_1.var_.actorSpriteComps10093 = var_80_15:GetComponentsInChildren(typeof(Image), true)
			end

			local var_80_17 = 2

			if var_80_16 <= arg_77_1.time_ and arg_77_1.time_ < var_80_16 + var_80_17 and not isNil(var_80_15) then
				local var_80_18 = (arg_77_1.time_ - var_80_16) / var_80_17

				if arg_77_1.var_.actorSpriteComps10093 then
					for iter_80_5, iter_80_6 in pairs(arg_77_1.var_.actorSpriteComps10093:ToTable()) do
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

			if arg_77_1.time_ >= var_80_16 + var_80_17 and arg_77_1.time_ < var_80_16 + var_80_17 + arg_80_0 and not isNil(var_80_15) and arg_77_1.var_.actorSpriteComps10093 then
				for iter_80_7, iter_80_8 in pairs(arg_77_1.var_.actorSpriteComps10093:ToTable()) do
					if iter_80_8 then
						if arg_77_1.isInRecall_ then
							iter_80_8.color = arg_77_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_80_8.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_77_1.var_.actorSpriteComps10093 = nil
			end

			local var_80_23 = 0
			local var_80_24 = 0.975

			if var_80_23 < arg_77_1.time_ and arg_77_1.time_ <= var_80_23 + arg_80_0 then
				arg_77_1.talkMaxDuration = 0
				arg_77_1.dialogCg_.alpha = 1

				arg_77_1.dialog_:SetActive(true)
				SetActive(arg_77_1.leftNameGo_, true)

				local var_80_25 = arg_77_1:FormatText(StoryNameCfg[996].name)

				arg_77_1.leftNameTxt_.text = var_80_25

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_77_1.leftNameTxt_.transform)

				arg_77_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_77_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_77_1:RecordName(arg_77_1.leftNameTxt_.text)
				SetActive(arg_77_1.iconTrs_.gameObject, false)
				arg_77_1.callingController_:SetSelectedState("normal")

				local var_80_26 = arg_77_1:GetWordFromCfg(413141019)
				local var_80_27 = arg_77_1:FormatText(var_80_26.content)

				arg_77_1.text_.text = var_80_27

				LuaForUtil.ClearLinePrefixSymbol(arg_77_1.text_)

				local var_80_28 = 39
				local var_80_29 = utf8.len(var_80_27)
				local var_80_30 = var_80_28 <= 0 and var_80_24 or var_80_24 * (var_80_29 / var_80_28)

				if var_80_30 > 0 and var_80_24 < var_80_30 then
					arg_77_1.talkMaxDuration = var_80_30

					if var_80_30 + var_80_23 > arg_77_1.duration_ then
						arg_77_1.duration_ = var_80_30 + var_80_23
					end
				end

				arg_77_1.text_.text = var_80_27
				arg_77_1.typewritter.percent = 0

				arg_77_1.typewritter:SetDirty()
				arg_77_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_413141", "413141019", "story_v_out_413141.awb") ~= 0 then
					local var_80_31 = manager.audio:GetVoiceLength("story_v_out_413141", "413141019", "story_v_out_413141.awb") / 1000

					if var_80_31 + var_80_23 > arg_77_1.duration_ then
						arg_77_1.duration_ = var_80_31 + var_80_23
					end

					if var_80_26.prefab_name ~= "" and arg_77_1.actors_[var_80_26.prefab_name] ~= nil then
						local var_80_32 = LuaForUtil.PlayVoiceWithCriLipsync(arg_77_1.actors_[var_80_26.prefab_name].transform, "story_v_out_413141", "413141019", "story_v_out_413141.awb")

						arg_77_1:RecordAudio("413141019", var_80_32)
						arg_77_1:RecordAudio("413141019", var_80_32)
					else
						arg_77_1:AudioAction("play", "voice", "story_v_out_413141", "413141019", "story_v_out_413141.awb")
					end

					arg_77_1:RecordHistoryTalkVoice("story_v_out_413141", "413141019", "story_v_out_413141.awb")
				end

				arg_77_1:RecordContent(arg_77_1.text_.text)
			end

			local var_80_33 = math.max(var_80_24, arg_77_1.talkMaxDuration)

			if var_80_23 <= arg_77_1.time_ and arg_77_1.time_ < var_80_23 + var_80_33 then
				arg_77_1.typewritter.percent = (arg_77_1.time_ - var_80_23) / var_80_33

				arg_77_1.typewritter:SetDirty()
			end

			if arg_77_1.time_ >= var_80_23 + var_80_33 and arg_77_1.time_ < var_80_23 + var_80_33 + arg_80_0 then
				arg_77_1.typewritter.percent = 1

				arg_77_1.typewritter:SetDirty()
				arg_77_1:ShowNextGo(true)
			end
		end

		arg_77_1.nodeConfigList_ = {
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

		arg_77_1:InitPlayNodeList()
	end,
	Play413141020 = function(arg_81_0, arg_81_1)
		arg_81_1.time_ = 0
		arg_81_1.frameCnt_ = 0
		arg_81_1.state_ = "playing"
		arg_81_1.curTalkId_ = 413141020
		arg_81_1.duration_ = 5

		SetActive(arg_81_1.tipsGo_, false)

		function arg_81_1.onSingleLineFinish_()
			arg_81_1.onSingleLineUpdate_ = nil
			arg_81_1.onSingleLineFinish_ = nil
			arg_81_1.state_ = "waiting"
		end

		function arg_81_1.playNext_(arg_83_0)
			if arg_83_0 == 1 then
				arg_81_0:Play413141021(arg_81_1)
			end
		end

		function arg_81_1.onSingleLineUpdate_(arg_84_0)
			local var_84_0 = arg_81_1.actors_["10092_1"]
			local var_84_1 = 0

			if var_84_1 < arg_81_1.time_ and arg_81_1.time_ <= var_84_1 + arg_84_0 and not isNil(var_84_0) and arg_81_1.var_.actorSpriteComps10092_1 == nil then
				arg_81_1.var_.actorSpriteComps10092_1 = var_84_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_84_2 = 2

			if var_84_1 <= arg_81_1.time_ and arg_81_1.time_ < var_84_1 + var_84_2 and not isNil(var_84_0) then
				local var_84_3 = (arg_81_1.time_ - var_84_1) / var_84_2

				if arg_81_1.var_.actorSpriteComps10092_1 then
					for iter_84_0, iter_84_1 in pairs(arg_81_1.var_.actorSpriteComps10092_1:ToTable()) do
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

			if arg_81_1.time_ >= var_84_1 + var_84_2 and arg_81_1.time_ < var_84_1 + var_84_2 + arg_84_0 and not isNil(var_84_0) and arg_81_1.var_.actorSpriteComps10092_1 then
				for iter_84_2, iter_84_3 in pairs(arg_81_1.var_.actorSpriteComps10092_1:ToTable()) do
					if iter_84_3 then
						if arg_81_1.isInRecall_ then
							iter_84_3.color = arg_81_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_84_3.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_81_1.var_.actorSpriteComps10092_1 = nil
			end

			local var_84_8 = arg_81_1.actors_["10092_1"].transform
			local var_84_9 = 0

			if var_84_9 < arg_81_1.time_ and arg_81_1.time_ <= var_84_9 + arg_84_0 then
				arg_81_1.var_.moveOldPos10092_1 = var_84_8.localPosition
				var_84_8.localScale = Vector3.New(1, 1, 1)

				arg_81_1:CheckSpriteTmpPos("10092_1", 7)

				local var_84_10 = var_84_8.childCount

				for iter_84_4 = 0, var_84_10 - 1 do
					local var_84_11 = var_84_8:GetChild(iter_84_4)

					if var_84_11.name == "" or not string.find(var_84_11.name, "split") then
						var_84_11.gameObject:SetActive(true)
					else
						var_84_11.gameObject:SetActive(false)
					end
				end
			end

			local var_84_12 = 0.001

			if var_84_9 <= arg_81_1.time_ and arg_81_1.time_ < var_84_9 + var_84_12 then
				local var_84_13 = (arg_81_1.time_ - var_84_9) / var_84_12
				local var_84_14 = Vector3.New(0, -2000, 0)

				var_84_8.localPosition = Vector3.Lerp(arg_81_1.var_.moveOldPos10092_1, var_84_14, var_84_13)
			end

			if arg_81_1.time_ >= var_84_9 + var_84_12 and arg_81_1.time_ < var_84_9 + var_84_12 + arg_84_0 then
				var_84_8.localPosition = Vector3.New(0, -2000, 0)
			end

			local var_84_15 = arg_81_1.actors_["10093"].transform
			local var_84_16 = 0

			if var_84_16 < arg_81_1.time_ and arg_81_1.time_ <= var_84_16 + arg_84_0 then
				arg_81_1.var_.moveOldPos10093 = var_84_15.localPosition
				var_84_15.localScale = Vector3.New(1, 1, 1)

				arg_81_1:CheckSpriteTmpPos("10093", 7)

				local var_84_17 = var_84_15.childCount

				for iter_84_5 = 0, var_84_17 - 1 do
					local var_84_18 = var_84_15:GetChild(iter_84_5)

					if var_84_18.name == "" or not string.find(var_84_18.name, "split") then
						var_84_18.gameObject:SetActive(true)
					else
						var_84_18.gameObject:SetActive(false)
					end
				end
			end

			local var_84_19 = 0.001

			if var_84_16 <= arg_81_1.time_ and arg_81_1.time_ < var_84_16 + var_84_19 then
				local var_84_20 = (arg_81_1.time_ - var_84_16) / var_84_19
				local var_84_21 = Vector3.New(0, -2000, 0)

				var_84_15.localPosition = Vector3.Lerp(arg_81_1.var_.moveOldPos10093, var_84_21, var_84_20)
			end

			if arg_81_1.time_ >= var_84_16 + var_84_19 and arg_81_1.time_ < var_84_16 + var_84_19 + arg_84_0 then
				var_84_15.localPosition = Vector3.New(0, -2000, 0)
			end

			local var_84_22 = 0
			local var_84_23 = 1.025

			if var_84_22 < arg_81_1.time_ and arg_81_1.time_ <= var_84_22 + arg_84_0 then
				arg_81_1.talkMaxDuration = 0
				arg_81_1.dialogCg_.alpha = 1

				arg_81_1.dialog_:SetActive(true)
				SetActive(arg_81_1.leftNameGo_, false)

				arg_81_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_81_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_81_1:RecordName(arg_81_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_81_1.iconTrs_.gameObject, false)
				arg_81_1.callingController_:SetSelectedState("normal")

				local var_84_24 = arg_81_1:GetWordFromCfg(413141020)
				local var_84_25 = arg_81_1:FormatText(var_84_24.content)

				arg_81_1.text_.text = var_84_25

				LuaForUtil.ClearLinePrefixSymbol(arg_81_1.text_)

				local var_84_26 = 41
				local var_84_27 = utf8.len(var_84_25)
				local var_84_28 = var_84_26 <= 0 and var_84_23 or var_84_23 * (var_84_27 / var_84_26)

				if var_84_28 > 0 and var_84_23 < var_84_28 then
					arg_81_1.talkMaxDuration = var_84_28

					if var_84_28 + var_84_22 > arg_81_1.duration_ then
						arg_81_1.duration_ = var_84_28 + var_84_22
					end
				end

				arg_81_1.text_.text = var_84_25
				arg_81_1.typewritter.percent = 0

				arg_81_1.typewritter:SetDirty()
				arg_81_1:ShowNextGo(false)
				arg_81_1:RecordContent(arg_81_1.text_.text)
			end

			local var_84_29 = math.max(var_84_23, arg_81_1.talkMaxDuration)

			if var_84_22 <= arg_81_1.time_ and arg_81_1.time_ < var_84_22 + var_84_29 then
				arg_81_1.typewritter.percent = (arg_81_1.time_ - var_84_22) / var_84_29

				arg_81_1.typewritter:SetDirty()
			end

			if arg_81_1.time_ >= var_84_22 + var_84_29 and arg_81_1.time_ < var_84_22 + var_84_29 + arg_84_0 then
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

		arg_81_1:InitPlayNodeList()
	end,
	Play413141021 = function(arg_85_0, arg_85_1)
		arg_85_1.time_ = 0
		arg_85_1.frameCnt_ = 0
		arg_85_1.state_ = "playing"
		arg_85_1.curTalkId_ = 413141021
		arg_85_1.duration_ = 7.17

		local var_85_0 = {
			zh = 3.833,
			ja = 7.166
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
				arg_85_0:Play413141022(arg_85_1)
			end
		end

		function arg_85_1.onSingleLineUpdate_(arg_88_0)
			local var_88_0 = arg_85_1.actors_["10092_1"].transform
			local var_88_1 = 0

			if var_88_1 < arg_85_1.time_ and arg_85_1.time_ <= var_88_1 + arg_88_0 then
				arg_85_1.var_.moveOldPos10092_1 = var_88_0.localPosition
				var_88_0.localScale = Vector3.New(1, 1, 1)

				arg_85_1:CheckSpriteTmpPos("10092_1", 3)

				local var_88_2 = var_88_0.childCount

				for iter_88_0 = 0, var_88_2 - 1 do
					local var_88_3 = var_88_0:GetChild(iter_88_0)

					if var_88_3.name == "" or not string.find(var_88_3.name, "split") then
						var_88_3.gameObject:SetActive(true)
					else
						var_88_3.gameObject:SetActive(false)
					end
				end
			end

			local var_88_4 = 0.001

			if var_88_1 <= arg_85_1.time_ and arg_85_1.time_ < var_88_1 + var_88_4 then
				local var_88_5 = (arg_85_1.time_ - var_88_1) / var_88_4
				local var_88_6 = Vector3.New(0, -300, -295)

				var_88_0.localPosition = Vector3.Lerp(arg_85_1.var_.moveOldPos10092_1, var_88_6, var_88_5)
			end

			if arg_85_1.time_ >= var_88_1 + var_88_4 and arg_85_1.time_ < var_88_1 + var_88_4 + arg_88_0 then
				var_88_0.localPosition = Vector3.New(0, -300, -295)
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

			local var_88_15 = 0
			local var_88_16 = 0.55

			if var_88_15 < arg_85_1.time_ and arg_85_1.time_ <= var_88_15 + arg_88_0 then
				arg_85_1.talkMaxDuration = 0
				arg_85_1.dialogCg_.alpha = 1

				arg_85_1.dialog_:SetActive(true)
				SetActive(arg_85_1.leftNameGo_, true)

				local var_88_17 = arg_85_1:FormatText(StoryNameCfg[996].name)

				arg_85_1.leftNameTxt_.text = var_88_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_85_1.leftNameTxt_.transform)

				arg_85_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_85_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_85_1:RecordName(arg_85_1.leftNameTxt_.text)
				SetActive(arg_85_1.iconTrs_.gameObject, false)
				arg_85_1.callingController_:SetSelectedState("normal")

				local var_88_18 = arg_85_1:GetWordFromCfg(413141021)
				local var_88_19 = arg_85_1:FormatText(var_88_18.content)

				arg_85_1.text_.text = var_88_19

				LuaForUtil.ClearLinePrefixSymbol(arg_85_1.text_)

				local var_88_20 = 22
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

				if manager.audio:GetVoiceLength("story_v_out_413141", "413141021", "story_v_out_413141.awb") ~= 0 then
					local var_88_23 = manager.audio:GetVoiceLength("story_v_out_413141", "413141021", "story_v_out_413141.awb") / 1000

					if var_88_23 + var_88_15 > arg_85_1.duration_ then
						arg_85_1.duration_ = var_88_23 + var_88_15
					end

					if var_88_18.prefab_name ~= "" and arg_85_1.actors_[var_88_18.prefab_name] ~= nil then
						local var_88_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_85_1.actors_[var_88_18.prefab_name].transform, "story_v_out_413141", "413141021", "story_v_out_413141.awb")

						arg_85_1:RecordAudio("413141021", var_88_24)
						arg_85_1:RecordAudio("413141021", var_88_24)
					else
						arg_85_1:AudioAction("play", "voice", "story_v_out_413141", "413141021", "story_v_out_413141.awb")
					end

					arg_85_1:RecordHistoryTalkVoice("story_v_out_413141", "413141021", "story_v_out_413141.awb")
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
	Play413141022 = function(arg_89_0, arg_89_1)
		arg_89_1.time_ = 0
		arg_89_1.frameCnt_ = 0
		arg_89_1.state_ = "playing"
		arg_89_1.curTalkId_ = 413141022
		arg_89_1.duration_ = 13.03

		local var_89_0 = {
			zh = 7.033,
			ja = 13.033
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
				arg_89_0:Play413141023(arg_89_1)
			end
		end

		function arg_89_1.onSingleLineUpdate_(arg_92_0)
			local var_92_0 = 0
			local var_92_1 = 1.075

			if var_92_0 < arg_89_1.time_ and arg_89_1.time_ <= var_92_0 + arg_92_0 then
				arg_89_1.talkMaxDuration = 0
				arg_89_1.dialogCg_.alpha = 1

				arg_89_1.dialog_:SetActive(true)
				SetActive(arg_89_1.leftNameGo_, true)

				local var_92_2 = arg_89_1:FormatText(StoryNameCfg[996].name)

				arg_89_1.leftNameTxt_.text = var_92_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_89_1.leftNameTxt_.transform)

				arg_89_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_89_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_89_1:RecordName(arg_89_1.leftNameTxt_.text)
				SetActive(arg_89_1.iconTrs_.gameObject, false)
				arg_89_1.callingController_:SetSelectedState("normal")

				local var_92_3 = arg_89_1:GetWordFromCfg(413141022)
				local var_92_4 = arg_89_1:FormatText(var_92_3.content)

				arg_89_1.text_.text = var_92_4

				LuaForUtil.ClearLinePrefixSymbol(arg_89_1.text_)

				local var_92_5 = 43
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

				if manager.audio:GetVoiceLength("story_v_out_413141", "413141022", "story_v_out_413141.awb") ~= 0 then
					local var_92_8 = manager.audio:GetVoiceLength("story_v_out_413141", "413141022", "story_v_out_413141.awb") / 1000

					if var_92_8 + var_92_0 > arg_89_1.duration_ then
						arg_89_1.duration_ = var_92_8 + var_92_0
					end

					if var_92_3.prefab_name ~= "" and arg_89_1.actors_[var_92_3.prefab_name] ~= nil then
						local var_92_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_89_1.actors_[var_92_3.prefab_name].transform, "story_v_out_413141", "413141022", "story_v_out_413141.awb")

						arg_89_1:RecordAudio("413141022", var_92_9)
						arg_89_1:RecordAudio("413141022", var_92_9)
					else
						arg_89_1:AudioAction("play", "voice", "story_v_out_413141", "413141022", "story_v_out_413141.awb")
					end

					arg_89_1:RecordHistoryTalkVoice("story_v_out_413141", "413141022", "story_v_out_413141.awb")
				end

				arg_89_1:RecordContent(arg_89_1.text_.text)
			end

			local var_92_10 = math.max(var_92_1, arg_89_1.talkMaxDuration)

			if var_92_0 <= arg_89_1.time_ and arg_89_1.time_ < var_92_0 + var_92_10 then
				arg_89_1.typewritter.percent = (arg_89_1.time_ - var_92_0) / var_92_10

				arg_89_1.typewritter:SetDirty()
			end

			if arg_89_1.time_ >= var_92_0 + var_92_10 and arg_89_1.time_ < var_92_0 + var_92_10 + arg_92_0 then
				arg_89_1.typewritter.percent = 1

				arg_89_1.typewritter:SetDirty()
				arg_89_1:ShowNextGo(true)
			end
		end

		arg_89_1.nodeConfigList_ = {}

		arg_89_1:InitPlayNodeList()
	end,
	Play413141023 = function(arg_93_0, arg_93_1)
		arg_93_1.time_ = 0
		arg_93_1.frameCnt_ = 0
		arg_93_1.state_ = "playing"
		arg_93_1.curTalkId_ = 413141023
		arg_93_1.duration_ = 10.37

		local var_93_0 = {
			zh = 7.133,
			ja = 10.366
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
				arg_93_0:Play413141024(arg_93_1)
			end
		end

		function arg_93_1.onSingleLineUpdate_(arg_96_0)
			local var_96_0 = arg_93_1.actors_["10092_1"].transform
			local var_96_1 = 0

			if var_96_1 < arg_93_1.time_ and arg_93_1.time_ <= var_96_1 + arg_96_0 then
				arg_93_1.var_.moveOldPos10092_1 = var_96_0.localPosition
				var_96_0.localScale = Vector3.New(1, 1, 1)

				arg_93_1:CheckSpriteTmpPos("10092_1", 3)

				local var_96_2 = var_96_0.childCount

				for iter_96_0 = 0, var_96_2 - 1 do
					local var_96_3 = var_96_0:GetChild(iter_96_0)

					if var_96_3.name == "split_2" or not string.find(var_96_3.name, "split") then
						var_96_3.gameObject:SetActive(true)
					else
						var_96_3.gameObject:SetActive(false)
					end
				end
			end

			local var_96_4 = 0.001

			if var_96_1 <= arg_93_1.time_ and arg_93_1.time_ < var_96_1 + var_96_4 then
				local var_96_5 = (arg_93_1.time_ - var_96_1) / var_96_4
				local var_96_6 = Vector3.New(0, -300, -295)

				var_96_0.localPosition = Vector3.Lerp(arg_93_1.var_.moveOldPos10092_1, var_96_6, var_96_5)
			end

			if arg_93_1.time_ >= var_96_1 + var_96_4 and arg_93_1.time_ < var_96_1 + var_96_4 + arg_96_0 then
				var_96_0.localPosition = Vector3.New(0, -300, -295)
			end

			local var_96_7 = arg_93_1.actors_["10092_1"]
			local var_96_8 = 0

			if var_96_8 < arg_93_1.time_ and arg_93_1.time_ <= var_96_8 + arg_96_0 and not isNil(var_96_7) and arg_93_1.var_.actorSpriteComps10092_1 == nil then
				arg_93_1.var_.actorSpriteComps10092_1 = var_96_7:GetComponentsInChildren(typeof(Image), true)
			end

			local var_96_9 = 2

			if var_96_8 <= arg_93_1.time_ and arg_93_1.time_ < var_96_8 + var_96_9 and not isNil(var_96_7) then
				local var_96_10 = (arg_93_1.time_ - var_96_8) / var_96_9

				if arg_93_1.var_.actorSpriteComps10092_1 then
					for iter_96_1, iter_96_2 in pairs(arg_93_1.var_.actorSpriteComps10092_1:ToTable()) do
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

			if arg_93_1.time_ >= var_96_8 + var_96_9 and arg_93_1.time_ < var_96_8 + var_96_9 + arg_96_0 and not isNil(var_96_7) and arg_93_1.var_.actorSpriteComps10092_1 then
				for iter_96_3, iter_96_4 in pairs(arg_93_1.var_.actorSpriteComps10092_1:ToTable()) do
					if iter_96_4 then
						if arg_93_1.isInRecall_ then
							iter_96_4.color = arg_93_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_96_4.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_93_1.var_.actorSpriteComps10092_1 = nil
			end

			local var_96_15 = 0
			local var_96_16 = 0.775

			if var_96_15 < arg_93_1.time_ and arg_93_1.time_ <= var_96_15 + arg_96_0 then
				arg_93_1.talkMaxDuration = 0
				arg_93_1.dialogCg_.alpha = 1

				arg_93_1.dialog_:SetActive(true)
				SetActive(arg_93_1.leftNameGo_, true)

				local var_96_17 = arg_93_1:FormatText(StoryNameCfg[996].name)

				arg_93_1.leftNameTxt_.text = var_96_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_93_1.leftNameTxt_.transform)

				arg_93_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_93_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_93_1:RecordName(arg_93_1.leftNameTxt_.text)
				SetActive(arg_93_1.iconTrs_.gameObject, false)
				arg_93_1.callingController_:SetSelectedState("normal")

				local var_96_18 = arg_93_1:GetWordFromCfg(413141023)
				local var_96_19 = arg_93_1:FormatText(var_96_18.content)

				arg_93_1.text_.text = var_96_19

				LuaForUtil.ClearLinePrefixSymbol(arg_93_1.text_)

				local var_96_20 = 31
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

				if manager.audio:GetVoiceLength("story_v_out_413141", "413141023", "story_v_out_413141.awb") ~= 0 then
					local var_96_23 = manager.audio:GetVoiceLength("story_v_out_413141", "413141023", "story_v_out_413141.awb") / 1000

					if var_96_23 + var_96_15 > arg_93_1.duration_ then
						arg_93_1.duration_ = var_96_23 + var_96_15
					end

					if var_96_18.prefab_name ~= "" and arg_93_1.actors_[var_96_18.prefab_name] ~= nil then
						local var_96_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_93_1.actors_[var_96_18.prefab_name].transform, "story_v_out_413141", "413141023", "story_v_out_413141.awb")

						arg_93_1:RecordAudio("413141023", var_96_24)
						arg_93_1:RecordAudio("413141023", var_96_24)
					else
						arg_93_1:AudioAction("play", "voice", "story_v_out_413141", "413141023", "story_v_out_413141.awb")
					end

					arg_93_1:RecordHistoryTalkVoice("story_v_out_413141", "413141023", "story_v_out_413141.awb")
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
				actorName = "10092_1",
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
	Play413141024 = function(arg_97_0, arg_97_1)
		arg_97_1.time_ = 0
		arg_97_1.frameCnt_ = 0
		arg_97_1.state_ = "playing"
		arg_97_1.curTalkId_ = 413141024
		arg_97_1.duration_ = 7.13

		local var_97_0 = {
			zh = 3.9,
			ja = 7.133
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
				arg_97_0:Play413141025(arg_97_1)
			end
		end

		function arg_97_1.onSingleLineUpdate_(arg_100_0)
			local var_100_0 = arg_97_1.actors_["10092_1"]
			local var_100_1 = 0

			if var_100_1 < arg_97_1.time_ and arg_97_1.time_ <= var_100_1 + arg_100_0 and not isNil(var_100_0) and arg_97_1.var_.actorSpriteComps10092_1 == nil then
				arg_97_1.var_.actorSpriteComps10092_1 = var_100_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_100_2 = 2

			if var_100_1 <= arg_97_1.time_ and arg_97_1.time_ < var_100_1 + var_100_2 and not isNil(var_100_0) then
				local var_100_3 = (arg_97_1.time_ - var_100_1) / var_100_2

				if arg_97_1.var_.actorSpriteComps10092_1 then
					for iter_100_0, iter_100_1 in pairs(arg_97_1.var_.actorSpriteComps10092_1:ToTable()) do
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

			if arg_97_1.time_ >= var_100_1 + var_100_2 and arg_97_1.time_ < var_100_1 + var_100_2 + arg_100_0 and not isNil(var_100_0) and arg_97_1.var_.actorSpriteComps10092_1 then
				for iter_100_2, iter_100_3 in pairs(arg_97_1.var_.actorSpriteComps10092_1:ToTable()) do
					if iter_100_3 then
						if arg_97_1.isInRecall_ then
							iter_100_3.color = arg_97_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_100_3.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_97_1.var_.actorSpriteComps10092_1 = nil
			end

			local var_100_8 = arg_97_1.actors_["10093"]
			local var_100_9 = 0

			if var_100_9 < arg_97_1.time_ and arg_97_1.time_ <= var_100_9 + arg_100_0 and not isNil(var_100_8) and arg_97_1.var_.actorSpriteComps10093 == nil then
				arg_97_1.var_.actorSpriteComps10093 = var_100_8:GetComponentsInChildren(typeof(Image), true)
			end

			local var_100_10 = 2

			if var_100_9 <= arg_97_1.time_ and arg_97_1.time_ < var_100_9 + var_100_10 and not isNil(var_100_8) then
				local var_100_11 = (arg_97_1.time_ - var_100_9) / var_100_10

				if arg_97_1.var_.actorSpriteComps10093 then
					for iter_100_4, iter_100_5 in pairs(arg_97_1.var_.actorSpriteComps10093:ToTable()) do
						if iter_100_5 then
							if arg_97_1.isInRecall_ then
								local var_100_12 = Mathf.Lerp(iter_100_5.color.r, arg_97_1.hightColor1.r, var_100_11)
								local var_100_13 = Mathf.Lerp(iter_100_5.color.g, arg_97_1.hightColor1.g, var_100_11)
								local var_100_14 = Mathf.Lerp(iter_100_5.color.b, arg_97_1.hightColor1.b, var_100_11)

								iter_100_5.color = Color.New(var_100_12, var_100_13, var_100_14)
							else
								local var_100_15 = Mathf.Lerp(iter_100_5.color.r, 1, var_100_11)

								iter_100_5.color = Color.New(var_100_15, var_100_15, var_100_15)
							end
						end
					end
				end
			end

			if arg_97_1.time_ >= var_100_9 + var_100_10 and arg_97_1.time_ < var_100_9 + var_100_10 + arg_100_0 and not isNil(var_100_8) and arg_97_1.var_.actorSpriteComps10093 then
				for iter_100_6, iter_100_7 in pairs(arg_97_1.var_.actorSpriteComps10093:ToTable()) do
					if iter_100_7 then
						if arg_97_1.isInRecall_ then
							iter_100_7.color = arg_97_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_100_7.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_97_1.var_.actorSpriteComps10093 = nil
			end

			local var_100_16 = arg_97_1.actors_["10093"].transform
			local var_100_17 = 0

			if var_100_17 < arg_97_1.time_ and arg_97_1.time_ <= var_100_17 + arg_100_0 then
				arg_97_1.var_.moveOldPos10093 = var_100_16.localPosition
				var_100_16.localScale = Vector3.New(1, 1, 1)

				arg_97_1:CheckSpriteTmpPos("10093", 4)

				local var_100_18 = var_100_16.childCount

				for iter_100_8 = 0, var_100_18 - 1 do
					local var_100_19 = var_100_16:GetChild(iter_100_8)

					if var_100_19.name == "split_5" or not string.find(var_100_19.name, "split") then
						var_100_19.gameObject:SetActive(true)
					else
						var_100_19.gameObject:SetActive(false)
					end
				end
			end

			local var_100_20 = 0.001

			if var_100_17 <= arg_97_1.time_ and arg_97_1.time_ < var_100_17 + var_100_20 then
				local var_100_21 = (arg_97_1.time_ - var_100_17) / var_100_20
				local var_100_22 = Vector3.New(390, -345, -245)

				var_100_16.localPosition = Vector3.Lerp(arg_97_1.var_.moveOldPos10093, var_100_22, var_100_21)
			end

			if arg_97_1.time_ >= var_100_17 + var_100_20 and arg_97_1.time_ < var_100_17 + var_100_20 + arg_100_0 then
				var_100_16.localPosition = Vector3.New(390, -345, -245)
			end

			local var_100_23 = arg_97_1.actors_["10092_1"].transform
			local var_100_24 = 0

			if var_100_24 < arg_97_1.time_ and arg_97_1.time_ <= var_100_24 + arg_100_0 then
				arg_97_1.var_.moveOldPos10092_1 = var_100_23.localPosition
				var_100_23.localScale = Vector3.New(1, 1, 1)

				arg_97_1:CheckSpriteTmpPos("10092_1", 2)

				local var_100_25 = var_100_23.childCount

				for iter_100_9 = 0, var_100_25 - 1 do
					local var_100_26 = var_100_23:GetChild(iter_100_9)

					if var_100_26.name == "split_2" or not string.find(var_100_26.name, "split") then
						var_100_26.gameObject:SetActive(true)
					else
						var_100_26.gameObject:SetActive(false)
					end
				end
			end

			local var_100_27 = 0.001

			if var_100_24 <= arg_97_1.time_ and arg_97_1.time_ < var_100_24 + var_100_27 then
				local var_100_28 = (arg_97_1.time_ - var_100_24) / var_100_27
				local var_100_29 = Vector3.New(-389.49, -300, -295)

				var_100_23.localPosition = Vector3.Lerp(arg_97_1.var_.moveOldPos10092_1, var_100_29, var_100_28)
			end

			if arg_97_1.time_ >= var_100_24 + var_100_27 and arg_97_1.time_ < var_100_24 + var_100_27 + arg_100_0 then
				var_100_23.localPosition = Vector3.New(-389.49, -300, -295)
			end

			local var_100_30 = 0
			local var_100_31 = 0.6

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

				local var_100_33 = arg_97_1:GetWordFromCfg(413141024)
				local var_100_34 = arg_97_1:FormatText(var_100_33.content)

				arg_97_1.text_.text = var_100_34

				LuaForUtil.ClearLinePrefixSymbol(arg_97_1.text_)

				local var_100_35 = 24
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

				if manager.audio:GetVoiceLength("story_v_out_413141", "413141024", "story_v_out_413141.awb") ~= 0 then
					local var_100_38 = manager.audio:GetVoiceLength("story_v_out_413141", "413141024", "story_v_out_413141.awb") / 1000

					if var_100_38 + var_100_30 > arg_97_1.duration_ then
						arg_97_1.duration_ = var_100_38 + var_100_30
					end

					if var_100_33.prefab_name ~= "" and arg_97_1.actors_[var_100_33.prefab_name] ~= nil then
						local var_100_39 = LuaForUtil.PlayVoiceWithCriLipsync(arg_97_1.actors_[var_100_33.prefab_name].transform, "story_v_out_413141", "413141024", "story_v_out_413141.awb")

						arg_97_1:RecordAudio("413141024", var_100_39)
						arg_97_1:RecordAudio("413141024", var_100_39)
					else
						arg_97_1:AudioAction("play", "voice", "story_v_out_413141", "413141024", "story_v_out_413141.awb")
					end

					arg_97_1:RecordHistoryTalkVoice("story_v_out_413141", "413141024", "story_v_out_413141.awb")
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

		arg_97_1:InitPlayNodeList()
	end,
	Play413141025 = function(arg_101_0, arg_101_1)
		arg_101_1.time_ = 0
		arg_101_1.frameCnt_ = 0
		arg_101_1.state_ = "playing"
		arg_101_1.curTalkId_ = 413141025
		arg_101_1.duration_ = 5

		SetActive(arg_101_1.tipsGo_, false)

		function arg_101_1.onSingleLineFinish_()
			arg_101_1.onSingleLineUpdate_ = nil
			arg_101_1.onSingleLineFinish_ = nil
			arg_101_1.state_ = "waiting"
		end

		function arg_101_1.playNext_(arg_103_0)
			if arg_103_0 == 1 then
				arg_101_0:Play413141026(arg_101_1)
			end
		end

		function arg_101_1.onSingleLineUpdate_(arg_104_0)
			local var_104_0 = arg_101_1.actors_["10093"].transform
			local var_104_1 = 0

			if var_104_1 < arg_101_1.time_ and arg_101_1.time_ <= var_104_1 + arg_104_0 then
				arg_101_1.var_.moveOldPos10093 = var_104_0.localPosition
				var_104_0.localScale = Vector3.New(1, 1, 1)

				arg_101_1:CheckSpriteTmpPos("10093", 7)

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
				local var_104_6 = Vector3.New(0, -2000, 0)

				var_104_0.localPosition = Vector3.Lerp(arg_101_1.var_.moveOldPos10093, var_104_6, var_104_5)
			end

			if arg_101_1.time_ >= var_104_1 + var_104_4 and arg_101_1.time_ < var_104_1 + var_104_4 + arg_104_0 then
				var_104_0.localPosition = Vector3.New(0, -2000, 0)
			end

			local var_104_7 = arg_101_1.actors_["10093"]
			local var_104_8 = 0

			if var_104_8 < arg_101_1.time_ and arg_101_1.time_ <= var_104_8 + arg_104_0 and not isNil(var_104_7) and arg_101_1.var_.actorSpriteComps10093 == nil then
				arg_101_1.var_.actorSpriteComps10093 = var_104_7:GetComponentsInChildren(typeof(Image), true)
			end

			local var_104_9 = 2

			if var_104_8 <= arg_101_1.time_ and arg_101_1.time_ < var_104_8 + var_104_9 and not isNil(var_104_7) then
				local var_104_10 = (arg_101_1.time_ - var_104_8) / var_104_9

				if arg_101_1.var_.actorSpriteComps10093 then
					for iter_104_1, iter_104_2 in pairs(arg_101_1.var_.actorSpriteComps10093:ToTable()) do
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

			if arg_101_1.time_ >= var_104_8 + var_104_9 and arg_101_1.time_ < var_104_8 + var_104_9 + arg_104_0 and not isNil(var_104_7) and arg_101_1.var_.actorSpriteComps10093 then
				for iter_104_3, iter_104_4 in pairs(arg_101_1.var_.actorSpriteComps10093:ToTable()) do
					if iter_104_4 then
						if arg_101_1.isInRecall_ then
							iter_104_4.color = arg_101_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_104_4.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_101_1.var_.actorSpriteComps10093 = nil
			end

			local var_104_15 = arg_101_1.actors_["10092_1"].transform
			local var_104_16 = 0

			if var_104_16 < arg_101_1.time_ and arg_101_1.time_ <= var_104_16 + arg_104_0 then
				arg_101_1.var_.moveOldPos10092_1 = var_104_15.localPosition
				var_104_15.localScale = Vector3.New(1, 1, 1)

				arg_101_1:CheckSpriteTmpPos("10092_1", 7)

				local var_104_17 = var_104_15.childCount

				for iter_104_5 = 0, var_104_17 - 1 do
					local var_104_18 = var_104_15:GetChild(iter_104_5)

					if var_104_18.name == "" or not string.find(var_104_18.name, "split") then
						var_104_18.gameObject:SetActive(true)
					else
						var_104_18.gameObject:SetActive(false)
					end
				end
			end

			local var_104_19 = 0.001

			if var_104_16 <= arg_101_1.time_ and arg_101_1.time_ < var_104_16 + var_104_19 then
				local var_104_20 = (arg_101_1.time_ - var_104_16) / var_104_19
				local var_104_21 = Vector3.New(0, -2000, 0)

				var_104_15.localPosition = Vector3.Lerp(arg_101_1.var_.moveOldPos10092_1, var_104_21, var_104_20)
			end

			if arg_101_1.time_ >= var_104_16 + var_104_19 and arg_101_1.time_ < var_104_16 + var_104_19 + arg_104_0 then
				var_104_15.localPosition = Vector3.New(0, -2000, 0)
			end

			local var_104_22 = 0
			local var_104_23 = 0.675

			if var_104_22 < arg_101_1.time_ and arg_101_1.time_ <= var_104_22 + arg_104_0 then
				arg_101_1.talkMaxDuration = 0
				arg_101_1.dialogCg_.alpha = 1

				arg_101_1.dialog_:SetActive(true)
				SetActive(arg_101_1.leftNameGo_, false)

				arg_101_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_101_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_101_1:RecordName(arg_101_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_101_1.iconTrs_.gameObject, false)
				arg_101_1.callingController_:SetSelectedState("normal")

				local var_104_24 = arg_101_1:GetWordFromCfg(413141025)
				local var_104_25 = arg_101_1:FormatText(var_104_24.content)

				arg_101_1.text_.text = var_104_25

				LuaForUtil.ClearLinePrefixSymbol(arg_101_1.text_)

				local var_104_26 = 27
				local var_104_27 = utf8.len(var_104_25)
				local var_104_28 = var_104_26 <= 0 and var_104_23 or var_104_23 * (var_104_27 / var_104_26)

				if var_104_28 > 0 and var_104_23 < var_104_28 then
					arg_101_1.talkMaxDuration = var_104_28

					if var_104_28 + var_104_22 > arg_101_1.duration_ then
						arg_101_1.duration_ = var_104_28 + var_104_22
					end
				end

				arg_101_1.text_.text = var_104_25
				arg_101_1.typewritter.percent = 0

				arg_101_1.typewritter:SetDirty()
				arg_101_1:ShowNextGo(false)
				arg_101_1:RecordContent(arg_101_1.text_.text)
			end

			local var_104_29 = math.max(var_104_23, arg_101_1.talkMaxDuration)

			if var_104_22 <= arg_101_1.time_ and arg_101_1.time_ < var_104_22 + var_104_29 then
				arg_101_1.typewritter.percent = (arg_101_1.time_ - var_104_22) / var_104_29

				arg_101_1.typewritter:SetDirty()
			end

			if arg_101_1.time_ >= var_104_22 + var_104_29 and arg_101_1.time_ < var_104_22 + var_104_29 + arg_104_0 then
				arg_101_1.typewritter.percent = 1

				arg_101_1.typewritter:SetDirty()
				arg_101_1:ShowNextGo(true)
			end
		end

		arg_101_1.nodeConfigList_ = {
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

		arg_101_1:InitPlayNodeList()
	end,
	Play413141026 = function(arg_105_0, arg_105_1)
		arg_105_1.time_ = 0
		arg_105_1.frameCnt_ = 0
		arg_105_1.state_ = "playing"
		arg_105_1.curTalkId_ = 413141026
		arg_105_1.duration_ = 6.57

		local var_105_0 = {
			zh = 5.466,
			ja = 6.566
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
				arg_105_0:Play413141027(arg_105_1)
			end
		end

		function arg_105_1.onSingleLineUpdate_(arg_108_0)
			local var_108_0 = arg_105_1.actors_["10092_1"].transform
			local var_108_1 = 0

			if var_108_1 < arg_105_1.time_ and arg_105_1.time_ <= var_108_1 + arg_108_0 then
				arg_105_1.var_.moveOldPos10092_1 = var_108_0.localPosition
				var_108_0.localScale = Vector3.New(1, 1, 1)

				arg_105_1:CheckSpriteTmpPos("10092_1", 3)

				local var_108_2 = var_108_0.childCount

				for iter_108_0 = 0, var_108_2 - 1 do
					local var_108_3 = var_108_0:GetChild(iter_108_0)

					if var_108_3.name == "split_1_1" or not string.find(var_108_3.name, "split") then
						var_108_3.gameObject:SetActive(true)
					else
						var_108_3.gameObject:SetActive(false)
					end
				end
			end

			local var_108_4 = 0.001

			if var_108_1 <= arg_105_1.time_ and arg_105_1.time_ < var_108_1 + var_108_4 then
				local var_108_5 = (arg_105_1.time_ - var_108_1) / var_108_4
				local var_108_6 = Vector3.New(0, -300, -295)

				var_108_0.localPosition = Vector3.Lerp(arg_105_1.var_.moveOldPos10092_1, var_108_6, var_108_5)
			end

			if arg_105_1.time_ >= var_108_1 + var_108_4 and arg_105_1.time_ < var_108_1 + var_108_4 + arg_108_0 then
				var_108_0.localPosition = Vector3.New(0, -300, -295)
			end

			local var_108_7 = arg_105_1.actors_["10092_1"]
			local var_108_8 = 0

			if var_108_8 < arg_105_1.time_ and arg_105_1.time_ <= var_108_8 + arg_108_0 and not isNil(var_108_7) and arg_105_1.var_.actorSpriteComps10092_1 == nil then
				arg_105_1.var_.actorSpriteComps10092_1 = var_108_7:GetComponentsInChildren(typeof(Image), true)
			end

			local var_108_9 = 2

			if var_108_8 <= arg_105_1.time_ and arg_105_1.time_ < var_108_8 + var_108_9 and not isNil(var_108_7) then
				local var_108_10 = (arg_105_1.time_ - var_108_8) / var_108_9

				if arg_105_1.var_.actorSpriteComps10092_1 then
					for iter_108_1, iter_108_2 in pairs(arg_105_1.var_.actorSpriteComps10092_1:ToTable()) do
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

			if arg_105_1.time_ >= var_108_8 + var_108_9 and arg_105_1.time_ < var_108_8 + var_108_9 + arg_108_0 and not isNil(var_108_7) and arg_105_1.var_.actorSpriteComps10092_1 then
				for iter_108_3, iter_108_4 in pairs(arg_105_1.var_.actorSpriteComps10092_1:ToTable()) do
					if iter_108_4 then
						if arg_105_1.isInRecall_ then
							iter_108_4.color = arg_105_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_108_4.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_105_1.var_.actorSpriteComps10092_1 = nil
			end

			local var_108_15 = 0
			local var_108_16 = 0.875

			if var_108_15 < arg_105_1.time_ and arg_105_1.time_ <= var_108_15 + arg_108_0 then
				arg_105_1.talkMaxDuration = 0
				arg_105_1.dialogCg_.alpha = 1

				arg_105_1.dialog_:SetActive(true)
				SetActive(arg_105_1.leftNameGo_, true)

				local var_108_17 = arg_105_1:FormatText(StoryNameCfg[996].name)

				arg_105_1.leftNameTxt_.text = var_108_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_105_1.leftNameTxt_.transform)

				arg_105_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_105_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_105_1:RecordName(arg_105_1.leftNameTxt_.text)
				SetActive(arg_105_1.iconTrs_.gameObject, false)
				arg_105_1.callingController_:SetSelectedState("normal")

				local var_108_18 = arg_105_1:GetWordFromCfg(413141026)
				local var_108_19 = arg_105_1:FormatText(var_108_18.content)

				arg_105_1.text_.text = var_108_19

				LuaForUtil.ClearLinePrefixSymbol(arg_105_1.text_)

				local var_108_20 = 35
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

				if manager.audio:GetVoiceLength("story_v_out_413141", "413141026", "story_v_out_413141.awb") ~= 0 then
					local var_108_23 = manager.audio:GetVoiceLength("story_v_out_413141", "413141026", "story_v_out_413141.awb") / 1000

					if var_108_23 + var_108_15 > arg_105_1.duration_ then
						arg_105_1.duration_ = var_108_23 + var_108_15
					end

					if var_108_18.prefab_name ~= "" and arg_105_1.actors_[var_108_18.prefab_name] ~= nil then
						local var_108_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_105_1.actors_[var_108_18.prefab_name].transform, "story_v_out_413141", "413141026", "story_v_out_413141.awb")

						arg_105_1:RecordAudio("413141026", var_108_24)
						arg_105_1:RecordAudio("413141026", var_108_24)
					else
						arg_105_1:AudioAction("play", "voice", "story_v_out_413141", "413141026", "story_v_out_413141.awb")
					end

					arg_105_1:RecordHistoryTalkVoice("story_v_out_413141", "413141026", "story_v_out_413141.awb")
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
				actorName = "10092_1",
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
	Play413141027 = function(arg_109_0, arg_109_1)
		arg_109_1.time_ = 0
		arg_109_1.frameCnt_ = 0
		arg_109_1.state_ = "playing"
		arg_109_1.curTalkId_ = 413141027
		arg_109_1.duration_ = 14.97

		local var_109_0 = {
			zh = 6.5,
			ja = 14.966
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
				arg_109_0:Play413141028(arg_109_1)
			end
		end

		function arg_109_1.onSingleLineUpdate_(arg_112_0)
			local var_112_0 = arg_109_1.actors_["10092_1"].transform
			local var_112_1 = 0

			if var_112_1 < arg_109_1.time_ and arg_109_1.time_ <= var_112_1 + arg_112_0 then
				arg_109_1.var_.moveOldPos10092_1 = var_112_0.localPosition
				var_112_0.localScale = Vector3.New(1, 1, 1)

				arg_109_1:CheckSpriteTmpPos("10092_1", 3)

				local var_112_2 = var_112_0.childCount

				for iter_112_0 = 0, var_112_2 - 1 do
					local var_112_3 = var_112_0:GetChild(iter_112_0)

					if var_112_3.name == "split_1_1" or not string.find(var_112_3.name, "split") then
						var_112_3.gameObject:SetActive(true)
					else
						var_112_3.gameObject:SetActive(false)
					end
				end
			end

			local var_112_4 = 0.001

			if var_112_1 <= arg_109_1.time_ and arg_109_1.time_ < var_112_1 + var_112_4 then
				local var_112_5 = (arg_109_1.time_ - var_112_1) / var_112_4
				local var_112_6 = Vector3.New(0, -300, -295)

				var_112_0.localPosition = Vector3.Lerp(arg_109_1.var_.moveOldPos10092_1, var_112_6, var_112_5)
			end

			if arg_109_1.time_ >= var_112_1 + var_112_4 and arg_109_1.time_ < var_112_1 + var_112_4 + arg_112_0 then
				var_112_0.localPosition = Vector3.New(0, -300, -295)
			end

			local var_112_7 = arg_109_1.actors_["10092_1"]
			local var_112_8 = 0

			if var_112_8 < arg_109_1.time_ and arg_109_1.time_ <= var_112_8 + arg_112_0 and not isNil(var_112_7) and arg_109_1.var_.actorSpriteComps10092_1 == nil then
				arg_109_1.var_.actorSpriteComps10092_1 = var_112_7:GetComponentsInChildren(typeof(Image), true)
			end

			local var_112_9 = 2

			if var_112_8 <= arg_109_1.time_ and arg_109_1.time_ < var_112_8 + var_112_9 and not isNil(var_112_7) then
				local var_112_10 = (arg_109_1.time_ - var_112_8) / var_112_9

				if arg_109_1.var_.actorSpriteComps10092_1 then
					for iter_112_1, iter_112_2 in pairs(arg_109_1.var_.actorSpriteComps10092_1:ToTable()) do
						if iter_112_2 then
							if arg_109_1.isInRecall_ then
								local var_112_11 = Mathf.Lerp(iter_112_2.color.r, arg_109_1.hightColor1.r, var_112_10)
								local var_112_12 = Mathf.Lerp(iter_112_2.color.g, arg_109_1.hightColor1.g, var_112_10)
								local var_112_13 = Mathf.Lerp(iter_112_2.color.b, arg_109_1.hightColor1.b, var_112_10)

								iter_112_2.color = Color.New(var_112_11, var_112_12, var_112_13)
							else
								local var_112_14 = Mathf.Lerp(iter_112_2.color.r, 1, var_112_10)

								iter_112_2.color = Color.New(var_112_14, var_112_14, var_112_14)
							end
						end
					end
				end
			end

			if arg_109_1.time_ >= var_112_8 + var_112_9 and arg_109_1.time_ < var_112_8 + var_112_9 + arg_112_0 and not isNil(var_112_7) and arg_109_1.var_.actorSpriteComps10092_1 then
				for iter_112_3, iter_112_4 in pairs(arg_109_1.var_.actorSpriteComps10092_1:ToTable()) do
					if iter_112_4 then
						if arg_109_1.isInRecall_ then
							iter_112_4.color = arg_109_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_112_4.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_109_1.var_.actorSpriteComps10092_1 = nil
			end

			local var_112_15 = 0
			local var_112_16 = 0.775

			if var_112_15 < arg_109_1.time_ and arg_109_1.time_ <= var_112_15 + arg_112_0 then
				arg_109_1.talkMaxDuration = 0
				arg_109_1.dialogCg_.alpha = 1

				arg_109_1.dialog_:SetActive(true)
				SetActive(arg_109_1.leftNameGo_, true)

				local var_112_17 = arg_109_1:FormatText(StoryNameCfg[996].name)

				arg_109_1.leftNameTxt_.text = var_112_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_109_1.leftNameTxt_.transform)

				arg_109_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_109_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_109_1:RecordName(arg_109_1.leftNameTxt_.text)
				SetActive(arg_109_1.iconTrs_.gameObject, false)
				arg_109_1.callingController_:SetSelectedState("normal")

				local var_112_18 = arg_109_1:GetWordFromCfg(413141027)
				local var_112_19 = arg_109_1:FormatText(var_112_18.content)

				arg_109_1.text_.text = var_112_19

				LuaForUtil.ClearLinePrefixSymbol(arg_109_1.text_)

				local var_112_20 = 31
				local var_112_21 = utf8.len(var_112_19)
				local var_112_22 = var_112_20 <= 0 and var_112_16 or var_112_16 * (var_112_21 / var_112_20)

				if var_112_22 > 0 and var_112_16 < var_112_22 then
					arg_109_1.talkMaxDuration = var_112_22

					if var_112_22 + var_112_15 > arg_109_1.duration_ then
						arg_109_1.duration_ = var_112_22 + var_112_15
					end
				end

				arg_109_1.text_.text = var_112_19
				arg_109_1.typewritter.percent = 0

				arg_109_1.typewritter:SetDirty()
				arg_109_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_413141", "413141027", "story_v_out_413141.awb") ~= 0 then
					local var_112_23 = manager.audio:GetVoiceLength("story_v_out_413141", "413141027", "story_v_out_413141.awb") / 1000

					if var_112_23 + var_112_15 > arg_109_1.duration_ then
						arg_109_1.duration_ = var_112_23 + var_112_15
					end

					if var_112_18.prefab_name ~= "" and arg_109_1.actors_[var_112_18.prefab_name] ~= nil then
						local var_112_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_109_1.actors_[var_112_18.prefab_name].transform, "story_v_out_413141", "413141027", "story_v_out_413141.awb")

						arg_109_1:RecordAudio("413141027", var_112_24)
						arg_109_1:RecordAudio("413141027", var_112_24)
					else
						arg_109_1:AudioAction("play", "voice", "story_v_out_413141", "413141027", "story_v_out_413141.awb")
					end

					arg_109_1:RecordHistoryTalkVoice("story_v_out_413141", "413141027", "story_v_out_413141.awb")
				end

				arg_109_1:RecordContent(arg_109_1.text_.text)
			end

			local var_112_25 = math.max(var_112_16, arg_109_1.talkMaxDuration)

			if var_112_15 <= arg_109_1.time_ and arg_109_1.time_ < var_112_15 + var_112_25 then
				arg_109_1.typewritter.percent = (arg_109_1.time_ - var_112_15) / var_112_25

				arg_109_1.typewritter:SetDirty()
			end

			if arg_109_1.time_ >= var_112_15 + var_112_25 and arg_109_1.time_ < var_112_15 + var_112_25 + arg_112_0 then
				arg_109_1.typewritter.percent = 1

				arg_109_1.typewritter:SetDirty()
				arg_109_1:ShowNextGo(true)
			end
		end

		arg_109_1.nodeConfigList_ = {
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

		arg_109_1:InitPlayNodeList()
	end,
	Play413141028 = function(arg_113_0, arg_113_1)
		arg_113_1.time_ = 0
		arg_113_1.frameCnt_ = 0
		arg_113_1.state_ = "playing"
		arg_113_1.curTalkId_ = 413141028
		arg_113_1.duration_ = 6.33

		local var_113_0 = {
			zh = 4.733,
			ja = 6.333
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
				arg_113_0:Play413141029(arg_113_1)
			end
		end

		function arg_113_1.onSingleLineUpdate_(arg_116_0)
			local var_116_0 = arg_113_1.actors_["10092_1"].transform
			local var_116_1 = 0

			if var_116_1 < arg_113_1.time_ and arg_113_1.time_ <= var_116_1 + arg_116_0 then
				arg_113_1.var_.moveOldPos10092_1 = var_116_0.localPosition
				var_116_0.localScale = Vector3.New(1, 1, 1)

				arg_113_1:CheckSpriteTmpPos("10092_1", 2)

				local var_116_2 = var_116_0.childCount

				for iter_116_0 = 0, var_116_2 - 1 do
					local var_116_3 = var_116_0:GetChild(iter_116_0)

					if var_116_3.name == "split_1_1" or not string.find(var_116_3.name, "split") then
						var_116_3.gameObject:SetActive(true)
					else
						var_116_3.gameObject:SetActive(false)
					end
				end
			end

			local var_116_4 = 0.001

			if var_116_1 <= arg_113_1.time_ and arg_113_1.time_ < var_116_1 + var_116_4 then
				local var_116_5 = (arg_113_1.time_ - var_116_1) / var_116_4
				local var_116_6 = Vector3.New(-389.49, -300, -295)

				var_116_0.localPosition = Vector3.Lerp(arg_113_1.var_.moveOldPos10092_1, var_116_6, var_116_5)
			end

			if arg_113_1.time_ >= var_116_1 + var_116_4 and arg_113_1.time_ < var_116_1 + var_116_4 + arg_116_0 then
				var_116_0.localPosition = Vector3.New(-389.49, -300, -295)
			end

			local var_116_7 = arg_113_1.actors_["10092_1"]
			local var_116_8 = 0

			if var_116_8 < arg_113_1.time_ and arg_113_1.time_ <= var_116_8 + arg_116_0 and not isNil(var_116_7) and arg_113_1.var_.actorSpriteComps10092_1 == nil then
				arg_113_1.var_.actorSpriteComps10092_1 = var_116_7:GetComponentsInChildren(typeof(Image), true)
			end

			local var_116_9 = 2

			if var_116_8 <= arg_113_1.time_ and arg_113_1.time_ < var_116_8 + var_116_9 and not isNil(var_116_7) then
				local var_116_10 = (arg_113_1.time_ - var_116_8) / var_116_9

				if arg_113_1.var_.actorSpriteComps10092_1 then
					for iter_116_1, iter_116_2 in pairs(arg_113_1.var_.actorSpriteComps10092_1:ToTable()) do
						if iter_116_2 then
							if arg_113_1.isInRecall_ then
								local var_116_11 = Mathf.Lerp(iter_116_2.color.r, arg_113_1.hightColor2.r, var_116_10)
								local var_116_12 = Mathf.Lerp(iter_116_2.color.g, arg_113_1.hightColor2.g, var_116_10)
								local var_116_13 = Mathf.Lerp(iter_116_2.color.b, arg_113_1.hightColor2.b, var_116_10)

								iter_116_2.color = Color.New(var_116_11, var_116_12, var_116_13)
							else
								local var_116_14 = Mathf.Lerp(iter_116_2.color.r, 0.5, var_116_10)

								iter_116_2.color = Color.New(var_116_14, var_116_14, var_116_14)
							end
						end
					end
				end
			end

			if arg_113_1.time_ >= var_116_8 + var_116_9 and arg_113_1.time_ < var_116_8 + var_116_9 + arg_116_0 and not isNil(var_116_7) and arg_113_1.var_.actorSpriteComps10092_1 then
				for iter_116_3, iter_116_4 in pairs(arg_113_1.var_.actorSpriteComps10092_1:ToTable()) do
					if iter_116_4 then
						if arg_113_1.isInRecall_ then
							iter_116_4.color = arg_113_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_116_4.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_113_1.var_.actorSpriteComps10092_1 = nil
			end

			local var_116_15 = arg_113_1.actors_["10093"]
			local var_116_16 = 0

			if var_116_16 < arg_113_1.time_ and arg_113_1.time_ <= var_116_16 + arg_116_0 and not isNil(var_116_15) and arg_113_1.var_.actorSpriteComps10093 == nil then
				arg_113_1.var_.actorSpriteComps10093 = var_116_15:GetComponentsInChildren(typeof(Image), true)
			end

			local var_116_17 = 2

			if var_116_16 <= arg_113_1.time_ and arg_113_1.time_ < var_116_16 + var_116_17 and not isNil(var_116_15) then
				local var_116_18 = (arg_113_1.time_ - var_116_16) / var_116_17

				if arg_113_1.var_.actorSpriteComps10093 then
					for iter_116_5, iter_116_6 in pairs(arg_113_1.var_.actorSpriteComps10093:ToTable()) do
						if iter_116_6 then
							if arg_113_1.isInRecall_ then
								local var_116_19 = Mathf.Lerp(iter_116_6.color.r, arg_113_1.hightColor1.r, var_116_18)
								local var_116_20 = Mathf.Lerp(iter_116_6.color.g, arg_113_1.hightColor1.g, var_116_18)
								local var_116_21 = Mathf.Lerp(iter_116_6.color.b, arg_113_1.hightColor1.b, var_116_18)

								iter_116_6.color = Color.New(var_116_19, var_116_20, var_116_21)
							else
								local var_116_22 = Mathf.Lerp(iter_116_6.color.r, 1, var_116_18)

								iter_116_6.color = Color.New(var_116_22, var_116_22, var_116_22)
							end
						end
					end
				end
			end

			if arg_113_1.time_ >= var_116_16 + var_116_17 and arg_113_1.time_ < var_116_16 + var_116_17 + arg_116_0 and not isNil(var_116_15) and arg_113_1.var_.actorSpriteComps10093 then
				for iter_116_7, iter_116_8 in pairs(arg_113_1.var_.actorSpriteComps10093:ToTable()) do
					if iter_116_8 then
						if arg_113_1.isInRecall_ then
							iter_116_8.color = arg_113_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_116_8.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_113_1.var_.actorSpriteComps10093 = nil
			end

			local var_116_23 = arg_113_1.actors_["10093"].transform
			local var_116_24 = 0

			if var_116_24 < arg_113_1.time_ and arg_113_1.time_ <= var_116_24 + arg_116_0 then
				arg_113_1.var_.moveOldPos10093 = var_116_23.localPosition
				var_116_23.localScale = Vector3.New(1, 1, 1)

				arg_113_1:CheckSpriteTmpPos("10093", 4)

				local var_116_25 = var_116_23.childCount

				for iter_116_9 = 0, var_116_25 - 1 do
					local var_116_26 = var_116_23:GetChild(iter_116_9)

					if var_116_26.name == "split_4" or not string.find(var_116_26.name, "split") then
						var_116_26.gameObject:SetActive(true)
					else
						var_116_26.gameObject:SetActive(false)
					end
				end
			end

			local var_116_27 = 0.001

			if var_116_24 <= arg_113_1.time_ and arg_113_1.time_ < var_116_24 + var_116_27 then
				local var_116_28 = (arg_113_1.time_ - var_116_24) / var_116_27
				local var_116_29 = Vector3.New(390, -345, -245)

				var_116_23.localPosition = Vector3.Lerp(arg_113_1.var_.moveOldPos10093, var_116_29, var_116_28)
			end

			if arg_113_1.time_ >= var_116_24 + var_116_27 and arg_113_1.time_ < var_116_24 + var_116_27 + arg_116_0 then
				var_116_23.localPosition = Vector3.New(390, -345, -245)
			end

			local var_116_30 = 0
			local var_116_31 = 0.6

			if var_116_30 < arg_113_1.time_ and arg_113_1.time_ <= var_116_30 + arg_116_0 then
				arg_113_1.talkMaxDuration = 0
				arg_113_1.dialogCg_.alpha = 1

				arg_113_1.dialog_:SetActive(true)
				SetActive(arg_113_1.leftNameGo_, true)

				local var_116_32 = arg_113_1:FormatText(StoryNameCfg[28].name)

				arg_113_1.leftNameTxt_.text = var_116_32

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_113_1.leftNameTxt_.transform)

				arg_113_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_113_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_113_1:RecordName(arg_113_1.leftNameTxt_.text)
				SetActive(arg_113_1.iconTrs_.gameObject, false)
				arg_113_1.callingController_:SetSelectedState("normal")

				local var_116_33 = arg_113_1:GetWordFromCfg(413141028)
				local var_116_34 = arg_113_1:FormatText(var_116_33.content)

				arg_113_1.text_.text = var_116_34

				LuaForUtil.ClearLinePrefixSymbol(arg_113_1.text_)

				local var_116_35 = 24
				local var_116_36 = utf8.len(var_116_34)
				local var_116_37 = var_116_35 <= 0 and var_116_31 or var_116_31 * (var_116_36 / var_116_35)

				if var_116_37 > 0 and var_116_31 < var_116_37 then
					arg_113_1.talkMaxDuration = var_116_37

					if var_116_37 + var_116_30 > arg_113_1.duration_ then
						arg_113_1.duration_ = var_116_37 + var_116_30
					end
				end

				arg_113_1.text_.text = var_116_34
				arg_113_1.typewritter.percent = 0

				arg_113_1.typewritter:SetDirty()
				arg_113_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_413141", "413141028", "story_v_out_413141.awb") ~= 0 then
					local var_116_38 = manager.audio:GetVoiceLength("story_v_out_413141", "413141028", "story_v_out_413141.awb") / 1000

					if var_116_38 + var_116_30 > arg_113_1.duration_ then
						arg_113_1.duration_ = var_116_38 + var_116_30
					end

					if var_116_33.prefab_name ~= "" and arg_113_1.actors_[var_116_33.prefab_name] ~= nil then
						local var_116_39 = LuaForUtil.PlayVoiceWithCriLipsync(arg_113_1.actors_[var_116_33.prefab_name].transform, "story_v_out_413141", "413141028", "story_v_out_413141.awb")

						arg_113_1:RecordAudio("413141028", var_116_39)
						arg_113_1:RecordAudio("413141028", var_116_39)
					else
						arg_113_1:AudioAction("play", "voice", "story_v_out_413141", "413141028", "story_v_out_413141.awb")
					end

					arg_113_1:RecordHistoryTalkVoice("story_v_out_413141", "413141028", "story_v_out_413141.awb")
				end

				arg_113_1:RecordContent(arg_113_1.text_.text)
			end

			local var_116_40 = math.max(var_116_31, arg_113_1.talkMaxDuration)

			if var_116_30 <= arg_113_1.time_ and arg_113_1.time_ < var_116_30 + var_116_40 then
				arg_113_1.typewritter.percent = (arg_113_1.time_ - var_116_30) / var_116_40

				arg_113_1.typewritter:SetDirty()
			end

			if arg_113_1.time_ >= var_116_30 + var_116_40 and arg_113_1.time_ < var_116_30 + var_116_40 + arg_116_0 then
				arg_113_1.typewritter.percent = 1

				arg_113_1.typewritter:SetDirty()
				arg_113_1:ShowNextGo(true)
			end
		end

		arg_113_1.nodeConfigList_ = {
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

		arg_113_1:InitPlayNodeList()
	end,
	Play413141029 = function(arg_117_0, arg_117_1)
		arg_117_1.time_ = 0
		arg_117_1.frameCnt_ = 0
		arg_117_1.state_ = "playing"
		arg_117_1.curTalkId_ = 413141029
		arg_117_1.duration_ = 7.9

		local var_117_0 = {
			zh = 7.033,
			ja = 7.9
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
				arg_117_0:Play413141030(arg_117_1)
			end
		end

		function arg_117_1.onSingleLineUpdate_(arg_120_0)
			local var_120_0 = arg_117_1.actors_["10092_1"].transform
			local var_120_1 = 0

			if var_120_1 < arg_117_1.time_ and arg_117_1.time_ <= var_120_1 + arg_120_0 then
				arg_117_1.var_.moveOldPos10092_1 = var_120_0.localPosition
				var_120_0.localScale = Vector3.New(1, 1, 1)

				arg_117_1:CheckSpriteTmpPos("10092_1", 2)

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
				local var_120_6 = Vector3.New(-389.49, -300, -295)

				var_120_0.localPosition = Vector3.Lerp(arg_117_1.var_.moveOldPos10092_1, var_120_6, var_120_5)
			end

			if arg_117_1.time_ >= var_120_1 + var_120_4 and arg_117_1.time_ < var_120_1 + var_120_4 + arg_120_0 then
				var_120_0.localPosition = Vector3.New(-389.49, -300, -295)
			end

			local var_120_7 = arg_117_1.actors_["10092_1"]
			local var_120_8 = 0

			if var_120_8 < arg_117_1.time_ and arg_117_1.time_ <= var_120_8 + arg_120_0 and not isNil(var_120_7) and arg_117_1.var_.actorSpriteComps10092_1 == nil then
				arg_117_1.var_.actorSpriteComps10092_1 = var_120_7:GetComponentsInChildren(typeof(Image), true)
			end

			local var_120_9 = 2

			if var_120_8 <= arg_117_1.time_ and arg_117_1.time_ < var_120_8 + var_120_9 and not isNil(var_120_7) then
				local var_120_10 = (arg_117_1.time_ - var_120_8) / var_120_9

				if arg_117_1.var_.actorSpriteComps10092_1 then
					for iter_120_1, iter_120_2 in pairs(arg_117_1.var_.actorSpriteComps10092_1:ToTable()) do
						if iter_120_2 then
							if arg_117_1.isInRecall_ then
								local var_120_11 = Mathf.Lerp(iter_120_2.color.r, arg_117_1.hightColor1.r, var_120_10)
								local var_120_12 = Mathf.Lerp(iter_120_2.color.g, arg_117_1.hightColor1.g, var_120_10)
								local var_120_13 = Mathf.Lerp(iter_120_2.color.b, arg_117_1.hightColor1.b, var_120_10)

								iter_120_2.color = Color.New(var_120_11, var_120_12, var_120_13)
							else
								local var_120_14 = Mathf.Lerp(iter_120_2.color.r, 1, var_120_10)

								iter_120_2.color = Color.New(var_120_14, var_120_14, var_120_14)
							end
						end
					end
				end
			end

			if arg_117_1.time_ >= var_120_8 + var_120_9 and arg_117_1.time_ < var_120_8 + var_120_9 + arg_120_0 and not isNil(var_120_7) and arg_117_1.var_.actorSpriteComps10092_1 then
				for iter_120_3, iter_120_4 in pairs(arg_117_1.var_.actorSpriteComps10092_1:ToTable()) do
					if iter_120_4 then
						if arg_117_1.isInRecall_ then
							iter_120_4.color = arg_117_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_120_4.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_117_1.var_.actorSpriteComps10092_1 = nil
			end

			local var_120_15 = arg_117_1.actors_["10093"].transform
			local var_120_16 = 0

			if var_120_16 < arg_117_1.time_ and arg_117_1.time_ <= var_120_16 + arg_120_0 then
				arg_117_1.var_.moveOldPos10093 = var_120_15.localPosition
				var_120_15.localScale = Vector3.New(1, 1, 1)

				arg_117_1:CheckSpriteTmpPos("10093", 4)

				local var_120_17 = var_120_15.childCount

				for iter_120_5 = 0, var_120_17 - 1 do
					local var_120_18 = var_120_15:GetChild(iter_120_5)

					if var_120_18.name == "" or not string.find(var_120_18.name, "split") then
						var_120_18.gameObject:SetActive(true)
					else
						var_120_18.gameObject:SetActive(false)
					end
				end
			end

			local var_120_19 = 0.001

			if var_120_16 <= arg_117_1.time_ and arg_117_1.time_ < var_120_16 + var_120_19 then
				local var_120_20 = (arg_117_1.time_ - var_120_16) / var_120_19
				local var_120_21 = Vector3.New(390, -345, -245)

				var_120_15.localPosition = Vector3.Lerp(arg_117_1.var_.moveOldPos10093, var_120_21, var_120_20)
			end

			if arg_117_1.time_ >= var_120_16 + var_120_19 and arg_117_1.time_ < var_120_16 + var_120_19 + arg_120_0 then
				var_120_15.localPosition = Vector3.New(390, -345, -245)
			end

			local var_120_22 = arg_117_1.actors_["10093"]
			local var_120_23 = 0

			if var_120_23 < arg_117_1.time_ and arg_117_1.time_ <= var_120_23 + arg_120_0 and not isNil(var_120_22) and arg_117_1.var_.actorSpriteComps10093 == nil then
				arg_117_1.var_.actorSpriteComps10093 = var_120_22:GetComponentsInChildren(typeof(Image), true)
			end

			local var_120_24 = 2

			if var_120_23 <= arg_117_1.time_ and arg_117_1.time_ < var_120_23 + var_120_24 and not isNil(var_120_22) then
				local var_120_25 = (arg_117_1.time_ - var_120_23) / var_120_24

				if arg_117_1.var_.actorSpriteComps10093 then
					for iter_120_6, iter_120_7 in pairs(arg_117_1.var_.actorSpriteComps10093:ToTable()) do
						if iter_120_7 then
							if arg_117_1.isInRecall_ then
								local var_120_26 = Mathf.Lerp(iter_120_7.color.r, arg_117_1.hightColor2.r, var_120_25)
								local var_120_27 = Mathf.Lerp(iter_120_7.color.g, arg_117_1.hightColor2.g, var_120_25)
								local var_120_28 = Mathf.Lerp(iter_120_7.color.b, arg_117_1.hightColor2.b, var_120_25)

								iter_120_7.color = Color.New(var_120_26, var_120_27, var_120_28)
							else
								local var_120_29 = Mathf.Lerp(iter_120_7.color.r, 0.5, var_120_25)

								iter_120_7.color = Color.New(var_120_29, var_120_29, var_120_29)
							end
						end
					end
				end
			end

			if arg_117_1.time_ >= var_120_23 + var_120_24 and arg_117_1.time_ < var_120_23 + var_120_24 + arg_120_0 and not isNil(var_120_22) and arg_117_1.var_.actorSpriteComps10093 then
				for iter_120_8, iter_120_9 in pairs(arg_117_1.var_.actorSpriteComps10093:ToTable()) do
					if iter_120_9 then
						if arg_117_1.isInRecall_ then
							iter_120_9.color = arg_117_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_120_9.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_117_1.var_.actorSpriteComps10093 = nil
			end

			local var_120_30 = 0
			local var_120_31 = 0.875

			if var_120_30 < arg_117_1.time_ and arg_117_1.time_ <= var_120_30 + arg_120_0 then
				arg_117_1.talkMaxDuration = 0
				arg_117_1.dialogCg_.alpha = 1

				arg_117_1.dialog_:SetActive(true)
				SetActive(arg_117_1.leftNameGo_, true)

				local var_120_32 = arg_117_1:FormatText(StoryNameCfg[996].name)

				arg_117_1.leftNameTxt_.text = var_120_32

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_117_1.leftNameTxt_.transform)

				arg_117_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_117_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_117_1:RecordName(arg_117_1.leftNameTxt_.text)
				SetActive(arg_117_1.iconTrs_.gameObject, false)
				arg_117_1.callingController_:SetSelectedState("normal")

				local var_120_33 = arg_117_1:GetWordFromCfg(413141029)
				local var_120_34 = arg_117_1:FormatText(var_120_33.content)

				arg_117_1.text_.text = var_120_34

				LuaForUtil.ClearLinePrefixSymbol(arg_117_1.text_)

				local var_120_35 = 35
				local var_120_36 = utf8.len(var_120_34)
				local var_120_37 = var_120_35 <= 0 and var_120_31 or var_120_31 * (var_120_36 / var_120_35)

				if var_120_37 > 0 and var_120_31 < var_120_37 then
					arg_117_1.talkMaxDuration = var_120_37

					if var_120_37 + var_120_30 > arg_117_1.duration_ then
						arg_117_1.duration_ = var_120_37 + var_120_30
					end
				end

				arg_117_1.text_.text = var_120_34
				arg_117_1.typewritter.percent = 0

				arg_117_1.typewritter:SetDirty()
				arg_117_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_413141", "413141029", "story_v_out_413141.awb") ~= 0 then
					local var_120_38 = manager.audio:GetVoiceLength("story_v_out_413141", "413141029", "story_v_out_413141.awb") / 1000

					if var_120_38 + var_120_30 > arg_117_1.duration_ then
						arg_117_1.duration_ = var_120_38 + var_120_30
					end

					if var_120_33.prefab_name ~= "" and arg_117_1.actors_[var_120_33.prefab_name] ~= nil then
						local var_120_39 = LuaForUtil.PlayVoiceWithCriLipsync(arg_117_1.actors_[var_120_33.prefab_name].transform, "story_v_out_413141", "413141029", "story_v_out_413141.awb")

						arg_117_1:RecordAudio("413141029", var_120_39)
						arg_117_1:RecordAudio("413141029", var_120_39)
					else
						arg_117_1:AudioAction("play", "voice", "story_v_out_413141", "413141029", "story_v_out_413141.awb")
					end

					arg_117_1:RecordHistoryTalkVoice("story_v_out_413141", "413141029", "story_v_out_413141.awb")
				end

				arg_117_1:RecordContent(arg_117_1.text_.text)
			end

			local var_120_40 = math.max(var_120_31, arg_117_1.talkMaxDuration)

			if var_120_30 <= arg_117_1.time_ and arg_117_1.time_ < var_120_30 + var_120_40 then
				arg_117_1.typewritter.percent = (arg_117_1.time_ - var_120_30) / var_120_40

				arg_117_1.typewritter:SetDirty()
			end

			if arg_117_1.time_ >= var_120_30 + var_120_40 and arg_117_1.time_ < var_120_30 + var_120_40 + arg_120_0 then
				arg_117_1.typewritter.percent = 1

				arg_117_1.typewritter:SetDirty()
				arg_117_1:ShowNextGo(true)
			end
		end

		arg_117_1.nodeConfigList_ = {
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

		arg_117_1:InitPlayNodeList()
	end,
	Play413141030 = function(arg_121_0, arg_121_1)
		arg_121_1.time_ = 0
		arg_121_1.frameCnt_ = 0
		arg_121_1.state_ = "playing"
		arg_121_1.curTalkId_ = 413141030
		arg_121_1.duration_ = 5

		SetActive(arg_121_1.tipsGo_, false)

		function arg_121_1.onSingleLineFinish_()
			arg_121_1.onSingleLineUpdate_ = nil
			arg_121_1.onSingleLineFinish_ = nil
			arg_121_1.state_ = "waiting"
		end

		function arg_121_1.playNext_(arg_123_0)
			if arg_123_0 == 1 then
				arg_121_0:Play413141031(arg_121_1)
			end
		end

		function arg_121_1.onSingleLineUpdate_(arg_124_0)
			local var_124_0 = arg_121_1.actors_["10092_1"]
			local var_124_1 = 0

			if var_124_1 < arg_121_1.time_ and arg_121_1.time_ <= var_124_1 + arg_124_0 and not isNil(var_124_0) and arg_121_1.var_.actorSpriteComps10092_1 == nil then
				arg_121_1.var_.actorSpriteComps10092_1 = var_124_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_124_2 = 2

			if var_124_1 <= arg_121_1.time_ and arg_121_1.time_ < var_124_1 + var_124_2 and not isNil(var_124_0) then
				local var_124_3 = (arg_121_1.time_ - var_124_1) / var_124_2

				if arg_121_1.var_.actorSpriteComps10092_1 then
					for iter_124_0, iter_124_1 in pairs(arg_121_1.var_.actorSpriteComps10092_1:ToTable()) do
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

			if arg_121_1.time_ >= var_124_1 + var_124_2 and arg_121_1.time_ < var_124_1 + var_124_2 + arg_124_0 and not isNil(var_124_0) and arg_121_1.var_.actorSpriteComps10092_1 then
				for iter_124_2, iter_124_3 in pairs(arg_121_1.var_.actorSpriteComps10092_1:ToTable()) do
					if iter_124_3 then
						if arg_121_1.isInRecall_ then
							iter_124_3.color = arg_121_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_124_3.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_121_1.var_.actorSpriteComps10092_1 = nil
			end

			local var_124_8 = arg_121_1.actors_["10092_1"].transform
			local var_124_9 = 0

			if var_124_9 < arg_121_1.time_ and arg_121_1.time_ <= var_124_9 + arg_124_0 then
				arg_121_1.var_.moveOldPos10092_1 = var_124_8.localPosition
				var_124_8.localScale = Vector3.New(1, 1, 1)

				arg_121_1:CheckSpriteTmpPos("10092_1", 7)

				local var_124_10 = var_124_8.childCount

				for iter_124_4 = 0, var_124_10 - 1 do
					local var_124_11 = var_124_8:GetChild(iter_124_4)

					if var_124_11.name == "split_2" or not string.find(var_124_11.name, "split") then
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

				var_124_8.localPosition = Vector3.Lerp(arg_121_1.var_.moveOldPos10092_1, var_124_14, var_124_13)
			end

			if arg_121_1.time_ >= var_124_9 + var_124_12 and arg_121_1.time_ < var_124_9 + var_124_12 + arg_124_0 then
				var_124_8.localPosition = Vector3.New(0, -2000, 0)
			end

			local var_124_15 = arg_121_1.actors_["10093"].transform
			local var_124_16 = 0

			if var_124_16 < arg_121_1.time_ and arg_121_1.time_ <= var_124_16 + arg_124_0 then
				arg_121_1.var_.moveOldPos10093 = var_124_15.localPosition
				var_124_15.localScale = Vector3.New(1, 1, 1)

				arg_121_1:CheckSpriteTmpPos("10093", 7)

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

				var_124_15.localPosition = Vector3.Lerp(arg_121_1.var_.moveOldPos10093, var_124_21, var_124_20)
			end

			if arg_121_1.time_ >= var_124_16 + var_124_19 and arg_121_1.time_ < var_124_16 + var_124_19 + arg_124_0 then
				var_124_15.localPosition = Vector3.New(0, -2000, 0)
			end

			local var_124_22 = 0
			local var_124_23 = 1

			if var_124_22 < arg_121_1.time_ and arg_121_1.time_ <= var_124_22 + arg_124_0 then
				arg_121_1.talkMaxDuration = 0
				arg_121_1.dialogCg_.alpha = 1

				arg_121_1.dialog_:SetActive(true)
				SetActive(arg_121_1.leftNameGo_, false)

				arg_121_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_121_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_121_1:RecordName(arg_121_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_121_1.iconTrs_.gameObject, false)
				arg_121_1.callingController_:SetSelectedState("normal")

				local var_124_24 = arg_121_1:GetWordFromCfg(413141030)
				local var_124_25 = arg_121_1:FormatText(var_124_24.content)

				arg_121_1.text_.text = var_124_25

				LuaForUtil.ClearLinePrefixSymbol(arg_121_1.text_)

				local var_124_26 = 40
				local var_124_27 = utf8.len(var_124_25)
				local var_124_28 = var_124_26 <= 0 and var_124_23 or var_124_23 * (var_124_27 / var_124_26)

				if var_124_28 > 0 and var_124_23 < var_124_28 then
					arg_121_1.talkMaxDuration = var_124_28

					if var_124_28 + var_124_22 > arg_121_1.duration_ then
						arg_121_1.duration_ = var_124_28 + var_124_22
					end
				end

				arg_121_1.text_.text = var_124_25
				arg_121_1.typewritter.percent = 0

				arg_121_1.typewritter:SetDirty()
				arg_121_1:ShowNextGo(false)
				arg_121_1:RecordContent(arg_121_1.text_.text)
			end

			local var_124_29 = math.max(var_124_23, arg_121_1.talkMaxDuration)

			if var_124_22 <= arg_121_1.time_ and arg_121_1.time_ < var_124_22 + var_124_29 then
				arg_121_1.typewritter.percent = (arg_121_1.time_ - var_124_22) / var_124_29

				arg_121_1.typewritter:SetDirty()
			end

			if arg_121_1.time_ >= var_124_22 + var_124_29 and arg_121_1.time_ < var_124_22 + var_124_29 + arg_124_0 then
				arg_121_1.typewritter.percent = 1

				arg_121_1.typewritter:SetDirty()
				arg_121_1:ShowNextGo(true)
			end
		end

		arg_121_1.nodeConfigList_ = {
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

		arg_121_1:InitPlayNodeList()
	end,
	Play413141031 = function(arg_125_0, arg_125_1)
		arg_125_1.time_ = 0
		arg_125_1.frameCnt_ = 0
		arg_125_1.state_ = "playing"
		arg_125_1.curTalkId_ = 413141031
		arg_125_1.duration_ = 7.8

		local var_125_0 = {
			zh = 3.9,
			ja = 7.8
		}
		local var_125_1 = manager.audio:GetLocalizationFlag()

		if var_125_0[var_125_1] ~= nil then
			arg_125_1.duration_ = var_125_0[var_125_1]
		end

		SetActive(arg_125_1.tipsGo_, false)

		function arg_125_1.onSingleLineFinish_()
			arg_125_1.onSingleLineUpdate_ = nil
			arg_125_1.onSingleLineFinish_ = nil
			arg_125_1.state_ = "waiting"
		end

		function arg_125_1.playNext_(arg_127_0)
			if arg_127_0 == 1 then
				arg_125_0:Play413141032(arg_125_1)
			end
		end

		function arg_125_1.onSingleLineUpdate_(arg_128_0)
			local var_128_0 = arg_125_1.actors_["10092_1"].transform
			local var_128_1 = 0

			if var_128_1 < arg_125_1.time_ and arg_125_1.time_ <= var_128_1 + arg_128_0 then
				arg_125_1.var_.moveOldPos10092_1 = var_128_0.localPosition
				var_128_0.localScale = Vector3.New(1, 1, 1)

				arg_125_1:CheckSpriteTmpPos("10092_1", 3)

				local var_128_2 = var_128_0.childCount

				for iter_128_0 = 0, var_128_2 - 1 do
					local var_128_3 = var_128_0:GetChild(iter_128_0)

					if var_128_3.name == "" or not string.find(var_128_3.name, "split") then
						var_128_3.gameObject:SetActive(true)
					else
						var_128_3.gameObject:SetActive(false)
					end
				end
			end

			local var_128_4 = 0.001

			if var_128_1 <= arg_125_1.time_ and arg_125_1.time_ < var_128_1 + var_128_4 then
				local var_128_5 = (arg_125_1.time_ - var_128_1) / var_128_4
				local var_128_6 = Vector3.New(0, -300, -295)

				var_128_0.localPosition = Vector3.Lerp(arg_125_1.var_.moveOldPos10092_1, var_128_6, var_128_5)
			end

			if arg_125_1.time_ >= var_128_1 + var_128_4 and arg_125_1.time_ < var_128_1 + var_128_4 + arg_128_0 then
				var_128_0.localPosition = Vector3.New(0, -300, -295)
			end

			local var_128_7 = arg_125_1.actors_["10092_1"]
			local var_128_8 = 0

			if var_128_8 < arg_125_1.time_ and arg_125_1.time_ <= var_128_8 + arg_128_0 and not isNil(var_128_7) and arg_125_1.var_.actorSpriteComps10092_1 == nil then
				arg_125_1.var_.actorSpriteComps10092_1 = var_128_7:GetComponentsInChildren(typeof(Image), true)
			end

			local var_128_9 = 2

			if var_128_8 <= arg_125_1.time_ and arg_125_1.time_ < var_128_8 + var_128_9 and not isNil(var_128_7) then
				local var_128_10 = (arg_125_1.time_ - var_128_8) / var_128_9

				if arg_125_1.var_.actorSpriteComps10092_1 then
					for iter_128_1, iter_128_2 in pairs(arg_125_1.var_.actorSpriteComps10092_1:ToTable()) do
						if iter_128_2 then
							if arg_125_1.isInRecall_ then
								local var_128_11 = Mathf.Lerp(iter_128_2.color.r, arg_125_1.hightColor1.r, var_128_10)
								local var_128_12 = Mathf.Lerp(iter_128_2.color.g, arg_125_1.hightColor1.g, var_128_10)
								local var_128_13 = Mathf.Lerp(iter_128_2.color.b, arg_125_1.hightColor1.b, var_128_10)

								iter_128_2.color = Color.New(var_128_11, var_128_12, var_128_13)
							else
								local var_128_14 = Mathf.Lerp(iter_128_2.color.r, 1, var_128_10)

								iter_128_2.color = Color.New(var_128_14, var_128_14, var_128_14)
							end
						end
					end
				end
			end

			if arg_125_1.time_ >= var_128_8 + var_128_9 and arg_125_1.time_ < var_128_8 + var_128_9 + arg_128_0 and not isNil(var_128_7) and arg_125_1.var_.actorSpriteComps10092_1 then
				for iter_128_3, iter_128_4 in pairs(arg_125_1.var_.actorSpriteComps10092_1:ToTable()) do
					if iter_128_4 then
						if arg_125_1.isInRecall_ then
							iter_128_4.color = arg_125_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_128_4.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_125_1.var_.actorSpriteComps10092_1 = nil
			end

			local var_128_15 = 0
			local var_128_16 = 0.55

			if var_128_15 < arg_125_1.time_ and arg_125_1.time_ <= var_128_15 + arg_128_0 then
				arg_125_1.talkMaxDuration = 0
				arg_125_1.dialogCg_.alpha = 1

				arg_125_1.dialog_:SetActive(true)
				SetActive(arg_125_1.leftNameGo_, true)

				local var_128_17 = arg_125_1:FormatText(StoryNameCfg[996].name)

				arg_125_1.leftNameTxt_.text = var_128_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_125_1.leftNameTxt_.transform)

				arg_125_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_125_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_125_1:RecordName(arg_125_1.leftNameTxt_.text)
				SetActive(arg_125_1.iconTrs_.gameObject, false)
				arg_125_1.callingController_:SetSelectedState("normal")

				local var_128_18 = arg_125_1:GetWordFromCfg(413141031)
				local var_128_19 = arg_125_1:FormatText(var_128_18.content)

				arg_125_1.text_.text = var_128_19

				LuaForUtil.ClearLinePrefixSymbol(arg_125_1.text_)

				local var_128_20 = 22
				local var_128_21 = utf8.len(var_128_19)
				local var_128_22 = var_128_20 <= 0 and var_128_16 or var_128_16 * (var_128_21 / var_128_20)

				if var_128_22 > 0 and var_128_16 < var_128_22 then
					arg_125_1.talkMaxDuration = var_128_22

					if var_128_22 + var_128_15 > arg_125_1.duration_ then
						arg_125_1.duration_ = var_128_22 + var_128_15
					end
				end

				arg_125_1.text_.text = var_128_19
				arg_125_1.typewritter.percent = 0

				arg_125_1.typewritter:SetDirty()
				arg_125_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_413141", "413141031", "story_v_out_413141.awb") ~= 0 then
					local var_128_23 = manager.audio:GetVoiceLength("story_v_out_413141", "413141031", "story_v_out_413141.awb") / 1000

					if var_128_23 + var_128_15 > arg_125_1.duration_ then
						arg_125_1.duration_ = var_128_23 + var_128_15
					end

					if var_128_18.prefab_name ~= "" and arg_125_1.actors_[var_128_18.prefab_name] ~= nil then
						local var_128_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_125_1.actors_[var_128_18.prefab_name].transform, "story_v_out_413141", "413141031", "story_v_out_413141.awb")

						arg_125_1:RecordAudio("413141031", var_128_24)
						arg_125_1:RecordAudio("413141031", var_128_24)
					else
						arg_125_1:AudioAction("play", "voice", "story_v_out_413141", "413141031", "story_v_out_413141.awb")
					end

					arg_125_1:RecordHistoryTalkVoice("story_v_out_413141", "413141031", "story_v_out_413141.awb")
				end

				arg_125_1:RecordContent(arg_125_1.text_.text)
			end

			local var_128_25 = math.max(var_128_16, arg_125_1.talkMaxDuration)

			if var_128_15 <= arg_125_1.time_ and arg_125_1.time_ < var_128_15 + var_128_25 then
				arg_125_1.typewritter.percent = (arg_125_1.time_ - var_128_15) / var_128_25

				arg_125_1.typewritter:SetDirty()
			end

			if arg_125_1.time_ >= var_128_15 + var_128_25 and arg_125_1.time_ < var_128_15 + var_128_25 + arg_128_0 then
				arg_125_1.typewritter.percent = 1

				arg_125_1.typewritter:SetDirty()
				arg_125_1:ShowNextGo(true)
			end
		end

		arg_125_1.nodeConfigList_ = {
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

		arg_125_1:InitPlayNodeList()
	end,
	Play413141032 = function(arg_129_0, arg_129_1)
		arg_129_1.time_ = 0
		arg_129_1.frameCnt_ = 0
		arg_129_1.state_ = "playing"
		arg_129_1.curTalkId_ = 413141032
		arg_129_1.duration_ = 7.8

		local var_129_0 = {
			zh = 5.333,
			ja = 7.8
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
				arg_129_0:Play413141033(arg_129_1)
			end
		end

		function arg_129_1.onSingleLineUpdate_(arg_132_0)
			local var_132_0 = 0
			local var_132_1 = 0.625

			if var_132_0 < arg_129_1.time_ and arg_129_1.time_ <= var_132_0 + arg_132_0 then
				arg_129_1.talkMaxDuration = 0
				arg_129_1.dialogCg_.alpha = 1

				arg_129_1.dialog_:SetActive(true)
				SetActive(arg_129_1.leftNameGo_, true)

				local var_132_2 = arg_129_1:FormatText(StoryNameCfg[996].name)

				arg_129_1.leftNameTxt_.text = var_132_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_129_1.leftNameTxt_.transform)

				arg_129_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_129_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_129_1:RecordName(arg_129_1.leftNameTxt_.text)
				SetActive(arg_129_1.iconTrs_.gameObject, false)
				arg_129_1.callingController_:SetSelectedState("normal")

				local var_132_3 = arg_129_1:GetWordFromCfg(413141032)
				local var_132_4 = arg_129_1:FormatText(var_132_3.content)

				arg_129_1.text_.text = var_132_4

				LuaForUtil.ClearLinePrefixSymbol(arg_129_1.text_)

				local var_132_5 = 25
				local var_132_6 = utf8.len(var_132_4)
				local var_132_7 = var_132_5 <= 0 and var_132_1 or var_132_1 * (var_132_6 / var_132_5)

				if var_132_7 > 0 and var_132_1 < var_132_7 then
					arg_129_1.talkMaxDuration = var_132_7

					if var_132_7 + var_132_0 > arg_129_1.duration_ then
						arg_129_1.duration_ = var_132_7 + var_132_0
					end
				end

				arg_129_1.text_.text = var_132_4
				arg_129_1.typewritter.percent = 0

				arg_129_1.typewritter:SetDirty()
				arg_129_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_413141", "413141032", "story_v_out_413141.awb") ~= 0 then
					local var_132_8 = manager.audio:GetVoiceLength("story_v_out_413141", "413141032", "story_v_out_413141.awb") / 1000

					if var_132_8 + var_132_0 > arg_129_1.duration_ then
						arg_129_1.duration_ = var_132_8 + var_132_0
					end

					if var_132_3.prefab_name ~= "" and arg_129_1.actors_[var_132_3.prefab_name] ~= nil then
						local var_132_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_129_1.actors_[var_132_3.prefab_name].transform, "story_v_out_413141", "413141032", "story_v_out_413141.awb")

						arg_129_1:RecordAudio("413141032", var_132_9)
						arg_129_1:RecordAudio("413141032", var_132_9)
					else
						arg_129_1:AudioAction("play", "voice", "story_v_out_413141", "413141032", "story_v_out_413141.awb")
					end

					arg_129_1:RecordHistoryTalkVoice("story_v_out_413141", "413141032", "story_v_out_413141.awb")
				end

				arg_129_1:RecordContent(arg_129_1.text_.text)
			end

			local var_132_10 = math.max(var_132_1, arg_129_1.talkMaxDuration)

			if var_132_0 <= arg_129_1.time_ and arg_129_1.time_ < var_132_0 + var_132_10 then
				arg_129_1.typewritter.percent = (arg_129_1.time_ - var_132_0) / var_132_10

				arg_129_1.typewritter:SetDirty()
			end

			if arg_129_1.time_ >= var_132_0 + var_132_10 and arg_129_1.time_ < var_132_0 + var_132_10 + arg_132_0 then
				arg_129_1.typewritter.percent = 1

				arg_129_1.typewritter:SetDirty()
				arg_129_1:ShowNextGo(true)
			end
		end

		arg_129_1.nodeConfigList_ = {}

		arg_129_1:InitPlayNodeList()
	end,
	Play413141033 = function(arg_133_0, arg_133_1)
		arg_133_1.time_ = 0
		arg_133_1.frameCnt_ = 0
		arg_133_1.state_ = "playing"
		arg_133_1.curTalkId_ = 413141033
		arg_133_1.duration_ = 16.2

		local var_133_0 = {
			zh = 8.233,
			ja = 16.2
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
				arg_133_0:Play413141034(arg_133_1)
			end
		end

		function arg_133_1.onSingleLineUpdate_(arg_136_0)
			local var_136_0 = arg_133_1.actors_["10092_1"]
			local var_136_1 = 0

			if var_136_1 < arg_133_1.time_ and arg_133_1.time_ <= var_136_1 + arg_136_0 and not isNil(var_136_0) and arg_133_1.var_.actorSpriteComps10092_1 == nil then
				arg_133_1.var_.actorSpriteComps10092_1 = var_136_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_136_2 = 2

			if var_136_1 <= arg_133_1.time_ and arg_133_1.time_ < var_136_1 + var_136_2 and not isNil(var_136_0) then
				local var_136_3 = (arg_133_1.time_ - var_136_1) / var_136_2

				if arg_133_1.var_.actorSpriteComps10092_1 then
					for iter_136_0, iter_136_1 in pairs(arg_133_1.var_.actorSpriteComps10092_1:ToTable()) do
						if iter_136_1 then
							if arg_133_1.isInRecall_ then
								local var_136_4 = Mathf.Lerp(iter_136_1.color.r, arg_133_1.hightColor1.r, var_136_3)
								local var_136_5 = Mathf.Lerp(iter_136_1.color.g, arg_133_1.hightColor1.g, var_136_3)
								local var_136_6 = Mathf.Lerp(iter_136_1.color.b, arg_133_1.hightColor1.b, var_136_3)

								iter_136_1.color = Color.New(var_136_4, var_136_5, var_136_6)
							else
								local var_136_7 = Mathf.Lerp(iter_136_1.color.r, 1, var_136_3)

								iter_136_1.color = Color.New(var_136_7, var_136_7, var_136_7)
							end
						end
					end
				end
			end

			if arg_133_1.time_ >= var_136_1 + var_136_2 and arg_133_1.time_ < var_136_1 + var_136_2 + arg_136_0 and not isNil(var_136_0) and arg_133_1.var_.actorSpriteComps10092_1 then
				for iter_136_2, iter_136_3 in pairs(arg_133_1.var_.actorSpriteComps10092_1:ToTable()) do
					if iter_136_3 then
						if arg_133_1.isInRecall_ then
							iter_136_3.color = arg_133_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_136_3.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_133_1.var_.actorSpriteComps10092_1 = nil
			end

			local var_136_8 = 0
			local var_136_9 = 0.975

			if var_136_8 < arg_133_1.time_ and arg_133_1.time_ <= var_136_8 + arg_136_0 then
				arg_133_1.talkMaxDuration = 0
				arg_133_1.dialogCg_.alpha = 1

				arg_133_1.dialog_:SetActive(true)
				SetActive(arg_133_1.leftNameGo_, true)

				local var_136_10 = arg_133_1:FormatText(StoryNameCfg[996].name)

				arg_133_1.leftNameTxt_.text = var_136_10

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_133_1.leftNameTxt_.transform)

				arg_133_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_133_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_133_1:RecordName(arg_133_1.leftNameTxt_.text)
				SetActive(arg_133_1.iconTrs_.gameObject, false)
				arg_133_1.callingController_:SetSelectedState("normal")

				local var_136_11 = arg_133_1:GetWordFromCfg(413141033)
				local var_136_12 = arg_133_1:FormatText(var_136_11.content)

				arg_133_1.text_.text = var_136_12

				LuaForUtil.ClearLinePrefixSymbol(arg_133_1.text_)

				local var_136_13 = 39
				local var_136_14 = utf8.len(var_136_12)
				local var_136_15 = var_136_13 <= 0 and var_136_9 or var_136_9 * (var_136_14 / var_136_13)

				if var_136_15 > 0 and var_136_9 < var_136_15 then
					arg_133_1.talkMaxDuration = var_136_15

					if var_136_15 + var_136_8 > arg_133_1.duration_ then
						arg_133_1.duration_ = var_136_15 + var_136_8
					end
				end

				arg_133_1.text_.text = var_136_12
				arg_133_1.typewritter.percent = 0

				arg_133_1.typewritter:SetDirty()
				arg_133_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_413141", "413141033", "story_v_out_413141.awb") ~= 0 then
					local var_136_16 = manager.audio:GetVoiceLength("story_v_out_413141", "413141033", "story_v_out_413141.awb") / 1000

					if var_136_16 + var_136_8 > arg_133_1.duration_ then
						arg_133_1.duration_ = var_136_16 + var_136_8
					end

					if var_136_11.prefab_name ~= "" and arg_133_1.actors_[var_136_11.prefab_name] ~= nil then
						local var_136_17 = LuaForUtil.PlayVoiceWithCriLipsync(arg_133_1.actors_[var_136_11.prefab_name].transform, "story_v_out_413141", "413141033", "story_v_out_413141.awb")

						arg_133_1:RecordAudio("413141033", var_136_17)
						arg_133_1:RecordAudio("413141033", var_136_17)
					else
						arg_133_1:AudioAction("play", "voice", "story_v_out_413141", "413141033", "story_v_out_413141.awb")
					end

					arg_133_1:RecordHistoryTalkVoice("story_v_out_413141", "413141033", "story_v_out_413141.awb")
				end

				arg_133_1:RecordContent(arg_133_1.text_.text)
			end

			local var_136_18 = math.max(var_136_9, arg_133_1.talkMaxDuration)

			if var_136_8 <= arg_133_1.time_ and arg_133_1.time_ < var_136_8 + var_136_18 then
				arg_133_1.typewritter.percent = (arg_133_1.time_ - var_136_8) / var_136_18

				arg_133_1.typewritter:SetDirty()
			end

			if arg_133_1.time_ >= var_136_8 + var_136_18 and arg_133_1.time_ < var_136_8 + var_136_18 + arg_136_0 then
				arg_133_1.typewritter.percent = 1

				arg_133_1.typewritter:SetDirty()
				arg_133_1:ShowNextGo(true)
			end
		end

		arg_133_1.nodeConfigList_ = {}

		arg_133_1:InitPlayNodeList()
	end,
	Play413141034 = function(arg_137_0, arg_137_1)
		arg_137_1.time_ = 0
		arg_137_1.frameCnt_ = 0
		arg_137_1.state_ = "playing"
		arg_137_1.curTalkId_ = 413141034
		arg_137_1.duration_ = 2

		SetActive(arg_137_1.tipsGo_, false)

		function arg_137_1.onSingleLineFinish_()
			arg_137_1.onSingleLineUpdate_ = nil
			arg_137_1.onSingleLineFinish_ = nil
			arg_137_1.state_ = "waiting"
		end

		function arg_137_1.playNext_(arg_139_0)
			if arg_139_0 == 1 then
				arg_137_0:Play413141035(arg_137_1)
			end
		end

		function arg_137_1.onSingleLineUpdate_(arg_140_0)
			local var_140_0 = arg_137_1.actors_["10092_1"].transform
			local var_140_1 = 0

			if var_140_1 < arg_137_1.time_ and arg_137_1.time_ <= var_140_1 + arg_140_0 then
				arg_137_1.var_.moveOldPos10092_1 = var_140_0.localPosition
				var_140_0.localScale = Vector3.New(1, 1, 1)

				arg_137_1:CheckSpriteTmpPos("10092_1", 2)

				local var_140_2 = var_140_0.childCount

				for iter_140_0 = 0, var_140_2 - 1 do
					local var_140_3 = var_140_0:GetChild(iter_140_0)

					if var_140_3.name == "" or not string.find(var_140_3.name, "split") then
						var_140_3.gameObject:SetActive(true)
					else
						var_140_3.gameObject:SetActive(false)
					end
				end
			end

			local var_140_4 = 0.001

			if var_140_1 <= arg_137_1.time_ and arg_137_1.time_ < var_140_1 + var_140_4 then
				local var_140_5 = (arg_137_1.time_ - var_140_1) / var_140_4
				local var_140_6 = Vector3.New(-389.49, -300, -295)

				var_140_0.localPosition = Vector3.Lerp(arg_137_1.var_.moveOldPos10092_1, var_140_6, var_140_5)
			end

			if arg_137_1.time_ >= var_140_1 + var_140_4 and arg_137_1.time_ < var_140_1 + var_140_4 + arg_140_0 then
				var_140_0.localPosition = Vector3.New(-389.49, -300, -295)
			end

			local var_140_7 = arg_137_1.actors_["10093"].transform
			local var_140_8 = 0

			if var_140_8 < arg_137_1.time_ and arg_137_1.time_ <= var_140_8 + arg_140_0 then
				arg_137_1.var_.moveOldPos10093 = var_140_7.localPosition
				var_140_7.localScale = Vector3.New(1, 1, 1)

				arg_137_1:CheckSpriteTmpPos("10093", 4)

				local var_140_9 = var_140_7.childCount

				for iter_140_1 = 0, var_140_9 - 1 do
					local var_140_10 = var_140_7:GetChild(iter_140_1)

					if var_140_10.name == "" or not string.find(var_140_10.name, "split") then
						var_140_10.gameObject:SetActive(true)
					else
						var_140_10.gameObject:SetActive(false)
					end
				end
			end

			local var_140_11 = 0.001

			if var_140_8 <= arg_137_1.time_ and arg_137_1.time_ < var_140_8 + var_140_11 then
				local var_140_12 = (arg_137_1.time_ - var_140_8) / var_140_11
				local var_140_13 = Vector3.New(390, -345, -245)

				var_140_7.localPosition = Vector3.Lerp(arg_137_1.var_.moveOldPos10093, var_140_13, var_140_12)
			end

			if arg_137_1.time_ >= var_140_8 + var_140_11 and arg_137_1.time_ < var_140_8 + var_140_11 + arg_140_0 then
				var_140_7.localPosition = Vector3.New(390, -345, -245)
			end

			local var_140_14 = arg_137_1.actors_["10092_1"]
			local var_140_15 = 0

			if var_140_15 < arg_137_1.time_ and arg_137_1.time_ <= var_140_15 + arg_140_0 and not isNil(var_140_14) and arg_137_1.var_.actorSpriteComps10092_1 == nil then
				arg_137_1.var_.actorSpriteComps10092_1 = var_140_14:GetComponentsInChildren(typeof(Image), true)
			end

			local var_140_16 = 2

			if var_140_15 <= arg_137_1.time_ and arg_137_1.time_ < var_140_15 + var_140_16 and not isNil(var_140_14) then
				local var_140_17 = (arg_137_1.time_ - var_140_15) / var_140_16

				if arg_137_1.var_.actorSpriteComps10092_1 then
					for iter_140_2, iter_140_3 in pairs(arg_137_1.var_.actorSpriteComps10092_1:ToTable()) do
						if iter_140_3 then
							if arg_137_1.isInRecall_ then
								local var_140_18 = Mathf.Lerp(iter_140_3.color.r, arg_137_1.hightColor2.r, var_140_17)
								local var_140_19 = Mathf.Lerp(iter_140_3.color.g, arg_137_1.hightColor2.g, var_140_17)
								local var_140_20 = Mathf.Lerp(iter_140_3.color.b, arg_137_1.hightColor2.b, var_140_17)

								iter_140_3.color = Color.New(var_140_18, var_140_19, var_140_20)
							else
								local var_140_21 = Mathf.Lerp(iter_140_3.color.r, 0.5, var_140_17)

								iter_140_3.color = Color.New(var_140_21, var_140_21, var_140_21)
							end
						end
					end
				end
			end

			if arg_137_1.time_ >= var_140_15 + var_140_16 and arg_137_1.time_ < var_140_15 + var_140_16 + arg_140_0 and not isNil(var_140_14) and arg_137_1.var_.actorSpriteComps10092_1 then
				for iter_140_4, iter_140_5 in pairs(arg_137_1.var_.actorSpriteComps10092_1:ToTable()) do
					if iter_140_5 then
						if arg_137_1.isInRecall_ then
							iter_140_5.color = arg_137_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_140_5.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_137_1.var_.actorSpriteComps10092_1 = nil
			end

			local var_140_22 = arg_137_1.actors_["10093"]
			local var_140_23 = 0

			if var_140_23 < arg_137_1.time_ and arg_137_1.time_ <= var_140_23 + arg_140_0 and not isNil(var_140_22) and arg_137_1.var_.actorSpriteComps10093 == nil then
				arg_137_1.var_.actorSpriteComps10093 = var_140_22:GetComponentsInChildren(typeof(Image), true)
			end

			local var_140_24 = 2

			if var_140_23 <= arg_137_1.time_ and arg_137_1.time_ < var_140_23 + var_140_24 and not isNil(var_140_22) then
				local var_140_25 = (arg_137_1.time_ - var_140_23) / var_140_24

				if arg_137_1.var_.actorSpriteComps10093 then
					for iter_140_6, iter_140_7 in pairs(arg_137_1.var_.actorSpriteComps10093:ToTable()) do
						if iter_140_7 then
							if arg_137_1.isInRecall_ then
								local var_140_26 = Mathf.Lerp(iter_140_7.color.r, arg_137_1.hightColor1.r, var_140_25)
								local var_140_27 = Mathf.Lerp(iter_140_7.color.g, arg_137_1.hightColor1.g, var_140_25)
								local var_140_28 = Mathf.Lerp(iter_140_7.color.b, arg_137_1.hightColor1.b, var_140_25)

								iter_140_7.color = Color.New(var_140_26, var_140_27, var_140_28)
							else
								local var_140_29 = Mathf.Lerp(iter_140_7.color.r, 1, var_140_25)

								iter_140_7.color = Color.New(var_140_29, var_140_29, var_140_29)
							end
						end
					end
				end
			end

			if arg_137_1.time_ >= var_140_23 + var_140_24 and arg_137_1.time_ < var_140_23 + var_140_24 + arg_140_0 and not isNil(var_140_22) and arg_137_1.var_.actorSpriteComps10093 then
				for iter_140_8, iter_140_9 in pairs(arg_137_1.var_.actorSpriteComps10093:ToTable()) do
					if iter_140_9 then
						if arg_137_1.isInRecall_ then
							iter_140_9.color = arg_137_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_140_9.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_137_1.var_.actorSpriteComps10093 = nil
			end

			local var_140_30 = 0
			local var_140_31 = 0.1

			if var_140_30 < arg_137_1.time_ and arg_137_1.time_ <= var_140_30 + arg_140_0 then
				arg_137_1.talkMaxDuration = 0
				arg_137_1.dialogCg_.alpha = 1

				arg_137_1.dialog_:SetActive(true)
				SetActive(arg_137_1.leftNameGo_, true)

				local var_140_32 = arg_137_1:FormatText(StoryNameCfg[28].name)

				arg_137_1.leftNameTxt_.text = var_140_32

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_137_1.leftNameTxt_.transform)

				arg_137_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_137_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_137_1:RecordName(arg_137_1.leftNameTxt_.text)
				SetActive(arg_137_1.iconTrs_.gameObject, false)
				arg_137_1.callingController_:SetSelectedState("normal")

				local var_140_33 = arg_137_1:GetWordFromCfg(413141034)
				local var_140_34 = arg_137_1:FormatText(var_140_33.content)

				arg_137_1.text_.text = var_140_34

				LuaForUtil.ClearLinePrefixSymbol(arg_137_1.text_)

				local var_140_35 = 4
				local var_140_36 = utf8.len(var_140_34)
				local var_140_37 = var_140_35 <= 0 and var_140_31 or var_140_31 * (var_140_36 / var_140_35)

				if var_140_37 > 0 and var_140_31 < var_140_37 then
					arg_137_1.talkMaxDuration = var_140_37

					if var_140_37 + var_140_30 > arg_137_1.duration_ then
						arg_137_1.duration_ = var_140_37 + var_140_30
					end
				end

				arg_137_1.text_.text = var_140_34
				arg_137_1.typewritter.percent = 0

				arg_137_1.typewritter:SetDirty()
				arg_137_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_413141", "413141034", "story_v_out_413141.awb") ~= 0 then
					local var_140_38 = manager.audio:GetVoiceLength("story_v_out_413141", "413141034", "story_v_out_413141.awb") / 1000

					if var_140_38 + var_140_30 > arg_137_1.duration_ then
						arg_137_1.duration_ = var_140_38 + var_140_30
					end

					if var_140_33.prefab_name ~= "" and arg_137_1.actors_[var_140_33.prefab_name] ~= nil then
						local var_140_39 = LuaForUtil.PlayVoiceWithCriLipsync(arg_137_1.actors_[var_140_33.prefab_name].transform, "story_v_out_413141", "413141034", "story_v_out_413141.awb")

						arg_137_1:RecordAudio("413141034", var_140_39)
						arg_137_1:RecordAudio("413141034", var_140_39)
					else
						arg_137_1:AudioAction("play", "voice", "story_v_out_413141", "413141034", "story_v_out_413141.awb")
					end

					arg_137_1:RecordHistoryTalkVoice("story_v_out_413141", "413141034", "story_v_out_413141.awb")
				end

				arg_137_1:RecordContent(arg_137_1.text_.text)
			end

			local var_140_40 = math.max(var_140_31, arg_137_1.talkMaxDuration)

			if var_140_30 <= arg_137_1.time_ and arg_137_1.time_ < var_140_30 + var_140_40 then
				arg_137_1.typewritter.percent = (arg_137_1.time_ - var_140_30) / var_140_40

				arg_137_1.typewritter:SetDirty()
			end

			if arg_137_1.time_ >= var_140_30 + var_140_40 and arg_137_1.time_ < var_140_30 + var_140_40 + arg_140_0 then
				arg_137_1.typewritter.percent = 1

				arg_137_1.typewritter:SetDirty()
				arg_137_1:ShowNextGo(true)
			end
		end

		arg_137_1.nodeConfigList_ = {
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

		arg_137_1:InitPlayNodeList()
	end,
	Play413141035 = function(arg_141_0, arg_141_1)
		arg_141_1.time_ = 0
		arg_141_1.frameCnt_ = 0
		arg_141_1.state_ = "playing"
		arg_141_1.curTalkId_ = 413141035
		arg_141_1.duration_ = 8.4

		local var_141_0 = {
			zh = 5.2,
			ja = 8.4
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
				arg_141_0:Play413141036(arg_141_1)
			end
		end

		function arg_141_1.onSingleLineUpdate_(arg_144_0)
			local var_144_0 = arg_141_1.actors_["10092_1"]
			local var_144_1 = 0

			if var_144_1 < arg_141_1.time_ and arg_141_1.time_ <= var_144_1 + arg_144_0 and not isNil(var_144_0) and arg_141_1.var_.actorSpriteComps10092_1 == nil then
				arg_141_1.var_.actorSpriteComps10092_1 = var_144_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_144_2 = 2

			if var_144_1 <= arg_141_1.time_ and arg_141_1.time_ < var_144_1 + var_144_2 and not isNil(var_144_0) then
				local var_144_3 = (arg_141_1.time_ - var_144_1) / var_144_2

				if arg_141_1.var_.actorSpriteComps10092_1 then
					for iter_144_0, iter_144_1 in pairs(arg_141_1.var_.actorSpriteComps10092_1:ToTable()) do
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

			if arg_141_1.time_ >= var_144_1 + var_144_2 and arg_141_1.time_ < var_144_1 + var_144_2 + arg_144_0 and not isNil(var_144_0) and arg_141_1.var_.actorSpriteComps10092_1 then
				for iter_144_2, iter_144_3 in pairs(arg_141_1.var_.actorSpriteComps10092_1:ToTable()) do
					if iter_144_3 then
						if arg_141_1.isInRecall_ then
							iter_144_3.color = arg_141_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_144_3.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_141_1.var_.actorSpriteComps10092_1 = nil
			end

			local var_144_8 = arg_141_1.actors_["10093"]
			local var_144_9 = 0

			if var_144_9 < arg_141_1.time_ and arg_141_1.time_ <= var_144_9 + arg_144_0 and not isNil(var_144_8) and arg_141_1.var_.actorSpriteComps10093 == nil then
				arg_141_1.var_.actorSpriteComps10093 = var_144_8:GetComponentsInChildren(typeof(Image), true)
			end

			local var_144_10 = 2

			if var_144_9 <= arg_141_1.time_ and arg_141_1.time_ < var_144_9 + var_144_10 and not isNil(var_144_8) then
				local var_144_11 = (arg_141_1.time_ - var_144_9) / var_144_10

				if arg_141_1.var_.actorSpriteComps10093 then
					for iter_144_4, iter_144_5 in pairs(arg_141_1.var_.actorSpriteComps10093:ToTable()) do
						if iter_144_5 then
							if arg_141_1.isInRecall_ then
								local var_144_12 = Mathf.Lerp(iter_144_5.color.r, arg_141_1.hightColor2.r, var_144_11)
								local var_144_13 = Mathf.Lerp(iter_144_5.color.g, arg_141_1.hightColor2.g, var_144_11)
								local var_144_14 = Mathf.Lerp(iter_144_5.color.b, arg_141_1.hightColor2.b, var_144_11)

								iter_144_5.color = Color.New(var_144_12, var_144_13, var_144_14)
							else
								local var_144_15 = Mathf.Lerp(iter_144_5.color.r, 0.5, var_144_11)

								iter_144_5.color = Color.New(var_144_15, var_144_15, var_144_15)
							end
						end
					end
				end
			end

			if arg_141_1.time_ >= var_144_9 + var_144_10 and arg_141_1.time_ < var_144_9 + var_144_10 + arg_144_0 and not isNil(var_144_8) and arg_141_1.var_.actorSpriteComps10093 then
				for iter_144_6, iter_144_7 in pairs(arg_141_1.var_.actorSpriteComps10093:ToTable()) do
					if iter_144_7 then
						if arg_141_1.isInRecall_ then
							iter_144_7.color = arg_141_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_144_7.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_141_1.var_.actorSpriteComps10093 = nil
			end

			local var_144_16 = 0
			local var_144_17 = 0.625

			if var_144_16 < arg_141_1.time_ and arg_141_1.time_ <= var_144_16 + arg_144_0 then
				arg_141_1.talkMaxDuration = 0
				arg_141_1.dialogCg_.alpha = 1

				arg_141_1.dialog_:SetActive(true)
				SetActive(arg_141_1.leftNameGo_, true)

				local var_144_18 = arg_141_1:FormatText(StoryNameCfg[996].name)

				arg_141_1.leftNameTxt_.text = var_144_18

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_141_1.leftNameTxt_.transform)

				arg_141_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_141_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_141_1:RecordName(arg_141_1.leftNameTxt_.text)
				SetActive(arg_141_1.iconTrs_.gameObject, false)
				arg_141_1.callingController_:SetSelectedState("normal")

				local var_144_19 = arg_141_1:GetWordFromCfg(413141035)
				local var_144_20 = arg_141_1:FormatText(var_144_19.content)

				arg_141_1.text_.text = var_144_20

				LuaForUtil.ClearLinePrefixSymbol(arg_141_1.text_)

				local var_144_21 = 25
				local var_144_22 = utf8.len(var_144_20)
				local var_144_23 = var_144_21 <= 0 and var_144_17 or var_144_17 * (var_144_22 / var_144_21)

				if var_144_23 > 0 and var_144_17 < var_144_23 then
					arg_141_1.talkMaxDuration = var_144_23

					if var_144_23 + var_144_16 > arg_141_1.duration_ then
						arg_141_1.duration_ = var_144_23 + var_144_16
					end
				end

				arg_141_1.text_.text = var_144_20
				arg_141_1.typewritter.percent = 0

				arg_141_1.typewritter:SetDirty()
				arg_141_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_413141", "413141035", "story_v_out_413141.awb") ~= 0 then
					local var_144_24 = manager.audio:GetVoiceLength("story_v_out_413141", "413141035", "story_v_out_413141.awb") / 1000

					if var_144_24 + var_144_16 > arg_141_1.duration_ then
						arg_141_1.duration_ = var_144_24 + var_144_16
					end

					if var_144_19.prefab_name ~= "" and arg_141_1.actors_[var_144_19.prefab_name] ~= nil then
						local var_144_25 = LuaForUtil.PlayVoiceWithCriLipsync(arg_141_1.actors_[var_144_19.prefab_name].transform, "story_v_out_413141", "413141035", "story_v_out_413141.awb")

						arg_141_1:RecordAudio("413141035", var_144_25)
						arg_141_1:RecordAudio("413141035", var_144_25)
					else
						arg_141_1:AudioAction("play", "voice", "story_v_out_413141", "413141035", "story_v_out_413141.awb")
					end

					arg_141_1:RecordHistoryTalkVoice("story_v_out_413141", "413141035", "story_v_out_413141.awb")
				end

				arg_141_1:RecordContent(arg_141_1.text_.text)
			end

			local var_144_26 = math.max(var_144_17, arg_141_1.talkMaxDuration)

			if var_144_16 <= arg_141_1.time_ and arg_141_1.time_ < var_144_16 + var_144_26 then
				arg_141_1.typewritter.percent = (arg_141_1.time_ - var_144_16) / var_144_26

				arg_141_1.typewritter:SetDirty()
			end

			if arg_141_1.time_ >= var_144_16 + var_144_26 and arg_141_1.time_ < var_144_16 + var_144_26 + arg_144_0 then
				arg_141_1.typewritter.percent = 1

				arg_141_1.typewritter:SetDirty()
				arg_141_1:ShowNextGo(true)
			end
		end

		arg_141_1.nodeConfigList_ = {}

		arg_141_1:InitPlayNodeList()
	end,
	Play413141036 = function(arg_145_0, arg_145_1)
		arg_145_1.time_ = 0
		arg_145_1.frameCnt_ = 0
		arg_145_1.state_ = "playing"
		arg_145_1.curTalkId_ = 413141036
		arg_145_1.duration_ = 6.2

		local var_145_0 = {
			zh = 1.999999999999,
			ja = 6.2
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
				arg_145_0:Play413141037(arg_145_1)
			end
		end

		function arg_145_1.onSingleLineUpdate_(arg_148_0)
			local var_148_0 = arg_145_1.actors_["10093"].transform
			local var_148_1 = 0

			if var_148_1 < arg_145_1.time_ and arg_145_1.time_ <= var_148_1 + arg_148_0 then
				arg_145_1.var_.moveOldPos10093 = var_148_0.localPosition
				var_148_0.localScale = Vector3.New(1, 1, 1)

				arg_145_1:CheckSpriteTmpPos("10093", 4)

				local var_148_2 = var_148_0.childCount

				for iter_148_0 = 0, var_148_2 - 1 do
					local var_148_3 = var_148_0:GetChild(iter_148_0)

					if var_148_3.name == "split_4" or not string.find(var_148_3.name, "split") then
						var_148_3.gameObject:SetActive(true)
					else
						var_148_3.gameObject:SetActive(false)
					end
				end
			end

			local var_148_4 = 0.001

			if var_148_1 <= arg_145_1.time_ and arg_145_1.time_ < var_148_1 + var_148_4 then
				local var_148_5 = (arg_145_1.time_ - var_148_1) / var_148_4
				local var_148_6 = Vector3.New(390, -345, -245)

				var_148_0.localPosition = Vector3.Lerp(arg_145_1.var_.moveOldPos10093, var_148_6, var_148_5)
			end

			if arg_145_1.time_ >= var_148_1 + var_148_4 and arg_145_1.time_ < var_148_1 + var_148_4 + arg_148_0 then
				var_148_0.localPosition = Vector3.New(390, -345, -245)
			end

			local var_148_7 = arg_145_1.actors_["10092_1"]
			local var_148_8 = 0

			if var_148_8 < arg_145_1.time_ and arg_145_1.time_ <= var_148_8 + arg_148_0 and not isNil(var_148_7) and arg_145_1.var_.actorSpriteComps10092_1 == nil then
				arg_145_1.var_.actorSpriteComps10092_1 = var_148_7:GetComponentsInChildren(typeof(Image), true)
			end

			local var_148_9 = 2

			if var_148_8 <= arg_145_1.time_ and arg_145_1.time_ < var_148_8 + var_148_9 and not isNil(var_148_7) then
				local var_148_10 = (arg_145_1.time_ - var_148_8) / var_148_9

				if arg_145_1.var_.actorSpriteComps10092_1 then
					for iter_148_1, iter_148_2 in pairs(arg_145_1.var_.actorSpriteComps10092_1:ToTable()) do
						if iter_148_2 then
							if arg_145_1.isInRecall_ then
								local var_148_11 = Mathf.Lerp(iter_148_2.color.r, arg_145_1.hightColor2.r, var_148_10)
								local var_148_12 = Mathf.Lerp(iter_148_2.color.g, arg_145_1.hightColor2.g, var_148_10)
								local var_148_13 = Mathf.Lerp(iter_148_2.color.b, arg_145_1.hightColor2.b, var_148_10)

								iter_148_2.color = Color.New(var_148_11, var_148_12, var_148_13)
							else
								local var_148_14 = Mathf.Lerp(iter_148_2.color.r, 0.5, var_148_10)

								iter_148_2.color = Color.New(var_148_14, var_148_14, var_148_14)
							end
						end
					end
				end
			end

			if arg_145_1.time_ >= var_148_8 + var_148_9 and arg_145_1.time_ < var_148_8 + var_148_9 + arg_148_0 and not isNil(var_148_7) and arg_145_1.var_.actorSpriteComps10092_1 then
				for iter_148_3, iter_148_4 in pairs(arg_145_1.var_.actorSpriteComps10092_1:ToTable()) do
					if iter_148_4 then
						if arg_145_1.isInRecall_ then
							iter_148_4.color = arg_145_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_148_4.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_145_1.var_.actorSpriteComps10092_1 = nil
			end

			local var_148_15 = arg_145_1.actors_["10093"]
			local var_148_16 = 0

			if var_148_16 < arg_145_1.time_ and arg_145_1.time_ <= var_148_16 + arg_148_0 and not isNil(var_148_15) and arg_145_1.var_.actorSpriteComps10093 == nil then
				arg_145_1.var_.actorSpriteComps10093 = var_148_15:GetComponentsInChildren(typeof(Image), true)
			end

			local var_148_17 = 2

			if var_148_16 <= arg_145_1.time_ and arg_145_1.time_ < var_148_16 + var_148_17 and not isNil(var_148_15) then
				local var_148_18 = (arg_145_1.time_ - var_148_16) / var_148_17

				if arg_145_1.var_.actorSpriteComps10093 then
					for iter_148_5, iter_148_6 in pairs(arg_145_1.var_.actorSpriteComps10093:ToTable()) do
						if iter_148_6 then
							if arg_145_1.isInRecall_ then
								local var_148_19 = Mathf.Lerp(iter_148_6.color.r, arg_145_1.hightColor1.r, var_148_18)
								local var_148_20 = Mathf.Lerp(iter_148_6.color.g, arg_145_1.hightColor1.g, var_148_18)
								local var_148_21 = Mathf.Lerp(iter_148_6.color.b, arg_145_1.hightColor1.b, var_148_18)

								iter_148_6.color = Color.New(var_148_19, var_148_20, var_148_21)
							else
								local var_148_22 = Mathf.Lerp(iter_148_6.color.r, 1, var_148_18)

								iter_148_6.color = Color.New(var_148_22, var_148_22, var_148_22)
							end
						end
					end
				end
			end

			if arg_145_1.time_ >= var_148_16 + var_148_17 and arg_145_1.time_ < var_148_16 + var_148_17 + arg_148_0 and not isNil(var_148_15) and arg_145_1.var_.actorSpriteComps10093 then
				for iter_148_7, iter_148_8 in pairs(arg_145_1.var_.actorSpriteComps10093:ToTable()) do
					if iter_148_8 then
						if arg_145_1.isInRecall_ then
							iter_148_8.color = arg_145_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_148_8.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_145_1.var_.actorSpriteComps10093 = nil
			end

			local var_148_23 = 0
			local var_148_24 = 0.2

			if var_148_23 < arg_145_1.time_ and arg_145_1.time_ <= var_148_23 + arg_148_0 then
				arg_145_1.talkMaxDuration = 0
				arg_145_1.dialogCg_.alpha = 1

				arg_145_1.dialog_:SetActive(true)
				SetActive(arg_145_1.leftNameGo_, true)

				local var_148_25 = arg_145_1:FormatText(StoryNameCfg[28].name)

				arg_145_1.leftNameTxt_.text = var_148_25

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_145_1.leftNameTxt_.transform)

				arg_145_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_145_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_145_1:RecordName(arg_145_1.leftNameTxt_.text)
				SetActive(arg_145_1.iconTrs_.gameObject, false)
				arg_145_1.callingController_:SetSelectedState("normal")

				local var_148_26 = arg_145_1:GetWordFromCfg(413141036)
				local var_148_27 = arg_145_1:FormatText(var_148_26.content)

				arg_145_1.text_.text = var_148_27

				LuaForUtil.ClearLinePrefixSymbol(arg_145_1.text_)

				local var_148_28 = 8
				local var_148_29 = utf8.len(var_148_27)
				local var_148_30 = var_148_28 <= 0 and var_148_24 or var_148_24 * (var_148_29 / var_148_28)

				if var_148_30 > 0 and var_148_24 < var_148_30 then
					arg_145_1.talkMaxDuration = var_148_30

					if var_148_30 + var_148_23 > arg_145_1.duration_ then
						arg_145_1.duration_ = var_148_30 + var_148_23
					end
				end

				arg_145_1.text_.text = var_148_27
				arg_145_1.typewritter.percent = 0

				arg_145_1.typewritter:SetDirty()
				arg_145_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_413141", "413141036", "story_v_out_413141.awb") ~= 0 then
					local var_148_31 = manager.audio:GetVoiceLength("story_v_out_413141", "413141036", "story_v_out_413141.awb") / 1000

					if var_148_31 + var_148_23 > arg_145_1.duration_ then
						arg_145_1.duration_ = var_148_31 + var_148_23
					end

					if var_148_26.prefab_name ~= "" and arg_145_1.actors_[var_148_26.prefab_name] ~= nil then
						local var_148_32 = LuaForUtil.PlayVoiceWithCriLipsync(arg_145_1.actors_[var_148_26.prefab_name].transform, "story_v_out_413141", "413141036", "story_v_out_413141.awb")

						arg_145_1:RecordAudio("413141036", var_148_32)
						arg_145_1:RecordAudio("413141036", var_148_32)
					else
						arg_145_1:AudioAction("play", "voice", "story_v_out_413141", "413141036", "story_v_out_413141.awb")
					end

					arg_145_1:RecordHistoryTalkVoice("story_v_out_413141", "413141036", "story_v_out_413141.awb")
				end

				arg_145_1:RecordContent(arg_145_1.text_.text)
			end

			local var_148_33 = math.max(var_148_24, arg_145_1.talkMaxDuration)

			if var_148_23 <= arg_145_1.time_ and arg_145_1.time_ < var_148_23 + var_148_33 then
				arg_145_1.typewritter.percent = (arg_145_1.time_ - var_148_23) / var_148_33

				arg_145_1.typewritter:SetDirty()
			end

			if arg_145_1.time_ >= var_148_23 + var_148_33 and arg_145_1.time_ < var_148_23 + var_148_33 + arg_148_0 then
				arg_145_1.typewritter.percent = 1

				arg_145_1.typewritter:SetDirty()
				arg_145_1:ShowNextGo(true)
			end
		end

		arg_145_1.nodeConfigList_ = {
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

		arg_145_1:InitPlayNodeList()
	end,
	Play413141037 = function(arg_149_0, arg_149_1)
		arg_149_1.time_ = 0
		arg_149_1.frameCnt_ = 0
		arg_149_1.state_ = "playing"
		arg_149_1.curTalkId_ = 413141037
		arg_149_1.duration_ = 5.27

		local var_149_0 = {
			zh = 4.1,
			ja = 5.266
		}
		local var_149_1 = manager.audio:GetLocalizationFlag()

		if var_149_0[var_149_1] ~= nil then
			arg_149_1.duration_ = var_149_0[var_149_1]
		end

		SetActive(arg_149_1.tipsGo_, false)

		function arg_149_1.onSingleLineFinish_()
			arg_149_1.onSingleLineUpdate_ = nil
			arg_149_1.onSingleLineFinish_ = nil
			arg_149_1.state_ = "waiting"
		end

		function arg_149_1.playNext_(arg_151_0)
			if arg_151_0 == 1 then
				arg_149_0:Play413141038(arg_149_1)
			end
		end

		function arg_149_1.onSingleLineUpdate_(arg_152_0)
			local var_152_0 = arg_149_1.actors_["10092_1"].transform
			local var_152_1 = 0

			if var_152_1 < arg_149_1.time_ and arg_149_1.time_ <= var_152_1 + arg_152_0 then
				arg_149_1.var_.moveOldPos10092_1 = var_152_0.localPosition
				var_152_0.localScale = Vector3.New(1, 1, 1)

				arg_149_1:CheckSpriteTmpPos("10092_1", 2)

				local var_152_2 = var_152_0.childCount

				for iter_152_0 = 0, var_152_2 - 1 do
					local var_152_3 = var_152_0:GetChild(iter_152_0)

					if var_152_3.name == "split_1_1" or not string.find(var_152_3.name, "split") then
						var_152_3.gameObject:SetActive(true)
					else
						var_152_3.gameObject:SetActive(false)
					end
				end
			end

			local var_152_4 = 0.001

			if var_152_1 <= arg_149_1.time_ and arg_149_1.time_ < var_152_1 + var_152_4 then
				local var_152_5 = (arg_149_1.time_ - var_152_1) / var_152_4
				local var_152_6 = Vector3.New(-389.49, -300, -295)

				var_152_0.localPosition = Vector3.Lerp(arg_149_1.var_.moveOldPos10092_1, var_152_6, var_152_5)
			end

			if arg_149_1.time_ >= var_152_1 + var_152_4 and arg_149_1.time_ < var_152_1 + var_152_4 + arg_152_0 then
				var_152_0.localPosition = Vector3.New(-389.49, -300, -295)
			end

			local var_152_7 = arg_149_1.actors_["10092_1"]
			local var_152_8 = 0

			if var_152_8 < arg_149_1.time_ and arg_149_1.time_ <= var_152_8 + arg_152_0 and not isNil(var_152_7) and arg_149_1.var_.actorSpriteComps10092_1 == nil then
				arg_149_1.var_.actorSpriteComps10092_1 = var_152_7:GetComponentsInChildren(typeof(Image), true)
			end

			local var_152_9 = 2

			if var_152_8 <= arg_149_1.time_ and arg_149_1.time_ < var_152_8 + var_152_9 and not isNil(var_152_7) then
				local var_152_10 = (arg_149_1.time_ - var_152_8) / var_152_9

				if arg_149_1.var_.actorSpriteComps10092_1 then
					for iter_152_1, iter_152_2 in pairs(arg_149_1.var_.actorSpriteComps10092_1:ToTable()) do
						if iter_152_2 then
							if arg_149_1.isInRecall_ then
								local var_152_11 = Mathf.Lerp(iter_152_2.color.r, arg_149_1.hightColor1.r, var_152_10)
								local var_152_12 = Mathf.Lerp(iter_152_2.color.g, arg_149_1.hightColor1.g, var_152_10)
								local var_152_13 = Mathf.Lerp(iter_152_2.color.b, arg_149_1.hightColor1.b, var_152_10)

								iter_152_2.color = Color.New(var_152_11, var_152_12, var_152_13)
							else
								local var_152_14 = Mathf.Lerp(iter_152_2.color.r, 1, var_152_10)

								iter_152_2.color = Color.New(var_152_14, var_152_14, var_152_14)
							end
						end
					end
				end
			end

			if arg_149_1.time_ >= var_152_8 + var_152_9 and arg_149_1.time_ < var_152_8 + var_152_9 + arg_152_0 and not isNil(var_152_7) and arg_149_1.var_.actorSpriteComps10092_1 then
				for iter_152_3, iter_152_4 in pairs(arg_149_1.var_.actorSpriteComps10092_1:ToTable()) do
					if iter_152_4 then
						if arg_149_1.isInRecall_ then
							iter_152_4.color = arg_149_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_152_4.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_149_1.var_.actorSpriteComps10092_1 = nil
			end

			local var_152_15 = arg_149_1.actors_["10093"]
			local var_152_16 = 0

			if var_152_16 < arg_149_1.time_ and arg_149_1.time_ <= var_152_16 + arg_152_0 and not isNil(var_152_15) and arg_149_1.var_.actorSpriteComps10093 == nil then
				arg_149_1.var_.actorSpriteComps10093 = var_152_15:GetComponentsInChildren(typeof(Image), true)
			end

			local var_152_17 = 2

			if var_152_16 <= arg_149_1.time_ and arg_149_1.time_ < var_152_16 + var_152_17 and not isNil(var_152_15) then
				local var_152_18 = (arg_149_1.time_ - var_152_16) / var_152_17

				if arg_149_1.var_.actorSpriteComps10093 then
					for iter_152_5, iter_152_6 in pairs(arg_149_1.var_.actorSpriteComps10093:ToTable()) do
						if iter_152_6 then
							if arg_149_1.isInRecall_ then
								local var_152_19 = Mathf.Lerp(iter_152_6.color.r, arg_149_1.hightColor2.r, var_152_18)
								local var_152_20 = Mathf.Lerp(iter_152_6.color.g, arg_149_1.hightColor2.g, var_152_18)
								local var_152_21 = Mathf.Lerp(iter_152_6.color.b, arg_149_1.hightColor2.b, var_152_18)

								iter_152_6.color = Color.New(var_152_19, var_152_20, var_152_21)
							else
								local var_152_22 = Mathf.Lerp(iter_152_6.color.r, 0.5, var_152_18)

								iter_152_6.color = Color.New(var_152_22, var_152_22, var_152_22)
							end
						end
					end
				end
			end

			if arg_149_1.time_ >= var_152_16 + var_152_17 and arg_149_1.time_ < var_152_16 + var_152_17 + arg_152_0 and not isNil(var_152_15) and arg_149_1.var_.actorSpriteComps10093 then
				for iter_152_7, iter_152_8 in pairs(arg_149_1.var_.actorSpriteComps10093:ToTable()) do
					if iter_152_8 then
						if arg_149_1.isInRecall_ then
							iter_152_8.color = arg_149_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_152_8.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_149_1.var_.actorSpriteComps10093 = nil
			end

			local var_152_23 = 0
			local var_152_24 = 0.475

			if var_152_23 < arg_149_1.time_ and arg_149_1.time_ <= var_152_23 + arg_152_0 then
				arg_149_1.talkMaxDuration = 0
				arg_149_1.dialogCg_.alpha = 1

				arg_149_1.dialog_:SetActive(true)
				SetActive(arg_149_1.leftNameGo_, true)

				local var_152_25 = arg_149_1:FormatText(StoryNameCfg[996].name)

				arg_149_1.leftNameTxt_.text = var_152_25

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_149_1.leftNameTxt_.transform)

				arg_149_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_149_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_149_1:RecordName(arg_149_1.leftNameTxt_.text)
				SetActive(arg_149_1.iconTrs_.gameObject, false)
				arg_149_1.callingController_:SetSelectedState("normal")

				local var_152_26 = arg_149_1:GetWordFromCfg(413141037)
				local var_152_27 = arg_149_1:FormatText(var_152_26.content)

				arg_149_1.text_.text = var_152_27

				LuaForUtil.ClearLinePrefixSymbol(arg_149_1.text_)

				local var_152_28 = 19
				local var_152_29 = utf8.len(var_152_27)
				local var_152_30 = var_152_28 <= 0 and var_152_24 or var_152_24 * (var_152_29 / var_152_28)

				if var_152_30 > 0 and var_152_24 < var_152_30 then
					arg_149_1.talkMaxDuration = var_152_30

					if var_152_30 + var_152_23 > arg_149_1.duration_ then
						arg_149_1.duration_ = var_152_30 + var_152_23
					end
				end

				arg_149_1.text_.text = var_152_27
				arg_149_1.typewritter.percent = 0

				arg_149_1.typewritter:SetDirty()
				arg_149_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_413141", "413141037", "story_v_out_413141.awb") ~= 0 then
					local var_152_31 = manager.audio:GetVoiceLength("story_v_out_413141", "413141037", "story_v_out_413141.awb") / 1000

					if var_152_31 + var_152_23 > arg_149_1.duration_ then
						arg_149_1.duration_ = var_152_31 + var_152_23
					end

					if var_152_26.prefab_name ~= "" and arg_149_1.actors_[var_152_26.prefab_name] ~= nil then
						local var_152_32 = LuaForUtil.PlayVoiceWithCriLipsync(arg_149_1.actors_[var_152_26.prefab_name].transform, "story_v_out_413141", "413141037", "story_v_out_413141.awb")

						arg_149_1:RecordAudio("413141037", var_152_32)
						arg_149_1:RecordAudio("413141037", var_152_32)
					else
						arg_149_1:AudioAction("play", "voice", "story_v_out_413141", "413141037", "story_v_out_413141.awb")
					end

					arg_149_1:RecordHistoryTalkVoice("story_v_out_413141", "413141037", "story_v_out_413141.awb")
				end

				arg_149_1:RecordContent(arg_149_1.text_.text)
			end

			local var_152_33 = math.max(var_152_24, arg_149_1.talkMaxDuration)

			if var_152_23 <= arg_149_1.time_ and arg_149_1.time_ < var_152_23 + var_152_33 then
				arg_149_1.typewritter.percent = (arg_149_1.time_ - var_152_23) / var_152_33

				arg_149_1.typewritter:SetDirty()
			end

			if arg_149_1.time_ >= var_152_23 + var_152_33 and arg_149_1.time_ < var_152_23 + var_152_33 + arg_152_0 then
				arg_149_1.typewritter.percent = 1

				arg_149_1.typewritter:SetDirty()
				arg_149_1:ShowNextGo(true)
			end
		end

		arg_149_1.nodeConfigList_ = {
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

		arg_149_1:InitPlayNodeList()
	end,
	Play413141038 = function(arg_153_0, arg_153_1)
		arg_153_1.time_ = 0
		arg_153_1.frameCnt_ = 0
		arg_153_1.state_ = "playing"
		arg_153_1.curTalkId_ = 413141038
		arg_153_1.duration_ = 10.03

		local var_153_0 = {
			zh = 7.6,
			ja = 10.033
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
				arg_153_0:Play413141039(arg_153_1)
			end
		end

		function arg_153_1.onSingleLineUpdate_(arg_156_0)
			local var_156_0 = 0
			local var_156_1 = 1

			if var_156_0 < arg_153_1.time_ and arg_153_1.time_ <= var_156_0 + arg_156_0 then
				arg_153_1.talkMaxDuration = 0
				arg_153_1.dialogCg_.alpha = 1

				arg_153_1.dialog_:SetActive(true)
				SetActive(arg_153_1.leftNameGo_, true)

				local var_156_2 = arg_153_1:FormatText(StoryNameCfg[996].name)

				arg_153_1.leftNameTxt_.text = var_156_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_153_1.leftNameTxt_.transform)

				arg_153_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_153_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_153_1:RecordName(arg_153_1.leftNameTxt_.text)
				SetActive(arg_153_1.iconTrs_.gameObject, false)
				arg_153_1.callingController_:SetSelectedState("normal")

				local var_156_3 = arg_153_1:GetWordFromCfg(413141038)
				local var_156_4 = arg_153_1:FormatText(var_156_3.content)

				arg_153_1.text_.text = var_156_4

				LuaForUtil.ClearLinePrefixSymbol(arg_153_1.text_)

				local var_156_5 = 40
				local var_156_6 = utf8.len(var_156_4)
				local var_156_7 = var_156_5 <= 0 and var_156_1 or var_156_1 * (var_156_6 / var_156_5)

				if var_156_7 > 0 and var_156_1 < var_156_7 then
					arg_153_1.talkMaxDuration = var_156_7

					if var_156_7 + var_156_0 > arg_153_1.duration_ then
						arg_153_1.duration_ = var_156_7 + var_156_0
					end
				end

				arg_153_1.text_.text = var_156_4
				arg_153_1.typewritter.percent = 0

				arg_153_1.typewritter:SetDirty()
				arg_153_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_413141", "413141038", "story_v_out_413141.awb") ~= 0 then
					local var_156_8 = manager.audio:GetVoiceLength("story_v_out_413141", "413141038", "story_v_out_413141.awb") / 1000

					if var_156_8 + var_156_0 > arg_153_1.duration_ then
						arg_153_1.duration_ = var_156_8 + var_156_0
					end

					if var_156_3.prefab_name ~= "" and arg_153_1.actors_[var_156_3.prefab_name] ~= nil then
						local var_156_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_153_1.actors_[var_156_3.prefab_name].transform, "story_v_out_413141", "413141038", "story_v_out_413141.awb")

						arg_153_1:RecordAudio("413141038", var_156_9)
						arg_153_1:RecordAudio("413141038", var_156_9)
					else
						arg_153_1:AudioAction("play", "voice", "story_v_out_413141", "413141038", "story_v_out_413141.awb")
					end

					arg_153_1:RecordHistoryTalkVoice("story_v_out_413141", "413141038", "story_v_out_413141.awb")
				end

				arg_153_1:RecordContent(arg_153_1.text_.text)
			end

			local var_156_10 = math.max(var_156_1, arg_153_1.talkMaxDuration)

			if var_156_0 <= arg_153_1.time_ and arg_153_1.time_ < var_156_0 + var_156_10 then
				arg_153_1.typewritter.percent = (arg_153_1.time_ - var_156_0) / var_156_10

				arg_153_1.typewritter:SetDirty()
			end

			if arg_153_1.time_ >= var_156_0 + var_156_10 and arg_153_1.time_ < var_156_0 + var_156_10 + arg_156_0 then
				arg_153_1.typewritter.percent = 1

				arg_153_1.typewritter:SetDirty()
				arg_153_1:ShowNextGo(true)
			end
		end

		arg_153_1.nodeConfigList_ = {}

		arg_153_1:InitPlayNodeList()
	end,
	Play413141039 = function(arg_157_0, arg_157_1)
		arg_157_1.time_ = 0
		arg_157_1.frameCnt_ = 0
		arg_157_1.state_ = "playing"
		arg_157_1.curTalkId_ = 413141039
		arg_157_1.duration_ = 5.87

		local var_157_0 = {
			zh = 4.966,
			ja = 5.866
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
				arg_157_0:Play413141040(arg_157_1)
			end
		end

		function arg_157_1.onSingleLineUpdate_(arg_160_0)
			local var_160_0 = 0
			local var_160_1 = 0.675

			if var_160_0 < arg_157_1.time_ and arg_157_1.time_ <= var_160_0 + arg_160_0 then
				arg_157_1.talkMaxDuration = 0
				arg_157_1.dialogCg_.alpha = 1

				arg_157_1.dialog_:SetActive(true)
				SetActive(arg_157_1.leftNameGo_, true)

				local var_160_2 = arg_157_1:FormatText(StoryNameCfg[996].name)

				arg_157_1.leftNameTxt_.text = var_160_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_157_1.leftNameTxt_.transform)

				arg_157_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_157_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_157_1:RecordName(arg_157_1.leftNameTxt_.text)
				SetActive(arg_157_1.iconTrs_.gameObject, false)
				arg_157_1.callingController_:SetSelectedState("normal")

				local var_160_3 = arg_157_1:GetWordFromCfg(413141039)
				local var_160_4 = arg_157_1:FormatText(var_160_3.content)

				arg_157_1.text_.text = var_160_4

				LuaForUtil.ClearLinePrefixSymbol(arg_157_1.text_)

				local var_160_5 = 27
				local var_160_6 = utf8.len(var_160_4)
				local var_160_7 = var_160_5 <= 0 and var_160_1 or var_160_1 * (var_160_6 / var_160_5)

				if var_160_7 > 0 and var_160_1 < var_160_7 then
					arg_157_1.talkMaxDuration = var_160_7

					if var_160_7 + var_160_0 > arg_157_1.duration_ then
						arg_157_1.duration_ = var_160_7 + var_160_0
					end
				end

				arg_157_1.text_.text = var_160_4
				arg_157_1.typewritter.percent = 0

				arg_157_1.typewritter:SetDirty()
				arg_157_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_413141", "413141039", "story_v_out_413141.awb") ~= 0 then
					local var_160_8 = manager.audio:GetVoiceLength("story_v_out_413141", "413141039", "story_v_out_413141.awb") / 1000

					if var_160_8 + var_160_0 > arg_157_1.duration_ then
						arg_157_1.duration_ = var_160_8 + var_160_0
					end

					if var_160_3.prefab_name ~= "" and arg_157_1.actors_[var_160_3.prefab_name] ~= nil then
						local var_160_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_157_1.actors_[var_160_3.prefab_name].transform, "story_v_out_413141", "413141039", "story_v_out_413141.awb")

						arg_157_1:RecordAudio("413141039", var_160_9)
						arg_157_1:RecordAudio("413141039", var_160_9)
					else
						arg_157_1:AudioAction("play", "voice", "story_v_out_413141", "413141039", "story_v_out_413141.awb")
					end

					arg_157_1:RecordHistoryTalkVoice("story_v_out_413141", "413141039", "story_v_out_413141.awb")
				end

				arg_157_1:RecordContent(arg_157_1.text_.text)
			end

			local var_160_10 = math.max(var_160_1, arg_157_1.talkMaxDuration)

			if var_160_0 <= arg_157_1.time_ and arg_157_1.time_ < var_160_0 + var_160_10 then
				arg_157_1.typewritter.percent = (arg_157_1.time_ - var_160_0) / var_160_10

				arg_157_1.typewritter:SetDirty()
			end

			if arg_157_1.time_ >= var_160_0 + var_160_10 and arg_157_1.time_ < var_160_0 + var_160_10 + arg_160_0 then
				arg_157_1.typewritter.percent = 1

				arg_157_1.typewritter:SetDirty()
				arg_157_1:ShowNextGo(true)
			end
		end

		arg_157_1.nodeConfigList_ = {}

		arg_157_1:InitPlayNodeList()
	end,
	Play413141040 = function(arg_161_0, arg_161_1)
		arg_161_1.time_ = 0
		arg_161_1.frameCnt_ = 0
		arg_161_1.state_ = "playing"
		arg_161_1.curTalkId_ = 413141040
		arg_161_1.duration_ = 5

		SetActive(arg_161_1.tipsGo_, false)

		function arg_161_1.onSingleLineFinish_()
			arg_161_1.onSingleLineUpdate_ = nil
			arg_161_1.onSingleLineFinish_ = nil
			arg_161_1.state_ = "waiting"
		end

		function arg_161_1.playNext_(arg_163_0)
			if arg_163_0 == 1 then
				arg_161_0:Play413141041(arg_161_1)
			end
		end

		function arg_161_1.onSingleLineUpdate_(arg_164_0)
			local var_164_0 = arg_161_1.actors_["10092_1"].transform
			local var_164_1 = 0

			if var_164_1 < arg_161_1.time_ and arg_161_1.time_ <= var_164_1 + arg_164_0 then
				arg_161_1.var_.moveOldPos10092_1 = var_164_0.localPosition
				var_164_0.localScale = Vector3.New(1, 1, 1)

				arg_161_1:CheckSpriteTmpPos("10092_1", 6)

				local var_164_2 = var_164_0.childCount

				for iter_164_0 = 0, var_164_2 - 1 do
					local var_164_3 = var_164_0:GetChild(iter_164_0)

					if var_164_3.name == "" or not string.find(var_164_3.name, "split") then
						var_164_3.gameObject:SetActive(true)
					else
						var_164_3.gameObject:SetActive(false)
					end
				end
			end

			local var_164_4 = 0.001

			if var_164_1 <= arg_161_1.time_ and arg_161_1.time_ < var_164_1 + var_164_4 then
				local var_164_5 = (arg_161_1.time_ - var_164_1) / var_164_4
				local var_164_6 = Vector3.New(1500, -300, -295)

				var_164_0.localPosition = Vector3.Lerp(arg_161_1.var_.moveOldPos10092_1, var_164_6, var_164_5)
			end

			if arg_161_1.time_ >= var_164_1 + var_164_4 and arg_161_1.time_ < var_164_1 + var_164_4 + arg_164_0 then
				var_164_0.localPosition = Vector3.New(1500, -300, -295)
			end

			local var_164_7 = arg_161_1.actors_["10093"].transform
			local var_164_8 = 0

			if var_164_8 < arg_161_1.time_ and arg_161_1.time_ <= var_164_8 + arg_164_0 then
				arg_161_1.var_.moveOldPos10093 = var_164_7.localPosition
				var_164_7.localScale = Vector3.New(1, 1, 1)

				arg_161_1:CheckSpriteTmpPos("10093", 7)

				local var_164_9 = var_164_7.childCount

				for iter_164_1 = 0, var_164_9 - 1 do
					local var_164_10 = var_164_7:GetChild(iter_164_1)

					if var_164_10.name == "" or not string.find(var_164_10.name, "split") then
						var_164_10.gameObject:SetActive(true)
					else
						var_164_10.gameObject:SetActive(false)
					end
				end
			end

			local var_164_11 = 0.001

			if var_164_8 <= arg_161_1.time_ and arg_161_1.time_ < var_164_8 + var_164_11 then
				local var_164_12 = (arg_161_1.time_ - var_164_8) / var_164_11
				local var_164_13 = Vector3.New(0, -2000, 0)

				var_164_7.localPosition = Vector3.Lerp(arg_161_1.var_.moveOldPos10093, var_164_13, var_164_12)
			end

			if arg_161_1.time_ >= var_164_8 + var_164_11 and arg_161_1.time_ < var_164_8 + var_164_11 + arg_164_0 then
				var_164_7.localPosition = Vector3.New(0, -2000, 0)
			end

			local var_164_14 = arg_161_1.actors_["10092"]
			local var_164_15 = 0

			if var_164_15 < arg_161_1.time_ and arg_161_1.time_ <= var_164_15 + arg_164_0 and not isNil(var_164_14) and arg_161_1.var_.actorSpriteComps10092 == nil then
				arg_161_1.var_.actorSpriteComps10092 = var_164_14:GetComponentsInChildren(typeof(Image), true)
			end

			local var_164_16 = 2

			if var_164_15 <= arg_161_1.time_ and arg_161_1.time_ < var_164_15 + var_164_16 and not isNil(var_164_14) then
				local var_164_17 = (arg_161_1.time_ - var_164_15) / var_164_16

				if arg_161_1.var_.actorSpriteComps10092 then
					for iter_164_2, iter_164_3 in pairs(arg_161_1.var_.actorSpriteComps10092:ToTable()) do
						if iter_164_3 then
							if arg_161_1.isInRecall_ then
								local var_164_18 = Mathf.Lerp(iter_164_3.color.r, arg_161_1.hightColor2.r, var_164_17)
								local var_164_19 = Mathf.Lerp(iter_164_3.color.g, arg_161_1.hightColor2.g, var_164_17)
								local var_164_20 = Mathf.Lerp(iter_164_3.color.b, arg_161_1.hightColor2.b, var_164_17)

								iter_164_3.color = Color.New(var_164_18, var_164_19, var_164_20)
							else
								local var_164_21 = Mathf.Lerp(iter_164_3.color.r, 0.5, var_164_17)

								iter_164_3.color = Color.New(var_164_21, var_164_21, var_164_21)
							end
						end
					end
				end
			end

			if arg_161_1.time_ >= var_164_15 + var_164_16 and arg_161_1.time_ < var_164_15 + var_164_16 + arg_164_0 and not isNil(var_164_14) and arg_161_1.var_.actorSpriteComps10092 then
				for iter_164_4, iter_164_5 in pairs(arg_161_1.var_.actorSpriteComps10092:ToTable()) do
					if iter_164_5 then
						if arg_161_1.isInRecall_ then
							iter_164_5.color = arg_161_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_164_5.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_161_1.var_.actorSpriteComps10092 = nil
			end

			local var_164_22 = arg_161_1.actors_["10093"]
			local var_164_23 = 0

			if var_164_23 < arg_161_1.time_ and arg_161_1.time_ <= var_164_23 + arg_164_0 and not isNil(var_164_22) and arg_161_1.var_.actorSpriteComps10093 == nil then
				arg_161_1.var_.actorSpriteComps10093 = var_164_22:GetComponentsInChildren(typeof(Image), true)
			end

			local var_164_24 = 2

			if var_164_23 <= arg_161_1.time_ and arg_161_1.time_ < var_164_23 + var_164_24 and not isNil(var_164_22) then
				local var_164_25 = (arg_161_1.time_ - var_164_23) / var_164_24

				if arg_161_1.var_.actorSpriteComps10093 then
					for iter_164_6, iter_164_7 in pairs(arg_161_1.var_.actorSpriteComps10093:ToTable()) do
						if iter_164_7 then
							if arg_161_1.isInRecall_ then
								local var_164_26 = Mathf.Lerp(iter_164_7.color.r, arg_161_1.hightColor2.r, var_164_25)
								local var_164_27 = Mathf.Lerp(iter_164_7.color.g, arg_161_1.hightColor2.g, var_164_25)
								local var_164_28 = Mathf.Lerp(iter_164_7.color.b, arg_161_1.hightColor2.b, var_164_25)

								iter_164_7.color = Color.New(var_164_26, var_164_27, var_164_28)
							else
								local var_164_29 = Mathf.Lerp(iter_164_7.color.r, 0.5, var_164_25)

								iter_164_7.color = Color.New(var_164_29, var_164_29, var_164_29)
							end
						end
					end
				end
			end

			if arg_161_1.time_ >= var_164_23 + var_164_24 and arg_161_1.time_ < var_164_23 + var_164_24 + arg_164_0 and not isNil(var_164_22) and arg_161_1.var_.actorSpriteComps10093 then
				for iter_164_8, iter_164_9 in pairs(arg_161_1.var_.actorSpriteComps10093:ToTable()) do
					if iter_164_9 then
						if arg_161_1.isInRecall_ then
							iter_164_9.color = arg_161_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_164_9.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_161_1.var_.actorSpriteComps10093 = nil
			end

			local var_164_30 = 0
			local var_164_31 = 0.825

			if var_164_30 < arg_161_1.time_ and arg_161_1.time_ <= var_164_30 + arg_164_0 then
				arg_161_1.talkMaxDuration = 0
				arg_161_1.dialogCg_.alpha = 1

				arg_161_1.dialog_:SetActive(true)
				SetActive(arg_161_1.leftNameGo_, false)

				arg_161_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_161_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_161_1:RecordName(arg_161_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_161_1.iconTrs_.gameObject, false)
				arg_161_1.callingController_:SetSelectedState("normal")

				local var_164_32 = arg_161_1:GetWordFromCfg(413141040)
				local var_164_33 = arg_161_1:FormatText(var_164_32.content)

				arg_161_1.text_.text = var_164_33

				LuaForUtil.ClearLinePrefixSymbol(arg_161_1.text_)

				local var_164_34 = 33
				local var_164_35 = utf8.len(var_164_33)
				local var_164_36 = var_164_34 <= 0 and var_164_31 or var_164_31 * (var_164_35 / var_164_34)

				if var_164_36 > 0 and var_164_31 < var_164_36 then
					arg_161_1.talkMaxDuration = var_164_36

					if var_164_36 + var_164_30 > arg_161_1.duration_ then
						arg_161_1.duration_ = var_164_36 + var_164_30
					end
				end

				arg_161_1.text_.text = var_164_33
				arg_161_1.typewritter.percent = 0

				arg_161_1.typewritter:SetDirty()
				arg_161_1:ShowNextGo(false)
				arg_161_1:RecordContent(arg_161_1.text_.text)
			end

			local var_164_37 = math.max(var_164_31, arg_161_1.talkMaxDuration)

			if var_164_30 <= arg_161_1.time_ and arg_161_1.time_ < var_164_30 + var_164_37 then
				arg_161_1.typewritter.percent = (arg_161_1.time_ - var_164_30) / var_164_37

				arg_161_1.typewritter:SetDirty()
			end

			if arg_161_1.time_ >= var_164_30 + var_164_37 and arg_161_1.time_ < var_164_30 + var_164_37 + arg_164_0 then
				arg_161_1.typewritter.percent = 1

				arg_161_1.typewritter:SetDirty()
				arg_161_1:ShowNextGo(true)
			end
		end

		arg_161_1.nodeConfigList_ = {
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

		arg_161_1:InitPlayNodeList()
	end,
	Play413141041 = function(arg_165_0, arg_165_1)
		arg_165_1.time_ = 0
		arg_165_1.frameCnt_ = 0
		arg_165_1.state_ = "playing"
		arg_165_1.curTalkId_ = 413141041
		arg_165_1.duration_ = 5

		SetActive(arg_165_1.tipsGo_, false)

		function arg_165_1.onSingleLineFinish_()
			arg_165_1.onSingleLineUpdate_ = nil
			arg_165_1.onSingleLineFinish_ = nil
			arg_165_1.state_ = "waiting"
		end

		function arg_165_1.playNext_(arg_167_0)
			if arg_167_0 == 1 then
				arg_165_0:Play413141042(arg_165_1)
			end
		end

		function arg_165_1.onSingleLineUpdate_(arg_168_0)
			local var_168_0 = 0
			local var_168_1 = 0.875

			if var_168_0 < arg_165_1.time_ and arg_165_1.time_ <= var_168_0 + arg_168_0 then
				arg_165_1.talkMaxDuration = 0
				arg_165_1.dialogCg_.alpha = 1

				arg_165_1.dialog_:SetActive(true)
				SetActive(arg_165_1.leftNameGo_, false)

				arg_165_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_165_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_165_1:RecordName(arg_165_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_165_1.iconTrs_.gameObject, false)
				arg_165_1.callingController_:SetSelectedState("normal")

				local var_168_2 = arg_165_1:GetWordFromCfg(413141041)
				local var_168_3 = arg_165_1:FormatText(var_168_2.content)

				arg_165_1.text_.text = var_168_3

				LuaForUtil.ClearLinePrefixSymbol(arg_165_1.text_)

				local var_168_4 = 35
				local var_168_5 = utf8.len(var_168_3)
				local var_168_6 = var_168_4 <= 0 and var_168_1 or var_168_1 * (var_168_5 / var_168_4)

				if var_168_6 > 0 and var_168_1 < var_168_6 then
					arg_165_1.talkMaxDuration = var_168_6

					if var_168_6 + var_168_0 > arg_165_1.duration_ then
						arg_165_1.duration_ = var_168_6 + var_168_0
					end
				end

				arg_165_1.text_.text = var_168_3
				arg_165_1.typewritter.percent = 0

				arg_165_1.typewritter:SetDirty()
				arg_165_1:ShowNextGo(false)
				arg_165_1:RecordContent(arg_165_1.text_.text)
			end

			local var_168_7 = math.max(var_168_1, arg_165_1.talkMaxDuration)

			if var_168_0 <= arg_165_1.time_ and arg_165_1.time_ < var_168_0 + var_168_7 then
				arg_165_1.typewritter.percent = (arg_165_1.time_ - var_168_0) / var_168_7

				arg_165_1.typewritter:SetDirty()
			end

			if arg_165_1.time_ >= var_168_0 + var_168_7 and arg_165_1.time_ < var_168_0 + var_168_7 + arg_168_0 then
				arg_165_1.typewritter.percent = 1

				arg_165_1.typewritter:SetDirty()
				arg_165_1:ShowNextGo(true)
			end
		end

		arg_165_1.nodeConfigList_ = {}

		arg_165_1:InitPlayNodeList()
	end,
	Play413141042 = function(arg_169_0, arg_169_1)
		arg_169_1.time_ = 0
		arg_169_1.frameCnt_ = 0
		arg_169_1.state_ = "playing"
		arg_169_1.curTalkId_ = 413141042
		arg_169_1.duration_ = 7.93

		local var_169_0 = {
			zh = 5.266,
			ja = 7.933
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
				arg_169_0:Play413141043(arg_169_1)
			end
		end

		function arg_169_1.onSingleLineUpdate_(arg_172_0)
			local var_172_0 = arg_169_1.actors_["10092_1"].transform
			local var_172_1 = 0

			if var_172_1 < arg_169_1.time_ and arg_169_1.time_ <= var_172_1 + arg_172_0 then
				arg_169_1.var_.moveOldPos10092_1 = var_172_0.localPosition
				var_172_0.localScale = Vector3.New(1, 1, 1)

				arg_169_1:CheckSpriteTmpPos("10092_1", 3)

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
				local var_172_6 = Vector3.New(0, -300, -295)

				var_172_0.localPosition = Vector3.Lerp(arg_169_1.var_.moveOldPos10092_1, var_172_6, var_172_5)
			end

			if arg_169_1.time_ >= var_172_1 + var_172_4 and arg_169_1.time_ < var_172_1 + var_172_4 + arg_172_0 then
				var_172_0.localPosition = Vector3.New(0, -300, -295)
			end

			local var_172_7 = arg_169_1.actors_["10092"]
			local var_172_8 = 0

			if var_172_8 < arg_169_1.time_ and arg_169_1.time_ <= var_172_8 + arg_172_0 and not isNil(var_172_7) and arg_169_1.var_.actorSpriteComps10092 == nil then
				arg_169_1.var_.actorSpriteComps10092 = var_172_7:GetComponentsInChildren(typeof(Image), true)
			end

			local var_172_9 = 2

			if var_172_8 <= arg_169_1.time_ and arg_169_1.time_ < var_172_8 + var_172_9 and not isNil(var_172_7) then
				local var_172_10 = (arg_169_1.time_ - var_172_8) / var_172_9

				if arg_169_1.var_.actorSpriteComps10092 then
					for iter_172_1, iter_172_2 in pairs(arg_169_1.var_.actorSpriteComps10092:ToTable()) do
						if iter_172_2 then
							if arg_169_1.isInRecall_ then
								local var_172_11 = Mathf.Lerp(iter_172_2.color.r, arg_169_1.hightColor1.r, var_172_10)
								local var_172_12 = Mathf.Lerp(iter_172_2.color.g, arg_169_1.hightColor1.g, var_172_10)
								local var_172_13 = Mathf.Lerp(iter_172_2.color.b, arg_169_1.hightColor1.b, var_172_10)

								iter_172_2.color = Color.New(var_172_11, var_172_12, var_172_13)
							else
								local var_172_14 = Mathf.Lerp(iter_172_2.color.r, 1, var_172_10)

								iter_172_2.color = Color.New(var_172_14, var_172_14, var_172_14)
							end
						end
					end
				end
			end

			if arg_169_1.time_ >= var_172_8 + var_172_9 and arg_169_1.time_ < var_172_8 + var_172_9 + arg_172_0 and not isNil(var_172_7) and arg_169_1.var_.actorSpriteComps10092 then
				for iter_172_3, iter_172_4 in pairs(arg_169_1.var_.actorSpriteComps10092:ToTable()) do
					if iter_172_4 then
						if arg_169_1.isInRecall_ then
							iter_172_4.color = arg_169_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_172_4.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_169_1.var_.actorSpriteComps10092 = nil
			end

			local var_172_15 = 0
			local var_172_16 = 0.675

			if var_172_15 < arg_169_1.time_ and arg_169_1.time_ <= var_172_15 + arg_172_0 then
				arg_169_1.talkMaxDuration = 0
				arg_169_1.dialogCg_.alpha = 1

				arg_169_1.dialog_:SetActive(true)
				SetActive(arg_169_1.leftNameGo_, true)

				local var_172_17 = arg_169_1:FormatText(StoryNameCfg[996].name)

				arg_169_1.leftNameTxt_.text = var_172_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_169_1.leftNameTxt_.transform)

				arg_169_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_169_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_169_1:RecordName(arg_169_1.leftNameTxt_.text)
				SetActive(arg_169_1.iconTrs_.gameObject, false)
				arg_169_1.callingController_:SetSelectedState("normal")

				local var_172_18 = arg_169_1:GetWordFromCfg(413141042)
				local var_172_19 = arg_169_1:FormatText(var_172_18.content)

				arg_169_1.text_.text = var_172_19

				LuaForUtil.ClearLinePrefixSymbol(arg_169_1.text_)

				local var_172_20 = 27
				local var_172_21 = utf8.len(var_172_19)
				local var_172_22 = var_172_20 <= 0 and var_172_16 or var_172_16 * (var_172_21 / var_172_20)

				if var_172_22 > 0 and var_172_16 < var_172_22 then
					arg_169_1.talkMaxDuration = var_172_22

					if var_172_22 + var_172_15 > arg_169_1.duration_ then
						arg_169_1.duration_ = var_172_22 + var_172_15
					end
				end

				arg_169_1.text_.text = var_172_19
				arg_169_1.typewritter.percent = 0

				arg_169_1.typewritter:SetDirty()
				arg_169_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_413141", "413141042", "story_v_out_413141.awb") ~= 0 then
					local var_172_23 = manager.audio:GetVoiceLength("story_v_out_413141", "413141042", "story_v_out_413141.awb") / 1000

					if var_172_23 + var_172_15 > arg_169_1.duration_ then
						arg_169_1.duration_ = var_172_23 + var_172_15
					end

					if var_172_18.prefab_name ~= "" and arg_169_1.actors_[var_172_18.prefab_name] ~= nil then
						local var_172_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_169_1.actors_[var_172_18.prefab_name].transform, "story_v_out_413141", "413141042", "story_v_out_413141.awb")

						arg_169_1:RecordAudio("413141042", var_172_24)
						arg_169_1:RecordAudio("413141042", var_172_24)
					else
						arg_169_1:AudioAction("play", "voice", "story_v_out_413141", "413141042", "story_v_out_413141.awb")
					end

					arg_169_1:RecordHistoryTalkVoice("story_v_out_413141", "413141042", "story_v_out_413141.awb")
				end

				arg_169_1:RecordContent(arg_169_1.text_.text)
			end

			local var_172_25 = math.max(var_172_16, arg_169_1.talkMaxDuration)

			if var_172_15 <= arg_169_1.time_ and arg_169_1.time_ < var_172_15 + var_172_25 then
				arg_169_1.typewritter.percent = (arg_169_1.time_ - var_172_15) / var_172_25

				arg_169_1.typewritter:SetDirty()
			end

			if arg_169_1.time_ >= var_172_15 + var_172_25 and arg_169_1.time_ < var_172_15 + var_172_25 + arg_172_0 then
				arg_169_1.typewritter.percent = 1

				arg_169_1.typewritter:SetDirty()
				arg_169_1:ShowNextGo(true)
			end
		end

		arg_169_1.nodeConfigList_ = {
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

		arg_169_1:InitPlayNodeList()
	end,
	Play413141043 = function(arg_173_0, arg_173_1)
		arg_173_1.time_ = 0
		arg_173_1.frameCnt_ = 0
		arg_173_1.state_ = "playing"
		arg_173_1.curTalkId_ = 413141043
		arg_173_1.duration_ = 10.97

		local var_173_0 = {
			zh = 7.833,
			ja = 10.966
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
				arg_173_0:Play413141044(arg_173_1)
			end
		end

		function arg_173_1.onSingleLineUpdate_(arg_176_0)
			local var_176_0 = 0
			local var_176_1 = 0.925

			if var_176_0 < arg_173_1.time_ and arg_173_1.time_ <= var_176_0 + arg_176_0 then
				arg_173_1.talkMaxDuration = 0
				arg_173_1.dialogCg_.alpha = 1

				arg_173_1.dialog_:SetActive(true)
				SetActive(arg_173_1.leftNameGo_, true)

				local var_176_2 = arg_173_1:FormatText(StoryNameCfg[996].name)

				arg_173_1.leftNameTxt_.text = var_176_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_173_1.leftNameTxt_.transform)

				arg_173_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_173_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_173_1:RecordName(arg_173_1.leftNameTxt_.text)
				SetActive(arg_173_1.iconTrs_.gameObject, false)
				arg_173_1.callingController_:SetSelectedState("normal")

				local var_176_3 = arg_173_1:GetWordFromCfg(413141043)
				local var_176_4 = arg_173_1:FormatText(var_176_3.content)

				arg_173_1.text_.text = var_176_4

				LuaForUtil.ClearLinePrefixSymbol(arg_173_1.text_)

				local var_176_5 = 37
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

				if manager.audio:GetVoiceLength("story_v_out_413141", "413141043", "story_v_out_413141.awb") ~= 0 then
					local var_176_8 = manager.audio:GetVoiceLength("story_v_out_413141", "413141043", "story_v_out_413141.awb") / 1000

					if var_176_8 + var_176_0 > arg_173_1.duration_ then
						arg_173_1.duration_ = var_176_8 + var_176_0
					end

					if var_176_3.prefab_name ~= "" and arg_173_1.actors_[var_176_3.prefab_name] ~= nil then
						local var_176_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_173_1.actors_[var_176_3.prefab_name].transform, "story_v_out_413141", "413141043", "story_v_out_413141.awb")

						arg_173_1:RecordAudio("413141043", var_176_9)
						arg_173_1:RecordAudio("413141043", var_176_9)
					else
						arg_173_1:AudioAction("play", "voice", "story_v_out_413141", "413141043", "story_v_out_413141.awb")
					end

					arg_173_1:RecordHistoryTalkVoice("story_v_out_413141", "413141043", "story_v_out_413141.awb")
				end

				arg_173_1:RecordContent(arg_173_1.text_.text)
			end

			local var_176_10 = math.max(var_176_1, arg_173_1.talkMaxDuration)

			if var_176_0 <= arg_173_1.time_ and arg_173_1.time_ < var_176_0 + var_176_10 then
				arg_173_1.typewritter.percent = (arg_173_1.time_ - var_176_0) / var_176_10

				arg_173_1.typewritter:SetDirty()
			end

			if arg_173_1.time_ >= var_176_0 + var_176_10 and arg_173_1.time_ < var_176_0 + var_176_10 + arg_176_0 then
				arg_173_1.typewritter.percent = 1

				arg_173_1.typewritter:SetDirty()
				arg_173_1:ShowNextGo(true)
			end
		end

		arg_173_1.nodeConfigList_ = {}

		arg_173_1:InitPlayNodeList()
	end,
	Play413141044 = function(arg_177_0, arg_177_1)
		arg_177_1.time_ = 0
		arg_177_1.frameCnt_ = 0
		arg_177_1.state_ = "playing"
		arg_177_1.curTalkId_ = 413141044
		arg_177_1.duration_ = 5.77

		local var_177_0 = {
			zh = 4.3,
			ja = 5.766
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
				arg_177_0:Play413141045(arg_177_1)
			end
		end

		function arg_177_1.onSingleLineUpdate_(arg_180_0)
			local var_180_0 = 0
			local var_180_1 = 0.5

			if var_180_0 < arg_177_1.time_ and arg_177_1.time_ <= var_180_0 + arg_180_0 then
				arg_177_1.talkMaxDuration = 0
				arg_177_1.dialogCg_.alpha = 1

				arg_177_1.dialog_:SetActive(true)
				SetActive(arg_177_1.leftNameGo_, true)

				local var_180_2 = arg_177_1:FormatText(StoryNameCfg[996].name)

				arg_177_1.leftNameTxt_.text = var_180_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_177_1.leftNameTxt_.transform)

				arg_177_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_177_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_177_1:RecordName(arg_177_1.leftNameTxt_.text)
				SetActive(arg_177_1.iconTrs_.gameObject, false)
				arg_177_1.callingController_:SetSelectedState("normal")

				local var_180_3 = arg_177_1:GetWordFromCfg(413141044)
				local var_180_4 = arg_177_1:FormatText(var_180_3.content)

				arg_177_1.text_.text = var_180_4

				LuaForUtil.ClearLinePrefixSymbol(arg_177_1.text_)

				local var_180_5 = 20
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

				if manager.audio:GetVoiceLength("story_v_out_413141", "413141044", "story_v_out_413141.awb") ~= 0 then
					local var_180_8 = manager.audio:GetVoiceLength("story_v_out_413141", "413141044", "story_v_out_413141.awb") / 1000

					if var_180_8 + var_180_0 > arg_177_1.duration_ then
						arg_177_1.duration_ = var_180_8 + var_180_0
					end

					if var_180_3.prefab_name ~= "" and arg_177_1.actors_[var_180_3.prefab_name] ~= nil then
						local var_180_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_177_1.actors_[var_180_3.prefab_name].transform, "story_v_out_413141", "413141044", "story_v_out_413141.awb")

						arg_177_1:RecordAudio("413141044", var_180_9)
						arg_177_1:RecordAudio("413141044", var_180_9)
					else
						arg_177_1:AudioAction("play", "voice", "story_v_out_413141", "413141044", "story_v_out_413141.awb")
					end

					arg_177_1:RecordHistoryTalkVoice("story_v_out_413141", "413141044", "story_v_out_413141.awb")
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
	Play413141045 = function(arg_181_0, arg_181_1)
		arg_181_1.time_ = 0
		arg_181_1.frameCnt_ = 0
		arg_181_1.state_ = "playing"
		arg_181_1.curTalkId_ = 413141045
		arg_181_1.duration_ = 2.5

		local var_181_0 = {
			zh = 2.266,
			ja = 2.5
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
				arg_181_0:Play413141046(arg_181_1)
			end
		end

		function arg_181_1.onSingleLineUpdate_(arg_184_0)
			local var_184_0 = arg_181_1.actors_["10092_1"].transform
			local var_184_1 = 0

			if var_184_1 < arg_181_1.time_ and arg_181_1.time_ <= var_184_1 + arg_184_0 then
				arg_181_1.var_.moveOldPos10092_1 = var_184_0.localPosition
				var_184_0.localScale = Vector3.New(1, 1, 1)

				arg_181_1:CheckSpriteTmpPos("10092_1", 2)

				local var_184_2 = var_184_0.childCount

				for iter_184_0 = 0, var_184_2 - 1 do
					local var_184_3 = var_184_0:GetChild(iter_184_0)

					if var_184_3.name == "split_1_1" or not string.find(var_184_3.name, "split") then
						var_184_3.gameObject:SetActive(true)
					else
						var_184_3.gameObject:SetActive(false)
					end
				end
			end

			local var_184_4 = 0.001

			if var_184_1 <= arg_181_1.time_ and arg_181_1.time_ < var_184_1 + var_184_4 then
				local var_184_5 = (arg_181_1.time_ - var_184_1) / var_184_4
				local var_184_6 = Vector3.New(-389.49, -300, -295)

				var_184_0.localPosition = Vector3.Lerp(arg_181_1.var_.moveOldPos10092_1, var_184_6, var_184_5)
			end

			if arg_181_1.time_ >= var_184_1 + var_184_4 and arg_181_1.time_ < var_184_1 + var_184_4 + arg_184_0 then
				var_184_0.localPosition = Vector3.New(-389.49, -300, -295)
			end

			local var_184_7 = arg_181_1.actors_["10093"].transform
			local var_184_8 = 0

			if var_184_8 < arg_181_1.time_ and arg_181_1.time_ <= var_184_8 + arg_184_0 then
				arg_181_1.var_.moveOldPos10093 = var_184_7.localPosition
				var_184_7.localScale = Vector3.New(1, 1, 1)

				arg_181_1:CheckSpriteTmpPos("10093", 4)

				local var_184_9 = var_184_7.childCount

				for iter_184_1 = 0, var_184_9 - 1 do
					local var_184_10 = var_184_7:GetChild(iter_184_1)

					if var_184_10.name == "split_4" or not string.find(var_184_10.name, "split") then
						var_184_10.gameObject:SetActive(true)
					else
						var_184_10.gameObject:SetActive(false)
					end
				end
			end

			local var_184_11 = 0.001

			if var_184_8 <= arg_181_1.time_ and arg_181_1.time_ < var_184_8 + var_184_11 then
				local var_184_12 = (arg_181_1.time_ - var_184_8) / var_184_11
				local var_184_13 = Vector3.New(390, -345, -245)

				var_184_7.localPosition = Vector3.Lerp(arg_181_1.var_.moveOldPos10093, var_184_13, var_184_12)
			end

			if arg_181_1.time_ >= var_184_8 + var_184_11 and arg_181_1.time_ < var_184_8 + var_184_11 + arg_184_0 then
				var_184_7.localPosition = Vector3.New(390, -345, -245)
			end

			local var_184_14 = arg_181_1.actors_["10092_1"]
			local var_184_15 = 0

			if var_184_15 < arg_181_1.time_ and arg_181_1.time_ <= var_184_15 + arg_184_0 and not isNil(var_184_14) and arg_181_1.var_.actorSpriteComps10092_1 == nil then
				arg_181_1.var_.actorSpriteComps10092_1 = var_184_14:GetComponentsInChildren(typeof(Image), true)
			end

			local var_184_16 = 2

			if var_184_15 <= arg_181_1.time_ and arg_181_1.time_ < var_184_15 + var_184_16 and not isNil(var_184_14) then
				local var_184_17 = (arg_181_1.time_ - var_184_15) / var_184_16

				if arg_181_1.var_.actorSpriteComps10092_1 then
					for iter_184_2, iter_184_3 in pairs(arg_181_1.var_.actorSpriteComps10092_1:ToTable()) do
						if iter_184_3 then
							if arg_181_1.isInRecall_ then
								local var_184_18 = Mathf.Lerp(iter_184_3.color.r, arg_181_1.hightColor2.r, var_184_17)
								local var_184_19 = Mathf.Lerp(iter_184_3.color.g, arg_181_1.hightColor2.g, var_184_17)
								local var_184_20 = Mathf.Lerp(iter_184_3.color.b, arg_181_1.hightColor2.b, var_184_17)

								iter_184_3.color = Color.New(var_184_18, var_184_19, var_184_20)
							else
								local var_184_21 = Mathf.Lerp(iter_184_3.color.r, 0.5, var_184_17)

								iter_184_3.color = Color.New(var_184_21, var_184_21, var_184_21)
							end
						end
					end
				end
			end

			if arg_181_1.time_ >= var_184_15 + var_184_16 and arg_181_1.time_ < var_184_15 + var_184_16 + arg_184_0 and not isNil(var_184_14) and arg_181_1.var_.actorSpriteComps10092_1 then
				for iter_184_4, iter_184_5 in pairs(arg_181_1.var_.actorSpriteComps10092_1:ToTable()) do
					if iter_184_5 then
						if arg_181_1.isInRecall_ then
							iter_184_5.color = arg_181_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_184_5.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_181_1.var_.actorSpriteComps10092_1 = nil
			end

			local var_184_22 = arg_181_1.actors_["10093"]
			local var_184_23 = 0

			if var_184_23 < arg_181_1.time_ and arg_181_1.time_ <= var_184_23 + arg_184_0 and not isNil(var_184_22) and arg_181_1.var_.actorSpriteComps10093 == nil then
				arg_181_1.var_.actorSpriteComps10093 = var_184_22:GetComponentsInChildren(typeof(Image), true)
			end

			local var_184_24 = 2

			if var_184_23 <= arg_181_1.time_ and arg_181_1.time_ < var_184_23 + var_184_24 and not isNil(var_184_22) then
				local var_184_25 = (arg_181_1.time_ - var_184_23) / var_184_24

				if arg_181_1.var_.actorSpriteComps10093 then
					for iter_184_6, iter_184_7 in pairs(arg_181_1.var_.actorSpriteComps10093:ToTable()) do
						if iter_184_7 then
							if arg_181_1.isInRecall_ then
								local var_184_26 = Mathf.Lerp(iter_184_7.color.r, arg_181_1.hightColor1.r, var_184_25)
								local var_184_27 = Mathf.Lerp(iter_184_7.color.g, arg_181_1.hightColor1.g, var_184_25)
								local var_184_28 = Mathf.Lerp(iter_184_7.color.b, arg_181_1.hightColor1.b, var_184_25)

								iter_184_7.color = Color.New(var_184_26, var_184_27, var_184_28)
							else
								local var_184_29 = Mathf.Lerp(iter_184_7.color.r, 1, var_184_25)

								iter_184_7.color = Color.New(var_184_29, var_184_29, var_184_29)
							end
						end
					end
				end
			end

			if arg_181_1.time_ >= var_184_23 + var_184_24 and arg_181_1.time_ < var_184_23 + var_184_24 + arg_184_0 and not isNil(var_184_22) and arg_181_1.var_.actorSpriteComps10093 then
				for iter_184_8, iter_184_9 in pairs(arg_181_1.var_.actorSpriteComps10093:ToTable()) do
					if iter_184_9 then
						if arg_181_1.isInRecall_ then
							iter_184_9.color = arg_181_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_184_9.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_181_1.var_.actorSpriteComps10093 = nil
			end

			local var_184_30 = 0
			local var_184_31 = 0.25

			if var_184_30 < arg_181_1.time_ and arg_181_1.time_ <= var_184_30 + arg_184_0 then
				arg_181_1.talkMaxDuration = 0
				arg_181_1.dialogCg_.alpha = 1

				arg_181_1.dialog_:SetActive(true)
				SetActive(arg_181_1.leftNameGo_, true)

				local var_184_32 = arg_181_1:FormatText(StoryNameCfg[28].name)

				arg_181_1.leftNameTxt_.text = var_184_32

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_181_1.leftNameTxt_.transform)

				arg_181_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_181_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_181_1:RecordName(arg_181_1.leftNameTxt_.text)
				SetActive(arg_181_1.iconTrs_.gameObject, false)
				arg_181_1.callingController_:SetSelectedState("normal")

				local var_184_33 = arg_181_1:GetWordFromCfg(413141045)
				local var_184_34 = arg_181_1:FormatText(var_184_33.content)

				arg_181_1.text_.text = var_184_34

				LuaForUtil.ClearLinePrefixSymbol(arg_181_1.text_)

				local var_184_35 = 10
				local var_184_36 = utf8.len(var_184_34)
				local var_184_37 = var_184_35 <= 0 and var_184_31 or var_184_31 * (var_184_36 / var_184_35)

				if var_184_37 > 0 and var_184_31 < var_184_37 then
					arg_181_1.talkMaxDuration = var_184_37

					if var_184_37 + var_184_30 > arg_181_1.duration_ then
						arg_181_1.duration_ = var_184_37 + var_184_30
					end
				end

				arg_181_1.text_.text = var_184_34
				arg_181_1.typewritter.percent = 0

				arg_181_1.typewritter:SetDirty()
				arg_181_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_413141", "413141045", "story_v_out_413141.awb") ~= 0 then
					local var_184_38 = manager.audio:GetVoiceLength("story_v_out_413141", "413141045", "story_v_out_413141.awb") / 1000

					if var_184_38 + var_184_30 > arg_181_1.duration_ then
						arg_181_1.duration_ = var_184_38 + var_184_30
					end

					if var_184_33.prefab_name ~= "" and arg_181_1.actors_[var_184_33.prefab_name] ~= nil then
						local var_184_39 = LuaForUtil.PlayVoiceWithCriLipsync(arg_181_1.actors_[var_184_33.prefab_name].transform, "story_v_out_413141", "413141045", "story_v_out_413141.awb")

						arg_181_1:RecordAudio("413141045", var_184_39)
						arg_181_1:RecordAudio("413141045", var_184_39)
					else
						arg_181_1:AudioAction("play", "voice", "story_v_out_413141", "413141045", "story_v_out_413141.awb")
					end

					arg_181_1:RecordHistoryTalkVoice("story_v_out_413141", "413141045", "story_v_out_413141.awb")
				end

				arg_181_1:RecordContent(arg_181_1.text_.text)
			end

			local var_184_40 = math.max(var_184_31, arg_181_1.talkMaxDuration)

			if var_184_30 <= arg_181_1.time_ and arg_181_1.time_ < var_184_30 + var_184_40 then
				arg_181_1.typewritter.percent = (arg_181_1.time_ - var_184_30) / var_184_40

				arg_181_1.typewritter:SetDirty()
			end

			if arg_181_1.time_ >= var_184_30 + var_184_40 and arg_181_1.time_ < var_184_30 + var_184_40 + arg_184_0 then
				arg_181_1.typewritter.percent = 1

				arg_181_1.typewritter:SetDirty()
				arg_181_1:ShowNextGo(true)
			end
		end

		arg_181_1.nodeConfigList_ = {
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

		arg_181_1:InitPlayNodeList()
	end,
	Play413141046 = function(arg_185_0, arg_185_1)
		arg_185_1.time_ = 0
		arg_185_1.frameCnt_ = 0
		arg_185_1.state_ = "playing"
		arg_185_1.curTalkId_ = 413141046
		arg_185_1.duration_ = 12.2

		local var_185_0 = {
			zh = 6.266,
			ja = 12.2
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
				arg_185_0:Play413141047(arg_185_1)
			end
		end

		function arg_185_1.onSingleLineUpdate_(arg_188_0)
			local var_188_0 = arg_185_1.actors_["10092_1"]
			local var_188_1 = 0

			if var_188_1 < arg_185_1.time_ and arg_185_1.time_ <= var_188_1 + arg_188_0 and not isNil(var_188_0) and arg_185_1.var_.actorSpriteComps10092_1 == nil then
				arg_185_1.var_.actorSpriteComps10092_1 = var_188_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_188_2 = 2

			if var_188_1 <= arg_185_1.time_ and arg_185_1.time_ < var_188_1 + var_188_2 and not isNil(var_188_0) then
				local var_188_3 = (arg_185_1.time_ - var_188_1) / var_188_2

				if arg_185_1.var_.actorSpriteComps10092_1 then
					for iter_188_0, iter_188_1 in pairs(arg_185_1.var_.actorSpriteComps10092_1:ToTable()) do
						if iter_188_1 then
							if arg_185_1.isInRecall_ then
								local var_188_4 = Mathf.Lerp(iter_188_1.color.r, arg_185_1.hightColor1.r, var_188_3)
								local var_188_5 = Mathf.Lerp(iter_188_1.color.g, arg_185_1.hightColor1.g, var_188_3)
								local var_188_6 = Mathf.Lerp(iter_188_1.color.b, arg_185_1.hightColor1.b, var_188_3)

								iter_188_1.color = Color.New(var_188_4, var_188_5, var_188_6)
							else
								local var_188_7 = Mathf.Lerp(iter_188_1.color.r, 1, var_188_3)

								iter_188_1.color = Color.New(var_188_7, var_188_7, var_188_7)
							end
						end
					end
				end
			end

			if arg_185_1.time_ >= var_188_1 + var_188_2 and arg_185_1.time_ < var_188_1 + var_188_2 + arg_188_0 and not isNil(var_188_0) and arg_185_1.var_.actorSpriteComps10092_1 then
				for iter_188_2, iter_188_3 in pairs(arg_185_1.var_.actorSpriteComps10092_1:ToTable()) do
					if iter_188_3 then
						if arg_185_1.isInRecall_ then
							iter_188_3.color = arg_185_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_188_3.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_185_1.var_.actorSpriteComps10092_1 = nil
			end

			local var_188_8 = arg_185_1.actors_["10093"]
			local var_188_9 = 0

			if var_188_9 < arg_185_1.time_ and arg_185_1.time_ <= var_188_9 + arg_188_0 and not isNil(var_188_8) and arg_185_1.var_.actorSpriteComps10093 == nil then
				arg_185_1.var_.actorSpriteComps10093 = var_188_8:GetComponentsInChildren(typeof(Image), true)
			end

			local var_188_10 = 2

			if var_188_9 <= arg_185_1.time_ and arg_185_1.time_ < var_188_9 + var_188_10 and not isNil(var_188_8) then
				local var_188_11 = (arg_185_1.time_ - var_188_9) / var_188_10

				if arg_185_1.var_.actorSpriteComps10093 then
					for iter_188_4, iter_188_5 in pairs(arg_185_1.var_.actorSpriteComps10093:ToTable()) do
						if iter_188_5 then
							if arg_185_1.isInRecall_ then
								local var_188_12 = Mathf.Lerp(iter_188_5.color.r, arg_185_1.hightColor2.r, var_188_11)
								local var_188_13 = Mathf.Lerp(iter_188_5.color.g, arg_185_1.hightColor2.g, var_188_11)
								local var_188_14 = Mathf.Lerp(iter_188_5.color.b, arg_185_1.hightColor2.b, var_188_11)

								iter_188_5.color = Color.New(var_188_12, var_188_13, var_188_14)
							else
								local var_188_15 = Mathf.Lerp(iter_188_5.color.r, 0.5, var_188_11)

								iter_188_5.color = Color.New(var_188_15, var_188_15, var_188_15)
							end
						end
					end
				end
			end

			if arg_185_1.time_ >= var_188_9 + var_188_10 and arg_185_1.time_ < var_188_9 + var_188_10 + arg_188_0 and not isNil(var_188_8) and arg_185_1.var_.actorSpriteComps10093 then
				for iter_188_6, iter_188_7 in pairs(arg_185_1.var_.actorSpriteComps10093:ToTable()) do
					if iter_188_7 then
						if arg_185_1.isInRecall_ then
							iter_188_7.color = arg_185_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_188_7.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_185_1.var_.actorSpriteComps10093 = nil
			end

			local var_188_16 = 0
			local var_188_17 = 0.7

			if var_188_16 < arg_185_1.time_ and arg_185_1.time_ <= var_188_16 + arg_188_0 then
				arg_185_1.talkMaxDuration = 0
				arg_185_1.dialogCg_.alpha = 1

				arg_185_1.dialog_:SetActive(true)
				SetActive(arg_185_1.leftNameGo_, true)

				local var_188_18 = arg_185_1:FormatText(StoryNameCfg[996].name)

				arg_185_1.leftNameTxt_.text = var_188_18

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_185_1.leftNameTxt_.transform)

				arg_185_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_185_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_185_1:RecordName(arg_185_1.leftNameTxt_.text)
				SetActive(arg_185_1.iconTrs_.gameObject, false)
				arg_185_1.callingController_:SetSelectedState("normal")

				local var_188_19 = arg_185_1:GetWordFromCfg(413141046)
				local var_188_20 = arg_185_1:FormatText(var_188_19.content)

				arg_185_1.text_.text = var_188_20

				LuaForUtil.ClearLinePrefixSymbol(arg_185_1.text_)

				local var_188_21 = 28
				local var_188_22 = utf8.len(var_188_20)
				local var_188_23 = var_188_21 <= 0 and var_188_17 or var_188_17 * (var_188_22 / var_188_21)

				if var_188_23 > 0 and var_188_17 < var_188_23 then
					arg_185_1.talkMaxDuration = var_188_23

					if var_188_23 + var_188_16 > arg_185_1.duration_ then
						arg_185_1.duration_ = var_188_23 + var_188_16
					end
				end

				arg_185_1.text_.text = var_188_20
				arg_185_1.typewritter.percent = 0

				arg_185_1.typewritter:SetDirty()
				arg_185_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_413141", "413141046", "story_v_out_413141.awb") ~= 0 then
					local var_188_24 = manager.audio:GetVoiceLength("story_v_out_413141", "413141046", "story_v_out_413141.awb") / 1000

					if var_188_24 + var_188_16 > arg_185_1.duration_ then
						arg_185_1.duration_ = var_188_24 + var_188_16
					end

					if var_188_19.prefab_name ~= "" and arg_185_1.actors_[var_188_19.prefab_name] ~= nil then
						local var_188_25 = LuaForUtil.PlayVoiceWithCriLipsync(arg_185_1.actors_[var_188_19.prefab_name].transform, "story_v_out_413141", "413141046", "story_v_out_413141.awb")

						arg_185_1:RecordAudio("413141046", var_188_25)
						arg_185_1:RecordAudio("413141046", var_188_25)
					else
						arg_185_1:AudioAction("play", "voice", "story_v_out_413141", "413141046", "story_v_out_413141.awb")
					end

					arg_185_1:RecordHistoryTalkVoice("story_v_out_413141", "413141046", "story_v_out_413141.awb")
				end

				arg_185_1:RecordContent(arg_185_1.text_.text)
			end

			local var_188_26 = math.max(var_188_17, arg_185_1.talkMaxDuration)

			if var_188_16 <= arg_185_1.time_ and arg_185_1.time_ < var_188_16 + var_188_26 then
				arg_185_1.typewritter.percent = (arg_185_1.time_ - var_188_16) / var_188_26

				arg_185_1.typewritter:SetDirty()
			end

			if arg_185_1.time_ >= var_188_16 + var_188_26 and arg_185_1.time_ < var_188_16 + var_188_26 + arg_188_0 then
				arg_185_1.typewritter.percent = 1

				arg_185_1.typewritter:SetDirty()
				arg_185_1:ShowNextGo(true)
			end
		end

		arg_185_1.nodeConfigList_ = {}

		arg_185_1:InitPlayNodeList()
	end,
	Play413141047 = function(arg_189_0, arg_189_1)
		arg_189_1.time_ = 0
		arg_189_1.frameCnt_ = 0
		arg_189_1.state_ = "playing"
		arg_189_1.curTalkId_ = 413141047
		arg_189_1.duration_ = 11.8

		local var_189_0 = {
			zh = 5.4,
			ja = 11.8
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
				arg_189_0:Play413141048(arg_189_1)
			end
		end

		function arg_189_1.onSingleLineUpdate_(arg_192_0)
			local var_192_0 = arg_189_1.actors_["10092_1"]
			local var_192_1 = 0

			if var_192_1 < arg_189_1.time_ and arg_189_1.time_ <= var_192_1 + arg_192_0 and not isNil(var_192_0) and arg_189_1.var_.actorSpriteComps10092_1 == nil then
				arg_189_1.var_.actorSpriteComps10092_1 = var_192_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_192_2 = 2

			if var_192_1 <= arg_189_1.time_ and arg_189_1.time_ < var_192_1 + var_192_2 and not isNil(var_192_0) then
				local var_192_3 = (arg_189_1.time_ - var_192_1) / var_192_2

				if arg_189_1.var_.actorSpriteComps10092_1 then
					for iter_192_0, iter_192_1 in pairs(arg_189_1.var_.actorSpriteComps10092_1:ToTable()) do
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

			if arg_189_1.time_ >= var_192_1 + var_192_2 and arg_189_1.time_ < var_192_1 + var_192_2 + arg_192_0 and not isNil(var_192_0) and arg_189_1.var_.actorSpriteComps10092_1 then
				for iter_192_2, iter_192_3 in pairs(arg_189_1.var_.actorSpriteComps10092_1:ToTable()) do
					if iter_192_3 then
						if arg_189_1.isInRecall_ then
							iter_192_3.color = arg_189_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_192_3.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_189_1.var_.actorSpriteComps10092_1 = nil
			end

			local var_192_8 = 0
			local var_192_9 = 0.625

			if var_192_8 < arg_189_1.time_ and arg_189_1.time_ <= var_192_8 + arg_192_0 then
				arg_189_1.talkMaxDuration = 0
				arg_189_1.dialogCg_.alpha = 1

				arg_189_1.dialog_:SetActive(true)
				SetActive(arg_189_1.leftNameGo_, true)

				local var_192_10 = arg_189_1:FormatText(StoryNameCfg[996].name)

				arg_189_1.leftNameTxt_.text = var_192_10

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_189_1.leftNameTxt_.transform)

				arg_189_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_189_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_189_1:RecordName(arg_189_1.leftNameTxt_.text)
				SetActive(arg_189_1.iconTrs_.gameObject, false)
				arg_189_1.callingController_:SetSelectedState("normal")

				local var_192_11 = arg_189_1:GetWordFromCfg(413141047)
				local var_192_12 = arg_189_1:FormatText(var_192_11.content)

				arg_189_1.text_.text = var_192_12

				LuaForUtil.ClearLinePrefixSymbol(arg_189_1.text_)

				local var_192_13 = 25
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

				if manager.audio:GetVoiceLength("story_v_out_413141", "413141047", "story_v_out_413141.awb") ~= 0 then
					local var_192_16 = manager.audio:GetVoiceLength("story_v_out_413141", "413141047", "story_v_out_413141.awb") / 1000

					if var_192_16 + var_192_8 > arg_189_1.duration_ then
						arg_189_1.duration_ = var_192_16 + var_192_8
					end

					if var_192_11.prefab_name ~= "" and arg_189_1.actors_[var_192_11.prefab_name] ~= nil then
						local var_192_17 = LuaForUtil.PlayVoiceWithCriLipsync(arg_189_1.actors_[var_192_11.prefab_name].transform, "story_v_out_413141", "413141047", "story_v_out_413141.awb")

						arg_189_1:RecordAudio("413141047", var_192_17)
						arg_189_1:RecordAudio("413141047", var_192_17)
					else
						arg_189_1:AudioAction("play", "voice", "story_v_out_413141", "413141047", "story_v_out_413141.awb")
					end

					arg_189_1:RecordHistoryTalkVoice("story_v_out_413141", "413141047", "story_v_out_413141.awb")
				end

				arg_189_1:RecordContent(arg_189_1.text_.text)
			end

			local var_192_18 = math.max(var_192_9, arg_189_1.talkMaxDuration)

			if var_192_8 <= arg_189_1.time_ and arg_189_1.time_ < var_192_8 + var_192_18 then
				arg_189_1.typewritter.percent = (arg_189_1.time_ - var_192_8) / var_192_18

				arg_189_1.typewritter:SetDirty()
			end

			if arg_189_1.time_ >= var_192_8 + var_192_18 and arg_189_1.time_ < var_192_8 + var_192_18 + arg_192_0 then
				arg_189_1.typewritter.percent = 1

				arg_189_1.typewritter:SetDirty()
				arg_189_1:ShowNextGo(true)
			end
		end

		arg_189_1.nodeConfigList_ = {}

		arg_189_1:InitPlayNodeList()
	end,
	Play413141048 = function(arg_193_0, arg_193_1)
		arg_193_1.time_ = 0
		arg_193_1.frameCnt_ = 0
		arg_193_1.state_ = "playing"
		arg_193_1.curTalkId_ = 413141048
		arg_193_1.duration_ = 2.7

		local var_193_0 = {
			zh = 2.566,
			ja = 2.7
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
				arg_193_0:Play413141049(arg_193_1)
			end
		end

		function arg_193_1.onSingleLineUpdate_(arg_196_0)
			local var_196_0 = arg_193_1.actors_["10093"].transform
			local var_196_1 = 0

			if var_196_1 < arg_193_1.time_ and arg_193_1.time_ <= var_196_1 + arg_196_0 then
				arg_193_1.var_.moveOldPos10093 = var_196_0.localPosition
				var_196_0.localScale = Vector3.New(1, 1, 1)

				arg_193_1:CheckSpriteTmpPos("10093", 4)

				local var_196_2 = var_196_0.childCount

				for iter_196_0 = 0, var_196_2 - 1 do
					local var_196_3 = var_196_0:GetChild(iter_196_0)

					if var_196_3.name == "split_4" or not string.find(var_196_3.name, "split") then
						var_196_3.gameObject:SetActive(true)
					else
						var_196_3.gameObject:SetActive(false)
					end
				end
			end

			local var_196_4 = 0.001

			if var_196_1 <= arg_193_1.time_ and arg_193_1.time_ < var_196_1 + var_196_4 then
				local var_196_5 = (arg_193_1.time_ - var_196_1) / var_196_4
				local var_196_6 = Vector3.New(390, -345, -245)

				var_196_0.localPosition = Vector3.Lerp(arg_193_1.var_.moveOldPos10093, var_196_6, var_196_5)
			end

			if arg_193_1.time_ >= var_196_1 + var_196_4 and arg_193_1.time_ < var_196_1 + var_196_4 + arg_196_0 then
				var_196_0.localPosition = Vector3.New(390, -345, -245)
			end

			local var_196_7 = arg_193_1.actors_["10092_1"]
			local var_196_8 = 0

			if var_196_8 < arg_193_1.time_ and arg_193_1.time_ <= var_196_8 + arg_196_0 and not isNil(var_196_7) and arg_193_1.var_.actorSpriteComps10092_1 == nil then
				arg_193_1.var_.actorSpriteComps10092_1 = var_196_7:GetComponentsInChildren(typeof(Image), true)
			end

			local var_196_9 = 2

			if var_196_8 <= arg_193_1.time_ and arg_193_1.time_ < var_196_8 + var_196_9 and not isNil(var_196_7) then
				local var_196_10 = (arg_193_1.time_ - var_196_8) / var_196_9

				if arg_193_1.var_.actorSpriteComps10092_1 then
					for iter_196_1, iter_196_2 in pairs(arg_193_1.var_.actorSpriteComps10092_1:ToTable()) do
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

			if arg_193_1.time_ >= var_196_8 + var_196_9 and arg_193_1.time_ < var_196_8 + var_196_9 + arg_196_0 and not isNil(var_196_7) and arg_193_1.var_.actorSpriteComps10092_1 then
				for iter_196_3, iter_196_4 in pairs(arg_193_1.var_.actorSpriteComps10092_1:ToTable()) do
					if iter_196_4 then
						if arg_193_1.isInRecall_ then
							iter_196_4.color = arg_193_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_196_4.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_193_1.var_.actorSpriteComps10092_1 = nil
			end

			local var_196_15 = arg_193_1.actors_["10093"]
			local var_196_16 = 0

			if var_196_16 < arg_193_1.time_ and arg_193_1.time_ <= var_196_16 + arg_196_0 and not isNil(var_196_15) and arg_193_1.var_.actorSpriteComps10093 == nil then
				arg_193_1.var_.actorSpriteComps10093 = var_196_15:GetComponentsInChildren(typeof(Image), true)
			end

			local var_196_17 = 2

			if var_196_16 <= arg_193_1.time_ and arg_193_1.time_ < var_196_16 + var_196_17 and not isNil(var_196_15) then
				local var_196_18 = (arg_193_1.time_ - var_196_16) / var_196_17

				if arg_193_1.var_.actorSpriteComps10093 then
					for iter_196_5, iter_196_6 in pairs(arg_193_1.var_.actorSpriteComps10093:ToTable()) do
						if iter_196_6 then
							if arg_193_1.isInRecall_ then
								local var_196_19 = Mathf.Lerp(iter_196_6.color.r, arg_193_1.hightColor1.r, var_196_18)
								local var_196_20 = Mathf.Lerp(iter_196_6.color.g, arg_193_1.hightColor1.g, var_196_18)
								local var_196_21 = Mathf.Lerp(iter_196_6.color.b, arg_193_1.hightColor1.b, var_196_18)

								iter_196_6.color = Color.New(var_196_19, var_196_20, var_196_21)
							else
								local var_196_22 = Mathf.Lerp(iter_196_6.color.r, 1, var_196_18)

								iter_196_6.color = Color.New(var_196_22, var_196_22, var_196_22)
							end
						end
					end
				end
			end

			if arg_193_1.time_ >= var_196_16 + var_196_17 and arg_193_1.time_ < var_196_16 + var_196_17 + arg_196_0 and not isNil(var_196_15) and arg_193_1.var_.actorSpriteComps10093 then
				for iter_196_7, iter_196_8 in pairs(arg_193_1.var_.actorSpriteComps10093:ToTable()) do
					if iter_196_8 then
						if arg_193_1.isInRecall_ then
							iter_196_8.color = arg_193_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_196_8.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_193_1.var_.actorSpriteComps10093 = nil
			end

			local var_196_23 = 0
			local var_196_24 = 0.25

			if var_196_23 < arg_193_1.time_ and arg_193_1.time_ <= var_196_23 + arg_196_0 then
				arg_193_1.talkMaxDuration = 0
				arg_193_1.dialogCg_.alpha = 1

				arg_193_1.dialog_:SetActive(true)
				SetActive(arg_193_1.leftNameGo_, true)

				local var_196_25 = arg_193_1:FormatText(StoryNameCfg[28].name)

				arg_193_1.leftNameTxt_.text = var_196_25

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_193_1.leftNameTxt_.transform)

				arg_193_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_193_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_193_1:RecordName(arg_193_1.leftNameTxt_.text)
				SetActive(arg_193_1.iconTrs_.gameObject, false)
				arg_193_1.callingController_:SetSelectedState("normal")

				local var_196_26 = arg_193_1:GetWordFromCfg(413141048)
				local var_196_27 = arg_193_1:FormatText(var_196_26.content)

				arg_193_1.text_.text = var_196_27

				LuaForUtil.ClearLinePrefixSymbol(arg_193_1.text_)

				local var_196_28 = 10
				local var_196_29 = utf8.len(var_196_27)
				local var_196_30 = var_196_28 <= 0 and var_196_24 or var_196_24 * (var_196_29 / var_196_28)

				if var_196_30 > 0 and var_196_24 < var_196_30 then
					arg_193_1.talkMaxDuration = var_196_30

					if var_196_30 + var_196_23 > arg_193_1.duration_ then
						arg_193_1.duration_ = var_196_30 + var_196_23
					end
				end

				arg_193_1.text_.text = var_196_27
				arg_193_1.typewritter.percent = 0

				arg_193_1.typewritter:SetDirty()
				arg_193_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_413141", "413141048", "story_v_out_413141.awb") ~= 0 then
					local var_196_31 = manager.audio:GetVoiceLength("story_v_out_413141", "413141048", "story_v_out_413141.awb") / 1000

					if var_196_31 + var_196_23 > arg_193_1.duration_ then
						arg_193_1.duration_ = var_196_31 + var_196_23
					end

					if var_196_26.prefab_name ~= "" and arg_193_1.actors_[var_196_26.prefab_name] ~= nil then
						local var_196_32 = LuaForUtil.PlayVoiceWithCriLipsync(arg_193_1.actors_[var_196_26.prefab_name].transform, "story_v_out_413141", "413141048", "story_v_out_413141.awb")

						arg_193_1:RecordAudio("413141048", var_196_32)
						arg_193_1:RecordAudio("413141048", var_196_32)
					else
						arg_193_1:AudioAction("play", "voice", "story_v_out_413141", "413141048", "story_v_out_413141.awb")
					end

					arg_193_1:RecordHistoryTalkVoice("story_v_out_413141", "413141048", "story_v_out_413141.awb")
				end

				arg_193_1:RecordContent(arg_193_1.text_.text)
			end

			local var_196_33 = math.max(var_196_24, arg_193_1.talkMaxDuration)

			if var_196_23 <= arg_193_1.time_ and arg_193_1.time_ < var_196_23 + var_196_33 then
				arg_193_1.typewritter.percent = (arg_193_1.time_ - var_196_23) / var_196_33

				arg_193_1.typewritter:SetDirty()
			end

			if arg_193_1.time_ >= var_196_23 + var_196_33 and arg_193_1.time_ < var_196_23 + var_196_33 + arg_196_0 then
				arg_193_1.typewritter.percent = 1

				arg_193_1.typewritter:SetDirty()
				arg_193_1:ShowNextGo(true)
			end
		end

		arg_193_1.nodeConfigList_ = {
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

		arg_193_1:InitPlayNodeList()
	end,
	Play413141049 = function(arg_197_0, arg_197_1)
		arg_197_1.time_ = 0
		arg_197_1.frameCnt_ = 0
		arg_197_1.state_ = "playing"
		arg_197_1.curTalkId_ = 413141049
		arg_197_1.duration_ = 15.6

		local var_197_0 = {
			zh = 8.233,
			ja = 15.6
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
				arg_197_0:Play413141050(arg_197_1)
			end
		end

		function arg_197_1.onSingleLineUpdate_(arg_200_0)
			local var_200_0 = arg_197_1.actors_["10092_1"]
			local var_200_1 = 0

			if var_200_1 < arg_197_1.time_ and arg_197_1.time_ <= var_200_1 + arg_200_0 and not isNil(var_200_0) and arg_197_1.var_.actorSpriteComps10092_1 == nil then
				arg_197_1.var_.actorSpriteComps10092_1 = var_200_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_200_2 = 2

			if var_200_1 <= arg_197_1.time_ and arg_197_1.time_ < var_200_1 + var_200_2 and not isNil(var_200_0) then
				local var_200_3 = (arg_197_1.time_ - var_200_1) / var_200_2

				if arg_197_1.var_.actorSpriteComps10092_1 then
					for iter_200_0, iter_200_1 in pairs(arg_197_1.var_.actorSpriteComps10092_1:ToTable()) do
						if iter_200_1 then
							if arg_197_1.isInRecall_ then
								local var_200_4 = Mathf.Lerp(iter_200_1.color.r, arg_197_1.hightColor1.r, var_200_3)
								local var_200_5 = Mathf.Lerp(iter_200_1.color.g, arg_197_1.hightColor1.g, var_200_3)
								local var_200_6 = Mathf.Lerp(iter_200_1.color.b, arg_197_1.hightColor1.b, var_200_3)

								iter_200_1.color = Color.New(var_200_4, var_200_5, var_200_6)
							else
								local var_200_7 = Mathf.Lerp(iter_200_1.color.r, 1, var_200_3)

								iter_200_1.color = Color.New(var_200_7, var_200_7, var_200_7)
							end
						end
					end
				end
			end

			if arg_197_1.time_ >= var_200_1 + var_200_2 and arg_197_1.time_ < var_200_1 + var_200_2 + arg_200_0 and not isNil(var_200_0) and arg_197_1.var_.actorSpriteComps10092_1 then
				for iter_200_2, iter_200_3 in pairs(arg_197_1.var_.actorSpriteComps10092_1:ToTable()) do
					if iter_200_3 then
						if arg_197_1.isInRecall_ then
							iter_200_3.color = arg_197_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_200_3.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_197_1.var_.actorSpriteComps10092_1 = nil
			end

			local var_200_8 = arg_197_1.actors_["10093"]
			local var_200_9 = 0

			if var_200_9 < arg_197_1.time_ and arg_197_1.time_ <= var_200_9 + arg_200_0 and not isNil(var_200_8) and arg_197_1.var_.actorSpriteComps10093 == nil then
				arg_197_1.var_.actorSpriteComps10093 = var_200_8:GetComponentsInChildren(typeof(Image), true)
			end

			local var_200_10 = 2

			if var_200_9 <= arg_197_1.time_ and arg_197_1.time_ < var_200_9 + var_200_10 and not isNil(var_200_8) then
				local var_200_11 = (arg_197_1.time_ - var_200_9) / var_200_10

				if arg_197_1.var_.actorSpriteComps10093 then
					for iter_200_4, iter_200_5 in pairs(arg_197_1.var_.actorSpriteComps10093:ToTable()) do
						if iter_200_5 then
							if arg_197_1.isInRecall_ then
								local var_200_12 = Mathf.Lerp(iter_200_5.color.r, arg_197_1.hightColor2.r, var_200_11)
								local var_200_13 = Mathf.Lerp(iter_200_5.color.g, arg_197_1.hightColor2.g, var_200_11)
								local var_200_14 = Mathf.Lerp(iter_200_5.color.b, arg_197_1.hightColor2.b, var_200_11)

								iter_200_5.color = Color.New(var_200_12, var_200_13, var_200_14)
							else
								local var_200_15 = Mathf.Lerp(iter_200_5.color.r, 0.5, var_200_11)

								iter_200_5.color = Color.New(var_200_15, var_200_15, var_200_15)
							end
						end
					end
				end
			end

			if arg_197_1.time_ >= var_200_9 + var_200_10 and arg_197_1.time_ < var_200_9 + var_200_10 + arg_200_0 and not isNil(var_200_8) and arg_197_1.var_.actorSpriteComps10093 then
				for iter_200_6, iter_200_7 in pairs(arg_197_1.var_.actorSpriteComps10093:ToTable()) do
					if iter_200_7 then
						if arg_197_1.isInRecall_ then
							iter_200_7.color = arg_197_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_200_7.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_197_1.var_.actorSpriteComps10093 = nil
			end

			local var_200_16 = 0
			local var_200_17 = 0.675

			if var_200_16 < arg_197_1.time_ and arg_197_1.time_ <= var_200_16 + arg_200_0 then
				arg_197_1.talkMaxDuration = 0
				arg_197_1.dialogCg_.alpha = 1

				arg_197_1.dialog_:SetActive(true)
				SetActive(arg_197_1.leftNameGo_, true)

				local var_200_18 = arg_197_1:FormatText(StoryNameCfg[996].name)

				arg_197_1.leftNameTxt_.text = var_200_18

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_197_1.leftNameTxt_.transform)

				arg_197_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_197_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_197_1:RecordName(arg_197_1.leftNameTxt_.text)
				SetActive(arg_197_1.iconTrs_.gameObject, false)
				arg_197_1.callingController_:SetSelectedState("normal")

				local var_200_19 = arg_197_1:GetWordFromCfg(413141049)
				local var_200_20 = arg_197_1:FormatText(var_200_19.content)

				arg_197_1.text_.text = var_200_20

				LuaForUtil.ClearLinePrefixSymbol(arg_197_1.text_)

				local var_200_21 = 27
				local var_200_22 = utf8.len(var_200_20)
				local var_200_23 = var_200_21 <= 0 and var_200_17 or var_200_17 * (var_200_22 / var_200_21)

				if var_200_23 > 0 and var_200_17 < var_200_23 then
					arg_197_1.talkMaxDuration = var_200_23

					if var_200_23 + var_200_16 > arg_197_1.duration_ then
						arg_197_1.duration_ = var_200_23 + var_200_16
					end
				end

				arg_197_1.text_.text = var_200_20
				arg_197_1.typewritter.percent = 0

				arg_197_1.typewritter:SetDirty()
				arg_197_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_413141", "413141049", "story_v_out_413141.awb") ~= 0 then
					local var_200_24 = manager.audio:GetVoiceLength("story_v_out_413141", "413141049", "story_v_out_413141.awb") / 1000

					if var_200_24 + var_200_16 > arg_197_1.duration_ then
						arg_197_1.duration_ = var_200_24 + var_200_16
					end

					if var_200_19.prefab_name ~= "" and arg_197_1.actors_[var_200_19.prefab_name] ~= nil then
						local var_200_25 = LuaForUtil.PlayVoiceWithCriLipsync(arg_197_1.actors_[var_200_19.prefab_name].transform, "story_v_out_413141", "413141049", "story_v_out_413141.awb")

						arg_197_1:RecordAudio("413141049", var_200_25)
						arg_197_1:RecordAudio("413141049", var_200_25)
					else
						arg_197_1:AudioAction("play", "voice", "story_v_out_413141", "413141049", "story_v_out_413141.awb")
					end

					arg_197_1:RecordHistoryTalkVoice("story_v_out_413141", "413141049", "story_v_out_413141.awb")
				end

				arg_197_1:RecordContent(arg_197_1.text_.text)
			end

			local var_200_26 = math.max(var_200_17, arg_197_1.talkMaxDuration)

			if var_200_16 <= arg_197_1.time_ and arg_197_1.time_ < var_200_16 + var_200_26 then
				arg_197_1.typewritter.percent = (arg_197_1.time_ - var_200_16) / var_200_26

				arg_197_1.typewritter:SetDirty()
			end

			if arg_197_1.time_ >= var_200_16 + var_200_26 and arg_197_1.time_ < var_200_16 + var_200_26 + arg_200_0 then
				arg_197_1.typewritter.percent = 1

				arg_197_1.typewritter:SetDirty()
				arg_197_1:ShowNextGo(true)
			end
		end

		arg_197_1.nodeConfigList_ = {}

		arg_197_1:InitPlayNodeList()
	end,
	Play413141050 = function(arg_201_0, arg_201_1)
		arg_201_1.time_ = 0
		arg_201_1.frameCnt_ = 0
		arg_201_1.state_ = "playing"
		arg_201_1.curTalkId_ = 413141050
		arg_201_1.duration_ = 17.97

		local var_201_0 = {
			zh = 9.933,
			ja = 17.966
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
				arg_201_0:Play413141051(arg_201_1)
			end
		end

		function arg_201_1.onSingleLineUpdate_(arg_204_0)
			local var_204_0 = arg_201_1.actors_["10092_1"].transform
			local var_204_1 = 0

			if var_204_1 < arg_201_1.time_ and arg_201_1.time_ <= var_204_1 + arg_204_0 then
				arg_201_1.var_.moveOldPos10092_1 = var_204_0.localPosition
				var_204_0.localScale = Vector3.New(1, 1, 1)

				arg_201_1:CheckSpriteTmpPos("10092_1", 2)

				local var_204_2 = var_204_0.childCount

				for iter_204_0 = 0, var_204_2 - 1 do
					local var_204_3 = var_204_0:GetChild(iter_204_0)

					if var_204_3.name == "split_4" or not string.find(var_204_3.name, "split") then
						var_204_3.gameObject:SetActive(true)
					else
						var_204_3.gameObject:SetActive(false)
					end
				end
			end

			local var_204_4 = 0.001

			if var_204_1 <= arg_201_1.time_ and arg_201_1.time_ < var_204_1 + var_204_4 then
				local var_204_5 = (arg_201_1.time_ - var_204_1) / var_204_4
				local var_204_6 = Vector3.New(-389.49, -300, -295)

				var_204_0.localPosition = Vector3.Lerp(arg_201_1.var_.moveOldPos10092_1, var_204_6, var_204_5)
			end

			if arg_201_1.time_ >= var_204_1 + var_204_4 and arg_201_1.time_ < var_204_1 + var_204_4 + arg_204_0 then
				var_204_0.localPosition = Vector3.New(-389.49, -300, -295)
			end

			local var_204_7 = arg_201_1.actors_["10092_1"]
			local var_204_8 = 0

			if var_204_8 < arg_201_1.time_ and arg_201_1.time_ <= var_204_8 + arg_204_0 and not isNil(var_204_7) and arg_201_1.var_.actorSpriteComps10092_1 == nil then
				arg_201_1.var_.actorSpriteComps10092_1 = var_204_7:GetComponentsInChildren(typeof(Image), true)
			end

			local var_204_9 = 2

			if var_204_8 <= arg_201_1.time_ and arg_201_1.time_ < var_204_8 + var_204_9 and not isNil(var_204_7) then
				local var_204_10 = (arg_201_1.time_ - var_204_8) / var_204_9

				if arg_201_1.var_.actorSpriteComps10092_1 then
					for iter_204_1, iter_204_2 in pairs(arg_201_1.var_.actorSpriteComps10092_1:ToTable()) do
						if iter_204_2 then
							if arg_201_1.isInRecall_ then
								local var_204_11 = Mathf.Lerp(iter_204_2.color.r, arg_201_1.hightColor1.r, var_204_10)
								local var_204_12 = Mathf.Lerp(iter_204_2.color.g, arg_201_1.hightColor1.g, var_204_10)
								local var_204_13 = Mathf.Lerp(iter_204_2.color.b, arg_201_1.hightColor1.b, var_204_10)

								iter_204_2.color = Color.New(var_204_11, var_204_12, var_204_13)
							else
								local var_204_14 = Mathf.Lerp(iter_204_2.color.r, 1, var_204_10)

								iter_204_2.color = Color.New(var_204_14, var_204_14, var_204_14)
							end
						end
					end
				end
			end

			if arg_201_1.time_ >= var_204_8 + var_204_9 and arg_201_1.time_ < var_204_8 + var_204_9 + arg_204_0 and not isNil(var_204_7) and arg_201_1.var_.actorSpriteComps10092_1 then
				for iter_204_3, iter_204_4 in pairs(arg_201_1.var_.actorSpriteComps10092_1:ToTable()) do
					if iter_204_4 then
						if arg_201_1.isInRecall_ then
							iter_204_4.color = arg_201_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_204_4.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_201_1.var_.actorSpriteComps10092_1 = nil
			end

			local var_204_15 = 0
			local var_204_16 = 1

			if var_204_15 < arg_201_1.time_ and arg_201_1.time_ <= var_204_15 + arg_204_0 then
				arg_201_1.talkMaxDuration = 0
				arg_201_1.dialogCg_.alpha = 1

				arg_201_1.dialog_:SetActive(true)
				SetActive(arg_201_1.leftNameGo_, true)

				local var_204_17 = arg_201_1:FormatText(StoryNameCfg[996].name)

				arg_201_1.leftNameTxt_.text = var_204_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_201_1.leftNameTxt_.transform)

				arg_201_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_201_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_201_1:RecordName(arg_201_1.leftNameTxt_.text)
				SetActive(arg_201_1.iconTrs_.gameObject, false)
				arg_201_1.callingController_:SetSelectedState("normal")

				local var_204_18 = arg_201_1:GetWordFromCfg(413141050)
				local var_204_19 = arg_201_1:FormatText(var_204_18.content)

				arg_201_1.text_.text = var_204_19

				LuaForUtil.ClearLinePrefixSymbol(arg_201_1.text_)

				local var_204_20 = 40
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

				if manager.audio:GetVoiceLength("story_v_out_413141", "413141050", "story_v_out_413141.awb") ~= 0 then
					local var_204_23 = manager.audio:GetVoiceLength("story_v_out_413141", "413141050", "story_v_out_413141.awb") / 1000

					if var_204_23 + var_204_15 > arg_201_1.duration_ then
						arg_201_1.duration_ = var_204_23 + var_204_15
					end

					if var_204_18.prefab_name ~= "" and arg_201_1.actors_[var_204_18.prefab_name] ~= nil then
						local var_204_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_201_1.actors_[var_204_18.prefab_name].transform, "story_v_out_413141", "413141050", "story_v_out_413141.awb")

						arg_201_1:RecordAudio("413141050", var_204_24)
						arg_201_1:RecordAudio("413141050", var_204_24)
					else
						arg_201_1:AudioAction("play", "voice", "story_v_out_413141", "413141050", "story_v_out_413141.awb")
					end

					arg_201_1:RecordHistoryTalkVoice("story_v_out_413141", "413141050", "story_v_out_413141.awb")
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
				actorName = "10092_1",
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
	Play413141051 = function(arg_205_0, arg_205_1)
		arg_205_1.time_ = 0
		arg_205_1.frameCnt_ = 0
		arg_205_1.state_ = "playing"
		arg_205_1.curTalkId_ = 413141051
		arg_205_1.duration_ = 8.4

		SetActive(arg_205_1.tipsGo_, false)

		function arg_205_1.onSingleLineFinish_()
			arg_205_1.onSingleLineUpdate_ = nil
			arg_205_1.onSingleLineFinish_ = nil
			arg_205_1.state_ = "waiting"
		end

		function arg_205_1.playNext_(arg_207_0)
			if arg_207_0 == 1 then
				arg_205_0:Play413141052(arg_205_1)
			end
		end

		function arg_205_1.onSingleLineUpdate_(arg_208_0)
			local var_208_0 = "F10f"

			if arg_205_1.bgs_[var_208_0] == nil then
				local var_208_1 = Object.Instantiate(arg_205_1.paintGo_)

				var_208_1:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. var_208_0)
				var_208_1.name = var_208_0
				var_208_1.transform.parent = arg_205_1.stage_.transform
				var_208_1.transform.localPosition = Vector3.New(0, 100, 0)
				arg_205_1.bgs_[var_208_0] = var_208_1
			end

			local var_208_2 = 1.4

			if var_208_2 < arg_205_1.time_ and arg_205_1.time_ <= var_208_2 + arg_208_0 then
				local var_208_3 = manager.ui.mainCamera.transform.localPosition
				local var_208_4 = Vector3.New(0, 0, 10) + Vector3.New(var_208_3.x, var_208_3.y, 0)
				local var_208_5 = arg_205_1.bgs_.F10f

				var_208_5.transform.localPosition = var_208_4
				var_208_5.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_208_6 = var_208_5:GetComponent("SpriteRenderer")

				if var_208_6 and var_208_6.sprite then
					local var_208_7 = (var_208_5.transform.localPosition - var_208_3).z
					local var_208_8 = manager.ui.mainCameraCom_
					local var_208_9 = 2 * var_208_7 * Mathf.Tan(var_208_8.fieldOfView * 0.5 * Mathf.Deg2Rad)
					local var_208_10 = var_208_9 * var_208_8.aspect
					local var_208_11 = var_208_6.sprite.bounds.size.x
					local var_208_12 = var_208_6.sprite.bounds.size.y
					local var_208_13 = var_208_10 / var_208_11
					local var_208_14 = var_208_9 / var_208_12
					local var_208_15 = var_208_14 < var_208_13 and var_208_13 or var_208_14

					var_208_5.transform.localScale = Vector3.New(var_208_15, var_208_15, 0)
				end

				for iter_208_0, iter_208_1 in pairs(arg_205_1.bgs_) do
					if iter_208_0 ~= "F10f" then
						iter_208_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_208_16 = 0

			if var_208_16 < arg_205_1.time_ and arg_205_1.time_ <= var_208_16 + arg_208_0 then
				arg_205_1.allBtn_.enabled = false
			end

			local var_208_17 = 0.3

			if arg_205_1.time_ >= var_208_16 + var_208_17 and arg_205_1.time_ < var_208_16 + var_208_17 + arg_208_0 then
				arg_205_1.allBtn_.enabled = true
			end

			local var_208_18 = 0

			if var_208_18 < arg_205_1.time_ and arg_205_1.time_ <= var_208_18 + arg_208_0 then
				arg_205_1.mask_.enabled = true
				arg_205_1.mask_.raycastTarget = true

				arg_205_1:SetGaussion(false)
			end

			local var_208_19 = 1.4

			if var_208_18 <= arg_205_1.time_ and arg_205_1.time_ < var_208_18 + var_208_19 then
				local var_208_20 = (arg_205_1.time_ - var_208_18) / var_208_19
				local var_208_21 = Color.New(0, 0, 0)

				var_208_21.a = Mathf.Lerp(0, 1, var_208_20)
				arg_205_1.mask_.color = var_208_21
			end

			if arg_205_1.time_ >= var_208_18 + var_208_19 and arg_205_1.time_ < var_208_18 + var_208_19 + arg_208_0 then
				local var_208_22 = Color.New(0, 0, 0)

				var_208_22.a = 1
				arg_205_1.mask_.color = var_208_22
			end

			local var_208_23 = 1.4

			if var_208_23 < arg_205_1.time_ and arg_205_1.time_ <= var_208_23 + arg_208_0 then
				arg_205_1.mask_.enabled = true
				arg_205_1.mask_.raycastTarget = true

				arg_205_1:SetGaussion(false)
			end

			local var_208_24 = 2

			if var_208_23 <= arg_205_1.time_ and arg_205_1.time_ < var_208_23 + var_208_24 then
				local var_208_25 = (arg_205_1.time_ - var_208_23) / var_208_24
				local var_208_26 = Color.New(0, 0, 0)

				var_208_26.a = Mathf.Lerp(1, 0, var_208_25)
				arg_205_1.mask_.color = var_208_26
			end

			if arg_205_1.time_ >= var_208_23 + var_208_24 and arg_205_1.time_ < var_208_23 + var_208_24 + arg_208_0 then
				local var_208_27 = Color.New(0, 0, 0)
				local var_208_28 = 0

				arg_205_1.mask_.enabled = false
				var_208_27.a = var_208_28
				arg_205_1.mask_.color = var_208_27
			end

			local var_208_29 = arg_205_1.actors_["10092_1"].transform
			local var_208_30 = 1.4

			if var_208_30 < arg_205_1.time_ and arg_205_1.time_ <= var_208_30 + arg_208_0 then
				arg_205_1.var_.moveOldPos10092_1 = var_208_29.localPosition
				var_208_29.localScale = Vector3.New(1, 1, 1)

				arg_205_1:CheckSpriteTmpPos("10092_1", 6)

				local var_208_31 = var_208_29.childCount

				for iter_208_2 = 0, var_208_31 - 1 do
					local var_208_32 = var_208_29:GetChild(iter_208_2)

					if var_208_32.name == "" or not string.find(var_208_32.name, "split") then
						var_208_32.gameObject:SetActive(true)
					else
						var_208_32.gameObject:SetActive(false)
					end
				end
			end

			local var_208_33 = 0.001

			if var_208_30 <= arg_205_1.time_ and arg_205_1.time_ < var_208_30 + var_208_33 then
				local var_208_34 = (arg_205_1.time_ - var_208_30) / var_208_33
				local var_208_35 = Vector3.New(1500, -300, -295)

				var_208_29.localPosition = Vector3.Lerp(arg_205_1.var_.moveOldPos10092_1, var_208_35, var_208_34)
			end

			if arg_205_1.time_ >= var_208_30 + var_208_33 and arg_205_1.time_ < var_208_30 + var_208_33 + arg_208_0 then
				var_208_29.localPosition = Vector3.New(1500, -300, -295)
			end

			local var_208_36 = arg_205_1.actors_["10093"].transform
			local var_208_37 = 1.4

			if var_208_37 < arg_205_1.time_ and arg_205_1.time_ <= var_208_37 + arg_208_0 then
				arg_205_1.var_.moveOldPos10093 = var_208_36.localPosition
				var_208_36.localScale = Vector3.New(1, 1, 1)

				arg_205_1:CheckSpriteTmpPos("10093", 6)

				local var_208_38 = var_208_36.childCount

				for iter_208_3 = 0, var_208_38 - 1 do
					local var_208_39 = var_208_36:GetChild(iter_208_3)

					if var_208_39.name == "" or not string.find(var_208_39.name, "split") then
						var_208_39.gameObject:SetActive(true)
					else
						var_208_39.gameObject:SetActive(false)
					end
				end
			end

			local var_208_40 = 0.001

			if var_208_37 <= arg_205_1.time_ and arg_205_1.time_ < var_208_37 + var_208_40 then
				local var_208_41 = (arg_205_1.time_ - var_208_37) / var_208_40
				local var_208_42 = Vector3.New(1500, -345, -245)

				var_208_36.localPosition = Vector3.Lerp(arg_205_1.var_.moveOldPos10093, var_208_42, var_208_41)
			end

			if arg_205_1.time_ >= var_208_37 + var_208_40 and arg_205_1.time_ < var_208_37 + var_208_40 + arg_208_0 then
				var_208_36.localPosition = Vector3.New(1500, -345, -245)
			end

			local var_208_43 = arg_205_1.actors_["10092_1"]
			local var_208_44 = 1.4

			if var_208_44 < arg_205_1.time_ and arg_205_1.time_ <= var_208_44 + arg_208_0 and not isNil(var_208_43) and arg_205_1.var_.actorSpriteComps10092_1 == nil then
				arg_205_1.var_.actorSpriteComps10092_1 = var_208_43:GetComponentsInChildren(typeof(Image), true)
			end

			local var_208_45 = 2

			if var_208_44 <= arg_205_1.time_ and arg_205_1.time_ < var_208_44 + var_208_45 and not isNil(var_208_43) then
				local var_208_46 = (arg_205_1.time_ - var_208_44) / var_208_45

				if arg_205_1.var_.actorSpriteComps10092_1 then
					for iter_208_4, iter_208_5 in pairs(arg_205_1.var_.actorSpriteComps10092_1:ToTable()) do
						if iter_208_5 then
							if arg_205_1.isInRecall_ then
								local var_208_47 = Mathf.Lerp(iter_208_5.color.r, arg_205_1.hightColor2.r, var_208_46)
								local var_208_48 = Mathf.Lerp(iter_208_5.color.g, arg_205_1.hightColor2.g, var_208_46)
								local var_208_49 = Mathf.Lerp(iter_208_5.color.b, arg_205_1.hightColor2.b, var_208_46)

								iter_208_5.color = Color.New(var_208_47, var_208_48, var_208_49)
							else
								local var_208_50 = Mathf.Lerp(iter_208_5.color.r, 0.5, var_208_46)

								iter_208_5.color = Color.New(var_208_50, var_208_50, var_208_50)
							end
						end
					end
				end
			end

			if arg_205_1.time_ >= var_208_44 + var_208_45 and arg_205_1.time_ < var_208_44 + var_208_45 + arg_208_0 and not isNil(var_208_43) and arg_205_1.var_.actorSpriteComps10092_1 then
				for iter_208_6, iter_208_7 in pairs(arg_205_1.var_.actorSpriteComps10092_1:ToTable()) do
					if iter_208_7 then
						if arg_205_1.isInRecall_ then
							iter_208_7.color = arg_205_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_208_7.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_205_1.var_.actorSpriteComps10092_1 = nil
			end

			local var_208_51 = arg_205_1.actors_["10093"]
			local var_208_52 = 1.4

			if var_208_52 < arg_205_1.time_ and arg_205_1.time_ <= var_208_52 + arg_208_0 and not isNil(var_208_51) and arg_205_1.var_.actorSpriteComps10093 == nil then
				arg_205_1.var_.actorSpriteComps10093 = var_208_51:GetComponentsInChildren(typeof(Image), true)
			end

			local var_208_53 = 2

			if var_208_52 <= arg_205_1.time_ and arg_205_1.time_ < var_208_52 + var_208_53 and not isNil(var_208_51) then
				local var_208_54 = (arg_205_1.time_ - var_208_52) / var_208_53

				if arg_205_1.var_.actorSpriteComps10093 then
					for iter_208_8, iter_208_9 in pairs(arg_205_1.var_.actorSpriteComps10093:ToTable()) do
						if iter_208_9 then
							if arg_205_1.isInRecall_ then
								local var_208_55 = Mathf.Lerp(iter_208_9.color.r, arg_205_1.hightColor2.r, var_208_54)
								local var_208_56 = Mathf.Lerp(iter_208_9.color.g, arg_205_1.hightColor2.g, var_208_54)
								local var_208_57 = Mathf.Lerp(iter_208_9.color.b, arg_205_1.hightColor2.b, var_208_54)

								iter_208_9.color = Color.New(var_208_55, var_208_56, var_208_57)
							else
								local var_208_58 = Mathf.Lerp(iter_208_9.color.r, 0.5, var_208_54)

								iter_208_9.color = Color.New(var_208_58, var_208_58, var_208_58)
							end
						end
					end
				end
			end

			if arg_205_1.time_ >= var_208_52 + var_208_53 and arg_205_1.time_ < var_208_52 + var_208_53 + arg_208_0 and not isNil(var_208_51) and arg_205_1.var_.actorSpriteComps10093 then
				for iter_208_10, iter_208_11 in pairs(arg_205_1.var_.actorSpriteComps10093:ToTable()) do
					if iter_208_11 then
						if arg_205_1.isInRecall_ then
							iter_208_11.color = arg_205_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_208_11.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_205_1.var_.actorSpriteComps10093 = nil
			end

			local var_208_59 = 1.4

			arg_205_1.isInRecall_ = true

			if var_208_59 < arg_205_1.time_ and arg_205_1.time_ <= var_208_59 + arg_208_0 then
				arg_205_1.screenFilterGo_:SetActive(true)

				arg_205_1.screenFilterEffect_.profile = Asset.Load("Effect/Scene/fx_vintageStyle_Profile")
				arg_205_1.hightColor1 = Color.New(0.82, 0.77, 0.62)
				arg_205_1.hightColor2 = Color.New(0.46, 0.43, 0.35)

				for iter_208_12, iter_208_13 in pairs(arg_205_1.actors_) do
					local var_208_60 = iter_208_13:GetComponentsInChildren(typeof(Image), true):ToTable()

					for iter_208_14, iter_208_15 in ipairs(var_208_60) do
						if iter_208_15.color.r > 0.51 then
							iter_208_15.color = Color.New(0.82, 0.77, 0.62)
						else
							iter_208_15.color = Color.New(0.46, 0.43, 0.35)
						end
					end
				end
			end

			local var_208_61 = 0.034

			if var_208_59 <= arg_205_1.time_ and arg_205_1.time_ < var_208_59 + var_208_61 then
				local var_208_62 = (arg_205_1.time_ - var_208_59) / var_208_61

				arg_205_1.screenFilterEffect_.weight = Mathf.Lerp(0, 1, var_208_62)
			end

			if arg_205_1.time_ >= var_208_59 + var_208_61 and arg_205_1.time_ < var_208_59 + var_208_61 + arg_208_0 then
				arg_205_1.screenFilterEffect_.weight = 1
			end

			if arg_205_1.frameCnt_ <= 1 then
				arg_205_1.dialog_:SetActive(false)
			end

			local var_208_63 = 3.4
			local var_208_64 = 0.825

			if var_208_63 < arg_205_1.time_ and arg_205_1.time_ <= var_208_63 + arg_208_0 then
				arg_205_1.talkMaxDuration = 0

				arg_205_1.dialog_:SetActive(true)

				arg_205_1.dialogCg_.alpha = 0

				local var_208_65 = LeanTween.value(arg_205_1.dialog_, 0, 1, 0.3)

				var_208_65:setOnUpdate(LuaHelper.FloatAction(function(arg_209_0)
					arg_205_1.dialogCg_.alpha = arg_209_0
				end))
				var_208_65:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_205_1.dialog_)
					var_208_65:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_205_1.duration_ = arg_205_1.duration_ + 0.3

				SetActive(arg_205_1.leftNameGo_, false)

				arg_205_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_205_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_205_1:RecordName(arg_205_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_205_1.iconTrs_.gameObject, false)
				arg_205_1.callingController_:SetSelectedState("normal")

				local var_208_66 = arg_205_1:GetWordFromCfg(413141051)
				local var_208_67 = arg_205_1:FormatText(var_208_66.content)

				arg_205_1.text_.text = var_208_67

				LuaForUtil.ClearLinePrefixSymbol(arg_205_1.text_)

				local var_208_68 = 33
				local var_208_69 = utf8.len(var_208_67)
				local var_208_70 = var_208_68 <= 0 and var_208_64 or var_208_64 * (var_208_69 / var_208_68)

				if var_208_70 > 0 and var_208_64 < var_208_70 then
					arg_205_1.talkMaxDuration = var_208_70
					var_208_63 = var_208_63 + 0.3

					if var_208_70 + var_208_63 > arg_205_1.duration_ then
						arg_205_1.duration_ = var_208_70 + var_208_63
					end
				end

				arg_205_1.text_.text = var_208_67
				arg_205_1.typewritter.percent = 0

				arg_205_1.typewritter:SetDirty()
				arg_205_1:ShowNextGo(false)
				arg_205_1:RecordContent(arg_205_1.text_.text)
			end

			local var_208_71 = var_208_63 + 0.3
			local var_208_72 = math.max(var_208_64, arg_205_1.talkMaxDuration)

			if var_208_71 <= arg_205_1.time_ and arg_205_1.time_ < var_208_71 + var_208_72 then
				arg_205_1.typewritter.percent = (arg_205_1.time_ - var_208_71) / var_208_72

				arg_205_1.typewritter:SetDirty()
			end

			if arg_205_1.time_ >= var_208_71 + var_208_72 and arg_205_1.time_ < var_208_71 + var_208_72 + arg_208_0 then
				arg_205_1.typewritter.percent = 1

				arg_205_1.typewritter:SetDirty()
				arg_205_1:ShowNextGo(true)
			end
		end

		arg_205_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10092_1",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 1.4,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			},
			{
				assetPath = "",
				actorName = "10093",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 1.4,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_205_1:InitPlayNodeList()
	end,
	Play413141052 = function(arg_211_0, arg_211_1)
		arg_211_1.time_ = 0
		arg_211_1.frameCnt_ = 0
		arg_211_1.state_ = "playing"
		arg_211_1.curTalkId_ = 413141052
		arg_211_1.duration_ = 5

		SetActive(arg_211_1.tipsGo_, false)

		function arg_211_1.onSingleLineFinish_()
			arg_211_1.onSingleLineUpdate_ = nil
			arg_211_1.onSingleLineFinish_ = nil
			arg_211_1.state_ = "waiting"
		end

		function arg_211_1.playNext_(arg_213_0)
			if arg_213_0 == 1 then
				arg_211_0:Play413141053(arg_211_1)
			end
		end

		function arg_211_1.onSingleLineUpdate_(arg_214_0)
			local var_214_0 = 0
			local var_214_1 = 1.025

			if var_214_0 < arg_211_1.time_ and arg_211_1.time_ <= var_214_0 + arg_214_0 then
				arg_211_1.talkMaxDuration = 0
				arg_211_1.dialogCg_.alpha = 1

				arg_211_1.dialog_:SetActive(true)
				SetActive(arg_211_1.leftNameGo_, false)

				arg_211_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_211_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_211_1:RecordName(arg_211_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_211_1.iconTrs_.gameObject, false)
				arg_211_1.callingController_:SetSelectedState("normal")

				local var_214_2 = arg_211_1:GetWordFromCfg(413141052)
				local var_214_3 = arg_211_1:FormatText(var_214_2.content)

				arg_211_1.text_.text = var_214_3

				LuaForUtil.ClearLinePrefixSymbol(arg_211_1.text_)

				local var_214_4 = 41
				local var_214_5 = utf8.len(var_214_3)
				local var_214_6 = var_214_4 <= 0 and var_214_1 or var_214_1 * (var_214_5 / var_214_4)

				if var_214_6 > 0 and var_214_1 < var_214_6 then
					arg_211_1.talkMaxDuration = var_214_6

					if var_214_6 + var_214_0 > arg_211_1.duration_ then
						arg_211_1.duration_ = var_214_6 + var_214_0
					end
				end

				arg_211_1.text_.text = var_214_3
				arg_211_1.typewritter.percent = 0

				arg_211_1.typewritter:SetDirty()
				arg_211_1:ShowNextGo(false)
				arg_211_1:RecordContent(arg_211_1.text_.text)
			end

			local var_214_7 = math.max(var_214_1, arg_211_1.talkMaxDuration)

			if var_214_0 <= arg_211_1.time_ and arg_211_1.time_ < var_214_0 + var_214_7 then
				arg_211_1.typewritter.percent = (arg_211_1.time_ - var_214_0) / var_214_7

				arg_211_1.typewritter:SetDirty()
			end

			if arg_211_1.time_ >= var_214_0 + var_214_7 and arg_211_1.time_ < var_214_0 + var_214_7 + arg_214_0 then
				arg_211_1.typewritter.percent = 1

				arg_211_1.typewritter:SetDirty()
				arg_211_1:ShowNextGo(true)
			end
		end

		arg_211_1.nodeConfigList_ = {}

		arg_211_1:InitPlayNodeList()
	end,
	Play413141053 = function(arg_215_0, arg_215_1)
		arg_215_1.time_ = 0
		arg_215_1.frameCnt_ = 0
		arg_215_1.state_ = "playing"
		arg_215_1.curTalkId_ = 413141053
		arg_215_1.duration_ = 1.47

		local var_215_0 = {
			zh = 1.033,
			ja = 1.466
		}
		local var_215_1 = manager.audio:GetLocalizationFlag()

		if var_215_0[var_215_1] ~= nil then
			arg_215_1.duration_ = var_215_0[var_215_1]
		end

		SetActive(arg_215_1.tipsGo_, false)

		function arg_215_1.onSingleLineFinish_()
			arg_215_1.onSingleLineUpdate_ = nil
			arg_215_1.onSingleLineFinish_ = nil
			arg_215_1.state_ = "waiting"
		end

		function arg_215_1.playNext_(arg_217_0)
			if arg_217_0 == 1 then
				arg_215_0:Play413141054(arg_215_1)
			end
		end

		function arg_215_1.onSingleLineUpdate_(arg_218_0)
			local var_218_0 = 0
			local var_218_1 = 0.15

			if var_218_0 < arg_215_1.time_ and arg_215_1.time_ <= var_218_0 + arg_218_0 then
				arg_215_1.talkMaxDuration = 0
				arg_215_1.dialogCg_.alpha = 1

				arg_215_1.dialog_:SetActive(true)
				SetActive(arg_215_1.leftNameGo_, true)

				local var_218_2 = arg_215_1:FormatText(StoryNameCfg[996].name)

				arg_215_1.leftNameTxt_.text = var_218_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_215_1.leftNameTxt_.transform)

				arg_215_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_215_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_215_1:RecordName(arg_215_1.leftNameTxt_.text)
				SetActive(arg_215_1.iconTrs_.gameObject, true)
				arg_215_1.iconController_:SetSelectedState("hero")

				arg_215_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_10092_split_3")

				arg_215_1.callingController_:SetSelectedState("normal")

				arg_215_1.keyicon_.color = Color.New(0.82, 0.77, 0.62)
				arg_215_1.icon_.color = Color.New(0.82, 0.77, 0.62)

				local var_218_3 = arg_215_1:GetWordFromCfg(413141053)
				local var_218_4 = arg_215_1:FormatText(var_218_3.content)

				arg_215_1.text_.text = var_218_4

				LuaForUtil.ClearLinePrefixSymbol(arg_215_1.text_)

				local var_218_5 = 6
				local var_218_6 = utf8.len(var_218_4)
				local var_218_7 = var_218_5 <= 0 and var_218_1 or var_218_1 * (var_218_6 / var_218_5)

				if var_218_7 > 0 and var_218_1 < var_218_7 then
					arg_215_1.talkMaxDuration = var_218_7

					if var_218_7 + var_218_0 > arg_215_1.duration_ then
						arg_215_1.duration_ = var_218_7 + var_218_0
					end
				end

				arg_215_1.text_.text = var_218_4
				arg_215_1.typewritter.percent = 0

				arg_215_1.typewritter:SetDirty()
				arg_215_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_413141", "413141053", "story_v_out_413141.awb") ~= 0 then
					local var_218_8 = manager.audio:GetVoiceLength("story_v_out_413141", "413141053", "story_v_out_413141.awb") / 1000

					if var_218_8 + var_218_0 > arg_215_1.duration_ then
						arg_215_1.duration_ = var_218_8 + var_218_0
					end

					if var_218_3.prefab_name ~= "" and arg_215_1.actors_[var_218_3.prefab_name] ~= nil then
						local var_218_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_215_1.actors_[var_218_3.prefab_name].transform, "story_v_out_413141", "413141053", "story_v_out_413141.awb")

						arg_215_1:RecordAudio("413141053", var_218_9)
						arg_215_1:RecordAudio("413141053", var_218_9)
					else
						arg_215_1:AudioAction("play", "voice", "story_v_out_413141", "413141053", "story_v_out_413141.awb")
					end

					arg_215_1:RecordHistoryTalkVoice("story_v_out_413141", "413141053", "story_v_out_413141.awb")
				end

				arg_215_1:RecordContent(arg_215_1.text_.text)
			end

			local var_218_10 = math.max(var_218_1, arg_215_1.talkMaxDuration)

			if var_218_0 <= arg_215_1.time_ and arg_215_1.time_ < var_218_0 + var_218_10 then
				arg_215_1.typewritter.percent = (arg_215_1.time_ - var_218_0) / var_218_10

				arg_215_1.typewritter:SetDirty()
			end

			if arg_215_1.time_ >= var_218_0 + var_218_10 and arg_215_1.time_ < var_218_0 + var_218_10 + arg_218_0 then
				arg_215_1.typewritter.percent = 1

				arg_215_1.typewritter:SetDirty()
				arg_215_1:ShowNextGo(true)
			end
		end

		arg_215_1.nodeConfigList_ = {}

		arg_215_1:InitPlayNodeList()
	end,
	Play413141054 = function(arg_219_0, arg_219_1)
		arg_219_1.time_ = 0
		arg_219_1.frameCnt_ = 0
		arg_219_1.state_ = "playing"
		arg_219_1.curTalkId_ = 413141054
		arg_219_1.duration_ = 5.9

		SetActive(arg_219_1.tipsGo_, false)

		function arg_219_1.onSingleLineFinish_()
			arg_219_1.onSingleLineUpdate_ = nil
			arg_219_1.onSingleLineFinish_ = nil
			arg_219_1.state_ = "waiting"
		end

		function arg_219_1.playNext_(arg_221_0)
			if arg_221_0 == 1 then
				arg_219_0:Play413141055(arg_219_1)
			end
		end

		function arg_219_1.onSingleLineUpdate_(arg_222_0)
			local var_222_0 = 0

			if var_222_0 < arg_219_1.time_ and arg_219_1.time_ <= var_222_0 + arg_222_0 then
				arg_219_1.mask_.enabled = true
				arg_219_1.mask_.raycastTarget = true

				arg_219_1:SetGaussion(false)
			end

			local var_222_1 = 0.633333333333333

			if var_222_0 <= arg_219_1.time_ and arg_219_1.time_ < var_222_0 + var_222_1 then
				local var_222_2 = (arg_219_1.time_ - var_222_0) / var_222_1
				local var_222_3 = Color.New(1, 1, 1)

				var_222_3.a = Mathf.Lerp(1, 0, var_222_2)
				arg_219_1.mask_.color = var_222_3
			end

			if arg_219_1.time_ >= var_222_0 + var_222_1 and arg_219_1.time_ < var_222_0 + var_222_1 + arg_222_0 then
				local var_222_4 = Color.New(1, 1, 1)
				local var_222_5 = 0

				arg_219_1.mask_.enabled = false
				var_222_4.a = var_222_5
				arg_219_1.mask_.color = var_222_4
			end

			if arg_219_1.frameCnt_ <= 1 then
				arg_219_1.dialog_:SetActive(false)
			end

			local var_222_6 = 0.9
			local var_222_7 = 0.95

			if var_222_6 < arg_219_1.time_ and arg_219_1.time_ <= var_222_6 + arg_222_0 then
				arg_219_1.talkMaxDuration = 0

				arg_219_1.dialog_:SetActive(true)

				arg_219_1.dialogCg_.alpha = 0

				local var_222_8 = LeanTween.value(arg_219_1.dialog_, 0, 1, 0.3)

				var_222_8:setOnUpdate(LuaHelper.FloatAction(function(arg_223_0)
					arg_219_1.dialogCg_.alpha = arg_223_0
				end))
				var_222_8:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_219_1.dialog_)
					var_222_8:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_219_1.duration_ = arg_219_1.duration_ + 0.3

				SetActive(arg_219_1.leftNameGo_, false)

				arg_219_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_219_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_219_1:RecordName(arg_219_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_219_1.iconTrs_.gameObject, false)
				arg_219_1.callingController_:SetSelectedState("normal")

				local var_222_9 = arg_219_1:GetWordFromCfg(413141054)
				local var_222_10 = arg_219_1:FormatText(var_222_9.content)

				arg_219_1.text_.text = var_222_10

				LuaForUtil.ClearLinePrefixSymbol(arg_219_1.text_)

				local var_222_11 = 38
				local var_222_12 = utf8.len(var_222_10)
				local var_222_13 = var_222_11 <= 0 and var_222_7 or var_222_7 * (var_222_12 / var_222_11)

				if var_222_13 > 0 and var_222_7 < var_222_13 then
					arg_219_1.talkMaxDuration = var_222_13
					var_222_6 = var_222_6 + 0.3

					if var_222_13 + var_222_6 > arg_219_1.duration_ then
						arg_219_1.duration_ = var_222_13 + var_222_6
					end
				end

				arg_219_1.text_.text = var_222_10
				arg_219_1.typewritter.percent = 0

				arg_219_1.typewritter:SetDirty()
				arg_219_1:ShowNextGo(false)
				arg_219_1:RecordContent(arg_219_1.text_.text)
			end

			local var_222_14 = var_222_6 + 0.3
			local var_222_15 = math.max(var_222_7, arg_219_1.talkMaxDuration)

			if var_222_14 <= arg_219_1.time_ and arg_219_1.time_ < var_222_14 + var_222_15 then
				arg_219_1.typewritter.percent = (arg_219_1.time_ - var_222_14) / var_222_15

				arg_219_1.typewritter:SetDirty()
			end

			if arg_219_1.time_ >= var_222_14 + var_222_15 and arg_219_1.time_ < var_222_14 + var_222_15 + arg_222_0 then
				arg_219_1.typewritter.percent = 1

				arg_219_1.typewritter:SetDirty()
				arg_219_1:ShowNextGo(true)
			end
		end

		arg_219_1.nodeConfigList_ = {}

		arg_219_1:InitPlayNodeList()
	end,
	Play413141055 = function(arg_225_0, arg_225_1)
		arg_225_1.time_ = 0
		arg_225_1.frameCnt_ = 0
		arg_225_1.state_ = "playing"
		arg_225_1.curTalkId_ = 413141055
		arg_225_1.duration_ = 8.97

		local var_225_0 = {
			zh = 5.4,
			ja = 8.966
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
				arg_225_0:Play413141056(arg_225_1)
			end
		end

		function arg_225_1.onSingleLineUpdate_(arg_228_0)
			local var_228_0 = 0
			local var_228_1 = 0.25

			if var_228_0 < arg_225_1.time_ and arg_225_1.time_ <= var_228_0 + arg_228_0 then
				arg_225_1.talkMaxDuration = 0
				arg_225_1.dialogCg_.alpha = 1

				arg_225_1.dialog_:SetActive(true)
				SetActive(arg_225_1.leftNameGo_, true)

				local var_228_2 = arg_225_1:FormatText(StoryNameCfg[1004].name)

				arg_225_1.leftNameTxt_.text = var_228_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_225_1.leftNameTxt_.transform)

				arg_225_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_225_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_225_1:RecordName(arg_225_1.leftNameTxt_.text)
				SetActive(arg_225_1.iconTrs_.gameObject, true)
				arg_225_1.iconController_:SetSelectedState("hero")

				arg_225_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_ilyina")

				arg_225_1.callingController_:SetSelectedState("normal")

				arg_225_1.keyicon_.color = Color.New(0.82, 0.77, 0.62)
				arg_225_1.icon_.color = Color.New(0.82, 0.77, 0.62)

				local var_228_3 = arg_225_1:GetWordFromCfg(413141055)
				local var_228_4 = arg_225_1:FormatText(var_228_3.content)

				arg_225_1.text_.text = var_228_4

				LuaForUtil.ClearLinePrefixSymbol(arg_225_1.text_)

				local var_228_5 = 10
				local var_228_6 = utf8.len(var_228_4)
				local var_228_7 = var_228_5 <= 0 and var_228_1 or var_228_1 * (var_228_6 / var_228_5)

				if var_228_7 > 0 and var_228_1 < var_228_7 then
					arg_225_1.talkMaxDuration = var_228_7

					if var_228_7 + var_228_0 > arg_225_1.duration_ then
						arg_225_1.duration_ = var_228_7 + var_228_0
					end
				end

				arg_225_1.text_.text = var_228_4
				arg_225_1.typewritter.percent = 0

				arg_225_1.typewritter:SetDirty()
				arg_225_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_413141", "413141055", "story_v_out_413141.awb") ~= 0 then
					local var_228_8 = manager.audio:GetVoiceLength("story_v_out_413141", "413141055", "story_v_out_413141.awb") / 1000

					if var_228_8 + var_228_0 > arg_225_1.duration_ then
						arg_225_1.duration_ = var_228_8 + var_228_0
					end

					if var_228_3.prefab_name ~= "" and arg_225_1.actors_[var_228_3.prefab_name] ~= nil then
						local var_228_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_225_1.actors_[var_228_3.prefab_name].transform, "story_v_out_413141", "413141055", "story_v_out_413141.awb")

						arg_225_1:RecordAudio("413141055", var_228_9)
						arg_225_1:RecordAudio("413141055", var_228_9)
					else
						arg_225_1:AudioAction("play", "voice", "story_v_out_413141", "413141055", "story_v_out_413141.awb")
					end

					arg_225_1:RecordHistoryTalkVoice("story_v_out_413141", "413141055", "story_v_out_413141.awb")
				end

				arg_225_1:RecordContent(arg_225_1.text_.text)
			end

			local var_228_10 = math.max(var_228_1, arg_225_1.talkMaxDuration)

			if var_228_0 <= arg_225_1.time_ and arg_225_1.time_ < var_228_0 + var_228_10 then
				arg_225_1.typewritter.percent = (arg_225_1.time_ - var_228_0) / var_228_10

				arg_225_1.typewritter:SetDirty()
			end

			if arg_225_1.time_ >= var_228_0 + var_228_10 and arg_225_1.time_ < var_228_0 + var_228_10 + arg_228_0 then
				arg_225_1.typewritter.percent = 1

				arg_225_1.typewritter:SetDirty()
				arg_225_1:ShowNextGo(true)
			end
		end

		arg_225_1.nodeConfigList_ = {}

		arg_225_1:InitPlayNodeList()
	end,
	Play413141056 = function(arg_229_0, arg_229_1)
		arg_229_1.time_ = 0
		arg_229_1.frameCnt_ = 0
		arg_229_1.state_ = "playing"
		arg_229_1.curTalkId_ = 413141056
		arg_229_1.duration_ = 5

		SetActive(arg_229_1.tipsGo_, false)

		function arg_229_1.onSingleLineFinish_()
			arg_229_1.onSingleLineUpdate_ = nil
			arg_229_1.onSingleLineFinish_ = nil
			arg_229_1.state_ = "waiting"
		end

		function arg_229_1.playNext_(arg_231_0)
			if arg_231_0 == 1 then
				arg_229_0:Play413141057(arg_229_1)
			end
		end

		function arg_229_1.onSingleLineUpdate_(arg_232_0)
			local var_232_0 = 0
			local var_232_1 = 0.825

			if var_232_0 < arg_229_1.time_ and arg_229_1.time_ <= var_232_0 + arg_232_0 then
				arg_229_1.talkMaxDuration = 0
				arg_229_1.dialogCg_.alpha = 1

				arg_229_1.dialog_:SetActive(true)
				SetActive(arg_229_1.leftNameGo_, false)

				arg_229_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_229_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_229_1:RecordName(arg_229_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_229_1.iconTrs_.gameObject, false)
				arg_229_1.callingController_:SetSelectedState("normal")

				local var_232_2 = arg_229_1:GetWordFromCfg(413141056)
				local var_232_3 = arg_229_1:FormatText(var_232_2.content)

				arg_229_1.text_.text = var_232_3

				LuaForUtil.ClearLinePrefixSymbol(arg_229_1.text_)

				local var_232_4 = 33
				local var_232_5 = utf8.len(var_232_3)
				local var_232_6 = var_232_4 <= 0 and var_232_1 or var_232_1 * (var_232_5 / var_232_4)

				if var_232_6 > 0 and var_232_1 < var_232_6 then
					arg_229_1.talkMaxDuration = var_232_6

					if var_232_6 + var_232_0 > arg_229_1.duration_ then
						arg_229_1.duration_ = var_232_6 + var_232_0
					end
				end

				arg_229_1.text_.text = var_232_3
				arg_229_1.typewritter.percent = 0

				arg_229_1.typewritter:SetDirty()
				arg_229_1:ShowNextGo(false)
				arg_229_1:RecordContent(arg_229_1.text_.text)
			end

			local var_232_7 = math.max(var_232_1, arg_229_1.talkMaxDuration)

			if var_232_0 <= arg_229_1.time_ and arg_229_1.time_ < var_232_0 + var_232_7 then
				arg_229_1.typewritter.percent = (arg_229_1.time_ - var_232_0) / var_232_7

				arg_229_1.typewritter:SetDirty()
			end

			if arg_229_1.time_ >= var_232_0 + var_232_7 and arg_229_1.time_ < var_232_0 + var_232_7 + arg_232_0 then
				arg_229_1.typewritter.percent = 1

				arg_229_1.typewritter:SetDirty()
				arg_229_1:ShowNextGo(true)
			end
		end

		arg_229_1.nodeConfigList_ = {}

		arg_229_1:InitPlayNodeList()
	end,
	Play413141057 = function(arg_233_0, arg_233_1)
		arg_233_1.time_ = 0
		arg_233_1.frameCnt_ = 0
		arg_233_1.state_ = "playing"
		arg_233_1.curTalkId_ = 413141057
		arg_233_1.duration_ = 7.5

		SetActive(arg_233_1.tipsGo_, false)

		function arg_233_1.onSingleLineFinish_()
			arg_233_1.onSingleLineUpdate_ = nil
			arg_233_1.onSingleLineFinish_ = nil
			arg_233_1.state_ = "waiting"
		end

		function arg_233_1.playNext_(arg_235_0)
			if arg_235_0 == 1 then
				arg_233_0:Play413141058(arg_233_1)
			end
		end

		function arg_233_1.onSingleLineUpdate_(arg_236_0)
			local var_236_0 = 0

			if var_236_0 < arg_233_1.time_ and arg_233_1.time_ <= var_236_0 + arg_236_0 then
				arg_233_1.mask_.enabled = true
				arg_233_1.mask_.raycastTarget = true

				arg_233_1:SetGaussion(false)
			end

			local var_236_1 = 0.3

			if var_236_0 <= arg_233_1.time_ and arg_233_1.time_ < var_236_0 + var_236_1 then
				local var_236_2 = (arg_233_1.time_ - var_236_0) / var_236_1
				local var_236_3 = Color.New(0, 0, 0)

				var_236_3.a = Mathf.Lerp(0, 1, var_236_2)
				arg_233_1.mask_.color = var_236_3
			end

			if arg_233_1.time_ >= var_236_0 + var_236_1 and arg_233_1.time_ < var_236_0 + var_236_1 + arg_236_0 then
				local var_236_4 = Color.New(0, 0, 0)

				var_236_4.a = 1
				arg_233_1.mask_.color = var_236_4
			end

			local var_236_5 = 0.3

			if var_236_5 < arg_233_1.time_ and arg_233_1.time_ <= var_236_5 + arg_236_0 then
				arg_233_1.mask_.enabled = true
				arg_233_1.mask_.raycastTarget = true

				arg_233_1:SetGaussion(false)
			end

			local var_236_6 = 0.7

			if var_236_5 <= arg_233_1.time_ and arg_233_1.time_ < var_236_5 + var_236_6 then
				local var_236_7 = (arg_233_1.time_ - var_236_5) / var_236_6
				local var_236_8 = Color.New(0, 0, 0)

				var_236_8.a = Mathf.Lerp(1, 0, var_236_7)
				arg_233_1.mask_.color = var_236_8
			end

			if arg_233_1.time_ >= var_236_5 + var_236_6 and arg_233_1.time_ < var_236_5 + var_236_6 + arg_236_0 then
				local var_236_9 = Color.New(0, 0, 0)
				local var_236_10 = 0

				arg_233_1.mask_.enabled = false
				var_236_9.a = var_236_10
				arg_233_1.mask_.color = var_236_9
			end

			local var_236_11 = 1.36666666666667

			if var_236_11 < arg_233_1.time_ and arg_233_1.time_ <= var_236_11 + arg_236_0 then
				arg_233_1.mask_.enabled = true
				arg_233_1.mask_.raycastTarget = true

				arg_233_1:SetGaussion(false)
			end

			local var_236_12 = 0.3

			if var_236_11 <= arg_233_1.time_ and arg_233_1.time_ < var_236_11 + var_236_12 then
				local var_236_13 = (arg_233_1.time_ - var_236_11) / var_236_12
				local var_236_14 = Color.New(0, 0, 0)

				var_236_14.a = Mathf.Lerp(0, 1, var_236_13)
				arg_233_1.mask_.color = var_236_14
			end

			if arg_233_1.time_ >= var_236_11 + var_236_12 and arg_233_1.time_ < var_236_11 + var_236_12 + arg_236_0 then
				local var_236_15 = Color.New(0, 0, 0)

				var_236_15.a = 1
				arg_233_1.mask_.color = var_236_15
			end

			local var_236_16 = 1.66666666666667

			if var_236_16 < arg_233_1.time_ and arg_233_1.time_ <= var_236_16 + arg_236_0 then
				arg_233_1.mask_.enabled = true
				arg_233_1.mask_.raycastTarget = true

				arg_233_1:SetGaussion(false)
			end

			local var_236_17 = 0.833333333333333

			if var_236_16 <= arg_233_1.time_ and arg_233_1.time_ < var_236_16 + var_236_17 then
				local var_236_18 = (arg_233_1.time_ - var_236_16) / var_236_17
				local var_236_19 = Color.New(0, 0, 0)

				var_236_19.a = Mathf.Lerp(1, 0, var_236_18)
				arg_233_1.mask_.color = var_236_19
			end

			if arg_233_1.time_ >= var_236_16 + var_236_17 and arg_233_1.time_ < var_236_16 + var_236_17 + arg_236_0 then
				local var_236_20 = Color.New(0, 0, 0)
				local var_236_21 = 0

				arg_233_1.mask_.enabled = false
				var_236_20.a = var_236_21
				arg_233_1.mask_.color = var_236_20
			end

			local var_236_22 = 0

			if var_236_22 < arg_233_1.time_ and arg_233_1.time_ <= var_236_22 + arg_236_0 then
				arg_233_1.allBtn_.enabled = false
			end

			local var_236_23 = 2.5

			if arg_233_1.time_ >= var_236_22 + var_236_23 and arg_233_1.time_ < var_236_22 + var_236_23 + arg_236_0 then
				arg_233_1.allBtn_.enabled = true
			end

			if arg_233_1.frameCnt_ <= 1 then
				arg_233_1.dialog_:SetActive(false)
			end

			local var_236_24 = 2.5
			local var_236_25 = 1.15

			if var_236_24 < arg_233_1.time_ and arg_233_1.time_ <= var_236_24 + arg_236_0 then
				arg_233_1.talkMaxDuration = 0

				arg_233_1.dialog_:SetActive(true)

				arg_233_1.dialogCg_.alpha = 0

				local var_236_26 = LeanTween.value(arg_233_1.dialog_, 0, 1, 0.3)

				var_236_26:setOnUpdate(LuaHelper.FloatAction(function(arg_237_0)
					arg_233_1.dialogCg_.alpha = arg_237_0
				end))
				var_236_26:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_233_1.dialog_)
					var_236_26:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_233_1.duration_ = arg_233_1.duration_ + 0.3

				SetActive(arg_233_1.leftNameGo_, false)

				arg_233_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_233_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_233_1:RecordName(arg_233_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_233_1.iconTrs_.gameObject, false)
				arg_233_1.callingController_:SetSelectedState("normal")

				local var_236_27 = arg_233_1:GetWordFromCfg(413141057)
				local var_236_28 = arg_233_1:FormatText(var_236_27.content)

				arg_233_1.text_.text = var_236_28

				LuaForUtil.ClearLinePrefixSymbol(arg_233_1.text_)

				local var_236_29 = 46
				local var_236_30 = utf8.len(var_236_28)
				local var_236_31 = var_236_29 <= 0 and var_236_25 or var_236_25 * (var_236_30 / var_236_29)

				if var_236_31 > 0 and var_236_25 < var_236_31 then
					arg_233_1.talkMaxDuration = var_236_31
					var_236_24 = var_236_24 + 0.3

					if var_236_31 + var_236_24 > arg_233_1.duration_ then
						arg_233_1.duration_ = var_236_31 + var_236_24
					end
				end

				arg_233_1.text_.text = var_236_28
				arg_233_1.typewritter.percent = 0

				arg_233_1.typewritter:SetDirty()
				arg_233_1:ShowNextGo(false)
				arg_233_1:RecordContent(arg_233_1.text_.text)
			end

			local var_236_32 = var_236_24 + 0.3
			local var_236_33 = math.max(var_236_25, arg_233_1.talkMaxDuration)

			if var_236_32 <= arg_233_1.time_ and arg_233_1.time_ < var_236_32 + var_236_33 then
				arg_233_1.typewritter.percent = (arg_233_1.time_ - var_236_32) / var_236_33

				arg_233_1.typewritter:SetDirty()
			end

			if arg_233_1.time_ >= var_236_32 + var_236_33 and arg_233_1.time_ < var_236_32 + var_236_33 + arg_236_0 then
				arg_233_1.typewritter.percent = 1

				arg_233_1.typewritter:SetDirty()
				arg_233_1:ShowNextGo(true)
			end
		end

		arg_233_1.nodeConfigList_ = {}

		arg_233_1:InitPlayNodeList()
	end,
	Play413141058 = function(arg_239_0, arg_239_1)
		arg_239_1.time_ = 0
		arg_239_1.frameCnt_ = 0
		arg_239_1.state_ = "playing"
		arg_239_1.curTalkId_ = 413141058
		arg_239_1.duration_ = 8.87

		local var_239_0 = {
			zh = 5.966,
			ja = 8.866
		}
		local var_239_1 = manager.audio:GetLocalizationFlag()

		if var_239_0[var_239_1] ~= nil then
			arg_239_1.duration_ = var_239_0[var_239_1]
		end

		SetActive(arg_239_1.tipsGo_, false)

		function arg_239_1.onSingleLineFinish_()
			arg_239_1.onSingleLineUpdate_ = nil
			arg_239_1.onSingleLineFinish_ = nil
			arg_239_1.state_ = "waiting"
		end

		function arg_239_1.playNext_(arg_241_0)
			if arg_241_0 == 1 then
				arg_239_0:Play413141059(arg_239_1)
			end
		end

		function arg_239_1.onSingleLineUpdate_(arg_242_0)
			local var_242_0 = 0
			local var_242_1 = 0.475

			if var_242_0 < arg_239_1.time_ and arg_239_1.time_ <= var_242_0 + arg_242_0 then
				arg_239_1.talkMaxDuration = 0
				arg_239_1.dialogCg_.alpha = 1

				arg_239_1.dialog_:SetActive(true)
				SetActive(arg_239_1.leftNameGo_, true)

				local var_242_2 = arg_239_1:FormatText(StoryNameCfg[1004].name)

				arg_239_1.leftNameTxt_.text = var_242_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_239_1.leftNameTxt_.transform)

				arg_239_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_239_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_239_1:RecordName(arg_239_1.leftNameTxt_.text)
				SetActive(arg_239_1.iconTrs_.gameObject, true)
				arg_239_1.iconController_:SetSelectedState("hero")

				arg_239_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_ilyina")

				arg_239_1.callingController_:SetSelectedState("normal")

				arg_239_1.keyicon_.color = Color.New(0.82, 0.77, 0.62)
				arg_239_1.icon_.color = Color.New(0.82, 0.77, 0.62)

				local var_242_3 = arg_239_1:GetWordFromCfg(413141058)
				local var_242_4 = arg_239_1:FormatText(var_242_3.content)

				arg_239_1.text_.text = var_242_4

				LuaForUtil.ClearLinePrefixSymbol(arg_239_1.text_)

				local var_242_5 = 18
				local var_242_6 = utf8.len(var_242_4)
				local var_242_7 = var_242_5 <= 0 and var_242_1 or var_242_1 * (var_242_6 / var_242_5)

				if var_242_7 > 0 and var_242_1 < var_242_7 then
					arg_239_1.talkMaxDuration = var_242_7

					if var_242_7 + var_242_0 > arg_239_1.duration_ then
						arg_239_1.duration_ = var_242_7 + var_242_0
					end
				end

				arg_239_1.text_.text = var_242_4
				arg_239_1.typewritter.percent = 0

				arg_239_1.typewritter:SetDirty()
				arg_239_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_413141", "413141058", "story_v_out_413141.awb") ~= 0 then
					local var_242_8 = manager.audio:GetVoiceLength("story_v_out_413141", "413141058", "story_v_out_413141.awb") / 1000

					if var_242_8 + var_242_0 > arg_239_1.duration_ then
						arg_239_1.duration_ = var_242_8 + var_242_0
					end

					if var_242_3.prefab_name ~= "" and arg_239_1.actors_[var_242_3.prefab_name] ~= nil then
						local var_242_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_239_1.actors_[var_242_3.prefab_name].transform, "story_v_out_413141", "413141058", "story_v_out_413141.awb")

						arg_239_1:RecordAudio("413141058", var_242_9)
						arg_239_1:RecordAudio("413141058", var_242_9)
					else
						arg_239_1:AudioAction("play", "voice", "story_v_out_413141", "413141058", "story_v_out_413141.awb")
					end

					arg_239_1:RecordHistoryTalkVoice("story_v_out_413141", "413141058", "story_v_out_413141.awb")
				end

				arg_239_1:RecordContent(arg_239_1.text_.text)
			end

			local var_242_10 = math.max(var_242_1, arg_239_1.talkMaxDuration)

			if var_242_0 <= arg_239_1.time_ and arg_239_1.time_ < var_242_0 + var_242_10 then
				arg_239_1.typewritter.percent = (arg_239_1.time_ - var_242_0) / var_242_10

				arg_239_1.typewritter:SetDirty()
			end

			if arg_239_1.time_ >= var_242_0 + var_242_10 and arg_239_1.time_ < var_242_0 + var_242_10 + arg_242_0 then
				arg_239_1.typewritter.percent = 1

				arg_239_1.typewritter:SetDirty()
				arg_239_1:ShowNextGo(true)
			end
		end

		arg_239_1.nodeConfigList_ = {}

		arg_239_1:InitPlayNodeList()
	end,
	Play413141059 = function(arg_243_0, arg_243_1)
		arg_243_1.time_ = 0
		arg_243_1.frameCnt_ = 0
		arg_243_1.state_ = "playing"
		arg_243_1.curTalkId_ = 413141059
		arg_243_1.duration_ = 5

		SetActive(arg_243_1.tipsGo_, false)

		function arg_243_1.onSingleLineFinish_()
			arg_243_1.onSingleLineUpdate_ = nil
			arg_243_1.onSingleLineFinish_ = nil
			arg_243_1.state_ = "waiting"
		end

		function arg_243_1.playNext_(arg_245_0)
			if arg_245_0 == 1 then
				arg_243_0:Play413141060(arg_243_1)
			end
		end

		function arg_243_1.onSingleLineUpdate_(arg_246_0)
			local var_246_0 = 0
			local var_246_1 = 1.05

			if var_246_0 < arg_243_1.time_ and arg_243_1.time_ <= var_246_0 + arg_246_0 then
				arg_243_1.talkMaxDuration = 0
				arg_243_1.dialogCg_.alpha = 1

				arg_243_1.dialog_:SetActive(true)
				SetActive(arg_243_1.leftNameGo_, false)

				arg_243_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_243_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_243_1:RecordName(arg_243_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_243_1.iconTrs_.gameObject, false)
				arg_243_1.callingController_:SetSelectedState("normal")

				local var_246_2 = arg_243_1:GetWordFromCfg(413141059)
				local var_246_3 = arg_243_1:FormatText(var_246_2.content)

				arg_243_1.text_.text = var_246_3

				LuaForUtil.ClearLinePrefixSymbol(arg_243_1.text_)

				local var_246_4 = 42
				local var_246_5 = utf8.len(var_246_3)
				local var_246_6 = var_246_4 <= 0 and var_246_1 or var_246_1 * (var_246_5 / var_246_4)

				if var_246_6 > 0 and var_246_1 < var_246_6 then
					arg_243_1.talkMaxDuration = var_246_6

					if var_246_6 + var_246_0 > arg_243_1.duration_ then
						arg_243_1.duration_ = var_246_6 + var_246_0
					end
				end

				arg_243_1.text_.text = var_246_3
				arg_243_1.typewritter.percent = 0

				arg_243_1.typewritter:SetDirty()
				arg_243_1:ShowNextGo(false)
				arg_243_1:RecordContent(arg_243_1.text_.text)
			end

			local var_246_7 = math.max(var_246_1, arg_243_1.talkMaxDuration)

			if var_246_0 <= arg_243_1.time_ and arg_243_1.time_ < var_246_0 + var_246_7 then
				arg_243_1.typewritter.percent = (arg_243_1.time_ - var_246_0) / var_246_7

				arg_243_1.typewritter:SetDirty()
			end

			if arg_243_1.time_ >= var_246_0 + var_246_7 and arg_243_1.time_ < var_246_0 + var_246_7 + arg_246_0 then
				arg_243_1.typewritter.percent = 1

				arg_243_1.typewritter:SetDirty()
				arg_243_1:ShowNextGo(true)
			end
		end

		arg_243_1.nodeConfigList_ = {}

		arg_243_1:InitPlayNodeList()
	end,
	Play413141060 = function(arg_247_0, arg_247_1)
		arg_247_1.time_ = 0
		arg_247_1.frameCnt_ = 0
		arg_247_1.state_ = "playing"
		arg_247_1.curTalkId_ = 413141060
		arg_247_1.duration_ = 6.57

		SetActive(arg_247_1.tipsGo_, false)

		function arg_247_1.onSingleLineFinish_()
			arg_247_1.onSingleLineUpdate_ = nil
			arg_247_1.onSingleLineFinish_ = nil
			arg_247_1.state_ = "waiting"
		end

		function arg_247_1.playNext_(arg_249_0)
			if arg_249_0 == 1 then
				arg_247_0:Play413141061(arg_247_1)
			end
		end

		function arg_247_1.onSingleLineUpdate_(arg_250_0)
			local var_250_0 = "F10f_blur"

			if arg_247_1.bgs_[var_250_0] == nil then
				local var_250_1 = Object.Instantiate(arg_247_1.blurPaintGo_)
				local var_250_2 = getSpriteWithoutAtlas("TextureConfig/Background/" .. var_250_0)

				var_250_1:GetComponent("SpriteRenderer").sprite = var_250_2
				var_250_1.name = var_250_0
				var_250_1.transform.parent = arg_247_1.stage_.transform
				var_250_1.transform.localPosition = Vector3.New(0, 100, 0)
				arg_247_1.bgs_[var_250_0] = var_250_1
			end

			local var_250_3 = 0
			local var_250_4 = arg_247_1.bgs_[var_250_0]

			if var_250_3 < arg_247_1.time_ and arg_247_1.time_ <= var_250_3 + arg_250_0 then
				local var_250_5 = manager.ui.mainCamera.transform.localPosition
				local var_250_6 = Vector3.New(0, 0, 10) + Vector3.New(var_250_5.x, var_250_5.y, 0)

				var_250_4.transform.localPosition = var_250_6
				var_250_4.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_250_7 = var_250_4:GetComponent("SpriteRenderer")

				if var_250_7 and var_250_7.sprite then
					local var_250_8 = (var_250_4.transform.localPosition - var_250_5).z
					local var_250_9 = manager.ui.mainCameraCom_
					local var_250_10 = 2 * var_250_8 * Mathf.Tan(var_250_9.fieldOfView * 0.5 * Mathf.Deg2Rad)
					local var_250_11 = var_250_10 * var_250_9.aspect
					local var_250_12 = var_250_7.sprite.bounds.size.x
					local var_250_13 = var_250_7.sprite.bounds.size.y
					local var_250_14 = var_250_11 / var_250_12
					local var_250_15 = var_250_10 / var_250_13
					local var_250_16 = var_250_15 < var_250_14 and var_250_14 or var_250_15

					var_250_4.transform.localScale = Vector3.New(var_250_16, var_250_16, 0)
				end
			end

			local var_250_17 = 1.86666666666667

			if var_250_3 <= arg_247_1.time_ and arg_247_1.time_ < var_250_3 + var_250_17 then
				local var_250_18 = (arg_247_1.time_ - var_250_3) / var_250_17
				local var_250_19 = Color.New(1, 1, 1)

				var_250_19.a = Mathf.Lerp(0, 1, var_250_18)

				var_250_4:GetComponent("SpriteRenderer").material:SetColor("_Color", var_250_19)
			end

			local var_250_20 = 0

			if var_250_20 < arg_247_1.time_ and arg_247_1.time_ <= var_250_20 + arg_250_0 then
				arg_247_1.allBtn_.enabled = false
			end

			local var_250_21 = 1.56666666666667

			if arg_247_1.time_ >= var_250_20 + var_250_21 and arg_247_1.time_ < var_250_20 + var_250_21 + arg_250_0 then
				arg_247_1.allBtn_.enabled = true
			end

			if arg_247_1.frameCnt_ <= 1 then
				arg_247_1.dialog_:SetActive(false)
			end

			local var_250_22 = 1.56666666666667
			local var_250_23 = 0.975

			if var_250_22 < arg_247_1.time_ and arg_247_1.time_ <= var_250_22 + arg_250_0 then
				arg_247_1.talkMaxDuration = 0

				arg_247_1.dialog_:SetActive(true)

				arg_247_1.dialogCg_.alpha = 0

				local var_250_24 = LeanTween.value(arg_247_1.dialog_, 0, 1, 0.3)

				var_250_24:setOnUpdate(LuaHelper.FloatAction(function(arg_251_0)
					arg_247_1.dialogCg_.alpha = arg_251_0
				end))
				var_250_24:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_247_1.dialog_)
					var_250_24:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_247_1.duration_ = arg_247_1.duration_ + 0.3

				SetActive(arg_247_1.leftNameGo_, false)

				arg_247_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_247_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_247_1:RecordName(arg_247_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_247_1.iconTrs_.gameObject, false)
				arg_247_1.callingController_:SetSelectedState("normal")

				local var_250_25 = arg_247_1:GetWordFromCfg(413141060)
				local var_250_26 = arg_247_1:FormatText(var_250_25.content)

				arg_247_1.text_.text = var_250_26

				LuaForUtil.ClearLinePrefixSymbol(arg_247_1.text_)

				local var_250_27 = 39
				local var_250_28 = utf8.len(var_250_26)
				local var_250_29 = var_250_27 <= 0 and var_250_23 or var_250_23 * (var_250_28 / var_250_27)

				if var_250_29 > 0 and var_250_23 < var_250_29 then
					arg_247_1.talkMaxDuration = var_250_29
					var_250_22 = var_250_22 + 0.3

					if var_250_29 + var_250_22 > arg_247_1.duration_ then
						arg_247_1.duration_ = var_250_29 + var_250_22
					end
				end

				arg_247_1.text_.text = var_250_26
				arg_247_1.typewritter.percent = 0

				arg_247_1.typewritter:SetDirty()
				arg_247_1:ShowNextGo(false)
				arg_247_1:RecordContent(arg_247_1.text_.text)
			end

			local var_250_30 = var_250_22 + 0.3
			local var_250_31 = math.max(var_250_23, arg_247_1.talkMaxDuration)

			if var_250_30 <= arg_247_1.time_ and arg_247_1.time_ < var_250_30 + var_250_31 then
				arg_247_1.typewritter.percent = (arg_247_1.time_ - var_250_30) / var_250_31

				arg_247_1.typewritter:SetDirty()
			end

			if arg_247_1.time_ >= var_250_30 + var_250_31 and arg_247_1.time_ < var_250_30 + var_250_31 + arg_250_0 then
				arg_247_1.typewritter.percent = 1

				arg_247_1.typewritter:SetDirty()
				arg_247_1:ShowNextGo(true)
			end
		end

		arg_247_1.nodeConfigList_ = {}

		arg_247_1:InitPlayNodeList()
	end,
	Play413141061 = function(arg_253_0, arg_253_1)
		arg_253_1.time_ = 0
		arg_253_1.frameCnt_ = 0
		arg_253_1.state_ = "playing"
		arg_253_1.curTalkId_ = 413141061
		arg_253_1.duration_ = 6.67

		local var_253_0 = {
			zh = 6.666,
			ja = 4.933
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
				arg_253_0:Play413141062(arg_253_1)
			end
		end

		function arg_253_1.onSingleLineUpdate_(arg_256_0)
			local var_256_0 = 0
			local var_256_1 = 0.375

			if var_256_0 < arg_253_1.time_ and arg_253_1.time_ <= var_256_0 + arg_256_0 then
				arg_253_1.talkMaxDuration = 0
				arg_253_1.dialogCg_.alpha = 1

				arg_253_1.dialog_:SetActive(true)
				SetActive(arg_253_1.leftNameGo_, true)

				local var_256_2 = arg_253_1:FormatText(StoryNameCfg[1004].name)

				arg_253_1.leftNameTxt_.text = var_256_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_253_1.leftNameTxt_.transform)

				arg_253_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_253_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_253_1:RecordName(arg_253_1.leftNameTxt_.text)
				SetActive(arg_253_1.iconTrs_.gameObject, true)
				arg_253_1.iconController_:SetSelectedState("hero")

				arg_253_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_ilyina")

				arg_253_1.callingController_:SetSelectedState("normal")

				arg_253_1.keyicon_.color = Color.New(0.82, 0.77, 0.62)
				arg_253_1.icon_.color = Color.New(0.82, 0.77, 0.62)

				local var_256_3 = arg_253_1:GetWordFromCfg(413141061)
				local var_256_4 = arg_253_1:FormatText(var_256_3.content)

				arg_253_1.text_.text = var_256_4

				LuaForUtil.ClearLinePrefixSymbol(arg_253_1.text_)

				local var_256_5 = 15
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

				if manager.audio:GetVoiceLength("story_v_out_413141", "413141061", "story_v_out_413141.awb") ~= 0 then
					local var_256_8 = manager.audio:GetVoiceLength("story_v_out_413141", "413141061", "story_v_out_413141.awb") / 1000

					if var_256_8 + var_256_0 > arg_253_1.duration_ then
						arg_253_1.duration_ = var_256_8 + var_256_0
					end

					if var_256_3.prefab_name ~= "" and arg_253_1.actors_[var_256_3.prefab_name] ~= nil then
						local var_256_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_253_1.actors_[var_256_3.prefab_name].transform, "story_v_out_413141", "413141061", "story_v_out_413141.awb")

						arg_253_1:RecordAudio("413141061", var_256_9)
						arg_253_1:RecordAudio("413141061", var_256_9)
					else
						arg_253_1:AudioAction("play", "voice", "story_v_out_413141", "413141061", "story_v_out_413141.awb")
					end

					arg_253_1:RecordHistoryTalkVoice("story_v_out_413141", "413141061", "story_v_out_413141.awb")
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
	Play413141062 = function(arg_257_0, arg_257_1)
		arg_257_1.time_ = 0
		arg_257_1.frameCnt_ = 0
		arg_257_1.state_ = "playing"
		arg_257_1.curTalkId_ = 413141062
		arg_257_1.duration_ = 5

		SetActive(arg_257_1.tipsGo_, false)

		function arg_257_1.onSingleLineFinish_()
			arg_257_1.onSingleLineUpdate_ = nil
			arg_257_1.onSingleLineFinish_ = nil
			arg_257_1.state_ = "waiting"
		end

		function arg_257_1.playNext_(arg_259_0)
			if arg_259_0 == 1 then
				arg_257_0:Play413141063(arg_257_1)
			end
		end

		function arg_257_1.onSingleLineUpdate_(arg_260_0)
			local var_260_0 = 0
			local var_260_1 = 1.075

			if var_260_0 < arg_257_1.time_ and arg_257_1.time_ <= var_260_0 + arg_260_0 then
				arg_257_1.talkMaxDuration = 0
				arg_257_1.dialogCg_.alpha = 1

				arg_257_1.dialog_:SetActive(true)
				SetActive(arg_257_1.leftNameGo_, false)

				arg_257_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_257_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_257_1:RecordName(arg_257_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_257_1.iconTrs_.gameObject, false)
				arg_257_1.callingController_:SetSelectedState("normal")

				local var_260_2 = arg_257_1:GetWordFromCfg(413141062)
				local var_260_3 = arg_257_1:FormatText(var_260_2.content)

				arg_257_1.text_.text = var_260_3

				LuaForUtil.ClearLinePrefixSymbol(arg_257_1.text_)

				local var_260_4 = 43
				local var_260_5 = utf8.len(var_260_3)
				local var_260_6 = var_260_4 <= 0 and var_260_1 or var_260_1 * (var_260_5 / var_260_4)

				if var_260_6 > 0 and var_260_1 < var_260_6 then
					arg_257_1.talkMaxDuration = var_260_6

					if var_260_6 + var_260_0 > arg_257_1.duration_ then
						arg_257_1.duration_ = var_260_6 + var_260_0
					end
				end

				arg_257_1.text_.text = var_260_3
				arg_257_1.typewritter.percent = 0

				arg_257_1.typewritter:SetDirty()
				arg_257_1:ShowNextGo(false)
				arg_257_1:RecordContent(arg_257_1.text_.text)
			end

			local var_260_7 = math.max(var_260_1, arg_257_1.talkMaxDuration)

			if var_260_0 <= arg_257_1.time_ and arg_257_1.time_ < var_260_0 + var_260_7 then
				arg_257_1.typewritter.percent = (arg_257_1.time_ - var_260_0) / var_260_7

				arg_257_1.typewritter:SetDirty()
			end

			if arg_257_1.time_ >= var_260_0 + var_260_7 and arg_257_1.time_ < var_260_0 + var_260_7 + arg_260_0 then
				arg_257_1.typewritter.percent = 1

				arg_257_1.typewritter:SetDirty()
				arg_257_1:ShowNextGo(true)
			end
		end

		arg_257_1.nodeConfigList_ = {}

		arg_257_1:InitPlayNodeList()
	end,
	Play413141063 = function(arg_261_0, arg_261_1)
		arg_261_1.time_ = 0
		arg_261_1.frameCnt_ = 0
		arg_261_1.state_ = "playing"
		arg_261_1.curTalkId_ = 413141063
		arg_261_1.duration_ = 5

		SetActive(arg_261_1.tipsGo_, false)

		function arg_261_1.onSingleLineFinish_()
			arg_261_1.onSingleLineUpdate_ = nil
			arg_261_1.onSingleLineFinish_ = nil
			arg_261_1.state_ = "waiting"
		end

		function arg_261_1.playNext_(arg_263_0)
			if arg_263_0 == 1 then
				arg_261_0:Play413141064(arg_261_1)
			end
		end

		function arg_261_1.onSingleLineUpdate_(arg_264_0)
			local var_264_0 = 0
			local var_264_1 = 0.725

			if var_264_0 < arg_261_1.time_ and arg_261_1.time_ <= var_264_0 + arg_264_0 then
				arg_261_1.talkMaxDuration = 0

				arg_261_1.dialog_:SetActive(true)

				arg_261_1.dialogCg_.alpha = 0

				local var_264_2 = LeanTween.value(arg_261_1.dialog_, 0, 1, 0.3)

				var_264_2:setOnUpdate(LuaHelper.FloatAction(function(arg_265_0)
					arg_261_1.dialogCg_.alpha = arg_265_0
				end))
				var_264_2:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_261_1.dialog_)
					var_264_2:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_261_1.duration_ = arg_261_1.duration_ + 0.3

				SetActive(arg_261_1.leftNameGo_, false)

				arg_261_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_261_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_261_1:RecordName(arg_261_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_261_1.iconTrs_.gameObject, false)
				arg_261_1.callingController_:SetSelectedState("normal")

				local var_264_3 = arg_261_1:GetWordFromCfg(413141063)
				local var_264_4 = arg_261_1:FormatText(var_264_3.content)

				arg_261_1.text_.text = var_264_4

				LuaForUtil.ClearLinePrefixSymbol(arg_261_1.text_)

				local var_264_5 = 29
				local var_264_6 = utf8.len(var_264_4)
				local var_264_7 = var_264_5 <= 0 and var_264_1 or var_264_1 * (var_264_6 / var_264_5)

				if var_264_7 > 0 and var_264_1 < var_264_7 then
					arg_261_1.talkMaxDuration = var_264_7
					var_264_0 = var_264_0 + 0.3

					if var_264_7 + var_264_0 > arg_261_1.duration_ then
						arg_261_1.duration_ = var_264_7 + var_264_0
					end
				end

				arg_261_1.text_.text = var_264_4
				arg_261_1.typewritter.percent = 0

				arg_261_1.typewritter:SetDirty()
				arg_261_1:ShowNextGo(false)
				arg_261_1:RecordContent(arg_261_1.text_.text)
			end

			local var_264_8 = var_264_0 + 0.3
			local var_264_9 = math.max(var_264_1, arg_261_1.talkMaxDuration)

			if var_264_8 <= arg_261_1.time_ and arg_261_1.time_ < var_264_8 + var_264_9 then
				arg_261_1.typewritter.percent = (arg_261_1.time_ - var_264_8) / var_264_9

				arg_261_1.typewritter:SetDirty()
			end

			if arg_261_1.time_ >= var_264_8 + var_264_9 and arg_261_1.time_ < var_264_8 + var_264_9 + arg_264_0 then
				arg_261_1.typewritter.percent = 1

				arg_261_1.typewritter:SetDirty()
				arg_261_1:ShowNextGo(true)
			end
		end

		arg_261_1.nodeConfigList_ = {}

		arg_261_1:InitPlayNodeList()
	end,
	Play413141064 = function(arg_267_0, arg_267_1)
		arg_267_1.time_ = 0
		arg_267_1.frameCnt_ = 0
		arg_267_1.state_ = "playing"
		arg_267_1.curTalkId_ = 413141064
		arg_267_1.duration_ = 16.3

		local var_267_0 = {
			zh = 11.666,
			ja = 16.3
		}
		local var_267_1 = manager.audio:GetLocalizationFlag()

		if var_267_0[var_267_1] ~= nil then
			arg_267_1.duration_ = var_267_0[var_267_1]
		end

		SetActive(arg_267_1.tipsGo_, false)

		function arg_267_1.onSingleLineFinish_()
			arg_267_1.onSingleLineUpdate_ = nil
			arg_267_1.onSingleLineFinish_ = nil
			arg_267_1.state_ = "waiting"
		end

		function arg_267_1.playNext_(arg_269_0)
			if arg_269_0 == 1 then
				arg_267_0:Play413141065(arg_267_1)
			end
		end

		function arg_267_1.onSingleLineUpdate_(arg_270_0)
			local var_270_0 = 0
			local var_270_1 = 0.65

			if var_270_0 < arg_267_1.time_ and arg_267_1.time_ <= var_270_0 + arg_270_0 then
				arg_267_1.talkMaxDuration = 0
				arg_267_1.dialogCg_.alpha = 1

				arg_267_1.dialog_:SetActive(true)
				SetActive(arg_267_1.leftNameGo_, true)

				local var_270_2 = arg_267_1:FormatText(StoryNameCfg[1004].name)

				arg_267_1.leftNameTxt_.text = var_270_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_267_1.leftNameTxt_.transform)

				arg_267_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_267_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_267_1:RecordName(arg_267_1.leftNameTxt_.text)
				SetActive(arg_267_1.iconTrs_.gameObject, true)
				arg_267_1.iconController_:SetSelectedState("hero")

				arg_267_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_ilyina")

				arg_267_1.callingController_:SetSelectedState("normal")

				arg_267_1.keyicon_.color = Color.New(0.82, 0.77, 0.62)
				arg_267_1.icon_.color = Color.New(0.82, 0.77, 0.62)

				local var_270_3 = arg_267_1:GetWordFromCfg(413141064)
				local var_270_4 = arg_267_1:FormatText(var_270_3.content)

				arg_267_1.text_.text = var_270_4

				LuaForUtil.ClearLinePrefixSymbol(arg_267_1.text_)

				local var_270_5 = 26
				local var_270_6 = utf8.len(var_270_4)
				local var_270_7 = var_270_5 <= 0 and var_270_1 or var_270_1 * (var_270_6 / var_270_5)

				if var_270_7 > 0 and var_270_1 < var_270_7 then
					arg_267_1.talkMaxDuration = var_270_7

					if var_270_7 + var_270_0 > arg_267_1.duration_ then
						arg_267_1.duration_ = var_270_7 + var_270_0
					end
				end

				arg_267_1.text_.text = var_270_4
				arg_267_1.typewritter.percent = 0

				arg_267_1.typewritter:SetDirty()
				arg_267_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_413141", "413141064", "story_v_out_413141.awb") ~= 0 then
					local var_270_8 = manager.audio:GetVoiceLength("story_v_out_413141", "413141064", "story_v_out_413141.awb") / 1000

					if var_270_8 + var_270_0 > arg_267_1.duration_ then
						arg_267_1.duration_ = var_270_8 + var_270_0
					end

					if var_270_3.prefab_name ~= "" and arg_267_1.actors_[var_270_3.prefab_name] ~= nil then
						local var_270_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_267_1.actors_[var_270_3.prefab_name].transform, "story_v_out_413141", "413141064", "story_v_out_413141.awb")

						arg_267_1:RecordAudio("413141064", var_270_9)
						arg_267_1:RecordAudio("413141064", var_270_9)
					else
						arg_267_1:AudioAction("play", "voice", "story_v_out_413141", "413141064", "story_v_out_413141.awb")
					end

					arg_267_1:RecordHistoryTalkVoice("story_v_out_413141", "413141064", "story_v_out_413141.awb")
				end

				arg_267_1:RecordContent(arg_267_1.text_.text)
			end

			local var_270_10 = math.max(var_270_1, arg_267_1.talkMaxDuration)

			if var_270_0 <= arg_267_1.time_ and arg_267_1.time_ < var_270_0 + var_270_10 then
				arg_267_1.typewritter.percent = (arg_267_1.time_ - var_270_0) / var_270_10

				arg_267_1.typewritter:SetDirty()
			end

			if arg_267_1.time_ >= var_270_0 + var_270_10 and arg_267_1.time_ < var_270_0 + var_270_10 + arg_270_0 then
				arg_267_1.typewritter.percent = 1

				arg_267_1.typewritter:SetDirty()
				arg_267_1:ShowNextGo(true)
			end
		end

		arg_267_1.nodeConfigList_ = {}

		arg_267_1:InitPlayNodeList()
	end,
	Play413141065 = function(arg_271_0, arg_271_1)
		arg_271_1.time_ = 0
		arg_271_1.frameCnt_ = 0
		arg_271_1.state_ = "playing"
		arg_271_1.curTalkId_ = 413141065
		arg_271_1.duration_ = 5.3

		local var_271_0 = {
			zh = 1.966,
			ja = 5.3
		}
		local var_271_1 = manager.audio:GetLocalizationFlag()

		if var_271_0[var_271_1] ~= nil then
			arg_271_1.duration_ = var_271_0[var_271_1]
		end

		SetActive(arg_271_1.tipsGo_, false)

		function arg_271_1.onSingleLineFinish_()
			arg_271_1.onSingleLineUpdate_ = nil
			arg_271_1.onSingleLineFinish_ = nil
			arg_271_1.state_ = "waiting"
		end

		function arg_271_1.playNext_(arg_273_0)
			if arg_273_0 == 1 then
				arg_271_0:Play413141066(arg_271_1)
			end
		end

		function arg_271_1.onSingleLineUpdate_(arg_274_0)
			local var_274_0 = 0
			local var_274_1 = 0.15

			if var_274_0 < arg_271_1.time_ and arg_271_1.time_ <= var_274_0 + arg_274_0 then
				arg_271_1.talkMaxDuration = 0
				arg_271_1.dialogCg_.alpha = 1

				arg_271_1.dialog_:SetActive(true)
				SetActive(arg_271_1.leftNameGo_, true)

				local var_274_2 = arg_271_1:FormatText(StoryNameCfg[996].name)

				arg_271_1.leftNameTxt_.text = var_274_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_271_1.leftNameTxt_.transform)

				arg_271_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_271_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_271_1:RecordName(arg_271_1.leftNameTxt_.text)
				SetActive(arg_271_1.iconTrs_.gameObject, true)
				arg_271_1.iconController_:SetSelectedState("hero")

				arg_271_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_10092_1_split_3")

				arg_271_1.callingController_:SetSelectedState("normal")

				arg_271_1.keyicon_.color = Color.New(0.82, 0.77, 0.62)
				arg_271_1.icon_.color = Color.New(0.82, 0.77, 0.62)

				local var_274_3 = arg_271_1:GetWordFromCfg(413141065)
				local var_274_4 = arg_271_1:FormatText(var_274_3.content)

				arg_271_1.text_.text = var_274_4

				LuaForUtil.ClearLinePrefixSymbol(arg_271_1.text_)

				local var_274_5 = 6
				local var_274_6 = utf8.len(var_274_4)
				local var_274_7 = var_274_5 <= 0 and var_274_1 or var_274_1 * (var_274_6 / var_274_5)

				if var_274_7 > 0 and var_274_1 < var_274_7 then
					arg_271_1.talkMaxDuration = var_274_7

					if var_274_7 + var_274_0 > arg_271_1.duration_ then
						arg_271_1.duration_ = var_274_7 + var_274_0
					end
				end

				arg_271_1.text_.text = var_274_4
				arg_271_1.typewritter.percent = 0

				arg_271_1.typewritter:SetDirty()
				arg_271_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_413141", "413141065", "story_v_out_413141.awb") ~= 0 then
					local var_274_8 = manager.audio:GetVoiceLength("story_v_out_413141", "413141065", "story_v_out_413141.awb") / 1000

					if var_274_8 + var_274_0 > arg_271_1.duration_ then
						arg_271_1.duration_ = var_274_8 + var_274_0
					end

					if var_274_3.prefab_name ~= "" and arg_271_1.actors_[var_274_3.prefab_name] ~= nil then
						local var_274_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_271_1.actors_[var_274_3.prefab_name].transform, "story_v_out_413141", "413141065", "story_v_out_413141.awb")

						arg_271_1:RecordAudio("413141065", var_274_9)
						arg_271_1:RecordAudio("413141065", var_274_9)
					else
						arg_271_1:AudioAction("play", "voice", "story_v_out_413141", "413141065", "story_v_out_413141.awb")
					end

					arg_271_1:RecordHistoryTalkVoice("story_v_out_413141", "413141065", "story_v_out_413141.awb")
				end

				arg_271_1:RecordContent(arg_271_1.text_.text)
			end

			local var_274_10 = math.max(var_274_1, arg_271_1.talkMaxDuration)

			if var_274_0 <= arg_271_1.time_ and arg_271_1.time_ < var_274_0 + var_274_10 then
				arg_271_1.typewritter.percent = (arg_271_1.time_ - var_274_0) / var_274_10

				arg_271_1.typewritter:SetDirty()
			end

			if arg_271_1.time_ >= var_274_0 + var_274_10 and arg_271_1.time_ < var_274_0 + var_274_10 + arg_274_0 then
				arg_271_1.typewritter.percent = 1

				arg_271_1.typewritter:SetDirty()
				arg_271_1:ShowNextGo(true)
			end
		end

		arg_271_1.nodeConfigList_ = {}

		arg_271_1:InitPlayNodeList()
	end,
	Play413141066 = function(arg_275_0, arg_275_1)
		arg_275_1.time_ = 0
		arg_275_1.frameCnt_ = 0
		arg_275_1.state_ = "playing"
		arg_275_1.curTalkId_ = 413141066
		arg_275_1.duration_ = 8.93

		local var_275_0 = {
			zh = 8.933,
			ja = 8.6
		}
		local var_275_1 = manager.audio:GetLocalizationFlag()

		if var_275_0[var_275_1] ~= nil then
			arg_275_1.duration_ = var_275_0[var_275_1]
		end

		SetActive(arg_275_1.tipsGo_, false)

		function arg_275_1.onSingleLineFinish_()
			arg_275_1.onSingleLineUpdate_ = nil
			arg_275_1.onSingleLineFinish_ = nil
			arg_275_1.state_ = "waiting"
		end

		function arg_275_1.playNext_(arg_277_0)
			if arg_277_0 == 1 then
				arg_275_0:Play413141067(arg_275_1)
			end
		end

		function arg_275_1.onSingleLineUpdate_(arg_278_0)
			local var_278_0 = 1.6

			if var_278_0 < arg_275_1.time_ and arg_275_1.time_ <= var_278_0 + arg_278_0 then
				local var_278_1 = manager.ui.mainCamera.transform.localPosition
				local var_278_2 = Vector3.New(0, 0, 10) + Vector3.New(var_278_1.x, var_278_1.y, 0)
				local var_278_3 = arg_275_1.bgs_.ST0603a

				var_278_3.transform.localPosition = var_278_2
				var_278_3.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_278_4 = var_278_3:GetComponent("SpriteRenderer")

				if var_278_4 and var_278_4.sprite then
					local var_278_5 = (var_278_3.transform.localPosition - var_278_1).z
					local var_278_6 = manager.ui.mainCameraCom_
					local var_278_7 = 2 * var_278_5 * Mathf.Tan(var_278_6.fieldOfView * 0.5 * Mathf.Deg2Rad)
					local var_278_8 = var_278_7 * var_278_6.aspect
					local var_278_9 = var_278_4.sprite.bounds.size.x
					local var_278_10 = var_278_4.sprite.bounds.size.y
					local var_278_11 = var_278_8 / var_278_9
					local var_278_12 = var_278_7 / var_278_10
					local var_278_13 = var_278_12 < var_278_11 and var_278_11 or var_278_12

					var_278_3.transform.localScale = Vector3.New(var_278_13, var_278_13, 0)
				end

				for iter_278_0, iter_278_1 in pairs(arg_275_1.bgs_) do
					if iter_278_0 ~= "ST0603a" then
						iter_278_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_278_14 = 3.2

			if var_278_14 < arg_275_1.time_ and arg_275_1.time_ <= var_278_14 + arg_278_0 then
				arg_275_1.allBtn_.enabled = false
			end

			local var_278_15 = 0.3

			if arg_275_1.time_ >= var_278_14 + var_278_15 and arg_275_1.time_ < var_278_14 + var_278_15 + arg_278_0 then
				arg_275_1.allBtn_.enabled = true
			end

			local var_278_16 = 0

			if var_278_16 < arg_275_1.time_ and arg_275_1.time_ <= var_278_16 + arg_278_0 then
				arg_275_1.mask_.enabled = true
				arg_275_1.mask_.raycastTarget = true

				arg_275_1:SetGaussion(false)
			end

			local var_278_17 = 1.6

			if var_278_16 <= arg_275_1.time_ and arg_275_1.time_ < var_278_16 + var_278_17 then
				local var_278_18 = (arg_275_1.time_ - var_278_16) / var_278_17
				local var_278_19 = Color.New(1, 1, 1)

				var_278_19.a = Mathf.Lerp(0, 1, var_278_18)
				arg_275_1.mask_.color = var_278_19
			end

			if arg_275_1.time_ >= var_278_16 + var_278_17 and arg_275_1.time_ < var_278_16 + var_278_17 + arg_278_0 then
				local var_278_20 = Color.New(1, 1, 1)

				var_278_20.a = 1
				arg_275_1.mask_.color = var_278_20
			end

			local var_278_21 = 1.6

			if var_278_21 < arg_275_1.time_ and arg_275_1.time_ <= var_278_21 + arg_278_0 then
				arg_275_1.mask_.enabled = true
				arg_275_1.mask_.raycastTarget = true

				arg_275_1:SetGaussion(false)
			end

			local var_278_22 = 1.6

			if var_278_21 <= arg_275_1.time_ and arg_275_1.time_ < var_278_21 + var_278_22 then
				local var_278_23 = (arg_275_1.time_ - var_278_21) / var_278_22
				local var_278_24 = Color.New(1, 1, 1)

				var_278_24.a = Mathf.Lerp(1, 0, var_278_23)
				arg_275_1.mask_.color = var_278_24
			end

			if arg_275_1.time_ >= var_278_21 + var_278_22 and arg_275_1.time_ < var_278_21 + var_278_22 + arg_278_0 then
				local var_278_25 = Color.New(1, 1, 1)
				local var_278_26 = 0

				arg_275_1.mask_.enabled = false
				var_278_25.a = var_278_26
				arg_275_1.mask_.color = var_278_25
			end

			local var_278_27 = arg_275_1.actors_["10092_1"].transform
			local var_278_28 = 2.96666666666667

			if var_278_28 < arg_275_1.time_ and arg_275_1.time_ <= var_278_28 + arg_278_0 then
				arg_275_1.var_.moveOldPos10092_1 = var_278_27.localPosition
				var_278_27.localScale = Vector3.New(1, 1, 1)

				arg_275_1:CheckSpriteTmpPos("10092_1", 3)

				local var_278_29 = var_278_27.childCount

				for iter_278_2 = 0, var_278_29 - 1 do
					local var_278_30 = var_278_27:GetChild(iter_278_2)

					if var_278_30.name == "split_8" or not string.find(var_278_30.name, "split") then
						var_278_30.gameObject:SetActive(true)
					else
						var_278_30.gameObject:SetActive(false)
					end
				end
			end

			local var_278_31 = 0.001

			if var_278_28 <= arg_275_1.time_ and arg_275_1.time_ < var_278_28 + var_278_31 then
				local var_278_32 = (arg_275_1.time_ - var_278_28) / var_278_31
				local var_278_33 = Vector3.New(0, -300, -295)

				var_278_27.localPosition = Vector3.Lerp(arg_275_1.var_.moveOldPos10092_1, var_278_33, var_278_32)
			end

			if arg_275_1.time_ >= var_278_28 + var_278_31 and arg_275_1.time_ < var_278_28 + var_278_31 + arg_278_0 then
				var_278_27.localPosition = Vector3.New(0, -300, -295)
			end

			local var_278_34 = arg_275_1.actors_["10092_1"]
			local var_278_35 = 2.96666666666667

			if var_278_35 < arg_275_1.time_ and arg_275_1.time_ <= var_278_35 + arg_278_0 and not isNil(var_278_34) and arg_275_1.var_.actorSpriteComps10092_1 == nil then
				arg_275_1.var_.actorSpriteComps10092_1 = var_278_34:GetComponentsInChildren(typeof(Image), true)
			end

			local var_278_36 = 2

			if var_278_35 <= arg_275_1.time_ and arg_275_1.time_ < var_278_35 + var_278_36 and not isNil(var_278_34) then
				local var_278_37 = (arg_275_1.time_ - var_278_35) / var_278_36

				if arg_275_1.var_.actorSpriteComps10092_1 then
					for iter_278_3, iter_278_4 in pairs(arg_275_1.var_.actorSpriteComps10092_1:ToTable()) do
						if iter_278_4 then
							if arg_275_1.isInRecall_ then
								local var_278_38 = Mathf.Lerp(iter_278_4.color.r, arg_275_1.hightColor1.r, var_278_37)
								local var_278_39 = Mathf.Lerp(iter_278_4.color.g, arg_275_1.hightColor1.g, var_278_37)
								local var_278_40 = Mathf.Lerp(iter_278_4.color.b, arg_275_1.hightColor1.b, var_278_37)

								iter_278_4.color = Color.New(var_278_38, var_278_39, var_278_40)
							else
								local var_278_41 = Mathf.Lerp(iter_278_4.color.r, 1, var_278_37)

								iter_278_4.color = Color.New(var_278_41, var_278_41, var_278_41)
							end
						end
					end
				end
			end

			if arg_275_1.time_ >= var_278_35 + var_278_36 and arg_275_1.time_ < var_278_35 + var_278_36 + arg_278_0 and not isNil(var_278_34) and arg_275_1.var_.actorSpriteComps10092_1 then
				for iter_278_5, iter_278_6 in pairs(arg_275_1.var_.actorSpriteComps10092_1:ToTable()) do
					if iter_278_6 then
						if arg_275_1.isInRecall_ then
							iter_278_6.color = arg_275_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_278_6.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_275_1.var_.actorSpriteComps10092_1 = nil
			end

			local var_278_42 = arg_275_1.actors_["10092_1"]
			local var_278_43 = 2.96666666666667

			if var_278_43 < arg_275_1.time_ and arg_275_1.time_ <= var_278_43 + arg_278_0 then
				local var_278_44 = var_278_42:GetComponentInChildren(typeof(CanvasGroup))

				if var_278_44 then
					arg_275_1.var_.alphaOldValue10092_1 = var_278_44.alpha
					arg_275_1.var_.characterEffect10092_1 = var_278_44
				end

				arg_275_1.var_.alphaOldValue10092_1 = 0
			end

			local var_278_45 = 0.3

			if var_278_43 <= arg_275_1.time_ and arg_275_1.time_ < var_278_43 + var_278_45 then
				local var_278_46 = (arg_275_1.time_ - var_278_43) / var_278_45
				local var_278_47 = Mathf.Lerp(arg_275_1.var_.alphaOldValue10092_1, 1, var_278_46)

				if arg_275_1.var_.characterEffect10092_1 then
					arg_275_1.var_.characterEffect10092_1.alpha = var_278_47
				end
			end

			if arg_275_1.time_ >= var_278_43 + var_278_45 and arg_275_1.time_ < var_278_43 + var_278_45 + arg_278_0 and arg_275_1.var_.characterEffect10092_1 then
				arg_275_1.var_.characterEffect10092_1.alpha = 1
			end

			local var_278_48 = 1.6

			arg_275_1.isInRecall_ = false

			if var_278_48 < arg_275_1.time_ and arg_275_1.time_ <= var_278_48 + arg_278_0 then
				arg_275_1.screenFilterGo_:SetActive(false)

				for iter_278_7, iter_278_8 in pairs(arg_275_1.actors_) do
					local var_278_49 = iter_278_8:GetComponentsInChildren(typeof(Image), true):ToTable()

					for iter_278_9, iter_278_10 in ipairs(var_278_49) do
						if iter_278_10.color.r > 0.51 then
							iter_278_10.color = Color.New(1, 1, 1)
						else
							iter_278_10.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end
			end

			local var_278_50 = 0.2333333

			if var_278_48 <= arg_275_1.time_ and arg_275_1.time_ < var_278_48 + var_278_50 then
				local var_278_51 = (arg_275_1.time_ - var_278_48) / var_278_50

				arg_275_1.screenFilterEffect_.weight = Mathf.Lerp(1, 0, var_278_51)
			end

			if arg_275_1.time_ >= var_278_48 + var_278_50 and arg_275_1.time_ < var_278_48 + var_278_50 + arg_278_0 then
				arg_275_1.screenFilterEffect_.weight = 0
			end

			if arg_275_1.frameCnt_ <= 1 then
				arg_275_1.dialog_:SetActive(false)
			end

			local var_278_52 = 3.4
			local var_278_53 = 0.725

			if var_278_52 < arg_275_1.time_ and arg_275_1.time_ <= var_278_52 + arg_278_0 then
				arg_275_1.talkMaxDuration = 0

				arg_275_1.dialog_:SetActive(true)

				arg_275_1.dialogCg_.alpha = 0

				local var_278_54 = LeanTween.value(arg_275_1.dialog_, 0, 1, 0.3)

				var_278_54:setOnUpdate(LuaHelper.FloatAction(function(arg_279_0)
					arg_275_1.dialogCg_.alpha = arg_279_0
				end))
				var_278_54:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_275_1.dialog_)
					var_278_54:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_275_1.duration_ = arg_275_1.duration_ + 0.3

				SetActive(arg_275_1.leftNameGo_, true)

				local var_278_55 = arg_275_1:FormatText(StoryNameCfg[996].name)

				arg_275_1.leftNameTxt_.text = var_278_55

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_275_1.leftNameTxt_.transform)

				arg_275_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_275_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_275_1:RecordName(arg_275_1.leftNameTxt_.text)
				SetActive(arg_275_1.iconTrs_.gameObject, false)
				arg_275_1.callingController_:SetSelectedState("normal")

				local var_278_56 = arg_275_1:GetWordFromCfg(413141066)
				local var_278_57 = arg_275_1:FormatText(var_278_56.content)

				arg_275_1.text_.text = var_278_57

				LuaForUtil.ClearLinePrefixSymbol(arg_275_1.text_)

				local var_278_58 = 29
				local var_278_59 = utf8.len(var_278_57)
				local var_278_60 = var_278_58 <= 0 and var_278_53 or var_278_53 * (var_278_59 / var_278_58)

				if var_278_60 > 0 and var_278_53 < var_278_60 then
					arg_275_1.talkMaxDuration = var_278_60
					var_278_52 = var_278_52 + 0.3

					if var_278_60 + var_278_52 > arg_275_1.duration_ then
						arg_275_1.duration_ = var_278_60 + var_278_52
					end
				end

				arg_275_1.text_.text = var_278_57
				arg_275_1.typewritter.percent = 0

				arg_275_1.typewritter:SetDirty()
				arg_275_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_413141", "413141066", "story_v_out_413141.awb") ~= 0 then
					local var_278_61 = manager.audio:GetVoiceLength("story_v_out_413141", "413141066", "story_v_out_413141.awb") / 1000

					if var_278_61 + var_278_52 > arg_275_1.duration_ then
						arg_275_1.duration_ = var_278_61 + var_278_52
					end

					if var_278_56.prefab_name ~= "" and arg_275_1.actors_[var_278_56.prefab_name] ~= nil then
						local var_278_62 = LuaForUtil.PlayVoiceWithCriLipsync(arg_275_1.actors_[var_278_56.prefab_name].transform, "story_v_out_413141", "413141066", "story_v_out_413141.awb")

						arg_275_1:RecordAudio("413141066", var_278_62)
						arg_275_1:RecordAudio("413141066", var_278_62)
					else
						arg_275_1:AudioAction("play", "voice", "story_v_out_413141", "413141066", "story_v_out_413141.awb")
					end

					arg_275_1:RecordHistoryTalkVoice("story_v_out_413141", "413141066", "story_v_out_413141.awb")
				end

				arg_275_1:RecordContent(arg_275_1.text_.text)
			end

			local var_278_63 = var_278_52 + 0.3
			local var_278_64 = math.max(var_278_53, arg_275_1.talkMaxDuration)

			if var_278_63 <= arg_275_1.time_ and arg_275_1.time_ < var_278_63 + var_278_64 then
				arg_275_1.typewritter.percent = (arg_275_1.time_ - var_278_63) / var_278_64

				arg_275_1.typewritter:SetDirty()
			end

			if arg_275_1.time_ >= var_278_63 + var_278_64 and arg_275_1.time_ < var_278_63 + var_278_64 + arg_278_0 then
				arg_275_1.typewritter.percent = 1

				arg_275_1.typewritter:SetDirty()
				arg_275_1:ShowNextGo(true)
			end
		end

		arg_275_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10092_1",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 2.96666666666667,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_275_1:InitPlayNodeList()
	end,
	Play413141067 = function(arg_281_0, arg_281_1)
		arg_281_1.time_ = 0
		arg_281_1.frameCnt_ = 0
		arg_281_1.state_ = "playing"
		arg_281_1.curTalkId_ = 413141067
		arg_281_1.duration_ = 7

		local var_281_0 = {
			zh = 6.933,
			ja = 7
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
				arg_281_0:Play413141068(arg_281_1)
			end
		end

		function arg_281_1.onSingleLineUpdate_(arg_284_0)
			local var_284_0 = 0
			local var_284_1 = 0.7

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

				local var_284_3 = arg_281_1:GetWordFromCfg(413141067)
				local var_284_4 = arg_281_1:FormatText(var_284_3.content)

				arg_281_1.text_.text = var_284_4

				LuaForUtil.ClearLinePrefixSymbol(arg_281_1.text_)

				local var_284_5 = 28
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

				if manager.audio:GetVoiceLength("story_v_out_413141", "413141067", "story_v_out_413141.awb") ~= 0 then
					local var_284_8 = manager.audio:GetVoiceLength("story_v_out_413141", "413141067", "story_v_out_413141.awb") / 1000

					if var_284_8 + var_284_0 > arg_281_1.duration_ then
						arg_281_1.duration_ = var_284_8 + var_284_0
					end

					if var_284_3.prefab_name ~= "" and arg_281_1.actors_[var_284_3.prefab_name] ~= nil then
						local var_284_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_281_1.actors_[var_284_3.prefab_name].transform, "story_v_out_413141", "413141067", "story_v_out_413141.awb")

						arg_281_1:RecordAudio("413141067", var_284_9)
						arg_281_1:RecordAudio("413141067", var_284_9)
					else
						arg_281_1:AudioAction("play", "voice", "story_v_out_413141", "413141067", "story_v_out_413141.awb")
					end

					arg_281_1:RecordHistoryTalkVoice("story_v_out_413141", "413141067", "story_v_out_413141.awb")
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
	Play413141068 = function(arg_285_0, arg_285_1)
		arg_285_1.time_ = 0
		arg_285_1.frameCnt_ = 0
		arg_285_1.state_ = "playing"
		arg_285_1.curTalkId_ = 413141068
		arg_285_1.duration_ = 5.7

		local var_285_0 = {
			zh = 3.9,
			ja = 5.7
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
				arg_285_0:Play413141069(arg_285_1)
			end
		end

		function arg_285_1.onSingleLineUpdate_(arg_288_0)
			local var_288_0 = arg_285_1.actors_["10092_1"].transform
			local var_288_1 = 0

			if var_288_1 < arg_285_1.time_ and arg_285_1.time_ <= var_288_1 + arg_288_0 then
				arg_285_1.var_.moveOldPos10092_1 = var_288_0.localPosition
				var_288_0.localScale = Vector3.New(1, 1, 1)

				arg_285_1:CheckSpriteTmpPos("10092_1", 2)

				local var_288_2 = var_288_0.childCount

				for iter_288_0 = 0, var_288_2 - 1 do
					local var_288_3 = var_288_0:GetChild(iter_288_0)

					if var_288_3.name == "split_8" or not string.find(var_288_3.name, "split") then
						var_288_3.gameObject:SetActive(true)
					else
						var_288_3.gameObject:SetActive(false)
					end
				end
			end

			local var_288_4 = 0.001

			if var_288_1 <= arg_285_1.time_ and arg_285_1.time_ < var_288_1 + var_288_4 then
				local var_288_5 = (arg_285_1.time_ - var_288_1) / var_288_4
				local var_288_6 = Vector3.New(-389.49, -300, -295)

				var_288_0.localPosition = Vector3.Lerp(arg_285_1.var_.moveOldPos10092_1, var_288_6, var_288_5)
			end

			if arg_285_1.time_ >= var_288_1 + var_288_4 and arg_285_1.time_ < var_288_1 + var_288_4 + arg_288_0 then
				var_288_0.localPosition = Vector3.New(-389.49, -300, -295)
			end

			local var_288_7 = arg_285_1.actors_["10093"].transform
			local var_288_8 = 0

			if var_288_8 < arg_285_1.time_ and arg_285_1.time_ <= var_288_8 + arg_288_0 then
				arg_285_1.var_.moveOldPos10093 = var_288_7.localPosition
				var_288_7.localScale = Vector3.New(1, 1, 1)

				arg_285_1:CheckSpriteTmpPos("10093", 4)

				local var_288_9 = var_288_7.childCount

				for iter_288_1 = 0, var_288_9 - 1 do
					local var_288_10 = var_288_7:GetChild(iter_288_1)

					if var_288_10.name == "split_4" or not string.find(var_288_10.name, "split") then
						var_288_10.gameObject:SetActive(true)
					else
						var_288_10.gameObject:SetActive(false)
					end
				end
			end

			local var_288_11 = 0.001

			if var_288_8 <= arg_285_1.time_ and arg_285_1.time_ < var_288_8 + var_288_11 then
				local var_288_12 = (arg_285_1.time_ - var_288_8) / var_288_11
				local var_288_13 = Vector3.New(390, -345, -245)

				var_288_7.localPosition = Vector3.Lerp(arg_285_1.var_.moveOldPos10093, var_288_13, var_288_12)
			end

			if arg_285_1.time_ >= var_288_8 + var_288_11 and arg_285_1.time_ < var_288_8 + var_288_11 + arg_288_0 then
				var_288_7.localPosition = Vector3.New(390, -345, -245)
			end

			local var_288_14 = arg_285_1.actors_["10092_1"]
			local var_288_15 = 0

			if var_288_15 < arg_285_1.time_ and arg_285_1.time_ <= var_288_15 + arg_288_0 and not isNil(var_288_14) and arg_285_1.var_.actorSpriteComps10092_1 == nil then
				arg_285_1.var_.actorSpriteComps10092_1 = var_288_14:GetComponentsInChildren(typeof(Image), true)
			end

			local var_288_16 = 2

			if var_288_15 <= arg_285_1.time_ and arg_285_1.time_ < var_288_15 + var_288_16 and not isNil(var_288_14) then
				local var_288_17 = (arg_285_1.time_ - var_288_15) / var_288_16

				if arg_285_1.var_.actorSpriteComps10092_1 then
					for iter_288_2, iter_288_3 in pairs(arg_285_1.var_.actorSpriteComps10092_1:ToTable()) do
						if iter_288_3 then
							if arg_285_1.isInRecall_ then
								local var_288_18 = Mathf.Lerp(iter_288_3.color.r, arg_285_1.hightColor2.r, var_288_17)
								local var_288_19 = Mathf.Lerp(iter_288_3.color.g, arg_285_1.hightColor2.g, var_288_17)
								local var_288_20 = Mathf.Lerp(iter_288_3.color.b, arg_285_1.hightColor2.b, var_288_17)

								iter_288_3.color = Color.New(var_288_18, var_288_19, var_288_20)
							else
								local var_288_21 = Mathf.Lerp(iter_288_3.color.r, 0.5, var_288_17)

								iter_288_3.color = Color.New(var_288_21, var_288_21, var_288_21)
							end
						end
					end
				end
			end

			if arg_285_1.time_ >= var_288_15 + var_288_16 and arg_285_1.time_ < var_288_15 + var_288_16 + arg_288_0 and not isNil(var_288_14) and arg_285_1.var_.actorSpriteComps10092_1 then
				for iter_288_4, iter_288_5 in pairs(arg_285_1.var_.actorSpriteComps10092_1:ToTable()) do
					if iter_288_5 then
						if arg_285_1.isInRecall_ then
							iter_288_5.color = arg_285_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_288_5.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_285_1.var_.actorSpriteComps10092_1 = nil
			end

			local var_288_22 = arg_285_1.actors_["10093"]
			local var_288_23 = 0

			if var_288_23 < arg_285_1.time_ and arg_285_1.time_ <= var_288_23 + arg_288_0 and not isNil(var_288_22) and arg_285_1.var_.actorSpriteComps10093 == nil then
				arg_285_1.var_.actorSpriteComps10093 = var_288_22:GetComponentsInChildren(typeof(Image), true)
			end

			local var_288_24 = 2

			if var_288_23 <= arg_285_1.time_ and arg_285_1.time_ < var_288_23 + var_288_24 and not isNil(var_288_22) then
				local var_288_25 = (arg_285_1.time_ - var_288_23) / var_288_24

				if arg_285_1.var_.actorSpriteComps10093 then
					for iter_288_6, iter_288_7 in pairs(arg_285_1.var_.actorSpriteComps10093:ToTable()) do
						if iter_288_7 then
							if arg_285_1.isInRecall_ then
								local var_288_26 = Mathf.Lerp(iter_288_7.color.r, arg_285_1.hightColor1.r, var_288_25)
								local var_288_27 = Mathf.Lerp(iter_288_7.color.g, arg_285_1.hightColor1.g, var_288_25)
								local var_288_28 = Mathf.Lerp(iter_288_7.color.b, arg_285_1.hightColor1.b, var_288_25)

								iter_288_7.color = Color.New(var_288_26, var_288_27, var_288_28)
							else
								local var_288_29 = Mathf.Lerp(iter_288_7.color.r, 1, var_288_25)

								iter_288_7.color = Color.New(var_288_29, var_288_29, var_288_29)
							end
						end
					end
				end
			end

			if arg_285_1.time_ >= var_288_23 + var_288_24 and arg_285_1.time_ < var_288_23 + var_288_24 + arg_288_0 and not isNil(var_288_22) and arg_285_1.var_.actorSpriteComps10093 then
				for iter_288_8, iter_288_9 in pairs(arg_285_1.var_.actorSpriteComps10093:ToTable()) do
					if iter_288_9 then
						if arg_285_1.isInRecall_ then
							iter_288_9.color = arg_285_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_288_9.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_285_1.var_.actorSpriteComps10093 = nil
			end

			local var_288_30 = 0
			local var_288_31 = 0.475

			if var_288_30 < arg_285_1.time_ and arg_285_1.time_ <= var_288_30 + arg_288_0 then
				arg_285_1.talkMaxDuration = 0
				arg_285_1.dialogCg_.alpha = 1

				arg_285_1.dialog_:SetActive(true)
				SetActive(arg_285_1.leftNameGo_, true)

				local var_288_32 = arg_285_1:FormatText(StoryNameCfg[28].name)

				arg_285_1.leftNameTxt_.text = var_288_32

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_285_1.leftNameTxt_.transform)

				arg_285_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_285_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_285_1:RecordName(arg_285_1.leftNameTxt_.text)
				SetActive(arg_285_1.iconTrs_.gameObject, false)
				arg_285_1.callingController_:SetSelectedState("normal")

				local var_288_33 = arg_285_1:GetWordFromCfg(413141068)
				local var_288_34 = arg_285_1:FormatText(var_288_33.content)

				arg_285_1.text_.text = var_288_34

				LuaForUtil.ClearLinePrefixSymbol(arg_285_1.text_)

				local var_288_35 = 19
				local var_288_36 = utf8.len(var_288_34)
				local var_288_37 = var_288_35 <= 0 and var_288_31 or var_288_31 * (var_288_36 / var_288_35)

				if var_288_37 > 0 and var_288_31 < var_288_37 then
					arg_285_1.talkMaxDuration = var_288_37

					if var_288_37 + var_288_30 > arg_285_1.duration_ then
						arg_285_1.duration_ = var_288_37 + var_288_30
					end
				end

				arg_285_1.text_.text = var_288_34
				arg_285_1.typewritter.percent = 0

				arg_285_1.typewritter:SetDirty()
				arg_285_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_413141", "413141068", "story_v_out_413141.awb") ~= 0 then
					local var_288_38 = manager.audio:GetVoiceLength("story_v_out_413141", "413141068", "story_v_out_413141.awb") / 1000

					if var_288_38 + var_288_30 > arg_285_1.duration_ then
						arg_285_1.duration_ = var_288_38 + var_288_30
					end

					if var_288_33.prefab_name ~= "" and arg_285_1.actors_[var_288_33.prefab_name] ~= nil then
						local var_288_39 = LuaForUtil.PlayVoiceWithCriLipsync(arg_285_1.actors_[var_288_33.prefab_name].transform, "story_v_out_413141", "413141068", "story_v_out_413141.awb")

						arg_285_1:RecordAudio("413141068", var_288_39)
						arg_285_1:RecordAudio("413141068", var_288_39)
					else
						arg_285_1:AudioAction("play", "voice", "story_v_out_413141", "413141068", "story_v_out_413141.awb")
					end

					arg_285_1:RecordHistoryTalkVoice("story_v_out_413141", "413141068", "story_v_out_413141.awb")
				end

				arg_285_1:RecordContent(arg_285_1.text_.text)
			end

			local var_288_40 = math.max(var_288_31, arg_285_1.talkMaxDuration)

			if var_288_30 <= arg_285_1.time_ and arg_285_1.time_ < var_288_30 + var_288_40 then
				arg_285_1.typewritter.percent = (arg_285_1.time_ - var_288_30) / var_288_40

				arg_285_1.typewritter:SetDirty()
			end

			if arg_285_1.time_ >= var_288_30 + var_288_40 and arg_285_1.time_ < var_288_30 + var_288_40 + arg_288_0 then
				arg_285_1.typewritter.percent = 1

				arg_285_1.typewritter:SetDirty()
				arg_285_1:ShowNextGo(true)
			end
		end

		arg_285_1.nodeConfigList_ = {
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

		arg_285_1:InitPlayNodeList()
	end,
	Play413141069 = function(arg_289_0, arg_289_1)
		arg_289_1.time_ = 0
		arg_289_1.frameCnt_ = 0
		arg_289_1.state_ = "playing"
		arg_289_1.curTalkId_ = 413141069
		arg_289_1.duration_ = 8.7

		local var_289_0 = {
			zh = 4.1,
			ja = 8.7
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
				arg_289_0:Play413141070(arg_289_1)
			end
		end

		function arg_289_1.onSingleLineUpdate_(arg_292_0)
			local var_292_0 = arg_289_1.actors_["10092_1"].transform
			local var_292_1 = 0

			if var_292_1 < arg_289_1.time_ and arg_289_1.time_ <= var_292_1 + arg_292_0 then
				arg_289_1.var_.moveOldPos10092_1 = var_292_0.localPosition
				var_292_0.localScale = Vector3.New(1, 1, 1)

				arg_289_1:CheckSpriteTmpPos("10092_1", 2)

				local var_292_2 = var_292_0.childCount

				for iter_292_0 = 0, var_292_2 - 1 do
					local var_292_3 = var_292_0:GetChild(iter_292_0)

					if var_292_3.name == "split_1_1" or not string.find(var_292_3.name, "split") then
						var_292_3.gameObject:SetActive(true)
					else
						var_292_3.gameObject:SetActive(false)
					end
				end
			end

			local var_292_4 = 0.001

			if var_292_1 <= arg_289_1.time_ and arg_289_1.time_ < var_292_1 + var_292_4 then
				local var_292_5 = (arg_289_1.time_ - var_292_1) / var_292_4
				local var_292_6 = Vector3.New(-389.49, -300, -295)

				var_292_0.localPosition = Vector3.Lerp(arg_289_1.var_.moveOldPos10092_1, var_292_6, var_292_5)
			end

			if arg_289_1.time_ >= var_292_1 + var_292_4 and arg_289_1.time_ < var_292_1 + var_292_4 + arg_292_0 then
				var_292_0.localPosition = Vector3.New(-389.49, -300, -295)
			end

			local var_292_7 = arg_289_1.actors_["10092_1"]
			local var_292_8 = 0

			if var_292_8 < arg_289_1.time_ and arg_289_1.time_ <= var_292_8 + arg_292_0 and not isNil(var_292_7) and arg_289_1.var_.actorSpriteComps10092_1 == nil then
				arg_289_1.var_.actorSpriteComps10092_1 = var_292_7:GetComponentsInChildren(typeof(Image), true)
			end

			local var_292_9 = 2

			if var_292_8 <= arg_289_1.time_ and arg_289_1.time_ < var_292_8 + var_292_9 and not isNil(var_292_7) then
				local var_292_10 = (arg_289_1.time_ - var_292_8) / var_292_9

				if arg_289_1.var_.actorSpriteComps10092_1 then
					for iter_292_1, iter_292_2 in pairs(arg_289_1.var_.actorSpriteComps10092_1:ToTable()) do
						if iter_292_2 then
							if arg_289_1.isInRecall_ then
								local var_292_11 = Mathf.Lerp(iter_292_2.color.r, arg_289_1.hightColor1.r, var_292_10)
								local var_292_12 = Mathf.Lerp(iter_292_2.color.g, arg_289_1.hightColor1.g, var_292_10)
								local var_292_13 = Mathf.Lerp(iter_292_2.color.b, arg_289_1.hightColor1.b, var_292_10)

								iter_292_2.color = Color.New(var_292_11, var_292_12, var_292_13)
							else
								local var_292_14 = Mathf.Lerp(iter_292_2.color.r, 1, var_292_10)

								iter_292_2.color = Color.New(var_292_14, var_292_14, var_292_14)
							end
						end
					end
				end
			end

			if arg_289_1.time_ >= var_292_8 + var_292_9 and arg_289_1.time_ < var_292_8 + var_292_9 + arg_292_0 and not isNil(var_292_7) and arg_289_1.var_.actorSpriteComps10092_1 then
				for iter_292_3, iter_292_4 in pairs(arg_289_1.var_.actorSpriteComps10092_1:ToTable()) do
					if iter_292_4 then
						if arg_289_1.isInRecall_ then
							iter_292_4.color = arg_289_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_292_4.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_289_1.var_.actorSpriteComps10092_1 = nil
			end

			local var_292_15 = arg_289_1.actors_["10093"]
			local var_292_16 = 0

			if var_292_16 < arg_289_1.time_ and arg_289_1.time_ <= var_292_16 + arg_292_0 and not isNil(var_292_15) and arg_289_1.var_.actorSpriteComps10093 == nil then
				arg_289_1.var_.actorSpriteComps10093 = var_292_15:GetComponentsInChildren(typeof(Image), true)
			end

			local var_292_17 = 2

			if var_292_16 <= arg_289_1.time_ and arg_289_1.time_ < var_292_16 + var_292_17 and not isNil(var_292_15) then
				local var_292_18 = (arg_289_1.time_ - var_292_16) / var_292_17

				if arg_289_1.var_.actorSpriteComps10093 then
					for iter_292_5, iter_292_6 in pairs(arg_289_1.var_.actorSpriteComps10093:ToTable()) do
						if iter_292_6 then
							if arg_289_1.isInRecall_ then
								local var_292_19 = Mathf.Lerp(iter_292_6.color.r, arg_289_1.hightColor2.r, var_292_18)
								local var_292_20 = Mathf.Lerp(iter_292_6.color.g, arg_289_1.hightColor2.g, var_292_18)
								local var_292_21 = Mathf.Lerp(iter_292_6.color.b, arg_289_1.hightColor2.b, var_292_18)

								iter_292_6.color = Color.New(var_292_19, var_292_20, var_292_21)
							else
								local var_292_22 = Mathf.Lerp(iter_292_6.color.r, 0.5, var_292_18)

								iter_292_6.color = Color.New(var_292_22, var_292_22, var_292_22)
							end
						end
					end
				end
			end

			if arg_289_1.time_ >= var_292_16 + var_292_17 and arg_289_1.time_ < var_292_16 + var_292_17 + arg_292_0 and not isNil(var_292_15) and arg_289_1.var_.actorSpriteComps10093 then
				for iter_292_7, iter_292_8 in pairs(arg_289_1.var_.actorSpriteComps10093:ToTable()) do
					if iter_292_8 then
						if arg_289_1.isInRecall_ then
							iter_292_8.color = arg_289_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_292_8.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_289_1.var_.actorSpriteComps10093 = nil
			end

			local var_292_23 = 0
			local var_292_24 = 0.675

			if var_292_23 < arg_289_1.time_ and arg_289_1.time_ <= var_292_23 + arg_292_0 then
				arg_289_1.talkMaxDuration = 0
				arg_289_1.dialogCg_.alpha = 1

				arg_289_1.dialog_:SetActive(true)
				SetActive(arg_289_1.leftNameGo_, true)

				local var_292_25 = arg_289_1:FormatText(StoryNameCfg[996].name)

				arg_289_1.leftNameTxt_.text = var_292_25

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_289_1.leftNameTxt_.transform)

				arg_289_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_289_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_289_1:RecordName(arg_289_1.leftNameTxt_.text)
				SetActive(arg_289_1.iconTrs_.gameObject, false)
				arg_289_1.callingController_:SetSelectedState("normal")

				local var_292_26 = arg_289_1:GetWordFromCfg(413141069)
				local var_292_27 = arg_289_1:FormatText(var_292_26.content)

				arg_289_1.text_.text = var_292_27

				LuaForUtil.ClearLinePrefixSymbol(arg_289_1.text_)

				local var_292_28 = 27
				local var_292_29 = utf8.len(var_292_27)
				local var_292_30 = var_292_28 <= 0 and var_292_24 or var_292_24 * (var_292_29 / var_292_28)

				if var_292_30 > 0 and var_292_24 < var_292_30 then
					arg_289_1.talkMaxDuration = var_292_30

					if var_292_30 + var_292_23 > arg_289_1.duration_ then
						arg_289_1.duration_ = var_292_30 + var_292_23
					end
				end

				arg_289_1.text_.text = var_292_27
				arg_289_1.typewritter.percent = 0

				arg_289_1.typewritter:SetDirty()
				arg_289_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_413141", "413141069", "story_v_out_413141.awb") ~= 0 then
					local var_292_31 = manager.audio:GetVoiceLength("story_v_out_413141", "413141069", "story_v_out_413141.awb") / 1000

					if var_292_31 + var_292_23 > arg_289_1.duration_ then
						arg_289_1.duration_ = var_292_31 + var_292_23
					end

					if var_292_26.prefab_name ~= "" and arg_289_1.actors_[var_292_26.prefab_name] ~= nil then
						local var_292_32 = LuaForUtil.PlayVoiceWithCriLipsync(arg_289_1.actors_[var_292_26.prefab_name].transform, "story_v_out_413141", "413141069", "story_v_out_413141.awb")

						arg_289_1:RecordAudio("413141069", var_292_32)
						arg_289_1:RecordAudio("413141069", var_292_32)
					else
						arg_289_1:AudioAction("play", "voice", "story_v_out_413141", "413141069", "story_v_out_413141.awb")
					end

					arg_289_1:RecordHistoryTalkVoice("story_v_out_413141", "413141069", "story_v_out_413141.awb")
				end

				arg_289_1:RecordContent(arg_289_1.text_.text)
			end

			local var_292_33 = math.max(var_292_24, arg_289_1.talkMaxDuration)

			if var_292_23 <= arg_289_1.time_ and arg_289_1.time_ < var_292_23 + var_292_33 then
				arg_289_1.typewritter.percent = (arg_289_1.time_ - var_292_23) / var_292_33

				arg_289_1.typewritter:SetDirty()
			end

			if arg_289_1.time_ >= var_292_23 + var_292_33 and arg_289_1.time_ < var_292_23 + var_292_33 + arg_292_0 then
				arg_289_1.typewritter.percent = 1

				arg_289_1.typewritter:SetDirty()
				arg_289_1:ShowNextGo(true)
			end
		end

		arg_289_1.nodeConfigList_ = {
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

		arg_289_1:InitPlayNodeList()
	end,
	Play413141070 = function(arg_293_0, arg_293_1)
		arg_293_1.time_ = 0
		arg_293_1.frameCnt_ = 0
		arg_293_1.state_ = "playing"
		arg_293_1.curTalkId_ = 413141070
		arg_293_1.duration_ = 5.83

		local var_293_0 = {
			zh = 5.833,
			ja = 4.4
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
				arg_293_0:Play413141071(arg_293_1)
			end
		end

		function arg_293_1.onSingleLineUpdate_(arg_296_0)
			local var_296_0 = 0
			local var_296_1 = 0.6

			if var_296_0 < arg_293_1.time_ and arg_293_1.time_ <= var_296_0 + arg_296_0 then
				arg_293_1.talkMaxDuration = 0
				arg_293_1.dialogCg_.alpha = 1

				arg_293_1.dialog_:SetActive(true)
				SetActive(arg_293_1.leftNameGo_, true)

				local var_296_2 = arg_293_1:FormatText(StoryNameCfg[996].name)

				arg_293_1.leftNameTxt_.text = var_296_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_293_1.leftNameTxt_.transform)

				arg_293_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_293_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_293_1:RecordName(arg_293_1.leftNameTxt_.text)
				SetActive(arg_293_1.iconTrs_.gameObject, false)
				arg_293_1.callingController_:SetSelectedState("normal")

				local var_296_3 = arg_293_1:GetWordFromCfg(413141070)
				local var_296_4 = arg_293_1:FormatText(var_296_3.content)

				arg_293_1.text_.text = var_296_4

				LuaForUtil.ClearLinePrefixSymbol(arg_293_1.text_)

				local var_296_5 = 24
				local var_296_6 = utf8.len(var_296_4)
				local var_296_7 = var_296_5 <= 0 and var_296_1 or var_296_1 * (var_296_6 / var_296_5)

				if var_296_7 > 0 and var_296_1 < var_296_7 then
					arg_293_1.talkMaxDuration = var_296_7

					if var_296_7 + var_296_0 > arg_293_1.duration_ then
						arg_293_1.duration_ = var_296_7 + var_296_0
					end
				end

				arg_293_1.text_.text = var_296_4
				arg_293_1.typewritter.percent = 0

				arg_293_1.typewritter:SetDirty()
				arg_293_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_413141", "413141070", "story_v_out_413141.awb") ~= 0 then
					local var_296_8 = manager.audio:GetVoiceLength("story_v_out_413141", "413141070", "story_v_out_413141.awb") / 1000

					if var_296_8 + var_296_0 > arg_293_1.duration_ then
						arg_293_1.duration_ = var_296_8 + var_296_0
					end

					if var_296_3.prefab_name ~= "" and arg_293_1.actors_[var_296_3.prefab_name] ~= nil then
						local var_296_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_293_1.actors_[var_296_3.prefab_name].transform, "story_v_out_413141", "413141070", "story_v_out_413141.awb")

						arg_293_1:RecordAudio("413141070", var_296_9)
						arg_293_1:RecordAudio("413141070", var_296_9)
					else
						arg_293_1:AudioAction("play", "voice", "story_v_out_413141", "413141070", "story_v_out_413141.awb")
					end

					arg_293_1:RecordHistoryTalkVoice("story_v_out_413141", "413141070", "story_v_out_413141.awb")
				end

				arg_293_1:RecordContent(arg_293_1.text_.text)
			end

			local var_296_10 = math.max(var_296_1, arg_293_1.talkMaxDuration)

			if var_296_0 <= arg_293_1.time_ and arg_293_1.time_ < var_296_0 + var_296_10 then
				arg_293_1.typewritter.percent = (arg_293_1.time_ - var_296_0) / var_296_10

				arg_293_1.typewritter:SetDirty()
			end

			if arg_293_1.time_ >= var_296_0 + var_296_10 and arg_293_1.time_ < var_296_0 + var_296_10 + arg_296_0 then
				arg_293_1.typewritter.percent = 1

				arg_293_1.typewritter:SetDirty()
				arg_293_1:ShowNextGo(true)
			end
		end

		arg_293_1.nodeConfigList_ = {}

		arg_293_1:InitPlayNodeList()
	end,
	Play413141071 = function(arg_297_0, arg_297_1)
		arg_297_1.time_ = 0
		arg_297_1.frameCnt_ = 0
		arg_297_1.state_ = "playing"
		arg_297_1.curTalkId_ = 413141071
		arg_297_1.duration_ = 10.83

		local var_297_0 = {
			zh = 7.9,
			ja = 10.833
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
				arg_297_0:Play413141072(arg_297_1)
			end
		end

		function arg_297_1.onSingleLineUpdate_(arg_300_0)
			local var_300_0 = 0
			local var_300_1 = 1.1

			if var_300_0 < arg_297_1.time_ and arg_297_1.time_ <= var_300_0 + arg_300_0 then
				arg_297_1.talkMaxDuration = 0
				arg_297_1.dialogCg_.alpha = 1

				arg_297_1.dialog_:SetActive(true)
				SetActive(arg_297_1.leftNameGo_, true)

				local var_300_2 = arg_297_1:FormatText(StoryNameCfg[996].name)

				arg_297_1.leftNameTxt_.text = var_300_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_297_1.leftNameTxt_.transform)

				arg_297_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_297_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_297_1:RecordName(arg_297_1.leftNameTxt_.text)
				SetActive(arg_297_1.iconTrs_.gameObject, false)
				arg_297_1.callingController_:SetSelectedState("normal")

				local var_300_3 = arg_297_1:GetWordFromCfg(413141071)
				local var_300_4 = arg_297_1:FormatText(var_300_3.content)

				arg_297_1.text_.text = var_300_4

				LuaForUtil.ClearLinePrefixSymbol(arg_297_1.text_)

				local var_300_5 = 44
				local var_300_6 = utf8.len(var_300_4)
				local var_300_7 = var_300_5 <= 0 and var_300_1 or var_300_1 * (var_300_6 / var_300_5)

				if var_300_7 > 0 and var_300_1 < var_300_7 then
					arg_297_1.talkMaxDuration = var_300_7

					if var_300_7 + var_300_0 > arg_297_1.duration_ then
						arg_297_1.duration_ = var_300_7 + var_300_0
					end
				end

				arg_297_1.text_.text = var_300_4
				arg_297_1.typewritter.percent = 0

				arg_297_1.typewritter:SetDirty()
				arg_297_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_413141", "413141071", "story_v_out_413141.awb") ~= 0 then
					local var_300_8 = manager.audio:GetVoiceLength("story_v_out_413141", "413141071", "story_v_out_413141.awb") / 1000

					if var_300_8 + var_300_0 > arg_297_1.duration_ then
						arg_297_1.duration_ = var_300_8 + var_300_0
					end

					if var_300_3.prefab_name ~= "" and arg_297_1.actors_[var_300_3.prefab_name] ~= nil then
						local var_300_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_297_1.actors_[var_300_3.prefab_name].transform, "story_v_out_413141", "413141071", "story_v_out_413141.awb")

						arg_297_1:RecordAudio("413141071", var_300_9)
						arg_297_1:RecordAudio("413141071", var_300_9)
					else
						arg_297_1:AudioAction("play", "voice", "story_v_out_413141", "413141071", "story_v_out_413141.awb")
					end

					arg_297_1:RecordHistoryTalkVoice("story_v_out_413141", "413141071", "story_v_out_413141.awb")
				end

				arg_297_1:RecordContent(arg_297_1.text_.text)
			end

			local var_300_10 = math.max(var_300_1, arg_297_1.talkMaxDuration)

			if var_300_0 <= arg_297_1.time_ and arg_297_1.time_ < var_300_0 + var_300_10 then
				arg_297_1.typewritter.percent = (arg_297_1.time_ - var_300_0) / var_300_10

				arg_297_1.typewritter:SetDirty()
			end

			if arg_297_1.time_ >= var_300_0 + var_300_10 and arg_297_1.time_ < var_300_0 + var_300_10 + arg_300_0 then
				arg_297_1.typewritter.percent = 1

				arg_297_1.typewritter:SetDirty()
				arg_297_1:ShowNextGo(true)
			end
		end

		arg_297_1.nodeConfigList_ = {}

		arg_297_1:InitPlayNodeList()
	end,
	Play413141072 = function(arg_301_0, arg_301_1)
		arg_301_1.time_ = 0
		arg_301_1.frameCnt_ = 0
		arg_301_1.state_ = "playing"
		arg_301_1.curTalkId_ = 413141072
		arg_301_1.duration_ = 9.57

		local var_301_0 = {
			zh = 5.833,
			ja = 9.566
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
				arg_301_0:Play413141073(arg_301_1)
			end
		end

		function arg_301_1.onSingleLineUpdate_(arg_304_0)
			local var_304_0 = arg_301_1.actors_["10092_1"].transform
			local var_304_1 = 0

			if var_304_1 < arg_301_1.time_ and arg_301_1.time_ <= var_304_1 + arg_304_0 then
				arg_301_1.var_.moveOldPos10092_1 = var_304_0.localPosition
				var_304_0.localScale = Vector3.New(1, 1, 1)

				arg_301_1:CheckSpriteTmpPos("10092_1", 2)

				local var_304_2 = var_304_0.childCount

				for iter_304_0 = 0, var_304_2 - 1 do
					local var_304_3 = var_304_0:GetChild(iter_304_0)

					if var_304_3.name == "split_1_1" or not string.find(var_304_3.name, "split") then
						var_304_3.gameObject:SetActive(true)
					else
						var_304_3.gameObject:SetActive(false)
					end
				end
			end

			local var_304_4 = 0.001

			if var_304_1 <= arg_301_1.time_ and arg_301_1.time_ < var_304_1 + var_304_4 then
				local var_304_5 = (arg_301_1.time_ - var_304_1) / var_304_4
				local var_304_6 = Vector3.New(-389.49, -300, -295)

				var_304_0.localPosition = Vector3.Lerp(arg_301_1.var_.moveOldPos10092_1, var_304_6, var_304_5)
			end

			if arg_301_1.time_ >= var_304_1 + var_304_4 and arg_301_1.time_ < var_304_1 + var_304_4 + arg_304_0 then
				var_304_0.localPosition = Vector3.New(-389.49, -300, -295)
			end

			local var_304_7 = 0
			local var_304_8 = 0.8

			if var_304_7 < arg_301_1.time_ and arg_301_1.time_ <= var_304_7 + arg_304_0 then
				arg_301_1.talkMaxDuration = 0
				arg_301_1.dialogCg_.alpha = 1

				arg_301_1.dialog_:SetActive(true)
				SetActive(arg_301_1.leftNameGo_, true)

				local var_304_9 = arg_301_1:FormatText(StoryNameCfg[996].name)

				arg_301_1.leftNameTxt_.text = var_304_9

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_301_1.leftNameTxt_.transform)

				arg_301_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_301_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_301_1:RecordName(arg_301_1.leftNameTxt_.text)
				SetActive(arg_301_1.iconTrs_.gameObject, false)
				arg_301_1.callingController_:SetSelectedState("normal")

				local var_304_10 = arg_301_1:GetWordFromCfg(413141072)
				local var_304_11 = arg_301_1:FormatText(var_304_10.content)

				arg_301_1.text_.text = var_304_11

				LuaForUtil.ClearLinePrefixSymbol(arg_301_1.text_)

				local var_304_12 = 32
				local var_304_13 = utf8.len(var_304_11)
				local var_304_14 = var_304_12 <= 0 and var_304_8 or var_304_8 * (var_304_13 / var_304_12)

				if var_304_14 > 0 and var_304_8 < var_304_14 then
					arg_301_1.talkMaxDuration = var_304_14

					if var_304_14 + var_304_7 > arg_301_1.duration_ then
						arg_301_1.duration_ = var_304_14 + var_304_7
					end
				end

				arg_301_1.text_.text = var_304_11
				arg_301_1.typewritter.percent = 0

				arg_301_1.typewritter:SetDirty()
				arg_301_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_413141", "413141072", "story_v_out_413141.awb") ~= 0 then
					local var_304_15 = manager.audio:GetVoiceLength("story_v_out_413141", "413141072", "story_v_out_413141.awb") / 1000

					if var_304_15 + var_304_7 > arg_301_1.duration_ then
						arg_301_1.duration_ = var_304_15 + var_304_7
					end

					if var_304_10.prefab_name ~= "" and arg_301_1.actors_[var_304_10.prefab_name] ~= nil then
						local var_304_16 = LuaForUtil.PlayVoiceWithCriLipsync(arg_301_1.actors_[var_304_10.prefab_name].transform, "story_v_out_413141", "413141072", "story_v_out_413141.awb")

						arg_301_1:RecordAudio("413141072", var_304_16)
						arg_301_1:RecordAudio("413141072", var_304_16)
					else
						arg_301_1:AudioAction("play", "voice", "story_v_out_413141", "413141072", "story_v_out_413141.awb")
					end

					arg_301_1:RecordHistoryTalkVoice("story_v_out_413141", "413141072", "story_v_out_413141.awb")
				end

				arg_301_1:RecordContent(arg_301_1.text_.text)
			end

			local var_304_17 = math.max(var_304_8, arg_301_1.talkMaxDuration)

			if var_304_7 <= arg_301_1.time_ and arg_301_1.time_ < var_304_7 + var_304_17 then
				arg_301_1.typewritter.percent = (arg_301_1.time_ - var_304_7) / var_304_17

				arg_301_1.typewritter:SetDirty()
			end

			if arg_301_1.time_ >= var_304_7 + var_304_17 and arg_301_1.time_ < var_304_7 + var_304_17 + arg_304_0 then
				arg_301_1.typewritter.percent = 1

				arg_301_1.typewritter:SetDirty()
				arg_301_1:ShowNextGo(true)
			end
		end

		arg_301_1.nodeConfigList_ = {
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

		arg_301_1:InitPlayNodeList()
	end,
	Play413141073 = function(arg_305_0, arg_305_1)
		arg_305_1.time_ = 0
		arg_305_1.frameCnt_ = 0
		arg_305_1.state_ = "playing"
		arg_305_1.curTalkId_ = 413141073
		arg_305_1.duration_ = 12.7

		local var_305_0 = {
			zh = 11,
			ja = 12.7
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
				arg_305_0:Play413141074(arg_305_1)
			end
		end

		function arg_305_1.onSingleLineUpdate_(arg_308_0)
			local var_308_0 = 0
			local var_308_1 = 1.375

			if var_308_0 < arg_305_1.time_ and arg_305_1.time_ <= var_308_0 + arg_308_0 then
				arg_305_1.talkMaxDuration = 0
				arg_305_1.dialogCg_.alpha = 1

				arg_305_1.dialog_:SetActive(true)
				SetActive(arg_305_1.leftNameGo_, true)

				local var_308_2 = arg_305_1:FormatText(StoryNameCfg[996].name)

				arg_305_1.leftNameTxt_.text = var_308_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_305_1.leftNameTxt_.transform)

				arg_305_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_305_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_305_1:RecordName(arg_305_1.leftNameTxt_.text)
				SetActive(arg_305_1.iconTrs_.gameObject, false)
				arg_305_1.callingController_:SetSelectedState("normal")

				local var_308_3 = arg_305_1:GetWordFromCfg(413141073)
				local var_308_4 = arg_305_1:FormatText(var_308_3.content)

				arg_305_1.text_.text = var_308_4

				LuaForUtil.ClearLinePrefixSymbol(arg_305_1.text_)

				local var_308_5 = 55
				local var_308_6 = utf8.len(var_308_4)
				local var_308_7 = var_308_5 <= 0 and var_308_1 or var_308_1 * (var_308_6 / var_308_5)

				if var_308_7 > 0 and var_308_1 < var_308_7 then
					arg_305_1.talkMaxDuration = var_308_7

					if var_308_7 + var_308_0 > arg_305_1.duration_ then
						arg_305_1.duration_ = var_308_7 + var_308_0
					end
				end

				arg_305_1.text_.text = var_308_4
				arg_305_1.typewritter.percent = 0

				arg_305_1.typewritter:SetDirty()
				arg_305_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_413141", "413141073", "story_v_out_413141.awb") ~= 0 then
					local var_308_8 = manager.audio:GetVoiceLength("story_v_out_413141", "413141073", "story_v_out_413141.awb") / 1000

					if var_308_8 + var_308_0 > arg_305_1.duration_ then
						arg_305_1.duration_ = var_308_8 + var_308_0
					end

					if var_308_3.prefab_name ~= "" and arg_305_1.actors_[var_308_3.prefab_name] ~= nil then
						local var_308_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_305_1.actors_[var_308_3.prefab_name].transform, "story_v_out_413141", "413141073", "story_v_out_413141.awb")

						arg_305_1:RecordAudio("413141073", var_308_9)
						arg_305_1:RecordAudio("413141073", var_308_9)
					else
						arg_305_1:AudioAction("play", "voice", "story_v_out_413141", "413141073", "story_v_out_413141.awb")
					end

					arg_305_1:RecordHistoryTalkVoice("story_v_out_413141", "413141073", "story_v_out_413141.awb")
				end

				arg_305_1:RecordContent(arg_305_1.text_.text)
			end

			local var_308_10 = math.max(var_308_1, arg_305_1.talkMaxDuration)

			if var_308_0 <= arg_305_1.time_ and arg_305_1.time_ < var_308_0 + var_308_10 then
				arg_305_1.typewritter.percent = (arg_305_1.time_ - var_308_0) / var_308_10

				arg_305_1.typewritter:SetDirty()
			end

			if arg_305_1.time_ >= var_308_0 + var_308_10 and arg_305_1.time_ < var_308_0 + var_308_10 + arg_308_0 then
				arg_305_1.typewritter.percent = 1

				arg_305_1.typewritter:SetDirty()
				arg_305_1:ShowNextGo(true)
			end
		end

		arg_305_1.nodeConfigList_ = {}

		arg_305_1:InitPlayNodeList()
	end,
	Play413141074 = function(arg_309_0, arg_309_1)
		arg_309_1.time_ = 0
		arg_309_1.frameCnt_ = 0
		arg_309_1.state_ = "playing"
		arg_309_1.curTalkId_ = 413141074
		arg_309_1.duration_ = 8.07

		local var_309_0 = {
			zh = 6.6,
			ja = 8.066
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
				arg_309_0:Play413141075(arg_309_1)
			end
		end

		function arg_309_1.onSingleLineUpdate_(arg_312_0)
			local var_312_0 = 0
			local var_312_1 = 0.775

			if var_312_0 < arg_309_1.time_ and arg_309_1.time_ <= var_312_0 + arg_312_0 then
				arg_309_1.talkMaxDuration = 0
				arg_309_1.dialogCg_.alpha = 1

				arg_309_1.dialog_:SetActive(true)
				SetActive(arg_309_1.leftNameGo_, true)

				local var_312_2 = arg_309_1:FormatText(StoryNameCfg[996].name)

				arg_309_1.leftNameTxt_.text = var_312_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_309_1.leftNameTxt_.transform)

				arg_309_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_309_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_309_1:RecordName(arg_309_1.leftNameTxt_.text)
				SetActive(arg_309_1.iconTrs_.gameObject, false)
				arg_309_1.callingController_:SetSelectedState("normal")

				local var_312_3 = arg_309_1:GetWordFromCfg(413141074)
				local var_312_4 = arg_309_1:FormatText(var_312_3.content)

				arg_309_1.text_.text = var_312_4

				LuaForUtil.ClearLinePrefixSymbol(arg_309_1.text_)

				local var_312_5 = 31
				local var_312_6 = utf8.len(var_312_4)
				local var_312_7 = var_312_5 <= 0 and var_312_1 or var_312_1 * (var_312_6 / var_312_5)

				if var_312_7 > 0 and var_312_1 < var_312_7 then
					arg_309_1.talkMaxDuration = var_312_7

					if var_312_7 + var_312_0 > arg_309_1.duration_ then
						arg_309_1.duration_ = var_312_7 + var_312_0
					end
				end

				arg_309_1.text_.text = var_312_4
				arg_309_1.typewritter.percent = 0

				arg_309_1.typewritter:SetDirty()
				arg_309_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_413141", "413141074", "story_v_out_413141.awb") ~= 0 then
					local var_312_8 = manager.audio:GetVoiceLength("story_v_out_413141", "413141074", "story_v_out_413141.awb") / 1000

					if var_312_8 + var_312_0 > arg_309_1.duration_ then
						arg_309_1.duration_ = var_312_8 + var_312_0
					end

					if var_312_3.prefab_name ~= "" and arg_309_1.actors_[var_312_3.prefab_name] ~= nil then
						local var_312_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_309_1.actors_[var_312_3.prefab_name].transform, "story_v_out_413141", "413141074", "story_v_out_413141.awb")

						arg_309_1:RecordAudio("413141074", var_312_9)
						arg_309_1:RecordAudio("413141074", var_312_9)
					else
						arg_309_1:AudioAction("play", "voice", "story_v_out_413141", "413141074", "story_v_out_413141.awb")
					end

					arg_309_1:RecordHistoryTalkVoice("story_v_out_413141", "413141074", "story_v_out_413141.awb")
				end

				arg_309_1:RecordContent(arg_309_1.text_.text)
			end

			local var_312_10 = math.max(var_312_1, arg_309_1.talkMaxDuration)

			if var_312_0 <= arg_309_1.time_ and arg_309_1.time_ < var_312_0 + var_312_10 then
				arg_309_1.typewritter.percent = (arg_309_1.time_ - var_312_0) / var_312_10

				arg_309_1.typewritter:SetDirty()
			end

			if arg_309_1.time_ >= var_312_0 + var_312_10 and arg_309_1.time_ < var_312_0 + var_312_10 + arg_312_0 then
				arg_309_1.typewritter.percent = 1

				arg_309_1.typewritter:SetDirty()
				arg_309_1:ShowNextGo(true)
			end
		end

		arg_309_1.nodeConfigList_ = {}

		arg_309_1:InitPlayNodeList()
	end,
	Play413141075 = function(arg_313_0, arg_313_1)
		arg_313_1.time_ = 0
		arg_313_1.frameCnt_ = 0
		arg_313_1.state_ = "playing"
		arg_313_1.curTalkId_ = 413141075
		arg_313_1.duration_ = 6.6

		local var_313_0 = {
			zh = 1.999999999999,
			ja = 6.6
		}
		local var_313_1 = manager.audio:GetLocalizationFlag()

		if var_313_0[var_313_1] ~= nil then
			arg_313_1.duration_ = var_313_0[var_313_1]
		end

		SetActive(arg_313_1.tipsGo_, false)

		function arg_313_1.onSingleLineFinish_()
			arg_313_1.onSingleLineUpdate_ = nil
			arg_313_1.onSingleLineFinish_ = nil
			arg_313_1.state_ = "waiting"
		end

		function arg_313_1.playNext_(arg_315_0)
			if arg_315_0 == 1 then
				arg_313_0:Play413141076(arg_313_1)
			end
		end

		function arg_313_1.onSingleLineUpdate_(arg_316_0)
			local var_316_0 = arg_313_1.actors_["10092_1"].transform
			local var_316_1 = 0

			if var_316_1 < arg_313_1.time_ and arg_313_1.time_ <= var_316_1 + arg_316_0 then
				arg_313_1.var_.moveOldPos10092_1 = var_316_0.localPosition
				var_316_0.localScale = Vector3.New(1, 1, 1)

				arg_313_1:CheckSpriteTmpPos("10092_1", 2)

				local var_316_2 = var_316_0.childCount

				for iter_316_0 = 0, var_316_2 - 1 do
					local var_316_3 = var_316_0:GetChild(iter_316_0)

					if var_316_3.name == "split_5" or not string.find(var_316_3.name, "split") then
						var_316_3.gameObject:SetActive(true)
					else
						var_316_3.gameObject:SetActive(false)
					end
				end
			end

			local var_316_4 = 0.001

			if var_316_1 <= arg_313_1.time_ and arg_313_1.time_ < var_316_1 + var_316_4 then
				local var_316_5 = (arg_313_1.time_ - var_316_1) / var_316_4
				local var_316_6 = Vector3.New(-389.49, -300, -295)

				var_316_0.localPosition = Vector3.Lerp(arg_313_1.var_.moveOldPos10092_1, var_316_6, var_316_5)
			end

			if arg_313_1.time_ >= var_316_1 + var_316_4 and arg_313_1.time_ < var_316_1 + var_316_4 + arg_316_0 then
				var_316_0.localPosition = Vector3.New(-389.49, -300, -295)
			end

			local var_316_7 = arg_313_1.actors_["10092_1"]
			local var_316_8 = 0

			if var_316_8 < arg_313_1.time_ and arg_313_1.time_ <= var_316_8 + arg_316_0 and not isNil(var_316_7) and arg_313_1.var_.actorSpriteComps10092_1 == nil then
				arg_313_1.var_.actorSpriteComps10092_1 = var_316_7:GetComponentsInChildren(typeof(Image), true)
			end

			local var_316_9 = 2

			if var_316_8 <= arg_313_1.time_ and arg_313_1.time_ < var_316_8 + var_316_9 and not isNil(var_316_7) then
				local var_316_10 = (arg_313_1.time_ - var_316_8) / var_316_9

				if arg_313_1.var_.actorSpriteComps10092_1 then
					for iter_316_1, iter_316_2 in pairs(arg_313_1.var_.actorSpriteComps10092_1:ToTable()) do
						if iter_316_2 then
							if arg_313_1.isInRecall_ then
								local var_316_11 = Mathf.Lerp(iter_316_2.color.r, arg_313_1.hightColor1.r, var_316_10)
								local var_316_12 = Mathf.Lerp(iter_316_2.color.g, arg_313_1.hightColor1.g, var_316_10)
								local var_316_13 = Mathf.Lerp(iter_316_2.color.b, arg_313_1.hightColor1.b, var_316_10)

								iter_316_2.color = Color.New(var_316_11, var_316_12, var_316_13)
							else
								local var_316_14 = Mathf.Lerp(iter_316_2.color.r, 1, var_316_10)

								iter_316_2.color = Color.New(var_316_14, var_316_14, var_316_14)
							end
						end
					end
				end
			end

			if arg_313_1.time_ >= var_316_8 + var_316_9 and arg_313_1.time_ < var_316_8 + var_316_9 + arg_316_0 and not isNil(var_316_7) and arg_313_1.var_.actorSpriteComps10092_1 then
				for iter_316_3, iter_316_4 in pairs(arg_313_1.var_.actorSpriteComps10092_1:ToTable()) do
					if iter_316_4 then
						if arg_313_1.isInRecall_ then
							iter_316_4.color = arg_313_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_316_4.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_313_1.var_.actorSpriteComps10092_1 = nil
			end

			local var_316_15 = 0
			local var_316_16 = 0.325

			if var_316_15 < arg_313_1.time_ and arg_313_1.time_ <= var_316_15 + arg_316_0 then
				arg_313_1.talkMaxDuration = 0
				arg_313_1.dialogCg_.alpha = 1

				arg_313_1.dialog_:SetActive(true)
				SetActive(arg_313_1.leftNameGo_, true)

				local var_316_17 = arg_313_1:FormatText(StoryNameCfg[996].name)

				arg_313_1.leftNameTxt_.text = var_316_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_313_1.leftNameTxt_.transform)

				arg_313_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_313_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_313_1:RecordName(arg_313_1.leftNameTxt_.text)
				SetActive(arg_313_1.iconTrs_.gameObject, false)
				arg_313_1.callingController_:SetSelectedState("normal")

				local var_316_18 = arg_313_1:GetWordFromCfg(413141075)
				local var_316_19 = arg_313_1:FormatText(var_316_18.content)

				arg_313_1.text_.text = var_316_19

				LuaForUtil.ClearLinePrefixSymbol(arg_313_1.text_)

				local var_316_20 = 13
				local var_316_21 = utf8.len(var_316_19)
				local var_316_22 = var_316_20 <= 0 and var_316_16 or var_316_16 * (var_316_21 / var_316_20)

				if var_316_22 > 0 and var_316_16 < var_316_22 then
					arg_313_1.talkMaxDuration = var_316_22

					if var_316_22 + var_316_15 > arg_313_1.duration_ then
						arg_313_1.duration_ = var_316_22 + var_316_15
					end
				end

				arg_313_1.text_.text = var_316_19
				arg_313_1.typewritter.percent = 0

				arg_313_1.typewritter:SetDirty()
				arg_313_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_413141", "413141075", "story_v_out_413141.awb") ~= 0 then
					local var_316_23 = manager.audio:GetVoiceLength("story_v_out_413141", "413141075", "story_v_out_413141.awb") / 1000

					if var_316_23 + var_316_15 > arg_313_1.duration_ then
						arg_313_1.duration_ = var_316_23 + var_316_15
					end

					if var_316_18.prefab_name ~= "" and arg_313_1.actors_[var_316_18.prefab_name] ~= nil then
						local var_316_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_313_1.actors_[var_316_18.prefab_name].transform, "story_v_out_413141", "413141075", "story_v_out_413141.awb")

						arg_313_1:RecordAudio("413141075", var_316_24)
						arg_313_1:RecordAudio("413141075", var_316_24)
					else
						arg_313_1:AudioAction("play", "voice", "story_v_out_413141", "413141075", "story_v_out_413141.awb")
					end

					arg_313_1:RecordHistoryTalkVoice("story_v_out_413141", "413141075", "story_v_out_413141.awb")
				end

				arg_313_1:RecordContent(arg_313_1.text_.text)
			end

			local var_316_25 = math.max(var_316_16, arg_313_1.talkMaxDuration)

			if var_316_15 <= arg_313_1.time_ and arg_313_1.time_ < var_316_15 + var_316_25 then
				arg_313_1.typewritter.percent = (arg_313_1.time_ - var_316_15) / var_316_25

				arg_313_1.typewritter:SetDirty()
			end

			if arg_313_1.time_ >= var_316_15 + var_316_25 and arg_313_1.time_ < var_316_15 + var_316_25 + arg_316_0 then
				arg_313_1.typewritter.percent = 1

				arg_313_1.typewritter:SetDirty()
				arg_313_1:ShowNextGo(true)
			end
		end

		arg_313_1.nodeConfigList_ = {
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

		arg_313_1:InitPlayNodeList()
	end,
	Play413141076 = function(arg_317_0, arg_317_1)
		arg_317_1.time_ = 0
		arg_317_1.frameCnt_ = 0
		arg_317_1.state_ = "playing"
		arg_317_1.curTalkId_ = 413141076
		arg_317_1.duration_ = 5

		SetActive(arg_317_1.tipsGo_, false)

		function arg_317_1.onSingleLineFinish_()
			arg_317_1.onSingleLineUpdate_ = nil
			arg_317_1.onSingleLineFinish_ = nil
			arg_317_1.state_ = "waiting"
		end

		function arg_317_1.playNext_(arg_319_0)
			if arg_319_0 == 1 then
				arg_317_0:Play413141077(arg_317_1)
			end
		end

		function arg_317_1.onSingleLineUpdate_(arg_320_0)
			local var_320_0 = arg_317_1.actors_["10092_1"].transform
			local var_320_1 = 0

			if var_320_1 < arg_317_1.time_ and arg_317_1.time_ <= var_320_1 + arg_320_0 then
				arg_317_1.var_.moveOldPos10092_1 = var_320_0.localPosition
				var_320_0.localScale = Vector3.New(1, 1, 1)

				arg_317_1:CheckSpriteTmpPos("10092_1", 7)

				local var_320_2 = var_320_0.childCount

				for iter_320_0 = 0, var_320_2 - 1 do
					local var_320_3 = var_320_0:GetChild(iter_320_0)

					if var_320_3.name == "" or not string.find(var_320_3.name, "split") then
						var_320_3.gameObject:SetActive(true)
					else
						var_320_3.gameObject:SetActive(false)
					end
				end
			end

			local var_320_4 = 0.001

			if var_320_1 <= arg_317_1.time_ and arg_317_1.time_ < var_320_1 + var_320_4 then
				local var_320_5 = (arg_317_1.time_ - var_320_1) / var_320_4
				local var_320_6 = Vector3.New(0, -2000, 0)

				var_320_0.localPosition = Vector3.Lerp(arg_317_1.var_.moveOldPos10092_1, var_320_6, var_320_5)
			end

			if arg_317_1.time_ >= var_320_1 + var_320_4 and arg_317_1.time_ < var_320_1 + var_320_4 + arg_320_0 then
				var_320_0.localPosition = Vector3.New(0, -2000, 0)
			end

			local var_320_7 = arg_317_1.actors_["10092_1"]
			local var_320_8 = 0

			if var_320_8 < arg_317_1.time_ and arg_317_1.time_ <= var_320_8 + arg_320_0 and not isNil(var_320_7) and arg_317_1.var_.actorSpriteComps10092_1 == nil then
				arg_317_1.var_.actorSpriteComps10092_1 = var_320_7:GetComponentsInChildren(typeof(Image), true)
			end

			local var_320_9 = 2

			if var_320_8 <= arg_317_1.time_ and arg_317_1.time_ < var_320_8 + var_320_9 and not isNil(var_320_7) then
				local var_320_10 = (arg_317_1.time_ - var_320_8) / var_320_9

				if arg_317_1.var_.actorSpriteComps10092_1 then
					for iter_320_1, iter_320_2 in pairs(arg_317_1.var_.actorSpriteComps10092_1:ToTable()) do
						if iter_320_2 then
							if arg_317_1.isInRecall_ then
								local var_320_11 = Mathf.Lerp(iter_320_2.color.r, arg_317_1.hightColor2.r, var_320_10)
								local var_320_12 = Mathf.Lerp(iter_320_2.color.g, arg_317_1.hightColor2.g, var_320_10)
								local var_320_13 = Mathf.Lerp(iter_320_2.color.b, arg_317_1.hightColor2.b, var_320_10)

								iter_320_2.color = Color.New(var_320_11, var_320_12, var_320_13)
							else
								local var_320_14 = Mathf.Lerp(iter_320_2.color.r, 0.5, var_320_10)

								iter_320_2.color = Color.New(var_320_14, var_320_14, var_320_14)
							end
						end
					end
				end
			end

			if arg_317_1.time_ >= var_320_8 + var_320_9 and arg_317_1.time_ < var_320_8 + var_320_9 + arg_320_0 and not isNil(var_320_7) and arg_317_1.var_.actorSpriteComps10092_1 then
				for iter_320_3, iter_320_4 in pairs(arg_317_1.var_.actorSpriteComps10092_1:ToTable()) do
					if iter_320_4 then
						if arg_317_1.isInRecall_ then
							iter_320_4.color = arg_317_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_320_4.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_317_1.var_.actorSpriteComps10092_1 = nil
			end

			local var_320_15 = arg_317_1.actors_["10093"].transform
			local var_320_16 = 0

			if var_320_16 < arg_317_1.time_ and arg_317_1.time_ <= var_320_16 + arg_320_0 then
				arg_317_1.var_.moveOldPos10093 = var_320_15.localPosition
				var_320_15.localScale = Vector3.New(1, 1, 1)

				arg_317_1:CheckSpriteTmpPos("10093", 7)

				local var_320_17 = var_320_15.childCount

				for iter_320_5 = 0, var_320_17 - 1 do
					local var_320_18 = var_320_15:GetChild(iter_320_5)

					if var_320_18.name == "" or not string.find(var_320_18.name, "split") then
						var_320_18.gameObject:SetActive(true)
					else
						var_320_18.gameObject:SetActive(false)
					end
				end
			end

			local var_320_19 = 0.001

			if var_320_16 <= arg_317_1.time_ and arg_317_1.time_ < var_320_16 + var_320_19 then
				local var_320_20 = (arg_317_1.time_ - var_320_16) / var_320_19
				local var_320_21 = Vector3.New(0, -2000, 0)

				var_320_15.localPosition = Vector3.Lerp(arg_317_1.var_.moveOldPos10093, var_320_21, var_320_20)
			end

			if arg_317_1.time_ >= var_320_16 + var_320_19 and arg_317_1.time_ < var_320_16 + var_320_19 + arg_320_0 then
				var_320_15.localPosition = Vector3.New(0, -2000, 0)
			end

			local var_320_22 = 0
			local var_320_23 = 0.8

			if var_320_22 < arg_317_1.time_ and arg_317_1.time_ <= var_320_22 + arg_320_0 then
				arg_317_1.talkMaxDuration = 0
				arg_317_1.dialogCg_.alpha = 1

				arg_317_1.dialog_:SetActive(true)
				SetActive(arg_317_1.leftNameGo_, false)

				arg_317_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_317_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_317_1:RecordName(arg_317_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_317_1.iconTrs_.gameObject, false)
				arg_317_1.callingController_:SetSelectedState("normal")

				local var_320_24 = arg_317_1:GetWordFromCfg(413141076)
				local var_320_25 = arg_317_1:FormatText(var_320_24.content)

				arg_317_1.text_.text = var_320_25

				LuaForUtil.ClearLinePrefixSymbol(arg_317_1.text_)

				local var_320_26 = 32
				local var_320_27 = utf8.len(var_320_25)
				local var_320_28 = var_320_26 <= 0 and var_320_23 or var_320_23 * (var_320_27 / var_320_26)

				if var_320_28 > 0 and var_320_23 < var_320_28 then
					arg_317_1.talkMaxDuration = var_320_28

					if var_320_28 + var_320_22 > arg_317_1.duration_ then
						arg_317_1.duration_ = var_320_28 + var_320_22
					end
				end

				arg_317_1.text_.text = var_320_25
				arg_317_1.typewritter.percent = 0

				arg_317_1.typewritter:SetDirty()
				arg_317_1:ShowNextGo(false)
				arg_317_1:RecordContent(arg_317_1.text_.text)
			end

			local var_320_29 = math.max(var_320_23, arg_317_1.talkMaxDuration)

			if var_320_22 <= arg_317_1.time_ and arg_317_1.time_ < var_320_22 + var_320_29 then
				arg_317_1.typewritter.percent = (arg_317_1.time_ - var_320_22) / var_320_29

				arg_317_1.typewritter:SetDirty()
			end

			if arg_317_1.time_ >= var_320_22 + var_320_29 and arg_317_1.time_ < var_320_22 + var_320_29 + arg_320_0 then
				arg_317_1.typewritter.percent = 1

				arg_317_1.typewritter:SetDirty()
				arg_317_1:ShowNextGo(true)
			end
		end

		arg_317_1.nodeConfigList_ = {
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

		arg_317_1:InitPlayNodeList()
	end,
	Play413141077 = function(arg_321_0, arg_321_1)
		arg_321_1.time_ = 0
		arg_321_1.frameCnt_ = 0
		arg_321_1.state_ = "playing"
		arg_321_1.curTalkId_ = 413141077
		arg_321_1.duration_ = 7.7

		local var_321_0 = {
			zh = 5.166,
			ja = 7.7
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
				arg_321_0:Play413141078(arg_321_1)
			end
		end

		function arg_321_1.onSingleLineUpdate_(arg_324_0)
			local var_324_0 = arg_321_1.actors_["10093"].transform
			local var_324_1 = 0

			if var_324_1 < arg_321_1.time_ and arg_321_1.time_ <= var_324_1 + arg_324_0 then
				arg_321_1.var_.moveOldPos10093 = var_324_0.localPosition
				var_324_0.localScale = Vector3.New(1, 1, 1)

				arg_321_1:CheckSpriteTmpPos("10093", 4)

				local var_324_2 = var_324_0.childCount

				for iter_324_0 = 0, var_324_2 - 1 do
					local var_324_3 = var_324_0:GetChild(iter_324_0)

					if var_324_3.name == "split_4" or not string.find(var_324_3.name, "split") then
						var_324_3.gameObject:SetActive(true)
					else
						var_324_3.gameObject:SetActive(false)
					end
				end
			end

			local var_324_4 = 0.001

			if var_324_1 <= arg_321_1.time_ and arg_321_1.time_ < var_324_1 + var_324_4 then
				local var_324_5 = (arg_321_1.time_ - var_324_1) / var_324_4
				local var_324_6 = Vector3.New(390, -345, -245)

				var_324_0.localPosition = Vector3.Lerp(arg_321_1.var_.moveOldPos10093, var_324_6, var_324_5)
			end

			if arg_321_1.time_ >= var_324_1 + var_324_4 and arg_321_1.time_ < var_324_1 + var_324_4 + arg_324_0 then
				var_324_0.localPosition = Vector3.New(390, -345, -245)
			end

			local var_324_7 = arg_321_1.actors_["10093"]
			local var_324_8 = 0

			if var_324_8 < arg_321_1.time_ and arg_321_1.time_ <= var_324_8 + arg_324_0 and not isNil(var_324_7) and arg_321_1.var_.actorSpriteComps10093 == nil then
				arg_321_1.var_.actorSpriteComps10093 = var_324_7:GetComponentsInChildren(typeof(Image), true)
			end

			local var_324_9 = 2

			if var_324_8 <= arg_321_1.time_ and arg_321_1.time_ < var_324_8 + var_324_9 and not isNil(var_324_7) then
				local var_324_10 = (arg_321_1.time_ - var_324_8) / var_324_9

				if arg_321_1.var_.actorSpriteComps10093 then
					for iter_324_1, iter_324_2 in pairs(arg_321_1.var_.actorSpriteComps10093:ToTable()) do
						if iter_324_2 then
							if arg_321_1.isInRecall_ then
								local var_324_11 = Mathf.Lerp(iter_324_2.color.r, arg_321_1.hightColor1.r, var_324_10)
								local var_324_12 = Mathf.Lerp(iter_324_2.color.g, arg_321_1.hightColor1.g, var_324_10)
								local var_324_13 = Mathf.Lerp(iter_324_2.color.b, arg_321_1.hightColor1.b, var_324_10)

								iter_324_2.color = Color.New(var_324_11, var_324_12, var_324_13)
							else
								local var_324_14 = Mathf.Lerp(iter_324_2.color.r, 1, var_324_10)

								iter_324_2.color = Color.New(var_324_14, var_324_14, var_324_14)
							end
						end
					end
				end
			end

			if arg_321_1.time_ >= var_324_8 + var_324_9 and arg_321_1.time_ < var_324_8 + var_324_9 + arg_324_0 and not isNil(var_324_7) and arg_321_1.var_.actorSpriteComps10093 then
				for iter_324_3, iter_324_4 in pairs(arg_321_1.var_.actorSpriteComps10093:ToTable()) do
					if iter_324_4 then
						if arg_321_1.isInRecall_ then
							iter_324_4.color = arg_321_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_324_4.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_321_1.var_.actorSpriteComps10093 = nil
			end

			local var_324_15 = 0
			local var_324_16 = 0.525

			if var_324_15 < arg_321_1.time_ and arg_321_1.time_ <= var_324_15 + arg_324_0 then
				arg_321_1.talkMaxDuration = 0
				arg_321_1.dialogCg_.alpha = 1

				arg_321_1.dialog_:SetActive(true)
				SetActive(arg_321_1.leftNameGo_, true)

				local var_324_17 = arg_321_1:FormatText(StoryNameCfg[28].name)

				arg_321_1.leftNameTxt_.text = var_324_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_321_1.leftNameTxt_.transform)

				arg_321_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_321_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_321_1:RecordName(arg_321_1.leftNameTxt_.text)
				SetActive(arg_321_1.iconTrs_.gameObject, false)
				arg_321_1.callingController_:SetSelectedState("normal")

				local var_324_18 = arg_321_1:GetWordFromCfg(413141077)
				local var_324_19 = arg_321_1:FormatText(var_324_18.content)

				arg_321_1.text_.text = var_324_19

				LuaForUtil.ClearLinePrefixSymbol(arg_321_1.text_)

				local var_324_20 = 21
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

				if manager.audio:GetVoiceLength("story_v_out_413141", "413141077", "story_v_out_413141.awb") ~= 0 then
					local var_324_23 = manager.audio:GetVoiceLength("story_v_out_413141", "413141077", "story_v_out_413141.awb") / 1000

					if var_324_23 + var_324_15 > arg_321_1.duration_ then
						arg_321_1.duration_ = var_324_23 + var_324_15
					end

					if var_324_18.prefab_name ~= "" and arg_321_1.actors_[var_324_18.prefab_name] ~= nil then
						local var_324_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_321_1.actors_[var_324_18.prefab_name].transform, "story_v_out_413141", "413141077", "story_v_out_413141.awb")

						arg_321_1:RecordAudio("413141077", var_324_24)
						arg_321_1:RecordAudio("413141077", var_324_24)
					else
						arg_321_1:AudioAction("play", "voice", "story_v_out_413141", "413141077", "story_v_out_413141.awb")
					end

					arg_321_1:RecordHistoryTalkVoice("story_v_out_413141", "413141077", "story_v_out_413141.awb")
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
				actorName = "10093",
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
	Play413141078 = function(arg_325_0, arg_325_1)
		arg_325_1.time_ = 0
		arg_325_1.frameCnt_ = 0
		arg_325_1.state_ = "playing"
		arg_325_1.curTalkId_ = 413141078
		arg_325_1.duration_ = 13.83

		local var_325_0 = {
			zh = 13.833,
			ja = 7.366
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
				arg_325_0:Play413141079(arg_325_1)
			end
		end

		function arg_325_1.onSingleLineUpdate_(arg_328_0)
			local var_328_0 = arg_325_1.actors_["10092_1"].transform
			local var_328_1 = 0

			if var_328_1 < arg_325_1.time_ and arg_325_1.time_ <= var_328_1 + arg_328_0 then
				arg_325_1.var_.moveOldPos10092_1 = var_328_0.localPosition
				var_328_0.localScale = Vector3.New(1, 1, 1)

				arg_325_1:CheckSpriteTmpPos("10092_1", 2)

				local var_328_2 = var_328_0.childCount

				for iter_328_0 = 0, var_328_2 - 1 do
					local var_328_3 = var_328_0:GetChild(iter_328_0)

					if var_328_3.name == "split_8" or not string.find(var_328_3.name, "split") then
						var_328_3.gameObject:SetActive(true)
					else
						var_328_3.gameObject:SetActive(false)
					end
				end
			end

			local var_328_4 = 0.001

			if var_328_1 <= arg_325_1.time_ and arg_325_1.time_ < var_328_1 + var_328_4 then
				local var_328_5 = (arg_325_1.time_ - var_328_1) / var_328_4
				local var_328_6 = Vector3.New(-389.49, -300, -295)

				var_328_0.localPosition = Vector3.Lerp(arg_325_1.var_.moveOldPos10092_1, var_328_6, var_328_5)
			end

			if arg_325_1.time_ >= var_328_1 + var_328_4 and arg_325_1.time_ < var_328_1 + var_328_4 + arg_328_0 then
				var_328_0.localPosition = Vector3.New(-389.49, -300, -295)
			end

			local var_328_7 = arg_325_1.actors_["10092_1"]
			local var_328_8 = 0

			if var_328_8 < arg_325_1.time_ and arg_325_1.time_ <= var_328_8 + arg_328_0 and not isNil(var_328_7) and arg_325_1.var_.actorSpriteComps10092_1 == nil then
				arg_325_1.var_.actorSpriteComps10092_1 = var_328_7:GetComponentsInChildren(typeof(Image), true)
			end

			local var_328_9 = 2

			if var_328_8 <= arg_325_1.time_ and arg_325_1.time_ < var_328_8 + var_328_9 and not isNil(var_328_7) then
				local var_328_10 = (arg_325_1.time_ - var_328_8) / var_328_9

				if arg_325_1.var_.actorSpriteComps10092_1 then
					for iter_328_1, iter_328_2 in pairs(arg_325_1.var_.actorSpriteComps10092_1:ToTable()) do
						if iter_328_2 then
							if arg_325_1.isInRecall_ then
								local var_328_11 = Mathf.Lerp(iter_328_2.color.r, arg_325_1.hightColor1.r, var_328_10)
								local var_328_12 = Mathf.Lerp(iter_328_2.color.g, arg_325_1.hightColor1.g, var_328_10)
								local var_328_13 = Mathf.Lerp(iter_328_2.color.b, arg_325_1.hightColor1.b, var_328_10)

								iter_328_2.color = Color.New(var_328_11, var_328_12, var_328_13)
							else
								local var_328_14 = Mathf.Lerp(iter_328_2.color.r, 1, var_328_10)

								iter_328_2.color = Color.New(var_328_14, var_328_14, var_328_14)
							end
						end
					end
				end
			end

			if arg_325_1.time_ >= var_328_8 + var_328_9 and arg_325_1.time_ < var_328_8 + var_328_9 + arg_328_0 and not isNil(var_328_7) and arg_325_1.var_.actorSpriteComps10092_1 then
				for iter_328_3, iter_328_4 in pairs(arg_325_1.var_.actorSpriteComps10092_1:ToTable()) do
					if iter_328_4 then
						if arg_325_1.isInRecall_ then
							iter_328_4.color = arg_325_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_328_4.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_325_1.var_.actorSpriteComps10092_1 = nil
			end

			local var_328_15 = arg_325_1.actors_["10093"]
			local var_328_16 = 0

			if var_328_16 < arg_325_1.time_ and arg_325_1.time_ <= var_328_16 + arg_328_0 and not isNil(var_328_15) and arg_325_1.var_.actorSpriteComps10093 == nil then
				arg_325_1.var_.actorSpriteComps10093 = var_328_15:GetComponentsInChildren(typeof(Image), true)
			end

			local var_328_17 = 2

			if var_328_16 <= arg_325_1.time_ and arg_325_1.time_ < var_328_16 + var_328_17 and not isNil(var_328_15) then
				local var_328_18 = (arg_325_1.time_ - var_328_16) / var_328_17

				if arg_325_1.var_.actorSpriteComps10093 then
					for iter_328_5, iter_328_6 in pairs(arg_325_1.var_.actorSpriteComps10093:ToTable()) do
						if iter_328_6 then
							if arg_325_1.isInRecall_ then
								local var_328_19 = Mathf.Lerp(iter_328_6.color.r, arg_325_1.hightColor2.r, var_328_18)
								local var_328_20 = Mathf.Lerp(iter_328_6.color.g, arg_325_1.hightColor2.g, var_328_18)
								local var_328_21 = Mathf.Lerp(iter_328_6.color.b, arg_325_1.hightColor2.b, var_328_18)

								iter_328_6.color = Color.New(var_328_19, var_328_20, var_328_21)
							else
								local var_328_22 = Mathf.Lerp(iter_328_6.color.r, 0.5, var_328_18)

								iter_328_6.color = Color.New(var_328_22, var_328_22, var_328_22)
							end
						end
					end
				end
			end

			if arg_325_1.time_ >= var_328_16 + var_328_17 and arg_325_1.time_ < var_328_16 + var_328_17 + arg_328_0 and not isNil(var_328_15) and arg_325_1.var_.actorSpriteComps10093 then
				for iter_328_7, iter_328_8 in pairs(arg_325_1.var_.actorSpriteComps10093:ToTable()) do
					if iter_328_8 then
						if arg_325_1.isInRecall_ then
							iter_328_8.color = arg_325_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_328_8.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_325_1.var_.actorSpriteComps10093 = nil
			end

			local var_328_23 = 0
			local var_328_24 = 1.2

			if var_328_23 < arg_325_1.time_ and arg_325_1.time_ <= var_328_23 + arg_328_0 then
				arg_325_1.talkMaxDuration = 0
				arg_325_1.dialogCg_.alpha = 1

				arg_325_1.dialog_:SetActive(true)
				SetActive(arg_325_1.leftNameGo_, true)

				local var_328_25 = arg_325_1:FormatText(StoryNameCfg[996].name)

				arg_325_1.leftNameTxt_.text = var_328_25

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_325_1.leftNameTxt_.transform)

				arg_325_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_325_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_325_1:RecordName(arg_325_1.leftNameTxt_.text)
				SetActive(arg_325_1.iconTrs_.gameObject, false)
				arg_325_1.callingController_:SetSelectedState("normal")

				local var_328_26 = arg_325_1:GetWordFromCfg(413141078)
				local var_328_27 = arg_325_1:FormatText(var_328_26.content)

				arg_325_1.text_.text = var_328_27

				LuaForUtil.ClearLinePrefixSymbol(arg_325_1.text_)

				local var_328_28 = 48
				local var_328_29 = utf8.len(var_328_27)
				local var_328_30 = var_328_28 <= 0 and var_328_24 or var_328_24 * (var_328_29 / var_328_28)

				if var_328_30 > 0 and var_328_24 < var_328_30 then
					arg_325_1.talkMaxDuration = var_328_30

					if var_328_30 + var_328_23 > arg_325_1.duration_ then
						arg_325_1.duration_ = var_328_30 + var_328_23
					end
				end

				arg_325_1.text_.text = var_328_27
				arg_325_1.typewritter.percent = 0

				arg_325_1.typewritter:SetDirty()
				arg_325_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_413141", "413141078", "story_v_out_413141.awb") ~= 0 then
					local var_328_31 = manager.audio:GetVoiceLength("story_v_out_413141", "413141078", "story_v_out_413141.awb") / 1000

					if var_328_31 + var_328_23 > arg_325_1.duration_ then
						arg_325_1.duration_ = var_328_31 + var_328_23
					end

					if var_328_26.prefab_name ~= "" and arg_325_1.actors_[var_328_26.prefab_name] ~= nil then
						local var_328_32 = LuaForUtil.PlayVoiceWithCriLipsync(arg_325_1.actors_[var_328_26.prefab_name].transform, "story_v_out_413141", "413141078", "story_v_out_413141.awb")

						arg_325_1:RecordAudio("413141078", var_328_32)
						arg_325_1:RecordAudio("413141078", var_328_32)
					else
						arg_325_1:AudioAction("play", "voice", "story_v_out_413141", "413141078", "story_v_out_413141.awb")
					end

					arg_325_1:RecordHistoryTalkVoice("story_v_out_413141", "413141078", "story_v_out_413141.awb")
				end

				arg_325_1:RecordContent(arg_325_1.text_.text)
			end

			local var_328_33 = math.max(var_328_24, arg_325_1.talkMaxDuration)

			if var_328_23 <= arg_325_1.time_ and arg_325_1.time_ < var_328_23 + var_328_33 then
				arg_325_1.typewritter.percent = (arg_325_1.time_ - var_328_23) / var_328_33

				arg_325_1.typewritter:SetDirty()
			end

			if arg_325_1.time_ >= var_328_23 + var_328_33 and arg_325_1.time_ < var_328_23 + var_328_33 + arg_328_0 then
				arg_325_1.typewritter.percent = 1

				arg_325_1.typewritter:SetDirty()
				arg_325_1:ShowNextGo(true)
			end
		end

		arg_325_1.nodeConfigList_ = {
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

		arg_325_1:InitPlayNodeList()
	end,
	Play413141079 = function(arg_329_0, arg_329_1)
		arg_329_1.time_ = 0
		arg_329_1.frameCnt_ = 0
		arg_329_1.state_ = "playing"
		arg_329_1.curTalkId_ = 413141079
		arg_329_1.duration_ = 6.83

		local var_329_0 = {
			zh = 6.833,
			ja = 5.3
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
				arg_329_0:Play413141080(arg_329_1)
			end
		end

		function arg_329_1.onSingleLineUpdate_(arg_332_0)
			local var_332_0 = arg_329_1.actors_["10092_1"]
			local var_332_1 = 0

			if var_332_1 < arg_329_1.time_ and arg_329_1.time_ <= var_332_1 + arg_332_0 and not isNil(var_332_0) and arg_329_1.var_.actorSpriteComps10092_1 == nil then
				arg_329_1.var_.actorSpriteComps10092_1 = var_332_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_332_2 = 2

			if var_332_1 <= arg_329_1.time_ and arg_329_1.time_ < var_332_1 + var_332_2 and not isNil(var_332_0) then
				local var_332_3 = (arg_329_1.time_ - var_332_1) / var_332_2

				if arg_329_1.var_.actorSpriteComps10092_1 then
					for iter_332_0, iter_332_1 in pairs(arg_329_1.var_.actorSpriteComps10092_1:ToTable()) do
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

			if arg_329_1.time_ >= var_332_1 + var_332_2 and arg_329_1.time_ < var_332_1 + var_332_2 + arg_332_0 and not isNil(var_332_0) and arg_329_1.var_.actorSpriteComps10092_1 then
				for iter_332_2, iter_332_3 in pairs(arg_329_1.var_.actorSpriteComps10092_1:ToTable()) do
					if iter_332_3 then
						if arg_329_1.isInRecall_ then
							iter_332_3.color = arg_329_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_332_3.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_329_1.var_.actorSpriteComps10092_1 = nil
			end

			local var_332_8 = 0
			local var_332_9 = 0.65

			if var_332_8 < arg_329_1.time_ and arg_329_1.time_ <= var_332_8 + arg_332_0 then
				arg_329_1.talkMaxDuration = 0
				arg_329_1.dialogCg_.alpha = 1

				arg_329_1.dialog_:SetActive(true)
				SetActive(arg_329_1.leftNameGo_, true)

				local var_332_10 = arg_329_1:FormatText(StoryNameCfg[996].name)

				arg_329_1.leftNameTxt_.text = var_332_10

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_329_1.leftNameTxt_.transform)

				arg_329_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_329_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_329_1:RecordName(arg_329_1.leftNameTxt_.text)
				SetActive(arg_329_1.iconTrs_.gameObject, false)
				arg_329_1.callingController_:SetSelectedState("normal")

				local var_332_11 = arg_329_1:GetWordFromCfg(413141079)
				local var_332_12 = arg_329_1:FormatText(var_332_11.content)

				arg_329_1.text_.text = var_332_12

				LuaForUtil.ClearLinePrefixSymbol(arg_329_1.text_)

				local var_332_13 = 26
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

				if manager.audio:GetVoiceLength("story_v_out_413141", "413141079", "story_v_out_413141.awb") ~= 0 then
					local var_332_16 = manager.audio:GetVoiceLength("story_v_out_413141", "413141079", "story_v_out_413141.awb") / 1000

					if var_332_16 + var_332_8 > arg_329_1.duration_ then
						arg_329_1.duration_ = var_332_16 + var_332_8
					end

					if var_332_11.prefab_name ~= "" and arg_329_1.actors_[var_332_11.prefab_name] ~= nil then
						local var_332_17 = LuaForUtil.PlayVoiceWithCriLipsync(arg_329_1.actors_[var_332_11.prefab_name].transform, "story_v_out_413141", "413141079", "story_v_out_413141.awb")

						arg_329_1:RecordAudio("413141079", var_332_17)
						arg_329_1:RecordAudio("413141079", var_332_17)
					else
						arg_329_1:AudioAction("play", "voice", "story_v_out_413141", "413141079", "story_v_out_413141.awb")
					end

					arg_329_1:RecordHistoryTalkVoice("story_v_out_413141", "413141079", "story_v_out_413141.awb")
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
	Play413141080 = function(arg_333_0, arg_333_1)
		arg_333_1.time_ = 0
		arg_333_1.frameCnt_ = 0
		arg_333_1.state_ = "playing"
		arg_333_1.curTalkId_ = 413141080
		arg_333_1.duration_ = 5

		SetActive(arg_333_1.tipsGo_, false)

		function arg_333_1.onSingleLineFinish_()
			arg_333_1.onSingleLineUpdate_ = nil
			arg_333_1.onSingleLineFinish_ = nil
			arg_333_1.state_ = "waiting"
		end

		function arg_333_1.playNext_(arg_335_0)
			if arg_335_0 == 1 then
				arg_333_0:Play413141081(arg_333_1)
			end
		end

		function arg_333_1.onSingleLineUpdate_(arg_336_0)
			local var_336_0 = arg_333_1.actors_["10092_1"].transform
			local var_336_1 = 0

			if var_336_1 < arg_333_1.time_ and arg_333_1.time_ <= var_336_1 + arg_336_0 then
				arg_333_1.var_.moveOldPos10092_1 = var_336_0.localPosition
				var_336_0.localScale = Vector3.New(1, 1, 1)

				arg_333_1:CheckSpriteTmpPos("10092_1", 6)

				local var_336_2 = var_336_0.childCount

				for iter_336_0 = 0, var_336_2 - 1 do
					local var_336_3 = var_336_0:GetChild(iter_336_0)

					if var_336_3.name == "" or not string.find(var_336_3.name, "split") then
						var_336_3.gameObject:SetActive(true)
					else
						var_336_3.gameObject:SetActive(false)
					end
				end
			end

			local var_336_4 = 0.001

			if var_336_1 <= arg_333_1.time_ and arg_333_1.time_ < var_336_1 + var_336_4 then
				local var_336_5 = (arg_333_1.time_ - var_336_1) / var_336_4
				local var_336_6 = Vector3.New(1500, -300, -295)

				var_336_0.localPosition = Vector3.Lerp(arg_333_1.var_.moveOldPos10092_1, var_336_6, var_336_5)
			end

			if arg_333_1.time_ >= var_336_1 + var_336_4 and arg_333_1.time_ < var_336_1 + var_336_4 + arg_336_0 then
				var_336_0.localPosition = Vector3.New(1500, -300, -295)
			end

			local var_336_7 = arg_333_1.actors_["10093"].transform
			local var_336_8 = 0

			if var_336_8 < arg_333_1.time_ and arg_333_1.time_ <= var_336_8 + arg_336_0 then
				arg_333_1.var_.moveOldPos10093 = var_336_7.localPosition
				var_336_7.localScale = Vector3.New(1, 1, 1)

				arg_333_1:CheckSpriteTmpPos("10093", 6)

				local var_336_9 = var_336_7.childCount

				for iter_336_1 = 0, var_336_9 - 1 do
					local var_336_10 = var_336_7:GetChild(iter_336_1)

					if var_336_10.name == "" or not string.find(var_336_10.name, "split") then
						var_336_10.gameObject:SetActive(true)
					else
						var_336_10.gameObject:SetActive(false)
					end
				end
			end

			local var_336_11 = 0.001

			if var_336_8 <= arg_333_1.time_ and arg_333_1.time_ < var_336_8 + var_336_11 then
				local var_336_12 = (arg_333_1.time_ - var_336_8) / var_336_11
				local var_336_13 = Vector3.New(1500, -345, -245)

				var_336_7.localPosition = Vector3.Lerp(arg_333_1.var_.moveOldPos10093, var_336_13, var_336_12)
			end

			if arg_333_1.time_ >= var_336_8 + var_336_11 and arg_333_1.time_ < var_336_8 + var_336_11 + arg_336_0 then
				var_336_7.localPosition = Vector3.New(1500, -345, -245)
			end

			local var_336_14 = arg_333_1.actors_["10092"]
			local var_336_15 = 0

			if var_336_15 < arg_333_1.time_ and arg_333_1.time_ <= var_336_15 + arg_336_0 and not isNil(var_336_14) and arg_333_1.var_.actorSpriteComps10092 == nil then
				arg_333_1.var_.actorSpriteComps10092 = var_336_14:GetComponentsInChildren(typeof(Image), true)
			end

			local var_336_16 = 2

			if var_336_15 <= arg_333_1.time_ and arg_333_1.time_ < var_336_15 + var_336_16 and not isNil(var_336_14) then
				local var_336_17 = (arg_333_1.time_ - var_336_15) / var_336_16

				if arg_333_1.var_.actorSpriteComps10092 then
					for iter_336_2, iter_336_3 in pairs(arg_333_1.var_.actorSpriteComps10092:ToTable()) do
						if iter_336_3 then
							if arg_333_1.isInRecall_ then
								local var_336_18 = Mathf.Lerp(iter_336_3.color.r, arg_333_1.hightColor2.r, var_336_17)
								local var_336_19 = Mathf.Lerp(iter_336_3.color.g, arg_333_1.hightColor2.g, var_336_17)
								local var_336_20 = Mathf.Lerp(iter_336_3.color.b, arg_333_1.hightColor2.b, var_336_17)

								iter_336_3.color = Color.New(var_336_18, var_336_19, var_336_20)
							else
								local var_336_21 = Mathf.Lerp(iter_336_3.color.r, 0.5, var_336_17)

								iter_336_3.color = Color.New(var_336_21, var_336_21, var_336_21)
							end
						end
					end
				end
			end

			if arg_333_1.time_ >= var_336_15 + var_336_16 and arg_333_1.time_ < var_336_15 + var_336_16 + arg_336_0 and not isNil(var_336_14) and arg_333_1.var_.actorSpriteComps10092 then
				for iter_336_4, iter_336_5 in pairs(arg_333_1.var_.actorSpriteComps10092:ToTable()) do
					if iter_336_5 then
						if arg_333_1.isInRecall_ then
							iter_336_5.color = arg_333_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_336_5.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_333_1.var_.actorSpriteComps10092 = nil
			end

			local var_336_22 = arg_333_1.actors_["10093"]
			local var_336_23 = 0

			if var_336_23 < arg_333_1.time_ and arg_333_1.time_ <= var_336_23 + arg_336_0 and not isNil(var_336_22) and arg_333_1.var_.actorSpriteComps10093 == nil then
				arg_333_1.var_.actorSpriteComps10093 = var_336_22:GetComponentsInChildren(typeof(Image), true)
			end

			local var_336_24 = 2

			if var_336_23 <= arg_333_1.time_ and arg_333_1.time_ < var_336_23 + var_336_24 and not isNil(var_336_22) then
				local var_336_25 = (arg_333_1.time_ - var_336_23) / var_336_24

				if arg_333_1.var_.actorSpriteComps10093 then
					for iter_336_6, iter_336_7 in pairs(arg_333_1.var_.actorSpriteComps10093:ToTable()) do
						if iter_336_7 then
							if arg_333_1.isInRecall_ then
								local var_336_26 = Mathf.Lerp(iter_336_7.color.r, arg_333_1.hightColor2.r, var_336_25)
								local var_336_27 = Mathf.Lerp(iter_336_7.color.g, arg_333_1.hightColor2.g, var_336_25)
								local var_336_28 = Mathf.Lerp(iter_336_7.color.b, arg_333_1.hightColor2.b, var_336_25)

								iter_336_7.color = Color.New(var_336_26, var_336_27, var_336_28)
							else
								local var_336_29 = Mathf.Lerp(iter_336_7.color.r, 0.5, var_336_25)

								iter_336_7.color = Color.New(var_336_29, var_336_29, var_336_29)
							end
						end
					end
				end
			end

			if arg_333_1.time_ >= var_336_23 + var_336_24 and arg_333_1.time_ < var_336_23 + var_336_24 + arg_336_0 and not isNil(var_336_22) and arg_333_1.var_.actorSpriteComps10093 then
				for iter_336_8, iter_336_9 in pairs(arg_333_1.var_.actorSpriteComps10093:ToTable()) do
					if iter_336_9 then
						if arg_333_1.isInRecall_ then
							iter_336_9.color = arg_333_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_336_9.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_333_1.var_.actorSpriteComps10093 = nil
			end

			local var_336_30 = 0
			local var_336_31 = 0.925

			if var_336_30 < arg_333_1.time_ and arg_333_1.time_ <= var_336_30 + arg_336_0 then
				arg_333_1.talkMaxDuration = 0
				arg_333_1.dialogCg_.alpha = 1

				arg_333_1.dialog_:SetActive(true)
				SetActive(arg_333_1.leftNameGo_, false)

				arg_333_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_333_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_333_1:RecordName(arg_333_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_333_1.iconTrs_.gameObject, false)
				arg_333_1.callingController_:SetSelectedState("normal")

				local var_336_32 = arg_333_1:GetWordFromCfg(413141080)
				local var_336_33 = arg_333_1:FormatText(var_336_32.content)

				arg_333_1.text_.text = var_336_33

				LuaForUtil.ClearLinePrefixSymbol(arg_333_1.text_)

				local var_336_34 = 37
				local var_336_35 = utf8.len(var_336_33)
				local var_336_36 = var_336_34 <= 0 and var_336_31 or var_336_31 * (var_336_35 / var_336_34)

				if var_336_36 > 0 and var_336_31 < var_336_36 then
					arg_333_1.talkMaxDuration = var_336_36

					if var_336_36 + var_336_30 > arg_333_1.duration_ then
						arg_333_1.duration_ = var_336_36 + var_336_30
					end
				end

				arg_333_1.text_.text = var_336_33
				arg_333_1.typewritter.percent = 0

				arg_333_1.typewritter:SetDirty()
				arg_333_1:ShowNextGo(false)
				arg_333_1:RecordContent(arg_333_1.text_.text)
			end

			local var_336_37 = math.max(var_336_31, arg_333_1.talkMaxDuration)

			if var_336_30 <= arg_333_1.time_ and arg_333_1.time_ < var_336_30 + var_336_37 then
				arg_333_1.typewritter.percent = (arg_333_1.time_ - var_336_30) / var_336_37

				arg_333_1.typewritter:SetDirty()
			end

			if arg_333_1.time_ >= var_336_30 + var_336_37 and arg_333_1.time_ < var_336_30 + var_336_37 + arg_336_0 then
				arg_333_1.typewritter.percent = 1

				arg_333_1.typewritter:SetDirty()
				arg_333_1:ShowNextGo(true)
			end
		end

		arg_333_1.nodeConfigList_ = {
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

		arg_333_1:InitPlayNodeList()
	end,
	Play413141081 = function(arg_337_0, arg_337_1)
		arg_337_1.time_ = 0
		arg_337_1.frameCnt_ = 0
		arg_337_1.state_ = "playing"
		arg_337_1.curTalkId_ = 413141081
		arg_337_1.duration_ = 7.63

		local var_337_0 = {
			zh = 6.033,
			ja = 7.633
		}
		local var_337_1 = manager.audio:GetLocalizationFlag()

		if var_337_0[var_337_1] ~= nil then
			arg_337_1.duration_ = var_337_0[var_337_1]
		end

		SetActive(arg_337_1.tipsGo_, false)

		function arg_337_1.onSingleLineFinish_()
			arg_337_1.onSingleLineUpdate_ = nil
			arg_337_1.onSingleLineFinish_ = nil
			arg_337_1.state_ = "waiting"
		end

		function arg_337_1.playNext_(arg_339_0)
			if arg_339_0 == 1 then
				arg_337_0:Play413141082(arg_337_1)
			end
		end

		function arg_337_1.onSingleLineUpdate_(arg_340_0)
			local var_340_0 = arg_337_1.actors_["10092_1"].transform
			local var_340_1 = 0

			if var_340_1 < arg_337_1.time_ and arg_337_1.time_ <= var_340_1 + arg_340_0 then
				arg_337_1.var_.moveOldPos10092_1 = var_340_0.localPosition
				var_340_0.localScale = Vector3.New(1, 1, 1)

				arg_337_1:CheckSpriteTmpPos("10092_1", 3)

				local var_340_2 = var_340_0.childCount

				for iter_340_0 = 0, var_340_2 - 1 do
					local var_340_3 = var_340_0:GetChild(iter_340_0)

					if var_340_3.name == "split_8" or not string.find(var_340_3.name, "split") then
						var_340_3.gameObject:SetActive(true)
					else
						var_340_3.gameObject:SetActive(false)
					end
				end
			end

			local var_340_4 = 0.001

			if var_340_1 <= arg_337_1.time_ and arg_337_1.time_ < var_340_1 + var_340_4 then
				local var_340_5 = (arg_337_1.time_ - var_340_1) / var_340_4
				local var_340_6 = Vector3.New(0, -300, -295)

				var_340_0.localPosition = Vector3.Lerp(arg_337_1.var_.moveOldPos10092_1, var_340_6, var_340_5)
			end

			if arg_337_1.time_ >= var_340_1 + var_340_4 and arg_337_1.time_ < var_340_1 + var_340_4 + arg_340_0 then
				var_340_0.localPosition = Vector3.New(0, -300, -295)
			end

			local var_340_7 = arg_337_1.actors_["10092_1"]
			local var_340_8 = 0

			if var_340_8 < arg_337_1.time_ and arg_337_1.time_ <= var_340_8 + arg_340_0 and not isNil(var_340_7) and arg_337_1.var_.actorSpriteComps10092_1 == nil then
				arg_337_1.var_.actorSpriteComps10092_1 = var_340_7:GetComponentsInChildren(typeof(Image), true)
			end

			local var_340_9 = 2

			if var_340_8 <= arg_337_1.time_ and arg_337_1.time_ < var_340_8 + var_340_9 and not isNil(var_340_7) then
				local var_340_10 = (arg_337_1.time_ - var_340_8) / var_340_9

				if arg_337_1.var_.actorSpriteComps10092_1 then
					for iter_340_1, iter_340_2 in pairs(arg_337_1.var_.actorSpriteComps10092_1:ToTable()) do
						if iter_340_2 then
							if arg_337_1.isInRecall_ then
								local var_340_11 = Mathf.Lerp(iter_340_2.color.r, arg_337_1.hightColor1.r, var_340_10)
								local var_340_12 = Mathf.Lerp(iter_340_2.color.g, arg_337_1.hightColor1.g, var_340_10)
								local var_340_13 = Mathf.Lerp(iter_340_2.color.b, arg_337_1.hightColor1.b, var_340_10)

								iter_340_2.color = Color.New(var_340_11, var_340_12, var_340_13)
							else
								local var_340_14 = Mathf.Lerp(iter_340_2.color.r, 1, var_340_10)

								iter_340_2.color = Color.New(var_340_14, var_340_14, var_340_14)
							end
						end
					end
				end
			end

			if arg_337_1.time_ >= var_340_8 + var_340_9 and arg_337_1.time_ < var_340_8 + var_340_9 + arg_340_0 and not isNil(var_340_7) and arg_337_1.var_.actorSpriteComps10092_1 then
				for iter_340_3, iter_340_4 in pairs(arg_337_1.var_.actorSpriteComps10092_1:ToTable()) do
					if iter_340_4 then
						if arg_337_1.isInRecall_ then
							iter_340_4.color = arg_337_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_340_4.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_337_1.var_.actorSpriteComps10092_1 = nil
			end

			local var_340_15 = 0
			local var_340_16 = 0.55

			if var_340_15 < arg_337_1.time_ and arg_337_1.time_ <= var_340_15 + arg_340_0 then
				arg_337_1.talkMaxDuration = 0
				arg_337_1.dialogCg_.alpha = 1

				arg_337_1.dialog_:SetActive(true)
				SetActive(arg_337_1.leftNameGo_, true)

				local var_340_17 = arg_337_1:FormatText(StoryNameCfg[996].name)

				arg_337_1.leftNameTxt_.text = var_340_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_337_1.leftNameTxt_.transform)

				arg_337_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_337_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_337_1:RecordName(arg_337_1.leftNameTxt_.text)
				SetActive(arg_337_1.iconTrs_.gameObject, false)
				arg_337_1.callingController_:SetSelectedState("normal")

				local var_340_18 = arg_337_1:GetWordFromCfg(413141081)
				local var_340_19 = arg_337_1:FormatText(var_340_18.content)

				arg_337_1.text_.text = var_340_19

				LuaForUtil.ClearLinePrefixSymbol(arg_337_1.text_)

				local var_340_20 = 22
				local var_340_21 = utf8.len(var_340_19)
				local var_340_22 = var_340_20 <= 0 and var_340_16 or var_340_16 * (var_340_21 / var_340_20)

				if var_340_22 > 0 and var_340_16 < var_340_22 then
					arg_337_1.talkMaxDuration = var_340_22

					if var_340_22 + var_340_15 > arg_337_1.duration_ then
						arg_337_1.duration_ = var_340_22 + var_340_15
					end
				end

				arg_337_1.text_.text = var_340_19
				arg_337_1.typewritter.percent = 0

				arg_337_1.typewritter:SetDirty()
				arg_337_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_413141", "413141081", "story_v_out_413141.awb") ~= 0 then
					local var_340_23 = manager.audio:GetVoiceLength("story_v_out_413141", "413141081", "story_v_out_413141.awb") / 1000

					if var_340_23 + var_340_15 > arg_337_1.duration_ then
						arg_337_1.duration_ = var_340_23 + var_340_15
					end

					if var_340_18.prefab_name ~= "" and arg_337_1.actors_[var_340_18.prefab_name] ~= nil then
						local var_340_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_337_1.actors_[var_340_18.prefab_name].transform, "story_v_out_413141", "413141081", "story_v_out_413141.awb")

						arg_337_1:RecordAudio("413141081", var_340_24)
						arg_337_1:RecordAudio("413141081", var_340_24)
					else
						arg_337_1:AudioAction("play", "voice", "story_v_out_413141", "413141081", "story_v_out_413141.awb")
					end

					arg_337_1:RecordHistoryTalkVoice("story_v_out_413141", "413141081", "story_v_out_413141.awb")
				end

				arg_337_1:RecordContent(arg_337_1.text_.text)
			end

			local var_340_25 = math.max(var_340_16, arg_337_1.talkMaxDuration)

			if var_340_15 <= arg_337_1.time_ and arg_337_1.time_ < var_340_15 + var_340_25 then
				arg_337_1.typewritter.percent = (arg_337_1.time_ - var_340_15) / var_340_25

				arg_337_1.typewritter:SetDirty()
			end

			if arg_337_1.time_ >= var_340_15 + var_340_25 and arg_337_1.time_ < var_340_15 + var_340_25 + arg_340_0 then
				arg_337_1.typewritter.percent = 1

				arg_337_1.typewritter:SetDirty()
				arg_337_1:ShowNextGo(true)
			end
		end

		arg_337_1.nodeConfigList_ = {
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

		arg_337_1:InitPlayNodeList()
	end,
	Play413141082 = function(arg_341_0, arg_341_1)
		arg_341_1.time_ = 0
		arg_341_1.frameCnt_ = 0
		arg_341_1.state_ = "playing"
		arg_341_1.curTalkId_ = 413141082
		arg_341_1.duration_ = 8.82

		local var_341_0 = {
			zh = 4.325,
			ja = 8.825
		}
		local var_341_1 = manager.audio:GetLocalizationFlag()

		if var_341_0[var_341_1] ~= nil then
			arg_341_1.duration_ = var_341_0[var_341_1]
		end

		SetActive(arg_341_1.tipsGo_, false)

		function arg_341_1.onSingleLineFinish_()
			arg_341_1.onSingleLineUpdate_ = nil
			arg_341_1.onSingleLineFinish_ = nil
			arg_341_1.state_ = "waiting"
		end

		function arg_341_1.playNext_(arg_343_0)
			if arg_343_0 == 1 then
				arg_341_0:Play413141083(arg_341_1)
			end
		end

		function arg_341_1.onSingleLineUpdate_(arg_344_0)
			local var_344_0 = arg_341_1.actors_["10092_1"].transform
			local var_344_1 = 0

			if var_344_1 < arg_341_1.time_ and arg_341_1.time_ <= var_344_1 + arg_344_0 then
				arg_341_1.var_.moveOldPos10092_1 = var_344_0.localPosition
				var_344_0.localScale = Vector3.New(1, 1, 1)

				arg_341_1:CheckSpriteTmpPos("10092_1", 3)

				local var_344_2 = var_344_0.childCount

				for iter_344_0 = 0, var_344_2 - 1 do
					local var_344_3 = var_344_0:GetChild(iter_344_0)

					if var_344_3.name == "" or not string.find(var_344_3.name, "split") then
						var_344_3.gameObject:SetActive(true)
					else
						var_344_3.gameObject:SetActive(false)
					end
				end
			end

			local var_344_4 = 0.001

			if var_344_1 <= arg_341_1.time_ and arg_341_1.time_ < var_344_1 + var_344_4 then
				local var_344_5 = (arg_341_1.time_ - var_344_1) / var_344_4
				local var_344_6 = Vector3.New(0, -300, -295)

				var_344_0.localPosition = Vector3.Lerp(arg_341_1.var_.moveOldPos10092_1, var_344_6, var_344_5)
			end

			if arg_341_1.time_ >= var_344_1 + var_344_4 and arg_341_1.time_ < var_344_1 + var_344_4 + arg_344_0 then
				var_344_0.localPosition = Vector3.New(0, -300, -295)
			end

			local var_344_7 = 0

			if var_344_7 < arg_341_1.time_ and arg_341_1.time_ <= var_344_7 + arg_344_0 then
				arg_341_1.allBtn_.enabled = false
			end

			local var_344_8 = 0.625

			if arg_341_1.time_ >= var_344_7 + var_344_8 and arg_341_1.time_ < var_344_7 + var_344_8 + arg_344_0 then
				arg_341_1.allBtn_.enabled = true
			end

			if arg_341_1.frameCnt_ <= 1 then
				arg_341_1.dialog_:SetActive(false)
			end

			local var_344_9 = 0.625
			local var_344_10 = 0.375

			if var_344_9 < arg_341_1.time_ and arg_341_1.time_ <= var_344_9 + arg_344_0 then
				arg_341_1.talkMaxDuration = 0

				arg_341_1.dialog_:SetActive(true)

				arg_341_1.dialogCg_.alpha = 0

				local var_344_11 = LeanTween.value(arg_341_1.dialog_, 0, 1, 0.3)

				var_344_11:setOnUpdate(LuaHelper.FloatAction(function(arg_345_0)
					arg_341_1.dialogCg_.alpha = arg_345_0
				end))
				var_344_11:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_341_1.dialog_)
					var_344_11:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_341_1.duration_ = arg_341_1.duration_ + 0.3

				SetActive(arg_341_1.leftNameGo_, true)

				local var_344_12 = arg_341_1:FormatText(StoryNameCfg[996].name)

				arg_341_1.leftNameTxt_.text = var_344_12

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_341_1.leftNameTxt_.transform)

				arg_341_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_341_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_341_1:RecordName(arg_341_1.leftNameTxt_.text)
				SetActive(arg_341_1.iconTrs_.gameObject, false)
				arg_341_1.callingController_:SetSelectedState("normal")

				local var_344_13 = arg_341_1:GetWordFromCfg(413141082)
				local var_344_14 = arg_341_1:FormatText(var_344_13.content)

				arg_341_1.text_.text = var_344_14

				LuaForUtil.ClearLinePrefixSymbol(arg_341_1.text_)

				local var_344_15 = 15
				local var_344_16 = utf8.len(var_344_14)
				local var_344_17 = var_344_15 <= 0 and var_344_10 or var_344_10 * (var_344_16 / var_344_15)

				if var_344_17 > 0 and var_344_10 < var_344_17 then
					arg_341_1.talkMaxDuration = var_344_17
					var_344_9 = var_344_9 + 0.3

					if var_344_17 + var_344_9 > arg_341_1.duration_ then
						arg_341_1.duration_ = var_344_17 + var_344_9
					end
				end

				arg_341_1.text_.text = var_344_14
				arg_341_1.typewritter.percent = 0

				arg_341_1.typewritter:SetDirty()
				arg_341_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_413141", "413141082", "story_v_out_413141.awb") ~= 0 then
					local var_344_18 = manager.audio:GetVoiceLength("story_v_out_413141", "413141082", "story_v_out_413141.awb") / 1000

					if var_344_18 + var_344_9 > arg_341_1.duration_ then
						arg_341_1.duration_ = var_344_18 + var_344_9
					end

					if var_344_13.prefab_name ~= "" and arg_341_1.actors_[var_344_13.prefab_name] ~= nil then
						local var_344_19 = LuaForUtil.PlayVoiceWithCriLipsync(arg_341_1.actors_[var_344_13.prefab_name].transform, "story_v_out_413141", "413141082", "story_v_out_413141.awb")

						arg_341_1:RecordAudio("413141082", var_344_19)
						arg_341_1:RecordAudio("413141082", var_344_19)
					else
						arg_341_1:AudioAction("play", "voice", "story_v_out_413141", "413141082", "story_v_out_413141.awb")
					end

					arg_341_1:RecordHistoryTalkVoice("story_v_out_413141", "413141082", "story_v_out_413141.awb")
				end

				arg_341_1:RecordContent(arg_341_1.text_.text)
			end

			local var_344_20 = var_344_9 + 0.3
			local var_344_21 = math.max(var_344_10, arg_341_1.talkMaxDuration)

			if var_344_20 <= arg_341_1.time_ and arg_341_1.time_ < var_344_20 + var_344_21 then
				arg_341_1.typewritter.percent = (arg_341_1.time_ - var_344_20) / var_344_21

				arg_341_1.typewritter:SetDirty()
			end

			if arg_341_1.time_ >= var_344_20 + var_344_21 and arg_341_1.time_ < var_344_20 + var_344_21 + arg_344_0 then
				arg_341_1.typewritter.percent = 1

				arg_341_1.typewritter:SetDirty()
				arg_341_1:ShowNextGo(true)
			end
		end

		arg_341_1.nodeConfigList_ = {
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

		arg_341_1:InitPlayNodeList()
	end,
	Play413141083 = function(arg_347_0, arg_347_1)
		arg_347_1.time_ = 0
		arg_347_1.frameCnt_ = 0
		arg_347_1.state_ = "playing"
		arg_347_1.curTalkId_ = 413141083
		arg_347_1.duration_ = 5

		SetActive(arg_347_1.tipsGo_, false)

		function arg_347_1.onSingleLineFinish_()
			arg_347_1.onSingleLineUpdate_ = nil
			arg_347_1.onSingleLineFinish_ = nil
			arg_347_1.state_ = "waiting"
		end

		function arg_347_1.playNext_(arg_349_0)
			if arg_349_0 == 1 then
				arg_347_0:Play413141084(arg_347_1)
			end
		end

		function arg_347_1.onSingleLineUpdate_(arg_350_0)
			local var_350_0 = arg_347_1.actors_["10092_1"]
			local var_350_1 = 0

			if var_350_1 < arg_347_1.time_ and arg_347_1.time_ <= var_350_1 + arg_350_0 and not isNil(var_350_0) and arg_347_1.var_.actorSpriteComps10092_1 == nil then
				arg_347_1.var_.actorSpriteComps10092_1 = var_350_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_350_2 = 0.2

			if var_350_1 <= arg_347_1.time_ and arg_347_1.time_ < var_350_1 + var_350_2 and not isNil(var_350_0) then
				local var_350_3 = (arg_347_1.time_ - var_350_1) / var_350_2

				if arg_347_1.var_.actorSpriteComps10092_1 then
					for iter_350_0, iter_350_1 in pairs(arg_347_1.var_.actorSpriteComps10092_1:ToTable()) do
						if iter_350_1 then
							if arg_347_1.isInRecall_ then
								local var_350_4 = Mathf.Lerp(iter_350_1.color.r, arg_347_1.hightColor2.r, var_350_3)
								local var_350_5 = Mathf.Lerp(iter_350_1.color.g, arg_347_1.hightColor2.g, var_350_3)
								local var_350_6 = Mathf.Lerp(iter_350_1.color.b, arg_347_1.hightColor2.b, var_350_3)

								iter_350_1.color = Color.New(var_350_4, var_350_5, var_350_6)
							else
								local var_350_7 = Mathf.Lerp(iter_350_1.color.r, 0.5, var_350_3)

								iter_350_1.color = Color.New(var_350_7, var_350_7, var_350_7)
							end
						end
					end
				end
			end

			if arg_347_1.time_ >= var_350_1 + var_350_2 and arg_347_1.time_ < var_350_1 + var_350_2 + arg_350_0 and not isNil(var_350_0) and arg_347_1.var_.actorSpriteComps10092_1 then
				for iter_350_2, iter_350_3 in pairs(arg_347_1.var_.actorSpriteComps10092_1:ToTable()) do
					if iter_350_3 then
						if arg_347_1.isInRecall_ then
							iter_350_3.color = arg_347_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_350_3.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_347_1.var_.actorSpriteComps10092_1 = nil
			end

			local var_350_8 = 0
			local var_350_9 = 1.1

			if var_350_8 < arg_347_1.time_ and arg_347_1.time_ <= var_350_8 + arg_350_0 then
				arg_347_1.talkMaxDuration = 0
				arg_347_1.dialogCg_.alpha = 1

				arg_347_1.dialog_:SetActive(true)
				SetActive(arg_347_1.leftNameGo_, false)

				arg_347_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_347_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_347_1:RecordName(arg_347_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_347_1.iconTrs_.gameObject, false)
				arg_347_1.callingController_:SetSelectedState("normal")

				local var_350_10 = arg_347_1:GetWordFromCfg(413141083)
				local var_350_11 = arg_347_1:FormatText(var_350_10.content)

				arg_347_1.text_.text = var_350_11

				LuaForUtil.ClearLinePrefixSymbol(arg_347_1.text_)

				local var_350_12 = 44
				local var_350_13 = utf8.len(var_350_11)
				local var_350_14 = var_350_12 <= 0 and var_350_9 or var_350_9 * (var_350_13 / var_350_12)

				if var_350_14 > 0 and var_350_9 < var_350_14 then
					arg_347_1.talkMaxDuration = var_350_14

					if var_350_14 + var_350_8 > arg_347_1.duration_ then
						arg_347_1.duration_ = var_350_14 + var_350_8
					end
				end

				arg_347_1.text_.text = var_350_11
				arg_347_1.typewritter.percent = 0

				arg_347_1.typewritter:SetDirty()
				arg_347_1:ShowNextGo(false)
				arg_347_1:RecordContent(arg_347_1.text_.text)
			end

			local var_350_15 = math.max(var_350_9, arg_347_1.talkMaxDuration)

			if var_350_8 <= arg_347_1.time_ and arg_347_1.time_ < var_350_8 + var_350_15 then
				arg_347_1.typewritter.percent = (arg_347_1.time_ - var_350_8) / var_350_15

				arg_347_1.typewritter:SetDirty()
			end

			if arg_347_1.time_ >= var_350_8 + var_350_15 and arg_347_1.time_ < var_350_8 + var_350_15 + arg_350_0 then
				arg_347_1.typewritter.percent = 1

				arg_347_1.typewritter:SetDirty()
				arg_347_1:ShowNextGo(true)
			end
		end

		arg_347_1.nodeConfigList_ = {}

		arg_347_1:InitPlayNodeList()
	end,
	Play413141084 = function(arg_351_0, arg_351_1)
		arg_351_1.time_ = 0
		arg_351_1.frameCnt_ = 0
		arg_351_1.state_ = "playing"
		arg_351_1.curTalkId_ = 413141084
		arg_351_1.duration_ = 5

		SetActive(arg_351_1.tipsGo_, false)

		function arg_351_1.onSingleLineFinish_()
			arg_351_1.onSingleLineUpdate_ = nil
			arg_351_1.onSingleLineFinish_ = nil
			arg_351_1.state_ = "waiting"
		end

		function arg_351_1.playNext_(arg_353_0)
			if arg_353_0 == 1 then
				arg_351_0:Play413141085(arg_351_1)
			end
		end

		function arg_351_1.onSingleLineUpdate_(arg_354_0)
			local var_354_0 = 0
			local var_354_1 = 0.625

			if var_354_0 < arg_351_1.time_ and arg_351_1.time_ <= var_354_0 + arg_354_0 then
				arg_351_1.talkMaxDuration = 0
				arg_351_1.dialogCg_.alpha = 1

				arg_351_1.dialog_:SetActive(true)
				SetActive(arg_351_1.leftNameGo_, false)

				arg_351_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_351_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_351_1:RecordName(arg_351_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_351_1.iconTrs_.gameObject, false)
				arg_351_1.callingController_:SetSelectedState("normal")

				local var_354_2 = arg_351_1:GetWordFromCfg(413141084)
				local var_354_3 = arg_351_1:FormatText(var_354_2.content)

				arg_351_1.text_.text = var_354_3

				LuaForUtil.ClearLinePrefixSymbol(arg_351_1.text_)

				local var_354_4 = 25
				local var_354_5 = utf8.len(var_354_3)
				local var_354_6 = var_354_4 <= 0 and var_354_1 or var_354_1 * (var_354_5 / var_354_4)

				if var_354_6 > 0 and var_354_1 < var_354_6 then
					arg_351_1.talkMaxDuration = var_354_6

					if var_354_6 + var_354_0 > arg_351_1.duration_ then
						arg_351_1.duration_ = var_354_6 + var_354_0
					end
				end

				arg_351_1.text_.text = var_354_3
				arg_351_1.typewritter.percent = 0

				arg_351_1.typewritter:SetDirty()
				arg_351_1:ShowNextGo(false)
				arg_351_1:RecordContent(arg_351_1.text_.text)
			end

			local var_354_7 = math.max(var_354_1, arg_351_1.talkMaxDuration)

			if var_354_0 <= arg_351_1.time_ and arg_351_1.time_ < var_354_0 + var_354_7 then
				arg_351_1.typewritter.percent = (arg_351_1.time_ - var_354_0) / var_354_7

				arg_351_1.typewritter:SetDirty()
			end

			if arg_351_1.time_ >= var_354_0 + var_354_7 and arg_351_1.time_ < var_354_0 + var_354_7 + arg_354_0 then
				arg_351_1.typewritter.percent = 1

				arg_351_1.typewritter:SetDirty()
				arg_351_1:ShowNextGo(true)
			end
		end

		arg_351_1.nodeConfigList_ = {}

		arg_351_1:InitPlayNodeList()
	end,
	Play413141085 = function(arg_355_0, arg_355_1)
		arg_355_1.time_ = 0
		arg_355_1.frameCnt_ = 0
		arg_355_1.state_ = "playing"
		arg_355_1.curTalkId_ = 413141085
		arg_355_1.duration_ = 3.77

		local var_355_0 = {
			zh = 3.766,
			ja = 3.366
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
				arg_355_0:Play413141086(arg_355_1)
			end
		end

		function arg_355_1.onSingleLineUpdate_(arg_358_0)
			local var_358_0 = arg_355_1.actors_["10093"].transform
			local var_358_1 = 0

			if var_358_1 < arg_355_1.time_ and arg_355_1.time_ <= var_358_1 + arg_358_0 then
				arg_355_1.var_.moveOldPos10093 = var_358_0.localPosition
				var_358_0.localScale = Vector3.New(1, 1, 1)

				arg_355_1:CheckSpriteTmpPos("10093", 3)

				local var_358_2 = var_358_0.childCount

				for iter_358_0 = 0, var_358_2 - 1 do
					local var_358_3 = var_358_0:GetChild(iter_358_0)

					if var_358_3.name == "split_3" or not string.find(var_358_3.name, "split") then
						var_358_3.gameObject:SetActive(true)
					else
						var_358_3.gameObject:SetActive(false)
					end
				end
			end

			local var_358_4 = 0.001

			if var_358_1 <= arg_355_1.time_ and arg_355_1.time_ < var_358_1 + var_358_4 then
				local var_358_5 = (arg_355_1.time_ - var_358_1) / var_358_4
				local var_358_6 = Vector3.New(0, -345, -245)

				var_358_0.localPosition = Vector3.Lerp(arg_355_1.var_.moveOldPos10093, var_358_6, var_358_5)
			end

			if arg_355_1.time_ >= var_358_1 + var_358_4 and arg_355_1.time_ < var_358_1 + var_358_4 + arg_358_0 then
				var_358_0.localPosition = Vector3.New(0, -345, -245)
			end

			local var_358_7 = arg_355_1.actors_["10093"]
			local var_358_8 = 0

			if var_358_8 < arg_355_1.time_ and arg_355_1.time_ <= var_358_8 + arg_358_0 and not isNil(var_358_7) and arg_355_1.var_.actorSpriteComps10093 == nil then
				arg_355_1.var_.actorSpriteComps10093 = var_358_7:GetComponentsInChildren(typeof(Image), true)
			end

			local var_358_9 = 2

			if var_358_8 <= arg_355_1.time_ and arg_355_1.time_ < var_358_8 + var_358_9 and not isNil(var_358_7) then
				local var_358_10 = (arg_355_1.time_ - var_358_8) / var_358_9

				if arg_355_1.var_.actorSpriteComps10093 then
					for iter_358_1, iter_358_2 in pairs(arg_355_1.var_.actorSpriteComps10093:ToTable()) do
						if iter_358_2 then
							if arg_355_1.isInRecall_ then
								local var_358_11 = Mathf.Lerp(iter_358_2.color.r, arg_355_1.hightColor1.r, var_358_10)
								local var_358_12 = Mathf.Lerp(iter_358_2.color.g, arg_355_1.hightColor1.g, var_358_10)
								local var_358_13 = Mathf.Lerp(iter_358_2.color.b, arg_355_1.hightColor1.b, var_358_10)

								iter_358_2.color = Color.New(var_358_11, var_358_12, var_358_13)
							else
								local var_358_14 = Mathf.Lerp(iter_358_2.color.r, 1, var_358_10)

								iter_358_2.color = Color.New(var_358_14, var_358_14, var_358_14)
							end
						end
					end
				end
			end

			if arg_355_1.time_ >= var_358_8 + var_358_9 and arg_355_1.time_ < var_358_8 + var_358_9 + arg_358_0 and not isNil(var_358_7) and arg_355_1.var_.actorSpriteComps10093 then
				for iter_358_3, iter_358_4 in pairs(arg_355_1.var_.actorSpriteComps10093:ToTable()) do
					if iter_358_4 then
						if arg_355_1.isInRecall_ then
							iter_358_4.color = arg_355_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_358_4.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_355_1.var_.actorSpriteComps10093 = nil
			end

			local var_358_15 = 0
			local var_358_16 = 0.475

			if var_358_15 < arg_355_1.time_ and arg_355_1.time_ <= var_358_15 + arg_358_0 then
				arg_355_1.talkMaxDuration = 0
				arg_355_1.dialogCg_.alpha = 1

				arg_355_1.dialog_:SetActive(true)
				SetActive(arg_355_1.leftNameGo_, true)

				local var_358_17 = arg_355_1:FormatText(StoryNameCfg[28].name)

				arg_355_1.leftNameTxt_.text = var_358_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_355_1.leftNameTxt_.transform)

				arg_355_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_355_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_355_1:RecordName(arg_355_1.leftNameTxt_.text)
				SetActive(arg_355_1.iconTrs_.gameObject, false)
				arg_355_1.callingController_:SetSelectedState("normal")

				local var_358_18 = arg_355_1:GetWordFromCfg(413141085)
				local var_358_19 = arg_355_1:FormatText(var_358_18.content)

				arg_355_1.text_.text = var_358_19

				LuaForUtil.ClearLinePrefixSymbol(arg_355_1.text_)

				local var_358_20 = 19
				local var_358_21 = utf8.len(var_358_19)
				local var_358_22 = var_358_20 <= 0 and var_358_16 or var_358_16 * (var_358_21 / var_358_20)

				if var_358_22 > 0 and var_358_16 < var_358_22 then
					arg_355_1.talkMaxDuration = var_358_22

					if var_358_22 + var_358_15 > arg_355_1.duration_ then
						arg_355_1.duration_ = var_358_22 + var_358_15
					end
				end

				arg_355_1.text_.text = var_358_19
				arg_355_1.typewritter.percent = 0

				arg_355_1.typewritter:SetDirty()
				arg_355_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_413141", "413141085", "story_v_out_413141.awb") ~= 0 then
					local var_358_23 = manager.audio:GetVoiceLength("story_v_out_413141", "413141085", "story_v_out_413141.awb") / 1000

					if var_358_23 + var_358_15 > arg_355_1.duration_ then
						arg_355_1.duration_ = var_358_23 + var_358_15
					end

					if var_358_18.prefab_name ~= "" and arg_355_1.actors_[var_358_18.prefab_name] ~= nil then
						local var_358_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_355_1.actors_[var_358_18.prefab_name].transform, "story_v_out_413141", "413141085", "story_v_out_413141.awb")

						arg_355_1:RecordAudio("413141085", var_358_24)
						arg_355_1:RecordAudio("413141085", var_358_24)
					else
						arg_355_1:AudioAction("play", "voice", "story_v_out_413141", "413141085", "story_v_out_413141.awb")
					end

					arg_355_1:RecordHistoryTalkVoice("story_v_out_413141", "413141085", "story_v_out_413141.awb")
				end

				arg_355_1:RecordContent(arg_355_1.text_.text)
			end

			local var_358_25 = math.max(var_358_16, arg_355_1.talkMaxDuration)

			if var_358_15 <= arg_355_1.time_ and arg_355_1.time_ < var_358_15 + var_358_25 then
				arg_355_1.typewritter.percent = (arg_355_1.time_ - var_358_15) / var_358_25

				arg_355_1.typewritter:SetDirty()
			end

			if arg_355_1.time_ >= var_358_15 + var_358_25 and arg_355_1.time_ < var_358_15 + var_358_25 + arg_358_0 then
				arg_355_1.typewritter.percent = 1

				arg_355_1.typewritter:SetDirty()
				arg_355_1:ShowNextGo(true)
			end
		end

		arg_355_1.nodeConfigList_ = {
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

		arg_355_1:InitPlayNodeList()
	end,
	Play413141086 = function(arg_359_0, arg_359_1)
		arg_359_1.time_ = 0
		arg_359_1.frameCnt_ = 0
		arg_359_1.state_ = "playing"
		arg_359_1.curTalkId_ = 413141086
		arg_359_1.duration_ = 5

		SetActive(arg_359_1.tipsGo_, false)

		function arg_359_1.onSingleLineFinish_()
			arg_359_1.onSingleLineUpdate_ = nil
			arg_359_1.onSingleLineFinish_ = nil
			arg_359_1.state_ = "waiting"
		end

		function arg_359_1.playNext_(arg_361_0)
			if arg_361_0 == 1 then
				arg_359_0:Play413141087(arg_359_1)
			end
		end

		function arg_359_1.onSingleLineUpdate_(arg_362_0)
			local var_362_0 = arg_359_1.actors_["10093"].transform
			local var_362_1 = 0

			if var_362_1 < arg_359_1.time_ and arg_359_1.time_ <= var_362_1 + arg_362_0 then
				arg_359_1.var_.moveOldPos10093 = var_362_0.localPosition
				var_362_0.localScale = Vector3.New(1, 1, 1)

				arg_359_1:CheckSpriteTmpPos("10093", 6)

				local var_362_2 = var_362_0.childCount

				for iter_362_0 = 0, var_362_2 - 1 do
					local var_362_3 = var_362_0:GetChild(iter_362_0)

					if var_362_3.name == "" or not string.find(var_362_3.name, "split") then
						var_362_3.gameObject:SetActive(true)
					else
						var_362_3.gameObject:SetActive(false)
					end
				end
			end

			local var_362_4 = 0.001

			if var_362_1 <= arg_359_1.time_ and arg_359_1.time_ < var_362_1 + var_362_4 then
				local var_362_5 = (arg_359_1.time_ - var_362_1) / var_362_4
				local var_362_6 = Vector3.New(1500, -345, -245)

				var_362_0.localPosition = Vector3.Lerp(arg_359_1.var_.moveOldPos10093, var_362_6, var_362_5)
			end

			if arg_359_1.time_ >= var_362_1 + var_362_4 and arg_359_1.time_ < var_362_1 + var_362_4 + arg_362_0 then
				var_362_0.localPosition = Vector3.New(1500, -345, -245)
			end

			local var_362_7 = arg_359_1.actors_["10093"]
			local var_362_8 = 0

			if var_362_8 < arg_359_1.time_ and arg_359_1.time_ <= var_362_8 + arg_362_0 and not isNil(var_362_7) and arg_359_1.var_.actorSpriteComps10093 == nil then
				arg_359_1.var_.actorSpriteComps10093 = var_362_7:GetComponentsInChildren(typeof(Image), true)
			end

			local var_362_9 = 2

			if var_362_8 <= arg_359_1.time_ and arg_359_1.time_ < var_362_8 + var_362_9 and not isNil(var_362_7) then
				local var_362_10 = (arg_359_1.time_ - var_362_8) / var_362_9

				if arg_359_1.var_.actorSpriteComps10093 then
					for iter_362_1, iter_362_2 in pairs(arg_359_1.var_.actorSpriteComps10093:ToTable()) do
						if iter_362_2 then
							if arg_359_1.isInRecall_ then
								local var_362_11 = Mathf.Lerp(iter_362_2.color.r, arg_359_1.hightColor2.r, var_362_10)
								local var_362_12 = Mathf.Lerp(iter_362_2.color.g, arg_359_1.hightColor2.g, var_362_10)
								local var_362_13 = Mathf.Lerp(iter_362_2.color.b, arg_359_1.hightColor2.b, var_362_10)

								iter_362_2.color = Color.New(var_362_11, var_362_12, var_362_13)
							else
								local var_362_14 = Mathf.Lerp(iter_362_2.color.r, 0.5, var_362_10)

								iter_362_2.color = Color.New(var_362_14, var_362_14, var_362_14)
							end
						end
					end
				end
			end

			if arg_359_1.time_ >= var_362_8 + var_362_9 and arg_359_1.time_ < var_362_8 + var_362_9 + arg_362_0 and not isNil(var_362_7) and arg_359_1.var_.actorSpriteComps10093 then
				for iter_362_3, iter_362_4 in pairs(arg_359_1.var_.actorSpriteComps10093:ToTable()) do
					if iter_362_4 then
						if arg_359_1.isInRecall_ then
							iter_362_4.color = arg_359_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_362_4.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_359_1.var_.actorSpriteComps10093 = nil
			end

			local var_362_15 = 0
			local var_362_16 = 0.75

			if var_362_15 < arg_359_1.time_ and arg_359_1.time_ <= var_362_15 + arg_362_0 then
				arg_359_1.talkMaxDuration = 0
				arg_359_1.dialogCg_.alpha = 1

				arg_359_1.dialog_:SetActive(true)
				SetActive(arg_359_1.leftNameGo_, false)

				arg_359_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_359_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_359_1:RecordName(arg_359_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_359_1.iconTrs_.gameObject, false)
				arg_359_1.callingController_:SetSelectedState("normal")

				local var_362_17 = arg_359_1:GetWordFromCfg(413141086)
				local var_362_18 = arg_359_1:FormatText(var_362_17.content)

				arg_359_1.text_.text = var_362_18

				LuaForUtil.ClearLinePrefixSymbol(arg_359_1.text_)

				local var_362_19 = 30
				local var_362_20 = utf8.len(var_362_18)
				local var_362_21 = var_362_19 <= 0 and var_362_16 or var_362_16 * (var_362_20 / var_362_19)

				if var_362_21 > 0 and var_362_16 < var_362_21 then
					arg_359_1.talkMaxDuration = var_362_21

					if var_362_21 + var_362_15 > arg_359_1.duration_ then
						arg_359_1.duration_ = var_362_21 + var_362_15
					end
				end

				arg_359_1.text_.text = var_362_18
				arg_359_1.typewritter.percent = 0

				arg_359_1.typewritter:SetDirty()
				arg_359_1:ShowNextGo(false)
				arg_359_1:RecordContent(arg_359_1.text_.text)
			end

			local var_362_22 = math.max(var_362_16, arg_359_1.talkMaxDuration)

			if var_362_15 <= arg_359_1.time_ and arg_359_1.time_ < var_362_15 + var_362_22 then
				arg_359_1.typewritter.percent = (arg_359_1.time_ - var_362_15) / var_362_22

				arg_359_1.typewritter:SetDirty()
			end

			if arg_359_1.time_ >= var_362_15 + var_362_22 and arg_359_1.time_ < var_362_15 + var_362_22 + arg_362_0 then
				arg_359_1.typewritter.percent = 1

				arg_359_1.typewritter:SetDirty()
				arg_359_1:ShowNextGo(true)
			end
		end

		arg_359_1.nodeConfigList_ = {
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

		arg_359_1:InitPlayNodeList()
	end,
	Play413141087 = function(arg_363_0, arg_363_1)
		arg_363_1.time_ = 0
		arg_363_1.frameCnt_ = 0
		arg_363_1.state_ = "playing"
		arg_363_1.curTalkId_ = 413141087
		arg_363_1.duration_ = 7

		SetActive(arg_363_1.tipsGo_, false)

		function arg_363_1.onSingleLineFinish_()
			arg_363_1.onSingleLineUpdate_ = nil
			arg_363_1.onSingleLineFinish_ = nil
			arg_363_1.state_ = "waiting"
		end

		function arg_363_1.playNext_(arg_365_0)
			if arg_365_0 == 1 then
				arg_363_0:Play413141088(arg_363_1)
			end
		end

		function arg_363_1.onSingleLineUpdate_(arg_366_0)
			local var_366_0 = "10022"

			if arg_363_1.actors_[var_366_0] == nil then
				local var_366_1 = Asset.Load("Widget/System/Story/StoryExpression/" .. "10022")

				if not isNil(var_366_1) then
					local var_366_2 = Object.Instantiate(var_366_1, arg_363_1.canvasGo_.transform)

					var_366_2.transform:SetSiblingIndex(1)

					var_366_2.name = var_366_0
					var_366_2.transform.localPosition = Vector3.New(0, 100000, 0)
					arg_363_1.actors_[var_366_0] = var_366_2

					local var_366_3 = var_366_2:GetComponentsInChildren(typeof(Image), true):ToTable()

					if arg_363_1.isInRecall_ then
						for iter_366_0, iter_366_1 in ipairs(var_366_3) do
							iter_366_1.color = arg_363_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						end
					end
				end
			end

			local var_366_4 = arg_363_1.actors_["10022"].transform
			local var_366_5 = 0

			if var_366_5 < arg_363_1.time_ and arg_363_1.time_ <= var_366_5 + arg_366_0 then
				arg_363_1.var_.moveOldPos10022 = var_366_4.localPosition
				var_366_4.localScale = Vector3.New(1, 1, 1)

				arg_363_1:CheckSpriteTmpPos("10022", 3)

				local var_366_6 = var_366_4.childCount

				for iter_366_2 = 0, var_366_6 - 1 do
					local var_366_7 = var_366_4:GetChild(iter_366_2)

					if var_366_7.name == "" or not string.find(var_366_7.name, "split") then
						var_366_7.gameObject:SetActive(true)
					else
						var_366_7.gameObject:SetActive(false)
					end
				end
			end

			local var_366_8 = 0.001

			if var_366_5 <= arg_363_1.time_ and arg_363_1.time_ < var_366_5 + var_366_8 then
				local var_366_9 = (arg_363_1.time_ - var_366_5) / var_366_8
				local var_366_10 = Vector3.New(0, -315, -320)

				var_366_4.localPosition = Vector3.Lerp(arg_363_1.var_.moveOldPos10022, var_366_10, var_366_9)
			end

			if arg_363_1.time_ >= var_366_5 + var_366_8 and arg_363_1.time_ < var_366_5 + var_366_8 + arg_366_0 then
				var_366_4.localPosition = Vector3.New(0, -315, -320)
			end

			local var_366_11 = arg_363_1.actors_["10022"]
			local var_366_12 = 0

			if var_366_12 < arg_363_1.time_ and arg_363_1.time_ <= var_366_12 + arg_366_0 then
				arg_363_1:SetSpriteNiuquEffect("10022", true)
			end

			local var_366_13 = arg_363_1.actors_["10022"]
			local var_366_14 = 0

			if var_366_14 < arg_363_1.time_ and arg_363_1.time_ <= var_366_14 + arg_366_0 then
				local var_366_15 = var_366_13:GetComponentInChildren(typeof(CanvasGroup))

				if var_366_15 then
					arg_363_1.var_.alphaOldValue10022 = var_366_15.alpha
					arg_363_1.var_.characterEffect10022 = var_366_15
				end
			end

			local var_366_16 = 0.5

			if var_366_14 <= arg_363_1.time_ and arg_363_1.time_ < var_366_14 + var_366_16 then
				local var_366_17 = (arg_363_1.time_ - var_366_14) / var_366_16
				local var_366_18 = Mathf.Lerp(arg_363_1.var_.alphaOldValue10022, 0.6, var_366_17)

				if arg_363_1.var_.characterEffect10022 then
					arg_363_1.var_.characterEffect10022.alpha = var_366_18
				end
			end

			if arg_363_1.time_ >= var_366_14 + var_366_16 and arg_363_1.time_ < var_366_14 + var_366_16 + arg_366_0 and arg_363_1.var_.characterEffect10022 then
				arg_363_1.var_.characterEffect10022.alpha = 0.6
			end

			local var_366_19 = 0
			local var_366_20 = 0.675

			if var_366_19 < arg_363_1.time_ and arg_363_1.time_ <= var_366_19 + arg_366_0 then
				arg_363_1.talkMaxDuration = 0
				arg_363_1.dialogCg_.alpha = 1

				arg_363_1.dialog_:SetActive(true)
				SetActive(arg_363_1.leftNameGo_, true)

				local var_366_21 = arg_363_1:FormatText(StoryNameCfg[614].name)

				arg_363_1.leftNameTxt_.text = var_366_21

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_363_1.leftNameTxt_.transform)

				arg_363_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_363_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_363_1:RecordName(arg_363_1.leftNameTxt_.text)
				SetActive(arg_363_1.iconTrs_.gameObject, false)
				arg_363_1.callingController_:SetSelectedState("normal")

				local var_366_22 = arg_363_1:GetWordFromCfg(413141087)
				local var_366_23 = arg_363_1:FormatText(var_366_22.content)

				arg_363_1.text_.text = var_366_23

				LuaForUtil.ClearLinePrefixSymbol(arg_363_1.text_)

				local var_366_24 = 27
				local var_366_25 = utf8.len(var_366_23)
				local var_366_26 = var_366_24 <= 0 and var_366_20 or var_366_20 * (var_366_25 / var_366_24)

				if var_366_26 > 0 and var_366_20 < var_366_26 then
					arg_363_1.talkMaxDuration = var_366_26

					if var_366_26 + var_366_19 > arg_363_1.duration_ then
						arg_363_1.duration_ = var_366_26 + var_366_19
					end
				end

				arg_363_1.text_.text = var_366_23
				arg_363_1.typewritter.percent = 0

				arg_363_1.typewritter:SetDirty()
				arg_363_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_413141", "413141087", "story_v_out_413141.awb") ~= 0 then
					local var_366_27 = manager.audio:GetVoiceLength("story_v_out_413141", "413141087", "story_v_out_413141.awb") / 1000

					if var_366_27 + var_366_19 > arg_363_1.duration_ then
						arg_363_1.duration_ = var_366_27 + var_366_19
					end

					if var_366_22.prefab_name ~= "" and arg_363_1.actors_[var_366_22.prefab_name] ~= nil then
						local var_366_28 = LuaForUtil.PlayVoiceWithCriLipsync(arg_363_1.actors_[var_366_22.prefab_name].transform, "story_v_out_413141", "413141087", "story_v_out_413141.awb")

						arg_363_1:RecordAudio("413141087", var_366_28)
						arg_363_1:RecordAudio("413141087", var_366_28)
					else
						arg_363_1:AudioAction("play", "voice", "story_v_out_413141", "413141087", "story_v_out_413141.awb")
					end

					arg_363_1:RecordHistoryTalkVoice("story_v_out_413141", "413141087", "story_v_out_413141.awb")
				end

				arg_363_1:RecordContent(arg_363_1.text_.text)
			end

			local var_366_29 = math.max(var_366_20, arg_363_1.talkMaxDuration)

			if var_366_19 <= arg_363_1.time_ and arg_363_1.time_ < var_366_19 + var_366_29 then
				arg_363_1.typewritter.percent = (arg_363_1.time_ - var_366_19) / var_366_29

				arg_363_1.typewritter:SetDirty()
			end

			if arg_363_1.time_ >= var_366_19 + var_366_29 and arg_363_1.time_ < var_366_19 + var_366_29 + arg_366_0 then
				arg_363_1.typewritter.percent = 1

				arg_363_1.typewritter:SetDirty()
				arg_363_1:ShowNextGo(true)
			end
		end

		arg_363_1.nodeConfigList_ = {
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

		arg_363_1:InitPlayNodeList()
	end,
	Play413141088 = function(arg_367_0, arg_367_1)
		arg_367_1.time_ = 0
		arg_367_1.frameCnt_ = 0
		arg_367_1.state_ = "playing"
		arg_367_1.curTalkId_ = 413141088
		arg_367_1.duration_ = 6.3

		local var_367_0 = {
			zh = 4.333,
			ja = 6.3
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
				arg_367_0:Play413141089(arg_367_1)
			end
		end

		function arg_367_1.onSingleLineUpdate_(arg_370_0)
			local var_370_0 = arg_367_1.actors_["10092_1"].transform
			local var_370_1 = 0

			if var_370_1 < arg_367_1.time_ and arg_367_1.time_ <= var_370_1 + arg_370_0 then
				arg_367_1.var_.moveOldPos10092_1 = var_370_0.localPosition
				var_370_0.localScale = Vector3.New(1, 1, 1)

				arg_367_1:CheckSpriteTmpPos("10092_1", 3)

				local var_370_2 = var_370_0.childCount

				for iter_370_0 = 0, var_370_2 - 1 do
					local var_370_3 = var_370_0:GetChild(iter_370_0)

					if var_370_3.name == "split_1_1" or not string.find(var_370_3.name, "split") then
						var_370_3.gameObject:SetActive(true)
					else
						var_370_3.gameObject:SetActive(false)
					end
				end
			end

			local var_370_4 = 0.001

			if var_370_1 <= arg_367_1.time_ and arg_367_1.time_ < var_370_1 + var_370_4 then
				local var_370_5 = (arg_367_1.time_ - var_370_1) / var_370_4
				local var_370_6 = Vector3.New(0, -300, -295)

				var_370_0.localPosition = Vector3.Lerp(arg_367_1.var_.moveOldPos10092_1, var_370_6, var_370_5)
			end

			if arg_367_1.time_ >= var_370_1 + var_370_4 and arg_367_1.time_ < var_370_1 + var_370_4 + arg_370_0 then
				var_370_0.localPosition = Vector3.New(0, -300, -295)
			end

			local var_370_7 = arg_367_1.actors_["10092_1"]
			local var_370_8 = 0

			if var_370_8 < arg_367_1.time_ and arg_367_1.time_ <= var_370_8 + arg_370_0 and not isNil(var_370_7) and arg_367_1.var_.actorSpriteComps10092_1 == nil then
				arg_367_1.var_.actorSpriteComps10092_1 = var_370_7:GetComponentsInChildren(typeof(Image), true)
			end

			local var_370_9 = 2

			if var_370_8 <= arg_367_1.time_ and arg_367_1.time_ < var_370_8 + var_370_9 and not isNil(var_370_7) then
				local var_370_10 = (arg_367_1.time_ - var_370_8) / var_370_9

				if arg_367_1.var_.actorSpriteComps10092_1 then
					for iter_370_1, iter_370_2 in pairs(arg_367_1.var_.actorSpriteComps10092_1:ToTable()) do
						if iter_370_2 then
							if arg_367_1.isInRecall_ then
								local var_370_11 = Mathf.Lerp(iter_370_2.color.r, arg_367_1.hightColor1.r, var_370_10)
								local var_370_12 = Mathf.Lerp(iter_370_2.color.g, arg_367_1.hightColor1.g, var_370_10)
								local var_370_13 = Mathf.Lerp(iter_370_2.color.b, arg_367_1.hightColor1.b, var_370_10)

								iter_370_2.color = Color.New(var_370_11, var_370_12, var_370_13)
							else
								local var_370_14 = Mathf.Lerp(iter_370_2.color.r, 1, var_370_10)

								iter_370_2.color = Color.New(var_370_14, var_370_14, var_370_14)
							end
						end
					end
				end
			end

			if arg_367_1.time_ >= var_370_8 + var_370_9 and arg_367_1.time_ < var_370_8 + var_370_9 + arg_370_0 and not isNil(var_370_7) and arg_367_1.var_.actorSpriteComps10092_1 then
				for iter_370_3, iter_370_4 in pairs(arg_367_1.var_.actorSpriteComps10092_1:ToTable()) do
					if iter_370_4 then
						if arg_367_1.isInRecall_ then
							iter_370_4.color = arg_367_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_370_4.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_367_1.var_.actorSpriteComps10092_1 = nil
			end

			local var_370_15 = 0
			local var_370_16 = 0.5

			if var_370_15 < arg_367_1.time_ and arg_367_1.time_ <= var_370_15 + arg_370_0 then
				arg_367_1.talkMaxDuration = 0
				arg_367_1.dialogCg_.alpha = 1

				arg_367_1.dialog_:SetActive(true)
				SetActive(arg_367_1.leftNameGo_, true)

				local var_370_17 = arg_367_1:FormatText(StoryNameCfg[996].name)

				arg_367_1.leftNameTxt_.text = var_370_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_367_1.leftNameTxt_.transform)

				arg_367_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_367_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_367_1:RecordName(arg_367_1.leftNameTxt_.text)
				SetActive(arg_367_1.iconTrs_.gameObject, false)
				arg_367_1.callingController_:SetSelectedState("normal")

				local var_370_18 = arg_367_1:GetWordFromCfg(413141088)
				local var_370_19 = arg_367_1:FormatText(var_370_18.content)

				arg_367_1.text_.text = var_370_19

				LuaForUtil.ClearLinePrefixSymbol(arg_367_1.text_)

				local var_370_20 = 20
				local var_370_21 = utf8.len(var_370_19)
				local var_370_22 = var_370_20 <= 0 and var_370_16 or var_370_16 * (var_370_21 / var_370_20)

				if var_370_22 > 0 and var_370_16 < var_370_22 then
					arg_367_1.talkMaxDuration = var_370_22

					if var_370_22 + var_370_15 > arg_367_1.duration_ then
						arg_367_1.duration_ = var_370_22 + var_370_15
					end
				end

				arg_367_1.text_.text = var_370_19
				arg_367_1.typewritter.percent = 0

				arg_367_1.typewritter:SetDirty()
				arg_367_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_413141", "413141088", "story_v_out_413141.awb") ~= 0 then
					local var_370_23 = manager.audio:GetVoiceLength("story_v_out_413141", "413141088", "story_v_out_413141.awb") / 1000

					if var_370_23 + var_370_15 > arg_367_1.duration_ then
						arg_367_1.duration_ = var_370_23 + var_370_15
					end

					if var_370_18.prefab_name ~= "" and arg_367_1.actors_[var_370_18.prefab_name] ~= nil then
						local var_370_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_367_1.actors_[var_370_18.prefab_name].transform, "story_v_out_413141", "413141088", "story_v_out_413141.awb")

						arg_367_1:RecordAudio("413141088", var_370_24)
						arg_367_1:RecordAudio("413141088", var_370_24)
					else
						arg_367_1:AudioAction("play", "voice", "story_v_out_413141", "413141088", "story_v_out_413141.awb")
					end

					arg_367_1:RecordHistoryTalkVoice("story_v_out_413141", "413141088", "story_v_out_413141.awb")
				end

				arg_367_1:RecordContent(arg_367_1.text_.text)
			end

			local var_370_25 = math.max(var_370_16, arg_367_1.talkMaxDuration)

			if var_370_15 <= arg_367_1.time_ and arg_367_1.time_ < var_370_15 + var_370_25 then
				arg_367_1.typewritter.percent = (arg_367_1.time_ - var_370_15) / var_370_25

				arg_367_1.typewritter:SetDirty()
			end

			if arg_367_1.time_ >= var_370_15 + var_370_25 and arg_367_1.time_ < var_370_15 + var_370_25 + arg_370_0 then
				arg_367_1.typewritter.percent = 1

				arg_367_1.typewritter:SetDirty()
				arg_367_1:ShowNextGo(true)
			end
		end

		arg_367_1.nodeConfigList_ = {
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

		arg_367_1:InitPlayNodeList()
	end,
	Play413141089 = function(arg_371_0, arg_371_1)
		arg_371_1.time_ = 0
		arg_371_1.frameCnt_ = 0
		arg_371_1.state_ = "playing"
		arg_371_1.curTalkId_ = 413141089
		arg_371_1.duration_ = 8.23

		local var_371_0 = {
			zh = 4.466,
			ja = 8.233
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
				arg_371_0:Play413141090(arg_371_1)
			end
		end

		function arg_371_1.onSingleLineUpdate_(arg_374_0)
			local var_374_0 = 0
			local var_374_1 = 0.625

			if var_374_0 < arg_371_1.time_ and arg_371_1.time_ <= var_374_0 + arg_374_0 then
				arg_371_1.talkMaxDuration = 0
				arg_371_1.dialogCg_.alpha = 1

				arg_371_1.dialog_:SetActive(true)
				SetActive(arg_371_1.leftNameGo_, true)

				local var_374_2 = arg_371_1:FormatText(StoryNameCfg[996].name)

				arg_371_1.leftNameTxt_.text = var_374_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_371_1.leftNameTxt_.transform)

				arg_371_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_371_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_371_1:RecordName(arg_371_1.leftNameTxt_.text)
				SetActive(arg_371_1.iconTrs_.gameObject, false)
				arg_371_1.callingController_:SetSelectedState("normal")

				local var_374_3 = arg_371_1:GetWordFromCfg(413141089)
				local var_374_4 = arg_371_1:FormatText(var_374_3.content)

				arg_371_1.text_.text = var_374_4

				LuaForUtil.ClearLinePrefixSymbol(arg_371_1.text_)

				local var_374_5 = 25
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

				if manager.audio:GetVoiceLength("story_v_out_413141", "413141089", "story_v_out_413141.awb") ~= 0 then
					local var_374_8 = manager.audio:GetVoiceLength("story_v_out_413141", "413141089", "story_v_out_413141.awb") / 1000

					if var_374_8 + var_374_0 > arg_371_1.duration_ then
						arg_371_1.duration_ = var_374_8 + var_374_0
					end

					if var_374_3.prefab_name ~= "" and arg_371_1.actors_[var_374_3.prefab_name] ~= nil then
						local var_374_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_371_1.actors_[var_374_3.prefab_name].transform, "story_v_out_413141", "413141089", "story_v_out_413141.awb")

						arg_371_1:RecordAudio("413141089", var_374_9)
						arg_371_1:RecordAudio("413141089", var_374_9)
					else
						arg_371_1:AudioAction("play", "voice", "story_v_out_413141", "413141089", "story_v_out_413141.awb")
					end

					arg_371_1:RecordHistoryTalkVoice("story_v_out_413141", "413141089", "story_v_out_413141.awb")
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
	Play413141090 = function(arg_375_0, arg_375_1)
		arg_375_1.time_ = 0
		arg_375_1.frameCnt_ = 0
		arg_375_1.state_ = "playing"
		arg_375_1.curTalkId_ = 413141090
		arg_375_1.duration_ = 2.1

		local var_375_0 = {
			zh = 1.999999999999,
			ja = 2.1
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
				arg_375_0:Play413141091(arg_375_1)
			end
		end

		function arg_375_1.onSingleLineUpdate_(arg_378_0)
			local var_378_0 = arg_375_1.actors_["10092_1"]
			local var_378_1 = 0

			if var_378_1 < arg_375_1.time_ and arg_375_1.time_ <= var_378_1 + arg_378_0 and not isNil(var_378_0) and arg_375_1.var_.actorSpriteComps10092_1 == nil then
				arg_375_1.var_.actorSpriteComps10092_1 = var_378_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_378_2 = 2

			if var_378_1 <= arg_375_1.time_ and arg_375_1.time_ < var_378_1 + var_378_2 and not isNil(var_378_0) then
				local var_378_3 = (arg_375_1.time_ - var_378_1) / var_378_2

				if arg_375_1.var_.actorSpriteComps10092_1 then
					for iter_378_0, iter_378_1 in pairs(arg_375_1.var_.actorSpriteComps10092_1:ToTable()) do
						if iter_378_1 then
							if arg_375_1.isInRecall_ then
								local var_378_4 = Mathf.Lerp(iter_378_1.color.r, arg_375_1.hightColor2.r, var_378_3)
								local var_378_5 = Mathf.Lerp(iter_378_1.color.g, arg_375_1.hightColor2.g, var_378_3)
								local var_378_6 = Mathf.Lerp(iter_378_1.color.b, arg_375_1.hightColor2.b, var_378_3)

								iter_378_1.color = Color.New(var_378_4, var_378_5, var_378_6)
							else
								local var_378_7 = Mathf.Lerp(iter_378_1.color.r, 0.5, var_378_3)

								iter_378_1.color = Color.New(var_378_7, var_378_7, var_378_7)
							end
						end
					end
				end
			end

			if arg_375_1.time_ >= var_378_1 + var_378_2 and arg_375_1.time_ < var_378_1 + var_378_2 + arg_378_0 and not isNil(var_378_0) and arg_375_1.var_.actorSpriteComps10092_1 then
				for iter_378_2, iter_378_3 in pairs(arg_375_1.var_.actorSpriteComps10092_1:ToTable()) do
					if iter_378_3 then
						if arg_375_1.isInRecall_ then
							iter_378_3.color = arg_375_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_378_3.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_375_1.var_.actorSpriteComps10092_1 = nil
			end

			local var_378_8 = arg_375_1.actors_["10022"].transform
			local var_378_9 = 0

			if var_378_9 < arg_375_1.time_ and arg_375_1.time_ <= var_378_9 + arg_378_0 then
				arg_375_1.var_.moveOldPos10022 = var_378_8.localPosition
				var_378_8.localScale = Vector3.New(1, 1, 1)

				arg_375_1:CheckSpriteTmpPos("10022", 3)

				local var_378_10 = var_378_8.childCount

				for iter_378_4 = 0, var_378_10 - 1 do
					local var_378_11 = var_378_8:GetChild(iter_378_4)

					if var_378_11.name == "" or not string.find(var_378_11.name, "split") then
						var_378_11.gameObject:SetActive(true)
					else
						var_378_11.gameObject:SetActive(false)
					end
				end
			end

			local var_378_12 = 0.001

			if var_378_9 <= arg_375_1.time_ and arg_375_1.time_ < var_378_9 + var_378_12 then
				local var_378_13 = (arg_375_1.time_ - var_378_9) / var_378_12
				local var_378_14 = Vector3.New(0, -315, -320)

				var_378_8.localPosition = Vector3.Lerp(arg_375_1.var_.moveOldPos10022, var_378_14, var_378_13)
			end

			if arg_375_1.time_ >= var_378_9 + var_378_12 and arg_375_1.time_ < var_378_9 + var_378_12 + arg_378_0 then
				var_378_8.localPosition = Vector3.New(0, -315, -320)
			end

			local var_378_15 = 0
			local var_378_16 = 0.075

			if var_378_15 < arg_375_1.time_ and arg_375_1.time_ <= var_378_15 + arg_378_0 then
				arg_375_1.talkMaxDuration = 0
				arg_375_1.dialogCg_.alpha = 1

				arg_375_1.dialog_:SetActive(true)
				SetActive(arg_375_1.leftNameGo_, true)

				local var_378_17 = arg_375_1:FormatText(StoryNameCfg[614].name)

				arg_375_1.leftNameTxt_.text = var_378_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_375_1.leftNameTxt_.transform)

				arg_375_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_375_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_375_1:RecordName(arg_375_1.leftNameTxt_.text)
				SetActive(arg_375_1.iconTrs_.gameObject, false)
				arg_375_1.callingController_:SetSelectedState("normal")

				local var_378_18 = arg_375_1:GetWordFromCfg(413141090)
				local var_378_19 = arg_375_1:FormatText(var_378_18.content)

				arg_375_1.text_.text = var_378_19

				LuaForUtil.ClearLinePrefixSymbol(arg_375_1.text_)

				local var_378_20 = 3
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

				if manager.audio:GetVoiceLength("story_v_out_413141", "413141090", "story_v_out_413141.awb") ~= 0 then
					local var_378_23 = manager.audio:GetVoiceLength("story_v_out_413141", "413141090", "story_v_out_413141.awb") / 1000

					if var_378_23 + var_378_15 > arg_375_1.duration_ then
						arg_375_1.duration_ = var_378_23 + var_378_15
					end

					if var_378_18.prefab_name ~= "" and arg_375_1.actors_[var_378_18.prefab_name] ~= nil then
						local var_378_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_375_1.actors_[var_378_18.prefab_name].transform, "story_v_out_413141", "413141090", "story_v_out_413141.awb")

						arg_375_1:RecordAudio("413141090", var_378_24)
						arg_375_1:RecordAudio("413141090", var_378_24)
					else
						arg_375_1:AudioAction("play", "voice", "story_v_out_413141", "413141090", "story_v_out_413141.awb")
					end

					arg_375_1:RecordHistoryTalkVoice("story_v_out_413141", "413141090", "story_v_out_413141.awb")
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
				actorName = "10022",
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
	Play413141091 = function(arg_379_0, arg_379_1)
		arg_379_1.time_ = 0
		arg_379_1.frameCnt_ = 0
		arg_379_1.state_ = "playing"
		arg_379_1.curTalkId_ = 413141091
		arg_379_1.duration_ = 5

		SetActive(arg_379_1.tipsGo_, false)

		function arg_379_1.onSingleLineFinish_()
			arg_379_1.onSingleLineUpdate_ = nil
			arg_379_1.onSingleLineFinish_ = nil
			arg_379_1.state_ = "waiting"
		end

		function arg_379_1.playNext_(arg_381_0)
			if arg_381_0 == 1 then
				arg_379_0:Play413141092(arg_379_1)
			end
		end

		function arg_379_1.onSingleLineUpdate_(arg_382_0)
			local var_382_0 = arg_379_1.actors_["10022"].transform
			local var_382_1 = 0

			if var_382_1 < arg_379_1.time_ and arg_379_1.time_ <= var_382_1 + arg_382_0 then
				arg_379_1.var_.moveOldPos10022 = var_382_0.localPosition
				var_382_0.localScale = Vector3.New(1, 1, 1)

				arg_379_1:CheckSpriteTmpPos("10022", 7)

				local var_382_2 = var_382_0.childCount

				for iter_382_0 = 0, var_382_2 - 1 do
					local var_382_3 = var_382_0:GetChild(iter_382_0)

					if var_382_3.name == "split_2" or not string.find(var_382_3.name, "split") then
						var_382_3.gameObject:SetActive(true)
					else
						var_382_3.gameObject:SetActive(false)
					end
				end
			end

			local var_382_4 = 0.001

			if var_382_1 <= arg_379_1.time_ and arg_379_1.time_ < var_382_1 + var_382_4 then
				local var_382_5 = (arg_379_1.time_ - var_382_1) / var_382_4
				local var_382_6 = Vector3.New(0, -2000, 0)

				var_382_0.localPosition = Vector3.Lerp(arg_379_1.var_.moveOldPos10022, var_382_6, var_382_5)
			end

			if arg_379_1.time_ >= var_382_1 + var_382_4 and arg_379_1.time_ < var_382_1 + var_382_4 + arg_382_0 then
				var_382_0.localPosition = Vector3.New(0, -2000, 0)
			end

			local var_382_7 = 0
			local var_382_8 = 0.725

			if var_382_7 < arg_379_1.time_ and arg_379_1.time_ <= var_382_7 + arg_382_0 then
				arg_379_1.talkMaxDuration = 0
				arg_379_1.dialogCg_.alpha = 1

				arg_379_1.dialog_:SetActive(true)
				SetActive(arg_379_1.leftNameGo_, false)

				arg_379_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_379_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_379_1:RecordName(arg_379_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_379_1.iconTrs_.gameObject, false)
				arg_379_1.callingController_:SetSelectedState("normal")

				local var_382_9 = arg_379_1:GetWordFromCfg(413141091)
				local var_382_10 = arg_379_1:FormatText(var_382_9.content)

				arg_379_1.text_.text = var_382_10

				LuaForUtil.ClearLinePrefixSymbol(arg_379_1.text_)

				local var_382_11 = 29
				local var_382_12 = utf8.len(var_382_10)
				local var_382_13 = var_382_11 <= 0 and var_382_8 or var_382_8 * (var_382_12 / var_382_11)

				if var_382_13 > 0 and var_382_8 < var_382_13 then
					arg_379_1.talkMaxDuration = var_382_13

					if var_382_13 + var_382_7 > arg_379_1.duration_ then
						arg_379_1.duration_ = var_382_13 + var_382_7
					end
				end

				arg_379_1.text_.text = var_382_10
				arg_379_1.typewritter.percent = 0

				arg_379_1.typewritter:SetDirty()
				arg_379_1:ShowNextGo(false)
				arg_379_1:RecordContent(arg_379_1.text_.text)
			end

			local var_382_14 = math.max(var_382_8, arg_379_1.talkMaxDuration)

			if var_382_7 <= arg_379_1.time_ and arg_379_1.time_ < var_382_7 + var_382_14 then
				arg_379_1.typewritter.percent = (arg_379_1.time_ - var_382_7) / var_382_14

				arg_379_1.typewritter:SetDirty()
			end

			if arg_379_1.time_ >= var_382_7 + var_382_14 and arg_379_1.time_ < var_382_7 + var_382_14 + arg_382_0 then
				arg_379_1.typewritter.percent = 1

				arg_379_1.typewritter:SetDirty()
				arg_379_1:ShowNextGo(true)
			end
		end

		arg_379_1.nodeConfigList_ = {
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

		arg_379_1:InitPlayNodeList()
	end,
	Play413141092 = function(arg_383_0, arg_383_1)
		arg_383_1.time_ = 0
		arg_383_1.frameCnt_ = 0
		arg_383_1.state_ = "playing"
		arg_383_1.curTalkId_ = 413141092
		arg_383_1.duration_ = 12.27

		local var_383_0 = {
			zh = 9.79966666666667,
			ja = 12.2666666666667
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
				arg_383_0:Play413141093(arg_383_1)
			end
		end

		function arg_383_1.onSingleLineUpdate_(arg_386_0)
			local var_386_0 = 0

			if var_386_0 < arg_383_1.time_ and arg_383_1.time_ <= var_386_0 + arg_386_0 then
				arg_383_1.allBtn_.enabled = false
			end

			local var_386_1 = 0.466666666666667

			if arg_383_1.time_ >= var_386_0 + var_386_1 and arg_383_1.time_ < var_386_0 + var_386_1 + arg_386_0 then
				arg_383_1.allBtn_.enabled = true
			end

			local var_386_2 = arg_383_1.actors_["10022"].transform
			local var_386_3 = 0.466666666666667

			if var_386_3 < arg_383_1.time_ and arg_383_1.time_ <= var_386_3 + arg_386_0 then
				arg_383_1.var_.moveOldPos10022 = var_386_2.localPosition
				var_386_2.localScale = Vector3.New(1, 1, 1)

				arg_383_1:CheckSpriteTmpPos("10022", 3)

				local var_386_4 = var_386_2.childCount

				for iter_386_0 = 0, var_386_4 - 1 do
					local var_386_5 = var_386_2:GetChild(iter_386_0)

					if var_386_5.name == "" or not string.find(var_386_5.name, "split") then
						var_386_5.gameObject:SetActive(true)
					else
						var_386_5.gameObject:SetActive(false)
					end
				end
			end

			local var_386_6 = 0.001

			if var_386_3 <= arg_383_1.time_ and arg_383_1.time_ < var_386_3 + var_386_6 then
				local var_386_7 = (arg_383_1.time_ - var_386_3) / var_386_6
				local var_386_8 = Vector3.New(0, -315, -320)

				var_386_2.localPosition = Vector3.Lerp(arg_383_1.var_.moveOldPos10022, var_386_8, var_386_7)
			end

			if arg_383_1.time_ >= var_386_3 + var_386_6 and arg_383_1.time_ < var_386_3 + var_386_6 + arg_386_0 then
				var_386_2.localPosition = Vector3.New(0, -315, -320)
			end

			local var_386_9 = arg_383_1.actors_["10022"]
			local var_386_10 = 0.466666666666667

			if var_386_10 < arg_383_1.time_ and arg_383_1.time_ <= var_386_10 + arg_386_0 then
				arg_383_1:SetSpriteNiuquEffect("10022", true)
			end

			local var_386_11 = arg_383_1.actors_["10022"]
			local var_386_12 = 0.466666666666667

			if var_386_12 < arg_383_1.time_ and arg_383_1.time_ <= var_386_12 + arg_386_0 then
				local var_386_13 = var_386_11:GetComponentInChildren(typeof(CanvasGroup))

				if var_386_13 then
					arg_383_1.var_.alphaOldValue10022 = var_386_13.alpha
					arg_383_1.var_.characterEffect10022 = var_386_13
				end
			end

			local var_386_14 = 0.5

			if var_386_12 <= arg_383_1.time_ and arg_383_1.time_ < var_386_12 + var_386_14 then
				local var_386_15 = (arg_383_1.time_ - var_386_12) / var_386_14
				local var_386_16 = Mathf.Lerp(arg_383_1.var_.alphaOldValue10022, 0.6, var_386_15)

				if arg_383_1.var_.characterEffect10022 then
					arg_383_1.var_.characterEffect10022.alpha = var_386_16
				end
			end

			if arg_383_1.time_ >= var_386_12 + var_386_14 and arg_383_1.time_ < var_386_12 + var_386_14 + arg_386_0 and arg_383_1.var_.characterEffect10022 then
				arg_383_1.var_.characterEffect10022.alpha = 0.6
			end

			if arg_383_1.frameCnt_ <= 1 then
				arg_383_1.dialog_:SetActive(false)
			end

			local var_386_17 = 0.466666666666667
			local var_386_18 = 0.75

			if var_386_17 < arg_383_1.time_ and arg_383_1.time_ <= var_386_17 + arg_386_0 then
				arg_383_1.talkMaxDuration = 0

				arg_383_1.dialog_:SetActive(true)

				arg_383_1.dialogCg_.alpha = 0

				local var_386_19 = LeanTween.value(arg_383_1.dialog_, 0, 1, 0.3)

				var_386_19:setOnUpdate(LuaHelper.FloatAction(function(arg_387_0)
					arg_383_1.dialogCg_.alpha = arg_387_0
				end))
				var_386_19:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_383_1.dialog_)
					var_386_19:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_383_1.duration_ = arg_383_1.duration_ + 0.3

				SetActive(arg_383_1.leftNameGo_, true)

				local var_386_20 = arg_383_1:FormatText(StoryNameCfg[614].name)

				arg_383_1.leftNameTxt_.text = var_386_20

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_383_1.leftNameTxt_.transform)

				arg_383_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_383_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_383_1:RecordName(arg_383_1.leftNameTxt_.text)
				SetActive(arg_383_1.iconTrs_.gameObject, false)
				arg_383_1.callingController_:SetSelectedState("normal")

				local var_386_21 = arg_383_1:GetWordFromCfg(413141092)
				local var_386_22 = arg_383_1:FormatText(var_386_21.content)

				arg_383_1.text_.text = var_386_22

				LuaForUtil.ClearLinePrefixSymbol(arg_383_1.text_)

				local var_386_23 = 30
				local var_386_24 = utf8.len(var_386_22)
				local var_386_25 = var_386_23 <= 0 and var_386_18 or var_386_18 * (var_386_24 / var_386_23)

				if var_386_25 > 0 and var_386_18 < var_386_25 then
					arg_383_1.talkMaxDuration = var_386_25
					var_386_17 = var_386_17 + 0.3

					if var_386_25 + var_386_17 > arg_383_1.duration_ then
						arg_383_1.duration_ = var_386_25 + var_386_17
					end
				end

				arg_383_1.text_.text = var_386_22
				arg_383_1.typewritter.percent = 0

				arg_383_1.typewritter:SetDirty()
				arg_383_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_413141", "413141092", "story_v_out_413141.awb") ~= 0 then
					local var_386_26 = manager.audio:GetVoiceLength("story_v_out_413141", "413141092", "story_v_out_413141.awb") / 1000

					if var_386_26 + var_386_17 > arg_383_1.duration_ then
						arg_383_1.duration_ = var_386_26 + var_386_17
					end

					if var_386_21.prefab_name ~= "" and arg_383_1.actors_[var_386_21.prefab_name] ~= nil then
						local var_386_27 = LuaForUtil.PlayVoiceWithCriLipsync(arg_383_1.actors_[var_386_21.prefab_name].transform, "story_v_out_413141", "413141092", "story_v_out_413141.awb")

						arg_383_1:RecordAudio("413141092", var_386_27)
						arg_383_1:RecordAudio("413141092", var_386_27)
					else
						arg_383_1:AudioAction("play", "voice", "story_v_out_413141", "413141092", "story_v_out_413141.awb")
					end

					arg_383_1:RecordHistoryTalkVoice("story_v_out_413141", "413141092", "story_v_out_413141.awb")
				end

				arg_383_1:RecordContent(arg_383_1.text_.text)
			end

			local var_386_28 = var_386_17 + 0.3
			local var_386_29 = math.max(var_386_18, arg_383_1.talkMaxDuration)

			if var_386_28 <= arg_383_1.time_ and arg_383_1.time_ < var_386_28 + var_386_29 then
				arg_383_1.typewritter.percent = (arg_383_1.time_ - var_386_28) / var_386_29

				arg_383_1.typewritter:SetDirty()
			end

			if arg_383_1.time_ >= var_386_28 + var_386_29 and arg_383_1.time_ < var_386_28 + var_386_29 + arg_386_0 then
				arg_383_1.typewritter.percent = 1

				arg_383_1.typewritter:SetDirty()
				arg_383_1:ShowNextGo(true)
			end
		end

		arg_383_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10022",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0.466666666666667,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_383_1:InitPlayNodeList()
	end,
	Play413141093 = function(arg_389_0, arg_389_1)
		arg_389_1.time_ = 0
		arg_389_1.frameCnt_ = 0
		arg_389_1.state_ = "playing"
		arg_389_1.curTalkId_ = 413141093
		arg_389_1.duration_ = 3.3

		local var_389_0 = {
			zh = 2.6,
			ja = 3.3
		}
		local var_389_1 = manager.audio:GetLocalizationFlag()

		if var_389_0[var_389_1] ~= nil then
			arg_389_1.duration_ = var_389_0[var_389_1]
		end

		SetActive(arg_389_1.tipsGo_, false)

		function arg_389_1.onSingleLineFinish_()
			arg_389_1.onSingleLineUpdate_ = nil
			arg_389_1.onSingleLineFinish_ = nil
			arg_389_1.state_ = "waiting"
		end

		function arg_389_1.playNext_(arg_391_0)
			if arg_391_0 == 1 then
				arg_389_0:Play413141094(arg_389_1)
			end
		end

		function arg_389_1.onSingleLineUpdate_(arg_392_0)
			local var_392_0 = arg_389_1.actors_["10092_1"].transform
			local var_392_1 = 0

			if var_392_1 < arg_389_1.time_ and arg_389_1.time_ <= var_392_1 + arg_392_0 then
				arg_389_1.var_.moveOldPos10092_1 = var_392_0.localPosition
				var_392_0.localScale = Vector3.New(1, 1, 1)

				arg_389_1:CheckSpriteTmpPos("10092_1", 3)

				local var_392_2 = var_392_0.childCount

				for iter_392_0 = 0, var_392_2 - 1 do
					local var_392_3 = var_392_0:GetChild(iter_392_0)

					if var_392_3.name == "split_1_1" or not string.find(var_392_3.name, "split") then
						var_392_3.gameObject:SetActive(true)
					else
						var_392_3.gameObject:SetActive(false)
					end
				end
			end

			local var_392_4 = 0.001

			if var_392_1 <= arg_389_1.time_ and arg_389_1.time_ < var_392_1 + var_392_4 then
				local var_392_5 = (arg_389_1.time_ - var_392_1) / var_392_4
				local var_392_6 = Vector3.New(0, -300, -295)

				var_392_0.localPosition = Vector3.Lerp(arg_389_1.var_.moveOldPos10092_1, var_392_6, var_392_5)
			end

			if arg_389_1.time_ >= var_392_1 + var_392_4 and arg_389_1.time_ < var_392_1 + var_392_4 + arg_392_0 then
				var_392_0.localPosition = Vector3.New(0, -300, -295)
			end

			local var_392_7 = arg_389_1.actors_["10092_1"]
			local var_392_8 = 0

			if var_392_8 < arg_389_1.time_ and arg_389_1.time_ <= var_392_8 + arg_392_0 and not isNil(var_392_7) and arg_389_1.var_.actorSpriteComps10092_1 == nil then
				arg_389_1.var_.actorSpriteComps10092_1 = var_392_7:GetComponentsInChildren(typeof(Image), true)
			end

			local var_392_9 = 2

			if var_392_8 <= arg_389_1.time_ and arg_389_1.time_ < var_392_8 + var_392_9 and not isNil(var_392_7) then
				local var_392_10 = (arg_389_1.time_ - var_392_8) / var_392_9

				if arg_389_1.var_.actorSpriteComps10092_1 then
					for iter_392_1, iter_392_2 in pairs(arg_389_1.var_.actorSpriteComps10092_1:ToTable()) do
						if iter_392_2 then
							if arg_389_1.isInRecall_ then
								local var_392_11 = Mathf.Lerp(iter_392_2.color.r, arg_389_1.hightColor1.r, var_392_10)
								local var_392_12 = Mathf.Lerp(iter_392_2.color.g, arg_389_1.hightColor1.g, var_392_10)
								local var_392_13 = Mathf.Lerp(iter_392_2.color.b, arg_389_1.hightColor1.b, var_392_10)

								iter_392_2.color = Color.New(var_392_11, var_392_12, var_392_13)
							else
								local var_392_14 = Mathf.Lerp(iter_392_2.color.r, 1, var_392_10)

								iter_392_2.color = Color.New(var_392_14, var_392_14, var_392_14)
							end
						end
					end
				end
			end

			if arg_389_1.time_ >= var_392_8 + var_392_9 and arg_389_1.time_ < var_392_8 + var_392_9 + arg_392_0 and not isNil(var_392_7) and arg_389_1.var_.actorSpriteComps10092_1 then
				for iter_392_3, iter_392_4 in pairs(arg_389_1.var_.actorSpriteComps10092_1:ToTable()) do
					if iter_392_4 then
						if arg_389_1.isInRecall_ then
							iter_392_4.color = arg_389_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_392_4.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_389_1.var_.actorSpriteComps10092_1 = nil
			end

			local var_392_15 = 0
			local var_392_16 = 0.125

			if var_392_15 < arg_389_1.time_ and arg_389_1.time_ <= var_392_15 + arg_392_0 then
				arg_389_1.talkMaxDuration = 0
				arg_389_1.dialogCg_.alpha = 1

				arg_389_1.dialog_:SetActive(true)
				SetActive(arg_389_1.leftNameGo_, true)

				local var_392_17 = arg_389_1:FormatText(StoryNameCfg[996].name)

				arg_389_1.leftNameTxt_.text = var_392_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_389_1.leftNameTxt_.transform)

				arg_389_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_389_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_389_1:RecordName(arg_389_1.leftNameTxt_.text)
				SetActive(arg_389_1.iconTrs_.gameObject, false)
				arg_389_1.callingController_:SetSelectedState("normal")

				local var_392_18 = arg_389_1:GetWordFromCfg(413141093)
				local var_392_19 = arg_389_1:FormatText(var_392_18.content)

				arg_389_1.text_.text = var_392_19

				LuaForUtil.ClearLinePrefixSymbol(arg_389_1.text_)

				local var_392_20 = 5
				local var_392_21 = utf8.len(var_392_19)
				local var_392_22 = var_392_20 <= 0 and var_392_16 or var_392_16 * (var_392_21 / var_392_20)

				if var_392_22 > 0 and var_392_16 < var_392_22 then
					arg_389_1.talkMaxDuration = var_392_22

					if var_392_22 + var_392_15 > arg_389_1.duration_ then
						arg_389_1.duration_ = var_392_22 + var_392_15
					end
				end

				arg_389_1.text_.text = var_392_19
				arg_389_1.typewritter.percent = 0

				arg_389_1.typewritter:SetDirty()
				arg_389_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_413141", "413141093", "story_v_out_413141.awb") ~= 0 then
					local var_392_23 = manager.audio:GetVoiceLength("story_v_out_413141", "413141093", "story_v_out_413141.awb") / 1000

					if var_392_23 + var_392_15 > arg_389_1.duration_ then
						arg_389_1.duration_ = var_392_23 + var_392_15
					end

					if var_392_18.prefab_name ~= "" and arg_389_1.actors_[var_392_18.prefab_name] ~= nil then
						local var_392_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_389_1.actors_[var_392_18.prefab_name].transform, "story_v_out_413141", "413141093", "story_v_out_413141.awb")

						arg_389_1:RecordAudio("413141093", var_392_24)
						arg_389_1:RecordAudio("413141093", var_392_24)
					else
						arg_389_1:AudioAction("play", "voice", "story_v_out_413141", "413141093", "story_v_out_413141.awb")
					end

					arg_389_1:RecordHistoryTalkVoice("story_v_out_413141", "413141093", "story_v_out_413141.awb")
				end

				arg_389_1:RecordContent(arg_389_1.text_.text)
			end

			local var_392_25 = math.max(var_392_16, arg_389_1.talkMaxDuration)

			if var_392_15 <= arg_389_1.time_ and arg_389_1.time_ < var_392_15 + var_392_25 then
				arg_389_1.typewritter.percent = (arg_389_1.time_ - var_392_15) / var_392_25

				arg_389_1.typewritter:SetDirty()
			end

			if arg_389_1.time_ >= var_392_15 + var_392_25 and arg_389_1.time_ < var_392_15 + var_392_25 + arg_392_0 then
				arg_389_1.typewritter.percent = 1

				arg_389_1.typewritter:SetDirty()
				arg_389_1:ShowNextGo(true)
			end
		end

		arg_389_1.nodeConfigList_ = {
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

		arg_389_1:InitPlayNodeList()
	end,
	Play413141094 = function(arg_393_0, arg_393_1)
		arg_393_1.time_ = 0
		arg_393_1.frameCnt_ = 0
		arg_393_1.state_ = "playing"
		arg_393_1.curTalkId_ = 413141094
		arg_393_1.duration_ = 5

		SetActive(arg_393_1.tipsGo_, false)

		function arg_393_1.onSingleLineFinish_()
			arg_393_1.onSingleLineUpdate_ = nil
			arg_393_1.onSingleLineFinish_ = nil
			arg_393_1.state_ = "waiting"
		end

		function arg_393_1.playNext_(arg_395_0)
			if arg_395_0 == 1 then
				arg_393_0:Play413141095(arg_393_1)
			end
		end

		function arg_393_1.onSingleLineUpdate_(arg_396_0)
			local var_396_0 = arg_393_1.actors_["10092_1"].transform
			local var_396_1 = 0

			if var_396_1 < arg_393_1.time_ and arg_393_1.time_ <= var_396_1 + arg_396_0 then
				arg_393_1.var_.moveOldPos10092_1 = var_396_0.localPosition
				var_396_0.localScale = Vector3.New(1, 1, 1)

				arg_393_1:CheckSpriteTmpPos("10092_1", 7)

				local var_396_2 = var_396_0.childCount

				for iter_396_0 = 0, var_396_2 - 1 do
					local var_396_3 = var_396_0:GetChild(iter_396_0)

					if var_396_3.name == "split_1_1" or not string.find(var_396_3.name, "split") then
						var_396_3.gameObject:SetActive(true)
					else
						var_396_3.gameObject:SetActive(false)
					end
				end
			end

			local var_396_4 = 0.001

			if var_396_1 <= arg_393_1.time_ and arg_393_1.time_ < var_396_1 + var_396_4 then
				local var_396_5 = (arg_393_1.time_ - var_396_1) / var_396_4
				local var_396_6 = Vector3.New(0, -2000, 0)

				var_396_0.localPosition = Vector3.Lerp(arg_393_1.var_.moveOldPos10092_1, var_396_6, var_396_5)
			end

			if arg_393_1.time_ >= var_396_1 + var_396_4 and arg_393_1.time_ < var_396_1 + var_396_4 + arg_396_0 then
				var_396_0.localPosition = Vector3.New(0, -2000, 0)
			end

			local var_396_7 = 0
			local var_396_8 = 0.7

			if var_396_7 < arg_393_1.time_ and arg_393_1.time_ <= var_396_7 + arg_396_0 then
				arg_393_1.talkMaxDuration = 0
				arg_393_1.dialogCg_.alpha = 1

				arg_393_1.dialog_:SetActive(true)
				SetActive(arg_393_1.leftNameGo_, false)

				arg_393_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_393_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_393_1:RecordName(arg_393_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_393_1.iconTrs_.gameObject, false)
				arg_393_1.callingController_:SetSelectedState("normal")

				local var_396_9 = arg_393_1:GetWordFromCfg(413141094)
				local var_396_10 = arg_393_1:FormatText(var_396_9.content)

				arg_393_1.text_.text = var_396_10

				LuaForUtil.ClearLinePrefixSymbol(arg_393_1.text_)

				local var_396_11 = 28
				local var_396_12 = utf8.len(var_396_10)
				local var_396_13 = var_396_11 <= 0 and var_396_8 or var_396_8 * (var_396_12 / var_396_11)

				if var_396_13 > 0 and var_396_8 < var_396_13 then
					arg_393_1.talkMaxDuration = var_396_13

					if var_396_13 + var_396_7 > arg_393_1.duration_ then
						arg_393_1.duration_ = var_396_13 + var_396_7
					end
				end

				arg_393_1.text_.text = var_396_10
				arg_393_1.typewritter.percent = 0

				arg_393_1.typewritter:SetDirty()
				arg_393_1:ShowNextGo(false)
				arg_393_1:RecordContent(arg_393_1.text_.text)
			end

			local var_396_14 = math.max(var_396_8, arg_393_1.talkMaxDuration)

			if var_396_7 <= arg_393_1.time_ and arg_393_1.time_ < var_396_7 + var_396_14 then
				arg_393_1.typewritter.percent = (arg_393_1.time_ - var_396_7) / var_396_14

				arg_393_1.typewritter:SetDirty()
			end

			if arg_393_1.time_ >= var_396_7 + var_396_14 and arg_393_1.time_ < var_396_7 + var_396_14 + arg_396_0 then
				arg_393_1.typewritter.percent = 1

				arg_393_1.typewritter:SetDirty()
				arg_393_1:ShowNextGo(true)
			end
		end

		arg_393_1.nodeConfigList_ = {
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

		arg_393_1:InitPlayNodeList()
	end,
	Play413141095 = function(arg_397_0, arg_397_1)
		arg_397_1.time_ = 0
		arg_397_1.frameCnt_ = 0
		arg_397_1.state_ = "playing"
		arg_397_1.curTalkId_ = 413141095
		arg_397_1.duration_ = 5

		SetActive(arg_397_1.tipsGo_, false)

		function arg_397_1.onSingleLineFinish_()
			arg_397_1.onSingleLineUpdate_ = nil
			arg_397_1.onSingleLineFinish_ = nil
			arg_397_1.state_ = "waiting"
		end

		function arg_397_1.playNext_(arg_399_0)
			if arg_399_0 == 1 then
				arg_397_0:Play413141096(arg_397_1)
			end
		end

		function arg_397_1.onSingleLineUpdate_(arg_400_0)
			local var_400_0 = 0
			local var_400_1 = 0.75

			if var_400_0 < arg_397_1.time_ and arg_397_1.time_ <= var_400_0 + arg_400_0 then
				arg_397_1.talkMaxDuration = 0
				arg_397_1.dialogCg_.alpha = 1

				arg_397_1.dialog_:SetActive(true)
				SetActive(arg_397_1.leftNameGo_, false)

				arg_397_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_397_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_397_1:RecordName(arg_397_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_397_1.iconTrs_.gameObject, false)
				arg_397_1.callingController_:SetSelectedState("normal")

				local var_400_2 = arg_397_1:GetWordFromCfg(413141095)
				local var_400_3 = arg_397_1:FormatText(var_400_2.content)

				arg_397_1.text_.text = var_400_3

				LuaForUtil.ClearLinePrefixSymbol(arg_397_1.text_)

				local var_400_4 = 30
				local var_400_5 = utf8.len(var_400_3)
				local var_400_6 = var_400_4 <= 0 and var_400_1 or var_400_1 * (var_400_5 / var_400_4)

				if var_400_6 > 0 and var_400_1 < var_400_6 then
					arg_397_1.talkMaxDuration = var_400_6

					if var_400_6 + var_400_0 > arg_397_1.duration_ then
						arg_397_1.duration_ = var_400_6 + var_400_0
					end
				end

				arg_397_1.text_.text = var_400_3
				arg_397_1.typewritter.percent = 0

				arg_397_1.typewritter:SetDirty()
				arg_397_1:ShowNextGo(false)
				arg_397_1:RecordContent(arg_397_1.text_.text)
			end

			local var_400_7 = math.max(var_400_1, arg_397_1.talkMaxDuration)

			if var_400_0 <= arg_397_1.time_ and arg_397_1.time_ < var_400_0 + var_400_7 then
				arg_397_1.typewritter.percent = (arg_397_1.time_ - var_400_0) / var_400_7

				arg_397_1.typewritter:SetDirty()
			end

			if arg_397_1.time_ >= var_400_0 + var_400_7 and arg_397_1.time_ < var_400_0 + var_400_7 + arg_400_0 then
				arg_397_1.typewritter.percent = 1

				arg_397_1.typewritter:SetDirty()
				arg_397_1:ShowNextGo(true)
			end
		end

		arg_397_1.nodeConfigList_ = {}

		arg_397_1:InitPlayNodeList()
	end,
	Play413141096 = function(arg_401_0, arg_401_1)
		arg_401_1.time_ = 0
		arg_401_1.frameCnt_ = 0
		arg_401_1.state_ = "playing"
		arg_401_1.curTalkId_ = 413141096
		arg_401_1.duration_ = 8.6

		local var_401_0 = {
			zh = 8.1,
			ja = 8.6
		}
		local var_401_1 = manager.audio:GetLocalizationFlag()

		if var_401_0[var_401_1] ~= nil then
			arg_401_1.duration_ = var_401_0[var_401_1]
		end

		SetActive(arg_401_1.tipsGo_, false)

		function arg_401_1.onSingleLineFinish_()
			arg_401_1.onSingleLineUpdate_ = nil
			arg_401_1.onSingleLineFinish_ = nil
			arg_401_1.state_ = "waiting"
		end

		function arg_401_1.playNext_(arg_403_0)
			if arg_403_0 == 1 then
				arg_401_0:Play413141097(arg_401_1)
			end
		end

		function arg_401_1.onSingleLineUpdate_(arg_404_0)
			local var_404_0 = arg_401_1.actors_["10092_1"].transform
			local var_404_1 = 1.8

			if var_404_1 < arg_401_1.time_ and arg_401_1.time_ <= var_404_1 + arg_404_0 then
				arg_401_1.var_.moveOldPos10092_1 = var_404_0.localPosition
				var_404_0.localScale = Vector3.New(1, 1, 1)

				arg_401_1:CheckSpriteTmpPos("10092_1", 3)

				local var_404_2 = var_404_0.childCount

				for iter_404_0 = 0, var_404_2 - 1 do
					local var_404_3 = var_404_0:GetChild(iter_404_0)

					if var_404_3.name == "" or not string.find(var_404_3.name, "split") then
						var_404_3.gameObject:SetActive(true)
					else
						var_404_3.gameObject:SetActive(false)
					end
				end
			end

			local var_404_4 = 0.001

			if var_404_1 <= arg_401_1.time_ and arg_401_1.time_ < var_404_1 + var_404_4 then
				local var_404_5 = (arg_401_1.time_ - var_404_1) / var_404_4
				local var_404_6 = Vector3.New(0, -300, -295)

				var_404_0.localPosition = Vector3.Lerp(arg_401_1.var_.moveOldPos10092_1, var_404_6, var_404_5)
			end

			if arg_401_1.time_ >= var_404_1 + var_404_4 and arg_401_1.time_ < var_404_1 + var_404_4 + arg_404_0 then
				var_404_0.localPosition = Vector3.New(0, -300, -295)
			end

			local var_404_7 = arg_401_1.actors_["10092_1"]
			local var_404_8 = 1.8

			if var_404_8 < arg_401_1.time_ and arg_401_1.time_ <= var_404_8 + arg_404_0 and not isNil(var_404_7) and arg_401_1.var_.actorSpriteComps10092_1 == nil then
				arg_401_1.var_.actorSpriteComps10092_1 = var_404_7:GetComponentsInChildren(typeof(Image), true)
			end

			local var_404_9 = 2

			if var_404_8 <= arg_401_1.time_ and arg_401_1.time_ < var_404_8 + var_404_9 and not isNil(var_404_7) then
				local var_404_10 = (arg_401_1.time_ - var_404_8) / var_404_9

				if arg_401_1.var_.actorSpriteComps10092_1 then
					for iter_404_1, iter_404_2 in pairs(arg_401_1.var_.actorSpriteComps10092_1:ToTable()) do
						if iter_404_2 then
							if arg_401_1.isInRecall_ then
								local var_404_11 = Mathf.Lerp(iter_404_2.color.r, arg_401_1.hightColor1.r, var_404_10)
								local var_404_12 = Mathf.Lerp(iter_404_2.color.g, arg_401_1.hightColor1.g, var_404_10)
								local var_404_13 = Mathf.Lerp(iter_404_2.color.b, arg_401_1.hightColor1.b, var_404_10)

								iter_404_2.color = Color.New(var_404_11, var_404_12, var_404_13)
							else
								local var_404_14 = Mathf.Lerp(iter_404_2.color.r, 1, var_404_10)

								iter_404_2.color = Color.New(var_404_14, var_404_14, var_404_14)
							end
						end
					end
				end
			end

			if arg_401_1.time_ >= var_404_8 + var_404_9 and arg_401_1.time_ < var_404_8 + var_404_9 + arg_404_0 and not isNil(var_404_7) and arg_401_1.var_.actorSpriteComps10092_1 then
				for iter_404_3, iter_404_4 in pairs(arg_401_1.var_.actorSpriteComps10092_1:ToTable()) do
					if iter_404_4 then
						if arg_401_1.isInRecall_ then
							iter_404_4.color = arg_401_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_404_4.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_401_1.var_.actorSpriteComps10092_1 = nil
			end

			local var_404_15 = 0

			if var_404_15 < arg_401_1.time_ and arg_401_1.time_ <= var_404_15 + arg_404_0 then
				arg_401_1.mask_.enabled = true
				arg_401_1.mask_.raycastTarget = true

				arg_401_1:SetGaussion(false)
			end

			local var_404_16 = 1

			if var_404_15 <= arg_401_1.time_ and arg_401_1.time_ < var_404_15 + var_404_16 then
				local var_404_17 = (arg_401_1.time_ - var_404_15) / var_404_16
				local var_404_18 = Color.New(0, 0, 0)

				var_404_18.a = Mathf.Lerp(0, 1, var_404_17)
				arg_401_1.mask_.color = var_404_18
			end

			if arg_401_1.time_ >= var_404_15 + var_404_16 and arg_401_1.time_ < var_404_15 + var_404_16 + arg_404_0 then
				local var_404_19 = Color.New(0, 0, 0)

				var_404_19.a = 1
				arg_401_1.mask_.color = var_404_19
			end

			local var_404_20 = 1

			if var_404_20 < arg_401_1.time_ and arg_401_1.time_ <= var_404_20 + arg_404_0 then
				arg_401_1.mask_.enabled = true
				arg_401_1.mask_.raycastTarget = true

				arg_401_1:SetGaussion(false)
			end

			local var_404_21 = 1

			if var_404_20 <= arg_401_1.time_ and arg_401_1.time_ < var_404_20 + var_404_21 then
				local var_404_22 = (arg_401_1.time_ - var_404_20) / var_404_21
				local var_404_23 = Color.New(0, 0, 0)

				var_404_23.a = Mathf.Lerp(1, 0, var_404_22)
				arg_401_1.mask_.color = var_404_23
			end

			if arg_401_1.time_ >= var_404_20 + var_404_21 and arg_401_1.time_ < var_404_20 + var_404_21 + arg_404_0 then
				local var_404_24 = Color.New(0, 0, 0)
				local var_404_25 = 0

				arg_401_1.mask_.enabled = false
				var_404_24.a = var_404_25
				arg_401_1.mask_.color = var_404_24
			end

			local var_404_26 = arg_401_1.actors_["10092_1"]
			local var_404_27 = 1.8

			if var_404_27 < arg_401_1.time_ and arg_401_1.time_ <= var_404_27 + arg_404_0 then
				local var_404_28 = var_404_26:GetComponentInChildren(typeof(CanvasGroup))

				if var_404_28 then
					arg_401_1.var_.alphaOldValue10092_1 = var_404_28.alpha
					arg_401_1.var_.characterEffect10092_1 = var_404_28
				end

				arg_401_1.var_.alphaOldValue10092_1 = 0
			end

			local var_404_29 = 0.2

			if var_404_27 <= arg_401_1.time_ and arg_401_1.time_ < var_404_27 + var_404_29 then
				local var_404_30 = (arg_401_1.time_ - var_404_27) / var_404_29
				local var_404_31 = Mathf.Lerp(arg_401_1.var_.alphaOldValue10092_1, 1, var_404_30)

				if arg_401_1.var_.characterEffect10092_1 then
					arg_401_1.var_.characterEffect10092_1.alpha = var_404_31
				end
			end

			if arg_401_1.time_ >= var_404_27 + var_404_29 and arg_401_1.time_ < var_404_27 + var_404_29 + arg_404_0 and arg_401_1.var_.characterEffect10092_1 then
				arg_401_1.var_.characterEffect10092_1.alpha = 1
			end

			if arg_401_1.frameCnt_ <= 1 then
				arg_401_1.dialog_:SetActive(false)
			end

			local var_404_32 = 2.2
			local var_404_33 = 0.775

			if var_404_32 < arg_401_1.time_ and arg_401_1.time_ <= var_404_32 + arg_404_0 then
				arg_401_1.talkMaxDuration = 0

				arg_401_1.dialog_:SetActive(true)

				arg_401_1.dialogCg_.alpha = 0

				local var_404_34 = LeanTween.value(arg_401_1.dialog_, 0, 1, 0.3)

				var_404_34:setOnUpdate(LuaHelper.FloatAction(function(arg_405_0)
					arg_401_1.dialogCg_.alpha = arg_405_0
				end))
				var_404_34:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_401_1.dialog_)
					var_404_34:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_401_1.duration_ = arg_401_1.duration_ + 0.3

				SetActive(arg_401_1.leftNameGo_, true)

				local var_404_35 = arg_401_1:FormatText(StoryNameCfg[996].name)

				arg_401_1.leftNameTxt_.text = var_404_35

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_401_1.leftNameTxt_.transform)

				arg_401_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_401_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_401_1:RecordName(arg_401_1.leftNameTxt_.text)
				SetActive(arg_401_1.iconTrs_.gameObject, false)
				arg_401_1.callingController_:SetSelectedState("normal")

				local var_404_36 = arg_401_1:GetWordFromCfg(413141096)
				local var_404_37 = arg_401_1:FormatText(var_404_36.content)

				arg_401_1.text_.text = var_404_37

				LuaForUtil.ClearLinePrefixSymbol(arg_401_1.text_)

				local var_404_38 = 31
				local var_404_39 = utf8.len(var_404_37)
				local var_404_40 = var_404_38 <= 0 and var_404_33 or var_404_33 * (var_404_39 / var_404_38)

				if var_404_40 > 0 and var_404_33 < var_404_40 then
					arg_401_1.talkMaxDuration = var_404_40
					var_404_32 = var_404_32 + 0.3

					if var_404_40 + var_404_32 > arg_401_1.duration_ then
						arg_401_1.duration_ = var_404_40 + var_404_32
					end
				end

				arg_401_1.text_.text = var_404_37
				arg_401_1.typewritter.percent = 0

				arg_401_1.typewritter:SetDirty()
				arg_401_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_413141", "413141096", "story_v_out_413141.awb") ~= 0 then
					local var_404_41 = manager.audio:GetVoiceLength("story_v_out_413141", "413141096", "story_v_out_413141.awb") / 1000

					if var_404_41 + var_404_32 > arg_401_1.duration_ then
						arg_401_1.duration_ = var_404_41 + var_404_32
					end

					if var_404_36.prefab_name ~= "" and arg_401_1.actors_[var_404_36.prefab_name] ~= nil then
						local var_404_42 = LuaForUtil.PlayVoiceWithCriLipsync(arg_401_1.actors_[var_404_36.prefab_name].transform, "story_v_out_413141", "413141096", "story_v_out_413141.awb")

						arg_401_1:RecordAudio("413141096", var_404_42)
						arg_401_1:RecordAudio("413141096", var_404_42)
					else
						arg_401_1:AudioAction("play", "voice", "story_v_out_413141", "413141096", "story_v_out_413141.awb")
					end

					arg_401_1:RecordHistoryTalkVoice("story_v_out_413141", "413141096", "story_v_out_413141.awb")
				end

				arg_401_1:RecordContent(arg_401_1.text_.text)
			end

			local var_404_43 = var_404_32 + 0.3
			local var_404_44 = math.max(var_404_33, arg_401_1.talkMaxDuration)

			if var_404_43 <= arg_401_1.time_ and arg_401_1.time_ < var_404_43 + var_404_44 then
				arg_401_1.typewritter.percent = (arg_401_1.time_ - var_404_43) / var_404_44

				arg_401_1.typewritter:SetDirty()
			end

			if arg_401_1.time_ >= var_404_43 + var_404_44 and arg_401_1.time_ < var_404_43 + var_404_44 + arg_404_0 then
				arg_401_1.typewritter.percent = 1

				arg_401_1.typewritter:SetDirty()
				arg_401_1:ShowNextGo(true)
			end
		end

		arg_401_1.nodeConfigList_ = {
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

		arg_401_1:InitPlayNodeList()
	end,
	Play413141097 = function(arg_407_0, arg_407_1)
		arg_407_1.time_ = 0
		arg_407_1.frameCnt_ = 0
		arg_407_1.state_ = "playing"
		arg_407_1.curTalkId_ = 413141097
		arg_407_1.duration_ = 5

		SetActive(arg_407_1.tipsGo_, false)

		function arg_407_1.onSingleLineFinish_()
			arg_407_1.onSingleLineUpdate_ = nil
			arg_407_1.onSingleLineFinish_ = nil
			arg_407_1.state_ = "waiting"
		end

		function arg_407_1.playNext_(arg_409_0)
			if arg_409_0 == 1 then
				arg_407_0:Play413141098(arg_407_1)
			end
		end

		function arg_407_1.onSingleLineUpdate_(arg_410_0)
			local var_410_0 = arg_407_1.actors_["10092_1"].transform
			local var_410_1 = 0

			if var_410_1 < arg_407_1.time_ and arg_407_1.time_ <= var_410_1 + arg_410_0 then
				arg_407_1.var_.moveOldPos10092_1 = var_410_0.localPosition
				var_410_0.localScale = Vector3.New(1, 1, 1)

				arg_407_1:CheckSpriteTmpPos("10092_1", 7)

				local var_410_2 = var_410_0.childCount

				for iter_410_0 = 0, var_410_2 - 1 do
					local var_410_3 = var_410_0:GetChild(iter_410_0)

					if var_410_3.name == "" or not string.find(var_410_3.name, "split") then
						var_410_3.gameObject:SetActive(true)
					else
						var_410_3.gameObject:SetActive(false)
					end
				end
			end

			local var_410_4 = 0.001

			if var_410_1 <= arg_407_1.time_ and arg_407_1.time_ < var_410_1 + var_410_4 then
				local var_410_5 = (arg_407_1.time_ - var_410_1) / var_410_4
				local var_410_6 = Vector3.New(0, -2000, 0)

				var_410_0.localPosition = Vector3.Lerp(arg_407_1.var_.moveOldPos10092_1, var_410_6, var_410_5)
			end

			if arg_407_1.time_ >= var_410_1 + var_410_4 and arg_407_1.time_ < var_410_1 + var_410_4 + arg_410_0 then
				var_410_0.localPosition = Vector3.New(0, -2000, 0)
			end

			local var_410_7 = arg_407_1.actors_["10092_1"]
			local var_410_8 = 0

			if var_410_8 < arg_407_1.time_ and arg_407_1.time_ <= var_410_8 + arg_410_0 and not isNil(var_410_7) and arg_407_1.var_.actorSpriteComps10092_1 == nil then
				arg_407_1.var_.actorSpriteComps10092_1 = var_410_7:GetComponentsInChildren(typeof(Image), true)
			end

			local var_410_9 = 2

			if var_410_8 <= arg_407_1.time_ and arg_407_1.time_ < var_410_8 + var_410_9 and not isNil(var_410_7) then
				local var_410_10 = (arg_407_1.time_ - var_410_8) / var_410_9

				if arg_407_1.var_.actorSpriteComps10092_1 then
					for iter_410_1, iter_410_2 in pairs(arg_407_1.var_.actorSpriteComps10092_1:ToTable()) do
						if iter_410_2 then
							if arg_407_1.isInRecall_ then
								local var_410_11 = Mathf.Lerp(iter_410_2.color.r, arg_407_1.hightColor2.r, var_410_10)
								local var_410_12 = Mathf.Lerp(iter_410_2.color.g, arg_407_1.hightColor2.g, var_410_10)
								local var_410_13 = Mathf.Lerp(iter_410_2.color.b, arg_407_1.hightColor2.b, var_410_10)

								iter_410_2.color = Color.New(var_410_11, var_410_12, var_410_13)
							else
								local var_410_14 = Mathf.Lerp(iter_410_2.color.r, 0.5, var_410_10)

								iter_410_2.color = Color.New(var_410_14, var_410_14, var_410_14)
							end
						end
					end
				end
			end

			if arg_407_1.time_ >= var_410_8 + var_410_9 and arg_407_1.time_ < var_410_8 + var_410_9 + arg_410_0 and not isNil(var_410_7) and arg_407_1.var_.actorSpriteComps10092_1 then
				for iter_410_3, iter_410_4 in pairs(arg_407_1.var_.actorSpriteComps10092_1:ToTable()) do
					if iter_410_4 then
						if arg_407_1.isInRecall_ then
							iter_410_4.color = arg_407_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_410_4.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_407_1.var_.actorSpriteComps10092_1 = nil
			end

			local var_410_15 = 0
			local var_410_16 = 0.95

			if var_410_15 < arg_407_1.time_ and arg_407_1.time_ <= var_410_15 + arg_410_0 then
				arg_407_1.talkMaxDuration = 0
				arg_407_1.dialogCg_.alpha = 1

				arg_407_1.dialog_:SetActive(true)
				SetActive(arg_407_1.leftNameGo_, false)

				arg_407_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_407_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_407_1:RecordName(arg_407_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_407_1.iconTrs_.gameObject, false)
				arg_407_1.callingController_:SetSelectedState("normal")

				local var_410_17 = arg_407_1:GetWordFromCfg(413141097)
				local var_410_18 = arg_407_1:FormatText(var_410_17.content)

				arg_407_1.text_.text = var_410_18

				LuaForUtil.ClearLinePrefixSymbol(arg_407_1.text_)

				local var_410_19 = 38
				local var_410_20 = utf8.len(var_410_18)
				local var_410_21 = var_410_19 <= 0 and var_410_16 or var_410_16 * (var_410_20 / var_410_19)

				if var_410_21 > 0 and var_410_16 < var_410_21 then
					arg_407_1.talkMaxDuration = var_410_21

					if var_410_21 + var_410_15 > arg_407_1.duration_ then
						arg_407_1.duration_ = var_410_21 + var_410_15
					end
				end

				arg_407_1.text_.text = var_410_18
				arg_407_1.typewritter.percent = 0

				arg_407_1.typewritter:SetDirty()
				arg_407_1:ShowNextGo(false)
				arg_407_1:RecordContent(arg_407_1.text_.text)
			end

			local var_410_22 = math.max(var_410_16, arg_407_1.talkMaxDuration)

			if var_410_15 <= arg_407_1.time_ and arg_407_1.time_ < var_410_15 + var_410_22 then
				arg_407_1.typewritter.percent = (arg_407_1.time_ - var_410_15) / var_410_22

				arg_407_1.typewritter:SetDirty()
			end

			if arg_407_1.time_ >= var_410_15 + var_410_22 and arg_407_1.time_ < var_410_15 + var_410_22 + arg_410_0 then
				arg_407_1.typewritter.percent = 1

				arg_407_1.typewritter:SetDirty()
				arg_407_1:ShowNextGo(true)
			end
		end

		arg_407_1.nodeConfigList_ = {
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

		arg_407_1:InitPlayNodeList()
	end,
	Play413141098 = function(arg_411_0, arg_411_1)
		arg_411_1.time_ = 0
		arg_411_1.frameCnt_ = 0
		arg_411_1.state_ = "playing"
		arg_411_1.curTalkId_ = 413141098
		arg_411_1.duration_ = 3

		local var_411_0 = {
			zh = 3,
			ja = 2.133
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
				arg_411_0:Play413141099(arg_411_1)
			end
		end

		function arg_411_1.onSingleLineUpdate_(arg_414_0)
			local var_414_0 = arg_411_1.actors_["10093"].transform
			local var_414_1 = 0

			if var_414_1 < arg_411_1.time_ and arg_411_1.time_ <= var_414_1 + arg_414_0 then
				arg_411_1.var_.moveOldPos10093 = var_414_0.localPosition
				var_414_0.localScale = Vector3.New(1, 1, 1)

				arg_411_1:CheckSpriteTmpPos("10093", 3)

				local var_414_2 = var_414_0.childCount

				for iter_414_0 = 0, var_414_2 - 1 do
					local var_414_3 = var_414_0:GetChild(iter_414_0)

					if var_414_3.name == "split_4" or not string.find(var_414_3.name, "split") then
						var_414_3.gameObject:SetActive(true)
					else
						var_414_3.gameObject:SetActive(false)
					end
				end
			end

			local var_414_4 = 0.001

			if var_414_1 <= arg_411_1.time_ and arg_411_1.time_ < var_414_1 + var_414_4 then
				local var_414_5 = (arg_411_1.time_ - var_414_1) / var_414_4
				local var_414_6 = Vector3.New(0, -345, -245)

				var_414_0.localPosition = Vector3.Lerp(arg_411_1.var_.moveOldPos10093, var_414_6, var_414_5)
			end

			if arg_411_1.time_ >= var_414_1 + var_414_4 and arg_411_1.time_ < var_414_1 + var_414_4 + arg_414_0 then
				var_414_0.localPosition = Vector3.New(0, -345, -245)
			end

			local var_414_7 = arg_411_1.actors_["10092_1"]
			local var_414_8 = 0

			if var_414_8 < arg_411_1.time_ and arg_411_1.time_ <= var_414_8 + arg_414_0 and not isNil(var_414_7) and arg_411_1.var_.actorSpriteComps10092_1 == nil then
				arg_411_1.var_.actorSpriteComps10092_1 = var_414_7:GetComponentsInChildren(typeof(Image), true)
			end

			local var_414_9 = 2

			if var_414_8 <= arg_411_1.time_ and arg_411_1.time_ < var_414_8 + var_414_9 and not isNil(var_414_7) then
				local var_414_10 = (arg_411_1.time_ - var_414_8) / var_414_9

				if arg_411_1.var_.actorSpriteComps10092_1 then
					for iter_414_1, iter_414_2 in pairs(arg_411_1.var_.actorSpriteComps10092_1:ToTable()) do
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

			if arg_411_1.time_ >= var_414_8 + var_414_9 and arg_411_1.time_ < var_414_8 + var_414_9 + arg_414_0 and not isNil(var_414_7) and arg_411_1.var_.actorSpriteComps10092_1 then
				for iter_414_3, iter_414_4 in pairs(arg_411_1.var_.actorSpriteComps10092_1:ToTable()) do
					if iter_414_4 then
						if arg_411_1.isInRecall_ then
							iter_414_4.color = arg_411_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_414_4.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_411_1.var_.actorSpriteComps10092_1 = nil
			end

			local var_414_15 = arg_411_1.actors_["10093"]
			local var_414_16 = 0

			if var_414_16 < arg_411_1.time_ and arg_411_1.time_ <= var_414_16 + arg_414_0 and not isNil(var_414_15) and arg_411_1.var_.actorSpriteComps10093 == nil then
				arg_411_1.var_.actorSpriteComps10093 = var_414_15:GetComponentsInChildren(typeof(Image), true)
			end

			local var_414_17 = 2

			if var_414_16 <= arg_411_1.time_ and arg_411_1.time_ < var_414_16 + var_414_17 and not isNil(var_414_15) then
				local var_414_18 = (arg_411_1.time_ - var_414_16) / var_414_17

				if arg_411_1.var_.actorSpriteComps10093 then
					for iter_414_5, iter_414_6 in pairs(arg_411_1.var_.actorSpriteComps10093:ToTable()) do
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

			if arg_411_1.time_ >= var_414_16 + var_414_17 and arg_411_1.time_ < var_414_16 + var_414_17 + arg_414_0 and not isNil(var_414_15) and arg_411_1.var_.actorSpriteComps10093 then
				for iter_414_7, iter_414_8 in pairs(arg_411_1.var_.actorSpriteComps10093:ToTable()) do
					if iter_414_8 then
						if arg_411_1.isInRecall_ then
							iter_414_8.color = arg_411_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_414_8.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_411_1.var_.actorSpriteComps10093 = nil
			end

			local var_414_23 = 0
			local var_414_24 = 0.325

			if var_414_23 < arg_411_1.time_ and arg_411_1.time_ <= var_414_23 + arg_414_0 then
				arg_411_1.talkMaxDuration = 0
				arg_411_1.dialogCg_.alpha = 1

				arg_411_1.dialog_:SetActive(true)
				SetActive(arg_411_1.leftNameGo_, true)

				local var_414_25 = arg_411_1:FormatText(StoryNameCfg[28].name)

				arg_411_1.leftNameTxt_.text = var_414_25

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_411_1.leftNameTxt_.transform)

				arg_411_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_411_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_411_1:RecordName(arg_411_1.leftNameTxt_.text)
				SetActive(arg_411_1.iconTrs_.gameObject, false)
				arg_411_1.callingController_:SetSelectedState("normal")

				local var_414_26 = arg_411_1:GetWordFromCfg(413141098)
				local var_414_27 = arg_411_1:FormatText(var_414_26.content)

				arg_411_1.text_.text = var_414_27

				LuaForUtil.ClearLinePrefixSymbol(arg_411_1.text_)

				local var_414_28 = 13
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

				if manager.audio:GetVoiceLength("story_v_out_413141", "413141098", "story_v_out_413141.awb") ~= 0 then
					local var_414_31 = manager.audio:GetVoiceLength("story_v_out_413141", "413141098", "story_v_out_413141.awb") / 1000

					if var_414_31 + var_414_23 > arg_411_1.duration_ then
						arg_411_1.duration_ = var_414_31 + var_414_23
					end

					if var_414_26.prefab_name ~= "" and arg_411_1.actors_[var_414_26.prefab_name] ~= nil then
						local var_414_32 = LuaForUtil.PlayVoiceWithCriLipsync(arg_411_1.actors_[var_414_26.prefab_name].transform, "story_v_out_413141", "413141098", "story_v_out_413141.awb")

						arg_411_1:RecordAudio("413141098", var_414_32)
						arg_411_1:RecordAudio("413141098", var_414_32)
					else
						arg_411_1:AudioAction("play", "voice", "story_v_out_413141", "413141098", "story_v_out_413141.awb")
					end

					arg_411_1:RecordHistoryTalkVoice("story_v_out_413141", "413141098", "story_v_out_413141.awb")
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
				actorName = "10093",
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
	Play413141099 = function(arg_415_0, arg_415_1)
		arg_415_1.time_ = 0
		arg_415_1.frameCnt_ = 0
		arg_415_1.state_ = "playing"
		arg_415_1.curTalkId_ = 413141099
		arg_415_1.duration_ = 8.3

		local var_415_0 = {
			zh = 5.6,
			ja = 8.3
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
				arg_415_0:Play413141100(arg_415_1)
			end
		end

		function arg_415_1.onSingleLineUpdate_(arg_418_0)
			local var_418_0 = arg_415_1.actors_["10092_1"].transform
			local var_418_1 = 0

			if var_418_1 < arg_415_1.time_ and arg_415_1.time_ <= var_418_1 + arg_418_0 then
				arg_415_1.var_.moveOldPos10092_1 = var_418_0.localPosition
				var_418_0.localScale = Vector3.New(1, 1, 1)

				arg_415_1:CheckSpriteTmpPos("10092_1", 3)

				local var_418_2 = var_418_0.childCount

				for iter_418_0 = 0, var_418_2 - 1 do
					local var_418_3 = var_418_0:GetChild(iter_418_0)

					if var_418_3.name == "" or not string.find(var_418_3.name, "split") then
						var_418_3.gameObject:SetActive(true)
					else
						var_418_3.gameObject:SetActive(false)
					end
				end
			end

			local var_418_4 = 0.001

			if var_418_1 <= arg_415_1.time_ and arg_415_1.time_ < var_418_1 + var_418_4 then
				local var_418_5 = (arg_415_1.time_ - var_418_1) / var_418_4
				local var_418_6 = Vector3.New(0, -300, -295)

				var_418_0.localPosition = Vector3.Lerp(arg_415_1.var_.moveOldPos10092_1, var_418_6, var_418_5)
			end

			if arg_415_1.time_ >= var_418_1 + var_418_4 and arg_415_1.time_ < var_418_1 + var_418_4 + arg_418_0 then
				var_418_0.localPosition = Vector3.New(0, -300, -295)
			end

			local var_418_7 = arg_415_1.actors_["10092_1"]
			local var_418_8 = 0

			if var_418_8 < arg_415_1.time_ and arg_415_1.time_ <= var_418_8 + arg_418_0 and not isNil(var_418_7) and arg_415_1.var_.actorSpriteComps10092_1 == nil then
				arg_415_1.var_.actorSpriteComps10092_1 = var_418_7:GetComponentsInChildren(typeof(Image), true)
			end

			local var_418_9 = 2

			if var_418_8 <= arg_415_1.time_ and arg_415_1.time_ < var_418_8 + var_418_9 and not isNil(var_418_7) then
				local var_418_10 = (arg_415_1.time_ - var_418_8) / var_418_9

				if arg_415_1.var_.actorSpriteComps10092_1 then
					for iter_418_1, iter_418_2 in pairs(arg_415_1.var_.actorSpriteComps10092_1:ToTable()) do
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

			if arg_415_1.time_ >= var_418_8 + var_418_9 and arg_415_1.time_ < var_418_8 + var_418_9 + arg_418_0 and not isNil(var_418_7) and arg_415_1.var_.actorSpriteComps10092_1 then
				for iter_418_3, iter_418_4 in pairs(arg_415_1.var_.actorSpriteComps10092_1:ToTable()) do
					if iter_418_4 then
						if arg_415_1.isInRecall_ then
							iter_418_4.color = arg_415_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_418_4.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_415_1.var_.actorSpriteComps10092_1 = nil
			end

			local var_418_15 = arg_415_1.actors_["10093"]
			local var_418_16 = 0

			if var_418_16 < arg_415_1.time_ and arg_415_1.time_ <= var_418_16 + arg_418_0 and not isNil(var_418_15) and arg_415_1.var_.actorSpriteComps10093 == nil then
				arg_415_1.var_.actorSpriteComps10093 = var_418_15:GetComponentsInChildren(typeof(Image), true)
			end

			local var_418_17 = 2

			if var_418_16 <= arg_415_1.time_ and arg_415_1.time_ < var_418_16 + var_418_17 and not isNil(var_418_15) then
				local var_418_18 = (arg_415_1.time_ - var_418_16) / var_418_17

				if arg_415_1.var_.actorSpriteComps10093 then
					for iter_418_5, iter_418_6 in pairs(arg_415_1.var_.actorSpriteComps10093:ToTable()) do
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

			if arg_415_1.time_ >= var_418_16 + var_418_17 and arg_415_1.time_ < var_418_16 + var_418_17 + arg_418_0 and not isNil(var_418_15) and arg_415_1.var_.actorSpriteComps10093 then
				for iter_418_7, iter_418_8 in pairs(arg_415_1.var_.actorSpriteComps10093:ToTable()) do
					if iter_418_8 then
						if arg_415_1.isInRecall_ then
							iter_418_8.color = arg_415_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_418_8.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_415_1.var_.actorSpriteComps10093 = nil
			end

			local var_418_23 = 0
			local var_418_24 = 0.8

			if var_418_23 < arg_415_1.time_ and arg_415_1.time_ <= var_418_23 + arg_418_0 then
				arg_415_1.talkMaxDuration = 0
				arg_415_1.dialogCg_.alpha = 1

				arg_415_1.dialog_:SetActive(true)
				SetActive(arg_415_1.leftNameGo_, true)

				local var_418_25 = arg_415_1:FormatText(StoryNameCfg[996].name)

				arg_415_1.leftNameTxt_.text = var_418_25

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_415_1.leftNameTxt_.transform)

				arg_415_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_415_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_415_1:RecordName(arg_415_1.leftNameTxt_.text)
				SetActive(arg_415_1.iconTrs_.gameObject, false)
				arg_415_1.callingController_:SetSelectedState("normal")

				local var_418_26 = arg_415_1:GetWordFromCfg(413141099)
				local var_418_27 = arg_415_1:FormatText(var_418_26.content)

				arg_415_1.text_.text = var_418_27

				LuaForUtil.ClearLinePrefixSymbol(arg_415_1.text_)

				local var_418_28 = 32
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

				if manager.audio:GetVoiceLength("story_v_out_413141", "413141099", "story_v_out_413141.awb") ~= 0 then
					local var_418_31 = manager.audio:GetVoiceLength("story_v_out_413141", "413141099", "story_v_out_413141.awb") / 1000

					if var_418_31 + var_418_23 > arg_415_1.duration_ then
						arg_415_1.duration_ = var_418_31 + var_418_23
					end

					if var_418_26.prefab_name ~= "" and arg_415_1.actors_[var_418_26.prefab_name] ~= nil then
						local var_418_32 = LuaForUtil.PlayVoiceWithCriLipsync(arg_415_1.actors_[var_418_26.prefab_name].transform, "story_v_out_413141", "413141099", "story_v_out_413141.awb")

						arg_415_1:RecordAudio("413141099", var_418_32)
						arg_415_1:RecordAudio("413141099", var_418_32)
					else
						arg_415_1:AudioAction("play", "voice", "story_v_out_413141", "413141099", "story_v_out_413141.awb")
					end

					arg_415_1:RecordHistoryTalkVoice("story_v_out_413141", "413141099", "story_v_out_413141.awb")
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
				actorName = "10092_1",
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
	Play413141100 = function(arg_419_0, arg_419_1)
		arg_419_1.time_ = 0
		arg_419_1.frameCnt_ = 0
		arg_419_1.state_ = "playing"
		arg_419_1.curTalkId_ = 413141100
		arg_419_1.duration_ = 10.53

		local var_419_0 = {
			zh = 5.466,
			ja = 10.533
		}
		local var_419_1 = manager.audio:GetLocalizationFlag()

		if var_419_0[var_419_1] ~= nil then
			arg_419_1.duration_ = var_419_0[var_419_1]
		end

		SetActive(arg_419_1.tipsGo_, false)

		function arg_419_1.onSingleLineFinish_()
			arg_419_1.onSingleLineUpdate_ = nil
			arg_419_1.onSingleLineFinish_ = nil
			arg_419_1.state_ = "waiting"
		end

		function arg_419_1.playNext_(arg_421_0)
			if arg_421_0 == 1 then
				arg_419_0:Play413141101(arg_419_1)
			end
		end

		function arg_419_1.onSingleLineUpdate_(arg_422_0)
			local var_422_0 = 0
			local var_422_1 = 0.775

			if var_422_0 < arg_419_1.time_ and arg_419_1.time_ <= var_422_0 + arg_422_0 then
				arg_419_1.talkMaxDuration = 0
				arg_419_1.dialogCg_.alpha = 1

				arg_419_1.dialog_:SetActive(true)
				SetActive(arg_419_1.leftNameGo_, true)

				local var_422_2 = arg_419_1:FormatText(StoryNameCfg[996].name)

				arg_419_1.leftNameTxt_.text = var_422_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_419_1.leftNameTxt_.transform)

				arg_419_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_419_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_419_1:RecordName(arg_419_1.leftNameTxt_.text)
				SetActive(arg_419_1.iconTrs_.gameObject, false)
				arg_419_1.callingController_:SetSelectedState("normal")

				local var_422_3 = arg_419_1:GetWordFromCfg(413141100)
				local var_422_4 = arg_419_1:FormatText(var_422_3.content)

				arg_419_1.text_.text = var_422_4

				LuaForUtil.ClearLinePrefixSymbol(arg_419_1.text_)

				local var_422_5 = 31
				local var_422_6 = utf8.len(var_422_4)
				local var_422_7 = var_422_5 <= 0 and var_422_1 or var_422_1 * (var_422_6 / var_422_5)

				if var_422_7 > 0 and var_422_1 < var_422_7 then
					arg_419_1.talkMaxDuration = var_422_7

					if var_422_7 + var_422_0 > arg_419_1.duration_ then
						arg_419_1.duration_ = var_422_7 + var_422_0
					end
				end

				arg_419_1.text_.text = var_422_4
				arg_419_1.typewritter.percent = 0

				arg_419_1.typewritter:SetDirty()
				arg_419_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_413141", "413141100", "story_v_out_413141.awb") ~= 0 then
					local var_422_8 = manager.audio:GetVoiceLength("story_v_out_413141", "413141100", "story_v_out_413141.awb") / 1000

					if var_422_8 + var_422_0 > arg_419_1.duration_ then
						arg_419_1.duration_ = var_422_8 + var_422_0
					end

					if var_422_3.prefab_name ~= "" and arg_419_1.actors_[var_422_3.prefab_name] ~= nil then
						local var_422_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_419_1.actors_[var_422_3.prefab_name].transform, "story_v_out_413141", "413141100", "story_v_out_413141.awb")

						arg_419_1:RecordAudio("413141100", var_422_9)
						arg_419_1:RecordAudio("413141100", var_422_9)
					else
						arg_419_1:AudioAction("play", "voice", "story_v_out_413141", "413141100", "story_v_out_413141.awb")
					end

					arg_419_1:RecordHistoryTalkVoice("story_v_out_413141", "413141100", "story_v_out_413141.awb")
				end

				arg_419_1:RecordContent(arg_419_1.text_.text)
			end

			local var_422_10 = math.max(var_422_1, arg_419_1.talkMaxDuration)

			if var_422_0 <= arg_419_1.time_ and arg_419_1.time_ < var_422_0 + var_422_10 then
				arg_419_1.typewritter.percent = (arg_419_1.time_ - var_422_0) / var_422_10

				arg_419_1.typewritter:SetDirty()
			end

			if arg_419_1.time_ >= var_422_0 + var_422_10 and arg_419_1.time_ < var_422_0 + var_422_10 + arg_422_0 then
				arg_419_1.typewritter.percent = 1

				arg_419_1.typewritter:SetDirty()
				arg_419_1:ShowNextGo(true)
			end
		end

		arg_419_1.nodeConfigList_ = {}

		arg_419_1:InitPlayNodeList()
	end,
	Play413141101 = function(arg_423_0, arg_423_1)
		arg_423_1.time_ = 0
		arg_423_1.frameCnt_ = 0
		arg_423_1.state_ = "playing"
		arg_423_1.curTalkId_ = 413141101
		arg_423_1.duration_ = 7.6

		local var_423_0 = {
			zh = 3.966,
			ja = 7.6
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
				arg_423_0:Play413141102(arg_423_1)
			end
		end

		function arg_423_1.onSingleLineUpdate_(arg_426_0)
			local var_426_0 = arg_423_1.actors_["10092_1"].transform
			local var_426_1 = 0

			if var_426_1 < arg_423_1.time_ and arg_423_1.time_ <= var_426_1 + arg_426_0 then
				arg_423_1.var_.moveOldPos10092_1 = var_426_0.localPosition
				var_426_0.localScale = Vector3.New(1, 1, 1)

				arg_423_1:CheckSpriteTmpPos("10092_1", 3)

				local var_426_2 = var_426_0.childCount

				for iter_426_0 = 0, var_426_2 - 1 do
					local var_426_3 = var_426_0:GetChild(iter_426_0)

					if var_426_3.name == "" or not string.find(var_426_3.name, "split") then
						var_426_3.gameObject:SetActive(true)
					else
						var_426_3.gameObject:SetActive(false)
					end
				end
			end

			local var_426_4 = 0.001

			if var_426_1 <= arg_423_1.time_ and arg_423_1.time_ < var_426_1 + var_426_4 then
				local var_426_5 = (arg_423_1.time_ - var_426_1) / var_426_4
				local var_426_6 = Vector3.New(0, -300, -295)

				var_426_0.localPosition = Vector3.Lerp(arg_423_1.var_.moveOldPos10092_1, var_426_6, var_426_5)
			end

			if arg_423_1.time_ >= var_426_1 + var_426_4 and arg_423_1.time_ < var_426_1 + var_426_4 + arg_426_0 then
				var_426_0.localPosition = Vector3.New(0, -300, -295)
			end

			local var_426_7 = arg_423_1.actors_["10092"]
			local var_426_8 = 0

			if var_426_8 < arg_423_1.time_ and arg_423_1.time_ <= var_426_8 + arg_426_0 and not isNil(var_426_7) and arg_423_1.var_.actorSpriteComps10092 == nil then
				arg_423_1.var_.actorSpriteComps10092 = var_426_7:GetComponentsInChildren(typeof(Image), true)
			end

			local var_426_9 = 2

			if var_426_8 <= arg_423_1.time_ and arg_423_1.time_ < var_426_8 + var_426_9 and not isNil(var_426_7) then
				local var_426_10 = (arg_423_1.time_ - var_426_8) / var_426_9

				if arg_423_1.var_.actorSpriteComps10092 then
					for iter_426_1, iter_426_2 in pairs(arg_423_1.var_.actorSpriteComps10092:ToTable()) do
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

			if arg_423_1.time_ >= var_426_8 + var_426_9 and arg_423_1.time_ < var_426_8 + var_426_9 + arg_426_0 and not isNil(var_426_7) and arg_423_1.var_.actorSpriteComps10092 then
				for iter_426_3, iter_426_4 in pairs(arg_423_1.var_.actorSpriteComps10092:ToTable()) do
					if iter_426_4 then
						if arg_423_1.isInRecall_ then
							iter_426_4.color = arg_423_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_426_4.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_423_1.var_.actorSpriteComps10092 = nil
			end

			local var_426_15 = 0
			local var_426_16 = 0.475

			if var_426_15 < arg_423_1.time_ and arg_423_1.time_ <= var_426_15 + arg_426_0 then
				arg_423_1.talkMaxDuration = 0
				arg_423_1.dialogCg_.alpha = 1

				arg_423_1.dialog_:SetActive(true)
				SetActive(arg_423_1.leftNameGo_, true)

				local var_426_17 = arg_423_1:FormatText(StoryNameCfg[996].name)

				arg_423_1.leftNameTxt_.text = var_426_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_423_1.leftNameTxt_.transform)

				arg_423_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_423_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_423_1:RecordName(arg_423_1.leftNameTxt_.text)
				SetActive(arg_423_1.iconTrs_.gameObject, false)
				arg_423_1.callingController_:SetSelectedState("normal")

				local var_426_18 = arg_423_1:GetWordFromCfg(413141101)
				local var_426_19 = arg_423_1:FormatText(var_426_18.content)

				arg_423_1.text_.text = var_426_19

				LuaForUtil.ClearLinePrefixSymbol(arg_423_1.text_)

				local var_426_20 = 19
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

				if manager.audio:GetVoiceLength("story_v_out_413141", "413141101", "story_v_out_413141.awb") ~= 0 then
					local var_426_23 = manager.audio:GetVoiceLength("story_v_out_413141", "413141101", "story_v_out_413141.awb") / 1000

					if var_426_23 + var_426_15 > arg_423_1.duration_ then
						arg_423_1.duration_ = var_426_23 + var_426_15
					end

					if var_426_18.prefab_name ~= "" and arg_423_1.actors_[var_426_18.prefab_name] ~= nil then
						local var_426_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_423_1.actors_[var_426_18.prefab_name].transform, "story_v_out_413141", "413141101", "story_v_out_413141.awb")

						arg_423_1:RecordAudio("413141101", var_426_24)
						arg_423_1:RecordAudio("413141101", var_426_24)
					else
						arg_423_1:AudioAction("play", "voice", "story_v_out_413141", "413141101", "story_v_out_413141.awb")
					end

					arg_423_1:RecordHistoryTalkVoice("story_v_out_413141", "413141101", "story_v_out_413141.awb")
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
				actorName = "10092_1",
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
	Play413141102 = function(arg_427_0, arg_427_1)
		arg_427_1.time_ = 0
		arg_427_1.frameCnt_ = 0
		arg_427_1.state_ = "playing"
		arg_427_1.curTalkId_ = 413141102
		arg_427_1.duration_ = 5.03

		local var_427_0 = {
			zh = 4.166,
			ja = 5.033
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
				arg_427_0:Play413141103(arg_427_1)
			end
		end

		function arg_427_1.onSingleLineUpdate_(arg_430_0)
			local var_430_0 = arg_427_1.actors_["10092_1"].transform
			local var_430_1 = 0

			if var_430_1 < arg_427_1.time_ and arg_427_1.time_ <= var_430_1 + arg_430_0 then
				arg_427_1.var_.moveOldPos10092_1 = var_430_0.localPosition
				var_430_0.localScale = Vector3.New(1, 1, 1)

				arg_427_1:CheckSpriteTmpPos("10092_1", 2)

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
				local var_430_6 = Vector3.New(-389.49, -300, -295)

				var_430_0.localPosition = Vector3.Lerp(arg_427_1.var_.moveOldPos10092_1, var_430_6, var_430_5)
			end

			if arg_427_1.time_ >= var_430_1 + var_430_4 and arg_427_1.time_ < var_430_1 + var_430_4 + arg_430_0 then
				var_430_0.localPosition = Vector3.New(-389.49, -300, -295)
			end

			local var_430_7 = arg_427_1.actors_["10093"].transform
			local var_430_8 = 0

			if var_430_8 < arg_427_1.time_ and arg_427_1.time_ <= var_430_8 + arg_430_0 then
				arg_427_1.var_.moveOldPos10093 = var_430_7.localPosition
				var_430_7.localScale = Vector3.New(1, 1, 1)

				arg_427_1:CheckSpriteTmpPos("10093", 4)

				local var_430_9 = var_430_7.childCount

				for iter_430_1 = 0, var_430_9 - 1 do
					local var_430_10 = var_430_7:GetChild(iter_430_1)

					if var_430_10.name == "split_5" or not string.find(var_430_10.name, "split") then
						var_430_10.gameObject:SetActive(true)
					else
						var_430_10.gameObject:SetActive(false)
					end
				end
			end

			local var_430_11 = 0.001

			if var_430_8 <= arg_427_1.time_ and arg_427_1.time_ < var_430_8 + var_430_11 then
				local var_430_12 = (arg_427_1.time_ - var_430_8) / var_430_11
				local var_430_13 = Vector3.New(390, -345, -245)

				var_430_7.localPosition = Vector3.Lerp(arg_427_1.var_.moveOldPos10093, var_430_13, var_430_12)
			end

			if arg_427_1.time_ >= var_430_8 + var_430_11 and arg_427_1.time_ < var_430_8 + var_430_11 + arg_430_0 then
				var_430_7.localPosition = Vector3.New(390, -345, -245)
			end

			local var_430_14 = arg_427_1.actors_["10092_1"]
			local var_430_15 = 0

			if var_430_15 < arg_427_1.time_ and arg_427_1.time_ <= var_430_15 + arg_430_0 and not isNil(var_430_14) and arg_427_1.var_.actorSpriteComps10092_1 == nil then
				arg_427_1.var_.actorSpriteComps10092_1 = var_430_14:GetComponentsInChildren(typeof(Image), true)
			end

			local var_430_16 = 2

			if var_430_15 <= arg_427_1.time_ and arg_427_1.time_ < var_430_15 + var_430_16 and not isNil(var_430_14) then
				local var_430_17 = (arg_427_1.time_ - var_430_15) / var_430_16

				if arg_427_1.var_.actorSpriteComps10092_1 then
					for iter_430_2, iter_430_3 in pairs(arg_427_1.var_.actorSpriteComps10092_1:ToTable()) do
						if iter_430_3 then
							if arg_427_1.isInRecall_ then
								local var_430_18 = Mathf.Lerp(iter_430_3.color.r, arg_427_1.hightColor2.r, var_430_17)
								local var_430_19 = Mathf.Lerp(iter_430_3.color.g, arg_427_1.hightColor2.g, var_430_17)
								local var_430_20 = Mathf.Lerp(iter_430_3.color.b, arg_427_1.hightColor2.b, var_430_17)

								iter_430_3.color = Color.New(var_430_18, var_430_19, var_430_20)
							else
								local var_430_21 = Mathf.Lerp(iter_430_3.color.r, 0.5, var_430_17)

								iter_430_3.color = Color.New(var_430_21, var_430_21, var_430_21)
							end
						end
					end
				end
			end

			if arg_427_1.time_ >= var_430_15 + var_430_16 and arg_427_1.time_ < var_430_15 + var_430_16 + arg_430_0 and not isNil(var_430_14) and arg_427_1.var_.actorSpriteComps10092_1 then
				for iter_430_4, iter_430_5 in pairs(arg_427_1.var_.actorSpriteComps10092_1:ToTable()) do
					if iter_430_5 then
						if arg_427_1.isInRecall_ then
							iter_430_5.color = arg_427_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_430_5.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_427_1.var_.actorSpriteComps10092_1 = nil
			end

			local var_430_22 = arg_427_1.actors_["10093"]
			local var_430_23 = 0

			if var_430_23 < arg_427_1.time_ and arg_427_1.time_ <= var_430_23 + arg_430_0 and not isNil(var_430_22) and arg_427_1.var_.actorSpriteComps10093 == nil then
				arg_427_1.var_.actorSpriteComps10093 = var_430_22:GetComponentsInChildren(typeof(Image), true)
			end

			local var_430_24 = 2

			if var_430_23 <= arg_427_1.time_ and arg_427_1.time_ < var_430_23 + var_430_24 and not isNil(var_430_22) then
				local var_430_25 = (arg_427_1.time_ - var_430_23) / var_430_24

				if arg_427_1.var_.actorSpriteComps10093 then
					for iter_430_6, iter_430_7 in pairs(arg_427_1.var_.actorSpriteComps10093:ToTable()) do
						if iter_430_7 then
							if arg_427_1.isInRecall_ then
								local var_430_26 = Mathf.Lerp(iter_430_7.color.r, arg_427_1.hightColor1.r, var_430_25)
								local var_430_27 = Mathf.Lerp(iter_430_7.color.g, arg_427_1.hightColor1.g, var_430_25)
								local var_430_28 = Mathf.Lerp(iter_430_7.color.b, arg_427_1.hightColor1.b, var_430_25)

								iter_430_7.color = Color.New(var_430_26, var_430_27, var_430_28)
							else
								local var_430_29 = Mathf.Lerp(iter_430_7.color.r, 1, var_430_25)

								iter_430_7.color = Color.New(var_430_29, var_430_29, var_430_29)
							end
						end
					end
				end
			end

			if arg_427_1.time_ >= var_430_23 + var_430_24 and arg_427_1.time_ < var_430_23 + var_430_24 + arg_430_0 and not isNil(var_430_22) and arg_427_1.var_.actorSpriteComps10093 then
				for iter_430_8, iter_430_9 in pairs(arg_427_1.var_.actorSpriteComps10093:ToTable()) do
					if iter_430_9 then
						if arg_427_1.isInRecall_ then
							iter_430_9.color = arg_427_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_430_9.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_427_1.var_.actorSpriteComps10093 = nil
			end

			local var_430_30 = 0
			local var_430_31 = 0.375

			if var_430_30 < arg_427_1.time_ and arg_427_1.time_ <= var_430_30 + arg_430_0 then
				arg_427_1.talkMaxDuration = 0
				arg_427_1.dialogCg_.alpha = 1

				arg_427_1.dialog_:SetActive(true)
				SetActive(arg_427_1.leftNameGo_, true)

				local var_430_32 = arg_427_1:FormatText(StoryNameCfg[28].name)

				arg_427_1.leftNameTxt_.text = var_430_32

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_427_1.leftNameTxt_.transform)

				arg_427_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_427_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_427_1:RecordName(arg_427_1.leftNameTxt_.text)
				SetActive(arg_427_1.iconTrs_.gameObject, false)
				arg_427_1.callingController_:SetSelectedState("normal")

				local var_430_33 = arg_427_1:GetWordFromCfg(413141102)
				local var_430_34 = arg_427_1:FormatText(var_430_33.content)

				arg_427_1.text_.text = var_430_34

				LuaForUtil.ClearLinePrefixSymbol(arg_427_1.text_)

				local var_430_35 = 15
				local var_430_36 = utf8.len(var_430_34)
				local var_430_37 = var_430_35 <= 0 and var_430_31 or var_430_31 * (var_430_36 / var_430_35)

				if var_430_37 > 0 and var_430_31 < var_430_37 then
					arg_427_1.talkMaxDuration = var_430_37

					if var_430_37 + var_430_30 > arg_427_1.duration_ then
						arg_427_1.duration_ = var_430_37 + var_430_30
					end
				end

				arg_427_1.text_.text = var_430_34
				arg_427_1.typewritter.percent = 0

				arg_427_1.typewritter:SetDirty()
				arg_427_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_413141", "413141102", "story_v_out_413141.awb") ~= 0 then
					local var_430_38 = manager.audio:GetVoiceLength("story_v_out_413141", "413141102", "story_v_out_413141.awb") / 1000

					if var_430_38 + var_430_30 > arg_427_1.duration_ then
						arg_427_1.duration_ = var_430_38 + var_430_30
					end

					if var_430_33.prefab_name ~= "" and arg_427_1.actors_[var_430_33.prefab_name] ~= nil then
						local var_430_39 = LuaForUtil.PlayVoiceWithCriLipsync(arg_427_1.actors_[var_430_33.prefab_name].transform, "story_v_out_413141", "413141102", "story_v_out_413141.awb")

						arg_427_1:RecordAudio("413141102", var_430_39)
						arg_427_1:RecordAudio("413141102", var_430_39)
					else
						arg_427_1:AudioAction("play", "voice", "story_v_out_413141", "413141102", "story_v_out_413141.awb")
					end

					arg_427_1:RecordHistoryTalkVoice("story_v_out_413141", "413141102", "story_v_out_413141.awb")
				end

				arg_427_1:RecordContent(arg_427_1.text_.text)
			end

			local var_430_40 = math.max(var_430_31, arg_427_1.talkMaxDuration)

			if var_430_30 <= arg_427_1.time_ and arg_427_1.time_ < var_430_30 + var_430_40 then
				arg_427_1.typewritter.percent = (arg_427_1.time_ - var_430_30) / var_430_40

				arg_427_1.typewritter:SetDirty()
			end

			if arg_427_1.time_ >= var_430_30 + var_430_40 and arg_427_1.time_ < var_430_30 + var_430_40 + arg_430_0 then
				arg_427_1.typewritter.percent = 1

				arg_427_1.typewritter:SetDirty()
				arg_427_1:ShowNextGo(true)
			end
		end

		arg_427_1.nodeConfigList_ = {
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

		arg_427_1:InitPlayNodeList()
	end,
	Play413141103 = function(arg_431_0, arg_431_1)
		arg_431_1.time_ = 0
		arg_431_1.frameCnt_ = 0
		arg_431_1.state_ = "playing"
		arg_431_1.curTalkId_ = 413141103
		arg_431_1.duration_ = 6.1

		local var_431_0 = {
			zh = 4.666,
			ja = 6.1
		}
		local var_431_1 = manager.audio:GetLocalizationFlag()

		if var_431_0[var_431_1] ~= nil then
			arg_431_1.duration_ = var_431_0[var_431_1]
		end

		SetActive(arg_431_1.tipsGo_, false)

		function arg_431_1.onSingleLineFinish_()
			arg_431_1.onSingleLineUpdate_ = nil
			arg_431_1.onSingleLineFinish_ = nil
			arg_431_1.state_ = "waiting"
		end

		function arg_431_1.playNext_(arg_433_0)
			if arg_433_0 == 1 then
				arg_431_0:Play413141104(arg_431_1)
			end
		end

		function arg_431_1.onSingleLineUpdate_(arg_434_0)
			local var_434_0 = arg_431_1.actors_["10092_1"].transform
			local var_434_1 = 0

			if var_434_1 < arg_431_1.time_ and arg_431_1.time_ <= var_434_1 + arg_434_0 then
				arg_431_1.var_.moveOldPos10092_1 = var_434_0.localPosition
				var_434_0.localScale = Vector3.New(1, 1, 1)

				arg_431_1:CheckSpriteTmpPos("10092_1", 2)

				local var_434_2 = var_434_0.childCount

				for iter_434_0 = 0, var_434_2 - 1 do
					local var_434_3 = var_434_0:GetChild(iter_434_0)

					if var_434_3.name == "split_1_1" or not string.find(var_434_3.name, "split") then
						var_434_3.gameObject:SetActive(true)
					else
						var_434_3.gameObject:SetActive(false)
					end
				end
			end

			local var_434_4 = 0.001

			if var_434_1 <= arg_431_1.time_ and arg_431_1.time_ < var_434_1 + var_434_4 then
				local var_434_5 = (arg_431_1.time_ - var_434_1) / var_434_4
				local var_434_6 = Vector3.New(-389.49, -300, -295)

				var_434_0.localPosition = Vector3.Lerp(arg_431_1.var_.moveOldPos10092_1, var_434_6, var_434_5)
			end

			if arg_431_1.time_ >= var_434_1 + var_434_4 and arg_431_1.time_ < var_434_1 + var_434_4 + arg_434_0 then
				var_434_0.localPosition = Vector3.New(-389.49, -300, -295)
			end

			local var_434_7 = arg_431_1.actors_["10092_1"]
			local var_434_8 = 0

			if var_434_8 < arg_431_1.time_ and arg_431_1.time_ <= var_434_8 + arg_434_0 and not isNil(var_434_7) and arg_431_1.var_.actorSpriteComps10092_1 == nil then
				arg_431_1.var_.actorSpriteComps10092_1 = var_434_7:GetComponentsInChildren(typeof(Image), true)
			end

			local var_434_9 = 2

			if var_434_8 <= arg_431_1.time_ and arg_431_1.time_ < var_434_8 + var_434_9 and not isNil(var_434_7) then
				local var_434_10 = (arg_431_1.time_ - var_434_8) / var_434_9

				if arg_431_1.var_.actorSpriteComps10092_1 then
					for iter_434_1, iter_434_2 in pairs(arg_431_1.var_.actorSpriteComps10092_1:ToTable()) do
						if iter_434_2 then
							if arg_431_1.isInRecall_ then
								local var_434_11 = Mathf.Lerp(iter_434_2.color.r, arg_431_1.hightColor1.r, var_434_10)
								local var_434_12 = Mathf.Lerp(iter_434_2.color.g, arg_431_1.hightColor1.g, var_434_10)
								local var_434_13 = Mathf.Lerp(iter_434_2.color.b, arg_431_1.hightColor1.b, var_434_10)

								iter_434_2.color = Color.New(var_434_11, var_434_12, var_434_13)
							else
								local var_434_14 = Mathf.Lerp(iter_434_2.color.r, 1, var_434_10)

								iter_434_2.color = Color.New(var_434_14, var_434_14, var_434_14)
							end
						end
					end
				end
			end

			if arg_431_1.time_ >= var_434_8 + var_434_9 and arg_431_1.time_ < var_434_8 + var_434_9 + arg_434_0 and not isNil(var_434_7) and arg_431_1.var_.actorSpriteComps10092_1 then
				for iter_434_3, iter_434_4 in pairs(arg_431_1.var_.actorSpriteComps10092_1:ToTable()) do
					if iter_434_4 then
						if arg_431_1.isInRecall_ then
							iter_434_4.color = arg_431_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_434_4.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_431_1.var_.actorSpriteComps10092_1 = nil
			end

			local var_434_15 = arg_431_1.actors_["10093"]
			local var_434_16 = 0

			if var_434_16 < arg_431_1.time_ and arg_431_1.time_ <= var_434_16 + arg_434_0 and not isNil(var_434_15) and arg_431_1.var_.actorSpriteComps10093 == nil then
				arg_431_1.var_.actorSpriteComps10093 = var_434_15:GetComponentsInChildren(typeof(Image), true)
			end

			local var_434_17 = 2

			if var_434_16 <= arg_431_1.time_ and arg_431_1.time_ < var_434_16 + var_434_17 and not isNil(var_434_15) then
				local var_434_18 = (arg_431_1.time_ - var_434_16) / var_434_17

				if arg_431_1.var_.actorSpriteComps10093 then
					for iter_434_5, iter_434_6 in pairs(arg_431_1.var_.actorSpriteComps10093:ToTable()) do
						if iter_434_6 then
							if arg_431_1.isInRecall_ then
								local var_434_19 = Mathf.Lerp(iter_434_6.color.r, arg_431_1.hightColor2.r, var_434_18)
								local var_434_20 = Mathf.Lerp(iter_434_6.color.g, arg_431_1.hightColor2.g, var_434_18)
								local var_434_21 = Mathf.Lerp(iter_434_6.color.b, arg_431_1.hightColor2.b, var_434_18)

								iter_434_6.color = Color.New(var_434_19, var_434_20, var_434_21)
							else
								local var_434_22 = Mathf.Lerp(iter_434_6.color.r, 0.5, var_434_18)

								iter_434_6.color = Color.New(var_434_22, var_434_22, var_434_22)
							end
						end
					end
				end
			end

			if arg_431_1.time_ >= var_434_16 + var_434_17 and arg_431_1.time_ < var_434_16 + var_434_17 + arg_434_0 and not isNil(var_434_15) and arg_431_1.var_.actorSpriteComps10093 then
				for iter_434_7, iter_434_8 in pairs(arg_431_1.var_.actorSpriteComps10093:ToTable()) do
					if iter_434_8 then
						if arg_431_1.isInRecall_ then
							iter_434_8.color = arg_431_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_434_8.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_431_1.var_.actorSpriteComps10093 = nil
			end

			local var_434_23 = 0
			local var_434_24 = 0.5

			if var_434_23 < arg_431_1.time_ and arg_431_1.time_ <= var_434_23 + arg_434_0 then
				arg_431_1.talkMaxDuration = 0
				arg_431_1.dialogCg_.alpha = 1

				arg_431_1.dialog_:SetActive(true)
				SetActive(arg_431_1.leftNameGo_, true)

				local var_434_25 = arg_431_1:FormatText(StoryNameCfg[996].name)

				arg_431_1.leftNameTxt_.text = var_434_25

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_431_1.leftNameTxt_.transform)

				arg_431_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_431_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_431_1:RecordName(arg_431_1.leftNameTxt_.text)
				SetActive(arg_431_1.iconTrs_.gameObject, false)
				arg_431_1.callingController_:SetSelectedState("normal")

				local var_434_26 = arg_431_1:GetWordFromCfg(413141103)
				local var_434_27 = arg_431_1:FormatText(var_434_26.content)

				arg_431_1.text_.text = var_434_27

				LuaForUtil.ClearLinePrefixSymbol(arg_431_1.text_)

				local var_434_28 = 20
				local var_434_29 = utf8.len(var_434_27)
				local var_434_30 = var_434_28 <= 0 and var_434_24 or var_434_24 * (var_434_29 / var_434_28)

				if var_434_30 > 0 and var_434_24 < var_434_30 then
					arg_431_1.talkMaxDuration = var_434_30

					if var_434_30 + var_434_23 > arg_431_1.duration_ then
						arg_431_1.duration_ = var_434_30 + var_434_23
					end
				end

				arg_431_1.text_.text = var_434_27
				arg_431_1.typewritter.percent = 0

				arg_431_1.typewritter:SetDirty()
				arg_431_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_413141", "413141103", "story_v_out_413141.awb") ~= 0 then
					local var_434_31 = manager.audio:GetVoiceLength("story_v_out_413141", "413141103", "story_v_out_413141.awb") / 1000

					if var_434_31 + var_434_23 > arg_431_1.duration_ then
						arg_431_1.duration_ = var_434_31 + var_434_23
					end

					if var_434_26.prefab_name ~= "" and arg_431_1.actors_[var_434_26.prefab_name] ~= nil then
						local var_434_32 = LuaForUtil.PlayVoiceWithCriLipsync(arg_431_1.actors_[var_434_26.prefab_name].transform, "story_v_out_413141", "413141103", "story_v_out_413141.awb")

						arg_431_1:RecordAudio("413141103", var_434_32)
						arg_431_1:RecordAudio("413141103", var_434_32)
					else
						arg_431_1:AudioAction("play", "voice", "story_v_out_413141", "413141103", "story_v_out_413141.awb")
					end

					arg_431_1:RecordHistoryTalkVoice("story_v_out_413141", "413141103", "story_v_out_413141.awb")
				end

				arg_431_1:RecordContent(arg_431_1.text_.text)
			end

			local var_434_33 = math.max(var_434_24, arg_431_1.talkMaxDuration)

			if var_434_23 <= arg_431_1.time_ and arg_431_1.time_ < var_434_23 + var_434_33 then
				arg_431_1.typewritter.percent = (arg_431_1.time_ - var_434_23) / var_434_33

				arg_431_1.typewritter:SetDirty()
			end

			if arg_431_1.time_ >= var_434_23 + var_434_33 and arg_431_1.time_ < var_434_23 + var_434_33 + arg_434_0 then
				arg_431_1.typewritter.percent = 1

				arg_431_1.typewritter:SetDirty()
				arg_431_1:ShowNextGo(true)
			end
		end

		arg_431_1.nodeConfigList_ = {
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

		arg_431_1:InitPlayNodeList()
	end,
	Play413141104 = function(arg_435_0, arg_435_1)
		arg_435_1.time_ = 0
		arg_435_1.frameCnt_ = 0
		arg_435_1.state_ = "playing"
		arg_435_1.curTalkId_ = 413141104
		arg_435_1.duration_ = 2

		SetActive(arg_435_1.tipsGo_, false)

		function arg_435_1.onSingleLineFinish_()
			arg_435_1.onSingleLineUpdate_ = nil
			arg_435_1.onSingleLineFinish_ = nil
			arg_435_1.state_ = "waiting"
		end

		function arg_435_1.playNext_(arg_437_0)
			if arg_437_0 == 1 then
				arg_435_0:Play413141105(arg_435_1)
			end
		end

		function arg_435_1.onSingleLineUpdate_(arg_438_0)
			local var_438_0 = arg_435_1.actors_["10093"].transform
			local var_438_1 = 0

			if var_438_1 < arg_435_1.time_ and arg_435_1.time_ <= var_438_1 + arg_438_0 then
				arg_435_1.var_.moveOldPos10093 = var_438_0.localPosition
				var_438_0.localScale = Vector3.New(1, 1, 1)

				arg_435_1:CheckSpriteTmpPos("10093", 4)

				local var_438_2 = var_438_0.childCount

				for iter_438_0 = 0, var_438_2 - 1 do
					local var_438_3 = var_438_0:GetChild(iter_438_0)

					if var_438_3.name == "split_4" or not string.find(var_438_3.name, "split") then
						var_438_3.gameObject:SetActive(true)
					else
						var_438_3.gameObject:SetActive(false)
					end
				end
			end

			local var_438_4 = 0.001

			if var_438_1 <= arg_435_1.time_ and arg_435_1.time_ < var_438_1 + var_438_4 then
				local var_438_5 = (arg_435_1.time_ - var_438_1) / var_438_4
				local var_438_6 = Vector3.New(390, -345, -245)

				var_438_0.localPosition = Vector3.Lerp(arg_435_1.var_.moveOldPos10093, var_438_6, var_438_5)
			end

			if arg_435_1.time_ >= var_438_1 + var_438_4 and arg_435_1.time_ < var_438_1 + var_438_4 + arg_438_0 then
				var_438_0.localPosition = Vector3.New(390, -345, -245)
			end

			local var_438_7 = arg_435_1.actors_["10092_1"]
			local var_438_8 = 0

			if var_438_8 < arg_435_1.time_ and arg_435_1.time_ <= var_438_8 + arg_438_0 and not isNil(var_438_7) and arg_435_1.var_.actorSpriteComps10092_1 == nil then
				arg_435_1.var_.actorSpriteComps10092_1 = var_438_7:GetComponentsInChildren(typeof(Image), true)
			end

			local var_438_9 = 2

			if var_438_8 <= arg_435_1.time_ and arg_435_1.time_ < var_438_8 + var_438_9 and not isNil(var_438_7) then
				local var_438_10 = (arg_435_1.time_ - var_438_8) / var_438_9

				if arg_435_1.var_.actorSpriteComps10092_1 then
					for iter_438_1, iter_438_2 in pairs(arg_435_1.var_.actorSpriteComps10092_1:ToTable()) do
						if iter_438_2 then
							if arg_435_1.isInRecall_ then
								local var_438_11 = Mathf.Lerp(iter_438_2.color.r, arg_435_1.hightColor2.r, var_438_10)
								local var_438_12 = Mathf.Lerp(iter_438_2.color.g, arg_435_1.hightColor2.g, var_438_10)
								local var_438_13 = Mathf.Lerp(iter_438_2.color.b, arg_435_1.hightColor2.b, var_438_10)

								iter_438_2.color = Color.New(var_438_11, var_438_12, var_438_13)
							else
								local var_438_14 = Mathf.Lerp(iter_438_2.color.r, 0.5, var_438_10)

								iter_438_2.color = Color.New(var_438_14, var_438_14, var_438_14)
							end
						end
					end
				end
			end

			if arg_435_1.time_ >= var_438_8 + var_438_9 and arg_435_1.time_ < var_438_8 + var_438_9 + arg_438_0 and not isNil(var_438_7) and arg_435_1.var_.actorSpriteComps10092_1 then
				for iter_438_3, iter_438_4 in pairs(arg_435_1.var_.actorSpriteComps10092_1:ToTable()) do
					if iter_438_4 then
						if arg_435_1.isInRecall_ then
							iter_438_4.color = arg_435_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_438_4.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_435_1.var_.actorSpriteComps10092_1 = nil
			end

			local var_438_15 = arg_435_1.actors_["10093"]
			local var_438_16 = 0

			if var_438_16 < arg_435_1.time_ and arg_435_1.time_ <= var_438_16 + arg_438_0 and not isNil(var_438_15) and arg_435_1.var_.actorSpriteComps10093 == nil then
				arg_435_1.var_.actorSpriteComps10093 = var_438_15:GetComponentsInChildren(typeof(Image), true)
			end

			local var_438_17 = 2

			if var_438_16 <= arg_435_1.time_ and arg_435_1.time_ < var_438_16 + var_438_17 and not isNil(var_438_15) then
				local var_438_18 = (arg_435_1.time_ - var_438_16) / var_438_17

				if arg_435_1.var_.actorSpriteComps10093 then
					for iter_438_5, iter_438_6 in pairs(arg_435_1.var_.actorSpriteComps10093:ToTable()) do
						if iter_438_6 then
							if arg_435_1.isInRecall_ then
								local var_438_19 = Mathf.Lerp(iter_438_6.color.r, arg_435_1.hightColor1.r, var_438_18)
								local var_438_20 = Mathf.Lerp(iter_438_6.color.g, arg_435_1.hightColor1.g, var_438_18)
								local var_438_21 = Mathf.Lerp(iter_438_6.color.b, arg_435_1.hightColor1.b, var_438_18)

								iter_438_6.color = Color.New(var_438_19, var_438_20, var_438_21)
							else
								local var_438_22 = Mathf.Lerp(iter_438_6.color.r, 1, var_438_18)

								iter_438_6.color = Color.New(var_438_22, var_438_22, var_438_22)
							end
						end
					end
				end
			end

			if arg_435_1.time_ >= var_438_16 + var_438_17 and arg_435_1.time_ < var_438_16 + var_438_17 + arg_438_0 and not isNil(var_438_15) and arg_435_1.var_.actorSpriteComps10093 then
				for iter_438_7, iter_438_8 in pairs(arg_435_1.var_.actorSpriteComps10093:ToTable()) do
					if iter_438_8 then
						if arg_435_1.isInRecall_ then
							iter_438_8.color = arg_435_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_438_8.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_435_1.var_.actorSpriteComps10093 = nil
			end

			local var_438_23 = 0
			local var_438_24 = 0.075

			if var_438_23 < arg_435_1.time_ and arg_435_1.time_ <= var_438_23 + arg_438_0 then
				arg_435_1.talkMaxDuration = 0
				arg_435_1.dialogCg_.alpha = 1

				arg_435_1.dialog_:SetActive(true)
				SetActive(arg_435_1.leftNameGo_, true)

				local var_438_25 = arg_435_1:FormatText(StoryNameCfg[28].name)

				arg_435_1.leftNameTxt_.text = var_438_25

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_435_1.leftNameTxt_.transform)

				arg_435_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_435_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_435_1:RecordName(arg_435_1.leftNameTxt_.text)
				SetActive(arg_435_1.iconTrs_.gameObject, false)
				arg_435_1.callingController_:SetSelectedState("normal")

				local var_438_26 = arg_435_1:GetWordFromCfg(413141104)
				local var_438_27 = arg_435_1:FormatText(var_438_26.content)

				arg_435_1.text_.text = var_438_27

				LuaForUtil.ClearLinePrefixSymbol(arg_435_1.text_)

				local var_438_28 = 3
				local var_438_29 = utf8.len(var_438_27)
				local var_438_30 = var_438_28 <= 0 and var_438_24 or var_438_24 * (var_438_29 / var_438_28)

				if var_438_30 > 0 and var_438_24 < var_438_30 then
					arg_435_1.talkMaxDuration = var_438_30

					if var_438_30 + var_438_23 > arg_435_1.duration_ then
						arg_435_1.duration_ = var_438_30 + var_438_23
					end
				end

				arg_435_1.text_.text = var_438_27
				arg_435_1.typewritter.percent = 0

				arg_435_1.typewritter:SetDirty()
				arg_435_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_413141", "413141104", "story_v_out_413141.awb") ~= 0 then
					local var_438_31 = manager.audio:GetVoiceLength("story_v_out_413141", "413141104", "story_v_out_413141.awb") / 1000

					if var_438_31 + var_438_23 > arg_435_1.duration_ then
						arg_435_1.duration_ = var_438_31 + var_438_23
					end

					if var_438_26.prefab_name ~= "" and arg_435_1.actors_[var_438_26.prefab_name] ~= nil then
						local var_438_32 = LuaForUtil.PlayVoiceWithCriLipsync(arg_435_1.actors_[var_438_26.prefab_name].transform, "story_v_out_413141", "413141104", "story_v_out_413141.awb")

						arg_435_1:RecordAudio("413141104", var_438_32)
						arg_435_1:RecordAudio("413141104", var_438_32)
					else
						arg_435_1:AudioAction("play", "voice", "story_v_out_413141", "413141104", "story_v_out_413141.awb")
					end

					arg_435_1:RecordHistoryTalkVoice("story_v_out_413141", "413141104", "story_v_out_413141.awb")
				end

				arg_435_1:RecordContent(arg_435_1.text_.text)
			end

			local var_438_33 = math.max(var_438_24, arg_435_1.talkMaxDuration)

			if var_438_23 <= arg_435_1.time_ and arg_435_1.time_ < var_438_23 + var_438_33 then
				arg_435_1.typewritter.percent = (arg_435_1.time_ - var_438_23) / var_438_33

				arg_435_1.typewritter:SetDirty()
			end

			if arg_435_1.time_ >= var_438_23 + var_438_33 and arg_435_1.time_ < var_438_23 + var_438_33 + arg_438_0 then
				arg_435_1.typewritter.percent = 1

				arg_435_1.typewritter:SetDirty()
				arg_435_1:ShowNextGo(true)
			end
		end

		arg_435_1.nodeConfigList_ = {
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

		arg_435_1:InitPlayNodeList()
	end,
	Play413141105 = function(arg_439_0, arg_439_1)
		arg_439_1.time_ = 0
		arg_439_1.frameCnt_ = 0
		arg_439_1.state_ = "playing"
		arg_439_1.curTalkId_ = 413141105
		arg_439_1.duration_ = 12.23

		local var_439_0 = {
			zh = 7.1,
			ja = 12.233
		}
		local var_439_1 = manager.audio:GetLocalizationFlag()

		if var_439_0[var_439_1] ~= nil then
			arg_439_1.duration_ = var_439_0[var_439_1]
		end

		SetActive(arg_439_1.tipsGo_, false)

		function arg_439_1.onSingleLineFinish_()
			arg_439_1.onSingleLineUpdate_ = nil
			arg_439_1.onSingleLineFinish_ = nil
			arg_439_1.state_ = "waiting"
		end

		function arg_439_1.playNext_(arg_441_0)
			if arg_441_0 == 1 then
				arg_439_0:Play413141106(arg_439_1)
			end
		end

		function arg_439_1.onSingleLineUpdate_(arg_442_0)
			local var_442_0 = arg_439_1.actors_["10092_1"].transform
			local var_442_1 = 0

			if var_442_1 < arg_439_1.time_ and arg_439_1.time_ <= var_442_1 + arg_442_0 then
				arg_439_1.var_.moveOldPos10092_1 = var_442_0.localPosition
				var_442_0.localScale = Vector3.New(1, 1, 1)

				arg_439_1:CheckSpriteTmpPos("10092_1", 2)

				local var_442_2 = var_442_0.childCount

				for iter_442_0 = 0, var_442_2 - 1 do
					local var_442_3 = var_442_0:GetChild(iter_442_0)

					if var_442_3.name == "split_2" or not string.find(var_442_3.name, "split") then
						var_442_3.gameObject:SetActive(true)
					else
						var_442_3.gameObject:SetActive(false)
					end
				end
			end

			local var_442_4 = 0.001

			if var_442_1 <= arg_439_1.time_ and arg_439_1.time_ < var_442_1 + var_442_4 then
				local var_442_5 = (arg_439_1.time_ - var_442_1) / var_442_4
				local var_442_6 = Vector3.New(-389.49, -300, -295)

				var_442_0.localPosition = Vector3.Lerp(arg_439_1.var_.moveOldPos10092_1, var_442_6, var_442_5)
			end

			if arg_439_1.time_ >= var_442_1 + var_442_4 and arg_439_1.time_ < var_442_1 + var_442_4 + arg_442_0 then
				var_442_0.localPosition = Vector3.New(-389.49, -300, -295)
			end

			local var_442_7 = arg_439_1.actors_["10092_1"]
			local var_442_8 = 0

			if var_442_8 < arg_439_1.time_ and arg_439_1.time_ <= var_442_8 + arg_442_0 and not isNil(var_442_7) and arg_439_1.var_.actorSpriteComps10092_1 == nil then
				arg_439_1.var_.actorSpriteComps10092_1 = var_442_7:GetComponentsInChildren(typeof(Image), true)
			end

			local var_442_9 = 2

			if var_442_8 <= arg_439_1.time_ and arg_439_1.time_ < var_442_8 + var_442_9 and not isNil(var_442_7) then
				local var_442_10 = (arg_439_1.time_ - var_442_8) / var_442_9

				if arg_439_1.var_.actorSpriteComps10092_1 then
					for iter_442_1, iter_442_2 in pairs(arg_439_1.var_.actorSpriteComps10092_1:ToTable()) do
						if iter_442_2 then
							if arg_439_1.isInRecall_ then
								local var_442_11 = Mathf.Lerp(iter_442_2.color.r, arg_439_1.hightColor1.r, var_442_10)
								local var_442_12 = Mathf.Lerp(iter_442_2.color.g, arg_439_1.hightColor1.g, var_442_10)
								local var_442_13 = Mathf.Lerp(iter_442_2.color.b, arg_439_1.hightColor1.b, var_442_10)

								iter_442_2.color = Color.New(var_442_11, var_442_12, var_442_13)
							else
								local var_442_14 = Mathf.Lerp(iter_442_2.color.r, 1, var_442_10)

								iter_442_2.color = Color.New(var_442_14, var_442_14, var_442_14)
							end
						end
					end
				end
			end

			if arg_439_1.time_ >= var_442_8 + var_442_9 and arg_439_1.time_ < var_442_8 + var_442_9 + arg_442_0 and not isNil(var_442_7) and arg_439_1.var_.actorSpriteComps10092_1 then
				for iter_442_3, iter_442_4 in pairs(arg_439_1.var_.actorSpriteComps10092_1:ToTable()) do
					if iter_442_4 then
						if arg_439_1.isInRecall_ then
							iter_442_4.color = arg_439_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_442_4.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_439_1.var_.actorSpriteComps10092_1 = nil
			end

			local var_442_15 = arg_439_1.actors_["10093"]
			local var_442_16 = 0

			if var_442_16 < arg_439_1.time_ and arg_439_1.time_ <= var_442_16 + arg_442_0 and not isNil(var_442_15) and arg_439_1.var_.actorSpriteComps10093 == nil then
				arg_439_1.var_.actorSpriteComps10093 = var_442_15:GetComponentsInChildren(typeof(Image), true)
			end

			local var_442_17 = 2

			if var_442_16 <= arg_439_1.time_ and arg_439_1.time_ < var_442_16 + var_442_17 and not isNil(var_442_15) then
				local var_442_18 = (arg_439_1.time_ - var_442_16) / var_442_17

				if arg_439_1.var_.actorSpriteComps10093 then
					for iter_442_5, iter_442_6 in pairs(arg_439_1.var_.actorSpriteComps10093:ToTable()) do
						if iter_442_6 then
							if arg_439_1.isInRecall_ then
								local var_442_19 = Mathf.Lerp(iter_442_6.color.r, arg_439_1.hightColor2.r, var_442_18)
								local var_442_20 = Mathf.Lerp(iter_442_6.color.g, arg_439_1.hightColor2.g, var_442_18)
								local var_442_21 = Mathf.Lerp(iter_442_6.color.b, arg_439_1.hightColor2.b, var_442_18)

								iter_442_6.color = Color.New(var_442_19, var_442_20, var_442_21)
							else
								local var_442_22 = Mathf.Lerp(iter_442_6.color.r, 0.5, var_442_18)

								iter_442_6.color = Color.New(var_442_22, var_442_22, var_442_22)
							end
						end
					end
				end
			end

			if arg_439_1.time_ >= var_442_16 + var_442_17 and arg_439_1.time_ < var_442_16 + var_442_17 + arg_442_0 and not isNil(var_442_15) and arg_439_1.var_.actorSpriteComps10093 then
				for iter_442_7, iter_442_8 in pairs(arg_439_1.var_.actorSpriteComps10093:ToTable()) do
					if iter_442_8 then
						if arg_439_1.isInRecall_ then
							iter_442_8.color = arg_439_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_442_8.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_439_1.var_.actorSpriteComps10093 = nil
			end

			local var_442_23 = 0
			local var_442_24 = 0.95

			if var_442_23 < arg_439_1.time_ and arg_439_1.time_ <= var_442_23 + arg_442_0 then
				arg_439_1.talkMaxDuration = 0
				arg_439_1.dialogCg_.alpha = 1

				arg_439_1.dialog_:SetActive(true)
				SetActive(arg_439_1.leftNameGo_, true)

				local var_442_25 = arg_439_1:FormatText(StoryNameCfg[996].name)

				arg_439_1.leftNameTxt_.text = var_442_25

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_439_1.leftNameTxt_.transform)

				arg_439_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_439_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_439_1:RecordName(arg_439_1.leftNameTxt_.text)
				SetActive(arg_439_1.iconTrs_.gameObject, false)
				arg_439_1.callingController_:SetSelectedState("normal")

				local var_442_26 = arg_439_1:GetWordFromCfg(413141105)
				local var_442_27 = arg_439_1:FormatText(var_442_26.content)

				arg_439_1.text_.text = var_442_27

				LuaForUtil.ClearLinePrefixSymbol(arg_439_1.text_)

				local var_442_28 = 38
				local var_442_29 = utf8.len(var_442_27)
				local var_442_30 = var_442_28 <= 0 and var_442_24 or var_442_24 * (var_442_29 / var_442_28)

				if var_442_30 > 0 and var_442_24 < var_442_30 then
					arg_439_1.talkMaxDuration = var_442_30

					if var_442_30 + var_442_23 > arg_439_1.duration_ then
						arg_439_1.duration_ = var_442_30 + var_442_23
					end
				end

				arg_439_1.text_.text = var_442_27
				arg_439_1.typewritter.percent = 0

				arg_439_1.typewritter:SetDirty()
				arg_439_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_413141", "413141105", "story_v_out_413141.awb") ~= 0 then
					local var_442_31 = manager.audio:GetVoiceLength("story_v_out_413141", "413141105", "story_v_out_413141.awb") / 1000

					if var_442_31 + var_442_23 > arg_439_1.duration_ then
						arg_439_1.duration_ = var_442_31 + var_442_23
					end

					if var_442_26.prefab_name ~= "" and arg_439_1.actors_[var_442_26.prefab_name] ~= nil then
						local var_442_32 = LuaForUtil.PlayVoiceWithCriLipsync(arg_439_1.actors_[var_442_26.prefab_name].transform, "story_v_out_413141", "413141105", "story_v_out_413141.awb")

						arg_439_1:RecordAudio("413141105", var_442_32)
						arg_439_1:RecordAudio("413141105", var_442_32)
					else
						arg_439_1:AudioAction("play", "voice", "story_v_out_413141", "413141105", "story_v_out_413141.awb")
					end

					arg_439_1:RecordHistoryTalkVoice("story_v_out_413141", "413141105", "story_v_out_413141.awb")
				end

				arg_439_1:RecordContent(arg_439_1.text_.text)
			end

			local var_442_33 = math.max(var_442_24, arg_439_1.talkMaxDuration)

			if var_442_23 <= arg_439_1.time_ and arg_439_1.time_ < var_442_23 + var_442_33 then
				arg_439_1.typewritter.percent = (arg_439_1.time_ - var_442_23) / var_442_33

				arg_439_1.typewritter:SetDirty()
			end

			if arg_439_1.time_ >= var_442_23 + var_442_33 and arg_439_1.time_ < var_442_23 + var_442_33 + arg_442_0 then
				arg_439_1.typewritter.percent = 1

				arg_439_1.typewritter:SetDirty()
				arg_439_1:ShowNextGo(true)
			end
		end

		arg_439_1.nodeConfigList_ = {
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

		arg_439_1:InitPlayNodeList()
	end,
	Play413141106 = function(arg_443_0, arg_443_1)
		arg_443_1.time_ = 0
		arg_443_1.frameCnt_ = 0
		arg_443_1.state_ = "playing"
		arg_443_1.curTalkId_ = 413141106
		arg_443_1.duration_ = 4.57

		local var_443_0 = {
			zh = 4.566,
			ja = 4.233
		}
		local var_443_1 = manager.audio:GetLocalizationFlag()

		if var_443_0[var_443_1] ~= nil then
			arg_443_1.duration_ = var_443_0[var_443_1]
		end

		SetActive(arg_443_1.tipsGo_, false)

		function arg_443_1.onSingleLineFinish_()
			arg_443_1.onSingleLineUpdate_ = nil
			arg_443_1.onSingleLineFinish_ = nil
			arg_443_1.state_ = "waiting"
		end

		function arg_443_1.playNext_(arg_445_0)
			if arg_445_0 == 1 then
				arg_443_0:Play413141107(arg_443_1)
			end
		end

		function arg_443_1.onSingleLineUpdate_(arg_446_0)
			local var_446_0 = arg_443_1.actors_["10093"].transform
			local var_446_1 = 0

			if var_446_1 < arg_443_1.time_ and arg_443_1.time_ <= var_446_1 + arg_446_0 then
				arg_443_1.var_.moveOldPos10093 = var_446_0.localPosition
				var_446_0.localScale = Vector3.New(1, 1, 1)

				arg_443_1:CheckSpriteTmpPos("10093", 4)

				local var_446_2 = var_446_0.childCount

				for iter_446_0 = 0, var_446_2 - 1 do
					local var_446_3 = var_446_0:GetChild(iter_446_0)

					if var_446_3.name == "split_4" or not string.find(var_446_3.name, "split") then
						var_446_3.gameObject:SetActive(true)
					else
						var_446_3.gameObject:SetActive(false)
					end
				end
			end

			local var_446_4 = 0.001

			if var_446_1 <= arg_443_1.time_ and arg_443_1.time_ < var_446_1 + var_446_4 then
				local var_446_5 = (arg_443_1.time_ - var_446_1) / var_446_4
				local var_446_6 = Vector3.New(390, -345, -245)

				var_446_0.localPosition = Vector3.Lerp(arg_443_1.var_.moveOldPos10093, var_446_6, var_446_5)
			end

			if arg_443_1.time_ >= var_446_1 + var_446_4 and arg_443_1.time_ < var_446_1 + var_446_4 + arg_446_0 then
				var_446_0.localPosition = Vector3.New(390, -345, -245)
			end

			local var_446_7 = arg_443_1.actors_["10092_1"]
			local var_446_8 = 0

			if var_446_8 < arg_443_1.time_ and arg_443_1.time_ <= var_446_8 + arg_446_0 and not isNil(var_446_7) and arg_443_1.var_.actorSpriteComps10092_1 == nil then
				arg_443_1.var_.actorSpriteComps10092_1 = var_446_7:GetComponentsInChildren(typeof(Image), true)
			end

			local var_446_9 = 2

			if var_446_8 <= arg_443_1.time_ and arg_443_1.time_ < var_446_8 + var_446_9 and not isNil(var_446_7) then
				local var_446_10 = (arg_443_1.time_ - var_446_8) / var_446_9

				if arg_443_1.var_.actorSpriteComps10092_1 then
					for iter_446_1, iter_446_2 in pairs(arg_443_1.var_.actorSpriteComps10092_1:ToTable()) do
						if iter_446_2 then
							if arg_443_1.isInRecall_ then
								local var_446_11 = Mathf.Lerp(iter_446_2.color.r, arg_443_1.hightColor2.r, var_446_10)
								local var_446_12 = Mathf.Lerp(iter_446_2.color.g, arg_443_1.hightColor2.g, var_446_10)
								local var_446_13 = Mathf.Lerp(iter_446_2.color.b, arg_443_1.hightColor2.b, var_446_10)

								iter_446_2.color = Color.New(var_446_11, var_446_12, var_446_13)
							else
								local var_446_14 = Mathf.Lerp(iter_446_2.color.r, 0.5, var_446_10)

								iter_446_2.color = Color.New(var_446_14, var_446_14, var_446_14)
							end
						end
					end
				end
			end

			if arg_443_1.time_ >= var_446_8 + var_446_9 and arg_443_1.time_ < var_446_8 + var_446_9 + arg_446_0 and not isNil(var_446_7) and arg_443_1.var_.actorSpriteComps10092_1 then
				for iter_446_3, iter_446_4 in pairs(arg_443_1.var_.actorSpriteComps10092_1:ToTable()) do
					if iter_446_4 then
						if arg_443_1.isInRecall_ then
							iter_446_4.color = arg_443_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_446_4.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_443_1.var_.actorSpriteComps10092_1 = nil
			end

			local var_446_15 = arg_443_1.actors_["10093"]
			local var_446_16 = 0

			if var_446_16 < arg_443_1.time_ and arg_443_1.time_ <= var_446_16 + arg_446_0 and not isNil(var_446_15) and arg_443_1.var_.actorSpriteComps10093 == nil then
				arg_443_1.var_.actorSpriteComps10093 = var_446_15:GetComponentsInChildren(typeof(Image), true)
			end

			local var_446_17 = 2

			if var_446_16 <= arg_443_1.time_ and arg_443_1.time_ < var_446_16 + var_446_17 and not isNil(var_446_15) then
				local var_446_18 = (arg_443_1.time_ - var_446_16) / var_446_17

				if arg_443_1.var_.actorSpriteComps10093 then
					for iter_446_5, iter_446_6 in pairs(arg_443_1.var_.actorSpriteComps10093:ToTable()) do
						if iter_446_6 then
							if arg_443_1.isInRecall_ then
								local var_446_19 = Mathf.Lerp(iter_446_6.color.r, arg_443_1.hightColor1.r, var_446_18)
								local var_446_20 = Mathf.Lerp(iter_446_6.color.g, arg_443_1.hightColor1.g, var_446_18)
								local var_446_21 = Mathf.Lerp(iter_446_6.color.b, arg_443_1.hightColor1.b, var_446_18)

								iter_446_6.color = Color.New(var_446_19, var_446_20, var_446_21)
							else
								local var_446_22 = Mathf.Lerp(iter_446_6.color.r, 1, var_446_18)

								iter_446_6.color = Color.New(var_446_22, var_446_22, var_446_22)
							end
						end
					end
				end
			end

			if arg_443_1.time_ >= var_446_16 + var_446_17 and arg_443_1.time_ < var_446_16 + var_446_17 + arg_446_0 and not isNil(var_446_15) and arg_443_1.var_.actorSpriteComps10093 then
				for iter_446_7, iter_446_8 in pairs(arg_443_1.var_.actorSpriteComps10093:ToTable()) do
					if iter_446_8 then
						if arg_443_1.isInRecall_ then
							iter_446_8.color = arg_443_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_446_8.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_443_1.var_.actorSpriteComps10093 = nil
			end

			local var_446_23 = 0
			local var_446_24 = 0.425

			if var_446_23 < arg_443_1.time_ and arg_443_1.time_ <= var_446_23 + arg_446_0 then
				arg_443_1.talkMaxDuration = 0
				arg_443_1.dialogCg_.alpha = 1

				arg_443_1.dialog_:SetActive(true)
				SetActive(arg_443_1.leftNameGo_, true)

				local var_446_25 = arg_443_1:FormatText(StoryNameCfg[28].name)

				arg_443_1.leftNameTxt_.text = var_446_25

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_443_1.leftNameTxt_.transform)

				arg_443_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_443_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_443_1:RecordName(arg_443_1.leftNameTxt_.text)
				SetActive(arg_443_1.iconTrs_.gameObject, false)
				arg_443_1.callingController_:SetSelectedState("normal")

				local var_446_26 = arg_443_1:GetWordFromCfg(413141106)
				local var_446_27 = arg_443_1:FormatText(var_446_26.content)

				arg_443_1.text_.text = var_446_27

				LuaForUtil.ClearLinePrefixSymbol(arg_443_1.text_)

				local var_446_28 = 17
				local var_446_29 = utf8.len(var_446_27)
				local var_446_30 = var_446_28 <= 0 and var_446_24 or var_446_24 * (var_446_29 / var_446_28)

				if var_446_30 > 0 and var_446_24 < var_446_30 then
					arg_443_1.talkMaxDuration = var_446_30

					if var_446_30 + var_446_23 > arg_443_1.duration_ then
						arg_443_1.duration_ = var_446_30 + var_446_23
					end
				end

				arg_443_1.text_.text = var_446_27
				arg_443_1.typewritter.percent = 0

				arg_443_1.typewritter:SetDirty()
				arg_443_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_413141", "413141106", "story_v_out_413141.awb") ~= 0 then
					local var_446_31 = manager.audio:GetVoiceLength("story_v_out_413141", "413141106", "story_v_out_413141.awb") / 1000

					if var_446_31 + var_446_23 > arg_443_1.duration_ then
						arg_443_1.duration_ = var_446_31 + var_446_23
					end

					if var_446_26.prefab_name ~= "" and arg_443_1.actors_[var_446_26.prefab_name] ~= nil then
						local var_446_32 = LuaForUtil.PlayVoiceWithCriLipsync(arg_443_1.actors_[var_446_26.prefab_name].transform, "story_v_out_413141", "413141106", "story_v_out_413141.awb")

						arg_443_1:RecordAudio("413141106", var_446_32)
						arg_443_1:RecordAudio("413141106", var_446_32)
					else
						arg_443_1:AudioAction("play", "voice", "story_v_out_413141", "413141106", "story_v_out_413141.awb")
					end

					arg_443_1:RecordHistoryTalkVoice("story_v_out_413141", "413141106", "story_v_out_413141.awb")
				end

				arg_443_1:RecordContent(arg_443_1.text_.text)
			end

			local var_446_33 = math.max(var_446_24, arg_443_1.talkMaxDuration)

			if var_446_23 <= arg_443_1.time_ and arg_443_1.time_ < var_446_23 + var_446_33 then
				arg_443_1.typewritter.percent = (arg_443_1.time_ - var_446_23) / var_446_33

				arg_443_1.typewritter:SetDirty()
			end

			if arg_443_1.time_ >= var_446_23 + var_446_33 and arg_443_1.time_ < var_446_23 + var_446_33 + arg_446_0 then
				arg_443_1.typewritter.percent = 1

				arg_443_1.typewritter:SetDirty()
				arg_443_1:ShowNextGo(true)
			end
		end

		arg_443_1.nodeConfigList_ = {
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

		arg_443_1:InitPlayNodeList()
	end,
	Play413141107 = function(arg_447_0, arg_447_1)
		arg_447_1.time_ = 0
		arg_447_1.frameCnt_ = 0
		arg_447_1.state_ = "playing"
		arg_447_1.curTalkId_ = 413141107
		arg_447_1.duration_ = 5

		SetActive(arg_447_1.tipsGo_, false)

		function arg_447_1.onSingleLineFinish_()
			arg_447_1.onSingleLineUpdate_ = nil
			arg_447_1.onSingleLineFinish_ = nil
			arg_447_1.state_ = "waiting"
		end

		function arg_447_1.playNext_(arg_449_0)
			if arg_449_0 == 1 then
				arg_447_0:Play413141108(arg_447_1)
			end
		end

		function arg_447_1.onSingleLineUpdate_(arg_450_0)
			local var_450_0 = arg_447_1.actors_["10093"].transform
			local var_450_1 = 0

			if var_450_1 < arg_447_1.time_ and arg_447_1.time_ <= var_450_1 + arg_450_0 then
				arg_447_1.var_.moveOldPos10093 = var_450_0.localPosition
				var_450_0.localScale = Vector3.New(1, 1, 1)

				arg_447_1:CheckSpriteTmpPos("10093", 7)

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
				local var_450_6 = Vector3.New(0, -2000, 0)

				var_450_0.localPosition = Vector3.Lerp(arg_447_1.var_.moveOldPos10093, var_450_6, var_450_5)
			end

			if arg_447_1.time_ >= var_450_1 + var_450_4 and arg_447_1.time_ < var_450_1 + var_450_4 + arg_450_0 then
				var_450_0.localPosition = Vector3.New(0, -2000, 0)
			end

			local var_450_7 = arg_447_1.actors_["10092_1"].transform
			local var_450_8 = 0

			if var_450_8 < arg_447_1.time_ and arg_447_1.time_ <= var_450_8 + arg_450_0 then
				arg_447_1.var_.moveOldPos10092_1 = var_450_7.localPosition
				var_450_7.localScale = Vector3.New(1, 1, 1)

				arg_447_1:CheckSpriteTmpPos("10092_1", 7)

				local var_450_9 = var_450_7.childCount

				for iter_450_1 = 0, var_450_9 - 1 do
					local var_450_10 = var_450_7:GetChild(iter_450_1)

					if var_450_10.name == "split_2" or not string.find(var_450_10.name, "split") then
						var_450_10.gameObject:SetActive(true)
					else
						var_450_10.gameObject:SetActive(false)
					end
				end
			end

			local var_450_11 = 0.001

			if var_450_8 <= arg_447_1.time_ and arg_447_1.time_ < var_450_8 + var_450_11 then
				local var_450_12 = (arg_447_1.time_ - var_450_8) / var_450_11
				local var_450_13 = Vector3.New(0, -2000, 0)

				var_450_7.localPosition = Vector3.Lerp(arg_447_1.var_.moveOldPos10092_1, var_450_13, var_450_12)
			end

			if arg_447_1.time_ >= var_450_8 + var_450_11 and arg_447_1.time_ < var_450_8 + var_450_11 + arg_450_0 then
				var_450_7.localPosition = Vector3.New(0, -2000, 0)
			end

			local var_450_14 = 0
			local var_450_15 = 1.05

			if var_450_14 < arg_447_1.time_ and arg_447_1.time_ <= var_450_14 + arg_450_0 then
				arg_447_1.talkMaxDuration = 0
				arg_447_1.dialogCg_.alpha = 1

				arg_447_1.dialog_:SetActive(true)
				SetActive(arg_447_1.leftNameGo_, false)

				arg_447_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_447_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_447_1:RecordName(arg_447_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_447_1.iconTrs_.gameObject, false)
				arg_447_1.callingController_:SetSelectedState("normal")

				local var_450_16 = arg_447_1:GetWordFromCfg(413141107)
				local var_450_17 = arg_447_1:FormatText(var_450_16.content)

				arg_447_1.text_.text = var_450_17

				LuaForUtil.ClearLinePrefixSymbol(arg_447_1.text_)

				local var_450_18 = 42
				local var_450_19 = utf8.len(var_450_17)
				local var_450_20 = var_450_18 <= 0 and var_450_15 or var_450_15 * (var_450_19 / var_450_18)

				if var_450_20 > 0 and var_450_15 < var_450_20 then
					arg_447_1.talkMaxDuration = var_450_20

					if var_450_20 + var_450_14 > arg_447_1.duration_ then
						arg_447_1.duration_ = var_450_20 + var_450_14
					end
				end

				arg_447_1.text_.text = var_450_17
				arg_447_1.typewritter.percent = 0

				arg_447_1.typewritter:SetDirty()
				arg_447_1:ShowNextGo(false)
				arg_447_1:RecordContent(arg_447_1.text_.text)
			end

			local var_450_21 = math.max(var_450_15, arg_447_1.talkMaxDuration)

			if var_450_14 <= arg_447_1.time_ and arg_447_1.time_ < var_450_14 + var_450_21 then
				arg_447_1.typewritter.percent = (arg_447_1.time_ - var_450_14) / var_450_21

				arg_447_1.typewritter:SetDirty()
			end

			if arg_447_1.time_ >= var_450_14 + var_450_21 and arg_447_1.time_ < var_450_14 + var_450_21 + arg_450_0 then
				arg_447_1.typewritter.percent = 1

				arg_447_1.typewritter:SetDirty()
				arg_447_1:ShowNextGo(true)
			end
		end

		arg_447_1.nodeConfigList_ = {
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

		arg_447_1:InitPlayNodeList()
	end,
	Play413141108 = function(arg_451_0, arg_451_1)
		arg_451_1.time_ = 0
		arg_451_1.frameCnt_ = 0
		arg_451_1.state_ = "playing"
		arg_451_1.curTalkId_ = 413141108
		arg_451_1.duration_ = 7.8

		local var_451_0 = {
			zh = 5.333,
			ja = 7.8
		}
		local var_451_1 = manager.audio:GetLocalizationFlag()

		if var_451_0[var_451_1] ~= nil then
			arg_451_1.duration_ = var_451_0[var_451_1]
		end

		SetActive(arg_451_1.tipsGo_, false)

		function arg_451_1.onSingleLineFinish_()
			arg_451_1.onSingleLineUpdate_ = nil
			arg_451_1.onSingleLineFinish_ = nil
			arg_451_1.state_ = "waiting"
		end

		function arg_451_1.playNext_(arg_453_0)
			if arg_453_0 == 1 then
				arg_451_0:Play413141109(arg_451_1)
			end
		end

		function arg_451_1.onSingleLineUpdate_(arg_454_0)
			local var_454_0 = arg_451_1.actors_["10092_1"].transform
			local var_454_1 = 0

			if var_454_1 < arg_451_1.time_ and arg_451_1.time_ <= var_454_1 + arg_454_0 then
				arg_451_1.var_.moveOldPos10092_1 = var_454_0.localPosition
				var_454_0.localScale = Vector3.New(1, 1, 1)

				arg_451_1:CheckSpriteTmpPos("10092_1", 2)

				local var_454_2 = var_454_0.childCount

				for iter_454_0 = 0, var_454_2 - 1 do
					local var_454_3 = var_454_0:GetChild(iter_454_0)

					if var_454_3.name == "split_1_1" or not string.find(var_454_3.name, "split") then
						var_454_3.gameObject:SetActive(true)
					else
						var_454_3.gameObject:SetActive(false)
					end
				end
			end

			local var_454_4 = 0.001

			if var_454_1 <= arg_451_1.time_ and arg_451_1.time_ < var_454_1 + var_454_4 then
				local var_454_5 = (arg_451_1.time_ - var_454_1) / var_454_4
				local var_454_6 = Vector3.New(-389.49, -300, -295)

				var_454_0.localPosition = Vector3.Lerp(arg_451_1.var_.moveOldPos10092_1, var_454_6, var_454_5)
			end

			if arg_451_1.time_ >= var_454_1 + var_454_4 and arg_451_1.time_ < var_454_1 + var_454_4 + arg_454_0 then
				var_454_0.localPosition = Vector3.New(-389.49, -300, -295)
			end

			local var_454_7 = arg_451_1.actors_["10092_1"]
			local var_454_8 = 0

			if var_454_8 < arg_451_1.time_ and arg_451_1.time_ <= var_454_8 + arg_454_0 and not isNil(var_454_7) and arg_451_1.var_.actorSpriteComps10092_1 == nil then
				arg_451_1.var_.actorSpriteComps10092_1 = var_454_7:GetComponentsInChildren(typeof(Image), true)
			end

			local var_454_9 = 2

			if var_454_8 <= arg_451_1.time_ and arg_451_1.time_ < var_454_8 + var_454_9 and not isNil(var_454_7) then
				local var_454_10 = (arg_451_1.time_ - var_454_8) / var_454_9

				if arg_451_1.var_.actorSpriteComps10092_1 then
					for iter_454_1, iter_454_2 in pairs(arg_451_1.var_.actorSpriteComps10092_1:ToTable()) do
						if iter_454_2 then
							if arg_451_1.isInRecall_ then
								local var_454_11 = Mathf.Lerp(iter_454_2.color.r, arg_451_1.hightColor1.r, var_454_10)
								local var_454_12 = Mathf.Lerp(iter_454_2.color.g, arg_451_1.hightColor1.g, var_454_10)
								local var_454_13 = Mathf.Lerp(iter_454_2.color.b, arg_451_1.hightColor1.b, var_454_10)

								iter_454_2.color = Color.New(var_454_11, var_454_12, var_454_13)
							else
								local var_454_14 = Mathf.Lerp(iter_454_2.color.r, 1, var_454_10)

								iter_454_2.color = Color.New(var_454_14, var_454_14, var_454_14)
							end
						end
					end
				end
			end

			if arg_451_1.time_ >= var_454_8 + var_454_9 and arg_451_1.time_ < var_454_8 + var_454_9 + arg_454_0 and not isNil(var_454_7) and arg_451_1.var_.actorSpriteComps10092_1 then
				for iter_454_3, iter_454_4 in pairs(arg_451_1.var_.actorSpriteComps10092_1:ToTable()) do
					if iter_454_4 then
						if arg_451_1.isInRecall_ then
							iter_454_4.color = arg_451_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_454_4.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_451_1.var_.actorSpriteComps10092_1 = nil
			end

			local var_454_15 = 0
			local var_454_16 = 0.7

			if var_454_15 < arg_451_1.time_ and arg_451_1.time_ <= var_454_15 + arg_454_0 then
				arg_451_1.talkMaxDuration = 0
				arg_451_1.dialogCg_.alpha = 1

				arg_451_1.dialog_:SetActive(true)
				SetActive(arg_451_1.leftNameGo_, true)

				local var_454_17 = arg_451_1:FormatText(StoryNameCfg[996].name)

				arg_451_1.leftNameTxt_.text = var_454_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_451_1.leftNameTxt_.transform)

				arg_451_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_451_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_451_1:RecordName(arg_451_1.leftNameTxt_.text)
				SetActive(arg_451_1.iconTrs_.gameObject, false)
				arg_451_1.callingController_:SetSelectedState("normal")

				local var_454_18 = arg_451_1:GetWordFromCfg(413141108)
				local var_454_19 = arg_451_1:FormatText(var_454_18.content)

				arg_451_1.text_.text = var_454_19

				LuaForUtil.ClearLinePrefixSymbol(arg_451_1.text_)

				local var_454_20 = 28
				local var_454_21 = utf8.len(var_454_19)
				local var_454_22 = var_454_20 <= 0 and var_454_16 or var_454_16 * (var_454_21 / var_454_20)

				if var_454_22 > 0 and var_454_16 < var_454_22 then
					arg_451_1.talkMaxDuration = var_454_22

					if var_454_22 + var_454_15 > arg_451_1.duration_ then
						arg_451_1.duration_ = var_454_22 + var_454_15
					end
				end

				arg_451_1.text_.text = var_454_19
				arg_451_1.typewritter.percent = 0

				arg_451_1.typewritter:SetDirty()
				arg_451_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_413141", "413141108", "story_v_out_413141.awb") ~= 0 then
					local var_454_23 = manager.audio:GetVoiceLength("story_v_out_413141", "413141108", "story_v_out_413141.awb") / 1000

					if var_454_23 + var_454_15 > arg_451_1.duration_ then
						arg_451_1.duration_ = var_454_23 + var_454_15
					end

					if var_454_18.prefab_name ~= "" and arg_451_1.actors_[var_454_18.prefab_name] ~= nil then
						local var_454_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_451_1.actors_[var_454_18.prefab_name].transform, "story_v_out_413141", "413141108", "story_v_out_413141.awb")

						arg_451_1:RecordAudio("413141108", var_454_24)
						arg_451_1:RecordAudio("413141108", var_454_24)
					else
						arg_451_1:AudioAction("play", "voice", "story_v_out_413141", "413141108", "story_v_out_413141.awb")
					end

					arg_451_1:RecordHistoryTalkVoice("story_v_out_413141", "413141108", "story_v_out_413141.awb")
				end

				arg_451_1:RecordContent(arg_451_1.text_.text)
			end

			local var_454_25 = math.max(var_454_16, arg_451_1.talkMaxDuration)

			if var_454_15 <= arg_451_1.time_ and arg_451_1.time_ < var_454_15 + var_454_25 then
				arg_451_1.typewritter.percent = (arg_451_1.time_ - var_454_15) / var_454_25

				arg_451_1.typewritter:SetDirty()
			end

			if arg_451_1.time_ >= var_454_15 + var_454_25 and arg_451_1.time_ < var_454_15 + var_454_25 + arg_454_0 then
				arg_451_1.typewritter.percent = 1

				arg_451_1.typewritter:SetDirty()
				arg_451_1:ShowNextGo(true)
			end
		end

		arg_451_1.nodeConfigList_ = {
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

		arg_451_1:InitPlayNodeList()
	end,
	Play413141109 = function(arg_455_0, arg_455_1)
		arg_455_1.time_ = 0
		arg_455_1.frameCnt_ = 0
		arg_455_1.state_ = "playing"
		arg_455_1.curTalkId_ = 413141109
		arg_455_1.duration_ = 5.53

		local var_455_0 = {
			zh = 3.266,
			ja = 5.533
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
				arg_455_0:Play413141110(arg_455_1)
			end
		end

		function arg_455_1.onSingleLineUpdate_(arg_458_0)
			local var_458_0 = arg_455_1.actors_["10092_1"].transform
			local var_458_1 = 0

			if var_458_1 < arg_455_1.time_ and arg_455_1.time_ <= var_458_1 + arg_458_0 then
				arg_455_1.var_.moveOldPos10092_1 = var_458_0.localPosition
				var_458_0.localScale = Vector3.New(1, 1, 1)

				arg_455_1:CheckSpriteTmpPos("10092_1", 2)

				local var_458_2 = var_458_0.childCount

				for iter_458_0 = 0, var_458_2 - 1 do
					local var_458_3 = var_458_0:GetChild(iter_458_0)

					if var_458_3.name == "" or not string.find(var_458_3.name, "split") then
						var_458_3.gameObject:SetActive(true)
					else
						var_458_3.gameObject:SetActive(false)
					end
				end
			end

			local var_458_4 = 0.001

			if var_458_1 <= arg_455_1.time_ and arg_455_1.time_ < var_458_1 + var_458_4 then
				local var_458_5 = (arg_455_1.time_ - var_458_1) / var_458_4
				local var_458_6 = Vector3.New(-389.49, -300, -295)

				var_458_0.localPosition = Vector3.Lerp(arg_455_1.var_.moveOldPos10092_1, var_458_6, var_458_5)
			end

			if arg_455_1.time_ >= var_458_1 + var_458_4 and arg_455_1.time_ < var_458_1 + var_458_4 + arg_458_0 then
				var_458_0.localPosition = Vector3.New(-389.49, -300, -295)
			end

			local var_458_7 = arg_455_1.actors_["10093"].transform
			local var_458_8 = 0

			if var_458_8 < arg_455_1.time_ and arg_455_1.time_ <= var_458_8 + arg_458_0 then
				arg_455_1.var_.moveOldPos10093 = var_458_7.localPosition
				var_458_7.localScale = Vector3.New(1, 1, 1)

				arg_455_1:CheckSpriteTmpPos("10093", 4)

				local var_458_9 = var_458_7.childCount

				for iter_458_1 = 0, var_458_9 - 1 do
					local var_458_10 = var_458_7:GetChild(iter_458_1)

					if var_458_10.name == "split_3" or not string.find(var_458_10.name, "split") then
						var_458_10.gameObject:SetActive(true)
					else
						var_458_10.gameObject:SetActive(false)
					end
				end
			end

			local var_458_11 = 0.001

			if var_458_8 <= arg_455_1.time_ and arg_455_1.time_ < var_458_8 + var_458_11 then
				local var_458_12 = (arg_455_1.time_ - var_458_8) / var_458_11
				local var_458_13 = Vector3.New(390, -345, -245)

				var_458_7.localPosition = Vector3.Lerp(arg_455_1.var_.moveOldPos10093, var_458_13, var_458_12)
			end

			if arg_455_1.time_ >= var_458_8 + var_458_11 and arg_455_1.time_ < var_458_8 + var_458_11 + arg_458_0 then
				var_458_7.localPosition = Vector3.New(390, -345, -245)
			end

			local var_458_14 = arg_455_1.actors_["10092_1"]
			local var_458_15 = 0

			if var_458_15 < arg_455_1.time_ and arg_455_1.time_ <= var_458_15 + arg_458_0 and not isNil(var_458_14) and arg_455_1.var_.actorSpriteComps10092_1 == nil then
				arg_455_1.var_.actorSpriteComps10092_1 = var_458_14:GetComponentsInChildren(typeof(Image), true)
			end

			local var_458_16 = 2

			if var_458_15 <= arg_455_1.time_ and arg_455_1.time_ < var_458_15 + var_458_16 and not isNil(var_458_14) then
				local var_458_17 = (arg_455_1.time_ - var_458_15) / var_458_16

				if arg_455_1.var_.actorSpriteComps10092_1 then
					for iter_458_2, iter_458_3 in pairs(arg_455_1.var_.actorSpriteComps10092_1:ToTable()) do
						if iter_458_3 then
							if arg_455_1.isInRecall_ then
								local var_458_18 = Mathf.Lerp(iter_458_3.color.r, arg_455_1.hightColor2.r, var_458_17)
								local var_458_19 = Mathf.Lerp(iter_458_3.color.g, arg_455_1.hightColor2.g, var_458_17)
								local var_458_20 = Mathf.Lerp(iter_458_3.color.b, arg_455_1.hightColor2.b, var_458_17)

								iter_458_3.color = Color.New(var_458_18, var_458_19, var_458_20)
							else
								local var_458_21 = Mathf.Lerp(iter_458_3.color.r, 0.5, var_458_17)

								iter_458_3.color = Color.New(var_458_21, var_458_21, var_458_21)
							end
						end
					end
				end
			end

			if arg_455_1.time_ >= var_458_15 + var_458_16 and arg_455_1.time_ < var_458_15 + var_458_16 + arg_458_0 and not isNil(var_458_14) and arg_455_1.var_.actorSpriteComps10092_1 then
				for iter_458_4, iter_458_5 in pairs(arg_455_1.var_.actorSpriteComps10092_1:ToTable()) do
					if iter_458_5 then
						if arg_455_1.isInRecall_ then
							iter_458_5.color = arg_455_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_458_5.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_455_1.var_.actorSpriteComps10092_1 = nil
			end

			local var_458_22 = arg_455_1.actors_["10093"]
			local var_458_23 = 0

			if var_458_23 < arg_455_1.time_ and arg_455_1.time_ <= var_458_23 + arg_458_0 and not isNil(var_458_22) and arg_455_1.var_.actorSpriteComps10093 == nil then
				arg_455_1.var_.actorSpriteComps10093 = var_458_22:GetComponentsInChildren(typeof(Image), true)
			end

			local var_458_24 = 2

			if var_458_23 <= arg_455_1.time_ and arg_455_1.time_ < var_458_23 + var_458_24 and not isNil(var_458_22) then
				local var_458_25 = (arg_455_1.time_ - var_458_23) / var_458_24

				if arg_455_1.var_.actorSpriteComps10093 then
					for iter_458_6, iter_458_7 in pairs(arg_455_1.var_.actorSpriteComps10093:ToTable()) do
						if iter_458_7 then
							if arg_455_1.isInRecall_ then
								local var_458_26 = Mathf.Lerp(iter_458_7.color.r, arg_455_1.hightColor1.r, var_458_25)
								local var_458_27 = Mathf.Lerp(iter_458_7.color.g, arg_455_1.hightColor1.g, var_458_25)
								local var_458_28 = Mathf.Lerp(iter_458_7.color.b, arg_455_1.hightColor1.b, var_458_25)

								iter_458_7.color = Color.New(var_458_26, var_458_27, var_458_28)
							else
								local var_458_29 = Mathf.Lerp(iter_458_7.color.r, 1, var_458_25)

								iter_458_7.color = Color.New(var_458_29, var_458_29, var_458_29)
							end
						end
					end
				end
			end

			if arg_455_1.time_ >= var_458_23 + var_458_24 and arg_455_1.time_ < var_458_23 + var_458_24 + arg_458_0 and not isNil(var_458_22) and arg_455_1.var_.actorSpriteComps10093 then
				for iter_458_8, iter_458_9 in pairs(arg_455_1.var_.actorSpriteComps10093:ToTable()) do
					if iter_458_9 then
						if arg_455_1.isInRecall_ then
							iter_458_9.color = arg_455_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_458_9.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_455_1.var_.actorSpriteComps10093 = nil
			end

			local var_458_30 = 0
			local var_458_31 = 0.35

			if var_458_30 < arg_455_1.time_ and arg_455_1.time_ <= var_458_30 + arg_458_0 then
				arg_455_1.talkMaxDuration = 0
				arg_455_1.dialogCg_.alpha = 1

				arg_455_1.dialog_:SetActive(true)
				SetActive(arg_455_1.leftNameGo_, true)

				local var_458_32 = arg_455_1:FormatText(StoryNameCfg[28].name)

				arg_455_1.leftNameTxt_.text = var_458_32

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_455_1.leftNameTxt_.transform)

				arg_455_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_455_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_455_1:RecordName(arg_455_1.leftNameTxt_.text)
				SetActive(arg_455_1.iconTrs_.gameObject, false)
				arg_455_1.callingController_:SetSelectedState("normal")

				local var_458_33 = arg_455_1:GetWordFromCfg(413141109)
				local var_458_34 = arg_455_1:FormatText(var_458_33.content)

				arg_455_1.text_.text = var_458_34

				LuaForUtil.ClearLinePrefixSymbol(arg_455_1.text_)

				local var_458_35 = 14
				local var_458_36 = utf8.len(var_458_34)
				local var_458_37 = var_458_35 <= 0 and var_458_31 or var_458_31 * (var_458_36 / var_458_35)

				if var_458_37 > 0 and var_458_31 < var_458_37 then
					arg_455_1.talkMaxDuration = var_458_37

					if var_458_37 + var_458_30 > arg_455_1.duration_ then
						arg_455_1.duration_ = var_458_37 + var_458_30
					end
				end

				arg_455_1.text_.text = var_458_34
				arg_455_1.typewritter.percent = 0

				arg_455_1.typewritter:SetDirty()
				arg_455_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_413141", "413141109", "story_v_out_413141.awb") ~= 0 then
					local var_458_38 = manager.audio:GetVoiceLength("story_v_out_413141", "413141109", "story_v_out_413141.awb") / 1000

					if var_458_38 + var_458_30 > arg_455_1.duration_ then
						arg_455_1.duration_ = var_458_38 + var_458_30
					end

					if var_458_33.prefab_name ~= "" and arg_455_1.actors_[var_458_33.prefab_name] ~= nil then
						local var_458_39 = LuaForUtil.PlayVoiceWithCriLipsync(arg_455_1.actors_[var_458_33.prefab_name].transform, "story_v_out_413141", "413141109", "story_v_out_413141.awb")

						arg_455_1:RecordAudio("413141109", var_458_39)
						arg_455_1:RecordAudio("413141109", var_458_39)
					else
						arg_455_1:AudioAction("play", "voice", "story_v_out_413141", "413141109", "story_v_out_413141.awb")
					end

					arg_455_1:RecordHistoryTalkVoice("story_v_out_413141", "413141109", "story_v_out_413141.awb")
				end

				arg_455_1:RecordContent(arg_455_1.text_.text)
			end

			local var_458_40 = math.max(var_458_31, arg_455_1.talkMaxDuration)

			if var_458_30 <= arg_455_1.time_ and arg_455_1.time_ < var_458_30 + var_458_40 then
				arg_455_1.typewritter.percent = (arg_455_1.time_ - var_458_30) / var_458_40

				arg_455_1.typewritter:SetDirty()
			end

			if arg_455_1.time_ >= var_458_30 + var_458_40 and arg_455_1.time_ < var_458_30 + var_458_40 + arg_458_0 then
				arg_455_1.typewritter.percent = 1

				arg_455_1.typewritter:SetDirty()
				arg_455_1:ShowNextGo(true)
			end
		end

		arg_455_1.nodeConfigList_ = {
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

		arg_455_1:InitPlayNodeList()
	end,
	Play413141110 = function(arg_459_0, arg_459_1)
		arg_459_1.time_ = 0
		arg_459_1.frameCnt_ = 0
		arg_459_1.state_ = "playing"
		arg_459_1.curTalkId_ = 413141110
		arg_459_1.duration_ = 8.8

		SetActive(arg_459_1.tipsGo_, false)

		function arg_459_1.onSingleLineFinish_()
			arg_459_1.onSingleLineUpdate_ = nil
			arg_459_1.onSingleLineFinish_ = nil
			arg_459_1.state_ = "waiting"
		end

		function arg_459_1.playNext_(arg_461_0)
			if arg_461_0 == 1 then
				arg_459_0:Play413141111(arg_459_1)
			end
		end

		function arg_459_1.onSingleLineUpdate_(arg_462_0)
			local var_462_0 = 2

			if var_462_0 < arg_459_1.time_ and arg_459_1.time_ <= var_462_0 + arg_462_0 then
				local var_462_1 = manager.ui.mainCamera.transform.localPosition
				local var_462_2 = Vector3.New(0, 0, 10) + Vector3.New(var_462_1.x, var_462_1.y, 0)
				local var_462_3 = arg_459_1.bgs_.ST0603a

				var_462_3.transform.localPosition = var_462_2
				var_462_3.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_462_4 = var_462_3:GetComponent("SpriteRenderer")

				if var_462_4 and var_462_4.sprite then
					local var_462_5 = (var_462_3.transform.localPosition - var_462_1).z
					local var_462_6 = manager.ui.mainCameraCom_
					local var_462_7 = 2 * var_462_5 * Mathf.Tan(var_462_6.fieldOfView * 0.5 * Mathf.Deg2Rad)
					local var_462_8 = var_462_7 * var_462_6.aspect
					local var_462_9 = var_462_4.sprite.bounds.size.x
					local var_462_10 = var_462_4.sprite.bounds.size.y
					local var_462_11 = var_462_8 / var_462_9
					local var_462_12 = var_462_7 / var_462_10
					local var_462_13 = var_462_12 < var_462_11 and var_462_11 or var_462_12

					var_462_3.transform.localScale = Vector3.New(var_462_13, var_462_13, 0)
				end

				for iter_462_0, iter_462_1 in pairs(arg_459_1.bgs_) do
					if iter_462_0 ~= "ST0603a" then
						iter_462_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_462_14 = 3.8

			if var_462_14 < arg_459_1.time_ and arg_459_1.time_ <= var_462_14 + arg_462_0 then
				arg_459_1.allBtn_.enabled = false
			end

			local var_462_15 = 0.3

			if arg_459_1.time_ >= var_462_14 + var_462_15 and arg_459_1.time_ < var_462_14 + var_462_15 + arg_462_0 then
				arg_459_1.allBtn_.enabled = true
			end

			local var_462_16 = 0

			if var_462_16 < arg_459_1.time_ and arg_459_1.time_ <= var_462_16 + arg_462_0 then
				arg_459_1.mask_.enabled = true
				arg_459_1.mask_.raycastTarget = true

				arg_459_1:SetGaussion(false)
			end

			local var_462_17 = 2

			if var_462_16 <= arg_459_1.time_ and arg_459_1.time_ < var_462_16 + var_462_17 then
				local var_462_18 = (arg_459_1.time_ - var_462_16) / var_462_17
				local var_462_19 = Color.New(0, 0, 0)

				var_462_19.a = Mathf.Lerp(0, 1, var_462_18)
				arg_459_1.mask_.color = var_462_19
			end

			if arg_459_1.time_ >= var_462_16 + var_462_17 and arg_459_1.time_ < var_462_16 + var_462_17 + arg_462_0 then
				local var_462_20 = Color.New(0, 0, 0)

				var_462_20.a = 1
				arg_459_1.mask_.color = var_462_20
			end

			local var_462_21 = 2

			if var_462_21 < arg_459_1.time_ and arg_459_1.time_ <= var_462_21 + arg_462_0 then
				arg_459_1.mask_.enabled = true
				arg_459_1.mask_.raycastTarget = true

				arg_459_1:SetGaussion(false)
			end

			local var_462_22 = 2

			if var_462_21 <= arg_459_1.time_ and arg_459_1.time_ < var_462_21 + var_462_22 then
				local var_462_23 = (arg_459_1.time_ - var_462_21) / var_462_22
				local var_462_24 = Color.New(0, 0, 0)

				var_462_24.a = Mathf.Lerp(1, 0, var_462_23)
				arg_459_1.mask_.color = var_462_24
			end

			if arg_459_1.time_ >= var_462_21 + var_462_22 and arg_459_1.time_ < var_462_21 + var_462_22 + arg_462_0 then
				local var_462_25 = Color.New(0, 0, 0)
				local var_462_26 = 0

				arg_459_1.mask_.enabled = false
				var_462_25.a = var_462_26
				arg_459_1.mask_.color = var_462_25
			end

			local var_462_27 = arg_459_1.actors_["10092_1"].transform
			local var_462_28 = 2

			if var_462_28 < arg_459_1.time_ and arg_459_1.time_ <= var_462_28 + arg_462_0 then
				arg_459_1.var_.moveOldPos10092_1 = var_462_27.localPosition
				var_462_27.localScale = Vector3.New(1, 1, 1)

				arg_459_1:CheckSpriteTmpPos("10092_1", 7)

				local var_462_29 = var_462_27.childCount

				for iter_462_2 = 0, var_462_29 - 1 do
					local var_462_30 = var_462_27:GetChild(iter_462_2)

					if var_462_30.name == "" or not string.find(var_462_30.name, "split") then
						var_462_30.gameObject:SetActive(true)
					else
						var_462_30.gameObject:SetActive(false)
					end
				end
			end

			local var_462_31 = 0.001

			if var_462_28 <= arg_459_1.time_ and arg_459_1.time_ < var_462_28 + var_462_31 then
				local var_462_32 = (arg_459_1.time_ - var_462_28) / var_462_31
				local var_462_33 = Vector3.New(0, -2000, 0)

				var_462_27.localPosition = Vector3.Lerp(arg_459_1.var_.moveOldPos10092_1, var_462_33, var_462_32)
			end

			if arg_459_1.time_ >= var_462_28 + var_462_31 and arg_459_1.time_ < var_462_28 + var_462_31 + arg_462_0 then
				var_462_27.localPosition = Vector3.New(0, -2000, 0)
			end

			local var_462_34 = arg_459_1.actors_["10093"].transform
			local var_462_35 = 2

			if var_462_35 < arg_459_1.time_ and arg_459_1.time_ <= var_462_35 + arg_462_0 then
				arg_459_1.var_.moveOldPos10093 = var_462_34.localPosition
				var_462_34.localScale = Vector3.New(1, 1, 1)

				arg_459_1:CheckSpriteTmpPos("10093", 7)

				local var_462_36 = var_462_34.childCount

				for iter_462_3 = 0, var_462_36 - 1 do
					local var_462_37 = var_462_34:GetChild(iter_462_3)

					if var_462_37.name == "" or not string.find(var_462_37.name, "split") then
						var_462_37.gameObject:SetActive(true)
					else
						var_462_37.gameObject:SetActive(false)
					end
				end
			end

			local var_462_38 = 0.001

			if var_462_35 <= arg_459_1.time_ and arg_459_1.time_ < var_462_35 + var_462_38 then
				local var_462_39 = (arg_459_1.time_ - var_462_35) / var_462_38
				local var_462_40 = Vector3.New(0, -2000, 0)

				var_462_34.localPosition = Vector3.Lerp(arg_459_1.var_.moveOldPos10093, var_462_40, var_462_39)
			end

			if arg_459_1.time_ >= var_462_35 + var_462_38 and arg_459_1.time_ < var_462_35 + var_462_38 + arg_462_0 then
				var_462_34.localPosition = Vector3.New(0, -2000, 0)
			end

			if arg_459_1.frameCnt_ <= 1 then
				arg_459_1.dialog_:SetActive(false)
			end

			local var_462_41 = 3.8
			local var_462_42 = 0.65

			if var_462_41 < arg_459_1.time_ and arg_459_1.time_ <= var_462_41 + arg_462_0 then
				arg_459_1.talkMaxDuration = 0

				arg_459_1.dialog_:SetActive(true)

				arg_459_1.dialogCg_.alpha = 0

				local var_462_43 = LeanTween.value(arg_459_1.dialog_, 0, 1, 0.3)

				var_462_43:setOnUpdate(LuaHelper.FloatAction(function(arg_463_0)
					arg_459_1.dialogCg_.alpha = arg_463_0
				end))
				var_462_43:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_459_1.dialog_)
					var_462_43:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_459_1.duration_ = arg_459_1.duration_ + 0.3

				SetActive(arg_459_1.leftNameGo_, false)

				arg_459_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_459_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_459_1:RecordName(arg_459_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_459_1.iconTrs_.gameObject, false)
				arg_459_1.callingController_:SetSelectedState("normal")

				local var_462_44 = arg_459_1:GetWordFromCfg(413141110)
				local var_462_45 = arg_459_1:FormatText(var_462_44.content)

				arg_459_1.text_.text = var_462_45

				LuaForUtil.ClearLinePrefixSymbol(arg_459_1.text_)

				local var_462_46 = 26
				local var_462_47 = utf8.len(var_462_45)
				local var_462_48 = var_462_46 <= 0 and var_462_42 or var_462_42 * (var_462_47 / var_462_46)

				if var_462_48 > 0 and var_462_42 < var_462_48 then
					arg_459_1.talkMaxDuration = var_462_48
					var_462_41 = var_462_41 + 0.3

					if var_462_48 + var_462_41 > arg_459_1.duration_ then
						arg_459_1.duration_ = var_462_48 + var_462_41
					end
				end

				arg_459_1.text_.text = var_462_45
				arg_459_1.typewritter.percent = 0

				arg_459_1.typewritter:SetDirty()
				arg_459_1:ShowNextGo(false)
				arg_459_1:RecordContent(arg_459_1.text_.text)
			end

			local var_462_49 = var_462_41 + 0.3
			local var_462_50 = math.max(var_462_42, arg_459_1.talkMaxDuration)

			if var_462_49 <= arg_459_1.time_ and arg_459_1.time_ < var_462_49 + var_462_50 then
				arg_459_1.typewritter.percent = (arg_459_1.time_ - var_462_49) / var_462_50

				arg_459_1.typewritter:SetDirty()
			end

			if arg_459_1.time_ >= var_462_49 + var_462_50 and arg_459_1.time_ < var_462_49 + var_462_50 + arg_462_0 then
				arg_459_1.typewritter.percent = 1

				arg_459_1.typewritter:SetDirty()
				arg_459_1:ShowNextGo(true)
			end
		end

		arg_459_1.nodeConfigList_ = {
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
				actorName = "10093",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 2,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_459_1:InitPlayNodeList()
	end,
	Play413141111 = function(arg_465_0, arg_465_1)
		arg_465_1.time_ = 0
		arg_465_1.frameCnt_ = 0
		arg_465_1.state_ = "playing"
		arg_465_1.curTalkId_ = 413141111
		arg_465_1.duration_ = 5

		SetActive(arg_465_1.tipsGo_, false)

		function arg_465_1.onSingleLineFinish_()
			arg_465_1.onSingleLineUpdate_ = nil
			arg_465_1.onSingleLineFinish_ = nil
			arg_465_1.state_ = "waiting"
		end

		function arg_465_1.playNext_(arg_467_0)
			if arg_467_0 == 1 then
				arg_465_0:Play413141112(arg_465_1)
			end
		end

		function arg_465_1.onSingleLineUpdate_(arg_468_0)
			local var_468_0 = 0
			local var_468_1 = 1.475

			if var_468_0 < arg_465_1.time_ and arg_465_1.time_ <= var_468_0 + arg_468_0 then
				arg_465_1.talkMaxDuration = 0
				arg_465_1.dialogCg_.alpha = 1

				arg_465_1.dialog_:SetActive(true)
				SetActive(arg_465_1.leftNameGo_, false)

				arg_465_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_465_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_465_1:RecordName(arg_465_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_465_1.iconTrs_.gameObject, false)
				arg_465_1.callingController_:SetSelectedState("normal")

				local var_468_2 = arg_465_1:GetWordFromCfg(413141111)
				local var_468_3 = arg_465_1:FormatText(var_468_2.content)

				arg_465_1.text_.text = var_468_3

				LuaForUtil.ClearLinePrefixSymbol(arg_465_1.text_)

				local var_468_4 = 59
				local var_468_5 = utf8.len(var_468_3)
				local var_468_6 = var_468_4 <= 0 and var_468_1 or var_468_1 * (var_468_5 / var_468_4)

				if var_468_6 > 0 and var_468_1 < var_468_6 then
					arg_465_1.talkMaxDuration = var_468_6

					if var_468_6 + var_468_0 > arg_465_1.duration_ then
						arg_465_1.duration_ = var_468_6 + var_468_0
					end
				end

				arg_465_1.text_.text = var_468_3
				arg_465_1.typewritter.percent = 0

				arg_465_1.typewritter:SetDirty()
				arg_465_1:ShowNextGo(false)
				arg_465_1:RecordContent(arg_465_1.text_.text)
			end

			local var_468_7 = math.max(var_468_1, arg_465_1.talkMaxDuration)

			if var_468_0 <= arg_465_1.time_ and arg_465_1.time_ < var_468_0 + var_468_7 then
				arg_465_1.typewritter.percent = (arg_465_1.time_ - var_468_0) / var_468_7

				arg_465_1.typewritter:SetDirty()
			end

			if arg_465_1.time_ >= var_468_0 + var_468_7 and arg_465_1.time_ < var_468_0 + var_468_7 + arg_468_0 then
				arg_465_1.typewritter.percent = 1

				arg_465_1.typewritter:SetDirty()
				arg_465_1:ShowNextGo(true)
			end
		end

		arg_465_1.nodeConfigList_ = {}

		arg_465_1:InitPlayNodeList()
	end,
	Play413141112 = function(arg_469_0, arg_469_1)
		arg_469_1.time_ = 0
		arg_469_1.frameCnt_ = 0
		arg_469_1.state_ = "playing"
		arg_469_1.curTalkId_ = 413141112
		arg_469_1.duration_ = 5

		SetActive(arg_469_1.tipsGo_, false)

		function arg_469_1.onSingleLineFinish_()
			arg_469_1.onSingleLineUpdate_ = nil
			arg_469_1.onSingleLineFinish_ = nil
			arg_469_1.state_ = "waiting"
		end

		function arg_469_1.playNext_(arg_471_0)
			if arg_471_0 == 1 then
				arg_469_0:Play413141113(arg_469_1)
			end
		end

		function arg_469_1.onSingleLineUpdate_(arg_472_0)
			local var_472_0 = 0
			local var_472_1 = 1.125

			if var_472_0 < arg_469_1.time_ and arg_469_1.time_ <= var_472_0 + arg_472_0 then
				arg_469_1.talkMaxDuration = 0
				arg_469_1.dialogCg_.alpha = 1

				arg_469_1.dialog_:SetActive(true)
				SetActive(arg_469_1.leftNameGo_, false)

				arg_469_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_469_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_469_1:RecordName(arg_469_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_469_1.iconTrs_.gameObject, false)
				arg_469_1.callingController_:SetSelectedState("normal")

				local var_472_2 = arg_469_1:GetWordFromCfg(413141112)
				local var_472_3 = arg_469_1:FormatText(var_472_2.content)

				arg_469_1.text_.text = var_472_3

				LuaForUtil.ClearLinePrefixSymbol(arg_469_1.text_)

				local var_472_4 = 45
				local var_472_5 = utf8.len(var_472_3)
				local var_472_6 = var_472_4 <= 0 and var_472_1 or var_472_1 * (var_472_5 / var_472_4)

				if var_472_6 > 0 and var_472_1 < var_472_6 then
					arg_469_1.talkMaxDuration = var_472_6

					if var_472_6 + var_472_0 > arg_469_1.duration_ then
						arg_469_1.duration_ = var_472_6 + var_472_0
					end
				end

				arg_469_1.text_.text = var_472_3
				arg_469_1.typewritter.percent = 0

				arg_469_1.typewritter:SetDirty()
				arg_469_1:ShowNextGo(false)
				arg_469_1:RecordContent(arg_469_1.text_.text)
			end

			local var_472_7 = math.max(var_472_1, arg_469_1.talkMaxDuration)

			if var_472_0 <= arg_469_1.time_ and arg_469_1.time_ < var_472_0 + var_472_7 then
				arg_469_1.typewritter.percent = (arg_469_1.time_ - var_472_0) / var_472_7

				arg_469_1.typewritter:SetDirty()
			end

			if arg_469_1.time_ >= var_472_0 + var_472_7 and arg_469_1.time_ < var_472_0 + var_472_7 + arg_472_0 then
				arg_469_1.typewritter.percent = 1

				arg_469_1.typewritter:SetDirty()
				arg_469_1:ShowNextGo(true)
			end
		end

		arg_469_1.nodeConfigList_ = {}

		arg_469_1:InitPlayNodeList()
	end,
	Play413141113 = function(arg_473_0, arg_473_1)
		arg_473_1.time_ = 0
		arg_473_1.frameCnt_ = 0
		arg_473_1.state_ = "playing"
		arg_473_1.curTalkId_ = 413141113
		arg_473_1.duration_ = 16

		local var_473_0 = {
			zh = 8.466,
			ja = 16
		}
		local var_473_1 = manager.audio:GetLocalizationFlag()

		if var_473_0[var_473_1] ~= nil then
			arg_473_1.duration_ = var_473_0[var_473_1]
		end

		SetActive(arg_473_1.tipsGo_, false)

		function arg_473_1.onSingleLineFinish_()
			arg_473_1.onSingleLineUpdate_ = nil
			arg_473_1.onSingleLineFinish_ = nil
			arg_473_1.state_ = "waiting"
		end

		function arg_473_1.playNext_(arg_475_0)
			if arg_475_0 == 1 then
				arg_473_0:Play413141114(arg_473_1)
			end
		end

		function arg_473_1.onSingleLineUpdate_(arg_476_0)
			local var_476_0 = arg_473_1.actors_["10092_1"].transform
			local var_476_1 = 0

			if var_476_1 < arg_473_1.time_ and arg_473_1.time_ <= var_476_1 + arg_476_0 then
				arg_473_1.var_.moveOldPos10092_1 = var_476_0.localPosition
				var_476_0.localScale = Vector3.New(1, 1, 1)

				arg_473_1:CheckSpriteTmpPos("10092_1", 3)

				local var_476_2 = var_476_0.childCount

				for iter_476_0 = 0, var_476_2 - 1 do
					local var_476_3 = var_476_0:GetChild(iter_476_0)

					if var_476_3.name == "" or not string.find(var_476_3.name, "split") then
						var_476_3.gameObject:SetActive(true)
					else
						var_476_3.gameObject:SetActive(false)
					end
				end
			end

			local var_476_4 = 0.001

			if var_476_1 <= arg_473_1.time_ and arg_473_1.time_ < var_476_1 + var_476_4 then
				local var_476_5 = (arg_473_1.time_ - var_476_1) / var_476_4
				local var_476_6 = Vector3.New(0, -300, -295)

				var_476_0.localPosition = Vector3.Lerp(arg_473_1.var_.moveOldPos10092_1, var_476_6, var_476_5)
			end

			if arg_473_1.time_ >= var_476_1 + var_476_4 and arg_473_1.time_ < var_476_1 + var_476_4 + arg_476_0 then
				var_476_0.localPosition = Vector3.New(0, -300, -295)
			end

			local var_476_7 = arg_473_1.actors_["10092_1"]
			local var_476_8 = 0

			if var_476_8 < arg_473_1.time_ and arg_473_1.time_ <= var_476_8 + arg_476_0 and not isNil(var_476_7) and arg_473_1.var_.actorSpriteComps10092_1 == nil then
				arg_473_1.var_.actorSpriteComps10092_1 = var_476_7:GetComponentsInChildren(typeof(Image), true)
			end

			local var_476_9 = 2

			if var_476_8 <= arg_473_1.time_ and arg_473_1.time_ < var_476_8 + var_476_9 and not isNil(var_476_7) then
				local var_476_10 = (arg_473_1.time_ - var_476_8) / var_476_9

				if arg_473_1.var_.actorSpriteComps10092_1 then
					for iter_476_1, iter_476_2 in pairs(arg_473_1.var_.actorSpriteComps10092_1:ToTable()) do
						if iter_476_2 then
							if arg_473_1.isInRecall_ then
								local var_476_11 = Mathf.Lerp(iter_476_2.color.r, arg_473_1.hightColor1.r, var_476_10)
								local var_476_12 = Mathf.Lerp(iter_476_2.color.g, arg_473_1.hightColor1.g, var_476_10)
								local var_476_13 = Mathf.Lerp(iter_476_2.color.b, arg_473_1.hightColor1.b, var_476_10)

								iter_476_2.color = Color.New(var_476_11, var_476_12, var_476_13)
							else
								local var_476_14 = Mathf.Lerp(iter_476_2.color.r, 1, var_476_10)

								iter_476_2.color = Color.New(var_476_14, var_476_14, var_476_14)
							end
						end
					end
				end
			end

			if arg_473_1.time_ >= var_476_8 + var_476_9 and arg_473_1.time_ < var_476_8 + var_476_9 + arg_476_0 and not isNil(var_476_7) and arg_473_1.var_.actorSpriteComps10092_1 then
				for iter_476_3, iter_476_4 in pairs(arg_473_1.var_.actorSpriteComps10092_1:ToTable()) do
					if iter_476_4 then
						if arg_473_1.isInRecall_ then
							iter_476_4.color = arg_473_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_476_4.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_473_1.var_.actorSpriteComps10092_1 = nil
			end

			local var_476_15 = 0
			local var_476_16 = 0.975

			if var_476_15 < arg_473_1.time_ and arg_473_1.time_ <= var_476_15 + arg_476_0 then
				arg_473_1.talkMaxDuration = 0

				arg_473_1.dialog_:SetActive(true)

				arg_473_1.dialogCg_.alpha = 0

				local var_476_17 = LeanTween.value(arg_473_1.dialog_, 0, 1, 0.3)

				var_476_17:setOnUpdate(LuaHelper.FloatAction(function(arg_477_0)
					arg_473_1.dialogCg_.alpha = arg_477_0
				end))
				var_476_17:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_473_1.dialog_)
					var_476_17:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_473_1.duration_ = arg_473_1.duration_ + 0.3

				SetActive(arg_473_1.leftNameGo_, true)

				local var_476_18 = arg_473_1:FormatText(StoryNameCfg[996].name)

				arg_473_1.leftNameTxt_.text = var_476_18

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_473_1.leftNameTxt_.transform)

				arg_473_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_473_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_473_1:RecordName(arg_473_1.leftNameTxt_.text)
				SetActive(arg_473_1.iconTrs_.gameObject, false)
				arg_473_1.callingController_:SetSelectedState("normal")

				local var_476_19 = arg_473_1:GetWordFromCfg(413141113)
				local var_476_20 = arg_473_1:FormatText(var_476_19.content)

				arg_473_1.text_.text = var_476_20

				LuaForUtil.ClearLinePrefixSymbol(arg_473_1.text_)

				local var_476_21 = 39
				local var_476_22 = utf8.len(var_476_20)
				local var_476_23 = var_476_21 <= 0 and var_476_16 or var_476_16 * (var_476_22 / var_476_21)

				if var_476_23 > 0 and var_476_16 < var_476_23 then
					arg_473_1.talkMaxDuration = var_476_23
					var_476_15 = var_476_15 + 0.3

					if var_476_23 + var_476_15 > arg_473_1.duration_ then
						arg_473_1.duration_ = var_476_23 + var_476_15
					end
				end

				arg_473_1.text_.text = var_476_20
				arg_473_1.typewritter.percent = 0

				arg_473_1.typewritter:SetDirty()
				arg_473_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_413141", "413141113", "story_v_out_413141.awb") ~= 0 then
					local var_476_24 = manager.audio:GetVoiceLength("story_v_out_413141", "413141113", "story_v_out_413141.awb") / 1000

					if var_476_24 + var_476_15 > arg_473_1.duration_ then
						arg_473_1.duration_ = var_476_24 + var_476_15
					end

					if var_476_19.prefab_name ~= "" and arg_473_1.actors_[var_476_19.prefab_name] ~= nil then
						local var_476_25 = LuaForUtil.PlayVoiceWithCriLipsync(arg_473_1.actors_[var_476_19.prefab_name].transform, "story_v_out_413141", "413141113", "story_v_out_413141.awb")

						arg_473_1:RecordAudio("413141113", var_476_25)
						arg_473_1:RecordAudio("413141113", var_476_25)
					else
						arg_473_1:AudioAction("play", "voice", "story_v_out_413141", "413141113", "story_v_out_413141.awb")
					end

					arg_473_1:RecordHistoryTalkVoice("story_v_out_413141", "413141113", "story_v_out_413141.awb")
				end

				arg_473_1:RecordContent(arg_473_1.text_.text)
			end

			local var_476_26 = var_476_15 + 0.3
			local var_476_27 = math.max(var_476_16, arg_473_1.talkMaxDuration)

			if var_476_26 <= arg_473_1.time_ and arg_473_1.time_ < var_476_26 + var_476_27 then
				arg_473_1.typewritter.percent = (arg_473_1.time_ - var_476_26) / var_476_27

				arg_473_1.typewritter:SetDirty()
			end

			if arg_473_1.time_ >= var_476_26 + var_476_27 and arg_473_1.time_ < var_476_26 + var_476_27 + arg_476_0 then
				arg_473_1.typewritter.percent = 1

				arg_473_1.typewritter:SetDirty()
				arg_473_1:ShowNextGo(true)
			end
		end

		arg_473_1.nodeConfigList_ = {
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

		arg_473_1:InitPlayNodeList()
	end,
	Play413141114 = function(arg_479_0, arg_479_1)
		arg_479_1.time_ = 0
		arg_479_1.frameCnt_ = 0
		arg_479_1.state_ = "playing"
		arg_479_1.curTalkId_ = 413141114
		arg_479_1.duration_ = 6.4

		local var_479_0 = {
			zh = 4.3,
			ja = 6.4
		}
		local var_479_1 = manager.audio:GetLocalizationFlag()

		if var_479_0[var_479_1] ~= nil then
			arg_479_1.duration_ = var_479_0[var_479_1]
		end

		SetActive(arg_479_1.tipsGo_, false)

		function arg_479_1.onSingleLineFinish_()
			arg_479_1.onSingleLineUpdate_ = nil
			arg_479_1.onSingleLineFinish_ = nil
			arg_479_1.state_ = "waiting"
		end

		function arg_479_1.playNext_(arg_481_0)
			if arg_481_0 == 1 then
				arg_479_0:Play413141115(arg_479_1)
			end
		end

		function arg_479_1.onSingleLineUpdate_(arg_482_0)
			local var_482_0 = arg_479_1.actors_["10092_1"].transform
			local var_482_1 = 0

			if var_482_1 < arg_479_1.time_ and arg_479_1.time_ <= var_482_1 + arg_482_0 then
				arg_479_1.var_.moveOldPos10092_1 = var_482_0.localPosition
				var_482_0.localScale = Vector3.New(1, 1, 1)

				arg_479_1:CheckSpriteTmpPos("10092_1", 3)

				local var_482_2 = var_482_0.childCount

				for iter_482_0 = 0, var_482_2 - 1 do
					local var_482_3 = var_482_0:GetChild(iter_482_0)

					if var_482_3.name == "split_2" or not string.find(var_482_3.name, "split") then
						var_482_3.gameObject:SetActive(true)
					else
						var_482_3.gameObject:SetActive(false)
					end
				end
			end

			local var_482_4 = 0.001

			if var_482_1 <= arg_479_1.time_ and arg_479_1.time_ < var_482_1 + var_482_4 then
				local var_482_5 = (arg_479_1.time_ - var_482_1) / var_482_4
				local var_482_6 = Vector3.New(0, -300, -295)

				var_482_0.localPosition = Vector3.Lerp(arg_479_1.var_.moveOldPos10092_1, var_482_6, var_482_5)
			end

			if arg_479_1.time_ >= var_482_1 + var_482_4 and arg_479_1.time_ < var_482_1 + var_482_4 + arg_482_0 then
				var_482_0.localPosition = Vector3.New(0, -300, -295)
			end

			local var_482_7 = arg_479_1.actors_["10092_1"]
			local var_482_8 = 0

			if var_482_8 < arg_479_1.time_ and arg_479_1.time_ <= var_482_8 + arg_482_0 and not isNil(var_482_7) and arg_479_1.var_.actorSpriteComps10092_1 == nil then
				arg_479_1.var_.actorSpriteComps10092_1 = var_482_7:GetComponentsInChildren(typeof(Image), true)
			end

			local var_482_9 = 2

			if var_482_8 <= arg_479_1.time_ and arg_479_1.time_ < var_482_8 + var_482_9 and not isNil(var_482_7) then
				local var_482_10 = (arg_479_1.time_ - var_482_8) / var_482_9

				if arg_479_1.var_.actorSpriteComps10092_1 then
					for iter_482_1, iter_482_2 in pairs(arg_479_1.var_.actorSpriteComps10092_1:ToTable()) do
						if iter_482_2 then
							if arg_479_1.isInRecall_ then
								local var_482_11 = Mathf.Lerp(iter_482_2.color.r, arg_479_1.hightColor1.r, var_482_10)
								local var_482_12 = Mathf.Lerp(iter_482_2.color.g, arg_479_1.hightColor1.g, var_482_10)
								local var_482_13 = Mathf.Lerp(iter_482_2.color.b, arg_479_1.hightColor1.b, var_482_10)

								iter_482_2.color = Color.New(var_482_11, var_482_12, var_482_13)
							else
								local var_482_14 = Mathf.Lerp(iter_482_2.color.r, 1, var_482_10)

								iter_482_2.color = Color.New(var_482_14, var_482_14, var_482_14)
							end
						end
					end
				end
			end

			if arg_479_1.time_ >= var_482_8 + var_482_9 and arg_479_1.time_ < var_482_8 + var_482_9 + arg_482_0 and not isNil(var_482_7) and arg_479_1.var_.actorSpriteComps10092_1 then
				for iter_482_3, iter_482_4 in pairs(arg_479_1.var_.actorSpriteComps10092_1:ToTable()) do
					if iter_482_4 then
						if arg_479_1.isInRecall_ then
							iter_482_4.color = arg_479_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_482_4.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_479_1.var_.actorSpriteComps10092_1 = nil
			end

			local var_482_15 = 0
			local var_482_16 = 0.475

			if var_482_15 < arg_479_1.time_ and arg_479_1.time_ <= var_482_15 + arg_482_0 then
				arg_479_1.talkMaxDuration = 0
				arg_479_1.dialogCg_.alpha = 1

				arg_479_1.dialog_:SetActive(true)
				SetActive(arg_479_1.leftNameGo_, true)

				local var_482_17 = arg_479_1:FormatText(StoryNameCfg[996].name)

				arg_479_1.leftNameTxt_.text = var_482_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_479_1.leftNameTxt_.transform)

				arg_479_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_479_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_479_1:RecordName(arg_479_1.leftNameTxt_.text)
				SetActive(arg_479_1.iconTrs_.gameObject, false)
				arg_479_1.callingController_:SetSelectedState("normal")

				local var_482_18 = arg_479_1:GetWordFromCfg(413141114)
				local var_482_19 = arg_479_1:FormatText(var_482_18.content)

				arg_479_1.text_.text = var_482_19

				LuaForUtil.ClearLinePrefixSymbol(arg_479_1.text_)

				local var_482_20 = 19
				local var_482_21 = utf8.len(var_482_19)
				local var_482_22 = var_482_20 <= 0 and var_482_16 or var_482_16 * (var_482_21 / var_482_20)

				if var_482_22 > 0 and var_482_16 < var_482_22 then
					arg_479_1.talkMaxDuration = var_482_22

					if var_482_22 + var_482_15 > arg_479_1.duration_ then
						arg_479_1.duration_ = var_482_22 + var_482_15
					end
				end

				arg_479_1.text_.text = var_482_19
				arg_479_1.typewritter.percent = 0

				arg_479_1.typewritter:SetDirty()
				arg_479_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_413141", "413141114", "story_v_out_413141.awb") ~= 0 then
					local var_482_23 = manager.audio:GetVoiceLength("story_v_out_413141", "413141114", "story_v_out_413141.awb") / 1000

					if var_482_23 + var_482_15 > arg_479_1.duration_ then
						arg_479_1.duration_ = var_482_23 + var_482_15
					end

					if var_482_18.prefab_name ~= "" and arg_479_1.actors_[var_482_18.prefab_name] ~= nil then
						local var_482_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_479_1.actors_[var_482_18.prefab_name].transform, "story_v_out_413141", "413141114", "story_v_out_413141.awb")

						arg_479_1:RecordAudio("413141114", var_482_24)
						arg_479_1:RecordAudio("413141114", var_482_24)
					else
						arg_479_1:AudioAction("play", "voice", "story_v_out_413141", "413141114", "story_v_out_413141.awb")
					end

					arg_479_1:RecordHistoryTalkVoice("story_v_out_413141", "413141114", "story_v_out_413141.awb")
				end

				arg_479_1:RecordContent(arg_479_1.text_.text)
			end

			local var_482_25 = math.max(var_482_16, arg_479_1.talkMaxDuration)

			if var_482_15 <= arg_479_1.time_ and arg_479_1.time_ < var_482_15 + var_482_25 then
				arg_479_1.typewritter.percent = (arg_479_1.time_ - var_482_15) / var_482_25

				arg_479_1.typewritter:SetDirty()
			end

			if arg_479_1.time_ >= var_482_15 + var_482_25 and arg_479_1.time_ < var_482_15 + var_482_25 + arg_482_0 then
				arg_479_1.typewritter.percent = 1

				arg_479_1.typewritter:SetDirty()
				arg_479_1:ShowNextGo(true)
			end
		end

		arg_479_1.nodeConfigList_ = {
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

		arg_479_1:InitPlayNodeList()
	end,
	Play413141115 = function(arg_483_0, arg_483_1)
		arg_483_1.time_ = 0
		arg_483_1.frameCnt_ = 0
		arg_483_1.state_ = "playing"
		arg_483_1.curTalkId_ = 413141115
		arg_483_1.duration_ = 9

		SetActive(arg_483_1.tipsGo_, false)

		function arg_483_1.onSingleLineFinish_()
			arg_483_1.onSingleLineUpdate_ = nil
			arg_483_1.onSingleLineFinish_ = nil
			arg_483_1.state_ = "waiting"
		end

		function arg_483_1.playNext_(arg_485_0)
			if arg_485_0 == 1 then
				arg_483_0:Play413141116(arg_483_1)
			end
		end

		function arg_483_1.onSingleLineUpdate_(arg_486_0)
			local var_486_0 = "F08m"

			if arg_483_1.bgs_[var_486_0] == nil then
				local var_486_1 = Object.Instantiate(arg_483_1.paintGo_)

				var_486_1:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. var_486_0)
				var_486_1.name = var_486_0
				var_486_1.transform.parent = arg_483_1.stage_.transform
				var_486_1.transform.localPosition = Vector3.New(0, 100, 0)
				arg_483_1.bgs_[var_486_0] = var_486_1
			end

			local var_486_2 = 2

			if var_486_2 < arg_483_1.time_ and arg_483_1.time_ <= var_486_2 + arg_486_0 then
				local var_486_3 = manager.ui.mainCamera.transform.localPosition
				local var_486_4 = Vector3.New(0, 0, 10) + Vector3.New(var_486_3.x, var_486_3.y, 0)
				local var_486_5 = arg_483_1.bgs_.F08m

				var_486_5.transform.localPosition = var_486_4
				var_486_5.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_486_6 = var_486_5:GetComponent("SpriteRenderer")

				if var_486_6 and var_486_6.sprite then
					local var_486_7 = (var_486_5.transform.localPosition - var_486_3).z
					local var_486_8 = manager.ui.mainCameraCom_
					local var_486_9 = 2 * var_486_7 * Mathf.Tan(var_486_8.fieldOfView * 0.5 * Mathf.Deg2Rad)
					local var_486_10 = var_486_9 * var_486_8.aspect
					local var_486_11 = var_486_6.sprite.bounds.size.x
					local var_486_12 = var_486_6.sprite.bounds.size.y
					local var_486_13 = var_486_10 / var_486_11
					local var_486_14 = var_486_9 / var_486_12
					local var_486_15 = var_486_14 < var_486_13 and var_486_13 or var_486_14

					var_486_5.transform.localScale = Vector3.New(var_486_15, var_486_15, 0)
				end

				for iter_486_0, iter_486_1 in pairs(arg_483_1.bgs_) do
					if iter_486_0 ~= "F08m" then
						iter_486_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_486_16 = 4

			if var_486_16 < arg_483_1.time_ and arg_483_1.time_ <= var_486_16 + arg_486_0 then
				arg_483_1.allBtn_.enabled = false
			end

			local var_486_17 = 0.3

			if arg_483_1.time_ >= var_486_16 + var_486_17 and arg_483_1.time_ < var_486_16 + var_486_17 + arg_486_0 then
				arg_483_1.allBtn_.enabled = true
			end

			local var_486_18 = 0

			if var_486_18 < arg_483_1.time_ and arg_483_1.time_ <= var_486_18 + arg_486_0 then
				arg_483_1.mask_.enabled = true
				arg_483_1.mask_.raycastTarget = true

				arg_483_1:SetGaussion(false)
			end

			local var_486_19 = 2

			if var_486_18 <= arg_483_1.time_ and arg_483_1.time_ < var_486_18 + var_486_19 then
				local var_486_20 = (arg_483_1.time_ - var_486_18) / var_486_19
				local var_486_21 = Color.New(0, 0, 0)

				var_486_21.a = Mathf.Lerp(0, 1, var_486_20)
				arg_483_1.mask_.color = var_486_21
			end

			if arg_483_1.time_ >= var_486_18 + var_486_19 and arg_483_1.time_ < var_486_18 + var_486_19 + arg_486_0 then
				local var_486_22 = Color.New(0, 0, 0)

				var_486_22.a = 1
				arg_483_1.mask_.color = var_486_22
			end

			local var_486_23 = 2

			if var_486_23 < arg_483_1.time_ and arg_483_1.time_ <= var_486_23 + arg_486_0 then
				arg_483_1.mask_.enabled = true
				arg_483_1.mask_.raycastTarget = true

				arg_483_1:SetGaussion(false)
			end

			local var_486_24 = 2

			if var_486_23 <= arg_483_1.time_ and arg_483_1.time_ < var_486_23 + var_486_24 then
				local var_486_25 = (arg_483_1.time_ - var_486_23) / var_486_24
				local var_486_26 = Color.New(0, 0, 0)

				var_486_26.a = Mathf.Lerp(1, 0, var_486_25)
				arg_483_1.mask_.color = var_486_26
			end

			if arg_483_1.time_ >= var_486_23 + var_486_24 and arg_483_1.time_ < var_486_23 + var_486_24 + arg_486_0 then
				local var_486_27 = Color.New(0, 0, 0)
				local var_486_28 = 0

				arg_483_1.mask_.enabled = false
				var_486_27.a = var_486_28
				arg_483_1.mask_.color = var_486_27
			end

			local var_486_29 = arg_483_1.actors_["10092_1"].transform
			local var_486_30 = 2

			if var_486_30 < arg_483_1.time_ and arg_483_1.time_ <= var_486_30 + arg_486_0 then
				arg_483_1.var_.moveOldPos10092_1 = var_486_29.localPosition
				var_486_29.localScale = Vector3.New(1, 1, 1)

				arg_483_1:CheckSpriteTmpPos("10092_1", 6)

				local var_486_31 = var_486_29.childCount

				for iter_486_2 = 0, var_486_31 - 1 do
					local var_486_32 = var_486_29:GetChild(iter_486_2)

					if var_486_32.name == "" or not string.find(var_486_32.name, "split") then
						var_486_32.gameObject:SetActive(true)
					else
						var_486_32.gameObject:SetActive(false)
					end
				end
			end

			local var_486_33 = 0.001

			if var_486_30 <= arg_483_1.time_ and arg_483_1.time_ < var_486_30 + var_486_33 then
				local var_486_34 = (arg_483_1.time_ - var_486_30) / var_486_33
				local var_486_35 = Vector3.New(1500, -300, -295)

				var_486_29.localPosition = Vector3.Lerp(arg_483_1.var_.moveOldPos10092_1, var_486_35, var_486_34)
			end

			if arg_483_1.time_ >= var_486_30 + var_486_33 and arg_483_1.time_ < var_486_30 + var_486_33 + arg_486_0 then
				var_486_29.localPosition = Vector3.New(1500, -300, -295)
			end

			if arg_483_1.frameCnt_ <= 1 then
				arg_483_1.dialog_:SetActive(false)
			end

			local var_486_36 = 4
			local var_486_37 = 1.175

			if var_486_36 < arg_483_1.time_ and arg_483_1.time_ <= var_486_36 + arg_486_0 then
				arg_483_1.talkMaxDuration = 0

				arg_483_1.dialog_:SetActive(true)

				arg_483_1.dialogCg_.alpha = 0

				local var_486_38 = LeanTween.value(arg_483_1.dialog_, 0, 1, 0.3)

				var_486_38:setOnUpdate(LuaHelper.FloatAction(function(arg_487_0)
					arg_483_1.dialogCg_.alpha = arg_487_0
				end))
				var_486_38:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_483_1.dialog_)
					var_486_38:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_483_1.duration_ = arg_483_1.duration_ + 0.3

				SetActive(arg_483_1.leftNameGo_, false)

				arg_483_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_483_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_483_1:RecordName(arg_483_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_483_1.iconTrs_.gameObject, false)
				arg_483_1.callingController_:SetSelectedState("normal")

				local var_486_39 = arg_483_1:GetWordFromCfg(413141115)
				local var_486_40 = arg_483_1:FormatText(var_486_39.content)

				arg_483_1.text_.text = var_486_40

				LuaForUtil.ClearLinePrefixSymbol(arg_483_1.text_)

				local var_486_41 = 47
				local var_486_42 = utf8.len(var_486_40)
				local var_486_43 = var_486_41 <= 0 and var_486_37 or var_486_37 * (var_486_42 / var_486_41)

				if var_486_43 > 0 and var_486_37 < var_486_43 then
					arg_483_1.talkMaxDuration = var_486_43
					var_486_36 = var_486_36 + 0.3

					if var_486_43 + var_486_36 > arg_483_1.duration_ then
						arg_483_1.duration_ = var_486_43 + var_486_36
					end
				end

				arg_483_1.text_.text = var_486_40
				arg_483_1.typewritter.percent = 0

				arg_483_1.typewritter:SetDirty()
				arg_483_1:ShowNextGo(false)
				arg_483_1:RecordContent(arg_483_1.text_.text)
			end

			local var_486_44 = var_486_36 + 0.3
			local var_486_45 = math.max(var_486_37, arg_483_1.talkMaxDuration)

			if var_486_44 <= arg_483_1.time_ and arg_483_1.time_ < var_486_44 + var_486_45 then
				arg_483_1.typewritter.percent = (arg_483_1.time_ - var_486_44) / var_486_45

				arg_483_1.typewritter:SetDirty()
			end

			if arg_483_1.time_ >= var_486_44 + var_486_45 and arg_483_1.time_ < var_486_44 + var_486_45 + arg_486_0 then
				arg_483_1.typewritter.percent = 1

				arg_483_1.typewritter:SetDirty()
				arg_483_1:ShowNextGo(true)
			end
		end

		arg_483_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10092_1",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 2,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_483_1:InitPlayNodeList()
	end,
	Play413141116 = function(arg_489_0, arg_489_1)
		arg_489_1.time_ = 0
		arg_489_1.frameCnt_ = 0
		arg_489_1.state_ = "playing"
		arg_489_1.curTalkId_ = 413141116
		arg_489_1.duration_ = 5

		local var_489_0 = {
			zh = 3.466,
			ja = 5
		}
		local var_489_1 = manager.audio:GetLocalizationFlag()

		if var_489_0[var_489_1] ~= nil then
			arg_489_1.duration_ = var_489_0[var_489_1]
		end

		SetActive(arg_489_1.tipsGo_, false)

		function arg_489_1.onSingleLineFinish_()
			arg_489_1.onSingleLineUpdate_ = nil
			arg_489_1.onSingleLineFinish_ = nil
			arg_489_1.state_ = "waiting"
		end

		function arg_489_1.playNext_(arg_491_0)
			if arg_491_0 == 1 then
				arg_489_0:Play413141117(arg_489_1)
			end
		end

		function arg_489_1.onSingleLineUpdate_(arg_492_0)
			local var_492_0 = 0
			local var_492_1 = 0.35

			if var_492_0 < arg_489_1.time_ and arg_489_1.time_ <= var_492_0 + arg_492_0 then
				arg_489_1.talkMaxDuration = 0
				arg_489_1.dialogCg_.alpha = 1

				arg_489_1.dialog_:SetActive(true)
				SetActive(arg_489_1.leftNameGo_, true)

				local var_492_2 = arg_489_1:FormatText(StoryNameCfg[993].name)

				arg_489_1.leftNameTxt_.text = var_492_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_489_1.leftNameTxt_.transform)

				arg_489_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_489_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_489_1:RecordName(arg_489_1.leftNameTxt_.text)
				SetActive(arg_489_1.iconTrs_.gameObject, true)
				arg_489_1.iconController_:SetSelectedState("hero")

				arg_489_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_citizenmb")

				arg_489_1.callingController_:SetSelectedState("normal")

				arg_489_1.keyicon_.color = Color.New(1, 1, 1)
				arg_489_1.icon_.color = Color.New(1, 1, 1)

				local var_492_3 = arg_489_1:GetWordFromCfg(413141116)
				local var_492_4 = arg_489_1:FormatText(var_492_3.content)

				arg_489_1.text_.text = var_492_4

				LuaForUtil.ClearLinePrefixSymbol(arg_489_1.text_)

				local var_492_5 = 14
				local var_492_6 = utf8.len(var_492_4)
				local var_492_7 = var_492_5 <= 0 and var_492_1 or var_492_1 * (var_492_6 / var_492_5)

				if var_492_7 > 0 and var_492_1 < var_492_7 then
					arg_489_1.talkMaxDuration = var_492_7

					if var_492_7 + var_492_0 > arg_489_1.duration_ then
						arg_489_1.duration_ = var_492_7 + var_492_0
					end
				end

				arg_489_1.text_.text = var_492_4
				arg_489_1.typewritter.percent = 0

				arg_489_1.typewritter:SetDirty()
				arg_489_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_413141", "413141116", "story_v_out_413141.awb") ~= 0 then
					local var_492_8 = manager.audio:GetVoiceLength("story_v_out_413141", "413141116", "story_v_out_413141.awb") / 1000

					if var_492_8 + var_492_0 > arg_489_1.duration_ then
						arg_489_1.duration_ = var_492_8 + var_492_0
					end

					if var_492_3.prefab_name ~= "" and arg_489_1.actors_[var_492_3.prefab_name] ~= nil then
						local var_492_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_489_1.actors_[var_492_3.prefab_name].transform, "story_v_out_413141", "413141116", "story_v_out_413141.awb")

						arg_489_1:RecordAudio("413141116", var_492_9)
						arg_489_1:RecordAudio("413141116", var_492_9)
					else
						arg_489_1:AudioAction("play", "voice", "story_v_out_413141", "413141116", "story_v_out_413141.awb")
					end

					arg_489_1:RecordHistoryTalkVoice("story_v_out_413141", "413141116", "story_v_out_413141.awb")
				end

				arg_489_1:RecordContent(arg_489_1.text_.text)
			end

			local var_492_10 = math.max(var_492_1, arg_489_1.talkMaxDuration)

			if var_492_0 <= arg_489_1.time_ and arg_489_1.time_ < var_492_0 + var_492_10 then
				arg_489_1.typewritter.percent = (arg_489_1.time_ - var_492_0) / var_492_10

				arg_489_1.typewritter:SetDirty()
			end

			if arg_489_1.time_ >= var_492_0 + var_492_10 and arg_489_1.time_ < var_492_0 + var_492_10 + arg_492_0 then
				arg_489_1.typewritter.percent = 1

				arg_489_1.typewritter:SetDirty()
				arg_489_1:ShowNextGo(true)
			end
		end

		arg_489_1.nodeConfigList_ = {}

		arg_489_1:InitPlayNodeList()
	end,
	Play413141117 = function(arg_493_0, arg_493_1)
		arg_493_1.time_ = 0
		arg_493_1.frameCnt_ = 0
		arg_493_1.state_ = "playing"
		arg_493_1.curTalkId_ = 413141117
		arg_493_1.duration_ = 3.83

		local var_493_0 = {
			zh = 3,
			ja = 3.833
		}
		local var_493_1 = manager.audio:GetLocalizationFlag()

		if var_493_0[var_493_1] ~= nil then
			arg_493_1.duration_ = var_493_0[var_493_1]
		end

		SetActive(arg_493_1.tipsGo_, false)

		function arg_493_1.onSingleLineFinish_()
			arg_493_1.onSingleLineUpdate_ = nil
			arg_493_1.onSingleLineFinish_ = nil
			arg_493_1.state_ = "waiting"
		end

		function arg_493_1.playNext_(arg_495_0)
			if arg_495_0 == 1 then
				arg_493_0:Play413141118(arg_493_1)
			end
		end

		function arg_493_1.onSingleLineUpdate_(arg_496_0)
			local var_496_0 = 0
			local var_496_1 = 0.175

			if var_496_0 < arg_493_1.time_ and arg_493_1.time_ <= var_496_0 + arg_496_0 then
				arg_493_1.talkMaxDuration = 0
				arg_493_1.dialogCg_.alpha = 1

				arg_493_1.dialog_:SetActive(true)
				SetActive(arg_493_1.leftNameGo_, true)

				local var_496_2 = arg_493_1:FormatText(StoryNameCfg[993].name)

				arg_493_1.leftNameTxt_.text = var_496_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_493_1.leftNameTxt_.transform)

				arg_493_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_493_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_493_1:RecordName(arg_493_1.leftNameTxt_.text)
				SetActive(arg_493_1.iconTrs_.gameObject, true)
				arg_493_1.iconController_:SetSelectedState("hero")

				arg_493_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_citizenmb")

				arg_493_1.callingController_:SetSelectedState("normal")

				arg_493_1.keyicon_.color = Color.New(1, 1, 1)
				arg_493_1.icon_.color = Color.New(1, 1, 1)

				local var_496_3 = arg_493_1:GetWordFromCfg(413141117)
				local var_496_4 = arg_493_1:FormatText(var_496_3.content)

				arg_493_1.text_.text = var_496_4

				LuaForUtil.ClearLinePrefixSymbol(arg_493_1.text_)

				local var_496_5 = 7
				local var_496_6 = utf8.len(var_496_4)
				local var_496_7 = var_496_5 <= 0 and var_496_1 or var_496_1 * (var_496_6 / var_496_5)

				if var_496_7 > 0 and var_496_1 < var_496_7 then
					arg_493_1.talkMaxDuration = var_496_7

					if var_496_7 + var_496_0 > arg_493_1.duration_ then
						arg_493_1.duration_ = var_496_7 + var_496_0
					end
				end

				arg_493_1.text_.text = var_496_4
				arg_493_1.typewritter.percent = 0

				arg_493_1.typewritter:SetDirty()
				arg_493_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_413141", "413141117", "story_v_out_413141.awb") ~= 0 then
					local var_496_8 = manager.audio:GetVoiceLength("story_v_out_413141", "413141117", "story_v_out_413141.awb") / 1000

					if var_496_8 + var_496_0 > arg_493_1.duration_ then
						arg_493_1.duration_ = var_496_8 + var_496_0
					end

					if var_496_3.prefab_name ~= "" and arg_493_1.actors_[var_496_3.prefab_name] ~= nil then
						local var_496_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_493_1.actors_[var_496_3.prefab_name].transform, "story_v_out_413141", "413141117", "story_v_out_413141.awb")

						arg_493_1:RecordAudio("413141117", var_496_9)
						arg_493_1:RecordAudio("413141117", var_496_9)
					else
						arg_493_1:AudioAction("play", "voice", "story_v_out_413141", "413141117", "story_v_out_413141.awb")
					end

					arg_493_1:RecordHistoryTalkVoice("story_v_out_413141", "413141117", "story_v_out_413141.awb")
				end

				arg_493_1:RecordContent(arg_493_1.text_.text)
			end

			local var_496_10 = math.max(var_496_1, arg_493_1.talkMaxDuration)

			if var_496_0 <= arg_493_1.time_ and arg_493_1.time_ < var_496_0 + var_496_10 then
				arg_493_1.typewritter.percent = (arg_493_1.time_ - var_496_0) / var_496_10

				arg_493_1.typewritter:SetDirty()
			end

			if arg_493_1.time_ >= var_496_0 + var_496_10 and arg_493_1.time_ < var_496_0 + var_496_10 + arg_496_0 then
				arg_493_1.typewritter.percent = 1

				arg_493_1.typewritter:SetDirty()
				arg_493_1:ShowNextGo(true)
			end
		end

		arg_493_1.nodeConfigList_ = {}

		arg_493_1:InitPlayNodeList()
	end,
	Play413141118 = function(arg_497_0, arg_497_1)
		arg_497_1.time_ = 0
		arg_497_1.frameCnt_ = 0
		arg_497_1.state_ = "playing"
		arg_497_1.curTalkId_ = 413141118
		arg_497_1.duration_ = 6.2

		local var_497_0 = {
			zh = 3.766,
			ja = 6.2
		}
		local var_497_1 = manager.audio:GetLocalizationFlag()

		if var_497_0[var_497_1] ~= nil then
			arg_497_1.duration_ = var_497_0[var_497_1]
		end

		SetActive(arg_497_1.tipsGo_, false)

		function arg_497_1.onSingleLineFinish_()
			arg_497_1.onSingleLineUpdate_ = nil
			arg_497_1.onSingleLineFinish_ = nil
			arg_497_1.state_ = "waiting"
		end

		function arg_497_1.playNext_(arg_499_0)
			if arg_499_0 == 1 then
				arg_497_0:Play413141119(arg_497_1)
			end
		end

		function arg_497_1.onSingleLineUpdate_(arg_500_0)
			local var_500_0 = manager.ui.mainCamera.transform
			local var_500_1 = 0

			if var_500_1 < arg_497_1.time_ and arg_497_1.time_ <= var_500_1 + arg_500_0 then
				arg_497_1.var_.shakeOldPos = var_500_0.localPosition
			end

			local var_500_2 = 0.6

			if var_500_1 <= arg_497_1.time_ and arg_497_1.time_ < var_500_1 + var_500_2 then
				local var_500_3 = (arg_497_1.time_ - var_500_1) / 0.066
				local var_500_4, var_500_5 = math.modf(var_500_3)

				var_500_0.localPosition = Vector3.New(var_500_5 * 0.13, var_500_5 * 0.13, var_500_5 * 0.13) + arg_497_1.var_.shakeOldPos
			end

			if arg_497_1.time_ >= var_500_1 + var_500_2 and arg_497_1.time_ < var_500_1 + var_500_2 + arg_500_0 then
				var_500_0.localPosition = arg_497_1.var_.shakeOldPos
			end

			local var_500_6 = 0

			if var_500_6 < arg_497_1.time_ and arg_497_1.time_ <= var_500_6 + arg_500_0 then
				arg_497_1.allBtn_.enabled = false
			end

			local var_500_7 = 0.6

			if arg_497_1.time_ >= var_500_6 + var_500_7 and arg_497_1.time_ < var_500_6 + var_500_7 + arg_500_0 then
				arg_497_1.allBtn_.enabled = true
			end

			local var_500_8 = 0
			local var_500_9 = 0.325

			if var_500_8 < arg_497_1.time_ and arg_497_1.time_ <= var_500_8 + arg_500_0 then
				arg_497_1.talkMaxDuration = 0
				arg_497_1.dialogCg_.alpha = 1

				arg_497_1.dialog_:SetActive(true)
				SetActive(arg_497_1.leftNameGo_, true)

				local var_500_10 = arg_497_1:FormatText(StoryNameCfg[993].name)

				arg_497_1.leftNameTxt_.text = var_500_10

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_497_1.leftNameTxt_.transform)

				arg_497_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_497_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_497_1:RecordName(arg_497_1.leftNameTxt_.text)
				SetActive(arg_497_1.iconTrs_.gameObject, true)
				arg_497_1.iconController_:SetSelectedState("hero")

				arg_497_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_citizenmb")

				arg_497_1.callingController_:SetSelectedState("normal")

				arg_497_1.keyicon_.color = Color.New(1, 1, 1)
				arg_497_1.icon_.color = Color.New(1, 1, 1)

				local var_500_11 = arg_497_1:GetWordFromCfg(413141118)
				local var_500_12 = arg_497_1:FormatText(var_500_11.content)

				arg_497_1.text_.text = var_500_12

				LuaForUtil.ClearLinePrefixSymbol(arg_497_1.text_)

				local var_500_13 = 13
				local var_500_14 = utf8.len(var_500_12)
				local var_500_15 = var_500_13 <= 0 and var_500_9 or var_500_9 * (var_500_14 / var_500_13)

				if var_500_15 > 0 and var_500_9 < var_500_15 then
					arg_497_1.talkMaxDuration = var_500_15

					if var_500_15 + var_500_8 > arg_497_1.duration_ then
						arg_497_1.duration_ = var_500_15 + var_500_8
					end
				end

				arg_497_1.text_.text = var_500_12
				arg_497_1.typewritter.percent = 0

				arg_497_1.typewritter:SetDirty()
				arg_497_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_413141", "413141118", "story_v_out_413141.awb") ~= 0 then
					local var_500_16 = manager.audio:GetVoiceLength("story_v_out_413141", "413141118", "story_v_out_413141.awb") / 1000

					if var_500_16 + var_500_8 > arg_497_1.duration_ then
						arg_497_1.duration_ = var_500_16 + var_500_8
					end

					if var_500_11.prefab_name ~= "" and arg_497_1.actors_[var_500_11.prefab_name] ~= nil then
						local var_500_17 = LuaForUtil.PlayVoiceWithCriLipsync(arg_497_1.actors_[var_500_11.prefab_name].transform, "story_v_out_413141", "413141118", "story_v_out_413141.awb")

						arg_497_1:RecordAudio("413141118", var_500_17)
						arg_497_1:RecordAudio("413141118", var_500_17)
					else
						arg_497_1:AudioAction("play", "voice", "story_v_out_413141", "413141118", "story_v_out_413141.awb")
					end

					arg_497_1:RecordHistoryTalkVoice("story_v_out_413141", "413141118", "story_v_out_413141.awb")
				end

				arg_497_1:RecordContent(arg_497_1.text_.text)
			end

			local var_500_18 = math.max(var_500_9, arg_497_1.talkMaxDuration)

			if var_500_8 <= arg_497_1.time_ and arg_497_1.time_ < var_500_8 + var_500_18 then
				arg_497_1.typewritter.percent = (arg_497_1.time_ - var_500_8) / var_500_18

				arg_497_1.typewritter:SetDirty()
			end

			if arg_497_1.time_ >= var_500_8 + var_500_18 and arg_497_1.time_ < var_500_8 + var_500_18 + arg_500_0 then
				arg_497_1.typewritter.percent = 1

				arg_497_1.typewritter:SetDirty()
				arg_497_1:ShowNextGo(true)
			end
		end

		arg_497_1.nodeConfigList_ = {}

		arg_497_1:InitPlayNodeList()
	end,
	Play413141119 = function(arg_501_0, arg_501_1)
		arg_501_1.time_ = 0
		arg_501_1.frameCnt_ = 0
		arg_501_1.state_ = "playing"
		arg_501_1.curTalkId_ = 413141119
		arg_501_1.duration_ = 8.03

		SetActive(arg_501_1.tipsGo_, false)

		function arg_501_1.onSingleLineFinish_()
			arg_501_1.onSingleLineUpdate_ = nil
			arg_501_1.onSingleLineFinish_ = nil
			arg_501_1.state_ = "waiting"
		end

		function arg_501_1.playNext_(arg_503_0)
			if arg_503_0 == 1 then
				arg_501_0:Play413141120(arg_501_1)
			end
		end

		function arg_501_1.onSingleLineUpdate_(arg_504_0)
			local var_504_0 = "F10g"

			if arg_501_1.bgs_[var_504_0] == nil then
				local var_504_1 = Object.Instantiate(arg_501_1.paintGo_)

				var_504_1:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. var_504_0)
				var_504_1.name = var_504_0
				var_504_1.transform.parent = arg_501_1.stage_.transform
				var_504_1.transform.localPosition = Vector3.New(0, 100, 0)
				arg_501_1.bgs_[var_504_0] = var_504_1
			end

			local var_504_2 = 1.26666666666667

			if var_504_2 < arg_501_1.time_ and arg_501_1.time_ <= var_504_2 + arg_504_0 then
				local var_504_3 = manager.ui.mainCamera.transform.localPosition
				local var_504_4 = Vector3.New(0, 0, 10) + Vector3.New(var_504_3.x, var_504_3.y, 0)
				local var_504_5 = arg_501_1.bgs_.F10g

				var_504_5.transform.localPosition = var_504_4
				var_504_5.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_504_6 = var_504_5:GetComponent("SpriteRenderer")

				if var_504_6 and var_504_6.sprite then
					local var_504_7 = (var_504_5.transform.localPosition - var_504_3).z
					local var_504_8 = manager.ui.mainCameraCom_
					local var_504_9 = 2 * var_504_7 * Mathf.Tan(var_504_8.fieldOfView * 0.5 * Mathf.Deg2Rad)
					local var_504_10 = var_504_9 * var_504_8.aspect
					local var_504_11 = var_504_6.sprite.bounds.size.x
					local var_504_12 = var_504_6.sprite.bounds.size.y
					local var_504_13 = var_504_10 / var_504_11
					local var_504_14 = var_504_9 / var_504_12
					local var_504_15 = var_504_14 < var_504_13 and var_504_13 or var_504_14

					var_504_5.transform.localScale = Vector3.New(var_504_15, var_504_15, 0)
				end

				for iter_504_0, iter_504_1 in pairs(arg_501_1.bgs_) do
					if iter_504_0 ~= "F10g" then
						iter_504_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_504_16 = 2.86666666666667

			if var_504_16 < arg_501_1.time_ and arg_501_1.time_ <= var_504_16 + arg_504_0 then
				arg_501_1.allBtn_.enabled = false
			end

			local var_504_17 = 0.3

			if arg_501_1.time_ >= var_504_16 + var_504_17 and arg_501_1.time_ < var_504_16 + var_504_17 + arg_504_0 then
				arg_501_1.allBtn_.enabled = true
			end

			local var_504_18 = 0

			if var_504_18 < arg_501_1.time_ and arg_501_1.time_ <= var_504_18 + arg_504_0 then
				arg_501_1.mask_.enabled = true
				arg_501_1.mask_.raycastTarget = true

				arg_501_1:SetGaussion(false)
			end

			local var_504_19 = 1.26666666666667

			if var_504_18 <= arg_501_1.time_ and arg_501_1.time_ < var_504_18 + var_504_19 then
				local var_504_20 = (arg_501_1.time_ - var_504_18) / var_504_19
				local var_504_21 = Color.New(1, 1, 1)

				var_504_21.a = Mathf.Lerp(0, 1, var_504_20)
				arg_501_1.mask_.color = var_504_21
			end

			if arg_501_1.time_ >= var_504_18 + var_504_19 and arg_501_1.time_ < var_504_18 + var_504_19 + arg_504_0 then
				local var_504_22 = Color.New(1, 1, 1)

				var_504_22.a = 1
				arg_501_1.mask_.color = var_504_22
			end

			local var_504_23 = 1.26666666666667

			if var_504_23 < arg_501_1.time_ and arg_501_1.time_ <= var_504_23 + arg_504_0 then
				arg_501_1.mask_.enabled = true
				arg_501_1.mask_.raycastTarget = true

				arg_501_1:SetGaussion(false)
			end

			local var_504_24 = 1.6

			if var_504_23 <= arg_501_1.time_ and arg_501_1.time_ < var_504_23 + var_504_24 then
				local var_504_25 = (arg_501_1.time_ - var_504_23) / var_504_24
				local var_504_26 = Color.New(1, 1, 1)

				var_504_26.a = Mathf.Lerp(1, 0, var_504_25)
				arg_501_1.mask_.color = var_504_26
			end

			if arg_501_1.time_ >= var_504_23 + var_504_24 and arg_501_1.time_ < var_504_23 + var_504_24 + arg_504_0 then
				local var_504_27 = Color.New(1, 1, 1)
				local var_504_28 = 0

				arg_501_1.mask_.enabled = false
				var_504_27.a = var_504_28
				arg_501_1.mask_.color = var_504_27
			end

			if arg_501_1.frameCnt_ <= 1 then
				arg_501_1.dialog_:SetActive(false)
			end

			local var_504_29 = 3.03333333333333
			local var_504_30 = 0.7

			if var_504_29 < arg_501_1.time_ and arg_501_1.time_ <= var_504_29 + arg_504_0 then
				arg_501_1.talkMaxDuration = 0

				arg_501_1.dialog_:SetActive(true)

				arg_501_1.dialogCg_.alpha = 0

				local var_504_31 = LeanTween.value(arg_501_1.dialog_, 0, 1, 0.3)

				var_504_31:setOnUpdate(LuaHelper.FloatAction(function(arg_505_0)
					arg_501_1.dialogCg_.alpha = arg_505_0
				end))
				var_504_31:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_501_1.dialog_)
					var_504_31:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_501_1.duration_ = arg_501_1.duration_ + 0.3

				SetActive(arg_501_1.leftNameGo_, false)

				arg_501_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_501_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_501_1:RecordName(arg_501_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_501_1.iconTrs_.gameObject, false)
				arg_501_1.callingController_:SetSelectedState("normal")

				local var_504_32 = arg_501_1:GetWordFromCfg(413141119)
				local var_504_33 = arg_501_1:FormatText(var_504_32.content)

				arg_501_1.text_.text = var_504_33

				LuaForUtil.ClearLinePrefixSymbol(arg_501_1.text_)

				local var_504_34 = 28
				local var_504_35 = utf8.len(var_504_33)
				local var_504_36 = var_504_34 <= 0 and var_504_30 or var_504_30 * (var_504_35 / var_504_34)

				if var_504_36 > 0 and var_504_30 < var_504_36 then
					arg_501_1.talkMaxDuration = var_504_36
					var_504_29 = var_504_29 + 0.3

					if var_504_36 + var_504_29 > arg_501_1.duration_ then
						arg_501_1.duration_ = var_504_36 + var_504_29
					end
				end

				arg_501_1.text_.text = var_504_33
				arg_501_1.typewritter.percent = 0

				arg_501_1.typewritter:SetDirty()
				arg_501_1:ShowNextGo(false)
				arg_501_1:RecordContent(arg_501_1.text_.text)
			end

			local var_504_37 = var_504_29 + 0.3
			local var_504_38 = math.max(var_504_30, arg_501_1.talkMaxDuration)

			if var_504_37 <= arg_501_1.time_ and arg_501_1.time_ < var_504_37 + var_504_38 then
				arg_501_1.typewritter.percent = (arg_501_1.time_ - var_504_37) / var_504_38

				arg_501_1.typewritter:SetDirty()
			end

			if arg_501_1.time_ >= var_504_37 + var_504_38 and arg_501_1.time_ < var_504_37 + var_504_38 + arg_504_0 then
				arg_501_1.typewritter.percent = 1

				arg_501_1.typewritter:SetDirty()
				arg_501_1:ShowNextGo(true)
			end
		end

		arg_501_1.nodeConfigList_ = {}

		arg_501_1:InitPlayNodeList()
	end,
	Play413141120 = function(arg_507_0, arg_507_1)
		arg_507_1.time_ = 0
		arg_507_1.frameCnt_ = 0
		arg_507_1.state_ = "playing"
		arg_507_1.curTalkId_ = 413141120
		arg_507_1.duration_ = 5

		SetActive(arg_507_1.tipsGo_, false)

		function arg_507_1.onSingleLineFinish_()
			arg_507_1.onSingleLineUpdate_ = nil
			arg_507_1.onSingleLineFinish_ = nil
			arg_507_1.state_ = "waiting"
		end

		function arg_507_1.playNext_(arg_509_0)
			if arg_509_0 == 1 then
				arg_507_0:Play413141121(arg_507_1)
			end
		end

		function arg_507_1.onSingleLineUpdate_(arg_510_0)
			local var_510_0 = 0
			local var_510_1 = 1.15

			if var_510_0 < arg_507_1.time_ and arg_507_1.time_ <= var_510_0 + arg_510_0 then
				arg_507_1.talkMaxDuration = 0
				arg_507_1.dialogCg_.alpha = 1

				arg_507_1.dialog_:SetActive(true)
				SetActive(arg_507_1.leftNameGo_, false)

				arg_507_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_507_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_507_1:RecordName(arg_507_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_507_1.iconTrs_.gameObject, false)
				arg_507_1.callingController_:SetSelectedState("normal")

				local var_510_2 = arg_507_1:GetWordFromCfg(413141120)
				local var_510_3 = arg_507_1:FormatText(var_510_2.content)

				arg_507_1.text_.text = var_510_3

				LuaForUtil.ClearLinePrefixSymbol(arg_507_1.text_)

				local var_510_4 = 46
				local var_510_5 = utf8.len(var_510_3)
				local var_510_6 = var_510_4 <= 0 and var_510_1 or var_510_1 * (var_510_5 / var_510_4)

				if var_510_6 > 0 and var_510_1 < var_510_6 then
					arg_507_1.talkMaxDuration = var_510_6

					if var_510_6 + var_510_0 > arg_507_1.duration_ then
						arg_507_1.duration_ = var_510_6 + var_510_0
					end
				end

				arg_507_1.text_.text = var_510_3
				arg_507_1.typewritter.percent = 0

				arg_507_1.typewritter:SetDirty()
				arg_507_1:ShowNextGo(false)
				arg_507_1:RecordContent(arg_507_1.text_.text)
			end

			local var_510_7 = math.max(var_510_1, arg_507_1.talkMaxDuration)

			if var_510_0 <= arg_507_1.time_ and arg_507_1.time_ < var_510_0 + var_510_7 then
				arg_507_1.typewritter.percent = (arg_507_1.time_ - var_510_0) / var_510_7

				arg_507_1.typewritter:SetDirty()
			end

			if arg_507_1.time_ >= var_510_0 + var_510_7 and arg_507_1.time_ < var_510_0 + var_510_7 + arg_510_0 then
				arg_507_1.typewritter.percent = 1

				arg_507_1.typewritter:SetDirty()
				arg_507_1:ShowNextGo(true)
			end
		end

		arg_507_1.nodeConfigList_ = {}

		arg_507_1:InitPlayNodeList()
	end,
	Play413141121 = function(arg_511_0, arg_511_1)
		arg_511_1.time_ = 0
		arg_511_1.frameCnt_ = 0
		arg_511_1.state_ = "playing"
		arg_511_1.curTalkId_ = 413141121
		arg_511_1.duration_ = 5

		SetActive(arg_511_1.tipsGo_, false)

		function arg_511_1.onSingleLineFinish_()
			arg_511_1.onSingleLineUpdate_ = nil
			arg_511_1.onSingleLineFinish_ = nil
			arg_511_1.state_ = "waiting"
		end

		function arg_511_1.playNext_(arg_513_0)
			if arg_513_0 == 1 then
				arg_511_0:Play413141122(arg_511_1)
			end
		end

		function arg_511_1.onSingleLineUpdate_(arg_514_0)
			local var_514_0 = 0
			local var_514_1 = 0.875

			if var_514_0 < arg_511_1.time_ and arg_511_1.time_ <= var_514_0 + arg_514_0 then
				arg_511_1.talkMaxDuration = 0
				arg_511_1.dialogCg_.alpha = 1

				arg_511_1.dialog_:SetActive(true)
				SetActive(arg_511_1.leftNameGo_, false)

				arg_511_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_511_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_511_1:RecordName(arg_511_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_511_1.iconTrs_.gameObject, false)
				arg_511_1.callingController_:SetSelectedState("normal")

				local var_514_2 = arg_511_1:GetWordFromCfg(413141121)
				local var_514_3 = arg_511_1:FormatText(var_514_2.content)

				arg_511_1.text_.text = var_514_3

				LuaForUtil.ClearLinePrefixSymbol(arg_511_1.text_)

				local var_514_4 = 35
				local var_514_5 = utf8.len(var_514_3)
				local var_514_6 = var_514_4 <= 0 and var_514_1 or var_514_1 * (var_514_5 / var_514_4)

				if var_514_6 > 0 and var_514_1 < var_514_6 then
					arg_511_1.talkMaxDuration = var_514_6

					if var_514_6 + var_514_0 > arg_511_1.duration_ then
						arg_511_1.duration_ = var_514_6 + var_514_0
					end
				end

				arg_511_1.text_.text = var_514_3
				arg_511_1.typewritter.percent = 0

				arg_511_1.typewritter:SetDirty()
				arg_511_1:ShowNextGo(false)
				arg_511_1:RecordContent(arg_511_1.text_.text)
			end

			local var_514_7 = math.max(var_514_1, arg_511_1.talkMaxDuration)

			if var_514_0 <= arg_511_1.time_ and arg_511_1.time_ < var_514_0 + var_514_7 then
				arg_511_1.typewritter.percent = (arg_511_1.time_ - var_514_0) / var_514_7

				arg_511_1.typewritter:SetDirty()
			end

			if arg_511_1.time_ >= var_514_0 + var_514_7 and arg_511_1.time_ < var_514_0 + var_514_7 + arg_514_0 then
				arg_511_1.typewritter.percent = 1

				arg_511_1.typewritter:SetDirty()
				arg_511_1:ShowNextGo(true)
			end
		end

		arg_511_1.nodeConfigList_ = {}

		arg_511_1:InitPlayNodeList()
	end,
	Play413141122 = function(arg_515_0, arg_515_1)
		arg_515_1.time_ = 0
		arg_515_1.frameCnt_ = 0
		arg_515_1.state_ = "playing"
		arg_515_1.curTalkId_ = 413141122
		arg_515_1.duration_ = 13.17

		local var_515_0 = {
			zh = 8.533,
			ja = 13.166
		}
		local var_515_1 = manager.audio:GetLocalizationFlag()

		if var_515_0[var_515_1] ~= nil then
			arg_515_1.duration_ = var_515_0[var_515_1]
		end

		SetActive(arg_515_1.tipsGo_, false)

		function arg_515_1.onSingleLineFinish_()
			arg_515_1.onSingleLineUpdate_ = nil
			arg_515_1.onSingleLineFinish_ = nil
			arg_515_1.state_ = "waiting"
		end

		function arg_515_1.playNext_(arg_517_0)
			if arg_517_0 == 1 then
				arg_515_0:Play413141123(arg_515_1)
			end
		end

		function arg_515_1.onSingleLineUpdate_(arg_518_0)
			local var_518_0 = "SS1309"

			if arg_515_1.bgs_[var_518_0] == nil then
				local var_518_1 = Object.Instantiate(arg_515_1.paintGo_)

				var_518_1:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. var_518_0)
				var_518_1.name = var_518_0
				var_518_1.transform.parent = arg_515_1.stage_.transform
				var_518_1.transform.localPosition = Vector3.New(0, 100, 0)
				arg_515_1.bgs_[var_518_0] = var_518_1
			end

			local var_518_2 = 1.31666666666667

			if var_518_2 < arg_515_1.time_ and arg_515_1.time_ <= var_518_2 + arg_518_0 then
				local var_518_3 = manager.ui.mainCamera.transform.localPosition
				local var_518_4 = Vector3.New(0, 0, 10) + Vector3.New(var_518_3.x, var_518_3.y, 0)
				local var_518_5 = arg_515_1.bgs_.SS1309

				var_518_5.transform.localPosition = var_518_4
				var_518_5.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_518_6 = var_518_5:GetComponent("SpriteRenderer")

				if var_518_6 and var_518_6.sprite then
					local var_518_7 = (var_518_5.transform.localPosition - var_518_3).z
					local var_518_8 = manager.ui.mainCameraCom_
					local var_518_9 = 2 * var_518_7 * Mathf.Tan(var_518_8.fieldOfView * 0.5 * Mathf.Deg2Rad)
					local var_518_10 = var_518_9 * var_518_8.aspect
					local var_518_11 = var_518_6.sprite.bounds.size.x
					local var_518_12 = var_518_6.sprite.bounds.size.y
					local var_518_13 = var_518_10 / var_518_11
					local var_518_14 = var_518_9 / var_518_12
					local var_518_15 = var_518_14 < var_518_13 and var_518_13 or var_518_14

					var_518_5.transform.localScale = Vector3.New(var_518_15, var_518_15, 0)
				end

				for iter_518_0, iter_518_1 in pairs(arg_515_1.bgs_) do
					if iter_518_0 ~= "SS1309" then
						iter_518_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_518_16 = 0

			if var_518_16 < arg_515_1.time_ and arg_515_1.time_ <= var_518_16 + arg_518_0 then
				arg_515_1.allBtn_.enabled = false
			end

			local var_518_17 = 0.3

			if arg_515_1.time_ >= var_518_16 + var_518_17 and arg_515_1.time_ < var_518_16 + var_518_17 + arg_518_0 then
				arg_515_1.allBtn_.enabled = true
			end

			local var_518_18 = 0

			if var_518_18 < arg_515_1.time_ and arg_515_1.time_ <= var_518_18 + arg_518_0 then
				arg_515_1.mask_.enabled = true
				arg_515_1.mask_.raycastTarget = true

				arg_515_1:SetGaussion(false)
			end

			local var_518_19 = 1.33333333333333

			if var_518_18 <= arg_515_1.time_ and arg_515_1.time_ < var_518_18 + var_518_19 then
				local var_518_20 = (arg_515_1.time_ - var_518_18) / var_518_19
				local var_518_21 = Color.New(0, 0, 0)

				var_518_21.a = Mathf.Lerp(0, 1, var_518_20)
				arg_515_1.mask_.color = var_518_21
			end

			if arg_515_1.time_ >= var_518_18 + var_518_19 and arg_515_1.time_ < var_518_18 + var_518_19 + arg_518_0 then
				local var_518_22 = Color.New(0, 0, 0)

				var_518_22.a = 1
				arg_515_1.mask_.color = var_518_22
			end

			local var_518_23 = 1.33333333333333

			if var_518_23 < arg_515_1.time_ and arg_515_1.time_ <= var_518_23 + arg_518_0 then
				arg_515_1.mask_.enabled = true
				arg_515_1.mask_.raycastTarget = true

				arg_515_1:SetGaussion(false)
			end

			local var_518_24 = 2

			if var_518_23 <= arg_515_1.time_ and arg_515_1.time_ < var_518_23 + var_518_24 then
				local var_518_25 = (arg_515_1.time_ - var_518_23) / var_518_24
				local var_518_26 = Color.New(0, 0, 0)

				var_518_26.a = Mathf.Lerp(1, 0, var_518_25)
				arg_515_1.mask_.color = var_518_26
			end

			if arg_515_1.time_ >= var_518_23 + var_518_24 and arg_515_1.time_ < var_518_23 + var_518_24 + arg_518_0 then
				local var_518_27 = Color.New(0, 0, 0)
				local var_518_28 = 0

				arg_515_1.mask_.enabled = false
				var_518_27.a = var_518_28
				arg_515_1.mask_.color = var_518_27
			end

			local var_518_29 = arg_515_1.bgs_.SS1309.transform
			local var_518_30 = 1.33333333333333

			if var_518_30 < arg_515_1.time_ and arg_515_1.time_ <= var_518_30 + arg_518_0 then
				arg_515_1.var_.moveOldPosSS1309 = var_518_29.localPosition
			end

			local var_518_31 = 0.001

			if var_518_30 <= arg_515_1.time_ and arg_515_1.time_ < var_518_30 + var_518_31 then
				local var_518_32 = (arg_515_1.time_ - var_518_30) / var_518_31
				local var_518_33 = Vector3.New(0, 1, 10)

				var_518_29.localPosition = Vector3.Lerp(arg_515_1.var_.moveOldPosSS1309, var_518_33, var_518_32)
			end

			if arg_515_1.time_ >= var_518_30 + var_518_31 and arg_515_1.time_ < var_518_30 + var_518_31 + arg_518_0 then
				var_518_29.localPosition = Vector3.New(0, 1, 10)
			end

			local var_518_34 = arg_515_1.bgs_.SS1309.transform
			local var_518_35 = 1.35

			if var_518_35 < arg_515_1.time_ and arg_515_1.time_ <= var_518_35 + arg_518_0 then
				arg_515_1.var_.moveOldPosSS1309 = var_518_34.localPosition
			end

			local var_518_36 = 2.15

			if var_518_35 <= arg_515_1.time_ and arg_515_1.time_ < var_518_35 + var_518_36 then
				local var_518_37 = (arg_515_1.time_ - var_518_35) / var_518_36
				local var_518_38 = Vector3.New(0, 1, 9)

				var_518_34.localPosition = Vector3.Lerp(arg_515_1.var_.moveOldPosSS1309, var_518_38, var_518_37)
			end

			if arg_515_1.time_ >= var_518_35 + var_518_36 and arg_515_1.time_ < var_518_35 + var_518_36 + arg_518_0 then
				var_518_34.localPosition = Vector3.New(0, 1, 9)
			end

			local var_518_39 = manager.ui.mainCamera.transform
			local var_518_40 = 1.33333333333333

			if var_518_40 < arg_515_1.time_ and arg_515_1.time_ <= var_518_40 + arg_518_0 then
				local var_518_41 = arg_515_1.var_.effectheliesihuoyan1
				local var_518_42
				local var_518_43 = var_518_39

				if not var_518_41 then
					var_518_41 = Object.Instantiate(Asset.Load("Effect/Scene/fx_ui_red"), var_518_43)
					var_518_41.name = "heliesihuoyan1"
					arg_515_1.var_.effectheliesihuoyan1 = var_518_41
				else
					var_518_41.transform:SetParent(var_518_43)
				end

				var_518_41.transform.localPosition = Vector3.New(0, 0, 0.44)
				var_518_41.transform.localRotation = Quaternion.Euler(0, 0, 0)
			end

			local var_518_44 = 0
			local var_518_45 = 1

			if var_518_44 < arg_515_1.time_ and arg_515_1.time_ <= var_518_44 + arg_518_0 then
				local var_518_46 = "play"
				local var_518_47 = "effect"

				arg_515_1:AudioAction(var_518_46, var_518_47, "se_story_8", "se_story_8_fire", "")
			end

			if arg_515_1.frameCnt_ <= 1 then
				arg_515_1.dialog_:SetActive(false)
			end

			local var_518_48 = 3.5
			local var_518_49 = 0.6

			if var_518_48 < arg_515_1.time_ and arg_515_1.time_ <= var_518_48 + arg_518_0 then
				arg_515_1.talkMaxDuration = 0

				arg_515_1.dialog_:SetActive(true)

				arg_515_1.dialogCg_.alpha = 0

				local var_518_50 = LeanTween.value(arg_515_1.dialog_, 0, 1, 0.3)

				var_518_50:setOnUpdate(LuaHelper.FloatAction(function(arg_519_0)
					arg_515_1.dialogCg_.alpha = arg_519_0
				end))
				var_518_50:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_515_1.dialog_)
					var_518_50:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_515_1.duration_ = arg_515_1.duration_ + 0.3

				SetActive(arg_515_1.leftNameGo_, true)

				local var_518_51 = arg_515_1:FormatText(StoryNameCfg[996].name)

				arg_515_1.leftNameTxt_.text = var_518_51

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_515_1.leftNameTxt_.transform)

				arg_515_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_515_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_515_1:RecordName(arg_515_1.leftNameTxt_.text)
				SetActive(arg_515_1.iconTrs_.gameObject, false)
				arg_515_1.callingController_:SetSelectedState("normal")

				local var_518_52 = arg_515_1:GetWordFromCfg(413141122)
				local var_518_53 = arg_515_1:FormatText(var_518_52.content)

				arg_515_1.text_.text = var_518_53

				LuaForUtil.ClearLinePrefixSymbol(arg_515_1.text_)

				local var_518_54 = 24
				local var_518_55 = utf8.len(var_518_53)
				local var_518_56 = var_518_54 <= 0 and var_518_49 or var_518_49 * (var_518_55 / var_518_54)

				if var_518_56 > 0 and var_518_49 < var_518_56 then
					arg_515_1.talkMaxDuration = var_518_56
					var_518_48 = var_518_48 + 0.3

					if var_518_56 + var_518_48 > arg_515_1.duration_ then
						arg_515_1.duration_ = var_518_56 + var_518_48
					end
				end

				arg_515_1.text_.text = var_518_53
				arg_515_1.typewritter.percent = 0

				arg_515_1.typewritter:SetDirty()
				arg_515_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_413141", "413141122", "story_v_out_413141.awb") ~= 0 then
					local var_518_57 = manager.audio:GetVoiceLength("story_v_out_413141", "413141122", "story_v_out_413141.awb") / 1000

					if var_518_57 + var_518_48 > arg_515_1.duration_ then
						arg_515_1.duration_ = var_518_57 + var_518_48
					end

					if var_518_52.prefab_name ~= "" and arg_515_1.actors_[var_518_52.prefab_name] ~= nil then
						local var_518_58 = LuaForUtil.PlayVoiceWithCriLipsync(arg_515_1.actors_[var_518_52.prefab_name].transform, "story_v_out_413141", "413141122", "story_v_out_413141.awb")

						arg_515_1:RecordAudio("413141122", var_518_58)
						arg_515_1:RecordAudio("413141122", var_518_58)
					else
						arg_515_1:AudioAction("play", "voice", "story_v_out_413141", "413141122", "story_v_out_413141.awb")
					end

					arg_515_1:RecordHistoryTalkVoice("story_v_out_413141", "413141122", "story_v_out_413141.awb")
				end

				arg_515_1:RecordContent(arg_515_1.text_.text)
			end

			local var_518_59 = var_518_48 + 0.3
			local var_518_60 = math.max(var_518_49, arg_515_1.talkMaxDuration)

			if var_518_59 <= arg_515_1.time_ and arg_515_1.time_ < var_518_59 + var_518_60 then
				arg_515_1.typewritter.percent = (arg_515_1.time_ - var_518_59) / var_518_60

				arg_515_1.typewritter:SetDirty()
			end

			if arg_515_1.time_ >= var_518_59 + var_518_60 and arg_515_1.time_ < var_518_59 + var_518_60 + arg_518_0 then
				arg_515_1.typewritter.percent = 1

				arg_515_1.typewritter:SetDirty()
				arg_515_1:ShowNextGo(true)
			end
		end

		arg_515_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "SS1309",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.0166666666666667,
				className = "StoryMoveNode",
				startTime = 1.33333333333333,
				actorType = StoryPlayerConst.ACTOR_TYPE.Background
			},
			{
				assetPath = "",
				actorName = "SS1309",
				changeDisplayLayer = false,
				needEase = false,
				duration = 2.15,
				className = "StoryMoveNode",
				startTime = 1.35,
				actorType = StoryPlayerConst.ACTOR_TYPE.Background
			}
		}

		arg_515_1:InitPlayNodeList()
	end,
	Play413141123 = function(arg_521_0, arg_521_1)
		arg_521_1.time_ = 0
		arg_521_1.frameCnt_ = 0
		arg_521_1.state_ = "playing"
		arg_521_1.curTalkId_ = 413141123
		arg_521_1.duration_ = 5

		SetActive(arg_521_1.tipsGo_, false)

		function arg_521_1.onSingleLineFinish_()
			arg_521_1.onSingleLineUpdate_ = nil
			arg_521_1.onSingleLineFinish_ = nil
			arg_521_1.state_ = "waiting"
		end

		function arg_521_1.playNext_(arg_523_0)
			if arg_523_0 == 1 then
				arg_521_0:Play413141124(arg_521_1)
			end
		end

		function arg_521_1.onSingleLineUpdate_(arg_524_0)
			local var_524_0 = 0.133333333333333
			local var_524_1 = 0.866666666666667

			if var_524_0 < arg_521_1.time_ and arg_521_1.time_ <= var_524_0 + arg_524_0 then
				local var_524_2 = "play"
				local var_524_3 = "effect"

				arg_521_1:AudioAction(var_524_2, var_524_3, "se_story_122_03", "se_story_122_03_arrow1", "")
			end

			local var_524_4 = 0
			local var_524_5 = 0.525

			if var_524_4 < arg_521_1.time_ and arg_521_1.time_ <= var_524_4 + arg_524_0 then
				arg_521_1.talkMaxDuration = 0
				arg_521_1.dialogCg_.alpha = 1

				arg_521_1.dialog_:SetActive(true)
				SetActive(arg_521_1.leftNameGo_, false)

				arg_521_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_521_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_521_1:RecordName(arg_521_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_521_1.iconTrs_.gameObject, false)
				arg_521_1.callingController_:SetSelectedState("normal")

				local var_524_6 = arg_521_1:GetWordFromCfg(413141123)
				local var_524_7 = arg_521_1:FormatText(var_524_6.content)

				arg_521_1.text_.text = var_524_7

				LuaForUtil.ClearLinePrefixSymbol(arg_521_1.text_)

				local var_524_8 = 21
				local var_524_9 = utf8.len(var_524_7)
				local var_524_10 = var_524_8 <= 0 and var_524_5 or var_524_5 * (var_524_9 / var_524_8)

				if var_524_10 > 0 and var_524_5 < var_524_10 then
					arg_521_1.talkMaxDuration = var_524_10

					if var_524_10 + var_524_4 > arg_521_1.duration_ then
						arg_521_1.duration_ = var_524_10 + var_524_4
					end
				end

				arg_521_1.text_.text = var_524_7
				arg_521_1.typewritter.percent = 0

				arg_521_1.typewritter:SetDirty()
				arg_521_1:ShowNextGo(false)
				arg_521_1:RecordContent(arg_521_1.text_.text)
			end

			local var_524_11 = math.max(var_524_5, arg_521_1.talkMaxDuration)

			if var_524_4 <= arg_521_1.time_ and arg_521_1.time_ < var_524_4 + var_524_11 then
				arg_521_1.typewritter.percent = (arg_521_1.time_ - var_524_4) / var_524_11

				arg_521_1.typewritter:SetDirty()
			end

			if arg_521_1.time_ >= var_524_4 + var_524_11 and arg_521_1.time_ < var_524_4 + var_524_11 + arg_524_0 then
				arg_521_1.typewritter.percent = 1

				arg_521_1.typewritter:SetDirty()
				arg_521_1:ShowNextGo(true)
			end
		end

		arg_521_1.nodeConfigList_ = {}

		arg_521_1:InitPlayNodeList()
	end,
	Play413141124 = function(arg_525_0, arg_525_1)
		arg_525_1.time_ = 0
		arg_525_1.frameCnt_ = 0
		arg_525_1.state_ = "playing"
		arg_525_1.curTalkId_ = 413141124
		arg_525_1.duration_ = 4.43

		local var_525_0 = {
			zh = 4.433,
			ja = 3.8
		}
		local var_525_1 = manager.audio:GetLocalizationFlag()

		if var_525_0[var_525_1] ~= nil then
			arg_525_1.duration_ = var_525_0[var_525_1]
		end

		SetActive(arg_525_1.tipsGo_, false)

		function arg_525_1.onSingleLineFinish_()
			arg_525_1.onSingleLineUpdate_ = nil
			arg_525_1.onSingleLineFinish_ = nil
			arg_525_1.state_ = "waiting"
		end

		function arg_525_1.playNext_(arg_527_0)
			if arg_527_0 == 1 then
				arg_525_0:Play413141125(arg_525_1)
			end
		end

		function arg_525_1.onSingleLineUpdate_(arg_528_0)
			local var_528_0 = 0
			local var_528_1 = 0.275

			if var_528_0 < arg_525_1.time_ and arg_525_1.time_ <= var_528_0 + arg_528_0 then
				arg_525_1.talkMaxDuration = 0
				arg_525_1.dialogCg_.alpha = 1

				arg_525_1.dialog_:SetActive(true)
				SetActive(arg_525_1.leftNameGo_, true)

				local var_528_2 = arg_525_1:FormatText(StoryNameCfg[996].name)

				arg_525_1.leftNameTxt_.text = var_528_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_525_1.leftNameTxt_.transform)

				arg_525_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_525_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_525_1:RecordName(arg_525_1.leftNameTxt_.text)
				SetActive(arg_525_1.iconTrs_.gameObject, false)
				arg_525_1.callingController_:SetSelectedState("normal")

				local var_528_3 = arg_525_1:GetWordFromCfg(413141124)
				local var_528_4 = arg_525_1:FormatText(var_528_3.content)

				arg_525_1.text_.text = var_528_4

				LuaForUtil.ClearLinePrefixSymbol(arg_525_1.text_)

				local var_528_5 = 11
				local var_528_6 = utf8.len(var_528_4)
				local var_528_7 = var_528_5 <= 0 and var_528_1 or var_528_1 * (var_528_6 / var_528_5)

				if var_528_7 > 0 and var_528_1 < var_528_7 then
					arg_525_1.talkMaxDuration = var_528_7

					if var_528_7 + var_528_0 > arg_525_1.duration_ then
						arg_525_1.duration_ = var_528_7 + var_528_0
					end
				end

				arg_525_1.text_.text = var_528_4
				arg_525_1.typewritter.percent = 0

				arg_525_1.typewritter:SetDirty()
				arg_525_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_413141", "413141124", "story_v_out_413141.awb") ~= 0 then
					local var_528_8 = manager.audio:GetVoiceLength("story_v_out_413141", "413141124", "story_v_out_413141.awb") / 1000

					if var_528_8 + var_528_0 > arg_525_1.duration_ then
						arg_525_1.duration_ = var_528_8 + var_528_0
					end

					if var_528_3.prefab_name ~= "" and arg_525_1.actors_[var_528_3.prefab_name] ~= nil then
						local var_528_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_525_1.actors_[var_528_3.prefab_name].transform, "story_v_out_413141", "413141124", "story_v_out_413141.awb")

						arg_525_1:RecordAudio("413141124", var_528_9)
						arg_525_1:RecordAudio("413141124", var_528_9)
					else
						arg_525_1:AudioAction("play", "voice", "story_v_out_413141", "413141124", "story_v_out_413141.awb")
					end

					arg_525_1:RecordHistoryTalkVoice("story_v_out_413141", "413141124", "story_v_out_413141.awb")
				end

				arg_525_1:RecordContent(arg_525_1.text_.text)
			end

			local var_528_10 = math.max(var_528_1, arg_525_1.talkMaxDuration)

			if var_528_0 <= arg_525_1.time_ and arg_525_1.time_ < var_528_0 + var_528_10 then
				arg_525_1.typewritter.percent = (arg_525_1.time_ - var_528_0) / var_528_10

				arg_525_1.typewritter:SetDirty()
			end

			if arg_525_1.time_ >= var_528_0 + var_528_10 and arg_525_1.time_ < var_528_0 + var_528_10 + arg_528_0 then
				arg_525_1.typewritter.percent = 1

				arg_525_1.typewritter:SetDirty()
				arg_525_1:ShowNextGo(true)
			end
		end

		arg_525_1.nodeConfigList_ = {}

		arg_525_1:InitPlayNodeList()
	end,
	Play413141125 = function(arg_529_0, arg_529_1)
		arg_529_1.time_ = 0
		arg_529_1.frameCnt_ = 0
		arg_529_1.state_ = "playing"
		arg_529_1.curTalkId_ = 413141125
		arg_529_1.duration_ = 5

		SetActive(arg_529_1.tipsGo_, false)

		function arg_529_1.onSingleLineFinish_()
			arg_529_1.onSingleLineUpdate_ = nil
			arg_529_1.onSingleLineFinish_ = nil
			arg_529_1.state_ = "waiting"
		end

		function arg_529_1.playNext_(arg_531_0)
			if arg_531_0 == 1 then
				arg_529_0:Play413141126(arg_529_1)
			end
		end

		function arg_529_1.onSingleLineUpdate_(arg_532_0)
			local var_532_0 = 0
			local var_532_1 = 0.725

			if var_532_0 < arg_529_1.time_ and arg_529_1.time_ <= var_532_0 + arg_532_0 then
				arg_529_1.talkMaxDuration = 0
				arg_529_1.dialogCg_.alpha = 1

				arg_529_1.dialog_:SetActive(true)
				SetActive(arg_529_1.leftNameGo_, false)

				arg_529_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_529_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_529_1:RecordName(arg_529_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_529_1.iconTrs_.gameObject, false)
				arg_529_1.callingController_:SetSelectedState("normal")

				local var_532_2 = arg_529_1:GetWordFromCfg(413141125)
				local var_532_3 = arg_529_1:FormatText(var_532_2.content)

				arg_529_1.text_.text = var_532_3

				LuaForUtil.ClearLinePrefixSymbol(arg_529_1.text_)

				local var_532_4 = 29
				local var_532_5 = utf8.len(var_532_3)
				local var_532_6 = var_532_4 <= 0 and var_532_1 or var_532_1 * (var_532_5 / var_532_4)

				if var_532_6 > 0 and var_532_1 < var_532_6 then
					arg_529_1.talkMaxDuration = var_532_6

					if var_532_6 + var_532_0 > arg_529_1.duration_ then
						arg_529_1.duration_ = var_532_6 + var_532_0
					end
				end

				arg_529_1.text_.text = var_532_3
				arg_529_1.typewritter.percent = 0

				arg_529_1.typewritter:SetDirty()
				arg_529_1:ShowNextGo(false)
				arg_529_1:RecordContent(arg_529_1.text_.text)
			end

			local var_532_7 = math.max(var_532_1, arg_529_1.talkMaxDuration)

			if var_532_0 <= arg_529_1.time_ and arg_529_1.time_ < var_532_0 + var_532_7 then
				arg_529_1.typewritter.percent = (arg_529_1.time_ - var_532_0) / var_532_7

				arg_529_1.typewritter:SetDirty()
			end

			if arg_529_1.time_ >= var_532_0 + var_532_7 and arg_529_1.time_ < var_532_0 + var_532_7 + arg_532_0 then
				arg_529_1.typewritter.percent = 1

				arg_529_1.typewritter:SetDirty()
				arg_529_1:ShowNextGo(true)
			end
		end

		arg_529_1.nodeConfigList_ = {}

		arg_529_1:InitPlayNodeList()
	end,
	Play413141126 = function(arg_533_0, arg_533_1)
		arg_533_1.time_ = 0
		arg_533_1.frameCnt_ = 0
		arg_533_1.state_ = "playing"
		arg_533_1.curTalkId_ = 413141126
		arg_533_1.duration_ = 9.5

		local var_533_0 = {
			zh = 7.133,
			ja = 9.5
		}
		local var_533_1 = manager.audio:GetLocalizationFlag()

		if var_533_0[var_533_1] ~= nil then
			arg_533_1.duration_ = var_533_0[var_533_1]
		end

		SetActive(arg_533_1.tipsGo_, false)

		function arg_533_1.onSingleLineFinish_()
			arg_533_1.onSingleLineUpdate_ = nil
			arg_533_1.onSingleLineFinish_ = nil
			arg_533_1.state_ = "waiting"
		end

		function arg_533_1.playNext_(arg_535_0)
			if arg_535_0 == 1 then
				arg_533_0:Play413141127(arg_533_1)
			end
		end

		function arg_533_1.onSingleLineUpdate_(arg_536_0)
			local var_536_0 = 0
			local var_536_1 = 0.525

			if var_536_0 < arg_533_1.time_ and arg_533_1.time_ <= var_536_0 + arg_536_0 then
				arg_533_1.talkMaxDuration = 0
				arg_533_1.dialogCg_.alpha = 1

				arg_533_1.dialog_:SetActive(true)
				SetActive(arg_533_1.leftNameGo_, true)

				local var_536_2 = arg_533_1:FormatText(StoryNameCfg[996].name)

				arg_533_1.leftNameTxt_.text = var_536_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_533_1.leftNameTxt_.transform)

				arg_533_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_533_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_533_1:RecordName(arg_533_1.leftNameTxt_.text)
				SetActive(arg_533_1.iconTrs_.gameObject, false)
				arg_533_1.callingController_:SetSelectedState("normal")

				local var_536_3 = arg_533_1:GetWordFromCfg(413141126)
				local var_536_4 = arg_533_1:FormatText(var_536_3.content)

				arg_533_1.text_.text = var_536_4

				LuaForUtil.ClearLinePrefixSymbol(arg_533_1.text_)

				local var_536_5 = 21
				local var_536_6 = utf8.len(var_536_4)
				local var_536_7 = var_536_5 <= 0 and var_536_1 or var_536_1 * (var_536_6 / var_536_5)

				if var_536_7 > 0 and var_536_1 < var_536_7 then
					arg_533_1.talkMaxDuration = var_536_7

					if var_536_7 + var_536_0 > arg_533_1.duration_ then
						arg_533_1.duration_ = var_536_7 + var_536_0
					end
				end

				arg_533_1.text_.text = var_536_4
				arg_533_1.typewritter.percent = 0

				arg_533_1.typewritter:SetDirty()
				arg_533_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_413141", "413141126", "story_v_out_413141.awb") ~= 0 then
					local var_536_8 = manager.audio:GetVoiceLength("story_v_out_413141", "413141126", "story_v_out_413141.awb") / 1000

					if var_536_8 + var_536_0 > arg_533_1.duration_ then
						arg_533_1.duration_ = var_536_8 + var_536_0
					end

					if var_536_3.prefab_name ~= "" and arg_533_1.actors_[var_536_3.prefab_name] ~= nil then
						local var_536_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_533_1.actors_[var_536_3.prefab_name].transform, "story_v_out_413141", "413141126", "story_v_out_413141.awb")

						arg_533_1:RecordAudio("413141126", var_536_9)
						arg_533_1:RecordAudio("413141126", var_536_9)
					else
						arg_533_1:AudioAction("play", "voice", "story_v_out_413141", "413141126", "story_v_out_413141.awb")
					end

					arg_533_1:RecordHistoryTalkVoice("story_v_out_413141", "413141126", "story_v_out_413141.awb")
				end

				arg_533_1:RecordContent(arg_533_1.text_.text)
			end

			local var_536_10 = math.max(var_536_1, arg_533_1.talkMaxDuration)

			if var_536_0 <= arg_533_1.time_ and arg_533_1.time_ < var_536_0 + var_536_10 then
				arg_533_1.typewritter.percent = (arg_533_1.time_ - var_536_0) / var_536_10

				arg_533_1.typewritter:SetDirty()
			end

			if arg_533_1.time_ >= var_536_0 + var_536_10 and arg_533_1.time_ < var_536_0 + var_536_10 + arg_536_0 then
				arg_533_1.typewritter.percent = 1

				arg_533_1.typewritter:SetDirty()
				arg_533_1:ShowNextGo(true)
			end
		end

		arg_533_1.nodeConfigList_ = {}

		arg_533_1:InitPlayNodeList()
	end,
	Play413141127 = function(arg_537_0, arg_537_1)
		arg_537_1.time_ = 0
		arg_537_1.frameCnt_ = 0
		arg_537_1.state_ = "playing"
		arg_537_1.curTalkId_ = 413141127
		arg_537_1.duration_ = 2.57

		local var_537_0 = {
			zh = 2.566,
			ja = 2.2
		}
		local var_537_1 = manager.audio:GetLocalizationFlag()

		if var_537_0[var_537_1] ~= nil then
			arg_537_1.duration_ = var_537_0[var_537_1]
		end

		SetActive(arg_537_1.tipsGo_, false)

		function arg_537_1.onSingleLineFinish_()
			arg_537_1.onSingleLineUpdate_ = nil
			arg_537_1.onSingleLineFinish_ = nil
			arg_537_1.state_ = "waiting"
		end

		function arg_537_1.playNext_(arg_539_0)
			if arg_539_0 == 1 then
				arg_537_0:Play413141128(arg_537_1)
			end
		end

		function arg_537_1.onSingleLineUpdate_(arg_540_0)
			local var_540_0 = 0
			local var_540_1 = 0.2

			if var_540_0 < arg_537_1.time_ and arg_537_1.time_ <= var_540_0 + arg_540_0 then
				arg_537_1.talkMaxDuration = 0
				arg_537_1.dialogCg_.alpha = 1

				arg_537_1.dialog_:SetActive(true)
				SetActive(arg_537_1.leftNameGo_, true)

				local var_540_2 = arg_537_1:FormatText(StoryNameCfg[28].name)

				arg_537_1.leftNameTxt_.text = var_540_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_537_1.leftNameTxt_.transform)

				arg_537_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_537_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_537_1:RecordName(arg_537_1.leftNameTxt_.text)
				SetActive(arg_537_1.iconTrs_.gameObject, true)
				arg_537_1.iconController_:SetSelectedState("hero")

				arg_537_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_10093_split_5")

				arg_537_1.callingController_:SetSelectedState("normal")

				arg_537_1.keyicon_.color = Color.New(1, 1, 1)
				arg_537_1.icon_.color = Color.New(1, 1, 1)

				local var_540_3 = arg_537_1:GetWordFromCfg(413141127)
				local var_540_4 = arg_537_1:FormatText(var_540_3.content)

				arg_537_1.text_.text = var_540_4

				LuaForUtil.ClearLinePrefixSymbol(arg_537_1.text_)

				local var_540_5 = 8
				local var_540_6 = utf8.len(var_540_4)
				local var_540_7 = var_540_5 <= 0 and var_540_1 or var_540_1 * (var_540_6 / var_540_5)

				if var_540_7 > 0 and var_540_1 < var_540_7 then
					arg_537_1.talkMaxDuration = var_540_7

					if var_540_7 + var_540_0 > arg_537_1.duration_ then
						arg_537_1.duration_ = var_540_7 + var_540_0
					end
				end

				arg_537_1.text_.text = var_540_4
				arg_537_1.typewritter.percent = 0

				arg_537_1.typewritter:SetDirty()
				arg_537_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_413141", "413141127", "story_v_out_413141.awb") ~= 0 then
					local var_540_8 = manager.audio:GetVoiceLength("story_v_out_413141", "413141127", "story_v_out_413141.awb") / 1000

					if var_540_8 + var_540_0 > arg_537_1.duration_ then
						arg_537_1.duration_ = var_540_8 + var_540_0
					end

					if var_540_3.prefab_name ~= "" and arg_537_1.actors_[var_540_3.prefab_name] ~= nil then
						local var_540_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_537_1.actors_[var_540_3.prefab_name].transform, "story_v_out_413141", "413141127", "story_v_out_413141.awb")

						arg_537_1:RecordAudio("413141127", var_540_9)
						arg_537_1:RecordAudio("413141127", var_540_9)
					else
						arg_537_1:AudioAction("play", "voice", "story_v_out_413141", "413141127", "story_v_out_413141.awb")
					end

					arg_537_1:RecordHistoryTalkVoice("story_v_out_413141", "413141127", "story_v_out_413141.awb")
				end

				arg_537_1:RecordContent(arg_537_1.text_.text)
			end

			local var_540_10 = math.max(var_540_1, arg_537_1.talkMaxDuration)

			if var_540_0 <= arg_537_1.time_ and arg_537_1.time_ < var_540_0 + var_540_10 then
				arg_537_1.typewritter.percent = (arg_537_1.time_ - var_540_0) / var_540_10

				arg_537_1.typewritter:SetDirty()
			end

			if arg_537_1.time_ >= var_540_0 + var_540_10 and arg_537_1.time_ < var_540_0 + var_540_10 + arg_540_0 then
				arg_537_1.typewritter.percent = 1

				arg_537_1.typewritter:SetDirty()
				arg_537_1:ShowNextGo(true)
			end
		end

		arg_537_1.nodeConfigList_ = {}

		arg_537_1:InitPlayNodeList()
	end,
	Play413141128 = function(arg_541_0, arg_541_1)
		arg_541_1.time_ = 0
		arg_541_1.frameCnt_ = 0
		arg_541_1.state_ = "playing"
		arg_541_1.curTalkId_ = 413141128
		arg_541_1.duration_ = 2.87

		local var_541_0 = {
			zh = 2.866,
			ja = 2.833
		}
		local var_541_1 = manager.audio:GetLocalizationFlag()

		if var_541_0[var_541_1] ~= nil then
			arg_541_1.duration_ = var_541_0[var_541_1]
		end

		SetActive(arg_541_1.tipsGo_, false)

		function arg_541_1.onSingleLineFinish_()
			arg_541_1.onSingleLineUpdate_ = nil
			arg_541_1.onSingleLineFinish_ = nil
			arg_541_1.state_ = "waiting"
		end

		function arg_541_1.playNext_(arg_543_0)
			if arg_543_0 == 1 then
				arg_541_0:Play413141129(arg_541_1)
			end
		end

		function arg_541_1.onSingleLineUpdate_(arg_544_0)
			local var_544_0 = 0
			local var_544_1 = 0.175

			if var_544_0 < arg_541_1.time_ and arg_541_1.time_ <= var_544_0 + arg_544_0 then
				arg_541_1.talkMaxDuration = 0
				arg_541_1.dialogCg_.alpha = 1

				arg_541_1.dialog_:SetActive(true)
				SetActive(arg_541_1.leftNameGo_, true)

				local var_544_2 = arg_541_1:FormatText(StoryNameCfg[996].name)

				arg_541_1.leftNameTxt_.text = var_544_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_541_1.leftNameTxt_.transform)

				arg_541_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_541_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_541_1:RecordName(arg_541_1.leftNameTxt_.text)
				SetActive(arg_541_1.iconTrs_.gameObject, false)
				arg_541_1.callingController_:SetSelectedState("normal")

				local var_544_3 = arg_541_1:GetWordFromCfg(413141128)
				local var_544_4 = arg_541_1:FormatText(var_544_3.content)

				arg_541_1.text_.text = var_544_4

				LuaForUtil.ClearLinePrefixSymbol(arg_541_1.text_)

				local var_544_5 = 7
				local var_544_6 = utf8.len(var_544_4)
				local var_544_7 = var_544_5 <= 0 and var_544_1 or var_544_1 * (var_544_6 / var_544_5)

				if var_544_7 > 0 and var_544_1 < var_544_7 then
					arg_541_1.talkMaxDuration = var_544_7

					if var_544_7 + var_544_0 > arg_541_1.duration_ then
						arg_541_1.duration_ = var_544_7 + var_544_0
					end
				end

				arg_541_1.text_.text = var_544_4
				arg_541_1.typewritter.percent = 0

				arg_541_1.typewritter:SetDirty()
				arg_541_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_413141", "413141128", "story_v_out_413141.awb") ~= 0 then
					local var_544_8 = manager.audio:GetVoiceLength("story_v_out_413141", "413141128", "story_v_out_413141.awb") / 1000

					if var_544_8 + var_544_0 > arg_541_1.duration_ then
						arg_541_1.duration_ = var_544_8 + var_544_0
					end

					if var_544_3.prefab_name ~= "" and arg_541_1.actors_[var_544_3.prefab_name] ~= nil then
						local var_544_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_541_1.actors_[var_544_3.prefab_name].transform, "story_v_out_413141", "413141128", "story_v_out_413141.awb")

						arg_541_1:RecordAudio("413141128", var_544_9)
						arg_541_1:RecordAudio("413141128", var_544_9)
					else
						arg_541_1:AudioAction("play", "voice", "story_v_out_413141", "413141128", "story_v_out_413141.awb")
					end

					arg_541_1:RecordHistoryTalkVoice("story_v_out_413141", "413141128", "story_v_out_413141.awb")
				end

				arg_541_1:RecordContent(arg_541_1.text_.text)
			end

			local var_544_10 = math.max(var_544_1, arg_541_1.talkMaxDuration)

			if var_544_0 <= arg_541_1.time_ and arg_541_1.time_ < var_544_0 + var_544_10 then
				arg_541_1.typewritter.percent = (arg_541_1.time_ - var_544_0) / var_544_10

				arg_541_1.typewritter:SetDirty()
			end

			if arg_541_1.time_ >= var_544_0 + var_544_10 and arg_541_1.time_ < var_544_0 + var_544_10 + arg_544_0 then
				arg_541_1.typewritter.percent = 1

				arg_541_1.typewritter:SetDirty()
				arg_541_1:ShowNextGo(true)
			end
		end

		arg_541_1.nodeConfigList_ = {}

		arg_541_1:InitPlayNodeList()
	end,
	Play413141129 = function(arg_545_0, arg_545_1)
		arg_545_1.time_ = 0
		arg_545_1.frameCnt_ = 0
		arg_545_1.state_ = "playing"
		arg_545_1.curTalkId_ = 413141129
		arg_545_1.duration_ = 6.47

		SetActive(arg_545_1.tipsGo_, false)

		function arg_545_1.onSingleLineFinish_()
			arg_545_1.onSingleLineUpdate_ = nil
			arg_545_1.onSingleLineFinish_ = nil
			arg_545_1.state_ = "waiting"
		end

		function arg_545_1.playNext_(arg_547_0)
			if arg_547_0 == 1 then
				arg_545_0:Play413141130(arg_545_1)
			end
		end

		function arg_545_1.onSingleLineUpdate_(arg_548_0)
			local var_548_0 = arg_545_1.bgs_.SS1309.transform
			local var_548_1 = 0

			if var_548_1 < arg_545_1.time_ and arg_545_1.time_ <= var_548_1 + arg_548_0 then
				arg_545_1.var_.moveOldPosSS1309 = var_548_0.localPosition
			end

			local var_548_2 = 0.001

			if var_548_1 <= arg_545_1.time_ and arg_545_1.time_ < var_548_1 + var_548_2 then
				local var_548_3 = (arg_545_1.time_ - var_548_1) / var_548_2
				local var_548_4 = Vector3.New(0, 1, 9)

				var_548_0.localPosition = Vector3.Lerp(arg_545_1.var_.moveOldPosSS1309, var_548_4, var_548_3)
			end

			if arg_545_1.time_ >= var_548_1 + var_548_2 and arg_545_1.time_ < var_548_1 + var_548_2 + arg_548_0 then
				var_548_0.localPosition = Vector3.New(0, 1, 9)
			end

			local var_548_5 = arg_545_1.bgs_.SS1309.transform
			local var_548_6 = 0.0166666666666667

			if var_548_6 < arg_545_1.time_ and arg_545_1.time_ <= var_548_6 + arg_548_0 then
				arg_545_1.var_.moveOldPosSS1309 = var_548_5.localPosition
			end

			local var_548_7 = 1.51666666666667

			if var_548_6 <= arg_545_1.time_ and arg_545_1.time_ < var_548_6 + var_548_7 then
				local var_548_8 = (arg_545_1.time_ - var_548_6) / var_548_7
				local var_548_9 = Vector3.New(0, 1, 10)

				var_548_5.localPosition = Vector3.Lerp(arg_545_1.var_.moveOldPosSS1309, var_548_9, var_548_8)
			end

			if arg_545_1.time_ >= var_548_6 + var_548_7 and arg_545_1.time_ < var_548_6 + var_548_7 + arg_548_0 then
				var_548_5.localPosition = Vector3.New(0, 1, 10)
			end

			local var_548_10 = manager.ui.mainCamera.transform
			local var_548_11 = 0

			if var_548_11 < arg_545_1.time_ and arg_545_1.time_ <= var_548_11 + arg_548_0 then
				arg_545_1.var_.shakeOldPos = var_548_10.localPosition
			end

			local var_548_12 = 0.6

			if var_548_11 <= arg_545_1.time_ and arg_545_1.time_ < var_548_11 + var_548_12 then
				local var_548_13 = (arg_545_1.time_ - var_548_11) / 0.066
				local var_548_14, var_548_15 = math.modf(var_548_13)

				var_548_10.localPosition = Vector3.New(var_548_15 * 0.13, var_548_15 * 0.13, var_548_15 * 0.13) + arg_545_1.var_.shakeOldPos
			end

			if arg_545_1.time_ >= var_548_11 + var_548_12 and arg_545_1.time_ < var_548_11 + var_548_12 + arg_548_0 then
				var_548_10.localPosition = arg_545_1.var_.shakeOldPos
			end

			local var_548_16 = 0

			if var_548_16 < arg_545_1.time_ and arg_545_1.time_ <= var_548_16 + arg_548_0 then
				arg_545_1.allBtn_.enabled = false
			end

			local var_548_17 = 1.53333333333333

			if arg_545_1.time_ >= var_548_16 + var_548_17 and arg_545_1.time_ < var_548_16 + var_548_17 + arg_548_0 then
				arg_545_1.allBtn_.enabled = true
			end

			if arg_545_1.frameCnt_ <= 1 then
				arg_545_1.dialog_:SetActive(false)
			end

			local var_548_18 = 1.46666666666667
			local var_548_19 = 0.8

			if var_548_18 < arg_545_1.time_ and arg_545_1.time_ <= var_548_18 + arg_548_0 then
				arg_545_1.talkMaxDuration = 0

				arg_545_1.dialog_:SetActive(true)

				arg_545_1.dialogCg_.alpha = 0

				local var_548_20 = LeanTween.value(arg_545_1.dialog_, 0, 1, 0.3)

				var_548_20:setOnUpdate(LuaHelper.FloatAction(function(arg_549_0)
					arg_545_1.dialogCg_.alpha = arg_549_0
				end))
				var_548_20:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_545_1.dialog_)
					var_548_20:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_545_1.duration_ = arg_545_1.duration_ + 0.3

				SetActive(arg_545_1.leftNameGo_, false)

				arg_545_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_545_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_545_1:RecordName(arg_545_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_545_1.iconTrs_.gameObject, false)
				arg_545_1.callingController_:SetSelectedState("normal")

				local var_548_21 = arg_545_1:GetWordFromCfg(413141129)
				local var_548_22 = arg_545_1:FormatText(var_548_21.content)

				arg_545_1.text_.text = var_548_22

				LuaForUtil.ClearLinePrefixSymbol(arg_545_1.text_)

				local var_548_23 = 32
				local var_548_24 = utf8.len(var_548_22)
				local var_548_25 = var_548_23 <= 0 and var_548_19 or var_548_19 * (var_548_24 / var_548_23)

				if var_548_25 > 0 and var_548_19 < var_548_25 then
					arg_545_1.talkMaxDuration = var_548_25
					var_548_18 = var_548_18 + 0.3

					if var_548_25 + var_548_18 > arg_545_1.duration_ then
						arg_545_1.duration_ = var_548_25 + var_548_18
					end
				end

				arg_545_1.text_.text = var_548_22
				arg_545_1.typewritter.percent = 0

				arg_545_1.typewritter:SetDirty()
				arg_545_1:ShowNextGo(false)
				arg_545_1:RecordContent(arg_545_1.text_.text)
			end

			local var_548_26 = var_548_18 + 0.3
			local var_548_27 = math.max(var_548_19, arg_545_1.talkMaxDuration)

			if var_548_26 <= arg_545_1.time_ and arg_545_1.time_ < var_548_26 + var_548_27 then
				arg_545_1.typewritter.percent = (arg_545_1.time_ - var_548_26) / var_548_27

				arg_545_1.typewritter:SetDirty()
			end

			if arg_545_1.time_ >= var_548_26 + var_548_27 and arg_545_1.time_ < var_548_26 + var_548_27 + arg_548_0 then
				arg_545_1.typewritter.percent = 1

				arg_545_1.typewritter:SetDirty()
				arg_545_1:ShowNextGo(true)
			end
		end

		arg_545_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "SS1309",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.0166666666666667,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Background
			},
			{
				assetPath = "",
				actorName = "SS1309",
				changeDisplayLayer = false,
				needEase = false,
				duration = 1.51666666666667,
				className = "StoryMoveNode",
				startTime = 0.0166666666666667,
				actorType = StoryPlayerConst.ACTOR_TYPE.Background
			}
		}

		arg_545_1:InitPlayNodeList()
	end,
	Play413141130 = function(arg_551_0, arg_551_1)
		arg_551_1.time_ = 0
		arg_551_1.frameCnt_ = 0
		arg_551_1.state_ = "playing"
		arg_551_1.curTalkId_ = 413141130
		arg_551_1.duration_ = 5

		SetActive(arg_551_1.tipsGo_, false)

		function arg_551_1.onSingleLineFinish_()
			arg_551_1.onSingleLineUpdate_ = nil
			arg_551_1.onSingleLineFinish_ = nil
			arg_551_1.state_ = "waiting"
		end

		function arg_551_1.playNext_(arg_553_0)
			if arg_553_0 == 1 then
				arg_551_0:Play413141131(arg_551_1)
			end
		end

		function arg_551_1.onSingleLineUpdate_(arg_554_0)
			local var_554_0 = 0
			local var_554_1 = 1.075

			if var_554_0 < arg_551_1.time_ and arg_551_1.time_ <= var_554_0 + arg_554_0 then
				arg_551_1.talkMaxDuration = 0
				arg_551_1.dialogCg_.alpha = 1

				arg_551_1.dialog_:SetActive(true)
				SetActive(arg_551_1.leftNameGo_, false)

				arg_551_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_551_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_551_1:RecordName(arg_551_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_551_1.iconTrs_.gameObject, false)
				arg_551_1.callingController_:SetSelectedState("normal")

				local var_554_2 = arg_551_1:GetWordFromCfg(413141130)
				local var_554_3 = arg_551_1:FormatText(var_554_2.content)

				arg_551_1.text_.text = var_554_3

				LuaForUtil.ClearLinePrefixSymbol(arg_551_1.text_)

				local var_554_4 = 43
				local var_554_5 = utf8.len(var_554_3)
				local var_554_6 = var_554_4 <= 0 and var_554_1 or var_554_1 * (var_554_5 / var_554_4)

				if var_554_6 > 0 and var_554_1 < var_554_6 then
					arg_551_1.talkMaxDuration = var_554_6

					if var_554_6 + var_554_0 > arg_551_1.duration_ then
						arg_551_1.duration_ = var_554_6 + var_554_0
					end
				end

				arg_551_1.text_.text = var_554_3
				arg_551_1.typewritter.percent = 0

				arg_551_1.typewritter:SetDirty()
				arg_551_1:ShowNextGo(false)
				arg_551_1:RecordContent(arg_551_1.text_.text)
			end

			local var_554_7 = math.max(var_554_1, arg_551_1.talkMaxDuration)

			if var_554_0 <= arg_551_1.time_ and arg_551_1.time_ < var_554_0 + var_554_7 then
				arg_551_1.typewritter.percent = (arg_551_1.time_ - var_554_0) / var_554_7

				arg_551_1.typewritter:SetDirty()
			end

			if arg_551_1.time_ >= var_554_0 + var_554_7 and arg_551_1.time_ < var_554_0 + var_554_7 + arg_554_0 then
				arg_551_1.typewritter.percent = 1

				arg_551_1.typewritter:SetDirty()
				arg_551_1:ShowNextGo(true)
			end
		end

		arg_551_1.nodeConfigList_ = {}

		arg_551_1:InitPlayNodeList()
	end,
	Play413141131 = function(arg_555_0, arg_555_1)
		arg_555_1.time_ = 0
		arg_555_1.frameCnt_ = 0
		arg_555_1.state_ = "playing"
		arg_555_1.curTalkId_ = 413141131
		arg_555_1.duration_ = 6.6

		local var_555_0 = {
			zh = 6.6,
			ja = 4.9
		}
		local var_555_1 = manager.audio:GetLocalizationFlag()

		if var_555_0[var_555_1] ~= nil then
			arg_555_1.duration_ = var_555_0[var_555_1]
		end

		SetActive(arg_555_1.tipsGo_, false)

		function arg_555_1.onSingleLineFinish_()
			arg_555_1.onSingleLineUpdate_ = nil
			arg_555_1.onSingleLineFinish_ = nil
			arg_555_1.state_ = "waiting"
		end

		function arg_555_1.playNext_(arg_557_0)
			if arg_557_0 == 1 then
				arg_555_0:Play413141132(arg_555_1)
			end
		end

		function arg_555_1.onSingleLineUpdate_(arg_558_0)
			local var_558_0 = "STblack"

			if arg_555_1.bgs_[var_558_0] == nil then
				local var_558_1 = Object.Instantiate(arg_555_1.paintGo_)

				var_558_1:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. var_558_0)
				var_558_1.name = var_558_0
				var_558_1.transform.parent = arg_555_1.stage_.transform
				var_558_1.transform.localPosition = Vector3.New(0, 100, 0)
				arg_555_1.bgs_[var_558_0] = var_558_1
			end

			local var_558_2 = 1.66666666666667

			if var_558_2 < arg_555_1.time_ and arg_555_1.time_ <= var_558_2 + arg_558_0 then
				local var_558_3 = manager.ui.mainCamera.transform.localPosition
				local var_558_4 = Vector3.New(0, 0, 10) + Vector3.New(var_558_3.x, var_558_3.y, 0)
				local var_558_5 = arg_555_1.bgs_.STblack

				var_558_5.transform.localPosition = var_558_4
				var_558_5.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_558_6 = var_558_5:GetComponent("SpriteRenderer")

				if var_558_6 and var_558_6.sprite then
					local var_558_7 = (var_558_5.transform.localPosition - var_558_3).z
					local var_558_8 = manager.ui.mainCameraCom_
					local var_558_9 = 2 * var_558_7 * Mathf.Tan(var_558_8.fieldOfView * 0.5 * Mathf.Deg2Rad)
					local var_558_10 = var_558_9 * var_558_8.aspect
					local var_558_11 = var_558_6.sprite.bounds.size.x
					local var_558_12 = var_558_6.sprite.bounds.size.y
					local var_558_13 = var_558_10 / var_558_11
					local var_558_14 = var_558_9 / var_558_12
					local var_558_15 = var_558_14 < var_558_13 and var_558_13 or var_558_14

					var_558_5.transform.localScale = Vector3.New(var_558_15, var_558_15, 0)
				end

				for iter_558_0, iter_558_1 in pairs(arg_555_1.bgs_) do
					if iter_558_0 ~= "STblack" then
						iter_558_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_558_16 = 0

			if var_558_16 < arg_555_1.time_ and arg_555_1.time_ <= var_558_16 + arg_558_0 then
				arg_555_1.mask_.enabled = true
				arg_555_1.mask_.raycastTarget = true

				arg_555_1:SetGaussion(false)
			end

			local var_558_17 = 1.66666666666667

			if var_558_16 <= arg_555_1.time_ and arg_555_1.time_ < var_558_16 + var_558_17 then
				local var_558_18 = (arg_555_1.time_ - var_558_16) / var_558_17
				local var_558_19 = Color.New(0, 0, 0)

				var_558_19.a = Mathf.Lerp(0, 1, var_558_18)
				arg_555_1.mask_.color = var_558_19
			end

			if arg_555_1.time_ >= var_558_16 + var_558_17 and arg_555_1.time_ < var_558_16 + var_558_17 + arg_558_0 then
				local var_558_20 = Color.New(0, 0, 0)

				var_558_20.a = 1
				arg_555_1.mask_.color = var_558_20
			end

			local var_558_21 = 1.66666666666667

			if var_558_21 < arg_555_1.time_ and arg_555_1.time_ <= var_558_21 + arg_558_0 then
				arg_555_1.mask_.enabled = true
				arg_555_1.mask_.raycastTarget = true

				arg_555_1:SetGaussion(false)
			end

			local var_558_22 = 0.733333333333333

			if var_558_21 <= arg_555_1.time_ and arg_555_1.time_ < var_558_21 + var_558_22 then
				local var_558_23 = (arg_555_1.time_ - var_558_21) / var_558_22
				local var_558_24 = Color.New(0, 0, 0)

				var_558_24.a = Mathf.Lerp(1, 0, var_558_23)
				arg_555_1.mask_.color = var_558_24
			end

			if arg_555_1.time_ >= var_558_21 + var_558_22 and arg_555_1.time_ < var_558_21 + var_558_22 + arg_558_0 then
				local var_558_25 = Color.New(0, 0, 0)
				local var_558_26 = 0

				arg_555_1.mask_.enabled = false
				var_558_25.a = var_558_26
				arg_555_1.mask_.color = var_558_25
			end

			local var_558_27 = manager.ui.mainCamera.transform
			local var_558_28 = 1.66666666666667

			if var_558_28 < arg_555_1.time_ and arg_555_1.time_ <= var_558_28 + arg_558_0 then
				local var_558_29 = arg_555_1.var_.effectheliesihuoyan1

				if var_558_29 then
					Object.Destroy(var_558_29)

					arg_555_1.var_.effectheliesihuoyan1 = nil
				end
			end

			if arg_555_1.frameCnt_ <= 1 then
				arg_555_1.dialog_:SetActive(false)
			end

			local var_558_30 = 2.3
			local var_558_31 = 0.275

			if var_558_30 < arg_555_1.time_ and arg_555_1.time_ <= var_558_30 + arg_558_0 then
				arg_555_1.talkMaxDuration = 0

				arg_555_1.dialog_:SetActive(true)

				arg_555_1.dialogCg_.alpha = 0

				local var_558_32 = LeanTween.value(arg_555_1.dialog_, 0, 1, 0.3)

				var_558_32:setOnUpdate(LuaHelper.FloatAction(function(arg_559_0)
					arg_555_1.dialogCg_.alpha = arg_559_0
				end))
				var_558_32:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_555_1.dialog_)
					var_558_32:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_555_1.duration_ = arg_555_1.duration_ + 0.3

				SetActive(arg_555_1.leftNameGo_, true)

				local var_558_33 = arg_555_1:FormatText(StoryNameCfg[996].name)

				arg_555_1.leftNameTxt_.text = var_558_33

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_555_1.leftNameTxt_.transform)

				arg_555_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_555_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_555_1:RecordName(arg_555_1.leftNameTxt_.text)
				SetActive(arg_555_1.iconTrs_.gameObject, false)
				arg_555_1.callingController_:SetSelectedState("normal")

				local var_558_34 = arg_555_1:GetWordFromCfg(413141131)
				local var_558_35 = arg_555_1:FormatText(var_558_34.content)

				arg_555_1.text_.text = var_558_35

				LuaForUtil.ClearLinePrefixSymbol(arg_555_1.text_)

				local var_558_36 = 11
				local var_558_37 = utf8.len(var_558_35)
				local var_558_38 = var_558_36 <= 0 and var_558_31 or var_558_31 * (var_558_37 / var_558_36)

				if var_558_38 > 0 and var_558_31 < var_558_38 then
					arg_555_1.talkMaxDuration = var_558_38
					var_558_30 = var_558_30 + 0.3

					if var_558_38 + var_558_30 > arg_555_1.duration_ then
						arg_555_1.duration_ = var_558_38 + var_558_30
					end
				end

				arg_555_1.text_.text = var_558_35
				arg_555_1.typewritter.percent = 0

				arg_555_1.typewritter:SetDirty()
				arg_555_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_413141", "413141131", "story_v_out_413141.awb") ~= 0 then
					local var_558_39 = manager.audio:GetVoiceLength("story_v_out_413141", "413141131", "story_v_out_413141.awb") / 1000

					if var_558_39 + var_558_30 > arg_555_1.duration_ then
						arg_555_1.duration_ = var_558_39 + var_558_30
					end

					if var_558_34.prefab_name ~= "" and arg_555_1.actors_[var_558_34.prefab_name] ~= nil then
						local var_558_40 = LuaForUtil.PlayVoiceWithCriLipsync(arg_555_1.actors_[var_558_34.prefab_name].transform, "story_v_out_413141", "413141131", "story_v_out_413141.awb")

						arg_555_1:RecordAudio("413141131", var_558_40)
						arg_555_1:RecordAudio("413141131", var_558_40)
					else
						arg_555_1:AudioAction("play", "voice", "story_v_out_413141", "413141131", "story_v_out_413141.awb")
					end

					arg_555_1:RecordHistoryTalkVoice("story_v_out_413141", "413141131", "story_v_out_413141.awb")
				end

				arg_555_1:RecordContent(arg_555_1.text_.text)
			end

			local var_558_41 = var_558_30 + 0.3
			local var_558_42 = math.max(var_558_31, arg_555_1.talkMaxDuration)

			if var_558_41 <= arg_555_1.time_ and arg_555_1.time_ < var_558_41 + var_558_42 then
				arg_555_1.typewritter.percent = (arg_555_1.time_ - var_558_41) / var_558_42

				arg_555_1.typewritter:SetDirty()
			end

			if arg_555_1.time_ >= var_558_41 + var_558_42 and arg_555_1.time_ < var_558_41 + var_558_42 + arg_558_0 then
				arg_555_1.typewritter.percent = 1

				arg_555_1.typewritter:SetDirty()
				arg_555_1:ShowNextGo(true)
			end
		end

		arg_555_1.nodeConfigList_ = {}

		arg_555_1:InitPlayNodeList()
	end,
	Play413141132 = function(arg_561_0, arg_561_1)
		arg_561_1.time_ = 0
		arg_561_1.frameCnt_ = 0
		arg_561_1.state_ = "playing"
		arg_561_1.curTalkId_ = 413141132
		arg_561_1.duration_ = 5

		SetActive(arg_561_1.tipsGo_, false)

		function arg_561_1.onSingleLineFinish_()
			arg_561_1.onSingleLineUpdate_ = nil
			arg_561_1.onSingleLineFinish_ = nil
			arg_561_1.state_ = "waiting"
			arg_561_1.auto_ = false
		end

		function arg_561_1.playNext_(arg_563_0)
			arg_561_1.onStoryFinished_()
		end

		function arg_561_1.onSingleLineUpdate_(arg_564_0)
			local var_564_0 = 0
			local var_564_1 = 0.7

			if var_564_0 < arg_561_1.time_ and arg_561_1.time_ <= var_564_0 + arg_564_0 then
				arg_561_1.talkMaxDuration = 0
				arg_561_1.dialogCg_.alpha = 1

				arg_561_1.dialog_:SetActive(true)
				SetActive(arg_561_1.leftNameGo_, false)

				arg_561_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_561_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_561_1:RecordName(arg_561_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_561_1.iconTrs_.gameObject, false)
				arg_561_1.callingController_:SetSelectedState("normal")

				local var_564_2 = arg_561_1:GetWordFromCfg(413141132)
				local var_564_3 = arg_561_1:FormatText(var_564_2.content)

				arg_561_1.text_.text = var_564_3

				LuaForUtil.ClearLinePrefixSymbol(arg_561_1.text_)

				local var_564_4 = 28
				local var_564_5 = utf8.len(var_564_3)
				local var_564_6 = var_564_4 <= 0 and var_564_1 or var_564_1 * (var_564_5 / var_564_4)

				if var_564_6 > 0 and var_564_1 < var_564_6 then
					arg_561_1.talkMaxDuration = var_564_6

					if var_564_6 + var_564_0 > arg_561_1.duration_ then
						arg_561_1.duration_ = var_564_6 + var_564_0
					end
				end

				arg_561_1.text_.text = var_564_3
				arg_561_1.typewritter.percent = 0

				arg_561_1.typewritter:SetDirty()
				arg_561_1:ShowNextGo(false)
				arg_561_1:RecordContent(arg_561_1.text_.text)
			end

			local var_564_7 = math.max(var_564_1, arg_561_1.talkMaxDuration)

			if var_564_0 <= arg_561_1.time_ and arg_561_1.time_ < var_564_0 + var_564_7 then
				arg_561_1.typewritter.percent = (arg_561_1.time_ - var_564_0) / var_564_7

				arg_561_1.typewritter:SetDirty()
			end

			if arg_561_1.time_ >= var_564_0 + var_564_7 and arg_561_1.time_ < var_564_0 + var_564_7 + arg_564_0 then
				arg_561_1.typewritter.percent = 1

				arg_561_1.typewritter:SetDirty()
				arg_561_1:ShowNextGo(true)
			end
		end

		arg_561_1.nodeConfigList_ = {}

		arg_561_1:InitPlayNodeList()
	end,
	assets = {
		"TextureConfig/Background/ST0603a",
		"TextureConfig/Background/F10f",
		"TextureConfig/Background/F08m",
		"TextureConfig/Background/F10g",
		"TextureConfig/Background/SS1309",
		"TextureConfig/Background/STblack"
	},
	voices = {
		"story_v_out_413141.awb"
	}
}
