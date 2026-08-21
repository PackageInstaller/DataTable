return {
	Play410251001 = function(arg_1_0, arg_1_1)
		arg_1_1.time_ = 0
		arg_1_1.frameCnt_ = 0
		arg_1_1.state_ = "playing"
		arg_1_1.curTalkId_ = 410251001
		arg_1_1.duration_ = 6.27

		local var_1_0 = {
			ja = 6.266,
			CriLanguages = 4.5,
			zh = 4.5
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
				arg_1_0:Play410251002(arg_1_1)
			end
		end

		function arg_1_1.onSingleLineUpdate_(arg_4_0)
			local var_4_0 = "ST62"

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
				local var_4_5 = arg_1_1.bgs_.ST62

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
					if iter_4_0 ~= "ST62" then
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

			local var_4_22 = "1056"

			if arg_1_1.actors_[var_4_22] == nil then
				local var_4_23 = Asset.Load("Widget/System/Story/StoryExpression/" .. "1056")

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

			local var_4_26 = arg_1_1.actors_["1056"].transform
			local var_4_27 = 2

			if var_4_27 < arg_1_1.time_ and arg_1_1.time_ <= var_4_27 + arg_4_0 then
				arg_1_1.var_.moveOldPos1056 = var_4_26.localPosition
				var_4_26.localScale = Vector3.New(1, 1, 1)

				arg_1_1:CheckSpriteTmpPos("1056", 2)

				local var_4_28 = var_4_26.childCount

				for iter_4_4 = 0, var_4_28 - 1 do
					local var_4_29 = var_4_26:GetChild(iter_4_4)

					if var_4_29.name == "split_2" or not string.find(var_4_29.name, "split") then
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

				var_4_26.localPosition = Vector3.Lerp(arg_1_1.var_.moveOldPos1056, var_4_32, var_4_31)
			end

			if arg_1_1.time_ >= var_4_27 + var_4_30 and arg_1_1.time_ < var_4_27 + var_4_30 + arg_4_0 then
				var_4_26.localPosition = Vector3.New(-390, -350, -180)
			end

			local var_4_33 = "1060"

			if arg_1_1.actors_[var_4_33] == nil then
				local var_4_34 = Asset.Load("Widget/System/Story/StoryExpression/" .. "1060")

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

			local var_4_37 = arg_1_1.actors_["1060"].transform
			local var_4_38 = 2

			if var_4_38 < arg_1_1.time_ and arg_1_1.time_ <= var_4_38 + arg_4_0 then
				arg_1_1.var_.moveOldPos1060 = var_4_37.localPosition
				var_4_37.localScale = Vector3.New(1, 1, 1)

				arg_1_1:CheckSpriteTmpPos("1060", 4)

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
				local var_4_43 = Vector3.New(420.9, -430.8, 6.9)

				var_4_37.localPosition = Vector3.Lerp(arg_1_1.var_.moveOldPos1060, var_4_43, var_4_42)
			end

			if arg_1_1.time_ >= var_4_38 + var_4_41 and arg_1_1.time_ < var_4_38 + var_4_41 + arg_4_0 then
				var_4_37.localPosition = Vector3.New(420.9, -430.8, 6.9)
			end

			local var_4_44 = arg_1_1.actors_["1056"]
			local var_4_45 = 2

			if var_4_45 < arg_1_1.time_ and arg_1_1.time_ <= var_4_45 + arg_4_0 and not isNil(var_4_44) and arg_1_1.var_.actorSpriteComps1056 == nil then
				arg_1_1.var_.actorSpriteComps1056 = var_4_44:GetComponentsInChildren(typeof(Image), true)
			end

			local var_4_46 = 0.034

			if var_4_45 <= arg_1_1.time_ and arg_1_1.time_ < var_4_45 + var_4_46 and not isNil(var_4_44) then
				local var_4_47 = (arg_1_1.time_ - var_4_45) / var_4_46

				if arg_1_1.var_.actorSpriteComps1056 then
					for iter_4_8, iter_4_9 in pairs(arg_1_1.var_.actorSpriteComps1056:ToTable()) do
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

			if arg_1_1.time_ >= var_4_45 + var_4_46 and arg_1_1.time_ < var_4_45 + var_4_46 + arg_4_0 and not isNil(var_4_44) and arg_1_1.var_.actorSpriteComps1056 then
				for iter_4_10, iter_4_11 in pairs(arg_1_1.var_.actorSpriteComps1056:ToTable()) do
					if iter_4_11 then
						if arg_1_1.isInRecall_ then
							iter_4_11.color = arg_1_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_4_11.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_1_1.var_.actorSpriteComps1056 = nil
			end

			local var_4_52 = arg_1_1.actors_["1060"]
			local var_4_53 = 2

			if var_4_53 < arg_1_1.time_ and arg_1_1.time_ <= var_4_53 + arg_4_0 and not isNil(var_4_52) and arg_1_1.var_.actorSpriteComps1060 == nil then
				arg_1_1.var_.actorSpriteComps1060 = var_4_52:GetComponentsInChildren(typeof(Image), true)
			end

			local var_4_54 = 0.034

			if var_4_53 <= arg_1_1.time_ and arg_1_1.time_ < var_4_53 + var_4_54 and not isNil(var_4_52) then
				local var_4_55 = (arg_1_1.time_ - var_4_53) / var_4_54

				if arg_1_1.var_.actorSpriteComps1060 then
					for iter_4_12, iter_4_13 in pairs(arg_1_1.var_.actorSpriteComps1060:ToTable()) do
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

			if arg_1_1.time_ >= var_4_53 + var_4_54 and arg_1_1.time_ < var_4_53 + var_4_54 + arg_4_0 and not isNil(var_4_52) and arg_1_1.var_.actorSpriteComps1060 then
				for iter_4_14, iter_4_15 in pairs(arg_1_1.var_.actorSpriteComps1060:ToTable()) do
					if iter_4_15 then
						if arg_1_1.isInRecall_ then
							iter_4_15.color = arg_1_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_4_15.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_1_1.var_.actorSpriteComps1060 = nil
			end

			local var_4_60 = 0
			local var_4_61 = 0.166666666666667

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

			local var_4_66 = 0.3
			local var_4_67 = 1

			if var_4_66 < arg_1_1.time_ and arg_1_1.time_ <= var_4_66 + arg_4_0 then
				local var_4_68 = "play"
				local var_4_69 = "music"

				arg_1_1:AudioAction(var_4_68, var_4_69, "bgm_activity_2_8_story_tara_building", "bgm_activity_2_8_story_tara_building", "bgm_activity_2_8_story_tara_building.awb")

				local var_4_70 = ""
				local var_4_71 = manager.audio:GetAudioName("bgm_activity_2_8_story_tara_building", "bgm_activity_2_8_story_tara_building")

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
			local var_4_73 = 0.25

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

				local var_4_75 = arg_1_1:FormatText(StoryNameCfg[605].name)

				arg_1_1.leftNameTxt_.text = var_4_75

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_1_1.leftNameTxt_.transform)

				arg_1_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_1_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_1_1:RecordName(arg_1_1.leftNameTxt_.text)
				SetActive(arg_1_1.iconTrs_.gameObject, false)
				arg_1_1.callingController_:SetSelectedState("normal")

				local var_4_76 = arg_1_1:GetWordFromCfg(410251001)
				local var_4_77 = arg_1_1:FormatText(var_4_76.content)

				arg_1_1.text_.text = var_4_77

				LuaForUtil.ClearLinePrefixSymbol(arg_1_1.text_)

				local var_4_78 = 10
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

				if manager.audio:GetVoiceLength("story_v_out_410251", "410251001", "story_v_out_410251.awb") ~= 0 then
					local var_4_81 = manager.audio:GetVoiceLength("story_v_out_410251", "410251001", "story_v_out_410251.awb") / 1000

					if var_4_81 + var_4_72 > arg_1_1.duration_ then
						arg_1_1.duration_ = var_4_81 + var_4_72
					end

					if var_4_76.prefab_name ~= "" and arg_1_1.actors_[var_4_76.prefab_name] ~= nil then
						local var_4_82 = LuaForUtil.PlayVoiceWithCriLipsync(arg_1_1.actors_[var_4_76.prefab_name].transform, "story_v_out_410251", "410251001", "story_v_out_410251.awb")

						arg_1_1:RecordAudio("410251001", var_4_82)
						arg_1_1:RecordAudio("410251001", var_4_82)
					else
						arg_1_1:AudioAction("play", "voice", "story_v_out_410251", "410251001", "story_v_out_410251.awb")
					end

					arg_1_1:RecordHistoryTalkVoice("story_v_out_410251", "410251001", "story_v_out_410251.awb")
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
				actorName = "1060",
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
	Play410251002 = function(arg_9_0, arg_9_1)
		arg_9_1.time_ = 0
		arg_9_1.frameCnt_ = 0
		arg_9_1.state_ = "playing"
		arg_9_1.curTalkId_ = 410251002
		arg_9_1.duration_ = 5.93

		local var_9_0 = {
			ja = 5.933,
			CriLanguages = 3,
			zh = 3
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
				arg_9_0:Play410251003(arg_9_1)
			end
		end

		function arg_9_1.onSingleLineUpdate_(arg_12_0)
			local var_12_0 = arg_9_1.actors_["1060"].transform
			local var_12_1 = 0

			if var_12_1 < arg_9_1.time_ and arg_9_1.time_ <= var_12_1 + arg_12_0 then
				arg_9_1.var_.moveOldPos1060 = var_12_0.localPosition
				var_12_0.localScale = Vector3.New(1, 1, 1)

				arg_9_1:CheckSpriteTmpPos("1060", 4)

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
				local var_12_6 = Vector3.New(420.9, -430.8, 6.9)

				var_12_0.localPosition = Vector3.Lerp(arg_9_1.var_.moveOldPos1060, var_12_6, var_12_5)
			end

			if arg_9_1.time_ >= var_12_1 + var_12_4 and arg_9_1.time_ < var_12_1 + var_12_4 + arg_12_0 then
				var_12_0.localPosition = Vector3.New(420.9, -430.8, 6.9)
			end

			local var_12_7 = arg_9_1.actors_["1060"]
			local var_12_8 = 0

			if var_12_8 < arg_9_1.time_ and arg_9_1.time_ <= var_12_8 + arg_12_0 and not isNil(var_12_7) and arg_9_1.var_.actorSpriteComps1060 == nil then
				arg_9_1.var_.actorSpriteComps1060 = var_12_7:GetComponentsInChildren(typeof(Image), true)
			end

			local var_12_9 = 0.034

			if var_12_8 <= arg_9_1.time_ and arg_9_1.time_ < var_12_8 + var_12_9 and not isNil(var_12_7) then
				local var_12_10 = (arg_9_1.time_ - var_12_8) / var_12_9

				if arg_9_1.var_.actorSpriteComps1060 then
					for iter_12_1, iter_12_2 in pairs(arg_9_1.var_.actorSpriteComps1060:ToTable()) do
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

			if arg_9_1.time_ >= var_12_8 + var_12_9 and arg_9_1.time_ < var_12_8 + var_12_9 + arg_12_0 and not isNil(var_12_7) and arg_9_1.var_.actorSpriteComps1060 then
				for iter_12_3, iter_12_4 in pairs(arg_9_1.var_.actorSpriteComps1060:ToTable()) do
					if iter_12_4 then
						if arg_9_1.isInRecall_ then
							iter_12_4.color = arg_9_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_12_4.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_9_1.var_.actorSpriteComps1060 = nil
			end

			local var_12_15 = arg_9_1.actors_["1056"]
			local var_12_16 = 0

			if var_12_16 < arg_9_1.time_ and arg_9_1.time_ <= var_12_16 + arg_12_0 and not isNil(var_12_15) and arg_9_1.var_.actorSpriteComps1056 == nil then
				arg_9_1.var_.actorSpriteComps1056 = var_12_15:GetComponentsInChildren(typeof(Image), true)
			end

			local var_12_17 = 0.034

			if var_12_16 <= arg_9_1.time_ and arg_9_1.time_ < var_12_16 + var_12_17 and not isNil(var_12_15) then
				local var_12_18 = (arg_9_1.time_ - var_12_16) / var_12_17

				if arg_9_1.var_.actorSpriteComps1056 then
					for iter_12_5, iter_12_6 in pairs(arg_9_1.var_.actorSpriteComps1056:ToTable()) do
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

			if arg_9_1.time_ >= var_12_16 + var_12_17 and arg_9_1.time_ < var_12_16 + var_12_17 + arg_12_0 and not isNil(var_12_15) and arg_9_1.var_.actorSpriteComps1056 then
				for iter_12_7, iter_12_8 in pairs(arg_9_1.var_.actorSpriteComps1056:ToTable()) do
					if iter_12_8 then
						if arg_9_1.isInRecall_ then
							iter_12_8.color = arg_9_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_12_8.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_9_1.var_.actorSpriteComps1056 = nil
			end

			local var_12_23 = 0
			local var_12_24 = 0.375

			if var_12_23 < arg_9_1.time_ and arg_9_1.time_ <= var_12_23 + arg_12_0 then
				arg_9_1.talkMaxDuration = 0
				arg_9_1.dialogCg_.alpha = 1

				arg_9_1.dialog_:SetActive(true)
				SetActive(arg_9_1.leftNameGo_, true)

				local var_12_25 = arg_9_1:FormatText(StoryNameCfg[584].name)

				arg_9_1.leftNameTxt_.text = var_12_25

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_9_1.leftNameTxt_.transform)

				arg_9_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_9_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_9_1:RecordName(arg_9_1.leftNameTxt_.text)
				SetActive(arg_9_1.iconTrs_.gameObject, false)
				arg_9_1.callingController_:SetSelectedState("normal")

				local var_12_26 = arg_9_1:GetWordFromCfg(410251002)
				local var_12_27 = arg_9_1:FormatText(var_12_26.content)

				arg_9_1.text_.text = var_12_27

				LuaForUtil.ClearLinePrefixSymbol(arg_9_1.text_)

				local var_12_28 = 15
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

				if manager.audio:GetVoiceLength("story_v_out_410251", "410251002", "story_v_out_410251.awb") ~= 0 then
					local var_12_31 = manager.audio:GetVoiceLength("story_v_out_410251", "410251002", "story_v_out_410251.awb") / 1000

					if var_12_31 + var_12_23 > arg_9_1.duration_ then
						arg_9_1.duration_ = var_12_31 + var_12_23
					end

					if var_12_26.prefab_name ~= "" and arg_9_1.actors_[var_12_26.prefab_name] ~= nil then
						local var_12_32 = LuaForUtil.PlayVoiceWithCriLipsync(arg_9_1.actors_[var_12_26.prefab_name].transform, "story_v_out_410251", "410251002", "story_v_out_410251.awb")

						arg_9_1:RecordAudio("410251002", var_12_32)
						arg_9_1:RecordAudio("410251002", var_12_32)
					else
						arg_9_1:AudioAction("play", "voice", "story_v_out_410251", "410251002", "story_v_out_410251.awb")
					end

					arg_9_1:RecordHistoryTalkVoice("story_v_out_410251", "410251002", "story_v_out_410251.awb")
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
				actorName = "1060",
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
	Play410251003 = function(arg_13_0, arg_13_1)
		arg_13_1.time_ = 0
		arg_13_1.frameCnt_ = 0
		arg_13_1.state_ = "playing"
		arg_13_1.curTalkId_ = 410251003
		arg_13_1.duration_ = 5

		SetActive(arg_13_1.tipsGo_, false)

		function arg_13_1.onSingleLineFinish_()
			arg_13_1.onSingleLineUpdate_ = nil
			arg_13_1.onSingleLineFinish_ = nil
			arg_13_1.state_ = "waiting"
		end

		function arg_13_1.playNext_(arg_15_0)
			if arg_15_0 == 1 then
				arg_13_0:Play410251004(arg_13_1)
			end
		end

		function arg_13_1.onSingleLineUpdate_(arg_16_0)
			local var_16_0 = arg_13_1.actors_["1060"]
			local var_16_1 = 0

			if var_16_1 < arg_13_1.time_ and arg_13_1.time_ <= var_16_1 + arg_16_0 and not isNil(var_16_0) and arg_13_1.var_.actorSpriteComps1060 == nil then
				arg_13_1.var_.actorSpriteComps1060 = var_16_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_16_2 = 0.034

			if var_16_1 <= arg_13_1.time_ and arg_13_1.time_ < var_16_1 + var_16_2 and not isNil(var_16_0) then
				local var_16_3 = (arg_13_1.time_ - var_16_1) / var_16_2

				if arg_13_1.var_.actorSpriteComps1060 then
					for iter_16_0, iter_16_1 in pairs(arg_13_1.var_.actorSpriteComps1060:ToTable()) do
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

			if arg_13_1.time_ >= var_16_1 + var_16_2 and arg_13_1.time_ < var_16_1 + var_16_2 + arg_16_0 and not isNil(var_16_0) and arg_13_1.var_.actorSpriteComps1060 then
				for iter_16_2, iter_16_3 in pairs(arg_13_1.var_.actorSpriteComps1060:ToTable()) do
					if iter_16_3 then
						if arg_13_1.isInRecall_ then
							iter_16_3.color = arg_13_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_16_3.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_13_1.var_.actorSpriteComps1060 = nil
			end

			local var_16_8 = 0
			local var_16_9 = 1.375

			if var_16_8 < arg_13_1.time_ and arg_13_1.time_ <= var_16_8 + arg_16_0 then
				arg_13_1.talkMaxDuration = 0
				arg_13_1.dialogCg_.alpha = 1

				arg_13_1.dialog_:SetActive(true)
				SetActive(arg_13_1.leftNameGo_, false)

				arg_13_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_13_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_13_1:RecordName(arg_13_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_13_1.iconTrs_.gameObject, false)
				arg_13_1.callingController_:SetSelectedState("normal")

				local var_16_10 = arg_13_1:GetWordFromCfg(410251003)
				local var_16_11 = arg_13_1:FormatText(var_16_10.content)

				arg_13_1.text_.text = var_16_11

				LuaForUtil.ClearLinePrefixSymbol(arg_13_1.text_)

				local var_16_12 = 55
				local var_16_13 = utf8.len(var_16_11)
				local var_16_14 = var_16_12 <= 0 and var_16_9 or var_16_9 * (var_16_13 / var_16_12)

				if var_16_14 > 0 and var_16_9 < var_16_14 then
					arg_13_1.talkMaxDuration = var_16_14

					if var_16_14 + var_16_8 > arg_13_1.duration_ then
						arg_13_1.duration_ = var_16_14 + var_16_8
					end
				end

				arg_13_1.text_.text = var_16_11
				arg_13_1.typewritter.percent = 0

				arg_13_1.typewritter:SetDirty()
				arg_13_1:ShowNextGo(false)
				arg_13_1:RecordContent(arg_13_1.text_.text)
			end

			local var_16_15 = math.max(var_16_9, arg_13_1.talkMaxDuration)

			if var_16_8 <= arg_13_1.time_ and arg_13_1.time_ < var_16_8 + var_16_15 then
				arg_13_1.typewritter.percent = (arg_13_1.time_ - var_16_8) / var_16_15

				arg_13_1.typewritter:SetDirty()
			end

			if arg_13_1.time_ >= var_16_8 + var_16_15 and arg_13_1.time_ < var_16_8 + var_16_15 + arg_16_0 then
				arg_13_1.typewritter.percent = 1

				arg_13_1.typewritter:SetDirty()
				arg_13_1:ShowNextGo(true)
			end
		end

		arg_13_1.nodeConfigList_ = {}

		arg_13_1:InitPlayNodeList()
	end,
	Play410251004 = function(arg_17_0, arg_17_1)
		arg_17_1.time_ = 0
		arg_17_1.frameCnt_ = 0
		arg_17_1.state_ = "playing"
		arg_17_1.curTalkId_ = 410251004
		arg_17_1.duration_ = 7.9

		local var_17_0 = {
			ja = 7.9,
			CriLanguages = 7,
			zh = 7
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
				arg_17_0:Play410251005(arg_17_1)
			end
		end

		function arg_17_1.onSingleLineUpdate_(arg_20_0)
			local var_20_0 = arg_17_1.actors_["1056"].transform
			local var_20_1 = 0

			if var_20_1 < arg_17_1.time_ and arg_17_1.time_ <= var_20_1 + arg_20_0 then
				arg_17_1.var_.moveOldPos1056 = var_20_0.localPosition
				var_20_0.localScale = Vector3.New(1, 1, 1)

				arg_17_1:CheckSpriteTmpPos("1056", 2)

				local var_20_2 = var_20_0.childCount

				for iter_20_0 = 0, var_20_2 - 1 do
					local var_20_3 = var_20_0:GetChild(iter_20_0)

					if var_20_3.name == "" or not string.find(var_20_3.name, "split") then
						var_20_3.gameObject:SetActive(true)
					else
						var_20_3.gameObject:SetActive(false)
					end
				end
			end

			local var_20_4 = 0.001

			if var_20_1 <= arg_17_1.time_ and arg_17_1.time_ < var_20_1 + var_20_4 then
				local var_20_5 = (arg_17_1.time_ - var_20_1) / var_20_4
				local var_20_6 = Vector3.New(-390, -350, -180)

				var_20_0.localPosition = Vector3.Lerp(arg_17_1.var_.moveOldPos1056, var_20_6, var_20_5)
			end

			if arg_17_1.time_ >= var_20_1 + var_20_4 and arg_17_1.time_ < var_20_1 + var_20_4 + arg_20_0 then
				var_20_0.localPosition = Vector3.New(-390, -350, -180)
			end

			local var_20_7 = arg_17_1.actors_["1056"]
			local var_20_8 = 0

			if var_20_8 < arg_17_1.time_ and arg_17_1.time_ <= var_20_8 + arg_20_0 and not isNil(var_20_7) and arg_17_1.var_.actorSpriteComps1056 == nil then
				arg_17_1.var_.actorSpriteComps1056 = var_20_7:GetComponentsInChildren(typeof(Image), true)
			end

			local var_20_9 = 0.034

			if var_20_8 <= arg_17_1.time_ and arg_17_1.time_ < var_20_8 + var_20_9 and not isNil(var_20_7) then
				local var_20_10 = (arg_17_1.time_ - var_20_8) / var_20_9

				if arg_17_1.var_.actorSpriteComps1056 then
					for iter_20_1, iter_20_2 in pairs(arg_17_1.var_.actorSpriteComps1056:ToTable()) do
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

			if arg_17_1.time_ >= var_20_8 + var_20_9 and arg_17_1.time_ < var_20_8 + var_20_9 + arg_20_0 and not isNil(var_20_7) and arg_17_1.var_.actorSpriteComps1056 then
				for iter_20_3, iter_20_4 in pairs(arg_17_1.var_.actorSpriteComps1056:ToTable()) do
					if iter_20_4 then
						if arg_17_1.isInRecall_ then
							iter_20_4.color = arg_17_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_20_4.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_17_1.var_.actorSpriteComps1056 = nil
			end

			local var_20_15 = 0
			local var_20_16 = 0.825

			if var_20_15 < arg_17_1.time_ and arg_17_1.time_ <= var_20_15 + arg_20_0 then
				arg_17_1.talkMaxDuration = 0
				arg_17_1.dialogCg_.alpha = 1

				arg_17_1.dialog_:SetActive(true)
				SetActive(arg_17_1.leftNameGo_, true)

				local var_20_17 = arg_17_1:FormatText(StoryNameCfg[605].name)

				arg_17_1.leftNameTxt_.text = var_20_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_17_1.leftNameTxt_.transform)

				arg_17_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_17_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_17_1:RecordName(arg_17_1.leftNameTxt_.text)
				SetActive(arg_17_1.iconTrs_.gameObject, false)
				arg_17_1.callingController_:SetSelectedState("normal")

				local var_20_18 = arg_17_1:GetWordFromCfg(410251004)
				local var_20_19 = arg_17_1:FormatText(var_20_18.content)

				arg_17_1.text_.text = var_20_19

				LuaForUtil.ClearLinePrefixSymbol(arg_17_1.text_)

				local var_20_20 = 33
				local var_20_21 = utf8.len(var_20_19)
				local var_20_22 = var_20_20 <= 0 and var_20_16 or var_20_16 * (var_20_21 / var_20_20)

				if var_20_22 > 0 and var_20_16 < var_20_22 then
					arg_17_1.talkMaxDuration = var_20_22

					if var_20_22 + var_20_15 > arg_17_1.duration_ then
						arg_17_1.duration_ = var_20_22 + var_20_15
					end
				end

				arg_17_1.text_.text = var_20_19
				arg_17_1.typewritter.percent = 0

				arg_17_1.typewritter:SetDirty()
				arg_17_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_410251", "410251004", "story_v_out_410251.awb") ~= 0 then
					local var_20_23 = manager.audio:GetVoiceLength("story_v_out_410251", "410251004", "story_v_out_410251.awb") / 1000

					if var_20_23 + var_20_15 > arg_17_1.duration_ then
						arg_17_1.duration_ = var_20_23 + var_20_15
					end

					if var_20_18.prefab_name ~= "" and arg_17_1.actors_[var_20_18.prefab_name] ~= nil then
						local var_20_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_17_1.actors_[var_20_18.prefab_name].transform, "story_v_out_410251", "410251004", "story_v_out_410251.awb")

						arg_17_1:RecordAudio("410251004", var_20_24)
						arg_17_1:RecordAudio("410251004", var_20_24)
					else
						arg_17_1:AudioAction("play", "voice", "story_v_out_410251", "410251004", "story_v_out_410251.awb")
					end

					arg_17_1:RecordHistoryTalkVoice("story_v_out_410251", "410251004", "story_v_out_410251.awb")
				end

				arg_17_1:RecordContent(arg_17_1.text_.text)
			end

			local var_20_25 = math.max(var_20_16, arg_17_1.talkMaxDuration)

			if var_20_15 <= arg_17_1.time_ and arg_17_1.time_ < var_20_15 + var_20_25 then
				arg_17_1.typewritter.percent = (arg_17_1.time_ - var_20_15) / var_20_25

				arg_17_1.typewritter:SetDirty()
			end

			if arg_17_1.time_ >= var_20_15 + var_20_25 and arg_17_1.time_ < var_20_15 + var_20_25 + arg_20_0 then
				arg_17_1.typewritter.percent = 1

				arg_17_1.typewritter:SetDirty()
				arg_17_1:ShowNextGo(true)
			end
		end

		arg_17_1.nodeConfigList_ = {
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

		arg_17_1:InitPlayNodeList()
	end,
	Play410251005 = function(arg_21_0, arg_21_1)
		arg_21_1.time_ = 0
		arg_21_1.frameCnt_ = 0
		arg_21_1.state_ = "playing"
		arg_21_1.curTalkId_ = 410251005
		arg_21_1.duration_ = 14.73

		local var_21_0 = {
			ja = 14.733,
			CriLanguages = 10.2,
			zh = 10.2
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
				arg_21_0:Play410251006(arg_21_1)
			end
		end

		function arg_21_1.onSingleLineUpdate_(arg_24_0)
			local var_24_0 = 0
			local var_24_1 = 1.4

			if var_24_0 < arg_21_1.time_ and arg_21_1.time_ <= var_24_0 + arg_24_0 then
				arg_21_1.talkMaxDuration = 0
				arg_21_1.dialogCg_.alpha = 1

				arg_21_1.dialog_:SetActive(true)
				SetActive(arg_21_1.leftNameGo_, true)

				local var_24_2 = arg_21_1:FormatText(StoryNameCfg[605].name)

				arg_21_1.leftNameTxt_.text = var_24_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_21_1.leftNameTxt_.transform)

				arg_21_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_21_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_21_1:RecordName(arg_21_1.leftNameTxt_.text)
				SetActive(arg_21_1.iconTrs_.gameObject, false)
				arg_21_1.callingController_:SetSelectedState("normal")

				local var_24_3 = arg_21_1:GetWordFromCfg(410251005)
				local var_24_4 = arg_21_1:FormatText(var_24_3.content)

				arg_21_1.text_.text = var_24_4

				LuaForUtil.ClearLinePrefixSymbol(arg_21_1.text_)

				local var_24_5 = 56
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

				if manager.audio:GetVoiceLength("story_v_out_410251", "410251005", "story_v_out_410251.awb") ~= 0 then
					local var_24_8 = manager.audio:GetVoiceLength("story_v_out_410251", "410251005", "story_v_out_410251.awb") / 1000

					if var_24_8 + var_24_0 > arg_21_1.duration_ then
						arg_21_1.duration_ = var_24_8 + var_24_0
					end

					if var_24_3.prefab_name ~= "" and arg_21_1.actors_[var_24_3.prefab_name] ~= nil then
						local var_24_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_21_1.actors_[var_24_3.prefab_name].transform, "story_v_out_410251", "410251005", "story_v_out_410251.awb")

						arg_21_1:RecordAudio("410251005", var_24_9)
						arg_21_1:RecordAudio("410251005", var_24_9)
					else
						arg_21_1:AudioAction("play", "voice", "story_v_out_410251", "410251005", "story_v_out_410251.awb")
					end

					arg_21_1:RecordHistoryTalkVoice("story_v_out_410251", "410251005", "story_v_out_410251.awb")
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
	Play410251006 = function(arg_25_0, arg_25_1)
		arg_25_1.time_ = 0
		arg_25_1.frameCnt_ = 0
		arg_25_1.state_ = "playing"
		arg_25_1.curTalkId_ = 410251006
		arg_25_1.duration_ = 8.8

		local var_25_0 = {
			ja = 8.8,
			CriLanguages = 5.2,
			zh = 5.2
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
				arg_25_0:Play410251007(arg_25_1)
			end
		end

		function arg_25_1.onSingleLineUpdate_(arg_28_0)
			local var_28_0 = arg_25_1.actors_["1056"].transform
			local var_28_1 = 0

			if var_28_1 < arg_25_1.time_ and arg_25_1.time_ <= var_28_1 + arg_28_0 then
				arg_25_1.var_.moveOldPos1056 = var_28_0.localPosition
				var_28_0.localScale = Vector3.New(1, 1, 1)

				arg_25_1:CheckSpriteTmpPos("1056", 2)

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
				local var_28_6 = Vector3.New(-390, -350, -180)

				var_28_0.localPosition = Vector3.Lerp(arg_25_1.var_.moveOldPos1056, var_28_6, var_28_5)
			end

			if arg_25_1.time_ >= var_28_1 + var_28_4 and arg_25_1.time_ < var_28_1 + var_28_4 + arg_28_0 then
				var_28_0.localPosition = Vector3.New(-390, -350, -180)
			end

			local var_28_7 = arg_25_1.actors_["1056"]
			local var_28_8 = 0

			if var_28_8 < arg_25_1.time_ and arg_25_1.time_ <= var_28_8 + arg_28_0 and not isNil(var_28_7) and arg_25_1.var_.actorSpriteComps1056 == nil then
				arg_25_1.var_.actorSpriteComps1056 = var_28_7:GetComponentsInChildren(typeof(Image), true)
			end

			local var_28_9 = 0.034

			if var_28_8 <= arg_25_1.time_ and arg_25_1.time_ < var_28_8 + var_28_9 and not isNil(var_28_7) then
				local var_28_10 = (arg_25_1.time_ - var_28_8) / var_28_9

				if arg_25_1.var_.actorSpriteComps1056 then
					for iter_28_1, iter_28_2 in pairs(arg_25_1.var_.actorSpriteComps1056:ToTable()) do
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

			if arg_25_1.time_ >= var_28_8 + var_28_9 and arg_25_1.time_ < var_28_8 + var_28_9 + arg_28_0 and not isNil(var_28_7) and arg_25_1.var_.actorSpriteComps1056 then
				for iter_28_3, iter_28_4 in pairs(arg_25_1.var_.actorSpriteComps1056:ToTable()) do
					if iter_28_4 then
						if arg_25_1.isInRecall_ then
							iter_28_4.color = arg_25_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_28_4.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_25_1.var_.actorSpriteComps1056 = nil
			end

			local var_28_15 = 0
			local var_28_16 = 0.675

			if var_28_15 < arg_25_1.time_ and arg_25_1.time_ <= var_28_15 + arg_28_0 then
				arg_25_1.talkMaxDuration = 0
				arg_25_1.dialogCg_.alpha = 1

				arg_25_1.dialog_:SetActive(true)
				SetActive(arg_25_1.leftNameGo_, true)

				local var_28_17 = arg_25_1:FormatText(StoryNameCfg[605].name)

				arg_25_1.leftNameTxt_.text = var_28_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_25_1.leftNameTxt_.transform)

				arg_25_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_25_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_25_1:RecordName(arg_25_1.leftNameTxt_.text)
				SetActive(arg_25_1.iconTrs_.gameObject, false)
				arg_25_1.callingController_:SetSelectedState("normal")

				local var_28_18 = arg_25_1:GetWordFromCfg(410251006)
				local var_28_19 = arg_25_1:FormatText(var_28_18.content)

				arg_25_1.text_.text = var_28_19

				LuaForUtil.ClearLinePrefixSymbol(arg_25_1.text_)

				local var_28_20 = 27
				local var_28_21 = utf8.len(var_28_19)
				local var_28_22 = var_28_20 <= 0 and var_28_16 or var_28_16 * (var_28_21 / var_28_20)

				if var_28_22 > 0 and var_28_16 < var_28_22 then
					arg_25_1.talkMaxDuration = var_28_22

					if var_28_22 + var_28_15 > arg_25_1.duration_ then
						arg_25_1.duration_ = var_28_22 + var_28_15
					end
				end

				arg_25_1.text_.text = var_28_19
				arg_25_1.typewritter.percent = 0

				arg_25_1.typewritter:SetDirty()
				arg_25_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_410251", "410251006", "story_v_out_410251.awb") ~= 0 then
					local var_28_23 = manager.audio:GetVoiceLength("story_v_out_410251", "410251006", "story_v_out_410251.awb") / 1000

					if var_28_23 + var_28_15 > arg_25_1.duration_ then
						arg_25_1.duration_ = var_28_23 + var_28_15
					end

					if var_28_18.prefab_name ~= "" and arg_25_1.actors_[var_28_18.prefab_name] ~= nil then
						local var_28_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_25_1.actors_[var_28_18.prefab_name].transform, "story_v_out_410251", "410251006", "story_v_out_410251.awb")

						arg_25_1:RecordAudio("410251006", var_28_24)
						arg_25_1:RecordAudio("410251006", var_28_24)
					else
						arg_25_1:AudioAction("play", "voice", "story_v_out_410251", "410251006", "story_v_out_410251.awb")
					end

					arg_25_1:RecordHistoryTalkVoice("story_v_out_410251", "410251006", "story_v_out_410251.awb")
				end

				arg_25_1:RecordContent(arg_25_1.text_.text)
			end

			local var_28_25 = math.max(var_28_16, arg_25_1.talkMaxDuration)

			if var_28_15 <= arg_25_1.time_ and arg_25_1.time_ < var_28_15 + var_28_25 then
				arg_25_1.typewritter.percent = (arg_25_1.time_ - var_28_15) / var_28_25

				arg_25_1.typewritter:SetDirty()
			end

			if arg_25_1.time_ >= var_28_15 + var_28_25 and arg_25_1.time_ < var_28_15 + var_28_25 + arg_28_0 then
				arg_25_1.typewritter.percent = 1

				arg_25_1.typewritter:SetDirty()
				arg_25_1:ShowNextGo(true)
			end
		end

		arg_25_1.nodeConfigList_ = {
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

		arg_25_1:InitPlayNodeList()
	end,
	Play410251007 = function(arg_29_0, arg_29_1)
		arg_29_1.time_ = 0
		arg_29_1.frameCnt_ = 0
		arg_29_1.state_ = "playing"
		arg_29_1.curTalkId_ = 410251007
		arg_29_1.duration_ = 15.27

		local var_29_0 = {
			ja = 15.266,
			CriLanguages = 7.866,
			zh = 7.866
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
				arg_29_0:Play410251008(arg_29_1)
			end
		end

		function arg_29_1.onSingleLineUpdate_(arg_32_0)
			local var_32_0 = arg_29_1.actors_["1060"].transform
			local var_32_1 = 0

			if var_32_1 < arg_29_1.time_ and arg_29_1.time_ <= var_32_1 + arg_32_0 then
				arg_29_1.var_.moveOldPos1060 = var_32_0.localPosition
				var_32_0.localScale = Vector3.New(1, 1, 1)

				arg_29_1:CheckSpriteTmpPos("1060", 4)

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
				local var_32_6 = Vector3.New(420.9, -430.8, 6.9)

				var_32_0.localPosition = Vector3.Lerp(arg_29_1.var_.moveOldPos1060, var_32_6, var_32_5)
			end

			if arg_29_1.time_ >= var_32_1 + var_32_4 and arg_29_1.time_ < var_32_1 + var_32_4 + arg_32_0 then
				var_32_0.localPosition = Vector3.New(420.9, -430.8, 6.9)
			end

			local var_32_7 = arg_29_1.actors_["1060"]
			local var_32_8 = 0

			if var_32_8 < arg_29_1.time_ and arg_29_1.time_ <= var_32_8 + arg_32_0 and not isNil(var_32_7) and arg_29_1.var_.actorSpriteComps1060 == nil then
				arg_29_1.var_.actorSpriteComps1060 = var_32_7:GetComponentsInChildren(typeof(Image), true)
			end

			local var_32_9 = 0.034

			if var_32_8 <= arg_29_1.time_ and arg_29_1.time_ < var_32_8 + var_32_9 and not isNil(var_32_7) then
				local var_32_10 = (arg_29_1.time_ - var_32_8) / var_32_9

				if arg_29_1.var_.actorSpriteComps1060 then
					for iter_32_1, iter_32_2 in pairs(arg_29_1.var_.actorSpriteComps1060:ToTable()) do
						if iter_32_2 then
							if arg_29_1.isInRecall_ then
								local var_32_11 = Mathf.Lerp(iter_32_2.color.r, arg_29_1.hightColor1.r, var_32_10)
								local var_32_12 = Mathf.Lerp(iter_32_2.color.g, arg_29_1.hightColor1.g, var_32_10)
								local var_32_13 = Mathf.Lerp(iter_32_2.color.b, arg_29_1.hightColor1.b, var_32_10)

								iter_32_2.color = Color.New(var_32_11, var_32_12, var_32_13)
							else
								local var_32_14 = Mathf.Lerp(iter_32_2.color.r, 1, var_32_10)

								iter_32_2.color = Color.New(var_32_14, var_32_14, var_32_14)
							end
						end
					end
				end
			end

			if arg_29_1.time_ >= var_32_8 + var_32_9 and arg_29_1.time_ < var_32_8 + var_32_9 + arg_32_0 and not isNil(var_32_7) and arg_29_1.var_.actorSpriteComps1060 then
				for iter_32_3, iter_32_4 in pairs(arg_29_1.var_.actorSpriteComps1060:ToTable()) do
					if iter_32_4 then
						if arg_29_1.isInRecall_ then
							iter_32_4.color = arg_29_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_32_4.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_29_1.var_.actorSpriteComps1060 = nil
			end

			local var_32_15 = arg_29_1.actors_["1056"]
			local var_32_16 = 0

			if var_32_16 < arg_29_1.time_ and arg_29_1.time_ <= var_32_16 + arg_32_0 and not isNil(var_32_15) and arg_29_1.var_.actorSpriteComps1056 == nil then
				arg_29_1.var_.actorSpriteComps1056 = var_32_15:GetComponentsInChildren(typeof(Image), true)
			end

			local var_32_17 = 0.034

			if var_32_16 <= arg_29_1.time_ and arg_29_1.time_ < var_32_16 + var_32_17 and not isNil(var_32_15) then
				local var_32_18 = (arg_29_1.time_ - var_32_16) / var_32_17

				if arg_29_1.var_.actorSpriteComps1056 then
					for iter_32_5, iter_32_6 in pairs(arg_29_1.var_.actorSpriteComps1056:ToTable()) do
						if iter_32_6 then
							if arg_29_1.isInRecall_ then
								local var_32_19 = Mathf.Lerp(iter_32_6.color.r, arg_29_1.hightColor2.r, var_32_18)
								local var_32_20 = Mathf.Lerp(iter_32_6.color.g, arg_29_1.hightColor2.g, var_32_18)
								local var_32_21 = Mathf.Lerp(iter_32_6.color.b, arg_29_1.hightColor2.b, var_32_18)

								iter_32_6.color = Color.New(var_32_19, var_32_20, var_32_21)
							else
								local var_32_22 = Mathf.Lerp(iter_32_6.color.r, 0.5, var_32_18)

								iter_32_6.color = Color.New(var_32_22, var_32_22, var_32_22)
							end
						end
					end
				end
			end

			if arg_29_1.time_ >= var_32_16 + var_32_17 and arg_29_1.time_ < var_32_16 + var_32_17 + arg_32_0 and not isNil(var_32_15) and arg_29_1.var_.actorSpriteComps1056 then
				for iter_32_7, iter_32_8 in pairs(arg_29_1.var_.actorSpriteComps1056:ToTable()) do
					if iter_32_8 then
						if arg_29_1.isInRecall_ then
							iter_32_8.color = arg_29_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_32_8.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_29_1.var_.actorSpriteComps1056 = nil
			end

			local var_32_23 = 0
			local var_32_24 = 1.075

			if var_32_23 < arg_29_1.time_ and arg_29_1.time_ <= var_32_23 + arg_32_0 then
				arg_29_1.talkMaxDuration = 0
				arg_29_1.dialogCg_.alpha = 1

				arg_29_1.dialog_:SetActive(true)
				SetActive(arg_29_1.leftNameGo_, true)

				local var_32_25 = arg_29_1:FormatText(StoryNameCfg[584].name)

				arg_29_1.leftNameTxt_.text = var_32_25

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_29_1.leftNameTxt_.transform)

				arg_29_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_29_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_29_1:RecordName(arg_29_1.leftNameTxt_.text)
				SetActive(arg_29_1.iconTrs_.gameObject, false)
				arg_29_1.callingController_:SetSelectedState("normal")

				local var_32_26 = arg_29_1:GetWordFromCfg(410251007)
				local var_32_27 = arg_29_1:FormatText(var_32_26.content)

				arg_29_1.text_.text = var_32_27

				LuaForUtil.ClearLinePrefixSymbol(arg_29_1.text_)

				local var_32_28 = 43
				local var_32_29 = utf8.len(var_32_27)
				local var_32_30 = var_32_28 <= 0 and var_32_24 or var_32_24 * (var_32_29 / var_32_28)

				if var_32_30 > 0 and var_32_24 < var_32_30 then
					arg_29_1.talkMaxDuration = var_32_30

					if var_32_30 + var_32_23 > arg_29_1.duration_ then
						arg_29_1.duration_ = var_32_30 + var_32_23
					end
				end

				arg_29_1.text_.text = var_32_27
				arg_29_1.typewritter.percent = 0

				arg_29_1.typewritter:SetDirty()
				arg_29_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_410251", "410251007", "story_v_out_410251.awb") ~= 0 then
					local var_32_31 = manager.audio:GetVoiceLength("story_v_out_410251", "410251007", "story_v_out_410251.awb") / 1000

					if var_32_31 + var_32_23 > arg_29_1.duration_ then
						arg_29_1.duration_ = var_32_31 + var_32_23
					end

					if var_32_26.prefab_name ~= "" and arg_29_1.actors_[var_32_26.prefab_name] ~= nil then
						local var_32_32 = LuaForUtil.PlayVoiceWithCriLipsync(arg_29_1.actors_[var_32_26.prefab_name].transform, "story_v_out_410251", "410251007", "story_v_out_410251.awb")

						arg_29_1:RecordAudio("410251007", var_32_32)
						arg_29_1:RecordAudio("410251007", var_32_32)
					else
						arg_29_1:AudioAction("play", "voice", "story_v_out_410251", "410251007", "story_v_out_410251.awb")
					end

					arg_29_1:RecordHistoryTalkVoice("story_v_out_410251", "410251007", "story_v_out_410251.awb")
				end

				arg_29_1:RecordContent(arg_29_1.text_.text)
			end

			local var_32_33 = math.max(var_32_24, arg_29_1.talkMaxDuration)

			if var_32_23 <= arg_29_1.time_ and arg_29_1.time_ < var_32_23 + var_32_33 then
				arg_29_1.typewritter.percent = (arg_29_1.time_ - var_32_23) / var_32_33

				arg_29_1.typewritter:SetDirty()
			end

			if arg_29_1.time_ >= var_32_23 + var_32_33 and arg_29_1.time_ < var_32_23 + var_32_33 + arg_32_0 then
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
			}
		}

		arg_29_1:InitPlayNodeList()
	end,
	Play410251008 = function(arg_33_0, arg_33_1)
		arg_33_1.time_ = 0
		arg_33_1.frameCnt_ = 0
		arg_33_1.state_ = "playing"
		arg_33_1.curTalkId_ = 410251008
		arg_33_1.duration_ = 4.87

		local var_33_0 = {
			ja = 4.866,
			CriLanguages = 3.866,
			zh = 3.866
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
				arg_33_0:Play410251009(arg_33_1)
			end
		end

		function arg_33_1.onSingleLineUpdate_(arg_36_0)
			local var_36_0 = arg_33_1.actors_["1056"].transform
			local var_36_1 = 0

			if var_36_1 < arg_33_1.time_ and arg_33_1.time_ <= var_36_1 + arg_36_0 then
				arg_33_1.var_.moveOldPos1056 = var_36_0.localPosition
				var_36_0.localScale = Vector3.New(1, 1, 1)

				arg_33_1:CheckSpriteTmpPos("1056", 2)

				local var_36_2 = var_36_0.childCount

				for iter_36_0 = 0, var_36_2 - 1 do
					local var_36_3 = var_36_0:GetChild(iter_36_0)

					if var_36_3.name == "" or not string.find(var_36_3.name, "split") then
						var_36_3.gameObject:SetActive(true)
					else
						var_36_3.gameObject:SetActive(false)
					end
				end
			end

			local var_36_4 = 0.001

			if var_36_1 <= arg_33_1.time_ and arg_33_1.time_ < var_36_1 + var_36_4 then
				local var_36_5 = (arg_33_1.time_ - var_36_1) / var_36_4
				local var_36_6 = Vector3.New(-390, -350, -180)

				var_36_0.localPosition = Vector3.Lerp(arg_33_1.var_.moveOldPos1056, var_36_6, var_36_5)
			end

			if arg_33_1.time_ >= var_36_1 + var_36_4 and arg_33_1.time_ < var_36_1 + var_36_4 + arg_36_0 then
				var_36_0.localPosition = Vector3.New(-390, -350, -180)
			end

			local var_36_7 = arg_33_1.actors_["1056"]
			local var_36_8 = 0

			if var_36_8 < arg_33_1.time_ and arg_33_1.time_ <= var_36_8 + arg_36_0 and not isNil(var_36_7) and arg_33_1.var_.actorSpriteComps1056 == nil then
				arg_33_1.var_.actorSpriteComps1056 = var_36_7:GetComponentsInChildren(typeof(Image), true)
			end

			local var_36_9 = 0.034

			if var_36_8 <= arg_33_1.time_ and arg_33_1.time_ < var_36_8 + var_36_9 and not isNil(var_36_7) then
				local var_36_10 = (arg_33_1.time_ - var_36_8) / var_36_9

				if arg_33_1.var_.actorSpriteComps1056 then
					for iter_36_1, iter_36_2 in pairs(arg_33_1.var_.actorSpriteComps1056:ToTable()) do
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

			if arg_33_1.time_ >= var_36_8 + var_36_9 and arg_33_1.time_ < var_36_8 + var_36_9 + arg_36_0 and not isNil(var_36_7) and arg_33_1.var_.actorSpriteComps1056 then
				for iter_36_3, iter_36_4 in pairs(arg_33_1.var_.actorSpriteComps1056:ToTable()) do
					if iter_36_4 then
						if arg_33_1.isInRecall_ then
							iter_36_4.color = arg_33_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_36_4.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_33_1.var_.actorSpriteComps1056 = nil
			end

			local var_36_15 = arg_33_1.actors_["1060"]
			local var_36_16 = 0

			if var_36_16 < arg_33_1.time_ and arg_33_1.time_ <= var_36_16 + arg_36_0 and not isNil(var_36_15) and arg_33_1.var_.actorSpriteComps1060 == nil then
				arg_33_1.var_.actorSpriteComps1060 = var_36_15:GetComponentsInChildren(typeof(Image), true)
			end

			local var_36_17 = 0.034

			if var_36_16 <= arg_33_1.time_ and arg_33_1.time_ < var_36_16 + var_36_17 and not isNil(var_36_15) then
				local var_36_18 = (arg_33_1.time_ - var_36_16) / var_36_17

				if arg_33_1.var_.actorSpriteComps1060 then
					for iter_36_5, iter_36_6 in pairs(arg_33_1.var_.actorSpriteComps1060:ToTable()) do
						if iter_36_6 then
							if arg_33_1.isInRecall_ then
								local var_36_19 = Mathf.Lerp(iter_36_6.color.r, arg_33_1.hightColor2.r, var_36_18)
								local var_36_20 = Mathf.Lerp(iter_36_6.color.g, arg_33_1.hightColor2.g, var_36_18)
								local var_36_21 = Mathf.Lerp(iter_36_6.color.b, arg_33_1.hightColor2.b, var_36_18)

								iter_36_6.color = Color.New(var_36_19, var_36_20, var_36_21)
							else
								local var_36_22 = Mathf.Lerp(iter_36_6.color.r, 0.5, var_36_18)

								iter_36_6.color = Color.New(var_36_22, var_36_22, var_36_22)
							end
						end
					end
				end
			end

			if arg_33_1.time_ >= var_36_16 + var_36_17 and arg_33_1.time_ < var_36_16 + var_36_17 + arg_36_0 and not isNil(var_36_15) and arg_33_1.var_.actorSpriteComps1060 then
				for iter_36_7, iter_36_8 in pairs(arg_33_1.var_.actorSpriteComps1060:ToTable()) do
					if iter_36_8 then
						if arg_33_1.isInRecall_ then
							iter_36_8.color = arg_33_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_36_8.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_33_1.var_.actorSpriteComps1060 = nil
			end

			local var_36_23 = 0
			local var_36_24 = 0.5

			if var_36_23 < arg_33_1.time_ and arg_33_1.time_ <= var_36_23 + arg_36_0 then
				arg_33_1.talkMaxDuration = 0
				arg_33_1.dialogCg_.alpha = 1

				arg_33_1.dialog_:SetActive(true)
				SetActive(arg_33_1.leftNameGo_, true)

				local var_36_25 = arg_33_1:FormatText(StoryNameCfg[605].name)

				arg_33_1.leftNameTxt_.text = var_36_25

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_33_1.leftNameTxt_.transform)

				arg_33_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_33_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_33_1:RecordName(arg_33_1.leftNameTxt_.text)
				SetActive(arg_33_1.iconTrs_.gameObject, false)
				arg_33_1.callingController_:SetSelectedState("normal")

				local var_36_26 = arg_33_1:GetWordFromCfg(410251008)
				local var_36_27 = arg_33_1:FormatText(var_36_26.content)

				arg_33_1.text_.text = var_36_27

				LuaForUtil.ClearLinePrefixSymbol(arg_33_1.text_)

				local var_36_28 = 20
				local var_36_29 = utf8.len(var_36_27)
				local var_36_30 = var_36_28 <= 0 and var_36_24 or var_36_24 * (var_36_29 / var_36_28)

				if var_36_30 > 0 and var_36_24 < var_36_30 then
					arg_33_1.talkMaxDuration = var_36_30

					if var_36_30 + var_36_23 > arg_33_1.duration_ then
						arg_33_1.duration_ = var_36_30 + var_36_23
					end
				end

				arg_33_1.text_.text = var_36_27
				arg_33_1.typewritter.percent = 0

				arg_33_1.typewritter:SetDirty()
				arg_33_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_410251", "410251008", "story_v_out_410251.awb") ~= 0 then
					local var_36_31 = manager.audio:GetVoiceLength("story_v_out_410251", "410251008", "story_v_out_410251.awb") / 1000

					if var_36_31 + var_36_23 > arg_33_1.duration_ then
						arg_33_1.duration_ = var_36_31 + var_36_23
					end

					if var_36_26.prefab_name ~= "" and arg_33_1.actors_[var_36_26.prefab_name] ~= nil then
						local var_36_32 = LuaForUtil.PlayVoiceWithCriLipsync(arg_33_1.actors_[var_36_26.prefab_name].transform, "story_v_out_410251", "410251008", "story_v_out_410251.awb")

						arg_33_1:RecordAudio("410251008", var_36_32)
						arg_33_1:RecordAudio("410251008", var_36_32)
					else
						arg_33_1:AudioAction("play", "voice", "story_v_out_410251", "410251008", "story_v_out_410251.awb")
					end

					arg_33_1:RecordHistoryTalkVoice("story_v_out_410251", "410251008", "story_v_out_410251.awb")
				end

				arg_33_1:RecordContent(arg_33_1.text_.text)
			end

			local var_36_33 = math.max(var_36_24, arg_33_1.talkMaxDuration)

			if var_36_23 <= arg_33_1.time_ and arg_33_1.time_ < var_36_23 + var_36_33 then
				arg_33_1.typewritter.percent = (arg_33_1.time_ - var_36_23) / var_36_33

				arg_33_1.typewritter:SetDirty()
			end

			if arg_33_1.time_ >= var_36_23 + var_36_33 and arg_33_1.time_ < var_36_23 + var_36_33 + arg_36_0 then
				arg_33_1.typewritter.percent = 1

				arg_33_1.typewritter:SetDirty()
				arg_33_1:ShowNextGo(true)
			end
		end

		arg_33_1.nodeConfigList_ = {
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

		arg_33_1:InitPlayNodeList()
	end,
	Play410251009 = function(arg_37_0, arg_37_1)
		arg_37_1.time_ = 0
		arg_37_1.frameCnt_ = 0
		arg_37_1.state_ = "playing"
		arg_37_1.curTalkId_ = 410251009
		arg_37_1.duration_ = 12.97

		local var_37_0 = {
			ja = 12.966,
			CriLanguages = 7.7,
			zh = 7.7
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
				arg_37_0:Play410251010(arg_37_1)
			end
		end

		function arg_37_1.onSingleLineUpdate_(arg_40_0)
			local var_40_0 = arg_37_1.actors_["1060"].transform
			local var_40_1 = 0

			if var_40_1 < arg_37_1.time_ and arg_37_1.time_ <= var_40_1 + arg_40_0 then
				arg_37_1.var_.moveOldPos1060 = var_40_0.localPosition
				var_40_0.localScale = Vector3.New(1, 1, 1)

				arg_37_1:CheckSpriteTmpPos("1060", 4)

				local var_40_2 = var_40_0.childCount

				for iter_40_0 = 0, var_40_2 - 1 do
					local var_40_3 = var_40_0:GetChild(iter_40_0)

					if var_40_3.name == "" or not string.find(var_40_3.name, "split") then
						var_40_3.gameObject:SetActive(true)
					else
						var_40_3.gameObject:SetActive(false)
					end
				end
			end

			local var_40_4 = 0.001

			if var_40_1 <= arg_37_1.time_ and arg_37_1.time_ < var_40_1 + var_40_4 then
				local var_40_5 = (arg_37_1.time_ - var_40_1) / var_40_4
				local var_40_6 = Vector3.New(420.9, -430.8, 6.9)

				var_40_0.localPosition = Vector3.Lerp(arg_37_1.var_.moveOldPos1060, var_40_6, var_40_5)
			end

			if arg_37_1.time_ >= var_40_1 + var_40_4 and arg_37_1.time_ < var_40_1 + var_40_4 + arg_40_0 then
				var_40_0.localPosition = Vector3.New(420.9, -430.8, 6.9)
			end

			local var_40_7 = arg_37_1.actors_["1060"]
			local var_40_8 = 0

			if var_40_8 < arg_37_1.time_ and arg_37_1.time_ <= var_40_8 + arg_40_0 and not isNil(var_40_7) and arg_37_1.var_.actorSpriteComps1060 == nil then
				arg_37_1.var_.actorSpriteComps1060 = var_40_7:GetComponentsInChildren(typeof(Image), true)
			end

			local var_40_9 = 0.034

			if var_40_8 <= arg_37_1.time_ and arg_37_1.time_ < var_40_8 + var_40_9 and not isNil(var_40_7) then
				local var_40_10 = (arg_37_1.time_ - var_40_8) / var_40_9

				if arg_37_1.var_.actorSpriteComps1060 then
					for iter_40_1, iter_40_2 in pairs(arg_37_1.var_.actorSpriteComps1060:ToTable()) do
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

			if arg_37_1.time_ >= var_40_8 + var_40_9 and arg_37_1.time_ < var_40_8 + var_40_9 + arg_40_0 and not isNil(var_40_7) and arg_37_1.var_.actorSpriteComps1060 then
				for iter_40_3, iter_40_4 in pairs(arg_37_1.var_.actorSpriteComps1060:ToTable()) do
					if iter_40_4 then
						if arg_37_1.isInRecall_ then
							iter_40_4.color = arg_37_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_40_4.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_37_1.var_.actorSpriteComps1060 = nil
			end

			local var_40_15 = arg_37_1.actors_["1056"]
			local var_40_16 = 0

			if var_40_16 < arg_37_1.time_ and arg_37_1.time_ <= var_40_16 + arg_40_0 and not isNil(var_40_15) and arg_37_1.var_.actorSpriteComps1056 == nil then
				arg_37_1.var_.actorSpriteComps1056 = var_40_15:GetComponentsInChildren(typeof(Image), true)
			end

			local var_40_17 = 0.034

			if var_40_16 <= arg_37_1.time_ and arg_37_1.time_ < var_40_16 + var_40_17 and not isNil(var_40_15) then
				local var_40_18 = (arg_37_1.time_ - var_40_16) / var_40_17

				if arg_37_1.var_.actorSpriteComps1056 then
					for iter_40_5, iter_40_6 in pairs(arg_37_1.var_.actorSpriteComps1056:ToTable()) do
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

			if arg_37_1.time_ >= var_40_16 + var_40_17 and arg_37_1.time_ < var_40_16 + var_40_17 + arg_40_0 and not isNil(var_40_15) and arg_37_1.var_.actorSpriteComps1056 then
				for iter_40_7, iter_40_8 in pairs(arg_37_1.var_.actorSpriteComps1056:ToTable()) do
					if iter_40_8 then
						if arg_37_1.isInRecall_ then
							iter_40_8.color = arg_37_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_40_8.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_37_1.var_.actorSpriteComps1056 = nil
			end

			local var_40_23 = 0
			local var_40_24 = 0.95

			if var_40_23 < arg_37_1.time_ and arg_37_1.time_ <= var_40_23 + arg_40_0 then
				arg_37_1.talkMaxDuration = 0
				arg_37_1.dialogCg_.alpha = 1

				arg_37_1.dialog_:SetActive(true)
				SetActive(arg_37_1.leftNameGo_, true)

				local var_40_25 = arg_37_1:FormatText(StoryNameCfg[584].name)

				arg_37_1.leftNameTxt_.text = var_40_25

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_37_1.leftNameTxt_.transform)

				arg_37_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_37_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_37_1:RecordName(arg_37_1.leftNameTxt_.text)
				SetActive(arg_37_1.iconTrs_.gameObject, false)
				arg_37_1.callingController_:SetSelectedState("normal")

				local var_40_26 = arg_37_1:GetWordFromCfg(410251009)
				local var_40_27 = arg_37_1:FormatText(var_40_26.content)

				arg_37_1.text_.text = var_40_27

				LuaForUtil.ClearLinePrefixSymbol(arg_37_1.text_)

				local var_40_28 = 39
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

				if manager.audio:GetVoiceLength("story_v_out_410251", "410251009", "story_v_out_410251.awb") ~= 0 then
					local var_40_31 = manager.audio:GetVoiceLength("story_v_out_410251", "410251009", "story_v_out_410251.awb") / 1000

					if var_40_31 + var_40_23 > arg_37_1.duration_ then
						arg_37_1.duration_ = var_40_31 + var_40_23
					end

					if var_40_26.prefab_name ~= "" and arg_37_1.actors_[var_40_26.prefab_name] ~= nil then
						local var_40_32 = LuaForUtil.PlayVoiceWithCriLipsync(arg_37_1.actors_[var_40_26.prefab_name].transform, "story_v_out_410251", "410251009", "story_v_out_410251.awb")

						arg_37_1:RecordAudio("410251009", var_40_32)
						arg_37_1:RecordAudio("410251009", var_40_32)
					else
						arg_37_1:AudioAction("play", "voice", "story_v_out_410251", "410251009", "story_v_out_410251.awb")
					end

					arg_37_1:RecordHistoryTalkVoice("story_v_out_410251", "410251009", "story_v_out_410251.awb")
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
	Play410251010 = function(arg_41_0, arg_41_1)
		arg_41_1.time_ = 0
		arg_41_1.frameCnt_ = 0
		arg_41_1.state_ = "playing"
		arg_41_1.curTalkId_ = 410251010
		arg_41_1.duration_ = 4.07

		local var_41_0 = {
			ja = 4.066,
			CriLanguages = 2.533,
			zh = 2.533
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
				arg_41_0:Play410251011(arg_41_1)
			end
		end

		function arg_41_1.onSingleLineUpdate_(arg_44_0)
			local var_44_0 = arg_41_1.actors_["1056"].transform
			local var_44_1 = 0

			if var_44_1 < arg_41_1.time_ and arg_41_1.time_ <= var_44_1 + arg_44_0 then
				arg_41_1.var_.moveOldPos1056 = var_44_0.localPosition
				var_44_0.localScale = Vector3.New(1, 1, 1)

				arg_41_1:CheckSpriteTmpPos("1056", 2)

				local var_44_2 = var_44_0.childCount

				for iter_44_0 = 0, var_44_2 - 1 do
					local var_44_3 = var_44_0:GetChild(iter_44_0)

					if var_44_3.name == "split_4" or not string.find(var_44_3.name, "split") then
						var_44_3.gameObject:SetActive(true)
					else
						var_44_3.gameObject:SetActive(false)
					end
				end
			end

			local var_44_4 = 0.001

			if var_44_1 <= arg_41_1.time_ and arg_41_1.time_ < var_44_1 + var_44_4 then
				local var_44_5 = (arg_41_1.time_ - var_44_1) / var_44_4
				local var_44_6 = Vector3.New(-390, -350, -180)

				var_44_0.localPosition = Vector3.Lerp(arg_41_1.var_.moveOldPos1056, var_44_6, var_44_5)
			end

			if arg_41_1.time_ >= var_44_1 + var_44_4 and arg_41_1.time_ < var_44_1 + var_44_4 + arg_44_0 then
				var_44_0.localPosition = Vector3.New(-390, -350, -180)
			end

			local var_44_7 = arg_41_1.actors_["1056"]
			local var_44_8 = 0

			if var_44_8 < arg_41_1.time_ and arg_41_1.time_ <= var_44_8 + arg_44_0 and not isNil(var_44_7) and arg_41_1.var_.actorSpriteComps1056 == nil then
				arg_41_1.var_.actorSpriteComps1056 = var_44_7:GetComponentsInChildren(typeof(Image), true)
			end

			local var_44_9 = 0.034

			if var_44_8 <= arg_41_1.time_ and arg_41_1.time_ < var_44_8 + var_44_9 and not isNil(var_44_7) then
				local var_44_10 = (arg_41_1.time_ - var_44_8) / var_44_9

				if arg_41_1.var_.actorSpriteComps1056 then
					for iter_44_1, iter_44_2 in pairs(arg_41_1.var_.actorSpriteComps1056:ToTable()) do
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

			if arg_41_1.time_ >= var_44_8 + var_44_9 and arg_41_1.time_ < var_44_8 + var_44_9 + arg_44_0 and not isNil(var_44_7) and arg_41_1.var_.actorSpriteComps1056 then
				for iter_44_3, iter_44_4 in pairs(arg_41_1.var_.actorSpriteComps1056:ToTable()) do
					if iter_44_4 then
						if arg_41_1.isInRecall_ then
							iter_44_4.color = arg_41_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_44_4.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_41_1.var_.actorSpriteComps1056 = nil
			end

			local var_44_15 = arg_41_1.actors_["1060"]
			local var_44_16 = 0

			if var_44_16 < arg_41_1.time_ and arg_41_1.time_ <= var_44_16 + arg_44_0 and not isNil(var_44_15) and arg_41_1.var_.actorSpriteComps1060 == nil then
				arg_41_1.var_.actorSpriteComps1060 = var_44_15:GetComponentsInChildren(typeof(Image), true)
			end

			local var_44_17 = 0.034

			if var_44_16 <= arg_41_1.time_ and arg_41_1.time_ < var_44_16 + var_44_17 and not isNil(var_44_15) then
				local var_44_18 = (arg_41_1.time_ - var_44_16) / var_44_17

				if arg_41_1.var_.actorSpriteComps1060 then
					for iter_44_5, iter_44_6 in pairs(arg_41_1.var_.actorSpriteComps1060:ToTable()) do
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

			if arg_41_1.time_ >= var_44_16 + var_44_17 and arg_41_1.time_ < var_44_16 + var_44_17 + arg_44_0 and not isNil(var_44_15) and arg_41_1.var_.actorSpriteComps1060 then
				for iter_44_7, iter_44_8 in pairs(arg_41_1.var_.actorSpriteComps1060:ToTable()) do
					if iter_44_8 then
						if arg_41_1.isInRecall_ then
							iter_44_8.color = arg_41_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_44_8.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_41_1.var_.actorSpriteComps1060 = nil
			end

			local var_44_23 = 0
			local var_44_24 = 0.225

			if var_44_23 < arg_41_1.time_ and arg_41_1.time_ <= var_44_23 + arg_44_0 then
				arg_41_1.talkMaxDuration = 0
				arg_41_1.dialogCg_.alpha = 1

				arg_41_1.dialog_:SetActive(true)
				SetActive(arg_41_1.leftNameGo_, true)

				local var_44_25 = arg_41_1:FormatText(StoryNameCfg[605].name)

				arg_41_1.leftNameTxt_.text = var_44_25

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_41_1.leftNameTxt_.transform)

				arg_41_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_41_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_41_1:RecordName(arg_41_1.leftNameTxt_.text)
				SetActive(arg_41_1.iconTrs_.gameObject, false)
				arg_41_1.callingController_:SetSelectedState("normal")

				local var_44_26 = arg_41_1:GetWordFromCfg(410251010)
				local var_44_27 = arg_41_1:FormatText(var_44_26.content)

				arg_41_1.text_.text = var_44_27

				LuaForUtil.ClearLinePrefixSymbol(arg_41_1.text_)

				local var_44_28 = 9
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

				if manager.audio:GetVoiceLength("story_v_out_410251", "410251010", "story_v_out_410251.awb") ~= 0 then
					local var_44_31 = manager.audio:GetVoiceLength("story_v_out_410251", "410251010", "story_v_out_410251.awb") / 1000

					if var_44_31 + var_44_23 > arg_41_1.duration_ then
						arg_41_1.duration_ = var_44_31 + var_44_23
					end

					if var_44_26.prefab_name ~= "" and arg_41_1.actors_[var_44_26.prefab_name] ~= nil then
						local var_44_32 = LuaForUtil.PlayVoiceWithCriLipsync(arg_41_1.actors_[var_44_26.prefab_name].transform, "story_v_out_410251", "410251010", "story_v_out_410251.awb")

						arg_41_1:RecordAudio("410251010", var_44_32)
						arg_41_1:RecordAudio("410251010", var_44_32)
					else
						arg_41_1:AudioAction("play", "voice", "story_v_out_410251", "410251010", "story_v_out_410251.awb")
					end

					arg_41_1:RecordHistoryTalkVoice("story_v_out_410251", "410251010", "story_v_out_410251.awb")
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
				actorName = "1056",
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
	Play410251011 = function(arg_45_0, arg_45_1)
		arg_45_1.time_ = 0
		arg_45_1.frameCnt_ = 0
		arg_45_1.state_ = "playing"
		arg_45_1.curTalkId_ = 410251011
		arg_45_1.duration_ = 4.13

		local var_45_0 = {
			ja = 4.133,
			CriLanguages = 3.7,
			zh = 3.7
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
				arg_45_0:Play410251012(arg_45_1)
			end
		end

		function arg_45_1.onSingleLineUpdate_(arg_48_0)
			local var_48_0 = arg_45_1.actors_["1060"].transform
			local var_48_1 = 0

			if var_48_1 < arg_45_1.time_ and arg_45_1.time_ <= var_48_1 + arg_48_0 then
				arg_45_1.var_.moveOldPos1060 = var_48_0.localPosition
				var_48_0.localScale = Vector3.New(1, 1, 1)

				arg_45_1:CheckSpriteTmpPos("1060", 4)

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
				local var_48_6 = Vector3.New(420.9, -430.8, 6.9)

				var_48_0.localPosition = Vector3.Lerp(arg_45_1.var_.moveOldPos1060, var_48_6, var_48_5)
			end

			if arg_45_1.time_ >= var_48_1 + var_48_4 and arg_45_1.time_ < var_48_1 + var_48_4 + arg_48_0 then
				var_48_0.localPosition = Vector3.New(420.9, -430.8, 6.9)
			end

			local var_48_7 = arg_45_1.actors_["1060"]
			local var_48_8 = 0

			if var_48_8 < arg_45_1.time_ and arg_45_1.time_ <= var_48_8 + arg_48_0 and not isNil(var_48_7) and arg_45_1.var_.actorSpriteComps1060 == nil then
				arg_45_1.var_.actorSpriteComps1060 = var_48_7:GetComponentsInChildren(typeof(Image), true)
			end

			local var_48_9 = 0.034

			if var_48_8 <= arg_45_1.time_ and arg_45_1.time_ < var_48_8 + var_48_9 and not isNil(var_48_7) then
				local var_48_10 = (arg_45_1.time_ - var_48_8) / var_48_9

				if arg_45_1.var_.actorSpriteComps1060 then
					for iter_48_1, iter_48_2 in pairs(arg_45_1.var_.actorSpriteComps1060:ToTable()) do
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

			if arg_45_1.time_ >= var_48_8 + var_48_9 and arg_45_1.time_ < var_48_8 + var_48_9 + arg_48_0 and not isNil(var_48_7) and arg_45_1.var_.actorSpriteComps1060 then
				for iter_48_3, iter_48_4 in pairs(arg_45_1.var_.actorSpriteComps1060:ToTable()) do
					if iter_48_4 then
						if arg_45_1.isInRecall_ then
							iter_48_4.color = arg_45_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_48_4.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_45_1.var_.actorSpriteComps1060 = nil
			end

			local var_48_15 = arg_45_1.actors_["1056"]
			local var_48_16 = 0

			if var_48_16 < arg_45_1.time_ and arg_45_1.time_ <= var_48_16 + arg_48_0 and not isNil(var_48_15) and arg_45_1.var_.actorSpriteComps1056 == nil then
				arg_45_1.var_.actorSpriteComps1056 = var_48_15:GetComponentsInChildren(typeof(Image), true)
			end

			local var_48_17 = 0.034

			if var_48_16 <= arg_45_1.time_ and arg_45_1.time_ < var_48_16 + var_48_17 and not isNil(var_48_15) then
				local var_48_18 = (arg_45_1.time_ - var_48_16) / var_48_17

				if arg_45_1.var_.actorSpriteComps1056 then
					for iter_48_5, iter_48_6 in pairs(arg_45_1.var_.actorSpriteComps1056:ToTable()) do
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

			if arg_45_1.time_ >= var_48_16 + var_48_17 and arg_45_1.time_ < var_48_16 + var_48_17 + arg_48_0 and not isNil(var_48_15) and arg_45_1.var_.actorSpriteComps1056 then
				for iter_48_7, iter_48_8 in pairs(arg_45_1.var_.actorSpriteComps1056:ToTable()) do
					if iter_48_8 then
						if arg_45_1.isInRecall_ then
							iter_48_8.color = arg_45_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_48_8.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_45_1.var_.actorSpriteComps1056 = nil
			end

			local var_48_23 = 0
			local var_48_24 = 0.375

			if var_48_23 < arg_45_1.time_ and arg_45_1.time_ <= var_48_23 + arg_48_0 then
				arg_45_1.talkMaxDuration = 0
				arg_45_1.dialogCg_.alpha = 1

				arg_45_1.dialog_:SetActive(true)
				SetActive(arg_45_1.leftNameGo_, true)

				local var_48_25 = arg_45_1:FormatText(StoryNameCfg[584].name)

				arg_45_1.leftNameTxt_.text = var_48_25

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_45_1.leftNameTxt_.transform)

				arg_45_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_45_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_45_1:RecordName(arg_45_1.leftNameTxt_.text)
				SetActive(arg_45_1.iconTrs_.gameObject, false)
				arg_45_1.callingController_:SetSelectedState("normal")

				local var_48_26 = arg_45_1:GetWordFromCfg(410251011)
				local var_48_27 = arg_45_1:FormatText(var_48_26.content)

				arg_45_1.text_.text = var_48_27

				LuaForUtil.ClearLinePrefixSymbol(arg_45_1.text_)

				local var_48_28 = 15
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

				if manager.audio:GetVoiceLength("story_v_out_410251", "410251011", "story_v_out_410251.awb") ~= 0 then
					local var_48_31 = manager.audio:GetVoiceLength("story_v_out_410251", "410251011", "story_v_out_410251.awb") / 1000

					if var_48_31 + var_48_23 > arg_45_1.duration_ then
						arg_45_1.duration_ = var_48_31 + var_48_23
					end

					if var_48_26.prefab_name ~= "" and arg_45_1.actors_[var_48_26.prefab_name] ~= nil then
						local var_48_32 = LuaForUtil.PlayVoiceWithCriLipsync(arg_45_1.actors_[var_48_26.prefab_name].transform, "story_v_out_410251", "410251011", "story_v_out_410251.awb")

						arg_45_1:RecordAudio("410251011", var_48_32)
						arg_45_1:RecordAudio("410251011", var_48_32)
					else
						arg_45_1:AudioAction("play", "voice", "story_v_out_410251", "410251011", "story_v_out_410251.awb")
					end

					arg_45_1:RecordHistoryTalkVoice("story_v_out_410251", "410251011", "story_v_out_410251.awb")
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
				actorName = "1060",
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
	Play410251012 = function(arg_49_0, arg_49_1)
		arg_49_1.time_ = 0
		arg_49_1.frameCnt_ = 0
		arg_49_1.state_ = "playing"
		arg_49_1.curTalkId_ = 410251012
		arg_49_1.duration_ = 4.33

		local var_49_0 = {
			ja = 4.333,
			CriLanguages = 4.2,
			zh = 4.2
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
				arg_49_0:Play410251013(arg_49_1)
			end
		end

		function arg_49_1.onSingleLineUpdate_(arg_52_0)
			local var_52_0 = arg_49_1.actors_["1060"].transform
			local var_52_1 = 0

			if var_52_1 < arg_49_1.time_ and arg_49_1.time_ <= var_52_1 + arg_52_0 then
				arg_49_1.var_.moveOldPos1060 = var_52_0.localPosition
				var_52_0.localScale = Vector3.New(1, 1, 1)

				arg_49_1:CheckSpriteTmpPos("1060", 4)

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
				local var_52_6 = Vector3.New(420.9, -430.8, 6.9)

				var_52_0.localPosition = Vector3.Lerp(arg_49_1.var_.moveOldPos1060, var_52_6, var_52_5)
			end

			if arg_49_1.time_ >= var_52_1 + var_52_4 and arg_49_1.time_ < var_52_1 + var_52_4 + arg_52_0 then
				var_52_0.localPosition = Vector3.New(420.9, -430.8, 6.9)
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

			local var_52_15 = 0
			local var_52_16 = 0.475

			if var_52_15 < arg_49_1.time_ and arg_49_1.time_ <= var_52_15 + arg_52_0 then
				arg_49_1.talkMaxDuration = 0
				arg_49_1.dialogCg_.alpha = 1

				arg_49_1.dialog_:SetActive(true)
				SetActive(arg_49_1.leftNameGo_, true)

				local var_52_17 = arg_49_1:FormatText(StoryNameCfg[584].name)

				arg_49_1.leftNameTxt_.text = var_52_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_49_1.leftNameTxt_.transform)

				arg_49_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_49_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_49_1:RecordName(arg_49_1.leftNameTxt_.text)
				SetActive(arg_49_1.iconTrs_.gameObject, false)
				arg_49_1.callingController_:SetSelectedState("normal")

				local var_52_18 = arg_49_1:GetWordFromCfg(410251012)
				local var_52_19 = arg_49_1:FormatText(var_52_18.content)

				arg_49_1.text_.text = var_52_19

				LuaForUtil.ClearLinePrefixSymbol(arg_49_1.text_)

				local var_52_20 = 19
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

				if manager.audio:GetVoiceLength("story_v_out_410251", "410251012", "story_v_out_410251.awb") ~= 0 then
					local var_52_23 = manager.audio:GetVoiceLength("story_v_out_410251", "410251012", "story_v_out_410251.awb") / 1000

					if var_52_23 + var_52_15 > arg_49_1.duration_ then
						arg_49_1.duration_ = var_52_23 + var_52_15
					end

					if var_52_18.prefab_name ~= "" and arg_49_1.actors_[var_52_18.prefab_name] ~= nil then
						local var_52_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_49_1.actors_[var_52_18.prefab_name].transform, "story_v_out_410251", "410251012", "story_v_out_410251.awb")

						arg_49_1:RecordAudio("410251012", var_52_24)
						arg_49_1:RecordAudio("410251012", var_52_24)
					else
						arg_49_1:AudioAction("play", "voice", "story_v_out_410251", "410251012", "story_v_out_410251.awb")
					end

					arg_49_1:RecordHistoryTalkVoice("story_v_out_410251", "410251012", "story_v_out_410251.awb")
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
				actorName = "1060",
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
	Play410251013 = function(arg_53_0, arg_53_1)
		arg_53_1.time_ = 0
		arg_53_1.frameCnt_ = 0
		arg_53_1.state_ = "playing"
		arg_53_1.curTalkId_ = 410251013
		arg_53_1.duration_ = 9

		SetActive(arg_53_1.tipsGo_, false)

		function arg_53_1.onSingleLineFinish_()
			arg_53_1.onSingleLineUpdate_ = nil
			arg_53_1.onSingleLineFinish_ = nil
			arg_53_1.state_ = "waiting"
		end

		function arg_53_1.playNext_(arg_55_0)
			if arg_55_0 == 1 then
				arg_53_0:Play410251014(arg_53_1)
			end
		end

		function arg_53_1.onSingleLineUpdate_(arg_56_0)
			local var_56_0 = "L04h"

			if arg_53_1.bgs_[var_56_0] == nil then
				local var_56_1 = Object.Instantiate(arg_53_1.paintGo_)

				var_56_1:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. var_56_0)
				var_56_1.name = var_56_0
				var_56_1.transform.parent = arg_53_1.stage_.transform
				var_56_1.transform.localPosition = Vector3.New(0, 100, 0)
				arg_53_1.bgs_[var_56_0] = var_56_1
			end

			local var_56_2 = 2

			if var_56_2 < arg_53_1.time_ and arg_53_1.time_ <= var_56_2 + arg_56_0 then
				local var_56_3 = manager.ui.mainCamera.transform.localPosition
				local var_56_4 = Vector3.New(0, 0, 10) + Vector3.New(var_56_3.x, var_56_3.y, 0)
				local var_56_5 = arg_53_1.bgs_.L04h

				var_56_5.transform.localPosition = var_56_4
				var_56_5.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_56_6 = var_56_5:GetComponent("SpriteRenderer")

				if var_56_6 and var_56_6.sprite then
					local var_56_7 = (var_56_5.transform.localPosition - var_56_3).z
					local var_56_8 = manager.ui.mainCameraCom_
					local var_56_9 = 2 * var_56_7 * Mathf.Tan(var_56_8.fieldOfView * 0.5 * Mathf.Deg2Rad)
					local var_56_10 = var_56_9 * var_56_8.aspect
					local var_56_11 = var_56_6.sprite.bounds.size.x
					local var_56_12 = var_56_6.sprite.bounds.size.y
					local var_56_13 = var_56_10 / var_56_11
					local var_56_14 = var_56_9 / var_56_12
					local var_56_15 = var_56_14 < var_56_13 and var_56_13 or var_56_14

					var_56_5.transform.localScale = Vector3.New(var_56_15, var_56_15, 0)
				end

				for iter_56_0, iter_56_1 in pairs(arg_53_1.bgs_) do
					if iter_56_0 ~= "L04h" then
						iter_56_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_56_16 = 0

			if var_56_16 < arg_53_1.time_ and arg_53_1.time_ <= var_56_16 + arg_56_0 then
				arg_53_1.mask_.enabled = true
				arg_53_1.mask_.raycastTarget = true

				arg_53_1:SetGaussion(false)
			end

			local var_56_17 = 2

			if var_56_16 <= arg_53_1.time_ and arg_53_1.time_ < var_56_16 + var_56_17 then
				local var_56_18 = (arg_53_1.time_ - var_56_16) / var_56_17
				local var_56_19 = Color.New(0, 0, 0)

				var_56_19.a = Mathf.Lerp(0, 1, var_56_18)
				arg_53_1.mask_.color = var_56_19
			end

			if arg_53_1.time_ >= var_56_16 + var_56_17 and arg_53_1.time_ < var_56_16 + var_56_17 + arg_56_0 then
				local var_56_20 = Color.New(0, 0, 0)

				var_56_20.a = 1
				arg_53_1.mask_.color = var_56_20
			end

			local var_56_21 = 2

			if var_56_21 < arg_53_1.time_ and arg_53_1.time_ <= var_56_21 + arg_56_0 then
				arg_53_1.mask_.enabled = true
				arg_53_1.mask_.raycastTarget = true

				arg_53_1:SetGaussion(false)
			end

			local var_56_22 = 2

			if var_56_21 <= arg_53_1.time_ and arg_53_1.time_ < var_56_21 + var_56_22 then
				local var_56_23 = (arg_53_1.time_ - var_56_21) / var_56_22
				local var_56_24 = Color.New(0, 0, 0)

				var_56_24.a = Mathf.Lerp(1, 0, var_56_23)
				arg_53_1.mask_.color = var_56_24
			end

			if arg_53_1.time_ >= var_56_21 + var_56_22 and arg_53_1.time_ < var_56_21 + var_56_22 + arg_56_0 then
				local var_56_25 = Color.New(0, 0, 0)
				local var_56_26 = 0

				arg_53_1.mask_.enabled = false
				var_56_25.a = var_56_26
				arg_53_1.mask_.color = var_56_25
			end

			local var_56_27 = arg_53_1.actors_["1056"].transform
			local var_56_28 = 2

			if var_56_28 < arg_53_1.time_ and arg_53_1.time_ <= var_56_28 + arg_56_0 then
				arg_53_1.var_.moveOldPos1056 = var_56_27.localPosition
				var_56_27.localScale = Vector3.New(1, 1, 1)

				arg_53_1:CheckSpriteTmpPos("1056", 7)

				local var_56_29 = var_56_27.childCount

				for iter_56_2 = 0, var_56_29 - 1 do
					local var_56_30 = var_56_27:GetChild(iter_56_2)

					if var_56_30.name == "" or not string.find(var_56_30.name, "split") then
						var_56_30.gameObject:SetActive(true)
					else
						var_56_30.gameObject:SetActive(false)
					end
				end
			end

			local var_56_31 = 0.001

			if var_56_28 <= arg_53_1.time_ and arg_53_1.time_ < var_56_28 + var_56_31 then
				local var_56_32 = (arg_53_1.time_ - var_56_28) / var_56_31
				local var_56_33 = Vector3.New(0, -2000, -180)

				var_56_27.localPosition = Vector3.Lerp(arg_53_1.var_.moveOldPos1056, var_56_33, var_56_32)
			end

			if arg_53_1.time_ >= var_56_28 + var_56_31 and arg_53_1.time_ < var_56_28 + var_56_31 + arg_56_0 then
				var_56_27.localPosition = Vector3.New(0, -2000, -180)
			end

			local var_56_34 = arg_53_1.actors_["1060"].transform
			local var_56_35 = 2

			if var_56_35 < arg_53_1.time_ and arg_53_1.time_ <= var_56_35 + arg_56_0 then
				arg_53_1.var_.moveOldPos1060 = var_56_34.localPosition
				var_56_34.localScale = Vector3.New(1, 1, 1)

				arg_53_1:CheckSpriteTmpPos("1060", 7)

				local var_56_36 = var_56_34.childCount

				for iter_56_3 = 0, var_56_36 - 1 do
					local var_56_37 = var_56_34:GetChild(iter_56_3)

					if var_56_37.name == "" or not string.find(var_56_37.name, "split") then
						var_56_37.gameObject:SetActive(true)
					else
						var_56_37.gameObject:SetActive(false)
					end
				end
			end

			local var_56_38 = 0.001

			if var_56_35 <= arg_53_1.time_ and arg_53_1.time_ < var_56_35 + var_56_38 then
				local var_56_39 = (arg_53_1.time_ - var_56_35) / var_56_38
				local var_56_40 = Vector3.New(0, -2000, -40)

				var_56_34.localPosition = Vector3.Lerp(arg_53_1.var_.moveOldPos1060, var_56_40, var_56_39)
			end

			if arg_53_1.time_ >= var_56_35 + var_56_38 and arg_53_1.time_ < var_56_35 + var_56_38 + arg_56_0 then
				var_56_34.localPosition = Vector3.New(0, -2000, -40)
			end

			local var_56_41 = arg_53_1.actors_["1056"]
			local var_56_42 = 2

			if var_56_42 < arg_53_1.time_ and arg_53_1.time_ <= var_56_42 + arg_56_0 and not isNil(var_56_41) and arg_53_1.var_.actorSpriteComps1056 == nil then
				arg_53_1.var_.actorSpriteComps1056 = var_56_41:GetComponentsInChildren(typeof(Image), true)
			end

			local var_56_43 = 0.034

			if var_56_42 <= arg_53_1.time_ and arg_53_1.time_ < var_56_42 + var_56_43 and not isNil(var_56_41) then
				local var_56_44 = (arg_53_1.time_ - var_56_42) / var_56_43

				if arg_53_1.var_.actorSpriteComps1056 then
					for iter_56_4, iter_56_5 in pairs(arg_53_1.var_.actorSpriteComps1056:ToTable()) do
						if iter_56_5 then
							if arg_53_1.isInRecall_ then
								local var_56_45 = Mathf.Lerp(iter_56_5.color.r, arg_53_1.hightColor2.r, var_56_44)
								local var_56_46 = Mathf.Lerp(iter_56_5.color.g, arg_53_1.hightColor2.g, var_56_44)
								local var_56_47 = Mathf.Lerp(iter_56_5.color.b, arg_53_1.hightColor2.b, var_56_44)

								iter_56_5.color = Color.New(var_56_45, var_56_46, var_56_47)
							else
								local var_56_48 = Mathf.Lerp(iter_56_5.color.r, 0.5, var_56_44)

								iter_56_5.color = Color.New(var_56_48, var_56_48, var_56_48)
							end
						end
					end
				end
			end

			if arg_53_1.time_ >= var_56_42 + var_56_43 and arg_53_1.time_ < var_56_42 + var_56_43 + arg_56_0 and not isNil(var_56_41) and arg_53_1.var_.actorSpriteComps1056 then
				for iter_56_6, iter_56_7 in pairs(arg_53_1.var_.actorSpriteComps1056:ToTable()) do
					if iter_56_7 then
						if arg_53_1.isInRecall_ then
							iter_56_7.color = arg_53_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_56_7.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_53_1.var_.actorSpriteComps1056 = nil
			end

			local var_56_49 = arg_53_1.actors_["1060"]
			local var_56_50 = 2

			if var_56_50 < arg_53_1.time_ and arg_53_1.time_ <= var_56_50 + arg_56_0 and not isNil(var_56_49) and arg_53_1.var_.actorSpriteComps1060 == nil then
				arg_53_1.var_.actorSpriteComps1060 = var_56_49:GetComponentsInChildren(typeof(Image), true)
			end

			local var_56_51 = 0.034

			if var_56_50 <= arg_53_1.time_ and arg_53_1.time_ < var_56_50 + var_56_51 and not isNil(var_56_49) then
				local var_56_52 = (arg_53_1.time_ - var_56_50) / var_56_51

				if arg_53_1.var_.actorSpriteComps1060 then
					for iter_56_8, iter_56_9 in pairs(arg_53_1.var_.actorSpriteComps1060:ToTable()) do
						if iter_56_9 then
							if arg_53_1.isInRecall_ then
								local var_56_53 = Mathf.Lerp(iter_56_9.color.r, arg_53_1.hightColor2.r, var_56_52)
								local var_56_54 = Mathf.Lerp(iter_56_9.color.g, arg_53_1.hightColor2.g, var_56_52)
								local var_56_55 = Mathf.Lerp(iter_56_9.color.b, arg_53_1.hightColor2.b, var_56_52)

								iter_56_9.color = Color.New(var_56_53, var_56_54, var_56_55)
							else
								local var_56_56 = Mathf.Lerp(iter_56_9.color.r, 0.5, var_56_52)

								iter_56_9.color = Color.New(var_56_56, var_56_56, var_56_56)
							end
						end
					end
				end
			end

			if arg_53_1.time_ >= var_56_50 + var_56_51 and arg_53_1.time_ < var_56_50 + var_56_51 + arg_56_0 and not isNil(var_56_49) and arg_53_1.var_.actorSpriteComps1060 then
				for iter_56_10, iter_56_11 in pairs(arg_53_1.var_.actorSpriteComps1060:ToTable()) do
					if iter_56_11 then
						if arg_53_1.isInRecall_ then
							iter_56_11.color = arg_53_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_56_11.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_53_1.var_.actorSpriteComps1060 = nil
			end

			if arg_53_1.frameCnt_ <= 1 then
				arg_53_1.dialog_:SetActive(false)
			end

			local var_56_57 = 4
			local var_56_58 = 0.9

			if var_56_57 < arg_53_1.time_ and arg_53_1.time_ <= var_56_57 + arg_56_0 then
				arg_53_1.talkMaxDuration = 0

				arg_53_1.dialog_:SetActive(true)

				arg_53_1.dialogCg_.alpha = 0

				local var_56_59 = LeanTween.value(arg_53_1.dialog_, 0, 1, 0.3)

				var_56_59:setOnUpdate(LuaHelper.FloatAction(function(arg_57_0)
					arg_53_1.dialogCg_.alpha = arg_57_0
				end))
				var_56_59:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_53_1.dialog_)
					var_56_59:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_53_1.duration_ = arg_53_1.duration_ + 0.3

				SetActive(arg_53_1.leftNameGo_, false)

				arg_53_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_53_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_53_1:RecordName(arg_53_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_53_1.iconTrs_.gameObject, false)
				arg_53_1.callingController_:SetSelectedState("normal")

				local var_56_60 = arg_53_1:GetWordFromCfg(410251013)
				local var_56_61 = arg_53_1:FormatText(var_56_60.content)

				arg_53_1.text_.text = var_56_61

				LuaForUtil.ClearLinePrefixSymbol(arg_53_1.text_)

				local var_56_62 = 36
				local var_56_63 = utf8.len(var_56_61)
				local var_56_64 = var_56_62 <= 0 and var_56_58 or var_56_58 * (var_56_63 / var_56_62)

				if var_56_64 > 0 and var_56_58 < var_56_64 then
					arg_53_1.talkMaxDuration = var_56_64
					var_56_57 = var_56_57 + 0.3

					if var_56_64 + var_56_57 > arg_53_1.duration_ then
						arg_53_1.duration_ = var_56_64 + var_56_57
					end
				end

				arg_53_1.text_.text = var_56_61
				arg_53_1.typewritter.percent = 0

				arg_53_1.typewritter:SetDirty()
				arg_53_1:ShowNextGo(false)
				arg_53_1:RecordContent(arg_53_1.text_.text)
			end

			local var_56_65 = var_56_57 + 0.3
			local var_56_66 = math.max(var_56_58, arg_53_1.talkMaxDuration)

			if var_56_65 <= arg_53_1.time_ and arg_53_1.time_ < var_56_65 + var_56_66 then
				arg_53_1.typewritter.percent = (arg_53_1.time_ - var_56_65) / var_56_66

				arg_53_1.typewritter:SetDirty()
			end

			if arg_53_1.time_ >= var_56_65 + var_56_66 and arg_53_1.time_ < var_56_65 + var_56_66 + arg_56_0 then
				arg_53_1.typewritter.percent = 1

				arg_53_1.typewritter:SetDirty()
				arg_53_1:ShowNextGo(true)
			end
		end

		arg_53_1.nodeConfigList_ = {
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
				actorName = "1060",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 2,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_53_1:InitPlayNodeList()
	end,
	Play410251014 = function(arg_59_0, arg_59_1)
		arg_59_1.time_ = 0
		arg_59_1.frameCnt_ = 0
		arg_59_1.state_ = "playing"
		arg_59_1.curTalkId_ = 410251014
		arg_59_1.duration_ = 5

		SetActive(arg_59_1.tipsGo_, false)

		function arg_59_1.onSingleLineFinish_()
			arg_59_1.onSingleLineUpdate_ = nil
			arg_59_1.onSingleLineFinish_ = nil
			arg_59_1.state_ = "waiting"
		end

		function arg_59_1.playNext_(arg_61_0)
			if arg_61_0 == 1 then
				arg_59_0:Play410251015(arg_59_1)
			end
		end

		function arg_59_1.onSingleLineUpdate_(arg_62_0)
			local var_62_0 = 0
			local var_62_1 = 1

			if var_62_0 < arg_59_1.time_ and arg_59_1.time_ <= var_62_0 + arg_62_0 then
				arg_59_1.talkMaxDuration = 0
				arg_59_1.dialogCg_.alpha = 1

				arg_59_1.dialog_:SetActive(true)
				SetActive(arg_59_1.leftNameGo_, false)

				arg_59_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_59_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_59_1:RecordName(arg_59_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_59_1.iconTrs_.gameObject, false)
				arg_59_1.callingController_:SetSelectedState("normal")

				local var_62_2 = arg_59_1:GetWordFromCfg(410251014)
				local var_62_3 = arg_59_1:FormatText(var_62_2.content)

				arg_59_1.text_.text = var_62_3

				LuaForUtil.ClearLinePrefixSymbol(arg_59_1.text_)

				local var_62_4 = 40
				local var_62_5 = utf8.len(var_62_3)
				local var_62_6 = var_62_4 <= 0 and var_62_1 or var_62_1 * (var_62_5 / var_62_4)

				if var_62_6 > 0 and var_62_1 < var_62_6 then
					arg_59_1.talkMaxDuration = var_62_6

					if var_62_6 + var_62_0 > arg_59_1.duration_ then
						arg_59_1.duration_ = var_62_6 + var_62_0
					end
				end

				arg_59_1.text_.text = var_62_3
				arg_59_1.typewritter.percent = 0

				arg_59_1.typewritter:SetDirty()
				arg_59_1:ShowNextGo(false)
				arg_59_1:RecordContent(arg_59_1.text_.text)
			end

			local var_62_7 = math.max(var_62_1, arg_59_1.talkMaxDuration)

			if var_62_0 <= arg_59_1.time_ and arg_59_1.time_ < var_62_0 + var_62_7 then
				arg_59_1.typewritter.percent = (arg_59_1.time_ - var_62_0) / var_62_7

				arg_59_1.typewritter:SetDirty()
			end

			if arg_59_1.time_ >= var_62_0 + var_62_7 and arg_59_1.time_ < var_62_0 + var_62_7 + arg_62_0 then
				arg_59_1.typewritter.percent = 1

				arg_59_1.typewritter:SetDirty()
				arg_59_1:ShowNextGo(true)
			end
		end

		arg_59_1.nodeConfigList_ = {}

		arg_59_1:InitPlayNodeList()
	end,
	Play410251015 = function(arg_63_0, arg_63_1)
		arg_63_1.time_ = 0
		arg_63_1.frameCnt_ = 0
		arg_63_1.state_ = "playing"
		arg_63_1.curTalkId_ = 410251015
		arg_63_1.duration_ = 2.3

		local var_63_0 = {
			ja = 2.3,
			CriLanguages = 1.2,
			zh = 1.2
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
				arg_63_0:Play410251016(arg_63_1)
			end
		end

		function arg_63_1.onSingleLineUpdate_(arg_66_0)
			local var_66_0 = arg_63_1.actors_["1060"].transform
			local var_66_1 = 0

			if var_66_1 < arg_63_1.time_ and arg_63_1.time_ <= var_66_1 + arg_66_0 then
				arg_63_1.var_.moveOldPos1060 = var_66_0.localPosition
				var_66_0.localScale = Vector3.New(1, 1, 1)

				arg_63_1:CheckSpriteTmpPos("1060", 3)

				local var_66_2 = var_66_0.childCount

				for iter_66_0 = 0, var_66_2 - 1 do
					local var_66_3 = var_66_0:GetChild(iter_66_0)

					if var_66_3.name == "split_3" or not string.find(var_66_3.name, "split") then
						var_66_3.gameObject:SetActive(true)
					else
						var_66_3.gameObject:SetActive(false)
					end
				end
			end

			local var_66_4 = 0.001

			if var_66_1 <= arg_63_1.time_ and arg_63_1.time_ < var_66_1 + var_66_4 then
				local var_66_5 = (arg_63_1.time_ - var_66_1) / var_66_4
				local var_66_6 = Vector3.New(33.4, -430.8, 6.9)

				var_66_0.localPosition = Vector3.Lerp(arg_63_1.var_.moveOldPos1060, var_66_6, var_66_5)
			end

			if arg_63_1.time_ >= var_66_1 + var_66_4 and arg_63_1.time_ < var_66_1 + var_66_4 + arg_66_0 then
				var_66_0.localPosition = Vector3.New(33.4, -430.8, 6.9)
			end

			local var_66_7 = arg_63_1.actors_["1060"]
			local var_66_8 = 0

			if var_66_8 < arg_63_1.time_ and arg_63_1.time_ <= var_66_8 + arg_66_0 and not isNil(var_66_7) and arg_63_1.var_.actorSpriteComps1060 == nil then
				arg_63_1.var_.actorSpriteComps1060 = var_66_7:GetComponentsInChildren(typeof(Image), true)
			end

			local var_66_9 = 0.034

			if var_66_8 <= arg_63_1.time_ and arg_63_1.time_ < var_66_8 + var_66_9 and not isNil(var_66_7) then
				local var_66_10 = (arg_63_1.time_ - var_66_8) / var_66_9

				if arg_63_1.var_.actorSpriteComps1060 then
					for iter_66_1, iter_66_2 in pairs(arg_63_1.var_.actorSpriteComps1060:ToTable()) do
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

			if arg_63_1.time_ >= var_66_8 + var_66_9 and arg_63_1.time_ < var_66_8 + var_66_9 + arg_66_0 and not isNil(var_66_7) and arg_63_1.var_.actorSpriteComps1060 then
				for iter_66_3, iter_66_4 in pairs(arg_63_1.var_.actorSpriteComps1060:ToTable()) do
					if iter_66_4 then
						if arg_63_1.isInRecall_ then
							iter_66_4.color = arg_63_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_66_4.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_63_1.var_.actorSpriteComps1060 = nil
			end

			local var_66_15 = 0
			local var_66_16 = 0.075

			if var_66_15 < arg_63_1.time_ and arg_63_1.time_ <= var_66_15 + arg_66_0 then
				arg_63_1.talkMaxDuration = 0
				arg_63_1.dialogCg_.alpha = 1

				arg_63_1.dialog_:SetActive(true)
				SetActive(arg_63_1.leftNameGo_, true)

				local var_66_17 = arg_63_1:FormatText(StoryNameCfg[584].name)

				arg_63_1.leftNameTxt_.text = var_66_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_63_1.leftNameTxt_.transform)

				arg_63_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_63_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_63_1:RecordName(arg_63_1.leftNameTxt_.text)
				SetActive(arg_63_1.iconTrs_.gameObject, false)
				arg_63_1.callingController_:SetSelectedState("normal")

				local var_66_18 = arg_63_1:GetWordFromCfg(410251015)
				local var_66_19 = arg_63_1:FormatText(var_66_18.content)

				arg_63_1.text_.text = var_66_19

				LuaForUtil.ClearLinePrefixSymbol(arg_63_1.text_)

				local var_66_20 = 3
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

				if manager.audio:GetVoiceLength("story_v_out_410251", "410251015", "story_v_out_410251.awb") ~= 0 then
					local var_66_23 = manager.audio:GetVoiceLength("story_v_out_410251", "410251015", "story_v_out_410251.awb") / 1000

					if var_66_23 + var_66_15 > arg_63_1.duration_ then
						arg_63_1.duration_ = var_66_23 + var_66_15
					end

					if var_66_18.prefab_name ~= "" and arg_63_1.actors_[var_66_18.prefab_name] ~= nil then
						local var_66_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_63_1.actors_[var_66_18.prefab_name].transform, "story_v_out_410251", "410251015", "story_v_out_410251.awb")

						arg_63_1:RecordAudio("410251015", var_66_24)
						arg_63_1:RecordAudio("410251015", var_66_24)
					else
						arg_63_1:AudioAction("play", "voice", "story_v_out_410251", "410251015", "story_v_out_410251.awb")
					end

					arg_63_1:RecordHistoryTalkVoice("story_v_out_410251", "410251015", "story_v_out_410251.awb")
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
				actorName = "1060",
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
	Play410251016 = function(arg_67_0, arg_67_1)
		arg_67_1.time_ = 0
		arg_67_1.frameCnt_ = 0
		arg_67_1.state_ = "playing"
		arg_67_1.curTalkId_ = 410251016
		arg_67_1.duration_ = 5

		SetActive(arg_67_1.tipsGo_, false)

		function arg_67_1.onSingleLineFinish_()
			arg_67_1.onSingleLineUpdate_ = nil
			arg_67_1.onSingleLineFinish_ = nil
			arg_67_1.state_ = "waiting"
		end

		function arg_67_1.playNext_(arg_69_0)
			if arg_69_0 == 1 then
				arg_67_0:Play410251017(arg_67_1)
			end
		end

		function arg_67_1.onSingleLineUpdate_(arg_70_0)
			local var_70_0 = arg_67_1.actors_["1060"].transform
			local var_70_1 = 0

			if var_70_1 < arg_67_1.time_ and arg_67_1.time_ <= var_70_1 + arg_70_0 then
				arg_67_1.var_.moveOldPos1060 = var_70_0.localPosition
				var_70_0.localScale = Vector3.New(1, 1, 1)

				arg_67_1:CheckSpriteTmpPos("1060", 7)

				local var_70_2 = var_70_0.childCount

				for iter_70_0 = 0, var_70_2 - 1 do
					local var_70_3 = var_70_0:GetChild(iter_70_0)

					if var_70_3.name == "" or not string.find(var_70_3.name, "split") then
						var_70_3.gameObject:SetActive(true)
					else
						var_70_3.gameObject:SetActive(false)
					end
				end
			end

			local var_70_4 = 0.001

			if var_70_1 <= arg_67_1.time_ and arg_67_1.time_ < var_70_1 + var_70_4 then
				local var_70_5 = (arg_67_1.time_ - var_70_1) / var_70_4
				local var_70_6 = Vector3.New(0, -2000, -40)

				var_70_0.localPosition = Vector3.Lerp(arg_67_1.var_.moveOldPos1060, var_70_6, var_70_5)
			end

			if arg_67_1.time_ >= var_70_1 + var_70_4 and arg_67_1.time_ < var_70_1 + var_70_4 + arg_70_0 then
				var_70_0.localPosition = Vector3.New(0, -2000, -40)
			end

			local var_70_7 = arg_67_1.actors_["1060"]
			local var_70_8 = 0

			if var_70_8 < arg_67_1.time_ and arg_67_1.time_ <= var_70_8 + arg_70_0 and not isNil(var_70_7) and arg_67_1.var_.actorSpriteComps1060 == nil then
				arg_67_1.var_.actorSpriteComps1060 = var_70_7:GetComponentsInChildren(typeof(Image), true)
			end

			local var_70_9 = 0.034

			if var_70_8 <= arg_67_1.time_ and arg_67_1.time_ < var_70_8 + var_70_9 and not isNil(var_70_7) then
				local var_70_10 = (arg_67_1.time_ - var_70_8) / var_70_9

				if arg_67_1.var_.actorSpriteComps1060 then
					for iter_70_1, iter_70_2 in pairs(arg_67_1.var_.actorSpriteComps1060:ToTable()) do
						if iter_70_2 then
							if arg_67_1.isInRecall_ then
								local var_70_11 = Mathf.Lerp(iter_70_2.color.r, arg_67_1.hightColor2.r, var_70_10)
								local var_70_12 = Mathf.Lerp(iter_70_2.color.g, arg_67_1.hightColor2.g, var_70_10)
								local var_70_13 = Mathf.Lerp(iter_70_2.color.b, arg_67_1.hightColor2.b, var_70_10)

								iter_70_2.color = Color.New(var_70_11, var_70_12, var_70_13)
							else
								local var_70_14 = Mathf.Lerp(iter_70_2.color.r, 0.5, var_70_10)

								iter_70_2.color = Color.New(var_70_14, var_70_14, var_70_14)
							end
						end
					end
				end
			end

			if arg_67_1.time_ >= var_70_8 + var_70_9 and arg_67_1.time_ < var_70_8 + var_70_9 + arg_70_0 and not isNil(var_70_7) and arg_67_1.var_.actorSpriteComps1060 then
				for iter_70_3, iter_70_4 in pairs(arg_67_1.var_.actorSpriteComps1060:ToTable()) do
					if iter_70_4 then
						if arg_67_1.isInRecall_ then
							iter_70_4.color = arg_67_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_70_4.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_67_1.var_.actorSpriteComps1060 = nil
			end

			local var_70_15 = 0
			local var_70_16 = 1.525

			if var_70_15 < arg_67_1.time_ and arg_67_1.time_ <= var_70_15 + arg_70_0 then
				arg_67_1.talkMaxDuration = 0
				arg_67_1.dialogCg_.alpha = 1

				arg_67_1.dialog_:SetActive(true)
				SetActive(arg_67_1.leftNameGo_, false)

				arg_67_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_67_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_67_1:RecordName(arg_67_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_67_1.iconTrs_.gameObject, false)
				arg_67_1.callingController_:SetSelectedState("normal")

				local var_70_17 = arg_67_1:GetWordFromCfg(410251016)
				local var_70_18 = arg_67_1:FormatText(var_70_17.content)

				arg_67_1.text_.text = var_70_18

				LuaForUtil.ClearLinePrefixSymbol(arg_67_1.text_)

				local var_70_19 = 61
				local var_70_20 = utf8.len(var_70_18)
				local var_70_21 = var_70_19 <= 0 and var_70_16 or var_70_16 * (var_70_20 / var_70_19)

				if var_70_21 > 0 and var_70_16 < var_70_21 then
					arg_67_1.talkMaxDuration = var_70_21

					if var_70_21 + var_70_15 > arg_67_1.duration_ then
						arg_67_1.duration_ = var_70_21 + var_70_15
					end
				end

				arg_67_1.text_.text = var_70_18
				arg_67_1.typewritter.percent = 0

				arg_67_1.typewritter:SetDirty()
				arg_67_1:ShowNextGo(false)
				arg_67_1:RecordContent(arg_67_1.text_.text)
			end

			local var_70_22 = math.max(var_70_16, arg_67_1.talkMaxDuration)

			if var_70_15 <= arg_67_1.time_ and arg_67_1.time_ < var_70_15 + var_70_22 then
				arg_67_1.typewritter.percent = (arg_67_1.time_ - var_70_15) / var_70_22

				arg_67_1.typewritter:SetDirty()
			end

			if arg_67_1.time_ >= var_70_15 + var_70_22 and arg_67_1.time_ < var_70_15 + var_70_22 + arg_70_0 then
				arg_67_1.typewritter.percent = 1

				arg_67_1.typewritter:SetDirty()
				arg_67_1:ShowNextGo(true)
			end
		end

		arg_67_1.nodeConfigList_ = {
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

		arg_67_1:InitPlayNodeList()
	end,
	Play410251017 = function(arg_71_0, arg_71_1)
		arg_71_1.time_ = 0
		arg_71_1.frameCnt_ = 0
		arg_71_1.state_ = "playing"
		arg_71_1.curTalkId_ = 410251017
		arg_71_1.duration_ = 1.67

		local var_71_0 = {
			ja = 1.666,
			CriLanguages = 0.999999999999,
			zh = 0.999999999999
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
				arg_71_0:Play410251018(arg_71_1)
			end
		end

		function arg_71_1.onSingleLineUpdate_(arg_74_0)
			local var_74_0 = arg_71_1.actors_["1060"].transform
			local var_74_1 = 0

			if var_74_1 < arg_71_1.time_ and arg_71_1.time_ <= var_74_1 + arg_74_0 then
				arg_71_1.var_.moveOldPos1060 = var_74_0.localPosition
				var_74_0.localScale = Vector3.New(1, 1, 1)

				arg_71_1:CheckSpriteTmpPos("1060", 3)

				local var_74_2 = var_74_0.childCount

				for iter_74_0 = 0, var_74_2 - 1 do
					local var_74_3 = var_74_0:GetChild(iter_74_0)

					if var_74_3.name == "split_3" or not string.find(var_74_3.name, "split") then
						var_74_3.gameObject:SetActive(true)
					else
						var_74_3.gameObject:SetActive(false)
					end
				end
			end

			local var_74_4 = 0.001

			if var_74_1 <= arg_71_1.time_ and arg_71_1.time_ < var_74_1 + var_74_4 then
				local var_74_5 = (arg_71_1.time_ - var_74_1) / var_74_4
				local var_74_6 = Vector3.New(33.4, -430.8, 6.9)

				var_74_0.localPosition = Vector3.Lerp(arg_71_1.var_.moveOldPos1060, var_74_6, var_74_5)
			end

			if arg_71_1.time_ >= var_74_1 + var_74_4 and arg_71_1.time_ < var_74_1 + var_74_4 + arg_74_0 then
				var_74_0.localPosition = Vector3.New(33.4, -430.8, 6.9)
			end

			local var_74_7 = arg_71_1.actors_["1060"]
			local var_74_8 = 0

			if var_74_8 < arg_71_1.time_ and arg_71_1.time_ <= var_74_8 + arg_74_0 and not isNil(var_74_7) and arg_71_1.var_.actorSpriteComps1060 == nil then
				arg_71_1.var_.actorSpriteComps1060 = var_74_7:GetComponentsInChildren(typeof(Image), true)
			end

			local var_74_9 = 0.034

			if var_74_8 <= arg_71_1.time_ and arg_71_1.time_ < var_74_8 + var_74_9 and not isNil(var_74_7) then
				local var_74_10 = (arg_71_1.time_ - var_74_8) / var_74_9

				if arg_71_1.var_.actorSpriteComps1060 then
					for iter_74_1, iter_74_2 in pairs(arg_71_1.var_.actorSpriteComps1060:ToTable()) do
						if iter_74_2 then
							if arg_71_1.isInRecall_ then
								local var_74_11 = Mathf.Lerp(iter_74_2.color.r, arg_71_1.hightColor1.r, var_74_10)
								local var_74_12 = Mathf.Lerp(iter_74_2.color.g, arg_71_1.hightColor1.g, var_74_10)
								local var_74_13 = Mathf.Lerp(iter_74_2.color.b, arg_71_1.hightColor1.b, var_74_10)

								iter_74_2.color = Color.New(var_74_11, var_74_12, var_74_13)
							else
								local var_74_14 = Mathf.Lerp(iter_74_2.color.r, 1, var_74_10)

								iter_74_2.color = Color.New(var_74_14, var_74_14, var_74_14)
							end
						end
					end
				end
			end

			if arg_71_1.time_ >= var_74_8 + var_74_9 and arg_71_1.time_ < var_74_8 + var_74_9 + arg_74_0 and not isNil(var_74_7) and arg_71_1.var_.actorSpriteComps1060 then
				for iter_74_3, iter_74_4 in pairs(arg_71_1.var_.actorSpriteComps1060:ToTable()) do
					if iter_74_4 then
						if arg_71_1.isInRecall_ then
							iter_74_4.color = arg_71_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_74_4.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_71_1.var_.actorSpriteComps1060 = nil
			end

			local var_74_15 = 0
			local var_74_16 = 0.075

			if var_74_15 < arg_71_1.time_ and arg_71_1.time_ <= var_74_15 + arg_74_0 then
				arg_71_1.talkMaxDuration = 0
				arg_71_1.dialogCg_.alpha = 1

				arg_71_1.dialog_:SetActive(true)
				SetActive(arg_71_1.leftNameGo_, true)

				local var_74_17 = arg_71_1:FormatText(StoryNameCfg[584].name)

				arg_71_1.leftNameTxt_.text = var_74_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_71_1.leftNameTxt_.transform)

				arg_71_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_71_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_71_1:RecordName(arg_71_1.leftNameTxt_.text)
				SetActive(arg_71_1.iconTrs_.gameObject, false)
				arg_71_1.callingController_:SetSelectedState("normal")

				local var_74_18 = arg_71_1:GetWordFromCfg(410251017)
				local var_74_19 = arg_71_1:FormatText(var_74_18.content)

				arg_71_1.text_.text = var_74_19

				LuaForUtil.ClearLinePrefixSymbol(arg_71_1.text_)

				local var_74_20 = 3
				local var_74_21 = utf8.len(var_74_19)
				local var_74_22 = var_74_20 <= 0 and var_74_16 or var_74_16 * (var_74_21 / var_74_20)

				if var_74_22 > 0 and var_74_16 < var_74_22 then
					arg_71_1.talkMaxDuration = var_74_22

					if var_74_22 + var_74_15 > arg_71_1.duration_ then
						arg_71_1.duration_ = var_74_22 + var_74_15
					end
				end

				arg_71_1.text_.text = var_74_19
				arg_71_1.typewritter.percent = 0

				arg_71_1.typewritter:SetDirty()
				arg_71_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_410251", "410251017", "story_v_out_410251.awb") ~= 0 then
					local var_74_23 = manager.audio:GetVoiceLength("story_v_out_410251", "410251017", "story_v_out_410251.awb") / 1000

					if var_74_23 + var_74_15 > arg_71_1.duration_ then
						arg_71_1.duration_ = var_74_23 + var_74_15
					end

					if var_74_18.prefab_name ~= "" and arg_71_1.actors_[var_74_18.prefab_name] ~= nil then
						local var_74_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_71_1.actors_[var_74_18.prefab_name].transform, "story_v_out_410251", "410251017", "story_v_out_410251.awb")

						arg_71_1:RecordAudio("410251017", var_74_24)
						arg_71_1:RecordAudio("410251017", var_74_24)
					else
						arg_71_1:AudioAction("play", "voice", "story_v_out_410251", "410251017", "story_v_out_410251.awb")
					end

					arg_71_1:RecordHistoryTalkVoice("story_v_out_410251", "410251017", "story_v_out_410251.awb")
				end

				arg_71_1:RecordContent(arg_71_1.text_.text)
			end

			local var_74_25 = math.max(var_74_16, arg_71_1.talkMaxDuration)

			if var_74_15 <= arg_71_1.time_ and arg_71_1.time_ < var_74_15 + var_74_25 then
				arg_71_1.typewritter.percent = (arg_71_1.time_ - var_74_15) / var_74_25

				arg_71_1.typewritter:SetDirty()
			end

			if arg_71_1.time_ >= var_74_15 + var_74_25 and arg_71_1.time_ < var_74_15 + var_74_25 + arg_74_0 then
				arg_71_1.typewritter.percent = 1

				arg_71_1.typewritter:SetDirty()
				arg_71_1:ShowNextGo(true)
			end
		end

		arg_71_1.nodeConfigList_ = {
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

		arg_71_1:InitPlayNodeList()
	end,
	Play410251018 = function(arg_75_0, arg_75_1)
		arg_75_1.time_ = 0
		arg_75_1.frameCnt_ = 0
		arg_75_1.state_ = "playing"
		arg_75_1.curTalkId_ = 410251018
		arg_75_1.duration_ = 5

		SetActive(arg_75_1.tipsGo_, false)

		function arg_75_1.onSingleLineFinish_()
			arg_75_1.onSingleLineUpdate_ = nil
			arg_75_1.onSingleLineFinish_ = nil
			arg_75_1.state_ = "waiting"
		end

		function arg_75_1.playNext_(arg_77_0)
			if arg_77_0 == 1 then
				arg_75_0:Play410251019(arg_75_1)
			end
		end

		function arg_75_1.onSingleLineUpdate_(arg_78_0)
			local var_78_0 = arg_75_1.actors_["1060"].transform
			local var_78_1 = 0

			if var_78_1 < arg_75_1.time_ and arg_75_1.time_ <= var_78_1 + arg_78_0 then
				arg_75_1.var_.moveOldPos1060 = var_78_0.localPosition
				var_78_0.localScale = Vector3.New(1, 1, 1)

				arg_75_1:CheckSpriteTmpPos("1060", 7)

				local var_78_2 = var_78_0.childCount

				for iter_78_0 = 0, var_78_2 - 1 do
					local var_78_3 = var_78_0:GetChild(iter_78_0)

					if var_78_3.name == "" or not string.find(var_78_3.name, "split") then
						var_78_3.gameObject:SetActive(true)
					else
						var_78_3.gameObject:SetActive(false)
					end
				end
			end

			local var_78_4 = 0.001

			if var_78_1 <= arg_75_1.time_ and arg_75_1.time_ < var_78_1 + var_78_4 then
				local var_78_5 = (arg_75_1.time_ - var_78_1) / var_78_4
				local var_78_6 = Vector3.New(0, -2000, -40)

				var_78_0.localPosition = Vector3.Lerp(arg_75_1.var_.moveOldPos1060, var_78_6, var_78_5)
			end

			if arg_75_1.time_ >= var_78_1 + var_78_4 and arg_75_1.time_ < var_78_1 + var_78_4 + arg_78_0 then
				var_78_0.localPosition = Vector3.New(0, -2000, -40)
			end

			local var_78_7 = arg_75_1.actors_["1060"]
			local var_78_8 = 0

			if var_78_8 < arg_75_1.time_ and arg_75_1.time_ <= var_78_8 + arg_78_0 and not isNil(var_78_7) and arg_75_1.var_.actorSpriteComps1060 == nil then
				arg_75_1.var_.actorSpriteComps1060 = var_78_7:GetComponentsInChildren(typeof(Image), true)
			end

			local var_78_9 = 0.034

			if var_78_8 <= arg_75_1.time_ and arg_75_1.time_ < var_78_8 + var_78_9 and not isNil(var_78_7) then
				local var_78_10 = (arg_75_1.time_ - var_78_8) / var_78_9

				if arg_75_1.var_.actorSpriteComps1060 then
					for iter_78_1, iter_78_2 in pairs(arg_75_1.var_.actorSpriteComps1060:ToTable()) do
						if iter_78_2 then
							if arg_75_1.isInRecall_ then
								local var_78_11 = Mathf.Lerp(iter_78_2.color.r, arg_75_1.hightColor2.r, var_78_10)
								local var_78_12 = Mathf.Lerp(iter_78_2.color.g, arg_75_1.hightColor2.g, var_78_10)
								local var_78_13 = Mathf.Lerp(iter_78_2.color.b, arg_75_1.hightColor2.b, var_78_10)

								iter_78_2.color = Color.New(var_78_11, var_78_12, var_78_13)
							else
								local var_78_14 = Mathf.Lerp(iter_78_2.color.r, 0.5, var_78_10)

								iter_78_2.color = Color.New(var_78_14, var_78_14, var_78_14)
							end
						end
					end
				end
			end

			if arg_75_1.time_ >= var_78_8 + var_78_9 and arg_75_1.time_ < var_78_8 + var_78_9 + arg_78_0 and not isNil(var_78_7) and arg_75_1.var_.actorSpriteComps1060 then
				for iter_78_3, iter_78_4 in pairs(arg_75_1.var_.actorSpriteComps1060:ToTable()) do
					if iter_78_4 then
						if arg_75_1.isInRecall_ then
							iter_78_4.color = arg_75_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_78_4.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_75_1.var_.actorSpriteComps1060 = nil
			end

			local var_78_15 = 0
			local var_78_16 = 1.05

			if var_78_15 < arg_75_1.time_ and arg_75_1.time_ <= var_78_15 + arg_78_0 then
				arg_75_1.talkMaxDuration = 0
				arg_75_1.dialogCg_.alpha = 1

				arg_75_1.dialog_:SetActive(true)
				SetActive(arg_75_1.leftNameGo_, false)

				arg_75_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_75_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_75_1:RecordName(arg_75_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_75_1.iconTrs_.gameObject, false)
				arg_75_1.callingController_:SetSelectedState("normal")

				local var_78_17 = arg_75_1:GetWordFromCfg(410251018)
				local var_78_18 = arg_75_1:FormatText(var_78_17.content)

				arg_75_1.text_.text = var_78_18

				LuaForUtil.ClearLinePrefixSymbol(arg_75_1.text_)

				local var_78_19 = 42
				local var_78_20 = utf8.len(var_78_18)
				local var_78_21 = var_78_19 <= 0 and var_78_16 or var_78_16 * (var_78_20 / var_78_19)

				if var_78_21 > 0 and var_78_16 < var_78_21 then
					arg_75_1.talkMaxDuration = var_78_21

					if var_78_21 + var_78_15 > arg_75_1.duration_ then
						arg_75_1.duration_ = var_78_21 + var_78_15
					end
				end

				arg_75_1.text_.text = var_78_18
				arg_75_1.typewritter.percent = 0

				arg_75_1.typewritter:SetDirty()
				arg_75_1:ShowNextGo(false)
				arg_75_1:RecordContent(arg_75_1.text_.text)
			end

			local var_78_22 = math.max(var_78_16, arg_75_1.talkMaxDuration)

			if var_78_15 <= arg_75_1.time_ and arg_75_1.time_ < var_78_15 + var_78_22 then
				arg_75_1.typewritter.percent = (arg_75_1.time_ - var_78_15) / var_78_22

				arg_75_1.typewritter:SetDirty()
			end

			if arg_75_1.time_ >= var_78_15 + var_78_22 and arg_75_1.time_ < var_78_15 + var_78_22 + arg_78_0 then
				arg_75_1.typewritter.percent = 1

				arg_75_1.typewritter:SetDirty()
				arg_75_1:ShowNextGo(true)
			end
		end

		arg_75_1.nodeConfigList_ = {
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

		arg_75_1:InitPlayNodeList()
	end,
	Play410251019 = function(arg_79_0, arg_79_1)
		arg_79_1.time_ = 0
		arg_79_1.frameCnt_ = 0
		arg_79_1.state_ = "playing"
		arg_79_1.curTalkId_ = 410251019
		arg_79_1.duration_ = 5

		SetActive(arg_79_1.tipsGo_, false)

		function arg_79_1.onSingleLineFinish_()
			arg_79_1.onSingleLineUpdate_ = nil
			arg_79_1.onSingleLineFinish_ = nil
			arg_79_1.state_ = "waiting"
		end

		function arg_79_1.playNext_(arg_81_0)
			if arg_81_0 == 1 then
				arg_79_0:Play410251020(arg_79_1)
			end
		end

		function arg_79_1.onSingleLineUpdate_(arg_82_0)
			local var_82_0 = 0
			local var_82_1 = 0.975

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

				local var_82_2 = arg_79_1:GetWordFromCfg(410251019)
				local var_82_3 = arg_79_1:FormatText(var_82_2.content)

				arg_79_1.text_.text = var_82_3

				LuaForUtil.ClearLinePrefixSymbol(arg_79_1.text_)

				local var_82_4 = 39
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
	Play410251020 = function(arg_83_0, arg_83_1)
		arg_83_1.time_ = 0
		arg_83_1.frameCnt_ = 0
		arg_83_1.state_ = "playing"
		arg_83_1.curTalkId_ = 410251020
		arg_83_1.duration_ = 8.1

		local var_83_0 = {
			ja = 8.1,
			CriLanguages = 6.166,
			zh = 6.166
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
				arg_83_0:Play410251021(arg_83_1)
			end
		end

		function arg_83_1.onSingleLineUpdate_(arg_86_0)
			local var_86_0 = 2

			if var_86_0 < arg_83_1.time_ and arg_83_1.time_ <= var_86_0 + arg_86_0 then
				local var_86_1 = manager.ui.mainCamera.transform.localPosition
				local var_86_2 = Vector3.New(0, 0, 10) + Vector3.New(var_86_1.x, var_86_1.y, 0)
				local var_86_3 = arg_83_1.bgs_.L04h

				var_86_3.transform.localPosition = var_86_2
				var_86_3.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_86_4 = var_86_3:GetComponent("SpriteRenderer")

				if var_86_4 and var_86_4.sprite then
					local var_86_5 = (var_86_3.transform.localPosition - var_86_1).z
					local var_86_6 = manager.ui.mainCameraCom_
					local var_86_7 = 2 * var_86_5 * Mathf.Tan(var_86_6.fieldOfView * 0.5 * Mathf.Deg2Rad)
					local var_86_8 = var_86_7 * var_86_6.aspect
					local var_86_9 = var_86_4.sprite.bounds.size.x
					local var_86_10 = var_86_4.sprite.bounds.size.y
					local var_86_11 = var_86_8 / var_86_9
					local var_86_12 = var_86_7 / var_86_10
					local var_86_13 = var_86_12 < var_86_11 and var_86_11 or var_86_12

					var_86_3.transform.localScale = Vector3.New(var_86_13, var_86_13, 0)
				end

				for iter_86_0, iter_86_1 in pairs(arg_83_1.bgs_) do
					if iter_86_0 ~= "L04h" then
						iter_86_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_86_14 = 0

			if var_86_14 < arg_83_1.time_ and arg_83_1.time_ <= var_86_14 + arg_86_0 then
				arg_83_1.mask_.enabled = true
				arg_83_1.mask_.raycastTarget = true

				arg_83_1:SetGaussion(false)
			end

			local var_86_15 = 2

			if var_86_14 <= arg_83_1.time_ and arg_83_1.time_ < var_86_14 + var_86_15 then
				local var_86_16 = (arg_83_1.time_ - var_86_14) / var_86_15
				local var_86_17 = Color.New(0, 0, 0)

				var_86_17.a = Mathf.Lerp(0, 1, var_86_16)
				arg_83_1.mask_.color = var_86_17
			end

			if arg_83_1.time_ >= var_86_14 + var_86_15 and arg_83_1.time_ < var_86_14 + var_86_15 + arg_86_0 then
				local var_86_18 = Color.New(0, 0, 0)

				var_86_18.a = 1
				arg_83_1.mask_.color = var_86_18
			end

			local var_86_19 = 2

			if var_86_19 < arg_83_1.time_ and arg_83_1.time_ <= var_86_19 + arg_86_0 then
				arg_83_1.mask_.enabled = true
				arg_83_1.mask_.raycastTarget = true

				arg_83_1:SetGaussion(false)
			end

			local var_86_20 = 2

			if var_86_19 <= arg_83_1.time_ and arg_83_1.time_ < var_86_19 + var_86_20 then
				local var_86_21 = (arg_83_1.time_ - var_86_19) / var_86_20
				local var_86_22 = Color.New(0, 0, 0)

				var_86_22.a = Mathf.Lerp(1, 0, var_86_21)
				arg_83_1.mask_.color = var_86_22
			end

			if arg_83_1.time_ >= var_86_19 + var_86_20 and arg_83_1.time_ < var_86_19 + var_86_20 + arg_86_0 then
				local var_86_23 = Color.New(0, 0, 0)
				local var_86_24 = 0

				arg_83_1.mask_.enabled = false
				var_86_23.a = var_86_24
				arg_83_1.mask_.color = var_86_23
			end

			local var_86_25 = "10062"

			if arg_83_1.actors_[var_86_25] == nil then
				local var_86_26 = Asset.Load("Widget/System/Story/StoryExpression/" .. "10062")

				if not isNil(var_86_26) then
					local var_86_27 = Object.Instantiate(var_86_26, arg_83_1.canvasGo_.transform)

					var_86_27.transform:SetSiblingIndex(1)

					var_86_27.name = var_86_25
					var_86_27.transform.localPosition = Vector3.New(0, 100000, 0)
					arg_83_1.actors_[var_86_25] = var_86_27

					local var_86_28 = var_86_27:GetComponentsInChildren(typeof(Image), true):ToTable()

					if arg_83_1.isInRecall_ then
						for iter_86_2, iter_86_3 in ipairs(var_86_28) do
							iter_86_3.color = arg_83_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						end
					end
				end
			end

			local var_86_29 = arg_83_1.actors_["10062"].transform
			local var_86_30 = 4

			if var_86_30 < arg_83_1.time_ and arg_83_1.time_ <= var_86_30 + arg_86_0 then
				arg_83_1.var_.moveOldPos10062 = var_86_29.localPosition
				var_86_29.localScale = Vector3.New(1, 1, 1)

				arg_83_1:CheckSpriteTmpPos("10062", 3)

				local var_86_31 = var_86_29.childCount

				for iter_86_4 = 0, var_86_31 - 1 do
					local var_86_32 = var_86_29:GetChild(iter_86_4)

					if var_86_32.name == "" or not string.find(var_86_32.name, "split") then
						var_86_32.gameObject:SetActive(true)
					else
						var_86_32.gameObject:SetActive(false)
					end
				end
			end

			local var_86_33 = 0.001

			if var_86_30 <= arg_83_1.time_ and arg_83_1.time_ < var_86_30 + var_86_33 then
				local var_86_34 = (arg_83_1.time_ - var_86_30) / var_86_33
				local var_86_35 = Vector3.New(0, -390, -290)

				var_86_29.localPosition = Vector3.Lerp(arg_83_1.var_.moveOldPos10062, var_86_35, var_86_34)
			end

			if arg_83_1.time_ >= var_86_30 + var_86_33 and arg_83_1.time_ < var_86_30 + var_86_33 + arg_86_0 then
				var_86_29.localPosition = Vector3.New(0, -390, -290)
			end

			local var_86_36 = arg_83_1.actors_["10062"]
			local var_86_37 = 4

			if var_86_37 < arg_83_1.time_ and arg_83_1.time_ <= var_86_37 + arg_86_0 and not isNil(var_86_36) and arg_83_1.var_.actorSpriteComps10062 == nil then
				arg_83_1.var_.actorSpriteComps10062 = var_86_36:GetComponentsInChildren(typeof(Image), true)
			end

			local var_86_38 = 0.034

			if var_86_37 <= arg_83_1.time_ and arg_83_1.time_ < var_86_37 + var_86_38 and not isNil(var_86_36) then
				local var_86_39 = (arg_83_1.time_ - var_86_37) / var_86_38

				if arg_83_1.var_.actorSpriteComps10062 then
					for iter_86_5, iter_86_6 in pairs(arg_83_1.var_.actorSpriteComps10062:ToTable()) do
						if iter_86_6 then
							if arg_83_1.isInRecall_ then
								local var_86_40 = Mathf.Lerp(iter_86_6.color.r, arg_83_1.hightColor1.r, var_86_39)
								local var_86_41 = Mathf.Lerp(iter_86_6.color.g, arg_83_1.hightColor1.g, var_86_39)
								local var_86_42 = Mathf.Lerp(iter_86_6.color.b, arg_83_1.hightColor1.b, var_86_39)

								iter_86_6.color = Color.New(var_86_40, var_86_41, var_86_42)
							else
								local var_86_43 = Mathf.Lerp(iter_86_6.color.r, 1, var_86_39)

								iter_86_6.color = Color.New(var_86_43, var_86_43, var_86_43)
							end
						end
					end
				end
			end

			if arg_83_1.time_ >= var_86_37 + var_86_38 and arg_83_1.time_ < var_86_37 + var_86_38 + arg_86_0 and not isNil(var_86_36) and arg_83_1.var_.actorSpriteComps10062 then
				for iter_86_7, iter_86_8 in pairs(arg_83_1.var_.actorSpriteComps10062:ToTable()) do
					if iter_86_8 then
						if arg_83_1.isInRecall_ then
							iter_86_8.color = arg_83_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_86_8.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_83_1.var_.actorSpriteComps10062 = nil
			end

			if arg_83_1.frameCnt_ <= 1 then
				arg_83_1.dialog_:SetActive(false)
			end

			local var_86_44 = 4
			local var_86_45 = 0.125

			if var_86_44 < arg_83_1.time_ and arg_83_1.time_ <= var_86_44 + arg_86_0 then
				arg_83_1.talkMaxDuration = 0

				arg_83_1.dialog_:SetActive(true)

				arg_83_1.dialogCg_.alpha = 0

				local var_86_46 = LeanTween.value(arg_83_1.dialog_, 0, 1, 0.3)

				var_86_46:setOnUpdate(LuaHelper.FloatAction(function(arg_87_0)
					arg_83_1.dialogCg_.alpha = arg_87_0
				end))
				var_86_46:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_83_1.dialog_)
					var_86_46:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_83_1.duration_ = arg_83_1.duration_ + 0.3

				SetActive(arg_83_1.leftNameGo_, true)

				local var_86_47 = arg_83_1:FormatText(StoryNameCfg[600].name)

				arg_83_1.leftNameTxt_.text = var_86_47

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_83_1.leftNameTxt_.transform)

				arg_83_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_83_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_83_1:RecordName(arg_83_1.leftNameTxt_.text)
				SetActive(arg_83_1.iconTrs_.gameObject, false)
				arg_83_1.callingController_:SetSelectedState("normal")

				local var_86_48 = arg_83_1:GetWordFromCfg(410251020)
				local var_86_49 = arg_83_1:FormatText(var_86_48.content)

				arg_83_1.text_.text = var_86_49

				LuaForUtil.ClearLinePrefixSymbol(arg_83_1.text_)

				local var_86_50 = 5
				local var_86_51 = utf8.len(var_86_49)
				local var_86_52 = var_86_50 <= 0 and var_86_45 or var_86_45 * (var_86_51 / var_86_50)

				if var_86_52 > 0 and var_86_45 < var_86_52 then
					arg_83_1.talkMaxDuration = var_86_52
					var_86_44 = var_86_44 + 0.3

					if var_86_52 + var_86_44 > arg_83_1.duration_ then
						arg_83_1.duration_ = var_86_52 + var_86_44
					end
				end

				arg_83_1.text_.text = var_86_49
				arg_83_1.typewritter.percent = 0

				arg_83_1.typewritter:SetDirty()
				arg_83_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_410251", "410251020", "story_v_out_410251.awb") ~= 0 then
					local var_86_53 = manager.audio:GetVoiceLength("story_v_out_410251", "410251020", "story_v_out_410251.awb") / 1000

					if var_86_53 + var_86_44 > arg_83_1.duration_ then
						arg_83_1.duration_ = var_86_53 + var_86_44
					end

					if var_86_48.prefab_name ~= "" and arg_83_1.actors_[var_86_48.prefab_name] ~= nil then
						local var_86_54 = LuaForUtil.PlayVoiceWithCriLipsync(arg_83_1.actors_[var_86_48.prefab_name].transform, "story_v_out_410251", "410251020", "story_v_out_410251.awb")

						arg_83_1:RecordAudio("410251020", var_86_54)
						arg_83_1:RecordAudio("410251020", var_86_54)
					else
						arg_83_1:AudioAction("play", "voice", "story_v_out_410251", "410251020", "story_v_out_410251.awb")
					end

					arg_83_1:RecordHistoryTalkVoice("story_v_out_410251", "410251020", "story_v_out_410251.awb")
				end

				arg_83_1:RecordContent(arg_83_1.text_.text)
			end

			local var_86_55 = var_86_44 + 0.3
			local var_86_56 = math.max(var_86_45, arg_83_1.talkMaxDuration)

			if var_86_55 <= arg_83_1.time_ and arg_83_1.time_ < var_86_55 + var_86_56 then
				arg_83_1.typewritter.percent = (arg_83_1.time_ - var_86_55) / var_86_56

				arg_83_1.typewritter:SetDirty()
			end

			if arg_83_1.time_ >= var_86_55 + var_86_56 and arg_83_1.time_ < var_86_55 + var_86_56 + arg_86_0 then
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
				startTime = 4,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_83_1:InitPlayNodeList()
	end,
	Play410251021 = function(arg_89_0, arg_89_1)
		arg_89_1.time_ = 0
		arg_89_1.frameCnt_ = 0
		arg_89_1.state_ = "playing"
		arg_89_1.curTalkId_ = 410251021
		arg_89_1.duration_ = 3.07

		local var_89_0 = {
			ja = 2.1,
			CriLanguages = 3.066,
			zh = 3.066
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
				arg_89_0:Play410251022(arg_89_1)
			end
		end

		function arg_89_1.onSingleLineUpdate_(arg_92_0)
			local var_92_0 = arg_89_1.actors_["10062"].transform
			local var_92_1 = 0

			if var_92_1 < arg_89_1.time_ and arg_89_1.time_ <= var_92_1 + arg_92_0 then
				arg_89_1.var_.moveOldPos10062 = var_92_0.localPosition
				var_92_0.localScale = Vector3.New(1, 1, 1)

				arg_89_1:CheckSpriteTmpPos("10062", 7)

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
				local var_92_6 = Vector3.New(0, -2000, -290)

				var_92_0.localPosition = Vector3.Lerp(arg_89_1.var_.moveOldPos10062, var_92_6, var_92_5)
			end

			if arg_89_1.time_ >= var_92_1 + var_92_4 and arg_89_1.time_ < var_92_1 + var_92_4 + arg_92_0 then
				var_92_0.localPosition = Vector3.New(0, -2000, -290)
			end

			local var_92_7 = "1061"

			if arg_89_1.actors_[var_92_7] == nil then
				local var_92_8 = Asset.Load("Widget/System/Story/StoryExpression/" .. "1061")

				if not isNil(var_92_8) then
					local var_92_9 = Object.Instantiate(var_92_8, arg_89_1.canvasGo_.transform)

					var_92_9.transform:SetSiblingIndex(1)

					var_92_9.name = var_92_7
					var_92_9.transform.localPosition = Vector3.New(0, 100000, 0)
					arg_89_1.actors_[var_92_7] = var_92_9

					local var_92_10 = var_92_9:GetComponentsInChildren(typeof(Image), true):ToTable()

					if arg_89_1.isInRecall_ then
						for iter_92_1, iter_92_2 in ipairs(var_92_10) do
							iter_92_2.color = arg_89_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						end
					end
				end
			end

			local var_92_11 = arg_89_1.actors_["1061"].transform
			local var_92_12 = 0

			if var_92_12 < arg_89_1.time_ and arg_89_1.time_ <= var_92_12 + arg_92_0 then
				arg_89_1.var_.moveOldPos1061 = var_92_11.localPosition
				var_92_11.localScale = Vector3.New(1, 1, 1)

				arg_89_1:CheckSpriteTmpPos("1061", 3)

				local var_92_13 = var_92_11.childCount

				for iter_92_3 = 0, var_92_13 - 1 do
					local var_92_14 = var_92_11:GetChild(iter_92_3)

					if var_92_14.name == "split_7" or not string.find(var_92_14.name, "split") then
						var_92_14.gameObject:SetActive(true)
					else
						var_92_14.gameObject:SetActive(false)
					end
				end
			end

			local var_92_15 = 0.001

			if var_92_12 <= arg_89_1.time_ and arg_89_1.time_ < var_92_12 + var_92_15 then
				local var_92_16 = (arg_89_1.time_ - var_92_12) / var_92_15
				local var_92_17 = Vector3.New(0, -490, 18)

				var_92_11.localPosition = Vector3.Lerp(arg_89_1.var_.moveOldPos1061, var_92_17, var_92_16)
			end

			if arg_89_1.time_ >= var_92_12 + var_92_15 and arg_89_1.time_ < var_92_12 + var_92_15 + arg_92_0 then
				var_92_11.localPosition = Vector3.New(0, -490, 18)
			end

			local var_92_18 = arg_89_1.actors_["10062"]
			local var_92_19 = 0

			if var_92_19 < arg_89_1.time_ and arg_89_1.time_ <= var_92_19 + arg_92_0 and not isNil(var_92_18) and arg_89_1.var_.actorSpriteComps10062 == nil then
				arg_89_1.var_.actorSpriteComps10062 = var_92_18:GetComponentsInChildren(typeof(Image), true)
			end

			local var_92_20 = 0.034

			if var_92_19 <= arg_89_1.time_ and arg_89_1.time_ < var_92_19 + var_92_20 and not isNil(var_92_18) then
				local var_92_21 = (arg_89_1.time_ - var_92_19) / var_92_20

				if arg_89_1.var_.actorSpriteComps10062 then
					for iter_92_4, iter_92_5 in pairs(arg_89_1.var_.actorSpriteComps10062:ToTable()) do
						if iter_92_5 then
							if arg_89_1.isInRecall_ then
								local var_92_22 = Mathf.Lerp(iter_92_5.color.r, arg_89_1.hightColor2.r, var_92_21)
								local var_92_23 = Mathf.Lerp(iter_92_5.color.g, arg_89_1.hightColor2.g, var_92_21)
								local var_92_24 = Mathf.Lerp(iter_92_5.color.b, arg_89_1.hightColor2.b, var_92_21)

								iter_92_5.color = Color.New(var_92_22, var_92_23, var_92_24)
							else
								local var_92_25 = Mathf.Lerp(iter_92_5.color.r, 0.5, var_92_21)

								iter_92_5.color = Color.New(var_92_25, var_92_25, var_92_25)
							end
						end
					end
				end
			end

			if arg_89_1.time_ >= var_92_19 + var_92_20 and arg_89_1.time_ < var_92_19 + var_92_20 + arg_92_0 and not isNil(var_92_18) and arg_89_1.var_.actorSpriteComps10062 then
				for iter_92_6, iter_92_7 in pairs(arg_89_1.var_.actorSpriteComps10062:ToTable()) do
					if iter_92_7 then
						if arg_89_1.isInRecall_ then
							iter_92_7.color = arg_89_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_92_7.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_89_1.var_.actorSpriteComps10062 = nil
			end

			local var_92_26 = arg_89_1.actors_["1061"]
			local var_92_27 = 0

			if var_92_27 < arg_89_1.time_ and arg_89_1.time_ <= var_92_27 + arg_92_0 and not isNil(var_92_26) and arg_89_1.var_.actorSpriteComps1061 == nil then
				arg_89_1.var_.actorSpriteComps1061 = var_92_26:GetComponentsInChildren(typeof(Image), true)
			end

			local var_92_28 = 0.034

			if var_92_27 <= arg_89_1.time_ and arg_89_1.time_ < var_92_27 + var_92_28 and not isNil(var_92_26) then
				local var_92_29 = (arg_89_1.time_ - var_92_27) / var_92_28

				if arg_89_1.var_.actorSpriteComps1061 then
					for iter_92_8, iter_92_9 in pairs(arg_89_1.var_.actorSpriteComps1061:ToTable()) do
						if iter_92_9 then
							if arg_89_1.isInRecall_ then
								local var_92_30 = Mathf.Lerp(iter_92_9.color.r, arg_89_1.hightColor1.r, var_92_29)
								local var_92_31 = Mathf.Lerp(iter_92_9.color.g, arg_89_1.hightColor1.g, var_92_29)
								local var_92_32 = Mathf.Lerp(iter_92_9.color.b, arg_89_1.hightColor1.b, var_92_29)

								iter_92_9.color = Color.New(var_92_30, var_92_31, var_92_32)
							else
								local var_92_33 = Mathf.Lerp(iter_92_9.color.r, 1, var_92_29)

								iter_92_9.color = Color.New(var_92_33, var_92_33, var_92_33)
							end
						end
					end
				end
			end

			if arg_89_1.time_ >= var_92_27 + var_92_28 and arg_89_1.time_ < var_92_27 + var_92_28 + arg_92_0 and not isNil(var_92_26) and arg_89_1.var_.actorSpriteComps1061 then
				for iter_92_10, iter_92_11 in pairs(arg_89_1.var_.actorSpriteComps1061:ToTable()) do
					if iter_92_11 then
						if arg_89_1.isInRecall_ then
							iter_92_11.color = arg_89_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_92_11.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_89_1.var_.actorSpriteComps1061 = nil
			end

			local var_92_34 = 0
			local var_92_35 = 0.175

			if var_92_34 < arg_89_1.time_ and arg_89_1.time_ <= var_92_34 + arg_92_0 then
				arg_89_1.talkMaxDuration = 0
				arg_89_1.dialogCg_.alpha = 1

				arg_89_1.dialog_:SetActive(true)
				SetActive(arg_89_1.leftNameGo_, true)

				local var_92_36 = arg_89_1:FormatText(StoryNameCfg[612].name)

				arg_89_1.leftNameTxt_.text = var_92_36

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_89_1.leftNameTxt_.transform)

				arg_89_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_89_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_89_1:RecordName(arg_89_1.leftNameTxt_.text)
				SetActive(arg_89_1.iconTrs_.gameObject, false)
				arg_89_1.callingController_:SetSelectedState("normal")

				local var_92_37 = arg_89_1:GetWordFromCfg(410251021)
				local var_92_38 = arg_89_1:FormatText(var_92_37.content)

				arg_89_1.text_.text = var_92_38

				LuaForUtil.ClearLinePrefixSymbol(arg_89_1.text_)

				local var_92_39 = 7
				local var_92_40 = utf8.len(var_92_38)
				local var_92_41 = var_92_39 <= 0 and var_92_35 or var_92_35 * (var_92_40 / var_92_39)

				if var_92_41 > 0 and var_92_35 < var_92_41 then
					arg_89_1.talkMaxDuration = var_92_41

					if var_92_41 + var_92_34 > arg_89_1.duration_ then
						arg_89_1.duration_ = var_92_41 + var_92_34
					end
				end

				arg_89_1.text_.text = var_92_38
				arg_89_1.typewritter.percent = 0

				arg_89_1.typewritter:SetDirty()
				arg_89_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_410251", "410251021", "story_v_out_410251.awb") ~= 0 then
					local var_92_42 = manager.audio:GetVoiceLength("story_v_out_410251", "410251021", "story_v_out_410251.awb") / 1000

					if var_92_42 + var_92_34 > arg_89_1.duration_ then
						arg_89_1.duration_ = var_92_42 + var_92_34
					end

					if var_92_37.prefab_name ~= "" and arg_89_1.actors_[var_92_37.prefab_name] ~= nil then
						local var_92_43 = LuaForUtil.PlayVoiceWithCriLipsync(arg_89_1.actors_[var_92_37.prefab_name].transform, "story_v_out_410251", "410251021", "story_v_out_410251.awb")

						arg_89_1:RecordAudio("410251021", var_92_43)
						arg_89_1:RecordAudio("410251021", var_92_43)
					else
						arg_89_1:AudioAction("play", "voice", "story_v_out_410251", "410251021", "story_v_out_410251.awb")
					end

					arg_89_1:RecordHistoryTalkVoice("story_v_out_410251", "410251021", "story_v_out_410251.awb")
				end

				arg_89_1:RecordContent(arg_89_1.text_.text)
			end

			local var_92_44 = math.max(var_92_35, arg_89_1.talkMaxDuration)

			if var_92_34 <= arg_89_1.time_ and arg_89_1.time_ < var_92_34 + var_92_44 then
				arg_89_1.typewritter.percent = (arg_89_1.time_ - var_92_34) / var_92_44

				arg_89_1.typewritter:SetDirty()
			end

			if arg_89_1.time_ >= var_92_34 + var_92_44 and arg_89_1.time_ < var_92_34 + var_92_44 + arg_92_0 then
				arg_89_1.typewritter.percent = 1

				arg_89_1.typewritter:SetDirty()
				arg_89_1:ShowNextGo(true)
			end
		end

		arg_89_1.nodeConfigList_ = {
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
				actorName = "1061",
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
	Play410251022 = function(arg_93_0, arg_93_1)
		arg_93_1.time_ = 0
		arg_93_1.frameCnt_ = 0
		arg_93_1.state_ = "playing"
		arg_93_1.curTalkId_ = 410251022
		arg_93_1.duration_ = 5

		SetActive(arg_93_1.tipsGo_, false)

		function arg_93_1.onSingleLineFinish_()
			arg_93_1.onSingleLineUpdate_ = nil
			arg_93_1.onSingleLineFinish_ = nil
			arg_93_1.state_ = "waiting"
		end

		function arg_93_1.playNext_(arg_95_0)
			if arg_95_0 == 1 then
				arg_93_0:Play410251023(arg_93_1)
			end
		end

		function arg_93_1.onSingleLineUpdate_(arg_96_0)
			local var_96_0 = arg_93_1.actors_["1061"]
			local var_96_1 = 0

			if var_96_1 < arg_93_1.time_ and arg_93_1.time_ <= var_96_1 + arg_96_0 and not isNil(var_96_0) and arg_93_1.var_.actorSpriteComps1061 == nil then
				arg_93_1.var_.actorSpriteComps1061 = var_96_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_96_2 = 0.034

			if var_96_1 <= arg_93_1.time_ and arg_93_1.time_ < var_96_1 + var_96_2 and not isNil(var_96_0) then
				local var_96_3 = (arg_93_1.time_ - var_96_1) / var_96_2

				if arg_93_1.var_.actorSpriteComps1061 then
					for iter_96_0, iter_96_1 in pairs(arg_93_1.var_.actorSpriteComps1061:ToTable()) do
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

			if arg_93_1.time_ >= var_96_1 + var_96_2 and arg_93_1.time_ < var_96_1 + var_96_2 + arg_96_0 and not isNil(var_96_0) and arg_93_1.var_.actorSpriteComps1061 then
				for iter_96_2, iter_96_3 in pairs(arg_93_1.var_.actorSpriteComps1061:ToTable()) do
					if iter_96_3 then
						if arg_93_1.isInRecall_ then
							iter_96_3.color = arg_93_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_96_3.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_93_1.var_.actorSpriteComps1061 = nil
			end

			local var_96_8 = 0
			local var_96_9 = 1.525

			if var_96_8 < arg_93_1.time_ and arg_93_1.time_ <= var_96_8 + arg_96_0 then
				arg_93_1.talkMaxDuration = 0
				arg_93_1.dialogCg_.alpha = 1

				arg_93_1.dialog_:SetActive(true)
				SetActive(arg_93_1.leftNameGo_, false)

				arg_93_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_93_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_93_1:RecordName(arg_93_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_93_1.iconTrs_.gameObject, false)
				arg_93_1.callingController_:SetSelectedState("normal")

				local var_96_10 = arg_93_1:GetWordFromCfg(410251022)
				local var_96_11 = arg_93_1:FormatText(var_96_10.content)

				arg_93_1.text_.text = var_96_11

				LuaForUtil.ClearLinePrefixSymbol(arg_93_1.text_)

				local var_96_12 = 61
				local var_96_13 = utf8.len(var_96_11)
				local var_96_14 = var_96_12 <= 0 and var_96_9 or var_96_9 * (var_96_13 / var_96_12)

				if var_96_14 > 0 and var_96_9 < var_96_14 then
					arg_93_1.talkMaxDuration = var_96_14

					if var_96_14 + var_96_8 > arg_93_1.duration_ then
						arg_93_1.duration_ = var_96_14 + var_96_8
					end
				end

				arg_93_1.text_.text = var_96_11
				arg_93_1.typewritter.percent = 0

				arg_93_1.typewritter:SetDirty()
				arg_93_1:ShowNextGo(false)
				arg_93_1:RecordContent(arg_93_1.text_.text)
			end

			local var_96_15 = math.max(var_96_9, arg_93_1.talkMaxDuration)

			if var_96_8 <= arg_93_1.time_ and arg_93_1.time_ < var_96_8 + var_96_15 then
				arg_93_1.typewritter.percent = (arg_93_1.time_ - var_96_8) / var_96_15

				arg_93_1.typewritter:SetDirty()
			end

			if arg_93_1.time_ >= var_96_8 + var_96_15 and arg_93_1.time_ < var_96_8 + var_96_15 + arg_96_0 then
				arg_93_1.typewritter.percent = 1

				arg_93_1.typewritter:SetDirty()
				arg_93_1:ShowNextGo(true)
			end
		end

		arg_93_1.nodeConfigList_ = {}

		arg_93_1:InitPlayNodeList()
	end,
	Play410251023 = function(arg_97_0, arg_97_1)
		arg_97_1.time_ = 0
		arg_97_1.frameCnt_ = 0
		arg_97_1.state_ = "playing"
		arg_97_1.curTalkId_ = 410251023
		arg_97_1.duration_ = 10.03

		local var_97_0 = {
			ja = 10.033,
			CriLanguages = 5.533,
			zh = 5.533
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
				arg_97_0:Play410251024(arg_97_1)
			end
		end

		function arg_97_1.onSingleLineUpdate_(arg_100_0)
			local var_100_0 = arg_97_1.actors_["1061"].transform
			local var_100_1 = 0

			if var_100_1 < arg_97_1.time_ and arg_97_1.time_ <= var_100_1 + arg_100_0 then
				arg_97_1.var_.moveOldPos1061 = var_100_0.localPosition
				var_100_0.localScale = Vector3.New(1, 1, 1)

				arg_97_1:CheckSpriteTmpPos("1061", 3)

				local var_100_2 = var_100_0.childCount

				for iter_100_0 = 0, var_100_2 - 1 do
					local var_100_3 = var_100_0:GetChild(iter_100_0)

					if var_100_3.name == "split_5" or not string.find(var_100_3.name, "split") then
						var_100_3.gameObject:SetActive(true)
					else
						var_100_3.gameObject:SetActive(false)
					end
				end
			end

			local var_100_4 = 0.001

			if var_100_1 <= arg_97_1.time_ and arg_97_1.time_ < var_100_1 + var_100_4 then
				local var_100_5 = (arg_97_1.time_ - var_100_1) / var_100_4
				local var_100_6 = Vector3.New(0, -490, 18)

				var_100_0.localPosition = Vector3.Lerp(arg_97_1.var_.moveOldPos1061, var_100_6, var_100_5)
			end

			if arg_97_1.time_ >= var_100_1 + var_100_4 and arg_97_1.time_ < var_100_1 + var_100_4 + arg_100_0 then
				var_100_0.localPosition = Vector3.New(0, -490, 18)
			end

			local var_100_7 = arg_97_1.actors_["1061"]
			local var_100_8 = 0

			if var_100_8 < arg_97_1.time_ and arg_97_1.time_ <= var_100_8 + arg_100_0 and not isNil(var_100_7) and arg_97_1.var_.actorSpriteComps1061 == nil then
				arg_97_1.var_.actorSpriteComps1061 = var_100_7:GetComponentsInChildren(typeof(Image), true)
			end

			local var_100_9 = 0.034

			if var_100_8 <= arg_97_1.time_ and arg_97_1.time_ < var_100_8 + var_100_9 and not isNil(var_100_7) then
				local var_100_10 = (arg_97_1.time_ - var_100_8) / var_100_9

				if arg_97_1.var_.actorSpriteComps1061 then
					for iter_100_1, iter_100_2 in pairs(arg_97_1.var_.actorSpriteComps1061:ToTable()) do
						if iter_100_2 then
							if arg_97_1.isInRecall_ then
								local var_100_11 = Mathf.Lerp(iter_100_2.color.r, arg_97_1.hightColor1.r, var_100_10)
								local var_100_12 = Mathf.Lerp(iter_100_2.color.g, arg_97_1.hightColor1.g, var_100_10)
								local var_100_13 = Mathf.Lerp(iter_100_2.color.b, arg_97_1.hightColor1.b, var_100_10)

								iter_100_2.color = Color.New(var_100_11, var_100_12, var_100_13)
							else
								local var_100_14 = Mathf.Lerp(iter_100_2.color.r, 1, var_100_10)

								iter_100_2.color = Color.New(var_100_14, var_100_14, var_100_14)
							end
						end
					end
				end
			end

			if arg_97_1.time_ >= var_100_8 + var_100_9 and arg_97_1.time_ < var_100_8 + var_100_9 + arg_100_0 and not isNil(var_100_7) and arg_97_1.var_.actorSpriteComps1061 then
				for iter_100_3, iter_100_4 in pairs(arg_97_1.var_.actorSpriteComps1061:ToTable()) do
					if iter_100_4 then
						if arg_97_1.isInRecall_ then
							iter_100_4.color = arg_97_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_100_4.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_97_1.var_.actorSpriteComps1061 = nil
			end

			local var_100_15 = 0
			local var_100_16 = 0.5

			if var_100_15 < arg_97_1.time_ and arg_97_1.time_ <= var_100_15 + arg_100_0 then
				arg_97_1.talkMaxDuration = 0
				arg_97_1.dialogCg_.alpha = 1

				arg_97_1.dialog_:SetActive(true)
				SetActive(arg_97_1.leftNameGo_, true)

				local var_100_17 = arg_97_1:FormatText(StoryNameCfg[612].name)

				arg_97_1.leftNameTxt_.text = var_100_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_97_1.leftNameTxt_.transform)

				arg_97_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_97_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_97_1:RecordName(arg_97_1.leftNameTxt_.text)
				SetActive(arg_97_1.iconTrs_.gameObject, false)
				arg_97_1.callingController_:SetSelectedState("normal")

				local var_100_18 = arg_97_1:GetWordFromCfg(410251023)
				local var_100_19 = arg_97_1:FormatText(var_100_18.content)

				arg_97_1.text_.text = var_100_19

				LuaForUtil.ClearLinePrefixSymbol(arg_97_1.text_)

				local var_100_20 = 20
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

				if manager.audio:GetVoiceLength("story_v_out_410251", "410251023", "story_v_out_410251.awb") ~= 0 then
					local var_100_23 = manager.audio:GetVoiceLength("story_v_out_410251", "410251023", "story_v_out_410251.awb") / 1000

					if var_100_23 + var_100_15 > arg_97_1.duration_ then
						arg_97_1.duration_ = var_100_23 + var_100_15
					end

					if var_100_18.prefab_name ~= "" and arg_97_1.actors_[var_100_18.prefab_name] ~= nil then
						local var_100_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_97_1.actors_[var_100_18.prefab_name].transform, "story_v_out_410251", "410251023", "story_v_out_410251.awb")

						arg_97_1:RecordAudio("410251023", var_100_24)
						arg_97_1:RecordAudio("410251023", var_100_24)
					else
						arg_97_1:AudioAction("play", "voice", "story_v_out_410251", "410251023", "story_v_out_410251.awb")
					end

					arg_97_1:RecordHistoryTalkVoice("story_v_out_410251", "410251023", "story_v_out_410251.awb")
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
				actorName = "1061",
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
	Play410251024 = function(arg_101_0, arg_101_1)
		arg_101_1.time_ = 0
		arg_101_1.frameCnt_ = 0
		arg_101_1.state_ = "playing"
		arg_101_1.curTalkId_ = 410251024
		arg_101_1.duration_ = 5

		SetActive(arg_101_1.tipsGo_, false)

		function arg_101_1.onSingleLineFinish_()
			arg_101_1.onSingleLineUpdate_ = nil
			arg_101_1.onSingleLineFinish_ = nil
			arg_101_1.state_ = "waiting"
		end

		function arg_101_1.playNext_(arg_103_0)
			if arg_103_0 == 1 then
				arg_101_0:Play410251025(arg_101_1)
			end
		end

		function arg_101_1.onSingleLineUpdate_(arg_104_0)
			local var_104_0 = arg_101_1.actors_["1061"].transform
			local var_104_1 = 0

			if var_104_1 < arg_101_1.time_ and arg_101_1.time_ <= var_104_1 + arg_104_0 then
				arg_101_1.var_.moveOldPos1061 = var_104_0.localPosition
				var_104_0.localScale = Vector3.New(1, 1, 1)

				arg_101_1:CheckSpriteTmpPos("1061", 7)

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
				local var_104_6 = Vector3.New(0, -2000, 18)

				var_104_0.localPosition = Vector3.Lerp(arg_101_1.var_.moveOldPos1061, var_104_6, var_104_5)
			end

			if arg_101_1.time_ >= var_104_1 + var_104_4 and arg_101_1.time_ < var_104_1 + var_104_4 + arg_104_0 then
				var_104_0.localPosition = Vector3.New(0, -2000, 18)
			end

			local var_104_7 = arg_101_1.actors_["1061"]
			local var_104_8 = 0

			if var_104_8 < arg_101_1.time_ and arg_101_1.time_ <= var_104_8 + arg_104_0 and not isNil(var_104_7) and arg_101_1.var_.actorSpriteComps1061 == nil then
				arg_101_1.var_.actorSpriteComps1061 = var_104_7:GetComponentsInChildren(typeof(Image), true)
			end

			local var_104_9 = 0.034

			if var_104_8 <= arg_101_1.time_ and arg_101_1.time_ < var_104_8 + var_104_9 and not isNil(var_104_7) then
				local var_104_10 = (arg_101_1.time_ - var_104_8) / var_104_9

				if arg_101_1.var_.actorSpriteComps1061 then
					for iter_104_1, iter_104_2 in pairs(arg_101_1.var_.actorSpriteComps1061:ToTable()) do
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

			if arg_101_1.time_ >= var_104_8 + var_104_9 and arg_101_1.time_ < var_104_8 + var_104_9 + arg_104_0 and not isNil(var_104_7) and arg_101_1.var_.actorSpriteComps1061 then
				for iter_104_3, iter_104_4 in pairs(arg_101_1.var_.actorSpriteComps1061:ToTable()) do
					if iter_104_4 then
						if arg_101_1.isInRecall_ then
							iter_104_4.color = arg_101_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_104_4.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_101_1.var_.actorSpriteComps1061 = nil
			end

			local var_104_15 = 0
			local var_104_16 = 1.05

			if var_104_15 < arg_101_1.time_ and arg_101_1.time_ <= var_104_15 + arg_104_0 then
				arg_101_1.talkMaxDuration = 0
				arg_101_1.dialogCg_.alpha = 1

				arg_101_1.dialog_:SetActive(true)
				SetActive(arg_101_1.leftNameGo_, false)

				arg_101_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_101_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_101_1:RecordName(arg_101_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_101_1.iconTrs_.gameObject, false)
				arg_101_1.callingController_:SetSelectedState("normal")

				local var_104_17 = arg_101_1:GetWordFromCfg(410251024)
				local var_104_18 = arg_101_1:FormatText(var_104_17.content)

				arg_101_1.text_.text = var_104_18

				LuaForUtil.ClearLinePrefixSymbol(arg_101_1.text_)

				local var_104_19 = 42
				local var_104_20 = utf8.len(var_104_18)
				local var_104_21 = var_104_19 <= 0 and var_104_16 or var_104_16 * (var_104_20 / var_104_19)

				if var_104_21 > 0 and var_104_16 < var_104_21 then
					arg_101_1.talkMaxDuration = var_104_21

					if var_104_21 + var_104_15 > arg_101_1.duration_ then
						arg_101_1.duration_ = var_104_21 + var_104_15
					end
				end

				arg_101_1.text_.text = var_104_18
				arg_101_1.typewritter.percent = 0

				arg_101_1.typewritter:SetDirty()
				arg_101_1:ShowNextGo(false)
				arg_101_1:RecordContent(arg_101_1.text_.text)
			end

			local var_104_22 = math.max(var_104_16, arg_101_1.talkMaxDuration)

			if var_104_15 <= arg_101_1.time_ and arg_101_1.time_ < var_104_15 + var_104_22 then
				arg_101_1.typewritter.percent = (arg_101_1.time_ - var_104_15) / var_104_22

				arg_101_1.typewritter:SetDirty()
			end

			if arg_101_1.time_ >= var_104_15 + var_104_22 and arg_101_1.time_ < var_104_15 + var_104_22 + arg_104_0 then
				arg_101_1.typewritter.percent = 1

				arg_101_1.typewritter:SetDirty()
				arg_101_1:ShowNextGo(true)
			end
		end

		arg_101_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1061",
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
	Play410251025 = function(arg_105_0, arg_105_1)
		arg_105_1.time_ = 0
		arg_105_1.frameCnt_ = 0
		arg_105_1.state_ = "playing"
		arg_105_1.curTalkId_ = 410251025
		arg_105_1.duration_ = 5

		SetActive(arg_105_1.tipsGo_, false)

		function arg_105_1.onSingleLineFinish_()
			arg_105_1.onSingleLineUpdate_ = nil
			arg_105_1.onSingleLineFinish_ = nil
			arg_105_1.state_ = "waiting"
		end

		function arg_105_1.playNext_(arg_107_0)
			if arg_107_0 == 1 then
				arg_105_0:Play410251026(arg_105_1)
			end
		end

		function arg_105_1.onSingleLineUpdate_(arg_108_0)
			local var_108_0 = 0
			local var_108_1 = 0.925

			if var_108_0 < arg_105_1.time_ and arg_105_1.time_ <= var_108_0 + arg_108_0 then
				arg_105_1.talkMaxDuration = 0
				arg_105_1.dialogCg_.alpha = 1

				arg_105_1.dialog_:SetActive(true)
				SetActive(arg_105_1.leftNameGo_, false)

				arg_105_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_105_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_105_1:RecordName(arg_105_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_105_1.iconTrs_.gameObject, false)
				arg_105_1.callingController_:SetSelectedState("normal")

				local var_108_2 = arg_105_1:GetWordFromCfg(410251025)
				local var_108_3 = arg_105_1:FormatText(var_108_2.content)

				arg_105_1.text_.text = var_108_3

				LuaForUtil.ClearLinePrefixSymbol(arg_105_1.text_)

				local var_108_4 = 37
				local var_108_5 = utf8.len(var_108_3)
				local var_108_6 = var_108_4 <= 0 and var_108_1 or var_108_1 * (var_108_5 / var_108_4)

				if var_108_6 > 0 and var_108_1 < var_108_6 then
					arg_105_1.talkMaxDuration = var_108_6

					if var_108_6 + var_108_0 > arg_105_1.duration_ then
						arg_105_1.duration_ = var_108_6 + var_108_0
					end
				end

				arg_105_1.text_.text = var_108_3
				arg_105_1.typewritter.percent = 0

				arg_105_1.typewritter:SetDirty()
				arg_105_1:ShowNextGo(false)
				arg_105_1:RecordContent(arg_105_1.text_.text)
			end

			local var_108_7 = math.max(var_108_1, arg_105_1.talkMaxDuration)

			if var_108_0 <= arg_105_1.time_ and arg_105_1.time_ < var_108_0 + var_108_7 then
				arg_105_1.typewritter.percent = (arg_105_1.time_ - var_108_0) / var_108_7

				arg_105_1.typewritter:SetDirty()
			end

			if arg_105_1.time_ >= var_108_0 + var_108_7 and arg_105_1.time_ < var_108_0 + var_108_7 + arg_108_0 then
				arg_105_1.typewritter.percent = 1

				arg_105_1.typewritter:SetDirty()
				arg_105_1:ShowNextGo(true)
			end
		end

		arg_105_1.nodeConfigList_ = {}

		arg_105_1:InitPlayNodeList()
	end,
	Play410251026 = function(arg_109_0, arg_109_1)
		arg_109_1.time_ = 0
		arg_109_1.frameCnt_ = 0
		arg_109_1.state_ = "playing"
		arg_109_1.curTalkId_ = 410251026
		arg_109_1.duration_ = 3.7

		local var_109_0 = {
			ja = 3.7,
			CriLanguages = 2.766,
			zh = 2.766
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
				arg_109_0:Play410251027(arg_109_1)
			end
		end

		function arg_109_1.onSingleLineUpdate_(arg_112_0)
			local var_112_0 = arg_109_1.actors_["1060"].transform
			local var_112_1 = 0

			if var_112_1 < arg_109_1.time_ and arg_109_1.time_ <= var_112_1 + arg_112_0 then
				arg_109_1.var_.moveOldPos1060 = var_112_0.localPosition
				var_112_0.localScale = Vector3.New(1, 1, 1)

				arg_109_1:CheckSpriteTmpPos("1060", 2)

				local var_112_2 = var_112_0.childCount

				for iter_112_0 = 0, var_112_2 - 1 do
					local var_112_3 = var_112_0:GetChild(iter_112_0)

					if var_112_3.name == "split_3" or not string.find(var_112_3.name, "split") then
						var_112_3.gameObject:SetActive(true)
					else
						var_112_3.gameObject:SetActive(false)
					end
				end
			end

			local var_112_4 = 0.001

			if var_112_1 <= arg_109_1.time_ and arg_109_1.time_ < var_112_1 + var_112_4 then
				local var_112_5 = (arg_109_1.time_ - var_112_1) / var_112_4
				local var_112_6 = Vector3.New(-440.94, -430.8, 6.9)

				var_112_0.localPosition = Vector3.Lerp(arg_109_1.var_.moveOldPos1060, var_112_6, var_112_5)
			end

			if arg_109_1.time_ >= var_112_1 + var_112_4 and arg_109_1.time_ < var_112_1 + var_112_4 + arg_112_0 then
				var_112_0.localPosition = Vector3.New(-440.94, -430.8, 6.9)
			end

			local var_112_7 = arg_109_1.actors_["1061"].transform
			local var_112_8 = 0

			if var_112_8 < arg_109_1.time_ and arg_109_1.time_ <= var_112_8 + arg_112_0 then
				arg_109_1.var_.moveOldPos1061 = var_112_7.localPosition
				var_112_7.localScale = Vector3.New(1, 1, 1)

				arg_109_1:CheckSpriteTmpPos("1061", 4)

				local var_112_9 = var_112_7.childCount

				for iter_112_1 = 0, var_112_9 - 1 do
					local var_112_10 = var_112_7:GetChild(iter_112_1)

					if var_112_10.name == "" or not string.find(var_112_10.name, "split") then
						var_112_10.gameObject:SetActive(true)
					else
						var_112_10.gameObject:SetActive(false)
					end
				end
			end

			local var_112_11 = 0.001

			if var_112_8 <= arg_109_1.time_ and arg_109_1.time_ < var_112_8 + var_112_11 then
				local var_112_12 = (arg_109_1.time_ - var_112_8) / var_112_11
				local var_112_13 = Vector3.New(390, -490, 18)

				var_112_7.localPosition = Vector3.Lerp(arg_109_1.var_.moveOldPos1061, var_112_13, var_112_12)
			end

			if arg_109_1.time_ >= var_112_8 + var_112_11 and arg_109_1.time_ < var_112_8 + var_112_11 + arg_112_0 then
				var_112_7.localPosition = Vector3.New(390, -490, 18)
			end

			local var_112_14 = arg_109_1.actors_["1060"]
			local var_112_15 = 0

			if var_112_15 < arg_109_1.time_ and arg_109_1.time_ <= var_112_15 + arg_112_0 and not isNil(var_112_14) and arg_109_1.var_.actorSpriteComps1060 == nil then
				arg_109_1.var_.actorSpriteComps1060 = var_112_14:GetComponentsInChildren(typeof(Image), true)
			end

			local var_112_16 = 0.034

			if var_112_15 <= arg_109_1.time_ and arg_109_1.time_ < var_112_15 + var_112_16 and not isNil(var_112_14) then
				local var_112_17 = (arg_109_1.time_ - var_112_15) / var_112_16

				if arg_109_1.var_.actorSpriteComps1060 then
					for iter_112_2, iter_112_3 in pairs(arg_109_1.var_.actorSpriteComps1060:ToTable()) do
						if iter_112_3 then
							if arg_109_1.isInRecall_ then
								local var_112_18 = Mathf.Lerp(iter_112_3.color.r, arg_109_1.hightColor1.r, var_112_17)
								local var_112_19 = Mathf.Lerp(iter_112_3.color.g, arg_109_1.hightColor1.g, var_112_17)
								local var_112_20 = Mathf.Lerp(iter_112_3.color.b, arg_109_1.hightColor1.b, var_112_17)

								iter_112_3.color = Color.New(var_112_18, var_112_19, var_112_20)
							else
								local var_112_21 = Mathf.Lerp(iter_112_3.color.r, 1, var_112_17)

								iter_112_3.color = Color.New(var_112_21, var_112_21, var_112_21)
							end
						end
					end
				end
			end

			if arg_109_1.time_ >= var_112_15 + var_112_16 and arg_109_1.time_ < var_112_15 + var_112_16 + arg_112_0 and not isNil(var_112_14) and arg_109_1.var_.actorSpriteComps1060 then
				for iter_112_4, iter_112_5 in pairs(arg_109_1.var_.actorSpriteComps1060:ToTable()) do
					if iter_112_5 then
						if arg_109_1.isInRecall_ then
							iter_112_5.color = arg_109_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_112_5.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_109_1.var_.actorSpriteComps1060 = nil
			end

			local var_112_22 = arg_109_1.actors_["1061"]
			local var_112_23 = 0

			if var_112_23 < arg_109_1.time_ and arg_109_1.time_ <= var_112_23 + arg_112_0 and not isNil(var_112_22) and arg_109_1.var_.actorSpriteComps1061 == nil then
				arg_109_1.var_.actorSpriteComps1061 = var_112_22:GetComponentsInChildren(typeof(Image), true)
			end

			local var_112_24 = 0.034

			if var_112_23 <= arg_109_1.time_ and arg_109_1.time_ < var_112_23 + var_112_24 and not isNil(var_112_22) then
				local var_112_25 = (arg_109_1.time_ - var_112_23) / var_112_24

				if arg_109_1.var_.actorSpriteComps1061 then
					for iter_112_6, iter_112_7 in pairs(arg_109_1.var_.actorSpriteComps1061:ToTable()) do
						if iter_112_7 then
							if arg_109_1.isInRecall_ then
								local var_112_26 = Mathf.Lerp(iter_112_7.color.r, arg_109_1.hightColor2.r, var_112_25)
								local var_112_27 = Mathf.Lerp(iter_112_7.color.g, arg_109_1.hightColor2.g, var_112_25)
								local var_112_28 = Mathf.Lerp(iter_112_7.color.b, arg_109_1.hightColor2.b, var_112_25)

								iter_112_7.color = Color.New(var_112_26, var_112_27, var_112_28)
							else
								local var_112_29 = Mathf.Lerp(iter_112_7.color.r, 0.5, var_112_25)

								iter_112_7.color = Color.New(var_112_29, var_112_29, var_112_29)
							end
						end
					end
				end
			end

			if arg_109_1.time_ >= var_112_23 + var_112_24 and arg_109_1.time_ < var_112_23 + var_112_24 + arg_112_0 and not isNil(var_112_22) and arg_109_1.var_.actorSpriteComps1061 then
				for iter_112_8, iter_112_9 in pairs(arg_109_1.var_.actorSpriteComps1061:ToTable()) do
					if iter_112_9 then
						if arg_109_1.isInRecall_ then
							iter_112_9.color = arg_109_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_112_9.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_109_1.var_.actorSpriteComps1061 = nil
			end

			local var_112_30 = 0
			local var_112_31 = 0.35

			if var_112_30 < arg_109_1.time_ and arg_109_1.time_ <= var_112_30 + arg_112_0 then
				arg_109_1.talkMaxDuration = 0
				arg_109_1.dialogCg_.alpha = 1

				arg_109_1.dialog_:SetActive(true)
				SetActive(arg_109_1.leftNameGo_, true)

				local var_112_32 = arg_109_1:FormatText(StoryNameCfg[584].name)

				arg_109_1.leftNameTxt_.text = var_112_32

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_109_1.leftNameTxt_.transform)

				arg_109_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_109_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_109_1:RecordName(arg_109_1.leftNameTxt_.text)
				SetActive(arg_109_1.iconTrs_.gameObject, false)
				arg_109_1.callingController_:SetSelectedState("normal")

				local var_112_33 = arg_109_1:GetWordFromCfg(410251026)
				local var_112_34 = arg_109_1:FormatText(var_112_33.content)

				arg_109_1.text_.text = var_112_34

				LuaForUtil.ClearLinePrefixSymbol(arg_109_1.text_)

				local var_112_35 = 14
				local var_112_36 = utf8.len(var_112_34)
				local var_112_37 = var_112_35 <= 0 and var_112_31 or var_112_31 * (var_112_36 / var_112_35)

				if var_112_37 > 0 and var_112_31 < var_112_37 then
					arg_109_1.talkMaxDuration = var_112_37

					if var_112_37 + var_112_30 > arg_109_1.duration_ then
						arg_109_1.duration_ = var_112_37 + var_112_30
					end
				end

				arg_109_1.text_.text = var_112_34
				arg_109_1.typewritter.percent = 0

				arg_109_1.typewritter:SetDirty()
				arg_109_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_410251", "410251026", "story_v_out_410251.awb") ~= 0 then
					local var_112_38 = manager.audio:GetVoiceLength("story_v_out_410251", "410251026", "story_v_out_410251.awb") / 1000

					if var_112_38 + var_112_30 > arg_109_1.duration_ then
						arg_109_1.duration_ = var_112_38 + var_112_30
					end

					if var_112_33.prefab_name ~= "" and arg_109_1.actors_[var_112_33.prefab_name] ~= nil then
						local var_112_39 = LuaForUtil.PlayVoiceWithCriLipsync(arg_109_1.actors_[var_112_33.prefab_name].transform, "story_v_out_410251", "410251026", "story_v_out_410251.awb")

						arg_109_1:RecordAudio("410251026", var_112_39)
						arg_109_1:RecordAudio("410251026", var_112_39)
					else
						arg_109_1:AudioAction("play", "voice", "story_v_out_410251", "410251026", "story_v_out_410251.awb")
					end

					arg_109_1:RecordHistoryTalkVoice("story_v_out_410251", "410251026", "story_v_out_410251.awb")
				end

				arg_109_1:RecordContent(arg_109_1.text_.text)
			end

			local var_112_40 = math.max(var_112_31, arg_109_1.talkMaxDuration)

			if var_112_30 <= arg_109_1.time_ and arg_109_1.time_ < var_112_30 + var_112_40 then
				arg_109_1.typewritter.percent = (arg_109_1.time_ - var_112_30) / var_112_40

				arg_109_1.typewritter:SetDirty()
			end

			if arg_109_1.time_ >= var_112_30 + var_112_40 and arg_109_1.time_ < var_112_30 + var_112_40 + arg_112_0 then
				arg_109_1.typewritter.percent = 1

				arg_109_1.typewritter:SetDirty()
				arg_109_1:ShowNextGo(true)
			end
		end

		arg_109_1.nodeConfigList_ = {
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
				actorName = "1061",
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
	Play410251027 = function(arg_113_0, arg_113_1)
		arg_113_1.time_ = 0
		arg_113_1.frameCnt_ = 0
		arg_113_1.state_ = "playing"
		arg_113_1.curTalkId_ = 410251027
		arg_113_1.duration_ = 4

		local var_113_0 = {
			ja = 1.866,
			CriLanguages = 4,
			zh = 4
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
				arg_113_0:Play410251028(arg_113_1)
			end
		end

		function arg_113_1.onSingleLineUpdate_(arg_116_0)
			local var_116_0 = arg_113_1.actors_["1061"].transform
			local var_116_1 = 0

			if var_116_1 < arg_113_1.time_ and arg_113_1.time_ <= var_116_1 + arg_116_0 then
				arg_113_1.var_.moveOldPos1061 = var_116_0.localPosition
				var_116_0.localScale = Vector3.New(1, 1, 1)

				arg_113_1:CheckSpriteTmpPos("1061", 4)

				local var_116_2 = var_116_0.childCount

				for iter_116_0 = 0, var_116_2 - 1 do
					local var_116_3 = var_116_0:GetChild(iter_116_0)

					if var_116_3.name == "split_5" or not string.find(var_116_3.name, "split") then
						var_116_3.gameObject:SetActive(true)
					else
						var_116_3.gameObject:SetActive(false)
					end
				end
			end

			local var_116_4 = 0.001

			if var_116_1 <= arg_113_1.time_ and arg_113_1.time_ < var_116_1 + var_116_4 then
				local var_116_5 = (arg_113_1.time_ - var_116_1) / var_116_4
				local var_116_6 = Vector3.New(390, -490, 18)

				var_116_0.localPosition = Vector3.Lerp(arg_113_1.var_.moveOldPos1061, var_116_6, var_116_5)
			end

			if arg_113_1.time_ >= var_116_1 + var_116_4 and arg_113_1.time_ < var_116_1 + var_116_4 + arg_116_0 then
				var_116_0.localPosition = Vector3.New(390, -490, 18)
			end

			local var_116_7 = arg_113_1.actors_["1061"]
			local var_116_8 = 0

			if var_116_8 < arg_113_1.time_ and arg_113_1.time_ <= var_116_8 + arg_116_0 and not isNil(var_116_7) and arg_113_1.var_.actorSpriteComps1061 == nil then
				arg_113_1.var_.actorSpriteComps1061 = var_116_7:GetComponentsInChildren(typeof(Image), true)
			end

			local var_116_9 = 0.034

			if var_116_8 <= arg_113_1.time_ and arg_113_1.time_ < var_116_8 + var_116_9 and not isNil(var_116_7) then
				local var_116_10 = (arg_113_1.time_ - var_116_8) / var_116_9

				if arg_113_1.var_.actorSpriteComps1061 then
					for iter_116_1, iter_116_2 in pairs(arg_113_1.var_.actorSpriteComps1061:ToTable()) do
						if iter_116_2 then
							if arg_113_1.isInRecall_ then
								local var_116_11 = Mathf.Lerp(iter_116_2.color.r, arg_113_1.hightColor1.r, var_116_10)
								local var_116_12 = Mathf.Lerp(iter_116_2.color.g, arg_113_1.hightColor1.g, var_116_10)
								local var_116_13 = Mathf.Lerp(iter_116_2.color.b, arg_113_1.hightColor1.b, var_116_10)

								iter_116_2.color = Color.New(var_116_11, var_116_12, var_116_13)
							else
								local var_116_14 = Mathf.Lerp(iter_116_2.color.r, 1, var_116_10)

								iter_116_2.color = Color.New(var_116_14, var_116_14, var_116_14)
							end
						end
					end
				end
			end

			if arg_113_1.time_ >= var_116_8 + var_116_9 and arg_113_1.time_ < var_116_8 + var_116_9 + arg_116_0 and not isNil(var_116_7) and arg_113_1.var_.actorSpriteComps1061 then
				for iter_116_3, iter_116_4 in pairs(arg_113_1.var_.actorSpriteComps1061:ToTable()) do
					if iter_116_4 then
						if arg_113_1.isInRecall_ then
							iter_116_4.color = arg_113_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_116_4.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_113_1.var_.actorSpriteComps1061 = nil
			end

			local var_116_15 = arg_113_1.actors_["1060"]
			local var_116_16 = 0

			if var_116_16 < arg_113_1.time_ and arg_113_1.time_ <= var_116_16 + arg_116_0 and not isNil(var_116_15) and arg_113_1.var_.actorSpriteComps1060 == nil then
				arg_113_1.var_.actorSpriteComps1060 = var_116_15:GetComponentsInChildren(typeof(Image), true)
			end

			local var_116_17 = 0.034

			if var_116_16 <= arg_113_1.time_ and arg_113_1.time_ < var_116_16 + var_116_17 and not isNil(var_116_15) then
				local var_116_18 = (arg_113_1.time_ - var_116_16) / var_116_17

				if arg_113_1.var_.actorSpriteComps1060 then
					for iter_116_5, iter_116_6 in pairs(arg_113_1.var_.actorSpriteComps1060:ToTable()) do
						if iter_116_6 then
							if arg_113_1.isInRecall_ then
								local var_116_19 = Mathf.Lerp(iter_116_6.color.r, arg_113_1.hightColor2.r, var_116_18)
								local var_116_20 = Mathf.Lerp(iter_116_6.color.g, arg_113_1.hightColor2.g, var_116_18)
								local var_116_21 = Mathf.Lerp(iter_116_6.color.b, arg_113_1.hightColor2.b, var_116_18)

								iter_116_6.color = Color.New(var_116_19, var_116_20, var_116_21)
							else
								local var_116_22 = Mathf.Lerp(iter_116_6.color.r, 0.5, var_116_18)

								iter_116_6.color = Color.New(var_116_22, var_116_22, var_116_22)
							end
						end
					end
				end
			end

			if arg_113_1.time_ >= var_116_16 + var_116_17 and arg_113_1.time_ < var_116_16 + var_116_17 + arg_116_0 and not isNil(var_116_15) and arg_113_1.var_.actorSpriteComps1060 then
				for iter_116_7, iter_116_8 in pairs(arg_113_1.var_.actorSpriteComps1060:ToTable()) do
					if iter_116_8 then
						if arg_113_1.isInRecall_ then
							iter_116_8.color = arg_113_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_116_8.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_113_1.var_.actorSpriteComps1060 = nil
			end

			local var_116_23 = 0
			local var_116_24 = 0.2

			if var_116_23 < arg_113_1.time_ and arg_113_1.time_ <= var_116_23 + arg_116_0 then
				arg_113_1.talkMaxDuration = 0
				arg_113_1.dialogCg_.alpha = 1

				arg_113_1.dialog_:SetActive(true)
				SetActive(arg_113_1.leftNameGo_, true)

				local var_116_25 = arg_113_1:FormatText(StoryNameCfg[612].name)

				arg_113_1.leftNameTxt_.text = var_116_25

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_113_1.leftNameTxt_.transform)

				arg_113_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_113_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_113_1:RecordName(arg_113_1.leftNameTxt_.text)
				SetActive(arg_113_1.iconTrs_.gameObject, false)
				arg_113_1.callingController_:SetSelectedState("normal")

				local var_116_26 = arg_113_1:GetWordFromCfg(410251027)
				local var_116_27 = arg_113_1:FormatText(var_116_26.content)

				arg_113_1.text_.text = var_116_27

				LuaForUtil.ClearLinePrefixSymbol(arg_113_1.text_)

				local var_116_28 = 8
				local var_116_29 = utf8.len(var_116_27)
				local var_116_30 = var_116_28 <= 0 and var_116_24 or var_116_24 * (var_116_29 / var_116_28)

				if var_116_30 > 0 and var_116_24 < var_116_30 then
					arg_113_1.talkMaxDuration = var_116_30

					if var_116_30 + var_116_23 > arg_113_1.duration_ then
						arg_113_1.duration_ = var_116_30 + var_116_23
					end
				end

				arg_113_1.text_.text = var_116_27
				arg_113_1.typewritter.percent = 0

				arg_113_1.typewritter:SetDirty()
				arg_113_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_410251", "410251027", "story_v_out_410251.awb") ~= 0 then
					local var_116_31 = manager.audio:GetVoiceLength("story_v_out_410251", "410251027", "story_v_out_410251.awb") / 1000

					if var_116_31 + var_116_23 > arg_113_1.duration_ then
						arg_113_1.duration_ = var_116_31 + var_116_23
					end

					if var_116_26.prefab_name ~= "" and arg_113_1.actors_[var_116_26.prefab_name] ~= nil then
						local var_116_32 = LuaForUtil.PlayVoiceWithCriLipsync(arg_113_1.actors_[var_116_26.prefab_name].transform, "story_v_out_410251", "410251027", "story_v_out_410251.awb")

						arg_113_1:RecordAudio("410251027", var_116_32)
						arg_113_1:RecordAudio("410251027", var_116_32)
					else
						arg_113_1:AudioAction("play", "voice", "story_v_out_410251", "410251027", "story_v_out_410251.awb")
					end

					arg_113_1:RecordHistoryTalkVoice("story_v_out_410251", "410251027", "story_v_out_410251.awb")
				end

				arg_113_1:RecordContent(arg_113_1.text_.text)
			end

			local var_116_33 = math.max(var_116_24, arg_113_1.talkMaxDuration)

			if var_116_23 <= arg_113_1.time_ and arg_113_1.time_ < var_116_23 + var_116_33 then
				arg_113_1.typewritter.percent = (arg_113_1.time_ - var_116_23) / var_116_33

				arg_113_1.typewritter:SetDirty()
			end

			if arg_113_1.time_ >= var_116_23 + var_116_33 and arg_113_1.time_ < var_116_23 + var_116_33 + arg_116_0 then
				arg_113_1.typewritter.percent = 1

				arg_113_1.typewritter:SetDirty()
				arg_113_1:ShowNextGo(true)
			end
		end

		arg_113_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1061",
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
	Play410251028 = function(arg_117_0, arg_117_1)
		arg_117_1.time_ = 0
		arg_117_1.frameCnt_ = 0
		arg_117_1.state_ = "playing"
		arg_117_1.curTalkId_ = 410251028
		arg_117_1.duration_ = 5

		SetActive(arg_117_1.tipsGo_, false)

		function arg_117_1.onSingleLineFinish_()
			arg_117_1.onSingleLineUpdate_ = nil
			arg_117_1.onSingleLineFinish_ = nil
			arg_117_1.state_ = "waiting"
		end

		function arg_117_1.playNext_(arg_119_0)
			if arg_119_0 == 1 then
				arg_117_0:Play410251029(arg_117_1)
			end
		end

		function arg_117_1.onSingleLineUpdate_(arg_120_0)
			local var_120_0 = arg_117_1.actors_["1060"].transform
			local var_120_1 = 0

			if var_120_1 < arg_117_1.time_ and arg_117_1.time_ <= var_120_1 + arg_120_0 then
				arg_117_1.var_.moveOldPos1060 = var_120_0.localPosition
				var_120_0.localScale = Vector3.New(1, 1, 1)

				arg_117_1:CheckSpriteTmpPos("1060", 7)

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
				local var_120_6 = Vector3.New(0, -2000, -40)

				var_120_0.localPosition = Vector3.Lerp(arg_117_1.var_.moveOldPos1060, var_120_6, var_120_5)
			end

			if arg_117_1.time_ >= var_120_1 + var_120_4 and arg_117_1.time_ < var_120_1 + var_120_4 + arg_120_0 then
				var_120_0.localPosition = Vector3.New(0, -2000, -40)
			end

			local var_120_7 = arg_117_1.actors_["1061"].transform
			local var_120_8 = 0

			if var_120_8 < arg_117_1.time_ and arg_117_1.time_ <= var_120_8 + arg_120_0 then
				arg_117_1.var_.moveOldPos1061 = var_120_7.localPosition
				var_120_7.localScale = Vector3.New(1, 1, 1)

				arg_117_1:CheckSpriteTmpPos("1061", 7)

				local var_120_9 = var_120_7.childCount

				for iter_120_1 = 0, var_120_9 - 1 do
					local var_120_10 = var_120_7:GetChild(iter_120_1)

					if var_120_10.name == "" or not string.find(var_120_10.name, "split") then
						var_120_10.gameObject:SetActive(true)
					else
						var_120_10.gameObject:SetActive(false)
					end
				end
			end

			local var_120_11 = 0.001

			if var_120_8 <= arg_117_1.time_ and arg_117_1.time_ < var_120_8 + var_120_11 then
				local var_120_12 = (arg_117_1.time_ - var_120_8) / var_120_11
				local var_120_13 = Vector3.New(0, -2000, 18)

				var_120_7.localPosition = Vector3.Lerp(arg_117_1.var_.moveOldPos1061, var_120_13, var_120_12)
			end

			if arg_117_1.time_ >= var_120_8 + var_120_11 and arg_117_1.time_ < var_120_8 + var_120_11 + arg_120_0 then
				var_120_7.localPosition = Vector3.New(0, -2000, 18)
			end

			local var_120_14 = arg_117_1.actors_["1060"]
			local var_120_15 = 0

			if var_120_15 < arg_117_1.time_ and arg_117_1.time_ <= var_120_15 + arg_120_0 and not isNil(var_120_14) and arg_117_1.var_.actorSpriteComps1060 == nil then
				arg_117_1.var_.actorSpriteComps1060 = var_120_14:GetComponentsInChildren(typeof(Image), true)
			end

			local var_120_16 = 0.034

			if var_120_15 <= arg_117_1.time_ and arg_117_1.time_ < var_120_15 + var_120_16 and not isNil(var_120_14) then
				local var_120_17 = (arg_117_1.time_ - var_120_15) / var_120_16

				if arg_117_1.var_.actorSpriteComps1060 then
					for iter_120_2, iter_120_3 in pairs(arg_117_1.var_.actorSpriteComps1060:ToTable()) do
						if iter_120_3 then
							if arg_117_1.isInRecall_ then
								local var_120_18 = Mathf.Lerp(iter_120_3.color.r, arg_117_1.hightColor2.r, var_120_17)
								local var_120_19 = Mathf.Lerp(iter_120_3.color.g, arg_117_1.hightColor2.g, var_120_17)
								local var_120_20 = Mathf.Lerp(iter_120_3.color.b, arg_117_1.hightColor2.b, var_120_17)

								iter_120_3.color = Color.New(var_120_18, var_120_19, var_120_20)
							else
								local var_120_21 = Mathf.Lerp(iter_120_3.color.r, 0.5, var_120_17)

								iter_120_3.color = Color.New(var_120_21, var_120_21, var_120_21)
							end
						end
					end
				end
			end

			if arg_117_1.time_ >= var_120_15 + var_120_16 and arg_117_1.time_ < var_120_15 + var_120_16 + arg_120_0 and not isNil(var_120_14) and arg_117_1.var_.actorSpriteComps1060 then
				for iter_120_4, iter_120_5 in pairs(arg_117_1.var_.actorSpriteComps1060:ToTable()) do
					if iter_120_5 then
						if arg_117_1.isInRecall_ then
							iter_120_5.color = arg_117_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_120_5.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_117_1.var_.actorSpriteComps1060 = nil
			end

			local var_120_22 = arg_117_1.actors_["1061"]
			local var_120_23 = 0

			if var_120_23 < arg_117_1.time_ and arg_117_1.time_ <= var_120_23 + arg_120_0 and not isNil(var_120_22) and arg_117_1.var_.actorSpriteComps1061 == nil then
				arg_117_1.var_.actorSpriteComps1061 = var_120_22:GetComponentsInChildren(typeof(Image), true)
			end

			local var_120_24 = 0.034

			if var_120_23 <= arg_117_1.time_ and arg_117_1.time_ < var_120_23 + var_120_24 and not isNil(var_120_22) then
				local var_120_25 = (arg_117_1.time_ - var_120_23) / var_120_24

				if arg_117_1.var_.actorSpriteComps1061 then
					for iter_120_6, iter_120_7 in pairs(arg_117_1.var_.actorSpriteComps1061:ToTable()) do
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

			if arg_117_1.time_ >= var_120_23 + var_120_24 and arg_117_1.time_ < var_120_23 + var_120_24 + arg_120_0 and not isNil(var_120_22) and arg_117_1.var_.actorSpriteComps1061 then
				for iter_120_8, iter_120_9 in pairs(arg_117_1.var_.actorSpriteComps1061:ToTable()) do
					if iter_120_9 then
						if arg_117_1.isInRecall_ then
							iter_120_9.color = arg_117_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_120_9.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_117_1.var_.actorSpriteComps1061 = nil
			end

			local var_120_30 = 0
			local var_120_31 = 1.325

			if var_120_30 < arg_117_1.time_ and arg_117_1.time_ <= var_120_30 + arg_120_0 then
				arg_117_1.talkMaxDuration = 0
				arg_117_1.dialogCg_.alpha = 1

				arg_117_1.dialog_:SetActive(true)
				SetActive(arg_117_1.leftNameGo_, false)

				arg_117_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_117_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_117_1:RecordName(arg_117_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_117_1.iconTrs_.gameObject, false)
				arg_117_1.callingController_:SetSelectedState("normal")

				local var_120_32 = arg_117_1:GetWordFromCfg(410251028)
				local var_120_33 = arg_117_1:FormatText(var_120_32.content)

				arg_117_1.text_.text = var_120_33

				LuaForUtil.ClearLinePrefixSymbol(arg_117_1.text_)

				local var_120_34 = 53
				local var_120_35 = utf8.len(var_120_33)
				local var_120_36 = var_120_34 <= 0 and var_120_31 or var_120_31 * (var_120_35 / var_120_34)

				if var_120_36 > 0 and var_120_31 < var_120_36 then
					arg_117_1.talkMaxDuration = var_120_36

					if var_120_36 + var_120_30 > arg_117_1.duration_ then
						arg_117_1.duration_ = var_120_36 + var_120_30
					end
				end

				arg_117_1.text_.text = var_120_33
				arg_117_1.typewritter.percent = 0

				arg_117_1.typewritter:SetDirty()
				arg_117_1:ShowNextGo(false)
				arg_117_1:RecordContent(arg_117_1.text_.text)
			end

			local var_120_37 = math.max(var_120_31, arg_117_1.talkMaxDuration)

			if var_120_30 <= arg_117_1.time_ and arg_117_1.time_ < var_120_30 + var_120_37 then
				arg_117_1.typewritter.percent = (arg_117_1.time_ - var_120_30) / var_120_37

				arg_117_1.typewritter:SetDirty()
			end

			if arg_117_1.time_ >= var_120_30 + var_120_37 and arg_117_1.time_ < var_120_30 + var_120_37 + arg_120_0 then
				arg_117_1.typewritter.percent = 1

				arg_117_1.typewritter:SetDirty()
				arg_117_1:ShowNextGo(true)
			end
		end

		arg_117_1.nodeConfigList_ = {
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
				actorName = "1061",
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
	Play410251029 = function(arg_121_0, arg_121_1)
		arg_121_1.time_ = 0
		arg_121_1.frameCnt_ = 0
		arg_121_1.state_ = "playing"
		arg_121_1.curTalkId_ = 410251029
		arg_121_1.duration_ = 5

		SetActive(arg_121_1.tipsGo_, false)

		function arg_121_1.onSingleLineFinish_()
			arg_121_1.onSingleLineUpdate_ = nil
			arg_121_1.onSingleLineFinish_ = nil
			arg_121_1.state_ = "waiting"
		end

		function arg_121_1.playNext_(arg_123_0)
			if arg_123_0 == 1 then
				arg_121_0:Play410251030(arg_121_1)
			end
		end

		function arg_121_1.onSingleLineUpdate_(arg_124_0)
			local var_124_0 = 0
			local var_124_1 = 1.525

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

				local var_124_2 = arg_121_1:GetWordFromCfg(410251029)
				local var_124_3 = arg_121_1:FormatText(var_124_2.content)

				arg_121_1.text_.text = var_124_3

				LuaForUtil.ClearLinePrefixSymbol(arg_121_1.text_)

				local var_124_4 = 61
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
	Play410251030 = function(arg_125_0, arg_125_1)
		arg_125_1.time_ = 0
		arg_125_1.frameCnt_ = 0
		arg_125_1.state_ = "playing"
		arg_125_1.curTalkId_ = 410251030
		arg_125_1.duration_ = 3.4

		local var_125_0 = {
			ja = 3.4,
			CriLanguages = 3.333,
			zh = 3.333
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
				arg_125_0:Play410251031(arg_125_1)
			end
		end

		function arg_125_1.onSingleLineUpdate_(arg_128_0)
			local var_128_0 = arg_125_1.actors_["1061"].transform
			local var_128_1 = 0

			if var_128_1 < arg_125_1.time_ and arg_125_1.time_ <= var_128_1 + arg_128_0 then
				arg_125_1.var_.moveOldPos1061 = var_128_0.localPosition
				var_128_0.localScale = Vector3.New(1, 1, 1)

				arg_125_1:CheckSpriteTmpPos("1061", 3)

				local var_128_2 = var_128_0.childCount

				for iter_128_0 = 0, var_128_2 - 1 do
					local var_128_3 = var_128_0:GetChild(iter_128_0)

					if var_128_3.name == "split_5" or not string.find(var_128_3.name, "split") then
						var_128_3.gameObject:SetActive(true)
					else
						var_128_3.gameObject:SetActive(false)
					end
				end
			end

			local var_128_4 = 0.001

			if var_128_1 <= arg_125_1.time_ and arg_125_1.time_ < var_128_1 + var_128_4 then
				local var_128_5 = (arg_125_1.time_ - var_128_1) / var_128_4
				local var_128_6 = Vector3.New(0, -490, 18)

				var_128_0.localPosition = Vector3.Lerp(arg_125_1.var_.moveOldPos1061, var_128_6, var_128_5)
			end

			if arg_125_1.time_ >= var_128_1 + var_128_4 and arg_125_1.time_ < var_128_1 + var_128_4 + arg_128_0 then
				var_128_0.localPosition = Vector3.New(0, -490, 18)
			end

			local var_128_7 = arg_125_1.actors_["1061"]
			local var_128_8 = 0

			if var_128_8 < arg_125_1.time_ and arg_125_1.time_ <= var_128_8 + arg_128_0 and not isNil(var_128_7) and arg_125_1.var_.actorSpriteComps1061 == nil then
				arg_125_1.var_.actorSpriteComps1061 = var_128_7:GetComponentsInChildren(typeof(Image), true)
			end

			local var_128_9 = 0.034

			if var_128_8 <= arg_125_1.time_ and arg_125_1.time_ < var_128_8 + var_128_9 and not isNil(var_128_7) then
				local var_128_10 = (arg_125_1.time_ - var_128_8) / var_128_9

				if arg_125_1.var_.actorSpriteComps1061 then
					for iter_128_1, iter_128_2 in pairs(arg_125_1.var_.actorSpriteComps1061:ToTable()) do
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

			if arg_125_1.time_ >= var_128_8 + var_128_9 and arg_125_1.time_ < var_128_8 + var_128_9 + arg_128_0 and not isNil(var_128_7) and arg_125_1.var_.actorSpriteComps1061 then
				for iter_128_3, iter_128_4 in pairs(arg_125_1.var_.actorSpriteComps1061:ToTable()) do
					if iter_128_4 then
						if arg_125_1.isInRecall_ then
							iter_128_4.color = arg_125_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_128_4.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_125_1.var_.actorSpriteComps1061 = nil
			end

			local var_128_15 = 0
			local var_128_16 = 0.225

			if var_128_15 < arg_125_1.time_ and arg_125_1.time_ <= var_128_15 + arg_128_0 then
				arg_125_1.talkMaxDuration = 0
				arg_125_1.dialogCg_.alpha = 1

				arg_125_1.dialog_:SetActive(true)
				SetActive(arg_125_1.leftNameGo_, true)

				local var_128_17 = arg_125_1:FormatText(StoryNameCfg[612].name)

				arg_125_1.leftNameTxt_.text = var_128_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_125_1.leftNameTxt_.transform)

				arg_125_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_125_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_125_1:RecordName(arg_125_1.leftNameTxt_.text)
				SetActive(arg_125_1.iconTrs_.gameObject, false)
				arg_125_1.callingController_:SetSelectedState("normal")

				local var_128_18 = arg_125_1:GetWordFromCfg(410251030)
				local var_128_19 = arg_125_1:FormatText(var_128_18.content)

				arg_125_1.text_.text = var_128_19

				LuaForUtil.ClearLinePrefixSymbol(arg_125_1.text_)

				local var_128_20 = 9
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

				if manager.audio:GetVoiceLength("story_v_out_410251", "410251030", "story_v_out_410251.awb") ~= 0 then
					local var_128_23 = manager.audio:GetVoiceLength("story_v_out_410251", "410251030", "story_v_out_410251.awb") / 1000

					if var_128_23 + var_128_15 > arg_125_1.duration_ then
						arg_125_1.duration_ = var_128_23 + var_128_15
					end

					if var_128_18.prefab_name ~= "" and arg_125_1.actors_[var_128_18.prefab_name] ~= nil then
						local var_128_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_125_1.actors_[var_128_18.prefab_name].transform, "story_v_out_410251", "410251030", "story_v_out_410251.awb")

						arg_125_1:RecordAudio("410251030", var_128_24)
						arg_125_1:RecordAudio("410251030", var_128_24)
					else
						arg_125_1:AudioAction("play", "voice", "story_v_out_410251", "410251030", "story_v_out_410251.awb")
					end

					arg_125_1:RecordHistoryTalkVoice("story_v_out_410251", "410251030", "story_v_out_410251.awb")
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
				actorName = "1061",
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
	Play410251031 = function(arg_129_0, arg_129_1)
		arg_129_1.time_ = 0
		arg_129_1.frameCnt_ = 0
		arg_129_1.state_ = "playing"
		arg_129_1.curTalkId_ = 410251031
		arg_129_1.duration_ = 5.63

		SetActive(arg_129_1.tipsGo_, false)

		function arg_129_1.onSingleLineFinish_()
			arg_129_1.onSingleLineUpdate_ = nil
			arg_129_1.onSingleLineFinish_ = nil
			arg_129_1.state_ = "waiting"
		end

		function arg_129_1.playNext_(arg_131_0)
			if arg_131_0 == 1 then
				arg_129_0:Play410251032(arg_129_1)
			end
		end

		function arg_129_1.onSingleLineUpdate_(arg_132_0)
			local var_132_0 = "STwhite"

			if arg_129_1.bgs_[var_132_0] == nil then
				local var_132_1 = Object.Instantiate(arg_129_1.paintGo_)

				var_132_1:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. var_132_0)
				var_132_1.name = var_132_0
				var_132_1.transform.parent = arg_129_1.stage_.transform
				var_132_1.transform.localPosition = Vector3.New(0, 100, 0)
				arg_129_1.bgs_[var_132_0] = var_132_1
			end

			local var_132_2 = 0.633333333333333

			if var_132_2 < arg_129_1.time_ and arg_129_1.time_ <= var_132_2 + arg_132_0 then
				local var_132_3 = manager.ui.mainCamera.transform.localPosition
				local var_132_4 = Vector3.New(0, 0, 10) + Vector3.New(var_132_3.x, var_132_3.y, 0)
				local var_132_5 = arg_129_1.bgs_.STwhite

				var_132_5.transform.localPosition = var_132_4
				var_132_5.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_132_6 = var_132_5:GetComponent("SpriteRenderer")

				if var_132_6 and var_132_6.sprite then
					local var_132_7 = (var_132_5.transform.localPosition - var_132_3).z
					local var_132_8 = manager.ui.mainCameraCom_
					local var_132_9 = 2 * var_132_7 * Mathf.Tan(var_132_8.fieldOfView * 0.5 * Mathf.Deg2Rad)
					local var_132_10 = var_132_9 * var_132_8.aspect
					local var_132_11 = var_132_6.sprite.bounds.size.x
					local var_132_12 = var_132_6.sprite.bounds.size.y
					local var_132_13 = var_132_10 / var_132_11
					local var_132_14 = var_132_9 / var_132_12
					local var_132_15 = var_132_14 < var_132_13 and var_132_13 or var_132_14

					var_132_5.transform.localScale = Vector3.New(var_132_15, var_132_15, 0)
				end

				for iter_132_0, iter_132_1 in pairs(arg_129_1.bgs_) do
					if iter_132_0 ~= "STwhite" then
						iter_132_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_132_16 = 0

			if var_132_16 < arg_129_1.time_ and arg_129_1.time_ <= var_132_16 + arg_132_0 then
				arg_129_1.mask_.enabled = true
				arg_129_1.mask_.raycastTarget = true

				arg_129_1:SetGaussion(false)
			end

			local var_132_17 = 0.633333333333333

			if var_132_16 <= arg_129_1.time_ and arg_129_1.time_ < var_132_16 + var_132_17 then
				local var_132_18 = (arg_129_1.time_ - var_132_16) / var_132_17
				local var_132_19 = Color.New(1, 1, 1)

				var_132_19.a = Mathf.Lerp(1, 0, var_132_18)
				arg_129_1.mask_.color = var_132_19
			end

			if arg_129_1.time_ >= var_132_16 + var_132_17 and arg_129_1.time_ < var_132_16 + var_132_17 + arg_132_0 then
				local var_132_20 = Color.New(1, 1, 1)
				local var_132_21 = 0

				arg_129_1.mask_.enabled = false
				var_132_20.a = var_132_21
				arg_129_1.mask_.color = var_132_20
			end

			local var_132_22 = arg_129_1.actors_["1061"].transform
			local var_132_23 = 0

			if var_132_23 < arg_129_1.time_ and arg_129_1.time_ <= var_132_23 + arg_132_0 then
				arg_129_1.var_.moveOldPos1061 = var_132_22.localPosition
				var_132_22.localScale = Vector3.New(1, 1, 1)

				arg_129_1:CheckSpriteTmpPos("1061", 7)

				local var_132_24 = var_132_22.childCount

				for iter_132_2 = 0, var_132_24 - 1 do
					local var_132_25 = var_132_22:GetChild(iter_132_2)

					if var_132_25.name == "" or not string.find(var_132_25.name, "split") then
						var_132_25.gameObject:SetActive(true)
					else
						var_132_25.gameObject:SetActive(false)
					end
				end
			end

			local var_132_26 = 0.001

			if var_132_23 <= arg_129_1.time_ and arg_129_1.time_ < var_132_23 + var_132_26 then
				local var_132_27 = (arg_129_1.time_ - var_132_23) / var_132_26
				local var_132_28 = Vector3.New(0, -2000, 18)

				var_132_22.localPosition = Vector3.Lerp(arg_129_1.var_.moveOldPos1061, var_132_28, var_132_27)
			end

			if arg_129_1.time_ >= var_132_23 + var_132_26 and arg_129_1.time_ < var_132_23 + var_132_26 + arg_132_0 then
				var_132_22.localPosition = Vector3.New(0, -2000, 18)
			end

			local var_132_29 = arg_129_1.actors_["1061"]
			local var_132_30 = 0

			if var_132_30 < arg_129_1.time_ and arg_129_1.time_ <= var_132_30 + arg_132_0 and not isNil(var_132_29) and arg_129_1.var_.actorSpriteComps1061 == nil then
				arg_129_1.var_.actorSpriteComps1061 = var_132_29:GetComponentsInChildren(typeof(Image), true)
			end

			local var_132_31 = 0.034

			if var_132_30 <= arg_129_1.time_ and arg_129_1.time_ < var_132_30 + var_132_31 and not isNil(var_132_29) then
				local var_132_32 = (arg_129_1.time_ - var_132_30) / var_132_31

				if arg_129_1.var_.actorSpriteComps1061 then
					for iter_132_3, iter_132_4 in pairs(arg_129_1.var_.actorSpriteComps1061:ToTable()) do
						if iter_132_4 then
							if arg_129_1.isInRecall_ then
								local var_132_33 = Mathf.Lerp(iter_132_4.color.r, arg_129_1.hightColor2.r, var_132_32)
								local var_132_34 = Mathf.Lerp(iter_132_4.color.g, arg_129_1.hightColor2.g, var_132_32)
								local var_132_35 = Mathf.Lerp(iter_132_4.color.b, arg_129_1.hightColor2.b, var_132_32)

								iter_132_4.color = Color.New(var_132_33, var_132_34, var_132_35)
							else
								local var_132_36 = Mathf.Lerp(iter_132_4.color.r, 0.5, var_132_32)

								iter_132_4.color = Color.New(var_132_36, var_132_36, var_132_36)
							end
						end
					end
				end
			end

			if arg_129_1.time_ >= var_132_30 + var_132_31 and arg_129_1.time_ < var_132_30 + var_132_31 + arg_132_0 and not isNil(var_132_29) and arg_129_1.var_.actorSpriteComps1061 then
				for iter_132_5, iter_132_6 in pairs(arg_129_1.var_.actorSpriteComps1061:ToTable()) do
					if iter_132_6 then
						if arg_129_1.isInRecall_ then
							iter_132_6.color = arg_129_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_132_6.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_129_1.var_.actorSpriteComps1061 = nil
			end

			if arg_129_1.frameCnt_ <= 1 then
				arg_129_1.dialog_:SetActive(false)
			end

			local var_132_37 = 0.633333333333333
			local var_132_38 = 0.925

			if var_132_37 < arg_129_1.time_ and arg_129_1.time_ <= var_132_37 + arg_132_0 then
				arg_129_1.talkMaxDuration = 0

				arg_129_1.dialog_:SetActive(true)

				arg_129_1.dialogCg_.alpha = 0

				local var_132_39 = LeanTween.value(arg_129_1.dialog_, 0, 1, 0.3)

				var_132_39:setOnUpdate(LuaHelper.FloatAction(function(arg_133_0)
					arg_129_1.dialogCg_.alpha = arg_133_0
				end))
				var_132_39:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_129_1.dialog_)
					var_132_39:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_129_1.duration_ = arg_129_1.duration_ + 0.3

				SetActive(arg_129_1.leftNameGo_, false)

				arg_129_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_129_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_129_1:RecordName(arg_129_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_129_1.iconTrs_.gameObject, false)
				arg_129_1.callingController_:SetSelectedState("normal")

				local var_132_40 = arg_129_1:GetWordFromCfg(410251031)
				local var_132_41 = arg_129_1:FormatText(var_132_40.content)

				arg_129_1.text_.text = var_132_41

				LuaForUtil.ClearLinePrefixSymbol(arg_129_1.text_)

				local var_132_42 = 37
				local var_132_43 = utf8.len(var_132_41)
				local var_132_44 = var_132_42 <= 0 and var_132_38 or var_132_38 * (var_132_43 / var_132_42)

				if var_132_44 > 0 and var_132_38 < var_132_44 then
					arg_129_1.talkMaxDuration = var_132_44
					var_132_37 = var_132_37 + 0.3

					if var_132_44 + var_132_37 > arg_129_1.duration_ then
						arg_129_1.duration_ = var_132_44 + var_132_37
					end
				end

				arg_129_1.text_.text = var_132_41
				arg_129_1.typewritter.percent = 0

				arg_129_1.typewritter:SetDirty()
				arg_129_1:ShowNextGo(false)
				arg_129_1:RecordContent(arg_129_1.text_.text)
			end

			local var_132_45 = var_132_37 + 0.3
			local var_132_46 = math.max(var_132_38, arg_129_1.talkMaxDuration)

			if var_132_45 <= arg_129_1.time_ and arg_129_1.time_ < var_132_45 + var_132_46 then
				arg_129_1.typewritter.percent = (arg_129_1.time_ - var_132_45) / var_132_46

				arg_129_1.typewritter:SetDirty()
			end

			if arg_129_1.time_ >= var_132_45 + var_132_46 and arg_129_1.time_ < var_132_45 + var_132_46 + arg_132_0 then
				arg_129_1.typewritter.percent = 1

				arg_129_1.typewritter:SetDirty()
				arg_129_1:ShowNextGo(true)
			end
		end

		arg_129_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1061",
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
	Play410251032 = function(arg_135_0, arg_135_1)
		arg_135_1.time_ = 0
		arg_135_1.frameCnt_ = 0
		arg_135_1.state_ = "playing"
		arg_135_1.curTalkId_ = 410251032
		arg_135_1.duration_ = 7

		SetActive(arg_135_1.tipsGo_, false)

		function arg_135_1.onSingleLineFinish_()
			arg_135_1.onSingleLineUpdate_ = nil
			arg_135_1.onSingleLineFinish_ = nil
			arg_135_1.state_ = "waiting"
		end

		function arg_135_1.playNext_(arg_137_0)
			if arg_137_0 == 1 then
				arg_135_0:Play410251033(arg_135_1)
			end
		end

		function arg_135_1.onSingleLineUpdate_(arg_138_0)
			local var_138_0 = "LZ0208"

			if arg_135_1.bgs_[var_138_0] == nil then
				local var_138_1 = Object.Instantiate(arg_135_1.paintGo_)

				var_138_1:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. var_138_0)
				var_138_1.name = var_138_0
				var_138_1.transform.parent = arg_135_1.stage_.transform
				var_138_1.transform.localPosition = Vector3.New(0, 100, 0)
				arg_135_1.bgs_[var_138_0] = var_138_1
			end

			local var_138_2 = 0

			if var_138_2 < arg_135_1.time_ and arg_135_1.time_ <= var_138_2 + arg_138_0 then
				local var_138_3 = manager.ui.mainCamera.transform.localPosition
				local var_138_4 = Vector3.New(0, 0, 10) + Vector3.New(var_138_3.x, var_138_3.y, 0)
				local var_138_5 = arg_135_1.bgs_.LZ0208

				var_138_5.transform.localPosition = var_138_4
				var_138_5.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_138_6 = var_138_5:GetComponent("SpriteRenderer")

				if var_138_6 and var_138_6.sprite then
					local var_138_7 = (var_138_5.transform.localPosition - var_138_3).z
					local var_138_8 = manager.ui.mainCameraCom_
					local var_138_9 = 2 * var_138_7 * Mathf.Tan(var_138_8.fieldOfView * 0.5 * Mathf.Deg2Rad)
					local var_138_10 = var_138_9 * var_138_8.aspect
					local var_138_11 = var_138_6.sprite.bounds.size.x
					local var_138_12 = var_138_6.sprite.bounds.size.y
					local var_138_13 = var_138_10 / var_138_11
					local var_138_14 = var_138_9 / var_138_12
					local var_138_15 = var_138_14 < var_138_13 and var_138_13 or var_138_14

					var_138_5.transform.localScale = Vector3.New(var_138_15, var_138_15, 0)
				end

				for iter_138_0, iter_138_1 in pairs(arg_135_1.bgs_) do
					if iter_138_0 ~= "LZ0208" then
						iter_138_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_138_16 = 0

			if var_138_16 < arg_135_1.time_ and arg_135_1.time_ <= var_138_16 + arg_138_0 then
				arg_135_1.mask_.enabled = true
				arg_135_1.mask_.raycastTarget = true

				arg_135_1:SetGaussion(false)
			end

			local var_138_17 = 2

			if var_138_16 <= arg_135_1.time_ and arg_135_1.time_ < var_138_16 + var_138_17 then
				local var_138_18 = (arg_135_1.time_ - var_138_16) / var_138_17
				local var_138_19 = Color.New(1, 1, 1)

				var_138_19.a = Mathf.Lerp(1, 0, var_138_18)
				arg_135_1.mask_.color = var_138_19
			end

			if arg_135_1.time_ >= var_138_16 + var_138_17 and arg_135_1.time_ < var_138_16 + var_138_17 + arg_138_0 then
				local var_138_20 = Color.New(1, 1, 1)
				local var_138_21 = 0

				arg_135_1.mask_.enabled = false
				var_138_20.a = var_138_21
				arg_135_1.mask_.color = var_138_20
			end

			local var_138_22 = arg_135_1.bgs_.LZ0208.transform
			local var_138_23 = 0

			if var_138_23 < arg_135_1.time_ and arg_135_1.time_ <= var_138_23 + arg_138_0 then
				arg_135_1.var_.moveOldPosLZ0208 = var_138_22.localPosition
			end

			local var_138_24 = 0.001

			if var_138_23 <= arg_135_1.time_ and arg_135_1.time_ < var_138_23 + var_138_24 then
				local var_138_25 = (arg_135_1.time_ - var_138_23) / var_138_24
				local var_138_26 = Vector3.New(0, 1, 5)

				var_138_22.localPosition = Vector3.Lerp(arg_135_1.var_.moveOldPosLZ0208, var_138_26, var_138_25)
			end

			if arg_135_1.time_ >= var_138_23 + var_138_24 and arg_135_1.time_ < var_138_23 + var_138_24 + arg_138_0 then
				var_138_22.localPosition = Vector3.New(0, 1, 5)
			end

			local var_138_27 = arg_135_1.bgs_.LZ0208.transform
			local var_138_28 = 0.0166666666666667

			if var_138_28 < arg_135_1.time_ and arg_135_1.time_ <= var_138_28 + arg_138_0 then
				arg_135_1.var_.moveOldPosLZ0208 = var_138_27.localPosition
			end

			local var_138_29 = 4

			if var_138_28 <= arg_135_1.time_ and arg_135_1.time_ < var_138_28 + var_138_29 then
				local var_138_30 = (arg_135_1.time_ - var_138_28) / var_138_29
				local var_138_31 = Vector3.New(0, 0.8, 9)

				var_138_27.localPosition = Vector3.Lerp(arg_135_1.var_.moveOldPosLZ0208, var_138_31, var_138_30)
			end

			if arg_135_1.time_ >= var_138_28 + var_138_29 and arg_135_1.time_ < var_138_28 + var_138_29 + arg_138_0 then
				var_138_27.localPosition = Vector3.New(0, 0.8, 9)
			end

			local var_138_32 = 2

			if var_138_32 < arg_135_1.time_ and arg_135_1.time_ <= var_138_32 + arg_138_0 then
				arg_135_1.allBtn_.enabled = false
			end

			local var_138_33 = 2.01666666666667

			if arg_135_1.time_ >= var_138_32 + var_138_33 and arg_135_1.time_ < var_138_32 + var_138_33 + arg_138_0 then
				arg_135_1.allBtn_.enabled = true
			end

			local var_138_34 = manager.ui.mainCamera.transform
			local var_138_35 = 0

			if var_138_35 < arg_135_1.time_ and arg_135_1.time_ <= var_138_35 + arg_138_0 then
				arg_135_1.var_.shakeOldPos = var_138_34.localPosition
			end

			local var_138_36 = 1

			if var_138_35 <= arg_135_1.time_ and arg_135_1.time_ < var_138_35 + var_138_36 then
				local var_138_37 = (arg_135_1.time_ - var_138_35) / 0.066
				local var_138_38, var_138_39 = math.modf(var_138_37)

				var_138_34.localPosition = Vector3.New(var_138_39 * 0.13, var_138_39 * 0.13, var_138_39 * 0.13) + arg_135_1.var_.shakeOldPos
			end

			if arg_135_1.time_ >= var_138_35 + var_138_36 and arg_135_1.time_ < var_138_35 + var_138_36 + arg_138_0 then
				var_138_34.localPosition = arg_135_1.var_.shakeOldPos
			end

			if arg_135_1.frameCnt_ <= 1 then
				arg_135_1.dialog_:SetActive(false)
			end

			local var_138_40 = 2
			local var_138_41 = 0.975

			if var_138_40 < arg_135_1.time_ and arg_135_1.time_ <= var_138_40 + arg_138_0 then
				arg_135_1.talkMaxDuration = 0

				arg_135_1.dialog_:SetActive(true)

				arg_135_1.dialogCg_.alpha = 0

				local var_138_42 = LeanTween.value(arg_135_1.dialog_, 0, 1, 0.3)

				var_138_42:setOnUpdate(LuaHelper.FloatAction(function(arg_139_0)
					arg_135_1.dialogCg_.alpha = arg_139_0
				end))
				var_138_42:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_135_1.dialog_)
					var_138_42:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_135_1.duration_ = arg_135_1.duration_ + 0.3

				SetActive(arg_135_1.leftNameGo_, false)

				arg_135_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_135_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_135_1:RecordName(arg_135_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_135_1.iconTrs_.gameObject, false)
				arg_135_1.callingController_:SetSelectedState("normal")

				local var_138_43 = arg_135_1:GetWordFromCfg(410251032)
				local var_138_44 = arg_135_1:FormatText(var_138_43.content)

				arg_135_1.text_.text = var_138_44

				LuaForUtil.ClearLinePrefixSymbol(arg_135_1.text_)

				local var_138_45 = 39
				local var_138_46 = utf8.len(var_138_44)
				local var_138_47 = var_138_45 <= 0 and var_138_41 or var_138_41 * (var_138_46 / var_138_45)

				if var_138_47 > 0 and var_138_41 < var_138_47 then
					arg_135_1.talkMaxDuration = var_138_47
					var_138_40 = var_138_40 + 0.3

					if var_138_47 + var_138_40 > arg_135_1.duration_ then
						arg_135_1.duration_ = var_138_47 + var_138_40
					end
				end

				arg_135_1.text_.text = var_138_44
				arg_135_1.typewritter.percent = 0

				arg_135_1.typewritter:SetDirty()
				arg_135_1:ShowNextGo(false)
				arg_135_1:RecordContent(arg_135_1.text_.text)
			end

			local var_138_48 = var_138_40 + 0.3
			local var_138_49 = math.max(var_138_41, arg_135_1.talkMaxDuration)

			if var_138_48 <= arg_135_1.time_ and arg_135_1.time_ < var_138_48 + var_138_49 then
				arg_135_1.typewritter.percent = (arg_135_1.time_ - var_138_48) / var_138_49

				arg_135_1.typewritter:SetDirty()
			end

			if arg_135_1.time_ >= var_138_48 + var_138_49 and arg_135_1.time_ < var_138_48 + var_138_49 + arg_138_0 then
				arg_135_1.typewritter.percent = 1

				arg_135_1.typewritter:SetDirty()
				arg_135_1:ShowNextGo(true)
			end
		end

		arg_135_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "LZ0208",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.0166666666666667,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Background
			},
			{
				assetPath = "",
				actorName = "LZ0208",
				changeDisplayLayer = false,
				needEase = false,
				duration = 4,
				className = "StoryMoveNode",
				startTime = 0.0166666666666667,
				actorType = StoryPlayerConst.ACTOR_TYPE.Background
			}
		}

		arg_135_1:InitPlayNodeList()
	end,
	Play410251033 = function(arg_141_0, arg_141_1)
		arg_141_1.time_ = 0
		arg_141_1.frameCnt_ = 0
		arg_141_1.state_ = "playing"
		arg_141_1.curTalkId_ = 410251033
		arg_141_1.duration_ = 5

		SetActive(arg_141_1.tipsGo_, false)

		function arg_141_1.onSingleLineFinish_()
			arg_141_1.onSingleLineUpdate_ = nil
			arg_141_1.onSingleLineFinish_ = nil
			arg_141_1.state_ = "waiting"
		end

		function arg_141_1.playNext_(arg_143_0)
			if arg_143_0 == 1 then
				arg_141_0:Play410251034(arg_141_1)
			end
		end

		function arg_141_1.onSingleLineUpdate_(arg_144_0)
			local var_144_0 = 0
			local var_144_1 = 0.65

			if var_144_0 < arg_141_1.time_ and arg_141_1.time_ <= var_144_0 + arg_144_0 then
				arg_141_1.talkMaxDuration = 0
				arg_141_1.dialogCg_.alpha = 1

				arg_141_1.dialog_:SetActive(true)
				SetActive(arg_141_1.leftNameGo_, false)

				arg_141_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_141_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_141_1:RecordName(arg_141_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_141_1.iconTrs_.gameObject, false)
				arg_141_1.callingController_:SetSelectedState("normal")

				local var_144_2 = arg_141_1:GetWordFromCfg(410251033)
				local var_144_3 = arg_141_1:FormatText(var_144_2.content)

				arg_141_1.text_.text = var_144_3

				LuaForUtil.ClearLinePrefixSymbol(arg_141_1.text_)

				local var_144_4 = 26
				local var_144_5 = utf8.len(var_144_3)
				local var_144_6 = var_144_4 <= 0 and var_144_1 or var_144_1 * (var_144_5 / var_144_4)

				if var_144_6 > 0 and var_144_1 < var_144_6 then
					arg_141_1.talkMaxDuration = var_144_6

					if var_144_6 + var_144_0 > arg_141_1.duration_ then
						arg_141_1.duration_ = var_144_6 + var_144_0
					end
				end

				arg_141_1.text_.text = var_144_3
				arg_141_1.typewritter.percent = 0

				arg_141_1.typewritter:SetDirty()
				arg_141_1:ShowNextGo(false)
				arg_141_1:RecordContent(arg_141_1.text_.text)
			end

			local var_144_7 = math.max(var_144_1, arg_141_1.talkMaxDuration)

			if var_144_0 <= arg_141_1.time_ and arg_141_1.time_ < var_144_0 + var_144_7 then
				arg_141_1.typewritter.percent = (arg_141_1.time_ - var_144_0) / var_144_7

				arg_141_1.typewritter:SetDirty()
			end

			if arg_141_1.time_ >= var_144_0 + var_144_7 and arg_141_1.time_ < var_144_0 + var_144_7 + arg_144_0 then
				arg_141_1.typewritter.percent = 1

				arg_141_1.typewritter:SetDirty()
				arg_141_1:ShowNextGo(true)
			end
		end

		arg_141_1.nodeConfigList_ = {}

		arg_141_1:InitPlayNodeList()
	end,
	Play410251034 = function(arg_145_0, arg_145_1)
		arg_145_1.time_ = 0
		arg_145_1.frameCnt_ = 0
		arg_145_1.state_ = "playing"
		arg_145_1.curTalkId_ = 410251034
		arg_145_1.duration_ = 4.43

		local var_145_0 = {
			ja = 4.433,
			CriLanguages = 3.5,
			zh = 3.5
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
				arg_145_0:Play410251035(arg_145_1)
			end
		end

		function arg_145_1.onSingleLineUpdate_(arg_148_0)
			local var_148_0 = 0
			local var_148_1 = 0.45

			if var_148_0 < arg_145_1.time_ and arg_145_1.time_ <= var_148_0 + arg_148_0 then
				arg_145_1.talkMaxDuration = 0
				arg_145_1.dialogCg_.alpha = 1

				arg_145_1.dialog_:SetActive(true)
				SetActive(arg_145_1.leftNameGo_, true)

				local var_148_2 = arg_145_1:FormatText(StoryNameCfg[605].name)

				arg_145_1.leftNameTxt_.text = var_148_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_145_1.leftNameTxt_.transform)

				arg_145_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_145_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_145_1:RecordName(arg_145_1.leftNameTxt_.text)
				SetActive(arg_145_1.iconTrs_.gameObject, true)
				arg_145_1.iconController_:SetSelectedState("hero")

				arg_145_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_1056_split_4")

				arg_145_1.callingController_:SetSelectedState("normal")

				arg_145_1.keyicon_.color = Color.New(1, 1, 1)
				arg_145_1.icon_.color = Color.New(1, 1, 1)

				local var_148_3 = arg_145_1:GetWordFromCfg(410251034)
				local var_148_4 = arg_145_1:FormatText(var_148_3.content)

				arg_145_1.text_.text = var_148_4

				LuaForUtil.ClearLinePrefixSymbol(arg_145_1.text_)

				local var_148_5 = 18
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

				if manager.audio:GetVoiceLength("story_v_out_410251", "410251034", "story_v_out_410251.awb") ~= 0 then
					local var_148_8 = manager.audio:GetVoiceLength("story_v_out_410251", "410251034", "story_v_out_410251.awb") / 1000

					if var_148_8 + var_148_0 > arg_145_1.duration_ then
						arg_145_1.duration_ = var_148_8 + var_148_0
					end

					if var_148_3.prefab_name ~= "" and arg_145_1.actors_[var_148_3.prefab_name] ~= nil then
						local var_148_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_145_1.actors_[var_148_3.prefab_name].transform, "story_v_out_410251", "410251034", "story_v_out_410251.awb")

						arg_145_1:RecordAudio("410251034", var_148_9)
						arg_145_1:RecordAudio("410251034", var_148_9)
					else
						arg_145_1:AudioAction("play", "voice", "story_v_out_410251", "410251034", "story_v_out_410251.awb")
					end

					arg_145_1:RecordHistoryTalkVoice("story_v_out_410251", "410251034", "story_v_out_410251.awb")
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
	Play410251035 = function(arg_149_0, arg_149_1)
		arg_149_1.time_ = 0
		arg_149_1.frameCnt_ = 0
		arg_149_1.state_ = "playing"
		arg_149_1.curTalkId_ = 410251035
		arg_149_1.duration_ = 3.7

		local var_149_0 = {
			ja = 3.7,
			CriLanguages = 2.033,
			zh = 2.033
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
				arg_149_0:Play410251036(arg_149_1)
			end
		end

		function arg_149_1.onSingleLineUpdate_(arg_152_0)
			local var_152_0 = 0
			local var_152_1 = 0.225

			if var_152_0 < arg_149_1.time_ and arg_149_1.time_ <= var_152_0 + arg_152_0 then
				arg_149_1.talkMaxDuration = 0
				arg_149_1.dialogCg_.alpha = 1

				arg_149_1.dialog_:SetActive(true)
				SetActive(arg_149_1.leftNameGo_, true)

				local var_152_2 = arg_149_1:FormatText(StoryNameCfg[612].name)

				arg_149_1.leftNameTxt_.text = var_152_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_149_1.leftNameTxt_.transform)

				arg_149_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_149_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_149_1:RecordName(arg_149_1.leftNameTxt_.text)
				SetActive(arg_149_1.iconTrs_.gameObject, false)
				arg_149_1.callingController_:SetSelectedState("normal")

				local var_152_3 = arg_149_1:GetWordFromCfg(410251035)
				local var_152_4 = arg_149_1:FormatText(var_152_3.content)

				arg_149_1.text_.text = var_152_4

				LuaForUtil.ClearLinePrefixSymbol(arg_149_1.text_)

				local var_152_5 = 9
				local var_152_6 = utf8.len(var_152_4)
				local var_152_7 = var_152_5 <= 0 and var_152_1 or var_152_1 * (var_152_6 / var_152_5)

				if var_152_7 > 0 and var_152_1 < var_152_7 then
					arg_149_1.talkMaxDuration = var_152_7

					if var_152_7 + var_152_0 > arg_149_1.duration_ then
						arg_149_1.duration_ = var_152_7 + var_152_0
					end
				end

				arg_149_1.text_.text = var_152_4
				arg_149_1.typewritter.percent = 0

				arg_149_1.typewritter:SetDirty()
				arg_149_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_410251", "410251035", "story_v_out_410251.awb") ~= 0 then
					local var_152_8 = manager.audio:GetVoiceLength("story_v_out_410251", "410251035", "story_v_out_410251.awb") / 1000

					if var_152_8 + var_152_0 > arg_149_1.duration_ then
						arg_149_1.duration_ = var_152_8 + var_152_0
					end

					if var_152_3.prefab_name ~= "" and arg_149_1.actors_[var_152_3.prefab_name] ~= nil then
						local var_152_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_149_1.actors_[var_152_3.prefab_name].transform, "story_v_out_410251", "410251035", "story_v_out_410251.awb")

						arg_149_1:RecordAudio("410251035", var_152_9)
						arg_149_1:RecordAudio("410251035", var_152_9)
					else
						arg_149_1:AudioAction("play", "voice", "story_v_out_410251", "410251035", "story_v_out_410251.awb")
					end

					arg_149_1:RecordHistoryTalkVoice("story_v_out_410251", "410251035", "story_v_out_410251.awb")
				end

				arg_149_1:RecordContent(arg_149_1.text_.text)
			end

			local var_152_10 = math.max(var_152_1, arg_149_1.talkMaxDuration)

			if var_152_0 <= arg_149_1.time_ and arg_149_1.time_ < var_152_0 + var_152_10 then
				arg_149_1.typewritter.percent = (arg_149_1.time_ - var_152_0) / var_152_10

				arg_149_1.typewritter:SetDirty()
			end

			if arg_149_1.time_ >= var_152_0 + var_152_10 and arg_149_1.time_ < var_152_0 + var_152_10 + arg_152_0 then
				arg_149_1.typewritter.percent = 1

				arg_149_1.typewritter:SetDirty()
				arg_149_1:ShowNextGo(true)
			end
		end

		arg_149_1.nodeConfigList_ = {}

		arg_149_1:InitPlayNodeList()
	end,
	Play410251036 = function(arg_153_0, arg_153_1)
		arg_153_1.time_ = 0
		arg_153_1.frameCnt_ = 0
		arg_153_1.state_ = "playing"
		arg_153_1.curTalkId_ = 410251036
		arg_153_1.duration_ = 8.27

		local var_153_0 = {
			ja = 6.5,
			CriLanguages = 8.266,
			zh = 8.266
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
				arg_153_0:Play410251037(arg_153_1)
			end
		end

		function arg_153_1.onSingleLineUpdate_(arg_156_0)
			local var_156_0 = 0
			local var_156_1 = 0.9

			if var_156_0 < arg_153_1.time_ and arg_153_1.time_ <= var_156_0 + arg_156_0 then
				arg_153_1.talkMaxDuration = 0
				arg_153_1.dialogCg_.alpha = 1

				arg_153_1.dialog_:SetActive(true)
				SetActive(arg_153_1.leftNameGo_, true)

				local var_156_2 = arg_153_1:FormatText(StoryNameCfg[605].name)

				arg_153_1.leftNameTxt_.text = var_156_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_153_1.leftNameTxt_.transform)

				arg_153_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_153_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_153_1:RecordName(arg_153_1.leftNameTxt_.text)
				SetActive(arg_153_1.iconTrs_.gameObject, true)
				arg_153_1.iconController_:SetSelectedState("hero")

				arg_153_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_1056_split_3")

				arg_153_1.callingController_:SetSelectedState("normal")

				arg_153_1.keyicon_.color = Color.New(1, 1, 1)
				arg_153_1.icon_.color = Color.New(1, 1, 1)

				local var_156_3 = arg_153_1:GetWordFromCfg(410251036)
				local var_156_4 = arg_153_1:FormatText(var_156_3.content)

				arg_153_1.text_.text = var_156_4

				LuaForUtil.ClearLinePrefixSymbol(arg_153_1.text_)

				local var_156_5 = 36
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

				if manager.audio:GetVoiceLength("story_v_out_410251", "410251036", "story_v_out_410251.awb") ~= 0 then
					local var_156_8 = manager.audio:GetVoiceLength("story_v_out_410251", "410251036", "story_v_out_410251.awb") / 1000

					if var_156_8 + var_156_0 > arg_153_1.duration_ then
						arg_153_1.duration_ = var_156_8 + var_156_0
					end

					if var_156_3.prefab_name ~= "" and arg_153_1.actors_[var_156_3.prefab_name] ~= nil then
						local var_156_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_153_1.actors_[var_156_3.prefab_name].transform, "story_v_out_410251", "410251036", "story_v_out_410251.awb")

						arg_153_1:RecordAudio("410251036", var_156_9)
						arg_153_1:RecordAudio("410251036", var_156_9)
					else
						arg_153_1:AudioAction("play", "voice", "story_v_out_410251", "410251036", "story_v_out_410251.awb")
					end

					arg_153_1:RecordHistoryTalkVoice("story_v_out_410251", "410251036", "story_v_out_410251.awb")
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
	Play410251037 = function(arg_157_0, arg_157_1)
		arg_157_1.time_ = 0
		arg_157_1.frameCnt_ = 0
		arg_157_1.state_ = "playing"
		arg_157_1.curTalkId_ = 410251037
		arg_157_1.duration_ = 10.03

		local var_157_0 = {
			ja = 10.033,
			CriLanguages = 3.3,
			zh = 3.3
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
				arg_157_0:Play410251038(arg_157_1)
			end
		end

		function arg_157_1.onSingleLineUpdate_(arg_160_0)
			local var_160_0 = 0
			local var_160_1 = 0.375

			if var_160_0 < arg_157_1.time_ and arg_157_1.time_ <= var_160_0 + arg_160_0 then
				arg_157_1.talkMaxDuration = 0
				arg_157_1.dialogCg_.alpha = 1

				arg_157_1.dialog_:SetActive(true)
				SetActive(arg_157_1.leftNameGo_, true)

				local var_160_2 = arg_157_1:FormatText(StoryNameCfg[612].name)

				arg_157_1.leftNameTxt_.text = var_160_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_157_1.leftNameTxt_.transform)

				arg_157_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_157_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_157_1:RecordName(arg_157_1.leftNameTxt_.text)
				SetActive(arg_157_1.iconTrs_.gameObject, false)
				arg_157_1.callingController_:SetSelectedState("normal")

				local var_160_3 = arg_157_1:GetWordFromCfg(410251037)
				local var_160_4 = arg_157_1:FormatText(var_160_3.content)

				arg_157_1.text_.text = var_160_4

				LuaForUtil.ClearLinePrefixSymbol(arg_157_1.text_)

				local var_160_5 = 15
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

				if manager.audio:GetVoiceLength("story_v_out_410251", "410251037", "story_v_out_410251.awb") ~= 0 then
					local var_160_8 = manager.audio:GetVoiceLength("story_v_out_410251", "410251037", "story_v_out_410251.awb") / 1000

					if var_160_8 + var_160_0 > arg_157_1.duration_ then
						arg_157_1.duration_ = var_160_8 + var_160_0
					end

					if var_160_3.prefab_name ~= "" and arg_157_1.actors_[var_160_3.prefab_name] ~= nil then
						local var_160_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_157_1.actors_[var_160_3.prefab_name].transform, "story_v_out_410251", "410251037", "story_v_out_410251.awb")

						arg_157_1:RecordAudio("410251037", var_160_9)
						arg_157_1:RecordAudio("410251037", var_160_9)
					else
						arg_157_1:AudioAction("play", "voice", "story_v_out_410251", "410251037", "story_v_out_410251.awb")
					end

					arg_157_1:RecordHistoryTalkVoice("story_v_out_410251", "410251037", "story_v_out_410251.awb")
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
	Play410251038 = function(arg_161_0, arg_161_1)
		arg_161_1.time_ = 0
		arg_161_1.frameCnt_ = 0
		arg_161_1.state_ = "playing"
		arg_161_1.curTalkId_ = 410251038
		arg_161_1.duration_ = 6.9

		local var_161_0 = {
			ja = 6.9,
			CriLanguages = 3.6,
			zh = 3.6
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
				arg_161_0:Play410251039(arg_161_1)
			end
		end

		function arg_161_1.onSingleLineUpdate_(arg_164_0)
			local var_164_0 = 0
			local var_164_1 = 0.425

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
				SetActive(arg_161_1.iconTrs_.gameObject, true)
				arg_161_1.iconController_:SetSelectedState("hero")

				arg_161_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "1060_split_1_3")

				arg_161_1.callingController_:SetSelectedState("normal")

				arg_161_1.keyicon_.color = Color.New(1, 1, 1)
				arg_161_1.icon_.color = Color.New(1, 1, 1)

				local var_164_3 = arg_161_1:GetWordFromCfg(410251038)
				local var_164_4 = arg_161_1:FormatText(var_164_3.content)

				arg_161_1.text_.text = var_164_4

				LuaForUtil.ClearLinePrefixSymbol(arg_161_1.text_)

				local var_164_5 = 17
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

				if manager.audio:GetVoiceLength("story_v_out_410251", "410251038", "story_v_out_410251.awb") ~= 0 then
					local var_164_8 = manager.audio:GetVoiceLength("story_v_out_410251", "410251038", "story_v_out_410251.awb") / 1000

					if var_164_8 + var_164_0 > arg_161_1.duration_ then
						arg_161_1.duration_ = var_164_8 + var_164_0
					end

					if var_164_3.prefab_name ~= "" and arg_161_1.actors_[var_164_3.prefab_name] ~= nil then
						local var_164_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_161_1.actors_[var_164_3.prefab_name].transform, "story_v_out_410251", "410251038", "story_v_out_410251.awb")

						arg_161_1:RecordAudio("410251038", var_164_9)
						arg_161_1:RecordAudio("410251038", var_164_9)
					else
						arg_161_1:AudioAction("play", "voice", "story_v_out_410251", "410251038", "story_v_out_410251.awb")
					end

					arg_161_1:RecordHistoryTalkVoice("story_v_out_410251", "410251038", "story_v_out_410251.awb")
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
	Play410251039 = function(arg_165_0, arg_165_1)
		arg_165_1.time_ = 0
		arg_165_1.frameCnt_ = 0
		arg_165_1.state_ = "playing"
		arg_165_1.curTalkId_ = 410251039
		arg_165_1.duration_ = 1

		SetActive(arg_165_1.tipsGo_, false)

		function arg_165_1.onSingleLineFinish_()
			arg_165_1.onSingleLineUpdate_ = nil
			arg_165_1.onSingleLineFinish_ = nil
			arg_165_1.state_ = "waiting"
		end

		function arg_165_1.playNext_(arg_167_0)
			if arg_167_0 == 1 then
				arg_165_0:Play410251040(arg_165_1)
			end
		end

		function arg_165_1.onSingleLineUpdate_(arg_168_0)
			local var_168_0 = 0
			local var_168_1 = 0.05

			if var_168_0 < arg_165_1.time_ and arg_165_1.time_ <= var_168_0 + arg_168_0 then
				arg_165_1.talkMaxDuration = 0
				arg_165_1.dialogCg_.alpha = 1

				arg_165_1.dialog_:SetActive(true)
				SetActive(arg_165_1.leftNameGo_, true)

				local var_168_2 = arg_165_1:FormatText(StoryNameCfg[612].name)

				arg_165_1.leftNameTxt_.text = var_168_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_165_1.leftNameTxt_.transform)

				arg_165_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_165_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_165_1:RecordName(arg_165_1.leftNameTxt_.text)
				SetActive(arg_165_1.iconTrs_.gameObject, false)
				arg_165_1.callingController_:SetSelectedState("normal")

				local var_168_3 = arg_165_1:GetWordFromCfg(410251039)
				local var_168_4 = arg_165_1:FormatText(var_168_3.content)

				arg_165_1.text_.text = var_168_4

				LuaForUtil.ClearLinePrefixSymbol(arg_165_1.text_)

				local var_168_5 = 2
				local var_168_6 = utf8.len(var_168_4)
				local var_168_7 = var_168_5 <= 0 and var_168_1 or var_168_1 * (var_168_6 / var_168_5)

				if var_168_7 > 0 and var_168_1 < var_168_7 then
					arg_165_1.talkMaxDuration = var_168_7

					if var_168_7 + var_168_0 > arg_165_1.duration_ then
						arg_165_1.duration_ = var_168_7 + var_168_0
					end
				end

				arg_165_1.text_.text = var_168_4
				arg_165_1.typewritter.percent = 0

				arg_165_1.typewritter:SetDirty()
				arg_165_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_410251", "410251039", "story_v_out_410251.awb") ~= 0 then
					local var_168_8 = manager.audio:GetVoiceLength("story_v_out_410251", "410251039", "story_v_out_410251.awb") / 1000

					if var_168_8 + var_168_0 > arg_165_1.duration_ then
						arg_165_1.duration_ = var_168_8 + var_168_0
					end

					if var_168_3.prefab_name ~= "" and arg_165_1.actors_[var_168_3.prefab_name] ~= nil then
						local var_168_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_165_1.actors_[var_168_3.prefab_name].transform, "story_v_out_410251", "410251039", "story_v_out_410251.awb")

						arg_165_1:RecordAudio("410251039", var_168_9)
						arg_165_1:RecordAudio("410251039", var_168_9)
					else
						arg_165_1:AudioAction("play", "voice", "story_v_out_410251", "410251039", "story_v_out_410251.awb")
					end

					arg_165_1:RecordHistoryTalkVoice("story_v_out_410251", "410251039", "story_v_out_410251.awb")
				end

				arg_165_1:RecordContent(arg_165_1.text_.text)
			end

			local var_168_10 = math.max(var_168_1, arg_165_1.talkMaxDuration)

			if var_168_0 <= arg_165_1.time_ and arg_165_1.time_ < var_168_0 + var_168_10 then
				arg_165_1.typewritter.percent = (arg_165_1.time_ - var_168_0) / var_168_10

				arg_165_1.typewritter:SetDirty()
			end

			if arg_165_1.time_ >= var_168_0 + var_168_10 and arg_165_1.time_ < var_168_0 + var_168_10 + arg_168_0 then
				arg_165_1.typewritter.percent = 1

				arg_165_1.typewritter:SetDirty()
				arg_165_1:ShowNextGo(true)
			end
		end

		arg_165_1.nodeConfigList_ = {}

		arg_165_1:InitPlayNodeList()
	end,
	Play410251040 = function(arg_169_0, arg_169_1)
		arg_169_1.time_ = 0
		arg_169_1.frameCnt_ = 0
		arg_169_1.state_ = "playing"
		arg_169_1.curTalkId_ = 410251040
		arg_169_1.duration_ = 2.2

		local var_169_0 = {
			ja = 1.933,
			CriLanguages = 2.2,
			zh = 2.2
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
				arg_169_0:Play410251041(arg_169_1)
			end
		end

		function arg_169_1.onSingleLineUpdate_(arg_172_0)
			local var_172_0 = 0
			local var_172_1 = 0.15

			if var_172_0 < arg_169_1.time_ and arg_169_1.time_ <= var_172_0 + arg_172_0 then
				arg_169_1.talkMaxDuration = 0
				arg_169_1.dialogCg_.alpha = 1

				arg_169_1.dialog_:SetActive(true)
				SetActive(arg_169_1.leftNameGo_, true)

				local var_172_2 = arg_169_1:FormatText(StoryNameCfg[584].name)

				arg_169_1.leftNameTxt_.text = var_172_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_169_1.leftNameTxt_.transform)

				arg_169_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_169_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_169_1:RecordName(arg_169_1.leftNameTxt_.text)
				SetActive(arg_169_1.iconTrs_.gameObject, true)
				arg_169_1.iconController_:SetSelectedState("hero")

				arg_169_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "1060_split_1_3")

				arg_169_1.callingController_:SetSelectedState("normal")

				arg_169_1.keyicon_.color = Color.New(1, 1, 1)
				arg_169_1.icon_.color = Color.New(1, 1, 1)

				local var_172_3 = arg_169_1:GetWordFromCfg(410251040)
				local var_172_4 = arg_169_1:FormatText(var_172_3.content)

				arg_169_1.text_.text = var_172_4

				LuaForUtil.ClearLinePrefixSymbol(arg_169_1.text_)

				local var_172_5 = 6
				local var_172_6 = utf8.len(var_172_4)
				local var_172_7 = var_172_5 <= 0 and var_172_1 or var_172_1 * (var_172_6 / var_172_5)

				if var_172_7 > 0 and var_172_1 < var_172_7 then
					arg_169_1.talkMaxDuration = var_172_7

					if var_172_7 + var_172_0 > arg_169_1.duration_ then
						arg_169_1.duration_ = var_172_7 + var_172_0
					end
				end

				arg_169_1.text_.text = var_172_4
				arg_169_1.typewritter.percent = 0

				arg_169_1.typewritter:SetDirty()
				arg_169_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_410251", "410251040", "story_v_out_410251.awb") ~= 0 then
					local var_172_8 = manager.audio:GetVoiceLength("story_v_out_410251", "410251040", "story_v_out_410251.awb") / 1000

					if var_172_8 + var_172_0 > arg_169_1.duration_ then
						arg_169_1.duration_ = var_172_8 + var_172_0
					end

					if var_172_3.prefab_name ~= "" and arg_169_1.actors_[var_172_3.prefab_name] ~= nil then
						local var_172_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_169_1.actors_[var_172_3.prefab_name].transform, "story_v_out_410251", "410251040", "story_v_out_410251.awb")

						arg_169_1:RecordAudio("410251040", var_172_9)
						arg_169_1:RecordAudio("410251040", var_172_9)
					else
						arg_169_1:AudioAction("play", "voice", "story_v_out_410251", "410251040", "story_v_out_410251.awb")
					end

					arg_169_1:RecordHistoryTalkVoice("story_v_out_410251", "410251040", "story_v_out_410251.awb")
				end

				arg_169_1:RecordContent(arg_169_1.text_.text)
			end

			local var_172_10 = math.max(var_172_1, arg_169_1.talkMaxDuration)

			if var_172_0 <= arg_169_1.time_ and arg_169_1.time_ < var_172_0 + var_172_10 then
				arg_169_1.typewritter.percent = (arg_169_1.time_ - var_172_0) / var_172_10

				arg_169_1.typewritter:SetDirty()
			end

			if arg_169_1.time_ >= var_172_0 + var_172_10 and arg_169_1.time_ < var_172_0 + var_172_10 + arg_172_0 then
				arg_169_1.typewritter.percent = 1

				arg_169_1.typewritter:SetDirty()
				arg_169_1:ShowNextGo(true)
			end
		end

		arg_169_1.nodeConfigList_ = {}

		arg_169_1:InitPlayNodeList()
	end,
	Play410251041 = function(arg_173_0, arg_173_1)
		arg_173_1.time_ = 0
		arg_173_1.frameCnt_ = 0
		arg_173_1.state_ = "playing"
		arg_173_1.curTalkId_ = 410251041
		arg_173_1.duration_ = 9

		SetActive(arg_173_1.tipsGo_, false)

		function arg_173_1.onSingleLineFinish_()
			arg_173_1.onSingleLineUpdate_ = nil
			arg_173_1.onSingleLineFinish_ = nil
			arg_173_1.state_ = "waiting"
		end

		function arg_173_1.playNext_(arg_175_0)
			if arg_175_0 == 1 then
				arg_173_0:Play410251042(arg_173_1)
			end
		end

		function arg_173_1.onSingleLineUpdate_(arg_176_0)
			local var_176_0 = 2

			if var_176_0 < arg_173_1.time_ and arg_173_1.time_ <= var_176_0 + arg_176_0 then
				local var_176_1 = manager.ui.mainCamera.transform.localPosition
				local var_176_2 = Vector3.New(0, 0, 10) + Vector3.New(var_176_1.x, var_176_1.y, 0)
				local var_176_3 = arg_173_1.bgs_.L04h

				var_176_3.transform.localPosition = var_176_2
				var_176_3.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_176_4 = var_176_3:GetComponent("SpriteRenderer")

				if var_176_4 and var_176_4.sprite then
					local var_176_5 = (var_176_3.transform.localPosition - var_176_1).z
					local var_176_6 = manager.ui.mainCameraCom_
					local var_176_7 = 2 * var_176_5 * Mathf.Tan(var_176_6.fieldOfView * 0.5 * Mathf.Deg2Rad)
					local var_176_8 = var_176_7 * var_176_6.aspect
					local var_176_9 = var_176_4.sprite.bounds.size.x
					local var_176_10 = var_176_4.sprite.bounds.size.y
					local var_176_11 = var_176_8 / var_176_9
					local var_176_12 = var_176_7 / var_176_10
					local var_176_13 = var_176_12 < var_176_11 and var_176_11 or var_176_12

					var_176_3.transform.localScale = Vector3.New(var_176_13, var_176_13, 0)
				end

				for iter_176_0, iter_176_1 in pairs(arg_173_1.bgs_) do
					if iter_176_0 ~= "L04h" then
						iter_176_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_176_14 = 0

			if var_176_14 < arg_173_1.time_ and arg_173_1.time_ <= var_176_14 + arg_176_0 then
				arg_173_1.mask_.enabled = true
				arg_173_1.mask_.raycastTarget = true

				arg_173_1:SetGaussion(false)
			end

			local var_176_15 = 2

			if var_176_14 <= arg_173_1.time_ and arg_173_1.time_ < var_176_14 + var_176_15 then
				local var_176_16 = (arg_173_1.time_ - var_176_14) / var_176_15
				local var_176_17 = Color.New(0, 0, 0)

				var_176_17.a = Mathf.Lerp(0, 1, var_176_16)
				arg_173_1.mask_.color = var_176_17
			end

			if arg_173_1.time_ >= var_176_14 + var_176_15 and arg_173_1.time_ < var_176_14 + var_176_15 + arg_176_0 then
				local var_176_18 = Color.New(0, 0, 0)

				var_176_18.a = 1
				arg_173_1.mask_.color = var_176_18
			end

			local var_176_19 = 2

			if var_176_19 < arg_173_1.time_ and arg_173_1.time_ <= var_176_19 + arg_176_0 then
				arg_173_1.mask_.enabled = true
				arg_173_1.mask_.raycastTarget = true

				arg_173_1:SetGaussion(false)
			end

			local var_176_20 = 2

			if var_176_19 <= arg_173_1.time_ and arg_173_1.time_ < var_176_19 + var_176_20 then
				local var_176_21 = (arg_173_1.time_ - var_176_19) / var_176_20
				local var_176_22 = Color.New(0, 0, 0)

				var_176_22.a = Mathf.Lerp(1, 0, var_176_21)
				arg_173_1.mask_.color = var_176_22
			end

			if arg_173_1.time_ >= var_176_19 + var_176_20 and arg_173_1.time_ < var_176_19 + var_176_20 + arg_176_0 then
				local var_176_23 = Color.New(0, 0, 0)
				local var_176_24 = 0

				arg_173_1.mask_.enabled = false
				var_176_23.a = var_176_24
				arg_173_1.mask_.color = var_176_23
			end

			if arg_173_1.frameCnt_ <= 1 then
				arg_173_1.dialog_:SetActive(false)
			end

			local var_176_25 = 4
			local var_176_26 = 1

			if var_176_25 < arg_173_1.time_ and arg_173_1.time_ <= var_176_25 + arg_176_0 then
				arg_173_1.talkMaxDuration = 0

				arg_173_1.dialog_:SetActive(true)

				arg_173_1.dialogCg_.alpha = 0

				local var_176_27 = LeanTween.value(arg_173_1.dialog_, 0, 1, 0.3)

				var_176_27:setOnUpdate(LuaHelper.FloatAction(function(arg_177_0)
					arg_173_1.dialogCg_.alpha = arg_177_0
				end))
				var_176_27:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_173_1.dialog_)
					var_176_27:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_173_1.duration_ = arg_173_1.duration_ + 0.3

				SetActive(arg_173_1.leftNameGo_, false)

				arg_173_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_173_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_173_1:RecordName(arg_173_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_173_1.iconTrs_.gameObject, false)
				arg_173_1.callingController_:SetSelectedState("normal")

				local var_176_28 = arg_173_1:GetWordFromCfg(410251041)
				local var_176_29 = arg_173_1:FormatText(var_176_28.content)

				arg_173_1.text_.text = var_176_29

				LuaForUtil.ClearLinePrefixSymbol(arg_173_1.text_)

				local var_176_30 = 40
				local var_176_31 = utf8.len(var_176_29)
				local var_176_32 = var_176_30 <= 0 and var_176_26 or var_176_26 * (var_176_31 / var_176_30)

				if var_176_32 > 0 and var_176_26 < var_176_32 then
					arg_173_1.talkMaxDuration = var_176_32
					var_176_25 = var_176_25 + 0.3

					if var_176_32 + var_176_25 > arg_173_1.duration_ then
						arg_173_1.duration_ = var_176_32 + var_176_25
					end
				end

				arg_173_1.text_.text = var_176_29
				arg_173_1.typewritter.percent = 0

				arg_173_1.typewritter:SetDirty()
				arg_173_1:ShowNextGo(false)
				arg_173_1:RecordContent(arg_173_1.text_.text)
			end

			local var_176_33 = var_176_25 + 0.3
			local var_176_34 = math.max(var_176_26, arg_173_1.talkMaxDuration)

			if var_176_33 <= arg_173_1.time_ and arg_173_1.time_ < var_176_33 + var_176_34 then
				arg_173_1.typewritter.percent = (arg_173_1.time_ - var_176_33) / var_176_34

				arg_173_1.typewritter:SetDirty()
			end

			if arg_173_1.time_ >= var_176_33 + var_176_34 and arg_173_1.time_ < var_176_33 + var_176_34 + arg_176_0 then
				arg_173_1.typewritter.percent = 1

				arg_173_1.typewritter:SetDirty()
				arg_173_1:ShowNextGo(true)
			end
		end

		arg_173_1.nodeConfigList_ = {}

		arg_173_1:InitPlayNodeList()
	end,
	Play410251042 = function(arg_179_0, arg_179_1)
		arg_179_1.time_ = 0
		arg_179_1.frameCnt_ = 0
		arg_179_1.state_ = "playing"
		arg_179_1.curTalkId_ = 410251042
		arg_179_1.duration_ = 11.03

		local var_179_0 = {
			ja = 11.033,
			CriLanguages = 7.4,
			zh = 7.4
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
				arg_179_0:Play410251043(arg_179_1)
			end
		end

		function arg_179_1.onSingleLineUpdate_(arg_182_0)
			local var_182_0 = 0
			local var_182_1 = 0.675

			if var_182_0 < arg_179_1.time_ and arg_179_1.time_ <= var_182_0 + arg_182_0 then
				arg_179_1.talkMaxDuration = 0
				arg_179_1.dialogCg_.alpha = 1

				arg_179_1.dialog_:SetActive(true)
				SetActive(arg_179_1.leftNameGo_, true)

				local var_182_2 = arg_179_1:FormatText(StoryNameCfg[600].name)

				arg_179_1.leftNameTxt_.text = var_182_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_179_1.leftNameTxt_.transform)

				arg_179_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_179_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_179_1:RecordName(arg_179_1.leftNameTxt_.text)
				SetActive(arg_179_1.iconTrs_.gameObject, true)
				arg_179_1.iconController_:SetSelectedState("hero")

				arg_179_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_4032")

				arg_179_1.callingController_:SetSelectedState("normal")

				arg_179_1.keyicon_.color = Color.New(1, 1, 1)
				arg_179_1.icon_.color = Color.New(1, 1, 1)

				local var_182_3 = arg_179_1:GetWordFromCfg(410251042)
				local var_182_4 = arg_179_1:FormatText(var_182_3.content)

				arg_179_1.text_.text = var_182_4

				LuaForUtil.ClearLinePrefixSymbol(arg_179_1.text_)

				local var_182_5 = 27
				local var_182_6 = utf8.len(var_182_4)
				local var_182_7 = var_182_5 <= 0 and var_182_1 or var_182_1 * (var_182_6 / var_182_5)

				if var_182_7 > 0 and var_182_1 < var_182_7 then
					arg_179_1.talkMaxDuration = var_182_7

					if var_182_7 + var_182_0 > arg_179_1.duration_ then
						arg_179_1.duration_ = var_182_7 + var_182_0
					end
				end

				arg_179_1.text_.text = var_182_4
				arg_179_1.typewritter.percent = 0

				arg_179_1.typewritter:SetDirty()
				arg_179_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_410251", "410251042", "story_v_out_410251.awb") ~= 0 then
					local var_182_8 = manager.audio:GetVoiceLength("story_v_out_410251", "410251042", "story_v_out_410251.awb") / 1000

					if var_182_8 + var_182_0 > arg_179_1.duration_ then
						arg_179_1.duration_ = var_182_8 + var_182_0
					end

					if var_182_3.prefab_name ~= "" and arg_179_1.actors_[var_182_3.prefab_name] ~= nil then
						local var_182_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_179_1.actors_[var_182_3.prefab_name].transform, "story_v_out_410251", "410251042", "story_v_out_410251.awb")

						arg_179_1:RecordAudio("410251042", var_182_9)
						arg_179_1:RecordAudio("410251042", var_182_9)
					else
						arg_179_1:AudioAction("play", "voice", "story_v_out_410251", "410251042", "story_v_out_410251.awb")
					end

					arg_179_1:RecordHistoryTalkVoice("story_v_out_410251", "410251042", "story_v_out_410251.awb")
				end

				arg_179_1:RecordContent(arg_179_1.text_.text)
			end

			local var_182_10 = math.max(var_182_1, arg_179_1.talkMaxDuration)

			if var_182_0 <= arg_179_1.time_ and arg_179_1.time_ < var_182_0 + var_182_10 then
				arg_179_1.typewritter.percent = (arg_179_1.time_ - var_182_0) / var_182_10

				arg_179_1.typewritter:SetDirty()
			end

			if arg_179_1.time_ >= var_182_0 + var_182_10 and arg_179_1.time_ < var_182_0 + var_182_10 + arg_182_0 then
				arg_179_1.typewritter.percent = 1

				arg_179_1.typewritter:SetDirty()
				arg_179_1:ShowNextGo(true)
			end
		end

		arg_179_1.nodeConfigList_ = {}

		arg_179_1:InitPlayNodeList()
	end,
	Play410251043 = function(arg_183_0, arg_183_1)
		arg_183_1.time_ = 0
		arg_183_1.frameCnt_ = 0
		arg_183_1.state_ = "playing"
		arg_183_1.curTalkId_ = 410251043
		arg_183_1.duration_ = 6.73

		local var_183_0 = {
			ja = 6.733,
			CriLanguages = 4.5,
			zh = 4.5
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
				arg_183_0:Play410251044(arg_183_1)
			end
		end

		function arg_183_1.onSingleLineUpdate_(arg_186_0)
			local var_186_0 = 0
			local var_186_1 = 0.4

			if var_186_0 < arg_183_1.time_ and arg_183_1.time_ <= var_186_0 + arg_186_0 then
				arg_183_1.talkMaxDuration = 0
				arg_183_1.dialogCg_.alpha = 1

				arg_183_1.dialog_:SetActive(true)
				SetActive(arg_183_1.leftNameGo_, true)

				local var_186_2 = arg_183_1:FormatText(StoryNameCfg[600].name)

				arg_183_1.leftNameTxt_.text = var_186_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_183_1.leftNameTxt_.transform)

				arg_183_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_183_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_183_1:RecordName(arg_183_1.leftNameTxt_.text)
				SetActive(arg_183_1.iconTrs_.gameObject, true)
				arg_183_1.iconController_:SetSelectedState("hero")

				arg_183_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_4032")

				arg_183_1.callingController_:SetSelectedState("normal")

				arg_183_1.keyicon_.color = Color.New(1, 1, 1)
				arg_183_1.icon_.color = Color.New(1, 1, 1)

				local var_186_3 = arg_183_1:GetWordFromCfg(410251043)
				local var_186_4 = arg_183_1:FormatText(var_186_3.content)

				arg_183_1.text_.text = var_186_4

				LuaForUtil.ClearLinePrefixSymbol(arg_183_1.text_)

				local var_186_5 = 16
				local var_186_6 = utf8.len(var_186_4)
				local var_186_7 = var_186_5 <= 0 and var_186_1 or var_186_1 * (var_186_6 / var_186_5)

				if var_186_7 > 0 and var_186_1 < var_186_7 then
					arg_183_1.talkMaxDuration = var_186_7

					if var_186_7 + var_186_0 > arg_183_1.duration_ then
						arg_183_1.duration_ = var_186_7 + var_186_0
					end
				end

				arg_183_1.text_.text = var_186_4
				arg_183_1.typewritter.percent = 0

				arg_183_1.typewritter:SetDirty()
				arg_183_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_410251", "410251043", "story_v_out_410251.awb") ~= 0 then
					local var_186_8 = manager.audio:GetVoiceLength("story_v_out_410251", "410251043", "story_v_out_410251.awb") / 1000

					if var_186_8 + var_186_0 > arg_183_1.duration_ then
						arg_183_1.duration_ = var_186_8 + var_186_0
					end

					if var_186_3.prefab_name ~= "" and arg_183_1.actors_[var_186_3.prefab_name] ~= nil then
						local var_186_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_183_1.actors_[var_186_3.prefab_name].transform, "story_v_out_410251", "410251043", "story_v_out_410251.awb")

						arg_183_1:RecordAudio("410251043", var_186_9)
						arg_183_1:RecordAudio("410251043", var_186_9)
					else
						arg_183_1:AudioAction("play", "voice", "story_v_out_410251", "410251043", "story_v_out_410251.awb")
					end

					arg_183_1:RecordHistoryTalkVoice("story_v_out_410251", "410251043", "story_v_out_410251.awb")
				end

				arg_183_1:RecordContent(arg_183_1.text_.text)
			end

			local var_186_10 = math.max(var_186_1, arg_183_1.talkMaxDuration)

			if var_186_0 <= arg_183_1.time_ and arg_183_1.time_ < var_186_0 + var_186_10 then
				arg_183_1.typewritter.percent = (arg_183_1.time_ - var_186_0) / var_186_10

				arg_183_1.typewritter:SetDirty()
			end

			if arg_183_1.time_ >= var_186_0 + var_186_10 and arg_183_1.time_ < var_186_0 + var_186_10 + arg_186_0 then
				arg_183_1.typewritter.percent = 1

				arg_183_1.typewritter:SetDirty()
				arg_183_1:ShowNextGo(true)
			end
		end

		arg_183_1.nodeConfigList_ = {}

		arg_183_1:InitPlayNodeList()
	end,
	Play410251044 = function(arg_187_0, arg_187_1)
		arg_187_1.time_ = 0
		arg_187_1.frameCnt_ = 0
		arg_187_1.state_ = "playing"
		arg_187_1.curTalkId_ = 410251044
		arg_187_1.duration_ = 7.1

		local var_187_0 = {
			ja = 7.1,
			CriLanguages = 4.633,
			zh = 4.633
		}
		local var_187_1 = manager.audio:GetLocalizationFlag()

		if var_187_0[var_187_1] ~= nil then
			arg_187_1.duration_ = var_187_0[var_187_1]
		end

		SetActive(arg_187_1.tipsGo_, false)

		function arg_187_1.onSingleLineFinish_()
			arg_187_1.onSingleLineUpdate_ = nil
			arg_187_1.onSingleLineFinish_ = nil
			arg_187_1.state_ = "waiting"
		end

		function arg_187_1.playNext_(arg_189_0)
			if arg_189_0 == 1 then
				arg_187_0:Play410251045(arg_187_1)
			end
		end

		function arg_187_1.onSingleLineUpdate_(arg_190_0)
			local var_190_0 = 0
			local var_190_1 = 0.35

			if var_190_0 < arg_187_1.time_ and arg_187_1.time_ <= var_190_0 + arg_190_0 then
				arg_187_1.talkMaxDuration = 0
				arg_187_1.dialogCg_.alpha = 1

				arg_187_1.dialog_:SetActive(true)
				SetActive(arg_187_1.leftNameGo_, true)

				local var_190_2 = arg_187_1:FormatText(StoryNameCfg[600].name)

				arg_187_1.leftNameTxt_.text = var_190_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_187_1.leftNameTxt_.transform)

				arg_187_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_187_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_187_1:RecordName(arg_187_1.leftNameTxt_.text)
				SetActive(arg_187_1.iconTrs_.gameObject, true)
				arg_187_1.iconController_:SetSelectedState("hero")

				arg_187_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_4032")

				arg_187_1.callingController_:SetSelectedState("normal")

				arg_187_1.keyicon_.color = Color.New(1, 1, 1)
				arg_187_1.icon_.color = Color.New(1, 1, 1)

				local var_190_3 = arg_187_1:GetWordFromCfg(410251044)
				local var_190_4 = arg_187_1:FormatText(var_190_3.content)

				arg_187_1.text_.text = var_190_4

				LuaForUtil.ClearLinePrefixSymbol(arg_187_1.text_)

				local var_190_5 = 14
				local var_190_6 = utf8.len(var_190_4)
				local var_190_7 = var_190_5 <= 0 and var_190_1 or var_190_1 * (var_190_6 / var_190_5)

				if var_190_7 > 0 and var_190_1 < var_190_7 then
					arg_187_1.talkMaxDuration = var_190_7

					if var_190_7 + var_190_0 > arg_187_1.duration_ then
						arg_187_1.duration_ = var_190_7 + var_190_0
					end
				end

				arg_187_1.text_.text = var_190_4
				arg_187_1.typewritter.percent = 0

				arg_187_1.typewritter:SetDirty()
				arg_187_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_410251", "410251044", "story_v_out_410251.awb") ~= 0 then
					local var_190_8 = manager.audio:GetVoiceLength("story_v_out_410251", "410251044", "story_v_out_410251.awb") / 1000

					if var_190_8 + var_190_0 > arg_187_1.duration_ then
						arg_187_1.duration_ = var_190_8 + var_190_0
					end

					if var_190_3.prefab_name ~= "" and arg_187_1.actors_[var_190_3.prefab_name] ~= nil then
						local var_190_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_187_1.actors_[var_190_3.prefab_name].transform, "story_v_out_410251", "410251044", "story_v_out_410251.awb")

						arg_187_1:RecordAudio("410251044", var_190_9)
						arg_187_1:RecordAudio("410251044", var_190_9)
					else
						arg_187_1:AudioAction("play", "voice", "story_v_out_410251", "410251044", "story_v_out_410251.awb")
					end

					arg_187_1:RecordHistoryTalkVoice("story_v_out_410251", "410251044", "story_v_out_410251.awb")
				end

				arg_187_1:RecordContent(arg_187_1.text_.text)
			end

			local var_190_10 = math.max(var_190_1, arg_187_1.talkMaxDuration)

			if var_190_0 <= arg_187_1.time_ and arg_187_1.time_ < var_190_0 + var_190_10 then
				arg_187_1.typewritter.percent = (arg_187_1.time_ - var_190_0) / var_190_10

				arg_187_1.typewritter:SetDirty()
			end

			if arg_187_1.time_ >= var_190_0 + var_190_10 and arg_187_1.time_ < var_190_0 + var_190_10 + arg_190_0 then
				arg_187_1.typewritter.percent = 1

				arg_187_1.typewritter:SetDirty()
				arg_187_1:ShowNextGo(true)
			end
		end

		arg_187_1.nodeConfigList_ = {}

		arg_187_1:InitPlayNodeList()
	end,
	Play410251045 = function(arg_191_0, arg_191_1)
		arg_191_1.time_ = 0
		arg_191_1.frameCnt_ = 0
		arg_191_1.state_ = "playing"
		arg_191_1.curTalkId_ = 410251045
		arg_191_1.duration_ = 5

		SetActive(arg_191_1.tipsGo_, false)

		function arg_191_1.onSingleLineFinish_()
			arg_191_1.onSingleLineUpdate_ = nil
			arg_191_1.onSingleLineFinish_ = nil
			arg_191_1.state_ = "waiting"
		end

		function arg_191_1.playNext_(arg_193_0)
			if arg_193_0 == 1 then
				arg_191_0:Play410251046(arg_191_1)
			end
		end

		function arg_191_1.onSingleLineUpdate_(arg_194_0)
			local var_194_0 = 0
			local var_194_1 = 1

			if var_194_0 < arg_191_1.time_ and arg_191_1.time_ <= var_194_0 + arg_194_0 then
				arg_191_1.talkMaxDuration = 0
				arg_191_1.dialogCg_.alpha = 1

				arg_191_1.dialog_:SetActive(true)
				SetActive(arg_191_1.leftNameGo_, false)

				arg_191_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_191_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_191_1:RecordName(arg_191_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_191_1.iconTrs_.gameObject, false)
				arg_191_1.callingController_:SetSelectedState("normal")

				local var_194_2 = arg_191_1:GetWordFromCfg(410251045)
				local var_194_3 = arg_191_1:FormatText(var_194_2.content)

				arg_191_1.text_.text = var_194_3

				LuaForUtil.ClearLinePrefixSymbol(arg_191_1.text_)

				local var_194_4 = 40
				local var_194_5 = utf8.len(var_194_3)
				local var_194_6 = var_194_4 <= 0 and var_194_1 or var_194_1 * (var_194_5 / var_194_4)

				if var_194_6 > 0 and var_194_1 < var_194_6 then
					arg_191_1.talkMaxDuration = var_194_6

					if var_194_6 + var_194_0 > arg_191_1.duration_ then
						arg_191_1.duration_ = var_194_6 + var_194_0
					end
				end

				arg_191_1.text_.text = var_194_3
				arg_191_1.typewritter.percent = 0

				arg_191_1.typewritter:SetDirty()
				arg_191_1:ShowNextGo(false)
				arg_191_1:RecordContent(arg_191_1.text_.text)
			end

			local var_194_7 = math.max(var_194_1, arg_191_1.talkMaxDuration)

			if var_194_0 <= arg_191_1.time_ and arg_191_1.time_ < var_194_0 + var_194_7 then
				arg_191_1.typewritter.percent = (arg_191_1.time_ - var_194_0) / var_194_7

				arg_191_1.typewritter:SetDirty()
			end

			if arg_191_1.time_ >= var_194_0 + var_194_7 and arg_191_1.time_ < var_194_0 + var_194_7 + arg_194_0 then
				arg_191_1.typewritter.percent = 1

				arg_191_1.typewritter:SetDirty()
				arg_191_1:ShowNextGo(true)
			end
		end

		arg_191_1.nodeConfigList_ = {}

		arg_191_1:InitPlayNodeList()
	end,
	Play410251046 = function(arg_195_0, arg_195_1)
		arg_195_1.time_ = 0
		arg_195_1.frameCnt_ = 0
		arg_195_1.state_ = "playing"
		arg_195_1.curTalkId_ = 410251046
		arg_195_1.duration_ = 5

		SetActive(arg_195_1.tipsGo_, false)

		function arg_195_1.onSingleLineFinish_()
			arg_195_1.onSingleLineUpdate_ = nil
			arg_195_1.onSingleLineFinish_ = nil
			arg_195_1.state_ = "waiting"
			arg_195_1.auto_ = false
		end

		function arg_195_1.playNext_(arg_197_0)
			arg_195_1.onStoryFinished_()
		end

		function arg_195_1.onSingleLineUpdate_(arg_198_0)
			local var_198_0 = 0
			local var_198_1 = 0.85

			if var_198_0 < arg_195_1.time_ and arg_195_1.time_ <= var_198_0 + arg_198_0 then
				arg_195_1.talkMaxDuration = 0
				arg_195_1.dialogCg_.alpha = 1

				arg_195_1.dialog_:SetActive(true)
				SetActive(arg_195_1.leftNameGo_, false)

				arg_195_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_195_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_195_1:RecordName(arg_195_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_195_1.iconTrs_.gameObject, false)
				arg_195_1.callingController_:SetSelectedState("normal")

				local var_198_2 = arg_195_1:GetWordFromCfg(410251046)
				local var_198_3 = arg_195_1:FormatText(var_198_2.content)

				arg_195_1.text_.text = var_198_3

				LuaForUtil.ClearLinePrefixSymbol(arg_195_1.text_)

				local var_198_4 = 34
				local var_198_5 = utf8.len(var_198_3)
				local var_198_6 = var_198_4 <= 0 and var_198_1 or var_198_1 * (var_198_5 / var_198_4)

				if var_198_6 > 0 and var_198_1 < var_198_6 then
					arg_195_1.talkMaxDuration = var_198_6

					if var_198_6 + var_198_0 > arg_195_1.duration_ then
						arg_195_1.duration_ = var_198_6 + var_198_0
					end
				end

				arg_195_1.text_.text = var_198_3
				arg_195_1.typewritter.percent = 0

				arg_195_1.typewritter:SetDirty()
				arg_195_1:ShowNextGo(false)
				arg_195_1:RecordContent(arg_195_1.text_.text)
			end

			local var_198_7 = math.max(var_198_1, arg_195_1.talkMaxDuration)

			if var_198_0 <= arg_195_1.time_ and arg_195_1.time_ < var_198_0 + var_198_7 then
				arg_195_1.typewritter.percent = (arg_195_1.time_ - var_198_0) / var_198_7

				arg_195_1.typewritter:SetDirty()
			end

			if arg_195_1.time_ >= var_198_0 + var_198_7 and arg_195_1.time_ < var_198_0 + var_198_7 + arg_198_0 then
				arg_195_1.typewritter.percent = 1

				arg_195_1.typewritter:SetDirty()
				arg_195_1:ShowNextGo(true)
			end
		end

		arg_195_1.nodeConfigList_ = {}

		arg_195_1:InitPlayNodeList()
	end,
	assets = {
		"TextureConfig/Background/ST62",
		"TextureConfig/Background/L04h",
		"TextureConfig/Background/STwhite",
		"TextureConfig/Background/LZ0208"
	},
	voices = {
		"story_v_out_410251.awb"
	}
}
