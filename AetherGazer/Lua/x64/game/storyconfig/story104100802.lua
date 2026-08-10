return {
	Play410082001 = function(arg_1_0, arg_1_1)
		arg_1_1.time_ = 0
		arg_1_1.frameCnt_ = 0
		arg_1_1.state_ = "playing"
		arg_1_1.curTalkId_ = 410082001
		arg_1_1.duration_ = 8.8

		local var_1_0 = {
			zh = 5.5,
			ja = 8.8
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
				arg_1_0:Play410082002(arg_1_1)
			end
		end

		function arg_1_1.onSingleLineUpdate_(arg_4_0)
			local var_4_0 = "L01f"

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
				local var_4_5 = arg_1_1.bgs_.L01f

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
					if iter_4_0 ~= "L01f" then
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

			local var_4_22 = "1060"

			if arg_1_1.actors_[var_4_22] == nil then
				local var_4_23 = Asset.Load("Widget/System/Story/StoryExpression/" .. "1060")

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

			local var_4_26 = arg_1_1.actors_["1060"].transform
			local var_4_27 = 2

			if var_4_27 < arg_1_1.time_ and arg_1_1.time_ <= var_4_27 + arg_4_0 then
				arg_1_1.var_.moveOldPos1060 = var_4_26.localPosition
				var_4_26.localScale = Vector3.New(1, 1, 1)

				arg_1_1:CheckSpriteTmpPos("1060", 2)

				local var_4_28 = var_4_26.childCount

				for iter_4_4 = 0, var_4_28 - 1 do
					local var_4_29 = var_4_26:GetChild(iter_4_4)

					if var_4_29.name == "" or not string.find(var_4_29.name, "split") then
						var_4_29.gameObject:SetActive(true)
					else
						var_4_29.gameObject:SetActive(false)
					end
				end
			end

			local var_4_30 = 0.001

			if var_4_27 <= arg_1_1.time_ and arg_1_1.time_ < var_4_27 + var_4_30 then
				local var_4_31 = (arg_1_1.time_ - var_4_27) / var_4_30
				local var_4_32 = Vector3.New(-440.94, -430.8, 6.9)

				var_4_26.localPosition = Vector3.Lerp(arg_1_1.var_.moveOldPos1060, var_4_32, var_4_31)
			end

			if arg_1_1.time_ >= var_4_27 + var_4_30 and arg_1_1.time_ < var_4_27 + var_4_30 + arg_4_0 then
				var_4_26.localPosition = Vector3.New(-440.94, -430.8, 6.9)
			end

			local var_4_33 = "10062"

			if arg_1_1.actors_[var_4_33] == nil then
				local var_4_34 = Asset.Load("Widget/System/Story/StoryExpression/" .. "10062")

				if not isNil(var_4_34) then
					local var_4_35 = Object.Instantiate(var_4_34, arg_1_1.canvasGo_.transform)

					var_4_35.transform:SetSiblingIndex(1)

					var_4_35.name = var_4_33
					var_4_35.transform.localPosition = Vector3.New(0, 100000, 0)
					arg_1_1.actors_[var_4_33] = var_4_35

					local var_4_36 = var_4_35:GetComponentsInChildren(typeof(Image), true):ToTable()

					if arg_1_1.isInRecall_ then
						for iter_4_5, iter_4_6 in ipairs(var_4_36) do
							iter_4_6.color = arg_1_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						end
					end
				end
			end

			local var_4_37 = arg_1_1.actors_["10062"].transform
			local var_4_38 = 2

			if var_4_38 < arg_1_1.time_ and arg_1_1.time_ <= var_4_38 + arg_4_0 then
				arg_1_1.var_.moveOldPos10062 = var_4_37.localPosition
				var_4_37.localScale = Vector3.New(1, 1, 1)

				arg_1_1:CheckSpriteTmpPos("10062", 4)

				local var_4_39 = var_4_37.childCount

				for iter_4_7 = 0, var_4_39 - 1 do
					local var_4_40 = var_4_37:GetChild(iter_4_7)

					if var_4_40.name == "" or not string.find(var_4_40.name, "split") then
						var_4_40.gameObject:SetActive(true)
					else
						var_4_40.gameObject:SetActive(false)
					end
				end
			end

			local var_4_41 = 0.001

			if var_4_38 <= arg_1_1.time_ and arg_1_1.time_ < var_4_38 + var_4_41 then
				local var_4_42 = (arg_1_1.time_ - var_4_38) / var_4_41
				local var_4_43 = Vector3.New(370, -390, -290)

				var_4_37.localPosition = Vector3.Lerp(arg_1_1.var_.moveOldPos10062, var_4_43, var_4_42)
			end

			if arg_1_1.time_ >= var_4_38 + var_4_41 and arg_1_1.time_ < var_4_38 + var_4_41 + arg_4_0 then
				var_4_37.localPosition = Vector3.New(370, -390, -290)
			end

			local var_4_44 = arg_1_1.actors_["1060"]
			local var_4_45 = 2

			if var_4_45 < arg_1_1.time_ and arg_1_1.time_ <= var_4_45 + arg_4_0 and not isNil(var_4_44) and arg_1_1.var_.actorSpriteComps1060 == nil then
				arg_1_1.var_.actorSpriteComps1060 = var_4_44:GetComponentsInChildren(typeof(Image), true)
			end

			local var_4_46 = 0.034

			if var_4_45 <= arg_1_1.time_ and arg_1_1.time_ < var_4_45 + var_4_46 and not isNil(var_4_44) then
				local var_4_47 = (arg_1_1.time_ - var_4_45) / var_4_46

				if arg_1_1.var_.actorSpriteComps1060 then
					for iter_4_8, iter_4_9 in pairs(arg_1_1.var_.actorSpriteComps1060:ToTable()) do
						if iter_4_9 then
							if arg_1_1.isInRecall_ then
								local var_4_48 = Mathf.Lerp(iter_4_9.color.r, arg_1_1.hightColor1.r, var_4_47)
								local var_4_49 = Mathf.Lerp(iter_4_9.color.g, arg_1_1.hightColor1.g, var_4_47)
								local var_4_50 = Mathf.Lerp(iter_4_9.color.b, arg_1_1.hightColor1.b, var_4_47)

								iter_4_9.color = Color.New(var_4_48, var_4_49, var_4_50)
							else
								local var_4_51 = Mathf.Lerp(iter_4_9.color.r, 1, var_4_47)

								iter_4_9.color = Color.New(var_4_51, var_4_51, var_4_51)
							end
						end
					end
				end
			end

			if arg_1_1.time_ >= var_4_45 + var_4_46 and arg_1_1.time_ < var_4_45 + var_4_46 + arg_4_0 and not isNil(var_4_44) and arg_1_1.var_.actorSpriteComps1060 then
				for iter_4_10, iter_4_11 in pairs(arg_1_1.var_.actorSpriteComps1060:ToTable()) do
					if iter_4_11 then
						if arg_1_1.isInRecall_ then
							iter_4_11.color = arg_1_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_4_11.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_1_1.var_.actorSpriteComps1060 = nil
			end

			local var_4_52 = arg_1_1.actors_["10062"]
			local var_4_53 = 2

			if var_4_53 < arg_1_1.time_ and arg_1_1.time_ <= var_4_53 + arg_4_0 and not isNil(var_4_52) and arg_1_1.var_.actorSpriteComps10062 == nil then
				arg_1_1.var_.actorSpriteComps10062 = var_4_52:GetComponentsInChildren(typeof(Image), true)
			end

			local var_4_54 = 0.034

			if var_4_53 <= arg_1_1.time_ and arg_1_1.time_ < var_4_53 + var_4_54 and not isNil(var_4_52) then
				local var_4_55 = (arg_1_1.time_ - var_4_53) / var_4_54

				if arg_1_1.var_.actorSpriteComps10062 then
					for iter_4_12, iter_4_13 in pairs(arg_1_1.var_.actorSpriteComps10062:ToTable()) do
						if iter_4_13 then
							if arg_1_1.isInRecall_ then
								local var_4_56 = Mathf.Lerp(iter_4_13.color.r, arg_1_1.hightColor2.r, var_4_55)
								local var_4_57 = Mathf.Lerp(iter_4_13.color.g, arg_1_1.hightColor2.g, var_4_55)
								local var_4_58 = Mathf.Lerp(iter_4_13.color.b, arg_1_1.hightColor2.b, var_4_55)

								iter_4_13.color = Color.New(var_4_56, var_4_57, var_4_58)
							else
								local var_4_59 = Mathf.Lerp(iter_4_13.color.r, 0.5, var_4_55)

								iter_4_13.color = Color.New(var_4_59, var_4_59, var_4_59)
							end
						end
					end
				end
			end

			if arg_1_1.time_ >= var_4_53 + var_4_54 and arg_1_1.time_ < var_4_53 + var_4_54 + arg_4_0 and not isNil(var_4_52) and arg_1_1.var_.actorSpriteComps10062 then
				for iter_4_14, iter_4_15 in pairs(arg_1_1.var_.actorSpriteComps10062:ToTable()) do
					if iter_4_15 then
						if arg_1_1.isInRecall_ then
							iter_4_15.color = arg_1_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_4_15.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_1_1.var_.actorSpriteComps10062 = nil
			end

			local var_4_60 = 0
			local var_4_61 = 1

			if var_4_60 < arg_1_1.time_ and arg_1_1.time_ <= var_4_60 + arg_4_0 then
				local var_4_62 = "play"
				local var_4_63 = "music"

				arg_1_1:AudioAction(var_4_62, var_4_63, "ui_battle", "ui_battle_stopbgm", "")

				local var_4_64 = ""
				local var_4_65 = manager.audio:GetAudioName("ui_battle", "ui_battle_stopbgm")

				if var_4_65 ~= "" then
					if arg_1_1.bgmTxt_.text ~= var_4_65 and arg_1_1.bgmTxt_.text ~= "" then
						if arg_1_1.bgmTxt2_.text ~= "" then
							arg_1_1.bgmTxt_.text = arg_1_1.bgmTxt2_.text
						end

						arg_1_1.bgmTxt2_.text = var_4_65

						arg_1_1.musicChangeAnimator_:Play("music_change", 0, 0)
					else
						arg_1_1.bgmTxt_.text = var_4_65
						arg_1_1.bgmTxt2_.text = var_4_65
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

			local var_4_66 = 1.56666666666667
			local var_4_67 = 1

			if var_4_66 < arg_1_1.time_ and arg_1_1.time_ <= var_4_66 + arg_4_0 then
				local var_4_68 = "play"
				local var_4_69 = "music"

				arg_1_1:AudioAction(var_4_68, var_4_69, "bgm_activity_2_8_story_jivitabad_slum", "bgm_activity_2_8_story_jivitabad_slum", "bgm_activity_2_8_story_jivitabad_slum.awb")

				local var_4_70 = ""
				local var_4_71 = manager.audio:GetAudioName("bgm_activity_2_8_story_jivitabad_slum", "bgm_activity_2_8_story_jivitabad_slum")

				if var_4_71 ~= "" then
					if arg_1_1.bgmTxt_.text ~= var_4_71 and arg_1_1.bgmTxt_.text ~= "" then
						if arg_1_1.bgmTxt2_.text ~= "" then
							arg_1_1.bgmTxt_.text = arg_1_1.bgmTxt2_.text
						end

						arg_1_1.bgmTxt2_.text = var_4_71

						arg_1_1.musicChangeAnimator_:Play("music_change", 0, 0)
					else
						arg_1_1.bgmTxt_.text = var_4_71
						arg_1_1.bgmTxt2_.text = var_4_71
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

			local var_4_72 = 2
			local var_4_73 = 0.35

			if var_4_72 < arg_1_1.time_ and arg_1_1.time_ <= var_4_72 + arg_4_0 then
				arg_1_1.talkMaxDuration = 0

				arg_1_1.dialog_:SetActive(true)

				arg_1_1.dialogCg_.alpha = 0

				local var_4_74 = LeanTween.value(arg_1_1.dialog_, 0, 1, 0.3)

				var_4_74:setOnUpdate(LuaHelper.FloatAction(function(arg_7_0)
					arg_1_1.dialogCg_.alpha = arg_7_0
				end))
				var_4_74:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_1_1.dialog_)
					var_4_74:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_1_1.duration_ = arg_1_1.duration_ + 0.3

				SetActive(arg_1_1.leftNameGo_, true)

				local var_4_75 = arg_1_1:FormatText(StoryNameCfg[584].name)

				arg_1_1.leftNameTxt_.text = var_4_75

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_1_1.leftNameTxt_.transform)

				arg_1_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_1_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_1_1:RecordName(arg_1_1.leftNameTxt_.text)
				SetActive(arg_1_1.iconTrs_.gameObject, false)
				arg_1_1.callingController_:SetSelectedState("normal")

				local var_4_76 = arg_1_1:GetWordFromCfg(410082001)
				local var_4_77 = arg_1_1:FormatText(var_4_76.content)

				arg_1_1.text_.text = var_4_77

				LuaForUtil.ClearLinePrefixSymbol(arg_1_1.text_)

				local var_4_78 = 14
				local var_4_79 = utf8.len(var_4_77)
				local var_4_80 = var_4_78 <= 0 and var_4_73 or var_4_73 * (var_4_79 / var_4_78)

				if var_4_80 > 0 and var_4_73 < var_4_80 then
					arg_1_1.talkMaxDuration = var_4_80
					var_4_72 = var_4_72 + 0.3

					if var_4_80 + var_4_72 > arg_1_1.duration_ then
						arg_1_1.duration_ = var_4_80 + var_4_72
					end
				end

				arg_1_1.text_.text = var_4_77
				arg_1_1.typewritter.percent = 0

				arg_1_1.typewritter:SetDirty()
				arg_1_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_410082", "410082001", "story_v_out_410082.awb") ~= 0 then
					local var_4_81 = manager.audio:GetVoiceLength("story_v_out_410082", "410082001", "story_v_out_410082.awb") / 1000

					if var_4_81 + var_4_72 > arg_1_1.duration_ then
						arg_1_1.duration_ = var_4_81 + var_4_72
					end

					if var_4_76.prefab_name ~= "" and arg_1_1.actors_[var_4_76.prefab_name] ~= nil then
						local var_4_82 = LuaForUtil.PlayVoiceWithCriLipsync(arg_1_1.actors_[var_4_76.prefab_name].transform, "story_v_out_410082", "410082001", "story_v_out_410082.awb")

						arg_1_1:RecordAudio("410082001", var_4_82)
						arg_1_1:RecordAudio("410082001", var_4_82)
					else
						arg_1_1:AudioAction("play", "voice", "story_v_out_410082", "410082001", "story_v_out_410082.awb")
					end

					arg_1_1:RecordHistoryTalkVoice("story_v_out_410082", "410082001", "story_v_out_410082.awb")
				end

				arg_1_1:RecordContent(arg_1_1.text_.text)
			end

			local var_4_83 = var_4_72 + 0.3
			local var_4_84 = math.max(var_4_73, arg_1_1.talkMaxDuration)

			if var_4_83 <= arg_1_1.time_ and arg_1_1.time_ < var_4_83 + var_4_84 then
				arg_1_1.typewritter.percent = (arg_1_1.time_ - var_4_83) / var_4_84

				arg_1_1.typewritter:SetDirty()
			end

			if arg_1_1.time_ >= var_4_83 + var_4_84 and arg_1_1.time_ < var_4_83 + var_4_84 + arg_4_0 then
				arg_1_1.typewritter.percent = 1

				arg_1_1.typewritter:SetDirty()
				arg_1_1:ShowNextGo(true)
			end
		end

		arg_1_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1060",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 2,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			},
			{
				assetPath = "",
				actorName = "10062",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 2,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_1_1:InitPlayNodeList()
	end,
	Play410082002 = function(arg_9_0, arg_9_1)
		arg_9_1.time_ = 0
		arg_9_1.frameCnt_ = 0
		arg_9_1.state_ = "playing"
		arg_9_1.curTalkId_ = 410082002
		arg_9_1.duration_ = 10.63

		local var_9_0 = {
			zh = 5.1,
			ja = 10.633
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
				arg_9_0:Play410082003(arg_9_1)
			end
		end

		function arg_9_1.onSingleLineUpdate_(arg_12_0)
			local var_12_0 = arg_9_1.actors_["10062"].transform
			local var_12_1 = 0

			if var_12_1 < arg_9_1.time_ and arg_9_1.time_ <= var_12_1 + arg_12_0 then
				arg_9_1.var_.moveOldPos10062 = var_12_0.localPosition
				var_12_0.localScale = Vector3.New(1, 1, 1)

				arg_9_1:CheckSpriteTmpPos("10062", 4)

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
				local var_12_6 = Vector3.New(370, -390, -290)

				var_12_0.localPosition = Vector3.Lerp(arg_9_1.var_.moveOldPos10062, var_12_6, var_12_5)
			end

			if arg_9_1.time_ >= var_12_1 + var_12_4 and arg_9_1.time_ < var_12_1 + var_12_4 + arg_12_0 then
				var_12_0.localPosition = Vector3.New(370, -390, -290)
			end

			local var_12_7 = arg_9_1.actors_["10062"]
			local var_12_8 = 0

			if var_12_8 < arg_9_1.time_ and arg_9_1.time_ <= var_12_8 + arg_12_0 and not isNil(var_12_7) and arg_9_1.var_.actorSpriteComps10062 == nil then
				arg_9_1.var_.actorSpriteComps10062 = var_12_7:GetComponentsInChildren(typeof(Image), true)
			end

			local var_12_9 = 0.034

			if var_12_8 <= arg_9_1.time_ and arg_9_1.time_ < var_12_8 + var_12_9 and not isNil(var_12_7) then
				local var_12_10 = (arg_9_1.time_ - var_12_8) / var_12_9

				if arg_9_1.var_.actorSpriteComps10062 then
					for iter_12_1, iter_12_2 in pairs(arg_9_1.var_.actorSpriteComps10062:ToTable()) do
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

			if arg_9_1.time_ >= var_12_8 + var_12_9 and arg_9_1.time_ < var_12_8 + var_12_9 + arg_12_0 and not isNil(var_12_7) and arg_9_1.var_.actorSpriteComps10062 then
				for iter_12_3, iter_12_4 in pairs(arg_9_1.var_.actorSpriteComps10062:ToTable()) do
					if iter_12_4 then
						if arg_9_1.isInRecall_ then
							iter_12_4.color = arg_9_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_12_4.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_9_1.var_.actorSpriteComps10062 = nil
			end

			local var_12_15 = arg_9_1.actors_["1060"]
			local var_12_16 = 0

			if var_12_16 < arg_9_1.time_ and arg_9_1.time_ <= var_12_16 + arg_12_0 and not isNil(var_12_15) and arg_9_1.var_.actorSpriteComps1060 == nil then
				arg_9_1.var_.actorSpriteComps1060 = var_12_15:GetComponentsInChildren(typeof(Image), true)
			end

			local var_12_17 = 0.034

			if var_12_16 <= arg_9_1.time_ and arg_9_1.time_ < var_12_16 + var_12_17 and not isNil(var_12_15) then
				local var_12_18 = (arg_9_1.time_ - var_12_16) / var_12_17

				if arg_9_1.var_.actorSpriteComps1060 then
					for iter_12_5, iter_12_6 in pairs(arg_9_1.var_.actorSpriteComps1060:ToTable()) do
						if iter_12_6 then
							if arg_9_1.isInRecall_ then
								local var_12_19 = Mathf.Lerp(iter_12_6.color.r, arg_9_1.hightColor2.r, var_12_18)
								local var_12_20 = Mathf.Lerp(iter_12_6.color.g, arg_9_1.hightColor2.g, var_12_18)
								local var_12_21 = Mathf.Lerp(iter_12_6.color.b, arg_9_1.hightColor2.b, var_12_18)

								iter_12_6.color = Color.New(var_12_19, var_12_20, var_12_21)
							else
								local var_12_22 = Mathf.Lerp(iter_12_6.color.r, 0.5, var_12_18)

								iter_12_6.color = Color.New(var_12_22, var_12_22, var_12_22)
							end
						end
					end
				end
			end

			if arg_9_1.time_ >= var_12_16 + var_12_17 and arg_9_1.time_ < var_12_16 + var_12_17 + arg_12_0 and not isNil(var_12_15) and arg_9_1.var_.actorSpriteComps1060 then
				for iter_12_7, iter_12_8 in pairs(arg_9_1.var_.actorSpriteComps1060:ToTable()) do
					if iter_12_8 then
						if arg_9_1.isInRecall_ then
							iter_12_8.color = arg_9_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_12_8.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_9_1.var_.actorSpriteComps1060 = nil
			end

			local var_12_23 = 0
			local var_12_24 = 0.5

			if var_12_23 < arg_9_1.time_ and arg_9_1.time_ <= var_12_23 + arg_12_0 then
				arg_9_1.talkMaxDuration = 0
				arg_9_1.dialogCg_.alpha = 1

				arg_9_1.dialog_:SetActive(true)
				SetActive(arg_9_1.leftNameGo_, true)

				local var_12_25 = arg_9_1:FormatText(StoryNameCfg[600].name)

				arg_9_1.leftNameTxt_.text = var_12_25

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_9_1.leftNameTxt_.transform)

				arg_9_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_9_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_9_1:RecordName(arg_9_1.leftNameTxt_.text)
				SetActive(arg_9_1.iconTrs_.gameObject, false)
				arg_9_1.callingController_:SetSelectedState("normal")

				local var_12_26 = arg_9_1:GetWordFromCfg(410082002)
				local var_12_27 = arg_9_1:FormatText(var_12_26.content)

				arg_9_1.text_.text = var_12_27

				LuaForUtil.ClearLinePrefixSymbol(arg_9_1.text_)

				local var_12_28 = 20
				local var_12_29 = utf8.len(var_12_27)
				local var_12_30 = var_12_28 <= 0 and var_12_24 or var_12_24 * (var_12_29 / var_12_28)

				if var_12_30 > 0 and var_12_24 < var_12_30 then
					arg_9_1.talkMaxDuration = var_12_30

					if var_12_30 + var_12_23 > arg_9_1.duration_ then
						arg_9_1.duration_ = var_12_30 + var_12_23
					end
				end

				arg_9_1.text_.text = var_12_27
				arg_9_1.typewritter.percent = 0

				arg_9_1.typewritter:SetDirty()
				arg_9_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_410082", "410082002", "story_v_out_410082.awb") ~= 0 then
					local var_12_31 = manager.audio:GetVoiceLength("story_v_out_410082", "410082002", "story_v_out_410082.awb") / 1000

					if var_12_31 + var_12_23 > arg_9_1.duration_ then
						arg_9_1.duration_ = var_12_31 + var_12_23
					end

					if var_12_26.prefab_name ~= "" and arg_9_1.actors_[var_12_26.prefab_name] ~= nil then
						local var_12_32 = LuaForUtil.PlayVoiceWithCriLipsync(arg_9_1.actors_[var_12_26.prefab_name].transform, "story_v_out_410082", "410082002", "story_v_out_410082.awb")

						arg_9_1:RecordAudio("410082002", var_12_32)
						arg_9_1:RecordAudio("410082002", var_12_32)
					else
						arg_9_1:AudioAction("play", "voice", "story_v_out_410082", "410082002", "story_v_out_410082.awb")
					end

					arg_9_1:RecordHistoryTalkVoice("story_v_out_410082", "410082002", "story_v_out_410082.awb")
				end

				arg_9_1:RecordContent(arg_9_1.text_.text)
			end

			local var_12_33 = math.max(var_12_24, arg_9_1.talkMaxDuration)

			if var_12_23 <= arg_9_1.time_ and arg_9_1.time_ < var_12_23 + var_12_33 then
				arg_9_1.typewritter.percent = (arg_9_1.time_ - var_12_23) / var_12_33

				arg_9_1.typewritter:SetDirty()
			end

			if arg_9_1.time_ >= var_12_23 + var_12_33 and arg_9_1.time_ < var_12_23 + var_12_33 + arg_12_0 then
				arg_9_1.typewritter.percent = 1

				arg_9_1.typewritter:SetDirty()
				arg_9_1:ShowNextGo(true)
			end
		end

		arg_9_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10062",
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
	Play410082003 = function(arg_13_0, arg_13_1)
		arg_13_1.time_ = 0
		arg_13_1.frameCnt_ = 0
		arg_13_1.state_ = "playing"
		arg_13_1.curTalkId_ = 410082003
		arg_13_1.duration_ = 5

		SetActive(arg_13_1.tipsGo_, false)

		function arg_13_1.onSingleLineFinish_()
			arg_13_1.onSingleLineUpdate_ = nil
			arg_13_1.onSingleLineFinish_ = nil
			arg_13_1.state_ = "waiting"
		end

		function arg_13_1.playNext_(arg_15_0)
			if arg_15_0 == 1 then
				arg_13_0:Play410082004(arg_13_1)
			end
		end

		function arg_13_1.onSingleLineUpdate_(arg_16_0)
			local var_16_0 = arg_13_1.actors_["10062"]
			local var_16_1 = 0

			if var_16_1 < arg_13_1.time_ and arg_13_1.time_ <= var_16_1 + arg_16_0 and not isNil(var_16_0) and arg_13_1.var_.actorSpriteComps10062 == nil then
				arg_13_1.var_.actorSpriteComps10062 = var_16_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_16_2 = 0.034

			if var_16_1 <= arg_13_1.time_ and arg_13_1.time_ < var_16_1 + var_16_2 and not isNil(var_16_0) then
				local var_16_3 = (arg_13_1.time_ - var_16_1) / var_16_2

				if arg_13_1.var_.actorSpriteComps10062 then
					for iter_16_0, iter_16_1 in pairs(arg_13_1.var_.actorSpriteComps10062:ToTable()) do
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

			if arg_13_1.time_ >= var_16_1 + var_16_2 and arg_13_1.time_ < var_16_1 + var_16_2 + arg_16_0 and not isNil(var_16_0) and arg_13_1.var_.actorSpriteComps10062 then
				for iter_16_2, iter_16_3 in pairs(arg_13_1.var_.actorSpriteComps10062:ToTable()) do
					if iter_16_3 then
						if arg_13_1.isInRecall_ then
							iter_16_3.color = arg_13_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_16_3.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_13_1.var_.actorSpriteComps10062 = nil
			end

			local var_16_8 = arg_13_1.actors_["1060"].transform
			local var_16_9 = 0

			if var_16_9 < arg_13_1.time_ and arg_13_1.time_ <= var_16_9 + arg_16_0 then
				arg_13_1.var_.moveOldPos1060 = var_16_8.localPosition
				var_16_8.localScale = Vector3.New(1, 1, 1)

				arg_13_1:CheckSpriteTmpPos("1060", 7)

				local var_16_10 = var_16_8.childCount

				for iter_16_4 = 0, var_16_10 - 1 do
					local var_16_11 = var_16_8:GetChild(iter_16_4)

					if var_16_11.name == "" or not string.find(var_16_11.name, "split") then
						var_16_11.gameObject:SetActive(true)
					else
						var_16_11.gameObject:SetActive(false)
					end
				end
			end

			local var_16_12 = 0.001

			if var_16_9 <= arg_13_1.time_ and arg_13_1.time_ < var_16_9 + var_16_12 then
				local var_16_13 = (arg_13_1.time_ - var_16_9) / var_16_12
				local var_16_14 = Vector3.New(0, -2000, -40)

				var_16_8.localPosition = Vector3.Lerp(arg_13_1.var_.moveOldPos1060, var_16_14, var_16_13)
			end

			if arg_13_1.time_ >= var_16_9 + var_16_12 and arg_13_1.time_ < var_16_9 + var_16_12 + arg_16_0 then
				var_16_8.localPosition = Vector3.New(0, -2000, -40)
			end

			local var_16_15 = arg_13_1.actors_["10062"].transform
			local var_16_16 = 0

			if var_16_16 < arg_13_1.time_ and arg_13_1.time_ <= var_16_16 + arg_16_0 then
				arg_13_1.var_.moveOldPos10062 = var_16_15.localPosition
				var_16_15.localScale = Vector3.New(1, 1, 1)

				arg_13_1:CheckSpriteTmpPos("10062", 7)

				local var_16_17 = var_16_15.childCount

				for iter_16_5 = 0, var_16_17 - 1 do
					local var_16_18 = var_16_15:GetChild(iter_16_5)

					if var_16_18.name == "" or not string.find(var_16_18.name, "split") then
						var_16_18.gameObject:SetActive(true)
					else
						var_16_18.gameObject:SetActive(false)
					end
				end
			end

			local var_16_19 = 0.001

			if var_16_16 <= arg_13_1.time_ and arg_13_1.time_ < var_16_16 + var_16_19 then
				local var_16_20 = (arg_13_1.time_ - var_16_16) / var_16_19
				local var_16_21 = Vector3.New(0, -2000, -290)

				var_16_15.localPosition = Vector3.Lerp(arg_13_1.var_.moveOldPos10062, var_16_21, var_16_20)
			end

			if arg_13_1.time_ >= var_16_16 + var_16_19 and arg_13_1.time_ < var_16_16 + var_16_19 + arg_16_0 then
				var_16_15.localPosition = Vector3.New(0, -2000, -290)
			end

			local var_16_22 = 0
			local var_16_23 = 1.575

			if var_16_22 < arg_13_1.time_ and arg_13_1.time_ <= var_16_22 + arg_16_0 then
				arg_13_1.talkMaxDuration = 0
				arg_13_1.dialogCg_.alpha = 1

				arg_13_1.dialog_:SetActive(true)
				SetActive(arg_13_1.leftNameGo_, false)

				arg_13_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_13_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_13_1:RecordName(arg_13_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_13_1.iconTrs_.gameObject, false)
				arg_13_1.callingController_:SetSelectedState("normal")

				local var_16_24 = arg_13_1:GetWordFromCfg(410082003)
				local var_16_25 = arg_13_1:FormatText(var_16_24.content)

				arg_13_1.text_.text = var_16_25

				LuaForUtil.ClearLinePrefixSymbol(arg_13_1.text_)

				local var_16_26 = 63
				local var_16_27 = utf8.len(var_16_25)
				local var_16_28 = var_16_26 <= 0 and var_16_23 or var_16_23 * (var_16_27 / var_16_26)

				if var_16_28 > 0 and var_16_23 < var_16_28 then
					arg_13_1.talkMaxDuration = var_16_28

					if var_16_28 + var_16_22 > arg_13_1.duration_ then
						arg_13_1.duration_ = var_16_28 + var_16_22
					end
				end

				arg_13_1.text_.text = var_16_25
				arg_13_1.typewritter.percent = 0

				arg_13_1.typewritter:SetDirty()
				arg_13_1:ShowNextGo(false)
				arg_13_1:RecordContent(arg_13_1.text_.text)
			end

			local var_16_29 = math.max(var_16_23, arg_13_1.talkMaxDuration)

			if var_16_22 <= arg_13_1.time_ and arg_13_1.time_ < var_16_22 + var_16_29 then
				arg_13_1.typewritter.percent = (arg_13_1.time_ - var_16_22) / var_16_29

				arg_13_1.typewritter:SetDirty()
			end

			if arg_13_1.time_ >= var_16_22 + var_16_29 and arg_13_1.time_ < var_16_22 + var_16_29 + arg_16_0 then
				arg_13_1.typewritter.percent = 1

				arg_13_1.typewritter:SetDirty()
				arg_13_1:ShowNextGo(true)
			end
		end

		arg_13_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1060",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			},
			{
				assetPath = "",
				actorName = "10062",
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
	Play410082004 = function(arg_17_0, arg_17_1)
		arg_17_1.time_ = 0
		arg_17_1.frameCnt_ = 0
		arg_17_1.state_ = "playing"
		arg_17_1.curTalkId_ = 410082004
		arg_17_1.duration_ = 5

		SetActive(arg_17_1.tipsGo_, false)

		function arg_17_1.onSingleLineFinish_()
			arg_17_1.onSingleLineUpdate_ = nil
			arg_17_1.onSingleLineFinish_ = nil
			arg_17_1.state_ = "waiting"
		end

		function arg_17_1.playNext_(arg_19_0)
			if arg_19_0 == 1 then
				arg_17_0:Play410082005(arg_17_1)
			end
		end

		function arg_17_1.onSingleLineUpdate_(arg_20_0)
			local var_20_0 = 0
			local var_20_1 = 1.1

			if var_20_0 < arg_17_1.time_ and arg_17_1.time_ <= var_20_0 + arg_20_0 then
				arg_17_1.talkMaxDuration = 0
				arg_17_1.dialogCg_.alpha = 1

				arg_17_1.dialog_:SetActive(true)
				SetActive(arg_17_1.leftNameGo_, false)

				arg_17_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_17_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_17_1:RecordName(arg_17_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_17_1.iconTrs_.gameObject, false)
				arg_17_1.callingController_:SetSelectedState("normal")

				local var_20_2 = arg_17_1:GetWordFromCfg(410082004)
				local var_20_3 = arg_17_1:FormatText(var_20_2.content)

				arg_17_1.text_.text = var_20_3

				LuaForUtil.ClearLinePrefixSymbol(arg_17_1.text_)

				local var_20_4 = 44
				local var_20_5 = utf8.len(var_20_3)
				local var_20_6 = var_20_4 <= 0 and var_20_1 or var_20_1 * (var_20_5 / var_20_4)

				if var_20_6 > 0 and var_20_1 < var_20_6 then
					arg_17_1.talkMaxDuration = var_20_6

					if var_20_6 + var_20_0 > arg_17_1.duration_ then
						arg_17_1.duration_ = var_20_6 + var_20_0
					end
				end

				arg_17_1.text_.text = var_20_3
				arg_17_1.typewritter.percent = 0

				arg_17_1.typewritter:SetDirty()
				arg_17_1:ShowNextGo(false)
				arg_17_1:RecordContent(arg_17_1.text_.text)
			end

			local var_20_7 = math.max(var_20_1, arg_17_1.talkMaxDuration)

			if var_20_0 <= arg_17_1.time_ and arg_17_1.time_ < var_20_0 + var_20_7 then
				arg_17_1.typewritter.percent = (arg_17_1.time_ - var_20_0) / var_20_7

				arg_17_1.typewritter:SetDirty()
			end

			if arg_17_1.time_ >= var_20_0 + var_20_7 and arg_17_1.time_ < var_20_0 + var_20_7 + arg_20_0 then
				arg_17_1.typewritter.percent = 1

				arg_17_1.typewritter:SetDirty()
				arg_17_1:ShowNextGo(true)
			end
		end

		arg_17_1.nodeConfigList_ = {}

		arg_17_1:InitPlayNodeList()
	end,
	Play410082005 = function(arg_21_0, arg_21_1)
		arg_21_1.time_ = 0
		arg_21_1.frameCnt_ = 0
		arg_21_1.state_ = "playing"
		arg_21_1.curTalkId_ = 410082005
		arg_21_1.duration_ = 8.7

		local var_21_0 = {
			zh = 5.933,
			ja = 8.7
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
				arg_21_0:Play410082006(arg_21_1)
			end
		end

		function arg_21_1.onSingleLineUpdate_(arg_24_0)
			local var_24_0 = arg_21_1.actors_["10062"].transform
			local var_24_1 = 0

			if var_24_1 < arg_21_1.time_ and arg_21_1.time_ <= var_24_1 + arg_24_0 then
				arg_21_1.var_.moveOldPos10062 = var_24_0.localPosition
				var_24_0.localScale = Vector3.New(1, 1, 1)

				arg_21_1:CheckSpriteTmpPos("10062", 4)

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
				local var_24_6 = Vector3.New(370, -390, -290)

				var_24_0.localPosition = Vector3.Lerp(arg_21_1.var_.moveOldPos10062, var_24_6, var_24_5)
			end

			if arg_21_1.time_ >= var_24_1 + var_24_4 and arg_21_1.time_ < var_24_1 + var_24_4 + arg_24_0 then
				var_24_0.localPosition = Vector3.New(370, -390, -290)
			end

			local var_24_7 = arg_21_1.actors_["10062"]
			local var_24_8 = 0

			if var_24_8 < arg_21_1.time_ and arg_21_1.time_ <= var_24_8 + arg_24_0 and not isNil(var_24_7) and arg_21_1.var_.actorSpriteComps10062 == nil then
				arg_21_1.var_.actorSpriteComps10062 = var_24_7:GetComponentsInChildren(typeof(Image), true)
			end

			local var_24_9 = 0.034

			if var_24_8 <= arg_21_1.time_ and arg_21_1.time_ < var_24_8 + var_24_9 and not isNil(var_24_7) then
				local var_24_10 = (arg_21_1.time_ - var_24_8) / var_24_9

				if arg_21_1.var_.actorSpriteComps10062 then
					for iter_24_1, iter_24_2 in pairs(arg_21_1.var_.actorSpriteComps10062:ToTable()) do
						if iter_24_2 then
							if arg_21_1.isInRecall_ then
								local var_24_11 = Mathf.Lerp(iter_24_2.color.r, arg_21_1.hightColor1.r, var_24_10)
								local var_24_12 = Mathf.Lerp(iter_24_2.color.g, arg_21_1.hightColor1.g, var_24_10)
								local var_24_13 = Mathf.Lerp(iter_24_2.color.b, arg_21_1.hightColor1.b, var_24_10)

								iter_24_2.color = Color.New(var_24_11, var_24_12, var_24_13)
							else
								local var_24_14 = Mathf.Lerp(iter_24_2.color.r, 1, var_24_10)

								iter_24_2.color = Color.New(var_24_14, var_24_14, var_24_14)
							end
						end
					end
				end
			end

			if arg_21_1.time_ >= var_24_8 + var_24_9 and arg_21_1.time_ < var_24_8 + var_24_9 + arg_24_0 and not isNil(var_24_7) and arg_21_1.var_.actorSpriteComps10062 then
				for iter_24_3, iter_24_4 in pairs(arg_21_1.var_.actorSpriteComps10062:ToTable()) do
					if iter_24_4 then
						if arg_21_1.isInRecall_ then
							iter_24_4.color = arg_21_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_24_4.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_21_1.var_.actorSpriteComps10062 = nil
			end

			local var_24_15 = arg_21_1.actors_["1060"].transform
			local var_24_16 = 0

			if var_24_16 < arg_21_1.time_ and arg_21_1.time_ <= var_24_16 + arg_24_0 then
				arg_21_1.var_.moveOldPos1060 = var_24_15.localPosition
				var_24_15.localScale = Vector3.New(1, 1, 1)

				arg_21_1:CheckSpriteTmpPos("1060", 2)

				local var_24_17 = var_24_15.childCount

				for iter_24_5 = 0, var_24_17 - 1 do
					local var_24_18 = var_24_15:GetChild(iter_24_5)

					if var_24_18.name == "" or not string.find(var_24_18.name, "split") then
						var_24_18.gameObject:SetActive(true)
					else
						var_24_18.gameObject:SetActive(false)
					end
				end
			end

			local var_24_19 = 0.001

			if var_24_16 <= arg_21_1.time_ and arg_21_1.time_ < var_24_16 + var_24_19 then
				local var_24_20 = (arg_21_1.time_ - var_24_16) / var_24_19
				local var_24_21 = Vector3.New(-440.94, -430.8, 6.9)

				var_24_15.localPosition = Vector3.Lerp(arg_21_1.var_.moveOldPos1060, var_24_21, var_24_20)
			end

			if arg_21_1.time_ >= var_24_16 + var_24_19 and arg_21_1.time_ < var_24_16 + var_24_19 + arg_24_0 then
				var_24_15.localPosition = Vector3.New(-440.94, -430.8, 6.9)
			end

			local var_24_22 = arg_21_1.actors_["1060"]
			local var_24_23 = 0

			if var_24_23 < arg_21_1.time_ and arg_21_1.time_ <= var_24_23 + arg_24_0 and not isNil(var_24_22) and arg_21_1.var_.actorSpriteComps1060 == nil then
				arg_21_1.var_.actorSpriteComps1060 = var_24_22:GetComponentsInChildren(typeof(Image), true)
			end

			local var_24_24 = 0.034

			if var_24_23 <= arg_21_1.time_ and arg_21_1.time_ < var_24_23 + var_24_24 and not isNil(var_24_22) then
				local var_24_25 = (arg_21_1.time_ - var_24_23) / var_24_24

				if arg_21_1.var_.actorSpriteComps1060 then
					for iter_24_6, iter_24_7 in pairs(arg_21_1.var_.actorSpriteComps1060:ToTable()) do
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

			if arg_21_1.time_ >= var_24_23 + var_24_24 and arg_21_1.time_ < var_24_23 + var_24_24 + arg_24_0 and not isNil(var_24_22) and arg_21_1.var_.actorSpriteComps1060 then
				for iter_24_8, iter_24_9 in pairs(arg_21_1.var_.actorSpriteComps1060:ToTable()) do
					if iter_24_9 then
						if arg_21_1.isInRecall_ then
							iter_24_9.color = arg_21_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_24_9.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_21_1.var_.actorSpriteComps1060 = nil
			end

			local var_24_30 = 0
			local var_24_31 = 0.45

			if var_24_30 < arg_21_1.time_ and arg_21_1.time_ <= var_24_30 + arg_24_0 then
				arg_21_1.talkMaxDuration = 0
				arg_21_1.dialogCg_.alpha = 1

				arg_21_1.dialog_:SetActive(true)
				SetActive(arg_21_1.leftNameGo_, true)

				local var_24_32 = arg_21_1:FormatText(StoryNameCfg[600].name)

				arg_21_1.leftNameTxt_.text = var_24_32

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_21_1.leftNameTxt_.transform)

				arg_21_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_21_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_21_1:RecordName(arg_21_1.leftNameTxt_.text)
				SetActive(arg_21_1.iconTrs_.gameObject, false)
				arg_21_1.callingController_:SetSelectedState("normal")

				local var_24_33 = arg_21_1:GetWordFromCfg(410082005)
				local var_24_34 = arg_21_1:FormatText(var_24_33.content)

				arg_21_1.text_.text = var_24_34

				LuaForUtil.ClearLinePrefixSymbol(arg_21_1.text_)

				local var_24_35 = 18
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

				if manager.audio:GetVoiceLength("story_v_out_410082", "410082005", "story_v_out_410082.awb") ~= 0 then
					local var_24_38 = manager.audio:GetVoiceLength("story_v_out_410082", "410082005", "story_v_out_410082.awb") / 1000

					if var_24_38 + var_24_30 > arg_21_1.duration_ then
						arg_21_1.duration_ = var_24_38 + var_24_30
					end

					if var_24_33.prefab_name ~= "" and arg_21_1.actors_[var_24_33.prefab_name] ~= nil then
						local var_24_39 = LuaForUtil.PlayVoiceWithCriLipsync(arg_21_1.actors_[var_24_33.prefab_name].transform, "story_v_out_410082", "410082005", "story_v_out_410082.awb")

						arg_21_1:RecordAudio("410082005", var_24_39)
						arg_21_1:RecordAudio("410082005", var_24_39)
					else
						arg_21_1:AudioAction("play", "voice", "story_v_out_410082", "410082005", "story_v_out_410082.awb")
					end

					arg_21_1:RecordHistoryTalkVoice("story_v_out_410082", "410082005", "story_v_out_410082.awb")
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
				actorName = "10062",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			},
			{
				assetPath = "",
				actorName = "1060",
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
	Play410082006 = function(arg_25_0, arg_25_1)
		arg_25_1.time_ = 0
		arg_25_1.frameCnt_ = 0
		arg_25_1.state_ = "playing"
		arg_25_1.curTalkId_ = 410082006
		arg_25_1.duration_ = 7.33

		local var_25_0 = {
			zh = 4.9,
			ja = 7.333
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
				arg_25_0:Play410082007(arg_25_1)
			end
		end

		function arg_25_1.onSingleLineUpdate_(arg_28_0)
			local var_28_0 = arg_25_1.actors_["1060"].transform
			local var_28_1 = 0

			if var_28_1 < arg_25_1.time_ and arg_25_1.time_ <= var_28_1 + arg_28_0 then
				arg_25_1.var_.moveOldPos1060 = var_28_0.localPosition
				var_28_0.localScale = Vector3.New(1, 1, 1)

				arg_25_1:CheckSpriteTmpPos("1060", 2)

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
				local var_28_6 = Vector3.New(-440.94, -430.8, 6.9)

				var_28_0.localPosition = Vector3.Lerp(arg_25_1.var_.moveOldPos1060, var_28_6, var_28_5)
			end

			if arg_25_1.time_ >= var_28_1 + var_28_4 and arg_25_1.time_ < var_28_1 + var_28_4 + arg_28_0 then
				var_28_0.localPosition = Vector3.New(-440.94, -430.8, 6.9)
			end

			local var_28_7 = arg_25_1.actors_["1060"]
			local var_28_8 = 0

			if var_28_8 < arg_25_1.time_ and arg_25_1.time_ <= var_28_8 + arg_28_0 and not isNil(var_28_7) and arg_25_1.var_.actorSpriteComps1060 == nil then
				arg_25_1.var_.actorSpriteComps1060 = var_28_7:GetComponentsInChildren(typeof(Image), true)
			end

			local var_28_9 = 0.034

			if var_28_8 <= arg_25_1.time_ and arg_25_1.time_ < var_28_8 + var_28_9 and not isNil(var_28_7) then
				local var_28_10 = (arg_25_1.time_ - var_28_8) / var_28_9

				if arg_25_1.var_.actorSpriteComps1060 then
					for iter_28_1, iter_28_2 in pairs(arg_25_1.var_.actorSpriteComps1060:ToTable()) do
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

			if arg_25_1.time_ >= var_28_8 + var_28_9 and arg_25_1.time_ < var_28_8 + var_28_9 + arg_28_0 and not isNil(var_28_7) and arg_25_1.var_.actorSpriteComps1060 then
				for iter_28_3, iter_28_4 in pairs(arg_25_1.var_.actorSpriteComps1060:ToTable()) do
					if iter_28_4 then
						if arg_25_1.isInRecall_ then
							iter_28_4.color = arg_25_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_28_4.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_25_1.var_.actorSpriteComps1060 = nil
			end

			local var_28_15 = arg_25_1.actors_["10062"]
			local var_28_16 = 0

			if var_28_16 < arg_25_1.time_ and arg_25_1.time_ <= var_28_16 + arg_28_0 and not isNil(var_28_15) and arg_25_1.var_.actorSpriteComps10062 == nil then
				arg_25_1.var_.actorSpriteComps10062 = var_28_15:GetComponentsInChildren(typeof(Image), true)
			end

			local var_28_17 = 0.034

			if var_28_16 <= arg_25_1.time_ and arg_25_1.time_ < var_28_16 + var_28_17 and not isNil(var_28_15) then
				local var_28_18 = (arg_25_1.time_ - var_28_16) / var_28_17

				if arg_25_1.var_.actorSpriteComps10062 then
					for iter_28_5, iter_28_6 in pairs(arg_25_1.var_.actorSpriteComps10062:ToTable()) do
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

			if arg_25_1.time_ >= var_28_16 + var_28_17 and arg_25_1.time_ < var_28_16 + var_28_17 + arg_28_0 and not isNil(var_28_15) and arg_25_1.var_.actorSpriteComps10062 then
				for iter_28_7, iter_28_8 in pairs(arg_25_1.var_.actorSpriteComps10062:ToTable()) do
					if iter_28_8 then
						if arg_25_1.isInRecall_ then
							iter_28_8.color = arg_25_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_28_8.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_25_1.var_.actorSpriteComps10062 = nil
			end

			local var_28_23 = 0
			local var_28_24 = 0.5

			if var_28_23 < arg_25_1.time_ and arg_25_1.time_ <= var_28_23 + arg_28_0 then
				arg_25_1.talkMaxDuration = 0
				arg_25_1.dialogCg_.alpha = 1

				arg_25_1.dialog_:SetActive(true)
				SetActive(arg_25_1.leftNameGo_, true)

				local var_28_25 = arg_25_1:FormatText(StoryNameCfg[584].name)

				arg_25_1.leftNameTxt_.text = var_28_25

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_25_1.leftNameTxt_.transform)

				arg_25_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_25_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_25_1:RecordName(arg_25_1.leftNameTxt_.text)
				SetActive(arg_25_1.iconTrs_.gameObject, false)
				arg_25_1.callingController_:SetSelectedState("normal")

				local var_28_26 = arg_25_1:GetWordFromCfg(410082006)
				local var_28_27 = arg_25_1:FormatText(var_28_26.content)

				arg_25_1.text_.text = var_28_27

				LuaForUtil.ClearLinePrefixSymbol(arg_25_1.text_)

				local var_28_28 = 20
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

				if manager.audio:GetVoiceLength("story_v_out_410082", "410082006", "story_v_out_410082.awb") ~= 0 then
					local var_28_31 = manager.audio:GetVoiceLength("story_v_out_410082", "410082006", "story_v_out_410082.awb") / 1000

					if var_28_31 + var_28_23 > arg_25_1.duration_ then
						arg_25_1.duration_ = var_28_31 + var_28_23
					end

					if var_28_26.prefab_name ~= "" and arg_25_1.actors_[var_28_26.prefab_name] ~= nil then
						local var_28_32 = LuaForUtil.PlayVoiceWithCriLipsync(arg_25_1.actors_[var_28_26.prefab_name].transform, "story_v_out_410082", "410082006", "story_v_out_410082.awb")

						arg_25_1:RecordAudio("410082006", var_28_32)
						arg_25_1:RecordAudio("410082006", var_28_32)
					else
						arg_25_1:AudioAction("play", "voice", "story_v_out_410082", "410082006", "story_v_out_410082.awb")
					end

					arg_25_1:RecordHistoryTalkVoice("story_v_out_410082", "410082006", "story_v_out_410082.awb")
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
				actorName = "1060",
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
	Play410082007 = function(arg_29_0, arg_29_1)
		arg_29_1.time_ = 0
		arg_29_1.frameCnt_ = 0
		arg_29_1.state_ = "playing"
		arg_29_1.curTalkId_ = 410082007
		arg_29_1.duration_ = 5

		SetActive(arg_29_1.tipsGo_, false)

		function arg_29_1.onSingleLineFinish_()
			arg_29_1.onSingleLineUpdate_ = nil
			arg_29_1.onSingleLineFinish_ = nil
			arg_29_1.state_ = "waiting"
		end

		function arg_29_1.playNext_(arg_31_0)
			if arg_31_0 == 1 then
				arg_29_0:Play410082008(arg_29_1)
			end
		end

		function arg_29_1.onSingleLineUpdate_(arg_32_0)
			local var_32_0 = arg_29_1.actors_["1060"].transform
			local var_32_1 = 0

			if var_32_1 < arg_29_1.time_ and arg_29_1.time_ <= var_32_1 + arg_32_0 then
				arg_29_1.var_.moveOldPos1060 = var_32_0.localPosition
				var_32_0.localScale = Vector3.New(1, 1, 1)

				arg_29_1:CheckSpriteTmpPos("1060", 7)

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
				local var_32_6 = Vector3.New(0, -2000, -40)

				var_32_0.localPosition = Vector3.Lerp(arg_29_1.var_.moveOldPos1060, var_32_6, var_32_5)
			end

			if arg_29_1.time_ >= var_32_1 + var_32_4 and arg_29_1.time_ < var_32_1 + var_32_4 + arg_32_0 then
				var_32_0.localPosition = Vector3.New(0, -2000, -40)
			end

			local var_32_7 = arg_29_1.actors_["10062"].transform
			local var_32_8 = 0

			if var_32_8 < arg_29_1.time_ and arg_29_1.time_ <= var_32_8 + arg_32_0 then
				arg_29_1.var_.moveOldPos10062 = var_32_7.localPosition
				var_32_7.localScale = Vector3.New(1, 1, 1)

				arg_29_1:CheckSpriteTmpPos("10062", 7)

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
				local var_32_13 = Vector3.New(0, -2000, -290)

				var_32_7.localPosition = Vector3.Lerp(arg_29_1.var_.moveOldPos10062, var_32_13, var_32_12)
			end

			if arg_29_1.time_ >= var_32_8 + var_32_11 and arg_29_1.time_ < var_32_8 + var_32_11 + arg_32_0 then
				var_32_7.localPosition = Vector3.New(0, -2000, -290)
			end

			local var_32_14 = manager.ui.mainCamera.transform
			local var_32_15 = 0

			if var_32_15 < arg_29_1.time_ and arg_29_1.time_ <= var_32_15 + arg_32_0 then
				arg_29_1.var_.shakeOldPos = var_32_14.localPosition
			end

			local var_32_16 = 0.5

			if var_32_15 <= arg_29_1.time_ and arg_29_1.time_ < var_32_15 + var_32_16 then
				local var_32_17 = (arg_29_1.time_ - var_32_15) / 0.066
				local var_32_18, var_32_19 = math.modf(var_32_17)

				var_32_14.localPosition = Vector3.New(var_32_19 * 0.13, var_32_19 * 0.13, var_32_19 * 0.13) + arg_29_1.var_.shakeOldPos
			end

			if arg_29_1.time_ >= var_32_15 + var_32_16 and arg_29_1.time_ < var_32_15 + var_32_16 + arg_32_0 then
				var_32_14.localPosition = arg_29_1.var_.shakeOldPos
			end

			local var_32_20 = 0
			local var_32_21 = 1

			if var_32_20 < arg_29_1.time_ and arg_29_1.time_ <= var_32_20 + arg_32_0 then
				local var_32_22 = "play"
				local var_32_23 = "effect"

				arg_29_1:AudioAction(var_32_22, var_32_23, "se_story_122_03", "se_story_122_03_hit", "")
			end

			local var_32_24 = 0
			local var_32_25 = 1.375

			if var_32_24 < arg_29_1.time_ and arg_29_1.time_ <= var_32_24 + arg_32_0 then
				arg_29_1.talkMaxDuration = 0
				arg_29_1.dialogCg_.alpha = 1

				arg_29_1.dialog_:SetActive(true)
				SetActive(arg_29_1.leftNameGo_, false)

				arg_29_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_29_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_29_1:RecordName(arg_29_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_29_1.iconTrs_.gameObject, false)
				arg_29_1.callingController_:SetSelectedState("normal")

				local var_32_26 = arg_29_1:GetWordFromCfg(410082007)
				local var_32_27 = arg_29_1:FormatText(var_32_26.content)

				arg_29_1.text_.text = var_32_27

				LuaForUtil.ClearLinePrefixSymbol(arg_29_1.text_)

				local var_32_28 = 55
				local var_32_29 = utf8.len(var_32_27)
				local var_32_30 = var_32_28 <= 0 and var_32_25 or var_32_25 * (var_32_29 / var_32_28)

				if var_32_30 > 0 and var_32_25 < var_32_30 then
					arg_29_1.talkMaxDuration = var_32_30

					if var_32_30 + var_32_24 > arg_29_1.duration_ then
						arg_29_1.duration_ = var_32_30 + var_32_24
					end
				end

				arg_29_1.text_.text = var_32_27
				arg_29_1.typewritter.percent = 0

				arg_29_1.typewritter:SetDirty()
				arg_29_1:ShowNextGo(false)
				arg_29_1:RecordContent(arg_29_1.text_.text)
			end

			local var_32_31 = math.max(var_32_25, arg_29_1.talkMaxDuration)

			if var_32_24 <= arg_29_1.time_ and arg_29_1.time_ < var_32_24 + var_32_31 then
				arg_29_1.typewritter.percent = (arg_29_1.time_ - var_32_24) / var_32_31

				arg_29_1.typewritter:SetDirty()
			end

			if arg_29_1.time_ >= var_32_24 + var_32_31 and arg_29_1.time_ < var_32_24 + var_32_31 + arg_32_0 then
				arg_29_1.typewritter.percent = 1

				arg_29_1.typewritter:SetDirty()
				arg_29_1:ShowNextGo(true)
			end
		end

		arg_29_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1060",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			},
			{
				assetPath = "",
				actorName = "10062",
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
	Play410082008 = function(arg_33_0, arg_33_1)
		arg_33_1.time_ = 0
		arg_33_1.frameCnt_ = 0
		arg_33_1.state_ = "playing"
		arg_33_1.curTalkId_ = 410082008
		arg_33_1.duration_ = 3.83

		local var_33_0 = {
			zh = 3.833,
			ja = 3.733
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
				arg_33_0:Play410082009(arg_33_1)
			end
		end

		function arg_33_1.onSingleLineUpdate_(arg_36_0)
			local var_36_0 = arg_33_1.actors_["1060"].transform
			local var_36_1 = 0

			if var_36_1 < arg_33_1.time_ and arg_33_1.time_ <= var_36_1 + arg_36_0 then
				arg_33_1.var_.moveOldPos1060 = var_36_0.localPosition
				var_36_0.localScale = Vector3.New(1, 1, 1)

				arg_33_1:CheckSpriteTmpPos("1060", 3)

				local var_36_2 = var_36_0.childCount

				for iter_36_0 = 0, var_36_2 - 1 do
					local var_36_3 = var_36_0:GetChild(iter_36_0)

					if var_36_3.name == "split_3" or not string.find(var_36_3.name, "split") then
						var_36_3.gameObject:SetActive(true)
					else
						var_36_3.gameObject:SetActive(false)
					end
				end
			end

			local var_36_4 = 0.001

			if var_36_1 <= arg_33_1.time_ and arg_33_1.time_ < var_36_1 + var_36_4 then
				local var_36_5 = (arg_33_1.time_ - var_36_1) / var_36_4
				local var_36_6 = Vector3.New(33.4, -430.8, 6.9)

				var_36_0.localPosition = Vector3.Lerp(arg_33_1.var_.moveOldPos1060, var_36_6, var_36_5)
			end

			if arg_33_1.time_ >= var_36_1 + var_36_4 and arg_33_1.time_ < var_36_1 + var_36_4 + arg_36_0 then
				var_36_0.localPosition = Vector3.New(33.4, -430.8, 6.9)
			end

			local var_36_7 = arg_33_1.actors_["1060"]
			local var_36_8 = 0

			if var_36_8 < arg_33_1.time_ and arg_33_1.time_ <= var_36_8 + arg_36_0 and not isNil(var_36_7) and arg_33_1.var_.actorSpriteComps1060 == nil then
				arg_33_1.var_.actorSpriteComps1060 = var_36_7:GetComponentsInChildren(typeof(Image), true)
			end

			local var_36_9 = 0.034

			if var_36_8 <= arg_33_1.time_ and arg_33_1.time_ < var_36_8 + var_36_9 and not isNil(var_36_7) then
				local var_36_10 = (arg_33_1.time_ - var_36_8) / var_36_9

				if arg_33_1.var_.actorSpriteComps1060 then
					for iter_36_1, iter_36_2 in pairs(arg_33_1.var_.actorSpriteComps1060:ToTable()) do
						if iter_36_2 then
							if arg_33_1.isInRecall_ then
								local var_36_11 = Mathf.Lerp(iter_36_2.color.r, arg_33_1.hightColor1.r, var_36_10)
								local var_36_12 = Mathf.Lerp(iter_36_2.color.g, arg_33_1.hightColor1.g, var_36_10)
								local var_36_13 = Mathf.Lerp(iter_36_2.color.b, arg_33_1.hightColor1.b, var_36_10)

								iter_36_2.color = Color.New(var_36_11, var_36_12, var_36_13)
							else
								local var_36_14 = Mathf.Lerp(iter_36_2.color.r, 1, var_36_10)

								iter_36_2.color = Color.New(var_36_14, var_36_14, var_36_14)
							end
						end
					end
				end
			end

			if arg_33_1.time_ >= var_36_8 + var_36_9 and arg_33_1.time_ < var_36_8 + var_36_9 + arg_36_0 and not isNil(var_36_7) and arg_33_1.var_.actorSpriteComps1060 then
				for iter_36_3, iter_36_4 in pairs(arg_33_1.var_.actorSpriteComps1060:ToTable()) do
					if iter_36_4 then
						if arg_33_1.isInRecall_ then
							iter_36_4.color = arg_33_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_36_4.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_33_1.var_.actorSpriteComps1060 = nil
			end

			local var_36_15 = 0
			local var_36_16 = 0.325

			if var_36_15 < arg_33_1.time_ and arg_33_1.time_ <= var_36_15 + arg_36_0 then
				arg_33_1.talkMaxDuration = 0
				arg_33_1.dialogCg_.alpha = 1

				arg_33_1.dialog_:SetActive(true)
				SetActive(arg_33_1.leftNameGo_, true)

				local var_36_17 = arg_33_1:FormatText(StoryNameCfg[584].name)

				arg_33_1.leftNameTxt_.text = var_36_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_33_1.leftNameTxt_.transform)

				arg_33_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_33_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_33_1:RecordName(arg_33_1.leftNameTxt_.text)
				SetActive(arg_33_1.iconTrs_.gameObject, false)
				arg_33_1.callingController_:SetSelectedState("normal")

				local var_36_18 = arg_33_1:GetWordFromCfg(410082008)
				local var_36_19 = arg_33_1:FormatText(var_36_18.content)

				arg_33_1.text_.text = var_36_19

				LuaForUtil.ClearLinePrefixSymbol(arg_33_1.text_)

				local var_36_20 = 13
				local var_36_21 = utf8.len(var_36_19)
				local var_36_22 = var_36_20 <= 0 and var_36_16 or var_36_16 * (var_36_21 / var_36_20)

				if var_36_22 > 0 and var_36_16 < var_36_22 then
					arg_33_1.talkMaxDuration = var_36_22

					if var_36_22 + var_36_15 > arg_33_1.duration_ then
						arg_33_1.duration_ = var_36_22 + var_36_15
					end
				end

				arg_33_1.text_.text = var_36_19
				arg_33_1.typewritter.percent = 0

				arg_33_1.typewritter:SetDirty()
				arg_33_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_410082", "410082008", "story_v_out_410082.awb") ~= 0 then
					local var_36_23 = manager.audio:GetVoiceLength("story_v_out_410082", "410082008", "story_v_out_410082.awb") / 1000

					if var_36_23 + var_36_15 > arg_33_1.duration_ then
						arg_33_1.duration_ = var_36_23 + var_36_15
					end

					if var_36_18.prefab_name ~= "" and arg_33_1.actors_[var_36_18.prefab_name] ~= nil then
						local var_36_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_33_1.actors_[var_36_18.prefab_name].transform, "story_v_out_410082", "410082008", "story_v_out_410082.awb")

						arg_33_1:RecordAudio("410082008", var_36_24)
						arg_33_1:RecordAudio("410082008", var_36_24)
					else
						arg_33_1:AudioAction("play", "voice", "story_v_out_410082", "410082008", "story_v_out_410082.awb")
					end

					arg_33_1:RecordHistoryTalkVoice("story_v_out_410082", "410082008", "story_v_out_410082.awb")
				end

				arg_33_1:RecordContent(arg_33_1.text_.text)
			end

			local var_36_25 = math.max(var_36_16, arg_33_1.talkMaxDuration)

			if var_36_15 <= arg_33_1.time_ and arg_33_1.time_ < var_36_15 + var_36_25 then
				arg_33_1.typewritter.percent = (arg_33_1.time_ - var_36_15) / var_36_25

				arg_33_1.typewritter:SetDirty()
			end

			if arg_33_1.time_ >= var_36_15 + var_36_25 and arg_33_1.time_ < var_36_15 + var_36_25 + arg_36_0 then
				arg_33_1.typewritter.percent = 1

				arg_33_1.typewritter:SetDirty()
				arg_33_1:ShowNextGo(true)
			end
		end

		arg_33_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1060",
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
	Play410082009 = function(arg_37_0, arg_37_1)
		arg_37_1.time_ = 0
		arg_37_1.frameCnt_ = 0
		arg_37_1.state_ = "playing"
		arg_37_1.curTalkId_ = 410082009
		arg_37_1.duration_ = 5

		SetActive(arg_37_1.tipsGo_, false)

		function arg_37_1.onSingleLineFinish_()
			arg_37_1.onSingleLineUpdate_ = nil
			arg_37_1.onSingleLineFinish_ = nil
			arg_37_1.state_ = "waiting"
		end

		function arg_37_1.playNext_(arg_39_0)
			if arg_39_0 == 1 then
				arg_37_0:Play410082010(arg_37_1)
			end
		end

		function arg_37_1.onSingleLineUpdate_(arg_40_0)
			local var_40_0 = arg_37_1.actors_["1060"].transform
			local var_40_1 = 0

			if var_40_1 < arg_37_1.time_ and arg_37_1.time_ <= var_40_1 + arg_40_0 then
				arg_37_1.var_.moveOldPos1060 = var_40_0.localPosition
				var_40_0.localScale = Vector3.New(1, 1, 1)

				arg_37_1:CheckSpriteTmpPos("1060", 7)

				local var_40_2 = var_40_0.childCount

				for iter_40_0 = 0, var_40_2 - 1 do
					local var_40_3 = var_40_0:GetChild(iter_40_0)

					if var_40_3.name == "split_3" or not string.find(var_40_3.name, "split") then
						var_40_3.gameObject:SetActive(true)
					else
						var_40_3.gameObject:SetActive(false)
					end
				end
			end

			local var_40_4 = 0.001

			if var_40_1 <= arg_37_1.time_ and arg_37_1.time_ < var_40_1 + var_40_4 then
				local var_40_5 = (arg_37_1.time_ - var_40_1) / var_40_4
				local var_40_6 = Vector3.New(0, -2000, -40)

				var_40_0.localPosition = Vector3.Lerp(arg_37_1.var_.moveOldPos1060, var_40_6, var_40_5)
			end

			if arg_37_1.time_ >= var_40_1 + var_40_4 and arg_37_1.time_ < var_40_1 + var_40_4 + arg_40_0 then
				var_40_0.localPosition = Vector3.New(0, -2000, -40)
			end

			local var_40_7 = 0
			local var_40_8 = 0.925

			if var_40_7 < arg_37_1.time_ and arg_37_1.time_ <= var_40_7 + arg_40_0 then
				arg_37_1.talkMaxDuration = 0
				arg_37_1.dialogCg_.alpha = 1

				arg_37_1.dialog_:SetActive(true)
				SetActive(arg_37_1.leftNameGo_, false)

				arg_37_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_37_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_37_1:RecordName(arg_37_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_37_1.iconTrs_.gameObject, false)
				arg_37_1.callingController_:SetSelectedState("normal")

				local var_40_9 = arg_37_1:GetWordFromCfg(410082009)
				local var_40_10 = arg_37_1:FormatText(var_40_9.content)

				arg_37_1.text_.text = var_40_10

				LuaForUtil.ClearLinePrefixSymbol(arg_37_1.text_)

				local var_40_11 = 37
				local var_40_12 = utf8.len(var_40_10)
				local var_40_13 = var_40_11 <= 0 and var_40_8 or var_40_8 * (var_40_12 / var_40_11)

				if var_40_13 > 0 and var_40_8 < var_40_13 then
					arg_37_1.talkMaxDuration = var_40_13

					if var_40_13 + var_40_7 > arg_37_1.duration_ then
						arg_37_1.duration_ = var_40_13 + var_40_7
					end
				end

				arg_37_1.text_.text = var_40_10
				arg_37_1.typewritter.percent = 0

				arg_37_1.typewritter:SetDirty()
				arg_37_1:ShowNextGo(false)
				arg_37_1:RecordContent(arg_37_1.text_.text)
			end

			local var_40_14 = math.max(var_40_8, arg_37_1.talkMaxDuration)

			if var_40_7 <= arg_37_1.time_ and arg_37_1.time_ < var_40_7 + var_40_14 then
				arg_37_1.typewritter.percent = (arg_37_1.time_ - var_40_7) / var_40_14

				arg_37_1.typewritter:SetDirty()
			end

			if arg_37_1.time_ >= var_40_7 + var_40_14 and arg_37_1.time_ < var_40_7 + var_40_14 + arg_40_0 then
				arg_37_1.typewritter.percent = 1

				arg_37_1.typewritter:SetDirty()
				arg_37_1:ShowNextGo(true)
			end
		end

		arg_37_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1060",
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
	Play410082010 = function(arg_41_0, arg_41_1)
		arg_41_1.time_ = 0
		arg_41_1.frameCnt_ = 0
		arg_41_1.state_ = "playing"
		arg_41_1.curTalkId_ = 410082010
		arg_41_1.duration_ = 5

		SetActive(arg_41_1.tipsGo_, false)

		function arg_41_1.onSingleLineFinish_()
			arg_41_1.onSingleLineUpdate_ = nil
			arg_41_1.onSingleLineFinish_ = nil
			arg_41_1.state_ = "waiting"
		end

		function arg_41_1.playNext_(arg_43_0)
			if arg_43_0 == 1 then
				arg_41_0:Play410082011(arg_41_1)
			end
		end

		function arg_41_1.onSingleLineUpdate_(arg_44_0)
			local var_44_0 = 0
			local var_44_1 = 0.6

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

				local var_44_2 = arg_41_1:GetWordFromCfg(410082010)
				local var_44_3 = arg_41_1:FormatText(var_44_2.content)

				arg_41_1.text_.text = var_44_3

				LuaForUtil.ClearLinePrefixSymbol(arg_41_1.text_)

				local var_44_4 = 24
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
	Play410082011 = function(arg_45_0, arg_45_1)
		arg_45_1.time_ = 0
		arg_45_1.frameCnt_ = 0
		arg_45_1.state_ = "playing"
		arg_45_1.curTalkId_ = 410082011
		arg_45_1.duration_ = 4.5

		local var_45_0 = {
			zh = 2.1,
			ja = 4.5
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
				arg_45_0:Play410082012(arg_45_1)
			end
		end

		function arg_45_1.onSingleLineUpdate_(arg_48_0)
			local var_48_0 = arg_45_1.actors_["10062"].transform
			local var_48_1 = 0

			if var_48_1 < arg_45_1.time_ and arg_45_1.time_ <= var_48_1 + arg_48_0 then
				arg_45_1.var_.moveOldPos10062 = var_48_0.localPosition
				var_48_0.localScale = Vector3.New(1, 1, 1)

				arg_45_1:CheckSpriteTmpPos("10062", 3)

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
				local var_48_6 = Vector3.New(0, -390, -290)

				var_48_0.localPosition = Vector3.Lerp(arg_45_1.var_.moveOldPos10062, var_48_6, var_48_5)
			end

			if arg_45_1.time_ >= var_48_1 + var_48_4 and arg_45_1.time_ < var_48_1 + var_48_4 + arg_48_0 then
				var_48_0.localPosition = Vector3.New(0, -390, -290)
			end

			local var_48_7 = arg_45_1.actors_["10062"]
			local var_48_8 = 0

			if var_48_8 < arg_45_1.time_ and arg_45_1.time_ <= var_48_8 + arg_48_0 and not isNil(var_48_7) and arg_45_1.var_.actorSpriteComps10062 == nil then
				arg_45_1.var_.actorSpriteComps10062 = var_48_7:GetComponentsInChildren(typeof(Image), true)
			end

			local var_48_9 = 0.034

			if var_48_8 <= arg_45_1.time_ and arg_45_1.time_ < var_48_8 + var_48_9 and not isNil(var_48_7) then
				local var_48_10 = (arg_45_1.time_ - var_48_8) / var_48_9

				if arg_45_1.var_.actorSpriteComps10062 then
					for iter_48_1, iter_48_2 in pairs(arg_45_1.var_.actorSpriteComps10062:ToTable()) do
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

			if arg_45_1.time_ >= var_48_8 + var_48_9 and arg_45_1.time_ < var_48_8 + var_48_9 + arg_48_0 and not isNil(var_48_7) and arg_45_1.var_.actorSpriteComps10062 then
				for iter_48_3, iter_48_4 in pairs(arg_45_1.var_.actorSpriteComps10062:ToTable()) do
					if iter_48_4 then
						if arg_45_1.isInRecall_ then
							iter_48_4.color = arg_45_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_48_4.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_45_1.var_.actorSpriteComps10062 = nil
			end

			local var_48_15 = 0
			local var_48_16 = 0.125

			if var_48_15 < arg_45_1.time_ and arg_45_1.time_ <= var_48_15 + arg_48_0 then
				arg_45_1.talkMaxDuration = 0
				arg_45_1.dialogCg_.alpha = 1

				arg_45_1.dialog_:SetActive(true)
				SetActive(arg_45_1.leftNameGo_, true)

				local var_48_17 = arg_45_1:FormatText(StoryNameCfg[600].name)

				arg_45_1.leftNameTxt_.text = var_48_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_45_1.leftNameTxt_.transform)

				arg_45_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_45_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_45_1:RecordName(arg_45_1.leftNameTxt_.text)
				SetActive(arg_45_1.iconTrs_.gameObject, false)
				arg_45_1.callingController_:SetSelectedState("normal")

				local var_48_18 = arg_45_1:GetWordFromCfg(410082011)
				local var_48_19 = arg_45_1:FormatText(var_48_18.content)

				arg_45_1.text_.text = var_48_19

				LuaForUtil.ClearLinePrefixSymbol(arg_45_1.text_)

				local var_48_20 = 5
				local var_48_21 = utf8.len(var_48_19)
				local var_48_22 = var_48_20 <= 0 and var_48_16 or var_48_16 * (var_48_21 / var_48_20)

				if var_48_22 > 0 and var_48_16 < var_48_22 then
					arg_45_1.talkMaxDuration = var_48_22

					if var_48_22 + var_48_15 > arg_45_1.duration_ then
						arg_45_1.duration_ = var_48_22 + var_48_15
					end
				end

				arg_45_1.text_.text = var_48_19
				arg_45_1.typewritter.percent = 0

				arg_45_1.typewritter:SetDirty()
				arg_45_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_410082", "410082011", "story_v_out_410082.awb") ~= 0 then
					local var_48_23 = manager.audio:GetVoiceLength("story_v_out_410082", "410082011", "story_v_out_410082.awb") / 1000

					if var_48_23 + var_48_15 > arg_45_1.duration_ then
						arg_45_1.duration_ = var_48_23 + var_48_15
					end

					if var_48_18.prefab_name ~= "" and arg_45_1.actors_[var_48_18.prefab_name] ~= nil then
						local var_48_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_45_1.actors_[var_48_18.prefab_name].transform, "story_v_out_410082", "410082011", "story_v_out_410082.awb")

						arg_45_1:RecordAudio("410082011", var_48_24)
						arg_45_1:RecordAudio("410082011", var_48_24)
					else
						arg_45_1:AudioAction("play", "voice", "story_v_out_410082", "410082011", "story_v_out_410082.awb")
					end

					arg_45_1:RecordHistoryTalkVoice("story_v_out_410082", "410082011", "story_v_out_410082.awb")
				end

				arg_45_1:RecordContent(arg_45_1.text_.text)
			end

			local var_48_25 = math.max(var_48_16, arg_45_1.talkMaxDuration)

			if var_48_15 <= arg_45_1.time_ and arg_45_1.time_ < var_48_15 + var_48_25 then
				arg_45_1.typewritter.percent = (arg_45_1.time_ - var_48_15) / var_48_25

				arg_45_1.typewritter:SetDirty()
			end

			if arg_45_1.time_ >= var_48_15 + var_48_25 and arg_45_1.time_ < var_48_15 + var_48_25 + arg_48_0 then
				arg_45_1.typewritter.percent = 1

				arg_45_1.typewritter:SetDirty()
				arg_45_1:ShowNextGo(true)
			end
		end

		arg_45_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10062",
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
	Play410082012 = function(arg_49_0, arg_49_1)
		arg_49_1.time_ = 0
		arg_49_1.frameCnt_ = 0
		arg_49_1.state_ = "playing"
		arg_49_1.curTalkId_ = 410082012
		arg_49_1.duration_ = 7.33

		local var_49_0 = {
			zh = 3.9,
			ja = 7.333
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
				arg_49_0:Play410082013(arg_49_1)
			end
		end

		function arg_49_1.onSingleLineUpdate_(arg_52_0)
			local var_52_0 = arg_49_1.actors_["1060"].transform
			local var_52_1 = 0

			if var_52_1 < arg_49_1.time_ and arg_49_1.time_ <= var_52_1 + arg_52_0 then
				arg_49_1.var_.moveOldPos1060 = var_52_0.localPosition
				var_52_0.localScale = Vector3.New(1, 1, 1)

				arg_49_1:CheckSpriteTmpPos("1060", 2)

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
				local var_52_6 = Vector3.New(-440.94, -430.8, 6.9)

				var_52_0.localPosition = Vector3.Lerp(arg_49_1.var_.moveOldPos1060, var_52_6, var_52_5)
			end

			if arg_49_1.time_ >= var_52_1 + var_52_4 and arg_49_1.time_ < var_52_1 + var_52_4 + arg_52_0 then
				var_52_0.localPosition = Vector3.New(-440.94, -430.8, 6.9)
			end

			local var_52_7 = arg_49_1.actors_["1060"]
			local var_52_8 = 0

			if var_52_8 < arg_49_1.time_ and arg_49_1.time_ <= var_52_8 + arg_52_0 and not isNil(var_52_7) and arg_49_1.var_.actorSpriteComps1060 == nil then
				arg_49_1.var_.actorSpriteComps1060 = var_52_7:GetComponentsInChildren(typeof(Image), true)
			end

			local var_52_9 = 0.034

			if var_52_8 <= arg_49_1.time_ and arg_49_1.time_ < var_52_8 + var_52_9 and not isNil(var_52_7) then
				local var_52_10 = (arg_49_1.time_ - var_52_8) / var_52_9

				if arg_49_1.var_.actorSpriteComps1060 then
					for iter_52_1, iter_52_2 in pairs(arg_49_1.var_.actorSpriteComps1060:ToTable()) do
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

			if arg_49_1.time_ >= var_52_8 + var_52_9 and arg_49_1.time_ < var_52_8 + var_52_9 + arg_52_0 and not isNil(var_52_7) and arg_49_1.var_.actorSpriteComps1060 then
				for iter_52_3, iter_52_4 in pairs(arg_49_1.var_.actorSpriteComps1060:ToTable()) do
					if iter_52_4 then
						if arg_49_1.isInRecall_ then
							iter_52_4.color = arg_49_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_52_4.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_49_1.var_.actorSpriteComps1060 = nil
			end

			local var_52_15 = arg_49_1.actors_["10062"].transform
			local var_52_16 = 0

			if var_52_16 < arg_49_1.time_ and arg_49_1.time_ <= var_52_16 + arg_52_0 then
				arg_49_1.var_.moveOldPos10062 = var_52_15.localPosition
				var_52_15.localScale = Vector3.New(1, 1, 1)

				arg_49_1:CheckSpriteTmpPos("10062", 4)

				local var_52_17 = var_52_15.childCount

				for iter_52_5 = 0, var_52_17 - 1 do
					local var_52_18 = var_52_15:GetChild(iter_52_5)

					if var_52_18.name == "" or not string.find(var_52_18.name, "split") then
						var_52_18.gameObject:SetActive(true)
					else
						var_52_18.gameObject:SetActive(false)
					end
				end
			end

			local var_52_19 = 0.001

			if var_52_16 <= arg_49_1.time_ and arg_49_1.time_ < var_52_16 + var_52_19 then
				local var_52_20 = (arg_49_1.time_ - var_52_16) / var_52_19
				local var_52_21 = Vector3.New(370, -390, -290)

				var_52_15.localPosition = Vector3.Lerp(arg_49_1.var_.moveOldPos10062, var_52_21, var_52_20)
			end

			if arg_49_1.time_ >= var_52_16 + var_52_19 and arg_49_1.time_ < var_52_16 + var_52_19 + arg_52_0 then
				var_52_15.localPosition = Vector3.New(370, -390, -290)
			end

			local var_52_22 = arg_49_1.actors_["10062"]
			local var_52_23 = 0

			if var_52_23 < arg_49_1.time_ and arg_49_1.time_ <= var_52_23 + arg_52_0 and not isNil(var_52_22) and arg_49_1.var_.actorSpriteComps10062 == nil then
				arg_49_1.var_.actorSpriteComps10062 = var_52_22:GetComponentsInChildren(typeof(Image), true)
			end

			local var_52_24 = 0.034

			if var_52_23 <= arg_49_1.time_ and arg_49_1.time_ < var_52_23 + var_52_24 and not isNil(var_52_22) then
				local var_52_25 = (arg_49_1.time_ - var_52_23) / var_52_24

				if arg_49_1.var_.actorSpriteComps10062 then
					for iter_52_6, iter_52_7 in pairs(arg_49_1.var_.actorSpriteComps10062:ToTable()) do
						if iter_52_7 then
							if arg_49_1.isInRecall_ then
								local var_52_26 = Mathf.Lerp(iter_52_7.color.r, arg_49_1.hightColor2.r, var_52_25)
								local var_52_27 = Mathf.Lerp(iter_52_7.color.g, arg_49_1.hightColor2.g, var_52_25)
								local var_52_28 = Mathf.Lerp(iter_52_7.color.b, arg_49_1.hightColor2.b, var_52_25)

								iter_52_7.color = Color.New(var_52_26, var_52_27, var_52_28)
							else
								local var_52_29 = Mathf.Lerp(iter_52_7.color.r, 0.5, var_52_25)

								iter_52_7.color = Color.New(var_52_29, var_52_29, var_52_29)
							end
						end
					end
				end
			end

			if arg_49_1.time_ >= var_52_23 + var_52_24 and arg_49_1.time_ < var_52_23 + var_52_24 + arg_52_0 and not isNil(var_52_22) and arg_49_1.var_.actorSpriteComps10062 then
				for iter_52_8, iter_52_9 in pairs(arg_49_1.var_.actorSpriteComps10062:ToTable()) do
					if iter_52_9 then
						if arg_49_1.isInRecall_ then
							iter_52_9.color = arg_49_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_52_9.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_49_1.var_.actorSpriteComps10062 = nil
			end

			local var_52_30 = 0
			local var_52_31 = 0.275

			if var_52_30 < arg_49_1.time_ and arg_49_1.time_ <= var_52_30 + arg_52_0 then
				arg_49_1.talkMaxDuration = 0
				arg_49_1.dialogCg_.alpha = 1

				arg_49_1.dialog_:SetActive(true)
				SetActive(arg_49_1.leftNameGo_, true)

				local var_52_32 = arg_49_1:FormatText(StoryNameCfg[584].name)

				arg_49_1.leftNameTxt_.text = var_52_32

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_49_1.leftNameTxt_.transform)

				arg_49_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_49_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_49_1:RecordName(arg_49_1.leftNameTxt_.text)
				SetActive(arg_49_1.iconTrs_.gameObject, false)
				arg_49_1.callingController_:SetSelectedState("normal")

				local var_52_33 = arg_49_1:GetWordFromCfg(410082012)
				local var_52_34 = arg_49_1:FormatText(var_52_33.content)

				arg_49_1.text_.text = var_52_34

				LuaForUtil.ClearLinePrefixSymbol(arg_49_1.text_)

				local var_52_35 = 11
				local var_52_36 = utf8.len(var_52_34)
				local var_52_37 = var_52_35 <= 0 and var_52_31 or var_52_31 * (var_52_36 / var_52_35)

				if var_52_37 > 0 and var_52_31 < var_52_37 then
					arg_49_1.talkMaxDuration = var_52_37

					if var_52_37 + var_52_30 > arg_49_1.duration_ then
						arg_49_1.duration_ = var_52_37 + var_52_30
					end
				end

				arg_49_1.text_.text = var_52_34
				arg_49_1.typewritter.percent = 0

				arg_49_1.typewritter:SetDirty()
				arg_49_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_410082", "410082012", "story_v_out_410082.awb") ~= 0 then
					local var_52_38 = manager.audio:GetVoiceLength("story_v_out_410082", "410082012", "story_v_out_410082.awb") / 1000

					if var_52_38 + var_52_30 > arg_49_1.duration_ then
						arg_49_1.duration_ = var_52_38 + var_52_30
					end

					if var_52_33.prefab_name ~= "" and arg_49_1.actors_[var_52_33.prefab_name] ~= nil then
						local var_52_39 = LuaForUtil.PlayVoiceWithCriLipsync(arg_49_1.actors_[var_52_33.prefab_name].transform, "story_v_out_410082", "410082012", "story_v_out_410082.awb")

						arg_49_1:RecordAudio("410082012", var_52_39)
						arg_49_1:RecordAudio("410082012", var_52_39)
					else
						arg_49_1:AudioAction("play", "voice", "story_v_out_410082", "410082012", "story_v_out_410082.awb")
					end

					arg_49_1:RecordHistoryTalkVoice("story_v_out_410082", "410082012", "story_v_out_410082.awb")
				end

				arg_49_1:RecordContent(arg_49_1.text_.text)
			end

			local var_52_40 = math.max(var_52_31, arg_49_1.talkMaxDuration)

			if var_52_30 <= arg_49_1.time_ and arg_49_1.time_ < var_52_30 + var_52_40 then
				arg_49_1.typewritter.percent = (arg_49_1.time_ - var_52_30) / var_52_40

				arg_49_1.typewritter:SetDirty()
			end

			if arg_49_1.time_ >= var_52_30 + var_52_40 and arg_49_1.time_ < var_52_30 + var_52_40 + arg_52_0 then
				arg_49_1.typewritter.percent = 1

				arg_49_1.typewritter:SetDirty()
				arg_49_1:ShowNextGo(true)
			end
		end

		arg_49_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1060",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			},
			{
				assetPath = "",
				actorName = "10062",
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
	Play410082013 = function(arg_53_0, arg_53_1)
		arg_53_1.time_ = 0
		arg_53_1.frameCnt_ = 0
		arg_53_1.state_ = "playing"
		arg_53_1.curTalkId_ = 410082013
		arg_53_1.duration_ = 7.93

		local var_53_0 = {
			zh = 4.333,
			ja = 7.933
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
				arg_53_0:Play410082014(arg_53_1)
			end
		end

		function arg_53_1.onSingleLineUpdate_(arg_56_0)
			local var_56_0 = arg_53_1.actors_["10062"].transform
			local var_56_1 = 0

			if var_56_1 < arg_53_1.time_ and arg_53_1.time_ <= var_56_1 + arg_56_0 then
				arg_53_1.var_.moveOldPos10062 = var_56_0.localPosition
				var_56_0.localScale = Vector3.New(1, 1, 1)

				arg_53_1:CheckSpriteTmpPos("10062", 4)

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
				local var_56_6 = Vector3.New(370, -390, -290)

				var_56_0.localPosition = Vector3.Lerp(arg_53_1.var_.moveOldPos10062, var_56_6, var_56_5)
			end

			if arg_53_1.time_ >= var_56_1 + var_56_4 and arg_53_1.time_ < var_56_1 + var_56_4 + arg_56_0 then
				var_56_0.localPosition = Vector3.New(370, -390, -290)
			end

			local var_56_7 = arg_53_1.actors_["10062"]
			local var_56_8 = 0

			if var_56_8 < arg_53_1.time_ and arg_53_1.time_ <= var_56_8 + arg_56_0 and not isNil(var_56_7) and arg_53_1.var_.actorSpriteComps10062 == nil then
				arg_53_1.var_.actorSpriteComps10062 = var_56_7:GetComponentsInChildren(typeof(Image), true)
			end

			local var_56_9 = 0.034

			if var_56_8 <= arg_53_1.time_ and arg_53_1.time_ < var_56_8 + var_56_9 and not isNil(var_56_7) then
				local var_56_10 = (arg_53_1.time_ - var_56_8) / var_56_9

				if arg_53_1.var_.actorSpriteComps10062 then
					for iter_56_1, iter_56_2 in pairs(arg_53_1.var_.actorSpriteComps10062:ToTable()) do
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

			if arg_53_1.time_ >= var_56_8 + var_56_9 and arg_53_1.time_ < var_56_8 + var_56_9 + arg_56_0 and not isNil(var_56_7) and arg_53_1.var_.actorSpriteComps10062 then
				for iter_56_3, iter_56_4 in pairs(arg_53_1.var_.actorSpriteComps10062:ToTable()) do
					if iter_56_4 then
						if arg_53_1.isInRecall_ then
							iter_56_4.color = arg_53_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_56_4.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_53_1.var_.actorSpriteComps10062 = nil
			end

			local var_56_15 = arg_53_1.actors_["1060"]
			local var_56_16 = 0

			if var_56_16 < arg_53_1.time_ and arg_53_1.time_ <= var_56_16 + arg_56_0 and not isNil(var_56_15) and arg_53_1.var_.actorSpriteComps1060 == nil then
				arg_53_1.var_.actorSpriteComps1060 = var_56_15:GetComponentsInChildren(typeof(Image), true)
			end

			local var_56_17 = 0.034

			if var_56_16 <= arg_53_1.time_ and arg_53_1.time_ < var_56_16 + var_56_17 and not isNil(var_56_15) then
				local var_56_18 = (arg_53_1.time_ - var_56_16) / var_56_17

				if arg_53_1.var_.actorSpriteComps1060 then
					for iter_56_5, iter_56_6 in pairs(arg_53_1.var_.actorSpriteComps1060:ToTable()) do
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

			if arg_53_1.time_ >= var_56_16 + var_56_17 and arg_53_1.time_ < var_56_16 + var_56_17 + arg_56_0 and not isNil(var_56_15) and arg_53_1.var_.actorSpriteComps1060 then
				for iter_56_7, iter_56_8 in pairs(arg_53_1.var_.actorSpriteComps1060:ToTable()) do
					if iter_56_8 then
						if arg_53_1.isInRecall_ then
							iter_56_8.color = arg_53_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_56_8.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_53_1.var_.actorSpriteComps1060 = nil
			end

			local var_56_23 = 0
			local var_56_24 = 0.375

			if var_56_23 < arg_53_1.time_ and arg_53_1.time_ <= var_56_23 + arg_56_0 then
				arg_53_1.talkMaxDuration = 0
				arg_53_1.dialogCg_.alpha = 1

				arg_53_1.dialog_:SetActive(true)
				SetActive(arg_53_1.leftNameGo_, true)

				local var_56_25 = arg_53_1:FormatText(StoryNameCfg[600].name)

				arg_53_1.leftNameTxt_.text = var_56_25

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_53_1.leftNameTxt_.transform)

				arg_53_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_53_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_53_1:RecordName(arg_53_1.leftNameTxt_.text)
				SetActive(arg_53_1.iconTrs_.gameObject, false)
				arg_53_1.callingController_:SetSelectedState("normal")

				local var_56_26 = arg_53_1:GetWordFromCfg(410082013)
				local var_56_27 = arg_53_1:FormatText(var_56_26.content)

				arg_53_1.text_.text = var_56_27

				LuaForUtil.ClearLinePrefixSymbol(arg_53_1.text_)

				local var_56_28 = 15
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

				if manager.audio:GetVoiceLength("story_v_out_410082", "410082013", "story_v_out_410082.awb") ~= 0 then
					local var_56_31 = manager.audio:GetVoiceLength("story_v_out_410082", "410082013", "story_v_out_410082.awb") / 1000

					if var_56_31 + var_56_23 > arg_53_1.duration_ then
						arg_53_1.duration_ = var_56_31 + var_56_23
					end

					if var_56_26.prefab_name ~= "" and arg_53_1.actors_[var_56_26.prefab_name] ~= nil then
						local var_56_32 = LuaForUtil.PlayVoiceWithCriLipsync(arg_53_1.actors_[var_56_26.prefab_name].transform, "story_v_out_410082", "410082013", "story_v_out_410082.awb")

						arg_53_1:RecordAudio("410082013", var_56_32)
						arg_53_1:RecordAudio("410082013", var_56_32)
					else
						arg_53_1:AudioAction("play", "voice", "story_v_out_410082", "410082013", "story_v_out_410082.awb")
					end

					arg_53_1:RecordHistoryTalkVoice("story_v_out_410082", "410082013", "story_v_out_410082.awb")
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
				actorName = "10062",
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
	Play410082014 = function(arg_57_0, arg_57_1)
		arg_57_1.time_ = 0
		arg_57_1.frameCnt_ = 0
		arg_57_1.state_ = "playing"
		arg_57_1.curTalkId_ = 410082014
		arg_57_1.duration_ = 5

		SetActive(arg_57_1.tipsGo_, false)

		function arg_57_1.onSingleLineFinish_()
			arg_57_1.onSingleLineUpdate_ = nil
			arg_57_1.onSingleLineFinish_ = nil
			arg_57_1.state_ = "waiting"
		end

		function arg_57_1.playNext_(arg_59_0)
			if arg_59_0 == 1 then
				arg_57_0:Play410082015(arg_57_1)
			end
		end

		function arg_57_1.onSingleLineUpdate_(arg_60_0)
			local var_60_0 = arg_57_1.actors_["1060"].transform
			local var_60_1 = 0

			if var_60_1 < arg_57_1.time_ and arg_57_1.time_ <= var_60_1 + arg_60_0 then
				arg_57_1.var_.moveOldPos1060 = var_60_0.localPosition
				var_60_0.localScale = Vector3.New(1, 1, 1)

				arg_57_1:CheckSpriteTmpPos("1060", 7)

				local var_60_2 = var_60_0.childCount

				for iter_60_0 = 0, var_60_2 - 1 do
					local var_60_3 = var_60_0:GetChild(iter_60_0)

					if var_60_3.name == "" or not string.find(var_60_3.name, "split") then
						var_60_3.gameObject:SetActive(true)
					else
						var_60_3.gameObject:SetActive(false)
					end
				end
			end

			local var_60_4 = 0.001

			if var_60_1 <= arg_57_1.time_ and arg_57_1.time_ < var_60_1 + var_60_4 then
				local var_60_5 = (arg_57_1.time_ - var_60_1) / var_60_4
				local var_60_6 = Vector3.New(0, -2000, -40)

				var_60_0.localPosition = Vector3.Lerp(arg_57_1.var_.moveOldPos1060, var_60_6, var_60_5)
			end

			if arg_57_1.time_ >= var_60_1 + var_60_4 and arg_57_1.time_ < var_60_1 + var_60_4 + arg_60_0 then
				var_60_0.localPosition = Vector3.New(0, -2000, -40)
			end

			local var_60_7 = arg_57_1.actors_["10062"].transform
			local var_60_8 = 0

			if var_60_8 < arg_57_1.time_ and arg_57_1.time_ <= var_60_8 + arg_60_0 then
				arg_57_1.var_.moveOldPos10062 = var_60_7.localPosition
				var_60_7.localScale = Vector3.New(1, 1, 1)

				arg_57_1:CheckSpriteTmpPos("10062", 7)

				local var_60_9 = var_60_7.childCount

				for iter_60_1 = 0, var_60_9 - 1 do
					local var_60_10 = var_60_7:GetChild(iter_60_1)

					if var_60_10.name == "" or not string.find(var_60_10.name, "split") then
						var_60_10.gameObject:SetActive(true)
					else
						var_60_10.gameObject:SetActive(false)
					end
				end
			end

			local var_60_11 = 0.001

			if var_60_8 <= arg_57_1.time_ and arg_57_1.time_ < var_60_8 + var_60_11 then
				local var_60_12 = (arg_57_1.time_ - var_60_8) / var_60_11
				local var_60_13 = Vector3.New(0, -2000, -290)

				var_60_7.localPosition = Vector3.Lerp(arg_57_1.var_.moveOldPos10062, var_60_13, var_60_12)
			end

			if arg_57_1.time_ >= var_60_8 + var_60_11 and arg_57_1.time_ < var_60_8 + var_60_11 + arg_60_0 then
				var_60_7.localPosition = Vector3.New(0, -2000, -290)
			end

			local var_60_14 = 0
			local var_60_15 = 1.225

			if var_60_14 < arg_57_1.time_ and arg_57_1.time_ <= var_60_14 + arg_60_0 then
				arg_57_1.talkMaxDuration = 0
				arg_57_1.dialogCg_.alpha = 1

				arg_57_1.dialog_:SetActive(true)
				SetActive(arg_57_1.leftNameGo_, false)

				arg_57_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_57_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_57_1:RecordName(arg_57_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_57_1.iconTrs_.gameObject, false)
				arg_57_1.callingController_:SetSelectedState("normal")

				local var_60_16 = arg_57_1:GetWordFromCfg(410082014)
				local var_60_17 = arg_57_1:FormatText(var_60_16.content)

				arg_57_1.text_.text = var_60_17

				LuaForUtil.ClearLinePrefixSymbol(arg_57_1.text_)

				local var_60_18 = 49
				local var_60_19 = utf8.len(var_60_17)
				local var_60_20 = var_60_18 <= 0 and var_60_15 or var_60_15 * (var_60_19 / var_60_18)

				if var_60_20 > 0 and var_60_15 < var_60_20 then
					arg_57_1.talkMaxDuration = var_60_20

					if var_60_20 + var_60_14 > arg_57_1.duration_ then
						arg_57_1.duration_ = var_60_20 + var_60_14
					end
				end

				arg_57_1.text_.text = var_60_17
				arg_57_1.typewritter.percent = 0

				arg_57_1.typewritter:SetDirty()
				arg_57_1:ShowNextGo(false)
				arg_57_1:RecordContent(arg_57_1.text_.text)
			end

			local var_60_21 = math.max(var_60_15, arg_57_1.talkMaxDuration)

			if var_60_14 <= arg_57_1.time_ and arg_57_1.time_ < var_60_14 + var_60_21 then
				arg_57_1.typewritter.percent = (arg_57_1.time_ - var_60_14) / var_60_21

				arg_57_1.typewritter:SetDirty()
			end

			if arg_57_1.time_ >= var_60_14 + var_60_21 and arg_57_1.time_ < var_60_14 + var_60_21 + arg_60_0 then
				arg_57_1.typewritter.percent = 1

				arg_57_1.typewritter:SetDirty()
				arg_57_1:ShowNextGo(true)
			end
		end

		arg_57_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1060",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			},
			{
				assetPath = "",
				actorName = "10062",
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
	Play410082015 = function(arg_61_0, arg_61_1)
		arg_61_1.time_ = 0
		arg_61_1.frameCnt_ = 0
		arg_61_1.state_ = "playing"
		arg_61_1.curTalkId_ = 410082015
		arg_61_1.duration_ = 5

		SetActive(arg_61_1.tipsGo_, false)

		function arg_61_1.onSingleLineFinish_()
			arg_61_1.onSingleLineUpdate_ = nil
			arg_61_1.onSingleLineFinish_ = nil
			arg_61_1.state_ = "waiting"
		end

		function arg_61_1.playNext_(arg_63_0)
			if arg_63_0 == 1 then
				arg_61_0:Play410082016(arg_61_1)
			end
		end

		function arg_61_1.onSingleLineUpdate_(arg_64_0)
			local var_64_0 = 0
			local var_64_1 = 1.025

			if var_64_0 < arg_61_1.time_ and arg_61_1.time_ <= var_64_0 + arg_64_0 then
				arg_61_1.talkMaxDuration = 0
				arg_61_1.dialogCg_.alpha = 1

				arg_61_1.dialog_:SetActive(true)
				SetActive(arg_61_1.leftNameGo_, false)

				arg_61_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_61_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_61_1:RecordName(arg_61_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_61_1.iconTrs_.gameObject, false)
				arg_61_1.callingController_:SetSelectedState("normal")

				local var_64_2 = arg_61_1:GetWordFromCfg(410082015)
				local var_64_3 = arg_61_1:FormatText(var_64_2.content)

				arg_61_1.text_.text = var_64_3

				LuaForUtil.ClearLinePrefixSymbol(arg_61_1.text_)

				local var_64_4 = 41
				local var_64_5 = utf8.len(var_64_3)
				local var_64_6 = var_64_4 <= 0 and var_64_1 or var_64_1 * (var_64_5 / var_64_4)

				if var_64_6 > 0 and var_64_1 < var_64_6 then
					arg_61_1.talkMaxDuration = var_64_6

					if var_64_6 + var_64_0 > arg_61_1.duration_ then
						arg_61_1.duration_ = var_64_6 + var_64_0
					end
				end

				arg_61_1.text_.text = var_64_3
				arg_61_1.typewritter.percent = 0

				arg_61_1.typewritter:SetDirty()
				arg_61_1:ShowNextGo(false)
				arg_61_1:RecordContent(arg_61_1.text_.text)
			end

			local var_64_7 = math.max(var_64_1, arg_61_1.talkMaxDuration)

			if var_64_0 <= arg_61_1.time_ and arg_61_1.time_ < var_64_0 + var_64_7 then
				arg_61_1.typewritter.percent = (arg_61_1.time_ - var_64_0) / var_64_7

				arg_61_1.typewritter:SetDirty()
			end

			if arg_61_1.time_ >= var_64_0 + var_64_7 and arg_61_1.time_ < var_64_0 + var_64_7 + arg_64_0 then
				arg_61_1.typewritter.percent = 1

				arg_61_1.typewritter:SetDirty()
				arg_61_1:ShowNextGo(true)
			end
		end

		arg_61_1.nodeConfigList_ = {}

		arg_61_1:InitPlayNodeList()
	end,
	Play410082016 = function(arg_65_0, arg_65_1)
		arg_65_1.time_ = 0
		arg_65_1.frameCnt_ = 0
		arg_65_1.state_ = "playing"
		arg_65_1.curTalkId_ = 410082016
		arg_65_1.duration_ = 5

		SetActive(arg_65_1.tipsGo_, false)

		function arg_65_1.onSingleLineFinish_()
			arg_65_1.onSingleLineUpdate_ = nil
			arg_65_1.onSingleLineFinish_ = nil
			arg_65_1.state_ = "waiting"
		end

		function arg_65_1.playNext_(arg_67_0)
			if arg_67_0 == 1 then
				arg_65_0:Play410082017(arg_65_1)
			end
		end

		function arg_65_1.onSingleLineUpdate_(arg_68_0)
			local var_68_0 = 0
			local var_68_1 = 1.375

			if var_68_0 < arg_65_1.time_ and arg_65_1.time_ <= var_68_0 + arg_68_0 then
				arg_65_1.talkMaxDuration = 0
				arg_65_1.dialogCg_.alpha = 1

				arg_65_1.dialog_:SetActive(true)
				SetActive(arg_65_1.leftNameGo_, false)

				arg_65_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_65_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_65_1:RecordName(arg_65_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_65_1.iconTrs_.gameObject, false)
				arg_65_1.callingController_:SetSelectedState("normal")

				local var_68_2 = arg_65_1:GetWordFromCfg(410082016)
				local var_68_3 = arg_65_1:FormatText(var_68_2.content)

				arg_65_1.text_.text = var_68_3

				LuaForUtil.ClearLinePrefixSymbol(arg_65_1.text_)

				local var_68_4 = 55
				local var_68_5 = utf8.len(var_68_3)
				local var_68_6 = var_68_4 <= 0 and var_68_1 or var_68_1 * (var_68_5 / var_68_4)

				if var_68_6 > 0 and var_68_1 < var_68_6 then
					arg_65_1.talkMaxDuration = var_68_6

					if var_68_6 + var_68_0 > arg_65_1.duration_ then
						arg_65_1.duration_ = var_68_6 + var_68_0
					end
				end

				arg_65_1.text_.text = var_68_3
				arg_65_1.typewritter.percent = 0

				arg_65_1.typewritter:SetDirty()
				arg_65_1:ShowNextGo(false)
				arg_65_1:RecordContent(arg_65_1.text_.text)
			end

			local var_68_7 = math.max(var_68_1, arg_65_1.talkMaxDuration)

			if var_68_0 <= arg_65_1.time_ and arg_65_1.time_ < var_68_0 + var_68_7 then
				arg_65_1.typewritter.percent = (arg_65_1.time_ - var_68_0) / var_68_7

				arg_65_1.typewritter:SetDirty()
			end

			if arg_65_1.time_ >= var_68_0 + var_68_7 and arg_65_1.time_ < var_68_0 + var_68_7 + arg_68_0 then
				arg_65_1.typewritter.percent = 1

				arg_65_1.typewritter:SetDirty()
				arg_65_1:ShowNextGo(true)
			end
		end

		arg_65_1.nodeConfigList_ = {}

		arg_65_1:InitPlayNodeList()
	end,
	Play410082017 = function(arg_69_0, arg_69_1)
		arg_69_1.time_ = 0
		arg_69_1.frameCnt_ = 0
		arg_69_1.state_ = "playing"
		arg_69_1.curTalkId_ = 410082017
		arg_69_1.duration_ = 5

		SetActive(arg_69_1.tipsGo_, false)

		function arg_69_1.onSingleLineFinish_()
			arg_69_1.onSingleLineUpdate_ = nil
			arg_69_1.onSingleLineFinish_ = nil
			arg_69_1.state_ = "waiting"
		end

		function arg_69_1.playNext_(arg_71_0)
			if arg_71_0 == 1 then
				arg_69_0:Play410082018(arg_69_1)
			end
		end

		function arg_69_1.onSingleLineUpdate_(arg_72_0)
			local var_72_0 = 0
			local var_72_1 = 1.3

			if var_72_0 < arg_69_1.time_ and arg_69_1.time_ <= var_72_0 + arg_72_0 then
				arg_69_1.talkMaxDuration = 0
				arg_69_1.dialogCg_.alpha = 1

				arg_69_1.dialog_:SetActive(true)
				SetActive(arg_69_1.leftNameGo_, false)

				arg_69_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_69_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_69_1:RecordName(arg_69_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_69_1.iconTrs_.gameObject, false)
				arg_69_1.callingController_:SetSelectedState("normal")

				local var_72_2 = arg_69_1:GetWordFromCfg(410082017)
				local var_72_3 = arg_69_1:FormatText(var_72_2.content)

				arg_69_1.text_.text = var_72_3

				LuaForUtil.ClearLinePrefixSymbol(arg_69_1.text_)

				local var_72_4 = 52
				local var_72_5 = utf8.len(var_72_3)
				local var_72_6 = var_72_4 <= 0 and var_72_1 or var_72_1 * (var_72_5 / var_72_4)

				if var_72_6 > 0 and var_72_1 < var_72_6 then
					arg_69_1.talkMaxDuration = var_72_6

					if var_72_6 + var_72_0 > arg_69_1.duration_ then
						arg_69_1.duration_ = var_72_6 + var_72_0
					end
				end

				arg_69_1.text_.text = var_72_3
				arg_69_1.typewritter.percent = 0

				arg_69_1.typewritter:SetDirty()
				arg_69_1:ShowNextGo(false)
				arg_69_1:RecordContent(arg_69_1.text_.text)
			end

			local var_72_7 = math.max(var_72_1, arg_69_1.talkMaxDuration)

			if var_72_0 <= arg_69_1.time_ and arg_69_1.time_ < var_72_0 + var_72_7 then
				arg_69_1.typewritter.percent = (arg_69_1.time_ - var_72_0) / var_72_7

				arg_69_1.typewritter:SetDirty()
			end

			if arg_69_1.time_ >= var_72_0 + var_72_7 and arg_69_1.time_ < var_72_0 + var_72_7 + arg_72_0 then
				arg_69_1.typewritter.percent = 1

				arg_69_1.typewritter:SetDirty()
				arg_69_1:ShowNextGo(true)
			end
		end

		arg_69_1.nodeConfigList_ = {}

		arg_69_1:InitPlayNodeList()
	end,
	Play410082018 = function(arg_73_0, arg_73_1)
		arg_73_1.time_ = 0
		arg_73_1.frameCnt_ = 0
		arg_73_1.state_ = "playing"
		arg_73_1.curTalkId_ = 410082018
		arg_73_1.duration_ = 5

		SetActive(arg_73_1.tipsGo_, false)

		function arg_73_1.onSingleLineFinish_()
			arg_73_1.onSingleLineUpdate_ = nil
			arg_73_1.onSingleLineFinish_ = nil
			arg_73_1.state_ = "waiting"
		end

		function arg_73_1.playNext_(arg_75_0)
			if arg_75_0 == 1 then
				arg_73_0:Play410082019(arg_73_1)
			end
		end

		function arg_73_1.onSingleLineUpdate_(arg_76_0)
			local var_76_0 = 0

			if var_76_0 < arg_73_1.time_ and arg_73_1.time_ <= var_76_0 + arg_76_0 then
				arg_73_1.mask_.enabled = true
				arg_73_1.mask_.raycastTarget = true

				arg_73_1:SetGaussion(false)
			end

			local var_76_1 = 0.5

			if var_76_0 <= arg_73_1.time_ and arg_73_1.time_ < var_76_0 + var_76_1 then
				local var_76_2 = (arg_73_1.time_ - var_76_0) / var_76_1
				local var_76_3 = Color.New(1, 1, 1)

				var_76_3.a = Mathf.Lerp(1, 0, var_76_2)
				arg_73_1.mask_.color = var_76_3
			end

			if arg_73_1.time_ >= var_76_0 + var_76_1 and arg_73_1.time_ < var_76_0 + var_76_1 + arg_76_0 then
				local var_76_4 = Color.New(1, 1, 1)
				local var_76_5 = 0

				arg_73_1.mask_.enabled = false
				var_76_4.a = var_76_5
				arg_73_1.mask_.color = var_76_4
			end

			local var_76_6 = manager.ui.mainCamera.transform
			local var_76_7 = 0

			if var_76_7 < arg_73_1.time_ and arg_73_1.time_ <= var_76_7 + arg_76_0 then
				arg_73_1.var_.shakeOldPos = var_76_6.localPosition
			end

			local var_76_8 = 1

			if var_76_7 <= arg_73_1.time_ and arg_73_1.time_ < var_76_7 + var_76_8 then
				local var_76_9 = (arg_73_1.time_ - var_76_7) / 0.066
				local var_76_10, var_76_11 = math.modf(var_76_9)

				var_76_6.localPosition = Vector3.New(var_76_11 * 0.13, var_76_11 * 0.13, var_76_11 * 0.13) + arg_73_1.var_.shakeOldPos
			end

			if arg_73_1.time_ >= var_76_7 + var_76_8 and arg_73_1.time_ < var_76_7 + var_76_8 + arg_76_0 then
				var_76_6.localPosition = arg_73_1.var_.shakeOldPos
			end

			local var_76_12 = 0
			local var_76_13 = 1

			if var_76_12 < arg_73_1.time_ and arg_73_1.time_ <= var_76_12 + arg_76_0 then
				local var_76_14 = "play"
				local var_76_15 = "effect"

				arg_73_1:AudioAction(var_76_14, var_76_15, "se_story_126_01", "se_story_126_01_whoosh", "")
			end

			local var_76_16 = 0
			local var_76_17 = 1.525

			if var_76_16 < arg_73_1.time_ and arg_73_1.time_ <= var_76_16 + arg_76_0 then
				arg_73_1.talkMaxDuration = 0

				arg_73_1.dialog_:SetActive(true)

				arg_73_1.dialogCg_.alpha = 0

				local var_76_18 = LeanTween.value(arg_73_1.dialog_, 0, 1, 0.3)

				var_76_18:setOnUpdate(LuaHelper.FloatAction(function(arg_77_0)
					arg_73_1.dialogCg_.alpha = arg_77_0
				end))
				var_76_18:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_73_1.dialog_)
					var_76_18:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_73_1.duration_ = arg_73_1.duration_ + 0.3

				SetActive(arg_73_1.leftNameGo_, false)

				arg_73_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_73_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_73_1:RecordName(arg_73_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_73_1.iconTrs_.gameObject, false)
				arg_73_1.callingController_:SetSelectedState("normal")

				local var_76_19 = arg_73_1:GetWordFromCfg(410082018)
				local var_76_20 = arg_73_1:FormatText(var_76_19.content)

				arg_73_1.text_.text = var_76_20

				LuaForUtil.ClearLinePrefixSymbol(arg_73_1.text_)

				local var_76_21 = 61
				local var_76_22 = utf8.len(var_76_20)
				local var_76_23 = var_76_21 <= 0 and var_76_17 or var_76_17 * (var_76_22 / var_76_21)

				if var_76_23 > 0 and var_76_17 < var_76_23 then
					arg_73_1.talkMaxDuration = var_76_23
					var_76_16 = var_76_16 + 0.3

					if var_76_23 + var_76_16 > arg_73_1.duration_ then
						arg_73_1.duration_ = var_76_23 + var_76_16
					end
				end

				arg_73_1.text_.text = var_76_20
				arg_73_1.typewritter.percent = 0

				arg_73_1.typewritter:SetDirty()
				arg_73_1:ShowNextGo(false)
				arg_73_1:RecordContent(arg_73_1.text_.text)
			end

			local var_76_24 = var_76_16 + 0.3
			local var_76_25 = math.max(var_76_17, arg_73_1.talkMaxDuration)

			if var_76_24 <= arg_73_1.time_ and arg_73_1.time_ < var_76_24 + var_76_25 then
				arg_73_1.typewritter.percent = (arg_73_1.time_ - var_76_24) / var_76_25

				arg_73_1.typewritter:SetDirty()
			end

			if arg_73_1.time_ >= var_76_24 + var_76_25 and arg_73_1.time_ < var_76_24 + var_76_25 + arg_76_0 then
				arg_73_1.typewritter.percent = 1

				arg_73_1.typewritter:SetDirty()
				arg_73_1:ShowNextGo(true)
			end
		end

		arg_73_1.nodeConfigList_ = {}

		arg_73_1:InitPlayNodeList()
	end,
	Play410082019 = function(arg_79_0, arg_79_1)
		arg_79_1.time_ = 0
		arg_79_1.frameCnt_ = 0
		arg_79_1.state_ = "playing"
		arg_79_1.curTalkId_ = 410082019
		arg_79_1.duration_ = 5

		SetActive(arg_79_1.tipsGo_, false)

		function arg_79_1.onSingleLineFinish_()
			arg_79_1.onSingleLineUpdate_ = nil
			arg_79_1.onSingleLineFinish_ = nil
			arg_79_1.state_ = "waiting"
		end

		function arg_79_1.playNext_(arg_81_0)
			if arg_81_0 == 1 then
				arg_79_0:Play410082020(arg_79_1)
			end
		end

		function arg_79_1.onSingleLineUpdate_(arg_82_0)
			local var_82_0 = 0
			local var_82_1 = 0.85

			if var_82_0 < arg_79_1.time_ and arg_79_1.time_ <= var_82_0 + arg_82_0 then
				arg_79_1.talkMaxDuration = 0
				arg_79_1.dialogCg_.alpha = 1

				arg_79_1.dialog_:SetActive(true)
				SetActive(arg_79_1.leftNameGo_, false)

				arg_79_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_79_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_79_1:RecordName(arg_79_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_79_1.iconTrs_.gameObject, false)
				arg_79_1.callingController_:SetSelectedState("normal")

				local var_82_2 = arg_79_1:GetWordFromCfg(410082019)
				local var_82_3 = arg_79_1:FormatText(var_82_2.content)

				arg_79_1.text_.text = var_82_3

				LuaForUtil.ClearLinePrefixSymbol(arg_79_1.text_)

				local var_82_4 = 34
				local var_82_5 = utf8.len(var_82_3)
				local var_82_6 = var_82_4 <= 0 and var_82_1 or var_82_1 * (var_82_5 / var_82_4)

				if var_82_6 > 0 and var_82_1 < var_82_6 then
					arg_79_1.talkMaxDuration = var_82_6

					if var_82_6 + var_82_0 > arg_79_1.duration_ then
						arg_79_1.duration_ = var_82_6 + var_82_0
					end
				end

				arg_79_1.text_.text = var_82_3
				arg_79_1.typewritter.percent = 0

				arg_79_1.typewritter:SetDirty()
				arg_79_1:ShowNextGo(false)
				arg_79_1:RecordContent(arg_79_1.text_.text)
			end

			local var_82_7 = math.max(var_82_1, arg_79_1.talkMaxDuration)

			if var_82_0 <= arg_79_1.time_ and arg_79_1.time_ < var_82_0 + var_82_7 then
				arg_79_1.typewritter.percent = (arg_79_1.time_ - var_82_0) / var_82_7

				arg_79_1.typewritter:SetDirty()
			end

			if arg_79_1.time_ >= var_82_0 + var_82_7 and arg_79_1.time_ < var_82_0 + var_82_7 + arg_82_0 then
				arg_79_1.typewritter.percent = 1

				arg_79_1.typewritter:SetDirty()
				arg_79_1:ShowNextGo(true)
			end
		end

		arg_79_1.nodeConfigList_ = {}

		arg_79_1:InitPlayNodeList()
	end,
	Play410082020 = function(arg_83_0, arg_83_1)
		arg_83_1.time_ = 0
		arg_83_1.frameCnt_ = 0
		arg_83_1.state_ = "playing"
		arg_83_1.curTalkId_ = 410082020
		arg_83_1.duration_ = 13.47

		local var_83_0 = {
			zh = 4.6,
			ja = 13.466
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
				arg_83_0:Play410082021(arg_83_1)
			end
		end

		function arg_83_1.onSingleLineUpdate_(arg_86_0)
			local var_86_0 = arg_83_1.actors_["10062"].transform
			local var_86_1 = 0

			if var_86_1 < arg_83_1.time_ and arg_83_1.time_ <= var_86_1 + arg_86_0 then
				arg_83_1.var_.moveOldPos10062 = var_86_0.localPosition
				var_86_0.localScale = Vector3.New(1, 1, 1)

				arg_83_1:CheckSpriteTmpPos("10062", 3)

				local var_86_2 = var_86_0.childCount

				for iter_86_0 = 0, var_86_2 - 1 do
					local var_86_3 = var_86_0:GetChild(iter_86_0)

					if var_86_3.name == "split_1_1" or not string.find(var_86_3.name, "split") then
						var_86_3.gameObject:SetActive(true)
					else
						var_86_3.gameObject:SetActive(false)
					end
				end
			end

			local var_86_4 = 0.001

			if var_86_1 <= arg_83_1.time_ and arg_83_1.time_ < var_86_1 + var_86_4 then
				local var_86_5 = (arg_83_1.time_ - var_86_1) / var_86_4
				local var_86_6 = Vector3.New(0, -390, -290)

				var_86_0.localPosition = Vector3.Lerp(arg_83_1.var_.moveOldPos10062, var_86_6, var_86_5)
			end

			if arg_83_1.time_ >= var_86_1 + var_86_4 and arg_83_1.time_ < var_86_1 + var_86_4 + arg_86_0 then
				var_86_0.localPosition = Vector3.New(0, -390, -290)
			end

			local var_86_7 = arg_83_1.actors_["10062"]
			local var_86_8 = 0

			if var_86_8 < arg_83_1.time_ and arg_83_1.time_ <= var_86_8 + arg_86_0 and not isNil(var_86_7) and arg_83_1.var_.actorSpriteComps10062 == nil then
				arg_83_1.var_.actorSpriteComps10062 = var_86_7:GetComponentsInChildren(typeof(Image), true)
			end

			local var_86_9 = 0.034

			if var_86_8 <= arg_83_1.time_ and arg_83_1.time_ < var_86_8 + var_86_9 and not isNil(var_86_7) then
				local var_86_10 = (arg_83_1.time_ - var_86_8) / var_86_9

				if arg_83_1.var_.actorSpriteComps10062 then
					for iter_86_1, iter_86_2 in pairs(arg_83_1.var_.actorSpriteComps10062:ToTable()) do
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

			if arg_83_1.time_ >= var_86_8 + var_86_9 and arg_83_1.time_ < var_86_8 + var_86_9 + arg_86_0 and not isNil(var_86_7) and arg_83_1.var_.actorSpriteComps10062 then
				for iter_86_3, iter_86_4 in pairs(arg_83_1.var_.actorSpriteComps10062:ToTable()) do
					if iter_86_4 then
						if arg_83_1.isInRecall_ then
							iter_86_4.color = arg_83_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_86_4.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_83_1.var_.actorSpriteComps10062 = nil
			end

			local var_86_15 = 0
			local var_86_16 = 0.5

			if var_86_15 < arg_83_1.time_ and arg_83_1.time_ <= var_86_15 + arg_86_0 then
				arg_83_1.talkMaxDuration = 0
				arg_83_1.dialogCg_.alpha = 1

				arg_83_1.dialog_:SetActive(true)
				SetActive(arg_83_1.leftNameGo_, true)

				local var_86_17 = arg_83_1:FormatText(StoryNameCfg[600].name)

				arg_83_1.leftNameTxt_.text = var_86_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_83_1.leftNameTxt_.transform)

				arg_83_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_83_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_83_1:RecordName(arg_83_1.leftNameTxt_.text)
				SetActive(arg_83_1.iconTrs_.gameObject, false)
				arg_83_1.callingController_:SetSelectedState("normal")

				local var_86_18 = arg_83_1:GetWordFromCfg(410082020)
				local var_86_19 = arg_83_1:FormatText(var_86_18.content)

				arg_83_1.text_.text = var_86_19

				LuaForUtil.ClearLinePrefixSymbol(arg_83_1.text_)

				local var_86_20 = 20
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

				if manager.audio:GetVoiceLength("story_v_out_410082", "410082020", "story_v_out_410082.awb") ~= 0 then
					local var_86_23 = manager.audio:GetVoiceLength("story_v_out_410082", "410082020", "story_v_out_410082.awb") / 1000

					if var_86_23 + var_86_15 > arg_83_1.duration_ then
						arg_83_1.duration_ = var_86_23 + var_86_15
					end

					if var_86_18.prefab_name ~= "" and arg_83_1.actors_[var_86_18.prefab_name] ~= nil then
						local var_86_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_83_1.actors_[var_86_18.prefab_name].transform, "story_v_out_410082", "410082020", "story_v_out_410082.awb")

						arg_83_1:RecordAudio("410082020", var_86_24)
						arg_83_1:RecordAudio("410082020", var_86_24)
					else
						arg_83_1:AudioAction("play", "voice", "story_v_out_410082", "410082020", "story_v_out_410082.awb")
					end

					arg_83_1:RecordHistoryTalkVoice("story_v_out_410082", "410082020", "story_v_out_410082.awb")
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
				actorName = "10062",
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
	Play410082021 = function(arg_87_0, arg_87_1)
		arg_87_1.time_ = 0
		arg_87_1.frameCnt_ = 0
		arg_87_1.state_ = "playing"
		arg_87_1.curTalkId_ = 410082021
		arg_87_1.duration_ = 8.63

		local var_87_0 = {
			zh = 6.533,
			ja = 8.633
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
				arg_87_0:Play410082022(arg_87_1)
			end
		end

		function arg_87_1.onSingleLineUpdate_(arg_90_0)
			local var_90_0 = arg_87_1.actors_["1060"].transform
			local var_90_1 = 0

			if var_90_1 < arg_87_1.time_ and arg_87_1.time_ <= var_90_1 + arg_90_0 then
				arg_87_1.var_.moveOldPos1060 = var_90_0.localPosition
				var_90_0.localScale = Vector3.New(1, 1, 1)

				arg_87_1:CheckSpriteTmpPos("1060", 2)

				local var_90_2 = var_90_0.childCount

				for iter_90_0 = 0, var_90_2 - 1 do
					local var_90_3 = var_90_0:GetChild(iter_90_0)

					if var_90_3.name == "" or not string.find(var_90_3.name, "split") then
						var_90_3.gameObject:SetActive(true)
					else
						var_90_3.gameObject:SetActive(false)
					end
				end
			end

			local var_90_4 = 0.001

			if var_90_1 <= arg_87_1.time_ and arg_87_1.time_ < var_90_1 + var_90_4 then
				local var_90_5 = (arg_87_1.time_ - var_90_1) / var_90_4
				local var_90_6 = Vector3.New(-440.94, -430.8, 6.9)

				var_90_0.localPosition = Vector3.Lerp(arg_87_1.var_.moveOldPos1060, var_90_6, var_90_5)
			end

			if arg_87_1.time_ >= var_90_1 + var_90_4 and arg_87_1.time_ < var_90_1 + var_90_4 + arg_90_0 then
				var_90_0.localPosition = Vector3.New(-440.94, -430.8, 6.9)
			end

			local var_90_7 = arg_87_1.actors_["1060"]
			local var_90_8 = 0

			if var_90_8 < arg_87_1.time_ and arg_87_1.time_ <= var_90_8 + arg_90_0 and not isNil(var_90_7) and arg_87_1.var_.actorSpriteComps1060 == nil then
				arg_87_1.var_.actorSpriteComps1060 = var_90_7:GetComponentsInChildren(typeof(Image), true)
			end

			local var_90_9 = 0.034

			if var_90_8 <= arg_87_1.time_ and arg_87_1.time_ < var_90_8 + var_90_9 and not isNil(var_90_7) then
				local var_90_10 = (arg_87_1.time_ - var_90_8) / var_90_9

				if arg_87_1.var_.actorSpriteComps1060 then
					for iter_90_1, iter_90_2 in pairs(arg_87_1.var_.actorSpriteComps1060:ToTable()) do
						if iter_90_2 then
							if arg_87_1.isInRecall_ then
								local var_90_11 = Mathf.Lerp(iter_90_2.color.r, arg_87_1.hightColor1.r, var_90_10)
								local var_90_12 = Mathf.Lerp(iter_90_2.color.g, arg_87_1.hightColor1.g, var_90_10)
								local var_90_13 = Mathf.Lerp(iter_90_2.color.b, arg_87_1.hightColor1.b, var_90_10)

								iter_90_2.color = Color.New(var_90_11, var_90_12, var_90_13)
							else
								local var_90_14 = Mathf.Lerp(iter_90_2.color.r, 1, var_90_10)

								iter_90_2.color = Color.New(var_90_14, var_90_14, var_90_14)
							end
						end
					end
				end
			end

			if arg_87_1.time_ >= var_90_8 + var_90_9 and arg_87_1.time_ < var_90_8 + var_90_9 + arg_90_0 and not isNil(var_90_7) and arg_87_1.var_.actorSpriteComps1060 then
				for iter_90_3, iter_90_4 in pairs(arg_87_1.var_.actorSpriteComps1060:ToTable()) do
					if iter_90_4 then
						if arg_87_1.isInRecall_ then
							iter_90_4.color = arg_87_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_90_4.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_87_1.var_.actorSpriteComps1060 = nil
			end

			local var_90_15 = arg_87_1.actors_["10062"].transform
			local var_90_16 = 0

			if var_90_16 < arg_87_1.time_ and arg_87_1.time_ <= var_90_16 + arg_90_0 then
				arg_87_1.var_.moveOldPos10062 = var_90_15.localPosition
				var_90_15.localScale = Vector3.New(1, 1, 1)

				arg_87_1:CheckSpriteTmpPos("10062", 4)

				local var_90_17 = var_90_15.childCount

				for iter_90_5 = 0, var_90_17 - 1 do
					local var_90_18 = var_90_15:GetChild(iter_90_5)

					if var_90_18.name == "split_1_1" or not string.find(var_90_18.name, "split") then
						var_90_18.gameObject:SetActive(true)
					else
						var_90_18.gameObject:SetActive(false)
					end
				end
			end

			local var_90_19 = 0.001

			if var_90_16 <= arg_87_1.time_ and arg_87_1.time_ < var_90_16 + var_90_19 then
				local var_90_20 = (arg_87_1.time_ - var_90_16) / var_90_19
				local var_90_21 = Vector3.New(370, -390, -290)

				var_90_15.localPosition = Vector3.Lerp(arg_87_1.var_.moveOldPos10062, var_90_21, var_90_20)
			end

			if arg_87_1.time_ >= var_90_16 + var_90_19 and arg_87_1.time_ < var_90_16 + var_90_19 + arg_90_0 then
				var_90_15.localPosition = Vector3.New(370, -390, -290)
			end

			local var_90_22 = arg_87_1.actors_["10062"]
			local var_90_23 = 0

			if var_90_23 < arg_87_1.time_ and arg_87_1.time_ <= var_90_23 + arg_90_0 and not isNil(var_90_22) and arg_87_1.var_.actorSpriteComps10062 == nil then
				arg_87_1.var_.actorSpriteComps10062 = var_90_22:GetComponentsInChildren(typeof(Image), true)
			end

			local var_90_24 = 0.034

			if var_90_23 <= arg_87_1.time_ and arg_87_1.time_ < var_90_23 + var_90_24 and not isNil(var_90_22) then
				local var_90_25 = (arg_87_1.time_ - var_90_23) / var_90_24

				if arg_87_1.var_.actorSpriteComps10062 then
					for iter_90_6, iter_90_7 in pairs(arg_87_1.var_.actorSpriteComps10062:ToTable()) do
						if iter_90_7 then
							if arg_87_1.isInRecall_ then
								local var_90_26 = Mathf.Lerp(iter_90_7.color.r, arg_87_1.hightColor2.r, var_90_25)
								local var_90_27 = Mathf.Lerp(iter_90_7.color.g, arg_87_1.hightColor2.g, var_90_25)
								local var_90_28 = Mathf.Lerp(iter_90_7.color.b, arg_87_1.hightColor2.b, var_90_25)

								iter_90_7.color = Color.New(var_90_26, var_90_27, var_90_28)
							else
								local var_90_29 = Mathf.Lerp(iter_90_7.color.r, 0.5, var_90_25)

								iter_90_7.color = Color.New(var_90_29, var_90_29, var_90_29)
							end
						end
					end
				end
			end

			if arg_87_1.time_ >= var_90_23 + var_90_24 and arg_87_1.time_ < var_90_23 + var_90_24 + arg_90_0 and not isNil(var_90_22) and arg_87_1.var_.actorSpriteComps10062 then
				for iter_90_8, iter_90_9 in pairs(arg_87_1.var_.actorSpriteComps10062:ToTable()) do
					if iter_90_9 then
						if arg_87_1.isInRecall_ then
							iter_90_9.color = arg_87_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_90_9.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_87_1.var_.actorSpriteComps10062 = nil
			end

			local var_90_30 = 0
			local var_90_31 = 0.525

			if var_90_30 < arg_87_1.time_ and arg_87_1.time_ <= var_90_30 + arg_90_0 then
				arg_87_1.talkMaxDuration = 0
				arg_87_1.dialogCg_.alpha = 1

				arg_87_1.dialog_:SetActive(true)
				SetActive(arg_87_1.leftNameGo_, true)

				local var_90_32 = arg_87_1:FormatText(StoryNameCfg[584].name)

				arg_87_1.leftNameTxt_.text = var_90_32

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_87_1.leftNameTxt_.transform)

				arg_87_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_87_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_87_1:RecordName(arg_87_1.leftNameTxt_.text)
				SetActive(arg_87_1.iconTrs_.gameObject, false)
				arg_87_1.callingController_:SetSelectedState("normal")

				local var_90_33 = arg_87_1:GetWordFromCfg(410082021)
				local var_90_34 = arg_87_1:FormatText(var_90_33.content)

				arg_87_1.text_.text = var_90_34

				LuaForUtil.ClearLinePrefixSymbol(arg_87_1.text_)

				local var_90_35 = 21
				local var_90_36 = utf8.len(var_90_34)
				local var_90_37 = var_90_35 <= 0 and var_90_31 or var_90_31 * (var_90_36 / var_90_35)

				if var_90_37 > 0 and var_90_31 < var_90_37 then
					arg_87_1.talkMaxDuration = var_90_37

					if var_90_37 + var_90_30 > arg_87_1.duration_ then
						arg_87_1.duration_ = var_90_37 + var_90_30
					end
				end

				arg_87_1.text_.text = var_90_34
				arg_87_1.typewritter.percent = 0

				arg_87_1.typewritter:SetDirty()
				arg_87_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_410082", "410082021", "story_v_out_410082.awb") ~= 0 then
					local var_90_38 = manager.audio:GetVoiceLength("story_v_out_410082", "410082021", "story_v_out_410082.awb") / 1000

					if var_90_38 + var_90_30 > arg_87_1.duration_ then
						arg_87_1.duration_ = var_90_38 + var_90_30
					end

					if var_90_33.prefab_name ~= "" and arg_87_1.actors_[var_90_33.prefab_name] ~= nil then
						local var_90_39 = LuaForUtil.PlayVoiceWithCriLipsync(arg_87_1.actors_[var_90_33.prefab_name].transform, "story_v_out_410082", "410082021", "story_v_out_410082.awb")

						arg_87_1:RecordAudio("410082021", var_90_39)
						arg_87_1:RecordAudio("410082021", var_90_39)
					else
						arg_87_1:AudioAction("play", "voice", "story_v_out_410082", "410082021", "story_v_out_410082.awb")
					end

					arg_87_1:RecordHistoryTalkVoice("story_v_out_410082", "410082021", "story_v_out_410082.awb")
				end

				arg_87_1:RecordContent(arg_87_1.text_.text)
			end

			local var_90_40 = math.max(var_90_31, arg_87_1.talkMaxDuration)

			if var_90_30 <= arg_87_1.time_ and arg_87_1.time_ < var_90_30 + var_90_40 then
				arg_87_1.typewritter.percent = (arg_87_1.time_ - var_90_30) / var_90_40

				arg_87_1.typewritter:SetDirty()
			end

			if arg_87_1.time_ >= var_90_30 + var_90_40 and arg_87_1.time_ < var_90_30 + var_90_40 + arg_90_0 then
				arg_87_1.typewritter.percent = 1

				arg_87_1.typewritter:SetDirty()
				arg_87_1:ShowNextGo(true)
			end
		end

		arg_87_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1060",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			},
			{
				assetPath = "",
				actorName = "10062",
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
	Play410082022 = function(arg_91_0, arg_91_1)
		arg_91_1.time_ = 0
		arg_91_1.frameCnt_ = 0
		arg_91_1.state_ = "playing"
		arg_91_1.curTalkId_ = 410082022
		arg_91_1.duration_ = 12.83

		local var_91_0 = {
			zh = 2.666,
			ja = 12.833
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
				arg_91_0:Play410082023(arg_91_1)
			end
		end

		function arg_91_1.onSingleLineUpdate_(arg_94_0)
			local var_94_0 = arg_91_1.actors_["10062"].transform
			local var_94_1 = 0

			if var_94_1 < arg_91_1.time_ and arg_91_1.time_ <= var_94_1 + arg_94_0 then
				arg_91_1.var_.moveOldPos10062 = var_94_0.localPosition
				var_94_0.localScale = Vector3.New(1, 1, 1)

				arg_91_1:CheckSpriteTmpPos("10062", 4)

				local var_94_2 = var_94_0.childCount

				for iter_94_0 = 0, var_94_2 - 1 do
					local var_94_3 = var_94_0:GetChild(iter_94_0)

					if var_94_3.name == "split_5" or not string.find(var_94_3.name, "split") then
						var_94_3.gameObject:SetActive(true)
					else
						var_94_3.gameObject:SetActive(false)
					end
				end
			end

			local var_94_4 = 0.001

			if var_94_1 <= arg_91_1.time_ and arg_91_1.time_ < var_94_1 + var_94_4 then
				local var_94_5 = (arg_91_1.time_ - var_94_1) / var_94_4
				local var_94_6 = Vector3.New(370, -390, -290)

				var_94_0.localPosition = Vector3.Lerp(arg_91_1.var_.moveOldPos10062, var_94_6, var_94_5)
			end

			if arg_91_1.time_ >= var_94_1 + var_94_4 and arg_91_1.time_ < var_94_1 + var_94_4 + arg_94_0 then
				var_94_0.localPosition = Vector3.New(370, -390, -290)
			end

			local var_94_7 = arg_91_1.actors_["10062"]
			local var_94_8 = 0

			if var_94_8 < arg_91_1.time_ and arg_91_1.time_ <= var_94_8 + arg_94_0 and not isNil(var_94_7) and arg_91_1.var_.actorSpriteComps10062 == nil then
				arg_91_1.var_.actorSpriteComps10062 = var_94_7:GetComponentsInChildren(typeof(Image), true)
			end

			local var_94_9 = 0.034

			if var_94_8 <= arg_91_1.time_ and arg_91_1.time_ < var_94_8 + var_94_9 and not isNil(var_94_7) then
				local var_94_10 = (arg_91_1.time_ - var_94_8) / var_94_9

				if arg_91_1.var_.actorSpriteComps10062 then
					for iter_94_1, iter_94_2 in pairs(arg_91_1.var_.actorSpriteComps10062:ToTable()) do
						if iter_94_2 then
							if arg_91_1.isInRecall_ then
								local var_94_11 = Mathf.Lerp(iter_94_2.color.r, arg_91_1.hightColor1.r, var_94_10)
								local var_94_12 = Mathf.Lerp(iter_94_2.color.g, arg_91_1.hightColor1.g, var_94_10)
								local var_94_13 = Mathf.Lerp(iter_94_2.color.b, arg_91_1.hightColor1.b, var_94_10)

								iter_94_2.color = Color.New(var_94_11, var_94_12, var_94_13)
							else
								local var_94_14 = Mathf.Lerp(iter_94_2.color.r, 1, var_94_10)

								iter_94_2.color = Color.New(var_94_14, var_94_14, var_94_14)
							end
						end
					end
				end
			end

			if arg_91_1.time_ >= var_94_8 + var_94_9 and arg_91_1.time_ < var_94_8 + var_94_9 + arg_94_0 and not isNil(var_94_7) and arg_91_1.var_.actorSpriteComps10062 then
				for iter_94_3, iter_94_4 in pairs(arg_91_1.var_.actorSpriteComps10062:ToTable()) do
					if iter_94_4 then
						if arg_91_1.isInRecall_ then
							iter_94_4.color = arg_91_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_94_4.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_91_1.var_.actorSpriteComps10062 = nil
			end

			local var_94_15 = arg_91_1.actors_["1060"]
			local var_94_16 = 0

			if var_94_16 < arg_91_1.time_ and arg_91_1.time_ <= var_94_16 + arg_94_0 and not isNil(var_94_15) and arg_91_1.var_.actorSpriteComps1060 == nil then
				arg_91_1.var_.actorSpriteComps1060 = var_94_15:GetComponentsInChildren(typeof(Image), true)
			end

			local var_94_17 = 0.034

			if var_94_16 <= arg_91_1.time_ and arg_91_1.time_ < var_94_16 + var_94_17 and not isNil(var_94_15) then
				local var_94_18 = (arg_91_1.time_ - var_94_16) / var_94_17

				if arg_91_1.var_.actorSpriteComps1060 then
					for iter_94_5, iter_94_6 in pairs(arg_91_1.var_.actorSpriteComps1060:ToTable()) do
						if iter_94_6 then
							if arg_91_1.isInRecall_ then
								local var_94_19 = Mathf.Lerp(iter_94_6.color.r, arg_91_1.hightColor2.r, var_94_18)
								local var_94_20 = Mathf.Lerp(iter_94_6.color.g, arg_91_1.hightColor2.g, var_94_18)
								local var_94_21 = Mathf.Lerp(iter_94_6.color.b, arg_91_1.hightColor2.b, var_94_18)

								iter_94_6.color = Color.New(var_94_19, var_94_20, var_94_21)
							else
								local var_94_22 = Mathf.Lerp(iter_94_6.color.r, 0.5, var_94_18)

								iter_94_6.color = Color.New(var_94_22, var_94_22, var_94_22)
							end
						end
					end
				end
			end

			if arg_91_1.time_ >= var_94_16 + var_94_17 and arg_91_1.time_ < var_94_16 + var_94_17 + arg_94_0 and not isNil(var_94_15) and arg_91_1.var_.actorSpriteComps1060 then
				for iter_94_7, iter_94_8 in pairs(arg_91_1.var_.actorSpriteComps1060:ToTable()) do
					if iter_94_8 then
						if arg_91_1.isInRecall_ then
							iter_94_8.color = arg_91_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_94_8.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_91_1.var_.actorSpriteComps1060 = nil
			end

			local var_94_23 = 0
			local var_94_24 = 0.2

			if var_94_23 < arg_91_1.time_ and arg_91_1.time_ <= var_94_23 + arg_94_0 then
				arg_91_1.talkMaxDuration = 0
				arg_91_1.dialogCg_.alpha = 1

				arg_91_1.dialog_:SetActive(true)
				SetActive(arg_91_1.leftNameGo_, true)

				local var_94_25 = arg_91_1:FormatText(StoryNameCfg[600].name)

				arg_91_1.leftNameTxt_.text = var_94_25

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_91_1.leftNameTxt_.transform)

				arg_91_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_91_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_91_1:RecordName(arg_91_1.leftNameTxt_.text)
				SetActive(arg_91_1.iconTrs_.gameObject, false)
				arg_91_1.callingController_:SetSelectedState("normal")

				local var_94_26 = arg_91_1:GetWordFromCfg(410082022)
				local var_94_27 = arg_91_1:FormatText(var_94_26.content)

				arg_91_1.text_.text = var_94_27

				LuaForUtil.ClearLinePrefixSymbol(arg_91_1.text_)

				local var_94_28 = 8
				local var_94_29 = utf8.len(var_94_27)
				local var_94_30 = var_94_28 <= 0 and var_94_24 or var_94_24 * (var_94_29 / var_94_28)

				if var_94_30 > 0 and var_94_24 < var_94_30 then
					arg_91_1.talkMaxDuration = var_94_30

					if var_94_30 + var_94_23 > arg_91_1.duration_ then
						arg_91_1.duration_ = var_94_30 + var_94_23
					end
				end

				arg_91_1.text_.text = var_94_27
				arg_91_1.typewritter.percent = 0

				arg_91_1.typewritter:SetDirty()
				arg_91_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_410082", "410082022", "story_v_out_410082.awb") ~= 0 then
					local var_94_31 = manager.audio:GetVoiceLength("story_v_out_410082", "410082022", "story_v_out_410082.awb") / 1000

					if var_94_31 + var_94_23 > arg_91_1.duration_ then
						arg_91_1.duration_ = var_94_31 + var_94_23
					end

					if var_94_26.prefab_name ~= "" and arg_91_1.actors_[var_94_26.prefab_name] ~= nil then
						local var_94_32 = LuaForUtil.PlayVoiceWithCriLipsync(arg_91_1.actors_[var_94_26.prefab_name].transform, "story_v_out_410082", "410082022", "story_v_out_410082.awb")

						arg_91_1:RecordAudio("410082022", var_94_32)
						arg_91_1:RecordAudio("410082022", var_94_32)
					else
						arg_91_1:AudioAction("play", "voice", "story_v_out_410082", "410082022", "story_v_out_410082.awb")
					end

					arg_91_1:RecordHistoryTalkVoice("story_v_out_410082", "410082022", "story_v_out_410082.awb")
				end

				arg_91_1:RecordContent(arg_91_1.text_.text)
			end

			local var_94_33 = math.max(var_94_24, arg_91_1.talkMaxDuration)

			if var_94_23 <= arg_91_1.time_ and arg_91_1.time_ < var_94_23 + var_94_33 then
				arg_91_1.typewritter.percent = (arg_91_1.time_ - var_94_23) / var_94_33

				arg_91_1.typewritter:SetDirty()
			end

			if arg_91_1.time_ >= var_94_23 + var_94_33 and arg_91_1.time_ < var_94_23 + var_94_33 + arg_94_0 then
				arg_91_1.typewritter.percent = 1

				arg_91_1.typewritter:SetDirty()
				arg_91_1:ShowNextGo(true)
			end
		end

		arg_91_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10062",
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
	Play410082023 = function(arg_95_0, arg_95_1)
		arg_95_1.time_ = 0
		arg_95_1.frameCnt_ = 0
		arg_95_1.state_ = "playing"
		arg_95_1.curTalkId_ = 410082023
		arg_95_1.duration_ = 5

		SetActive(arg_95_1.tipsGo_, false)

		function arg_95_1.onSingleLineFinish_()
			arg_95_1.onSingleLineUpdate_ = nil
			arg_95_1.onSingleLineFinish_ = nil
			arg_95_1.state_ = "waiting"
		end

		function arg_95_1.playNext_(arg_97_0)
			if arg_97_0 == 1 then
				arg_95_0:Play410082024(arg_95_1)
			end
		end

		function arg_95_1.onSingleLineUpdate_(arg_98_0)
			local var_98_0 = arg_95_1.actors_["1060"].transform
			local var_98_1 = 0

			if var_98_1 < arg_95_1.time_ and arg_95_1.time_ <= var_98_1 + arg_98_0 then
				arg_95_1.var_.moveOldPos1060 = var_98_0.localPosition
				var_98_0.localScale = Vector3.New(1, 1, 1)

				arg_95_1:CheckSpriteTmpPos("1060", 7)

				local var_98_2 = var_98_0.childCount

				for iter_98_0 = 0, var_98_2 - 1 do
					local var_98_3 = var_98_0:GetChild(iter_98_0)

					if var_98_3.name == "" or not string.find(var_98_3.name, "split") then
						var_98_3.gameObject:SetActive(true)
					else
						var_98_3.gameObject:SetActive(false)
					end
				end
			end

			local var_98_4 = 0.001

			if var_98_1 <= arg_95_1.time_ and arg_95_1.time_ < var_98_1 + var_98_4 then
				local var_98_5 = (arg_95_1.time_ - var_98_1) / var_98_4
				local var_98_6 = Vector3.New(0, -2000, -40)

				var_98_0.localPosition = Vector3.Lerp(arg_95_1.var_.moveOldPos1060, var_98_6, var_98_5)
			end

			if arg_95_1.time_ >= var_98_1 + var_98_4 and arg_95_1.time_ < var_98_1 + var_98_4 + arg_98_0 then
				var_98_0.localPosition = Vector3.New(0, -2000, -40)
			end

			local var_98_7 = arg_95_1.actors_["10062"].transform
			local var_98_8 = 0

			if var_98_8 < arg_95_1.time_ and arg_95_1.time_ <= var_98_8 + arg_98_0 then
				arg_95_1.var_.moveOldPos10062 = var_98_7.localPosition
				var_98_7.localScale = Vector3.New(1, 1, 1)

				arg_95_1:CheckSpriteTmpPos("10062", 7)

				local var_98_9 = var_98_7.childCount

				for iter_98_1 = 0, var_98_9 - 1 do
					local var_98_10 = var_98_7:GetChild(iter_98_1)

					if var_98_10.name == "split_1_1" or not string.find(var_98_10.name, "split") then
						var_98_10.gameObject:SetActive(true)
					else
						var_98_10.gameObject:SetActive(false)
					end
				end
			end

			local var_98_11 = 0.001

			if var_98_8 <= arg_95_1.time_ and arg_95_1.time_ < var_98_8 + var_98_11 then
				local var_98_12 = (arg_95_1.time_ - var_98_8) / var_98_11
				local var_98_13 = Vector3.New(0, -2000, -290)

				var_98_7.localPosition = Vector3.Lerp(arg_95_1.var_.moveOldPos10062, var_98_13, var_98_12)
			end

			if arg_95_1.time_ >= var_98_8 + var_98_11 and arg_95_1.time_ < var_98_8 + var_98_11 + arg_98_0 then
				var_98_7.localPosition = Vector3.New(0, -2000, -290)
			end

			local var_98_14 = 0
			local var_98_15 = 1.225

			if var_98_14 < arg_95_1.time_ and arg_95_1.time_ <= var_98_14 + arg_98_0 then
				arg_95_1.talkMaxDuration = 0
				arg_95_1.dialogCg_.alpha = 1

				arg_95_1.dialog_:SetActive(true)
				SetActive(arg_95_1.leftNameGo_, false)

				arg_95_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_95_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_95_1:RecordName(arg_95_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_95_1.iconTrs_.gameObject, false)
				arg_95_1.callingController_:SetSelectedState("normal")

				local var_98_16 = arg_95_1:GetWordFromCfg(410082023)
				local var_98_17 = arg_95_1:FormatText(var_98_16.content)

				arg_95_1.text_.text = var_98_17

				LuaForUtil.ClearLinePrefixSymbol(arg_95_1.text_)

				local var_98_18 = 49
				local var_98_19 = utf8.len(var_98_17)
				local var_98_20 = var_98_18 <= 0 and var_98_15 or var_98_15 * (var_98_19 / var_98_18)

				if var_98_20 > 0 and var_98_15 < var_98_20 then
					arg_95_1.talkMaxDuration = var_98_20

					if var_98_20 + var_98_14 > arg_95_1.duration_ then
						arg_95_1.duration_ = var_98_20 + var_98_14
					end
				end

				arg_95_1.text_.text = var_98_17
				arg_95_1.typewritter.percent = 0

				arg_95_1.typewritter:SetDirty()
				arg_95_1:ShowNextGo(false)
				arg_95_1:RecordContent(arg_95_1.text_.text)
			end

			local var_98_21 = math.max(var_98_15, arg_95_1.talkMaxDuration)

			if var_98_14 <= arg_95_1.time_ and arg_95_1.time_ < var_98_14 + var_98_21 then
				arg_95_1.typewritter.percent = (arg_95_1.time_ - var_98_14) / var_98_21

				arg_95_1.typewritter:SetDirty()
			end

			if arg_95_1.time_ >= var_98_14 + var_98_21 and arg_95_1.time_ < var_98_14 + var_98_21 + arg_98_0 then
				arg_95_1.typewritter.percent = 1

				arg_95_1.typewritter:SetDirty()
				arg_95_1:ShowNextGo(true)
			end
		end

		arg_95_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1060",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			},
			{
				assetPath = "",
				actorName = "10062",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_95_1:InitPlayNodeList()
	end,
	Play410082024 = function(arg_99_0, arg_99_1)
		arg_99_1.time_ = 0
		arg_99_1.frameCnt_ = 0
		arg_99_1.state_ = "playing"
		arg_99_1.curTalkId_ = 410082024
		arg_99_1.duration_ = 5

		SetActive(arg_99_1.tipsGo_, false)

		function arg_99_1.onSingleLineFinish_()
			arg_99_1.onSingleLineUpdate_ = nil
			arg_99_1.onSingleLineFinish_ = nil
			arg_99_1.state_ = "waiting"
		end

		function arg_99_1.playNext_(arg_101_0)
			if arg_101_0 == 1 then
				arg_99_0:Play410082025(arg_99_1)
			end
		end

		function arg_99_1.onSingleLineUpdate_(arg_102_0)
			local var_102_0 = 0
			local var_102_1 = 1.675

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

				local var_102_2 = arg_99_1:GetWordFromCfg(410082024)
				local var_102_3 = arg_99_1:FormatText(var_102_2.content)

				arg_99_1.text_.text = var_102_3

				LuaForUtil.ClearLinePrefixSymbol(arg_99_1.text_)

				local var_102_4 = 67
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
	Play410082025 = function(arg_103_0, arg_103_1)
		arg_103_1.time_ = 0
		arg_103_1.frameCnt_ = 0
		arg_103_1.state_ = "playing"
		arg_103_1.curTalkId_ = 410082025
		arg_103_1.duration_ = 5

		SetActive(arg_103_1.tipsGo_, false)

		function arg_103_1.onSingleLineFinish_()
			arg_103_1.onSingleLineUpdate_ = nil
			arg_103_1.onSingleLineFinish_ = nil
			arg_103_1.state_ = "waiting"
		end

		function arg_103_1.playNext_(arg_105_0)
			if arg_105_0 == 1 then
				arg_103_0:Play410082026(arg_103_1)
			end
		end

		function arg_103_1.onSingleLineUpdate_(arg_106_0)
			local var_106_0 = 0
			local var_106_1 = 0.975

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

				local var_106_2 = arg_103_1:GetWordFromCfg(410082025)
				local var_106_3 = arg_103_1:FormatText(var_106_2.content)

				arg_103_1.text_.text = var_106_3

				LuaForUtil.ClearLinePrefixSymbol(arg_103_1.text_)

				local var_106_4 = 39
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
	Play410082026 = function(arg_107_0, arg_107_1)
		arg_107_1.time_ = 0
		arg_107_1.frameCnt_ = 0
		arg_107_1.state_ = "playing"
		arg_107_1.curTalkId_ = 410082026
		arg_107_1.duration_ = 5

		SetActive(arg_107_1.tipsGo_, false)

		function arg_107_1.onSingleLineFinish_()
			arg_107_1.onSingleLineUpdate_ = nil
			arg_107_1.onSingleLineFinish_ = nil
			arg_107_1.state_ = "waiting"
		end

		function arg_107_1.playNext_(arg_109_0)
			if arg_109_0 == 1 then
				arg_107_0:Play410082027(arg_107_1)
			end
		end

		function arg_107_1.onSingleLineUpdate_(arg_110_0)
			local var_110_0 = 0
			local var_110_1 = 1.45

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

				local var_110_2 = arg_107_1:GetWordFromCfg(410082026)
				local var_110_3 = arg_107_1:FormatText(var_110_2.content)

				arg_107_1.text_.text = var_110_3

				LuaForUtil.ClearLinePrefixSymbol(arg_107_1.text_)

				local var_110_4 = 58
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
	Play410082027 = function(arg_111_0, arg_111_1)
		arg_111_1.time_ = 0
		arg_111_1.frameCnt_ = 0
		arg_111_1.state_ = "playing"
		arg_111_1.curTalkId_ = 410082027
		arg_111_1.duration_ = 5

		SetActive(arg_111_1.tipsGo_, false)

		function arg_111_1.onSingleLineFinish_()
			arg_111_1.onSingleLineUpdate_ = nil
			arg_111_1.onSingleLineFinish_ = nil
			arg_111_1.state_ = "waiting"
		end

		function arg_111_1.playNext_(arg_113_0)
			if arg_113_0 == 1 then
				arg_111_0:Play410082028(arg_111_1)
			end
		end

		function arg_111_1.onSingleLineUpdate_(arg_114_0)
			local var_114_0 = 0
			local var_114_1 = 0.875

			if var_114_0 < arg_111_1.time_ and arg_111_1.time_ <= var_114_0 + arg_114_0 then
				arg_111_1.talkMaxDuration = 0
				arg_111_1.dialogCg_.alpha = 1

				arg_111_1.dialog_:SetActive(true)
				SetActive(arg_111_1.leftNameGo_, false)

				arg_111_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_111_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_111_1:RecordName(arg_111_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_111_1.iconTrs_.gameObject, false)
				arg_111_1.callingController_:SetSelectedState("normal")

				local var_114_2 = arg_111_1:GetWordFromCfg(410082027)
				local var_114_3 = arg_111_1:FormatText(var_114_2.content)

				arg_111_1.text_.text = var_114_3

				LuaForUtil.ClearLinePrefixSymbol(arg_111_1.text_)

				local var_114_4 = 35
				local var_114_5 = utf8.len(var_114_3)
				local var_114_6 = var_114_4 <= 0 and var_114_1 or var_114_1 * (var_114_5 / var_114_4)

				if var_114_6 > 0 and var_114_1 < var_114_6 then
					arg_111_1.talkMaxDuration = var_114_6

					if var_114_6 + var_114_0 > arg_111_1.duration_ then
						arg_111_1.duration_ = var_114_6 + var_114_0
					end
				end

				arg_111_1.text_.text = var_114_3
				arg_111_1.typewritter.percent = 0

				arg_111_1.typewritter:SetDirty()
				arg_111_1:ShowNextGo(false)
				arg_111_1:RecordContent(arg_111_1.text_.text)
			end

			local var_114_7 = math.max(var_114_1, arg_111_1.talkMaxDuration)

			if var_114_0 <= arg_111_1.time_ and arg_111_1.time_ < var_114_0 + var_114_7 then
				arg_111_1.typewritter.percent = (arg_111_1.time_ - var_114_0) / var_114_7

				arg_111_1.typewritter:SetDirty()
			end

			if arg_111_1.time_ >= var_114_0 + var_114_7 and arg_111_1.time_ < var_114_0 + var_114_7 + arg_114_0 then
				arg_111_1.typewritter.percent = 1

				arg_111_1.typewritter:SetDirty()
				arg_111_1:ShowNextGo(true)
			end
		end

		arg_111_1.nodeConfigList_ = {}

		arg_111_1:InitPlayNodeList()
	end,
	Play410082028 = function(arg_115_0, arg_115_1)
		arg_115_1.time_ = 0
		arg_115_1.frameCnt_ = 0
		arg_115_1.state_ = "playing"
		arg_115_1.curTalkId_ = 410082028
		arg_115_1.duration_ = 5

		SetActive(arg_115_1.tipsGo_, false)

		function arg_115_1.onSingleLineFinish_()
			arg_115_1.onSingleLineUpdate_ = nil
			arg_115_1.onSingleLineFinish_ = nil
			arg_115_1.state_ = "waiting"
		end

		function arg_115_1.playNext_(arg_117_0)
			if arg_117_0 == 1 then
				arg_115_0:Play410082029(arg_115_1)
			end
		end

		function arg_115_1.onSingleLineUpdate_(arg_118_0)
			local var_118_0 = 0

			if var_118_0 < arg_115_1.time_ and arg_115_1.time_ <= var_118_0 + arg_118_0 then
				arg_115_1.mask_.enabled = true
				arg_115_1.mask_.raycastTarget = true

				arg_115_1:SetGaussion(false)
			end

			local var_118_1 = 0.5

			if var_118_0 <= arg_115_1.time_ and arg_115_1.time_ < var_118_0 + var_118_1 then
				local var_118_2 = (arg_115_1.time_ - var_118_0) / var_118_1
				local var_118_3 = Color.New(1, 1, 1)

				var_118_3.a = Mathf.Lerp(1, 0, var_118_2)
				arg_115_1.mask_.color = var_118_3
			end

			if arg_115_1.time_ >= var_118_0 + var_118_1 and arg_115_1.time_ < var_118_0 + var_118_1 + arg_118_0 then
				local var_118_4 = Color.New(1, 1, 1)
				local var_118_5 = 0

				arg_115_1.mask_.enabled = false
				var_118_4.a = var_118_5
				arg_115_1.mask_.color = var_118_4
			end

			local var_118_6 = manager.ui.mainCamera.transform
			local var_118_7 = 0

			if var_118_7 < arg_115_1.time_ and arg_115_1.time_ <= var_118_7 + arg_118_0 then
				arg_115_1.var_.shakeOldPos = var_118_6.localPosition
			end

			local var_118_8 = 1

			if var_118_7 <= arg_115_1.time_ and arg_115_1.time_ < var_118_7 + var_118_8 then
				local var_118_9 = (arg_115_1.time_ - var_118_7) / 0.066
				local var_118_10, var_118_11 = math.modf(var_118_9)

				var_118_6.localPosition = Vector3.New(var_118_11 * 0.13, var_118_11 * 0.13, var_118_11 * 0.13) + arg_115_1.var_.shakeOldPos
			end

			if arg_115_1.time_ >= var_118_7 + var_118_8 and arg_115_1.time_ < var_118_7 + var_118_8 + arg_118_0 then
				var_118_6.localPosition = arg_115_1.var_.shakeOldPos
			end

			local var_118_12 = 0
			local var_118_13 = 1

			if var_118_12 < arg_115_1.time_ and arg_115_1.time_ <= var_118_12 + arg_118_0 then
				local var_118_14 = "play"
				local var_118_15 = "effect"

				arg_115_1:AudioAction(var_118_14, var_118_15, "se_story_123_01", "se_story_123_01_explosion", "")
			end

			local var_118_16 = 0
			local var_118_17 = 0.075

			if var_118_16 < arg_115_1.time_ and arg_115_1.time_ <= var_118_16 + arg_118_0 then
				arg_115_1.talkMaxDuration = 0

				arg_115_1.dialog_:SetActive(true)

				arg_115_1.dialogCg_.alpha = 0

				local var_118_18 = LeanTween.value(arg_115_1.dialog_, 0, 1, 0.3)

				var_118_18:setOnUpdate(LuaHelper.FloatAction(function(arg_119_0)
					arg_115_1.dialogCg_.alpha = arg_119_0
				end))
				var_118_18:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_115_1.dialog_)
					var_118_18:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_115_1.duration_ = arg_115_1.duration_ + 0.3

				SetActive(arg_115_1.leftNameGo_, false)

				arg_115_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_115_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_115_1:RecordName(arg_115_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_115_1.iconTrs_.gameObject, false)
				arg_115_1.callingController_:SetSelectedState("normal")

				local var_118_19 = arg_115_1:GetWordFromCfg(410082028)
				local var_118_20 = arg_115_1:FormatText(var_118_19.content)

				arg_115_1.text_.text = var_118_20

				LuaForUtil.ClearLinePrefixSymbol(arg_115_1.text_)

				local var_118_21 = 3
				local var_118_22 = utf8.len(var_118_20)
				local var_118_23 = var_118_21 <= 0 and var_118_17 or var_118_17 * (var_118_22 / var_118_21)

				if var_118_23 > 0 and var_118_17 < var_118_23 then
					arg_115_1.talkMaxDuration = var_118_23
					var_118_16 = var_118_16 + 0.3

					if var_118_23 + var_118_16 > arg_115_1.duration_ then
						arg_115_1.duration_ = var_118_23 + var_118_16
					end
				end

				arg_115_1.text_.text = var_118_20
				arg_115_1.typewritter.percent = 0

				arg_115_1.typewritter:SetDirty()
				arg_115_1:ShowNextGo(false)
				arg_115_1:RecordContent(arg_115_1.text_.text)
			end

			local var_118_24 = var_118_16 + 0.3
			local var_118_25 = math.max(var_118_17, arg_115_1.talkMaxDuration)

			if var_118_24 <= arg_115_1.time_ and arg_115_1.time_ < var_118_24 + var_118_25 then
				arg_115_1.typewritter.percent = (arg_115_1.time_ - var_118_24) / var_118_25

				arg_115_1.typewritter:SetDirty()
			end

			if arg_115_1.time_ >= var_118_24 + var_118_25 and arg_115_1.time_ < var_118_24 + var_118_25 + arg_118_0 then
				arg_115_1.typewritter.percent = 1

				arg_115_1.typewritter:SetDirty()
				arg_115_1:ShowNextGo(true)
			end
		end

		arg_115_1.nodeConfigList_ = {}

		arg_115_1:InitPlayNodeList()
	end,
	Play410082029 = function(arg_121_0, arg_121_1)
		arg_121_1.time_ = 0
		arg_121_1.frameCnt_ = 0
		arg_121_1.state_ = "playing"
		arg_121_1.curTalkId_ = 410082029
		arg_121_1.duration_ = 5

		SetActive(arg_121_1.tipsGo_, false)

		function arg_121_1.onSingleLineFinish_()
			arg_121_1.onSingleLineUpdate_ = nil
			arg_121_1.onSingleLineFinish_ = nil
			arg_121_1.state_ = "waiting"
		end

		function arg_121_1.playNext_(arg_123_0)
			if arg_123_0 == 1 then
				arg_121_0:Play410082030(arg_121_1)
			end
		end

		function arg_121_1.onSingleLineUpdate_(arg_124_0)
			local var_124_0 = 0
			local var_124_1 = 1.1

			if var_124_0 < arg_121_1.time_ and arg_121_1.time_ <= var_124_0 + arg_124_0 then
				arg_121_1.talkMaxDuration = 0
				arg_121_1.dialogCg_.alpha = 1

				arg_121_1.dialog_:SetActive(true)
				SetActive(arg_121_1.leftNameGo_, false)

				arg_121_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_121_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_121_1:RecordName(arg_121_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_121_1.iconTrs_.gameObject, false)
				arg_121_1.callingController_:SetSelectedState("normal")

				local var_124_2 = arg_121_1:GetWordFromCfg(410082029)
				local var_124_3 = arg_121_1:FormatText(var_124_2.content)

				arg_121_1.text_.text = var_124_3

				LuaForUtil.ClearLinePrefixSymbol(arg_121_1.text_)

				local var_124_4 = 44
				local var_124_5 = utf8.len(var_124_3)
				local var_124_6 = var_124_4 <= 0 and var_124_1 or var_124_1 * (var_124_5 / var_124_4)

				if var_124_6 > 0 and var_124_1 < var_124_6 then
					arg_121_1.talkMaxDuration = var_124_6

					if var_124_6 + var_124_0 > arg_121_1.duration_ then
						arg_121_1.duration_ = var_124_6 + var_124_0
					end
				end

				arg_121_1.text_.text = var_124_3
				arg_121_1.typewritter.percent = 0

				arg_121_1.typewritter:SetDirty()
				arg_121_1:ShowNextGo(false)
				arg_121_1:RecordContent(arg_121_1.text_.text)
			end

			local var_124_7 = math.max(var_124_1, arg_121_1.talkMaxDuration)

			if var_124_0 <= arg_121_1.time_ and arg_121_1.time_ < var_124_0 + var_124_7 then
				arg_121_1.typewritter.percent = (arg_121_1.time_ - var_124_0) / var_124_7

				arg_121_1.typewritter:SetDirty()
			end

			if arg_121_1.time_ >= var_124_0 + var_124_7 and arg_121_1.time_ < var_124_0 + var_124_7 + arg_124_0 then
				arg_121_1.typewritter.percent = 1

				arg_121_1.typewritter:SetDirty()
				arg_121_1:ShowNextGo(true)
			end
		end

		arg_121_1.nodeConfigList_ = {}

		arg_121_1:InitPlayNodeList()
	end,
	Play410082030 = function(arg_125_0, arg_125_1)
		arg_125_1.time_ = 0
		arg_125_1.frameCnt_ = 0
		arg_125_1.state_ = "playing"
		arg_125_1.curTalkId_ = 410082030
		arg_125_1.duration_ = 5

		SetActive(arg_125_1.tipsGo_, false)

		function arg_125_1.onSingleLineFinish_()
			arg_125_1.onSingleLineUpdate_ = nil
			arg_125_1.onSingleLineFinish_ = nil
			arg_125_1.state_ = "waiting"
		end

		function arg_125_1.playNext_(arg_127_0)
			if arg_127_0 == 1 then
				arg_125_0:Play410082031(arg_125_1)
			end
		end

		function arg_125_1.onSingleLineUpdate_(arg_128_0)
			local var_128_0 = 0
			local var_128_1 = 1.375

			if var_128_0 < arg_125_1.time_ and arg_125_1.time_ <= var_128_0 + arg_128_0 then
				arg_125_1.talkMaxDuration = 0
				arg_125_1.dialogCg_.alpha = 1

				arg_125_1.dialog_:SetActive(true)
				SetActive(arg_125_1.leftNameGo_, false)

				arg_125_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_125_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_125_1:RecordName(arg_125_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_125_1.iconTrs_.gameObject, false)
				arg_125_1.callingController_:SetSelectedState("normal")

				local var_128_2 = arg_125_1:GetWordFromCfg(410082030)
				local var_128_3 = arg_125_1:FormatText(var_128_2.content)

				arg_125_1.text_.text = var_128_3

				LuaForUtil.ClearLinePrefixSymbol(arg_125_1.text_)

				local var_128_4 = 55
				local var_128_5 = utf8.len(var_128_3)
				local var_128_6 = var_128_4 <= 0 and var_128_1 or var_128_1 * (var_128_5 / var_128_4)

				if var_128_6 > 0 and var_128_1 < var_128_6 then
					arg_125_1.talkMaxDuration = var_128_6

					if var_128_6 + var_128_0 > arg_125_1.duration_ then
						arg_125_1.duration_ = var_128_6 + var_128_0
					end
				end

				arg_125_1.text_.text = var_128_3
				arg_125_1.typewritter.percent = 0

				arg_125_1.typewritter:SetDirty()
				arg_125_1:ShowNextGo(false)
				arg_125_1:RecordContent(arg_125_1.text_.text)
			end

			local var_128_7 = math.max(var_128_1, arg_125_1.talkMaxDuration)

			if var_128_0 <= arg_125_1.time_ and arg_125_1.time_ < var_128_0 + var_128_7 then
				arg_125_1.typewritter.percent = (arg_125_1.time_ - var_128_0) / var_128_7

				arg_125_1.typewritter:SetDirty()
			end

			if arg_125_1.time_ >= var_128_0 + var_128_7 and arg_125_1.time_ < var_128_0 + var_128_7 + arg_128_0 then
				arg_125_1.typewritter.percent = 1

				arg_125_1.typewritter:SetDirty()
				arg_125_1:ShowNextGo(true)
			end
		end

		arg_125_1.nodeConfigList_ = {}

		arg_125_1:InitPlayNodeList()
	end,
	Play410082031 = function(arg_129_0, arg_129_1)
		arg_129_1.time_ = 0
		arg_129_1.frameCnt_ = 0
		arg_129_1.state_ = "playing"
		arg_129_1.curTalkId_ = 410082031
		arg_129_1.duration_ = 1.73

		local var_129_0 = {
			zh = 1.466,
			ja = 1.733
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
				arg_129_0:Play410082032(arg_129_1)
			end
		end

		function arg_129_1.onSingleLineUpdate_(arg_132_0)
			local var_132_0 = arg_129_1.actors_["10062"].transform
			local var_132_1 = 0

			if var_132_1 < arg_129_1.time_ and arg_129_1.time_ <= var_132_1 + arg_132_0 then
				arg_129_1.var_.moveOldPos10062 = var_132_0.localPosition
				var_132_0.localScale = Vector3.New(1, 1, 1)

				arg_129_1:CheckSpriteTmpPos("10062", 3)

				local var_132_2 = var_132_0.childCount

				for iter_132_0 = 0, var_132_2 - 1 do
					local var_132_3 = var_132_0:GetChild(iter_132_0)

					if var_132_3.name == "" or not string.find(var_132_3.name, "split") then
						var_132_3.gameObject:SetActive(true)
					else
						var_132_3.gameObject:SetActive(false)
					end
				end
			end

			local var_132_4 = 0.001

			if var_132_1 <= arg_129_1.time_ and arg_129_1.time_ < var_132_1 + var_132_4 then
				local var_132_5 = (arg_129_1.time_ - var_132_1) / var_132_4
				local var_132_6 = Vector3.New(0, -390, -290)

				var_132_0.localPosition = Vector3.Lerp(arg_129_1.var_.moveOldPos10062, var_132_6, var_132_5)
			end

			if arg_129_1.time_ >= var_132_1 + var_132_4 and arg_129_1.time_ < var_132_1 + var_132_4 + arg_132_0 then
				var_132_0.localPosition = Vector3.New(0, -390, -290)
			end

			local var_132_7 = arg_129_1.actors_["10062"]
			local var_132_8 = 0

			if var_132_8 < arg_129_1.time_ and arg_129_1.time_ <= var_132_8 + arg_132_0 and not isNil(var_132_7) and arg_129_1.var_.actorSpriteComps10062 == nil then
				arg_129_1.var_.actorSpriteComps10062 = var_132_7:GetComponentsInChildren(typeof(Image), true)
			end

			local var_132_9 = 0.034

			if var_132_8 <= arg_129_1.time_ and arg_129_1.time_ < var_132_8 + var_132_9 and not isNil(var_132_7) then
				local var_132_10 = (arg_129_1.time_ - var_132_8) / var_132_9

				if arg_129_1.var_.actorSpriteComps10062 then
					for iter_132_1, iter_132_2 in pairs(arg_129_1.var_.actorSpriteComps10062:ToTable()) do
						if iter_132_2 then
							if arg_129_1.isInRecall_ then
								local var_132_11 = Mathf.Lerp(iter_132_2.color.r, arg_129_1.hightColor1.r, var_132_10)
								local var_132_12 = Mathf.Lerp(iter_132_2.color.g, arg_129_1.hightColor1.g, var_132_10)
								local var_132_13 = Mathf.Lerp(iter_132_2.color.b, arg_129_1.hightColor1.b, var_132_10)

								iter_132_2.color = Color.New(var_132_11, var_132_12, var_132_13)
							else
								local var_132_14 = Mathf.Lerp(iter_132_2.color.r, 1, var_132_10)

								iter_132_2.color = Color.New(var_132_14, var_132_14, var_132_14)
							end
						end
					end
				end
			end

			if arg_129_1.time_ >= var_132_8 + var_132_9 and arg_129_1.time_ < var_132_8 + var_132_9 + arg_132_0 and not isNil(var_132_7) and arg_129_1.var_.actorSpriteComps10062 then
				for iter_132_3, iter_132_4 in pairs(arg_129_1.var_.actorSpriteComps10062:ToTable()) do
					if iter_132_4 then
						if arg_129_1.isInRecall_ then
							iter_132_4.color = arg_129_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_132_4.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_129_1.var_.actorSpriteComps10062 = nil
			end

			local var_132_15 = 0
			local var_132_16 = 0.1

			if var_132_15 < arg_129_1.time_ and arg_129_1.time_ <= var_132_15 + arg_132_0 then
				arg_129_1.talkMaxDuration = 0
				arg_129_1.dialogCg_.alpha = 1

				arg_129_1.dialog_:SetActive(true)
				SetActive(arg_129_1.leftNameGo_, true)

				local var_132_17 = arg_129_1:FormatText(StoryNameCfg[600].name)

				arg_129_1.leftNameTxt_.text = var_132_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_129_1.leftNameTxt_.transform)

				arg_129_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_129_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_129_1:RecordName(arg_129_1.leftNameTxt_.text)
				SetActive(arg_129_1.iconTrs_.gameObject, false)
				arg_129_1.callingController_:SetSelectedState("normal")

				local var_132_18 = arg_129_1:GetWordFromCfg(410082031)
				local var_132_19 = arg_129_1:FormatText(var_132_18.content)

				arg_129_1.text_.text = var_132_19

				LuaForUtil.ClearLinePrefixSymbol(arg_129_1.text_)

				local var_132_20 = 4
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

				if manager.audio:GetVoiceLength("story_v_out_410082", "410082031", "story_v_out_410082.awb") ~= 0 then
					local var_132_23 = manager.audio:GetVoiceLength("story_v_out_410082", "410082031", "story_v_out_410082.awb") / 1000

					if var_132_23 + var_132_15 > arg_129_1.duration_ then
						arg_129_1.duration_ = var_132_23 + var_132_15
					end

					if var_132_18.prefab_name ~= "" and arg_129_1.actors_[var_132_18.prefab_name] ~= nil then
						local var_132_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_129_1.actors_[var_132_18.prefab_name].transform, "story_v_out_410082", "410082031", "story_v_out_410082.awb")

						arg_129_1:RecordAudio("410082031", var_132_24)
						arg_129_1:RecordAudio("410082031", var_132_24)
					else
						arg_129_1:AudioAction("play", "voice", "story_v_out_410082", "410082031", "story_v_out_410082.awb")
					end

					arg_129_1:RecordHistoryTalkVoice("story_v_out_410082", "410082031", "story_v_out_410082.awb")
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
				actorName = "10062",
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
	Play410082032 = function(arg_133_0, arg_133_1)
		arg_133_1.time_ = 0
		arg_133_1.frameCnt_ = 0
		arg_133_1.state_ = "playing"
		arg_133_1.curTalkId_ = 410082032
		arg_133_1.duration_ = 5

		SetActive(arg_133_1.tipsGo_, false)

		function arg_133_1.onSingleLineFinish_()
			arg_133_1.onSingleLineUpdate_ = nil
			arg_133_1.onSingleLineFinish_ = nil
			arg_133_1.state_ = "waiting"
		end

		function arg_133_1.playNext_(arg_135_0)
			if arg_135_0 == 1 then
				arg_133_0:Play410082033(arg_133_1)
			end
		end

		function arg_133_1.onSingleLineUpdate_(arg_136_0)
			local var_136_0 = arg_133_1.actors_["10062"]
			local var_136_1 = 0

			if var_136_1 < arg_133_1.time_ and arg_133_1.time_ <= var_136_1 + arg_136_0 and not isNil(var_136_0) and arg_133_1.var_.actorSpriteComps10062 == nil then
				arg_133_1.var_.actorSpriteComps10062 = var_136_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_136_2 = 0.034

			if var_136_1 <= arg_133_1.time_ and arg_133_1.time_ < var_136_1 + var_136_2 and not isNil(var_136_0) then
				local var_136_3 = (arg_133_1.time_ - var_136_1) / var_136_2

				if arg_133_1.var_.actorSpriteComps10062 then
					for iter_136_0, iter_136_1 in pairs(arg_133_1.var_.actorSpriteComps10062:ToTable()) do
						if iter_136_1 then
							if arg_133_1.isInRecall_ then
								local var_136_4 = Mathf.Lerp(iter_136_1.color.r, arg_133_1.hightColor2.r, var_136_3)
								local var_136_5 = Mathf.Lerp(iter_136_1.color.g, arg_133_1.hightColor2.g, var_136_3)
								local var_136_6 = Mathf.Lerp(iter_136_1.color.b, arg_133_1.hightColor2.b, var_136_3)

								iter_136_1.color = Color.New(var_136_4, var_136_5, var_136_6)
							else
								local var_136_7 = Mathf.Lerp(iter_136_1.color.r, 0.5, var_136_3)

								iter_136_1.color = Color.New(var_136_7, var_136_7, var_136_7)
							end
						end
					end
				end
			end

			if arg_133_1.time_ >= var_136_1 + var_136_2 and arg_133_1.time_ < var_136_1 + var_136_2 + arg_136_0 and not isNil(var_136_0) and arg_133_1.var_.actorSpriteComps10062 then
				for iter_136_2, iter_136_3 in pairs(arg_133_1.var_.actorSpriteComps10062:ToTable()) do
					if iter_136_3 then
						if arg_133_1.isInRecall_ then
							iter_136_3.color = arg_133_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_136_3.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_133_1.var_.actorSpriteComps10062 = nil
			end

			local var_136_8 = 0
			local var_136_9 = 0.975

			if var_136_8 < arg_133_1.time_ and arg_133_1.time_ <= var_136_8 + arg_136_0 then
				arg_133_1.talkMaxDuration = 0
				arg_133_1.dialogCg_.alpha = 1

				arg_133_1.dialog_:SetActive(true)
				SetActive(arg_133_1.leftNameGo_, false)

				arg_133_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_133_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_133_1:RecordName(arg_133_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_133_1.iconTrs_.gameObject, false)
				arg_133_1.callingController_:SetSelectedState("normal")

				local var_136_10 = arg_133_1:GetWordFromCfg(410082032)
				local var_136_11 = arg_133_1:FormatText(var_136_10.content)

				arg_133_1.text_.text = var_136_11

				LuaForUtil.ClearLinePrefixSymbol(arg_133_1.text_)

				local var_136_12 = 39
				local var_136_13 = utf8.len(var_136_11)
				local var_136_14 = var_136_12 <= 0 and var_136_9 or var_136_9 * (var_136_13 / var_136_12)

				if var_136_14 > 0 and var_136_9 < var_136_14 then
					arg_133_1.talkMaxDuration = var_136_14

					if var_136_14 + var_136_8 > arg_133_1.duration_ then
						arg_133_1.duration_ = var_136_14 + var_136_8
					end
				end

				arg_133_1.text_.text = var_136_11
				arg_133_1.typewritter.percent = 0

				arg_133_1.typewritter:SetDirty()
				arg_133_1:ShowNextGo(false)
				arg_133_1:RecordContent(arg_133_1.text_.text)
			end

			local var_136_15 = math.max(var_136_9, arg_133_1.talkMaxDuration)

			if var_136_8 <= arg_133_1.time_ and arg_133_1.time_ < var_136_8 + var_136_15 then
				arg_133_1.typewritter.percent = (arg_133_1.time_ - var_136_8) / var_136_15

				arg_133_1.typewritter:SetDirty()
			end

			if arg_133_1.time_ >= var_136_8 + var_136_15 and arg_133_1.time_ < var_136_8 + var_136_15 + arg_136_0 then
				arg_133_1.typewritter.percent = 1

				arg_133_1.typewritter:SetDirty()
				arg_133_1:ShowNextGo(true)
			end
		end

		arg_133_1.nodeConfigList_ = {}

		arg_133_1:InitPlayNodeList()
	end,
	Play410082033 = function(arg_137_0, arg_137_1)
		arg_137_1.time_ = 0
		arg_137_1.frameCnt_ = 0
		arg_137_1.state_ = "playing"
		arg_137_1.curTalkId_ = 410082033
		arg_137_1.duration_ = 15.93

		local var_137_0 = {
			zh = 5.6,
			ja = 15.933
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
				arg_137_0:Play410082034(arg_137_1)
			end
		end

		function arg_137_1.onSingleLineUpdate_(arg_140_0)
			local var_140_0 = arg_137_1.actors_["10062"].transform
			local var_140_1 = 0

			if var_140_1 < arg_137_1.time_ and arg_137_1.time_ <= var_140_1 + arg_140_0 then
				arg_137_1.var_.moveOldPos10062 = var_140_0.localPosition
				var_140_0.localScale = Vector3.New(1, 1, 1)

				arg_137_1:CheckSpriteTmpPos("10062", 3)

				local var_140_2 = var_140_0.childCount

				for iter_140_0 = 0, var_140_2 - 1 do
					local var_140_3 = var_140_0:GetChild(iter_140_0)

					if var_140_3.name == "split_2" or not string.find(var_140_3.name, "split") then
						var_140_3.gameObject:SetActive(true)
					else
						var_140_3.gameObject:SetActive(false)
					end
				end
			end

			local var_140_4 = 0.001

			if var_140_1 <= arg_137_1.time_ and arg_137_1.time_ < var_140_1 + var_140_4 then
				local var_140_5 = (arg_137_1.time_ - var_140_1) / var_140_4
				local var_140_6 = Vector3.New(0, -390, -290)

				var_140_0.localPosition = Vector3.Lerp(arg_137_1.var_.moveOldPos10062, var_140_6, var_140_5)
			end

			if arg_137_1.time_ >= var_140_1 + var_140_4 and arg_137_1.time_ < var_140_1 + var_140_4 + arg_140_0 then
				var_140_0.localPosition = Vector3.New(0, -390, -290)
			end

			local var_140_7 = arg_137_1.actors_["10062"]
			local var_140_8 = 0

			if var_140_8 < arg_137_1.time_ and arg_137_1.time_ <= var_140_8 + arg_140_0 and not isNil(var_140_7) and arg_137_1.var_.actorSpriteComps10062 == nil then
				arg_137_1.var_.actorSpriteComps10062 = var_140_7:GetComponentsInChildren(typeof(Image), true)
			end

			local var_140_9 = 0.034

			if var_140_8 <= arg_137_1.time_ and arg_137_1.time_ < var_140_8 + var_140_9 and not isNil(var_140_7) then
				local var_140_10 = (arg_137_1.time_ - var_140_8) / var_140_9

				if arg_137_1.var_.actorSpriteComps10062 then
					for iter_140_1, iter_140_2 in pairs(arg_137_1.var_.actorSpriteComps10062:ToTable()) do
						if iter_140_2 then
							if arg_137_1.isInRecall_ then
								local var_140_11 = Mathf.Lerp(iter_140_2.color.r, arg_137_1.hightColor1.r, var_140_10)
								local var_140_12 = Mathf.Lerp(iter_140_2.color.g, arg_137_1.hightColor1.g, var_140_10)
								local var_140_13 = Mathf.Lerp(iter_140_2.color.b, arg_137_1.hightColor1.b, var_140_10)

								iter_140_2.color = Color.New(var_140_11, var_140_12, var_140_13)
							else
								local var_140_14 = Mathf.Lerp(iter_140_2.color.r, 1, var_140_10)

								iter_140_2.color = Color.New(var_140_14, var_140_14, var_140_14)
							end
						end
					end
				end
			end

			if arg_137_1.time_ >= var_140_8 + var_140_9 and arg_137_1.time_ < var_140_8 + var_140_9 + arg_140_0 and not isNil(var_140_7) and arg_137_1.var_.actorSpriteComps10062 then
				for iter_140_3, iter_140_4 in pairs(arg_137_1.var_.actorSpriteComps10062:ToTable()) do
					if iter_140_4 then
						if arg_137_1.isInRecall_ then
							iter_140_4.color = arg_137_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_140_4.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_137_1.var_.actorSpriteComps10062 = nil
			end

			local var_140_15 = 0
			local var_140_16 = 0.7

			if var_140_15 < arg_137_1.time_ and arg_137_1.time_ <= var_140_15 + arg_140_0 then
				arg_137_1.talkMaxDuration = 0
				arg_137_1.dialogCg_.alpha = 1

				arg_137_1.dialog_:SetActive(true)
				SetActive(arg_137_1.leftNameGo_, true)

				local var_140_17 = arg_137_1:FormatText(StoryNameCfg[600].name)

				arg_137_1.leftNameTxt_.text = var_140_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_137_1.leftNameTxt_.transform)

				arg_137_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_137_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_137_1:RecordName(arg_137_1.leftNameTxt_.text)
				SetActive(arg_137_1.iconTrs_.gameObject, false)
				arg_137_1.callingController_:SetSelectedState("normal")

				local var_140_18 = arg_137_1:GetWordFromCfg(410082033)
				local var_140_19 = arg_137_1:FormatText(var_140_18.content)

				arg_137_1.text_.text = var_140_19

				LuaForUtil.ClearLinePrefixSymbol(arg_137_1.text_)

				local var_140_20 = 28
				local var_140_21 = utf8.len(var_140_19)
				local var_140_22 = var_140_20 <= 0 and var_140_16 or var_140_16 * (var_140_21 / var_140_20)

				if var_140_22 > 0 and var_140_16 < var_140_22 then
					arg_137_1.talkMaxDuration = var_140_22

					if var_140_22 + var_140_15 > arg_137_1.duration_ then
						arg_137_1.duration_ = var_140_22 + var_140_15
					end
				end

				arg_137_1.text_.text = var_140_19
				arg_137_1.typewritter.percent = 0

				arg_137_1.typewritter:SetDirty()
				arg_137_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_410082", "410082033", "story_v_out_410082.awb") ~= 0 then
					local var_140_23 = manager.audio:GetVoiceLength("story_v_out_410082", "410082033", "story_v_out_410082.awb") / 1000

					if var_140_23 + var_140_15 > arg_137_1.duration_ then
						arg_137_1.duration_ = var_140_23 + var_140_15
					end

					if var_140_18.prefab_name ~= "" and arg_137_1.actors_[var_140_18.prefab_name] ~= nil then
						local var_140_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_137_1.actors_[var_140_18.prefab_name].transform, "story_v_out_410082", "410082033", "story_v_out_410082.awb")

						arg_137_1:RecordAudio("410082033", var_140_24)
						arg_137_1:RecordAudio("410082033", var_140_24)
					else
						arg_137_1:AudioAction("play", "voice", "story_v_out_410082", "410082033", "story_v_out_410082.awb")
					end

					arg_137_1:RecordHistoryTalkVoice("story_v_out_410082", "410082033", "story_v_out_410082.awb")
				end

				arg_137_1:RecordContent(arg_137_1.text_.text)
			end

			local var_140_25 = math.max(var_140_16, arg_137_1.talkMaxDuration)

			if var_140_15 <= arg_137_1.time_ and arg_137_1.time_ < var_140_15 + var_140_25 then
				arg_137_1.typewritter.percent = (arg_137_1.time_ - var_140_15) / var_140_25

				arg_137_1.typewritter:SetDirty()
			end

			if arg_137_1.time_ >= var_140_15 + var_140_25 and arg_137_1.time_ < var_140_15 + var_140_25 + arg_140_0 then
				arg_137_1.typewritter.percent = 1

				arg_137_1.typewritter:SetDirty()
				arg_137_1:ShowNextGo(true)
			end
		end

		arg_137_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10062",
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
	Play410082034 = function(arg_141_0, arg_141_1)
		arg_141_1.time_ = 0
		arg_141_1.frameCnt_ = 0
		arg_141_1.state_ = "playing"
		arg_141_1.curTalkId_ = 410082034
		arg_141_1.duration_ = 4.23

		local var_141_0 = {
			zh = 1.266,
			ja = 4.233
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
				arg_141_0:Play410082035(arg_141_1)
			end
		end

		function arg_141_1.onSingleLineUpdate_(arg_144_0)
			local var_144_0 = arg_141_1.actors_["1060"].transform
			local var_144_1 = 0

			if var_144_1 < arg_141_1.time_ and arg_141_1.time_ <= var_144_1 + arg_144_0 then
				arg_141_1.var_.moveOldPos1060 = var_144_0.localPosition
				var_144_0.localScale = Vector3.New(1, 1, 1)

				arg_141_1:CheckSpriteTmpPos("1060", 2)

				local var_144_2 = var_144_0.childCount

				for iter_144_0 = 0, var_144_2 - 1 do
					local var_144_3 = var_144_0:GetChild(iter_144_0)

					if var_144_3.name == "" or not string.find(var_144_3.name, "split") then
						var_144_3.gameObject:SetActive(true)
					else
						var_144_3.gameObject:SetActive(false)
					end
				end
			end

			local var_144_4 = 0.001

			if var_144_1 <= arg_141_1.time_ and arg_141_1.time_ < var_144_1 + var_144_4 then
				local var_144_5 = (arg_141_1.time_ - var_144_1) / var_144_4
				local var_144_6 = Vector3.New(-440.94, -430.8, 6.9)

				var_144_0.localPosition = Vector3.Lerp(arg_141_1.var_.moveOldPos1060, var_144_6, var_144_5)
			end

			if arg_141_1.time_ >= var_144_1 + var_144_4 and arg_141_1.time_ < var_144_1 + var_144_4 + arg_144_0 then
				var_144_0.localPosition = Vector3.New(-440.94, -430.8, 6.9)
			end

			local var_144_7 = arg_141_1.actors_["1060"]
			local var_144_8 = 0

			if var_144_8 < arg_141_1.time_ and arg_141_1.time_ <= var_144_8 + arg_144_0 and not isNil(var_144_7) and arg_141_1.var_.actorSpriteComps1060 == nil then
				arg_141_1.var_.actorSpriteComps1060 = var_144_7:GetComponentsInChildren(typeof(Image), true)
			end

			local var_144_9 = 0.034

			if var_144_8 <= arg_141_1.time_ and arg_141_1.time_ < var_144_8 + var_144_9 and not isNil(var_144_7) then
				local var_144_10 = (arg_141_1.time_ - var_144_8) / var_144_9

				if arg_141_1.var_.actorSpriteComps1060 then
					for iter_144_1, iter_144_2 in pairs(arg_141_1.var_.actorSpriteComps1060:ToTable()) do
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

			if arg_141_1.time_ >= var_144_8 + var_144_9 and arg_141_1.time_ < var_144_8 + var_144_9 + arg_144_0 and not isNil(var_144_7) and arg_141_1.var_.actorSpriteComps1060 then
				for iter_144_3, iter_144_4 in pairs(arg_141_1.var_.actorSpriteComps1060:ToTable()) do
					if iter_144_4 then
						if arg_141_1.isInRecall_ then
							iter_144_4.color = arg_141_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_144_4.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_141_1.var_.actorSpriteComps1060 = nil
			end

			local var_144_15 = arg_141_1.actors_["10062"].transform
			local var_144_16 = 0

			if var_144_16 < arg_141_1.time_ and arg_141_1.time_ <= var_144_16 + arg_144_0 then
				arg_141_1.var_.moveOldPos10062 = var_144_15.localPosition
				var_144_15.localScale = Vector3.New(1, 1, 1)

				arg_141_1:CheckSpriteTmpPos("10062", 4)

				local var_144_17 = var_144_15.childCount

				for iter_144_5 = 0, var_144_17 - 1 do
					local var_144_18 = var_144_15:GetChild(iter_144_5)

					if var_144_18.name == "split_2" or not string.find(var_144_18.name, "split") then
						var_144_18.gameObject:SetActive(true)
					else
						var_144_18.gameObject:SetActive(false)
					end
				end
			end

			local var_144_19 = 0.001

			if var_144_16 <= arg_141_1.time_ and arg_141_1.time_ < var_144_16 + var_144_19 then
				local var_144_20 = (arg_141_1.time_ - var_144_16) / var_144_19
				local var_144_21 = Vector3.New(370, -390, -290)

				var_144_15.localPosition = Vector3.Lerp(arg_141_1.var_.moveOldPos10062, var_144_21, var_144_20)
			end

			if arg_141_1.time_ >= var_144_16 + var_144_19 and arg_141_1.time_ < var_144_16 + var_144_19 + arg_144_0 then
				var_144_15.localPosition = Vector3.New(370, -390, -290)
			end

			local var_144_22 = arg_141_1.actors_["10062"]
			local var_144_23 = 0

			if var_144_23 < arg_141_1.time_ and arg_141_1.time_ <= var_144_23 + arg_144_0 and not isNil(var_144_22) and arg_141_1.var_.actorSpriteComps10062 == nil then
				arg_141_1.var_.actorSpriteComps10062 = var_144_22:GetComponentsInChildren(typeof(Image), true)
			end

			local var_144_24 = 0.034

			if var_144_23 <= arg_141_1.time_ and arg_141_1.time_ < var_144_23 + var_144_24 and not isNil(var_144_22) then
				local var_144_25 = (arg_141_1.time_ - var_144_23) / var_144_24

				if arg_141_1.var_.actorSpriteComps10062 then
					for iter_144_6, iter_144_7 in pairs(arg_141_1.var_.actorSpriteComps10062:ToTable()) do
						if iter_144_7 then
							if arg_141_1.isInRecall_ then
								local var_144_26 = Mathf.Lerp(iter_144_7.color.r, arg_141_1.hightColor2.r, var_144_25)
								local var_144_27 = Mathf.Lerp(iter_144_7.color.g, arg_141_1.hightColor2.g, var_144_25)
								local var_144_28 = Mathf.Lerp(iter_144_7.color.b, arg_141_1.hightColor2.b, var_144_25)

								iter_144_7.color = Color.New(var_144_26, var_144_27, var_144_28)
							else
								local var_144_29 = Mathf.Lerp(iter_144_7.color.r, 0.5, var_144_25)

								iter_144_7.color = Color.New(var_144_29, var_144_29, var_144_29)
							end
						end
					end
				end
			end

			if arg_141_1.time_ >= var_144_23 + var_144_24 and arg_141_1.time_ < var_144_23 + var_144_24 + arg_144_0 and not isNil(var_144_22) and arg_141_1.var_.actorSpriteComps10062 then
				for iter_144_8, iter_144_9 in pairs(arg_141_1.var_.actorSpriteComps10062:ToTable()) do
					if iter_144_9 then
						if arg_141_1.isInRecall_ then
							iter_144_9.color = arg_141_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_144_9.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_141_1.var_.actorSpriteComps10062 = nil
			end

			local var_144_30 = 0
			local var_144_31 = 0.125

			if var_144_30 < arg_141_1.time_ and arg_141_1.time_ <= var_144_30 + arg_144_0 then
				arg_141_1.talkMaxDuration = 0
				arg_141_1.dialogCg_.alpha = 1

				arg_141_1.dialog_:SetActive(true)
				SetActive(arg_141_1.leftNameGo_, true)

				local var_144_32 = arg_141_1:FormatText(StoryNameCfg[584].name)

				arg_141_1.leftNameTxt_.text = var_144_32

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_141_1.leftNameTxt_.transform)

				arg_141_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_141_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_141_1:RecordName(arg_141_1.leftNameTxt_.text)
				SetActive(arg_141_1.iconTrs_.gameObject, false)
				arg_141_1.callingController_:SetSelectedState("normal")

				local var_144_33 = arg_141_1:GetWordFromCfg(410082034)
				local var_144_34 = arg_141_1:FormatText(var_144_33.content)

				arg_141_1.text_.text = var_144_34

				LuaForUtil.ClearLinePrefixSymbol(arg_141_1.text_)

				local var_144_35 = 5
				local var_144_36 = utf8.len(var_144_34)
				local var_144_37 = var_144_35 <= 0 and var_144_31 or var_144_31 * (var_144_36 / var_144_35)

				if var_144_37 > 0 and var_144_31 < var_144_37 then
					arg_141_1.talkMaxDuration = var_144_37

					if var_144_37 + var_144_30 > arg_141_1.duration_ then
						arg_141_1.duration_ = var_144_37 + var_144_30
					end
				end

				arg_141_1.text_.text = var_144_34
				arg_141_1.typewritter.percent = 0

				arg_141_1.typewritter:SetDirty()
				arg_141_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_410082", "410082034", "story_v_out_410082.awb") ~= 0 then
					local var_144_38 = manager.audio:GetVoiceLength("story_v_out_410082", "410082034", "story_v_out_410082.awb") / 1000

					if var_144_38 + var_144_30 > arg_141_1.duration_ then
						arg_141_1.duration_ = var_144_38 + var_144_30
					end

					if var_144_33.prefab_name ~= "" and arg_141_1.actors_[var_144_33.prefab_name] ~= nil then
						local var_144_39 = LuaForUtil.PlayVoiceWithCriLipsync(arg_141_1.actors_[var_144_33.prefab_name].transform, "story_v_out_410082", "410082034", "story_v_out_410082.awb")

						arg_141_1:RecordAudio("410082034", var_144_39)
						arg_141_1:RecordAudio("410082034", var_144_39)
					else
						arg_141_1:AudioAction("play", "voice", "story_v_out_410082", "410082034", "story_v_out_410082.awb")
					end

					arg_141_1:RecordHistoryTalkVoice("story_v_out_410082", "410082034", "story_v_out_410082.awb")
				end

				arg_141_1:RecordContent(arg_141_1.text_.text)
			end

			local var_144_40 = math.max(var_144_31, arg_141_1.talkMaxDuration)

			if var_144_30 <= arg_141_1.time_ and arg_141_1.time_ < var_144_30 + var_144_40 then
				arg_141_1.typewritter.percent = (arg_141_1.time_ - var_144_30) / var_144_40

				arg_141_1.typewritter:SetDirty()
			end

			if arg_141_1.time_ >= var_144_30 + var_144_40 and arg_141_1.time_ < var_144_30 + var_144_40 + arg_144_0 then
				arg_141_1.typewritter.percent = 1

				arg_141_1.typewritter:SetDirty()
				arg_141_1:ShowNextGo(true)
			end
		end

		arg_141_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1060",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			},
			{
				assetPath = "",
				actorName = "10062",
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
	Play410082035 = function(arg_145_0, arg_145_1)
		arg_145_1.time_ = 0
		arg_145_1.frameCnt_ = 0
		arg_145_1.state_ = "playing"
		arg_145_1.curTalkId_ = 410082035
		arg_145_1.duration_ = 5

		SetActive(arg_145_1.tipsGo_, false)

		function arg_145_1.onSingleLineFinish_()
			arg_145_1.onSingleLineUpdate_ = nil
			arg_145_1.onSingleLineFinish_ = nil
			arg_145_1.state_ = "waiting"
		end

		function arg_145_1.playNext_(arg_147_0)
			if arg_147_0 == 1 then
				arg_145_0:Play410082036(arg_145_1)
			end
		end

		function arg_145_1.onSingleLineUpdate_(arg_148_0)
			local var_148_0 = arg_145_1.actors_["10062"].transform
			local var_148_1 = 0

			if var_148_1 < arg_145_1.time_ and arg_145_1.time_ <= var_148_1 + arg_148_0 then
				arg_145_1.var_.moveOldPos10062 = var_148_0.localPosition
				var_148_0.localScale = Vector3.New(1, 1, 1)

				arg_145_1:CheckSpriteTmpPos("10062", 7)

				local var_148_2 = var_148_0.childCount

				for iter_148_0 = 0, var_148_2 - 1 do
					local var_148_3 = var_148_0:GetChild(iter_148_0)

					if var_148_3.name == "" or not string.find(var_148_3.name, "split") then
						var_148_3.gameObject:SetActive(true)
					else
						var_148_3.gameObject:SetActive(false)
					end
				end
			end

			local var_148_4 = 0.001

			if var_148_1 <= arg_145_1.time_ and arg_145_1.time_ < var_148_1 + var_148_4 then
				local var_148_5 = (arg_145_1.time_ - var_148_1) / var_148_4
				local var_148_6 = Vector3.New(0, -2000, -290)

				var_148_0.localPosition = Vector3.Lerp(arg_145_1.var_.moveOldPos10062, var_148_6, var_148_5)
			end

			if arg_145_1.time_ >= var_148_1 + var_148_4 and arg_145_1.time_ < var_148_1 + var_148_4 + arg_148_0 then
				var_148_0.localPosition = Vector3.New(0, -2000, -290)
			end

			local var_148_7 = arg_145_1.actors_["1060"].transform
			local var_148_8 = 0

			if var_148_8 < arg_145_1.time_ and arg_145_1.time_ <= var_148_8 + arg_148_0 then
				arg_145_1.var_.moveOldPos1060 = var_148_7.localPosition
				var_148_7.localScale = Vector3.New(1, 1, 1)

				arg_145_1:CheckSpriteTmpPos("1060", 7)

				local var_148_9 = var_148_7.childCount

				for iter_148_1 = 0, var_148_9 - 1 do
					local var_148_10 = var_148_7:GetChild(iter_148_1)

					if var_148_10.name == "" or not string.find(var_148_10.name, "split") then
						var_148_10.gameObject:SetActive(true)
					else
						var_148_10.gameObject:SetActive(false)
					end
				end
			end

			local var_148_11 = 0.001

			if var_148_8 <= arg_145_1.time_ and arg_145_1.time_ < var_148_8 + var_148_11 then
				local var_148_12 = (arg_145_1.time_ - var_148_8) / var_148_11
				local var_148_13 = Vector3.New(0, -2000, -40)

				var_148_7.localPosition = Vector3.Lerp(arg_145_1.var_.moveOldPos1060, var_148_13, var_148_12)
			end

			if arg_145_1.time_ >= var_148_8 + var_148_11 and arg_145_1.time_ < var_148_8 + var_148_11 + arg_148_0 then
				var_148_7.localPosition = Vector3.New(0, -2000, -40)
			end

			local var_148_14 = 0
			local var_148_15 = 1.15

			if var_148_14 < arg_145_1.time_ and arg_145_1.time_ <= var_148_14 + arg_148_0 then
				arg_145_1.talkMaxDuration = 0
				arg_145_1.dialogCg_.alpha = 1

				arg_145_1.dialog_:SetActive(true)
				SetActive(arg_145_1.leftNameGo_, false)

				arg_145_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_145_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_145_1:RecordName(arg_145_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_145_1.iconTrs_.gameObject, false)
				arg_145_1.callingController_:SetSelectedState("normal")

				local var_148_16 = arg_145_1:GetWordFromCfg(410082035)
				local var_148_17 = arg_145_1:FormatText(var_148_16.content)

				arg_145_1.text_.text = var_148_17

				LuaForUtil.ClearLinePrefixSymbol(arg_145_1.text_)

				local var_148_18 = 46
				local var_148_19 = utf8.len(var_148_17)
				local var_148_20 = var_148_18 <= 0 and var_148_15 or var_148_15 * (var_148_19 / var_148_18)

				if var_148_20 > 0 and var_148_15 < var_148_20 then
					arg_145_1.talkMaxDuration = var_148_20

					if var_148_20 + var_148_14 > arg_145_1.duration_ then
						arg_145_1.duration_ = var_148_20 + var_148_14
					end
				end

				arg_145_1.text_.text = var_148_17
				arg_145_1.typewritter.percent = 0

				arg_145_1.typewritter:SetDirty()
				arg_145_1:ShowNextGo(false)
				arg_145_1:RecordContent(arg_145_1.text_.text)
			end

			local var_148_21 = math.max(var_148_15, arg_145_1.talkMaxDuration)

			if var_148_14 <= arg_145_1.time_ and arg_145_1.time_ < var_148_14 + var_148_21 then
				arg_145_1.typewritter.percent = (arg_145_1.time_ - var_148_14) / var_148_21

				arg_145_1.typewritter:SetDirty()
			end

			if arg_145_1.time_ >= var_148_14 + var_148_21 and arg_145_1.time_ < var_148_14 + var_148_21 + arg_148_0 then
				arg_145_1.typewritter.percent = 1

				arg_145_1.typewritter:SetDirty()
				arg_145_1:ShowNextGo(true)
			end
		end

		arg_145_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10062",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			},
			{
				assetPath = "",
				actorName = "1060",
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
	Play410082036 = function(arg_149_0, arg_149_1)
		arg_149_1.time_ = 0
		arg_149_1.frameCnt_ = 0
		arg_149_1.state_ = "playing"
		arg_149_1.curTalkId_ = 410082036
		arg_149_1.duration_ = 5

		SetActive(arg_149_1.tipsGo_, false)

		function arg_149_1.onSingleLineFinish_()
			arg_149_1.onSingleLineUpdate_ = nil
			arg_149_1.onSingleLineFinish_ = nil
			arg_149_1.state_ = "waiting"
		end

		function arg_149_1.playNext_(arg_151_0)
			if arg_151_0 == 1 then
				arg_149_0:Play410082037(arg_149_1)
			end
		end

		function arg_149_1.onSingleLineUpdate_(arg_152_0)
			local var_152_0 = 0
			local var_152_1 = 0.975

			if var_152_0 < arg_149_1.time_ and arg_149_1.time_ <= var_152_0 + arg_152_0 then
				arg_149_1.talkMaxDuration = 0
				arg_149_1.dialogCg_.alpha = 1

				arg_149_1.dialog_:SetActive(true)
				SetActive(arg_149_1.leftNameGo_, false)

				arg_149_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_149_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_149_1:RecordName(arg_149_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_149_1.iconTrs_.gameObject, false)
				arg_149_1.callingController_:SetSelectedState("normal")

				local var_152_2 = arg_149_1:GetWordFromCfg(410082036)
				local var_152_3 = arg_149_1:FormatText(var_152_2.content)

				arg_149_1.text_.text = var_152_3

				LuaForUtil.ClearLinePrefixSymbol(arg_149_1.text_)

				local var_152_4 = 39
				local var_152_5 = utf8.len(var_152_3)
				local var_152_6 = var_152_4 <= 0 and var_152_1 or var_152_1 * (var_152_5 / var_152_4)

				if var_152_6 > 0 and var_152_1 < var_152_6 then
					arg_149_1.talkMaxDuration = var_152_6

					if var_152_6 + var_152_0 > arg_149_1.duration_ then
						arg_149_1.duration_ = var_152_6 + var_152_0
					end
				end

				arg_149_1.text_.text = var_152_3
				arg_149_1.typewritter.percent = 0

				arg_149_1.typewritter:SetDirty()
				arg_149_1:ShowNextGo(false)
				arg_149_1:RecordContent(arg_149_1.text_.text)
			end

			local var_152_7 = math.max(var_152_1, arg_149_1.talkMaxDuration)

			if var_152_0 <= arg_149_1.time_ and arg_149_1.time_ < var_152_0 + var_152_7 then
				arg_149_1.typewritter.percent = (arg_149_1.time_ - var_152_0) / var_152_7

				arg_149_1.typewritter:SetDirty()
			end

			if arg_149_1.time_ >= var_152_0 + var_152_7 and arg_149_1.time_ < var_152_0 + var_152_7 + arg_152_0 then
				arg_149_1.typewritter.percent = 1

				arg_149_1.typewritter:SetDirty()
				arg_149_1:ShowNextGo(true)
			end
		end

		arg_149_1.nodeConfigList_ = {}

		arg_149_1:InitPlayNodeList()
	end,
	Play410082037 = function(arg_153_0, arg_153_1)
		arg_153_1.time_ = 0
		arg_153_1.frameCnt_ = 0
		arg_153_1.state_ = "playing"
		arg_153_1.curTalkId_ = 410082037
		arg_153_1.duration_ = 8.87

		local var_153_0 = {
			zh = 3.733,
			ja = 8.866
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
				arg_153_0:Play410082038(arg_153_1)
			end
		end

		function arg_153_1.onSingleLineUpdate_(arg_156_0)
			local var_156_0 = "1056"

			if arg_153_1.actors_[var_156_0] == nil then
				local var_156_1 = Asset.Load("Widget/System/Story/StoryExpression/" .. "1056")

				if not isNil(var_156_1) then
					local var_156_2 = Object.Instantiate(var_156_1, arg_153_1.canvasGo_.transform)

					var_156_2.transform:SetSiblingIndex(1)

					var_156_2.name = var_156_0
					var_156_2.transform.localPosition = Vector3.New(0, 100000, 0)
					arg_153_1.actors_[var_156_0] = var_156_2

					local var_156_3 = var_156_2:GetComponentsInChildren(typeof(Image), true):ToTable()

					if arg_153_1.isInRecall_ then
						for iter_156_0, iter_156_1 in ipairs(var_156_3) do
							iter_156_1.color = arg_153_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						end
					end
				end
			end

			local var_156_4 = arg_153_1.actors_["1056"].transform
			local var_156_5 = 0

			if var_156_5 < arg_153_1.time_ and arg_153_1.time_ <= var_156_5 + arg_156_0 then
				arg_153_1.var_.moveOldPos1056 = var_156_4.localPosition
				var_156_4.localScale = Vector3.New(1, 1, 1)

				arg_153_1:CheckSpriteTmpPos("1056", 4)

				local var_156_6 = var_156_4.childCount

				for iter_156_2 = 0, var_156_6 - 1 do
					local var_156_7 = var_156_4:GetChild(iter_156_2)

					if var_156_7.name == "split_1" or not string.find(var_156_7.name, "split") then
						var_156_7.gameObject:SetActive(true)
					else
						var_156_7.gameObject:SetActive(false)
					end
				end
			end

			local var_156_8 = 0.001

			if var_156_5 <= arg_153_1.time_ and arg_153_1.time_ < var_156_5 + var_156_8 then
				local var_156_9 = (arg_153_1.time_ - var_156_5) / var_156_8
				local var_156_10 = Vector3.New(390, -350, -180)

				var_156_4.localPosition = Vector3.Lerp(arg_153_1.var_.moveOldPos1056, var_156_10, var_156_9)
			end

			if arg_153_1.time_ >= var_156_5 + var_156_8 and arg_153_1.time_ < var_156_5 + var_156_8 + arg_156_0 then
				var_156_4.localPosition = Vector3.New(390, -350, -180)
			end

			local var_156_11 = arg_153_1.actors_["1060"].transform
			local var_156_12 = 0

			if var_156_12 < arg_153_1.time_ and arg_153_1.time_ <= var_156_12 + arg_156_0 then
				arg_153_1.var_.moveOldPos1060 = var_156_11.localPosition
				var_156_11.localScale = Vector3.New(1, 1, 1)

				arg_153_1:CheckSpriteTmpPos("1060", 2)

				local var_156_13 = var_156_11.childCount

				for iter_156_3 = 0, var_156_13 - 1 do
					local var_156_14 = var_156_11:GetChild(iter_156_3)

					if var_156_14.name == "" or not string.find(var_156_14.name, "split") then
						var_156_14.gameObject:SetActive(true)
					else
						var_156_14.gameObject:SetActive(false)
					end
				end
			end

			local var_156_15 = 0.001

			if var_156_12 <= arg_153_1.time_ and arg_153_1.time_ < var_156_12 + var_156_15 then
				local var_156_16 = (arg_153_1.time_ - var_156_12) / var_156_15
				local var_156_17 = Vector3.New(-440.94, -430.8, 6.9)

				var_156_11.localPosition = Vector3.Lerp(arg_153_1.var_.moveOldPos1060, var_156_17, var_156_16)
			end

			if arg_153_1.time_ >= var_156_12 + var_156_15 and arg_153_1.time_ < var_156_12 + var_156_15 + arg_156_0 then
				var_156_11.localPosition = Vector3.New(-440.94, -430.8, 6.9)
			end

			local var_156_18 = arg_153_1.actors_["1056"]
			local var_156_19 = 0

			if var_156_19 < arg_153_1.time_ and arg_153_1.time_ <= var_156_19 + arg_156_0 and not isNil(var_156_18) and arg_153_1.var_.actorSpriteComps1056 == nil then
				arg_153_1.var_.actorSpriteComps1056 = var_156_18:GetComponentsInChildren(typeof(Image), true)
			end

			local var_156_20 = 0.034

			if var_156_19 <= arg_153_1.time_ and arg_153_1.time_ < var_156_19 + var_156_20 and not isNil(var_156_18) then
				local var_156_21 = (arg_153_1.time_ - var_156_19) / var_156_20

				if arg_153_1.var_.actorSpriteComps1056 then
					for iter_156_4, iter_156_5 in pairs(arg_153_1.var_.actorSpriteComps1056:ToTable()) do
						if iter_156_5 then
							if arg_153_1.isInRecall_ then
								local var_156_22 = Mathf.Lerp(iter_156_5.color.r, arg_153_1.hightColor1.r, var_156_21)
								local var_156_23 = Mathf.Lerp(iter_156_5.color.g, arg_153_1.hightColor1.g, var_156_21)
								local var_156_24 = Mathf.Lerp(iter_156_5.color.b, arg_153_1.hightColor1.b, var_156_21)

								iter_156_5.color = Color.New(var_156_22, var_156_23, var_156_24)
							else
								local var_156_25 = Mathf.Lerp(iter_156_5.color.r, 1, var_156_21)

								iter_156_5.color = Color.New(var_156_25, var_156_25, var_156_25)
							end
						end
					end
				end
			end

			if arg_153_1.time_ >= var_156_19 + var_156_20 and arg_153_1.time_ < var_156_19 + var_156_20 + arg_156_0 and not isNil(var_156_18) and arg_153_1.var_.actorSpriteComps1056 then
				for iter_156_6, iter_156_7 in pairs(arg_153_1.var_.actorSpriteComps1056:ToTable()) do
					if iter_156_7 then
						if arg_153_1.isInRecall_ then
							iter_156_7.color = arg_153_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_156_7.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_153_1.var_.actorSpriteComps1056 = nil
			end

			local var_156_26 = arg_153_1.actors_["1060"]
			local var_156_27 = 0

			if var_156_27 < arg_153_1.time_ and arg_153_1.time_ <= var_156_27 + arg_156_0 and not isNil(var_156_26) and arg_153_1.var_.actorSpriteComps1060 == nil then
				arg_153_1.var_.actorSpriteComps1060 = var_156_26:GetComponentsInChildren(typeof(Image), true)
			end

			local var_156_28 = 0.034

			if var_156_27 <= arg_153_1.time_ and arg_153_1.time_ < var_156_27 + var_156_28 and not isNil(var_156_26) then
				local var_156_29 = (arg_153_1.time_ - var_156_27) / var_156_28

				if arg_153_1.var_.actorSpriteComps1060 then
					for iter_156_8, iter_156_9 in pairs(arg_153_1.var_.actorSpriteComps1060:ToTable()) do
						if iter_156_9 then
							if arg_153_1.isInRecall_ then
								local var_156_30 = Mathf.Lerp(iter_156_9.color.r, arg_153_1.hightColor2.r, var_156_29)
								local var_156_31 = Mathf.Lerp(iter_156_9.color.g, arg_153_1.hightColor2.g, var_156_29)
								local var_156_32 = Mathf.Lerp(iter_156_9.color.b, arg_153_1.hightColor2.b, var_156_29)

								iter_156_9.color = Color.New(var_156_30, var_156_31, var_156_32)
							else
								local var_156_33 = Mathf.Lerp(iter_156_9.color.r, 0.5, var_156_29)

								iter_156_9.color = Color.New(var_156_33, var_156_33, var_156_33)
							end
						end
					end
				end
			end

			if arg_153_1.time_ >= var_156_27 + var_156_28 and arg_153_1.time_ < var_156_27 + var_156_28 + arg_156_0 and not isNil(var_156_26) and arg_153_1.var_.actorSpriteComps1060 then
				for iter_156_10, iter_156_11 in pairs(arg_153_1.var_.actorSpriteComps1060:ToTable()) do
					if iter_156_11 then
						if arg_153_1.isInRecall_ then
							iter_156_11.color = arg_153_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_156_11.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_153_1.var_.actorSpriteComps1060 = nil
			end

			local var_156_34 = 0
			local var_156_35 = 0.5

			if var_156_34 < arg_153_1.time_ and arg_153_1.time_ <= var_156_34 + arg_156_0 then
				arg_153_1.talkMaxDuration = 0
				arg_153_1.dialogCg_.alpha = 1

				arg_153_1.dialog_:SetActive(true)
				SetActive(arg_153_1.leftNameGo_, true)

				local var_156_36 = arg_153_1:FormatText(StoryNameCfg[605].name)

				arg_153_1.leftNameTxt_.text = var_156_36

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_153_1.leftNameTxt_.transform)

				arg_153_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_153_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_153_1:RecordName(arg_153_1.leftNameTxt_.text)
				SetActive(arg_153_1.iconTrs_.gameObject, false)
				arg_153_1.callingController_:SetSelectedState("normal")

				local var_156_37 = arg_153_1:GetWordFromCfg(410082037)
				local var_156_38 = arg_153_1:FormatText(var_156_37.content)

				arg_153_1.text_.text = var_156_38

				LuaForUtil.ClearLinePrefixSymbol(arg_153_1.text_)

				local var_156_39 = 20
				local var_156_40 = utf8.len(var_156_38)
				local var_156_41 = var_156_39 <= 0 and var_156_35 or var_156_35 * (var_156_40 / var_156_39)

				if var_156_41 > 0 and var_156_35 < var_156_41 then
					arg_153_1.talkMaxDuration = var_156_41

					if var_156_41 + var_156_34 > arg_153_1.duration_ then
						arg_153_1.duration_ = var_156_41 + var_156_34
					end
				end

				arg_153_1.text_.text = var_156_38
				arg_153_1.typewritter.percent = 0

				arg_153_1.typewritter:SetDirty()
				arg_153_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_410082", "410082037", "story_v_out_410082.awb") ~= 0 then
					local var_156_42 = manager.audio:GetVoiceLength("story_v_out_410082", "410082037", "story_v_out_410082.awb") / 1000

					if var_156_42 + var_156_34 > arg_153_1.duration_ then
						arg_153_1.duration_ = var_156_42 + var_156_34
					end

					if var_156_37.prefab_name ~= "" and arg_153_1.actors_[var_156_37.prefab_name] ~= nil then
						local var_156_43 = LuaForUtil.PlayVoiceWithCriLipsync(arg_153_1.actors_[var_156_37.prefab_name].transform, "story_v_out_410082", "410082037", "story_v_out_410082.awb")

						arg_153_1:RecordAudio("410082037", var_156_43)
						arg_153_1:RecordAudio("410082037", var_156_43)
					else
						arg_153_1:AudioAction("play", "voice", "story_v_out_410082", "410082037", "story_v_out_410082.awb")
					end

					arg_153_1:RecordHistoryTalkVoice("story_v_out_410082", "410082037", "story_v_out_410082.awb")
				end

				arg_153_1:RecordContent(arg_153_1.text_.text)
			end

			local var_156_44 = math.max(var_156_35, arg_153_1.talkMaxDuration)

			if var_156_34 <= arg_153_1.time_ and arg_153_1.time_ < var_156_34 + var_156_44 then
				arg_153_1.typewritter.percent = (arg_153_1.time_ - var_156_34) / var_156_44

				arg_153_1.typewritter:SetDirty()
			end

			if arg_153_1.time_ >= var_156_34 + var_156_44 and arg_153_1.time_ < var_156_34 + var_156_44 + arg_156_0 then
				arg_153_1.typewritter.percent = 1

				arg_153_1.typewritter:SetDirty()
				arg_153_1:ShowNextGo(true)
			end
		end

		arg_153_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1056",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			},
			{
				assetPath = "",
				actorName = "1060",
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
	Play410082038 = function(arg_157_0, arg_157_1)
		arg_157_1.time_ = 0
		arg_157_1.frameCnt_ = 0
		arg_157_1.state_ = "playing"
		arg_157_1.curTalkId_ = 410082038
		arg_157_1.duration_ = 8.63

		local var_157_0 = {
			zh = 3.633,
			ja = 8.633
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
				arg_157_0:Play410082039(arg_157_1)
			end
		end

		function arg_157_1.onSingleLineUpdate_(arg_160_0)
			local var_160_0 = arg_157_1.actors_["1060"].transform
			local var_160_1 = 0

			if var_160_1 < arg_157_1.time_ and arg_157_1.time_ <= var_160_1 + arg_160_0 then
				arg_157_1.var_.moveOldPos1060 = var_160_0.localPosition
				var_160_0.localScale = Vector3.New(1, 1, 1)

				arg_157_1:CheckSpriteTmpPos("1060", 2)

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
				local var_160_6 = Vector3.New(-440.94, -430.8, 6.9)

				var_160_0.localPosition = Vector3.Lerp(arg_157_1.var_.moveOldPos1060, var_160_6, var_160_5)
			end

			if arg_157_1.time_ >= var_160_1 + var_160_4 and arg_157_1.time_ < var_160_1 + var_160_4 + arg_160_0 then
				var_160_0.localPosition = Vector3.New(-440.94, -430.8, 6.9)
			end

			local var_160_7 = arg_157_1.actors_["1060"]
			local var_160_8 = 0

			if var_160_8 < arg_157_1.time_ and arg_157_1.time_ <= var_160_8 + arg_160_0 and not isNil(var_160_7) and arg_157_1.var_.actorSpriteComps1060 == nil then
				arg_157_1.var_.actorSpriteComps1060 = var_160_7:GetComponentsInChildren(typeof(Image), true)
			end

			local var_160_9 = 0.034

			if var_160_8 <= arg_157_1.time_ and arg_157_1.time_ < var_160_8 + var_160_9 and not isNil(var_160_7) then
				local var_160_10 = (arg_157_1.time_ - var_160_8) / var_160_9

				if arg_157_1.var_.actorSpriteComps1060 then
					for iter_160_1, iter_160_2 in pairs(arg_157_1.var_.actorSpriteComps1060:ToTable()) do
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

			if arg_157_1.time_ >= var_160_8 + var_160_9 and arg_157_1.time_ < var_160_8 + var_160_9 + arg_160_0 and not isNil(var_160_7) and arg_157_1.var_.actorSpriteComps1060 then
				for iter_160_3, iter_160_4 in pairs(arg_157_1.var_.actorSpriteComps1060:ToTable()) do
					if iter_160_4 then
						if arg_157_1.isInRecall_ then
							iter_160_4.color = arg_157_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_160_4.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_157_1.var_.actorSpriteComps1060 = nil
			end

			local var_160_15 = arg_157_1.actors_["1056"]
			local var_160_16 = 0

			if var_160_16 < arg_157_1.time_ and arg_157_1.time_ <= var_160_16 + arg_160_0 and not isNil(var_160_15) and arg_157_1.var_.actorSpriteComps1056 == nil then
				arg_157_1.var_.actorSpriteComps1056 = var_160_15:GetComponentsInChildren(typeof(Image), true)
			end

			local var_160_17 = 0.034

			if var_160_16 <= arg_157_1.time_ and arg_157_1.time_ < var_160_16 + var_160_17 and not isNil(var_160_15) then
				local var_160_18 = (arg_157_1.time_ - var_160_16) / var_160_17

				if arg_157_1.var_.actorSpriteComps1056 then
					for iter_160_5, iter_160_6 in pairs(arg_157_1.var_.actorSpriteComps1056:ToTable()) do
						if iter_160_6 then
							if arg_157_1.isInRecall_ then
								local var_160_19 = Mathf.Lerp(iter_160_6.color.r, arg_157_1.hightColor2.r, var_160_18)
								local var_160_20 = Mathf.Lerp(iter_160_6.color.g, arg_157_1.hightColor2.g, var_160_18)
								local var_160_21 = Mathf.Lerp(iter_160_6.color.b, arg_157_1.hightColor2.b, var_160_18)

								iter_160_6.color = Color.New(var_160_19, var_160_20, var_160_21)
							else
								local var_160_22 = Mathf.Lerp(iter_160_6.color.r, 0.5, var_160_18)

								iter_160_6.color = Color.New(var_160_22, var_160_22, var_160_22)
							end
						end
					end
				end
			end

			if arg_157_1.time_ >= var_160_16 + var_160_17 and arg_157_1.time_ < var_160_16 + var_160_17 + arg_160_0 and not isNil(var_160_15) and arg_157_1.var_.actorSpriteComps1056 then
				for iter_160_7, iter_160_8 in pairs(arg_157_1.var_.actorSpriteComps1056:ToTable()) do
					if iter_160_8 then
						if arg_157_1.isInRecall_ then
							iter_160_8.color = arg_157_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_160_8.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_157_1.var_.actorSpriteComps1056 = nil
			end

			local var_160_23 = 0
			local var_160_24 = 0.5

			if var_160_23 < arg_157_1.time_ and arg_157_1.time_ <= var_160_23 + arg_160_0 then
				arg_157_1.talkMaxDuration = 0
				arg_157_1.dialogCg_.alpha = 1

				arg_157_1.dialog_:SetActive(true)
				SetActive(arg_157_1.leftNameGo_, true)

				local var_160_25 = arg_157_1:FormatText(StoryNameCfg[584].name)

				arg_157_1.leftNameTxt_.text = var_160_25

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_157_1.leftNameTxt_.transform)

				arg_157_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_157_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_157_1:RecordName(arg_157_1.leftNameTxt_.text)
				SetActive(arg_157_1.iconTrs_.gameObject, false)
				arg_157_1.callingController_:SetSelectedState("normal")

				local var_160_26 = arg_157_1:GetWordFromCfg(410082038)
				local var_160_27 = arg_157_1:FormatText(var_160_26.content)

				arg_157_1.text_.text = var_160_27

				LuaForUtil.ClearLinePrefixSymbol(arg_157_1.text_)

				local var_160_28 = 20
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

				if manager.audio:GetVoiceLength("story_v_out_410082", "410082038", "story_v_out_410082.awb") ~= 0 then
					local var_160_31 = manager.audio:GetVoiceLength("story_v_out_410082", "410082038", "story_v_out_410082.awb") / 1000

					if var_160_31 + var_160_23 > arg_157_1.duration_ then
						arg_157_1.duration_ = var_160_31 + var_160_23
					end

					if var_160_26.prefab_name ~= "" and arg_157_1.actors_[var_160_26.prefab_name] ~= nil then
						local var_160_32 = LuaForUtil.PlayVoiceWithCriLipsync(arg_157_1.actors_[var_160_26.prefab_name].transform, "story_v_out_410082", "410082038", "story_v_out_410082.awb")

						arg_157_1:RecordAudio("410082038", var_160_32)
						arg_157_1:RecordAudio("410082038", var_160_32)
					else
						arg_157_1:AudioAction("play", "voice", "story_v_out_410082", "410082038", "story_v_out_410082.awb")
					end

					arg_157_1:RecordHistoryTalkVoice("story_v_out_410082", "410082038", "story_v_out_410082.awb")
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
				actorName = "1060",
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
	Play410082039 = function(arg_161_0, arg_161_1)
		arg_161_1.time_ = 0
		arg_161_1.frameCnt_ = 0
		arg_161_1.state_ = "playing"
		arg_161_1.curTalkId_ = 410082039
		arg_161_1.duration_ = 8.73

		local var_161_0 = {
			zh = 6.2,
			ja = 8.733
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
				arg_161_0:Play410082040(arg_161_1)
			end
		end

		function arg_161_1.onSingleLineUpdate_(arg_164_0)
			local var_164_0 = 0
			local var_164_1 = 0.8

			if var_164_0 < arg_161_1.time_ and arg_161_1.time_ <= var_164_0 + arg_164_0 then
				arg_161_1.talkMaxDuration = 0
				arg_161_1.dialogCg_.alpha = 1

				arg_161_1.dialog_:SetActive(true)
				SetActive(arg_161_1.leftNameGo_, true)

				local var_164_2 = arg_161_1:FormatText(StoryNameCfg[584].name)

				arg_161_1.leftNameTxt_.text = var_164_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_161_1.leftNameTxt_.transform)

				arg_161_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_161_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_161_1:RecordName(arg_161_1.leftNameTxt_.text)
				SetActive(arg_161_1.iconTrs_.gameObject, false)
				arg_161_1.callingController_:SetSelectedState("normal")

				local var_164_3 = arg_161_1:GetWordFromCfg(410082039)
				local var_164_4 = arg_161_1:FormatText(var_164_3.content)

				arg_161_1.text_.text = var_164_4

				LuaForUtil.ClearLinePrefixSymbol(arg_161_1.text_)

				local var_164_5 = 32
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

				if manager.audio:GetVoiceLength("story_v_out_410082", "410082039", "story_v_out_410082.awb") ~= 0 then
					local var_164_8 = manager.audio:GetVoiceLength("story_v_out_410082", "410082039", "story_v_out_410082.awb") / 1000

					if var_164_8 + var_164_0 > arg_161_1.duration_ then
						arg_161_1.duration_ = var_164_8 + var_164_0
					end

					if var_164_3.prefab_name ~= "" and arg_161_1.actors_[var_164_3.prefab_name] ~= nil then
						local var_164_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_161_1.actors_[var_164_3.prefab_name].transform, "story_v_out_410082", "410082039", "story_v_out_410082.awb")

						arg_161_1:RecordAudio("410082039", var_164_9)
						arg_161_1:RecordAudio("410082039", var_164_9)
					else
						arg_161_1:AudioAction("play", "voice", "story_v_out_410082", "410082039", "story_v_out_410082.awb")
					end

					arg_161_1:RecordHistoryTalkVoice("story_v_out_410082", "410082039", "story_v_out_410082.awb")
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
	Play410082040 = function(arg_165_0, arg_165_1)
		arg_165_1.time_ = 0
		arg_165_1.frameCnt_ = 0
		arg_165_1.state_ = "playing"
		arg_165_1.curTalkId_ = 410082040
		arg_165_1.duration_ = 7.5

		local var_165_0 = {
			zh = 3.333,
			ja = 7.5
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
				arg_165_0:Play410082041(arg_165_1)
			end
		end

		function arg_165_1.onSingleLineUpdate_(arg_168_0)
			local var_168_0 = arg_165_1.actors_["1056"].transform
			local var_168_1 = 0

			if var_168_1 < arg_165_1.time_ and arg_165_1.time_ <= var_168_1 + arg_168_0 then
				arg_165_1.var_.moveOldPos1056 = var_168_0.localPosition
				var_168_0.localScale = Vector3.New(1, 1, 1)

				arg_165_1:CheckSpriteTmpPos("1056", 4)

				local var_168_2 = var_168_0.childCount

				for iter_168_0 = 0, var_168_2 - 1 do
					local var_168_3 = var_168_0:GetChild(iter_168_0)

					if var_168_3.name == "split_2" or not string.find(var_168_3.name, "split") then
						var_168_3.gameObject:SetActive(true)
					else
						var_168_3.gameObject:SetActive(false)
					end
				end
			end

			local var_168_4 = 0.001

			if var_168_1 <= arg_165_1.time_ and arg_165_1.time_ < var_168_1 + var_168_4 then
				local var_168_5 = (arg_165_1.time_ - var_168_1) / var_168_4
				local var_168_6 = Vector3.New(390, -350, -180)

				var_168_0.localPosition = Vector3.Lerp(arg_165_1.var_.moveOldPos1056, var_168_6, var_168_5)
			end

			if arg_165_1.time_ >= var_168_1 + var_168_4 and arg_165_1.time_ < var_168_1 + var_168_4 + arg_168_0 then
				var_168_0.localPosition = Vector3.New(390, -350, -180)
			end

			local var_168_7 = arg_165_1.actors_["1056"]
			local var_168_8 = 0

			if var_168_8 < arg_165_1.time_ and arg_165_1.time_ <= var_168_8 + arg_168_0 and not isNil(var_168_7) and arg_165_1.var_.actorSpriteComps1056 == nil then
				arg_165_1.var_.actorSpriteComps1056 = var_168_7:GetComponentsInChildren(typeof(Image), true)
			end

			local var_168_9 = 0.034

			if var_168_8 <= arg_165_1.time_ and arg_165_1.time_ < var_168_8 + var_168_9 and not isNil(var_168_7) then
				local var_168_10 = (arg_165_1.time_ - var_168_8) / var_168_9

				if arg_165_1.var_.actorSpriteComps1056 then
					for iter_168_1, iter_168_2 in pairs(arg_165_1.var_.actorSpriteComps1056:ToTable()) do
						if iter_168_2 then
							if arg_165_1.isInRecall_ then
								local var_168_11 = Mathf.Lerp(iter_168_2.color.r, arg_165_1.hightColor1.r, var_168_10)
								local var_168_12 = Mathf.Lerp(iter_168_2.color.g, arg_165_1.hightColor1.g, var_168_10)
								local var_168_13 = Mathf.Lerp(iter_168_2.color.b, arg_165_1.hightColor1.b, var_168_10)

								iter_168_2.color = Color.New(var_168_11, var_168_12, var_168_13)
							else
								local var_168_14 = Mathf.Lerp(iter_168_2.color.r, 1, var_168_10)

								iter_168_2.color = Color.New(var_168_14, var_168_14, var_168_14)
							end
						end
					end
				end
			end

			if arg_165_1.time_ >= var_168_8 + var_168_9 and arg_165_1.time_ < var_168_8 + var_168_9 + arg_168_0 and not isNil(var_168_7) and arg_165_1.var_.actorSpriteComps1056 then
				for iter_168_3, iter_168_4 in pairs(arg_165_1.var_.actorSpriteComps1056:ToTable()) do
					if iter_168_4 then
						if arg_165_1.isInRecall_ then
							iter_168_4.color = arg_165_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_168_4.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_165_1.var_.actorSpriteComps1056 = nil
			end

			local var_168_15 = arg_165_1.actors_["1060"]
			local var_168_16 = 0

			if var_168_16 < arg_165_1.time_ and arg_165_1.time_ <= var_168_16 + arg_168_0 and not isNil(var_168_15) and arg_165_1.var_.actorSpriteComps1060 == nil then
				arg_165_1.var_.actorSpriteComps1060 = var_168_15:GetComponentsInChildren(typeof(Image), true)
			end

			local var_168_17 = 0.034

			if var_168_16 <= arg_165_1.time_ and arg_165_1.time_ < var_168_16 + var_168_17 and not isNil(var_168_15) then
				local var_168_18 = (arg_165_1.time_ - var_168_16) / var_168_17

				if arg_165_1.var_.actorSpriteComps1060 then
					for iter_168_5, iter_168_6 in pairs(arg_165_1.var_.actorSpriteComps1060:ToTable()) do
						if iter_168_6 then
							if arg_165_1.isInRecall_ then
								local var_168_19 = Mathf.Lerp(iter_168_6.color.r, arg_165_1.hightColor2.r, var_168_18)
								local var_168_20 = Mathf.Lerp(iter_168_6.color.g, arg_165_1.hightColor2.g, var_168_18)
								local var_168_21 = Mathf.Lerp(iter_168_6.color.b, arg_165_1.hightColor2.b, var_168_18)

								iter_168_6.color = Color.New(var_168_19, var_168_20, var_168_21)
							else
								local var_168_22 = Mathf.Lerp(iter_168_6.color.r, 0.5, var_168_18)

								iter_168_6.color = Color.New(var_168_22, var_168_22, var_168_22)
							end
						end
					end
				end
			end

			if arg_165_1.time_ >= var_168_16 + var_168_17 and arg_165_1.time_ < var_168_16 + var_168_17 + arg_168_0 and not isNil(var_168_15) and arg_165_1.var_.actorSpriteComps1060 then
				for iter_168_7, iter_168_8 in pairs(arg_165_1.var_.actorSpriteComps1060:ToTable()) do
					if iter_168_8 then
						if arg_165_1.isInRecall_ then
							iter_168_8.color = arg_165_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_168_8.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_165_1.var_.actorSpriteComps1060 = nil
			end

			local var_168_23 = 0
			local var_168_24 = 0.375

			if var_168_23 < arg_165_1.time_ and arg_165_1.time_ <= var_168_23 + arg_168_0 then
				arg_165_1.talkMaxDuration = 0
				arg_165_1.dialogCg_.alpha = 1

				arg_165_1.dialog_:SetActive(true)
				SetActive(arg_165_1.leftNameGo_, true)

				local var_168_25 = arg_165_1:FormatText(StoryNameCfg[605].name)

				arg_165_1.leftNameTxt_.text = var_168_25

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_165_1.leftNameTxt_.transform)

				arg_165_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_165_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_165_1:RecordName(arg_165_1.leftNameTxt_.text)
				SetActive(arg_165_1.iconTrs_.gameObject, false)
				arg_165_1.callingController_:SetSelectedState("normal")

				local var_168_26 = arg_165_1:GetWordFromCfg(410082040)
				local var_168_27 = arg_165_1:FormatText(var_168_26.content)

				arg_165_1.text_.text = var_168_27

				LuaForUtil.ClearLinePrefixSymbol(arg_165_1.text_)

				local var_168_28 = 15
				local var_168_29 = utf8.len(var_168_27)
				local var_168_30 = var_168_28 <= 0 and var_168_24 or var_168_24 * (var_168_29 / var_168_28)

				if var_168_30 > 0 and var_168_24 < var_168_30 then
					arg_165_1.talkMaxDuration = var_168_30

					if var_168_30 + var_168_23 > arg_165_1.duration_ then
						arg_165_1.duration_ = var_168_30 + var_168_23
					end
				end

				arg_165_1.text_.text = var_168_27
				arg_165_1.typewritter.percent = 0

				arg_165_1.typewritter:SetDirty()
				arg_165_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_410082", "410082040", "story_v_out_410082.awb") ~= 0 then
					local var_168_31 = manager.audio:GetVoiceLength("story_v_out_410082", "410082040", "story_v_out_410082.awb") / 1000

					if var_168_31 + var_168_23 > arg_165_1.duration_ then
						arg_165_1.duration_ = var_168_31 + var_168_23
					end

					if var_168_26.prefab_name ~= "" and arg_165_1.actors_[var_168_26.prefab_name] ~= nil then
						local var_168_32 = LuaForUtil.PlayVoiceWithCriLipsync(arg_165_1.actors_[var_168_26.prefab_name].transform, "story_v_out_410082", "410082040", "story_v_out_410082.awb")

						arg_165_1:RecordAudio("410082040", var_168_32)
						arg_165_1:RecordAudio("410082040", var_168_32)
					else
						arg_165_1:AudioAction("play", "voice", "story_v_out_410082", "410082040", "story_v_out_410082.awb")
					end

					arg_165_1:RecordHistoryTalkVoice("story_v_out_410082", "410082040", "story_v_out_410082.awb")
				end

				arg_165_1:RecordContent(arg_165_1.text_.text)
			end

			local var_168_33 = math.max(var_168_24, arg_165_1.talkMaxDuration)

			if var_168_23 <= arg_165_1.time_ and arg_165_1.time_ < var_168_23 + var_168_33 then
				arg_165_1.typewritter.percent = (arg_165_1.time_ - var_168_23) / var_168_33

				arg_165_1.typewritter:SetDirty()
			end

			if arg_165_1.time_ >= var_168_23 + var_168_33 and arg_165_1.time_ < var_168_23 + var_168_33 + arg_168_0 then
				arg_165_1.typewritter.percent = 1

				arg_165_1.typewritter:SetDirty()
				arg_165_1:ShowNextGo(true)
			end
		end

		arg_165_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1056",
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
	Play410082041 = function(arg_169_0, arg_169_1)
		arg_169_1.time_ = 0
		arg_169_1.frameCnt_ = 0
		arg_169_1.state_ = "playing"
		arg_169_1.curTalkId_ = 410082041
		arg_169_1.duration_ = 11.93

		local var_169_0 = {
			zh = 5,
			ja = 11.933
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
				arg_169_0:Play410082042(arg_169_1)
			end
		end

		function arg_169_1.onSingleLineUpdate_(arg_172_0)
			local var_172_0 = arg_169_1.actors_["1060"].transform
			local var_172_1 = 0

			if var_172_1 < arg_169_1.time_ and arg_169_1.time_ <= var_172_1 + arg_172_0 then
				arg_169_1.var_.moveOldPos1060 = var_172_0.localPosition
				var_172_0.localScale = Vector3.New(1, 1, 1)

				arg_169_1:CheckSpriteTmpPos("1060", 2)

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
				local var_172_6 = Vector3.New(-440.94, -430.8, 6.9)

				var_172_0.localPosition = Vector3.Lerp(arg_169_1.var_.moveOldPos1060, var_172_6, var_172_5)
			end

			if arg_169_1.time_ >= var_172_1 + var_172_4 and arg_169_1.time_ < var_172_1 + var_172_4 + arg_172_0 then
				var_172_0.localPosition = Vector3.New(-440.94, -430.8, 6.9)
			end

			local var_172_7 = arg_169_1.actors_["1060"]
			local var_172_8 = 0

			if var_172_8 < arg_169_1.time_ and arg_169_1.time_ <= var_172_8 + arg_172_0 and not isNil(var_172_7) and arg_169_1.var_.actorSpriteComps1060 == nil then
				arg_169_1.var_.actorSpriteComps1060 = var_172_7:GetComponentsInChildren(typeof(Image), true)
			end

			local var_172_9 = 0.034

			if var_172_8 <= arg_169_1.time_ and arg_169_1.time_ < var_172_8 + var_172_9 and not isNil(var_172_7) then
				local var_172_10 = (arg_169_1.time_ - var_172_8) / var_172_9

				if arg_169_1.var_.actorSpriteComps1060 then
					for iter_172_1, iter_172_2 in pairs(arg_169_1.var_.actorSpriteComps1060:ToTable()) do
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

			if arg_169_1.time_ >= var_172_8 + var_172_9 and arg_169_1.time_ < var_172_8 + var_172_9 + arg_172_0 and not isNil(var_172_7) and arg_169_1.var_.actorSpriteComps1060 then
				for iter_172_3, iter_172_4 in pairs(arg_169_1.var_.actorSpriteComps1060:ToTable()) do
					if iter_172_4 then
						if arg_169_1.isInRecall_ then
							iter_172_4.color = arg_169_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_172_4.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_169_1.var_.actorSpriteComps1060 = nil
			end

			local var_172_15 = arg_169_1.actors_["1056"]
			local var_172_16 = 0

			if var_172_16 < arg_169_1.time_ and arg_169_1.time_ <= var_172_16 + arg_172_0 and not isNil(var_172_15) and arg_169_1.var_.actorSpriteComps1056 == nil then
				arg_169_1.var_.actorSpriteComps1056 = var_172_15:GetComponentsInChildren(typeof(Image), true)
			end

			local var_172_17 = 0.034

			if var_172_16 <= arg_169_1.time_ and arg_169_1.time_ < var_172_16 + var_172_17 and not isNil(var_172_15) then
				local var_172_18 = (arg_169_1.time_ - var_172_16) / var_172_17

				if arg_169_1.var_.actorSpriteComps1056 then
					for iter_172_5, iter_172_6 in pairs(arg_169_1.var_.actorSpriteComps1056:ToTable()) do
						if iter_172_6 then
							if arg_169_1.isInRecall_ then
								local var_172_19 = Mathf.Lerp(iter_172_6.color.r, arg_169_1.hightColor2.r, var_172_18)
								local var_172_20 = Mathf.Lerp(iter_172_6.color.g, arg_169_1.hightColor2.g, var_172_18)
								local var_172_21 = Mathf.Lerp(iter_172_6.color.b, arg_169_1.hightColor2.b, var_172_18)

								iter_172_6.color = Color.New(var_172_19, var_172_20, var_172_21)
							else
								local var_172_22 = Mathf.Lerp(iter_172_6.color.r, 0.5, var_172_18)

								iter_172_6.color = Color.New(var_172_22, var_172_22, var_172_22)
							end
						end
					end
				end
			end

			if arg_169_1.time_ >= var_172_16 + var_172_17 and arg_169_1.time_ < var_172_16 + var_172_17 + arg_172_0 and not isNil(var_172_15) and arg_169_1.var_.actorSpriteComps1056 then
				for iter_172_7, iter_172_8 in pairs(arg_169_1.var_.actorSpriteComps1056:ToTable()) do
					if iter_172_8 then
						if arg_169_1.isInRecall_ then
							iter_172_8.color = arg_169_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_172_8.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_169_1.var_.actorSpriteComps1056 = nil
			end

			local var_172_23 = 0
			local var_172_24 = 0.55

			if var_172_23 < arg_169_1.time_ and arg_169_1.time_ <= var_172_23 + arg_172_0 then
				arg_169_1.talkMaxDuration = 0
				arg_169_1.dialogCg_.alpha = 1

				arg_169_1.dialog_:SetActive(true)
				SetActive(arg_169_1.leftNameGo_, true)

				local var_172_25 = arg_169_1:FormatText(StoryNameCfg[584].name)

				arg_169_1.leftNameTxt_.text = var_172_25

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_169_1.leftNameTxt_.transform)

				arg_169_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_169_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_169_1:RecordName(arg_169_1.leftNameTxt_.text)
				SetActive(arg_169_1.iconTrs_.gameObject, false)
				arg_169_1.callingController_:SetSelectedState("normal")

				local var_172_26 = arg_169_1:GetWordFromCfg(410082041)
				local var_172_27 = arg_169_1:FormatText(var_172_26.content)

				arg_169_1.text_.text = var_172_27

				LuaForUtil.ClearLinePrefixSymbol(arg_169_1.text_)

				local var_172_28 = 22
				local var_172_29 = utf8.len(var_172_27)
				local var_172_30 = var_172_28 <= 0 and var_172_24 or var_172_24 * (var_172_29 / var_172_28)

				if var_172_30 > 0 and var_172_24 < var_172_30 then
					arg_169_1.talkMaxDuration = var_172_30

					if var_172_30 + var_172_23 > arg_169_1.duration_ then
						arg_169_1.duration_ = var_172_30 + var_172_23
					end
				end

				arg_169_1.text_.text = var_172_27
				arg_169_1.typewritter.percent = 0

				arg_169_1.typewritter:SetDirty()
				arg_169_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_410082", "410082041", "story_v_out_410082.awb") ~= 0 then
					local var_172_31 = manager.audio:GetVoiceLength("story_v_out_410082", "410082041", "story_v_out_410082.awb") / 1000

					if var_172_31 + var_172_23 > arg_169_1.duration_ then
						arg_169_1.duration_ = var_172_31 + var_172_23
					end

					if var_172_26.prefab_name ~= "" and arg_169_1.actors_[var_172_26.prefab_name] ~= nil then
						local var_172_32 = LuaForUtil.PlayVoiceWithCriLipsync(arg_169_1.actors_[var_172_26.prefab_name].transform, "story_v_out_410082", "410082041", "story_v_out_410082.awb")

						arg_169_1:RecordAudio("410082041", var_172_32)
						arg_169_1:RecordAudio("410082041", var_172_32)
					else
						arg_169_1:AudioAction("play", "voice", "story_v_out_410082", "410082041", "story_v_out_410082.awb")
					end

					arg_169_1:RecordHistoryTalkVoice("story_v_out_410082", "410082041", "story_v_out_410082.awb")
				end

				arg_169_1:RecordContent(arg_169_1.text_.text)
			end

			local var_172_33 = math.max(var_172_24, arg_169_1.talkMaxDuration)

			if var_172_23 <= arg_169_1.time_ and arg_169_1.time_ < var_172_23 + var_172_33 then
				arg_169_1.typewritter.percent = (arg_169_1.time_ - var_172_23) / var_172_33

				arg_169_1.typewritter:SetDirty()
			end

			if arg_169_1.time_ >= var_172_23 + var_172_33 and arg_169_1.time_ < var_172_23 + var_172_33 + arg_172_0 then
				arg_169_1.typewritter.percent = 1

				arg_169_1.typewritter:SetDirty()
				arg_169_1:ShowNextGo(true)
			end
		end

		arg_169_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1060",
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
	Play410082042 = function(arg_173_0, arg_173_1)
		arg_173_1.time_ = 0
		arg_173_1.frameCnt_ = 0
		arg_173_1.state_ = "playing"
		arg_173_1.curTalkId_ = 410082042
		arg_173_1.duration_ = 9.07

		local var_173_0 = {
			zh = 7.266,
			ja = 9.066
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
				arg_173_0:Play410082043(arg_173_1)
			end
		end

		function arg_173_1.onSingleLineUpdate_(arg_176_0)
			local var_176_0 = 0
			local var_176_1 = 0.725

			if var_176_0 < arg_173_1.time_ and arg_173_1.time_ <= var_176_0 + arg_176_0 then
				arg_173_1.talkMaxDuration = 0
				arg_173_1.dialogCg_.alpha = 1

				arg_173_1.dialog_:SetActive(true)
				SetActive(arg_173_1.leftNameGo_, true)

				local var_176_2 = arg_173_1:FormatText(StoryNameCfg[584].name)

				arg_173_1.leftNameTxt_.text = var_176_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_173_1.leftNameTxt_.transform)

				arg_173_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_173_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_173_1:RecordName(arg_173_1.leftNameTxt_.text)
				SetActive(arg_173_1.iconTrs_.gameObject, false)
				arg_173_1.callingController_:SetSelectedState("normal")

				local var_176_3 = arg_173_1:GetWordFromCfg(410082042)
				local var_176_4 = arg_173_1:FormatText(var_176_3.content)

				arg_173_1.text_.text = var_176_4

				LuaForUtil.ClearLinePrefixSymbol(arg_173_1.text_)

				local var_176_5 = 29
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

				if manager.audio:GetVoiceLength("story_v_out_410082", "410082042", "story_v_out_410082.awb") ~= 0 then
					local var_176_8 = manager.audio:GetVoiceLength("story_v_out_410082", "410082042", "story_v_out_410082.awb") / 1000

					if var_176_8 + var_176_0 > arg_173_1.duration_ then
						arg_173_1.duration_ = var_176_8 + var_176_0
					end

					if var_176_3.prefab_name ~= "" and arg_173_1.actors_[var_176_3.prefab_name] ~= nil then
						local var_176_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_173_1.actors_[var_176_3.prefab_name].transform, "story_v_out_410082", "410082042", "story_v_out_410082.awb")

						arg_173_1:RecordAudio("410082042", var_176_9)
						arg_173_1:RecordAudio("410082042", var_176_9)
					else
						arg_173_1:AudioAction("play", "voice", "story_v_out_410082", "410082042", "story_v_out_410082.awb")
					end

					arg_173_1:RecordHistoryTalkVoice("story_v_out_410082", "410082042", "story_v_out_410082.awb")
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
	Play410082043 = function(arg_177_0, arg_177_1)
		arg_177_1.time_ = 0
		arg_177_1.frameCnt_ = 0
		arg_177_1.state_ = "playing"
		arg_177_1.curTalkId_ = 410082043
		arg_177_1.duration_ = 9.8

		local var_177_0 = {
			zh = 9.2,
			ja = 9.8
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
				arg_177_0:Play410082044(arg_177_1)
			end
		end

		function arg_177_1.onSingleLineUpdate_(arg_180_0)
			local var_180_0 = arg_177_1.actors_["1056"].transform
			local var_180_1 = 0

			if var_180_1 < arg_177_1.time_ and arg_177_1.time_ <= var_180_1 + arg_180_0 then
				arg_177_1.var_.moveOldPos1056 = var_180_0.localPosition
				var_180_0.localScale = Vector3.New(1, 1, 1)

				arg_177_1:CheckSpriteTmpPos("1056", 4)

				local var_180_2 = var_180_0.childCount

				for iter_180_0 = 0, var_180_2 - 1 do
					local var_180_3 = var_180_0:GetChild(iter_180_0)

					if var_180_3.name == "split_2" or not string.find(var_180_3.name, "split") then
						var_180_3.gameObject:SetActive(true)
					else
						var_180_3.gameObject:SetActive(false)
					end
				end
			end

			local var_180_4 = 0.001

			if var_180_1 <= arg_177_1.time_ and arg_177_1.time_ < var_180_1 + var_180_4 then
				local var_180_5 = (arg_177_1.time_ - var_180_1) / var_180_4
				local var_180_6 = Vector3.New(390, -350, -180)

				var_180_0.localPosition = Vector3.Lerp(arg_177_1.var_.moveOldPos1056, var_180_6, var_180_5)
			end

			if arg_177_1.time_ >= var_180_1 + var_180_4 and arg_177_1.time_ < var_180_1 + var_180_4 + arg_180_0 then
				var_180_0.localPosition = Vector3.New(390, -350, -180)
			end

			local var_180_7 = arg_177_1.actors_["1056"]
			local var_180_8 = 0

			if var_180_8 < arg_177_1.time_ and arg_177_1.time_ <= var_180_8 + arg_180_0 and not isNil(var_180_7) and arg_177_1.var_.actorSpriteComps1056 == nil then
				arg_177_1.var_.actorSpriteComps1056 = var_180_7:GetComponentsInChildren(typeof(Image), true)
			end

			local var_180_9 = 0.034

			if var_180_8 <= arg_177_1.time_ and arg_177_1.time_ < var_180_8 + var_180_9 and not isNil(var_180_7) then
				local var_180_10 = (arg_177_1.time_ - var_180_8) / var_180_9

				if arg_177_1.var_.actorSpriteComps1056 then
					for iter_180_1, iter_180_2 in pairs(arg_177_1.var_.actorSpriteComps1056:ToTable()) do
						if iter_180_2 then
							if arg_177_1.isInRecall_ then
								local var_180_11 = Mathf.Lerp(iter_180_2.color.r, arg_177_1.hightColor1.r, var_180_10)
								local var_180_12 = Mathf.Lerp(iter_180_2.color.g, arg_177_1.hightColor1.g, var_180_10)
								local var_180_13 = Mathf.Lerp(iter_180_2.color.b, arg_177_1.hightColor1.b, var_180_10)

								iter_180_2.color = Color.New(var_180_11, var_180_12, var_180_13)
							else
								local var_180_14 = Mathf.Lerp(iter_180_2.color.r, 1, var_180_10)

								iter_180_2.color = Color.New(var_180_14, var_180_14, var_180_14)
							end
						end
					end
				end
			end

			if arg_177_1.time_ >= var_180_8 + var_180_9 and arg_177_1.time_ < var_180_8 + var_180_9 + arg_180_0 and not isNil(var_180_7) and arg_177_1.var_.actorSpriteComps1056 then
				for iter_180_3, iter_180_4 in pairs(arg_177_1.var_.actorSpriteComps1056:ToTable()) do
					if iter_180_4 then
						if arg_177_1.isInRecall_ then
							iter_180_4.color = arg_177_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_180_4.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_177_1.var_.actorSpriteComps1056 = nil
			end

			local var_180_15 = arg_177_1.actors_["1060"]
			local var_180_16 = 0

			if var_180_16 < arg_177_1.time_ and arg_177_1.time_ <= var_180_16 + arg_180_0 and not isNil(var_180_15) and arg_177_1.var_.actorSpriteComps1060 == nil then
				arg_177_1.var_.actorSpriteComps1060 = var_180_15:GetComponentsInChildren(typeof(Image), true)
			end

			local var_180_17 = 0.034

			if var_180_16 <= arg_177_1.time_ and arg_177_1.time_ < var_180_16 + var_180_17 and not isNil(var_180_15) then
				local var_180_18 = (arg_177_1.time_ - var_180_16) / var_180_17

				if arg_177_1.var_.actorSpriteComps1060 then
					for iter_180_5, iter_180_6 in pairs(arg_177_1.var_.actorSpriteComps1060:ToTable()) do
						if iter_180_6 then
							if arg_177_1.isInRecall_ then
								local var_180_19 = Mathf.Lerp(iter_180_6.color.r, arg_177_1.hightColor2.r, var_180_18)
								local var_180_20 = Mathf.Lerp(iter_180_6.color.g, arg_177_1.hightColor2.g, var_180_18)
								local var_180_21 = Mathf.Lerp(iter_180_6.color.b, arg_177_1.hightColor2.b, var_180_18)

								iter_180_6.color = Color.New(var_180_19, var_180_20, var_180_21)
							else
								local var_180_22 = Mathf.Lerp(iter_180_6.color.r, 0.5, var_180_18)

								iter_180_6.color = Color.New(var_180_22, var_180_22, var_180_22)
							end
						end
					end
				end
			end

			if arg_177_1.time_ >= var_180_16 + var_180_17 and arg_177_1.time_ < var_180_16 + var_180_17 + arg_180_0 and not isNil(var_180_15) and arg_177_1.var_.actorSpriteComps1060 then
				for iter_180_7, iter_180_8 in pairs(arg_177_1.var_.actorSpriteComps1060:ToTable()) do
					if iter_180_8 then
						if arg_177_1.isInRecall_ then
							iter_180_8.color = arg_177_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_180_8.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_177_1.var_.actorSpriteComps1060 = nil
			end

			local var_180_23 = 0
			local var_180_24 = 1.025

			if var_180_23 < arg_177_1.time_ and arg_177_1.time_ <= var_180_23 + arg_180_0 then
				arg_177_1.talkMaxDuration = 0
				arg_177_1.dialogCg_.alpha = 1

				arg_177_1.dialog_:SetActive(true)
				SetActive(arg_177_1.leftNameGo_, true)

				local var_180_25 = arg_177_1:FormatText(StoryNameCfg[605].name)

				arg_177_1.leftNameTxt_.text = var_180_25

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_177_1.leftNameTxt_.transform)

				arg_177_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_177_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_177_1:RecordName(arg_177_1.leftNameTxt_.text)
				SetActive(arg_177_1.iconTrs_.gameObject, false)
				arg_177_1.callingController_:SetSelectedState("normal")

				local var_180_26 = arg_177_1:GetWordFromCfg(410082043)
				local var_180_27 = arg_177_1:FormatText(var_180_26.content)

				arg_177_1.text_.text = var_180_27

				LuaForUtil.ClearLinePrefixSymbol(arg_177_1.text_)

				local var_180_28 = 41
				local var_180_29 = utf8.len(var_180_27)
				local var_180_30 = var_180_28 <= 0 and var_180_24 or var_180_24 * (var_180_29 / var_180_28)

				if var_180_30 > 0 and var_180_24 < var_180_30 then
					arg_177_1.talkMaxDuration = var_180_30

					if var_180_30 + var_180_23 > arg_177_1.duration_ then
						arg_177_1.duration_ = var_180_30 + var_180_23
					end
				end

				arg_177_1.text_.text = var_180_27
				arg_177_1.typewritter.percent = 0

				arg_177_1.typewritter:SetDirty()
				arg_177_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_410082", "410082043", "story_v_out_410082.awb") ~= 0 then
					local var_180_31 = manager.audio:GetVoiceLength("story_v_out_410082", "410082043", "story_v_out_410082.awb") / 1000

					if var_180_31 + var_180_23 > arg_177_1.duration_ then
						arg_177_1.duration_ = var_180_31 + var_180_23
					end

					if var_180_26.prefab_name ~= "" and arg_177_1.actors_[var_180_26.prefab_name] ~= nil then
						local var_180_32 = LuaForUtil.PlayVoiceWithCriLipsync(arg_177_1.actors_[var_180_26.prefab_name].transform, "story_v_out_410082", "410082043", "story_v_out_410082.awb")

						arg_177_1:RecordAudio("410082043", var_180_32)
						arg_177_1:RecordAudio("410082043", var_180_32)
					else
						arg_177_1:AudioAction("play", "voice", "story_v_out_410082", "410082043", "story_v_out_410082.awb")
					end

					arg_177_1:RecordHistoryTalkVoice("story_v_out_410082", "410082043", "story_v_out_410082.awb")
				end

				arg_177_1:RecordContent(arg_177_1.text_.text)
			end

			local var_180_33 = math.max(var_180_24, arg_177_1.talkMaxDuration)

			if var_180_23 <= arg_177_1.time_ and arg_177_1.time_ < var_180_23 + var_180_33 then
				arg_177_1.typewritter.percent = (arg_177_1.time_ - var_180_23) / var_180_33

				arg_177_1.typewritter:SetDirty()
			end

			if arg_177_1.time_ >= var_180_23 + var_180_33 and arg_177_1.time_ < var_180_23 + var_180_33 + arg_180_0 then
				arg_177_1.typewritter.percent = 1

				arg_177_1.typewritter:SetDirty()
				arg_177_1:ShowNextGo(true)
			end
		end

		arg_177_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1056",
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
	Play410082044 = function(arg_181_0, arg_181_1)
		arg_181_1.time_ = 0
		arg_181_1.frameCnt_ = 0
		arg_181_1.state_ = "playing"
		arg_181_1.curTalkId_ = 410082044
		arg_181_1.duration_ = 8.47

		local var_181_0 = {
			zh = 5.3,
			ja = 8.466
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
				arg_181_0:Play410082045(arg_181_1)
			end
		end

		function arg_181_1.onSingleLineUpdate_(arg_184_0)
			local var_184_0 = 0
			local var_184_1 = 0.75

			if var_184_0 < arg_181_1.time_ and arg_181_1.time_ <= var_184_0 + arg_184_0 then
				arg_181_1.talkMaxDuration = 0
				arg_181_1.dialogCg_.alpha = 1

				arg_181_1.dialog_:SetActive(true)
				SetActive(arg_181_1.leftNameGo_, true)

				local var_184_2 = arg_181_1:FormatText(StoryNameCfg[605].name)

				arg_181_1.leftNameTxt_.text = var_184_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_181_1.leftNameTxt_.transform)

				arg_181_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_181_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_181_1:RecordName(arg_181_1.leftNameTxt_.text)
				SetActive(arg_181_1.iconTrs_.gameObject, false)
				arg_181_1.callingController_:SetSelectedState("normal")

				local var_184_3 = arg_181_1:GetWordFromCfg(410082044)
				local var_184_4 = arg_181_1:FormatText(var_184_3.content)

				arg_181_1.text_.text = var_184_4

				LuaForUtil.ClearLinePrefixSymbol(arg_181_1.text_)

				local var_184_5 = 30
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

				if manager.audio:GetVoiceLength("story_v_out_410082", "410082044", "story_v_out_410082.awb") ~= 0 then
					local var_184_8 = manager.audio:GetVoiceLength("story_v_out_410082", "410082044", "story_v_out_410082.awb") / 1000

					if var_184_8 + var_184_0 > arg_181_1.duration_ then
						arg_181_1.duration_ = var_184_8 + var_184_0
					end

					if var_184_3.prefab_name ~= "" and arg_181_1.actors_[var_184_3.prefab_name] ~= nil then
						local var_184_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_181_1.actors_[var_184_3.prefab_name].transform, "story_v_out_410082", "410082044", "story_v_out_410082.awb")

						arg_181_1:RecordAudio("410082044", var_184_9)
						arg_181_1:RecordAudio("410082044", var_184_9)
					else
						arg_181_1:AudioAction("play", "voice", "story_v_out_410082", "410082044", "story_v_out_410082.awb")
					end

					arg_181_1:RecordHistoryTalkVoice("story_v_out_410082", "410082044", "story_v_out_410082.awb")
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
	Play410082045 = function(arg_185_0, arg_185_1)
		arg_185_1.time_ = 0
		arg_185_1.frameCnt_ = 0
		arg_185_1.state_ = "playing"
		arg_185_1.curTalkId_ = 410082045
		arg_185_1.duration_ = 5

		SetActive(arg_185_1.tipsGo_, false)

		function arg_185_1.onSingleLineFinish_()
			arg_185_1.onSingleLineUpdate_ = nil
			arg_185_1.onSingleLineFinish_ = nil
			arg_185_1.state_ = "waiting"
		end

		function arg_185_1.playNext_(arg_187_0)
			if arg_187_0 == 1 then
				arg_185_0:Play410082046(arg_185_1)
			end
		end

		function arg_185_1.onSingleLineUpdate_(arg_188_0)
			local var_188_0 = arg_185_1.actors_["1056"]
			local var_188_1 = 0

			if var_188_1 < arg_185_1.time_ and arg_185_1.time_ <= var_188_1 + arg_188_0 and not isNil(var_188_0) and arg_185_1.var_.actorSpriteComps1056 == nil then
				arg_185_1.var_.actorSpriteComps1056 = var_188_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_188_2 = 0.034

			if var_188_1 <= arg_185_1.time_ and arg_185_1.time_ < var_188_1 + var_188_2 and not isNil(var_188_0) then
				local var_188_3 = (arg_185_1.time_ - var_188_1) / var_188_2

				if arg_185_1.var_.actorSpriteComps1056 then
					for iter_188_0, iter_188_1 in pairs(arg_185_1.var_.actorSpriteComps1056:ToTable()) do
						if iter_188_1 then
							if arg_185_1.isInRecall_ then
								local var_188_4 = Mathf.Lerp(iter_188_1.color.r, arg_185_1.hightColor2.r, var_188_3)
								local var_188_5 = Mathf.Lerp(iter_188_1.color.g, arg_185_1.hightColor2.g, var_188_3)
								local var_188_6 = Mathf.Lerp(iter_188_1.color.b, arg_185_1.hightColor2.b, var_188_3)

								iter_188_1.color = Color.New(var_188_4, var_188_5, var_188_6)
							else
								local var_188_7 = Mathf.Lerp(iter_188_1.color.r, 0.5, var_188_3)

								iter_188_1.color = Color.New(var_188_7, var_188_7, var_188_7)
							end
						end
					end
				end
			end

			if arg_185_1.time_ >= var_188_1 + var_188_2 and arg_185_1.time_ < var_188_1 + var_188_2 + arg_188_0 and not isNil(var_188_0) and arg_185_1.var_.actorSpriteComps1056 then
				for iter_188_2, iter_188_3 in pairs(arg_185_1.var_.actorSpriteComps1056:ToTable()) do
					if iter_188_3 then
						if arg_185_1.isInRecall_ then
							iter_188_3.color = arg_185_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_188_3.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_185_1.var_.actorSpriteComps1056 = nil
			end

			local var_188_8 = 0
			local var_188_9 = 1.3

			if var_188_8 < arg_185_1.time_ and arg_185_1.time_ <= var_188_8 + arg_188_0 then
				arg_185_1.talkMaxDuration = 0
				arg_185_1.dialogCg_.alpha = 1

				arg_185_1.dialog_:SetActive(true)
				SetActive(arg_185_1.leftNameGo_, false)

				arg_185_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_185_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_185_1:RecordName(arg_185_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_185_1.iconTrs_.gameObject, false)
				arg_185_1.callingController_:SetSelectedState("normal")

				local var_188_10 = arg_185_1:GetWordFromCfg(410082045)
				local var_188_11 = arg_185_1:FormatText(var_188_10.content)

				arg_185_1.text_.text = var_188_11

				LuaForUtil.ClearLinePrefixSymbol(arg_185_1.text_)

				local var_188_12 = 52
				local var_188_13 = utf8.len(var_188_11)
				local var_188_14 = var_188_12 <= 0 and var_188_9 or var_188_9 * (var_188_13 / var_188_12)

				if var_188_14 > 0 and var_188_9 < var_188_14 then
					arg_185_1.talkMaxDuration = var_188_14

					if var_188_14 + var_188_8 > arg_185_1.duration_ then
						arg_185_1.duration_ = var_188_14 + var_188_8
					end
				end

				arg_185_1.text_.text = var_188_11
				arg_185_1.typewritter.percent = 0

				arg_185_1.typewritter:SetDirty()
				arg_185_1:ShowNextGo(false)
				arg_185_1:RecordContent(arg_185_1.text_.text)
			end

			local var_188_15 = math.max(var_188_9, arg_185_1.talkMaxDuration)

			if var_188_8 <= arg_185_1.time_ and arg_185_1.time_ < var_188_8 + var_188_15 then
				arg_185_1.typewritter.percent = (arg_185_1.time_ - var_188_8) / var_188_15

				arg_185_1.typewritter:SetDirty()
			end

			if arg_185_1.time_ >= var_188_8 + var_188_15 and arg_185_1.time_ < var_188_8 + var_188_15 + arg_188_0 then
				arg_185_1.typewritter.percent = 1

				arg_185_1.typewritter:SetDirty()
				arg_185_1:ShowNextGo(true)
			end
		end

		arg_185_1.nodeConfigList_ = {}

		arg_185_1:InitPlayNodeList()
	end,
	Play410082046 = function(arg_189_0, arg_189_1)
		arg_189_1.time_ = 0
		arg_189_1.frameCnt_ = 0
		arg_189_1.state_ = "playing"
		arg_189_1.curTalkId_ = 410082046
		arg_189_1.duration_ = 4.27

		local var_189_0 = {
			zh = 4.266,
			ja = 3.1
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
				arg_189_0:Play410082047(arg_189_1)
			end
		end

		function arg_189_1.onSingleLineUpdate_(arg_192_0)
			local var_192_0 = arg_189_1.actors_["1060"].transform
			local var_192_1 = 0

			if var_192_1 < arg_189_1.time_ and arg_189_1.time_ <= var_192_1 + arg_192_0 then
				arg_189_1.var_.moveOldPos1060 = var_192_0.localPosition
				var_192_0.localScale = Vector3.New(1, 1, 1)

				arg_189_1:CheckSpriteTmpPos("1060", 2)

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
				local var_192_6 = Vector3.New(-440.94, -430.8, 6.9)

				var_192_0.localPosition = Vector3.Lerp(arg_189_1.var_.moveOldPos1060, var_192_6, var_192_5)
			end

			if arg_189_1.time_ >= var_192_1 + var_192_4 and arg_189_1.time_ < var_192_1 + var_192_4 + arg_192_0 then
				var_192_0.localPosition = Vector3.New(-440.94, -430.8, 6.9)
			end

			local var_192_7 = arg_189_1.actors_["1060"]
			local var_192_8 = 0

			if var_192_8 < arg_189_1.time_ and arg_189_1.time_ <= var_192_8 + arg_192_0 and not isNil(var_192_7) and arg_189_1.var_.actorSpriteComps1060 == nil then
				arg_189_1.var_.actorSpriteComps1060 = var_192_7:GetComponentsInChildren(typeof(Image), true)
			end

			local var_192_9 = 0.034

			if var_192_8 <= arg_189_1.time_ and arg_189_1.time_ < var_192_8 + var_192_9 and not isNil(var_192_7) then
				local var_192_10 = (arg_189_1.time_ - var_192_8) / var_192_9

				if arg_189_1.var_.actorSpriteComps1060 then
					for iter_192_1, iter_192_2 in pairs(arg_189_1.var_.actorSpriteComps1060:ToTable()) do
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

			if arg_189_1.time_ >= var_192_8 + var_192_9 and arg_189_1.time_ < var_192_8 + var_192_9 + arg_192_0 and not isNil(var_192_7) and arg_189_1.var_.actorSpriteComps1060 then
				for iter_192_3, iter_192_4 in pairs(arg_189_1.var_.actorSpriteComps1060:ToTable()) do
					if iter_192_4 then
						if arg_189_1.isInRecall_ then
							iter_192_4.color = arg_189_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_192_4.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_189_1.var_.actorSpriteComps1060 = nil
			end

			local var_192_15 = 0
			local var_192_16 = 0.55

			if var_192_15 < arg_189_1.time_ and arg_189_1.time_ <= var_192_15 + arg_192_0 then
				arg_189_1.talkMaxDuration = 0
				arg_189_1.dialogCg_.alpha = 1

				arg_189_1.dialog_:SetActive(true)
				SetActive(arg_189_1.leftNameGo_, true)

				local var_192_17 = arg_189_1:FormatText(StoryNameCfg[584].name)

				arg_189_1.leftNameTxt_.text = var_192_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_189_1.leftNameTxt_.transform)

				arg_189_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_189_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_189_1:RecordName(arg_189_1.leftNameTxt_.text)
				SetActive(arg_189_1.iconTrs_.gameObject, false)
				arg_189_1.callingController_:SetSelectedState("normal")

				local var_192_18 = arg_189_1:GetWordFromCfg(410082046)
				local var_192_19 = arg_189_1:FormatText(var_192_18.content)

				arg_189_1.text_.text = var_192_19

				LuaForUtil.ClearLinePrefixSymbol(arg_189_1.text_)

				local var_192_20 = 22
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

				if manager.audio:GetVoiceLength("story_v_out_410082", "410082046", "story_v_out_410082.awb") ~= 0 then
					local var_192_23 = manager.audio:GetVoiceLength("story_v_out_410082", "410082046", "story_v_out_410082.awb") / 1000

					if var_192_23 + var_192_15 > arg_189_1.duration_ then
						arg_189_1.duration_ = var_192_23 + var_192_15
					end

					if var_192_18.prefab_name ~= "" and arg_189_1.actors_[var_192_18.prefab_name] ~= nil then
						local var_192_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_189_1.actors_[var_192_18.prefab_name].transform, "story_v_out_410082", "410082046", "story_v_out_410082.awb")

						arg_189_1:RecordAudio("410082046", var_192_24)
						arg_189_1:RecordAudio("410082046", var_192_24)
					else
						arg_189_1:AudioAction("play", "voice", "story_v_out_410082", "410082046", "story_v_out_410082.awb")
					end

					arg_189_1:RecordHistoryTalkVoice("story_v_out_410082", "410082046", "story_v_out_410082.awb")
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
				actorName = "1060",
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
	Play410082047 = function(arg_193_0, arg_193_1)
		arg_193_1.time_ = 0
		arg_193_1.frameCnt_ = 0
		arg_193_1.state_ = "playing"
		arg_193_1.curTalkId_ = 410082047
		arg_193_1.duration_ = 12.77

		local var_193_0 = {
			zh = 12.733,
			ja = 12.766
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
				arg_193_0:Play410082048(arg_193_1)
			end
		end

		function arg_193_1.onSingleLineUpdate_(arg_196_0)
			local var_196_0 = arg_193_1.actors_["1056"].transform
			local var_196_1 = 0

			if var_196_1 < arg_193_1.time_ and arg_193_1.time_ <= var_196_1 + arg_196_0 then
				arg_193_1.var_.moveOldPos1056 = var_196_0.localPosition
				var_196_0.localScale = Vector3.New(1, 1, 1)

				arg_193_1:CheckSpriteTmpPos("1056", 4)

				local var_196_2 = var_196_0.childCount

				for iter_196_0 = 0, var_196_2 - 1 do
					local var_196_3 = var_196_0:GetChild(iter_196_0)

					if var_196_3.name == "split_1" or not string.find(var_196_3.name, "split") then
						var_196_3.gameObject:SetActive(true)
					else
						var_196_3.gameObject:SetActive(false)
					end
				end
			end

			local var_196_4 = 0.001

			if var_196_1 <= arg_193_1.time_ and arg_193_1.time_ < var_196_1 + var_196_4 then
				local var_196_5 = (arg_193_1.time_ - var_196_1) / var_196_4
				local var_196_6 = Vector3.New(390, -350, -180)

				var_196_0.localPosition = Vector3.Lerp(arg_193_1.var_.moveOldPos1056, var_196_6, var_196_5)
			end

			if arg_193_1.time_ >= var_196_1 + var_196_4 and arg_193_1.time_ < var_196_1 + var_196_4 + arg_196_0 then
				var_196_0.localPosition = Vector3.New(390, -350, -180)
			end

			local var_196_7 = arg_193_1.actors_["1056"]
			local var_196_8 = 0

			if var_196_8 < arg_193_1.time_ and arg_193_1.time_ <= var_196_8 + arg_196_0 and not isNil(var_196_7) and arg_193_1.var_.actorSpriteComps1056 == nil then
				arg_193_1.var_.actorSpriteComps1056 = var_196_7:GetComponentsInChildren(typeof(Image), true)
			end

			local var_196_9 = 0.034

			if var_196_8 <= arg_193_1.time_ and arg_193_1.time_ < var_196_8 + var_196_9 and not isNil(var_196_7) then
				local var_196_10 = (arg_193_1.time_ - var_196_8) / var_196_9

				if arg_193_1.var_.actorSpriteComps1056 then
					for iter_196_1, iter_196_2 in pairs(arg_193_1.var_.actorSpriteComps1056:ToTable()) do
						if iter_196_2 then
							if arg_193_1.isInRecall_ then
								local var_196_11 = Mathf.Lerp(iter_196_2.color.r, arg_193_1.hightColor1.r, var_196_10)
								local var_196_12 = Mathf.Lerp(iter_196_2.color.g, arg_193_1.hightColor1.g, var_196_10)
								local var_196_13 = Mathf.Lerp(iter_196_2.color.b, arg_193_1.hightColor1.b, var_196_10)

								iter_196_2.color = Color.New(var_196_11, var_196_12, var_196_13)
							else
								local var_196_14 = Mathf.Lerp(iter_196_2.color.r, 1, var_196_10)

								iter_196_2.color = Color.New(var_196_14, var_196_14, var_196_14)
							end
						end
					end
				end
			end

			if arg_193_1.time_ >= var_196_8 + var_196_9 and arg_193_1.time_ < var_196_8 + var_196_9 + arg_196_0 and not isNil(var_196_7) and arg_193_1.var_.actorSpriteComps1056 then
				for iter_196_3, iter_196_4 in pairs(arg_193_1.var_.actorSpriteComps1056:ToTable()) do
					if iter_196_4 then
						if arg_193_1.isInRecall_ then
							iter_196_4.color = arg_193_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_196_4.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_193_1.var_.actorSpriteComps1056 = nil
			end

			local var_196_15 = arg_193_1.actors_["1060"]
			local var_196_16 = 0

			if var_196_16 < arg_193_1.time_ and arg_193_1.time_ <= var_196_16 + arg_196_0 and not isNil(var_196_15) and arg_193_1.var_.actorSpriteComps1060 == nil then
				arg_193_1.var_.actorSpriteComps1060 = var_196_15:GetComponentsInChildren(typeof(Image), true)
			end

			local var_196_17 = 0.034

			if var_196_16 <= arg_193_1.time_ and arg_193_1.time_ < var_196_16 + var_196_17 and not isNil(var_196_15) then
				local var_196_18 = (arg_193_1.time_ - var_196_16) / var_196_17

				if arg_193_1.var_.actorSpriteComps1060 then
					for iter_196_5, iter_196_6 in pairs(arg_193_1.var_.actorSpriteComps1060:ToTable()) do
						if iter_196_6 then
							if arg_193_1.isInRecall_ then
								local var_196_19 = Mathf.Lerp(iter_196_6.color.r, arg_193_1.hightColor2.r, var_196_18)
								local var_196_20 = Mathf.Lerp(iter_196_6.color.g, arg_193_1.hightColor2.g, var_196_18)
								local var_196_21 = Mathf.Lerp(iter_196_6.color.b, arg_193_1.hightColor2.b, var_196_18)

								iter_196_6.color = Color.New(var_196_19, var_196_20, var_196_21)
							else
								local var_196_22 = Mathf.Lerp(iter_196_6.color.r, 0.5, var_196_18)

								iter_196_6.color = Color.New(var_196_22, var_196_22, var_196_22)
							end
						end
					end
				end
			end

			if arg_193_1.time_ >= var_196_16 + var_196_17 and arg_193_1.time_ < var_196_16 + var_196_17 + arg_196_0 and not isNil(var_196_15) and arg_193_1.var_.actorSpriteComps1060 then
				for iter_196_7, iter_196_8 in pairs(arg_193_1.var_.actorSpriteComps1060:ToTable()) do
					if iter_196_8 then
						if arg_193_1.isInRecall_ then
							iter_196_8.color = arg_193_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_196_8.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_193_1.var_.actorSpriteComps1060 = nil
			end

			local var_196_23 = 0
			local var_196_24 = 1.45

			if var_196_23 < arg_193_1.time_ and arg_193_1.time_ <= var_196_23 + arg_196_0 then
				arg_193_1.talkMaxDuration = 0
				arg_193_1.dialogCg_.alpha = 1

				arg_193_1.dialog_:SetActive(true)
				SetActive(arg_193_1.leftNameGo_, true)

				local var_196_25 = arg_193_1:FormatText(StoryNameCfg[605].name)

				arg_193_1.leftNameTxt_.text = var_196_25

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_193_1.leftNameTxt_.transform)

				arg_193_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_193_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_193_1:RecordName(arg_193_1.leftNameTxt_.text)
				SetActive(arg_193_1.iconTrs_.gameObject, false)
				arg_193_1.callingController_:SetSelectedState("normal")

				local var_196_26 = arg_193_1:GetWordFromCfg(410082047)
				local var_196_27 = arg_193_1:FormatText(var_196_26.content)

				arg_193_1.text_.text = var_196_27

				LuaForUtil.ClearLinePrefixSymbol(arg_193_1.text_)

				local var_196_28 = 59
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

				if manager.audio:GetVoiceLength("story_v_out_410082", "410082047", "story_v_out_410082.awb") ~= 0 then
					local var_196_31 = manager.audio:GetVoiceLength("story_v_out_410082", "410082047", "story_v_out_410082.awb") / 1000

					if var_196_31 + var_196_23 > arg_193_1.duration_ then
						arg_193_1.duration_ = var_196_31 + var_196_23
					end

					if var_196_26.prefab_name ~= "" and arg_193_1.actors_[var_196_26.prefab_name] ~= nil then
						local var_196_32 = LuaForUtil.PlayVoiceWithCriLipsync(arg_193_1.actors_[var_196_26.prefab_name].transform, "story_v_out_410082", "410082047", "story_v_out_410082.awb")

						arg_193_1:RecordAudio("410082047", var_196_32)
						arg_193_1:RecordAudio("410082047", var_196_32)
					else
						arg_193_1:AudioAction("play", "voice", "story_v_out_410082", "410082047", "story_v_out_410082.awb")
					end

					arg_193_1:RecordHistoryTalkVoice("story_v_out_410082", "410082047", "story_v_out_410082.awb")
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
				actorName = "1056",
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
	Play410082048 = function(arg_197_0, arg_197_1)
		arg_197_1.time_ = 0
		arg_197_1.frameCnt_ = 0
		arg_197_1.state_ = "playing"
		arg_197_1.curTalkId_ = 410082048
		arg_197_1.duration_ = 8.53

		local var_197_0 = {
			zh = 3.7,
			ja = 8.533
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
				arg_197_0:Play410082049(arg_197_1)
			end
		end

		function arg_197_1.onSingleLineUpdate_(arg_200_0)
			local var_200_0 = 0
			local var_200_1 = 0.45

			if var_200_0 < arg_197_1.time_ and arg_197_1.time_ <= var_200_0 + arg_200_0 then
				arg_197_1.talkMaxDuration = 0
				arg_197_1.dialogCg_.alpha = 1

				arg_197_1.dialog_:SetActive(true)
				SetActive(arg_197_1.leftNameGo_, true)

				local var_200_2 = arg_197_1:FormatText(StoryNameCfg[605].name)

				arg_197_1.leftNameTxt_.text = var_200_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_197_1.leftNameTxt_.transform)

				arg_197_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_197_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_197_1:RecordName(arg_197_1.leftNameTxt_.text)
				SetActive(arg_197_1.iconTrs_.gameObject, false)
				arg_197_1.callingController_:SetSelectedState("normal")

				local var_200_3 = arg_197_1:GetWordFromCfg(410082048)
				local var_200_4 = arg_197_1:FormatText(var_200_3.content)

				arg_197_1.text_.text = var_200_4

				LuaForUtil.ClearLinePrefixSymbol(arg_197_1.text_)

				local var_200_5 = 18
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

				if manager.audio:GetVoiceLength("story_v_out_410082", "410082048", "story_v_out_410082.awb") ~= 0 then
					local var_200_8 = manager.audio:GetVoiceLength("story_v_out_410082", "410082048", "story_v_out_410082.awb") / 1000

					if var_200_8 + var_200_0 > arg_197_1.duration_ then
						arg_197_1.duration_ = var_200_8 + var_200_0
					end

					if var_200_3.prefab_name ~= "" and arg_197_1.actors_[var_200_3.prefab_name] ~= nil then
						local var_200_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_197_1.actors_[var_200_3.prefab_name].transform, "story_v_out_410082", "410082048", "story_v_out_410082.awb")

						arg_197_1:RecordAudio("410082048", var_200_9)
						arg_197_1:RecordAudio("410082048", var_200_9)
					else
						arg_197_1:AudioAction("play", "voice", "story_v_out_410082", "410082048", "story_v_out_410082.awb")
					end

					arg_197_1:RecordHistoryTalkVoice("story_v_out_410082", "410082048", "story_v_out_410082.awb")
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
	Play410082049 = function(arg_201_0, arg_201_1)
		arg_201_1.time_ = 0
		arg_201_1.frameCnt_ = 0
		arg_201_1.state_ = "playing"
		arg_201_1.curTalkId_ = 410082049
		arg_201_1.duration_ = 9.4

		local var_201_0 = {
			zh = 6.2,
			ja = 9.4
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
				arg_201_0:Play410082050(arg_201_1)
			end
		end

		function arg_201_1.onSingleLineUpdate_(arg_204_0)
			local var_204_0 = arg_201_1.actors_["1060"].transform
			local var_204_1 = 0

			if var_204_1 < arg_201_1.time_ and arg_201_1.time_ <= var_204_1 + arg_204_0 then
				arg_201_1.var_.moveOldPos1060 = var_204_0.localPosition
				var_204_0.localScale = Vector3.New(1, 1, 1)

				arg_201_1:CheckSpriteTmpPos("1060", 2)

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
				local var_204_6 = Vector3.New(-440.94, -430.8, 6.9)

				var_204_0.localPosition = Vector3.Lerp(arg_201_1.var_.moveOldPos1060, var_204_6, var_204_5)
			end

			if arg_201_1.time_ >= var_204_1 + var_204_4 and arg_201_1.time_ < var_204_1 + var_204_4 + arg_204_0 then
				var_204_0.localPosition = Vector3.New(-440.94, -430.8, 6.9)
			end

			local var_204_7 = arg_201_1.actors_["1060"]
			local var_204_8 = 0

			if var_204_8 < arg_201_1.time_ and arg_201_1.time_ <= var_204_8 + arg_204_0 and not isNil(var_204_7) and arg_201_1.var_.actorSpriteComps1060 == nil then
				arg_201_1.var_.actorSpriteComps1060 = var_204_7:GetComponentsInChildren(typeof(Image), true)
			end

			local var_204_9 = 0.034

			if var_204_8 <= arg_201_1.time_ and arg_201_1.time_ < var_204_8 + var_204_9 and not isNil(var_204_7) then
				local var_204_10 = (arg_201_1.time_ - var_204_8) / var_204_9

				if arg_201_1.var_.actorSpriteComps1060 then
					for iter_204_1, iter_204_2 in pairs(arg_201_1.var_.actorSpriteComps1060:ToTable()) do
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

			if arg_201_1.time_ >= var_204_8 + var_204_9 and arg_201_1.time_ < var_204_8 + var_204_9 + arg_204_0 and not isNil(var_204_7) and arg_201_1.var_.actorSpriteComps1060 then
				for iter_204_3, iter_204_4 in pairs(arg_201_1.var_.actorSpriteComps1060:ToTable()) do
					if iter_204_4 then
						if arg_201_1.isInRecall_ then
							iter_204_4.color = arg_201_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_204_4.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_201_1.var_.actorSpriteComps1060 = nil
			end

			local var_204_15 = arg_201_1.actors_["1056"]
			local var_204_16 = 0

			if var_204_16 < arg_201_1.time_ and arg_201_1.time_ <= var_204_16 + arg_204_0 and not isNil(var_204_15) and arg_201_1.var_.actorSpriteComps1056 == nil then
				arg_201_1.var_.actorSpriteComps1056 = var_204_15:GetComponentsInChildren(typeof(Image), true)
			end

			local var_204_17 = 0.034

			if var_204_16 <= arg_201_1.time_ and arg_201_1.time_ < var_204_16 + var_204_17 and not isNil(var_204_15) then
				local var_204_18 = (arg_201_1.time_ - var_204_16) / var_204_17

				if arg_201_1.var_.actorSpriteComps1056 then
					for iter_204_5, iter_204_6 in pairs(arg_201_1.var_.actorSpriteComps1056:ToTable()) do
						if iter_204_6 then
							if arg_201_1.isInRecall_ then
								local var_204_19 = Mathf.Lerp(iter_204_6.color.r, arg_201_1.hightColor2.r, var_204_18)
								local var_204_20 = Mathf.Lerp(iter_204_6.color.g, arg_201_1.hightColor2.g, var_204_18)
								local var_204_21 = Mathf.Lerp(iter_204_6.color.b, arg_201_1.hightColor2.b, var_204_18)

								iter_204_6.color = Color.New(var_204_19, var_204_20, var_204_21)
							else
								local var_204_22 = Mathf.Lerp(iter_204_6.color.r, 0.5, var_204_18)

								iter_204_6.color = Color.New(var_204_22, var_204_22, var_204_22)
							end
						end
					end
				end
			end

			if arg_201_1.time_ >= var_204_16 + var_204_17 and arg_201_1.time_ < var_204_16 + var_204_17 + arg_204_0 and not isNil(var_204_15) and arg_201_1.var_.actorSpriteComps1056 then
				for iter_204_7, iter_204_8 in pairs(arg_201_1.var_.actorSpriteComps1056:ToTable()) do
					if iter_204_8 then
						if arg_201_1.isInRecall_ then
							iter_204_8.color = arg_201_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_204_8.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_201_1.var_.actorSpriteComps1056 = nil
			end

			local var_204_23 = 0
			local var_204_24 = 0.65

			if var_204_23 < arg_201_1.time_ and arg_201_1.time_ <= var_204_23 + arg_204_0 then
				arg_201_1.talkMaxDuration = 0
				arg_201_1.dialogCg_.alpha = 1

				arg_201_1.dialog_:SetActive(true)
				SetActive(arg_201_1.leftNameGo_, true)

				local var_204_25 = arg_201_1:FormatText(StoryNameCfg[584].name)

				arg_201_1.leftNameTxt_.text = var_204_25

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_201_1.leftNameTxt_.transform)

				arg_201_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_201_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_201_1:RecordName(arg_201_1.leftNameTxt_.text)
				SetActive(arg_201_1.iconTrs_.gameObject, false)
				arg_201_1.callingController_:SetSelectedState("normal")

				local var_204_26 = arg_201_1:GetWordFromCfg(410082049)
				local var_204_27 = arg_201_1:FormatText(var_204_26.content)

				arg_201_1.text_.text = var_204_27

				LuaForUtil.ClearLinePrefixSymbol(arg_201_1.text_)

				local var_204_28 = 26
				local var_204_29 = utf8.len(var_204_27)
				local var_204_30 = var_204_28 <= 0 and var_204_24 or var_204_24 * (var_204_29 / var_204_28)

				if var_204_30 > 0 and var_204_24 < var_204_30 then
					arg_201_1.talkMaxDuration = var_204_30

					if var_204_30 + var_204_23 > arg_201_1.duration_ then
						arg_201_1.duration_ = var_204_30 + var_204_23
					end
				end

				arg_201_1.text_.text = var_204_27
				arg_201_1.typewritter.percent = 0

				arg_201_1.typewritter:SetDirty()
				arg_201_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_410082", "410082049", "story_v_out_410082.awb") ~= 0 then
					local var_204_31 = manager.audio:GetVoiceLength("story_v_out_410082", "410082049", "story_v_out_410082.awb") / 1000

					if var_204_31 + var_204_23 > arg_201_1.duration_ then
						arg_201_1.duration_ = var_204_31 + var_204_23
					end

					if var_204_26.prefab_name ~= "" and arg_201_1.actors_[var_204_26.prefab_name] ~= nil then
						local var_204_32 = LuaForUtil.PlayVoiceWithCriLipsync(arg_201_1.actors_[var_204_26.prefab_name].transform, "story_v_out_410082", "410082049", "story_v_out_410082.awb")

						arg_201_1:RecordAudio("410082049", var_204_32)
						arg_201_1:RecordAudio("410082049", var_204_32)
					else
						arg_201_1:AudioAction("play", "voice", "story_v_out_410082", "410082049", "story_v_out_410082.awb")
					end

					arg_201_1:RecordHistoryTalkVoice("story_v_out_410082", "410082049", "story_v_out_410082.awb")
				end

				arg_201_1:RecordContent(arg_201_1.text_.text)
			end

			local var_204_33 = math.max(var_204_24, arg_201_1.talkMaxDuration)

			if var_204_23 <= arg_201_1.time_ and arg_201_1.time_ < var_204_23 + var_204_33 then
				arg_201_1.typewritter.percent = (arg_201_1.time_ - var_204_23) / var_204_33

				arg_201_1.typewritter:SetDirty()
			end

			if arg_201_1.time_ >= var_204_23 + var_204_33 and arg_201_1.time_ < var_204_23 + var_204_33 + arg_204_0 then
				arg_201_1.typewritter.percent = 1

				arg_201_1.typewritter:SetDirty()
				arg_201_1:ShowNextGo(true)
			end
		end

		arg_201_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1060",
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
	Play410082050 = function(arg_205_0, arg_205_1)
		arg_205_1.time_ = 0
		arg_205_1.frameCnt_ = 0
		arg_205_1.state_ = "playing"
		arg_205_1.curTalkId_ = 410082050
		arg_205_1.duration_ = 6.13

		local var_205_0 = {
			zh = 3.166,
			ja = 6.133
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
				arg_205_0:Play410082051(arg_205_1)
			end
		end

		function arg_205_1.onSingleLineUpdate_(arg_208_0)
			local var_208_0 = arg_205_1.actors_["1060"]
			local var_208_1 = 0

			if var_208_1 < arg_205_1.time_ and arg_205_1.time_ <= var_208_1 + arg_208_0 and not isNil(var_208_0) and arg_205_1.var_.actorSpriteComps1060 == nil then
				arg_205_1.var_.actorSpriteComps1060 = var_208_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_208_2 = 0.034

			if var_208_1 <= arg_205_1.time_ and arg_205_1.time_ < var_208_1 + var_208_2 and not isNil(var_208_0) then
				local var_208_3 = (arg_205_1.time_ - var_208_1) / var_208_2

				if arg_205_1.var_.actorSpriteComps1060 then
					for iter_208_0, iter_208_1 in pairs(arg_205_1.var_.actorSpriteComps1060:ToTable()) do
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

			if arg_205_1.time_ >= var_208_1 + var_208_2 and arg_205_1.time_ < var_208_1 + var_208_2 + arg_208_0 and not isNil(var_208_0) and arg_205_1.var_.actorSpriteComps1060 then
				for iter_208_2, iter_208_3 in pairs(arg_205_1.var_.actorSpriteComps1060:ToTable()) do
					if iter_208_3 then
						if arg_205_1.isInRecall_ then
							iter_208_3.color = arg_205_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_208_3.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_205_1.var_.actorSpriteComps1060 = nil
			end

			local var_208_8 = 0
			local var_208_9 = 0.3

			if var_208_8 < arg_205_1.time_ and arg_205_1.time_ <= var_208_8 + arg_208_0 then
				arg_205_1.talkMaxDuration = 0
				arg_205_1.dialogCg_.alpha = 1

				arg_205_1.dialog_:SetActive(true)
				SetActive(arg_205_1.leftNameGo_, true)

				local var_208_10 = arg_205_1:FormatText(StoryNameCfg[36].name)

				arg_205_1.leftNameTxt_.text = var_208_10

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_205_1.leftNameTxt_.transform)

				arg_205_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_205_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_205_1:RecordName(arg_205_1.leftNameTxt_.text)
				SetActive(arg_205_1.iconTrs_.gameObject, false)
				arg_205_1.callingController_:SetSelectedState("normal")

				local var_208_11 = arg_205_1:GetWordFromCfg(410082050)
				local var_208_12 = arg_205_1:FormatText(var_208_11.content)

				arg_205_1.text_.text = var_208_12

				LuaForUtil.ClearLinePrefixSymbol(arg_205_1.text_)

				local var_208_13 = 12
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

				if manager.audio:GetVoiceLength("story_v_out_410082", "410082050", "story_v_out_410082.awb") ~= 0 then
					local var_208_16 = manager.audio:GetVoiceLength("story_v_out_410082", "410082050", "story_v_out_410082.awb") / 1000

					if var_208_16 + var_208_8 > arg_205_1.duration_ then
						arg_205_1.duration_ = var_208_16 + var_208_8
					end

					if var_208_11.prefab_name ~= "" and arg_205_1.actors_[var_208_11.prefab_name] ~= nil then
						local var_208_17 = LuaForUtil.PlayVoiceWithCriLipsync(arg_205_1.actors_[var_208_11.prefab_name].transform, "story_v_out_410082", "410082050", "story_v_out_410082.awb")

						arg_205_1:RecordAudio("410082050", var_208_17)
						arg_205_1:RecordAudio("410082050", var_208_17)
					else
						arg_205_1:AudioAction("play", "voice", "story_v_out_410082", "410082050", "story_v_out_410082.awb")
					end

					arg_205_1:RecordHistoryTalkVoice("story_v_out_410082", "410082050", "story_v_out_410082.awb")
				end

				arg_205_1:RecordContent(arg_205_1.text_.text)
			end

			local var_208_18 = math.max(var_208_9, arg_205_1.talkMaxDuration)

			if var_208_8 <= arg_205_1.time_ and arg_205_1.time_ < var_208_8 + var_208_18 then
				arg_205_1.typewritter.percent = (arg_205_1.time_ - var_208_8) / var_208_18

				arg_205_1.typewritter:SetDirty()
			end

			if arg_205_1.time_ >= var_208_8 + var_208_18 and arg_205_1.time_ < var_208_8 + var_208_18 + arg_208_0 then
				arg_205_1.typewritter.percent = 1

				arg_205_1.typewritter:SetDirty()
				arg_205_1:ShowNextGo(true)
			end
		end

		arg_205_1.nodeConfigList_ = {}

		arg_205_1:InitPlayNodeList()
	end,
	Play410082051 = function(arg_209_0, arg_209_1)
		arg_209_1.time_ = 0
		arg_209_1.frameCnt_ = 0
		arg_209_1.state_ = "playing"
		arg_209_1.curTalkId_ = 410082051
		arg_209_1.duration_ = 5

		SetActive(arg_209_1.tipsGo_, false)

		function arg_209_1.onSingleLineFinish_()
			arg_209_1.onSingleLineUpdate_ = nil
			arg_209_1.onSingleLineFinish_ = nil
			arg_209_1.state_ = "waiting"
		end

		function arg_209_1.playNext_(arg_211_0)
			if arg_211_0 == 1 then
				arg_209_0:Play410082052(arg_209_1)
			end
		end

		function arg_209_1.onSingleLineUpdate_(arg_212_0)
			local var_212_0 = arg_209_1.actors_["1056"].transform
			local var_212_1 = 0

			if var_212_1 < arg_209_1.time_ and arg_209_1.time_ <= var_212_1 + arg_212_0 then
				arg_209_1.var_.moveOldPos1056 = var_212_0.localPosition
				var_212_0.localScale = Vector3.New(1, 1, 1)

				arg_209_1:CheckSpriteTmpPos("1056", 7)

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
				local var_212_6 = Vector3.New(0, -2000, -180)

				var_212_0.localPosition = Vector3.Lerp(arg_209_1.var_.moveOldPos1056, var_212_6, var_212_5)
			end

			if arg_209_1.time_ >= var_212_1 + var_212_4 and arg_209_1.time_ < var_212_1 + var_212_4 + arg_212_0 then
				var_212_0.localPosition = Vector3.New(0, -2000, -180)
			end

			local var_212_7 = arg_209_1.actors_["1060"].transform
			local var_212_8 = 0

			if var_212_8 < arg_209_1.time_ and arg_209_1.time_ <= var_212_8 + arg_212_0 then
				arg_209_1.var_.moveOldPos1060 = var_212_7.localPosition
				var_212_7.localScale = Vector3.New(1, 1, 1)

				arg_209_1:CheckSpriteTmpPos("1060", 7)

				local var_212_9 = var_212_7.childCount

				for iter_212_1 = 0, var_212_9 - 1 do
					local var_212_10 = var_212_7:GetChild(iter_212_1)

					if var_212_10.name == "" or not string.find(var_212_10.name, "split") then
						var_212_10.gameObject:SetActive(true)
					else
						var_212_10.gameObject:SetActive(false)
					end
				end
			end

			local var_212_11 = 0.001

			if var_212_8 <= arg_209_1.time_ and arg_209_1.time_ < var_212_8 + var_212_11 then
				local var_212_12 = (arg_209_1.time_ - var_212_8) / var_212_11
				local var_212_13 = Vector3.New(0, -2000, -40)

				var_212_7.localPosition = Vector3.Lerp(arg_209_1.var_.moveOldPos1060, var_212_13, var_212_12)
			end

			if arg_209_1.time_ >= var_212_8 + var_212_11 and arg_209_1.time_ < var_212_8 + var_212_11 + arg_212_0 then
				var_212_7.localPosition = Vector3.New(0, -2000, -40)
			end

			local var_212_14 = 0
			local var_212_15 = 0.875

			if var_212_14 < arg_209_1.time_ and arg_209_1.time_ <= var_212_14 + arg_212_0 then
				arg_209_1.talkMaxDuration = 0
				arg_209_1.dialogCg_.alpha = 1

				arg_209_1.dialog_:SetActive(true)
				SetActive(arg_209_1.leftNameGo_, false)

				arg_209_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_209_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_209_1:RecordName(arg_209_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_209_1.iconTrs_.gameObject, false)
				arg_209_1.callingController_:SetSelectedState("normal")

				local var_212_16 = arg_209_1:GetWordFromCfg(410082051)
				local var_212_17 = arg_209_1:FormatText(var_212_16.content)

				arg_209_1.text_.text = var_212_17

				LuaForUtil.ClearLinePrefixSymbol(arg_209_1.text_)

				local var_212_18 = 35
				local var_212_19 = utf8.len(var_212_17)
				local var_212_20 = var_212_18 <= 0 and var_212_15 or var_212_15 * (var_212_19 / var_212_18)

				if var_212_20 > 0 and var_212_15 < var_212_20 then
					arg_209_1.talkMaxDuration = var_212_20

					if var_212_20 + var_212_14 > arg_209_1.duration_ then
						arg_209_1.duration_ = var_212_20 + var_212_14
					end
				end

				arg_209_1.text_.text = var_212_17
				arg_209_1.typewritter.percent = 0

				arg_209_1.typewritter:SetDirty()
				arg_209_1:ShowNextGo(false)
				arg_209_1:RecordContent(arg_209_1.text_.text)
			end

			local var_212_21 = math.max(var_212_15, arg_209_1.talkMaxDuration)

			if var_212_14 <= arg_209_1.time_ and arg_209_1.time_ < var_212_14 + var_212_21 then
				arg_209_1.typewritter.percent = (arg_209_1.time_ - var_212_14) / var_212_21

				arg_209_1.typewritter:SetDirty()
			end

			if arg_209_1.time_ >= var_212_14 + var_212_21 and arg_209_1.time_ < var_212_14 + var_212_21 + arg_212_0 then
				arg_209_1.typewritter.percent = 1

				arg_209_1.typewritter:SetDirty()
				arg_209_1:ShowNextGo(true)
			end
		end

		arg_209_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1056",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			},
			{
				assetPath = "",
				actorName = "1060",
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
	Play410082052 = function(arg_213_0, arg_213_1)
		arg_213_1.time_ = 0
		arg_213_1.frameCnt_ = 0
		arg_213_1.state_ = "playing"
		arg_213_1.curTalkId_ = 410082052
		arg_213_1.duration_ = 5

		SetActive(arg_213_1.tipsGo_, false)

		function arg_213_1.onSingleLineFinish_()
			arg_213_1.onSingleLineUpdate_ = nil
			arg_213_1.onSingleLineFinish_ = nil
			arg_213_1.state_ = "waiting"
		end

		function arg_213_1.playNext_(arg_215_0)
			if arg_215_0 == 1 then
				arg_213_0:Play410082053(arg_213_1)
			end
		end

		function arg_213_1.onSingleLineUpdate_(arg_216_0)
			local var_216_0 = 0
			local var_216_1 = 0.95

			if var_216_0 < arg_213_1.time_ and arg_213_1.time_ <= var_216_0 + arg_216_0 then
				arg_213_1.talkMaxDuration = 0
				arg_213_1.dialogCg_.alpha = 1

				arg_213_1.dialog_:SetActive(true)
				SetActive(arg_213_1.leftNameGo_, false)

				arg_213_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_213_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_213_1:RecordName(arg_213_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_213_1.iconTrs_.gameObject, false)
				arg_213_1.callingController_:SetSelectedState("normal")

				local var_216_2 = arg_213_1:GetWordFromCfg(410082052)
				local var_216_3 = arg_213_1:FormatText(var_216_2.content)

				arg_213_1.text_.text = var_216_3

				LuaForUtil.ClearLinePrefixSymbol(arg_213_1.text_)

				local var_216_4 = 38
				local var_216_5 = utf8.len(var_216_3)
				local var_216_6 = var_216_4 <= 0 and var_216_1 or var_216_1 * (var_216_5 / var_216_4)

				if var_216_6 > 0 and var_216_1 < var_216_6 then
					arg_213_1.talkMaxDuration = var_216_6

					if var_216_6 + var_216_0 > arg_213_1.duration_ then
						arg_213_1.duration_ = var_216_6 + var_216_0
					end
				end

				arg_213_1.text_.text = var_216_3
				arg_213_1.typewritter.percent = 0

				arg_213_1.typewritter:SetDirty()
				arg_213_1:ShowNextGo(false)
				arg_213_1:RecordContent(arg_213_1.text_.text)
			end

			local var_216_7 = math.max(var_216_1, arg_213_1.talkMaxDuration)

			if var_216_0 <= arg_213_1.time_ and arg_213_1.time_ < var_216_0 + var_216_7 then
				arg_213_1.typewritter.percent = (arg_213_1.time_ - var_216_0) / var_216_7

				arg_213_1.typewritter:SetDirty()
			end

			if arg_213_1.time_ >= var_216_0 + var_216_7 and arg_213_1.time_ < var_216_0 + var_216_7 + arg_216_0 then
				arg_213_1.typewritter.percent = 1

				arg_213_1.typewritter:SetDirty()
				arg_213_1:ShowNextGo(true)
			end
		end

		arg_213_1.nodeConfigList_ = {}

		arg_213_1:InitPlayNodeList()
	end,
	Play410082053 = function(arg_217_0, arg_217_1)
		arg_217_1.time_ = 0
		arg_217_1.frameCnt_ = 0
		arg_217_1.state_ = "playing"
		arg_217_1.curTalkId_ = 410082053
		arg_217_1.duration_ = 5

		SetActive(arg_217_1.tipsGo_, false)

		function arg_217_1.onSingleLineFinish_()
			arg_217_1.onSingleLineUpdate_ = nil
			arg_217_1.onSingleLineFinish_ = nil
			arg_217_1.state_ = "waiting"
		end

		function arg_217_1.playNext_(arg_219_0)
			if arg_219_0 == 1 then
				arg_217_0:Play410082054(arg_217_1)
			end
		end

		function arg_217_1.onSingleLineUpdate_(arg_220_0)
			local var_220_0 = 0
			local var_220_1 = 1.45

			if var_220_0 < arg_217_1.time_ and arg_217_1.time_ <= var_220_0 + arg_220_0 then
				arg_217_1.talkMaxDuration = 0
				arg_217_1.dialogCg_.alpha = 1

				arg_217_1.dialog_:SetActive(true)
				SetActive(arg_217_1.leftNameGo_, false)

				arg_217_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_217_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_217_1:RecordName(arg_217_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_217_1.iconTrs_.gameObject, false)
				arg_217_1.callingController_:SetSelectedState("normal")

				local var_220_2 = arg_217_1:GetWordFromCfg(410082053)
				local var_220_3 = arg_217_1:FormatText(var_220_2.content)

				arg_217_1.text_.text = var_220_3

				LuaForUtil.ClearLinePrefixSymbol(arg_217_1.text_)

				local var_220_4 = 58
				local var_220_5 = utf8.len(var_220_3)
				local var_220_6 = var_220_4 <= 0 and var_220_1 or var_220_1 * (var_220_5 / var_220_4)

				if var_220_6 > 0 and var_220_1 < var_220_6 then
					arg_217_1.talkMaxDuration = var_220_6

					if var_220_6 + var_220_0 > arg_217_1.duration_ then
						arg_217_1.duration_ = var_220_6 + var_220_0
					end
				end

				arg_217_1.text_.text = var_220_3
				arg_217_1.typewritter.percent = 0

				arg_217_1.typewritter:SetDirty()
				arg_217_1:ShowNextGo(false)
				arg_217_1:RecordContent(arg_217_1.text_.text)
			end

			local var_220_7 = math.max(var_220_1, arg_217_1.talkMaxDuration)

			if var_220_0 <= arg_217_1.time_ and arg_217_1.time_ < var_220_0 + var_220_7 then
				arg_217_1.typewritter.percent = (arg_217_1.time_ - var_220_0) / var_220_7

				arg_217_1.typewritter:SetDirty()
			end

			if arg_217_1.time_ >= var_220_0 + var_220_7 and arg_217_1.time_ < var_220_0 + var_220_7 + arg_220_0 then
				arg_217_1.typewritter.percent = 1

				arg_217_1.typewritter:SetDirty()
				arg_217_1:ShowNextGo(true)
			end
		end

		arg_217_1.nodeConfigList_ = {}

		arg_217_1:InitPlayNodeList()
	end,
	Play410082054 = function(arg_221_0, arg_221_1)
		arg_221_1.time_ = 0
		arg_221_1.frameCnt_ = 0
		arg_221_1.state_ = "playing"
		arg_221_1.curTalkId_ = 410082054
		arg_221_1.duration_ = 5.4

		local var_221_0 = {
			zh = 1.4,
			ja = 5.4
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
				arg_221_0:Play410082055(arg_221_1)
			end
		end

		function arg_221_1.onSingleLineUpdate_(arg_224_0)
			local var_224_0 = arg_221_1.actors_["1060"].transform
			local var_224_1 = 0

			if var_224_1 < arg_221_1.time_ and arg_221_1.time_ <= var_224_1 + arg_224_0 then
				arg_221_1.var_.moveOldPos1060 = var_224_0.localPosition
				var_224_0.localScale = Vector3.New(1, 1, 1)

				arg_221_1:CheckSpriteTmpPos("1060", 2)

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
				local var_224_6 = Vector3.New(-440.94, -430.8, 6.9)

				var_224_0.localPosition = Vector3.Lerp(arg_221_1.var_.moveOldPos1060, var_224_6, var_224_5)
			end

			if arg_221_1.time_ >= var_224_1 + var_224_4 and arg_221_1.time_ < var_224_1 + var_224_4 + arg_224_0 then
				var_224_0.localPosition = Vector3.New(-440.94, -430.8, 6.9)
			end

			local var_224_7 = arg_221_1.actors_["1056"].transform
			local var_224_8 = 0

			if var_224_8 < arg_221_1.time_ and arg_221_1.time_ <= var_224_8 + arg_224_0 then
				arg_221_1.var_.moveOldPos1056 = var_224_7.localPosition
				var_224_7.localScale = Vector3.New(1, 1, 1)

				arg_221_1:CheckSpriteTmpPos("1056", 3)

				local var_224_9 = var_224_7.childCount

				for iter_224_1 = 0, var_224_9 - 1 do
					local var_224_10 = var_224_7:GetChild(iter_224_1)

					if var_224_10.name == "" or not string.find(var_224_10.name, "split") then
						var_224_10.gameObject:SetActive(true)
					else
						var_224_10.gameObject:SetActive(false)
					end
				end
			end

			local var_224_11 = 0.001

			if var_224_8 <= arg_221_1.time_ and arg_221_1.time_ < var_224_8 + var_224_11 then
				local var_224_12 = (arg_221_1.time_ - var_224_8) / var_224_11
				local var_224_13 = Vector3.New(0, -350, -180)

				var_224_7.localPosition = Vector3.Lerp(arg_221_1.var_.moveOldPos1056, var_224_13, var_224_12)
			end

			if arg_221_1.time_ >= var_224_8 + var_224_11 and arg_221_1.time_ < var_224_8 + var_224_11 + arg_224_0 then
				var_224_7.localPosition = Vector3.New(0, -350, -180)
			end

			local var_224_14 = "1012"

			if arg_221_1.actors_[var_224_14] == nil then
				local var_224_15 = Asset.Load("Widget/System/Story/StoryExpression/" .. "1012")

				if not isNil(var_224_15) then
					local var_224_16 = Object.Instantiate(var_224_15, arg_221_1.canvasGo_.transform)

					var_224_16.transform:SetSiblingIndex(1)

					var_224_16.name = var_224_14
					var_224_16.transform.localPosition = Vector3.New(0, 100000, 0)
					arg_221_1.actors_[var_224_14] = var_224_16

					local var_224_17 = var_224_16:GetComponentsInChildren(typeof(Image), true):ToTable()

					if arg_221_1.isInRecall_ then
						for iter_224_2, iter_224_3 in ipairs(var_224_17) do
							iter_224_3.color = arg_221_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						end
					end
				end
			end

			local var_224_18 = arg_221_1.actors_["1012"].transform
			local var_224_19 = 0

			if var_224_19 < arg_221_1.time_ and arg_221_1.time_ <= var_224_19 + arg_224_0 then
				arg_221_1.var_.moveOldPos1012 = var_224_18.localPosition
				var_224_18.localScale = Vector3.New(1, 1, 1)

				arg_221_1:CheckSpriteTmpPos("1012", 4)

				local var_224_20 = var_224_18.childCount

				for iter_224_4 = 0, var_224_20 - 1 do
					local var_224_21 = var_224_18:GetChild(iter_224_4)

					if var_224_21.name == "" or not string.find(var_224_21.name, "split") then
						var_224_21.gameObject:SetActive(true)
					else
						var_224_21.gameObject:SetActive(false)
					end
				end
			end

			local var_224_22 = 0.001

			if var_224_19 <= arg_221_1.time_ and arg_221_1.time_ < var_224_19 + var_224_22 then
				local var_224_23 = (arg_221_1.time_ - var_224_19) / var_224_22
				local var_224_24 = Vector3.New(390, -465, 300)

				var_224_18.localPosition = Vector3.Lerp(arg_221_1.var_.moveOldPos1012, var_224_24, var_224_23)
			end

			if arg_221_1.time_ >= var_224_19 + var_224_22 and arg_221_1.time_ < var_224_19 + var_224_22 + arg_224_0 then
				var_224_18.localPosition = Vector3.New(390, -465, 300)
			end

			local var_224_25 = arg_221_1.actors_["1060"]
			local var_224_26 = 0

			if var_224_26 < arg_221_1.time_ and arg_221_1.time_ <= var_224_26 + arg_224_0 and not isNil(var_224_25) and arg_221_1.var_.actorSpriteComps1060 == nil then
				arg_221_1.var_.actorSpriteComps1060 = var_224_25:GetComponentsInChildren(typeof(Image), true)
			end

			local var_224_27 = 0.034

			if var_224_26 <= arg_221_1.time_ and arg_221_1.time_ < var_224_26 + var_224_27 and not isNil(var_224_25) then
				local var_224_28 = (arg_221_1.time_ - var_224_26) / var_224_27

				if arg_221_1.var_.actorSpriteComps1060 then
					for iter_224_5, iter_224_6 in pairs(arg_221_1.var_.actorSpriteComps1060:ToTable()) do
						if iter_224_6 then
							if arg_221_1.isInRecall_ then
								local var_224_29 = Mathf.Lerp(iter_224_6.color.r, arg_221_1.hightColor1.r, var_224_28)
								local var_224_30 = Mathf.Lerp(iter_224_6.color.g, arg_221_1.hightColor1.g, var_224_28)
								local var_224_31 = Mathf.Lerp(iter_224_6.color.b, arg_221_1.hightColor1.b, var_224_28)

								iter_224_6.color = Color.New(var_224_29, var_224_30, var_224_31)
							else
								local var_224_32 = Mathf.Lerp(iter_224_6.color.r, 1, var_224_28)

								iter_224_6.color = Color.New(var_224_32, var_224_32, var_224_32)
							end
						end
					end
				end
			end

			if arg_221_1.time_ >= var_224_26 + var_224_27 and arg_221_1.time_ < var_224_26 + var_224_27 + arg_224_0 and not isNil(var_224_25) and arg_221_1.var_.actorSpriteComps1060 then
				for iter_224_7, iter_224_8 in pairs(arg_221_1.var_.actorSpriteComps1060:ToTable()) do
					if iter_224_8 then
						if arg_221_1.isInRecall_ then
							iter_224_8.color = arg_221_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_224_8.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_221_1.var_.actorSpriteComps1060 = nil
			end

			local var_224_33 = arg_221_1.actors_["1056"]
			local var_224_34 = 0

			if var_224_34 < arg_221_1.time_ and arg_221_1.time_ <= var_224_34 + arg_224_0 and not isNil(var_224_33) and arg_221_1.var_.actorSpriteComps1056 == nil then
				arg_221_1.var_.actorSpriteComps1056 = var_224_33:GetComponentsInChildren(typeof(Image), true)
			end

			local var_224_35 = 0.034

			if var_224_34 <= arg_221_1.time_ and arg_221_1.time_ < var_224_34 + var_224_35 and not isNil(var_224_33) then
				local var_224_36 = (arg_221_1.time_ - var_224_34) / var_224_35

				if arg_221_1.var_.actorSpriteComps1056 then
					for iter_224_9, iter_224_10 in pairs(arg_221_1.var_.actorSpriteComps1056:ToTable()) do
						if iter_224_10 then
							if arg_221_1.isInRecall_ then
								local var_224_37 = Mathf.Lerp(iter_224_10.color.r, arg_221_1.hightColor2.r, var_224_36)
								local var_224_38 = Mathf.Lerp(iter_224_10.color.g, arg_221_1.hightColor2.g, var_224_36)
								local var_224_39 = Mathf.Lerp(iter_224_10.color.b, arg_221_1.hightColor2.b, var_224_36)

								iter_224_10.color = Color.New(var_224_37, var_224_38, var_224_39)
							else
								local var_224_40 = Mathf.Lerp(iter_224_10.color.r, 0.5, var_224_36)

								iter_224_10.color = Color.New(var_224_40, var_224_40, var_224_40)
							end
						end
					end
				end
			end

			if arg_221_1.time_ >= var_224_34 + var_224_35 and arg_221_1.time_ < var_224_34 + var_224_35 + arg_224_0 and not isNil(var_224_33) and arg_221_1.var_.actorSpriteComps1056 then
				for iter_224_11, iter_224_12 in pairs(arg_221_1.var_.actorSpriteComps1056:ToTable()) do
					if iter_224_12 then
						if arg_221_1.isInRecall_ then
							iter_224_12.color = arg_221_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_224_12.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_221_1.var_.actorSpriteComps1056 = nil
			end

			local var_224_41 = arg_221_1.actors_["1012"]
			local var_224_42 = 0

			if var_224_42 < arg_221_1.time_ and arg_221_1.time_ <= var_224_42 + arg_224_0 and not isNil(var_224_41) and arg_221_1.var_.actorSpriteComps1012 == nil then
				arg_221_1.var_.actorSpriteComps1012 = var_224_41:GetComponentsInChildren(typeof(Image), true)
			end

			local var_224_43 = 0.034

			if var_224_42 <= arg_221_1.time_ and arg_221_1.time_ < var_224_42 + var_224_43 and not isNil(var_224_41) then
				local var_224_44 = (arg_221_1.time_ - var_224_42) / var_224_43

				if arg_221_1.var_.actorSpriteComps1012 then
					for iter_224_13, iter_224_14 in pairs(arg_221_1.var_.actorSpriteComps1012:ToTable()) do
						if iter_224_14 then
							if arg_221_1.isInRecall_ then
								local var_224_45 = Mathf.Lerp(iter_224_14.color.r, arg_221_1.hightColor2.r, var_224_44)
								local var_224_46 = Mathf.Lerp(iter_224_14.color.g, arg_221_1.hightColor2.g, var_224_44)
								local var_224_47 = Mathf.Lerp(iter_224_14.color.b, arg_221_1.hightColor2.b, var_224_44)

								iter_224_14.color = Color.New(var_224_45, var_224_46, var_224_47)
							else
								local var_224_48 = Mathf.Lerp(iter_224_14.color.r, 0.5, var_224_44)

								iter_224_14.color = Color.New(var_224_48, var_224_48, var_224_48)
							end
						end
					end
				end
			end

			if arg_221_1.time_ >= var_224_42 + var_224_43 and arg_221_1.time_ < var_224_42 + var_224_43 + arg_224_0 and not isNil(var_224_41) and arg_221_1.var_.actorSpriteComps1012 then
				for iter_224_15, iter_224_16 in pairs(arg_221_1.var_.actorSpriteComps1012:ToTable()) do
					if iter_224_16 then
						if arg_221_1.isInRecall_ then
							iter_224_16.color = arg_221_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_224_16.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_221_1.var_.actorSpriteComps1012 = nil
			end

			local var_224_49 = 0
			local var_224_50 = 0.1

			if var_224_49 < arg_221_1.time_ and arg_221_1.time_ <= var_224_49 + arg_224_0 then
				arg_221_1.talkMaxDuration = 0
				arg_221_1.dialogCg_.alpha = 1

				arg_221_1.dialog_:SetActive(true)
				SetActive(arg_221_1.leftNameGo_, true)

				local var_224_51 = arg_221_1:FormatText(StoryNameCfg[584].name)

				arg_221_1.leftNameTxt_.text = var_224_51

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_221_1.leftNameTxt_.transform)

				arg_221_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_221_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_221_1:RecordName(arg_221_1.leftNameTxt_.text)
				SetActive(arg_221_1.iconTrs_.gameObject, false)
				arg_221_1.callingController_:SetSelectedState("normal")

				local var_224_52 = arg_221_1:GetWordFromCfg(410082054)
				local var_224_53 = arg_221_1:FormatText(var_224_52.content)

				arg_221_1.text_.text = var_224_53

				LuaForUtil.ClearLinePrefixSymbol(arg_221_1.text_)

				local var_224_54 = 4
				local var_224_55 = utf8.len(var_224_53)
				local var_224_56 = var_224_54 <= 0 and var_224_50 or var_224_50 * (var_224_55 / var_224_54)

				if var_224_56 > 0 and var_224_50 < var_224_56 then
					arg_221_1.talkMaxDuration = var_224_56

					if var_224_56 + var_224_49 > arg_221_1.duration_ then
						arg_221_1.duration_ = var_224_56 + var_224_49
					end
				end

				arg_221_1.text_.text = var_224_53
				arg_221_1.typewritter.percent = 0

				arg_221_1.typewritter:SetDirty()
				arg_221_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_410082", "410082054", "story_v_out_410082.awb") ~= 0 then
					local var_224_57 = manager.audio:GetVoiceLength("story_v_out_410082", "410082054", "story_v_out_410082.awb") / 1000

					if var_224_57 + var_224_49 > arg_221_1.duration_ then
						arg_221_1.duration_ = var_224_57 + var_224_49
					end

					if var_224_52.prefab_name ~= "" and arg_221_1.actors_[var_224_52.prefab_name] ~= nil then
						local var_224_58 = LuaForUtil.PlayVoiceWithCriLipsync(arg_221_1.actors_[var_224_52.prefab_name].transform, "story_v_out_410082", "410082054", "story_v_out_410082.awb")

						arg_221_1:RecordAudio("410082054", var_224_58)
						arg_221_1:RecordAudio("410082054", var_224_58)
					else
						arg_221_1:AudioAction("play", "voice", "story_v_out_410082", "410082054", "story_v_out_410082.awb")
					end

					arg_221_1:RecordHistoryTalkVoice("story_v_out_410082", "410082054", "story_v_out_410082.awb")
				end

				arg_221_1:RecordContent(arg_221_1.text_.text)
			end

			local var_224_59 = math.max(var_224_50, arg_221_1.talkMaxDuration)

			if var_224_49 <= arg_221_1.time_ and arg_221_1.time_ < var_224_49 + var_224_59 then
				arg_221_1.typewritter.percent = (arg_221_1.time_ - var_224_49) / var_224_59

				arg_221_1.typewritter:SetDirty()
			end

			if arg_221_1.time_ >= var_224_49 + var_224_59 and arg_221_1.time_ < var_224_49 + var_224_59 + arg_224_0 then
				arg_221_1.typewritter.percent = 1

				arg_221_1.typewritter:SetDirty()
				arg_221_1:ShowNextGo(true)
			end
		end

		arg_221_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1060",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			},
			{
				assetPath = "",
				actorName = "1056",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			},
			{
				assetPath = "",
				actorName = "1012",
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
	Play410082055 = function(arg_225_0, arg_225_1)
		arg_225_1.time_ = 0
		arg_225_1.frameCnt_ = 0
		arg_225_1.state_ = "playing"
		arg_225_1.curTalkId_ = 410082055
		arg_225_1.duration_ = 2.7

		local var_225_0 = {
			zh = 2.266,
			ja = 2.7
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
				arg_225_0:Play410082056(arg_225_1)
			end
		end

		function arg_225_1.onSingleLineUpdate_(arg_228_0)
			local var_228_0 = arg_225_1.actors_["1056"].transform
			local var_228_1 = 0

			if var_228_1 < arg_225_1.time_ and arg_225_1.time_ <= var_228_1 + arg_228_0 then
				arg_225_1.var_.moveOldPos1056 = var_228_0.localPosition
				var_228_0.localScale = Vector3.New(1, 1, 1)

				arg_225_1:CheckSpriteTmpPos("1056", 3)

				local var_228_2 = var_228_0.childCount

				for iter_228_0 = 0, var_228_2 - 1 do
					local var_228_3 = var_228_0:GetChild(iter_228_0)

					if var_228_3.name == "split_4" or not string.find(var_228_3.name, "split") then
						var_228_3.gameObject:SetActive(true)
					else
						var_228_3.gameObject:SetActive(false)
					end
				end
			end

			local var_228_4 = 0.001

			if var_228_1 <= arg_225_1.time_ and arg_225_1.time_ < var_228_1 + var_228_4 then
				local var_228_5 = (arg_225_1.time_ - var_228_1) / var_228_4
				local var_228_6 = Vector3.New(0, -350, -180)

				var_228_0.localPosition = Vector3.Lerp(arg_225_1.var_.moveOldPos1056, var_228_6, var_228_5)
			end

			if arg_225_1.time_ >= var_228_1 + var_228_4 and arg_225_1.time_ < var_228_1 + var_228_4 + arg_228_0 then
				var_228_0.localPosition = Vector3.New(0, -350, -180)
			end

			local var_228_7 = arg_225_1.actors_["1056"]
			local var_228_8 = 0

			if var_228_8 < arg_225_1.time_ and arg_225_1.time_ <= var_228_8 + arg_228_0 and not isNil(var_228_7) and arg_225_1.var_.actorSpriteComps1056 == nil then
				arg_225_1.var_.actorSpriteComps1056 = var_228_7:GetComponentsInChildren(typeof(Image), true)
			end

			local var_228_9 = 0.034

			if var_228_8 <= arg_225_1.time_ and arg_225_1.time_ < var_228_8 + var_228_9 and not isNil(var_228_7) then
				local var_228_10 = (arg_225_1.time_ - var_228_8) / var_228_9

				if arg_225_1.var_.actorSpriteComps1056 then
					for iter_228_1, iter_228_2 in pairs(arg_225_1.var_.actorSpriteComps1056:ToTable()) do
						if iter_228_2 then
							if arg_225_1.isInRecall_ then
								local var_228_11 = Mathf.Lerp(iter_228_2.color.r, arg_225_1.hightColor1.r, var_228_10)
								local var_228_12 = Mathf.Lerp(iter_228_2.color.g, arg_225_1.hightColor1.g, var_228_10)
								local var_228_13 = Mathf.Lerp(iter_228_2.color.b, arg_225_1.hightColor1.b, var_228_10)

								iter_228_2.color = Color.New(var_228_11, var_228_12, var_228_13)
							else
								local var_228_14 = Mathf.Lerp(iter_228_2.color.r, 1, var_228_10)

								iter_228_2.color = Color.New(var_228_14, var_228_14, var_228_14)
							end
						end
					end
				end
			end

			if arg_225_1.time_ >= var_228_8 + var_228_9 and arg_225_1.time_ < var_228_8 + var_228_9 + arg_228_0 and not isNil(var_228_7) and arg_225_1.var_.actorSpriteComps1056 then
				for iter_228_3, iter_228_4 in pairs(arg_225_1.var_.actorSpriteComps1056:ToTable()) do
					if iter_228_4 then
						if arg_225_1.isInRecall_ then
							iter_228_4.color = arg_225_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_228_4.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_225_1.var_.actorSpriteComps1056 = nil
			end

			local var_228_15 = arg_225_1.actors_["1060"]
			local var_228_16 = 0

			if var_228_16 < arg_225_1.time_ and arg_225_1.time_ <= var_228_16 + arg_228_0 and not isNil(var_228_15) and arg_225_1.var_.actorSpriteComps1060 == nil then
				arg_225_1.var_.actorSpriteComps1060 = var_228_15:GetComponentsInChildren(typeof(Image), true)
			end

			local var_228_17 = 0.034

			if var_228_16 <= arg_225_1.time_ and arg_225_1.time_ < var_228_16 + var_228_17 and not isNil(var_228_15) then
				local var_228_18 = (arg_225_1.time_ - var_228_16) / var_228_17

				if arg_225_1.var_.actorSpriteComps1060 then
					for iter_228_5, iter_228_6 in pairs(arg_225_1.var_.actorSpriteComps1060:ToTable()) do
						if iter_228_6 then
							if arg_225_1.isInRecall_ then
								local var_228_19 = Mathf.Lerp(iter_228_6.color.r, arg_225_1.hightColor2.r, var_228_18)
								local var_228_20 = Mathf.Lerp(iter_228_6.color.g, arg_225_1.hightColor2.g, var_228_18)
								local var_228_21 = Mathf.Lerp(iter_228_6.color.b, arg_225_1.hightColor2.b, var_228_18)

								iter_228_6.color = Color.New(var_228_19, var_228_20, var_228_21)
							else
								local var_228_22 = Mathf.Lerp(iter_228_6.color.r, 0.5, var_228_18)

								iter_228_6.color = Color.New(var_228_22, var_228_22, var_228_22)
							end
						end
					end
				end
			end

			if arg_225_1.time_ >= var_228_16 + var_228_17 and arg_225_1.time_ < var_228_16 + var_228_17 + arg_228_0 and not isNil(var_228_15) and arg_225_1.var_.actorSpriteComps1060 then
				for iter_228_7, iter_228_8 in pairs(arg_225_1.var_.actorSpriteComps1060:ToTable()) do
					if iter_228_8 then
						if arg_225_1.isInRecall_ then
							iter_228_8.color = arg_225_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_228_8.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_225_1.var_.actorSpriteComps1060 = nil
			end

			local var_228_23 = 0
			local var_228_24 = 0.225

			if var_228_23 < arg_225_1.time_ and arg_225_1.time_ <= var_228_23 + arg_228_0 then
				arg_225_1.talkMaxDuration = 0
				arg_225_1.dialogCg_.alpha = 1

				arg_225_1.dialog_:SetActive(true)
				SetActive(arg_225_1.leftNameGo_, true)

				local var_228_25 = arg_225_1:FormatText(StoryNameCfg[605].name)

				arg_225_1.leftNameTxt_.text = var_228_25

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_225_1.leftNameTxt_.transform)

				arg_225_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_225_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_225_1:RecordName(arg_225_1.leftNameTxt_.text)
				SetActive(arg_225_1.iconTrs_.gameObject, false)
				arg_225_1.callingController_:SetSelectedState("normal")

				local var_228_26 = arg_225_1:GetWordFromCfg(410082055)
				local var_228_27 = arg_225_1:FormatText(var_228_26.content)

				arg_225_1.text_.text = var_228_27

				LuaForUtil.ClearLinePrefixSymbol(arg_225_1.text_)

				local var_228_28 = 9
				local var_228_29 = utf8.len(var_228_27)
				local var_228_30 = var_228_28 <= 0 and var_228_24 or var_228_24 * (var_228_29 / var_228_28)

				if var_228_30 > 0 and var_228_24 < var_228_30 then
					arg_225_1.talkMaxDuration = var_228_30

					if var_228_30 + var_228_23 > arg_225_1.duration_ then
						arg_225_1.duration_ = var_228_30 + var_228_23
					end
				end

				arg_225_1.text_.text = var_228_27
				arg_225_1.typewritter.percent = 0

				arg_225_1.typewritter:SetDirty()
				arg_225_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_410082", "410082055", "story_v_out_410082.awb") ~= 0 then
					local var_228_31 = manager.audio:GetVoiceLength("story_v_out_410082", "410082055", "story_v_out_410082.awb") / 1000

					if var_228_31 + var_228_23 > arg_225_1.duration_ then
						arg_225_1.duration_ = var_228_31 + var_228_23
					end

					if var_228_26.prefab_name ~= "" and arg_225_1.actors_[var_228_26.prefab_name] ~= nil then
						local var_228_32 = LuaForUtil.PlayVoiceWithCriLipsync(arg_225_1.actors_[var_228_26.prefab_name].transform, "story_v_out_410082", "410082055", "story_v_out_410082.awb")

						arg_225_1:RecordAudio("410082055", var_228_32)
						arg_225_1:RecordAudio("410082055", var_228_32)
					else
						arg_225_1:AudioAction("play", "voice", "story_v_out_410082", "410082055", "story_v_out_410082.awb")
					end

					arg_225_1:RecordHistoryTalkVoice("story_v_out_410082", "410082055", "story_v_out_410082.awb")
				end

				arg_225_1:RecordContent(arg_225_1.text_.text)
			end

			local var_228_33 = math.max(var_228_24, arg_225_1.talkMaxDuration)

			if var_228_23 <= arg_225_1.time_ and arg_225_1.time_ < var_228_23 + var_228_33 then
				arg_225_1.typewritter.percent = (arg_225_1.time_ - var_228_23) / var_228_33

				arg_225_1.typewritter:SetDirty()
			end

			if arg_225_1.time_ >= var_228_23 + var_228_33 and arg_225_1.time_ < var_228_23 + var_228_33 + arg_228_0 then
				arg_225_1.typewritter.percent = 1

				arg_225_1.typewritter:SetDirty()
				arg_225_1:ShowNextGo(true)
			end
		end

		arg_225_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1056",
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
	Play410082056 = function(arg_229_0, arg_229_1)
		arg_229_1.time_ = 0
		arg_229_1.frameCnt_ = 0
		arg_229_1.state_ = "playing"
		arg_229_1.curTalkId_ = 410082056
		arg_229_1.duration_ = 6.9

		local var_229_0 = {
			zh = 3.666,
			ja = 6.9
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
				arg_229_0:Play410082057(arg_229_1)
			end
		end

		function arg_229_1.onSingleLineUpdate_(arg_232_0)
			local var_232_0 = arg_229_1.actors_["1012"].transform
			local var_232_1 = 0

			if var_232_1 < arg_229_1.time_ and arg_229_1.time_ <= var_232_1 + arg_232_0 then
				arg_229_1.var_.moveOldPos1012 = var_232_0.localPosition
				var_232_0.localScale = Vector3.New(1, 1, 1)

				arg_229_1:CheckSpriteTmpPos("1012", 4)

				local var_232_2 = var_232_0.childCount

				for iter_232_0 = 0, var_232_2 - 1 do
					local var_232_3 = var_232_0:GetChild(iter_232_0)

					if var_232_3.name == "split_3" or not string.find(var_232_3.name, "split") then
						var_232_3.gameObject:SetActive(true)
					else
						var_232_3.gameObject:SetActive(false)
					end
				end
			end

			local var_232_4 = 0.001

			if var_232_1 <= arg_229_1.time_ and arg_229_1.time_ < var_232_1 + var_232_4 then
				local var_232_5 = (arg_229_1.time_ - var_232_1) / var_232_4
				local var_232_6 = Vector3.New(390, -465, 300)

				var_232_0.localPosition = Vector3.Lerp(arg_229_1.var_.moveOldPos1012, var_232_6, var_232_5)
			end

			if arg_229_1.time_ >= var_232_1 + var_232_4 and arg_229_1.time_ < var_232_1 + var_232_4 + arg_232_0 then
				var_232_0.localPosition = Vector3.New(390, -465, 300)
			end

			local var_232_7 = arg_229_1.actors_["1012"]
			local var_232_8 = 0

			if var_232_8 < arg_229_1.time_ and arg_229_1.time_ <= var_232_8 + arg_232_0 and not isNil(var_232_7) and arg_229_1.var_.actorSpriteComps1012 == nil then
				arg_229_1.var_.actorSpriteComps1012 = var_232_7:GetComponentsInChildren(typeof(Image), true)
			end

			local var_232_9 = 0.034

			if var_232_8 <= arg_229_1.time_ and arg_229_1.time_ < var_232_8 + var_232_9 and not isNil(var_232_7) then
				local var_232_10 = (arg_229_1.time_ - var_232_8) / var_232_9

				if arg_229_1.var_.actorSpriteComps1012 then
					for iter_232_1, iter_232_2 in pairs(arg_229_1.var_.actorSpriteComps1012:ToTable()) do
						if iter_232_2 then
							if arg_229_1.isInRecall_ then
								local var_232_11 = Mathf.Lerp(iter_232_2.color.r, arg_229_1.hightColor1.r, var_232_10)
								local var_232_12 = Mathf.Lerp(iter_232_2.color.g, arg_229_1.hightColor1.g, var_232_10)
								local var_232_13 = Mathf.Lerp(iter_232_2.color.b, arg_229_1.hightColor1.b, var_232_10)

								iter_232_2.color = Color.New(var_232_11, var_232_12, var_232_13)
							else
								local var_232_14 = Mathf.Lerp(iter_232_2.color.r, 1, var_232_10)

								iter_232_2.color = Color.New(var_232_14, var_232_14, var_232_14)
							end
						end
					end
				end
			end

			if arg_229_1.time_ >= var_232_8 + var_232_9 and arg_229_1.time_ < var_232_8 + var_232_9 + arg_232_0 and not isNil(var_232_7) and arg_229_1.var_.actorSpriteComps1012 then
				for iter_232_3, iter_232_4 in pairs(arg_229_1.var_.actorSpriteComps1012:ToTable()) do
					if iter_232_4 then
						if arg_229_1.isInRecall_ then
							iter_232_4.color = arg_229_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_232_4.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_229_1.var_.actorSpriteComps1012 = nil
			end

			local var_232_15 = arg_229_1.actors_["1056"]
			local var_232_16 = 0

			if var_232_16 < arg_229_1.time_ and arg_229_1.time_ <= var_232_16 + arg_232_0 and not isNil(var_232_15) and arg_229_1.var_.actorSpriteComps1056 == nil then
				arg_229_1.var_.actorSpriteComps1056 = var_232_15:GetComponentsInChildren(typeof(Image), true)
			end

			local var_232_17 = 0.034

			if var_232_16 <= arg_229_1.time_ and arg_229_1.time_ < var_232_16 + var_232_17 and not isNil(var_232_15) then
				local var_232_18 = (arg_229_1.time_ - var_232_16) / var_232_17

				if arg_229_1.var_.actorSpriteComps1056 then
					for iter_232_5, iter_232_6 in pairs(arg_229_1.var_.actorSpriteComps1056:ToTable()) do
						if iter_232_6 then
							if arg_229_1.isInRecall_ then
								local var_232_19 = Mathf.Lerp(iter_232_6.color.r, arg_229_1.hightColor2.r, var_232_18)
								local var_232_20 = Mathf.Lerp(iter_232_6.color.g, arg_229_1.hightColor2.g, var_232_18)
								local var_232_21 = Mathf.Lerp(iter_232_6.color.b, arg_229_1.hightColor2.b, var_232_18)

								iter_232_6.color = Color.New(var_232_19, var_232_20, var_232_21)
							else
								local var_232_22 = Mathf.Lerp(iter_232_6.color.r, 0.5, var_232_18)

								iter_232_6.color = Color.New(var_232_22, var_232_22, var_232_22)
							end
						end
					end
				end
			end

			if arg_229_1.time_ >= var_232_16 + var_232_17 and arg_229_1.time_ < var_232_16 + var_232_17 + arg_232_0 and not isNil(var_232_15) and arg_229_1.var_.actorSpriteComps1056 then
				for iter_232_7, iter_232_8 in pairs(arg_229_1.var_.actorSpriteComps1056:ToTable()) do
					if iter_232_8 then
						if arg_229_1.isInRecall_ then
							iter_232_8.color = arg_229_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_232_8.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_229_1.var_.actorSpriteComps1056 = nil
			end

			local var_232_23 = 0
			local var_232_24 = 0.5

			if var_232_23 < arg_229_1.time_ and arg_229_1.time_ <= var_232_23 + arg_232_0 then
				arg_229_1.talkMaxDuration = 0
				arg_229_1.dialogCg_.alpha = 1

				arg_229_1.dialog_:SetActive(true)
				SetActive(arg_229_1.leftNameGo_, true)

				local var_232_25 = arg_229_1:FormatText(StoryNameCfg[595].name)

				arg_229_1.leftNameTxt_.text = var_232_25

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_229_1.leftNameTxt_.transform)

				arg_229_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_229_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_229_1:RecordName(arg_229_1.leftNameTxt_.text)
				SetActive(arg_229_1.iconTrs_.gameObject, false)
				arg_229_1.callingController_:SetSelectedState("normal")

				local var_232_26 = arg_229_1:GetWordFromCfg(410082056)
				local var_232_27 = arg_229_1:FormatText(var_232_26.content)

				arg_229_1.text_.text = var_232_27

				LuaForUtil.ClearLinePrefixSymbol(arg_229_1.text_)

				local var_232_28 = 20
				local var_232_29 = utf8.len(var_232_27)
				local var_232_30 = var_232_28 <= 0 and var_232_24 or var_232_24 * (var_232_29 / var_232_28)

				if var_232_30 > 0 and var_232_24 < var_232_30 then
					arg_229_1.talkMaxDuration = var_232_30

					if var_232_30 + var_232_23 > arg_229_1.duration_ then
						arg_229_1.duration_ = var_232_30 + var_232_23
					end
				end

				arg_229_1.text_.text = var_232_27
				arg_229_1.typewritter.percent = 0

				arg_229_1.typewritter:SetDirty()
				arg_229_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_410082", "410082056", "story_v_out_410082.awb") ~= 0 then
					local var_232_31 = manager.audio:GetVoiceLength("story_v_out_410082", "410082056", "story_v_out_410082.awb") / 1000

					if var_232_31 + var_232_23 > arg_229_1.duration_ then
						arg_229_1.duration_ = var_232_31 + var_232_23
					end

					if var_232_26.prefab_name ~= "" and arg_229_1.actors_[var_232_26.prefab_name] ~= nil then
						local var_232_32 = LuaForUtil.PlayVoiceWithCriLipsync(arg_229_1.actors_[var_232_26.prefab_name].transform, "story_v_out_410082", "410082056", "story_v_out_410082.awb")

						arg_229_1:RecordAudio("410082056", var_232_32)
						arg_229_1:RecordAudio("410082056", var_232_32)
					else
						arg_229_1:AudioAction("play", "voice", "story_v_out_410082", "410082056", "story_v_out_410082.awb")
					end

					arg_229_1:RecordHistoryTalkVoice("story_v_out_410082", "410082056", "story_v_out_410082.awb")
				end

				arg_229_1:RecordContent(arg_229_1.text_.text)
			end

			local var_232_33 = math.max(var_232_24, arg_229_1.talkMaxDuration)

			if var_232_23 <= arg_229_1.time_ and arg_229_1.time_ < var_232_23 + var_232_33 then
				arg_229_1.typewritter.percent = (arg_229_1.time_ - var_232_23) / var_232_33

				arg_229_1.typewritter:SetDirty()
			end

			if arg_229_1.time_ >= var_232_23 + var_232_33 and arg_229_1.time_ < var_232_23 + var_232_33 + arg_232_0 then
				arg_229_1.typewritter.percent = 1

				arg_229_1.typewritter:SetDirty()
				arg_229_1:ShowNextGo(true)
			end
		end

		arg_229_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1012",
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
	Play410082057 = function(arg_233_0, arg_233_1)
		arg_233_1.time_ = 0
		arg_233_1.frameCnt_ = 0
		arg_233_1.state_ = "playing"
		arg_233_1.curTalkId_ = 410082057
		arg_233_1.duration_ = 7.37

		local var_233_0 = {
			zh = 4.333,
			ja = 7.366
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
				arg_233_0:Play410082058(arg_233_1)
			end
		end

		function arg_233_1.onSingleLineUpdate_(arg_236_0)
			local var_236_0 = arg_233_1.actors_["1060"].transform
			local var_236_1 = 0

			if var_236_1 < arg_233_1.time_ and arg_233_1.time_ <= var_236_1 + arg_236_0 then
				arg_233_1.var_.moveOldPos1060 = var_236_0.localPosition
				var_236_0.localScale = Vector3.New(1, 1, 1)

				arg_233_1:CheckSpriteTmpPos("1060", 2)

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
				local var_236_6 = Vector3.New(-440.94, -430.8, 6.9)

				var_236_0.localPosition = Vector3.Lerp(arg_233_1.var_.moveOldPos1060, var_236_6, var_236_5)
			end

			if arg_233_1.time_ >= var_236_1 + var_236_4 and arg_233_1.time_ < var_236_1 + var_236_4 + arg_236_0 then
				var_236_0.localPosition = Vector3.New(-440.94, -430.8, 6.9)
			end

			local var_236_7 = arg_233_1.actors_["1060"]
			local var_236_8 = 0

			if var_236_8 < arg_233_1.time_ and arg_233_1.time_ <= var_236_8 + arg_236_0 and not isNil(var_236_7) and arg_233_1.var_.actorSpriteComps1060 == nil then
				arg_233_1.var_.actorSpriteComps1060 = var_236_7:GetComponentsInChildren(typeof(Image), true)
			end

			local var_236_9 = 0.034

			if var_236_8 <= arg_233_1.time_ and arg_233_1.time_ < var_236_8 + var_236_9 and not isNil(var_236_7) then
				local var_236_10 = (arg_233_1.time_ - var_236_8) / var_236_9

				if arg_233_1.var_.actorSpriteComps1060 then
					for iter_236_1, iter_236_2 in pairs(arg_233_1.var_.actorSpriteComps1060:ToTable()) do
						if iter_236_2 then
							if arg_233_1.isInRecall_ then
								local var_236_11 = Mathf.Lerp(iter_236_2.color.r, arg_233_1.hightColor1.r, var_236_10)
								local var_236_12 = Mathf.Lerp(iter_236_2.color.g, arg_233_1.hightColor1.g, var_236_10)
								local var_236_13 = Mathf.Lerp(iter_236_2.color.b, arg_233_1.hightColor1.b, var_236_10)

								iter_236_2.color = Color.New(var_236_11, var_236_12, var_236_13)
							else
								local var_236_14 = Mathf.Lerp(iter_236_2.color.r, 1, var_236_10)

								iter_236_2.color = Color.New(var_236_14, var_236_14, var_236_14)
							end
						end
					end
				end
			end

			if arg_233_1.time_ >= var_236_8 + var_236_9 and arg_233_1.time_ < var_236_8 + var_236_9 + arg_236_0 and not isNil(var_236_7) and arg_233_1.var_.actorSpriteComps1060 then
				for iter_236_3, iter_236_4 in pairs(arg_233_1.var_.actorSpriteComps1060:ToTable()) do
					if iter_236_4 then
						if arg_233_1.isInRecall_ then
							iter_236_4.color = arg_233_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_236_4.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_233_1.var_.actorSpriteComps1060 = nil
			end

			local var_236_15 = arg_233_1.actors_["1012"]
			local var_236_16 = 0

			if var_236_16 < arg_233_1.time_ and arg_233_1.time_ <= var_236_16 + arg_236_0 and not isNil(var_236_15) and arg_233_1.var_.actorSpriteComps1012 == nil then
				arg_233_1.var_.actorSpriteComps1012 = var_236_15:GetComponentsInChildren(typeof(Image), true)
			end

			local var_236_17 = 0.034

			if var_236_16 <= arg_233_1.time_ and arg_233_1.time_ < var_236_16 + var_236_17 and not isNil(var_236_15) then
				local var_236_18 = (arg_233_1.time_ - var_236_16) / var_236_17

				if arg_233_1.var_.actorSpriteComps1012 then
					for iter_236_5, iter_236_6 in pairs(arg_233_1.var_.actorSpriteComps1012:ToTable()) do
						if iter_236_6 then
							if arg_233_1.isInRecall_ then
								local var_236_19 = Mathf.Lerp(iter_236_6.color.r, arg_233_1.hightColor2.r, var_236_18)
								local var_236_20 = Mathf.Lerp(iter_236_6.color.g, arg_233_1.hightColor2.g, var_236_18)
								local var_236_21 = Mathf.Lerp(iter_236_6.color.b, arg_233_1.hightColor2.b, var_236_18)

								iter_236_6.color = Color.New(var_236_19, var_236_20, var_236_21)
							else
								local var_236_22 = Mathf.Lerp(iter_236_6.color.r, 0.5, var_236_18)

								iter_236_6.color = Color.New(var_236_22, var_236_22, var_236_22)
							end
						end
					end
				end
			end

			if arg_233_1.time_ >= var_236_16 + var_236_17 and arg_233_1.time_ < var_236_16 + var_236_17 + arg_236_0 and not isNil(var_236_15) and arg_233_1.var_.actorSpriteComps1012 then
				for iter_236_7, iter_236_8 in pairs(arg_233_1.var_.actorSpriteComps1012:ToTable()) do
					if iter_236_8 then
						if arg_233_1.isInRecall_ then
							iter_236_8.color = arg_233_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_236_8.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_233_1.var_.actorSpriteComps1012 = nil
			end

			local var_236_23 = 0
			local var_236_24 = 0.575

			if var_236_23 < arg_233_1.time_ and arg_233_1.time_ <= var_236_23 + arg_236_0 then
				arg_233_1.talkMaxDuration = 0
				arg_233_1.dialogCg_.alpha = 1

				arg_233_1.dialog_:SetActive(true)
				SetActive(arg_233_1.leftNameGo_, true)

				local var_236_25 = arg_233_1:FormatText(StoryNameCfg[584].name)

				arg_233_1.leftNameTxt_.text = var_236_25

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_233_1.leftNameTxt_.transform)

				arg_233_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_233_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_233_1:RecordName(arg_233_1.leftNameTxt_.text)
				SetActive(arg_233_1.iconTrs_.gameObject, false)
				arg_233_1.callingController_:SetSelectedState("normal")

				local var_236_26 = arg_233_1:GetWordFromCfg(410082057)
				local var_236_27 = arg_233_1:FormatText(var_236_26.content)

				arg_233_1.text_.text = var_236_27

				LuaForUtil.ClearLinePrefixSymbol(arg_233_1.text_)

				local var_236_28 = 23
				local var_236_29 = utf8.len(var_236_27)
				local var_236_30 = var_236_28 <= 0 and var_236_24 or var_236_24 * (var_236_29 / var_236_28)

				if var_236_30 > 0 and var_236_24 < var_236_30 then
					arg_233_1.talkMaxDuration = var_236_30

					if var_236_30 + var_236_23 > arg_233_1.duration_ then
						arg_233_1.duration_ = var_236_30 + var_236_23
					end
				end

				arg_233_1.text_.text = var_236_27
				arg_233_1.typewritter.percent = 0

				arg_233_1.typewritter:SetDirty()
				arg_233_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_410082", "410082057", "story_v_out_410082.awb") ~= 0 then
					local var_236_31 = manager.audio:GetVoiceLength("story_v_out_410082", "410082057", "story_v_out_410082.awb") / 1000

					if var_236_31 + var_236_23 > arg_233_1.duration_ then
						arg_233_1.duration_ = var_236_31 + var_236_23
					end

					if var_236_26.prefab_name ~= "" and arg_233_1.actors_[var_236_26.prefab_name] ~= nil then
						local var_236_32 = LuaForUtil.PlayVoiceWithCriLipsync(arg_233_1.actors_[var_236_26.prefab_name].transform, "story_v_out_410082", "410082057", "story_v_out_410082.awb")

						arg_233_1:RecordAudio("410082057", var_236_32)
						arg_233_1:RecordAudio("410082057", var_236_32)
					else
						arg_233_1:AudioAction("play", "voice", "story_v_out_410082", "410082057", "story_v_out_410082.awb")
					end

					arg_233_1:RecordHistoryTalkVoice("story_v_out_410082", "410082057", "story_v_out_410082.awb")
				end

				arg_233_1:RecordContent(arg_233_1.text_.text)
			end

			local var_236_33 = math.max(var_236_24, arg_233_1.talkMaxDuration)

			if var_236_23 <= arg_233_1.time_ and arg_233_1.time_ < var_236_23 + var_236_33 then
				arg_233_1.typewritter.percent = (arg_233_1.time_ - var_236_23) / var_236_33

				arg_233_1.typewritter:SetDirty()
			end

			if arg_233_1.time_ >= var_236_23 + var_236_33 and arg_233_1.time_ < var_236_23 + var_236_33 + arg_236_0 then
				arg_233_1.typewritter.percent = 1

				arg_233_1.typewritter:SetDirty()
				arg_233_1:ShowNextGo(true)
			end
		end

		arg_233_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1060",
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
	Play410082058 = function(arg_237_0, arg_237_1)
		arg_237_1.time_ = 0
		arg_237_1.frameCnt_ = 0
		arg_237_1.state_ = "playing"
		arg_237_1.curTalkId_ = 410082058
		arg_237_1.duration_ = 8

		local var_237_0 = {
			zh = 4.833,
			ja = 8
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
				arg_237_0:Play410082059(arg_237_1)
			end
		end

		function arg_237_1.onSingleLineUpdate_(arg_240_0)
			local var_240_0 = arg_237_1.actors_["1012"].transform
			local var_240_1 = 0

			if var_240_1 < arg_237_1.time_ and arg_237_1.time_ <= var_240_1 + arg_240_0 then
				arg_237_1.var_.moveOldPos1012 = var_240_0.localPosition
				var_240_0.localScale = Vector3.New(1, 1, 1)

				arg_237_1:CheckSpriteTmpPos("1012", 4)

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
				local var_240_6 = Vector3.New(390, -465, 300)

				var_240_0.localPosition = Vector3.Lerp(arg_237_1.var_.moveOldPos1012, var_240_6, var_240_5)
			end

			if arg_237_1.time_ >= var_240_1 + var_240_4 and arg_237_1.time_ < var_240_1 + var_240_4 + arg_240_0 then
				var_240_0.localPosition = Vector3.New(390, -465, 300)
			end

			local var_240_7 = arg_237_1.actors_["1012"]
			local var_240_8 = 0

			if var_240_8 < arg_237_1.time_ and arg_237_1.time_ <= var_240_8 + arg_240_0 and not isNil(var_240_7) and arg_237_1.var_.actorSpriteComps1012 == nil then
				arg_237_1.var_.actorSpriteComps1012 = var_240_7:GetComponentsInChildren(typeof(Image), true)
			end

			local var_240_9 = 0.034

			if var_240_8 <= arg_237_1.time_ and arg_237_1.time_ < var_240_8 + var_240_9 and not isNil(var_240_7) then
				local var_240_10 = (arg_237_1.time_ - var_240_8) / var_240_9

				if arg_237_1.var_.actorSpriteComps1012 then
					for iter_240_1, iter_240_2 in pairs(arg_237_1.var_.actorSpriteComps1012:ToTable()) do
						if iter_240_2 then
							if arg_237_1.isInRecall_ then
								local var_240_11 = Mathf.Lerp(iter_240_2.color.r, arg_237_1.hightColor1.r, var_240_10)
								local var_240_12 = Mathf.Lerp(iter_240_2.color.g, arg_237_1.hightColor1.g, var_240_10)
								local var_240_13 = Mathf.Lerp(iter_240_2.color.b, arg_237_1.hightColor1.b, var_240_10)

								iter_240_2.color = Color.New(var_240_11, var_240_12, var_240_13)
							else
								local var_240_14 = Mathf.Lerp(iter_240_2.color.r, 1, var_240_10)

								iter_240_2.color = Color.New(var_240_14, var_240_14, var_240_14)
							end
						end
					end
				end
			end

			if arg_237_1.time_ >= var_240_8 + var_240_9 and arg_237_1.time_ < var_240_8 + var_240_9 + arg_240_0 and not isNil(var_240_7) and arg_237_1.var_.actorSpriteComps1012 then
				for iter_240_3, iter_240_4 in pairs(arg_237_1.var_.actorSpriteComps1012:ToTable()) do
					if iter_240_4 then
						if arg_237_1.isInRecall_ then
							iter_240_4.color = arg_237_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_240_4.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_237_1.var_.actorSpriteComps1012 = nil
			end

			local var_240_15 = arg_237_1.actors_["1060"]
			local var_240_16 = 0

			if var_240_16 < arg_237_1.time_ and arg_237_1.time_ <= var_240_16 + arg_240_0 and not isNil(var_240_15) and arg_237_1.var_.actorSpriteComps1060 == nil then
				arg_237_1.var_.actorSpriteComps1060 = var_240_15:GetComponentsInChildren(typeof(Image), true)
			end

			local var_240_17 = 0.034

			if var_240_16 <= arg_237_1.time_ and arg_237_1.time_ < var_240_16 + var_240_17 and not isNil(var_240_15) then
				local var_240_18 = (arg_237_1.time_ - var_240_16) / var_240_17

				if arg_237_1.var_.actorSpriteComps1060 then
					for iter_240_5, iter_240_6 in pairs(arg_237_1.var_.actorSpriteComps1060:ToTable()) do
						if iter_240_6 then
							if arg_237_1.isInRecall_ then
								local var_240_19 = Mathf.Lerp(iter_240_6.color.r, arg_237_1.hightColor2.r, var_240_18)
								local var_240_20 = Mathf.Lerp(iter_240_6.color.g, arg_237_1.hightColor2.g, var_240_18)
								local var_240_21 = Mathf.Lerp(iter_240_6.color.b, arg_237_1.hightColor2.b, var_240_18)

								iter_240_6.color = Color.New(var_240_19, var_240_20, var_240_21)
							else
								local var_240_22 = Mathf.Lerp(iter_240_6.color.r, 0.5, var_240_18)

								iter_240_6.color = Color.New(var_240_22, var_240_22, var_240_22)
							end
						end
					end
				end
			end

			if arg_237_1.time_ >= var_240_16 + var_240_17 and arg_237_1.time_ < var_240_16 + var_240_17 + arg_240_0 and not isNil(var_240_15) and arg_237_1.var_.actorSpriteComps1060 then
				for iter_240_7, iter_240_8 in pairs(arg_237_1.var_.actorSpriteComps1060:ToTable()) do
					if iter_240_8 then
						if arg_237_1.isInRecall_ then
							iter_240_8.color = arg_237_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_240_8.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_237_1.var_.actorSpriteComps1060 = nil
			end

			local var_240_23 = 0
			local var_240_24 = 0.7

			if var_240_23 < arg_237_1.time_ and arg_237_1.time_ <= var_240_23 + arg_240_0 then
				arg_237_1.talkMaxDuration = 0
				arg_237_1.dialogCg_.alpha = 1

				arg_237_1.dialog_:SetActive(true)
				SetActive(arg_237_1.leftNameGo_, true)

				local var_240_25 = arg_237_1:FormatText(StoryNameCfg[595].name)

				arg_237_1.leftNameTxt_.text = var_240_25

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_237_1.leftNameTxt_.transform)

				arg_237_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_237_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_237_1:RecordName(arg_237_1.leftNameTxt_.text)
				SetActive(arg_237_1.iconTrs_.gameObject, false)
				arg_237_1.callingController_:SetSelectedState("normal")

				local var_240_26 = arg_237_1:GetWordFromCfg(410082058)
				local var_240_27 = arg_237_1:FormatText(var_240_26.content)

				arg_237_1.text_.text = var_240_27

				LuaForUtil.ClearLinePrefixSymbol(arg_237_1.text_)

				local var_240_28 = 28
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

				if manager.audio:GetVoiceLength("story_v_out_410082", "410082058", "story_v_out_410082.awb") ~= 0 then
					local var_240_31 = manager.audio:GetVoiceLength("story_v_out_410082", "410082058", "story_v_out_410082.awb") / 1000

					if var_240_31 + var_240_23 > arg_237_1.duration_ then
						arg_237_1.duration_ = var_240_31 + var_240_23
					end

					if var_240_26.prefab_name ~= "" and arg_237_1.actors_[var_240_26.prefab_name] ~= nil then
						local var_240_32 = LuaForUtil.PlayVoiceWithCriLipsync(arg_237_1.actors_[var_240_26.prefab_name].transform, "story_v_out_410082", "410082058", "story_v_out_410082.awb")

						arg_237_1:RecordAudio("410082058", var_240_32)
						arg_237_1:RecordAudio("410082058", var_240_32)
					else
						arg_237_1:AudioAction("play", "voice", "story_v_out_410082", "410082058", "story_v_out_410082.awb")
					end

					arg_237_1:RecordHistoryTalkVoice("story_v_out_410082", "410082058", "story_v_out_410082.awb")
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
				actorName = "1012",
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
	Play410082059 = function(arg_241_0, arg_241_1)
		arg_241_1.time_ = 0
		arg_241_1.frameCnt_ = 0
		arg_241_1.state_ = "playing"
		arg_241_1.curTalkId_ = 410082059
		arg_241_1.duration_ = 9

		local var_241_0 = {
			zh = 4.6,
			ja = 9
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
				arg_241_0:Play410082060(arg_241_1)
			end
		end

		function arg_241_1.onSingleLineUpdate_(arg_244_0)
			local var_244_0 = 0
			local var_244_1 = 0.675

			if var_244_0 < arg_241_1.time_ and arg_241_1.time_ <= var_244_0 + arg_244_0 then
				arg_241_1.talkMaxDuration = 0
				arg_241_1.dialogCg_.alpha = 1

				arg_241_1.dialog_:SetActive(true)
				SetActive(arg_241_1.leftNameGo_, true)

				local var_244_2 = arg_241_1:FormatText(StoryNameCfg[595].name)

				arg_241_1.leftNameTxt_.text = var_244_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_241_1.leftNameTxt_.transform)

				arg_241_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_241_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_241_1:RecordName(arg_241_1.leftNameTxt_.text)
				SetActive(arg_241_1.iconTrs_.gameObject, false)
				arg_241_1.callingController_:SetSelectedState("normal")

				local var_244_3 = arg_241_1:GetWordFromCfg(410082059)
				local var_244_4 = arg_241_1:FormatText(var_244_3.content)

				arg_241_1.text_.text = var_244_4

				LuaForUtil.ClearLinePrefixSymbol(arg_241_1.text_)

				local var_244_5 = 27
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

				if manager.audio:GetVoiceLength("story_v_out_410082", "410082059", "story_v_out_410082.awb") ~= 0 then
					local var_244_8 = manager.audio:GetVoiceLength("story_v_out_410082", "410082059", "story_v_out_410082.awb") / 1000

					if var_244_8 + var_244_0 > arg_241_1.duration_ then
						arg_241_1.duration_ = var_244_8 + var_244_0
					end

					if var_244_3.prefab_name ~= "" and arg_241_1.actors_[var_244_3.prefab_name] ~= nil then
						local var_244_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_241_1.actors_[var_244_3.prefab_name].transform, "story_v_out_410082", "410082059", "story_v_out_410082.awb")

						arg_241_1:RecordAudio("410082059", var_244_9)
						arg_241_1:RecordAudio("410082059", var_244_9)
					else
						arg_241_1:AudioAction("play", "voice", "story_v_out_410082", "410082059", "story_v_out_410082.awb")
					end

					arg_241_1:RecordHistoryTalkVoice("story_v_out_410082", "410082059", "story_v_out_410082.awb")
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
	Play410082060 = function(arg_245_0, arg_245_1)
		arg_245_1.time_ = 0
		arg_245_1.frameCnt_ = 0
		arg_245_1.state_ = "playing"
		arg_245_1.curTalkId_ = 410082060
		arg_245_1.duration_ = 14.87

		local var_245_0 = {
			zh = 8.6,
			ja = 14.866
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
				arg_245_0:Play410082061(arg_245_1)
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

				local var_248_2 = arg_245_1:FormatText(StoryNameCfg[595].name)

				arg_245_1.leftNameTxt_.text = var_248_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_245_1.leftNameTxt_.transform)

				arg_245_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_245_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_245_1:RecordName(arg_245_1.leftNameTxt_.text)
				SetActive(arg_245_1.iconTrs_.gameObject, false)
				arg_245_1.callingController_:SetSelectedState("normal")

				local var_248_3 = arg_245_1:GetWordFromCfg(410082060)
				local var_248_4 = arg_245_1:FormatText(var_248_3.content)

				arg_245_1.text_.text = var_248_4

				LuaForUtil.ClearLinePrefixSymbol(arg_245_1.text_)

				local var_248_5 = 39
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

				if manager.audio:GetVoiceLength("story_v_out_410082", "410082060", "story_v_out_410082.awb") ~= 0 then
					local var_248_8 = manager.audio:GetVoiceLength("story_v_out_410082", "410082060", "story_v_out_410082.awb") / 1000

					if var_248_8 + var_248_0 > arg_245_1.duration_ then
						arg_245_1.duration_ = var_248_8 + var_248_0
					end

					if var_248_3.prefab_name ~= "" and arg_245_1.actors_[var_248_3.prefab_name] ~= nil then
						local var_248_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_245_1.actors_[var_248_3.prefab_name].transform, "story_v_out_410082", "410082060", "story_v_out_410082.awb")

						arg_245_1:RecordAudio("410082060", var_248_9)
						arg_245_1:RecordAudio("410082060", var_248_9)
					else
						arg_245_1:AudioAction("play", "voice", "story_v_out_410082", "410082060", "story_v_out_410082.awb")
					end

					arg_245_1:RecordHistoryTalkVoice("story_v_out_410082", "410082060", "story_v_out_410082.awb")
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
	Play410082061 = function(arg_249_0, arg_249_1)
		arg_249_1.time_ = 0
		arg_249_1.frameCnt_ = 0
		arg_249_1.state_ = "playing"
		arg_249_1.curTalkId_ = 410082061
		arg_249_1.duration_ = 5.63

		local var_249_0 = {
			zh = 5.633,
			ja = 4.666
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
				arg_249_0:Play410082062(arg_249_1)
			end
		end

		function arg_249_1.onSingleLineUpdate_(arg_252_0)
			local var_252_0 = arg_249_1.actors_["1056"].transform
			local var_252_1 = 0

			if var_252_1 < arg_249_1.time_ and arg_249_1.time_ <= var_252_1 + arg_252_0 then
				arg_249_1.var_.moveOldPos1056 = var_252_0.localPosition
				var_252_0.localScale = Vector3.New(1, 1, 1)

				arg_249_1:CheckSpriteTmpPos("1056", 3)

				local var_252_2 = var_252_0.childCount

				for iter_252_0 = 0, var_252_2 - 1 do
					local var_252_3 = var_252_0:GetChild(iter_252_0)

					if var_252_3.name == "split_2" or not string.find(var_252_3.name, "split") then
						var_252_3.gameObject:SetActive(true)
					else
						var_252_3.gameObject:SetActive(false)
					end
				end
			end

			local var_252_4 = 0.001

			if var_252_1 <= arg_249_1.time_ and arg_249_1.time_ < var_252_1 + var_252_4 then
				local var_252_5 = (arg_249_1.time_ - var_252_1) / var_252_4
				local var_252_6 = Vector3.New(0, -350, -180)

				var_252_0.localPosition = Vector3.Lerp(arg_249_1.var_.moveOldPos1056, var_252_6, var_252_5)
			end

			if arg_249_1.time_ >= var_252_1 + var_252_4 and arg_249_1.time_ < var_252_1 + var_252_4 + arg_252_0 then
				var_252_0.localPosition = Vector3.New(0, -350, -180)
			end

			local var_252_7 = arg_249_1.actors_["1056"]
			local var_252_8 = 0

			if var_252_8 < arg_249_1.time_ and arg_249_1.time_ <= var_252_8 + arg_252_0 and not isNil(var_252_7) and arg_249_1.var_.actorSpriteComps1056 == nil then
				arg_249_1.var_.actorSpriteComps1056 = var_252_7:GetComponentsInChildren(typeof(Image), true)
			end

			local var_252_9 = 0.034

			if var_252_8 <= arg_249_1.time_ and arg_249_1.time_ < var_252_8 + var_252_9 and not isNil(var_252_7) then
				local var_252_10 = (arg_249_1.time_ - var_252_8) / var_252_9

				if arg_249_1.var_.actorSpriteComps1056 then
					for iter_252_1, iter_252_2 in pairs(arg_249_1.var_.actorSpriteComps1056:ToTable()) do
						if iter_252_2 then
							if arg_249_1.isInRecall_ then
								local var_252_11 = Mathf.Lerp(iter_252_2.color.r, arg_249_1.hightColor1.r, var_252_10)
								local var_252_12 = Mathf.Lerp(iter_252_2.color.g, arg_249_1.hightColor1.g, var_252_10)
								local var_252_13 = Mathf.Lerp(iter_252_2.color.b, arg_249_1.hightColor1.b, var_252_10)

								iter_252_2.color = Color.New(var_252_11, var_252_12, var_252_13)
							else
								local var_252_14 = Mathf.Lerp(iter_252_2.color.r, 1, var_252_10)

								iter_252_2.color = Color.New(var_252_14, var_252_14, var_252_14)
							end
						end
					end
				end
			end

			if arg_249_1.time_ >= var_252_8 + var_252_9 and arg_249_1.time_ < var_252_8 + var_252_9 + arg_252_0 and not isNil(var_252_7) and arg_249_1.var_.actorSpriteComps1056 then
				for iter_252_3, iter_252_4 in pairs(arg_249_1.var_.actorSpriteComps1056:ToTable()) do
					if iter_252_4 then
						if arg_249_1.isInRecall_ then
							iter_252_4.color = arg_249_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_252_4.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_249_1.var_.actorSpriteComps1056 = nil
			end

			local var_252_15 = arg_249_1.actors_["1012"]
			local var_252_16 = 0

			if var_252_16 < arg_249_1.time_ and arg_249_1.time_ <= var_252_16 + arg_252_0 and not isNil(var_252_15) and arg_249_1.var_.actorSpriteComps1012 == nil then
				arg_249_1.var_.actorSpriteComps1012 = var_252_15:GetComponentsInChildren(typeof(Image), true)
			end

			local var_252_17 = 0.034

			if var_252_16 <= arg_249_1.time_ and arg_249_1.time_ < var_252_16 + var_252_17 and not isNil(var_252_15) then
				local var_252_18 = (arg_249_1.time_ - var_252_16) / var_252_17

				if arg_249_1.var_.actorSpriteComps1012 then
					for iter_252_5, iter_252_6 in pairs(arg_249_1.var_.actorSpriteComps1012:ToTable()) do
						if iter_252_6 then
							if arg_249_1.isInRecall_ then
								local var_252_19 = Mathf.Lerp(iter_252_6.color.r, arg_249_1.hightColor2.r, var_252_18)
								local var_252_20 = Mathf.Lerp(iter_252_6.color.g, arg_249_1.hightColor2.g, var_252_18)
								local var_252_21 = Mathf.Lerp(iter_252_6.color.b, arg_249_1.hightColor2.b, var_252_18)

								iter_252_6.color = Color.New(var_252_19, var_252_20, var_252_21)
							else
								local var_252_22 = Mathf.Lerp(iter_252_6.color.r, 0.5, var_252_18)

								iter_252_6.color = Color.New(var_252_22, var_252_22, var_252_22)
							end
						end
					end
				end
			end

			if arg_249_1.time_ >= var_252_16 + var_252_17 and arg_249_1.time_ < var_252_16 + var_252_17 + arg_252_0 and not isNil(var_252_15) and arg_249_1.var_.actorSpriteComps1012 then
				for iter_252_7, iter_252_8 in pairs(arg_249_1.var_.actorSpriteComps1012:ToTable()) do
					if iter_252_8 then
						if arg_249_1.isInRecall_ then
							iter_252_8.color = arg_249_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_252_8.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_249_1.var_.actorSpriteComps1012 = nil
			end

			local var_252_23 = 0
			local var_252_24 = 0.7

			if var_252_23 < arg_249_1.time_ and arg_249_1.time_ <= var_252_23 + arg_252_0 then
				arg_249_1.talkMaxDuration = 0
				arg_249_1.dialogCg_.alpha = 1

				arg_249_1.dialog_:SetActive(true)
				SetActive(arg_249_1.leftNameGo_, true)

				local var_252_25 = arg_249_1:FormatText(StoryNameCfg[605].name)

				arg_249_1.leftNameTxt_.text = var_252_25

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_249_1.leftNameTxt_.transform)

				arg_249_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_249_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_249_1:RecordName(arg_249_1.leftNameTxt_.text)
				SetActive(arg_249_1.iconTrs_.gameObject, false)
				arg_249_1.callingController_:SetSelectedState("normal")

				local var_252_26 = arg_249_1:GetWordFromCfg(410082061)
				local var_252_27 = arg_249_1:FormatText(var_252_26.content)

				arg_249_1.text_.text = var_252_27

				LuaForUtil.ClearLinePrefixSymbol(arg_249_1.text_)

				local var_252_28 = 28
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

				if manager.audio:GetVoiceLength("story_v_out_410082", "410082061", "story_v_out_410082.awb") ~= 0 then
					local var_252_31 = manager.audio:GetVoiceLength("story_v_out_410082", "410082061", "story_v_out_410082.awb") / 1000

					if var_252_31 + var_252_23 > arg_249_1.duration_ then
						arg_249_1.duration_ = var_252_31 + var_252_23
					end

					if var_252_26.prefab_name ~= "" and arg_249_1.actors_[var_252_26.prefab_name] ~= nil then
						local var_252_32 = LuaForUtil.PlayVoiceWithCriLipsync(arg_249_1.actors_[var_252_26.prefab_name].transform, "story_v_out_410082", "410082061", "story_v_out_410082.awb")

						arg_249_1:RecordAudio("410082061", var_252_32)
						arg_249_1:RecordAudio("410082061", var_252_32)
					else
						arg_249_1:AudioAction("play", "voice", "story_v_out_410082", "410082061", "story_v_out_410082.awb")
					end

					arg_249_1:RecordHistoryTalkVoice("story_v_out_410082", "410082061", "story_v_out_410082.awb")
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
				actorName = "1056",
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
	Play410082062 = function(arg_253_0, arg_253_1)
		arg_253_1.time_ = 0
		arg_253_1.frameCnt_ = 0
		arg_253_1.state_ = "playing"
		arg_253_1.curTalkId_ = 410082062
		arg_253_1.duration_ = 4.53

		local var_253_0 = {
			zh = 1.833,
			ja = 4.533
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
				arg_253_0:Play410082063(arg_253_1)
			end
		end

		function arg_253_1.onSingleLineUpdate_(arg_256_0)
			local var_256_0 = arg_253_1.actors_["1012"].transform
			local var_256_1 = 0

			if var_256_1 < arg_253_1.time_ and arg_253_1.time_ <= var_256_1 + arg_256_0 then
				arg_253_1.var_.moveOldPos1012 = var_256_0.localPosition
				var_256_0.localScale = Vector3.New(1, 1, 1)

				arg_253_1:CheckSpriteTmpPos("1012", 4)

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
				local var_256_6 = Vector3.New(390, -465, 300)

				var_256_0.localPosition = Vector3.Lerp(arg_253_1.var_.moveOldPos1012, var_256_6, var_256_5)
			end

			if arg_253_1.time_ >= var_256_1 + var_256_4 and arg_253_1.time_ < var_256_1 + var_256_4 + arg_256_0 then
				var_256_0.localPosition = Vector3.New(390, -465, 300)
			end

			local var_256_7 = arg_253_1.actors_["1012"]
			local var_256_8 = 0

			if var_256_8 < arg_253_1.time_ and arg_253_1.time_ <= var_256_8 + arg_256_0 and not isNil(var_256_7) and arg_253_1.var_.actorSpriteComps1012 == nil then
				arg_253_1.var_.actorSpriteComps1012 = var_256_7:GetComponentsInChildren(typeof(Image), true)
			end

			local var_256_9 = 0.034

			if var_256_8 <= arg_253_1.time_ and arg_253_1.time_ < var_256_8 + var_256_9 and not isNil(var_256_7) then
				local var_256_10 = (arg_253_1.time_ - var_256_8) / var_256_9

				if arg_253_1.var_.actorSpriteComps1012 then
					for iter_256_1, iter_256_2 in pairs(arg_253_1.var_.actorSpriteComps1012:ToTable()) do
						if iter_256_2 then
							if arg_253_1.isInRecall_ then
								local var_256_11 = Mathf.Lerp(iter_256_2.color.r, arg_253_1.hightColor1.r, var_256_10)
								local var_256_12 = Mathf.Lerp(iter_256_2.color.g, arg_253_1.hightColor1.g, var_256_10)
								local var_256_13 = Mathf.Lerp(iter_256_2.color.b, arg_253_1.hightColor1.b, var_256_10)

								iter_256_2.color = Color.New(var_256_11, var_256_12, var_256_13)
							else
								local var_256_14 = Mathf.Lerp(iter_256_2.color.r, 1, var_256_10)

								iter_256_2.color = Color.New(var_256_14, var_256_14, var_256_14)
							end
						end
					end
				end
			end

			if arg_253_1.time_ >= var_256_8 + var_256_9 and arg_253_1.time_ < var_256_8 + var_256_9 + arg_256_0 and not isNil(var_256_7) and arg_253_1.var_.actorSpriteComps1012 then
				for iter_256_3, iter_256_4 in pairs(arg_253_1.var_.actorSpriteComps1012:ToTable()) do
					if iter_256_4 then
						if arg_253_1.isInRecall_ then
							iter_256_4.color = arg_253_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_256_4.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_253_1.var_.actorSpriteComps1012 = nil
			end

			local var_256_15 = arg_253_1.actors_["1056"]
			local var_256_16 = 0

			if var_256_16 < arg_253_1.time_ and arg_253_1.time_ <= var_256_16 + arg_256_0 and not isNil(var_256_15) and arg_253_1.var_.actorSpriteComps1056 == nil then
				arg_253_1.var_.actorSpriteComps1056 = var_256_15:GetComponentsInChildren(typeof(Image), true)
			end

			local var_256_17 = 0.034

			if var_256_16 <= arg_253_1.time_ and arg_253_1.time_ < var_256_16 + var_256_17 and not isNil(var_256_15) then
				local var_256_18 = (arg_253_1.time_ - var_256_16) / var_256_17

				if arg_253_1.var_.actorSpriteComps1056 then
					for iter_256_5, iter_256_6 in pairs(arg_253_1.var_.actorSpriteComps1056:ToTable()) do
						if iter_256_6 then
							if arg_253_1.isInRecall_ then
								local var_256_19 = Mathf.Lerp(iter_256_6.color.r, arg_253_1.hightColor2.r, var_256_18)
								local var_256_20 = Mathf.Lerp(iter_256_6.color.g, arg_253_1.hightColor2.g, var_256_18)
								local var_256_21 = Mathf.Lerp(iter_256_6.color.b, arg_253_1.hightColor2.b, var_256_18)

								iter_256_6.color = Color.New(var_256_19, var_256_20, var_256_21)
							else
								local var_256_22 = Mathf.Lerp(iter_256_6.color.r, 0.5, var_256_18)

								iter_256_6.color = Color.New(var_256_22, var_256_22, var_256_22)
							end
						end
					end
				end
			end

			if arg_253_1.time_ >= var_256_16 + var_256_17 and arg_253_1.time_ < var_256_16 + var_256_17 + arg_256_0 and not isNil(var_256_15) and arg_253_1.var_.actorSpriteComps1056 then
				for iter_256_7, iter_256_8 in pairs(arg_253_1.var_.actorSpriteComps1056:ToTable()) do
					if iter_256_8 then
						if arg_253_1.isInRecall_ then
							iter_256_8.color = arg_253_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_256_8.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_253_1.var_.actorSpriteComps1056 = nil
			end

			local var_256_23 = 0
			local var_256_24 = 0.15

			if var_256_23 < arg_253_1.time_ and arg_253_1.time_ <= var_256_23 + arg_256_0 then
				arg_253_1.talkMaxDuration = 0
				arg_253_1.dialogCg_.alpha = 1

				arg_253_1.dialog_:SetActive(true)
				SetActive(arg_253_1.leftNameGo_, true)

				local var_256_25 = arg_253_1:FormatText(StoryNameCfg[595].name)

				arg_253_1.leftNameTxt_.text = var_256_25

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_253_1.leftNameTxt_.transform)

				arg_253_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_253_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_253_1:RecordName(arg_253_1.leftNameTxt_.text)
				SetActive(arg_253_1.iconTrs_.gameObject, false)
				arg_253_1.callingController_:SetSelectedState("normal")

				local var_256_26 = arg_253_1:GetWordFromCfg(410082062)
				local var_256_27 = arg_253_1:FormatText(var_256_26.content)

				arg_253_1.text_.text = var_256_27

				LuaForUtil.ClearLinePrefixSymbol(arg_253_1.text_)

				local var_256_28 = 6
				local var_256_29 = utf8.len(var_256_27)
				local var_256_30 = var_256_28 <= 0 and var_256_24 or var_256_24 * (var_256_29 / var_256_28)

				if var_256_30 > 0 and var_256_24 < var_256_30 then
					arg_253_1.talkMaxDuration = var_256_30

					if var_256_30 + var_256_23 > arg_253_1.duration_ then
						arg_253_1.duration_ = var_256_30 + var_256_23
					end
				end

				arg_253_1.text_.text = var_256_27
				arg_253_1.typewritter.percent = 0

				arg_253_1.typewritter:SetDirty()
				arg_253_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_410082", "410082062", "story_v_out_410082.awb") ~= 0 then
					local var_256_31 = manager.audio:GetVoiceLength("story_v_out_410082", "410082062", "story_v_out_410082.awb") / 1000

					if var_256_31 + var_256_23 > arg_253_1.duration_ then
						arg_253_1.duration_ = var_256_31 + var_256_23
					end

					if var_256_26.prefab_name ~= "" and arg_253_1.actors_[var_256_26.prefab_name] ~= nil then
						local var_256_32 = LuaForUtil.PlayVoiceWithCriLipsync(arg_253_1.actors_[var_256_26.prefab_name].transform, "story_v_out_410082", "410082062", "story_v_out_410082.awb")

						arg_253_1:RecordAudio("410082062", var_256_32)
						arg_253_1:RecordAudio("410082062", var_256_32)
					else
						arg_253_1:AudioAction("play", "voice", "story_v_out_410082", "410082062", "story_v_out_410082.awb")
					end

					arg_253_1:RecordHistoryTalkVoice("story_v_out_410082", "410082062", "story_v_out_410082.awb")
				end

				arg_253_1:RecordContent(arg_253_1.text_.text)
			end

			local var_256_33 = math.max(var_256_24, arg_253_1.talkMaxDuration)

			if var_256_23 <= arg_253_1.time_ and arg_253_1.time_ < var_256_23 + var_256_33 then
				arg_253_1.typewritter.percent = (arg_253_1.time_ - var_256_23) / var_256_33

				arg_253_1.typewritter:SetDirty()
			end

			if arg_253_1.time_ >= var_256_23 + var_256_33 and arg_253_1.time_ < var_256_23 + var_256_33 + arg_256_0 then
				arg_253_1.typewritter.percent = 1

				arg_253_1.typewritter:SetDirty()
				arg_253_1:ShowNextGo(true)
			end
		end

		arg_253_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1012",
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
	Play410082063 = function(arg_257_0, arg_257_1)
		arg_257_1.time_ = 0
		arg_257_1.frameCnt_ = 0
		arg_257_1.state_ = "playing"
		arg_257_1.curTalkId_ = 410082063
		arg_257_1.duration_ = 3.7

		local var_257_0 = {
			zh = 1.066,
			ja = 3.7
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
				arg_257_0:Play410082064(arg_257_1)
			end
		end

		function arg_257_1.onSingleLineUpdate_(arg_260_0)
			local var_260_0 = arg_257_1.actors_["1056"].transform
			local var_260_1 = 0

			if var_260_1 < arg_257_1.time_ and arg_257_1.time_ <= var_260_1 + arg_260_0 then
				arg_257_1.var_.moveOldPos1056 = var_260_0.localPosition
				var_260_0.localScale = Vector3.New(1, 1, 1)

				arg_257_1:CheckSpriteTmpPos("1056", 3)

				local var_260_2 = var_260_0.childCount

				for iter_260_0 = 0, var_260_2 - 1 do
					local var_260_3 = var_260_0:GetChild(iter_260_0)

					if var_260_3.name == "split_4" or not string.find(var_260_3.name, "split") then
						var_260_3.gameObject:SetActive(true)
					else
						var_260_3.gameObject:SetActive(false)
					end
				end
			end

			local var_260_4 = 0.001

			if var_260_1 <= arg_257_1.time_ and arg_257_1.time_ < var_260_1 + var_260_4 then
				local var_260_5 = (arg_257_1.time_ - var_260_1) / var_260_4
				local var_260_6 = Vector3.New(0, -350, -180)

				var_260_0.localPosition = Vector3.Lerp(arg_257_1.var_.moveOldPos1056, var_260_6, var_260_5)
			end

			if arg_257_1.time_ >= var_260_1 + var_260_4 and arg_257_1.time_ < var_260_1 + var_260_4 + arg_260_0 then
				var_260_0.localPosition = Vector3.New(0, -350, -180)
			end

			local var_260_7 = arg_257_1.actors_["1056"]
			local var_260_8 = 0

			if var_260_8 < arg_257_1.time_ and arg_257_1.time_ <= var_260_8 + arg_260_0 and not isNil(var_260_7) and arg_257_1.var_.actorSpriteComps1056 == nil then
				arg_257_1.var_.actorSpriteComps1056 = var_260_7:GetComponentsInChildren(typeof(Image), true)
			end

			local var_260_9 = 0.034

			if var_260_8 <= arg_257_1.time_ and arg_257_1.time_ < var_260_8 + var_260_9 and not isNil(var_260_7) then
				local var_260_10 = (arg_257_1.time_ - var_260_8) / var_260_9

				if arg_257_1.var_.actorSpriteComps1056 then
					for iter_260_1, iter_260_2 in pairs(arg_257_1.var_.actorSpriteComps1056:ToTable()) do
						if iter_260_2 then
							if arg_257_1.isInRecall_ then
								local var_260_11 = Mathf.Lerp(iter_260_2.color.r, arg_257_1.hightColor1.r, var_260_10)
								local var_260_12 = Mathf.Lerp(iter_260_2.color.g, arg_257_1.hightColor1.g, var_260_10)
								local var_260_13 = Mathf.Lerp(iter_260_2.color.b, arg_257_1.hightColor1.b, var_260_10)

								iter_260_2.color = Color.New(var_260_11, var_260_12, var_260_13)
							else
								local var_260_14 = Mathf.Lerp(iter_260_2.color.r, 1, var_260_10)

								iter_260_2.color = Color.New(var_260_14, var_260_14, var_260_14)
							end
						end
					end
				end
			end

			if arg_257_1.time_ >= var_260_8 + var_260_9 and arg_257_1.time_ < var_260_8 + var_260_9 + arg_260_0 and not isNil(var_260_7) and arg_257_1.var_.actorSpriteComps1056 then
				for iter_260_3, iter_260_4 in pairs(arg_257_1.var_.actorSpriteComps1056:ToTable()) do
					if iter_260_4 then
						if arg_257_1.isInRecall_ then
							iter_260_4.color = arg_257_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_260_4.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_257_1.var_.actorSpriteComps1056 = nil
			end

			local var_260_15 = arg_257_1.actors_["1012"]
			local var_260_16 = 0

			if var_260_16 < arg_257_1.time_ and arg_257_1.time_ <= var_260_16 + arg_260_0 and not isNil(var_260_15) and arg_257_1.var_.actorSpriteComps1012 == nil then
				arg_257_1.var_.actorSpriteComps1012 = var_260_15:GetComponentsInChildren(typeof(Image), true)
			end

			local var_260_17 = 0.034

			if var_260_16 <= arg_257_1.time_ and arg_257_1.time_ < var_260_16 + var_260_17 and not isNil(var_260_15) then
				local var_260_18 = (arg_257_1.time_ - var_260_16) / var_260_17

				if arg_257_1.var_.actorSpriteComps1012 then
					for iter_260_5, iter_260_6 in pairs(arg_257_1.var_.actorSpriteComps1012:ToTable()) do
						if iter_260_6 then
							if arg_257_1.isInRecall_ then
								local var_260_19 = Mathf.Lerp(iter_260_6.color.r, arg_257_1.hightColor2.r, var_260_18)
								local var_260_20 = Mathf.Lerp(iter_260_6.color.g, arg_257_1.hightColor2.g, var_260_18)
								local var_260_21 = Mathf.Lerp(iter_260_6.color.b, arg_257_1.hightColor2.b, var_260_18)

								iter_260_6.color = Color.New(var_260_19, var_260_20, var_260_21)
							else
								local var_260_22 = Mathf.Lerp(iter_260_6.color.r, 0.5, var_260_18)

								iter_260_6.color = Color.New(var_260_22, var_260_22, var_260_22)
							end
						end
					end
				end
			end

			if arg_257_1.time_ >= var_260_16 + var_260_17 and arg_257_1.time_ < var_260_16 + var_260_17 + arg_260_0 and not isNil(var_260_15) and arg_257_1.var_.actorSpriteComps1012 then
				for iter_260_7, iter_260_8 in pairs(arg_257_1.var_.actorSpriteComps1012:ToTable()) do
					if iter_260_8 then
						if arg_257_1.isInRecall_ then
							iter_260_8.color = arg_257_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_260_8.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_257_1.var_.actorSpriteComps1012 = nil
			end

			local var_260_23 = 0
			local var_260_24 = 0.1

			if var_260_23 < arg_257_1.time_ and arg_257_1.time_ <= var_260_23 + arg_260_0 then
				arg_257_1.talkMaxDuration = 0
				arg_257_1.dialogCg_.alpha = 1

				arg_257_1.dialog_:SetActive(true)
				SetActive(arg_257_1.leftNameGo_, true)

				local var_260_25 = arg_257_1:FormatText(StoryNameCfg[605].name)

				arg_257_1.leftNameTxt_.text = var_260_25

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_257_1.leftNameTxt_.transform)

				arg_257_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_257_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_257_1:RecordName(arg_257_1.leftNameTxt_.text)
				SetActive(arg_257_1.iconTrs_.gameObject, false)
				arg_257_1.callingController_:SetSelectedState("normal")

				local var_260_26 = arg_257_1:GetWordFromCfg(410082063)
				local var_260_27 = arg_257_1:FormatText(var_260_26.content)

				arg_257_1.text_.text = var_260_27

				LuaForUtil.ClearLinePrefixSymbol(arg_257_1.text_)

				local var_260_28 = 4
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

				if manager.audio:GetVoiceLength("story_v_out_410082", "410082063", "story_v_out_410082.awb") ~= 0 then
					local var_260_31 = manager.audio:GetVoiceLength("story_v_out_410082", "410082063", "story_v_out_410082.awb") / 1000

					if var_260_31 + var_260_23 > arg_257_1.duration_ then
						arg_257_1.duration_ = var_260_31 + var_260_23
					end

					if var_260_26.prefab_name ~= "" and arg_257_1.actors_[var_260_26.prefab_name] ~= nil then
						local var_260_32 = LuaForUtil.PlayVoiceWithCriLipsync(arg_257_1.actors_[var_260_26.prefab_name].transform, "story_v_out_410082", "410082063", "story_v_out_410082.awb")

						arg_257_1:RecordAudio("410082063", var_260_32)
						arg_257_1:RecordAudio("410082063", var_260_32)
					else
						arg_257_1:AudioAction("play", "voice", "story_v_out_410082", "410082063", "story_v_out_410082.awb")
					end

					arg_257_1:RecordHistoryTalkVoice("story_v_out_410082", "410082063", "story_v_out_410082.awb")
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
				actorName = "1056",
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
	Play410082064 = function(arg_261_0, arg_261_1)
		arg_261_1.time_ = 0
		arg_261_1.frameCnt_ = 0
		arg_261_1.state_ = "playing"
		arg_261_1.curTalkId_ = 410082064
		arg_261_1.duration_ = 7.27

		local var_261_0 = {
			zh = 4.166,
			ja = 7.266
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
				arg_261_0:Play410082065(arg_261_1)
			end
		end

		function arg_261_1.onSingleLineUpdate_(arg_264_0)
			local var_264_0 = arg_261_1.actors_["1012"].transform
			local var_264_1 = 0

			if var_264_1 < arg_261_1.time_ and arg_261_1.time_ <= var_264_1 + arg_264_0 then
				arg_261_1.var_.moveOldPos1012 = var_264_0.localPosition
				var_264_0.localScale = Vector3.New(1, 1, 1)

				arg_261_1:CheckSpriteTmpPos("1012", 4)

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
				local var_264_6 = Vector3.New(390, -465, 300)

				var_264_0.localPosition = Vector3.Lerp(arg_261_1.var_.moveOldPos1012, var_264_6, var_264_5)
			end

			if arg_261_1.time_ >= var_264_1 + var_264_4 and arg_261_1.time_ < var_264_1 + var_264_4 + arg_264_0 then
				var_264_0.localPosition = Vector3.New(390, -465, 300)
			end

			local var_264_7 = arg_261_1.actors_["1012"]
			local var_264_8 = 0

			if var_264_8 < arg_261_1.time_ and arg_261_1.time_ <= var_264_8 + arg_264_0 and not isNil(var_264_7) and arg_261_1.var_.actorSpriteComps1012 == nil then
				arg_261_1.var_.actorSpriteComps1012 = var_264_7:GetComponentsInChildren(typeof(Image), true)
			end

			local var_264_9 = 0.034

			if var_264_8 <= arg_261_1.time_ and arg_261_1.time_ < var_264_8 + var_264_9 and not isNil(var_264_7) then
				local var_264_10 = (arg_261_1.time_ - var_264_8) / var_264_9

				if arg_261_1.var_.actorSpriteComps1012 then
					for iter_264_1, iter_264_2 in pairs(arg_261_1.var_.actorSpriteComps1012:ToTable()) do
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

			if arg_261_1.time_ >= var_264_8 + var_264_9 and arg_261_1.time_ < var_264_8 + var_264_9 + arg_264_0 and not isNil(var_264_7) and arg_261_1.var_.actorSpriteComps1012 then
				for iter_264_3, iter_264_4 in pairs(arg_261_1.var_.actorSpriteComps1012:ToTable()) do
					if iter_264_4 then
						if arg_261_1.isInRecall_ then
							iter_264_4.color = arg_261_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_264_4.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_261_1.var_.actorSpriteComps1012 = nil
			end

			local var_264_15 = arg_261_1.actors_["1056"]
			local var_264_16 = 0

			if var_264_16 < arg_261_1.time_ and arg_261_1.time_ <= var_264_16 + arg_264_0 and not isNil(var_264_15) and arg_261_1.var_.actorSpriteComps1056 == nil then
				arg_261_1.var_.actorSpriteComps1056 = var_264_15:GetComponentsInChildren(typeof(Image), true)
			end

			local var_264_17 = 0.034

			if var_264_16 <= arg_261_1.time_ and arg_261_1.time_ < var_264_16 + var_264_17 and not isNil(var_264_15) then
				local var_264_18 = (arg_261_1.time_ - var_264_16) / var_264_17

				if arg_261_1.var_.actorSpriteComps1056 then
					for iter_264_5, iter_264_6 in pairs(arg_261_1.var_.actorSpriteComps1056:ToTable()) do
						if iter_264_6 then
							if arg_261_1.isInRecall_ then
								local var_264_19 = Mathf.Lerp(iter_264_6.color.r, arg_261_1.hightColor2.r, var_264_18)
								local var_264_20 = Mathf.Lerp(iter_264_6.color.g, arg_261_1.hightColor2.g, var_264_18)
								local var_264_21 = Mathf.Lerp(iter_264_6.color.b, arg_261_1.hightColor2.b, var_264_18)

								iter_264_6.color = Color.New(var_264_19, var_264_20, var_264_21)
							else
								local var_264_22 = Mathf.Lerp(iter_264_6.color.r, 0.5, var_264_18)

								iter_264_6.color = Color.New(var_264_22, var_264_22, var_264_22)
							end
						end
					end
				end
			end

			if arg_261_1.time_ >= var_264_16 + var_264_17 and arg_261_1.time_ < var_264_16 + var_264_17 + arg_264_0 and not isNil(var_264_15) and arg_261_1.var_.actorSpriteComps1056 then
				for iter_264_7, iter_264_8 in pairs(arg_261_1.var_.actorSpriteComps1056:ToTable()) do
					if iter_264_8 then
						if arg_261_1.isInRecall_ then
							iter_264_8.color = arg_261_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_264_8.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_261_1.var_.actorSpriteComps1056 = nil
			end

			local var_264_23 = 0
			local var_264_24 = 0.525

			if var_264_23 < arg_261_1.time_ and arg_261_1.time_ <= var_264_23 + arg_264_0 then
				arg_261_1.talkMaxDuration = 0
				arg_261_1.dialogCg_.alpha = 1

				arg_261_1.dialog_:SetActive(true)
				SetActive(arg_261_1.leftNameGo_, true)

				local var_264_25 = arg_261_1:FormatText(StoryNameCfg[595].name)

				arg_261_1.leftNameTxt_.text = var_264_25

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_261_1.leftNameTxt_.transform)

				arg_261_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_261_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_261_1:RecordName(arg_261_1.leftNameTxt_.text)
				SetActive(arg_261_1.iconTrs_.gameObject, false)
				arg_261_1.callingController_:SetSelectedState("normal")

				local var_264_26 = arg_261_1:GetWordFromCfg(410082064)
				local var_264_27 = arg_261_1:FormatText(var_264_26.content)

				arg_261_1.text_.text = var_264_27

				LuaForUtil.ClearLinePrefixSymbol(arg_261_1.text_)

				local var_264_28 = 21
				local var_264_29 = utf8.len(var_264_27)
				local var_264_30 = var_264_28 <= 0 and var_264_24 or var_264_24 * (var_264_29 / var_264_28)

				if var_264_30 > 0 and var_264_24 < var_264_30 then
					arg_261_1.talkMaxDuration = var_264_30

					if var_264_30 + var_264_23 > arg_261_1.duration_ then
						arg_261_1.duration_ = var_264_30 + var_264_23
					end
				end

				arg_261_1.text_.text = var_264_27
				arg_261_1.typewritter.percent = 0

				arg_261_1.typewritter:SetDirty()
				arg_261_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_410082", "410082064", "story_v_out_410082.awb") ~= 0 then
					local var_264_31 = manager.audio:GetVoiceLength("story_v_out_410082", "410082064", "story_v_out_410082.awb") / 1000

					if var_264_31 + var_264_23 > arg_261_1.duration_ then
						arg_261_1.duration_ = var_264_31 + var_264_23
					end

					if var_264_26.prefab_name ~= "" and arg_261_1.actors_[var_264_26.prefab_name] ~= nil then
						local var_264_32 = LuaForUtil.PlayVoiceWithCriLipsync(arg_261_1.actors_[var_264_26.prefab_name].transform, "story_v_out_410082", "410082064", "story_v_out_410082.awb")

						arg_261_1:RecordAudio("410082064", var_264_32)
						arg_261_1:RecordAudio("410082064", var_264_32)
					else
						arg_261_1:AudioAction("play", "voice", "story_v_out_410082", "410082064", "story_v_out_410082.awb")
					end

					arg_261_1:RecordHistoryTalkVoice("story_v_out_410082", "410082064", "story_v_out_410082.awb")
				end

				arg_261_1:RecordContent(arg_261_1.text_.text)
			end

			local var_264_33 = math.max(var_264_24, arg_261_1.talkMaxDuration)

			if var_264_23 <= arg_261_1.time_ and arg_261_1.time_ < var_264_23 + var_264_33 then
				arg_261_1.typewritter.percent = (arg_261_1.time_ - var_264_23) / var_264_33

				arg_261_1.typewritter:SetDirty()
			end

			if arg_261_1.time_ >= var_264_23 + var_264_33 and arg_261_1.time_ < var_264_23 + var_264_33 + arg_264_0 then
				arg_261_1.typewritter.percent = 1

				arg_261_1.typewritter:SetDirty()
				arg_261_1:ShowNextGo(true)
			end
		end

		arg_261_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1012",
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
	Play410082065 = function(arg_265_0, arg_265_1)
		arg_265_1.time_ = 0
		arg_265_1.frameCnt_ = 0
		arg_265_1.state_ = "playing"
		arg_265_1.curTalkId_ = 410082065
		arg_265_1.duration_ = 7.03

		local var_265_0 = {
			zh = 2.4,
			ja = 7.033
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
				arg_265_0:Play410082066(arg_265_1)
			end
		end

		function arg_265_1.onSingleLineUpdate_(arg_268_0)
			local var_268_0 = arg_265_1.actors_["1056"].transform
			local var_268_1 = 0

			if var_268_1 < arg_265_1.time_ and arg_265_1.time_ <= var_268_1 + arg_268_0 then
				arg_265_1.var_.moveOldPos1056 = var_268_0.localPosition
				var_268_0.localScale = Vector3.New(1, 1, 1)

				arg_265_1:CheckSpriteTmpPos("1056", 3)

				local var_268_2 = var_268_0.childCount

				for iter_268_0 = 0, var_268_2 - 1 do
					local var_268_3 = var_268_0:GetChild(iter_268_0)

					if var_268_3.name == "split_2" or not string.find(var_268_3.name, "split") then
						var_268_3.gameObject:SetActive(true)
					else
						var_268_3.gameObject:SetActive(false)
					end
				end
			end

			local var_268_4 = 0.001

			if var_268_1 <= arg_265_1.time_ and arg_265_1.time_ < var_268_1 + var_268_4 then
				local var_268_5 = (arg_265_1.time_ - var_268_1) / var_268_4
				local var_268_6 = Vector3.New(0, -350, -180)

				var_268_0.localPosition = Vector3.Lerp(arg_265_1.var_.moveOldPos1056, var_268_6, var_268_5)
			end

			if arg_265_1.time_ >= var_268_1 + var_268_4 and arg_265_1.time_ < var_268_1 + var_268_4 + arg_268_0 then
				var_268_0.localPosition = Vector3.New(0, -350, -180)
			end

			local var_268_7 = arg_265_1.actors_["1056"]
			local var_268_8 = 0

			if var_268_8 < arg_265_1.time_ and arg_265_1.time_ <= var_268_8 + arg_268_0 and not isNil(var_268_7) and arg_265_1.var_.actorSpriteComps1056 == nil then
				arg_265_1.var_.actorSpriteComps1056 = var_268_7:GetComponentsInChildren(typeof(Image), true)
			end

			local var_268_9 = 0.034

			if var_268_8 <= arg_265_1.time_ and arg_265_1.time_ < var_268_8 + var_268_9 and not isNil(var_268_7) then
				local var_268_10 = (arg_265_1.time_ - var_268_8) / var_268_9

				if arg_265_1.var_.actorSpriteComps1056 then
					for iter_268_1, iter_268_2 in pairs(arg_265_1.var_.actorSpriteComps1056:ToTable()) do
						if iter_268_2 then
							if arg_265_1.isInRecall_ then
								local var_268_11 = Mathf.Lerp(iter_268_2.color.r, arg_265_1.hightColor1.r, var_268_10)
								local var_268_12 = Mathf.Lerp(iter_268_2.color.g, arg_265_1.hightColor1.g, var_268_10)
								local var_268_13 = Mathf.Lerp(iter_268_2.color.b, arg_265_1.hightColor1.b, var_268_10)

								iter_268_2.color = Color.New(var_268_11, var_268_12, var_268_13)
							else
								local var_268_14 = Mathf.Lerp(iter_268_2.color.r, 1, var_268_10)

								iter_268_2.color = Color.New(var_268_14, var_268_14, var_268_14)
							end
						end
					end
				end
			end

			if arg_265_1.time_ >= var_268_8 + var_268_9 and arg_265_1.time_ < var_268_8 + var_268_9 + arg_268_0 and not isNil(var_268_7) and arg_265_1.var_.actorSpriteComps1056 then
				for iter_268_3, iter_268_4 in pairs(arg_265_1.var_.actorSpriteComps1056:ToTable()) do
					if iter_268_4 then
						if arg_265_1.isInRecall_ then
							iter_268_4.color = arg_265_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_268_4.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_265_1.var_.actorSpriteComps1056 = nil
			end

			local var_268_15 = arg_265_1.actors_["1012"]
			local var_268_16 = 0

			if var_268_16 < arg_265_1.time_ and arg_265_1.time_ <= var_268_16 + arg_268_0 and not isNil(var_268_15) and arg_265_1.var_.actorSpriteComps1012 == nil then
				arg_265_1.var_.actorSpriteComps1012 = var_268_15:GetComponentsInChildren(typeof(Image), true)
			end

			local var_268_17 = 0.034

			if var_268_16 <= arg_265_1.time_ and arg_265_1.time_ < var_268_16 + var_268_17 and not isNil(var_268_15) then
				local var_268_18 = (arg_265_1.time_ - var_268_16) / var_268_17

				if arg_265_1.var_.actorSpriteComps1012 then
					for iter_268_5, iter_268_6 in pairs(arg_265_1.var_.actorSpriteComps1012:ToTable()) do
						if iter_268_6 then
							if arg_265_1.isInRecall_ then
								local var_268_19 = Mathf.Lerp(iter_268_6.color.r, arg_265_1.hightColor2.r, var_268_18)
								local var_268_20 = Mathf.Lerp(iter_268_6.color.g, arg_265_1.hightColor2.g, var_268_18)
								local var_268_21 = Mathf.Lerp(iter_268_6.color.b, arg_265_1.hightColor2.b, var_268_18)

								iter_268_6.color = Color.New(var_268_19, var_268_20, var_268_21)
							else
								local var_268_22 = Mathf.Lerp(iter_268_6.color.r, 0.5, var_268_18)

								iter_268_6.color = Color.New(var_268_22, var_268_22, var_268_22)
							end
						end
					end
				end
			end

			if arg_265_1.time_ >= var_268_16 + var_268_17 and arg_265_1.time_ < var_268_16 + var_268_17 + arg_268_0 and not isNil(var_268_15) and arg_265_1.var_.actorSpriteComps1012 then
				for iter_268_7, iter_268_8 in pairs(arg_265_1.var_.actorSpriteComps1012:ToTable()) do
					if iter_268_8 then
						if arg_265_1.isInRecall_ then
							iter_268_8.color = arg_265_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_268_8.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_265_1.var_.actorSpriteComps1012 = nil
			end

			local var_268_23 = 0
			local var_268_24 = 0.325

			if var_268_23 < arg_265_1.time_ and arg_265_1.time_ <= var_268_23 + arg_268_0 then
				arg_265_1.talkMaxDuration = 0
				arg_265_1.dialogCg_.alpha = 1

				arg_265_1.dialog_:SetActive(true)
				SetActive(arg_265_1.leftNameGo_, true)

				local var_268_25 = arg_265_1:FormatText(StoryNameCfg[605].name)

				arg_265_1.leftNameTxt_.text = var_268_25

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_265_1.leftNameTxt_.transform)

				arg_265_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_265_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_265_1:RecordName(arg_265_1.leftNameTxt_.text)
				SetActive(arg_265_1.iconTrs_.gameObject, false)
				arg_265_1.callingController_:SetSelectedState("normal")

				local var_268_26 = arg_265_1:GetWordFromCfg(410082065)
				local var_268_27 = arg_265_1:FormatText(var_268_26.content)

				arg_265_1.text_.text = var_268_27

				LuaForUtil.ClearLinePrefixSymbol(arg_265_1.text_)

				local var_268_28 = 13
				local var_268_29 = utf8.len(var_268_27)
				local var_268_30 = var_268_28 <= 0 and var_268_24 or var_268_24 * (var_268_29 / var_268_28)

				if var_268_30 > 0 and var_268_24 < var_268_30 then
					arg_265_1.talkMaxDuration = var_268_30

					if var_268_30 + var_268_23 > arg_265_1.duration_ then
						arg_265_1.duration_ = var_268_30 + var_268_23
					end
				end

				arg_265_1.text_.text = var_268_27
				arg_265_1.typewritter.percent = 0

				arg_265_1.typewritter:SetDirty()
				arg_265_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_410082", "410082065", "story_v_out_410082.awb") ~= 0 then
					local var_268_31 = manager.audio:GetVoiceLength("story_v_out_410082", "410082065", "story_v_out_410082.awb") / 1000

					if var_268_31 + var_268_23 > arg_265_1.duration_ then
						arg_265_1.duration_ = var_268_31 + var_268_23
					end

					if var_268_26.prefab_name ~= "" and arg_265_1.actors_[var_268_26.prefab_name] ~= nil then
						local var_268_32 = LuaForUtil.PlayVoiceWithCriLipsync(arg_265_1.actors_[var_268_26.prefab_name].transform, "story_v_out_410082", "410082065", "story_v_out_410082.awb")

						arg_265_1:RecordAudio("410082065", var_268_32)
						arg_265_1:RecordAudio("410082065", var_268_32)
					else
						arg_265_1:AudioAction("play", "voice", "story_v_out_410082", "410082065", "story_v_out_410082.awb")
					end

					arg_265_1:RecordHistoryTalkVoice("story_v_out_410082", "410082065", "story_v_out_410082.awb")
				end

				arg_265_1:RecordContent(arg_265_1.text_.text)
			end

			local var_268_33 = math.max(var_268_24, arg_265_1.talkMaxDuration)

			if var_268_23 <= arg_265_1.time_ and arg_265_1.time_ < var_268_23 + var_268_33 then
				arg_265_1.typewritter.percent = (arg_265_1.time_ - var_268_23) / var_268_33

				arg_265_1.typewritter:SetDirty()
			end

			if arg_265_1.time_ >= var_268_23 + var_268_33 and arg_265_1.time_ < var_268_23 + var_268_33 + arg_268_0 then
				arg_265_1.typewritter.percent = 1

				arg_265_1.typewritter:SetDirty()
				arg_265_1:ShowNextGo(true)
			end
		end

		arg_265_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1056",
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
	Play410082066 = function(arg_269_0, arg_269_1)
		arg_269_1.time_ = 0
		arg_269_1.frameCnt_ = 0
		arg_269_1.state_ = "playing"
		arg_269_1.curTalkId_ = 410082066
		arg_269_1.duration_ = 9.5

		local var_269_0 = {
			zh = 5.933,
			ja = 9.5
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
				arg_269_0:Play410082067(arg_269_1)
			end
		end

		function arg_269_1.onSingleLineUpdate_(arg_272_0)
			local var_272_0 = arg_269_1.actors_["1060"].transform
			local var_272_1 = 0

			if var_272_1 < arg_269_1.time_ and arg_269_1.time_ <= var_272_1 + arg_272_0 then
				arg_269_1.var_.moveOldPos1060 = var_272_0.localPosition
				var_272_0.localScale = Vector3.New(1, 1, 1)

				arg_269_1:CheckSpriteTmpPos("1060", 2)

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
				local var_272_6 = Vector3.New(-440.94, -430.8, 6.9)

				var_272_0.localPosition = Vector3.Lerp(arg_269_1.var_.moveOldPos1060, var_272_6, var_272_5)
			end

			if arg_269_1.time_ >= var_272_1 + var_272_4 and arg_269_1.time_ < var_272_1 + var_272_4 + arg_272_0 then
				var_272_0.localPosition = Vector3.New(-440.94, -430.8, 6.9)
			end

			local var_272_7 = arg_269_1.actors_["1060"]
			local var_272_8 = 0

			if var_272_8 < arg_269_1.time_ and arg_269_1.time_ <= var_272_8 + arg_272_0 and not isNil(var_272_7) and arg_269_1.var_.actorSpriteComps1060 == nil then
				arg_269_1.var_.actorSpriteComps1060 = var_272_7:GetComponentsInChildren(typeof(Image), true)
			end

			local var_272_9 = 0.034

			if var_272_8 <= arg_269_1.time_ and arg_269_1.time_ < var_272_8 + var_272_9 and not isNil(var_272_7) then
				local var_272_10 = (arg_269_1.time_ - var_272_8) / var_272_9

				if arg_269_1.var_.actorSpriteComps1060 then
					for iter_272_1, iter_272_2 in pairs(arg_269_1.var_.actorSpriteComps1060:ToTable()) do
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

			if arg_269_1.time_ >= var_272_8 + var_272_9 and arg_269_1.time_ < var_272_8 + var_272_9 + arg_272_0 and not isNil(var_272_7) and arg_269_1.var_.actorSpriteComps1060 then
				for iter_272_3, iter_272_4 in pairs(arg_269_1.var_.actorSpriteComps1060:ToTable()) do
					if iter_272_4 then
						if arg_269_1.isInRecall_ then
							iter_272_4.color = arg_269_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_272_4.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_269_1.var_.actorSpriteComps1060 = nil
			end

			local var_272_15 = arg_269_1.actors_["1056"]
			local var_272_16 = 0

			if var_272_16 < arg_269_1.time_ and arg_269_1.time_ <= var_272_16 + arg_272_0 and not isNil(var_272_15) and arg_269_1.var_.actorSpriteComps1056 == nil then
				arg_269_1.var_.actorSpriteComps1056 = var_272_15:GetComponentsInChildren(typeof(Image), true)
			end

			local var_272_17 = 0.034

			if var_272_16 <= arg_269_1.time_ and arg_269_1.time_ < var_272_16 + var_272_17 and not isNil(var_272_15) then
				local var_272_18 = (arg_269_1.time_ - var_272_16) / var_272_17

				if arg_269_1.var_.actorSpriteComps1056 then
					for iter_272_5, iter_272_6 in pairs(arg_269_1.var_.actorSpriteComps1056:ToTable()) do
						if iter_272_6 then
							if arg_269_1.isInRecall_ then
								local var_272_19 = Mathf.Lerp(iter_272_6.color.r, arg_269_1.hightColor2.r, var_272_18)
								local var_272_20 = Mathf.Lerp(iter_272_6.color.g, arg_269_1.hightColor2.g, var_272_18)
								local var_272_21 = Mathf.Lerp(iter_272_6.color.b, arg_269_1.hightColor2.b, var_272_18)

								iter_272_6.color = Color.New(var_272_19, var_272_20, var_272_21)
							else
								local var_272_22 = Mathf.Lerp(iter_272_6.color.r, 0.5, var_272_18)

								iter_272_6.color = Color.New(var_272_22, var_272_22, var_272_22)
							end
						end
					end
				end
			end

			if arg_269_1.time_ >= var_272_16 + var_272_17 and arg_269_1.time_ < var_272_16 + var_272_17 + arg_272_0 and not isNil(var_272_15) and arg_269_1.var_.actorSpriteComps1056 then
				for iter_272_7, iter_272_8 in pairs(arg_269_1.var_.actorSpriteComps1056:ToTable()) do
					if iter_272_8 then
						if arg_269_1.isInRecall_ then
							iter_272_8.color = arg_269_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_272_8.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_269_1.var_.actorSpriteComps1056 = nil
			end

			local var_272_23 = 0
			local var_272_24 = 0.675

			if var_272_23 < arg_269_1.time_ and arg_269_1.time_ <= var_272_23 + arg_272_0 then
				arg_269_1.talkMaxDuration = 0
				arg_269_1.dialogCg_.alpha = 1

				arg_269_1.dialog_:SetActive(true)
				SetActive(arg_269_1.leftNameGo_, true)

				local var_272_25 = arg_269_1:FormatText(StoryNameCfg[584].name)

				arg_269_1.leftNameTxt_.text = var_272_25

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_269_1.leftNameTxt_.transform)

				arg_269_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_269_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_269_1:RecordName(arg_269_1.leftNameTxt_.text)
				SetActive(arg_269_1.iconTrs_.gameObject, false)
				arg_269_1.callingController_:SetSelectedState("normal")

				local var_272_26 = arg_269_1:GetWordFromCfg(410082066)
				local var_272_27 = arg_269_1:FormatText(var_272_26.content)

				arg_269_1.text_.text = var_272_27

				LuaForUtil.ClearLinePrefixSymbol(arg_269_1.text_)

				local var_272_28 = 27
				local var_272_29 = utf8.len(var_272_27)
				local var_272_30 = var_272_28 <= 0 and var_272_24 or var_272_24 * (var_272_29 / var_272_28)

				if var_272_30 > 0 and var_272_24 < var_272_30 then
					arg_269_1.talkMaxDuration = var_272_30

					if var_272_30 + var_272_23 > arg_269_1.duration_ then
						arg_269_1.duration_ = var_272_30 + var_272_23
					end
				end

				arg_269_1.text_.text = var_272_27
				arg_269_1.typewritter.percent = 0

				arg_269_1.typewritter:SetDirty()
				arg_269_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_410082", "410082066", "story_v_out_410082.awb") ~= 0 then
					local var_272_31 = manager.audio:GetVoiceLength("story_v_out_410082", "410082066", "story_v_out_410082.awb") / 1000

					if var_272_31 + var_272_23 > arg_269_1.duration_ then
						arg_269_1.duration_ = var_272_31 + var_272_23
					end

					if var_272_26.prefab_name ~= "" and arg_269_1.actors_[var_272_26.prefab_name] ~= nil then
						local var_272_32 = LuaForUtil.PlayVoiceWithCriLipsync(arg_269_1.actors_[var_272_26.prefab_name].transform, "story_v_out_410082", "410082066", "story_v_out_410082.awb")

						arg_269_1:RecordAudio("410082066", var_272_32)
						arg_269_1:RecordAudio("410082066", var_272_32)
					else
						arg_269_1:AudioAction("play", "voice", "story_v_out_410082", "410082066", "story_v_out_410082.awb")
					end

					arg_269_1:RecordHistoryTalkVoice("story_v_out_410082", "410082066", "story_v_out_410082.awb")
				end

				arg_269_1:RecordContent(arg_269_1.text_.text)
			end

			local var_272_33 = math.max(var_272_24, arg_269_1.talkMaxDuration)

			if var_272_23 <= arg_269_1.time_ and arg_269_1.time_ < var_272_23 + var_272_33 then
				arg_269_1.typewritter.percent = (arg_269_1.time_ - var_272_23) / var_272_33

				arg_269_1.typewritter:SetDirty()
			end

			if arg_269_1.time_ >= var_272_23 + var_272_33 and arg_269_1.time_ < var_272_23 + var_272_33 + arg_272_0 then
				arg_269_1.typewritter.percent = 1

				arg_269_1.typewritter:SetDirty()
				arg_269_1:ShowNextGo(true)
			end
		end

		arg_269_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1060",
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
	Play410082067 = function(arg_273_0, arg_273_1)
		arg_273_1.time_ = 0
		arg_273_1.frameCnt_ = 0
		arg_273_1.state_ = "playing"
		arg_273_1.curTalkId_ = 410082067
		arg_273_1.duration_ = 9

		SetActive(arg_273_1.tipsGo_, false)

		function arg_273_1.onSingleLineFinish_()
			arg_273_1.onSingleLineUpdate_ = nil
			arg_273_1.onSingleLineFinish_ = nil
			arg_273_1.state_ = "waiting"
		end

		function arg_273_1.playNext_(arg_275_0)
			if arg_275_0 == 1 then
				arg_273_0:Play410082068(arg_273_1)
			end
		end

		function arg_273_1.onSingleLineUpdate_(arg_276_0)
			local var_276_0 = "ST61"

			if arg_273_1.bgs_[var_276_0] == nil then
				local var_276_1 = Object.Instantiate(arg_273_1.paintGo_)

				var_276_1:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. var_276_0)
				var_276_1.name = var_276_0
				var_276_1.transform.parent = arg_273_1.stage_.transform
				var_276_1.transform.localPosition = Vector3.New(0, 100, 0)
				arg_273_1.bgs_[var_276_0] = var_276_1
			end

			local var_276_2 = 2

			if var_276_2 < arg_273_1.time_ and arg_273_1.time_ <= var_276_2 + arg_276_0 then
				local var_276_3 = manager.ui.mainCamera.transform.localPosition
				local var_276_4 = Vector3.New(0, 0, 10) + Vector3.New(var_276_3.x, var_276_3.y, 0)
				local var_276_5 = arg_273_1.bgs_.ST61

				var_276_5.transform.localPosition = var_276_4
				var_276_5.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_276_6 = var_276_5:GetComponent("SpriteRenderer")

				if var_276_6 and var_276_6.sprite then
					local var_276_7 = (var_276_5.transform.localPosition - var_276_3).z
					local var_276_8 = manager.ui.mainCameraCom_
					local var_276_9 = 2 * var_276_7 * Mathf.Tan(var_276_8.fieldOfView * 0.5 * Mathf.Deg2Rad)
					local var_276_10 = var_276_9 * var_276_8.aspect
					local var_276_11 = var_276_6.sprite.bounds.size.x
					local var_276_12 = var_276_6.sprite.bounds.size.y
					local var_276_13 = var_276_10 / var_276_11
					local var_276_14 = var_276_9 / var_276_12
					local var_276_15 = var_276_14 < var_276_13 and var_276_13 or var_276_14

					var_276_5.transform.localScale = Vector3.New(var_276_15, var_276_15, 0)
				end

				for iter_276_0, iter_276_1 in pairs(arg_273_1.bgs_) do
					if iter_276_0 ~= "ST61" then
						iter_276_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_276_16 = 0

			if var_276_16 < arg_273_1.time_ and arg_273_1.time_ <= var_276_16 + arg_276_0 then
				arg_273_1.mask_.enabled = true
				arg_273_1.mask_.raycastTarget = true

				arg_273_1:SetGaussion(false)
			end

			local var_276_17 = 2

			if var_276_16 <= arg_273_1.time_ and arg_273_1.time_ < var_276_16 + var_276_17 then
				local var_276_18 = (arg_273_1.time_ - var_276_16) / var_276_17
				local var_276_19 = Color.New(0, 0, 0)

				var_276_19.a = Mathf.Lerp(0, 1, var_276_18)
				arg_273_1.mask_.color = var_276_19
			end

			if arg_273_1.time_ >= var_276_16 + var_276_17 and arg_273_1.time_ < var_276_16 + var_276_17 + arg_276_0 then
				local var_276_20 = Color.New(0, 0, 0)

				var_276_20.a = 1
				arg_273_1.mask_.color = var_276_20
			end

			local var_276_21 = 2

			if var_276_21 < arg_273_1.time_ and arg_273_1.time_ <= var_276_21 + arg_276_0 then
				arg_273_1.mask_.enabled = true
				arg_273_1.mask_.raycastTarget = true

				arg_273_1:SetGaussion(false)
			end

			local var_276_22 = 2

			if var_276_21 <= arg_273_1.time_ and arg_273_1.time_ < var_276_21 + var_276_22 then
				local var_276_23 = (arg_273_1.time_ - var_276_21) / var_276_22
				local var_276_24 = Color.New(0, 0, 0)

				var_276_24.a = Mathf.Lerp(1, 0, var_276_23)
				arg_273_1.mask_.color = var_276_24
			end

			if arg_273_1.time_ >= var_276_21 + var_276_22 and arg_273_1.time_ < var_276_21 + var_276_22 + arg_276_0 then
				local var_276_25 = Color.New(0, 0, 0)
				local var_276_26 = 0

				arg_273_1.mask_.enabled = false
				var_276_25.a = var_276_26
				arg_273_1.mask_.color = var_276_25
			end

			local var_276_27 = arg_273_1.actors_["1060"].transform
			local var_276_28 = 2

			if var_276_28 < arg_273_1.time_ and arg_273_1.time_ <= var_276_28 + arg_276_0 then
				arg_273_1.var_.moveOldPos1060 = var_276_27.localPosition
				var_276_27.localScale = Vector3.New(1, 1, 1)

				arg_273_1:CheckSpriteTmpPos("1060", 7)

				local var_276_29 = var_276_27.childCount

				for iter_276_2 = 0, var_276_29 - 1 do
					local var_276_30 = var_276_27:GetChild(iter_276_2)

					if var_276_30.name == "" or not string.find(var_276_30.name, "split") then
						var_276_30.gameObject:SetActive(true)
					else
						var_276_30.gameObject:SetActive(false)
					end
				end
			end

			local var_276_31 = 0.001

			if var_276_28 <= arg_273_1.time_ and arg_273_1.time_ < var_276_28 + var_276_31 then
				local var_276_32 = (arg_273_1.time_ - var_276_28) / var_276_31
				local var_276_33 = Vector3.New(0, -2000, -40)

				var_276_27.localPosition = Vector3.Lerp(arg_273_1.var_.moveOldPos1060, var_276_33, var_276_32)
			end

			if arg_273_1.time_ >= var_276_28 + var_276_31 and arg_273_1.time_ < var_276_28 + var_276_31 + arg_276_0 then
				var_276_27.localPosition = Vector3.New(0, -2000, -40)
			end

			local var_276_34 = arg_273_1.actors_["1056"].transform
			local var_276_35 = 2

			if var_276_35 < arg_273_1.time_ and arg_273_1.time_ <= var_276_35 + arg_276_0 then
				arg_273_1.var_.moveOldPos1056 = var_276_34.localPosition
				var_276_34.localScale = Vector3.New(1, 1, 1)

				arg_273_1:CheckSpriteTmpPos("1056", 7)

				local var_276_36 = var_276_34.childCount

				for iter_276_3 = 0, var_276_36 - 1 do
					local var_276_37 = var_276_34:GetChild(iter_276_3)

					if var_276_37.name == "" or not string.find(var_276_37.name, "split") then
						var_276_37.gameObject:SetActive(true)
					else
						var_276_37.gameObject:SetActive(false)
					end
				end
			end

			local var_276_38 = 0.001

			if var_276_35 <= arg_273_1.time_ and arg_273_1.time_ < var_276_35 + var_276_38 then
				local var_276_39 = (arg_273_1.time_ - var_276_35) / var_276_38
				local var_276_40 = Vector3.New(0, -2000, -180)

				var_276_34.localPosition = Vector3.Lerp(arg_273_1.var_.moveOldPos1056, var_276_40, var_276_39)
			end

			if arg_273_1.time_ >= var_276_35 + var_276_38 and arg_273_1.time_ < var_276_35 + var_276_38 + arg_276_0 then
				var_276_34.localPosition = Vector3.New(0, -2000, -180)
			end

			local var_276_41 = arg_273_1.actors_["1012"].transform
			local var_276_42 = 2

			if var_276_42 < arg_273_1.time_ and arg_273_1.time_ <= var_276_42 + arg_276_0 then
				arg_273_1.var_.moveOldPos1012 = var_276_41.localPosition
				var_276_41.localScale = Vector3.New(1, 1, 1)

				arg_273_1:CheckSpriteTmpPos("1012", 7)

				local var_276_43 = var_276_41.childCount

				for iter_276_4 = 0, var_276_43 - 1 do
					local var_276_44 = var_276_41:GetChild(iter_276_4)

					if var_276_44.name == "" or not string.find(var_276_44.name, "split") then
						var_276_44.gameObject:SetActive(true)
					else
						var_276_44.gameObject:SetActive(false)
					end
				end
			end

			local var_276_45 = 0.001

			if var_276_42 <= arg_273_1.time_ and arg_273_1.time_ < var_276_42 + var_276_45 then
				local var_276_46 = (arg_273_1.time_ - var_276_42) / var_276_45
				local var_276_47 = Vector3.New(0, -2000, 300)

				var_276_41.localPosition = Vector3.Lerp(arg_273_1.var_.moveOldPos1012, var_276_47, var_276_46)
			end

			if arg_273_1.time_ >= var_276_42 + var_276_45 and arg_273_1.time_ < var_276_42 + var_276_45 + arg_276_0 then
				var_276_41.localPosition = Vector3.New(0, -2000, 300)
			end

			local var_276_48 = 0
			local var_276_49 = 0.133333333333333

			if var_276_48 < arg_273_1.time_ and arg_273_1.time_ <= var_276_48 + arg_276_0 then
				local var_276_50 = "play"
				local var_276_51 = "music"

				arg_273_1:AudioAction(var_276_50, var_276_51, "ui_battle", "ui_battle_stopbgm", "")

				local var_276_52 = ""
				local var_276_53 = manager.audio:GetAudioName("ui_battle", "ui_battle_stopbgm")

				if var_276_53 ~= "" then
					if arg_273_1.bgmTxt_.text ~= var_276_53 and arg_273_1.bgmTxt_.text ~= "" then
						if arg_273_1.bgmTxt2_.text ~= "" then
							arg_273_1.bgmTxt_.text = arg_273_1.bgmTxt2_.text
						end

						arg_273_1.bgmTxt2_.text = var_276_53

						arg_273_1.musicChangeAnimator_:Play("music_change", 0, 0)
					else
						arg_273_1.bgmTxt_.text = var_276_53
						arg_273_1.bgmTxt2_.text = var_276_53
					end

					if arg_273_1.bgmTimer then
						arg_273_1.bgmTimer:Stop()

						arg_273_1.bgmTimer = nil
					end

					if arg_273_1.settingData.show_music_name == 1 then
						arg_273_1.musicController:SetSelectedState("show")
						arg_273_1.musicAnimator_:Play("open", 0, 0)

						if arg_273_1.settingData.music_time ~= 0 then
							arg_273_1.bgmTimer = TimeTools.StartAfterSeconds(tonumber(arg_273_1.settingData.music_time), function()
								if arg_273_1 == nil or isNil(arg_273_1.bgmTxt_) then
									return
								end

								arg_273_1.musicController:SetSelectedState("hide")
								arg_273_1.musicAnimator_:Play("back", 0, 0)
							end, {})
						end
					end
				end
			end

			local var_276_54 = 0.266666666666667
			local var_276_55 = 1

			if var_276_54 < arg_273_1.time_ and arg_273_1.time_ <= var_276_54 + arg_276_0 then
				local var_276_56 = "play"
				local var_276_57 = "music"

				arg_273_1:AudioAction(var_276_56, var_276_57, "bgm_activity_2_8_story_meruism", "bgm_activity_2_8_story_meruism", "bgm_activity_2_8_story_meruism.awb")

				local var_276_58 = ""
				local var_276_59 = manager.audio:GetAudioName("bgm_activity_2_8_story_meruism", "bgm_activity_2_8_story_meruism")

				if var_276_59 ~= "" then
					if arg_273_1.bgmTxt_.text ~= var_276_59 and arg_273_1.bgmTxt_.text ~= "" then
						if arg_273_1.bgmTxt2_.text ~= "" then
							arg_273_1.bgmTxt_.text = arg_273_1.bgmTxt2_.text
						end

						arg_273_1.bgmTxt2_.text = var_276_59

						arg_273_1.musicChangeAnimator_:Play("music_change", 0, 0)
					else
						arg_273_1.bgmTxt_.text = var_276_59
						arg_273_1.bgmTxt2_.text = var_276_59
					end

					if arg_273_1.bgmTimer then
						arg_273_1.bgmTimer:Stop()

						arg_273_1.bgmTimer = nil
					end

					if arg_273_1.settingData.show_music_name == 1 then
						arg_273_1.musicController:SetSelectedState("show")
						arg_273_1.musicAnimator_:Play("open", 0, 0)

						if arg_273_1.settingData.music_time ~= 0 then
							arg_273_1.bgmTimer = TimeTools.StartAfterSeconds(tonumber(arg_273_1.settingData.music_time), function()
								if arg_273_1 == nil or isNil(arg_273_1.bgmTxt_) then
									return
								end

								arg_273_1.musicController:SetSelectedState("hide")
								arg_273_1.musicAnimator_:Play("back", 0, 0)
							end, {})
						end
					end
				end
			end

			if arg_273_1.frameCnt_ <= 1 then
				arg_273_1.dialog_:SetActive(false)
			end

			local var_276_60 = 4
			local var_276_61 = 1.475

			if var_276_60 < arg_273_1.time_ and arg_273_1.time_ <= var_276_60 + arg_276_0 then
				arg_273_1.talkMaxDuration = 0

				arg_273_1.dialog_:SetActive(true)

				arg_273_1.dialogCg_.alpha = 0

				local var_276_62 = LeanTween.value(arg_273_1.dialog_, 0, 1, 0.3)

				var_276_62:setOnUpdate(LuaHelper.FloatAction(function(arg_279_0)
					arg_273_1.dialogCg_.alpha = arg_279_0
				end))
				var_276_62:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_273_1.dialog_)
					var_276_62:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_273_1.duration_ = arg_273_1.duration_ + 0.3

				SetActive(arg_273_1.leftNameGo_, false)

				arg_273_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_273_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_273_1:RecordName(arg_273_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_273_1.iconTrs_.gameObject, false)
				arg_273_1.callingController_:SetSelectedState("normal")

				local var_276_63 = arg_273_1:GetWordFromCfg(410082067)
				local var_276_64 = arg_273_1:FormatText(var_276_63.content)

				arg_273_1.text_.text = var_276_64

				LuaForUtil.ClearLinePrefixSymbol(arg_273_1.text_)

				local var_276_65 = 59
				local var_276_66 = utf8.len(var_276_64)
				local var_276_67 = var_276_65 <= 0 and var_276_61 or var_276_61 * (var_276_66 / var_276_65)

				if var_276_67 > 0 and var_276_61 < var_276_67 then
					arg_273_1.talkMaxDuration = var_276_67
					var_276_60 = var_276_60 + 0.3

					if var_276_67 + var_276_60 > arg_273_1.duration_ then
						arg_273_1.duration_ = var_276_67 + var_276_60
					end
				end

				arg_273_1.text_.text = var_276_64
				arg_273_1.typewritter.percent = 0

				arg_273_1.typewritter:SetDirty()
				arg_273_1:ShowNextGo(false)
				arg_273_1:RecordContent(arg_273_1.text_.text)
			end

			local var_276_68 = var_276_60 + 0.3
			local var_276_69 = math.max(var_276_61, arg_273_1.talkMaxDuration)

			if var_276_68 <= arg_273_1.time_ and arg_273_1.time_ < var_276_68 + var_276_69 then
				arg_273_1.typewritter.percent = (arg_273_1.time_ - var_276_68) / var_276_69

				arg_273_1.typewritter:SetDirty()
			end

			if arg_273_1.time_ >= var_276_68 + var_276_69 and arg_273_1.time_ < var_276_68 + var_276_69 + arg_276_0 then
				arg_273_1.typewritter.percent = 1

				arg_273_1.typewritter:SetDirty()
				arg_273_1:ShowNextGo(true)
			end
		end

		arg_273_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1060",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 2,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			},
			{
				assetPath = "",
				actorName = "1056",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 2,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			},
			{
				assetPath = "",
				actorName = "1012",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 2,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_273_1:InitPlayNodeList()
	end,
	Play410082068 = function(arg_281_0, arg_281_1)
		arg_281_1.time_ = 0
		arg_281_1.frameCnt_ = 0
		arg_281_1.state_ = "playing"
		arg_281_1.curTalkId_ = 410082068
		arg_281_1.duration_ = 5

		SetActive(arg_281_1.tipsGo_, false)

		function arg_281_1.onSingleLineFinish_()
			arg_281_1.onSingleLineUpdate_ = nil
			arg_281_1.onSingleLineFinish_ = nil
			arg_281_1.state_ = "waiting"
		end

		function arg_281_1.playNext_(arg_283_0)
			if arg_283_0 == 1 then
				arg_281_0:Play410082069(arg_281_1)
			end
		end

		function arg_281_1.onSingleLineUpdate_(arg_284_0)
			local var_284_0 = 0
			local var_284_1 = 0.975

			if var_284_0 < arg_281_1.time_ and arg_281_1.time_ <= var_284_0 + arg_284_0 then
				arg_281_1.talkMaxDuration = 0
				arg_281_1.dialogCg_.alpha = 1

				arg_281_1.dialog_:SetActive(true)
				SetActive(arg_281_1.leftNameGo_, false)

				arg_281_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_281_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_281_1:RecordName(arg_281_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_281_1.iconTrs_.gameObject, false)
				arg_281_1.callingController_:SetSelectedState("normal")

				local var_284_2 = arg_281_1:GetWordFromCfg(410082068)
				local var_284_3 = arg_281_1:FormatText(var_284_2.content)

				arg_281_1.text_.text = var_284_3

				LuaForUtil.ClearLinePrefixSymbol(arg_281_1.text_)

				local var_284_4 = 39
				local var_284_5 = utf8.len(var_284_3)
				local var_284_6 = var_284_4 <= 0 and var_284_1 or var_284_1 * (var_284_5 / var_284_4)

				if var_284_6 > 0 and var_284_1 < var_284_6 then
					arg_281_1.talkMaxDuration = var_284_6

					if var_284_6 + var_284_0 > arg_281_1.duration_ then
						arg_281_1.duration_ = var_284_6 + var_284_0
					end
				end

				arg_281_1.text_.text = var_284_3
				arg_281_1.typewritter.percent = 0

				arg_281_1.typewritter:SetDirty()
				arg_281_1:ShowNextGo(false)
				arg_281_1:RecordContent(arg_281_1.text_.text)
			end

			local var_284_7 = math.max(var_284_1, arg_281_1.talkMaxDuration)

			if var_284_0 <= arg_281_1.time_ and arg_281_1.time_ < var_284_0 + var_284_7 then
				arg_281_1.typewritter.percent = (arg_281_1.time_ - var_284_0) / var_284_7

				arg_281_1.typewritter:SetDirty()
			end

			if arg_281_1.time_ >= var_284_0 + var_284_7 and arg_281_1.time_ < var_284_0 + var_284_7 + arg_284_0 then
				arg_281_1.typewritter.percent = 1

				arg_281_1.typewritter:SetDirty()
				arg_281_1:ShowNextGo(true)
			end
		end

		arg_281_1.nodeConfigList_ = {}

		arg_281_1:InitPlayNodeList()
	end,
	Play410082069 = function(arg_285_0, arg_285_1)
		arg_285_1.time_ = 0
		arg_285_1.frameCnt_ = 0
		arg_285_1.state_ = "playing"
		arg_285_1.curTalkId_ = 410082069
		arg_285_1.duration_ = 5.8

		local var_285_0 = {
			zh = 5.8,
			ja = 4.733
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
				arg_285_0:Play410082070(arg_285_1)
			end
		end

		function arg_285_1.onSingleLineUpdate_(arg_288_0)
			local var_288_0 = arg_285_1.actors_["1060"].transform
			local var_288_1 = 0

			if var_288_1 < arg_285_1.time_ and arg_285_1.time_ <= var_288_1 + arg_288_0 then
				arg_285_1.var_.moveOldPos1060 = var_288_0.localPosition
				var_288_0.localScale = Vector3.New(1, 1, 1)

				arg_285_1:CheckSpriteTmpPos("1060", 2)

				local var_288_2 = var_288_0.childCount

				for iter_288_0 = 0, var_288_2 - 1 do
					local var_288_3 = var_288_0:GetChild(iter_288_0)

					if var_288_3.name == "" or not string.find(var_288_3.name, "split") then
						var_288_3.gameObject:SetActive(true)
					else
						var_288_3.gameObject:SetActive(false)
					end
				end
			end

			local var_288_4 = 0.001

			if var_288_1 <= arg_285_1.time_ and arg_285_1.time_ < var_288_1 + var_288_4 then
				local var_288_5 = (arg_285_1.time_ - var_288_1) / var_288_4
				local var_288_6 = Vector3.New(-440.94, -430.8, 6.9)

				var_288_0.localPosition = Vector3.Lerp(arg_285_1.var_.moveOldPos1060, var_288_6, var_288_5)
			end

			if arg_285_1.time_ >= var_288_1 + var_288_4 and arg_285_1.time_ < var_288_1 + var_288_4 + arg_288_0 then
				var_288_0.localPosition = Vector3.New(-440.94, -430.8, 6.9)
			end

			local var_288_7 = arg_285_1.actors_["1012"].transform
			local var_288_8 = 0

			if var_288_8 < arg_285_1.time_ and arg_285_1.time_ <= var_288_8 + arg_288_0 then
				arg_285_1.var_.moveOldPos1012 = var_288_7.localPosition
				var_288_7.localScale = Vector3.New(1, 1, 1)

				arg_285_1:CheckSpriteTmpPos("1012", 4)

				local var_288_9 = var_288_7.childCount

				for iter_288_1 = 0, var_288_9 - 1 do
					local var_288_10 = var_288_7:GetChild(iter_288_1)

					if var_288_10.name == "" or not string.find(var_288_10.name, "split") then
						var_288_10.gameObject:SetActive(true)
					else
						var_288_10.gameObject:SetActive(false)
					end
				end
			end

			local var_288_11 = 0.001

			if var_288_8 <= arg_285_1.time_ and arg_285_1.time_ < var_288_8 + var_288_11 then
				local var_288_12 = (arg_285_1.time_ - var_288_8) / var_288_11
				local var_288_13 = Vector3.New(390, -465, 300)

				var_288_7.localPosition = Vector3.Lerp(arg_285_1.var_.moveOldPos1012, var_288_13, var_288_12)
			end

			if arg_285_1.time_ >= var_288_8 + var_288_11 and arg_285_1.time_ < var_288_8 + var_288_11 + arg_288_0 then
				var_288_7.localPosition = Vector3.New(390, -465, 300)
			end

			local var_288_14 = arg_285_1.actors_["1060"]
			local var_288_15 = 0

			if var_288_15 < arg_285_1.time_ and arg_285_1.time_ <= var_288_15 + arg_288_0 and not isNil(var_288_14) and arg_285_1.var_.actorSpriteComps1060 == nil then
				arg_285_1.var_.actorSpriteComps1060 = var_288_14:GetComponentsInChildren(typeof(Image), true)
			end

			local var_288_16 = 0.034

			if var_288_15 <= arg_285_1.time_ and arg_285_1.time_ < var_288_15 + var_288_16 and not isNil(var_288_14) then
				local var_288_17 = (arg_285_1.time_ - var_288_15) / var_288_16

				if arg_285_1.var_.actorSpriteComps1060 then
					for iter_288_2, iter_288_3 in pairs(arg_285_1.var_.actorSpriteComps1060:ToTable()) do
						if iter_288_3 then
							if arg_285_1.isInRecall_ then
								local var_288_18 = Mathf.Lerp(iter_288_3.color.r, arg_285_1.hightColor1.r, var_288_17)
								local var_288_19 = Mathf.Lerp(iter_288_3.color.g, arg_285_1.hightColor1.g, var_288_17)
								local var_288_20 = Mathf.Lerp(iter_288_3.color.b, arg_285_1.hightColor1.b, var_288_17)

								iter_288_3.color = Color.New(var_288_18, var_288_19, var_288_20)
							else
								local var_288_21 = Mathf.Lerp(iter_288_3.color.r, 1, var_288_17)

								iter_288_3.color = Color.New(var_288_21, var_288_21, var_288_21)
							end
						end
					end
				end
			end

			if arg_285_1.time_ >= var_288_15 + var_288_16 and arg_285_1.time_ < var_288_15 + var_288_16 + arg_288_0 and not isNil(var_288_14) and arg_285_1.var_.actorSpriteComps1060 then
				for iter_288_4, iter_288_5 in pairs(arg_285_1.var_.actorSpriteComps1060:ToTable()) do
					if iter_288_5 then
						if arg_285_1.isInRecall_ then
							iter_288_5.color = arg_285_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_288_5.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_285_1.var_.actorSpriteComps1060 = nil
			end

			local var_288_22 = arg_285_1.actors_["1012"]
			local var_288_23 = 0

			if var_288_23 < arg_285_1.time_ and arg_285_1.time_ <= var_288_23 + arg_288_0 and not isNil(var_288_22) and arg_285_1.var_.actorSpriteComps1012 == nil then
				arg_285_1.var_.actorSpriteComps1012 = var_288_22:GetComponentsInChildren(typeof(Image), true)
			end

			local var_288_24 = 0.034

			if var_288_23 <= arg_285_1.time_ and arg_285_1.time_ < var_288_23 + var_288_24 and not isNil(var_288_22) then
				local var_288_25 = (arg_285_1.time_ - var_288_23) / var_288_24

				if arg_285_1.var_.actorSpriteComps1012 then
					for iter_288_6, iter_288_7 in pairs(arg_285_1.var_.actorSpriteComps1012:ToTable()) do
						if iter_288_7 then
							if arg_285_1.isInRecall_ then
								local var_288_26 = Mathf.Lerp(iter_288_7.color.r, arg_285_1.hightColor2.r, var_288_25)
								local var_288_27 = Mathf.Lerp(iter_288_7.color.g, arg_285_1.hightColor2.g, var_288_25)
								local var_288_28 = Mathf.Lerp(iter_288_7.color.b, arg_285_1.hightColor2.b, var_288_25)

								iter_288_7.color = Color.New(var_288_26, var_288_27, var_288_28)
							else
								local var_288_29 = Mathf.Lerp(iter_288_7.color.r, 0.5, var_288_25)

								iter_288_7.color = Color.New(var_288_29, var_288_29, var_288_29)
							end
						end
					end
				end
			end

			if arg_285_1.time_ >= var_288_23 + var_288_24 and arg_285_1.time_ < var_288_23 + var_288_24 + arg_288_0 and not isNil(var_288_22) and arg_285_1.var_.actorSpriteComps1012 then
				for iter_288_8, iter_288_9 in pairs(arg_285_1.var_.actorSpriteComps1012:ToTable()) do
					if iter_288_9 then
						if arg_285_1.isInRecall_ then
							iter_288_9.color = arg_285_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_288_9.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_285_1.var_.actorSpriteComps1012 = nil
			end

			local var_288_30 = 0
			local var_288_31 = 0.725

			if var_288_30 < arg_285_1.time_ and arg_285_1.time_ <= var_288_30 + arg_288_0 then
				arg_285_1.talkMaxDuration = 0
				arg_285_1.dialogCg_.alpha = 1

				arg_285_1.dialog_:SetActive(true)
				SetActive(arg_285_1.leftNameGo_, true)

				local var_288_32 = arg_285_1:FormatText(StoryNameCfg[584].name)

				arg_285_1.leftNameTxt_.text = var_288_32

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_285_1.leftNameTxt_.transform)

				arg_285_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_285_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_285_1:RecordName(arg_285_1.leftNameTxt_.text)
				SetActive(arg_285_1.iconTrs_.gameObject, false)
				arg_285_1.callingController_:SetSelectedState("normal")

				local var_288_33 = arg_285_1:GetWordFromCfg(410082069)
				local var_288_34 = arg_285_1:FormatText(var_288_33.content)

				arg_285_1.text_.text = var_288_34

				LuaForUtil.ClearLinePrefixSymbol(arg_285_1.text_)

				local var_288_35 = 29
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

				if manager.audio:GetVoiceLength("story_v_out_410082", "410082069", "story_v_out_410082.awb") ~= 0 then
					local var_288_38 = manager.audio:GetVoiceLength("story_v_out_410082", "410082069", "story_v_out_410082.awb") / 1000

					if var_288_38 + var_288_30 > arg_285_1.duration_ then
						arg_285_1.duration_ = var_288_38 + var_288_30
					end

					if var_288_33.prefab_name ~= "" and arg_285_1.actors_[var_288_33.prefab_name] ~= nil then
						local var_288_39 = LuaForUtil.PlayVoiceWithCriLipsync(arg_285_1.actors_[var_288_33.prefab_name].transform, "story_v_out_410082", "410082069", "story_v_out_410082.awb")

						arg_285_1:RecordAudio("410082069", var_288_39)
						arg_285_1:RecordAudio("410082069", var_288_39)
					else
						arg_285_1:AudioAction("play", "voice", "story_v_out_410082", "410082069", "story_v_out_410082.awb")
					end

					arg_285_1:RecordHistoryTalkVoice("story_v_out_410082", "410082069", "story_v_out_410082.awb")
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
				actorName = "1060",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			},
			{
				assetPath = "",
				actorName = "1012",
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
	Play410082070 = function(arg_289_0, arg_289_1)
		arg_289_1.time_ = 0
		arg_289_1.frameCnt_ = 0
		arg_289_1.state_ = "playing"
		arg_289_1.curTalkId_ = 410082070
		arg_289_1.duration_ = 5.3

		local var_289_0 = {
			zh = 2.333,
			ja = 5.3
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
				arg_289_0:Play410082071(arg_289_1)
			end
		end

		function arg_289_1.onSingleLineUpdate_(arg_292_0)
			local var_292_0 = arg_289_1.actors_["1012"].transform
			local var_292_1 = 0

			if var_292_1 < arg_289_1.time_ and arg_289_1.time_ <= var_292_1 + arg_292_0 then
				arg_289_1.var_.moveOldPos1012 = var_292_0.localPosition
				var_292_0.localScale = Vector3.New(1, 1, 1)

				arg_289_1:CheckSpriteTmpPos("1012", 4)

				local var_292_2 = var_292_0.childCount

				for iter_292_0 = 0, var_292_2 - 1 do
					local var_292_3 = var_292_0:GetChild(iter_292_0)

					if var_292_3.name == "" or not string.find(var_292_3.name, "split") then
						var_292_3.gameObject:SetActive(true)
					else
						var_292_3.gameObject:SetActive(false)
					end
				end
			end

			local var_292_4 = 0.001

			if var_292_1 <= arg_289_1.time_ and arg_289_1.time_ < var_292_1 + var_292_4 then
				local var_292_5 = (arg_289_1.time_ - var_292_1) / var_292_4
				local var_292_6 = Vector3.New(390, -465, 300)

				var_292_0.localPosition = Vector3.Lerp(arg_289_1.var_.moveOldPos1012, var_292_6, var_292_5)
			end

			if arg_289_1.time_ >= var_292_1 + var_292_4 and arg_289_1.time_ < var_292_1 + var_292_4 + arg_292_0 then
				var_292_0.localPosition = Vector3.New(390, -465, 300)
			end

			local var_292_7 = arg_289_1.actors_["1012"]
			local var_292_8 = 0

			if var_292_8 < arg_289_1.time_ and arg_289_1.time_ <= var_292_8 + arg_292_0 and not isNil(var_292_7) and arg_289_1.var_.actorSpriteComps1012 == nil then
				arg_289_1.var_.actorSpriteComps1012 = var_292_7:GetComponentsInChildren(typeof(Image), true)
			end

			local var_292_9 = 0.034

			if var_292_8 <= arg_289_1.time_ and arg_289_1.time_ < var_292_8 + var_292_9 and not isNil(var_292_7) then
				local var_292_10 = (arg_289_1.time_ - var_292_8) / var_292_9

				if arg_289_1.var_.actorSpriteComps1012 then
					for iter_292_1, iter_292_2 in pairs(arg_289_1.var_.actorSpriteComps1012:ToTable()) do
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

			if arg_289_1.time_ >= var_292_8 + var_292_9 and arg_289_1.time_ < var_292_8 + var_292_9 + arg_292_0 and not isNil(var_292_7) and arg_289_1.var_.actorSpriteComps1012 then
				for iter_292_3, iter_292_4 in pairs(arg_289_1.var_.actorSpriteComps1012:ToTable()) do
					if iter_292_4 then
						if arg_289_1.isInRecall_ then
							iter_292_4.color = arg_289_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_292_4.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_289_1.var_.actorSpriteComps1012 = nil
			end

			local var_292_15 = arg_289_1.actors_["1060"]
			local var_292_16 = 0

			if var_292_16 < arg_289_1.time_ and arg_289_1.time_ <= var_292_16 + arg_292_0 and not isNil(var_292_15) and arg_289_1.var_.actorSpriteComps1060 == nil then
				arg_289_1.var_.actorSpriteComps1060 = var_292_15:GetComponentsInChildren(typeof(Image), true)
			end

			local var_292_17 = 0.034

			if var_292_16 <= arg_289_1.time_ and arg_289_1.time_ < var_292_16 + var_292_17 and not isNil(var_292_15) then
				local var_292_18 = (arg_289_1.time_ - var_292_16) / var_292_17

				if arg_289_1.var_.actorSpriteComps1060 then
					for iter_292_5, iter_292_6 in pairs(arg_289_1.var_.actorSpriteComps1060:ToTable()) do
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

			if arg_289_1.time_ >= var_292_16 + var_292_17 and arg_289_1.time_ < var_292_16 + var_292_17 + arg_292_0 and not isNil(var_292_15) and arg_289_1.var_.actorSpriteComps1060 then
				for iter_292_7, iter_292_8 in pairs(arg_289_1.var_.actorSpriteComps1060:ToTable()) do
					if iter_292_8 then
						if arg_289_1.isInRecall_ then
							iter_292_8.color = arg_289_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_292_8.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_289_1.var_.actorSpriteComps1060 = nil
			end

			local var_292_23 = 0
			local var_292_24 = 0.325

			if var_292_23 < arg_289_1.time_ and arg_289_1.time_ <= var_292_23 + arg_292_0 then
				arg_289_1.talkMaxDuration = 0
				arg_289_1.dialogCg_.alpha = 1

				arg_289_1.dialog_:SetActive(true)
				SetActive(arg_289_1.leftNameGo_, true)

				local var_292_25 = arg_289_1:FormatText(StoryNameCfg[595].name)

				arg_289_1.leftNameTxt_.text = var_292_25

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_289_1.leftNameTxt_.transform)

				arg_289_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_289_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_289_1:RecordName(arg_289_1.leftNameTxt_.text)
				SetActive(arg_289_1.iconTrs_.gameObject, false)
				arg_289_1.callingController_:SetSelectedState("normal")

				local var_292_26 = arg_289_1:GetWordFromCfg(410082070)
				local var_292_27 = arg_289_1:FormatText(var_292_26.content)

				arg_289_1.text_.text = var_292_27

				LuaForUtil.ClearLinePrefixSymbol(arg_289_1.text_)

				local var_292_28 = 13
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

				if manager.audio:GetVoiceLength("story_v_out_410082", "410082070", "story_v_out_410082.awb") ~= 0 then
					local var_292_31 = manager.audio:GetVoiceLength("story_v_out_410082", "410082070", "story_v_out_410082.awb") / 1000

					if var_292_31 + var_292_23 > arg_289_1.duration_ then
						arg_289_1.duration_ = var_292_31 + var_292_23
					end

					if var_292_26.prefab_name ~= "" and arg_289_1.actors_[var_292_26.prefab_name] ~= nil then
						local var_292_32 = LuaForUtil.PlayVoiceWithCriLipsync(arg_289_1.actors_[var_292_26.prefab_name].transform, "story_v_out_410082", "410082070", "story_v_out_410082.awb")

						arg_289_1:RecordAudio("410082070", var_292_32)
						arg_289_1:RecordAudio("410082070", var_292_32)
					else
						arg_289_1:AudioAction("play", "voice", "story_v_out_410082", "410082070", "story_v_out_410082.awb")
					end

					arg_289_1:RecordHistoryTalkVoice("story_v_out_410082", "410082070", "story_v_out_410082.awb")
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
				actorName = "1012",
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
	Play410082071 = function(arg_293_0, arg_293_1)
		arg_293_1.time_ = 0
		arg_293_1.frameCnt_ = 0
		arg_293_1.state_ = "playing"
		arg_293_1.curTalkId_ = 410082071
		arg_293_1.duration_ = 12.37

		local var_293_0 = {
			zh = 6.9,
			ja = 12.366
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
				arg_293_0:Play410082072(arg_293_1)
			end
		end

		function arg_293_1.onSingleLineUpdate_(arg_296_0)
			local var_296_0 = 0
			local var_296_1 = 0.75

			if var_296_0 < arg_293_1.time_ and arg_293_1.time_ <= var_296_0 + arg_296_0 then
				arg_293_1.talkMaxDuration = 0
				arg_293_1.dialogCg_.alpha = 1

				arg_293_1.dialog_:SetActive(true)
				SetActive(arg_293_1.leftNameGo_, true)

				local var_296_2 = arg_293_1:FormatText(StoryNameCfg[595].name)

				arg_293_1.leftNameTxt_.text = var_296_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_293_1.leftNameTxt_.transform)

				arg_293_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_293_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_293_1:RecordName(arg_293_1.leftNameTxt_.text)
				SetActive(arg_293_1.iconTrs_.gameObject, false)
				arg_293_1.callingController_:SetSelectedState("normal")

				local var_296_3 = arg_293_1:GetWordFromCfg(410082071)
				local var_296_4 = arg_293_1:FormatText(var_296_3.content)

				arg_293_1.text_.text = var_296_4

				LuaForUtil.ClearLinePrefixSymbol(arg_293_1.text_)

				local var_296_5 = 30
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

				if manager.audio:GetVoiceLength("story_v_out_410082", "410082071", "story_v_out_410082.awb") ~= 0 then
					local var_296_8 = manager.audio:GetVoiceLength("story_v_out_410082", "410082071", "story_v_out_410082.awb") / 1000

					if var_296_8 + var_296_0 > arg_293_1.duration_ then
						arg_293_1.duration_ = var_296_8 + var_296_0
					end

					if var_296_3.prefab_name ~= "" and arg_293_1.actors_[var_296_3.prefab_name] ~= nil then
						local var_296_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_293_1.actors_[var_296_3.prefab_name].transform, "story_v_out_410082", "410082071", "story_v_out_410082.awb")

						arg_293_1:RecordAudio("410082071", var_296_9)
						arg_293_1:RecordAudio("410082071", var_296_9)
					else
						arg_293_1:AudioAction("play", "voice", "story_v_out_410082", "410082071", "story_v_out_410082.awb")
					end

					arg_293_1:RecordHistoryTalkVoice("story_v_out_410082", "410082071", "story_v_out_410082.awb")
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
	Play410082072 = function(arg_297_0, arg_297_1)
		arg_297_1.time_ = 0
		arg_297_1.frameCnt_ = 0
		arg_297_1.state_ = "playing"
		arg_297_1.curTalkId_ = 410082072
		arg_297_1.duration_ = 3.03

		local var_297_0 = {
			zh = 2.7,
			ja = 3.033
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
				arg_297_0:Play410082073(arg_297_1)
			end
		end

		function arg_297_1.onSingleLineUpdate_(arg_300_0)
			local var_300_0 = arg_297_1.actors_["1056"].transform
			local var_300_1 = 0

			if var_300_1 < arg_297_1.time_ and arg_297_1.time_ <= var_300_1 + arg_300_0 then
				arg_297_1.var_.moveOldPos1056 = var_300_0.localPosition
				var_300_0.localScale = Vector3.New(1, 1, 1)

				arg_297_1:CheckSpriteTmpPos("1056", 3)

				local var_300_2 = var_300_0.childCount

				for iter_300_0 = 0, var_300_2 - 1 do
					local var_300_3 = var_300_0:GetChild(iter_300_0)

					if var_300_3.name == "split_3" or not string.find(var_300_3.name, "split") then
						var_300_3.gameObject:SetActive(true)
					else
						var_300_3.gameObject:SetActive(false)
					end
				end
			end

			local var_300_4 = 0.001

			if var_300_1 <= arg_297_1.time_ and arg_297_1.time_ < var_300_1 + var_300_4 then
				local var_300_5 = (arg_297_1.time_ - var_300_1) / var_300_4
				local var_300_6 = Vector3.New(0, -350, -180)

				var_300_0.localPosition = Vector3.Lerp(arg_297_1.var_.moveOldPos1056, var_300_6, var_300_5)
			end

			if arg_297_1.time_ >= var_300_1 + var_300_4 and arg_297_1.time_ < var_300_1 + var_300_4 + arg_300_0 then
				var_300_0.localPosition = Vector3.New(0, -350, -180)
			end

			local var_300_7 = arg_297_1.actors_["1056"]
			local var_300_8 = 0

			if var_300_8 < arg_297_1.time_ and arg_297_1.time_ <= var_300_8 + arg_300_0 and not isNil(var_300_7) and arg_297_1.var_.actorSpriteComps1056 == nil then
				arg_297_1.var_.actorSpriteComps1056 = var_300_7:GetComponentsInChildren(typeof(Image), true)
			end

			local var_300_9 = 0.034

			if var_300_8 <= arg_297_1.time_ and arg_297_1.time_ < var_300_8 + var_300_9 and not isNil(var_300_7) then
				local var_300_10 = (arg_297_1.time_ - var_300_8) / var_300_9

				if arg_297_1.var_.actorSpriteComps1056 then
					for iter_300_1, iter_300_2 in pairs(arg_297_1.var_.actorSpriteComps1056:ToTable()) do
						if iter_300_2 then
							if arg_297_1.isInRecall_ then
								local var_300_11 = Mathf.Lerp(iter_300_2.color.r, arg_297_1.hightColor1.r, var_300_10)
								local var_300_12 = Mathf.Lerp(iter_300_2.color.g, arg_297_1.hightColor1.g, var_300_10)
								local var_300_13 = Mathf.Lerp(iter_300_2.color.b, arg_297_1.hightColor1.b, var_300_10)

								iter_300_2.color = Color.New(var_300_11, var_300_12, var_300_13)
							else
								local var_300_14 = Mathf.Lerp(iter_300_2.color.r, 1, var_300_10)

								iter_300_2.color = Color.New(var_300_14, var_300_14, var_300_14)
							end
						end
					end
				end
			end

			if arg_297_1.time_ >= var_300_8 + var_300_9 and arg_297_1.time_ < var_300_8 + var_300_9 + arg_300_0 and not isNil(var_300_7) and arg_297_1.var_.actorSpriteComps1056 then
				for iter_300_3, iter_300_4 in pairs(arg_297_1.var_.actorSpriteComps1056:ToTable()) do
					if iter_300_4 then
						if arg_297_1.isInRecall_ then
							iter_300_4.color = arg_297_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_300_4.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_297_1.var_.actorSpriteComps1056 = nil
			end

			local var_300_15 = arg_297_1.actors_["1060"].transform
			local var_300_16 = 0

			if var_300_16 < arg_297_1.time_ and arg_297_1.time_ <= var_300_16 + arg_300_0 then
				arg_297_1.var_.moveOldPos1060 = var_300_15.localPosition
				var_300_15.localScale = Vector3.New(1, 1, 1)

				arg_297_1:CheckSpriteTmpPos("1060", 7)

				local var_300_17 = var_300_15.childCount

				for iter_300_5 = 0, var_300_17 - 1 do
					local var_300_18 = var_300_15:GetChild(iter_300_5)

					if var_300_18.name == "" or not string.find(var_300_18.name, "split") then
						var_300_18.gameObject:SetActive(true)
					else
						var_300_18.gameObject:SetActive(false)
					end
				end
			end

			local var_300_19 = 0.001

			if var_300_16 <= arg_297_1.time_ and arg_297_1.time_ < var_300_16 + var_300_19 then
				local var_300_20 = (arg_297_1.time_ - var_300_16) / var_300_19
				local var_300_21 = Vector3.New(0, -2000, -40)

				var_300_15.localPosition = Vector3.Lerp(arg_297_1.var_.moveOldPos1060, var_300_21, var_300_20)
			end

			if arg_297_1.time_ >= var_300_16 + var_300_19 and arg_297_1.time_ < var_300_16 + var_300_19 + arg_300_0 then
				var_300_15.localPosition = Vector3.New(0, -2000, -40)
			end

			local var_300_22 = arg_297_1.actors_["1012"].transform
			local var_300_23 = 0

			if var_300_23 < arg_297_1.time_ and arg_297_1.time_ <= var_300_23 + arg_300_0 then
				arg_297_1.var_.moveOldPos1012 = var_300_22.localPosition
				var_300_22.localScale = Vector3.New(1, 1, 1)

				arg_297_1:CheckSpriteTmpPos("1012", 7)

				local var_300_24 = var_300_22.childCount

				for iter_300_6 = 0, var_300_24 - 1 do
					local var_300_25 = var_300_22:GetChild(iter_300_6)

					if var_300_25.name == "" or not string.find(var_300_25.name, "split") then
						var_300_25.gameObject:SetActive(true)
					else
						var_300_25.gameObject:SetActive(false)
					end
				end
			end

			local var_300_26 = 0.001

			if var_300_23 <= arg_297_1.time_ and arg_297_1.time_ < var_300_23 + var_300_26 then
				local var_300_27 = (arg_297_1.time_ - var_300_23) / var_300_26
				local var_300_28 = Vector3.New(0, -2000, 300)

				var_300_22.localPosition = Vector3.Lerp(arg_297_1.var_.moveOldPos1012, var_300_28, var_300_27)
			end

			if arg_297_1.time_ >= var_300_23 + var_300_26 and arg_297_1.time_ < var_300_23 + var_300_26 + arg_300_0 then
				var_300_22.localPosition = Vector3.New(0, -2000, 300)
			end

			local var_300_29 = 0
			local var_300_30 = 0.15

			if var_300_29 < arg_297_1.time_ and arg_297_1.time_ <= var_300_29 + arg_300_0 then
				arg_297_1.talkMaxDuration = 0
				arg_297_1.dialogCg_.alpha = 1

				arg_297_1.dialog_:SetActive(true)
				SetActive(arg_297_1.leftNameGo_, true)

				local var_300_31 = arg_297_1:FormatText(StoryNameCfg[605].name)

				arg_297_1.leftNameTxt_.text = var_300_31

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_297_1.leftNameTxt_.transform)

				arg_297_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_297_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_297_1:RecordName(arg_297_1.leftNameTxt_.text)
				SetActive(arg_297_1.iconTrs_.gameObject, false)
				arg_297_1.callingController_:SetSelectedState("normal")

				local var_300_32 = arg_297_1:GetWordFromCfg(410082072)
				local var_300_33 = arg_297_1:FormatText(var_300_32.content)

				arg_297_1.text_.text = var_300_33

				LuaForUtil.ClearLinePrefixSymbol(arg_297_1.text_)

				local var_300_34 = 6
				local var_300_35 = utf8.len(var_300_33)
				local var_300_36 = var_300_34 <= 0 and var_300_30 or var_300_30 * (var_300_35 / var_300_34)

				if var_300_36 > 0 and var_300_30 < var_300_36 then
					arg_297_1.talkMaxDuration = var_300_36

					if var_300_36 + var_300_29 > arg_297_1.duration_ then
						arg_297_1.duration_ = var_300_36 + var_300_29
					end
				end

				arg_297_1.text_.text = var_300_33
				arg_297_1.typewritter.percent = 0

				arg_297_1.typewritter:SetDirty()
				arg_297_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_410082", "410082072", "story_v_out_410082.awb") ~= 0 then
					local var_300_37 = manager.audio:GetVoiceLength("story_v_out_410082", "410082072", "story_v_out_410082.awb") / 1000

					if var_300_37 + var_300_29 > arg_297_1.duration_ then
						arg_297_1.duration_ = var_300_37 + var_300_29
					end

					if var_300_32.prefab_name ~= "" and arg_297_1.actors_[var_300_32.prefab_name] ~= nil then
						local var_300_38 = LuaForUtil.PlayVoiceWithCriLipsync(arg_297_1.actors_[var_300_32.prefab_name].transform, "story_v_out_410082", "410082072", "story_v_out_410082.awb")

						arg_297_1:RecordAudio("410082072", var_300_38)
						arg_297_1:RecordAudio("410082072", var_300_38)
					else
						arg_297_1:AudioAction("play", "voice", "story_v_out_410082", "410082072", "story_v_out_410082.awb")
					end

					arg_297_1:RecordHistoryTalkVoice("story_v_out_410082", "410082072", "story_v_out_410082.awb")
				end

				arg_297_1:RecordContent(arg_297_1.text_.text)
			end

			local var_300_39 = math.max(var_300_30, arg_297_1.talkMaxDuration)

			if var_300_29 <= arg_297_1.time_ and arg_297_1.time_ < var_300_29 + var_300_39 then
				arg_297_1.typewritter.percent = (arg_297_1.time_ - var_300_29) / var_300_39

				arg_297_1.typewritter:SetDirty()
			end

			if arg_297_1.time_ >= var_300_29 + var_300_39 and arg_297_1.time_ < var_300_29 + var_300_39 + arg_300_0 then
				arg_297_1.typewritter.percent = 1

				arg_297_1.typewritter:SetDirty()
				arg_297_1:ShowNextGo(true)
			end
		end

		arg_297_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1056",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			},
			{
				assetPath = "",
				actorName = "1060",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			},
			{
				assetPath = "",
				actorName = "1012",
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
	Play410082073 = function(arg_301_0, arg_301_1)
		arg_301_1.time_ = 0
		arg_301_1.frameCnt_ = 0
		arg_301_1.state_ = "playing"
		arg_301_1.curTalkId_ = 410082073
		arg_301_1.duration_ = 5

		SetActive(arg_301_1.tipsGo_, false)

		function arg_301_1.onSingleLineFinish_()
			arg_301_1.onSingleLineUpdate_ = nil
			arg_301_1.onSingleLineFinish_ = nil
			arg_301_1.state_ = "waiting"
		end

		function arg_301_1.playNext_(arg_303_0)
			if arg_303_0 == 1 then
				arg_301_0:Play410082074(arg_301_1)
			end
		end

		function arg_301_1.onSingleLineUpdate_(arg_304_0)
			local var_304_0 = arg_301_1.actors_["1056"]
			local var_304_1 = 0

			if var_304_1 < arg_301_1.time_ and arg_301_1.time_ <= var_304_1 + arg_304_0 and not isNil(var_304_0) and arg_301_1.var_.actorSpriteComps1056 == nil then
				arg_301_1.var_.actorSpriteComps1056 = var_304_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_304_2 = 0.034

			if var_304_1 <= arg_301_1.time_ and arg_301_1.time_ < var_304_1 + var_304_2 and not isNil(var_304_0) then
				local var_304_3 = (arg_301_1.time_ - var_304_1) / var_304_2

				if arg_301_1.var_.actorSpriteComps1056 then
					for iter_304_0, iter_304_1 in pairs(arg_301_1.var_.actorSpriteComps1056:ToTable()) do
						if iter_304_1 then
							if arg_301_1.isInRecall_ then
								local var_304_4 = Mathf.Lerp(iter_304_1.color.r, arg_301_1.hightColor2.r, var_304_3)
								local var_304_5 = Mathf.Lerp(iter_304_1.color.g, arg_301_1.hightColor2.g, var_304_3)
								local var_304_6 = Mathf.Lerp(iter_304_1.color.b, arg_301_1.hightColor2.b, var_304_3)

								iter_304_1.color = Color.New(var_304_4, var_304_5, var_304_6)
							else
								local var_304_7 = Mathf.Lerp(iter_304_1.color.r, 0.5, var_304_3)

								iter_304_1.color = Color.New(var_304_7, var_304_7, var_304_7)
							end
						end
					end
				end
			end

			if arg_301_1.time_ >= var_304_1 + var_304_2 and arg_301_1.time_ < var_304_1 + var_304_2 + arg_304_0 and not isNil(var_304_0) and arg_301_1.var_.actorSpriteComps1056 then
				for iter_304_2, iter_304_3 in pairs(arg_301_1.var_.actorSpriteComps1056:ToTable()) do
					if iter_304_3 then
						if arg_301_1.isInRecall_ then
							iter_304_3.color = arg_301_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_304_3.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_301_1.var_.actorSpriteComps1056 = nil
			end

			local var_304_8 = 0
			local var_304_9 = 0.55

			if var_304_8 < arg_301_1.time_ and arg_301_1.time_ <= var_304_8 + arg_304_0 then
				arg_301_1.talkMaxDuration = 0
				arg_301_1.dialogCg_.alpha = 1

				arg_301_1.dialog_:SetActive(true)
				SetActive(arg_301_1.leftNameGo_, false)

				arg_301_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_301_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_301_1:RecordName(arg_301_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_301_1.iconTrs_.gameObject, false)
				arg_301_1.callingController_:SetSelectedState("normal")

				local var_304_10 = arg_301_1:GetWordFromCfg(410082073)
				local var_304_11 = arg_301_1:FormatText(var_304_10.content)

				arg_301_1.text_.text = var_304_11

				LuaForUtil.ClearLinePrefixSymbol(arg_301_1.text_)

				local var_304_12 = 22
				local var_304_13 = utf8.len(var_304_11)
				local var_304_14 = var_304_12 <= 0 and var_304_9 or var_304_9 * (var_304_13 / var_304_12)

				if var_304_14 > 0 and var_304_9 < var_304_14 then
					arg_301_1.talkMaxDuration = var_304_14

					if var_304_14 + var_304_8 > arg_301_1.duration_ then
						arg_301_1.duration_ = var_304_14 + var_304_8
					end
				end

				arg_301_1.text_.text = var_304_11
				arg_301_1.typewritter.percent = 0

				arg_301_1.typewritter:SetDirty()
				arg_301_1:ShowNextGo(false)
				arg_301_1:RecordContent(arg_301_1.text_.text)
			end

			local var_304_15 = math.max(var_304_9, arg_301_1.talkMaxDuration)

			if var_304_8 <= arg_301_1.time_ and arg_301_1.time_ < var_304_8 + var_304_15 then
				arg_301_1.typewritter.percent = (arg_301_1.time_ - var_304_8) / var_304_15

				arg_301_1.typewritter:SetDirty()
			end

			if arg_301_1.time_ >= var_304_8 + var_304_15 and arg_301_1.time_ < var_304_8 + var_304_15 + arg_304_0 then
				arg_301_1.typewritter.percent = 1

				arg_301_1.typewritter:SetDirty()
				arg_301_1:ShowNextGo(true)
			end
		end

		arg_301_1.nodeConfigList_ = {}

		arg_301_1:InitPlayNodeList()
	end,
	Play410082074 = function(arg_305_0, arg_305_1)
		arg_305_1.time_ = 0
		arg_305_1.frameCnt_ = 0
		arg_305_1.state_ = "playing"
		arg_305_1.curTalkId_ = 410082074
		arg_305_1.duration_ = 12.6

		local var_305_0 = {
			zh = 12.6,
			ja = 11.1
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
				arg_305_0:Play410082075(arg_305_1)
			end
		end

		function arg_305_1.onSingleLineUpdate_(arg_308_0)
			local var_308_0 = arg_305_1.actors_["1012"]
			local var_308_1 = 0

			if var_308_1 < arg_305_1.time_ and arg_305_1.time_ <= var_308_1 + arg_308_0 and not isNil(var_308_0) and arg_305_1.var_.actorSpriteComps1012 == nil then
				arg_305_1.var_.actorSpriteComps1012 = var_308_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_308_2 = 0.034

			if var_308_1 <= arg_305_1.time_ and arg_305_1.time_ < var_308_1 + var_308_2 and not isNil(var_308_0) then
				local var_308_3 = (arg_305_1.time_ - var_308_1) / var_308_2

				if arg_305_1.var_.actorSpriteComps1012 then
					for iter_308_0, iter_308_1 in pairs(arg_305_1.var_.actorSpriteComps1012:ToTable()) do
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

			if arg_305_1.time_ >= var_308_1 + var_308_2 and arg_305_1.time_ < var_308_1 + var_308_2 + arg_308_0 and not isNil(var_308_0) and arg_305_1.var_.actorSpriteComps1012 then
				for iter_308_2, iter_308_3 in pairs(arg_305_1.var_.actorSpriteComps1012:ToTable()) do
					if iter_308_3 then
						if arg_305_1.isInRecall_ then
							iter_308_3.color = arg_305_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_308_3.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_305_1.var_.actorSpriteComps1012 = nil
			end

			local var_308_8 = arg_305_1.actors_["1060"].transform
			local var_308_9 = 0

			if var_308_9 < arg_305_1.time_ and arg_305_1.time_ <= var_308_9 + arg_308_0 then
				arg_305_1.var_.moveOldPos1060 = var_308_8.localPosition
				var_308_8.localScale = Vector3.New(1, 1, 1)

				arg_305_1:CheckSpriteTmpPos("1060", 2)

				local var_308_10 = var_308_8.childCount

				for iter_308_4 = 0, var_308_10 - 1 do
					local var_308_11 = var_308_8:GetChild(iter_308_4)

					if var_308_11.name == "" or not string.find(var_308_11.name, "split") then
						var_308_11.gameObject:SetActive(true)
					else
						var_308_11.gameObject:SetActive(false)
					end
				end
			end

			local var_308_12 = 0.001

			if var_308_9 <= arg_305_1.time_ and arg_305_1.time_ < var_308_9 + var_308_12 then
				local var_308_13 = (arg_305_1.time_ - var_308_9) / var_308_12
				local var_308_14 = Vector3.New(-440.94, -430.8, 6.9)

				var_308_8.localPosition = Vector3.Lerp(arg_305_1.var_.moveOldPos1060, var_308_14, var_308_13)
			end

			if arg_305_1.time_ >= var_308_9 + var_308_12 and arg_305_1.time_ < var_308_9 + var_308_12 + arg_308_0 then
				var_308_8.localPosition = Vector3.New(-440.94, -430.8, 6.9)
			end

			local var_308_15 = arg_305_1.actors_["1012"].transform
			local var_308_16 = 0

			if var_308_16 < arg_305_1.time_ and arg_305_1.time_ <= var_308_16 + arg_308_0 then
				arg_305_1.var_.moveOldPos1012 = var_308_15.localPosition
				var_308_15.localScale = Vector3.New(1, 1, 1)

				arg_305_1:CheckSpriteTmpPos("1012", 4)

				local var_308_17 = var_308_15.childCount

				for iter_308_5 = 0, var_308_17 - 1 do
					local var_308_18 = var_308_15:GetChild(iter_308_5)

					if var_308_18.name == "" or not string.find(var_308_18.name, "split") then
						var_308_18.gameObject:SetActive(true)
					else
						var_308_18.gameObject:SetActive(false)
					end
				end
			end

			local var_308_19 = 0.001

			if var_308_16 <= arg_305_1.time_ and arg_305_1.time_ < var_308_16 + var_308_19 then
				local var_308_20 = (arg_305_1.time_ - var_308_16) / var_308_19
				local var_308_21 = Vector3.New(390, -465, 300)

				var_308_15.localPosition = Vector3.Lerp(arg_305_1.var_.moveOldPos1012, var_308_21, var_308_20)
			end

			if arg_305_1.time_ >= var_308_16 + var_308_19 and arg_305_1.time_ < var_308_16 + var_308_19 + arg_308_0 then
				var_308_15.localPosition = Vector3.New(390, -465, 300)
			end

			local var_308_22 = arg_305_1.actors_["1056"].transform
			local var_308_23 = 0

			if var_308_23 < arg_305_1.time_ and arg_305_1.time_ <= var_308_23 + arg_308_0 then
				arg_305_1.var_.moveOldPos1056 = var_308_22.localPosition
				var_308_22.localScale = Vector3.New(1, 1, 1)

				arg_305_1:CheckSpriteTmpPos("1056", 7)

				local var_308_24 = var_308_22.childCount

				for iter_308_6 = 0, var_308_24 - 1 do
					local var_308_25 = var_308_22:GetChild(iter_308_6)

					if var_308_25.name == "" or not string.find(var_308_25.name, "split") then
						var_308_25.gameObject:SetActive(true)
					else
						var_308_25.gameObject:SetActive(false)
					end
				end
			end

			local var_308_26 = 0.001

			if var_308_23 <= arg_305_1.time_ and arg_305_1.time_ < var_308_23 + var_308_26 then
				local var_308_27 = (arg_305_1.time_ - var_308_23) / var_308_26
				local var_308_28 = Vector3.New(0, -2000, -180)

				var_308_22.localPosition = Vector3.Lerp(arg_305_1.var_.moveOldPos1056, var_308_28, var_308_27)
			end

			if arg_305_1.time_ >= var_308_23 + var_308_26 and arg_305_1.time_ < var_308_23 + var_308_26 + arg_308_0 then
				var_308_22.localPosition = Vector3.New(0, -2000, -180)
			end

			local var_308_29 = arg_305_1.actors_["1060"]
			local var_308_30 = 0

			if var_308_30 < arg_305_1.time_ and arg_305_1.time_ <= var_308_30 + arg_308_0 and not isNil(var_308_29) and arg_305_1.var_.actorSpriteComps1060 == nil then
				arg_305_1.var_.actorSpriteComps1060 = var_308_29:GetComponentsInChildren(typeof(Image), true)
			end

			local var_308_31 = 0.034

			if var_308_30 <= arg_305_1.time_ and arg_305_1.time_ < var_308_30 + var_308_31 and not isNil(var_308_29) then
				local var_308_32 = (arg_305_1.time_ - var_308_30) / var_308_31

				if arg_305_1.var_.actorSpriteComps1060 then
					for iter_308_7, iter_308_8 in pairs(arg_305_1.var_.actorSpriteComps1060:ToTable()) do
						if iter_308_8 then
							if arg_305_1.isInRecall_ then
								local var_308_33 = Mathf.Lerp(iter_308_8.color.r, arg_305_1.hightColor2.r, var_308_32)
								local var_308_34 = Mathf.Lerp(iter_308_8.color.g, arg_305_1.hightColor2.g, var_308_32)
								local var_308_35 = Mathf.Lerp(iter_308_8.color.b, arg_305_1.hightColor2.b, var_308_32)

								iter_308_8.color = Color.New(var_308_33, var_308_34, var_308_35)
							else
								local var_308_36 = Mathf.Lerp(iter_308_8.color.r, 0.5, var_308_32)

								iter_308_8.color = Color.New(var_308_36, var_308_36, var_308_36)
							end
						end
					end
				end
			end

			if arg_305_1.time_ >= var_308_30 + var_308_31 and arg_305_1.time_ < var_308_30 + var_308_31 + arg_308_0 and not isNil(var_308_29) and arg_305_1.var_.actorSpriteComps1060 then
				for iter_308_9, iter_308_10 in pairs(arg_305_1.var_.actorSpriteComps1060:ToTable()) do
					if iter_308_10 then
						if arg_305_1.isInRecall_ then
							iter_308_10.color = arg_305_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_308_10.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_305_1.var_.actorSpriteComps1060 = nil
			end

			local var_308_37 = 0
			local var_308_38 = 1.575

			if var_308_37 < arg_305_1.time_ and arg_305_1.time_ <= var_308_37 + arg_308_0 then
				arg_305_1.talkMaxDuration = 0
				arg_305_1.dialogCg_.alpha = 1

				arg_305_1.dialog_:SetActive(true)
				SetActive(arg_305_1.leftNameGo_, true)

				local var_308_39 = arg_305_1:FormatText(StoryNameCfg[595].name)

				arg_305_1.leftNameTxt_.text = var_308_39

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_305_1.leftNameTxt_.transform)

				arg_305_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_305_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_305_1:RecordName(arg_305_1.leftNameTxt_.text)
				SetActive(arg_305_1.iconTrs_.gameObject, false)
				arg_305_1.callingController_:SetSelectedState("normal")

				local var_308_40 = arg_305_1:GetWordFromCfg(410082074)
				local var_308_41 = arg_305_1:FormatText(var_308_40.content)

				arg_305_1.text_.text = var_308_41

				LuaForUtil.ClearLinePrefixSymbol(arg_305_1.text_)

				local var_308_42 = 63
				local var_308_43 = utf8.len(var_308_41)
				local var_308_44 = var_308_42 <= 0 and var_308_38 or var_308_38 * (var_308_43 / var_308_42)

				if var_308_44 > 0 and var_308_38 < var_308_44 then
					arg_305_1.talkMaxDuration = var_308_44

					if var_308_44 + var_308_37 > arg_305_1.duration_ then
						arg_305_1.duration_ = var_308_44 + var_308_37
					end
				end

				arg_305_1.text_.text = var_308_41
				arg_305_1.typewritter.percent = 0

				arg_305_1.typewritter:SetDirty()
				arg_305_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_410082", "410082074", "story_v_out_410082.awb") ~= 0 then
					local var_308_45 = manager.audio:GetVoiceLength("story_v_out_410082", "410082074", "story_v_out_410082.awb") / 1000

					if var_308_45 + var_308_37 > arg_305_1.duration_ then
						arg_305_1.duration_ = var_308_45 + var_308_37
					end

					if var_308_40.prefab_name ~= "" and arg_305_1.actors_[var_308_40.prefab_name] ~= nil then
						local var_308_46 = LuaForUtil.PlayVoiceWithCriLipsync(arg_305_1.actors_[var_308_40.prefab_name].transform, "story_v_out_410082", "410082074", "story_v_out_410082.awb")

						arg_305_1:RecordAudio("410082074", var_308_46)
						arg_305_1:RecordAudio("410082074", var_308_46)
					else
						arg_305_1:AudioAction("play", "voice", "story_v_out_410082", "410082074", "story_v_out_410082.awb")
					end

					arg_305_1:RecordHistoryTalkVoice("story_v_out_410082", "410082074", "story_v_out_410082.awb")
				end

				arg_305_1:RecordContent(arg_305_1.text_.text)
			end

			local var_308_47 = math.max(var_308_38, arg_305_1.talkMaxDuration)

			if var_308_37 <= arg_305_1.time_ and arg_305_1.time_ < var_308_37 + var_308_47 then
				arg_305_1.typewritter.percent = (arg_305_1.time_ - var_308_37) / var_308_47

				arg_305_1.typewritter:SetDirty()
			end

			if arg_305_1.time_ >= var_308_37 + var_308_47 and arg_305_1.time_ < var_308_37 + var_308_47 + arg_308_0 then
				arg_305_1.typewritter.percent = 1

				arg_305_1.typewritter:SetDirty()
				arg_305_1:ShowNextGo(true)
			end
		end

		arg_305_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1060",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			},
			{
				assetPath = "",
				actorName = "1012",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			},
			{
				assetPath = "",
				actorName = "1056",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_305_1:InitPlayNodeList()
	end,
	Play410082075 = function(arg_309_0, arg_309_1)
		arg_309_1.time_ = 0
		arg_309_1.frameCnt_ = 0
		arg_309_1.state_ = "playing"
		arg_309_1.curTalkId_ = 410082075
		arg_309_1.duration_ = 6.7

		local var_309_0 = {
			zh = 6.7,
			ja = 6.533
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
				arg_309_0:Play410082076(arg_309_1)
			end
		end

		function arg_309_1.onSingleLineUpdate_(arg_312_0)
			local var_312_0 = 0
			local var_312_1 = 0.725

			if var_312_0 < arg_309_1.time_ and arg_309_1.time_ <= var_312_0 + arg_312_0 then
				arg_309_1.talkMaxDuration = 0
				arg_309_1.dialogCg_.alpha = 1

				arg_309_1.dialog_:SetActive(true)
				SetActive(arg_309_1.leftNameGo_, true)

				local var_312_2 = arg_309_1:FormatText(StoryNameCfg[595].name)

				arg_309_1.leftNameTxt_.text = var_312_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_309_1.leftNameTxt_.transform)

				arg_309_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_309_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_309_1:RecordName(arg_309_1.leftNameTxt_.text)
				SetActive(arg_309_1.iconTrs_.gameObject, false)
				arg_309_1.callingController_:SetSelectedState("normal")

				local var_312_3 = arg_309_1:GetWordFromCfg(410082075)
				local var_312_4 = arg_309_1:FormatText(var_312_3.content)

				arg_309_1.text_.text = var_312_4

				LuaForUtil.ClearLinePrefixSymbol(arg_309_1.text_)

				local var_312_5 = 29
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

				if manager.audio:GetVoiceLength("story_v_out_410082", "410082075", "story_v_out_410082.awb") ~= 0 then
					local var_312_8 = manager.audio:GetVoiceLength("story_v_out_410082", "410082075", "story_v_out_410082.awb") / 1000

					if var_312_8 + var_312_0 > arg_309_1.duration_ then
						arg_309_1.duration_ = var_312_8 + var_312_0
					end

					if var_312_3.prefab_name ~= "" and arg_309_1.actors_[var_312_3.prefab_name] ~= nil then
						local var_312_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_309_1.actors_[var_312_3.prefab_name].transform, "story_v_out_410082", "410082075", "story_v_out_410082.awb")

						arg_309_1:RecordAudio("410082075", var_312_9)
						arg_309_1:RecordAudio("410082075", var_312_9)
					else
						arg_309_1:AudioAction("play", "voice", "story_v_out_410082", "410082075", "story_v_out_410082.awb")
					end

					arg_309_1:RecordHistoryTalkVoice("story_v_out_410082", "410082075", "story_v_out_410082.awb")
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
	Play410082076 = function(arg_313_0, arg_313_1)
		arg_313_1.time_ = 0
		arg_313_1.frameCnt_ = 0
		arg_313_1.state_ = "playing"
		arg_313_1.curTalkId_ = 410082076
		arg_313_1.duration_ = 4.13

		local var_313_0 = {
			zh = 1.866,
			ja = 4.133
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
				arg_313_0:Play410082077(arg_313_1)
			end
		end

		function arg_313_1.onSingleLineUpdate_(arg_316_0)
			local var_316_0 = arg_313_1.actors_["1056"]
			local var_316_1 = 0

			if var_316_1 < arg_313_1.time_ and arg_313_1.time_ <= var_316_1 + arg_316_0 and not isNil(var_316_0) and arg_313_1.var_.actorSpriteComps1056 == nil then
				arg_313_1.var_.actorSpriteComps1056 = var_316_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_316_2 = 0.034

			if var_316_1 <= arg_313_1.time_ and arg_313_1.time_ < var_316_1 + var_316_2 and not isNil(var_316_0) then
				local var_316_3 = (arg_313_1.time_ - var_316_1) / var_316_2

				if arg_313_1.var_.actorSpriteComps1056 then
					for iter_316_0, iter_316_1 in pairs(arg_313_1.var_.actorSpriteComps1056:ToTable()) do
						if iter_316_1 then
							if arg_313_1.isInRecall_ then
								local var_316_4 = Mathf.Lerp(iter_316_1.color.r, arg_313_1.hightColor1.r, var_316_3)
								local var_316_5 = Mathf.Lerp(iter_316_1.color.g, arg_313_1.hightColor1.g, var_316_3)
								local var_316_6 = Mathf.Lerp(iter_316_1.color.b, arg_313_1.hightColor1.b, var_316_3)

								iter_316_1.color = Color.New(var_316_4, var_316_5, var_316_6)
							else
								local var_316_7 = Mathf.Lerp(iter_316_1.color.r, 1, var_316_3)

								iter_316_1.color = Color.New(var_316_7, var_316_7, var_316_7)
							end
						end
					end
				end
			end

			if arg_313_1.time_ >= var_316_1 + var_316_2 and arg_313_1.time_ < var_316_1 + var_316_2 + arg_316_0 and not isNil(var_316_0) and arg_313_1.var_.actorSpriteComps1056 then
				for iter_316_2, iter_316_3 in pairs(arg_313_1.var_.actorSpriteComps1056:ToTable()) do
					if iter_316_3 then
						if arg_313_1.isInRecall_ then
							iter_316_3.color = arg_313_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_316_3.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_313_1.var_.actorSpriteComps1056 = nil
			end

			local var_316_8 = arg_313_1.actors_["1012"]
			local var_316_9 = 0

			if var_316_9 < arg_313_1.time_ and arg_313_1.time_ <= var_316_9 + arg_316_0 and not isNil(var_316_8) and arg_313_1.var_.actorSpriteComps1012 == nil then
				arg_313_1.var_.actorSpriteComps1012 = var_316_8:GetComponentsInChildren(typeof(Image), true)
			end

			local var_316_10 = 0.034

			if var_316_9 <= arg_313_1.time_ and arg_313_1.time_ < var_316_9 + var_316_10 and not isNil(var_316_8) then
				local var_316_11 = (arg_313_1.time_ - var_316_9) / var_316_10

				if arg_313_1.var_.actorSpriteComps1012 then
					for iter_316_4, iter_316_5 in pairs(arg_313_1.var_.actorSpriteComps1012:ToTable()) do
						if iter_316_5 then
							if arg_313_1.isInRecall_ then
								local var_316_12 = Mathf.Lerp(iter_316_5.color.r, arg_313_1.hightColor2.r, var_316_11)
								local var_316_13 = Mathf.Lerp(iter_316_5.color.g, arg_313_1.hightColor2.g, var_316_11)
								local var_316_14 = Mathf.Lerp(iter_316_5.color.b, arg_313_1.hightColor2.b, var_316_11)

								iter_316_5.color = Color.New(var_316_12, var_316_13, var_316_14)
							else
								local var_316_15 = Mathf.Lerp(iter_316_5.color.r, 0.5, var_316_11)

								iter_316_5.color = Color.New(var_316_15, var_316_15, var_316_15)
							end
						end
					end
				end
			end

			if arg_313_1.time_ >= var_316_9 + var_316_10 and arg_313_1.time_ < var_316_9 + var_316_10 + arg_316_0 and not isNil(var_316_8) and arg_313_1.var_.actorSpriteComps1012 then
				for iter_316_6, iter_316_7 in pairs(arg_313_1.var_.actorSpriteComps1012:ToTable()) do
					if iter_316_7 then
						if arg_313_1.isInRecall_ then
							iter_316_7.color = arg_313_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_316_7.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_313_1.var_.actorSpriteComps1012 = nil
			end

			local var_316_16 = arg_313_1.actors_["1060"].transform
			local var_316_17 = 0

			if var_316_17 < arg_313_1.time_ and arg_313_1.time_ <= var_316_17 + arg_316_0 then
				arg_313_1.var_.moveOldPos1060 = var_316_16.localPosition
				var_316_16.localScale = Vector3.New(1, 1, 1)

				arg_313_1:CheckSpriteTmpPos("1060", 7)

				local var_316_18 = var_316_16.childCount

				for iter_316_8 = 0, var_316_18 - 1 do
					local var_316_19 = var_316_16:GetChild(iter_316_8)

					if var_316_19.name == "" or not string.find(var_316_19.name, "split") then
						var_316_19.gameObject:SetActive(true)
					else
						var_316_19.gameObject:SetActive(false)
					end
				end
			end

			local var_316_20 = 0.001

			if var_316_17 <= arg_313_1.time_ and arg_313_1.time_ < var_316_17 + var_316_20 then
				local var_316_21 = (arg_313_1.time_ - var_316_17) / var_316_20
				local var_316_22 = Vector3.New(0, -2000, -40)

				var_316_16.localPosition = Vector3.Lerp(arg_313_1.var_.moveOldPos1060, var_316_22, var_316_21)
			end

			if arg_313_1.time_ >= var_316_17 + var_316_20 and arg_313_1.time_ < var_316_17 + var_316_20 + arg_316_0 then
				var_316_16.localPosition = Vector3.New(0, -2000, -40)
			end

			local var_316_23 = arg_313_1.actors_["1012"].transform
			local var_316_24 = 0

			if var_316_24 < arg_313_1.time_ and arg_313_1.time_ <= var_316_24 + arg_316_0 then
				arg_313_1.var_.moveOldPos1012 = var_316_23.localPosition
				var_316_23.localScale = Vector3.New(1, 1, 1)

				arg_313_1:CheckSpriteTmpPos("1012", 7)

				local var_316_25 = var_316_23.childCount

				for iter_316_9 = 0, var_316_25 - 1 do
					local var_316_26 = var_316_23:GetChild(iter_316_9)

					if var_316_26.name == "" or not string.find(var_316_26.name, "split") then
						var_316_26.gameObject:SetActive(true)
					else
						var_316_26.gameObject:SetActive(false)
					end
				end
			end

			local var_316_27 = 0.001

			if var_316_24 <= arg_313_1.time_ and arg_313_1.time_ < var_316_24 + var_316_27 then
				local var_316_28 = (arg_313_1.time_ - var_316_24) / var_316_27
				local var_316_29 = Vector3.New(0, -2000, 300)

				var_316_23.localPosition = Vector3.Lerp(arg_313_1.var_.moveOldPos1012, var_316_29, var_316_28)
			end

			if arg_313_1.time_ >= var_316_24 + var_316_27 and arg_313_1.time_ < var_316_24 + var_316_27 + arg_316_0 then
				var_316_23.localPosition = Vector3.New(0, -2000, 300)
			end

			local var_316_30 = arg_313_1.actors_["1056"].transform
			local var_316_31 = 0

			if var_316_31 < arg_313_1.time_ and arg_313_1.time_ <= var_316_31 + arg_316_0 then
				arg_313_1.var_.moveOldPos1056 = var_316_30.localPosition
				var_316_30.localScale = Vector3.New(1, 1, 1)

				arg_313_1:CheckSpriteTmpPos("1056", 3)

				local var_316_32 = var_316_30.childCount

				for iter_316_10 = 0, var_316_32 - 1 do
					local var_316_33 = var_316_30:GetChild(iter_316_10)

					if var_316_33.name == "split_3" or not string.find(var_316_33.name, "split") then
						var_316_33.gameObject:SetActive(true)
					else
						var_316_33.gameObject:SetActive(false)
					end
				end
			end

			local var_316_34 = 0.001

			if var_316_31 <= arg_313_1.time_ and arg_313_1.time_ < var_316_31 + var_316_34 then
				local var_316_35 = (arg_313_1.time_ - var_316_31) / var_316_34
				local var_316_36 = Vector3.New(0, -350, -180)

				var_316_30.localPosition = Vector3.Lerp(arg_313_1.var_.moveOldPos1056, var_316_36, var_316_35)
			end

			if arg_313_1.time_ >= var_316_31 + var_316_34 and arg_313_1.time_ < var_316_31 + var_316_34 + arg_316_0 then
				var_316_30.localPosition = Vector3.New(0, -350, -180)
			end

			local var_316_37 = arg_313_1.actors_["1060"]
			local var_316_38 = 0

			if var_316_38 < arg_313_1.time_ and arg_313_1.time_ <= var_316_38 + arg_316_0 and not isNil(var_316_37) and arg_313_1.var_.actorSpriteComps1060 == nil then
				arg_313_1.var_.actorSpriteComps1060 = var_316_37:GetComponentsInChildren(typeof(Image), true)
			end

			local var_316_39 = 0.034

			if var_316_38 <= arg_313_1.time_ and arg_313_1.time_ < var_316_38 + var_316_39 and not isNil(var_316_37) then
				local var_316_40 = (arg_313_1.time_ - var_316_38) / var_316_39

				if arg_313_1.var_.actorSpriteComps1060 then
					for iter_316_11, iter_316_12 in pairs(arg_313_1.var_.actorSpriteComps1060:ToTable()) do
						if iter_316_12 then
							if arg_313_1.isInRecall_ then
								local var_316_41 = Mathf.Lerp(iter_316_12.color.r, arg_313_1.hightColor2.r, var_316_40)
								local var_316_42 = Mathf.Lerp(iter_316_12.color.g, arg_313_1.hightColor2.g, var_316_40)
								local var_316_43 = Mathf.Lerp(iter_316_12.color.b, arg_313_1.hightColor2.b, var_316_40)

								iter_316_12.color = Color.New(var_316_41, var_316_42, var_316_43)
							else
								local var_316_44 = Mathf.Lerp(iter_316_12.color.r, 0.5, var_316_40)

								iter_316_12.color = Color.New(var_316_44, var_316_44, var_316_44)
							end
						end
					end
				end
			end

			if arg_313_1.time_ >= var_316_38 + var_316_39 and arg_313_1.time_ < var_316_38 + var_316_39 + arg_316_0 and not isNil(var_316_37) and arg_313_1.var_.actorSpriteComps1060 then
				for iter_316_13, iter_316_14 in pairs(arg_313_1.var_.actorSpriteComps1060:ToTable()) do
					if iter_316_14 then
						if arg_313_1.isInRecall_ then
							iter_316_14.color = arg_313_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_316_14.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_313_1.var_.actorSpriteComps1060 = nil
			end

			local var_316_45 = 0
			local var_316_46 = 0.25

			if var_316_45 < arg_313_1.time_ and arg_313_1.time_ <= var_316_45 + arg_316_0 then
				arg_313_1.talkMaxDuration = 0
				arg_313_1.dialogCg_.alpha = 1

				arg_313_1.dialog_:SetActive(true)
				SetActive(arg_313_1.leftNameGo_, true)

				local var_316_47 = arg_313_1:FormatText(StoryNameCfg[605].name)

				arg_313_1.leftNameTxt_.text = var_316_47

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_313_1.leftNameTxt_.transform)

				arg_313_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_313_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_313_1:RecordName(arg_313_1.leftNameTxt_.text)
				SetActive(arg_313_1.iconTrs_.gameObject, false)
				arg_313_1.callingController_:SetSelectedState("normal")

				local var_316_48 = arg_313_1:GetWordFromCfg(410082076)
				local var_316_49 = arg_313_1:FormatText(var_316_48.content)

				arg_313_1.text_.text = var_316_49

				LuaForUtil.ClearLinePrefixSymbol(arg_313_1.text_)

				local var_316_50 = 10
				local var_316_51 = utf8.len(var_316_49)
				local var_316_52 = var_316_50 <= 0 and var_316_46 or var_316_46 * (var_316_51 / var_316_50)

				if var_316_52 > 0 and var_316_46 < var_316_52 then
					arg_313_1.talkMaxDuration = var_316_52

					if var_316_52 + var_316_45 > arg_313_1.duration_ then
						arg_313_1.duration_ = var_316_52 + var_316_45
					end
				end

				arg_313_1.text_.text = var_316_49
				arg_313_1.typewritter.percent = 0

				arg_313_1.typewritter:SetDirty()
				arg_313_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_410082", "410082076", "story_v_out_410082.awb") ~= 0 then
					local var_316_53 = manager.audio:GetVoiceLength("story_v_out_410082", "410082076", "story_v_out_410082.awb") / 1000

					if var_316_53 + var_316_45 > arg_313_1.duration_ then
						arg_313_1.duration_ = var_316_53 + var_316_45
					end

					if var_316_48.prefab_name ~= "" and arg_313_1.actors_[var_316_48.prefab_name] ~= nil then
						local var_316_54 = LuaForUtil.PlayVoiceWithCriLipsync(arg_313_1.actors_[var_316_48.prefab_name].transform, "story_v_out_410082", "410082076", "story_v_out_410082.awb")

						arg_313_1:RecordAudio("410082076", var_316_54)
						arg_313_1:RecordAudio("410082076", var_316_54)
					else
						arg_313_1:AudioAction("play", "voice", "story_v_out_410082", "410082076", "story_v_out_410082.awb")
					end

					arg_313_1:RecordHistoryTalkVoice("story_v_out_410082", "410082076", "story_v_out_410082.awb")
				end

				arg_313_1:RecordContent(arg_313_1.text_.text)
			end

			local var_316_55 = math.max(var_316_46, arg_313_1.talkMaxDuration)

			if var_316_45 <= arg_313_1.time_ and arg_313_1.time_ < var_316_45 + var_316_55 then
				arg_313_1.typewritter.percent = (arg_313_1.time_ - var_316_45) / var_316_55

				arg_313_1.typewritter:SetDirty()
			end

			if arg_313_1.time_ >= var_316_45 + var_316_55 and arg_313_1.time_ < var_316_45 + var_316_55 + arg_316_0 then
				arg_313_1.typewritter.percent = 1

				arg_313_1.typewritter:SetDirty()
				arg_313_1:ShowNextGo(true)
			end
		end

		arg_313_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1060",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			},
			{
				assetPath = "",
				actorName = "1012",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			},
			{
				assetPath = "",
				actorName = "1056",
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
	Play410082077 = function(arg_317_0, arg_317_1)
		arg_317_1.time_ = 0
		arg_317_1.frameCnt_ = 0
		arg_317_1.state_ = "playing"
		arg_317_1.curTalkId_ = 410082077
		arg_317_1.duration_ = 8.4

		local var_317_0 = {
			zh = 8.4,
			ja = 6.166
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
				arg_317_0:Play410082078(arg_317_1)
			end
		end

		function arg_317_1.onSingleLineUpdate_(arg_320_0)
			local var_320_0 = arg_317_1.actors_["1012"].transform
			local var_320_1 = 0

			if var_320_1 < arg_317_1.time_ and arg_317_1.time_ <= var_320_1 + arg_320_0 then
				arg_317_1.var_.moveOldPos1012 = var_320_0.localPosition
				var_320_0.localScale = Vector3.New(1, 1, 1)

				arg_317_1:CheckSpriteTmpPos("1012", 4)

				local var_320_2 = var_320_0.childCount

				for iter_320_0 = 0, var_320_2 - 1 do
					local var_320_3 = var_320_0:GetChild(iter_320_0)

					if var_320_3.name == "split_1" or not string.find(var_320_3.name, "split") then
						var_320_3.gameObject:SetActive(true)
					else
						var_320_3.gameObject:SetActive(false)
					end
				end
			end

			local var_320_4 = 0.001

			if var_320_1 <= arg_317_1.time_ and arg_317_1.time_ < var_320_1 + var_320_4 then
				local var_320_5 = (arg_317_1.time_ - var_320_1) / var_320_4
				local var_320_6 = Vector3.New(390, -465, 300)

				var_320_0.localPosition = Vector3.Lerp(arg_317_1.var_.moveOldPos1012, var_320_6, var_320_5)
			end

			if arg_317_1.time_ >= var_320_1 + var_320_4 and arg_317_1.time_ < var_320_1 + var_320_4 + arg_320_0 then
				var_320_0.localPosition = Vector3.New(390, -465, 300)
			end

			local var_320_7 = arg_317_1.actors_["1012"]
			local var_320_8 = 0

			if var_320_8 < arg_317_1.time_ and arg_317_1.time_ <= var_320_8 + arg_320_0 and not isNil(var_320_7) and arg_317_1.var_.actorSpriteComps1012 == nil then
				arg_317_1.var_.actorSpriteComps1012 = var_320_7:GetComponentsInChildren(typeof(Image), true)
			end

			local var_320_9 = 0.034

			if var_320_8 <= arg_317_1.time_ and arg_317_1.time_ < var_320_8 + var_320_9 and not isNil(var_320_7) then
				local var_320_10 = (arg_317_1.time_ - var_320_8) / var_320_9

				if arg_317_1.var_.actorSpriteComps1012 then
					for iter_320_1, iter_320_2 in pairs(arg_317_1.var_.actorSpriteComps1012:ToTable()) do
						if iter_320_2 then
							if arg_317_1.isInRecall_ then
								local var_320_11 = Mathf.Lerp(iter_320_2.color.r, arg_317_1.hightColor1.r, var_320_10)
								local var_320_12 = Mathf.Lerp(iter_320_2.color.g, arg_317_1.hightColor1.g, var_320_10)
								local var_320_13 = Mathf.Lerp(iter_320_2.color.b, arg_317_1.hightColor1.b, var_320_10)

								iter_320_2.color = Color.New(var_320_11, var_320_12, var_320_13)
							else
								local var_320_14 = Mathf.Lerp(iter_320_2.color.r, 1, var_320_10)

								iter_320_2.color = Color.New(var_320_14, var_320_14, var_320_14)
							end
						end
					end
				end
			end

			if arg_317_1.time_ >= var_320_8 + var_320_9 and arg_317_1.time_ < var_320_8 + var_320_9 + arg_320_0 and not isNil(var_320_7) and arg_317_1.var_.actorSpriteComps1012 then
				for iter_320_3, iter_320_4 in pairs(arg_317_1.var_.actorSpriteComps1012:ToTable()) do
					if iter_320_4 then
						if arg_317_1.isInRecall_ then
							iter_320_4.color = arg_317_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_320_4.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_317_1.var_.actorSpriteComps1012 = nil
			end

			local var_320_15 = arg_317_1.actors_["1060"]
			local var_320_16 = 0

			if var_320_16 < arg_317_1.time_ and arg_317_1.time_ <= var_320_16 + arg_320_0 and not isNil(var_320_15) and arg_317_1.var_.actorSpriteComps1060 == nil then
				arg_317_1.var_.actorSpriteComps1060 = var_320_15:GetComponentsInChildren(typeof(Image), true)
			end

			local var_320_17 = 0.034

			if var_320_16 <= arg_317_1.time_ and arg_317_1.time_ < var_320_16 + var_320_17 and not isNil(var_320_15) then
				local var_320_18 = (arg_317_1.time_ - var_320_16) / var_320_17

				if arg_317_1.var_.actorSpriteComps1060 then
					for iter_320_5, iter_320_6 in pairs(arg_317_1.var_.actorSpriteComps1060:ToTable()) do
						if iter_320_6 then
							if arg_317_1.isInRecall_ then
								local var_320_19 = Mathf.Lerp(iter_320_6.color.r, arg_317_1.hightColor2.r, var_320_18)
								local var_320_20 = Mathf.Lerp(iter_320_6.color.g, arg_317_1.hightColor2.g, var_320_18)
								local var_320_21 = Mathf.Lerp(iter_320_6.color.b, arg_317_1.hightColor2.b, var_320_18)

								iter_320_6.color = Color.New(var_320_19, var_320_20, var_320_21)
							else
								local var_320_22 = Mathf.Lerp(iter_320_6.color.r, 0.5, var_320_18)

								iter_320_6.color = Color.New(var_320_22, var_320_22, var_320_22)
							end
						end
					end
				end
			end

			if arg_317_1.time_ >= var_320_16 + var_320_17 and arg_317_1.time_ < var_320_16 + var_320_17 + arg_320_0 and not isNil(var_320_15) and arg_317_1.var_.actorSpriteComps1060 then
				for iter_320_7, iter_320_8 in pairs(arg_317_1.var_.actorSpriteComps1060:ToTable()) do
					if iter_320_8 then
						if arg_317_1.isInRecall_ then
							iter_320_8.color = arg_317_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_320_8.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_317_1.var_.actorSpriteComps1060 = nil
			end

			local var_320_23 = arg_317_1.actors_["1056"].transform
			local var_320_24 = 0

			if var_320_24 < arg_317_1.time_ and arg_317_1.time_ <= var_320_24 + arg_320_0 then
				arg_317_1.var_.moveOldPos1056 = var_320_23.localPosition
				var_320_23.localScale = Vector3.New(1, 1, 1)

				arg_317_1:CheckSpriteTmpPos("1056", 7)

				local var_320_25 = var_320_23.childCount

				for iter_320_9 = 0, var_320_25 - 1 do
					local var_320_26 = var_320_23:GetChild(iter_320_9)

					if var_320_26.name == "" or not string.find(var_320_26.name, "split") then
						var_320_26.gameObject:SetActive(true)
					else
						var_320_26.gameObject:SetActive(false)
					end
				end
			end

			local var_320_27 = 0.001

			if var_320_24 <= arg_317_1.time_ and arg_317_1.time_ < var_320_24 + var_320_27 then
				local var_320_28 = (arg_317_1.time_ - var_320_24) / var_320_27
				local var_320_29 = Vector3.New(0, -2000, -180)

				var_320_23.localPosition = Vector3.Lerp(arg_317_1.var_.moveOldPos1056, var_320_29, var_320_28)
			end

			if arg_317_1.time_ >= var_320_24 + var_320_27 and arg_317_1.time_ < var_320_24 + var_320_27 + arg_320_0 then
				var_320_23.localPosition = Vector3.New(0, -2000, -180)
			end

			local var_320_30 = arg_317_1.actors_["1060"].transform
			local var_320_31 = 0

			if var_320_31 < arg_317_1.time_ and arg_317_1.time_ <= var_320_31 + arg_320_0 then
				arg_317_1.var_.moveOldPos1060 = var_320_30.localPosition
				var_320_30.localScale = Vector3.New(1, 1, 1)

				arg_317_1:CheckSpriteTmpPos("1060", 2)

				local var_320_32 = var_320_30.childCount

				for iter_320_10 = 0, var_320_32 - 1 do
					local var_320_33 = var_320_30:GetChild(iter_320_10)

					if var_320_33.name == "split_1" or not string.find(var_320_33.name, "split") then
						var_320_33.gameObject:SetActive(true)
					else
						var_320_33.gameObject:SetActive(false)
					end
				end
			end

			local var_320_34 = 0.001

			if var_320_31 <= arg_317_1.time_ and arg_317_1.time_ < var_320_31 + var_320_34 then
				local var_320_35 = (arg_317_1.time_ - var_320_31) / var_320_34
				local var_320_36 = Vector3.New(-440.94, -430.8, 6.9)

				var_320_30.localPosition = Vector3.Lerp(arg_317_1.var_.moveOldPos1060, var_320_36, var_320_35)
			end

			if arg_317_1.time_ >= var_320_31 + var_320_34 and arg_317_1.time_ < var_320_31 + var_320_34 + arg_320_0 then
				var_320_30.localPosition = Vector3.New(-440.94, -430.8, 6.9)
			end

			local var_320_37 = 0
			local var_320_38 = 1.05

			if var_320_37 < arg_317_1.time_ and arg_317_1.time_ <= var_320_37 + arg_320_0 then
				arg_317_1.talkMaxDuration = 0
				arg_317_1.dialogCg_.alpha = 1

				arg_317_1.dialog_:SetActive(true)
				SetActive(arg_317_1.leftNameGo_, true)

				local var_320_39 = arg_317_1:FormatText(StoryNameCfg[595].name)

				arg_317_1.leftNameTxt_.text = var_320_39

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_317_1.leftNameTxt_.transform)

				arg_317_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_317_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_317_1:RecordName(arg_317_1.leftNameTxt_.text)
				SetActive(arg_317_1.iconTrs_.gameObject, false)
				arg_317_1.callingController_:SetSelectedState("normal")

				local var_320_40 = arg_317_1:GetWordFromCfg(410082077)
				local var_320_41 = arg_317_1:FormatText(var_320_40.content)

				arg_317_1.text_.text = var_320_41

				LuaForUtil.ClearLinePrefixSymbol(arg_317_1.text_)

				local var_320_42 = 42
				local var_320_43 = utf8.len(var_320_41)
				local var_320_44 = var_320_42 <= 0 and var_320_38 or var_320_38 * (var_320_43 / var_320_42)

				if var_320_44 > 0 and var_320_38 < var_320_44 then
					arg_317_1.talkMaxDuration = var_320_44

					if var_320_44 + var_320_37 > arg_317_1.duration_ then
						arg_317_1.duration_ = var_320_44 + var_320_37
					end
				end

				arg_317_1.text_.text = var_320_41
				arg_317_1.typewritter.percent = 0

				arg_317_1.typewritter:SetDirty()
				arg_317_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_410082", "410082077", "story_v_out_410082.awb") ~= 0 then
					local var_320_45 = manager.audio:GetVoiceLength("story_v_out_410082", "410082077", "story_v_out_410082.awb") / 1000

					if var_320_45 + var_320_37 > arg_317_1.duration_ then
						arg_317_1.duration_ = var_320_45 + var_320_37
					end

					if var_320_40.prefab_name ~= "" and arg_317_1.actors_[var_320_40.prefab_name] ~= nil then
						local var_320_46 = LuaForUtil.PlayVoiceWithCriLipsync(arg_317_1.actors_[var_320_40.prefab_name].transform, "story_v_out_410082", "410082077", "story_v_out_410082.awb")

						arg_317_1:RecordAudio("410082077", var_320_46)
						arg_317_1:RecordAudio("410082077", var_320_46)
					else
						arg_317_1:AudioAction("play", "voice", "story_v_out_410082", "410082077", "story_v_out_410082.awb")
					end

					arg_317_1:RecordHistoryTalkVoice("story_v_out_410082", "410082077", "story_v_out_410082.awb")
				end

				arg_317_1:RecordContent(arg_317_1.text_.text)
			end

			local var_320_47 = math.max(var_320_38, arg_317_1.talkMaxDuration)

			if var_320_37 <= arg_317_1.time_ and arg_317_1.time_ < var_320_37 + var_320_47 then
				arg_317_1.typewritter.percent = (arg_317_1.time_ - var_320_37) / var_320_47

				arg_317_1.typewritter:SetDirty()
			end

			if arg_317_1.time_ >= var_320_37 + var_320_47 and arg_317_1.time_ < var_320_37 + var_320_47 + arg_320_0 then
				arg_317_1.typewritter.percent = 1

				arg_317_1.typewritter:SetDirty()
				arg_317_1:ShowNextGo(true)
			end
		end

		arg_317_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1012",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			},
			{
				assetPath = "",
				actorName = "1056",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			},
			{
				assetPath = "",
				actorName = "1060",
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
	Play410082078 = function(arg_321_0, arg_321_1)
		arg_321_1.time_ = 0
		arg_321_1.frameCnt_ = 0
		arg_321_1.state_ = "playing"
		arg_321_1.curTalkId_ = 410082078
		arg_321_1.duration_ = 10.9

		local var_321_0 = {
			zh = 4.233,
			ja = 10.9
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
				arg_321_0:Play410082079(arg_321_1)
			end
		end

		function arg_321_1.onSingleLineUpdate_(arg_324_0)
			local var_324_0 = 0
			local var_324_1 = 0.65

			if var_324_0 < arg_321_1.time_ and arg_321_1.time_ <= var_324_0 + arg_324_0 then
				arg_321_1.talkMaxDuration = 0
				arg_321_1.dialogCg_.alpha = 1

				arg_321_1.dialog_:SetActive(true)
				SetActive(arg_321_1.leftNameGo_, true)

				local var_324_2 = arg_321_1:FormatText(StoryNameCfg[595].name)

				arg_321_1.leftNameTxt_.text = var_324_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_321_1.leftNameTxt_.transform)

				arg_321_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_321_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_321_1:RecordName(arg_321_1.leftNameTxt_.text)
				SetActive(arg_321_1.iconTrs_.gameObject, false)
				arg_321_1.callingController_:SetSelectedState("normal")

				local var_324_3 = arg_321_1:GetWordFromCfg(410082078)
				local var_324_4 = arg_321_1:FormatText(var_324_3.content)

				arg_321_1.text_.text = var_324_4

				LuaForUtil.ClearLinePrefixSymbol(arg_321_1.text_)

				local var_324_5 = 26
				local var_324_6 = utf8.len(var_324_4)
				local var_324_7 = var_324_5 <= 0 and var_324_1 or var_324_1 * (var_324_6 / var_324_5)

				if var_324_7 > 0 and var_324_1 < var_324_7 then
					arg_321_1.talkMaxDuration = var_324_7

					if var_324_7 + var_324_0 > arg_321_1.duration_ then
						arg_321_1.duration_ = var_324_7 + var_324_0
					end
				end

				arg_321_1.text_.text = var_324_4
				arg_321_1.typewritter.percent = 0

				arg_321_1.typewritter:SetDirty()
				arg_321_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_410082", "410082078", "story_v_out_410082.awb") ~= 0 then
					local var_324_8 = manager.audio:GetVoiceLength("story_v_out_410082", "410082078", "story_v_out_410082.awb") / 1000

					if var_324_8 + var_324_0 > arg_321_1.duration_ then
						arg_321_1.duration_ = var_324_8 + var_324_0
					end

					if var_324_3.prefab_name ~= "" and arg_321_1.actors_[var_324_3.prefab_name] ~= nil then
						local var_324_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_321_1.actors_[var_324_3.prefab_name].transform, "story_v_out_410082", "410082078", "story_v_out_410082.awb")

						arg_321_1:RecordAudio("410082078", var_324_9)
						arg_321_1:RecordAudio("410082078", var_324_9)
					else
						arg_321_1:AudioAction("play", "voice", "story_v_out_410082", "410082078", "story_v_out_410082.awb")
					end

					arg_321_1:RecordHistoryTalkVoice("story_v_out_410082", "410082078", "story_v_out_410082.awb")
				end

				arg_321_1:RecordContent(arg_321_1.text_.text)
			end

			local var_324_10 = math.max(var_324_1, arg_321_1.talkMaxDuration)

			if var_324_0 <= arg_321_1.time_ and arg_321_1.time_ < var_324_0 + var_324_10 then
				arg_321_1.typewritter.percent = (arg_321_1.time_ - var_324_0) / var_324_10

				arg_321_1.typewritter:SetDirty()
			end

			if arg_321_1.time_ >= var_324_0 + var_324_10 and arg_321_1.time_ < var_324_0 + var_324_10 + arg_324_0 then
				arg_321_1.typewritter.percent = 1

				arg_321_1.typewritter:SetDirty()
				arg_321_1:ShowNextGo(true)
			end
		end

		arg_321_1.nodeConfigList_ = {}

		arg_321_1:InitPlayNodeList()
	end,
	Play410082079 = function(arg_325_0, arg_325_1)
		arg_325_1.time_ = 0
		arg_325_1.frameCnt_ = 0
		arg_325_1.state_ = "playing"
		arg_325_1.curTalkId_ = 410082079
		arg_325_1.duration_ = 5

		SetActive(arg_325_1.tipsGo_, false)

		function arg_325_1.onSingleLineFinish_()
			arg_325_1.onSingleLineUpdate_ = nil
			arg_325_1.onSingleLineFinish_ = nil
			arg_325_1.state_ = "waiting"
		end

		function arg_325_1.playNext_(arg_327_0)
			if arg_327_0 == 1 then
				arg_325_0:Play410082080(arg_325_1)
			end
		end

		function arg_325_1.onSingleLineUpdate_(arg_328_0)
			local var_328_0 = arg_325_1.actors_["1060"].transform
			local var_328_1 = 0

			if var_328_1 < arg_325_1.time_ and arg_325_1.time_ <= var_328_1 + arg_328_0 then
				arg_325_1.var_.moveOldPos1060 = var_328_0.localPosition
				var_328_0.localScale = Vector3.New(1, 1, 1)

				arg_325_1:CheckSpriteTmpPos("1060", 7)

				local var_328_2 = var_328_0.childCount

				for iter_328_0 = 0, var_328_2 - 1 do
					local var_328_3 = var_328_0:GetChild(iter_328_0)

					if var_328_3.name == "" or not string.find(var_328_3.name, "split") then
						var_328_3.gameObject:SetActive(true)
					else
						var_328_3.gameObject:SetActive(false)
					end
				end
			end

			local var_328_4 = 0.001

			if var_328_1 <= arg_325_1.time_ and arg_325_1.time_ < var_328_1 + var_328_4 then
				local var_328_5 = (arg_325_1.time_ - var_328_1) / var_328_4
				local var_328_6 = Vector3.New(0, -2000, -40)

				var_328_0.localPosition = Vector3.Lerp(arg_325_1.var_.moveOldPos1060, var_328_6, var_328_5)
			end

			if arg_325_1.time_ >= var_328_1 + var_328_4 and arg_325_1.time_ < var_328_1 + var_328_4 + arg_328_0 then
				var_328_0.localPosition = Vector3.New(0, -2000, -40)
			end

			local var_328_7 = arg_325_1.actors_["1056"].transform
			local var_328_8 = 0

			if var_328_8 < arg_325_1.time_ and arg_325_1.time_ <= var_328_8 + arg_328_0 then
				arg_325_1.var_.moveOldPos1056 = var_328_7.localPosition
				var_328_7.localScale = Vector3.New(1, 1, 1)

				arg_325_1:CheckSpriteTmpPos("1056", 7)

				local var_328_9 = var_328_7.childCount

				for iter_328_1 = 0, var_328_9 - 1 do
					local var_328_10 = var_328_7:GetChild(iter_328_1)

					if var_328_10.name == "" or not string.find(var_328_10.name, "split") then
						var_328_10.gameObject:SetActive(true)
					else
						var_328_10.gameObject:SetActive(false)
					end
				end
			end

			local var_328_11 = 0.001

			if var_328_8 <= arg_325_1.time_ and arg_325_1.time_ < var_328_8 + var_328_11 then
				local var_328_12 = (arg_325_1.time_ - var_328_8) / var_328_11
				local var_328_13 = Vector3.New(0, -2000, -180)

				var_328_7.localPosition = Vector3.Lerp(arg_325_1.var_.moveOldPos1056, var_328_13, var_328_12)
			end

			if arg_325_1.time_ >= var_328_8 + var_328_11 and arg_325_1.time_ < var_328_8 + var_328_11 + arg_328_0 then
				var_328_7.localPosition = Vector3.New(0, -2000, -180)
			end

			local var_328_14 = arg_325_1.actors_["1012"].transform
			local var_328_15 = 0

			if var_328_15 < arg_325_1.time_ and arg_325_1.time_ <= var_328_15 + arg_328_0 then
				arg_325_1.var_.moveOldPos1012 = var_328_14.localPosition
				var_328_14.localScale = Vector3.New(1, 1, 1)

				arg_325_1:CheckSpriteTmpPos("1012", 7)

				local var_328_16 = var_328_14.childCount

				for iter_328_2 = 0, var_328_16 - 1 do
					local var_328_17 = var_328_14:GetChild(iter_328_2)

					if var_328_17.name == "" or not string.find(var_328_17.name, "split") then
						var_328_17.gameObject:SetActive(true)
					else
						var_328_17.gameObject:SetActive(false)
					end
				end
			end

			local var_328_18 = 0.001

			if var_328_15 <= arg_325_1.time_ and arg_325_1.time_ < var_328_15 + var_328_18 then
				local var_328_19 = (arg_325_1.time_ - var_328_15) / var_328_18
				local var_328_20 = Vector3.New(0, -2000, 300)

				var_328_14.localPosition = Vector3.Lerp(arg_325_1.var_.moveOldPos1012, var_328_20, var_328_19)
			end

			if arg_325_1.time_ >= var_328_15 + var_328_18 and arg_325_1.time_ < var_328_15 + var_328_18 + arg_328_0 then
				var_328_14.localPosition = Vector3.New(0, -2000, 300)
			end

			local var_328_21 = 0
			local var_328_22 = 0.975

			if var_328_21 < arg_325_1.time_ and arg_325_1.time_ <= var_328_21 + arg_328_0 then
				arg_325_1.talkMaxDuration = 0
				arg_325_1.dialogCg_.alpha = 1

				arg_325_1.dialog_:SetActive(true)
				SetActive(arg_325_1.leftNameGo_, false)

				arg_325_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_325_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_325_1:RecordName(arg_325_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_325_1.iconTrs_.gameObject, false)
				arg_325_1.callingController_:SetSelectedState("normal")

				local var_328_23 = arg_325_1:GetWordFromCfg(410082079)
				local var_328_24 = arg_325_1:FormatText(var_328_23.content)

				arg_325_1.text_.text = var_328_24

				LuaForUtil.ClearLinePrefixSymbol(arg_325_1.text_)

				local var_328_25 = 39
				local var_328_26 = utf8.len(var_328_24)
				local var_328_27 = var_328_25 <= 0 and var_328_22 or var_328_22 * (var_328_26 / var_328_25)

				if var_328_27 > 0 and var_328_22 < var_328_27 then
					arg_325_1.talkMaxDuration = var_328_27

					if var_328_27 + var_328_21 > arg_325_1.duration_ then
						arg_325_1.duration_ = var_328_27 + var_328_21
					end
				end

				arg_325_1.text_.text = var_328_24
				arg_325_1.typewritter.percent = 0

				arg_325_1.typewritter:SetDirty()
				arg_325_1:ShowNextGo(false)
				arg_325_1:RecordContent(arg_325_1.text_.text)
			end

			local var_328_28 = math.max(var_328_22, arg_325_1.talkMaxDuration)

			if var_328_21 <= arg_325_1.time_ and arg_325_1.time_ < var_328_21 + var_328_28 then
				arg_325_1.typewritter.percent = (arg_325_1.time_ - var_328_21) / var_328_28

				arg_325_1.typewritter:SetDirty()
			end

			if arg_325_1.time_ >= var_328_21 + var_328_28 and arg_325_1.time_ < var_328_21 + var_328_28 + arg_328_0 then
				arg_325_1.typewritter.percent = 1

				arg_325_1.typewritter:SetDirty()
				arg_325_1:ShowNextGo(true)
			end
		end

		arg_325_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1060",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			},
			{
				assetPath = "",
				actorName = "1056",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			},
			{
				assetPath = "",
				actorName = "1012",
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
	Play410082080 = function(arg_329_0, arg_329_1)
		arg_329_1.time_ = 0
		arg_329_1.frameCnt_ = 0
		arg_329_1.state_ = "playing"
		arg_329_1.curTalkId_ = 410082080
		arg_329_1.duration_ = 5

		SetActive(arg_329_1.tipsGo_, false)

		function arg_329_1.onSingleLineFinish_()
			arg_329_1.onSingleLineUpdate_ = nil
			arg_329_1.onSingleLineFinish_ = nil
			arg_329_1.state_ = "waiting"
		end

		function arg_329_1.playNext_(arg_331_0)
			if arg_331_0 == 1 then
				arg_329_0:Play410082081(arg_329_1)
			end
		end

		function arg_329_1.onSingleLineUpdate_(arg_332_0)
			local var_332_0 = 0
			local var_332_1 = 1.725

			if var_332_0 < arg_329_1.time_ and arg_329_1.time_ <= var_332_0 + arg_332_0 then
				arg_329_1.talkMaxDuration = 0
				arg_329_1.dialogCg_.alpha = 1

				arg_329_1.dialog_:SetActive(true)
				SetActive(arg_329_1.leftNameGo_, false)

				arg_329_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_329_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_329_1:RecordName(arg_329_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_329_1.iconTrs_.gameObject, false)
				arg_329_1.callingController_:SetSelectedState("normal")

				local var_332_2 = arg_329_1:GetWordFromCfg(410082080)
				local var_332_3 = arg_329_1:FormatText(var_332_2.content)

				arg_329_1.text_.text = var_332_3

				LuaForUtil.ClearLinePrefixSymbol(arg_329_1.text_)

				local var_332_4 = 69
				local var_332_5 = utf8.len(var_332_3)
				local var_332_6 = var_332_4 <= 0 and var_332_1 or var_332_1 * (var_332_5 / var_332_4)

				if var_332_6 > 0 and var_332_1 < var_332_6 then
					arg_329_1.talkMaxDuration = var_332_6

					if var_332_6 + var_332_0 > arg_329_1.duration_ then
						arg_329_1.duration_ = var_332_6 + var_332_0
					end
				end

				arg_329_1.text_.text = var_332_3
				arg_329_1.typewritter.percent = 0

				arg_329_1.typewritter:SetDirty()
				arg_329_1:ShowNextGo(false)
				arg_329_1:RecordContent(arg_329_1.text_.text)
			end

			local var_332_7 = math.max(var_332_1, arg_329_1.talkMaxDuration)

			if var_332_0 <= arg_329_1.time_ and arg_329_1.time_ < var_332_0 + var_332_7 then
				arg_329_1.typewritter.percent = (arg_329_1.time_ - var_332_0) / var_332_7

				arg_329_1.typewritter:SetDirty()
			end

			if arg_329_1.time_ >= var_332_0 + var_332_7 and arg_329_1.time_ < var_332_0 + var_332_7 + arg_332_0 then
				arg_329_1.typewritter.percent = 1

				arg_329_1.typewritter:SetDirty()
				arg_329_1:ShowNextGo(true)
			end
		end

		arg_329_1.nodeConfigList_ = {}

		arg_329_1:InitPlayNodeList()
	end,
	Play410082081 = function(arg_333_0, arg_333_1)
		arg_333_1.time_ = 0
		arg_333_1.frameCnt_ = 0
		arg_333_1.state_ = "playing"
		arg_333_1.curTalkId_ = 410082081
		arg_333_1.duration_ = 9.1

		local var_333_0 = {
			zh = 4.8,
			ja = 9.1
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
				arg_333_0:Play410082082(arg_333_1)
			end
		end

		function arg_333_1.onSingleLineUpdate_(arg_336_0)
			local var_336_0 = arg_333_1.actors_["1012"].transform
			local var_336_1 = 0

			if var_336_1 < arg_333_1.time_ and arg_333_1.time_ <= var_336_1 + arg_336_0 then
				arg_333_1.var_.moveOldPos1012 = var_336_0.localPosition
				var_336_0.localScale = Vector3.New(1, 1, 1)

				arg_333_1:CheckSpriteTmpPos("1012", 4)

				local var_336_2 = var_336_0.childCount

				for iter_336_0 = 0, var_336_2 - 1 do
					local var_336_3 = var_336_0:GetChild(iter_336_0)

					if var_336_3.name == "split_3" or not string.find(var_336_3.name, "split") then
						var_336_3.gameObject:SetActive(true)
					else
						var_336_3.gameObject:SetActive(false)
					end
				end
			end

			local var_336_4 = 0.001

			if var_336_1 <= arg_333_1.time_ and arg_333_1.time_ < var_336_1 + var_336_4 then
				local var_336_5 = (arg_333_1.time_ - var_336_1) / var_336_4
				local var_336_6 = Vector3.New(390, -465, 300)

				var_336_0.localPosition = Vector3.Lerp(arg_333_1.var_.moveOldPos1012, var_336_6, var_336_5)
			end

			if arg_333_1.time_ >= var_336_1 + var_336_4 and arg_333_1.time_ < var_336_1 + var_336_4 + arg_336_0 then
				var_336_0.localPosition = Vector3.New(390, -465, 300)
			end

			local var_336_7 = arg_333_1.actors_["1012"]
			local var_336_8 = 0

			if var_336_8 < arg_333_1.time_ and arg_333_1.time_ <= var_336_8 + arg_336_0 and not isNil(var_336_7) and arg_333_1.var_.actorSpriteComps1012 == nil then
				arg_333_1.var_.actorSpriteComps1012 = var_336_7:GetComponentsInChildren(typeof(Image), true)
			end

			local var_336_9 = 0.034

			if var_336_8 <= arg_333_1.time_ and arg_333_1.time_ < var_336_8 + var_336_9 and not isNil(var_336_7) then
				local var_336_10 = (arg_333_1.time_ - var_336_8) / var_336_9

				if arg_333_1.var_.actorSpriteComps1012 then
					for iter_336_1, iter_336_2 in pairs(arg_333_1.var_.actorSpriteComps1012:ToTable()) do
						if iter_336_2 then
							if arg_333_1.isInRecall_ then
								local var_336_11 = Mathf.Lerp(iter_336_2.color.r, arg_333_1.hightColor1.r, var_336_10)
								local var_336_12 = Mathf.Lerp(iter_336_2.color.g, arg_333_1.hightColor1.g, var_336_10)
								local var_336_13 = Mathf.Lerp(iter_336_2.color.b, arg_333_1.hightColor1.b, var_336_10)

								iter_336_2.color = Color.New(var_336_11, var_336_12, var_336_13)
							else
								local var_336_14 = Mathf.Lerp(iter_336_2.color.r, 1, var_336_10)

								iter_336_2.color = Color.New(var_336_14, var_336_14, var_336_14)
							end
						end
					end
				end
			end

			if arg_333_1.time_ >= var_336_8 + var_336_9 and arg_333_1.time_ < var_336_8 + var_336_9 + arg_336_0 and not isNil(var_336_7) and arg_333_1.var_.actorSpriteComps1012 then
				for iter_336_3, iter_336_4 in pairs(arg_333_1.var_.actorSpriteComps1012:ToTable()) do
					if iter_336_4 then
						if arg_333_1.isInRecall_ then
							iter_336_4.color = arg_333_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_336_4.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_333_1.var_.actorSpriteComps1012 = nil
			end

			local var_336_15 = arg_333_1.actors_["1060"].transform
			local var_336_16 = 0

			if var_336_16 < arg_333_1.time_ and arg_333_1.time_ <= var_336_16 + arg_336_0 then
				arg_333_1.var_.moveOldPos1060 = var_336_15.localPosition
				var_336_15.localScale = Vector3.New(1, 1, 1)

				arg_333_1:CheckSpriteTmpPos("1060", 2)

				local var_336_17 = var_336_15.childCount

				for iter_336_5 = 0, var_336_17 - 1 do
					local var_336_18 = var_336_15:GetChild(iter_336_5)

					if var_336_18.name == "" or not string.find(var_336_18.name, "split") then
						var_336_18.gameObject:SetActive(true)
					else
						var_336_18.gameObject:SetActive(false)
					end
				end
			end

			local var_336_19 = 0.001

			if var_336_16 <= arg_333_1.time_ and arg_333_1.time_ < var_336_16 + var_336_19 then
				local var_336_20 = (arg_333_1.time_ - var_336_16) / var_336_19
				local var_336_21 = Vector3.New(-440.94, -430.8, 6.9)

				var_336_15.localPosition = Vector3.Lerp(arg_333_1.var_.moveOldPos1060, var_336_21, var_336_20)
			end

			if arg_333_1.time_ >= var_336_16 + var_336_19 and arg_333_1.time_ < var_336_16 + var_336_19 + arg_336_0 then
				var_336_15.localPosition = Vector3.New(-440.94, -430.8, 6.9)
			end

			local var_336_22 = arg_333_1.actors_["1060"]
			local var_336_23 = 0

			if var_336_23 < arg_333_1.time_ and arg_333_1.time_ <= var_336_23 + arg_336_0 and not isNil(var_336_22) and arg_333_1.var_.actorSpriteComps1060 == nil then
				arg_333_1.var_.actorSpriteComps1060 = var_336_22:GetComponentsInChildren(typeof(Image), true)
			end

			local var_336_24 = 0.034

			if var_336_23 <= arg_333_1.time_ and arg_333_1.time_ < var_336_23 + var_336_24 and not isNil(var_336_22) then
				local var_336_25 = (arg_333_1.time_ - var_336_23) / var_336_24

				if arg_333_1.var_.actorSpriteComps1060 then
					for iter_336_6, iter_336_7 in pairs(arg_333_1.var_.actorSpriteComps1060:ToTable()) do
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

			if arg_333_1.time_ >= var_336_23 + var_336_24 and arg_333_1.time_ < var_336_23 + var_336_24 + arg_336_0 and not isNil(var_336_22) and arg_333_1.var_.actorSpriteComps1060 then
				for iter_336_8, iter_336_9 in pairs(arg_333_1.var_.actorSpriteComps1060:ToTable()) do
					if iter_336_9 then
						if arg_333_1.isInRecall_ then
							iter_336_9.color = arg_333_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_336_9.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_333_1.var_.actorSpriteComps1060 = nil
			end

			local var_336_30 = 0
			local var_336_31 = 0.45

			if var_336_30 < arg_333_1.time_ and arg_333_1.time_ <= var_336_30 + arg_336_0 then
				arg_333_1.talkMaxDuration = 0
				arg_333_1.dialogCg_.alpha = 1

				arg_333_1.dialog_:SetActive(true)
				SetActive(arg_333_1.leftNameGo_, true)

				local var_336_32 = arg_333_1:FormatText(StoryNameCfg[595].name)

				arg_333_1.leftNameTxt_.text = var_336_32

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_333_1.leftNameTxt_.transform)

				arg_333_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_333_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_333_1:RecordName(arg_333_1.leftNameTxt_.text)
				SetActive(arg_333_1.iconTrs_.gameObject, false)
				arg_333_1.callingController_:SetSelectedState("normal")

				local var_336_33 = arg_333_1:GetWordFromCfg(410082081)
				local var_336_34 = arg_333_1:FormatText(var_336_33.content)

				arg_333_1.text_.text = var_336_34

				LuaForUtil.ClearLinePrefixSymbol(arg_333_1.text_)

				local var_336_35 = 18
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

				if manager.audio:GetVoiceLength("story_v_out_410082", "410082081", "story_v_out_410082.awb") ~= 0 then
					local var_336_38 = manager.audio:GetVoiceLength("story_v_out_410082", "410082081", "story_v_out_410082.awb") / 1000

					if var_336_38 + var_336_30 > arg_333_1.duration_ then
						arg_333_1.duration_ = var_336_38 + var_336_30
					end

					if var_336_33.prefab_name ~= "" and arg_333_1.actors_[var_336_33.prefab_name] ~= nil then
						local var_336_39 = LuaForUtil.PlayVoiceWithCriLipsync(arg_333_1.actors_[var_336_33.prefab_name].transform, "story_v_out_410082", "410082081", "story_v_out_410082.awb")

						arg_333_1:RecordAudio("410082081", var_336_39)
						arg_333_1:RecordAudio("410082081", var_336_39)
					else
						arg_333_1:AudioAction("play", "voice", "story_v_out_410082", "410082081", "story_v_out_410082.awb")
					end

					arg_333_1:RecordHistoryTalkVoice("story_v_out_410082", "410082081", "story_v_out_410082.awb")
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
				actorName = "1012",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			},
			{
				assetPath = "",
				actorName = "1060",
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
	Play410082082 = function(arg_337_0, arg_337_1)
		arg_337_1.time_ = 0
		arg_337_1.frameCnt_ = 0
		arg_337_1.state_ = "playing"
		arg_337_1.curTalkId_ = 410082082
		arg_337_1.duration_ = 8.6

		local var_337_0 = {
			zh = 5.666,
			ja = 8.6
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
				arg_337_0:Play410082083(arg_337_1)
			end
		end

		function arg_337_1.onSingleLineUpdate_(arg_340_0)
			local var_340_0 = arg_337_1.actors_["1060"].transform
			local var_340_1 = 0

			if var_340_1 < arg_337_1.time_ and arg_337_1.time_ <= var_340_1 + arg_340_0 then
				arg_337_1.var_.moveOldPos1060 = var_340_0.localPosition
				var_340_0.localScale = Vector3.New(1, 1, 1)

				arg_337_1:CheckSpriteTmpPos("1060", 2)

				local var_340_2 = var_340_0.childCount

				for iter_340_0 = 0, var_340_2 - 1 do
					local var_340_3 = var_340_0:GetChild(iter_340_0)

					if var_340_3.name == "" or not string.find(var_340_3.name, "split") then
						var_340_3.gameObject:SetActive(true)
					else
						var_340_3.gameObject:SetActive(false)
					end
				end
			end

			local var_340_4 = 0.001

			if var_340_1 <= arg_337_1.time_ and arg_337_1.time_ < var_340_1 + var_340_4 then
				local var_340_5 = (arg_337_1.time_ - var_340_1) / var_340_4
				local var_340_6 = Vector3.New(-440.94, -430.8, 6.9)

				var_340_0.localPosition = Vector3.Lerp(arg_337_1.var_.moveOldPos1060, var_340_6, var_340_5)
			end

			if arg_337_1.time_ >= var_340_1 + var_340_4 and arg_337_1.time_ < var_340_1 + var_340_4 + arg_340_0 then
				var_340_0.localPosition = Vector3.New(-440.94, -430.8, 6.9)
			end

			local var_340_7 = arg_337_1.actors_["1060"]
			local var_340_8 = 0

			if var_340_8 < arg_337_1.time_ and arg_337_1.time_ <= var_340_8 + arg_340_0 and not isNil(var_340_7) and arg_337_1.var_.actorSpriteComps1060 == nil then
				arg_337_1.var_.actorSpriteComps1060 = var_340_7:GetComponentsInChildren(typeof(Image), true)
			end

			local var_340_9 = 0.034

			if var_340_8 <= arg_337_1.time_ and arg_337_1.time_ < var_340_8 + var_340_9 and not isNil(var_340_7) then
				local var_340_10 = (arg_337_1.time_ - var_340_8) / var_340_9

				if arg_337_1.var_.actorSpriteComps1060 then
					for iter_340_1, iter_340_2 in pairs(arg_337_1.var_.actorSpriteComps1060:ToTable()) do
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

			if arg_337_1.time_ >= var_340_8 + var_340_9 and arg_337_1.time_ < var_340_8 + var_340_9 + arg_340_0 and not isNil(var_340_7) and arg_337_1.var_.actorSpriteComps1060 then
				for iter_340_3, iter_340_4 in pairs(arg_337_1.var_.actorSpriteComps1060:ToTable()) do
					if iter_340_4 then
						if arg_337_1.isInRecall_ then
							iter_340_4.color = arg_337_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_340_4.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_337_1.var_.actorSpriteComps1060 = nil
			end

			local var_340_15 = arg_337_1.actors_["1012"]
			local var_340_16 = 0

			if var_340_16 < arg_337_1.time_ and arg_337_1.time_ <= var_340_16 + arg_340_0 and not isNil(var_340_15) and arg_337_1.var_.actorSpriteComps1012 == nil then
				arg_337_1.var_.actorSpriteComps1012 = var_340_15:GetComponentsInChildren(typeof(Image), true)
			end

			local var_340_17 = 0.034

			if var_340_16 <= arg_337_1.time_ and arg_337_1.time_ < var_340_16 + var_340_17 and not isNil(var_340_15) then
				local var_340_18 = (arg_337_1.time_ - var_340_16) / var_340_17

				if arg_337_1.var_.actorSpriteComps1012 then
					for iter_340_5, iter_340_6 in pairs(arg_337_1.var_.actorSpriteComps1012:ToTable()) do
						if iter_340_6 then
							if arg_337_1.isInRecall_ then
								local var_340_19 = Mathf.Lerp(iter_340_6.color.r, arg_337_1.hightColor2.r, var_340_18)
								local var_340_20 = Mathf.Lerp(iter_340_6.color.g, arg_337_1.hightColor2.g, var_340_18)
								local var_340_21 = Mathf.Lerp(iter_340_6.color.b, arg_337_1.hightColor2.b, var_340_18)

								iter_340_6.color = Color.New(var_340_19, var_340_20, var_340_21)
							else
								local var_340_22 = Mathf.Lerp(iter_340_6.color.r, 0.5, var_340_18)

								iter_340_6.color = Color.New(var_340_22, var_340_22, var_340_22)
							end
						end
					end
				end
			end

			if arg_337_1.time_ >= var_340_16 + var_340_17 and arg_337_1.time_ < var_340_16 + var_340_17 + arg_340_0 and not isNil(var_340_15) and arg_337_1.var_.actorSpriteComps1012 then
				for iter_340_7, iter_340_8 in pairs(arg_337_1.var_.actorSpriteComps1012:ToTable()) do
					if iter_340_8 then
						if arg_337_1.isInRecall_ then
							iter_340_8.color = arg_337_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_340_8.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_337_1.var_.actorSpriteComps1012 = nil
			end

			local var_340_23 = 0
			local var_340_24 = 0.7

			if var_340_23 < arg_337_1.time_ and arg_337_1.time_ <= var_340_23 + arg_340_0 then
				arg_337_1.talkMaxDuration = 0
				arg_337_1.dialogCg_.alpha = 1

				arg_337_1.dialog_:SetActive(true)
				SetActive(arg_337_1.leftNameGo_, true)

				local var_340_25 = arg_337_1:FormatText(StoryNameCfg[584].name)

				arg_337_1.leftNameTxt_.text = var_340_25

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_337_1.leftNameTxt_.transform)

				arg_337_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_337_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_337_1:RecordName(arg_337_1.leftNameTxt_.text)
				SetActive(arg_337_1.iconTrs_.gameObject, false)
				arg_337_1.callingController_:SetSelectedState("normal")

				local var_340_26 = arg_337_1:GetWordFromCfg(410082082)
				local var_340_27 = arg_337_1:FormatText(var_340_26.content)

				arg_337_1.text_.text = var_340_27

				LuaForUtil.ClearLinePrefixSymbol(arg_337_1.text_)

				local var_340_28 = 28
				local var_340_29 = utf8.len(var_340_27)
				local var_340_30 = var_340_28 <= 0 and var_340_24 or var_340_24 * (var_340_29 / var_340_28)

				if var_340_30 > 0 and var_340_24 < var_340_30 then
					arg_337_1.talkMaxDuration = var_340_30

					if var_340_30 + var_340_23 > arg_337_1.duration_ then
						arg_337_1.duration_ = var_340_30 + var_340_23
					end
				end

				arg_337_1.text_.text = var_340_27
				arg_337_1.typewritter.percent = 0

				arg_337_1.typewritter:SetDirty()
				arg_337_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_410082", "410082082", "story_v_out_410082.awb") ~= 0 then
					local var_340_31 = manager.audio:GetVoiceLength("story_v_out_410082", "410082082", "story_v_out_410082.awb") / 1000

					if var_340_31 + var_340_23 > arg_337_1.duration_ then
						arg_337_1.duration_ = var_340_31 + var_340_23
					end

					if var_340_26.prefab_name ~= "" and arg_337_1.actors_[var_340_26.prefab_name] ~= nil then
						local var_340_32 = LuaForUtil.PlayVoiceWithCriLipsync(arg_337_1.actors_[var_340_26.prefab_name].transform, "story_v_out_410082", "410082082", "story_v_out_410082.awb")

						arg_337_1:RecordAudio("410082082", var_340_32)
						arg_337_1:RecordAudio("410082082", var_340_32)
					else
						arg_337_1:AudioAction("play", "voice", "story_v_out_410082", "410082082", "story_v_out_410082.awb")
					end

					arg_337_1:RecordHistoryTalkVoice("story_v_out_410082", "410082082", "story_v_out_410082.awb")
				end

				arg_337_1:RecordContent(arg_337_1.text_.text)
			end

			local var_340_33 = math.max(var_340_24, arg_337_1.talkMaxDuration)

			if var_340_23 <= arg_337_1.time_ and arg_337_1.time_ < var_340_23 + var_340_33 then
				arg_337_1.typewritter.percent = (arg_337_1.time_ - var_340_23) / var_340_33

				arg_337_1.typewritter:SetDirty()
			end

			if arg_337_1.time_ >= var_340_23 + var_340_33 and arg_337_1.time_ < var_340_23 + var_340_33 + arg_340_0 then
				arg_337_1.typewritter.percent = 1

				arg_337_1.typewritter:SetDirty()
				arg_337_1:ShowNextGo(true)
			end
		end

		arg_337_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1060",
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
	Play410082083 = function(arg_341_0, arg_341_1)
		arg_341_1.time_ = 0
		arg_341_1.frameCnt_ = 0
		arg_341_1.state_ = "playing"
		arg_341_1.curTalkId_ = 410082083
		arg_341_1.duration_ = 4.07

		local var_341_0 = {
			zh = 4.066,
			ja = 3.133
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
				arg_341_0:Play410082084(arg_341_1)
			end
		end

		function arg_341_1.onSingleLineUpdate_(arg_344_0)
			local var_344_0 = arg_341_1.actors_["1012"].transform
			local var_344_1 = 0

			if var_344_1 < arg_341_1.time_ and arg_341_1.time_ <= var_344_1 + arg_344_0 then
				arg_341_1.var_.moveOldPos1012 = var_344_0.localPosition
				var_344_0.localScale = Vector3.New(1, 1, 1)

				arg_341_1:CheckSpriteTmpPos("1012", 4)

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
				local var_344_6 = Vector3.New(390, -465, 300)

				var_344_0.localPosition = Vector3.Lerp(arg_341_1.var_.moveOldPos1012, var_344_6, var_344_5)
			end

			if arg_341_1.time_ >= var_344_1 + var_344_4 and arg_341_1.time_ < var_344_1 + var_344_4 + arg_344_0 then
				var_344_0.localPosition = Vector3.New(390, -465, 300)
			end

			local var_344_7 = arg_341_1.actors_["1012"]
			local var_344_8 = 0

			if var_344_8 < arg_341_1.time_ and arg_341_1.time_ <= var_344_8 + arg_344_0 and not isNil(var_344_7) and arg_341_1.var_.actorSpriteComps1012 == nil then
				arg_341_1.var_.actorSpriteComps1012 = var_344_7:GetComponentsInChildren(typeof(Image), true)
			end

			local var_344_9 = 0.034

			if var_344_8 <= arg_341_1.time_ and arg_341_1.time_ < var_344_8 + var_344_9 and not isNil(var_344_7) then
				local var_344_10 = (arg_341_1.time_ - var_344_8) / var_344_9

				if arg_341_1.var_.actorSpriteComps1012 then
					for iter_344_1, iter_344_2 in pairs(arg_341_1.var_.actorSpriteComps1012:ToTable()) do
						if iter_344_2 then
							if arg_341_1.isInRecall_ then
								local var_344_11 = Mathf.Lerp(iter_344_2.color.r, arg_341_1.hightColor1.r, var_344_10)
								local var_344_12 = Mathf.Lerp(iter_344_2.color.g, arg_341_1.hightColor1.g, var_344_10)
								local var_344_13 = Mathf.Lerp(iter_344_2.color.b, arg_341_1.hightColor1.b, var_344_10)

								iter_344_2.color = Color.New(var_344_11, var_344_12, var_344_13)
							else
								local var_344_14 = Mathf.Lerp(iter_344_2.color.r, 1, var_344_10)

								iter_344_2.color = Color.New(var_344_14, var_344_14, var_344_14)
							end
						end
					end
				end
			end

			if arg_341_1.time_ >= var_344_8 + var_344_9 and arg_341_1.time_ < var_344_8 + var_344_9 + arg_344_0 and not isNil(var_344_7) and arg_341_1.var_.actorSpriteComps1012 then
				for iter_344_3, iter_344_4 in pairs(arg_341_1.var_.actorSpriteComps1012:ToTable()) do
					if iter_344_4 then
						if arg_341_1.isInRecall_ then
							iter_344_4.color = arg_341_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_344_4.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_341_1.var_.actorSpriteComps1012 = nil
			end

			local var_344_15 = arg_341_1.actors_["1060"]
			local var_344_16 = 0

			if var_344_16 < arg_341_1.time_ and arg_341_1.time_ <= var_344_16 + arg_344_0 and not isNil(var_344_15) and arg_341_1.var_.actorSpriteComps1060 == nil then
				arg_341_1.var_.actorSpriteComps1060 = var_344_15:GetComponentsInChildren(typeof(Image), true)
			end

			local var_344_17 = 0.034

			if var_344_16 <= arg_341_1.time_ and arg_341_1.time_ < var_344_16 + var_344_17 and not isNil(var_344_15) then
				local var_344_18 = (arg_341_1.time_ - var_344_16) / var_344_17

				if arg_341_1.var_.actorSpriteComps1060 then
					for iter_344_5, iter_344_6 in pairs(arg_341_1.var_.actorSpriteComps1060:ToTable()) do
						if iter_344_6 then
							if arg_341_1.isInRecall_ then
								local var_344_19 = Mathf.Lerp(iter_344_6.color.r, arg_341_1.hightColor2.r, var_344_18)
								local var_344_20 = Mathf.Lerp(iter_344_6.color.g, arg_341_1.hightColor2.g, var_344_18)
								local var_344_21 = Mathf.Lerp(iter_344_6.color.b, arg_341_1.hightColor2.b, var_344_18)

								iter_344_6.color = Color.New(var_344_19, var_344_20, var_344_21)
							else
								local var_344_22 = Mathf.Lerp(iter_344_6.color.r, 0.5, var_344_18)

								iter_344_6.color = Color.New(var_344_22, var_344_22, var_344_22)
							end
						end
					end
				end
			end

			if arg_341_1.time_ >= var_344_16 + var_344_17 and arg_341_1.time_ < var_344_16 + var_344_17 + arg_344_0 and not isNil(var_344_15) and arg_341_1.var_.actorSpriteComps1060 then
				for iter_344_7, iter_344_8 in pairs(arg_341_1.var_.actorSpriteComps1060:ToTable()) do
					if iter_344_8 then
						if arg_341_1.isInRecall_ then
							iter_344_8.color = arg_341_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_344_8.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_341_1.var_.actorSpriteComps1060 = nil
			end

			local var_344_23 = 0
			local var_344_24 = 0.3

			if var_344_23 < arg_341_1.time_ and arg_341_1.time_ <= var_344_23 + arg_344_0 then
				arg_341_1.talkMaxDuration = 0
				arg_341_1.dialogCg_.alpha = 1

				arg_341_1.dialog_:SetActive(true)
				SetActive(arg_341_1.leftNameGo_, true)

				local var_344_25 = arg_341_1:FormatText(StoryNameCfg[595].name)

				arg_341_1.leftNameTxt_.text = var_344_25

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_341_1.leftNameTxt_.transform)

				arg_341_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_341_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_341_1:RecordName(arg_341_1.leftNameTxt_.text)
				SetActive(arg_341_1.iconTrs_.gameObject, false)
				arg_341_1.callingController_:SetSelectedState("normal")

				local var_344_26 = arg_341_1:GetWordFromCfg(410082083)
				local var_344_27 = arg_341_1:FormatText(var_344_26.content)

				arg_341_1.text_.text = var_344_27

				LuaForUtil.ClearLinePrefixSymbol(arg_341_1.text_)

				local var_344_28 = 12
				local var_344_29 = utf8.len(var_344_27)
				local var_344_30 = var_344_28 <= 0 and var_344_24 or var_344_24 * (var_344_29 / var_344_28)

				if var_344_30 > 0 and var_344_24 < var_344_30 then
					arg_341_1.talkMaxDuration = var_344_30

					if var_344_30 + var_344_23 > arg_341_1.duration_ then
						arg_341_1.duration_ = var_344_30 + var_344_23
					end
				end

				arg_341_1.text_.text = var_344_27
				arg_341_1.typewritter.percent = 0

				arg_341_1.typewritter:SetDirty()
				arg_341_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_410082", "410082083", "story_v_out_410082.awb") ~= 0 then
					local var_344_31 = manager.audio:GetVoiceLength("story_v_out_410082", "410082083", "story_v_out_410082.awb") / 1000

					if var_344_31 + var_344_23 > arg_341_1.duration_ then
						arg_341_1.duration_ = var_344_31 + var_344_23
					end

					if var_344_26.prefab_name ~= "" and arg_341_1.actors_[var_344_26.prefab_name] ~= nil then
						local var_344_32 = LuaForUtil.PlayVoiceWithCriLipsync(arg_341_1.actors_[var_344_26.prefab_name].transform, "story_v_out_410082", "410082083", "story_v_out_410082.awb")

						arg_341_1:RecordAudio("410082083", var_344_32)
						arg_341_1:RecordAudio("410082083", var_344_32)
					else
						arg_341_1:AudioAction("play", "voice", "story_v_out_410082", "410082083", "story_v_out_410082.awb")
					end

					arg_341_1:RecordHistoryTalkVoice("story_v_out_410082", "410082083", "story_v_out_410082.awb")
				end

				arg_341_1:RecordContent(arg_341_1.text_.text)
			end

			local var_344_33 = math.max(var_344_24, arg_341_1.talkMaxDuration)

			if var_344_23 <= arg_341_1.time_ and arg_341_1.time_ < var_344_23 + var_344_33 then
				arg_341_1.typewritter.percent = (arg_341_1.time_ - var_344_23) / var_344_33

				arg_341_1.typewritter:SetDirty()
			end

			if arg_341_1.time_ >= var_344_23 + var_344_33 and arg_341_1.time_ < var_344_23 + var_344_33 + arg_344_0 then
				arg_341_1.typewritter.percent = 1

				arg_341_1.typewritter:SetDirty()
				arg_341_1:ShowNextGo(true)
			end
		end

		arg_341_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1012",
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
	Play410082084 = function(arg_345_0, arg_345_1)
		arg_345_1.time_ = 0
		arg_345_1.frameCnt_ = 0
		arg_345_1.state_ = "playing"
		arg_345_1.curTalkId_ = 410082084
		arg_345_1.duration_ = 4.43

		local var_345_0 = {
			zh = 1.6,
			ja = 4.433
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
				arg_345_0:Play410082085(arg_345_1)
			end
		end

		function arg_345_1.onSingleLineUpdate_(arg_348_0)
			local var_348_0 = arg_345_1.actors_["1060"].transform
			local var_348_1 = 0

			if var_348_1 < arg_345_1.time_ and arg_345_1.time_ <= var_348_1 + arg_348_0 then
				arg_345_1.var_.moveOldPos1060 = var_348_0.localPosition
				var_348_0.localScale = Vector3.New(1, 1, 1)

				arg_345_1:CheckSpriteTmpPos("1060", 2)

				local var_348_2 = var_348_0.childCount

				for iter_348_0 = 0, var_348_2 - 1 do
					local var_348_3 = var_348_0:GetChild(iter_348_0)

					if var_348_3.name == "" or not string.find(var_348_3.name, "split") then
						var_348_3.gameObject:SetActive(true)
					else
						var_348_3.gameObject:SetActive(false)
					end
				end
			end

			local var_348_4 = 0.001

			if var_348_1 <= arg_345_1.time_ and arg_345_1.time_ < var_348_1 + var_348_4 then
				local var_348_5 = (arg_345_1.time_ - var_348_1) / var_348_4
				local var_348_6 = Vector3.New(-440.94, -430.8, 6.9)

				var_348_0.localPosition = Vector3.Lerp(arg_345_1.var_.moveOldPos1060, var_348_6, var_348_5)
			end

			if arg_345_1.time_ >= var_348_1 + var_348_4 and arg_345_1.time_ < var_348_1 + var_348_4 + arg_348_0 then
				var_348_0.localPosition = Vector3.New(-440.94, -430.8, 6.9)
			end

			local var_348_7 = arg_345_1.actors_["1060"]
			local var_348_8 = 0

			if var_348_8 < arg_345_1.time_ and arg_345_1.time_ <= var_348_8 + arg_348_0 and not isNil(var_348_7) and arg_345_1.var_.actorSpriteComps1060 == nil then
				arg_345_1.var_.actorSpriteComps1060 = var_348_7:GetComponentsInChildren(typeof(Image), true)
			end

			local var_348_9 = 0.034

			if var_348_8 <= arg_345_1.time_ and arg_345_1.time_ < var_348_8 + var_348_9 and not isNil(var_348_7) then
				local var_348_10 = (arg_345_1.time_ - var_348_8) / var_348_9

				if arg_345_1.var_.actorSpriteComps1060 then
					for iter_348_1, iter_348_2 in pairs(arg_345_1.var_.actorSpriteComps1060:ToTable()) do
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

			if arg_345_1.time_ >= var_348_8 + var_348_9 and arg_345_1.time_ < var_348_8 + var_348_9 + arg_348_0 and not isNil(var_348_7) and arg_345_1.var_.actorSpriteComps1060 then
				for iter_348_3, iter_348_4 in pairs(arg_345_1.var_.actorSpriteComps1060:ToTable()) do
					if iter_348_4 then
						if arg_345_1.isInRecall_ then
							iter_348_4.color = arg_345_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_348_4.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_345_1.var_.actorSpriteComps1060 = nil
			end

			local var_348_15 = arg_345_1.actors_["1012"]
			local var_348_16 = 0

			if var_348_16 < arg_345_1.time_ and arg_345_1.time_ <= var_348_16 + arg_348_0 and not isNil(var_348_15) and arg_345_1.var_.actorSpriteComps1012 == nil then
				arg_345_1.var_.actorSpriteComps1012 = var_348_15:GetComponentsInChildren(typeof(Image), true)
			end

			local var_348_17 = 0.034

			if var_348_16 <= arg_345_1.time_ and arg_345_1.time_ < var_348_16 + var_348_17 and not isNil(var_348_15) then
				local var_348_18 = (arg_345_1.time_ - var_348_16) / var_348_17

				if arg_345_1.var_.actorSpriteComps1012 then
					for iter_348_5, iter_348_6 in pairs(arg_345_1.var_.actorSpriteComps1012:ToTable()) do
						if iter_348_6 then
							if arg_345_1.isInRecall_ then
								local var_348_19 = Mathf.Lerp(iter_348_6.color.r, arg_345_1.hightColor2.r, var_348_18)
								local var_348_20 = Mathf.Lerp(iter_348_6.color.g, arg_345_1.hightColor2.g, var_348_18)
								local var_348_21 = Mathf.Lerp(iter_348_6.color.b, arg_345_1.hightColor2.b, var_348_18)

								iter_348_6.color = Color.New(var_348_19, var_348_20, var_348_21)
							else
								local var_348_22 = Mathf.Lerp(iter_348_6.color.r, 0.5, var_348_18)

								iter_348_6.color = Color.New(var_348_22, var_348_22, var_348_22)
							end
						end
					end
				end
			end

			if arg_345_1.time_ >= var_348_16 + var_348_17 and arg_345_1.time_ < var_348_16 + var_348_17 + arg_348_0 and not isNil(var_348_15) and arg_345_1.var_.actorSpriteComps1012 then
				for iter_348_7, iter_348_8 in pairs(arg_345_1.var_.actorSpriteComps1012:ToTable()) do
					if iter_348_8 then
						if arg_345_1.isInRecall_ then
							iter_348_8.color = arg_345_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_348_8.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_345_1.var_.actorSpriteComps1012 = nil
			end

			local var_348_23 = 0
			local var_348_24 = 0.25

			if var_348_23 < arg_345_1.time_ and arg_345_1.time_ <= var_348_23 + arg_348_0 then
				arg_345_1.talkMaxDuration = 0
				arg_345_1.dialogCg_.alpha = 1

				arg_345_1.dialog_:SetActive(true)
				SetActive(arg_345_1.leftNameGo_, true)

				local var_348_25 = arg_345_1:FormatText(StoryNameCfg[584].name)

				arg_345_1.leftNameTxt_.text = var_348_25

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_345_1.leftNameTxt_.transform)

				arg_345_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_345_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_345_1:RecordName(arg_345_1.leftNameTxt_.text)
				SetActive(arg_345_1.iconTrs_.gameObject, false)
				arg_345_1.callingController_:SetSelectedState("normal")

				local var_348_26 = arg_345_1:GetWordFromCfg(410082084)
				local var_348_27 = arg_345_1:FormatText(var_348_26.content)

				arg_345_1.text_.text = var_348_27

				LuaForUtil.ClearLinePrefixSymbol(arg_345_1.text_)

				local var_348_28 = 10
				local var_348_29 = utf8.len(var_348_27)
				local var_348_30 = var_348_28 <= 0 and var_348_24 or var_348_24 * (var_348_29 / var_348_28)

				if var_348_30 > 0 and var_348_24 < var_348_30 then
					arg_345_1.talkMaxDuration = var_348_30

					if var_348_30 + var_348_23 > arg_345_1.duration_ then
						arg_345_1.duration_ = var_348_30 + var_348_23
					end
				end

				arg_345_1.text_.text = var_348_27
				arg_345_1.typewritter.percent = 0

				arg_345_1.typewritter:SetDirty()
				arg_345_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_410082", "410082084", "story_v_out_410082.awb") ~= 0 then
					local var_348_31 = manager.audio:GetVoiceLength("story_v_out_410082", "410082084", "story_v_out_410082.awb") / 1000

					if var_348_31 + var_348_23 > arg_345_1.duration_ then
						arg_345_1.duration_ = var_348_31 + var_348_23
					end

					if var_348_26.prefab_name ~= "" and arg_345_1.actors_[var_348_26.prefab_name] ~= nil then
						local var_348_32 = LuaForUtil.PlayVoiceWithCriLipsync(arg_345_1.actors_[var_348_26.prefab_name].transform, "story_v_out_410082", "410082084", "story_v_out_410082.awb")

						arg_345_1:RecordAudio("410082084", var_348_32)
						arg_345_1:RecordAudio("410082084", var_348_32)
					else
						arg_345_1:AudioAction("play", "voice", "story_v_out_410082", "410082084", "story_v_out_410082.awb")
					end

					arg_345_1:RecordHistoryTalkVoice("story_v_out_410082", "410082084", "story_v_out_410082.awb")
				end

				arg_345_1:RecordContent(arg_345_1.text_.text)
			end

			local var_348_33 = math.max(var_348_24, arg_345_1.talkMaxDuration)

			if var_348_23 <= arg_345_1.time_ and arg_345_1.time_ < var_348_23 + var_348_33 then
				arg_345_1.typewritter.percent = (arg_345_1.time_ - var_348_23) / var_348_33

				arg_345_1.typewritter:SetDirty()
			end

			if arg_345_1.time_ >= var_348_23 + var_348_33 and arg_345_1.time_ < var_348_23 + var_348_33 + arg_348_0 then
				arg_345_1.typewritter.percent = 1

				arg_345_1.typewritter:SetDirty()
				arg_345_1:ShowNextGo(true)
			end
		end

		arg_345_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1060",
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
	Play410082085 = function(arg_349_0, arg_349_1)
		arg_349_1.time_ = 0
		arg_349_1.frameCnt_ = 0
		arg_349_1.state_ = "playing"
		arg_349_1.curTalkId_ = 410082085
		arg_349_1.duration_ = 12.37

		local var_349_0 = {
			zh = 8.1,
			ja = 12.366
		}
		local var_349_1 = manager.audio:GetLocalizationFlag()

		if var_349_0[var_349_1] ~= nil then
			arg_349_1.duration_ = var_349_0[var_349_1]
		end

		SetActive(arg_349_1.tipsGo_, false)

		function arg_349_1.onSingleLineFinish_()
			arg_349_1.onSingleLineUpdate_ = nil
			arg_349_1.onSingleLineFinish_ = nil
			arg_349_1.state_ = "waiting"
		end

		function arg_349_1.playNext_(arg_351_0)
			if arg_351_0 == 1 then
				arg_349_0:Play410082086(arg_349_1)
			end
		end

		function arg_349_1.onSingleLineUpdate_(arg_352_0)
			local var_352_0 = arg_349_1.actors_["1012"].transform
			local var_352_1 = 0

			if var_352_1 < arg_349_1.time_ and arg_349_1.time_ <= var_352_1 + arg_352_0 then
				arg_349_1.var_.moveOldPos1012 = var_352_0.localPosition
				var_352_0.localScale = Vector3.New(1, 1, 1)

				arg_349_1:CheckSpriteTmpPos("1012", 4)

				local var_352_2 = var_352_0.childCount

				for iter_352_0 = 0, var_352_2 - 1 do
					local var_352_3 = var_352_0:GetChild(iter_352_0)

					if var_352_3.name == "" or not string.find(var_352_3.name, "split") then
						var_352_3.gameObject:SetActive(true)
					else
						var_352_3.gameObject:SetActive(false)
					end
				end
			end

			local var_352_4 = 0.001

			if var_352_1 <= arg_349_1.time_ and arg_349_1.time_ < var_352_1 + var_352_4 then
				local var_352_5 = (arg_349_1.time_ - var_352_1) / var_352_4
				local var_352_6 = Vector3.New(390, -465, 300)

				var_352_0.localPosition = Vector3.Lerp(arg_349_1.var_.moveOldPos1012, var_352_6, var_352_5)
			end

			if arg_349_1.time_ >= var_352_1 + var_352_4 and arg_349_1.time_ < var_352_1 + var_352_4 + arg_352_0 then
				var_352_0.localPosition = Vector3.New(390, -465, 300)
			end

			local var_352_7 = arg_349_1.actors_["1012"]
			local var_352_8 = 0

			if var_352_8 < arg_349_1.time_ and arg_349_1.time_ <= var_352_8 + arg_352_0 and not isNil(var_352_7) and arg_349_1.var_.actorSpriteComps1012 == nil then
				arg_349_1.var_.actorSpriteComps1012 = var_352_7:GetComponentsInChildren(typeof(Image), true)
			end

			local var_352_9 = 0.034

			if var_352_8 <= arg_349_1.time_ and arg_349_1.time_ < var_352_8 + var_352_9 and not isNil(var_352_7) then
				local var_352_10 = (arg_349_1.time_ - var_352_8) / var_352_9

				if arg_349_1.var_.actorSpriteComps1012 then
					for iter_352_1, iter_352_2 in pairs(arg_349_1.var_.actorSpriteComps1012:ToTable()) do
						if iter_352_2 then
							if arg_349_1.isInRecall_ then
								local var_352_11 = Mathf.Lerp(iter_352_2.color.r, arg_349_1.hightColor1.r, var_352_10)
								local var_352_12 = Mathf.Lerp(iter_352_2.color.g, arg_349_1.hightColor1.g, var_352_10)
								local var_352_13 = Mathf.Lerp(iter_352_2.color.b, arg_349_1.hightColor1.b, var_352_10)

								iter_352_2.color = Color.New(var_352_11, var_352_12, var_352_13)
							else
								local var_352_14 = Mathf.Lerp(iter_352_2.color.r, 1, var_352_10)

								iter_352_2.color = Color.New(var_352_14, var_352_14, var_352_14)
							end
						end
					end
				end
			end

			if arg_349_1.time_ >= var_352_8 + var_352_9 and arg_349_1.time_ < var_352_8 + var_352_9 + arg_352_0 and not isNil(var_352_7) and arg_349_1.var_.actorSpriteComps1012 then
				for iter_352_3, iter_352_4 in pairs(arg_349_1.var_.actorSpriteComps1012:ToTable()) do
					if iter_352_4 then
						if arg_349_1.isInRecall_ then
							iter_352_4.color = arg_349_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_352_4.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_349_1.var_.actorSpriteComps1012 = nil
			end

			local var_352_15 = arg_349_1.actors_["1060"]
			local var_352_16 = 0

			if var_352_16 < arg_349_1.time_ and arg_349_1.time_ <= var_352_16 + arg_352_0 and not isNil(var_352_15) and arg_349_1.var_.actorSpriteComps1060 == nil then
				arg_349_1.var_.actorSpriteComps1060 = var_352_15:GetComponentsInChildren(typeof(Image), true)
			end

			local var_352_17 = 0.034

			if var_352_16 <= arg_349_1.time_ and arg_349_1.time_ < var_352_16 + var_352_17 and not isNil(var_352_15) then
				local var_352_18 = (arg_349_1.time_ - var_352_16) / var_352_17

				if arg_349_1.var_.actorSpriteComps1060 then
					for iter_352_5, iter_352_6 in pairs(arg_349_1.var_.actorSpriteComps1060:ToTable()) do
						if iter_352_6 then
							if arg_349_1.isInRecall_ then
								local var_352_19 = Mathf.Lerp(iter_352_6.color.r, arg_349_1.hightColor2.r, var_352_18)
								local var_352_20 = Mathf.Lerp(iter_352_6.color.g, arg_349_1.hightColor2.g, var_352_18)
								local var_352_21 = Mathf.Lerp(iter_352_6.color.b, arg_349_1.hightColor2.b, var_352_18)

								iter_352_6.color = Color.New(var_352_19, var_352_20, var_352_21)
							else
								local var_352_22 = Mathf.Lerp(iter_352_6.color.r, 0.5, var_352_18)

								iter_352_6.color = Color.New(var_352_22, var_352_22, var_352_22)
							end
						end
					end
				end
			end

			if arg_349_1.time_ >= var_352_16 + var_352_17 and arg_349_1.time_ < var_352_16 + var_352_17 + arg_352_0 and not isNil(var_352_15) and arg_349_1.var_.actorSpriteComps1060 then
				for iter_352_7, iter_352_8 in pairs(arg_349_1.var_.actorSpriteComps1060:ToTable()) do
					if iter_352_8 then
						if arg_349_1.isInRecall_ then
							iter_352_8.color = arg_349_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_352_8.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_349_1.var_.actorSpriteComps1060 = nil
			end

			local var_352_23 = 0
			local var_352_24 = 0.9

			if var_352_23 < arg_349_1.time_ and arg_349_1.time_ <= var_352_23 + arg_352_0 then
				arg_349_1.talkMaxDuration = 0
				arg_349_1.dialogCg_.alpha = 1

				arg_349_1.dialog_:SetActive(true)
				SetActive(arg_349_1.leftNameGo_, true)

				local var_352_25 = arg_349_1:FormatText(StoryNameCfg[595].name)

				arg_349_1.leftNameTxt_.text = var_352_25

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_349_1.leftNameTxt_.transform)

				arg_349_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_349_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_349_1:RecordName(arg_349_1.leftNameTxt_.text)
				SetActive(arg_349_1.iconTrs_.gameObject, false)
				arg_349_1.callingController_:SetSelectedState("normal")

				local var_352_26 = arg_349_1:GetWordFromCfg(410082085)
				local var_352_27 = arg_349_1:FormatText(var_352_26.content)

				arg_349_1.text_.text = var_352_27

				LuaForUtil.ClearLinePrefixSymbol(arg_349_1.text_)

				local var_352_28 = 36
				local var_352_29 = utf8.len(var_352_27)
				local var_352_30 = var_352_28 <= 0 and var_352_24 or var_352_24 * (var_352_29 / var_352_28)

				if var_352_30 > 0 and var_352_24 < var_352_30 then
					arg_349_1.talkMaxDuration = var_352_30

					if var_352_30 + var_352_23 > arg_349_1.duration_ then
						arg_349_1.duration_ = var_352_30 + var_352_23
					end
				end

				arg_349_1.text_.text = var_352_27
				arg_349_1.typewritter.percent = 0

				arg_349_1.typewritter:SetDirty()
				arg_349_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_410082", "410082085", "story_v_out_410082.awb") ~= 0 then
					local var_352_31 = manager.audio:GetVoiceLength("story_v_out_410082", "410082085", "story_v_out_410082.awb") / 1000

					if var_352_31 + var_352_23 > arg_349_1.duration_ then
						arg_349_1.duration_ = var_352_31 + var_352_23
					end

					if var_352_26.prefab_name ~= "" and arg_349_1.actors_[var_352_26.prefab_name] ~= nil then
						local var_352_32 = LuaForUtil.PlayVoiceWithCriLipsync(arg_349_1.actors_[var_352_26.prefab_name].transform, "story_v_out_410082", "410082085", "story_v_out_410082.awb")

						arg_349_1:RecordAudio("410082085", var_352_32)
						arg_349_1:RecordAudio("410082085", var_352_32)
					else
						arg_349_1:AudioAction("play", "voice", "story_v_out_410082", "410082085", "story_v_out_410082.awb")
					end

					arg_349_1:RecordHistoryTalkVoice("story_v_out_410082", "410082085", "story_v_out_410082.awb")
				end

				arg_349_1:RecordContent(arg_349_1.text_.text)
			end

			local var_352_33 = math.max(var_352_24, arg_349_1.talkMaxDuration)

			if var_352_23 <= arg_349_1.time_ and arg_349_1.time_ < var_352_23 + var_352_33 then
				arg_349_1.typewritter.percent = (arg_349_1.time_ - var_352_23) / var_352_33

				arg_349_1.typewritter:SetDirty()
			end

			if arg_349_1.time_ >= var_352_23 + var_352_33 and arg_349_1.time_ < var_352_23 + var_352_33 + arg_352_0 then
				arg_349_1.typewritter.percent = 1

				arg_349_1.typewritter:SetDirty()
				arg_349_1:ShowNextGo(true)
			end
		end

		arg_349_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1012",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_349_1:InitPlayNodeList()
	end,
	Play410082086 = function(arg_353_0, arg_353_1)
		arg_353_1.time_ = 0
		arg_353_1.frameCnt_ = 0
		arg_353_1.state_ = "playing"
		arg_353_1.curTalkId_ = 410082086
		arg_353_1.duration_ = 7.17

		local var_353_0 = {
			zh = 2.833,
			ja = 7.166
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
				arg_353_0:Play410082087(arg_353_1)
			end
		end

		function arg_353_1.onSingleLineUpdate_(arg_356_0)
			local var_356_0 = arg_353_1.actors_["1060"].transform
			local var_356_1 = 0

			if var_356_1 < arg_353_1.time_ and arg_353_1.time_ <= var_356_1 + arg_356_0 then
				arg_353_1.var_.moveOldPos1060 = var_356_0.localPosition
				var_356_0.localScale = Vector3.New(1, 1, 1)

				arg_353_1:CheckSpriteTmpPos("1060", 2)

				local var_356_2 = var_356_0.childCount

				for iter_356_0 = 0, var_356_2 - 1 do
					local var_356_3 = var_356_0:GetChild(iter_356_0)

					if var_356_3.name == "" or not string.find(var_356_3.name, "split") then
						var_356_3.gameObject:SetActive(true)
					else
						var_356_3.gameObject:SetActive(false)
					end
				end
			end

			local var_356_4 = 0.001

			if var_356_1 <= arg_353_1.time_ and arg_353_1.time_ < var_356_1 + var_356_4 then
				local var_356_5 = (arg_353_1.time_ - var_356_1) / var_356_4
				local var_356_6 = Vector3.New(-440.94, -430.8, 6.9)

				var_356_0.localPosition = Vector3.Lerp(arg_353_1.var_.moveOldPos1060, var_356_6, var_356_5)
			end

			if arg_353_1.time_ >= var_356_1 + var_356_4 and arg_353_1.time_ < var_356_1 + var_356_4 + arg_356_0 then
				var_356_0.localPosition = Vector3.New(-440.94, -430.8, 6.9)
			end

			local var_356_7 = arg_353_1.actors_["1060"]
			local var_356_8 = 0

			if var_356_8 < arg_353_1.time_ and arg_353_1.time_ <= var_356_8 + arg_356_0 and not isNil(var_356_7) and arg_353_1.var_.actorSpriteComps1060 == nil then
				arg_353_1.var_.actorSpriteComps1060 = var_356_7:GetComponentsInChildren(typeof(Image), true)
			end

			local var_356_9 = 0.034

			if var_356_8 <= arg_353_1.time_ and arg_353_1.time_ < var_356_8 + var_356_9 and not isNil(var_356_7) then
				local var_356_10 = (arg_353_1.time_ - var_356_8) / var_356_9

				if arg_353_1.var_.actorSpriteComps1060 then
					for iter_356_1, iter_356_2 in pairs(arg_353_1.var_.actorSpriteComps1060:ToTable()) do
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

			if arg_353_1.time_ >= var_356_8 + var_356_9 and arg_353_1.time_ < var_356_8 + var_356_9 + arg_356_0 and not isNil(var_356_7) and arg_353_1.var_.actorSpriteComps1060 then
				for iter_356_3, iter_356_4 in pairs(arg_353_1.var_.actorSpriteComps1060:ToTable()) do
					if iter_356_4 then
						if arg_353_1.isInRecall_ then
							iter_356_4.color = arg_353_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_356_4.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_353_1.var_.actorSpriteComps1060 = nil
			end

			local var_356_15 = arg_353_1.actors_["1012"]
			local var_356_16 = 0

			if var_356_16 < arg_353_1.time_ and arg_353_1.time_ <= var_356_16 + arg_356_0 and not isNil(var_356_15) and arg_353_1.var_.actorSpriteComps1012 == nil then
				arg_353_1.var_.actorSpriteComps1012 = var_356_15:GetComponentsInChildren(typeof(Image), true)
			end

			local var_356_17 = 0.034

			if var_356_16 <= arg_353_1.time_ and arg_353_1.time_ < var_356_16 + var_356_17 and not isNil(var_356_15) then
				local var_356_18 = (arg_353_1.time_ - var_356_16) / var_356_17

				if arg_353_1.var_.actorSpriteComps1012 then
					for iter_356_5, iter_356_6 in pairs(arg_353_1.var_.actorSpriteComps1012:ToTable()) do
						if iter_356_6 then
							if arg_353_1.isInRecall_ then
								local var_356_19 = Mathf.Lerp(iter_356_6.color.r, arg_353_1.hightColor2.r, var_356_18)
								local var_356_20 = Mathf.Lerp(iter_356_6.color.g, arg_353_1.hightColor2.g, var_356_18)
								local var_356_21 = Mathf.Lerp(iter_356_6.color.b, arg_353_1.hightColor2.b, var_356_18)

								iter_356_6.color = Color.New(var_356_19, var_356_20, var_356_21)
							else
								local var_356_22 = Mathf.Lerp(iter_356_6.color.r, 0.5, var_356_18)

								iter_356_6.color = Color.New(var_356_22, var_356_22, var_356_22)
							end
						end
					end
				end
			end

			if arg_353_1.time_ >= var_356_16 + var_356_17 and arg_353_1.time_ < var_356_16 + var_356_17 + arg_356_0 and not isNil(var_356_15) and arg_353_1.var_.actorSpriteComps1012 then
				for iter_356_7, iter_356_8 in pairs(arg_353_1.var_.actorSpriteComps1012:ToTable()) do
					if iter_356_8 then
						if arg_353_1.isInRecall_ then
							iter_356_8.color = arg_353_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_356_8.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_353_1.var_.actorSpriteComps1012 = nil
			end

			local var_356_23 = 0
			local var_356_24 = 0.125

			if var_356_23 < arg_353_1.time_ and arg_353_1.time_ <= var_356_23 + arg_356_0 then
				arg_353_1.talkMaxDuration = 0
				arg_353_1.dialogCg_.alpha = 1

				arg_353_1.dialog_:SetActive(true)
				SetActive(arg_353_1.leftNameGo_, true)

				local var_356_25 = arg_353_1:FormatText(StoryNameCfg[584].name)

				arg_353_1.leftNameTxt_.text = var_356_25

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_353_1.leftNameTxt_.transform)

				arg_353_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_353_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_353_1:RecordName(arg_353_1.leftNameTxt_.text)
				SetActive(arg_353_1.iconTrs_.gameObject, false)
				arg_353_1.callingController_:SetSelectedState("normal")

				local var_356_26 = arg_353_1:GetWordFromCfg(410082086)
				local var_356_27 = arg_353_1:FormatText(var_356_26.content)

				arg_353_1.text_.text = var_356_27

				LuaForUtil.ClearLinePrefixSymbol(arg_353_1.text_)

				local var_356_28 = 5
				local var_356_29 = utf8.len(var_356_27)
				local var_356_30 = var_356_28 <= 0 and var_356_24 or var_356_24 * (var_356_29 / var_356_28)

				if var_356_30 > 0 and var_356_24 < var_356_30 then
					arg_353_1.talkMaxDuration = var_356_30

					if var_356_30 + var_356_23 > arg_353_1.duration_ then
						arg_353_1.duration_ = var_356_30 + var_356_23
					end
				end

				arg_353_1.text_.text = var_356_27
				arg_353_1.typewritter.percent = 0

				arg_353_1.typewritter:SetDirty()
				arg_353_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_410082", "410082086", "story_v_out_410082.awb") ~= 0 then
					local var_356_31 = manager.audio:GetVoiceLength("story_v_out_410082", "410082086", "story_v_out_410082.awb") / 1000

					if var_356_31 + var_356_23 > arg_353_1.duration_ then
						arg_353_1.duration_ = var_356_31 + var_356_23
					end

					if var_356_26.prefab_name ~= "" and arg_353_1.actors_[var_356_26.prefab_name] ~= nil then
						local var_356_32 = LuaForUtil.PlayVoiceWithCriLipsync(arg_353_1.actors_[var_356_26.prefab_name].transform, "story_v_out_410082", "410082086", "story_v_out_410082.awb")

						arg_353_1:RecordAudio("410082086", var_356_32)
						arg_353_1:RecordAudio("410082086", var_356_32)
					else
						arg_353_1:AudioAction("play", "voice", "story_v_out_410082", "410082086", "story_v_out_410082.awb")
					end

					arg_353_1:RecordHistoryTalkVoice("story_v_out_410082", "410082086", "story_v_out_410082.awb")
				end

				arg_353_1:RecordContent(arg_353_1.text_.text)
			end

			local var_356_33 = math.max(var_356_24, arg_353_1.talkMaxDuration)

			if var_356_23 <= arg_353_1.time_ and arg_353_1.time_ < var_356_23 + var_356_33 then
				arg_353_1.typewritter.percent = (arg_353_1.time_ - var_356_23) / var_356_33

				arg_353_1.typewritter:SetDirty()
			end

			if arg_353_1.time_ >= var_356_23 + var_356_33 and arg_353_1.time_ < var_356_23 + var_356_33 + arg_356_0 then
				arg_353_1.typewritter.percent = 1

				arg_353_1.typewritter:SetDirty()
				arg_353_1:ShowNextGo(true)
			end
		end

		arg_353_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1060",
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
	Play410082087 = function(arg_357_0, arg_357_1)
		arg_357_1.time_ = 0
		arg_357_1.frameCnt_ = 0
		arg_357_1.state_ = "playing"
		arg_357_1.curTalkId_ = 410082087
		arg_357_1.duration_ = 11.2

		local var_357_0 = {
			zh = 9.666,
			ja = 11.2
		}
		local var_357_1 = manager.audio:GetLocalizationFlag()

		if var_357_0[var_357_1] ~= nil then
			arg_357_1.duration_ = var_357_0[var_357_1]
		end

		SetActive(arg_357_1.tipsGo_, false)

		function arg_357_1.onSingleLineFinish_()
			arg_357_1.onSingleLineUpdate_ = nil
			arg_357_1.onSingleLineFinish_ = nil
			arg_357_1.state_ = "waiting"
		end

		function arg_357_1.playNext_(arg_359_0)
			if arg_359_0 == 1 then
				arg_357_0:Play410082088(arg_357_1)
			end
		end

		function arg_357_1.onSingleLineUpdate_(arg_360_0)
			local var_360_0 = arg_357_1.actors_["1012"].transform
			local var_360_1 = 0

			if var_360_1 < arg_357_1.time_ and arg_357_1.time_ <= var_360_1 + arg_360_0 then
				arg_357_1.var_.moveOldPos1012 = var_360_0.localPosition
				var_360_0.localScale = Vector3.New(1, 1, 1)

				arg_357_1:CheckSpriteTmpPos("1012", 4)

				local var_360_2 = var_360_0.childCount

				for iter_360_0 = 0, var_360_2 - 1 do
					local var_360_3 = var_360_0:GetChild(iter_360_0)

					if var_360_3.name == "" or not string.find(var_360_3.name, "split") then
						var_360_3.gameObject:SetActive(true)
					else
						var_360_3.gameObject:SetActive(false)
					end
				end
			end

			local var_360_4 = 0.001

			if var_360_1 <= arg_357_1.time_ and arg_357_1.time_ < var_360_1 + var_360_4 then
				local var_360_5 = (arg_357_1.time_ - var_360_1) / var_360_4
				local var_360_6 = Vector3.New(390, -465, 300)

				var_360_0.localPosition = Vector3.Lerp(arg_357_1.var_.moveOldPos1012, var_360_6, var_360_5)
			end

			if arg_357_1.time_ >= var_360_1 + var_360_4 and arg_357_1.time_ < var_360_1 + var_360_4 + arg_360_0 then
				var_360_0.localPosition = Vector3.New(390, -465, 300)
			end

			local var_360_7 = arg_357_1.actors_["1012"]
			local var_360_8 = 0

			if var_360_8 < arg_357_1.time_ and arg_357_1.time_ <= var_360_8 + arg_360_0 and not isNil(var_360_7) and arg_357_1.var_.actorSpriteComps1012 == nil then
				arg_357_1.var_.actorSpriteComps1012 = var_360_7:GetComponentsInChildren(typeof(Image), true)
			end

			local var_360_9 = 0.034

			if var_360_8 <= arg_357_1.time_ and arg_357_1.time_ < var_360_8 + var_360_9 and not isNil(var_360_7) then
				local var_360_10 = (arg_357_1.time_ - var_360_8) / var_360_9

				if arg_357_1.var_.actorSpriteComps1012 then
					for iter_360_1, iter_360_2 in pairs(arg_357_1.var_.actorSpriteComps1012:ToTable()) do
						if iter_360_2 then
							if arg_357_1.isInRecall_ then
								local var_360_11 = Mathf.Lerp(iter_360_2.color.r, arg_357_1.hightColor1.r, var_360_10)
								local var_360_12 = Mathf.Lerp(iter_360_2.color.g, arg_357_1.hightColor1.g, var_360_10)
								local var_360_13 = Mathf.Lerp(iter_360_2.color.b, arg_357_1.hightColor1.b, var_360_10)

								iter_360_2.color = Color.New(var_360_11, var_360_12, var_360_13)
							else
								local var_360_14 = Mathf.Lerp(iter_360_2.color.r, 1, var_360_10)

								iter_360_2.color = Color.New(var_360_14, var_360_14, var_360_14)
							end
						end
					end
				end
			end

			if arg_357_1.time_ >= var_360_8 + var_360_9 and arg_357_1.time_ < var_360_8 + var_360_9 + arg_360_0 and not isNil(var_360_7) and arg_357_1.var_.actorSpriteComps1012 then
				for iter_360_3, iter_360_4 in pairs(arg_357_1.var_.actorSpriteComps1012:ToTable()) do
					if iter_360_4 then
						if arg_357_1.isInRecall_ then
							iter_360_4.color = arg_357_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_360_4.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_357_1.var_.actorSpriteComps1012 = nil
			end

			local var_360_15 = arg_357_1.actors_["1060"]
			local var_360_16 = 0

			if var_360_16 < arg_357_1.time_ and arg_357_1.time_ <= var_360_16 + arg_360_0 and not isNil(var_360_15) and arg_357_1.var_.actorSpriteComps1060 == nil then
				arg_357_1.var_.actorSpriteComps1060 = var_360_15:GetComponentsInChildren(typeof(Image), true)
			end

			local var_360_17 = 0.034

			if var_360_16 <= arg_357_1.time_ and arg_357_1.time_ < var_360_16 + var_360_17 and not isNil(var_360_15) then
				local var_360_18 = (arg_357_1.time_ - var_360_16) / var_360_17

				if arg_357_1.var_.actorSpriteComps1060 then
					for iter_360_5, iter_360_6 in pairs(arg_357_1.var_.actorSpriteComps1060:ToTable()) do
						if iter_360_6 then
							if arg_357_1.isInRecall_ then
								local var_360_19 = Mathf.Lerp(iter_360_6.color.r, arg_357_1.hightColor2.r, var_360_18)
								local var_360_20 = Mathf.Lerp(iter_360_6.color.g, arg_357_1.hightColor2.g, var_360_18)
								local var_360_21 = Mathf.Lerp(iter_360_6.color.b, arg_357_1.hightColor2.b, var_360_18)

								iter_360_6.color = Color.New(var_360_19, var_360_20, var_360_21)
							else
								local var_360_22 = Mathf.Lerp(iter_360_6.color.r, 0.5, var_360_18)

								iter_360_6.color = Color.New(var_360_22, var_360_22, var_360_22)
							end
						end
					end
				end
			end

			if arg_357_1.time_ >= var_360_16 + var_360_17 and arg_357_1.time_ < var_360_16 + var_360_17 + arg_360_0 and not isNil(var_360_15) and arg_357_1.var_.actorSpriteComps1060 then
				for iter_360_7, iter_360_8 in pairs(arg_357_1.var_.actorSpriteComps1060:ToTable()) do
					if iter_360_8 then
						if arg_357_1.isInRecall_ then
							iter_360_8.color = arg_357_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_360_8.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_357_1.var_.actorSpriteComps1060 = nil
			end

			local var_360_23 = 0
			local var_360_24 = 1.225

			if var_360_23 < arg_357_1.time_ and arg_357_1.time_ <= var_360_23 + arg_360_0 then
				arg_357_1.talkMaxDuration = 0
				arg_357_1.dialogCg_.alpha = 1

				arg_357_1.dialog_:SetActive(true)
				SetActive(arg_357_1.leftNameGo_, true)

				local var_360_25 = arg_357_1:FormatText(StoryNameCfg[595].name)

				arg_357_1.leftNameTxt_.text = var_360_25

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_357_1.leftNameTxt_.transform)

				arg_357_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_357_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_357_1:RecordName(arg_357_1.leftNameTxt_.text)
				SetActive(arg_357_1.iconTrs_.gameObject, false)
				arg_357_1.callingController_:SetSelectedState("normal")

				local var_360_26 = arg_357_1:GetWordFromCfg(410082087)
				local var_360_27 = arg_357_1:FormatText(var_360_26.content)

				arg_357_1.text_.text = var_360_27

				LuaForUtil.ClearLinePrefixSymbol(arg_357_1.text_)

				local var_360_28 = 49
				local var_360_29 = utf8.len(var_360_27)
				local var_360_30 = var_360_28 <= 0 and var_360_24 or var_360_24 * (var_360_29 / var_360_28)

				if var_360_30 > 0 and var_360_24 < var_360_30 then
					arg_357_1.talkMaxDuration = var_360_30

					if var_360_30 + var_360_23 > arg_357_1.duration_ then
						arg_357_1.duration_ = var_360_30 + var_360_23
					end
				end

				arg_357_1.text_.text = var_360_27
				arg_357_1.typewritter.percent = 0

				arg_357_1.typewritter:SetDirty()
				arg_357_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_410082", "410082087", "story_v_out_410082.awb") ~= 0 then
					local var_360_31 = manager.audio:GetVoiceLength("story_v_out_410082", "410082087", "story_v_out_410082.awb") / 1000

					if var_360_31 + var_360_23 > arg_357_1.duration_ then
						arg_357_1.duration_ = var_360_31 + var_360_23
					end

					if var_360_26.prefab_name ~= "" and arg_357_1.actors_[var_360_26.prefab_name] ~= nil then
						local var_360_32 = LuaForUtil.PlayVoiceWithCriLipsync(arg_357_1.actors_[var_360_26.prefab_name].transform, "story_v_out_410082", "410082087", "story_v_out_410082.awb")

						arg_357_1:RecordAudio("410082087", var_360_32)
						arg_357_1:RecordAudio("410082087", var_360_32)
					else
						arg_357_1:AudioAction("play", "voice", "story_v_out_410082", "410082087", "story_v_out_410082.awb")
					end

					arg_357_1:RecordHistoryTalkVoice("story_v_out_410082", "410082087", "story_v_out_410082.awb")
				end

				arg_357_1:RecordContent(arg_357_1.text_.text)
			end

			local var_360_33 = math.max(var_360_24, arg_357_1.talkMaxDuration)

			if var_360_23 <= arg_357_1.time_ and arg_357_1.time_ < var_360_23 + var_360_33 then
				arg_357_1.typewritter.percent = (arg_357_1.time_ - var_360_23) / var_360_33

				arg_357_1.typewritter:SetDirty()
			end

			if arg_357_1.time_ >= var_360_23 + var_360_33 and arg_357_1.time_ < var_360_23 + var_360_33 + arg_360_0 then
				arg_357_1.typewritter.percent = 1

				arg_357_1.typewritter:SetDirty()
				arg_357_1:ShowNextGo(true)
			end
		end

		arg_357_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1012",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_357_1:InitPlayNodeList()
	end,
	Play410082088 = function(arg_361_0, arg_361_1)
		arg_361_1.time_ = 0
		arg_361_1.frameCnt_ = 0
		arg_361_1.state_ = "playing"
		arg_361_1.curTalkId_ = 410082088
		arg_361_1.duration_ = 9.53

		local var_361_0 = {
			zh = 4.666,
			ja = 9.533
		}
		local var_361_1 = manager.audio:GetLocalizationFlag()

		if var_361_0[var_361_1] ~= nil then
			arg_361_1.duration_ = var_361_0[var_361_1]
		end

		SetActive(arg_361_1.tipsGo_, false)

		function arg_361_1.onSingleLineFinish_()
			arg_361_1.onSingleLineUpdate_ = nil
			arg_361_1.onSingleLineFinish_ = nil
			arg_361_1.state_ = "waiting"
		end

		function arg_361_1.playNext_(arg_363_0)
			if arg_363_0 == 1 then
				arg_361_0:Play410082089(arg_361_1)
			end
		end

		function arg_361_1.onSingleLineUpdate_(arg_364_0)
			local var_364_0 = 0
			local var_364_1 = 0.575

			if var_364_0 < arg_361_1.time_ and arg_361_1.time_ <= var_364_0 + arg_364_0 then
				arg_361_1.talkMaxDuration = 0
				arg_361_1.dialogCg_.alpha = 1

				arg_361_1.dialog_:SetActive(true)
				SetActive(arg_361_1.leftNameGo_, true)

				local var_364_2 = arg_361_1:FormatText(StoryNameCfg[595].name)

				arg_361_1.leftNameTxt_.text = var_364_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_361_1.leftNameTxt_.transform)

				arg_361_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_361_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_361_1:RecordName(arg_361_1.leftNameTxt_.text)
				SetActive(arg_361_1.iconTrs_.gameObject, false)
				arg_361_1.callingController_:SetSelectedState("normal")

				local var_364_3 = arg_361_1:GetWordFromCfg(410082088)
				local var_364_4 = arg_361_1:FormatText(var_364_3.content)

				arg_361_1.text_.text = var_364_4

				LuaForUtil.ClearLinePrefixSymbol(arg_361_1.text_)

				local var_364_5 = 23
				local var_364_6 = utf8.len(var_364_4)
				local var_364_7 = var_364_5 <= 0 and var_364_1 or var_364_1 * (var_364_6 / var_364_5)

				if var_364_7 > 0 and var_364_1 < var_364_7 then
					arg_361_1.talkMaxDuration = var_364_7

					if var_364_7 + var_364_0 > arg_361_1.duration_ then
						arg_361_1.duration_ = var_364_7 + var_364_0
					end
				end

				arg_361_1.text_.text = var_364_4
				arg_361_1.typewritter.percent = 0

				arg_361_1.typewritter:SetDirty()
				arg_361_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_410082", "410082088", "story_v_out_410082.awb") ~= 0 then
					local var_364_8 = manager.audio:GetVoiceLength("story_v_out_410082", "410082088", "story_v_out_410082.awb") / 1000

					if var_364_8 + var_364_0 > arg_361_1.duration_ then
						arg_361_1.duration_ = var_364_8 + var_364_0
					end

					if var_364_3.prefab_name ~= "" and arg_361_1.actors_[var_364_3.prefab_name] ~= nil then
						local var_364_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_361_1.actors_[var_364_3.prefab_name].transform, "story_v_out_410082", "410082088", "story_v_out_410082.awb")

						arg_361_1:RecordAudio("410082088", var_364_9)
						arg_361_1:RecordAudio("410082088", var_364_9)
					else
						arg_361_1:AudioAction("play", "voice", "story_v_out_410082", "410082088", "story_v_out_410082.awb")
					end

					arg_361_1:RecordHistoryTalkVoice("story_v_out_410082", "410082088", "story_v_out_410082.awb")
				end

				arg_361_1:RecordContent(arg_361_1.text_.text)
			end

			local var_364_10 = math.max(var_364_1, arg_361_1.talkMaxDuration)

			if var_364_0 <= arg_361_1.time_ and arg_361_1.time_ < var_364_0 + var_364_10 then
				arg_361_1.typewritter.percent = (arg_361_1.time_ - var_364_0) / var_364_10

				arg_361_1.typewritter:SetDirty()
			end

			if arg_361_1.time_ >= var_364_0 + var_364_10 and arg_361_1.time_ < var_364_0 + var_364_10 + arg_364_0 then
				arg_361_1.typewritter.percent = 1

				arg_361_1.typewritter:SetDirty()
				arg_361_1:ShowNextGo(true)
			end
		end

		arg_361_1.nodeConfigList_ = {}

		arg_361_1:InitPlayNodeList()
	end,
	Play410082089 = function(arg_365_0, arg_365_1)
		arg_365_1.time_ = 0
		arg_365_1.frameCnt_ = 0
		arg_365_1.state_ = "playing"
		arg_365_1.curTalkId_ = 410082089
		arg_365_1.duration_ = 5.13

		local var_365_0 = {
			zh = 1.7,
			ja = 5.133
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
				arg_365_0:Play410082090(arg_365_1)
			end
		end

		function arg_365_1.onSingleLineUpdate_(arg_368_0)
			local var_368_0 = arg_365_1.actors_["1060"].transform
			local var_368_1 = 0

			if var_368_1 < arg_365_1.time_ and arg_365_1.time_ <= var_368_1 + arg_368_0 then
				arg_365_1.var_.moveOldPos1060 = var_368_0.localPosition
				var_368_0.localScale = Vector3.New(1, 1, 1)

				arg_365_1:CheckSpriteTmpPos("1060", 2)

				local var_368_2 = var_368_0.childCount

				for iter_368_0 = 0, var_368_2 - 1 do
					local var_368_3 = var_368_0:GetChild(iter_368_0)

					if var_368_3.name == "" or not string.find(var_368_3.name, "split") then
						var_368_3.gameObject:SetActive(true)
					else
						var_368_3.gameObject:SetActive(false)
					end
				end
			end

			local var_368_4 = 0.001

			if var_368_1 <= arg_365_1.time_ and arg_365_1.time_ < var_368_1 + var_368_4 then
				local var_368_5 = (arg_365_1.time_ - var_368_1) / var_368_4
				local var_368_6 = Vector3.New(-440.94, -430.8, 6.9)

				var_368_0.localPosition = Vector3.Lerp(arg_365_1.var_.moveOldPos1060, var_368_6, var_368_5)
			end

			if arg_365_1.time_ >= var_368_1 + var_368_4 and arg_365_1.time_ < var_368_1 + var_368_4 + arg_368_0 then
				var_368_0.localPosition = Vector3.New(-440.94, -430.8, 6.9)
			end

			local var_368_7 = arg_365_1.actors_["1060"]
			local var_368_8 = 0

			if var_368_8 < arg_365_1.time_ and arg_365_1.time_ <= var_368_8 + arg_368_0 and not isNil(var_368_7) and arg_365_1.var_.actorSpriteComps1060 == nil then
				arg_365_1.var_.actorSpriteComps1060 = var_368_7:GetComponentsInChildren(typeof(Image), true)
			end

			local var_368_9 = 0.034

			if var_368_8 <= arg_365_1.time_ and arg_365_1.time_ < var_368_8 + var_368_9 and not isNil(var_368_7) then
				local var_368_10 = (arg_365_1.time_ - var_368_8) / var_368_9

				if arg_365_1.var_.actorSpriteComps1060 then
					for iter_368_1, iter_368_2 in pairs(arg_365_1.var_.actorSpriteComps1060:ToTable()) do
						if iter_368_2 then
							if arg_365_1.isInRecall_ then
								local var_368_11 = Mathf.Lerp(iter_368_2.color.r, arg_365_1.hightColor1.r, var_368_10)
								local var_368_12 = Mathf.Lerp(iter_368_2.color.g, arg_365_1.hightColor1.g, var_368_10)
								local var_368_13 = Mathf.Lerp(iter_368_2.color.b, arg_365_1.hightColor1.b, var_368_10)

								iter_368_2.color = Color.New(var_368_11, var_368_12, var_368_13)
							else
								local var_368_14 = Mathf.Lerp(iter_368_2.color.r, 1, var_368_10)

								iter_368_2.color = Color.New(var_368_14, var_368_14, var_368_14)
							end
						end
					end
				end
			end

			if arg_365_1.time_ >= var_368_8 + var_368_9 and arg_365_1.time_ < var_368_8 + var_368_9 + arg_368_0 and not isNil(var_368_7) and arg_365_1.var_.actorSpriteComps1060 then
				for iter_368_3, iter_368_4 in pairs(arg_365_1.var_.actorSpriteComps1060:ToTable()) do
					if iter_368_4 then
						if arg_365_1.isInRecall_ then
							iter_368_4.color = arg_365_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_368_4.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_365_1.var_.actorSpriteComps1060 = nil
			end

			local var_368_15 = arg_365_1.actors_["1012"]
			local var_368_16 = 0

			if var_368_16 < arg_365_1.time_ and arg_365_1.time_ <= var_368_16 + arg_368_0 and not isNil(var_368_15) and arg_365_1.var_.actorSpriteComps1012 == nil then
				arg_365_1.var_.actorSpriteComps1012 = var_368_15:GetComponentsInChildren(typeof(Image), true)
			end

			local var_368_17 = 0.034

			if var_368_16 <= arg_365_1.time_ and arg_365_1.time_ < var_368_16 + var_368_17 and not isNil(var_368_15) then
				local var_368_18 = (arg_365_1.time_ - var_368_16) / var_368_17

				if arg_365_1.var_.actorSpriteComps1012 then
					for iter_368_5, iter_368_6 in pairs(arg_365_1.var_.actorSpriteComps1012:ToTable()) do
						if iter_368_6 then
							if arg_365_1.isInRecall_ then
								local var_368_19 = Mathf.Lerp(iter_368_6.color.r, arg_365_1.hightColor2.r, var_368_18)
								local var_368_20 = Mathf.Lerp(iter_368_6.color.g, arg_365_1.hightColor2.g, var_368_18)
								local var_368_21 = Mathf.Lerp(iter_368_6.color.b, arg_365_1.hightColor2.b, var_368_18)

								iter_368_6.color = Color.New(var_368_19, var_368_20, var_368_21)
							else
								local var_368_22 = Mathf.Lerp(iter_368_6.color.r, 0.5, var_368_18)

								iter_368_6.color = Color.New(var_368_22, var_368_22, var_368_22)
							end
						end
					end
				end
			end

			if arg_365_1.time_ >= var_368_16 + var_368_17 and arg_365_1.time_ < var_368_16 + var_368_17 + arg_368_0 and not isNil(var_368_15) and arg_365_1.var_.actorSpriteComps1012 then
				for iter_368_7, iter_368_8 in pairs(arg_365_1.var_.actorSpriteComps1012:ToTable()) do
					if iter_368_8 then
						if arg_365_1.isInRecall_ then
							iter_368_8.color = arg_365_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_368_8.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_365_1.var_.actorSpriteComps1012 = nil
			end

			local var_368_23 = 0
			local var_368_24 = 0.25

			if var_368_23 < arg_365_1.time_ and arg_365_1.time_ <= var_368_23 + arg_368_0 then
				arg_365_1.talkMaxDuration = 0
				arg_365_1.dialogCg_.alpha = 1

				arg_365_1.dialog_:SetActive(true)
				SetActive(arg_365_1.leftNameGo_, true)

				local var_368_25 = arg_365_1:FormatText(StoryNameCfg[584].name)

				arg_365_1.leftNameTxt_.text = var_368_25

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_365_1.leftNameTxt_.transform)

				arg_365_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_365_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_365_1:RecordName(arg_365_1.leftNameTxt_.text)
				SetActive(arg_365_1.iconTrs_.gameObject, false)
				arg_365_1.callingController_:SetSelectedState("normal")

				local var_368_26 = arg_365_1:GetWordFromCfg(410082089)
				local var_368_27 = arg_365_1:FormatText(var_368_26.content)

				arg_365_1.text_.text = var_368_27

				LuaForUtil.ClearLinePrefixSymbol(arg_365_1.text_)

				local var_368_28 = 10
				local var_368_29 = utf8.len(var_368_27)
				local var_368_30 = var_368_28 <= 0 and var_368_24 or var_368_24 * (var_368_29 / var_368_28)

				if var_368_30 > 0 and var_368_24 < var_368_30 then
					arg_365_1.talkMaxDuration = var_368_30

					if var_368_30 + var_368_23 > arg_365_1.duration_ then
						arg_365_1.duration_ = var_368_30 + var_368_23
					end
				end

				arg_365_1.text_.text = var_368_27
				arg_365_1.typewritter.percent = 0

				arg_365_1.typewritter:SetDirty()
				arg_365_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_410082", "410082089", "story_v_out_410082.awb") ~= 0 then
					local var_368_31 = manager.audio:GetVoiceLength("story_v_out_410082", "410082089", "story_v_out_410082.awb") / 1000

					if var_368_31 + var_368_23 > arg_365_1.duration_ then
						arg_365_1.duration_ = var_368_31 + var_368_23
					end

					if var_368_26.prefab_name ~= "" and arg_365_1.actors_[var_368_26.prefab_name] ~= nil then
						local var_368_32 = LuaForUtil.PlayVoiceWithCriLipsync(arg_365_1.actors_[var_368_26.prefab_name].transform, "story_v_out_410082", "410082089", "story_v_out_410082.awb")

						arg_365_1:RecordAudio("410082089", var_368_32)
						arg_365_1:RecordAudio("410082089", var_368_32)
					else
						arg_365_1:AudioAction("play", "voice", "story_v_out_410082", "410082089", "story_v_out_410082.awb")
					end

					arg_365_1:RecordHistoryTalkVoice("story_v_out_410082", "410082089", "story_v_out_410082.awb")
				end

				arg_365_1:RecordContent(arg_365_1.text_.text)
			end

			local var_368_33 = math.max(var_368_24, arg_365_1.talkMaxDuration)

			if var_368_23 <= arg_365_1.time_ and arg_365_1.time_ < var_368_23 + var_368_33 then
				arg_365_1.typewritter.percent = (arg_365_1.time_ - var_368_23) / var_368_33

				arg_365_1.typewritter:SetDirty()
			end

			if arg_365_1.time_ >= var_368_23 + var_368_33 and arg_365_1.time_ < var_368_23 + var_368_33 + arg_368_0 then
				arg_365_1.typewritter.percent = 1

				arg_365_1.typewritter:SetDirty()
				arg_365_1:ShowNextGo(true)
			end
		end

		arg_365_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1060",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_365_1:InitPlayNodeList()
	end,
	Play410082090 = function(arg_369_0, arg_369_1)
		arg_369_1.time_ = 0
		arg_369_1.frameCnt_ = 0
		arg_369_1.state_ = "playing"
		arg_369_1.curTalkId_ = 410082090
		arg_369_1.duration_ = 6.83

		local var_369_0 = {
			zh = 2.833,
			ja = 6.833
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
				arg_369_0:Play410082091(arg_369_1)
			end
		end

		function arg_369_1.onSingleLineUpdate_(arg_372_0)
			local var_372_0 = arg_369_1.actors_["1012"].transform
			local var_372_1 = 0

			if var_372_1 < arg_369_1.time_ and arg_369_1.time_ <= var_372_1 + arg_372_0 then
				arg_369_1.var_.moveOldPos1012 = var_372_0.localPosition
				var_372_0.localScale = Vector3.New(1, 1, 1)

				arg_369_1:CheckSpriteTmpPos("1012", 4)

				local var_372_2 = var_372_0.childCount

				for iter_372_0 = 0, var_372_2 - 1 do
					local var_372_3 = var_372_0:GetChild(iter_372_0)

					if var_372_3.name == "split_3" or not string.find(var_372_3.name, "split") then
						var_372_3.gameObject:SetActive(true)
					else
						var_372_3.gameObject:SetActive(false)
					end
				end
			end

			local var_372_4 = 0.001

			if var_372_1 <= arg_369_1.time_ and arg_369_1.time_ < var_372_1 + var_372_4 then
				local var_372_5 = (arg_369_1.time_ - var_372_1) / var_372_4
				local var_372_6 = Vector3.New(390, -465, 300)

				var_372_0.localPosition = Vector3.Lerp(arg_369_1.var_.moveOldPos1012, var_372_6, var_372_5)
			end

			if arg_369_1.time_ >= var_372_1 + var_372_4 and arg_369_1.time_ < var_372_1 + var_372_4 + arg_372_0 then
				var_372_0.localPosition = Vector3.New(390, -465, 300)
			end

			local var_372_7 = arg_369_1.actors_["1012"]
			local var_372_8 = 0

			if var_372_8 < arg_369_1.time_ and arg_369_1.time_ <= var_372_8 + arg_372_0 and not isNil(var_372_7) and arg_369_1.var_.actorSpriteComps1012 == nil then
				arg_369_1.var_.actorSpriteComps1012 = var_372_7:GetComponentsInChildren(typeof(Image), true)
			end

			local var_372_9 = 0.034

			if var_372_8 <= arg_369_1.time_ and arg_369_1.time_ < var_372_8 + var_372_9 and not isNil(var_372_7) then
				local var_372_10 = (arg_369_1.time_ - var_372_8) / var_372_9

				if arg_369_1.var_.actorSpriteComps1012 then
					for iter_372_1, iter_372_2 in pairs(arg_369_1.var_.actorSpriteComps1012:ToTable()) do
						if iter_372_2 then
							if arg_369_1.isInRecall_ then
								local var_372_11 = Mathf.Lerp(iter_372_2.color.r, arg_369_1.hightColor1.r, var_372_10)
								local var_372_12 = Mathf.Lerp(iter_372_2.color.g, arg_369_1.hightColor1.g, var_372_10)
								local var_372_13 = Mathf.Lerp(iter_372_2.color.b, arg_369_1.hightColor1.b, var_372_10)

								iter_372_2.color = Color.New(var_372_11, var_372_12, var_372_13)
							else
								local var_372_14 = Mathf.Lerp(iter_372_2.color.r, 1, var_372_10)

								iter_372_2.color = Color.New(var_372_14, var_372_14, var_372_14)
							end
						end
					end
				end
			end

			if arg_369_1.time_ >= var_372_8 + var_372_9 and arg_369_1.time_ < var_372_8 + var_372_9 + arg_372_0 and not isNil(var_372_7) and arg_369_1.var_.actorSpriteComps1012 then
				for iter_372_3, iter_372_4 in pairs(arg_369_1.var_.actorSpriteComps1012:ToTable()) do
					if iter_372_4 then
						if arg_369_1.isInRecall_ then
							iter_372_4.color = arg_369_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_372_4.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_369_1.var_.actorSpriteComps1012 = nil
			end

			local var_372_15 = arg_369_1.actors_["1060"]
			local var_372_16 = 0

			if var_372_16 < arg_369_1.time_ and arg_369_1.time_ <= var_372_16 + arg_372_0 and not isNil(var_372_15) and arg_369_1.var_.actorSpriteComps1060 == nil then
				arg_369_1.var_.actorSpriteComps1060 = var_372_15:GetComponentsInChildren(typeof(Image), true)
			end

			local var_372_17 = 0.034

			if var_372_16 <= arg_369_1.time_ and arg_369_1.time_ < var_372_16 + var_372_17 and not isNil(var_372_15) then
				local var_372_18 = (arg_369_1.time_ - var_372_16) / var_372_17

				if arg_369_1.var_.actorSpriteComps1060 then
					for iter_372_5, iter_372_6 in pairs(arg_369_1.var_.actorSpriteComps1060:ToTable()) do
						if iter_372_6 then
							if arg_369_1.isInRecall_ then
								local var_372_19 = Mathf.Lerp(iter_372_6.color.r, arg_369_1.hightColor2.r, var_372_18)
								local var_372_20 = Mathf.Lerp(iter_372_6.color.g, arg_369_1.hightColor2.g, var_372_18)
								local var_372_21 = Mathf.Lerp(iter_372_6.color.b, arg_369_1.hightColor2.b, var_372_18)

								iter_372_6.color = Color.New(var_372_19, var_372_20, var_372_21)
							else
								local var_372_22 = Mathf.Lerp(iter_372_6.color.r, 0.5, var_372_18)

								iter_372_6.color = Color.New(var_372_22, var_372_22, var_372_22)
							end
						end
					end
				end
			end

			if arg_369_1.time_ >= var_372_16 + var_372_17 and arg_369_1.time_ < var_372_16 + var_372_17 + arg_372_0 and not isNil(var_372_15) and arg_369_1.var_.actorSpriteComps1060 then
				for iter_372_7, iter_372_8 in pairs(arg_369_1.var_.actorSpriteComps1060:ToTable()) do
					if iter_372_8 then
						if arg_369_1.isInRecall_ then
							iter_372_8.color = arg_369_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_372_8.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_369_1.var_.actorSpriteComps1060 = nil
			end

			local var_372_23 = 0
			local var_372_24 = 0.4

			if var_372_23 < arg_369_1.time_ and arg_369_1.time_ <= var_372_23 + arg_372_0 then
				arg_369_1.talkMaxDuration = 0
				arg_369_1.dialogCg_.alpha = 1

				arg_369_1.dialog_:SetActive(true)
				SetActive(arg_369_1.leftNameGo_, true)

				local var_372_25 = arg_369_1:FormatText(StoryNameCfg[595].name)

				arg_369_1.leftNameTxt_.text = var_372_25

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_369_1.leftNameTxt_.transform)

				arg_369_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_369_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_369_1:RecordName(arg_369_1.leftNameTxt_.text)
				SetActive(arg_369_1.iconTrs_.gameObject, false)
				arg_369_1.callingController_:SetSelectedState("normal")

				local var_372_26 = arg_369_1:GetWordFromCfg(410082090)
				local var_372_27 = arg_369_1:FormatText(var_372_26.content)

				arg_369_1.text_.text = var_372_27

				LuaForUtil.ClearLinePrefixSymbol(arg_369_1.text_)

				local var_372_28 = 16
				local var_372_29 = utf8.len(var_372_27)
				local var_372_30 = var_372_28 <= 0 and var_372_24 or var_372_24 * (var_372_29 / var_372_28)

				if var_372_30 > 0 and var_372_24 < var_372_30 then
					arg_369_1.talkMaxDuration = var_372_30

					if var_372_30 + var_372_23 > arg_369_1.duration_ then
						arg_369_1.duration_ = var_372_30 + var_372_23
					end
				end

				arg_369_1.text_.text = var_372_27
				arg_369_1.typewritter.percent = 0

				arg_369_1.typewritter:SetDirty()
				arg_369_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_410082", "410082090", "story_v_out_410082.awb") ~= 0 then
					local var_372_31 = manager.audio:GetVoiceLength("story_v_out_410082", "410082090", "story_v_out_410082.awb") / 1000

					if var_372_31 + var_372_23 > arg_369_1.duration_ then
						arg_369_1.duration_ = var_372_31 + var_372_23
					end

					if var_372_26.prefab_name ~= "" and arg_369_1.actors_[var_372_26.prefab_name] ~= nil then
						local var_372_32 = LuaForUtil.PlayVoiceWithCriLipsync(arg_369_1.actors_[var_372_26.prefab_name].transform, "story_v_out_410082", "410082090", "story_v_out_410082.awb")

						arg_369_1:RecordAudio("410082090", var_372_32)
						arg_369_1:RecordAudio("410082090", var_372_32)
					else
						arg_369_1:AudioAction("play", "voice", "story_v_out_410082", "410082090", "story_v_out_410082.awb")
					end

					arg_369_1:RecordHistoryTalkVoice("story_v_out_410082", "410082090", "story_v_out_410082.awb")
				end

				arg_369_1:RecordContent(arg_369_1.text_.text)
			end

			local var_372_33 = math.max(var_372_24, arg_369_1.talkMaxDuration)

			if var_372_23 <= arg_369_1.time_ and arg_369_1.time_ < var_372_23 + var_372_33 then
				arg_369_1.typewritter.percent = (arg_369_1.time_ - var_372_23) / var_372_33

				arg_369_1.typewritter:SetDirty()
			end

			if arg_369_1.time_ >= var_372_23 + var_372_33 and arg_369_1.time_ < var_372_23 + var_372_33 + arg_372_0 then
				arg_369_1.typewritter.percent = 1

				arg_369_1.typewritter:SetDirty()
				arg_369_1:ShowNextGo(true)
			end
		end

		arg_369_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1012",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_369_1:InitPlayNodeList()
	end,
	Play410082091 = function(arg_373_0, arg_373_1)
		arg_373_1.time_ = 0
		arg_373_1.frameCnt_ = 0
		arg_373_1.state_ = "playing"
		arg_373_1.curTalkId_ = 410082091
		arg_373_1.duration_ = 5.93

		local var_373_0 = {
			zh = 2.733,
			ja = 5.933
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
				arg_373_0:Play410082092(arg_373_1)
			end
		end

		function arg_373_1.onSingleLineUpdate_(arg_376_0)
			local var_376_0 = arg_373_1.actors_["1060"].transform
			local var_376_1 = 0

			if var_376_1 < arg_373_1.time_ and arg_373_1.time_ <= var_376_1 + arg_376_0 then
				arg_373_1.var_.moveOldPos1060 = var_376_0.localPosition
				var_376_0.localScale = Vector3.New(1, 1, 1)

				arg_373_1:CheckSpriteTmpPos("1060", 2)

				local var_376_2 = var_376_0.childCount

				for iter_376_0 = 0, var_376_2 - 1 do
					local var_376_3 = var_376_0:GetChild(iter_376_0)

					if var_376_3.name == "split_3" or not string.find(var_376_3.name, "split") then
						var_376_3.gameObject:SetActive(true)
					else
						var_376_3.gameObject:SetActive(false)
					end
				end
			end

			local var_376_4 = 0.001

			if var_376_1 <= arg_373_1.time_ and arg_373_1.time_ < var_376_1 + var_376_4 then
				local var_376_5 = (arg_373_1.time_ - var_376_1) / var_376_4
				local var_376_6 = Vector3.New(-440.94, -430.8, 6.9)

				var_376_0.localPosition = Vector3.Lerp(arg_373_1.var_.moveOldPos1060, var_376_6, var_376_5)
			end

			if arg_373_1.time_ >= var_376_1 + var_376_4 and arg_373_1.time_ < var_376_1 + var_376_4 + arg_376_0 then
				var_376_0.localPosition = Vector3.New(-440.94, -430.8, 6.9)
			end

			local var_376_7 = arg_373_1.actors_["1060"]
			local var_376_8 = 0

			if var_376_8 < arg_373_1.time_ and arg_373_1.time_ <= var_376_8 + arg_376_0 and not isNil(var_376_7) and arg_373_1.var_.actorSpriteComps1060 == nil then
				arg_373_1.var_.actorSpriteComps1060 = var_376_7:GetComponentsInChildren(typeof(Image), true)
			end

			local var_376_9 = 0.034

			if var_376_8 <= arg_373_1.time_ and arg_373_1.time_ < var_376_8 + var_376_9 and not isNil(var_376_7) then
				local var_376_10 = (arg_373_1.time_ - var_376_8) / var_376_9

				if arg_373_1.var_.actorSpriteComps1060 then
					for iter_376_1, iter_376_2 in pairs(arg_373_1.var_.actorSpriteComps1060:ToTable()) do
						if iter_376_2 then
							if arg_373_1.isInRecall_ then
								local var_376_11 = Mathf.Lerp(iter_376_2.color.r, arg_373_1.hightColor1.r, var_376_10)
								local var_376_12 = Mathf.Lerp(iter_376_2.color.g, arg_373_1.hightColor1.g, var_376_10)
								local var_376_13 = Mathf.Lerp(iter_376_2.color.b, arg_373_1.hightColor1.b, var_376_10)

								iter_376_2.color = Color.New(var_376_11, var_376_12, var_376_13)
							else
								local var_376_14 = Mathf.Lerp(iter_376_2.color.r, 1, var_376_10)

								iter_376_2.color = Color.New(var_376_14, var_376_14, var_376_14)
							end
						end
					end
				end
			end

			if arg_373_1.time_ >= var_376_8 + var_376_9 and arg_373_1.time_ < var_376_8 + var_376_9 + arg_376_0 and not isNil(var_376_7) and arg_373_1.var_.actorSpriteComps1060 then
				for iter_376_3, iter_376_4 in pairs(arg_373_1.var_.actorSpriteComps1060:ToTable()) do
					if iter_376_4 then
						if arg_373_1.isInRecall_ then
							iter_376_4.color = arg_373_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_376_4.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_373_1.var_.actorSpriteComps1060 = nil
			end

			local var_376_15 = arg_373_1.actors_["1012"]
			local var_376_16 = 0

			if var_376_16 < arg_373_1.time_ and arg_373_1.time_ <= var_376_16 + arg_376_0 and not isNil(var_376_15) and arg_373_1.var_.actorSpriteComps1012 == nil then
				arg_373_1.var_.actorSpriteComps1012 = var_376_15:GetComponentsInChildren(typeof(Image), true)
			end

			local var_376_17 = 0.034

			if var_376_16 <= arg_373_1.time_ and arg_373_1.time_ < var_376_16 + var_376_17 and not isNil(var_376_15) then
				local var_376_18 = (arg_373_1.time_ - var_376_16) / var_376_17

				if arg_373_1.var_.actorSpriteComps1012 then
					for iter_376_5, iter_376_6 in pairs(arg_373_1.var_.actorSpriteComps1012:ToTable()) do
						if iter_376_6 then
							if arg_373_1.isInRecall_ then
								local var_376_19 = Mathf.Lerp(iter_376_6.color.r, arg_373_1.hightColor2.r, var_376_18)
								local var_376_20 = Mathf.Lerp(iter_376_6.color.g, arg_373_1.hightColor2.g, var_376_18)
								local var_376_21 = Mathf.Lerp(iter_376_6.color.b, arg_373_1.hightColor2.b, var_376_18)

								iter_376_6.color = Color.New(var_376_19, var_376_20, var_376_21)
							else
								local var_376_22 = Mathf.Lerp(iter_376_6.color.r, 0.5, var_376_18)

								iter_376_6.color = Color.New(var_376_22, var_376_22, var_376_22)
							end
						end
					end
				end
			end

			if arg_373_1.time_ >= var_376_16 + var_376_17 and arg_373_1.time_ < var_376_16 + var_376_17 + arg_376_0 and not isNil(var_376_15) and arg_373_1.var_.actorSpriteComps1012 then
				for iter_376_7, iter_376_8 in pairs(arg_373_1.var_.actorSpriteComps1012:ToTable()) do
					if iter_376_8 then
						if arg_373_1.isInRecall_ then
							iter_376_8.color = arg_373_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_376_8.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_373_1.var_.actorSpriteComps1012 = nil
			end

			local var_376_23 = 0
			local var_376_24 = 0.35

			if var_376_23 < arg_373_1.time_ and arg_373_1.time_ <= var_376_23 + arg_376_0 then
				arg_373_1.talkMaxDuration = 0
				arg_373_1.dialogCg_.alpha = 1

				arg_373_1.dialog_:SetActive(true)
				SetActive(arg_373_1.leftNameGo_, true)

				local var_376_25 = arg_373_1:FormatText(StoryNameCfg[584].name)

				arg_373_1.leftNameTxt_.text = var_376_25

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_373_1.leftNameTxt_.transform)

				arg_373_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_373_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_373_1:RecordName(arg_373_1.leftNameTxt_.text)
				SetActive(arg_373_1.iconTrs_.gameObject, false)
				arg_373_1.callingController_:SetSelectedState("normal")

				local var_376_26 = arg_373_1:GetWordFromCfg(410082091)
				local var_376_27 = arg_373_1:FormatText(var_376_26.content)

				arg_373_1.text_.text = var_376_27

				LuaForUtil.ClearLinePrefixSymbol(arg_373_1.text_)

				local var_376_28 = 14
				local var_376_29 = utf8.len(var_376_27)
				local var_376_30 = var_376_28 <= 0 and var_376_24 or var_376_24 * (var_376_29 / var_376_28)

				if var_376_30 > 0 and var_376_24 < var_376_30 then
					arg_373_1.talkMaxDuration = var_376_30

					if var_376_30 + var_376_23 > arg_373_1.duration_ then
						arg_373_1.duration_ = var_376_30 + var_376_23
					end
				end

				arg_373_1.text_.text = var_376_27
				arg_373_1.typewritter.percent = 0

				arg_373_1.typewritter:SetDirty()
				arg_373_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_410082", "410082091", "story_v_out_410082.awb") ~= 0 then
					local var_376_31 = manager.audio:GetVoiceLength("story_v_out_410082", "410082091", "story_v_out_410082.awb") / 1000

					if var_376_31 + var_376_23 > arg_373_1.duration_ then
						arg_373_1.duration_ = var_376_31 + var_376_23
					end

					if var_376_26.prefab_name ~= "" and arg_373_1.actors_[var_376_26.prefab_name] ~= nil then
						local var_376_32 = LuaForUtil.PlayVoiceWithCriLipsync(arg_373_1.actors_[var_376_26.prefab_name].transform, "story_v_out_410082", "410082091", "story_v_out_410082.awb")

						arg_373_1:RecordAudio("410082091", var_376_32)
						arg_373_1:RecordAudio("410082091", var_376_32)
					else
						arg_373_1:AudioAction("play", "voice", "story_v_out_410082", "410082091", "story_v_out_410082.awb")
					end

					arg_373_1:RecordHistoryTalkVoice("story_v_out_410082", "410082091", "story_v_out_410082.awb")
				end

				arg_373_1:RecordContent(arg_373_1.text_.text)
			end

			local var_376_33 = math.max(var_376_24, arg_373_1.talkMaxDuration)

			if var_376_23 <= arg_373_1.time_ and arg_373_1.time_ < var_376_23 + var_376_33 then
				arg_373_1.typewritter.percent = (arg_373_1.time_ - var_376_23) / var_376_33

				arg_373_1.typewritter:SetDirty()
			end

			if arg_373_1.time_ >= var_376_23 + var_376_33 and arg_373_1.time_ < var_376_23 + var_376_33 + arg_376_0 then
				arg_373_1.typewritter.percent = 1

				arg_373_1.typewritter:SetDirty()
				arg_373_1:ShowNextGo(true)
			end
		end

		arg_373_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1060",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_373_1:InitPlayNodeList()
	end,
	Play410082092 = function(arg_377_0, arg_377_1)
		arg_377_1.time_ = 0
		arg_377_1.frameCnt_ = 0
		arg_377_1.state_ = "playing"
		arg_377_1.curTalkId_ = 410082092
		arg_377_1.duration_ = 5

		SetActive(arg_377_1.tipsGo_, false)

		function arg_377_1.onSingleLineFinish_()
			arg_377_1.onSingleLineUpdate_ = nil
			arg_377_1.onSingleLineFinish_ = nil
			arg_377_1.state_ = "waiting"
		end

		function arg_377_1.playNext_(arg_379_0)
			if arg_379_0 == 1 then
				arg_377_0:Play410082093(arg_377_1)
			end
		end

		function arg_377_1.onSingleLineUpdate_(arg_380_0)
			local var_380_0 = arg_377_1.actors_["1060"].transform
			local var_380_1 = 0

			if var_380_1 < arg_377_1.time_ and arg_377_1.time_ <= var_380_1 + arg_380_0 then
				arg_377_1.var_.moveOldPos1060 = var_380_0.localPosition
				var_380_0.localScale = Vector3.New(1, 1, 1)

				arg_377_1:CheckSpriteTmpPos("1060", 7)

				local var_380_2 = var_380_0.childCount

				for iter_380_0 = 0, var_380_2 - 1 do
					local var_380_3 = var_380_0:GetChild(iter_380_0)

					if var_380_3.name == "" or not string.find(var_380_3.name, "split") then
						var_380_3.gameObject:SetActive(true)
					else
						var_380_3.gameObject:SetActive(false)
					end
				end
			end

			local var_380_4 = 0.001

			if var_380_1 <= arg_377_1.time_ and arg_377_1.time_ < var_380_1 + var_380_4 then
				local var_380_5 = (arg_377_1.time_ - var_380_1) / var_380_4
				local var_380_6 = Vector3.New(0, -2000, -40)

				var_380_0.localPosition = Vector3.Lerp(arg_377_1.var_.moveOldPos1060, var_380_6, var_380_5)
			end

			if arg_377_1.time_ >= var_380_1 + var_380_4 and arg_377_1.time_ < var_380_1 + var_380_4 + arg_380_0 then
				var_380_0.localPosition = Vector3.New(0, -2000, -40)
			end

			local var_380_7 = arg_377_1.actors_["1012"].transform
			local var_380_8 = 0

			if var_380_8 < arg_377_1.time_ and arg_377_1.time_ <= var_380_8 + arg_380_0 then
				arg_377_1.var_.moveOldPos1012 = var_380_7.localPosition
				var_380_7.localScale = Vector3.New(1, 1, 1)

				arg_377_1:CheckSpriteTmpPos("1012", 7)

				local var_380_9 = var_380_7.childCount

				for iter_380_1 = 0, var_380_9 - 1 do
					local var_380_10 = var_380_7:GetChild(iter_380_1)

					if var_380_10.name == "" or not string.find(var_380_10.name, "split") then
						var_380_10.gameObject:SetActive(true)
					else
						var_380_10.gameObject:SetActive(false)
					end
				end
			end

			local var_380_11 = 0.001

			if var_380_8 <= arg_377_1.time_ and arg_377_1.time_ < var_380_8 + var_380_11 then
				local var_380_12 = (arg_377_1.time_ - var_380_8) / var_380_11
				local var_380_13 = Vector3.New(0, -2000, 300)

				var_380_7.localPosition = Vector3.Lerp(arg_377_1.var_.moveOldPos1012, var_380_13, var_380_12)
			end

			if arg_377_1.time_ >= var_380_8 + var_380_11 and arg_377_1.time_ < var_380_8 + var_380_11 + arg_380_0 then
				var_380_7.localPosition = Vector3.New(0, -2000, 300)
			end

			local var_380_14 = 0
			local var_380_15 = 1.45

			if var_380_14 < arg_377_1.time_ and arg_377_1.time_ <= var_380_14 + arg_380_0 then
				arg_377_1.talkMaxDuration = 0
				arg_377_1.dialogCg_.alpha = 1

				arg_377_1.dialog_:SetActive(true)
				SetActive(arg_377_1.leftNameGo_, false)

				arg_377_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_377_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_377_1:RecordName(arg_377_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_377_1.iconTrs_.gameObject, false)
				arg_377_1.callingController_:SetSelectedState("normal")

				local var_380_16 = arg_377_1:GetWordFromCfg(410082092)
				local var_380_17 = arg_377_1:FormatText(var_380_16.content)

				arg_377_1.text_.text = var_380_17

				LuaForUtil.ClearLinePrefixSymbol(arg_377_1.text_)

				local var_380_18 = 58
				local var_380_19 = utf8.len(var_380_17)
				local var_380_20 = var_380_18 <= 0 and var_380_15 or var_380_15 * (var_380_19 / var_380_18)

				if var_380_20 > 0 and var_380_15 < var_380_20 then
					arg_377_1.talkMaxDuration = var_380_20

					if var_380_20 + var_380_14 > arg_377_1.duration_ then
						arg_377_1.duration_ = var_380_20 + var_380_14
					end
				end

				arg_377_1.text_.text = var_380_17
				arg_377_1.typewritter.percent = 0

				arg_377_1.typewritter:SetDirty()
				arg_377_1:ShowNextGo(false)
				arg_377_1:RecordContent(arg_377_1.text_.text)
			end

			local var_380_21 = math.max(var_380_15, arg_377_1.talkMaxDuration)

			if var_380_14 <= arg_377_1.time_ and arg_377_1.time_ < var_380_14 + var_380_21 then
				arg_377_1.typewritter.percent = (arg_377_1.time_ - var_380_14) / var_380_21

				arg_377_1.typewritter:SetDirty()
			end

			if arg_377_1.time_ >= var_380_14 + var_380_21 and arg_377_1.time_ < var_380_14 + var_380_21 + arg_380_0 then
				arg_377_1.typewritter.percent = 1

				arg_377_1.typewritter:SetDirty()
				arg_377_1:ShowNextGo(true)
			end
		end

		arg_377_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1060",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			},
			{
				assetPath = "",
				actorName = "1012",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_377_1:InitPlayNodeList()
	end,
	Play410082093 = function(arg_381_0, arg_381_1)
		arg_381_1.time_ = 0
		arg_381_1.frameCnt_ = 0
		arg_381_1.state_ = "playing"
		arg_381_1.curTalkId_ = 410082093
		arg_381_1.duration_ = 3.43

		local var_381_0 = {
			zh = 3.133,
			ja = 3.433
		}
		local var_381_1 = manager.audio:GetLocalizationFlag()

		if var_381_0[var_381_1] ~= nil then
			arg_381_1.duration_ = var_381_0[var_381_1]
		end

		SetActive(arg_381_1.tipsGo_, false)

		function arg_381_1.onSingleLineFinish_()
			arg_381_1.onSingleLineUpdate_ = nil
			arg_381_1.onSingleLineFinish_ = nil
			arg_381_1.state_ = "waiting"
		end

		function arg_381_1.playNext_(arg_383_0)
			if arg_383_0 == 1 then
				arg_381_0:Play410082094(arg_381_1)
			end
		end

		function arg_381_1.onSingleLineUpdate_(arg_384_0)
			local var_384_0 = arg_381_1.actors_["1056"].transform
			local var_384_1 = 0

			if var_384_1 < arg_381_1.time_ and arg_381_1.time_ <= var_384_1 + arg_384_0 then
				arg_381_1.var_.moveOldPos1056 = var_384_0.localPosition
				var_384_0.localScale = Vector3.New(1, 1, 1)

				arg_381_1:CheckSpriteTmpPos("1056", 3)

				local var_384_2 = var_384_0.childCount

				for iter_384_0 = 0, var_384_2 - 1 do
					local var_384_3 = var_384_0:GetChild(iter_384_0)

					if var_384_3.name == "split_1" or not string.find(var_384_3.name, "split") then
						var_384_3.gameObject:SetActive(true)
					else
						var_384_3.gameObject:SetActive(false)
					end
				end
			end

			local var_384_4 = 0.001

			if var_384_1 <= arg_381_1.time_ and arg_381_1.time_ < var_384_1 + var_384_4 then
				local var_384_5 = (arg_381_1.time_ - var_384_1) / var_384_4
				local var_384_6 = Vector3.New(0, -350, -180)

				var_384_0.localPosition = Vector3.Lerp(arg_381_1.var_.moveOldPos1056, var_384_6, var_384_5)
			end

			if arg_381_1.time_ >= var_384_1 + var_384_4 and arg_381_1.time_ < var_384_1 + var_384_4 + arg_384_0 then
				var_384_0.localPosition = Vector3.New(0, -350, -180)
			end

			local var_384_7 = arg_381_1.actors_["1056"]
			local var_384_8 = 0

			if var_384_8 < arg_381_1.time_ and arg_381_1.time_ <= var_384_8 + arg_384_0 and not isNil(var_384_7) and arg_381_1.var_.actorSpriteComps1056 == nil then
				arg_381_1.var_.actorSpriteComps1056 = var_384_7:GetComponentsInChildren(typeof(Image), true)
			end

			local var_384_9 = 0.034

			if var_384_8 <= arg_381_1.time_ and arg_381_1.time_ < var_384_8 + var_384_9 and not isNil(var_384_7) then
				local var_384_10 = (arg_381_1.time_ - var_384_8) / var_384_9

				if arg_381_1.var_.actorSpriteComps1056 then
					for iter_384_1, iter_384_2 in pairs(arg_381_1.var_.actorSpriteComps1056:ToTable()) do
						if iter_384_2 then
							if arg_381_1.isInRecall_ then
								local var_384_11 = Mathf.Lerp(iter_384_2.color.r, arg_381_1.hightColor1.r, var_384_10)
								local var_384_12 = Mathf.Lerp(iter_384_2.color.g, arg_381_1.hightColor1.g, var_384_10)
								local var_384_13 = Mathf.Lerp(iter_384_2.color.b, arg_381_1.hightColor1.b, var_384_10)

								iter_384_2.color = Color.New(var_384_11, var_384_12, var_384_13)
							else
								local var_384_14 = Mathf.Lerp(iter_384_2.color.r, 1, var_384_10)

								iter_384_2.color = Color.New(var_384_14, var_384_14, var_384_14)
							end
						end
					end
				end
			end

			if arg_381_1.time_ >= var_384_8 + var_384_9 and arg_381_1.time_ < var_384_8 + var_384_9 + arg_384_0 and not isNil(var_384_7) and arg_381_1.var_.actorSpriteComps1056 then
				for iter_384_3, iter_384_4 in pairs(arg_381_1.var_.actorSpriteComps1056:ToTable()) do
					if iter_384_4 then
						if arg_381_1.isInRecall_ then
							iter_384_4.color = arg_381_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_384_4.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_381_1.var_.actorSpriteComps1056 = nil
			end

			local var_384_15 = arg_381_1.actors_["1060"].transform
			local var_384_16 = 0

			if var_384_16 < arg_381_1.time_ and arg_381_1.time_ <= var_384_16 + arg_384_0 then
				arg_381_1.var_.moveOldPos1060 = var_384_15.localPosition
				var_384_15.localScale = Vector3.New(1, 1, 1)

				arg_381_1:CheckSpriteTmpPos("1060", 2)

				local var_384_17 = var_384_15.childCount

				for iter_384_5 = 0, var_384_17 - 1 do
					local var_384_18 = var_384_15:GetChild(iter_384_5)

					if var_384_18.name == "split_3" or not string.find(var_384_18.name, "split") then
						var_384_18.gameObject:SetActive(true)
					else
						var_384_18.gameObject:SetActive(false)
					end
				end
			end

			local var_384_19 = 0.001

			if var_384_16 <= arg_381_1.time_ and arg_381_1.time_ < var_384_16 + var_384_19 then
				local var_384_20 = (arg_381_1.time_ - var_384_16) / var_384_19
				local var_384_21 = Vector3.New(-440.94, -430.8, 6.9)

				var_384_15.localPosition = Vector3.Lerp(arg_381_1.var_.moveOldPos1060, var_384_21, var_384_20)
			end

			if arg_381_1.time_ >= var_384_16 + var_384_19 and arg_381_1.time_ < var_384_16 + var_384_19 + arg_384_0 then
				var_384_15.localPosition = Vector3.New(-440.94, -430.8, 6.9)
			end

			local var_384_22 = arg_381_1.actors_["1012"].transform
			local var_384_23 = 0

			if var_384_23 < arg_381_1.time_ and arg_381_1.time_ <= var_384_23 + arg_384_0 then
				arg_381_1.var_.moveOldPos1012 = var_384_22.localPosition
				var_384_22.localScale = Vector3.New(1, 1, 1)

				arg_381_1:CheckSpriteTmpPos("1012", 4)

				local var_384_24 = var_384_22.childCount

				for iter_384_6 = 0, var_384_24 - 1 do
					local var_384_25 = var_384_22:GetChild(iter_384_6)

					if var_384_25.name == "split_3" or not string.find(var_384_25.name, "split") then
						var_384_25.gameObject:SetActive(true)
					else
						var_384_25.gameObject:SetActive(false)
					end
				end
			end

			local var_384_26 = 0.001

			if var_384_23 <= arg_381_1.time_ and arg_381_1.time_ < var_384_23 + var_384_26 then
				local var_384_27 = (arg_381_1.time_ - var_384_23) / var_384_26
				local var_384_28 = Vector3.New(390, -465, 300)

				var_384_22.localPosition = Vector3.Lerp(arg_381_1.var_.moveOldPos1012, var_384_28, var_384_27)
			end

			if arg_381_1.time_ >= var_384_23 + var_384_26 and arg_381_1.time_ < var_384_23 + var_384_26 + arg_384_0 then
				var_384_22.localPosition = Vector3.New(390, -465, 300)
			end

			local var_384_29 = arg_381_1.actors_["1060"]
			local var_384_30 = 0

			if var_384_30 < arg_381_1.time_ and arg_381_1.time_ <= var_384_30 + arg_384_0 and not isNil(var_384_29) and arg_381_1.var_.actorSpriteComps1060 == nil then
				arg_381_1.var_.actorSpriteComps1060 = var_384_29:GetComponentsInChildren(typeof(Image), true)
			end

			local var_384_31 = 0.034

			if var_384_30 <= arg_381_1.time_ and arg_381_1.time_ < var_384_30 + var_384_31 and not isNil(var_384_29) then
				local var_384_32 = (arg_381_1.time_ - var_384_30) / var_384_31

				if arg_381_1.var_.actorSpriteComps1060 then
					for iter_384_7, iter_384_8 in pairs(arg_381_1.var_.actorSpriteComps1060:ToTable()) do
						if iter_384_8 then
							if arg_381_1.isInRecall_ then
								local var_384_33 = Mathf.Lerp(iter_384_8.color.r, arg_381_1.hightColor2.r, var_384_32)
								local var_384_34 = Mathf.Lerp(iter_384_8.color.g, arg_381_1.hightColor2.g, var_384_32)
								local var_384_35 = Mathf.Lerp(iter_384_8.color.b, arg_381_1.hightColor2.b, var_384_32)

								iter_384_8.color = Color.New(var_384_33, var_384_34, var_384_35)
							else
								local var_384_36 = Mathf.Lerp(iter_384_8.color.r, 0.5, var_384_32)

								iter_384_8.color = Color.New(var_384_36, var_384_36, var_384_36)
							end
						end
					end
				end
			end

			if arg_381_1.time_ >= var_384_30 + var_384_31 and arg_381_1.time_ < var_384_30 + var_384_31 + arg_384_0 and not isNil(var_384_29) and arg_381_1.var_.actorSpriteComps1060 then
				for iter_384_9, iter_384_10 in pairs(arg_381_1.var_.actorSpriteComps1060:ToTable()) do
					if iter_384_10 then
						if arg_381_1.isInRecall_ then
							iter_384_10.color = arg_381_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_384_10.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_381_1.var_.actorSpriteComps1060 = nil
			end

			local var_384_37 = arg_381_1.actors_["1012"]
			local var_384_38 = 0

			if var_384_38 < arg_381_1.time_ and arg_381_1.time_ <= var_384_38 + arg_384_0 and not isNil(var_384_37) and arg_381_1.var_.actorSpriteComps1012 == nil then
				arg_381_1.var_.actorSpriteComps1012 = var_384_37:GetComponentsInChildren(typeof(Image), true)
			end

			local var_384_39 = 0.034

			if var_384_38 <= arg_381_1.time_ and arg_381_1.time_ < var_384_38 + var_384_39 and not isNil(var_384_37) then
				local var_384_40 = (arg_381_1.time_ - var_384_38) / var_384_39

				if arg_381_1.var_.actorSpriteComps1012 then
					for iter_384_11, iter_384_12 in pairs(arg_381_1.var_.actorSpriteComps1012:ToTable()) do
						if iter_384_12 then
							if arg_381_1.isInRecall_ then
								local var_384_41 = Mathf.Lerp(iter_384_12.color.r, arg_381_1.hightColor2.r, var_384_40)
								local var_384_42 = Mathf.Lerp(iter_384_12.color.g, arg_381_1.hightColor2.g, var_384_40)
								local var_384_43 = Mathf.Lerp(iter_384_12.color.b, arg_381_1.hightColor2.b, var_384_40)

								iter_384_12.color = Color.New(var_384_41, var_384_42, var_384_43)
							else
								local var_384_44 = Mathf.Lerp(iter_384_12.color.r, 0.5, var_384_40)

								iter_384_12.color = Color.New(var_384_44, var_384_44, var_384_44)
							end
						end
					end
				end
			end

			if arg_381_1.time_ >= var_384_38 + var_384_39 and arg_381_1.time_ < var_384_38 + var_384_39 + arg_384_0 and not isNil(var_384_37) and arg_381_1.var_.actorSpriteComps1012 then
				for iter_384_13, iter_384_14 in pairs(arg_381_1.var_.actorSpriteComps1012:ToTable()) do
					if iter_384_14 then
						if arg_381_1.isInRecall_ then
							iter_384_14.color = arg_381_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_384_14.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_381_1.var_.actorSpriteComps1012 = nil
			end

			local var_384_45 = 0
			local var_384_46 = 0.125

			if var_384_45 < arg_381_1.time_ and arg_381_1.time_ <= var_384_45 + arg_384_0 then
				arg_381_1.talkMaxDuration = 0
				arg_381_1.dialogCg_.alpha = 1

				arg_381_1.dialog_:SetActive(true)
				SetActive(arg_381_1.leftNameGo_, true)

				local var_384_47 = arg_381_1:FormatText(StoryNameCfg[605].name)

				arg_381_1.leftNameTxt_.text = var_384_47

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_381_1.leftNameTxt_.transform)

				arg_381_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_381_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_381_1:RecordName(arg_381_1.leftNameTxt_.text)
				SetActive(arg_381_1.iconTrs_.gameObject, false)
				arg_381_1.callingController_:SetSelectedState("normal")

				local var_384_48 = arg_381_1:GetWordFromCfg(410082093)
				local var_384_49 = arg_381_1:FormatText(var_384_48.content)

				arg_381_1.text_.text = var_384_49

				LuaForUtil.ClearLinePrefixSymbol(arg_381_1.text_)

				local var_384_50 = 5
				local var_384_51 = utf8.len(var_384_49)
				local var_384_52 = var_384_50 <= 0 and var_384_46 or var_384_46 * (var_384_51 / var_384_50)

				if var_384_52 > 0 and var_384_46 < var_384_52 then
					arg_381_1.talkMaxDuration = var_384_52

					if var_384_52 + var_384_45 > arg_381_1.duration_ then
						arg_381_1.duration_ = var_384_52 + var_384_45
					end
				end

				arg_381_1.text_.text = var_384_49
				arg_381_1.typewritter.percent = 0

				arg_381_1.typewritter:SetDirty()
				arg_381_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_410082", "410082093", "story_v_out_410082.awb") ~= 0 then
					local var_384_53 = manager.audio:GetVoiceLength("story_v_out_410082", "410082093", "story_v_out_410082.awb") / 1000

					if var_384_53 + var_384_45 > arg_381_1.duration_ then
						arg_381_1.duration_ = var_384_53 + var_384_45
					end

					if var_384_48.prefab_name ~= "" and arg_381_1.actors_[var_384_48.prefab_name] ~= nil then
						local var_384_54 = LuaForUtil.PlayVoiceWithCriLipsync(arg_381_1.actors_[var_384_48.prefab_name].transform, "story_v_out_410082", "410082093", "story_v_out_410082.awb")

						arg_381_1:RecordAudio("410082093", var_384_54)
						arg_381_1:RecordAudio("410082093", var_384_54)
					else
						arg_381_1:AudioAction("play", "voice", "story_v_out_410082", "410082093", "story_v_out_410082.awb")
					end

					arg_381_1:RecordHistoryTalkVoice("story_v_out_410082", "410082093", "story_v_out_410082.awb")
				end

				arg_381_1:RecordContent(arg_381_1.text_.text)
			end

			local var_384_55 = math.max(var_384_46, arg_381_1.talkMaxDuration)

			if var_384_45 <= arg_381_1.time_ and arg_381_1.time_ < var_384_45 + var_384_55 then
				arg_381_1.typewritter.percent = (arg_381_1.time_ - var_384_45) / var_384_55

				arg_381_1.typewritter:SetDirty()
			end

			if arg_381_1.time_ >= var_384_45 + var_384_55 and arg_381_1.time_ < var_384_45 + var_384_55 + arg_384_0 then
				arg_381_1.typewritter.percent = 1

				arg_381_1.typewritter:SetDirty()
				arg_381_1:ShowNextGo(true)
			end
		end

		arg_381_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1056",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			},
			{
				assetPath = "",
				actorName = "1060",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			},
			{
				assetPath = "",
				actorName = "1012",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_381_1:InitPlayNodeList()
	end,
	Play410082094 = function(arg_385_0, arg_385_1)
		arg_385_1.time_ = 0
		arg_385_1.frameCnt_ = 0
		arg_385_1.state_ = "playing"
		arg_385_1.curTalkId_ = 410082094
		arg_385_1.duration_ = 2.77

		local var_385_0 = {
			zh = 1.033,
			ja = 2.766
		}
		local var_385_1 = manager.audio:GetLocalizationFlag()

		if var_385_0[var_385_1] ~= nil then
			arg_385_1.duration_ = var_385_0[var_385_1]
		end

		SetActive(arg_385_1.tipsGo_, false)

		function arg_385_1.onSingleLineFinish_()
			arg_385_1.onSingleLineUpdate_ = nil
			arg_385_1.onSingleLineFinish_ = nil
			arg_385_1.state_ = "waiting"
		end

		function arg_385_1.playNext_(arg_387_0)
			if arg_387_0 == 1 then
				arg_385_0:Play410082095(arg_385_1)
			end
		end

		function arg_385_1.onSingleLineUpdate_(arg_388_0)
			local var_388_0 = arg_385_1.actors_["1060"].transform
			local var_388_1 = 0

			if var_388_1 < arg_385_1.time_ and arg_385_1.time_ <= var_388_1 + arg_388_0 then
				arg_385_1.var_.moveOldPos1060 = var_388_0.localPosition
				var_388_0.localScale = Vector3.New(1, 1, 1)

				arg_385_1:CheckSpriteTmpPos("1060", 2)

				local var_388_2 = var_388_0.childCount

				for iter_388_0 = 0, var_388_2 - 1 do
					local var_388_3 = var_388_0:GetChild(iter_388_0)

					if var_388_3.name == "" or not string.find(var_388_3.name, "split") then
						var_388_3.gameObject:SetActive(true)
					else
						var_388_3.gameObject:SetActive(false)
					end
				end
			end

			local var_388_4 = 0.001

			if var_388_1 <= arg_385_1.time_ and arg_385_1.time_ < var_388_1 + var_388_4 then
				local var_388_5 = (arg_385_1.time_ - var_388_1) / var_388_4
				local var_388_6 = Vector3.New(-440.94, -430.8, 6.9)

				var_388_0.localPosition = Vector3.Lerp(arg_385_1.var_.moveOldPos1060, var_388_6, var_388_5)
			end

			if arg_385_1.time_ >= var_388_1 + var_388_4 and arg_385_1.time_ < var_388_1 + var_388_4 + arg_388_0 then
				var_388_0.localPosition = Vector3.New(-440.94, -430.8, 6.9)
			end

			local var_388_7 = arg_385_1.actors_["1012"].transform
			local var_388_8 = 0

			if var_388_8 < arg_385_1.time_ and arg_385_1.time_ <= var_388_8 + arg_388_0 then
				arg_385_1.var_.moveOldPos1012 = var_388_7.localPosition
				var_388_7.localScale = Vector3.New(1, 1, 1)

				arg_385_1:CheckSpriteTmpPos("1012", 4)

				local var_388_9 = var_388_7.childCount

				for iter_388_1 = 0, var_388_9 - 1 do
					local var_388_10 = var_388_7:GetChild(iter_388_1)

					if var_388_10.name == "" or not string.find(var_388_10.name, "split") then
						var_388_10.gameObject:SetActive(true)
					else
						var_388_10.gameObject:SetActive(false)
					end
				end
			end

			local var_388_11 = 0.001

			if var_388_8 <= arg_385_1.time_ and arg_385_1.time_ < var_388_8 + var_388_11 then
				local var_388_12 = (arg_385_1.time_ - var_388_8) / var_388_11
				local var_388_13 = Vector3.New(390, -465, 300)

				var_388_7.localPosition = Vector3.Lerp(arg_385_1.var_.moveOldPos1012, var_388_13, var_388_12)
			end

			if arg_385_1.time_ >= var_388_8 + var_388_11 and arg_385_1.time_ < var_388_8 + var_388_11 + arg_388_0 then
				var_388_7.localPosition = Vector3.New(390, -465, 300)
			end

			local var_388_14 = arg_385_1.actors_["1060"]
			local var_388_15 = 0

			if var_388_15 < arg_385_1.time_ and arg_385_1.time_ <= var_388_15 + arg_388_0 and not isNil(var_388_14) and arg_385_1.var_.actorSpriteComps1060 == nil then
				arg_385_1.var_.actorSpriteComps1060 = var_388_14:GetComponentsInChildren(typeof(Image), true)
			end

			local var_388_16 = 0.034

			if var_388_15 <= arg_385_1.time_ and arg_385_1.time_ < var_388_15 + var_388_16 and not isNil(var_388_14) then
				local var_388_17 = (arg_385_1.time_ - var_388_15) / var_388_16

				if arg_385_1.var_.actorSpriteComps1060 then
					for iter_388_2, iter_388_3 in pairs(arg_385_1.var_.actorSpriteComps1060:ToTable()) do
						if iter_388_3 then
							if arg_385_1.isInRecall_ then
								local var_388_18 = Mathf.Lerp(iter_388_3.color.r, arg_385_1.hightColor1.r, var_388_17)
								local var_388_19 = Mathf.Lerp(iter_388_3.color.g, arg_385_1.hightColor1.g, var_388_17)
								local var_388_20 = Mathf.Lerp(iter_388_3.color.b, arg_385_1.hightColor1.b, var_388_17)

								iter_388_3.color = Color.New(var_388_18, var_388_19, var_388_20)
							else
								local var_388_21 = Mathf.Lerp(iter_388_3.color.r, 1, var_388_17)

								iter_388_3.color = Color.New(var_388_21, var_388_21, var_388_21)
							end
						end
					end
				end
			end

			if arg_385_1.time_ >= var_388_15 + var_388_16 and arg_385_1.time_ < var_388_15 + var_388_16 + arg_388_0 and not isNil(var_388_14) and arg_385_1.var_.actorSpriteComps1060 then
				for iter_388_4, iter_388_5 in pairs(arg_385_1.var_.actorSpriteComps1060:ToTable()) do
					if iter_388_5 then
						if arg_385_1.isInRecall_ then
							iter_388_5.color = arg_385_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_388_5.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_385_1.var_.actorSpriteComps1060 = nil
			end

			local var_388_22 = arg_385_1.actors_["1012"]
			local var_388_23 = 0

			if var_388_23 < arg_385_1.time_ and arg_385_1.time_ <= var_388_23 + arg_388_0 and not isNil(var_388_22) and arg_385_1.var_.actorSpriteComps1012 == nil then
				arg_385_1.var_.actorSpriteComps1012 = var_388_22:GetComponentsInChildren(typeof(Image), true)
			end

			local var_388_24 = 0.034

			if var_388_23 <= arg_385_1.time_ and arg_385_1.time_ < var_388_23 + var_388_24 and not isNil(var_388_22) then
				local var_388_25 = (arg_385_1.time_ - var_388_23) / var_388_24

				if arg_385_1.var_.actorSpriteComps1012 then
					for iter_388_6, iter_388_7 in pairs(arg_385_1.var_.actorSpriteComps1012:ToTable()) do
						if iter_388_7 then
							if arg_385_1.isInRecall_ then
								local var_388_26 = Mathf.Lerp(iter_388_7.color.r, arg_385_1.hightColor1.r, var_388_25)
								local var_388_27 = Mathf.Lerp(iter_388_7.color.g, arg_385_1.hightColor1.g, var_388_25)
								local var_388_28 = Mathf.Lerp(iter_388_7.color.b, arg_385_1.hightColor1.b, var_388_25)

								iter_388_7.color = Color.New(var_388_26, var_388_27, var_388_28)
							else
								local var_388_29 = Mathf.Lerp(iter_388_7.color.r, 1, var_388_25)

								iter_388_7.color = Color.New(var_388_29, var_388_29, var_388_29)
							end
						end
					end
				end
			end

			if arg_385_1.time_ >= var_388_23 + var_388_24 and arg_385_1.time_ < var_388_23 + var_388_24 + arg_388_0 and not isNil(var_388_22) and arg_385_1.var_.actorSpriteComps1012 then
				for iter_388_8, iter_388_9 in pairs(arg_385_1.var_.actorSpriteComps1012:ToTable()) do
					if iter_388_9 then
						if arg_385_1.isInRecall_ then
							iter_388_9.color = arg_385_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_388_9.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_385_1.var_.actorSpriteComps1012 = nil
			end

			local var_388_30 = arg_385_1.actors_["1056"]
			local var_388_31 = 0

			if var_388_31 < arg_385_1.time_ and arg_385_1.time_ <= var_388_31 + arg_388_0 and not isNil(var_388_30) and arg_385_1.var_.actorSpriteComps1056 == nil then
				arg_385_1.var_.actorSpriteComps1056 = var_388_30:GetComponentsInChildren(typeof(Image), true)
			end

			local var_388_32 = 0.034

			if var_388_31 <= arg_385_1.time_ and arg_385_1.time_ < var_388_31 + var_388_32 and not isNil(var_388_30) then
				local var_388_33 = (arg_385_1.time_ - var_388_31) / var_388_32

				if arg_385_1.var_.actorSpriteComps1056 then
					for iter_388_10, iter_388_11 in pairs(arg_385_1.var_.actorSpriteComps1056:ToTable()) do
						if iter_388_11 then
							if arg_385_1.isInRecall_ then
								local var_388_34 = Mathf.Lerp(iter_388_11.color.r, arg_385_1.hightColor2.r, var_388_33)
								local var_388_35 = Mathf.Lerp(iter_388_11.color.g, arg_385_1.hightColor2.g, var_388_33)
								local var_388_36 = Mathf.Lerp(iter_388_11.color.b, arg_385_1.hightColor2.b, var_388_33)

								iter_388_11.color = Color.New(var_388_34, var_388_35, var_388_36)
							else
								local var_388_37 = Mathf.Lerp(iter_388_11.color.r, 0.5, var_388_33)

								iter_388_11.color = Color.New(var_388_37, var_388_37, var_388_37)
							end
						end
					end
				end
			end

			if arg_385_1.time_ >= var_388_31 + var_388_32 and arg_385_1.time_ < var_388_31 + var_388_32 + arg_388_0 and not isNil(var_388_30) and arg_385_1.var_.actorSpriteComps1056 then
				for iter_388_12, iter_388_13 in pairs(arg_385_1.var_.actorSpriteComps1056:ToTable()) do
					if iter_388_13 then
						if arg_385_1.isInRecall_ then
							iter_388_13.color = arg_385_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_388_13.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_385_1.var_.actorSpriteComps1056 = nil
			end

			local var_388_38 = 0
			local var_388_39 = 0.075

			if var_388_38 < arg_385_1.time_ and arg_385_1.time_ <= var_388_38 + arg_388_0 then
				arg_385_1.talkMaxDuration = 0
				arg_385_1.dialogCg_.alpha = 1

				arg_385_1.dialog_:SetActive(true)
				SetActive(arg_385_1.leftNameGo_, true)

				local var_388_40 = arg_385_1:FormatText(StoryNameCfg[601].name)

				arg_385_1.leftNameTxt_.text = var_388_40

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_385_1.leftNameTxt_.transform)

				arg_385_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_385_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_385_1:RecordName(arg_385_1.leftNameTxt_.text)
				SetActive(arg_385_1.iconTrs_.gameObject, false)
				arg_385_1.callingController_:SetSelectedState("normal")

				local var_388_41 = arg_385_1:GetWordFromCfg(410082094)
				local var_388_42 = arg_385_1:FormatText(var_388_41.content)

				arg_385_1.text_.text = var_388_42

				LuaForUtil.ClearLinePrefixSymbol(arg_385_1.text_)

				local var_388_43 = 3
				local var_388_44 = utf8.len(var_388_42)
				local var_388_45 = var_388_43 <= 0 and var_388_39 or var_388_39 * (var_388_44 / var_388_43)

				if var_388_45 > 0 and var_388_39 < var_388_45 then
					arg_385_1.talkMaxDuration = var_388_45

					if var_388_45 + var_388_38 > arg_385_1.duration_ then
						arg_385_1.duration_ = var_388_45 + var_388_38
					end
				end

				arg_385_1.text_.text = var_388_42
				arg_385_1.typewritter.percent = 0

				arg_385_1.typewritter:SetDirty()
				arg_385_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_410082", "410082094", "story_v_out_410082.awb") ~= 0 then
					local var_388_46 = manager.audio:GetVoiceLength("story_v_out_410082", "410082094", "story_v_out_410082.awb") / 1000

					if var_388_46 + var_388_38 > arg_385_1.duration_ then
						arg_385_1.duration_ = var_388_46 + var_388_38
					end

					if var_388_41.prefab_name ~= "" and arg_385_1.actors_[var_388_41.prefab_name] ~= nil then
						local var_388_47 = LuaForUtil.PlayVoiceWithCriLipsync(arg_385_1.actors_[var_388_41.prefab_name].transform, "story_v_out_410082", "410082094", "story_v_out_410082.awb")

						arg_385_1:RecordAudio("410082094", var_388_47)
						arg_385_1:RecordAudio("410082094", var_388_47)
					else
						arg_385_1:AudioAction("play", "voice", "story_v_out_410082", "410082094", "story_v_out_410082.awb")
					end

					arg_385_1:RecordHistoryTalkVoice("story_v_out_410082", "410082094", "story_v_out_410082.awb")
				end

				arg_385_1:RecordContent(arg_385_1.text_.text)
			end

			local var_388_48 = math.max(var_388_39, arg_385_1.talkMaxDuration)

			if var_388_38 <= arg_385_1.time_ and arg_385_1.time_ < var_388_38 + var_388_48 then
				arg_385_1.typewritter.percent = (arg_385_1.time_ - var_388_38) / var_388_48

				arg_385_1.typewritter:SetDirty()
			end

			if arg_385_1.time_ >= var_388_38 + var_388_48 and arg_385_1.time_ < var_388_38 + var_388_48 + arg_388_0 then
				arg_385_1.typewritter.percent = 1

				arg_385_1.typewritter:SetDirty()
				arg_385_1:ShowNextGo(true)
			end
		end

		arg_385_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1060",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			},
			{
				assetPath = "",
				actorName = "1012",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_385_1:InitPlayNodeList()
	end,
	Play410082095 = function(arg_389_0, arg_389_1)
		arg_389_1.time_ = 0
		arg_389_1.frameCnt_ = 0
		arg_389_1.state_ = "playing"
		arg_389_1.curTalkId_ = 410082095
		arg_389_1.duration_ = 13.53

		local var_389_0 = {
			zh = 9.366,
			ja = 13.533
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
				arg_389_0:Play410082096(arg_389_1)
			end
		end

		function arg_389_1.onSingleLineUpdate_(arg_392_0)
			local var_392_0 = arg_389_1.actors_["1056"].transform
			local var_392_1 = 0

			if var_392_1 < arg_389_1.time_ and arg_389_1.time_ <= var_392_1 + arg_392_0 then
				arg_389_1.var_.moveOldPos1056 = var_392_0.localPosition
				var_392_0.localScale = Vector3.New(1, 1, 1)

				arg_389_1:CheckSpriteTmpPos("1056", 3)

				local var_392_2 = var_392_0.childCount

				for iter_392_0 = 0, var_392_2 - 1 do
					local var_392_3 = var_392_0:GetChild(iter_392_0)

					if var_392_3.name == "split_1" or not string.find(var_392_3.name, "split") then
						var_392_3.gameObject:SetActive(true)
					else
						var_392_3.gameObject:SetActive(false)
					end
				end
			end

			local var_392_4 = 0.001

			if var_392_1 <= arg_389_1.time_ and arg_389_1.time_ < var_392_1 + var_392_4 then
				local var_392_5 = (arg_389_1.time_ - var_392_1) / var_392_4
				local var_392_6 = Vector3.New(0, -350, -180)

				var_392_0.localPosition = Vector3.Lerp(arg_389_1.var_.moveOldPos1056, var_392_6, var_392_5)
			end

			if arg_389_1.time_ >= var_392_1 + var_392_4 and arg_389_1.time_ < var_392_1 + var_392_4 + arg_392_0 then
				var_392_0.localPosition = Vector3.New(0, -350, -180)
			end

			local var_392_7 = arg_389_1.actors_["1056"]
			local var_392_8 = 0

			if var_392_8 < arg_389_1.time_ and arg_389_1.time_ <= var_392_8 + arg_392_0 and not isNil(var_392_7) and arg_389_1.var_.actorSpriteComps1056 == nil then
				arg_389_1.var_.actorSpriteComps1056 = var_392_7:GetComponentsInChildren(typeof(Image), true)
			end

			local var_392_9 = 0.034

			if var_392_8 <= arg_389_1.time_ and arg_389_1.time_ < var_392_8 + var_392_9 and not isNil(var_392_7) then
				local var_392_10 = (arg_389_1.time_ - var_392_8) / var_392_9

				if arg_389_1.var_.actorSpriteComps1056 then
					for iter_392_1, iter_392_2 in pairs(arg_389_1.var_.actorSpriteComps1056:ToTable()) do
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

			if arg_389_1.time_ >= var_392_8 + var_392_9 and arg_389_1.time_ < var_392_8 + var_392_9 + arg_392_0 and not isNil(var_392_7) and arg_389_1.var_.actorSpriteComps1056 then
				for iter_392_3, iter_392_4 in pairs(arg_389_1.var_.actorSpriteComps1056:ToTable()) do
					if iter_392_4 then
						if arg_389_1.isInRecall_ then
							iter_392_4.color = arg_389_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_392_4.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_389_1.var_.actorSpriteComps1056 = nil
			end

			local var_392_15 = arg_389_1.actors_["1012"]
			local var_392_16 = 0

			if var_392_16 < arg_389_1.time_ and arg_389_1.time_ <= var_392_16 + arg_392_0 and not isNil(var_392_15) and arg_389_1.var_.actorSpriteComps1012 == nil then
				arg_389_1.var_.actorSpriteComps1012 = var_392_15:GetComponentsInChildren(typeof(Image), true)
			end

			local var_392_17 = 0.034

			if var_392_16 <= arg_389_1.time_ and arg_389_1.time_ < var_392_16 + var_392_17 and not isNil(var_392_15) then
				local var_392_18 = (arg_389_1.time_ - var_392_16) / var_392_17

				if arg_389_1.var_.actorSpriteComps1012 then
					for iter_392_5, iter_392_6 in pairs(arg_389_1.var_.actorSpriteComps1012:ToTable()) do
						if iter_392_6 then
							if arg_389_1.isInRecall_ then
								local var_392_19 = Mathf.Lerp(iter_392_6.color.r, arg_389_1.hightColor2.r, var_392_18)
								local var_392_20 = Mathf.Lerp(iter_392_6.color.g, arg_389_1.hightColor2.g, var_392_18)
								local var_392_21 = Mathf.Lerp(iter_392_6.color.b, arg_389_1.hightColor2.b, var_392_18)

								iter_392_6.color = Color.New(var_392_19, var_392_20, var_392_21)
							else
								local var_392_22 = Mathf.Lerp(iter_392_6.color.r, 0.5, var_392_18)

								iter_392_6.color = Color.New(var_392_22, var_392_22, var_392_22)
							end
						end
					end
				end
			end

			if arg_389_1.time_ >= var_392_16 + var_392_17 and arg_389_1.time_ < var_392_16 + var_392_17 + arg_392_0 and not isNil(var_392_15) and arg_389_1.var_.actorSpriteComps1012 then
				for iter_392_7, iter_392_8 in pairs(arg_389_1.var_.actorSpriteComps1012:ToTable()) do
					if iter_392_8 then
						if arg_389_1.isInRecall_ then
							iter_392_8.color = arg_389_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_392_8.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_389_1.var_.actorSpriteComps1012 = nil
			end

			local var_392_23 = arg_389_1.actors_["1060"]
			local var_392_24 = 0

			if var_392_24 < arg_389_1.time_ and arg_389_1.time_ <= var_392_24 + arg_392_0 and not isNil(var_392_23) and arg_389_1.var_.actorSpriteComps1060 == nil then
				arg_389_1.var_.actorSpriteComps1060 = var_392_23:GetComponentsInChildren(typeof(Image), true)
			end

			local var_392_25 = 0.034

			if var_392_24 <= arg_389_1.time_ and arg_389_1.time_ < var_392_24 + var_392_25 and not isNil(var_392_23) then
				local var_392_26 = (arg_389_1.time_ - var_392_24) / var_392_25

				if arg_389_1.var_.actorSpriteComps1060 then
					for iter_392_9, iter_392_10 in pairs(arg_389_1.var_.actorSpriteComps1060:ToTable()) do
						if iter_392_10 then
							if arg_389_1.isInRecall_ then
								local var_392_27 = Mathf.Lerp(iter_392_10.color.r, arg_389_1.hightColor2.r, var_392_26)
								local var_392_28 = Mathf.Lerp(iter_392_10.color.g, arg_389_1.hightColor2.g, var_392_26)
								local var_392_29 = Mathf.Lerp(iter_392_10.color.b, arg_389_1.hightColor2.b, var_392_26)

								iter_392_10.color = Color.New(var_392_27, var_392_28, var_392_29)
							else
								local var_392_30 = Mathf.Lerp(iter_392_10.color.r, 0.5, var_392_26)

								iter_392_10.color = Color.New(var_392_30, var_392_30, var_392_30)
							end
						end
					end
				end
			end

			if arg_389_1.time_ >= var_392_24 + var_392_25 and arg_389_1.time_ < var_392_24 + var_392_25 + arg_392_0 and not isNil(var_392_23) and arg_389_1.var_.actorSpriteComps1060 then
				for iter_392_11, iter_392_12 in pairs(arg_389_1.var_.actorSpriteComps1060:ToTable()) do
					if iter_392_12 then
						if arg_389_1.isInRecall_ then
							iter_392_12.color = arg_389_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_392_12.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_389_1.var_.actorSpriteComps1060 = nil
			end

			local var_392_31 = 0
			local var_392_32 = 1

			if var_392_31 < arg_389_1.time_ and arg_389_1.time_ <= var_392_31 + arg_392_0 then
				arg_389_1.talkMaxDuration = 0
				arg_389_1.dialogCg_.alpha = 1

				arg_389_1.dialog_:SetActive(true)
				SetActive(arg_389_1.leftNameGo_, true)

				local var_392_33 = arg_389_1:FormatText(StoryNameCfg[605].name)

				arg_389_1.leftNameTxt_.text = var_392_33

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_389_1.leftNameTxt_.transform)

				arg_389_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_389_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_389_1:RecordName(arg_389_1.leftNameTxt_.text)
				SetActive(arg_389_1.iconTrs_.gameObject, false)
				arg_389_1.callingController_:SetSelectedState("normal")

				local var_392_34 = arg_389_1:GetWordFromCfg(410082095)
				local var_392_35 = arg_389_1:FormatText(var_392_34.content)

				arg_389_1.text_.text = var_392_35

				LuaForUtil.ClearLinePrefixSymbol(arg_389_1.text_)

				local var_392_36 = 40
				local var_392_37 = utf8.len(var_392_35)
				local var_392_38 = var_392_36 <= 0 and var_392_32 or var_392_32 * (var_392_37 / var_392_36)

				if var_392_38 > 0 and var_392_32 < var_392_38 then
					arg_389_1.talkMaxDuration = var_392_38

					if var_392_38 + var_392_31 > arg_389_1.duration_ then
						arg_389_1.duration_ = var_392_38 + var_392_31
					end
				end

				arg_389_1.text_.text = var_392_35
				arg_389_1.typewritter.percent = 0

				arg_389_1.typewritter:SetDirty()
				arg_389_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_410082", "410082095", "story_v_out_410082.awb") ~= 0 then
					local var_392_39 = manager.audio:GetVoiceLength("story_v_out_410082", "410082095", "story_v_out_410082.awb") / 1000

					if var_392_39 + var_392_31 > arg_389_1.duration_ then
						arg_389_1.duration_ = var_392_39 + var_392_31
					end

					if var_392_34.prefab_name ~= "" and arg_389_1.actors_[var_392_34.prefab_name] ~= nil then
						local var_392_40 = LuaForUtil.PlayVoiceWithCriLipsync(arg_389_1.actors_[var_392_34.prefab_name].transform, "story_v_out_410082", "410082095", "story_v_out_410082.awb")

						arg_389_1:RecordAudio("410082095", var_392_40)
						arg_389_1:RecordAudio("410082095", var_392_40)
					else
						arg_389_1:AudioAction("play", "voice", "story_v_out_410082", "410082095", "story_v_out_410082.awb")
					end

					arg_389_1:RecordHistoryTalkVoice("story_v_out_410082", "410082095", "story_v_out_410082.awb")
				end

				arg_389_1:RecordContent(arg_389_1.text_.text)
			end

			local var_392_41 = math.max(var_392_32, arg_389_1.talkMaxDuration)

			if var_392_31 <= arg_389_1.time_ and arg_389_1.time_ < var_392_31 + var_392_41 then
				arg_389_1.typewritter.percent = (arg_389_1.time_ - var_392_31) / var_392_41

				arg_389_1.typewritter:SetDirty()
			end

			if arg_389_1.time_ >= var_392_31 + var_392_41 and arg_389_1.time_ < var_392_31 + var_392_41 + arg_392_0 then
				arg_389_1.typewritter.percent = 1

				arg_389_1.typewritter:SetDirty()
				arg_389_1:ShowNextGo(true)
			end
		end

		arg_389_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1056",
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
	Play410082096 = function(arg_393_0, arg_393_1)
		arg_393_1.time_ = 0
		arg_393_1.frameCnt_ = 0
		arg_393_1.state_ = "playing"
		arg_393_1.curTalkId_ = 410082096
		arg_393_1.duration_ = 8.43

		local var_393_0 = {
			zh = 7.566,
			ja = 8.433
		}
		local var_393_1 = manager.audio:GetLocalizationFlag()

		if var_393_0[var_393_1] ~= nil then
			arg_393_1.duration_ = var_393_0[var_393_1]
		end

		SetActive(arg_393_1.tipsGo_, false)

		function arg_393_1.onSingleLineFinish_()
			arg_393_1.onSingleLineUpdate_ = nil
			arg_393_1.onSingleLineFinish_ = nil
			arg_393_1.state_ = "waiting"
		end

		function arg_393_1.playNext_(arg_395_0)
			if arg_395_0 == 1 then
				arg_393_0:Play410082097(arg_393_1)
			end
		end

		function arg_393_1.onSingleLineUpdate_(arg_396_0)
			local var_396_0 = arg_393_1.actors_["1012"].transform
			local var_396_1 = 0

			if var_396_1 < arg_393_1.time_ and arg_393_1.time_ <= var_396_1 + arg_396_0 then
				arg_393_1.var_.moveOldPos1012 = var_396_0.localPosition
				var_396_0.localScale = Vector3.New(1, 1, 1)

				arg_393_1:CheckSpriteTmpPos("1012", 4)

				local var_396_2 = var_396_0.childCount

				for iter_396_0 = 0, var_396_2 - 1 do
					local var_396_3 = var_396_0:GetChild(iter_396_0)

					if var_396_3.name == "" or not string.find(var_396_3.name, "split") then
						var_396_3.gameObject:SetActive(true)
					else
						var_396_3.gameObject:SetActive(false)
					end
				end
			end

			local var_396_4 = 0.001

			if var_396_1 <= arg_393_1.time_ and arg_393_1.time_ < var_396_1 + var_396_4 then
				local var_396_5 = (arg_393_1.time_ - var_396_1) / var_396_4
				local var_396_6 = Vector3.New(390, -465, 300)

				var_396_0.localPosition = Vector3.Lerp(arg_393_1.var_.moveOldPos1012, var_396_6, var_396_5)
			end

			if arg_393_1.time_ >= var_396_1 + var_396_4 and arg_393_1.time_ < var_396_1 + var_396_4 + arg_396_0 then
				var_396_0.localPosition = Vector3.New(390, -465, 300)
			end

			local var_396_7 = arg_393_1.actors_["1012"]
			local var_396_8 = 0

			if var_396_8 < arg_393_1.time_ and arg_393_1.time_ <= var_396_8 + arg_396_0 and not isNil(var_396_7) and arg_393_1.var_.actorSpriteComps1012 == nil then
				arg_393_1.var_.actorSpriteComps1012 = var_396_7:GetComponentsInChildren(typeof(Image), true)
			end

			local var_396_9 = 0.034

			if var_396_8 <= arg_393_1.time_ and arg_393_1.time_ < var_396_8 + var_396_9 and not isNil(var_396_7) then
				local var_396_10 = (arg_393_1.time_ - var_396_8) / var_396_9

				if arg_393_1.var_.actorSpriteComps1012 then
					for iter_396_1, iter_396_2 in pairs(arg_393_1.var_.actorSpriteComps1012:ToTable()) do
						if iter_396_2 then
							if arg_393_1.isInRecall_ then
								local var_396_11 = Mathf.Lerp(iter_396_2.color.r, arg_393_1.hightColor1.r, var_396_10)
								local var_396_12 = Mathf.Lerp(iter_396_2.color.g, arg_393_1.hightColor1.g, var_396_10)
								local var_396_13 = Mathf.Lerp(iter_396_2.color.b, arg_393_1.hightColor1.b, var_396_10)

								iter_396_2.color = Color.New(var_396_11, var_396_12, var_396_13)
							else
								local var_396_14 = Mathf.Lerp(iter_396_2.color.r, 1, var_396_10)

								iter_396_2.color = Color.New(var_396_14, var_396_14, var_396_14)
							end
						end
					end
				end
			end

			if arg_393_1.time_ >= var_396_8 + var_396_9 and arg_393_1.time_ < var_396_8 + var_396_9 + arg_396_0 and not isNil(var_396_7) and arg_393_1.var_.actorSpriteComps1012 then
				for iter_396_3, iter_396_4 in pairs(arg_393_1.var_.actorSpriteComps1012:ToTable()) do
					if iter_396_4 then
						if arg_393_1.isInRecall_ then
							iter_396_4.color = arg_393_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_396_4.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_393_1.var_.actorSpriteComps1012 = nil
			end

			local var_396_15 = arg_393_1.actors_["1056"]
			local var_396_16 = 0

			if var_396_16 < arg_393_1.time_ and arg_393_1.time_ <= var_396_16 + arg_396_0 and not isNil(var_396_15) and arg_393_1.var_.actorSpriteComps1056 == nil then
				arg_393_1.var_.actorSpriteComps1056 = var_396_15:GetComponentsInChildren(typeof(Image), true)
			end

			local var_396_17 = 0.034

			if var_396_16 <= arg_393_1.time_ and arg_393_1.time_ < var_396_16 + var_396_17 and not isNil(var_396_15) then
				local var_396_18 = (arg_393_1.time_ - var_396_16) / var_396_17

				if arg_393_1.var_.actorSpriteComps1056 then
					for iter_396_5, iter_396_6 in pairs(arg_393_1.var_.actorSpriteComps1056:ToTable()) do
						if iter_396_6 then
							if arg_393_1.isInRecall_ then
								local var_396_19 = Mathf.Lerp(iter_396_6.color.r, arg_393_1.hightColor2.r, var_396_18)
								local var_396_20 = Mathf.Lerp(iter_396_6.color.g, arg_393_1.hightColor2.g, var_396_18)
								local var_396_21 = Mathf.Lerp(iter_396_6.color.b, arg_393_1.hightColor2.b, var_396_18)

								iter_396_6.color = Color.New(var_396_19, var_396_20, var_396_21)
							else
								local var_396_22 = Mathf.Lerp(iter_396_6.color.r, 0.5, var_396_18)

								iter_396_6.color = Color.New(var_396_22, var_396_22, var_396_22)
							end
						end
					end
				end
			end

			if arg_393_1.time_ >= var_396_16 + var_396_17 and arg_393_1.time_ < var_396_16 + var_396_17 + arg_396_0 and not isNil(var_396_15) and arg_393_1.var_.actorSpriteComps1056 then
				for iter_396_7, iter_396_8 in pairs(arg_393_1.var_.actorSpriteComps1056:ToTable()) do
					if iter_396_8 then
						if arg_393_1.isInRecall_ then
							iter_396_8.color = arg_393_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_396_8.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_393_1.var_.actorSpriteComps1056 = nil
			end

			local var_396_23 = 0
			local var_396_24 = 0.8

			if var_396_23 < arg_393_1.time_ and arg_393_1.time_ <= var_396_23 + arg_396_0 then
				arg_393_1.talkMaxDuration = 0
				arg_393_1.dialogCg_.alpha = 1

				arg_393_1.dialog_:SetActive(true)
				SetActive(arg_393_1.leftNameGo_, true)

				local var_396_25 = arg_393_1:FormatText(StoryNameCfg[595].name)

				arg_393_1.leftNameTxt_.text = var_396_25

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_393_1.leftNameTxt_.transform)

				arg_393_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_393_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_393_1:RecordName(arg_393_1.leftNameTxt_.text)
				SetActive(arg_393_1.iconTrs_.gameObject, false)
				arg_393_1.callingController_:SetSelectedState("normal")

				local var_396_26 = arg_393_1:GetWordFromCfg(410082096)
				local var_396_27 = arg_393_1:FormatText(var_396_26.content)

				arg_393_1.text_.text = var_396_27

				LuaForUtil.ClearLinePrefixSymbol(arg_393_1.text_)

				local var_396_28 = 32
				local var_396_29 = utf8.len(var_396_27)
				local var_396_30 = var_396_28 <= 0 and var_396_24 or var_396_24 * (var_396_29 / var_396_28)

				if var_396_30 > 0 and var_396_24 < var_396_30 then
					arg_393_1.talkMaxDuration = var_396_30

					if var_396_30 + var_396_23 > arg_393_1.duration_ then
						arg_393_1.duration_ = var_396_30 + var_396_23
					end
				end

				arg_393_1.text_.text = var_396_27
				arg_393_1.typewritter.percent = 0

				arg_393_1.typewritter:SetDirty()
				arg_393_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_410082", "410082096", "story_v_out_410082.awb") ~= 0 then
					local var_396_31 = manager.audio:GetVoiceLength("story_v_out_410082", "410082096", "story_v_out_410082.awb") / 1000

					if var_396_31 + var_396_23 > arg_393_1.duration_ then
						arg_393_1.duration_ = var_396_31 + var_396_23
					end

					if var_396_26.prefab_name ~= "" and arg_393_1.actors_[var_396_26.prefab_name] ~= nil then
						local var_396_32 = LuaForUtil.PlayVoiceWithCriLipsync(arg_393_1.actors_[var_396_26.prefab_name].transform, "story_v_out_410082", "410082096", "story_v_out_410082.awb")

						arg_393_1:RecordAudio("410082096", var_396_32)
						arg_393_1:RecordAudio("410082096", var_396_32)
					else
						arg_393_1:AudioAction("play", "voice", "story_v_out_410082", "410082096", "story_v_out_410082.awb")
					end

					arg_393_1:RecordHistoryTalkVoice("story_v_out_410082", "410082096", "story_v_out_410082.awb")
				end

				arg_393_1:RecordContent(arg_393_1.text_.text)
			end

			local var_396_33 = math.max(var_396_24, arg_393_1.talkMaxDuration)

			if var_396_23 <= arg_393_1.time_ and arg_393_1.time_ < var_396_23 + var_396_33 then
				arg_393_1.typewritter.percent = (arg_393_1.time_ - var_396_23) / var_396_33

				arg_393_1.typewritter:SetDirty()
			end

			if arg_393_1.time_ >= var_396_23 + var_396_33 and arg_393_1.time_ < var_396_23 + var_396_33 + arg_396_0 then
				arg_393_1.typewritter.percent = 1

				arg_393_1.typewritter:SetDirty()
				arg_393_1:ShowNextGo(true)
			end
		end

		arg_393_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1012",
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
	Play410082097 = function(arg_397_0, arg_397_1)
		arg_397_1.time_ = 0
		arg_397_1.frameCnt_ = 0
		arg_397_1.state_ = "playing"
		arg_397_1.curTalkId_ = 410082097
		arg_397_1.duration_ = 20.27

		local var_397_0 = {
			zh = 9.7,
			ja = 20.266
		}
		local var_397_1 = manager.audio:GetLocalizationFlag()

		if var_397_0[var_397_1] ~= nil then
			arg_397_1.duration_ = var_397_0[var_397_1]
		end

		SetActive(arg_397_1.tipsGo_, false)

		function arg_397_1.onSingleLineFinish_()
			arg_397_1.onSingleLineUpdate_ = nil
			arg_397_1.onSingleLineFinish_ = nil
			arg_397_1.state_ = "waiting"
		end

		function arg_397_1.playNext_(arg_399_0)
			if arg_399_0 == 1 then
				arg_397_0:Play410082098(arg_397_1)
			end
		end

		function arg_397_1.onSingleLineUpdate_(arg_400_0)
			local var_400_0 = 0
			local var_400_1 = 1.125

			if var_400_0 < arg_397_1.time_ and arg_397_1.time_ <= var_400_0 + arg_400_0 then
				arg_397_1.talkMaxDuration = 0
				arg_397_1.dialogCg_.alpha = 1

				arg_397_1.dialog_:SetActive(true)
				SetActive(arg_397_1.leftNameGo_, true)

				local var_400_2 = arg_397_1:FormatText(StoryNameCfg[595].name)

				arg_397_1.leftNameTxt_.text = var_400_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_397_1.leftNameTxt_.transform)

				arg_397_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_397_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_397_1:RecordName(arg_397_1.leftNameTxt_.text)
				SetActive(arg_397_1.iconTrs_.gameObject, false)
				arg_397_1.callingController_:SetSelectedState("normal")

				local var_400_3 = arg_397_1:GetWordFromCfg(410082097)
				local var_400_4 = arg_397_1:FormatText(var_400_3.content)

				arg_397_1.text_.text = var_400_4

				LuaForUtil.ClearLinePrefixSymbol(arg_397_1.text_)

				local var_400_5 = 45
				local var_400_6 = utf8.len(var_400_4)
				local var_400_7 = var_400_5 <= 0 and var_400_1 or var_400_1 * (var_400_6 / var_400_5)

				if var_400_7 > 0 and var_400_1 < var_400_7 then
					arg_397_1.talkMaxDuration = var_400_7

					if var_400_7 + var_400_0 > arg_397_1.duration_ then
						arg_397_1.duration_ = var_400_7 + var_400_0
					end
				end

				arg_397_1.text_.text = var_400_4
				arg_397_1.typewritter.percent = 0

				arg_397_1.typewritter:SetDirty()
				arg_397_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_410082", "410082097", "story_v_out_410082.awb") ~= 0 then
					local var_400_8 = manager.audio:GetVoiceLength("story_v_out_410082", "410082097", "story_v_out_410082.awb") / 1000

					if var_400_8 + var_400_0 > arg_397_1.duration_ then
						arg_397_1.duration_ = var_400_8 + var_400_0
					end

					if var_400_3.prefab_name ~= "" and arg_397_1.actors_[var_400_3.prefab_name] ~= nil then
						local var_400_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_397_1.actors_[var_400_3.prefab_name].transform, "story_v_out_410082", "410082097", "story_v_out_410082.awb")

						arg_397_1:RecordAudio("410082097", var_400_9)
						arg_397_1:RecordAudio("410082097", var_400_9)
					else
						arg_397_1:AudioAction("play", "voice", "story_v_out_410082", "410082097", "story_v_out_410082.awb")
					end

					arg_397_1:RecordHistoryTalkVoice("story_v_out_410082", "410082097", "story_v_out_410082.awb")
				end

				arg_397_1:RecordContent(arg_397_1.text_.text)
			end

			local var_400_10 = math.max(var_400_1, arg_397_1.talkMaxDuration)

			if var_400_0 <= arg_397_1.time_ and arg_397_1.time_ < var_400_0 + var_400_10 then
				arg_397_1.typewritter.percent = (arg_397_1.time_ - var_400_0) / var_400_10

				arg_397_1.typewritter:SetDirty()
			end

			if arg_397_1.time_ >= var_400_0 + var_400_10 and arg_397_1.time_ < var_400_0 + var_400_10 + arg_400_0 then
				arg_397_1.typewritter.percent = 1

				arg_397_1.typewritter:SetDirty()
				arg_397_1:ShowNextGo(true)
			end
		end

		arg_397_1.nodeConfigList_ = {}

		arg_397_1:InitPlayNodeList()
	end,
	Play410082098 = function(arg_401_0, arg_401_1)
		arg_401_1.time_ = 0
		arg_401_1.frameCnt_ = 0
		arg_401_1.state_ = "playing"
		arg_401_1.curTalkId_ = 410082098
		arg_401_1.duration_ = 9.6

		local var_401_0 = {
			zh = 4.1,
			ja = 9.6
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
				arg_401_0:Play410082099(arg_401_1)
			end
		end

		function arg_401_1.onSingleLineUpdate_(arg_404_0)
			local var_404_0 = 0
			local var_404_1 = 0.5

			if var_404_0 < arg_401_1.time_ and arg_401_1.time_ <= var_404_0 + arg_404_0 then
				arg_401_1.talkMaxDuration = 0
				arg_401_1.dialogCg_.alpha = 1

				arg_401_1.dialog_:SetActive(true)
				SetActive(arg_401_1.leftNameGo_, true)

				local var_404_2 = arg_401_1:FormatText(StoryNameCfg[595].name)

				arg_401_1.leftNameTxt_.text = var_404_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_401_1.leftNameTxt_.transform)

				arg_401_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_401_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_401_1:RecordName(arg_401_1.leftNameTxt_.text)
				SetActive(arg_401_1.iconTrs_.gameObject, false)
				arg_401_1.callingController_:SetSelectedState("normal")

				local var_404_3 = arg_401_1:GetWordFromCfg(410082098)
				local var_404_4 = arg_401_1:FormatText(var_404_3.content)

				arg_401_1.text_.text = var_404_4

				LuaForUtil.ClearLinePrefixSymbol(arg_401_1.text_)

				local var_404_5 = 20
				local var_404_6 = utf8.len(var_404_4)
				local var_404_7 = var_404_5 <= 0 and var_404_1 or var_404_1 * (var_404_6 / var_404_5)

				if var_404_7 > 0 and var_404_1 < var_404_7 then
					arg_401_1.talkMaxDuration = var_404_7

					if var_404_7 + var_404_0 > arg_401_1.duration_ then
						arg_401_1.duration_ = var_404_7 + var_404_0
					end
				end

				arg_401_1.text_.text = var_404_4
				arg_401_1.typewritter.percent = 0

				arg_401_1.typewritter:SetDirty()
				arg_401_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_410082", "410082098", "story_v_out_410082.awb") ~= 0 then
					local var_404_8 = manager.audio:GetVoiceLength("story_v_out_410082", "410082098", "story_v_out_410082.awb") / 1000

					if var_404_8 + var_404_0 > arg_401_1.duration_ then
						arg_401_1.duration_ = var_404_8 + var_404_0
					end

					if var_404_3.prefab_name ~= "" and arg_401_1.actors_[var_404_3.prefab_name] ~= nil then
						local var_404_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_401_1.actors_[var_404_3.prefab_name].transform, "story_v_out_410082", "410082098", "story_v_out_410082.awb")

						arg_401_1:RecordAudio("410082098", var_404_9)
						arg_401_1:RecordAudio("410082098", var_404_9)
					else
						arg_401_1:AudioAction("play", "voice", "story_v_out_410082", "410082098", "story_v_out_410082.awb")
					end

					arg_401_1:RecordHistoryTalkVoice("story_v_out_410082", "410082098", "story_v_out_410082.awb")
				end

				arg_401_1:RecordContent(arg_401_1.text_.text)
			end

			local var_404_10 = math.max(var_404_1, arg_401_1.talkMaxDuration)

			if var_404_0 <= arg_401_1.time_ and arg_401_1.time_ < var_404_0 + var_404_10 then
				arg_401_1.typewritter.percent = (arg_401_1.time_ - var_404_0) / var_404_10

				arg_401_1.typewritter:SetDirty()
			end

			if arg_401_1.time_ >= var_404_0 + var_404_10 and arg_401_1.time_ < var_404_0 + var_404_10 + arg_404_0 then
				arg_401_1.typewritter.percent = 1

				arg_401_1.typewritter:SetDirty()
				arg_401_1:ShowNextGo(true)
			end
		end

		arg_401_1.nodeConfigList_ = {}

		arg_401_1:InitPlayNodeList()
	end,
	Play410082099 = function(arg_405_0, arg_405_1)
		arg_405_1.time_ = 0
		arg_405_1.frameCnt_ = 0
		arg_405_1.state_ = "playing"
		arg_405_1.curTalkId_ = 410082099
		arg_405_1.duration_ = 3.23

		local var_405_0 = {
			zh = 3.233,
			ja = 3.2
		}
		local var_405_1 = manager.audio:GetLocalizationFlag()

		if var_405_0[var_405_1] ~= nil then
			arg_405_1.duration_ = var_405_0[var_405_1]
		end

		SetActive(arg_405_1.tipsGo_, false)

		function arg_405_1.onSingleLineFinish_()
			arg_405_1.onSingleLineUpdate_ = nil
			arg_405_1.onSingleLineFinish_ = nil
			arg_405_1.state_ = "waiting"
		end

		function arg_405_1.playNext_(arg_407_0)
			if arg_407_0 == 1 then
				arg_405_0:Play410082100(arg_405_1)
			end
		end

		function arg_405_1.onSingleLineUpdate_(arg_408_0)
			local var_408_0 = arg_405_1.actors_["1060"].transform
			local var_408_1 = 0

			if var_408_1 < arg_405_1.time_ and arg_405_1.time_ <= var_408_1 + arg_408_0 then
				arg_405_1.var_.moveOldPos1060 = var_408_0.localPosition
				var_408_0.localScale = Vector3.New(1, 1, 1)

				arg_405_1:CheckSpriteTmpPos("1060", 2)

				local var_408_2 = var_408_0.childCount

				for iter_408_0 = 0, var_408_2 - 1 do
					local var_408_3 = var_408_0:GetChild(iter_408_0)

					if var_408_3.name == "" or not string.find(var_408_3.name, "split") then
						var_408_3.gameObject:SetActive(true)
					else
						var_408_3.gameObject:SetActive(false)
					end
				end
			end

			local var_408_4 = 0.001

			if var_408_1 <= arg_405_1.time_ and arg_405_1.time_ < var_408_1 + var_408_4 then
				local var_408_5 = (arg_405_1.time_ - var_408_1) / var_408_4
				local var_408_6 = Vector3.New(-440.94, -430.8, 6.9)

				var_408_0.localPosition = Vector3.Lerp(arg_405_1.var_.moveOldPos1060, var_408_6, var_408_5)
			end

			if arg_405_1.time_ >= var_408_1 + var_408_4 and arg_405_1.time_ < var_408_1 + var_408_4 + arg_408_0 then
				var_408_0.localPosition = Vector3.New(-440.94, -430.8, 6.9)
			end

			local var_408_7 = arg_405_1.actors_["1060"]
			local var_408_8 = 0

			if var_408_8 < arg_405_1.time_ and arg_405_1.time_ <= var_408_8 + arg_408_0 and not isNil(var_408_7) and arg_405_1.var_.actorSpriteComps1060 == nil then
				arg_405_1.var_.actorSpriteComps1060 = var_408_7:GetComponentsInChildren(typeof(Image), true)
			end

			local var_408_9 = 0.034

			if var_408_8 <= arg_405_1.time_ and arg_405_1.time_ < var_408_8 + var_408_9 and not isNil(var_408_7) then
				local var_408_10 = (arg_405_1.time_ - var_408_8) / var_408_9

				if arg_405_1.var_.actorSpriteComps1060 then
					for iter_408_1, iter_408_2 in pairs(arg_405_1.var_.actorSpriteComps1060:ToTable()) do
						if iter_408_2 then
							if arg_405_1.isInRecall_ then
								local var_408_11 = Mathf.Lerp(iter_408_2.color.r, arg_405_1.hightColor1.r, var_408_10)
								local var_408_12 = Mathf.Lerp(iter_408_2.color.g, arg_405_1.hightColor1.g, var_408_10)
								local var_408_13 = Mathf.Lerp(iter_408_2.color.b, arg_405_1.hightColor1.b, var_408_10)

								iter_408_2.color = Color.New(var_408_11, var_408_12, var_408_13)
							else
								local var_408_14 = Mathf.Lerp(iter_408_2.color.r, 1, var_408_10)

								iter_408_2.color = Color.New(var_408_14, var_408_14, var_408_14)
							end
						end
					end
				end
			end

			if arg_405_1.time_ >= var_408_8 + var_408_9 and arg_405_1.time_ < var_408_8 + var_408_9 + arg_408_0 and not isNil(var_408_7) and arg_405_1.var_.actorSpriteComps1060 then
				for iter_408_3, iter_408_4 in pairs(arg_405_1.var_.actorSpriteComps1060:ToTable()) do
					if iter_408_4 then
						if arg_405_1.isInRecall_ then
							iter_408_4.color = arg_405_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_408_4.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_405_1.var_.actorSpriteComps1060 = nil
			end

			local var_408_15 = arg_405_1.actors_["1012"]
			local var_408_16 = 0

			if var_408_16 < arg_405_1.time_ and arg_405_1.time_ <= var_408_16 + arg_408_0 and not isNil(var_408_15) and arg_405_1.var_.actorSpriteComps1012 == nil then
				arg_405_1.var_.actorSpriteComps1012 = var_408_15:GetComponentsInChildren(typeof(Image), true)
			end

			local var_408_17 = 0.034

			if var_408_16 <= arg_405_1.time_ and arg_405_1.time_ < var_408_16 + var_408_17 and not isNil(var_408_15) then
				local var_408_18 = (arg_405_1.time_ - var_408_16) / var_408_17

				if arg_405_1.var_.actorSpriteComps1012 then
					for iter_408_5, iter_408_6 in pairs(arg_405_1.var_.actorSpriteComps1012:ToTable()) do
						if iter_408_6 then
							if arg_405_1.isInRecall_ then
								local var_408_19 = Mathf.Lerp(iter_408_6.color.r, arg_405_1.hightColor2.r, var_408_18)
								local var_408_20 = Mathf.Lerp(iter_408_6.color.g, arg_405_1.hightColor2.g, var_408_18)
								local var_408_21 = Mathf.Lerp(iter_408_6.color.b, arg_405_1.hightColor2.b, var_408_18)

								iter_408_6.color = Color.New(var_408_19, var_408_20, var_408_21)
							else
								local var_408_22 = Mathf.Lerp(iter_408_6.color.r, 0.5, var_408_18)

								iter_408_6.color = Color.New(var_408_22, var_408_22, var_408_22)
							end
						end
					end
				end
			end

			if arg_405_1.time_ >= var_408_16 + var_408_17 and arg_405_1.time_ < var_408_16 + var_408_17 + arg_408_0 and not isNil(var_408_15) and arg_405_1.var_.actorSpriteComps1012 then
				for iter_408_7, iter_408_8 in pairs(arg_405_1.var_.actorSpriteComps1012:ToTable()) do
					if iter_408_8 then
						if arg_405_1.isInRecall_ then
							iter_408_8.color = arg_405_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_408_8.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_405_1.var_.actorSpriteComps1012 = nil
			end

			local var_408_23 = 0
			local var_408_24 = 0.375

			if var_408_23 < arg_405_1.time_ and arg_405_1.time_ <= var_408_23 + arg_408_0 then
				arg_405_1.talkMaxDuration = 0
				arg_405_1.dialogCg_.alpha = 1

				arg_405_1.dialog_:SetActive(true)
				SetActive(arg_405_1.leftNameGo_, true)

				local var_408_25 = arg_405_1:FormatText(StoryNameCfg[584].name)

				arg_405_1.leftNameTxt_.text = var_408_25

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_405_1.leftNameTxt_.transform)

				arg_405_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_405_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_405_1:RecordName(arg_405_1.leftNameTxt_.text)
				SetActive(arg_405_1.iconTrs_.gameObject, false)
				arg_405_1.callingController_:SetSelectedState("normal")

				local var_408_26 = arg_405_1:GetWordFromCfg(410082099)
				local var_408_27 = arg_405_1:FormatText(var_408_26.content)

				arg_405_1.text_.text = var_408_27

				LuaForUtil.ClearLinePrefixSymbol(arg_405_1.text_)

				local var_408_28 = 15
				local var_408_29 = utf8.len(var_408_27)
				local var_408_30 = var_408_28 <= 0 and var_408_24 or var_408_24 * (var_408_29 / var_408_28)

				if var_408_30 > 0 and var_408_24 < var_408_30 then
					arg_405_1.talkMaxDuration = var_408_30

					if var_408_30 + var_408_23 > arg_405_1.duration_ then
						arg_405_1.duration_ = var_408_30 + var_408_23
					end
				end

				arg_405_1.text_.text = var_408_27
				arg_405_1.typewritter.percent = 0

				arg_405_1.typewritter:SetDirty()
				arg_405_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_410082", "410082099", "story_v_out_410082.awb") ~= 0 then
					local var_408_31 = manager.audio:GetVoiceLength("story_v_out_410082", "410082099", "story_v_out_410082.awb") / 1000

					if var_408_31 + var_408_23 > arg_405_1.duration_ then
						arg_405_1.duration_ = var_408_31 + var_408_23
					end

					if var_408_26.prefab_name ~= "" and arg_405_1.actors_[var_408_26.prefab_name] ~= nil then
						local var_408_32 = LuaForUtil.PlayVoiceWithCriLipsync(arg_405_1.actors_[var_408_26.prefab_name].transform, "story_v_out_410082", "410082099", "story_v_out_410082.awb")

						arg_405_1:RecordAudio("410082099", var_408_32)
						arg_405_1:RecordAudio("410082099", var_408_32)
					else
						arg_405_1:AudioAction("play", "voice", "story_v_out_410082", "410082099", "story_v_out_410082.awb")
					end

					arg_405_1:RecordHistoryTalkVoice("story_v_out_410082", "410082099", "story_v_out_410082.awb")
				end

				arg_405_1:RecordContent(arg_405_1.text_.text)
			end

			local var_408_33 = math.max(var_408_24, arg_405_1.talkMaxDuration)

			if var_408_23 <= arg_405_1.time_ and arg_405_1.time_ < var_408_23 + var_408_33 then
				arg_405_1.typewritter.percent = (arg_405_1.time_ - var_408_23) / var_408_33

				arg_405_1.typewritter:SetDirty()
			end

			if arg_405_1.time_ >= var_408_23 + var_408_33 and arg_405_1.time_ < var_408_23 + var_408_33 + arg_408_0 then
				arg_405_1.typewritter.percent = 1

				arg_405_1.typewritter:SetDirty()
				arg_405_1:ShowNextGo(true)
			end
		end

		arg_405_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1060",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_405_1:InitPlayNodeList()
	end,
	Play410082100 = function(arg_409_0, arg_409_1)
		arg_409_1.time_ = 0
		arg_409_1.frameCnt_ = 0
		arg_409_1.state_ = "playing"
		arg_409_1.curTalkId_ = 410082100
		arg_409_1.duration_ = 9.37

		local var_409_0 = {
			zh = 6.966,
			ja = 9.366
		}
		local var_409_1 = manager.audio:GetLocalizationFlag()

		if var_409_0[var_409_1] ~= nil then
			arg_409_1.duration_ = var_409_0[var_409_1]
		end

		SetActive(arg_409_1.tipsGo_, false)

		function arg_409_1.onSingleLineFinish_()
			arg_409_1.onSingleLineUpdate_ = nil
			arg_409_1.onSingleLineFinish_ = nil
			arg_409_1.state_ = "waiting"
		end

		function arg_409_1.playNext_(arg_411_0)
			if arg_411_0 == 1 then
				arg_409_0:Play410082101(arg_409_1)
			end
		end

		function arg_409_1.onSingleLineUpdate_(arg_412_0)
			local var_412_0 = arg_409_1.actors_["1012"].transform
			local var_412_1 = 0

			if var_412_1 < arg_409_1.time_ and arg_409_1.time_ <= var_412_1 + arg_412_0 then
				arg_409_1.var_.moveOldPos1012 = var_412_0.localPosition
				var_412_0.localScale = Vector3.New(1, 1, 1)

				arg_409_1:CheckSpriteTmpPos("1012", 4)

				local var_412_2 = var_412_0.childCount

				for iter_412_0 = 0, var_412_2 - 1 do
					local var_412_3 = var_412_0:GetChild(iter_412_0)

					if var_412_3.name == "" or not string.find(var_412_3.name, "split") then
						var_412_3.gameObject:SetActive(true)
					else
						var_412_3.gameObject:SetActive(false)
					end
				end
			end

			local var_412_4 = 0.001

			if var_412_1 <= arg_409_1.time_ and arg_409_1.time_ < var_412_1 + var_412_4 then
				local var_412_5 = (arg_409_1.time_ - var_412_1) / var_412_4
				local var_412_6 = Vector3.New(390, -465, 300)

				var_412_0.localPosition = Vector3.Lerp(arg_409_1.var_.moveOldPos1012, var_412_6, var_412_5)
			end

			if arg_409_1.time_ >= var_412_1 + var_412_4 and arg_409_1.time_ < var_412_1 + var_412_4 + arg_412_0 then
				var_412_0.localPosition = Vector3.New(390, -465, 300)
			end

			local var_412_7 = arg_409_1.actors_["1012"]
			local var_412_8 = 0

			if var_412_8 < arg_409_1.time_ and arg_409_1.time_ <= var_412_8 + arg_412_0 and not isNil(var_412_7) and arg_409_1.var_.actorSpriteComps1012 == nil then
				arg_409_1.var_.actorSpriteComps1012 = var_412_7:GetComponentsInChildren(typeof(Image), true)
			end

			local var_412_9 = 0.034

			if var_412_8 <= arg_409_1.time_ and arg_409_1.time_ < var_412_8 + var_412_9 and not isNil(var_412_7) then
				local var_412_10 = (arg_409_1.time_ - var_412_8) / var_412_9

				if arg_409_1.var_.actorSpriteComps1012 then
					for iter_412_1, iter_412_2 in pairs(arg_409_1.var_.actorSpriteComps1012:ToTable()) do
						if iter_412_2 then
							if arg_409_1.isInRecall_ then
								local var_412_11 = Mathf.Lerp(iter_412_2.color.r, arg_409_1.hightColor1.r, var_412_10)
								local var_412_12 = Mathf.Lerp(iter_412_2.color.g, arg_409_1.hightColor1.g, var_412_10)
								local var_412_13 = Mathf.Lerp(iter_412_2.color.b, arg_409_1.hightColor1.b, var_412_10)

								iter_412_2.color = Color.New(var_412_11, var_412_12, var_412_13)
							else
								local var_412_14 = Mathf.Lerp(iter_412_2.color.r, 1, var_412_10)

								iter_412_2.color = Color.New(var_412_14, var_412_14, var_412_14)
							end
						end
					end
				end
			end

			if arg_409_1.time_ >= var_412_8 + var_412_9 and arg_409_1.time_ < var_412_8 + var_412_9 + arg_412_0 and not isNil(var_412_7) and arg_409_1.var_.actorSpriteComps1012 then
				for iter_412_3, iter_412_4 in pairs(arg_409_1.var_.actorSpriteComps1012:ToTable()) do
					if iter_412_4 then
						if arg_409_1.isInRecall_ then
							iter_412_4.color = arg_409_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_412_4.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_409_1.var_.actorSpriteComps1012 = nil
			end

			local var_412_15 = arg_409_1.actors_["1060"]
			local var_412_16 = 0

			if var_412_16 < arg_409_1.time_ and arg_409_1.time_ <= var_412_16 + arg_412_0 and not isNil(var_412_15) and arg_409_1.var_.actorSpriteComps1060 == nil then
				arg_409_1.var_.actorSpriteComps1060 = var_412_15:GetComponentsInChildren(typeof(Image), true)
			end

			local var_412_17 = 0.034

			if var_412_16 <= arg_409_1.time_ and arg_409_1.time_ < var_412_16 + var_412_17 and not isNil(var_412_15) then
				local var_412_18 = (arg_409_1.time_ - var_412_16) / var_412_17

				if arg_409_1.var_.actorSpriteComps1060 then
					for iter_412_5, iter_412_6 in pairs(arg_409_1.var_.actorSpriteComps1060:ToTable()) do
						if iter_412_6 then
							if arg_409_1.isInRecall_ then
								local var_412_19 = Mathf.Lerp(iter_412_6.color.r, arg_409_1.hightColor2.r, var_412_18)
								local var_412_20 = Mathf.Lerp(iter_412_6.color.g, arg_409_1.hightColor2.g, var_412_18)
								local var_412_21 = Mathf.Lerp(iter_412_6.color.b, arg_409_1.hightColor2.b, var_412_18)

								iter_412_6.color = Color.New(var_412_19, var_412_20, var_412_21)
							else
								local var_412_22 = Mathf.Lerp(iter_412_6.color.r, 0.5, var_412_18)

								iter_412_6.color = Color.New(var_412_22, var_412_22, var_412_22)
							end
						end
					end
				end
			end

			if arg_409_1.time_ >= var_412_16 + var_412_17 and arg_409_1.time_ < var_412_16 + var_412_17 + arg_412_0 and not isNil(var_412_15) and arg_409_1.var_.actorSpriteComps1060 then
				for iter_412_7, iter_412_8 in pairs(arg_409_1.var_.actorSpriteComps1060:ToTable()) do
					if iter_412_8 then
						if arg_409_1.isInRecall_ then
							iter_412_8.color = arg_409_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_412_8.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_409_1.var_.actorSpriteComps1060 = nil
			end

			local var_412_23 = 0
			local var_412_24 = 0.75

			if var_412_23 < arg_409_1.time_ and arg_409_1.time_ <= var_412_23 + arg_412_0 then
				arg_409_1.talkMaxDuration = 0
				arg_409_1.dialogCg_.alpha = 1

				arg_409_1.dialog_:SetActive(true)
				SetActive(arg_409_1.leftNameGo_, true)

				local var_412_25 = arg_409_1:FormatText(StoryNameCfg[595].name)

				arg_409_1.leftNameTxt_.text = var_412_25

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_409_1.leftNameTxt_.transform)

				arg_409_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_409_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_409_1:RecordName(arg_409_1.leftNameTxt_.text)
				SetActive(arg_409_1.iconTrs_.gameObject, false)
				arg_409_1.callingController_:SetSelectedState("normal")

				local var_412_26 = arg_409_1:GetWordFromCfg(410082100)
				local var_412_27 = arg_409_1:FormatText(var_412_26.content)

				arg_409_1.text_.text = var_412_27

				LuaForUtil.ClearLinePrefixSymbol(arg_409_1.text_)

				local var_412_28 = 30
				local var_412_29 = utf8.len(var_412_27)
				local var_412_30 = var_412_28 <= 0 and var_412_24 or var_412_24 * (var_412_29 / var_412_28)

				if var_412_30 > 0 and var_412_24 < var_412_30 then
					arg_409_1.talkMaxDuration = var_412_30

					if var_412_30 + var_412_23 > arg_409_1.duration_ then
						arg_409_1.duration_ = var_412_30 + var_412_23
					end
				end

				arg_409_1.text_.text = var_412_27
				arg_409_1.typewritter.percent = 0

				arg_409_1.typewritter:SetDirty()
				arg_409_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_410082", "410082100", "story_v_out_410082.awb") ~= 0 then
					local var_412_31 = manager.audio:GetVoiceLength("story_v_out_410082", "410082100", "story_v_out_410082.awb") / 1000

					if var_412_31 + var_412_23 > arg_409_1.duration_ then
						arg_409_1.duration_ = var_412_31 + var_412_23
					end

					if var_412_26.prefab_name ~= "" and arg_409_1.actors_[var_412_26.prefab_name] ~= nil then
						local var_412_32 = LuaForUtil.PlayVoiceWithCriLipsync(arg_409_1.actors_[var_412_26.prefab_name].transform, "story_v_out_410082", "410082100", "story_v_out_410082.awb")

						arg_409_1:RecordAudio("410082100", var_412_32)
						arg_409_1:RecordAudio("410082100", var_412_32)
					else
						arg_409_1:AudioAction("play", "voice", "story_v_out_410082", "410082100", "story_v_out_410082.awb")
					end

					arg_409_1:RecordHistoryTalkVoice("story_v_out_410082", "410082100", "story_v_out_410082.awb")
				end

				arg_409_1:RecordContent(arg_409_1.text_.text)
			end

			local var_412_33 = math.max(var_412_24, arg_409_1.talkMaxDuration)

			if var_412_23 <= arg_409_1.time_ and arg_409_1.time_ < var_412_23 + var_412_33 then
				arg_409_1.typewritter.percent = (arg_409_1.time_ - var_412_23) / var_412_33

				arg_409_1.typewritter:SetDirty()
			end

			if arg_409_1.time_ >= var_412_23 + var_412_33 and arg_409_1.time_ < var_412_23 + var_412_33 + arg_412_0 then
				arg_409_1.typewritter.percent = 1

				arg_409_1.typewritter:SetDirty()
				arg_409_1:ShowNextGo(true)
			end
		end

		arg_409_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1012",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_409_1:InitPlayNodeList()
	end,
	Play410082101 = function(arg_413_0, arg_413_1)
		arg_413_1.time_ = 0
		arg_413_1.frameCnt_ = 0
		arg_413_1.state_ = "playing"
		arg_413_1.curTalkId_ = 410082101
		arg_413_1.duration_ = 3.7

		local var_413_0 = {
			zh = 3.3,
			ja = 3.7
		}
		local var_413_1 = manager.audio:GetLocalizationFlag()

		if var_413_0[var_413_1] ~= nil then
			arg_413_1.duration_ = var_413_0[var_413_1]
		end

		SetActive(arg_413_1.tipsGo_, false)

		function arg_413_1.onSingleLineFinish_()
			arg_413_1.onSingleLineUpdate_ = nil
			arg_413_1.onSingleLineFinish_ = nil
			arg_413_1.state_ = "waiting"
		end

		function arg_413_1.playNext_(arg_415_0)
			if arg_415_0 == 1 then
				arg_413_0:Play410082102(arg_413_1)
			end
		end

		function arg_413_1.onSingleLineUpdate_(arg_416_0)
			local var_416_0 = arg_413_1.actors_["1060"].transform
			local var_416_1 = 0

			if var_416_1 < arg_413_1.time_ and arg_413_1.time_ <= var_416_1 + arg_416_0 then
				arg_413_1.var_.moveOldPos1060 = var_416_0.localPosition
				var_416_0.localScale = Vector3.New(1, 1, 1)

				arg_413_1:CheckSpriteTmpPos("1060", 2)

				local var_416_2 = var_416_0.childCount

				for iter_416_0 = 0, var_416_2 - 1 do
					local var_416_3 = var_416_0:GetChild(iter_416_0)

					if var_416_3.name == "" or not string.find(var_416_3.name, "split") then
						var_416_3.gameObject:SetActive(true)
					else
						var_416_3.gameObject:SetActive(false)
					end
				end
			end

			local var_416_4 = 0.001

			if var_416_1 <= arg_413_1.time_ and arg_413_1.time_ < var_416_1 + var_416_4 then
				local var_416_5 = (arg_413_1.time_ - var_416_1) / var_416_4
				local var_416_6 = Vector3.New(-440.94, -430.8, 6.9)

				var_416_0.localPosition = Vector3.Lerp(arg_413_1.var_.moveOldPos1060, var_416_6, var_416_5)
			end

			if arg_413_1.time_ >= var_416_1 + var_416_4 and arg_413_1.time_ < var_416_1 + var_416_4 + arg_416_0 then
				var_416_0.localPosition = Vector3.New(-440.94, -430.8, 6.9)
			end

			local var_416_7 = arg_413_1.actors_["1060"]
			local var_416_8 = 0

			if var_416_8 < arg_413_1.time_ and arg_413_1.time_ <= var_416_8 + arg_416_0 and not isNil(var_416_7) and arg_413_1.var_.actorSpriteComps1060 == nil then
				arg_413_1.var_.actorSpriteComps1060 = var_416_7:GetComponentsInChildren(typeof(Image), true)
			end

			local var_416_9 = 0.034

			if var_416_8 <= arg_413_1.time_ and arg_413_1.time_ < var_416_8 + var_416_9 and not isNil(var_416_7) then
				local var_416_10 = (arg_413_1.time_ - var_416_8) / var_416_9

				if arg_413_1.var_.actorSpriteComps1060 then
					for iter_416_1, iter_416_2 in pairs(arg_413_1.var_.actorSpriteComps1060:ToTable()) do
						if iter_416_2 then
							if arg_413_1.isInRecall_ then
								local var_416_11 = Mathf.Lerp(iter_416_2.color.r, arg_413_1.hightColor1.r, var_416_10)
								local var_416_12 = Mathf.Lerp(iter_416_2.color.g, arg_413_1.hightColor1.g, var_416_10)
								local var_416_13 = Mathf.Lerp(iter_416_2.color.b, arg_413_1.hightColor1.b, var_416_10)

								iter_416_2.color = Color.New(var_416_11, var_416_12, var_416_13)
							else
								local var_416_14 = Mathf.Lerp(iter_416_2.color.r, 1, var_416_10)

								iter_416_2.color = Color.New(var_416_14, var_416_14, var_416_14)
							end
						end
					end
				end
			end

			if arg_413_1.time_ >= var_416_8 + var_416_9 and arg_413_1.time_ < var_416_8 + var_416_9 + arg_416_0 and not isNil(var_416_7) and arg_413_1.var_.actorSpriteComps1060 then
				for iter_416_3, iter_416_4 in pairs(arg_413_1.var_.actorSpriteComps1060:ToTable()) do
					if iter_416_4 then
						if arg_413_1.isInRecall_ then
							iter_416_4.color = arg_413_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_416_4.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_413_1.var_.actorSpriteComps1060 = nil
			end

			local var_416_15 = arg_413_1.actors_["1012"]
			local var_416_16 = 0

			if var_416_16 < arg_413_1.time_ and arg_413_1.time_ <= var_416_16 + arg_416_0 and not isNil(var_416_15) and arg_413_1.var_.actorSpriteComps1012 == nil then
				arg_413_1.var_.actorSpriteComps1012 = var_416_15:GetComponentsInChildren(typeof(Image), true)
			end

			local var_416_17 = 0.034

			if var_416_16 <= arg_413_1.time_ and arg_413_1.time_ < var_416_16 + var_416_17 and not isNil(var_416_15) then
				local var_416_18 = (arg_413_1.time_ - var_416_16) / var_416_17

				if arg_413_1.var_.actorSpriteComps1012 then
					for iter_416_5, iter_416_6 in pairs(arg_413_1.var_.actorSpriteComps1012:ToTable()) do
						if iter_416_6 then
							if arg_413_1.isInRecall_ then
								local var_416_19 = Mathf.Lerp(iter_416_6.color.r, arg_413_1.hightColor2.r, var_416_18)
								local var_416_20 = Mathf.Lerp(iter_416_6.color.g, arg_413_1.hightColor2.g, var_416_18)
								local var_416_21 = Mathf.Lerp(iter_416_6.color.b, arg_413_1.hightColor2.b, var_416_18)

								iter_416_6.color = Color.New(var_416_19, var_416_20, var_416_21)
							else
								local var_416_22 = Mathf.Lerp(iter_416_6.color.r, 0.5, var_416_18)

								iter_416_6.color = Color.New(var_416_22, var_416_22, var_416_22)
							end
						end
					end
				end
			end

			if arg_413_1.time_ >= var_416_16 + var_416_17 and arg_413_1.time_ < var_416_16 + var_416_17 + arg_416_0 and not isNil(var_416_15) and arg_413_1.var_.actorSpriteComps1012 then
				for iter_416_7, iter_416_8 in pairs(arg_413_1.var_.actorSpriteComps1012:ToTable()) do
					if iter_416_8 then
						if arg_413_1.isInRecall_ then
							iter_416_8.color = arg_413_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_416_8.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_413_1.var_.actorSpriteComps1012 = nil
			end

			local var_416_23 = 0
			local var_416_24 = 0.45

			if var_416_23 < arg_413_1.time_ and arg_413_1.time_ <= var_416_23 + arg_416_0 then
				arg_413_1.talkMaxDuration = 0
				arg_413_1.dialogCg_.alpha = 1

				arg_413_1.dialog_:SetActive(true)
				SetActive(arg_413_1.leftNameGo_, true)

				local var_416_25 = arg_413_1:FormatText(StoryNameCfg[584].name)

				arg_413_1.leftNameTxt_.text = var_416_25

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_413_1.leftNameTxt_.transform)

				arg_413_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_413_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_413_1:RecordName(arg_413_1.leftNameTxt_.text)
				SetActive(arg_413_1.iconTrs_.gameObject, false)
				arg_413_1.callingController_:SetSelectedState("normal")

				local var_416_26 = arg_413_1:GetWordFromCfg(410082101)
				local var_416_27 = arg_413_1:FormatText(var_416_26.content)

				arg_413_1.text_.text = var_416_27

				LuaForUtil.ClearLinePrefixSymbol(arg_413_1.text_)

				local var_416_28 = 18
				local var_416_29 = utf8.len(var_416_27)
				local var_416_30 = var_416_28 <= 0 and var_416_24 or var_416_24 * (var_416_29 / var_416_28)

				if var_416_30 > 0 and var_416_24 < var_416_30 then
					arg_413_1.talkMaxDuration = var_416_30

					if var_416_30 + var_416_23 > arg_413_1.duration_ then
						arg_413_1.duration_ = var_416_30 + var_416_23
					end
				end

				arg_413_1.text_.text = var_416_27
				arg_413_1.typewritter.percent = 0

				arg_413_1.typewritter:SetDirty()
				arg_413_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_410082", "410082101", "story_v_out_410082.awb") ~= 0 then
					local var_416_31 = manager.audio:GetVoiceLength("story_v_out_410082", "410082101", "story_v_out_410082.awb") / 1000

					if var_416_31 + var_416_23 > arg_413_1.duration_ then
						arg_413_1.duration_ = var_416_31 + var_416_23
					end

					if var_416_26.prefab_name ~= "" and arg_413_1.actors_[var_416_26.prefab_name] ~= nil then
						local var_416_32 = LuaForUtil.PlayVoiceWithCriLipsync(arg_413_1.actors_[var_416_26.prefab_name].transform, "story_v_out_410082", "410082101", "story_v_out_410082.awb")

						arg_413_1:RecordAudio("410082101", var_416_32)
						arg_413_1:RecordAudio("410082101", var_416_32)
					else
						arg_413_1:AudioAction("play", "voice", "story_v_out_410082", "410082101", "story_v_out_410082.awb")
					end

					arg_413_1:RecordHistoryTalkVoice("story_v_out_410082", "410082101", "story_v_out_410082.awb")
				end

				arg_413_1:RecordContent(arg_413_1.text_.text)
			end

			local var_416_33 = math.max(var_416_24, arg_413_1.talkMaxDuration)

			if var_416_23 <= arg_413_1.time_ and arg_413_1.time_ < var_416_23 + var_416_33 then
				arg_413_1.typewritter.percent = (arg_413_1.time_ - var_416_23) / var_416_33

				arg_413_1.typewritter:SetDirty()
			end

			if arg_413_1.time_ >= var_416_23 + var_416_33 and arg_413_1.time_ < var_416_23 + var_416_33 + arg_416_0 then
				arg_413_1.typewritter.percent = 1

				arg_413_1.typewritter:SetDirty()
				arg_413_1:ShowNextGo(true)
			end
		end

		arg_413_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1060",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_413_1:InitPlayNodeList()
	end,
	Play410082102 = function(arg_417_0, arg_417_1)
		arg_417_1.time_ = 0
		arg_417_1.frameCnt_ = 0
		arg_417_1.state_ = "playing"
		arg_417_1.curTalkId_ = 410082102
		arg_417_1.duration_ = 8.03

		local var_417_0 = {
			zh = 4.766,
			ja = 8.033
		}
		local var_417_1 = manager.audio:GetLocalizationFlag()

		if var_417_0[var_417_1] ~= nil then
			arg_417_1.duration_ = var_417_0[var_417_1]
		end

		SetActive(arg_417_1.tipsGo_, false)

		function arg_417_1.onSingleLineFinish_()
			arg_417_1.onSingleLineUpdate_ = nil
			arg_417_1.onSingleLineFinish_ = nil
			arg_417_1.state_ = "waiting"
		end

		function arg_417_1.playNext_(arg_419_0)
			if arg_419_0 == 1 then
				arg_417_0:Play410082103(arg_417_1)
			end
		end

		function arg_417_1.onSingleLineUpdate_(arg_420_0)
			local var_420_0 = arg_417_1.actors_["1012"].transform
			local var_420_1 = 0

			if var_420_1 < arg_417_1.time_ and arg_417_1.time_ <= var_420_1 + arg_420_0 then
				arg_417_1.var_.moveOldPos1012 = var_420_0.localPosition
				var_420_0.localScale = Vector3.New(1, 1, 1)

				arg_417_1:CheckSpriteTmpPos("1012", 4)

				local var_420_2 = var_420_0.childCount

				for iter_420_0 = 0, var_420_2 - 1 do
					local var_420_3 = var_420_0:GetChild(iter_420_0)

					if var_420_3.name == "" or not string.find(var_420_3.name, "split") then
						var_420_3.gameObject:SetActive(true)
					else
						var_420_3.gameObject:SetActive(false)
					end
				end
			end

			local var_420_4 = 0.001

			if var_420_1 <= arg_417_1.time_ and arg_417_1.time_ < var_420_1 + var_420_4 then
				local var_420_5 = (arg_417_1.time_ - var_420_1) / var_420_4
				local var_420_6 = Vector3.New(390, -465, 300)

				var_420_0.localPosition = Vector3.Lerp(arg_417_1.var_.moveOldPos1012, var_420_6, var_420_5)
			end

			if arg_417_1.time_ >= var_420_1 + var_420_4 and arg_417_1.time_ < var_420_1 + var_420_4 + arg_420_0 then
				var_420_0.localPosition = Vector3.New(390, -465, 300)
			end

			local var_420_7 = arg_417_1.actors_["1012"]
			local var_420_8 = 0

			if var_420_8 < arg_417_1.time_ and arg_417_1.time_ <= var_420_8 + arg_420_0 and not isNil(var_420_7) and arg_417_1.var_.actorSpriteComps1012 == nil then
				arg_417_1.var_.actorSpriteComps1012 = var_420_7:GetComponentsInChildren(typeof(Image), true)
			end

			local var_420_9 = 0.034

			if var_420_8 <= arg_417_1.time_ and arg_417_1.time_ < var_420_8 + var_420_9 and not isNil(var_420_7) then
				local var_420_10 = (arg_417_1.time_ - var_420_8) / var_420_9

				if arg_417_1.var_.actorSpriteComps1012 then
					for iter_420_1, iter_420_2 in pairs(arg_417_1.var_.actorSpriteComps1012:ToTable()) do
						if iter_420_2 then
							if arg_417_1.isInRecall_ then
								local var_420_11 = Mathf.Lerp(iter_420_2.color.r, arg_417_1.hightColor1.r, var_420_10)
								local var_420_12 = Mathf.Lerp(iter_420_2.color.g, arg_417_1.hightColor1.g, var_420_10)
								local var_420_13 = Mathf.Lerp(iter_420_2.color.b, arg_417_1.hightColor1.b, var_420_10)

								iter_420_2.color = Color.New(var_420_11, var_420_12, var_420_13)
							else
								local var_420_14 = Mathf.Lerp(iter_420_2.color.r, 1, var_420_10)

								iter_420_2.color = Color.New(var_420_14, var_420_14, var_420_14)
							end
						end
					end
				end
			end

			if arg_417_1.time_ >= var_420_8 + var_420_9 and arg_417_1.time_ < var_420_8 + var_420_9 + arg_420_0 and not isNil(var_420_7) and arg_417_1.var_.actorSpriteComps1012 then
				for iter_420_3, iter_420_4 in pairs(arg_417_1.var_.actorSpriteComps1012:ToTable()) do
					if iter_420_4 then
						if arg_417_1.isInRecall_ then
							iter_420_4.color = arg_417_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_420_4.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_417_1.var_.actorSpriteComps1012 = nil
			end

			local var_420_15 = arg_417_1.actors_["1060"]
			local var_420_16 = 0

			if var_420_16 < arg_417_1.time_ and arg_417_1.time_ <= var_420_16 + arg_420_0 and not isNil(var_420_15) and arg_417_1.var_.actorSpriteComps1060 == nil then
				arg_417_1.var_.actorSpriteComps1060 = var_420_15:GetComponentsInChildren(typeof(Image), true)
			end

			local var_420_17 = 0.034

			if var_420_16 <= arg_417_1.time_ and arg_417_1.time_ < var_420_16 + var_420_17 and not isNil(var_420_15) then
				local var_420_18 = (arg_417_1.time_ - var_420_16) / var_420_17

				if arg_417_1.var_.actorSpriteComps1060 then
					for iter_420_5, iter_420_6 in pairs(arg_417_1.var_.actorSpriteComps1060:ToTable()) do
						if iter_420_6 then
							if arg_417_1.isInRecall_ then
								local var_420_19 = Mathf.Lerp(iter_420_6.color.r, arg_417_1.hightColor2.r, var_420_18)
								local var_420_20 = Mathf.Lerp(iter_420_6.color.g, arg_417_1.hightColor2.g, var_420_18)
								local var_420_21 = Mathf.Lerp(iter_420_6.color.b, arg_417_1.hightColor2.b, var_420_18)

								iter_420_6.color = Color.New(var_420_19, var_420_20, var_420_21)
							else
								local var_420_22 = Mathf.Lerp(iter_420_6.color.r, 0.5, var_420_18)

								iter_420_6.color = Color.New(var_420_22, var_420_22, var_420_22)
							end
						end
					end
				end
			end

			if arg_417_1.time_ >= var_420_16 + var_420_17 and arg_417_1.time_ < var_420_16 + var_420_17 + arg_420_0 and not isNil(var_420_15) and arg_417_1.var_.actorSpriteComps1060 then
				for iter_420_7, iter_420_8 in pairs(arg_417_1.var_.actorSpriteComps1060:ToTable()) do
					if iter_420_8 then
						if arg_417_1.isInRecall_ then
							iter_420_8.color = arg_417_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_420_8.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_417_1.var_.actorSpriteComps1060 = nil
			end

			local var_420_23 = 0
			local var_420_24 = 0.55

			if var_420_23 < arg_417_1.time_ and arg_417_1.time_ <= var_420_23 + arg_420_0 then
				arg_417_1.talkMaxDuration = 0
				arg_417_1.dialogCg_.alpha = 1

				arg_417_1.dialog_:SetActive(true)
				SetActive(arg_417_1.leftNameGo_, true)

				local var_420_25 = arg_417_1:FormatText(StoryNameCfg[595].name)

				arg_417_1.leftNameTxt_.text = var_420_25

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_417_1.leftNameTxt_.transform)

				arg_417_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_417_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_417_1:RecordName(arg_417_1.leftNameTxt_.text)
				SetActive(arg_417_1.iconTrs_.gameObject, false)
				arg_417_1.callingController_:SetSelectedState("normal")

				local var_420_26 = arg_417_1:GetWordFromCfg(410082102)
				local var_420_27 = arg_417_1:FormatText(var_420_26.content)

				arg_417_1.text_.text = var_420_27

				LuaForUtil.ClearLinePrefixSymbol(arg_417_1.text_)

				local var_420_28 = 22
				local var_420_29 = utf8.len(var_420_27)
				local var_420_30 = var_420_28 <= 0 and var_420_24 or var_420_24 * (var_420_29 / var_420_28)

				if var_420_30 > 0 and var_420_24 < var_420_30 then
					arg_417_1.talkMaxDuration = var_420_30

					if var_420_30 + var_420_23 > arg_417_1.duration_ then
						arg_417_1.duration_ = var_420_30 + var_420_23
					end
				end

				arg_417_1.text_.text = var_420_27
				arg_417_1.typewritter.percent = 0

				arg_417_1.typewritter:SetDirty()
				arg_417_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_410082", "410082102", "story_v_out_410082.awb") ~= 0 then
					local var_420_31 = manager.audio:GetVoiceLength("story_v_out_410082", "410082102", "story_v_out_410082.awb") / 1000

					if var_420_31 + var_420_23 > arg_417_1.duration_ then
						arg_417_1.duration_ = var_420_31 + var_420_23
					end

					if var_420_26.prefab_name ~= "" and arg_417_1.actors_[var_420_26.prefab_name] ~= nil then
						local var_420_32 = LuaForUtil.PlayVoiceWithCriLipsync(arg_417_1.actors_[var_420_26.prefab_name].transform, "story_v_out_410082", "410082102", "story_v_out_410082.awb")

						arg_417_1:RecordAudio("410082102", var_420_32)
						arg_417_1:RecordAudio("410082102", var_420_32)
					else
						arg_417_1:AudioAction("play", "voice", "story_v_out_410082", "410082102", "story_v_out_410082.awb")
					end

					arg_417_1:RecordHistoryTalkVoice("story_v_out_410082", "410082102", "story_v_out_410082.awb")
				end

				arg_417_1:RecordContent(arg_417_1.text_.text)
			end

			local var_420_33 = math.max(var_420_24, arg_417_1.talkMaxDuration)

			if var_420_23 <= arg_417_1.time_ and arg_417_1.time_ < var_420_23 + var_420_33 then
				arg_417_1.typewritter.percent = (arg_417_1.time_ - var_420_23) / var_420_33

				arg_417_1.typewritter:SetDirty()
			end

			if arg_417_1.time_ >= var_420_23 + var_420_33 and arg_417_1.time_ < var_420_23 + var_420_33 + arg_420_0 then
				arg_417_1.typewritter.percent = 1

				arg_417_1.typewritter:SetDirty()
				arg_417_1:ShowNextGo(true)
			end
		end

		arg_417_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1012",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_417_1:InitPlayNodeList()
	end,
	Play410082103 = function(arg_421_0, arg_421_1)
		arg_421_1.time_ = 0
		arg_421_1.frameCnt_ = 0
		arg_421_1.state_ = "playing"
		arg_421_1.curTalkId_ = 410082103
		arg_421_1.duration_ = 5.37

		local var_421_0 = {
			zh = 2.7,
			ja = 5.366
		}
		local var_421_1 = manager.audio:GetLocalizationFlag()

		if var_421_0[var_421_1] ~= nil then
			arg_421_1.duration_ = var_421_0[var_421_1]
		end

		SetActive(arg_421_1.tipsGo_, false)

		function arg_421_1.onSingleLineFinish_()
			arg_421_1.onSingleLineUpdate_ = nil
			arg_421_1.onSingleLineFinish_ = nil
			arg_421_1.state_ = "waiting"
		end

		function arg_421_1.playNext_(arg_423_0)
			if arg_423_0 == 1 then
				arg_421_0:Play410082104(arg_421_1)
			end
		end

		function arg_421_1.onSingleLineUpdate_(arg_424_0)
			local var_424_0 = arg_421_1.actors_["1060"].transform
			local var_424_1 = 0

			if var_424_1 < arg_421_1.time_ and arg_421_1.time_ <= var_424_1 + arg_424_0 then
				arg_421_1.var_.moveOldPos1060 = var_424_0.localPosition
				var_424_0.localScale = Vector3.New(1, 1, 1)

				arg_421_1:CheckSpriteTmpPos("1060", 2)

				local var_424_2 = var_424_0.childCount

				for iter_424_0 = 0, var_424_2 - 1 do
					local var_424_3 = var_424_0:GetChild(iter_424_0)

					if var_424_3.name == "split_3" or not string.find(var_424_3.name, "split") then
						var_424_3.gameObject:SetActive(true)
					else
						var_424_3.gameObject:SetActive(false)
					end
				end
			end

			local var_424_4 = 0.001

			if var_424_1 <= arg_421_1.time_ and arg_421_1.time_ < var_424_1 + var_424_4 then
				local var_424_5 = (arg_421_1.time_ - var_424_1) / var_424_4
				local var_424_6 = Vector3.New(-440.94, -430.8, 6.9)

				var_424_0.localPosition = Vector3.Lerp(arg_421_1.var_.moveOldPos1060, var_424_6, var_424_5)
			end

			if arg_421_1.time_ >= var_424_1 + var_424_4 and arg_421_1.time_ < var_424_1 + var_424_4 + arg_424_0 then
				var_424_0.localPosition = Vector3.New(-440.94, -430.8, 6.9)
			end

			local var_424_7 = arg_421_1.actors_["1060"]
			local var_424_8 = 0

			if var_424_8 < arg_421_1.time_ and arg_421_1.time_ <= var_424_8 + arg_424_0 and not isNil(var_424_7) and arg_421_1.var_.actorSpriteComps1060 == nil then
				arg_421_1.var_.actorSpriteComps1060 = var_424_7:GetComponentsInChildren(typeof(Image), true)
			end

			local var_424_9 = 0.034

			if var_424_8 <= arg_421_1.time_ and arg_421_1.time_ < var_424_8 + var_424_9 and not isNil(var_424_7) then
				local var_424_10 = (arg_421_1.time_ - var_424_8) / var_424_9

				if arg_421_1.var_.actorSpriteComps1060 then
					for iter_424_1, iter_424_2 in pairs(arg_421_1.var_.actorSpriteComps1060:ToTable()) do
						if iter_424_2 then
							if arg_421_1.isInRecall_ then
								local var_424_11 = Mathf.Lerp(iter_424_2.color.r, arg_421_1.hightColor1.r, var_424_10)
								local var_424_12 = Mathf.Lerp(iter_424_2.color.g, arg_421_1.hightColor1.g, var_424_10)
								local var_424_13 = Mathf.Lerp(iter_424_2.color.b, arg_421_1.hightColor1.b, var_424_10)

								iter_424_2.color = Color.New(var_424_11, var_424_12, var_424_13)
							else
								local var_424_14 = Mathf.Lerp(iter_424_2.color.r, 1, var_424_10)

								iter_424_2.color = Color.New(var_424_14, var_424_14, var_424_14)
							end
						end
					end
				end
			end

			if arg_421_1.time_ >= var_424_8 + var_424_9 and arg_421_1.time_ < var_424_8 + var_424_9 + arg_424_0 and not isNil(var_424_7) and arg_421_1.var_.actorSpriteComps1060 then
				for iter_424_3, iter_424_4 in pairs(arg_421_1.var_.actorSpriteComps1060:ToTable()) do
					if iter_424_4 then
						if arg_421_1.isInRecall_ then
							iter_424_4.color = arg_421_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_424_4.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_421_1.var_.actorSpriteComps1060 = nil
			end

			local var_424_15 = arg_421_1.actors_["1012"]
			local var_424_16 = 0

			if var_424_16 < arg_421_1.time_ and arg_421_1.time_ <= var_424_16 + arg_424_0 and not isNil(var_424_15) and arg_421_1.var_.actorSpriteComps1012 == nil then
				arg_421_1.var_.actorSpriteComps1012 = var_424_15:GetComponentsInChildren(typeof(Image), true)
			end

			local var_424_17 = 0.034

			if var_424_16 <= arg_421_1.time_ and arg_421_1.time_ < var_424_16 + var_424_17 and not isNil(var_424_15) then
				local var_424_18 = (arg_421_1.time_ - var_424_16) / var_424_17

				if arg_421_1.var_.actorSpriteComps1012 then
					for iter_424_5, iter_424_6 in pairs(arg_421_1.var_.actorSpriteComps1012:ToTable()) do
						if iter_424_6 then
							if arg_421_1.isInRecall_ then
								local var_424_19 = Mathf.Lerp(iter_424_6.color.r, arg_421_1.hightColor2.r, var_424_18)
								local var_424_20 = Mathf.Lerp(iter_424_6.color.g, arg_421_1.hightColor2.g, var_424_18)
								local var_424_21 = Mathf.Lerp(iter_424_6.color.b, arg_421_1.hightColor2.b, var_424_18)

								iter_424_6.color = Color.New(var_424_19, var_424_20, var_424_21)
							else
								local var_424_22 = Mathf.Lerp(iter_424_6.color.r, 0.5, var_424_18)

								iter_424_6.color = Color.New(var_424_22, var_424_22, var_424_22)
							end
						end
					end
				end
			end

			if arg_421_1.time_ >= var_424_16 + var_424_17 and arg_421_1.time_ < var_424_16 + var_424_17 + arg_424_0 and not isNil(var_424_15) and arg_421_1.var_.actorSpriteComps1012 then
				for iter_424_7, iter_424_8 in pairs(arg_421_1.var_.actorSpriteComps1012:ToTable()) do
					if iter_424_8 then
						if arg_421_1.isInRecall_ then
							iter_424_8.color = arg_421_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_424_8.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_421_1.var_.actorSpriteComps1012 = nil
			end

			local var_424_23 = 0
			local var_424_24 = 0.35

			if var_424_23 < arg_421_1.time_ and arg_421_1.time_ <= var_424_23 + arg_424_0 then
				arg_421_1.talkMaxDuration = 0
				arg_421_1.dialogCg_.alpha = 1

				arg_421_1.dialog_:SetActive(true)
				SetActive(arg_421_1.leftNameGo_, true)

				local var_424_25 = arg_421_1:FormatText(StoryNameCfg[584].name)

				arg_421_1.leftNameTxt_.text = var_424_25

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_421_1.leftNameTxt_.transform)

				arg_421_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_421_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_421_1:RecordName(arg_421_1.leftNameTxt_.text)
				SetActive(arg_421_1.iconTrs_.gameObject, false)
				arg_421_1.callingController_:SetSelectedState("normal")

				local var_424_26 = arg_421_1:GetWordFromCfg(410082103)
				local var_424_27 = arg_421_1:FormatText(var_424_26.content)

				arg_421_1.text_.text = var_424_27

				LuaForUtil.ClearLinePrefixSymbol(arg_421_1.text_)

				local var_424_28 = 14
				local var_424_29 = utf8.len(var_424_27)
				local var_424_30 = var_424_28 <= 0 and var_424_24 or var_424_24 * (var_424_29 / var_424_28)

				if var_424_30 > 0 and var_424_24 < var_424_30 then
					arg_421_1.talkMaxDuration = var_424_30

					if var_424_30 + var_424_23 > arg_421_1.duration_ then
						arg_421_1.duration_ = var_424_30 + var_424_23
					end
				end

				arg_421_1.text_.text = var_424_27
				arg_421_1.typewritter.percent = 0

				arg_421_1.typewritter:SetDirty()
				arg_421_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_410082", "410082103", "story_v_out_410082.awb") ~= 0 then
					local var_424_31 = manager.audio:GetVoiceLength("story_v_out_410082", "410082103", "story_v_out_410082.awb") / 1000

					if var_424_31 + var_424_23 > arg_421_1.duration_ then
						arg_421_1.duration_ = var_424_31 + var_424_23
					end

					if var_424_26.prefab_name ~= "" and arg_421_1.actors_[var_424_26.prefab_name] ~= nil then
						local var_424_32 = LuaForUtil.PlayVoiceWithCriLipsync(arg_421_1.actors_[var_424_26.prefab_name].transform, "story_v_out_410082", "410082103", "story_v_out_410082.awb")

						arg_421_1:RecordAudio("410082103", var_424_32)
						arg_421_1:RecordAudio("410082103", var_424_32)
					else
						arg_421_1:AudioAction("play", "voice", "story_v_out_410082", "410082103", "story_v_out_410082.awb")
					end

					arg_421_1:RecordHistoryTalkVoice("story_v_out_410082", "410082103", "story_v_out_410082.awb")
				end

				arg_421_1:RecordContent(arg_421_1.text_.text)
			end

			local var_424_33 = math.max(var_424_24, arg_421_1.talkMaxDuration)

			if var_424_23 <= arg_421_1.time_ and arg_421_1.time_ < var_424_23 + var_424_33 then
				arg_421_1.typewritter.percent = (arg_421_1.time_ - var_424_23) / var_424_33

				arg_421_1.typewritter:SetDirty()
			end

			if arg_421_1.time_ >= var_424_23 + var_424_33 and arg_421_1.time_ < var_424_23 + var_424_33 + arg_424_0 then
				arg_421_1.typewritter.percent = 1

				arg_421_1.typewritter:SetDirty()
				arg_421_1:ShowNextGo(true)
			end
		end

		arg_421_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1060",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_421_1:InitPlayNodeList()
	end,
	Play410082104 = function(arg_425_0, arg_425_1)
		arg_425_1.time_ = 0
		arg_425_1.frameCnt_ = 0
		arg_425_1.state_ = "playing"
		arg_425_1.curTalkId_ = 410082104
		arg_425_1.duration_ = 1.47

		local var_425_0 = {
			zh = 1.466,
			ja = 1.266
		}
		local var_425_1 = manager.audio:GetLocalizationFlag()

		if var_425_0[var_425_1] ~= nil then
			arg_425_1.duration_ = var_425_0[var_425_1]
		end

		SetActive(arg_425_1.tipsGo_, false)

		function arg_425_1.onSingleLineFinish_()
			arg_425_1.onSingleLineUpdate_ = nil
			arg_425_1.onSingleLineFinish_ = nil
			arg_425_1.state_ = "waiting"
		end

		function arg_425_1.playNext_(arg_427_0)
			if arg_427_0 == 1 then
				arg_425_0:Play410082105(arg_425_1)
			end
		end

		function arg_425_1.onSingleLineUpdate_(arg_428_0)
			local var_428_0 = arg_425_1.actors_["1012"].transform
			local var_428_1 = 0

			if var_428_1 < arg_425_1.time_ and arg_425_1.time_ <= var_428_1 + arg_428_0 then
				arg_425_1.var_.moveOldPos1012 = var_428_0.localPosition
				var_428_0.localScale = Vector3.New(1, 1, 1)

				arg_425_1:CheckSpriteTmpPos("1012", 4)

				local var_428_2 = var_428_0.childCount

				for iter_428_0 = 0, var_428_2 - 1 do
					local var_428_3 = var_428_0:GetChild(iter_428_0)

					if var_428_3.name == "" or not string.find(var_428_3.name, "split") then
						var_428_3.gameObject:SetActive(true)
					else
						var_428_3.gameObject:SetActive(false)
					end
				end
			end

			local var_428_4 = 0.001

			if var_428_1 <= arg_425_1.time_ and arg_425_1.time_ < var_428_1 + var_428_4 then
				local var_428_5 = (arg_425_1.time_ - var_428_1) / var_428_4
				local var_428_6 = Vector3.New(390, -465, 300)

				var_428_0.localPosition = Vector3.Lerp(arg_425_1.var_.moveOldPos1012, var_428_6, var_428_5)
			end

			if arg_425_1.time_ >= var_428_1 + var_428_4 and arg_425_1.time_ < var_428_1 + var_428_4 + arg_428_0 then
				var_428_0.localPosition = Vector3.New(390, -465, 300)
			end

			local var_428_7 = arg_425_1.actors_["1012"]
			local var_428_8 = 0

			if var_428_8 < arg_425_1.time_ and arg_425_1.time_ <= var_428_8 + arg_428_0 and not isNil(var_428_7) and arg_425_1.var_.actorSpriteComps1012 == nil then
				arg_425_1.var_.actorSpriteComps1012 = var_428_7:GetComponentsInChildren(typeof(Image), true)
			end

			local var_428_9 = 0.034

			if var_428_8 <= arg_425_1.time_ and arg_425_1.time_ < var_428_8 + var_428_9 and not isNil(var_428_7) then
				local var_428_10 = (arg_425_1.time_ - var_428_8) / var_428_9

				if arg_425_1.var_.actorSpriteComps1012 then
					for iter_428_1, iter_428_2 in pairs(arg_425_1.var_.actorSpriteComps1012:ToTable()) do
						if iter_428_2 then
							if arg_425_1.isInRecall_ then
								local var_428_11 = Mathf.Lerp(iter_428_2.color.r, arg_425_1.hightColor1.r, var_428_10)
								local var_428_12 = Mathf.Lerp(iter_428_2.color.g, arg_425_1.hightColor1.g, var_428_10)
								local var_428_13 = Mathf.Lerp(iter_428_2.color.b, arg_425_1.hightColor1.b, var_428_10)

								iter_428_2.color = Color.New(var_428_11, var_428_12, var_428_13)
							else
								local var_428_14 = Mathf.Lerp(iter_428_2.color.r, 1, var_428_10)

								iter_428_2.color = Color.New(var_428_14, var_428_14, var_428_14)
							end
						end
					end
				end
			end

			if arg_425_1.time_ >= var_428_8 + var_428_9 and arg_425_1.time_ < var_428_8 + var_428_9 + arg_428_0 and not isNil(var_428_7) and arg_425_1.var_.actorSpriteComps1012 then
				for iter_428_3, iter_428_4 in pairs(arg_425_1.var_.actorSpriteComps1012:ToTable()) do
					if iter_428_4 then
						if arg_425_1.isInRecall_ then
							iter_428_4.color = arg_425_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_428_4.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_425_1.var_.actorSpriteComps1012 = nil
			end

			local var_428_15 = arg_425_1.actors_["1060"]
			local var_428_16 = 0

			if var_428_16 < arg_425_1.time_ and arg_425_1.time_ <= var_428_16 + arg_428_0 and not isNil(var_428_15) and arg_425_1.var_.actorSpriteComps1060 == nil then
				arg_425_1.var_.actorSpriteComps1060 = var_428_15:GetComponentsInChildren(typeof(Image), true)
			end

			local var_428_17 = 0.034

			if var_428_16 <= arg_425_1.time_ and arg_425_1.time_ < var_428_16 + var_428_17 and not isNil(var_428_15) then
				local var_428_18 = (arg_425_1.time_ - var_428_16) / var_428_17

				if arg_425_1.var_.actorSpriteComps1060 then
					for iter_428_5, iter_428_6 in pairs(arg_425_1.var_.actorSpriteComps1060:ToTable()) do
						if iter_428_6 then
							if arg_425_1.isInRecall_ then
								local var_428_19 = Mathf.Lerp(iter_428_6.color.r, arg_425_1.hightColor2.r, var_428_18)
								local var_428_20 = Mathf.Lerp(iter_428_6.color.g, arg_425_1.hightColor2.g, var_428_18)
								local var_428_21 = Mathf.Lerp(iter_428_6.color.b, arg_425_1.hightColor2.b, var_428_18)

								iter_428_6.color = Color.New(var_428_19, var_428_20, var_428_21)
							else
								local var_428_22 = Mathf.Lerp(iter_428_6.color.r, 0.5, var_428_18)

								iter_428_6.color = Color.New(var_428_22, var_428_22, var_428_22)
							end
						end
					end
				end
			end

			if arg_425_1.time_ >= var_428_16 + var_428_17 and arg_425_1.time_ < var_428_16 + var_428_17 + arg_428_0 and not isNil(var_428_15) and arg_425_1.var_.actorSpriteComps1060 then
				for iter_428_7, iter_428_8 in pairs(arg_425_1.var_.actorSpriteComps1060:ToTable()) do
					if iter_428_8 then
						if arg_425_1.isInRecall_ then
							iter_428_8.color = arg_425_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_428_8.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_425_1.var_.actorSpriteComps1060 = nil
			end

			local var_428_23 = 0
			local var_428_24 = 0.1

			if var_428_23 < arg_425_1.time_ and arg_425_1.time_ <= var_428_23 + arg_428_0 then
				arg_425_1.talkMaxDuration = 0
				arg_425_1.dialogCg_.alpha = 1

				arg_425_1.dialog_:SetActive(true)
				SetActive(arg_425_1.leftNameGo_, true)

				local var_428_25 = arg_425_1:FormatText(StoryNameCfg[595].name)

				arg_425_1.leftNameTxt_.text = var_428_25

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_425_1.leftNameTxt_.transform)

				arg_425_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_425_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_425_1:RecordName(arg_425_1.leftNameTxt_.text)
				SetActive(arg_425_1.iconTrs_.gameObject, false)
				arg_425_1.callingController_:SetSelectedState("normal")

				local var_428_26 = arg_425_1:GetWordFromCfg(410082104)
				local var_428_27 = arg_425_1:FormatText(var_428_26.content)

				arg_425_1.text_.text = var_428_27

				LuaForUtil.ClearLinePrefixSymbol(arg_425_1.text_)

				local var_428_28 = 4
				local var_428_29 = utf8.len(var_428_27)
				local var_428_30 = var_428_28 <= 0 and var_428_24 or var_428_24 * (var_428_29 / var_428_28)

				if var_428_30 > 0 and var_428_24 < var_428_30 then
					arg_425_1.talkMaxDuration = var_428_30

					if var_428_30 + var_428_23 > arg_425_1.duration_ then
						arg_425_1.duration_ = var_428_30 + var_428_23
					end
				end

				arg_425_1.text_.text = var_428_27
				arg_425_1.typewritter.percent = 0

				arg_425_1.typewritter:SetDirty()
				arg_425_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_410082", "410082104", "story_v_out_410082.awb") ~= 0 then
					local var_428_31 = manager.audio:GetVoiceLength("story_v_out_410082", "410082104", "story_v_out_410082.awb") / 1000

					if var_428_31 + var_428_23 > arg_425_1.duration_ then
						arg_425_1.duration_ = var_428_31 + var_428_23
					end

					if var_428_26.prefab_name ~= "" and arg_425_1.actors_[var_428_26.prefab_name] ~= nil then
						local var_428_32 = LuaForUtil.PlayVoiceWithCriLipsync(arg_425_1.actors_[var_428_26.prefab_name].transform, "story_v_out_410082", "410082104", "story_v_out_410082.awb")

						arg_425_1:RecordAudio("410082104", var_428_32)
						arg_425_1:RecordAudio("410082104", var_428_32)
					else
						arg_425_1:AudioAction("play", "voice", "story_v_out_410082", "410082104", "story_v_out_410082.awb")
					end

					arg_425_1:RecordHistoryTalkVoice("story_v_out_410082", "410082104", "story_v_out_410082.awb")
				end

				arg_425_1:RecordContent(arg_425_1.text_.text)
			end

			local var_428_33 = math.max(var_428_24, arg_425_1.talkMaxDuration)

			if var_428_23 <= arg_425_1.time_ and arg_425_1.time_ < var_428_23 + var_428_33 then
				arg_425_1.typewritter.percent = (arg_425_1.time_ - var_428_23) / var_428_33

				arg_425_1.typewritter:SetDirty()
			end

			if arg_425_1.time_ >= var_428_23 + var_428_33 and arg_425_1.time_ < var_428_23 + var_428_33 + arg_428_0 then
				arg_425_1.typewritter.percent = 1

				arg_425_1.typewritter:SetDirty()
				arg_425_1:ShowNextGo(true)
			end
		end

		arg_425_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1012",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_425_1:InitPlayNodeList()
	end,
	Play410082105 = function(arg_429_0, arg_429_1)
		arg_429_1.time_ = 0
		arg_429_1.frameCnt_ = 0
		arg_429_1.state_ = "playing"
		arg_429_1.curTalkId_ = 410082105
		arg_429_1.duration_ = 5

		SetActive(arg_429_1.tipsGo_, false)

		function arg_429_1.onSingleLineFinish_()
			arg_429_1.onSingleLineUpdate_ = nil
			arg_429_1.onSingleLineFinish_ = nil
			arg_429_1.state_ = "waiting"
		end

		function arg_429_1.playNext_(arg_431_0)
			if arg_431_0 == 1 then
				arg_429_0:Play410082106(arg_429_1)
			end
		end

		function arg_429_1.onSingleLineUpdate_(arg_432_0)
			local var_432_0 = arg_429_1.actors_["1012"]
			local var_432_1 = 0

			if var_432_1 < arg_429_1.time_ and arg_429_1.time_ <= var_432_1 + arg_432_0 and not isNil(var_432_0) and arg_429_1.var_.actorSpriteComps1012 == nil then
				arg_429_1.var_.actorSpriteComps1012 = var_432_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_432_2 = 0.034

			if var_432_1 <= arg_429_1.time_ and arg_429_1.time_ < var_432_1 + var_432_2 and not isNil(var_432_0) then
				local var_432_3 = (arg_429_1.time_ - var_432_1) / var_432_2

				if arg_429_1.var_.actorSpriteComps1012 then
					for iter_432_0, iter_432_1 in pairs(arg_429_1.var_.actorSpriteComps1012:ToTable()) do
						if iter_432_1 then
							if arg_429_1.isInRecall_ then
								local var_432_4 = Mathf.Lerp(iter_432_1.color.r, arg_429_1.hightColor2.r, var_432_3)
								local var_432_5 = Mathf.Lerp(iter_432_1.color.g, arg_429_1.hightColor2.g, var_432_3)
								local var_432_6 = Mathf.Lerp(iter_432_1.color.b, arg_429_1.hightColor2.b, var_432_3)

								iter_432_1.color = Color.New(var_432_4, var_432_5, var_432_6)
							else
								local var_432_7 = Mathf.Lerp(iter_432_1.color.r, 0.5, var_432_3)

								iter_432_1.color = Color.New(var_432_7, var_432_7, var_432_7)
							end
						end
					end
				end
			end

			if arg_429_1.time_ >= var_432_1 + var_432_2 and arg_429_1.time_ < var_432_1 + var_432_2 + arg_432_0 and not isNil(var_432_0) and arg_429_1.var_.actorSpriteComps1012 then
				for iter_432_2, iter_432_3 in pairs(arg_429_1.var_.actorSpriteComps1012:ToTable()) do
					if iter_432_3 then
						if arg_429_1.isInRecall_ then
							iter_432_3.color = arg_429_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_432_3.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_429_1.var_.actorSpriteComps1012 = nil
			end

			local var_432_8 = arg_429_1.actors_["1012"].transform
			local var_432_9 = 0

			if var_432_9 < arg_429_1.time_ and arg_429_1.time_ <= var_432_9 + arg_432_0 then
				arg_429_1.var_.moveOldPos1012 = var_432_8.localPosition
				var_432_8.localScale = Vector3.New(1, 1, 1)

				arg_429_1:CheckSpriteTmpPos("1012", 4)

				local var_432_10 = var_432_8.childCount

				for iter_432_4 = 0, var_432_10 - 1 do
					local var_432_11 = var_432_8:GetChild(iter_432_4)

					if var_432_11.name == "split_2" or not string.find(var_432_11.name, "split") then
						var_432_11.gameObject:SetActive(true)
					else
						var_432_11.gameObject:SetActive(false)
					end
				end
			end

			local var_432_12 = 0.001

			if var_432_9 <= arg_429_1.time_ and arg_429_1.time_ < var_432_9 + var_432_12 then
				local var_432_13 = (arg_429_1.time_ - var_432_9) / var_432_12
				local var_432_14 = Vector3.New(390, -465, 300)

				var_432_8.localPosition = Vector3.Lerp(arg_429_1.var_.moveOldPos1012, var_432_14, var_432_13)
			end

			if arg_429_1.time_ >= var_432_9 + var_432_12 and arg_429_1.time_ < var_432_9 + var_432_12 + arg_432_0 then
				var_432_8.localPosition = Vector3.New(390, -465, 300)
			end

			local var_432_15 = 0
			local var_432_16 = 0.95

			if var_432_15 < arg_429_1.time_ and arg_429_1.time_ <= var_432_15 + arg_432_0 then
				arg_429_1.talkMaxDuration = 0
				arg_429_1.dialogCg_.alpha = 1

				arg_429_1.dialog_:SetActive(true)
				SetActive(arg_429_1.leftNameGo_, false)

				arg_429_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_429_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_429_1:RecordName(arg_429_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_429_1.iconTrs_.gameObject, false)
				arg_429_1.callingController_:SetSelectedState("normal")

				local var_432_17 = arg_429_1:GetWordFromCfg(410082105)
				local var_432_18 = arg_429_1:FormatText(var_432_17.content)

				arg_429_1.text_.text = var_432_18

				LuaForUtil.ClearLinePrefixSymbol(arg_429_1.text_)

				local var_432_19 = 38
				local var_432_20 = utf8.len(var_432_18)
				local var_432_21 = var_432_19 <= 0 and var_432_16 or var_432_16 * (var_432_20 / var_432_19)

				if var_432_21 > 0 and var_432_16 < var_432_21 then
					arg_429_1.talkMaxDuration = var_432_21

					if var_432_21 + var_432_15 > arg_429_1.duration_ then
						arg_429_1.duration_ = var_432_21 + var_432_15
					end
				end

				arg_429_1.text_.text = var_432_18
				arg_429_1.typewritter.percent = 0

				arg_429_1.typewritter:SetDirty()
				arg_429_1:ShowNextGo(false)
				arg_429_1:RecordContent(arg_429_1.text_.text)
			end

			local var_432_22 = math.max(var_432_16, arg_429_1.talkMaxDuration)

			if var_432_15 <= arg_429_1.time_ and arg_429_1.time_ < var_432_15 + var_432_22 then
				arg_429_1.typewritter.percent = (arg_429_1.time_ - var_432_15) / var_432_22

				arg_429_1.typewritter:SetDirty()
			end

			if arg_429_1.time_ >= var_432_15 + var_432_22 and arg_429_1.time_ < var_432_15 + var_432_22 + arg_432_0 then
				arg_429_1.typewritter.percent = 1

				arg_429_1.typewritter:SetDirty()
				arg_429_1:ShowNextGo(true)
			end
		end

		arg_429_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1012",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_429_1:InitPlayNodeList()
	end,
	Play410082106 = function(arg_433_0, arg_433_1)
		arg_433_1.time_ = 0
		arg_433_1.frameCnt_ = 0
		arg_433_1.state_ = "playing"
		arg_433_1.curTalkId_ = 410082106
		arg_433_1.duration_ = 10.63

		local var_433_0 = {
			zh = 10.633,
			ja = 9.5
		}
		local var_433_1 = manager.audio:GetLocalizationFlag()

		if var_433_0[var_433_1] ~= nil then
			arg_433_1.duration_ = var_433_0[var_433_1]
		end

		SetActive(arg_433_1.tipsGo_, false)

		function arg_433_1.onSingleLineFinish_()
			arg_433_1.onSingleLineUpdate_ = nil
			arg_433_1.onSingleLineFinish_ = nil
			arg_433_1.state_ = "waiting"
		end

		function arg_433_1.playNext_(arg_435_0)
			if arg_435_0 == 1 then
				arg_433_0:Play410082107(arg_433_1)
			end
		end

		function arg_433_1.onSingleLineUpdate_(arg_436_0)
			local var_436_0 = arg_433_1.actors_["1012"].transform
			local var_436_1 = 0

			if var_436_1 < arg_433_1.time_ and arg_433_1.time_ <= var_436_1 + arg_436_0 then
				arg_433_1.var_.moveOldPos1012 = var_436_0.localPosition
				var_436_0.localScale = Vector3.New(1, 1, 1)

				arg_433_1:CheckSpriteTmpPos("1012", 4)

				local var_436_2 = var_436_0.childCount

				for iter_436_0 = 0, var_436_2 - 1 do
					local var_436_3 = var_436_0:GetChild(iter_436_0)

					if var_436_3.name == "split_3" or not string.find(var_436_3.name, "split") then
						var_436_3.gameObject:SetActive(true)
					else
						var_436_3.gameObject:SetActive(false)
					end
				end
			end

			local var_436_4 = 0.001

			if var_436_1 <= arg_433_1.time_ and arg_433_1.time_ < var_436_1 + var_436_4 then
				local var_436_5 = (arg_433_1.time_ - var_436_1) / var_436_4
				local var_436_6 = Vector3.New(390, -465, 300)

				var_436_0.localPosition = Vector3.Lerp(arg_433_1.var_.moveOldPos1012, var_436_6, var_436_5)
			end

			if arg_433_1.time_ >= var_436_1 + var_436_4 and arg_433_1.time_ < var_436_1 + var_436_4 + arg_436_0 then
				var_436_0.localPosition = Vector3.New(390, -465, 300)
			end

			local var_436_7 = arg_433_1.actors_["1012"]
			local var_436_8 = 0

			if var_436_8 < arg_433_1.time_ and arg_433_1.time_ <= var_436_8 + arg_436_0 and not isNil(var_436_7) and arg_433_1.var_.actorSpriteComps1012 == nil then
				arg_433_1.var_.actorSpriteComps1012 = var_436_7:GetComponentsInChildren(typeof(Image), true)
			end

			local var_436_9 = 0.034

			if var_436_8 <= arg_433_1.time_ and arg_433_1.time_ < var_436_8 + var_436_9 and not isNil(var_436_7) then
				local var_436_10 = (arg_433_1.time_ - var_436_8) / var_436_9

				if arg_433_1.var_.actorSpriteComps1012 then
					for iter_436_1, iter_436_2 in pairs(arg_433_1.var_.actorSpriteComps1012:ToTable()) do
						if iter_436_2 then
							if arg_433_1.isInRecall_ then
								local var_436_11 = Mathf.Lerp(iter_436_2.color.r, arg_433_1.hightColor1.r, var_436_10)
								local var_436_12 = Mathf.Lerp(iter_436_2.color.g, arg_433_1.hightColor1.g, var_436_10)
								local var_436_13 = Mathf.Lerp(iter_436_2.color.b, arg_433_1.hightColor1.b, var_436_10)

								iter_436_2.color = Color.New(var_436_11, var_436_12, var_436_13)
							else
								local var_436_14 = Mathf.Lerp(iter_436_2.color.r, 1, var_436_10)

								iter_436_2.color = Color.New(var_436_14, var_436_14, var_436_14)
							end
						end
					end
				end
			end

			if arg_433_1.time_ >= var_436_8 + var_436_9 and arg_433_1.time_ < var_436_8 + var_436_9 + arg_436_0 and not isNil(var_436_7) and arg_433_1.var_.actorSpriteComps1012 then
				for iter_436_3, iter_436_4 in pairs(arg_433_1.var_.actorSpriteComps1012:ToTable()) do
					if iter_436_4 then
						if arg_433_1.isInRecall_ then
							iter_436_4.color = arg_433_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_436_4.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_433_1.var_.actorSpriteComps1012 = nil
			end

			local var_436_15 = 0
			local var_436_16 = 1.1

			if var_436_15 < arg_433_1.time_ and arg_433_1.time_ <= var_436_15 + arg_436_0 then
				arg_433_1.talkMaxDuration = 0
				arg_433_1.dialogCg_.alpha = 1

				arg_433_1.dialog_:SetActive(true)
				SetActive(arg_433_1.leftNameGo_, true)

				local var_436_17 = arg_433_1:FormatText(StoryNameCfg[595].name)

				arg_433_1.leftNameTxt_.text = var_436_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_433_1.leftNameTxt_.transform)

				arg_433_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_433_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_433_1:RecordName(arg_433_1.leftNameTxt_.text)
				SetActive(arg_433_1.iconTrs_.gameObject, false)
				arg_433_1.callingController_:SetSelectedState("normal")

				local var_436_18 = arg_433_1:GetWordFromCfg(410082106)
				local var_436_19 = arg_433_1:FormatText(var_436_18.content)

				arg_433_1.text_.text = var_436_19

				LuaForUtil.ClearLinePrefixSymbol(arg_433_1.text_)

				local var_436_20 = 44
				local var_436_21 = utf8.len(var_436_19)
				local var_436_22 = var_436_20 <= 0 and var_436_16 or var_436_16 * (var_436_21 / var_436_20)

				if var_436_22 > 0 and var_436_16 < var_436_22 then
					arg_433_1.talkMaxDuration = var_436_22

					if var_436_22 + var_436_15 > arg_433_1.duration_ then
						arg_433_1.duration_ = var_436_22 + var_436_15
					end
				end

				arg_433_1.text_.text = var_436_19
				arg_433_1.typewritter.percent = 0

				arg_433_1.typewritter:SetDirty()
				arg_433_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_410082", "410082106", "story_v_out_410082.awb") ~= 0 then
					local var_436_23 = manager.audio:GetVoiceLength("story_v_out_410082", "410082106", "story_v_out_410082.awb") / 1000

					if var_436_23 + var_436_15 > arg_433_1.duration_ then
						arg_433_1.duration_ = var_436_23 + var_436_15
					end

					if var_436_18.prefab_name ~= "" and arg_433_1.actors_[var_436_18.prefab_name] ~= nil then
						local var_436_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_433_1.actors_[var_436_18.prefab_name].transform, "story_v_out_410082", "410082106", "story_v_out_410082.awb")

						arg_433_1:RecordAudio("410082106", var_436_24)
						arg_433_1:RecordAudio("410082106", var_436_24)
					else
						arg_433_1:AudioAction("play", "voice", "story_v_out_410082", "410082106", "story_v_out_410082.awb")
					end

					arg_433_1:RecordHistoryTalkVoice("story_v_out_410082", "410082106", "story_v_out_410082.awb")
				end

				arg_433_1:RecordContent(arg_433_1.text_.text)
			end

			local var_436_25 = math.max(var_436_16, arg_433_1.talkMaxDuration)

			if var_436_15 <= arg_433_1.time_ and arg_433_1.time_ < var_436_15 + var_436_25 then
				arg_433_1.typewritter.percent = (arg_433_1.time_ - var_436_15) / var_436_25

				arg_433_1.typewritter:SetDirty()
			end

			if arg_433_1.time_ >= var_436_15 + var_436_25 and arg_433_1.time_ < var_436_15 + var_436_25 + arg_436_0 then
				arg_433_1.typewritter.percent = 1

				arg_433_1.typewritter:SetDirty()
				arg_433_1:ShowNextGo(true)
			end
		end

		arg_433_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1012",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_433_1:InitPlayNodeList()
	end,
	Play410082107 = function(arg_437_0, arg_437_1)
		arg_437_1.time_ = 0
		arg_437_1.frameCnt_ = 0
		arg_437_1.state_ = "playing"
		arg_437_1.curTalkId_ = 410082107
		arg_437_1.duration_ = 2.33

		local var_437_0 = {
			zh = 2.066,
			ja = 2.333
		}
		local var_437_1 = manager.audio:GetLocalizationFlag()

		if var_437_0[var_437_1] ~= nil then
			arg_437_1.duration_ = var_437_0[var_437_1]
		end

		SetActive(arg_437_1.tipsGo_, false)

		function arg_437_1.onSingleLineFinish_()
			arg_437_1.onSingleLineUpdate_ = nil
			arg_437_1.onSingleLineFinish_ = nil
			arg_437_1.state_ = "waiting"
			arg_437_1.auto_ = false
		end

		function arg_437_1.playNext_(arg_439_0)
			arg_437_1.onStoryFinished_()
		end

		function arg_437_1.onSingleLineUpdate_(arg_440_0)
			local var_440_0 = 0
			local var_440_1 = 0.125

			if var_440_0 < arg_437_1.time_ and arg_437_1.time_ <= var_440_0 + arg_440_0 then
				arg_437_1.talkMaxDuration = 0
				arg_437_1.dialogCg_.alpha = 1

				arg_437_1.dialog_:SetActive(true)
				SetActive(arg_437_1.leftNameGo_, true)

				local var_440_2 = arg_437_1:FormatText(StoryNameCfg[595].name)

				arg_437_1.leftNameTxt_.text = var_440_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_437_1.leftNameTxt_.transform)

				arg_437_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_437_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_437_1:RecordName(arg_437_1.leftNameTxt_.text)
				SetActive(arg_437_1.iconTrs_.gameObject, false)
				arg_437_1.callingController_:SetSelectedState("normal")

				local var_440_3 = arg_437_1:GetWordFromCfg(410082107)
				local var_440_4 = arg_437_1:FormatText(var_440_3.content)

				arg_437_1.text_.text = var_440_4

				LuaForUtil.ClearLinePrefixSymbol(arg_437_1.text_)

				local var_440_5 = 5
				local var_440_6 = utf8.len(var_440_4)
				local var_440_7 = var_440_5 <= 0 and var_440_1 or var_440_1 * (var_440_6 / var_440_5)

				if var_440_7 > 0 and var_440_1 < var_440_7 then
					arg_437_1.talkMaxDuration = var_440_7

					if var_440_7 + var_440_0 > arg_437_1.duration_ then
						arg_437_1.duration_ = var_440_7 + var_440_0
					end
				end

				arg_437_1.text_.text = var_440_4
				arg_437_1.typewritter.percent = 0

				arg_437_1.typewritter:SetDirty()
				arg_437_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_410082", "410082107", "story_v_out_410082.awb") ~= 0 then
					local var_440_8 = manager.audio:GetVoiceLength("story_v_out_410082", "410082107", "story_v_out_410082.awb") / 1000

					if var_440_8 + var_440_0 > arg_437_1.duration_ then
						arg_437_1.duration_ = var_440_8 + var_440_0
					end

					if var_440_3.prefab_name ~= "" and arg_437_1.actors_[var_440_3.prefab_name] ~= nil then
						local var_440_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_437_1.actors_[var_440_3.prefab_name].transform, "story_v_out_410082", "410082107", "story_v_out_410082.awb")

						arg_437_1:RecordAudio("410082107", var_440_9)
						arg_437_1:RecordAudio("410082107", var_440_9)
					else
						arg_437_1:AudioAction("play", "voice", "story_v_out_410082", "410082107", "story_v_out_410082.awb")
					end

					arg_437_1:RecordHistoryTalkVoice("story_v_out_410082", "410082107", "story_v_out_410082.awb")
				end

				arg_437_1:RecordContent(arg_437_1.text_.text)
			end

			local var_440_10 = math.max(var_440_1, arg_437_1.talkMaxDuration)

			if var_440_0 <= arg_437_1.time_ and arg_437_1.time_ < var_440_0 + var_440_10 then
				arg_437_1.typewritter.percent = (arg_437_1.time_ - var_440_0) / var_440_10

				arg_437_1.typewritter:SetDirty()
			end

			if arg_437_1.time_ >= var_440_0 + var_440_10 and arg_437_1.time_ < var_440_0 + var_440_10 + arg_440_0 then
				arg_437_1.typewritter.percent = 1

				arg_437_1.typewritter:SetDirty()
				arg_437_1:ShowNextGo(true)
			end
		end

		arg_437_1.nodeConfigList_ = {}

		arg_437_1:InitPlayNodeList()
	end,
	assets = {
		"TextureConfig/Background/L01f",
		"TextureConfig/Background/ST61"
	},
	voices = {
		"story_v_out_410082.awb"
	}
}
