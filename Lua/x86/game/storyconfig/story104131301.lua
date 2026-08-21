return {
	Play413131001 = function(arg_1_0, arg_1_1)
		arg_1_1.time_ = 0
		arg_1_1.frameCnt_ = 0
		arg_1_1.state_ = "playing"
		arg_1_1.curTalkId_ = 413131001
		arg_1_1.duration_ = 6.77

		local var_1_0 = {
			zh = 6.4,
			ja = 6.766
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
				arg_1_0:Play413131002(arg_1_1)
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
			local var_4_29 = 1.63333333333333

			if var_4_29 < arg_1_1.time_ and arg_1_1.time_ <= var_4_29 + arg_4_0 then
				arg_1_1.var_.moveOldPos10022 = var_4_28.localPosition
				var_4_28.localScale = Vector3.New(1, 1, 1)

				arg_1_1:CheckSpriteTmpPos("10022", 3)

				local var_4_30 = var_4_28.childCount

				for iter_4_4 = 0, var_4_30 - 1 do
					local var_4_31 = var_4_28:GetChild(iter_4_4)

					if var_4_31.name == "" or not string.find(var_4_31.name, "split") then
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
			local var_4_36 = 1.63333333333333

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
			local var_4_44 = 1.63333333333333

			if var_4_44 < arg_1_1.time_ and arg_1_1.time_ <= var_4_44 + arg_4_0 then
				local var_4_45 = var_4_43:GetComponentInChildren(typeof(CanvasGroup))

				if var_4_45 then
					arg_1_1.var_.alphaOldValue10022 = var_4_45.alpha
					arg_1_1.var_.characterEffect10022 = var_4_45
				end

				arg_1_1.var_.alphaOldValue10022 = 0
			end

			local var_4_46 = 0.2

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

			local var_4_61 = 2
			local var_4_62 = 0.6

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

				local var_4_65 = arg_1_1:GetWordFromCfg(413131001)
				local var_4_66 = arg_1_1:FormatText(var_4_65.content)

				arg_1_1.text_.text = var_4_66

				LuaForUtil.ClearLinePrefixSymbol(arg_1_1.text_)

				local var_4_67 = 24
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

				if manager.audio:GetVoiceLength("story_v_out_413131", "413131001", "story_v_out_413131.awb") ~= 0 then
					local var_4_70 = manager.audio:GetVoiceLength("story_v_out_413131", "413131001", "story_v_out_413131.awb") / 1000

					if var_4_70 + var_4_61 > arg_1_1.duration_ then
						arg_1_1.duration_ = var_4_70 + var_4_61
					end

					if var_4_65.prefab_name ~= "" and arg_1_1.actors_[var_4_65.prefab_name] ~= nil then
						local var_4_71 = LuaForUtil.PlayVoiceWithCriLipsync(arg_1_1.actors_[var_4_65.prefab_name].transform, "story_v_out_413131", "413131001", "story_v_out_413131.awb")

						arg_1_1:RecordAudio("413131001", var_4_71)
						arg_1_1:RecordAudio("413131001", var_4_71)
					else
						arg_1_1:AudioAction("play", "voice", "story_v_out_413131", "413131001", "story_v_out_413131.awb")
					end

					arg_1_1:RecordHistoryTalkVoice("story_v_out_413131", "413131001", "story_v_out_413131.awb")
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
				startTime = 1.63333333333333,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_1_1:InitPlayNodeList()
	end,
	Play413131002 = function(arg_9_0, arg_9_1)
		arg_9_1.time_ = 0
		arg_9_1.frameCnt_ = 0
		arg_9_1.state_ = "playing"
		arg_9_1.curTalkId_ = 413131002
		arg_9_1.duration_ = 6.4

		local var_9_0 = {
			zh = 4.7,
			ja = 6.4
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
				arg_9_0:Play413131003(arg_9_1)
			end
		end

		function arg_9_1.onSingleLineUpdate_(arg_12_0)
			local var_12_0 = arg_9_1.actors_["10022"].transform
			local var_12_1 = 0

			if var_12_1 < arg_9_1.time_ and arg_9_1.time_ <= var_12_1 + arg_12_0 then
				arg_9_1.var_.moveOldPos10022 = var_12_0.localPosition
				var_12_0.localScale = Vector3.New(1, 1, 1)

				arg_9_1:CheckSpriteTmpPos("10022", 3)

				local var_12_2 = var_12_0.childCount

				for iter_12_0 = 0, var_12_2 - 1 do
					local var_12_3 = var_12_0:GetChild(iter_12_0)

					if var_12_3.name == "split_3" or not string.find(var_12_3.name, "split") then
						var_12_3.gameObject:SetActive(true)
					else
						var_12_3.gameObject:SetActive(false)
					end
				end
			end

			local var_12_4 = 0.001

			if var_12_1 <= arg_9_1.time_ and arg_9_1.time_ < var_12_1 + var_12_4 then
				local var_12_5 = (arg_9_1.time_ - var_12_1) / var_12_4
				local var_12_6 = Vector3.New(0, -315, -320)

				var_12_0.localPosition = Vector3.Lerp(arg_9_1.var_.moveOldPos10022, var_12_6, var_12_5)
			end

			if arg_9_1.time_ >= var_12_1 + var_12_4 and arg_9_1.time_ < var_12_1 + var_12_4 + arg_12_0 then
				var_12_0.localPosition = Vector3.New(0, -315, -320)
			end

			local var_12_7 = arg_9_1.actors_["10022"]
			local var_12_8 = 0

			if var_12_8 < arg_9_1.time_ and arg_9_1.time_ <= var_12_8 + arg_12_0 and not isNil(var_12_7) and arg_9_1.var_.actorSpriteComps10022 == nil then
				arg_9_1.var_.actorSpriteComps10022 = var_12_7:GetComponentsInChildren(typeof(Image), true)
			end

			local var_12_9 = 2

			if var_12_8 <= arg_9_1.time_ and arg_9_1.time_ < var_12_8 + var_12_9 and not isNil(var_12_7) then
				local var_12_10 = (arg_9_1.time_ - var_12_8) / var_12_9

				if arg_9_1.var_.actorSpriteComps10022 then
					for iter_12_1, iter_12_2 in pairs(arg_9_1.var_.actorSpriteComps10022:ToTable()) do
						if iter_12_2 then
							if arg_9_1.isInRecall_ then
								local var_12_11 = Mathf.Lerp(iter_12_2.color.r, arg_9_1.hightColor1.r, var_12_10)
								local var_12_12 = Mathf.Lerp(iter_12_2.color.g, arg_9_1.hightColor1.g, var_12_10)
								local var_12_13 = Mathf.Lerp(iter_12_2.color.b, arg_9_1.hightColor1.b, var_12_10)

								iter_12_2.color = Color.New(var_12_11, var_12_12, var_12_13)
							else
								local var_12_14 = Mathf.Lerp(iter_12_2.color.r, 1, var_12_10)

								iter_12_2.color = Color.New(var_12_14, var_12_14, var_12_14)
							end
						end
					end
				end
			end

			if arg_9_1.time_ >= var_12_8 + var_12_9 and arg_9_1.time_ < var_12_8 + var_12_9 + arg_12_0 and not isNil(var_12_7) and arg_9_1.var_.actorSpriteComps10022 then
				for iter_12_3, iter_12_4 in pairs(arg_9_1.var_.actorSpriteComps10022:ToTable()) do
					if iter_12_4 then
						if arg_9_1.isInRecall_ then
							iter_12_4.color = arg_9_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_12_4.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_9_1.var_.actorSpriteComps10022 = nil
			end

			local var_12_15 = 0
			local var_12_16 = 0.65

			if var_12_15 < arg_9_1.time_ and arg_9_1.time_ <= var_12_15 + arg_12_0 then
				arg_9_1.talkMaxDuration = 0
				arg_9_1.dialogCg_.alpha = 1

				arg_9_1.dialog_:SetActive(true)
				SetActive(arg_9_1.leftNameGo_, true)

				local var_12_17 = arg_9_1:FormatText(StoryNameCfg[614].name)

				arg_9_1.leftNameTxt_.text = var_12_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_9_1.leftNameTxt_.transform)

				arg_9_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_9_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_9_1:RecordName(arg_9_1.leftNameTxt_.text)
				SetActive(arg_9_1.iconTrs_.gameObject, false)
				arg_9_1.callingController_:SetSelectedState("normal")

				local var_12_18 = arg_9_1:GetWordFromCfg(413131002)
				local var_12_19 = arg_9_1:FormatText(var_12_18.content)

				arg_9_1.text_.text = var_12_19

				LuaForUtil.ClearLinePrefixSymbol(arg_9_1.text_)

				local var_12_20 = 26
				local var_12_21 = utf8.len(var_12_19)
				local var_12_22 = var_12_20 <= 0 and var_12_16 or var_12_16 * (var_12_21 / var_12_20)

				if var_12_22 > 0 and var_12_16 < var_12_22 then
					arg_9_1.talkMaxDuration = var_12_22

					if var_12_22 + var_12_15 > arg_9_1.duration_ then
						arg_9_1.duration_ = var_12_22 + var_12_15
					end
				end

				arg_9_1.text_.text = var_12_19
				arg_9_1.typewritter.percent = 0

				arg_9_1.typewritter:SetDirty()
				arg_9_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_413131", "413131002", "story_v_out_413131.awb") ~= 0 then
					local var_12_23 = manager.audio:GetVoiceLength("story_v_out_413131", "413131002", "story_v_out_413131.awb") / 1000

					if var_12_23 + var_12_15 > arg_9_1.duration_ then
						arg_9_1.duration_ = var_12_23 + var_12_15
					end

					if var_12_18.prefab_name ~= "" and arg_9_1.actors_[var_12_18.prefab_name] ~= nil then
						local var_12_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_9_1.actors_[var_12_18.prefab_name].transform, "story_v_out_413131", "413131002", "story_v_out_413131.awb")

						arg_9_1:RecordAudio("413131002", var_12_24)
						arg_9_1:RecordAudio("413131002", var_12_24)
					else
						arg_9_1:AudioAction("play", "voice", "story_v_out_413131", "413131002", "story_v_out_413131.awb")
					end

					arg_9_1:RecordHistoryTalkVoice("story_v_out_413131", "413131002", "story_v_out_413131.awb")
				end

				arg_9_1:RecordContent(arg_9_1.text_.text)
			end

			local var_12_25 = math.max(var_12_16, arg_9_1.talkMaxDuration)

			if var_12_15 <= arg_9_1.time_ and arg_9_1.time_ < var_12_15 + var_12_25 then
				arg_9_1.typewritter.percent = (arg_9_1.time_ - var_12_15) / var_12_25

				arg_9_1.typewritter:SetDirty()
			end

			if arg_9_1.time_ >= var_12_15 + var_12_25 and arg_9_1.time_ < var_12_15 + var_12_25 + arg_12_0 then
				arg_9_1.typewritter.percent = 1

				arg_9_1.typewritter:SetDirty()
				arg_9_1:ShowNextGo(true)
			end
		end

		arg_9_1.nodeConfigList_ = {
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

		arg_9_1:InitPlayNodeList()
	end,
	Play413131003 = function(arg_13_0, arg_13_1)
		arg_13_1.time_ = 0
		arg_13_1.frameCnt_ = 0
		arg_13_1.state_ = "playing"
		arg_13_1.curTalkId_ = 413131003
		arg_13_1.duration_ = 7.3

		local var_13_0 = {
			zh = 4.266,
			ja = 7.3
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
				arg_13_0:Play413131004(arg_13_1)
			end
		end

		function arg_13_1.onSingleLineUpdate_(arg_16_0)
			local var_16_0 = arg_13_1.actors_["10022"].transform
			local var_16_1 = 0

			if var_16_1 < arg_13_1.time_ and arg_13_1.time_ <= var_16_1 + arg_16_0 then
				arg_13_1.var_.moveOldPos10022 = var_16_0.localPosition
				var_16_0.localScale = Vector3.New(1, 1, 1)

				arg_13_1:CheckSpriteTmpPos("10022", 2)

				local var_16_2 = var_16_0.childCount

				for iter_16_0 = 0, var_16_2 - 1 do
					local var_16_3 = var_16_0:GetChild(iter_16_0)

					if var_16_3.name == "split_3" or not string.find(var_16_3.name, "split") then
						var_16_3.gameObject:SetActive(true)
					else
						var_16_3.gameObject:SetActive(false)
					end
				end
			end

			local var_16_4 = 0.001

			if var_16_1 <= arg_13_1.time_ and arg_13_1.time_ < var_16_1 + var_16_4 then
				local var_16_5 = (arg_13_1.time_ - var_16_1) / var_16_4
				local var_16_6 = Vector3.New(-390, -315, -320)

				var_16_0.localPosition = Vector3.Lerp(arg_13_1.var_.moveOldPos10022, var_16_6, var_16_5)
			end

			if arg_13_1.time_ >= var_16_1 + var_16_4 and arg_13_1.time_ < var_16_1 + var_16_4 + arg_16_0 then
				var_16_0.localPosition = Vector3.New(-390, -315, -320)
			end

			local var_16_7 = "10094"

			if arg_13_1.actors_[var_16_7] == nil then
				local var_16_8 = Asset.Load("Widget/System/Story/StoryExpression/" .. "10094")

				if not isNil(var_16_8) then
					local var_16_9 = Object.Instantiate(var_16_8, arg_13_1.canvasGo_.transform)

					var_16_9.transform:SetSiblingIndex(1)

					var_16_9.name = var_16_7
					var_16_9.transform.localPosition = Vector3.New(0, 100000, 0)
					arg_13_1.actors_[var_16_7] = var_16_9

					local var_16_10 = var_16_9:GetComponentsInChildren(typeof(Image), true):ToTable()

					if arg_13_1.isInRecall_ then
						for iter_16_1, iter_16_2 in ipairs(var_16_10) do
							iter_16_2.color = arg_13_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						end
					end
				end
			end

			local var_16_11 = arg_13_1.actors_["10094"].transform
			local var_16_12 = 0

			if var_16_12 < arg_13_1.time_ and arg_13_1.time_ <= var_16_12 + arg_16_0 then
				arg_13_1.var_.moveOldPos10094 = var_16_11.localPosition
				var_16_11.localScale = Vector3.New(1, 1, 1)

				arg_13_1:CheckSpriteTmpPos("10094", 4)

				local var_16_13 = var_16_11.childCount

				for iter_16_3 = 0, var_16_13 - 1 do
					local var_16_14 = var_16_11:GetChild(iter_16_3)

					if var_16_14.name == "" or not string.find(var_16_14.name, "split") then
						var_16_14.gameObject:SetActive(true)
					else
						var_16_14.gameObject:SetActive(false)
					end
				end
			end

			local var_16_15 = 0.001

			if var_16_12 <= arg_13_1.time_ and arg_13_1.time_ < var_16_12 + var_16_15 then
				local var_16_16 = (arg_13_1.time_ - var_16_12) / var_16_15
				local var_16_17 = Vector3.New(390, -340, -414)

				var_16_11.localPosition = Vector3.Lerp(arg_13_1.var_.moveOldPos10094, var_16_17, var_16_16)
			end

			if arg_13_1.time_ >= var_16_12 + var_16_15 and arg_13_1.time_ < var_16_12 + var_16_15 + arg_16_0 then
				var_16_11.localPosition = Vector3.New(390, -340, -414)
			end

			local var_16_18 = arg_13_1.actors_["10022"]
			local var_16_19 = 0

			if var_16_19 < arg_13_1.time_ and arg_13_1.time_ <= var_16_19 + arg_16_0 and not isNil(var_16_18) and arg_13_1.var_.actorSpriteComps10022 == nil then
				arg_13_1.var_.actorSpriteComps10022 = var_16_18:GetComponentsInChildren(typeof(Image), true)
			end

			local var_16_20 = 2

			if var_16_19 <= arg_13_1.time_ and arg_13_1.time_ < var_16_19 + var_16_20 and not isNil(var_16_18) then
				local var_16_21 = (arg_13_1.time_ - var_16_19) / var_16_20

				if arg_13_1.var_.actorSpriteComps10022 then
					for iter_16_4, iter_16_5 in pairs(arg_13_1.var_.actorSpriteComps10022:ToTable()) do
						if iter_16_5 then
							if arg_13_1.isInRecall_ then
								local var_16_22 = Mathf.Lerp(iter_16_5.color.r, arg_13_1.hightColor2.r, var_16_21)
								local var_16_23 = Mathf.Lerp(iter_16_5.color.g, arg_13_1.hightColor2.g, var_16_21)
								local var_16_24 = Mathf.Lerp(iter_16_5.color.b, arg_13_1.hightColor2.b, var_16_21)

								iter_16_5.color = Color.New(var_16_22, var_16_23, var_16_24)
							else
								local var_16_25 = Mathf.Lerp(iter_16_5.color.r, 0.5, var_16_21)

								iter_16_5.color = Color.New(var_16_25, var_16_25, var_16_25)
							end
						end
					end
				end
			end

			if arg_13_1.time_ >= var_16_19 + var_16_20 and arg_13_1.time_ < var_16_19 + var_16_20 + arg_16_0 and not isNil(var_16_18) and arg_13_1.var_.actorSpriteComps10022 then
				for iter_16_6, iter_16_7 in pairs(arg_13_1.var_.actorSpriteComps10022:ToTable()) do
					if iter_16_7 then
						if arg_13_1.isInRecall_ then
							iter_16_7.color = arg_13_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_16_7.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_13_1.var_.actorSpriteComps10022 = nil
			end

			local var_16_26 = arg_13_1.actors_["10094"]
			local var_16_27 = 0

			if var_16_27 < arg_13_1.time_ and arg_13_1.time_ <= var_16_27 + arg_16_0 and not isNil(var_16_26) and arg_13_1.var_.actorSpriteComps10094 == nil then
				arg_13_1.var_.actorSpriteComps10094 = var_16_26:GetComponentsInChildren(typeof(Image), true)
			end

			local var_16_28 = 2

			if var_16_27 <= arg_13_1.time_ and arg_13_1.time_ < var_16_27 + var_16_28 and not isNil(var_16_26) then
				local var_16_29 = (arg_13_1.time_ - var_16_27) / var_16_28

				if arg_13_1.var_.actorSpriteComps10094 then
					for iter_16_8, iter_16_9 in pairs(arg_13_1.var_.actorSpriteComps10094:ToTable()) do
						if iter_16_9 then
							if arg_13_1.isInRecall_ then
								local var_16_30 = Mathf.Lerp(iter_16_9.color.r, arg_13_1.hightColor1.r, var_16_29)
								local var_16_31 = Mathf.Lerp(iter_16_9.color.g, arg_13_1.hightColor1.g, var_16_29)
								local var_16_32 = Mathf.Lerp(iter_16_9.color.b, arg_13_1.hightColor1.b, var_16_29)

								iter_16_9.color = Color.New(var_16_30, var_16_31, var_16_32)
							else
								local var_16_33 = Mathf.Lerp(iter_16_9.color.r, 1, var_16_29)

								iter_16_9.color = Color.New(var_16_33, var_16_33, var_16_33)
							end
						end
					end
				end
			end

			if arg_13_1.time_ >= var_16_27 + var_16_28 and arg_13_1.time_ < var_16_27 + var_16_28 + arg_16_0 and not isNil(var_16_26) and arg_13_1.var_.actorSpriteComps10094 then
				for iter_16_10, iter_16_11 in pairs(arg_13_1.var_.actorSpriteComps10094:ToTable()) do
					if iter_16_11 then
						if arg_13_1.isInRecall_ then
							iter_16_11.color = arg_13_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_16_11.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_13_1.var_.actorSpriteComps10094 = nil
			end

			local var_16_34 = 0
			local var_16_35 = 0.5

			if var_16_34 < arg_13_1.time_ and arg_13_1.time_ <= var_16_34 + arg_16_0 then
				arg_13_1.talkMaxDuration = 0
				arg_13_1.dialogCg_.alpha = 1

				arg_13_1.dialog_:SetActive(true)
				SetActive(arg_13_1.leftNameGo_, true)

				local var_16_36 = arg_13_1:FormatText(StoryNameCfg[259].name)

				arg_13_1.leftNameTxt_.text = var_16_36

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_13_1.leftNameTxt_.transform)

				arg_13_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_13_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_13_1:RecordName(arg_13_1.leftNameTxt_.text)
				SetActive(arg_13_1.iconTrs_.gameObject, false)
				arg_13_1.callingController_:SetSelectedState("normal")

				local var_16_37 = arg_13_1:GetWordFromCfg(413131003)
				local var_16_38 = arg_13_1:FormatText(var_16_37.content)

				arg_13_1.text_.text = var_16_38

				LuaForUtil.ClearLinePrefixSymbol(arg_13_1.text_)

				local var_16_39 = 20
				local var_16_40 = utf8.len(var_16_38)
				local var_16_41 = var_16_39 <= 0 and var_16_35 or var_16_35 * (var_16_40 / var_16_39)

				if var_16_41 > 0 and var_16_35 < var_16_41 then
					arg_13_1.talkMaxDuration = var_16_41

					if var_16_41 + var_16_34 > arg_13_1.duration_ then
						arg_13_1.duration_ = var_16_41 + var_16_34
					end
				end

				arg_13_1.text_.text = var_16_38
				arg_13_1.typewritter.percent = 0

				arg_13_1.typewritter:SetDirty()
				arg_13_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_413131", "413131003", "story_v_out_413131.awb") ~= 0 then
					local var_16_42 = manager.audio:GetVoiceLength("story_v_out_413131", "413131003", "story_v_out_413131.awb") / 1000

					if var_16_42 + var_16_34 > arg_13_1.duration_ then
						arg_13_1.duration_ = var_16_42 + var_16_34
					end

					if var_16_37.prefab_name ~= "" and arg_13_1.actors_[var_16_37.prefab_name] ~= nil then
						local var_16_43 = LuaForUtil.PlayVoiceWithCriLipsync(arg_13_1.actors_[var_16_37.prefab_name].transform, "story_v_out_413131", "413131003", "story_v_out_413131.awb")

						arg_13_1:RecordAudio("413131003", var_16_43)
						arg_13_1:RecordAudio("413131003", var_16_43)
					else
						arg_13_1:AudioAction("play", "voice", "story_v_out_413131", "413131003", "story_v_out_413131.awb")
					end

					arg_13_1:RecordHistoryTalkVoice("story_v_out_413131", "413131003", "story_v_out_413131.awb")
				end

				arg_13_1:RecordContent(arg_13_1.text_.text)
			end

			local var_16_44 = math.max(var_16_35, arg_13_1.talkMaxDuration)

			if var_16_34 <= arg_13_1.time_ and arg_13_1.time_ < var_16_34 + var_16_44 then
				arg_13_1.typewritter.percent = (arg_13_1.time_ - var_16_34) / var_16_44

				arg_13_1.typewritter:SetDirty()
			end

			if arg_13_1.time_ >= var_16_34 + var_16_44 and arg_13_1.time_ < var_16_34 + var_16_44 + arg_16_0 then
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

		arg_13_1:InitPlayNodeList()
	end,
	Play413131004 = function(arg_17_0, arg_17_1)
		arg_17_1.time_ = 0
		arg_17_1.frameCnt_ = 0
		arg_17_1.state_ = "playing"
		arg_17_1.curTalkId_ = 413131004
		arg_17_1.duration_ = 7.37

		local var_17_0 = {
			zh = 5.166,
			ja = 7.366
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
				arg_17_0:Play413131005(arg_17_1)
			end
		end

		function arg_17_1.onSingleLineUpdate_(arg_20_0)
			local var_20_0 = arg_17_1.actors_["10022"].transform
			local var_20_1 = 0

			if var_20_1 < arg_17_1.time_ and arg_17_1.time_ <= var_20_1 + arg_20_0 then
				arg_17_1.var_.moveOldPos10022 = var_20_0.localPosition
				var_20_0.localScale = Vector3.New(1, 1, 1)

				arg_17_1:CheckSpriteTmpPos("10022", 2)

				local var_20_2 = var_20_0.childCount

				for iter_20_0 = 0, var_20_2 - 1 do
					local var_20_3 = var_20_0:GetChild(iter_20_0)

					if var_20_3.name == "split_3" or not string.find(var_20_3.name, "split") then
						var_20_3.gameObject:SetActive(true)
					else
						var_20_3.gameObject:SetActive(false)
					end
				end
			end

			local var_20_4 = 0.001

			if var_20_1 <= arg_17_1.time_ and arg_17_1.time_ < var_20_1 + var_20_4 then
				local var_20_5 = (arg_17_1.time_ - var_20_1) / var_20_4
				local var_20_6 = Vector3.New(-390, -315, -320)

				var_20_0.localPosition = Vector3.Lerp(arg_17_1.var_.moveOldPos10022, var_20_6, var_20_5)
			end

			if arg_17_1.time_ >= var_20_1 + var_20_4 and arg_17_1.time_ < var_20_1 + var_20_4 + arg_20_0 then
				var_20_0.localPosition = Vector3.New(-390, -315, -320)
			end

			local var_20_7 = arg_17_1.actors_["10022"]
			local var_20_8 = 0

			if var_20_8 < arg_17_1.time_ and arg_17_1.time_ <= var_20_8 + arg_20_0 and not isNil(var_20_7) and arg_17_1.var_.actorSpriteComps10022 == nil then
				arg_17_1.var_.actorSpriteComps10022 = var_20_7:GetComponentsInChildren(typeof(Image), true)
			end

			local var_20_9 = 2

			if var_20_8 <= arg_17_1.time_ and arg_17_1.time_ < var_20_8 + var_20_9 and not isNil(var_20_7) then
				local var_20_10 = (arg_17_1.time_ - var_20_8) / var_20_9

				if arg_17_1.var_.actorSpriteComps10022 then
					for iter_20_1, iter_20_2 in pairs(arg_17_1.var_.actorSpriteComps10022:ToTable()) do
						if iter_20_2 then
							if arg_17_1.isInRecall_ then
								local var_20_11 = Mathf.Lerp(iter_20_2.color.r, arg_17_1.hightColor1.r, var_20_10)
								local var_20_12 = Mathf.Lerp(iter_20_2.color.g, arg_17_1.hightColor1.g, var_20_10)
								local var_20_13 = Mathf.Lerp(iter_20_2.color.b, arg_17_1.hightColor1.b, var_20_10)

								iter_20_2.color = Color.New(var_20_11, var_20_12, var_20_13)
							else
								local var_20_14 = Mathf.Lerp(iter_20_2.color.r, 1, var_20_10)

								iter_20_2.color = Color.New(var_20_14, var_20_14, var_20_14)
							end
						end
					end
				end
			end

			if arg_17_1.time_ >= var_20_8 + var_20_9 and arg_17_1.time_ < var_20_8 + var_20_9 + arg_20_0 and not isNil(var_20_7) and arg_17_1.var_.actorSpriteComps10022 then
				for iter_20_3, iter_20_4 in pairs(arg_17_1.var_.actorSpriteComps10022:ToTable()) do
					if iter_20_4 then
						if arg_17_1.isInRecall_ then
							iter_20_4.color = arg_17_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_20_4.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_17_1.var_.actorSpriteComps10022 = nil
			end

			local var_20_15 = arg_17_1.actors_["10094"]
			local var_20_16 = 0

			if var_20_16 < arg_17_1.time_ and arg_17_1.time_ <= var_20_16 + arg_20_0 and not isNil(var_20_15) and arg_17_1.var_.actorSpriteComps10094 == nil then
				arg_17_1.var_.actorSpriteComps10094 = var_20_15:GetComponentsInChildren(typeof(Image), true)
			end

			local var_20_17 = 2

			if var_20_16 <= arg_17_1.time_ and arg_17_1.time_ < var_20_16 + var_20_17 and not isNil(var_20_15) then
				local var_20_18 = (arg_17_1.time_ - var_20_16) / var_20_17

				if arg_17_1.var_.actorSpriteComps10094 then
					for iter_20_5, iter_20_6 in pairs(arg_17_1.var_.actorSpriteComps10094:ToTable()) do
						if iter_20_6 then
							if arg_17_1.isInRecall_ then
								local var_20_19 = Mathf.Lerp(iter_20_6.color.r, arg_17_1.hightColor2.r, var_20_18)
								local var_20_20 = Mathf.Lerp(iter_20_6.color.g, arg_17_1.hightColor2.g, var_20_18)
								local var_20_21 = Mathf.Lerp(iter_20_6.color.b, arg_17_1.hightColor2.b, var_20_18)

								iter_20_6.color = Color.New(var_20_19, var_20_20, var_20_21)
							else
								local var_20_22 = Mathf.Lerp(iter_20_6.color.r, 0.5, var_20_18)

								iter_20_6.color = Color.New(var_20_22, var_20_22, var_20_22)
							end
						end
					end
				end
			end

			if arg_17_1.time_ >= var_20_16 + var_20_17 and arg_17_1.time_ < var_20_16 + var_20_17 + arg_20_0 and not isNil(var_20_15) and arg_17_1.var_.actorSpriteComps10094 then
				for iter_20_7, iter_20_8 in pairs(arg_17_1.var_.actorSpriteComps10094:ToTable()) do
					if iter_20_8 then
						if arg_17_1.isInRecall_ then
							iter_20_8.color = arg_17_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_20_8.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_17_1.var_.actorSpriteComps10094 = nil
			end

			local var_20_23 = 0
			local var_20_24 = 0.725

			if var_20_23 < arg_17_1.time_ and arg_17_1.time_ <= var_20_23 + arg_20_0 then
				arg_17_1.talkMaxDuration = 0
				arg_17_1.dialogCg_.alpha = 1

				arg_17_1.dialog_:SetActive(true)
				SetActive(arg_17_1.leftNameGo_, true)

				local var_20_25 = arg_17_1:FormatText(StoryNameCfg[614].name)

				arg_17_1.leftNameTxt_.text = var_20_25

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_17_1.leftNameTxt_.transform)

				arg_17_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_17_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_17_1:RecordName(arg_17_1.leftNameTxt_.text)
				SetActive(arg_17_1.iconTrs_.gameObject, false)
				arg_17_1.callingController_:SetSelectedState("normal")

				local var_20_26 = arg_17_1:GetWordFromCfg(413131004)
				local var_20_27 = arg_17_1:FormatText(var_20_26.content)

				arg_17_1.text_.text = var_20_27

				LuaForUtil.ClearLinePrefixSymbol(arg_17_1.text_)

				local var_20_28 = 29
				local var_20_29 = utf8.len(var_20_27)
				local var_20_30 = var_20_28 <= 0 and var_20_24 or var_20_24 * (var_20_29 / var_20_28)

				if var_20_30 > 0 and var_20_24 < var_20_30 then
					arg_17_1.talkMaxDuration = var_20_30

					if var_20_30 + var_20_23 > arg_17_1.duration_ then
						arg_17_1.duration_ = var_20_30 + var_20_23
					end
				end

				arg_17_1.text_.text = var_20_27
				arg_17_1.typewritter.percent = 0

				arg_17_1.typewritter:SetDirty()
				arg_17_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_413131", "413131004", "story_v_out_413131.awb") ~= 0 then
					local var_20_31 = manager.audio:GetVoiceLength("story_v_out_413131", "413131004", "story_v_out_413131.awb") / 1000

					if var_20_31 + var_20_23 > arg_17_1.duration_ then
						arg_17_1.duration_ = var_20_31 + var_20_23
					end

					if var_20_26.prefab_name ~= "" and arg_17_1.actors_[var_20_26.prefab_name] ~= nil then
						local var_20_32 = LuaForUtil.PlayVoiceWithCriLipsync(arg_17_1.actors_[var_20_26.prefab_name].transform, "story_v_out_413131", "413131004", "story_v_out_413131.awb")

						arg_17_1:RecordAudio("413131004", var_20_32)
						arg_17_1:RecordAudio("413131004", var_20_32)
					else
						arg_17_1:AudioAction("play", "voice", "story_v_out_413131", "413131004", "story_v_out_413131.awb")
					end

					arg_17_1:RecordHistoryTalkVoice("story_v_out_413131", "413131004", "story_v_out_413131.awb")
				end

				arg_17_1:RecordContent(arg_17_1.text_.text)
			end

			local var_20_33 = math.max(var_20_24, arg_17_1.talkMaxDuration)

			if var_20_23 <= arg_17_1.time_ and arg_17_1.time_ < var_20_23 + var_20_33 then
				arg_17_1.typewritter.percent = (arg_17_1.time_ - var_20_23) / var_20_33

				arg_17_1.typewritter:SetDirty()
			end

			if arg_17_1.time_ >= var_20_23 + var_20_33 and arg_17_1.time_ < var_20_23 + var_20_33 + arg_20_0 then
				arg_17_1.typewritter.percent = 1

				arg_17_1.typewritter:SetDirty()
				arg_17_1:ShowNextGo(true)
			end
		end

		arg_17_1.nodeConfigList_ = {
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

		arg_17_1:InitPlayNodeList()
	end,
	Play413131005 = function(arg_21_0, arg_21_1)
		arg_21_1.time_ = 0
		arg_21_1.frameCnt_ = 0
		arg_21_1.state_ = "playing"
		arg_21_1.curTalkId_ = 413131005
		arg_21_1.duration_ = 9.23

		local var_21_0 = {
			zh = 4.733,
			ja = 9.233
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
				arg_21_0:Play413131006(arg_21_1)
			end
		end

		function arg_21_1.onSingleLineUpdate_(arg_24_0)
			local var_24_0 = arg_21_1.actors_["10022"]
			local var_24_1 = 0

			if var_24_1 < arg_21_1.time_ and arg_21_1.time_ <= var_24_1 + arg_24_0 and not isNil(var_24_0) and arg_21_1.var_.actorSpriteComps10022 == nil then
				arg_21_1.var_.actorSpriteComps10022 = var_24_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_24_2 = 2

			if var_24_1 <= arg_21_1.time_ and arg_21_1.time_ < var_24_1 + var_24_2 and not isNil(var_24_0) then
				local var_24_3 = (arg_21_1.time_ - var_24_1) / var_24_2

				if arg_21_1.var_.actorSpriteComps10022 then
					for iter_24_0, iter_24_1 in pairs(arg_21_1.var_.actorSpriteComps10022:ToTable()) do
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

			if arg_21_1.time_ >= var_24_1 + var_24_2 and arg_21_1.time_ < var_24_1 + var_24_2 + arg_24_0 and not isNil(var_24_0) and arg_21_1.var_.actorSpriteComps10022 then
				for iter_24_2, iter_24_3 in pairs(arg_21_1.var_.actorSpriteComps10022:ToTable()) do
					if iter_24_3 then
						if arg_21_1.isInRecall_ then
							iter_24_3.color = arg_21_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_24_3.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_21_1.var_.actorSpriteComps10022 = nil
			end

			local var_24_8 = arg_21_1.actors_["10094"]
			local var_24_9 = 0

			if var_24_9 < arg_21_1.time_ and arg_21_1.time_ <= var_24_9 + arg_24_0 and not isNil(var_24_8) and arg_21_1.var_.actorSpriteComps10094 == nil then
				arg_21_1.var_.actorSpriteComps10094 = var_24_8:GetComponentsInChildren(typeof(Image), true)
			end

			local var_24_10 = 2

			if var_24_9 <= arg_21_1.time_ and arg_21_1.time_ < var_24_9 + var_24_10 and not isNil(var_24_8) then
				local var_24_11 = (arg_21_1.time_ - var_24_9) / var_24_10

				if arg_21_1.var_.actorSpriteComps10094 then
					for iter_24_4, iter_24_5 in pairs(arg_21_1.var_.actorSpriteComps10094:ToTable()) do
						if iter_24_5 then
							if arg_21_1.isInRecall_ then
								local var_24_12 = Mathf.Lerp(iter_24_5.color.r, arg_21_1.hightColor1.r, var_24_11)
								local var_24_13 = Mathf.Lerp(iter_24_5.color.g, arg_21_1.hightColor1.g, var_24_11)
								local var_24_14 = Mathf.Lerp(iter_24_5.color.b, arg_21_1.hightColor1.b, var_24_11)

								iter_24_5.color = Color.New(var_24_12, var_24_13, var_24_14)
							else
								local var_24_15 = Mathf.Lerp(iter_24_5.color.r, 1, var_24_11)

								iter_24_5.color = Color.New(var_24_15, var_24_15, var_24_15)
							end
						end
					end
				end
			end

			if arg_21_1.time_ >= var_24_9 + var_24_10 and arg_21_1.time_ < var_24_9 + var_24_10 + arg_24_0 and not isNil(var_24_8) and arg_21_1.var_.actorSpriteComps10094 then
				for iter_24_6, iter_24_7 in pairs(arg_21_1.var_.actorSpriteComps10094:ToTable()) do
					if iter_24_7 then
						if arg_21_1.isInRecall_ then
							iter_24_7.color = arg_21_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_24_7.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_21_1.var_.actorSpriteComps10094 = nil
			end

			local var_24_16 = 0
			local var_24_17 = 0.6

			if var_24_16 < arg_21_1.time_ and arg_21_1.time_ <= var_24_16 + arg_24_0 then
				arg_21_1.talkMaxDuration = 0
				arg_21_1.dialogCg_.alpha = 1

				arg_21_1.dialog_:SetActive(true)
				SetActive(arg_21_1.leftNameGo_, true)

				local var_24_18 = arg_21_1:FormatText(StoryNameCfg[259].name)

				arg_21_1.leftNameTxt_.text = var_24_18

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_21_1.leftNameTxt_.transform)

				arg_21_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_21_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_21_1:RecordName(arg_21_1.leftNameTxt_.text)
				SetActive(arg_21_1.iconTrs_.gameObject, false)
				arg_21_1.callingController_:SetSelectedState("normal")

				local var_24_19 = arg_21_1:GetWordFromCfg(413131005)
				local var_24_20 = arg_21_1:FormatText(var_24_19.content)

				arg_21_1.text_.text = var_24_20

				LuaForUtil.ClearLinePrefixSymbol(arg_21_1.text_)

				local var_24_21 = 24
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

				if manager.audio:GetVoiceLength("story_v_out_413131", "413131005", "story_v_out_413131.awb") ~= 0 then
					local var_24_24 = manager.audio:GetVoiceLength("story_v_out_413131", "413131005", "story_v_out_413131.awb") / 1000

					if var_24_24 + var_24_16 > arg_21_1.duration_ then
						arg_21_1.duration_ = var_24_24 + var_24_16
					end

					if var_24_19.prefab_name ~= "" and arg_21_1.actors_[var_24_19.prefab_name] ~= nil then
						local var_24_25 = LuaForUtil.PlayVoiceWithCriLipsync(arg_21_1.actors_[var_24_19.prefab_name].transform, "story_v_out_413131", "413131005", "story_v_out_413131.awb")

						arg_21_1:RecordAudio("413131005", var_24_25)
						arg_21_1:RecordAudio("413131005", var_24_25)
					else
						arg_21_1:AudioAction("play", "voice", "story_v_out_413131", "413131005", "story_v_out_413131.awb")
					end

					arg_21_1:RecordHistoryTalkVoice("story_v_out_413131", "413131005", "story_v_out_413131.awb")
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
	Play413131006 = function(arg_25_0, arg_25_1)
		arg_25_1.time_ = 0
		arg_25_1.frameCnt_ = 0
		arg_25_1.state_ = "playing"
		arg_25_1.curTalkId_ = 413131006
		arg_25_1.duration_ = 6.13

		local var_25_0 = {
			zh = 4.033,
			ja = 6.133
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
				arg_25_0:Play413131007(arg_25_1)
			end
		end

		function arg_25_1.onSingleLineUpdate_(arg_28_0)
			local var_28_0 = "10092_1"

			if arg_25_1.actors_[var_28_0] == nil then
				local var_28_1 = Asset.Load("Widget/System/Story/StoryExpression/" .. "10092_1")

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

			local var_28_4 = arg_25_1.actors_["10092_1"].transform
			local var_28_5 = 0

			if var_28_5 < arg_25_1.time_ and arg_25_1.time_ <= var_28_5 + arg_28_0 then
				arg_25_1.var_.moveOldPos10092_1 = var_28_4.localPosition
				var_28_4.localScale = Vector3.New(1, 1, 1)

				arg_25_1:CheckSpriteTmpPos("10092_1", 2)

				local var_28_6 = var_28_4.childCount

				for iter_28_2 = 0, var_28_6 - 1 do
					local var_28_7 = var_28_4:GetChild(iter_28_2)

					if var_28_7.name == "" or not string.find(var_28_7.name, "split") then
						var_28_7.gameObject:SetActive(true)
					else
						var_28_7.gameObject:SetActive(false)
					end
				end
			end

			local var_28_8 = 0.001

			if var_28_5 <= arg_25_1.time_ and arg_25_1.time_ < var_28_5 + var_28_8 then
				local var_28_9 = (arg_25_1.time_ - var_28_5) / var_28_8
				local var_28_10 = Vector3.New(-389.49, -300, -295)

				var_28_4.localPosition = Vector3.Lerp(arg_25_1.var_.moveOldPos10092_1, var_28_10, var_28_9)
			end

			if arg_25_1.time_ >= var_28_5 + var_28_8 and arg_25_1.time_ < var_28_5 + var_28_8 + arg_28_0 then
				var_28_4.localPosition = Vector3.New(-389.49, -300, -295)
			end

			local var_28_11 = arg_25_1.actors_["10092_1"]
			local var_28_12 = 0

			if var_28_12 < arg_25_1.time_ and arg_25_1.time_ <= var_28_12 + arg_28_0 and not isNil(var_28_11) and arg_25_1.var_.actorSpriteComps10092_1 == nil then
				arg_25_1.var_.actorSpriteComps10092_1 = var_28_11:GetComponentsInChildren(typeof(Image), true)
			end

			local var_28_13 = 2

			if var_28_12 <= arg_25_1.time_ and arg_25_1.time_ < var_28_12 + var_28_13 and not isNil(var_28_11) then
				local var_28_14 = (arg_25_1.time_ - var_28_12) / var_28_13

				if arg_25_1.var_.actorSpriteComps10092_1 then
					for iter_28_3, iter_28_4 in pairs(arg_25_1.var_.actorSpriteComps10092_1:ToTable()) do
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

			if arg_25_1.time_ >= var_28_12 + var_28_13 and arg_25_1.time_ < var_28_12 + var_28_13 + arg_28_0 and not isNil(var_28_11) and arg_25_1.var_.actorSpriteComps10092_1 then
				for iter_28_5, iter_28_6 in pairs(arg_25_1.var_.actorSpriteComps10092_1:ToTable()) do
					if iter_28_6 then
						if arg_25_1.isInRecall_ then
							iter_28_6.color = arg_25_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_28_6.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_25_1.var_.actorSpriteComps10092_1 = nil
			end

			local var_28_19 = arg_25_1.actors_["10094"]
			local var_28_20 = 0

			if var_28_20 < arg_25_1.time_ and arg_25_1.time_ <= var_28_20 + arg_28_0 and not isNil(var_28_19) and arg_25_1.var_.actorSpriteComps10094 == nil then
				arg_25_1.var_.actorSpriteComps10094 = var_28_19:GetComponentsInChildren(typeof(Image), true)
			end

			local var_28_21 = 2

			if var_28_20 <= arg_25_1.time_ and arg_25_1.time_ < var_28_20 + var_28_21 and not isNil(var_28_19) then
				local var_28_22 = (arg_25_1.time_ - var_28_20) / var_28_21

				if arg_25_1.var_.actorSpriteComps10094 then
					for iter_28_7, iter_28_8 in pairs(arg_25_1.var_.actorSpriteComps10094:ToTable()) do
						if iter_28_8 then
							if arg_25_1.isInRecall_ then
								local var_28_23 = Mathf.Lerp(iter_28_8.color.r, arg_25_1.hightColor2.r, var_28_22)
								local var_28_24 = Mathf.Lerp(iter_28_8.color.g, arg_25_1.hightColor2.g, var_28_22)
								local var_28_25 = Mathf.Lerp(iter_28_8.color.b, arg_25_1.hightColor2.b, var_28_22)

								iter_28_8.color = Color.New(var_28_23, var_28_24, var_28_25)
							else
								local var_28_26 = Mathf.Lerp(iter_28_8.color.r, 0.5, var_28_22)

								iter_28_8.color = Color.New(var_28_26, var_28_26, var_28_26)
							end
						end
					end
				end
			end

			if arg_25_1.time_ >= var_28_20 + var_28_21 and arg_25_1.time_ < var_28_20 + var_28_21 + arg_28_0 and not isNil(var_28_19) and arg_25_1.var_.actorSpriteComps10094 then
				for iter_28_9, iter_28_10 in pairs(arg_25_1.var_.actorSpriteComps10094:ToTable()) do
					if iter_28_10 then
						if arg_25_1.isInRecall_ then
							iter_28_10.color = arg_25_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_28_10.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_25_1.var_.actorSpriteComps10094 = nil
			end

			local var_28_27 = 0
			local var_28_28 = 0.525

			if var_28_27 < arg_25_1.time_ and arg_25_1.time_ <= var_28_27 + arg_28_0 then
				arg_25_1.talkMaxDuration = 0
				arg_25_1.dialogCg_.alpha = 1

				arg_25_1.dialog_:SetActive(true)
				SetActive(arg_25_1.leftNameGo_, true)

				local var_28_29 = arg_25_1:FormatText(StoryNameCfg[996].name)

				arg_25_1.leftNameTxt_.text = var_28_29

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_25_1.leftNameTxt_.transform)

				arg_25_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_25_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_25_1:RecordName(arg_25_1.leftNameTxt_.text)
				SetActive(arg_25_1.iconTrs_.gameObject, false)
				arg_25_1.callingController_:SetSelectedState("normal")

				local var_28_30 = arg_25_1:GetWordFromCfg(413131006)
				local var_28_31 = arg_25_1:FormatText(var_28_30.content)

				arg_25_1.text_.text = var_28_31

				LuaForUtil.ClearLinePrefixSymbol(arg_25_1.text_)

				local var_28_32 = 21
				local var_28_33 = utf8.len(var_28_31)
				local var_28_34 = var_28_32 <= 0 and var_28_28 or var_28_28 * (var_28_33 / var_28_32)

				if var_28_34 > 0 and var_28_28 < var_28_34 then
					arg_25_1.talkMaxDuration = var_28_34

					if var_28_34 + var_28_27 > arg_25_1.duration_ then
						arg_25_1.duration_ = var_28_34 + var_28_27
					end
				end

				arg_25_1.text_.text = var_28_31
				arg_25_1.typewritter.percent = 0

				arg_25_1.typewritter:SetDirty()
				arg_25_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_413131", "413131006", "story_v_out_413131.awb") ~= 0 then
					local var_28_35 = manager.audio:GetVoiceLength("story_v_out_413131", "413131006", "story_v_out_413131.awb") / 1000

					if var_28_35 + var_28_27 > arg_25_1.duration_ then
						arg_25_1.duration_ = var_28_35 + var_28_27
					end

					if var_28_30.prefab_name ~= "" and arg_25_1.actors_[var_28_30.prefab_name] ~= nil then
						local var_28_36 = LuaForUtil.PlayVoiceWithCriLipsync(arg_25_1.actors_[var_28_30.prefab_name].transform, "story_v_out_413131", "413131006", "story_v_out_413131.awb")

						arg_25_1:RecordAudio("413131006", var_28_36)
						arg_25_1:RecordAudio("413131006", var_28_36)
					else
						arg_25_1:AudioAction("play", "voice", "story_v_out_413131", "413131006", "story_v_out_413131.awb")
					end

					arg_25_1:RecordHistoryTalkVoice("story_v_out_413131", "413131006", "story_v_out_413131.awb")
				end

				arg_25_1:RecordContent(arg_25_1.text_.text)
			end

			local var_28_37 = math.max(var_28_28, arg_25_1.talkMaxDuration)

			if var_28_27 <= arg_25_1.time_ and arg_25_1.time_ < var_28_27 + var_28_37 then
				arg_25_1.typewritter.percent = (arg_25_1.time_ - var_28_27) / var_28_37

				arg_25_1.typewritter:SetDirty()
			end

			if arg_25_1.time_ >= var_28_27 + var_28_37 and arg_25_1.time_ < var_28_27 + var_28_37 + arg_28_0 then
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
			}
		}

		arg_25_1:InitPlayNodeList()
	end,
	Play413131007 = function(arg_29_0, arg_29_1)
		arg_29_1.time_ = 0
		arg_29_1.frameCnt_ = 0
		arg_29_1.state_ = "playing"
		arg_29_1.curTalkId_ = 413131007
		arg_29_1.duration_ = 6.87

		local var_29_0 = {
			zh = 6.866,
			ja = 6.366
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
				arg_29_0:Play413131008(arg_29_1)
			end
		end

		function arg_29_1.onSingleLineUpdate_(arg_32_0)
			local var_32_0 = arg_29_1.actors_["10022"].transform
			local var_32_1 = 0

			if var_32_1 < arg_29_1.time_ and arg_29_1.time_ <= var_32_1 + arg_32_0 then
				arg_29_1.var_.moveOldPos10022 = var_32_0.localPosition
				var_32_0.localScale = Vector3.New(1, 1, 1)

				arg_29_1:CheckSpriteTmpPos("10022", 3)

				local var_32_2 = var_32_0.childCount

				for iter_32_0 = 0, var_32_2 - 1 do
					local var_32_3 = var_32_0:GetChild(iter_32_0)

					if var_32_3.name == "" or not string.find(var_32_3.name, "split") then
						var_32_3.gameObject:SetActive(true)
					else
						var_32_3.gameObject:SetActive(false)
					end
				end
			end

			local var_32_4 = 0.001

			if var_32_1 <= arg_29_1.time_ and arg_29_1.time_ < var_32_1 + var_32_4 then
				local var_32_5 = (arg_29_1.time_ - var_32_1) / var_32_4
				local var_32_6 = Vector3.New(0, -315, -320)

				var_32_0.localPosition = Vector3.Lerp(arg_29_1.var_.moveOldPos10022, var_32_6, var_32_5)
			end

			if arg_29_1.time_ >= var_32_1 + var_32_4 and arg_29_1.time_ < var_32_1 + var_32_4 + arg_32_0 then
				var_32_0.localPosition = Vector3.New(0, -315, -320)
			end

			local var_32_7 = arg_29_1.actors_["10092_1"].transform
			local var_32_8 = 0

			if var_32_8 < arg_29_1.time_ and arg_29_1.time_ <= var_32_8 + arg_32_0 then
				arg_29_1.var_.moveOldPos10092_1 = var_32_7.localPosition
				var_32_7.localScale = Vector3.New(1, 1, 1)

				arg_29_1:CheckSpriteTmpPos("10092_1", 7)

				local var_32_9 = var_32_7.childCount

				for iter_32_1 = 0, var_32_9 - 1 do
					local var_32_10 = var_32_7:GetChild(iter_32_1)

					if var_32_10.name == "" or not string.find(var_32_10.name, "split") then
						var_32_10.gameObject:SetActive(true)
					else
						var_32_10.gameObject:SetActive(false)
					end
				end
			end

			local var_32_11 = 0.001

			if var_32_8 <= arg_29_1.time_ and arg_29_1.time_ < var_32_8 + var_32_11 then
				local var_32_12 = (arg_29_1.time_ - var_32_8) / var_32_11
				local var_32_13 = Vector3.New(0, -2000, 0)

				var_32_7.localPosition = Vector3.Lerp(arg_29_1.var_.moveOldPos10092_1, var_32_13, var_32_12)
			end

			if arg_29_1.time_ >= var_32_8 + var_32_11 and arg_29_1.time_ < var_32_8 + var_32_11 + arg_32_0 then
				var_32_7.localPosition = Vector3.New(0, -2000, 0)
			end

			local var_32_14 = arg_29_1.actors_["10022"]
			local var_32_15 = 0

			if var_32_15 < arg_29_1.time_ and arg_29_1.time_ <= var_32_15 + arg_32_0 and not isNil(var_32_14) and arg_29_1.var_.actorSpriteComps10022 == nil then
				arg_29_1.var_.actorSpriteComps10022 = var_32_14:GetComponentsInChildren(typeof(Image), true)
			end

			local var_32_16 = 2

			if var_32_15 <= arg_29_1.time_ and arg_29_1.time_ < var_32_15 + var_32_16 and not isNil(var_32_14) then
				local var_32_17 = (arg_29_1.time_ - var_32_15) / var_32_16

				if arg_29_1.var_.actorSpriteComps10022 then
					for iter_32_2, iter_32_3 in pairs(arg_29_1.var_.actorSpriteComps10022:ToTable()) do
						if iter_32_3 then
							if arg_29_1.isInRecall_ then
								local var_32_18 = Mathf.Lerp(iter_32_3.color.r, arg_29_1.hightColor1.r, var_32_17)
								local var_32_19 = Mathf.Lerp(iter_32_3.color.g, arg_29_1.hightColor1.g, var_32_17)
								local var_32_20 = Mathf.Lerp(iter_32_3.color.b, arg_29_1.hightColor1.b, var_32_17)

								iter_32_3.color = Color.New(var_32_18, var_32_19, var_32_20)
							else
								local var_32_21 = Mathf.Lerp(iter_32_3.color.r, 1, var_32_17)

								iter_32_3.color = Color.New(var_32_21, var_32_21, var_32_21)
							end
						end
					end
				end
			end

			if arg_29_1.time_ >= var_32_15 + var_32_16 and arg_29_1.time_ < var_32_15 + var_32_16 + arg_32_0 and not isNil(var_32_14) and arg_29_1.var_.actorSpriteComps10022 then
				for iter_32_4, iter_32_5 in pairs(arg_29_1.var_.actorSpriteComps10022:ToTable()) do
					if iter_32_5 then
						if arg_29_1.isInRecall_ then
							iter_32_5.color = arg_29_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_32_5.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_29_1.var_.actorSpriteComps10022 = nil
			end

			local var_32_22 = arg_29_1.actors_["10092_1"]
			local var_32_23 = 0

			if var_32_23 < arg_29_1.time_ and arg_29_1.time_ <= var_32_23 + arg_32_0 and not isNil(var_32_22) and arg_29_1.var_.actorSpriteComps10092_1 == nil then
				arg_29_1.var_.actorSpriteComps10092_1 = var_32_22:GetComponentsInChildren(typeof(Image), true)
			end

			local var_32_24 = 2

			if var_32_23 <= arg_29_1.time_ and arg_29_1.time_ < var_32_23 + var_32_24 and not isNil(var_32_22) then
				local var_32_25 = (arg_29_1.time_ - var_32_23) / var_32_24

				if arg_29_1.var_.actorSpriteComps10092_1 then
					for iter_32_6, iter_32_7 in pairs(arg_29_1.var_.actorSpriteComps10092_1:ToTable()) do
						if iter_32_7 then
							if arg_29_1.isInRecall_ then
								local var_32_26 = Mathf.Lerp(iter_32_7.color.r, arg_29_1.hightColor2.r, var_32_25)
								local var_32_27 = Mathf.Lerp(iter_32_7.color.g, arg_29_1.hightColor2.g, var_32_25)
								local var_32_28 = Mathf.Lerp(iter_32_7.color.b, arg_29_1.hightColor2.b, var_32_25)

								iter_32_7.color = Color.New(var_32_26, var_32_27, var_32_28)
							else
								local var_32_29 = Mathf.Lerp(iter_32_7.color.r, 0.5, var_32_25)

								iter_32_7.color = Color.New(var_32_29, var_32_29, var_32_29)
							end
						end
					end
				end
			end

			if arg_29_1.time_ >= var_32_23 + var_32_24 and arg_29_1.time_ < var_32_23 + var_32_24 + arg_32_0 and not isNil(var_32_22) and arg_29_1.var_.actorSpriteComps10092_1 then
				for iter_32_8, iter_32_9 in pairs(arg_29_1.var_.actorSpriteComps10092_1:ToTable()) do
					if iter_32_9 then
						if arg_29_1.isInRecall_ then
							iter_32_9.color = arg_29_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_32_9.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_29_1.var_.actorSpriteComps10092_1 = nil
			end

			local var_32_30 = arg_29_1.actors_["10094"].transform
			local var_32_31 = 0

			if var_32_31 < arg_29_1.time_ and arg_29_1.time_ <= var_32_31 + arg_32_0 then
				arg_29_1.var_.moveOldPos10094 = var_32_30.localPosition
				var_32_30.localScale = Vector3.New(1, 1, 1)

				arg_29_1:CheckSpriteTmpPos("10094", 7)

				local var_32_32 = var_32_30.childCount

				for iter_32_10 = 0, var_32_32 - 1 do
					local var_32_33 = var_32_30:GetChild(iter_32_10)

					if var_32_33.name == "" or not string.find(var_32_33.name, "split") then
						var_32_33.gameObject:SetActive(true)
					else
						var_32_33.gameObject:SetActive(false)
					end
				end
			end

			local var_32_34 = 0.001

			if var_32_31 <= arg_29_1.time_ and arg_29_1.time_ < var_32_31 + var_32_34 then
				local var_32_35 = (arg_29_1.time_ - var_32_31) / var_32_34
				local var_32_36 = Vector3.New(0, -2000, 0)

				var_32_30.localPosition = Vector3.Lerp(arg_29_1.var_.moveOldPos10094, var_32_36, var_32_35)
			end

			if arg_29_1.time_ >= var_32_31 + var_32_34 and arg_29_1.time_ < var_32_31 + var_32_34 + arg_32_0 then
				var_32_30.localPosition = Vector3.New(0, -2000, 0)
			end

			local var_32_37 = 0
			local var_32_38 = 0.875

			if var_32_37 < arg_29_1.time_ and arg_29_1.time_ <= var_32_37 + arg_32_0 then
				arg_29_1.talkMaxDuration = 0
				arg_29_1.dialogCg_.alpha = 1

				arg_29_1.dialog_:SetActive(true)
				SetActive(arg_29_1.leftNameGo_, true)

				local var_32_39 = arg_29_1:FormatText(StoryNameCfg[614].name)

				arg_29_1.leftNameTxt_.text = var_32_39

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_29_1.leftNameTxt_.transform)

				arg_29_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_29_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_29_1:RecordName(arg_29_1.leftNameTxt_.text)
				SetActive(arg_29_1.iconTrs_.gameObject, false)
				arg_29_1.callingController_:SetSelectedState("normal")

				local var_32_40 = arg_29_1:GetWordFromCfg(413131007)
				local var_32_41 = arg_29_1:FormatText(var_32_40.content)

				arg_29_1.text_.text = var_32_41

				LuaForUtil.ClearLinePrefixSymbol(arg_29_1.text_)

				local var_32_42 = 35
				local var_32_43 = utf8.len(var_32_41)
				local var_32_44 = var_32_42 <= 0 and var_32_38 or var_32_38 * (var_32_43 / var_32_42)

				if var_32_44 > 0 and var_32_38 < var_32_44 then
					arg_29_1.talkMaxDuration = var_32_44

					if var_32_44 + var_32_37 > arg_29_1.duration_ then
						arg_29_1.duration_ = var_32_44 + var_32_37
					end
				end

				arg_29_1.text_.text = var_32_41
				arg_29_1.typewritter.percent = 0

				arg_29_1.typewritter:SetDirty()
				arg_29_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_413131", "413131007", "story_v_out_413131.awb") ~= 0 then
					local var_32_45 = manager.audio:GetVoiceLength("story_v_out_413131", "413131007", "story_v_out_413131.awb") / 1000

					if var_32_45 + var_32_37 > arg_29_1.duration_ then
						arg_29_1.duration_ = var_32_45 + var_32_37
					end

					if var_32_40.prefab_name ~= "" and arg_29_1.actors_[var_32_40.prefab_name] ~= nil then
						local var_32_46 = LuaForUtil.PlayVoiceWithCriLipsync(arg_29_1.actors_[var_32_40.prefab_name].transform, "story_v_out_413131", "413131007", "story_v_out_413131.awb")

						arg_29_1:RecordAudio("413131007", var_32_46)
						arg_29_1:RecordAudio("413131007", var_32_46)
					else
						arg_29_1:AudioAction("play", "voice", "story_v_out_413131", "413131007", "story_v_out_413131.awb")
					end

					arg_29_1:RecordHistoryTalkVoice("story_v_out_413131", "413131007", "story_v_out_413131.awb")
				end

				arg_29_1:RecordContent(arg_29_1.text_.text)
			end

			local var_32_47 = math.max(var_32_38, arg_29_1.talkMaxDuration)

			if var_32_37 <= arg_29_1.time_ and arg_29_1.time_ < var_32_37 + var_32_47 then
				arg_29_1.typewritter.percent = (arg_29_1.time_ - var_32_37) / var_32_47

				arg_29_1.typewritter:SetDirty()
			end

			if arg_29_1.time_ >= var_32_37 + var_32_47 and arg_29_1.time_ < var_32_37 + var_32_47 + arg_32_0 then
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

		arg_29_1:InitPlayNodeList()
	end,
	Play413131008 = function(arg_33_0, arg_33_1)
		arg_33_1.time_ = 0
		arg_33_1.frameCnt_ = 0
		arg_33_1.state_ = "playing"
		arg_33_1.curTalkId_ = 413131008
		arg_33_1.duration_ = 5.4

		local var_33_0 = {
			zh = 2.8,
			ja = 5.4
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
				arg_33_0:Play413131009(arg_33_1)
			end
		end

		function arg_33_1.onSingleLineUpdate_(arg_36_0)
			local var_36_0 = arg_33_1.actors_["10092_1"].transform
			local var_36_1 = 0

			if var_36_1 < arg_33_1.time_ and arg_33_1.time_ <= var_36_1 + arg_36_0 then
				arg_33_1.var_.moveOldPos10092_1 = var_36_0.localPosition
				var_36_0.localScale = Vector3.New(1, 1, 1)

				arg_33_1:CheckSpriteTmpPos("10092_1", 3)

				local var_36_2 = var_36_0.childCount

				for iter_36_0 = 0, var_36_2 - 1 do
					local var_36_3 = var_36_0:GetChild(iter_36_0)

					if var_36_3.name == "split_8" or not string.find(var_36_3.name, "split") then
						var_36_3.gameObject:SetActive(true)
					else
						var_36_3.gameObject:SetActive(false)
					end
				end
			end

			local var_36_4 = 0.001

			if var_36_1 <= arg_33_1.time_ and arg_33_1.time_ < var_36_1 + var_36_4 then
				local var_36_5 = (arg_33_1.time_ - var_36_1) / var_36_4
				local var_36_6 = Vector3.New(0, -300, -295)

				var_36_0.localPosition = Vector3.Lerp(arg_33_1.var_.moveOldPos10092_1, var_36_6, var_36_5)
			end

			if arg_33_1.time_ >= var_36_1 + var_36_4 and arg_33_1.time_ < var_36_1 + var_36_4 + arg_36_0 then
				var_36_0.localPosition = Vector3.New(0, -300, -295)
			end

			local var_36_7 = arg_33_1.actors_["10022"].transform
			local var_36_8 = 0

			if var_36_8 < arg_33_1.time_ and arg_33_1.time_ <= var_36_8 + arg_36_0 then
				arg_33_1.var_.moveOldPos10022 = var_36_7.localPosition
				var_36_7.localScale = Vector3.New(1, 1, 1)

				arg_33_1:CheckSpriteTmpPos("10022", 7)

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
				local var_36_13 = Vector3.New(0, -2000, 0)

				var_36_7.localPosition = Vector3.Lerp(arg_33_1.var_.moveOldPos10022, var_36_13, var_36_12)
			end

			if arg_33_1.time_ >= var_36_8 + var_36_11 and arg_33_1.time_ < var_36_8 + var_36_11 + arg_36_0 then
				var_36_7.localPosition = Vector3.New(0, -2000, 0)
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
			local var_36_31 = 0.4

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

				local var_36_33 = arg_33_1:GetWordFromCfg(413131008)
				local var_36_34 = arg_33_1:FormatText(var_36_33.content)

				arg_33_1.text_.text = var_36_34

				LuaForUtil.ClearLinePrefixSymbol(arg_33_1.text_)

				local var_36_35 = 16
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

				if manager.audio:GetVoiceLength("story_v_out_413131", "413131008", "story_v_out_413131.awb") ~= 0 then
					local var_36_38 = manager.audio:GetVoiceLength("story_v_out_413131", "413131008", "story_v_out_413131.awb") / 1000

					if var_36_38 + var_36_30 > arg_33_1.duration_ then
						arg_33_1.duration_ = var_36_38 + var_36_30
					end

					if var_36_33.prefab_name ~= "" and arg_33_1.actors_[var_36_33.prefab_name] ~= nil then
						local var_36_39 = LuaForUtil.PlayVoiceWithCriLipsync(arg_33_1.actors_[var_36_33.prefab_name].transform, "story_v_out_413131", "413131008", "story_v_out_413131.awb")

						arg_33_1:RecordAudio("413131008", var_36_39)
						arg_33_1:RecordAudio("413131008", var_36_39)
					else
						arg_33_1:AudioAction("play", "voice", "story_v_out_413131", "413131008", "story_v_out_413131.awb")
					end

					arg_33_1:RecordHistoryTalkVoice("story_v_out_413131", "413131008", "story_v_out_413131.awb")
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
	Play413131009 = function(arg_37_0, arg_37_1)
		arg_37_1.time_ = 0
		arg_37_1.frameCnt_ = 0
		arg_37_1.state_ = "playing"
		arg_37_1.curTalkId_ = 413131009
		arg_37_1.duration_ = 3.5

		local var_37_0 = {
			zh = 2.8,
			ja = 3.5
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
				arg_37_0:Play413131010(arg_37_1)
			end
		end

		function arg_37_1.onSingleLineUpdate_(arg_40_0)
			local var_40_0 = arg_37_1.actors_["10022"].transform
			local var_40_1 = 0

			if var_40_1 < arg_37_1.time_ and arg_37_1.time_ <= var_40_1 + arg_40_0 then
				arg_37_1.var_.moveOldPos10022 = var_40_0.localPosition
				var_40_0.localScale = Vector3.New(1, 1, 1)

				arg_37_1:CheckSpriteTmpPos("10022", 4)

				local var_40_2 = var_40_0.childCount

				for iter_40_0 = 0, var_40_2 - 1 do
					local var_40_3 = var_40_0:GetChild(iter_40_0)

					if var_40_3.name == "split_6" or not string.find(var_40_3.name, "split") then
						var_40_3.gameObject:SetActive(true)
					else
						var_40_3.gameObject:SetActive(false)
					end
				end
			end

			local var_40_4 = 0.001

			if var_40_1 <= arg_37_1.time_ and arg_37_1.time_ < var_40_1 + var_40_4 then
				local var_40_5 = (arg_37_1.time_ - var_40_1) / var_40_4
				local var_40_6 = Vector3.New(390, -315, -320)

				var_40_0.localPosition = Vector3.Lerp(arg_37_1.var_.moveOldPos10022, var_40_6, var_40_5)
			end

			if arg_37_1.time_ >= var_40_1 + var_40_4 and arg_37_1.time_ < var_40_1 + var_40_4 + arg_40_0 then
				var_40_0.localPosition = Vector3.New(390, -315, -320)
			end

			local var_40_7 = arg_37_1.actors_["10092_1"].transform
			local var_40_8 = 0

			if var_40_8 < arg_37_1.time_ and arg_37_1.time_ <= var_40_8 + arg_40_0 then
				arg_37_1.var_.moveOldPos10092_1 = var_40_7.localPosition
				var_40_7.localScale = Vector3.New(1, 1, 1)

				arg_37_1:CheckSpriteTmpPos("10092_1", 2)

				local var_40_9 = var_40_7.childCount

				for iter_40_1 = 0, var_40_9 - 1 do
					local var_40_10 = var_40_7:GetChild(iter_40_1)

					if var_40_10.name == "split_8" or not string.find(var_40_10.name, "split") then
						var_40_10.gameObject:SetActive(true)
					else
						var_40_10.gameObject:SetActive(false)
					end
				end
			end

			local var_40_11 = 0.001

			if var_40_8 <= arg_37_1.time_ and arg_37_1.time_ < var_40_8 + var_40_11 then
				local var_40_12 = (arg_37_1.time_ - var_40_8) / var_40_11
				local var_40_13 = Vector3.New(-389.49, -300, -295)

				var_40_7.localPosition = Vector3.Lerp(arg_37_1.var_.moveOldPos10092_1, var_40_13, var_40_12)
			end

			if arg_37_1.time_ >= var_40_8 + var_40_11 and arg_37_1.time_ < var_40_8 + var_40_11 + arg_40_0 then
				var_40_7.localPosition = Vector3.New(-389.49, -300, -295)
			end

			local var_40_14 = arg_37_1.actors_["10022"]
			local var_40_15 = 0

			if var_40_15 < arg_37_1.time_ and arg_37_1.time_ <= var_40_15 + arg_40_0 and not isNil(var_40_14) and arg_37_1.var_.actorSpriteComps10022 == nil then
				arg_37_1.var_.actorSpriteComps10022 = var_40_14:GetComponentsInChildren(typeof(Image), true)
			end

			local var_40_16 = 2

			if var_40_15 <= arg_37_1.time_ and arg_37_1.time_ < var_40_15 + var_40_16 and not isNil(var_40_14) then
				local var_40_17 = (arg_37_1.time_ - var_40_15) / var_40_16

				if arg_37_1.var_.actorSpriteComps10022 then
					for iter_40_2, iter_40_3 in pairs(arg_37_1.var_.actorSpriteComps10022:ToTable()) do
						if iter_40_3 then
							if arg_37_1.isInRecall_ then
								local var_40_18 = Mathf.Lerp(iter_40_3.color.r, arg_37_1.hightColor1.r, var_40_17)
								local var_40_19 = Mathf.Lerp(iter_40_3.color.g, arg_37_1.hightColor1.g, var_40_17)
								local var_40_20 = Mathf.Lerp(iter_40_3.color.b, arg_37_1.hightColor1.b, var_40_17)

								iter_40_3.color = Color.New(var_40_18, var_40_19, var_40_20)
							else
								local var_40_21 = Mathf.Lerp(iter_40_3.color.r, 1, var_40_17)

								iter_40_3.color = Color.New(var_40_21, var_40_21, var_40_21)
							end
						end
					end
				end
			end

			if arg_37_1.time_ >= var_40_15 + var_40_16 and arg_37_1.time_ < var_40_15 + var_40_16 + arg_40_0 and not isNil(var_40_14) and arg_37_1.var_.actorSpriteComps10022 then
				for iter_40_4, iter_40_5 in pairs(arg_37_1.var_.actorSpriteComps10022:ToTable()) do
					if iter_40_5 then
						if arg_37_1.isInRecall_ then
							iter_40_5.color = arg_37_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_40_5.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_37_1.var_.actorSpriteComps10022 = nil
			end

			local var_40_22 = arg_37_1.actors_["10092_1"]
			local var_40_23 = 0

			if var_40_23 < arg_37_1.time_ and arg_37_1.time_ <= var_40_23 + arg_40_0 and not isNil(var_40_22) and arg_37_1.var_.actorSpriteComps10092_1 == nil then
				arg_37_1.var_.actorSpriteComps10092_1 = var_40_22:GetComponentsInChildren(typeof(Image), true)
			end

			local var_40_24 = 2

			if var_40_23 <= arg_37_1.time_ and arg_37_1.time_ < var_40_23 + var_40_24 and not isNil(var_40_22) then
				local var_40_25 = (arg_37_1.time_ - var_40_23) / var_40_24

				if arg_37_1.var_.actorSpriteComps10092_1 then
					for iter_40_6, iter_40_7 in pairs(arg_37_1.var_.actorSpriteComps10092_1:ToTable()) do
						if iter_40_7 then
							if arg_37_1.isInRecall_ then
								local var_40_26 = Mathf.Lerp(iter_40_7.color.r, arg_37_1.hightColor2.r, var_40_25)
								local var_40_27 = Mathf.Lerp(iter_40_7.color.g, arg_37_1.hightColor2.g, var_40_25)
								local var_40_28 = Mathf.Lerp(iter_40_7.color.b, arg_37_1.hightColor2.b, var_40_25)

								iter_40_7.color = Color.New(var_40_26, var_40_27, var_40_28)
							else
								local var_40_29 = Mathf.Lerp(iter_40_7.color.r, 0.5, var_40_25)

								iter_40_7.color = Color.New(var_40_29, var_40_29, var_40_29)
							end
						end
					end
				end
			end

			if arg_37_1.time_ >= var_40_23 + var_40_24 and arg_37_1.time_ < var_40_23 + var_40_24 + arg_40_0 and not isNil(var_40_22) and arg_37_1.var_.actorSpriteComps10092_1 then
				for iter_40_8, iter_40_9 in pairs(arg_37_1.var_.actorSpriteComps10092_1:ToTable()) do
					if iter_40_9 then
						if arg_37_1.isInRecall_ then
							iter_40_9.color = arg_37_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_40_9.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_37_1.var_.actorSpriteComps10092_1 = nil
			end

			local var_40_30 = 0
			local var_40_31 = 0.35

			if var_40_30 < arg_37_1.time_ and arg_37_1.time_ <= var_40_30 + arg_40_0 then
				arg_37_1.talkMaxDuration = 0
				arg_37_1.dialogCg_.alpha = 1

				arg_37_1.dialog_:SetActive(true)
				SetActive(arg_37_1.leftNameGo_, true)

				local var_40_32 = arg_37_1:FormatText(StoryNameCfg[614].name)

				arg_37_1.leftNameTxt_.text = var_40_32

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_37_1.leftNameTxt_.transform)

				arg_37_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_37_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_37_1:RecordName(arg_37_1.leftNameTxt_.text)
				SetActive(arg_37_1.iconTrs_.gameObject, false)
				arg_37_1.callingController_:SetSelectedState("normal")

				local var_40_33 = arg_37_1:GetWordFromCfg(413131009)
				local var_40_34 = arg_37_1:FormatText(var_40_33.content)

				arg_37_1.text_.text = var_40_34

				LuaForUtil.ClearLinePrefixSymbol(arg_37_1.text_)

				local var_40_35 = 14
				local var_40_36 = utf8.len(var_40_34)
				local var_40_37 = var_40_35 <= 0 and var_40_31 or var_40_31 * (var_40_36 / var_40_35)

				if var_40_37 > 0 and var_40_31 < var_40_37 then
					arg_37_1.talkMaxDuration = var_40_37

					if var_40_37 + var_40_30 > arg_37_1.duration_ then
						arg_37_1.duration_ = var_40_37 + var_40_30
					end
				end

				arg_37_1.text_.text = var_40_34
				arg_37_1.typewritter.percent = 0

				arg_37_1.typewritter:SetDirty()
				arg_37_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_413131", "413131009", "story_v_out_413131.awb") ~= 0 then
					local var_40_38 = manager.audio:GetVoiceLength("story_v_out_413131", "413131009", "story_v_out_413131.awb") / 1000

					if var_40_38 + var_40_30 > arg_37_1.duration_ then
						arg_37_1.duration_ = var_40_38 + var_40_30
					end

					if var_40_33.prefab_name ~= "" and arg_37_1.actors_[var_40_33.prefab_name] ~= nil then
						local var_40_39 = LuaForUtil.PlayVoiceWithCriLipsync(arg_37_1.actors_[var_40_33.prefab_name].transform, "story_v_out_413131", "413131009", "story_v_out_413131.awb")

						arg_37_1:RecordAudio("413131009", var_40_39)
						arg_37_1:RecordAudio("413131009", var_40_39)
					else
						arg_37_1:AudioAction("play", "voice", "story_v_out_413131", "413131009", "story_v_out_413131.awb")
					end

					arg_37_1:RecordHistoryTalkVoice("story_v_out_413131", "413131009", "story_v_out_413131.awb")
				end

				arg_37_1:RecordContent(arg_37_1.text_.text)
			end

			local var_40_40 = math.max(var_40_31, arg_37_1.talkMaxDuration)

			if var_40_30 <= arg_37_1.time_ and arg_37_1.time_ < var_40_30 + var_40_40 then
				arg_37_1.typewritter.percent = (arg_37_1.time_ - var_40_30) / var_40_40

				arg_37_1.typewritter:SetDirty()
			end

			if arg_37_1.time_ >= var_40_30 + var_40_40 and arg_37_1.time_ < var_40_30 + var_40_40 + arg_40_0 then
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

		arg_37_1:InitPlayNodeList()
	end,
	Play413131010 = function(arg_41_0, arg_41_1)
		arg_41_1.time_ = 0
		arg_41_1.frameCnt_ = 0
		arg_41_1.state_ = "playing"
		arg_41_1.curTalkId_ = 413131010
		arg_41_1.duration_ = 9.7

		local var_41_0 = {
			zh = 8.733,
			ja = 9.7
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
				arg_41_0:Play413131011(arg_41_1)
			end
		end

		function arg_41_1.onSingleLineUpdate_(arg_44_0)
			local var_44_0 = arg_41_1.actors_["10092_1"].transform
			local var_44_1 = 0

			if var_44_1 < arg_41_1.time_ and arg_41_1.time_ <= var_44_1 + arg_44_0 then
				arg_41_1.var_.moveOldPos10092_1 = var_44_0.localPosition
				var_44_0.localScale = Vector3.New(1, 1, 1)

				arg_41_1:CheckSpriteTmpPos("10092_1", 2)

				local var_44_2 = var_44_0.childCount

				for iter_44_0 = 0, var_44_2 - 1 do
					local var_44_3 = var_44_0:GetChild(iter_44_0)

					if var_44_3.name == "split_1_1" or not string.find(var_44_3.name, "split") then
						var_44_3.gameObject:SetActive(true)
					else
						var_44_3.gameObject:SetActive(false)
					end
				end
			end

			local var_44_4 = 0.001

			if var_44_1 <= arg_41_1.time_ and arg_41_1.time_ < var_44_1 + var_44_4 then
				local var_44_5 = (arg_41_1.time_ - var_44_1) / var_44_4
				local var_44_6 = Vector3.New(-389.49, -300, -295)

				var_44_0.localPosition = Vector3.Lerp(arg_41_1.var_.moveOldPos10092_1, var_44_6, var_44_5)
			end

			if arg_41_1.time_ >= var_44_1 + var_44_4 and arg_41_1.time_ < var_44_1 + var_44_4 + arg_44_0 then
				var_44_0.localPosition = Vector3.New(-389.49, -300, -295)
			end

			local var_44_7 = arg_41_1.actors_["10022"].transform
			local var_44_8 = 0

			if var_44_8 < arg_41_1.time_ and arg_41_1.time_ <= var_44_8 + arg_44_0 then
				arg_41_1.var_.moveOldPos10022 = var_44_7.localPosition
				var_44_7.localScale = Vector3.New(1, 1, 1)

				arg_41_1:CheckSpriteTmpPos("10022", 4)

				local var_44_9 = var_44_7.childCount

				for iter_44_1 = 0, var_44_9 - 1 do
					local var_44_10 = var_44_7:GetChild(iter_44_1)

					if var_44_10.name == "split_6" or not string.find(var_44_10.name, "split") then
						var_44_10.gameObject:SetActive(true)
					else
						var_44_10.gameObject:SetActive(false)
					end
				end
			end

			local var_44_11 = 0.001

			if var_44_8 <= arg_41_1.time_ and arg_41_1.time_ < var_44_8 + var_44_11 then
				local var_44_12 = (arg_41_1.time_ - var_44_8) / var_44_11
				local var_44_13 = Vector3.New(390, -315, -320)

				var_44_7.localPosition = Vector3.Lerp(arg_41_1.var_.moveOldPos10022, var_44_13, var_44_12)
			end

			if arg_41_1.time_ >= var_44_8 + var_44_11 and arg_41_1.time_ < var_44_8 + var_44_11 + arg_44_0 then
				var_44_7.localPosition = Vector3.New(390, -315, -320)
			end

			local var_44_14 = arg_41_1.actors_["10092_1"]
			local var_44_15 = 0

			if var_44_15 < arg_41_1.time_ and arg_41_1.time_ <= var_44_15 + arg_44_0 and not isNil(var_44_14) and arg_41_1.var_.actorSpriteComps10092_1 == nil then
				arg_41_1.var_.actorSpriteComps10092_1 = var_44_14:GetComponentsInChildren(typeof(Image), true)
			end

			local var_44_16 = 2

			if var_44_15 <= arg_41_1.time_ and arg_41_1.time_ < var_44_15 + var_44_16 and not isNil(var_44_14) then
				local var_44_17 = (arg_41_1.time_ - var_44_15) / var_44_16

				if arg_41_1.var_.actorSpriteComps10092_1 then
					for iter_44_2, iter_44_3 in pairs(arg_41_1.var_.actorSpriteComps10092_1:ToTable()) do
						if iter_44_3 then
							if arg_41_1.isInRecall_ then
								local var_44_18 = Mathf.Lerp(iter_44_3.color.r, arg_41_1.hightColor1.r, var_44_17)
								local var_44_19 = Mathf.Lerp(iter_44_3.color.g, arg_41_1.hightColor1.g, var_44_17)
								local var_44_20 = Mathf.Lerp(iter_44_3.color.b, arg_41_1.hightColor1.b, var_44_17)

								iter_44_3.color = Color.New(var_44_18, var_44_19, var_44_20)
							else
								local var_44_21 = Mathf.Lerp(iter_44_3.color.r, 1, var_44_17)

								iter_44_3.color = Color.New(var_44_21, var_44_21, var_44_21)
							end
						end
					end
				end
			end

			if arg_41_1.time_ >= var_44_15 + var_44_16 and arg_41_1.time_ < var_44_15 + var_44_16 + arg_44_0 and not isNil(var_44_14) and arg_41_1.var_.actorSpriteComps10092_1 then
				for iter_44_4, iter_44_5 in pairs(arg_41_1.var_.actorSpriteComps10092_1:ToTable()) do
					if iter_44_5 then
						if arg_41_1.isInRecall_ then
							iter_44_5.color = arg_41_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_44_5.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_41_1.var_.actorSpriteComps10092_1 = nil
			end

			local var_44_22 = arg_41_1.actors_["10022"]
			local var_44_23 = 0

			if var_44_23 < arg_41_1.time_ and arg_41_1.time_ <= var_44_23 + arg_44_0 and not isNil(var_44_22) and arg_41_1.var_.actorSpriteComps10022 == nil then
				arg_41_1.var_.actorSpriteComps10022 = var_44_22:GetComponentsInChildren(typeof(Image), true)
			end

			local var_44_24 = 2

			if var_44_23 <= arg_41_1.time_ and arg_41_1.time_ < var_44_23 + var_44_24 and not isNil(var_44_22) then
				local var_44_25 = (arg_41_1.time_ - var_44_23) / var_44_24

				if arg_41_1.var_.actorSpriteComps10022 then
					for iter_44_6, iter_44_7 in pairs(arg_41_1.var_.actorSpriteComps10022:ToTable()) do
						if iter_44_7 then
							if arg_41_1.isInRecall_ then
								local var_44_26 = Mathf.Lerp(iter_44_7.color.r, arg_41_1.hightColor2.r, var_44_25)
								local var_44_27 = Mathf.Lerp(iter_44_7.color.g, arg_41_1.hightColor2.g, var_44_25)
								local var_44_28 = Mathf.Lerp(iter_44_7.color.b, arg_41_1.hightColor2.b, var_44_25)

								iter_44_7.color = Color.New(var_44_26, var_44_27, var_44_28)
							else
								local var_44_29 = Mathf.Lerp(iter_44_7.color.r, 0.5, var_44_25)

								iter_44_7.color = Color.New(var_44_29, var_44_29, var_44_29)
							end
						end
					end
				end
			end

			if arg_41_1.time_ >= var_44_23 + var_44_24 and arg_41_1.time_ < var_44_23 + var_44_24 + arg_44_0 and not isNil(var_44_22) and arg_41_1.var_.actorSpriteComps10022 then
				for iter_44_8, iter_44_9 in pairs(arg_41_1.var_.actorSpriteComps10022:ToTable()) do
					if iter_44_9 then
						if arg_41_1.isInRecall_ then
							iter_44_9.color = arg_41_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_44_9.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_41_1.var_.actorSpriteComps10022 = nil
			end

			local var_44_30 = 0
			local var_44_31 = 1.15

			if var_44_30 < arg_41_1.time_ and arg_41_1.time_ <= var_44_30 + arg_44_0 then
				arg_41_1.talkMaxDuration = 0
				arg_41_1.dialogCg_.alpha = 1

				arg_41_1.dialog_:SetActive(true)
				SetActive(arg_41_1.leftNameGo_, true)

				local var_44_32 = arg_41_1:FormatText(StoryNameCfg[996].name)

				arg_41_1.leftNameTxt_.text = var_44_32

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_41_1.leftNameTxt_.transform)

				arg_41_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_41_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_41_1:RecordName(arg_41_1.leftNameTxt_.text)
				SetActive(arg_41_1.iconTrs_.gameObject, false)
				arg_41_1.callingController_:SetSelectedState("normal")

				local var_44_33 = arg_41_1:GetWordFromCfg(413131010)
				local var_44_34 = arg_41_1:FormatText(var_44_33.content)

				arg_41_1.text_.text = var_44_34

				LuaForUtil.ClearLinePrefixSymbol(arg_41_1.text_)

				local var_44_35 = 46
				local var_44_36 = utf8.len(var_44_34)
				local var_44_37 = var_44_35 <= 0 and var_44_31 or var_44_31 * (var_44_36 / var_44_35)

				if var_44_37 > 0 and var_44_31 < var_44_37 then
					arg_41_1.talkMaxDuration = var_44_37

					if var_44_37 + var_44_30 > arg_41_1.duration_ then
						arg_41_1.duration_ = var_44_37 + var_44_30
					end
				end

				arg_41_1.text_.text = var_44_34
				arg_41_1.typewritter.percent = 0

				arg_41_1.typewritter:SetDirty()
				arg_41_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_413131", "413131010", "story_v_out_413131.awb") ~= 0 then
					local var_44_38 = manager.audio:GetVoiceLength("story_v_out_413131", "413131010", "story_v_out_413131.awb") / 1000

					if var_44_38 + var_44_30 > arg_41_1.duration_ then
						arg_41_1.duration_ = var_44_38 + var_44_30
					end

					if var_44_33.prefab_name ~= "" and arg_41_1.actors_[var_44_33.prefab_name] ~= nil then
						local var_44_39 = LuaForUtil.PlayVoiceWithCriLipsync(arg_41_1.actors_[var_44_33.prefab_name].transform, "story_v_out_413131", "413131010", "story_v_out_413131.awb")

						arg_41_1:RecordAudio("413131010", var_44_39)
						arg_41_1:RecordAudio("413131010", var_44_39)
					else
						arg_41_1:AudioAction("play", "voice", "story_v_out_413131", "413131010", "story_v_out_413131.awb")
					end

					arg_41_1:RecordHistoryTalkVoice("story_v_out_413131", "413131010", "story_v_out_413131.awb")
				end

				arg_41_1:RecordContent(arg_41_1.text_.text)
			end

			local var_44_40 = math.max(var_44_31, arg_41_1.talkMaxDuration)

			if var_44_30 <= arg_41_1.time_ and arg_41_1.time_ < var_44_30 + var_44_40 then
				arg_41_1.typewritter.percent = (arg_41_1.time_ - var_44_30) / var_44_40

				arg_41_1.typewritter:SetDirty()
			end

			if arg_41_1.time_ >= var_44_30 + var_44_40 and arg_41_1.time_ < var_44_30 + var_44_40 + arg_44_0 then
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

		arg_41_1:InitPlayNodeList()
	end,
	Play413131011 = function(arg_45_0, arg_45_1)
		arg_45_1.time_ = 0
		arg_45_1.frameCnt_ = 0
		arg_45_1.state_ = "playing"
		arg_45_1.curTalkId_ = 413131011
		arg_45_1.duration_ = 12.1

		local var_45_0 = {
			zh = 5.2,
			ja = 12.1
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
				arg_45_0:Play413131012(arg_45_1)
			end
		end

		function arg_45_1.onSingleLineUpdate_(arg_48_0)
			local var_48_0 = 0
			local var_48_1 = 0.675

			if var_48_0 < arg_45_1.time_ and arg_45_1.time_ <= var_48_0 + arg_48_0 then
				arg_45_1.talkMaxDuration = 0
				arg_45_1.dialogCg_.alpha = 1

				arg_45_1.dialog_:SetActive(true)
				SetActive(arg_45_1.leftNameGo_, true)

				local var_48_2 = arg_45_1:FormatText(StoryNameCfg[996].name)

				arg_45_1.leftNameTxt_.text = var_48_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_45_1.leftNameTxt_.transform)

				arg_45_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_45_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_45_1:RecordName(arg_45_1.leftNameTxt_.text)
				SetActive(arg_45_1.iconTrs_.gameObject, false)
				arg_45_1.callingController_:SetSelectedState("normal")

				local var_48_3 = arg_45_1:GetWordFromCfg(413131011)
				local var_48_4 = arg_45_1:FormatText(var_48_3.content)

				arg_45_1.text_.text = var_48_4

				LuaForUtil.ClearLinePrefixSymbol(arg_45_1.text_)

				local var_48_5 = 27
				local var_48_6 = utf8.len(var_48_4)
				local var_48_7 = var_48_5 <= 0 and var_48_1 or var_48_1 * (var_48_6 / var_48_5)

				if var_48_7 > 0 and var_48_1 < var_48_7 then
					arg_45_1.talkMaxDuration = var_48_7

					if var_48_7 + var_48_0 > arg_45_1.duration_ then
						arg_45_1.duration_ = var_48_7 + var_48_0
					end
				end

				arg_45_1.text_.text = var_48_4
				arg_45_1.typewritter.percent = 0

				arg_45_1.typewritter:SetDirty()
				arg_45_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_413131", "413131011", "story_v_out_413131.awb") ~= 0 then
					local var_48_8 = manager.audio:GetVoiceLength("story_v_out_413131", "413131011", "story_v_out_413131.awb") / 1000

					if var_48_8 + var_48_0 > arg_45_1.duration_ then
						arg_45_1.duration_ = var_48_8 + var_48_0
					end

					if var_48_3.prefab_name ~= "" and arg_45_1.actors_[var_48_3.prefab_name] ~= nil then
						local var_48_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_45_1.actors_[var_48_3.prefab_name].transform, "story_v_out_413131", "413131011", "story_v_out_413131.awb")

						arg_45_1:RecordAudio("413131011", var_48_9)
						arg_45_1:RecordAudio("413131011", var_48_9)
					else
						arg_45_1:AudioAction("play", "voice", "story_v_out_413131", "413131011", "story_v_out_413131.awb")
					end

					arg_45_1:RecordHistoryTalkVoice("story_v_out_413131", "413131011", "story_v_out_413131.awb")
				end

				arg_45_1:RecordContent(arg_45_1.text_.text)
			end

			local var_48_10 = math.max(var_48_1, arg_45_1.talkMaxDuration)

			if var_48_0 <= arg_45_1.time_ and arg_45_1.time_ < var_48_0 + var_48_10 then
				arg_45_1.typewritter.percent = (arg_45_1.time_ - var_48_0) / var_48_10

				arg_45_1.typewritter:SetDirty()
			end

			if arg_45_1.time_ >= var_48_0 + var_48_10 and arg_45_1.time_ < var_48_0 + var_48_10 + arg_48_0 then
				arg_45_1.typewritter.percent = 1

				arg_45_1.typewritter:SetDirty()
				arg_45_1:ShowNextGo(true)
			end
		end

		arg_45_1.nodeConfigList_ = {}

		arg_45_1:InitPlayNodeList()
	end,
	Play413131012 = function(arg_49_0, arg_49_1)
		arg_49_1.time_ = 0
		arg_49_1.frameCnt_ = 0
		arg_49_1.state_ = "playing"
		arg_49_1.curTalkId_ = 413131012
		arg_49_1.duration_ = 5.87

		local var_49_0 = {
			zh = 2.033,
			ja = 5.866
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
				arg_49_0:Play413131013(arg_49_1)
			end
		end

		function arg_49_1.onSingleLineUpdate_(arg_52_0)
			local var_52_0 = arg_49_1.actors_["10022"].transform
			local var_52_1 = 0

			if var_52_1 < arg_49_1.time_ and arg_49_1.time_ <= var_52_1 + arg_52_0 then
				arg_49_1.var_.moveOldPos10022 = var_52_0.localPosition
				var_52_0.localScale = Vector3.New(1, 1, 1)

				arg_49_1:CheckSpriteTmpPos("10022", 4)

				local var_52_2 = var_52_0.childCount

				for iter_52_0 = 0, var_52_2 - 1 do
					local var_52_3 = var_52_0:GetChild(iter_52_0)

					if var_52_3.name == "split_6" or not string.find(var_52_3.name, "split") then
						var_52_3.gameObject:SetActive(true)
					else
						var_52_3.gameObject:SetActive(false)
					end
				end
			end

			local var_52_4 = 0.001

			if var_52_1 <= arg_49_1.time_ and arg_49_1.time_ < var_52_1 + var_52_4 then
				local var_52_5 = (arg_49_1.time_ - var_52_1) / var_52_4
				local var_52_6 = Vector3.New(390, -315, -320)

				var_52_0.localPosition = Vector3.Lerp(arg_49_1.var_.moveOldPos10022, var_52_6, var_52_5)
			end

			if arg_49_1.time_ >= var_52_1 + var_52_4 and arg_49_1.time_ < var_52_1 + var_52_4 + arg_52_0 then
				var_52_0.localPosition = Vector3.New(390, -315, -320)
			end

			local var_52_7 = arg_49_1.actors_["10022"]
			local var_52_8 = 0

			if var_52_8 < arg_49_1.time_ and arg_49_1.time_ <= var_52_8 + arg_52_0 and not isNil(var_52_7) and arg_49_1.var_.actorSpriteComps10022 == nil then
				arg_49_1.var_.actorSpriteComps10022 = var_52_7:GetComponentsInChildren(typeof(Image), true)
			end

			local var_52_9 = 2

			if var_52_8 <= arg_49_1.time_ and arg_49_1.time_ < var_52_8 + var_52_9 and not isNil(var_52_7) then
				local var_52_10 = (arg_49_1.time_ - var_52_8) / var_52_9

				if arg_49_1.var_.actorSpriteComps10022 then
					for iter_52_1, iter_52_2 in pairs(arg_49_1.var_.actorSpriteComps10022:ToTable()) do
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

			if arg_49_1.time_ >= var_52_8 + var_52_9 and arg_49_1.time_ < var_52_8 + var_52_9 + arg_52_0 and not isNil(var_52_7) and arg_49_1.var_.actorSpriteComps10022 then
				for iter_52_3, iter_52_4 in pairs(arg_49_1.var_.actorSpriteComps10022:ToTable()) do
					if iter_52_4 then
						if arg_49_1.isInRecall_ then
							iter_52_4.color = arg_49_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_52_4.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_49_1.var_.actorSpriteComps10022 = nil
			end

			local var_52_15 = arg_49_1.actors_["10092_1"]
			local var_52_16 = 0

			if var_52_16 < arg_49_1.time_ and arg_49_1.time_ <= var_52_16 + arg_52_0 and not isNil(var_52_15) and arg_49_1.var_.actorSpriteComps10092_1 == nil then
				arg_49_1.var_.actorSpriteComps10092_1 = var_52_15:GetComponentsInChildren(typeof(Image), true)
			end

			local var_52_17 = 2

			if var_52_16 <= arg_49_1.time_ and arg_49_1.time_ < var_52_16 + var_52_17 and not isNil(var_52_15) then
				local var_52_18 = (arg_49_1.time_ - var_52_16) / var_52_17

				if arg_49_1.var_.actorSpriteComps10092_1 then
					for iter_52_5, iter_52_6 in pairs(arg_49_1.var_.actorSpriteComps10092_1:ToTable()) do
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

			if arg_49_1.time_ >= var_52_16 + var_52_17 and arg_49_1.time_ < var_52_16 + var_52_17 + arg_52_0 and not isNil(var_52_15) and arg_49_1.var_.actorSpriteComps10092_1 then
				for iter_52_7, iter_52_8 in pairs(arg_49_1.var_.actorSpriteComps10092_1:ToTable()) do
					if iter_52_8 then
						if arg_49_1.isInRecall_ then
							iter_52_8.color = arg_49_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_52_8.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_49_1.var_.actorSpriteComps10092_1 = nil
			end

			local var_52_23 = 0
			local var_52_24 = 0.25

			if var_52_23 < arg_49_1.time_ and arg_49_1.time_ <= var_52_23 + arg_52_0 then
				arg_49_1.talkMaxDuration = 0
				arg_49_1.dialogCg_.alpha = 1

				arg_49_1.dialog_:SetActive(true)
				SetActive(arg_49_1.leftNameGo_, true)

				local var_52_25 = arg_49_1:FormatText(StoryNameCfg[614].name)

				arg_49_1.leftNameTxt_.text = var_52_25

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_49_1.leftNameTxt_.transform)

				arg_49_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_49_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_49_1:RecordName(arg_49_1.leftNameTxt_.text)
				SetActive(arg_49_1.iconTrs_.gameObject, false)
				arg_49_1.callingController_:SetSelectedState("normal")

				local var_52_26 = arg_49_1:GetWordFromCfg(413131012)
				local var_52_27 = arg_49_1:FormatText(var_52_26.content)

				arg_49_1.text_.text = var_52_27

				LuaForUtil.ClearLinePrefixSymbol(arg_49_1.text_)

				local var_52_28 = 10
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

				if manager.audio:GetVoiceLength("story_v_out_413131", "413131012", "story_v_out_413131.awb") ~= 0 then
					local var_52_31 = manager.audio:GetVoiceLength("story_v_out_413131", "413131012", "story_v_out_413131.awb") / 1000

					if var_52_31 + var_52_23 > arg_49_1.duration_ then
						arg_49_1.duration_ = var_52_31 + var_52_23
					end

					if var_52_26.prefab_name ~= "" and arg_49_1.actors_[var_52_26.prefab_name] ~= nil then
						local var_52_32 = LuaForUtil.PlayVoiceWithCriLipsync(arg_49_1.actors_[var_52_26.prefab_name].transform, "story_v_out_413131", "413131012", "story_v_out_413131.awb")

						arg_49_1:RecordAudio("413131012", var_52_32)
						arg_49_1:RecordAudio("413131012", var_52_32)
					else
						arg_49_1:AudioAction("play", "voice", "story_v_out_413131", "413131012", "story_v_out_413131.awb")
					end

					arg_49_1:RecordHistoryTalkVoice("story_v_out_413131", "413131012", "story_v_out_413131.awb")
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
				actorName = "10022",
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
	Play413131013 = function(arg_53_0, arg_53_1)
		arg_53_1.time_ = 0
		arg_53_1.frameCnt_ = 0
		arg_53_1.state_ = "playing"
		arg_53_1.curTalkId_ = 413131013
		arg_53_1.duration_ = 6.7

		local var_53_0 = {
			zh = 4.166,
			ja = 6.7
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
				arg_53_0:Play413131014(arg_53_1)
			end
		end

		function arg_53_1.onSingleLineUpdate_(arg_56_0)
			local var_56_0 = arg_53_1.actors_["10022"].transform
			local var_56_1 = 0

			if var_56_1 < arg_53_1.time_ and arg_53_1.time_ <= var_56_1 + arg_56_0 then
				arg_53_1.var_.moveOldPos10022 = var_56_0.localPosition
				var_56_0.localScale = Vector3.New(1, 1, 1)

				arg_53_1:CheckSpriteTmpPos("10022", 6)

				local var_56_2 = var_56_0.childCount

				for iter_56_0 = 0, var_56_2 - 1 do
					local var_56_3 = var_56_0:GetChild(iter_56_0)

					if var_56_3.name == "" or not string.find(var_56_3.name, "split") then
						var_56_3.gameObject:SetActive(true)
					else
						var_56_3.gameObject:SetActive(false)
					end
				end
			end

			local var_56_4 = 0.001

			if var_56_1 <= arg_53_1.time_ and arg_53_1.time_ < var_56_1 + var_56_4 then
				local var_56_5 = (arg_53_1.time_ - var_56_1) / var_56_4
				local var_56_6 = Vector3.New(1500, -315, -320)

				var_56_0.localPosition = Vector3.Lerp(arg_53_1.var_.moveOldPos10022, var_56_6, var_56_5)
			end

			if arg_53_1.time_ >= var_56_1 + var_56_4 and arg_53_1.time_ < var_56_1 + var_56_4 + arg_56_0 then
				var_56_0.localPosition = Vector3.New(1500, -315, -320)
			end

			local var_56_7 = arg_53_1.actors_["10092_1"].transform
			local var_56_8 = 0

			if var_56_8 < arg_53_1.time_ and arg_53_1.time_ <= var_56_8 + arg_56_0 then
				arg_53_1.var_.moveOldPos10092_1 = var_56_7.localPosition
				var_56_7.localScale = Vector3.New(1, 1, 1)

				arg_53_1:CheckSpriteTmpPos("10092_1", 6)

				local var_56_9 = var_56_7.childCount

				for iter_56_1 = 0, var_56_9 - 1 do
					local var_56_10 = var_56_7:GetChild(iter_56_1)

					if var_56_10.name == "" or not string.find(var_56_10.name, "split") then
						var_56_10.gameObject:SetActive(true)
					else
						var_56_10.gameObject:SetActive(false)
					end
				end
			end

			local var_56_11 = 0.001

			if var_56_8 <= arg_53_1.time_ and arg_53_1.time_ < var_56_8 + var_56_11 then
				local var_56_12 = (arg_53_1.time_ - var_56_8) / var_56_11
				local var_56_13 = Vector3.New(1500, -300, -295)

				var_56_7.localPosition = Vector3.Lerp(arg_53_1.var_.moveOldPos10092_1, var_56_13, var_56_12)
			end

			if arg_53_1.time_ >= var_56_8 + var_56_11 and arg_53_1.time_ < var_56_8 + var_56_11 + arg_56_0 then
				var_56_7.localPosition = Vector3.New(1500, -300, -295)
			end

			local var_56_14 = arg_53_1.actors_["10022"]
			local var_56_15 = 0

			if var_56_15 < arg_53_1.time_ and arg_53_1.time_ <= var_56_15 + arg_56_0 and not isNil(var_56_14) and arg_53_1.var_.actorSpriteComps10022 == nil then
				arg_53_1.var_.actorSpriteComps10022 = var_56_14:GetComponentsInChildren(typeof(Image), true)
			end

			local var_56_16 = 2

			if var_56_15 <= arg_53_1.time_ and arg_53_1.time_ < var_56_15 + var_56_16 and not isNil(var_56_14) then
				local var_56_17 = (arg_53_1.time_ - var_56_15) / var_56_16

				if arg_53_1.var_.actorSpriteComps10022 then
					for iter_56_2, iter_56_3 in pairs(arg_53_1.var_.actorSpriteComps10022:ToTable()) do
						if iter_56_3 then
							if arg_53_1.isInRecall_ then
								local var_56_18 = Mathf.Lerp(iter_56_3.color.r, arg_53_1.hightColor2.r, var_56_17)
								local var_56_19 = Mathf.Lerp(iter_56_3.color.g, arg_53_1.hightColor2.g, var_56_17)
								local var_56_20 = Mathf.Lerp(iter_56_3.color.b, arg_53_1.hightColor2.b, var_56_17)

								iter_56_3.color = Color.New(var_56_18, var_56_19, var_56_20)
							else
								local var_56_21 = Mathf.Lerp(iter_56_3.color.r, 0.5, var_56_17)

								iter_56_3.color = Color.New(var_56_21, var_56_21, var_56_21)
							end
						end
					end
				end
			end

			if arg_53_1.time_ >= var_56_15 + var_56_16 and arg_53_1.time_ < var_56_15 + var_56_16 + arg_56_0 and not isNil(var_56_14) and arg_53_1.var_.actorSpriteComps10022 then
				for iter_56_4, iter_56_5 in pairs(arg_53_1.var_.actorSpriteComps10022:ToTable()) do
					if iter_56_5 then
						if arg_53_1.isInRecall_ then
							iter_56_5.color = arg_53_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_56_5.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_53_1.var_.actorSpriteComps10022 = nil
			end

			local var_56_22 = arg_53_1.actors_["10092_1"]
			local var_56_23 = 0

			if var_56_23 < arg_53_1.time_ and arg_53_1.time_ <= var_56_23 + arg_56_0 and not isNil(var_56_22) and arg_53_1.var_.actorSpriteComps10092_1 == nil then
				arg_53_1.var_.actorSpriteComps10092_1 = var_56_22:GetComponentsInChildren(typeof(Image), true)
			end

			local var_56_24 = 2

			if var_56_23 <= arg_53_1.time_ and arg_53_1.time_ < var_56_23 + var_56_24 and not isNil(var_56_22) then
				local var_56_25 = (arg_53_1.time_ - var_56_23) / var_56_24

				if arg_53_1.var_.actorSpriteComps10092_1 then
					for iter_56_6, iter_56_7 in pairs(arg_53_1.var_.actorSpriteComps10092_1:ToTable()) do
						if iter_56_7 then
							if arg_53_1.isInRecall_ then
								local var_56_26 = Mathf.Lerp(iter_56_7.color.r, arg_53_1.hightColor2.r, var_56_25)
								local var_56_27 = Mathf.Lerp(iter_56_7.color.g, arg_53_1.hightColor2.g, var_56_25)
								local var_56_28 = Mathf.Lerp(iter_56_7.color.b, arg_53_1.hightColor2.b, var_56_25)

								iter_56_7.color = Color.New(var_56_26, var_56_27, var_56_28)
							else
								local var_56_29 = Mathf.Lerp(iter_56_7.color.r, 0.5, var_56_25)

								iter_56_7.color = Color.New(var_56_29, var_56_29, var_56_29)
							end
						end
					end
				end
			end

			if arg_53_1.time_ >= var_56_23 + var_56_24 and arg_53_1.time_ < var_56_23 + var_56_24 + arg_56_0 and not isNil(var_56_22) and arg_53_1.var_.actorSpriteComps10092_1 then
				for iter_56_8, iter_56_9 in pairs(arg_53_1.var_.actorSpriteComps10092_1:ToTable()) do
					if iter_56_9 then
						if arg_53_1.isInRecall_ then
							iter_56_9.color = arg_53_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_56_9.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_53_1.var_.actorSpriteComps10092_1 = nil
			end

			local var_56_30 = manager.ui.mainCamera.transform
			local var_56_31 = 0

			if var_56_31 < arg_53_1.time_ and arg_53_1.time_ <= var_56_31 + arg_56_0 then
				arg_53_1.var_.shakeOldPos = var_56_30.localPosition
			end

			local var_56_32 = 0.6

			if var_56_31 <= arg_53_1.time_ and arg_53_1.time_ < var_56_31 + var_56_32 then
				local var_56_33 = (arg_53_1.time_ - var_56_31) / 0.066
				local var_56_34, var_56_35 = math.modf(var_56_33)

				var_56_30.localPosition = Vector3.New(var_56_35 * 0.13, var_56_35 * 0.13, var_56_35 * 0.13) + arg_53_1.var_.shakeOldPos
			end

			if arg_53_1.time_ >= var_56_31 + var_56_32 and arg_53_1.time_ < var_56_31 + var_56_32 + arg_56_0 then
				var_56_30.localPosition = arg_53_1.var_.shakeOldPos
			end

			local var_56_36 = 0

			if var_56_36 < arg_53_1.time_ and arg_53_1.time_ <= var_56_36 + arg_56_0 then
				arg_53_1.allBtn_.enabled = false
			end

			local var_56_37 = 0.6

			if arg_53_1.time_ >= var_56_36 + var_56_37 and arg_53_1.time_ < var_56_36 + var_56_37 + arg_56_0 then
				arg_53_1.allBtn_.enabled = true
			end

			local var_56_38 = 0
			local var_56_39 = 0.475

			if var_56_38 < arg_53_1.time_ and arg_53_1.time_ <= var_56_38 + arg_56_0 then
				arg_53_1.talkMaxDuration = 0
				arg_53_1.dialogCg_.alpha = 1

				arg_53_1.dialog_:SetActive(true)
				SetActive(arg_53_1.leftNameGo_, true)

				local var_56_40 = arg_53_1:FormatText(StoryNameCfg[996].name)

				arg_53_1.leftNameTxt_.text = var_56_40

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_53_1.leftNameTxt_.transform)

				arg_53_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_53_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_53_1:RecordName(arg_53_1.leftNameTxt_.text)
				SetActive(arg_53_1.iconTrs_.gameObject, true)
				arg_53_1.iconController_:SetSelectedState("hero")

				arg_53_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_10092_1_split_7")

				arg_53_1.callingController_:SetSelectedState("normal")

				arg_53_1.keyicon_.color = Color.New(1, 1, 1)
				arg_53_1.icon_.color = Color.New(1, 1, 1)

				local var_56_41 = arg_53_1:GetWordFromCfg(413131013)
				local var_56_42 = arg_53_1:FormatText(var_56_41.content)

				arg_53_1.text_.text = var_56_42

				LuaForUtil.ClearLinePrefixSymbol(arg_53_1.text_)

				local var_56_43 = 19
				local var_56_44 = utf8.len(var_56_42)
				local var_56_45 = var_56_43 <= 0 and var_56_39 or var_56_39 * (var_56_44 / var_56_43)

				if var_56_45 > 0 and var_56_39 < var_56_45 then
					arg_53_1.talkMaxDuration = var_56_45

					if var_56_45 + var_56_38 > arg_53_1.duration_ then
						arg_53_1.duration_ = var_56_45 + var_56_38
					end
				end

				arg_53_1.text_.text = var_56_42
				arg_53_1.typewritter.percent = 0

				arg_53_1.typewritter:SetDirty()
				arg_53_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_413131", "413131013", "story_v_out_413131.awb") ~= 0 then
					local var_56_46 = manager.audio:GetVoiceLength("story_v_out_413131", "413131013", "story_v_out_413131.awb") / 1000

					if var_56_46 + var_56_38 > arg_53_1.duration_ then
						arg_53_1.duration_ = var_56_46 + var_56_38
					end

					if var_56_41.prefab_name ~= "" and arg_53_1.actors_[var_56_41.prefab_name] ~= nil then
						local var_56_47 = LuaForUtil.PlayVoiceWithCriLipsync(arg_53_1.actors_[var_56_41.prefab_name].transform, "story_v_out_413131", "413131013", "story_v_out_413131.awb")

						arg_53_1:RecordAudio("413131013", var_56_47)
						arg_53_1:RecordAudio("413131013", var_56_47)
					else
						arg_53_1:AudioAction("play", "voice", "story_v_out_413131", "413131013", "story_v_out_413131.awb")
					end

					arg_53_1:RecordHistoryTalkVoice("story_v_out_413131", "413131013", "story_v_out_413131.awb")
				end

				arg_53_1:RecordContent(arg_53_1.text_.text)
			end

			local var_56_48 = math.max(var_56_39, arg_53_1.talkMaxDuration)

			if var_56_38 <= arg_53_1.time_ and arg_53_1.time_ < var_56_38 + var_56_48 then
				arg_53_1.typewritter.percent = (arg_53_1.time_ - var_56_38) / var_56_48

				arg_53_1.typewritter:SetDirty()
			end

			if arg_53_1.time_ >= var_56_38 + var_56_48 and arg_53_1.time_ < var_56_38 + var_56_48 + arg_56_0 then
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

		arg_53_1:InitPlayNodeList()
	end,
	Play413131014 = function(arg_57_0, arg_57_1)
		arg_57_1.time_ = 0
		arg_57_1.frameCnt_ = 0
		arg_57_1.state_ = "playing"
		arg_57_1.curTalkId_ = 413131014
		arg_57_1.duration_ = 3.97

		local var_57_0 = {
			zh = 3.866,
			ja = 3.966
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
				arg_57_0:Play413131015(arg_57_1)
			end
		end

		function arg_57_1.onSingleLineUpdate_(arg_60_0)
			local var_60_0 = "10093"

			if arg_57_1.actors_[var_60_0] == nil then
				local var_60_1 = Asset.Load("Widget/System/Story/StoryExpression/" .. "10093")

				if not isNil(var_60_1) then
					local var_60_2 = Object.Instantiate(var_60_1, arg_57_1.canvasGo_.transform)

					var_60_2.transform:SetSiblingIndex(1)

					var_60_2.name = var_60_0
					var_60_2.transform.localPosition = Vector3.New(0, 100000, 0)
					arg_57_1.actors_[var_60_0] = var_60_2

					local var_60_3 = var_60_2:GetComponentsInChildren(typeof(Image), true):ToTable()

					if arg_57_1.isInRecall_ then
						for iter_60_0, iter_60_1 in ipairs(var_60_3) do
							iter_60_1.color = arg_57_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						end
					end
				end
			end

			local var_60_4 = arg_57_1.actors_["10093"].transform
			local var_60_5 = 0

			if var_60_5 < arg_57_1.time_ and arg_57_1.time_ <= var_60_5 + arg_60_0 then
				arg_57_1.var_.moveOldPos10093 = var_60_4.localPosition
				var_60_4.localScale = Vector3.New(1, 1, 1)

				arg_57_1:CheckSpriteTmpPos("10093", 3)

				local var_60_6 = var_60_4.childCount

				for iter_60_2 = 0, var_60_6 - 1 do
					local var_60_7 = var_60_4:GetChild(iter_60_2)

					if var_60_7.name == "split_6" or not string.find(var_60_7.name, "split") then
						var_60_7.gameObject:SetActive(true)
					else
						var_60_7.gameObject:SetActive(false)
					end
				end
			end

			local var_60_8 = 0.001

			if var_60_5 <= arg_57_1.time_ and arg_57_1.time_ < var_60_5 + var_60_8 then
				local var_60_9 = (arg_57_1.time_ - var_60_5) / var_60_8
				local var_60_10 = Vector3.New(0, -345, -245)

				var_60_4.localPosition = Vector3.Lerp(arg_57_1.var_.moveOldPos10093, var_60_10, var_60_9)
			end

			if arg_57_1.time_ >= var_60_5 + var_60_8 and arg_57_1.time_ < var_60_5 + var_60_8 + arg_60_0 then
				var_60_4.localPosition = Vector3.New(0, -345, -245)
			end

			local var_60_11 = arg_57_1.actors_["10093"]
			local var_60_12 = 0

			if var_60_12 < arg_57_1.time_ and arg_57_1.time_ <= var_60_12 + arg_60_0 and not isNil(var_60_11) and arg_57_1.var_.actorSpriteComps10093 == nil then
				arg_57_1.var_.actorSpriteComps10093 = var_60_11:GetComponentsInChildren(typeof(Image), true)
			end

			local var_60_13 = 2

			if var_60_12 <= arg_57_1.time_ and arg_57_1.time_ < var_60_12 + var_60_13 and not isNil(var_60_11) then
				local var_60_14 = (arg_57_1.time_ - var_60_12) / var_60_13

				if arg_57_1.var_.actorSpriteComps10093 then
					for iter_60_3, iter_60_4 in pairs(arg_57_1.var_.actorSpriteComps10093:ToTable()) do
						if iter_60_4 then
							if arg_57_1.isInRecall_ then
								local var_60_15 = Mathf.Lerp(iter_60_4.color.r, arg_57_1.hightColor1.r, var_60_14)
								local var_60_16 = Mathf.Lerp(iter_60_4.color.g, arg_57_1.hightColor1.g, var_60_14)
								local var_60_17 = Mathf.Lerp(iter_60_4.color.b, arg_57_1.hightColor1.b, var_60_14)

								iter_60_4.color = Color.New(var_60_15, var_60_16, var_60_17)
							else
								local var_60_18 = Mathf.Lerp(iter_60_4.color.r, 1, var_60_14)

								iter_60_4.color = Color.New(var_60_18, var_60_18, var_60_18)
							end
						end
					end
				end
			end

			if arg_57_1.time_ >= var_60_12 + var_60_13 and arg_57_1.time_ < var_60_12 + var_60_13 + arg_60_0 and not isNil(var_60_11) and arg_57_1.var_.actorSpriteComps10093 then
				for iter_60_5, iter_60_6 in pairs(arg_57_1.var_.actorSpriteComps10093:ToTable()) do
					if iter_60_6 then
						if arg_57_1.isInRecall_ then
							iter_60_6.color = arg_57_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_60_6.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_57_1.var_.actorSpriteComps10093 = nil
			end

			local var_60_19 = 0
			local var_60_20 = 0.45

			if var_60_19 < arg_57_1.time_ and arg_57_1.time_ <= var_60_19 + arg_60_0 then
				arg_57_1.talkMaxDuration = 0
				arg_57_1.dialogCg_.alpha = 1

				arg_57_1.dialog_:SetActive(true)
				SetActive(arg_57_1.leftNameGo_, true)

				local var_60_21 = arg_57_1:FormatText(StoryNameCfg[28].name)

				arg_57_1.leftNameTxt_.text = var_60_21

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_57_1.leftNameTxt_.transform)

				arg_57_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_57_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_57_1:RecordName(arg_57_1.leftNameTxt_.text)
				SetActive(arg_57_1.iconTrs_.gameObject, false)
				arg_57_1.callingController_:SetSelectedState("normal")

				local var_60_22 = arg_57_1:GetWordFromCfg(413131014)
				local var_60_23 = arg_57_1:FormatText(var_60_22.content)

				arg_57_1.text_.text = var_60_23

				LuaForUtil.ClearLinePrefixSymbol(arg_57_1.text_)

				local var_60_24 = 18
				local var_60_25 = utf8.len(var_60_23)
				local var_60_26 = var_60_24 <= 0 and var_60_20 or var_60_20 * (var_60_25 / var_60_24)

				if var_60_26 > 0 and var_60_20 < var_60_26 then
					arg_57_1.talkMaxDuration = var_60_26

					if var_60_26 + var_60_19 > arg_57_1.duration_ then
						arg_57_1.duration_ = var_60_26 + var_60_19
					end
				end

				arg_57_1.text_.text = var_60_23
				arg_57_1.typewritter.percent = 0

				arg_57_1.typewritter:SetDirty()
				arg_57_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_413131", "413131014", "story_v_out_413131.awb") ~= 0 then
					local var_60_27 = manager.audio:GetVoiceLength("story_v_out_413131", "413131014", "story_v_out_413131.awb") / 1000

					if var_60_27 + var_60_19 > arg_57_1.duration_ then
						arg_57_1.duration_ = var_60_27 + var_60_19
					end

					if var_60_22.prefab_name ~= "" and arg_57_1.actors_[var_60_22.prefab_name] ~= nil then
						local var_60_28 = LuaForUtil.PlayVoiceWithCriLipsync(arg_57_1.actors_[var_60_22.prefab_name].transform, "story_v_out_413131", "413131014", "story_v_out_413131.awb")

						arg_57_1:RecordAudio("413131014", var_60_28)
						arg_57_1:RecordAudio("413131014", var_60_28)
					else
						arg_57_1:AudioAction("play", "voice", "story_v_out_413131", "413131014", "story_v_out_413131.awb")
					end

					arg_57_1:RecordHistoryTalkVoice("story_v_out_413131", "413131014", "story_v_out_413131.awb")
				end

				arg_57_1:RecordContent(arg_57_1.text_.text)
			end

			local var_60_29 = math.max(var_60_20, arg_57_1.talkMaxDuration)

			if var_60_19 <= arg_57_1.time_ and arg_57_1.time_ < var_60_19 + var_60_29 then
				arg_57_1.typewritter.percent = (arg_57_1.time_ - var_60_19) / var_60_29

				arg_57_1.typewritter:SetDirty()
			end

			if arg_57_1.time_ >= var_60_19 + var_60_29 and arg_57_1.time_ < var_60_19 + var_60_29 + arg_60_0 then
				arg_57_1.typewritter.percent = 1

				arg_57_1.typewritter:SetDirty()
				arg_57_1:ShowNextGo(true)
			end
		end

		arg_57_1.nodeConfigList_ = {
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

		arg_57_1:InitPlayNodeList()
	end,
	Play413131015 = function(arg_61_0, arg_61_1)
		arg_61_1.time_ = 0
		arg_61_1.frameCnt_ = 0
		arg_61_1.state_ = "playing"
		arg_61_1.curTalkId_ = 413131015
		arg_61_1.duration_ = 14.43

		local var_61_0 = {
			zh = 7,
			ja = 14.433
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
				arg_61_0:Play413131016(arg_61_1)
			end
		end

		function arg_61_1.onSingleLineUpdate_(arg_64_0)
			local var_64_0 = arg_61_1.actors_["10093"].transform
			local var_64_1 = 0

			if var_64_1 < arg_61_1.time_ and arg_61_1.time_ <= var_64_1 + arg_64_0 then
				arg_61_1.var_.moveOldPos10093 = var_64_0.localPosition
				var_64_0.localScale = Vector3.New(1, 1, 1)

				arg_61_1:CheckSpriteTmpPos("10093", 2)

				local var_64_2 = var_64_0.childCount

				for iter_64_0 = 0, var_64_2 - 1 do
					local var_64_3 = var_64_0:GetChild(iter_64_0)

					if var_64_3.name == "split_6" or not string.find(var_64_3.name, "split") then
						var_64_3.gameObject:SetActive(true)
					else
						var_64_3.gameObject:SetActive(false)
					end
				end
			end

			local var_64_4 = 0.001

			if var_64_1 <= arg_61_1.time_ and arg_61_1.time_ < var_64_1 + var_64_4 then
				local var_64_5 = (arg_61_1.time_ - var_64_1) / var_64_4
				local var_64_6 = Vector3.New(-390, -345, -245)

				var_64_0.localPosition = Vector3.Lerp(arg_61_1.var_.moveOldPos10093, var_64_6, var_64_5)
			end

			if arg_61_1.time_ >= var_64_1 + var_64_4 and arg_61_1.time_ < var_64_1 + var_64_4 + arg_64_0 then
				var_64_0.localPosition = Vector3.New(-390, -345, -245)
			end

			local var_64_7 = arg_61_1.actors_["10092_1"].transform
			local var_64_8 = 0

			if var_64_8 < arg_61_1.time_ and arg_61_1.time_ <= var_64_8 + arg_64_0 then
				arg_61_1.var_.moveOldPos10092_1 = var_64_7.localPosition
				var_64_7.localScale = Vector3.New(1, 1, 1)

				arg_61_1:CheckSpriteTmpPos("10092_1", 4)

				local var_64_9 = var_64_7.childCount

				for iter_64_1 = 0, var_64_9 - 1 do
					local var_64_10 = var_64_7:GetChild(iter_64_1)

					if var_64_10.name == "split_7" or not string.find(var_64_10.name, "split") then
						var_64_10.gameObject:SetActive(true)
					else
						var_64_10.gameObject:SetActive(false)
					end
				end
			end

			local var_64_11 = 0.001

			if var_64_8 <= arg_61_1.time_ and arg_61_1.time_ < var_64_8 + var_64_11 then
				local var_64_12 = (arg_61_1.time_ - var_64_8) / var_64_11
				local var_64_13 = Vector3.New(390, -300, -295)

				var_64_7.localPosition = Vector3.Lerp(arg_61_1.var_.moveOldPos10092_1, var_64_13, var_64_12)
			end

			if arg_61_1.time_ >= var_64_8 + var_64_11 and arg_61_1.time_ < var_64_8 + var_64_11 + arg_64_0 then
				var_64_7.localPosition = Vector3.New(390, -300, -295)
			end

			local var_64_14 = arg_61_1.actors_["10093"]
			local var_64_15 = 0

			if var_64_15 < arg_61_1.time_ and arg_61_1.time_ <= var_64_15 + arg_64_0 and not isNil(var_64_14) and arg_61_1.var_.actorSpriteComps10093 == nil then
				arg_61_1.var_.actorSpriteComps10093 = var_64_14:GetComponentsInChildren(typeof(Image), true)
			end

			local var_64_16 = 2

			if var_64_15 <= arg_61_1.time_ and arg_61_1.time_ < var_64_15 + var_64_16 and not isNil(var_64_14) then
				local var_64_17 = (arg_61_1.time_ - var_64_15) / var_64_16

				if arg_61_1.var_.actorSpriteComps10093 then
					for iter_64_2, iter_64_3 in pairs(arg_61_1.var_.actorSpriteComps10093:ToTable()) do
						if iter_64_3 then
							if arg_61_1.isInRecall_ then
								local var_64_18 = Mathf.Lerp(iter_64_3.color.r, arg_61_1.hightColor2.r, var_64_17)
								local var_64_19 = Mathf.Lerp(iter_64_3.color.g, arg_61_1.hightColor2.g, var_64_17)
								local var_64_20 = Mathf.Lerp(iter_64_3.color.b, arg_61_1.hightColor2.b, var_64_17)

								iter_64_3.color = Color.New(var_64_18, var_64_19, var_64_20)
							else
								local var_64_21 = Mathf.Lerp(iter_64_3.color.r, 0.5, var_64_17)

								iter_64_3.color = Color.New(var_64_21, var_64_21, var_64_21)
							end
						end
					end
				end
			end

			if arg_61_1.time_ >= var_64_15 + var_64_16 and arg_61_1.time_ < var_64_15 + var_64_16 + arg_64_0 and not isNil(var_64_14) and arg_61_1.var_.actorSpriteComps10093 then
				for iter_64_4, iter_64_5 in pairs(arg_61_1.var_.actorSpriteComps10093:ToTable()) do
					if iter_64_5 then
						if arg_61_1.isInRecall_ then
							iter_64_5.color = arg_61_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_64_5.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_61_1.var_.actorSpriteComps10093 = nil
			end

			local var_64_22 = arg_61_1.actors_["10092_1"]
			local var_64_23 = 0

			if var_64_23 < arg_61_1.time_ and arg_61_1.time_ <= var_64_23 + arg_64_0 and not isNil(var_64_22) and arg_61_1.var_.actorSpriteComps10092_1 == nil then
				arg_61_1.var_.actorSpriteComps10092_1 = var_64_22:GetComponentsInChildren(typeof(Image), true)
			end

			local var_64_24 = 2

			if var_64_23 <= arg_61_1.time_ and arg_61_1.time_ < var_64_23 + var_64_24 and not isNil(var_64_22) then
				local var_64_25 = (arg_61_1.time_ - var_64_23) / var_64_24

				if arg_61_1.var_.actorSpriteComps10092_1 then
					for iter_64_6, iter_64_7 in pairs(arg_61_1.var_.actorSpriteComps10092_1:ToTable()) do
						if iter_64_7 then
							if arg_61_1.isInRecall_ then
								local var_64_26 = Mathf.Lerp(iter_64_7.color.r, arg_61_1.hightColor1.r, var_64_25)
								local var_64_27 = Mathf.Lerp(iter_64_7.color.g, arg_61_1.hightColor1.g, var_64_25)
								local var_64_28 = Mathf.Lerp(iter_64_7.color.b, arg_61_1.hightColor1.b, var_64_25)

								iter_64_7.color = Color.New(var_64_26, var_64_27, var_64_28)
							else
								local var_64_29 = Mathf.Lerp(iter_64_7.color.r, 1, var_64_25)

								iter_64_7.color = Color.New(var_64_29, var_64_29, var_64_29)
							end
						end
					end
				end
			end

			if arg_61_1.time_ >= var_64_23 + var_64_24 and arg_61_1.time_ < var_64_23 + var_64_24 + arg_64_0 and not isNil(var_64_22) and arg_61_1.var_.actorSpriteComps10092_1 then
				for iter_64_8, iter_64_9 in pairs(arg_61_1.var_.actorSpriteComps10092_1:ToTable()) do
					if iter_64_9 then
						if arg_61_1.isInRecall_ then
							iter_64_9.color = arg_61_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_64_9.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_61_1.var_.actorSpriteComps10092_1 = nil
			end

			local var_64_30 = 0
			local var_64_31 = 0.525

			if var_64_30 < arg_61_1.time_ and arg_61_1.time_ <= var_64_30 + arg_64_0 then
				arg_61_1.talkMaxDuration = 0
				arg_61_1.dialogCg_.alpha = 1

				arg_61_1.dialog_:SetActive(true)
				SetActive(arg_61_1.leftNameGo_, true)

				local var_64_32 = arg_61_1:FormatText(StoryNameCfg[996].name)

				arg_61_1.leftNameTxt_.text = var_64_32

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_61_1.leftNameTxt_.transform)

				arg_61_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_61_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_61_1:RecordName(arg_61_1.leftNameTxt_.text)
				SetActive(arg_61_1.iconTrs_.gameObject, false)
				arg_61_1.callingController_:SetSelectedState("normal")

				local var_64_33 = arg_61_1:GetWordFromCfg(413131015)
				local var_64_34 = arg_61_1:FormatText(var_64_33.content)

				arg_61_1.text_.text = var_64_34

				LuaForUtil.ClearLinePrefixSymbol(arg_61_1.text_)

				local var_64_35 = 21
				local var_64_36 = utf8.len(var_64_34)
				local var_64_37 = var_64_35 <= 0 and var_64_31 or var_64_31 * (var_64_36 / var_64_35)

				if var_64_37 > 0 and var_64_31 < var_64_37 then
					arg_61_1.talkMaxDuration = var_64_37

					if var_64_37 + var_64_30 > arg_61_1.duration_ then
						arg_61_1.duration_ = var_64_37 + var_64_30
					end
				end

				arg_61_1.text_.text = var_64_34
				arg_61_1.typewritter.percent = 0

				arg_61_1.typewritter:SetDirty()
				arg_61_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_413131", "413131015", "story_v_out_413131.awb") ~= 0 then
					local var_64_38 = manager.audio:GetVoiceLength("story_v_out_413131", "413131015", "story_v_out_413131.awb") / 1000

					if var_64_38 + var_64_30 > arg_61_1.duration_ then
						arg_61_1.duration_ = var_64_38 + var_64_30
					end

					if var_64_33.prefab_name ~= "" and arg_61_1.actors_[var_64_33.prefab_name] ~= nil then
						local var_64_39 = LuaForUtil.PlayVoiceWithCriLipsync(arg_61_1.actors_[var_64_33.prefab_name].transform, "story_v_out_413131", "413131015", "story_v_out_413131.awb")

						arg_61_1:RecordAudio("413131015", var_64_39)
						arg_61_1:RecordAudio("413131015", var_64_39)
					else
						arg_61_1:AudioAction("play", "voice", "story_v_out_413131", "413131015", "story_v_out_413131.awb")
					end

					arg_61_1:RecordHistoryTalkVoice("story_v_out_413131", "413131015", "story_v_out_413131.awb")
				end

				arg_61_1:RecordContent(arg_61_1.text_.text)
			end

			local var_64_40 = math.max(var_64_31, arg_61_1.talkMaxDuration)

			if var_64_30 <= arg_61_1.time_ and arg_61_1.time_ < var_64_30 + var_64_40 then
				arg_61_1.typewritter.percent = (arg_61_1.time_ - var_64_30) / var_64_40

				arg_61_1.typewritter:SetDirty()
			end

			if arg_61_1.time_ >= var_64_30 + var_64_40 and arg_61_1.time_ < var_64_30 + var_64_40 + arg_64_0 then
				arg_61_1.typewritter.percent = 1

				arg_61_1.typewritter:SetDirty()
				arg_61_1:ShowNextGo(true)
			end
		end

		arg_61_1.nodeConfigList_ = {
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

		arg_61_1:InitPlayNodeList()
	end,
	Play413131016 = function(arg_65_0, arg_65_1)
		arg_65_1.time_ = 0
		arg_65_1.frameCnt_ = 0
		arg_65_1.state_ = "playing"
		arg_65_1.curTalkId_ = 413131016
		arg_65_1.duration_ = 4.87

		local var_65_0 = {
			zh = 4.466,
			ja = 4.866
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
				arg_65_0:Play413131017(arg_65_1)
			end
		end

		function arg_65_1.onSingleLineUpdate_(arg_68_0)
			local var_68_0 = arg_65_1.actors_["10093"].transform
			local var_68_1 = 0

			if var_68_1 < arg_65_1.time_ and arg_65_1.time_ <= var_68_1 + arg_68_0 then
				arg_65_1.var_.moveOldPos10093 = var_68_0.localPosition
				var_68_0.localScale = Vector3.New(1, 1, 1)

				arg_65_1:CheckSpriteTmpPos("10093", 2)

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
				local var_68_6 = Vector3.New(-390, -345, -245)

				var_68_0.localPosition = Vector3.Lerp(arg_65_1.var_.moveOldPos10093, var_68_6, var_68_5)
			end

			if arg_65_1.time_ >= var_68_1 + var_68_4 and arg_65_1.time_ < var_68_1 + var_68_4 + arg_68_0 then
				var_68_0.localPosition = Vector3.New(-390, -345, -245)
			end

			local var_68_7 = arg_65_1.actors_["10093"]
			local var_68_8 = 0

			if var_68_8 < arg_65_1.time_ and arg_65_1.time_ <= var_68_8 + arg_68_0 and not isNil(var_68_7) and arg_65_1.var_.actorSpriteComps10093 == nil then
				arg_65_1.var_.actorSpriteComps10093 = var_68_7:GetComponentsInChildren(typeof(Image), true)
			end

			local var_68_9 = 2

			if var_68_8 <= arg_65_1.time_ and arg_65_1.time_ < var_68_8 + var_68_9 and not isNil(var_68_7) then
				local var_68_10 = (arg_65_1.time_ - var_68_8) / var_68_9

				if arg_65_1.var_.actorSpriteComps10093 then
					for iter_68_1, iter_68_2 in pairs(arg_65_1.var_.actorSpriteComps10093:ToTable()) do
						if iter_68_2 then
							if arg_65_1.isInRecall_ then
								local var_68_11 = Mathf.Lerp(iter_68_2.color.r, arg_65_1.hightColor1.r, var_68_10)
								local var_68_12 = Mathf.Lerp(iter_68_2.color.g, arg_65_1.hightColor1.g, var_68_10)
								local var_68_13 = Mathf.Lerp(iter_68_2.color.b, arg_65_1.hightColor1.b, var_68_10)

								iter_68_2.color = Color.New(var_68_11, var_68_12, var_68_13)
							else
								local var_68_14 = Mathf.Lerp(iter_68_2.color.r, 1, var_68_10)

								iter_68_2.color = Color.New(var_68_14, var_68_14, var_68_14)
							end
						end
					end
				end
			end

			if arg_65_1.time_ >= var_68_8 + var_68_9 and arg_65_1.time_ < var_68_8 + var_68_9 + arg_68_0 and not isNil(var_68_7) and arg_65_1.var_.actorSpriteComps10093 then
				for iter_68_3, iter_68_4 in pairs(arg_65_1.var_.actorSpriteComps10093:ToTable()) do
					if iter_68_4 then
						if arg_65_1.isInRecall_ then
							iter_68_4.color = arg_65_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_68_4.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_65_1.var_.actorSpriteComps10093 = nil
			end

			local var_68_15 = arg_65_1.actors_["10092_1"]
			local var_68_16 = 0

			if var_68_16 < arg_65_1.time_ and arg_65_1.time_ <= var_68_16 + arg_68_0 and not isNil(var_68_15) and arg_65_1.var_.actorSpriteComps10092_1 == nil then
				arg_65_1.var_.actorSpriteComps10092_1 = var_68_15:GetComponentsInChildren(typeof(Image), true)
			end

			local var_68_17 = 2

			if var_68_16 <= arg_65_1.time_ and arg_65_1.time_ < var_68_16 + var_68_17 and not isNil(var_68_15) then
				local var_68_18 = (arg_65_1.time_ - var_68_16) / var_68_17

				if arg_65_1.var_.actorSpriteComps10092_1 then
					for iter_68_5, iter_68_6 in pairs(arg_65_1.var_.actorSpriteComps10092_1:ToTable()) do
						if iter_68_6 then
							if arg_65_1.isInRecall_ then
								local var_68_19 = Mathf.Lerp(iter_68_6.color.r, arg_65_1.hightColor2.r, var_68_18)
								local var_68_20 = Mathf.Lerp(iter_68_6.color.g, arg_65_1.hightColor2.g, var_68_18)
								local var_68_21 = Mathf.Lerp(iter_68_6.color.b, arg_65_1.hightColor2.b, var_68_18)

								iter_68_6.color = Color.New(var_68_19, var_68_20, var_68_21)
							else
								local var_68_22 = Mathf.Lerp(iter_68_6.color.r, 0.5, var_68_18)

								iter_68_6.color = Color.New(var_68_22, var_68_22, var_68_22)
							end
						end
					end
				end
			end

			if arg_65_1.time_ >= var_68_16 + var_68_17 and arg_65_1.time_ < var_68_16 + var_68_17 + arg_68_0 and not isNil(var_68_15) and arg_65_1.var_.actorSpriteComps10092_1 then
				for iter_68_7, iter_68_8 in pairs(arg_65_1.var_.actorSpriteComps10092_1:ToTable()) do
					if iter_68_8 then
						if arg_65_1.isInRecall_ then
							iter_68_8.color = arg_65_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_68_8.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_65_1.var_.actorSpriteComps10092_1 = nil
			end

			local var_68_23 = 0
			local var_68_24 = 0.5

			if var_68_23 < arg_65_1.time_ and arg_65_1.time_ <= var_68_23 + arg_68_0 then
				arg_65_1.talkMaxDuration = 0
				arg_65_1.dialogCg_.alpha = 1

				arg_65_1.dialog_:SetActive(true)
				SetActive(arg_65_1.leftNameGo_, true)

				local var_68_25 = arg_65_1:FormatText(StoryNameCfg[28].name)

				arg_65_1.leftNameTxt_.text = var_68_25

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_65_1.leftNameTxt_.transform)

				arg_65_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_65_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_65_1:RecordName(arg_65_1.leftNameTxt_.text)
				SetActive(arg_65_1.iconTrs_.gameObject, false)
				arg_65_1.callingController_:SetSelectedState("normal")

				local var_68_26 = arg_65_1:GetWordFromCfg(413131016)
				local var_68_27 = arg_65_1:FormatText(var_68_26.content)

				arg_65_1.text_.text = var_68_27

				LuaForUtil.ClearLinePrefixSymbol(arg_65_1.text_)

				local var_68_28 = 20
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

				if manager.audio:GetVoiceLength("story_v_out_413131", "413131016", "story_v_out_413131.awb") ~= 0 then
					local var_68_31 = manager.audio:GetVoiceLength("story_v_out_413131", "413131016", "story_v_out_413131.awb") / 1000

					if var_68_31 + var_68_23 > arg_65_1.duration_ then
						arg_65_1.duration_ = var_68_31 + var_68_23
					end

					if var_68_26.prefab_name ~= "" and arg_65_1.actors_[var_68_26.prefab_name] ~= nil then
						local var_68_32 = LuaForUtil.PlayVoiceWithCriLipsync(arg_65_1.actors_[var_68_26.prefab_name].transform, "story_v_out_413131", "413131016", "story_v_out_413131.awb")

						arg_65_1:RecordAudio("413131016", var_68_32)
						arg_65_1:RecordAudio("413131016", var_68_32)
					else
						arg_65_1:AudioAction("play", "voice", "story_v_out_413131", "413131016", "story_v_out_413131.awb")
					end

					arg_65_1:RecordHistoryTalkVoice("story_v_out_413131", "413131016", "story_v_out_413131.awb")
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
	Play413131017 = function(arg_69_0, arg_69_1)
		arg_69_1.time_ = 0
		arg_69_1.frameCnt_ = 0
		arg_69_1.state_ = "playing"
		arg_69_1.curTalkId_ = 413131017
		arg_69_1.duration_ = 9.97

		local var_69_0 = {
			zh = 8.133,
			ja = 9.966
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
				arg_69_0:Play413131018(arg_69_1)
			end
		end

		function arg_69_1.onSingleLineUpdate_(arg_72_0)
			local var_72_0 = arg_69_1.actors_["10022"].transform
			local var_72_1 = 0

			if var_72_1 < arg_69_1.time_ and arg_69_1.time_ <= var_72_1 + arg_72_0 then
				arg_69_1.var_.moveOldPos10022 = var_72_0.localPosition
				var_72_0.localScale = Vector3.New(1, 1, 1)

				arg_69_1:CheckSpriteTmpPos("10022", 3)

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
				local var_72_6 = Vector3.New(0, -315, -320)

				var_72_0.localPosition = Vector3.Lerp(arg_69_1.var_.moveOldPos10022, var_72_6, var_72_5)
			end

			if arg_69_1.time_ >= var_72_1 + var_72_4 and arg_69_1.time_ < var_72_1 + var_72_4 + arg_72_0 then
				var_72_0.localPosition = Vector3.New(0, -315, -320)
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

			local var_72_15 = arg_69_1.actors_["10093"].transform
			local var_72_16 = 0

			if var_72_16 < arg_69_1.time_ and arg_69_1.time_ <= var_72_16 + arg_72_0 then
				arg_69_1.var_.moveOldPos10093 = var_72_15.localPosition
				var_72_15.localScale = Vector3.New(1, 1, 1)

				arg_69_1:CheckSpriteTmpPos("10093", 7)

				local var_72_17 = var_72_15.childCount

				for iter_72_5 = 0, var_72_17 - 1 do
					local var_72_18 = var_72_15:GetChild(iter_72_5)

					if var_72_18.name == "split_7" or not string.find(var_72_18.name, "split") then
						var_72_18.gameObject:SetActive(true)
					else
						var_72_18.gameObject:SetActive(false)
					end
				end
			end

			local var_72_19 = 0.001

			if var_72_16 <= arg_69_1.time_ and arg_69_1.time_ < var_72_16 + var_72_19 then
				local var_72_20 = (arg_69_1.time_ - var_72_16) / var_72_19
				local var_72_21 = Vector3.New(0, -2000, 0)

				var_72_15.localPosition = Vector3.Lerp(arg_69_1.var_.moveOldPos10093, var_72_21, var_72_20)
			end

			if arg_69_1.time_ >= var_72_16 + var_72_19 and arg_69_1.time_ < var_72_16 + var_72_19 + arg_72_0 then
				var_72_15.localPosition = Vector3.New(0, -2000, 0)
			end

			local var_72_22 = arg_69_1.actors_["10092_1"].transform
			local var_72_23 = 0

			if var_72_23 < arg_69_1.time_ and arg_69_1.time_ <= var_72_23 + arg_72_0 then
				arg_69_1.var_.moveOldPos10092_1 = var_72_22.localPosition
				var_72_22.localScale = Vector3.New(1, 1, 1)

				arg_69_1:CheckSpriteTmpPos("10092_1", 7)

				local var_72_24 = var_72_22.childCount

				for iter_72_6 = 0, var_72_24 - 1 do
					local var_72_25 = var_72_22:GetChild(iter_72_6)

					if var_72_25.name == "split_7" or not string.find(var_72_25.name, "split") then
						var_72_25.gameObject:SetActive(true)
					else
						var_72_25.gameObject:SetActive(false)
					end
				end
			end

			local var_72_26 = 0.001

			if var_72_23 <= arg_69_1.time_ and arg_69_1.time_ < var_72_23 + var_72_26 then
				local var_72_27 = (arg_69_1.time_ - var_72_23) / var_72_26
				local var_72_28 = Vector3.New(0, -2000, 0)

				var_72_22.localPosition = Vector3.Lerp(arg_69_1.var_.moveOldPos10092_1, var_72_28, var_72_27)
			end

			if arg_69_1.time_ >= var_72_23 + var_72_26 and arg_69_1.time_ < var_72_23 + var_72_26 + arg_72_0 then
				var_72_22.localPosition = Vector3.New(0, -2000, 0)
			end

			local var_72_29 = 0
			local var_72_30 = 1.1

			if var_72_29 < arg_69_1.time_ and arg_69_1.time_ <= var_72_29 + arg_72_0 then
				arg_69_1.talkMaxDuration = 0
				arg_69_1.dialogCg_.alpha = 1

				arg_69_1.dialog_:SetActive(true)
				SetActive(arg_69_1.leftNameGo_, true)

				local var_72_31 = arg_69_1:FormatText(StoryNameCfg[614].name)

				arg_69_1.leftNameTxt_.text = var_72_31

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_69_1.leftNameTxt_.transform)

				arg_69_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_69_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_69_1:RecordName(arg_69_1.leftNameTxt_.text)
				SetActive(arg_69_1.iconTrs_.gameObject, false)
				arg_69_1.callingController_:SetSelectedState("normal")

				local var_72_32 = arg_69_1:GetWordFromCfg(413131017)
				local var_72_33 = arg_69_1:FormatText(var_72_32.content)

				arg_69_1.text_.text = var_72_33

				LuaForUtil.ClearLinePrefixSymbol(arg_69_1.text_)

				local var_72_34 = 44
				local var_72_35 = utf8.len(var_72_33)
				local var_72_36 = var_72_34 <= 0 and var_72_30 or var_72_30 * (var_72_35 / var_72_34)

				if var_72_36 > 0 and var_72_30 < var_72_36 then
					arg_69_1.talkMaxDuration = var_72_36

					if var_72_36 + var_72_29 > arg_69_1.duration_ then
						arg_69_1.duration_ = var_72_36 + var_72_29
					end
				end

				arg_69_1.text_.text = var_72_33
				arg_69_1.typewritter.percent = 0

				arg_69_1.typewritter:SetDirty()
				arg_69_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_413131", "413131017", "story_v_out_413131.awb") ~= 0 then
					local var_72_37 = manager.audio:GetVoiceLength("story_v_out_413131", "413131017", "story_v_out_413131.awb") / 1000

					if var_72_37 + var_72_29 > arg_69_1.duration_ then
						arg_69_1.duration_ = var_72_37 + var_72_29
					end

					if var_72_32.prefab_name ~= "" and arg_69_1.actors_[var_72_32.prefab_name] ~= nil then
						local var_72_38 = LuaForUtil.PlayVoiceWithCriLipsync(arg_69_1.actors_[var_72_32.prefab_name].transform, "story_v_out_413131", "413131017", "story_v_out_413131.awb")

						arg_69_1:RecordAudio("413131017", var_72_38)
						arg_69_1:RecordAudio("413131017", var_72_38)
					else
						arg_69_1:AudioAction("play", "voice", "story_v_out_413131", "413131017", "story_v_out_413131.awb")
					end

					arg_69_1:RecordHistoryTalkVoice("story_v_out_413131", "413131017", "story_v_out_413131.awb")
				end

				arg_69_1:RecordContent(arg_69_1.text_.text)
			end

			local var_72_39 = math.max(var_72_30, arg_69_1.talkMaxDuration)

			if var_72_29 <= arg_69_1.time_ and arg_69_1.time_ < var_72_29 + var_72_39 then
				arg_69_1.typewritter.percent = (arg_69_1.time_ - var_72_29) / var_72_39

				arg_69_1.typewritter:SetDirty()
			end

			if arg_69_1.time_ >= var_72_29 + var_72_39 and arg_69_1.time_ < var_72_29 + var_72_39 + arg_72_0 then
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
	Play413131018 = function(arg_73_0, arg_73_1)
		arg_73_1.time_ = 0
		arg_73_1.frameCnt_ = 0
		arg_73_1.state_ = "playing"
		arg_73_1.curTalkId_ = 413131018
		arg_73_1.duration_ = 10.6

		local var_73_0 = {
			zh = 7.333,
			ja = 10.6
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
				arg_73_0:Play413131019(arg_73_1)
			end
		end

		function arg_73_1.onSingleLineUpdate_(arg_76_0)
			local var_76_0 = arg_73_1.actors_["10094"].transform
			local var_76_1 = 0

			if var_76_1 < arg_73_1.time_ and arg_73_1.time_ <= var_76_1 + arg_76_0 then
				arg_73_1.var_.moveOldPos10094 = var_76_0.localPosition
				var_76_0.localScale = Vector3.New(1, 1, 1)

				arg_73_1:CheckSpriteTmpPos("10094", 3)

				local var_76_2 = var_76_0.childCount

				for iter_76_0 = 0, var_76_2 - 1 do
					local var_76_3 = var_76_0:GetChild(iter_76_0)

					if var_76_3.name == "" or not string.find(var_76_3.name, "split") then
						var_76_3.gameObject:SetActive(true)
					else
						var_76_3.gameObject:SetActive(false)
					end
				end
			end

			local var_76_4 = 0.001

			if var_76_1 <= arg_73_1.time_ and arg_73_1.time_ < var_76_1 + var_76_4 then
				local var_76_5 = (arg_73_1.time_ - var_76_1) / var_76_4
				local var_76_6 = Vector3.New(0, -340, -414)

				var_76_0.localPosition = Vector3.Lerp(arg_73_1.var_.moveOldPos10094, var_76_6, var_76_5)
			end

			if arg_73_1.time_ >= var_76_1 + var_76_4 and arg_73_1.time_ < var_76_1 + var_76_4 + arg_76_0 then
				var_76_0.localPosition = Vector3.New(0, -340, -414)
			end

			local var_76_7 = arg_73_1.actors_["10022"]
			local var_76_8 = 0

			if var_76_8 < arg_73_1.time_ and arg_73_1.time_ <= var_76_8 + arg_76_0 and not isNil(var_76_7) and arg_73_1.var_.actorSpriteComps10022 == nil then
				arg_73_1.var_.actorSpriteComps10022 = var_76_7:GetComponentsInChildren(typeof(Image), true)
			end

			local var_76_9 = 2

			if var_76_8 <= arg_73_1.time_ and arg_73_1.time_ < var_76_8 + var_76_9 and not isNil(var_76_7) then
				local var_76_10 = (arg_73_1.time_ - var_76_8) / var_76_9

				if arg_73_1.var_.actorSpriteComps10022 then
					for iter_76_1, iter_76_2 in pairs(arg_73_1.var_.actorSpriteComps10022:ToTable()) do
						if iter_76_2 then
							if arg_73_1.isInRecall_ then
								local var_76_11 = Mathf.Lerp(iter_76_2.color.r, arg_73_1.hightColor2.r, var_76_10)
								local var_76_12 = Mathf.Lerp(iter_76_2.color.g, arg_73_1.hightColor2.g, var_76_10)
								local var_76_13 = Mathf.Lerp(iter_76_2.color.b, arg_73_1.hightColor2.b, var_76_10)

								iter_76_2.color = Color.New(var_76_11, var_76_12, var_76_13)
							else
								local var_76_14 = Mathf.Lerp(iter_76_2.color.r, 0.5, var_76_10)

								iter_76_2.color = Color.New(var_76_14, var_76_14, var_76_14)
							end
						end
					end
				end
			end

			if arg_73_1.time_ >= var_76_8 + var_76_9 and arg_73_1.time_ < var_76_8 + var_76_9 + arg_76_0 and not isNil(var_76_7) and arg_73_1.var_.actorSpriteComps10022 then
				for iter_76_3, iter_76_4 in pairs(arg_73_1.var_.actorSpriteComps10022:ToTable()) do
					if iter_76_4 then
						if arg_73_1.isInRecall_ then
							iter_76_4.color = arg_73_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_76_4.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_73_1.var_.actorSpriteComps10022 = nil
			end

			local var_76_15 = arg_73_1.actors_["10094"]
			local var_76_16 = 0

			if var_76_16 < arg_73_1.time_ and arg_73_1.time_ <= var_76_16 + arg_76_0 and not isNil(var_76_15) and arg_73_1.var_.actorSpriteComps10094 == nil then
				arg_73_1.var_.actorSpriteComps10094 = var_76_15:GetComponentsInChildren(typeof(Image), true)
			end

			local var_76_17 = 2

			if var_76_16 <= arg_73_1.time_ and arg_73_1.time_ < var_76_16 + var_76_17 and not isNil(var_76_15) then
				local var_76_18 = (arg_73_1.time_ - var_76_16) / var_76_17

				if arg_73_1.var_.actorSpriteComps10094 then
					for iter_76_5, iter_76_6 in pairs(arg_73_1.var_.actorSpriteComps10094:ToTable()) do
						if iter_76_6 then
							if arg_73_1.isInRecall_ then
								local var_76_19 = Mathf.Lerp(iter_76_6.color.r, arg_73_1.hightColor1.r, var_76_18)
								local var_76_20 = Mathf.Lerp(iter_76_6.color.g, arg_73_1.hightColor1.g, var_76_18)
								local var_76_21 = Mathf.Lerp(iter_76_6.color.b, arg_73_1.hightColor1.b, var_76_18)

								iter_76_6.color = Color.New(var_76_19, var_76_20, var_76_21)
							else
								local var_76_22 = Mathf.Lerp(iter_76_6.color.r, 1, var_76_18)

								iter_76_6.color = Color.New(var_76_22, var_76_22, var_76_22)
							end
						end
					end
				end
			end

			if arg_73_1.time_ >= var_76_16 + var_76_17 and arg_73_1.time_ < var_76_16 + var_76_17 + arg_76_0 and not isNil(var_76_15) and arg_73_1.var_.actorSpriteComps10094 then
				for iter_76_7, iter_76_8 in pairs(arg_73_1.var_.actorSpriteComps10094:ToTable()) do
					if iter_76_8 then
						if arg_73_1.isInRecall_ then
							iter_76_8.color = arg_73_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_76_8.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_73_1.var_.actorSpriteComps10094 = nil
			end

			local var_76_23 = 0
			local var_76_24 = 0.8

			if var_76_23 < arg_73_1.time_ and arg_73_1.time_ <= var_76_23 + arg_76_0 then
				arg_73_1.talkMaxDuration = 0
				arg_73_1.dialogCg_.alpha = 1

				arg_73_1.dialog_:SetActive(true)
				SetActive(arg_73_1.leftNameGo_, true)

				local var_76_25 = arg_73_1:FormatText(StoryNameCfg[259].name)

				arg_73_1.leftNameTxt_.text = var_76_25

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_73_1.leftNameTxt_.transform)

				arg_73_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_73_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_73_1:RecordName(arg_73_1.leftNameTxt_.text)
				SetActive(arg_73_1.iconTrs_.gameObject, false)
				arg_73_1.callingController_:SetSelectedState("normal")

				local var_76_26 = arg_73_1:GetWordFromCfg(413131018)
				local var_76_27 = arg_73_1:FormatText(var_76_26.content)

				arg_73_1.text_.text = var_76_27

				LuaForUtil.ClearLinePrefixSymbol(arg_73_1.text_)

				local var_76_28 = 32
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

				if manager.audio:GetVoiceLength("story_v_out_413131", "413131018", "story_v_out_413131.awb") ~= 0 then
					local var_76_31 = manager.audio:GetVoiceLength("story_v_out_413131", "413131018", "story_v_out_413131.awb") / 1000

					if var_76_31 + var_76_23 > arg_73_1.duration_ then
						arg_73_1.duration_ = var_76_31 + var_76_23
					end

					if var_76_26.prefab_name ~= "" and arg_73_1.actors_[var_76_26.prefab_name] ~= nil then
						local var_76_32 = LuaForUtil.PlayVoiceWithCriLipsync(arg_73_1.actors_[var_76_26.prefab_name].transform, "story_v_out_413131", "413131018", "story_v_out_413131.awb")

						arg_73_1:RecordAudio("413131018", var_76_32)
						arg_73_1:RecordAudio("413131018", var_76_32)
					else
						arg_73_1:AudioAction("play", "voice", "story_v_out_413131", "413131018", "story_v_out_413131.awb")
					end

					arg_73_1:RecordHistoryTalkVoice("story_v_out_413131", "413131018", "story_v_out_413131.awb")
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
				actorName = "10094",
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
	Play413131019 = function(arg_77_0, arg_77_1)
		arg_77_1.time_ = 0
		arg_77_1.frameCnt_ = 0
		arg_77_1.state_ = "playing"
		arg_77_1.curTalkId_ = 413131019
		arg_77_1.duration_ = 11.07

		local var_77_0 = {
			zh = 5.166,
			ja = 11.066
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
				arg_77_0:Play413131020(arg_77_1)
			end
		end

		function arg_77_1.onSingleLineUpdate_(arg_80_0)
			local var_80_0 = arg_77_1.actors_["10022"].transform
			local var_80_1 = 0

			if var_80_1 < arg_77_1.time_ and arg_77_1.time_ <= var_80_1 + arg_80_0 then
				arg_77_1.var_.moveOldPos10022 = var_80_0.localPosition
				var_80_0.localScale = Vector3.New(1, 1, 1)

				arg_77_1:CheckSpriteTmpPos("10022", 6)

				local var_80_2 = var_80_0.childCount

				for iter_80_0 = 0, var_80_2 - 1 do
					local var_80_3 = var_80_0:GetChild(iter_80_0)

					if var_80_3.name == "" or not string.find(var_80_3.name, "split") then
						var_80_3.gameObject:SetActive(true)
					else
						var_80_3.gameObject:SetActive(false)
					end
				end
			end

			local var_80_4 = 0.001

			if var_80_1 <= arg_77_1.time_ and arg_77_1.time_ < var_80_1 + var_80_4 then
				local var_80_5 = (arg_77_1.time_ - var_80_1) / var_80_4
				local var_80_6 = Vector3.New(1500, -315, -320)

				var_80_0.localPosition = Vector3.Lerp(arg_77_1.var_.moveOldPos10022, var_80_6, var_80_5)
			end

			if arg_77_1.time_ >= var_80_1 + var_80_4 and arg_77_1.time_ < var_80_1 + var_80_4 + arg_80_0 then
				var_80_0.localPosition = Vector3.New(1500, -315, -320)
			end

			local var_80_7 = arg_77_1.actors_["10094"].transform
			local var_80_8 = 0

			if var_80_8 < arg_77_1.time_ and arg_77_1.time_ <= var_80_8 + arg_80_0 then
				arg_77_1.var_.moveOldPos10094 = var_80_7.localPosition
				var_80_7.localScale = Vector3.New(1, 1, 1)

				arg_77_1:CheckSpriteTmpPos("10094", 6)

				local var_80_9 = var_80_7.childCount

				for iter_80_1 = 0, var_80_9 - 1 do
					local var_80_10 = var_80_7:GetChild(iter_80_1)

					if var_80_10.name == "" or not string.find(var_80_10.name, "split") then
						var_80_10.gameObject:SetActive(true)
					else
						var_80_10.gameObject:SetActive(false)
					end
				end
			end

			local var_80_11 = 0.001

			if var_80_8 <= arg_77_1.time_ and arg_77_1.time_ < var_80_8 + var_80_11 then
				local var_80_12 = (arg_77_1.time_ - var_80_8) / var_80_11
				local var_80_13 = Vector3.New(1500, -340, -414)

				var_80_7.localPosition = Vector3.Lerp(arg_77_1.var_.moveOldPos10094, var_80_13, var_80_12)
			end

			if arg_77_1.time_ >= var_80_8 + var_80_11 and arg_77_1.time_ < var_80_8 + var_80_11 + arg_80_0 then
				var_80_7.localPosition = Vector3.New(1500, -340, -414)
			end

			local var_80_14 = arg_77_1.actors_["10092_1"].transform
			local var_80_15 = 0

			if var_80_15 < arg_77_1.time_ and arg_77_1.time_ <= var_80_15 + arg_80_0 then
				arg_77_1.var_.moveOldPos10092_1 = var_80_14.localPosition
				var_80_14.localScale = Vector3.New(1, 1, 1)

				arg_77_1:CheckSpriteTmpPos("10092_1", 3)

				local var_80_16 = var_80_14.childCount

				for iter_80_2 = 0, var_80_16 - 1 do
					local var_80_17 = var_80_14:GetChild(iter_80_2)

					if var_80_17.name == "split_2" or not string.find(var_80_17.name, "split") then
						var_80_17.gameObject:SetActive(true)
					else
						var_80_17.gameObject:SetActive(false)
					end
				end
			end

			local var_80_18 = 0.001

			if var_80_15 <= arg_77_1.time_ and arg_77_1.time_ < var_80_15 + var_80_18 then
				local var_80_19 = (arg_77_1.time_ - var_80_15) / var_80_18
				local var_80_20 = Vector3.New(0, -300, -295)

				var_80_14.localPosition = Vector3.Lerp(arg_77_1.var_.moveOldPos10092_1, var_80_20, var_80_19)
			end

			if arg_77_1.time_ >= var_80_15 + var_80_18 and arg_77_1.time_ < var_80_15 + var_80_18 + arg_80_0 then
				var_80_14.localPosition = Vector3.New(0, -300, -295)
			end

			local var_80_21 = arg_77_1.actors_["10022"]
			local var_80_22 = 0

			if var_80_22 < arg_77_1.time_ and arg_77_1.time_ <= var_80_22 + arg_80_0 and not isNil(var_80_21) and arg_77_1.var_.actorSpriteComps10022 == nil then
				arg_77_1.var_.actorSpriteComps10022 = var_80_21:GetComponentsInChildren(typeof(Image), true)
			end

			local var_80_23 = 2

			if var_80_22 <= arg_77_1.time_ and arg_77_1.time_ < var_80_22 + var_80_23 and not isNil(var_80_21) then
				local var_80_24 = (arg_77_1.time_ - var_80_22) / var_80_23

				if arg_77_1.var_.actorSpriteComps10022 then
					for iter_80_3, iter_80_4 in pairs(arg_77_1.var_.actorSpriteComps10022:ToTable()) do
						if iter_80_4 then
							if arg_77_1.isInRecall_ then
								local var_80_25 = Mathf.Lerp(iter_80_4.color.r, arg_77_1.hightColor2.r, var_80_24)
								local var_80_26 = Mathf.Lerp(iter_80_4.color.g, arg_77_1.hightColor2.g, var_80_24)
								local var_80_27 = Mathf.Lerp(iter_80_4.color.b, arg_77_1.hightColor2.b, var_80_24)

								iter_80_4.color = Color.New(var_80_25, var_80_26, var_80_27)
							else
								local var_80_28 = Mathf.Lerp(iter_80_4.color.r, 0.5, var_80_24)

								iter_80_4.color = Color.New(var_80_28, var_80_28, var_80_28)
							end
						end
					end
				end
			end

			if arg_77_1.time_ >= var_80_22 + var_80_23 and arg_77_1.time_ < var_80_22 + var_80_23 + arg_80_0 and not isNil(var_80_21) and arg_77_1.var_.actorSpriteComps10022 then
				for iter_80_5, iter_80_6 in pairs(arg_77_1.var_.actorSpriteComps10022:ToTable()) do
					if iter_80_6 then
						if arg_77_1.isInRecall_ then
							iter_80_6.color = arg_77_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_80_6.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_77_1.var_.actorSpriteComps10022 = nil
			end

			local var_80_29 = arg_77_1.actors_["10094"]
			local var_80_30 = 0

			if var_80_30 < arg_77_1.time_ and arg_77_1.time_ <= var_80_30 + arg_80_0 and not isNil(var_80_29) and arg_77_1.var_.actorSpriteComps10094 == nil then
				arg_77_1.var_.actorSpriteComps10094 = var_80_29:GetComponentsInChildren(typeof(Image), true)
			end

			local var_80_31 = 2

			if var_80_30 <= arg_77_1.time_ and arg_77_1.time_ < var_80_30 + var_80_31 and not isNil(var_80_29) then
				local var_80_32 = (arg_77_1.time_ - var_80_30) / var_80_31

				if arg_77_1.var_.actorSpriteComps10094 then
					for iter_80_7, iter_80_8 in pairs(arg_77_1.var_.actorSpriteComps10094:ToTable()) do
						if iter_80_8 then
							if arg_77_1.isInRecall_ then
								local var_80_33 = Mathf.Lerp(iter_80_8.color.r, arg_77_1.hightColor2.r, var_80_32)
								local var_80_34 = Mathf.Lerp(iter_80_8.color.g, arg_77_1.hightColor2.g, var_80_32)
								local var_80_35 = Mathf.Lerp(iter_80_8.color.b, arg_77_1.hightColor2.b, var_80_32)

								iter_80_8.color = Color.New(var_80_33, var_80_34, var_80_35)
							else
								local var_80_36 = Mathf.Lerp(iter_80_8.color.r, 0.5, var_80_32)

								iter_80_8.color = Color.New(var_80_36, var_80_36, var_80_36)
							end
						end
					end
				end
			end

			if arg_77_1.time_ >= var_80_30 + var_80_31 and arg_77_1.time_ < var_80_30 + var_80_31 + arg_80_0 and not isNil(var_80_29) and arg_77_1.var_.actorSpriteComps10094 then
				for iter_80_9, iter_80_10 in pairs(arg_77_1.var_.actorSpriteComps10094:ToTable()) do
					if iter_80_10 then
						if arg_77_1.isInRecall_ then
							iter_80_10.color = arg_77_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_80_10.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_77_1.var_.actorSpriteComps10094 = nil
			end

			local var_80_37 = arg_77_1.actors_["10092_1"]
			local var_80_38 = 0

			if var_80_38 < arg_77_1.time_ and arg_77_1.time_ <= var_80_38 + arg_80_0 and not isNil(var_80_37) and arg_77_1.var_.actorSpriteComps10092_1 == nil then
				arg_77_1.var_.actorSpriteComps10092_1 = var_80_37:GetComponentsInChildren(typeof(Image), true)
			end

			local var_80_39 = 2

			if var_80_38 <= arg_77_1.time_ and arg_77_1.time_ < var_80_38 + var_80_39 and not isNil(var_80_37) then
				local var_80_40 = (arg_77_1.time_ - var_80_38) / var_80_39

				if arg_77_1.var_.actorSpriteComps10092_1 then
					for iter_80_11, iter_80_12 in pairs(arg_77_1.var_.actorSpriteComps10092_1:ToTable()) do
						if iter_80_12 then
							if arg_77_1.isInRecall_ then
								local var_80_41 = Mathf.Lerp(iter_80_12.color.r, arg_77_1.hightColor1.r, var_80_40)
								local var_80_42 = Mathf.Lerp(iter_80_12.color.g, arg_77_1.hightColor1.g, var_80_40)
								local var_80_43 = Mathf.Lerp(iter_80_12.color.b, arg_77_1.hightColor1.b, var_80_40)

								iter_80_12.color = Color.New(var_80_41, var_80_42, var_80_43)
							else
								local var_80_44 = Mathf.Lerp(iter_80_12.color.r, 1, var_80_40)

								iter_80_12.color = Color.New(var_80_44, var_80_44, var_80_44)
							end
						end
					end
				end
			end

			if arg_77_1.time_ >= var_80_38 + var_80_39 and arg_77_1.time_ < var_80_38 + var_80_39 + arg_80_0 and not isNil(var_80_37) and arg_77_1.var_.actorSpriteComps10092_1 then
				for iter_80_13, iter_80_14 in pairs(arg_77_1.var_.actorSpriteComps10092_1:ToTable()) do
					if iter_80_14 then
						if arg_77_1.isInRecall_ then
							iter_80_14.color = arg_77_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_80_14.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_77_1.var_.actorSpriteComps10092_1 = nil
			end

			local var_80_45 = 0
			local var_80_46 = 0.575

			if var_80_45 < arg_77_1.time_ and arg_77_1.time_ <= var_80_45 + arg_80_0 then
				arg_77_1.talkMaxDuration = 0
				arg_77_1.dialogCg_.alpha = 1

				arg_77_1.dialog_:SetActive(true)
				SetActive(arg_77_1.leftNameGo_, true)

				local var_80_47 = arg_77_1:FormatText(StoryNameCfg[996].name)

				arg_77_1.leftNameTxt_.text = var_80_47

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_77_1.leftNameTxt_.transform)

				arg_77_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_77_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_77_1:RecordName(arg_77_1.leftNameTxt_.text)
				SetActive(arg_77_1.iconTrs_.gameObject, false)
				arg_77_1.callingController_:SetSelectedState("normal")

				local var_80_48 = arg_77_1:GetWordFromCfg(413131019)
				local var_80_49 = arg_77_1:FormatText(var_80_48.content)

				arg_77_1.text_.text = var_80_49

				LuaForUtil.ClearLinePrefixSymbol(arg_77_1.text_)

				local var_80_50 = 23
				local var_80_51 = utf8.len(var_80_49)
				local var_80_52 = var_80_50 <= 0 and var_80_46 or var_80_46 * (var_80_51 / var_80_50)

				if var_80_52 > 0 and var_80_46 < var_80_52 then
					arg_77_1.talkMaxDuration = var_80_52

					if var_80_52 + var_80_45 > arg_77_1.duration_ then
						arg_77_1.duration_ = var_80_52 + var_80_45
					end
				end

				arg_77_1.text_.text = var_80_49
				arg_77_1.typewritter.percent = 0

				arg_77_1.typewritter:SetDirty()
				arg_77_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_413131", "413131019", "story_v_out_413131.awb") ~= 0 then
					local var_80_53 = manager.audio:GetVoiceLength("story_v_out_413131", "413131019", "story_v_out_413131.awb") / 1000

					if var_80_53 + var_80_45 > arg_77_1.duration_ then
						arg_77_1.duration_ = var_80_53 + var_80_45
					end

					if var_80_48.prefab_name ~= "" and arg_77_1.actors_[var_80_48.prefab_name] ~= nil then
						local var_80_54 = LuaForUtil.PlayVoiceWithCriLipsync(arg_77_1.actors_[var_80_48.prefab_name].transform, "story_v_out_413131", "413131019", "story_v_out_413131.awb")

						arg_77_1:RecordAudio("413131019", var_80_54)
						arg_77_1:RecordAudio("413131019", var_80_54)
					else
						arg_77_1:AudioAction("play", "voice", "story_v_out_413131", "413131019", "story_v_out_413131.awb")
					end

					arg_77_1:RecordHistoryTalkVoice("story_v_out_413131", "413131019", "story_v_out_413131.awb")
				end

				arg_77_1:RecordContent(arg_77_1.text_.text)
			end

			local var_80_55 = math.max(var_80_46, arg_77_1.talkMaxDuration)

			if var_80_45 <= arg_77_1.time_ and arg_77_1.time_ < var_80_45 + var_80_55 then
				arg_77_1.typewritter.percent = (arg_77_1.time_ - var_80_45) / var_80_55

				arg_77_1.typewritter:SetDirty()
			end

			if arg_77_1.time_ >= var_80_45 + var_80_55 and arg_77_1.time_ < var_80_45 + var_80_55 + arg_80_0 then
				arg_77_1.typewritter.percent = 1

				arg_77_1.typewritter:SetDirty()
				arg_77_1:ShowNextGo(true)
			end
		end

		arg_77_1.nodeConfigList_ = {
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

		arg_77_1:InitPlayNodeList()
	end,
	Play413131020 = function(arg_81_0, arg_81_1)
		arg_81_1.time_ = 0
		arg_81_1.frameCnt_ = 0
		arg_81_1.state_ = "playing"
		arg_81_1.curTalkId_ = 413131020
		arg_81_1.duration_ = 8.8

		local var_81_0 = {
			zh = 7.433,
			ja = 8.8
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
				arg_81_0:Play413131021(arg_81_1)
			end
		end

		function arg_81_1.onSingleLineUpdate_(arg_84_0)
			local var_84_0 = arg_81_1.actors_["10092_1"].transform
			local var_84_1 = 0

			if var_84_1 < arg_81_1.time_ and arg_81_1.time_ <= var_84_1 + arg_84_0 then
				arg_81_1.var_.moveOldPos10092_1 = var_84_0.localPosition
				var_84_0.localScale = Vector3.New(1, 1, 1)

				arg_81_1:CheckSpriteTmpPos("10092_1", 3)

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
				local var_84_6 = Vector3.New(0, -300, -295)

				var_84_0.localPosition = Vector3.Lerp(arg_81_1.var_.moveOldPos10092_1, var_84_6, var_84_5)
			end

			if arg_81_1.time_ >= var_84_1 + var_84_4 and arg_81_1.time_ < var_84_1 + var_84_4 + arg_84_0 then
				var_84_0.localPosition = Vector3.New(0, -300, -295)
			end

			local var_84_7 = 0
			local var_84_8 = 0.875

			if var_84_7 < arg_81_1.time_ and arg_81_1.time_ <= var_84_7 + arg_84_0 then
				arg_81_1.talkMaxDuration = 0
				arg_81_1.dialogCg_.alpha = 1

				arg_81_1.dialog_:SetActive(true)
				SetActive(arg_81_1.leftNameGo_, true)

				local var_84_9 = arg_81_1:FormatText(StoryNameCfg[996].name)

				arg_81_1.leftNameTxt_.text = var_84_9

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_81_1.leftNameTxt_.transform)

				arg_81_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_81_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_81_1:RecordName(arg_81_1.leftNameTxt_.text)
				SetActive(arg_81_1.iconTrs_.gameObject, false)
				arg_81_1.callingController_:SetSelectedState("normal")

				local var_84_10 = arg_81_1:GetWordFromCfg(413131020)
				local var_84_11 = arg_81_1:FormatText(var_84_10.content)

				arg_81_1.text_.text = var_84_11

				LuaForUtil.ClearLinePrefixSymbol(arg_81_1.text_)

				local var_84_12 = 35
				local var_84_13 = utf8.len(var_84_11)
				local var_84_14 = var_84_12 <= 0 and var_84_8 or var_84_8 * (var_84_13 / var_84_12)

				if var_84_14 > 0 and var_84_8 < var_84_14 then
					arg_81_1.talkMaxDuration = var_84_14

					if var_84_14 + var_84_7 > arg_81_1.duration_ then
						arg_81_1.duration_ = var_84_14 + var_84_7
					end
				end

				arg_81_1.text_.text = var_84_11
				arg_81_1.typewritter.percent = 0

				arg_81_1.typewritter:SetDirty()
				arg_81_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_413131", "413131020", "story_v_out_413131.awb") ~= 0 then
					local var_84_15 = manager.audio:GetVoiceLength("story_v_out_413131", "413131020", "story_v_out_413131.awb") / 1000

					if var_84_15 + var_84_7 > arg_81_1.duration_ then
						arg_81_1.duration_ = var_84_15 + var_84_7
					end

					if var_84_10.prefab_name ~= "" and arg_81_1.actors_[var_84_10.prefab_name] ~= nil then
						local var_84_16 = LuaForUtil.PlayVoiceWithCriLipsync(arg_81_1.actors_[var_84_10.prefab_name].transform, "story_v_out_413131", "413131020", "story_v_out_413131.awb")

						arg_81_1:RecordAudio("413131020", var_84_16)
						arg_81_1:RecordAudio("413131020", var_84_16)
					else
						arg_81_1:AudioAction("play", "voice", "story_v_out_413131", "413131020", "story_v_out_413131.awb")
					end

					arg_81_1:RecordHistoryTalkVoice("story_v_out_413131", "413131020", "story_v_out_413131.awb")
				end

				arg_81_1:RecordContent(arg_81_1.text_.text)
			end

			local var_84_17 = math.max(var_84_8, arg_81_1.talkMaxDuration)

			if var_84_7 <= arg_81_1.time_ and arg_81_1.time_ < var_84_7 + var_84_17 then
				arg_81_1.typewritter.percent = (arg_81_1.time_ - var_84_7) / var_84_17

				arg_81_1.typewritter:SetDirty()
			end

			if arg_81_1.time_ >= var_84_7 + var_84_17 and arg_81_1.time_ < var_84_7 + var_84_17 + arg_84_0 then
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
	Play413131021 = function(arg_85_0, arg_85_1)
		arg_85_1.time_ = 0
		arg_85_1.frameCnt_ = 0
		arg_85_1.state_ = "playing"
		arg_85_1.curTalkId_ = 413131021
		arg_85_1.duration_ = 6.63

		local var_85_0 = {
			zh = 5.166,
			ja = 6.633
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
				arg_85_0:Play413131022(arg_85_1)
			end
		end

		function arg_85_1.onSingleLineUpdate_(arg_88_0)
			local var_88_0 = 0
			local var_88_1 = 0.725

			if var_88_0 < arg_85_1.time_ and arg_85_1.time_ <= var_88_0 + arg_88_0 then
				arg_85_1.talkMaxDuration = 0
				arg_85_1.dialogCg_.alpha = 1

				arg_85_1.dialog_:SetActive(true)
				SetActive(arg_85_1.leftNameGo_, true)

				local var_88_2 = arg_85_1:FormatText(StoryNameCfg[996].name)

				arg_85_1.leftNameTxt_.text = var_88_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_85_1.leftNameTxt_.transform)

				arg_85_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_85_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_85_1:RecordName(arg_85_1.leftNameTxt_.text)
				SetActive(arg_85_1.iconTrs_.gameObject, false)
				arg_85_1.callingController_:SetSelectedState("normal")

				local var_88_3 = arg_85_1:GetWordFromCfg(413131021)
				local var_88_4 = arg_85_1:FormatText(var_88_3.content)

				arg_85_1.text_.text = var_88_4

				LuaForUtil.ClearLinePrefixSymbol(arg_85_1.text_)

				local var_88_5 = 29
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

				if manager.audio:GetVoiceLength("story_v_out_413131", "413131021", "story_v_out_413131.awb") ~= 0 then
					local var_88_8 = manager.audio:GetVoiceLength("story_v_out_413131", "413131021", "story_v_out_413131.awb") / 1000

					if var_88_8 + var_88_0 > arg_85_1.duration_ then
						arg_85_1.duration_ = var_88_8 + var_88_0
					end

					if var_88_3.prefab_name ~= "" and arg_85_1.actors_[var_88_3.prefab_name] ~= nil then
						local var_88_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_85_1.actors_[var_88_3.prefab_name].transform, "story_v_out_413131", "413131021", "story_v_out_413131.awb")

						arg_85_1:RecordAudio("413131021", var_88_9)
						arg_85_1:RecordAudio("413131021", var_88_9)
					else
						arg_85_1:AudioAction("play", "voice", "story_v_out_413131", "413131021", "story_v_out_413131.awb")
					end

					arg_85_1:RecordHistoryTalkVoice("story_v_out_413131", "413131021", "story_v_out_413131.awb")
				end

				arg_85_1:RecordContent(arg_85_1.text_.text)
			end

			local var_88_10 = math.max(var_88_1, arg_85_1.talkMaxDuration)

			if var_88_0 <= arg_85_1.time_ and arg_85_1.time_ < var_88_0 + var_88_10 then
				arg_85_1.typewritter.percent = (arg_85_1.time_ - var_88_0) / var_88_10

				arg_85_1.typewritter:SetDirty()
			end

			if arg_85_1.time_ >= var_88_0 + var_88_10 and arg_85_1.time_ < var_88_0 + var_88_10 + arg_88_0 then
				arg_85_1.typewritter.percent = 1

				arg_85_1.typewritter:SetDirty()
				arg_85_1:ShowNextGo(true)
			end
		end

		arg_85_1.nodeConfigList_ = {}

		arg_85_1:InitPlayNodeList()
	end,
	Play413131022 = function(arg_89_0, arg_89_1)
		arg_89_1.time_ = 0
		arg_89_1.frameCnt_ = 0
		arg_89_1.state_ = "playing"
		arg_89_1.curTalkId_ = 413131022
		arg_89_1.duration_ = 4.4

		local var_89_0 = {
			zh = 2.6,
			ja = 4.4
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
				arg_89_0:Play413131023(arg_89_1)
			end
		end

		function arg_89_1.onSingleLineUpdate_(arg_92_0)
			local var_92_0 = 0
			local var_92_1 = 0.425

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

				local var_92_3 = arg_89_1:GetWordFromCfg(413131022)
				local var_92_4 = arg_89_1:FormatText(var_92_3.content)

				arg_89_1.text_.text = var_92_4

				LuaForUtil.ClearLinePrefixSymbol(arg_89_1.text_)

				local var_92_5 = 17
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

				if manager.audio:GetVoiceLength("story_v_out_413131", "413131022", "story_v_out_413131.awb") ~= 0 then
					local var_92_8 = manager.audio:GetVoiceLength("story_v_out_413131", "413131022", "story_v_out_413131.awb") / 1000

					if var_92_8 + var_92_0 > arg_89_1.duration_ then
						arg_89_1.duration_ = var_92_8 + var_92_0
					end

					if var_92_3.prefab_name ~= "" and arg_89_1.actors_[var_92_3.prefab_name] ~= nil then
						local var_92_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_89_1.actors_[var_92_3.prefab_name].transform, "story_v_out_413131", "413131022", "story_v_out_413131.awb")

						arg_89_1:RecordAudio("413131022", var_92_9)
						arg_89_1:RecordAudio("413131022", var_92_9)
					else
						arg_89_1:AudioAction("play", "voice", "story_v_out_413131", "413131022", "story_v_out_413131.awb")
					end

					arg_89_1:RecordHistoryTalkVoice("story_v_out_413131", "413131022", "story_v_out_413131.awb")
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
	Play413131023 = function(arg_93_0, arg_93_1)
		arg_93_1.time_ = 0
		arg_93_1.frameCnt_ = 0
		arg_93_1.state_ = "playing"
		arg_93_1.curTalkId_ = 413131023
		arg_93_1.duration_ = 6.23

		local var_93_0 = {
			zh = 5.2,
			ja = 6.233
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
				arg_93_0:Play413131024(arg_93_1)
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

					if var_96_3.name == "split_1_1" or not string.find(var_96_3.name, "split") then
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
			local var_96_16 = 0.65

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

				local var_96_18 = arg_93_1:GetWordFromCfg(413131023)
				local var_96_19 = arg_93_1:FormatText(var_96_18.content)

				arg_93_1.text_.text = var_96_19

				LuaForUtil.ClearLinePrefixSymbol(arg_93_1.text_)

				local var_96_20 = 26
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

				if manager.audio:GetVoiceLength("story_v_out_413131", "413131023", "story_v_out_413131.awb") ~= 0 then
					local var_96_23 = manager.audio:GetVoiceLength("story_v_out_413131", "413131023", "story_v_out_413131.awb") / 1000

					if var_96_23 + var_96_15 > arg_93_1.duration_ then
						arg_93_1.duration_ = var_96_23 + var_96_15
					end

					if var_96_18.prefab_name ~= "" and arg_93_1.actors_[var_96_18.prefab_name] ~= nil then
						local var_96_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_93_1.actors_[var_96_18.prefab_name].transform, "story_v_out_413131", "413131023", "story_v_out_413131.awb")

						arg_93_1:RecordAudio("413131023", var_96_24)
						arg_93_1:RecordAudio("413131023", var_96_24)
					else
						arg_93_1:AudioAction("play", "voice", "story_v_out_413131", "413131023", "story_v_out_413131.awb")
					end

					arg_93_1:RecordHistoryTalkVoice("story_v_out_413131", "413131023", "story_v_out_413131.awb")
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
	Play413131024 = function(arg_97_0, arg_97_1)
		arg_97_1.time_ = 0
		arg_97_1.frameCnt_ = 0
		arg_97_1.state_ = "playing"
		arg_97_1.curTalkId_ = 413131024
		arg_97_1.duration_ = 8.9

		SetActive(arg_97_1.tipsGo_, false)

		function arg_97_1.onSingleLineFinish_()
			arg_97_1.onSingleLineUpdate_ = nil
			arg_97_1.onSingleLineFinish_ = nil
			arg_97_1.state_ = "waiting"
		end

		function arg_97_1.playNext_(arg_99_0)
			if arg_99_0 == 1 then
				arg_97_0:Play413131025(arg_97_1)
			end
		end

		function arg_97_1.onSingleLineUpdate_(arg_100_0)
			local var_100_0 = "F10g"

			if arg_97_1.bgs_[var_100_0] == nil then
				local var_100_1 = Object.Instantiate(arg_97_1.paintGo_)

				var_100_1:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. var_100_0)
				var_100_1.name = var_100_0
				var_100_1.transform.parent = arg_97_1.stage_.transform
				var_100_1.transform.localPosition = Vector3.New(0, 100, 0)
				arg_97_1.bgs_[var_100_0] = var_100_1
			end

			local var_100_2 = 2

			if var_100_2 < arg_97_1.time_ and arg_97_1.time_ <= var_100_2 + arg_100_0 then
				local var_100_3 = manager.ui.mainCamera.transform.localPosition
				local var_100_4 = Vector3.New(0, 0, 10) + Vector3.New(var_100_3.x, var_100_3.y, 0)
				local var_100_5 = arg_97_1.bgs_.F10g

				var_100_5.transform.localPosition = var_100_4
				var_100_5.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_100_6 = var_100_5:GetComponent("SpriteRenderer")

				if var_100_6 and var_100_6.sprite then
					local var_100_7 = (var_100_5.transform.localPosition - var_100_3).z
					local var_100_8 = manager.ui.mainCameraCom_
					local var_100_9 = 2 * var_100_7 * Mathf.Tan(var_100_8.fieldOfView * 0.5 * Mathf.Deg2Rad)
					local var_100_10 = var_100_9 * var_100_8.aspect
					local var_100_11 = var_100_6.sprite.bounds.size.x
					local var_100_12 = var_100_6.sprite.bounds.size.y
					local var_100_13 = var_100_10 / var_100_11
					local var_100_14 = var_100_9 / var_100_12
					local var_100_15 = var_100_14 < var_100_13 and var_100_13 or var_100_14

					var_100_5.transform.localScale = Vector3.New(var_100_15, var_100_15, 0)
				end

				for iter_100_0, iter_100_1 in pairs(arg_97_1.bgs_) do
					if iter_100_0 ~= "F10g" then
						iter_100_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_100_16 = 4

			if var_100_16 < arg_97_1.time_ and arg_97_1.time_ <= var_100_16 + arg_100_0 then
				arg_97_1.allBtn_.enabled = false
			end

			local var_100_17 = 0.3

			if arg_97_1.time_ >= var_100_16 + var_100_17 and arg_97_1.time_ < var_100_16 + var_100_17 + arg_100_0 then
				arg_97_1.allBtn_.enabled = true
			end

			local var_100_18 = 0

			if var_100_18 < arg_97_1.time_ and arg_97_1.time_ <= var_100_18 + arg_100_0 then
				arg_97_1.mask_.enabled = true
				arg_97_1.mask_.raycastTarget = true

				arg_97_1:SetGaussion(false)
			end

			local var_100_19 = 2

			if var_100_18 <= arg_97_1.time_ and arg_97_1.time_ < var_100_18 + var_100_19 then
				local var_100_20 = (arg_97_1.time_ - var_100_18) / var_100_19
				local var_100_21 = Color.New(0, 0, 0)

				var_100_21.a = Mathf.Lerp(0, 1, var_100_20)
				arg_97_1.mask_.color = var_100_21
			end

			if arg_97_1.time_ >= var_100_18 + var_100_19 and arg_97_1.time_ < var_100_18 + var_100_19 + arg_100_0 then
				local var_100_22 = Color.New(0, 0, 0)

				var_100_22.a = 1
				arg_97_1.mask_.color = var_100_22
			end

			local var_100_23 = 2

			if var_100_23 < arg_97_1.time_ and arg_97_1.time_ <= var_100_23 + arg_100_0 then
				arg_97_1.mask_.enabled = true
				arg_97_1.mask_.raycastTarget = true

				arg_97_1:SetGaussion(false)
			end

			local var_100_24 = 2

			if var_100_23 <= arg_97_1.time_ and arg_97_1.time_ < var_100_23 + var_100_24 then
				local var_100_25 = (arg_97_1.time_ - var_100_23) / var_100_24
				local var_100_26 = Color.New(0, 0, 0)

				var_100_26.a = Mathf.Lerp(1, 0, var_100_25)
				arg_97_1.mask_.color = var_100_26
			end

			if arg_97_1.time_ >= var_100_23 + var_100_24 and arg_97_1.time_ < var_100_23 + var_100_24 + arg_100_0 then
				local var_100_27 = Color.New(0, 0, 0)
				local var_100_28 = 0

				arg_97_1.mask_.enabled = false
				var_100_27.a = var_100_28
				arg_97_1.mask_.color = var_100_27
			end

			local var_100_29 = arg_97_1.actors_["10092_1"].transform
			local var_100_30 = 2

			if var_100_30 < arg_97_1.time_ and arg_97_1.time_ <= var_100_30 + arg_100_0 then
				arg_97_1.var_.moveOldPos10092_1 = var_100_29.localPosition
				var_100_29.localScale = Vector3.New(1, 1, 1)

				arg_97_1:CheckSpriteTmpPos("10092_1", 7)

				local var_100_31 = var_100_29.childCount

				for iter_100_2 = 0, var_100_31 - 1 do
					local var_100_32 = var_100_29:GetChild(iter_100_2)

					if var_100_32.name == "" or not string.find(var_100_32.name, "split") then
						var_100_32.gameObject:SetActive(true)
					else
						var_100_32.gameObject:SetActive(false)
					end
				end
			end

			local var_100_33 = 0.001

			if var_100_30 <= arg_97_1.time_ and arg_97_1.time_ < var_100_30 + var_100_33 then
				local var_100_34 = (arg_97_1.time_ - var_100_30) / var_100_33
				local var_100_35 = Vector3.New(0, -2000, 0)

				var_100_29.localPosition = Vector3.Lerp(arg_97_1.var_.moveOldPos10092_1, var_100_35, var_100_34)
			end

			if arg_97_1.time_ >= var_100_30 + var_100_33 and arg_97_1.time_ < var_100_30 + var_100_33 + arg_100_0 then
				var_100_29.localPosition = Vector3.New(0, -2000, 0)
			end

			if arg_97_1.frameCnt_ <= 1 then
				arg_97_1.dialog_:SetActive(false)
			end

			local var_100_36 = 3.9
			local var_100_37 = 1.45

			if var_100_36 < arg_97_1.time_ and arg_97_1.time_ <= var_100_36 + arg_100_0 then
				arg_97_1.talkMaxDuration = 0

				arg_97_1.dialog_:SetActive(true)

				arg_97_1.dialogCg_.alpha = 0

				local var_100_38 = LeanTween.value(arg_97_1.dialog_, 0, 1, 0.3)

				var_100_38:setOnUpdate(LuaHelper.FloatAction(function(arg_101_0)
					arg_97_1.dialogCg_.alpha = arg_101_0
				end))
				var_100_38:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_97_1.dialog_)
					var_100_38:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_97_1.duration_ = arg_97_1.duration_ + 0.3

				SetActive(arg_97_1.leftNameGo_, false)

				arg_97_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_97_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_97_1:RecordName(arg_97_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_97_1.iconTrs_.gameObject, false)
				arg_97_1.callingController_:SetSelectedState("normal")

				local var_100_39 = arg_97_1:GetWordFromCfg(413131024)
				local var_100_40 = arg_97_1:FormatText(var_100_39.content)

				arg_97_1.text_.text = var_100_40

				LuaForUtil.ClearLinePrefixSymbol(arg_97_1.text_)

				local var_100_41 = 58
				local var_100_42 = utf8.len(var_100_40)
				local var_100_43 = var_100_41 <= 0 and var_100_37 or var_100_37 * (var_100_42 / var_100_41)

				if var_100_43 > 0 and var_100_37 < var_100_43 then
					arg_97_1.talkMaxDuration = var_100_43
					var_100_36 = var_100_36 + 0.3

					if var_100_43 + var_100_36 > arg_97_1.duration_ then
						arg_97_1.duration_ = var_100_43 + var_100_36
					end
				end

				arg_97_1.text_.text = var_100_40
				arg_97_1.typewritter.percent = 0

				arg_97_1.typewritter:SetDirty()
				arg_97_1:ShowNextGo(false)
				arg_97_1:RecordContent(arg_97_1.text_.text)
			end

			local var_100_44 = var_100_36 + 0.3
			local var_100_45 = math.max(var_100_37, arg_97_1.talkMaxDuration)

			if var_100_44 <= arg_97_1.time_ and arg_97_1.time_ < var_100_44 + var_100_45 then
				arg_97_1.typewritter.percent = (arg_97_1.time_ - var_100_44) / var_100_45

				arg_97_1.typewritter:SetDirty()
			end

			if arg_97_1.time_ >= var_100_44 + var_100_45 and arg_97_1.time_ < var_100_44 + var_100_45 + arg_100_0 then
				arg_97_1.typewritter.percent = 1

				arg_97_1.typewritter:SetDirty()
				arg_97_1:ShowNextGo(true)
			end
		end

		arg_97_1.nodeConfigList_ = {
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

		arg_97_1:InitPlayNodeList()
	end,
	Play413131025 = function(arg_103_0, arg_103_1)
		arg_103_1.time_ = 0
		arg_103_1.frameCnt_ = 0
		arg_103_1.state_ = "playing"
		arg_103_1.curTalkId_ = 413131025
		arg_103_1.duration_ = 5

		SetActive(arg_103_1.tipsGo_, false)

		function arg_103_1.onSingleLineFinish_()
			arg_103_1.onSingleLineUpdate_ = nil
			arg_103_1.onSingleLineFinish_ = nil
			arg_103_1.state_ = "waiting"
		end

		function arg_103_1.playNext_(arg_105_0)
			if arg_105_0 == 1 then
				arg_103_0:Play413131026(arg_103_1)
			end
		end

		function arg_103_1.onSingleLineUpdate_(arg_106_0)
			local var_106_0 = 0
			local var_106_1 = 1.125

			if var_106_0 < arg_103_1.time_ and arg_103_1.time_ <= var_106_0 + arg_106_0 then
				arg_103_1.talkMaxDuration = 0
				arg_103_1.dialogCg_.alpha = 1

				arg_103_1.dialog_:SetActive(true)
				SetActive(arg_103_1.leftNameGo_, false)

				arg_103_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_103_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_103_1:RecordName(arg_103_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_103_1.iconTrs_.gameObject, false)
				arg_103_1.callingController_:SetSelectedState("normal")

				local var_106_2 = arg_103_1:GetWordFromCfg(413131025)
				local var_106_3 = arg_103_1:FormatText(var_106_2.content)

				arg_103_1.text_.text = var_106_3

				LuaForUtil.ClearLinePrefixSymbol(arg_103_1.text_)

				local var_106_4 = 45
				local var_106_5 = utf8.len(var_106_3)
				local var_106_6 = var_106_4 <= 0 and var_106_1 or var_106_1 * (var_106_5 / var_106_4)

				if var_106_6 > 0 and var_106_1 < var_106_6 then
					arg_103_1.talkMaxDuration = var_106_6

					if var_106_6 + var_106_0 > arg_103_1.duration_ then
						arg_103_1.duration_ = var_106_6 + var_106_0
					end
				end

				arg_103_1.text_.text = var_106_3
				arg_103_1.typewritter.percent = 0

				arg_103_1.typewritter:SetDirty()
				arg_103_1:ShowNextGo(false)
				arg_103_1:RecordContent(arg_103_1.text_.text)
			end

			local var_106_7 = math.max(var_106_1, arg_103_1.talkMaxDuration)

			if var_106_0 <= arg_103_1.time_ and arg_103_1.time_ < var_106_0 + var_106_7 then
				arg_103_1.typewritter.percent = (arg_103_1.time_ - var_106_0) / var_106_7

				arg_103_1.typewritter:SetDirty()
			end

			if arg_103_1.time_ >= var_106_0 + var_106_7 and arg_103_1.time_ < var_106_0 + var_106_7 + arg_106_0 then
				arg_103_1.typewritter.percent = 1

				arg_103_1.typewritter:SetDirty()
				arg_103_1:ShowNextGo(true)
			end
		end

		arg_103_1.nodeConfigList_ = {}

		arg_103_1:InitPlayNodeList()
	end,
	Play413131026 = function(arg_107_0, arg_107_1)
		arg_107_1.time_ = 0
		arg_107_1.frameCnt_ = 0
		arg_107_1.state_ = "playing"
		arg_107_1.curTalkId_ = 413131026
		arg_107_1.duration_ = 5

		SetActive(arg_107_1.tipsGo_, false)

		function arg_107_1.onSingleLineFinish_()
			arg_107_1.onSingleLineUpdate_ = nil
			arg_107_1.onSingleLineFinish_ = nil
			arg_107_1.state_ = "waiting"
		end

		function arg_107_1.playNext_(arg_109_0)
			if arg_109_0 == 1 then
				arg_107_0:Play413131027(arg_107_1)
			end
		end

		function arg_107_1.onSingleLineUpdate_(arg_110_0)
			local var_110_0 = 0
			local var_110_1 = 1.725

			if var_110_0 < arg_107_1.time_ and arg_107_1.time_ <= var_110_0 + arg_110_0 then
				arg_107_1.talkMaxDuration = 0
				arg_107_1.dialogCg_.alpha = 1

				arg_107_1.dialog_:SetActive(true)
				SetActive(arg_107_1.leftNameGo_, false)

				arg_107_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_107_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_107_1:RecordName(arg_107_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_107_1.iconTrs_.gameObject, false)
				arg_107_1.callingController_:SetSelectedState("normal")

				local var_110_2 = arg_107_1:GetWordFromCfg(413131026)
				local var_110_3 = arg_107_1:FormatText(var_110_2.content)

				arg_107_1.text_.text = var_110_3

				LuaForUtil.ClearLinePrefixSymbol(arg_107_1.text_)

				local var_110_4 = 69
				local var_110_5 = utf8.len(var_110_3)
				local var_110_6 = var_110_4 <= 0 and var_110_1 or var_110_1 * (var_110_5 / var_110_4)

				if var_110_6 > 0 and var_110_1 < var_110_6 then
					arg_107_1.talkMaxDuration = var_110_6

					if var_110_6 + var_110_0 > arg_107_1.duration_ then
						arg_107_1.duration_ = var_110_6 + var_110_0
					end
				end

				arg_107_1.text_.text = var_110_3
				arg_107_1.typewritter.percent = 0

				arg_107_1.typewritter:SetDirty()
				arg_107_1:ShowNextGo(false)
				arg_107_1:RecordContent(arg_107_1.text_.text)
			end

			local var_110_7 = math.max(var_110_1, arg_107_1.talkMaxDuration)

			if var_110_0 <= arg_107_1.time_ and arg_107_1.time_ < var_110_0 + var_110_7 then
				arg_107_1.typewritter.percent = (arg_107_1.time_ - var_110_0) / var_110_7

				arg_107_1.typewritter:SetDirty()
			end

			if arg_107_1.time_ >= var_110_0 + var_110_7 and arg_107_1.time_ < var_110_0 + var_110_7 + arg_110_0 then
				arg_107_1.typewritter.percent = 1

				arg_107_1.typewritter:SetDirty()
				arg_107_1:ShowNextGo(true)
			end
		end

		arg_107_1.nodeConfigList_ = {}

		arg_107_1:InitPlayNodeList()
	end,
	Play413131027 = function(arg_111_0, arg_111_1)
		arg_111_1.time_ = 0
		arg_111_1.frameCnt_ = 0
		arg_111_1.state_ = "playing"
		arg_111_1.curTalkId_ = 413131027
		arg_111_1.duration_ = 7.53

		local var_111_0 = {
			zh = 6.366,
			ja = 7.533
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
				arg_111_0:Play413131028(arg_111_1)
			end
		end

		function arg_111_1.onSingleLineUpdate_(arg_114_0)
			local var_114_0 = 0
			local var_114_1 = 0.85

			if var_114_0 < arg_111_1.time_ and arg_111_1.time_ <= var_114_0 + arg_114_0 then
				arg_111_1.talkMaxDuration = 0
				arg_111_1.dialogCg_.alpha = 1

				arg_111_1.dialog_:SetActive(true)
				SetActive(arg_111_1.leftNameGo_, true)

				local var_114_2 = arg_111_1:FormatText(StoryNameCfg[998].name)

				arg_111_1.leftNameTxt_.text = var_114_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_111_1.leftNameTxt_.transform)

				arg_111_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_111_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_111_1:RecordName(arg_111_1.leftNameTxt_.text)
				SetActive(arg_111_1.iconTrs_.gameObject, true)
				arg_111_1.iconController_:SetSelectedState("hero")

				arg_111_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_knightwoman1")

				arg_111_1.callingController_:SetSelectedState("normal")

				arg_111_1.keyicon_.color = Color.New(1, 1, 1)
				arg_111_1.icon_.color = Color.New(1, 1, 1)

				local var_114_3 = arg_111_1:GetWordFromCfg(413131027)
				local var_114_4 = arg_111_1:FormatText(var_114_3.content)

				arg_111_1.text_.text = var_114_4

				LuaForUtil.ClearLinePrefixSymbol(arg_111_1.text_)

				local var_114_5 = 34
				local var_114_6 = utf8.len(var_114_4)
				local var_114_7 = var_114_5 <= 0 and var_114_1 or var_114_1 * (var_114_6 / var_114_5)

				if var_114_7 > 0 and var_114_1 < var_114_7 then
					arg_111_1.talkMaxDuration = var_114_7

					if var_114_7 + var_114_0 > arg_111_1.duration_ then
						arg_111_1.duration_ = var_114_7 + var_114_0
					end
				end

				arg_111_1.text_.text = var_114_4
				arg_111_1.typewritter.percent = 0

				arg_111_1.typewritter:SetDirty()
				arg_111_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_413131", "413131027", "story_v_out_413131.awb") ~= 0 then
					local var_114_8 = manager.audio:GetVoiceLength("story_v_out_413131", "413131027", "story_v_out_413131.awb") / 1000

					if var_114_8 + var_114_0 > arg_111_1.duration_ then
						arg_111_1.duration_ = var_114_8 + var_114_0
					end

					if var_114_3.prefab_name ~= "" and arg_111_1.actors_[var_114_3.prefab_name] ~= nil then
						local var_114_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_111_1.actors_[var_114_3.prefab_name].transform, "story_v_out_413131", "413131027", "story_v_out_413131.awb")

						arg_111_1:RecordAudio("413131027", var_114_9)
						arg_111_1:RecordAudio("413131027", var_114_9)
					else
						arg_111_1:AudioAction("play", "voice", "story_v_out_413131", "413131027", "story_v_out_413131.awb")
					end

					arg_111_1:RecordHistoryTalkVoice("story_v_out_413131", "413131027", "story_v_out_413131.awb")
				end

				arg_111_1:RecordContent(arg_111_1.text_.text)
			end

			local var_114_10 = math.max(var_114_1, arg_111_1.talkMaxDuration)

			if var_114_0 <= arg_111_1.time_ and arg_111_1.time_ < var_114_0 + var_114_10 then
				arg_111_1.typewritter.percent = (arg_111_1.time_ - var_114_0) / var_114_10

				arg_111_1.typewritter:SetDirty()
			end

			if arg_111_1.time_ >= var_114_0 + var_114_10 and arg_111_1.time_ < var_114_0 + var_114_10 + arg_114_0 then
				arg_111_1.typewritter.percent = 1

				arg_111_1.typewritter:SetDirty()
				arg_111_1:ShowNextGo(true)
			end
		end

		arg_111_1.nodeConfigList_ = {}

		arg_111_1:InitPlayNodeList()
	end,
	Play413131028 = function(arg_115_0, arg_115_1)
		arg_115_1.time_ = 0
		arg_115_1.frameCnt_ = 0
		arg_115_1.state_ = "playing"
		arg_115_1.curTalkId_ = 413131028
		arg_115_1.duration_ = 5

		SetActive(arg_115_1.tipsGo_, false)

		function arg_115_1.onSingleLineFinish_()
			arg_115_1.onSingleLineUpdate_ = nil
			arg_115_1.onSingleLineFinish_ = nil
			arg_115_1.state_ = "waiting"
		end

		function arg_115_1.playNext_(arg_117_0)
			if arg_117_0 == 1 then
				arg_115_0:Play413131029(arg_115_1)
			end
		end

		function arg_115_1.onSingleLineUpdate_(arg_118_0)
			local var_118_0 = 0
			local var_118_1 = 1.2

			if var_118_0 < arg_115_1.time_ and arg_115_1.time_ <= var_118_0 + arg_118_0 then
				arg_115_1.talkMaxDuration = 0
				arg_115_1.dialogCg_.alpha = 1

				arg_115_1.dialog_:SetActive(true)
				SetActive(arg_115_1.leftNameGo_, false)

				arg_115_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_115_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_115_1:RecordName(arg_115_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_115_1.iconTrs_.gameObject, false)
				arg_115_1.callingController_:SetSelectedState("normal")

				local var_118_2 = arg_115_1:GetWordFromCfg(413131028)
				local var_118_3 = arg_115_1:FormatText(var_118_2.content)

				arg_115_1.text_.text = var_118_3

				LuaForUtil.ClearLinePrefixSymbol(arg_115_1.text_)

				local var_118_4 = 48
				local var_118_5 = utf8.len(var_118_3)
				local var_118_6 = var_118_4 <= 0 and var_118_1 or var_118_1 * (var_118_5 / var_118_4)

				if var_118_6 > 0 and var_118_1 < var_118_6 then
					arg_115_1.talkMaxDuration = var_118_6

					if var_118_6 + var_118_0 > arg_115_1.duration_ then
						arg_115_1.duration_ = var_118_6 + var_118_0
					end
				end

				arg_115_1.text_.text = var_118_3
				arg_115_1.typewritter.percent = 0

				arg_115_1.typewritter:SetDirty()
				arg_115_1:ShowNextGo(false)
				arg_115_1:RecordContent(arg_115_1.text_.text)
			end

			local var_118_7 = math.max(var_118_1, arg_115_1.talkMaxDuration)

			if var_118_0 <= arg_115_1.time_ and arg_115_1.time_ < var_118_0 + var_118_7 then
				arg_115_1.typewritter.percent = (arg_115_1.time_ - var_118_0) / var_118_7

				arg_115_1.typewritter:SetDirty()
			end

			if arg_115_1.time_ >= var_118_0 + var_118_7 and arg_115_1.time_ < var_118_0 + var_118_7 + arg_118_0 then
				arg_115_1.typewritter.percent = 1

				arg_115_1.typewritter:SetDirty()
				arg_115_1:ShowNextGo(true)
			end
		end

		arg_115_1.nodeConfigList_ = {}

		arg_115_1:InitPlayNodeList()
	end,
	Play413131029 = function(arg_119_0, arg_119_1)
		arg_119_1.time_ = 0
		arg_119_1.frameCnt_ = 0
		arg_119_1.state_ = "playing"
		arg_119_1.curTalkId_ = 413131029
		arg_119_1.duration_ = 2.43

		local var_119_0 = {
			zh = 2.433,
			ja = 1.999999999999
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
				arg_119_0:Play413131030(arg_119_1)
			end
		end

		function arg_119_1.onSingleLineUpdate_(arg_122_0)
			local var_122_0 = arg_119_1.actors_["10022"].transform
			local var_122_1 = 0

			if var_122_1 < arg_119_1.time_ and arg_119_1.time_ <= var_122_1 + arg_122_0 then
				arg_119_1.var_.moveOldPos10022 = var_122_0.localPosition
				var_122_0.localScale = Vector3.New(1, 1, 1)

				arg_119_1:CheckSpriteTmpPos("10022", 3)

				local var_122_2 = var_122_0.childCount

				for iter_122_0 = 0, var_122_2 - 1 do
					local var_122_3 = var_122_0:GetChild(iter_122_0)

					if var_122_3.name == "split_6" or not string.find(var_122_3.name, "split") then
						var_122_3.gameObject:SetActive(true)
					else
						var_122_3.gameObject:SetActive(false)
					end
				end
			end

			local var_122_4 = 0.001

			if var_122_1 <= arg_119_1.time_ and arg_119_1.time_ < var_122_1 + var_122_4 then
				local var_122_5 = (arg_119_1.time_ - var_122_1) / var_122_4
				local var_122_6 = Vector3.New(0, -315, -320)

				var_122_0.localPosition = Vector3.Lerp(arg_119_1.var_.moveOldPos10022, var_122_6, var_122_5)
			end

			if arg_119_1.time_ >= var_122_1 + var_122_4 and arg_119_1.time_ < var_122_1 + var_122_4 + arg_122_0 then
				var_122_0.localPosition = Vector3.New(0, -315, -320)
			end

			local var_122_7 = arg_119_1.actors_["10022"]
			local var_122_8 = 0

			if var_122_8 < arg_119_1.time_ and arg_119_1.time_ <= var_122_8 + arg_122_0 and not isNil(var_122_7) and arg_119_1.var_.actorSpriteComps10022 == nil then
				arg_119_1.var_.actorSpriteComps10022 = var_122_7:GetComponentsInChildren(typeof(Image), true)
			end

			local var_122_9 = 2

			if var_122_8 <= arg_119_1.time_ and arg_119_1.time_ < var_122_8 + var_122_9 and not isNil(var_122_7) then
				local var_122_10 = (arg_119_1.time_ - var_122_8) / var_122_9

				if arg_119_1.var_.actorSpriteComps10022 then
					for iter_122_1, iter_122_2 in pairs(arg_119_1.var_.actorSpriteComps10022:ToTable()) do
						if iter_122_2 then
							if arg_119_1.isInRecall_ then
								local var_122_11 = Mathf.Lerp(iter_122_2.color.r, arg_119_1.hightColor1.r, var_122_10)
								local var_122_12 = Mathf.Lerp(iter_122_2.color.g, arg_119_1.hightColor1.g, var_122_10)
								local var_122_13 = Mathf.Lerp(iter_122_2.color.b, arg_119_1.hightColor1.b, var_122_10)

								iter_122_2.color = Color.New(var_122_11, var_122_12, var_122_13)
							else
								local var_122_14 = Mathf.Lerp(iter_122_2.color.r, 1, var_122_10)

								iter_122_2.color = Color.New(var_122_14, var_122_14, var_122_14)
							end
						end
					end
				end
			end

			if arg_119_1.time_ >= var_122_8 + var_122_9 and arg_119_1.time_ < var_122_8 + var_122_9 + arg_122_0 and not isNil(var_122_7) and arg_119_1.var_.actorSpriteComps10022 then
				for iter_122_3, iter_122_4 in pairs(arg_119_1.var_.actorSpriteComps10022:ToTable()) do
					if iter_122_4 then
						if arg_119_1.isInRecall_ then
							iter_122_4.color = arg_119_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_122_4.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_119_1.var_.actorSpriteComps10022 = nil
			end

			local var_122_15 = 0
			local var_122_16 = 0.3

			if var_122_15 < arg_119_1.time_ and arg_119_1.time_ <= var_122_15 + arg_122_0 then
				arg_119_1.talkMaxDuration = 0
				arg_119_1.dialogCg_.alpha = 1

				arg_119_1.dialog_:SetActive(true)
				SetActive(arg_119_1.leftNameGo_, true)

				local var_122_17 = arg_119_1:FormatText(StoryNameCfg[614].name)

				arg_119_1.leftNameTxt_.text = var_122_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_119_1.leftNameTxt_.transform)

				arg_119_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_119_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_119_1:RecordName(arg_119_1.leftNameTxt_.text)
				SetActive(arg_119_1.iconTrs_.gameObject, false)
				arg_119_1.callingController_:SetSelectedState("normal")

				local var_122_18 = arg_119_1:GetWordFromCfg(413131029)
				local var_122_19 = arg_119_1:FormatText(var_122_18.content)

				arg_119_1.text_.text = var_122_19

				LuaForUtil.ClearLinePrefixSymbol(arg_119_1.text_)

				local var_122_20 = 12
				local var_122_21 = utf8.len(var_122_19)
				local var_122_22 = var_122_20 <= 0 and var_122_16 or var_122_16 * (var_122_21 / var_122_20)

				if var_122_22 > 0 and var_122_16 < var_122_22 then
					arg_119_1.talkMaxDuration = var_122_22

					if var_122_22 + var_122_15 > arg_119_1.duration_ then
						arg_119_1.duration_ = var_122_22 + var_122_15
					end
				end

				arg_119_1.text_.text = var_122_19
				arg_119_1.typewritter.percent = 0

				arg_119_1.typewritter:SetDirty()
				arg_119_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_413131", "413131029", "story_v_out_413131.awb") ~= 0 then
					local var_122_23 = manager.audio:GetVoiceLength("story_v_out_413131", "413131029", "story_v_out_413131.awb") / 1000

					if var_122_23 + var_122_15 > arg_119_1.duration_ then
						arg_119_1.duration_ = var_122_23 + var_122_15
					end

					if var_122_18.prefab_name ~= "" and arg_119_1.actors_[var_122_18.prefab_name] ~= nil then
						local var_122_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_119_1.actors_[var_122_18.prefab_name].transform, "story_v_out_413131", "413131029", "story_v_out_413131.awb")

						arg_119_1:RecordAudio("413131029", var_122_24)
						arg_119_1:RecordAudio("413131029", var_122_24)
					else
						arg_119_1:AudioAction("play", "voice", "story_v_out_413131", "413131029", "story_v_out_413131.awb")
					end

					arg_119_1:RecordHistoryTalkVoice("story_v_out_413131", "413131029", "story_v_out_413131.awb")
				end

				arg_119_1:RecordContent(arg_119_1.text_.text)
			end

			local var_122_25 = math.max(var_122_16, arg_119_1.talkMaxDuration)

			if var_122_15 <= arg_119_1.time_ and arg_119_1.time_ < var_122_15 + var_122_25 then
				arg_119_1.typewritter.percent = (arg_119_1.time_ - var_122_15) / var_122_25

				arg_119_1.typewritter:SetDirty()
			end

			if arg_119_1.time_ >= var_122_15 + var_122_25 and arg_119_1.time_ < var_122_15 + var_122_25 + arg_122_0 then
				arg_119_1.typewritter.percent = 1

				arg_119_1.typewritter:SetDirty()
				arg_119_1:ShowNextGo(true)
			end
		end

		arg_119_1.nodeConfigList_ = {
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

		arg_119_1:InitPlayNodeList()
	end,
	Play413131030 = function(arg_123_0, arg_123_1)
		arg_123_1.time_ = 0
		arg_123_1.frameCnt_ = 0
		arg_123_1.state_ = "playing"
		arg_123_1.curTalkId_ = 413131030
		arg_123_1.duration_ = 7.63

		local var_123_0 = {
			zh = 5.6,
			ja = 7.633
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
				arg_123_0:Play413131031(arg_123_1)
			end
		end

		function arg_123_1.onSingleLineUpdate_(arg_126_0)
			local var_126_0 = arg_123_1.actors_["10022"]
			local var_126_1 = 0

			if var_126_1 < arg_123_1.time_ and arg_123_1.time_ <= var_126_1 + arg_126_0 and not isNil(var_126_0) and arg_123_1.var_.actorSpriteComps10022 == nil then
				arg_123_1.var_.actorSpriteComps10022 = var_126_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_126_2 = 2

			if var_126_1 <= arg_123_1.time_ and arg_123_1.time_ < var_126_1 + var_126_2 and not isNil(var_126_0) then
				local var_126_3 = (arg_123_1.time_ - var_126_1) / var_126_2

				if arg_123_1.var_.actorSpriteComps10022 then
					for iter_126_0, iter_126_1 in pairs(arg_123_1.var_.actorSpriteComps10022:ToTable()) do
						if iter_126_1 then
							if arg_123_1.isInRecall_ then
								local var_126_4 = Mathf.Lerp(iter_126_1.color.r, arg_123_1.hightColor2.r, var_126_3)
								local var_126_5 = Mathf.Lerp(iter_126_1.color.g, arg_123_1.hightColor2.g, var_126_3)
								local var_126_6 = Mathf.Lerp(iter_126_1.color.b, arg_123_1.hightColor2.b, var_126_3)

								iter_126_1.color = Color.New(var_126_4, var_126_5, var_126_6)
							else
								local var_126_7 = Mathf.Lerp(iter_126_1.color.r, 0.5, var_126_3)

								iter_126_1.color = Color.New(var_126_7, var_126_7, var_126_7)
							end
						end
					end
				end
			end

			if arg_123_1.time_ >= var_126_1 + var_126_2 and arg_123_1.time_ < var_126_1 + var_126_2 + arg_126_0 and not isNil(var_126_0) and arg_123_1.var_.actorSpriteComps10022 then
				for iter_126_2, iter_126_3 in pairs(arg_123_1.var_.actorSpriteComps10022:ToTable()) do
					if iter_126_3 then
						if arg_123_1.isInRecall_ then
							iter_126_3.color = arg_123_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_126_3.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_123_1.var_.actorSpriteComps10022 = nil
			end

			local var_126_8 = 0
			local var_126_9 = 0.775

			if var_126_8 < arg_123_1.time_ and arg_123_1.time_ <= var_126_8 + arg_126_0 then
				arg_123_1.talkMaxDuration = 0
				arg_123_1.dialogCg_.alpha = 1

				arg_123_1.dialog_:SetActive(true)
				SetActive(arg_123_1.leftNameGo_, true)

				local var_126_10 = arg_123_1:FormatText(StoryNameCfg[998].name)

				arg_123_1.leftNameTxt_.text = var_126_10

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_123_1.leftNameTxt_.transform)

				arg_123_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_123_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_123_1:RecordName(arg_123_1.leftNameTxt_.text)
				SetActive(arg_123_1.iconTrs_.gameObject, true)
				arg_123_1.iconController_:SetSelectedState("hero")

				arg_123_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_knightwoman1")

				arg_123_1.callingController_:SetSelectedState("normal")

				arg_123_1.keyicon_.color = Color.New(1, 1, 1)
				arg_123_1.icon_.color = Color.New(1, 1, 1)

				local var_126_11 = arg_123_1:GetWordFromCfg(413131030)
				local var_126_12 = arg_123_1:FormatText(var_126_11.content)

				arg_123_1.text_.text = var_126_12

				LuaForUtil.ClearLinePrefixSymbol(arg_123_1.text_)

				local var_126_13 = 31
				local var_126_14 = utf8.len(var_126_12)
				local var_126_15 = var_126_13 <= 0 and var_126_9 or var_126_9 * (var_126_14 / var_126_13)

				if var_126_15 > 0 and var_126_9 < var_126_15 then
					arg_123_1.talkMaxDuration = var_126_15

					if var_126_15 + var_126_8 > arg_123_1.duration_ then
						arg_123_1.duration_ = var_126_15 + var_126_8
					end
				end

				arg_123_1.text_.text = var_126_12
				arg_123_1.typewritter.percent = 0

				arg_123_1.typewritter:SetDirty()
				arg_123_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_413131", "413131030", "story_v_out_413131.awb") ~= 0 then
					local var_126_16 = manager.audio:GetVoiceLength("story_v_out_413131", "413131030", "story_v_out_413131.awb") / 1000

					if var_126_16 + var_126_8 > arg_123_1.duration_ then
						arg_123_1.duration_ = var_126_16 + var_126_8
					end

					if var_126_11.prefab_name ~= "" and arg_123_1.actors_[var_126_11.prefab_name] ~= nil then
						local var_126_17 = LuaForUtil.PlayVoiceWithCriLipsync(arg_123_1.actors_[var_126_11.prefab_name].transform, "story_v_out_413131", "413131030", "story_v_out_413131.awb")

						arg_123_1:RecordAudio("413131030", var_126_17)
						arg_123_1:RecordAudio("413131030", var_126_17)
					else
						arg_123_1:AudioAction("play", "voice", "story_v_out_413131", "413131030", "story_v_out_413131.awb")
					end

					arg_123_1:RecordHistoryTalkVoice("story_v_out_413131", "413131030", "story_v_out_413131.awb")
				end

				arg_123_1:RecordContent(arg_123_1.text_.text)
			end

			local var_126_18 = math.max(var_126_9, arg_123_1.talkMaxDuration)

			if var_126_8 <= arg_123_1.time_ and arg_123_1.time_ < var_126_8 + var_126_18 then
				arg_123_1.typewritter.percent = (arg_123_1.time_ - var_126_8) / var_126_18

				arg_123_1.typewritter:SetDirty()
			end

			if arg_123_1.time_ >= var_126_8 + var_126_18 and arg_123_1.time_ < var_126_8 + var_126_18 + arg_126_0 then
				arg_123_1.typewritter.percent = 1

				arg_123_1.typewritter:SetDirty()
				arg_123_1:ShowNextGo(true)
			end
		end

		arg_123_1.nodeConfigList_ = {}

		arg_123_1:InitPlayNodeList()
	end,
	Play413131031 = function(arg_127_0, arg_127_1)
		arg_127_1.time_ = 0
		arg_127_1.frameCnt_ = 0
		arg_127_1.state_ = "playing"
		arg_127_1.curTalkId_ = 413131031
		arg_127_1.duration_ = 3.2

		local var_127_0 = {
			zh = 1.999999999999,
			ja = 3.2
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
				arg_127_0:Play413131032(arg_127_1)
			end
		end

		function arg_127_1.onSingleLineUpdate_(arg_130_0)
			local var_130_0 = arg_127_1.actors_["10022"]
			local var_130_1 = 0

			if var_130_1 < arg_127_1.time_ and arg_127_1.time_ <= var_130_1 + arg_130_0 and not isNil(var_130_0) and arg_127_1.var_.actorSpriteComps10022 == nil then
				arg_127_1.var_.actorSpriteComps10022 = var_130_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_130_2 = 2

			if var_130_1 <= arg_127_1.time_ and arg_127_1.time_ < var_130_1 + var_130_2 and not isNil(var_130_0) then
				local var_130_3 = (arg_127_1.time_ - var_130_1) / var_130_2

				if arg_127_1.var_.actorSpriteComps10022 then
					for iter_130_0, iter_130_1 in pairs(arg_127_1.var_.actorSpriteComps10022:ToTable()) do
						if iter_130_1 then
							if arg_127_1.isInRecall_ then
								local var_130_4 = Mathf.Lerp(iter_130_1.color.r, arg_127_1.hightColor1.r, var_130_3)
								local var_130_5 = Mathf.Lerp(iter_130_1.color.g, arg_127_1.hightColor1.g, var_130_3)
								local var_130_6 = Mathf.Lerp(iter_130_1.color.b, arg_127_1.hightColor1.b, var_130_3)

								iter_130_1.color = Color.New(var_130_4, var_130_5, var_130_6)
							else
								local var_130_7 = Mathf.Lerp(iter_130_1.color.r, 1, var_130_3)

								iter_130_1.color = Color.New(var_130_7, var_130_7, var_130_7)
							end
						end
					end
				end
			end

			if arg_127_1.time_ >= var_130_1 + var_130_2 and arg_127_1.time_ < var_130_1 + var_130_2 + arg_130_0 and not isNil(var_130_0) and arg_127_1.var_.actorSpriteComps10022 then
				for iter_130_2, iter_130_3 in pairs(arg_127_1.var_.actorSpriteComps10022:ToTable()) do
					if iter_130_3 then
						if arg_127_1.isInRecall_ then
							iter_130_3.color = arg_127_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_130_3.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_127_1.var_.actorSpriteComps10022 = nil
			end

			local var_130_8 = 0
			local var_130_9 = 0.125

			if var_130_8 < arg_127_1.time_ and arg_127_1.time_ <= var_130_8 + arg_130_0 then
				arg_127_1.talkMaxDuration = 0
				arg_127_1.dialogCg_.alpha = 1

				arg_127_1.dialog_:SetActive(true)
				SetActive(arg_127_1.leftNameGo_, true)

				local var_130_10 = arg_127_1:FormatText(StoryNameCfg[614].name)

				arg_127_1.leftNameTxt_.text = var_130_10

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_127_1.leftNameTxt_.transform)

				arg_127_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_127_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_127_1:RecordName(arg_127_1.leftNameTxt_.text)
				SetActive(arg_127_1.iconTrs_.gameObject, false)
				arg_127_1.callingController_:SetSelectedState("normal")

				local var_130_11 = arg_127_1:GetWordFromCfg(413131031)
				local var_130_12 = arg_127_1:FormatText(var_130_11.content)

				arg_127_1.text_.text = var_130_12

				LuaForUtil.ClearLinePrefixSymbol(arg_127_1.text_)

				local var_130_13 = 5
				local var_130_14 = utf8.len(var_130_12)
				local var_130_15 = var_130_13 <= 0 and var_130_9 or var_130_9 * (var_130_14 / var_130_13)

				if var_130_15 > 0 and var_130_9 < var_130_15 then
					arg_127_1.talkMaxDuration = var_130_15

					if var_130_15 + var_130_8 > arg_127_1.duration_ then
						arg_127_1.duration_ = var_130_15 + var_130_8
					end
				end

				arg_127_1.text_.text = var_130_12
				arg_127_1.typewritter.percent = 0

				arg_127_1.typewritter:SetDirty()
				arg_127_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_413131", "413131031", "story_v_out_413131.awb") ~= 0 then
					local var_130_16 = manager.audio:GetVoiceLength("story_v_out_413131", "413131031", "story_v_out_413131.awb") / 1000

					if var_130_16 + var_130_8 > arg_127_1.duration_ then
						arg_127_1.duration_ = var_130_16 + var_130_8
					end

					if var_130_11.prefab_name ~= "" and arg_127_1.actors_[var_130_11.prefab_name] ~= nil then
						local var_130_17 = LuaForUtil.PlayVoiceWithCriLipsync(arg_127_1.actors_[var_130_11.prefab_name].transform, "story_v_out_413131", "413131031", "story_v_out_413131.awb")

						arg_127_1:RecordAudio("413131031", var_130_17)
						arg_127_1:RecordAudio("413131031", var_130_17)
					else
						arg_127_1:AudioAction("play", "voice", "story_v_out_413131", "413131031", "story_v_out_413131.awb")
					end

					arg_127_1:RecordHistoryTalkVoice("story_v_out_413131", "413131031", "story_v_out_413131.awb")
				end

				arg_127_1:RecordContent(arg_127_1.text_.text)
			end

			local var_130_18 = math.max(var_130_9, arg_127_1.talkMaxDuration)

			if var_130_8 <= arg_127_1.time_ and arg_127_1.time_ < var_130_8 + var_130_18 then
				arg_127_1.typewritter.percent = (arg_127_1.time_ - var_130_8) / var_130_18

				arg_127_1.typewritter:SetDirty()
			end

			if arg_127_1.time_ >= var_130_8 + var_130_18 and arg_127_1.time_ < var_130_8 + var_130_18 + arg_130_0 then
				arg_127_1.typewritter.percent = 1

				arg_127_1.typewritter:SetDirty()
				arg_127_1:ShowNextGo(true)
			end
		end

		arg_127_1.nodeConfigList_ = {}

		arg_127_1:InitPlayNodeList()
	end,
	Play413131032 = function(arg_131_0, arg_131_1)
		arg_131_1.time_ = 0
		arg_131_1.frameCnt_ = 0
		arg_131_1.state_ = "playing"
		arg_131_1.curTalkId_ = 413131032
		arg_131_1.duration_ = 7.37

		local var_131_0 = {
			zh = 5.5,
			ja = 7.366
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
				arg_131_0:Play413131033(arg_131_1)
			end
		end

		function arg_131_1.onSingleLineUpdate_(arg_134_0)
			local var_134_0 = arg_131_1.actors_["10022"]
			local var_134_1 = 0

			if var_134_1 < arg_131_1.time_ and arg_131_1.time_ <= var_134_1 + arg_134_0 and not isNil(var_134_0) and arg_131_1.var_.actorSpriteComps10022 == nil then
				arg_131_1.var_.actorSpriteComps10022 = var_134_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_134_2 = 2

			if var_134_1 <= arg_131_1.time_ and arg_131_1.time_ < var_134_1 + var_134_2 and not isNil(var_134_0) then
				local var_134_3 = (arg_131_1.time_ - var_134_1) / var_134_2

				if arg_131_1.var_.actorSpriteComps10022 then
					for iter_134_0, iter_134_1 in pairs(arg_131_1.var_.actorSpriteComps10022:ToTable()) do
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

			if arg_131_1.time_ >= var_134_1 + var_134_2 and arg_131_1.time_ < var_134_1 + var_134_2 + arg_134_0 and not isNil(var_134_0) and arg_131_1.var_.actorSpriteComps10022 then
				for iter_134_2, iter_134_3 in pairs(arg_131_1.var_.actorSpriteComps10022:ToTable()) do
					if iter_134_3 then
						if arg_131_1.isInRecall_ then
							iter_134_3.color = arg_131_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_134_3.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_131_1.var_.actorSpriteComps10022 = nil
			end

			local var_134_8 = 0
			local var_134_9 = 0.75

			if var_134_8 < arg_131_1.time_ and arg_131_1.time_ <= var_134_8 + arg_134_0 then
				arg_131_1.talkMaxDuration = 0
				arg_131_1.dialogCg_.alpha = 1

				arg_131_1.dialog_:SetActive(true)
				SetActive(arg_131_1.leftNameGo_, true)

				local var_134_10 = arg_131_1:FormatText(StoryNameCfg[998].name)

				arg_131_1.leftNameTxt_.text = var_134_10

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_131_1.leftNameTxt_.transform)

				arg_131_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_131_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_131_1:RecordName(arg_131_1.leftNameTxt_.text)
				SetActive(arg_131_1.iconTrs_.gameObject, true)
				arg_131_1.iconController_:SetSelectedState("hero")

				arg_131_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_knightwoman1")

				arg_131_1.callingController_:SetSelectedState("normal")

				arg_131_1.keyicon_.color = Color.New(1, 1, 1)
				arg_131_1.icon_.color = Color.New(1, 1, 1)

				local var_134_11 = arg_131_1:GetWordFromCfg(413131032)
				local var_134_12 = arg_131_1:FormatText(var_134_11.content)

				arg_131_1.text_.text = var_134_12

				LuaForUtil.ClearLinePrefixSymbol(arg_131_1.text_)

				local var_134_13 = 30
				local var_134_14 = utf8.len(var_134_12)
				local var_134_15 = var_134_13 <= 0 and var_134_9 or var_134_9 * (var_134_14 / var_134_13)

				if var_134_15 > 0 and var_134_9 < var_134_15 then
					arg_131_1.talkMaxDuration = var_134_15

					if var_134_15 + var_134_8 > arg_131_1.duration_ then
						arg_131_1.duration_ = var_134_15 + var_134_8
					end
				end

				arg_131_1.text_.text = var_134_12
				arg_131_1.typewritter.percent = 0

				arg_131_1.typewritter:SetDirty()
				arg_131_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_413131", "413131032", "story_v_out_413131.awb") ~= 0 then
					local var_134_16 = manager.audio:GetVoiceLength("story_v_out_413131", "413131032", "story_v_out_413131.awb") / 1000

					if var_134_16 + var_134_8 > arg_131_1.duration_ then
						arg_131_1.duration_ = var_134_16 + var_134_8
					end

					if var_134_11.prefab_name ~= "" and arg_131_1.actors_[var_134_11.prefab_name] ~= nil then
						local var_134_17 = LuaForUtil.PlayVoiceWithCriLipsync(arg_131_1.actors_[var_134_11.prefab_name].transform, "story_v_out_413131", "413131032", "story_v_out_413131.awb")

						arg_131_1:RecordAudio("413131032", var_134_17)
						arg_131_1:RecordAudio("413131032", var_134_17)
					else
						arg_131_1:AudioAction("play", "voice", "story_v_out_413131", "413131032", "story_v_out_413131.awb")
					end

					arg_131_1:RecordHistoryTalkVoice("story_v_out_413131", "413131032", "story_v_out_413131.awb")
				end

				arg_131_1:RecordContent(arg_131_1.text_.text)
			end

			local var_134_18 = math.max(var_134_9, arg_131_1.talkMaxDuration)

			if var_134_8 <= arg_131_1.time_ and arg_131_1.time_ < var_134_8 + var_134_18 then
				arg_131_1.typewritter.percent = (arg_131_1.time_ - var_134_8) / var_134_18

				arg_131_1.typewritter:SetDirty()
			end

			if arg_131_1.time_ >= var_134_8 + var_134_18 and arg_131_1.time_ < var_134_8 + var_134_18 + arg_134_0 then
				arg_131_1.typewritter.percent = 1

				arg_131_1.typewritter:SetDirty()
				arg_131_1:ShowNextGo(true)
			end
		end

		arg_131_1.nodeConfigList_ = {}

		arg_131_1:InitPlayNodeList()
	end,
	Play413131033 = function(arg_135_0, arg_135_1)
		arg_135_1.time_ = 0
		arg_135_1.frameCnt_ = 0
		arg_135_1.state_ = "playing"
		arg_135_1.curTalkId_ = 413131033
		arg_135_1.duration_ = 6.5

		local var_135_0 = {
			zh = 2.833,
			ja = 6.5
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
				arg_135_0:Play413131034(arg_135_1)
			end
		end

		function arg_135_1.onSingleLineUpdate_(arg_138_0)
			local var_138_0 = arg_135_1.actors_["10022"]
			local var_138_1 = 0

			if var_138_1 < arg_135_1.time_ and arg_135_1.time_ <= var_138_1 + arg_138_0 and not isNil(var_138_0) and arg_135_1.var_.actorSpriteComps10022 == nil then
				arg_135_1.var_.actorSpriteComps10022 = var_138_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_138_2 = 2

			if var_138_1 <= arg_135_1.time_ and arg_135_1.time_ < var_138_1 + var_138_2 and not isNil(var_138_0) then
				local var_138_3 = (arg_135_1.time_ - var_138_1) / var_138_2

				if arg_135_1.var_.actorSpriteComps10022 then
					for iter_138_0, iter_138_1 in pairs(arg_135_1.var_.actorSpriteComps10022:ToTable()) do
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

			if arg_135_1.time_ >= var_138_1 + var_138_2 and arg_135_1.time_ < var_138_1 + var_138_2 + arg_138_0 and not isNil(var_138_0) and arg_135_1.var_.actorSpriteComps10022 then
				for iter_138_2, iter_138_3 in pairs(arg_135_1.var_.actorSpriteComps10022:ToTable()) do
					if iter_138_3 then
						if arg_135_1.isInRecall_ then
							iter_138_3.color = arg_135_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_138_3.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_135_1.var_.actorSpriteComps10022 = nil
			end

			local var_138_8 = 0
			local var_138_9 = 0.375

			if var_138_8 < arg_135_1.time_ and arg_135_1.time_ <= var_138_8 + arg_138_0 then
				arg_135_1.talkMaxDuration = 0
				arg_135_1.dialogCg_.alpha = 1

				arg_135_1.dialog_:SetActive(true)
				SetActive(arg_135_1.leftNameGo_, true)

				local var_138_10 = arg_135_1:FormatText(StoryNameCfg[614].name)

				arg_135_1.leftNameTxt_.text = var_138_10

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_135_1.leftNameTxt_.transform)

				arg_135_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_135_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_135_1:RecordName(arg_135_1.leftNameTxt_.text)
				SetActive(arg_135_1.iconTrs_.gameObject, false)
				arg_135_1.callingController_:SetSelectedState("normal")

				local var_138_11 = arg_135_1:GetWordFromCfg(413131033)
				local var_138_12 = arg_135_1:FormatText(var_138_11.content)

				arg_135_1.text_.text = var_138_12

				LuaForUtil.ClearLinePrefixSymbol(arg_135_1.text_)

				local var_138_13 = 15
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

				if manager.audio:GetVoiceLength("story_v_out_413131", "413131033", "story_v_out_413131.awb") ~= 0 then
					local var_138_16 = manager.audio:GetVoiceLength("story_v_out_413131", "413131033", "story_v_out_413131.awb") / 1000

					if var_138_16 + var_138_8 > arg_135_1.duration_ then
						arg_135_1.duration_ = var_138_16 + var_138_8
					end

					if var_138_11.prefab_name ~= "" and arg_135_1.actors_[var_138_11.prefab_name] ~= nil then
						local var_138_17 = LuaForUtil.PlayVoiceWithCriLipsync(arg_135_1.actors_[var_138_11.prefab_name].transform, "story_v_out_413131", "413131033", "story_v_out_413131.awb")

						arg_135_1:RecordAudio("413131033", var_138_17)
						arg_135_1:RecordAudio("413131033", var_138_17)
					else
						arg_135_1:AudioAction("play", "voice", "story_v_out_413131", "413131033", "story_v_out_413131.awb")
					end

					arg_135_1:RecordHistoryTalkVoice("story_v_out_413131", "413131033", "story_v_out_413131.awb")
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
	Play413131034 = function(arg_139_0, arg_139_1)
		arg_139_1.time_ = 0
		arg_139_1.frameCnt_ = 0
		arg_139_1.state_ = "playing"
		arg_139_1.curTalkId_ = 413131034
		arg_139_1.duration_ = 7.97

		SetActive(arg_139_1.tipsGo_, false)

		function arg_139_1.onSingleLineFinish_()
			arg_139_1.onSingleLineUpdate_ = nil
			arg_139_1.onSingleLineFinish_ = nil
			arg_139_1.state_ = "waiting"
		end

		function arg_139_1.playNext_(arg_141_0)
			if arg_141_0 == 1 then
				arg_139_0:Play413131035(arg_139_1)
			end
		end

		function arg_139_1.onSingleLineUpdate_(arg_142_0)
			local var_142_0 = 1.16666666666667

			if var_142_0 < arg_139_1.time_ and arg_139_1.time_ <= var_142_0 + arg_142_0 then
				local var_142_1 = manager.ui.mainCamera.transform.localPosition
				local var_142_2 = Vector3.New(0, 0, 10) + Vector3.New(var_142_1.x, var_142_1.y, 0)
				local var_142_3 = arg_139_1.bgs_.ST0603a

				var_142_3.transform.localPosition = var_142_2
				var_142_3.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_142_4 = var_142_3:GetComponent("SpriteRenderer")

				if var_142_4 and var_142_4.sprite then
					local var_142_5 = (var_142_3.transform.localPosition - var_142_1).z
					local var_142_6 = manager.ui.mainCameraCom_
					local var_142_7 = 2 * var_142_5 * Mathf.Tan(var_142_6.fieldOfView * 0.5 * Mathf.Deg2Rad)
					local var_142_8 = var_142_7 * var_142_6.aspect
					local var_142_9 = var_142_4.sprite.bounds.size.x
					local var_142_10 = var_142_4.sprite.bounds.size.y
					local var_142_11 = var_142_8 / var_142_9
					local var_142_12 = var_142_7 / var_142_10
					local var_142_13 = var_142_12 < var_142_11 and var_142_11 or var_142_12

					var_142_3.transform.localScale = Vector3.New(var_142_13, var_142_13, 0)
				end

				for iter_142_0, iter_142_1 in pairs(arg_139_1.bgs_) do
					if iter_142_0 ~= "ST0603a" then
						iter_142_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_142_14 = 3.16666666666667

			if var_142_14 < arg_139_1.time_ and arg_139_1.time_ <= var_142_14 + arg_142_0 then
				arg_139_1.allBtn_.enabled = false
			end

			local var_142_15 = 0.3

			if arg_139_1.time_ >= var_142_14 + var_142_15 and arg_139_1.time_ < var_142_14 + var_142_15 + arg_142_0 then
				arg_139_1.allBtn_.enabled = true
			end

			local var_142_16 = 0

			if var_142_16 < arg_139_1.time_ and arg_139_1.time_ <= var_142_16 + arg_142_0 then
				arg_139_1.mask_.enabled = true
				arg_139_1.mask_.raycastTarget = true

				arg_139_1:SetGaussion(false)
			end

			local var_142_17 = 1.16666666666667

			if var_142_16 <= arg_139_1.time_ and arg_139_1.time_ < var_142_16 + var_142_17 then
				local var_142_18 = (arg_139_1.time_ - var_142_16) / var_142_17
				local var_142_19 = Color.New(0, 0, 0)

				var_142_19.a = Mathf.Lerp(0, 1, var_142_18)
				arg_139_1.mask_.color = var_142_19
			end

			if arg_139_1.time_ >= var_142_16 + var_142_17 and arg_139_1.time_ < var_142_16 + var_142_17 + arg_142_0 then
				local var_142_20 = Color.New(0, 0, 0)

				var_142_20.a = 1
				arg_139_1.mask_.color = var_142_20
			end

			local var_142_21 = 1.16666666666667

			if var_142_21 < arg_139_1.time_ and arg_139_1.time_ <= var_142_21 + arg_142_0 then
				arg_139_1.mask_.enabled = true
				arg_139_1.mask_.raycastTarget = true

				arg_139_1:SetGaussion(false)
			end

			local var_142_22 = 2

			if var_142_21 <= arg_139_1.time_ and arg_139_1.time_ < var_142_21 + var_142_22 then
				local var_142_23 = (arg_139_1.time_ - var_142_21) / var_142_22
				local var_142_24 = Color.New(0, 0, 0)

				var_142_24.a = Mathf.Lerp(1, 0, var_142_23)
				arg_139_1.mask_.color = var_142_24
			end

			if arg_139_1.time_ >= var_142_21 + var_142_22 and arg_139_1.time_ < var_142_21 + var_142_22 + arg_142_0 then
				local var_142_25 = Color.New(0, 0, 0)
				local var_142_26 = 0

				arg_139_1.mask_.enabled = false
				var_142_25.a = var_142_26
				arg_139_1.mask_.color = var_142_25
			end

			local var_142_27 = arg_139_1.actors_["10022"].transform
			local var_142_28 = 1.16666666666667

			if var_142_28 < arg_139_1.time_ and arg_139_1.time_ <= var_142_28 + arg_142_0 then
				arg_139_1.var_.moveOldPos10022 = var_142_27.localPosition
				var_142_27.localScale = Vector3.New(1, 1, 1)

				arg_139_1:CheckSpriteTmpPos("10022", 7)

				local var_142_29 = var_142_27.childCount

				for iter_142_2 = 0, var_142_29 - 1 do
					local var_142_30 = var_142_27:GetChild(iter_142_2)

					if var_142_30.name == "split_3" or not string.find(var_142_30.name, "split") then
						var_142_30.gameObject:SetActive(true)
					else
						var_142_30.gameObject:SetActive(false)
					end
				end
			end

			local var_142_31 = 0.001

			if var_142_28 <= arg_139_1.time_ and arg_139_1.time_ < var_142_28 + var_142_31 then
				local var_142_32 = (arg_139_1.time_ - var_142_28) / var_142_31
				local var_142_33 = Vector3.New(0, -2000, 0)

				var_142_27.localPosition = Vector3.Lerp(arg_139_1.var_.moveOldPos10022, var_142_33, var_142_32)
			end

			if arg_139_1.time_ >= var_142_28 + var_142_31 and arg_139_1.time_ < var_142_28 + var_142_31 + arg_142_0 then
				var_142_27.localPosition = Vector3.New(0, -2000, 0)
			end

			if arg_139_1.frameCnt_ <= 1 then
				arg_139_1.dialog_:SetActive(false)
			end

			local var_142_34 = 2.96666666666667
			local var_142_35 = 1.225

			if var_142_34 < arg_139_1.time_ and arg_139_1.time_ <= var_142_34 + arg_142_0 then
				arg_139_1.talkMaxDuration = 0

				arg_139_1.dialog_:SetActive(true)

				arg_139_1.dialogCg_.alpha = 0

				local var_142_36 = LeanTween.value(arg_139_1.dialog_, 0, 1, 0.3)

				var_142_36:setOnUpdate(LuaHelper.FloatAction(function(arg_143_0)
					arg_139_1.dialogCg_.alpha = arg_143_0
				end))
				var_142_36:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_139_1.dialog_)
					var_142_36:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_139_1.duration_ = arg_139_1.duration_ + 0.3

				SetActive(arg_139_1.leftNameGo_, false)

				arg_139_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_139_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_139_1:RecordName(arg_139_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_139_1.iconTrs_.gameObject, false)
				arg_139_1.callingController_:SetSelectedState("normal")

				local var_142_37 = arg_139_1:GetWordFromCfg(413131034)
				local var_142_38 = arg_139_1:FormatText(var_142_37.content)

				arg_139_1.text_.text = var_142_38

				LuaForUtil.ClearLinePrefixSymbol(arg_139_1.text_)

				local var_142_39 = 49
				local var_142_40 = utf8.len(var_142_38)
				local var_142_41 = var_142_39 <= 0 and var_142_35 or var_142_35 * (var_142_40 / var_142_39)

				if var_142_41 > 0 and var_142_35 < var_142_41 then
					arg_139_1.talkMaxDuration = var_142_41
					var_142_34 = var_142_34 + 0.3

					if var_142_41 + var_142_34 > arg_139_1.duration_ then
						arg_139_1.duration_ = var_142_41 + var_142_34
					end
				end

				arg_139_1.text_.text = var_142_38
				arg_139_1.typewritter.percent = 0

				arg_139_1.typewritter:SetDirty()
				arg_139_1:ShowNextGo(false)
				arg_139_1:RecordContent(arg_139_1.text_.text)
			end

			local var_142_42 = var_142_34 + 0.3
			local var_142_43 = math.max(var_142_35, arg_139_1.talkMaxDuration)

			if var_142_42 <= arg_139_1.time_ and arg_139_1.time_ < var_142_42 + var_142_43 then
				arg_139_1.typewritter.percent = (arg_139_1.time_ - var_142_42) / var_142_43

				arg_139_1.typewritter:SetDirty()
			end

			if arg_139_1.time_ >= var_142_42 + var_142_43 and arg_139_1.time_ < var_142_42 + var_142_43 + arg_142_0 then
				arg_139_1.typewritter.percent = 1

				arg_139_1.typewritter:SetDirty()
				arg_139_1:ShowNextGo(true)
			end
		end

		arg_139_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10022",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 1.16666666666667,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_139_1:InitPlayNodeList()
	end,
	Play413131035 = function(arg_145_0, arg_145_1)
		arg_145_1.time_ = 0
		arg_145_1.frameCnt_ = 0
		arg_145_1.state_ = "playing"
		arg_145_1.curTalkId_ = 413131035
		arg_145_1.duration_ = 4.6

		local var_145_0 = {
			zh = 4.6,
			ja = 4.433
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
				arg_145_0:Play413131036(arg_145_1)
			end
		end

		function arg_145_1.onSingleLineUpdate_(arg_148_0)
			local var_148_0 = arg_145_1.actors_["10093"].transform
			local var_148_1 = 0

			if var_148_1 < arg_145_1.time_ and arg_145_1.time_ <= var_148_1 + arg_148_0 then
				arg_145_1.var_.moveOldPos10093 = var_148_0.localPosition
				var_148_0.localScale = Vector3.New(1, 1, 1)

				arg_145_1:CheckSpriteTmpPos("10093", 2)

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
				local var_148_6 = Vector3.New(-390, -345, -245)

				var_148_0.localPosition = Vector3.Lerp(arg_145_1.var_.moveOldPos10093, var_148_6, var_148_5)
			end

			if arg_145_1.time_ >= var_148_1 + var_148_4 and arg_145_1.time_ < var_148_1 + var_148_4 + arg_148_0 then
				var_148_0.localPosition = Vector3.New(-390, -345, -245)
			end

			local var_148_7 = arg_145_1.actors_["10093"]
			local var_148_8 = 0

			if var_148_8 < arg_145_1.time_ and arg_145_1.time_ <= var_148_8 + arg_148_0 and not isNil(var_148_7) and arg_145_1.var_.actorSpriteComps10093 == nil then
				arg_145_1.var_.actorSpriteComps10093 = var_148_7:GetComponentsInChildren(typeof(Image), true)
			end

			local var_148_9 = 2

			if var_148_8 <= arg_145_1.time_ and arg_145_1.time_ < var_148_8 + var_148_9 and not isNil(var_148_7) then
				local var_148_10 = (arg_145_1.time_ - var_148_8) / var_148_9

				if arg_145_1.var_.actorSpriteComps10093 then
					for iter_148_1, iter_148_2 in pairs(arg_145_1.var_.actorSpriteComps10093:ToTable()) do
						if iter_148_2 then
							if arg_145_1.isInRecall_ then
								local var_148_11 = Mathf.Lerp(iter_148_2.color.r, arg_145_1.hightColor1.r, var_148_10)
								local var_148_12 = Mathf.Lerp(iter_148_2.color.g, arg_145_1.hightColor1.g, var_148_10)
								local var_148_13 = Mathf.Lerp(iter_148_2.color.b, arg_145_1.hightColor1.b, var_148_10)

								iter_148_2.color = Color.New(var_148_11, var_148_12, var_148_13)
							else
								local var_148_14 = Mathf.Lerp(iter_148_2.color.r, 1, var_148_10)

								iter_148_2.color = Color.New(var_148_14, var_148_14, var_148_14)
							end
						end
					end
				end
			end

			if arg_145_1.time_ >= var_148_8 + var_148_9 and arg_145_1.time_ < var_148_8 + var_148_9 + arg_148_0 and not isNil(var_148_7) and arg_145_1.var_.actorSpriteComps10093 then
				for iter_148_3, iter_148_4 in pairs(arg_145_1.var_.actorSpriteComps10093:ToTable()) do
					if iter_148_4 then
						if arg_145_1.isInRecall_ then
							iter_148_4.color = arg_145_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_148_4.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_145_1.var_.actorSpriteComps10093 = nil
			end

			local var_148_15 = 0
			local var_148_16 = 0.625

			if var_148_15 < arg_145_1.time_ and arg_145_1.time_ <= var_148_15 + arg_148_0 then
				arg_145_1.talkMaxDuration = 0
				arg_145_1.dialogCg_.alpha = 1

				arg_145_1.dialog_:SetActive(true)
				SetActive(arg_145_1.leftNameGo_, true)

				local var_148_17 = arg_145_1:FormatText(StoryNameCfg[28].name)

				arg_145_1.leftNameTxt_.text = var_148_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_145_1.leftNameTxt_.transform)

				arg_145_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_145_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_145_1:RecordName(arg_145_1.leftNameTxt_.text)
				SetActive(arg_145_1.iconTrs_.gameObject, false)
				arg_145_1.callingController_:SetSelectedState("normal")

				local var_148_18 = arg_145_1:GetWordFromCfg(413131035)
				local var_148_19 = arg_145_1:FormatText(var_148_18.content)

				arg_145_1.text_.text = var_148_19

				LuaForUtil.ClearLinePrefixSymbol(arg_145_1.text_)

				local var_148_20 = 25
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

				if manager.audio:GetVoiceLength("story_v_out_413131", "413131035", "story_v_out_413131.awb") ~= 0 then
					local var_148_23 = manager.audio:GetVoiceLength("story_v_out_413131", "413131035", "story_v_out_413131.awb") / 1000

					if var_148_23 + var_148_15 > arg_145_1.duration_ then
						arg_145_1.duration_ = var_148_23 + var_148_15
					end

					if var_148_18.prefab_name ~= "" and arg_145_1.actors_[var_148_18.prefab_name] ~= nil then
						local var_148_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_145_1.actors_[var_148_18.prefab_name].transform, "story_v_out_413131", "413131035", "story_v_out_413131.awb")

						arg_145_1:RecordAudio("413131035", var_148_24)
						arg_145_1:RecordAudio("413131035", var_148_24)
					else
						arg_145_1:AudioAction("play", "voice", "story_v_out_413131", "413131035", "story_v_out_413131.awb")
					end

					arg_145_1:RecordHistoryTalkVoice("story_v_out_413131", "413131035", "story_v_out_413131.awb")
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
	Play413131036 = function(arg_149_0, arg_149_1)
		arg_149_1.time_ = 0
		arg_149_1.frameCnt_ = 0
		arg_149_1.state_ = "playing"
		arg_149_1.curTalkId_ = 413131036
		arg_149_1.duration_ = 6.27

		local var_149_0 = {
			zh = 4.633,
			ja = 6.266
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
				arg_149_0:Play413131037(arg_149_1)
			end
		end

		function arg_149_1.onSingleLineUpdate_(arg_152_0)
			local var_152_0 = arg_149_1.actors_["10092_1"].transform
			local var_152_1 = 0

			if var_152_1 < arg_149_1.time_ and arg_149_1.time_ <= var_152_1 + arg_152_0 then
				arg_149_1.var_.moveOldPos10092_1 = var_152_0.localPosition
				var_152_0.localScale = Vector3.New(1, 1, 1)

				arg_149_1:CheckSpriteTmpPos("10092_1", 4)

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
				local var_152_6 = Vector3.New(390, -300, -295)

				var_152_0.localPosition = Vector3.Lerp(arg_149_1.var_.moveOldPos10092_1, var_152_6, var_152_5)
			end

			if arg_149_1.time_ >= var_152_1 + var_152_4 and arg_149_1.time_ < var_152_1 + var_152_4 + arg_152_0 then
				var_152_0.localPosition = Vector3.New(390, -300, -295)
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
			local var_152_24 = 0.65

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

				local var_152_26 = arg_149_1:GetWordFromCfg(413131036)
				local var_152_27 = arg_149_1:FormatText(var_152_26.content)

				arg_149_1.text_.text = var_152_27

				LuaForUtil.ClearLinePrefixSymbol(arg_149_1.text_)

				local var_152_28 = 26
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

				if manager.audio:GetVoiceLength("story_v_out_413131", "413131036", "story_v_out_413131.awb") ~= 0 then
					local var_152_31 = manager.audio:GetVoiceLength("story_v_out_413131", "413131036", "story_v_out_413131.awb") / 1000

					if var_152_31 + var_152_23 > arg_149_1.duration_ then
						arg_149_1.duration_ = var_152_31 + var_152_23
					end

					if var_152_26.prefab_name ~= "" and arg_149_1.actors_[var_152_26.prefab_name] ~= nil then
						local var_152_32 = LuaForUtil.PlayVoiceWithCriLipsync(arg_149_1.actors_[var_152_26.prefab_name].transform, "story_v_out_413131", "413131036", "story_v_out_413131.awb")

						arg_149_1:RecordAudio("413131036", var_152_32)
						arg_149_1:RecordAudio("413131036", var_152_32)
					else
						arg_149_1:AudioAction("play", "voice", "story_v_out_413131", "413131036", "story_v_out_413131.awb")
					end

					arg_149_1:RecordHistoryTalkVoice("story_v_out_413131", "413131036", "story_v_out_413131.awb")
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
	Play413131037 = function(arg_153_0, arg_153_1)
		arg_153_1.time_ = 0
		arg_153_1.frameCnt_ = 0
		arg_153_1.state_ = "playing"
		arg_153_1.curTalkId_ = 413131037
		arg_153_1.duration_ = 4.57

		local var_153_0 = {
			zh = 3.033,
			ja = 4.566
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
				arg_153_0:Play413131038(arg_153_1)
			end
		end

		function arg_153_1.onSingleLineUpdate_(arg_156_0)
			local var_156_0 = arg_153_1.actors_["10092_1"]
			local var_156_1 = 0

			if var_156_1 < arg_153_1.time_ and arg_153_1.time_ <= var_156_1 + arg_156_0 and not isNil(var_156_0) and arg_153_1.var_.actorSpriteComps10092_1 == nil then
				arg_153_1.var_.actorSpriteComps10092_1 = var_156_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_156_2 = 2

			if var_156_1 <= arg_153_1.time_ and arg_153_1.time_ < var_156_1 + var_156_2 and not isNil(var_156_0) then
				local var_156_3 = (arg_153_1.time_ - var_156_1) / var_156_2

				if arg_153_1.var_.actorSpriteComps10092_1 then
					for iter_156_0, iter_156_1 in pairs(arg_153_1.var_.actorSpriteComps10092_1:ToTable()) do
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

			if arg_153_1.time_ >= var_156_1 + var_156_2 and arg_153_1.time_ < var_156_1 + var_156_2 + arg_156_0 and not isNil(var_156_0) and arg_153_1.var_.actorSpriteComps10092_1 then
				for iter_156_2, iter_156_3 in pairs(arg_153_1.var_.actorSpriteComps10092_1:ToTable()) do
					if iter_156_3 then
						if arg_153_1.isInRecall_ then
							iter_156_3.color = arg_153_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_156_3.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_153_1.var_.actorSpriteComps10092_1 = nil
			end

			local var_156_8 = 0
			local var_156_9 = 0.35

			if var_156_8 < arg_153_1.time_ and arg_153_1.time_ <= var_156_8 + arg_156_0 then
				arg_153_1.talkMaxDuration = 0
				arg_153_1.dialogCg_.alpha = 1

				arg_153_1.dialog_:SetActive(true)
				SetActive(arg_153_1.leftNameGo_, true)

				local var_156_10 = arg_153_1:FormatText(StoryNameCfg[996].name)

				arg_153_1.leftNameTxt_.text = var_156_10

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_153_1.leftNameTxt_.transform)

				arg_153_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_153_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_153_1:RecordName(arg_153_1.leftNameTxt_.text)
				SetActive(arg_153_1.iconTrs_.gameObject, false)
				arg_153_1.callingController_:SetSelectedState("normal")

				local var_156_11 = arg_153_1:GetWordFromCfg(413131037)
				local var_156_12 = arg_153_1:FormatText(var_156_11.content)

				arg_153_1.text_.text = var_156_12

				LuaForUtil.ClearLinePrefixSymbol(arg_153_1.text_)

				local var_156_13 = 14
				local var_156_14 = utf8.len(var_156_12)
				local var_156_15 = var_156_13 <= 0 and var_156_9 or var_156_9 * (var_156_14 / var_156_13)

				if var_156_15 > 0 and var_156_9 < var_156_15 then
					arg_153_1.talkMaxDuration = var_156_15

					if var_156_15 + var_156_8 > arg_153_1.duration_ then
						arg_153_1.duration_ = var_156_15 + var_156_8
					end
				end

				arg_153_1.text_.text = var_156_12
				arg_153_1.typewritter.percent = 0

				arg_153_1.typewritter:SetDirty()
				arg_153_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_413131", "413131037", "story_v_out_413131.awb") ~= 0 then
					local var_156_16 = manager.audio:GetVoiceLength("story_v_out_413131", "413131037", "story_v_out_413131.awb") / 1000

					if var_156_16 + var_156_8 > arg_153_1.duration_ then
						arg_153_1.duration_ = var_156_16 + var_156_8
					end

					if var_156_11.prefab_name ~= "" and arg_153_1.actors_[var_156_11.prefab_name] ~= nil then
						local var_156_17 = LuaForUtil.PlayVoiceWithCriLipsync(arg_153_1.actors_[var_156_11.prefab_name].transform, "story_v_out_413131", "413131037", "story_v_out_413131.awb")

						arg_153_1:RecordAudio("413131037", var_156_17)
						arg_153_1:RecordAudio("413131037", var_156_17)
					else
						arg_153_1:AudioAction("play", "voice", "story_v_out_413131", "413131037", "story_v_out_413131.awb")
					end

					arg_153_1:RecordHistoryTalkVoice("story_v_out_413131", "413131037", "story_v_out_413131.awb")
				end

				arg_153_1:RecordContent(arg_153_1.text_.text)
			end

			local var_156_18 = math.max(var_156_9, arg_153_1.talkMaxDuration)

			if var_156_8 <= arg_153_1.time_ and arg_153_1.time_ < var_156_8 + var_156_18 then
				arg_153_1.typewritter.percent = (arg_153_1.time_ - var_156_8) / var_156_18

				arg_153_1.typewritter:SetDirty()
			end

			if arg_153_1.time_ >= var_156_8 + var_156_18 and arg_153_1.time_ < var_156_8 + var_156_18 + arg_156_0 then
				arg_153_1.typewritter.percent = 1

				arg_153_1.typewritter:SetDirty()
				arg_153_1:ShowNextGo(true)
			end
		end

		arg_153_1.nodeConfigList_ = {}

		arg_153_1:InitPlayNodeList()
	end,
	Play413131038 = function(arg_157_0, arg_157_1)
		arg_157_1.time_ = 0
		arg_157_1.frameCnt_ = 0
		arg_157_1.state_ = "playing"
		arg_157_1.curTalkId_ = 413131038
		arg_157_1.duration_ = 5.83

		local var_157_0 = {
			zh = 5.8,
			ja = 5.833
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
				arg_157_0:Play413131039(arg_157_1)
			end
		end

		function arg_157_1.onSingleLineUpdate_(arg_160_0)
			local var_160_0 = arg_157_1.actors_["10093"].transform
			local var_160_1 = 0

			if var_160_1 < arg_157_1.time_ and arg_157_1.time_ <= var_160_1 + arg_160_0 then
				arg_157_1.var_.moveOldPos10093 = var_160_0.localPosition
				var_160_0.localScale = Vector3.New(1, 1, 1)

				arg_157_1:CheckSpriteTmpPos("10093", 2)

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
				local var_160_6 = Vector3.New(-390, -345, -245)

				var_160_0.localPosition = Vector3.Lerp(arg_157_1.var_.moveOldPos10093, var_160_6, var_160_5)
			end

			if arg_157_1.time_ >= var_160_1 + var_160_4 and arg_157_1.time_ < var_160_1 + var_160_4 + arg_160_0 then
				var_160_0.localPosition = Vector3.New(-390, -345, -245)
			end

			local var_160_7 = arg_157_1.actors_["10092_1"]
			local var_160_8 = 0

			if var_160_8 < arg_157_1.time_ and arg_157_1.time_ <= var_160_8 + arg_160_0 and not isNil(var_160_7) and arg_157_1.var_.actorSpriteComps10092_1 == nil then
				arg_157_1.var_.actorSpriteComps10092_1 = var_160_7:GetComponentsInChildren(typeof(Image), true)
			end

			local var_160_9 = 2

			if var_160_8 <= arg_157_1.time_ and arg_157_1.time_ < var_160_8 + var_160_9 and not isNil(var_160_7) then
				local var_160_10 = (arg_157_1.time_ - var_160_8) / var_160_9

				if arg_157_1.var_.actorSpriteComps10092_1 then
					for iter_160_1, iter_160_2 in pairs(arg_157_1.var_.actorSpriteComps10092_1:ToTable()) do
						if iter_160_2 then
							if arg_157_1.isInRecall_ then
								local var_160_11 = Mathf.Lerp(iter_160_2.color.r, arg_157_1.hightColor2.r, var_160_10)
								local var_160_12 = Mathf.Lerp(iter_160_2.color.g, arg_157_1.hightColor2.g, var_160_10)
								local var_160_13 = Mathf.Lerp(iter_160_2.color.b, arg_157_1.hightColor2.b, var_160_10)

								iter_160_2.color = Color.New(var_160_11, var_160_12, var_160_13)
							else
								local var_160_14 = Mathf.Lerp(iter_160_2.color.r, 0.5, var_160_10)

								iter_160_2.color = Color.New(var_160_14, var_160_14, var_160_14)
							end
						end
					end
				end
			end

			if arg_157_1.time_ >= var_160_8 + var_160_9 and arg_157_1.time_ < var_160_8 + var_160_9 + arg_160_0 and not isNil(var_160_7) and arg_157_1.var_.actorSpriteComps10092_1 then
				for iter_160_3, iter_160_4 in pairs(arg_157_1.var_.actorSpriteComps10092_1:ToTable()) do
					if iter_160_4 then
						if arg_157_1.isInRecall_ then
							iter_160_4.color = arg_157_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_160_4.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_157_1.var_.actorSpriteComps10092_1 = nil
			end

			local var_160_15 = arg_157_1.actors_["10093"]
			local var_160_16 = 0

			if var_160_16 < arg_157_1.time_ and arg_157_1.time_ <= var_160_16 + arg_160_0 and not isNil(var_160_15) and arg_157_1.var_.actorSpriteComps10093 == nil then
				arg_157_1.var_.actorSpriteComps10093 = var_160_15:GetComponentsInChildren(typeof(Image), true)
			end

			local var_160_17 = 2

			if var_160_16 <= arg_157_1.time_ and arg_157_1.time_ < var_160_16 + var_160_17 and not isNil(var_160_15) then
				local var_160_18 = (arg_157_1.time_ - var_160_16) / var_160_17

				if arg_157_1.var_.actorSpriteComps10093 then
					for iter_160_5, iter_160_6 in pairs(arg_157_1.var_.actorSpriteComps10093:ToTable()) do
						if iter_160_6 then
							if arg_157_1.isInRecall_ then
								local var_160_19 = Mathf.Lerp(iter_160_6.color.r, arg_157_1.hightColor1.r, var_160_18)
								local var_160_20 = Mathf.Lerp(iter_160_6.color.g, arg_157_1.hightColor1.g, var_160_18)
								local var_160_21 = Mathf.Lerp(iter_160_6.color.b, arg_157_1.hightColor1.b, var_160_18)

								iter_160_6.color = Color.New(var_160_19, var_160_20, var_160_21)
							else
								local var_160_22 = Mathf.Lerp(iter_160_6.color.r, 1, var_160_18)

								iter_160_6.color = Color.New(var_160_22, var_160_22, var_160_22)
							end
						end
					end
				end
			end

			if arg_157_1.time_ >= var_160_16 + var_160_17 and arg_157_1.time_ < var_160_16 + var_160_17 + arg_160_0 and not isNil(var_160_15) and arg_157_1.var_.actorSpriteComps10093 then
				for iter_160_7, iter_160_8 in pairs(arg_157_1.var_.actorSpriteComps10093:ToTable()) do
					if iter_160_8 then
						if arg_157_1.isInRecall_ then
							iter_160_8.color = arg_157_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_160_8.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_157_1.var_.actorSpriteComps10093 = nil
			end

			local var_160_23 = 0
			local var_160_24 = 0.65

			if var_160_23 < arg_157_1.time_ and arg_157_1.time_ <= var_160_23 + arg_160_0 then
				arg_157_1.talkMaxDuration = 0
				arg_157_1.dialogCg_.alpha = 1

				arg_157_1.dialog_:SetActive(true)
				SetActive(arg_157_1.leftNameGo_, true)

				local var_160_25 = arg_157_1:FormatText(StoryNameCfg[28].name)

				arg_157_1.leftNameTxt_.text = var_160_25

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_157_1.leftNameTxt_.transform)

				arg_157_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_157_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_157_1:RecordName(arg_157_1.leftNameTxt_.text)
				SetActive(arg_157_1.iconTrs_.gameObject, false)
				arg_157_1.callingController_:SetSelectedState("normal")

				local var_160_26 = arg_157_1:GetWordFromCfg(413131038)
				local var_160_27 = arg_157_1:FormatText(var_160_26.content)

				arg_157_1.text_.text = var_160_27

				LuaForUtil.ClearLinePrefixSymbol(arg_157_1.text_)

				local var_160_28 = 26
				local var_160_29 = utf8.len(var_160_27)
				local var_160_30 = var_160_28 <= 0 and var_160_24 or var_160_24 * (var_160_29 / var_160_28)

				if var_160_30 > 0 and var_160_24 < var_160_30 then
					arg_157_1.talkMaxDuration = var_160_30

					if var_160_30 + var_160_23 > arg_157_1.duration_ then
						arg_157_1.duration_ = var_160_30 + var_160_23
					end
				end

				arg_157_1.text_.text = var_160_27
				arg_157_1.typewritter.percent = 0

				arg_157_1.typewritter:SetDirty()
				arg_157_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_413131", "413131038", "story_v_out_413131.awb") ~= 0 then
					local var_160_31 = manager.audio:GetVoiceLength("story_v_out_413131", "413131038", "story_v_out_413131.awb") / 1000

					if var_160_31 + var_160_23 > arg_157_1.duration_ then
						arg_157_1.duration_ = var_160_31 + var_160_23
					end

					if var_160_26.prefab_name ~= "" and arg_157_1.actors_[var_160_26.prefab_name] ~= nil then
						local var_160_32 = LuaForUtil.PlayVoiceWithCriLipsync(arg_157_1.actors_[var_160_26.prefab_name].transform, "story_v_out_413131", "413131038", "story_v_out_413131.awb")

						arg_157_1:RecordAudio("413131038", var_160_32)
						arg_157_1:RecordAudio("413131038", var_160_32)
					else
						arg_157_1:AudioAction("play", "voice", "story_v_out_413131", "413131038", "story_v_out_413131.awb")
					end

					arg_157_1:RecordHistoryTalkVoice("story_v_out_413131", "413131038", "story_v_out_413131.awb")
				end

				arg_157_1:RecordContent(arg_157_1.text_.text)
			end

			local var_160_33 = math.max(var_160_24, arg_157_1.talkMaxDuration)

			if var_160_23 <= arg_157_1.time_ and arg_157_1.time_ < var_160_23 + var_160_33 then
				arg_157_1.typewritter.percent = (arg_157_1.time_ - var_160_23) / var_160_33

				arg_157_1.typewritter:SetDirty()
			end

			if arg_157_1.time_ >= var_160_23 + var_160_33 and arg_157_1.time_ < var_160_23 + var_160_33 + arg_160_0 then
				arg_157_1.typewritter.percent = 1

				arg_157_1.typewritter:SetDirty()
				arg_157_1:ShowNextGo(true)
			end
		end

		arg_157_1.nodeConfigList_ = {
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
	Play413131039 = function(arg_161_0, arg_161_1)
		arg_161_1.time_ = 0
		arg_161_1.frameCnt_ = 0
		arg_161_1.state_ = "playing"
		arg_161_1.curTalkId_ = 413131039
		arg_161_1.duration_ = 6.2

		local var_161_0 = {
			zh = 3.1,
			ja = 6.2
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
				arg_161_0:Play413131040(arg_161_1)
			end
		end

		function arg_161_1.onSingleLineUpdate_(arg_164_0)
			local var_164_0 = arg_161_1.actors_["10092_1"].transform
			local var_164_1 = 0

			if var_164_1 < arg_161_1.time_ and arg_161_1.time_ <= var_164_1 + arg_164_0 then
				arg_161_1.var_.moveOldPos10092_1 = var_164_0.localPosition
				var_164_0.localScale = Vector3.New(1, 1, 1)

				arg_161_1:CheckSpriteTmpPos("10092_1", 4)

				local var_164_2 = var_164_0.childCount

				for iter_164_0 = 0, var_164_2 - 1 do
					local var_164_3 = var_164_0:GetChild(iter_164_0)

					if var_164_3.name == "split_2" or not string.find(var_164_3.name, "split") then
						var_164_3.gameObject:SetActive(true)
					else
						var_164_3.gameObject:SetActive(false)
					end
				end
			end

			local var_164_4 = 0.001

			if var_164_1 <= arg_161_1.time_ and arg_161_1.time_ < var_164_1 + var_164_4 then
				local var_164_5 = (arg_161_1.time_ - var_164_1) / var_164_4
				local var_164_6 = Vector3.New(390, -300, -295)

				var_164_0.localPosition = Vector3.Lerp(arg_161_1.var_.moveOldPos10092_1, var_164_6, var_164_5)
			end

			if arg_161_1.time_ >= var_164_1 + var_164_4 and arg_161_1.time_ < var_164_1 + var_164_4 + arg_164_0 then
				var_164_0.localPosition = Vector3.New(390, -300, -295)
			end

			local var_164_7 = arg_161_1.actors_["10093"].transform
			local var_164_8 = 0

			if var_164_8 < arg_161_1.time_ and arg_161_1.time_ <= var_164_8 + arg_164_0 then
				arg_161_1.var_.moveOldPos10093 = var_164_7.localPosition
				var_164_7.localScale = Vector3.New(1, 1, 1)

				arg_161_1:CheckSpriteTmpPos("10093", 2)

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
				local var_164_13 = Vector3.New(-390, -345, -245)

				var_164_7.localPosition = Vector3.Lerp(arg_161_1.var_.moveOldPos10093, var_164_13, var_164_12)
			end

			if arg_161_1.time_ >= var_164_8 + var_164_11 and arg_161_1.time_ < var_164_8 + var_164_11 + arg_164_0 then
				var_164_7.localPosition = Vector3.New(-390, -345, -245)
			end

			local var_164_14 = arg_161_1.actors_["10092_1"]
			local var_164_15 = 0

			if var_164_15 < arg_161_1.time_ and arg_161_1.time_ <= var_164_15 + arg_164_0 and not isNil(var_164_14) and arg_161_1.var_.actorSpriteComps10092_1 == nil then
				arg_161_1.var_.actorSpriteComps10092_1 = var_164_14:GetComponentsInChildren(typeof(Image), true)
			end

			local var_164_16 = 2

			if var_164_15 <= arg_161_1.time_ and arg_161_1.time_ < var_164_15 + var_164_16 and not isNil(var_164_14) then
				local var_164_17 = (arg_161_1.time_ - var_164_15) / var_164_16

				if arg_161_1.var_.actorSpriteComps10092_1 then
					for iter_164_2, iter_164_3 in pairs(arg_161_1.var_.actorSpriteComps10092_1:ToTable()) do
						if iter_164_3 then
							if arg_161_1.isInRecall_ then
								local var_164_18 = Mathf.Lerp(iter_164_3.color.r, arg_161_1.hightColor1.r, var_164_17)
								local var_164_19 = Mathf.Lerp(iter_164_3.color.g, arg_161_1.hightColor1.g, var_164_17)
								local var_164_20 = Mathf.Lerp(iter_164_3.color.b, arg_161_1.hightColor1.b, var_164_17)

								iter_164_3.color = Color.New(var_164_18, var_164_19, var_164_20)
							else
								local var_164_21 = Mathf.Lerp(iter_164_3.color.r, 1, var_164_17)

								iter_164_3.color = Color.New(var_164_21, var_164_21, var_164_21)
							end
						end
					end
				end
			end

			if arg_161_1.time_ >= var_164_15 + var_164_16 and arg_161_1.time_ < var_164_15 + var_164_16 + arg_164_0 and not isNil(var_164_14) and arg_161_1.var_.actorSpriteComps10092_1 then
				for iter_164_4, iter_164_5 in pairs(arg_161_1.var_.actorSpriteComps10092_1:ToTable()) do
					if iter_164_5 then
						if arg_161_1.isInRecall_ then
							iter_164_5.color = arg_161_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_164_5.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_161_1.var_.actorSpriteComps10092_1 = nil
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
			local var_164_31 = 0.425

			if var_164_30 < arg_161_1.time_ and arg_161_1.time_ <= var_164_30 + arg_164_0 then
				arg_161_1.talkMaxDuration = 0
				arg_161_1.dialogCg_.alpha = 1

				arg_161_1.dialog_:SetActive(true)
				SetActive(arg_161_1.leftNameGo_, true)

				local var_164_32 = arg_161_1:FormatText(StoryNameCfg[996].name)

				arg_161_1.leftNameTxt_.text = var_164_32

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_161_1.leftNameTxt_.transform)

				arg_161_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_161_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_161_1:RecordName(arg_161_1.leftNameTxt_.text)
				SetActive(arg_161_1.iconTrs_.gameObject, false)
				arg_161_1.callingController_:SetSelectedState("normal")

				local var_164_33 = arg_161_1:GetWordFromCfg(413131039)
				local var_164_34 = arg_161_1:FormatText(var_164_33.content)

				arg_161_1.text_.text = var_164_34

				LuaForUtil.ClearLinePrefixSymbol(arg_161_1.text_)

				local var_164_35 = 17
				local var_164_36 = utf8.len(var_164_34)
				local var_164_37 = var_164_35 <= 0 and var_164_31 or var_164_31 * (var_164_36 / var_164_35)

				if var_164_37 > 0 and var_164_31 < var_164_37 then
					arg_161_1.talkMaxDuration = var_164_37

					if var_164_37 + var_164_30 > arg_161_1.duration_ then
						arg_161_1.duration_ = var_164_37 + var_164_30
					end
				end

				arg_161_1.text_.text = var_164_34
				arg_161_1.typewritter.percent = 0

				arg_161_1.typewritter:SetDirty()
				arg_161_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_413131", "413131039", "story_v_out_413131.awb") ~= 0 then
					local var_164_38 = manager.audio:GetVoiceLength("story_v_out_413131", "413131039", "story_v_out_413131.awb") / 1000

					if var_164_38 + var_164_30 > arg_161_1.duration_ then
						arg_161_1.duration_ = var_164_38 + var_164_30
					end

					if var_164_33.prefab_name ~= "" and arg_161_1.actors_[var_164_33.prefab_name] ~= nil then
						local var_164_39 = LuaForUtil.PlayVoiceWithCriLipsync(arg_161_1.actors_[var_164_33.prefab_name].transform, "story_v_out_413131", "413131039", "story_v_out_413131.awb")

						arg_161_1:RecordAudio("413131039", var_164_39)
						arg_161_1:RecordAudio("413131039", var_164_39)
					else
						arg_161_1:AudioAction("play", "voice", "story_v_out_413131", "413131039", "story_v_out_413131.awb")
					end

					arg_161_1:RecordHistoryTalkVoice("story_v_out_413131", "413131039", "story_v_out_413131.awb")
				end

				arg_161_1:RecordContent(arg_161_1.text_.text)
			end

			local var_164_40 = math.max(var_164_31, arg_161_1.talkMaxDuration)

			if var_164_30 <= arg_161_1.time_ and arg_161_1.time_ < var_164_30 + var_164_40 then
				arg_161_1.typewritter.percent = (arg_161_1.time_ - var_164_30) / var_164_40

				arg_161_1.typewritter:SetDirty()
			end

			if arg_161_1.time_ >= var_164_30 + var_164_40 and arg_161_1.time_ < var_164_30 + var_164_40 + arg_164_0 then
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
	Play413131040 = function(arg_165_0, arg_165_1)
		arg_165_1.time_ = 0
		arg_165_1.frameCnt_ = 0
		arg_165_1.state_ = "playing"
		arg_165_1.curTalkId_ = 413131040
		arg_165_1.duration_ = 8.8

		local var_165_0 = {
			zh = 8.8,
			ja = 7.733
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
				arg_165_0:Play413131041(arg_165_1)
			end
		end

		function arg_165_1.onSingleLineUpdate_(arg_168_0)
			local var_168_0 = arg_165_1.actors_["10092_1"].transform
			local var_168_1 = 0

			if var_168_1 < arg_165_1.time_ and arg_165_1.time_ <= var_168_1 + arg_168_0 then
				arg_165_1.var_.moveOldPos10092_1 = var_168_0.localPosition
				var_168_0.localScale = Vector3.New(1, 1, 1)

				arg_165_1:CheckSpriteTmpPos("10092_1", 4)

				local var_168_2 = var_168_0.childCount

				for iter_168_0 = 0, var_168_2 - 1 do
					local var_168_3 = var_168_0:GetChild(iter_168_0)

					if var_168_3.name == "split_1_1" or not string.find(var_168_3.name, "split") then
						var_168_3.gameObject:SetActive(true)
					else
						var_168_3.gameObject:SetActive(false)
					end
				end
			end

			local var_168_4 = 0.001

			if var_168_1 <= arg_165_1.time_ and arg_165_1.time_ < var_168_1 + var_168_4 then
				local var_168_5 = (arg_165_1.time_ - var_168_1) / var_168_4
				local var_168_6 = Vector3.New(390, -300, -295)

				var_168_0.localPosition = Vector3.Lerp(arg_165_1.var_.moveOldPos10092_1, var_168_6, var_168_5)
			end

			if arg_165_1.time_ >= var_168_1 + var_168_4 and arg_165_1.time_ < var_168_1 + var_168_4 + arg_168_0 then
				var_168_0.localPosition = Vector3.New(390, -300, -295)
			end

			local var_168_7 = 0
			local var_168_8 = 1.075

			if var_168_7 < arg_165_1.time_ and arg_165_1.time_ <= var_168_7 + arg_168_0 then
				arg_165_1.talkMaxDuration = 0
				arg_165_1.dialogCg_.alpha = 1

				arg_165_1.dialog_:SetActive(true)
				SetActive(arg_165_1.leftNameGo_, true)

				local var_168_9 = arg_165_1:FormatText(StoryNameCfg[996].name)

				arg_165_1.leftNameTxt_.text = var_168_9

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_165_1.leftNameTxt_.transform)

				arg_165_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_165_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_165_1:RecordName(arg_165_1.leftNameTxt_.text)
				SetActive(arg_165_1.iconTrs_.gameObject, false)
				arg_165_1.callingController_:SetSelectedState("normal")

				local var_168_10 = arg_165_1:GetWordFromCfg(413131040)
				local var_168_11 = arg_165_1:FormatText(var_168_10.content)

				arg_165_1.text_.text = var_168_11

				LuaForUtil.ClearLinePrefixSymbol(arg_165_1.text_)

				local var_168_12 = 43
				local var_168_13 = utf8.len(var_168_11)
				local var_168_14 = var_168_12 <= 0 and var_168_8 or var_168_8 * (var_168_13 / var_168_12)

				if var_168_14 > 0 and var_168_8 < var_168_14 then
					arg_165_1.talkMaxDuration = var_168_14

					if var_168_14 + var_168_7 > arg_165_1.duration_ then
						arg_165_1.duration_ = var_168_14 + var_168_7
					end
				end

				arg_165_1.text_.text = var_168_11
				arg_165_1.typewritter.percent = 0

				arg_165_1.typewritter:SetDirty()
				arg_165_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_413131", "413131040", "story_v_out_413131.awb") ~= 0 then
					local var_168_15 = manager.audio:GetVoiceLength("story_v_out_413131", "413131040", "story_v_out_413131.awb") / 1000

					if var_168_15 + var_168_7 > arg_165_1.duration_ then
						arg_165_1.duration_ = var_168_15 + var_168_7
					end

					if var_168_10.prefab_name ~= "" and arg_165_1.actors_[var_168_10.prefab_name] ~= nil then
						local var_168_16 = LuaForUtil.PlayVoiceWithCriLipsync(arg_165_1.actors_[var_168_10.prefab_name].transform, "story_v_out_413131", "413131040", "story_v_out_413131.awb")

						arg_165_1:RecordAudio("413131040", var_168_16)
						arg_165_1:RecordAudio("413131040", var_168_16)
					else
						arg_165_1:AudioAction("play", "voice", "story_v_out_413131", "413131040", "story_v_out_413131.awb")
					end

					arg_165_1:RecordHistoryTalkVoice("story_v_out_413131", "413131040", "story_v_out_413131.awb")
				end

				arg_165_1:RecordContent(arg_165_1.text_.text)
			end

			local var_168_17 = math.max(var_168_8, arg_165_1.talkMaxDuration)

			if var_168_7 <= arg_165_1.time_ and arg_165_1.time_ < var_168_7 + var_168_17 then
				arg_165_1.typewritter.percent = (arg_165_1.time_ - var_168_7) / var_168_17

				arg_165_1.typewritter:SetDirty()
			end

			if arg_165_1.time_ >= var_168_7 + var_168_17 and arg_165_1.time_ < var_168_7 + var_168_17 + arg_168_0 then
				arg_165_1.typewritter.percent = 1

				arg_165_1.typewritter:SetDirty()
				arg_165_1:ShowNextGo(true)
			end
		end

		arg_165_1.nodeConfigList_ = {
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

		arg_165_1:InitPlayNodeList()
	end,
	Play413131041 = function(arg_169_0, arg_169_1)
		arg_169_1.time_ = 0
		arg_169_1.frameCnt_ = 0
		arg_169_1.state_ = "playing"
		arg_169_1.curTalkId_ = 413131041
		arg_169_1.duration_ = 7.67

		local var_169_0 = {
			zh = 6.866,
			ja = 7.666
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
				arg_169_0:Play413131042(arg_169_1)
			end
		end

		function arg_169_1.onSingleLineUpdate_(arg_172_0)
			local var_172_0 = "F08i"

			if arg_169_1.bgs_[var_172_0] == nil then
				local var_172_1 = Object.Instantiate(arg_169_1.paintGo_)

				var_172_1:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. var_172_0)
				var_172_1.name = var_172_0
				var_172_1.transform.parent = arg_169_1.stage_.transform
				var_172_1.transform.localPosition = Vector3.New(0, 100, 0)
				arg_169_1.bgs_[var_172_0] = var_172_1
			end

			local var_172_2 = 2

			if var_172_2 < arg_169_1.time_ and arg_169_1.time_ <= var_172_2 + arg_172_0 then
				local var_172_3 = manager.ui.mainCamera.transform.localPosition
				local var_172_4 = Vector3.New(0, 0, 10) + Vector3.New(var_172_3.x, var_172_3.y, 0)
				local var_172_5 = arg_169_1.bgs_.F08i

				var_172_5.transform.localPosition = var_172_4
				var_172_5.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_172_6 = var_172_5:GetComponent("SpriteRenderer")

				if var_172_6 and var_172_6.sprite then
					local var_172_7 = (var_172_5.transform.localPosition - var_172_3).z
					local var_172_8 = manager.ui.mainCameraCom_
					local var_172_9 = 2 * var_172_7 * Mathf.Tan(var_172_8.fieldOfView * 0.5 * Mathf.Deg2Rad)
					local var_172_10 = var_172_9 * var_172_8.aspect
					local var_172_11 = var_172_6.sprite.bounds.size.x
					local var_172_12 = var_172_6.sprite.bounds.size.y
					local var_172_13 = var_172_10 / var_172_11
					local var_172_14 = var_172_9 / var_172_12
					local var_172_15 = var_172_14 < var_172_13 and var_172_13 or var_172_14

					var_172_5.transform.localScale = Vector3.New(var_172_15, var_172_15, 0)
				end

				for iter_172_0, iter_172_1 in pairs(arg_169_1.bgs_) do
					if iter_172_0 ~= "F08i" then
						iter_172_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_172_16 = 3.9

			if var_172_16 < arg_169_1.time_ and arg_169_1.time_ <= var_172_16 + arg_172_0 then
				arg_169_1.allBtn_.enabled = false
			end

			local var_172_17 = 0.3

			if arg_169_1.time_ >= var_172_16 + var_172_17 and arg_169_1.time_ < var_172_16 + var_172_17 + arg_172_0 then
				arg_169_1.allBtn_.enabled = true
			end

			local var_172_18 = 0

			if var_172_18 < arg_169_1.time_ and arg_169_1.time_ <= var_172_18 + arg_172_0 then
				arg_169_1.mask_.enabled = true
				arg_169_1.mask_.raycastTarget = true

				arg_169_1:SetGaussion(false)
			end

			local var_172_19 = 2

			if var_172_18 <= arg_169_1.time_ and arg_169_1.time_ < var_172_18 + var_172_19 then
				local var_172_20 = (arg_169_1.time_ - var_172_18) / var_172_19
				local var_172_21 = Color.New(0, 0, 0)

				var_172_21.a = Mathf.Lerp(0, 1, var_172_20)
				arg_169_1.mask_.color = var_172_21
			end

			if arg_169_1.time_ >= var_172_18 + var_172_19 and arg_169_1.time_ < var_172_18 + var_172_19 + arg_172_0 then
				local var_172_22 = Color.New(0, 0, 0)

				var_172_22.a = 1
				arg_169_1.mask_.color = var_172_22
			end

			local var_172_23 = 2

			if var_172_23 < arg_169_1.time_ and arg_169_1.time_ <= var_172_23 + arg_172_0 then
				arg_169_1.mask_.enabled = true
				arg_169_1.mask_.raycastTarget = true

				arg_169_1:SetGaussion(false)
			end

			local var_172_24 = 2

			if var_172_23 <= arg_169_1.time_ and arg_169_1.time_ < var_172_23 + var_172_24 then
				local var_172_25 = (arg_169_1.time_ - var_172_23) / var_172_24
				local var_172_26 = Color.New(0, 0, 0)

				var_172_26.a = Mathf.Lerp(1, 0, var_172_25)
				arg_169_1.mask_.color = var_172_26
			end

			if arg_169_1.time_ >= var_172_23 + var_172_24 and arg_169_1.time_ < var_172_23 + var_172_24 + arg_172_0 then
				local var_172_27 = Color.New(0, 0, 0)
				local var_172_28 = 0

				arg_169_1.mask_.enabled = false
				var_172_27.a = var_172_28
				arg_169_1.mask_.color = var_172_27
			end

			local var_172_29 = arg_169_1.actors_["10092_1"].transform
			local var_172_30 = 2

			if var_172_30 < arg_169_1.time_ and arg_169_1.time_ <= var_172_30 + arg_172_0 then
				arg_169_1.var_.moveOldPos10092_1 = var_172_29.localPosition
				var_172_29.localScale = Vector3.New(1, 1, 1)

				arg_169_1:CheckSpriteTmpPos("10092_1", 6)

				local var_172_31 = var_172_29.childCount

				for iter_172_2 = 0, var_172_31 - 1 do
					local var_172_32 = var_172_29:GetChild(iter_172_2)

					if var_172_32.name == "" or not string.find(var_172_32.name, "split") then
						var_172_32.gameObject:SetActive(true)
					else
						var_172_32.gameObject:SetActive(false)
					end
				end
			end

			local var_172_33 = 0.001

			if var_172_30 <= arg_169_1.time_ and arg_169_1.time_ < var_172_30 + var_172_33 then
				local var_172_34 = (arg_169_1.time_ - var_172_30) / var_172_33
				local var_172_35 = Vector3.New(1500, -300, -295)

				var_172_29.localPosition = Vector3.Lerp(arg_169_1.var_.moveOldPos10092_1, var_172_35, var_172_34)
			end

			if arg_169_1.time_ >= var_172_30 + var_172_33 and arg_169_1.time_ < var_172_30 + var_172_33 + arg_172_0 then
				var_172_29.localPosition = Vector3.New(1500, -300, -295)
			end

			local var_172_36 = arg_169_1.actors_["10093"].transform
			local var_172_37 = 2

			if var_172_37 < arg_169_1.time_ and arg_169_1.time_ <= var_172_37 + arg_172_0 then
				arg_169_1.var_.moveOldPos10093 = var_172_36.localPosition
				var_172_36.localScale = Vector3.New(1, 1, 1)

				arg_169_1:CheckSpriteTmpPos("10093", 6)

				local var_172_38 = var_172_36.childCount

				for iter_172_3 = 0, var_172_38 - 1 do
					local var_172_39 = var_172_36:GetChild(iter_172_3)

					if var_172_39.name == "" or not string.find(var_172_39.name, "split") then
						var_172_39.gameObject:SetActive(true)
					else
						var_172_39.gameObject:SetActive(false)
					end
				end
			end

			local var_172_40 = 0.001

			if var_172_37 <= arg_169_1.time_ and arg_169_1.time_ < var_172_37 + var_172_40 then
				local var_172_41 = (arg_169_1.time_ - var_172_37) / var_172_40
				local var_172_42 = Vector3.New(1500, -345, -245)

				var_172_36.localPosition = Vector3.Lerp(arg_169_1.var_.moveOldPos10093, var_172_42, var_172_41)
			end

			if arg_169_1.time_ >= var_172_37 + var_172_40 and arg_169_1.time_ < var_172_37 + var_172_40 + arg_172_0 then
				var_172_36.localPosition = Vector3.New(1500, -345, -245)
			end

			if arg_169_1.frameCnt_ <= 1 then
				arg_169_1.dialog_:SetActive(false)
			end

			local var_172_43 = 3.9
			local var_172_44 = 0.475

			if var_172_43 < arg_169_1.time_ and arg_169_1.time_ <= var_172_43 + arg_172_0 then
				arg_169_1.talkMaxDuration = 0

				arg_169_1.dialog_:SetActive(true)

				arg_169_1.dialogCg_.alpha = 0

				local var_172_45 = LeanTween.value(arg_169_1.dialog_, 0, 1, 0.3)

				var_172_45:setOnUpdate(LuaHelper.FloatAction(function(arg_173_0)
					arg_169_1.dialogCg_.alpha = arg_173_0
				end))
				var_172_45:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_169_1.dialog_)
					var_172_45:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_169_1.duration_ = arg_169_1.duration_ + 0.3

				SetActive(arg_169_1.leftNameGo_, true)

				local var_172_46 = arg_169_1:FormatText(StoryNameCfg[992].name)

				arg_169_1.leftNameTxt_.text = var_172_46

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_169_1.leftNameTxt_.transform)

				arg_169_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_169_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_169_1:RecordName(arg_169_1.leftNameTxt_.text)
				SetActive(arg_169_1.iconTrs_.gameObject, true)
				arg_169_1.iconController_:SetSelectedState("hero")

				arg_169_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_knightman1")

				arg_169_1.callingController_:SetSelectedState("normal")

				arg_169_1.keyicon_.color = Color.New(1, 1, 1)
				arg_169_1.icon_.color = Color.New(1, 1, 1)

				local var_172_47 = arg_169_1:GetWordFromCfg(413131041)
				local var_172_48 = arg_169_1:FormatText(var_172_47.content)

				arg_169_1.text_.text = var_172_48

				LuaForUtil.ClearLinePrefixSymbol(arg_169_1.text_)

				local var_172_49 = 19
				local var_172_50 = utf8.len(var_172_48)
				local var_172_51 = var_172_49 <= 0 and var_172_44 or var_172_44 * (var_172_50 / var_172_49)

				if var_172_51 > 0 and var_172_44 < var_172_51 then
					arg_169_1.talkMaxDuration = var_172_51
					var_172_43 = var_172_43 + 0.3

					if var_172_51 + var_172_43 > arg_169_1.duration_ then
						arg_169_1.duration_ = var_172_51 + var_172_43
					end
				end

				arg_169_1.text_.text = var_172_48
				arg_169_1.typewritter.percent = 0

				arg_169_1.typewritter:SetDirty()
				arg_169_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_413131", "413131041", "story_v_out_413131.awb") ~= 0 then
					local var_172_52 = manager.audio:GetVoiceLength("story_v_out_413131", "413131041", "story_v_out_413131.awb") / 1000

					if var_172_52 + var_172_43 > arg_169_1.duration_ then
						arg_169_1.duration_ = var_172_52 + var_172_43
					end

					if var_172_47.prefab_name ~= "" and arg_169_1.actors_[var_172_47.prefab_name] ~= nil then
						local var_172_53 = LuaForUtil.PlayVoiceWithCriLipsync(arg_169_1.actors_[var_172_47.prefab_name].transform, "story_v_out_413131", "413131041", "story_v_out_413131.awb")

						arg_169_1:RecordAudio("413131041", var_172_53)
						arg_169_1:RecordAudio("413131041", var_172_53)
					else
						arg_169_1:AudioAction("play", "voice", "story_v_out_413131", "413131041", "story_v_out_413131.awb")
					end

					arg_169_1:RecordHistoryTalkVoice("story_v_out_413131", "413131041", "story_v_out_413131.awb")
				end

				arg_169_1:RecordContent(arg_169_1.text_.text)
			end

			local var_172_54 = var_172_43 + 0.3
			local var_172_55 = math.max(var_172_44, arg_169_1.talkMaxDuration)

			if var_172_54 <= arg_169_1.time_ and arg_169_1.time_ < var_172_54 + var_172_55 then
				arg_169_1.typewritter.percent = (arg_169_1.time_ - var_172_54) / var_172_55

				arg_169_1.typewritter:SetDirty()
			end

			if arg_169_1.time_ >= var_172_54 + var_172_55 and arg_169_1.time_ < var_172_54 + var_172_55 + arg_172_0 then
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

		arg_169_1:InitPlayNodeList()
	end,
	Play413131042 = function(arg_175_0, arg_175_1)
		arg_175_1.time_ = 0
		arg_175_1.frameCnt_ = 0
		arg_175_1.state_ = "playing"
		arg_175_1.curTalkId_ = 413131042
		arg_175_1.duration_ = 6.73

		local var_175_0 = {
			zh = 4.966,
			ja = 6.733
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
				arg_175_0:Play413131043(arg_175_1)
			end
		end

		function arg_175_1.onSingleLineUpdate_(arg_178_0)
			local var_178_0 = arg_175_1.actors_["10094"].transform
			local var_178_1 = 0

			if var_178_1 < arg_175_1.time_ and arg_175_1.time_ <= var_178_1 + arg_178_0 then
				arg_175_1.var_.moveOldPos10094 = var_178_0.localPosition
				var_178_0.localScale = Vector3.New(1, 1, 1)

				arg_175_1:CheckSpriteTmpPos("10094", 3)

				local var_178_2 = var_178_0.childCount

				for iter_178_0 = 0, var_178_2 - 1 do
					local var_178_3 = var_178_0:GetChild(iter_178_0)

					if var_178_3.name == "" or not string.find(var_178_3.name, "split") then
						var_178_3.gameObject:SetActive(true)
					else
						var_178_3.gameObject:SetActive(false)
					end
				end
			end

			local var_178_4 = 0.001

			if var_178_1 <= arg_175_1.time_ and arg_175_1.time_ < var_178_1 + var_178_4 then
				local var_178_5 = (arg_175_1.time_ - var_178_1) / var_178_4
				local var_178_6 = Vector3.New(0, -340, -414)

				var_178_0.localPosition = Vector3.Lerp(arg_175_1.var_.moveOldPos10094, var_178_6, var_178_5)
			end

			if arg_175_1.time_ >= var_178_1 + var_178_4 and arg_175_1.time_ < var_178_1 + var_178_4 + arg_178_0 then
				var_178_0.localPosition = Vector3.New(0, -340, -414)
			end

			local var_178_7 = arg_175_1.actors_["10094"]
			local var_178_8 = 0

			if var_178_8 < arg_175_1.time_ and arg_175_1.time_ <= var_178_8 + arg_178_0 and not isNil(var_178_7) and arg_175_1.var_.actorSpriteComps10094 == nil then
				arg_175_1.var_.actorSpriteComps10094 = var_178_7:GetComponentsInChildren(typeof(Image), true)
			end

			local var_178_9 = 2

			if var_178_8 <= arg_175_1.time_ and arg_175_1.time_ < var_178_8 + var_178_9 and not isNil(var_178_7) then
				local var_178_10 = (arg_175_1.time_ - var_178_8) / var_178_9

				if arg_175_1.var_.actorSpriteComps10094 then
					for iter_178_1, iter_178_2 in pairs(arg_175_1.var_.actorSpriteComps10094:ToTable()) do
						if iter_178_2 then
							if arg_175_1.isInRecall_ then
								local var_178_11 = Mathf.Lerp(iter_178_2.color.r, arg_175_1.hightColor1.r, var_178_10)
								local var_178_12 = Mathf.Lerp(iter_178_2.color.g, arg_175_1.hightColor1.g, var_178_10)
								local var_178_13 = Mathf.Lerp(iter_178_2.color.b, arg_175_1.hightColor1.b, var_178_10)

								iter_178_2.color = Color.New(var_178_11, var_178_12, var_178_13)
							else
								local var_178_14 = Mathf.Lerp(iter_178_2.color.r, 1, var_178_10)

								iter_178_2.color = Color.New(var_178_14, var_178_14, var_178_14)
							end
						end
					end
				end
			end

			if arg_175_1.time_ >= var_178_8 + var_178_9 and arg_175_1.time_ < var_178_8 + var_178_9 + arg_178_0 and not isNil(var_178_7) and arg_175_1.var_.actorSpriteComps10094 then
				for iter_178_3, iter_178_4 in pairs(arg_175_1.var_.actorSpriteComps10094:ToTable()) do
					if iter_178_4 then
						if arg_175_1.isInRecall_ then
							iter_178_4.color = arg_175_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_178_4.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_175_1.var_.actorSpriteComps10094 = nil
			end

			local var_178_15 = 0
			local var_178_16 = 0.675

			if var_178_15 < arg_175_1.time_ and arg_175_1.time_ <= var_178_15 + arg_178_0 then
				arg_175_1.talkMaxDuration = 0
				arg_175_1.dialogCg_.alpha = 1

				arg_175_1.dialog_:SetActive(true)
				SetActive(arg_175_1.leftNameGo_, true)

				local var_178_17 = arg_175_1:FormatText(StoryNameCfg[259].name)

				arg_175_1.leftNameTxt_.text = var_178_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_175_1.leftNameTxt_.transform)

				arg_175_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_175_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_175_1:RecordName(arg_175_1.leftNameTxt_.text)
				SetActive(arg_175_1.iconTrs_.gameObject, false)
				arg_175_1.callingController_:SetSelectedState("normal")

				local var_178_18 = arg_175_1:GetWordFromCfg(413131042)
				local var_178_19 = arg_175_1:FormatText(var_178_18.content)

				arg_175_1.text_.text = var_178_19

				LuaForUtil.ClearLinePrefixSymbol(arg_175_1.text_)

				local var_178_20 = 27
				local var_178_21 = utf8.len(var_178_19)
				local var_178_22 = var_178_20 <= 0 and var_178_16 or var_178_16 * (var_178_21 / var_178_20)

				if var_178_22 > 0 and var_178_16 < var_178_22 then
					arg_175_1.talkMaxDuration = var_178_22

					if var_178_22 + var_178_15 > arg_175_1.duration_ then
						arg_175_1.duration_ = var_178_22 + var_178_15
					end
				end

				arg_175_1.text_.text = var_178_19
				arg_175_1.typewritter.percent = 0

				arg_175_1.typewritter:SetDirty()
				arg_175_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_413131", "413131042", "story_v_out_413131.awb") ~= 0 then
					local var_178_23 = manager.audio:GetVoiceLength("story_v_out_413131", "413131042", "story_v_out_413131.awb") / 1000

					if var_178_23 + var_178_15 > arg_175_1.duration_ then
						arg_175_1.duration_ = var_178_23 + var_178_15
					end

					if var_178_18.prefab_name ~= "" and arg_175_1.actors_[var_178_18.prefab_name] ~= nil then
						local var_178_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_175_1.actors_[var_178_18.prefab_name].transform, "story_v_out_413131", "413131042", "story_v_out_413131.awb")

						arg_175_1:RecordAudio("413131042", var_178_24)
						arg_175_1:RecordAudio("413131042", var_178_24)
					else
						arg_175_1:AudioAction("play", "voice", "story_v_out_413131", "413131042", "story_v_out_413131.awb")
					end

					arg_175_1:RecordHistoryTalkVoice("story_v_out_413131", "413131042", "story_v_out_413131.awb")
				end

				arg_175_1:RecordContent(arg_175_1.text_.text)
			end

			local var_178_25 = math.max(var_178_16, arg_175_1.talkMaxDuration)

			if var_178_15 <= arg_175_1.time_ and arg_175_1.time_ < var_178_15 + var_178_25 then
				arg_175_1.typewritter.percent = (arg_175_1.time_ - var_178_15) / var_178_25

				arg_175_1.typewritter:SetDirty()
			end

			if arg_175_1.time_ >= var_178_15 + var_178_25 and arg_175_1.time_ < var_178_15 + var_178_25 + arg_178_0 then
				arg_175_1.typewritter.percent = 1

				arg_175_1.typewritter:SetDirty()
				arg_175_1:ShowNextGo(true)
			end
		end

		arg_175_1.nodeConfigList_ = {
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

		arg_175_1:InitPlayNodeList()
	end,
	Play413131043 = function(arg_179_0, arg_179_1)
		arg_179_1.time_ = 0
		arg_179_1.frameCnt_ = 0
		arg_179_1.state_ = "playing"
		arg_179_1.curTalkId_ = 413131043
		arg_179_1.duration_ = 5.9

		SetActive(arg_179_1.tipsGo_, false)

		function arg_179_1.onSingleLineFinish_()
			arg_179_1.onSingleLineUpdate_ = nil
			arg_179_1.onSingleLineFinish_ = nil
			arg_179_1.state_ = "waiting"
		end

		function arg_179_1.playNext_(arg_181_0)
			if arg_181_0 == 1 then
				arg_179_0:Play413131044(arg_179_1)
			end
		end

		function arg_179_1.onSingleLineUpdate_(arg_182_0)
			local var_182_0 = arg_179_1.actors_["10094"].transform
			local var_182_1 = 0

			if var_182_1 < arg_179_1.time_ and arg_179_1.time_ <= var_182_1 + arg_182_0 then
				arg_179_1.var_.moveOldPos10094 = var_182_0.localPosition
				var_182_0.localScale = Vector3.New(1, 1, 1)

				arg_179_1:CheckSpriteTmpPos("10094", 6)

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
				local var_182_6 = Vector3.New(1500, -340, -414)

				var_182_0.localPosition = Vector3.Lerp(arg_179_1.var_.moveOldPos10094, var_182_6, var_182_5)
			end

			if arg_179_1.time_ >= var_182_1 + var_182_4 and arg_179_1.time_ < var_182_1 + var_182_4 + arg_182_0 then
				var_182_0.localPosition = Vector3.New(1500, -340, -414)
			end

			local var_182_7 = arg_179_1.actors_["10094"]
			local var_182_8 = 0

			if var_182_8 < arg_179_1.time_ and arg_179_1.time_ <= var_182_8 + arg_182_0 and not isNil(var_182_7) and arg_179_1.var_.actorSpriteComps10094 == nil then
				arg_179_1.var_.actorSpriteComps10094 = var_182_7:GetComponentsInChildren(typeof(Image), true)
			end

			local var_182_9 = 2

			if var_182_8 <= arg_179_1.time_ and arg_179_1.time_ < var_182_8 + var_182_9 and not isNil(var_182_7) then
				local var_182_10 = (arg_179_1.time_ - var_182_8) / var_182_9

				if arg_179_1.var_.actorSpriteComps10094 then
					for iter_182_1, iter_182_2 in pairs(arg_179_1.var_.actorSpriteComps10094:ToTable()) do
						if iter_182_2 then
							if arg_179_1.isInRecall_ then
								local var_182_11 = Mathf.Lerp(iter_182_2.color.r, arg_179_1.hightColor2.r, var_182_10)
								local var_182_12 = Mathf.Lerp(iter_182_2.color.g, arg_179_1.hightColor2.g, var_182_10)
								local var_182_13 = Mathf.Lerp(iter_182_2.color.b, arg_179_1.hightColor2.b, var_182_10)

								iter_182_2.color = Color.New(var_182_11, var_182_12, var_182_13)
							else
								local var_182_14 = Mathf.Lerp(iter_182_2.color.r, 0.5, var_182_10)

								iter_182_2.color = Color.New(var_182_14, var_182_14, var_182_14)
							end
						end
					end
				end
			end

			if arg_179_1.time_ >= var_182_8 + var_182_9 and arg_179_1.time_ < var_182_8 + var_182_9 + arg_182_0 and not isNil(var_182_7) and arg_179_1.var_.actorSpriteComps10094 then
				for iter_182_3, iter_182_4 in pairs(arg_179_1.var_.actorSpriteComps10094:ToTable()) do
					if iter_182_4 then
						if arg_179_1.isInRecall_ then
							iter_182_4.color = arg_179_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_182_4.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_179_1.var_.actorSpriteComps10094 = nil
			end

			local var_182_15 = 0

			if var_182_15 < arg_179_1.time_ and arg_179_1.time_ <= var_182_15 + arg_182_0 then
				arg_179_1.mask_.enabled = true
				arg_179_1.mask_.raycastTarget = false

				arg_179_1:SetGaussion(false)
			end

			local var_182_16 = 0.766666666666667

			if var_182_15 <= arg_179_1.time_ and arg_179_1.time_ < var_182_15 + var_182_16 then
				local var_182_17 = (arg_179_1.time_ - var_182_15) / var_182_16
				local var_182_18 = Color.New(1, 1, 1)

				var_182_18.a = Mathf.Lerp(1, 0, var_182_17)
				arg_179_1.mask_.color = var_182_18
			end

			if arg_179_1.time_ >= var_182_15 + var_182_16 and arg_179_1.time_ < var_182_15 + var_182_16 + arg_182_0 then
				local var_182_19 = Color.New(1, 1, 1)
				local var_182_20 = 0

				arg_179_1.mask_.enabled = false
				var_182_19.a = var_182_20
				arg_179_1.mask_.color = var_182_19
			end

			local var_182_21 = 0
			local var_182_22 = 1

			if var_182_21 < arg_179_1.time_ and arg_179_1.time_ <= var_182_21 + arg_182_0 then
				local var_182_23 = "play"
				local var_182_24 = "effect"

				arg_179_1:AudioAction(var_182_23, var_182_24, "se_story_123_02", "se_story_123_02_cannon_loop", "")
			end

			if arg_179_1.frameCnt_ <= 1 then
				arg_179_1.dialog_:SetActive(false)
			end

			local var_182_25 = 0.9
			local var_182_26 = 1.25

			if var_182_25 < arg_179_1.time_ and arg_179_1.time_ <= var_182_25 + arg_182_0 then
				arg_179_1.talkMaxDuration = 0

				arg_179_1.dialog_:SetActive(true)

				arg_179_1.dialogCg_.alpha = 0

				local var_182_27 = LeanTween.value(arg_179_1.dialog_, 0, 1, 0.3)

				var_182_27:setOnUpdate(LuaHelper.FloatAction(function(arg_183_0)
					arg_179_1.dialogCg_.alpha = arg_183_0
				end))
				var_182_27:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_179_1.dialog_)
					var_182_27:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_179_1.duration_ = arg_179_1.duration_ + 0.3

				SetActive(arg_179_1.leftNameGo_, false)

				arg_179_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_179_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_179_1:RecordName(arg_179_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_179_1.iconTrs_.gameObject, false)
				arg_179_1.callingController_:SetSelectedState("normal")

				local var_182_28 = arg_179_1:GetWordFromCfg(413131043)
				local var_182_29 = arg_179_1:FormatText(var_182_28.content)

				arg_179_1.text_.text = var_182_29

				LuaForUtil.ClearLinePrefixSymbol(arg_179_1.text_)

				local var_182_30 = 50
				local var_182_31 = utf8.len(var_182_29)
				local var_182_32 = var_182_30 <= 0 and var_182_26 or var_182_26 * (var_182_31 / var_182_30)

				if var_182_32 > 0 and var_182_26 < var_182_32 then
					arg_179_1.talkMaxDuration = var_182_32
					var_182_25 = var_182_25 + 0.3

					if var_182_32 + var_182_25 > arg_179_1.duration_ then
						arg_179_1.duration_ = var_182_32 + var_182_25
					end
				end

				arg_179_1.text_.text = var_182_29
				arg_179_1.typewritter.percent = 0

				arg_179_1.typewritter:SetDirty()
				arg_179_1:ShowNextGo(false)
				arg_179_1:RecordContent(arg_179_1.text_.text)
			end

			local var_182_33 = var_182_25 + 0.3
			local var_182_34 = math.max(var_182_26, arg_179_1.talkMaxDuration)

			if var_182_33 <= arg_179_1.time_ and arg_179_1.time_ < var_182_33 + var_182_34 then
				arg_179_1.typewritter.percent = (arg_179_1.time_ - var_182_33) / var_182_34

				arg_179_1.typewritter:SetDirty()
			end

			if arg_179_1.time_ >= var_182_33 + var_182_34 and arg_179_1.time_ < var_182_33 + var_182_34 + arg_182_0 then
				arg_179_1.typewritter.percent = 1

				arg_179_1.typewritter:SetDirty()
				arg_179_1:ShowNextGo(true)
			end
		end

		arg_179_1.nodeConfigList_ = {
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

		arg_179_1:InitPlayNodeList()
	end,
	Play413131044 = function(arg_185_0, arg_185_1)
		arg_185_1.time_ = 0
		arg_185_1.frameCnt_ = 0
		arg_185_1.state_ = "playing"
		arg_185_1.curTalkId_ = 413131044
		arg_185_1.duration_ = 5

		SetActive(arg_185_1.tipsGo_, false)

		function arg_185_1.onSingleLineFinish_()
			arg_185_1.onSingleLineUpdate_ = nil
			arg_185_1.onSingleLineFinish_ = nil
			arg_185_1.state_ = "waiting"
		end

		function arg_185_1.playNext_(arg_187_0)
			if arg_187_0 == 1 then
				arg_185_0:Play413131045(arg_185_1)
			end
		end

		function arg_185_1.onSingleLineUpdate_(arg_188_0)
			local var_188_0 = 0
			local var_188_1 = 1.1

			if var_188_0 < arg_185_1.time_ and arg_185_1.time_ <= var_188_0 + arg_188_0 then
				arg_185_1.talkMaxDuration = 0
				arg_185_1.dialogCg_.alpha = 1

				arg_185_1.dialog_:SetActive(true)
				SetActive(arg_185_1.leftNameGo_, false)

				arg_185_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_185_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_185_1:RecordName(arg_185_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_185_1.iconTrs_.gameObject, false)
				arg_185_1.callingController_:SetSelectedState("normal")

				local var_188_2 = arg_185_1:GetWordFromCfg(413131044)
				local var_188_3 = arg_185_1:FormatText(var_188_2.content)

				arg_185_1.text_.text = var_188_3

				LuaForUtil.ClearLinePrefixSymbol(arg_185_1.text_)

				local var_188_4 = 44
				local var_188_5 = utf8.len(var_188_3)
				local var_188_6 = var_188_4 <= 0 and var_188_1 or var_188_1 * (var_188_5 / var_188_4)

				if var_188_6 > 0 and var_188_1 < var_188_6 then
					arg_185_1.talkMaxDuration = var_188_6

					if var_188_6 + var_188_0 > arg_185_1.duration_ then
						arg_185_1.duration_ = var_188_6 + var_188_0
					end
				end

				arg_185_1.text_.text = var_188_3
				arg_185_1.typewritter.percent = 0

				arg_185_1.typewritter:SetDirty()
				arg_185_1:ShowNextGo(false)
				arg_185_1:RecordContent(arg_185_1.text_.text)
			end

			local var_188_7 = math.max(var_188_1, arg_185_1.talkMaxDuration)

			if var_188_0 <= arg_185_1.time_ and arg_185_1.time_ < var_188_0 + var_188_7 then
				arg_185_1.typewritter.percent = (arg_185_1.time_ - var_188_0) / var_188_7

				arg_185_1.typewritter:SetDirty()
			end

			if arg_185_1.time_ >= var_188_0 + var_188_7 and arg_185_1.time_ < var_188_0 + var_188_7 + arg_188_0 then
				arg_185_1.typewritter.percent = 1

				arg_185_1.typewritter:SetDirty()
				arg_185_1:ShowNextGo(true)
			end
		end

		arg_185_1.nodeConfigList_ = {}

		arg_185_1:InitPlayNodeList()
	end,
	Play413131045 = function(arg_189_0, arg_189_1)
		arg_189_1.time_ = 0
		arg_189_1.frameCnt_ = 0
		arg_189_1.state_ = "playing"
		arg_189_1.curTalkId_ = 413131045
		arg_189_1.duration_ = 4.03

		local var_189_0 = {
			zh = 2.966,
			ja = 4.033
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
				arg_189_0:Play413131046(arg_189_1)
			end
		end

		function arg_189_1.onSingleLineUpdate_(arg_192_0)
			local var_192_0 = arg_189_1.actors_["10094"].transform
			local var_192_1 = 0

			if var_192_1 < arg_189_1.time_ and arg_189_1.time_ <= var_192_1 + arg_192_0 then
				arg_189_1.var_.moveOldPos10094 = var_192_0.localPosition
				var_192_0.localScale = Vector3.New(1, 1, 1)

				arg_189_1:CheckSpriteTmpPos("10094", 3)

				local var_192_2 = var_192_0.childCount

				for iter_192_0 = 0, var_192_2 - 1 do
					local var_192_3 = var_192_0:GetChild(iter_192_0)

					if var_192_3.name == "" or not string.find(var_192_3.name, "split") then
						var_192_3.gameObject:SetActive(true)
					else
						var_192_3.gameObject:SetActive(false)
					end
				end
			end

			local var_192_4 = 0.001

			if var_192_1 <= arg_189_1.time_ and arg_189_1.time_ < var_192_1 + var_192_4 then
				local var_192_5 = (arg_189_1.time_ - var_192_1) / var_192_4
				local var_192_6 = Vector3.New(0, -340, -414)

				var_192_0.localPosition = Vector3.Lerp(arg_189_1.var_.moveOldPos10094, var_192_6, var_192_5)
			end

			if arg_189_1.time_ >= var_192_1 + var_192_4 and arg_189_1.time_ < var_192_1 + var_192_4 + arg_192_0 then
				var_192_0.localPosition = Vector3.New(0, -340, -414)
			end

			local var_192_7 = arg_189_1.actors_["10094"]
			local var_192_8 = 0

			if var_192_8 < arg_189_1.time_ and arg_189_1.time_ <= var_192_8 + arg_192_0 and not isNil(var_192_7) and arg_189_1.var_.actorSpriteComps10094 == nil then
				arg_189_1.var_.actorSpriteComps10094 = var_192_7:GetComponentsInChildren(typeof(Image), true)
			end

			local var_192_9 = 2

			if var_192_8 <= arg_189_1.time_ and arg_189_1.time_ < var_192_8 + var_192_9 and not isNil(var_192_7) then
				local var_192_10 = (arg_189_1.time_ - var_192_8) / var_192_9

				if arg_189_1.var_.actorSpriteComps10094 then
					for iter_192_1, iter_192_2 in pairs(arg_189_1.var_.actorSpriteComps10094:ToTable()) do
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

			if arg_189_1.time_ >= var_192_8 + var_192_9 and arg_189_1.time_ < var_192_8 + var_192_9 + arg_192_0 and not isNil(var_192_7) and arg_189_1.var_.actorSpriteComps10094 then
				for iter_192_3, iter_192_4 in pairs(arg_189_1.var_.actorSpriteComps10094:ToTable()) do
					if iter_192_4 then
						if arg_189_1.isInRecall_ then
							iter_192_4.color = arg_189_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_192_4.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_189_1.var_.actorSpriteComps10094 = nil
			end

			local var_192_15 = 0
			local var_192_16 = 0.35

			if var_192_15 < arg_189_1.time_ and arg_189_1.time_ <= var_192_15 + arg_192_0 then
				arg_189_1.talkMaxDuration = 0
				arg_189_1.dialogCg_.alpha = 1

				arg_189_1.dialog_:SetActive(true)
				SetActive(arg_189_1.leftNameGo_, true)

				local var_192_17 = arg_189_1:FormatText(StoryNameCfg[259].name)

				arg_189_1.leftNameTxt_.text = var_192_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_189_1.leftNameTxt_.transform)

				arg_189_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_189_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_189_1:RecordName(arg_189_1.leftNameTxt_.text)
				SetActive(arg_189_1.iconTrs_.gameObject, false)
				arg_189_1.callingController_:SetSelectedState("normal")

				local var_192_18 = arg_189_1:GetWordFromCfg(413131045)
				local var_192_19 = arg_189_1:FormatText(var_192_18.content)

				arg_189_1.text_.text = var_192_19

				LuaForUtil.ClearLinePrefixSymbol(arg_189_1.text_)

				local var_192_20 = 14
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

				if manager.audio:GetVoiceLength("story_v_out_413131", "413131045", "story_v_out_413131.awb") ~= 0 then
					local var_192_23 = manager.audio:GetVoiceLength("story_v_out_413131", "413131045", "story_v_out_413131.awb") / 1000

					if var_192_23 + var_192_15 > arg_189_1.duration_ then
						arg_189_1.duration_ = var_192_23 + var_192_15
					end

					if var_192_18.prefab_name ~= "" and arg_189_1.actors_[var_192_18.prefab_name] ~= nil then
						local var_192_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_189_1.actors_[var_192_18.prefab_name].transform, "story_v_out_413131", "413131045", "story_v_out_413131.awb")

						arg_189_1:RecordAudio("413131045", var_192_24)
						arg_189_1:RecordAudio("413131045", var_192_24)
					else
						arg_189_1:AudioAction("play", "voice", "story_v_out_413131", "413131045", "story_v_out_413131.awb")
					end

					arg_189_1:RecordHistoryTalkVoice("story_v_out_413131", "413131045", "story_v_out_413131.awb")
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
				actorName = "10094",
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
	Play413131046 = function(arg_193_0, arg_193_1)
		arg_193_1.time_ = 0
		arg_193_1.frameCnt_ = 0
		arg_193_1.state_ = "playing"
		arg_193_1.curTalkId_ = 413131046
		arg_193_1.duration_ = 5.03

		local var_193_0 = {
			zh = 3.7,
			ja = 5.033
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
				arg_193_0:Play413131047(arg_193_1)
			end
		end

		function arg_193_1.onSingleLineUpdate_(arg_196_0)
			local var_196_0 = 0
			local var_196_1 = 0.375

			if var_196_0 < arg_193_1.time_ and arg_193_1.time_ <= var_196_0 + arg_196_0 then
				arg_193_1.talkMaxDuration = 0
				arg_193_1.dialogCg_.alpha = 1

				arg_193_1.dialog_:SetActive(true)
				SetActive(arg_193_1.leftNameGo_, true)

				local var_196_2 = arg_193_1:FormatText(StoryNameCfg[259].name)

				arg_193_1.leftNameTxt_.text = var_196_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_193_1.leftNameTxt_.transform)

				arg_193_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_193_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_193_1:RecordName(arg_193_1.leftNameTxt_.text)
				SetActive(arg_193_1.iconTrs_.gameObject, false)
				arg_193_1.callingController_:SetSelectedState("normal")

				local var_196_3 = arg_193_1:GetWordFromCfg(413131046)
				local var_196_4 = arg_193_1:FormatText(var_196_3.content)

				arg_193_1.text_.text = var_196_4

				LuaForUtil.ClearLinePrefixSymbol(arg_193_1.text_)

				local var_196_5 = 15
				local var_196_6 = utf8.len(var_196_4)
				local var_196_7 = var_196_5 <= 0 and var_196_1 or var_196_1 * (var_196_6 / var_196_5)

				if var_196_7 > 0 and var_196_1 < var_196_7 then
					arg_193_1.talkMaxDuration = var_196_7

					if var_196_7 + var_196_0 > arg_193_1.duration_ then
						arg_193_1.duration_ = var_196_7 + var_196_0
					end
				end

				arg_193_1.text_.text = var_196_4
				arg_193_1.typewritter.percent = 0

				arg_193_1.typewritter:SetDirty()
				arg_193_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_413131", "413131046", "story_v_out_413131.awb") ~= 0 then
					local var_196_8 = manager.audio:GetVoiceLength("story_v_out_413131", "413131046", "story_v_out_413131.awb") / 1000

					if var_196_8 + var_196_0 > arg_193_1.duration_ then
						arg_193_1.duration_ = var_196_8 + var_196_0
					end

					if var_196_3.prefab_name ~= "" and arg_193_1.actors_[var_196_3.prefab_name] ~= nil then
						local var_196_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_193_1.actors_[var_196_3.prefab_name].transform, "story_v_out_413131", "413131046", "story_v_out_413131.awb")

						arg_193_1:RecordAudio("413131046", var_196_9)
						arg_193_1:RecordAudio("413131046", var_196_9)
					else
						arg_193_1:AudioAction("play", "voice", "story_v_out_413131", "413131046", "story_v_out_413131.awb")
					end

					arg_193_1:RecordHistoryTalkVoice("story_v_out_413131", "413131046", "story_v_out_413131.awb")
				end

				arg_193_1:RecordContent(arg_193_1.text_.text)
			end

			local var_196_10 = math.max(var_196_1, arg_193_1.talkMaxDuration)

			if var_196_0 <= arg_193_1.time_ and arg_193_1.time_ < var_196_0 + var_196_10 then
				arg_193_1.typewritter.percent = (arg_193_1.time_ - var_196_0) / var_196_10

				arg_193_1.typewritter:SetDirty()
			end

			if arg_193_1.time_ >= var_196_0 + var_196_10 and arg_193_1.time_ < var_196_0 + var_196_10 + arg_196_0 then
				arg_193_1.typewritter.percent = 1

				arg_193_1.typewritter:SetDirty()
				arg_193_1:ShowNextGo(true)
			end
		end

		arg_193_1.nodeConfigList_ = {}

		arg_193_1:InitPlayNodeList()
	end,
	Play413131047 = function(arg_197_0, arg_197_1)
		arg_197_1.time_ = 0
		arg_197_1.frameCnt_ = 0
		arg_197_1.state_ = "playing"
		arg_197_1.curTalkId_ = 413131047
		arg_197_1.duration_ = 4.9

		local var_197_0 = {
			zh = 4.066,
			ja = 4.9
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
				arg_197_0:Play413131048(arg_197_1)
			end
		end

		function arg_197_1.onSingleLineUpdate_(arg_200_0)
			local var_200_0 = 0
			local var_200_1 = 0.35

			if var_200_0 < arg_197_1.time_ and arg_197_1.time_ <= var_200_0 + arg_200_0 then
				arg_197_1.talkMaxDuration = 0
				arg_197_1.dialogCg_.alpha = 1

				arg_197_1.dialog_:SetActive(true)
				SetActive(arg_197_1.leftNameGo_, true)

				local var_200_2 = arg_197_1:FormatText(StoryNameCfg[259].name)

				arg_197_1.leftNameTxt_.text = var_200_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_197_1.leftNameTxt_.transform)

				arg_197_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_197_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_197_1:RecordName(arg_197_1.leftNameTxt_.text)
				SetActive(arg_197_1.iconTrs_.gameObject, false)
				arg_197_1.callingController_:SetSelectedState("normal")

				local var_200_3 = arg_197_1:GetWordFromCfg(413131047)
				local var_200_4 = arg_197_1:FormatText(var_200_3.content)

				arg_197_1.text_.text = var_200_4

				LuaForUtil.ClearLinePrefixSymbol(arg_197_1.text_)

				local var_200_5 = 14
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

				if manager.audio:GetVoiceLength("story_v_out_413131", "413131047", "story_v_out_413131.awb") ~= 0 then
					local var_200_8 = manager.audio:GetVoiceLength("story_v_out_413131", "413131047", "story_v_out_413131.awb") / 1000

					if var_200_8 + var_200_0 > arg_197_1.duration_ then
						arg_197_1.duration_ = var_200_8 + var_200_0
					end

					if var_200_3.prefab_name ~= "" and arg_197_1.actors_[var_200_3.prefab_name] ~= nil then
						local var_200_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_197_1.actors_[var_200_3.prefab_name].transform, "story_v_out_413131", "413131047", "story_v_out_413131.awb")

						arg_197_1:RecordAudio("413131047", var_200_9)
						arg_197_1:RecordAudio("413131047", var_200_9)
					else
						arg_197_1:AudioAction("play", "voice", "story_v_out_413131", "413131047", "story_v_out_413131.awb")
					end

					arg_197_1:RecordHistoryTalkVoice("story_v_out_413131", "413131047", "story_v_out_413131.awb")
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
	Play413131048 = function(arg_201_0, arg_201_1)
		arg_201_1.time_ = 0
		arg_201_1.frameCnt_ = 0
		arg_201_1.state_ = "playing"
		arg_201_1.curTalkId_ = 413131048
		arg_201_1.duration_ = 7.33

		SetActive(arg_201_1.tipsGo_, false)

		function arg_201_1.onSingleLineFinish_()
			arg_201_1.onSingleLineUpdate_ = nil
			arg_201_1.onSingleLineFinish_ = nil
			arg_201_1.state_ = "waiting"
		end

		function arg_201_1.playNext_(arg_203_0)
			if arg_203_0 == 1 then
				arg_201_0:Play413131049(arg_201_1)
			end
		end

		function arg_201_1.onSingleLineUpdate_(arg_204_0)
			local var_204_0 = 0.833333333333333

			if var_204_0 < arg_201_1.time_ and arg_201_1.time_ <= var_204_0 + arg_204_0 then
				local var_204_1 = manager.ui.mainCamera.transform.localPosition
				local var_204_2 = Vector3.New(0, 0, 10) + Vector3.New(var_204_1.x, var_204_1.y, 0)
				local var_204_3 = arg_201_1.bgs_.F10g

				var_204_3.transform.localPosition = var_204_2
				var_204_3.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_204_4 = var_204_3:GetComponent("SpriteRenderer")

				if var_204_4 and var_204_4.sprite then
					local var_204_5 = (var_204_3.transform.localPosition - var_204_1).z
					local var_204_6 = manager.ui.mainCameraCom_
					local var_204_7 = 2 * var_204_5 * Mathf.Tan(var_204_6.fieldOfView * 0.5 * Mathf.Deg2Rad)
					local var_204_8 = var_204_7 * var_204_6.aspect
					local var_204_9 = var_204_4.sprite.bounds.size.x
					local var_204_10 = var_204_4.sprite.bounds.size.y
					local var_204_11 = var_204_8 / var_204_9
					local var_204_12 = var_204_7 / var_204_10
					local var_204_13 = var_204_12 < var_204_11 and var_204_11 or var_204_12

					var_204_3.transform.localScale = Vector3.New(var_204_13, var_204_13, 0)
				end

				for iter_204_0, iter_204_1 in pairs(arg_201_1.bgs_) do
					if iter_204_0 ~= "F10g" then
						iter_204_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_204_14 = 0

			if var_204_14 < arg_201_1.time_ and arg_201_1.time_ <= var_204_14 + arg_204_0 then
				arg_201_1.allBtn_.enabled = false
			end

			local var_204_15 = 0.3

			if arg_201_1.time_ >= var_204_14 + var_204_15 and arg_201_1.time_ < var_204_14 + var_204_15 + arg_204_0 then
				arg_201_1.allBtn_.enabled = true
			end

			local var_204_16 = 0

			if var_204_16 < arg_201_1.time_ and arg_201_1.time_ <= var_204_16 + arg_204_0 then
				arg_201_1.mask_.enabled = true
				arg_201_1.mask_.raycastTarget = true

				arg_201_1:SetGaussion(false)
			end

			local var_204_17 = 0.833333333333333

			if var_204_16 <= arg_201_1.time_ and arg_201_1.time_ < var_204_16 + var_204_17 then
				local var_204_18 = (arg_201_1.time_ - var_204_16) / var_204_17
				local var_204_19 = Color.New(1, 1, 1)

				var_204_19.a = Mathf.Lerp(0, 1, var_204_18)
				arg_201_1.mask_.color = var_204_19
			end

			if arg_201_1.time_ >= var_204_16 + var_204_17 and arg_201_1.time_ < var_204_16 + var_204_17 + arg_204_0 then
				local var_204_20 = Color.New(1, 1, 1)

				var_204_20.a = 1
				arg_201_1.mask_.color = var_204_20
			end

			local var_204_21 = 0.833333333333333

			if var_204_21 < arg_201_1.time_ and arg_201_1.time_ <= var_204_21 + arg_204_0 then
				arg_201_1.mask_.enabled = true
				arg_201_1.mask_.raycastTarget = true

				arg_201_1:SetGaussion(false)
			end

			local var_204_22 = 1.5

			if var_204_21 <= arg_201_1.time_ and arg_201_1.time_ < var_204_21 + var_204_22 then
				local var_204_23 = (arg_201_1.time_ - var_204_21) / var_204_22
				local var_204_24 = Color.New(1, 1, 1)

				var_204_24.a = Mathf.Lerp(1, 0, var_204_23)
				arg_201_1.mask_.color = var_204_24
			end

			if arg_201_1.time_ >= var_204_21 + var_204_22 and arg_201_1.time_ < var_204_21 + var_204_22 + arg_204_0 then
				local var_204_25 = Color.New(1, 1, 1)
				local var_204_26 = 0

				arg_201_1.mask_.enabled = false
				var_204_25.a = var_204_26
				arg_201_1.mask_.color = var_204_25
			end

			local var_204_27 = arg_201_1.actors_["10094"].transform
			local var_204_28 = 0.833333333333333

			if var_204_28 < arg_201_1.time_ and arg_201_1.time_ <= var_204_28 + arg_204_0 then
				arg_201_1.var_.moveOldPos10094 = var_204_27.localPosition
				var_204_27.localScale = Vector3.New(1, 1, 1)

				arg_201_1:CheckSpriteTmpPos("10094", 6)

				local var_204_29 = var_204_27.childCount

				for iter_204_2 = 0, var_204_29 - 1 do
					local var_204_30 = var_204_27:GetChild(iter_204_2)

					if var_204_30.name == "" or not string.find(var_204_30.name, "split") then
						var_204_30.gameObject:SetActive(true)
					else
						var_204_30.gameObject:SetActive(false)
					end
				end
			end

			local var_204_31 = 0.001

			if var_204_28 <= arg_201_1.time_ and arg_201_1.time_ < var_204_28 + var_204_31 then
				local var_204_32 = (arg_201_1.time_ - var_204_28) / var_204_31
				local var_204_33 = Vector3.New(1500, -340, -414)

				var_204_27.localPosition = Vector3.Lerp(arg_201_1.var_.moveOldPos10094, var_204_33, var_204_32)
			end

			if arg_201_1.time_ >= var_204_28 + var_204_31 and arg_201_1.time_ < var_204_28 + var_204_31 + arg_204_0 then
				var_204_27.localPosition = Vector3.New(1500, -340, -414)
			end

			if arg_201_1.frameCnt_ <= 1 then
				arg_201_1.dialog_:SetActive(false)
			end

			local var_204_34 = 2.33333333333333
			local var_204_35 = 1.1

			if var_204_34 < arg_201_1.time_ and arg_201_1.time_ <= var_204_34 + arg_204_0 then
				arg_201_1.talkMaxDuration = 0

				arg_201_1.dialog_:SetActive(true)

				arg_201_1.dialogCg_.alpha = 0

				local var_204_36 = LeanTween.value(arg_201_1.dialog_, 0, 1, 0.3)

				var_204_36:setOnUpdate(LuaHelper.FloatAction(function(arg_205_0)
					arg_201_1.dialogCg_.alpha = arg_205_0
				end))
				var_204_36:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_201_1.dialog_)
					var_204_36:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_201_1.duration_ = arg_201_1.duration_ + 0.3

				SetActive(arg_201_1.leftNameGo_, false)

				arg_201_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_201_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_201_1:RecordName(arg_201_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_201_1.iconTrs_.gameObject, false)
				arg_201_1.callingController_:SetSelectedState("normal")

				local var_204_37 = arg_201_1:GetWordFromCfg(413131048)
				local var_204_38 = arg_201_1:FormatText(var_204_37.content)

				arg_201_1.text_.text = var_204_38

				LuaForUtil.ClearLinePrefixSymbol(arg_201_1.text_)

				local var_204_39 = 44
				local var_204_40 = utf8.len(var_204_38)
				local var_204_41 = var_204_39 <= 0 and var_204_35 or var_204_35 * (var_204_40 / var_204_39)

				if var_204_41 > 0 and var_204_35 < var_204_41 then
					arg_201_1.talkMaxDuration = var_204_41
					var_204_34 = var_204_34 + 0.3

					if var_204_41 + var_204_34 > arg_201_1.duration_ then
						arg_201_1.duration_ = var_204_41 + var_204_34
					end
				end

				arg_201_1.text_.text = var_204_38
				arg_201_1.typewritter.percent = 0

				arg_201_1.typewritter:SetDirty()
				arg_201_1:ShowNextGo(false)
				arg_201_1:RecordContent(arg_201_1.text_.text)
			end

			local var_204_42 = var_204_34 + 0.3
			local var_204_43 = math.max(var_204_35, arg_201_1.talkMaxDuration)

			if var_204_42 <= arg_201_1.time_ and arg_201_1.time_ < var_204_42 + var_204_43 then
				arg_201_1.typewritter.percent = (arg_201_1.time_ - var_204_42) / var_204_43

				arg_201_1.typewritter:SetDirty()
			end

			if arg_201_1.time_ >= var_204_42 + var_204_43 and arg_201_1.time_ < var_204_42 + var_204_43 + arg_204_0 then
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
				startTime = 0.833333333333333,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_201_1:InitPlayNodeList()
	end,
	Play413131049 = function(arg_207_0, arg_207_1)
		arg_207_1.time_ = 0
		arg_207_1.frameCnt_ = 0
		arg_207_1.state_ = "playing"
		arg_207_1.curTalkId_ = 413131049
		arg_207_1.duration_ = 5

		SetActive(arg_207_1.tipsGo_, false)

		function arg_207_1.onSingleLineFinish_()
			arg_207_1.onSingleLineUpdate_ = nil
			arg_207_1.onSingleLineFinish_ = nil
			arg_207_1.state_ = "waiting"
		end

		function arg_207_1.playNext_(arg_209_0)
			if arg_209_0 == 1 then
				arg_207_0:Play413131050(arg_207_1)
			end
		end

		function arg_207_1.onSingleLineUpdate_(arg_210_0)
			local var_210_0 = 0
			local var_210_1 = 1

			if var_210_0 < arg_207_1.time_ and arg_207_1.time_ <= var_210_0 + arg_210_0 then
				arg_207_1.talkMaxDuration = 0
				arg_207_1.dialogCg_.alpha = 1

				arg_207_1.dialog_:SetActive(true)
				SetActive(arg_207_1.leftNameGo_, false)

				arg_207_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_207_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_207_1:RecordName(arg_207_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_207_1.iconTrs_.gameObject, false)
				arg_207_1.callingController_:SetSelectedState("normal")

				local var_210_2 = arg_207_1:GetWordFromCfg(413131049)
				local var_210_3 = arg_207_1:FormatText(var_210_2.content)

				arg_207_1.text_.text = var_210_3

				LuaForUtil.ClearLinePrefixSymbol(arg_207_1.text_)

				local var_210_4 = 40
				local var_210_5 = utf8.len(var_210_3)
				local var_210_6 = var_210_4 <= 0 and var_210_1 or var_210_1 * (var_210_5 / var_210_4)

				if var_210_6 > 0 and var_210_1 < var_210_6 then
					arg_207_1.talkMaxDuration = var_210_6

					if var_210_6 + var_210_0 > arg_207_1.duration_ then
						arg_207_1.duration_ = var_210_6 + var_210_0
					end
				end

				arg_207_1.text_.text = var_210_3
				arg_207_1.typewritter.percent = 0

				arg_207_1.typewritter:SetDirty()
				arg_207_1:ShowNextGo(false)
				arg_207_1:RecordContent(arg_207_1.text_.text)
			end

			local var_210_7 = math.max(var_210_1, arg_207_1.talkMaxDuration)

			if var_210_0 <= arg_207_1.time_ and arg_207_1.time_ < var_210_0 + var_210_7 then
				arg_207_1.typewritter.percent = (arg_207_1.time_ - var_210_0) / var_210_7

				arg_207_1.typewritter:SetDirty()
			end

			if arg_207_1.time_ >= var_210_0 + var_210_7 and arg_207_1.time_ < var_210_0 + var_210_7 + arg_210_0 then
				arg_207_1.typewritter.percent = 1

				arg_207_1.typewritter:SetDirty()
				arg_207_1:ShowNextGo(true)
			end
		end

		arg_207_1.nodeConfigList_ = {}

		arg_207_1:InitPlayNodeList()
	end,
	Play413131050 = function(arg_211_0, arg_211_1)
		arg_211_1.time_ = 0
		arg_211_1.frameCnt_ = 0
		arg_211_1.state_ = "playing"
		arg_211_1.curTalkId_ = 413131050
		arg_211_1.duration_ = 4

		local var_211_0 = {
			zh = 3.633,
			ja = 4
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
				arg_211_0:Play413131051(arg_211_1)
			end
		end

		function arg_211_1.onSingleLineUpdate_(arg_214_0)
			local var_214_0 = arg_211_1.actors_["10022"].transform
			local var_214_1 = 0

			if var_214_1 < arg_211_1.time_ and arg_211_1.time_ <= var_214_1 + arg_214_0 then
				arg_211_1.var_.moveOldPos10022 = var_214_0.localPosition
				var_214_0.localScale = Vector3.New(1, 1, 1)

				arg_211_1:CheckSpriteTmpPos("10022", 3)

				local var_214_2 = var_214_0.childCount

				for iter_214_0 = 0, var_214_2 - 1 do
					local var_214_3 = var_214_0:GetChild(iter_214_0)

					if var_214_3.name == "split_6" or not string.find(var_214_3.name, "split") then
						var_214_3.gameObject:SetActive(true)
					else
						var_214_3.gameObject:SetActive(false)
					end
				end
			end

			local var_214_4 = 0.001

			if var_214_1 <= arg_211_1.time_ and arg_211_1.time_ < var_214_1 + var_214_4 then
				local var_214_5 = (arg_211_1.time_ - var_214_1) / var_214_4
				local var_214_6 = Vector3.New(0, -315, -320)

				var_214_0.localPosition = Vector3.Lerp(arg_211_1.var_.moveOldPos10022, var_214_6, var_214_5)
			end

			if arg_211_1.time_ >= var_214_1 + var_214_4 and arg_211_1.time_ < var_214_1 + var_214_4 + arg_214_0 then
				var_214_0.localPosition = Vector3.New(0, -315, -320)
			end

			local var_214_7 = arg_211_1.actors_["10022"]
			local var_214_8 = 0

			if var_214_8 < arg_211_1.time_ and arg_211_1.time_ <= var_214_8 + arg_214_0 and not isNil(var_214_7) and arg_211_1.var_.actorSpriteComps10022 == nil then
				arg_211_1.var_.actorSpriteComps10022 = var_214_7:GetComponentsInChildren(typeof(Image), true)
			end

			local var_214_9 = 2

			if var_214_8 <= arg_211_1.time_ and arg_211_1.time_ < var_214_8 + var_214_9 and not isNil(var_214_7) then
				local var_214_10 = (arg_211_1.time_ - var_214_8) / var_214_9

				if arg_211_1.var_.actorSpriteComps10022 then
					for iter_214_1, iter_214_2 in pairs(arg_211_1.var_.actorSpriteComps10022:ToTable()) do
						if iter_214_2 then
							if arg_211_1.isInRecall_ then
								local var_214_11 = Mathf.Lerp(iter_214_2.color.r, arg_211_1.hightColor1.r, var_214_10)
								local var_214_12 = Mathf.Lerp(iter_214_2.color.g, arg_211_1.hightColor1.g, var_214_10)
								local var_214_13 = Mathf.Lerp(iter_214_2.color.b, arg_211_1.hightColor1.b, var_214_10)

								iter_214_2.color = Color.New(var_214_11, var_214_12, var_214_13)
							else
								local var_214_14 = Mathf.Lerp(iter_214_2.color.r, 1, var_214_10)

								iter_214_2.color = Color.New(var_214_14, var_214_14, var_214_14)
							end
						end
					end
				end
			end

			if arg_211_1.time_ >= var_214_8 + var_214_9 and arg_211_1.time_ < var_214_8 + var_214_9 + arg_214_0 and not isNil(var_214_7) and arg_211_1.var_.actorSpriteComps10022 then
				for iter_214_3, iter_214_4 in pairs(arg_211_1.var_.actorSpriteComps10022:ToTable()) do
					if iter_214_4 then
						if arg_211_1.isInRecall_ then
							iter_214_4.color = arg_211_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_214_4.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_211_1.var_.actorSpriteComps10022 = nil
			end

			local var_214_15 = 0
			local var_214_16 = 0.475

			if var_214_15 < arg_211_1.time_ and arg_211_1.time_ <= var_214_15 + arg_214_0 then
				arg_211_1.talkMaxDuration = 0
				arg_211_1.dialogCg_.alpha = 1

				arg_211_1.dialog_:SetActive(true)
				SetActive(arg_211_1.leftNameGo_, true)

				local var_214_17 = arg_211_1:FormatText(StoryNameCfg[614].name)

				arg_211_1.leftNameTxt_.text = var_214_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_211_1.leftNameTxt_.transform)

				arg_211_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_211_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_211_1:RecordName(arg_211_1.leftNameTxt_.text)
				SetActive(arg_211_1.iconTrs_.gameObject, false)
				arg_211_1.callingController_:SetSelectedState("normal")

				local var_214_18 = arg_211_1:GetWordFromCfg(413131050)
				local var_214_19 = arg_211_1:FormatText(var_214_18.content)

				arg_211_1.text_.text = var_214_19

				LuaForUtil.ClearLinePrefixSymbol(arg_211_1.text_)

				local var_214_20 = 19
				local var_214_21 = utf8.len(var_214_19)
				local var_214_22 = var_214_20 <= 0 and var_214_16 or var_214_16 * (var_214_21 / var_214_20)

				if var_214_22 > 0 and var_214_16 < var_214_22 then
					arg_211_1.talkMaxDuration = var_214_22

					if var_214_22 + var_214_15 > arg_211_1.duration_ then
						arg_211_1.duration_ = var_214_22 + var_214_15
					end
				end

				arg_211_1.text_.text = var_214_19
				arg_211_1.typewritter.percent = 0

				arg_211_1.typewritter:SetDirty()
				arg_211_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_413131", "413131050", "story_v_out_413131.awb") ~= 0 then
					local var_214_23 = manager.audio:GetVoiceLength("story_v_out_413131", "413131050", "story_v_out_413131.awb") / 1000

					if var_214_23 + var_214_15 > arg_211_1.duration_ then
						arg_211_1.duration_ = var_214_23 + var_214_15
					end

					if var_214_18.prefab_name ~= "" and arg_211_1.actors_[var_214_18.prefab_name] ~= nil then
						local var_214_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_211_1.actors_[var_214_18.prefab_name].transform, "story_v_out_413131", "413131050", "story_v_out_413131.awb")

						arg_211_1:RecordAudio("413131050", var_214_24)
						arg_211_1:RecordAudio("413131050", var_214_24)
					else
						arg_211_1:AudioAction("play", "voice", "story_v_out_413131", "413131050", "story_v_out_413131.awb")
					end

					arg_211_1:RecordHistoryTalkVoice("story_v_out_413131", "413131050", "story_v_out_413131.awb")
				end

				arg_211_1:RecordContent(arg_211_1.text_.text)
			end

			local var_214_25 = math.max(var_214_16, arg_211_1.talkMaxDuration)

			if var_214_15 <= arg_211_1.time_ and arg_211_1.time_ < var_214_15 + var_214_25 then
				arg_211_1.typewritter.percent = (arg_211_1.time_ - var_214_15) / var_214_25

				arg_211_1.typewritter:SetDirty()
			end

			if arg_211_1.time_ >= var_214_15 + var_214_25 and arg_211_1.time_ < var_214_15 + var_214_25 + arg_214_0 then
				arg_211_1.typewritter.percent = 1

				arg_211_1.typewritter:SetDirty()
				arg_211_1:ShowNextGo(true)
			end
		end

		arg_211_1.nodeConfigList_ = {
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

		arg_211_1:InitPlayNodeList()
	end,
	Play413131051 = function(arg_215_0, arg_215_1)
		arg_215_1.time_ = 0
		arg_215_1.frameCnt_ = 0
		arg_215_1.state_ = "playing"
		arg_215_1.curTalkId_ = 413131051
		arg_215_1.duration_ = 5

		SetActive(arg_215_1.tipsGo_, false)

		function arg_215_1.onSingleLineFinish_()
			arg_215_1.onSingleLineUpdate_ = nil
			arg_215_1.onSingleLineFinish_ = nil
			arg_215_1.state_ = "waiting"
		end

		function arg_215_1.playNext_(arg_217_0)
			if arg_217_0 == 1 then
				arg_215_0:Play413131052(arg_215_1)
			end
		end

		function arg_215_1.onSingleLineUpdate_(arg_218_0)
			local var_218_0 = arg_215_1.actors_["10022"].transform
			local var_218_1 = 0

			if var_218_1 < arg_215_1.time_ and arg_215_1.time_ <= var_218_1 + arg_218_0 then
				arg_215_1.var_.moveOldPos10022 = var_218_0.localPosition
				var_218_0.localScale = Vector3.New(1, 1, 1)

				arg_215_1:CheckSpriteTmpPos("10022", 7)

				local var_218_2 = var_218_0.childCount

				for iter_218_0 = 0, var_218_2 - 1 do
					local var_218_3 = var_218_0:GetChild(iter_218_0)

					if var_218_3.name == "" or not string.find(var_218_3.name, "split") then
						var_218_3.gameObject:SetActive(true)
					else
						var_218_3.gameObject:SetActive(false)
					end
				end
			end

			local var_218_4 = 0.001

			if var_218_1 <= arg_215_1.time_ and arg_215_1.time_ < var_218_1 + var_218_4 then
				local var_218_5 = (arg_215_1.time_ - var_218_1) / var_218_4
				local var_218_6 = Vector3.New(0, -2000, 0)

				var_218_0.localPosition = Vector3.Lerp(arg_215_1.var_.moveOldPos10022, var_218_6, var_218_5)
			end

			if arg_215_1.time_ >= var_218_1 + var_218_4 and arg_215_1.time_ < var_218_1 + var_218_4 + arg_218_0 then
				var_218_0.localPosition = Vector3.New(0, -2000, 0)
			end

			local var_218_7 = 0
			local var_218_8 = 1

			if var_218_7 < arg_215_1.time_ and arg_215_1.time_ <= var_218_7 + arg_218_0 then
				local var_218_9 = "play"
				local var_218_10 = "effect"

				arg_215_1:AudioAction(var_218_9, var_218_10, "se_story_8", "se_story_8_water03", "")
			end

			local var_218_11 = 0
			local var_218_12 = 1.45

			if var_218_11 < arg_215_1.time_ and arg_215_1.time_ <= var_218_11 + arg_218_0 then
				arg_215_1.talkMaxDuration = 0
				arg_215_1.dialogCg_.alpha = 1

				arg_215_1.dialog_:SetActive(true)
				SetActive(arg_215_1.leftNameGo_, false)

				arg_215_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_215_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_215_1:RecordName(arg_215_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_215_1.iconTrs_.gameObject, false)
				arg_215_1.callingController_:SetSelectedState("normal")

				local var_218_13 = arg_215_1:GetWordFromCfg(413131051)
				local var_218_14 = arg_215_1:FormatText(var_218_13.content)

				arg_215_1.text_.text = var_218_14

				LuaForUtil.ClearLinePrefixSymbol(arg_215_1.text_)

				local var_218_15 = 58
				local var_218_16 = utf8.len(var_218_14)
				local var_218_17 = var_218_15 <= 0 and var_218_12 or var_218_12 * (var_218_16 / var_218_15)

				if var_218_17 > 0 and var_218_12 < var_218_17 then
					arg_215_1.talkMaxDuration = var_218_17

					if var_218_17 + var_218_11 > arg_215_1.duration_ then
						arg_215_1.duration_ = var_218_17 + var_218_11
					end
				end

				arg_215_1.text_.text = var_218_14
				arg_215_1.typewritter.percent = 0

				arg_215_1.typewritter:SetDirty()
				arg_215_1:ShowNextGo(false)
				arg_215_1:RecordContent(arg_215_1.text_.text)
			end

			local var_218_18 = math.max(var_218_12, arg_215_1.talkMaxDuration)

			if var_218_11 <= arg_215_1.time_ and arg_215_1.time_ < var_218_11 + var_218_18 then
				arg_215_1.typewritter.percent = (arg_215_1.time_ - var_218_11) / var_218_18

				arg_215_1.typewritter:SetDirty()
			end

			if arg_215_1.time_ >= var_218_11 + var_218_18 and arg_215_1.time_ < var_218_11 + var_218_18 + arg_218_0 then
				arg_215_1.typewritter.percent = 1

				arg_215_1.typewritter:SetDirty()
				arg_215_1:ShowNextGo(true)
			end
		end

		arg_215_1.nodeConfigList_ = {
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

		arg_215_1:InitPlayNodeList()
	end,
	Play413131052 = function(arg_219_0, arg_219_1)
		arg_219_1.time_ = 0
		arg_219_1.frameCnt_ = 0
		arg_219_1.state_ = "playing"
		arg_219_1.curTalkId_ = 413131052
		arg_219_1.duration_ = 4.7

		local var_219_0 = {
			zh = 4.7,
			ja = 3.633
		}
		local var_219_1 = manager.audio:GetLocalizationFlag()

		if var_219_0[var_219_1] ~= nil then
			arg_219_1.duration_ = var_219_0[var_219_1]
		end

		SetActive(arg_219_1.tipsGo_, false)

		function arg_219_1.onSingleLineFinish_()
			arg_219_1.onSingleLineUpdate_ = nil
			arg_219_1.onSingleLineFinish_ = nil
			arg_219_1.state_ = "waiting"
		end

		function arg_219_1.playNext_(arg_221_0)
			if arg_221_0 == 1 then
				arg_219_0:Play413131053(arg_219_1)
			end
		end

		function arg_219_1.onSingleLineUpdate_(arg_222_0)
			local var_222_0 = 0
			local var_222_1 = 0.65

			if var_222_0 < arg_219_1.time_ and arg_219_1.time_ <= var_222_0 + arg_222_0 then
				arg_219_1.talkMaxDuration = 0
				arg_219_1.dialogCg_.alpha = 1

				arg_219_1.dialog_:SetActive(true)
				SetActive(arg_219_1.leftNameGo_, true)

				local var_222_2 = arg_219_1:FormatText(StoryNameCfg[998].name)

				arg_219_1.leftNameTxt_.text = var_222_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_219_1.leftNameTxt_.transform)

				arg_219_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_219_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_219_1:RecordName(arg_219_1.leftNameTxt_.text)
				SetActive(arg_219_1.iconTrs_.gameObject, true)
				arg_219_1.iconController_:SetSelectedState("hero")

				arg_219_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_knightwoman1")

				arg_219_1.callingController_:SetSelectedState("normal")

				arg_219_1.keyicon_.color = Color.New(1, 1, 1)
				arg_219_1.icon_.color = Color.New(1, 1, 1)

				local var_222_3 = arg_219_1:GetWordFromCfg(413131052)
				local var_222_4 = arg_219_1:FormatText(var_222_3.content)

				arg_219_1.text_.text = var_222_4

				LuaForUtil.ClearLinePrefixSymbol(arg_219_1.text_)

				local var_222_5 = 26
				local var_222_6 = utf8.len(var_222_4)
				local var_222_7 = var_222_5 <= 0 and var_222_1 or var_222_1 * (var_222_6 / var_222_5)

				if var_222_7 > 0 and var_222_1 < var_222_7 then
					arg_219_1.talkMaxDuration = var_222_7

					if var_222_7 + var_222_0 > arg_219_1.duration_ then
						arg_219_1.duration_ = var_222_7 + var_222_0
					end
				end

				arg_219_1.text_.text = var_222_4
				arg_219_1.typewritter.percent = 0

				arg_219_1.typewritter:SetDirty()
				arg_219_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_413131", "413131052", "story_v_out_413131.awb") ~= 0 then
					local var_222_8 = manager.audio:GetVoiceLength("story_v_out_413131", "413131052", "story_v_out_413131.awb") / 1000

					if var_222_8 + var_222_0 > arg_219_1.duration_ then
						arg_219_1.duration_ = var_222_8 + var_222_0
					end

					if var_222_3.prefab_name ~= "" and arg_219_1.actors_[var_222_3.prefab_name] ~= nil then
						local var_222_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_219_1.actors_[var_222_3.prefab_name].transform, "story_v_out_413131", "413131052", "story_v_out_413131.awb")

						arg_219_1:RecordAudio("413131052", var_222_9)
						arg_219_1:RecordAudio("413131052", var_222_9)
					else
						arg_219_1:AudioAction("play", "voice", "story_v_out_413131", "413131052", "story_v_out_413131.awb")
					end

					arg_219_1:RecordHistoryTalkVoice("story_v_out_413131", "413131052", "story_v_out_413131.awb")
				end

				arg_219_1:RecordContent(arg_219_1.text_.text)
			end

			local var_222_10 = math.max(var_222_1, arg_219_1.talkMaxDuration)

			if var_222_0 <= arg_219_1.time_ and arg_219_1.time_ < var_222_0 + var_222_10 then
				arg_219_1.typewritter.percent = (arg_219_1.time_ - var_222_0) / var_222_10

				arg_219_1.typewritter:SetDirty()
			end

			if arg_219_1.time_ >= var_222_0 + var_222_10 and arg_219_1.time_ < var_222_0 + var_222_10 + arg_222_0 then
				arg_219_1.typewritter.percent = 1

				arg_219_1.typewritter:SetDirty()
				arg_219_1:ShowNextGo(true)
			end
		end

		arg_219_1.nodeConfigList_ = {}

		arg_219_1:InitPlayNodeList()
	end,
	Play413131053 = function(arg_223_0, arg_223_1)
		arg_223_1.time_ = 0
		arg_223_1.frameCnt_ = 0
		arg_223_1.state_ = "playing"
		arg_223_1.curTalkId_ = 413131053
		arg_223_1.duration_ = 5.57

		local var_223_0 = {
			zh = 4.4,
			ja = 5.566
		}
		local var_223_1 = manager.audio:GetLocalizationFlag()

		if var_223_0[var_223_1] ~= nil then
			arg_223_1.duration_ = var_223_0[var_223_1]
		end

		SetActive(arg_223_1.tipsGo_, false)

		function arg_223_1.onSingleLineFinish_()
			arg_223_1.onSingleLineUpdate_ = nil
			arg_223_1.onSingleLineFinish_ = nil
			arg_223_1.state_ = "waiting"
		end

		function arg_223_1.playNext_(arg_225_0)
			if arg_225_0 == 1 then
				arg_223_0:Play413131054(arg_223_1)
			end
		end

		function arg_223_1.onSingleLineUpdate_(arg_226_0)
			local var_226_0 = arg_223_1.actors_["10022"].transform
			local var_226_1 = 0

			if var_226_1 < arg_223_1.time_ and arg_223_1.time_ <= var_226_1 + arg_226_0 then
				arg_223_1.var_.moveOldPos10022 = var_226_0.localPosition
				var_226_0.localScale = Vector3.New(1, 1, 1)

				arg_223_1:CheckSpriteTmpPos("10022", 3)

				local var_226_2 = var_226_0.childCount

				for iter_226_0 = 0, var_226_2 - 1 do
					local var_226_3 = var_226_0:GetChild(iter_226_0)

					if var_226_3.name == "split_2" or not string.find(var_226_3.name, "split") then
						var_226_3.gameObject:SetActive(true)
					else
						var_226_3.gameObject:SetActive(false)
					end
				end
			end

			local var_226_4 = 0.001

			if var_226_1 <= arg_223_1.time_ and arg_223_1.time_ < var_226_1 + var_226_4 then
				local var_226_5 = (arg_223_1.time_ - var_226_1) / var_226_4
				local var_226_6 = Vector3.New(0, -315, -320)

				var_226_0.localPosition = Vector3.Lerp(arg_223_1.var_.moveOldPos10022, var_226_6, var_226_5)
			end

			if arg_223_1.time_ >= var_226_1 + var_226_4 and arg_223_1.time_ < var_226_1 + var_226_4 + arg_226_0 then
				var_226_0.localPosition = Vector3.New(0, -315, -320)
			end

			local var_226_7 = arg_223_1.actors_["10022"]
			local var_226_8 = 0

			if var_226_8 < arg_223_1.time_ and arg_223_1.time_ <= var_226_8 + arg_226_0 and not isNil(var_226_7) and arg_223_1.var_.actorSpriteComps10022 == nil then
				arg_223_1.var_.actorSpriteComps10022 = var_226_7:GetComponentsInChildren(typeof(Image), true)
			end

			local var_226_9 = 2

			if var_226_8 <= arg_223_1.time_ and arg_223_1.time_ < var_226_8 + var_226_9 and not isNil(var_226_7) then
				local var_226_10 = (arg_223_1.time_ - var_226_8) / var_226_9

				if arg_223_1.var_.actorSpriteComps10022 then
					for iter_226_1, iter_226_2 in pairs(arg_223_1.var_.actorSpriteComps10022:ToTable()) do
						if iter_226_2 then
							if arg_223_1.isInRecall_ then
								local var_226_11 = Mathf.Lerp(iter_226_2.color.r, arg_223_1.hightColor1.r, var_226_10)
								local var_226_12 = Mathf.Lerp(iter_226_2.color.g, arg_223_1.hightColor1.g, var_226_10)
								local var_226_13 = Mathf.Lerp(iter_226_2.color.b, arg_223_1.hightColor1.b, var_226_10)

								iter_226_2.color = Color.New(var_226_11, var_226_12, var_226_13)
							else
								local var_226_14 = Mathf.Lerp(iter_226_2.color.r, 1, var_226_10)

								iter_226_2.color = Color.New(var_226_14, var_226_14, var_226_14)
							end
						end
					end
				end
			end

			if arg_223_1.time_ >= var_226_8 + var_226_9 and arg_223_1.time_ < var_226_8 + var_226_9 + arg_226_0 and not isNil(var_226_7) and arg_223_1.var_.actorSpriteComps10022 then
				for iter_226_3, iter_226_4 in pairs(arg_223_1.var_.actorSpriteComps10022:ToTable()) do
					if iter_226_4 then
						if arg_223_1.isInRecall_ then
							iter_226_4.color = arg_223_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_226_4.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_223_1.var_.actorSpriteComps10022 = nil
			end

			local var_226_15 = 0
			local var_226_16 = 0.5

			if var_226_15 < arg_223_1.time_ and arg_223_1.time_ <= var_226_15 + arg_226_0 then
				arg_223_1.talkMaxDuration = 0
				arg_223_1.dialogCg_.alpha = 1

				arg_223_1.dialog_:SetActive(true)
				SetActive(arg_223_1.leftNameGo_, true)

				local var_226_17 = arg_223_1:FormatText(StoryNameCfg[614].name)

				arg_223_1.leftNameTxt_.text = var_226_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_223_1.leftNameTxt_.transform)

				arg_223_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_223_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_223_1:RecordName(arg_223_1.leftNameTxt_.text)
				SetActive(arg_223_1.iconTrs_.gameObject, false)
				arg_223_1.callingController_:SetSelectedState("normal")

				local var_226_18 = arg_223_1:GetWordFromCfg(413131053)
				local var_226_19 = arg_223_1:FormatText(var_226_18.content)

				arg_223_1.text_.text = var_226_19

				LuaForUtil.ClearLinePrefixSymbol(arg_223_1.text_)

				local var_226_20 = 20
				local var_226_21 = utf8.len(var_226_19)
				local var_226_22 = var_226_20 <= 0 and var_226_16 or var_226_16 * (var_226_21 / var_226_20)

				if var_226_22 > 0 and var_226_16 < var_226_22 then
					arg_223_1.talkMaxDuration = var_226_22

					if var_226_22 + var_226_15 > arg_223_1.duration_ then
						arg_223_1.duration_ = var_226_22 + var_226_15
					end
				end

				arg_223_1.text_.text = var_226_19
				arg_223_1.typewritter.percent = 0

				arg_223_1.typewritter:SetDirty()
				arg_223_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_413131", "413131053", "story_v_out_413131.awb") ~= 0 then
					local var_226_23 = manager.audio:GetVoiceLength("story_v_out_413131", "413131053", "story_v_out_413131.awb") / 1000

					if var_226_23 + var_226_15 > arg_223_1.duration_ then
						arg_223_1.duration_ = var_226_23 + var_226_15
					end

					if var_226_18.prefab_name ~= "" and arg_223_1.actors_[var_226_18.prefab_name] ~= nil then
						local var_226_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_223_1.actors_[var_226_18.prefab_name].transform, "story_v_out_413131", "413131053", "story_v_out_413131.awb")

						arg_223_1:RecordAudio("413131053", var_226_24)
						arg_223_1:RecordAudio("413131053", var_226_24)
					else
						arg_223_1:AudioAction("play", "voice", "story_v_out_413131", "413131053", "story_v_out_413131.awb")
					end

					arg_223_1:RecordHistoryTalkVoice("story_v_out_413131", "413131053", "story_v_out_413131.awb")
				end

				arg_223_1:RecordContent(arg_223_1.text_.text)
			end

			local var_226_25 = math.max(var_226_16, arg_223_1.talkMaxDuration)

			if var_226_15 <= arg_223_1.time_ and arg_223_1.time_ < var_226_15 + var_226_25 then
				arg_223_1.typewritter.percent = (arg_223_1.time_ - var_226_15) / var_226_25

				arg_223_1.typewritter:SetDirty()
			end

			if arg_223_1.time_ >= var_226_15 + var_226_25 and arg_223_1.time_ < var_226_15 + var_226_25 + arg_226_0 then
				arg_223_1.typewritter.percent = 1

				arg_223_1.typewritter:SetDirty()
				arg_223_1:ShowNextGo(true)
			end
		end

		arg_223_1.nodeConfigList_ = {
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

		arg_223_1:InitPlayNodeList()
	end,
	Play413131054 = function(arg_227_0, arg_227_1)
		arg_227_1.time_ = 0
		arg_227_1.frameCnt_ = 0
		arg_227_1.state_ = "playing"
		arg_227_1.curTalkId_ = 413131054
		arg_227_1.duration_ = 2

		SetActive(arg_227_1.tipsGo_, false)

		function arg_227_1.onSingleLineFinish_()
			arg_227_1.onSingleLineUpdate_ = nil
			arg_227_1.onSingleLineFinish_ = nil
			arg_227_1.state_ = "waiting"
		end

		function arg_227_1.playNext_(arg_229_0)
			if arg_229_0 == 1 then
				arg_227_0:Play413131055(arg_227_1)
			end
		end

		function arg_227_1.onSingleLineUpdate_(arg_230_0)
			local var_230_0 = arg_227_1.actors_["10022"].transform
			local var_230_1 = 0

			if var_230_1 < arg_227_1.time_ and arg_227_1.time_ <= var_230_1 + arg_230_0 then
				arg_227_1.var_.moveOldPos10022 = var_230_0.localPosition
				var_230_0.localScale = Vector3.New(1, 1, 1)

				arg_227_1:CheckSpriteTmpPos("10022", 7)

				local var_230_2 = var_230_0.childCount

				for iter_230_0 = 0, var_230_2 - 1 do
					local var_230_3 = var_230_0:GetChild(iter_230_0)

					if var_230_3.name == "" or not string.find(var_230_3.name, "split") then
						var_230_3.gameObject:SetActive(true)
					else
						var_230_3.gameObject:SetActive(false)
					end
				end
			end

			local var_230_4 = 0.001

			if var_230_1 <= arg_227_1.time_ and arg_227_1.time_ < var_230_1 + var_230_4 then
				local var_230_5 = (arg_227_1.time_ - var_230_1) / var_230_4
				local var_230_6 = Vector3.New(0, -2000, 0)

				var_230_0.localPosition = Vector3.Lerp(arg_227_1.var_.moveOldPos10022, var_230_6, var_230_5)
			end

			if arg_227_1.time_ >= var_230_1 + var_230_4 and arg_227_1.time_ < var_230_1 + var_230_4 + arg_230_0 then
				var_230_0.localPosition = Vector3.New(0, -2000, 0)
			end

			local var_230_7 = arg_227_1.actors_["10022"]
			local var_230_8 = 0

			if var_230_8 < arg_227_1.time_ and arg_227_1.time_ <= var_230_8 + arg_230_0 and not isNil(var_230_7) and arg_227_1.var_.actorSpriteComps10022 == nil then
				arg_227_1.var_.actorSpriteComps10022 = var_230_7:GetComponentsInChildren(typeof(Image), true)
			end

			local var_230_9 = 2

			if var_230_8 <= arg_227_1.time_ and arg_227_1.time_ < var_230_8 + var_230_9 and not isNil(var_230_7) then
				local var_230_10 = (arg_227_1.time_ - var_230_8) / var_230_9

				if arg_227_1.var_.actorSpriteComps10022 then
					for iter_230_1, iter_230_2 in pairs(arg_227_1.var_.actorSpriteComps10022:ToTable()) do
						if iter_230_2 then
							if arg_227_1.isInRecall_ then
								local var_230_11 = Mathf.Lerp(iter_230_2.color.r, arg_227_1.hightColor2.r, var_230_10)
								local var_230_12 = Mathf.Lerp(iter_230_2.color.g, arg_227_1.hightColor2.g, var_230_10)
								local var_230_13 = Mathf.Lerp(iter_230_2.color.b, arg_227_1.hightColor2.b, var_230_10)

								iter_230_2.color = Color.New(var_230_11, var_230_12, var_230_13)
							else
								local var_230_14 = Mathf.Lerp(iter_230_2.color.r, 0.5, var_230_10)

								iter_230_2.color = Color.New(var_230_14, var_230_14, var_230_14)
							end
						end
					end
				end
			end

			if arg_227_1.time_ >= var_230_8 + var_230_9 and arg_227_1.time_ < var_230_8 + var_230_9 + arg_230_0 and not isNil(var_230_7) and arg_227_1.var_.actorSpriteComps10022 then
				for iter_230_3, iter_230_4 in pairs(arg_227_1.var_.actorSpriteComps10022:ToTable()) do
					if iter_230_4 then
						if arg_227_1.isInRecall_ then
							iter_230_4.color = arg_227_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_230_4.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_227_1.var_.actorSpriteComps10022 = nil
			end

			local var_230_15 = 0
			local var_230_16 = 0.05

			if var_230_15 < arg_227_1.time_ and arg_227_1.time_ <= var_230_15 + arg_230_0 then
				arg_227_1.talkMaxDuration = 0
				arg_227_1.dialogCg_.alpha = 1

				arg_227_1.dialog_:SetActive(true)
				SetActive(arg_227_1.leftNameGo_, true)

				local var_230_17 = arg_227_1:FormatText(StoryNameCfg[998].name)

				arg_227_1.leftNameTxt_.text = var_230_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_227_1.leftNameTxt_.transform)

				arg_227_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_227_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_227_1:RecordName(arg_227_1.leftNameTxt_.text)
				SetActive(arg_227_1.iconTrs_.gameObject, true)
				arg_227_1.iconController_:SetSelectedState("hero")

				arg_227_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_knightwoman1")

				arg_227_1.callingController_:SetSelectedState("normal")

				arg_227_1.keyicon_.color = Color.New(1, 1, 1)
				arg_227_1.icon_.color = Color.New(1, 1, 1)

				local var_230_18 = arg_227_1:GetWordFromCfg(413131054)
				local var_230_19 = arg_227_1:FormatText(var_230_18.content)

				arg_227_1.text_.text = var_230_19

				LuaForUtil.ClearLinePrefixSymbol(arg_227_1.text_)

				local var_230_20 = 2
				local var_230_21 = utf8.len(var_230_19)
				local var_230_22 = var_230_20 <= 0 and var_230_16 or var_230_16 * (var_230_21 / var_230_20)

				if var_230_22 > 0 and var_230_16 < var_230_22 then
					arg_227_1.talkMaxDuration = var_230_22

					if var_230_22 + var_230_15 > arg_227_1.duration_ then
						arg_227_1.duration_ = var_230_22 + var_230_15
					end
				end

				arg_227_1.text_.text = var_230_19
				arg_227_1.typewritter.percent = 0

				arg_227_1.typewritter:SetDirty()
				arg_227_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_413131", "413131054", "story_v_out_413131.awb") ~= 0 then
					local var_230_23 = manager.audio:GetVoiceLength("story_v_out_413131", "413131054", "story_v_out_413131.awb") / 1000

					if var_230_23 + var_230_15 > arg_227_1.duration_ then
						arg_227_1.duration_ = var_230_23 + var_230_15
					end

					if var_230_18.prefab_name ~= "" and arg_227_1.actors_[var_230_18.prefab_name] ~= nil then
						local var_230_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_227_1.actors_[var_230_18.prefab_name].transform, "story_v_out_413131", "413131054", "story_v_out_413131.awb")

						arg_227_1:RecordAudio("413131054", var_230_24)
						arg_227_1:RecordAudio("413131054", var_230_24)
					else
						arg_227_1:AudioAction("play", "voice", "story_v_out_413131", "413131054", "story_v_out_413131.awb")
					end

					arg_227_1:RecordHistoryTalkVoice("story_v_out_413131", "413131054", "story_v_out_413131.awb")
				end

				arg_227_1:RecordContent(arg_227_1.text_.text)
			end

			local var_230_25 = math.max(var_230_16, arg_227_1.talkMaxDuration)

			if var_230_15 <= arg_227_1.time_ and arg_227_1.time_ < var_230_15 + var_230_25 then
				arg_227_1.typewritter.percent = (arg_227_1.time_ - var_230_15) / var_230_25

				arg_227_1.typewritter:SetDirty()
			end

			if arg_227_1.time_ >= var_230_15 + var_230_25 and arg_227_1.time_ < var_230_15 + var_230_25 + arg_230_0 then
				arg_227_1.typewritter.percent = 1

				arg_227_1.typewritter:SetDirty()
				arg_227_1:ShowNextGo(true)
			end
		end

		arg_227_1.nodeConfigList_ = {
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

		arg_227_1:InitPlayNodeList()
	end,
	Play413131055 = function(arg_231_0, arg_231_1)
		arg_231_1.time_ = 0
		arg_231_1.frameCnt_ = 0
		arg_231_1.state_ = "playing"
		arg_231_1.curTalkId_ = 413131055
		arg_231_1.duration_ = 5

		SetActive(arg_231_1.tipsGo_, false)

		function arg_231_1.onSingleLineFinish_()
			arg_231_1.onSingleLineUpdate_ = nil
			arg_231_1.onSingleLineFinish_ = nil
			arg_231_1.state_ = "waiting"
		end

		function arg_231_1.playNext_(arg_233_0)
			if arg_233_0 == 1 then
				arg_231_0:Play413131056(arg_231_1)
			end
		end

		function arg_231_1.onSingleLineUpdate_(arg_234_0)
			local var_234_0 = 0
			local var_234_1 = 1.425

			if var_234_0 < arg_231_1.time_ and arg_231_1.time_ <= var_234_0 + arg_234_0 then
				arg_231_1.talkMaxDuration = 0
				arg_231_1.dialogCg_.alpha = 1

				arg_231_1.dialog_:SetActive(true)
				SetActive(arg_231_1.leftNameGo_, false)

				arg_231_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_231_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_231_1:RecordName(arg_231_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_231_1.iconTrs_.gameObject, false)
				arg_231_1.callingController_:SetSelectedState("normal")

				local var_234_2 = arg_231_1:GetWordFromCfg(413131055)
				local var_234_3 = arg_231_1:FormatText(var_234_2.content)

				arg_231_1.text_.text = var_234_3

				LuaForUtil.ClearLinePrefixSymbol(arg_231_1.text_)

				local var_234_4 = 57
				local var_234_5 = utf8.len(var_234_3)
				local var_234_6 = var_234_4 <= 0 and var_234_1 or var_234_1 * (var_234_5 / var_234_4)

				if var_234_6 > 0 and var_234_1 < var_234_6 then
					arg_231_1.talkMaxDuration = var_234_6

					if var_234_6 + var_234_0 > arg_231_1.duration_ then
						arg_231_1.duration_ = var_234_6 + var_234_0
					end
				end

				arg_231_1.text_.text = var_234_3
				arg_231_1.typewritter.percent = 0

				arg_231_1.typewritter:SetDirty()
				arg_231_1:ShowNextGo(false)
				arg_231_1:RecordContent(arg_231_1.text_.text)
			end

			local var_234_7 = math.max(var_234_1, arg_231_1.talkMaxDuration)

			if var_234_0 <= arg_231_1.time_ and arg_231_1.time_ < var_234_0 + var_234_7 then
				arg_231_1.typewritter.percent = (arg_231_1.time_ - var_234_0) / var_234_7

				arg_231_1.typewritter:SetDirty()
			end

			if arg_231_1.time_ >= var_234_0 + var_234_7 and arg_231_1.time_ < var_234_0 + var_234_7 + arg_234_0 then
				arg_231_1.typewritter.percent = 1

				arg_231_1.typewritter:SetDirty()
				arg_231_1:ShowNextGo(true)
			end
		end

		arg_231_1.nodeConfigList_ = {}

		arg_231_1:InitPlayNodeList()
	end,
	Play413131056 = function(arg_235_0, arg_235_1)
		arg_235_1.time_ = 0
		arg_235_1.frameCnt_ = 0
		arg_235_1.state_ = "playing"
		arg_235_1.curTalkId_ = 413131056
		arg_235_1.duration_ = 1.03

		local var_235_0 = {
			zh = 1.033,
			ja = 0.999999999999
		}
		local var_235_1 = manager.audio:GetLocalizationFlag()

		if var_235_0[var_235_1] ~= nil then
			arg_235_1.duration_ = var_235_0[var_235_1]
		end

		SetActive(arg_235_1.tipsGo_, false)

		function arg_235_1.onSingleLineFinish_()
			arg_235_1.onSingleLineUpdate_ = nil
			arg_235_1.onSingleLineFinish_ = nil
			arg_235_1.state_ = "waiting"
		end

		function arg_235_1.playNext_(arg_237_0)
			if arg_237_0 == 1 then
				arg_235_0:Play413131057(arg_235_1)
			end
		end

		function arg_235_1.onSingleLineUpdate_(arg_238_0)
			local var_238_0 = 0
			local var_238_1 = 0.05

			if var_238_0 < arg_235_1.time_ and arg_235_1.time_ <= var_238_0 + arg_238_0 then
				arg_235_1.talkMaxDuration = 0
				arg_235_1.dialogCg_.alpha = 1

				arg_235_1.dialog_:SetActive(true)
				SetActive(arg_235_1.leftNameGo_, true)

				local var_238_2 = arg_235_1:FormatText(StoryNameCfg[998].name)

				arg_235_1.leftNameTxt_.text = var_238_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_235_1.leftNameTxt_.transform)

				arg_235_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_235_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_235_1:RecordName(arg_235_1.leftNameTxt_.text)
				SetActive(arg_235_1.iconTrs_.gameObject, true)
				arg_235_1.iconController_:SetSelectedState("hero")

				arg_235_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_knightwoman1")

				arg_235_1.callingController_:SetSelectedState("normal")

				arg_235_1.keyicon_.color = Color.New(1, 1, 1)
				arg_235_1.icon_.color = Color.New(1, 1, 1)

				local var_238_3 = arg_235_1:GetWordFromCfg(413131056)
				local var_238_4 = arg_235_1:FormatText(var_238_3.content)

				arg_235_1.text_.text = var_238_4

				LuaForUtil.ClearLinePrefixSymbol(arg_235_1.text_)

				local var_238_5 = 2
				local var_238_6 = utf8.len(var_238_4)
				local var_238_7 = var_238_5 <= 0 and var_238_1 or var_238_1 * (var_238_6 / var_238_5)

				if var_238_7 > 0 and var_238_1 < var_238_7 then
					arg_235_1.talkMaxDuration = var_238_7

					if var_238_7 + var_238_0 > arg_235_1.duration_ then
						arg_235_1.duration_ = var_238_7 + var_238_0
					end
				end

				arg_235_1.text_.text = var_238_4
				arg_235_1.typewritter.percent = 0

				arg_235_1.typewritter:SetDirty()
				arg_235_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_413131", "413131056", "story_v_out_413131.awb") ~= 0 then
					local var_238_8 = manager.audio:GetVoiceLength("story_v_out_413131", "413131056", "story_v_out_413131.awb") / 1000

					if var_238_8 + var_238_0 > arg_235_1.duration_ then
						arg_235_1.duration_ = var_238_8 + var_238_0
					end

					if var_238_3.prefab_name ~= "" and arg_235_1.actors_[var_238_3.prefab_name] ~= nil then
						local var_238_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_235_1.actors_[var_238_3.prefab_name].transform, "story_v_out_413131", "413131056", "story_v_out_413131.awb")

						arg_235_1:RecordAudio("413131056", var_238_9)
						arg_235_1:RecordAudio("413131056", var_238_9)
					else
						arg_235_1:AudioAction("play", "voice", "story_v_out_413131", "413131056", "story_v_out_413131.awb")
					end

					arg_235_1:RecordHistoryTalkVoice("story_v_out_413131", "413131056", "story_v_out_413131.awb")
				end

				arg_235_1:RecordContent(arg_235_1.text_.text)
			end

			local var_238_10 = math.max(var_238_1, arg_235_1.talkMaxDuration)

			if var_238_0 <= arg_235_1.time_ and arg_235_1.time_ < var_238_0 + var_238_10 then
				arg_235_1.typewritter.percent = (arg_235_1.time_ - var_238_0) / var_238_10

				arg_235_1.typewritter:SetDirty()
			end

			if arg_235_1.time_ >= var_238_0 + var_238_10 and arg_235_1.time_ < var_238_0 + var_238_10 + arg_238_0 then
				arg_235_1.typewritter.percent = 1

				arg_235_1.typewritter:SetDirty()
				arg_235_1:ShowNextGo(true)
			end
		end

		arg_235_1.nodeConfigList_ = {}

		arg_235_1:InitPlayNodeList()
	end,
	Play413131057 = function(arg_239_0, arg_239_1)
		arg_239_1.time_ = 0
		arg_239_1.frameCnt_ = 0
		arg_239_1.state_ = "playing"
		arg_239_1.curTalkId_ = 413131057
		arg_239_1.duration_ = 7.1

		SetActive(arg_239_1.tipsGo_, false)

		function arg_239_1.onSingleLineFinish_()
			arg_239_1.onSingleLineUpdate_ = nil
			arg_239_1.onSingleLineFinish_ = nil
			arg_239_1.state_ = "waiting"
		end

		function arg_239_1.playNext_(arg_241_0)
			if arg_241_0 == 1 then
				arg_239_0:Play413131058(arg_239_1)
			end
		end

		function arg_239_1.onSingleLineUpdate_(arg_242_0)
			local var_242_0 = arg_239_1.bgs_.F10g.transform
			local var_242_1 = 0

			if var_242_1 < arg_239_1.time_ and arg_239_1.time_ <= var_242_1 + arg_242_0 then
				arg_239_1.var_.moveOldPosF10g = var_242_0.localPosition
			end

			local var_242_2 = 0.001

			if var_242_1 <= arg_239_1.time_ and arg_239_1.time_ < var_242_1 + var_242_2 then
				local var_242_3 = (arg_239_1.time_ - var_242_1) / var_242_2
				local var_242_4 = Vector3.New(0, 1, 10)

				var_242_0.localPosition = Vector3.Lerp(arg_239_1.var_.moveOldPosF10g, var_242_4, var_242_3)
			end

			if arg_239_1.time_ >= var_242_1 + var_242_2 and arg_239_1.time_ < var_242_1 + var_242_2 + arg_242_0 then
				var_242_0.localPosition = Vector3.New(0, 1, 10)
			end

			local var_242_5 = arg_239_1.bgs_.F10g.transform
			local var_242_6 = 0.034

			if var_242_6 < arg_239_1.time_ and arg_239_1.time_ <= var_242_6 + arg_242_0 then
				arg_239_1.var_.moveOldPosF10g = var_242_5.localPosition
			end

			local var_242_7 = 2.16666666666667

			if var_242_6 <= arg_239_1.time_ and arg_239_1.time_ < var_242_6 + var_242_7 then
				local var_242_8 = (arg_239_1.time_ - var_242_6) / var_242_7
				local var_242_9 = Vector3.New(-0.88, 1, 7.33)

				var_242_5.localPosition = Vector3.Lerp(arg_239_1.var_.moveOldPosF10g, var_242_9, var_242_8)
			end

			if arg_239_1.time_ >= var_242_6 + var_242_7 and arg_239_1.time_ < var_242_6 + var_242_7 + arg_242_0 then
				var_242_5.localPosition = Vector3.New(-0.88, 1, 7.33)
			end

			local var_242_10 = 0

			if var_242_10 < arg_239_1.time_ and arg_239_1.time_ <= var_242_10 + arg_242_0 then
				arg_239_1.allBtn_.enabled = false
			end

			local var_242_11 = 2.20066666666667

			if arg_239_1.time_ >= var_242_10 + var_242_11 and arg_239_1.time_ < var_242_10 + var_242_11 + arg_242_0 then
				arg_239_1.allBtn_.enabled = true
			end

			if arg_239_1.frameCnt_ <= 1 then
				arg_239_1.dialog_:SetActive(false)
			end

			local var_242_12 = 2.1
			local var_242_13 = 0.825

			if var_242_12 < arg_239_1.time_ and arg_239_1.time_ <= var_242_12 + arg_242_0 then
				arg_239_1.talkMaxDuration = 0

				arg_239_1.dialog_:SetActive(true)

				arg_239_1.dialogCg_.alpha = 0

				local var_242_14 = LeanTween.value(arg_239_1.dialog_, 0, 1, 0.3)

				var_242_14:setOnUpdate(LuaHelper.FloatAction(function(arg_243_0)
					arg_239_1.dialogCg_.alpha = arg_243_0
				end))
				var_242_14:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_239_1.dialog_)
					var_242_14:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_239_1.duration_ = arg_239_1.duration_ + 0.3

				SetActive(arg_239_1.leftNameGo_, false)

				arg_239_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_239_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_239_1:RecordName(arg_239_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_239_1.iconTrs_.gameObject, false)
				arg_239_1.callingController_:SetSelectedState("normal")

				local var_242_15 = arg_239_1:GetWordFromCfg(413131057)
				local var_242_16 = arg_239_1:FormatText(var_242_15.content)

				arg_239_1.text_.text = var_242_16

				LuaForUtil.ClearLinePrefixSymbol(arg_239_1.text_)

				local var_242_17 = 33
				local var_242_18 = utf8.len(var_242_16)
				local var_242_19 = var_242_17 <= 0 and var_242_13 or var_242_13 * (var_242_18 / var_242_17)

				if var_242_19 > 0 and var_242_13 < var_242_19 then
					arg_239_1.talkMaxDuration = var_242_19
					var_242_12 = var_242_12 + 0.3

					if var_242_19 + var_242_12 > arg_239_1.duration_ then
						arg_239_1.duration_ = var_242_19 + var_242_12
					end
				end

				arg_239_1.text_.text = var_242_16
				arg_239_1.typewritter.percent = 0

				arg_239_1.typewritter:SetDirty()
				arg_239_1:ShowNextGo(false)
				arg_239_1:RecordContent(arg_239_1.text_.text)
			end

			local var_242_20 = var_242_12 + 0.3
			local var_242_21 = math.max(var_242_13, arg_239_1.talkMaxDuration)

			if var_242_20 <= arg_239_1.time_ and arg_239_1.time_ < var_242_20 + var_242_21 then
				arg_239_1.typewritter.percent = (arg_239_1.time_ - var_242_20) / var_242_21

				arg_239_1.typewritter:SetDirty()
			end

			if arg_239_1.time_ >= var_242_20 + var_242_21 and arg_239_1.time_ < var_242_20 + var_242_21 + arg_242_0 then
				arg_239_1.typewritter.percent = 1

				arg_239_1.typewritter:SetDirty()
				arg_239_1:ShowNextGo(true)
			end
		end

		arg_239_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "F10g",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Background
			},
			{
				assetPath = "",
				actorName = "F10g",
				changeDisplayLayer = false,
				needEase = false,
				duration = 2.16666666666667,
				className = "StoryMoveNode",
				startTime = 0.034,
				actorType = StoryPlayerConst.ACTOR_TYPE.Background
			}
		}

		arg_239_1:InitPlayNodeList()
	end,
	Play413131058 = function(arg_245_0, arg_245_1)
		arg_245_1.time_ = 0
		arg_245_1.frameCnt_ = 0
		arg_245_1.state_ = "playing"
		arg_245_1.curTalkId_ = 413131058
		arg_245_1.duration_ = 1.1

		local var_245_0 = {
			zh = 1.033,
			ja = 1.1
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
				arg_245_0:Play413131059(arg_245_1)
			end
		end

		function arg_245_1.onSingleLineUpdate_(arg_248_0)
			local var_248_0 = 0
			local var_248_1 = 0.05

			if var_248_0 < arg_245_1.time_ and arg_245_1.time_ <= var_248_0 + arg_248_0 then
				arg_245_1.talkMaxDuration = 0
				arg_245_1.dialogCg_.alpha = 1

				arg_245_1.dialog_:SetActive(true)
				SetActive(arg_245_1.leftNameGo_, true)

				local var_248_2 = arg_245_1:FormatText(StoryNameCfg[998].name)

				arg_245_1.leftNameTxt_.text = var_248_2

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

				local var_248_3 = arg_245_1:GetWordFromCfg(413131058)
				local var_248_4 = arg_245_1:FormatText(var_248_3.content)

				arg_245_1.text_.text = var_248_4

				LuaForUtil.ClearLinePrefixSymbol(arg_245_1.text_)

				local var_248_5 = 2
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

				if manager.audio:GetVoiceLength("story_v_out_413131", "413131058", "story_v_out_413131.awb") ~= 0 then
					local var_248_8 = manager.audio:GetVoiceLength("story_v_out_413131", "413131058", "story_v_out_413131.awb") / 1000

					if var_248_8 + var_248_0 > arg_245_1.duration_ then
						arg_245_1.duration_ = var_248_8 + var_248_0
					end

					if var_248_3.prefab_name ~= "" and arg_245_1.actors_[var_248_3.prefab_name] ~= nil then
						local var_248_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_245_1.actors_[var_248_3.prefab_name].transform, "story_v_out_413131", "413131058", "story_v_out_413131.awb")

						arg_245_1:RecordAudio("413131058", var_248_9)
						arg_245_1:RecordAudio("413131058", var_248_9)
					else
						arg_245_1:AudioAction("play", "voice", "story_v_out_413131", "413131058", "story_v_out_413131.awb")
					end

					arg_245_1:RecordHistoryTalkVoice("story_v_out_413131", "413131058", "story_v_out_413131.awb")
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
	Play413131059 = function(arg_249_0, arg_249_1)
		arg_249_1.time_ = 0
		arg_249_1.frameCnt_ = 0
		arg_249_1.state_ = "playing"
		arg_249_1.curTalkId_ = 413131059
		arg_249_1.duration_ = 5

		SetActive(arg_249_1.tipsGo_, false)

		function arg_249_1.onSingleLineFinish_()
			arg_249_1.onSingleLineUpdate_ = nil
			arg_249_1.onSingleLineFinish_ = nil
			arg_249_1.state_ = "waiting"
		end

		function arg_249_1.playNext_(arg_251_0)
			if arg_251_0 == 1 then
				arg_249_0:Play413131060(arg_249_1)
			end
		end

		function arg_249_1.onSingleLineUpdate_(arg_252_0)
			local var_252_0 = 0
			local var_252_1 = 1.175

			if var_252_0 < arg_249_1.time_ and arg_249_1.time_ <= var_252_0 + arg_252_0 then
				arg_249_1.talkMaxDuration = 0
				arg_249_1.dialogCg_.alpha = 1

				arg_249_1.dialog_:SetActive(true)
				SetActive(arg_249_1.leftNameGo_, false)

				arg_249_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_249_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_249_1:RecordName(arg_249_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_249_1.iconTrs_.gameObject, false)
				arg_249_1.callingController_:SetSelectedState("normal")

				local var_252_2 = arg_249_1:GetWordFromCfg(413131059)
				local var_252_3 = arg_249_1:FormatText(var_252_2.content)

				arg_249_1.text_.text = var_252_3

				LuaForUtil.ClearLinePrefixSymbol(arg_249_1.text_)

				local var_252_4 = 47
				local var_252_5 = utf8.len(var_252_3)
				local var_252_6 = var_252_4 <= 0 and var_252_1 or var_252_1 * (var_252_5 / var_252_4)

				if var_252_6 > 0 and var_252_1 < var_252_6 then
					arg_249_1.talkMaxDuration = var_252_6

					if var_252_6 + var_252_0 > arg_249_1.duration_ then
						arg_249_1.duration_ = var_252_6 + var_252_0
					end
				end

				arg_249_1.text_.text = var_252_3
				arg_249_1.typewritter.percent = 0

				arg_249_1.typewritter:SetDirty()
				arg_249_1:ShowNextGo(false)
				arg_249_1:RecordContent(arg_249_1.text_.text)
			end

			local var_252_7 = math.max(var_252_1, arg_249_1.talkMaxDuration)

			if var_252_0 <= arg_249_1.time_ and arg_249_1.time_ < var_252_0 + var_252_7 then
				arg_249_1.typewritter.percent = (arg_249_1.time_ - var_252_0) / var_252_7

				arg_249_1.typewritter:SetDirty()
			end

			if arg_249_1.time_ >= var_252_0 + var_252_7 and arg_249_1.time_ < var_252_0 + var_252_7 + arg_252_0 then
				arg_249_1.typewritter.percent = 1

				arg_249_1.typewritter:SetDirty()
				arg_249_1:ShowNextGo(true)
			end
		end

		arg_249_1.nodeConfigList_ = {}

		arg_249_1:InitPlayNodeList()
	end,
	Play413131060 = function(arg_253_0, arg_253_1)
		arg_253_1.time_ = 0
		arg_253_1.frameCnt_ = 0
		arg_253_1.state_ = "playing"
		arg_253_1.curTalkId_ = 413131060
		arg_253_1.duration_ = 1

		SetActive(arg_253_1.tipsGo_, false)

		function arg_253_1.onSingleLineFinish_()
			arg_253_1.onSingleLineUpdate_ = nil
			arg_253_1.onSingleLineFinish_ = nil
			arg_253_1.state_ = "waiting"
		end

		function arg_253_1.playNext_(arg_255_0)
			if arg_255_0 == 1 then
				arg_253_0:Play413131061(arg_253_1)
			end
		end

		function arg_253_1.onSingleLineUpdate_(arg_256_0)
			local var_256_0 = 0
			local var_256_1 = 0.05

			if var_256_0 < arg_253_1.time_ and arg_253_1.time_ <= var_256_0 + arg_256_0 then
				arg_253_1.talkMaxDuration = 0
				arg_253_1.dialogCg_.alpha = 1

				arg_253_1.dialog_:SetActive(true)
				SetActive(arg_253_1.leftNameGo_, true)

				local var_256_2 = arg_253_1:FormatText(StoryNameCfg[998].name)

				arg_253_1.leftNameTxt_.text = var_256_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_253_1.leftNameTxt_.transform)

				arg_253_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_253_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_253_1:RecordName(arg_253_1.leftNameTxt_.text)
				SetActive(arg_253_1.iconTrs_.gameObject, true)
				arg_253_1.iconController_:SetSelectedState("hero")

				arg_253_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_knightwoman1")

				arg_253_1.callingController_:SetSelectedState("normal")

				arg_253_1.keyicon_.color = Color.New(1, 1, 1)
				arg_253_1.icon_.color = Color.New(1, 1, 1)

				local var_256_3 = arg_253_1:GetWordFromCfg(413131060)
				local var_256_4 = arg_253_1:FormatText(var_256_3.content)

				arg_253_1.text_.text = var_256_4

				LuaForUtil.ClearLinePrefixSymbol(arg_253_1.text_)

				local var_256_5 = 2
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

				if manager.audio:GetVoiceLength("story_v_out_413131", "413131060", "story_v_out_413131.awb") ~= 0 then
					local var_256_8 = manager.audio:GetVoiceLength("story_v_out_413131", "413131060", "story_v_out_413131.awb") / 1000

					if var_256_8 + var_256_0 > arg_253_1.duration_ then
						arg_253_1.duration_ = var_256_8 + var_256_0
					end

					if var_256_3.prefab_name ~= "" and arg_253_1.actors_[var_256_3.prefab_name] ~= nil then
						local var_256_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_253_1.actors_[var_256_3.prefab_name].transform, "story_v_out_413131", "413131060", "story_v_out_413131.awb")

						arg_253_1:RecordAudio("413131060", var_256_9)
						arg_253_1:RecordAudio("413131060", var_256_9)
					else
						arg_253_1:AudioAction("play", "voice", "story_v_out_413131", "413131060", "story_v_out_413131.awb")
					end

					arg_253_1:RecordHistoryTalkVoice("story_v_out_413131", "413131060", "story_v_out_413131.awb")
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
	Play413131061 = function(arg_257_0, arg_257_1)
		arg_257_1.time_ = 0
		arg_257_1.frameCnt_ = 0
		arg_257_1.state_ = "playing"
		arg_257_1.curTalkId_ = 413131061
		arg_257_1.duration_ = 5

		SetActive(arg_257_1.tipsGo_, false)

		function arg_257_1.onSingleLineFinish_()
			arg_257_1.onSingleLineUpdate_ = nil
			arg_257_1.onSingleLineFinish_ = nil
			arg_257_1.state_ = "waiting"
		end

		function arg_257_1.playNext_(arg_259_0)
			if arg_259_0 == 1 then
				arg_257_0:Play413131062(arg_257_1)
			end
		end

		function arg_257_1.onSingleLineUpdate_(arg_260_0)
			local var_260_0 = 0
			local var_260_1 = 0.95

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

				local var_260_2 = arg_257_1:GetWordFromCfg(413131061)
				local var_260_3 = arg_257_1:FormatText(var_260_2.content)

				arg_257_1.text_.text = var_260_3

				LuaForUtil.ClearLinePrefixSymbol(arg_257_1.text_)

				local var_260_4 = 38
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
	Play413131062 = function(arg_261_0, arg_261_1)
		arg_261_1.time_ = 0
		arg_261_1.frameCnt_ = 0
		arg_261_1.state_ = "playing"
		arg_261_1.curTalkId_ = 413131062
		arg_261_1.duration_ = 1

		SetActive(arg_261_1.tipsGo_, false)

		function arg_261_1.onSingleLineFinish_()
			arg_261_1.onSingleLineUpdate_ = nil
			arg_261_1.onSingleLineFinish_ = nil
			arg_261_1.state_ = "waiting"
		end

		function arg_261_1.playNext_(arg_263_0)
			if arg_263_0 == 1 then
				arg_261_0:Play413131063(arg_261_1)
			end
		end

		function arg_261_1.onSingleLineUpdate_(arg_264_0)
			local var_264_0 = 0
			local var_264_1 = 0.05

			if var_264_0 < arg_261_1.time_ and arg_261_1.time_ <= var_264_0 + arg_264_0 then
				arg_261_1.talkMaxDuration = 0
				arg_261_1.dialogCg_.alpha = 1

				arg_261_1.dialog_:SetActive(true)
				SetActive(arg_261_1.leftNameGo_, true)

				local var_264_2 = arg_261_1:FormatText(StoryNameCfg[998].name)

				arg_261_1.leftNameTxt_.text = var_264_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_261_1.leftNameTxt_.transform)

				arg_261_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_261_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_261_1:RecordName(arg_261_1.leftNameTxt_.text)
				SetActive(arg_261_1.iconTrs_.gameObject, true)
				arg_261_1.iconController_:SetSelectedState("hero")

				arg_261_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_knightwoman1")

				arg_261_1.callingController_:SetSelectedState("normal")

				arg_261_1.keyicon_.color = Color.New(1, 1, 1)
				arg_261_1.icon_.color = Color.New(1, 1, 1)

				local var_264_3 = arg_261_1:GetWordFromCfg(413131062)
				local var_264_4 = arg_261_1:FormatText(var_264_3.content)

				arg_261_1.text_.text = var_264_4

				LuaForUtil.ClearLinePrefixSymbol(arg_261_1.text_)

				local var_264_5 = 2
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

				if manager.audio:GetVoiceLength("story_v_out_413131", "413131062", "story_v_out_413131.awb") ~= 0 then
					local var_264_8 = manager.audio:GetVoiceLength("story_v_out_413131", "413131062", "story_v_out_413131.awb") / 1000

					if var_264_8 + var_264_0 > arg_261_1.duration_ then
						arg_261_1.duration_ = var_264_8 + var_264_0
					end

					if var_264_3.prefab_name ~= "" and arg_261_1.actors_[var_264_3.prefab_name] ~= nil then
						local var_264_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_261_1.actors_[var_264_3.prefab_name].transform, "story_v_out_413131", "413131062", "story_v_out_413131.awb")

						arg_261_1:RecordAudio("413131062", var_264_9)
						arg_261_1:RecordAudio("413131062", var_264_9)
					else
						arg_261_1:AudioAction("play", "voice", "story_v_out_413131", "413131062", "story_v_out_413131.awb")
					end

					arg_261_1:RecordHistoryTalkVoice("story_v_out_413131", "413131062", "story_v_out_413131.awb")
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
	Play413131063 = function(arg_265_0, arg_265_1)
		arg_265_1.time_ = 0
		arg_265_1.frameCnt_ = 0
		arg_265_1.state_ = "playing"
		arg_265_1.curTalkId_ = 413131063
		arg_265_1.duration_ = 6

		SetActive(arg_265_1.tipsGo_, false)

		function arg_265_1.onSingleLineFinish_()
			arg_265_1.onSingleLineUpdate_ = nil
			arg_265_1.onSingleLineFinish_ = nil
			arg_265_1.state_ = "waiting"
		end

		function arg_265_1.playNext_(arg_267_0)
			if arg_267_0 == 1 then
				arg_265_0:Play413131064(arg_265_1)
			end
		end

		function arg_265_1.onSingleLineUpdate_(arg_268_0)
			local var_268_0 = manager.ui.mainCamera.transform
			local var_268_1 = 0.366666666666667

			if var_268_1 < arg_265_1.time_ and arg_265_1.time_ <= var_268_1 + arg_268_0 then
				arg_265_1.var_.shakeOldPos = var_268_0.localPosition
			end

			local var_268_2 = 0.633333333333333

			if var_268_1 <= arg_265_1.time_ and arg_265_1.time_ < var_268_1 + var_268_2 then
				local var_268_3 = (arg_265_1.time_ - var_268_1) / 0.066
				local var_268_4, var_268_5 = math.modf(var_268_3)

				var_268_0.localPosition = Vector3.New(var_268_5 * 0.13, var_268_5 * 0.13, var_268_5 * 0.13) + arg_265_1.var_.shakeOldPos
			end

			if arg_265_1.time_ >= var_268_1 + var_268_2 and arg_265_1.time_ < var_268_1 + var_268_2 + arg_268_0 then
				var_268_0.localPosition = arg_265_1.var_.shakeOldPos
			end

			local var_268_6 = 0

			if var_268_6 < arg_265_1.time_ and arg_265_1.time_ <= var_268_6 + arg_268_0 then
				arg_265_1.mask_.enabled = true
				arg_265_1.mask_.raycastTarget = false

				arg_265_1:SetGaussion(false)
			end

			local var_268_7 = 0.6

			if var_268_6 <= arg_265_1.time_ and arg_265_1.time_ < var_268_6 + var_268_7 then
				local var_268_8 = (arg_265_1.time_ - var_268_6) / var_268_7
				local var_268_9 = Color.New(1, 1, 1)

				var_268_9.a = Mathf.Lerp(1, 0, var_268_8)
				arg_265_1.mask_.color = var_268_9
			end

			if arg_265_1.time_ >= var_268_6 + var_268_7 and arg_265_1.time_ < var_268_6 + var_268_7 + arg_268_0 then
				local var_268_10 = Color.New(1, 1, 1)
				local var_268_11 = 0

				arg_265_1.mask_.enabled = false
				var_268_10.a = var_268_11
				arg_265_1.mask_.color = var_268_10
			end

			if arg_265_1.frameCnt_ <= 1 then
				arg_265_1.dialog_:SetActive(false)
			end

			local var_268_12 = 1
			local var_268_13 = 0.525

			if var_268_12 < arg_265_1.time_ and arg_265_1.time_ <= var_268_12 + arg_268_0 then
				arg_265_1.talkMaxDuration = 0

				arg_265_1.dialog_:SetActive(true)

				arg_265_1.dialogCg_.alpha = 0

				local var_268_14 = LeanTween.value(arg_265_1.dialog_, 0, 1, 0.3)

				var_268_14:setOnUpdate(LuaHelper.FloatAction(function(arg_269_0)
					arg_265_1.dialogCg_.alpha = arg_269_0
				end))
				var_268_14:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_265_1.dialog_)
					var_268_14:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_265_1.duration_ = arg_265_1.duration_ + 0.3

				SetActive(arg_265_1.leftNameGo_, false)

				arg_265_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_265_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_265_1:RecordName(arg_265_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_265_1.iconTrs_.gameObject, false)
				arg_265_1.callingController_:SetSelectedState("normal")

				local var_268_15 = arg_265_1:GetWordFromCfg(413131063)
				local var_268_16 = arg_265_1:FormatText(var_268_15.content)

				arg_265_1.text_.text = var_268_16

				LuaForUtil.ClearLinePrefixSymbol(arg_265_1.text_)

				local var_268_17 = 21
				local var_268_18 = utf8.len(var_268_16)
				local var_268_19 = var_268_17 <= 0 and var_268_13 or var_268_13 * (var_268_18 / var_268_17)

				if var_268_19 > 0 and var_268_13 < var_268_19 then
					arg_265_1.talkMaxDuration = var_268_19
					var_268_12 = var_268_12 + 0.3

					if var_268_19 + var_268_12 > arg_265_1.duration_ then
						arg_265_1.duration_ = var_268_19 + var_268_12
					end
				end

				arg_265_1.text_.text = var_268_16
				arg_265_1.typewritter.percent = 0

				arg_265_1.typewritter:SetDirty()
				arg_265_1:ShowNextGo(false)
				arg_265_1:RecordContent(arg_265_1.text_.text)
			end

			local var_268_20 = var_268_12 + 0.3
			local var_268_21 = math.max(var_268_13, arg_265_1.talkMaxDuration)

			if var_268_20 <= arg_265_1.time_ and arg_265_1.time_ < var_268_20 + var_268_21 then
				arg_265_1.typewritter.percent = (arg_265_1.time_ - var_268_20) / var_268_21

				arg_265_1.typewritter:SetDirty()
			end

			if arg_265_1.time_ >= var_268_20 + var_268_21 and arg_265_1.time_ < var_268_20 + var_268_21 + arg_268_0 then
				arg_265_1.typewritter.percent = 1

				arg_265_1.typewritter:SetDirty()
				arg_265_1:ShowNextGo(true)
			end
		end

		arg_265_1.nodeConfigList_ = {}

		arg_265_1:InitPlayNodeList()
	end,
	Play413131064 = function(arg_271_0, arg_271_1)
		arg_271_1.time_ = 0
		arg_271_1.frameCnt_ = 0
		arg_271_1.state_ = "playing"
		arg_271_1.curTalkId_ = 413131064
		arg_271_1.duration_ = 1.67

		local var_271_0 = {
			zh = 0.999999999999,
			ja = 1.666
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
			arg_271_1.auto_ = false
		end

		function arg_271_1.playNext_(arg_273_0)
			arg_271_1.onStoryFinished_()
		end

		function arg_271_1.onSingleLineUpdate_(arg_274_0)
			local var_274_0 = 0
			local var_274_1 = 1

			if var_274_0 < arg_271_1.time_ and arg_271_1.time_ <= var_274_0 + arg_274_0 then
				local var_274_2 = "play"
				local var_274_3 = "effect"

				arg_271_1:AudioAction(var_274_2, var_274_3, "se_story_122_03", "se_story_122_03_stonecrushing", "")
			end

			local var_274_4 = 0
			local var_274_5 = 0.075

			if var_274_4 < arg_271_1.time_ and arg_271_1.time_ <= var_274_4 + arg_274_0 then
				arg_271_1.talkMaxDuration = 0
				arg_271_1.dialogCg_.alpha = 1

				arg_271_1.dialog_:SetActive(true)
				SetActive(arg_271_1.leftNameGo_, true)

				local var_274_6 = arg_271_1:FormatText(StoryNameCfg[614].name)

				arg_271_1.leftNameTxt_.text = var_274_6

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_271_1.leftNameTxt_.transform)

				arg_271_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_271_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_271_1:RecordName(arg_271_1.leftNameTxt_.text)
				SetActive(arg_271_1.iconTrs_.gameObject, true)
				arg_271_1.iconController_:SetSelectedState("hero")

				arg_271_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_10022_split_6")

				arg_271_1.callingController_:SetSelectedState("normal")

				arg_271_1.keyicon_.color = Color.New(1, 1, 1)
				arg_271_1.icon_.color = Color.New(1, 1, 1)

				local var_274_7 = arg_271_1:GetWordFromCfg(413131064)
				local var_274_8 = arg_271_1:FormatText(var_274_7.content)

				arg_271_1.text_.text = var_274_8

				LuaForUtil.ClearLinePrefixSymbol(arg_271_1.text_)

				local var_274_9 = 3
				local var_274_10 = utf8.len(var_274_8)
				local var_274_11 = var_274_9 <= 0 and var_274_5 or var_274_5 * (var_274_10 / var_274_9)

				if var_274_11 > 0 and var_274_5 < var_274_11 then
					arg_271_1.talkMaxDuration = var_274_11

					if var_274_11 + var_274_4 > arg_271_1.duration_ then
						arg_271_1.duration_ = var_274_11 + var_274_4
					end
				end

				arg_271_1.text_.text = var_274_8
				arg_271_1.typewritter.percent = 0

				arg_271_1.typewritter:SetDirty()
				arg_271_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_413131", "413131064", "story_v_out_413131.awb") ~= 0 then
					local var_274_12 = manager.audio:GetVoiceLength("story_v_out_413131", "413131064", "story_v_out_413131.awb") / 1000

					if var_274_12 + var_274_4 > arg_271_1.duration_ then
						arg_271_1.duration_ = var_274_12 + var_274_4
					end

					if var_274_7.prefab_name ~= "" and arg_271_1.actors_[var_274_7.prefab_name] ~= nil then
						local var_274_13 = LuaForUtil.PlayVoiceWithCriLipsync(arg_271_1.actors_[var_274_7.prefab_name].transform, "story_v_out_413131", "413131064", "story_v_out_413131.awb")

						arg_271_1:RecordAudio("413131064", var_274_13)
						arg_271_1:RecordAudio("413131064", var_274_13)
					else
						arg_271_1:AudioAction("play", "voice", "story_v_out_413131", "413131064", "story_v_out_413131.awb")
					end

					arg_271_1:RecordHistoryTalkVoice("story_v_out_413131", "413131064", "story_v_out_413131.awb")
				end

				arg_271_1:RecordContent(arg_271_1.text_.text)
			end

			local var_274_14 = math.max(var_274_5, arg_271_1.talkMaxDuration)

			if var_274_4 <= arg_271_1.time_ and arg_271_1.time_ < var_274_4 + var_274_14 then
				arg_271_1.typewritter.percent = (arg_271_1.time_ - var_274_4) / var_274_14

				arg_271_1.typewritter:SetDirty()
			end

			if arg_271_1.time_ >= var_274_4 + var_274_14 and arg_271_1.time_ < var_274_4 + var_274_14 + arg_274_0 then
				arg_271_1.typewritter.percent = 1

				arg_271_1.typewritter:SetDirty()
				arg_271_1:ShowNextGo(true)
			end
		end

		arg_271_1.nodeConfigList_ = {}

		arg_271_1:InitPlayNodeList()
	end,
	assets = {
		"TextureConfig/Background/ST0603a",
		"TextureConfig/Background/F10g",
		"TextureConfig/Background/F08i"
	},
	voices = {
		"story_v_out_413131.awb"
	}
}
