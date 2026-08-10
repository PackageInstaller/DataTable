return {
	Play410142001 = function(arg_1_0, arg_1_1)
		arg_1_1.time_ = 0
		arg_1_1.frameCnt_ = 0
		arg_1_1.state_ = "playing"
		arg_1_1.curTalkId_ = 410142001
		arg_1_1.duration_ = 5

		local var_1_0 = {
			ja = 5,
			CriLanguages = 3.333,
			zh = 3.333
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
				arg_1_0:Play410142002(arg_1_1)
			end
		end

		function arg_1_1.onSingleLineUpdate_(arg_4_0)
			local var_4_0 = "ST61"

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
				local var_4_5 = arg_1_1.bgs_.ST61

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
					if iter_4_0 ~= "ST61" then
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

			local var_4_22 = "1061"

			if arg_1_1.actors_[var_4_22] == nil then
				local var_4_23 = Asset.Load("Widget/System/Story/StoryExpression/" .. "1061")

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

			local var_4_26 = arg_1_1.actors_["1061"].transform
			local var_4_27 = 2

			if var_4_27 < arg_1_1.time_ and arg_1_1.time_ <= var_4_27 + arg_4_0 then
				arg_1_1.var_.moveOldPos1061 = var_4_26.localPosition
				var_4_26.localScale = Vector3.New(1, 1, 1)

				arg_1_1:CheckSpriteTmpPos("1061", 3)

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
				local var_4_32 = Vector3.New(0, -490, 18)

				var_4_26.localPosition = Vector3.Lerp(arg_1_1.var_.moveOldPos1061, var_4_32, var_4_31)
			end

			if arg_1_1.time_ >= var_4_27 + var_4_30 and arg_1_1.time_ < var_4_27 + var_4_30 + arg_4_0 then
				var_4_26.localPosition = Vector3.New(0, -490, 18)
			end

			local var_4_33 = arg_1_1.actors_["1061"]
			local var_4_34 = 2

			if var_4_34 < arg_1_1.time_ and arg_1_1.time_ <= var_4_34 + arg_4_0 and not isNil(var_4_33) and arg_1_1.var_.actorSpriteComps1061 == nil then
				arg_1_1.var_.actorSpriteComps1061 = var_4_33:GetComponentsInChildren(typeof(Image), true)
			end

			local var_4_35 = 0.0339999999999998

			if var_4_34 <= arg_1_1.time_ and arg_1_1.time_ < var_4_34 + var_4_35 and not isNil(var_4_33) then
				local var_4_36 = (arg_1_1.time_ - var_4_34) / var_4_35

				if arg_1_1.var_.actorSpriteComps1061 then
					for iter_4_5, iter_4_6 in pairs(arg_1_1.var_.actorSpriteComps1061:ToTable()) do
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

			if arg_1_1.time_ >= var_4_34 + var_4_35 and arg_1_1.time_ < var_4_34 + var_4_35 + arg_4_0 and not isNil(var_4_33) and arg_1_1.var_.actorSpriteComps1061 then
				for iter_4_7, iter_4_8 in pairs(arg_1_1.var_.actorSpriteComps1061:ToTable()) do
					if iter_4_8 then
						if arg_1_1.isInRecall_ then
							iter_4_8.color = arg_1_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_4_8.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_1_1.var_.actorSpriteComps1061 = nil
			end

			local var_4_41 = 0
			local var_4_42 = 0.466666666666667

			if var_4_41 < arg_1_1.time_ and arg_1_1.time_ <= var_4_41 + arg_4_0 then
				local var_4_43 = "play"
				local var_4_44 = "music"

				arg_1_1:AudioAction(var_4_43, var_4_44, "ui_battle", "ui_battle_stopbgm", "")

				local var_4_45 = ""
				local var_4_46 = manager.audio:GetAudioName("ui_battle", "ui_battle_stopbgm")

				if var_4_46 ~= "" then
					if arg_1_1.bgmTxt_.text ~= var_4_46 and arg_1_1.bgmTxt_.text ~= "" then
						if arg_1_1.bgmTxt2_.text ~= "" then
							arg_1_1.bgmTxt_.text = arg_1_1.bgmTxt2_.text
						end

						arg_1_1.bgmTxt2_.text = var_4_46

						arg_1_1.musicChangeAnimator_:Play("music_change", 0, 0)
					else
						arg_1_1.bgmTxt_.text = var_4_46
						arg_1_1.bgmTxt2_.text = var_4_46
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

			local var_4_47 = 0.666666666666667
			local var_4_48 = 1

			if var_4_47 < arg_1_1.time_ and arg_1_1.time_ <= var_4_47 + arg_4_0 then
				local var_4_49 = "play"
				local var_4_50 = "music"

				arg_1_1:AudioAction(var_4_49, var_4_50, "bgm_activity_2_8_story_meruism", "bgm_activity_2_8_story_meruism", "bgm_activity_2_8_story_meruism.awb")

				local var_4_51 = ""
				local var_4_52 = manager.audio:GetAudioName("bgm_activity_2_8_story_meruism", "bgm_activity_2_8_story_meruism")

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

			if arg_1_1.frameCnt_ <= 1 then
				arg_1_1.dialog_:SetActive(false)
			end

			local var_4_53 = 2
			local var_4_54 = 0.125

			if var_4_53 < arg_1_1.time_ and arg_1_1.time_ <= var_4_53 + arg_4_0 then
				arg_1_1.talkMaxDuration = 0

				arg_1_1.dialog_:SetActive(true)

				arg_1_1.dialogCg_.alpha = 0

				local var_4_55 = LeanTween.value(arg_1_1.dialog_, 0, 1, 0.3)

				var_4_55:setOnUpdate(LuaHelper.FloatAction(function(arg_7_0)
					arg_1_1.dialogCg_.alpha = arg_7_0
				end))
				var_4_55:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_1_1.dialog_)
					var_4_55:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_1_1.duration_ = arg_1_1.duration_ + 0.3

				SetActive(arg_1_1.leftNameGo_, true)

				local var_4_56 = arg_1_1:FormatText(StoryNameCfg[612].name)

				arg_1_1.leftNameTxt_.text = var_4_56

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_1_1.leftNameTxt_.transform)

				arg_1_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_1_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_1_1:RecordName(arg_1_1.leftNameTxt_.text)
				SetActive(arg_1_1.iconTrs_.gameObject, false)
				arg_1_1.callingController_:SetSelectedState("normal")

				local var_4_57 = arg_1_1:GetWordFromCfg(410142001)
				local var_4_58 = arg_1_1:FormatText(var_4_57.content)

				arg_1_1.text_.text = var_4_58

				LuaForUtil.ClearLinePrefixSymbol(arg_1_1.text_)

				local var_4_59 = 5
				local var_4_60 = utf8.len(var_4_58)
				local var_4_61 = var_4_59 <= 0 and var_4_54 or var_4_54 * (var_4_60 / var_4_59)

				if var_4_61 > 0 and var_4_54 < var_4_61 then
					arg_1_1.talkMaxDuration = var_4_61
					var_4_53 = var_4_53 + 0.3

					if var_4_61 + var_4_53 > arg_1_1.duration_ then
						arg_1_1.duration_ = var_4_61 + var_4_53
					end
				end

				arg_1_1.text_.text = var_4_58
				arg_1_1.typewritter.percent = 0

				arg_1_1.typewritter:SetDirty()
				arg_1_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_410142", "410142001", "story_v_out_410142.awb") ~= 0 then
					local var_4_62 = manager.audio:GetVoiceLength("story_v_out_410142", "410142001", "story_v_out_410142.awb") / 1000

					if var_4_62 + var_4_53 > arg_1_1.duration_ then
						arg_1_1.duration_ = var_4_62 + var_4_53
					end

					if var_4_57.prefab_name ~= "" and arg_1_1.actors_[var_4_57.prefab_name] ~= nil then
						local var_4_63 = LuaForUtil.PlayVoiceWithCriLipsync(arg_1_1.actors_[var_4_57.prefab_name].transform, "story_v_out_410142", "410142001", "story_v_out_410142.awb")

						arg_1_1:RecordAudio("410142001", var_4_63)
						arg_1_1:RecordAudio("410142001", var_4_63)
					else
						arg_1_1:AudioAction("play", "voice", "story_v_out_410142", "410142001", "story_v_out_410142.awb")
					end

					arg_1_1:RecordHistoryTalkVoice("story_v_out_410142", "410142001", "story_v_out_410142.awb")
				end

				arg_1_1:RecordContent(arg_1_1.text_.text)
			end

			local var_4_64 = var_4_53 + 0.3
			local var_4_65 = math.max(var_4_54, arg_1_1.talkMaxDuration)

			if var_4_64 <= arg_1_1.time_ and arg_1_1.time_ < var_4_64 + var_4_65 then
				arg_1_1.typewritter.percent = (arg_1_1.time_ - var_4_64) / var_4_65

				arg_1_1.typewritter:SetDirty()
			end

			if arg_1_1.time_ >= var_4_64 + var_4_65 and arg_1_1.time_ < var_4_64 + var_4_65 + arg_4_0 then
				arg_1_1.typewritter.percent = 1

				arg_1_1.typewritter:SetDirty()
				arg_1_1:ShowNextGo(true)
			end
		end

		arg_1_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1061",
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
	Play410142002 = function(arg_9_0, arg_9_1)
		arg_9_1.time_ = 0
		arg_9_1.frameCnt_ = 0
		arg_9_1.state_ = "playing"
		arg_9_1.curTalkId_ = 410142002
		arg_9_1.duration_ = 5

		SetActive(arg_9_1.tipsGo_, false)

		function arg_9_1.onSingleLineFinish_()
			arg_9_1.onSingleLineUpdate_ = nil
			arg_9_1.onSingleLineFinish_ = nil
			arg_9_1.state_ = "waiting"
		end

		function arg_9_1.playNext_(arg_11_0)
			if arg_11_0 == 1 then
				arg_9_0:Play410142003(arg_9_1)
			end
		end

		function arg_9_1.onSingleLineUpdate_(arg_12_0)
			local var_12_0 = 0
			local var_12_1 = 0.466666666666667

			if var_12_0 < arg_9_1.time_ and arg_9_1.time_ <= var_12_0 + arg_12_0 then
				local var_12_2 = "play"
				local var_12_3 = "effect"

				arg_9_1:AudioAction(var_12_2, var_12_3, "se_story_123_01", "se_story_123_01_map", "")
			end

			local var_12_4 = arg_9_1.actors_["1061"]
			local var_12_5 = 0

			if var_12_5 < arg_9_1.time_ and arg_9_1.time_ <= var_12_5 + arg_12_0 and not isNil(var_12_4) and arg_9_1.var_.actorSpriteComps1061 == nil then
				arg_9_1.var_.actorSpriteComps1061 = var_12_4:GetComponentsInChildren(typeof(Image), true)
			end

			local var_12_6 = 0.034

			if var_12_5 <= arg_9_1.time_ and arg_9_1.time_ < var_12_5 + var_12_6 and not isNil(var_12_4) then
				local var_12_7 = (arg_9_1.time_ - var_12_5) / var_12_6

				if arg_9_1.var_.actorSpriteComps1061 then
					for iter_12_0, iter_12_1 in pairs(arg_9_1.var_.actorSpriteComps1061:ToTable()) do
						if iter_12_1 then
							if arg_9_1.isInRecall_ then
								local var_12_8 = Mathf.Lerp(iter_12_1.color.r, arg_9_1.hightColor2.r, var_12_7)
								local var_12_9 = Mathf.Lerp(iter_12_1.color.g, arg_9_1.hightColor2.g, var_12_7)
								local var_12_10 = Mathf.Lerp(iter_12_1.color.b, arg_9_1.hightColor2.b, var_12_7)

								iter_12_1.color = Color.New(var_12_8, var_12_9, var_12_10)
							else
								local var_12_11 = Mathf.Lerp(iter_12_1.color.r, 0.5, var_12_7)

								iter_12_1.color = Color.New(var_12_11, var_12_11, var_12_11)
							end
						end
					end
				end
			end

			if arg_9_1.time_ >= var_12_5 + var_12_6 and arg_9_1.time_ < var_12_5 + var_12_6 + arg_12_0 and not isNil(var_12_4) and arg_9_1.var_.actorSpriteComps1061 then
				for iter_12_2, iter_12_3 in pairs(arg_9_1.var_.actorSpriteComps1061:ToTable()) do
					if iter_12_3 then
						if arg_9_1.isInRecall_ then
							iter_12_3.color = arg_9_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_12_3.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_9_1.var_.actorSpriteComps1061 = nil
			end

			local var_12_12 = 0
			local var_12_13 = 1.1

			if var_12_12 < arg_9_1.time_ and arg_9_1.time_ <= var_12_12 + arg_12_0 then
				arg_9_1.talkMaxDuration = 0
				arg_9_1.dialogCg_.alpha = 1

				arg_9_1.dialog_:SetActive(true)
				SetActive(arg_9_1.leftNameGo_, false)

				arg_9_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_9_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_9_1:RecordName(arg_9_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_9_1.iconTrs_.gameObject, false)
				arg_9_1.callingController_:SetSelectedState("normal")

				local var_12_14 = arg_9_1:GetWordFromCfg(410142002)
				local var_12_15 = arg_9_1:FormatText(var_12_14.content)

				arg_9_1.text_.text = var_12_15

				LuaForUtil.ClearLinePrefixSymbol(arg_9_1.text_)

				local var_12_16 = 44
				local var_12_17 = utf8.len(var_12_15)
				local var_12_18 = var_12_16 <= 0 and var_12_13 or var_12_13 * (var_12_17 / var_12_16)

				if var_12_18 > 0 and var_12_13 < var_12_18 then
					arg_9_1.talkMaxDuration = var_12_18

					if var_12_18 + var_12_12 > arg_9_1.duration_ then
						arg_9_1.duration_ = var_12_18 + var_12_12
					end
				end

				arg_9_1.text_.text = var_12_15
				arg_9_1.typewritter.percent = 0

				arg_9_1.typewritter:SetDirty()
				arg_9_1:ShowNextGo(false)
				arg_9_1:RecordContent(arg_9_1.text_.text)
			end

			local var_12_19 = math.max(var_12_13, arg_9_1.talkMaxDuration)

			if var_12_12 <= arg_9_1.time_ and arg_9_1.time_ < var_12_12 + var_12_19 then
				arg_9_1.typewritter.percent = (arg_9_1.time_ - var_12_12) / var_12_19

				arg_9_1.typewritter:SetDirty()
			end

			if arg_9_1.time_ >= var_12_12 + var_12_19 and arg_9_1.time_ < var_12_12 + var_12_19 + arg_12_0 then
				arg_9_1.typewritter.percent = 1

				arg_9_1.typewritter:SetDirty()
				arg_9_1:ShowNextGo(true)
			end
		end

		arg_9_1.nodeConfigList_ = {}

		arg_9_1:InitPlayNodeList()
	end,
	Play410142003 = function(arg_13_0, arg_13_1)
		arg_13_1.time_ = 0
		arg_13_1.frameCnt_ = 0
		arg_13_1.state_ = "playing"
		arg_13_1.curTalkId_ = 410142003
		arg_13_1.duration_ = 17.4

		local var_13_0 = {
			ja = 17.4,
			CriLanguages = 10.1,
			zh = 10.1
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
				arg_13_0:Play410142004(arg_13_1)
			end
		end

		function arg_13_1.onSingleLineUpdate_(arg_16_0)
			local var_16_0 = arg_13_1.actors_["1061"].transform
			local var_16_1 = 0

			if var_16_1 < arg_13_1.time_ and arg_13_1.time_ <= var_16_1 + arg_16_0 then
				arg_13_1.var_.moveOldPos1061 = var_16_0.localPosition
				var_16_0.localScale = Vector3.New(1, 1, 1)

				arg_13_1:CheckSpriteTmpPos("1061", 2)

				local var_16_2 = var_16_0.childCount

				for iter_16_0 = 0, var_16_2 - 1 do
					local var_16_3 = var_16_0:GetChild(iter_16_0)

					if var_16_3.name == "" or not string.find(var_16_3.name, "split") then
						var_16_3.gameObject:SetActive(true)
					else
						var_16_3.gameObject:SetActive(false)
					end
				end
			end

			local var_16_4 = 0.001

			if var_16_1 <= arg_13_1.time_ and arg_13_1.time_ < var_16_1 + var_16_4 then
				local var_16_5 = (arg_13_1.time_ - var_16_1) / var_16_4
				local var_16_6 = Vector3.New(-390, -490, 18)

				var_16_0.localPosition = Vector3.Lerp(arg_13_1.var_.moveOldPos1061, var_16_6, var_16_5)
			end

			if arg_13_1.time_ >= var_16_1 + var_16_4 and arg_13_1.time_ < var_16_1 + var_16_4 + arg_16_0 then
				var_16_0.localPosition = Vector3.New(-390, -490, 18)
			end

			local var_16_7 = "1056"

			if arg_13_1.actors_[var_16_7] == nil then
				local var_16_8 = Asset.Load("Widget/System/Story/StoryExpression/" .. "1056")

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

			local var_16_11 = arg_13_1.actors_["1056"].transform
			local var_16_12 = 0

			if var_16_12 < arg_13_1.time_ and arg_13_1.time_ <= var_16_12 + arg_16_0 then
				arg_13_1.var_.moveOldPos1056 = var_16_11.localPosition
				var_16_11.localScale = Vector3.New(1, 1, 1)

				arg_13_1:CheckSpriteTmpPos("1056", 4)

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
				local var_16_17 = Vector3.New(390, -350, -180)

				var_16_11.localPosition = Vector3.Lerp(arg_13_1.var_.moveOldPos1056, var_16_17, var_16_16)
			end

			if arg_13_1.time_ >= var_16_12 + var_16_15 and arg_13_1.time_ < var_16_12 + var_16_15 + arg_16_0 then
				var_16_11.localPosition = Vector3.New(390, -350, -180)
			end

			local var_16_18 = arg_13_1.actors_["1061"]
			local var_16_19 = 0

			if var_16_19 < arg_13_1.time_ and arg_13_1.time_ <= var_16_19 + arg_16_0 and not isNil(var_16_18) and arg_13_1.var_.actorSpriteComps1061 == nil then
				arg_13_1.var_.actorSpriteComps1061 = var_16_18:GetComponentsInChildren(typeof(Image), true)
			end

			local var_16_20 = 0.034

			if var_16_19 <= arg_13_1.time_ and arg_13_1.time_ < var_16_19 + var_16_20 and not isNil(var_16_18) then
				local var_16_21 = (arg_13_1.time_ - var_16_19) / var_16_20

				if arg_13_1.var_.actorSpriteComps1061 then
					for iter_16_4, iter_16_5 in pairs(arg_13_1.var_.actorSpriteComps1061:ToTable()) do
						if iter_16_5 then
							if arg_13_1.isInRecall_ then
								local var_16_22 = Mathf.Lerp(iter_16_5.color.r, arg_13_1.hightColor1.r, var_16_21)
								local var_16_23 = Mathf.Lerp(iter_16_5.color.g, arg_13_1.hightColor1.g, var_16_21)
								local var_16_24 = Mathf.Lerp(iter_16_5.color.b, arg_13_1.hightColor1.b, var_16_21)

								iter_16_5.color = Color.New(var_16_22, var_16_23, var_16_24)
							else
								local var_16_25 = Mathf.Lerp(iter_16_5.color.r, 1, var_16_21)

								iter_16_5.color = Color.New(var_16_25, var_16_25, var_16_25)
							end
						end
					end
				end
			end

			if arg_13_1.time_ >= var_16_19 + var_16_20 and arg_13_1.time_ < var_16_19 + var_16_20 + arg_16_0 and not isNil(var_16_18) and arg_13_1.var_.actorSpriteComps1061 then
				for iter_16_6, iter_16_7 in pairs(arg_13_1.var_.actorSpriteComps1061:ToTable()) do
					if iter_16_7 then
						if arg_13_1.isInRecall_ then
							iter_16_7.color = arg_13_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_16_7.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_13_1.var_.actorSpriteComps1061 = nil
			end

			local var_16_26 = arg_13_1.actors_["1056"]
			local var_16_27 = 0

			if var_16_27 < arg_13_1.time_ and arg_13_1.time_ <= var_16_27 + arg_16_0 and not isNil(var_16_26) and arg_13_1.var_.actorSpriteComps1056 == nil then
				arg_13_1.var_.actorSpriteComps1056 = var_16_26:GetComponentsInChildren(typeof(Image), true)
			end

			local var_16_28 = 0.034

			if var_16_27 <= arg_13_1.time_ and arg_13_1.time_ < var_16_27 + var_16_28 and not isNil(var_16_26) then
				local var_16_29 = (arg_13_1.time_ - var_16_27) / var_16_28

				if arg_13_1.var_.actorSpriteComps1056 then
					for iter_16_8, iter_16_9 in pairs(arg_13_1.var_.actorSpriteComps1056:ToTable()) do
						if iter_16_9 then
							if arg_13_1.isInRecall_ then
								local var_16_30 = Mathf.Lerp(iter_16_9.color.r, arg_13_1.hightColor2.r, var_16_29)
								local var_16_31 = Mathf.Lerp(iter_16_9.color.g, arg_13_1.hightColor2.g, var_16_29)
								local var_16_32 = Mathf.Lerp(iter_16_9.color.b, arg_13_1.hightColor2.b, var_16_29)

								iter_16_9.color = Color.New(var_16_30, var_16_31, var_16_32)
							else
								local var_16_33 = Mathf.Lerp(iter_16_9.color.r, 0.5, var_16_29)

								iter_16_9.color = Color.New(var_16_33, var_16_33, var_16_33)
							end
						end
					end
				end
			end

			if arg_13_1.time_ >= var_16_27 + var_16_28 and arg_13_1.time_ < var_16_27 + var_16_28 + arg_16_0 and not isNil(var_16_26) and arg_13_1.var_.actorSpriteComps1056 then
				for iter_16_10, iter_16_11 in pairs(arg_13_1.var_.actorSpriteComps1056:ToTable()) do
					if iter_16_11 then
						if arg_13_1.isInRecall_ then
							iter_16_11.color = arg_13_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_16_11.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_13_1.var_.actorSpriteComps1056 = nil
			end

			local var_16_34 = 0
			local var_16_35 = 1.125

			if var_16_34 < arg_13_1.time_ and arg_13_1.time_ <= var_16_34 + arg_16_0 then
				arg_13_1.talkMaxDuration = 0
				arg_13_1.dialogCg_.alpha = 1

				arg_13_1.dialog_:SetActive(true)
				SetActive(arg_13_1.leftNameGo_, true)

				local var_16_36 = arg_13_1:FormatText(StoryNameCfg[612].name)

				arg_13_1.leftNameTxt_.text = var_16_36

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_13_1.leftNameTxt_.transform)

				arg_13_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_13_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_13_1:RecordName(arg_13_1.leftNameTxt_.text)
				SetActive(arg_13_1.iconTrs_.gameObject, false)
				arg_13_1.callingController_:SetSelectedState("normal")

				local var_16_37 = arg_13_1:GetWordFromCfg(410142003)
				local var_16_38 = arg_13_1:FormatText(var_16_37.content)

				arg_13_1.text_.text = var_16_38

				LuaForUtil.ClearLinePrefixSymbol(arg_13_1.text_)

				local var_16_39 = 45
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

				if manager.audio:GetVoiceLength("story_v_out_410142", "410142003", "story_v_out_410142.awb") ~= 0 then
					local var_16_42 = manager.audio:GetVoiceLength("story_v_out_410142", "410142003", "story_v_out_410142.awb") / 1000

					if var_16_42 + var_16_34 > arg_13_1.duration_ then
						arg_13_1.duration_ = var_16_42 + var_16_34
					end

					if var_16_37.prefab_name ~= "" and arg_13_1.actors_[var_16_37.prefab_name] ~= nil then
						local var_16_43 = LuaForUtil.PlayVoiceWithCriLipsync(arg_13_1.actors_[var_16_37.prefab_name].transform, "story_v_out_410142", "410142003", "story_v_out_410142.awb")

						arg_13_1:RecordAudio("410142003", var_16_43)
						arg_13_1:RecordAudio("410142003", var_16_43)
					else
						arg_13_1:AudioAction("play", "voice", "story_v_out_410142", "410142003", "story_v_out_410142.awb")
					end

					arg_13_1:RecordHistoryTalkVoice("story_v_out_410142", "410142003", "story_v_out_410142.awb")
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
				actorName = "1061",
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

		arg_13_1:InitPlayNodeList()
	end,
	Play410142004 = function(arg_17_0, arg_17_1)
		arg_17_1.time_ = 0
		arg_17_1.frameCnt_ = 0
		arg_17_1.state_ = "playing"
		arg_17_1.curTalkId_ = 410142004
		arg_17_1.duration_ = 17.73

		local var_17_0 = {
			ja = 17.733,
			CriLanguages = 7.9,
			zh = 7.9
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
				arg_17_0:Play410142005(arg_17_1)
			end
		end

		function arg_17_1.onSingleLineUpdate_(arg_20_0)
			local var_20_0 = arg_17_1.actors_["1061"].transform
			local var_20_1 = 0

			if var_20_1 < arg_17_1.time_ and arg_17_1.time_ <= var_20_1 + arg_20_0 then
				arg_17_1.var_.moveOldPos1061 = var_20_0.localPosition
				var_20_0.localScale = Vector3.New(1, 1, 1)

				arg_17_1:CheckSpriteTmpPos("1061", 2)

				local var_20_2 = var_20_0.childCount

				for iter_20_0 = 0, var_20_2 - 1 do
					local var_20_3 = var_20_0:GetChild(iter_20_0)

					if var_20_3.name == "split_2" or not string.find(var_20_3.name, "split") then
						var_20_3.gameObject:SetActive(true)
					else
						var_20_3.gameObject:SetActive(false)
					end
				end
			end

			local var_20_4 = 0.001

			if var_20_1 <= arg_17_1.time_ and arg_17_1.time_ < var_20_1 + var_20_4 then
				local var_20_5 = (arg_17_1.time_ - var_20_1) / var_20_4
				local var_20_6 = Vector3.New(-390, -490, 18)

				var_20_0.localPosition = Vector3.Lerp(arg_17_1.var_.moveOldPos1061, var_20_6, var_20_5)
			end

			if arg_17_1.time_ >= var_20_1 + var_20_4 and arg_17_1.time_ < var_20_1 + var_20_4 + arg_20_0 then
				var_20_0.localPosition = Vector3.New(-390, -490, 18)
			end

			local var_20_7 = arg_17_1.actors_["1061"]
			local var_20_8 = 0

			if var_20_8 < arg_17_1.time_ and arg_17_1.time_ <= var_20_8 + arg_20_0 and not isNil(var_20_7) and arg_17_1.var_.actorSpriteComps1061 == nil then
				arg_17_1.var_.actorSpriteComps1061 = var_20_7:GetComponentsInChildren(typeof(Image), true)
			end

			local var_20_9 = 0.034

			if var_20_8 <= arg_17_1.time_ and arg_17_1.time_ < var_20_8 + var_20_9 and not isNil(var_20_7) then
				local var_20_10 = (arg_17_1.time_ - var_20_8) / var_20_9

				if arg_17_1.var_.actorSpriteComps1061 then
					for iter_20_1, iter_20_2 in pairs(arg_17_1.var_.actorSpriteComps1061:ToTable()) do
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

			if arg_17_1.time_ >= var_20_8 + var_20_9 and arg_17_1.time_ < var_20_8 + var_20_9 + arg_20_0 and not isNil(var_20_7) and arg_17_1.var_.actorSpriteComps1061 then
				for iter_20_3, iter_20_4 in pairs(arg_17_1.var_.actorSpriteComps1061:ToTable()) do
					if iter_20_4 then
						if arg_17_1.isInRecall_ then
							iter_20_4.color = arg_17_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_20_4.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_17_1.var_.actorSpriteComps1061 = nil
			end

			local var_20_15 = 0
			local var_20_16 = 0.925

			if var_20_15 < arg_17_1.time_ and arg_17_1.time_ <= var_20_15 + arg_20_0 then
				arg_17_1.talkMaxDuration = 0
				arg_17_1.dialogCg_.alpha = 1

				arg_17_1.dialog_:SetActive(true)
				SetActive(arg_17_1.leftNameGo_, true)

				local var_20_17 = arg_17_1:FormatText(StoryNameCfg[612].name)

				arg_17_1.leftNameTxt_.text = var_20_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_17_1.leftNameTxt_.transform)

				arg_17_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_17_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_17_1:RecordName(arg_17_1.leftNameTxt_.text)
				SetActive(arg_17_1.iconTrs_.gameObject, false)
				arg_17_1.callingController_:SetSelectedState("normal")

				local var_20_18 = arg_17_1:GetWordFromCfg(410142004)
				local var_20_19 = arg_17_1:FormatText(var_20_18.content)

				arg_17_1.text_.text = var_20_19

				LuaForUtil.ClearLinePrefixSymbol(arg_17_1.text_)

				local var_20_20 = 37
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

				if manager.audio:GetVoiceLength("story_v_out_410142", "410142004", "story_v_out_410142.awb") ~= 0 then
					local var_20_23 = manager.audio:GetVoiceLength("story_v_out_410142", "410142004", "story_v_out_410142.awb") / 1000

					if var_20_23 + var_20_15 > arg_17_1.duration_ then
						arg_17_1.duration_ = var_20_23 + var_20_15
					end

					if var_20_18.prefab_name ~= "" and arg_17_1.actors_[var_20_18.prefab_name] ~= nil then
						local var_20_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_17_1.actors_[var_20_18.prefab_name].transform, "story_v_out_410142", "410142004", "story_v_out_410142.awb")

						arg_17_1:RecordAudio("410142004", var_20_24)
						arg_17_1:RecordAudio("410142004", var_20_24)
					else
						arg_17_1:AudioAction("play", "voice", "story_v_out_410142", "410142004", "story_v_out_410142.awb")
					end

					arg_17_1:RecordHistoryTalkVoice("story_v_out_410142", "410142004", "story_v_out_410142.awb")
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
				actorName = "1061",
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
	Play410142005 = function(arg_21_0, arg_21_1)
		arg_21_1.time_ = 0
		arg_21_1.frameCnt_ = 0
		arg_21_1.state_ = "playing"
		arg_21_1.curTalkId_ = 410142005
		arg_21_1.duration_ = 8.5

		local var_21_0 = {
			ja = 8.5,
			CriLanguages = 4.6,
			zh = 4.6
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
				arg_21_0:Play410142006(arg_21_1)
			end
		end

		function arg_21_1.onSingleLineUpdate_(arg_24_0)
			local var_24_0 = arg_21_1.actors_["1056"].transform
			local var_24_1 = 0

			if var_24_1 < arg_21_1.time_ and arg_21_1.time_ <= var_24_1 + arg_24_0 then
				arg_21_1.var_.moveOldPos1056 = var_24_0.localPosition
				var_24_0.localScale = Vector3.New(1, 1, 1)

				arg_21_1:CheckSpriteTmpPos("1056", 4)

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
				local var_24_6 = Vector3.New(390, -350, -180)

				var_24_0.localPosition = Vector3.Lerp(arg_21_1.var_.moveOldPos1056, var_24_6, var_24_5)
			end

			if arg_21_1.time_ >= var_24_1 + var_24_4 and arg_21_1.time_ < var_24_1 + var_24_4 + arg_24_0 then
				var_24_0.localPosition = Vector3.New(390, -350, -180)
			end

			local var_24_7 = arg_21_1.actors_["1056"]
			local var_24_8 = 0

			if var_24_8 < arg_21_1.time_ and arg_21_1.time_ <= var_24_8 + arg_24_0 and not isNil(var_24_7) and arg_21_1.var_.actorSpriteComps1056 == nil then
				arg_21_1.var_.actorSpriteComps1056 = var_24_7:GetComponentsInChildren(typeof(Image), true)
			end

			local var_24_9 = 0.034

			if var_24_8 <= arg_21_1.time_ and arg_21_1.time_ < var_24_8 + var_24_9 and not isNil(var_24_7) then
				local var_24_10 = (arg_21_1.time_ - var_24_8) / var_24_9

				if arg_21_1.var_.actorSpriteComps1056 then
					for iter_24_1, iter_24_2 in pairs(arg_21_1.var_.actorSpriteComps1056:ToTable()) do
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

			if arg_21_1.time_ >= var_24_8 + var_24_9 and arg_21_1.time_ < var_24_8 + var_24_9 + arg_24_0 and not isNil(var_24_7) and arg_21_1.var_.actorSpriteComps1056 then
				for iter_24_3, iter_24_4 in pairs(arg_21_1.var_.actorSpriteComps1056:ToTable()) do
					if iter_24_4 then
						if arg_21_1.isInRecall_ then
							iter_24_4.color = arg_21_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_24_4.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_21_1.var_.actorSpriteComps1056 = nil
			end

			local var_24_15 = arg_21_1.actors_["1061"]
			local var_24_16 = 0

			if var_24_16 < arg_21_1.time_ and arg_21_1.time_ <= var_24_16 + arg_24_0 and not isNil(var_24_15) and arg_21_1.var_.actorSpriteComps1061 == nil then
				arg_21_1.var_.actorSpriteComps1061 = var_24_15:GetComponentsInChildren(typeof(Image), true)
			end

			local var_24_17 = 0.034

			if var_24_16 <= arg_21_1.time_ and arg_21_1.time_ < var_24_16 + var_24_17 and not isNil(var_24_15) then
				local var_24_18 = (arg_21_1.time_ - var_24_16) / var_24_17

				if arg_21_1.var_.actorSpriteComps1061 then
					for iter_24_5, iter_24_6 in pairs(arg_21_1.var_.actorSpriteComps1061:ToTable()) do
						if iter_24_6 then
							if arg_21_1.isInRecall_ then
								local var_24_19 = Mathf.Lerp(iter_24_6.color.r, arg_21_1.hightColor2.r, var_24_18)
								local var_24_20 = Mathf.Lerp(iter_24_6.color.g, arg_21_1.hightColor2.g, var_24_18)
								local var_24_21 = Mathf.Lerp(iter_24_6.color.b, arg_21_1.hightColor2.b, var_24_18)

								iter_24_6.color = Color.New(var_24_19, var_24_20, var_24_21)
							else
								local var_24_22 = Mathf.Lerp(iter_24_6.color.r, 0.5, var_24_18)

								iter_24_6.color = Color.New(var_24_22, var_24_22, var_24_22)
							end
						end
					end
				end
			end

			if arg_21_1.time_ >= var_24_16 + var_24_17 and arg_21_1.time_ < var_24_16 + var_24_17 + arg_24_0 and not isNil(var_24_15) and arg_21_1.var_.actorSpriteComps1061 then
				for iter_24_7, iter_24_8 in pairs(arg_21_1.var_.actorSpriteComps1061:ToTable()) do
					if iter_24_8 then
						if arg_21_1.isInRecall_ then
							iter_24_8.color = arg_21_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_24_8.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_21_1.var_.actorSpriteComps1061 = nil
			end

			local var_24_23 = 0
			local var_24_24 = 0.425

			if var_24_23 < arg_21_1.time_ and arg_21_1.time_ <= var_24_23 + arg_24_0 then
				arg_21_1.talkMaxDuration = 0
				arg_21_1.dialogCg_.alpha = 1

				arg_21_1.dialog_:SetActive(true)
				SetActive(arg_21_1.leftNameGo_, true)

				local var_24_25 = arg_21_1:FormatText(StoryNameCfg[605].name)

				arg_21_1.leftNameTxt_.text = var_24_25

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_21_1.leftNameTxt_.transform)

				arg_21_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_21_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_21_1:RecordName(arg_21_1.leftNameTxt_.text)
				SetActive(arg_21_1.iconTrs_.gameObject, false)
				arg_21_1.callingController_:SetSelectedState("normal")

				local var_24_26 = arg_21_1:GetWordFromCfg(410142005)
				local var_24_27 = arg_21_1:FormatText(var_24_26.content)

				arg_21_1.text_.text = var_24_27

				LuaForUtil.ClearLinePrefixSymbol(arg_21_1.text_)

				local var_24_28 = 17
				local var_24_29 = utf8.len(var_24_27)
				local var_24_30 = var_24_28 <= 0 and var_24_24 or var_24_24 * (var_24_29 / var_24_28)

				if var_24_30 > 0 and var_24_24 < var_24_30 then
					arg_21_1.talkMaxDuration = var_24_30

					if var_24_30 + var_24_23 > arg_21_1.duration_ then
						arg_21_1.duration_ = var_24_30 + var_24_23
					end
				end

				arg_21_1.text_.text = var_24_27
				arg_21_1.typewritter.percent = 0

				arg_21_1.typewritter:SetDirty()
				arg_21_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_410142", "410142005", "story_v_out_410142.awb") ~= 0 then
					local var_24_31 = manager.audio:GetVoiceLength("story_v_out_410142", "410142005", "story_v_out_410142.awb") / 1000

					if var_24_31 + var_24_23 > arg_21_1.duration_ then
						arg_21_1.duration_ = var_24_31 + var_24_23
					end

					if var_24_26.prefab_name ~= "" and arg_21_1.actors_[var_24_26.prefab_name] ~= nil then
						local var_24_32 = LuaForUtil.PlayVoiceWithCriLipsync(arg_21_1.actors_[var_24_26.prefab_name].transform, "story_v_out_410142", "410142005", "story_v_out_410142.awb")

						arg_21_1:RecordAudio("410142005", var_24_32)
						arg_21_1:RecordAudio("410142005", var_24_32)
					else
						arg_21_1:AudioAction("play", "voice", "story_v_out_410142", "410142005", "story_v_out_410142.awb")
					end

					arg_21_1:RecordHistoryTalkVoice("story_v_out_410142", "410142005", "story_v_out_410142.awb")
				end

				arg_21_1:RecordContent(arg_21_1.text_.text)
			end

			local var_24_33 = math.max(var_24_24, arg_21_1.talkMaxDuration)

			if var_24_23 <= arg_21_1.time_ and arg_21_1.time_ < var_24_23 + var_24_33 then
				arg_21_1.typewritter.percent = (arg_21_1.time_ - var_24_23) / var_24_33

				arg_21_1.typewritter:SetDirty()
			end

			if arg_21_1.time_ >= var_24_23 + var_24_33 and arg_21_1.time_ < var_24_23 + var_24_33 + arg_24_0 then
				arg_21_1.typewritter.percent = 1

				arg_21_1.typewritter:SetDirty()
				arg_21_1:ShowNextGo(true)
			end
		end

		arg_21_1.nodeConfigList_ = {
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

		arg_21_1:InitPlayNodeList()
	end,
	Play410142006 = function(arg_25_0, arg_25_1)
		arg_25_1.time_ = 0
		arg_25_1.frameCnt_ = 0
		arg_25_1.state_ = "playing"
		arg_25_1.curTalkId_ = 410142006
		arg_25_1.duration_ = 10.3

		local var_25_0 = {
			ja = 10.3,
			CriLanguages = 5.133,
			zh = 5.133
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
				arg_25_0:Play410142007(arg_25_1)
			end
		end

		function arg_25_1.onSingleLineUpdate_(arg_28_0)
			local var_28_0 = arg_25_1.actors_["1061"].transform
			local var_28_1 = 0

			if var_28_1 < arg_25_1.time_ and arg_25_1.time_ <= var_28_1 + arg_28_0 then
				arg_25_1.var_.moveOldPos1061 = var_28_0.localPosition
				var_28_0.localScale = Vector3.New(1, 1, 1)

				arg_25_1:CheckSpriteTmpPos("1061", 2)

				local var_28_2 = var_28_0.childCount

				for iter_28_0 = 0, var_28_2 - 1 do
					local var_28_3 = var_28_0:GetChild(iter_28_0)

					if var_28_3.name == "split_1" or not string.find(var_28_3.name, "split") then
						var_28_3.gameObject:SetActive(true)
					else
						var_28_3.gameObject:SetActive(false)
					end
				end
			end

			local var_28_4 = 0.001

			if var_28_1 <= arg_25_1.time_ and arg_25_1.time_ < var_28_1 + var_28_4 then
				local var_28_5 = (arg_25_1.time_ - var_28_1) / var_28_4
				local var_28_6 = Vector3.New(-390, -490, 18)

				var_28_0.localPosition = Vector3.Lerp(arg_25_1.var_.moveOldPos1061, var_28_6, var_28_5)
			end

			if arg_25_1.time_ >= var_28_1 + var_28_4 and arg_25_1.time_ < var_28_1 + var_28_4 + arg_28_0 then
				var_28_0.localPosition = Vector3.New(-390, -490, 18)
			end

			local var_28_7 = arg_25_1.actors_["1061"]
			local var_28_8 = 0

			if var_28_8 < arg_25_1.time_ and arg_25_1.time_ <= var_28_8 + arg_28_0 and not isNil(var_28_7) and arg_25_1.var_.actorSpriteComps1061 == nil then
				arg_25_1.var_.actorSpriteComps1061 = var_28_7:GetComponentsInChildren(typeof(Image), true)
			end

			local var_28_9 = 0.034

			if var_28_8 <= arg_25_1.time_ and arg_25_1.time_ < var_28_8 + var_28_9 and not isNil(var_28_7) then
				local var_28_10 = (arg_25_1.time_ - var_28_8) / var_28_9

				if arg_25_1.var_.actorSpriteComps1061 then
					for iter_28_1, iter_28_2 in pairs(arg_25_1.var_.actorSpriteComps1061:ToTable()) do
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

			if arg_25_1.time_ >= var_28_8 + var_28_9 and arg_25_1.time_ < var_28_8 + var_28_9 + arg_28_0 and not isNil(var_28_7) and arg_25_1.var_.actorSpriteComps1061 then
				for iter_28_3, iter_28_4 in pairs(arg_25_1.var_.actorSpriteComps1061:ToTable()) do
					if iter_28_4 then
						if arg_25_1.isInRecall_ then
							iter_28_4.color = arg_25_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_28_4.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_25_1.var_.actorSpriteComps1061 = nil
			end

			local var_28_15 = arg_25_1.actors_["1056"]
			local var_28_16 = 0

			if var_28_16 < arg_25_1.time_ and arg_25_1.time_ <= var_28_16 + arg_28_0 and not isNil(var_28_15) and arg_25_1.var_.actorSpriteComps1056 == nil then
				arg_25_1.var_.actorSpriteComps1056 = var_28_15:GetComponentsInChildren(typeof(Image), true)
			end

			local var_28_17 = 0.034

			if var_28_16 <= arg_25_1.time_ and arg_25_1.time_ < var_28_16 + var_28_17 and not isNil(var_28_15) then
				local var_28_18 = (arg_25_1.time_ - var_28_16) / var_28_17

				if arg_25_1.var_.actorSpriteComps1056 then
					for iter_28_5, iter_28_6 in pairs(arg_25_1.var_.actorSpriteComps1056:ToTable()) do
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

			if arg_25_1.time_ >= var_28_16 + var_28_17 and arg_25_1.time_ < var_28_16 + var_28_17 + arg_28_0 and not isNil(var_28_15) and arg_25_1.var_.actorSpriteComps1056 then
				for iter_28_7, iter_28_8 in pairs(arg_25_1.var_.actorSpriteComps1056:ToTable()) do
					if iter_28_8 then
						if arg_25_1.isInRecall_ then
							iter_28_8.color = arg_25_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_28_8.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_25_1.var_.actorSpriteComps1056 = nil
			end

			local var_28_23 = 0
			local var_28_24 = 0.55

			if var_28_23 < arg_25_1.time_ and arg_25_1.time_ <= var_28_23 + arg_28_0 then
				arg_25_1.talkMaxDuration = 0
				arg_25_1.dialogCg_.alpha = 1

				arg_25_1.dialog_:SetActive(true)
				SetActive(arg_25_1.leftNameGo_, true)

				local var_28_25 = arg_25_1:FormatText(StoryNameCfg[612].name)

				arg_25_1.leftNameTxt_.text = var_28_25

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_25_1.leftNameTxt_.transform)

				arg_25_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_25_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_25_1:RecordName(arg_25_1.leftNameTxt_.text)
				SetActive(arg_25_1.iconTrs_.gameObject, false)
				arg_25_1.callingController_:SetSelectedState("normal")

				local var_28_26 = arg_25_1:GetWordFromCfg(410142006)
				local var_28_27 = arg_25_1:FormatText(var_28_26.content)

				arg_25_1.text_.text = var_28_27

				LuaForUtil.ClearLinePrefixSymbol(arg_25_1.text_)

				local var_28_28 = 22
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

				if manager.audio:GetVoiceLength("story_v_out_410142", "410142006", "story_v_out_410142.awb") ~= 0 then
					local var_28_31 = manager.audio:GetVoiceLength("story_v_out_410142", "410142006", "story_v_out_410142.awb") / 1000

					if var_28_31 + var_28_23 > arg_25_1.duration_ then
						arg_25_1.duration_ = var_28_31 + var_28_23
					end

					if var_28_26.prefab_name ~= "" and arg_25_1.actors_[var_28_26.prefab_name] ~= nil then
						local var_28_32 = LuaForUtil.PlayVoiceWithCriLipsync(arg_25_1.actors_[var_28_26.prefab_name].transform, "story_v_out_410142", "410142006", "story_v_out_410142.awb")

						arg_25_1:RecordAudio("410142006", var_28_32)
						arg_25_1:RecordAudio("410142006", var_28_32)
					else
						arg_25_1:AudioAction("play", "voice", "story_v_out_410142", "410142006", "story_v_out_410142.awb")
					end

					arg_25_1:RecordHistoryTalkVoice("story_v_out_410142", "410142006", "story_v_out_410142.awb")
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
				actorName = "1061",
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
	Play410142007 = function(arg_29_0, arg_29_1)
		arg_29_1.time_ = 0
		arg_29_1.frameCnt_ = 0
		arg_29_1.state_ = "playing"
		arg_29_1.curTalkId_ = 410142007
		arg_29_1.duration_ = 5

		SetActive(arg_29_1.tipsGo_, false)

		function arg_29_1.onSingleLineFinish_()
			arg_29_1.onSingleLineUpdate_ = nil
			arg_29_1.onSingleLineFinish_ = nil
			arg_29_1.state_ = "waiting"
		end

		function arg_29_1.playNext_(arg_31_0)
			if arg_31_0 == 1 then
				arg_29_0:Play410142008(arg_29_1)
			end
		end

		function arg_29_1.onSingleLineUpdate_(arg_32_0)
			local var_32_0 = arg_29_1.actors_["1056"].transform
			local var_32_1 = 0

			if var_32_1 < arg_29_1.time_ and arg_29_1.time_ <= var_32_1 + arg_32_0 then
				arg_29_1.var_.moveOldPos1056 = var_32_0.localPosition
				var_32_0.localScale = Vector3.New(1, 1, 1)

				arg_29_1:CheckSpriteTmpPos("1056", 7)

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
				local var_32_6 = Vector3.New(0, -2000, -180)

				var_32_0.localPosition = Vector3.Lerp(arg_29_1.var_.moveOldPos1056, var_32_6, var_32_5)
			end

			if arg_29_1.time_ >= var_32_1 + var_32_4 and arg_29_1.time_ < var_32_1 + var_32_4 + arg_32_0 then
				var_32_0.localPosition = Vector3.New(0, -2000, -180)
			end

			local var_32_7 = arg_29_1.actors_["1061"].transform
			local var_32_8 = 0

			if var_32_8 < arg_29_1.time_ and arg_29_1.time_ <= var_32_8 + arg_32_0 then
				arg_29_1.var_.moveOldPos1061 = var_32_7.localPosition
				var_32_7.localScale = Vector3.New(1, 1, 1)

				arg_29_1:CheckSpriteTmpPos("1061", 7)

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
				local var_32_13 = Vector3.New(0, -2000, 18)

				var_32_7.localPosition = Vector3.Lerp(arg_29_1.var_.moveOldPos1061, var_32_13, var_32_12)
			end

			if arg_29_1.time_ >= var_32_8 + var_32_11 and arg_29_1.time_ < var_32_8 + var_32_11 + arg_32_0 then
				var_32_7.localPosition = Vector3.New(0, -2000, 18)
			end

			local var_32_14 = arg_29_1.actors_["1056"]
			local var_32_15 = 0

			if var_32_15 < arg_29_1.time_ and arg_29_1.time_ <= var_32_15 + arg_32_0 and not isNil(var_32_14) and arg_29_1.var_.actorSpriteComps1056 == nil then
				arg_29_1.var_.actorSpriteComps1056 = var_32_14:GetComponentsInChildren(typeof(Image), true)
			end

			local var_32_16 = 0.034

			if var_32_15 <= arg_29_1.time_ and arg_29_1.time_ < var_32_15 + var_32_16 and not isNil(var_32_14) then
				local var_32_17 = (arg_29_1.time_ - var_32_15) / var_32_16

				if arg_29_1.var_.actorSpriteComps1056 then
					for iter_32_2, iter_32_3 in pairs(arg_29_1.var_.actorSpriteComps1056:ToTable()) do
						if iter_32_3 then
							if arg_29_1.isInRecall_ then
								local var_32_18 = Mathf.Lerp(iter_32_3.color.r, arg_29_1.hightColor2.r, var_32_17)
								local var_32_19 = Mathf.Lerp(iter_32_3.color.g, arg_29_1.hightColor2.g, var_32_17)
								local var_32_20 = Mathf.Lerp(iter_32_3.color.b, arg_29_1.hightColor2.b, var_32_17)

								iter_32_3.color = Color.New(var_32_18, var_32_19, var_32_20)
							else
								local var_32_21 = Mathf.Lerp(iter_32_3.color.r, 0.5, var_32_17)

								iter_32_3.color = Color.New(var_32_21, var_32_21, var_32_21)
							end
						end
					end
				end
			end

			if arg_29_1.time_ >= var_32_15 + var_32_16 and arg_29_1.time_ < var_32_15 + var_32_16 + arg_32_0 and not isNil(var_32_14) and arg_29_1.var_.actorSpriteComps1056 then
				for iter_32_4, iter_32_5 in pairs(arg_29_1.var_.actorSpriteComps1056:ToTable()) do
					if iter_32_5 then
						if arg_29_1.isInRecall_ then
							iter_32_5.color = arg_29_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_32_5.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_29_1.var_.actorSpriteComps1056 = nil
			end

			local var_32_22 = arg_29_1.actors_["1061"]
			local var_32_23 = 0

			if var_32_23 < arg_29_1.time_ and arg_29_1.time_ <= var_32_23 + arg_32_0 and not isNil(var_32_22) and arg_29_1.var_.actorSpriteComps1061 == nil then
				arg_29_1.var_.actorSpriteComps1061 = var_32_22:GetComponentsInChildren(typeof(Image), true)
			end

			local var_32_24 = 0.034

			if var_32_23 <= arg_29_1.time_ and arg_29_1.time_ < var_32_23 + var_32_24 and not isNil(var_32_22) then
				local var_32_25 = (arg_29_1.time_ - var_32_23) / var_32_24

				if arg_29_1.var_.actorSpriteComps1061 then
					for iter_32_6, iter_32_7 in pairs(arg_29_1.var_.actorSpriteComps1061:ToTable()) do
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

			if arg_29_1.time_ >= var_32_23 + var_32_24 and arg_29_1.time_ < var_32_23 + var_32_24 + arg_32_0 and not isNil(var_32_22) and arg_29_1.var_.actorSpriteComps1061 then
				for iter_32_8, iter_32_9 in pairs(arg_29_1.var_.actorSpriteComps1061:ToTable()) do
					if iter_32_9 then
						if arg_29_1.isInRecall_ then
							iter_32_9.color = arg_29_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_32_9.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_29_1.var_.actorSpriteComps1061 = nil
			end

			local var_32_30 = 0
			local var_32_31 = 0.975

			if var_32_30 < arg_29_1.time_ and arg_29_1.time_ <= var_32_30 + arg_32_0 then
				arg_29_1.talkMaxDuration = 0
				arg_29_1.dialogCg_.alpha = 1

				arg_29_1.dialog_:SetActive(true)
				SetActive(arg_29_1.leftNameGo_, false)

				arg_29_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_29_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_29_1:RecordName(arg_29_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_29_1.iconTrs_.gameObject, false)
				arg_29_1.callingController_:SetSelectedState("normal")

				local var_32_32 = arg_29_1:GetWordFromCfg(410142007)
				local var_32_33 = arg_29_1:FormatText(var_32_32.content)

				arg_29_1.text_.text = var_32_33

				LuaForUtil.ClearLinePrefixSymbol(arg_29_1.text_)

				local var_32_34 = 39
				local var_32_35 = utf8.len(var_32_33)
				local var_32_36 = var_32_34 <= 0 and var_32_31 or var_32_31 * (var_32_35 / var_32_34)

				if var_32_36 > 0 and var_32_31 < var_32_36 then
					arg_29_1.talkMaxDuration = var_32_36

					if var_32_36 + var_32_30 > arg_29_1.duration_ then
						arg_29_1.duration_ = var_32_36 + var_32_30
					end
				end

				arg_29_1.text_.text = var_32_33
				arg_29_1.typewritter.percent = 0

				arg_29_1.typewritter:SetDirty()
				arg_29_1:ShowNextGo(false)
				arg_29_1:RecordContent(arg_29_1.text_.text)
			end

			local var_32_37 = math.max(var_32_31, arg_29_1.talkMaxDuration)

			if var_32_30 <= arg_29_1.time_ and arg_29_1.time_ < var_32_30 + var_32_37 then
				arg_29_1.typewritter.percent = (arg_29_1.time_ - var_32_30) / var_32_37

				arg_29_1.typewritter:SetDirty()
			end

			if arg_29_1.time_ >= var_32_30 + var_32_37 and arg_29_1.time_ < var_32_30 + var_32_37 + arg_32_0 then
				arg_29_1.typewritter.percent = 1

				arg_29_1.typewritter:SetDirty()
				arg_29_1:ShowNextGo(true)
			end
		end

		arg_29_1.nodeConfigList_ = {
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
				actorName = "1061",
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
	Play410142008 = function(arg_33_0, arg_33_1)
		arg_33_1.time_ = 0
		arg_33_1.frameCnt_ = 0
		arg_33_1.state_ = "playing"
		arg_33_1.curTalkId_ = 410142008
		arg_33_1.duration_ = 6.9

		local var_33_0 = {
			ja = 6.9,
			CriLanguages = 5.666,
			zh = 5.666
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
				arg_33_0:Play410142009(arg_33_1)
			end
		end

		function arg_33_1.onSingleLineUpdate_(arg_36_0)
			local var_36_0 = arg_33_1.actors_["1061"].transform
			local var_36_1 = 0

			if var_36_1 < arg_33_1.time_ and arg_33_1.time_ <= var_36_1 + arg_36_0 then
				arg_33_1.var_.moveOldPos1061 = var_36_0.localPosition
				var_36_0.localScale = Vector3.New(1, 1, 1)

				arg_33_1:CheckSpriteTmpPos("1061", 3)

				local var_36_2 = var_36_0.childCount

				for iter_36_0 = 0, var_36_2 - 1 do
					local var_36_3 = var_36_0:GetChild(iter_36_0)

					if var_36_3.name == "split_2" or not string.find(var_36_3.name, "split") then
						var_36_3.gameObject:SetActive(true)
					else
						var_36_3.gameObject:SetActive(false)
					end
				end
			end

			local var_36_4 = 0.001

			if var_36_1 <= arg_33_1.time_ and arg_33_1.time_ < var_36_1 + var_36_4 then
				local var_36_5 = (arg_33_1.time_ - var_36_1) / var_36_4
				local var_36_6 = Vector3.New(0, -490, 18)

				var_36_0.localPosition = Vector3.Lerp(arg_33_1.var_.moveOldPos1061, var_36_6, var_36_5)
			end

			if arg_33_1.time_ >= var_36_1 + var_36_4 and arg_33_1.time_ < var_36_1 + var_36_4 + arg_36_0 then
				var_36_0.localPosition = Vector3.New(0, -490, 18)
			end

			local var_36_7 = arg_33_1.actors_["1061"]
			local var_36_8 = 0

			if var_36_8 < arg_33_1.time_ and arg_33_1.time_ <= var_36_8 + arg_36_0 and not isNil(var_36_7) and arg_33_1.var_.actorSpriteComps1061 == nil then
				arg_33_1.var_.actorSpriteComps1061 = var_36_7:GetComponentsInChildren(typeof(Image), true)
			end

			local var_36_9 = 0.034

			if var_36_8 <= arg_33_1.time_ and arg_33_1.time_ < var_36_8 + var_36_9 and not isNil(var_36_7) then
				local var_36_10 = (arg_33_1.time_ - var_36_8) / var_36_9

				if arg_33_1.var_.actorSpriteComps1061 then
					for iter_36_1, iter_36_2 in pairs(arg_33_1.var_.actorSpriteComps1061:ToTable()) do
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

			if arg_33_1.time_ >= var_36_8 + var_36_9 and arg_33_1.time_ < var_36_8 + var_36_9 + arg_36_0 and not isNil(var_36_7) and arg_33_1.var_.actorSpriteComps1061 then
				for iter_36_3, iter_36_4 in pairs(arg_33_1.var_.actorSpriteComps1061:ToTable()) do
					if iter_36_4 then
						if arg_33_1.isInRecall_ then
							iter_36_4.color = arg_33_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_36_4.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_33_1.var_.actorSpriteComps1061 = nil
			end

			local var_36_15 = 0
			local var_36_16 = 0.475

			if var_36_15 < arg_33_1.time_ and arg_33_1.time_ <= var_36_15 + arg_36_0 then
				arg_33_1.talkMaxDuration = 0
				arg_33_1.dialogCg_.alpha = 1

				arg_33_1.dialog_:SetActive(true)
				SetActive(arg_33_1.leftNameGo_, true)

				local var_36_17 = arg_33_1:FormatText(StoryNameCfg[612].name)

				arg_33_1.leftNameTxt_.text = var_36_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_33_1.leftNameTxt_.transform)

				arg_33_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_33_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_33_1:RecordName(arg_33_1.leftNameTxt_.text)
				SetActive(arg_33_1.iconTrs_.gameObject, false)
				arg_33_1.callingController_:SetSelectedState("normal")

				local var_36_18 = arg_33_1:GetWordFromCfg(410142008)
				local var_36_19 = arg_33_1:FormatText(var_36_18.content)

				arg_33_1.text_.text = var_36_19

				LuaForUtil.ClearLinePrefixSymbol(arg_33_1.text_)

				local var_36_20 = 19
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

				if manager.audio:GetVoiceLength("story_v_out_410142", "410142008", "story_v_out_410142.awb") ~= 0 then
					local var_36_23 = manager.audio:GetVoiceLength("story_v_out_410142", "410142008", "story_v_out_410142.awb") / 1000

					if var_36_23 + var_36_15 > arg_33_1.duration_ then
						arg_33_1.duration_ = var_36_23 + var_36_15
					end

					if var_36_18.prefab_name ~= "" and arg_33_1.actors_[var_36_18.prefab_name] ~= nil then
						local var_36_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_33_1.actors_[var_36_18.prefab_name].transform, "story_v_out_410142", "410142008", "story_v_out_410142.awb")

						arg_33_1:RecordAudio("410142008", var_36_24)
						arg_33_1:RecordAudio("410142008", var_36_24)
					else
						arg_33_1:AudioAction("play", "voice", "story_v_out_410142", "410142008", "story_v_out_410142.awb")
					end

					arg_33_1:RecordHistoryTalkVoice("story_v_out_410142", "410142008", "story_v_out_410142.awb")
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
				actorName = "1061",
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
	Play410142009 = function(arg_37_0, arg_37_1)
		arg_37_1.time_ = 0
		arg_37_1.frameCnt_ = 0
		arg_37_1.state_ = "playing"
		arg_37_1.curTalkId_ = 410142009
		arg_37_1.duration_ = 5

		SetActive(arg_37_1.tipsGo_, false)

		function arg_37_1.onSingleLineFinish_()
			arg_37_1.onSingleLineUpdate_ = nil
			arg_37_1.onSingleLineFinish_ = nil
			arg_37_1.state_ = "waiting"
		end

		function arg_37_1.playNext_(arg_39_0)
			if arg_39_0 == 1 then
				arg_37_0:Play410142010(arg_37_1)
			end
		end

		function arg_37_1.onSingleLineUpdate_(arg_40_0)
			local var_40_0 = arg_37_1.actors_["1061"]
			local var_40_1 = 0

			if var_40_1 < arg_37_1.time_ and arg_37_1.time_ <= var_40_1 + arg_40_0 and not isNil(var_40_0) and arg_37_1.var_.actorSpriteComps1061 == nil then
				arg_37_1.var_.actorSpriteComps1061 = var_40_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_40_2 = 0.034

			if var_40_1 <= arg_37_1.time_ and arg_37_1.time_ < var_40_1 + var_40_2 and not isNil(var_40_0) then
				local var_40_3 = (arg_37_1.time_ - var_40_1) / var_40_2

				if arg_37_1.var_.actorSpriteComps1061 then
					for iter_40_0, iter_40_1 in pairs(arg_37_1.var_.actorSpriteComps1061:ToTable()) do
						if iter_40_1 then
							if arg_37_1.isInRecall_ then
								local var_40_4 = Mathf.Lerp(iter_40_1.color.r, arg_37_1.hightColor2.r, var_40_3)
								local var_40_5 = Mathf.Lerp(iter_40_1.color.g, arg_37_1.hightColor2.g, var_40_3)
								local var_40_6 = Mathf.Lerp(iter_40_1.color.b, arg_37_1.hightColor2.b, var_40_3)

								iter_40_1.color = Color.New(var_40_4, var_40_5, var_40_6)
							else
								local var_40_7 = Mathf.Lerp(iter_40_1.color.r, 0.5, var_40_3)

								iter_40_1.color = Color.New(var_40_7, var_40_7, var_40_7)
							end
						end
					end
				end
			end

			if arg_37_1.time_ >= var_40_1 + var_40_2 and arg_37_1.time_ < var_40_1 + var_40_2 + arg_40_0 and not isNil(var_40_0) and arg_37_1.var_.actorSpriteComps1061 then
				for iter_40_2, iter_40_3 in pairs(arg_37_1.var_.actorSpriteComps1061:ToTable()) do
					if iter_40_3 then
						if arg_37_1.isInRecall_ then
							iter_40_3.color = arg_37_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_40_3.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_37_1.var_.actorSpriteComps1061 = nil
			end

			local var_40_8 = 0
			local var_40_9 = 1.275

			if var_40_8 < arg_37_1.time_ and arg_37_1.time_ <= var_40_8 + arg_40_0 then
				arg_37_1.talkMaxDuration = 0
				arg_37_1.dialogCg_.alpha = 1

				arg_37_1.dialog_:SetActive(true)
				SetActive(arg_37_1.leftNameGo_, false)

				arg_37_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_37_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_37_1:RecordName(arg_37_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_37_1.iconTrs_.gameObject, false)
				arg_37_1.callingController_:SetSelectedState("normal")

				local var_40_10 = arg_37_1:GetWordFromCfg(410142009)
				local var_40_11 = arg_37_1:FormatText(var_40_10.content)

				arg_37_1.text_.text = var_40_11

				LuaForUtil.ClearLinePrefixSymbol(arg_37_1.text_)

				local var_40_12 = 51
				local var_40_13 = utf8.len(var_40_11)
				local var_40_14 = var_40_12 <= 0 and var_40_9 or var_40_9 * (var_40_13 / var_40_12)

				if var_40_14 > 0 and var_40_9 < var_40_14 then
					arg_37_1.talkMaxDuration = var_40_14

					if var_40_14 + var_40_8 > arg_37_1.duration_ then
						arg_37_1.duration_ = var_40_14 + var_40_8
					end
				end

				arg_37_1.text_.text = var_40_11
				arg_37_1.typewritter.percent = 0

				arg_37_1.typewritter:SetDirty()
				arg_37_1:ShowNextGo(false)
				arg_37_1:RecordContent(arg_37_1.text_.text)
			end

			local var_40_15 = math.max(var_40_9, arg_37_1.talkMaxDuration)

			if var_40_8 <= arg_37_1.time_ and arg_37_1.time_ < var_40_8 + var_40_15 then
				arg_37_1.typewritter.percent = (arg_37_1.time_ - var_40_8) / var_40_15

				arg_37_1.typewritter:SetDirty()
			end

			if arg_37_1.time_ >= var_40_8 + var_40_15 and arg_37_1.time_ < var_40_8 + var_40_15 + arg_40_0 then
				arg_37_1.typewritter.percent = 1

				arg_37_1.typewritter:SetDirty()
				arg_37_1:ShowNextGo(true)
			end
		end

		arg_37_1.nodeConfigList_ = {}

		arg_37_1:InitPlayNodeList()
	end,
	Play410142010 = function(arg_41_0, arg_41_1)
		arg_41_1.time_ = 0
		arg_41_1.frameCnt_ = 0
		arg_41_1.state_ = "playing"
		arg_41_1.curTalkId_ = 410142010
		arg_41_1.duration_ = 6.57

		local var_41_0 = {
			ja = 6.566,
			CriLanguages = 2.5,
			zh = 2.5
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
				arg_41_0:Play410142011(arg_41_1)
			end
		end

		function arg_41_1.onSingleLineUpdate_(arg_44_0)
			local var_44_0 = arg_41_1.actors_["1061"].transform
			local var_44_1 = 0

			if var_44_1 < arg_41_1.time_ and arg_41_1.time_ <= var_44_1 + arg_44_0 then
				arg_41_1.var_.moveOldPos1061 = var_44_0.localPosition
				var_44_0.localScale = Vector3.New(1, 1, 1)

				arg_41_1:CheckSpriteTmpPos("1061", 2)

				local var_44_2 = var_44_0.childCount

				for iter_44_0 = 0, var_44_2 - 1 do
					local var_44_3 = var_44_0:GetChild(iter_44_0)

					if var_44_3.name == "split_5" or not string.find(var_44_3.name, "split") then
						var_44_3.gameObject:SetActive(true)
					else
						var_44_3.gameObject:SetActive(false)
					end
				end
			end

			local var_44_4 = 0.001

			if var_44_1 <= arg_41_1.time_ and arg_41_1.time_ < var_44_1 + var_44_4 then
				local var_44_5 = (arg_41_1.time_ - var_44_1) / var_44_4
				local var_44_6 = Vector3.New(-390, -490, 18)

				var_44_0.localPosition = Vector3.Lerp(arg_41_1.var_.moveOldPos1061, var_44_6, var_44_5)
			end

			if arg_41_1.time_ >= var_44_1 + var_44_4 and arg_41_1.time_ < var_44_1 + var_44_4 + arg_44_0 then
				var_44_0.localPosition = Vector3.New(-390, -490, 18)
			end

			local var_44_7 = arg_41_1.actors_["1056"].transform
			local var_44_8 = 0

			if var_44_8 < arg_41_1.time_ and arg_41_1.time_ <= var_44_8 + arg_44_0 then
				arg_41_1.var_.moveOldPos1056 = var_44_7.localPosition
				var_44_7.localScale = Vector3.New(1, 1, 1)

				arg_41_1:CheckSpriteTmpPos("1056", 4)

				local var_44_9 = var_44_7.childCount

				for iter_44_1 = 0, var_44_9 - 1 do
					local var_44_10 = var_44_7:GetChild(iter_44_1)

					if var_44_10.name == "" or not string.find(var_44_10.name, "split") then
						var_44_10.gameObject:SetActive(true)
					else
						var_44_10.gameObject:SetActive(false)
					end
				end
			end

			local var_44_11 = 0.001

			if var_44_8 <= arg_41_1.time_ and arg_41_1.time_ < var_44_8 + var_44_11 then
				local var_44_12 = (arg_41_1.time_ - var_44_8) / var_44_11
				local var_44_13 = Vector3.New(390, -350, -180)

				var_44_7.localPosition = Vector3.Lerp(arg_41_1.var_.moveOldPos1056, var_44_13, var_44_12)
			end

			if arg_41_1.time_ >= var_44_8 + var_44_11 and arg_41_1.time_ < var_44_8 + var_44_11 + arg_44_0 then
				var_44_7.localPosition = Vector3.New(390, -350, -180)
			end

			local var_44_14 = arg_41_1.actors_["1061"]
			local var_44_15 = 0

			if var_44_15 < arg_41_1.time_ and arg_41_1.time_ <= var_44_15 + arg_44_0 and not isNil(var_44_14) and arg_41_1.var_.actorSpriteComps1061 == nil then
				arg_41_1.var_.actorSpriteComps1061 = var_44_14:GetComponentsInChildren(typeof(Image), true)
			end

			local var_44_16 = 0.034

			if var_44_15 <= arg_41_1.time_ and arg_41_1.time_ < var_44_15 + var_44_16 and not isNil(var_44_14) then
				local var_44_17 = (arg_41_1.time_ - var_44_15) / var_44_16

				if arg_41_1.var_.actorSpriteComps1061 then
					for iter_44_2, iter_44_3 in pairs(arg_41_1.var_.actorSpriteComps1061:ToTable()) do
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

			if arg_41_1.time_ >= var_44_15 + var_44_16 and arg_41_1.time_ < var_44_15 + var_44_16 + arg_44_0 and not isNil(var_44_14) and arg_41_1.var_.actorSpriteComps1061 then
				for iter_44_4, iter_44_5 in pairs(arg_41_1.var_.actorSpriteComps1061:ToTable()) do
					if iter_44_5 then
						if arg_41_1.isInRecall_ then
							iter_44_5.color = arg_41_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_44_5.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_41_1.var_.actorSpriteComps1061 = nil
			end

			local var_44_22 = arg_41_1.actors_["1056"]
			local var_44_23 = 0

			if var_44_23 < arg_41_1.time_ and arg_41_1.time_ <= var_44_23 + arg_44_0 and not isNil(var_44_22) and arg_41_1.var_.actorSpriteComps1056 == nil then
				arg_41_1.var_.actorSpriteComps1056 = var_44_22:GetComponentsInChildren(typeof(Image), true)
			end

			local var_44_24 = 0.034

			if var_44_23 <= arg_41_1.time_ and arg_41_1.time_ < var_44_23 + var_44_24 and not isNil(var_44_22) then
				local var_44_25 = (arg_41_1.time_ - var_44_23) / var_44_24

				if arg_41_1.var_.actorSpriteComps1056 then
					for iter_44_6, iter_44_7 in pairs(arg_41_1.var_.actorSpriteComps1056:ToTable()) do
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

			if arg_41_1.time_ >= var_44_23 + var_44_24 and arg_41_1.time_ < var_44_23 + var_44_24 + arg_44_0 and not isNil(var_44_22) and arg_41_1.var_.actorSpriteComps1056 then
				for iter_44_8, iter_44_9 in pairs(arg_41_1.var_.actorSpriteComps1056:ToTable()) do
					if iter_44_9 then
						if arg_41_1.isInRecall_ then
							iter_44_9.color = arg_41_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_44_9.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_41_1.var_.actorSpriteComps1056 = nil
			end

			local var_44_30 = 0
			local var_44_31 = 0.325

			if var_44_30 < arg_41_1.time_ and arg_41_1.time_ <= var_44_30 + arg_44_0 then
				arg_41_1.talkMaxDuration = 0
				arg_41_1.dialogCg_.alpha = 1

				arg_41_1.dialog_:SetActive(true)
				SetActive(arg_41_1.leftNameGo_, true)

				local var_44_32 = arg_41_1:FormatText(StoryNameCfg[612].name)

				arg_41_1.leftNameTxt_.text = var_44_32

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_41_1.leftNameTxt_.transform)

				arg_41_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_41_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_41_1:RecordName(arg_41_1.leftNameTxt_.text)
				SetActive(arg_41_1.iconTrs_.gameObject, false)
				arg_41_1.callingController_:SetSelectedState("normal")

				local var_44_33 = arg_41_1:GetWordFromCfg(410142010)
				local var_44_34 = arg_41_1:FormatText(var_44_33.content)

				arg_41_1.text_.text = var_44_34

				LuaForUtil.ClearLinePrefixSymbol(arg_41_1.text_)

				local var_44_35 = 13
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

				if manager.audio:GetVoiceLength("story_v_out_410142", "410142010", "story_v_out_410142.awb") ~= 0 then
					local var_44_38 = manager.audio:GetVoiceLength("story_v_out_410142", "410142010", "story_v_out_410142.awb") / 1000

					if var_44_38 + var_44_30 > arg_41_1.duration_ then
						arg_41_1.duration_ = var_44_38 + var_44_30
					end

					if var_44_33.prefab_name ~= "" and arg_41_1.actors_[var_44_33.prefab_name] ~= nil then
						local var_44_39 = LuaForUtil.PlayVoiceWithCriLipsync(arg_41_1.actors_[var_44_33.prefab_name].transform, "story_v_out_410142", "410142010", "story_v_out_410142.awb")

						arg_41_1:RecordAudio("410142010", var_44_39)
						arg_41_1:RecordAudio("410142010", var_44_39)
					else
						arg_41_1:AudioAction("play", "voice", "story_v_out_410142", "410142010", "story_v_out_410142.awb")
					end

					arg_41_1:RecordHistoryTalkVoice("story_v_out_410142", "410142010", "story_v_out_410142.awb")
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
				actorName = "1061",
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

		arg_41_1:InitPlayNodeList()
	end,
	Play410142011 = function(arg_45_0, arg_45_1)
		arg_45_1.time_ = 0
		arg_45_1.frameCnt_ = 0
		arg_45_1.state_ = "playing"
		arg_45_1.curTalkId_ = 410142011
		arg_45_1.duration_ = 3.83

		local var_45_0 = {
			ja = 3.833,
			CriLanguages = 1.766,
			zh = 1.766
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
				arg_45_0:Play410142012(arg_45_1)
			end
		end

		function arg_45_1.onSingleLineUpdate_(arg_48_0)
			local var_48_0 = arg_45_1.actors_["1056"].transform
			local var_48_1 = 0

			if var_48_1 < arg_45_1.time_ and arg_45_1.time_ <= var_48_1 + arg_48_0 then
				arg_45_1.var_.moveOldPos1056 = var_48_0.localPosition
				var_48_0.localScale = Vector3.New(1, 1, 1)

				arg_45_1:CheckSpriteTmpPos("1056", 4)

				local var_48_2 = var_48_0.childCount

				for iter_48_0 = 0, var_48_2 - 1 do
					local var_48_3 = var_48_0:GetChild(iter_48_0)

					if var_48_3.name == "split_1" or not string.find(var_48_3.name, "split") then
						var_48_3.gameObject:SetActive(true)
					else
						var_48_3.gameObject:SetActive(false)
					end
				end
			end

			local var_48_4 = 0.001

			if var_48_1 <= arg_45_1.time_ and arg_45_1.time_ < var_48_1 + var_48_4 then
				local var_48_5 = (arg_45_1.time_ - var_48_1) / var_48_4
				local var_48_6 = Vector3.New(390, -350, -180)

				var_48_0.localPosition = Vector3.Lerp(arg_45_1.var_.moveOldPos1056, var_48_6, var_48_5)
			end

			if arg_45_1.time_ >= var_48_1 + var_48_4 and arg_45_1.time_ < var_48_1 + var_48_4 + arg_48_0 then
				var_48_0.localPosition = Vector3.New(390, -350, -180)
			end

			local var_48_7 = arg_45_1.actors_["1056"]
			local var_48_8 = 0

			if var_48_8 < arg_45_1.time_ and arg_45_1.time_ <= var_48_8 + arg_48_0 and not isNil(var_48_7) and arg_45_1.var_.actorSpriteComps1056 == nil then
				arg_45_1.var_.actorSpriteComps1056 = var_48_7:GetComponentsInChildren(typeof(Image), true)
			end

			local var_48_9 = 0.034

			if var_48_8 <= arg_45_1.time_ and arg_45_1.time_ < var_48_8 + var_48_9 and not isNil(var_48_7) then
				local var_48_10 = (arg_45_1.time_ - var_48_8) / var_48_9

				if arg_45_1.var_.actorSpriteComps1056 then
					for iter_48_1, iter_48_2 in pairs(arg_45_1.var_.actorSpriteComps1056:ToTable()) do
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

			if arg_45_1.time_ >= var_48_8 + var_48_9 and arg_45_1.time_ < var_48_8 + var_48_9 + arg_48_0 and not isNil(var_48_7) and arg_45_1.var_.actorSpriteComps1056 then
				for iter_48_3, iter_48_4 in pairs(arg_45_1.var_.actorSpriteComps1056:ToTable()) do
					if iter_48_4 then
						if arg_45_1.isInRecall_ then
							iter_48_4.color = arg_45_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_48_4.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_45_1.var_.actorSpriteComps1056 = nil
			end

			local var_48_15 = arg_45_1.actors_["1061"]
			local var_48_16 = 0

			if var_48_16 < arg_45_1.time_ and arg_45_1.time_ <= var_48_16 + arg_48_0 and not isNil(var_48_15) and arg_45_1.var_.actorSpriteComps1061 == nil then
				arg_45_1.var_.actorSpriteComps1061 = var_48_15:GetComponentsInChildren(typeof(Image), true)
			end

			local var_48_17 = 0.034

			if var_48_16 <= arg_45_1.time_ and arg_45_1.time_ < var_48_16 + var_48_17 and not isNil(var_48_15) then
				local var_48_18 = (arg_45_1.time_ - var_48_16) / var_48_17

				if arg_45_1.var_.actorSpriteComps1061 then
					for iter_48_5, iter_48_6 in pairs(arg_45_1.var_.actorSpriteComps1061:ToTable()) do
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

			if arg_45_1.time_ >= var_48_16 + var_48_17 and arg_45_1.time_ < var_48_16 + var_48_17 + arg_48_0 and not isNil(var_48_15) and arg_45_1.var_.actorSpriteComps1061 then
				for iter_48_7, iter_48_8 in pairs(arg_45_1.var_.actorSpriteComps1061:ToTable()) do
					if iter_48_8 then
						if arg_45_1.isInRecall_ then
							iter_48_8.color = arg_45_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_48_8.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_45_1.var_.actorSpriteComps1061 = nil
			end

			local var_48_23 = 0
			local var_48_24 = 0.2

			if var_48_23 < arg_45_1.time_ and arg_45_1.time_ <= var_48_23 + arg_48_0 then
				arg_45_1.talkMaxDuration = 0
				arg_45_1.dialogCg_.alpha = 1

				arg_45_1.dialog_:SetActive(true)
				SetActive(arg_45_1.leftNameGo_, true)

				local var_48_25 = arg_45_1:FormatText(StoryNameCfg[605].name)

				arg_45_1.leftNameTxt_.text = var_48_25

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_45_1.leftNameTxt_.transform)

				arg_45_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_45_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_45_1:RecordName(arg_45_1.leftNameTxt_.text)
				SetActive(arg_45_1.iconTrs_.gameObject, false)
				arg_45_1.callingController_:SetSelectedState("normal")

				local var_48_26 = arg_45_1:GetWordFromCfg(410142011)
				local var_48_27 = arg_45_1:FormatText(var_48_26.content)

				arg_45_1.text_.text = var_48_27

				LuaForUtil.ClearLinePrefixSymbol(arg_45_1.text_)

				local var_48_28 = 8
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

				if manager.audio:GetVoiceLength("story_v_out_410142", "410142011", "story_v_out_410142.awb") ~= 0 then
					local var_48_31 = manager.audio:GetVoiceLength("story_v_out_410142", "410142011", "story_v_out_410142.awb") / 1000

					if var_48_31 + var_48_23 > arg_45_1.duration_ then
						arg_45_1.duration_ = var_48_31 + var_48_23
					end

					if var_48_26.prefab_name ~= "" and arg_45_1.actors_[var_48_26.prefab_name] ~= nil then
						local var_48_32 = LuaForUtil.PlayVoiceWithCriLipsync(arg_45_1.actors_[var_48_26.prefab_name].transform, "story_v_out_410142", "410142011", "story_v_out_410142.awb")

						arg_45_1:RecordAudio("410142011", var_48_32)
						arg_45_1:RecordAudio("410142011", var_48_32)
					else
						arg_45_1:AudioAction("play", "voice", "story_v_out_410142", "410142011", "story_v_out_410142.awb")
					end

					arg_45_1:RecordHistoryTalkVoice("story_v_out_410142", "410142011", "story_v_out_410142.awb")
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
				actorName = "1056",
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
	Play410142012 = function(arg_49_0, arg_49_1)
		arg_49_1.time_ = 0
		arg_49_1.frameCnt_ = 0
		arg_49_1.state_ = "playing"
		arg_49_1.curTalkId_ = 410142012
		arg_49_1.duration_ = 7.67

		local var_49_0 = {
			ja = 1.333,
			CriLanguages = 7.666,
			zh = 7.666
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
				arg_49_0:Play410142013(arg_49_1)
			end
		end

		function arg_49_1.onSingleLineUpdate_(arg_52_0)
			local var_52_0 = arg_49_1.actors_["1061"].transform
			local var_52_1 = 0

			if var_52_1 < arg_49_1.time_ and arg_49_1.time_ <= var_52_1 + arg_52_0 then
				arg_49_1.var_.moveOldPos1061 = var_52_0.localPosition
				var_52_0.localScale = Vector3.New(1, 1, 1)

				arg_49_1:CheckSpriteTmpPos("1061", 2)

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
				local var_52_6 = Vector3.New(-390, -490, 18)

				var_52_0.localPosition = Vector3.Lerp(arg_49_1.var_.moveOldPos1061, var_52_6, var_52_5)
			end

			if arg_49_1.time_ >= var_52_1 + var_52_4 and arg_49_1.time_ < var_52_1 + var_52_4 + arg_52_0 then
				var_52_0.localPosition = Vector3.New(-390, -490, 18)
			end

			local var_52_7 = arg_49_1.actors_["1061"]
			local var_52_8 = 0

			if var_52_8 < arg_49_1.time_ and arg_49_1.time_ <= var_52_8 + arg_52_0 and not isNil(var_52_7) and arg_49_1.var_.actorSpriteComps1061 == nil then
				arg_49_1.var_.actorSpriteComps1061 = var_52_7:GetComponentsInChildren(typeof(Image), true)
			end

			local var_52_9 = 0.034

			if var_52_8 <= arg_49_1.time_ and arg_49_1.time_ < var_52_8 + var_52_9 and not isNil(var_52_7) then
				local var_52_10 = (arg_49_1.time_ - var_52_8) / var_52_9

				if arg_49_1.var_.actorSpriteComps1061 then
					for iter_52_1, iter_52_2 in pairs(arg_49_1.var_.actorSpriteComps1061:ToTable()) do
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

			if arg_49_1.time_ >= var_52_8 + var_52_9 and arg_49_1.time_ < var_52_8 + var_52_9 + arg_52_0 and not isNil(var_52_7) and arg_49_1.var_.actorSpriteComps1061 then
				for iter_52_3, iter_52_4 in pairs(arg_49_1.var_.actorSpriteComps1061:ToTable()) do
					if iter_52_4 then
						if arg_49_1.isInRecall_ then
							iter_52_4.color = arg_49_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_52_4.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_49_1.var_.actorSpriteComps1061 = nil
			end

			local var_52_15 = arg_49_1.actors_["1056"]
			local var_52_16 = 0

			if var_52_16 < arg_49_1.time_ and arg_49_1.time_ <= var_52_16 + arg_52_0 and not isNil(var_52_15) and arg_49_1.var_.actorSpriteComps1056 == nil then
				arg_49_1.var_.actorSpriteComps1056 = var_52_15:GetComponentsInChildren(typeof(Image), true)
			end

			local var_52_17 = 0.034

			if var_52_16 <= arg_49_1.time_ and arg_49_1.time_ < var_52_16 + var_52_17 and not isNil(var_52_15) then
				local var_52_18 = (arg_49_1.time_ - var_52_16) / var_52_17

				if arg_49_1.var_.actorSpriteComps1056 then
					for iter_52_5, iter_52_6 in pairs(arg_49_1.var_.actorSpriteComps1056:ToTable()) do
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

			if arg_49_1.time_ >= var_52_16 + var_52_17 and arg_49_1.time_ < var_52_16 + var_52_17 + arg_52_0 and not isNil(var_52_15) and arg_49_1.var_.actorSpriteComps1056 then
				for iter_52_7, iter_52_8 in pairs(arg_49_1.var_.actorSpriteComps1056:ToTable()) do
					if iter_52_8 then
						if arg_49_1.isInRecall_ then
							iter_52_8.color = arg_49_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_52_8.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_49_1.var_.actorSpriteComps1056 = nil
			end

			local var_52_23 = 0
			local var_52_24 = 0.05

			if var_52_23 < arg_49_1.time_ and arg_49_1.time_ <= var_52_23 + arg_52_0 then
				arg_49_1.talkMaxDuration = 0
				arg_49_1.dialogCg_.alpha = 1

				arg_49_1.dialog_:SetActive(true)
				SetActive(arg_49_1.leftNameGo_, true)

				local var_52_25 = arg_49_1:FormatText(StoryNameCfg[612].name)

				arg_49_1.leftNameTxt_.text = var_52_25

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_49_1.leftNameTxt_.transform)

				arg_49_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_49_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_49_1:RecordName(arg_49_1.leftNameTxt_.text)
				SetActive(arg_49_1.iconTrs_.gameObject, false)
				arg_49_1.callingController_:SetSelectedState("normal")

				local var_52_26 = arg_49_1:GetWordFromCfg(410142012)
				local var_52_27 = arg_49_1:FormatText(var_52_26.content)

				arg_49_1.text_.text = var_52_27

				LuaForUtil.ClearLinePrefixSymbol(arg_49_1.text_)

				local var_52_28 = 2
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

				if manager.audio:GetVoiceLength("story_v_out_410142", "410142012", "story_v_out_410142.awb") ~= 0 then
					local var_52_31 = manager.audio:GetVoiceLength("story_v_out_410142", "410142012", "story_v_out_410142.awb") / 1000

					if var_52_31 + var_52_23 > arg_49_1.duration_ then
						arg_49_1.duration_ = var_52_31 + var_52_23
					end

					if var_52_26.prefab_name ~= "" and arg_49_1.actors_[var_52_26.prefab_name] ~= nil then
						local var_52_32 = LuaForUtil.PlayVoiceWithCriLipsync(arg_49_1.actors_[var_52_26.prefab_name].transform, "story_v_out_410142", "410142012", "story_v_out_410142.awb")

						arg_49_1:RecordAudio("410142012", var_52_32)
						arg_49_1:RecordAudio("410142012", var_52_32)
					else
						arg_49_1:AudioAction("play", "voice", "story_v_out_410142", "410142012", "story_v_out_410142.awb")
					end

					arg_49_1:RecordHistoryTalkVoice("story_v_out_410142", "410142012", "story_v_out_410142.awb")
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
				actorName = "1061",
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
	Play410142013 = function(arg_53_0, arg_53_1)
		arg_53_1.time_ = 0
		arg_53_1.frameCnt_ = 0
		arg_53_1.state_ = "playing"
		arg_53_1.curTalkId_ = 410142013
		arg_53_1.duration_ = 2.77

		local var_53_0 = {
			ja = 2.766,
			CriLanguages = 2.633,
			zh = 2.633
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
				arg_53_0:Play410142014(arg_53_1)
			end
		end

		function arg_53_1.onSingleLineUpdate_(arg_56_0)
			local var_56_0 = arg_53_1.actors_["1056"].transform
			local var_56_1 = 0

			if var_56_1 < arg_53_1.time_ and arg_53_1.time_ <= var_56_1 + arg_56_0 then
				arg_53_1.var_.moveOldPos1056 = var_56_0.localPosition
				var_56_0.localScale = Vector3.New(1, 1, 1)

				arg_53_1:CheckSpriteTmpPos("1056", 4)

				local var_56_2 = var_56_0.childCount

				for iter_56_0 = 0, var_56_2 - 1 do
					local var_56_3 = var_56_0:GetChild(iter_56_0)

					if var_56_3.name == "split_1" or not string.find(var_56_3.name, "split") then
						var_56_3.gameObject:SetActive(true)
					else
						var_56_3.gameObject:SetActive(false)
					end
				end
			end

			local var_56_4 = 0.001

			if var_56_1 <= arg_53_1.time_ and arg_53_1.time_ < var_56_1 + var_56_4 then
				local var_56_5 = (arg_53_1.time_ - var_56_1) / var_56_4
				local var_56_6 = Vector3.New(390, -350, -180)

				var_56_0.localPosition = Vector3.Lerp(arg_53_1.var_.moveOldPos1056, var_56_6, var_56_5)
			end

			if arg_53_1.time_ >= var_56_1 + var_56_4 and arg_53_1.time_ < var_56_1 + var_56_4 + arg_56_0 then
				var_56_0.localPosition = Vector3.New(390, -350, -180)
			end

			local var_56_7 = arg_53_1.actors_["1056"]
			local var_56_8 = 0

			if var_56_8 < arg_53_1.time_ and arg_53_1.time_ <= var_56_8 + arg_56_0 and not isNil(var_56_7) and arg_53_1.var_.actorSpriteComps1056 == nil then
				arg_53_1.var_.actorSpriteComps1056 = var_56_7:GetComponentsInChildren(typeof(Image), true)
			end

			local var_56_9 = 0.034

			if var_56_8 <= arg_53_1.time_ and arg_53_1.time_ < var_56_8 + var_56_9 and not isNil(var_56_7) then
				local var_56_10 = (arg_53_1.time_ - var_56_8) / var_56_9

				if arg_53_1.var_.actorSpriteComps1056 then
					for iter_56_1, iter_56_2 in pairs(arg_53_1.var_.actorSpriteComps1056:ToTable()) do
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

			if arg_53_1.time_ >= var_56_8 + var_56_9 and arg_53_1.time_ < var_56_8 + var_56_9 + arg_56_0 and not isNil(var_56_7) and arg_53_1.var_.actorSpriteComps1056 then
				for iter_56_3, iter_56_4 in pairs(arg_53_1.var_.actorSpriteComps1056:ToTable()) do
					if iter_56_4 then
						if arg_53_1.isInRecall_ then
							iter_56_4.color = arg_53_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_56_4.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_53_1.var_.actorSpriteComps1056 = nil
			end

			local var_56_15 = arg_53_1.actors_["1061"]
			local var_56_16 = 0

			if var_56_16 < arg_53_1.time_ and arg_53_1.time_ <= var_56_16 + arg_56_0 and not isNil(var_56_15) and arg_53_1.var_.actorSpriteComps1061 == nil then
				arg_53_1.var_.actorSpriteComps1061 = var_56_15:GetComponentsInChildren(typeof(Image), true)
			end

			local var_56_17 = 0.034

			if var_56_16 <= arg_53_1.time_ and arg_53_1.time_ < var_56_16 + var_56_17 and not isNil(var_56_15) then
				local var_56_18 = (arg_53_1.time_ - var_56_16) / var_56_17

				if arg_53_1.var_.actorSpriteComps1061 then
					for iter_56_5, iter_56_6 in pairs(arg_53_1.var_.actorSpriteComps1061:ToTable()) do
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

			if arg_53_1.time_ >= var_56_16 + var_56_17 and arg_53_1.time_ < var_56_16 + var_56_17 + arg_56_0 and not isNil(var_56_15) and arg_53_1.var_.actorSpriteComps1061 then
				for iter_56_7, iter_56_8 in pairs(arg_53_1.var_.actorSpriteComps1061:ToTable()) do
					if iter_56_8 then
						if arg_53_1.isInRecall_ then
							iter_56_8.color = arg_53_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_56_8.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_53_1.var_.actorSpriteComps1061 = nil
			end

			local var_56_23 = 0
			local var_56_24 = 0.35

			if var_56_23 < arg_53_1.time_ and arg_53_1.time_ <= var_56_23 + arg_56_0 then
				arg_53_1.talkMaxDuration = 0
				arg_53_1.dialogCg_.alpha = 1

				arg_53_1.dialog_:SetActive(true)
				SetActive(arg_53_1.leftNameGo_, true)

				local var_56_25 = arg_53_1:FormatText(StoryNameCfg[605].name)

				arg_53_1.leftNameTxt_.text = var_56_25

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_53_1.leftNameTxt_.transform)

				arg_53_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_53_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_53_1:RecordName(arg_53_1.leftNameTxt_.text)
				SetActive(arg_53_1.iconTrs_.gameObject, false)
				arg_53_1.callingController_:SetSelectedState("normal")

				local var_56_26 = arg_53_1:GetWordFromCfg(410142013)
				local var_56_27 = arg_53_1:FormatText(var_56_26.content)

				arg_53_1.text_.text = var_56_27

				LuaForUtil.ClearLinePrefixSymbol(arg_53_1.text_)

				local var_56_28 = 14
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

				if manager.audio:GetVoiceLength("story_v_out_410142", "410142013", "story_v_out_410142.awb") ~= 0 then
					local var_56_31 = manager.audio:GetVoiceLength("story_v_out_410142", "410142013", "story_v_out_410142.awb") / 1000

					if var_56_31 + var_56_23 > arg_53_1.duration_ then
						arg_53_1.duration_ = var_56_31 + var_56_23
					end

					if var_56_26.prefab_name ~= "" and arg_53_1.actors_[var_56_26.prefab_name] ~= nil then
						local var_56_32 = LuaForUtil.PlayVoiceWithCriLipsync(arg_53_1.actors_[var_56_26.prefab_name].transform, "story_v_out_410142", "410142013", "story_v_out_410142.awb")

						arg_53_1:RecordAudio("410142013", var_56_32)
						arg_53_1:RecordAudio("410142013", var_56_32)
					else
						arg_53_1:AudioAction("play", "voice", "story_v_out_410142", "410142013", "story_v_out_410142.awb")
					end

					arg_53_1:RecordHistoryTalkVoice("story_v_out_410142", "410142013", "story_v_out_410142.awb")
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
				actorName = "1056",
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
	Play410142014 = function(arg_57_0, arg_57_1)
		arg_57_1.time_ = 0
		arg_57_1.frameCnt_ = 0
		arg_57_1.state_ = "playing"
		arg_57_1.curTalkId_ = 410142014
		arg_57_1.duration_ = 5

		SetActive(arg_57_1.tipsGo_, false)

		function arg_57_1.onSingleLineFinish_()
			arg_57_1.onSingleLineUpdate_ = nil
			arg_57_1.onSingleLineFinish_ = nil
			arg_57_1.state_ = "waiting"
		end

		function arg_57_1.playNext_(arg_59_0)
			if arg_59_0 == 1 then
				arg_57_0:Play410142015(arg_57_1)
			end
		end

		function arg_57_1.onSingleLineUpdate_(arg_60_0)
			local var_60_0 = arg_57_1.actors_["1056"]
			local var_60_1 = 0

			if var_60_1 < arg_57_1.time_ and arg_57_1.time_ <= var_60_1 + arg_60_0 and not isNil(var_60_0) and arg_57_1.var_.actorSpriteComps1056 == nil then
				arg_57_1.var_.actorSpriteComps1056 = var_60_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_60_2 = 0.034

			if var_60_1 <= arg_57_1.time_ and arg_57_1.time_ < var_60_1 + var_60_2 and not isNil(var_60_0) then
				local var_60_3 = (arg_57_1.time_ - var_60_1) / var_60_2

				if arg_57_1.var_.actorSpriteComps1056 then
					for iter_60_0, iter_60_1 in pairs(arg_57_1.var_.actorSpriteComps1056:ToTable()) do
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

			if arg_57_1.time_ >= var_60_1 + var_60_2 and arg_57_1.time_ < var_60_1 + var_60_2 + arg_60_0 and not isNil(var_60_0) and arg_57_1.var_.actorSpriteComps1056 then
				for iter_60_2, iter_60_3 in pairs(arg_57_1.var_.actorSpriteComps1056:ToTable()) do
					if iter_60_3 then
						if arg_57_1.isInRecall_ then
							iter_60_3.color = arg_57_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_60_3.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_57_1.var_.actorSpriteComps1056 = nil
			end

			local var_60_8 = arg_57_1.actors_["1061"]
			local var_60_9 = 0

			if var_60_9 < arg_57_1.time_ and arg_57_1.time_ <= var_60_9 + arg_60_0 and not isNil(var_60_8) and arg_57_1.var_.actorSpriteComps1061 == nil then
				arg_57_1.var_.actorSpriteComps1061 = var_60_8:GetComponentsInChildren(typeof(Image), true)
			end

			local var_60_10 = 0.034

			if var_60_9 <= arg_57_1.time_ and arg_57_1.time_ < var_60_9 + var_60_10 and not isNil(var_60_8) then
				local var_60_11 = (arg_57_1.time_ - var_60_9) / var_60_10

				if arg_57_1.var_.actorSpriteComps1061 then
					for iter_60_4, iter_60_5 in pairs(arg_57_1.var_.actorSpriteComps1061:ToTable()) do
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

			if arg_57_1.time_ >= var_60_9 + var_60_10 and arg_57_1.time_ < var_60_9 + var_60_10 + arg_60_0 and not isNil(var_60_8) and arg_57_1.var_.actorSpriteComps1061 then
				for iter_60_6, iter_60_7 in pairs(arg_57_1.var_.actorSpriteComps1061:ToTable()) do
					if iter_60_7 then
						if arg_57_1.isInRecall_ then
							iter_60_7.color = arg_57_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_60_7.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_57_1.var_.actorSpriteComps1061 = nil
			end

			local var_60_16 = 0
			local var_60_17 = 0.7

			if var_60_16 < arg_57_1.time_ and arg_57_1.time_ <= var_60_16 + arg_60_0 then
				arg_57_1.talkMaxDuration = 0
				arg_57_1.dialogCg_.alpha = 1

				arg_57_1.dialog_:SetActive(true)
				SetActive(arg_57_1.leftNameGo_, false)

				arg_57_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_57_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_57_1:RecordName(arg_57_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_57_1.iconTrs_.gameObject, false)
				arg_57_1.callingController_:SetSelectedState("normal")

				local var_60_18 = arg_57_1:GetWordFromCfg(410142014)
				local var_60_19 = arg_57_1:FormatText(var_60_18.content)

				arg_57_1.text_.text = var_60_19

				LuaForUtil.ClearLinePrefixSymbol(arg_57_1.text_)

				local var_60_20 = 28
				local var_60_21 = utf8.len(var_60_19)
				local var_60_22 = var_60_20 <= 0 and var_60_17 or var_60_17 * (var_60_21 / var_60_20)

				if var_60_22 > 0 and var_60_17 < var_60_22 then
					arg_57_1.talkMaxDuration = var_60_22

					if var_60_22 + var_60_16 > arg_57_1.duration_ then
						arg_57_1.duration_ = var_60_22 + var_60_16
					end
				end

				arg_57_1.text_.text = var_60_19
				arg_57_1.typewritter.percent = 0

				arg_57_1.typewritter:SetDirty()
				arg_57_1:ShowNextGo(false)
				arg_57_1:RecordContent(arg_57_1.text_.text)
			end

			local var_60_23 = math.max(var_60_17, arg_57_1.talkMaxDuration)

			if var_60_16 <= arg_57_1.time_ and arg_57_1.time_ < var_60_16 + var_60_23 then
				arg_57_1.typewritter.percent = (arg_57_1.time_ - var_60_16) / var_60_23

				arg_57_1.typewritter:SetDirty()
			end

			if arg_57_1.time_ >= var_60_16 + var_60_23 and arg_57_1.time_ < var_60_16 + var_60_23 + arg_60_0 then
				arg_57_1.typewritter.percent = 1

				arg_57_1.typewritter:SetDirty()
				arg_57_1:ShowNextGo(true)
			end
		end

		arg_57_1.nodeConfigList_ = {}

		arg_57_1:InitPlayNodeList()
	end,
	Play410142015 = function(arg_61_0, arg_61_1)
		arg_61_1.time_ = 0
		arg_61_1.frameCnt_ = 0
		arg_61_1.state_ = "playing"
		arg_61_1.curTalkId_ = 410142015
		arg_61_1.duration_ = 9

		SetActive(arg_61_1.tipsGo_, false)

		function arg_61_1.onSingleLineFinish_()
			arg_61_1.onSingleLineUpdate_ = nil
			arg_61_1.onSingleLineFinish_ = nil
			arg_61_1.state_ = "waiting"
		end

		function arg_61_1.playNext_(arg_63_0)
			if arg_63_0 == 1 then
				arg_61_0:Play410142016(arg_61_1)
			end
		end

		function arg_61_1.onSingleLineUpdate_(arg_64_0)
			local var_64_0 = 2

			if var_64_0 < arg_61_1.time_ and arg_61_1.time_ <= var_64_0 + arg_64_0 then
				local var_64_1 = manager.ui.mainCamera.transform.localPosition
				local var_64_2 = Vector3.New(0, 0, 10) + Vector3.New(var_64_1.x, var_64_1.y, 0)
				local var_64_3 = arg_61_1.bgs_.ST61

				var_64_3.transform.localPosition = var_64_2
				var_64_3.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_64_4 = var_64_3:GetComponent("SpriteRenderer")

				if var_64_4 and var_64_4.sprite then
					local var_64_5 = (var_64_3.transform.localPosition - var_64_1).z
					local var_64_6 = manager.ui.mainCameraCom_
					local var_64_7 = 2 * var_64_5 * Mathf.Tan(var_64_6.fieldOfView * 0.5 * Mathf.Deg2Rad)
					local var_64_8 = var_64_7 * var_64_6.aspect
					local var_64_9 = var_64_4.sprite.bounds.size.x
					local var_64_10 = var_64_4.sprite.bounds.size.y
					local var_64_11 = var_64_8 / var_64_9
					local var_64_12 = var_64_7 / var_64_10
					local var_64_13 = var_64_12 < var_64_11 and var_64_11 or var_64_12

					var_64_3.transform.localScale = Vector3.New(var_64_13, var_64_13, 0)
				end

				for iter_64_0, iter_64_1 in pairs(arg_61_1.bgs_) do
					if iter_64_0 ~= "ST61" then
						iter_64_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_64_14 = 0

			if var_64_14 < arg_61_1.time_ and arg_61_1.time_ <= var_64_14 + arg_64_0 then
				arg_61_1.mask_.enabled = true
				arg_61_1.mask_.raycastTarget = true

				arg_61_1:SetGaussion(false)
			end

			local var_64_15 = 2

			if var_64_14 <= arg_61_1.time_ and arg_61_1.time_ < var_64_14 + var_64_15 then
				local var_64_16 = (arg_61_1.time_ - var_64_14) / var_64_15
				local var_64_17 = Color.New(0, 0, 0)

				var_64_17.a = Mathf.Lerp(0, 1, var_64_16)
				arg_61_1.mask_.color = var_64_17
			end

			if arg_61_1.time_ >= var_64_14 + var_64_15 and arg_61_1.time_ < var_64_14 + var_64_15 + arg_64_0 then
				local var_64_18 = Color.New(0, 0, 0)

				var_64_18.a = 1
				arg_61_1.mask_.color = var_64_18
			end

			local var_64_19 = 2

			if var_64_19 < arg_61_1.time_ and arg_61_1.time_ <= var_64_19 + arg_64_0 then
				arg_61_1.mask_.enabled = true
				arg_61_1.mask_.raycastTarget = true

				arg_61_1:SetGaussion(false)
			end

			local var_64_20 = 2

			if var_64_19 <= arg_61_1.time_ and arg_61_1.time_ < var_64_19 + var_64_20 then
				local var_64_21 = (arg_61_1.time_ - var_64_19) / var_64_20
				local var_64_22 = Color.New(0, 0, 0)

				var_64_22.a = Mathf.Lerp(1, 0, var_64_21)
				arg_61_1.mask_.color = var_64_22
			end

			if arg_61_1.time_ >= var_64_19 + var_64_20 and arg_61_1.time_ < var_64_19 + var_64_20 + arg_64_0 then
				local var_64_23 = Color.New(0, 0, 0)
				local var_64_24 = 0

				arg_61_1.mask_.enabled = false
				var_64_23.a = var_64_24
				arg_61_1.mask_.color = var_64_23
			end

			local var_64_25 = arg_61_1.actors_["1056"].transform
			local var_64_26 = 2

			if var_64_26 < arg_61_1.time_ and arg_61_1.time_ <= var_64_26 + arg_64_0 then
				arg_61_1.var_.moveOldPos1056 = var_64_25.localPosition
				var_64_25.localScale = Vector3.New(1, 1, 1)

				arg_61_1:CheckSpriteTmpPos("1056", 7)

				local var_64_27 = var_64_25.childCount

				for iter_64_2 = 0, var_64_27 - 1 do
					local var_64_28 = var_64_25:GetChild(iter_64_2)

					if var_64_28.name == "split_1" or not string.find(var_64_28.name, "split") then
						var_64_28.gameObject:SetActive(true)
					else
						var_64_28.gameObject:SetActive(false)
					end
				end
			end

			local var_64_29 = 0.001

			if var_64_26 <= arg_61_1.time_ and arg_61_1.time_ < var_64_26 + var_64_29 then
				local var_64_30 = (arg_61_1.time_ - var_64_26) / var_64_29
				local var_64_31 = Vector3.New(0, -2000, -180)

				var_64_25.localPosition = Vector3.Lerp(arg_61_1.var_.moveOldPos1056, var_64_31, var_64_30)
			end

			if arg_61_1.time_ >= var_64_26 + var_64_29 and arg_61_1.time_ < var_64_26 + var_64_29 + arg_64_0 then
				var_64_25.localPosition = Vector3.New(0, -2000, -180)
			end

			local var_64_32 = arg_61_1.actors_["1061"].transform
			local var_64_33 = 2

			if var_64_33 < arg_61_1.time_ and arg_61_1.time_ <= var_64_33 + arg_64_0 then
				arg_61_1.var_.moveOldPos1061 = var_64_32.localPosition
				var_64_32.localScale = Vector3.New(1, 1, 1)

				arg_61_1:CheckSpriteTmpPos("1061", 7)

				local var_64_34 = var_64_32.childCount

				for iter_64_3 = 0, var_64_34 - 1 do
					local var_64_35 = var_64_32:GetChild(iter_64_3)

					if var_64_35.name == "split_1" or not string.find(var_64_35.name, "split") then
						var_64_35.gameObject:SetActive(true)
					else
						var_64_35.gameObject:SetActive(false)
					end
				end
			end

			local var_64_36 = 0.001

			if var_64_33 <= arg_61_1.time_ and arg_61_1.time_ < var_64_33 + var_64_36 then
				local var_64_37 = (arg_61_1.time_ - var_64_33) / var_64_36
				local var_64_38 = Vector3.New(0, -2000, -180)

				var_64_32.localPosition = Vector3.Lerp(arg_61_1.var_.moveOldPos1061, var_64_38, var_64_37)
			end

			if arg_61_1.time_ >= var_64_33 + var_64_36 and arg_61_1.time_ < var_64_33 + var_64_36 + arg_64_0 then
				var_64_32.localPosition = Vector3.New(0, -2000, -180)
			end

			if arg_61_1.frameCnt_ <= 1 then
				arg_61_1.dialog_:SetActive(false)
			end

			local var_64_39 = 4
			local var_64_40 = 1.025

			if var_64_39 < arg_61_1.time_ and arg_61_1.time_ <= var_64_39 + arg_64_0 then
				arg_61_1.talkMaxDuration = 0

				arg_61_1.dialog_:SetActive(true)

				arg_61_1.dialogCg_.alpha = 0

				local var_64_41 = LeanTween.value(arg_61_1.dialog_, 0, 1, 0.3)

				var_64_41:setOnUpdate(LuaHelper.FloatAction(function(arg_65_0)
					arg_61_1.dialogCg_.alpha = arg_65_0
				end))
				var_64_41:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_61_1.dialog_)
					var_64_41:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_61_1.duration_ = arg_61_1.duration_ + 0.3

				SetActive(arg_61_1.leftNameGo_, false)

				arg_61_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_61_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_61_1:RecordName(arg_61_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_61_1.iconTrs_.gameObject, false)
				arg_61_1.callingController_:SetSelectedState("normal")

				local var_64_42 = arg_61_1:GetWordFromCfg(410142015)
				local var_64_43 = arg_61_1:FormatText(var_64_42.content)

				arg_61_1.text_.text = var_64_43

				LuaForUtil.ClearLinePrefixSymbol(arg_61_1.text_)

				local var_64_44 = 41
				local var_64_45 = utf8.len(var_64_43)
				local var_64_46 = var_64_44 <= 0 and var_64_40 or var_64_40 * (var_64_45 / var_64_44)

				if var_64_46 > 0 and var_64_40 < var_64_46 then
					arg_61_1.talkMaxDuration = var_64_46
					var_64_39 = var_64_39 + 0.3

					if var_64_46 + var_64_39 > arg_61_1.duration_ then
						arg_61_1.duration_ = var_64_46 + var_64_39
					end
				end

				arg_61_1.text_.text = var_64_43
				arg_61_1.typewritter.percent = 0

				arg_61_1.typewritter:SetDirty()
				arg_61_1:ShowNextGo(false)
				arg_61_1:RecordContent(arg_61_1.text_.text)
			end

			local var_64_47 = var_64_39 + 0.3
			local var_64_48 = math.max(var_64_40, arg_61_1.talkMaxDuration)

			if var_64_47 <= arg_61_1.time_ and arg_61_1.time_ < var_64_47 + var_64_48 then
				arg_61_1.typewritter.percent = (arg_61_1.time_ - var_64_47) / var_64_48

				arg_61_1.typewritter:SetDirty()
			end

			if arg_61_1.time_ >= var_64_47 + var_64_48 and arg_61_1.time_ < var_64_47 + var_64_48 + arg_64_0 then
				arg_61_1.typewritter.percent = 1

				arg_61_1.typewritter:SetDirty()
				arg_61_1:ShowNextGo(true)
			end
		end

		arg_61_1.nodeConfigList_ = {
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
				actorName = "1061",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 2,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_61_1:InitPlayNodeList()
	end,
	Play410142016 = function(arg_67_0, arg_67_1)
		arg_67_1.time_ = 0
		arg_67_1.frameCnt_ = 0
		arg_67_1.state_ = "playing"
		arg_67_1.curTalkId_ = 410142016
		arg_67_1.duration_ = 5

		SetActive(arg_67_1.tipsGo_, false)

		function arg_67_1.onSingleLineFinish_()
			arg_67_1.onSingleLineUpdate_ = nil
			arg_67_1.onSingleLineFinish_ = nil
			arg_67_1.state_ = "waiting"
		end

		function arg_67_1.playNext_(arg_69_0)
			if arg_69_0 == 1 then
				arg_67_0:Play410142017(arg_67_1)
			end
		end

		function arg_67_1.onSingleLineUpdate_(arg_70_0)
			local var_70_0 = arg_67_1.actors_["1061"].transform
			local var_70_1 = 0

			if var_70_1 < arg_67_1.time_ and arg_67_1.time_ <= var_70_1 + arg_70_0 then
				arg_67_1.var_.moveOldPos1061 = var_70_0.localPosition
				var_70_0.localScale = Vector3.New(1, 1, 1)

				arg_67_1:CheckSpriteTmpPos("1061", 3)

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
				local var_70_6 = Vector3.New(0, -490, 18)

				var_70_0.localPosition = Vector3.Lerp(arg_67_1.var_.moveOldPos1061, var_70_6, var_70_5)
			end

			if arg_67_1.time_ >= var_70_1 + var_70_4 and arg_67_1.time_ < var_70_1 + var_70_4 + arg_70_0 then
				var_70_0.localPosition = Vector3.New(0, -490, 18)
			end

			local var_70_7 = arg_67_1.actors_["1061"]
			local var_70_8 = 0

			if var_70_8 < arg_67_1.time_ and arg_67_1.time_ <= var_70_8 + arg_70_0 and not isNil(var_70_7) and arg_67_1.var_.actorSpriteComps1061 == nil then
				arg_67_1.var_.actorSpriteComps1061 = var_70_7:GetComponentsInChildren(typeof(Image), true)
			end

			local var_70_9 = 0.034

			if var_70_8 <= arg_67_1.time_ and arg_67_1.time_ < var_70_8 + var_70_9 and not isNil(var_70_7) then
				local var_70_10 = (arg_67_1.time_ - var_70_8) / var_70_9

				if arg_67_1.var_.actorSpriteComps1061 then
					for iter_70_1, iter_70_2 in pairs(arg_67_1.var_.actorSpriteComps1061:ToTable()) do
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

			if arg_67_1.time_ >= var_70_8 + var_70_9 and arg_67_1.time_ < var_70_8 + var_70_9 + arg_70_0 and not isNil(var_70_7) and arg_67_1.var_.actorSpriteComps1061 then
				for iter_70_3, iter_70_4 in pairs(arg_67_1.var_.actorSpriteComps1061:ToTable()) do
					if iter_70_4 then
						if arg_67_1.isInRecall_ then
							iter_70_4.color = arg_67_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_70_4.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_67_1.var_.actorSpriteComps1061 = nil
			end

			local var_70_15 = 0
			local var_70_16 = 1.125

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

				local var_70_17 = arg_67_1:GetWordFromCfg(410142016)
				local var_70_18 = arg_67_1:FormatText(var_70_17.content)

				arg_67_1.text_.text = var_70_18

				LuaForUtil.ClearLinePrefixSymbol(arg_67_1.text_)

				local var_70_19 = 45
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
				actorName = "1061",
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
	Play410142017 = function(arg_71_0, arg_71_1)
		arg_71_1.time_ = 0
		arg_71_1.frameCnt_ = 0
		arg_71_1.state_ = "playing"
		arg_71_1.curTalkId_ = 410142017
		arg_71_1.duration_ = 5.77

		local var_71_0 = {
			ja = 5.766,
			CriLanguages = 1.9,
			zh = 1.9
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
				arg_71_0:Play410142018(arg_71_1)
			end
		end

		function arg_71_1.onSingleLineUpdate_(arg_74_0)
			local var_74_0 = arg_71_1.actors_["1061"].transform
			local var_74_1 = 0

			if var_74_1 < arg_71_1.time_ and arg_71_1.time_ <= var_74_1 + arg_74_0 then
				arg_71_1.var_.moveOldPos1061 = var_74_0.localPosition
				var_74_0.localScale = Vector3.New(1, 1, 1)

				arg_71_1:CheckSpriteTmpPos("1061", 3)

				local var_74_2 = var_74_0.childCount

				for iter_74_0 = 0, var_74_2 - 1 do
					local var_74_3 = var_74_0:GetChild(iter_74_0)

					if var_74_3.name == "" or not string.find(var_74_3.name, "split") then
						var_74_3.gameObject:SetActive(true)
					else
						var_74_3.gameObject:SetActive(false)
					end
				end
			end

			local var_74_4 = 0.001

			if var_74_1 <= arg_71_1.time_ and arg_71_1.time_ < var_74_1 + var_74_4 then
				local var_74_5 = (arg_71_1.time_ - var_74_1) / var_74_4
				local var_74_6 = Vector3.New(0, -490, 18)

				var_74_0.localPosition = Vector3.Lerp(arg_71_1.var_.moveOldPos1061, var_74_6, var_74_5)
			end

			if arg_71_1.time_ >= var_74_1 + var_74_4 and arg_71_1.time_ < var_74_1 + var_74_4 + arg_74_0 then
				var_74_0.localPosition = Vector3.New(0, -490, 18)
			end

			local var_74_7 = arg_71_1.actors_["1061"]
			local var_74_8 = 0

			if var_74_8 < arg_71_1.time_ and arg_71_1.time_ <= var_74_8 + arg_74_0 and not isNil(var_74_7) and arg_71_1.var_.actorSpriteComps1061 == nil then
				arg_71_1.var_.actorSpriteComps1061 = var_74_7:GetComponentsInChildren(typeof(Image), true)
			end

			local var_74_9 = 0.034

			if var_74_8 <= arg_71_1.time_ and arg_71_1.time_ < var_74_8 + var_74_9 and not isNil(var_74_7) then
				local var_74_10 = (arg_71_1.time_ - var_74_8) / var_74_9

				if arg_71_1.var_.actorSpriteComps1061 then
					for iter_74_1, iter_74_2 in pairs(arg_71_1.var_.actorSpriteComps1061:ToTable()) do
						if iter_74_2 then
							if arg_71_1.isInRecall_ then
								local var_74_11 = Mathf.Lerp(iter_74_2.color.r, arg_71_1.hightColor2.r, var_74_10)
								local var_74_12 = Mathf.Lerp(iter_74_2.color.g, arg_71_1.hightColor2.g, var_74_10)
								local var_74_13 = Mathf.Lerp(iter_74_2.color.b, arg_71_1.hightColor2.b, var_74_10)

								iter_74_2.color = Color.New(var_74_11, var_74_12, var_74_13)
							else
								local var_74_14 = Mathf.Lerp(iter_74_2.color.r, 0.5, var_74_10)

								iter_74_2.color = Color.New(var_74_14, var_74_14, var_74_14)
							end
						end
					end
				end
			end

			if arg_71_1.time_ >= var_74_8 + var_74_9 and arg_71_1.time_ < var_74_8 + var_74_9 + arg_74_0 and not isNil(var_74_7) and arg_71_1.var_.actorSpriteComps1061 then
				for iter_74_3, iter_74_4 in pairs(arg_71_1.var_.actorSpriteComps1061:ToTable()) do
					if iter_74_4 then
						if arg_71_1.isInRecall_ then
							iter_74_4.color = arg_71_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_74_4.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_71_1.var_.actorSpriteComps1061 = nil
			end

			local var_74_15 = 0
			local var_74_16 = 0.1

			if var_74_15 < arg_71_1.time_ and arg_71_1.time_ <= var_74_15 + arg_74_0 then
				arg_71_1.talkMaxDuration = 0
				arg_71_1.dialogCg_.alpha = 1

				arg_71_1.dialog_:SetActive(true)
				SetActive(arg_71_1.leftNameGo_, true)

				local var_74_17 = arg_71_1:FormatText(StoryNameCfg[613].name)

				arg_71_1.leftNameTxt_.text = var_74_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_71_1.leftNameTxt_.transform)

				arg_71_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_71_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_71_1:RecordName(arg_71_1.leftNameTxt_.text)
				SetActive(arg_71_1.iconTrs_.gameObject, true)
				arg_71_1.iconController_:SetSelectedState("hero")

				arg_71_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_1020")

				arg_71_1.callingController_:SetSelectedState("normal")

				arg_71_1.keyicon_.color = Color.New(1, 1, 1)
				arg_71_1.icon_.color = Color.New(1, 1, 1)

				local var_74_18 = arg_71_1:GetWordFromCfg(410142017)
				local var_74_19 = arg_71_1:FormatText(var_74_18.content)

				arg_71_1.text_.text = var_74_19

				LuaForUtil.ClearLinePrefixSymbol(arg_71_1.text_)

				local var_74_20 = 4
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

				if manager.audio:GetVoiceLength("story_v_out_410142", "410142017", "story_v_out_410142.awb") ~= 0 then
					local var_74_23 = manager.audio:GetVoiceLength("story_v_out_410142", "410142017", "story_v_out_410142.awb") / 1000

					if var_74_23 + var_74_15 > arg_71_1.duration_ then
						arg_71_1.duration_ = var_74_23 + var_74_15
					end

					if var_74_18.prefab_name ~= "" and arg_71_1.actors_[var_74_18.prefab_name] ~= nil then
						local var_74_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_71_1.actors_[var_74_18.prefab_name].transform, "story_v_out_410142", "410142017", "story_v_out_410142.awb")

						arg_71_1:RecordAudio("410142017", var_74_24)
						arg_71_1:RecordAudio("410142017", var_74_24)
					else
						arg_71_1:AudioAction("play", "voice", "story_v_out_410142", "410142017", "story_v_out_410142.awb")
					end

					arg_71_1:RecordHistoryTalkVoice("story_v_out_410142", "410142017", "story_v_out_410142.awb")
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
				actorName = "1061",
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
	Play410142018 = function(arg_75_0, arg_75_1)
		arg_75_1.time_ = 0
		arg_75_1.frameCnt_ = 0
		arg_75_1.state_ = "playing"
		arg_75_1.curTalkId_ = 410142018
		arg_75_1.duration_ = 11.57

		local var_75_0 = {
			ja = 11.566,
			CriLanguages = 6.333,
			zh = 6.333
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
				arg_75_0:Play410142019(arg_75_1)
			end
		end

		function arg_75_1.onSingleLineUpdate_(arg_78_0)
			local var_78_0 = arg_75_1.actors_["1061"].transform
			local var_78_1 = 0

			if var_78_1 < arg_75_1.time_ and arg_75_1.time_ <= var_78_1 + arg_78_0 then
				arg_75_1.var_.moveOldPos1061 = var_78_0.localPosition
				var_78_0.localScale = Vector3.New(1, 1, 1)

				arg_75_1:CheckSpriteTmpPos("1061", 3)

				local var_78_2 = var_78_0.childCount

				for iter_78_0 = 0, var_78_2 - 1 do
					local var_78_3 = var_78_0:GetChild(iter_78_0)

					if var_78_3.name == "split_5" or not string.find(var_78_3.name, "split") then
						var_78_3.gameObject:SetActive(true)
					else
						var_78_3.gameObject:SetActive(false)
					end
				end
			end

			local var_78_4 = 0.001

			if var_78_1 <= arg_75_1.time_ and arg_75_1.time_ < var_78_1 + var_78_4 then
				local var_78_5 = (arg_75_1.time_ - var_78_1) / var_78_4
				local var_78_6 = Vector3.New(0, -490, 18)

				var_78_0.localPosition = Vector3.Lerp(arg_75_1.var_.moveOldPos1061, var_78_6, var_78_5)
			end

			if arg_75_1.time_ >= var_78_1 + var_78_4 and arg_75_1.time_ < var_78_1 + var_78_4 + arg_78_0 then
				var_78_0.localPosition = Vector3.New(0, -490, 18)
			end

			local var_78_7 = arg_75_1.actors_["1061"]
			local var_78_8 = 0

			if var_78_8 < arg_75_1.time_ and arg_75_1.time_ <= var_78_8 + arg_78_0 and not isNil(var_78_7) and arg_75_1.var_.actorSpriteComps1061 == nil then
				arg_75_1.var_.actorSpriteComps1061 = var_78_7:GetComponentsInChildren(typeof(Image), true)
			end

			local var_78_9 = 0.034

			if var_78_8 <= arg_75_1.time_ and arg_75_1.time_ < var_78_8 + var_78_9 and not isNil(var_78_7) then
				local var_78_10 = (arg_75_1.time_ - var_78_8) / var_78_9

				if arg_75_1.var_.actorSpriteComps1061 then
					for iter_78_1, iter_78_2 in pairs(arg_75_1.var_.actorSpriteComps1061:ToTable()) do
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

			if arg_75_1.time_ >= var_78_8 + var_78_9 and arg_75_1.time_ < var_78_8 + var_78_9 + arg_78_0 and not isNil(var_78_7) and arg_75_1.var_.actorSpriteComps1061 then
				for iter_78_3, iter_78_4 in pairs(arg_75_1.var_.actorSpriteComps1061:ToTable()) do
					if iter_78_4 then
						if arg_75_1.isInRecall_ then
							iter_78_4.color = arg_75_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_78_4.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_75_1.var_.actorSpriteComps1061 = nil
			end

			local var_78_15 = 0
			local var_78_16 = 0.8

			if var_78_15 < arg_75_1.time_ and arg_75_1.time_ <= var_78_15 + arg_78_0 then
				arg_75_1.talkMaxDuration = 0
				arg_75_1.dialogCg_.alpha = 1

				arg_75_1.dialog_:SetActive(true)
				SetActive(arg_75_1.leftNameGo_, true)

				local var_78_17 = arg_75_1:FormatText(StoryNameCfg[612].name)

				arg_75_1.leftNameTxt_.text = var_78_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_75_1.leftNameTxt_.transform)

				arg_75_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_75_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_75_1:RecordName(arg_75_1.leftNameTxt_.text)
				SetActive(arg_75_1.iconTrs_.gameObject, false)
				arg_75_1.callingController_:SetSelectedState("normal")

				local var_78_18 = arg_75_1:GetWordFromCfg(410142018)
				local var_78_19 = arg_75_1:FormatText(var_78_18.content)

				arg_75_1.text_.text = var_78_19

				LuaForUtil.ClearLinePrefixSymbol(arg_75_1.text_)

				local var_78_20 = 32
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

				if manager.audio:GetVoiceLength("story_v_out_410142", "410142018", "story_v_out_410142.awb") ~= 0 then
					local var_78_23 = manager.audio:GetVoiceLength("story_v_out_410142", "410142018", "story_v_out_410142.awb") / 1000

					if var_78_23 + var_78_15 > arg_75_1.duration_ then
						arg_75_1.duration_ = var_78_23 + var_78_15
					end

					if var_78_18.prefab_name ~= "" and arg_75_1.actors_[var_78_18.prefab_name] ~= nil then
						local var_78_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_75_1.actors_[var_78_18.prefab_name].transform, "story_v_out_410142", "410142018", "story_v_out_410142.awb")

						arg_75_1:RecordAudio("410142018", var_78_24)
						arg_75_1:RecordAudio("410142018", var_78_24)
					else
						arg_75_1:AudioAction("play", "voice", "story_v_out_410142", "410142018", "story_v_out_410142.awb")
					end

					arg_75_1:RecordHistoryTalkVoice("story_v_out_410142", "410142018", "story_v_out_410142.awb")
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
				actorName = "1061",
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
	Play410142019 = function(arg_79_0, arg_79_1)
		arg_79_1.time_ = 0
		arg_79_1.frameCnt_ = 0
		arg_79_1.state_ = "playing"
		arg_79_1.curTalkId_ = 410142019
		arg_79_1.duration_ = 16.4

		local var_79_0 = {
			ja = 16.4,
			CriLanguages = 5.533,
			zh = 5.533
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
				arg_79_0:Play410142020(arg_79_1)
			end
		end

		function arg_79_1.onSingleLineUpdate_(arg_82_0)
			local var_82_0 = arg_79_1.actors_["1061"]
			local var_82_1 = 0

			if var_82_1 < arg_79_1.time_ and arg_79_1.time_ <= var_82_1 + arg_82_0 and not isNil(var_82_0) and arg_79_1.var_.actorSpriteComps1061 == nil then
				arg_79_1.var_.actorSpriteComps1061 = var_82_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_82_2 = 0.034

			if var_82_1 <= arg_79_1.time_ and arg_79_1.time_ < var_82_1 + var_82_2 and not isNil(var_82_0) then
				local var_82_3 = (arg_79_1.time_ - var_82_1) / var_82_2

				if arg_79_1.var_.actorSpriteComps1061 then
					for iter_82_0, iter_82_1 in pairs(arg_79_1.var_.actorSpriteComps1061:ToTable()) do
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

			if arg_79_1.time_ >= var_82_1 + var_82_2 and arg_79_1.time_ < var_82_1 + var_82_2 + arg_82_0 and not isNil(var_82_0) and arg_79_1.var_.actorSpriteComps1061 then
				for iter_82_2, iter_82_3 in pairs(arg_79_1.var_.actorSpriteComps1061:ToTable()) do
					if iter_82_3 then
						if arg_79_1.isInRecall_ then
							iter_82_3.color = arg_79_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_82_3.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_79_1.var_.actorSpriteComps1061 = nil
			end

			local var_82_8 = 0
			local var_82_9 = 0.6

			if var_82_8 < arg_79_1.time_ and arg_79_1.time_ <= var_82_8 + arg_82_0 then
				arg_79_1.talkMaxDuration = 0
				arg_79_1.dialogCg_.alpha = 1

				arg_79_1.dialog_:SetActive(true)
				SetActive(arg_79_1.leftNameGo_, true)

				local var_82_10 = arg_79_1:FormatText(StoryNameCfg[613].name)

				arg_79_1.leftNameTxt_.text = var_82_10

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_79_1.leftNameTxt_.transform)

				arg_79_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_79_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_79_1:RecordName(arg_79_1.leftNameTxt_.text)
				SetActive(arg_79_1.iconTrs_.gameObject, true)
				arg_79_1.iconController_:SetSelectedState("hero")

				arg_79_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_1020")

				arg_79_1.callingController_:SetSelectedState("normal")

				arg_79_1.keyicon_.color = Color.New(1, 1, 1)
				arg_79_1.icon_.color = Color.New(1, 1, 1)

				local var_82_11 = arg_79_1:GetWordFromCfg(410142019)
				local var_82_12 = arg_79_1:FormatText(var_82_11.content)

				arg_79_1.text_.text = var_82_12

				LuaForUtil.ClearLinePrefixSymbol(arg_79_1.text_)

				local var_82_13 = 24
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

				if manager.audio:GetVoiceLength("story_v_out_410142", "410142019", "story_v_out_410142.awb") ~= 0 then
					local var_82_16 = manager.audio:GetVoiceLength("story_v_out_410142", "410142019", "story_v_out_410142.awb") / 1000

					if var_82_16 + var_82_8 > arg_79_1.duration_ then
						arg_79_1.duration_ = var_82_16 + var_82_8
					end

					if var_82_11.prefab_name ~= "" and arg_79_1.actors_[var_82_11.prefab_name] ~= nil then
						local var_82_17 = LuaForUtil.PlayVoiceWithCriLipsync(arg_79_1.actors_[var_82_11.prefab_name].transform, "story_v_out_410142", "410142019", "story_v_out_410142.awb")

						arg_79_1:RecordAudio("410142019", var_82_17)
						arg_79_1:RecordAudio("410142019", var_82_17)
					else
						arg_79_1:AudioAction("play", "voice", "story_v_out_410142", "410142019", "story_v_out_410142.awb")
					end

					arg_79_1:RecordHistoryTalkVoice("story_v_out_410142", "410142019", "story_v_out_410142.awb")
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
	Play410142020 = function(arg_83_0, arg_83_1)
		arg_83_1.time_ = 0
		arg_83_1.frameCnt_ = 0
		arg_83_1.state_ = "playing"
		arg_83_1.curTalkId_ = 410142020
		arg_83_1.duration_ = 14.7

		local var_83_0 = {
			ja = 14.7,
			CriLanguages = 6.1,
			zh = 6.1
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
				arg_83_0:Play410142021(arg_83_1)
			end
		end

		function arg_83_1.onSingleLineUpdate_(arg_86_0)
			local var_86_0 = arg_83_1.actors_["1061"].transform
			local var_86_1 = 0

			if var_86_1 < arg_83_1.time_ and arg_83_1.time_ <= var_86_1 + arg_86_0 then
				arg_83_1.var_.moveOldPos1061 = var_86_0.localPosition
				var_86_0.localScale = Vector3.New(1, 1, 1)

				arg_83_1:CheckSpriteTmpPos("1061", 3)

				local var_86_2 = var_86_0.childCount

				for iter_86_0 = 0, var_86_2 - 1 do
					local var_86_3 = var_86_0:GetChild(iter_86_0)

					if var_86_3.name == "split_5" or not string.find(var_86_3.name, "split") then
						var_86_3.gameObject:SetActive(true)
					else
						var_86_3.gameObject:SetActive(false)
					end
				end
			end

			local var_86_4 = 0.001

			if var_86_1 <= arg_83_1.time_ and arg_83_1.time_ < var_86_1 + var_86_4 then
				local var_86_5 = (arg_83_1.time_ - var_86_1) / var_86_4
				local var_86_6 = Vector3.New(0, -490, 18)

				var_86_0.localPosition = Vector3.Lerp(arg_83_1.var_.moveOldPos1061, var_86_6, var_86_5)
			end

			if arg_83_1.time_ >= var_86_1 + var_86_4 and arg_83_1.time_ < var_86_1 + var_86_4 + arg_86_0 then
				var_86_0.localPosition = Vector3.New(0, -490, 18)
			end

			local var_86_7 = arg_83_1.actors_["1061"]
			local var_86_8 = 0

			if var_86_8 < arg_83_1.time_ and arg_83_1.time_ <= var_86_8 + arg_86_0 and not isNil(var_86_7) and arg_83_1.var_.actorSpriteComps1061 == nil then
				arg_83_1.var_.actorSpriteComps1061 = var_86_7:GetComponentsInChildren(typeof(Image), true)
			end

			local var_86_9 = 0.034

			if var_86_8 <= arg_83_1.time_ and arg_83_1.time_ < var_86_8 + var_86_9 and not isNil(var_86_7) then
				local var_86_10 = (arg_83_1.time_ - var_86_8) / var_86_9

				if arg_83_1.var_.actorSpriteComps1061 then
					for iter_86_1, iter_86_2 in pairs(arg_83_1.var_.actorSpriteComps1061:ToTable()) do
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

			if arg_83_1.time_ >= var_86_8 + var_86_9 and arg_83_1.time_ < var_86_8 + var_86_9 + arg_86_0 and not isNil(var_86_7) and arg_83_1.var_.actorSpriteComps1061 then
				for iter_86_3, iter_86_4 in pairs(arg_83_1.var_.actorSpriteComps1061:ToTable()) do
					if iter_86_4 then
						if arg_83_1.isInRecall_ then
							iter_86_4.color = arg_83_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_86_4.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_83_1.var_.actorSpriteComps1061 = nil
			end

			local var_86_15 = 0
			local var_86_16 = 0.775

			if var_86_15 < arg_83_1.time_ and arg_83_1.time_ <= var_86_15 + arg_86_0 then
				arg_83_1.talkMaxDuration = 0
				arg_83_1.dialogCg_.alpha = 1

				arg_83_1.dialog_:SetActive(true)
				SetActive(arg_83_1.leftNameGo_, true)

				local var_86_17 = arg_83_1:FormatText(StoryNameCfg[612].name)

				arg_83_1.leftNameTxt_.text = var_86_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_83_1.leftNameTxt_.transform)

				arg_83_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_83_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_83_1:RecordName(arg_83_1.leftNameTxt_.text)
				SetActive(arg_83_1.iconTrs_.gameObject, false)
				arg_83_1.callingController_:SetSelectedState("normal")

				local var_86_18 = arg_83_1:GetWordFromCfg(410142020)
				local var_86_19 = arg_83_1:FormatText(var_86_18.content)

				arg_83_1.text_.text = var_86_19

				LuaForUtil.ClearLinePrefixSymbol(arg_83_1.text_)

				local var_86_20 = 31
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

				if manager.audio:GetVoiceLength("story_v_out_410142", "410142020", "story_v_out_410142.awb") ~= 0 then
					local var_86_23 = manager.audio:GetVoiceLength("story_v_out_410142", "410142020", "story_v_out_410142.awb") / 1000

					if var_86_23 + var_86_15 > arg_83_1.duration_ then
						arg_83_1.duration_ = var_86_23 + var_86_15
					end

					if var_86_18.prefab_name ~= "" and arg_83_1.actors_[var_86_18.prefab_name] ~= nil then
						local var_86_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_83_1.actors_[var_86_18.prefab_name].transform, "story_v_out_410142", "410142020", "story_v_out_410142.awb")

						arg_83_1:RecordAudio("410142020", var_86_24)
						arg_83_1:RecordAudio("410142020", var_86_24)
					else
						arg_83_1:AudioAction("play", "voice", "story_v_out_410142", "410142020", "story_v_out_410142.awb")
					end

					arg_83_1:RecordHistoryTalkVoice("story_v_out_410142", "410142020", "story_v_out_410142.awb")
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
				actorName = "1061",
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
	Play410142021 = function(arg_87_0, arg_87_1)
		arg_87_1.time_ = 0
		arg_87_1.frameCnt_ = 0
		arg_87_1.state_ = "playing"
		arg_87_1.curTalkId_ = 410142021
		arg_87_1.duration_ = 9.57

		local var_87_0 = {
			ja = 9.566,
			CriLanguages = 2.4,
			zh = 2.4
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
				arg_87_0:Play410142022(arg_87_1)
			end
		end

		function arg_87_1.onSingleLineUpdate_(arg_90_0)
			local var_90_0 = arg_87_1.actors_["1061"]
			local var_90_1 = 0

			if var_90_1 < arg_87_1.time_ and arg_87_1.time_ <= var_90_1 + arg_90_0 and not isNil(var_90_0) and arg_87_1.var_.actorSpriteComps1061 == nil then
				arg_87_1.var_.actorSpriteComps1061 = var_90_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_90_2 = 0.034

			if var_90_1 <= arg_87_1.time_ and arg_87_1.time_ < var_90_1 + var_90_2 and not isNil(var_90_0) then
				local var_90_3 = (arg_87_1.time_ - var_90_1) / var_90_2

				if arg_87_1.var_.actorSpriteComps1061 then
					for iter_90_0, iter_90_1 in pairs(arg_87_1.var_.actorSpriteComps1061:ToTable()) do
						if iter_90_1 then
							if arg_87_1.isInRecall_ then
								local var_90_4 = Mathf.Lerp(iter_90_1.color.r, arg_87_1.hightColor2.r, var_90_3)
								local var_90_5 = Mathf.Lerp(iter_90_1.color.g, arg_87_1.hightColor2.g, var_90_3)
								local var_90_6 = Mathf.Lerp(iter_90_1.color.b, arg_87_1.hightColor2.b, var_90_3)

								iter_90_1.color = Color.New(var_90_4, var_90_5, var_90_6)
							else
								local var_90_7 = Mathf.Lerp(iter_90_1.color.r, 0.5, var_90_3)

								iter_90_1.color = Color.New(var_90_7, var_90_7, var_90_7)
							end
						end
					end
				end
			end

			if arg_87_1.time_ >= var_90_1 + var_90_2 and arg_87_1.time_ < var_90_1 + var_90_2 + arg_90_0 and not isNil(var_90_0) and arg_87_1.var_.actorSpriteComps1061 then
				for iter_90_2, iter_90_3 in pairs(arg_87_1.var_.actorSpriteComps1061:ToTable()) do
					if iter_90_3 then
						if arg_87_1.isInRecall_ then
							iter_90_3.color = arg_87_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_90_3.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_87_1.var_.actorSpriteComps1061 = nil
			end

			local var_90_8 = 0
			local var_90_9 = 0.2

			if var_90_8 < arg_87_1.time_ and arg_87_1.time_ <= var_90_8 + arg_90_0 then
				arg_87_1.talkMaxDuration = 0
				arg_87_1.dialogCg_.alpha = 1

				arg_87_1.dialog_:SetActive(true)
				SetActive(arg_87_1.leftNameGo_, true)

				local var_90_10 = arg_87_1:FormatText(StoryNameCfg[613].name)

				arg_87_1.leftNameTxt_.text = var_90_10

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_87_1.leftNameTxt_.transform)

				arg_87_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_87_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_87_1:RecordName(arg_87_1.leftNameTxt_.text)
				SetActive(arg_87_1.iconTrs_.gameObject, true)
				arg_87_1.iconController_:SetSelectedState("hero")

				arg_87_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_1020")

				arg_87_1.callingController_:SetSelectedState("normal")

				arg_87_1.keyicon_.color = Color.New(1, 1, 1)
				arg_87_1.icon_.color = Color.New(1, 1, 1)

				local var_90_11 = arg_87_1:GetWordFromCfg(410142021)
				local var_90_12 = arg_87_1:FormatText(var_90_11.content)

				arg_87_1.text_.text = var_90_12

				LuaForUtil.ClearLinePrefixSymbol(arg_87_1.text_)

				local var_90_13 = 8
				local var_90_14 = utf8.len(var_90_12)
				local var_90_15 = var_90_13 <= 0 and var_90_9 or var_90_9 * (var_90_14 / var_90_13)

				if var_90_15 > 0 and var_90_9 < var_90_15 then
					arg_87_1.talkMaxDuration = var_90_15

					if var_90_15 + var_90_8 > arg_87_1.duration_ then
						arg_87_1.duration_ = var_90_15 + var_90_8
					end
				end

				arg_87_1.text_.text = var_90_12
				arg_87_1.typewritter.percent = 0

				arg_87_1.typewritter:SetDirty()
				arg_87_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_410142", "410142021", "story_v_out_410142.awb") ~= 0 then
					local var_90_16 = manager.audio:GetVoiceLength("story_v_out_410142", "410142021", "story_v_out_410142.awb") / 1000

					if var_90_16 + var_90_8 > arg_87_1.duration_ then
						arg_87_1.duration_ = var_90_16 + var_90_8
					end

					if var_90_11.prefab_name ~= "" and arg_87_1.actors_[var_90_11.prefab_name] ~= nil then
						local var_90_17 = LuaForUtil.PlayVoiceWithCriLipsync(arg_87_1.actors_[var_90_11.prefab_name].transform, "story_v_out_410142", "410142021", "story_v_out_410142.awb")

						arg_87_1:RecordAudio("410142021", var_90_17)
						arg_87_1:RecordAudio("410142021", var_90_17)
					else
						arg_87_1:AudioAction("play", "voice", "story_v_out_410142", "410142021", "story_v_out_410142.awb")
					end

					arg_87_1:RecordHistoryTalkVoice("story_v_out_410142", "410142021", "story_v_out_410142.awb")
				end

				arg_87_1:RecordContent(arg_87_1.text_.text)
			end

			local var_90_18 = math.max(var_90_9, arg_87_1.talkMaxDuration)

			if var_90_8 <= arg_87_1.time_ and arg_87_1.time_ < var_90_8 + var_90_18 then
				arg_87_1.typewritter.percent = (arg_87_1.time_ - var_90_8) / var_90_18

				arg_87_1.typewritter:SetDirty()
			end

			if arg_87_1.time_ >= var_90_8 + var_90_18 and arg_87_1.time_ < var_90_8 + var_90_18 + arg_90_0 then
				arg_87_1.typewritter.percent = 1

				arg_87_1.typewritter:SetDirty()
				arg_87_1:ShowNextGo(true)
			end
		end

		arg_87_1.nodeConfigList_ = {}

		arg_87_1:InitPlayNodeList()
	end,
	Play410142022 = function(arg_91_0, arg_91_1)
		arg_91_1.time_ = 0
		arg_91_1.frameCnt_ = 0
		arg_91_1.state_ = "playing"
		arg_91_1.curTalkId_ = 410142022
		arg_91_1.duration_ = 4.8

		local var_91_0 = {
			ja = 4.8,
			CriLanguages = 2.633,
			zh = 2.633
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
				arg_91_0:Play410142023(arg_91_1)
			end
		end

		function arg_91_1.onSingleLineUpdate_(arg_94_0)
			local var_94_0 = arg_91_1.actors_["1061"].transform
			local var_94_1 = 0

			if var_94_1 < arg_91_1.time_ and arg_91_1.time_ <= var_94_1 + arg_94_0 then
				arg_91_1.var_.moveOldPos1061 = var_94_0.localPosition
				var_94_0.localScale = Vector3.New(1, 1, 1)

				arg_91_1:CheckSpriteTmpPos("1061", 3)

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
				local var_94_6 = Vector3.New(0, -490, 18)

				var_94_0.localPosition = Vector3.Lerp(arg_91_1.var_.moveOldPos1061, var_94_6, var_94_5)
			end

			if arg_91_1.time_ >= var_94_1 + var_94_4 and arg_91_1.time_ < var_94_1 + var_94_4 + arg_94_0 then
				var_94_0.localPosition = Vector3.New(0, -490, 18)
			end

			local var_94_7 = arg_91_1.actors_["1061"]
			local var_94_8 = 0

			if var_94_8 < arg_91_1.time_ and arg_91_1.time_ <= var_94_8 + arg_94_0 and not isNil(var_94_7) and arg_91_1.var_.actorSpriteComps1061 == nil then
				arg_91_1.var_.actorSpriteComps1061 = var_94_7:GetComponentsInChildren(typeof(Image), true)
			end

			local var_94_9 = 0.034

			if var_94_8 <= arg_91_1.time_ and arg_91_1.time_ < var_94_8 + var_94_9 and not isNil(var_94_7) then
				local var_94_10 = (arg_91_1.time_ - var_94_8) / var_94_9

				if arg_91_1.var_.actorSpriteComps1061 then
					for iter_94_1, iter_94_2 in pairs(arg_91_1.var_.actorSpriteComps1061:ToTable()) do
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

			if arg_91_1.time_ >= var_94_8 + var_94_9 and arg_91_1.time_ < var_94_8 + var_94_9 + arg_94_0 and not isNil(var_94_7) and arg_91_1.var_.actorSpriteComps1061 then
				for iter_94_3, iter_94_4 in pairs(arg_91_1.var_.actorSpriteComps1061:ToTable()) do
					if iter_94_4 then
						if arg_91_1.isInRecall_ then
							iter_94_4.color = arg_91_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_94_4.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_91_1.var_.actorSpriteComps1061 = nil
			end

			local var_94_15 = 0
			local var_94_16 = 0.225

			if var_94_15 < arg_91_1.time_ and arg_91_1.time_ <= var_94_15 + arg_94_0 then
				arg_91_1.talkMaxDuration = 0
				arg_91_1.dialogCg_.alpha = 1

				arg_91_1.dialog_:SetActive(true)
				SetActive(arg_91_1.leftNameGo_, true)

				local var_94_17 = arg_91_1:FormatText(StoryNameCfg[612].name)

				arg_91_1.leftNameTxt_.text = var_94_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_91_1.leftNameTxt_.transform)

				arg_91_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_91_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_91_1:RecordName(arg_91_1.leftNameTxt_.text)
				SetActive(arg_91_1.iconTrs_.gameObject, false)
				arg_91_1.callingController_:SetSelectedState("normal")

				local var_94_18 = arg_91_1:GetWordFromCfg(410142022)
				local var_94_19 = arg_91_1:FormatText(var_94_18.content)

				arg_91_1.text_.text = var_94_19

				LuaForUtil.ClearLinePrefixSymbol(arg_91_1.text_)

				local var_94_20 = 9
				local var_94_21 = utf8.len(var_94_19)
				local var_94_22 = var_94_20 <= 0 and var_94_16 or var_94_16 * (var_94_21 / var_94_20)

				if var_94_22 > 0 and var_94_16 < var_94_22 then
					arg_91_1.talkMaxDuration = var_94_22

					if var_94_22 + var_94_15 > arg_91_1.duration_ then
						arg_91_1.duration_ = var_94_22 + var_94_15
					end
				end

				arg_91_1.text_.text = var_94_19
				arg_91_1.typewritter.percent = 0

				arg_91_1.typewritter:SetDirty()
				arg_91_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_410142", "410142022", "story_v_out_410142.awb") ~= 0 then
					local var_94_23 = manager.audio:GetVoiceLength("story_v_out_410142", "410142022", "story_v_out_410142.awb") / 1000

					if var_94_23 + var_94_15 > arg_91_1.duration_ then
						arg_91_1.duration_ = var_94_23 + var_94_15
					end

					if var_94_18.prefab_name ~= "" and arg_91_1.actors_[var_94_18.prefab_name] ~= nil then
						local var_94_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_91_1.actors_[var_94_18.prefab_name].transform, "story_v_out_410142", "410142022", "story_v_out_410142.awb")

						arg_91_1:RecordAudio("410142022", var_94_24)
						arg_91_1:RecordAudio("410142022", var_94_24)
					else
						arg_91_1:AudioAction("play", "voice", "story_v_out_410142", "410142022", "story_v_out_410142.awb")
					end

					arg_91_1:RecordHistoryTalkVoice("story_v_out_410142", "410142022", "story_v_out_410142.awb")
				end

				arg_91_1:RecordContent(arg_91_1.text_.text)
			end

			local var_94_25 = math.max(var_94_16, arg_91_1.talkMaxDuration)

			if var_94_15 <= arg_91_1.time_ and arg_91_1.time_ < var_94_15 + var_94_25 then
				arg_91_1.typewritter.percent = (arg_91_1.time_ - var_94_15) / var_94_25

				arg_91_1.typewritter:SetDirty()
			end

			if arg_91_1.time_ >= var_94_15 + var_94_25 and arg_91_1.time_ < var_94_15 + var_94_25 + arg_94_0 then
				arg_91_1.typewritter.percent = 1

				arg_91_1.typewritter:SetDirty()
				arg_91_1:ShowNextGo(true)
			end
		end

		arg_91_1.nodeConfigList_ = {
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

		arg_91_1:InitPlayNodeList()
	end,
	Play410142023 = function(arg_95_0, arg_95_1)
		arg_95_1.time_ = 0
		arg_95_1.frameCnt_ = 0
		arg_95_1.state_ = "playing"
		arg_95_1.curTalkId_ = 410142023
		arg_95_1.duration_ = 8.83

		local var_95_0 = {
			ja = 8.833,
			CriLanguages = 6.8,
			zh = 6.8
		}
		local var_95_1 = manager.audio:GetLocalizationFlag()

		if var_95_0[var_95_1] ~= nil then
			arg_95_1.duration_ = var_95_0[var_95_1]
		end

		SetActive(arg_95_1.tipsGo_, false)

		function arg_95_1.onSingleLineFinish_()
			arg_95_1.onSingleLineUpdate_ = nil
			arg_95_1.onSingleLineFinish_ = nil
			arg_95_1.state_ = "waiting"
		end

		function arg_95_1.playNext_(arg_97_0)
			if arg_97_0 == 1 then
				arg_95_0:Play410142024(arg_95_1)
			end
		end

		function arg_95_1.onSingleLineUpdate_(arg_98_0)
			local var_98_0 = arg_95_1.actors_["1061"].transform
			local var_98_1 = 0

			if var_98_1 < arg_95_1.time_ and arg_95_1.time_ <= var_98_1 + arg_98_0 then
				arg_95_1.var_.moveOldPos1061 = var_98_0.localPosition
				var_98_0.localScale = Vector3.New(1, 1, 1)

				arg_95_1:CheckSpriteTmpPos("1061", 3)

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
				local var_98_6 = Vector3.New(0, -490, 18)

				var_98_0.localPosition = Vector3.Lerp(arg_95_1.var_.moveOldPos1061, var_98_6, var_98_5)
			end

			if arg_95_1.time_ >= var_98_1 + var_98_4 and arg_95_1.time_ < var_98_1 + var_98_4 + arg_98_0 then
				var_98_0.localPosition = Vector3.New(0, -490, 18)
			end

			local var_98_7 = arg_95_1.actors_["1061"]
			local var_98_8 = 0

			if var_98_8 < arg_95_1.time_ and arg_95_1.time_ <= var_98_8 + arg_98_0 and not isNil(var_98_7) and arg_95_1.var_.actorSpriteComps1061 == nil then
				arg_95_1.var_.actorSpriteComps1061 = var_98_7:GetComponentsInChildren(typeof(Image), true)
			end

			local var_98_9 = 0.034

			if var_98_8 <= arg_95_1.time_ and arg_95_1.time_ < var_98_8 + var_98_9 and not isNil(var_98_7) then
				local var_98_10 = (arg_95_1.time_ - var_98_8) / var_98_9

				if arg_95_1.var_.actorSpriteComps1061 then
					for iter_98_1, iter_98_2 in pairs(arg_95_1.var_.actorSpriteComps1061:ToTable()) do
						if iter_98_2 then
							if arg_95_1.isInRecall_ then
								local var_98_11 = Mathf.Lerp(iter_98_2.color.r, arg_95_1.hightColor1.r, var_98_10)
								local var_98_12 = Mathf.Lerp(iter_98_2.color.g, arg_95_1.hightColor1.g, var_98_10)
								local var_98_13 = Mathf.Lerp(iter_98_2.color.b, arg_95_1.hightColor1.b, var_98_10)

								iter_98_2.color = Color.New(var_98_11, var_98_12, var_98_13)
							else
								local var_98_14 = Mathf.Lerp(iter_98_2.color.r, 1, var_98_10)

								iter_98_2.color = Color.New(var_98_14, var_98_14, var_98_14)
							end
						end
					end
				end
			end

			if arg_95_1.time_ >= var_98_8 + var_98_9 and arg_95_1.time_ < var_98_8 + var_98_9 + arg_98_0 and not isNil(var_98_7) and arg_95_1.var_.actorSpriteComps1061 then
				for iter_98_3, iter_98_4 in pairs(arg_95_1.var_.actorSpriteComps1061:ToTable()) do
					if iter_98_4 then
						if arg_95_1.isInRecall_ then
							iter_98_4.color = arg_95_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_98_4.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_95_1.var_.actorSpriteComps1061 = nil
			end

			local var_98_15 = 0
			local var_98_16 = 0.825

			if var_98_15 < arg_95_1.time_ and arg_95_1.time_ <= var_98_15 + arg_98_0 then
				arg_95_1.talkMaxDuration = 0
				arg_95_1.dialogCg_.alpha = 1

				arg_95_1.dialog_:SetActive(true)
				SetActive(arg_95_1.leftNameGo_, true)

				local var_98_17 = arg_95_1:FormatText(StoryNameCfg[612].name)

				arg_95_1.leftNameTxt_.text = var_98_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_95_1.leftNameTxt_.transform)

				arg_95_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_95_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_95_1:RecordName(arg_95_1.leftNameTxt_.text)
				SetActive(arg_95_1.iconTrs_.gameObject, false)
				arg_95_1.callingController_:SetSelectedState("normal")

				local var_98_18 = arg_95_1:GetWordFromCfg(410142023)
				local var_98_19 = arg_95_1:FormatText(var_98_18.content)

				arg_95_1.text_.text = var_98_19

				LuaForUtil.ClearLinePrefixSymbol(arg_95_1.text_)

				local var_98_20 = 33
				local var_98_21 = utf8.len(var_98_19)
				local var_98_22 = var_98_20 <= 0 and var_98_16 or var_98_16 * (var_98_21 / var_98_20)

				if var_98_22 > 0 and var_98_16 < var_98_22 then
					arg_95_1.talkMaxDuration = var_98_22

					if var_98_22 + var_98_15 > arg_95_1.duration_ then
						arg_95_1.duration_ = var_98_22 + var_98_15
					end
				end

				arg_95_1.text_.text = var_98_19
				arg_95_1.typewritter.percent = 0

				arg_95_1.typewritter:SetDirty()
				arg_95_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_410142", "410142023", "story_v_out_410142.awb") ~= 0 then
					local var_98_23 = manager.audio:GetVoiceLength("story_v_out_410142", "410142023", "story_v_out_410142.awb") / 1000

					if var_98_23 + var_98_15 > arg_95_1.duration_ then
						arg_95_1.duration_ = var_98_23 + var_98_15
					end

					if var_98_18.prefab_name ~= "" and arg_95_1.actors_[var_98_18.prefab_name] ~= nil then
						local var_98_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_95_1.actors_[var_98_18.prefab_name].transform, "story_v_out_410142", "410142023", "story_v_out_410142.awb")

						arg_95_1:RecordAudio("410142023", var_98_24)
						arg_95_1:RecordAudio("410142023", var_98_24)
					else
						arg_95_1:AudioAction("play", "voice", "story_v_out_410142", "410142023", "story_v_out_410142.awb")
					end

					arg_95_1:RecordHistoryTalkVoice("story_v_out_410142", "410142023", "story_v_out_410142.awb")
				end

				arg_95_1:RecordContent(arg_95_1.text_.text)
			end

			local var_98_25 = math.max(var_98_16, arg_95_1.talkMaxDuration)

			if var_98_15 <= arg_95_1.time_ and arg_95_1.time_ < var_98_15 + var_98_25 then
				arg_95_1.typewritter.percent = (arg_95_1.time_ - var_98_15) / var_98_25

				arg_95_1.typewritter:SetDirty()
			end

			if arg_95_1.time_ >= var_98_15 + var_98_25 and arg_95_1.time_ < var_98_15 + var_98_25 + arg_98_0 then
				arg_95_1.typewritter.percent = 1

				arg_95_1.typewritter:SetDirty()
				arg_95_1:ShowNextGo(true)
			end
		end

		arg_95_1.nodeConfigList_ = {
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

		arg_95_1:InitPlayNodeList()
	end,
	Play410142024 = function(arg_99_0, arg_99_1)
		arg_99_1.time_ = 0
		arg_99_1.frameCnt_ = 0
		arg_99_1.state_ = "playing"
		arg_99_1.curTalkId_ = 410142024
		arg_99_1.duration_ = 1.97

		local var_99_0 = {
			ja = 0.999999999999,
			CriLanguages = 1.966,
			zh = 1.966
		}
		local var_99_1 = manager.audio:GetLocalizationFlag()

		if var_99_0[var_99_1] ~= nil then
			arg_99_1.duration_ = var_99_0[var_99_1]
		end

		SetActive(arg_99_1.tipsGo_, false)

		function arg_99_1.onSingleLineFinish_()
			arg_99_1.onSingleLineUpdate_ = nil
			arg_99_1.onSingleLineFinish_ = nil
			arg_99_1.state_ = "waiting"
		end

		function arg_99_1.playNext_(arg_101_0)
			if arg_101_0 == 1 then
				arg_99_0:Play410142025(arg_99_1)
			end
		end

		function arg_99_1.onSingleLineUpdate_(arg_102_0)
			local var_102_0 = arg_99_1.actors_["1061"]
			local var_102_1 = 0

			if var_102_1 < arg_99_1.time_ and arg_99_1.time_ <= var_102_1 + arg_102_0 and not isNil(var_102_0) and arg_99_1.var_.actorSpriteComps1061 == nil then
				arg_99_1.var_.actorSpriteComps1061 = var_102_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_102_2 = 0.034

			if var_102_1 <= arg_99_1.time_ and arg_99_1.time_ < var_102_1 + var_102_2 and not isNil(var_102_0) then
				local var_102_3 = (arg_99_1.time_ - var_102_1) / var_102_2

				if arg_99_1.var_.actorSpriteComps1061 then
					for iter_102_0, iter_102_1 in pairs(arg_99_1.var_.actorSpriteComps1061:ToTable()) do
						if iter_102_1 then
							if arg_99_1.isInRecall_ then
								local var_102_4 = Mathf.Lerp(iter_102_1.color.r, arg_99_1.hightColor2.r, var_102_3)
								local var_102_5 = Mathf.Lerp(iter_102_1.color.g, arg_99_1.hightColor2.g, var_102_3)
								local var_102_6 = Mathf.Lerp(iter_102_1.color.b, arg_99_1.hightColor2.b, var_102_3)

								iter_102_1.color = Color.New(var_102_4, var_102_5, var_102_6)
							else
								local var_102_7 = Mathf.Lerp(iter_102_1.color.r, 0.5, var_102_3)

								iter_102_1.color = Color.New(var_102_7, var_102_7, var_102_7)
							end
						end
					end
				end
			end

			if arg_99_1.time_ >= var_102_1 + var_102_2 and arg_99_1.time_ < var_102_1 + var_102_2 + arg_102_0 and not isNil(var_102_0) and arg_99_1.var_.actorSpriteComps1061 then
				for iter_102_2, iter_102_3 in pairs(arg_99_1.var_.actorSpriteComps1061:ToTable()) do
					if iter_102_3 then
						if arg_99_1.isInRecall_ then
							iter_102_3.color = arg_99_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_102_3.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_99_1.var_.actorSpriteComps1061 = nil
			end

			local var_102_8 = 0
			local var_102_9 = 0.075

			if var_102_8 < arg_99_1.time_ and arg_99_1.time_ <= var_102_8 + arg_102_0 then
				arg_99_1.talkMaxDuration = 0
				arg_99_1.dialogCg_.alpha = 1

				arg_99_1.dialog_:SetActive(true)
				SetActive(arg_99_1.leftNameGo_, true)

				local var_102_10 = arg_99_1:FormatText(StoryNameCfg[613].name)

				arg_99_1.leftNameTxt_.text = var_102_10

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_99_1.leftNameTxt_.transform)

				arg_99_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_99_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_99_1:RecordName(arg_99_1.leftNameTxt_.text)
				SetActive(arg_99_1.iconTrs_.gameObject, true)
				arg_99_1.iconController_:SetSelectedState("hero")

				arg_99_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_1020")

				arg_99_1.callingController_:SetSelectedState("normal")

				arg_99_1.keyicon_.color = Color.New(1, 1, 1)
				arg_99_1.icon_.color = Color.New(1, 1, 1)

				local var_102_11 = arg_99_1:GetWordFromCfg(410142024)
				local var_102_12 = arg_99_1:FormatText(var_102_11.content)

				arg_99_1.text_.text = var_102_12

				LuaForUtil.ClearLinePrefixSymbol(arg_99_1.text_)

				local var_102_13 = 3
				local var_102_14 = utf8.len(var_102_12)
				local var_102_15 = var_102_13 <= 0 and var_102_9 or var_102_9 * (var_102_14 / var_102_13)

				if var_102_15 > 0 and var_102_9 < var_102_15 then
					arg_99_1.talkMaxDuration = var_102_15

					if var_102_15 + var_102_8 > arg_99_1.duration_ then
						arg_99_1.duration_ = var_102_15 + var_102_8
					end
				end

				arg_99_1.text_.text = var_102_12
				arg_99_1.typewritter.percent = 0

				arg_99_1.typewritter:SetDirty()
				arg_99_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_410142", "410142024", "story_v_out_410142.awb") ~= 0 then
					local var_102_16 = manager.audio:GetVoiceLength("story_v_out_410142", "410142024", "story_v_out_410142.awb") / 1000

					if var_102_16 + var_102_8 > arg_99_1.duration_ then
						arg_99_1.duration_ = var_102_16 + var_102_8
					end

					if var_102_11.prefab_name ~= "" and arg_99_1.actors_[var_102_11.prefab_name] ~= nil then
						local var_102_17 = LuaForUtil.PlayVoiceWithCriLipsync(arg_99_1.actors_[var_102_11.prefab_name].transform, "story_v_out_410142", "410142024", "story_v_out_410142.awb")

						arg_99_1:RecordAudio("410142024", var_102_17)
						arg_99_1:RecordAudio("410142024", var_102_17)
					else
						arg_99_1:AudioAction("play", "voice", "story_v_out_410142", "410142024", "story_v_out_410142.awb")
					end

					arg_99_1:RecordHistoryTalkVoice("story_v_out_410142", "410142024", "story_v_out_410142.awb")
				end

				arg_99_1:RecordContent(arg_99_1.text_.text)
			end

			local var_102_18 = math.max(var_102_9, arg_99_1.talkMaxDuration)

			if var_102_8 <= arg_99_1.time_ and arg_99_1.time_ < var_102_8 + var_102_18 then
				arg_99_1.typewritter.percent = (arg_99_1.time_ - var_102_8) / var_102_18

				arg_99_1.typewritter:SetDirty()
			end

			if arg_99_1.time_ >= var_102_8 + var_102_18 and arg_99_1.time_ < var_102_8 + var_102_18 + arg_102_0 then
				arg_99_1.typewritter.percent = 1

				arg_99_1.typewritter:SetDirty()
				arg_99_1:ShowNextGo(true)
			end
		end

		arg_99_1.nodeConfigList_ = {}

		arg_99_1:InitPlayNodeList()
	end,
	Play410142025 = function(arg_103_0, arg_103_1)
		arg_103_1.time_ = 0
		arg_103_1.frameCnt_ = 0
		arg_103_1.state_ = "playing"
		arg_103_1.curTalkId_ = 410142025
		arg_103_1.duration_ = 5

		SetActive(arg_103_1.tipsGo_, false)

		function arg_103_1.onSingleLineFinish_()
			arg_103_1.onSingleLineUpdate_ = nil
			arg_103_1.onSingleLineFinish_ = nil
			arg_103_1.state_ = "waiting"
		end

		function arg_103_1.playNext_(arg_105_0)
			if arg_105_0 == 1 then
				arg_103_0:Play410142026(arg_103_1)
			end
		end

		function arg_103_1.onSingleLineUpdate_(arg_106_0)
			local var_106_0 = 0
			local var_106_1 = 1.075

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

				local var_106_2 = arg_103_1:GetWordFromCfg(410142025)
				local var_106_3 = arg_103_1:FormatText(var_106_2.content)

				arg_103_1.text_.text = var_106_3

				LuaForUtil.ClearLinePrefixSymbol(arg_103_1.text_)

				local var_106_4 = 43
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
	Play410142026 = function(arg_107_0, arg_107_1)
		arg_107_1.time_ = 0
		arg_107_1.frameCnt_ = 0
		arg_107_1.state_ = "playing"
		arg_107_1.curTalkId_ = 410142026
		arg_107_1.duration_ = 20.2

		local var_107_0 = {
			ja = 20.2,
			CriLanguages = 6.833,
			zh = 6.833
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
				arg_107_0:Play410142027(arg_107_1)
			end
		end

		function arg_107_1.onSingleLineUpdate_(arg_110_0)
			local var_110_0 = 0
			local var_110_1 = 0.725

			if var_110_0 < arg_107_1.time_ and arg_107_1.time_ <= var_110_0 + arg_110_0 then
				arg_107_1.talkMaxDuration = 0
				arg_107_1.dialogCg_.alpha = 1

				arg_107_1.dialog_:SetActive(true)
				SetActive(arg_107_1.leftNameGo_, true)

				local var_110_2 = arg_107_1:FormatText(StoryNameCfg[613].name)

				arg_107_1.leftNameTxt_.text = var_110_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_107_1.leftNameTxt_.transform)

				arg_107_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_107_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_107_1:RecordName(arg_107_1.leftNameTxt_.text)
				SetActive(arg_107_1.iconTrs_.gameObject, true)
				arg_107_1.iconController_:SetSelectedState("hero")

				arg_107_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_1020")

				arg_107_1.callingController_:SetSelectedState("normal")

				arg_107_1.keyicon_.color = Color.New(1, 1, 1)
				arg_107_1.icon_.color = Color.New(1, 1, 1)

				local var_110_3 = arg_107_1:GetWordFromCfg(410142026)
				local var_110_4 = arg_107_1:FormatText(var_110_3.content)

				arg_107_1.text_.text = var_110_4

				LuaForUtil.ClearLinePrefixSymbol(arg_107_1.text_)

				local var_110_5 = 29
				local var_110_6 = utf8.len(var_110_4)
				local var_110_7 = var_110_5 <= 0 and var_110_1 or var_110_1 * (var_110_6 / var_110_5)

				if var_110_7 > 0 and var_110_1 < var_110_7 then
					arg_107_1.talkMaxDuration = var_110_7

					if var_110_7 + var_110_0 > arg_107_1.duration_ then
						arg_107_1.duration_ = var_110_7 + var_110_0
					end
				end

				arg_107_1.text_.text = var_110_4
				arg_107_1.typewritter.percent = 0

				arg_107_1.typewritter:SetDirty()
				arg_107_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_410142", "410142026", "story_v_out_410142.awb") ~= 0 then
					local var_110_8 = manager.audio:GetVoiceLength("story_v_out_410142", "410142026", "story_v_out_410142.awb") / 1000

					if var_110_8 + var_110_0 > arg_107_1.duration_ then
						arg_107_1.duration_ = var_110_8 + var_110_0
					end

					if var_110_3.prefab_name ~= "" and arg_107_1.actors_[var_110_3.prefab_name] ~= nil then
						local var_110_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_107_1.actors_[var_110_3.prefab_name].transform, "story_v_out_410142", "410142026", "story_v_out_410142.awb")

						arg_107_1:RecordAudio("410142026", var_110_9)
						arg_107_1:RecordAudio("410142026", var_110_9)
					else
						arg_107_1:AudioAction("play", "voice", "story_v_out_410142", "410142026", "story_v_out_410142.awb")
					end

					arg_107_1:RecordHistoryTalkVoice("story_v_out_410142", "410142026", "story_v_out_410142.awb")
				end

				arg_107_1:RecordContent(arg_107_1.text_.text)
			end

			local var_110_10 = math.max(var_110_1, arg_107_1.talkMaxDuration)

			if var_110_0 <= arg_107_1.time_ and arg_107_1.time_ < var_110_0 + var_110_10 then
				arg_107_1.typewritter.percent = (arg_107_1.time_ - var_110_0) / var_110_10

				arg_107_1.typewritter:SetDirty()
			end

			if arg_107_1.time_ >= var_110_0 + var_110_10 and arg_107_1.time_ < var_110_0 + var_110_10 + arg_110_0 then
				arg_107_1.typewritter.percent = 1

				arg_107_1.typewritter:SetDirty()
				arg_107_1:ShowNextGo(true)
			end
		end

		arg_107_1.nodeConfigList_ = {}

		arg_107_1:InitPlayNodeList()
	end,
	Play410142027 = function(arg_111_0, arg_111_1)
		arg_111_1.time_ = 0
		arg_111_1.frameCnt_ = 0
		arg_111_1.state_ = "playing"
		arg_111_1.curTalkId_ = 410142027
		arg_111_1.duration_ = 6.57

		local var_111_0 = {
			ja = 6.566,
			CriLanguages = 4.6,
			zh = 4.6
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
				arg_111_0:Play410142028(arg_111_1)
			end
		end

		function arg_111_1.onSingleLineUpdate_(arg_114_0)
			local var_114_0 = arg_111_1.actors_["1061"].transform
			local var_114_1 = 0

			if var_114_1 < arg_111_1.time_ and arg_111_1.time_ <= var_114_1 + arg_114_0 then
				arg_111_1.var_.moveOldPos1061 = var_114_0.localPosition
				var_114_0.localScale = Vector3.New(1, 1, 1)

				arg_111_1:CheckSpriteTmpPos("1061", 3)

				local var_114_2 = var_114_0.childCount

				for iter_114_0 = 0, var_114_2 - 1 do
					local var_114_3 = var_114_0:GetChild(iter_114_0)

					if var_114_3.name == "split_5" or not string.find(var_114_3.name, "split") then
						var_114_3.gameObject:SetActive(true)
					else
						var_114_3.gameObject:SetActive(false)
					end
				end
			end

			local var_114_4 = 0.001

			if var_114_1 <= arg_111_1.time_ and arg_111_1.time_ < var_114_1 + var_114_4 then
				local var_114_5 = (arg_111_1.time_ - var_114_1) / var_114_4
				local var_114_6 = Vector3.New(0, -490, 18)

				var_114_0.localPosition = Vector3.Lerp(arg_111_1.var_.moveOldPos1061, var_114_6, var_114_5)
			end

			if arg_111_1.time_ >= var_114_1 + var_114_4 and arg_111_1.time_ < var_114_1 + var_114_4 + arg_114_0 then
				var_114_0.localPosition = Vector3.New(0, -490, 18)
			end

			local var_114_7 = arg_111_1.actors_["1061"]
			local var_114_8 = 0

			if var_114_8 < arg_111_1.time_ and arg_111_1.time_ <= var_114_8 + arg_114_0 and not isNil(var_114_7) and arg_111_1.var_.actorSpriteComps1061 == nil then
				arg_111_1.var_.actorSpriteComps1061 = var_114_7:GetComponentsInChildren(typeof(Image), true)
			end

			local var_114_9 = 0.034

			if var_114_8 <= arg_111_1.time_ and arg_111_1.time_ < var_114_8 + var_114_9 and not isNil(var_114_7) then
				local var_114_10 = (arg_111_1.time_ - var_114_8) / var_114_9

				if arg_111_1.var_.actorSpriteComps1061 then
					for iter_114_1, iter_114_2 in pairs(arg_111_1.var_.actorSpriteComps1061:ToTable()) do
						if iter_114_2 then
							if arg_111_1.isInRecall_ then
								local var_114_11 = Mathf.Lerp(iter_114_2.color.r, arg_111_1.hightColor1.r, var_114_10)
								local var_114_12 = Mathf.Lerp(iter_114_2.color.g, arg_111_1.hightColor1.g, var_114_10)
								local var_114_13 = Mathf.Lerp(iter_114_2.color.b, arg_111_1.hightColor1.b, var_114_10)

								iter_114_2.color = Color.New(var_114_11, var_114_12, var_114_13)
							else
								local var_114_14 = Mathf.Lerp(iter_114_2.color.r, 1, var_114_10)

								iter_114_2.color = Color.New(var_114_14, var_114_14, var_114_14)
							end
						end
					end
				end
			end

			if arg_111_1.time_ >= var_114_8 + var_114_9 and arg_111_1.time_ < var_114_8 + var_114_9 + arg_114_0 and not isNil(var_114_7) and arg_111_1.var_.actorSpriteComps1061 then
				for iter_114_3, iter_114_4 in pairs(arg_111_1.var_.actorSpriteComps1061:ToTable()) do
					if iter_114_4 then
						if arg_111_1.isInRecall_ then
							iter_114_4.color = arg_111_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_114_4.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_111_1.var_.actorSpriteComps1061 = nil
			end

			local var_114_15 = 0
			local var_114_16 = 0.425

			if var_114_15 < arg_111_1.time_ and arg_111_1.time_ <= var_114_15 + arg_114_0 then
				arg_111_1.talkMaxDuration = 0
				arg_111_1.dialogCg_.alpha = 1

				arg_111_1.dialog_:SetActive(true)
				SetActive(arg_111_1.leftNameGo_, true)

				local var_114_17 = arg_111_1:FormatText(StoryNameCfg[612].name)

				arg_111_1.leftNameTxt_.text = var_114_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_111_1.leftNameTxt_.transform)

				arg_111_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_111_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_111_1:RecordName(arg_111_1.leftNameTxt_.text)
				SetActive(arg_111_1.iconTrs_.gameObject, false)
				arg_111_1.callingController_:SetSelectedState("normal")

				local var_114_18 = arg_111_1:GetWordFromCfg(410142027)
				local var_114_19 = arg_111_1:FormatText(var_114_18.content)

				arg_111_1.text_.text = var_114_19

				LuaForUtil.ClearLinePrefixSymbol(arg_111_1.text_)

				local var_114_20 = 17
				local var_114_21 = utf8.len(var_114_19)
				local var_114_22 = var_114_20 <= 0 and var_114_16 or var_114_16 * (var_114_21 / var_114_20)

				if var_114_22 > 0 and var_114_16 < var_114_22 then
					arg_111_1.talkMaxDuration = var_114_22

					if var_114_22 + var_114_15 > arg_111_1.duration_ then
						arg_111_1.duration_ = var_114_22 + var_114_15
					end
				end

				arg_111_1.text_.text = var_114_19
				arg_111_1.typewritter.percent = 0

				arg_111_1.typewritter:SetDirty()
				arg_111_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_410142", "410142027", "story_v_out_410142.awb") ~= 0 then
					local var_114_23 = manager.audio:GetVoiceLength("story_v_out_410142", "410142027", "story_v_out_410142.awb") / 1000

					if var_114_23 + var_114_15 > arg_111_1.duration_ then
						arg_111_1.duration_ = var_114_23 + var_114_15
					end

					if var_114_18.prefab_name ~= "" and arg_111_1.actors_[var_114_18.prefab_name] ~= nil then
						local var_114_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_111_1.actors_[var_114_18.prefab_name].transform, "story_v_out_410142", "410142027", "story_v_out_410142.awb")

						arg_111_1:RecordAudio("410142027", var_114_24)
						arg_111_1:RecordAudio("410142027", var_114_24)
					else
						arg_111_1:AudioAction("play", "voice", "story_v_out_410142", "410142027", "story_v_out_410142.awb")
					end

					arg_111_1:RecordHistoryTalkVoice("story_v_out_410142", "410142027", "story_v_out_410142.awb")
				end

				arg_111_1:RecordContent(arg_111_1.text_.text)
			end

			local var_114_25 = math.max(var_114_16, arg_111_1.talkMaxDuration)

			if var_114_15 <= arg_111_1.time_ and arg_111_1.time_ < var_114_15 + var_114_25 then
				arg_111_1.typewritter.percent = (arg_111_1.time_ - var_114_15) / var_114_25

				arg_111_1.typewritter:SetDirty()
			end

			if arg_111_1.time_ >= var_114_15 + var_114_25 and arg_111_1.time_ < var_114_15 + var_114_25 + arg_114_0 then
				arg_111_1.typewritter.percent = 1

				arg_111_1.typewritter:SetDirty()
				arg_111_1:ShowNextGo(true)
			end
		end

		arg_111_1.nodeConfigList_ = {
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

		arg_111_1:InitPlayNodeList()
	end,
	Play410142028 = function(arg_115_0, arg_115_1)
		arg_115_1.time_ = 0
		arg_115_1.frameCnt_ = 0
		arg_115_1.state_ = "playing"
		arg_115_1.curTalkId_ = 410142028
		arg_115_1.duration_ = 4.07

		local var_115_0 = {
			ja = 4.066,
			CriLanguages = 1.733,
			zh = 1.733
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
				arg_115_0:Play410142029(arg_115_1)
			end
		end

		function arg_115_1.onSingleLineUpdate_(arg_118_0)
			local var_118_0 = arg_115_1.actors_["1061"]
			local var_118_1 = 0

			if var_118_1 < arg_115_1.time_ and arg_115_1.time_ <= var_118_1 + arg_118_0 and not isNil(var_118_0) and arg_115_1.var_.actorSpriteComps1061 == nil then
				arg_115_1.var_.actorSpriteComps1061 = var_118_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_118_2 = 0.034

			if var_118_1 <= arg_115_1.time_ and arg_115_1.time_ < var_118_1 + var_118_2 and not isNil(var_118_0) then
				local var_118_3 = (arg_115_1.time_ - var_118_1) / var_118_2

				if arg_115_1.var_.actorSpriteComps1061 then
					for iter_118_0, iter_118_1 in pairs(arg_115_1.var_.actorSpriteComps1061:ToTable()) do
						if iter_118_1 then
							if arg_115_1.isInRecall_ then
								local var_118_4 = Mathf.Lerp(iter_118_1.color.r, arg_115_1.hightColor2.r, var_118_3)
								local var_118_5 = Mathf.Lerp(iter_118_1.color.g, arg_115_1.hightColor2.g, var_118_3)
								local var_118_6 = Mathf.Lerp(iter_118_1.color.b, arg_115_1.hightColor2.b, var_118_3)

								iter_118_1.color = Color.New(var_118_4, var_118_5, var_118_6)
							else
								local var_118_7 = Mathf.Lerp(iter_118_1.color.r, 0.5, var_118_3)

								iter_118_1.color = Color.New(var_118_7, var_118_7, var_118_7)
							end
						end
					end
				end
			end

			if arg_115_1.time_ >= var_118_1 + var_118_2 and arg_115_1.time_ < var_118_1 + var_118_2 + arg_118_0 and not isNil(var_118_0) and arg_115_1.var_.actorSpriteComps1061 then
				for iter_118_2, iter_118_3 in pairs(arg_115_1.var_.actorSpriteComps1061:ToTable()) do
					if iter_118_3 then
						if arg_115_1.isInRecall_ then
							iter_118_3.color = arg_115_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_118_3.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_115_1.var_.actorSpriteComps1061 = nil
			end

			local var_118_8 = 0
			local var_118_9 = 0.075

			if var_118_8 < arg_115_1.time_ and arg_115_1.time_ <= var_118_8 + arg_118_0 then
				arg_115_1.talkMaxDuration = 0
				arg_115_1.dialogCg_.alpha = 1

				arg_115_1.dialog_:SetActive(true)
				SetActive(arg_115_1.leftNameGo_, true)

				local var_118_10 = arg_115_1:FormatText(StoryNameCfg[613].name)

				arg_115_1.leftNameTxt_.text = var_118_10

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_115_1.leftNameTxt_.transform)

				arg_115_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_115_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_115_1:RecordName(arg_115_1.leftNameTxt_.text)
				SetActive(arg_115_1.iconTrs_.gameObject, true)
				arg_115_1.iconController_:SetSelectedState("hero")

				arg_115_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_1020")

				arg_115_1.callingController_:SetSelectedState("normal")

				arg_115_1.keyicon_.color = Color.New(1, 1, 1)
				arg_115_1.icon_.color = Color.New(1, 1, 1)

				local var_118_11 = arg_115_1:GetWordFromCfg(410142028)
				local var_118_12 = arg_115_1:FormatText(var_118_11.content)

				arg_115_1.text_.text = var_118_12

				LuaForUtil.ClearLinePrefixSymbol(arg_115_1.text_)

				local var_118_13 = 3
				local var_118_14 = utf8.len(var_118_12)
				local var_118_15 = var_118_13 <= 0 and var_118_9 or var_118_9 * (var_118_14 / var_118_13)

				if var_118_15 > 0 and var_118_9 < var_118_15 then
					arg_115_1.talkMaxDuration = var_118_15

					if var_118_15 + var_118_8 > arg_115_1.duration_ then
						arg_115_1.duration_ = var_118_15 + var_118_8
					end
				end

				arg_115_1.text_.text = var_118_12
				arg_115_1.typewritter.percent = 0

				arg_115_1.typewritter:SetDirty()
				arg_115_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_410142", "410142028", "story_v_out_410142.awb") ~= 0 then
					local var_118_16 = manager.audio:GetVoiceLength("story_v_out_410142", "410142028", "story_v_out_410142.awb") / 1000

					if var_118_16 + var_118_8 > arg_115_1.duration_ then
						arg_115_1.duration_ = var_118_16 + var_118_8
					end

					if var_118_11.prefab_name ~= "" and arg_115_1.actors_[var_118_11.prefab_name] ~= nil then
						local var_118_17 = LuaForUtil.PlayVoiceWithCriLipsync(arg_115_1.actors_[var_118_11.prefab_name].transform, "story_v_out_410142", "410142028", "story_v_out_410142.awb")

						arg_115_1:RecordAudio("410142028", var_118_17)
						arg_115_1:RecordAudio("410142028", var_118_17)
					else
						arg_115_1:AudioAction("play", "voice", "story_v_out_410142", "410142028", "story_v_out_410142.awb")
					end

					arg_115_1:RecordHistoryTalkVoice("story_v_out_410142", "410142028", "story_v_out_410142.awb")
				end

				arg_115_1:RecordContent(arg_115_1.text_.text)
			end

			local var_118_18 = math.max(var_118_9, arg_115_1.talkMaxDuration)

			if var_118_8 <= arg_115_1.time_ and arg_115_1.time_ < var_118_8 + var_118_18 then
				arg_115_1.typewritter.percent = (arg_115_1.time_ - var_118_8) / var_118_18

				arg_115_1.typewritter:SetDirty()
			end

			if arg_115_1.time_ >= var_118_8 + var_118_18 and arg_115_1.time_ < var_118_8 + var_118_18 + arg_118_0 then
				arg_115_1.typewritter.percent = 1

				arg_115_1.typewritter:SetDirty()
				arg_115_1:ShowNextGo(true)
			end
		end

		arg_115_1.nodeConfigList_ = {}

		arg_115_1:InitPlayNodeList()
	end,
	Play410142029 = function(arg_119_0, arg_119_1)
		arg_119_1.time_ = 0
		arg_119_1.frameCnt_ = 0
		arg_119_1.state_ = "playing"
		arg_119_1.curTalkId_ = 410142029
		arg_119_1.duration_ = 10.63

		local var_119_0 = {
			ja = 10.633,
			CriLanguages = 5.166,
			zh = 5.166
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
				arg_119_0:Play410142030(arg_119_1)
			end
		end

		function arg_119_1.onSingleLineUpdate_(arg_122_0)
			local var_122_0 = arg_119_1.actors_["1061"].transform
			local var_122_1 = 0

			if var_122_1 < arg_119_1.time_ and arg_119_1.time_ <= var_122_1 + arg_122_0 then
				arg_119_1.var_.moveOldPos1061 = var_122_0.localPosition
				var_122_0.localScale = Vector3.New(1, 1, 1)

				arg_119_1:CheckSpriteTmpPos("1061", 3)

				local var_122_2 = var_122_0.childCount

				for iter_122_0 = 0, var_122_2 - 1 do
					local var_122_3 = var_122_0:GetChild(iter_122_0)

					if var_122_3.name == "" or not string.find(var_122_3.name, "split") then
						var_122_3.gameObject:SetActive(true)
					else
						var_122_3.gameObject:SetActive(false)
					end
				end
			end

			local var_122_4 = 0.001

			if var_122_1 <= arg_119_1.time_ and arg_119_1.time_ < var_122_1 + var_122_4 then
				local var_122_5 = (arg_119_1.time_ - var_122_1) / var_122_4
				local var_122_6 = Vector3.New(0, -490, 18)

				var_122_0.localPosition = Vector3.Lerp(arg_119_1.var_.moveOldPos1061, var_122_6, var_122_5)
			end

			if arg_119_1.time_ >= var_122_1 + var_122_4 and arg_119_1.time_ < var_122_1 + var_122_4 + arg_122_0 then
				var_122_0.localPosition = Vector3.New(0, -490, 18)
			end

			local var_122_7 = arg_119_1.actors_["1061"]
			local var_122_8 = 0

			if var_122_8 < arg_119_1.time_ and arg_119_1.time_ <= var_122_8 + arg_122_0 and not isNil(var_122_7) and arg_119_1.var_.actorSpriteComps1061 == nil then
				arg_119_1.var_.actorSpriteComps1061 = var_122_7:GetComponentsInChildren(typeof(Image), true)
			end

			local var_122_9 = 0.034

			if var_122_8 <= arg_119_1.time_ and arg_119_1.time_ < var_122_8 + var_122_9 and not isNil(var_122_7) then
				local var_122_10 = (arg_119_1.time_ - var_122_8) / var_122_9

				if arg_119_1.var_.actorSpriteComps1061 then
					for iter_122_1, iter_122_2 in pairs(arg_119_1.var_.actorSpriteComps1061:ToTable()) do
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

			if arg_119_1.time_ >= var_122_8 + var_122_9 and arg_119_1.time_ < var_122_8 + var_122_9 + arg_122_0 and not isNil(var_122_7) and arg_119_1.var_.actorSpriteComps1061 then
				for iter_122_3, iter_122_4 in pairs(arg_119_1.var_.actorSpriteComps1061:ToTable()) do
					if iter_122_4 then
						if arg_119_1.isInRecall_ then
							iter_122_4.color = arg_119_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_122_4.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_119_1.var_.actorSpriteComps1061 = nil
			end

			local var_122_15 = 0
			local var_122_16 = 0.45

			if var_122_15 < arg_119_1.time_ and arg_119_1.time_ <= var_122_15 + arg_122_0 then
				arg_119_1.talkMaxDuration = 0
				arg_119_1.dialogCg_.alpha = 1

				arg_119_1.dialog_:SetActive(true)
				SetActive(arg_119_1.leftNameGo_, true)

				local var_122_17 = arg_119_1:FormatText(StoryNameCfg[612].name)

				arg_119_1.leftNameTxt_.text = var_122_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_119_1.leftNameTxt_.transform)

				arg_119_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_119_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_119_1:RecordName(arg_119_1.leftNameTxt_.text)
				SetActive(arg_119_1.iconTrs_.gameObject, false)
				arg_119_1.callingController_:SetSelectedState("normal")

				local var_122_18 = arg_119_1:GetWordFromCfg(410142029)
				local var_122_19 = arg_119_1:FormatText(var_122_18.content)

				arg_119_1.text_.text = var_122_19

				LuaForUtil.ClearLinePrefixSymbol(arg_119_1.text_)

				local var_122_20 = 18
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

				if manager.audio:GetVoiceLength("story_v_out_410142", "410142029", "story_v_out_410142.awb") ~= 0 then
					local var_122_23 = manager.audio:GetVoiceLength("story_v_out_410142", "410142029", "story_v_out_410142.awb") / 1000

					if var_122_23 + var_122_15 > arg_119_1.duration_ then
						arg_119_1.duration_ = var_122_23 + var_122_15
					end

					if var_122_18.prefab_name ~= "" and arg_119_1.actors_[var_122_18.prefab_name] ~= nil then
						local var_122_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_119_1.actors_[var_122_18.prefab_name].transform, "story_v_out_410142", "410142029", "story_v_out_410142.awb")

						arg_119_1:RecordAudio("410142029", var_122_24)
						arg_119_1:RecordAudio("410142029", var_122_24)
					else
						arg_119_1:AudioAction("play", "voice", "story_v_out_410142", "410142029", "story_v_out_410142.awb")
					end

					arg_119_1:RecordHistoryTalkVoice("story_v_out_410142", "410142029", "story_v_out_410142.awb")
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
				actorName = "1061",
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
	Play410142030 = function(arg_123_0, arg_123_1)
		arg_123_1.time_ = 0
		arg_123_1.frameCnt_ = 0
		arg_123_1.state_ = "playing"
		arg_123_1.curTalkId_ = 410142030
		arg_123_1.duration_ = 5

		SetActive(arg_123_1.tipsGo_, false)

		function arg_123_1.onSingleLineFinish_()
			arg_123_1.onSingleLineUpdate_ = nil
			arg_123_1.onSingleLineFinish_ = nil
			arg_123_1.state_ = "waiting"
		end

		function arg_123_1.playNext_(arg_125_0)
			if arg_125_0 == 1 then
				arg_123_0:Play410142031(arg_123_1)
			end
		end

		function arg_123_1.onSingleLineUpdate_(arg_126_0)
			local var_126_0 = arg_123_1.actors_["1061"]
			local var_126_1 = 0

			if var_126_1 < arg_123_1.time_ and arg_123_1.time_ <= var_126_1 + arg_126_0 and not isNil(var_126_0) and arg_123_1.var_.actorSpriteComps1061 == nil then
				arg_123_1.var_.actorSpriteComps1061 = var_126_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_126_2 = 0.034

			if var_126_1 <= arg_123_1.time_ and arg_123_1.time_ < var_126_1 + var_126_2 and not isNil(var_126_0) then
				local var_126_3 = (arg_123_1.time_ - var_126_1) / var_126_2

				if arg_123_1.var_.actorSpriteComps1061 then
					for iter_126_0, iter_126_1 in pairs(arg_123_1.var_.actorSpriteComps1061:ToTable()) do
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

			if arg_123_1.time_ >= var_126_1 + var_126_2 and arg_123_1.time_ < var_126_1 + var_126_2 + arg_126_0 and not isNil(var_126_0) and arg_123_1.var_.actorSpriteComps1061 then
				for iter_126_2, iter_126_3 in pairs(arg_123_1.var_.actorSpriteComps1061:ToTable()) do
					if iter_126_3 then
						if arg_123_1.isInRecall_ then
							iter_126_3.color = arg_123_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_126_3.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_123_1.var_.actorSpriteComps1061 = nil
			end

			local var_126_8 = 0
			local var_126_9 = 1.025

			if var_126_8 < arg_123_1.time_ and arg_123_1.time_ <= var_126_8 + arg_126_0 then
				arg_123_1.talkMaxDuration = 0
				arg_123_1.dialogCg_.alpha = 1

				arg_123_1.dialog_:SetActive(true)
				SetActive(arg_123_1.leftNameGo_, false)

				arg_123_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_123_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_123_1:RecordName(arg_123_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_123_1.iconTrs_.gameObject, false)
				arg_123_1.callingController_:SetSelectedState("normal")

				local var_126_10 = arg_123_1:GetWordFromCfg(410142030)
				local var_126_11 = arg_123_1:FormatText(var_126_10.content)

				arg_123_1.text_.text = var_126_11

				LuaForUtil.ClearLinePrefixSymbol(arg_123_1.text_)

				local var_126_12 = 41
				local var_126_13 = utf8.len(var_126_11)
				local var_126_14 = var_126_12 <= 0 and var_126_9 or var_126_9 * (var_126_13 / var_126_12)

				if var_126_14 > 0 and var_126_9 < var_126_14 then
					arg_123_1.talkMaxDuration = var_126_14

					if var_126_14 + var_126_8 > arg_123_1.duration_ then
						arg_123_1.duration_ = var_126_14 + var_126_8
					end
				end

				arg_123_1.text_.text = var_126_11
				arg_123_1.typewritter.percent = 0

				arg_123_1.typewritter:SetDirty()
				arg_123_1:ShowNextGo(false)
				arg_123_1:RecordContent(arg_123_1.text_.text)
			end

			local var_126_15 = math.max(var_126_9, arg_123_1.talkMaxDuration)

			if var_126_8 <= arg_123_1.time_ and arg_123_1.time_ < var_126_8 + var_126_15 then
				arg_123_1.typewritter.percent = (arg_123_1.time_ - var_126_8) / var_126_15

				arg_123_1.typewritter:SetDirty()
			end

			if arg_123_1.time_ >= var_126_8 + var_126_15 and arg_123_1.time_ < var_126_8 + var_126_15 + arg_126_0 then
				arg_123_1.typewritter.percent = 1

				arg_123_1.typewritter:SetDirty()
				arg_123_1:ShowNextGo(true)
			end
		end

		arg_123_1.nodeConfigList_ = {}

		arg_123_1:InitPlayNodeList()
	end,
	Play410142031 = function(arg_127_0, arg_127_1)
		arg_127_1.time_ = 0
		arg_127_1.frameCnt_ = 0
		arg_127_1.state_ = "playing"
		arg_127_1.curTalkId_ = 410142031
		arg_127_1.duration_ = 9.83

		local var_127_0 = {
			ja = 9.833,
			CriLanguages = 3.366,
			zh = 3.366
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
				arg_127_0:Play410142032(arg_127_1)
			end
		end

		function arg_127_1.onSingleLineUpdate_(arg_130_0)
			local var_130_0 = arg_127_1.actors_["1061"].transform
			local var_130_1 = 0

			if var_130_1 < arg_127_1.time_ and arg_127_1.time_ <= var_130_1 + arg_130_0 then
				arg_127_1.var_.moveOldPos1061 = var_130_0.localPosition
				var_130_0.localScale = Vector3.New(1, 1, 1)

				arg_127_1:CheckSpriteTmpPos("1061", 3)

				local var_130_2 = var_130_0.childCount

				for iter_130_0 = 0, var_130_2 - 1 do
					local var_130_3 = var_130_0:GetChild(iter_130_0)

					if var_130_3.name == "split_7" or not string.find(var_130_3.name, "split") then
						var_130_3.gameObject:SetActive(true)
					else
						var_130_3.gameObject:SetActive(false)
					end
				end
			end

			local var_130_4 = 0.001

			if var_130_1 <= arg_127_1.time_ and arg_127_1.time_ < var_130_1 + var_130_4 then
				local var_130_5 = (arg_127_1.time_ - var_130_1) / var_130_4
				local var_130_6 = Vector3.New(0, -490, 18)

				var_130_0.localPosition = Vector3.Lerp(arg_127_1.var_.moveOldPos1061, var_130_6, var_130_5)
			end

			if arg_127_1.time_ >= var_130_1 + var_130_4 and arg_127_1.time_ < var_130_1 + var_130_4 + arg_130_0 then
				var_130_0.localPosition = Vector3.New(0, -490, 18)
			end

			local var_130_7 = arg_127_1.actors_["1061"]
			local var_130_8 = 0

			if var_130_8 < arg_127_1.time_ and arg_127_1.time_ <= var_130_8 + arg_130_0 and not isNil(var_130_7) and arg_127_1.var_.actorSpriteComps1061 == nil then
				arg_127_1.var_.actorSpriteComps1061 = var_130_7:GetComponentsInChildren(typeof(Image), true)
			end

			local var_130_9 = 0.034

			if var_130_8 <= arg_127_1.time_ and arg_127_1.time_ < var_130_8 + var_130_9 and not isNil(var_130_7) then
				local var_130_10 = (arg_127_1.time_ - var_130_8) / var_130_9

				if arg_127_1.var_.actorSpriteComps1061 then
					for iter_130_1, iter_130_2 in pairs(arg_127_1.var_.actorSpriteComps1061:ToTable()) do
						if iter_130_2 then
							if arg_127_1.isInRecall_ then
								local var_130_11 = Mathf.Lerp(iter_130_2.color.r, arg_127_1.hightColor1.r, var_130_10)
								local var_130_12 = Mathf.Lerp(iter_130_2.color.g, arg_127_1.hightColor1.g, var_130_10)
								local var_130_13 = Mathf.Lerp(iter_130_2.color.b, arg_127_1.hightColor1.b, var_130_10)

								iter_130_2.color = Color.New(var_130_11, var_130_12, var_130_13)
							else
								local var_130_14 = Mathf.Lerp(iter_130_2.color.r, 1, var_130_10)

								iter_130_2.color = Color.New(var_130_14, var_130_14, var_130_14)
							end
						end
					end
				end
			end

			if arg_127_1.time_ >= var_130_8 + var_130_9 and arg_127_1.time_ < var_130_8 + var_130_9 + arg_130_0 and not isNil(var_130_7) and arg_127_1.var_.actorSpriteComps1061 then
				for iter_130_3, iter_130_4 in pairs(arg_127_1.var_.actorSpriteComps1061:ToTable()) do
					if iter_130_4 then
						if arg_127_1.isInRecall_ then
							iter_130_4.color = arg_127_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_130_4.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_127_1.var_.actorSpriteComps1061 = nil
			end

			local var_130_15 = 0
			local var_130_16 = 0.275

			if var_130_15 < arg_127_1.time_ and arg_127_1.time_ <= var_130_15 + arg_130_0 then
				arg_127_1.talkMaxDuration = 0
				arg_127_1.dialogCg_.alpha = 1

				arg_127_1.dialog_:SetActive(true)
				SetActive(arg_127_1.leftNameGo_, true)

				local var_130_17 = arg_127_1:FormatText(StoryNameCfg[612].name)

				arg_127_1.leftNameTxt_.text = var_130_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_127_1.leftNameTxt_.transform)

				arg_127_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_127_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_127_1:RecordName(arg_127_1.leftNameTxt_.text)
				SetActive(arg_127_1.iconTrs_.gameObject, false)
				arg_127_1.callingController_:SetSelectedState("normal")

				local var_130_18 = arg_127_1:GetWordFromCfg(410142031)
				local var_130_19 = arg_127_1:FormatText(var_130_18.content)

				arg_127_1.text_.text = var_130_19

				LuaForUtil.ClearLinePrefixSymbol(arg_127_1.text_)

				local var_130_20 = 11
				local var_130_21 = utf8.len(var_130_19)
				local var_130_22 = var_130_20 <= 0 and var_130_16 or var_130_16 * (var_130_21 / var_130_20)

				if var_130_22 > 0 and var_130_16 < var_130_22 then
					arg_127_1.talkMaxDuration = var_130_22

					if var_130_22 + var_130_15 > arg_127_1.duration_ then
						arg_127_1.duration_ = var_130_22 + var_130_15
					end
				end

				arg_127_1.text_.text = var_130_19
				arg_127_1.typewritter.percent = 0

				arg_127_1.typewritter:SetDirty()
				arg_127_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_410142", "410142031", "story_v_out_410142.awb") ~= 0 then
					local var_130_23 = manager.audio:GetVoiceLength("story_v_out_410142", "410142031", "story_v_out_410142.awb") / 1000

					if var_130_23 + var_130_15 > arg_127_1.duration_ then
						arg_127_1.duration_ = var_130_23 + var_130_15
					end

					if var_130_18.prefab_name ~= "" and arg_127_1.actors_[var_130_18.prefab_name] ~= nil then
						local var_130_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_127_1.actors_[var_130_18.prefab_name].transform, "story_v_out_410142", "410142031", "story_v_out_410142.awb")

						arg_127_1:RecordAudio("410142031", var_130_24)
						arg_127_1:RecordAudio("410142031", var_130_24)
					else
						arg_127_1:AudioAction("play", "voice", "story_v_out_410142", "410142031", "story_v_out_410142.awb")
					end

					arg_127_1:RecordHistoryTalkVoice("story_v_out_410142", "410142031", "story_v_out_410142.awb")
				end

				arg_127_1:RecordContent(arg_127_1.text_.text)
			end

			local var_130_25 = math.max(var_130_16, arg_127_1.talkMaxDuration)

			if var_130_15 <= arg_127_1.time_ and arg_127_1.time_ < var_130_15 + var_130_25 then
				arg_127_1.typewritter.percent = (arg_127_1.time_ - var_130_15) / var_130_25

				arg_127_1.typewritter:SetDirty()
			end

			if arg_127_1.time_ >= var_130_15 + var_130_25 and arg_127_1.time_ < var_130_15 + var_130_25 + arg_130_0 then
				arg_127_1.typewritter.percent = 1

				arg_127_1.typewritter:SetDirty()
				arg_127_1:ShowNextGo(true)
			end
		end

		arg_127_1.nodeConfigList_ = {
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

		arg_127_1:InitPlayNodeList()
	end,
	Play410142032 = function(arg_131_0, arg_131_1)
		arg_131_1.time_ = 0
		arg_131_1.frameCnt_ = 0
		arg_131_1.state_ = "playing"
		arg_131_1.curTalkId_ = 410142032
		arg_131_1.duration_ = 14.47

		local var_131_0 = {
			ja = 14.466,
			CriLanguages = 5.8,
			zh = 5.8
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
				arg_131_0:Play410142033(arg_131_1)
			end
		end

		function arg_131_1.onSingleLineUpdate_(arg_134_0)
			local var_134_0 = arg_131_1.actors_["1061"].transform
			local var_134_1 = 0

			if var_134_1 < arg_131_1.time_ and arg_131_1.time_ <= var_134_1 + arg_134_0 then
				arg_131_1.var_.moveOldPos1061 = var_134_0.localPosition
				var_134_0.localScale = Vector3.New(1, 1, 1)

				arg_131_1:CheckSpriteTmpPos("1061", 3)

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
				local var_134_6 = Vector3.New(0, -490, 18)

				var_134_0.localPosition = Vector3.Lerp(arg_131_1.var_.moveOldPos1061, var_134_6, var_134_5)
			end

			if arg_131_1.time_ >= var_134_1 + var_134_4 and arg_131_1.time_ < var_134_1 + var_134_4 + arg_134_0 then
				var_134_0.localPosition = Vector3.New(0, -490, 18)
			end

			local var_134_7 = arg_131_1.actors_["1061"]
			local var_134_8 = 0

			if var_134_8 < arg_131_1.time_ and arg_131_1.time_ <= var_134_8 + arg_134_0 and not isNil(var_134_7) and arg_131_1.var_.actorSpriteComps1061 == nil then
				arg_131_1.var_.actorSpriteComps1061 = var_134_7:GetComponentsInChildren(typeof(Image), true)
			end

			local var_134_9 = 0.034

			if var_134_8 <= arg_131_1.time_ and arg_131_1.time_ < var_134_8 + var_134_9 and not isNil(var_134_7) then
				local var_134_10 = (arg_131_1.time_ - var_134_8) / var_134_9

				if arg_131_1.var_.actorSpriteComps1061 then
					for iter_134_1, iter_134_2 in pairs(arg_131_1.var_.actorSpriteComps1061:ToTable()) do
						if iter_134_2 then
							if arg_131_1.isInRecall_ then
								local var_134_11 = Mathf.Lerp(iter_134_2.color.r, arg_131_1.hightColor2.r, var_134_10)
								local var_134_12 = Mathf.Lerp(iter_134_2.color.g, arg_131_1.hightColor2.g, var_134_10)
								local var_134_13 = Mathf.Lerp(iter_134_2.color.b, arg_131_1.hightColor2.b, var_134_10)

								iter_134_2.color = Color.New(var_134_11, var_134_12, var_134_13)
							else
								local var_134_14 = Mathf.Lerp(iter_134_2.color.r, 0.5, var_134_10)

								iter_134_2.color = Color.New(var_134_14, var_134_14, var_134_14)
							end
						end
					end
				end
			end

			if arg_131_1.time_ >= var_134_8 + var_134_9 and arg_131_1.time_ < var_134_8 + var_134_9 + arg_134_0 and not isNil(var_134_7) and arg_131_1.var_.actorSpriteComps1061 then
				for iter_134_3, iter_134_4 in pairs(arg_131_1.var_.actorSpriteComps1061:ToTable()) do
					if iter_134_4 then
						if arg_131_1.isInRecall_ then
							iter_134_4.color = arg_131_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_134_4.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_131_1.var_.actorSpriteComps1061 = nil
			end

			local var_134_15 = 0
			local var_134_16 = 0.575

			if var_134_15 < arg_131_1.time_ and arg_131_1.time_ <= var_134_15 + arg_134_0 then
				arg_131_1.talkMaxDuration = 0
				arg_131_1.dialogCg_.alpha = 1

				arg_131_1.dialog_:SetActive(true)
				SetActive(arg_131_1.leftNameGo_, true)

				local var_134_17 = arg_131_1:FormatText(StoryNameCfg[613].name)

				arg_131_1.leftNameTxt_.text = var_134_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_131_1.leftNameTxt_.transform)

				arg_131_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_131_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_131_1:RecordName(arg_131_1.leftNameTxt_.text)
				SetActive(arg_131_1.iconTrs_.gameObject, true)
				arg_131_1.iconController_:SetSelectedState("hero")

				arg_131_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_1020")

				arg_131_1.callingController_:SetSelectedState("normal")

				arg_131_1.keyicon_.color = Color.New(1, 1, 1)
				arg_131_1.icon_.color = Color.New(1, 1, 1)

				local var_134_18 = arg_131_1:GetWordFromCfg(410142032)
				local var_134_19 = arg_131_1:FormatText(var_134_18.content)

				arg_131_1.text_.text = var_134_19

				LuaForUtil.ClearLinePrefixSymbol(arg_131_1.text_)

				local var_134_20 = 23
				local var_134_21 = utf8.len(var_134_19)
				local var_134_22 = var_134_20 <= 0 and var_134_16 or var_134_16 * (var_134_21 / var_134_20)

				if var_134_22 > 0 and var_134_16 < var_134_22 then
					arg_131_1.talkMaxDuration = var_134_22

					if var_134_22 + var_134_15 > arg_131_1.duration_ then
						arg_131_1.duration_ = var_134_22 + var_134_15
					end
				end

				arg_131_1.text_.text = var_134_19
				arg_131_1.typewritter.percent = 0

				arg_131_1.typewritter:SetDirty()
				arg_131_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_410142", "410142032", "story_v_out_410142.awb") ~= 0 then
					local var_134_23 = manager.audio:GetVoiceLength("story_v_out_410142", "410142032", "story_v_out_410142.awb") / 1000

					if var_134_23 + var_134_15 > arg_131_1.duration_ then
						arg_131_1.duration_ = var_134_23 + var_134_15
					end

					if var_134_18.prefab_name ~= "" and arg_131_1.actors_[var_134_18.prefab_name] ~= nil then
						local var_134_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_131_1.actors_[var_134_18.prefab_name].transform, "story_v_out_410142", "410142032", "story_v_out_410142.awb")

						arg_131_1:RecordAudio("410142032", var_134_24)
						arg_131_1:RecordAudio("410142032", var_134_24)
					else
						arg_131_1:AudioAction("play", "voice", "story_v_out_410142", "410142032", "story_v_out_410142.awb")
					end

					arg_131_1:RecordHistoryTalkVoice("story_v_out_410142", "410142032", "story_v_out_410142.awb")
				end

				arg_131_1:RecordContent(arg_131_1.text_.text)
			end

			local var_134_25 = math.max(var_134_16, arg_131_1.talkMaxDuration)

			if var_134_15 <= arg_131_1.time_ and arg_131_1.time_ < var_134_15 + var_134_25 then
				arg_131_1.typewritter.percent = (arg_131_1.time_ - var_134_15) / var_134_25

				arg_131_1.typewritter:SetDirty()
			end

			if arg_131_1.time_ >= var_134_15 + var_134_25 and arg_131_1.time_ < var_134_15 + var_134_25 + arg_134_0 then
				arg_131_1.typewritter.percent = 1

				arg_131_1.typewritter:SetDirty()
				arg_131_1:ShowNextGo(true)
			end
		end

		arg_131_1.nodeConfigList_ = {
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

		arg_131_1:InitPlayNodeList()
	end,
	Play410142033 = function(arg_135_0, arg_135_1)
		arg_135_1.time_ = 0
		arg_135_1.frameCnt_ = 0
		arg_135_1.state_ = "playing"
		arg_135_1.curTalkId_ = 410142033
		arg_135_1.duration_ = 12.6

		local var_135_0 = {
			ja = 12.6,
			CriLanguages = 11.6,
			zh = 11.6
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
				arg_135_0:Play410142034(arg_135_1)
			end
		end

		function arg_135_1.onSingleLineUpdate_(arg_138_0)
			local var_138_0 = arg_135_1.actors_["1061"].transform
			local var_138_1 = 0

			if var_138_1 < arg_135_1.time_ and arg_135_1.time_ <= var_138_1 + arg_138_0 then
				arg_135_1.var_.moveOldPos1061 = var_138_0.localPosition
				var_138_0.localScale = Vector3.New(1, 1, 1)

				arg_135_1:CheckSpriteTmpPos("1061", 3)

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
				local var_138_6 = Vector3.New(0, -490, 18)

				var_138_0.localPosition = Vector3.Lerp(arg_135_1.var_.moveOldPos1061, var_138_6, var_138_5)
			end

			if arg_135_1.time_ >= var_138_1 + var_138_4 and arg_135_1.time_ < var_138_1 + var_138_4 + arg_138_0 then
				var_138_0.localPosition = Vector3.New(0, -490, 18)
			end

			local var_138_7 = arg_135_1.actors_["1061"]
			local var_138_8 = 0

			if var_138_8 < arg_135_1.time_ and arg_135_1.time_ <= var_138_8 + arg_138_0 and not isNil(var_138_7) and arg_135_1.var_.actorSpriteComps1061 == nil then
				arg_135_1.var_.actorSpriteComps1061 = var_138_7:GetComponentsInChildren(typeof(Image), true)
			end

			local var_138_9 = 0.034

			if var_138_8 <= arg_135_1.time_ and arg_135_1.time_ < var_138_8 + var_138_9 and not isNil(var_138_7) then
				local var_138_10 = (arg_135_1.time_ - var_138_8) / var_138_9

				if arg_135_1.var_.actorSpriteComps1061 then
					for iter_138_1, iter_138_2 in pairs(arg_135_1.var_.actorSpriteComps1061:ToTable()) do
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

			if arg_135_1.time_ >= var_138_8 + var_138_9 and arg_135_1.time_ < var_138_8 + var_138_9 + arg_138_0 and not isNil(var_138_7) and arg_135_1.var_.actorSpriteComps1061 then
				for iter_138_3, iter_138_4 in pairs(arg_135_1.var_.actorSpriteComps1061:ToTable()) do
					if iter_138_4 then
						if arg_135_1.isInRecall_ then
							iter_138_4.color = arg_135_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_138_4.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_135_1.var_.actorSpriteComps1061 = nil
			end

			local var_138_15 = 0
			local var_138_16 = 1.35

			if var_138_15 < arg_135_1.time_ and arg_135_1.time_ <= var_138_15 + arg_138_0 then
				arg_135_1.talkMaxDuration = 0
				arg_135_1.dialogCg_.alpha = 1

				arg_135_1.dialog_:SetActive(true)
				SetActive(arg_135_1.leftNameGo_, true)

				local var_138_17 = arg_135_1:FormatText(StoryNameCfg[612].name)

				arg_135_1.leftNameTxt_.text = var_138_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_135_1.leftNameTxt_.transform)

				arg_135_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_135_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_135_1:RecordName(arg_135_1.leftNameTxt_.text)
				SetActive(arg_135_1.iconTrs_.gameObject, false)
				arg_135_1.callingController_:SetSelectedState("normal")

				local var_138_18 = arg_135_1:GetWordFromCfg(410142033)
				local var_138_19 = arg_135_1:FormatText(var_138_18.content)

				arg_135_1.text_.text = var_138_19

				LuaForUtil.ClearLinePrefixSymbol(arg_135_1.text_)

				local var_138_20 = 54
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

				if manager.audio:GetVoiceLength("story_v_out_410142", "410142033", "story_v_out_410142.awb") ~= 0 then
					local var_138_23 = manager.audio:GetVoiceLength("story_v_out_410142", "410142033", "story_v_out_410142.awb") / 1000

					if var_138_23 + var_138_15 > arg_135_1.duration_ then
						arg_135_1.duration_ = var_138_23 + var_138_15
					end

					if var_138_18.prefab_name ~= "" and arg_135_1.actors_[var_138_18.prefab_name] ~= nil then
						local var_138_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_135_1.actors_[var_138_18.prefab_name].transform, "story_v_out_410142", "410142033", "story_v_out_410142.awb")

						arg_135_1:RecordAudio("410142033", var_138_24)
						arg_135_1:RecordAudio("410142033", var_138_24)
					else
						arg_135_1:AudioAction("play", "voice", "story_v_out_410142", "410142033", "story_v_out_410142.awb")
					end

					arg_135_1:RecordHistoryTalkVoice("story_v_out_410142", "410142033", "story_v_out_410142.awb")
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
				actorName = "1061",
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
	Play410142034 = function(arg_139_0, arg_139_1)
		arg_139_1.time_ = 0
		arg_139_1.frameCnt_ = 0
		arg_139_1.state_ = "playing"
		arg_139_1.curTalkId_ = 410142034
		arg_139_1.duration_ = 5

		SetActive(arg_139_1.tipsGo_, false)

		function arg_139_1.onSingleLineFinish_()
			arg_139_1.onSingleLineUpdate_ = nil
			arg_139_1.onSingleLineFinish_ = nil
			arg_139_1.state_ = "waiting"
		end

		function arg_139_1.playNext_(arg_141_0)
			if arg_141_0 == 1 then
				arg_139_0:Play410142035(arg_139_1)
			end
		end

		function arg_139_1.onSingleLineUpdate_(arg_142_0)
			local var_142_0 = arg_139_1.actors_["1061"].transform
			local var_142_1 = 0

			if var_142_1 < arg_139_1.time_ and arg_139_1.time_ <= var_142_1 + arg_142_0 then
				arg_139_1.var_.moveOldPos1061 = var_142_0.localPosition
				var_142_0.localScale = Vector3.New(1, 1, 1)

				arg_139_1:CheckSpriteTmpPos("1061", 3)

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
				local var_142_6 = Vector3.New(0, -490, 18)

				var_142_0.localPosition = Vector3.Lerp(arg_139_1.var_.moveOldPos1061, var_142_6, var_142_5)
			end

			if arg_139_1.time_ >= var_142_1 + var_142_4 and arg_139_1.time_ < var_142_1 + var_142_4 + arg_142_0 then
				var_142_0.localPosition = Vector3.New(0, -490, 18)
			end

			local var_142_7 = arg_139_1.actors_["1061"]
			local var_142_8 = 0

			if var_142_8 < arg_139_1.time_ and arg_139_1.time_ <= var_142_8 + arg_142_0 and not isNil(var_142_7) and arg_139_1.var_.actorSpriteComps1061 == nil then
				arg_139_1.var_.actorSpriteComps1061 = var_142_7:GetComponentsInChildren(typeof(Image), true)
			end

			local var_142_9 = 0.034

			if var_142_8 <= arg_139_1.time_ and arg_139_1.time_ < var_142_8 + var_142_9 and not isNil(var_142_7) then
				local var_142_10 = (arg_139_1.time_ - var_142_8) / var_142_9

				if arg_139_1.var_.actorSpriteComps1061 then
					for iter_142_1, iter_142_2 in pairs(arg_139_1.var_.actorSpriteComps1061:ToTable()) do
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

			if arg_139_1.time_ >= var_142_8 + var_142_9 and arg_139_1.time_ < var_142_8 + var_142_9 + arg_142_0 and not isNil(var_142_7) and arg_139_1.var_.actorSpriteComps1061 then
				for iter_142_3, iter_142_4 in pairs(arg_139_1.var_.actorSpriteComps1061:ToTable()) do
					if iter_142_4 then
						if arg_139_1.isInRecall_ then
							iter_142_4.color = arg_139_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_142_4.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_139_1.var_.actorSpriteComps1061 = nil
			end

			local var_142_15 = manager.ui.mainCamera.transform
			local var_142_16 = 0.5

			if var_142_16 < arg_139_1.time_ and arg_139_1.time_ <= var_142_16 + arg_142_0 then
				arg_139_1.var_.shakeOldPos = var_142_15.localPosition
			end

			local var_142_17 = 0.5

			if var_142_16 <= arg_139_1.time_ and arg_139_1.time_ < var_142_16 + var_142_17 then
				local var_142_18 = (arg_139_1.time_ - var_142_16) / 0.066
				local var_142_19, var_142_20 = math.modf(var_142_18)

				var_142_15.localPosition = Vector3.New(var_142_20 * 0.13, var_142_20 * 0.13, var_142_20 * 0.13) + arg_139_1.var_.shakeOldPos
			end

			if arg_139_1.time_ >= var_142_16 + var_142_17 and arg_139_1.time_ < var_142_16 + var_142_17 + arg_142_0 then
				var_142_15.localPosition = arg_139_1.var_.shakeOldPos
			end

			local var_142_21 = 0

			if var_142_21 < arg_139_1.time_ and arg_139_1.time_ <= var_142_21 + arg_142_0 then
				arg_139_1.allBtn_.enabled = false
			end

			local var_142_22 = 1

			if arg_139_1.time_ >= var_142_21 + var_142_22 and arg_139_1.time_ < var_142_21 + var_142_22 + arg_142_0 then
				arg_139_1.allBtn_.enabled = true
			end

			local var_142_23 = 0

			if var_142_23 < arg_139_1.time_ and arg_139_1.time_ <= var_142_23 + arg_142_0 then
				arg_139_1.mask_.enabled = true
				arg_139_1.mask_.raycastTarget = false

				arg_139_1:SetGaussion(false)
			end

			local var_142_24 = 0.5

			if var_142_23 <= arg_139_1.time_ and arg_139_1.time_ < var_142_23 + var_142_24 then
				local var_142_25 = (arg_139_1.time_ - var_142_23) / var_142_24
				local var_142_26 = Color.New(1, 1, 1)

				var_142_26.a = Mathf.Lerp(1, 0, var_142_25)
				arg_139_1.mask_.color = var_142_26
			end

			if arg_139_1.time_ >= var_142_23 + var_142_24 and arg_139_1.time_ < var_142_23 + var_142_24 + arg_142_0 then
				local var_142_27 = Color.New(1, 1, 1)
				local var_142_28 = 0

				arg_139_1.mask_.enabled = false
				var_142_27.a = var_142_28
				arg_139_1.mask_.color = var_142_27
			end

			local var_142_29 = manager.ui.mainCamera.transform
			local var_142_30 = 0

			if var_142_30 < arg_139_1.time_ and arg_139_1.time_ <= var_142_30 + arg_142_0 then
				arg_139_1.var_.shakeOldPos = var_142_29.localPosition
			end

			local var_142_31 = 0.5

			if var_142_30 <= arg_139_1.time_ and arg_139_1.time_ < var_142_30 + var_142_31 then
				local var_142_32 = (arg_139_1.time_ - var_142_30) / 0.066
				local var_142_33, var_142_34 = math.modf(var_142_32)

				var_142_29.localPosition = Vector3.New(var_142_34 * 0.13, var_142_34 * 0.13, var_142_34 * 0.13) + arg_139_1.var_.shakeOldPos
			end

			if arg_139_1.time_ >= var_142_30 + var_142_31 and arg_139_1.time_ < var_142_30 + var_142_31 + arg_142_0 then
				var_142_29.localPosition = arg_139_1.var_.shakeOldPos
			end

			local var_142_35 = 0

			if var_142_35 < arg_139_1.time_ and arg_139_1.time_ <= var_142_35 + arg_142_0 then
				arg_139_1.allBtn_.enabled = false
			end

			local var_142_36 = 0.5

			if arg_139_1.time_ >= var_142_35 + var_142_36 and arg_139_1.time_ < var_142_35 + var_142_36 + arg_142_0 then
				arg_139_1.allBtn_.enabled = true
			end

			local var_142_37 = 0
			local var_142_38 = 1.275

			if var_142_37 < arg_139_1.time_ and arg_139_1.time_ <= var_142_37 + arg_142_0 then
				arg_139_1.talkMaxDuration = 0
				arg_139_1.dialogCg_.alpha = 1

				arg_139_1.dialog_:SetActive(true)
				SetActive(arg_139_1.leftNameGo_, false)

				arg_139_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_139_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_139_1:RecordName(arg_139_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_139_1.iconTrs_.gameObject, false)
				arg_139_1.callingController_:SetSelectedState("normal")

				local var_142_39 = arg_139_1:GetWordFromCfg(410142034)
				local var_142_40 = arg_139_1:FormatText(var_142_39.content)

				arg_139_1.text_.text = var_142_40

				LuaForUtil.ClearLinePrefixSymbol(arg_139_1.text_)

				local var_142_41 = 51
				local var_142_42 = utf8.len(var_142_40)
				local var_142_43 = var_142_41 <= 0 and var_142_38 or var_142_38 * (var_142_42 / var_142_41)

				if var_142_43 > 0 and var_142_38 < var_142_43 then
					arg_139_1.talkMaxDuration = var_142_43

					if var_142_43 + var_142_37 > arg_139_1.duration_ then
						arg_139_1.duration_ = var_142_43 + var_142_37
					end
				end

				arg_139_1.text_.text = var_142_40
				arg_139_1.typewritter.percent = 0

				arg_139_1.typewritter:SetDirty()
				arg_139_1:ShowNextGo(false)
				arg_139_1:RecordContent(arg_139_1.text_.text)
			end

			local var_142_44 = math.max(var_142_38, arg_139_1.talkMaxDuration)

			if var_142_37 <= arg_139_1.time_ and arg_139_1.time_ < var_142_37 + var_142_44 then
				arg_139_1.typewritter.percent = (arg_139_1.time_ - var_142_37) / var_142_44

				arg_139_1.typewritter:SetDirty()
			end

			if arg_139_1.time_ >= var_142_37 + var_142_44 and arg_139_1.time_ < var_142_37 + var_142_44 + arg_142_0 then
				arg_139_1.typewritter.percent = 1

				arg_139_1.typewritter:SetDirty()
				arg_139_1:ShowNextGo(true)
			end
		end

		arg_139_1.nodeConfigList_ = {
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

		arg_139_1:InitPlayNodeList()
	end,
	Play410142035 = function(arg_143_0, arg_143_1)
		arg_143_1.time_ = 0
		arg_143_1.frameCnt_ = 0
		arg_143_1.state_ = "playing"
		arg_143_1.curTalkId_ = 410142035
		arg_143_1.duration_ = 5

		SetActive(arg_143_1.tipsGo_, false)

		function arg_143_1.onSingleLineFinish_()
			arg_143_1.onSingleLineUpdate_ = nil
			arg_143_1.onSingleLineFinish_ = nil
			arg_143_1.state_ = "waiting"
		end

		function arg_143_1.playNext_(arg_145_0)
			if arg_145_0 == 1 then
				arg_143_0:Play410142036(arg_143_1)
			end
		end

		function arg_143_1.onSingleLineUpdate_(arg_146_0)
			local var_146_0 = 0
			local var_146_1 = 0.625

			if var_146_0 < arg_143_1.time_ and arg_143_1.time_ <= var_146_0 + arg_146_0 then
				arg_143_1.talkMaxDuration = 0
				arg_143_1.dialogCg_.alpha = 1

				arg_143_1.dialog_:SetActive(true)
				SetActive(arg_143_1.leftNameGo_, false)

				arg_143_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_143_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_143_1:RecordName(arg_143_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_143_1.iconTrs_.gameObject, false)
				arg_143_1.callingController_:SetSelectedState("normal")

				local var_146_2 = arg_143_1:GetWordFromCfg(410142035)
				local var_146_3 = arg_143_1:FormatText(var_146_2.content)

				arg_143_1.text_.text = var_146_3

				LuaForUtil.ClearLinePrefixSymbol(arg_143_1.text_)

				local var_146_4 = 25
				local var_146_5 = utf8.len(var_146_3)
				local var_146_6 = var_146_4 <= 0 and var_146_1 or var_146_1 * (var_146_5 / var_146_4)

				if var_146_6 > 0 and var_146_1 < var_146_6 then
					arg_143_1.talkMaxDuration = var_146_6

					if var_146_6 + var_146_0 > arg_143_1.duration_ then
						arg_143_1.duration_ = var_146_6 + var_146_0
					end
				end

				arg_143_1.text_.text = var_146_3
				arg_143_1.typewritter.percent = 0

				arg_143_1.typewritter:SetDirty()
				arg_143_1:ShowNextGo(false)
				arg_143_1:RecordContent(arg_143_1.text_.text)
			end

			local var_146_7 = math.max(var_146_1, arg_143_1.talkMaxDuration)

			if var_146_0 <= arg_143_1.time_ and arg_143_1.time_ < var_146_0 + var_146_7 then
				arg_143_1.typewritter.percent = (arg_143_1.time_ - var_146_0) / var_146_7

				arg_143_1.typewritter:SetDirty()
			end

			if arg_143_1.time_ >= var_146_0 + var_146_7 and arg_143_1.time_ < var_146_0 + var_146_7 + arg_146_0 then
				arg_143_1.typewritter.percent = 1

				arg_143_1.typewritter:SetDirty()
				arg_143_1:ShowNextGo(true)
			end
		end

		arg_143_1.nodeConfigList_ = {}

		arg_143_1:InitPlayNodeList()
	end,
	Play410142036 = function(arg_147_0, arg_147_1)
		arg_147_1.time_ = 0
		arg_147_1.frameCnt_ = 0
		arg_147_1.state_ = "playing"
		arg_147_1.curTalkId_ = 410142036
		arg_147_1.duration_ = 3.9

		local var_147_0 = {
			ja = 3.9,
			CriLanguages = 2.533,
			zh = 2.533
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
				arg_147_0:Play410142037(arg_147_1)
			end
		end

		function arg_147_1.onSingleLineUpdate_(arg_150_0)
			local var_150_0 = arg_147_1.actors_["1061"].transform
			local var_150_1 = 0

			if var_150_1 < arg_147_1.time_ and arg_147_1.time_ <= var_150_1 + arg_150_0 then
				arg_147_1.var_.moveOldPos1061 = var_150_0.localPosition
				var_150_0.localScale = Vector3.New(1, 1, 1)

				arg_147_1:CheckSpriteTmpPos("1061", 3)

				local var_150_2 = var_150_0.childCount

				for iter_150_0 = 0, var_150_2 - 1 do
					local var_150_3 = var_150_0:GetChild(iter_150_0)

					if var_150_3.name == "split_9" or not string.find(var_150_3.name, "split") then
						var_150_3.gameObject:SetActive(true)
					else
						var_150_3.gameObject:SetActive(false)
					end
				end
			end

			local var_150_4 = 0.001

			if var_150_1 <= arg_147_1.time_ and arg_147_1.time_ < var_150_1 + var_150_4 then
				local var_150_5 = (arg_147_1.time_ - var_150_1) / var_150_4
				local var_150_6 = Vector3.New(0, -490, 18)

				var_150_0.localPosition = Vector3.Lerp(arg_147_1.var_.moveOldPos1061, var_150_6, var_150_5)
			end

			if arg_147_1.time_ >= var_150_1 + var_150_4 and arg_147_1.time_ < var_150_1 + var_150_4 + arg_150_0 then
				var_150_0.localPosition = Vector3.New(0, -490, 18)
			end

			local var_150_7 = arg_147_1.actors_["1061"]
			local var_150_8 = 0

			if var_150_8 < arg_147_1.time_ and arg_147_1.time_ <= var_150_8 + arg_150_0 and not isNil(var_150_7) and arg_147_1.var_.actorSpriteComps1061 == nil then
				arg_147_1.var_.actorSpriteComps1061 = var_150_7:GetComponentsInChildren(typeof(Image), true)
			end

			local var_150_9 = 0.034

			if var_150_8 <= arg_147_1.time_ and arg_147_1.time_ < var_150_8 + var_150_9 and not isNil(var_150_7) then
				local var_150_10 = (arg_147_1.time_ - var_150_8) / var_150_9

				if arg_147_1.var_.actorSpriteComps1061 then
					for iter_150_1, iter_150_2 in pairs(arg_147_1.var_.actorSpriteComps1061:ToTable()) do
						if iter_150_2 then
							if arg_147_1.isInRecall_ then
								local var_150_11 = Mathf.Lerp(iter_150_2.color.r, arg_147_1.hightColor1.r, var_150_10)
								local var_150_12 = Mathf.Lerp(iter_150_2.color.g, arg_147_1.hightColor1.g, var_150_10)
								local var_150_13 = Mathf.Lerp(iter_150_2.color.b, arg_147_1.hightColor1.b, var_150_10)

								iter_150_2.color = Color.New(var_150_11, var_150_12, var_150_13)
							else
								local var_150_14 = Mathf.Lerp(iter_150_2.color.r, 1, var_150_10)

								iter_150_2.color = Color.New(var_150_14, var_150_14, var_150_14)
							end
						end
					end
				end
			end

			if arg_147_1.time_ >= var_150_8 + var_150_9 and arg_147_1.time_ < var_150_8 + var_150_9 + arg_150_0 and not isNil(var_150_7) and arg_147_1.var_.actorSpriteComps1061 then
				for iter_150_3, iter_150_4 in pairs(arg_147_1.var_.actorSpriteComps1061:ToTable()) do
					if iter_150_4 then
						if arg_147_1.isInRecall_ then
							iter_150_4.color = arg_147_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_150_4.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_147_1.var_.actorSpriteComps1061 = nil
			end

			local var_150_15 = 0
			local var_150_16 = 0.25

			if var_150_15 < arg_147_1.time_ and arg_147_1.time_ <= var_150_15 + arg_150_0 then
				arg_147_1.talkMaxDuration = 0
				arg_147_1.dialogCg_.alpha = 1

				arg_147_1.dialog_:SetActive(true)
				SetActive(arg_147_1.leftNameGo_, true)

				local var_150_17 = arg_147_1:FormatText(StoryNameCfg[612].name)

				arg_147_1.leftNameTxt_.text = var_150_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_147_1.leftNameTxt_.transform)

				arg_147_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_147_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_147_1:RecordName(arg_147_1.leftNameTxt_.text)
				SetActive(arg_147_1.iconTrs_.gameObject, false)
				arg_147_1.callingController_:SetSelectedState("normal")

				local var_150_18 = arg_147_1:GetWordFromCfg(410142036)
				local var_150_19 = arg_147_1:FormatText(var_150_18.content)

				arg_147_1.text_.text = var_150_19

				LuaForUtil.ClearLinePrefixSymbol(arg_147_1.text_)

				local var_150_20 = 10
				local var_150_21 = utf8.len(var_150_19)
				local var_150_22 = var_150_20 <= 0 and var_150_16 or var_150_16 * (var_150_21 / var_150_20)

				if var_150_22 > 0 and var_150_16 < var_150_22 then
					arg_147_1.talkMaxDuration = var_150_22

					if var_150_22 + var_150_15 > arg_147_1.duration_ then
						arg_147_1.duration_ = var_150_22 + var_150_15
					end
				end

				arg_147_1.text_.text = var_150_19
				arg_147_1.typewritter.percent = 0

				arg_147_1.typewritter:SetDirty()
				arg_147_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_410142", "410142036", "story_v_out_410142.awb") ~= 0 then
					local var_150_23 = manager.audio:GetVoiceLength("story_v_out_410142", "410142036", "story_v_out_410142.awb") / 1000

					if var_150_23 + var_150_15 > arg_147_1.duration_ then
						arg_147_1.duration_ = var_150_23 + var_150_15
					end

					if var_150_18.prefab_name ~= "" and arg_147_1.actors_[var_150_18.prefab_name] ~= nil then
						local var_150_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_147_1.actors_[var_150_18.prefab_name].transform, "story_v_out_410142", "410142036", "story_v_out_410142.awb")

						arg_147_1:RecordAudio("410142036", var_150_24)
						arg_147_1:RecordAudio("410142036", var_150_24)
					else
						arg_147_1:AudioAction("play", "voice", "story_v_out_410142", "410142036", "story_v_out_410142.awb")
					end

					arg_147_1:RecordHistoryTalkVoice("story_v_out_410142", "410142036", "story_v_out_410142.awb")
				end

				arg_147_1:RecordContent(arg_147_1.text_.text)
			end

			local var_150_25 = math.max(var_150_16, arg_147_1.talkMaxDuration)

			if var_150_15 <= arg_147_1.time_ and arg_147_1.time_ < var_150_15 + var_150_25 then
				arg_147_1.typewritter.percent = (arg_147_1.time_ - var_150_15) / var_150_25

				arg_147_1.typewritter:SetDirty()
			end

			if arg_147_1.time_ >= var_150_15 + var_150_25 and arg_147_1.time_ < var_150_15 + var_150_25 + arg_150_0 then
				arg_147_1.typewritter.percent = 1

				arg_147_1.typewritter:SetDirty()
				arg_147_1:ShowNextGo(true)
			end
		end

		arg_147_1.nodeConfigList_ = {
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

		arg_147_1:InitPlayNodeList()
	end,
	Play410142037 = function(arg_151_0, arg_151_1)
		arg_151_1.time_ = 0
		arg_151_1.frameCnt_ = 0
		arg_151_1.state_ = "playing"
		arg_151_1.curTalkId_ = 410142037
		arg_151_1.duration_ = 5.67

		local var_151_0 = {
			ja = 5.666,
			CriLanguages = 3.333,
			zh = 3.333
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
				arg_151_0:Play410142038(arg_151_1)
			end
		end

		function arg_151_1.onSingleLineUpdate_(arg_154_0)
			local var_154_0 = arg_151_1.actors_["1061"].transform
			local var_154_1 = 0

			if var_154_1 < arg_151_1.time_ and arg_151_1.time_ <= var_154_1 + arg_154_0 then
				arg_151_1.var_.moveOldPos1061 = var_154_0.localPosition
				var_154_0.localScale = Vector3.New(1, 1, 1)

				arg_151_1:CheckSpriteTmpPos("1061", 3)

				local var_154_2 = var_154_0.childCount

				for iter_154_0 = 0, var_154_2 - 1 do
					local var_154_3 = var_154_0:GetChild(iter_154_0)

					if var_154_3.name == "" or not string.find(var_154_3.name, "split") then
						var_154_3.gameObject:SetActive(true)
					else
						var_154_3.gameObject:SetActive(false)
					end
				end
			end

			local var_154_4 = 0.001

			if var_154_1 <= arg_151_1.time_ and arg_151_1.time_ < var_154_1 + var_154_4 then
				local var_154_5 = (arg_151_1.time_ - var_154_1) / var_154_4
				local var_154_6 = Vector3.New(0, -490, 18)

				var_154_0.localPosition = Vector3.Lerp(arg_151_1.var_.moveOldPos1061, var_154_6, var_154_5)
			end

			if arg_151_1.time_ >= var_154_1 + var_154_4 and arg_151_1.time_ < var_154_1 + var_154_4 + arg_154_0 then
				var_154_0.localPosition = Vector3.New(0, -490, 18)
			end

			local var_154_7 = arg_151_1.actors_["1061"]
			local var_154_8 = 0

			if var_154_8 < arg_151_1.time_ and arg_151_1.time_ <= var_154_8 + arg_154_0 and not isNil(var_154_7) and arg_151_1.var_.actorSpriteComps1061 == nil then
				arg_151_1.var_.actorSpriteComps1061 = var_154_7:GetComponentsInChildren(typeof(Image), true)
			end

			local var_154_9 = 0.034

			if var_154_8 <= arg_151_1.time_ and arg_151_1.time_ < var_154_8 + var_154_9 and not isNil(var_154_7) then
				local var_154_10 = (arg_151_1.time_ - var_154_8) / var_154_9

				if arg_151_1.var_.actorSpriteComps1061 then
					for iter_154_1, iter_154_2 in pairs(arg_151_1.var_.actorSpriteComps1061:ToTable()) do
						if iter_154_2 then
							if arg_151_1.isInRecall_ then
								local var_154_11 = Mathf.Lerp(iter_154_2.color.r, arg_151_1.hightColor2.r, var_154_10)
								local var_154_12 = Mathf.Lerp(iter_154_2.color.g, arg_151_1.hightColor2.g, var_154_10)
								local var_154_13 = Mathf.Lerp(iter_154_2.color.b, arg_151_1.hightColor2.b, var_154_10)

								iter_154_2.color = Color.New(var_154_11, var_154_12, var_154_13)
							else
								local var_154_14 = Mathf.Lerp(iter_154_2.color.r, 0.5, var_154_10)

								iter_154_2.color = Color.New(var_154_14, var_154_14, var_154_14)
							end
						end
					end
				end
			end

			if arg_151_1.time_ >= var_154_8 + var_154_9 and arg_151_1.time_ < var_154_8 + var_154_9 + arg_154_0 and not isNil(var_154_7) and arg_151_1.var_.actorSpriteComps1061 then
				for iter_154_3, iter_154_4 in pairs(arg_151_1.var_.actorSpriteComps1061:ToTable()) do
					if iter_154_4 then
						if arg_151_1.isInRecall_ then
							iter_154_4.color = arg_151_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_154_4.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_151_1.var_.actorSpriteComps1061 = nil
			end

			local var_154_15 = 0
			local var_154_16 = 0.4

			if var_154_15 < arg_151_1.time_ and arg_151_1.time_ <= var_154_15 + arg_154_0 then
				arg_151_1.talkMaxDuration = 0
				arg_151_1.dialogCg_.alpha = 1

				arg_151_1.dialog_:SetActive(true)
				SetActive(arg_151_1.leftNameGo_, true)

				local var_154_17 = arg_151_1:FormatText(StoryNameCfg[613].name)

				arg_151_1.leftNameTxt_.text = var_154_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_151_1.leftNameTxt_.transform)

				arg_151_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_151_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_151_1:RecordName(arg_151_1.leftNameTxt_.text)
				SetActive(arg_151_1.iconTrs_.gameObject, true)
				arg_151_1.iconController_:SetSelectedState("hero")

				arg_151_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_1020")

				arg_151_1.callingController_:SetSelectedState("normal")

				arg_151_1.keyicon_.color = Color.New(1, 1, 1)
				arg_151_1.icon_.color = Color.New(1, 1, 1)

				local var_154_18 = arg_151_1:GetWordFromCfg(410142037)
				local var_154_19 = arg_151_1:FormatText(var_154_18.content)

				arg_151_1.text_.text = var_154_19

				LuaForUtil.ClearLinePrefixSymbol(arg_151_1.text_)

				local var_154_20 = 16
				local var_154_21 = utf8.len(var_154_19)
				local var_154_22 = var_154_20 <= 0 and var_154_16 or var_154_16 * (var_154_21 / var_154_20)

				if var_154_22 > 0 and var_154_16 < var_154_22 then
					arg_151_1.talkMaxDuration = var_154_22

					if var_154_22 + var_154_15 > arg_151_1.duration_ then
						arg_151_1.duration_ = var_154_22 + var_154_15
					end
				end

				arg_151_1.text_.text = var_154_19
				arg_151_1.typewritter.percent = 0

				arg_151_1.typewritter:SetDirty()
				arg_151_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_410142", "410142037", "story_v_out_410142.awb") ~= 0 then
					local var_154_23 = manager.audio:GetVoiceLength("story_v_out_410142", "410142037", "story_v_out_410142.awb") / 1000

					if var_154_23 + var_154_15 > arg_151_1.duration_ then
						arg_151_1.duration_ = var_154_23 + var_154_15
					end

					if var_154_18.prefab_name ~= "" and arg_151_1.actors_[var_154_18.prefab_name] ~= nil then
						local var_154_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_151_1.actors_[var_154_18.prefab_name].transform, "story_v_out_410142", "410142037", "story_v_out_410142.awb")

						arg_151_1:RecordAudio("410142037", var_154_24)
						arg_151_1:RecordAudio("410142037", var_154_24)
					else
						arg_151_1:AudioAction("play", "voice", "story_v_out_410142", "410142037", "story_v_out_410142.awb")
					end

					arg_151_1:RecordHistoryTalkVoice("story_v_out_410142", "410142037", "story_v_out_410142.awb")
				end

				arg_151_1:RecordContent(arg_151_1.text_.text)
			end

			local var_154_25 = math.max(var_154_16, arg_151_1.talkMaxDuration)

			if var_154_15 <= arg_151_1.time_ and arg_151_1.time_ < var_154_15 + var_154_25 then
				arg_151_1.typewritter.percent = (arg_151_1.time_ - var_154_15) / var_154_25

				arg_151_1.typewritter:SetDirty()
			end

			if arg_151_1.time_ >= var_154_15 + var_154_25 and arg_151_1.time_ < var_154_15 + var_154_25 + arg_154_0 then
				arg_151_1.typewritter.percent = 1

				arg_151_1.typewritter:SetDirty()
				arg_151_1:ShowNextGo(true)
			end
		end

		arg_151_1.nodeConfigList_ = {
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

		arg_151_1:InitPlayNodeList()
	end,
	Play410142038 = function(arg_155_0, arg_155_1)
		arg_155_1.time_ = 0
		arg_155_1.frameCnt_ = 0
		arg_155_1.state_ = "playing"
		arg_155_1.curTalkId_ = 410142038
		arg_155_1.duration_ = 10.23

		local var_155_0 = {
			ja = 6.8,
			CriLanguages = 10.233,
			zh = 10.233
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
				arg_155_0:Play410142039(arg_155_1)
			end
		end

		function arg_155_1.onSingleLineUpdate_(arg_158_0)
			local var_158_0 = arg_155_1.actors_["1061"].transform
			local var_158_1 = 0

			if var_158_1 < arg_155_1.time_ and arg_155_1.time_ <= var_158_1 + arg_158_0 then
				arg_155_1.var_.moveOldPos1061 = var_158_0.localPosition
				var_158_0.localScale = Vector3.New(1, 1, 1)

				arg_155_1:CheckSpriteTmpPos("1061", 3)

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
				local var_158_6 = Vector3.New(0, -490, 18)

				var_158_0.localPosition = Vector3.Lerp(arg_155_1.var_.moveOldPos1061, var_158_6, var_158_5)
			end

			if arg_155_1.time_ >= var_158_1 + var_158_4 and arg_155_1.time_ < var_158_1 + var_158_4 + arg_158_0 then
				var_158_0.localPosition = Vector3.New(0, -490, 18)
			end

			local var_158_7 = arg_155_1.actors_["1061"]
			local var_158_8 = 0

			if var_158_8 < arg_155_1.time_ and arg_155_1.time_ <= var_158_8 + arg_158_0 and not isNil(var_158_7) and arg_155_1.var_.actorSpriteComps1061 == nil then
				arg_155_1.var_.actorSpriteComps1061 = var_158_7:GetComponentsInChildren(typeof(Image), true)
			end

			local var_158_9 = 0.034

			if var_158_8 <= arg_155_1.time_ and arg_155_1.time_ < var_158_8 + var_158_9 and not isNil(var_158_7) then
				local var_158_10 = (arg_155_1.time_ - var_158_8) / var_158_9

				if arg_155_1.var_.actorSpriteComps1061 then
					for iter_158_1, iter_158_2 in pairs(arg_155_1.var_.actorSpriteComps1061:ToTable()) do
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

			if arg_155_1.time_ >= var_158_8 + var_158_9 and arg_155_1.time_ < var_158_8 + var_158_9 + arg_158_0 and not isNil(var_158_7) and arg_155_1.var_.actorSpriteComps1061 then
				for iter_158_3, iter_158_4 in pairs(arg_155_1.var_.actorSpriteComps1061:ToTable()) do
					if iter_158_4 then
						if arg_155_1.isInRecall_ then
							iter_158_4.color = arg_155_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_158_4.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_155_1.var_.actorSpriteComps1061 = nil
			end

			local var_158_15 = 0
			local var_158_16 = 1.15

			if var_158_15 < arg_155_1.time_ and arg_155_1.time_ <= var_158_15 + arg_158_0 then
				arg_155_1.talkMaxDuration = 0
				arg_155_1.dialogCg_.alpha = 1

				arg_155_1.dialog_:SetActive(true)
				SetActive(arg_155_1.leftNameGo_, true)

				local var_158_17 = arg_155_1:FormatText(StoryNameCfg[612].name)

				arg_155_1.leftNameTxt_.text = var_158_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_155_1.leftNameTxt_.transform)

				arg_155_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_155_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_155_1:RecordName(arg_155_1.leftNameTxt_.text)
				SetActive(arg_155_1.iconTrs_.gameObject, false)
				arg_155_1.callingController_:SetSelectedState("normal")

				local var_158_18 = arg_155_1:GetWordFromCfg(410142038)
				local var_158_19 = arg_155_1:FormatText(var_158_18.content)

				arg_155_1.text_.text = var_158_19

				LuaForUtil.ClearLinePrefixSymbol(arg_155_1.text_)

				local var_158_20 = 48
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

				if manager.audio:GetVoiceLength("story_v_out_410142", "410142038", "story_v_out_410142.awb") ~= 0 then
					local var_158_23 = manager.audio:GetVoiceLength("story_v_out_410142", "410142038", "story_v_out_410142.awb") / 1000

					if var_158_23 + var_158_15 > arg_155_1.duration_ then
						arg_155_1.duration_ = var_158_23 + var_158_15
					end

					if var_158_18.prefab_name ~= "" and arg_155_1.actors_[var_158_18.prefab_name] ~= nil then
						local var_158_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_155_1.actors_[var_158_18.prefab_name].transform, "story_v_out_410142", "410142038", "story_v_out_410142.awb")

						arg_155_1:RecordAudio("410142038", var_158_24)
						arg_155_1:RecordAudio("410142038", var_158_24)
					else
						arg_155_1:AudioAction("play", "voice", "story_v_out_410142", "410142038", "story_v_out_410142.awb")
					end

					arg_155_1:RecordHistoryTalkVoice("story_v_out_410142", "410142038", "story_v_out_410142.awb")
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
				actorName = "1061",
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
	Play410142039 = function(arg_159_0, arg_159_1)
		arg_159_1.time_ = 0
		arg_159_1.frameCnt_ = 0
		arg_159_1.state_ = "playing"
		arg_159_1.curTalkId_ = 410142039
		arg_159_1.duration_ = 6.8

		local var_159_0 = {
			ja = 6.8,
			CriLanguages = 5.2,
			zh = 5.2
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
				arg_159_0:Play410142040(arg_159_1)
			end
		end

		function arg_159_1.onSingleLineUpdate_(arg_162_0)
			local var_162_0 = arg_159_1.actors_["1061"]
			local var_162_1 = 0

			if var_162_1 < arg_159_1.time_ and arg_159_1.time_ <= var_162_1 + arg_162_0 and not isNil(var_162_0) and arg_159_1.var_.actorSpriteComps1061 == nil then
				arg_159_1.var_.actorSpriteComps1061 = var_162_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_162_2 = 0.034

			if var_162_1 <= arg_159_1.time_ and arg_159_1.time_ < var_162_1 + var_162_2 and not isNil(var_162_0) then
				local var_162_3 = (arg_159_1.time_ - var_162_1) / var_162_2

				if arg_159_1.var_.actorSpriteComps1061 then
					for iter_162_0, iter_162_1 in pairs(arg_159_1.var_.actorSpriteComps1061:ToTable()) do
						if iter_162_1 then
							if arg_159_1.isInRecall_ then
								local var_162_4 = Mathf.Lerp(iter_162_1.color.r, arg_159_1.hightColor2.r, var_162_3)
								local var_162_5 = Mathf.Lerp(iter_162_1.color.g, arg_159_1.hightColor2.g, var_162_3)
								local var_162_6 = Mathf.Lerp(iter_162_1.color.b, arg_159_1.hightColor2.b, var_162_3)

								iter_162_1.color = Color.New(var_162_4, var_162_5, var_162_6)
							else
								local var_162_7 = Mathf.Lerp(iter_162_1.color.r, 0.5, var_162_3)

								iter_162_1.color = Color.New(var_162_7, var_162_7, var_162_7)
							end
						end
					end
				end
			end

			if arg_159_1.time_ >= var_162_1 + var_162_2 and arg_159_1.time_ < var_162_1 + var_162_2 + arg_162_0 and not isNil(var_162_0) and arg_159_1.var_.actorSpriteComps1061 then
				for iter_162_2, iter_162_3 in pairs(arg_159_1.var_.actorSpriteComps1061:ToTable()) do
					if iter_162_3 then
						if arg_159_1.isInRecall_ then
							iter_162_3.color = arg_159_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_162_3.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_159_1.var_.actorSpriteComps1061 = nil
			end

			local var_162_8 = 0
			local var_162_9 = 0.6

			if var_162_8 < arg_159_1.time_ and arg_159_1.time_ <= var_162_8 + arg_162_0 then
				arg_159_1.talkMaxDuration = 0
				arg_159_1.dialogCg_.alpha = 1

				arg_159_1.dialog_:SetActive(true)
				SetActive(arg_159_1.leftNameGo_, true)

				local var_162_10 = arg_159_1:FormatText(StoryNameCfg[613].name)

				arg_159_1.leftNameTxt_.text = var_162_10

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_159_1.leftNameTxt_.transform)

				arg_159_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_159_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_159_1:RecordName(arg_159_1.leftNameTxt_.text)
				SetActive(arg_159_1.iconTrs_.gameObject, true)
				arg_159_1.iconController_:SetSelectedState("hero")

				arg_159_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_1020")

				arg_159_1.callingController_:SetSelectedState("normal")

				arg_159_1.keyicon_.color = Color.New(1, 1, 1)
				arg_159_1.icon_.color = Color.New(1, 1, 1)

				local var_162_11 = arg_159_1:GetWordFromCfg(410142039)
				local var_162_12 = arg_159_1:FormatText(var_162_11.content)

				arg_159_1.text_.text = var_162_12

				LuaForUtil.ClearLinePrefixSymbol(arg_159_1.text_)

				local var_162_13 = 24
				local var_162_14 = utf8.len(var_162_12)
				local var_162_15 = var_162_13 <= 0 and var_162_9 or var_162_9 * (var_162_14 / var_162_13)

				if var_162_15 > 0 and var_162_9 < var_162_15 then
					arg_159_1.talkMaxDuration = var_162_15

					if var_162_15 + var_162_8 > arg_159_1.duration_ then
						arg_159_1.duration_ = var_162_15 + var_162_8
					end
				end

				arg_159_1.text_.text = var_162_12
				arg_159_1.typewritter.percent = 0

				arg_159_1.typewritter:SetDirty()
				arg_159_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_410142", "410142039", "story_v_out_410142.awb") ~= 0 then
					local var_162_16 = manager.audio:GetVoiceLength("story_v_out_410142", "410142039", "story_v_out_410142.awb") / 1000

					if var_162_16 + var_162_8 > arg_159_1.duration_ then
						arg_159_1.duration_ = var_162_16 + var_162_8
					end

					if var_162_11.prefab_name ~= "" and arg_159_1.actors_[var_162_11.prefab_name] ~= nil then
						local var_162_17 = LuaForUtil.PlayVoiceWithCriLipsync(arg_159_1.actors_[var_162_11.prefab_name].transform, "story_v_out_410142", "410142039", "story_v_out_410142.awb")

						arg_159_1:RecordAudio("410142039", var_162_17)
						arg_159_1:RecordAudio("410142039", var_162_17)
					else
						arg_159_1:AudioAction("play", "voice", "story_v_out_410142", "410142039", "story_v_out_410142.awb")
					end

					arg_159_1:RecordHistoryTalkVoice("story_v_out_410142", "410142039", "story_v_out_410142.awb")
				end

				arg_159_1:RecordContent(arg_159_1.text_.text)
			end

			local var_162_18 = math.max(var_162_9, arg_159_1.talkMaxDuration)

			if var_162_8 <= arg_159_1.time_ and arg_159_1.time_ < var_162_8 + var_162_18 then
				arg_159_1.typewritter.percent = (arg_159_1.time_ - var_162_8) / var_162_18

				arg_159_1.typewritter:SetDirty()
			end

			if arg_159_1.time_ >= var_162_8 + var_162_18 and arg_159_1.time_ < var_162_8 + var_162_18 + arg_162_0 then
				arg_159_1.typewritter.percent = 1

				arg_159_1.typewritter:SetDirty()
				arg_159_1:ShowNextGo(true)
			end
		end

		arg_159_1.nodeConfigList_ = {}

		arg_159_1:InitPlayNodeList()
	end,
	Play410142040 = function(arg_163_0, arg_163_1)
		arg_163_1.time_ = 0
		arg_163_1.frameCnt_ = 0
		arg_163_1.state_ = "playing"
		arg_163_1.curTalkId_ = 410142040
		arg_163_1.duration_ = 15.57

		local var_163_0 = {
			ja = 15.566,
			CriLanguages = 10.433,
			zh = 10.433
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
				arg_163_0:Play410142041(arg_163_1)
			end
		end

		function arg_163_1.onSingleLineUpdate_(arg_166_0)
			local var_166_0 = arg_163_1.actors_["1061"].transform
			local var_166_1 = 0

			if var_166_1 < arg_163_1.time_ and arg_163_1.time_ <= var_166_1 + arg_166_0 then
				arg_163_1.var_.moveOldPos1061 = var_166_0.localPosition
				var_166_0.localScale = Vector3.New(1, 1, 1)

				arg_163_1:CheckSpriteTmpPos("1061", 3)

				local var_166_2 = var_166_0.childCount

				for iter_166_0 = 0, var_166_2 - 1 do
					local var_166_3 = var_166_0:GetChild(iter_166_0)

					if var_166_3.name == "split_5" or not string.find(var_166_3.name, "split") then
						var_166_3.gameObject:SetActive(true)
					else
						var_166_3.gameObject:SetActive(false)
					end
				end
			end

			local var_166_4 = 0.001

			if var_166_1 <= arg_163_1.time_ and arg_163_1.time_ < var_166_1 + var_166_4 then
				local var_166_5 = (arg_163_1.time_ - var_166_1) / var_166_4
				local var_166_6 = Vector3.New(0, -490, 18)

				var_166_0.localPosition = Vector3.Lerp(arg_163_1.var_.moveOldPos1061, var_166_6, var_166_5)
			end

			if arg_163_1.time_ >= var_166_1 + var_166_4 and arg_163_1.time_ < var_166_1 + var_166_4 + arg_166_0 then
				var_166_0.localPosition = Vector3.New(0, -490, 18)
			end

			local var_166_7 = arg_163_1.actors_["1061"]
			local var_166_8 = 0

			if var_166_8 < arg_163_1.time_ and arg_163_1.time_ <= var_166_8 + arg_166_0 and not isNil(var_166_7) and arg_163_1.var_.actorSpriteComps1061 == nil then
				arg_163_1.var_.actorSpriteComps1061 = var_166_7:GetComponentsInChildren(typeof(Image), true)
			end

			local var_166_9 = 0.034

			if var_166_8 <= arg_163_1.time_ and arg_163_1.time_ < var_166_8 + var_166_9 and not isNil(var_166_7) then
				local var_166_10 = (arg_163_1.time_ - var_166_8) / var_166_9

				if arg_163_1.var_.actorSpriteComps1061 then
					for iter_166_1, iter_166_2 in pairs(arg_163_1.var_.actorSpriteComps1061:ToTable()) do
						if iter_166_2 then
							if arg_163_1.isInRecall_ then
								local var_166_11 = Mathf.Lerp(iter_166_2.color.r, arg_163_1.hightColor1.r, var_166_10)
								local var_166_12 = Mathf.Lerp(iter_166_2.color.g, arg_163_1.hightColor1.g, var_166_10)
								local var_166_13 = Mathf.Lerp(iter_166_2.color.b, arg_163_1.hightColor1.b, var_166_10)

								iter_166_2.color = Color.New(var_166_11, var_166_12, var_166_13)
							else
								local var_166_14 = Mathf.Lerp(iter_166_2.color.r, 1, var_166_10)

								iter_166_2.color = Color.New(var_166_14, var_166_14, var_166_14)
							end
						end
					end
				end
			end

			if arg_163_1.time_ >= var_166_8 + var_166_9 and arg_163_1.time_ < var_166_8 + var_166_9 + arg_166_0 and not isNil(var_166_7) and arg_163_1.var_.actorSpriteComps1061 then
				for iter_166_3, iter_166_4 in pairs(arg_163_1.var_.actorSpriteComps1061:ToTable()) do
					if iter_166_4 then
						if arg_163_1.isInRecall_ then
							iter_166_4.color = arg_163_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_166_4.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_163_1.var_.actorSpriteComps1061 = nil
			end

			local var_166_15 = 0
			local var_166_16 = 1.3

			if var_166_15 < arg_163_1.time_ and arg_163_1.time_ <= var_166_15 + arg_166_0 then
				arg_163_1.talkMaxDuration = 0
				arg_163_1.dialogCg_.alpha = 1

				arg_163_1.dialog_:SetActive(true)
				SetActive(arg_163_1.leftNameGo_, true)

				local var_166_17 = arg_163_1:FormatText(StoryNameCfg[612].name)

				arg_163_1.leftNameTxt_.text = var_166_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_163_1.leftNameTxt_.transform)

				arg_163_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_163_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_163_1:RecordName(arg_163_1.leftNameTxt_.text)
				SetActive(arg_163_1.iconTrs_.gameObject, false)
				arg_163_1.callingController_:SetSelectedState("normal")

				local var_166_18 = arg_163_1:GetWordFromCfg(410142040)
				local var_166_19 = arg_163_1:FormatText(var_166_18.content)

				arg_163_1.text_.text = var_166_19

				LuaForUtil.ClearLinePrefixSymbol(arg_163_1.text_)

				local var_166_20 = 52
				local var_166_21 = utf8.len(var_166_19)
				local var_166_22 = var_166_20 <= 0 and var_166_16 or var_166_16 * (var_166_21 / var_166_20)

				if var_166_22 > 0 and var_166_16 < var_166_22 then
					arg_163_1.talkMaxDuration = var_166_22

					if var_166_22 + var_166_15 > arg_163_1.duration_ then
						arg_163_1.duration_ = var_166_22 + var_166_15
					end
				end

				arg_163_1.text_.text = var_166_19
				arg_163_1.typewritter.percent = 0

				arg_163_1.typewritter:SetDirty()
				arg_163_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_410142", "410142040", "story_v_out_410142.awb") ~= 0 then
					local var_166_23 = manager.audio:GetVoiceLength("story_v_out_410142", "410142040", "story_v_out_410142.awb") / 1000

					if var_166_23 + var_166_15 > arg_163_1.duration_ then
						arg_163_1.duration_ = var_166_23 + var_166_15
					end

					if var_166_18.prefab_name ~= "" and arg_163_1.actors_[var_166_18.prefab_name] ~= nil then
						local var_166_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_163_1.actors_[var_166_18.prefab_name].transform, "story_v_out_410142", "410142040", "story_v_out_410142.awb")

						arg_163_1:RecordAudio("410142040", var_166_24)
						arg_163_1:RecordAudio("410142040", var_166_24)
					else
						arg_163_1:AudioAction("play", "voice", "story_v_out_410142", "410142040", "story_v_out_410142.awb")
					end

					arg_163_1:RecordHistoryTalkVoice("story_v_out_410142", "410142040", "story_v_out_410142.awb")
				end

				arg_163_1:RecordContent(arg_163_1.text_.text)
			end

			local var_166_25 = math.max(var_166_16, arg_163_1.talkMaxDuration)

			if var_166_15 <= arg_163_1.time_ and arg_163_1.time_ < var_166_15 + var_166_25 then
				arg_163_1.typewritter.percent = (arg_163_1.time_ - var_166_15) / var_166_25

				arg_163_1.typewritter:SetDirty()
			end

			if arg_163_1.time_ >= var_166_15 + var_166_25 and arg_163_1.time_ < var_166_15 + var_166_25 + arg_166_0 then
				arg_163_1.typewritter.percent = 1

				arg_163_1.typewritter:SetDirty()
				arg_163_1:ShowNextGo(true)
			end
		end

		arg_163_1.nodeConfigList_ = {
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

		arg_163_1:InitPlayNodeList()
	end,
	Play410142041 = function(arg_167_0, arg_167_1)
		arg_167_1.time_ = 0
		arg_167_1.frameCnt_ = 0
		arg_167_1.state_ = "playing"
		arg_167_1.curTalkId_ = 410142041
		arg_167_1.duration_ = 7.77

		local var_167_0 = {
			ja = 7.766,
			CriLanguages = 7.066,
			zh = 7.066
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
				arg_167_0:Play410142042(arg_167_1)
			end
		end

		function arg_167_1.onSingleLineUpdate_(arg_170_0)
			local var_170_0 = arg_167_1.actors_["1061"].transform
			local var_170_1 = 0

			if var_170_1 < arg_167_1.time_ and arg_167_1.time_ <= var_170_1 + arg_170_0 then
				arg_167_1.var_.moveOldPos1061 = var_170_0.localPosition
				var_170_0.localScale = Vector3.New(1, 1, 1)

				arg_167_1:CheckSpriteTmpPos("1061", 3)

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
				local var_170_6 = Vector3.New(0, -490, 18)

				var_170_0.localPosition = Vector3.Lerp(arg_167_1.var_.moveOldPos1061, var_170_6, var_170_5)
			end

			if arg_167_1.time_ >= var_170_1 + var_170_4 and arg_167_1.time_ < var_170_1 + var_170_4 + arg_170_0 then
				var_170_0.localPosition = Vector3.New(0, -490, 18)
			end

			local var_170_7 = arg_167_1.actors_["1061"]
			local var_170_8 = 0

			if var_170_8 < arg_167_1.time_ and arg_167_1.time_ <= var_170_8 + arg_170_0 and not isNil(var_170_7) and arg_167_1.var_.actorSpriteComps1061 == nil then
				arg_167_1.var_.actorSpriteComps1061 = var_170_7:GetComponentsInChildren(typeof(Image), true)
			end

			local var_170_9 = 0.034

			if var_170_8 <= arg_167_1.time_ and arg_167_1.time_ < var_170_8 + var_170_9 and not isNil(var_170_7) then
				local var_170_10 = (arg_167_1.time_ - var_170_8) / var_170_9

				if arg_167_1.var_.actorSpriteComps1061 then
					for iter_170_1, iter_170_2 in pairs(arg_167_1.var_.actorSpriteComps1061:ToTable()) do
						if iter_170_2 then
							if arg_167_1.isInRecall_ then
								local var_170_11 = Mathf.Lerp(iter_170_2.color.r, arg_167_1.hightColor2.r, var_170_10)
								local var_170_12 = Mathf.Lerp(iter_170_2.color.g, arg_167_1.hightColor2.g, var_170_10)
								local var_170_13 = Mathf.Lerp(iter_170_2.color.b, arg_167_1.hightColor2.b, var_170_10)

								iter_170_2.color = Color.New(var_170_11, var_170_12, var_170_13)
							else
								local var_170_14 = Mathf.Lerp(iter_170_2.color.r, 0.5, var_170_10)

								iter_170_2.color = Color.New(var_170_14, var_170_14, var_170_14)
							end
						end
					end
				end
			end

			if arg_167_1.time_ >= var_170_8 + var_170_9 and arg_167_1.time_ < var_170_8 + var_170_9 + arg_170_0 and not isNil(var_170_7) and arg_167_1.var_.actorSpriteComps1061 then
				for iter_170_3, iter_170_4 in pairs(arg_167_1.var_.actorSpriteComps1061:ToTable()) do
					if iter_170_4 then
						if arg_167_1.isInRecall_ then
							iter_170_4.color = arg_167_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_170_4.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_167_1.var_.actorSpriteComps1061 = nil
			end

			local var_170_15 = 0
			local var_170_16 = 0.6

			if var_170_15 < arg_167_1.time_ and arg_167_1.time_ <= var_170_15 + arg_170_0 then
				arg_167_1.talkMaxDuration = 0
				arg_167_1.dialogCg_.alpha = 1

				arg_167_1.dialog_:SetActive(true)
				SetActive(arg_167_1.leftNameGo_, true)

				local var_170_17 = arg_167_1:FormatText(StoryNameCfg[613].name)

				arg_167_1.leftNameTxt_.text = var_170_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_167_1.leftNameTxt_.transform)

				arg_167_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_167_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_167_1:RecordName(arg_167_1.leftNameTxt_.text)
				SetActive(arg_167_1.iconTrs_.gameObject, true)
				arg_167_1.iconController_:SetSelectedState("hero")

				arg_167_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_1020")

				arg_167_1.callingController_:SetSelectedState("normal")

				arg_167_1.keyicon_.color = Color.New(1, 1, 1)
				arg_167_1.icon_.color = Color.New(1, 1, 1)

				local var_170_18 = arg_167_1:GetWordFromCfg(410142041)
				local var_170_19 = arg_167_1:FormatText(var_170_18.content)

				arg_167_1.text_.text = var_170_19

				LuaForUtil.ClearLinePrefixSymbol(arg_167_1.text_)

				local var_170_20 = 24
				local var_170_21 = utf8.len(var_170_19)
				local var_170_22 = var_170_20 <= 0 and var_170_16 or var_170_16 * (var_170_21 / var_170_20)

				if var_170_22 > 0 and var_170_16 < var_170_22 then
					arg_167_1.talkMaxDuration = var_170_22

					if var_170_22 + var_170_15 > arg_167_1.duration_ then
						arg_167_1.duration_ = var_170_22 + var_170_15
					end
				end

				arg_167_1.text_.text = var_170_19
				arg_167_1.typewritter.percent = 0

				arg_167_1.typewritter:SetDirty()
				arg_167_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_410142", "410142041", "story_v_out_410142.awb") ~= 0 then
					local var_170_23 = manager.audio:GetVoiceLength("story_v_out_410142", "410142041", "story_v_out_410142.awb") / 1000

					if var_170_23 + var_170_15 > arg_167_1.duration_ then
						arg_167_1.duration_ = var_170_23 + var_170_15
					end

					if var_170_18.prefab_name ~= "" and arg_167_1.actors_[var_170_18.prefab_name] ~= nil then
						local var_170_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_167_1.actors_[var_170_18.prefab_name].transform, "story_v_out_410142", "410142041", "story_v_out_410142.awb")

						arg_167_1:RecordAudio("410142041", var_170_24)
						arg_167_1:RecordAudio("410142041", var_170_24)
					else
						arg_167_1:AudioAction("play", "voice", "story_v_out_410142", "410142041", "story_v_out_410142.awb")
					end

					arg_167_1:RecordHistoryTalkVoice("story_v_out_410142", "410142041", "story_v_out_410142.awb")
				end

				arg_167_1:RecordContent(arg_167_1.text_.text)
			end

			local var_170_25 = math.max(var_170_16, arg_167_1.talkMaxDuration)

			if var_170_15 <= arg_167_1.time_ and arg_167_1.time_ < var_170_15 + var_170_25 then
				arg_167_1.typewritter.percent = (arg_167_1.time_ - var_170_15) / var_170_25

				arg_167_1.typewritter:SetDirty()
			end

			if arg_167_1.time_ >= var_170_15 + var_170_25 and arg_167_1.time_ < var_170_15 + var_170_25 + arg_170_0 then
				arg_167_1.typewritter.percent = 1

				arg_167_1.typewritter:SetDirty()
				arg_167_1:ShowNextGo(true)
			end
		end

		arg_167_1.nodeConfigList_ = {
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

		arg_167_1:InitPlayNodeList()
	end,
	Play410142042 = function(arg_171_0, arg_171_1)
		arg_171_1.time_ = 0
		arg_171_1.frameCnt_ = 0
		arg_171_1.state_ = "playing"
		arg_171_1.curTalkId_ = 410142042
		arg_171_1.duration_ = 4.97

		local var_171_0 = {
			ja = 4.966,
			CriLanguages = 3.6,
			zh = 3.6
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
				arg_171_0:Play410142043(arg_171_1)
			end
		end

		function arg_171_1.onSingleLineUpdate_(arg_174_0)
			local var_174_0 = arg_171_1.actors_["1061"].transform
			local var_174_1 = 0

			if var_174_1 < arg_171_1.time_ and arg_171_1.time_ <= var_174_1 + arg_174_0 then
				arg_171_1.var_.moveOldPos1061 = var_174_0.localPosition
				var_174_0.localScale = Vector3.New(1, 1, 1)

				arg_171_1:CheckSpriteTmpPos("1061", 3)

				local var_174_2 = var_174_0.childCount

				for iter_174_0 = 0, var_174_2 - 1 do
					local var_174_3 = var_174_0:GetChild(iter_174_0)

					if var_174_3.name == "split_1" or not string.find(var_174_3.name, "split") then
						var_174_3.gameObject:SetActive(true)
					else
						var_174_3.gameObject:SetActive(false)
					end
				end
			end

			local var_174_4 = 0.001

			if var_174_1 <= arg_171_1.time_ and arg_171_1.time_ < var_174_1 + var_174_4 then
				local var_174_5 = (arg_171_1.time_ - var_174_1) / var_174_4
				local var_174_6 = Vector3.New(0, -490, 18)

				var_174_0.localPosition = Vector3.Lerp(arg_171_1.var_.moveOldPos1061, var_174_6, var_174_5)
			end

			if arg_171_1.time_ >= var_174_1 + var_174_4 and arg_171_1.time_ < var_174_1 + var_174_4 + arg_174_0 then
				var_174_0.localPosition = Vector3.New(0, -490, 18)
			end

			local var_174_7 = arg_171_1.actors_["1061"]
			local var_174_8 = 0

			if var_174_8 < arg_171_1.time_ and arg_171_1.time_ <= var_174_8 + arg_174_0 and not isNil(var_174_7) and arg_171_1.var_.actorSpriteComps1061 == nil then
				arg_171_1.var_.actorSpriteComps1061 = var_174_7:GetComponentsInChildren(typeof(Image), true)
			end

			local var_174_9 = 0.034

			if var_174_8 <= arg_171_1.time_ and arg_171_1.time_ < var_174_8 + var_174_9 and not isNil(var_174_7) then
				local var_174_10 = (arg_171_1.time_ - var_174_8) / var_174_9

				if arg_171_1.var_.actorSpriteComps1061 then
					for iter_174_1, iter_174_2 in pairs(arg_171_1.var_.actorSpriteComps1061:ToTable()) do
						if iter_174_2 then
							if arg_171_1.isInRecall_ then
								local var_174_11 = Mathf.Lerp(iter_174_2.color.r, arg_171_1.hightColor1.r, var_174_10)
								local var_174_12 = Mathf.Lerp(iter_174_2.color.g, arg_171_1.hightColor1.g, var_174_10)
								local var_174_13 = Mathf.Lerp(iter_174_2.color.b, arg_171_1.hightColor1.b, var_174_10)

								iter_174_2.color = Color.New(var_174_11, var_174_12, var_174_13)
							else
								local var_174_14 = Mathf.Lerp(iter_174_2.color.r, 1, var_174_10)

								iter_174_2.color = Color.New(var_174_14, var_174_14, var_174_14)
							end
						end
					end
				end
			end

			if arg_171_1.time_ >= var_174_8 + var_174_9 and arg_171_1.time_ < var_174_8 + var_174_9 + arg_174_0 and not isNil(var_174_7) and arg_171_1.var_.actorSpriteComps1061 then
				for iter_174_3, iter_174_4 in pairs(arg_171_1.var_.actorSpriteComps1061:ToTable()) do
					if iter_174_4 then
						if arg_171_1.isInRecall_ then
							iter_174_4.color = arg_171_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_174_4.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_171_1.var_.actorSpriteComps1061 = nil
			end

			local var_174_15 = 0
			local var_174_16 = 0.375

			if var_174_15 < arg_171_1.time_ and arg_171_1.time_ <= var_174_15 + arg_174_0 then
				arg_171_1.talkMaxDuration = 0
				arg_171_1.dialogCg_.alpha = 1

				arg_171_1.dialog_:SetActive(true)
				SetActive(arg_171_1.leftNameGo_, true)

				local var_174_17 = arg_171_1:FormatText(StoryNameCfg[612].name)

				arg_171_1.leftNameTxt_.text = var_174_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_171_1.leftNameTxt_.transform)

				arg_171_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_171_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_171_1:RecordName(arg_171_1.leftNameTxt_.text)
				SetActive(arg_171_1.iconTrs_.gameObject, false)
				arg_171_1.callingController_:SetSelectedState("normal")

				local var_174_18 = arg_171_1:GetWordFromCfg(410142042)
				local var_174_19 = arg_171_1:FormatText(var_174_18.content)

				arg_171_1.text_.text = var_174_19

				LuaForUtil.ClearLinePrefixSymbol(arg_171_1.text_)

				local var_174_20 = 15
				local var_174_21 = utf8.len(var_174_19)
				local var_174_22 = var_174_20 <= 0 and var_174_16 or var_174_16 * (var_174_21 / var_174_20)

				if var_174_22 > 0 and var_174_16 < var_174_22 then
					arg_171_1.talkMaxDuration = var_174_22

					if var_174_22 + var_174_15 > arg_171_1.duration_ then
						arg_171_1.duration_ = var_174_22 + var_174_15
					end
				end

				arg_171_1.text_.text = var_174_19
				arg_171_1.typewritter.percent = 0

				arg_171_1.typewritter:SetDirty()
				arg_171_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_410142", "410142042", "story_v_out_410142.awb") ~= 0 then
					local var_174_23 = manager.audio:GetVoiceLength("story_v_out_410142", "410142042", "story_v_out_410142.awb") / 1000

					if var_174_23 + var_174_15 > arg_171_1.duration_ then
						arg_171_1.duration_ = var_174_23 + var_174_15
					end

					if var_174_18.prefab_name ~= "" and arg_171_1.actors_[var_174_18.prefab_name] ~= nil then
						local var_174_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_171_1.actors_[var_174_18.prefab_name].transform, "story_v_out_410142", "410142042", "story_v_out_410142.awb")

						arg_171_1:RecordAudio("410142042", var_174_24)
						arg_171_1:RecordAudio("410142042", var_174_24)
					else
						arg_171_1:AudioAction("play", "voice", "story_v_out_410142", "410142042", "story_v_out_410142.awb")
					end

					arg_171_1:RecordHistoryTalkVoice("story_v_out_410142", "410142042", "story_v_out_410142.awb")
				end

				arg_171_1:RecordContent(arg_171_1.text_.text)
			end

			local var_174_25 = math.max(var_174_16, arg_171_1.talkMaxDuration)

			if var_174_15 <= arg_171_1.time_ and arg_171_1.time_ < var_174_15 + var_174_25 then
				arg_171_1.typewritter.percent = (arg_171_1.time_ - var_174_15) / var_174_25

				arg_171_1.typewritter:SetDirty()
			end

			if arg_171_1.time_ >= var_174_15 + var_174_25 and arg_171_1.time_ < var_174_15 + var_174_25 + arg_174_0 then
				arg_171_1.typewritter.percent = 1

				arg_171_1.typewritter:SetDirty()
				arg_171_1:ShowNextGo(true)
			end
		end

		arg_171_1.nodeConfigList_ = {
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

		arg_171_1:InitPlayNodeList()
	end,
	Play410142043 = function(arg_175_0, arg_175_1)
		arg_175_1.time_ = 0
		arg_175_1.frameCnt_ = 0
		arg_175_1.state_ = "playing"
		arg_175_1.curTalkId_ = 410142043
		arg_175_1.duration_ = 4.63

		local var_175_0 = {
			ja = 4.633,
			CriLanguages = 3.733,
			zh = 3.733
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
				arg_175_0:Play410142044(arg_175_1)
			end
		end

		function arg_175_1.onSingleLineUpdate_(arg_178_0)
			local var_178_0 = arg_175_1.actors_["1061"]
			local var_178_1 = 0

			if var_178_1 < arg_175_1.time_ and arg_175_1.time_ <= var_178_1 + arg_178_0 and not isNil(var_178_0) and arg_175_1.var_.actorSpriteComps1061 == nil then
				arg_175_1.var_.actorSpriteComps1061 = var_178_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_178_2 = 0.034

			if var_178_1 <= arg_175_1.time_ and arg_175_1.time_ < var_178_1 + var_178_2 and not isNil(var_178_0) then
				local var_178_3 = (arg_175_1.time_ - var_178_1) / var_178_2

				if arg_175_1.var_.actorSpriteComps1061 then
					for iter_178_0, iter_178_1 in pairs(arg_175_1.var_.actorSpriteComps1061:ToTable()) do
						if iter_178_1 then
							if arg_175_1.isInRecall_ then
								local var_178_4 = Mathf.Lerp(iter_178_1.color.r, arg_175_1.hightColor2.r, var_178_3)
								local var_178_5 = Mathf.Lerp(iter_178_1.color.g, arg_175_1.hightColor2.g, var_178_3)
								local var_178_6 = Mathf.Lerp(iter_178_1.color.b, arg_175_1.hightColor2.b, var_178_3)

								iter_178_1.color = Color.New(var_178_4, var_178_5, var_178_6)
							else
								local var_178_7 = Mathf.Lerp(iter_178_1.color.r, 0.5, var_178_3)

								iter_178_1.color = Color.New(var_178_7, var_178_7, var_178_7)
							end
						end
					end
				end
			end

			if arg_175_1.time_ >= var_178_1 + var_178_2 and arg_175_1.time_ < var_178_1 + var_178_2 + arg_178_0 and not isNil(var_178_0) and arg_175_1.var_.actorSpriteComps1061 then
				for iter_178_2, iter_178_3 in pairs(arg_175_1.var_.actorSpriteComps1061:ToTable()) do
					if iter_178_3 then
						if arg_175_1.isInRecall_ then
							iter_178_3.color = arg_175_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_178_3.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_175_1.var_.actorSpriteComps1061 = nil
			end

			local var_178_8 = 0
			local var_178_9 = 0.45

			if var_178_8 < arg_175_1.time_ and arg_175_1.time_ <= var_178_8 + arg_178_0 then
				arg_175_1.talkMaxDuration = 0
				arg_175_1.dialogCg_.alpha = 1

				arg_175_1.dialog_:SetActive(true)
				SetActive(arg_175_1.leftNameGo_, true)

				local var_178_10 = arg_175_1:FormatText(StoryNameCfg[613].name)

				arg_175_1.leftNameTxt_.text = var_178_10

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_175_1.leftNameTxt_.transform)

				arg_175_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_175_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_175_1:RecordName(arg_175_1.leftNameTxt_.text)
				SetActive(arg_175_1.iconTrs_.gameObject, true)
				arg_175_1.iconController_:SetSelectedState("hero")

				arg_175_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_1020")

				arg_175_1.callingController_:SetSelectedState("normal")

				arg_175_1.keyicon_.color = Color.New(1, 1, 1)
				arg_175_1.icon_.color = Color.New(1, 1, 1)

				local var_178_11 = arg_175_1:GetWordFromCfg(410142043)
				local var_178_12 = arg_175_1:FormatText(var_178_11.content)

				arg_175_1.text_.text = var_178_12

				LuaForUtil.ClearLinePrefixSymbol(arg_175_1.text_)

				local var_178_13 = 18
				local var_178_14 = utf8.len(var_178_12)
				local var_178_15 = var_178_13 <= 0 and var_178_9 or var_178_9 * (var_178_14 / var_178_13)

				if var_178_15 > 0 and var_178_9 < var_178_15 then
					arg_175_1.talkMaxDuration = var_178_15

					if var_178_15 + var_178_8 > arg_175_1.duration_ then
						arg_175_1.duration_ = var_178_15 + var_178_8
					end
				end

				arg_175_1.text_.text = var_178_12
				arg_175_1.typewritter.percent = 0

				arg_175_1.typewritter:SetDirty()
				arg_175_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_410142", "410142043", "story_v_out_410142.awb") ~= 0 then
					local var_178_16 = manager.audio:GetVoiceLength("story_v_out_410142", "410142043", "story_v_out_410142.awb") / 1000

					if var_178_16 + var_178_8 > arg_175_1.duration_ then
						arg_175_1.duration_ = var_178_16 + var_178_8
					end

					if var_178_11.prefab_name ~= "" and arg_175_1.actors_[var_178_11.prefab_name] ~= nil then
						local var_178_17 = LuaForUtil.PlayVoiceWithCriLipsync(arg_175_1.actors_[var_178_11.prefab_name].transform, "story_v_out_410142", "410142043", "story_v_out_410142.awb")

						arg_175_1:RecordAudio("410142043", var_178_17)
						arg_175_1:RecordAudio("410142043", var_178_17)
					else
						arg_175_1:AudioAction("play", "voice", "story_v_out_410142", "410142043", "story_v_out_410142.awb")
					end

					arg_175_1:RecordHistoryTalkVoice("story_v_out_410142", "410142043", "story_v_out_410142.awb")
				end

				arg_175_1:RecordContent(arg_175_1.text_.text)
			end

			local var_178_18 = math.max(var_178_9, arg_175_1.talkMaxDuration)

			if var_178_8 <= arg_175_1.time_ and arg_175_1.time_ < var_178_8 + var_178_18 then
				arg_175_1.typewritter.percent = (arg_175_1.time_ - var_178_8) / var_178_18

				arg_175_1.typewritter:SetDirty()
			end

			if arg_175_1.time_ >= var_178_8 + var_178_18 and arg_175_1.time_ < var_178_8 + var_178_18 + arg_178_0 then
				arg_175_1.typewritter.percent = 1

				arg_175_1.typewritter:SetDirty()
				arg_175_1:ShowNextGo(true)
			end
		end

		arg_175_1.nodeConfigList_ = {}

		arg_175_1:InitPlayNodeList()
	end,
	Play410142044 = function(arg_179_0, arg_179_1)
		arg_179_1.time_ = 0
		arg_179_1.frameCnt_ = 0
		arg_179_1.state_ = "playing"
		arg_179_1.curTalkId_ = 410142044
		arg_179_1.duration_ = 12.17

		local var_179_0 = {
			ja = 12.166,
			CriLanguages = 9.2,
			zh = 9.2
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
				arg_179_0:Play410142045(arg_179_1)
			end
		end

		function arg_179_1.onSingleLineUpdate_(arg_182_0)
			local var_182_0 = 0
			local var_182_1 = 0.95

			if var_182_0 < arg_179_1.time_ and arg_179_1.time_ <= var_182_0 + arg_182_0 then
				arg_179_1.talkMaxDuration = 0
				arg_179_1.dialogCg_.alpha = 1

				arg_179_1.dialog_:SetActive(true)
				SetActive(arg_179_1.leftNameGo_, true)

				local var_182_2 = arg_179_1:FormatText(StoryNameCfg[613].name)

				arg_179_1.leftNameTxt_.text = var_182_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_179_1.leftNameTxt_.transform)

				arg_179_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_179_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_179_1:RecordName(arg_179_1.leftNameTxt_.text)
				SetActive(arg_179_1.iconTrs_.gameObject, true)
				arg_179_1.iconController_:SetSelectedState("hero")

				arg_179_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_1020")

				arg_179_1.callingController_:SetSelectedState("normal")

				arg_179_1.keyicon_.color = Color.New(1, 1, 1)
				arg_179_1.icon_.color = Color.New(1, 1, 1)

				local var_182_3 = arg_179_1:GetWordFromCfg(410142044)
				local var_182_4 = arg_179_1:FormatText(var_182_3.content)

				arg_179_1.text_.text = var_182_4

				LuaForUtil.ClearLinePrefixSymbol(arg_179_1.text_)

				local var_182_5 = 38
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

				if manager.audio:GetVoiceLength("story_v_out_410142", "410142044", "story_v_out_410142.awb") ~= 0 then
					local var_182_8 = manager.audio:GetVoiceLength("story_v_out_410142", "410142044", "story_v_out_410142.awb") / 1000

					if var_182_8 + var_182_0 > arg_179_1.duration_ then
						arg_179_1.duration_ = var_182_8 + var_182_0
					end

					if var_182_3.prefab_name ~= "" and arg_179_1.actors_[var_182_3.prefab_name] ~= nil then
						local var_182_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_179_1.actors_[var_182_3.prefab_name].transform, "story_v_out_410142", "410142044", "story_v_out_410142.awb")

						arg_179_1:RecordAudio("410142044", var_182_9)
						arg_179_1:RecordAudio("410142044", var_182_9)
					else
						arg_179_1:AudioAction("play", "voice", "story_v_out_410142", "410142044", "story_v_out_410142.awb")
					end

					arg_179_1:RecordHistoryTalkVoice("story_v_out_410142", "410142044", "story_v_out_410142.awb")
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
	Play410142045 = function(arg_183_0, arg_183_1)
		arg_183_1.time_ = 0
		arg_183_1.frameCnt_ = 0
		arg_183_1.state_ = "playing"
		arg_183_1.curTalkId_ = 410142045
		arg_183_1.duration_ = 8.1

		local var_183_0 = {
			ja = 8.1,
			CriLanguages = 7.833,
			zh = 7.833
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
				arg_183_0:Play410142046(arg_183_1)
			end
		end

		function arg_183_1.onSingleLineUpdate_(arg_186_0)
			local var_186_0 = "ST65"

			if arg_183_1.bgs_[var_186_0] == nil then
				local var_186_1 = Object.Instantiate(arg_183_1.paintGo_)

				var_186_1:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. var_186_0)
				var_186_1.name = var_186_0
				var_186_1.transform.parent = arg_183_1.stage_.transform
				var_186_1.transform.localPosition = Vector3.New(0, 100, 0)
				arg_183_1.bgs_[var_186_0] = var_186_1
			end

			local var_186_2 = 2

			if var_186_2 < arg_183_1.time_ and arg_183_1.time_ <= var_186_2 + arg_186_0 then
				local var_186_3 = manager.ui.mainCamera.transform.localPosition
				local var_186_4 = Vector3.New(0, 0, 10) + Vector3.New(var_186_3.x, var_186_3.y, 0)
				local var_186_5 = arg_183_1.bgs_.ST65

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
					if iter_186_0 ~= "ST65" then
						iter_186_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_186_16 = 0

			if var_186_16 < arg_183_1.time_ and arg_183_1.time_ <= var_186_16 + arg_186_0 then
				arg_183_1.mask_.enabled = true
				arg_183_1.mask_.raycastTarget = true

				arg_183_1:SetGaussion(false)
			end

			local var_186_17 = 2

			if var_186_16 <= arg_183_1.time_ and arg_183_1.time_ < var_186_16 + var_186_17 then
				local var_186_18 = (arg_183_1.time_ - var_186_16) / var_186_17
				local var_186_19 = Color.New(0, 0, 0)

				var_186_19.a = Mathf.Lerp(0, 1, var_186_18)
				arg_183_1.mask_.color = var_186_19
			end

			if arg_183_1.time_ >= var_186_16 + var_186_17 and arg_183_1.time_ < var_186_16 + var_186_17 + arg_186_0 then
				local var_186_20 = Color.New(0, 0, 0)

				var_186_20.a = 1
				arg_183_1.mask_.color = var_186_20
			end

			local var_186_21 = 2

			if var_186_21 < arg_183_1.time_ and arg_183_1.time_ <= var_186_21 + arg_186_0 then
				arg_183_1.mask_.enabled = true
				arg_183_1.mask_.raycastTarget = true

				arg_183_1:SetGaussion(false)
			end

			local var_186_22 = 2

			if var_186_21 <= arg_183_1.time_ and arg_183_1.time_ < var_186_21 + var_186_22 then
				local var_186_23 = (arg_183_1.time_ - var_186_21) / var_186_22
				local var_186_24 = Color.New(0, 0, 0)

				var_186_24.a = Mathf.Lerp(1, 0, var_186_23)
				arg_183_1.mask_.color = var_186_24
			end

			if arg_183_1.time_ >= var_186_21 + var_186_22 and arg_183_1.time_ < var_186_21 + var_186_22 + arg_186_0 then
				local var_186_25 = Color.New(0, 0, 0)
				local var_186_26 = 0

				arg_183_1.mask_.enabled = false
				var_186_25.a = var_186_26
				arg_183_1.mask_.color = var_186_25
			end

			local var_186_27 = arg_183_1.actors_["1061"].transform
			local var_186_28 = 2

			if var_186_28 < arg_183_1.time_ and arg_183_1.time_ <= var_186_28 + arg_186_0 then
				arg_183_1.var_.moveOldPos1061 = var_186_27.localPosition
				var_186_27.localScale = Vector3.New(1, 1, 1)

				arg_183_1:CheckSpriteTmpPos("1061", 7)

				local var_186_29 = var_186_27.childCount

				for iter_186_2 = 0, var_186_29 - 1 do
					local var_186_30 = var_186_27:GetChild(iter_186_2)

					if var_186_30.name == "" or not string.find(var_186_30.name, "split") then
						var_186_30.gameObject:SetActive(true)
					else
						var_186_30.gameObject:SetActive(false)
					end
				end
			end

			local var_186_31 = 0.001

			if var_186_28 <= arg_183_1.time_ and arg_183_1.time_ < var_186_28 + var_186_31 then
				local var_186_32 = (arg_183_1.time_ - var_186_28) / var_186_31
				local var_186_33 = Vector3.New(0, -2000, 18)

				var_186_27.localPosition = Vector3.Lerp(arg_183_1.var_.moveOldPos1061, var_186_33, var_186_32)
			end

			if arg_183_1.time_ >= var_186_28 + var_186_31 and arg_183_1.time_ < var_186_28 + var_186_31 + arg_186_0 then
				var_186_27.localPosition = Vector3.New(0, -2000, 18)
			end

			local var_186_34 = arg_183_1.actors_["1056"].transform
			local var_186_35 = 4.00000000000001

			if var_186_35 < arg_183_1.time_ and arg_183_1.time_ <= var_186_35 + arg_186_0 then
				arg_183_1.var_.moveOldPos1056 = var_186_34.localPosition
				var_186_34.localScale = Vector3.New(1, 1, 1)

				arg_183_1:CheckSpriteTmpPos("1056", 3)

				local var_186_36 = var_186_34.childCount

				for iter_186_3 = 0, var_186_36 - 1 do
					local var_186_37 = var_186_34:GetChild(iter_186_3)

					if var_186_37.name == "" or not string.find(var_186_37.name, "split") then
						var_186_37.gameObject:SetActive(true)
					else
						var_186_37.gameObject:SetActive(false)
					end
				end
			end

			local var_186_38 = 0.001

			if var_186_35 <= arg_183_1.time_ and arg_183_1.time_ < var_186_35 + var_186_38 then
				local var_186_39 = (arg_183_1.time_ - var_186_35) / var_186_38
				local var_186_40 = Vector3.New(0, -350, -180)

				var_186_34.localPosition = Vector3.Lerp(arg_183_1.var_.moveOldPos1056, var_186_40, var_186_39)
			end

			if arg_183_1.time_ >= var_186_35 + var_186_38 and arg_183_1.time_ < var_186_35 + var_186_38 + arg_186_0 then
				var_186_34.localPosition = Vector3.New(0, -350, -180)
			end

			local var_186_41 = arg_183_1.actors_["1061"]
			local var_186_42 = 2

			if var_186_42 < arg_183_1.time_ and arg_183_1.time_ <= var_186_42 + arg_186_0 and not isNil(var_186_41) and arg_183_1.var_.actorSpriteComps1061 == nil then
				arg_183_1.var_.actorSpriteComps1061 = var_186_41:GetComponentsInChildren(typeof(Image), true)
			end

			local var_186_43 = 0.0339999999999945

			if var_186_42 <= arg_183_1.time_ and arg_183_1.time_ < var_186_42 + var_186_43 and not isNil(var_186_41) then
				local var_186_44 = (arg_183_1.time_ - var_186_42) / var_186_43

				if arg_183_1.var_.actorSpriteComps1061 then
					for iter_186_4, iter_186_5 in pairs(arg_183_1.var_.actorSpriteComps1061:ToTable()) do
						if iter_186_5 then
							if arg_183_1.isInRecall_ then
								local var_186_45 = Mathf.Lerp(iter_186_5.color.r, arg_183_1.hightColor2.r, var_186_44)
								local var_186_46 = Mathf.Lerp(iter_186_5.color.g, arg_183_1.hightColor2.g, var_186_44)
								local var_186_47 = Mathf.Lerp(iter_186_5.color.b, arg_183_1.hightColor2.b, var_186_44)

								iter_186_5.color = Color.New(var_186_45, var_186_46, var_186_47)
							else
								local var_186_48 = Mathf.Lerp(iter_186_5.color.r, 0.5, var_186_44)

								iter_186_5.color = Color.New(var_186_48, var_186_48, var_186_48)
							end
						end
					end
				end
			end

			if arg_183_1.time_ >= var_186_42 + var_186_43 and arg_183_1.time_ < var_186_42 + var_186_43 + arg_186_0 and not isNil(var_186_41) and arg_183_1.var_.actorSpriteComps1061 then
				for iter_186_6, iter_186_7 in pairs(arg_183_1.var_.actorSpriteComps1061:ToTable()) do
					if iter_186_7 then
						if arg_183_1.isInRecall_ then
							iter_186_7.color = arg_183_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_186_7.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_183_1.var_.actorSpriteComps1061 = nil
			end

			local var_186_49 = arg_183_1.actors_["1056"]
			local var_186_50 = 4.00000000000001

			if var_186_50 < arg_183_1.time_ and arg_183_1.time_ <= var_186_50 + arg_186_0 and not isNil(var_186_49) and arg_183_1.var_.actorSpriteComps1056 == nil then
				arg_183_1.var_.actorSpriteComps1056 = var_186_49:GetComponentsInChildren(typeof(Image), true)
			end

			local var_186_51 = 0.034

			if var_186_50 <= arg_183_1.time_ and arg_183_1.time_ < var_186_50 + var_186_51 and not isNil(var_186_49) then
				local var_186_52 = (arg_183_1.time_ - var_186_50) / var_186_51

				if arg_183_1.var_.actorSpriteComps1056 then
					for iter_186_8, iter_186_9 in pairs(arg_183_1.var_.actorSpriteComps1056:ToTable()) do
						if iter_186_9 then
							if arg_183_1.isInRecall_ then
								local var_186_53 = Mathf.Lerp(iter_186_9.color.r, arg_183_1.hightColor1.r, var_186_52)
								local var_186_54 = Mathf.Lerp(iter_186_9.color.g, arg_183_1.hightColor1.g, var_186_52)
								local var_186_55 = Mathf.Lerp(iter_186_9.color.b, arg_183_1.hightColor1.b, var_186_52)

								iter_186_9.color = Color.New(var_186_53, var_186_54, var_186_55)
							else
								local var_186_56 = Mathf.Lerp(iter_186_9.color.r, 1, var_186_52)

								iter_186_9.color = Color.New(var_186_56, var_186_56, var_186_56)
							end
						end
					end
				end
			end

			if arg_183_1.time_ >= var_186_50 + var_186_51 and arg_183_1.time_ < var_186_50 + var_186_51 + arg_186_0 and not isNil(var_186_49) and arg_183_1.var_.actorSpriteComps1056 then
				for iter_186_10, iter_186_11 in pairs(arg_183_1.var_.actorSpriteComps1056:ToTable()) do
					if iter_186_11 then
						if arg_183_1.isInRecall_ then
							iter_186_11.color = arg_183_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_186_11.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_183_1.var_.actorSpriteComps1056 = nil
			end

			if arg_183_1.frameCnt_ <= 1 then
				arg_183_1.dialog_:SetActive(false)
			end

			local var_186_57 = 4
			local var_186_58 = 0.575

			if var_186_57 < arg_183_1.time_ and arg_183_1.time_ <= var_186_57 + arg_186_0 then
				arg_183_1.talkMaxDuration = 0

				arg_183_1.dialog_:SetActive(true)

				arg_183_1.dialogCg_.alpha = 0

				local var_186_59 = LeanTween.value(arg_183_1.dialog_, 0, 1, 0.3)

				var_186_59:setOnUpdate(LuaHelper.FloatAction(function(arg_187_0)
					arg_183_1.dialogCg_.alpha = arg_187_0
				end))
				var_186_59:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_183_1.dialog_)
					var_186_59:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_183_1.duration_ = arg_183_1.duration_ + 0.3

				SetActive(arg_183_1.leftNameGo_, true)

				local var_186_60 = arg_183_1:FormatText(StoryNameCfg[605].name)

				arg_183_1.leftNameTxt_.text = var_186_60

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_183_1.leftNameTxt_.transform)

				arg_183_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_183_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_183_1:RecordName(arg_183_1.leftNameTxt_.text)
				SetActive(arg_183_1.iconTrs_.gameObject, false)
				arg_183_1.callingController_:SetSelectedState("normal")

				local var_186_61 = arg_183_1:GetWordFromCfg(410142045)
				local var_186_62 = arg_183_1:FormatText(var_186_61.content)

				arg_183_1.text_.text = var_186_62

				LuaForUtil.ClearLinePrefixSymbol(arg_183_1.text_)

				local var_186_63 = 23
				local var_186_64 = utf8.len(var_186_62)
				local var_186_65 = var_186_63 <= 0 and var_186_58 or var_186_58 * (var_186_64 / var_186_63)

				if var_186_65 > 0 and var_186_58 < var_186_65 then
					arg_183_1.talkMaxDuration = var_186_65
					var_186_57 = var_186_57 + 0.3

					if var_186_65 + var_186_57 > arg_183_1.duration_ then
						arg_183_1.duration_ = var_186_65 + var_186_57
					end
				end

				arg_183_1.text_.text = var_186_62
				arg_183_1.typewritter.percent = 0

				arg_183_1.typewritter:SetDirty()
				arg_183_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_410142", "410142045", "story_v_out_410142.awb") ~= 0 then
					local var_186_66 = manager.audio:GetVoiceLength("story_v_out_410142", "410142045", "story_v_out_410142.awb") / 1000

					if var_186_66 + var_186_57 > arg_183_1.duration_ then
						arg_183_1.duration_ = var_186_66 + var_186_57
					end

					if var_186_61.prefab_name ~= "" and arg_183_1.actors_[var_186_61.prefab_name] ~= nil then
						local var_186_67 = LuaForUtil.PlayVoiceWithCriLipsync(arg_183_1.actors_[var_186_61.prefab_name].transform, "story_v_out_410142", "410142045", "story_v_out_410142.awb")

						arg_183_1:RecordAudio("410142045", var_186_67)
						arg_183_1:RecordAudio("410142045", var_186_67)
					else
						arg_183_1:AudioAction("play", "voice", "story_v_out_410142", "410142045", "story_v_out_410142.awb")
					end

					arg_183_1:RecordHistoryTalkVoice("story_v_out_410142", "410142045", "story_v_out_410142.awb")
				end

				arg_183_1:RecordContent(arg_183_1.text_.text)
			end

			local var_186_68 = var_186_57 + 0.3
			local var_186_69 = math.max(var_186_58, arg_183_1.talkMaxDuration)

			if var_186_68 <= arg_183_1.time_ and arg_183_1.time_ < var_186_68 + var_186_69 then
				arg_183_1.typewritter.percent = (arg_183_1.time_ - var_186_68) / var_186_69

				arg_183_1.typewritter:SetDirty()
			end

			if arg_183_1.time_ >= var_186_68 + var_186_69 and arg_183_1.time_ < var_186_68 + var_186_69 + arg_186_0 then
				arg_183_1.typewritter.percent = 1

				arg_183_1.typewritter:SetDirty()
				arg_183_1:ShowNextGo(true)
			end
		end

		arg_183_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1061",
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
				startTime = 4.00000000000001,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_183_1:InitPlayNodeList()
	end,
	Play410142046 = function(arg_189_0, arg_189_1)
		arg_189_1.time_ = 0
		arg_189_1.frameCnt_ = 0
		arg_189_1.state_ = "playing"
		arg_189_1.curTalkId_ = 410142046
		arg_189_1.duration_ = 5

		SetActive(arg_189_1.tipsGo_, false)

		function arg_189_1.onSingleLineFinish_()
			arg_189_1.onSingleLineUpdate_ = nil
			arg_189_1.onSingleLineFinish_ = nil
			arg_189_1.state_ = "waiting"
		end

		function arg_189_1.playNext_(arg_191_0)
			if arg_191_0 == 1 then
				arg_189_0:Play410142047(arg_189_1)
			end
		end

		function arg_189_1.onSingleLineUpdate_(arg_192_0)
			local var_192_0 = arg_189_1.actors_["1056"].transform
			local var_192_1 = 0

			if var_192_1 < arg_189_1.time_ and arg_189_1.time_ <= var_192_1 + arg_192_0 then
				arg_189_1.var_.moveOldPos1056 = var_192_0.localPosition
				var_192_0.localScale = Vector3.New(1, 1, 1)

				arg_189_1:CheckSpriteTmpPos("1056", 4)

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
				local var_192_6 = Vector3.New(390, -350, -180)

				var_192_0.localPosition = Vector3.Lerp(arg_189_1.var_.moveOldPos1056, var_192_6, var_192_5)
			end

			if arg_189_1.time_ >= var_192_1 + var_192_4 and arg_189_1.time_ < var_192_1 + var_192_4 + arg_192_0 then
				var_192_0.localPosition = Vector3.New(390, -350, -180)
			end

			local var_192_7 = arg_189_1.actors_["1061"].transform
			local var_192_8 = 0

			if var_192_8 < arg_189_1.time_ and arg_189_1.time_ <= var_192_8 + arg_192_0 then
				arg_189_1.var_.moveOldPos1061 = var_192_7.localPosition
				var_192_7.localScale = Vector3.New(1, 1, 1)

				arg_189_1:CheckSpriteTmpPos("1061", 2)

				local var_192_9 = var_192_7.childCount

				for iter_192_1 = 0, var_192_9 - 1 do
					local var_192_10 = var_192_7:GetChild(iter_192_1)

					if var_192_10.name == "" or not string.find(var_192_10.name, "split") then
						var_192_10.gameObject:SetActive(true)
					else
						var_192_10.gameObject:SetActive(false)
					end
				end
			end

			local var_192_11 = 0.001

			if var_192_8 <= arg_189_1.time_ and arg_189_1.time_ < var_192_8 + var_192_11 then
				local var_192_12 = (arg_189_1.time_ - var_192_8) / var_192_11
				local var_192_13 = Vector3.New(-390, -490, 18)

				var_192_7.localPosition = Vector3.Lerp(arg_189_1.var_.moveOldPos1061, var_192_13, var_192_12)
			end

			if arg_189_1.time_ >= var_192_8 + var_192_11 and arg_189_1.time_ < var_192_8 + var_192_11 + arg_192_0 then
				var_192_7.localPosition = Vector3.New(-390, -490, 18)
			end

			local var_192_14 = arg_189_1.actors_["1056"]
			local var_192_15 = 0

			if var_192_15 < arg_189_1.time_ and arg_189_1.time_ <= var_192_15 + arg_192_0 and not isNil(var_192_14) and arg_189_1.var_.actorSpriteComps1056 == nil then
				arg_189_1.var_.actorSpriteComps1056 = var_192_14:GetComponentsInChildren(typeof(Image), true)
			end

			local var_192_16 = 0.034

			if var_192_15 <= arg_189_1.time_ and arg_189_1.time_ < var_192_15 + var_192_16 and not isNil(var_192_14) then
				local var_192_17 = (arg_189_1.time_ - var_192_15) / var_192_16

				if arg_189_1.var_.actorSpriteComps1056 then
					for iter_192_2, iter_192_3 in pairs(arg_189_1.var_.actorSpriteComps1056:ToTable()) do
						if iter_192_3 then
							if arg_189_1.isInRecall_ then
								local var_192_18 = Mathf.Lerp(iter_192_3.color.r, arg_189_1.hightColor2.r, var_192_17)
								local var_192_19 = Mathf.Lerp(iter_192_3.color.g, arg_189_1.hightColor2.g, var_192_17)
								local var_192_20 = Mathf.Lerp(iter_192_3.color.b, arg_189_1.hightColor2.b, var_192_17)

								iter_192_3.color = Color.New(var_192_18, var_192_19, var_192_20)
							else
								local var_192_21 = Mathf.Lerp(iter_192_3.color.r, 0.5, var_192_17)

								iter_192_3.color = Color.New(var_192_21, var_192_21, var_192_21)
							end
						end
					end
				end
			end

			if arg_189_1.time_ >= var_192_15 + var_192_16 and arg_189_1.time_ < var_192_15 + var_192_16 + arg_192_0 and not isNil(var_192_14) and arg_189_1.var_.actorSpriteComps1056 then
				for iter_192_4, iter_192_5 in pairs(arg_189_1.var_.actorSpriteComps1056:ToTable()) do
					if iter_192_5 then
						if arg_189_1.isInRecall_ then
							iter_192_5.color = arg_189_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_192_5.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_189_1.var_.actorSpriteComps1056 = nil
			end

			local var_192_22 = arg_189_1.actors_["1061"]
			local var_192_23 = 0

			if var_192_23 < arg_189_1.time_ and arg_189_1.time_ <= var_192_23 + arg_192_0 and not isNil(var_192_22) and arg_189_1.var_.actorSpriteComps1061 == nil then
				arg_189_1.var_.actorSpriteComps1061 = var_192_22:GetComponentsInChildren(typeof(Image), true)
			end

			local var_192_24 = 0.034

			if var_192_23 <= arg_189_1.time_ and arg_189_1.time_ < var_192_23 + var_192_24 and not isNil(var_192_22) then
				local var_192_25 = (arg_189_1.time_ - var_192_23) / var_192_24

				if arg_189_1.var_.actorSpriteComps1061 then
					for iter_192_6, iter_192_7 in pairs(arg_189_1.var_.actorSpriteComps1061:ToTable()) do
						if iter_192_7 then
							if arg_189_1.isInRecall_ then
								local var_192_26 = Mathf.Lerp(iter_192_7.color.r, arg_189_1.hightColor2.r, var_192_25)
								local var_192_27 = Mathf.Lerp(iter_192_7.color.g, arg_189_1.hightColor2.g, var_192_25)
								local var_192_28 = Mathf.Lerp(iter_192_7.color.b, arg_189_1.hightColor2.b, var_192_25)

								iter_192_7.color = Color.New(var_192_26, var_192_27, var_192_28)
							else
								local var_192_29 = Mathf.Lerp(iter_192_7.color.r, 0.5, var_192_25)

								iter_192_7.color = Color.New(var_192_29, var_192_29, var_192_29)
							end
						end
					end
				end
			end

			if arg_189_1.time_ >= var_192_23 + var_192_24 and arg_189_1.time_ < var_192_23 + var_192_24 + arg_192_0 and not isNil(var_192_22) and arg_189_1.var_.actorSpriteComps1061 then
				for iter_192_8, iter_192_9 in pairs(arg_189_1.var_.actorSpriteComps1061:ToTable()) do
					if iter_192_9 then
						if arg_189_1.isInRecall_ then
							iter_192_9.color = arg_189_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_192_9.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_189_1.var_.actorSpriteComps1061 = nil
			end

			local var_192_30 = 0
			local var_192_31 = 0.925

			if var_192_30 < arg_189_1.time_ and arg_189_1.time_ <= var_192_30 + arg_192_0 then
				arg_189_1.talkMaxDuration = 0
				arg_189_1.dialogCg_.alpha = 1

				arg_189_1.dialog_:SetActive(true)
				SetActive(arg_189_1.leftNameGo_, false)

				arg_189_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_189_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_189_1:RecordName(arg_189_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_189_1.iconTrs_.gameObject, false)
				arg_189_1.callingController_:SetSelectedState("normal")

				local var_192_32 = arg_189_1:GetWordFromCfg(410142046)
				local var_192_33 = arg_189_1:FormatText(var_192_32.content)

				arg_189_1.text_.text = var_192_33

				LuaForUtil.ClearLinePrefixSymbol(arg_189_1.text_)

				local var_192_34 = 37
				local var_192_35 = utf8.len(var_192_33)
				local var_192_36 = var_192_34 <= 0 and var_192_31 or var_192_31 * (var_192_35 / var_192_34)

				if var_192_36 > 0 and var_192_31 < var_192_36 then
					arg_189_1.talkMaxDuration = var_192_36

					if var_192_36 + var_192_30 > arg_189_1.duration_ then
						arg_189_1.duration_ = var_192_36 + var_192_30
					end
				end

				arg_189_1.text_.text = var_192_33
				arg_189_1.typewritter.percent = 0

				arg_189_1.typewritter:SetDirty()
				arg_189_1:ShowNextGo(false)
				arg_189_1:RecordContent(arg_189_1.text_.text)
			end

			local var_192_37 = math.max(var_192_31, arg_189_1.talkMaxDuration)

			if var_192_30 <= arg_189_1.time_ and arg_189_1.time_ < var_192_30 + var_192_37 then
				arg_189_1.typewritter.percent = (arg_189_1.time_ - var_192_30) / var_192_37

				arg_189_1.typewritter:SetDirty()
			end

			if arg_189_1.time_ >= var_192_30 + var_192_37 and arg_189_1.time_ < var_192_30 + var_192_37 + arg_192_0 then
				arg_189_1.typewritter.percent = 1

				arg_189_1.typewritter:SetDirty()
				arg_189_1:ShowNextGo(true)
			end
		end

		arg_189_1.nodeConfigList_ = {
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
				actorName = "1061",
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
	Play410142047 = function(arg_193_0, arg_193_1)
		arg_193_1.time_ = 0
		arg_193_1.frameCnt_ = 0
		arg_193_1.state_ = "playing"
		arg_193_1.curTalkId_ = 410142047
		arg_193_1.duration_ = 2.37

		local var_193_0 = {
			ja = 2.366,
			CriLanguages = 2.033,
			zh = 2.033
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
				arg_193_0:Play410142048(arg_193_1)
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

					if var_196_3.name == "split_3" or not string.find(var_196_3.name, "split") then
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

			local var_196_15 = 0
			local var_196_16 = 0.15

			if var_196_15 < arg_193_1.time_ and arg_193_1.time_ <= var_196_15 + arg_196_0 then
				arg_193_1.talkMaxDuration = 0
				arg_193_1.dialogCg_.alpha = 1

				arg_193_1.dialog_:SetActive(true)
				SetActive(arg_193_1.leftNameGo_, true)

				local var_196_17 = arg_193_1:FormatText(StoryNameCfg[605].name)

				arg_193_1.leftNameTxt_.text = var_196_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_193_1.leftNameTxt_.transform)

				arg_193_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_193_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_193_1:RecordName(arg_193_1.leftNameTxt_.text)
				SetActive(arg_193_1.iconTrs_.gameObject, false)
				arg_193_1.callingController_:SetSelectedState("normal")

				local var_196_18 = arg_193_1:GetWordFromCfg(410142047)
				local var_196_19 = arg_193_1:FormatText(var_196_18.content)

				arg_193_1.text_.text = var_196_19

				LuaForUtil.ClearLinePrefixSymbol(arg_193_1.text_)

				local var_196_20 = 6
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

				if manager.audio:GetVoiceLength("story_v_out_410142", "410142047", "story_v_out_410142.awb") ~= 0 then
					local var_196_23 = manager.audio:GetVoiceLength("story_v_out_410142", "410142047", "story_v_out_410142.awb") / 1000

					if var_196_23 + var_196_15 > arg_193_1.duration_ then
						arg_193_1.duration_ = var_196_23 + var_196_15
					end

					if var_196_18.prefab_name ~= "" and arg_193_1.actors_[var_196_18.prefab_name] ~= nil then
						local var_196_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_193_1.actors_[var_196_18.prefab_name].transform, "story_v_out_410142", "410142047", "story_v_out_410142.awb")

						arg_193_1:RecordAudio("410142047", var_196_24)
						arg_193_1:RecordAudio("410142047", var_196_24)
					else
						arg_193_1:AudioAction("play", "voice", "story_v_out_410142", "410142047", "story_v_out_410142.awb")
					end

					arg_193_1:RecordHistoryTalkVoice("story_v_out_410142", "410142047", "story_v_out_410142.awb")
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
	Play410142048 = function(arg_197_0, arg_197_1)
		arg_197_1.time_ = 0
		arg_197_1.frameCnt_ = 0
		arg_197_1.state_ = "playing"
		arg_197_1.curTalkId_ = 410142048
		arg_197_1.duration_ = 4.1

		local var_197_0 = {
			ja = 4.1,
			CriLanguages = 1.2,
			zh = 1.2
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
				arg_197_0:Play410142049(arg_197_1)
			end
		end

		function arg_197_1.onSingleLineUpdate_(arg_200_0)
			local var_200_0 = arg_197_1.actors_["1061"].transform
			local var_200_1 = 0

			if var_200_1 < arg_197_1.time_ and arg_197_1.time_ <= var_200_1 + arg_200_0 then
				arg_197_1.var_.moveOldPos1061 = var_200_0.localPosition
				var_200_0.localScale = Vector3.New(1, 1, 1)

				arg_197_1:CheckSpriteTmpPos("1061", 2)

				local var_200_2 = var_200_0.childCount

				for iter_200_0 = 0, var_200_2 - 1 do
					local var_200_3 = var_200_0:GetChild(iter_200_0)

					if var_200_3.name == "split_5" or not string.find(var_200_3.name, "split") then
						var_200_3.gameObject:SetActive(true)
					else
						var_200_3.gameObject:SetActive(false)
					end
				end
			end

			local var_200_4 = 0.001

			if var_200_1 <= arg_197_1.time_ and arg_197_1.time_ < var_200_1 + var_200_4 then
				local var_200_5 = (arg_197_1.time_ - var_200_1) / var_200_4
				local var_200_6 = Vector3.New(-390, -490, 18)

				var_200_0.localPosition = Vector3.Lerp(arg_197_1.var_.moveOldPos1061, var_200_6, var_200_5)
			end

			if arg_197_1.time_ >= var_200_1 + var_200_4 and arg_197_1.time_ < var_200_1 + var_200_4 + arg_200_0 then
				var_200_0.localPosition = Vector3.New(-390, -490, 18)
			end

			local var_200_7 = arg_197_1.actors_["1061"]
			local var_200_8 = 0

			if var_200_8 < arg_197_1.time_ and arg_197_1.time_ <= var_200_8 + arg_200_0 and not isNil(var_200_7) and arg_197_1.var_.actorSpriteComps1061 == nil then
				arg_197_1.var_.actorSpriteComps1061 = var_200_7:GetComponentsInChildren(typeof(Image), true)
			end

			local var_200_9 = 0.034

			if var_200_8 <= arg_197_1.time_ and arg_197_1.time_ < var_200_8 + var_200_9 and not isNil(var_200_7) then
				local var_200_10 = (arg_197_1.time_ - var_200_8) / var_200_9

				if arg_197_1.var_.actorSpriteComps1061 then
					for iter_200_1, iter_200_2 in pairs(arg_197_1.var_.actorSpriteComps1061:ToTable()) do
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

			if arg_197_1.time_ >= var_200_8 + var_200_9 and arg_197_1.time_ < var_200_8 + var_200_9 + arg_200_0 and not isNil(var_200_7) and arg_197_1.var_.actorSpriteComps1061 then
				for iter_200_3, iter_200_4 in pairs(arg_197_1.var_.actorSpriteComps1061:ToTable()) do
					if iter_200_4 then
						if arg_197_1.isInRecall_ then
							iter_200_4.color = arg_197_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_200_4.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_197_1.var_.actorSpriteComps1061 = nil
			end

			local var_200_15 = arg_197_1.actors_["1056"]
			local var_200_16 = 0

			if var_200_16 < arg_197_1.time_ and arg_197_1.time_ <= var_200_16 + arg_200_0 and not isNil(var_200_15) and arg_197_1.var_.actorSpriteComps1056 == nil then
				arg_197_1.var_.actorSpriteComps1056 = var_200_15:GetComponentsInChildren(typeof(Image), true)
			end

			local var_200_17 = 0.034

			if var_200_16 <= arg_197_1.time_ and arg_197_1.time_ < var_200_16 + var_200_17 and not isNil(var_200_15) then
				local var_200_18 = (arg_197_1.time_ - var_200_16) / var_200_17

				if arg_197_1.var_.actorSpriteComps1056 then
					for iter_200_5, iter_200_6 in pairs(arg_197_1.var_.actorSpriteComps1056:ToTable()) do
						if iter_200_6 then
							if arg_197_1.isInRecall_ then
								local var_200_19 = Mathf.Lerp(iter_200_6.color.r, arg_197_1.hightColor2.r, var_200_18)
								local var_200_20 = Mathf.Lerp(iter_200_6.color.g, arg_197_1.hightColor2.g, var_200_18)
								local var_200_21 = Mathf.Lerp(iter_200_6.color.b, arg_197_1.hightColor2.b, var_200_18)

								iter_200_6.color = Color.New(var_200_19, var_200_20, var_200_21)
							else
								local var_200_22 = Mathf.Lerp(iter_200_6.color.r, 0.5, var_200_18)

								iter_200_6.color = Color.New(var_200_22, var_200_22, var_200_22)
							end
						end
					end
				end
			end

			if arg_197_1.time_ >= var_200_16 + var_200_17 and arg_197_1.time_ < var_200_16 + var_200_17 + arg_200_0 and not isNil(var_200_15) and arg_197_1.var_.actorSpriteComps1056 then
				for iter_200_7, iter_200_8 in pairs(arg_197_1.var_.actorSpriteComps1056:ToTable()) do
					if iter_200_8 then
						if arg_197_1.isInRecall_ then
							iter_200_8.color = arg_197_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_200_8.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_197_1.var_.actorSpriteComps1056 = nil
			end

			local var_200_23 = 0
			local var_200_24 = 0.075

			if var_200_23 < arg_197_1.time_ and arg_197_1.time_ <= var_200_23 + arg_200_0 then
				arg_197_1.talkMaxDuration = 0
				arg_197_1.dialogCg_.alpha = 1

				arg_197_1.dialog_:SetActive(true)
				SetActive(arg_197_1.leftNameGo_, true)

				local var_200_25 = arg_197_1:FormatText(StoryNameCfg[612].name)

				arg_197_1.leftNameTxt_.text = var_200_25

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_197_1.leftNameTxt_.transform)

				arg_197_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_197_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_197_1:RecordName(arg_197_1.leftNameTxt_.text)
				SetActive(arg_197_1.iconTrs_.gameObject, false)
				arg_197_1.callingController_:SetSelectedState("normal")

				local var_200_26 = arg_197_1:GetWordFromCfg(410142048)
				local var_200_27 = arg_197_1:FormatText(var_200_26.content)

				arg_197_1.text_.text = var_200_27

				LuaForUtil.ClearLinePrefixSymbol(arg_197_1.text_)

				local var_200_28 = 3
				local var_200_29 = utf8.len(var_200_27)
				local var_200_30 = var_200_28 <= 0 and var_200_24 or var_200_24 * (var_200_29 / var_200_28)

				if var_200_30 > 0 and var_200_24 < var_200_30 then
					arg_197_1.talkMaxDuration = var_200_30

					if var_200_30 + var_200_23 > arg_197_1.duration_ then
						arg_197_1.duration_ = var_200_30 + var_200_23
					end
				end

				arg_197_1.text_.text = var_200_27
				arg_197_1.typewritter.percent = 0

				arg_197_1.typewritter:SetDirty()
				arg_197_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_410142", "410142048", "story_v_out_410142.awb") ~= 0 then
					local var_200_31 = manager.audio:GetVoiceLength("story_v_out_410142", "410142048", "story_v_out_410142.awb") / 1000

					if var_200_31 + var_200_23 > arg_197_1.duration_ then
						arg_197_1.duration_ = var_200_31 + var_200_23
					end

					if var_200_26.prefab_name ~= "" and arg_197_1.actors_[var_200_26.prefab_name] ~= nil then
						local var_200_32 = LuaForUtil.PlayVoiceWithCriLipsync(arg_197_1.actors_[var_200_26.prefab_name].transform, "story_v_out_410142", "410142048", "story_v_out_410142.awb")

						arg_197_1:RecordAudio("410142048", var_200_32)
						arg_197_1:RecordAudio("410142048", var_200_32)
					else
						arg_197_1:AudioAction("play", "voice", "story_v_out_410142", "410142048", "story_v_out_410142.awb")
					end

					arg_197_1:RecordHistoryTalkVoice("story_v_out_410142", "410142048", "story_v_out_410142.awb")
				end

				arg_197_1:RecordContent(arg_197_1.text_.text)
			end

			local var_200_33 = math.max(var_200_24, arg_197_1.talkMaxDuration)

			if var_200_23 <= arg_197_1.time_ and arg_197_1.time_ < var_200_23 + var_200_33 then
				arg_197_1.typewritter.percent = (arg_197_1.time_ - var_200_23) / var_200_33

				arg_197_1.typewritter:SetDirty()
			end

			if arg_197_1.time_ >= var_200_23 + var_200_33 and arg_197_1.time_ < var_200_23 + var_200_33 + arg_200_0 then
				arg_197_1.typewritter.percent = 1

				arg_197_1.typewritter:SetDirty()
				arg_197_1:ShowNextGo(true)
			end
		end

		arg_197_1.nodeConfigList_ = {
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

		arg_197_1:InitPlayNodeList()
	end,
	Play410142049 = function(arg_201_0, arg_201_1)
		arg_201_1.time_ = 0
		arg_201_1.frameCnt_ = 0
		arg_201_1.state_ = "playing"
		arg_201_1.curTalkId_ = 410142049
		arg_201_1.duration_ = 5.67

		local var_201_0 = {
			ja = 5.666,
			CriLanguages = 2,
			zh = 2
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
				arg_201_0:Play410142050(arg_201_1)
			end
		end

		function arg_201_1.onSingleLineUpdate_(arg_204_0)
			local var_204_0 = arg_201_1.actors_["1056"].transform
			local var_204_1 = 0

			if var_204_1 < arg_201_1.time_ and arg_201_1.time_ <= var_204_1 + arg_204_0 then
				arg_201_1.var_.moveOldPos1056 = var_204_0.localPosition
				var_204_0.localScale = Vector3.New(1, 1, 1)

				arg_201_1:CheckSpriteTmpPos("1056", 4)

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
				local var_204_6 = Vector3.New(390, -350, -180)

				var_204_0.localPosition = Vector3.Lerp(arg_201_1.var_.moveOldPos1056, var_204_6, var_204_5)
			end

			if arg_201_1.time_ >= var_204_1 + var_204_4 and arg_201_1.time_ < var_204_1 + var_204_4 + arg_204_0 then
				var_204_0.localPosition = Vector3.New(390, -350, -180)
			end

			local var_204_7 = arg_201_1.actors_["1056"]
			local var_204_8 = 0

			if var_204_8 < arg_201_1.time_ and arg_201_1.time_ <= var_204_8 + arg_204_0 and not isNil(var_204_7) and arg_201_1.var_.actorSpriteComps1056 == nil then
				arg_201_1.var_.actorSpriteComps1056 = var_204_7:GetComponentsInChildren(typeof(Image), true)
			end

			local var_204_9 = 0.034

			if var_204_8 <= arg_201_1.time_ and arg_201_1.time_ < var_204_8 + var_204_9 and not isNil(var_204_7) then
				local var_204_10 = (arg_201_1.time_ - var_204_8) / var_204_9

				if arg_201_1.var_.actorSpriteComps1056 then
					for iter_204_1, iter_204_2 in pairs(arg_201_1.var_.actorSpriteComps1056:ToTable()) do
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

			if arg_201_1.time_ >= var_204_8 + var_204_9 and arg_201_1.time_ < var_204_8 + var_204_9 + arg_204_0 and not isNil(var_204_7) and arg_201_1.var_.actorSpriteComps1056 then
				for iter_204_3, iter_204_4 in pairs(arg_201_1.var_.actorSpriteComps1056:ToTable()) do
					if iter_204_4 then
						if arg_201_1.isInRecall_ then
							iter_204_4.color = arg_201_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_204_4.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_201_1.var_.actorSpriteComps1056 = nil
			end

			local var_204_15 = arg_201_1.actors_["1061"]
			local var_204_16 = 0

			if var_204_16 < arg_201_1.time_ and arg_201_1.time_ <= var_204_16 + arg_204_0 and not isNil(var_204_15) and arg_201_1.var_.actorSpriteComps1061 == nil then
				arg_201_1.var_.actorSpriteComps1061 = var_204_15:GetComponentsInChildren(typeof(Image), true)
			end

			local var_204_17 = 0.034

			if var_204_16 <= arg_201_1.time_ and arg_201_1.time_ < var_204_16 + var_204_17 and not isNil(var_204_15) then
				local var_204_18 = (arg_201_1.time_ - var_204_16) / var_204_17

				if arg_201_1.var_.actorSpriteComps1061 then
					for iter_204_5, iter_204_6 in pairs(arg_201_1.var_.actorSpriteComps1061:ToTable()) do
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

			if arg_201_1.time_ >= var_204_16 + var_204_17 and arg_201_1.time_ < var_204_16 + var_204_17 + arg_204_0 and not isNil(var_204_15) and arg_201_1.var_.actorSpriteComps1061 then
				for iter_204_7, iter_204_8 in pairs(arg_201_1.var_.actorSpriteComps1061:ToTable()) do
					if iter_204_8 then
						if arg_201_1.isInRecall_ then
							iter_204_8.color = arg_201_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_204_8.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_201_1.var_.actorSpriteComps1061 = nil
			end

			local var_204_23 = 0
			local var_204_24 = 0.15

			if var_204_23 < arg_201_1.time_ and arg_201_1.time_ <= var_204_23 + arg_204_0 then
				arg_201_1.talkMaxDuration = 0
				arg_201_1.dialogCg_.alpha = 1

				arg_201_1.dialog_:SetActive(true)
				SetActive(arg_201_1.leftNameGo_, true)

				local var_204_25 = arg_201_1:FormatText(StoryNameCfg[605].name)

				arg_201_1.leftNameTxt_.text = var_204_25

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_201_1.leftNameTxt_.transform)

				arg_201_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_201_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_201_1:RecordName(arg_201_1.leftNameTxt_.text)
				SetActive(arg_201_1.iconTrs_.gameObject, false)
				arg_201_1.callingController_:SetSelectedState("normal")

				local var_204_26 = arg_201_1:GetWordFromCfg(410142049)
				local var_204_27 = arg_201_1:FormatText(var_204_26.content)

				arg_201_1.text_.text = var_204_27

				LuaForUtil.ClearLinePrefixSymbol(arg_201_1.text_)

				local var_204_28 = 6
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

				if manager.audio:GetVoiceLength("story_v_out_410142", "410142049", "story_v_out_410142.awb") ~= 0 then
					local var_204_31 = manager.audio:GetVoiceLength("story_v_out_410142", "410142049", "story_v_out_410142.awb") / 1000

					if var_204_31 + var_204_23 > arg_201_1.duration_ then
						arg_201_1.duration_ = var_204_31 + var_204_23
					end

					if var_204_26.prefab_name ~= "" and arg_201_1.actors_[var_204_26.prefab_name] ~= nil then
						local var_204_32 = LuaForUtil.PlayVoiceWithCriLipsync(arg_201_1.actors_[var_204_26.prefab_name].transform, "story_v_out_410142", "410142049", "story_v_out_410142.awb")

						arg_201_1:RecordAudio("410142049", var_204_32)
						arg_201_1:RecordAudio("410142049", var_204_32)
					else
						arg_201_1:AudioAction("play", "voice", "story_v_out_410142", "410142049", "story_v_out_410142.awb")
					end

					arg_201_1:RecordHistoryTalkVoice("story_v_out_410142", "410142049", "story_v_out_410142.awb")
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
				actorName = "1056",
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
	Play410142050 = function(arg_205_0, arg_205_1)
		arg_205_1.time_ = 0
		arg_205_1.frameCnt_ = 0
		arg_205_1.state_ = "playing"
		arg_205_1.curTalkId_ = 410142050
		arg_205_1.duration_ = 7.07

		local var_205_0 = {
			ja = 7.066,
			CriLanguages = 3.966,
			zh = 3.966
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
				arg_205_0:Play410142051(arg_205_1)
			end
		end

		function arg_205_1.onSingleLineUpdate_(arg_208_0)
			local var_208_0 = arg_205_1.actors_["1061"].transform
			local var_208_1 = 0

			if var_208_1 < arg_205_1.time_ and arg_205_1.time_ <= var_208_1 + arg_208_0 then
				arg_205_1.var_.moveOldPos1061 = var_208_0.localPosition
				var_208_0.localScale = Vector3.New(1, 1, 1)

				arg_205_1:CheckSpriteTmpPos("1061", 2)

				local var_208_2 = var_208_0.childCount

				for iter_208_0 = 0, var_208_2 - 1 do
					local var_208_3 = var_208_0:GetChild(iter_208_0)

					if var_208_3.name == "split_7" or not string.find(var_208_3.name, "split") then
						var_208_3.gameObject:SetActive(true)
					else
						var_208_3.gameObject:SetActive(false)
					end
				end
			end

			local var_208_4 = 0.001

			if var_208_1 <= arg_205_1.time_ and arg_205_1.time_ < var_208_1 + var_208_4 then
				local var_208_5 = (arg_205_1.time_ - var_208_1) / var_208_4
				local var_208_6 = Vector3.New(-390, -490, 18)

				var_208_0.localPosition = Vector3.Lerp(arg_205_1.var_.moveOldPos1061, var_208_6, var_208_5)
			end

			if arg_205_1.time_ >= var_208_1 + var_208_4 and arg_205_1.time_ < var_208_1 + var_208_4 + arg_208_0 then
				var_208_0.localPosition = Vector3.New(-390, -490, 18)
			end

			local var_208_7 = arg_205_1.actors_["1061"]
			local var_208_8 = 0

			if var_208_8 < arg_205_1.time_ and arg_205_1.time_ <= var_208_8 + arg_208_0 and not isNil(var_208_7) and arg_205_1.var_.actorSpriteComps1061 == nil then
				arg_205_1.var_.actorSpriteComps1061 = var_208_7:GetComponentsInChildren(typeof(Image), true)
			end

			local var_208_9 = 0.034

			if var_208_8 <= arg_205_1.time_ and arg_205_1.time_ < var_208_8 + var_208_9 and not isNil(var_208_7) then
				local var_208_10 = (arg_205_1.time_ - var_208_8) / var_208_9

				if arg_205_1.var_.actorSpriteComps1061 then
					for iter_208_1, iter_208_2 in pairs(arg_205_1.var_.actorSpriteComps1061:ToTable()) do
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

			if arg_205_1.time_ >= var_208_8 + var_208_9 and arg_205_1.time_ < var_208_8 + var_208_9 + arg_208_0 and not isNil(var_208_7) and arg_205_1.var_.actorSpriteComps1061 then
				for iter_208_3, iter_208_4 in pairs(arg_205_1.var_.actorSpriteComps1061:ToTable()) do
					if iter_208_4 then
						if arg_205_1.isInRecall_ then
							iter_208_4.color = arg_205_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_208_4.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_205_1.var_.actorSpriteComps1061 = nil
			end

			local var_208_15 = arg_205_1.actors_["1056"]
			local var_208_16 = 0

			if var_208_16 < arg_205_1.time_ and arg_205_1.time_ <= var_208_16 + arg_208_0 and not isNil(var_208_15) and arg_205_1.var_.actorSpriteComps1056 == nil then
				arg_205_1.var_.actorSpriteComps1056 = var_208_15:GetComponentsInChildren(typeof(Image), true)
			end

			local var_208_17 = 0.034

			if var_208_16 <= arg_205_1.time_ and arg_205_1.time_ < var_208_16 + var_208_17 and not isNil(var_208_15) then
				local var_208_18 = (arg_205_1.time_ - var_208_16) / var_208_17

				if arg_205_1.var_.actorSpriteComps1056 then
					for iter_208_5, iter_208_6 in pairs(arg_205_1.var_.actorSpriteComps1056:ToTable()) do
						if iter_208_6 then
							if arg_205_1.isInRecall_ then
								local var_208_19 = Mathf.Lerp(iter_208_6.color.r, arg_205_1.hightColor2.r, var_208_18)
								local var_208_20 = Mathf.Lerp(iter_208_6.color.g, arg_205_1.hightColor2.g, var_208_18)
								local var_208_21 = Mathf.Lerp(iter_208_6.color.b, arg_205_1.hightColor2.b, var_208_18)

								iter_208_6.color = Color.New(var_208_19, var_208_20, var_208_21)
							else
								local var_208_22 = Mathf.Lerp(iter_208_6.color.r, 0.5, var_208_18)

								iter_208_6.color = Color.New(var_208_22, var_208_22, var_208_22)
							end
						end
					end
				end
			end

			if arg_205_1.time_ >= var_208_16 + var_208_17 and arg_205_1.time_ < var_208_16 + var_208_17 + arg_208_0 and not isNil(var_208_15) and arg_205_1.var_.actorSpriteComps1056 then
				for iter_208_7, iter_208_8 in pairs(arg_205_1.var_.actorSpriteComps1056:ToTable()) do
					if iter_208_8 then
						if arg_205_1.isInRecall_ then
							iter_208_8.color = arg_205_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_208_8.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_205_1.var_.actorSpriteComps1056 = nil
			end

			local var_208_23 = 0
			local var_208_24 = 0.5

			if var_208_23 < arg_205_1.time_ and arg_205_1.time_ <= var_208_23 + arg_208_0 then
				arg_205_1.talkMaxDuration = 0
				arg_205_1.dialogCg_.alpha = 1

				arg_205_1.dialog_:SetActive(true)
				SetActive(arg_205_1.leftNameGo_, true)

				local var_208_25 = arg_205_1:FormatText(StoryNameCfg[612].name)

				arg_205_1.leftNameTxt_.text = var_208_25

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_205_1.leftNameTxt_.transform)

				arg_205_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_205_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_205_1:RecordName(arg_205_1.leftNameTxt_.text)
				SetActive(arg_205_1.iconTrs_.gameObject, false)
				arg_205_1.callingController_:SetSelectedState("normal")

				local var_208_26 = arg_205_1:GetWordFromCfg(410142050)
				local var_208_27 = arg_205_1:FormatText(var_208_26.content)

				arg_205_1.text_.text = var_208_27

				LuaForUtil.ClearLinePrefixSymbol(arg_205_1.text_)

				local var_208_28 = 20
				local var_208_29 = utf8.len(var_208_27)
				local var_208_30 = var_208_28 <= 0 and var_208_24 or var_208_24 * (var_208_29 / var_208_28)

				if var_208_30 > 0 and var_208_24 < var_208_30 then
					arg_205_1.talkMaxDuration = var_208_30

					if var_208_30 + var_208_23 > arg_205_1.duration_ then
						arg_205_1.duration_ = var_208_30 + var_208_23
					end
				end

				arg_205_1.text_.text = var_208_27
				arg_205_1.typewritter.percent = 0

				arg_205_1.typewritter:SetDirty()
				arg_205_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_410142", "410142050", "story_v_out_410142.awb") ~= 0 then
					local var_208_31 = manager.audio:GetVoiceLength("story_v_out_410142", "410142050", "story_v_out_410142.awb") / 1000

					if var_208_31 + var_208_23 > arg_205_1.duration_ then
						arg_205_1.duration_ = var_208_31 + var_208_23
					end

					if var_208_26.prefab_name ~= "" and arg_205_1.actors_[var_208_26.prefab_name] ~= nil then
						local var_208_32 = LuaForUtil.PlayVoiceWithCriLipsync(arg_205_1.actors_[var_208_26.prefab_name].transform, "story_v_out_410142", "410142050", "story_v_out_410142.awb")

						arg_205_1:RecordAudio("410142050", var_208_32)
						arg_205_1:RecordAudio("410142050", var_208_32)
					else
						arg_205_1:AudioAction("play", "voice", "story_v_out_410142", "410142050", "story_v_out_410142.awb")
					end

					arg_205_1:RecordHistoryTalkVoice("story_v_out_410142", "410142050", "story_v_out_410142.awb")
				end

				arg_205_1:RecordContent(arg_205_1.text_.text)
			end

			local var_208_33 = math.max(var_208_24, arg_205_1.talkMaxDuration)

			if var_208_23 <= arg_205_1.time_ and arg_205_1.time_ < var_208_23 + var_208_33 then
				arg_205_1.typewritter.percent = (arg_205_1.time_ - var_208_23) / var_208_33

				arg_205_1.typewritter:SetDirty()
			end

			if arg_205_1.time_ >= var_208_23 + var_208_33 and arg_205_1.time_ < var_208_23 + var_208_33 + arg_208_0 then
				arg_205_1.typewritter.percent = 1

				arg_205_1.typewritter:SetDirty()
				arg_205_1:ShowNextGo(true)
			end
		end

		arg_205_1.nodeConfigList_ = {
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

		arg_205_1:InitPlayNodeList()
	end,
	Play410142051 = function(arg_209_0, arg_209_1)
		arg_209_1.time_ = 0
		arg_209_1.frameCnt_ = 0
		arg_209_1.state_ = "playing"
		arg_209_1.curTalkId_ = 410142051
		arg_209_1.duration_ = 11.03

		local var_209_0 = {
			ja = 7.766,
			CriLanguages = 11.033,
			zh = 11.033
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
				arg_209_0:Play410142052(arg_209_1)
			end
		end

		function arg_209_1.onSingleLineUpdate_(arg_212_0)
			local var_212_0 = arg_209_1.actors_["1061"].transform
			local var_212_1 = 0

			if var_212_1 < arg_209_1.time_ and arg_209_1.time_ <= var_212_1 + arg_212_0 then
				arg_209_1.var_.moveOldPos1061 = var_212_0.localPosition
				var_212_0.localScale = Vector3.New(1, 1, 1)

				arg_209_1:CheckSpriteTmpPos("1061", 2)

				local var_212_2 = var_212_0.childCount

				for iter_212_0 = 0, var_212_2 - 1 do
					local var_212_3 = var_212_0:GetChild(iter_212_0)

					if var_212_3.name == "split_7" or not string.find(var_212_3.name, "split") then
						var_212_3.gameObject:SetActive(true)
					else
						var_212_3.gameObject:SetActive(false)
					end
				end
			end

			local var_212_4 = 0.001

			if var_212_1 <= arg_209_1.time_ and arg_209_1.time_ < var_212_1 + var_212_4 then
				local var_212_5 = (arg_209_1.time_ - var_212_1) / var_212_4
				local var_212_6 = Vector3.New(-390, -490, 18)

				var_212_0.localPosition = Vector3.Lerp(arg_209_1.var_.moveOldPos1061, var_212_6, var_212_5)
			end

			if arg_209_1.time_ >= var_212_1 + var_212_4 and arg_209_1.time_ < var_212_1 + var_212_4 + arg_212_0 then
				var_212_0.localPosition = Vector3.New(-390, -490, 18)
			end

			local var_212_7 = arg_209_1.actors_["1061"]
			local var_212_8 = 0

			if var_212_8 < arg_209_1.time_ and arg_209_1.time_ <= var_212_8 + arg_212_0 and not isNil(var_212_7) and arg_209_1.var_.actorSpriteComps1061 == nil then
				arg_209_1.var_.actorSpriteComps1061 = var_212_7:GetComponentsInChildren(typeof(Image), true)
			end

			local var_212_9 = 0.034

			if var_212_8 <= arg_209_1.time_ and arg_209_1.time_ < var_212_8 + var_212_9 and not isNil(var_212_7) then
				local var_212_10 = (arg_209_1.time_ - var_212_8) / var_212_9

				if arg_209_1.var_.actorSpriteComps1061 then
					for iter_212_1, iter_212_2 in pairs(arg_209_1.var_.actorSpriteComps1061:ToTable()) do
						if iter_212_2 then
							if arg_209_1.isInRecall_ then
								local var_212_11 = Mathf.Lerp(iter_212_2.color.r, arg_209_1.hightColor1.r, var_212_10)
								local var_212_12 = Mathf.Lerp(iter_212_2.color.g, arg_209_1.hightColor1.g, var_212_10)
								local var_212_13 = Mathf.Lerp(iter_212_2.color.b, arg_209_1.hightColor1.b, var_212_10)

								iter_212_2.color = Color.New(var_212_11, var_212_12, var_212_13)
							else
								local var_212_14 = Mathf.Lerp(iter_212_2.color.r, 1, var_212_10)

								iter_212_2.color = Color.New(var_212_14, var_212_14, var_212_14)
							end
						end
					end
				end
			end

			if arg_209_1.time_ >= var_212_8 + var_212_9 and arg_209_1.time_ < var_212_8 + var_212_9 + arg_212_0 and not isNil(var_212_7) and arg_209_1.var_.actorSpriteComps1061 then
				for iter_212_3, iter_212_4 in pairs(arg_209_1.var_.actorSpriteComps1061:ToTable()) do
					if iter_212_4 then
						if arg_209_1.isInRecall_ then
							iter_212_4.color = arg_209_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_212_4.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_209_1.var_.actorSpriteComps1061 = nil
			end

			local var_212_15 = 0
			local var_212_16 = 1.175

			if var_212_15 < arg_209_1.time_ and arg_209_1.time_ <= var_212_15 + arg_212_0 then
				arg_209_1.talkMaxDuration = 0
				arg_209_1.dialogCg_.alpha = 1

				arg_209_1.dialog_:SetActive(true)
				SetActive(arg_209_1.leftNameGo_, true)

				local var_212_17 = arg_209_1:FormatText(StoryNameCfg[612].name)

				arg_209_1.leftNameTxt_.text = var_212_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_209_1.leftNameTxt_.transform)

				arg_209_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_209_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_209_1:RecordName(arg_209_1.leftNameTxt_.text)
				SetActive(arg_209_1.iconTrs_.gameObject, false)
				arg_209_1.callingController_:SetSelectedState("normal")

				local var_212_18 = arg_209_1:GetWordFromCfg(410142051)
				local var_212_19 = arg_209_1:FormatText(var_212_18.content)

				arg_209_1.text_.text = var_212_19

				LuaForUtil.ClearLinePrefixSymbol(arg_209_1.text_)

				local var_212_20 = 47
				local var_212_21 = utf8.len(var_212_19)
				local var_212_22 = var_212_20 <= 0 and var_212_16 or var_212_16 * (var_212_21 / var_212_20)

				if var_212_22 > 0 and var_212_16 < var_212_22 then
					arg_209_1.talkMaxDuration = var_212_22

					if var_212_22 + var_212_15 > arg_209_1.duration_ then
						arg_209_1.duration_ = var_212_22 + var_212_15
					end
				end

				arg_209_1.text_.text = var_212_19
				arg_209_1.typewritter.percent = 0

				arg_209_1.typewritter:SetDirty()
				arg_209_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_410142", "410142051", "story_v_out_410142.awb") ~= 0 then
					local var_212_23 = manager.audio:GetVoiceLength("story_v_out_410142", "410142051", "story_v_out_410142.awb") / 1000

					if var_212_23 + var_212_15 > arg_209_1.duration_ then
						arg_209_1.duration_ = var_212_23 + var_212_15
					end

					if var_212_18.prefab_name ~= "" and arg_209_1.actors_[var_212_18.prefab_name] ~= nil then
						local var_212_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_209_1.actors_[var_212_18.prefab_name].transform, "story_v_out_410142", "410142051", "story_v_out_410142.awb")

						arg_209_1:RecordAudio("410142051", var_212_24)
						arg_209_1:RecordAudio("410142051", var_212_24)
					else
						arg_209_1:AudioAction("play", "voice", "story_v_out_410142", "410142051", "story_v_out_410142.awb")
					end

					arg_209_1:RecordHistoryTalkVoice("story_v_out_410142", "410142051", "story_v_out_410142.awb")
				end

				arg_209_1:RecordContent(arg_209_1.text_.text)
			end

			local var_212_25 = math.max(var_212_16, arg_209_1.talkMaxDuration)

			if var_212_15 <= arg_209_1.time_ and arg_209_1.time_ < var_212_15 + var_212_25 then
				arg_209_1.typewritter.percent = (arg_209_1.time_ - var_212_15) / var_212_25

				arg_209_1.typewritter:SetDirty()
			end

			if arg_209_1.time_ >= var_212_15 + var_212_25 and arg_209_1.time_ < var_212_15 + var_212_25 + arg_212_0 then
				arg_209_1.typewritter.percent = 1

				arg_209_1.typewritter:SetDirty()
				arg_209_1:ShowNextGo(true)
			end
		end

		arg_209_1.nodeConfigList_ = {
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

		arg_209_1:InitPlayNodeList()
	end,
	Play410142052 = function(arg_213_0, arg_213_1)
		arg_213_1.time_ = 0
		arg_213_1.frameCnt_ = 0
		arg_213_1.state_ = "playing"
		arg_213_1.curTalkId_ = 410142052
		arg_213_1.duration_ = 5

		SetActive(arg_213_1.tipsGo_, false)

		function arg_213_1.onSingleLineFinish_()
			arg_213_1.onSingleLineUpdate_ = nil
			arg_213_1.onSingleLineFinish_ = nil
			arg_213_1.state_ = "waiting"
		end

		function arg_213_1.playNext_(arg_215_0)
			if arg_215_0 == 1 then
				arg_213_0:Play410142053(arg_213_1)
			end
		end

		function arg_213_1.onSingleLineUpdate_(arg_216_0)
			local var_216_0 = arg_213_1.actors_["1061"]
			local var_216_1 = 0

			if var_216_1 < arg_213_1.time_ and arg_213_1.time_ <= var_216_1 + arg_216_0 and not isNil(var_216_0) and arg_213_1.var_.actorSpriteComps1061 == nil then
				arg_213_1.var_.actorSpriteComps1061 = var_216_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_216_2 = 0.034

			if var_216_1 <= arg_213_1.time_ and arg_213_1.time_ < var_216_1 + var_216_2 and not isNil(var_216_0) then
				local var_216_3 = (arg_213_1.time_ - var_216_1) / var_216_2

				if arg_213_1.var_.actorSpriteComps1061 then
					for iter_216_0, iter_216_1 in pairs(arg_213_1.var_.actorSpriteComps1061:ToTable()) do
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

			if arg_213_1.time_ >= var_216_1 + var_216_2 and arg_213_1.time_ < var_216_1 + var_216_2 + arg_216_0 and not isNil(var_216_0) and arg_213_1.var_.actorSpriteComps1061 then
				for iter_216_2, iter_216_3 in pairs(arg_213_1.var_.actorSpriteComps1061:ToTable()) do
					if iter_216_3 then
						if arg_213_1.isInRecall_ then
							iter_216_3.color = arg_213_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_216_3.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_213_1.var_.actorSpriteComps1061 = nil
			end

			local var_216_8 = arg_213_1.actors_["1056"]
			local var_216_9 = 0

			if var_216_9 < arg_213_1.time_ and arg_213_1.time_ <= var_216_9 + arg_216_0 and not isNil(var_216_8) and arg_213_1.var_.actorSpriteComps1056 == nil then
				arg_213_1.var_.actorSpriteComps1056 = var_216_8:GetComponentsInChildren(typeof(Image), true)
			end

			local var_216_10 = 0.034

			if var_216_9 <= arg_213_1.time_ and arg_213_1.time_ < var_216_9 + var_216_10 and not isNil(var_216_8) then
				local var_216_11 = (arg_213_1.time_ - var_216_9) / var_216_10

				if arg_213_1.var_.actorSpriteComps1056 then
					for iter_216_4, iter_216_5 in pairs(arg_213_1.var_.actorSpriteComps1056:ToTable()) do
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

			if arg_213_1.time_ >= var_216_9 + var_216_10 and arg_213_1.time_ < var_216_9 + var_216_10 + arg_216_0 and not isNil(var_216_8) and arg_213_1.var_.actorSpriteComps1056 then
				for iter_216_6, iter_216_7 in pairs(arg_213_1.var_.actorSpriteComps1056:ToTable()) do
					if iter_216_7 then
						if arg_213_1.isInRecall_ then
							iter_216_7.color = arg_213_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_216_7.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_213_1.var_.actorSpriteComps1056 = nil
			end

			local var_216_16 = 0
			local var_216_17 = 0.925

			if var_216_16 < arg_213_1.time_ and arg_213_1.time_ <= var_216_16 + arg_216_0 then
				arg_213_1.talkMaxDuration = 0
				arg_213_1.dialogCg_.alpha = 1

				arg_213_1.dialog_:SetActive(true)
				SetActive(arg_213_1.leftNameGo_, false)

				arg_213_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_213_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_213_1:RecordName(arg_213_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_213_1.iconTrs_.gameObject, false)
				arg_213_1.callingController_:SetSelectedState("normal")

				local var_216_18 = arg_213_1:GetWordFromCfg(410142052)
				local var_216_19 = arg_213_1:FormatText(var_216_18.content)

				arg_213_1.text_.text = var_216_19

				LuaForUtil.ClearLinePrefixSymbol(arg_213_1.text_)

				local var_216_20 = 37
				local var_216_21 = utf8.len(var_216_19)
				local var_216_22 = var_216_20 <= 0 and var_216_17 or var_216_17 * (var_216_21 / var_216_20)

				if var_216_22 > 0 and var_216_17 < var_216_22 then
					arg_213_1.talkMaxDuration = var_216_22

					if var_216_22 + var_216_16 > arg_213_1.duration_ then
						arg_213_1.duration_ = var_216_22 + var_216_16
					end
				end

				arg_213_1.text_.text = var_216_19
				arg_213_1.typewritter.percent = 0

				arg_213_1.typewritter:SetDirty()
				arg_213_1:ShowNextGo(false)
				arg_213_1:RecordContent(arg_213_1.text_.text)
			end

			local var_216_23 = math.max(var_216_17, arg_213_1.talkMaxDuration)

			if var_216_16 <= arg_213_1.time_ and arg_213_1.time_ < var_216_16 + var_216_23 then
				arg_213_1.typewritter.percent = (arg_213_1.time_ - var_216_16) / var_216_23

				arg_213_1.typewritter:SetDirty()
			end

			if arg_213_1.time_ >= var_216_16 + var_216_23 and arg_213_1.time_ < var_216_16 + var_216_23 + arg_216_0 then
				arg_213_1.typewritter.percent = 1

				arg_213_1.typewritter:SetDirty()
				arg_213_1:ShowNextGo(true)
			end
		end

		arg_213_1.nodeConfigList_ = {}

		arg_213_1:InitPlayNodeList()
	end,
	Play410142053 = function(arg_217_0, arg_217_1)
		arg_217_1.time_ = 0
		arg_217_1.frameCnt_ = 0
		arg_217_1.state_ = "playing"
		arg_217_1.curTalkId_ = 410142053
		arg_217_1.duration_ = 6.1

		local var_217_0 = {
			ja = 6.1,
			CriLanguages = 2.866,
			zh = 2.866
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
				arg_217_0:Play410142054(arg_217_1)
			end
		end

		function arg_217_1.onSingleLineUpdate_(arg_220_0)
			local var_220_0 = arg_217_1.actors_["1061"].transform
			local var_220_1 = 0

			if var_220_1 < arg_217_1.time_ and arg_217_1.time_ <= var_220_1 + arg_220_0 then
				arg_217_1.var_.moveOldPos1061 = var_220_0.localPosition
				var_220_0.localScale = Vector3.New(1, 1, 1)

				arg_217_1:CheckSpriteTmpPos("1061", 2)

				local var_220_2 = var_220_0.childCount

				for iter_220_0 = 0, var_220_2 - 1 do
					local var_220_3 = var_220_0:GetChild(iter_220_0)

					if var_220_3.name == "split_1" or not string.find(var_220_3.name, "split") then
						var_220_3.gameObject:SetActive(true)
					else
						var_220_3.gameObject:SetActive(false)
					end
				end
			end

			local var_220_4 = 0.001

			if var_220_1 <= arg_217_1.time_ and arg_217_1.time_ < var_220_1 + var_220_4 then
				local var_220_5 = (arg_217_1.time_ - var_220_1) / var_220_4
				local var_220_6 = Vector3.New(-390, -490, 18)

				var_220_0.localPosition = Vector3.Lerp(arg_217_1.var_.moveOldPos1061, var_220_6, var_220_5)
			end

			if arg_217_1.time_ >= var_220_1 + var_220_4 and arg_217_1.time_ < var_220_1 + var_220_4 + arg_220_0 then
				var_220_0.localPosition = Vector3.New(-390, -490, 18)
			end

			local var_220_7 = arg_217_1.actors_["1061"]
			local var_220_8 = 0

			if var_220_8 < arg_217_1.time_ and arg_217_1.time_ <= var_220_8 + arg_220_0 and not isNil(var_220_7) and arg_217_1.var_.actorSpriteComps1061 == nil then
				arg_217_1.var_.actorSpriteComps1061 = var_220_7:GetComponentsInChildren(typeof(Image), true)
			end

			local var_220_9 = 0.034

			if var_220_8 <= arg_217_1.time_ and arg_217_1.time_ < var_220_8 + var_220_9 and not isNil(var_220_7) then
				local var_220_10 = (arg_217_1.time_ - var_220_8) / var_220_9

				if arg_217_1.var_.actorSpriteComps1061 then
					for iter_220_1, iter_220_2 in pairs(arg_217_1.var_.actorSpriteComps1061:ToTable()) do
						if iter_220_2 then
							if arg_217_1.isInRecall_ then
								local var_220_11 = Mathf.Lerp(iter_220_2.color.r, arg_217_1.hightColor1.r, var_220_10)
								local var_220_12 = Mathf.Lerp(iter_220_2.color.g, arg_217_1.hightColor1.g, var_220_10)
								local var_220_13 = Mathf.Lerp(iter_220_2.color.b, arg_217_1.hightColor1.b, var_220_10)

								iter_220_2.color = Color.New(var_220_11, var_220_12, var_220_13)
							else
								local var_220_14 = Mathf.Lerp(iter_220_2.color.r, 1, var_220_10)

								iter_220_2.color = Color.New(var_220_14, var_220_14, var_220_14)
							end
						end
					end
				end
			end

			if arg_217_1.time_ >= var_220_8 + var_220_9 and arg_217_1.time_ < var_220_8 + var_220_9 + arg_220_0 and not isNil(var_220_7) and arg_217_1.var_.actorSpriteComps1061 then
				for iter_220_3, iter_220_4 in pairs(arg_217_1.var_.actorSpriteComps1061:ToTable()) do
					if iter_220_4 then
						if arg_217_1.isInRecall_ then
							iter_220_4.color = arg_217_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_220_4.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_217_1.var_.actorSpriteComps1061 = nil
			end

			local var_220_15 = 0
			local var_220_16 = 0.225

			if var_220_15 < arg_217_1.time_ and arg_217_1.time_ <= var_220_15 + arg_220_0 then
				arg_217_1.talkMaxDuration = 0
				arg_217_1.dialogCg_.alpha = 1

				arg_217_1.dialog_:SetActive(true)
				SetActive(arg_217_1.leftNameGo_, true)

				local var_220_17 = arg_217_1:FormatText(StoryNameCfg[612].name)

				arg_217_1.leftNameTxt_.text = var_220_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_217_1.leftNameTxt_.transform)

				arg_217_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_217_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_217_1:RecordName(arg_217_1.leftNameTxt_.text)
				SetActive(arg_217_1.iconTrs_.gameObject, false)
				arg_217_1.callingController_:SetSelectedState("normal")

				local var_220_18 = arg_217_1:GetWordFromCfg(410142053)
				local var_220_19 = arg_217_1:FormatText(var_220_18.content)

				arg_217_1.text_.text = var_220_19

				LuaForUtil.ClearLinePrefixSymbol(arg_217_1.text_)

				local var_220_20 = 9
				local var_220_21 = utf8.len(var_220_19)
				local var_220_22 = var_220_20 <= 0 and var_220_16 or var_220_16 * (var_220_21 / var_220_20)

				if var_220_22 > 0 and var_220_16 < var_220_22 then
					arg_217_1.talkMaxDuration = var_220_22

					if var_220_22 + var_220_15 > arg_217_1.duration_ then
						arg_217_1.duration_ = var_220_22 + var_220_15
					end
				end

				arg_217_1.text_.text = var_220_19
				arg_217_1.typewritter.percent = 0

				arg_217_1.typewritter:SetDirty()
				arg_217_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_410142", "410142053", "story_v_out_410142.awb") ~= 0 then
					local var_220_23 = manager.audio:GetVoiceLength("story_v_out_410142", "410142053", "story_v_out_410142.awb") / 1000

					if var_220_23 + var_220_15 > arg_217_1.duration_ then
						arg_217_1.duration_ = var_220_23 + var_220_15
					end

					if var_220_18.prefab_name ~= "" and arg_217_1.actors_[var_220_18.prefab_name] ~= nil then
						local var_220_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_217_1.actors_[var_220_18.prefab_name].transform, "story_v_out_410142", "410142053", "story_v_out_410142.awb")

						arg_217_1:RecordAudio("410142053", var_220_24)
						arg_217_1:RecordAudio("410142053", var_220_24)
					else
						arg_217_1:AudioAction("play", "voice", "story_v_out_410142", "410142053", "story_v_out_410142.awb")
					end

					arg_217_1:RecordHistoryTalkVoice("story_v_out_410142", "410142053", "story_v_out_410142.awb")
				end

				arg_217_1:RecordContent(arg_217_1.text_.text)
			end

			local var_220_25 = math.max(var_220_16, arg_217_1.talkMaxDuration)

			if var_220_15 <= arg_217_1.time_ and arg_217_1.time_ < var_220_15 + var_220_25 then
				arg_217_1.typewritter.percent = (arg_217_1.time_ - var_220_15) / var_220_25

				arg_217_1.typewritter:SetDirty()
			end

			if arg_217_1.time_ >= var_220_15 + var_220_25 and arg_217_1.time_ < var_220_15 + var_220_25 + arg_220_0 then
				arg_217_1.typewritter.percent = 1

				arg_217_1.typewritter:SetDirty()
				arg_217_1:ShowNextGo(true)
			end
		end

		arg_217_1.nodeConfigList_ = {
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

		arg_217_1:InitPlayNodeList()
	end,
	Play410142054 = function(arg_221_0, arg_221_1)
		arg_221_1.time_ = 0
		arg_221_1.frameCnt_ = 0
		arg_221_1.state_ = "playing"
		arg_221_1.curTalkId_ = 410142054
		arg_221_1.duration_ = 7.1

		local var_221_0 = {
			ja = 7.1,
			CriLanguages = 6.266,
			zh = 6.266
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
				arg_221_0:Play410142055(arg_221_1)
			end
		end

		function arg_221_1.onSingleLineUpdate_(arg_224_0)
			local var_224_0 = arg_221_1.actors_["1056"].transform
			local var_224_1 = 0

			if var_224_1 < arg_221_1.time_ and arg_221_1.time_ <= var_224_1 + arg_224_0 then
				arg_221_1.var_.moveOldPos1056 = var_224_0.localPosition
				var_224_0.localScale = Vector3.New(1, 1, 1)

				arg_221_1:CheckSpriteTmpPos("1056", 4)

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
				local var_224_6 = Vector3.New(390, -350, -180)

				var_224_0.localPosition = Vector3.Lerp(arg_221_1.var_.moveOldPos1056, var_224_6, var_224_5)
			end

			if arg_221_1.time_ >= var_224_1 + var_224_4 and arg_221_1.time_ < var_224_1 + var_224_4 + arg_224_0 then
				var_224_0.localPosition = Vector3.New(390, -350, -180)
			end

			local var_224_7 = arg_221_1.actors_["1056"]
			local var_224_8 = 0

			if var_224_8 < arg_221_1.time_ and arg_221_1.time_ <= var_224_8 + arg_224_0 and not isNil(var_224_7) and arg_221_1.var_.actorSpriteComps1056 == nil then
				arg_221_1.var_.actorSpriteComps1056 = var_224_7:GetComponentsInChildren(typeof(Image), true)
			end

			local var_224_9 = 0.034

			if var_224_8 <= arg_221_1.time_ and arg_221_1.time_ < var_224_8 + var_224_9 and not isNil(var_224_7) then
				local var_224_10 = (arg_221_1.time_ - var_224_8) / var_224_9

				if arg_221_1.var_.actorSpriteComps1056 then
					for iter_224_1, iter_224_2 in pairs(arg_221_1.var_.actorSpriteComps1056:ToTable()) do
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

			if arg_221_1.time_ >= var_224_8 + var_224_9 and arg_221_1.time_ < var_224_8 + var_224_9 + arg_224_0 and not isNil(var_224_7) and arg_221_1.var_.actorSpriteComps1056 then
				for iter_224_3, iter_224_4 in pairs(arg_221_1.var_.actorSpriteComps1056:ToTable()) do
					if iter_224_4 then
						if arg_221_1.isInRecall_ then
							iter_224_4.color = arg_221_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_224_4.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_221_1.var_.actorSpriteComps1056 = nil
			end

			local var_224_15 = arg_221_1.actors_["1061"]
			local var_224_16 = 0

			if var_224_16 < arg_221_1.time_ and arg_221_1.time_ <= var_224_16 + arg_224_0 and not isNil(var_224_15) and arg_221_1.var_.actorSpriteComps1061 == nil then
				arg_221_1.var_.actorSpriteComps1061 = var_224_15:GetComponentsInChildren(typeof(Image), true)
			end

			local var_224_17 = 0.034

			if var_224_16 <= arg_221_1.time_ and arg_221_1.time_ < var_224_16 + var_224_17 and not isNil(var_224_15) then
				local var_224_18 = (arg_221_1.time_ - var_224_16) / var_224_17

				if arg_221_1.var_.actorSpriteComps1061 then
					for iter_224_5, iter_224_6 in pairs(arg_221_1.var_.actorSpriteComps1061:ToTable()) do
						if iter_224_6 then
							if arg_221_1.isInRecall_ then
								local var_224_19 = Mathf.Lerp(iter_224_6.color.r, arg_221_1.hightColor2.r, var_224_18)
								local var_224_20 = Mathf.Lerp(iter_224_6.color.g, arg_221_1.hightColor2.g, var_224_18)
								local var_224_21 = Mathf.Lerp(iter_224_6.color.b, arg_221_1.hightColor2.b, var_224_18)

								iter_224_6.color = Color.New(var_224_19, var_224_20, var_224_21)
							else
								local var_224_22 = Mathf.Lerp(iter_224_6.color.r, 0.5, var_224_18)

								iter_224_6.color = Color.New(var_224_22, var_224_22, var_224_22)
							end
						end
					end
				end
			end

			if arg_221_1.time_ >= var_224_16 + var_224_17 and arg_221_1.time_ < var_224_16 + var_224_17 + arg_224_0 and not isNil(var_224_15) and arg_221_1.var_.actorSpriteComps1061 then
				for iter_224_7, iter_224_8 in pairs(arg_221_1.var_.actorSpriteComps1061:ToTable()) do
					if iter_224_8 then
						if arg_221_1.isInRecall_ then
							iter_224_8.color = arg_221_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_224_8.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_221_1.var_.actorSpriteComps1061 = nil
			end

			local var_224_23 = 0
			local var_224_24 = 0.9

			if var_224_23 < arg_221_1.time_ and arg_221_1.time_ <= var_224_23 + arg_224_0 then
				arg_221_1.talkMaxDuration = 0
				arg_221_1.dialogCg_.alpha = 1

				arg_221_1.dialog_:SetActive(true)
				SetActive(arg_221_1.leftNameGo_, true)

				local var_224_25 = arg_221_1:FormatText(StoryNameCfg[605].name)

				arg_221_1.leftNameTxt_.text = var_224_25

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_221_1.leftNameTxt_.transform)

				arg_221_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_221_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_221_1:RecordName(arg_221_1.leftNameTxt_.text)
				SetActive(arg_221_1.iconTrs_.gameObject, false)
				arg_221_1.callingController_:SetSelectedState("normal")

				local var_224_26 = arg_221_1:GetWordFromCfg(410142054)
				local var_224_27 = arg_221_1:FormatText(var_224_26.content)

				arg_221_1.text_.text = var_224_27

				LuaForUtil.ClearLinePrefixSymbol(arg_221_1.text_)

				local var_224_28 = 36
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

				if manager.audio:GetVoiceLength("story_v_out_410142", "410142054", "story_v_out_410142.awb") ~= 0 then
					local var_224_31 = manager.audio:GetVoiceLength("story_v_out_410142", "410142054", "story_v_out_410142.awb") / 1000

					if var_224_31 + var_224_23 > arg_221_1.duration_ then
						arg_221_1.duration_ = var_224_31 + var_224_23
					end

					if var_224_26.prefab_name ~= "" and arg_221_1.actors_[var_224_26.prefab_name] ~= nil then
						local var_224_32 = LuaForUtil.PlayVoiceWithCriLipsync(arg_221_1.actors_[var_224_26.prefab_name].transform, "story_v_out_410142", "410142054", "story_v_out_410142.awb")

						arg_221_1:RecordAudio("410142054", var_224_32)
						arg_221_1:RecordAudio("410142054", var_224_32)
					else
						arg_221_1:AudioAction("play", "voice", "story_v_out_410142", "410142054", "story_v_out_410142.awb")
					end

					arg_221_1:RecordHistoryTalkVoice("story_v_out_410142", "410142054", "story_v_out_410142.awb")
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
				actorName = "1056",
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
	Play410142055 = function(arg_225_0, arg_225_1)
		arg_225_1.time_ = 0
		arg_225_1.frameCnt_ = 0
		arg_225_1.state_ = "playing"
		arg_225_1.curTalkId_ = 410142055
		arg_225_1.duration_ = 13.4

		local var_225_0 = {
			ja = 13.4,
			CriLanguages = 8.7,
			zh = 8.7
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
				arg_225_0:Play410142056(arg_225_1)
			end
		end

		function arg_225_1.onSingleLineUpdate_(arg_228_0)
			local var_228_0 = arg_225_1.actors_["1056"].transform
			local var_228_1 = 0

			if var_228_1 < arg_225_1.time_ and arg_225_1.time_ <= var_228_1 + arg_228_0 then
				arg_225_1.var_.moveOldPos1056 = var_228_0.localPosition
				var_228_0.localScale = Vector3.New(1, 1, 1)

				arg_225_1:CheckSpriteTmpPos("1056", 4)

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
				local var_228_6 = Vector3.New(390, -350, -180)

				var_228_0.localPosition = Vector3.Lerp(arg_225_1.var_.moveOldPos1056, var_228_6, var_228_5)
			end

			if arg_225_1.time_ >= var_228_1 + var_228_4 and arg_225_1.time_ < var_228_1 + var_228_4 + arg_228_0 then
				var_228_0.localPosition = Vector3.New(390, -350, -180)
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

			local var_228_15 = 0
			local var_228_16 = 1.15

			if var_228_15 < arg_225_1.time_ and arg_225_1.time_ <= var_228_15 + arg_228_0 then
				arg_225_1.talkMaxDuration = 0
				arg_225_1.dialogCg_.alpha = 1

				arg_225_1.dialog_:SetActive(true)
				SetActive(arg_225_1.leftNameGo_, true)

				local var_228_17 = arg_225_1:FormatText(StoryNameCfg[605].name)

				arg_225_1.leftNameTxt_.text = var_228_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_225_1.leftNameTxt_.transform)

				arg_225_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_225_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_225_1:RecordName(arg_225_1.leftNameTxt_.text)
				SetActive(arg_225_1.iconTrs_.gameObject, false)
				arg_225_1.callingController_:SetSelectedState("normal")

				local var_228_18 = arg_225_1:GetWordFromCfg(410142055)
				local var_228_19 = arg_225_1:FormatText(var_228_18.content)

				arg_225_1.text_.text = var_228_19

				LuaForUtil.ClearLinePrefixSymbol(arg_225_1.text_)

				local var_228_20 = 46
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

				if manager.audio:GetVoiceLength("story_v_out_410142", "410142055", "story_v_out_410142.awb") ~= 0 then
					local var_228_23 = manager.audio:GetVoiceLength("story_v_out_410142", "410142055", "story_v_out_410142.awb") / 1000

					if var_228_23 + var_228_15 > arg_225_1.duration_ then
						arg_225_1.duration_ = var_228_23 + var_228_15
					end

					if var_228_18.prefab_name ~= "" and arg_225_1.actors_[var_228_18.prefab_name] ~= nil then
						local var_228_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_225_1.actors_[var_228_18.prefab_name].transform, "story_v_out_410142", "410142055", "story_v_out_410142.awb")

						arg_225_1:RecordAudio("410142055", var_228_24)
						arg_225_1:RecordAudio("410142055", var_228_24)
					else
						arg_225_1:AudioAction("play", "voice", "story_v_out_410142", "410142055", "story_v_out_410142.awb")
					end

					arg_225_1:RecordHistoryTalkVoice("story_v_out_410142", "410142055", "story_v_out_410142.awb")
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
	Play410142056 = function(arg_229_0, arg_229_1)
		arg_229_1.time_ = 0
		arg_229_1.frameCnt_ = 0
		arg_229_1.state_ = "playing"
		arg_229_1.curTalkId_ = 410142056
		arg_229_1.duration_ = 9.07

		local var_229_0 = {
			ja = 9.066,
			CriLanguages = 4.866,
			zh = 4.866
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
				arg_229_0:Play410142057(arg_229_1)
			end
		end

		function arg_229_1.onSingleLineUpdate_(arg_232_0)
			local var_232_0 = arg_229_1.actors_["1061"].transform
			local var_232_1 = 0

			if var_232_1 < arg_229_1.time_ and arg_229_1.time_ <= var_232_1 + arg_232_0 then
				arg_229_1.var_.moveOldPos1061 = var_232_0.localPosition
				var_232_0.localScale = Vector3.New(1, 1, 1)

				arg_229_1:CheckSpriteTmpPos("1061", 2)

				local var_232_2 = var_232_0.childCount

				for iter_232_0 = 0, var_232_2 - 1 do
					local var_232_3 = var_232_0:GetChild(iter_232_0)

					if var_232_3.name == "split_5" or not string.find(var_232_3.name, "split") then
						var_232_3.gameObject:SetActive(true)
					else
						var_232_3.gameObject:SetActive(false)
					end
				end
			end

			local var_232_4 = 0.001

			if var_232_1 <= arg_229_1.time_ and arg_229_1.time_ < var_232_1 + var_232_4 then
				local var_232_5 = (arg_229_1.time_ - var_232_1) / var_232_4
				local var_232_6 = Vector3.New(-390, -490, 18)

				var_232_0.localPosition = Vector3.Lerp(arg_229_1.var_.moveOldPos1061, var_232_6, var_232_5)
			end

			if arg_229_1.time_ >= var_232_1 + var_232_4 and arg_229_1.time_ < var_232_1 + var_232_4 + arg_232_0 then
				var_232_0.localPosition = Vector3.New(-390, -490, 18)
			end

			local var_232_7 = arg_229_1.actors_["1061"]
			local var_232_8 = 0

			if var_232_8 < arg_229_1.time_ and arg_229_1.time_ <= var_232_8 + arg_232_0 and not isNil(var_232_7) and arg_229_1.var_.actorSpriteComps1061 == nil then
				arg_229_1.var_.actorSpriteComps1061 = var_232_7:GetComponentsInChildren(typeof(Image), true)
			end

			local var_232_9 = 0.034

			if var_232_8 <= arg_229_1.time_ and arg_229_1.time_ < var_232_8 + var_232_9 and not isNil(var_232_7) then
				local var_232_10 = (arg_229_1.time_ - var_232_8) / var_232_9

				if arg_229_1.var_.actorSpriteComps1061 then
					for iter_232_1, iter_232_2 in pairs(arg_229_1.var_.actorSpriteComps1061:ToTable()) do
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

			if arg_229_1.time_ >= var_232_8 + var_232_9 and arg_229_1.time_ < var_232_8 + var_232_9 + arg_232_0 and not isNil(var_232_7) and arg_229_1.var_.actorSpriteComps1061 then
				for iter_232_3, iter_232_4 in pairs(arg_229_1.var_.actorSpriteComps1061:ToTable()) do
					if iter_232_4 then
						if arg_229_1.isInRecall_ then
							iter_232_4.color = arg_229_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_232_4.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_229_1.var_.actorSpriteComps1061 = nil
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
			local var_232_24 = 0.4

			if var_232_23 < arg_229_1.time_ and arg_229_1.time_ <= var_232_23 + arg_232_0 then
				arg_229_1.talkMaxDuration = 0
				arg_229_1.dialogCg_.alpha = 1

				arg_229_1.dialog_:SetActive(true)
				SetActive(arg_229_1.leftNameGo_, true)

				local var_232_25 = arg_229_1:FormatText(StoryNameCfg[612].name)

				arg_229_1.leftNameTxt_.text = var_232_25

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_229_1.leftNameTxt_.transform)

				arg_229_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_229_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_229_1:RecordName(arg_229_1.leftNameTxt_.text)
				SetActive(arg_229_1.iconTrs_.gameObject, false)
				arg_229_1.callingController_:SetSelectedState("normal")

				local var_232_26 = arg_229_1:GetWordFromCfg(410142056)
				local var_232_27 = arg_229_1:FormatText(var_232_26.content)

				arg_229_1.text_.text = var_232_27

				LuaForUtil.ClearLinePrefixSymbol(arg_229_1.text_)

				local var_232_28 = 16
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

				if manager.audio:GetVoiceLength("story_v_out_410142", "410142056", "story_v_out_410142.awb") ~= 0 then
					local var_232_31 = manager.audio:GetVoiceLength("story_v_out_410142", "410142056", "story_v_out_410142.awb") / 1000

					if var_232_31 + var_232_23 > arg_229_1.duration_ then
						arg_229_1.duration_ = var_232_31 + var_232_23
					end

					if var_232_26.prefab_name ~= "" and arg_229_1.actors_[var_232_26.prefab_name] ~= nil then
						local var_232_32 = LuaForUtil.PlayVoiceWithCriLipsync(arg_229_1.actors_[var_232_26.prefab_name].transform, "story_v_out_410142", "410142056", "story_v_out_410142.awb")

						arg_229_1:RecordAudio("410142056", var_232_32)
						arg_229_1:RecordAudio("410142056", var_232_32)
					else
						arg_229_1:AudioAction("play", "voice", "story_v_out_410142", "410142056", "story_v_out_410142.awb")
					end

					arg_229_1:RecordHistoryTalkVoice("story_v_out_410142", "410142056", "story_v_out_410142.awb")
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
				actorName = "1061",
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
	Play410142057 = function(arg_233_0, arg_233_1)
		arg_233_1.time_ = 0
		arg_233_1.frameCnt_ = 0
		arg_233_1.state_ = "playing"
		arg_233_1.curTalkId_ = 410142057
		arg_233_1.duration_ = 8.47

		local var_233_0 = {
			ja = 8.466,
			CriLanguages = 6.666,
			zh = 6.666
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
				arg_233_0:Play410142058(arg_233_1)
			end
		end

		function arg_233_1.onSingleLineUpdate_(arg_236_0)
			local var_236_0 = arg_233_1.actors_["1056"].transform
			local var_236_1 = 0

			if var_236_1 < arg_233_1.time_ and arg_233_1.time_ <= var_236_1 + arg_236_0 then
				arg_233_1.var_.moveOldPos1056 = var_236_0.localPosition
				var_236_0.localScale = Vector3.New(1, 1, 1)

				arg_233_1:CheckSpriteTmpPos("1056", 4)

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
				local var_236_6 = Vector3.New(390, -350, -180)

				var_236_0.localPosition = Vector3.Lerp(arg_233_1.var_.moveOldPos1056, var_236_6, var_236_5)
			end

			if arg_233_1.time_ >= var_236_1 + var_236_4 and arg_233_1.time_ < var_236_1 + var_236_4 + arg_236_0 then
				var_236_0.localPosition = Vector3.New(390, -350, -180)
			end

			local var_236_7 = arg_233_1.actors_["1056"]
			local var_236_8 = 0

			if var_236_8 < arg_233_1.time_ and arg_233_1.time_ <= var_236_8 + arg_236_0 and not isNil(var_236_7) and arg_233_1.var_.actorSpriteComps1056 == nil then
				arg_233_1.var_.actorSpriteComps1056 = var_236_7:GetComponentsInChildren(typeof(Image), true)
			end

			local var_236_9 = 0.034

			if var_236_8 <= arg_233_1.time_ and arg_233_1.time_ < var_236_8 + var_236_9 and not isNil(var_236_7) then
				local var_236_10 = (arg_233_1.time_ - var_236_8) / var_236_9

				if arg_233_1.var_.actorSpriteComps1056 then
					for iter_236_1, iter_236_2 in pairs(arg_233_1.var_.actorSpriteComps1056:ToTable()) do
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

			if arg_233_1.time_ >= var_236_8 + var_236_9 and arg_233_1.time_ < var_236_8 + var_236_9 + arg_236_0 and not isNil(var_236_7) and arg_233_1.var_.actorSpriteComps1056 then
				for iter_236_3, iter_236_4 in pairs(arg_233_1.var_.actorSpriteComps1056:ToTable()) do
					if iter_236_4 then
						if arg_233_1.isInRecall_ then
							iter_236_4.color = arg_233_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_236_4.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_233_1.var_.actorSpriteComps1056 = nil
			end

			local var_236_15 = arg_233_1.actors_["1061"]
			local var_236_16 = 0

			if var_236_16 < arg_233_1.time_ and arg_233_1.time_ <= var_236_16 + arg_236_0 and not isNil(var_236_15) and arg_233_1.var_.actorSpriteComps1061 == nil then
				arg_233_1.var_.actorSpriteComps1061 = var_236_15:GetComponentsInChildren(typeof(Image), true)
			end

			local var_236_17 = 0.034

			if var_236_16 <= arg_233_1.time_ and arg_233_1.time_ < var_236_16 + var_236_17 and not isNil(var_236_15) then
				local var_236_18 = (arg_233_1.time_ - var_236_16) / var_236_17

				if arg_233_1.var_.actorSpriteComps1061 then
					for iter_236_5, iter_236_6 in pairs(arg_233_1.var_.actorSpriteComps1061:ToTable()) do
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

			if arg_233_1.time_ >= var_236_16 + var_236_17 and arg_233_1.time_ < var_236_16 + var_236_17 + arg_236_0 and not isNil(var_236_15) and arg_233_1.var_.actorSpriteComps1061 then
				for iter_236_7, iter_236_8 in pairs(arg_233_1.var_.actorSpriteComps1061:ToTable()) do
					if iter_236_8 then
						if arg_233_1.isInRecall_ then
							iter_236_8.color = arg_233_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_236_8.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_233_1.var_.actorSpriteComps1061 = nil
			end

			local var_236_23 = 0
			local var_236_24 = 0.9

			if var_236_23 < arg_233_1.time_ and arg_233_1.time_ <= var_236_23 + arg_236_0 then
				arg_233_1.talkMaxDuration = 0
				arg_233_1.dialogCg_.alpha = 1

				arg_233_1.dialog_:SetActive(true)
				SetActive(arg_233_1.leftNameGo_, true)

				local var_236_25 = arg_233_1:FormatText(StoryNameCfg[605].name)

				arg_233_1.leftNameTxt_.text = var_236_25

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_233_1.leftNameTxt_.transform)

				arg_233_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_233_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_233_1:RecordName(arg_233_1.leftNameTxt_.text)
				SetActive(arg_233_1.iconTrs_.gameObject, false)
				arg_233_1.callingController_:SetSelectedState("normal")

				local var_236_26 = arg_233_1:GetWordFromCfg(410142057)
				local var_236_27 = arg_233_1:FormatText(var_236_26.content)

				arg_233_1.text_.text = var_236_27

				LuaForUtil.ClearLinePrefixSymbol(arg_233_1.text_)

				local var_236_28 = 36
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

				if manager.audio:GetVoiceLength("story_v_out_410142", "410142057", "story_v_out_410142.awb") ~= 0 then
					local var_236_31 = manager.audio:GetVoiceLength("story_v_out_410142", "410142057", "story_v_out_410142.awb") / 1000

					if var_236_31 + var_236_23 > arg_233_1.duration_ then
						arg_233_1.duration_ = var_236_31 + var_236_23
					end

					if var_236_26.prefab_name ~= "" and arg_233_1.actors_[var_236_26.prefab_name] ~= nil then
						local var_236_32 = LuaForUtil.PlayVoiceWithCriLipsync(arg_233_1.actors_[var_236_26.prefab_name].transform, "story_v_out_410142", "410142057", "story_v_out_410142.awb")

						arg_233_1:RecordAudio("410142057", var_236_32)
						arg_233_1:RecordAudio("410142057", var_236_32)
					else
						arg_233_1:AudioAction("play", "voice", "story_v_out_410142", "410142057", "story_v_out_410142.awb")
					end

					arg_233_1:RecordHistoryTalkVoice("story_v_out_410142", "410142057", "story_v_out_410142.awb")
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
				actorName = "1056",
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
	Play410142058 = function(arg_237_0, arg_237_1)
		arg_237_1.time_ = 0
		arg_237_1.frameCnt_ = 0
		arg_237_1.state_ = "playing"
		arg_237_1.curTalkId_ = 410142058
		arg_237_1.duration_ = 9.83

		local var_237_0 = {
			ja = 9.833,
			CriLanguages = 8.9,
			zh = 8.9
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
				arg_237_0:Play410142059(arg_237_1)
			end
		end

		function arg_237_1.onSingleLineUpdate_(arg_240_0)
			local var_240_0 = arg_237_1.actors_["1061"].transform
			local var_240_1 = 0

			if var_240_1 < arg_237_1.time_ and arg_237_1.time_ <= var_240_1 + arg_240_0 then
				arg_237_1.var_.moveOldPos1061 = var_240_0.localPosition
				var_240_0.localScale = Vector3.New(1, 1, 1)

				arg_237_1:CheckSpriteTmpPos("1061", 2)

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
				local var_240_6 = Vector3.New(-390, -490, 18)

				var_240_0.localPosition = Vector3.Lerp(arg_237_1.var_.moveOldPos1061, var_240_6, var_240_5)
			end

			if arg_237_1.time_ >= var_240_1 + var_240_4 and arg_237_1.time_ < var_240_1 + var_240_4 + arg_240_0 then
				var_240_0.localPosition = Vector3.New(-390, -490, 18)
			end

			local var_240_7 = arg_237_1.actors_["1061"]
			local var_240_8 = 0

			if var_240_8 < arg_237_1.time_ and arg_237_1.time_ <= var_240_8 + arg_240_0 and not isNil(var_240_7) and arg_237_1.var_.actorSpriteComps1061 == nil then
				arg_237_1.var_.actorSpriteComps1061 = var_240_7:GetComponentsInChildren(typeof(Image), true)
			end

			local var_240_9 = 0.034

			if var_240_8 <= arg_237_1.time_ and arg_237_1.time_ < var_240_8 + var_240_9 and not isNil(var_240_7) then
				local var_240_10 = (arg_237_1.time_ - var_240_8) / var_240_9

				if arg_237_1.var_.actorSpriteComps1061 then
					for iter_240_1, iter_240_2 in pairs(arg_237_1.var_.actorSpriteComps1061:ToTable()) do
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

			if arg_237_1.time_ >= var_240_8 + var_240_9 and arg_237_1.time_ < var_240_8 + var_240_9 + arg_240_0 and not isNil(var_240_7) and arg_237_1.var_.actorSpriteComps1061 then
				for iter_240_3, iter_240_4 in pairs(arg_237_1.var_.actorSpriteComps1061:ToTable()) do
					if iter_240_4 then
						if arg_237_1.isInRecall_ then
							iter_240_4.color = arg_237_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_240_4.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_237_1.var_.actorSpriteComps1061 = nil
			end

			local var_240_15 = arg_237_1.actors_["1056"]
			local var_240_16 = 0

			if var_240_16 < arg_237_1.time_ and arg_237_1.time_ <= var_240_16 + arg_240_0 and not isNil(var_240_15) and arg_237_1.var_.actorSpriteComps1056 == nil then
				arg_237_1.var_.actorSpriteComps1056 = var_240_15:GetComponentsInChildren(typeof(Image), true)
			end

			local var_240_17 = 0.034

			if var_240_16 <= arg_237_1.time_ and arg_237_1.time_ < var_240_16 + var_240_17 and not isNil(var_240_15) then
				local var_240_18 = (arg_237_1.time_ - var_240_16) / var_240_17

				if arg_237_1.var_.actorSpriteComps1056 then
					for iter_240_5, iter_240_6 in pairs(arg_237_1.var_.actorSpriteComps1056:ToTable()) do
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

			if arg_237_1.time_ >= var_240_16 + var_240_17 and arg_237_1.time_ < var_240_16 + var_240_17 + arg_240_0 and not isNil(var_240_15) and arg_237_1.var_.actorSpriteComps1056 then
				for iter_240_7, iter_240_8 in pairs(arg_237_1.var_.actorSpriteComps1056:ToTable()) do
					if iter_240_8 then
						if arg_237_1.isInRecall_ then
							iter_240_8.color = arg_237_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_240_8.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_237_1.var_.actorSpriteComps1056 = nil
			end

			local var_240_23 = 0
			local var_240_24 = 0.9

			if var_240_23 < arg_237_1.time_ and arg_237_1.time_ <= var_240_23 + arg_240_0 then
				arg_237_1.talkMaxDuration = 0
				arg_237_1.dialogCg_.alpha = 1

				arg_237_1.dialog_:SetActive(true)
				SetActive(arg_237_1.leftNameGo_, true)

				local var_240_25 = arg_237_1:FormatText(StoryNameCfg[612].name)

				arg_237_1.leftNameTxt_.text = var_240_25

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_237_1.leftNameTxt_.transform)

				arg_237_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_237_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_237_1:RecordName(arg_237_1.leftNameTxt_.text)
				SetActive(arg_237_1.iconTrs_.gameObject, false)
				arg_237_1.callingController_:SetSelectedState("normal")

				local var_240_26 = arg_237_1:GetWordFromCfg(410142058)
				local var_240_27 = arg_237_1:FormatText(var_240_26.content)

				arg_237_1.text_.text = var_240_27

				LuaForUtil.ClearLinePrefixSymbol(arg_237_1.text_)

				local var_240_28 = 36
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

				if manager.audio:GetVoiceLength("story_v_out_410142", "410142058", "story_v_out_410142.awb") ~= 0 then
					local var_240_31 = manager.audio:GetVoiceLength("story_v_out_410142", "410142058", "story_v_out_410142.awb") / 1000

					if var_240_31 + var_240_23 > arg_237_1.duration_ then
						arg_237_1.duration_ = var_240_31 + var_240_23
					end

					if var_240_26.prefab_name ~= "" and arg_237_1.actors_[var_240_26.prefab_name] ~= nil then
						local var_240_32 = LuaForUtil.PlayVoiceWithCriLipsync(arg_237_1.actors_[var_240_26.prefab_name].transform, "story_v_out_410142", "410142058", "story_v_out_410142.awb")

						arg_237_1:RecordAudio("410142058", var_240_32)
						arg_237_1:RecordAudio("410142058", var_240_32)
					else
						arg_237_1:AudioAction("play", "voice", "story_v_out_410142", "410142058", "story_v_out_410142.awb")
					end

					arg_237_1:RecordHistoryTalkVoice("story_v_out_410142", "410142058", "story_v_out_410142.awb")
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
				actorName = "1061",
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
	Play410142059 = function(arg_241_0, arg_241_1)
		arg_241_1.time_ = 0
		arg_241_1.frameCnt_ = 0
		arg_241_1.state_ = "playing"
		arg_241_1.curTalkId_ = 410142059
		arg_241_1.duration_ = 9.5

		local var_241_0 = {
			ja = 9.5,
			CriLanguages = 9.033,
			zh = 9.033
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
				arg_241_0:Play410142060(arg_241_1)
			end
		end

		function arg_241_1.onSingleLineUpdate_(arg_244_0)
			local var_244_0 = arg_241_1.actors_["1056"].transform
			local var_244_1 = 0

			if var_244_1 < arg_241_1.time_ and arg_241_1.time_ <= var_244_1 + arg_244_0 then
				arg_241_1.var_.moveOldPos1056 = var_244_0.localPosition
				var_244_0.localScale = Vector3.New(1, 1, 1)

				arg_241_1:CheckSpriteTmpPos("1056", 4)

				local var_244_2 = var_244_0.childCount

				for iter_244_0 = 0, var_244_2 - 1 do
					local var_244_3 = var_244_0:GetChild(iter_244_0)

					if var_244_3.name == "" or not string.find(var_244_3.name, "split") then
						var_244_3.gameObject:SetActive(true)
					else
						var_244_3.gameObject:SetActive(false)
					end
				end
			end

			local var_244_4 = 0.001

			if var_244_1 <= arg_241_1.time_ and arg_241_1.time_ < var_244_1 + var_244_4 then
				local var_244_5 = (arg_241_1.time_ - var_244_1) / var_244_4
				local var_244_6 = Vector3.New(390, -350, -180)

				var_244_0.localPosition = Vector3.Lerp(arg_241_1.var_.moveOldPos1056, var_244_6, var_244_5)
			end

			if arg_241_1.time_ >= var_244_1 + var_244_4 and arg_241_1.time_ < var_244_1 + var_244_4 + arg_244_0 then
				var_244_0.localPosition = Vector3.New(390, -350, -180)
			end

			local var_244_7 = arg_241_1.actors_["1056"]
			local var_244_8 = 0

			if var_244_8 < arg_241_1.time_ and arg_241_1.time_ <= var_244_8 + arg_244_0 and not isNil(var_244_7) and arg_241_1.var_.actorSpriteComps1056 == nil then
				arg_241_1.var_.actorSpriteComps1056 = var_244_7:GetComponentsInChildren(typeof(Image), true)
			end

			local var_244_9 = 0.034

			if var_244_8 <= arg_241_1.time_ and arg_241_1.time_ < var_244_8 + var_244_9 and not isNil(var_244_7) then
				local var_244_10 = (arg_241_1.time_ - var_244_8) / var_244_9

				if arg_241_1.var_.actorSpriteComps1056 then
					for iter_244_1, iter_244_2 in pairs(arg_241_1.var_.actorSpriteComps1056:ToTable()) do
						if iter_244_2 then
							if arg_241_1.isInRecall_ then
								local var_244_11 = Mathf.Lerp(iter_244_2.color.r, arg_241_1.hightColor1.r, var_244_10)
								local var_244_12 = Mathf.Lerp(iter_244_2.color.g, arg_241_1.hightColor1.g, var_244_10)
								local var_244_13 = Mathf.Lerp(iter_244_2.color.b, arg_241_1.hightColor1.b, var_244_10)

								iter_244_2.color = Color.New(var_244_11, var_244_12, var_244_13)
							else
								local var_244_14 = Mathf.Lerp(iter_244_2.color.r, 1, var_244_10)

								iter_244_2.color = Color.New(var_244_14, var_244_14, var_244_14)
							end
						end
					end
				end
			end

			if arg_241_1.time_ >= var_244_8 + var_244_9 and arg_241_1.time_ < var_244_8 + var_244_9 + arg_244_0 and not isNil(var_244_7) and arg_241_1.var_.actorSpriteComps1056 then
				for iter_244_3, iter_244_4 in pairs(arg_241_1.var_.actorSpriteComps1056:ToTable()) do
					if iter_244_4 then
						if arg_241_1.isInRecall_ then
							iter_244_4.color = arg_241_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_244_4.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_241_1.var_.actorSpriteComps1056 = nil
			end

			local var_244_15 = arg_241_1.actors_["1061"]
			local var_244_16 = 0

			if var_244_16 < arg_241_1.time_ and arg_241_1.time_ <= var_244_16 + arg_244_0 and not isNil(var_244_15) and arg_241_1.var_.actorSpriteComps1061 == nil then
				arg_241_1.var_.actorSpriteComps1061 = var_244_15:GetComponentsInChildren(typeof(Image), true)
			end

			local var_244_17 = 0.034

			if var_244_16 <= arg_241_1.time_ and arg_241_1.time_ < var_244_16 + var_244_17 and not isNil(var_244_15) then
				local var_244_18 = (arg_241_1.time_ - var_244_16) / var_244_17

				if arg_241_1.var_.actorSpriteComps1061 then
					for iter_244_5, iter_244_6 in pairs(arg_241_1.var_.actorSpriteComps1061:ToTable()) do
						if iter_244_6 then
							if arg_241_1.isInRecall_ then
								local var_244_19 = Mathf.Lerp(iter_244_6.color.r, arg_241_1.hightColor2.r, var_244_18)
								local var_244_20 = Mathf.Lerp(iter_244_6.color.g, arg_241_1.hightColor2.g, var_244_18)
								local var_244_21 = Mathf.Lerp(iter_244_6.color.b, arg_241_1.hightColor2.b, var_244_18)

								iter_244_6.color = Color.New(var_244_19, var_244_20, var_244_21)
							else
								local var_244_22 = Mathf.Lerp(iter_244_6.color.r, 0.5, var_244_18)

								iter_244_6.color = Color.New(var_244_22, var_244_22, var_244_22)
							end
						end
					end
				end
			end

			if arg_241_1.time_ >= var_244_16 + var_244_17 and arg_241_1.time_ < var_244_16 + var_244_17 + arg_244_0 and not isNil(var_244_15) and arg_241_1.var_.actorSpriteComps1061 then
				for iter_244_7, iter_244_8 in pairs(arg_241_1.var_.actorSpriteComps1061:ToTable()) do
					if iter_244_8 then
						if arg_241_1.isInRecall_ then
							iter_244_8.color = arg_241_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_244_8.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_241_1.var_.actorSpriteComps1061 = nil
			end

			local var_244_23 = 0
			local var_244_24 = 0.9

			if var_244_23 < arg_241_1.time_ and arg_241_1.time_ <= var_244_23 + arg_244_0 then
				arg_241_1.talkMaxDuration = 0
				arg_241_1.dialogCg_.alpha = 1

				arg_241_1.dialog_:SetActive(true)
				SetActive(arg_241_1.leftNameGo_, true)

				local var_244_25 = arg_241_1:FormatText(StoryNameCfg[605].name)

				arg_241_1.leftNameTxt_.text = var_244_25

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_241_1.leftNameTxt_.transform)

				arg_241_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_241_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_241_1:RecordName(arg_241_1.leftNameTxt_.text)
				SetActive(arg_241_1.iconTrs_.gameObject, false)
				arg_241_1.callingController_:SetSelectedState("normal")

				local var_244_26 = arg_241_1:GetWordFromCfg(410142059)
				local var_244_27 = arg_241_1:FormatText(var_244_26.content)

				arg_241_1.text_.text = var_244_27

				LuaForUtil.ClearLinePrefixSymbol(arg_241_1.text_)

				local var_244_28 = 36
				local var_244_29 = utf8.len(var_244_27)
				local var_244_30 = var_244_28 <= 0 and var_244_24 or var_244_24 * (var_244_29 / var_244_28)

				if var_244_30 > 0 and var_244_24 < var_244_30 then
					arg_241_1.talkMaxDuration = var_244_30

					if var_244_30 + var_244_23 > arg_241_1.duration_ then
						arg_241_1.duration_ = var_244_30 + var_244_23
					end
				end

				arg_241_1.text_.text = var_244_27
				arg_241_1.typewritter.percent = 0

				arg_241_1.typewritter:SetDirty()
				arg_241_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_410142", "410142059", "story_v_out_410142.awb") ~= 0 then
					local var_244_31 = manager.audio:GetVoiceLength("story_v_out_410142", "410142059", "story_v_out_410142.awb") / 1000

					if var_244_31 + var_244_23 > arg_241_1.duration_ then
						arg_241_1.duration_ = var_244_31 + var_244_23
					end

					if var_244_26.prefab_name ~= "" and arg_241_1.actors_[var_244_26.prefab_name] ~= nil then
						local var_244_32 = LuaForUtil.PlayVoiceWithCriLipsync(arg_241_1.actors_[var_244_26.prefab_name].transform, "story_v_out_410142", "410142059", "story_v_out_410142.awb")

						arg_241_1:RecordAudio("410142059", var_244_32)
						arg_241_1:RecordAudio("410142059", var_244_32)
					else
						arg_241_1:AudioAction("play", "voice", "story_v_out_410142", "410142059", "story_v_out_410142.awb")
					end

					arg_241_1:RecordHistoryTalkVoice("story_v_out_410142", "410142059", "story_v_out_410142.awb")
				end

				arg_241_1:RecordContent(arg_241_1.text_.text)
			end

			local var_244_33 = math.max(var_244_24, arg_241_1.talkMaxDuration)

			if var_244_23 <= arg_241_1.time_ and arg_241_1.time_ < var_244_23 + var_244_33 then
				arg_241_1.typewritter.percent = (arg_241_1.time_ - var_244_23) / var_244_33

				arg_241_1.typewritter:SetDirty()
			end

			if arg_241_1.time_ >= var_244_23 + var_244_33 and arg_241_1.time_ < var_244_23 + var_244_33 + arg_244_0 then
				arg_241_1.typewritter.percent = 1

				arg_241_1.typewritter:SetDirty()
				arg_241_1:ShowNextGo(true)
			end
		end

		arg_241_1.nodeConfigList_ = {
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

		arg_241_1:InitPlayNodeList()
	end,
	Play410142060 = function(arg_245_0, arg_245_1)
		arg_245_1.time_ = 0
		arg_245_1.frameCnt_ = 0
		arg_245_1.state_ = "playing"
		arg_245_1.curTalkId_ = 410142060
		arg_245_1.duration_ = 5

		SetActive(arg_245_1.tipsGo_, false)

		function arg_245_1.onSingleLineFinish_()
			arg_245_1.onSingleLineUpdate_ = nil
			arg_245_1.onSingleLineFinish_ = nil
			arg_245_1.state_ = "waiting"
		end

		function arg_245_1.playNext_(arg_247_0)
			if arg_247_0 == 1 then
				arg_245_0:Play410142061(arg_245_1)
			end
		end

		function arg_245_1.onSingleLineUpdate_(arg_248_0)
			local var_248_0 = arg_245_1.actors_["1061"]
			local var_248_1 = 0

			if var_248_1 < arg_245_1.time_ and arg_245_1.time_ <= var_248_1 + arg_248_0 and not isNil(var_248_0) and arg_245_1.var_.actorSpriteComps1061 == nil then
				arg_245_1.var_.actorSpriteComps1061 = var_248_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_248_2 = 0.034

			if var_248_1 <= arg_245_1.time_ and arg_245_1.time_ < var_248_1 + var_248_2 and not isNil(var_248_0) then
				local var_248_3 = (arg_245_1.time_ - var_248_1) / var_248_2

				if arg_245_1.var_.actorSpriteComps1061 then
					for iter_248_0, iter_248_1 in pairs(arg_245_1.var_.actorSpriteComps1061:ToTable()) do
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

			if arg_245_1.time_ >= var_248_1 + var_248_2 and arg_245_1.time_ < var_248_1 + var_248_2 + arg_248_0 and not isNil(var_248_0) and arg_245_1.var_.actorSpriteComps1061 then
				for iter_248_2, iter_248_3 in pairs(arg_245_1.var_.actorSpriteComps1061:ToTable()) do
					if iter_248_3 then
						if arg_245_1.isInRecall_ then
							iter_248_3.color = arg_245_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_248_3.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_245_1.var_.actorSpriteComps1061 = nil
			end

			local var_248_8 = arg_245_1.actors_["1056"]
			local var_248_9 = 0

			if var_248_9 < arg_245_1.time_ and arg_245_1.time_ <= var_248_9 + arg_248_0 and not isNil(var_248_8) and arg_245_1.var_.actorSpriteComps1056 == nil then
				arg_245_1.var_.actorSpriteComps1056 = var_248_8:GetComponentsInChildren(typeof(Image), true)
			end

			local var_248_10 = 0.034

			if var_248_9 <= arg_245_1.time_ and arg_245_1.time_ < var_248_9 + var_248_10 and not isNil(var_248_8) then
				local var_248_11 = (arg_245_1.time_ - var_248_9) / var_248_10

				if arg_245_1.var_.actorSpriteComps1056 then
					for iter_248_4, iter_248_5 in pairs(arg_245_1.var_.actorSpriteComps1056:ToTable()) do
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

			if arg_245_1.time_ >= var_248_9 + var_248_10 and arg_245_1.time_ < var_248_9 + var_248_10 + arg_248_0 and not isNil(var_248_8) and arg_245_1.var_.actorSpriteComps1056 then
				for iter_248_6, iter_248_7 in pairs(arg_245_1.var_.actorSpriteComps1056:ToTable()) do
					if iter_248_7 then
						if arg_245_1.isInRecall_ then
							iter_248_7.color = arg_245_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_248_7.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_245_1.var_.actorSpriteComps1056 = nil
			end

			local var_248_16 = 0
			local var_248_17 = 1.225

			if var_248_16 < arg_245_1.time_ and arg_245_1.time_ <= var_248_16 + arg_248_0 then
				arg_245_1.talkMaxDuration = 0
				arg_245_1.dialogCg_.alpha = 1

				arg_245_1.dialog_:SetActive(true)
				SetActive(arg_245_1.leftNameGo_, false)

				arg_245_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_245_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_245_1:RecordName(arg_245_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_245_1.iconTrs_.gameObject, false)
				arg_245_1.callingController_:SetSelectedState("normal")

				local var_248_18 = arg_245_1:GetWordFromCfg(410142060)
				local var_248_19 = arg_245_1:FormatText(var_248_18.content)

				arg_245_1.text_.text = var_248_19

				LuaForUtil.ClearLinePrefixSymbol(arg_245_1.text_)

				local var_248_20 = 49
				local var_248_21 = utf8.len(var_248_19)
				local var_248_22 = var_248_20 <= 0 and var_248_17 or var_248_17 * (var_248_21 / var_248_20)

				if var_248_22 > 0 and var_248_17 < var_248_22 then
					arg_245_1.talkMaxDuration = var_248_22

					if var_248_22 + var_248_16 > arg_245_1.duration_ then
						arg_245_1.duration_ = var_248_22 + var_248_16
					end
				end

				arg_245_1.text_.text = var_248_19
				arg_245_1.typewritter.percent = 0

				arg_245_1.typewritter:SetDirty()
				arg_245_1:ShowNextGo(false)
				arg_245_1:RecordContent(arg_245_1.text_.text)
			end

			local var_248_23 = math.max(var_248_17, arg_245_1.talkMaxDuration)

			if var_248_16 <= arg_245_1.time_ and arg_245_1.time_ < var_248_16 + var_248_23 then
				arg_245_1.typewritter.percent = (arg_245_1.time_ - var_248_16) / var_248_23

				arg_245_1.typewritter:SetDirty()
			end

			if arg_245_1.time_ >= var_248_16 + var_248_23 and arg_245_1.time_ < var_248_16 + var_248_23 + arg_248_0 then
				arg_245_1.typewritter.percent = 1

				arg_245_1.typewritter:SetDirty()
				arg_245_1:ShowNextGo(true)
			end
		end

		arg_245_1.nodeConfigList_ = {}

		arg_245_1:InitPlayNodeList()
	end,
	Play410142061 = function(arg_249_0, arg_249_1)
		arg_249_1.time_ = 0
		arg_249_1.frameCnt_ = 0
		arg_249_1.state_ = "playing"
		arg_249_1.curTalkId_ = 410142061
		arg_249_1.duration_ = 4.3

		local var_249_0 = {
			ja = 4.3,
			CriLanguages = 1.633,
			zh = 1.633
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
				arg_249_0:Play410142062(arg_249_1)
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
				local var_252_6 = Vector3.New(0, -350, -180)

				var_252_0.localPosition = Vector3.Lerp(arg_249_1.var_.moveOldPos1056, var_252_6, var_252_5)
			end

			if arg_249_1.time_ >= var_252_1 + var_252_4 and arg_249_1.time_ < var_252_1 + var_252_4 + arg_252_0 then
				var_252_0.localPosition = Vector3.New(0, -350, -180)
			end

			local var_252_7 = arg_249_1.actors_["1061"].transform
			local var_252_8 = 0

			if var_252_8 < arg_249_1.time_ and arg_249_1.time_ <= var_252_8 + arg_252_0 then
				arg_249_1.var_.moveOldPos1061 = var_252_7.localPosition
				var_252_7.localScale = Vector3.New(1, 1, 1)

				arg_249_1:CheckSpriteTmpPos("1061", 7)

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
				local var_252_13 = Vector3.New(0, -2000, 18)

				var_252_7.localPosition = Vector3.Lerp(arg_249_1.var_.moveOldPos1061, var_252_13, var_252_12)
			end

			if arg_249_1.time_ >= var_252_8 + var_252_11 and arg_249_1.time_ < var_252_8 + var_252_11 + arg_252_0 then
				var_252_7.localPosition = Vector3.New(0, -2000, 18)
			end

			local var_252_14 = arg_249_1.actors_["1056"]
			local var_252_15 = 0

			if var_252_15 < arg_249_1.time_ and arg_249_1.time_ <= var_252_15 + arg_252_0 and not isNil(var_252_14) and arg_249_1.var_.actorSpriteComps1056 == nil then
				arg_249_1.var_.actorSpriteComps1056 = var_252_14:GetComponentsInChildren(typeof(Image), true)
			end

			local var_252_16 = 0.034

			if var_252_15 <= arg_249_1.time_ and arg_249_1.time_ < var_252_15 + var_252_16 and not isNil(var_252_14) then
				local var_252_17 = (arg_249_1.time_ - var_252_15) / var_252_16

				if arg_249_1.var_.actorSpriteComps1056 then
					for iter_252_2, iter_252_3 in pairs(arg_249_1.var_.actorSpriteComps1056:ToTable()) do
						if iter_252_3 then
							if arg_249_1.isInRecall_ then
								local var_252_18 = Mathf.Lerp(iter_252_3.color.r, arg_249_1.hightColor1.r, var_252_17)
								local var_252_19 = Mathf.Lerp(iter_252_3.color.g, arg_249_1.hightColor1.g, var_252_17)
								local var_252_20 = Mathf.Lerp(iter_252_3.color.b, arg_249_1.hightColor1.b, var_252_17)

								iter_252_3.color = Color.New(var_252_18, var_252_19, var_252_20)
							else
								local var_252_21 = Mathf.Lerp(iter_252_3.color.r, 1, var_252_17)

								iter_252_3.color = Color.New(var_252_21, var_252_21, var_252_21)
							end
						end
					end
				end
			end

			if arg_249_1.time_ >= var_252_15 + var_252_16 and arg_249_1.time_ < var_252_15 + var_252_16 + arg_252_0 and not isNil(var_252_14) and arg_249_1.var_.actorSpriteComps1056 then
				for iter_252_4, iter_252_5 in pairs(arg_249_1.var_.actorSpriteComps1056:ToTable()) do
					if iter_252_5 then
						if arg_249_1.isInRecall_ then
							iter_252_5.color = arg_249_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_252_5.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_249_1.var_.actorSpriteComps1056 = nil
			end

			local var_252_22 = arg_249_1.actors_["1061"]
			local var_252_23 = 0

			if var_252_23 < arg_249_1.time_ and arg_249_1.time_ <= var_252_23 + arg_252_0 and not isNil(var_252_22) and arg_249_1.var_.actorSpriteComps1061 == nil then
				arg_249_1.var_.actorSpriteComps1061 = var_252_22:GetComponentsInChildren(typeof(Image), true)
			end

			local var_252_24 = 0.034

			if var_252_23 <= arg_249_1.time_ and arg_249_1.time_ < var_252_23 + var_252_24 and not isNil(var_252_22) then
				local var_252_25 = (arg_249_1.time_ - var_252_23) / var_252_24

				if arg_249_1.var_.actorSpriteComps1061 then
					for iter_252_6, iter_252_7 in pairs(arg_249_1.var_.actorSpriteComps1061:ToTable()) do
						if iter_252_7 then
							if arg_249_1.isInRecall_ then
								local var_252_26 = Mathf.Lerp(iter_252_7.color.r, arg_249_1.hightColor2.r, var_252_25)
								local var_252_27 = Mathf.Lerp(iter_252_7.color.g, arg_249_1.hightColor2.g, var_252_25)
								local var_252_28 = Mathf.Lerp(iter_252_7.color.b, arg_249_1.hightColor2.b, var_252_25)

								iter_252_7.color = Color.New(var_252_26, var_252_27, var_252_28)
							else
								local var_252_29 = Mathf.Lerp(iter_252_7.color.r, 0.5, var_252_25)

								iter_252_7.color = Color.New(var_252_29, var_252_29, var_252_29)
							end
						end
					end
				end
			end

			if arg_249_1.time_ >= var_252_23 + var_252_24 and arg_249_1.time_ < var_252_23 + var_252_24 + arg_252_0 and not isNil(var_252_22) and arg_249_1.var_.actorSpriteComps1061 then
				for iter_252_8, iter_252_9 in pairs(arg_249_1.var_.actorSpriteComps1061:ToTable()) do
					if iter_252_9 then
						if arg_249_1.isInRecall_ then
							iter_252_9.color = arg_249_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_252_9.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_249_1.var_.actorSpriteComps1061 = nil
			end

			local var_252_30 = 0
			local var_252_31 = 0.175

			if var_252_30 < arg_249_1.time_ and arg_249_1.time_ <= var_252_30 + arg_252_0 then
				arg_249_1.talkMaxDuration = 0
				arg_249_1.dialogCg_.alpha = 1

				arg_249_1.dialog_:SetActive(true)
				SetActive(arg_249_1.leftNameGo_, true)

				local var_252_32 = arg_249_1:FormatText(StoryNameCfg[605].name)

				arg_249_1.leftNameTxt_.text = var_252_32

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_249_1.leftNameTxt_.transform)

				arg_249_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_249_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_249_1:RecordName(arg_249_1.leftNameTxt_.text)
				SetActive(arg_249_1.iconTrs_.gameObject, false)
				arg_249_1.callingController_:SetSelectedState("normal")

				local var_252_33 = arg_249_1:GetWordFromCfg(410142061)
				local var_252_34 = arg_249_1:FormatText(var_252_33.content)

				arg_249_1.text_.text = var_252_34

				LuaForUtil.ClearLinePrefixSymbol(arg_249_1.text_)

				local var_252_35 = 7
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

				if manager.audio:GetVoiceLength("story_v_out_410142", "410142061", "story_v_out_410142.awb") ~= 0 then
					local var_252_38 = manager.audio:GetVoiceLength("story_v_out_410142", "410142061", "story_v_out_410142.awb") / 1000

					if var_252_38 + var_252_30 > arg_249_1.duration_ then
						arg_249_1.duration_ = var_252_38 + var_252_30
					end

					if var_252_33.prefab_name ~= "" and arg_249_1.actors_[var_252_33.prefab_name] ~= nil then
						local var_252_39 = LuaForUtil.PlayVoiceWithCriLipsync(arg_249_1.actors_[var_252_33.prefab_name].transform, "story_v_out_410142", "410142061", "story_v_out_410142.awb")

						arg_249_1:RecordAudio("410142061", var_252_39)
						arg_249_1:RecordAudio("410142061", var_252_39)
					else
						arg_249_1:AudioAction("play", "voice", "story_v_out_410142", "410142061", "story_v_out_410142.awb")
					end

					arg_249_1:RecordHistoryTalkVoice("story_v_out_410142", "410142061", "story_v_out_410142.awb")
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
				actorName = "1061",
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
	Play410142062 = function(arg_253_0, arg_253_1)
		arg_253_1.time_ = 0
		arg_253_1.frameCnt_ = 0
		arg_253_1.state_ = "playing"
		arg_253_1.curTalkId_ = 410142062
		arg_253_1.duration_ = 5

		SetActive(arg_253_1.tipsGo_, false)

		function arg_253_1.onSingleLineFinish_()
			arg_253_1.onSingleLineUpdate_ = nil
			arg_253_1.onSingleLineFinish_ = nil
			arg_253_1.state_ = "waiting"
		end

		function arg_253_1.playNext_(arg_255_0)
			if arg_255_0 == 1 then
				arg_253_0:Play410142063(arg_253_1)
			end
		end

		function arg_253_1.onSingleLineUpdate_(arg_256_0)
			local var_256_0 = arg_253_1.actors_["1056"].transform
			local var_256_1 = 0

			if var_256_1 < arg_253_1.time_ and arg_253_1.time_ <= var_256_1 + arg_256_0 then
				arg_253_1.var_.moveOldPos1056 = var_256_0.localPosition
				var_256_0.localScale = Vector3.New(1, 1, 1)

				arg_253_1:CheckSpriteTmpPos("1056", 2)

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
				local var_256_6 = Vector3.New(-390, -350, -180)

				var_256_0.localPosition = Vector3.Lerp(arg_253_1.var_.moveOldPos1056, var_256_6, var_256_5)
			end

			if arg_253_1.time_ >= var_256_1 + var_256_4 and arg_253_1.time_ < var_256_1 + var_256_4 + arg_256_0 then
				var_256_0.localPosition = Vector3.New(-390, -350, -180)
			end

			local var_256_7 = "10061"

			if arg_253_1.actors_[var_256_7] == nil then
				local var_256_8 = Asset.Load("Widget/System/Story/StoryExpression/" .. "10061")

				if not isNil(var_256_8) then
					local var_256_9 = Object.Instantiate(var_256_8, arg_253_1.canvasGo_.transform)

					var_256_9.transform:SetSiblingIndex(1)

					var_256_9.name = var_256_7
					var_256_9.transform.localPosition = Vector3.New(0, 100000, 0)
					arg_253_1.actors_[var_256_7] = var_256_9

					local var_256_10 = var_256_9:GetComponentsInChildren(typeof(Image), true):ToTable()

					if arg_253_1.isInRecall_ then
						for iter_256_1, iter_256_2 in ipairs(var_256_10) do
							iter_256_2.color = arg_253_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						end
					end
				end
			end

			local var_256_11 = arg_253_1.actors_["10061"].transform
			local var_256_12 = 0

			if var_256_12 < arg_253_1.time_ and arg_253_1.time_ <= var_256_12 + arg_256_0 then
				arg_253_1.var_.moveOldPos10061 = var_256_11.localPosition
				var_256_11.localScale = Vector3.New(1, 1, 1)

				arg_253_1:CheckSpriteTmpPos("10061", 4)

				local var_256_13 = var_256_11.childCount

				for iter_256_3 = 0, var_256_13 - 1 do
					local var_256_14 = var_256_11:GetChild(iter_256_3)

					if var_256_14.name == "" or not string.find(var_256_14.name, "split") then
						var_256_14.gameObject:SetActive(true)
					else
						var_256_14.gameObject:SetActive(false)
					end
				end
			end

			local var_256_15 = 0.001

			if var_256_12 <= arg_253_1.time_ and arg_253_1.time_ < var_256_12 + var_256_15 then
				local var_256_16 = (arg_253_1.time_ - var_256_12) / var_256_15
				local var_256_17 = Vector3.New(390, -517.5, -100)

				var_256_11.localPosition = Vector3.Lerp(arg_253_1.var_.moveOldPos10061, var_256_17, var_256_16)
			end

			if arg_253_1.time_ >= var_256_12 + var_256_15 and arg_253_1.time_ < var_256_12 + var_256_15 + arg_256_0 then
				var_256_11.localPosition = Vector3.New(390, -517.5, -100)
			end

			local var_256_18 = arg_253_1.actors_["1056"]
			local var_256_19 = 0

			if var_256_19 < arg_253_1.time_ and arg_253_1.time_ <= var_256_19 + arg_256_0 and not isNil(var_256_18) and arg_253_1.var_.actorSpriteComps1056 == nil then
				arg_253_1.var_.actorSpriteComps1056 = var_256_18:GetComponentsInChildren(typeof(Image), true)
			end

			local var_256_20 = 0.034

			if var_256_19 <= arg_253_1.time_ and arg_253_1.time_ < var_256_19 + var_256_20 and not isNil(var_256_18) then
				local var_256_21 = (arg_253_1.time_ - var_256_19) / var_256_20

				if arg_253_1.var_.actorSpriteComps1056 then
					for iter_256_4, iter_256_5 in pairs(arg_253_1.var_.actorSpriteComps1056:ToTable()) do
						if iter_256_5 then
							if arg_253_1.isInRecall_ then
								local var_256_22 = Mathf.Lerp(iter_256_5.color.r, arg_253_1.hightColor2.r, var_256_21)
								local var_256_23 = Mathf.Lerp(iter_256_5.color.g, arg_253_1.hightColor2.g, var_256_21)
								local var_256_24 = Mathf.Lerp(iter_256_5.color.b, arg_253_1.hightColor2.b, var_256_21)

								iter_256_5.color = Color.New(var_256_22, var_256_23, var_256_24)
							else
								local var_256_25 = Mathf.Lerp(iter_256_5.color.r, 0.5, var_256_21)

								iter_256_5.color = Color.New(var_256_25, var_256_25, var_256_25)
							end
						end
					end
				end
			end

			if arg_253_1.time_ >= var_256_19 + var_256_20 and arg_253_1.time_ < var_256_19 + var_256_20 + arg_256_0 and not isNil(var_256_18) and arg_253_1.var_.actorSpriteComps1056 then
				for iter_256_6, iter_256_7 in pairs(arg_253_1.var_.actorSpriteComps1056:ToTable()) do
					if iter_256_7 then
						if arg_253_1.isInRecall_ then
							iter_256_7.color = arg_253_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_256_7.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_253_1.var_.actorSpriteComps1056 = nil
			end

			local var_256_26 = arg_253_1.actors_["10061"]
			local var_256_27 = 0

			if var_256_27 < arg_253_1.time_ and arg_253_1.time_ <= var_256_27 + arg_256_0 and not isNil(var_256_26) and arg_253_1.var_.actorSpriteComps10061 == nil then
				arg_253_1.var_.actorSpriteComps10061 = var_256_26:GetComponentsInChildren(typeof(Image), true)
			end

			local var_256_28 = 0.034

			if var_256_27 <= arg_253_1.time_ and arg_253_1.time_ < var_256_27 + var_256_28 and not isNil(var_256_26) then
				local var_256_29 = (arg_253_1.time_ - var_256_27) / var_256_28

				if arg_253_1.var_.actorSpriteComps10061 then
					for iter_256_8, iter_256_9 in pairs(arg_253_1.var_.actorSpriteComps10061:ToTable()) do
						if iter_256_9 then
							if arg_253_1.isInRecall_ then
								local var_256_30 = Mathf.Lerp(iter_256_9.color.r, arg_253_1.hightColor2.r, var_256_29)
								local var_256_31 = Mathf.Lerp(iter_256_9.color.g, arg_253_1.hightColor2.g, var_256_29)
								local var_256_32 = Mathf.Lerp(iter_256_9.color.b, arg_253_1.hightColor2.b, var_256_29)

								iter_256_9.color = Color.New(var_256_30, var_256_31, var_256_32)
							else
								local var_256_33 = Mathf.Lerp(iter_256_9.color.r, 0.5, var_256_29)

								iter_256_9.color = Color.New(var_256_33, var_256_33, var_256_33)
							end
						end
					end
				end
			end

			if arg_253_1.time_ >= var_256_27 + var_256_28 and arg_253_1.time_ < var_256_27 + var_256_28 + arg_256_0 and not isNil(var_256_26) and arg_253_1.var_.actorSpriteComps10061 then
				for iter_256_10, iter_256_11 in pairs(arg_253_1.var_.actorSpriteComps10061:ToTable()) do
					if iter_256_11 then
						if arg_253_1.isInRecall_ then
							iter_256_11.color = arg_253_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_256_11.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_253_1.var_.actorSpriteComps10061 = nil
			end

			local var_256_34 = 0
			local var_256_35 = 0.8

			if var_256_34 < arg_253_1.time_ and arg_253_1.time_ <= var_256_34 + arg_256_0 then
				arg_253_1.talkMaxDuration = 0
				arg_253_1.dialogCg_.alpha = 1

				arg_253_1.dialog_:SetActive(true)
				SetActive(arg_253_1.leftNameGo_, false)

				arg_253_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_253_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_253_1:RecordName(arg_253_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_253_1.iconTrs_.gameObject, false)
				arg_253_1.callingController_:SetSelectedState("normal")

				local var_256_36 = arg_253_1:GetWordFromCfg(410142062)
				local var_256_37 = arg_253_1:FormatText(var_256_36.content)

				arg_253_1.text_.text = var_256_37

				LuaForUtil.ClearLinePrefixSymbol(arg_253_1.text_)

				local var_256_38 = 32
				local var_256_39 = utf8.len(var_256_37)
				local var_256_40 = var_256_38 <= 0 and var_256_35 or var_256_35 * (var_256_39 / var_256_38)

				if var_256_40 > 0 and var_256_35 < var_256_40 then
					arg_253_1.talkMaxDuration = var_256_40

					if var_256_40 + var_256_34 > arg_253_1.duration_ then
						arg_253_1.duration_ = var_256_40 + var_256_34
					end
				end

				arg_253_1.text_.text = var_256_37
				arg_253_1.typewritter.percent = 0

				arg_253_1.typewritter:SetDirty()
				arg_253_1:ShowNextGo(false)
				arg_253_1:RecordContent(arg_253_1.text_.text)
			end

			local var_256_41 = math.max(var_256_35, arg_253_1.talkMaxDuration)

			if var_256_34 <= arg_253_1.time_ and arg_253_1.time_ < var_256_34 + var_256_41 then
				arg_253_1.typewritter.percent = (arg_253_1.time_ - var_256_34) / var_256_41

				arg_253_1.typewritter:SetDirty()
			end

			if arg_253_1.time_ >= var_256_34 + var_256_41 and arg_253_1.time_ < var_256_34 + var_256_41 + arg_256_0 then
				arg_253_1.typewritter.percent = 1

				arg_253_1.typewritter:SetDirty()
				arg_253_1:ShowNextGo(true)
			end
		end

		arg_253_1.nodeConfigList_ = {
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
				actorName = "10061",
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
	Play410142063 = function(arg_257_0, arg_257_1)
		arg_257_1.time_ = 0
		arg_257_1.frameCnt_ = 0
		arg_257_1.state_ = "playing"
		arg_257_1.curTalkId_ = 410142063
		arg_257_1.duration_ = 5

		SetActive(arg_257_1.tipsGo_, false)

		function arg_257_1.onSingleLineFinish_()
			arg_257_1.onSingleLineUpdate_ = nil
			arg_257_1.onSingleLineFinish_ = nil
			arg_257_1.state_ = "waiting"
		end

		function arg_257_1.playNext_(arg_259_0)
			if arg_259_0 == 1 then
				arg_257_0:Play410142064(arg_257_1)
			end
		end

		function arg_257_1.onSingleLineUpdate_(arg_260_0)
			local var_260_0 = 0
			local var_260_1 = 0.775

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

				local var_260_2 = arg_257_1:GetWordFromCfg(410142063)
				local var_260_3 = arg_257_1:FormatText(var_260_2.content)

				arg_257_1.text_.text = var_260_3

				LuaForUtil.ClearLinePrefixSymbol(arg_257_1.text_)

				local var_260_4 = 31
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
	Play410142064 = function(arg_261_0, arg_261_1)
		arg_261_1.time_ = 0
		arg_261_1.frameCnt_ = 0
		arg_261_1.state_ = "playing"
		arg_261_1.curTalkId_ = 410142064
		arg_261_1.duration_ = 6.93

		local var_261_0 = {
			ja = 6.933,
			CriLanguages = 3.1,
			zh = 3.1
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
				arg_261_0:Play410142065(arg_261_1)
			end
		end

		function arg_261_1.onSingleLineUpdate_(arg_264_0)
			local var_264_0 = arg_261_1.actors_["10061"].transform
			local var_264_1 = 0

			if var_264_1 < arg_261_1.time_ and arg_261_1.time_ <= var_264_1 + arg_264_0 then
				arg_261_1.var_.moveOldPos10061 = var_264_0.localPosition
				var_264_0.localScale = Vector3.New(1, 1, 1)

				arg_261_1:CheckSpriteTmpPos("10061", 4)

				local var_264_2 = var_264_0.childCount

				for iter_264_0 = 0, var_264_2 - 1 do
					local var_264_3 = var_264_0:GetChild(iter_264_0)

					if var_264_3.name == "split_5" or not string.find(var_264_3.name, "split") then
						var_264_3.gameObject:SetActive(true)
					else
						var_264_3.gameObject:SetActive(false)
					end
				end
			end

			local var_264_4 = 0.001

			if var_264_1 <= arg_261_1.time_ and arg_261_1.time_ < var_264_1 + var_264_4 then
				local var_264_5 = (arg_261_1.time_ - var_264_1) / var_264_4
				local var_264_6 = Vector3.New(390, -517.5, -100)

				var_264_0.localPosition = Vector3.Lerp(arg_261_1.var_.moveOldPos10061, var_264_6, var_264_5)
			end

			if arg_261_1.time_ >= var_264_1 + var_264_4 and arg_261_1.time_ < var_264_1 + var_264_4 + arg_264_0 then
				var_264_0.localPosition = Vector3.New(390, -517.5, -100)
			end

			local var_264_7 = arg_261_1.actors_["10061"]
			local var_264_8 = 0

			if var_264_8 < arg_261_1.time_ and arg_261_1.time_ <= var_264_8 + arg_264_0 and not isNil(var_264_7) and arg_261_1.var_.actorSpriteComps10061 == nil then
				arg_261_1.var_.actorSpriteComps10061 = var_264_7:GetComponentsInChildren(typeof(Image), true)
			end

			local var_264_9 = 0.034

			if var_264_8 <= arg_261_1.time_ and arg_261_1.time_ < var_264_8 + var_264_9 and not isNil(var_264_7) then
				local var_264_10 = (arg_261_1.time_ - var_264_8) / var_264_9

				if arg_261_1.var_.actorSpriteComps10061 then
					for iter_264_1, iter_264_2 in pairs(arg_261_1.var_.actorSpriteComps10061:ToTable()) do
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

			if arg_261_1.time_ >= var_264_8 + var_264_9 and arg_261_1.time_ < var_264_8 + var_264_9 + arg_264_0 and not isNil(var_264_7) and arg_261_1.var_.actorSpriteComps10061 then
				for iter_264_3, iter_264_4 in pairs(arg_261_1.var_.actorSpriteComps10061:ToTable()) do
					if iter_264_4 then
						if arg_261_1.isInRecall_ then
							iter_264_4.color = arg_261_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_264_4.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_261_1.var_.actorSpriteComps10061 = nil
			end

			local var_264_15 = 0
			local var_264_16 = 0.25

			if var_264_15 < arg_261_1.time_ and arg_261_1.time_ <= var_264_15 + arg_264_0 then
				arg_261_1.talkMaxDuration = 0
				arg_261_1.dialogCg_.alpha = 1

				arg_261_1.dialog_:SetActive(true)
				SetActive(arg_261_1.leftNameGo_, true)

				local var_264_17 = arg_261_1:FormatText(StoryNameCfg[591].name)

				arg_261_1.leftNameTxt_.text = var_264_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_261_1.leftNameTxt_.transform)

				arg_261_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_261_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_261_1:RecordName(arg_261_1.leftNameTxt_.text)
				SetActive(arg_261_1.iconTrs_.gameObject, false)
				arg_261_1.callingController_:SetSelectedState("normal")

				local var_264_18 = arg_261_1:GetWordFromCfg(410142064)
				local var_264_19 = arg_261_1:FormatText(var_264_18.content)

				arg_261_1.text_.text = var_264_19

				LuaForUtil.ClearLinePrefixSymbol(arg_261_1.text_)

				local var_264_20 = 10
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

				if manager.audio:GetVoiceLength("story_v_out_410142", "410142064", "story_v_out_410142.awb") ~= 0 then
					local var_264_23 = manager.audio:GetVoiceLength("story_v_out_410142", "410142064", "story_v_out_410142.awb") / 1000

					if var_264_23 + var_264_15 > arg_261_1.duration_ then
						arg_261_1.duration_ = var_264_23 + var_264_15
					end

					if var_264_18.prefab_name ~= "" and arg_261_1.actors_[var_264_18.prefab_name] ~= nil then
						local var_264_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_261_1.actors_[var_264_18.prefab_name].transform, "story_v_out_410142", "410142064", "story_v_out_410142.awb")

						arg_261_1:RecordAudio("410142064", var_264_24)
						arg_261_1:RecordAudio("410142064", var_264_24)
					else
						arg_261_1:AudioAction("play", "voice", "story_v_out_410142", "410142064", "story_v_out_410142.awb")
					end

					arg_261_1:RecordHistoryTalkVoice("story_v_out_410142", "410142064", "story_v_out_410142.awb")
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
				actorName = "10061",
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
	Play410142065 = function(arg_265_0, arg_265_1)
		arg_265_1.time_ = 0
		arg_265_1.frameCnt_ = 0
		arg_265_1.state_ = "playing"
		arg_265_1.curTalkId_ = 410142065
		arg_265_1.duration_ = 7.93

		local var_265_0 = {
			ja = 7.8,
			CriLanguages = 7.933,
			zh = 7.933
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
				arg_265_0:Play410142066(arg_265_1)
			end
		end

		function arg_265_1.onSingleLineUpdate_(arg_268_0)
			local var_268_0 = arg_265_1.actors_["1056"].transform
			local var_268_1 = 0

			if var_268_1 < arg_265_1.time_ and arg_265_1.time_ <= var_268_1 + arg_268_0 then
				arg_265_1.var_.moveOldPos1056 = var_268_0.localPosition
				var_268_0.localScale = Vector3.New(1, 1, 1)

				arg_265_1:CheckSpriteTmpPos("1056", 2)

				local var_268_2 = var_268_0.childCount

				for iter_268_0 = 0, var_268_2 - 1 do
					local var_268_3 = var_268_0:GetChild(iter_268_0)

					if var_268_3.name == "split_1" or not string.find(var_268_3.name, "split") then
						var_268_3.gameObject:SetActive(true)
					else
						var_268_3.gameObject:SetActive(false)
					end
				end
			end

			local var_268_4 = 0.001

			if var_268_1 <= arg_265_1.time_ and arg_265_1.time_ < var_268_1 + var_268_4 then
				local var_268_5 = (arg_265_1.time_ - var_268_1) / var_268_4
				local var_268_6 = Vector3.New(-390, -350, -180)

				var_268_0.localPosition = Vector3.Lerp(arg_265_1.var_.moveOldPos1056, var_268_6, var_268_5)
			end

			if arg_265_1.time_ >= var_268_1 + var_268_4 and arg_265_1.time_ < var_268_1 + var_268_4 + arg_268_0 then
				var_268_0.localPosition = Vector3.New(-390, -350, -180)
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

			local var_268_15 = arg_265_1.actors_["10061"]
			local var_268_16 = 0

			if var_268_16 < arg_265_1.time_ and arg_265_1.time_ <= var_268_16 + arg_268_0 and not isNil(var_268_15) and arg_265_1.var_.actorSpriteComps10061 == nil then
				arg_265_1.var_.actorSpriteComps10061 = var_268_15:GetComponentsInChildren(typeof(Image), true)
			end

			local var_268_17 = 0.034

			if var_268_16 <= arg_265_1.time_ and arg_265_1.time_ < var_268_16 + var_268_17 and not isNil(var_268_15) then
				local var_268_18 = (arg_265_1.time_ - var_268_16) / var_268_17

				if arg_265_1.var_.actorSpriteComps10061 then
					for iter_268_5, iter_268_6 in pairs(arg_265_1.var_.actorSpriteComps10061:ToTable()) do
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

			if arg_265_1.time_ >= var_268_16 + var_268_17 and arg_265_1.time_ < var_268_16 + var_268_17 + arg_268_0 and not isNil(var_268_15) and arg_265_1.var_.actorSpriteComps10061 then
				for iter_268_7, iter_268_8 in pairs(arg_265_1.var_.actorSpriteComps10061:ToTable()) do
					if iter_268_8 then
						if arg_265_1.isInRecall_ then
							iter_268_8.color = arg_265_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_268_8.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_265_1.var_.actorSpriteComps10061 = nil
			end

			local var_268_23 = 0
			local var_268_24 = 1.05

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

				local var_268_26 = arg_265_1:GetWordFromCfg(410142065)
				local var_268_27 = arg_265_1:FormatText(var_268_26.content)

				arg_265_1.text_.text = var_268_27

				LuaForUtil.ClearLinePrefixSymbol(arg_265_1.text_)

				local var_268_28 = 42
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

				if manager.audio:GetVoiceLength("story_v_out_410142", "410142065", "story_v_out_410142.awb") ~= 0 then
					local var_268_31 = manager.audio:GetVoiceLength("story_v_out_410142", "410142065", "story_v_out_410142.awb") / 1000

					if var_268_31 + var_268_23 > arg_265_1.duration_ then
						arg_265_1.duration_ = var_268_31 + var_268_23
					end

					if var_268_26.prefab_name ~= "" and arg_265_1.actors_[var_268_26.prefab_name] ~= nil then
						local var_268_32 = LuaForUtil.PlayVoiceWithCriLipsync(arg_265_1.actors_[var_268_26.prefab_name].transform, "story_v_out_410142", "410142065", "story_v_out_410142.awb")

						arg_265_1:RecordAudio("410142065", var_268_32)
						arg_265_1:RecordAudio("410142065", var_268_32)
					else
						arg_265_1:AudioAction("play", "voice", "story_v_out_410142", "410142065", "story_v_out_410142.awb")
					end

					arg_265_1:RecordHistoryTalkVoice("story_v_out_410142", "410142065", "story_v_out_410142.awb")
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
	Play410142066 = function(arg_269_0, arg_269_1)
		arg_269_1.time_ = 0
		arg_269_1.frameCnt_ = 0
		arg_269_1.state_ = "playing"
		arg_269_1.curTalkId_ = 410142066
		arg_269_1.duration_ = 9.97

		local var_269_0 = {
			ja = 9.966,
			CriLanguages = 6.3,
			zh = 6.3
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
				arg_269_0:Play410142067(arg_269_1)
			end
		end

		function arg_269_1.onSingleLineUpdate_(arg_272_0)
			local var_272_0 = arg_269_1.actors_["10061"].transform
			local var_272_1 = 0

			if var_272_1 < arg_269_1.time_ and arg_269_1.time_ <= var_272_1 + arg_272_0 then
				arg_269_1.var_.moveOldPos10061 = var_272_0.localPosition
				var_272_0.localScale = Vector3.New(1, 1, 1)

				arg_269_1:CheckSpriteTmpPos("10061", 4)

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
				local var_272_6 = Vector3.New(390, -517.5, -100)

				var_272_0.localPosition = Vector3.Lerp(arg_269_1.var_.moveOldPos10061, var_272_6, var_272_5)
			end

			if arg_269_1.time_ >= var_272_1 + var_272_4 and arg_269_1.time_ < var_272_1 + var_272_4 + arg_272_0 then
				var_272_0.localPosition = Vector3.New(390, -517.5, -100)
			end

			local var_272_7 = arg_269_1.actors_["1061"].transform
			local var_272_8 = 0

			if var_272_8 < arg_269_1.time_ and arg_269_1.time_ <= var_272_8 + arg_272_0 then
				arg_269_1.var_.moveOldPos1061 = var_272_7.localPosition
				var_272_7.localScale = Vector3.New(1, 1, 1)

				arg_269_1:CheckSpriteTmpPos("1061", 2)

				local var_272_9 = var_272_7.childCount

				for iter_272_1 = 0, var_272_9 - 1 do
					local var_272_10 = var_272_7:GetChild(iter_272_1)

					if var_272_10.name == "" or not string.find(var_272_10.name, "split") then
						var_272_10.gameObject:SetActive(true)
					else
						var_272_10.gameObject:SetActive(false)
					end
				end
			end

			local var_272_11 = 0.001

			if var_272_8 <= arg_269_1.time_ and arg_269_1.time_ < var_272_8 + var_272_11 then
				local var_272_12 = (arg_269_1.time_ - var_272_8) / var_272_11
				local var_272_13 = Vector3.New(-390, -490, 18)

				var_272_7.localPosition = Vector3.Lerp(arg_269_1.var_.moveOldPos1061, var_272_13, var_272_12)
			end

			if arg_269_1.time_ >= var_272_8 + var_272_11 and arg_269_1.time_ < var_272_8 + var_272_11 + arg_272_0 then
				var_272_7.localPosition = Vector3.New(-390, -490, 18)
			end

			local var_272_14 = arg_269_1.actors_["1056"].transform
			local var_272_15 = 0

			if var_272_15 < arg_269_1.time_ and arg_269_1.time_ <= var_272_15 + arg_272_0 then
				arg_269_1.var_.moveOldPos1056 = var_272_14.localPosition
				var_272_14.localScale = Vector3.New(1, 1, 1)

				arg_269_1:CheckSpriteTmpPos("1056", 7)

				local var_272_16 = var_272_14.childCount

				for iter_272_2 = 0, var_272_16 - 1 do
					local var_272_17 = var_272_14:GetChild(iter_272_2)

					if var_272_17.name == "" or not string.find(var_272_17.name, "split") then
						var_272_17.gameObject:SetActive(true)
					else
						var_272_17.gameObject:SetActive(false)
					end
				end
			end

			local var_272_18 = 0.001

			if var_272_15 <= arg_269_1.time_ and arg_269_1.time_ < var_272_15 + var_272_18 then
				local var_272_19 = (arg_269_1.time_ - var_272_15) / var_272_18
				local var_272_20 = Vector3.New(0, -2000, -180)

				var_272_14.localPosition = Vector3.Lerp(arg_269_1.var_.moveOldPos1056, var_272_20, var_272_19)
			end

			if arg_269_1.time_ >= var_272_15 + var_272_18 and arg_269_1.time_ < var_272_15 + var_272_18 + arg_272_0 then
				var_272_14.localPosition = Vector3.New(0, -2000, -180)
			end

			local var_272_21 = arg_269_1.actors_["10061"]
			local var_272_22 = 0

			if var_272_22 < arg_269_1.time_ and arg_269_1.time_ <= var_272_22 + arg_272_0 and not isNil(var_272_21) and arg_269_1.var_.actorSpriteComps10061 == nil then
				arg_269_1.var_.actorSpriteComps10061 = var_272_21:GetComponentsInChildren(typeof(Image), true)
			end

			local var_272_23 = 0.034

			if var_272_22 <= arg_269_1.time_ and arg_269_1.time_ < var_272_22 + var_272_23 and not isNil(var_272_21) then
				local var_272_24 = (arg_269_1.time_ - var_272_22) / var_272_23

				if arg_269_1.var_.actorSpriteComps10061 then
					for iter_272_3, iter_272_4 in pairs(arg_269_1.var_.actorSpriteComps10061:ToTable()) do
						if iter_272_4 then
							if arg_269_1.isInRecall_ then
								local var_272_25 = Mathf.Lerp(iter_272_4.color.r, arg_269_1.hightColor1.r, var_272_24)
								local var_272_26 = Mathf.Lerp(iter_272_4.color.g, arg_269_1.hightColor1.g, var_272_24)
								local var_272_27 = Mathf.Lerp(iter_272_4.color.b, arg_269_1.hightColor1.b, var_272_24)

								iter_272_4.color = Color.New(var_272_25, var_272_26, var_272_27)
							else
								local var_272_28 = Mathf.Lerp(iter_272_4.color.r, 1, var_272_24)

								iter_272_4.color = Color.New(var_272_28, var_272_28, var_272_28)
							end
						end
					end
				end
			end

			if arg_269_1.time_ >= var_272_22 + var_272_23 and arg_269_1.time_ < var_272_22 + var_272_23 + arg_272_0 and not isNil(var_272_21) and arg_269_1.var_.actorSpriteComps10061 then
				for iter_272_5, iter_272_6 in pairs(arg_269_1.var_.actorSpriteComps10061:ToTable()) do
					if iter_272_6 then
						if arg_269_1.isInRecall_ then
							iter_272_6.color = arg_269_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_272_6.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_269_1.var_.actorSpriteComps10061 = nil
			end

			local var_272_29 = arg_269_1.actors_["1061"]
			local var_272_30 = 0

			if var_272_30 < arg_269_1.time_ and arg_269_1.time_ <= var_272_30 + arg_272_0 and not isNil(var_272_29) and arg_269_1.var_.actorSpriteComps1061 == nil then
				arg_269_1.var_.actorSpriteComps1061 = var_272_29:GetComponentsInChildren(typeof(Image), true)
			end

			local var_272_31 = 0.034

			if var_272_30 <= arg_269_1.time_ and arg_269_1.time_ < var_272_30 + var_272_31 and not isNil(var_272_29) then
				local var_272_32 = (arg_269_1.time_ - var_272_30) / var_272_31

				if arg_269_1.var_.actorSpriteComps1061 then
					for iter_272_7, iter_272_8 in pairs(arg_269_1.var_.actorSpriteComps1061:ToTable()) do
						if iter_272_8 then
							if arg_269_1.isInRecall_ then
								local var_272_33 = Mathf.Lerp(iter_272_8.color.r, arg_269_1.hightColor2.r, var_272_32)
								local var_272_34 = Mathf.Lerp(iter_272_8.color.g, arg_269_1.hightColor2.g, var_272_32)
								local var_272_35 = Mathf.Lerp(iter_272_8.color.b, arg_269_1.hightColor2.b, var_272_32)

								iter_272_8.color = Color.New(var_272_33, var_272_34, var_272_35)
							else
								local var_272_36 = Mathf.Lerp(iter_272_8.color.r, 0.5, var_272_32)

								iter_272_8.color = Color.New(var_272_36, var_272_36, var_272_36)
							end
						end
					end
				end
			end

			if arg_269_1.time_ >= var_272_30 + var_272_31 and arg_269_1.time_ < var_272_30 + var_272_31 + arg_272_0 and not isNil(var_272_29) and arg_269_1.var_.actorSpriteComps1061 then
				for iter_272_9, iter_272_10 in pairs(arg_269_1.var_.actorSpriteComps1061:ToTable()) do
					if iter_272_10 then
						if arg_269_1.isInRecall_ then
							iter_272_10.color = arg_269_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_272_10.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_269_1.var_.actorSpriteComps1061 = nil
			end

			local var_272_37 = arg_269_1.actors_["1056"]
			local var_272_38 = 0

			if var_272_38 < arg_269_1.time_ and arg_269_1.time_ <= var_272_38 + arg_272_0 and not isNil(var_272_37) and arg_269_1.var_.actorSpriteComps1056 == nil then
				arg_269_1.var_.actorSpriteComps1056 = var_272_37:GetComponentsInChildren(typeof(Image), true)
			end

			local var_272_39 = 0.034

			if var_272_38 <= arg_269_1.time_ and arg_269_1.time_ < var_272_38 + var_272_39 and not isNil(var_272_37) then
				local var_272_40 = (arg_269_1.time_ - var_272_38) / var_272_39

				if arg_269_1.var_.actorSpriteComps1056 then
					for iter_272_11, iter_272_12 in pairs(arg_269_1.var_.actorSpriteComps1056:ToTable()) do
						if iter_272_12 then
							if arg_269_1.isInRecall_ then
								local var_272_41 = Mathf.Lerp(iter_272_12.color.r, arg_269_1.hightColor2.r, var_272_40)
								local var_272_42 = Mathf.Lerp(iter_272_12.color.g, arg_269_1.hightColor2.g, var_272_40)
								local var_272_43 = Mathf.Lerp(iter_272_12.color.b, arg_269_1.hightColor2.b, var_272_40)

								iter_272_12.color = Color.New(var_272_41, var_272_42, var_272_43)
							else
								local var_272_44 = Mathf.Lerp(iter_272_12.color.r, 0.5, var_272_40)

								iter_272_12.color = Color.New(var_272_44, var_272_44, var_272_44)
							end
						end
					end
				end
			end

			if arg_269_1.time_ >= var_272_38 + var_272_39 and arg_269_1.time_ < var_272_38 + var_272_39 + arg_272_0 and not isNil(var_272_37) and arg_269_1.var_.actorSpriteComps1056 then
				for iter_272_13, iter_272_14 in pairs(arg_269_1.var_.actorSpriteComps1056:ToTable()) do
					if iter_272_14 then
						if arg_269_1.isInRecall_ then
							iter_272_14.color = arg_269_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_272_14.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_269_1.var_.actorSpriteComps1056 = nil
			end

			local var_272_45 = 0
			local var_272_46 = 0.525

			if var_272_45 < arg_269_1.time_ and arg_269_1.time_ <= var_272_45 + arg_272_0 then
				arg_269_1.talkMaxDuration = 0
				arg_269_1.dialogCg_.alpha = 1

				arg_269_1.dialog_:SetActive(true)
				SetActive(arg_269_1.leftNameGo_, true)

				local var_272_47 = arg_269_1:FormatText(StoryNameCfg[591].name)

				arg_269_1.leftNameTxt_.text = var_272_47

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_269_1.leftNameTxt_.transform)

				arg_269_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_269_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_269_1:RecordName(arg_269_1.leftNameTxt_.text)
				SetActive(arg_269_1.iconTrs_.gameObject, false)
				arg_269_1.callingController_:SetSelectedState("normal")

				local var_272_48 = arg_269_1:GetWordFromCfg(410142066)
				local var_272_49 = arg_269_1:FormatText(var_272_48.content)

				arg_269_1.text_.text = var_272_49

				LuaForUtil.ClearLinePrefixSymbol(arg_269_1.text_)

				local var_272_50 = 21
				local var_272_51 = utf8.len(var_272_49)
				local var_272_52 = var_272_50 <= 0 and var_272_46 or var_272_46 * (var_272_51 / var_272_50)

				if var_272_52 > 0 and var_272_46 < var_272_52 then
					arg_269_1.talkMaxDuration = var_272_52

					if var_272_52 + var_272_45 > arg_269_1.duration_ then
						arg_269_1.duration_ = var_272_52 + var_272_45
					end
				end

				arg_269_1.text_.text = var_272_49
				arg_269_1.typewritter.percent = 0

				arg_269_1.typewritter:SetDirty()
				arg_269_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_410142", "410142066", "story_v_out_410142.awb") ~= 0 then
					local var_272_53 = manager.audio:GetVoiceLength("story_v_out_410142", "410142066", "story_v_out_410142.awb") / 1000

					if var_272_53 + var_272_45 > arg_269_1.duration_ then
						arg_269_1.duration_ = var_272_53 + var_272_45
					end

					if var_272_48.prefab_name ~= "" and arg_269_1.actors_[var_272_48.prefab_name] ~= nil then
						local var_272_54 = LuaForUtil.PlayVoiceWithCriLipsync(arg_269_1.actors_[var_272_48.prefab_name].transform, "story_v_out_410142", "410142066", "story_v_out_410142.awb")

						arg_269_1:RecordAudio("410142066", var_272_54)
						arg_269_1:RecordAudio("410142066", var_272_54)
					else
						arg_269_1:AudioAction("play", "voice", "story_v_out_410142", "410142066", "story_v_out_410142.awb")
					end

					arg_269_1:RecordHistoryTalkVoice("story_v_out_410142", "410142066", "story_v_out_410142.awb")
				end

				arg_269_1:RecordContent(arg_269_1.text_.text)
			end

			local var_272_55 = math.max(var_272_46, arg_269_1.talkMaxDuration)

			if var_272_45 <= arg_269_1.time_ and arg_269_1.time_ < var_272_45 + var_272_55 then
				arg_269_1.typewritter.percent = (arg_269_1.time_ - var_272_45) / var_272_55

				arg_269_1.typewritter:SetDirty()
			end

			if arg_269_1.time_ >= var_272_45 + var_272_55 and arg_269_1.time_ < var_272_45 + var_272_55 + arg_272_0 then
				arg_269_1.typewritter.percent = 1

				arg_269_1.typewritter:SetDirty()
				arg_269_1:ShowNextGo(true)
			end
		end

		arg_269_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10061",
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

		arg_269_1:InitPlayNodeList()
	end,
	Play410142067 = function(arg_273_0, arg_273_1)
		arg_273_1.time_ = 0
		arg_273_1.frameCnt_ = 0
		arg_273_1.state_ = "playing"
		arg_273_1.curTalkId_ = 410142067
		arg_273_1.duration_ = 8.07

		local var_273_0 = {
			ja = 8.066,
			CriLanguages = 2.266,
			zh = 2.266
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
				arg_273_0:Play410142068(arg_273_1)
			end
		end

		function arg_273_1.onSingleLineUpdate_(arg_276_0)
			local var_276_0 = arg_273_1.actors_["1061"].transform
			local var_276_1 = 0

			if var_276_1 < arg_273_1.time_ and arg_273_1.time_ <= var_276_1 + arg_276_0 then
				arg_273_1.var_.moveOldPos1061 = var_276_0.localPosition
				var_276_0.localScale = Vector3.New(1, 1, 1)

				arg_273_1:CheckSpriteTmpPos("1061", 2)

				local var_276_2 = var_276_0.childCount

				for iter_276_0 = 0, var_276_2 - 1 do
					local var_276_3 = var_276_0:GetChild(iter_276_0)

					if var_276_3.name == "split_5" or not string.find(var_276_3.name, "split") then
						var_276_3.gameObject:SetActive(true)
					else
						var_276_3.gameObject:SetActive(false)
					end
				end
			end

			local var_276_4 = 0.001

			if var_276_1 <= arg_273_1.time_ and arg_273_1.time_ < var_276_1 + var_276_4 then
				local var_276_5 = (arg_273_1.time_ - var_276_1) / var_276_4
				local var_276_6 = Vector3.New(-390, -490, 18)

				var_276_0.localPosition = Vector3.Lerp(arg_273_1.var_.moveOldPos1061, var_276_6, var_276_5)
			end

			if arg_273_1.time_ >= var_276_1 + var_276_4 and arg_273_1.time_ < var_276_1 + var_276_4 + arg_276_0 then
				var_276_0.localPosition = Vector3.New(-390, -490, 18)
			end

			local var_276_7 = arg_273_1.actors_["1061"]
			local var_276_8 = 0

			if var_276_8 < arg_273_1.time_ and arg_273_1.time_ <= var_276_8 + arg_276_0 and not isNil(var_276_7) and arg_273_1.var_.actorSpriteComps1061 == nil then
				arg_273_1.var_.actorSpriteComps1061 = var_276_7:GetComponentsInChildren(typeof(Image), true)
			end

			local var_276_9 = 0.034

			if var_276_8 <= arg_273_1.time_ and arg_273_1.time_ < var_276_8 + var_276_9 and not isNil(var_276_7) then
				local var_276_10 = (arg_273_1.time_ - var_276_8) / var_276_9

				if arg_273_1.var_.actorSpriteComps1061 then
					for iter_276_1, iter_276_2 in pairs(arg_273_1.var_.actorSpriteComps1061:ToTable()) do
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

			if arg_273_1.time_ >= var_276_8 + var_276_9 and arg_273_1.time_ < var_276_8 + var_276_9 + arg_276_0 and not isNil(var_276_7) and arg_273_1.var_.actorSpriteComps1061 then
				for iter_276_3, iter_276_4 in pairs(arg_273_1.var_.actorSpriteComps1061:ToTable()) do
					if iter_276_4 then
						if arg_273_1.isInRecall_ then
							iter_276_4.color = arg_273_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_276_4.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_273_1.var_.actorSpriteComps1061 = nil
			end

			local var_276_15 = arg_273_1.actors_["10061"]
			local var_276_16 = 0

			if var_276_16 < arg_273_1.time_ and arg_273_1.time_ <= var_276_16 + arg_276_0 and not isNil(var_276_15) and arg_273_1.var_.actorSpriteComps10061 == nil then
				arg_273_1.var_.actorSpriteComps10061 = var_276_15:GetComponentsInChildren(typeof(Image), true)
			end

			local var_276_17 = 0.034

			if var_276_16 <= arg_273_1.time_ and arg_273_1.time_ < var_276_16 + var_276_17 and not isNil(var_276_15) then
				local var_276_18 = (arg_273_1.time_ - var_276_16) / var_276_17

				if arg_273_1.var_.actorSpriteComps10061 then
					for iter_276_5, iter_276_6 in pairs(arg_273_1.var_.actorSpriteComps10061:ToTable()) do
						if iter_276_6 then
							if arg_273_1.isInRecall_ then
								local var_276_19 = Mathf.Lerp(iter_276_6.color.r, arg_273_1.hightColor2.r, var_276_18)
								local var_276_20 = Mathf.Lerp(iter_276_6.color.g, arg_273_1.hightColor2.g, var_276_18)
								local var_276_21 = Mathf.Lerp(iter_276_6.color.b, arg_273_1.hightColor2.b, var_276_18)

								iter_276_6.color = Color.New(var_276_19, var_276_20, var_276_21)
							else
								local var_276_22 = Mathf.Lerp(iter_276_6.color.r, 0.5, var_276_18)

								iter_276_6.color = Color.New(var_276_22, var_276_22, var_276_22)
							end
						end
					end
				end
			end

			if arg_273_1.time_ >= var_276_16 + var_276_17 and arg_273_1.time_ < var_276_16 + var_276_17 + arg_276_0 and not isNil(var_276_15) and arg_273_1.var_.actorSpriteComps10061 then
				for iter_276_7, iter_276_8 in pairs(arg_273_1.var_.actorSpriteComps10061:ToTable()) do
					if iter_276_8 then
						if arg_273_1.isInRecall_ then
							iter_276_8.color = arg_273_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_276_8.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_273_1.var_.actorSpriteComps10061 = nil
			end

			local var_276_23 = 0
			local var_276_24 = 0.175

			if var_276_23 < arg_273_1.time_ and arg_273_1.time_ <= var_276_23 + arg_276_0 then
				arg_273_1.talkMaxDuration = 0
				arg_273_1.dialogCg_.alpha = 1

				arg_273_1.dialog_:SetActive(true)
				SetActive(arg_273_1.leftNameGo_, true)

				local var_276_25 = arg_273_1:FormatText(StoryNameCfg[612].name)

				arg_273_1.leftNameTxt_.text = var_276_25

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_273_1.leftNameTxt_.transform)

				arg_273_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_273_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_273_1:RecordName(arg_273_1.leftNameTxt_.text)
				SetActive(arg_273_1.iconTrs_.gameObject, false)
				arg_273_1.callingController_:SetSelectedState("normal")

				local var_276_26 = arg_273_1:GetWordFromCfg(410142067)
				local var_276_27 = arg_273_1:FormatText(var_276_26.content)

				arg_273_1.text_.text = var_276_27

				LuaForUtil.ClearLinePrefixSymbol(arg_273_1.text_)

				local var_276_28 = 7
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

				if manager.audio:GetVoiceLength("story_v_out_410142", "410142067", "story_v_out_410142.awb") ~= 0 then
					local var_276_31 = manager.audio:GetVoiceLength("story_v_out_410142", "410142067", "story_v_out_410142.awb") / 1000

					if var_276_31 + var_276_23 > arg_273_1.duration_ then
						arg_273_1.duration_ = var_276_31 + var_276_23
					end

					if var_276_26.prefab_name ~= "" and arg_273_1.actors_[var_276_26.prefab_name] ~= nil then
						local var_276_32 = LuaForUtil.PlayVoiceWithCriLipsync(arg_273_1.actors_[var_276_26.prefab_name].transform, "story_v_out_410142", "410142067", "story_v_out_410142.awb")

						arg_273_1:RecordAudio("410142067", var_276_32)
						arg_273_1:RecordAudio("410142067", var_276_32)
					else
						arg_273_1:AudioAction("play", "voice", "story_v_out_410142", "410142067", "story_v_out_410142.awb")
					end

					arg_273_1:RecordHistoryTalkVoice("story_v_out_410142", "410142067", "story_v_out_410142.awb")
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
				actorName = "1061",
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
	Play410142068 = function(arg_277_0, arg_277_1)
		arg_277_1.time_ = 0
		arg_277_1.frameCnt_ = 0
		arg_277_1.state_ = "playing"
		arg_277_1.curTalkId_ = 410142068
		arg_277_1.duration_ = 13.43

		local var_277_0 = {
			ja = 13.433,
			CriLanguages = 7.866,
			zh = 7.866
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
				arg_277_0:Play410142069(arg_277_1)
			end
		end

		function arg_277_1.onSingleLineUpdate_(arg_280_0)
			local var_280_0 = arg_277_1.actors_["1056"].transform
			local var_280_1 = 0

			if var_280_1 < arg_277_1.time_ and arg_277_1.time_ <= var_280_1 + arg_280_0 then
				arg_277_1.var_.moveOldPos1056 = var_280_0.localPosition
				var_280_0.localScale = Vector3.New(1, 1, 1)

				arg_277_1:CheckSpriteTmpPos("1056", 2)

				local var_280_2 = var_280_0.childCount

				for iter_280_0 = 0, var_280_2 - 1 do
					local var_280_3 = var_280_0:GetChild(iter_280_0)

					if var_280_3.name == "" or not string.find(var_280_3.name, "split") then
						var_280_3.gameObject:SetActive(true)
					else
						var_280_3.gameObject:SetActive(false)
					end
				end
			end

			local var_280_4 = 0.001

			if var_280_1 <= arg_277_1.time_ and arg_277_1.time_ < var_280_1 + var_280_4 then
				local var_280_5 = (arg_277_1.time_ - var_280_1) / var_280_4
				local var_280_6 = Vector3.New(-390, -350, -180)

				var_280_0.localPosition = Vector3.Lerp(arg_277_1.var_.moveOldPos1056, var_280_6, var_280_5)
			end

			if arg_277_1.time_ >= var_280_1 + var_280_4 and arg_277_1.time_ < var_280_1 + var_280_4 + arg_280_0 then
				var_280_0.localPosition = Vector3.New(-390, -350, -180)
			end

			local var_280_7 = arg_277_1.actors_["1061"].transform
			local var_280_8 = 0

			if var_280_8 < arg_277_1.time_ and arg_277_1.time_ <= var_280_8 + arg_280_0 then
				arg_277_1.var_.moveOldPos1061 = var_280_7.localPosition
				var_280_7.localScale = Vector3.New(1, 1, 1)

				arg_277_1:CheckSpriteTmpPos("1061", 7)

				local var_280_9 = var_280_7.childCount

				for iter_280_1 = 0, var_280_9 - 1 do
					local var_280_10 = var_280_7:GetChild(iter_280_1)

					if var_280_10.name == "" or not string.find(var_280_10.name, "split") then
						var_280_10.gameObject:SetActive(true)
					else
						var_280_10.gameObject:SetActive(false)
					end
				end
			end

			local var_280_11 = 0.001

			if var_280_8 <= arg_277_1.time_ and arg_277_1.time_ < var_280_8 + var_280_11 then
				local var_280_12 = (arg_277_1.time_ - var_280_8) / var_280_11
				local var_280_13 = Vector3.New(0, -2000, 18)

				var_280_7.localPosition = Vector3.Lerp(arg_277_1.var_.moveOldPos1061, var_280_13, var_280_12)
			end

			if arg_277_1.time_ >= var_280_8 + var_280_11 and arg_277_1.time_ < var_280_8 + var_280_11 + arg_280_0 then
				var_280_7.localPosition = Vector3.New(0, -2000, 18)
			end

			local var_280_14 = arg_277_1.actors_["1056"]
			local var_280_15 = 0

			if var_280_15 < arg_277_1.time_ and arg_277_1.time_ <= var_280_15 + arg_280_0 and not isNil(var_280_14) and arg_277_1.var_.actorSpriteComps1056 == nil then
				arg_277_1.var_.actorSpriteComps1056 = var_280_14:GetComponentsInChildren(typeof(Image), true)
			end

			local var_280_16 = 0.034

			if var_280_15 <= arg_277_1.time_ and arg_277_1.time_ < var_280_15 + var_280_16 and not isNil(var_280_14) then
				local var_280_17 = (arg_277_1.time_ - var_280_15) / var_280_16

				if arg_277_1.var_.actorSpriteComps1056 then
					for iter_280_2, iter_280_3 in pairs(arg_277_1.var_.actorSpriteComps1056:ToTable()) do
						if iter_280_3 then
							if arg_277_1.isInRecall_ then
								local var_280_18 = Mathf.Lerp(iter_280_3.color.r, arg_277_1.hightColor1.r, var_280_17)
								local var_280_19 = Mathf.Lerp(iter_280_3.color.g, arg_277_1.hightColor1.g, var_280_17)
								local var_280_20 = Mathf.Lerp(iter_280_3.color.b, arg_277_1.hightColor1.b, var_280_17)

								iter_280_3.color = Color.New(var_280_18, var_280_19, var_280_20)
							else
								local var_280_21 = Mathf.Lerp(iter_280_3.color.r, 1, var_280_17)

								iter_280_3.color = Color.New(var_280_21, var_280_21, var_280_21)
							end
						end
					end
				end
			end

			if arg_277_1.time_ >= var_280_15 + var_280_16 and arg_277_1.time_ < var_280_15 + var_280_16 + arg_280_0 and not isNil(var_280_14) and arg_277_1.var_.actorSpriteComps1056 then
				for iter_280_4, iter_280_5 in pairs(arg_277_1.var_.actorSpriteComps1056:ToTable()) do
					if iter_280_5 then
						if arg_277_1.isInRecall_ then
							iter_280_5.color = arg_277_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_280_5.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_277_1.var_.actorSpriteComps1056 = nil
			end

			local var_280_22 = arg_277_1.actors_["1061"]
			local var_280_23 = 0

			if var_280_23 < arg_277_1.time_ and arg_277_1.time_ <= var_280_23 + arg_280_0 and not isNil(var_280_22) and arg_277_1.var_.actorSpriteComps1061 == nil then
				arg_277_1.var_.actorSpriteComps1061 = var_280_22:GetComponentsInChildren(typeof(Image), true)
			end

			local var_280_24 = 0.034

			if var_280_23 <= arg_277_1.time_ and arg_277_1.time_ < var_280_23 + var_280_24 and not isNil(var_280_22) then
				local var_280_25 = (arg_277_1.time_ - var_280_23) / var_280_24

				if arg_277_1.var_.actorSpriteComps1061 then
					for iter_280_6, iter_280_7 in pairs(arg_277_1.var_.actorSpriteComps1061:ToTable()) do
						if iter_280_7 then
							if arg_277_1.isInRecall_ then
								local var_280_26 = Mathf.Lerp(iter_280_7.color.r, arg_277_1.hightColor2.r, var_280_25)
								local var_280_27 = Mathf.Lerp(iter_280_7.color.g, arg_277_1.hightColor2.g, var_280_25)
								local var_280_28 = Mathf.Lerp(iter_280_7.color.b, arg_277_1.hightColor2.b, var_280_25)

								iter_280_7.color = Color.New(var_280_26, var_280_27, var_280_28)
							else
								local var_280_29 = Mathf.Lerp(iter_280_7.color.r, 0.5, var_280_25)

								iter_280_7.color = Color.New(var_280_29, var_280_29, var_280_29)
							end
						end
					end
				end
			end

			if arg_277_1.time_ >= var_280_23 + var_280_24 and arg_277_1.time_ < var_280_23 + var_280_24 + arg_280_0 and not isNil(var_280_22) and arg_277_1.var_.actorSpriteComps1061 then
				for iter_280_8, iter_280_9 in pairs(arg_277_1.var_.actorSpriteComps1061:ToTable()) do
					if iter_280_9 then
						if arg_277_1.isInRecall_ then
							iter_280_9.color = arg_277_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_280_9.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_277_1.var_.actorSpriteComps1061 = nil
			end

			local var_280_30 = 0
			local var_280_31 = 1.075

			if var_280_30 < arg_277_1.time_ and arg_277_1.time_ <= var_280_30 + arg_280_0 then
				arg_277_1.talkMaxDuration = 0
				arg_277_1.dialogCg_.alpha = 1

				arg_277_1.dialog_:SetActive(true)
				SetActive(arg_277_1.leftNameGo_, true)

				local var_280_32 = arg_277_1:FormatText(StoryNameCfg[605].name)

				arg_277_1.leftNameTxt_.text = var_280_32

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_277_1.leftNameTxt_.transform)

				arg_277_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_277_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_277_1:RecordName(arg_277_1.leftNameTxt_.text)
				SetActive(arg_277_1.iconTrs_.gameObject, false)
				arg_277_1.callingController_:SetSelectedState("normal")

				local var_280_33 = arg_277_1:GetWordFromCfg(410142068)
				local var_280_34 = arg_277_1:FormatText(var_280_33.content)

				arg_277_1.text_.text = var_280_34

				LuaForUtil.ClearLinePrefixSymbol(arg_277_1.text_)

				local var_280_35 = 43
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

				if manager.audio:GetVoiceLength("story_v_out_410142", "410142068", "story_v_out_410142.awb") ~= 0 then
					local var_280_38 = manager.audio:GetVoiceLength("story_v_out_410142", "410142068", "story_v_out_410142.awb") / 1000

					if var_280_38 + var_280_30 > arg_277_1.duration_ then
						arg_277_1.duration_ = var_280_38 + var_280_30
					end

					if var_280_33.prefab_name ~= "" and arg_277_1.actors_[var_280_33.prefab_name] ~= nil then
						local var_280_39 = LuaForUtil.PlayVoiceWithCriLipsync(arg_277_1.actors_[var_280_33.prefab_name].transform, "story_v_out_410142", "410142068", "story_v_out_410142.awb")

						arg_277_1:RecordAudio("410142068", var_280_39)
						arg_277_1:RecordAudio("410142068", var_280_39)
					else
						arg_277_1:AudioAction("play", "voice", "story_v_out_410142", "410142068", "story_v_out_410142.awb")
					end

					arg_277_1:RecordHistoryTalkVoice("story_v_out_410142", "410142068", "story_v_out_410142.awb")
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
				actorName = "1061",
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
	Play410142069 = function(arg_281_0, arg_281_1)
		arg_281_1.time_ = 0
		arg_281_1.frameCnt_ = 0
		arg_281_1.state_ = "playing"
		arg_281_1.curTalkId_ = 410142069
		arg_281_1.duration_ = 6.33

		local var_281_0 = {
			ja = 6.333,
			CriLanguages = 4.233,
			zh = 4.233
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
				arg_281_0:Play410142070(arg_281_1)
			end
		end

		function arg_281_1.onSingleLineUpdate_(arg_284_0)
			local var_284_0 = arg_281_1.actors_["1056"].transform
			local var_284_1 = 0

			if var_284_1 < arg_281_1.time_ and arg_281_1.time_ <= var_284_1 + arg_284_0 then
				arg_281_1.var_.moveOldPos1056 = var_284_0.localPosition
				var_284_0.localScale = Vector3.New(1, 1, 1)

				arg_281_1:CheckSpriteTmpPos("1056", 2)

				local var_284_2 = var_284_0.childCount

				for iter_284_0 = 0, var_284_2 - 1 do
					local var_284_3 = var_284_0:GetChild(iter_284_0)

					if var_284_3.name == "" or not string.find(var_284_3.name, "split") then
						var_284_3.gameObject:SetActive(true)
					else
						var_284_3.gameObject:SetActive(false)
					end
				end
			end

			local var_284_4 = 0.001

			if var_284_1 <= arg_281_1.time_ and arg_281_1.time_ < var_284_1 + var_284_4 then
				local var_284_5 = (arg_281_1.time_ - var_284_1) / var_284_4
				local var_284_6 = Vector3.New(-390, -350, -180)

				var_284_0.localPosition = Vector3.Lerp(arg_281_1.var_.moveOldPos1056, var_284_6, var_284_5)
			end

			if arg_281_1.time_ >= var_284_1 + var_284_4 and arg_281_1.time_ < var_284_1 + var_284_4 + arg_284_0 then
				var_284_0.localPosition = Vector3.New(-390, -350, -180)
			end

			local var_284_7 = arg_281_1.actors_["1056"]
			local var_284_8 = 0

			if var_284_8 < arg_281_1.time_ and arg_281_1.time_ <= var_284_8 + arg_284_0 and not isNil(var_284_7) and arg_281_1.var_.actorSpriteComps1056 == nil then
				arg_281_1.var_.actorSpriteComps1056 = var_284_7:GetComponentsInChildren(typeof(Image), true)
			end

			local var_284_9 = 0.034

			if var_284_8 <= arg_281_1.time_ and arg_281_1.time_ < var_284_8 + var_284_9 and not isNil(var_284_7) then
				local var_284_10 = (arg_281_1.time_ - var_284_8) / var_284_9

				if arg_281_1.var_.actorSpriteComps1056 then
					for iter_284_1, iter_284_2 in pairs(arg_281_1.var_.actorSpriteComps1056:ToTable()) do
						if iter_284_2 then
							if arg_281_1.isInRecall_ then
								local var_284_11 = Mathf.Lerp(iter_284_2.color.r, arg_281_1.hightColor1.r, var_284_10)
								local var_284_12 = Mathf.Lerp(iter_284_2.color.g, arg_281_1.hightColor1.g, var_284_10)
								local var_284_13 = Mathf.Lerp(iter_284_2.color.b, arg_281_1.hightColor1.b, var_284_10)

								iter_284_2.color = Color.New(var_284_11, var_284_12, var_284_13)
							else
								local var_284_14 = Mathf.Lerp(iter_284_2.color.r, 1, var_284_10)

								iter_284_2.color = Color.New(var_284_14, var_284_14, var_284_14)
							end
						end
					end
				end
			end

			if arg_281_1.time_ >= var_284_8 + var_284_9 and arg_281_1.time_ < var_284_8 + var_284_9 + arg_284_0 and not isNil(var_284_7) and arg_281_1.var_.actorSpriteComps1056 then
				for iter_284_3, iter_284_4 in pairs(arg_281_1.var_.actorSpriteComps1056:ToTable()) do
					if iter_284_4 then
						if arg_281_1.isInRecall_ then
							iter_284_4.color = arg_281_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_284_4.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_281_1.var_.actorSpriteComps1056 = nil
			end

			local var_284_15 = 0
			local var_284_16 = 0.525

			if var_284_15 < arg_281_1.time_ and arg_281_1.time_ <= var_284_15 + arg_284_0 then
				arg_281_1.talkMaxDuration = 0
				arg_281_1.dialogCg_.alpha = 1

				arg_281_1.dialog_:SetActive(true)
				SetActive(arg_281_1.leftNameGo_, true)

				local var_284_17 = arg_281_1:FormatText(StoryNameCfg[605].name)

				arg_281_1.leftNameTxt_.text = var_284_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_281_1.leftNameTxt_.transform)

				arg_281_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_281_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_281_1:RecordName(arg_281_1.leftNameTxt_.text)
				SetActive(arg_281_1.iconTrs_.gameObject, false)
				arg_281_1.callingController_:SetSelectedState("normal")

				local var_284_18 = arg_281_1:GetWordFromCfg(410142069)
				local var_284_19 = arg_281_1:FormatText(var_284_18.content)

				arg_281_1.text_.text = var_284_19

				LuaForUtil.ClearLinePrefixSymbol(arg_281_1.text_)

				local var_284_20 = 21
				local var_284_21 = utf8.len(var_284_19)
				local var_284_22 = var_284_20 <= 0 and var_284_16 or var_284_16 * (var_284_21 / var_284_20)

				if var_284_22 > 0 and var_284_16 < var_284_22 then
					arg_281_1.talkMaxDuration = var_284_22

					if var_284_22 + var_284_15 > arg_281_1.duration_ then
						arg_281_1.duration_ = var_284_22 + var_284_15
					end
				end

				arg_281_1.text_.text = var_284_19
				arg_281_1.typewritter.percent = 0

				arg_281_1.typewritter:SetDirty()
				arg_281_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_410142", "410142069", "story_v_out_410142.awb") ~= 0 then
					local var_284_23 = manager.audio:GetVoiceLength("story_v_out_410142", "410142069", "story_v_out_410142.awb") / 1000

					if var_284_23 + var_284_15 > arg_281_1.duration_ then
						arg_281_1.duration_ = var_284_23 + var_284_15
					end

					if var_284_18.prefab_name ~= "" and arg_281_1.actors_[var_284_18.prefab_name] ~= nil then
						local var_284_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_281_1.actors_[var_284_18.prefab_name].transform, "story_v_out_410142", "410142069", "story_v_out_410142.awb")

						arg_281_1:RecordAudio("410142069", var_284_24)
						arg_281_1:RecordAudio("410142069", var_284_24)
					else
						arg_281_1:AudioAction("play", "voice", "story_v_out_410142", "410142069", "story_v_out_410142.awb")
					end

					arg_281_1:RecordHistoryTalkVoice("story_v_out_410142", "410142069", "story_v_out_410142.awb")
				end

				arg_281_1:RecordContent(arg_281_1.text_.text)
			end

			local var_284_25 = math.max(var_284_16, arg_281_1.talkMaxDuration)

			if var_284_15 <= arg_281_1.time_ and arg_281_1.time_ < var_284_15 + var_284_25 then
				arg_281_1.typewritter.percent = (arg_281_1.time_ - var_284_15) / var_284_25

				arg_281_1.typewritter:SetDirty()
			end

			if arg_281_1.time_ >= var_284_15 + var_284_25 and arg_281_1.time_ < var_284_15 + var_284_25 + arg_284_0 then
				arg_281_1.typewritter.percent = 1

				arg_281_1.typewritter:SetDirty()
				arg_281_1:ShowNextGo(true)
			end
		end

		arg_281_1.nodeConfigList_ = {
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

		arg_281_1:InitPlayNodeList()
	end,
	Play410142070 = function(arg_285_0, arg_285_1)
		arg_285_1.time_ = 0
		arg_285_1.frameCnt_ = 0
		arg_285_1.state_ = "playing"
		arg_285_1.curTalkId_ = 410142070
		arg_285_1.duration_ = 9.2

		local var_285_0 = {
			ja = 9.2,
			CriLanguages = 8.3,
			zh = 7.533
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
				arg_285_0:Play410142071(arg_285_1)
			end
		end

		function arg_285_1.onSingleLineUpdate_(arg_288_0)
			local var_288_0 = arg_285_1.actors_["10061"].transform
			local var_288_1 = 0

			if var_288_1 < arg_285_1.time_ and arg_285_1.time_ <= var_288_1 + arg_288_0 then
				arg_285_1.var_.moveOldPos10061 = var_288_0.localPosition
				var_288_0.localScale = Vector3.New(1, 1, 1)

				arg_285_1:CheckSpriteTmpPos("10061", 4)

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
				local var_288_6 = Vector3.New(390, -517.5, -100)

				var_288_0.localPosition = Vector3.Lerp(arg_285_1.var_.moveOldPos10061, var_288_6, var_288_5)
			end

			if arg_285_1.time_ >= var_288_1 + var_288_4 and arg_285_1.time_ < var_288_1 + var_288_4 + arg_288_0 then
				var_288_0.localPosition = Vector3.New(390, -517.5, -100)
			end

			local var_288_7 = arg_285_1.actors_["10061"]
			local var_288_8 = 0

			if var_288_8 < arg_285_1.time_ and arg_285_1.time_ <= var_288_8 + arg_288_0 and not isNil(var_288_7) and arg_285_1.var_.actorSpriteComps10061 == nil then
				arg_285_1.var_.actorSpriteComps10061 = var_288_7:GetComponentsInChildren(typeof(Image), true)
			end

			local var_288_9 = 0.034

			if var_288_8 <= arg_285_1.time_ and arg_285_1.time_ < var_288_8 + var_288_9 and not isNil(var_288_7) then
				local var_288_10 = (arg_285_1.time_ - var_288_8) / var_288_9

				if arg_285_1.var_.actorSpriteComps10061 then
					for iter_288_1, iter_288_2 in pairs(arg_285_1.var_.actorSpriteComps10061:ToTable()) do
						if iter_288_2 then
							if arg_285_1.isInRecall_ then
								local var_288_11 = Mathf.Lerp(iter_288_2.color.r, arg_285_1.hightColor1.r, var_288_10)
								local var_288_12 = Mathf.Lerp(iter_288_2.color.g, arg_285_1.hightColor1.g, var_288_10)
								local var_288_13 = Mathf.Lerp(iter_288_2.color.b, arg_285_1.hightColor1.b, var_288_10)

								iter_288_2.color = Color.New(var_288_11, var_288_12, var_288_13)
							else
								local var_288_14 = Mathf.Lerp(iter_288_2.color.r, 1, var_288_10)

								iter_288_2.color = Color.New(var_288_14, var_288_14, var_288_14)
							end
						end
					end
				end
			end

			if arg_285_1.time_ >= var_288_8 + var_288_9 and arg_285_1.time_ < var_288_8 + var_288_9 + arg_288_0 and not isNil(var_288_7) and arg_285_1.var_.actorSpriteComps10061 then
				for iter_288_3, iter_288_4 in pairs(arg_285_1.var_.actorSpriteComps10061:ToTable()) do
					if iter_288_4 then
						if arg_285_1.isInRecall_ then
							iter_288_4.color = arg_285_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_288_4.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_285_1.var_.actorSpriteComps10061 = nil
			end

			local var_288_15 = arg_285_1.actors_["1056"]
			local var_288_16 = 0

			if var_288_16 < arg_285_1.time_ and arg_285_1.time_ <= var_288_16 + arg_288_0 and not isNil(var_288_15) and arg_285_1.var_.actorSpriteComps1056 == nil then
				arg_285_1.var_.actorSpriteComps1056 = var_288_15:GetComponentsInChildren(typeof(Image), true)
			end

			local var_288_17 = 0.034

			if var_288_16 <= arg_285_1.time_ and arg_285_1.time_ < var_288_16 + var_288_17 and not isNil(var_288_15) then
				local var_288_18 = (arg_285_1.time_ - var_288_16) / var_288_17

				if arg_285_1.var_.actorSpriteComps1056 then
					for iter_288_5, iter_288_6 in pairs(arg_285_1.var_.actorSpriteComps1056:ToTable()) do
						if iter_288_6 then
							if arg_285_1.isInRecall_ then
								local var_288_19 = Mathf.Lerp(iter_288_6.color.r, arg_285_1.hightColor2.r, var_288_18)
								local var_288_20 = Mathf.Lerp(iter_288_6.color.g, arg_285_1.hightColor2.g, var_288_18)
								local var_288_21 = Mathf.Lerp(iter_288_6.color.b, arg_285_1.hightColor2.b, var_288_18)

								iter_288_6.color = Color.New(var_288_19, var_288_20, var_288_21)
							else
								local var_288_22 = Mathf.Lerp(iter_288_6.color.r, 0.5, var_288_18)

								iter_288_6.color = Color.New(var_288_22, var_288_22, var_288_22)
							end
						end
					end
				end
			end

			if arg_285_1.time_ >= var_288_16 + var_288_17 and arg_285_1.time_ < var_288_16 + var_288_17 + arg_288_0 and not isNil(var_288_15) and arg_285_1.var_.actorSpriteComps1056 then
				for iter_288_7, iter_288_8 in pairs(arg_285_1.var_.actorSpriteComps1056:ToTable()) do
					if iter_288_8 then
						if arg_285_1.isInRecall_ then
							iter_288_8.color = arg_285_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_288_8.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_285_1.var_.actorSpriteComps1056 = nil
			end

			local var_288_23 = 0
			local var_288_24 = 0.975

			if var_288_23 < arg_285_1.time_ and arg_285_1.time_ <= var_288_23 + arg_288_0 then
				arg_285_1.talkMaxDuration = 0
				arg_285_1.dialogCg_.alpha = 1

				arg_285_1.dialog_:SetActive(true)
				SetActive(arg_285_1.leftNameGo_, true)

				local var_288_25 = arg_285_1:FormatText(StoryNameCfg[591].name)

				arg_285_1.leftNameTxt_.text = var_288_25

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_285_1.leftNameTxt_.transform)

				arg_285_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_285_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_285_1:RecordName(arg_285_1.leftNameTxt_.text)
				SetActive(arg_285_1.iconTrs_.gameObject, false)
				arg_285_1.callingController_:SetSelectedState("normal")

				local var_288_26 = arg_285_1:GetWordFromCfg(410142070)
				local var_288_27 = arg_285_1:FormatText(var_288_26.content)

				arg_285_1.text_.text = var_288_27

				LuaForUtil.ClearLinePrefixSymbol(arg_285_1.text_)

				local var_288_28 = 39
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

				if manager.audio:GetVoiceLength("story_v_out_410142", "410142070", "story_v_out_410142.awb") ~= 0 then
					local var_288_31 = manager.audio:GetVoiceLength("story_v_out_410142", "410142070", "story_v_out_410142.awb") / 1000

					if var_288_31 + var_288_23 > arg_285_1.duration_ then
						arg_285_1.duration_ = var_288_31 + var_288_23
					end

					if var_288_26.prefab_name ~= "" and arg_285_1.actors_[var_288_26.prefab_name] ~= nil then
						local var_288_32 = LuaForUtil.PlayVoiceWithCriLipsync(arg_285_1.actors_[var_288_26.prefab_name].transform, "story_v_out_410142", "410142070", "story_v_out_410142.awb")

						arg_285_1:RecordAudio("410142070", var_288_32)
						arg_285_1:RecordAudio("410142070", var_288_32)
					else
						arg_285_1:AudioAction("play", "voice", "story_v_out_410142", "410142070", "story_v_out_410142.awb")
					end

					arg_285_1:RecordHistoryTalkVoice("story_v_out_410142", "410142070", "story_v_out_410142.awb")
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
				actorName = "10061",
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
	Play410142071 = function(arg_289_0, arg_289_1)
		arg_289_1.time_ = 0
		arg_289_1.frameCnt_ = 0
		arg_289_1.state_ = "playing"
		arg_289_1.curTalkId_ = 410142071
		arg_289_1.duration_ = 1.33

		SetActive(arg_289_1.tipsGo_, false)

		function arg_289_1.onSingleLineFinish_()
			arg_289_1.onSingleLineUpdate_ = nil
			arg_289_1.onSingleLineFinish_ = nil
			arg_289_1.state_ = "waiting"
		end

		function arg_289_1.playNext_(arg_291_0)
			if arg_291_0 == 1 then
				arg_289_0:Play410142072(arg_289_1)
			end
		end

		function arg_289_1.onSingleLineUpdate_(arg_292_0)
			local var_292_0 = arg_289_1.actors_["1056"].transform
			local var_292_1 = 0

			if var_292_1 < arg_289_1.time_ and arg_289_1.time_ <= var_292_1 + arg_292_0 then
				arg_289_1.var_.moveOldPos1056 = var_292_0.localPosition
				var_292_0.localScale = Vector3.New(1, 1, 1)

				arg_289_1:CheckSpriteTmpPos("1056", 2)

				local var_292_2 = var_292_0.childCount

				for iter_292_0 = 0, var_292_2 - 1 do
					local var_292_3 = var_292_0:GetChild(iter_292_0)

					if var_292_3.name == "split_3" or not string.find(var_292_3.name, "split") then
						var_292_3.gameObject:SetActive(true)
					else
						var_292_3.gameObject:SetActive(false)
					end
				end
			end

			local var_292_4 = 0.001

			if var_292_1 <= arg_289_1.time_ and arg_289_1.time_ < var_292_1 + var_292_4 then
				local var_292_5 = (arg_289_1.time_ - var_292_1) / var_292_4
				local var_292_6 = Vector3.New(-390, -350, -180)

				var_292_0.localPosition = Vector3.Lerp(arg_289_1.var_.moveOldPos1056, var_292_6, var_292_5)
			end

			if arg_289_1.time_ >= var_292_1 + var_292_4 and arg_289_1.time_ < var_292_1 + var_292_4 + arg_292_0 then
				var_292_0.localPosition = Vector3.New(-390, -350, -180)
			end

			local var_292_7 = arg_289_1.actors_["1056"]
			local var_292_8 = 0

			if var_292_8 < arg_289_1.time_ and arg_289_1.time_ <= var_292_8 + arg_292_0 and not isNil(var_292_7) and arg_289_1.var_.actorSpriteComps1056 == nil then
				arg_289_1.var_.actorSpriteComps1056 = var_292_7:GetComponentsInChildren(typeof(Image), true)
			end

			local var_292_9 = 0.034

			if var_292_8 <= arg_289_1.time_ and arg_289_1.time_ < var_292_8 + var_292_9 and not isNil(var_292_7) then
				local var_292_10 = (arg_289_1.time_ - var_292_8) / var_292_9

				if arg_289_1.var_.actorSpriteComps1056 then
					for iter_292_1, iter_292_2 in pairs(arg_289_1.var_.actorSpriteComps1056:ToTable()) do
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

			if arg_289_1.time_ >= var_292_8 + var_292_9 and arg_289_1.time_ < var_292_8 + var_292_9 + arg_292_0 and not isNil(var_292_7) and arg_289_1.var_.actorSpriteComps1056 then
				for iter_292_3, iter_292_4 in pairs(arg_289_1.var_.actorSpriteComps1056:ToTable()) do
					if iter_292_4 then
						if arg_289_1.isInRecall_ then
							iter_292_4.color = arg_289_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_292_4.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_289_1.var_.actorSpriteComps1056 = nil
			end

			local var_292_15 = arg_289_1.actors_["10061"]
			local var_292_16 = 0

			if var_292_16 < arg_289_1.time_ and arg_289_1.time_ <= var_292_16 + arg_292_0 and not isNil(var_292_15) and arg_289_1.var_.actorSpriteComps10061 == nil then
				arg_289_1.var_.actorSpriteComps10061 = var_292_15:GetComponentsInChildren(typeof(Image), true)
			end

			local var_292_17 = 0.034

			if var_292_16 <= arg_289_1.time_ and arg_289_1.time_ < var_292_16 + var_292_17 and not isNil(var_292_15) then
				local var_292_18 = (arg_289_1.time_ - var_292_16) / var_292_17

				if arg_289_1.var_.actorSpriteComps10061 then
					for iter_292_5, iter_292_6 in pairs(arg_289_1.var_.actorSpriteComps10061:ToTable()) do
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

			if arg_289_1.time_ >= var_292_16 + var_292_17 and arg_289_1.time_ < var_292_16 + var_292_17 + arg_292_0 and not isNil(var_292_15) and arg_289_1.var_.actorSpriteComps10061 then
				for iter_292_7, iter_292_8 in pairs(arg_289_1.var_.actorSpriteComps10061:ToTable()) do
					if iter_292_8 then
						if arg_289_1.isInRecall_ then
							iter_292_8.color = arg_289_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_292_8.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_289_1.var_.actorSpriteComps10061 = nil
			end

			local var_292_23 = 0
			local var_292_24 = 0.075

			if var_292_23 < arg_289_1.time_ and arg_289_1.time_ <= var_292_23 + arg_292_0 then
				arg_289_1.talkMaxDuration = 0
				arg_289_1.dialogCg_.alpha = 1

				arg_289_1.dialog_:SetActive(true)
				SetActive(arg_289_1.leftNameGo_, true)

				local var_292_25 = arg_289_1:FormatText(StoryNameCfg[605].name)

				arg_289_1.leftNameTxt_.text = var_292_25

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_289_1.leftNameTxt_.transform)

				arg_289_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_289_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_289_1:RecordName(arg_289_1.leftNameTxt_.text)
				SetActive(arg_289_1.iconTrs_.gameObject, false)
				arg_289_1.callingController_:SetSelectedState("normal")

				local var_292_26 = arg_289_1:GetWordFromCfg(410142071)
				local var_292_27 = arg_289_1:FormatText(var_292_26.content)

				arg_289_1.text_.text = var_292_27

				LuaForUtil.ClearLinePrefixSymbol(arg_289_1.text_)

				local var_292_28 = 3
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

				if manager.audio:GetVoiceLength("story_v_out_410142", "410142071", "story_v_out_410142.awb") ~= 0 then
					local var_292_31 = manager.audio:GetVoiceLength("story_v_out_410142", "410142071", "story_v_out_410142.awb") / 1000

					if var_292_31 + var_292_23 > arg_289_1.duration_ then
						arg_289_1.duration_ = var_292_31 + var_292_23
					end

					if var_292_26.prefab_name ~= "" and arg_289_1.actors_[var_292_26.prefab_name] ~= nil then
						local var_292_32 = LuaForUtil.PlayVoiceWithCriLipsync(arg_289_1.actors_[var_292_26.prefab_name].transform, "story_v_out_410142", "410142071", "story_v_out_410142.awb")

						arg_289_1:RecordAudio("410142071", var_292_32)
						arg_289_1:RecordAudio("410142071", var_292_32)
					else
						arg_289_1:AudioAction("play", "voice", "story_v_out_410142", "410142071", "story_v_out_410142.awb")
					end

					arg_289_1:RecordHistoryTalkVoice("story_v_out_410142", "410142071", "story_v_out_410142.awb")
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
				actorName = "1056",
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
	Play410142072 = function(arg_293_0, arg_293_1)
		arg_293_1.time_ = 0
		arg_293_1.frameCnt_ = 0
		arg_293_1.state_ = "playing"
		arg_293_1.curTalkId_ = 410142072
		arg_293_1.duration_ = 10.9

		local var_293_0 = {
			ja = 10.9,
			CriLanguages = 6.733,
			zh = 6.733
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
				arg_293_0:Play410142073(arg_293_1)
			end
		end

		function arg_293_1.onSingleLineUpdate_(arg_296_0)
			local var_296_0 = arg_293_1.actors_["10061"].transform
			local var_296_1 = 0

			if var_296_1 < arg_293_1.time_ and arg_293_1.time_ <= var_296_1 + arg_296_0 then
				arg_293_1.var_.moveOldPos10061 = var_296_0.localPosition
				var_296_0.localScale = Vector3.New(1, 1, 1)

				arg_293_1:CheckSpriteTmpPos("10061", 4)

				local var_296_2 = var_296_0.childCount

				for iter_296_0 = 0, var_296_2 - 1 do
					local var_296_3 = var_296_0:GetChild(iter_296_0)

					if var_296_3.name == "" or not string.find(var_296_3.name, "split") then
						var_296_3.gameObject:SetActive(true)
					else
						var_296_3.gameObject:SetActive(false)
					end
				end
			end

			local var_296_4 = 0.001

			if var_296_1 <= arg_293_1.time_ and arg_293_1.time_ < var_296_1 + var_296_4 then
				local var_296_5 = (arg_293_1.time_ - var_296_1) / var_296_4
				local var_296_6 = Vector3.New(390, -517.5, -100)

				var_296_0.localPosition = Vector3.Lerp(arg_293_1.var_.moveOldPos10061, var_296_6, var_296_5)
			end

			if arg_293_1.time_ >= var_296_1 + var_296_4 and arg_293_1.time_ < var_296_1 + var_296_4 + arg_296_0 then
				var_296_0.localPosition = Vector3.New(390, -517.5, -100)
			end

			local var_296_7 = arg_293_1.actors_["10061"]
			local var_296_8 = 0

			if var_296_8 < arg_293_1.time_ and arg_293_1.time_ <= var_296_8 + arg_296_0 and not isNil(var_296_7) and arg_293_1.var_.actorSpriteComps10061 == nil then
				arg_293_1.var_.actorSpriteComps10061 = var_296_7:GetComponentsInChildren(typeof(Image), true)
			end

			local var_296_9 = 0.034

			if var_296_8 <= arg_293_1.time_ and arg_293_1.time_ < var_296_8 + var_296_9 and not isNil(var_296_7) then
				local var_296_10 = (arg_293_1.time_ - var_296_8) / var_296_9

				if arg_293_1.var_.actorSpriteComps10061 then
					for iter_296_1, iter_296_2 in pairs(arg_293_1.var_.actorSpriteComps10061:ToTable()) do
						if iter_296_2 then
							if arg_293_1.isInRecall_ then
								local var_296_11 = Mathf.Lerp(iter_296_2.color.r, arg_293_1.hightColor1.r, var_296_10)
								local var_296_12 = Mathf.Lerp(iter_296_2.color.g, arg_293_1.hightColor1.g, var_296_10)
								local var_296_13 = Mathf.Lerp(iter_296_2.color.b, arg_293_1.hightColor1.b, var_296_10)

								iter_296_2.color = Color.New(var_296_11, var_296_12, var_296_13)
							else
								local var_296_14 = Mathf.Lerp(iter_296_2.color.r, 1, var_296_10)

								iter_296_2.color = Color.New(var_296_14, var_296_14, var_296_14)
							end
						end
					end
				end
			end

			if arg_293_1.time_ >= var_296_8 + var_296_9 and arg_293_1.time_ < var_296_8 + var_296_9 + arg_296_0 and not isNil(var_296_7) and arg_293_1.var_.actorSpriteComps10061 then
				for iter_296_3, iter_296_4 in pairs(arg_293_1.var_.actorSpriteComps10061:ToTable()) do
					if iter_296_4 then
						if arg_293_1.isInRecall_ then
							iter_296_4.color = arg_293_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_296_4.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_293_1.var_.actorSpriteComps10061 = nil
			end

			local var_296_15 = arg_293_1.actors_["1056"]
			local var_296_16 = 0

			if var_296_16 < arg_293_1.time_ and arg_293_1.time_ <= var_296_16 + arg_296_0 and not isNil(var_296_15) and arg_293_1.var_.actorSpriteComps1056 == nil then
				arg_293_1.var_.actorSpriteComps1056 = var_296_15:GetComponentsInChildren(typeof(Image), true)
			end

			local var_296_17 = 0.034

			if var_296_16 <= arg_293_1.time_ and arg_293_1.time_ < var_296_16 + var_296_17 and not isNil(var_296_15) then
				local var_296_18 = (arg_293_1.time_ - var_296_16) / var_296_17

				if arg_293_1.var_.actorSpriteComps1056 then
					for iter_296_5, iter_296_6 in pairs(arg_293_1.var_.actorSpriteComps1056:ToTable()) do
						if iter_296_6 then
							if arg_293_1.isInRecall_ then
								local var_296_19 = Mathf.Lerp(iter_296_6.color.r, arg_293_1.hightColor2.r, var_296_18)
								local var_296_20 = Mathf.Lerp(iter_296_6.color.g, arg_293_1.hightColor2.g, var_296_18)
								local var_296_21 = Mathf.Lerp(iter_296_6.color.b, arg_293_1.hightColor2.b, var_296_18)

								iter_296_6.color = Color.New(var_296_19, var_296_20, var_296_21)
							else
								local var_296_22 = Mathf.Lerp(iter_296_6.color.r, 0.5, var_296_18)

								iter_296_6.color = Color.New(var_296_22, var_296_22, var_296_22)
							end
						end
					end
				end
			end

			if arg_293_1.time_ >= var_296_16 + var_296_17 and arg_293_1.time_ < var_296_16 + var_296_17 + arg_296_0 and not isNil(var_296_15) and arg_293_1.var_.actorSpriteComps1056 then
				for iter_296_7, iter_296_8 in pairs(arg_293_1.var_.actorSpriteComps1056:ToTable()) do
					if iter_296_8 then
						if arg_293_1.isInRecall_ then
							iter_296_8.color = arg_293_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_296_8.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_293_1.var_.actorSpriteComps1056 = nil
			end

			local var_296_23 = 0
			local var_296_24 = 0.7

			if var_296_23 < arg_293_1.time_ and arg_293_1.time_ <= var_296_23 + arg_296_0 then
				arg_293_1.talkMaxDuration = 0
				arg_293_1.dialogCg_.alpha = 1

				arg_293_1.dialog_:SetActive(true)
				SetActive(arg_293_1.leftNameGo_, true)

				local var_296_25 = arg_293_1:FormatText(StoryNameCfg[591].name)

				arg_293_1.leftNameTxt_.text = var_296_25

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_293_1.leftNameTxt_.transform)

				arg_293_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_293_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_293_1:RecordName(arg_293_1.leftNameTxt_.text)
				SetActive(arg_293_1.iconTrs_.gameObject, false)
				arg_293_1.callingController_:SetSelectedState("normal")

				local var_296_26 = arg_293_1:GetWordFromCfg(410142072)
				local var_296_27 = arg_293_1:FormatText(var_296_26.content)

				arg_293_1.text_.text = var_296_27

				LuaForUtil.ClearLinePrefixSymbol(arg_293_1.text_)

				local var_296_28 = 28
				local var_296_29 = utf8.len(var_296_27)
				local var_296_30 = var_296_28 <= 0 and var_296_24 or var_296_24 * (var_296_29 / var_296_28)

				if var_296_30 > 0 and var_296_24 < var_296_30 then
					arg_293_1.talkMaxDuration = var_296_30

					if var_296_30 + var_296_23 > arg_293_1.duration_ then
						arg_293_1.duration_ = var_296_30 + var_296_23
					end
				end

				arg_293_1.text_.text = var_296_27
				arg_293_1.typewritter.percent = 0

				arg_293_1.typewritter:SetDirty()
				arg_293_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_410142", "410142072", "story_v_out_410142.awb") ~= 0 then
					local var_296_31 = manager.audio:GetVoiceLength("story_v_out_410142", "410142072", "story_v_out_410142.awb") / 1000

					if var_296_31 + var_296_23 > arg_293_1.duration_ then
						arg_293_1.duration_ = var_296_31 + var_296_23
					end

					if var_296_26.prefab_name ~= "" and arg_293_1.actors_[var_296_26.prefab_name] ~= nil then
						local var_296_32 = LuaForUtil.PlayVoiceWithCriLipsync(arg_293_1.actors_[var_296_26.prefab_name].transform, "story_v_out_410142", "410142072", "story_v_out_410142.awb")

						arg_293_1:RecordAudio("410142072", var_296_32)
						arg_293_1:RecordAudio("410142072", var_296_32)
					else
						arg_293_1:AudioAction("play", "voice", "story_v_out_410142", "410142072", "story_v_out_410142.awb")
					end

					arg_293_1:RecordHistoryTalkVoice("story_v_out_410142", "410142072", "story_v_out_410142.awb")
				end

				arg_293_1:RecordContent(arg_293_1.text_.text)
			end

			local var_296_33 = math.max(var_296_24, arg_293_1.talkMaxDuration)

			if var_296_23 <= arg_293_1.time_ and arg_293_1.time_ < var_296_23 + var_296_33 then
				arg_293_1.typewritter.percent = (arg_293_1.time_ - var_296_23) / var_296_33

				arg_293_1.typewritter:SetDirty()
			end

			if arg_293_1.time_ >= var_296_23 + var_296_33 and arg_293_1.time_ < var_296_23 + var_296_33 + arg_296_0 then
				arg_293_1.typewritter.percent = 1

				arg_293_1.typewritter:SetDirty()
				arg_293_1:ShowNextGo(true)
			end
		end

		arg_293_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10061",
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
	Play410142073 = function(arg_297_0, arg_297_1)
		arg_297_1.time_ = 0
		arg_297_1.frameCnt_ = 0
		arg_297_1.state_ = "playing"
		arg_297_1.curTalkId_ = 410142073
		arg_297_1.duration_ = 5

		SetActive(arg_297_1.tipsGo_, false)

		function arg_297_1.onSingleLineFinish_()
			arg_297_1.onSingleLineUpdate_ = nil
			arg_297_1.onSingleLineFinish_ = nil
			arg_297_1.state_ = "waiting"
		end

		function arg_297_1.playNext_(arg_299_0)
			if arg_299_0 == 1 then
				arg_297_0:Play410142074(arg_297_1)
			end
		end

		function arg_297_1.onSingleLineUpdate_(arg_300_0)
			local var_300_0 = arg_297_1.actors_["10061"]
			local var_300_1 = 0

			if var_300_1 < arg_297_1.time_ and arg_297_1.time_ <= var_300_1 + arg_300_0 and not isNil(var_300_0) and arg_297_1.var_.actorSpriteComps10061 == nil then
				arg_297_1.var_.actorSpriteComps10061 = var_300_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_300_2 = 0.034

			if var_300_1 <= arg_297_1.time_ and arg_297_1.time_ < var_300_1 + var_300_2 and not isNil(var_300_0) then
				local var_300_3 = (arg_297_1.time_ - var_300_1) / var_300_2

				if arg_297_1.var_.actorSpriteComps10061 then
					for iter_300_0, iter_300_1 in pairs(arg_297_1.var_.actorSpriteComps10061:ToTable()) do
						if iter_300_1 then
							if arg_297_1.isInRecall_ then
								local var_300_4 = Mathf.Lerp(iter_300_1.color.r, arg_297_1.hightColor2.r, var_300_3)
								local var_300_5 = Mathf.Lerp(iter_300_1.color.g, arg_297_1.hightColor2.g, var_300_3)
								local var_300_6 = Mathf.Lerp(iter_300_1.color.b, arg_297_1.hightColor2.b, var_300_3)

								iter_300_1.color = Color.New(var_300_4, var_300_5, var_300_6)
							else
								local var_300_7 = Mathf.Lerp(iter_300_1.color.r, 0.5, var_300_3)

								iter_300_1.color = Color.New(var_300_7, var_300_7, var_300_7)
							end
						end
					end
				end
			end

			if arg_297_1.time_ >= var_300_1 + var_300_2 and arg_297_1.time_ < var_300_1 + var_300_2 + arg_300_0 and not isNil(var_300_0) and arg_297_1.var_.actorSpriteComps10061 then
				for iter_300_2, iter_300_3 in pairs(arg_297_1.var_.actorSpriteComps10061:ToTable()) do
					if iter_300_3 then
						if arg_297_1.isInRecall_ then
							iter_300_3.color = arg_297_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_300_3.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_297_1.var_.actorSpriteComps10061 = nil
			end

			local var_300_8 = 0
			local var_300_9 = 0.725

			if var_300_8 < arg_297_1.time_ and arg_297_1.time_ <= var_300_8 + arg_300_0 then
				arg_297_1.talkMaxDuration = 0
				arg_297_1.dialogCg_.alpha = 1

				arg_297_1.dialog_:SetActive(true)
				SetActive(arg_297_1.leftNameGo_, false)

				arg_297_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_297_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_297_1:RecordName(arg_297_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_297_1.iconTrs_.gameObject, false)
				arg_297_1.callingController_:SetSelectedState("normal")

				local var_300_10 = arg_297_1:GetWordFromCfg(410142073)
				local var_300_11 = arg_297_1:FormatText(var_300_10.content)

				arg_297_1.text_.text = var_300_11

				LuaForUtil.ClearLinePrefixSymbol(arg_297_1.text_)

				local var_300_12 = 29
				local var_300_13 = utf8.len(var_300_11)
				local var_300_14 = var_300_12 <= 0 and var_300_9 or var_300_9 * (var_300_13 / var_300_12)

				if var_300_14 > 0 and var_300_9 < var_300_14 then
					arg_297_1.talkMaxDuration = var_300_14

					if var_300_14 + var_300_8 > arg_297_1.duration_ then
						arg_297_1.duration_ = var_300_14 + var_300_8
					end
				end

				arg_297_1.text_.text = var_300_11
				arg_297_1.typewritter.percent = 0

				arg_297_1.typewritter:SetDirty()
				arg_297_1:ShowNextGo(false)
				arg_297_1:RecordContent(arg_297_1.text_.text)
			end

			local var_300_15 = math.max(var_300_9, arg_297_1.talkMaxDuration)

			if var_300_8 <= arg_297_1.time_ and arg_297_1.time_ < var_300_8 + var_300_15 then
				arg_297_1.typewritter.percent = (arg_297_1.time_ - var_300_8) / var_300_15

				arg_297_1.typewritter:SetDirty()
			end

			if arg_297_1.time_ >= var_300_8 + var_300_15 and arg_297_1.time_ < var_300_8 + var_300_15 + arg_300_0 then
				arg_297_1.typewritter.percent = 1

				arg_297_1.typewritter:SetDirty()
				arg_297_1:ShowNextGo(true)
			end
		end

		arg_297_1.nodeConfigList_ = {}

		arg_297_1:InitPlayNodeList()
	end,
	Play410142074 = function(arg_301_0, arg_301_1)
		arg_301_1.time_ = 0
		arg_301_1.frameCnt_ = 0
		arg_301_1.state_ = "playing"
		arg_301_1.curTalkId_ = 410142074
		arg_301_1.duration_ = 9.17

		local var_301_0 = {
			ja = 9.166,
			CriLanguages = 8.466,
			zh = 8.466
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
				arg_301_0:Play410142075(arg_301_1)
			end
		end

		function arg_301_1.onSingleLineUpdate_(arg_304_0)
			local var_304_0 = 3

			if var_304_0 < arg_301_1.time_ and arg_301_1.time_ <= var_304_0 + arg_304_0 then
				local var_304_1 = manager.ui.mainCamera.transform.localPosition
				local var_304_2 = Vector3.New(0, 0, 10) + Vector3.New(var_304_1.x, var_304_1.y, 0)
				local var_304_3 = arg_301_1.bgs_.ST61

				var_304_3.transform.localPosition = var_304_2
				var_304_3.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_304_4 = var_304_3:GetComponent("SpriteRenderer")

				if var_304_4 and var_304_4.sprite then
					local var_304_5 = (var_304_3.transform.localPosition - var_304_1).z
					local var_304_6 = manager.ui.mainCameraCom_
					local var_304_7 = 2 * var_304_5 * Mathf.Tan(var_304_6.fieldOfView * 0.5 * Mathf.Deg2Rad)
					local var_304_8 = var_304_7 * var_304_6.aspect
					local var_304_9 = var_304_4.sprite.bounds.size.x
					local var_304_10 = var_304_4.sprite.bounds.size.y
					local var_304_11 = var_304_8 / var_304_9
					local var_304_12 = var_304_7 / var_304_10
					local var_304_13 = var_304_12 < var_304_11 and var_304_11 or var_304_12

					var_304_3.transform.localScale = Vector3.New(var_304_13, var_304_13, 0)
				end

				for iter_304_0, iter_304_1 in pairs(arg_301_1.bgs_) do
					if iter_304_0 ~= "ST61" then
						iter_304_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_304_14 = 0

			if var_304_14 < arg_301_1.time_ and arg_301_1.time_ <= var_304_14 + arg_304_0 then
				arg_301_1.mask_.enabled = true
				arg_301_1.mask_.raycastTarget = true

				arg_301_1:SetGaussion(false)
			end

			local var_304_15 = 3

			if var_304_14 <= arg_301_1.time_ and arg_301_1.time_ < var_304_14 + var_304_15 then
				local var_304_16 = (arg_301_1.time_ - var_304_14) / var_304_15
				local var_304_17 = Color.New(0, 0, 0)

				var_304_17.a = Mathf.Lerp(0, 1, var_304_16)
				arg_301_1.mask_.color = var_304_17
			end

			if arg_301_1.time_ >= var_304_14 + var_304_15 and arg_301_1.time_ < var_304_14 + var_304_15 + arg_304_0 then
				local var_304_18 = Color.New(0, 0, 0)

				var_304_18.a = 1
				arg_301_1.mask_.color = var_304_18
			end

			local var_304_19 = 3

			if var_304_19 < arg_301_1.time_ and arg_301_1.time_ <= var_304_19 + arg_304_0 then
				arg_301_1.mask_.enabled = true
				arg_301_1.mask_.raycastTarget = true

				arg_301_1:SetGaussion(false)
			end

			local var_304_20 = 3

			if var_304_19 <= arg_301_1.time_ and arg_301_1.time_ < var_304_19 + var_304_20 then
				local var_304_21 = (arg_301_1.time_ - var_304_19) / var_304_20
				local var_304_22 = Color.New(0, 0, 0)

				var_304_22.a = Mathf.Lerp(1, 0, var_304_21)
				arg_301_1.mask_.color = var_304_22
			end

			if arg_301_1.time_ >= var_304_19 + var_304_20 and arg_301_1.time_ < var_304_19 + var_304_20 + arg_304_0 then
				local var_304_23 = Color.New(0, 0, 0)
				local var_304_24 = 0

				arg_301_1.mask_.enabled = false
				var_304_23.a = var_304_24
				arg_301_1.mask_.color = var_304_23
			end

			local var_304_25 = arg_301_1.actors_["1056"].transform
			local var_304_26 = 5.8

			if var_304_26 < arg_301_1.time_ and arg_301_1.time_ <= var_304_26 + arg_304_0 then
				arg_301_1.var_.moveOldPos1056 = var_304_25.localPosition
				var_304_25.localScale = Vector3.New(1, 1, 1)

				arg_301_1:CheckSpriteTmpPos("1056", 4)

				local var_304_27 = var_304_25.childCount

				for iter_304_2 = 0, var_304_27 - 1 do
					local var_304_28 = var_304_25:GetChild(iter_304_2)

					if var_304_28.name == "split_3" or not string.find(var_304_28.name, "split") then
						var_304_28.gameObject:SetActive(true)
					else
						var_304_28.gameObject:SetActive(false)
					end
				end
			end

			local var_304_29 = 0.001

			if var_304_26 <= arg_301_1.time_ and arg_301_1.time_ < var_304_26 + var_304_29 then
				local var_304_30 = (arg_301_1.time_ - var_304_26) / var_304_29
				local var_304_31 = Vector3.New(390, -350, -180)

				var_304_25.localPosition = Vector3.Lerp(arg_301_1.var_.moveOldPos1056, var_304_31, var_304_30)
			end

			if arg_301_1.time_ >= var_304_26 + var_304_29 and arg_301_1.time_ < var_304_26 + var_304_29 + arg_304_0 then
				var_304_25.localPosition = Vector3.New(390, -350, -180)
			end

			local var_304_32 = arg_301_1.actors_["1061"].transform
			local var_304_33 = 5.8

			if var_304_33 < arg_301_1.time_ and arg_301_1.time_ <= var_304_33 + arg_304_0 then
				arg_301_1.var_.moveOldPos1061 = var_304_32.localPosition
				var_304_32.localScale = Vector3.New(1, 1, 1)

				arg_301_1:CheckSpriteTmpPos("1061", 2)

				local var_304_34 = var_304_32.childCount

				for iter_304_3 = 0, var_304_34 - 1 do
					local var_304_35 = var_304_32:GetChild(iter_304_3)

					if var_304_35.name == "" or not string.find(var_304_35.name, "split") then
						var_304_35.gameObject:SetActive(true)
					else
						var_304_35.gameObject:SetActive(false)
					end
				end
			end

			local var_304_36 = 0.001

			if var_304_33 <= arg_301_1.time_ and arg_301_1.time_ < var_304_33 + var_304_36 then
				local var_304_37 = (arg_301_1.time_ - var_304_33) / var_304_36
				local var_304_38 = Vector3.New(-390, -490, 18)

				var_304_32.localPosition = Vector3.Lerp(arg_301_1.var_.moveOldPos1061, var_304_38, var_304_37)
			end

			if arg_301_1.time_ >= var_304_33 + var_304_36 and arg_301_1.time_ < var_304_33 + var_304_36 + arg_304_0 then
				var_304_32.localPosition = Vector3.New(-390, -490, 18)
			end

			local var_304_39 = arg_301_1.actors_["1056"]
			local var_304_40 = 5.8

			if var_304_40 < arg_301_1.time_ and arg_301_1.time_ <= var_304_40 + arg_304_0 and not isNil(var_304_39) and arg_301_1.var_.actorSpriteComps1056 == nil then
				arg_301_1.var_.actorSpriteComps1056 = var_304_39:GetComponentsInChildren(typeof(Image), true)
			end

			local var_304_41 = 0.0339999999999998

			if var_304_40 <= arg_301_1.time_ and arg_301_1.time_ < var_304_40 + var_304_41 and not isNil(var_304_39) then
				local var_304_42 = (arg_301_1.time_ - var_304_40) / var_304_41

				if arg_301_1.var_.actorSpriteComps1056 then
					for iter_304_4, iter_304_5 in pairs(arg_301_1.var_.actorSpriteComps1056:ToTable()) do
						if iter_304_5 then
							if arg_301_1.isInRecall_ then
								local var_304_43 = Mathf.Lerp(iter_304_5.color.r, arg_301_1.hightColor1.r, var_304_42)
								local var_304_44 = Mathf.Lerp(iter_304_5.color.g, arg_301_1.hightColor1.g, var_304_42)
								local var_304_45 = Mathf.Lerp(iter_304_5.color.b, arg_301_1.hightColor1.b, var_304_42)

								iter_304_5.color = Color.New(var_304_43, var_304_44, var_304_45)
							else
								local var_304_46 = Mathf.Lerp(iter_304_5.color.r, 1, var_304_42)

								iter_304_5.color = Color.New(var_304_46, var_304_46, var_304_46)
							end
						end
					end
				end
			end

			if arg_301_1.time_ >= var_304_40 + var_304_41 and arg_301_1.time_ < var_304_40 + var_304_41 + arg_304_0 and not isNil(var_304_39) and arg_301_1.var_.actorSpriteComps1056 then
				for iter_304_6, iter_304_7 in pairs(arg_301_1.var_.actorSpriteComps1056:ToTable()) do
					if iter_304_7 then
						if arg_301_1.isInRecall_ then
							iter_304_7.color = arg_301_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_304_7.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_301_1.var_.actorSpriteComps1056 = nil
			end

			local var_304_47 = arg_301_1.actors_["1061"]
			local var_304_48 = 5.8

			if var_304_48 < arg_301_1.time_ and arg_301_1.time_ <= var_304_48 + arg_304_0 and not isNil(var_304_47) and arg_301_1.var_.actorSpriteComps1061 == nil then
				arg_301_1.var_.actorSpriteComps1061 = var_304_47:GetComponentsInChildren(typeof(Image), true)
			end

			local var_304_49 = 0.034

			if var_304_48 <= arg_301_1.time_ and arg_301_1.time_ < var_304_48 + var_304_49 and not isNil(var_304_47) then
				local var_304_50 = (arg_301_1.time_ - var_304_48) / var_304_49

				if arg_301_1.var_.actorSpriteComps1061 then
					for iter_304_8, iter_304_9 in pairs(arg_301_1.var_.actorSpriteComps1061:ToTable()) do
						if iter_304_9 then
							if arg_301_1.isInRecall_ then
								local var_304_51 = Mathf.Lerp(iter_304_9.color.r, arg_301_1.hightColor2.r, var_304_50)
								local var_304_52 = Mathf.Lerp(iter_304_9.color.g, arg_301_1.hightColor2.g, var_304_50)
								local var_304_53 = Mathf.Lerp(iter_304_9.color.b, arg_301_1.hightColor2.b, var_304_50)

								iter_304_9.color = Color.New(var_304_51, var_304_52, var_304_53)
							else
								local var_304_54 = Mathf.Lerp(iter_304_9.color.r, 0.5, var_304_50)

								iter_304_9.color = Color.New(var_304_54, var_304_54, var_304_54)
							end
						end
					end
				end
			end

			if arg_301_1.time_ >= var_304_48 + var_304_49 and arg_301_1.time_ < var_304_48 + var_304_49 + arg_304_0 and not isNil(var_304_47) and arg_301_1.var_.actorSpriteComps1061 then
				for iter_304_10, iter_304_11 in pairs(arg_301_1.var_.actorSpriteComps1061:ToTable()) do
					if iter_304_11 then
						if arg_301_1.isInRecall_ then
							iter_304_11.color = arg_301_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_304_11.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_301_1.var_.actorSpriteComps1061 = nil
			end

			local var_304_55 = arg_301_1.actors_["1056"].transform
			local var_304_56 = 2.966

			if var_304_56 < arg_301_1.time_ and arg_301_1.time_ <= var_304_56 + arg_304_0 then
				arg_301_1.var_.moveOldPos1056 = var_304_55.localPosition
				var_304_55.localScale = Vector3.New(1, 1, 1)

				arg_301_1:CheckSpriteTmpPos("1056", 7)

				local var_304_57 = var_304_55.childCount

				for iter_304_12 = 0, var_304_57 - 1 do
					local var_304_58 = var_304_55:GetChild(iter_304_12)

					if var_304_58.name == "split_3" or not string.find(var_304_58.name, "split") then
						var_304_58.gameObject:SetActive(true)
					else
						var_304_58.gameObject:SetActive(false)
					end
				end
			end

			local var_304_59 = 0.001

			if var_304_56 <= arg_301_1.time_ and arg_301_1.time_ < var_304_56 + var_304_59 then
				local var_304_60 = (arg_301_1.time_ - var_304_56) / var_304_59
				local var_304_61 = Vector3.New(0, -2000, -180)

				var_304_55.localPosition = Vector3.Lerp(arg_301_1.var_.moveOldPos1056, var_304_61, var_304_60)
			end

			if arg_301_1.time_ >= var_304_56 + var_304_59 and arg_301_1.time_ < var_304_56 + var_304_59 + arg_304_0 then
				var_304_55.localPosition = Vector3.New(0, -2000, -180)
			end

			local var_304_62 = arg_301_1.actors_["10061"].transform
			local var_304_63 = 2.966

			if var_304_63 < arg_301_1.time_ and arg_301_1.time_ <= var_304_63 + arg_304_0 then
				arg_301_1.var_.moveOldPos10061 = var_304_62.localPosition
				var_304_62.localScale = Vector3.New(1, 1, 1)

				arg_301_1:CheckSpriteTmpPos("10061", 7)

				local var_304_64 = var_304_62.childCount

				for iter_304_13 = 0, var_304_64 - 1 do
					local var_304_65 = var_304_62:GetChild(iter_304_13)

					if var_304_65.name == "" or not string.find(var_304_65.name, "split") then
						var_304_65.gameObject:SetActive(true)
					else
						var_304_65.gameObject:SetActive(false)
					end
				end
			end

			local var_304_66 = 0.001

			if var_304_63 <= arg_301_1.time_ and arg_301_1.time_ < var_304_63 + var_304_66 then
				local var_304_67 = (arg_301_1.time_ - var_304_63) / var_304_66
				local var_304_68 = Vector3.New(0, -2000, -100)

				var_304_62.localPosition = Vector3.Lerp(arg_301_1.var_.moveOldPos10061, var_304_68, var_304_67)
			end

			if arg_301_1.time_ >= var_304_63 + var_304_66 and arg_301_1.time_ < var_304_63 + var_304_66 + arg_304_0 then
				var_304_62.localPosition = Vector3.New(0, -2000, -100)
			end

			if arg_301_1.frameCnt_ <= 1 then
				arg_301_1.dialog_:SetActive(false)
			end

			local var_304_69 = 6
			local var_304_70 = 0.275

			if var_304_69 < arg_301_1.time_ and arg_301_1.time_ <= var_304_69 + arg_304_0 then
				arg_301_1.talkMaxDuration = 0

				arg_301_1.dialog_:SetActive(true)

				arg_301_1.dialogCg_.alpha = 0

				local var_304_71 = LeanTween.value(arg_301_1.dialog_, 0, 1, 0.3)

				var_304_71:setOnUpdate(LuaHelper.FloatAction(function(arg_305_0)
					arg_301_1.dialogCg_.alpha = arg_305_0
				end))
				var_304_71:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_301_1.dialog_)
					var_304_71:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_301_1.duration_ = arg_301_1.duration_ + 0.3

				SetActive(arg_301_1.leftNameGo_, true)

				local var_304_72 = arg_301_1:FormatText(StoryNameCfg[605].name)

				arg_301_1.leftNameTxt_.text = var_304_72

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_301_1.leftNameTxt_.transform)

				arg_301_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_301_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_301_1:RecordName(arg_301_1.leftNameTxt_.text)
				SetActive(arg_301_1.iconTrs_.gameObject, false)
				arg_301_1.callingController_:SetSelectedState("normal")

				local var_304_73 = arg_301_1:GetWordFromCfg(410142074)
				local var_304_74 = arg_301_1:FormatText(var_304_73.content)

				arg_301_1.text_.text = var_304_74

				LuaForUtil.ClearLinePrefixSymbol(arg_301_1.text_)

				local var_304_75 = 11
				local var_304_76 = utf8.len(var_304_74)
				local var_304_77 = var_304_75 <= 0 and var_304_70 or var_304_70 * (var_304_76 / var_304_75)

				if var_304_77 > 0 and var_304_70 < var_304_77 then
					arg_301_1.talkMaxDuration = var_304_77
					var_304_69 = var_304_69 + 0.3

					if var_304_77 + var_304_69 > arg_301_1.duration_ then
						arg_301_1.duration_ = var_304_77 + var_304_69
					end
				end

				arg_301_1.text_.text = var_304_74
				arg_301_1.typewritter.percent = 0

				arg_301_1.typewritter:SetDirty()
				arg_301_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_410142", "410142074", "story_v_out_410142.awb") ~= 0 then
					local var_304_78 = manager.audio:GetVoiceLength("story_v_out_410142", "410142074", "story_v_out_410142.awb") / 1000

					if var_304_78 + var_304_69 > arg_301_1.duration_ then
						arg_301_1.duration_ = var_304_78 + var_304_69
					end

					if var_304_73.prefab_name ~= "" and arg_301_1.actors_[var_304_73.prefab_name] ~= nil then
						local var_304_79 = LuaForUtil.PlayVoiceWithCriLipsync(arg_301_1.actors_[var_304_73.prefab_name].transform, "story_v_out_410142", "410142074", "story_v_out_410142.awb")

						arg_301_1:RecordAudio("410142074", var_304_79)
						arg_301_1:RecordAudio("410142074", var_304_79)
					else
						arg_301_1:AudioAction("play", "voice", "story_v_out_410142", "410142074", "story_v_out_410142.awb")
					end

					arg_301_1:RecordHistoryTalkVoice("story_v_out_410142", "410142074", "story_v_out_410142.awb")
				end

				arg_301_1:RecordContent(arg_301_1.text_.text)
			end

			local var_304_80 = var_304_69 + 0.3
			local var_304_81 = math.max(var_304_70, arg_301_1.talkMaxDuration)

			if var_304_80 <= arg_301_1.time_ and arg_301_1.time_ < var_304_80 + var_304_81 then
				arg_301_1.typewritter.percent = (arg_301_1.time_ - var_304_80) / var_304_81

				arg_301_1.typewritter:SetDirty()
			end

			if arg_301_1.time_ >= var_304_80 + var_304_81 and arg_301_1.time_ < var_304_80 + var_304_81 + arg_304_0 then
				arg_301_1.typewritter.percent = 1

				arg_301_1.typewritter:SetDirty()
				arg_301_1:ShowNextGo(true)
			end
		end

		arg_301_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1056",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 5.8,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			},
			{
				assetPath = "",
				actorName = "1061",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 5.8,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			},
			{
				assetPath = "",
				actorName = "1056",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 2.966,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			},
			{
				assetPath = "",
				actorName = "10061",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 2.966,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_301_1:InitPlayNodeList()
	end,
	Play410142075 = function(arg_307_0, arg_307_1)
		arg_307_1.time_ = 0
		arg_307_1.frameCnt_ = 0
		arg_307_1.state_ = "playing"
		arg_307_1.curTalkId_ = 410142075
		arg_307_1.duration_ = 9.57

		local var_307_0 = {
			ja = 9.566,
			CriLanguages = 4.833,
			zh = 4.833
		}
		local var_307_1 = manager.audio:GetLocalizationFlag()

		if var_307_0[var_307_1] ~= nil then
			arg_307_1.duration_ = var_307_0[var_307_1]
		end

		SetActive(arg_307_1.tipsGo_, false)

		function arg_307_1.onSingleLineFinish_()
			arg_307_1.onSingleLineUpdate_ = nil
			arg_307_1.onSingleLineFinish_ = nil
			arg_307_1.state_ = "waiting"
		end

		function arg_307_1.playNext_(arg_309_0)
			if arg_309_0 == 1 then
				arg_307_0:Play410142076(arg_307_1)
			end
		end

		function arg_307_1.onSingleLineUpdate_(arg_310_0)
			local var_310_0 = arg_307_1.actors_["1061"].transform
			local var_310_1 = 0

			if var_310_1 < arg_307_1.time_ and arg_307_1.time_ <= var_310_1 + arg_310_0 then
				arg_307_1.var_.moveOldPos1061 = var_310_0.localPosition
				var_310_0.localScale = Vector3.New(1, 1, 1)

				arg_307_1:CheckSpriteTmpPos("1061", 2)

				local var_310_2 = var_310_0.childCount

				for iter_310_0 = 0, var_310_2 - 1 do
					local var_310_3 = var_310_0:GetChild(iter_310_0)

					if var_310_3.name == "split_2" or not string.find(var_310_3.name, "split") then
						var_310_3.gameObject:SetActive(true)
					else
						var_310_3.gameObject:SetActive(false)
					end
				end
			end

			local var_310_4 = 0.001

			if var_310_1 <= arg_307_1.time_ and arg_307_1.time_ < var_310_1 + var_310_4 then
				local var_310_5 = (arg_307_1.time_ - var_310_1) / var_310_4
				local var_310_6 = Vector3.New(-390, -490, 18)

				var_310_0.localPosition = Vector3.Lerp(arg_307_1.var_.moveOldPos1061, var_310_6, var_310_5)
			end

			if arg_307_1.time_ >= var_310_1 + var_310_4 and arg_307_1.time_ < var_310_1 + var_310_4 + arg_310_0 then
				var_310_0.localPosition = Vector3.New(-390, -490, 18)
			end

			local var_310_7 = arg_307_1.actors_["1056"]
			local var_310_8 = 0

			if var_310_8 < arg_307_1.time_ and arg_307_1.time_ <= var_310_8 + arg_310_0 and not isNil(var_310_7) and arg_307_1.var_.actorSpriteComps1056 == nil then
				arg_307_1.var_.actorSpriteComps1056 = var_310_7:GetComponentsInChildren(typeof(Image), true)
			end

			local var_310_9 = 0.0339999999999998

			if var_310_8 <= arg_307_1.time_ and arg_307_1.time_ < var_310_8 + var_310_9 and not isNil(var_310_7) then
				local var_310_10 = (arg_307_1.time_ - var_310_8) / var_310_9

				if arg_307_1.var_.actorSpriteComps1056 then
					for iter_310_1, iter_310_2 in pairs(arg_307_1.var_.actorSpriteComps1056:ToTable()) do
						if iter_310_2 then
							if arg_307_1.isInRecall_ then
								local var_310_11 = Mathf.Lerp(iter_310_2.color.r, arg_307_1.hightColor2.r, var_310_10)
								local var_310_12 = Mathf.Lerp(iter_310_2.color.g, arg_307_1.hightColor2.g, var_310_10)
								local var_310_13 = Mathf.Lerp(iter_310_2.color.b, arg_307_1.hightColor2.b, var_310_10)

								iter_310_2.color = Color.New(var_310_11, var_310_12, var_310_13)
							else
								local var_310_14 = Mathf.Lerp(iter_310_2.color.r, 0.5, var_310_10)

								iter_310_2.color = Color.New(var_310_14, var_310_14, var_310_14)
							end
						end
					end
				end
			end

			if arg_307_1.time_ >= var_310_8 + var_310_9 and arg_307_1.time_ < var_310_8 + var_310_9 + arg_310_0 and not isNil(var_310_7) and arg_307_1.var_.actorSpriteComps1056 then
				for iter_310_3, iter_310_4 in pairs(arg_307_1.var_.actorSpriteComps1056:ToTable()) do
					if iter_310_4 then
						if arg_307_1.isInRecall_ then
							iter_310_4.color = arg_307_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_310_4.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_307_1.var_.actorSpriteComps1056 = nil
			end

			local var_310_15 = arg_307_1.actors_["1061"]
			local var_310_16 = 0

			if var_310_16 < arg_307_1.time_ and arg_307_1.time_ <= var_310_16 + arg_310_0 and not isNil(var_310_15) and arg_307_1.var_.actorSpriteComps1061 == nil then
				arg_307_1.var_.actorSpriteComps1061 = var_310_15:GetComponentsInChildren(typeof(Image), true)
			end

			local var_310_17 = 0.034

			if var_310_16 <= arg_307_1.time_ and arg_307_1.time_ < var_310_16 + var_310_17 and not isNil(var_310_15) then
				local var_310_18 = (arg_307_1.time_ - var_310_16) / var_310_17

				if arg_307_1.var_.actorSpriteComps1061 then
					for iter_310_5, iter_310_6 in pairs(arg_307_1.var_.actorSpriteComps1061:ToTable()) do
						if iter_310_6 then
							if arg_307_1.isInRecall_ then
								local var_310_19 = Mathf.Lerp(iter_310_6.color.r, arg_307_1.hightColor1.r, var_310_18)
								local var_310_20 = Mathf.Lerp(iter_310_6.color.g, arg_307_1.hightColor1.g, var_310_18)
								local var_310_21 = Mathf.Lerp(iter_310_6.color.b, arg_307_1.hightColor1.b, var_310_18)

								iter_310_6.color = Color.New(var_310_19, var_310_20, var_310_21)
							else
								local var_310_22 = Mathf.Lerp(iter_310_6.color.r, 1, var_310_18)

								iter_310_6.color = Color.New(var_310_22, var_310_22, var_310_22)
							end
						end
					end
				end
			end

			if arg_307_1.time_ >= var_310_16 + var_310_17 and arg_307_1.time_ < var_310_16 + var_310_17 + arg_310_0 and not isNil(var_310_15) and arg_307_1.var_.actorSpriteComps1061 then
				for iter_310_7, iter_310_8 in pairs(arg_307_1.var_.actorSpriteComps1061:ToTable()) do
					if iter_310_8 then
						if arg_307_1.isInRecall_ then
							iter_310_8.color = arg_307_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_310_8.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_307_1.var_.actorSpriteComps1061 = nil
			end

			local var_310_23 = 0
			local var_310_24 = 0.675

			if var_310_23 < arg_307_1.time_ and arg_307_1.time_ <= var_310_23 + arg_310_0 then
				arg_307_1.talkMaxDuration = 0
				arg_307_1.dialogCg_.alpha = 1

				arg_307_1.dialog_:SetActive(true)
				SetActive(arg_307_1.leftNameGo_, true)

				local var_310_25 = arg_307_1:FormatText(StoryNameCfg[612].name)

				arg_307_1.leftNameTxt_.text = var_310_25

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_307_1.leftNameTxt_.transform)

				arg_307_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_307_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_307_1:RecordName(arg_307_1.leftNameTxt_.text)
				SetActive(arg_307_1.iconTrs_.gameObject, false)
				arg_307_1.callingController_:SetSelectedState("normal")

				local var_310_26 = arg_307_1:GetWordFromCfg(410142075)
				local var_310_27 = arg_307_1:FormatText(var_310_26.content)

				arg_307_1.text_.text = var_310_27

				LuaForUtil.ClearLinePrefixSymbol(arg_307_1.text_)

				local var_310_28 = 27
				local var_310_29 = utf8.len(var_310_27)
				local var_310_30 = var_310_28 <= 0 and var_310_24 or var_310_24 * (var_310_29 / var_310_28)

				if var_310_30 > 0 and var_310_24 < var_310_30 then
					arg_307_1.talkMaxDuration = var_310_30

					if var_310_30 + var_310_23 > arg_307_1.duration_ then
						arg_307_1.duration_ = var_310_30 + var_310_23
					end
				end

				arg_307_1.text_.text = var_310_27
				arg_307_1.typewritter.percent = 0

				arg_307_1.typewritter:SetDirty()
				arg_307_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_410142", "410142075", "story_v_out_410142.awb") ~= 0 then
					local var_310_31 = manager.audio:GetVoiceLength("story_v_out_410142", "410142075", "story_v_out_410142.awb") / 1000

					if var_310_31 + var_310_23 > arg_307_1.duration_ then
						arg_307_1.duration_ = var_310_31 + var_310_23
					end

					if var_310_26.prefab_name ~= "" and arg_307_1.actors_[var_310_26.prefab_name] ~= nil then
						local var_310_32 = LuaForUtil.PlayVoiceWithCriLipsync(arg_307_1.actors_[var_310_26.prefab_name].transform, "story_v_out_410142", "410142075", "story_v_out_410142.awb")

						arg_307_1:RecordAudio("410142075", var_310_32)
						arg_307_1:RecordAudio("410142075", var_310_32)
					else
						arg_307_1:AudioAction("play", "voice", "story_v_out_410142", "410142075", "story_v_out_410142.awb")
					end

					arg_307_1:RecordHistoryTalkVoice("story_v_out_410142", "410142075", "story_v_out_410142.awb")
				end

				arg_307_1:RecordContent(arg_307_1.text_.text)
			end

			local var_310_33 = math.max(var_310_24, arg_307_1.talkMaxDuration)

			if var_310_23 <= arg_307_1.time_ and arg_307_1.time_ < var_310_23 + var_310_33 then
				arg_307_1.typewritter.percent = (arg_307_1.time_ - var_310_23) / var_310_33

				arg_307_1.typewritter:SetDirty()
			end

			if arg_307_1.time_ >= var_310_23 + var_310_33 and arg_307_1.time_ < var_310_23 + var_310_33 + arg_310_0 then
				arg_307_1.typewritter.percent = 1

				arg_307_1.typewritter:SetDirty()
				arg_307_1:ShowNextGo(true)
			end
		end

		arg_307_1.nodeConfigList_ = {
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

		arg_307_1:InitPlayNodeList()
	end,
	Play410142076 = function(arg_311_0, arg_311_1)
		arg_311_1.time_ = 0
		arg_311_1.frameCnt_ = 0
		arg_311_1.state_ = "playing"
		arg_311_1.curTalkId_ = 410142076
		arg_311_1.duration_ = 5

		SetActive(arg_311_1.tipsGo_, false)

		function arg_311_1.onSingleLineFinish_()
			arg_311_1.onSingleLineUpdate_ = nil
			arg_311_1.onSingleLineFinish_ = nil
			arg_311_1.state_ = "waiting"
		end

		function arg_311_1.playNext_(arg_313_0)
			if arg_313_0 == 1 then
				arg_311_0:Play410142077(arg_311_1)
			end
		end

		function arg_311_1.onSingleLineUpdate_(arg_314_0)
			local var_314_0 = arg_311_1.actors_["1056"]
			local var_314_1 = 0

			if var_314_1 < arg_311_1.time_ and arg_311_1.time_ <= var_314_1 + arg_314_0 and not isNil(var_314_0) and arg_311_1.var_.actorSpriteComps1056 == nil then
				arg_311_1.var_.actorSpriteComps1056 = var_314_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_314_2 = 0.0339999999999998

			if var_314_1 <= arg_311_1.time_ and arg_311_1.time_ < var_314_1 + var_314_2 and not isNil(var_314_0) then
				local var_314_3 = (arg_311_1.time_ - var_314_1) / var_314_2

				if arg_311_1.var_.actorSpriteComps1056 then
					for iter_314_0, iter_314_1 in pairs(arg_311_1.var_.actorSpriteComps1056:ToTable()) do
						if iter_314_1 then
							if arg_311_1.isInRecall_ then
								local var_314_4 = Mathf.Lerp(iter_314_1.color.r, arg_311_1.hightColor2.r, var_314_3)
								local var_314_5 = Mathf.Lerp(iter_314_1.color.g, arg_311_1.hightColor2.g, var_314_3)
								local var_314_6 = Mathf.Lerp(iter_314_1.color.b, arg_311_1.hightColor2.b, var_314_3)

								iter_314_1.color = Color.New(var_314_4, var_314_5, var_314_6)
							else
								local var_314_7 = Mathf.Lerp(iter_314_1.color.r, 0.5, var_314_3)

								iter_314_1.color = Color.New(var_314_7, var_314_7, var_314_7)
							end
						end
					end
				end
			end

			if arg_311_1.time_ >= var_314_1 + var_314_2 and arg_311_1.time_ < var_314_1 + var_314_2 + arg_314_0 and not isNil(var_314_0) and arg_311_1.var_.actorSpriteComps1056 then
				for iter_314_2, iter_314_3 in pairs(arg_311_1.var_.actorSpriteComps1056:ToTable()) do
					if iter_314_3 then
						if arg_311_1.isInRecall_ then
							iter_314_3.color = arg_311_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_314_3.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_311_1.var_.actorSpriteComps1056 = nil
			end

			local var_314_8 = arg_311_1.actors_["1061"]
			local var_314_9 = 0

			if var_314_9 < arg_311_1.time_ and arg_311_1.time_ <= var_314_9 + arg_314_0 and not isNil(var_314_8) and arg_311_1.var_.actorSpriteComps1061 == nil then
				arg_311_1.var_.actorSpriteComps1061 = var_314_8:GetComponentsInChildren(typeof(Image), true)
			end

			local var_314_10 = 0.034

			if var_314_9 <= arg_311_1.time_ and arg_311_1.time_ < var_314_9 + var_314_10 and not isNil(var_314_8) then
				local var_314_11 = (arg_311_1.time_ - var_314_9) / var_314_10

				if arg_311_1.var_.actorSpriteComps1061 then
					for iter_314_4, iter_314_5 in pairs(arg_311_1.var_.actorSpriteComps1061:ToTable()) do
						if iter_314_5 then
							if arg_311_1.isInRecall_ then
								local var_314_12 = Mathf.Lerp(iter_314_5.color.r, arg_311_1.hightColor2.r, var_314_11)
								local var_314_13 = Mathf.Lerp(iter_314_5.color.g, arg_311_1.hightColor2.g, var_314_11)
								local var_314_14 = Mathf.Lerp(iter_314_5.color.b, arg_311_1.hightColor2.b, var_314_11)

								iter_314_5.color = Color.New(var_314_12, var_314_13, var_314_14)
							else
								local var_314_15 = Mathf.Lerp(iter_314_5.color.r, 0.5, var_314_11)

								iter_314_5.color = Color.New(var_314_15, var_314_15, var_314_15)
							end
						end
					end
				end
			end

			if arg_311_1.time_ >= var_314_9 + var_314_10 and arg_311_1.time_ < var_314_9 + var_314_10 + arg_314_0 and not isNil(var_314_8) and arg_311_1.var_.actorSpriteComps1061 then
				for iter_314_6, iter_314_7 in pairs(arg_311_1.var_.actorSpriteComps1061:ToTable()) do
					if iter_314_7 then
						if arg_311_1.isInRecall_ then
							iter_314_7.color = arg_311_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_314_7.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_311_1.var_.actorSpriteComps1061 = nil
			end

			local var_314_16 = 0
			local var_314_17 = 0.925

			if var_314_16 < arg_311_1.time_ and arg_311_1.time_ <= var_314_16 + arg_314_0 then
				arg_311_1.talkMaxDuration = 0
				arg_311_1.dialogCg_.alpha = 1

				arg_311_1.dialog_:SetActive(true)
				SetActive(arg_311_1.leftNameGo_, false)

				arg_311_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_311_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_311_1:RecordName(arg_311_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_311_1.iconTrs_.gameObject, false)
				arg_311_1.callingController_:SetSelectedState("normal")

				local var_314_18 = arg_311_1:GetWordFromCfg(410142076)
				local var_314_19 = arg_311_1:FormatText(var_314_18.content)

				arg_311_1.text_.text = var_314_19

				LuaForUtil.ClearLinePrefixSymbol(arg_311_1.text_)

				local var_314_20 = 37
				local var_314_21 = utf8.len(var_314_19)
				local var_314_22 = var_314_20 <= 0 and var_314_17 or var_314_17 * (var_314_21 / var_314_20)

				if var_314_22 > 0 and var_314_17 < var_314_22 then
					arg_311_1.talkMaxDuration = var_314_22

					if var_314_22 + var_314_16 > arg_311_1.duration_ then
						arg_311_1.duration_ = var_314_22 + var_314_16
					end
				end

				arg_311_1.text_.text = var_314_19
				arg_311_1.typewritter.percent = 0

				arg_311_1.typewritter:SetDirty()
				arg_311_1:ShowNextGo(false)
				arg_311_1:RecordContent(arg_311_1.text_.text)
			end

			local var_314_23 = math.max(var_314_17, arg_311_1.talkMaxDuration)

			if var_314_16 <= arg_311_1.time_ and arg_311_1.time_ < var_314_16 + var_314_23 then
				arg_311_1.typewritter.percent = (arg_311_1.time_ - var_314_16) / var_314_23

				arg_311_1.typewritter:SetDirty()
			end

			if arg_311_1.time_ >= var_314_16 + var_314_23 and arg_311_1.time_ < var_314_16 + var_314_23 + arg_314_0 then
				arg_311_1.typewritter.percent = 1

				arg_311_1.typewritter:SetDirty()
				arg_311_1:ShowNextGo(true)
			end
		end

		arg_311_1.nodeConfigList_ = {}

		arg_311_1:InitPlayNodeList()
	end,
	Play410142077 = function(arg_315_0, arg_315_1)
		arg_315_1.time_ = 0
		arg_315_1.frameCnt_ = 0
		arg_315_1.state_ = "playing"
		arg_315_1.curTalkId_ = 410142077
		arg_315_1.duration_ = 13.33

		local var_315_0 = {
			ja = 13.333,
			CriLanguages = 7.9,
			zh = 7.9
		}
		local var_315_1 = manager.audio:GetLocalizationFlag()

		if var_315_0[var_315_1] ~= nil then
			arg_315_1.duration_ = var_315_0[var_315_1]
		end

		SetActive(arg_315_1.tipsGo_, false)

		function arg_315_1.onSingleLineFinish_()
			arg_315_1.onSingleLineUpdate_ = nil
			arg_315_1.onSingleLineFinish_ = nil
			arg_315_1.state_ = "waiting"
		end

		function arg_315_1.playNext_(arg_317_0)
			if arg_317_0 == 1 then
				arg_315_0:Play410142078(arg_315_1)
			end
		end

		function arg_315_1.onSingleLineUpdate_(arg_318_0)
			local var_318_0 = arg_315_1.actors_["1061"].transform
			local var_318_1 = 0

			if var_318_1 < arg_315_1.time_ and arg_315_1.time_ <= var_318_1 + arg_318_0 then
				arg_315_1.var_.moveOldPos1061 = var_318_0.localPosition
				var_318_0.localScale = Vector3.New(1, 1, 1)

				arg_315_1:CheckSpriteTmpPos("1061", 2)

				local var_318_2 = var_318_0.childCount

				for iter_318_0 = 0, var_318_2 - 1 do
					local var_318_3 = var_318_0:GetChild(iter_318_0)

					if var_318_3.name == "split_1" or not string.find(var_318_3.name, "split") then
						var_318_3.gameObject:SetActive(true)
					else
						var_318_3.gameObject:SetActive(false)
					end
				end
			end

			local var_318_4 = 0.001

			if var_318_1 <= arg_315_1.time_ and arg_315_1.time_ < var_318_1 + var_318_4 then
				local var_318_5 = (arg_315_1.time_ - var_318_1) / var_318_4
				local var_318_6 = Vector3.New(-390, -490, 18)

				var_318_0.localPosition = Vector3.Lerp(arg_315_1.var_.moveOldPos1061, var_318_6, var_318_5)
			end

			if arg_315_1.time_ >= var_318_1 + var_318_4 and arg_315_1.time_ < var_318_1 + var_318_4 + arg_318_0 then
				var_318_0.localPosition = Vector3.New(-390, -490, 18)
			end

			local var_318_7 = arg_315_1.actors_["1061"]
			local var_318_8 = 0

			if var_318_8 < arg_315_1.time_ and arg_315_1.time_ <= var_318_8 + arg_318_0 and not isNil(var_318_7) and arg_315_1.var_.actorSpriteComps1061 == nil then
				arg_315_1.var_.actorSpriteComps1061 = var_318_7:GetComponentsInChildren(typeof(Image), true)
			end

			local var_318_9 = 0.034

			if var_318_8 <= arg_315_1.time_ and arg_315_1.time_ < var_318_8 + var_318_9 and not isNil(var_318_7) then
				local var_318_10 = (arg_315_1.time_ - var_318_8) / var_318_9

				if arg_315_1.var_.actorSpriteComps1061 then
					for iter_318_1, iter_318_2 in pairs(arg_315_1.var_.actorSpriteComps1061:ToTable()) do
						if iter_318_2 then
							if arg_315_1.isInRecall_ then
								local var_318_11 = Mathf.Lerp(iter_318_2.color.r, arg_315_1.hightColor1.r, var_318_10)
								local var_318_12 = Mathf.Lerp(iter_318_2.color.g, arg_315_1.hightColor1.g, var_318_10)
								local var_318_13 = Mathf.Lerp(iter_318_2.color.b, arg_315_1.hightColor1.b, var_318_10)

								iter_318_2.color = Color.New(var_318_11, var_318_12, var_318_13)
							else
								local var_318_14 = Mathf.Lerp(iter_318_2.color.r, 1, var_318_10)

								iter_318_2.color = Color.New(var_318_14, var_318_14, var_318_14)
							end
						end
					end
				end
			end

			if arg_315_1.time_ >= var_318_8 + var_318_9 and arg_315_1.time_ < var_318_8 + var_318_9 + arg_318_0 and not isNil(var_318_7) and arg_315_1.var_.actorSpriteComps1061 then
				for iter_318_3, iter_318_4 in pairs(arg_315_1.var_.actorSpriteComps1061:ToTable()) do
					if iter_318_4 then
						if arg_315_1.isInRecall_ then
							iter_318_4.color = arg_315_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_318_4.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_315_1.var_.actorSpriteComps1061 = nil
			end

			local var_318_15 = 0
			local var_318_16 = 0.875

			if var_318_15 < arg_315_1.time_ and arg_315_1.time_ <= var_318_15 + arg_318_0 then
				arg_315_1.talkMaxDuration = 0
				arg_315_1.dialogCg_.alpha = 1

				arg_315_1.dialog_:SetActive(true)
				SetActive(arg_315_1.leftNameGo_, true)

				local var_318_17 = arg_315_1:FormatText(StoryNameCfg[612].name)

				arg_315_1.leftNameTxt_.text = var_318_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_315_1.leftNameTxt_.transform)

				arg_315_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_315_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_315_1:RecordName(arg_315_1.leftNameTxt_.text)
				SetActive(arg_315_1.iconTrs_.gameObject, false)
				arg_315_1.callingController_:SetSelectedState("normal")

				local var_318_18 = arg_315_1:GetWordFromCfg(410142077)
				local var_318_19 = arg_315_1:FormatText(var_318_18.content)

				arg_315_1.text_.text = var_318_19

				LuaForUtil.ClearLinePrefixSymbol(arg_315_1.text_)

				local var_318_20 = 35
				local var_318_21 = utf8.len(var_318_19)
				local var_318_22 = var_318_20 <= 0 and var_318_16 or var_318_16 * (var_318_21 / var_318_20)

				if var_318_22 > 0 and var_318_16 < var_318_22 then
					arg_315_1.talkMaxDuration = var_318_22

					if var_318_22 + var_318_15 > arg_315_1.duration_ then
						arg_315_1.duration_ = var_318_22 + var_318_15
					end
				end

				arg_315_1.text_.text = var_318_19
				arg_315_1.typewritter.percent = 0

				arg_315_1.typewritter:SetDirty()
				arg_315_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_410142", "410142077", "story_v_out_410142.awb") ~= 0 then
					local var_318_23 = manager.audio:GetVoiceLength("story_v_out_410142", "410142077", "story_v_out_410142.awb") / 1000

					if var_318_23 + var_318_15 > arg_315_1.duration_ then
						arg_315_1.duration_ = var_318_23 + var_318_15
					end

					if var_318_18.prefab_name ~= "" and arg_315_1.actors_[var_318_18.prefab_name] ~= nil then
						local var_318_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_315_1.actors_[var_318_18.prefab_name].transform, "story_v_out_410142", "410142077", "story_v_out_410142.awb")

						arg_315_1:RecordAudio("410142077", var_318_24)
						arg_315_1:RecordAudio("410142077", var_318_24)
					else
						arg_315_1:AudioAction("play", "voice", "story_v_out_410142", "410142077", "story_v_out_410142.awb")
					end

					arg_315_1:RecordHistoryTalkVoice("story_v_out_410142", "410142077", "story_v_out_410142.awb")
				end

				arg_315_1:RecordContent(arg_315_1.text_.text)
			end

			local var_318_25 = math.max(var_318_16, arg_315_1.talkMaxDuration)

			if var_318_15 <= arg_315_1.time_ and arg_315_1.time_ < var_318_15 + var_318_25 then
				arg_315_1.typewritter.percent = (arg_315_1.time_ - var_318_15) / var_318_25

				arg_315_1.typewritter:SetDirty()
			end

			if arg_315_1.time_ >= var_318_15 + var_318_25 and arg_315_1.time_ < var_318_15 + var_318_25 + arg_318_0 then
				arg_315_1.typewritter.percent = 1

				arg_315_1.typewritter:SetDirty()
				arg_315_1:ShowNextGo(true)
			end
		end

		arg_315_1.nodeConfigList_ = {
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

		arg_315_1:InitPlayNodeList()
	end,
	Play410142078 = function(arg_319_0, arg_319_1)
		arg_319_1.time_ = 0
		arg_319_1.frameCnt_ = 0
		arg_319_1.state_ = "playing"
		arg_319_1.curTalkId_ = 410142078
		arg_319_1.duration_ = 7.83

		local var_319_0 = {
			ja = 7.833,
			CriLanguages = 5.2,
			zh = 5.2
		}
		local var_319_1 = manager.audio:GetLocalizationFlag()

		if var_319_0[var_319_1] ~= nil then
			arg_319_1.duration_ = var_319_0[var_319_1]
		end

		SetActive(arg_319_1.tipsGo_, false)

		function arg_319_1.onSingleLineFinish_()
			arg_319_1.onSingleLineUpdate_ = nil
			arg_319_1.onSingleLineFinish_ = nil
			arg_319_1.state_ = "waiting"
		end

		function arg_319_1.playNext_(arg_321_0)
			if arg_321_0 == 1 then
				arg_319_0:Play410142079(arg_319_1)
			end
		end

		function arg_319_1.onSingleLineUpdate_(arg_322_0)
			local var_322_0 = arg_319_1.actors_["1056"].transform
			local var_322_1 = 0

			if var_322_1 < arg_319_1.time_ and arg_319_1.time_ <= var_322_1 + arg_322_0 then
				arg_319_1.var_.moveOldPos1056 = var_322_0.localPosition
				var_322_0.localScale = Vector3.New(1, 1, 1)

				arg_319_1:CheckSpriteTmpPos("1056", 4)

				local var_322_2 = var_322_0.childCount

				for iter_322_0 = 0, var_322_2 - 1 do
					local var_322_3 = var_322_0:GetChild(iter_322_0)

					if var_322_3.name == "split_4" or not string.find(var_322_3.name, "split") then
						var_322_3.gameObject:SetActive(true)
					else
						var_322_3.gameObject:SetActive(false)
					end
				end
			end

			local var_322_4 = 0.001

			if var_322_1 <= arg_319_1.time_ and arg_319_1.time_ < var_322_1 + var_322_4 then
				local var_322_5 = (arg_319_1.time_ - var_322_1) / var_322_4
				local var_322_6 = Vector3.New(390, -350, -180)

				var_322_0.localPosition = Vector3.Lerp(arg_319_1.var_.moveOldPos1056, var_322_6, var_322_5)
			end

			if arg_319_1.time_ >= var_322_1 + var_322_4 and arg_319_1.time_ < var_322_1 + var_322_4 + arg_322_0 then
				var_322_0.localPosition = Vector3.New(390, -350, -180)
			end

			local var_322_7 = arg_319_1.actors_["1056"]
			local var_322_8 = 0

			if var_322_8 < arg_319_1.time_ and arg_319_1.time_ <= var_322_8 + arg_322_0 and not isNil(var_322_7) and arg_319_1.var_.actorSpriteComps1056 == nil then
				arg_319_1.var_.actorSpriteComps1056 = var_322_7:GetComponentsInChildren(typeof(Image), true)
			end

			local var_322_9 = 0.034

			if var_322_8 <= arg_319_1.time_ and arg_319_1.time_ < var_322_8 + var_322_9 and not isNil(var_322_7) then
				local var_322_10 = (arg_319_1.time_ - var_322_8) / var_322_9

				if arg_319_1.var_.actorSpriteComps1056 then
					for iter_322_1, iter_322_2 in pairs(arg_319_1.var_.actorSpriteComps1056:ToTable()) do
						if iter_322_2 then
							if arg_319_1.isInRecall_ then
								local var_322_11 = Mathf.Lerp(iter_322_2.color.r, arg_319_1.hightColor1.r, var_322_10)
								local var_322_12 = Mathf.Lerp(iter_322_2.color.g, arg_319_1.hightColor1.g, var_322_10)
								local var_322_13 = Mathf.Lerp(iter_322_2.color.b, arg_319_1.hightColor1.b, var_322_10)

								iter_322_2.color = Color.New(var_322_11, var_322_12, var_322_13)
							else
								local var_322_14 = Mathf.Lerp(iter_322_2.color.r, 1, var_322_10)

								iter_322_2.color = Color.New(var_322_14, var_322_14, var_322_14)
							end
						end
					end
				end
			end

			if arg_319_1.time_ >= var_322_8 + var_322_9 and arg_319_1.time_ < var_322_8 + var_322_9 + arg_322_0 and not isNil(var_322_7) and arg_319_1.var_.actorSpriteComps1056 then
				for iter_322_3, iter_322_4 in pairs(arg_319_1.var_.actorSpriteComps1056:ToTable()) do
					if iter_322_4 then
						if arg_319_1.isInRecall_ then
							iter_322_4.color = arg_319_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_322_4.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_319_1.var_.actorSpriteComps1056 = nil
			end

			local var_322_15 = arg_319_1.actors_["1061"]
			local var_322_16 = 0

			if var_322_16 < arg_319_1.time_ and arg_319_1.time_ <= var_322_16 + arg_322_0 and not isNil(var_322_15) and arg_319_1.var_.actorSpriteComps1061 == nil then
				arg_319_1.var_.actorSpriteComps1061 = var_322_15:GetComponentsInChildren(typeof(Image), true)
			end

			local var_322_17 = 0.034

			if var_322_16 <= arg_319_1.time_ and arg_319_1.time_ < var_322_16 + var_322_17 and not isNil(var_322_15) then
				local var_322_18 = (arg_319_1.time_ - var_322_16) / var_322_17

				if arg_319_1.var_.actorSpriteComps1061 then
					for iter_322_5, iter_322_6 in pairs(arg_319_1.var_.actorSpriteComps1061:ToTable()) do
						if iter_322_6 then
							if arg_319_1.isInRecall_ then
								local var_322_19 = Mathf.Lerp(iter_322_6.color.r, arg_319_1.hightColor2.r, var_322_18)
								local var_322_20 = Mathf.Lerp(iter_322_6.color.g, arg_319_1.hightColor2.g, var_322_18)
								local var_322_21 = Mathf.Lerp(iter_322_6.color.b, arg_319_1.hightColor2.b, var_322_18)

								iter_322_6.color = Color.New(var_322_19, var_322_20, var_322_21)
							else
								local var_322_22 = Mathf.Lerp(iter_322_6.color.r, 0.5, var_322_18)

								iter_322_6.color = Color.New(var_322_22, var_322_22, var_322_22)
							end
						end
					end
				end
			end

			if arg_319_1.time_ >= var_322_16 + var_322_17 and arg_319_1.time_ < var_322_16 + var_322_17 + arg_322_0 and not isNil(var_322_15) and arg_319_1.var_.actorSpriteComps1061 then
				for iter_322_7, iter_322_8 in pairs(arg_319_1.var_.actorSpriteComps1061:ToTable()) do
					if iter_322_8 then
						if arg_319_1.isInRecall_ then
							iter_322_8.color = arg_319_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_322_8.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_319_1.var_.actorSpriteComps1061 = nil
			end

			local var_322_23 = 0
			local var_322_24 = 0.525

			if var_322_23 < arg_319_1.time_ and arg_319_1.time_ <= var_322_23 + arg_322_0 then
				arg_319_1.talkMaxDuration = 0
				arg_319_1.dialogCg_.alpha = 1

				arg_319_1.dialog_:SetActive(true)
				SetActive(arg_319_1.leftNameGo_, true)

				local var_322_25 = arg_319_1:FormatText(StoryNameCfg[605].name)

				arg_319_1.leftNameTxt_.text = var_322_25

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_319_1.leftNameTxt_.transform)

				arg_319_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_319_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_319_1:RecordName(arg_319_1.leftNameTxt_.text)
				SetActive(arg_319_1.iconTrs_.gameObject, false)
				arg_319_1.callingController_:SetSelectedState("normal")

				local var_322_26 = arg_319_1:GetWordFromCfg(410142078)
				local var_322_27 = arg_319_1:FormatText(var_322_26.content)

				arg_319_1.text_.text = var_322_27

				LuaForUtil.ClearLinePrefixSymbol(arg_319_1.text_)

				local var_322_28 = 21
				local var_322_29 = utf8.len(var_322_27)
				local var_322_30 = var_322_28 <= 0 and var_322_24 or var_322_24 * (var_322_29 / var_322_28)

				if var_322_30 > 0 and var_322_24 < var_322_30 then
					arg_319_1.talkMaxDuration = var_322_30

					if var_322_30 + var_322_23 > arg_319_1.duration_ then
						arg_319_1.duration_ = var_322_30 + var_322_23
					end
				end

				arg_319_1.text_.text = var_322_27
				arg_319_1.typewritter.percent = 0

				arg_319_1.typewritter:SetDirty()
				arg_319_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_410142", "410142078", "story_v_out_410142.awb") ~= 0 then
					local var_322_31 = manager.audio:GetVoiceLength("story_v_out_410142", "410142078", "story_v_out_410142.awb") / 1000

					if var_322_31 + var_322_23 > arg_319_1.duration_ then
						arg_319_1.duration_ = var_322_31 + var_322_23
					end

					if var_322_26.prefab_name ~= "" and arg_319_1.actors_[var_322_26.prefab_name] ~= nil then
						local var_322_32 = LuaForUtil.PlayVoiceWithCriLipsync(arg_319_1.actors_[var_322_26.prefab_name].transform, "story_v_out_410142", "410142078", "story_v_out_410142.awb")

						arg_319_1:RecordAudio("410142078", var_322_32)
						arg_319_1:RecordAudio("410142078", var_322_32)
					else
						arg_319_1:AudioAction("play", "voice", "story_v_out_410142", "410142078", "story_v_out_410142.awb")
					end

					arg_319_1:RecordHistoryTalkVoice("story_v_out_410142", "410142078", "story_v_out_410142.awb")
				end

				arg_319_1:RecordContent(arg_319_1.text_.text)
			end

			local var_322_33 = math.max(var_322_24, arg_319_1.talkMaxDuration)

			if var_322_23 <= arg_319_1.time_ and arg_319_1.time_ < var_322_23 + var_322_33 then
				arg_319_1.typewritter.percent = (arg_319_1.time_ - var_322_23) / var_322_33

				arg_319_1.typewritter:SetDirty()
			end

			if arg_319_1.time_ >= var_322_23 + var_322_33 and arg_319_1.time_ < var_322_23 + var_322_33 + arg_322_0 then
				arg_319_1.typewritter.percent = 1

				arg_319_1.typewritter:SetDirty()
				arg_319_1:ShowNextGo(true)
			end
		end

		arg_319_1.nodeConfigList_ = {
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

		arg_319_1:InitPlayNodeList()
	end,
	Play410142079 = function(arg_323_0, arg_323_1)
		arg_323_1.time_ = 0
		arg_323_1.frameCnt_ = 0
		arg_323_1.state_ = "playing"
		arg_323_1.curTalkId_ = 410142079
		arg_323_1.duration_ = 14.73

		local var_323_0 = {
			ja = 14.733,
			CriLanguages = 11.133,
			zh = 11.133
		}
		local var_323_1 = manager.audio:GetLocalizationFlag()

		if var_323_0[var_323_1] ~= nil then
			arg_323_1.duration_ = var_323_0[var_323_1]
		end

		SetActive(arg_323_1.tipsGo_, false)

		function arg_323_1.onSingleLineFinish_()
			arg_323_1.onSingleLineUpdate_ = nil
			arg_323_1.onSingleLineFinish_ = nil
			arg_323_1.state_ = "waiting"
		end

		function arg_323_1.playNext_(arg_325_0)
			if arg_325_0 == 1 then
				arg_323_0:Play410142080(arg_323_1)
			end
		end

		function arg_323_1.onSingleLineUpdate_(arg_326_0)
			local var_326_0 = arg_323_1.actors_["1061"].transform
			local var_326_1 = 0

			if var_326_1 < arg_323_1.time_ and arg_323_1.time_ <= var_326_1 + arg_326_0 then
				arg_323_1.var_.moveOldPos1061 = var_326_0.localPosition
				var_326_0.localScale = Vector3.New(1, 1, 1)

				arg_323_1:CheckSpriteTmpPos("1061", 2)

				local var_326_2 = var_326_0.childCount

				for iter_326_0 = 0, var_326_2 - 1 do
					local var_326_3 = var_326_0:GetChild(iter_326_0)

					if var_326_3.name == "split_5" or not string.find(var_326_3.name, "split") then
						var_326_3.gameObject:SetActive(true)
					else
						var_326_3.gameObject:SetActive(false)
					end
				end
			end

			local var_326_4 = 0.001

			if var_326_1 <= arg_323_1.time_ and arg_323_1.time_ < var_326_1 + var_326_4 then
				local var_326_5 = (arg_323_1.time_ - var_326_1) / var_326_4
				local var_326_6 = Vector3.New(-390, -490, 18)

				var_326_0.localPosition = Vector3.Lerp(arg_323_1.var_.moveOldPos1061, var_326_6, var_326_5)
			end

			if arg_323_1.time_ >= var_326_1 + var_326_4 and arg_323_1.time_ < var_326_1 + var_326_4 + arg_326_0 then
				var_326_0.localPosition = Vector3.New(-390, -490, 18)
			end

			local var_326_7 = arg_323_1.actors_["1061"]
			local var_326_8 = 0

			if var_326_8 < arg_323_1.time_ and arg_323_1.time_ <= var_326_8 + arg_326_0 and not isNil(var_326_7) and arg_323_1.var_.actorSpriteComps1061 == nil then
				arg_323_1.var_.actorSpriteComps1061 = var_326_7:GetComponentsInChildren(typeof(Image), true)
			end

			local var_326_9 = 0.034

			if var_326_8 <= arg_323_1.time_ and arg_323_1.time_ < var_326_8 + var_326_9 and not isNil(var_326_7) then
				local var_326_10 = (arg_323_1.time_ - var_326_8) / var_326_9

				if arg_323_1.var_.actorSpriteComps1061 then
					for iter_326_1, iter_326_2 in pairs(arg_323_1.var_.actorSpriteComps1061:ToTable()) do
						if iter_326_2 then
							if arg_323_1.isInRecall_ then
								local var_326_11 = Mathf.Lerp(iter_326_2.color.r, arg_323_1.hightColor1.r, var_326_10)
								local var_326_12 = Mathf.Lerp(iter_326_2.color.g, arg_323_1.hightColor1.g, var_326_10)
								local var_326_13 = Mathf.Lerp(iter_326_2.color.b, arg_323_1.hightColor1.b, var_326_10)

								iter_326_2.color = Color.New(var_326_11, var_326_12, var_326_13)
							else
								local var_326_14 = Mathf.Lerp(iter_326_2.color.r, 1, var_326_10)

								iter_326_2.color = Color.New(var_326_14, var_326_14, var_326_14)
							end
						end
					end
				end
			end

			if arg_323_1.time_ >= var_326_8 + var_326_9 and arg_323_1.time_ < var_326_8 + var_326_9 + arg_326_0 and not isNil(var_326_7) and arg_323_1.var_.actorSpriteComps1061 then
				for iter_326_3, iter_326_4 in pairs(arg_323_1.var_.actorSpriteComps1061:ToTable()) do
					if iter_326_4 then
						if arg_323_1.isInRecall_ then
							iter_326_4.color = arg_323_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_326_4.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_323_1.var_.actorSpriteComps1061 = nil
			end

			local var_326_15 = arg_323_1.actors_["1056"]
			local var_326_16 = 0

			if var_326_16 < arg_323_1.time_ and arg_323_1.time_ <= var_326_16 + arg_326_0 and not isNil(var_326_15) and arg_323_1.var_.actorSpriteComps1056 == nil then
				arg_323_1.var_.actorSpriteComps1056 = var_326_15:GetComponentsInChildren(typeof(Image), true)
			end

			local var_326_17 = 0.0339999999999998

			if var_326_16 <= arg_323_1.time_ and arg_323_1.time_ < var_326_16 + var_326_17 and not isNil(var_326_15) then
				local var_326_18 = (arg_323_1.time_ - var_326_16) / var_326_17

				if arg_323_1.var_.actorSpriteComps1056 then
					for iter_326_5, iter_326_6 in pairs(arg_323_1.var_.actorSpriteComps1056:ToTable()) do
						if iter_326_6 then
							if arg_323_1.isInRecall_ then
								local var_326_19 = Mathf.Lerp(iter_326_6.color.r, arg_323_1.hightColor2.r, var_326_18)
								local var_326_20 = Mathf.Lerp(iter_326_6.color.g, arg_323_1.hightColor2.g, var_326_18)
								local var_326_21 = Mathf.Lerp(iter_326_6.color.b, arg_323_1.hightColor2.b, var_326_18)

								iter_326_6.color = Color.New(var_326_19, var_326_20, var_326_21)
							else
								local var_326_22 = Mathf.Lerp(iter_326_6.color.r, 0.5, var_326_18)

								iter_326_6.color = Color.New(var_326_22, var_326_22, var_326_22)
							end
						end
					end
				end
			end

			if arg_323_1.time_ >= var_326_16 + var_326_17 and arg_323_1.time_ < var_326_16 + var_326_17 + arg_326_0 and not isNil(var_326_15) and arg_323_1.var_.actorSpriteComps1056 then
				for iter_326_7, iter_326_8 in pairs(arg_323_1.var_.actorSpriteComps1056:ToTable()) do
					if iter_326_8 then
						if arg_323_1.isInRecall_ then
							iter_326_8.color = arg_323_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_326_8.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_323_1.var_.actorSpriteComps1056 = nil
			end

			local var_326_23 = 0
			local var_326_24 = 1.275

			if var_326_23 < arg_323_1.time_ and arg_323_1.time_ <= var_326_23 + arg_326_0 then
				arg_323_1.talkMaxDuration = 0
				arg_323_1.dialogCg_.alpha = 1

				arg_323_1.dialog_:SetActive(true)
				SetActive(arg_323_1.leftNameGo_, true)

				local var_326_25 = arg_323_1:FormatText(StoryNameCfg[612].name)

				arg_323_1.leftNameTxt_.text = var_326_25

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_323_1.leftNameTxt_.transform)

				arg_323_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_323_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_323_1:RecordName(arg_323_1.leftNameTxt_.text)
				SetActive(arg_323_1.iconTrs_.gameObject, false)
				arg_323_1.callingController_:SetSelectedState("normal")

				local var_326_26 = arg_323_1:GetWordFromCfg(410142079)
				local var_326_27 = arg_323_1:FormatText(var_326_26.content)

				arg_323_1.text_.text = var_326_27

				LuaForUtil.ClearLinePrefixSymbol(arg_323_1.text_)

				local var_326_28 = 51
				local var_326_29 = utf8.len(var_326_27)
				local var_326_30 = var_326_28 <= 0 and var_326_24 or var_326_24 * (var_326_29 / var_326_28)

				if var_326_30 > 0 and var_326_24 < var_326_30 then
					arg_323_1.talkMaxDuration = var_326_30

					if var_326_30 + var_326_23 > arg_323_1.duration_ then
						arg_323_1.duration_ = var_326_30 + var_326_23
					end
				end

				arg_323_1.text_.text = var_326_27
				arg_323_1.typewritter.percent = 0

				arg_323_1.typewritter:SetDirty()
				arg_323_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_410142", "410142079", "story_v_out_410142.awb") ~= 0 then
					local var_326_31 = manager.audio:GetVoiceLength("story_v_out_410142", "410142079", "story_v_out_410142.awb") / 1000

					if var_326_31 + var_326_23 > arg_323_1.duration_ then
						arg_323_1.duration_ = var_326_31 + var_326_23
					end

					if var_326_26.prefab_name ~= "" and arg_323_1.actors_[var_326_26.prefab_name] ~= nil then
						local var_326_32 = LuaForUtil.PlayVoiceWithCriLipsync(arg_323_1.actors_[var_326_26.prefab_name].transform, "story_v_out_410142", "410142079", "story_v_out_410142.awb")

						arg_323_1:RecordAudio("410142079", var_326_32)
						arg_323_1:RecordAudio("410142079", var_326_32)
					else
						arg_323_1:AudioAction("play", "voice", "story_v_out_410142", "410142079", "story_v_out_410142.awb")
					end

					arg_323_1:RecordHistoryTalkVoice("story_v_out_410142", "410142079", "story_v_out_410142.awb")
				end

				arg_323_1:RecordContent(arg_323_1.text_.text)
			end

			local var_326_33 = math.max(var_326_24, arg_323_1.talkMaxDuration)

			if var_326_23 <= arg_323_1.time_ and arg_323_1.time_ < var_326_23 + var_326_33 then
				arg_323_1.typewritter.percent = (arg_323_1.time_ - var_326_23) / var_326_33

				arg_323_1.typewritter:SetDirty()
			end

			if arg_323_1.time_ >= var_326_23 + var_326_33 and arg_323_1.time_ < var_326_23 + var_326_33 + arg_326_0 then
				arg_323_1.typewritter.percent = 1

				arg_323_1.typewritter:SetDirty()
				arg_323_1:ShowNextGo(true)
			end
		end

		arg_323_1.nodeConfigList_ = {
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

		arg_323_1:InitPlayNodeList()
	end,
	Play410142080 = function(arg_327_0, arg_327_1)
		arg_327_1.time_ = 0
		arg_327_1.frameCnt_ = 0
		arg_327_1.state_ = "playing"
		arg_327_1.curTalkId_ = 410142080
		arg_327_1.duration_ = 2.33

		local var_327_0 = {
			ja = 2.333,
			CriLanguages = 1.4,
			zh = 1.4
		}
		local var_327_1 = manager.audio:GetLocalizationFlag()

		if var_327_0[var_327_1] ~= nil then
			arg_327_1.duration_ = var_327_0[var_327_1]
		end

		SetActive(arg_327_1.tipsGo_, false)

		function arg_327_1.onSingleLineFinish_()
			arg_327_1.onSingleLineUpdate_ = nil
			arg_327_1.onSingleLineFinish_ = nil
			arg_327_1.state_ = "waiting"
		end

		function arg_327_1.playNext_(arg_329_0)
			if arg_329_0 == 1 then
				arg_327_0:Play410142081(arg_327_1)
			end
		end

		function arg_327_1.onSingleLineUpdate_(arg_330_0)
			local var_330_0 = arg_327_1.actors_["1056"].transform
			local var_330_1 = 0

			if var_330_1 < arg_327_1.time_ and arg_327_1.time_ <= var_330_1 + arg_330_0 then
				arg_327_1.var_.moveOldPos1056 = var_330_0.localPosition
				var_330_0.localScale = Vector3.New(1, 1, 1)

				arg_327_1:CheckSpriteTmpPos("1056", 4)

				local var_330_2 = var_330_0.childCount

				for iter_330_0 = 0, var_330_2 - 1 do
					local var_330_3 = var_330_0:GetChild(iter_330_0)

					if var_330_3.name == "split_3" or not string.find(var_330_3.name, "split") then
						var_330_3.gameObject:SetActive(true)
					else
						var_330_3.gameObject:SetActive(false)
					end
				end
			end

			local var_330_4 = 0.001

			if var_330_1 <= arg_327_1.time_ and arg_327_1.time_ < var_330_1 + var_330_4 then
				local var_330_5 = (arg_327_1.time_ - var_330_1) / var_330_4
				local var_330_6 = Vector3.New(390, -350, -180)

				var_330_0.localPosition = Vector3.Lerp(arg_327_1.var_.moveOldPos1056, var_330_6, var_330_5)
			end

			if arg_327_1.time_ >= var_330_1 + var_330_4 and arg_327_1.time_ < var_330_1 + var_330_4 + arg_330_0 then
				var_330_0.localPosition = Vector3.New(390, -350, -180)
			end

			local var_330_7 = arg_327_1.actors_["1056"]
			local var_330_8 = 0

			if var_330_8 < arg_327_1.time_ and arg_327_1.time_ <= var_330_8 + arg_330_0 and not isNil(var_330_7) and arg_327_1.var_.actorSpriteComps1056 == nil then
				arg_327_1.var_.actorSpriteComps1056 = var_330_7:GetComponentsInChildren(typeof(Image), true)
			end

			local var_330_9 = 0.034

			if var_330_8 <= arg_327_1.time_ and arg_327_1.time_ < var_330_8 + var_330_9 and not isNil(var_330_7) then
				local var_330_10 = (arg_327_1.time_ - var_330_8) / var_330_9

				if arg_327_1.var_.actorSpriteComps1056 then
					for iter_330_1, iter_330_2 in pairs(arg_327_1.var_.actorSpriteComps1056:ToTable()) do
						if iter_330_2 then
							if arg_327_1.isInRecall_ then
								local var_330_11 = Mathf.Lerp(iter_330_2.color.r, arg_327_1.hightColor1.r, var_330_10)
								local var_330_12 = Mathf.Lerp(iter_330_2.color.g, arg_327_1.hightColor1.g, var_330_10)
								local var_330_13 = Mathf.Lerp(iter_330_2.color.b, arg_327_1.hightColor1.b, var_330_10)

								iter_330_2.color = Color.New(var_330_11, var_330_12, var_330_13)
							else
								local var_330_14 = Mathf.Lerp(iter_330_2.color.r, 1, var_330_10)

								iter_330_2.color = Color.New(var_330_14, var_330_14, var_330_14)
							end
						end
					end
				end
			end

			if arg_327_1.time_ >= var_330_8 + var_330_9 and arg_327_1.time_ < var_330_8 + var_330_9 + arg_330_0 and not isNil(var_330_7) and arg_327_1.var_.actorSpriteComps1056 then
				for iter_330_3, iter_330_4 in pairs(arg_327_1.var_.actorSpriteComps1056:ToTable()) do
					if iter_330_4 then
						if arg_327_1.isInRecall_ then
							iter_330_4.color = arg_327_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_330_4.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_327_1.var_.actorSpriteComps1056 = nil
			end

			local var_330_15 = arg_327_1.actors_["1061"]
			local var_330_16 = 0

			if var_330_16 < arg_327_1.time_ and arg_327_1.time_ <= var_330_16 + arg_330_0 and not isNil(var_330_15) and arg_327_1.var_.actorSpriteComps1061 == nil then
				arg_327_1.var_.actorSpriteComps1061 = var_330_15:GetComponentsInChildren(typeof(Image), true)
			end

			local var_330_17 = 0.034

			if var_330_16 <= arg_327_1.time_ and arg_327_1.time_ < var_330_16 + var_330_17 and not isNil(var_330_15) then
				local var_330_18 = (arg_327_1.time_ - var_330_16) / var_330_17

				if arg_327_1.var_.actorSpriteComps1061 then
					for iter_330_5, iter_330_6 in pairs(arg_327_1.var_.actorSpriteComps1061:ToTable()) do
						if iter_330_6 then
							if arg_327_1.isInRecall_ then
								local var_330_19 = Mathf.Lerp(iter_330_6.color.r, arg_327_1.hightColor2.r, var_330_18)
								local var_330_20 = Mathf.Lerp(iter_330_6.color.g, arg_327_1.hightColor2.g, var_330_18)
								local var_330_21 = Mathf.Lerp(iter_330_6.color.b, arg_327_1.hightColor2.b, var_330_18)

								iter_330_6.color = Color.New(var_330_19, var_330_20, var_330_21)
							else
								local var_330_22 = Mathf.Lerp(iter_330_6.color.r, 0.5, var_330_18)

								iter_330_6.color = Color.New(var_330_22, var_330_22, var_330_22)
							end
						end
					end
				end
			end

			if arg_327_1.time_ >= var_330_16 + var_330_17 and arg_327_1.time_ < var_330_16 + var_330_17 + arg_330_0 and not isNil(var_330_15) and arg_327_1.var_.actorSpriteComps1061 then
				for iter_330_7, iter_330_8 in pairs(arg_327_1.var_.actorSpriteComps1061:ToTable()) do
					if iter_330_8 then
						if arg_327_1.isInRecall_ then
							iter_330_8.color = arg_327_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_330_8.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_327_1.var_.actorSpriteComps1061 = nil
			end

			local var_330_23 = 0
			local var_330_24 = 0.075

			if var_330_23 < arg_327_1.time_ and arg_327_1.time_ <= var_330_23 + arg_330_0 then
				arg_327_1.talkMaxDuration = 0
				arg_327_1.dialogCg_.alpha = 1

				arg_327_1.dialog_:SetActive(true)
				SetActive(arg_327_1.leftNameGo_, true)

				local var_330_25 = arg_327_1:FormatText(StoryNameCfg[605].name)

				arg_327_1.leftNameTxt_.text = var_330_25

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_327_1.leftNameTxt_.transform)

				arg_327_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_327_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_327_1:RecordName(arg_327_1.leftNameTxt_.text)
				SetActive(arg_327_1.iconTrs_.gameObject, false)
				arg_327_1.callingController_:SetSelectedState("normal")

				local var_330_26 = arg_327_1:GetWordFromCfg(410142080)
				local var_330_27 = arg_327_1:FormatText(var_330_26.content)

				arg_327_1.text_.text = var_330_27

				LuaForUtil.ClearLinePrefixSymbol(arg_327_1.text_)

				local var_330_28 = 3
				local var_330_29 = utf8.len(var_330_27)
				local var_330_30 = var_330_28 <= 0 and var_330_24 or var_330_24 * (var_330_29 / var_330_28)

				if var_330_30 > 0 and var_330_24 < var_330_30 then
					arg_327_1.talkMaxDuration = var_330_30

					if var_330_30 + var_330_23 > arg_327_1.duration_ then
						arg_327_1.duration_ = var_330_30 + var_330_23
					end
				end

				arg_327_1.text_.text = var_330_27
				arg_327_1.typewritter.percent = 0

				arg_327_1.typewritter:SetDirty()
				arg_327_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_410142", "410142080", "story_v_out_410142.awb") ~= 0 then
					local var_330_31 = manager.audio:GetVoiceLength("story_v_out_410142", "410142080", "story_v_out_410142.awb") / 1000

					if var_330_31 + var_330_23 > arg_327_1.duration_ then
						arg_327_1.duration_ = var_330_31 + var_330_23
					end

					if var_330_26.prefab_name ~= "" and arg_327_1.actors_[var_330_26.prefab_name] ~= nil then
						local var_330_32 = LuaForUtil.PlayVoiceWithCriLipsync(arg_327_1.actors_[var_330_26.prefab_name].transform, "story_v_out_410142", "410142080", "story_v_out_410142.awb")

						arg_327_1:RecordAudio("410142080", var_330_32)
						arg_327_1:RecordAudio("410142080", var_330_32)
					else
						arg_327_1:AudioAction("play", "voice", "story_v_out_410142", "410142080", "story_v_out_410142.awb")
					end

					arg_327_1:RecordHistoryTalkVoice("story_v_out_410142", "410142080", "story_v_out_410142.awb")
				end

				arg_327_1:RecordContent(arg_327_1.text_.text)
			end

			local var_330_33 = math.max(var_330_24, arg_327_1.talkMaxDuration)

			if var_330_23 <= arg_327_1.time_ and arg_327_1.time_ < var_330_23 + var_330_33 then
				arg_327_1.typewritter.percent = (arg_327_1.time_ - var_330_23) / var_330_33

				arg_327_1.typewritter:SetDirty()
			end

			if arg_327_1.time_ >= var_330_23 + var_330_33 and arg_327_1.time_ < var_330_23 + var_330_33 + arg_330_0 then
				arg_327_1.typewritter.percent = 1

				arg_327_1.typewritter:SetDirty()
				arg_327_1:ShowNextGo(true)
			end
		end

		arg_327_1.nodeConfigList_ = {
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

		arg_327_1:InitPlayNodeList()
	end,
	Play410142081 = function(arg_331_0, arg_331_1)
		arg_331_1.time_ = 0
		arg_331_1.frameCnt_ = 0
		arg_331_1.state_ = "playing"
		arg_331_1.curTalkId_ = 410142081
		arg_331_1.duration_ = 7.3

		local var_331_0 = {
			ja = 7.3,
			CriLanguages = 2.5,
			zh = 2.5
		}
		local var_331_1 = manager.audio:GetLocalizationFlag()

		if var_331_0[var_331_1] ~= nil then
			arg_331_1.duration_ = var_331_0[var_331_1]
		end

		SetActive(arg_331_1.tipsGo_, false)

		function arg_331_1.onSingleLineFinish_()
			arg_331_1.onSingleLineUpdate_ = nil
			arg_331_1.onSingleLineFinish_ = nil
			arg_331_1.state_ = "waiting"
		end

		function arg_331_1.playNext_(arg_333_0)
			if arg_333_0 == 1 then
				arg_331_0:Play410142082(arg_331_1)
			end
		end

		function arg_331_1.onSingleLineUpdate_(arg_334_0)
			local var_334_0 = arg_331_1.actors_["1061"].transform
			local var_334_1 = 0

			if var_334_1 < arg_331_1.time_ and arg_331_1.time_ <= var_334_1 + arg_334_0 then
				arg_331_1.var_.moveOldPos1061 = var_334_0.localPosition
				var_334_0.localScale = Vector3.New(1, 1, 1)

				arg_331_1:CheckSpriteTmpPos("1061", 2)

				local var_334_2 = var_334_0.childCount

				for iter_334_0 = 0, var_334_2 - 1 do
					local var_334_3 = var_334_0:GetChild(iter_334_0)

					if var_334_3.name == "" or not string.find(var_334_3.name, "split") then
						var_334_3.gameObject:SetActive(true)
					else
						var_334_3.gameObject:SetActive(false)
					end
				end
			end

			local var_334_4 = 0.001

			if var_334_1 <= arg_331_1.time_ and arg_331_1.time_ < var_334_1 + var_334_4 then
				local var_334_5 = (arg_331_1.time_ - var_334_1) / var_334_4
				local var_334_6 = Vector3.New(-390, -490, 18)

				var_334_0.localPosition = Vector3.Lerp(arg_331_1.var_.moveOldPos1061, var_334_6, var_334_5)
			end

			if arg_331_1.time_ >= var_334_1 + var_334_4 and arg_331_1.time_ < var_334_1 + var_334_4 + arg_334_0 then
				var_334_0.localPosition = Vector3.New(-390, -490, 18)
			end

			local var_334_7 = arg_331_1.actors_["1061"]
			local var_334_8 = 0

			if var_334_8 < arg_331_1.time_ and arg_331_1.time_ <= var_334_8 + arg_334_0 and not isNil(var_334_7) and arg_331_1.var_.actorSpriteComps1061 == nil then
				arg_331_1.var_.actorSpriteComps1061 = var_334_7:GetComponentsInChildren(typeof(Image), true)
			end

			local var_334_9 = 0.034

			if var_334_8 <= arg_331_1.time_ and arg_331_1.time_ < var_334_8 + var_334_9 and not isNil(var_334_7) then
				local var_334_10 = (arg_331_1.time_ - var_334_8) / var_334_9

				if arg_331_1.var_.actorSpriteComps1061 then
					for iter_334_1, iter_334_2 in pairs(arg_331_1.var_.actorSpriteComps1061:ToTable()) do
						if iter_334_2 then
							if arg_331_1.isInRecall_ then
								local var_334_11 = Mathf.Lerp(iter_334_2.color.r, arg_331_1.hightColor1.r, var_334_10)
								local var_334_12 = Mathf.Lerp(iter_334_2.color.g, arg_331_1.hightColor1.g, var_334_10)
								local var_334_13 = Mathf.Lerp(iter_334_2.color.b, arg_331_1.hightColor1.b, var_334_10)

								iter_334_2.color = Color.New(var_334_11, var_334_12, var_334_13)
							else
								local var_334_14 = Mathf.Lerp(iter_334_2.color.r, 1, var_334_10)

								iter_334_2.color = Color.New(var_334_14, var_334_14, var_334_14)
							end
						end
					end
				end
			end

			if arg_331_1.time_ >= var_334_8 + var_334_9 and arg_331_1.time_ < var_334_8 + var_334_9 + arg_334_0 and not isNil(var_334_7) and arg_331_1.var_.actorSpriteComps1061 then
				for iter_334_3, iter_334_4 in pairs(arg_331_1.var_.actorSpriteComps1061:ToTable()) do
					if iter_334_4 then
						if arg_331_1.isInRecall_ then
							iter_334_4.color = arg_331_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_334_4.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_331_1.var_.actorSpriteComps1061 = nil
			end

			local var_334_15 = arg_331_1.actors_["1056"]
			local var_334_16 = 0

			if var_334_16 < arg_331_1.time_ and arg_331_1.time_ <= var_334_16 + arg_334_0 and not isNil(var_334_15) and arg_331_1.var_.actorSpriteComps1056 == nil then
				arg_331_1.var_.actorSpriteComps1056 = var_334_15:GetComponentsInChildren(typeof(Image), true)
			end

			local var_334_17 = 0.0339999999999998

			if var_334_16 <= arg_331_1.time_ and arg_331_1.time_ < var_334_16 + var_334_17 and not isNil(var_334_15) then
				local var_334_18 = (arg_331_1.time_ - var_334_16) / var_334_17

				if arg_331_1.var_.actorSpriteComps1056 then
					for iter_334_5, iter_334_6 in pairs(arg_331_1.var_.actorSpriteComps1056:ToTable()) do
						if iter_334_6 then
							if arg_331_1.isInRecall_ then
								local var_334_19 = Mathf.Lerp(iter_334_6.color.r, arg_331_1.hightColor2.r, var_334_18)
								local var_334_20 = Mathf.Lerp(iter_334_6.color.g, arg_331_1.hightColor2.g, var_334_18)
								local var_334_21 = Mathf.Lerp(iter_334_6.color.b, arg_331_1.hightColor2.b, var_334_18)

								iter_334_6.color = Color.New(var_334_19, var_334_20, var_334_21)
							else
								local var_334_22 = Mathf.Lerp(iter_334_6.color.r, 0.5, var_334_18)

								iter_334_6.color = Color.New(var_334_22, var_334_22, var_334_22)
							end
						end
					end
				end
			end

			if arg_331_1.time_ >= var_334_16 + var_334_17 and arg_331_1.time_ < var_334_16 + var_334_17 + arg_334_0 and not isNil(var_334_15) and arg_331_1.var_.actorSpriteComps1056 then
				for iter_334_7, iter_334_8 in pairs(arg_331_1.var_.actorSpriteComps1056:ToTable()) do
					if iter_334_8 then
						if arg_331_1.isInRecall_ then
							iter_334_8.color = arg_331_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_334_8.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_331_1.var_.actorSpriteComps1056 = nil
			end

			local var_334_23 = 0
			local var_334_24 = 0.325

			if var_334_23 < arg_331_1.time_ and arg_331_1.time_ <= var_334_23 + arg_334_0 then
				arg_331_1.talkMaxDuration = 0
				arg_331_1.dialogCg_.alpha = 1

				arg_331_1.dialog_:SetActive(true)
				SetActive(arg_331_1.leftNameGo_, true)

				local var_334_25 = arg_331_1:FormatText(StoryNameCfg[612].name)

				arg_331_1.leftNameTxt_.text = var_334_25

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_331_1.leftNameTxt_.transform)

				arg_331_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_331_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_331_1:RecordName(arg_331_1.leftNameTxt_.text)
				SetActive(arg_331_1.iconTrs_.gameObject, false)
				arg_331_1.callingController_:SetSelectedState("normal")

				local var_334_26 = arg_331_1:GetWordFromCfg(410142081)
				local var_334_27 = arg_331_1:FormatText(var_334_26.content)

				arg_331_1.text_.text = var_334_27

				LuaForUtil.ClearLinePrefixSymbol(arg_331_1.text_)

				local var_334_28 = 13
				local var_334_29 = utf8.len(var_334_27)
				local var_334_30 = var_334_28 <= 0 and var_334_24 or var_334_24 * (var_334_29 / var_334_28)

				if var_334_30 > 0 and var_334_24 < var_334_30 then
					arg_331_1.talkMaxDuration = var_334_30

					if var_334_30 + var_334_23 > arg_331_1.duration_ then
						arg_331_1.duration_ = var_334_30 + var_334_23
					end
				end

				arg_331_1.text_.text = var_334_27
				arg_331_1.typewritter.percent = 0

				arg_331_1.typewritter:SetDirty()
				arg_331_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_410142", "410142081", "story_v_out_410142.awb") ~= 0 then
					local var_334_31 = manager.audio:GetVoiceLength("story_v_out_410142", "410142081", "story_v_out_410142.awb") / 1000

					if var_334_31 + var_334_23 > arg_331_1.duration_ then
						arg_331_1.duration_ = var_334_31 + var_334_23
					end

					if var_334_26.prefab_name ~= "" and arg_331_1.actors_[var_334_26.prefab_name] ~= nil then
						local var_334_32 = LuaForUtil.PlayVoiceWithCriLipsync(arg_331_1.actors_[var_334_26.prefab_name].transform, "story_v_out_410142", "410142081", "story_v_out_410142.awb")

						arg_331_1:RecordAudio("410142081", var_334_32)
						arg_331_1:RecordAudio("410142081", var_334_32)
					else
						arg_331_1:AudioAction("play", "voice", "story_v_out_410142", "410142081", "story_v_out_410142.awb")
					end

					arg_331_1:RecordHistoryTalkVoice("story_v_out_410142", "410142081", "story_v_out_410142.awb")
				end

				arg_331_1:RecordContent(arg_331_1.text_.text)
			end

			local var_334_33 = math.max(var_334_24, arg_331_1.talkMaxDuration)

			if var_334_23 <= arg_331_1.time_ and arg_331_1.time_ < var_334_23 + var_334_33 then
				arg_331_1.typewritter.percent = (arg_331_1.time_ - var_334_23) / var_334_33

				arg_331_1.typewritter:SetDirty()
			end

			if arg_331_1.time_ >= var_334_23 + var_334_33 and arg_331_1.time_ < var_334_23 + var_334_33 + arg_334_0 then
				arg_331_1.typewritter.percent = 1

				arg_331_1.typewritter:SetDirty()
				arg_331_1:ShowNextGo(true)
			end
		end

		arg_331_1.nodeConfigList_ = {
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

		arg_331_1:InitPlayNodeList()
	end,
	Play410142082 = function(arg_335_0, arg_335_1)
		arg_335_1.time_ = 0
		arg_335_1.frameCnt_ = 0
		arg_335_1.state_ = "playing"
		arg_335_1.curTalkId_ = 410142082
		arg_335_1.duration_ = 5

		SetActive(arg_335_1.tipsGo_, false)

		function arg_335_1.onSingleLineFinish_()
			arg_335_1.onSingleLineUpdate_ = nil
			arg_335_1.onSingleLineFinish_ = nil
			arg_335_1.state_ = "waiting"
		end

		function arg_335_1.playNext_(arg_337_0)
			if arg_337_0 == 1 then
				arg_335_0:Play410142083(arg_335_1)
			end
		end

		function arg_335_1.onSingleLineUpdate_(arg_338_0)
			local var_338_0 = arg_335_1.actors_["1056"].transform
			local var_338_1 = 0

			if var_338_1 < arg_335_1.time_ and arg_335_1.time_ <= var_338_1 + arg_338_0 then
				arg_335_1.var_.moveOldPos1056 = var_338_0.localPosition
				var_338_0.localScale = Vector3.New(1, 1, 1)

				arg_335_1:CheckSpriteTmpPos("1056", 7)

				local var_338_2 = var_338_0.childCount

				for iter_338_0 = 0, var_338_2 - 1 do
					local var_338_3 = var_338_0:GetChild(iter_338_0)

					if var_338_3.name == "" or not string.find(var_338_3.name, "split") then
						var_338_3.gameObject:SetActive(true)
					else
						var_338_3.gameObject:SetActive(false)
					end
				end
			end

			local var_338_4 = 0.001

			if var_338_1 <= arg_335_1.time_ and arg_335_1.time_ < var_338_1 + var_338_4 then
				local var_338_5 = (arg_335_1.time_ - var_338_1) / var_338_4
				local var_338_6 = Vector3.New(0, -2000, -180)

				var_338_0.localPosition = Vector3.Lerp(arg_335_1.var_.moveOldPos1056, var_338_6, var_338_5)
			end

			if arg_335_1.time_ >= var_338_1 + var_338_4 and arg_335_1.time_ < var_338_1 + var_338_4 + arg_338_0 then
				var_338_0.localPosition = Vector3.New(0, -2000, -180)
			end

			local var_338_7 = arg_335_1.actors_["1061"].transform
			local var_338_8 = 0

			if var_338_8 < arg_335_1.time_ and arg_335_1.time_ <= var_338_8 + arg_338_0 then
				arg_335_1.var_.moveOldPos1061 = var_338_7.localPosition
				var_338_7.localScale = Vector3.New(1, 1, 1)

				arg_335_1:CheckSpriteTmpPos("1061", 7)

				local var_338_9 = var_338_7.childCount

				for iter_338_1 = 0, var_338_9 - 1 do
					local var_338_10 = var_338_7:GetChild(iter_338_1)

					if var_338_10.name == "" or not string.find(var_338_10.name, "split") then
						var_338_10.gameObject:SetActive(true)
					else
						var_338_10.gameObject:SetActive(false)
					end
				end
			end

			local var_338_11 = 0.001

			if var_338_8 <= arg_335_1.time_ and arg_335_1.time_ < var_338_8 + var_338_11 then
				local var_338_12 = (arg_335_1.time_ - var_338_8) / var_338_11
				local var_338_13 = Vector3.New(0, -2000, 18)

				var_338_7.localPosition = Vector3.Lerp(arg_335_1.var_.moveOldPos1061, var_338_13, var_338_12)
			end

			if arg_335_1.time_ >= var_338_8 + var_338_11 and arg_335_1.time_ < var_338_8 + var_338_11 + arg_338_0 then
				var_338_7.localPosition = Vector3.New(0, -2000, 18)
			end

			local var_338_14 = arg_335_1.actors_["1056"]
			local var_338_15 = 0

			if var_338_15 < arg_335_1.time_ and arg_335_1.time_ <= var_338_15 + arg_338_0 and not isNil(var_338_14) and arg_335_1.var_.actorSpriteComps1056 == nil then
				arg_335_1.var_.actorSpriteComps1056 = var_338_14:GetComponentsInChildren(typeof(Image), true)
			end

			local var_338_16 = 0.034

			if var_338_15 <= arg_335_1.time_ and arg_335_1.time_ < var_338_15 + var_338_16 and not isNil(var_338_14) then
				local var_338_17 = (arg_335_1.time_ - var_338_15) / var_338_16

				if arg_335_1.var_.actorSpriteComps1056 then
					for iter_338_2, iter_338_3 in pairs(arg_335_1.var_.actorSpriteComps1056:ToTable()) do
						if iter_338_3 then
							if arg_335_1.isInRecall_ then
								local var_338_18 = Mathf.Lerp(iter_338_3.color.r, arg_335_1.hightColor2.r, var_338_17)
								local var_338_19 = Mathf.Lerp(iter_338_3.color.g, arg_335_1.hightColor2.g, var_338_17)
								local var_338_20 = Mathf.Lerp(iter_338_3.color.b, arg_335_1.hightColor2.b, var_338_17)

								iter_338_3.color = Color.New(var_338_18, var_338_19, var_338_20)
							else
								local var_338_21 = Mathf.Lerp(iter_338_3.color.r, 0.5, var_338_17)

								iter_338_3.color = Color.New(var_338_21, var_338_21, var_338_21)
							end
						end
					end
				end
			end

			if arg_335_1.time_ >= var_338_15 + var_338_16 and arg_335_1.time_ < var_338_15 + var_338_16 + arg_338_0 and not isNil(var_338_14) and arg_335_1.var_.actorSpriteComps1056 then
				for iter_338_4, iter_338_5 in pairs(arg_335_1.var_.actorSpriteComps1056:ToTable()) do
					if iter_338_5 then
						if arg_335_1.isInRecall_ then
							iter_338_5.color = arg_335_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_338_5.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_335_1.var_.actorSpriteComps1056 = nil
			end

			local var_338_22 = arg_335_1.actors_["1061"]
			local var_338_23 = 0

			if var_338_23 < arg_335_1.time_ and arg_335_1.time_ <= var_338_23 + arg_338_0 and not isNil(var_338_22) and arg_335_1.var_.actorSpriteComps1061 == nil then
				arg_335_1.var_.actorSpriteComps1061 = var_338_22:GetComponentsInChildren(typeof(Image), true)
			end

			local var_338_24 = 0.034

			if var_338_23 <= arg_335_1.time_ and arg_335_1.time_ < var_338_23 + var_338_24 and not isNil(var_338_22) then
				local var_338_25 = (arg_335_1.time_ - var_338_23) / var_338_24

				if arg_335_1.var_.actorSpriteComps1061 then
					for iter_338_6, iter_338_7 in pairs(arg_335_1.var_.actorSpriteComps1061:ToTable()) do
						if iter_338_7 then
							if arg_335_1.isInRecall_ then
								local var_338_26 = Mathf.Lerp(iter_338_7.color.r, arg_335_1.hightColor2.r, var_338_25)
								local var_338_27 = Mathf.Lerp(iter_338_7.color.g, arg_335_1.hightColor2.g, var_338_25)
								local var_338_28 = Mathf.Lerp(iter_338_7.color.b, arg_335_1.hightColor2.b, var_338_25)

								iter_338_7.color = Color.New(var_338_26, var_338_27, var_338_28)
							else
								local var_338_29 = Mathf.Lerp(iter_338_7.color.r, 0.5, var_338_25)

								iter_338_7.color = Color.New(var_338_29, var_338_29, var_338_29)
							end
						end
					end
				end
			end

			if arg_335_1.time_ >= var_338_23 + var_338_24 and arg_335_1.time_ < var_338_23 + var_338_24 + arg_338_0 and not isNil(var_338_22) and arg_335_1.var_.actorSpriteComps1061 then
				for iter_338_8, iter_338_9 in pairs(arg_335_1.var_.actorSpriteComps1061:ToTable()) do
					if iter_338_9 then
						if arg_335_1.isInRecall_ then
							iter_338_9.color = arg_335_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_338_9.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_335_1.var_.actorSpriteComps1061 = nil
			end

			local var_338_30 = 0
			local var_338_31 = 1.175

			if var_338_30 < arg_335_1.time_ and arg_335_1.time_ <= var_338_30 + arg_338_0 then
				arg_335_1.talkMaxDuration = 0
				arg_335_1.dialogCg_.alpha = 1

				arg_335_1.dialog_:SetActive(true)
				SetActive(arg_335_1.leftNameGo_, false)

				arg_335_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_335_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_335_1:RecordName(arg_335_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_335_1.iconTrs_.gameObject, false)
				arg_335_1.callingController_:SetSelectedState("normal")

				local var_338_32 = arg_335_1:GetWordFromCfg(410142082)
				local var_338_33 = arg_335_1:FormatText(var_338_32.content)

				arg_335_1.text_.text = var_338_33

				LuaForUtil.ClearLinePrefixSymbol(arg_335_1.text_)

				local var_338_34 = 47
				local var_338_35 = utf8.len(var_338_33)
				local var_338_36 = var_338_34 <= 0 and var_338_31 or var_338_31 * (var_338_35 / var_338_34)

				if var_338_36 > 0 and var_338_31 < var_338_36 then
					arg_335_1.talkMaxDuration = var_338_36

					if var_338_36 + var_338_30 > arg_335_1.duration_ then
						arg_335_1.duration_ = var_338_36 + var_338_30
					end
				end

				arg_335_1.text_.text = var_338_33
				arg_335_1.typewritter.percent = 0

				arg_335_1.typewritter:SetDirty()
				arg_335_1:ShowNextGo(false)
				arg_335_1:RecordContent(arg_335_1.text_.text)
			end

			local var_338_37 = math.max(var_338_31, arg_335_1.talkMaxDuration)

			if var_338_30 <= arg_335_1.time_ and arg_335_1.time_ < var_338_30 + var_338_37 then
				arg_335_1.typewritter.percent = (arg_335_1.time_ - var_338_30) / var_338_37

				arg_335_1.typewritter:SetDirty()
			end

			if arg_335_1.time_ >= var_338_30 + var_338_37 and arg_335_1.time_ < var_338_30 + var_338_37 + arg_338_0 then
				arg_335_1.typewritter.percent = 1

				arg_335_1.typewritter:SetDirty()
				arg_335_1:ShowNextGo(true)
			end
		end

		arg_335_1.nodeConfigList_ = {
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
				actorName = "1061",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_335_1:InitPlayNodeList()
	end,
	Play410142083 = function(arg_339_0, arg_339_1)
		arg_339_1.time_ = 0
		arg_339_1.frameCnt_ = 0
		arg_339_1.state_ = "playing"
		arg_339_1.curTalkId_ = 410142083
		arg_339_1.duration_ = 10.5

		local var_339_0 = {
			ja = 7.766,
			CriLanguages = 10.5,
			zh = 10.5
		}
		local var_339_1 = manager.audio:GetLocalizationFlag()

		if var_339_0[var_339_1] ~= nil then
			arg_339_1.duration_ = var_339_0[var_339_1]
		end

		SetActive(arg_339_1.tipsGo_, false)

		function arg_339_1.onSingleLineFinish_()
			arg_339_1.onSingleLineUpdate_ = nil
			arg_339_1.onSingleLineFinish_ = nil
			arg_339_1.state_ = "waiting"
		end

		function arg_339_1.playNext_(arg_341_0)
			if arg_341_0 == 1 then
				arg_339_0:Play410142084(arg_339_1)
			end
		end

		function arg_339_1.onSingleLineUpdate_(arg_342_0)
			local var_342_0 = arg_339_1.actors_["1061"].transform
			local var_342_1 = 0

			if var_342_1 < arg_339_1.time_ and arg_339_1.time_ <= var_342_1 + arg_342_0 then
				arg_339_1.var_.moveOldPos1061 = var_342_0.localPosition
				var_342_0.localScale = Vector3.New(1, 1, 1)

				arg_339_1:CheckSpriteTmpPos("1061", 3)

				local var_342_2 = var_342_0.childCount

				for iter_342_0 = 0, var_342_2 - 1 do
					local var_342_3 = var_342_0:GetChild(iter_342_0)

					if var_342_3.name == "split_7" or not string.find(var_342_3.name, "split") then
						var_342_3.gameObject:SetActive(true)
					else
						var_342_3.gameObject:SetActive(false)
					end
				end
			end

			local var_342_4 = 0.001

			if var_342_1 <= arg_339_1.time_ and arg_339_1.time_ < var_342_1 + var_342_4 then
				local var_342_5 = (arg_339_1.time_ - var_342_1) / var_342_4
				local var_342_6 = Vector3.New(0, -490, 18)

				var_342_0.localPosition = Vector3.Lerp(arg_339_1.var_.moveOldPos1061, var_342_6, var_342_5)
			end

			if arg_339_1.time_ >= var_342_1 + var_342_4 and arg_339_1.time_ < var_342_1 + var_342_4 + arg_342_0 then
				var_342_0.localPosition = Vector3.New(0, -490, 18)
			end

			local var_342_7 = arg_339_1.actors_["1061"]
			local var_342_8 = 0

			if var_342_8 < arg_339_1.time_ and arg_339_1.time_ <= var_342_8 + arg_342_0 and not isNil(var_342_7) and arg_339_1.var_.actorSpriteComps1061 == nil then
				arg_339_1.var_.actorSpriteComps1061 = var_342_7:GetComponentsInChildren(typeof(Image), true)
			end

			local var_342_9 = 0.034

			if var_342_8 <= arg_339_1.time_ and arg_339_1.time_ < var_342_8 + var_342_9 and not isNil(var_342_7) then
				local var_342_10 = (arg_339_1.time_ - var_342_8) / var_342_9

				if arg_339_1.var_.actorSpriteComps1061 then
					for iter_342_1, iter_342_2 in pairs(arg_339_1.var_.actorSpriteComps1061:ToTable()) do
						if iter_342_2 then
							if arg_339_1.isInRecall_ then
								local var_342_11 = Mathf.Lerp(iter_342_2.color.r, arg_339_1.hightColor1.r, var_342_10)
								local var_342_12 = Mathf.Lerp(iter_342_2.color.g, arg_339_1.hightColor1.g, var_342_10)
								local var_342_13 = Mathf.Lerp(iter_342_2.color.b, arg_339_1.hightColor1.b, var_342_10)

								iter_342_2.color = Color.New(var_342_11, var_342_12, var_342_13)
							else
								local var_342_14 = Mathf.Lerp(iter_342_2.color.r, 1, var_342_10)

								iter_342_2.color = Color.New(var_342_14, var_342_14, var_342_14)
							end
						end
					end
				end
			end

			if arg_339_1.time_ >= var_342_8 + var_342_9 and arg_339_1.time_ < var_342_8 + var_342_9 + arg_342_0 and not isNil(var_342_7) and arg_339_1.var_.actorSpriteComps1061 then
				for iter_342_3, iter_342_4 in pairs(arg_339_1.var_.actorSpriteComps1061:ToTable()) do
					if iter_342_4 then
						if arg_339_1.isInRecall_ then
							iter_342_4.color = arg_339_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_342_4.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_339_1.var_.actorSpriteComps1061 = nil
			end

			local var_342_15 = 0
			local var_342_16 = 1.15

			if var_342_15 < arg_339_1.time_ and arg_339_1.time_ <= var_342_15 + arg_342_0 then
				arg_339_1.talkMaxDuration = 0
				arg_339_1.dialogCg_.alpha = 1

				arg_339_1.dialog_:SetActive(true)
				SetActive(arg_339_1.leftNameGo_, true)

				local var_342_17 = arg_339_1:FormatText(StoryNameCfg[612].name)

				arg_339_1.leftNameTxt_.text = var_342_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_339_1.leftNameTxt_.transform)

				arg_339_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_339_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_339_1:RecordName(arg_339_1.leftNameTxt_.text)
				SetActive(arg_339_1.iconTrs_.gameObject, false)
				arg_339_1.callingController_:SetSelectedState("normal")

				local var_342_18 = arg_339_1:GetWordFromCfg(410142083)
				local var_342_19 = arg_339_1:FormatText(var_342_18.content)

				arg_339_1.text_.text = var_342_19

				LuaForUtil.ClearLinePrefixSymbol(arg_339_1.text_)

				local var_342_20 = 46
				local var_342_21 = utf8.len(var_342_19)
				local var_342_22 = var_342_20 <= 0 and var_342_16 or var_342_16 * (var_342_21 / var_342_20)

				if var_342_22 > 0 and var_342_16 < var_342_22 then
					arg_339_1.talkMaxDuration = var_342_22

					if var_342_22 + var_342_15 > arg_339_1.duration_ then
						arg_339_1.duration_ = var_342_22 + var_342_15
					end
				end

				arg_339_1.text_.text = var_342_19
				arg_339_1.typewritter.percent = 0

				arg_339_1.typewritter:SetDirty()
				arg_339_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_410142", "410142083", "story_v_out_410142.awb") ~= 0 then
					local var_342_23 = manager.audio:GetVoiceLength("story_v_out_410142", "410142083", "story_v_out_410142.awb") / 1000

					if var_342_23 + var_342_15 > arg_339_1.duration_ then
						arg_339_1.duration_ = var_342_23 + var_342_15
					end

					if var_342_18.prefab_name ~= "" and arg_339_1.actors_[var_342_18.prefab_name] ~= nil then
						local var_342_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_339_1.actors_[var_342_18.prefab_name].transform, "story_v_out_410142", "410142083", "story_v_out_410142.awb")

						arg_339_1:RecordAudio("410142083", var_342_24)
						arg_339_1:RecordAudio("410142083", var_342_24)
					else
						arg_339_1:AudioAction("play", "voice", "story_v_out_410142", "410142083", "story_v_out_410142.awb")
					end

					arg_339_1:RecordHistoryTalkVoice("story_v_out_410142", "410142083", "story_v_out_410142.awb")
				end

				arg_339_1:RecordContent(arg_339_1.text_.text)
			end

			local var_342_25 = math.max(var_342_16, arg_339_1.talkMaxDuration)

			if var_342_15 <= arg_339_1.time_ and arg_339_1.time_ < var_342_15 + var_342_25 then
				arg_339_1.typewritter.percent = (arg_339_1.time_ - var_342_15) / var_342_25

				arg_339_1.typewritter:SetDirty()
			end

			if arg_339_1.time_ >= var_342_15 + var_342_25 and arg_339_1.time_ < var_342_15 + var_342_25 + arg_342_0 then
				arg_339_1.typewritter.percent = 1

				arg_339_1.typewritter:SetDirty()
				arg_339_1:ShowNextGo(true)
			end
		end

		arg_339_1.nodeConfigList_ = {
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

		arg_339_1:InitPlayNodeList()
	end,
	Play410142084 = function(arg_343_0, arg_343_1)
		arg_343_1.time_ = 0
		arg_343_1.frameCnt_ = 0
		arg_343_1.state_ = "playing"
		arg_343_1.curTalkId_ = 410142084
		arg_343_1.duration_ = 11.17

		local var_343_0 = {
			ja = 11.166,
			CriLanguages = 10.966,
			zh = 10.966
		}
		local var_343_1 = manager.audio:GetLocalizationFlag()

		if var_343_0[var_343_1] ~= nil then
			arg_343_1.duration_ = var_343_0[var_343_1]
		end

		SetActive(arg_343_1.tipsGo_, false)

		function arg_343_1.onSingleLineFinish_()
			arg_343_1.onSingleLineUpdate_ = nil
			arg_343_1.onSingleLineFinish_ = nil
			arg_343_1.state_ = "waiting"
		end

		function arg_343_1.playNext_(arg_345_0)
			if arg_345_0 == 1 then
				arg_343_0:Play410142085(arg_343_1)
			end
		end

		function arg_343_1.onSingleLineUpdate_(arg_346_0)
			local var_346_0 = arg_343_1.actors_["1061"].transform
			local var_346_1 = 0

			if var_346_1 < arg_343_1.time_ and arg_343_1.time_ <= var_346_1 + arg_346_0 then
				arg_343_1.var_.moveOldPos1061 = var_346_0.localPosition
				var_346_0.localScale = Vector3.New(1, 1, 1)

				arg_343_1:CheckSpriteTmpPos("1061", 3)

				local var_346_2 = var_346_0.childCount

				for iter_346_0 = 0, var_346_2 - 1 do
					local var_346_3 = var_346_0:GetChild(iter_346_0)

					if var_346_3.name == "split_7" or not string.find(var_346_3.name, "split") then
						var_346_3.gameObject:SetActive(true)
					else
						var_346_3.gameObject:SetActive(false)
					end
				end
			end

			local var_346_4 = 0.001

			if var_346_1 <= arg_343_1.time_ and arg_343_1.time_ < var_346_1 + var_346_4 then
				local var_346_5 = (arg_343_1.time_ - var_346_1) / var_346_4
				local var_346_6 = Vector3.New(0, -490, 18)

				var_346_0.localPosition = Vector3.Lerp(arg_343_1.var_.moveOldPos1061, var_346_6, var_346_5)
			end

			if arg_343_1.time_ >= var_346_1 + var_346_4 and arg_343_1.time_ < var_346_1 + var_346_4 + arg_346_0 then
				var_346_0.localPosition = Vector3.New(0, -490, 18)
			end

			local var_346_7 = arg_343_1.actors_["1061"]
			local var_346_8 = 0

			if var_346_8 < arg_343_1.time_ and arg_343_1.time_ <= var_346_8 + arg_346_0 and not isNil(var_346_7) and arg_343_1.var_.actorSpriteComps1061 == nil then
				arg_343_1.var_.actorSpriteComps1061 = var_346_7:GetComponentsInChildren(typeof(Image), true)
			end

			local var_346_9 = 0.034

			if var_346_8 <= arg_343_1.time_ and arg_343_1.time_ < var_346_8 + var_346_9 and not isNil(var_346_7) then
				local var_346_10 = (arg_343_1.time_ - var_346_8) / var_346_9

				if arg_343_1.var_.actorSpriteComps1061 then
					for iter_346_1, iter_346_2 in pairs(arg_343_1.var_.actorSpriteComps1061:ToTable()) do
						if iter_346_2 then
							if arg_343_1.isInRecall_ then
								local var_346_11 = Mathf.Lerp(iter_346_2.color.r, arg_343_1.hightColor1.r, var_346_10)
								local var_346_12 = Mathf.Lerp(iter_346_2.color.g, arg_343_1.hightColor1.g, var_346_10)
								local var_346_13 = Mathf.Lerp(iter_346_2.color.b, arg_343_1.hightColor1.b, var_346_10)

								iter_346_2.color = Color.New(var_346_11, var_346_12, var_346_13)
							else
								local var_346_14 = Mathf.Lerp(iter_346_2.color.r, 1, var_346_10)

								iter_346_2.color = Color.New(var_346_14, var_346_14, var_346_14)
							end
						end
					end
				end
			end

			if arg_343_1.time_ >= var_346_8 + var_346_9 and arg_343_1.time_ < var_346_8 + var_346_9 + arg_346_0 and not isNil(var_346_7) and arg_343_1.var_.actorSpriteComps1061 then
				for iter_346_3, iter_346_4 in pairs(arg_343_1.var_.actorSpriteComps1061:ToTable()) do
					if iter_346_4 then
						if arg_343_1.isInRecall_ then
							iter_346_4.color = arg_343_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_346_4.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_343_1.var_.actorSpriteComps1061 = nil
			end

			local var_346_15 = 0
			local var_346_16 = 1.05

			if var_346_15 < arg_343_1.time_ and arg_343_1.time_ <= var_346_15 + arg_346_0 then
				arg_343_1.talkMaxDuration = 0
				arg_343_1.dialogCg_.alpha = 1

				arg_343_1.dialog_:SetActive(true)
				SetActive(arg_343_1.leftNameGo_, true)

				local var_346_17 = arg_343_1:FormatText(StoryNameCfg[612].name)

				arg_343_1.leftNameTxt_.text = var_346_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_343_1.leftNameTxt_.transform)

				arg_343_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_343_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_343_1:RecordName(arg_343_1.leftNameTxt_.text)
				SetActive(arg_343_1.iconTrs_.gameObject, false)
				arg_343_1.callingController_:SetSelectedState("normal")

				local var_346_18 = arg_343_1:GetWordFromCfg(410142084)
				local var_346_19 = arg_343_1:FormatText(var_346_18.content)

				arg_343_1.text_.text = var_346_19

				LuaForUtil.ClearLinePrefixSymbol(arg_343_1.text_)

				local var_346_20 = 43
				local var_346_21 = utf8.len(var_346_19)
				local var_346_22 = var_346_20 <= 0 and var_346_16 or var_346_16 * (var_346_21 / var_346_20)

				if var_346_22 > 0 and var_346_16 < var_346_22 then
					arg_343_1.talkMaxDuration = var_346_22

					if var_346_22 + var_346_15 > arg_343_1.duration_ then
						arg_343_1.duration_ = var_346_22 + var_346_15
					end
				end

				arg_343_1.text_.text = var_346_19
				arg_343_1.typewritter.percent = 0

				arg_343_1.typewritter:SetDirty()
				arg_343_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_410142", "410142084", "story_v_out_410142.awb") ~= 0 then
					local var_346_23 = manager.audio:GetVoiceLength("story_v_out_410142", "410142084", "story_v_out_410142.awb") / 1000

					if var_346_23 + var_346_15 > arg_343_1.duration_ then
						arg_343_1.duration_ = var_346_23 + var_346_15
					end

					if var_346_18.prefab_name ~= "" and arg_343_1.actors_[var_346_18.prefab_name] ~= nil then
						local var_346_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_343_1.actors_[var_346_18.prefab_name].transform, "story_v_out_410142", "410142084", "story_v_out_410142.awb")

						arg_343_1:RecordAudio("410142084", var_346_24)
						arg_343_1:RecordAudio("410142084", var_346_24)
					else
						arg_343_1:AudioAction("play", "voice", "story_v_out_410142", "410142084", "story_v_out_410142.awb")
					end

					arg_343_1:RecordHistoryTalkVoice("story_v_out_410142", "410142084", "story_v_out_410142.awb")
				end

				arg_343_1:RecordContent(arg_343_1.text_.text)
			end

			local var_346_25 = math.max(var_346_16, arg_343_1.talkMaxDuration)

			if var_346_15 <= arg_343_1.time_ and arg_343_1.time_ < var_346_15 + var_346_25 then
				arg_343_1.typewritter.percent = (arg_343_1.time_ - var_346_15) / var_346_25

				arg_343_1.typewritter:SetDirty()
			end

			if arg_343_1.time_ >= var_346_15 + var_346_25 and arg_343_1.time_ < var_346_15 + var_346_25 + arg_346_0 then
				arg_343_1.typewritter.percent = 1

				arg_343_1.typewritter:SetDirty()
				arg_343_1:ShowNextGo(true)
			end
		end

		arg_343_1.nodeConfigList_ = {
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

		arg_343_1:InitPlayNodeList()
	end,
	Play410142085 = function(arg_347_0, arg_347_1)
		arg_347_1.time_ = 0
		arg_347_1.frameCnt_ = 0
		arg_347_1.state_ = "playing"
		arg_347_1.curTalkId_ = 410142085
		arg_347_1.duration_ = 7.17

		local var_347_0 = {
			ja = 6.633,
			CriLanguages = 7.166,
			zh = 7.166
		}
		local var_347_1 = manager.audio:GetLocalizationFlag()

		if var_347_0[var_347_1] ~= nil then
			arg_347_1.duration_ = var_347_0[var_347_1]
		end

		SetActive(arg_347_1.tipsGo_, false)

		function arg_347_1.onSingleLineFinish_()
			arg_347_1.onSingleLineUpdate_ = nil
			arg_347_1.onSingleLineFinish_ = nil
			arg_347_1.state_ = "waiting"
		end

		function arg_347_1.playNext_(arg_349_0)
			if arg_349_0 == 1 then
				arg_347_0:Play410142086(arg_347_1)
			end
		end

		function arg_347_1.onSingleLineUpdate_(arg_350_0)
			local var_350_0 = arg_347_1.actors_["1061"].transform
			local var_350_1 = 0

			if var_350_1 < arg_347_1.time_ and arg_347_1.time_ <= var_350_1 + arg_350_0 then
				arg_347_1.var_.moveOldPos1061 = var_350_0.localPosition
				var_350_0.localScale = Vector3.New(1, 1, 1)

				arg_347_1:CheckSpriteTmpPos("1061", 3)

				local var_350_2 = var_350_0.childCount

				for iter_350_0 = 0, var_350_2 - 1 do
					local var_350_3 = var_350_0:GetChild(iter_350_0)

					if var_350_3.name == "split_7" or not string.find(var_350_3.name, "split") then
						var_350_3.gameObject:SetActive(true)
					else
						var_350_3.gameObject:SetActive(false)
					end
				end
			end

			local var_350_4 = 0.001

			if var_350_1 <= arg_347_1.time_ and arg_347_1.time_ < var_350_1 + var_350_4 then
				local var_350_5 = (arg_347_1.time_ - var_350_1) / var_350_4
				local var_350_6 = Vector3.New(0, -490, 18)

				var_350_0.localPosition = Vector3.Lerp(arg_347_1.var_.moveOldPos1061, var_350_6, var_350_5)
			end

			if arg_347_1.time_ >= var_350_1 + var_350_4 and arg_347_1.time_ < var_350_1 + var_350_4 + arg_350_0 then
				var_350_0.localPosition = Vector3.New(0, -490, 18)
			end

			local var_350_7 = arg_347_1.actors_["1061"]
			local var_350_8 = 0

			if var_350_8 < arg_347_1.time_ and arg_347_1.time_ <= var_350_8 + arg_350_0 and not isNil(var_350_7) and arg_347_1.var_.actorSpriteComps1061 == nil then
				arg_347_1.var_.actorSpriteComps1061 = var_350_7:GetComponentsInChildren(typeof(Image), true)
			end

			local var_350_9 = 0.034

			if var_350_8 <= arg_347_1.time_ and arg_347_1.time_ < var_350_8 + var_350_9 and not isNil(var_350_7) then
				local var_350_10 = (arg_347_1.time_ - var_350_8) / var_350_9

				if arg_347_1.var_.actorSpriteComps1061 then
					for iter_350_1, iter_350_2 in pairs(arg_347_1.var_.actorSpriteComps1061:ToTable()) do
						if iter_350_2 then
							if arg_347_1.isInRecall_ then
								local var_350_11 = Mathf.Lerp(iter_350_2.color.r, arg_347_1.hightColor1.r, var_350_10)
								local var_350_12 = Mathf.Lerp(iter_350_2.color.g, arg_347_1.hightColor1.g, var_350_10)
								local var_350_13 = Mathf.Lerp(iter_350_2.color.b, arg_347_1.hightColor1.b, var_350_10)

								iter_350_2.color = Color.New(var_350_11, var_350_12, var_350_13)
							else
								local var_350_14 = Mathf.Lerp(iter_350_2.color.r, 1, var_350_10)

								iter_350_2.color = Color.New(var_350_14, var_350_14, var_350_14)
							end
						end
					end
				end
			end

			if arg_347_1.time_ >= var_350_8 + var_350_9 and arg_347_1.time_ < var_350_8 + var_350_9 + arg_350_0 and not isNil(var_350_7) and arg_347_1.var_.actorSpriteComps1061 then
				for iter_350_3, iter_350_4 in pairs(arg_347_1.var_.actorSpriteComps1061:ToTable()) do
					if iter_350_4 then
						if arg_347_1.isInRecall_ then
							iter_350_4.color = arg_347_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_350_4.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_347_1.var_.actorSpriteComps1061 = nil
			end

			local var_350_15 = 0
			local var_350_16 = 0.425

			if var_350_15 < arg_347_1.time_ and arg_347_1.time_ <= var_350_15 + arg_350_0 then
				arg_347_1.talkMaxDuration = 0
				arg_347_1.dialogCg_.alpha = 1

				arg_347_1.dialog_:SetActive(true)
				SetActive(arg_347_1.leftNameGo_, true)

				local var_350_17 = arg_347_1:FormatText(StoryNameCfg[612].name)

				arg_347_1.leftNameTxt_.text = var_350_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_347_1.leftNameTxt_.transform)

				arg_347_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_347_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_347_1:RecordName(arg_347_1.leftNameTxt_.text)
				SetActive(arg_347_1.iconTrs_.gameObject, false)
				arg_347_1.callingController_:SetSelectedState("normal")

				local var_350_18 = arg_347_1:GetWordFromCfg(410142085)
				local var_350_19 = arg_347_1:FormatText(var_350_18.content)

				arg_347_1.text_.text = var_350_19

				LuaForUtil.ClearLinePrefixSymbol(arg_347_1.text_)

				local var_350_20 = 17
				local var_350_21 = utf8.len(var_350_19)
				local var_350_22 = var_350_20 <= 0 and var_350_16 or var_350_16 * (var_350_21 / var_350_20)

				if var_350_22 > 0 and var_350_16 < var_350_22 then
					arg_347_1.talkMaxDuration = var_350_22

					if var_350_22 + var_350_15 > arg_347_1.duration_ then
						arg_347_1.duration_ = var_350_22 + var_350_15
					end
				end

				arg_347_1.text_.text = var_350_19
				arg_347_1.typewritter.percent = 0

				arg_347_1.typewritter:SetDirty()
				arg_347_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_410142", "410142085", "story_v_out_410142.awb") ~= 0 then
					local var_350_23 = manager.audio:GetVoiceLength("story_v_out_410142", "410142085", "story_v_out_410142.awb") / 1000

					if var_350_23 + var_350_15 > arg_347_1.duration_ then
						arg_347_1.duration_ = var_350_23 + var_350_15
					end

					if var_350_18.prefab_name ~= "" and arg_347_1.actors_[var_350_18.prefab_name] ~= nil then
						local var_350_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_347_1.actors_[var_350_18.prefab_name].transform, "story_v_out_410142", "410142085", "story_v_out_410142.awb")

						arg_347_1:RecordAudio("410142085", var_350_24)
						arg_347_1:RecordAudio("410142085", var_350_24)
					else
						arg_347_1:AudioAction("play", "voice", "story_v_out_410142", "410142085", "story_v_out_410142.awb")
					end

					arg_347_1:RecordHistoryTalkVoice("story_v_out_410142", "410142085", "story_v_out_410142.awb")
				end

				arg_347_1:RecordContent(arg_347_1.text_.text)
			end

			local var_350_25 = math.max(var_350_16, arg_347_1.talkMaxDuration)

			if var_350_15 <= arg_347_1.time_ and arg_347_1.time_ < var_350_15 + var_350_25 then
				arg_347_1.typewritter.percent = (arg_347_1.time_ - var_350_15) / var_350_25

				arg_347_1.typewritter:SetDirty()
			end

			if arg_347_1.time_ >= var_350_15 + var_350_25 and arg_347_1.time_ < var_350_15 + var_350_25 + arg_350_0 then
				arg_347_1.typewritter.percent = 1

				arg_347_1.typewritter:SetDirty()
				arg_347_1:ShowNextGo(true)
			end
		end

		arg_347_1.nodeConfigList_ = {
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

		arg_347_1:InitPlayNodeList()
	end,
	Play410142086 = function(arg_351_0, arg_351_1)
		arg_351_1.time_ = 0
		arg_351_1.frameCnt_ = 0
		arg_351_1.state_ = "playing"
		arg_351_1.curTalkId_ = 410142086
		arg_351_1.duration_ = 5

		SetActive(arg_351_1.tipsGo_, false)

		function arg_351_1.onSingleLineFinish_()
			arg_351_1.onSingleLineUpdate_ = nil
			arg_351_1.onSingleLineFinish_ = nil
			arg_351_1.state_ = "waiting"
		end

		function arg_351_1.playNext_(arg_353_0)
			if arg_353_0 == 1 then
				arg_351_0:Play410142087(arg_351_1)
			end
		end

		function arg_351_1.onSingleLineUpdate_(arg_354_0)
			local var_354_0 = arg_351_1.actors_["1061"]
			local var_354_1 = 0

			if var_354_1 < arg_351_1.time_ and arg_351_1.time_ <= var_354_1 + arg_354_0 and not isNil(var_354_0) and arg_351_1.var_.actorSpriteComps1061 == nil then
				arg_351_1.var_.actorSpriteComps1061 = var_354_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_354_2 = 0.034

			if var_354_1 <= arg_351_1.time_ and arg_351_1.time_ < var_354_1 + var_354_2 and not isNil(var_354_0) then
				local var_354_3 = (arg_351_1.time_ - var_354_1) / var_354_2

				if arg_351_1.var_.actorSpriteComps1061 then
					for iter_354_0, iter_354_1 in pairs(arg_351_1.var_.actorSpriteComps1061:ToTable()) do
						if iter_354_1 then
							if arg_351_1.isInRecall_ then
								local var_354_4 = Mathf.Lerp(iter_354_1.color.r, arg_351_1.hightColor2.r, var_354_3)
								local var_354_5 = Mathf.Lerp(iter_354_1.color.g, arg_351_1.hightColor2.g, var_354_3)
								local var_354_6 = Mathf.Lerp(iter_354_1.color.b, arg_351_1.hightColor2.b, var_354_3)

								iter_354_1.color = Color.New(var_354_4, var_354_5, var_354_6)
							else
								local var_354_7 = Mathf.Lerp(iter_354_1.color.r, 0.5, var_354_3)

								iter_354_1.color = Color.New(var_354_7, var_354_7, var_354_7)
							end
						end
					end
				end
			end

			if arg_351_1.time_ >= var_354_1 + var_354_2 and arg_351_1.time_ < var_354_1 + var_354_2 + arg_354_0 and not isNil(var_354_0) and arg_351_1.var_.actorSpriteComps1061 then
				for iter_354_2, iter_354_3 in pairs(arg_351_1.var_.actorSpriteComps1061:ToTable()) do
					if iter_354_3 then
						if arg_351_1.isInRecall_ then
							iter_354_3.color = arg_351_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_354_3.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_351_1.var_.actorSpriteComps1061 = nil
			end

			local var_354_8 = 0
			local var_354_9 = 1.15

			if var_354_8 < arg_351_1.time_ and arg_351_1.time_ <= var_354_8 + arg_354_0 then
				arg_351_1.talkMaxDuration = 0
				arg_351_1.dialogCg_.alpha = 1

				arg_351_1.dialog_:SetActive(true)
				SetActive(arg_351_1.leftNameGo_, false)

				arg_351_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_351_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_351_1:RecordName(arg_351_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_351_1.iconTrs_.gameObject, false)
				arg_351_1.callingController_:SetSelectedState("normal")

				local var_354_10 = arg_351_1:GetWordFromCfg(410142086)
				local var_354_11 = arg_351_1:FormatText(var_354_10.content)

				arg_351_1.text_.text = var_354_11

				LuaForUtil.ClearLinePrefixSymbol(arg_351_1.text_)

				local var_354_12 = 46
				local var_354_13 = utf8.len(var_354_11)
				local var_354_14 = var_354_12 <= 0 and var_354_9 or var_354_9 * (var_354_13 / var_354_12)

				if var_354_14 > 0 and var_354_9 < var_354_14 then
					arg_351_1.talkMaxDuration = var_354_14

					if var_354_14 + var_354_8 > arg_351_1.duration_ then
						arg_351_1.duration_ = var_354_14 + var_354_8
					end
				end

				arg_351_1.text_.text = var_354_11
				arg_351_1.typewritter.percent = 0

				arg_351_1.typewritter:SetDirty()
				arg_351_1:ShowNextGo(false)
				arg_351_1:RecordContent(arg_351_1.text_.text)
			end

			local var_354_15 = math.max(var_354_9, arg_351_1.talkMaxDuration)

			if var_354_8 <= arg_351_1.time_ and arg_351_1.time_ < var_354_8 + var_354_15 then
				arg_351_1.typewritter.percent = (arg_351_1.time_ - var_354_8) / var_354_15

				arg_351_1.typewritter:SetDirty()
			end

			if arg_351_1.time_ >= var_354_8 + var_354_15 and arg_351_1.time_ < var_354_8 + var_354_15 + arg_354_0 then
				arg_351_1.typewritter.percent = 1

				arg_351_1.typewritter:SetDirty()
				arg_351_1:ShowNextGo(true)
			end
		end

		arg_351_1.nodeConfigList_ = {}

		arg_351_1:InitPlayNodeList()
	end,
	Play410142087 = function(arg_355_0, arg_355_1)
		arg_355_1.time_ = 0
		arg_355_1.frameCnt_ = 0
		arg_355_1.state_ = "playing"
		arg_355_1.curTalkId_ = 410142087
		arg_355_1.duration_ = 4.2

		SetActive(arg_355_1.tipsGo_, false)

		function arg_355_1.onSingleLineFinish_()
			arg_355_1.onSingleLineUpdate_ = nil
			arg_355_1.onSingleLineFinish_ = nil
			arg_355_1.state_ = "waiting"
		end

		function arg_355_1.playNext_(arg_357_0)
			if arg_357_0 == 1 then
				arg_355_0:Play410142088(arg_355_1)
			end
		end

		function arg_355_1.onSingleLineUpdate_(arg_358_0)
			local var_358_0 = "STblack"

			if arg_355_1.bgs_[var_358_0] == nil then
				local var_358_1 = Object.Instantiate(arg_355_1.paintGo_)

				var_358_1:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. var_358_0)
				var_358_1.name = var_358_0
				var_358_1.transform.parent = arg_355_1.stage_.transform
				var_358_1.transform.localPosition = Vector3.New(0, 100, 0)
				arg_355_1.bgs_[var_358_0] = var_358_1
			end

			local var_358_2 = 2

			if var_358_2 < arg_355_1.time_ and arg_355_1.time_ <= var_358_2 + arg_358_0 then
				local var_358_3 = manager.ui.mainCamera.transform.localPosition
				local var_358_4 = Vector3.New(0, 0, 10) + Vector3.New(var_358_3.x, var_358_3.y, 0)
				local var_358_5 = arg_355_1.bgs_.STblack

				var_358_5.transform.localPosition = var_358_4
				var_358_5.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_358_6 = var_358_5:GetComponent("SpriteRenderer")

				if var_358_6 and var_358_6.sprite then
					local var_358_7 = (var_358_5.transform.localPosition - var_358_3).z
					local var_358_8 = manager.ui.mainCameraCom_
					local var_358_9 = 2 * var_358_7 * Mathf.Tan(var_358_8.fieldOfView * 0.5 * Mathf.Deg2Rad)
					local var_358_10 = var_358_9 * var_358_8.aspect
					local var_358_11 = var_358_6.sprite.bounds.size.x
					local var_358_12 = var_358_6.sprite.bounds.size.y
					local var_358_13 = var_358_10 / var_358_11
					local var_358_14 = var_358_9 / var_358_12
					local var_358_15 = var_358_14 < var_358_13 and var_358_13 or var_358_14

					var_358_5.transform.localScale = Vector3.New(var_358_15, var_358_15, 0)
				end

				for iter_358_0, iter_358_1 in pairs(arg_355_1.bgs_) do
					if iter_358_0 ~= "STblack" then
						iter_358_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_358_16 = 0

			if var_358_16 < arg_355_1.time_ and arg_355_1.time_ <= var_358_16 + arg_358_0 then
				arg_355_1.mask_.enabled = true
				arg_355_1.mask_.raycastTarget = true

				arg_355_1:SetGaussion(false)
			end

			local var_358_17 = 2

			if var_358_16 <= arg_355_1.time_ and arg_355_1.time_ < var_358_16 + var_358_17 then
				local var_358_18 = (arg_355_1.time_ - var_358_16) / var_358_17
				local var_358_19 = Color.New(0, 0, 0)

				var_358_19.a = Mathf.Lerp(0, 1, var_358_18)
				arg_355_1.mask_.color = var_358_19
			end

			if arg_355_1.time_ >= var_358_16 + var_358_17 and arg_355_1.time_ < var_358_16 + var_358_17 + arg_358_0 then
				local var_358_20 = Color.New(0, 0, 0)

				var_358_20.a = 1
				arg_355_1.mask_.color = var_358_20
			end

			local var_358_21 = 2

			if var_358_21 < arg_355_1.time_ and arg_355_1.time_ <= var_358_21 + arg_358_0 then
				arg_355_1.mask_.enabled = true
				arg_355_1.mask_.raycastTarget = true

				arg_355_1:SetGaussion(false)
			end

			local var_358_22 = 2

			if var_358_21 <= arg_355_1.time_ and arg_355_1.time_ < var_358_21 + var_358_22 then
				local var_358_23 = (arg_355_1.time_ - var_358_21) / var_358_22
				local var_358_24 = Color.New(0, 0, 0)

				var_358_24.a = Mathf.Lerp(1, 0, var_358_23)
				arg_355_1.mask_.color = var_358_24
			end

			if arg_355_1.time_ >= var_358_21 + var_358_22 and arg_355_1.time_ < var_358_21 + var_358_22 + arg_358_0 then
				local var_358_25 = Color.New(0, 0, 0)
				local var_358_26 = 0

				arg_355_1.mask_.enabled = false
				var_358_25.a = var_358_26
				arg_355_1.mask_.color = var_358_25
			end

			local var_358_27 = arg_355_1.actors_["1061"].transform
			local var_358_28 = 2

			if var_358_28 < arg_355_1.time_ and arg_355_1.time_ <= var_358_28 + arg_358_0 then
				arg_355_1.var_.moveOldPos1061 = var_358_27.localPosition
				var_358_27.localScale = Vector3.New(1, 1, 1)

				arg_355_1:CheckSpriteTmpPos("1061", 7)

				local var_358_29 = var_358_27.childCount

				for iter_358_2 = 0, var_358_29 - 1 do
					local var_358_30 = var_358_27:GetChild(iter_358_2)

					if var_358_30.name == "" or not string.find(var_358_30.name, "split") then
						var_358_30.gameObject:SetActive(true)
					else
						var_358_30.gameObject:SetActive(false)
					end
				end
			end

			local var_358_31 = 0.001

			if var_358_28 <= arg_355_1.time_ and arg_355_1.time_ < var_358_28 + var_358_31 then
				local var_358_32 = (arg_355_1.time_ - var_358_28) / var_358_31
				local var_358_33 = Vector3.New(0, -2000, 18)

				var_358_27.localPosition = Vector3.Lerp(arg_355_1.var_.moveOldPos1061, var_358_33, var_358_32)
			end

			if arg_355_1.time_ >= var_358_28 + var_358_31 and arg_355_1.time_ < var_358_28 + var_358_31 + arg_358_0 then
				var_358_27.localPosition = Vector3.New(0, -2000, 18)
			end

			local var_358_34 = arg_355_1.actors_["1061"]
			local var_358_35 = 2

			if var_358_35 < arg_355_1.time_ and arg_355_1.time_ <= var_358_35 + arg_358_0 and not isNil(var_358_34) and arg_355_1.var_.actorSpriteComps1061 == nil then
				arg_355_1.var_.actorSpriteComps1061 = var_358_34:GetComponentsInChildren(typeof(Image), true)
			end

			local var_358_36 = 0.034

			if var_358_35 <= arg_355_1.time_ and arg_355_1.time_ < var_358_35 + var_358_36 and not isNil(var_358_34) then
				local var_358_37 = (arg_355_1.time_ - var_358_35) / var_358_36

				if arg_355_1.var_.actorSpriteComps1061 then
					for iter_358_3, iter_358_4 in pairs(arg_355_1.var_.actorSpriteComps1061:ToTable()) do
						if iter_358_4 then
							if arg_355_1.isInRecall_ then
								local var_358_38 = Mathf.Lerp(iter_358_4.color.r, arg_355_1.hightColor2.r, var_358_37)
								local var_358_39 = Mathf.Lerp(iter_358_4.color.g, arg_355_1.hightColor2.g, var_358_37)
								local var_358_40 = Mathf.Lerp(iter_358_4.color.b, arg_355_1.hightColor2.b, var_358_37)

								iter_358_4.color = Color.New(var_358_38, var_358_39, var_358_40)
							else
								local var_358_41 = Mathf.Lerp(iter_358_4.color.r, 0.5, var_358_37)

								iter_358_4.color = Color.New(var_358_41, var_358_41, var_358_41)
							end
						end
					end
				end
			end

			if arg_355_1.time_ >= var_358_35 + var_358_36 and arg_355_1.time_ < var_358_35 + var_358_36 + arg_358_0 and not isNil(var_358_34) and arg_355_1.var_.actorSpriteComps1061 then
				for iter_358_5, iter_358_6 in pairs(arg_355_1.var_.actorSpriteComps1061:ToTable()) do
					if iter_358_6 then
						if arg_355_1.isInRecall_ then
							iter_358_6.color = arg_355_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_358_6.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_355_1.var_.actorSpriteComps1061 = nil
			end

			local var_358_42 = 2

			if var_358_42 < arg_355_1.time_ and arg_355_1.time_ <= var_358_42 + arg_358_0 then
				arg_355_1.fswbg_:SetActive(true)
				arg_355_1.dialog_:SetActive(false)

				arg_355_1.fswtw_.percent = 0

				local var_358_43 = arg_355_1:GetWordFromCfg(410142087)
				local var_358_44 = arg_355_1:FormatText(var_358_43.content)

				arg_355_1.fswt_.text = var_358_44

				LuaForUtil.ClearLinePrefixSymbol(arg_355_1.fswt_)

				arg_355_1.fswt_:GetComponent("Text").color = Color(1, 1, 1)
				arg_355_1.fswbg_.transform:Find("textbox/bg"):GetComponent("Image").enabled = false

				arg_355_1.fswtw_:SetDirty()

				arg_355_1.typewritterCharCountI18N = 0

				SetActive(arg_355_1.fswtw_.transform.parent.parent:Find("bg/line").gameObject, false)
				arg_355_1:ShowNextGo(false)
			end

			local var_358_45 = 4

			if var_358_45 < arg_355_1.time_ and arg_355_1.time_ <= var_358_45 + arg_358_0 then
				arg_355_1.var_.oldValueTypewriter = arg_355_1.fswtw_.percent

				SetActive(arg_355_1.fswtw_.transform.parent.parent:Find("bg/line").gameObject, false)
				arg_355_1:ShowNextGo(false)
			end

			local var_358_46 = 3
			local var_358_47 = 0.2
			local var_358_48 = arg_355_1:GetWordFromCfg(410142087)
			local var_358_49 = arg_355_1:FormatText(var_358_48.content)
			local var_358_50, var_358_51 = arg_355_1:GetPercentByPara(var_358_49, 1)

			if var_358_45 < arg_355_1.time_ and arg_355_1.time_ <= var_358_45 + arg_358_0 then
				arg_355_1.talkMaxDuration = 0

				local var_358_52 = var_358_46 <= 0 and var_358_47 or var_358_47 * ((var_358_51 - arg_355_1.typewritterCharCountI18N) / var_358_46)

				if var_358_52 > 0 and var_358_47 < var_358_52 then
					arg_355_1.talkMaxDuration = var_358_52

					if var_358_52 + var_358_45 > arg_355_1.duration_ then
						arg_355_1.duration_ = var_358_52 + var_358_45
					end
				end
			end

			local var_358_53 = 0.2
			local var_358_54 = math.max(var_358_53, arg_355_1.talkMaxDuration)

			if var_358_45 <= arg_355_1.time_ and arg_355_1.time_ < var_358_45 + var_358_54 then
				local var_358_55 = (arg_355_1.time_ - var_358_45) / var_358_54

				arg_355_1.fswtw_.percent = Mathf.Lerp(arg_355_1.var_.oldValueTypewriter, var_358_50, var_358_55)
				arg_355_1.fswt_:GetComponent("Text").color = Color(1, 1, 1)

				arg_355_1.fswtw_:SetDirty()
			end

			if arg_355_1.time_ >= var_358_45 + var_358_54 and arg_355_1.time_ < var_358_45 + var_358_54 + arg_358_0 then
				arg_355_1.fswtw_.percent = var_358_50

				arg_355_1.fswtw_:SetDirty()
				arg_355_1:ShowNextGo(true)

				arg_355_1.typewritterCharCountI18N = var_358_51
			end

			local var_358_56 = 4

			if var_358_56 < arg_355_1.time_ and arg_355_1.time_ <= var_358_56 + arg_358_0 then
				local var_358_57 = arg_355_1.fswbg_.transform:Find("textbox/adapt/content") or arg_355_1.fswbg_.transform:Find("textbox/content")
				local var_358_58 = arg_355_1.fswbg_.transform:Find("textbox/bg"):GetComponent("Image")
				local var_358_59 = var_358_57:GetComponent("Text")
				local var_358_60 = var_358_57:GetComponent("RectTransform")

				var_358_59.alignment = UnityEngine.TextAnchor.MiddleCenter
				var_358_60.offsetMin = Vector2.New(0, 0)
				var_358_60.offsetMax = Vector2.New(0, 0)
			end
		end

		arg_355_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1061",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 2,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_355_1:InitPlayNodeList()
	end,
	Play410142088 = function(arg_359_0, arg_359_1)
		arg_359_1.time_ = 0
		arg_359_1.frameCnt_ = 0
		arg_359_1.state_ = "playing"
		arg_359_1.curTalkId_ = 410142088
		arg_359_1.duration_ = 9.83

		local var_359_0 = {
			ja = 9.833,
			CriLanguages = 5.3,
			zh = 5.3
		}
		local var_359_1 = manager.audio:GetLocalizationFlag()

		if var_359_0[var_359_1] ~= nil then
			arg_359_1.duration_ = var_359_0[var_359_1]
		end

		SetActive(arg_359_1.tipsGo_, false)

		function arg_359_1.onSingleLineFinish_()
			arg_359_1.onSingleLineUpdate_ = nil
			arg_359_1.onSingleLineFinish_ = nil
			arg_359_1.state_ = "waiting"
		end

		function arg_359_1.playNext_(arg_361_0)
			if arg_361_0 == 1 then
				arg_359_0:Play410142089(arg_359_1)
			end
		end

		function arg_359_1.onSingleLineUpdate_(arg_362_0)
			local var_362_0 = "L01f"

			if arg_359_1.bgs_[var_362_0] == nil then
				local var_362_1 = Object.Instantiate(arg_359_1.paintGo_)

				var_362_1:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. var_362_0)
				var_362_1.name = var_362_0
				var_362_1.transform.parent = arg_359_1.stage_.transform
				var_362_1.transform.localPosition = Vector3.New(0, 100, 0)
				arg_359_1.bgs_[var_362_0] = var_362_1
			end

			local var_362_2 = 2

			if var_362_2 < arg_359_1.time_ and arg_359_1.time_ <= var_362_2 + arg_362_0 then
				local var_362_3 = manager.ui.mainCamera.transform.localPosition
				local var_362_4 = Vector3.New(0, 0, 10) + Vector3.New(var_362_3.x, var_362_3.y, 0)
				local var_362_5 = arg_359_1.bgs_.L01f

				var_362_5.transform.localPosition = var_362_4
				var_362_5.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_362_6 = var_362_5:GetComponent("SpriteRenderer")

				if var_362_6 and var_362_6.sprite then
					local var_362_7 = (var_362_5.transform.localPosition - var_362_3).z
					local var_362_8 = manager.ui.mainCameraCom_
					local var_362_9 = 2 * var_362_7 * Mathf.Tan(var_362_8.fieldOfView * 0.5 * Mathf.Deg2Rad)
					local var_362_10 = var_362_9 * var_362_8.aspect
					local var_362_11 = var_362_6.sprite.bounds.size.x
					local var_362_12 = var_362_6.sprite.bounds.size.y
					local var_362_13 = var_362_10 / var_362_11
					local var_362_14 = var_362_9 / var_362_12
					local var_362_15 = var_362_14 < var_362_13 and var_362_13 or var_362_14

					var_362_5.transform.localScale = Vector3.New(var_362_15, var_362_15, 0)
				end

				for iter_362_0, iter_362_1 in pairs(arg_359_1.bgs_) do
					if iter_362_0 ~= "L01f" then
						iter_362_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_362_16 = 0

			if var_362_16 < arg_359_1.time_ and arg_359_1.time_ <= var_362_16 + arg_362_0 then
				arg_359_1.mask_.enabled = true
				arg_359_1.mask_.raycastTarget = true

				arg_359_1:SetGaussion(false)
			end

			local var_362_17 = 2

			if var_362_16 <= arg_359_1.time_ and arg_359_1.time_ < var_362_16 + var_362_17 then
				local var_362_18 = (arg_359_1.time_ - var_362_16) / var_362_17
				local var_362_19 = Color.New(0, 0, 0)

				var_362_19.a = Mathf.Lerp(0, 1, var_362_18)
				arg_359_1.mask_.color = var_362_19
			end

			if arg_359_1.time_ >= var_362_16 + var_362_17 and arg_359_1.time_ < var_362_16 + var_362_17 + arg_362_0 then
				local var_362_20 = Color.New(0, 0, 0)

				var_362_20.a = 1
				arg_359_1.mask_.color = var_362_20
			end

			local var_362_21 = 2

			if var_362_21 < arg_359_1.time_ and arg_359_1.time_ <= var_362_21 + arg_362_0 then
				arg_359_1.mask_.enabled = true
				arg_359_1.mask_.raycastTarget = true

				arg_359_1:SetGaussion(false)
			end

			local var_362_22 = 2

			if var_362_21 <= arg_359_1.time_ and arg_359_1.time_ < var_362_21 + var_362_22 then
				local var_362_23 = (arg_359_1.time_ - var_362_21) / var_362_22
				local var_362_24 = Color.New(0, 0, 0)

				var_362_24.a = Mathf.Lerp(1, 0, var_362_23)
				arg_359_1.mask_.color = var_362_24
			end

			if arg_359_1.time_ >= var_362_21 + var_362_22 and arg_359_1.time_ < var_362_21 + var_362_22 + arg_362_0 then
				local var_362_25 = Color.New(0, 0, 0)
				local var_362_26 = 0

				arg_359_1.mask_.enabled = false
				var_362_25.a = var_362_26
				arg_359_1.mask_.color = var_362_25
			end

			local var_362_27 = arg_359_1.actors_["1056"].transform
			local var_362_28 = 4

			if var_362_28 < arg_359_1.time_ and arg_359_1.time_ <= var_362_28 + arg_362_0 then
				arg_359_1.var_.moveOldPos1056 = var_362_27.localPosition
				var_362_27.localScale = Vector3.New(1, 1, 1)

				arg_359_1:CheckSpriteTmpPos("1056", 4)

				local var_362_29 = var_362_27.childCount

				for iter_362_2 = 0, var_362_29 - 1 do
					local var_362_30 = var_362_27:GetChild(iter_362_2)

					if var_362_30.name == "split_4" or not string.find(var_362_30.name, "split") then
						var_362_30.gameObject:SetActive(true)
					else
						var_362_30.gameObject:SetActive(false)
					end
				end
			end

			local var_362_31 = 0.001

			if var_362_28 <= arg_359_1.time_ and arg_359_1.time_ < var_362_28 + var_362_31 then
				local var_362_32 = (arg_359_1.time_ - var_362_28) / var_362_31
				local var_362_33 = Vector3.New(390, -350, -180)

				var_362_27.localPosition = Vector3.Lerp(arg_359_1.var_.moveOldPos1056, var_362_33, var_362_32)
			end

			if arg_359_1.time_ >= var_362_28 + var_362_31 and arg_359_1.time_ < var_362_28 + var_362_31 + arg_362_0 then
				var_362_27.localPosition = Vector3.New(390, -350, -180)
			end

			local var_362_34 = arg_359_1.actors_["1061"].transform
			local var_362_35 = 4

			if var_362_35 < arg_359_1.time_ and arg_359_1.time_ <= var_362_35 + arg_362_0 then
				arg_359_1.var_.moveOldPos1061 = var_362_34.localPosition
				var_362_34.localScale = Vector3.New(1, 1, 1)

				arg_359_1:CheckSpriteTmpPos("1061", 2)

				local var_362_36 = var_362_34.childCount

				for iter_362_3 = 0, var_362_36 - 1 do
					local var_362_37 = var_362_34:GetChild(iter_362_3)

					if var_362_37.name == "" or not string.find(var_362_37.name, "split") then
						var_362_37.gameObject:SetActive(true)
					else
						var_362_37.gameObject:SetActive(false)
					end
				end
			end

			local var_362_38 = 0.001

			if var_362_35 <= arg_359_1.time_ and arg_359_1.time_ < var_362_35 + var_362_38 then
				local var_362_39 = (arg_359_1.time_ - var_362_35) / var_362_38
				local var_362_40 = Vector3.New(-390, -490, 18)

				var_362_34.localPosition = Vector3.Lerp(arg_359_1.var_.moveOldPos1061, var_362_40, var_362_39)
			end

			if arg_359_1.time_ >= var_362_35 + var_362_38 and arg_359_1.time_ < var_362_35 + var_362_38 + arg_362_0 then
				var_362_34.localPosition = Vector3.New(-390, -490, 18)
			end

			local var_362_41 = arg_359_1.actors_["1056"]
			local var_362_42 = 4

			if var_362_42 < arg_359_1.time_ and arg_359_1.time_ <= var_362_42 + arg_362_0 and not isNil(var_362_41) and arg_359_1.var_.actorSpriteComps1056 == nil then
				arg_359_1.var_.actorSpriteComps1056 = var_362_41:GetComponentsInChildren(typeof(Image), true)
			end

			local var_362_43 = 0.034

			if var_362_42 <= arg_359_1.time_ and arg_359_1.time_ < var_362_42 + var_362_43 and not isNil(var_362_41) then
				local var_362_44 = (arg_359_1.time_ - var_362_42) / var_362_43

				if arg_359_1.var_.actorSpriteComps1056 then
					for iter_362_4, iter_362_5 in pairs(arg_359_1.var_.actorSpriteComps1056:ToTable()) do
						if iter_362_5 then
							if arg_359_1.isInRecall_ then
								local var_362_45 = Mathf.Lerp(iter_362_5.color.r, arg_359_1.hightColor1.r, var_362_44)
								local var_362_46 = Mathf.Lerp(iter_362_5.color.g, arg_359_1.hightColor1.g, var_362_44)
								local var_362_47 = Mathf.Lerp(iter_362_5.color.b, arg_359_1.hightColor1.b, var_362_44)

								iter_362_5.color = Color.New(var_362_45, var_362_46, var_362_47)
							else
								local var_362_48 = Mathf.Lerp(iter_362_5.color.r, 1, var_362_44)

								iter_362_5.color = Color.New(var_362_48, var_362_48, var_362_48)
							end
						end
					end
				end
			end

			if arg_359_1.time_ >= var_362_42 + var_362_43 and arg_359_1.time_ < var_362_42 + var_362_43 + arg_362_0 and not isNil(var_362_41) and arg_359_1.var_.actorSpriteComps1056 then
				for iter_362_6, iter_362_7 in pairs(arg_359_1.var_.actorSpriteComps1056:ToTable()) do
					if iter_362_7 then
						if arg_359_1.isInRecall_ then
							iter_362_7.color = arg_359_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_362_7.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_359_1.var_.actorSpriteComps1056 = nil
			end

			local var_362_49 = arg_359_1.actors_["1061"]
			local var_362_50 = 4

			if var_362_50 < arg_359_1.time_ and arg_359_1.time_ <= var_362_50 + arg_362_0 and not isNil(var_362_49) and arg_359_1.var_.actorSpriteComps1061 == nil then
				arg_359_1.var_.actorSpriteComps1061 = var_362_49:GetComponentsInChildren(typeof(Image), true)
			end

			local var_362_51 = 0.034

			if var_362_50 <= arg_359_1.time_ and arg_359_1.time_ < var_362_50 + var_362_51 and not isNil(var_362_49) then
				local var_362_52 = (arg_359_1.time_ - var_362_50) / var_362_51

				if arg_359_1.var_.actorSpriteComps1061 then
					for iter_362_8, iter_362_9 in pairs(arg_359_1.var_.actorSpriteComps1061:ToTable()) do
						if iter_362_9 then
							if arg_359_1.isInRecall_ then
								local var_362_53 = Mathf.Lerp(iter_362_9.color.r, arg_359_1.hightColor2.r, var_362_52)
								local var_362_54 = Mathf.Lerp(iter_362_9.color.g, arg_359_1.hightColor2.g, var_362_52)
								local var_362_55 = Mathf.Lerp(iter_362_9.color.b, arg_359_1.hightColor2.b, var_362_52)

								iter_362_9.color = Color.New(var_362_53, var_362_54, var_362_55)
							else
								local var_362_56 = Mathf.Lerp(iter_362_9.color.r, 0.5, var_362_52)

								iter_362_9.color = Color.New(var_362_56, var_362_56, var_362_56)
							end
						end
					end
				end
			end

			if arg_359_1.time_ >= var_362_50 + var_362_51 and arg_359_1.time_ < var_362_50 + var_362_51 + arg_362_0 and not isNil(var_362_49) and arg_359_1.var_.actorSpriteComps1061 then
				for iter_362_10, iter_362_11 in pairs(arg_359_1.var_.actorSpriteComps1061:ToTable()) do
					if iter_362_11 then
						if arg_359_1.isInRecall_ then
							iter_362_11.color = arg_359_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_362_11.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_359_1.var_.actorSpriteComps1061 = nil
			end

			local var_362_57 = 2

			if var_362_57 < arg_359_1.time_ and arg_359_1.time_ <= var_362_57 + arg_362_0 then
				arg_359_1.fswbg_:SetActive(false)
				arg_359_1.dialog_:SetActive(false)
				SetActive(arg_359_1.fswtw_.transform.parent.parent:Find("bg/line").gameObject, false)
				arg_359_1:ShowNextGo(false)
			end

			if arg_359_1.frameCnt_ <= 1 then
				arg_359_1.dialog_:SetActive(false)
			end

			local var_362_58 = 4
			local var_362_59 = 0.15

			if var_362_58 < arg_359_1.time_ and arg_359_1.time_ <= var_362_58 + arg_362_0 then
				arg_359_1.talkMaxDuration = 0

				arg_359_1.dialog_:SetActive(true)

				arg_359_1.dialogCg_.alpha = 0

				local var_362_60 = LeanTween.value(arg_359_1.dialog_, 0, 1, 0.3)

				var_362_60:setOnUpdate(LuaHelper.FloatAction(function(arg_363_0)
					arg_359_1.dialogCg_.alpha = arg_363_0
				end))
				var_362_60:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_359_1.dialog_)
					var_362_60:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_359_1.duration_ = arg_359_1.duration_ + 0.3

				SetActive(arg_359_1.leftNameGo_, true)

				local var_362_61 = arg_359_1:FormatText(StoryNameCfg[605].name)

				arg_359_1.leftNameTxt_.text = var_362_61

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_359_1.leftNameTxt_.transform)

				arg_359_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_359_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_359_1:RecordName(arg_359_1.leftNameTxt_.text)
				SetActive(arg_359_1.iconTrs_.gameObject, false)
				arg_359_1.callingController_:SetSelectedState("normal")

				local var_362_62 = arg_359_1:GetWordFromCfg(410142088)
				local var_362_63 = arg_359_1:FormatText(var_362_62.content)

				arg_359_1.text_.text = var_362_63

				LuaForUtil.ClearLinePrefixSymbol(arg_359_1.text_)

				local var_362_64 = 6
				local var_362_65 = utf8.len(var_362_63)
				local var_362_66 = var_362_64 <= 0 and var_362_59 or var_362_59 * (var_362_65 / var_362_64)

				if var_362_66 > 0 and var_362_59 < var_362_66 then
					arg_359_1.talkMaxDuration = var_362_66
					var_362_58 = var_362_58 + 0.3

					if var_362_66 + var_362_58 > arg_359_1.duration_ then
						arg_359_1.duration_ = var_362_66 + var_362_58
					end
				end

				arg_359_1.text_.text = var_362_63
				arg_359_1.typewritter.percent = 0

				arg_359_1.typewritter:SetDirty()
				arg_359_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_410142", "410142088", "story_v_out_410142.awb") ~= 0 then
					local var_362_67 = manager.audio:GetVoiceLength("story_v_out_410142", "410142088", "story_v_out_410142.awb") / 1000

					if var_362_67 + var_362_58 > arg_359_1.duration_ then
						arg_359_1.duration_ = var_362_67 + var_362_58
					end

					if var_362_62.prefab_name ~= "" and arg_359_1.actors_[var_362_62.prefab_name] ~= nil then
						local var_362_68 = LuaForUtil.PlayVoiceWithCriLipsync(arg_359_1.actors_[var_362_62.prefab_name].transform, "story_v_out_410142", "410142088", "story_v_out_410142.awb")

						arg_359_1:RecordAudio("410142088", var_362_68)
						arg_359_1:RecordAudio("410142088", var_362_68)
					else
						arg_359_1:AudioAction("play", "voice", "story_v_out_410142", "410142088", "story_v_out_410142.awb")
					end

					arg_359_1:RecordHistoryTalkVoice("story_v_out_410142", "410142088", "story_v_out_410142.awb")
				end

				arg_359_1:RecordContent(arg_359_1.text_.text)
			end

			local var_362_69 = var_362_58 + 0.3
			local var_362_70 = math.max(var_362_59, arg_359_1.talkMaxDuration)

			if var_362_69 <= arg_359_1.time_ and arg_359_1.time_ < var_362_69 + var_362_70 then
				arg_359_1.typewritter.percent = (arg_359_1.time_ - var_362_69) / var_362_70

				arg_359_1.typewritter:SetDirty()
			end

			if arg_359_1.time_ >= var_362_69 + var_362_70 and arg_359_1.time_ < var_362_69 + var_362_70 + arg_362_0 then
				arg_359_1.typewritter.percent = 1

				arg_359_1.typewritter:SetDirty()
				arg_359_1:ShowNextGo(true)
			end
		end

		arg_359_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1056",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.0339999999999998,
				className = "StoryMoveNode",
				startTime = 4,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			},
			{
				assetPath = "",
				actorName = "1061",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 4,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_359_1:InitPlayNodeList()
	end,
	Play410142089 = function(arg_365_0, arg_365_1)
		arg_365_1.time_ = 0
		arg_365_1.frameCnt_ = 0
		arg_365_1.state_ = "playing"
		arg_365_1.curTalkId_ = 410142089
		arg_365_1.duration_ = 5.33

		local var_365_0 = {
			ja = 5.333,
			CriLanguages = 5,
			zh = 5
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
				arg_365_0:Play410142090(arg_365_1)
			end
		end

		function arg_365_1.onSingleLineUpdate_(arg_368_0)
			local var_368_0 = arg_365_1.actors_["1061"].transform
			local var_368_1 = 0

			if var_368_1 < arg_365_1.time_ and arg_365_1.time_ <= var_368_1 + arg_368_0 then
				arg_365_1.var_.moveOldPos1061 = var_368_0.localPosition
				var_368_0.localScale = Vector3.New(1, 1, 1)

				arg_365_1:CheckSpriteTmpPos("1061", 2)

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
				local var_368_6 = Vector3.New(-390, -490, 18)

				var_368_0.localPosition = Vector3.Lerp(arg_365_1.var_.moveOldPos1061, var_368_6, var_368_5)
			end

			if arg_365_1.time_ >= var_368_1 + var_368_4 and arg_365_1.time_ < var_368_1 + var_368_4 + arg_368_0 then
				var_368_0.localPosition = Vector3.New(-390, -490, 18)
			end

			local var_368_7 = arg_365_1.actors_["1061"]
			local var_368_8 = 0

			if var_368_8 < arg_365_1.time_ and arg_365_1.time_ <= var_368_8 + arg_368_0 and not isNil(var_368_7) and arg_365_1.var_.actorSpriteComps1061 == nil then
				arg_365_1.var_.actorSpriteComps1061 = var_368_7:GetComponentsInChildren(typeof(Image), true)
			end

			local var_368_9 = 0.034

			if var_368_8 <= arg_365_1.time_ and arg_365_1.time_ < var_368_8 + var_368_9 and not isNil(var_368_7) then
				local var_368_10 = (arg_365_1.time_ - var_368_8) / var_368_9

				if arg_365_1.var_.actorSpriteComps1061 then
					for iter_368_1, iter_368_2 in pairs(arg_365_1.var_.actorSpriteComps1061:ToTable()) do
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

			if arg_365_1.time_ >= var_368_8 + var_368_9 and arg_365_1.time_ < var_368_8 + var_368_9 + arg_368_0 and not isNil(var_368_7) and arg_365_1.var_.actorSpriteComps1061 then
				for iter_368_3, iter_368_4 in pairs(arg_365_1.var_.actorSpriteComps1061:ToTable()) do
					if iter_368_4 then
						if arg_365_1.isInRecall_ then
							iter_368_4.color = arg_365_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_368_4.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_365_1.var_.actorSpriteComps1061 = nil
			end

			local var_368_15 = arg_365_1.actors_["1056"]
			local var_368_16 = 0

			if var_368_16 < arg_365_1.time_ and arg_365_1.time_ <= var_368_16 + arg_368_0 and not isNil(var_368_15) and arg_365_1.var_.actorSpriteComps1056 == nil then
				arg_365_1.var_.actorSpriteComps1056 = var_368_15:GetComponentsInChildren(typeof(Image), true)
			end

			local var_368_17 = 0.034

			if var_368_16 <= arg_365_1.time_ and arg_365_1.time_ < var_368_16 + var_368_17 and not isNil(var_368_15) then
				local var_368_18 = (arg_365_1.time_ - var_368_16) / var_368_17

				if arg_365_1.var_.actorSpriteComps1056 then
					for iter_368_5, iter_368_6 in pairs(arg_365_1.var_.actorSpriteComps1056:ToTable()) do
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

			if arg_365_1.time_ >= var_368_16 + var_368_17 and arg_365_1.time_ < var_368_16 + var_368_17 + arg_368_0 and not isNil(var_368_15) and arg_365_1.var_.actorSpriteComps1056 then
				for iter_368_7, iter_368_8 in pairs(arg_365_1.var_.actorSpriteComps1056:ToTable()) do
					if iter_368_8 then
						if arg_365_1.isInRecall_ then
							iter_368_8.color = arg_365_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_368_8.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_365_1.var_.actorSpriteComps1056 = nil
			end

			local var_368_23 = 0
			local var_368_24 = 0.6

			if var_368_23 < arg_365_1.time_ and arg_365_1.time_ <= var_368_23 + arg_368_0 then
				arg_365_1.talkMaxDuration = 0
				arg_365_1.dialogCg_.alpha = 1

				arg_365_1.dialog_:SetActive(true)
				SetActive(arg_365_1.leftNameGo_, true)

				local var_368_25 = arg_365_1:FormatText(StoryNameCfg[612].name)

				arg_365_1.leftNameTxt_.text = var_368_25

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_365_1.leftNameTxt_.transform)

				arg_365_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_365_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_365_1:RecordName(arg_365_1.leftNameTxt_.text)
				SetActive(arg_365_1.iconTrs_.gameObject, false)
				arg_365_1.callingController_:SetSelectedState("normal")

				local var_368_26 = arg_365_1:GetWordFromCfg(410142089)
				local var_368_27 = arg_365_1:FormatText(var_368_26.content)

				arg_365_1.text_.text = var_368_27

				LuaForUtil.ClearLinePrefixSymbol(arg_365_1.text_)

				local var_368_28 = 24
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

				if manager.audio:GetVoiceLength("story_v_out_410142", "410142089", "story_v_out_410142.awb") ~= 0 then
					local var_368_31 = manager.audio:GetVoiceLength("story_v_out_410142", "410142089", "story_v_out_410142.awb") / 1000

					if var_368_31 + var_368_23 > arg_365_1.duration_ then
						arg_365_1.duration_ = var_368_31 + var_368_23
					end

					if var_368_26.prefab_name ~= "" and arg_365_1.actors_[var_368_26.prefab_name] ~= nil then
						local var_368_32 = LuaForUtil.PlayVoiceWithCriLipsync(arg_365_1.actors_[var_368_26.prefab_name].transform, "story_v_out_410142", "410142089", "story_v_out_410142.awb")

						arg_365_1:RecordAudio("410142089", var_368_32)
						arg_365_1:RecordAudio("410142089", var_368_32)
					else
						arg_365_1:AudioAction("play", "voice", "story_v_out_410142", "410142089", "story_v_out_410142.awb")
					end

					arg_365_1:RecordHistoryTalkVoice("story_v_out_410142", "410142089", "story_v_out_410142.awb")
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
				actorName = "1061",
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
	Play410142090 = function(arg_369_0, arg_369_1)
		arg_369_1.time_ = 0
		arg_369_1.frameCnt_ = 0
		arg_369_1.state_ = "playing"
		arg_369_1.curTalkId_ = 410142090
		arg_369_1.duration_ = 5.87

		local var_369_0 = {
			ja = 5.866,
			CriLanguages = 4.5,
			zh = 4.5
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
				arg_369_0:Play410142091(arg_369_1)
			end
		end

		function arg_369_1.onSingleLineUpdate_(arg_372_0)
			local var_372_0 = arg_369_1.actors_["1056"].transform
			local var_372_1 = 0

			if var_372_1 < arg_369_1.time_ and arg_369_1.time_ <= var_372_1 + arg_372_0 then
				arg_369_1.var_.moveOldPos1056 = var_372_0.localPosition
				var_372_0.localScale = Vector3.New(1, 1, 1)

				arg_369_1:CheckSpriteTmpPos("1056", 4)

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
				local var_372_6 = Vector3.New(390, -350, -180)

				var_372_0.localPosition = Vector3.Lerp(arg_369_1.var_.moveOldPos1056, var_372_6, var_372_5)
			end

			if arg_369_1.time_ >= var_372_1 + var_372_4 and arg_369_1.time_ < var_372_1 + var_372_4 + arg_372_0 then
				var_372_0.localPosition = Vector3.New(390, -350, -180)
			end

			local var_372_7 = arg_369_1.actors_["1056"]
			local var_372_8 = 0

			if var_372_8 < arg_369_1.time_ and arg_369_1.time_ <= var_372_8 + arg_372_0 and not isNil(var_372_7) and arg_369_1.var_.actorSpriteComps1056 == nil then
				arg_369_1.var_.actorSpriteComps1056 = var_372_7:GetComponentsInChildren(typeof(Image), true)
			end

			local var_372_9 = 0.034

			if var_372_8 <= arg_369_1.time_ and arg_369_1.time_ < var_372_8 + var_372_9 and not isNil(var_372_7) then
				local var_372_10 = (arg_369_1.time_ - var_372_8) / var_372_9

				if arg_369_1.var_.actorSpriteComps1056 then
					for iter_372_1, iter_372_2 in pairs(arg_369_1.var_.actorSpriteComps1056:ToTable()) do
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

			if arg_369_1.time_ >= var_372_8 + var_372_9 and arg_369_1.time_ < var_372_8 + var_372_9 + arg_372_0 and not isNil(var_372_7) and arg_369_1.var_.actorSpriteComps1056 then
				for iter_372_3, iter_372_4 in pairs(arg_369_1.var_.actorSpriteComps1056:ToTable()) do
					if iter_372_4 then
						if arg_369_1.isInRecall_ then
							iter_372_4.color = arg_369_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_372_4.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_369_1.var_.actorSpriteComps1056 = nil
			end

			local var_372_15 = arg_369_1.actors_["1061"]
			local var_372_16 = 0

			if var_372_16 < arg_369_1.time_ and arg_369_1.time_ <= var_372_16 + arg_372_0 and not isNil(var_372_15) and arg_369_1.var_.actorSpriteComps1061 == nil then
				arg_369_1.var_.actorSpriteComps1061 = var_372_15:GetComponentsInChildren(typeof(Image), true)
			end

			local var_372_17 = 0.034

			if var_372_16 <= arg_369_1.time_ and arg_369_1.time_ < var_372_16 + var_372_17 and not isNil(var_372_15) then
				local var_372_18 = (arg_369_1.time_ - var_372_16) / var_372_17

				if arg_369_1.var_.actorSpriteComps1061 then
					for iter_372_5, iter_372_6 in pairs(arg_369_1.var_.actorSpriteComps1061:ToTable()) do
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

			if arg_369_1.time_ >= var_372_16 + var_372_17 and arg_369_1.time_ < var_372_16 + var_372_17 + arg_372_0 and not isNil(var_372_15) and arg_369_1.var_.actorSpriteComps1061 then
				for iter_372_7, iter_372_8 in pairs(arg_369_1.var_.actorSpriteComps1061:ToTable()) do
					if iter_372_8 then
						if arg_369_1.isInRecall_ then
							iter_372_8.color = arg_369_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_372_8.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_369_1.var_.actorSpriteComps1061 = nil
			end

			local var_372_23 = 0
			local var_372_24 = 0.6

			if var_372_23 < arg_369_1.time_ and arg_369_1.time_ <= var_372_23 + arg_372_0 then
				arg_369_1.talkMaxDuration = 0
				arg_369_1.dialogCg_.alpha = 1

				arg_369_1.dialog_:SetActive(true)
				SetActive(arg_369_1.leftNameGo_, true)

				local var_372_25 = arg_369_1:FormatText(StoryNameCfg[605].name)

				arg_369_1.leftNameTxt_.text = var_372_25

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_369_1.leftNameTxt_.transform)

				arg_369_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_369_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_369_1:RecordName(arg_369_1.leftNameTxt_.text)
				SetActive(arg_369_1.iconTrs_.gameObject, false)
				arg_369_1.callingController_:SetSelectedState("normal")

				local var_372_26 = arg_369_1:GetWordFromCfg(410142090)
				local var_372_27 = arg_369_1:FormatText(var_372_26.content)

				arg_369_1.text_.text = var_372_27

				LuaForUtil.ClearLinePrefixSymbol(arg_369_1.text_)

				local var_372_28 = 24
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

				if manager.audio:GetVoiceLength("story_v_out_410142", "410142090", "story_v_out_410142.awb") ~= 0 then
					local var_372_31 = manager.audio:GetVoiceLength("story_v_out_410142", "410142090", "story_v_out_410142.awb") / 1000

					if var_372_31 + var_372_23 > arg_369_1.duration_ then
						arg_369_1.duration_ = var_372_31 + var_372_23
					end

					if var_372_26.prefab_name ~= "" and arg_369_1.actors_[var_372_26.prefab_name] ~= nil then
						local var_372_32 = LuaForUtil.PlayVoiceWithCriLipsync(arg_369_1.actors_[var_372_26.prefab_name].transform, "story_v_out_410142", "410142090", "story_v_out_410142.awb")

						arg_369_1:RecordAudio("410142090", var_372_32)
						arg_369_1:RecordAudio("410142090", var_372_32)
					else
						arg_369_1:AudioAction("play", "voice", "story_v_out_410142", "410142090", "story_v_out_410142.awb")
					end

					arg_369_1:RecordHistoryTalkVoice("story_v_out_410142", "410142090", "story_v_out_410142.awb")
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
				actorName = "1056",
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
	Play410142091 = function(arg_373_0, arg_373_1)
		arg_373_1.time_ = 0
		arg_373_1.frameCnt_ = 0
		arg_373_1.state_ = "playing"
		arg_373_1.curTalkId_ = 410142091
		arg_373_1.duration_ = 5.4

		local var_373_0 = {
			ja = 5.4,
			CriLanguages = 2.566,
			zh = 2.566
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
				arg_373_0:Play410142092(arg_373_1)
			end
		end

		function arg_373_1.onSingleLineUpdate_(arg_376_0)
			local var_376_0 = arg_373_1.actors_["1061"].transform
			local var_376_1 = 0

			if var_376_1 < arg_373_1.time_ and arg_373_1.time_ <= var_376_1 + arg_376_0 then
				arg_373_1.var_.moveOldPos1061 = var_376_0.localPosition
				var_376_0.localScale = Vector3.New(1, 1, 1)

				arg_373_1:CheckSpriteTmpPos("1061", 2)

				local var_376_2 = var_376_0.childCount

				for iter_376_0 = 0, var_376_2 - 1 do
					local var_376_3 = var_376_0:GetChild(iter_376_0)

					if var_376_3.name == "" or not string.find(var_376_3.name, "split") then
						var_376_3.gameObject:SetActive(true)
					else
						var_376_3.gameObject:SetActive(false)
					end
				end
			end

			local var_376_4 = 0.001

			if var_376_1 <= arg_373_1.time_ and arg_373_1.time_ < var_376_1 + var_376_4 then
				local var_376_5 = (arg_373_1.time_ - var_376_1) / var_376_4
				local var_376_6 = Vector3.New(-390, -490, 18)

				var_376_0.localPosition = Vector3.Lerp(arg_373_1.var_.moveOldPos1061, var_376_6, var_376_5)
			end

			if arg_373_1.time_ >= var_376_1 + var_376_4 and arg_373_1.time_ < var_376_1 + var_376_4 + arg_376_0 then
				var_376_0.localPosition = Vector3.New(-390, -490, 18)
			end

			local var_376_7 = arg_373_1.actors_["1061"]
			local var_376_8 = 0

			if var_376_8 < arg_373_1.time_ and arg_373_1.time_ <= var_376_8 + arg_376_0 and not isNil(var_376_7) and arg_373_1.var_.actorSpriteComps1061 == nil then
				arg_373_1.var_.actorSpriteComps1061 = var_376_7:GetComponentsInChildren(typeof(Image), true)
			end

			local var_376_9 = 0.034

			if var_376_8 <= arg_373_1.time_ and arg_373_1.time_ < var_376_8 + var_376_9 and not isNil(var_376_7) then
				local var_376_10 = (arg_373_1.time_ - var_376_8) / var_376_9

				if arg_373_1.var_.actorSpriteComps1061 then
					for iter_376_1, iter_376_2 in pairs(arg_373_1.var_.actorSpriteComps1061:ToTable()) do
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

			if arg_373_1.time_ >= var_376_8 + var_376_9 and arg_373_1.time_ < var_376_8 + var_376_9 + arg_376_0 and not isNil(var_376_7) and arg_373_1.var_.actorSpriteComps1061 then
				for iter_376_3, iter_376_4 in pairs(arg_373_1.var_.actorSpriteComps1061:ToTable()) do
					if iter_376_4 then
						if arg_373_1.isInRecall_ then
							iter_376_4.color = arg_373_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_376_4.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_373_1.var_.actorSpriteComps1061 = nil
			end

			local var_376_15 = arg_373_1.actors_["1056"]
			local var_376_16 = 0

			if var_376_16 < arg_373_1.time_ and arg_373_1.time_ <= var_376_16 + arg_376_0 and not isNil(var_376_15) and arg_373_1.var_.actorSpriteComps1056 == nil then
				arg_373_1.var_.actorSpriteComps1056 = var_376_15:GetComponentsInChildren(typeof(Image), true)
			end

			local var_376_17 = 0.034

			if var_376_16 <= arg_373_1.time_ and arg_373_1.time_ < var_376_16 + var_376_17 and not isNil(var_376_15) then
				local var_376_18 = (arg_373_1.time_ - var_376_16) / var_376_17

				if arg_373_1.var_.actorSpriteComps1056 then
					for iter_376_5, iter_376_6 in pairs(arg_373_1.var_.actorSpriteComps1056:ToTable()) do
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

			if arg_373_1.time_ >= var_376_16 + var_376_17 and arg_373_1.time_ < var_376_16 + var_376_17 + arg_376_0 and not isNil(var_376_15) and arg_373_1.var_.actorSpriteComps1056 then
				for iter_376_7, iter_376_8 in pairs(arg_373_1.var_.actorSpriteComps1056:ToTable()) do
					if iter_376_8 then
						if arg_373_1.isInRecall_ then
							iter_376_8.color = arg_373_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_376_8.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_373_1.var_.actorSpriteComps1056 = nil
			end

			local var_376_23 = 0
			local var_376_24 = 0.35

			if var_376_23 < arg_373_1.time_ and arg_373_1.time_ <= var_376_23 + arg_376_0 then
				arg_373_1.talkMaxDuration = 0
				arg_373_1.dialogCg_.alpha = 1

				arg_373_1.dialog_:SetActive(true)
				SetActive(arg_373_1.leftNameGo_, true)

				local var_376_25 = arg_373_1:FormatText(StoryNameCfg[612].name)

				arg_373_1.leftNameTxt_.text = var_376_25

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_373_1.leftNameTxt_.transform)

				arg_373_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_373_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_373_1:RecordName(arg_373_1.leftNameTxt_.text)
				SetActive(arg_373_1.iconTrs_.gameObject, false)
				arg_373_1.callingController_:SetSelectedState("normal")

				local var_376_26 = arg_373_1:GetWordFromCfg(410142091)
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

				if manager.audio:GetVoiceLength("story_v_out_410142", "410142091", "story_v_out_410142.awb") ~= 0 then
					local var_376_31 = manager.audio:GetVoiceLength("story_v_out_410142", "410142091", "story_v_out_410142.awb") / 1000

					if var_376_31 + var_376_23 > arg_373_1.duration_ then
						arg_373_1.duration_ = var_376_31 + var_376_23
					end

					if var_376_26.prefab_name ~= "" and arg_373_1.actors_[var_376_26.prefab_name] ~= nil then
						local var_376_32 = LuaForUtil.PlayVoiceWithCriLipsync(arg_373_1.actors_[var_376_26.prefab_name].transform, "story_v_out_410142", "410142091", "story_v_out_410142.awb")

						arg_373_1:RecordAudio("410142091", var_376_32)
						arg_373_1:RecordAudio("410142091", var_376_32)
					else
						arg_373_1:AudioAction("play", "voice", "story_v_out_410142", "410142091", "story_v_out_410142.awb")
					end

					arg_373_1:RecordHistoryTalkVoice("story_v_out_410142", "410142091", "story_v_out_410142.awb")
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
				actorName = "1061",
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
	Play410142092 = function(arg_377_0, arg_377_1)
		arg_377_1.time_ = 0
		arg_377_1.frameCnt_ = 0
		arg_377_1.state_ = "playing"
		arg_377_1.curTalkId_ = 410142092
		arg_377_1.duration_ = 9.3

		local var_377_0 = {
			ja = 7.266,
			CriLanguages = 9.3,
			zh = 9.3
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
				arg_377_0:Play410142093(arg_377_1)
			end
		end

		function arg_377_1.onSingleLineUpdate_(arg_380_0)
			local var_380_0 = arg_377_1.actors_["1061"].transform
			local var_380_1 = 0

			if var_380_1 < arg_377_1.time_ and arg_377_1.time_ <= var_380_1 + arg_380_0 then
				arg_377_1.var_.moveOldPos1061 = var_380_0.localPosition
				var_380_0.localScale = Vector3.New(1, 1, 1)

				arg_377_1:CheckSpriteTmpPos("1061", 2)

				local var_380_2 = var_380_0.childCount

				for iter_380_0 = 0, var_380_2 - 1 do
					local var_380_3 = var_380_0:GetChild(iter_380_0)

					if var_380_3.name == "split_5" or not string.find(var_380_3.name, "split") then
						var_380_3.gameObject:SetActive(true)
					else
						var_380_3.gameObject:SetActive(false)
					end
				end
			end

			local var_380_4 = 0.001

			if var_380_1 <= arg_377_1.time_ and arg_377_1.time_ < var_380_1 + var_380_4 then
				local var_380_5 = (arg_377_1.time_ - var_380_1) / var_380_4
				local var_380_6 = Vector3.New(-390, -490, 18)

				var_380_0.localPosition = Vector3.Lerp(arg_377_1.var_.moveOldPos1061, var_380_6, var_380_5)
			end

			if arg_377_1.time_ >= var_380_1 + var_380_4 and arg_377_1.time_ < var_380_1 + var_380_4 + arg_380_0 then
				var_380_0.localPosition = Vector3.New(-390, -490, 18)
			end

			local var_380_7 = arg_377_1.actors_["1061"]
			local var_380_8 = 0

			if var_380_8 < arg_377_1.time_ and arg_377_1.time_ <= var_380_8 + arg_380_0 and not isNil(var_380_7) and arg_377_1.var_.actorSpriteComps1061 == nil then
				arg_377_1.var_.actorSpriteComps1061 = var_380_7:GetComponentsInChildren(typeof(Image), true)
			end

			local var_380_9 = 0.034

			if var_380_8 <= arg_377_1.time_ and arg_377_1.time_ < var_380_8 + var_380_9 and not isNil(var_380_7) then
				local var_380_10 = (arg_377_1.time_ - var_380_8) / var_380_9

				if arg_377_1.var_.actorSpriteComps1061 then
					for iter_380_1, iter_380_2 in pairs(arg_377_1.var_.actorSpriteComps1061:ToTable()) do
						if iter_380_2 then
							if arg_377_1.isInRecall_ then
								local var_380_11 = Mathf.Lerp(iter_380_2.color.r, arg_377_1.hightColor1.r, var_380_10)
								local var_380_12 = Mathf.Lerp(iter_380_2.color.g, arg_377_1.hightColor1.g, var_380_10)
								local var_380_13 = Mathf.Lerp(iter_380_2.color.b, arg_377_1.hightColor1.b, var_380_10)

								iter_380_2.color = Color.New(var_380_11, var_380_12, var_380_13)
							else
								local var_380_14 = Mathf.Lerp(iter_380_2.color.r, 1, var_380_10)

								iter_380_2.color = Color.New(var_380_14, var_380_14, var_380_14)
							end
						end
					end
				end
			end

			if arg_377_1.time_ >= var_380_8 + var_380_9 and arg_377_1.time_ < var_380_8 + var_380_9 + arg_380_0 and not isNil(var_380_7) and arg_377_1.var_.actorSpriteComps1061 then
				for iter_380_3, iter_380_4 in pairs(arg_377_1.var_.actorSpriteComps1061:ToTable()) do
					if iter_380_4 then
						if arg_377_1.isInRecall_ then
							iter_380_4.color = arg_377_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_380_4.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_377_1.var_.actorSpriteComps1061 = nil
			end

			local var_380_15 = 0
			local var_380_16 = 0.95

			if var_380_15 < arg_377_1.time_ and arg_377_1.time_ <= var_380_15 + arg_380_0 then
				arg_377_1.talkMaxDuration = 0
				arg_377_1.dialogCg_.alpha = 1

				arg_377_1.dialog_:SetActive(true)
				SetActive(arg_377_1.leftNameGo_, true)

				local var_380_17 = arg_377_1:FormatText(StoryNameCfg[612].name)

				arg_377_1.leftNameTxt_.text = var_380_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_377_1.leftNameTxt_.transform)

				arg_377_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_377_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_377_1:RecordName(arg_377_1.leftNameTxt_.text)
				SetActive(arg_377_1.iconTrs_.gameObject, false)
				arg_377_1.callingController_:SetSelectedState("normal")

				local var_380_18 = arg_377_1:GetWordFromCfg(410142092)
				local var_380_19 = arg_377_1:FormatText(var_380_18.content)

				arg_377_1.text_.text = var_380_19

				LuaForUtil.ClearLinePrefixSymbol(arg_377_1.text_)

				local var_380_20 = 38
				local var_380_21 = utf8.len(var_380_19)
				local var_380_22 = var_380_20 <= 0 and var_380_16 or var_380_16 * (var_380_21 / var_380_20)

				if var_380_22 > 0 and var_380_16 < var_380_22 then
					arg_377_1.talkMaxDuration = var_380_22

					if var_380_22 + var_380_15 > arg_377_1.duration_ then
						arg_377_1.duration_ = var_380_22 + var_380_15
					end
				end

				arg_377_1.text_.text = var_380_19
				arg_377_1.typewritter.percent = 0

				arg_377_1.typewritter:SetDirty()
				arg_377_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_410142", "410142092", "story_v_out_410142.awb") ~= 0 then
					local var_380_23 = manager.audio:GetVoiceLength("story_v_out_410142", "410142092", "story_v_out_410142.awb") / 1000

					if var_380_23 + var_380_15 > arg_377_1.duration_ then
						arg_377_1.duration_ = var_380_23 + var_380_15
					end

					if var_380_18.prefab_name ~= "" and arg_377_1.actors_[var_380_18.prefab_name] ~= nil then
						local var_380_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_377_1.actors_[var_380_18.prefab_name].transform, "story_v_out_410142", "410142092", "story_v_out_410142.awb")

						arg_377_1:RecordAudio("410142092", var_380_24)
						arg_377_1:RecordAudio("410142092", var_380_24)
					else
						arg_377_1:AudioAction("play", "voice", "story_v_out_410142", "410142092", "story_v_out_410142.awb")
					end

					arg_377_1:RecordHistoryTalkVoice("story_v_out_410142", "410142092", "story_v_out_410142.awb")
				end

				arg_377_1:RecordContent(arg_377_1.text_.text)
			end

			local var_380_25 = math.max(var_380_16, arg_377_1.talkMaxDuration)

			if var_380_15 <= arg_377_1.time_ and arg_377_1.time_ < var_380_15 + var_380_25 then
				arg_377_1.typewritter.percent = (arg_377_1.time_ - var_380_15) / var_380_25

				arg_377_1.typewritter:SetDirty()
			end

			if arg_377_1.time_ >= var_380_15 + var_380_25 and arg_377_1.time_ < var_380_15 + var_380_25 + arg_380_0 then
				arg_377_1.typewritter.percent = 1

				arg_377_1.typewritter:SetDirty()
				arg_377_1:ShowNextGo(true)
			end
		end

		arg_377_1.nodeConfigList_ = {
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

		arg_377_1:InitPlayNodeList()
	end,
	Play410142093 = function(arg_381_0, arg_381_1)
		arg_381_1.time_ = 0
		arg_381_1.frameCnt_ = 0
		arg_381_1.state_ = "playing"
		arg_381_1.curTalkId_ = 410142093
		arg_381_1.duration_ = 5

		SetActive(arg_381_1.tipsGo_, false)

		function arg_381_1.onSingleLineFinish_()
			arg_381_1.onSingleLineUpdate_ = nil
			arg_381_1.onSingleLineFinish_ = nil
			arg_381_1.state_ = "waiting"
		end

		function arg_381_1.playNext_(arg_383_0)
			if arg_383_0 == 1 then
				arg_381_0:Play410142094(arg_381_1)
			end
		end

		function arg_381_1.onSingleLineUpdate_(arg_384_0)
			local var_384_0 = arg_381_1.actors_["1056"].transform
			local var_384_1 = 0

			if var_384_1 < arg_381_1.time_ and arg_381_1.time_ <= var_384_1 + arg_384_0 then
				arg_381_1.var_.moveOldPos1056 = var_384_0.localPosition
				var_384_0.localScale = Vector3.New(1, 1, 1)

				arg_381_1:CheckSpriteTmpPos("1056", 7)

				local var_384_2 = var_384_0.childCount

				for iter_384_0 = 0, var_384_2 - 1 do
					local var_384_3 = var_384_0:GetChild(iter_384_0)

					if var_384_3.name == "" or not string.find(var_384_3.name, "split") then
						var_384_3.gameObject:SetActive(true)
					else
						var_384_3.gameObject:SetActive(false)
					end
				end
			end

			local var_384_4 = 0.001

			if var_384_1 <= arg_381_1.time_ and arg_381_1.time_ < var_384_1 + var_384_4 then
				local var_384_5 = (arg_381_1.time_ - var_384_1) / var_384_4
				local var_384_6 = Vector3.New(0, -2000, -180)

				var_384_0.localPosition = Vector3.Lerp(arg_381_1.var_.moveOldPos1056, var_384_6, var_384_5)
			end

			if arg_381_1.time_ >= var_384_1 + var_384_4 and arg_381_1.time_ < var_384_1 + var_384_4 + arg_384_0 then
				var_384_0.localPosition = Vector3.New(0, -2000, -180)
			end

			local var_384_7 = arg_381_1.actors_["1061"].transform
			local var_384_8 = 0

			if var_384_8 < arg_381_1.time_ and arg_381_1.time_ <= var_384_8 + arg_384_0 then
				arg_381_1.var_.moveOldPos1061 = var_384_7.localPosition
				var_384_7.localScale = Vector3.New(1, 1, 1)

				arg_381_1:CheckSpriteTmpPos("1061", 7)

				local var_384_9 = var_384_7.childCount

				for iter_384_1 = 0, var_384_9 - 1 do
					local var_384_10 = var_384_7:GetChild(iter_384_1)

					if var_384_10.name == "" or not string.find(var_384_10.name, "split") then
						var_384_10.gameObject:SetActive(true)
					else
						var_384_10.gameObject:SetActive(false)
					end
				end
			end

			local var_384_11 = 0.001

			if var_384_8 <= arg_381_1.time_ and arg_381_1.time_ < var_384_8 + var_384_11 then
				local var_384_12 = (arg_381_1.time_ - var_384_8) / var_384_11
				local var_384_13 = Vector3.New(0, -2000, 18)

				var_384_7.localPosition = Vector3.Lerp(arg_381_1.var_.moveOldPos1061, var_384_13, var_384_12)
			end

			if arg_381_1.time_ >= var_384_8 + var_384_11 and arg_381_1.time_ < var_384_8 + var_384_11 + arg_384_0 then
				var_384_7.localPosition = Vector3.New(0, -2000, 18)
			end

			local var_384_14 = arg_381_1.actors_["1056"]
			local var_384_15 = 0

			if var_384_15 < arg_381_1.time_ and arg_381_1.time_ <= var_384_15 + arg_384_0 and not isNil(var_384_14) and arg_381_1.var_.actorSpriteComps1056 == nil then
				arg_381_1.var_.actorSpriteComps1056 = var_384_14:GetComponentsInChildren(typeof(Image), true)
			end

			local var_384_16 = 0.034

			if var_384_15 <= arg_381_1.time_ and arg_381_1.time_ < var_384_15 + var_384_16 and not isNil(var_384_14) then
				local var_384_17 = (arg_381_1.time_ - var_384_15) / var_384_16

				if arg_381_1.var_.actorSpriteComps1056 then
					for iter_384_2, iter_384_3 in pairs(arg_381_1.var_.actorSpriteComps1056:ToTable()) do
						if iter_384_3 then
							if arg_381_1.isInRecall_ then
								local var_384_18 = Mathf.Lerp(iter_384_3.color.r, arg_381_1.hightColor2.r, var_384_17)
								local var_384_19 = Mathf.Lerp(iter_384_3.color.g, arg_381_1.hightColor2.g, var_384_17)
								local var_384_20 = Mathf.Lerp(iter_384_3.color.b, arg_381_1.hightColor2.b, var_384_17)

								iter_384_3.color = Color.New(var_384_18, var_384_19, var_384_20)
							else
								local var_384_21 = Mathf.Lerp(iter_384_3.color.r, 0.5, var_384_17)

								iter_384_3.color = Color.New(var_384_21, var_384_21, var_384_21)
							end
						end
					end
				end
			end

			if arg_381_1.time_ >= var_384_15 + var_384_16 and arg_381_1.time_ < var_384_15 + var_384_16 + arg_384_0 and not isNil(var_384_14) and arg_381_1.var_.actorSpriteComps1056 then
				for iter_384_4, iter_384_5 in pairs(arg_381_1.var_.actorSpriteComps1056:ToTable()) do
					if iter_384_5 then
						if arg_381_1.isInRecall_ then
							iter_384_5.color = arg_381_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_384_5.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_381_1.var_.actorSpriteComps1056 = nil
			end

			local var_384_22 = arg_381_1.actors_["1061"]
			local var_384_23 = 0

			if var_384_23 < arg_381_1.time_ and arg_381_1.time_ <= var_384_23 + arg_384_0 and not isNil(var_384_22) and arg_381_1.var_.actorSpriteComps1061 == nil then
				arg_381_1.var_.actorSpriteComps1061 = var_384_22:GetComponentsInChildren(typeof(Image), true)
			end

			local var_384_24 = 0.034

			if var_384_23 <= arg_381_1.time_ and arg_381_1.time_ < var_384_23 + var_384_24 and not isNil(var_384_22) then
				local var_384_25 = (arg_381_1.time_ - var_384_23) / var_384_24

				if arg_381_1.var_.actorSpriteComps1061 then
					for iter_384_6, iter_384_7 in pairs(arg_381_1.var_.actorSpriteComps1061:ToTable()) do
						if iter_384_7 then
							if arg_381_1.isInRecall_ then
								local var_384_26 = Mathf.Lerp(iter_384_7.color.r, arg_381_1.hightColor2.r, var_384_25)
								local var_384_27 = Mathf.Lerp(iter_384_7.color.g, arg_381_1.hightColor2.g, var_384_25)
								local var_384_28 = Mathf.Lerp(iter_384_7.color.b, arg_381_1.hightColor2.b, var_384_25)

								iter_384_7.color = Color.New(var_384_26, var_384_27, var_384_28)
							else
								local var_384_29 = Mathf.Lerp(iter_384_7.color.r, 0.5, var_384_25)

								iter_384_7.color = Color.New(var_384_29, var_384_29, var_384_29)
							end
						end
					end
				end
			end

			if arg_381_1.time_ >= var_384_23 + var_384_24 and arg_381_1.time_ < var_384_23 + var_384_24 + arg_384_0 and not isNil(var_384_22) and arg_381_1.var_.actorSpriteComps1061 then
				for iter_384_8, iter_384_9 in pairs(arg_381_1.var_.actorSpriteComps1061:ToTable()) do
					if iter_384_9 then
						if arg_381_1.isInRecall_ then
							iter_384_9.color = arg_381_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_384_9.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_381_1.var_.actorSpriteComps1061 = nil
			end

			local var_384_30 = 0
			local var_384_31 = 0.95

			if var_384_30 < arg_381_1.time_ and arg_381_1.time_ <= var_384_30 + arg_384_0 then
				arg_381_1.talkMaxDuration = 0
				arg_381_1.dialogCg_.alpha = 1

				arg_381_1.dialog_:SetActive(true)
				SetActive(arg_381_1.leftNameGo_, false)

				arg_381_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_381_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_381_1:RecordName(arg_381_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_381_1.iconTrs_.gameObject, false)
				arg_381_1.callingController_:SetSelectedState("normal")

				local var_384_32 = arg_381_1:GetWordFromCfg(410142093)
				local var_384_33 = arg_381_1:FormatText(var_384_32.content)

				arg_381_1.text_.text = var_384_33

				LuaForUtil.ClearLinePrefixSymbol(arg_381_1.text_)

				local var_384_34 = 38
				local var_384_35 = utf8.len(var_384_33)
				local var_384_36 = var_384_34 <= 0 and var_384_31 or var_384_31 * (var_384_35 / var_384_34)

				if var_384_36 > 0 and var_384_31 < var_384_36 then
					arg_381_1.talkMaxDuration = var_384_36

					if var_384_36 + var_384_30 > arg_381_1.duration_ then
						arg_381_1.duration_ = var_384_36 + var_384_30
					end
				end

				arg_381_1.text_.text = var_384_33
				arg_381_1.typewritter.percent = 0

				arg_381_1.typewritter:SetDirty()
				arg_381_1:ShowNextGo(false)
				arg_381_1:RecordContent(arg_381_1.text_.text)
			end

			local var_384_37 = math.max(var_384_31, arg_381_1.talkMaxDuration)

			if var_384_30 <= arg_381_1.time_ and arg_381_1.time_ < var_384_30 + var_384_37 then
				arg_381_1.typewritter.percent = (arg_381_1.time_ - var_384_30) / var_384_37

				arg_381_1.typewritter:SetDirty()
			end

			if arg_381_1.time_ >= var_384_30 + var_384_37 and arg_381_1.time_ < var_384_30 + var_384_37 + arg_384_0 then
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
				actorName = "1061",
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
	Play410142094 = function(arg_385_0, arg_385_1)
		arg_385_1.time_ = 0
		arg_385_1.frameCnt_ = 0
		arg_385_1.state_ = "playing"
		arg_385_1.curTalkId_ = 410142094
		arg_385_1.duration_ = 13.83

		local var_385_0 = {
			ja = 2.3,
			CriLanguages = 13.833,
			zh = 13.833
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
				arg_385_0:Play410142095(arg_385_1)
			end
		end

		function arg_385_1.onSingleLineUpdate_(arg_388_0)
			local var_388_0 = arg_385_1.actors_["1061"].transform
			local var_388_1 = 0

			if var_388_1 < arg_385_1.time_ and arg_385_1.time_ <= var_388_1 + arg_388_0 then
				arg_385_1.var_.moveOldPos1061 = var_388_0.localPosition
				var_388_0.localScale = Vector3.New(1, 1, 1)

				arg_385_1:CheckSpriteTmpPos("1061", 3)

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
				local var_388_6 = Vector3.New(0, -490, 18)

				var_388_0.localPosition = Vector3.Lerp(arg_385_1.var_.moveOldPos1061, var_388_6, var_388_5)
			end

			if arg_385_1.time_ >= var_388_1 + var_388_4 and arg_385_1.time_ < var_388_1 + var_388_4 + arg_388_0 then
				var_388_0.localPosition = Vector3.New(0, -490, 18)
			end

			local var_388_7 = arg_385_1.actors_["1061"]
			local var_388_8 = 0

			if var_388_8 < arg_385_1.time_ and arg_385_1.time_ <= var_388_8 + arg_388_0 and not isNil(var_388_7) and arg_385_1.var_.actorSpriteComps1061 == nil then
				arg_385_1.var_.actorSpriteComps1061 = var_388_7:GetComponentsInChildren(typeof(Image), true)
			end

			local var_388_9 = 0.034

			if var_388_8 <= arg_385_1.time_ and arg_385_1.time_ < var_388_8 + var_388_9 and not isNil(var_388_7) then
				local var_388_10 = (arg_385_1.time_ - var_388_8) / var_388_9

				if arg_385_1.var_.actorSpriteComps1061 then
					for iter_388_1, iter_388_2 in pairs(arg_385_1.var_.actorSpriteComps1061:ToTable()) do
						if iter_388_2 then
							if arg_385_1.isInRecall_ then
								local var_388_11 = Mathf.Lerp(iter_388_2.color.r, arg_385_1.hightColor1.r, var_388_10)
								local var_388_12 = Mathf.Lerp(iter_388_2.color.g, arg_385_1.hightColor1.g, var_388_10)
								local var_388_13 = Mathf.Lerp(iter_388_2.color.b, arg_385_1.hightColor1.b, var_388_10)

								iter_388_2.color = Color.New(var_388_11, var_388_12, var_388_13)
							else
								local var_388_14 = Mathf.Lerp(iter_388_2.color.r, 1, var_388_10)

								iter_388_2.color = Color.New(var_388_14, var_388_14, var_388_14)
							end
						end
					end
				end
			end

			if arg_385_1.time_ >= var_388_8 + var_388_9 and arg_385_1.time_ < var_388_8 + var_388_9 + arg_388_0 and not isNil(var_388_7) and arg_385_1.var_.actorSpriteComps1061 then
				for iter_388_3, iter_388_4 in pairs(arg_385_1.var_.actorSpriteComps1061:ToTable()) do
					if iter_388_4 then
						if arg_385_1.isInRecall_ then
							iter_388_4.color = arg_385_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_388_4.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_385_1.var_.actorSpriteComps1061 = nil
			end

			local var_388_15 = 0
			local var_388_16 = 0.05

			if var_388_15 < arg_385_1.time_ and arg_385_1.time_ <= var_388_15 + arg_388_0 then
				arg_385_1.talkMaxDuration = 0
				arg_385_1.dialogCg_.alpha = 1

				arg_385_1.dialog_:SetActive(true)
				SetActive(arg_385_1.leftNameGo_, true)

				local var_388_17 = arg_385_1:FormatText(StoryNameCfg[612].name)

				arg_385_1.leftNameTxt_.text = var_388_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_385_1.leftNameTxt_.transform)

				arg_385_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_385_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_385_1:RecordName(arg_385_1.leftNameTxt_.text)
				SetActive(arg_385_1.iconTrs_.gameObject, false)
				arg_385_1.callingController_:SetSelectedState("normal")

				local var_388_18 = arg_385_1:GetWordFromCfg(410142094)
				local var_388_19 = arg_385_1:FormatText(var_388_18.content)

				arg_385_1.text_.text = var_388_19

				LuaForUtil.ClearLinePrefixSymbol(arg_385_1.text_)

				local var_388_20 = 2
				local var_388_21 = utf8.len(var_388_19)
				local var_388_22 = var_388_20 <= 0 and var_388_16 or var_388_16 * (var_388_21 / var_388_20)

				if var_388_22 > 0 and var_388_16 < var_388_22 then
					arg_385_1.talkMaxDuration = var_388_22

					if var_388_22 + var_388_15 > arg_385_1.duration_ then
						arg_385_1.duration_ = var_388_22 + var_388_15
					end
				end

				arg_385_1.text_.text = var_388_19
				arg_385_1.typewritter.percent = 0

				arg_385_1.typewritter:SetDirty()
				arg_385_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_410142", "410142094", "story_v_out_410142.awb") ~= 0 then
					local var_388_23 = manager.audio:GetVoiceLength("story_v_out_410142", "410142094", "story_v_out_410142.awb") / 1000

					if var_388_23 + var_388_15 > arg_385_1.duration_ then
						arg_385_1.duration_ = var_388_23 + var_388_15
					end

					if var_388_18.prefab_name ~= "" and arg_385_1.actors_[var_388_18.prefab_name] ~= nil then
						local var_388_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_385_1.actors_[var_388_18.prefab_name].transform, "story_v_out_410142", "410142094", "story_v_out_410142.awb")

						arg_385_1:RecordAudio("410142094", var_388_24)
						arg_385_1:RecordAudio("410142094", var_388_24)
					else
						arg_385_1:AudioAction("play", "voice", "story_v_out_410142", "410142094", "story_v_out_410142.awb")
					end

					arg_385_1:RecordHistoryTalkVoice("story_v_out_410142", "410142094", "story_v_out_410142.awb")
				end

				arg_385_1:RecordContent(arg_385_1.text_.text)
			end

			local var_388_25 = math.max(var_388_16, arg_385_1.talkMaxDuration)

			if var_388_15 <= arg_385_1.time_ and arg_385_1.time_ < var_388_15 + var_388_25 then
				arg_385_1.typewritter.percent = (arg_385_1.time_ - var_388_15) / var_388_25

				arg_385_1.typewritter:SetDirty()
			end

			if arg_385_1.time_ >= var_388_15 + var_388_25 and arg_385_1.time_ < var_388_15 + var_388_25 + arg_388_0 then
				arg_385_1.typewritter.percent = 1

				arg_385_1.typewritter:SetDirty()
				arg_385_1:ShowNextGo(true)
			end
		end

		arg_385_1.nodeConfigList_ = {
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

		arg_385_1:InitPlayNodeList()
	end,
	Play410142095 = function(arg_389_0, arg_389_1)
		arg_389_1.time_ = 0
		arg_389_1.frameCnt_ = 0
		arg_389_1.state_ = "playing"
		arg_389_1.curTalkId_ = 410142095
		arg_389_1.duration_ = 10.9

		local var_389_0 = {
			ja = 10.9,
			CriLanguages = 5.4,
			zh = 5.4
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
				arg_389_0:Play410142096(arg_389_1)
			end
		end

		function arg_389_1.onSingleLineUpdate_(arg_392_0)
			local var_392_0 = arg_389_1.actors_["1061"].transform
			local var_392_1 = 0

			if var_392_1 < arg_389_1.time_ and arg_389_1.time_ <= var_392_1 + arg_392_0 then
				arg_389_1.var_.moveOldPos1061 = var_392_0.localPosition
				var_392_0.localScale = Vector3.New(1, 1, 1)

				arg_389_1:CheckSpriteTmpPos("1061", 3)

				local var_392_2 = var_392_0.childCount

				for iter_392_0 = 0, var_392_2 - 1 do
					local var_392_3 = var_392_0:GetChild(iter_392_0)

					if var_392_3.name == "split_2" or not string.find(var_392_3.name, "split") then
						var_392_3.gameObject:SetActive(true)
					else
						var_392_3.gameObject:SetActive(false)
					end
				end
			end

			local var_392_4 = 0.001

			if var_392_1 <= arg_389_1.time_ and arg_389_1.time_ < var_392_1 + var_392_4 then
				local var_392_5 = (arg_389_1.time_ - var_392_1) / var_392_4
				local var_392_6 = Vector3.New(0, -490, 18)

				var_392_0.localPosition = Vector3.Lerp(arg_389_1.var_.moveOldPos1061, var_392_6, var_392_5)
			end

			if arg_389_1.time_ >= var_392_1 + var_392_4 and arg_389_1.time_ < var_392_1 + var_392_4 + arg_392_0 then
				var_392_0.localPosition = Vector3.New(0, -490, 18)
			end

			local var_392_7 = arg_389_1.actors_["1061"]
			local var_392_8 = 0

			if var_392_8 < arg_389_1.time_ and arg_389_1.time_ <= var_392_8 + arg_392_0 and not isNil(var_392_7) and arg_389_1.var_.actorSpriteComps1061 == nil then
				arg_389_1.var_.actorSpriteComps1061 = var_392_7:GetComponentsInChildren(typeof(Image), true)
			end

			local var_392_9 = 0.034

			if var_392_8 <= arg_389_1.time_ and arg_389_1.time_ < var_392_8 + var_392_9 and not isNil(var_392_7) then
				local var_392_10 = (arg_389_1.time_ - var_392_8) / var_392_9

				if arg_389_1.var_.actorSpriteComps1061 then
					for iter_392_1, iter_392_2 in pairs(arg_389_1.var_.actorSpriteComps1061:ToTable()) do
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

			if arg_389_1.time_ >= var_392_8 + var_392_9 and arg_389_1.time_ < var_392_8 + var_392_9 + arg_392_0 and not isNil(var_392_7) and arg_389_1.var_.actorSpriteComps1061 then
				for iter_392_3, iter_392_4 in pairs(arg_389_1.var_.actorSpriteComps1061:ToTable()) do
					if iter_392_4 then
						if arg_389_1.isInRecall_ then
							iter_392_4.color = arg_389_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_392_4.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_389_1.var_.actorSpriteComps1061 = nil
			end

			local var_392_15 = 0
			local var_392_16 = 0.55

			if var_392_15 < arg_389_1.time_ and arg_389_1.time_ <= var_392_15 + arg_392_0 then
				arg_389_1.talkMaxDuration = 0
				arg_389_1.dialogCg_.alpha = 1

				arg_389_1.dialog_:SetActive(true)
				SetActive(arg_389_1.leftNameGo_, true)

				local var_392_17 = arg_389_1:FormatText(StoryNameCfg[612].name)

				arg_389_1.leftNameTxt_.text = var_392_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_389_1.leftNameTxt_.transform)

				arg_389_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_389_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_389_1:RecordName(arg_389_1.leftNameTxt_.text)
				SetActive(arg_389_1.iconTrs_.gameObject, false)
				arg_389_1.callingController_:SetSelectedState("normal")

				local var_392_18 = arg_389_1:GetWordFromCfg(410142095)
				local var_392_19 = arg_389_1:FormatText(var_392_18.content)

				arg_389_1.text_.text = var_392_19

				LuaForUtil.ClearLinePrefixSymbol(arg_389_1.text_)

				local var_392_20 = 22
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

				if manager.audio:GetVoiceLength("story_v_out_410142", "410142095", "story_v_out_410142.awb") ~= 0 then
					local var_392_23 = manager.audio:GetVoiceLength("story_v_out_410142", "410142095", "story_v_out_410142.awb") / 1000

					if var_392_23 + var_392_15 > arg_389_1.duration_ then
						arg_389_1.duration_ = var_392_23 + var_392_15
					end

					if var_392_18.prefab_name ~= "" and arg_389_1.actors_[var_392_18.prefab_name] ~= nil then
						local var_392_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_389_1.actors_[var_392_18.prefab_name].transform, "story_v_out_410142", "410142095", "story_v_out_410142.awb")

						arg_389_1:RecordAudio("410142095", var_392_24)
						arg_389_1:RecordAudio("410142095", var_392_24)
					else
						arg_389_1:AudioAction("play", "voice", "story_v_out_410142", "410142095", "story_v_out_410142.awb")
					end

					arg_389_1:RecordHistoryTalkVoice("story_v_out_410142", "410142095", "story_v_out_410142.awb")
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
				actorName = "1061",
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
	Play410142096 = function(arg_393_0, arg_393_1)
		arg_393_1.time_ = 0
		arg_393_1.frameCnt_ = 0
		arg_393_1.state_ = "playing"
		arg_393_1.curTalkId_ = 410142096
		arg_393_1.duration_ = 11.07

		local var_393_0 = {
			ja = 11.066,
			CriLanguages = 7.6,
			zh = 7.6
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
				arg_393_0:Play410142097(arg_393_1)
			end
		end

		function arg_393_1.onSingleLineUpdate_(arg_396_0)
			local var_396_0 = arg_393_1.actors_["1061"].transform
			local var_396_1 = 0

			if var_396_1 < arg_393_1.time_ and arg_393_1.time_ <= var_396_1 + arg_396_0 then
				arg_393_1.var_.moveOldPos1061 = var_396_0.localPosition
				var_396_0.localScale = Vector3.New(1, 1, 1)

				arg_393_1:CheckSpriteTmpPos("1061", 3)

				local var_396_2 = var_396_0.childCount

				for iter_396_0 = 0, var_396_2 - 1 do
					local var_396_3 = var_396_0:GetChild(iter_396_0)

					if var_396_3.name == "split_2" or not string.find(var_396_3.name, "split") then
						var_396_3.gameObject:SetActive(true)
					else
						var_396_3.gameObject:SetActive(false)
					end
				end
			end

			local var_396_4 = 0.001

			if var_396_1 <= arg_393_1.time_ and arg_393_1.time_ < var_396_1 + var_396_4 then
				local var_396_5 = (arg_393_1.time_ - var_396_1) / var_396_4
				local var_396_6 = Vector3.New(0, -490, 18)

				var_396_0.localPosition = Vector3.Lerp(arg_393_1.var_.moveOldPos1061, var_396_6, var_396_5)
			end

			if arg_393_1.time_ >= var_396_1 + var_396_4 and arg_393_1.time_ < var_396_1 + var_396_4 + arg_396_0 then
				var_396_0.localPosition = Vector3.New(0, -490, 18)
			end

			local var_396_7 = arg_393_1.actors_["1061"]
			local var_396_8 = 0

			if var_396_8 < arg_393_1.time_ and arg_393_1.time_ <= var_396_8 + arg_396_0 and not isNil(var_396_7) and arg_393_1.var_.actorSpriteComps1061 == nil then
				arg_393_1.var_.actorSpriteComps1061 = var_396_7:GetComponentsInChildren(typeof(Image), true)
			end

			local var_396_9 = 0.034

			if var_396_8 <= arg_393_1.time_ and arg_393_1.time_ < var_396_8 + var_396_9 and not isNil(var_396_7) then
				local var_396_10 = (arg_393_1.time_ - var_396_8) / var_396_9

				if arg_393_1.var_.actorSpriteComps1061 then
					for iter_396_1, iter_396_2 in pairs(arg_393_1.var_.actorSpriteComps1061:ToTable()) do
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

			if arg_393_1.time_ >= var_396_8 + var_396_9 and arg_393_1.time_ < var_396_8 + var_396_9 + arg_396_0 and not isNil(var_396_7) and arg_393_1.var_.actorSpriteComps1061 then
				for iter_396_3, iter_396_4 in pairs(arg_393_1.var_.actorSpriteComps1061:ToTable()) do
					if iter_396_4 then
						if arg_393_1.isInRecall_ then
							iter_396_4.color = arg_393_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_396_4.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_393_1.var_.actorSpriteComps1061 = nil
			end

			local var_396_15 = 0
			local var_396_16 = 0.675

			if var_396_15 < arg_393_1.time_ and arg_393_1.time_ <= var_396_15 + arg_396_0 then
				arg_393_1.talkMaxDuration = 0
				arg_393_1.dialogCg_.alpha = 1

				arg_393_1.dialog_:SetActive(true)
				SetActive(arg_393_1.leftNameGo_, true)

				local var_396_17 = arg_393_1:FormatText(StoryNameCfg[612].name)

				arg_393_1.leftNameTxt_.text = var_396_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_393_1.leftNameTxt_.transform)

				arg_393_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_393_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_393_1:RecordName(arg_393_1.leftNameTxt_.text)
				SetActive(arg_393_1.iconTrs_.gameObject, false)
				arg_393_1.callingController_:SetSelectedState("normal")

				local var_396_18 = arg_393_1:GetWordFromCfg(410142096)
				local var_396_19 = arg_393_1:FormatText(var_396_18.content)

				arg_393_1.text_.text = var_396_19

				LuaForUtil.ClearLinePrefixSymbol(arg_393_1.text_)

				local var_396_20 = 27
				local var_396_21 = utf8.len(var_396_19)
				local var_396_22 = var_396_20 <= 0 and var_396_16 or var_396_16 * (var_396_21 / var_396_20)

				if var_396_22 > 0 and var_396_16 < var_396_22 then
					arg_393_1.talkMaxDuration = var_396_22

					if var_396_22 + var_396_15 > arg_393_1.duration_ then
						arg_393_1.duration_ = var_396_22 + var_396_15
					end
				end

				arg_393_1.text_.text = var_396_19
				arg_393_1.typewritter.percent = 0

				arg_393_1.typewritter:SetDirty()
				arg_393_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_410142", "410142096", "story_v_out_410142.awb") ~= 0 then
					local var_396_23 = manager.audio:GetVoiceLength("story_v_out_410142", "410142096", "story_v_out_410142.awb") / 1000

					if var_396_23 + var_396_15 > arg_393_1.duration_ then
						arg_393_1.duration_ = var_396_23 + var_396_15
					end

					if var_396_18.prefab_name ~= "" and arg_393_1.actors_[var_396_18.prefab_name] ~= nil then
						local var_396_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_393_1.actors_[var_396_18.prefab_name].transform, "story_v_out_410142", "410142096", "story_v_out_410142.awb")

						arg_393_1:RecordAudio("410142096", var_396_24)
						arg_393_1:RecordAudio("410142096", var_396_24)
					else
						arg_393_1:AudioAction("play", "voice", "story_v_out_410142", "410142096", "story_v_out_410142.awb")
					end

					arg_393_1:RecordHistoryTalkVoice("story_v_out_410142", "410142096", "story_v_out_410142.awb")
				end

				arg_393_1:RecordContent(arg_393_1.text_.text)
			end

			local var_396_25 = math.max(var_396_16, arg_393_1.talkMaxDuration)

			if var_396_15 <= arg_393_1.time_ and arg_393_1.time_ < var_396_15 + var_396_25 then
				arg_393_1.typewritter.percent = (arg_393_1.time_ - var_396_15) / var_396_25

				arg_393_1.typewritter:SetDirty()
			end

			if arg_393_1.time_ >= var_396_15 + var_396_25 and arg_393_1.time_ < var_396_15 + var_396_25 + arg_396_0 then
				arg_393_1.typewritter.percent = 1

				arg_393_1.typewritter:SetDirty()
				arg_393_1:ShowNextGo(true)
			end
		end

		arg_393_1.nodeConfigList_ = {
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

		arg_393_1:InitPlayNodeList()
	end,
	Play410142097 = function(arg_397_0, arg_397_1)
		arg_397_1.time_ = 0
		arg_397_1.frameCnt_ = 0
		arg_397_1.state_ = "playing"
		arg_397_1.curTalkId_ = 410142097
		arg_397_1.duration_ = 5

		SetActive(arg_397_1.tipsGo_, false)

		function arg_397_1.onSingleLineFinish_()
			arg_397_1.onSingleLineUpdate_ = nil
			arg_397_1.onSingleLineFinish_ = nil
			arg_397_1.state_ = "waiting"
		end

		function arg_397_1.playNext_(arg_399_0)
			if arg_399_0 == 1 then
				arg_397_0:Play410142098(arg_397_1)
			end
		end

		function arg_397_1.onSingleLineUpdate_(arg_400_0)
			local var_400_0 = arg_397_1.actors_["1061"]
			local var_400_1 = 0

			if var_400_1 < arg_397_1.time_ and arg_397_1.time_ <= var_400_1 + arg_400_0 and not isNil(var_400_0) and arg_397_1.var_.actorSpriteComps1061 == nil then
				arg_397_1.var_.actorSpriteComps1061 = var_400_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_400_2 = 0.034

			if var_400_1 <= arg_397_1.time_ and arg_397_1.time_ < var_400_1 + var_400_2 and not isNil(var_400_0) then
				local var_400_3 = (arg_397_1.time_ - var_400_1) / var_400_2

				if arg_397_1.var_.actorSpriteComps1061 then
					for iter_400_0, iter_400_1 in pairs(arg_397_1.var_.actorSpriteComps1061:ToTable()) do
						if iter_400_1 then
							if arg_397_1.isInRecall_ then
								local var_400_4 = Mathf.Lerp(iter_400_1.color.r, arg_397_1.hightColor2.r, var_400_3)
								local var_400_5 = Mathf.Lerp(iter_400_1.color.g, arg_397_1.hightColor2.g, var_400_3)
								local var_400_6 = Mathf.Lerp(iter_400_1.color.b, arg_397_1.hightColor2.b, var_400_3)

								iter_400_1.color = Color.New(var_400_4, var_400_5, var_400_6)
							else
								local var_400_7 = Mathf.Lerp(iter_400_1.color.r, 0.5, var_400_3)

								iter_400_1.color = Color.New(var_400_7, var_400_7, var_400_7)
							end
						end
					end
				end
			end

			if arg_397_1.time_ >= var_400_1 + var_400_2 and arg_397_1.time_ < var_400_1 + var_400_2 + arg_400_0 and not isNil(var_400_0) and arg_397_1.var_.actorSpriteComps1061 then
				for iter_400_2, iter_400_3 in pairs(arg_397_1.var_.actorSpriteComps1061:ToTable()) do
					if iter_400_3 then
						if arg_397_1.isInRecall_ then
							iter_400_3.color = arg_397_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_400_3.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_397_1.var_.actorSpriteComps1061 = nil
			end

			local var_400_8 = 0
			local var_400_9 = 0.575

			if var_400_8 < arg_397_1.time_ and arg_397_1.time_ <= var_400_8 + arg_400_0 then
				arg_397_1.talkMaxDuration = 0
				arg_397_1.dialogCg_.alpha = 1

				arg_397_1.dialog_:SetActive(true)
				SetActive(arg_397_1.leftNameGo_, false)

				arg_397_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_397_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_397_1:RecordName(arg_397_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_397_1.iconTrs_.gameObject, false)
				arg_397_1.callingController_:SetSelectedState("normal")

				local var_400_10 = arg_397_1:GetWordFromCfg(410142097)
				local var_400_11 = arg_397_1:FormatText(var_400_10.content)

				arg_397_1.text_.text = var_400_11

				LuaForUtil.ClearLinePrefixSymbol(arg_397_1.text_)

				local var_400_12 = 23
				local var_400_13 = utf8.len(var_400_11)
				local var_400_14 = var_400_12 <= 0 and var_400_9 or var_400_9 * (var_400_13 / var_400_12)

				if var_400_14 > 0 and var_400_9 < var_400_14 then
					arg_397_1.talkMaxDuration = var_400_14

					if var_400_14 + var_400_8 > arg_397_1.duration_ then
						arg_397_1.duration_ = var_400_14 + var_400_8
					end
				end

				arg_397_1.text_.text = var_400_11
				arg_397_1.typewritter.percent = 0

				arg_397_1.typewritter:SetDirty()
				arg_397_1:ShowNextGo(false)
				arg_397_1:RecordContent(arg_397_1.text_.text)
			end

			local var_400_15 = math.max(var_400_9, arg_397_1.talkMaxDuration)

			if var_400_8 <= arg_397_1.time_ and arg_397_1.time_ < var_400_8 + var_400_15 then
				arg_397_1.typewritter.percent = (arg_397_1.time_ - var_400_8) / var_400_15

				arg_397_1.typewritter:SetDirty()
			end

			if arg_397_1.time_ >= var_400_8 + var_400_15 and arg_397_1.time_ < var_400_8 + var_400_15 + arg_400_0 then
				arg_397_1.typewritter.percent = 1

				arg_397_1.typewritter:SetDirty()
				arg_397_1:ShowNextGo(true)
			end
		end

		arg_397_1.nodeConfigList_ = {}

		arg_397_1:InitPlayNodeList()
	end,
	Play410142098 = function(arg_401_0, arg_401_1)
		arg_401_1.time_ = 0
		arg_401_1.frameCnt_ = 0
		arg_401_1.state_ = "playing"
		arg_401_1.curTalkId_ = 410142098
		arg_401_1.duration_ = 5

		SetActive(arg_401_1.tipsGo_, false)

		function arg_401_1.onSingleLineFinish_()
			arg_401_1.onSingleLineUpdate_ = nil
			arg_401_1.onSingleLineFinish_ = nil
			arg_401_1.state_ = "waiting"
			arg_401_1.auto_ = false
		end

		function arg_401_1.playNext_(arg_403_0)
			arg_401_1.onStoryFinished_()
		end

		function arg_401_1.onSingleLineUpdate_(arg_404_0)
			local var_404_0 = 0
			local var_404_1 = 0.85

			if var_404_0 < arg_401_1.time_ and arg_401_1.time_ <= var_404_0 + arg_404_0 then
				arg_401_1.talkMaxDuration = 0
				arg_401_1.dialogCg_.alpha = 1

				arg_401_1.dialog_:SetActive(true)
				SetActive(arg_401_1.leftNameGo_, false)

				arg_401_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_401_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_401_1:RecordName(arg_401_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_401_1.iconTrs_.gameObject, false)
				arg_401_1.callingController_:SetSelectedState("normal")

				local var_404_2 = arg_401_1:GetWordFromCfg(410142098)
				local var_404_3 = arg_401_1:FormatText(var_404_2.content)

				arg_401_1.text_.text = var_404_3

				LuaForUtil.ClearLinePrefixSymbol(arg_401_1.text_)

				local var_404_4 = 34
				local var_404_5 = utf8.len(var_404_3)
				local var_404_6 = var_404_4 <= 0 and var_404_1 or var_404_1 * (var_404_5 / var_404_4)

				if var_404_6 > 0 and var_404_1 < var_404_6 then
					arg_401_1.talkMaxDuration = var_404_6

					if var_404_6 + var_404_0 > arg_401_1.duration_ then
						arg_401_1.duration_ = var_404_6 + var_404_0
					end
				end

				arg_401_1.text_.text = var_404_3
				arg_401_1.typewritter.percent = 0

				arg_401_1.typewritter:SetDirty()
				arg_401_1:ShowNextGo(false)
				arg_401_1:RecordContent(arg_401_1.text_.text)
			end

			local var_404_7 = math.max(var_404_1, arg_401_1.talkMaxDuration)

			if var_404_0 <= arg_401_1.time_ and arg_401_1.time_ < var_404_0 + var_404_7 then
				arg_401_1.typewritter.percent = (arg_401_1.time_ - var_404_0) / var_404_7

				arg_401_1.typewritter:SetDirty()
			end

			if arg_401_1.time_ >= var_404_0 + var_404_7 and arg_401_1.time_ < var_404_0 + var_404_7 + arg_404_0 then
				arg_401_1.typewritter.percent = 1

				arg_401_1.typewritter:SetDirty()
				arg_401_1:ShowNextGo(true)
			end
		end

		arg_401_1.nodeConfigList_ = {}

		arg_401_1:InitPlayNodeList()
	end,
	assets = {
		"TextureConfig/Background/ST61",
		"TextureConfig/Background/ST65",
		"TextureConfig/Background/STblack",
		"TextureConfig/Background/L01f"
	},
	voices = {
		"story_v_out_410142.awb"
	}
}
