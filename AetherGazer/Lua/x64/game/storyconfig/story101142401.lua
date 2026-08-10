return {
	Play114241001 = function(arg_1_0, arg_1_1)
		arg_1_1.time_ = 0
		arg_1_1.frameCnt_ = 0
		arg_1_1.state_ = "playing"
		arg_1_1.curTalkId_ = 114241001
		arg_1_1.duration_ = 7.17

		local var_1_0 = {
			ja = 7.166,
			ko = 4.933,
			zh = 4.033,
			en = 4.1
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
				arg_1_0:Play114241002(arg_1_1)
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
			local var_4_54 = 0.633333333333333

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

			local var_4_59 = 2
			local var_4_60 = 0.225

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

				local var_4_63 = arg_1_1:GetWordFromCfg(114241001)
				local var_4_64 = arg_1_1:FormatText(var_4_63.content)

				arg_1_1.text_.text = var_4_64

				LuaForUtil.ClearLinePrefixSymbol(arg_1_1.text_)

				local var_4_65 = 9
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

				if manager.audio:GetVoiceLength("story_v_out_114241", "114241001", "story_v_out_114241.awb") ~= 0 then
					local var_4_68 = manager.audio:GetVoiceLength("story_v_out_114241", "114241001", "story_v_out_114241.awb") / 1000

					if var_4_68 + var_4_59 > arg_1_1.duration_ then
						arg_1_1.duration_ = var_4_68 + var_4_59
					end

					if var_4_63.prefab_name ~= "" and arg_1_1.actors_[var_4_63.prefab_name] ~= nil then
						local var_4_69 = LuaForUtil.PlayVoiceWithCriLipsync(arg_1_1.actors_[var_4_63.prefab_name].transform, "story_v_out_114241", "114241001", "story_v_out_114241.awb")

						arg_1_1:RecordAudio("114241001", var_4_69)
						arg_1_1:RecordAudio("114241001", var_4_69)
					else
						arg_1_1:AudioAction("play", "voice", "story_v_out_114241", "114241001", "story_v_out_114241.awb")
					end

					arg_1_1:RecordHistoryTalkVoice("story_v_out_114241", "114241001", "story_v_out_114241.awb")
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
	Play114241002 = function(arg_9_0, arg_9_1)
		arg_9_1.time_ = 0
		arg_9_1.frameCnt_ = 0
		arg_9_1.state_ = "playing"
		arg_9_1.curTalkId_ = 114241002
		arg_9_1.duration_ = 10.2

		local var_9_0 = {
			ja = 10.2,
			ko = 7.966,
			zh = 9.666,
			en = 8
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
				arg_9_0:Play114241003(arg_9_1)
			end
		end

		function arg_9_1.onSingleLineUpdate_(arg_12_0)
			local var_12_0 = "10018"

			if arg_9_1.actors_[var_12_0] == nil then
				local var_12_1 = Asset.Load("Widget/System/Story/StoryExpression/" .. "10018")

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

			local var_12_4 = arg_9_1.actors_["10018"].transform
			local var_12_5 = 0

			if var_12_5 < arg_9_1.time_ and arg_9_1.time_ <= var_12_5 + arg_12_0 then
				arg_9_1.var_.moveOldPos10018 = var_12_4.localPosition
				var_12_4.localScale = Vector3.New(1, 1, 1)

				arg_9_1:CheckSpriteTmpPos("10018", 2)

				local var_12_6 = var_12_4.childCount

				for iter_12_2 = 0, var_12_6 - 1 do
					local var_12_7 = var_12_4:GetChild(iter_12_2)

					if var_12_7.name == "split_1" or not string.find(var_12_7.name, "split") then
						var_12_7.gameObject:SetActive(true)
					else
						var_12_7.gameObject:SetActive(false)
					end
				end
			end

			local var_12_8 = 0.001

			if var_12_5 <= arg_9_1.time_ and arg_9_1.time_ < var_12_5 + var_12_8 then
				local var_12_9 = (arg_9_1.time_ - var_12_5) / var_12_8
				local var_12_10 = Vector3.New(-390, -350, -180)

				var_12_4.localPosition = Vector3.Lerp(arg_9_1.var_.moveOldPos10018, var_12_10, var_12_9)
			end

			if arg_9_1.time_ >= var_12_5 + var_12_8 and arg_9_1.time_ < var_12_5 + var_12_8 + arg_12_0 then
				var_12_4.localPosition = Vector3.New(-390, -350, -180)
			end

			local var_12_11 = arg_9_1.actors_["10015"]
			local var_12_12 = 0

			if var_12_12 < arg_9_1.time_ and arg_9_1.time_ <= var_12_12 + arg_12_0 and not isNil(var_12_11) and arg_9_1.var_.actorSpriteComps10015 == nil then
				arg_9_1.var_.actorSpriteComps10015 = var_12_11:GetComponentsInChildren(typeof(Image), true)
			end

			local var_12_13 = 0.034

			if var_12_12 <= arg_9_1.time_ and arg_9_1.time_ < var_12_12 + var_12_13 and not isNil(var_12_11) then
				local var_12_14 = (arg_9_1.time_ - var_12_12) / var_12_13

				if arg_9_1.var_.actorSpriteComps10015 then
					for iter_12_3, iter_12_4 in pairs(arg_9_1.var_.actorSpriteComps10015:ToTable()) do
						if iter_12_4 then
							if arg_9_1.isInRecall_ then
								local var_12_15 = Mathf.Lerp(iter_12_4.color.r, arg_9_1.hightColor2.r, var_12_14)
								local var_12_16 = Mathf.Lerp(iter_12_4.color.g, arg_9_1.hightColor2.g, var_12_14)
								local var_12_17 = Mathf.Lerp(iter_12_4.color.b, arg_9_1.hightColor2.b, var_12_14)

								iter_12_4.color = Color.New(var_12_15, var_12_16, var_12_17)
							else
								local var_12_18 = Mathf.Lerp(iter_12_4.color.r, 0.5, var_12_14)

								iter_12_4.color = Color.New(var_12_18, var_12_18, var_12_18)
							end
						end
					end
				end
			end

			if arg_9_1.time_ >= var_12_12 + var_12_13 and arg_9_1.time_ < var_12_12 + var_12_13 + arg_12_0 and not isNil(var_12_11) and arg_9_1.var_.actorSpriteComps10015 then
				for iter_12_5, iter_12_6 in pairs(arg_9_1.var_.actorSpriteComps10015:ToTable()) do
					if iter_12_6 then
						if arg_9_1.isInRecall_ then
							iter_12_6.color = arg_9_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_12_6.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_9_1.var_.actorSpriteComps10015 = nil
			end

			local var_12_19 = arg_9_1.actors_["10018"]
			local var_12_20 = 0

			if var_12_20 < arg_9_1.time_ and arg_9_1.time_ <= var_12_20 + arg_12_0 and not isNil(var_12_19) and arg_9_1.var_.actorSpriteComps10018 == nil then
				arg_9_1.var_.actorSpriteComps10018 = var_12_19:GetComponentsInChildren(typeof(Image), true)
			end

			local var_12_21 = 0.034

			if var_12_20 <= arg_9_1.time_ and arg_9_1.time_ < var_12_20 + var_12_21 and not isNil(var_12_19) then
				local var_12_22 = (arg_9_1.time_ - var_12_20) / var_12_21

				if arg_9_1.var_.actorSpriteComps10018 then
					for iter_12_7, iter_12_8 in pairs(arg_9_1.var_.actorSpriteComps10018:ToTable()) do
						if iter_12_8 then
							if arg_9_1.isInRecall_ then
								local var_12_23 = Mathf.Lerp(iter_12_8.color.r, arg_9_1.hightColor1.r, var_12_22)
								local var_12_24 = Mathf.Lerp(iter_12_8.color.g, arg_9_1.hightColor1.g, var_12_22)
								local var_12_25 = Mathf.Lerp(iter_12_8.color.b, arg_9_1.hightColor1.b, var_12_22)

								iter_12_8.color = Color.New(var_12_23, var_12_24, var_12_25)
							else
								local var_12_26 = Mathf.Lerp(iter_12_8.color.r, 1, var_12_22)

								iter_12_8.color = Color.New(var_12_26, var_12_26, var_12_26)
							end
						end
					end
				end
			end

			if arg_9_1.time_ >= var_12_20 + var_12_21 and arg_9_1.time_ < var_12_20 + var_12_21 + arg_12_0 and not isNil(var_12_19) and arg_9_1.var_.actorSpriteComps10018 then
				for iter_12_9, iter_12_10 in pairs(arg_9_1.var_.actorSpriteComps10018:ToTable()) do
					if iter_12_10 then
						if arg_9_1.isInRecall_ then
							iter_12_10.color = arg_9_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_12_10.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_9_1.var_.actorSpriteComps10018 = nil
			end

			local var_12_27 = arg_9_1.actors_["10018"]
			local var_12_28 = 0

			if var_12_28 < arg_9_1.time_ and arg_9_1.time_ <= var_12_28 + arg_12_0 then
				local var_12_29 = var_12_27:GetComponentInChildren(typeof(CanvasGroup))

				if var_12_29 then
					arg_9_1.var_.alphaOldValue10018 = var_12_29.alpha
					arg_9_1.var_.characterEffect10018 = var_12_29
				end

				arg_9_1.var_.alphaOldValue10018 = 0
			end

			local var_12_30 = 0.5

			if var_12_28 <= arg_9_1.time_ and arg_9_1.time_ < var_12_28 + var_12_30 then
				local var_12_31 = (arg_9_1.time_ - var_12_28) / var_12_30
				local var_12_32 = Mathf.Lerp(arg_9_1.var_.alphaOldValue10018, 1, var_12_31)

				if arg_9_1.var_.characterEffect10018 then
					arg_9_1.var_.characterEffect10018.alpha = var_12_32
				end
			end

			if arg_9_1.time_ >= var_12_28 + var_12_30 and arg_9_1.time_ < var_12_28 + var_12_30 + arg_12_0 and arg_9_1.var_.characterEffect10018 then
				arg_9_1.var_.characterEffect10018.alpha = 1
			end

			local var_12_33 = 0
			local var_12_34 = 1.025

			if var_12_33 < arg_9_1.time_ and arg_9_1.time_ <= var_12_33 + arg_12_0 then
				arg_9_1.talkMaxDuration = 0
				arg_9_1.dialogCg_.alpha = 1

				arg_9_1.dialog_:SetActive(true)
				SetActive(arg_9_1.leftNameGo_, true)

				local var_12_35 = arg_9_1:FormatText(StoryNameCfg[36].name)

				arg_9_1.leftNameTxt_.text = var_12_35

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_9_1.leftNameTxt_.transform)

				arg_9_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_9_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_9_1:RecordName(arg_9_1.leftNameTxt_.text)
				SetActive(arg_9_1.iconTrs_.gameObject, false)
				arg_9_1.callingController_:SetSelectedState("normal")

				local var_12_36 = arg_9_1:GetWordFromCfg(114241002)
				local var_12_37 = arg_9_1:FormatText(var_12_36.content)

				arg_9_1.text_.text = var_12_37

				LuaForUtil.ClearLinePrefixSymbol(arg_9_1.text_)

				local var_12_38 = 41
				local var_12_39 = utf8.len(var_12_37)
				local var_12_40 = var_12_38 <= 0 and var_12_34 or var_12_34 * (var_12_39 / var_12_38)

				if var_12_40 > 0 and var_12_34 < var_12_40 then
					arg_9_1.talkMaxDuration = var_12_40

					if var_12_40 + var_12_33 > arg_9_1.duration_ then
						arg_9_1.duration_ = var_12_40 + var_12_33
					end
				end

				arg_9_1.text_.text = var_12_37
				arg_9_1.typewritter.percent = 0

				arg_9_1.typewritter:SetDirty()
				arg_9_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_114241", "114241002", "story_v_out_114241.awb") ~= 0 then
					local var_12_41 = manager.audio:GetVoiceLength("story_v_out_114241", "114241002", "story_v_out_114241.awb") / 1000

					if var_12_41 + var_12_33 > arg_9_1.duration_ then
						arg_9_1.duration_ = var_12_41 + var_12_33
					end

					if var_12_36.prefab_name ~= "" and arg_9_1.actors_[var_12_36.prefab_name] ~= nil then
						local var_12_42 = LuaForUtil.PlayVoiceWithCriLipsync(arg_9_1.actors_[var_12_36.prefab_name].transform, "story_v_out_114241", "114241002", "story_v_out_114241.awb")

						arg_9_1:RecordAudio("114241002", var_12_42)
						arg_9_1:RecordAudio("114241002", var_12_42)
					else
						arg_9_1:AudioAction("play", "voice", "story_v_out_114241", "114241002", "story_v_out_114241.awb")
					end

					arg_9_1:RecordHistoryTalkVoice("story_v_out_114241", "114241002", "story_v_out_114241.awb")
				end

				arg_9_1:RecordContent(arg_9_1.text_.text)
			end

			local var_12_43 = math.max(var_12_34, arg_9_1.talkMaxDuration)

			if var_12_33 <= arg_9_1.time_ and arg_9_1.time_ < var_12_33 + var_12_43 then
				arg_9_1.typewritter.percent = (arg_9_1.time_ - var_12_33) / var_12_43

				arg_9_1.typewritter:SetDirty()
			end

			if arg_9_1.time_ >= var_12_33 + var_12_43 and arg_9_1.time_ < var_12_33 + var_12_43 + arg_12_0 then
				arg_9_1.typewritter.percent = 1

				arg_9_1.typewritter:SetDirty()
				arg_9_1:ShowNextGo(true)
			end
		end

		arg_9_1.nodeConfigList_ = {
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

		arg_9_1:InitPlayNodeList()
	end,
	Play114241003 = function(arg_13_0, arg_13_1)
		arg_13_1.time_ = 0
		arg_13_1.frameCnt_ = 0
		arg_13_1.state_ = "playing"
		arg_13_1.curTalkId_ = 114241003
		arg_13_1.duration_ = 7.1

		local var_13_0 = {
			ja = 7.1,
			ko = 6.133,
			zh = 4.833,
			en = 5.066
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
				arg_13_0:Play114241004(arg_13_1)
			end
		end

		function arg_13_1.onSingleLineUpdate_(arg_16_0)
			local var_16_0 = arg_13_1.actors_["10015"]
			local var_16_1 = 0

			if var_16_1 < arg_13_1.time_ and arg_13_1.time_ <= var_16_1 + arg_16_0 and not isNil(var_16_0) and arg_13_1.var_.actorSpriteComps10015 == nil then
				arg_13_1.var_.actorSpriteComps10015 = var_16_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_16_2 = 0.034

			if var_16_1 <= arg_13_1.time_ and arg_13_1.time_ < var_16_1 + var_16_2 and not isNil(var_16_0) then
				local var_16_3 = (arg_13_1.time_ - var_16_1) / var_16_2

				if arg_13_1.var_.actorSpriteComps10015 then
					for iter_16_0, iter_16_1 in pairs(arg_13_1.var_.actorSpriteComps10015:ToTable()) do
						if iter_16_1 then
							if arg_13_1.isInRecall_ then
								local var_16_4 = Mathf.Lerp(iter_16_1.color.r, arg_13_1.hightColor1.r, var_16_3)
								local var_16_5 = Mathf.Lerp(iter_16_1.color.g, arg_13_1.hightColor1.g, var_16_3)
								local var_16_6 = Mathf.Lerp(iter_16_1.color.b, arg_13_1.hightColor1.b, var_16_3)

								iter_16_1.color = Color.New(var_16_4, var_16_5, var_16_6)
							else
								local var_16_7 = Mathf.Lerp(iter_16_1.color.r, 1, var_16_3)

								iter_16_1.color = Color.New(var_16_7, var_16_7, var_16_7)
							end
						end
					end
				end
			end

			if arg_13_1.time_ >= var_16_1 + var_16_2 and arg_13_1.time_ < var_16_1 + var_16_2 + arg_16_0 and not isNil(var_16_0) and arg_13_1.var_.actorSpriteComps10015 then
				for iter_16_2, iter_16_3 in pairs(arg_13_1.var_.actorSpriteComps10015:ToTable()) do
					if iter_16_3 then
						if arg_13_1.isInRecall_ then
							iter_16_3.color = arg_13_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_16_3.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_13_1.var_.actorSpriteComps10015 = nil
			end

			local var_16_8 = arg_13_1.actors_["10018"]
			local var_16_9 = 0

			if var_16_9 < arg_13_1.time_ and arg_13_1.time_ <= var_16_9 + arg_16_0 and not isNil(var_16_8) and arg_13_1.var_.actorSpriteComps10018 == nil then
				arg_13_1.var_.actorSpriteComps10018 = var_16_8:GetComponentsInChildren(typeof(Image), true)
			end

			local var_16_10 = 0.034

			if var_16_9 <= arg_13_1.time_ and arg_13_1.time_ < var_16_9 + var_16_10 and not isNil(var_16_8) then
				local var_16_11 = (arg_13_1.time_ - var_16_9) / var_16_10

				if arg_13_1.var_.actorSpriteComps10018 then
					for iter_16_4, iter_16_5 in pairs(arg_13_1.var_.actorSpriteComps10018:ToTable()) do
						if iter_16_5 then
							if arg_13_1.isInRecall_ then
								local var_16_12 = Mathf.Lerp(iter_16_5.color.r, arg_13_1.hightColor2.r, var_16_11)
								local var_16_13 = Mathf.Lerp(iter_16_5.color.g, arg_13_1.hightColor2.g, var_16_11)
								local var_16_14 = Mathf.Lerp(iter_16_5.color.b, arg_13_1.hightColor2.b, var_16_11)

								iter_16_5.color = Color.New(var_16_12, var_16_13, var_16_14)
							else
								local var_16_15 = Mathf.Lerp(iter_16_5.color.r, 0.5, var_16_11)

								iter_16_5.color = Color.New(var_16_15, var_16_15, var_16_15)
							end
						end
					end
				end
			end

			if arg_13_1.time_ >= var_16_9 + var_16_10 and arg_13_1.time_ < var_16_9 + var_16_10 + arg_16_0 and not isNil(var_16_8) and arg_13_1.var_.actorSpriteComps10018 then
				for iter_16_6, iter_16_7 in pairs(arg_13_1.var_.actorSpriteComps10018:ToTable()) do
					if iter_16_7 then
						if arg_13_1.isInRecall_ then
							iter_16_7.color = arg_13_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_16_7.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_13_1.var_.actorSpriteComps10018 = nil
			end

			local var_16_16 = 0
			local var_16_17 = 0.625

			if var_16_16 < arg_13_1.time_ and arg_13_1.time_ <= var_16_16 + arg_16_0 then
				arg_13_1.talkMaxDuration = 0
				arg_13_1.dialogCg_.alpha = 1

				arg_13_1.dialog_:SetActive(true)
				SetActive(arg_13_1.leftNameGo_, true)

				local var_16_18 = arg_13_1:FormatText(StoryNameCfg[208].name)

				arg_13_1.leftNameTxt_.text = var_16_18

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_13_1.leftNameTxt_.transform)

				arg_13_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_13_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_13_1:RecordName(arg_13_1.leftNameTxt_.text)
				SetActive(arg_13_1.iconTrs_.gameObject, false)
				arg_13_1.callingController_:SetSelectedState("normal")

				local var_16_19 = arg_13_1:GetWordFromCfg(114241003)
				local var_16_20 = arg_13_1:FormatText(var_16_19.content)

				arg_13_1.text_.text = var_16_20

				LuaForUtil.ClearLinePrefixSymbol(arg_13_1.text_)

				local var_16_21 = 25
				local var_16_22 = utf8.len(var_16_20)
				local var_16_23 = var_16_21 <= 0 and var_16_17 or var_16_17 * (var_16_22 / var_16_21)

				if var_16_23 > 0 and var_16_17 < var_16_23 then
					arg_13_1.talkMaxDuration = var_16_23

					if var_16_23 + var_16_16 > arg_13_1.duration_ then
						arg_13_1.duration_ = var_16_23 + var_16_16
					end
				end

				arg_13_1.text_.text = var_16_20
				arg_13_1.typewritter.percent = 0

				arg_13_1.typewritter:SetDirty()
				arg_13_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_114241", "114241003", "story_v_out_114241.awb") ~= 0 then
					local var_16_24 = manager.audio:GetVoiceLength("story_v_out_114241", "114241003", "story_v_out_114241.awb") / 1000

					if var_16_24 + var_16_16 > arg_13_1.duration_ then
						arg_13_1.duration_ = var_16_24 + var_16_16
					end

					if var_16_19.prefab_name ~= "" and arg_13_1.actors_[var_16_19.prefab_name] ~= nil then
						local var_16_25 = LuaForUtil.PlayVoiceWithCriLipsync(arg_13_1.actors_[var_16_19.prefab_name].transform, "story_v_out_114241", "114241003", "story_v_out_114241.awb")

						arg_13_1:RecordAudio("114241003", var_16_25)
						arg_13_1:RecordAudio("114241003", var_16_25)
					else
						arg_13_1:AudioAction("play", "voice", "story_v_out_114241", "114241003", "story_v_out_114241.awb")
					end

					arg_13_1:RecordHistoryTalkVoice("story_v_out_114241", "114241003", "story_v_out_114241.awb")
				end

				arg_13_1:RecordContent(arg_13_1.text_.text)
			end

			local var_16_26 = math.max(var_16_17, arg_13_1.talkMaxDuration)

			if var_16_16 <= arg_13_1.time_ and arg_13_1.time_ < var_16_16 + var_16_26 then
				arg_13_1.typewritter.percent = (arg_13_1.time_ - var_16_16) / var_16_26

				arg_13_1.typewritter:SetDirty()
			end

			if arg_13_1.time_ >= var_16_16 + var_16_26 and arg_13_1.time_ < var_16_16 + var_16_26 + arg_16_0 then
				arg_13_1.typewritter.percent = 1

				arg_13_1.typewritter:SetDirty()
				arg_13_1:ShowNextGo(true)
			end
		end

		arg_13_1.nodeConfigList_ = {}

		arg_13_1:InitPlayNodeList()
	end,
	Play114241004 = function(arg_17_0, arg_17_1)
		arg_17_1.time_ = 0
		arg_17_1.frameCnt_ = 0
		arg_17_1.state_ = "playing"
		arg_17_1.curTalkId_ = 114241004
		arg_17_1.duration_ = 6.9

		local var_17_0 = {
			ja = 6.9,
			ko = 3.166,
			zh = 4.266,
			en = 4.3
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
				arg_17_0:Play114241005(arg_17_1)
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

			local var_20_8 = arg_17_1.actors_["10018"]
			local var_20_9 = 0

			if var_20_9 < arg_17_1.time_ and arg_17_1.time_ <= var_20_9 + arg_20_0 and not isNil(var_20_8) and arg_17_1.var_.actorSpriteComps10018 == nil then
				arg_17_1.var_.actorSpriteComps10018 = var_20_8:GetComponentsInChildren(typeof(Image), true)
			end

			local var_20_10 = 0.034

			if var_20_9 <= arg_17_1.time_ and arg_17_1.time_ < var_20_9 + var_20_10 and not isNil(var_20_8) then
				local var_20_11 = (arg_17_1.time_ - var_20_9) / var_20_10

				if arg_17_1.var_.actorSpriteComps10018 then
					for iter_20_4, iter_20_5 in pairs(arg_17_1.var_.actorSpriteComps10018:ToTable()) do
						if iter_20_5 then
							if arg_17_1.isInRecall_ then
								local var_20_12 = Mathf.Lerp(iter_20_5.color.r, arg_17_1.hightColor1.r, var_20_11)
								local var_20_13 = Mathf.Lerp(iter_20_5.color.g, arg_17_1.hightColor1.g, var_20_11)
								local var_20_14 = Mathf.Lerp(iter_20_5.color.b, arg_17_1.hightColor1.b, var_20_11)

								iter_20_5.color = Color.New(var_20_12, var_20_13, var_20_14)
							else
								local var_20_15 = Mathf.Lerp(iter_20_5.color.r, 1, var_20_11)

								iter_20_5.color = Color.New(var_20_15, var_20_15, var_20_15)
							end
						end
					end
				end
			end

			if arg_17_1.time_ >= var_20_9 + var_20_10 and arg_17_1.time_ < var_20_9 + var_20_10 + arg_20_0 and not isNil(var_20_8) and arg_17_1.var_.actorSpriteComps10018 then
				for iter_20_6, iter_20_7 in pairs(arg_17_1.var_.actorSpriteComps10018:ToTable()) do
					if iter_20_7 then
						if arg_17_1.isInRecall_ then
							iter_20_7.color = arg_17_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_20_7.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_17_1.var_.actorSpriteComps10018 = nil
			end

			local var_20_16 = 0
			local var_20_17 = 0.3

			if var_20_16 < arg_17_1.time_ and arg_17_1.time_ <= var_20_16 + arg_20_0 then
				arg_17_1.talkMaxDuration = 0
				arg_17_1.dialogCg_.alpha = 1

				arg_17_1.dialog_:SetActive(true)
				SetActive(arg_17_1.leftNameGo_, true)

				local var_20_18 = arg_17_1:FormatText(StoryNameCfg[257].name)

				arg_17_1.leftNameTxt_.text = var_20_18

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_17_1.leftNameTxt_.transform)

				arg_17_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_17_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_17_1:RecordName(arg_17_1.leftNameTxt_.text)
				SetActive(arg_17_1.iconTrs_.gameObject, false)
				arg_17_1.callingController_:SetSelectedState("normal")

				local var_20_19 = arg_17_1:GetWordFromCfg(114241004)
				local var_20_20 = arg_17_1:FormatText(var_20_19.content)

				arg_17_1.text_.text = var_20_20

				LuaForUtil.ClearLinePrefixSymbol(arg_17_1.text_)

				local var_20_21 = 12
				local var_20_22 = utf8.len(var_20_20)
				local var_20_23 = var_20_21 <= 0 and var_20_17 or var_20_17 * (var_20_22 / var_20_21)

				if var_20_23 > 0 and var_20_17 < var_20_23 then
					arg_17_1.talkMaxDuration = var_20_23

					if var_20_23 + var_20_16 > arg_17_1.duration_ then
						arg_17_1.duration_ = var_20_23 + var_20_16
					end
				end

				arg_17_1.text_.text = var_20_20
				arg_17_1.typewritter.percent = 0

				arg_17_1.typewritter:SetDirty()
				arg_17_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_114241", "114241004", "story_v_out_114241.awb") ~= 0 then
					local var_20_24 = manager.audio:GetVoiceLength("story_v_out_114241", "114241004", "story_v_out_114241.awb") / 1000

					if var_20_24 + var_20_16 > arg_17_1.duration_ then
						arg_17_1.duration_ = var_20_24 + var_20_16
					end

					if var_20_19.prefab_name ~= "" and arg_17_1.actors_[var_20_19.prefab_name] ~= nil then
						local var_20_25 = LuaForUtil.PlayVoiceWithCriLipsync(arg_17_1.actors_[var_20_19.prefab_name].transform, "story_v_out_114241", "114241004", "story_v_out_114241.awb")

						arg_17_1:RecordAudio("114241004", var_20_25)
						arg_17_1:RecordAudio("114241004", var_20_25)
					else
						arg_17_1:AudioAction("play", "voice", "story_v_out_114241", "114241004", "story_v_out_114241.awb")
					end

					arg_17_1:RecordHistoryTalkVoice("story_v_out_114241", "114241004", "story_v_out_114241.awb")
				end

				arg_17_1:RecordContent(arg_17_1.text_.text)
			end

			local var_20_26 = math.max(var_20_17, arg_17_1.talkMaxDuration)

			if var_20_16 <= arg_17_1.time_ and arg_17_1.time_ < var_20_16 + var_20_26 then
				arg_17_1.typewritter.percent = (arg_17_1.time_ - var_20_16) / var_20_26

				arg_17_1.typewritter:SetDirty()
			end

			if arg_17_1.time_ >= var_20_16 + var_20_26 and arg_17_1.time_ < var_20_16 + var_20_26 + arg_20_0 then
				arg_17_1.typewritter.percent = 1

				arg_17_1.typewritter:SetDirty()
				arg_17_1:ShowNextGo(true)
			end
		end

		arg_17_1.nodeConfigList_ = {}

		arg_17_1:InitPlayNodeList()
	end,
	Play114241005 = function(arg_21_0, arg_21_1)
		arg_21_1.time_ = 0
		arg_21_1.frameCnt_ = 0
		arg_21_1.state_ = "playing"
		arg_21_1.curTalkId_ = 114241005
		arg_21_1.duration_ = 8.4

		local var_21_0 = {
			ja = 8.4,
			ko = 7.866,
			zh = 7.833,
			en = 8.3
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
				arg_21_0:Play114241006(arg_21_1)
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

			if arg_21_1.time_ >= var_24_1 + var_24_2 and arg_21_1.time_ < var_24_1 + var_24_2 + arg_24_0 and not isNil(var_24_0) and arg_21_1.var_.actorSpriteComps10015 then
				for iter_24_2, iter_24_3 in pairs(arg_21_1.var_.actorSpriteComps10015:ToTable()) do
					if iter_24_3 then
						if arg_21_1.isInRecall_ then
							iter_24_3.color = arg_21_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_24_3.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_21_1.var_.actorSpriteComps10015 = nil
			end

			local var_24_8 = arg_21_1.actors_["10018"]
			local var_24_9 = 0

			if var_24_9 < arg_21_1.time_ and arg_21_1.time_ <= var_24_9 + arg_24_0 and not isNil(var_24_8) and arg_21_1.var_.actorSpriteComps10018 == nil then
				arg_21_1.var_.actorSpriteComps10018 = var_24_8:GetComponentsInChildren(typeof(Image), true)
			end

			local var_24_10 = 0.034

			if var_24_9 <= arg_21_1.time_ and arg_21_1.time_ < var_24_9 + var_24_10 and not isNil(var_24_8) then
				local var_24_11 = (arg_21_1.time_ - var_24_9) / var_24_10

				if arg_21_1.var_.actorSpriteComps10018 then
					for iter_24_4, iter_24_5 in pairs(arg_21_1.var_.actorSpriteComps10018:ToTable()) do
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

			if arg_21_1.time_ >= var_24_9 + var_24_10 and arg_21_1.time_ < var_24_9 + var_24_10 + arg_24_0 and not isNil(var_24_8) and arg_21_1.var_.actorSpriteComps10018 then
				for iter_24_6, iter_24_7 in pairs(arg_21_1.var_.actorSpriteComps10018:ToTable()) do
					if iter_24_7 then
						if arg_21_1.isInRecall_ then
							iter_24_7.color = arg_21_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_24_7.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_21_1.var_.actorSpriteComps10018 = nil
			end

			local var_24_16 = 0
			local var_24_17 = 0.675

			if var_24_16 < arg_21_1.time_ and arg_21_1.time_ <= var_24_16 + arg_24_0 then
				arg_21_1.talkMaxDuration = 0
				arg_21_1.dialogCg_.alpha = 1

				arg_21_1.dialog_:SetActive(true)
				SetActive(arg_21_1.leftNameGo_, true)

				local var_24_18 = arg_21_1:FormatText(StoryNameCfg[208].name)

				arg_21_1.leftNameTxt_.text = var_24_18

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_21_1.leftNameTxt_.transform)

				arg_21_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_21_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_21_1:RecordName(arg_21_1.leftNameTxt_.text)
				SetActive(arg_21_1.iconTrs_.gameObject, false)
				arg_21_1.callingController_:SetSelectedState("normal")

				local var_24_19 = arg_21_1:GetWordFromCfg(114241005)
				local var_24_20 = arg_21_1:FormatText(var_24_19.content)

				arg_21_1.text_.text = var_24_20

				LuaForUtil.ClearLinePrefixSymbol(arg_21_1.text_)

				local var_24_21 = 27
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

				if manager.audio:GetVoiceLength("story_v_out_114241", "114241005", "story_v_out_114241.awb") ~= 0 then
					local var_24_24 = manager.audio:GetVoiceLength("story_v_out_114241", "114241005", "story_v_out_114241.awb") / 1000

					if var_24_24 + var_24_16 > arg_21_1.duration_ then
						arg_21_1.duration_ = var_24_24 + var_24_16
					end

					if var_24_19.prefab_name ~= "" and arg_21_1.actors_[var_24_19.prefab_name] ~= nil then
						local var_24_25 = LuaForUtil.PlayVoiceWithCriLipsync(arg_21_1.actors_[var_24_19.prefab_name].transform, "story_v_out_114241", "114241005", "story_v_out_114241.awb")

						arg_21_1:RecordAudio("114241005", var_24_25)
						arg_21_1:RecordAudio("114241005", var_24_25)
					else
						arg_21_1:AudioAction("play", "voice", "story_v_out_114241", "114241005", "story_v_out_114241.awb")
					end

					arg_21_1:RecordHistoryTalkVoice("story_v_out_114241", "114241005", "story_v_out_114241.awb")
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
	Play114241006 = function(arg_25_0, arg_25_1)
		arg_25_1.time_ = 0
		arg_25_1.frameCnt_ = 0
		arg_25_1.state_ = "playing"
		arg_25_1.curTalkId_ = 114241006
		arg_25_1.duration_ = 12.23

		local var_25_0 = {
			ja = 12.233,
			ko = 6.866,
			zh = 6.266,
			en = 5.9
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
				arg_25_0:Play114241007(arg_25_1)
			end
		end

		function arg_25_1.onSingleLineUpdate_(arg_28_0)
			local var_28_0 = 0
			local var_28_1 = 0.8

			if var_28_0 < arg_25_1.time_ and arg_25_1.time_ <= var_28_0 + arg_28_0 then
				arg_25_1.talkMaxDuration = 0
				arg_25_1.dialogCg_.alpha = 1

				arg_25_1.dialog_:SetActive(true)
				SetActive(arg_25_1.leftNameGo_, true)

				local var_28_2 = arg_25_1:FormatText(StoryNameCfg[208].name)

				arg_25_1.leftNameTxt_.text = var_28_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_25_1.leftNameTxt_.transform)

				arg_25_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_25_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_25_1:RecordName(arg_25_1.leftNameTxt_.text)
				SetActive(arg_25_1.iconTrs_.gameObject, false)
				arg_25_1.callingController_:SetSelectedState("normal")

				local var_28_3 = arg_25_1:GetWordFromCfg(114241006)
				local var_28_4 = arg_25_1:FormatText(var_28_3.content)

				arg_25_1.text_.text = var_28_4

				LuaForUtil.ClearLinePrefixSymbol(arg_25_1.text_)

				local var_28_5 = 31
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

				if manager.audio:GetVoiceLength("story_v_out_114241", "114241006", "story_v_out_114241.awb") ~= 0 then
					local var_28_8 = manager.audio:GetVoiceLength("story_v_out_114241", "114241006", "story_v_out_114241.awb") / 1000

					if var_28_8 + var_28_0 > arg_25_1.duration_ then
						arg_25_1.duration_ = var_28_8 + var_28_0
					end

					if var_28_3.prefab_name ~= "" and arg_25_1.actors_[var_28_3.prefab_name] ~= nil then
						local var_28_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_25_1.actors_[var_28_3.prefab_name].transform, "story_v_out_114241", "114241006", "story_v_out_114241.awb")

						arg_25_1:RecordAudio("114241006", var_28_9)
						arg_25_1:RecordAudio("114241006", var_28_9)
					else
						arg_25_1:AudioAction("play", "voice", "story_v_out_114241", "114241006", "story_v_out_114241.awb")
					end

					arg_25_1:RecordHistoryTalkVoice("story_v_out_114241", "114241006", "story_v_out_114241.awb")
				end

				arg_25_1:RecordContent(arg_25_1.text_.text)
			end

			local var_28_10 = math.max(var_28_1, arg_25_1.talkMaxDuration)

			if var_28_0 <= arg_25_1.time_ and arg_25_1.time_ < var_28_0 + var_28_10 then
				arg_25_1.typewritter.percent = (arg_25_1.time_ - var_28_0) / var_28_10

				arg_25_1.typewritter:SetDirty()
			end

			if arg_25_1.time_ >= var_28_0 + var_28_10 and arg_25_1.time_ < var_28_0 + var_28_10 + arg_28_0 then
				arg_25_1.typewritter.percent = 1

				arg_25_1.typewritter:SetDirty()
				arg_25_1:ShowNextGo(true)
			end
		end

		arg_25_1.nodeConfigList_ = {}

		arg_25_1:InitPlayNodeList()
	end,
	Play114241007 = function(arg_29_0, arg_29_1)
		arg_29_1.time_ = 0
		arg_29_1.frameCnt_ = 0
		arg_29_1.state_ = "playing"
		arg_29_1.curTalkId_ = 114241007
		arg_29_1.duration_ = 8.57

		local var_29_0 = {
			ja = 8.233,
			ko = 5.833,
			zh = 7.466,
			en = 8.566
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
				arg_29_0:Play114241008(arg_29_1)
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

			local var_32_8 = arg_29_1.actors_["10018"]
			local var_32_9 = 0

			if var_32_9 < arg_29_1.time_ and arg_29_1.time_ <= var_32_9 + arg_32_0 and not isNil(var_32_8) and arg_29_1.var_.actorSpriteComps10018 == nil then
				arg_29_1.var_.actorSpriteComps10018 = var_32_8:GetComponentsInChildren(typeof(Image), true)
			end

			local var_32_10 = 0.034

			if var_32_9 <= arg_29_1.time_ and arg_29_1.time_ < var_32_9 + var_32_10 and not isNil(var_32_8) then
				local var_32_11 = (arg_29_1.time_ - var_32_9) / var_32_10

				if arg_29_1.var_.actorSpriteComps10018 then
					for iter_32_4, iter_32_5 in pairs(arg_29_1.var_.actorSpriteComps10018:ToTable()) do
						if iter_32_5 then
							if arg_29_1.isInRecall_ then
								local var_32_12 = Mathf.Lerp(iter_32_5.color.r, arg_29_1.hightColor1.r, var_32_11)
								local var_32_13 = Mathf.Lerp(iter_32_5.color.g, arg_29_1.hightColor1.g, var_32_11)
								local var_32_14 = Mathf.Lerp(iter_32_5.color.b, arg_29_1.hightColor1.b, var_32_11)

								iter_32_5.color = Color.New(var_32_12, var_32_13, var_32_14)
							else
								local var_32_15 = Mathf.Lerp(iter_32_5.color.r, 1, var_32_11)

								iter_32_5.color = Color.New(var_32_15, var_32_15, var_32_15)
							end
						end
					end
				end
			end

			if arg_29_1.time_ >= var_32_9 + var_32_10 and arg_29_1.time_ < var_32_9 + var_32_10 + arg_32_0 and not isNil(var_32_8) and arg_29_1.var_.actorSpriteComps10018 then
				for iter_32_6, iter_32_7 in pairs(arg_29_1.var_.actorSpriteComps10018:ToTable()) do
					if iter_32_7 then
						if arg_29_1.isInRecall_ then
							iter_32_7.color = arg_29_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_32_7.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_29_1.var_.actorSpriteComps10018 = nil
			end

			local var_32_16 = 0
			local var_32_17 = 0.65

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

				local var_32_19 = arg_29_1:GetWordFromCfg(114241007)
				local var_32_20 = arg_29_1:FormatText(var_32_19.content)

				arg_29_1.text_.text = var_32_20

				LuaForUtil.ClearLinePrefixSymbol(arg_29_1.text_)

				local var_32_21 = 26
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

				if manager.audio:GetVoiceLength("story_v_out_114241", "114241007", "story_v_out_114241.awb") ~= 0 then
					local var_32_24 = manager.audio:GetVoiceLength("story_v_out_114241", "114241007", "story_v_out_114241.awb") / 1000

					if var_32_24 + var_32_16 > arg_29_1.duration_ then
						arg_29_1.duration_ = var_32_24 + var_32_16
					end

					if var_32_19.prefab_name ~= "" and arg_29_1.actors_[var_32_19.prefab_name] ~= nil then
						local var_32_25 = LuaForUtil.PlayVoiceWithCriLipsync(arg_29_1.actors_[var_32_19.prefab_name].transform, "story_v_out_114241", "114241007", "story_v_out_114241.awb")

						arg_29_1:RecordAudio("114241007", var_32_25)
						arg_29_1:RecordAudio("114241007", var_32_25)
					else
						arg_29_1:AudioAction("play", "voice", "story_v_out_114241", "114241007", "story_v_out_114241.awb")
					end

					arg_29_1:RecordHistoryTalkVoice("story_v_out_114241", "114241007", "story_v_out_114241.awb")
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
	Play114241008 = function(arg_33_0, arg_33_1)
		arg_33_1.time_ = 0
		arg_33_1.frameCnt_ = 0
		arg_33_1.state_ = "playing"
		arg_33_1.curTalkId_ = 114241008
		arg_33_1.duration_ = 10.27

		local var_33_0 = {
			ja = 10.266,
			ko = 7.133,
			zh = 6.4,
			en = 5.533
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
				arg_33_0:Play114241009(arg_33_1)
			end
		end

		function arg_33_1.onSingleLineUpdate_(arg_36_0)
			local var_36_0 = arg_33_1.actors_["10015"]
			local var_36_1 = 0

			if var_36_1 < arg_33_1.time_ and arg_33_1.time_ <= var_36_1 + arg_36_0 and not isNil(var_36_0) and arg_33_1.var_.actorSpriteComps10015 == nil then
				arg_33_1.var_.actorSpriteComps10015 = var_36_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_36_2 = 0.034

			if var_36_1 <= arg_33_1.time_ and arg_33_1.time_ < var_36_1 + var_36_2 and not isNil(var_36_0) then
				local var_36_3 = (arg_33_1.time_ - var_36_1) / var_36_2

				if arg_33_1.var_.actorSpriteComps10015 then
					for iter_36_0, iter_36_1 in pairs(arg_33_1.var_.actorSpriteComps10015:ToTable()) do
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

			if arg_33_1.time_ >= var_36_1 + var_36_2 and arg_33_1.time_ < var_36_1 + var_36_2 + arg_36_0 and not isNil(var_36_0) and arg_33_1.var_.actorSpriteComps10015 then
				for iter_36_2, iter_36_3 in pairs(arg_33_1.var_.actorSpriteComps10015:ToTable()) do
					if iter_36_3 then
						if arg_33_1.isInRecall_ then
							iter_36_3.color = arg_33_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_36_3.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_33_1.var_.actorSpriteComps10015 = nil
			end

			local var_36_8 = arg_33_1.actors_["10018"]
			local var_36_9 = 0

			if var_36_9 < arg_33_1.time_ and arg_33_1.time_ <= var_36_9 + arg_36_0 and not isNil(var_36_8) and arg_33_1.var_.actorSpriteComps10018 == nil then
				arg_33_1.var_.actorSpriteComps10018 = var_36_8:GetComponentsInChildren(typeof(Image), true)
			end

			local var_36_10 = 0.034

			if var_36_9 <= arg_33_1.time_ and arg_33_1.time_ < var_36_9 + var_36_10 and not isNil(var_36_8) then
				local var_36_11 = (arg_33_1.time_ - var_36_9) / var_36_10

				if arg_33_1.var_.actorSpriteComps10018 then
					for iter_36_4, iter_36_5 in pairs(arg_33_1.var_.actorSpriteComps10018:ToTable()) do
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

			if arg_33_1.time_ >= var_36_9 + var_36_10 and arg_33_1.time_ < var_36_9 + var_36_10 + arg_36_0 and not isNil(var_36_8) and arg_33_1.var_.actorSpriteComps10018 then
				for iter_36_6, iter_36_7 in pairs(arg_33_1.var_.actorSpriteComps10018:ToTable()) do
					if iter_36_7 then
						if arg_33_1.isInRecall_ then
							iter_36_7.color = arg_33_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_36_7.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_33_1.var_.actorSpriteComps10018 = nil
			end

			local var_36_16 = 0
			local var_36_17 = 0.725

			if var_36_16 < arg_33_1.time_ and arg_33_1.time_ <= var_36_16 + arg_36_0 then
				arg_33_1.talkMaxDuration = 0
				arg_33_1.dialogCg_.alpha = 1

				arg_33_1.dialog_:SetActive(true)
				SetActive(arg_33_1.leftNameGo_, true)

				local var_36_18 = arg_33_1:FormatText(StoryNameCfg[208].name)

				arg_33_1.leftNameTxt_.text = var_36_18

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_33_1.leftNameTxt_.transform)

				arg_33_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_33_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_33_1:RecordName(arg_33_1.leftNameTxt_.text)
				SetActive(arg_33_1.iconTrs_.gameObject, false)
				arg_33_1.callingController_:SetSelectedState("normal")

				local var_36_19 = arg_33_1:GetWordFromCfg(114241008)
				local var_36_20 = arg_33_1:FormatText(var_36_19.content)

				arg_33_1.text_.text = var_36_20

				LuaForUtil.ClearLinePrefixSymbol(arg_33_1.text_)

				local var_36_21 = 29
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

				if manager.audio:GetVoiceLength("story_v_out_114241", "114241008", "story_v_out_114241.awb") ~= 0 then
					local var_36_24 = manager.audio:GetVoiceLength("story_v_out_114241", "114241008", "story_v_out_114241.awb") / 1000

					if var_36_24 + var_36_16 > arg_33_1.duration_ then
						arg_33_1.duration_ = var_36_24 + var_36_16
					end

					if var_36_19.prefab_name ~= "" and arg_33_1.actors_[var_36_19.prefab_name] ~= nil then
						local var_36_25 = LuaForUtil.PlayVoiceWithCriLipsync(arg_33_1.actors_[var_36_19.prefab_name].transform, "story_v_out_114241", "114241008", "story_v_out_114241.awb")

						arg_33_1:RecordAudio("114241008", var_36_25)
						arg_33_1:RecordAudio("114241008", var_36_25)
					else
						arg_33_1:AudioAction("play", "voice", "story_v_out_114241", "114241008", "story_v_out_114241.awb")
					end

					arg_33_1:RecordHistoryTalkVoice("story_v_out_114241", "114241008", "story_v_out_114241.awb")
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
	Play114241009 = function(arg_37_0, arg_37_1)
		arg_37_1.time_ = 0
		arg_37_1.frameCnt_ = 0
		arg_37_1.state_ = "playing"
		arg_37_1.curTalkId_ = 114241009
		arg_37_1.duration_ = 11.13

		local var_37_0 = {
			ja = 8.733,
			ko = 10.633,
			zh = 8.666,
			en = 11.133
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
				arg_37_0:Play114241010(arg_37_1)
			end
		end

		function arg_37_1.onSingleLineUpdate_(arg_40_0)
			local var_40_0 = arg_37_1.actors_["10015"]
			local var_40_1 = 0

			if var_40_1 < arg_37_1.time_ and arg_37_1.time_ <= var_40_1 + arg_40_0 and not isNil(var_40_0) and arg_37_1.var_.actorSpriteComps10015 == nil then
				arg_37_1.var_.actorSpriteComps10015 = var_40_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_40_2 = 0.034

			if var_40_1 <= arg_37_1.time_ and arg_37_1.time_ < var_40_1 + var_40_2 and not isNil(var_40_0) then
				local var_40_3 = (arg_37_1.time_ - var_40_1) / var_40_2

				if arg_37_1.var_.actorSpriteComps10015 then
					for iter_40_0, iter_40_1 in pairs(arg_37_1.var_.actorSpriteComps10015:ToTable()) do
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

			if arg_37_1.time_ >= var_40_1 + var_40_2 and arg_37_1.time_ < var_40_1 + var_40_2 + arg_40_0 and not isNil(var_40_0) and arg_37_1.var_.actorSpriteComps10015 then
				for iter_40_2, iter_40_3 in pairs(arg_37_1.var_.actorSpriteComps10015:ToTable()) do
					if iter_40_3 then
						if arg_37_1.isInRecall_ then
							iter_40_3.color = arg_37_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_40_3.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_37_1.var_.actorSpriteComps10015 = nil
			end

			local var_40_8 = arg_37_1.actors_["10018"]
			local var_40_9 = 0

			if var_40_9 < arg_37_1.time_ and arg_37_1.time_ <= var_40_9 + arg_40_0 and not isNil(var_40_8) and arg_37_1.var_.actorSpriteComps10018 == nil then
				arg_37_1.var_.actorSpriteComps10018 = var_40_8:GetComponentsInChildren(typeof(Image), true)
			end

			local var_40_10 = 0.034

			if var_40_9 <= arg_37_1.time_ and arg_37_1.time_ < var_40_9 + var_40_10 and not isNil(var_40_8) then
				local var_40_11 = (arg_37_1.time_ - var_40_9) / var_40_10

				if arg_37_1.var_.actorSpriteComps10018 then
					for iter_40_4, iter_40_5 in pairs(arg_37_1.var_.actorSpriteComps10018:ToTable()) do
						if iter_40_5 then
							if arg_37_1.isInRecall_ then
								local var_40_12 = Mathf.Lerp(iter_40_5.color.r, arg_37_1.hightColor1.r, var_40_11)
								local var_40_13 = Mathf.Lerp(iter_40_5.color.g, arg_37_1.hightColor1.g, var_40_11)
								local var_40_14 = Mathf.Lerp(iter_40_5.color.b, arg_37_1.hightColor1.b, var_40_11)

								iter_40_5.color = Color.New(var_40_12, var_40_13, var_40_14)
							else
								local var_40_15 = Mathf.Lerp(iter_40_5.color.r, 1, var_40_11)

								iter_40_5.color = Color.New(var_40_15, var_40_15, var_40_15)
							end
						end
					end
				end
			end

			if arg_37_1.time_ >= var_40_9 + var_40_10 and arg_37_1.time_ < var_40_9 + var_40_10 + arg_40_0 and not isNil(var_40_8) and arg_37_1.var_.actorSpriteComps10018 then
				for iter_40_6, iter_40_7 in pairs(arg_37_1.var_.actorSpriteComps10018:ToTable()) do
					if iter_40_7 then
						if arg_37_1.isInRecall_ then
							iter_40_7.color = arg_37_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_40_7.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_37_1.var_.actorSpriteComps10018 = nil
			end

			local var_40_16 = 0
			local var_40_17 = 0.925

			if var_40_16 < arg_37_1.time_ and arg_37_1.time_ <= var_40_16 + arg_40_0 then
				arg_37_1.talkMaxDuration = 0
				arg_37_1.dialogCg_.alpha = 1

				arg_37_1.dialog_:SetActive(true)
				SetActive(arg_37_1.leftNameGo_, true)

				local var_40_18 = arg_37_1:FormatText(StoryNameCfg[257].name)

				arg_37_1.leftNameTxt_.text = var_40_18

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_37_1.leftNameTxt_.transform)

				arg_37_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_37_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_37_1:RecordName(arg_37_1.leftNameTxt_.text)
				SetActive(arg_37_1.iconTrs_.gameObject, false)
				arg_37_1.callingController_:SetSelectedState("normal")

				local var_40_19 = arg_37_1:GetWordFromCfg(114241009)
				local var_40_20 = arg_37_1:FormatText(var_40_19.content)

				arg_37_1.text_.text = var_40_20

				LuaForUtil.ClearLinePrefixSymbol(arg_37_1.text_)

				local var_40_21 = 37
				local var_40_22 = utf8.len(var_40_20)
				local var_40_23 = var_40_21 <= 0 and var_40_17 or var_40_17 * (var_40_22 / var_40_21)

				if var_40_23 > 0 and var_40_17 < var_40_23 then
					arg_37_1.talkMaxDuration = var_40_23

					if var_40_23 + var_40_16 > arg_37_1.duration_ then
						arg_37_1.duration_ = var_40_23 + var_40_16
					end
				end

				arg_37_1.text_.text = var_40_20
				arg_37_1.typewritter.percent = 0

				arg_37_1.typewritter:SetDirty()
				arg_37_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_114241", "114241009", "story_v_out_114241.awb") ~= 0 then
					local var_40_24 = manager.audio:GetVoiceLength("story_v_out_114241", "114241009", "story_v_out_114241.awb") / 1000

					if var_40_24 + var_40_16 > arg_37_1.duration_ then
						arg_37_1.duration_ = var_40_24 + var_40_16
					end

					if var_40_19.prefab_name ~= "" and arg_37_1.actors_[var_40_19.prefab_name] ~= nil then
						local var_40_25 = LuaForUtil.PlayVoiceWithCriLipsync(arg_37_1.actors_[var_40_19.prefab_name].transform, "story_v_out_114241", "114241009", "story_v_out_114241.awb")

						arg_37_1:RecordAudio("114241009", var_40_25)
						arg_37_1:RecordAudio("114241009", var_40_25)
					else
						arg_37_1:AudioAction("play", "voice", "story_v_out_114241", "114241009", "story_v_out_114241.awb")
					end

					arg_37_1:RecordHistoryTalkVoice("story_v_out_114241", "114241009", "story_v_out_114241.awb")
				end

				arg_37_1:RecordContent(arg_37_1.text_.text)
			end

			local var_40_26 = math.max(var_40_17, arg_37_1.talkMaxDuration)

			if var_40_16 <= arg_37_1.time_ and arg_37_1.time_ < var_40_16 + var_40_26 then
				arg_37_1.typewritter.percent = (arg_37_1.time_ - var_40_16) / var_40_26

				arg_37_1.typewritter:SetDirty()
			end

			if arg_37_1.time_ >= var_40_16 + var_40_26 and arg_37_1.time_ < var_40_16 + var_40_26 + arg_40_0 then
				arg_37_1.typewritter.percent = 1

				arg_37_1.typewritter:SetDirty()
				arg_37_1:ShowNextGo(true)
			end
		end

		arg_37_1.nodeConfigList_ = {}

		arg_37_1:InitPlayNodeList()
	end,
	Play114241010 = function(arg_41_0, arg_41_1)
		arg_41_1.time_ = 0
		arg_41_1.frameCnt_ = 0
		arg_41_1.state_ = "playing"
		arg_41_1.curTalkId_ = 114241010
		arg_41_1.duration_ = 10.4

		local var_41_0 = {
			ja = 10.4,
			ko = 4.866,
			zh = 3.666,
			en = 5.733
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
				arg_41_0:Play114241011(arg_41_1)
			end
		end

		function arg_41_1.onSingleLineUpdate_(arg_44_0)
			local var_44_0 = arg_41_1.actors_["10015"]
			local var_44_1 = 0

			if var_44_1 < arg_41_1.time_ and arg_41_1.time_ <= var_44_1 + arg_44_0 and not isNil(var_44_0) and arg_41_1.var_.actorSpriteComps10015 == nil then
				arg_41_1.var_.actorSpriteComps10015 = var_44_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_44_2 = 0.034

			if var_44_1 <= arg_41_1.time_ and arg_41_1.time_ < var_44_1 + var_44_2 and not isNil(var_44_0) then
				local var_44_3 = (arg_41_1.time_ - var_44_1) / var_44_2

				if arg_41_1.var_.actorSpriteComps10015 then
					for iter_44_0, iter_44_1 in pairs(arg_41_1.var_.actorSpriteComps10015:ToTable()) do
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

			if arg_41_1.time_ >= var_44_1 + var_44_2 and arg_41_1.time_ < var_44_1 + var_44_2 + arg_44_0 and not isNil(var_44_0) and arg_41_1.var_.actorSpriteComps10015 then
				for iter_44_2, iter_44_3 in pairs(arg_41_1.var_.actorSpriteComps10015:ToTable()) do
					if iter_44_3 then
						if arg_41_1.isInRecall_ then
							iter_44_3.color = arg_41_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_44_3.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_41_1.var_.actorSpriteComps10015 = nil
			end

			local var_44_8 = arg_41_1.actors_["10018"]
			local var_44_9 = 0

			if var_44_9 < arg_41_1.time_ and arg_41_1.time_ <= var_44_9 + arg_44_0 and not isNil(var_44_8) and arg_41_1.var_.actorSpriteComps10018 == nil then
				arg_41_1.var_.actorSpriteComps10018 = var_44_8:GetComponentsInChildren(typeof(Image), true)
			end

			local var_44_10 = 0.034

			if var_44_9 <= arg_41_1.time_ and arg_41_1.time_ < var_44_9 + var_44_10 and not isNil(var_44_8) then
				local var_44_11 = (arg_41_1.time_ - var_44_9) / var_44_10

				if arg_41_1.var_.actorSpriteComps10018 then
					for iter_44_4, iter_44_5 in pairs(arg_41_1.var_.actorSpriteComps10018:ToTable()) do
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

			if arg_41_1.time_ >= var_44_9 + var_44_10 and arg_41_1.time_ < var_44_9 + var_44_10 + arg_44_0 and not isNil(var_44_8) and arg_41_1.var_.actorSpriteComps10018 then
				for iter_44_6, iter_44_7 in pairs(arg_41_1.var_.actorSpriteComps10018:ToTable()) do
					if iter_44_7 then
						if arg_41_1.isInRecall_ then
							iter_44_7.color = arg_41_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_44_7.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_41_1.var_.actorSpriteComps10018 = nil
			end

			local var_44_16 = 0
			local var_44_17 = 0.425

			if var_44_16 < arg_41_1.time_ and arg_41_1.time_ <= var_44_16 + arg_44_0 then
				arg_41_1.talkMaxDuration = 0
				arg_41_1.dialogCg_.alpha = 1

				arg_41_1.dialog_:SetActive(true)
				SetActive(arg_41_1.leftNameGo_, true)

				local var_44_18 = arg_41_1:FormatText(StoryNameCfg[208].name)

				arg_41_1.leftNameTxt_.text = var_44_18

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_41_1.leftNameTxt_.transform)

				arg_41_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_41_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_41_1:RecordName(arg_41_1.leftNameTxt_.text)
				SetActive(arg_41_1.iconTrs_.gameObject, false)
				arg_41_1.callingController_:SetSelectedState("normal")

				local var_44_19 = arg_41_1:GetWordFromCfg(114241010)
				local var_44_20 = arg_41_1:FormatText(var_44_19.content)

				arg_41_1.text_.text = var_44_20

				LuaForUtil.ClearLinePrefixSymbol(arg_41_1.text_)

				local var_44_21 = 17
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

				if manager.audio:GetVoiceLength("story_v_out_114241", "114241010", "story_v_out_114241.awb") ~= 0 then
					local var_44_24 = manager.audio:GetVoiceLength("story_v_out_114241", "114241010", "story_v_out_114241.awb") / 1000

					if var_44_24 + var_44_16 > arg_41_1.duration_ then
						arg_41_1.duration_ = var_44_24 + var_44_16
					end

					if var_44_19.prefab_name ~= "" and arg_41_1.actors_[var_44_19.prefab_name] ~= nil then
						local var_44_25 = LuaForUtil.PlayVoiceWithCriLipsync(arg_41_1.actors_[var_44_19.prefab_name].transform, "story_v_out_114241", "114241010", "story_v_out_114241.awb")

						arg_41_1:RecordAudio("114241010", var_44_25)
						arg_41_1:RecordAudio("114241010", var_44_25)
					else
						arg_41_1:AudioAction("play", "voice", "story_v_out_114241", "114241010", "story_v_out_114241.awb")
					end

					arg_41_1:RecordHistoryTalkVoice("story_v_out_114241", "114241010", "story_v_out_114241.awb")
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
	Play114241011 = function(arg_45_0, arg_45_1)
		arg_45_1.time_ = 0
		arg_45_1.frameCnt_ = 0
		arg_45_1.state_ = "playing"
		arg_45_1.curTalkId_ = 114241011
		arg_45_1.duration_ = 6.87

		local var_45_0 = {
			ja = 4.533,
			ko = 6.666,
			zh = 5.466,
			en = 6.866
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
				arg_45_0:Play114241012(arg_45_1)
			end
		end

		function arg_45_1.onSingleLineUpdate_(arg_48_0)
			local var_48_0 = arg_45_1.actors_["10015"]
			local var_48_1 = 0

			if var_48_1 < arg_45_1.time_ and arg_45_1.time_ <= var_48_1 + arg_48_0 and not isNil(var_48_0) and arg_45_1.var_.actorSpriteComps10015 == nil then
				arg_45_1.var_.actorSpriteComps10015 = var_48_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_48_2 = 0.034

			if var_48_1 <= arg_45_1.time_ and arg_45_1.time_ < var_48_1 + var_48_2 and not isNil(var_48_0) then
				local var_48_3 = (arg_45_1.time_ - var_48_1) / var_48_2

				if arg_45_1.var_.actorSpriteComps10015 then
					for iter_48_0, iter_48_1 in pairs(arg_45_1.var_.actorSpriteComps10015:ToTable()) do
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

			if arg_45_1.time_ >= var_48_1 + var_48_2 and arg_45_1.time_ < var_48_1 + var_48_2 + arg_48_0 and not isNil(var_48_0) and arg_45_1.var_.actorSpriteComps10015 then
				for iter_48_2, iter_48_3 in pairs(arg_45_1.var_.actorSpriteComps10015:ToTable()) do
					if iter_48_3 then
						if arg_45_1.isInRecall_ then
							iter_48_3.color = arg_45_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_48_3.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_45_1.var_.actorSpriteComps10015 = nil
			end

			local var_48_8 = arg_45_1.actors_["10018"]
			local var_48_9 = 0

			if var_48_9 < arg_45_1.time_ and arg_45_1.time_ <= var_48_9 + arg_48_0 and not isNil(var_48_8) and arg_45_1.var_.actorSpriteComps10018 == nil then
				arg_45_1.var_.actorSpriteComps10018 = var_48_8:GetComponentsInChildren(typeof(Image), true)
			end

			local var_48_10 = 0.034

			if var_48_9 <= arg_45_1.time_ and arg_45_1.time_ < var_48_9 + var_48_10 and not isNil(var_48_8) then
				local var_48_11 = (arg_45_1.time_ - var_48_9) / var_48_10

				if arg_45_1.var_.actorSpriteComps10018 then
					for iter_48_4, iter_48_5 in pairs(arg_45_1.var_.actorSpriteComps10018:ToTable()) do
						if iter_48_5 then
							if arg_45_1.isInRecall_ then
								local var_48_12 = Mathf.Lerp(iter_48_5.color.r, arg_45_1.hightColor1.r, var_48_11)
								local var_48_13 = Mathf.Lerp(iter_48_5.color.g, arg_45_1.hightColor1.g, var_48_11)
								local var_48_14 = Mathf.Lerp(iter_48_5.color.b, arg_45_1.hightColor1.b, var_48_11)

								iter_48_5.color = Color.New(var_48_12, var_48_13, var_48_14)
							else
								local var_48_15 = Mathf.Lerp(iter_48_5.color.r, 1, var_48_11)

								iter_48_5.color = Color.New(var_48_15, var_48_15, var_48_15)
							end
						end
					end
				end
			end

			if arg_45_1.time_ >= var_48_9 + var_48_10 and arg_45_1.time_ < var_48_9 + var_48_10 + arg_48_0 and not isNil(var_48_8) and arg_45_1.var_.actorSpriteComps10018 then
				for iter_48_6, iter_48_7 in pairs(arg_45_1.var_.actorSpriteComps10018:ToTable()) do
					if iter_48_7 then
						if arg_45_1.isInRecall_ then
							iter_48_7.color = arg_45_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_48_7.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_45_1.var_.actorSpriteComps10018 = nil
			end

			local var_48_16 = 0
			local var_48_17 = 0.6

			if var_48_16 < arg_45_1.time_ and arg_45_1.time_ <= var_48_16 + arg_48_0 then
				arg_45_1.talkMaxDuration = 0
				arg_45_1.dialogCg_.alpha = 1

				arg_45_1.dialog_:SetActive(true)
				SetActive(arg_45_1.leftNameGo_, true)

				local var_48_18 = arg_45_1:FormatText(StoryNameCfg[257].name)

				arg_45_1.leftNameTxt_.text = var_48_18

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_45_1.leftNameTxt_.transform)

				arg_45_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_45_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_45_1:RecordName(arg_45_1.leftNameTxt_.text)
				SetActive(arg_45_1.iconTrs_.gameObject, false)
				arg_45_1.callingController_:SetSelectedState("normal")

				local var_48_19 = arg_45_1:GetWordFromCfg(114241011)
				local var_48_20 = arg_45_1:FormatText(var_48_19.content)

				arg_45_1.text_.text = var_48_20

				LuaForUtil.ClearLinePrefixSymbol(arg_45_1.text_)

				local var_48_21 = 24
				local var_48_22 = utf8.len(var_48_20)
				local var_48_23 = var_48_21 <= 0 and var_48_17 or var_48_17 * (var_48_22 / var_48_21)

				if var_48_23 > 0 and var_48_17 < var_48_23 then
					arg_45_1.talkMaxDuration = var_48_23

					if var_48_23 + var_48_16 > arg_45_1.duration_ then
						arg_45_1.duration_ = var_48_23 + var_48_16
					end
				end

				arg_45_1.text_.text = var_48_20
				arg_45_1.typewritter.percent = 0

				arg_45_1.typewritter:SetDirty()
				arg_45_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_114241", "114241011", "story_v_out_114241.awb") ~= 0 then
					local var_48_24 = manager.audio:GetVoiceLength("story_v_out_114241", "114241011", "story_v_out_114241.awb") / 1000

					if var_48_24 + var_48_16 > arg_45_1.duration_ then
						arg_45_1.duration_ = var_48_24 + var_48_16
					end

					if var_48_19.prefab_name ~= "" and arg_45_1.actors_[var_48_19.prefab_name] ~= nil then
						local var_48_25 = LuaForUtil.PlayVoiceWithCriLipsync(arg_45_1.actors_[var_48_19.prefab_name].transform, "story_v_out_114241", "114241011", "story_v_out_114241.awb")

						arg_45_1:RecordAudio("114241011", var_48_25)
						arg_45_1:RecordAudio("114241011", var_48_25)
					else
						arg_45_1:AudioAction("play", "voice", "story_v_out_114241", "114241011", "story_v_out_114241.awb")
					end

					arg_45_1:RecordHistoryTalkVoice("story_v_out_114241", "114241011", "story_v_out_114241.awb")
				end

				arg_45_1:RecordContent(arg_45_1.text_.text)
			end

			local var_48_26 = math.max(var_48_17, arg_45_1.talkMaxDuration)

			if var_48_16 <= arg_45_1.time_ and arg_45_1.time_ < var_48_16 + var_48_26 then
				arg_45_1.typewritter.percent = (arg_45_1.time_ - var_48_16) / var_48_26

				arg_45_1.typewritter:SetDirty()
			end

			if arg_45_1.time_ >= var_48_16 + var_48_26 and arg_45_1.time_ < var_48_16 + var_48_26 + arg_48_0 then
				arg_45_1.typewritter.percent = 1

				arg_45_1.typewritter:SetDirty()
				arg_45_1:ShowNextGo(true)
			end
		end

		arg_45_1.nodeConfigList_ = {}

		arg_45_1:InitPlayNodeList()
	end,
	Play114241012 = function(arg_49_0, arg_49_1)
		arg_49_1.time_ = 0
		arg_49_1.frameCnt_ = 0
		arg_49_1.state_ = "playing"
		arg_49_1.curTalkId_ = 114241012
		arg_49_1.duration_ = 5.53

		local var_49_0 = {
			ja = 5.533,
			ko = 1.633,
			zh = 2.633,
			en = 1.9
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
				arg_49_0:Play114241013(arg_49_1)
			end
		end

		function arg_49_1.onSingleLineUpdate_(arg_52_0)
			local var_52_0 = arg_49_1.actors_["10015"]
			local var_52_1 = 0

			if var_52_1 < arg_49_1.time_ and arg_49_1.time_ <= var_52_1 + arg_52_0 and not isNil(var_52_0) and arg_49_1.var_.actorSpriteComps10015 == nil then
				arg_49_1.var_.actorSpriteComps10015 = var_52_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_52_2 = 0.034

			if var_52_1 <= arg_49_1.time_ and arg_49_1.time_ < var_52_1 + var_52_2 and not isNil(var_52_0) then
				local var_52_3 = (arg_49_1.time_ - var_52_1) / var_52_2

				if arg_49_1.var_.actorSpriteComps10015 then
					for iter_52_0, iter_52_1 in pairs(arg_49_1.var_.actorSpriteComps10015:ToTable()) do
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

			if arg_49_1.time_ >= var_52_1 + var_52_2 and arg_49_1.time_ < var_52_1 + var_52_2 + arg_52_0 and not isNil(var_52_0) and arg_49_1.var_.actorSpriteComps10015 then
				for iter_52_2, iter_52_3 in pairs(arg_49_1.var_.actorSpriteComps10015:ToTable()) do
					if iter_52_3 then
						if arg_49_1.isInRecall_ then
							iter_52_3.color = arg_49_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_52_3.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_49_1.var_.actorSpriteComps10015 = nil
			end

			local var_52_8 = arg_49_1.actors_["10018"]
			local var_52_9 = 0

			if var_52_9 < arg_49_1.time_ and arg_49_1.time_ <= var_52_9 + arg_52_0 and not isNil(var_52_8) and arg_49_1.var_.actorSpriteComps10018 == nil then
				arg_49_1.var_.actorSpriteComps10018 = var_52_8:GetComponentsInChildren(typeof(Image), true)
			end

			local var_52_10 = 0.034

			if var_52_9 <= arg_49_1.time_ and arg_49_1.time_ < var_52_9 + var_52_10 and not isNil(var_52_8) then
				local var_52_11 = (arg_49_1.time_ - var_52_9) / var_52_10

				if arg_49_1.var_.actorSpriteComps10018 then
					for iter_52_4, iter_52_5 in pairs(arg_49_1.var_.actorSpriteComps10018:ToTable()) do
						if iter_52_5 then
							if arg_49_1.isInRecall_ then
								local var_52_12 = Mathf.Lerp(iter_52_5.color.r, arg_49_1.hightColor2.r, var_52_11)
								local var_52_13 = Mathf.Lerp(iter_52_5.color.g, arg_49_1.hightColor2.g, var_52_11)
								local var_52_14 = Mathf.Lerp(iter_52_5.color.b, arg_49_1.hightColor2.b, var_52_11)

								iter_52_5.color = Color.New(var_52_12, var_52_13, var_52_14)
							else
								local var_52_15 = Mathf.Lerp(iter_52_5.color.r, 0.5, var_52_11)

								iter_52_5.color = Color.New(var_52_15, var_52_15, var_52_15)
							end
						end
					end
				end
			end

			if arg_49_1.time_ >= var_52_9 + var_52_10 and arg_49_1.time_ < var_52_9 + var_52_10 + arg_52_0 and not isNil(var_52_8) and arg_49_1.var_.actorSpriteComps10018 then
				for iter_52_6, iter_52_7 in pairs(arg_49_1.var_.actorSpriteComps10018:ToTable()) do
					if iter_52_7 then
						if arg_49_1.isInRecall_ then
							iter_52_7.color = arg_49_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_52_7.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_49_1.var_.actorSpriteComps10018 = nil
			end

			local var_52_16 = 0
			local var_52_17 = 0.25

			if var_52_16 < arg_49_1.time_ and arg_49_1.time_ <= var_52_16 + arg_52_0 then
				arg_49_1.talkMaxDuration = 0
				arg_49_1.dialogCg_.alpha = 1

				arg_49_1.dialog_:SetActive(true)
				SetActive(arg_49_1.leftNameGo_, true)

				local var_52_18 = arg_49_1:FormatText(StoryNameCfg[208].name)

				arg_49_1.leftNameTxt_.text = var_52_18

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_49_1.leftNameTxt_.transform)

				arg_49_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_49_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_49_1:RecordName(arg_49_1.leftNameTxt_.text)
				SetActive(arg_49_1.iconTrs_.gameObject, false)
				arg_49_1.callingController_:SetSelectedState("normal")

				local var_52_19 = arg_49_1:GetWordFromCfg(114241012)
				local var_52_20 = arg_49_1:FormatText(var_52_19.content)

				arg_49_1.text_.text = var_52_20

				LuaForUtil.ClearLinePrefixSymbol(arg_49_1.text_)

				local var_52_21 = 10
				local var_52_22 = utf8.len(var_52_20)
				local var_52_23 = var_52_21 <= 0 and var_52_17 or var_52_17 * (var_52_22 / var_52_21)

				if var_52_23 > 0 and var_52_17 < var_52_23 then
					arg_49_1.talkMaxDuration = var_52_23

					if var_52_23 + var_52_16 > arg_49_1.duration_ then
						arg_49_1.duration_ = var_52_23 + var_52_16
					end
				end

				arg_49_1.text_.text = var_52_20
				arg_49_1.typewritter.percent = 0

				arg_49_1.typewritter:SetDirty()
				arg_49_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_114241", "114241012", "story_v_out_114241.awb") ~= 0 then
					local var_52_24 = manager.audio:GetVoiceLength("story_v_out_114241", "114241012", "story_v_out_114241.awb") / 1000

					if var_52_24 + var_52_16 > arg_49_1.duration_ then
						arg_49_1.duration_ = var_52_24 + var_52_16
					end

					if var_52_19.prefab_name ~= "" and arg_49_1.actors_[var_52_19.prefab_name] ~= nil then
						local var_52_25 = LuaForUtil.PlayVoiceWithCriLipsync(arg_49_1.actors_[var_52_19.prefab_name].transform, "story_v_out_114241", "114241012", "story_v_out_114241.awb")

						arg_49_1:RecordAudio("114241012", var_52_25)
						arg_49_1:RecordAudio("114241012", var_52_25)
					else
						arg_49_1:AudioAction("play", "voice", "story_v_out_114241", "114241012", "story_v_out_114241.awb")
					end

					arg_49_1:RecordHistoryTalkVoice("story_v_out_114241", "114241012", "story_v_out_114241.awb")
				end

				arg_49_1:RecordContent(arg_49_1.text_.text)
			end

			local var_52_26 = math.max(var_52_17, arg_49_1.talkMaxDuration)

			if var_52_16 <= arg_49_1.time_ and arg_49_1.time_ < var_52_16 + var_52_26 then
				arg_49_1.typewritter.percent = (arg_49_1.time_ - var_52_16) / var_52_26

				arg_49_1.typewritter:SetDirty()
			end

			if arg_49_1.time_ >= var_52_16 + var_52_26 and arg_49_1.time_ < var_52_16 + var_52_26 + arg_52_0 then
				arg_49_1.typewritter.percent = 1

				arg_49_1.typewritter:SetDirty()
				arg_49_1:ShowNextGo(true)
			end
		end

		arg_49_1.nodeConfigList_ = {}

		arg_49_1:InitPlayNodeList()
	end,
	Play114241013 = function(arg_53_0, arg_53_1)
		arg_53_1.time_ = 0
		arg_53_1.frameCnt_ = 0
		arg_53_1.state_ = "playing"
		arg_53_1.curTalkId_ = 114241013
		arg_53_1.duration_ = 5

		SetActive(arg_53_1.tipsGo_, false)

		function arg_53_1.onSingleLineFinish_()
			arg_53_1.onSingleLineUpdate_ = nil
			arg_53_1.onSingleLineFinish_ = nil
			arg_53_1.state_ = "waiting"
		end

		function arg_53_1.playNext_(arg_55_0)
			if arg_55_0 == 1 then
				arg_53_0:Play114241014(arg_53_1)
			end
		end

		function arg_53_1.onSingleLineUpdate_(arg_56_0)
			local var_56_0 = arg_53_1.actors_["10015"]
			local var_56_1 = 0

			if var_56_1 < arg_53_1.time_ and arg_53_1.time_ <= var_56_1 + arg_56_0 and not isNil(var_56_0) and arg_53_1.var_.actorSpriteComps10015 == nil then
				arg_53_1.var_.actorSpriteComps10015 = var_56_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_56_2 = 0.034

			if var_56_1 <= arg_53_1.time_ and arg_53_1.time_ < var_56_1 + var_56_2 and not isNil(var_56_0) then
				local var_56_3 = (arg_53_1.time_ - var_56_1) / var_56_2

				if arg_53_1.var_.actorSpriteComps10015 then
					for iter_56_0, iter_56_1 in pairs(arg_53_1.var_.actorSpriteComps10015:ToTable()) do
						if iter_56_1 then
							if arg_53_1.isInRecall_ then
								local var_56_4 = Mathf.Lerp(iter_56_1.color.r, arg_53_1.hightColor2.r, var_56_3)
								local var_56_5 = Mathf.Lerp(iter_56_1.color.g, arg_53_1.hightColor2.g, var_56_3)
								local var_56_6 = Mathf.Lerp(iter_56_1.color.b, arg_53_1.hightColor2.b, var_56_3)

								iter_56_1.color = Color.New(var_56_4, var_56_5, var_56_6)
							else
								local var_56_7 = Mathf.Lerp(iter_56_1.color.r, 0.5, var_56_3)

								iter_56_1.color = Color.New(var_56_7, var_56_7, var_56_7)
							end
						end
					end
				end
			end

			if arg_53_1.time_ >= var_56_1 + var_56_2 and arg_53_1.time_ < var_56_1 + var_56_2 + arg_56_0 and not isNil(var_56_0) and arg_53_1.var_.actorSpriteComps10015 then
				for iter_56_2, iter_56_3 in pairs(arg_53_1.var_.actorSpriteComps10015:ToTable()) do
					if iter_56_3 then
						if arg_53_1.isInRecall_ then
							iter_56_3.color = arg_53_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_56_3.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_53_1.var_.actorSpriteComps10015 = nil
			end

			local var_56_8 = 0
			local var_56_9 = 1

			if var_56_8 < arg_53_1.time_ and arg_53_1.time_ <= var_56_8 + arg_56_0 then
				local var_56_10 = "play"
				local var_56_11 = "effect"

				arg_53_1:AudioAction(var_56_10, var_56_11, "se_story_activity_1_4_3", "se_story_activity_1_4_3_rock", "")
			end

			local var_56_12 = 0
			local var_56_13 = 0.95

			if var_56_12 < arg_53_1.time_ and arg_53_1.time_ <= var_56_12 + arg_56_0 then
				arg_53_1.talkMaxDuration = 0
				arg_53_1.dialogCg_.alpha = 1

				arg_53_1.dialog_:SetActive(true)
				SetActive(arg_53_1.leftNameGo_, false)

				arg_53_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_53_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_53_1:RecordName(arg_53_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_53_1.iconTrs_.gameObject, false)
				arg_53_1.callingController_:SetSelectedState("normal")

				local var_56_14 = arg_53_1:GetWordFromCfg(114241013)
				local var_56_15 = arg_53_1:FormatText(var_56_14.content)

				arg_53_1.text_.text = var_56_15

				LuaForUtil.ClearLinePrefixSymbol(arg_53_1.text_)

				local var_56_16 = 38
				local var_56_17 = utf8.len(var_56_15)
				local var_56_18 = var_56_16 <= 0 and var_56_13 or var_56_13 * (var_56_17 / var_56_16)

				if var_56_18 > 0 and var_56_13 < var_56_18 then
					arg_53_1.talkMaxDuration = var_56_18

					if var_56_18 + var_56_12 > arg_53_1.duration_ then
						arg_53_1.duration_ = var_56_18 + var_56_12
					end
				end

				arg_53_1.text_.text = var_56_15
				arg_53_1.typewritter.percent = 0

				arg_53_1.typewritter:SetDirty()
				arg_53_1:ShowNextGo(false)
				arg_53_1:RecordContent(arg_53_1.text_.text)
			end

			local var_56_19 = math.max(var_56_13, arg_53_1.talkMaxDuration)

			if var_56_12 <= arg_53_1.time_ and arg_53_1.time_ < var_56_12 + var_56_19 then
				arg_53_1.typewritter.percent = (arg_53_1.time_ - var_56_12) / var_56_19

				arg_53_1.typewritter:SetDirty()
			end

			if arg_53_1.time_ >= var_56_12 + var_56_19 and arg_53_1.time_ < var_56_12 + var_56_19 + arg_56_0 then
				arg_53_1.typewritter.percent = 1

				arg_53_1.typewritter:SetDirty()
				arg_53_1:ShowNextGo(true)
			end
		end

		arg_53_1.nodeConfigList_ = {}

		arg_53_1:InitPlayNodeList()
	end,
	Play114241014 = function(arg_57_0, arg_57_1)
		arg_57_1.time_ = 0
		arg_57_1.frameCnt_ = 0
		arg_57_1.state_ = "playing"
		arg_57_1.curTalkId_ = 114241014
		arg_57_1.duration_ = 7.23

		local var_57_0 = {
			ja = 7.233,
			ko = 4.433,
			zh = 2.5,
			en = 5.233
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
				arg_57_0:Play114241015(arg_57_1)
			end
		end

		function arg_57_1.onSingleLineUpdate_(arg_60_0)
			local var_60_0 = arg_57_1.actors_["10018"]
			local var_60_1 = 0

			if var_60_1 < arg_57_1.time_ and arg_57_1.time_ <= var_60_1 + arg_60_0 and not isNil(var_60_0) and arg_57_1.var_.actorSpriteComps10018 == nil then
				arg_57_1.var_.actorSpriteComps10018 = var_60_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_60_2 = 0.034

			if var_60_1 <= arg_57_1.time_ and arg_57_1.time_ < var_60_1 + var_60_2 and not isNil(var_60_0) then
				local var_60_3 = (arg_57_1.time_ - var_60_1) / var_60_2

				if arg_57_1.var_.actorSpriteComps10018 then
					for iter_60_0, iter_60_1 in pairs(arg_57_1.var_.actorSpriteComps10018:ToTable()) do
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

			if arg_57_1.time_ >= var_60_1 + var_60_2 and arg_57_1.time_ < var_60_1 + var_60_2 + arg_60_0 and not isNil(var_60_0) and arg_57_1.var_.actorSpriteComps10018 then
				for iter_60_2, iter_60_3 in pairs(arg_57_1.var_.actorSpriteComps10018:ToTable()) do
					if iter_60_3 then
						if arg_57_1.isInRecall_ then
							iter_60_3.color = arg_57_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_60_3.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_57_1.var_.actorSpriteComps10018 = nil
			end

			local var_60_8 = 0
			local var_60_9 = 0.275

			if var_60_8 < arg_57_1.time_ and arg_57_1.time_ <= var_60_8 + arg_60_0 then
				arg_57_1.talkMaxDuration = 0
				arg_57_1.dialogCg_.alpha = 1

				arg_57_1.dialog_:SetActive(true)
				SetActive(arg_57_1.leftNameGo_, true)

				local var_60_10 = arg_57_1:FormatText(StoryNameCfg[257].name)

				arg_57_1.leftNameTxt_.text = var_60_10

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_57_1.leftNameTxt_.transform)

				arg_57_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_57_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_57_1:RecordName(arg_57_1.leftNameTxt_.text)
				SetActive(arg_57_1.iconTrs_.gameObject, false)
				arg_57_1.callingController_:SetSelectedState("normal")

				local var_60_11 = arg_57_1:GetWordFromCfg(114241014)
				local var_60_12 = arg_57_1:FormatText(var_60_11.content)

				arg_57_1.text_.text = var_60_12

				LuaForUtil.ClearLinePrefixSymbol(arg_57_1.text_)

				local var_60_13 = 11
				local var_60_14 = utf8.len(var_60_12)
				local var_60_15 = var_60_13 <= 0 and var_60_9 or var_60_9 * (var_60_14 / var_60_13)

				if var_60_15 > 0 and var_60_9 < var_60_15 then
					arg_57_1.talkMaxDuration = var_60_15

					if var_60_15 + var_60_8 > arg_57_1.duration_ then
						arg_57_1.duration_ = var_60_15 + var_60_8
					end
				end

				arg_57_1.text_.text = var_60_12
				arg_57_1.typewritter.percent = 0

				arg_57_1.typewritter:SetDirty()
				arg_57_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_114241", "114241014", "story_v_out_114241.awb") ~= 0 then
					local var_60_16 = manager.audio:GetVoiceLength("story_v_out_114241", "114241014", "story_v_out_114241.awb") / 1000

					if var_60_16 + var_60_8 > arg_57_1.duration_ then
						arg_57_1.duration_ = var_60_16 + var_60_8
					end

					if var_60_11.prefab_name ~= "" and arg_57_1.actors_[var_60_11.prefab_name] ~= nil then
						local var_60_17 = LuaForUtil.PlayVoiceWithCriLipsync(arg_57_1.actors_[var_60_11.prefab_name].transform, "story_v_out_114241", "114241014", "story_v_out_114241.awb")

						arg_57_1:RecordAudio("114241014", var_60_17)
						arg_57_1:RecordAudio("114241014", var_60_17)
					else
						arg_57_1:AudioAction("play", "voice", "story_v_out_114241", "114241014", "story_v_out_114241.awb")
					end

					arg_57_1:RecordHistoryTalkVoice("story_v_out_114241", "114241014", "story_v_out_114241.awb")
				end

				arg_57_1:RecordContent(arg_57_1.text_.text)
			end

			local var_60_18 = math.max(var_60_9, arg_57_1.talkMaxDuration)

			if var_60_8 <= arg_57_1.time_ and arg_57_1.time_ < var_60_8 + var_60_18 then
				arg_57_1.typewritter.percent = (arg_57_1.time_ - var_60_8) / var_60_18

				arg_57_1.typewritter:SetDirty()
			end

			if arg_57_1.time_ >= var_60_8 + var_60_18 and arg_57_1.time_ < var_60_8 + var_60_18 + arg_60_0 then
				arg_57_1.typewritter.percent = 1

				arg_57_1.typewritter:SetDirty()
				arg_57_1:ShowNextGo(true)
			end
		end

		arg_57_1.nodeConfigList_ = {}

		arg_57_1:InitPlayNodeList()
	end,
	Play114241015 = function(arg_61_0, arg_61_1)
		arg_61_1.time_ = 0
		arg_61_1.frameCnt_ = 0
		arg_61_1.state_ = "playing"
		arg_61_1.curTalkId_ = 114241015
		arg_61_1.duration_ = 5.5

		local var_61_0 = {
			ja = 5.5,
			ko = 4.533,
			zh = 5.266,
			en = 3.966
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
				arg_61_0:Play114241016(arg_61_1)
			end
		end

		function arg_61_1.onSingleLineUpdate_(arg_64_0)
			local var_64_0 = arg_61_1.actors_["10015"]
			local var_64_1 = 0

			if var_64_1 < arg_61_1.time_ and arg_61_1.time_ <= var_64_1 + arg_64_0 and not isNil(var_64_0) and arg_61_1.var_.actorSpriteComps10015 == nil then
				arg_61_1.var_.actorSpriteComps10015 = var_64_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_64_2 = 0.034

			if var_64_1 <= arg_61_1.time_ and arg_61_1.time_ < var_64_1 + var_64_2 and not isNil(var_64_0) then
				local var_64_3 = (arg_61_1.time_ - var_64_1) / var_64_2

				if arg_61_1.var_.actorSpriteComps10015 then
					for iter_64_0, iter_64_1 in pairs(arg_61_1.var_.actorSpriteComps10015:ToTable()) do
						if iter_64_1 then
							if arg_61_1.isInRecall_ then
								local var_64_4 = Mathf.Lerp(iter_64_1.color.r, arg_61_1.hightColor1.r, var_64_3)
								local var_64_5 = Mathf.Lerp(iter_64_1.color.g, arg_61_1.hightColor1.g, var_64_3)
								local var_64_6 = Mathf.Lerp(iter_64_1.color.b, arg_61_1.hightColor1.b, var_64_3)

								iter_64_1.color = Color.New(var_64_4, var_64_5, var_64_6)
							else
								local var_64_7 = Mathf.Lerp(iter_64_1.color.r, 1, var_64_3)

								iter_64_1.color = Color.New(var_64_7, var_64_7, var_64_7)
							end
						end
					end
				end
			end

			if arg_61_1.time_ >= var_64_1 + var_64_2 and arg_61_1.time_ < var_64_1 + var_64_2 + arg_64_0 and not isNil(var_64_0) and arg_61_1.var_.actorSpriteComps10015 then
				for iter_64_2, iter_64_3 in pairs(arg_61_1.var_.actorSpriteComps10015:ToTable()) do
					if iter_64_3 then
						if arg_61_1.isInRecall_ then
							iter_64_3.color = arg_61_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_64_3.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_61_1.var_.actorSpriteComps10015 = nil
			end

			local var_64_8 = arg_61_1.actors_["10018"]
			local var_64_9 = 0

			if var_64_9 < arg_61_1.time_ and arg_61_1.time_ <= var_64_9 + arg_64_0 and not isNil(var_64_8) and arg_61_1.var_.actorSpriteComps10018 == nil then
				arg_61_1.var_.actorSpriteComps10018 = var_64_8:GetComponentsInChildren(typeof(Image), true)
			end

			local var_64_10 = 0.034

			if var_64_9 <= arg_61_1.time_ and arg_61_1.time_ < var_64_9 + var_64_10 and not isNil(var_64_8) then
				local var_64_11 = (arg_61_1.time_ - var_64_9) / var_64_10

				if arg_61_1.var_.actorSpriteComps10018 then
					for iter_64_4, iter_64_5 in pairs(arg_61_1.var_.actorSpriteComps10018:ToTable()) do
						if iter_64_5 then
							if arg_61_1.isInRecall_ then
								local var_64_12 = Mathf.Lerp(iter_64_5.color.r, arg_61_1.hightColor2.r, var_64_11)
								local var_64_13 = Mathf.Lerp(iter_64_5.color.g, arg_61_1.hightColor2.g, var_64_11)
								local var_64_14 = Mathf.Lerp(iter_64_5.color.b, arg_61_1.hightColor2.b, var_64_11)

								iter_64_5.color = Color.New(var_64_12, var_64_13, var_64_14)
							else
								local var_64_15 = Mathf.Lerp(iter_64_5.color.r, 0.5, var_64_11)

								iter_64_5.color = Color.New(var_64_15, var_64_15, var_64_15)
							end
						end
					end
				end
			end

			if arg_61_1.time_ >= var_64_9 + var_64_10 and arg_61_1.time_ < var_64_9 + var_64_10 + arg_64_0 and not isNil(var_64_8) and arg_61_1.var_.actorSpriteComps10018 then
				for iter_64_6, iter_64_7 in pairs(arg_61_1.var_.actorSpriteComps10018:ToTable()) do
					if iter_64_7 then
						if arg_61_1.isInRecall_ then
							iter_64_7.color = arg_61_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_64_7.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_61_1.var_.actorSpriteComps10018 = nil
			end

			local var_64_16 = 0
			local var_64_17 = 0.55

			if var_64_16 < arg_61_1.time_ and arg_61_1.time_ <= var_64_16 + arg_64_0 then
				arg_61_1.talkMaxDuration = 0
				arg_61_1.dialogCg_.alpha = 1

				arg_61_1.dialog_:SetActive(true)
				SetActive(arg_61_1.leftNameGo_, true)

				local var_64_18 = arg_61_1:FormatText(StoryNameCfg[208].name)

				arg_61_1.leftNameTxt_.text = var_64_18

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_61_1.leftNameTxt_.transform)

				arg_61_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_61_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_61_1:RecordName(arg_61_1.leftNameTxt_.text)
				SetActive(arg_61_1.iconTrs_.gameObject, false)
				arg_61_1.callingController_:SetSelectedState("normal")

				local var_64_19 = arg_61_1:GetWordFromCfg(114241015)
				local var_64_20 = arg_61_1:FormatText(var_64_19.content)

				arg_61_1.text_.text = var_64_20

				LuaForUtil.ClearLinePrefixSymbol(arg_61_1.text_)

				local var_64_21 = 22
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

				if manager.audio:GetVoiceLength("story_v_out_114241", "114241015", "story_v_out_114241.awb") ~= 0 then
					local var_64_24 = manager.audio:GetVoiceLength("story_v_out_114241", "114241015", "story_v_out_114241.awb") / 1000

					if var_64_24 + var_64_16 > arg_61_1.duration_ then
						arg_61_1.duration_ = var_64_24 + var_64_16
					end

					if var_64_19.prefab_name ~= "" and arg_61_1.actors_[var_64_19.prefab_name] ~= nil then
						local var_64_25 = LuaForUtil.PlayVoiceWithCriLipsync(arg_61_1.actors_[var_64_19.prefab_name].transform, "story_v_out_114241", "114241015", "story_v_out_114241.awb")

						arg_61_1:RecordAudio("114241015", var_64_25)
						arg_61_1:RecordAudio("114241015", var_64_25)
					else
						arg_61_1:AudioAction("play", "voice", "story_v_out_114241", "114241015", "story_v_out_114241.awb")
					end

					arg_61_1:RecordHistoryTalkVoice("story_v_out_114241", "114241015", "story_v_out_114241.awb")
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
	Play114241016 = function(arg_65_0, arg_65_1)
		arg_65_1.time_ = 0
		arg_65_1.frameCnt_ = 0
		arg_65_1.state_ = "playing"
		arg_65_1.curTalkId_ = 114241016
		arg_65_1.duration_ = 7.07

		local var_65_0 = {
			ja = 4.233,
			ko = 4.9,
			zh = 5.166,
			en = 7.066
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
				arg_65_0:Play114241017(arg_65_1)
			end
		end

		function arg_65_1.onSingleLineUpdate_(arg_68_0)
			local var_68_0 = arg_65_1.actors_["10015"]
			local var_68_1 = 0

			if var_68_1 < arg_65_1.time_ and arg_65_1.time_ <= var_68_1 + arg_68_0 and not isNil(var_68_0) and arg_65_1.var_.actorSpriteComps10015 == nil then
				arg_65_1.var_.actorSpriteComps10015 = var_68_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_68_2 = 0.034

			if var_68_1 <= arg_65_1.time_ and arg_65_1.time_ < var_68_1 + var_68_2 and not isNil(var_68_0) then
				local var_68_3 = (arg_65_1.time_ - var_68_1) / var_68_2

				if arg_65_1.var_.actorSpriteComps10015 then
					for iter_68_0, iter_68_1 in pairs(arg_65_1.var_.actorSpriteComps10015:ToTable()) do
						if iter_68_1 then
							if arg_65_1.isInRecall_ then
								local var_68_4 = Mathf.Lerp(iter_68_1.color.r, arg_65_1.hightColor2.r, var_68_3)
								local var_68_5 = Mathf.Lerp(iter_68_1.color.g, arg_65_1.hightColor2.g, var_68_3)
								local var_68_6 = Mathf.Lerp(iter_68_1.color.b, arg_65_1.hightColor2.b, var_68_3)

								iter_68_1.color = Color.New(var_68_4, var_68_5, var_68_6)
							else
								local var_68_7 = Mathf.Lerp(iter_68_1.color.r, 0.5, var_68_3)

								iter_68_1.color = Color.New(var_68_7, var_68_7, var_68_7)
							end
						end
					end
				end
			end

			if arg_65_1.time_ >= var_68_1 + var_68_2 and arg_65_1.time_ < var_68_1 + var_68_2 + arg_68_0 and not isNil(var_68_0) and arg_65_1.var_.actorSpriteComps10015 then
				for iter_68_2, iter_68_3 in pairs(arg_65_1.var_.actorSpriteComps10015:ToTable()) do
					if iter_68_3 then
						if arg_65_1.isInRecall_ then
							iter_68_3.color = arg_65_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_68_3.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_65_1.var_.actorSpriteComps10015 = nil
			end

			local var_68_8 = arg_65_1.actors_["10018"]
			local var_68_9 = 0

			if var_68_9 < arg_65_1.time_ and arg_65_1.time_ <= var_68_9 + arg_68_0 and not isNil(var_68_8) and arg_65_1.var_.actorSpriteComps10018 == nil then
				arg_65_1.var_.actorSpriteComps10018 = var_68_8:GetComponentsInChildren(typeof(Image), true)
			end

			local var_68_10 = 0.034

			if var_68_9 <= arg_65_1.time_ and arg_65_1.time_ < var_68_9 + var_68_10 and not isNil(var_68_8) then
				local var_68_11 = (arg_65_1.time_ - var_68_9) / var_68_10

				if arg_65_1.var_.actorSpriteComps10018 then
					for iter_68_4, iter_68_5 in pairs(arg_65_1.var_.actorSpriteComps10018:ToTable()) do
						if iter_68_5 then
							if arg_65_1.isInRecall_ then
								local var_68_12 = Mathf.Lerp(iter_68_5.color.r, arg_65_1.hightColor1.r, var_68_11)
								local var_68_13 = Mathf.Lerp(iter_68_5.color.g, arg_65_1.hightColor1.g, var_68_11)
								local var_68_14 = Mathf.Lerp(iter_68_5.color.b, arg_65_1.hightColor1.b, var_68_11)

								iter_68_5.color = Color.New(var_68_12, var_68_13, var_68_14)
							else
								local var_68_15 = Mathf.Lerp(iter_68_5.color.r, 1, var_68_11)

								iter_68_5.color = Color.New(var_68_15, var_68_15, var_68_15)
							end
						end
					end
				end
			end

			if arg_65_1.time_ >= var_68_9 + var_68_10 and arg_65_1.time_ < var_68_9 + var_68_10 + arg_68_0 and not isNil(var_68_8) and arg_65_1.var_.actorSpriteComps10018 then
				for iter_68_6, iter_68_7 in pairs(arg_65_1.var_.actorSpriteComps10018:ToTable()) do
					if iter_68_7 then
						if arg_65_1.isInRecall_ then
							iter_68_7.color = arg_65_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_68_7.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_65_1.var_.actorSpriteComps10018 = nil
			end

			local var_68_16 = 0
			local var_68_17 = 0.45

			if var_68_16 < arg_65_1.time_ and arg_65_1.time_ <= var_68_16 + arg_68_0 then
				arg_65_1.talkMaxDuration = 0
				arg_65_1.dialogCg_.alpha = 1

				arg_65_1.dialog_:SetActive(true)
				SetActive(arg_65_1.leftNameGo_, true)

				local var_68_18 = arg_65_1:FormatText(StoryNameCfg[257].name)

				arg_65_1.leftNameTxt_.text = var_68_18

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_65_1.leftNameTxt_.transform)

				arg_65_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_65_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_65_1:RecordName(arg_65_1.leftNameTxt_.text)
				SetActive(arg_65_1.iconTrs_.gameObject, false)
				arg_65_1.callingController_:SetSelectedState("normal")

				local var_68_19 = arg_65_1:GetWordFromCfg(114241016)
				local var_68_20 = arg_65_1:FormatText(var_68_19.content)

				arg_65_1.text_.text = var_68_20

				LuaForUtil.ClearLinePrefixSymbol(arg_65_1.text_)

				local var_68_21 = 18
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

				if manager.audio:GetVoiceLength("story_v_out_114241", "114241016", "story_v_out_114241.awb") ~= 0 then
					local var_68_24 = manager.audio:GetVoiceLength("story_v_out_114241", "114241016", "story_v_out_114241.awb") / 1000

					if var_68_24 + var_68_16 > arg_65_1.duration_ then
						arg_65_1.duration_ = var_68_24 + var_68_16
					end

					if var_68_19.prefab_name ~= "" and arg_65_1.actors_[var_68_19.prefab_name] ~= nil then
						local var_68_25 = LuaForUtil.PlayVoiceWithCriLipsync(arg_65_1.actors_[var_68_19.prefab_name].transform, "story_v_out_114241", "114241016", "story_v_out_114241.awb")

						arg_65_1:RecordAudio("114241016", var_68_25)
						arg_65_1:RecordAudio("114241016", var_68_25)
					else
						arg_65_1:AudioAction("play", "voice", "story_v_out_114241", "114241016", "story_v_out_114241.awb")
					end

					arg_65_1:RecordHistoryTalkVoice("story_v_out_114241", "114241016", "story_v_out_114241.awb")
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
	Play114241017 = function(arg_69_0, arg_69_1)
		arg_69_1.time_ = 0
		arg_69_1.frameCnt_ = 0
		arg_69_1.state_ = "playing"
		arg_69_1.curTalkId_ = 114241017
		arg_69_1.duration_ = 14.27

		local var_69_0 = {
			ja = 9.233,
			ko = 11.933,
			zh = 10.833,
			en = 14.266
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
				arg_69_0:Play114241018(arg_69_1)
			end
		end

		function arg_69_1.onSingleLineUpdate_(arg_72_0)
			local var_72_0 = 0
			local var_72_1 = 1.2

			if var_72_0 < arg_69_1.time_ and arg_69_1.time_ <= var_72_0 + arg_72_0 then
				arg_69_1.talkMaxDuration = 0
				arg_69_1.dialogCg_.alpha = 1

				arg_69_1.dialog_:SetActive(true)
				SetActive(arg_69_1.leftNameGo_, true)

				local var_72_2 = arg_69_1:FormatText(StoryNameCfg[257].name)

				arg_69_1.leftNameTxt_.text = var_72_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_69_1.leftNameTxt_.transform)

				arg_69_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_69_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_69_1:RecordName(arg_69_1.leftNameTxt_.text)
				SetActive(arg_69_1.iconTrs_.gameObject, false)
				arg_69_1.callingController_:SetSelectedState("normal")

				local var_72_3 = arg_69_1:GetWordFromCfg(114241017)
				local var_72_4 = arg_69_1:FormatText(var_72_3.content)

				arg_69_1.text_.text = var_72_4

				LuaForUtil.ClearLinePrefixSymbol(arg_69_1.text_)

				local var_72_5 = 48
				local var_72_6 = utf8.len(var_72_4)
				local var_72_7 = var_72_5 <= 0 and var_72_1 or var_72_1 * (var_72_6 / var_72_5)

				if var_72_7 > 0 and var_72_1 < var_72_7 then
					arg_69_1.talkMaxDuration = var_72_7

					if var_72_7 + var_72_0 > arg_69_1.duration_ then
						arg_69_1.duration_ = var_72_7 + var_72_0
					end
				end

				arg_69_1.text_.text = var_72_4
				arg_69_1.typewritter.percent = 0

				arg_69_1.typewritter:SetDirty()
				arg_69_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_114241", "114241017", "story_v_out_114241.awb") ~= 0 then
					local var_72_8 = manager.audio:GetVoiceLength("story_v_out_114241", "114241017", "story_v_out_114241.awb") / 1000

					if var_72_8 + var_72_0 > arg_69_1.duration_ then
						arg_69_1.duration_ = var_72_8 + var_72_0
					end

					if var_72_3.prefab_name ~= "" and arg_69_1.actors_[var_72_3.prefab_name] ~= nil then
						local var_72_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_69_1.actors_[var_72_3.prefab_name].transform, "story_v_out_114241", "114241017", "story_v_out_114241.awb")

						arg_69_1:RecordAudio("114241017", var_72_9)
						arg_69_1:RecordAudio("114241017", var_72_9)
					else
						arg_69_1:AudioAction("play", "voice", "story_v_out_114241", "114241017", "story_v_out_114241.awb")
					end

					arg_69_1:RecordHistoryTalkVoice("story_v_out_114241", "114241017", "story_v_out_114241.awb")
				end

				arg_69_1:RecordContent(arg_69_1.text_.text)
			end

			local var_72_10 = math.max(var_72_1, arg_69_1.talkMaxDuration)

			if var_72_0 <= arg_69_1.time_ and arg_69_1.time_ < var_72_0 + var_72_10 then
				arg_69_1.typewritter.percent = (arg_69_1.time_ - var_72_0) / var_72_10

				arg_69_1.typewritter:SetDirty()
			end

			if arg_69_1.time_ >= var_72_0 + var_72_10 and arg_69_1.time_ < var_72_0 + var_72_10 + arg_72_0 then
				arg_69_1.typewritter.percent = 1

				arg_69_1.typewritter:SetDirty()
				arg_69_1:ShowNextGo(true)
			end
		end

		arg_69_1.nodeConfigList_ = {}

		arg_69_1:InitPlayNodeList()
	end,
	Play114241018 = function(arg_73_0, arg_73_1)
		arg_73_1.time_ = 0
		arg_73_1.frameCnt_ = 0
		arg_73_1.state_ = "playing"
		arg_73_1.curTalkId_ = 114241018
		arg_73_1.duration_ = 4.1

		local var_73_0 = {
			ja = 4.1,
			ko = 2.933,
			zh = 2.6,
			en = 3.366
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
				arg_73_0:Play114241019(arg_73_1)
			end
		end

		function arg_73_1.onSingleLineUpdate_(arg_76_0)
			local var_76_0 = arg_73_1.actors_["10015"]
			local var_76_1 = 0

			if var_76_1 < arg_73_1.time_ and arg_73_1.time_ <= var_76_1 + arg_76_0 and not isNil(var_76_0) and arg_73_1.var_.actorSpriteComps10015 == nil then
				arg_73_1.var_.actorSpriteComps10015 = var_76_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_76_2 = 0.034

			if var_76_1 <= arg_73_1.time_ and arg_73_1.time_ < var_76_1 + var_76_2 and not isNil(var_76_0) then
				local var_76_3 = (arg_73_1.time_ - var_76_1) / var_76_2

				if arg_73_1.var_.actorSpriteComps10015 then
					for iter_76_0, iter_76_1 in pairs(arg_73_1.var_.actorSpriteComps10015:ToTable()) do
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

			if arg_73_1.time_ >= var_76_1 + var_76_2 and arg_73_1.time_ < var_76_1 + var_76_2 + arg_76_0 and not isNil(var_76_0) and arg_73_1.var_.actorSpriteComps10015 then
				for iter_76_2, iter_76_3 in pairs(arg_73_1.var_.actorSpriteComps10015:ToTable()) do
					if iter_76_3 then
						if arg_73_1.isInRecall_ then
							iter_76_3.color = arg_73_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_76_3.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_73_1.var_.actorSpriteComps10015 = nil
			end

			local var_76_8 = arg_73_1.actors_["10018"]
			local var_76_9 = 0

			if var_76_9 < arg_73_1.time_ and arg_73_1.time_ <= var_76_9 + arg_76_0 and not isNil(var_76_8) and arg_73_1.var_.actorSpriteComps10018 == nil then
				arg_73_1.var_.actorSpriteComps10018 = var_76_8:GetComponentsInChildren(typeof(Image), true)
			end

			local var_76_10 = 0.034

			if var_76_9 <= arg_73_1.time_ and arg_73_1.time_ < var_76_9 + var_76_10 and not isNil(var_76_8) then
				local var_76_11 = (arg_73_1.time_ - var_76_9) / var_76_10

				if arg_73_1.var_.actorSpriteComps10018 then
					for iter_76_4, iter_76_5 in pairs(arg_73_1.var_.actorSpriteComps10018:ToTable()) do
						if iter_76_5 then
							if arg_73_1.isInRecall_ then
								local var_76_12 = Mathf.Lerp(iter_76_5.color.r, arg_73_1.hightColor2.r, var_76_11)
								local var_76_13 = Mathf.Lerp(iter_76_5.color.g, arg_73_1.hightColor2.g, var_76_11)
								local var_76_14 = Mathf.Lerp(iter_76_5.color.b, arg_73_1.hightColor2.b, var_76_11)

								iter_76_5.color = Color.New(var_76_12, var_76_13, var_76_14)
							else
								local var_76_15 = Mathf.Lerp(iter_76_5.color.r, 0.5, var_76_11)

								iter_76_5.color = Color.New(var_76_15, var_76_15, var_76_15)
							end
						end
					end
				end
			end

			if arg_73_1.time_ >= var_76_9 + var_76_10 and arg_73_1.time_ < var_76_9 + var_76_10 + arg_76_0 and not isNil(var_76_8) and arg_73_1.var_.actorSpriteComps10018 then
				for iter_76_6, iter_76_7 in pairs(arg_73_1.var_.actorSpriteComps10018:ToTable()) do
					if iter_76_7 then
						if arg_73_1.isInRecall_ then
							iter_76_7.color = arg_73_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_76_7.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_73_1.var_.actorSpriteComps10018 = nil
			end

			local var_76_16 = 0
			local var_76_17 = 0.275

			if var_76_16 < arg_73_1.time_ and arg_73_1.time_ <= var_76_16 + arg_76_0 then
				arg_73_1.talkMaxDuration = 0
				arg_73_1.dialogCg_.alpha = 1

				arg_73_1.dialog_:SetActive(true)
				SetActive(arg_73_1.leftNameGo_, true)

				local var_76_18 = arg_73_1:FormatText(StoryNameCfg[208].name)

				arg_73_1.leftNameTxt_.text = var_76_18

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_73_1.leftNameTxt_.transform)

				arg_73_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_73_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_73_1:RecordName(arg_73_1.leftNameTxt_.text)
				SetActive(arg_73_1.iconTrs_.gameObject, false)
				arg_73_1.callingController_:SetSelectedState("normal")

				local var_76_19 = arg_73_1:GetWordFromCfg(114241018)
				local var_76_20 = arg_73_1:FormatText(var_76_19.content)

				arg_73_1.text_.text = var_76_20

				LuaForUtil.ClearLinePrefixSymbol(arg_73_1.text_)

				local var_76_21 = 11
				local var_76_22 = utf8.len(var_76_20)
				local var_76_23 = var_76_21 <= 0 and var_76_17 or var_76_17 * (var_76_22 / var_76_21)

				if var_76_23 > 0 and var_76_17 < var_76_23 then
					arg_73_1.talkMaxDuration = var_76_23

					if var_76_23 + var_76_16 > arg_73_1.duration_ then
						arg_73_1.duration_ = var_76_23 + var_76_16
					end
				end

				arg_73_1.text_.text = var_76_20
				arg_73_1.typewritter.percent = 0

				arg_73_1.typewritter:SetDirty()
				arg_73_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_114241", "114241018", "story_v_out_114241.awb") ~= 0 then
					local var_76_24 = manager.audio:GetVoiceLength("story_v_out_114241", "114241018", "story_v_out_114241.awb") / 1000

					if var_76_24 + var_76_16 > arg_73_1.duration_ then
						arg_73_1.duration_ = var_76_24 + var_76_16
					end

					if var_76_19.prefab_name ~= "" and arg_73_1.actors_[var_76_19.prefab_name] ~= nil then
						local var_76_25 = LuaForUtil.PlayVoiceWithCriLipsync(arg_73_1.actors_[var_76_19.prefab_name].transform, "story_v_out_114241", "114241018", "story_v_out_114241.awb")

						arg_73_1:RecordAudio("114241018", var_76_25)
						arg_73_1:RecordAudio("114241018", var_76_25)
					else
						arg_73_1:AudioAction("play", "voice", "story_v_out_114241", "114241018", "story_v_out_114241.awb")
					end

					arg_73_1:RecordHistoryTalkVoice("story_v_out_114241", "114241018", "story_v_out_114241.awb")
				end

				arg_73_1:RecordContent(arg_73_1.text_.text)
			end

			local var_76_26 = math.max(var_76_17, arg_73_1.talkMaxDuration)

			if var_76_16 <= arg_73_1.time_ and arg_73_1.time_ < var_76_16 + var_76_26 then
				arg_73_1.typewritter.percent = (arg_73_1.time_ - var_76_16) / var_76_26

				arg_73_1.typewritter:SetDirty()
			end

			if arg_73_1.time_ >= var_76_16 + var_76_26 and arg_73_1.time_ < var_76_16 + var_76_26 + arg_76_0 then
				arg_73_1.typewritter.percent = 1

				arg_73_1.typewritter:SetDirty()
				arg_73_1:ShowNextGo(true)
			end
		end

		arg_73_1.nodeConfigList_ = {}

		arg_73_1:InitPlayNodeList()
	end,
	Play114241019 = function(arg_77_0, arg_77_1)
		arg_77_1.time_ = 0
		arg_77_1.frameCnt_ = 0
		arg_77_1.state_ = "playing"
		arg_77_1.curTalkId_ = 114241019
		arg_77_1.duration_ = 15.07

		local var_77_0 = {
			ja = 15.066,
			ko = 11.866,
			zh = 12.166,
			en = 12.7
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
				arg_77_0:Play114241020(arg_77_1)
			end
		end

		function arg_77_1.onSingleLineUpdate_(arg_80_0)
			local var_80_0 = arg_77_1.actors_["10015"]
			local var_80_1 = 0

			if var_80_1 < arg_77_1.time_ and arg_77_1.time_ <= var_80_1 + arg_80_0 and not isNil(var_80_0) and arg_77_1.var_.actorSpriteComps10015 == nil then
				arg_77_1.var_.actorSpriteComps10015 = var_80_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_80_2 = 0.034

			if var_80_1 <= arg_77_1.time_ and arg_77_1.time_ < var_80_1 + var_80_2 and not isNil(var_80_0) then
				local var_80_3 = (arg_77_1.time_ - var_80_1) / var_80_2

				if arg_77_1.var_.actorSpriteComps10015 then
					for iter_80_0, iter_80_1 in pairs(arg_77_1.var_.actorSpriteComps10015:ToTable()) do
						if iter_80_1 then
							if arg_77_1.isInRecall_ then
								local var_80_4 = Mathf.Lerp(iter_80_1.color.r, arg_77_1.hightColor2.r, var_80_3)
								local var_80_5 = Mathf.Lerp(iter_80_1.color.g, arg_77_1.hightColor2.g, var_80_3)
								local var_80_6 = Mathf.Lerp(iter_80_1.color.b, arg_77_1.hightColor2.b, var_80_3)

								iter_80_1.color = Color.New(var_80_4, var_80_5, var_80_6)
							else
								local var_80_7 = Mathf.Lerp(iter_80_1.color.r, 0.5, var_80_3)

								iter_80_1.color = Color.New(var_80_7, var_80_7, var_80_7)
							end
						end
					end
				end
			end

			if arg_77_1.time_ >= var_80_1 + var_80_2 and arg_77_1.time_ < var_80_1 + var_80_2 + arg_80_0 and not isNil(var_80_0) and arg_77_1.var_.actorSpriteComps10015 then
				for iter_80_2, iter_80_3 in pairs(arg_77_1.var_.actorSpriteComps10015:ToTable()) do
					if iter_80_3 then
						if arg_77_1.isInRecall_ then
							iter_80_3.color = arg_77_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_80_3.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_77_1.var_.actorSpriteComps10015 = nil
			end

			local var_80_8 = arg_77_1.actors_["10018"]
			local var_80_9 = 0

			if var_80_9 < arg_77_1.time_ and arg_77_1.time_ <= var_80_9 + arg_80_0 and not isNil(var_80_8) and arg_77_1.var_.actorSpriteComps10018 == nil then
				arg_77_1.var_.actorSpriteComps10018 = var_80_8:GetComponentsInChildren(typeof(Image), true)
			end

			local var_80_10 = 0.034

			if var_80_9 <= arg_77_1.time_ and arg_77_1.time_ < var_80_9 + var_80_10 and not isNil(var_80_8) then
				local var_80_11 = (arg_77_1.time_ - var_80_9) / var_80_10

				if arg_77_1.var_.actorSpriteComps10018 then
					for iter_80_4, iter_80_5 in pairs(arg_77_1.var_.actorSpriteComps10018:ToTable()) do
						if iter_80_5 then
							if arg_77_1.isInRecall_ then
								local var_80_12 = Mathf.Lerp(iter_80_5.color.r, arg_77_1.hightColor1.r, var_80_11)
								local var_80_13 = Mathf.Lerp(iter_80_5.color.g, arg_77_1.hightColor1.g, var_80_11)
								local var_80_14 = Mathf.Lerp(iter_80_5.color.b, arg_77_1.hightColor1.b, var_80_11)

								iter_80_5.color = Color.New(var_80_12, var_80_13, var_80_14)
							else
								local var_80_15 = Mathf.Lerp(iter_80_5.color.r, 1, var_80_11)

								iter_80_5.color = Color.New(var_80_15, var_80_15, var_80_15)
							end
						end
					end
				end
			end

			if arg_77_1.time_ >= var_80_9 + var_80_10 and arg_77_1.time_ < var_80_9 + var_80_10 + arg_80_0 and not isNil(var_80_8) and arg_77_1.var_.actorSpriteComps10018 then
				for iter_80_6, iter_80_7 in pairs(arg_77_1.var_.actorSpriteComps10018:ToTable()) do
					if iter_80_7 then
						if arg_77_1.isInRecall_ then
							iter_80_7.color = arg_77_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_80_7.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_77_1.var_.actorSpriteComps10018 = nil
			end

			local var_80_16 = 0
			local var_80_17 = 1.35

			if var_80_16 < arg_77_1.time_ and arg_77_1.time_ <= var_80_16 + arg_80_0 then
				arg_77_1.talkMaxDuration = 0
				arg_77_1.dialogCg_.alpha = 1

				arg_77_1.dialog_:SetActive(true)
				SetActive(arg_77_1.leftNameGo_, true)

				local var_80_18 = arg_77_1:FormatText(StoryNameCfg[257].name)

				arg_77_1.leftNameTxt_.text = var_80_18

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_77_1.leftNameTxt_.transform)

				arg_77_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_77_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_77_1:RecordName(arg_77_1.leftNameTxt_.text)
				SetActive(arg_77_1.iconTrs_.gameObject, false)
				arg_77_1.callingController_:SetSelectedState("normal")

				local var_80_19 = arg_77_1:GetWordFromCfg(114241019)
				local var_80_20 = arg_77_1:FormatText(var_80_19.content)

				arg_77_1.text_.text = var_80_20

				LuaForUtil.ClearLinePrefixSymbol(arg_77_1.text_)

				local var_80_21 = 54
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

				if manager.audio:GetVoiceLength("story_v_out_114241", "114241019", "story_v_out_114241.awb") ~= 0 then
					local var_80_24 = manager.audio:GetVoiceLength("story_v_out_114241", "114241019", "story_v_out_114241.awb") / 1000

					if var_80_24 + var_80_16 > arg_77_1.duration_ then
						arg_77_1.duration_ = var_80_24 + var_80_16
					end

					if var_80_19.prefab_name ~= "" and arg_77_1.actors_[var_80_19.prefab_name] ~= nil then
						local var_80_25 = LuaForUtil.PlayVoiceWithCriLipsync(arg_77_1.actors_[var_80_19.prefab_name].transform, "story_v_out_114241", "114241019", "story_v_out_114241.awb")

						arg_77_1:RecordAudio("114241019", var_80_25)
						arg_77_1:RecordAudio("114241019", var_80_25)
					else
						arg_77_1:AudioAction("play", "voice", "story_v_out_114241", "114241019", "story_v_out_114241.awb")
					end

					arg_77_1:RecordHistoryTalkVoice("story_v_out_114241", "114241019", "story_v_out_114241.awb")
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
	Play114241020 = function(arg_81_0, arg_81_1)
		arg_81_1.time_ = 0
		arg_81_1.frameCnt_ = 0
		arg_81_1.state_ = "playing"
		arg_81_1.curTalkId_ = 114241020
		arg_81_1.duration_ = 4.23

		local var_81_0 = {
			ja = 3.6,
			ko = 4.233,
			zh = 3.533,
			en = 3.266
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
				arg_81_0:Play114241021(arg_81_1)
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
			local var_84_17 = 0.375

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

				local var_84_19 = arg_81_1:GetWordFromCfg(114241020)
				local var_84_20 = arg_81_1:FormatText(var_84_19.content)

				arg_81_1.text_.text = var_84_20

				LuaForUtil.ClearLinePrefixSymbol(arg_81_1.text_)

				local var_84_21 = 15
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

				if manager.audio:GetVoiceLength("story_v_out_114241", "114241020", "story_v_out_114241.awb") ~= 0 then
					local var_84_24 = manager.audio:GetVoiceLength("story_v_out_114241", "114241020", "story_v_out_114241.awb") / 1000

					if var_84_24 + var_84_16 > arg_81_1.duration_ then
						arg_81_1.duration_ = var_84_24 + var_84_16
					end

					if var_84_19.prefab_name ~= "" and arg_81_1.actors_[var_84_19.prefab_name] ~= nil then
						local var_84_25 = LuaForUtil.PlayVoiceWithCriLipsync(arg_81_1.actors_[var_84_19.prefab_name].transform, "story_v_out_114241", "114241020", "story_v_out_114241.awb")

						arg_81_1:RecordAudio("114241020", var_84_25)
						arg_81_1:RecordAudio("114241020", var_84_25)
					else
						arg_81_1:AudioAction("play", "voice", "story_v_out_114241", "114241020", "story_v_out_114241.awb")
					end

					arg_81_1:RecordHistoryTalkVoice("story_v_out_114241", "114241020", "story_v_out_114241.awb")
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
	Play114241021 = function(arg_85_0, arg_85_1)
		arg_85_1.time_ = 0
		arg_85_1.frameCnt_ = 0
		arg_85_1.state_ = "playing"
		arg_85_1.curTalkId_ = 114241021
		arg_85_1.duration_ = 6.23

		local var_85_0 = {
			ja = 5.3,
			ko = 5.6,
			zh = 6.233,
			en = 5.433
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
				arg_85_0:Play114241022(arg_85_1)
			end
		end

		function arg_85_1.onSingleLineUpdate_(arg_88_0)
			local var_88_0 = arg_85_1.actors_["10015"]
			local var_88_1 = 0

			if var_88_1 < arg_85_1.time_ and arg_85_1.time_ <= var_88_1 + arg_88_0 and not isNil(var_88_0) and arg_85_1.var_.actorSpriteComps10015 == nil then
				arg_85_1.var_.actorSpriteComps10015 = var_88_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_88_2 = 0.034

			if var_88_1 <= arg_85_1.time_ and arg_85_1.time_ < var_88_1 + var_88_2 and not isNil(var_88_0) then
				local var_88_3 = (arg_85_1.time_ - var_88_1) / var_88_2

				if arg_85_1.var_.actorSpriteComps10015 then
					for iter_88_0, iter_88_1 in pairs(arg_85_1.var_.actorSpriteComps10015:ToTable()) do
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

			if arg_85_1.time_ >= var_88_1 + var_88_2 and arg_85_1.time_ < var_88_1 + var_88_2 + arg_88_0 and not isNil(var_88_0) and arg_85_1.var_.actorSpriteComps10015 then
				for iter_88_2, iter_88_3 in pairs(arg_85_1.var_.actorSpriteComps10015:ToTable()) do
					if iter_88_3 then
						if arg_85_1.isInRecall_ then
							iter_88_3.color = arg_85_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_88_3.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_85_1.var_.actorSpriteComps10015 = nil
			end

			local var_88_8 = arg_85_1.actors_["10018"]
			local var_88_9 = 0

			if var_88_9 < arg_85_1.time_ and arg_85_1.time_ <= var_88_9 + arg_88_0 and not isNil(var_88_8) and arg_85_1.var_.actorSpriteComps10018 == nil then
				arg_85_1.var_.actorSpriteComps10018 = var_88_8:GetComponentsInChildren(typeof(Image), true)
			end

			local var_88_10 = 0.034

			if var_88_9 <= arg_85_1.time_ and arg_85_1.time_ < var_88_9 + var_88_10 and not isNil(var_88_8) then
				local var_88_11 = (arg_85_1.time_ - var_88_9) / var_88_10

				if arg_85_1.var_.actorSpriteComps10018 then
					for iter_88_4, iter_88_5 in pairs(arg_85_1.var_.actorSpriteComps10018:ToTable()) do
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

			if arg_85_1.time_ >= var_88_9 + var_88_10 and arg_85_1.time_ < var_88_9 + var_88_10 + arg_88_0 and not isNil(var_88_8) and arg_85_1.var_.actorSpriteComps10018 then
				for iter_88_6, iter_88_7 in pairs(arg_85_1.var_.actorSpriteComps10018:ToTable()) do
					if iter_88_7 then
						if arg_85_1.isInRecall_ then
							iter_88_7.color = arg_85_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_88_7.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_85_1.var_.actorSpriteComps10018 = nil
			end

			local var_88_16 = 0
			local var_88_17 = 0.525

			if var_88_16 < arg_85_1.time_ and arg_85_1.time_ <= var_88_16 + arg_88_0 then
				arg_85_1.talkMaxDuration = 0
				arg_85_1.dialogCg_.alpha = 1

				arg_85_1.dialog_:SetActive(true)
				SetActive(arg_85_1.leftNameGo_, true)

				local var_88_18 = arg_85_1:FormatText(StoryNameCfg[257].name)

				arg_85_1.leftNameTxt_.text = var_88_18

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_85_1.leftNameTxt_.transform)

				arg_85_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_85_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_85_1:RecordName(arg_85_1.leftNameTxt_.text)
				SetActive(arg_85_1.iconTrs_.gameObject, false)
				arg_85_1.callingController_:SetSelectedState("normal")

				local var_88_19 = arg_85_1:GetWordFromCfg(114241021)
				local var_88_20 = arg_85_1:FormatText(var_88_19.content)

				arg_85_1.text_.text = var_88_20

				LuaForUtil.ClearLinePrefixSymbol(arg_85_1.text_)

				local var_88_21 = 21
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

				if manager.audio:GetVoiceLength("story_v_out_114241", "114241021", "story_v_out_114241.awb") ~= 0 then
					local var_88_24 = manager.audio:GetVoiceLength("story_v_out_114241", "114241021", "story_v_out_114241.awb") / 1000

					if var_88_24 + var_88_16 > arg_85_1.duration_ then
						arg_85_1.duration_ = var_88_24 + var_88_16
					end

					if var_88_19.prefab_name ~= "" and arg_85_1.actors_[var_88_19.prefab_name] ~= nil then
						local var_88_25 = LuaForUtil.PlayVoiceWithCriLipsync(arg_85_1.actors_[var_88_19.prefab_name].transform, "story_v_out_114241", "114241021", "story_v_out_114241.awb")

						arg_85_1:RecordAudio("114241021", var_88_25)
						arg_85_1:RecordAudio("114241021", var_88_25)
					else
						arg_85_1:AudioAction("play", "voice", "story_v_out_114241", "114241021", "story_v_out_114241.awb")
					end

					arg_85_1:RecordHistoryTalkVoice("story_v_out_114241", "114241021", "story_v_out_114241.awb")
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
	Play114241022 = function(arg_89_0, arg_89_1)
		arg_89_1.time_ = 0
		arg_89_1.frameCnt_ = 0
		arg_89_1.state_ = "playing"
		arg_89_1.curTalkId_ = 114241022
		arg_89_1.duration_ = 10

		local var_89_0 = {
			ja = 10,
			ko = 7.666,
			zh = 6.3,
			en = 7.433
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
				arg_89_0:Play114241023(arg_89_1)
			end
		end

		function arg_89_1.onSingleLineUpdate_(arg_92_0)
			local var_92_0 = arg_89_1.actors_["10015"]
			local var_92_1 = 0

			if var_92_1 < arg_89_1.time_ and arg_89_1.time_ <= var_92_1 + arg_92_0 and not isNil(var_92_0) and arg_89_1.var_.actorSpriteComps10015 == nil then
				arg_89_1.var_.actorSpriteComps10015 = var_92_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_92_2 = 0.034

			if var_92_1 <= arg_89_1.time_ and arg_89_1.time_ < var_92_1 + var_92_2 and not isNil(var_92_0) then
				local var_92_3 = (arg_89_1.time_ - var_92_1) / var_92_2

				if arg_89_1.var_.actorSpriteComps10015 then
					for iter_92_0, iter_92_1 in pairs(arg_89_1.var_.actorSpriteComps10015:ToTable()) do
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

			if arg_89_1.time_ >= var_92_1 + var_92_2 and arg_89_1.time_ < var_92_1 + var_92_2 + arg_92_0 and not isNil(var_92_0) and arg_89_1.var_.actorSpriteComps10015 then
				for iter_92_2, iter_92_3 in pairs(arg_89_1.var_.actorSpriteComps10015:ToTable()) do
					if iter_92_3 then
						if arg_89_1.isInRecall_ then
							iter_92_3.color = arg_89_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_92_3.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_89_1.var_.actorSpriteComps10015 = nil
			end

			local var_92_8 = arg_89_1.actors_["10018"]
			local var_92_9 = 0

			if var_92_9 < arg_89_1.time_ and arg_89_1.time_ <= var_92_9 + arg_92_0 and not isNil(var_92_8) and arg_89_1.var_.actorSpriteComps10018 == nil then
				arg_89_1.var_.actorSpriteComps10018 = var_92_8:GetComponentsInChildren(typeof(Image), true)
			end

			local var_92_10 = 0.034

			if var_92_9 <= arg_89_1.time_ and arg_89_1.time_ < var_92_9 + var_92_10 and not isNil(var_92_8) then
				local var_92_11 = (arg_89_1.time_ - var_92_9) / var_92_10

				if arg_89_1.var_.actorSpriteComps10018 then
					for iter_92_4, iter_92_5 in pairs(arg_89_1.var_.actorSpriteComps10018:ToTable()) do
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

			if arg_89_1.time_ >= var_92_9 + var_92_10 and arg_89_1.time_ < var_92_9 + var_92_10 + arg_92_0 and not isNil(var_92_8) and arg_89_1.var_.actorSpriteComps10018 then
				for iter_92_6, iter_92_7 in pairs(arg_89_1.var_.actorSpriteComps10018:ToTable()) do
					if iter_92_7 then
						if arg_89_1.isInRecall_ then
							iter_92_7.color = arg_89_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_92_7.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_89_1.var_.actorSpriteComps10018 = nil
			end

			local var_92_16 = 0
			local var_92_17 = 0.75

			if var_92_16 < arg_89_1.time_ and arg_89_1.time_ <= var_92_16 + arg_92_0 then
				arg_89_1.talkMaxDuration = 0
				arg_89_1.dialogCg_.alpha = 1

				arg_89_1.dialog_:SetActive(true)
				SetActive(arg_89_1.leftNameGo_, true)

				local var_92_18 = arg_89_1:FormatText(StoryNameCfg[208].name)

				arg_89_1.leftNameTxt_.text = var_92_18

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_89_1.leftNameTxt_.transform)

				arg_89_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_89_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_89_1:RecordName(arg_89_1.leftNameTxt_.text)
				SetActive(arg_89_1.iconTrs_.gameObject, false)
				arg_89_1.callingController_:SetSelectedState("normal")

				local var_92_19 = arg_89_1:GetWordFromCfg(114241022)
				local var_92_20 = arg_89_1:FormatText(var_92_19.content)

				arg_89_1.text_.text = var_92_20

				LuaForUtil.ClearLinePrefixSymbol(arg_89_1.text_)

				local var_92_21 = 30
				local var_92_22 = utf8.len(var_92_20)
				local var_92_23 = var_92_21 <= 0 and var_92_17 or var_92_17 * (var_92_22 / var_92_21)

				if var_92_23 > 0 and var_92_17 < var_92_23 then
					arg_89_1.talkMaxDuration = var_92_23

					if var_92_23 + var_92_16 > arg_89_1.duration_ then
						arg_89_1.duration_ = var_92_23 + var_92_16
					end
				end

				arg_89_1.text_.text = var_92_20
				arg_89_1.typewritter.percent = 0

				arg_89_1.typewritter:SetDirty()
				arg_89_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_114241", "114241022", "story_v_out_114241.awb") ~= 0 then
					local var_92_24 = manager.audio:GetVoiceLength("story_v_out_114241", "114241022", "story_v_out_114241.awb") / 1000

					if var_92_24 + var_92_16 > arg_89_1.duration_ then
						arg_89_1.duration_ = var_92_24 + var_92_16
					end

					if var_92_19.prefab_name ~= "" and arg_89_1.actors_[var_92_19.prefab_name] ~= nil then
						local var_92_25 = LuaForUtil.PlayVoiceWithCriLipsync(arg_89_1.actors_[var_92_19.prefab_name].transform, "story_v_out_114241", "114241022", "story_v_out_114241.awb")

						arg_89_1:RecordAudio("114241022", var_92_25)
						arg_89_1:RecordAudio("114241022", var_92_25)
					else
						arg_89_1:AudioAction("play", "voice", "story_v_out_114241", "114241022", "story_v_out_114241.awb")
					end

					arg_89_1:RecordHistoryTalkVoice("story_v_out_114241", "114241022", "story_v_out_114241.awb")
				end

				arg_89_1:RecordContent(arg_89_1.text_.text)
			end

			local var_92_26 = math.max(var_92_17, arg_89_1.talkMaxDuration)

			if var_92_16 <= arg_89_1.time_ and arg_89_1.time_ < var_92_16 + var_92_26 then
				arg_89_1.typewritter.percent = (arg_89_1.time_ - var_92_16) / var_92_26

				arg_89_1.typewritter:SetDirty()
			end

			if arg_89_1.time_ >= var_92_16 + var_92_26 and arg_89_1.time_ < var_92_16 + var_92_26 + arg_92_0 then
				arg_89_1.typewritter.percent = 1

				arg_89_1.typewritter:SetDirty()
				arg_89_1:ShowNextGo(true)
			end
		end

		arg_89_1.nodeConfigList_ = {}

		arg_89_1:InitPlayNodeList()
	end,
	Play114241023 = function(arg_93_0, arg_93_1)
		arg_93_1.time_ = 0
		arg_93_1.frameCnt_ = 0
		arg_93_1.state_ = "playing"
		arg_93_1.curTalkId_ = 114241023
		arg_93_1.duration_ = 4.37

		local var_93_0 = {
			ja = 3.9,
			ko = 3.3,
			zh = 4.266,
			en = 4.366
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
				arg_93_0:Play114241024(arg_93_1)
			end
		end

		function arg_93_1.onSingleLineUpdate_(arg_96_0)
			local var_96_0 = arg_93_1.actors_["10015"]
			local var_96_1 = 0

			if var_96_1 < arg_93_1.time_ and arg_93_1.time_ <= var_96_1 + arg_96_0 and not isNil(var_96_0) and arg_93_1.var_.actorSpriteComps10015 == nil then
				arg_93_1.var_.actorSpriteComps10015 = var_96_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_96_2 = 0.034

			if var_96_1 <= arg_93_1.time_ and arg_93_1.time_ < var_96_1 + var_96_2 and not isNil(var_96_0) then
				local var_96_3 = (arg_93_1.time_ - var_96_1) / var_96_2

				if arg_93_1.var_.actorSpriteComps10015 then
					for iter_96_0, iter_96_1 in pairs(arg_93_1.var_.actorSpriteComps10015:ToTable()) do
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

			if arg_93_1.time_ >= var_96_1 + var_96_2 and arg_93_1.time_ < var_96_1 + var_96_2 + arg_96_0 and not isNil(var_96_0) and arg_93_1.var_.actorSpriteComps10015 then
				for iter_96_2, iter_96_3 in pairs(arg_93_1.var_.actorSpriteComps10015:ToTable()) do
					if iter_96_3 then
						if arg_93_1.isInRecall_ then
							iter_96_3.color = arg_93_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_96_3.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_93_1.var_.actorSpriteComps10015 = nil
			end

			local var_96_8 = arg_93_1.actors_["10018"]
			local var_96_9 = 0

			if var_96_9 < arg_93_1.time_ and arg_93_1.time_ <= var_96_9 + arg_96_0 and not isNil(var_96_8) and arg_93_1.var_.actorSpriteComps10018 == nil then
				arg_93_1.var_.actorSpriteComps10018 = var_96_8:GetComponentsInChildren(typeof(Image), true)
			end

			local var_96_10 = 0.034

			if var_96_9 <= arg_93_1.time_ and arg_93_1.time_ < var_96_9 + var_96_10 and not isNil(var_96_8) then
				local var_96_11 = (arg_93_1.time_ - var_96_9) / var_96_10

				if arg_93_1.var_.actorSpriteComps10018 then
					for iter_96_4, iter_96_5 in pairs(arg_93_1.var_.actorSpriteComps10018:ToTable()) do
						if iter_96_5 then
							if arg_93_1.isInRecall_ then
								local var_96_12 = Mathf.Lerp(iter_96_5.color.r, arg_93_1.hightColor1.r, var_96_11)
								local var_96_13 = Mathf.Lerp(iter_96_5.color.g, arg_93_1.hightColor1.g, var_96_11)
								local var_96_14 = Mathf.Lerp(iter_96_5.color.b, arg_93_1.hightColor1.b, var_96_11)

								iter_96_5.color = Color.New(var_96_12, var_96_13, var_96_14)
							else
								local var_96_15 = Mathf.Lerp(iter_96_5.color.r, 1, var_96_11)

								iter_96_5.color = Color.New(var_96_15, var_96_15, var_96_15)
							end
						end
					end
				end
			end

			if arg_93_1.time_ >= var_96_9 + var_96_10 and arg_93_1.time_ < var_96_9 + var_96_10 + arg_96_0 and not isNil(var_96_8) and arg_93_1.var_.actorSpriteComps10018 then
				for iter_96_6, iter_96_7 in pairs(arg_93_1.var_.actorSpriteComps10018:ToTable()) do
					if iter_96_7 then
						if arg_93_1.isInRecall_ then
							iter_96_7.color = arg_93_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_96_7.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_93_1.var_.actorSpriteComps10018 = nil
			end

			local var_96_16 = 0
			local var_96_17 = 0.35

			if var_96_16 < arg_93_1.time_ and arg_93_1.time_ <= var_96_16 + arg_96_0 then
				arg_93_1.talkMaxDuration = 0
				arg_93_1.dialogCg_.alpha = 1

				arg_93_1.dialog_:SetActive(true)
				SetActive(arg_93_1.leftNameGo_, true)

				local var_96_18 = arg_93_1:FormatText(StoryNameCfg[257].name)

				arg_93_1.leftNameTxt_.text = var_96_18

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_93_1.leftNameTxt_.transform)

				arg_93_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_93_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_93_1:RecordName(arg_93_1.leftNameTxt_.text)
				SetActive(arg_93_1.iconTrs_.gameObject, false)
				arg_93_1.callingController_:SetSelectedState("normal")

				local var_96_19 = arg_93_1:GetWordFromCfg(114241023)
				local var_96_20 = arg_93_1:FormatText(var_96_19.content)

				arg_93_1.text_.text = var_96_20

				LuaForUtil.ClearLinePrefixSymbol(arg_93_1.text_)

				local var_96_21 = 14
				local var_96_22 = utf8.len(var_96_20)
				local var_96_23 = var_96_21 <= 0 and var_96_17 or var_96_17 * (var_96_22 / var_96_21)

				if var_96_23 > 0 and var_96_17 < var_96_23 then
					arg_93_1.talkMaxDuration = var_96_23

					if var_96_23 + var_96_16 > arg_93_1.duration_ then
						arg_93_1.duration_ = var_96_23 + var_96_16
					end
				end

				arg_93_1.text_.text = var_96_20
				arg_93_1.typewritter.percent = 0

				arg_93_1.typewritter:SetDirty()
				arg_93_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_114241", "114241023", "story_v_out_114241.awb") ~= 0 then
					local var_96_24 = manager.audio:GetVoiceLength("story_v_out_114241", "114241023", "story_v_out_114241.awb") / 1000

					if var_96_24 + var_96_16 > arg_93_1.duration_ then
						arg_93_1.duration_ = var_96_24 + var_96_16
					end

					if var_96_19.prefab_name ~= "" and arg_93_1.actors_[var_96_19.prefab_name] ~= nil then
						local var_96_25 = LuaForUtil.PlayVoiceWithCriLipsync(arg_93_1.actors_[var_96_19.prefab_name].transform, "story_v_out_114241", "114241023", "story_v_out_114241.awb")

						arg_93_1:RecordAudio("114241023", var_96_25)
						arg_93_1:RecordAudio("114241023", var_96_25)
					else
						arg_93_1:AudioAction("play", "voice", "story_v_out_114241", "114241023", "story_v_out_114241.awb")
					end

					arg_93_1:RecordHistoryTalkVoice("story_v_out_114241", "114241023", "story_v_out_114241.awb")
				end

				arg_93_1:RecordContent(arg_93_1.text_.text)
			end

			local var_96_26 = math.max(var_96_17, arg_93_1.talkMaxDuration)

			if var_96_16 <= arg_93_1.time_ and arg_93_1.time_ < var_96_16 + var_96_26 then
				arg_93_1.typewritter.percent = (arg_93_1.time_ - var_96_16) / var_96_26

				arg_93_1.typewritter:SetDirty()
			end

			if arg_93_1.time_ >= var_96_16 + var_96_26 and arg_93_1.time_ < var_96_16 + var_96_26 + arg_96_0 then
				arg_93_1.typewritter.percent = 1

				arg_93_1.typewritter:SetDirty()
				arg_93_1:ShowNextGo(true)
			end
		end

		arg_93_1.nodeConfigList_ = {}

		arg_93_1:InitPlayNodeList()
	end,
	Play114241024 = function(arg_97_0, arg_97_1)
		arg_97_1.time_ = 0
		arg_97_1.frameCnt_ = 0
		arg_97_1.state_ = "playing"
		arg_97_1.curTalkId_ = 114241024
		arg_97_1.duration_ = 5

		SetActive(arg_97_1.tipsGo_, false)

		function arg_97_1.onSingleLineFinish_()
			arg_97_1.onSingleLineUpdate_ = nil
			arg_97_1.onSingleLineFinish_ = nil
			arg_97_1.state_ = "waiting"
		end

		function arg_97_1.playNext_(arg_99_0)
			if arg_99_0 == 1 then
				arg_97_0:Play114241025(arg_97_1)
			end
		end

		function arg_97_1.onSingleLineUpdate_(arg_100_0)
			local var_100_0 = arg_97_1.actors_["10018"]
			local var_100_1 = 0

			if var_100_1 < arg_97_1.time_ and arg_97_1.time_ <= var_100_1 + arg_100_0 and not isNil(var_100_0) and arg_97_1.var_.actorSpriteComps10018 == nil then
				arg_97_1.var_.actorSpriteComps10018 = var_100_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_100_2 = 0.034

			if var_100_1 <= arg_97_1.time_ and arg_97_1.time_ < var_100_1 + var_100_2 and not isNil(var_100_0) then
				local var_100_3 = (arg_97_1.time_ - var_100_1) / var_100_2

				if arg_97_1.var_.actorSpriteComps10018 then
					for iter_100_0, iter_100_1 in pairs(arg_97_1.var_.actorSpriteComps10018:ToTable()) do
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

			if arg_97_1.time_ >= var_100_1 + var_100_2 and arg_97_1.time_ < var_100_1 + var_100_2 + arg_100_0 and not isNil(var_100_0) and arg_97_1.var_.actorSpriteComps10018 then
				for iter_100_2, iter_100_3 in pairs(arg_97_1.var_.actorSpriteComps10018:ToTable()) do
					if iter_100_3 then
						if arg_97_1.isInRecall_ then
							iter_100_3.color = arg_97_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_100_3.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_97_1.var_.actorSpriteComps10018 = nil
			end

			local var_100_8 = 0
			local var_100_9 = 0.475

			if var_100_8 < arg_97_1.time_ and arg_97_1.time_ <= var_100_8 + arg_100_0 then
				arg_97_1.talkMaxDuration = 0
				arg_97_1.dialogCg_.alpha = 1

				arg_97_1.dialog_:SetActive(true)
				SetActive(arg_97_1.leftNameGo_, false)

				arg_97_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_97_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_97_1:RecordName(arg_97_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_97_1.iconTrs_.gameObject, false)
				arg_97_1.callingController_:SetSelectedState("normal")

				local var_100_10 = arg_97_1:GetWordFromCfg(114241024)
				local var_100_11 = arg_97_1:FormatText(var_100_10.content)

				arg_97_1.text_.text = var_100_11

				LuaForUtil.ClearLinePrefixSymbol(arg_97_1.text_)

				local var_100_12 = 19
				local var_100_13 = utf8.len(var_100_11)
				local var_100_14 = var_100_12 <= 0 and var_100_9 or var_100_9 * (var_100_13 / var_100_12)

				if var_100_14 > 0 and var_100_9 < var_100_14 then
					arg_97_1.talkMaxDuration = var_100_14

					if var_100_14 + var_100_8 > arg_97_1.duration_ then
						arg_97_1.duration_ = var_100_14 + var_100_8
					end
				end

				arg_97_1.text_.text = var_100_11
				arg_97_1.typewritter.percent = 0

				arg_97_1.typewritter:SetDirty()
				arg_97_1:ShowNextGo(false)
				arg_97_1:RecordContent(arg_97_1.text_.text)
			end

			local var_100_15 = math.max(var_100_9, arg_97_1.talkMaxDuration)

			if var_100_8 <= arg_97_1.time_ and arg_97_1.time_ < var_100_8 + var_100_15 then
				arg_97_1.typewritter.percent = (arg_97_1.time_ - var_100_8) / var_100_15

				arg_97_1.typewritter:SetDirty()
			end

			if arg_97_1.time_ >= var_100_8 + var_100_15 and arg_97_1.time_ < var_100_8 + var_100_15 + arg_100_0 then
				arg_97_1.typewritter.percent = 1

				arg_97_1.typewritter:SetDirty()
				arg_97_1:ShowNextGo(true)
			end
		end

		arg_97_1.nodeConfigList_ = {}

		arg_97_1:InitPlayNodeList()
	end,
	Play114241025 = function(arg_101_0, arg_101_1)
		arg_101_1.time_ = 0
		arg_101_1.frameCnt_ = 0
		arg_101_1.state_ = "playing"
		arg_101_1.curTalkId_ = 114241025
		arg_101_1.duration_ = 13.43

		local var_101_0 = {
			ja = 9.2,
			ko = 10.1,
			zh = 13.433,
			en = 12.166
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
				arg_101_0:Play114241026(arg_101_1)
			end
		end

		function arg_101_1.onSingleLineUpdate_(arg_104_0)
			local var_104_0 = arg_101_1.actors_["10018"]
			local var_104_1 = 0

			if var_104_1 < arg_101_1.time_ and arg_101_1.time_ <= var_104_1 + arg_104_0 and not isNil(var_104_0) and arg_101_1.var_.actorSpriteComps10018 == nil then
				arg_101_1.var_.actorSpriteComps10018 = var_104_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_104_2 = 0.034

			if var_104_1 <= arg_101_1.time_ and arg_101_1.time_ < var_104_1 + var_104_2 and not isNil(var_104_0) then
				local var_104_3 = (arg_101_1.time_ - var_104_1) / var_104_2

				if arg_101_1.var_.actorSpriteComps10018 then
					for iter_104_0, iter_104_1 in pairs(arg_101_1.var_.actorSpriteComps10018:ToTable()) do
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

			if arg_101_1.time_ >= var_104_1 + var_104_2 and arg_101_1.time_ < var_104_1 + var_104_2 + arg_104_0 and not isNil(var_104_0) and arg_101_1.var_.actorSpriteComps10018 then
				for iter_104_2, iter_104_3 in pairs(arg_101_1.var_.actorSpriteComps10018:ToTable()) do
					if iter_104_3 then
						if arg_101_1.isInRecall_ then
							iter_104_3.color = arg_101_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_104_3.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_101_1.var_.actorSpriteComps10018 = nil
			end

			local var_104_8 = 0
			local var_104_9 = 1.375

			if var_104_8 < arg_101_1.time_ and arg_101_1.time_ <= var_104_8 + arg_104_0 then
				arg_101_1.talkMaxDuration = 0
				arg_101_1.dialogCg_.alpha = 1

				arg_101_1.dialog_:SetActive(true)
				SetActive(arg_101_1.leftNameGo_, true)

				local var_104_10 = arg_101_1:FormatText(StoryNameCfg[257].name)

				arg_101_1.leftNameTxt_.text = var_104_10

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_101_1.leftNameTxt_.transform)

				arg_101_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_101_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_101_1:RecordName(arg_101_1.leftNameTxt_.text)
				SetActive(arg_101_1.iconTrs_.gameObject, false)
				arg_101_1.callingController_:SetSelectedState("normal")

				local var_104_11 = arg_101_1:GetWordFromCfg(114241025)
				local var_104_12 = arg_101_1:FormatText(var_104_11.content)

				arg_101_1.text_.text = var_104_12

				LuaForUtil.ClearLinePrefixSymbol(arg_101_1.text_)

				local var_104_13 = 55
				local var_104_14 = utf8.len(var_104_12)
				local var_104_15 = var_104_13 <= 0 and var_104_9 or var_104_9 * (var_104_14 / var_104_13)

				if var_104_15 > 0 and var_104_9 < var_104_15 then
					arg_101_1.talkMaxDuration = var_104_15

					if var_104_15 + var_104_8 > arg_101_1.duration_ then
						arg_101_1.duration_ = var_104_15 + var_104_8
					end
				end

				arg_101_1.text_.text = var_104_12
				arg_101_1.typewritter.percent = 0

				arg_101_1.typewritter:SetDirty()
				arg_101_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_114241", "114241025", "story_v_out_114241.awb") ~= 0 then
					local var_104_16 = manager.audio:GetVoiceLength("story_v_out_114241", "114241025", "story_v_out_114241.awb") / 1000

					if var_104_16 + var_104_8 > arg_101_1.duration_ then
						arg_101_1.duration_ = var_104_16 + var_104_8
					end

					if var_104_11.prefab_name ~= "" and arg_101_1.actors_[var_104_11.prefab_name] ~= nil then
						local var_104_17 = LuaForUtil.PlayVoiceWithCriLipsync(arg_101_1.actors_[var_104_11.prefab_name].transform, "story_v_out_114241", "114241025", "story_v_out_114241.awb")

						arg_101_1:RecordAudio("114241025", var_104_17)
						arg_101_1:RecordAudio("114241025", var_104_17)
					else
						arg_101_1:AudioAction("play", "voice", "story_v_out_114241", "114241025", "story_v_out_114241.awb")
					end

					arg_101_1:RecordHistoryTalkVoice("story_v_out_114241", "114241025", "story_v_out_114241.awb")
				end

				arg_101_1:RecordContent(arg_101_1.text_.text)
			end

			local var_104_18 = math.max(var_104_9, arg_101_1.talkMaxDuration)

			if var_104_8 <= arg_101_1.time_ and arg_101_1.time_ < var_104_8 + var_104_18 then
				arg_101_1.typewritter.percent = (arg_101_1.time_ - var_104_8) / var_104_18

				arg_101_1.typewritter:SetDirty()
			end

			if arg_101_1.time_ >= var_104_8 + var_104_18 and arg_101_1.time_ < var_104_8 + var_104_18 + arg_104_0 then
				arg_101_1.typewritter.percent = 1

				arg_101_1.typewritter:SetDirty()
				arg_101_1:ShowNextGo(true)
			end
		end

		arg_101_1.nodeConfigList_ = {}

		arg_101_1:InitPlayNodeList()
	end,
	Play114241026 = function(arg_105_0, arg_105_1)
		arg_105_1.time_ = 0
		arg_105_1.frameCnt_ = 0
		arg_105_1.state_ = "playing"
		arg_105_1.curTalkId_ = 114241026
		arg_105_1.duration_ = 3.8

		local var_105_0 = {
			ja = 3.3,
			ko = 3.433,
			zh = 3.8,
			en = 3.033
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
				arg_105_0:Play114241027(arg_105_1)
			end
		end

		function arg_105_1.onSingleLineUpdate_(arg_108_0)
			local var_108_0 = arg_105_1.actors_["10015"]
			local var_108_1 = 0

			if var_108_1 < arg_105_1.time_ and arg_105_1.time_ <= var_108_1 + arg_108_0 and not isNil(var_108_0) and arg_105_1.var_.actorSpriteComps10015 == nil then
				arg_105_1.var_.actorSpriteComps10015 = var_108_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_108_2 = 0.034

			if var_108_1 <= arg_105_1.time_ and arg_105_1.time_ < var_108_1 + var_108_2 and not isNil(var_108_0) then
				local var_108_3 = (arg_105_1.time_ - var_108_1) / var_108_2

				if arg_105_1.var_.actorSpriteComps10015 then
					for iter_108_0, iter_108_1 in pairs(arg_105_1.var_.actorSpriteComps10015:ToTable()) do
						if iter_108_1 then
							if arg_105_1.isInRecall_ then
								local var_108_4 = Mathf.Lerp(iter_108_1.color.r, arg_105_1.hightColor1.r, var_108_3)
								local var_108_5 = Mathf.Lerp(iter_108_1.color.g, arg_105_1.hightColor1.g, var_108_3)
								local var_108_6 = Mathf.Lerp(iter_108_1.color.b, arg_105_1.hightColor1.b, var_108_3)

								iter_108_1.color = Color.New(var_108_4, var_108_5, var_108_6)
							else
								local var_108_7 = Mathf.Lerp(iter_108_1.color.r, 1, var_108_3)

								iter_108_1.color = Color.New(var_108_7, var_108_7, var_108_7)
							end
						end
					end
				end
			end

			if arg_105_1.time_ >= var_108_1 + var_108_2 and arg_105_1.time_ < var_108_1 + var_108_2 + arg_108_0 and not isNil(var_108_0) and arg_105_1.var_.actorSpriteComps10015 then
				for iter_108_2, iter_108_3 in pairs(arg_105_1.var_.actorSpriteComps10015:ToTable()) do
					if iter_108_3 then
						if arg_105_1.isInRecall_ then
							iter_108_3.color = arg_105_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_108_3.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_105_1.var_.actorSpriteComps10015 = nil
			end

			local var_108_8 = arg_105_1.actors_["10018"]
			local var_108_9 = 0

			if var_108_9 < arg_105_1.time_ and arg_105_1.time_ <= var_108_9 + arg_108_0 and not isNil(var_108_8) and arg_105_1.var_.actorSpriteComps10018 == nil then
				arg_105_1.var_.actorSpriteComps10018 = var_108_8:GetComponentsInChildren(typeof(Image), true)
			end

			local var_108_10 = 0.034

			if var_108_9 <= arg_105_1.time_ and arg_105_1.time_ < var_108_9 + var_108_10 and not isNil(var_108_8) then
				local var_108_11 = (arg_105_1.time_ - var_108_9) / var_108_10

				if arg_105_1.var_.actorSpriteComps10018 then
					for iter_108_4, iter_108_5 in pairs(arg_105_1.var_.actorSpriteComps10018:ToTable()) do
						if iter_108_5 then
							if arg_105_1.isInRecall_ then
								local var_108_12 = Mathf.Lerp(iter_108_5.color.r, arg_105_1.hightColor2.r, var_108_11)
								local var_108_13 = Mathf.Lerp(iter_108_5.color.g, arg_105_1.hightColor2.g, var_108_11)
								local var_108_14 = Mathf.Lerp(iter_108_5.color.b, arg_105_1.hightColor2.b, var_108_11)

								iter_108_5.color = Color.New(var_108_12, var_108_13, var_108_14)
							else
								local var_108_15 = Mathf.Lerp(iter_108_5.color.r, 0.5, var_108_11)

								iter_108_5.color = Color.New(var_108_15, var_108_15, var_108_15)
							end
						end
					end
				end
			end

			if arg_105_1.time_ >= var_108_9 + var_108_10 and arg_105_1.time_ < var_108_9 + var_108_10 + arg_108_0 and not isNil(var_108_8) and arg_105_1.var_.actorSpriteComps10018 then
				for iter_108_6, iter_108_7 in pairs(arg_105_1.var_.actorSpriteComps10018:ToTable()) do
					if iter_108_7 then
						if arg_105_1.isInRecall_ then
							iter_108_7.color = arg_105_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_108_7.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_105_1.var_.actorSpriteComps10018 = nil
			end

			local var_108_16 = 0
			local var_108_17 = 0.325

			if var_108_16 < arg_105_1.time_ and arg_105_1.time_ <= var_108_16 + arg_108_0 then
				arg_105_1.talkMaxDuration = 0
				arg_105_1.dialogCg_.alpha = 1

				arg_105_1.dialog_:SetActive(true)
				SetActive(arg_105_1.leftNameGo_, true)

				local var_108_18 = arg_105_1:FormatText(StoryNameCfg[208].name)

				arg_105_1.leftNameTxt_.text = var_108_18

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_105_1.leftNameTxt_.transform)

				arg_105_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_105_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_105_1:RecordName(arg_105_1.leftNameTxt_.text)
				SetActive(arg_105_1.iconTrs_.gameObject, false)
				arg_105_1.callingController_:SetSelectedState("normal")

				local var_108_19 = arg_105_1:GetWordFromCfg(114241026)
				local var_108_20 = arg_105_1:FormatText(var_108_19.content)

				arg_105_1.text_.text = var_108_20

				LuaForUtil.ClearLinePrefixSymbol(arg_105_1.text_)

				local var_108_21 = 13
				local var_108_22 = utf8.len(var_108_20)
				local var_108_23 = var_108_21 <= 0 and var_108_17 or var_108_17 * (var_108_22 / var_108_21)

				if var_108_23 > 0 and var_108_17 < var_108_23 then
					arg_105_1.talkMaxDuration = var_108_23

					if var_108_23 + var_108_16 > arg_105_1.duration_ then
						arg_105_1.duration_ = var_108_23 + var_108_16
					end
				end

				arg_105_1.text_.text = var_108_20
				arg_105_1.typewritter.percent = 0

				arg_105_1.typewritter:SetDirty()
				arg_105_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_114241", "114241026", "story_v_out_114241.awb") ~= 0 then
					local var_108_24 = manager.audio:GetVoiceLength("story_v_out_114241", "114241026", "story_v_out_114241.awb") / 1000

					if var_108_24 + var_108_16 > arg_105_1.duration_ then
						arg_105_1.duration_ = var_108_24 + var_108_16
					end

					if var_108_19.prefab_name ~= "" and arg_105_1.actors_[var_108_19.prefab_name] ~= nil then
						local var_108_25 = LuaForUtil.PlayVoiceWithCriLipsync(arg_105_1.actors_[var_108_19.prefab_name].transform, "story_v_out_114241", "114241026", "story_v_out_114241.awb")

						arg_105_1:RecordAudio("114241026", var_108_25)
						arg_105_1:RecordAudio("114241026", var_108_25)
					else
						arg_105_1:AudioAction("play", "voice", "story_v_out_114241", "114241026", "story_v_out_114241.awb")
					end

					arg_105_1:RecordHistoryTalkVoice("story_v_out_114241", "114241026", "story_v_out_114241.awb")
				end

				arg_105_1:RecordContent(arg_105_1.text_.text)
			end

			local var_108_26 = math.max(var_108_17, arg_105_1.talkMaxDuration)

			if var_108_16 <= arg_105_1.time_ and arg_105_1.time_ < var_108_16 + var_108_26 then
				arg_105_1.typewritter.percent = (arg_105_1.time_ - var_108_16) / var_108_26

				arg_105_1.typewritter:SetDirty()
			end

			if arg_105_1.time_ >= var_108_16 + var_108_26 and arg_105_1.time_ < var_108_16 + var_108_26 + arg_108_0 then
				arg_105_1.typewritter.percent = 1

				arg_105_1.typewritter:SetDirty()
				arg_105_1:ShowNextGo(true)
			end
		end

		arg_105_1.nodeConfigList_ = {}

		arg_105_1:InitPlayNodeList()
	end,
	Play114241027 = function(arg_109_0, arg_109_1)
		arg_109_1.time_ = 0
		arg_109_1.frameCnt_ = 0
		arg_109_1.state_ = "playing"
		arg_109_1.curTalkId_ = 114241027
		arg_109_1.duration_ = 2.67

		local var_109_0 = {
			ja = 2.333,
			ko = 1.2,
			zh = 1.533,
			en = 2.666
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
				arg_109_0:Play114241028(arg_109_1)
			end
		end

		function arg_109_1.onSingleLineUpdate_(arg_112_0)
			local var_112_0 = arg_109_1.actors_["10015"]
			local var_112_1 = 0

			if var_112_1 < arg_109_1.time_ and arg_109_1.time_ <= var_112_1 + arg_112_0 and not isNil(var_112_0) and arg_109_1.var_.actorSpriteComps10015 == nil then
				arg_109_1.var_.actorSpriteComps10015 = var_112_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_112_2 = 0.034

			if var_112_1 <= arg_109_1.time_ and arg_109_1.time_ < var_112_1 + var_112_2 and not isNil(var_112_0) then
				local var_112_3 = (arg_109_1.time_ - var_112_1) / var_112_2

				if arg_109_1.var_.actorSpriteComps10015 then
					for iter_112_0, iter_112_1 in pairs(arg_109_1.var_.actorSpriteComps10015:ToTable()) do
						if iter_112_1 then
							if arg_109_1.isInRecall_ then
								local var_112_4 = Mathf.Lerp(iter_112_1.color.r, arg_109_1.hightColor2.r, var_112_3)
								local var_112_5 = Mathf.Lerp(iter_112_1.color.g, arg_109_1.hightColor2.g, var_112_3)
								local var_112_6 = Mathf.Lerp(iter_112_1.color.b, arg_109_1.hightColor2.b, var_112_3)

								iter_112_1.color = Color.New(var_112_4, var_112_5, var_112_6)
							else
								local var_112_7 = Mathf.Lerp(iter_112_1.color.r, 0.5, var_112_3)

								iter_112_1.color = Color.New(var_112_7, var_112_7, var_112_7)
							end
						end
					end
				end
			end

			if arg_109_1.time_ >= var_112_1 + var_112_2 and arg_109_1.time_ < var_112_1 + var_112_2 + arg_112_0 and not isNil(var_112_0) and arg_109_1.var_.actorSpriteComps10015 then
				for iter_112_2, iter_112_3 in pairs(arg_109_1.var_.actorSpriteComps10015:ToTable()) do
					if iter_112_3 then
						if arg_109_1.isInRecall_ then
							iter_112_3.color = arg_109_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_112_3.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_109_1.var_.actorSpriteComps10015 = nil
			end

			local var_112_8 = arg_109_1.actors_["10018"]
			local var_112_9 = 0

			if var_112_9 < arg_109_1.time_ and arg_109_1.time_ <= var_112_9 + arg_112_0 and not isNil(var_112_8) and arg_109_1.var_.actorSpriteComps10018 == nil then
				arg_109_1.var_.actorSpriteComps10018 = var_112_8:GetComponentsInChildren(typeof(Image), true)
			end

			local var_112_10 = 0.034

			if var_112_9 <= arg_109_1.time_ and arg_109_1.time_ < var_112_9 + var_112_10 and not isNil(var_112_8) then
				local var_112_11 = (arg_109_1.time_ - var_112_9) / var_112_10

				if arg_109_1.var_.actorSpriteComps10018 then
					for iter_112_4, iter_112_5 in pairs(arg_109_1.var_.actorSpriteComps10018:ToTable()) do
						if iter_112_5 then
							if arg_109_1.isInRecall_ then
								local var_112_12 = Mathf.Lerp(iter_112_5.color.r, arg_109_1.hightColor1.r, var_112_11)
								local var_112_13 = Mathf.Lerp(iter_112_5.color.g, arg_109_1.hightColor1.g, var_112_11)
								local var_112_14 = Mathf.Lerp(iter_112_5.color.b, arg_109_1.hightColor1.b, var_112_11)

								iter_112_5.color = Color.New(var_112_12, var_112_13, var_112_14)
							else
								local var_112_15 = Mathf.Lerp(iter_112_5.color.r, 1, var_112_11)

								iter_112_5.color = Color.New(var_112_15, var_112_15, var_112_15)
							end
						end
					end
				end
			end

			if arg_109_1.time_ >= var_112_9 + var_112_10 and arg_109_1.time_ < var_112_9 + var_112_10 + arg_112_0 and not isNil(var_112_8) and arg_109_1.var_.actorSpriteComps10018 then
				for iter_112_6, iter_112_7 in pairs(arg_109_1.var_.actorSpriteComps10018:ToTable()) do
					if iter_112_7 then
						if arg_109_1.isInRecall_ then
							iter_112_7.color = arg_109_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_112_7.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_109_1.var_.actorSpriteComps10018 = nil
			end

			local var_112_16 = 0
			local var_112_17 = 0.125

			if var_112_16 < arg_109_1.time_ and arg_109_1.time_ <= var_112_16 + arg_112_0 then
				arg_109_1.talkMaxDuration = 0
				arg_109_1.dialogCg_.alpha = 1

				arg_109_1.dialog_:SetActive(true)
				SetActive(arg_109_1.leftNameGo_, true)

				local var_112_18 = arg_109_1:FormatText(StoryNameCfg[257].name)

				arg_109_1.leftNameTxt_.text = var_112_18

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_109_1.leftNameTxt_.transform)

				arg_109_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_109_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_109_1:RecordName(arg_109_1.leftNameTxt_.text)
				SetActive(arg_109_1.iconTrs_.gameObject, false)
				arg_109_1.callingController_:SetSelectedState("normal")

				local var_112_19 = arg_109_1:GetWordFromCfg(114241027)
				local var_112_20 = arg_109_1:FormatText(var_112_19.content)

				arg_109_1.text_.text = var_112_20

				LuaForUtil.ClearLinePrefixSymbol(arg_109_1.text_)

				local var_112_21 = 5
				local var_112_22 = utf8.len(var_112_20)
				local var_112_23 = var_112_21 <= 0 and var_112_17 or var_112_17 * (var_112_22 / var_112_21)

				if var_112_23 > 0 and var_112_17 < var_112_23 then
					arg_109_1.talkMaxDuration = var_112_23

					if var_112_23 + var_112_16 > arg_109_1.duration_ then
						arg_109_1.duration_ = var_112_23 + var_112_16
					end
				end

				arg_109_1.text_.text = var_112_20
				arg_109_1.typewritter.percent = 0

				arg_109_1.typewritter:SetDirty()
				arg_109_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_114241", "114241027", "story_v_out_114241.awb") ~= 0 then
					local var_112_24 = manager.audio:GetVoiceLength("story_v_out_114241", "114241027", "story_v_out_114241.awb") / 1000

					if var_112_24 + var_112_16 > arg_109_1.duration_ then
						arg_109_1.duration_ = var_112_24 + var_112_16
					end

					if var_112_19.prefab_name ~= "" and arg_109_1.actors_[var_112_19.prefab_name] ~= nil then
						local var_112_25 = LuaForUtil.PlayVoiceWithCriLipsync(arg_109_1.actors_[var_112_19.prefab_name].transform, "story_v_out_114241", "114241027", "story_v_out_114241.awb")

						arg_109_1:RecordAudio("114241027", var_112_25)
						arg_109_1:RecordAudio("114241027", var_112_25)
					else
						arg_109_1:AudioAction("play", "voice", "story_v_out_114241", "114241027", "story_v_out_114241.awb")
					end

					arg_109_1:RecordHistoryTalkVoice("story_v_out_114241", "114241027", "story_v_out_114241.awb")
				end

				arg_109_1:RecordContent(arg_109_1.text_.text)
			end

			local var_112_26 = math.max(var_112_17, arg_109_1.talkMaxDuration)

			if var_112_16 <= arg_109_1.time_ and arg_109_1.time_ < var_112_16 + var_112_26 then
				arg_109_1.typewritter.percent = (arg_109_1.time_ - var_112_16) / var_112_26

				arg_109_1.typewritter:SetDirty()
			end

			if arg_109_1.time_ >= var_112_16 + var_112_26 and arg_109_1.time_ < var_112_16 + var_112_26 + arg_112_0 then
				arg_109_1.typewritter.percent = 1

				arg_109_1.typewritter:SetDirty()
				arg_109_1:ShowNextGo(true)
			end
		end

		arg_109_1.nodeConfigList_ = {}

		arg_109_1:InitPlayNodeList()
	end,
	Play114241028 = function(arg_113_0, arg_113_1)
		arg_113_1.time_ = 0
		arg_113_1.frameCnt_ = 0
		arg_113_1.state_ = "playing"
		arg_113_1.curTalkId_ = 114241028
		arg_113_1.duration_ = 10.83

		local var_113_0 = {
			ja = 10.833,
			ko = 6,
			zh = 6.033,
			en = 4.266
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
				arg_113_0:Play114241029(arg_113_1)
			end
		end

		function arg_113_1.onSingleLineUpdate_(arg_116_0)
			local var_116_0 = arg_113_1.actors_["10015"]
			local var_116_1 = 0

			if var_116_1 < arg_113_1.time_ and arg_113_1.time_ <= var_116_1 + arg_116_0 and not isNil(var_116_0) and arg_113_1.var_.actorSpriteComps10015 == nil then
				arg_113_1.var_.actorSpriteComps10015 = var_116_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_116_2 = 0.034

			if var_116_1 <= arg_113_1.time_ and arg_113_1.time_ < var_116_1 + var_116_2 and not isNil(var_116_0) then
				local var_116_3 = (arg_113_1.time_ - var_116_1) / var_116_2

				if arg_113_1.var_.actorSpriteComps10015 then
					for iter_116_0, iter_116_1 in pairs(arg_113_1.var_.actorSpriteComps10015:ToTable()) do
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

			if arg_113_1.time_ >= var_116_1 + var_116_2 and arg_113_1.time_ < var_116_1 + var_116_2 + arg_116_0 and not isNil(var_116_0) and arg_113_1.var_.actorSpriteComps10015 then
				for iter_116_2, iter_116_3 in pairs(arg_113_1.var_.actorSpriteComps10015:ToTable()) do
					if iter_116_3 then
						if arg_113_1.isInRecall_ then
							iter_116_3.color = arg_113_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_116_3.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_113_1.var_.actorSpriteComps10015 = nil
			end

			local var_116_8 = arg_113_1.actors_["10018"]
			local var_116_9 = 0

			if var_116_9 < arg_113_1.time_ and arg_113_1.time_ <= var_116_9 + arg_116_0 and not isNil(var_116_8) and arg_113_1.var_.actorSpriteComps10018 == nil then
				arg_113_1.var_.actorSpriteComps10018 = var_116_8:GetComponentsInChildren(typeof(Image), true)
			end

			local var_116_10 = 0.034

			if var_116_9 <= arg_113_1.time_ and arg_113_1.time_ < var_116_9 + var_116_10 and not isNil(var_116_8) then
				local var_116_11 = (arg_113_1.time_ - var_116_9) / var_116_10

				if arg_113_1.var_.actorSpriteComps10018 then
					for iter_116_4, iter_116_5 in pairs(arg_113_1.var_.actorSpriteComps10018:ToTable()) do
						if iter_116_5 then
							if arg_113_1.isInRecall_ then
								local var_116_12 = Mathf.Lerp(iter_116_5.color.r, arg_113_1.hightColor2.r, var_116_11)
								local var_116_13 = Mathf.Lerp(iter_116_5.color.g, arg_113_1.hightColor2.g, var_116_11)
								local var_116_14 = Mathf.Lerp(iter_116_5.color.b, arg_113_1.hightColor2.b, var_116_11)

								iter_116_5.color = Color.New(var_116_12, var_116_13, var_116_14)
							else
								local var_116_15 = Mathf.Lerp(iter_116_5.color.r, 0.5, var_116_11)

								iter_116_5.color = Color.New(var_116_15, var_116_15, var_116_15)
							end
						end
					end
				end
			end

			if arg_113_1.time_ >= var_116_9 + var_116_10 and arg_113_1.time_ < var_116_9 + var_116_10 + arg_116_0 and not isNil(var_116_8) and arg_113_1.var_.actorSpriteComps10018 then
				for iter_116_6, iter_116_7 in pairs(arg_113_1.var_.actorSpriteComps10018:ToTable()) do
					if iter_116_7 then
						if arg_113_1.isInRecall_ then
							iter_116_7.color = arg_113_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_116_7.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_113_1.var_.actorSpriteComps10018 = nil
			end

			local var_116_16 = arg_113_1.actors_["10015"].transform
			local var_116_17 = 0

			if var_116_17 < arg_113_1.time_ and arg_113_1.time_ <= var_116_17 + arg_116_0 then
				arg_113_1.var_.moveOldPos10015 = var_116_16.localPosition
				var_116_16.localScale = Vector3.New(1, 1, 1)

				arg_113_1:CheckSpriteTmpPos("10015", 4)

				local var_116_18 = var_116_16.childCount

				for iter_116_8 = 0, var_116_18 - 1 do
					local var_116_19 = var_116_16:GetChild(iter_116_8)

					if var_116_19.name == "split_1" or not string.find(var_116_19.name, "split") then
						var_116_19.gameObject:SetActive(true)
					else
						var_116_19.gameObject:SetActive(false)
					end
				end
			end

			local var_116_20 = 0.001

			if var_116_17 <= arg_113_1.time_ and arg_113_1.time_ < var_116_17 + var_116_20 then
				local var_116_21 = (arg_113_1.time_ - var_116_17) / var_116_20
				local var_116_22 = Vector3.New(390, -350, -180)

				var_116_16.localPosition = Vector3.Lerp(arg_113_1.var_.moveOldPos10015, var_116_22, var_116_21)
			end

			if arg_113_1.time_ >= var_116_17 + var_116_20 and arg_113_1.time_ < var_116_17 + var_116_20 + arg_116_0 then
				var_116_16.localPosition = Vector3.New(390, -350, -180)
			end

			local var_116_23 = 0
			local var_116_24 = 0.675

			if var_116_23 < arg_113_1.time_ and arg_113_1.time_ <= var_116_23 + arg_116_0 then
				arg_113_1.talkMaxDuration = 0
				arg_113_1.dialogCg_.alpha = 1

				arg_113_1.dialog_:SetActive(true)
				SetActive(arg_113_1.leftNameGo_, true)

				local var_116_25 = arg_113_1:FormatText(StoryNameCfg[208].name)

				arg_113_1.leftNameTxt_.text = var_116_25

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_113_1.leftNameTxt_.transform)

				arg_113_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_113_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_113_1:RecordName(arg_113_1.leftNameTxt_.text)
				SetActive(arg_113_1.iconTrs_.gameObject, false)
				arg_113_1.callingController_:SetSelectedState("normal")

				local var_116_26 = arg_113_1:GetWordFromCfg(114241028)
				local var_116_27 = arg_113_1:FormatText(var_116_26.content)

				arg_113_1.text_.text = var_116_27

				LuaForUtil.ClearLinePrefixSymbol(arg_113_1.text_)

				local var_116_28 = 27
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

				if manager.audio:GetVoiceLength("story_v_out_114241", "114241028", "story_v_out_114241.awb") ~= 0 then
					local var_116_31 = manager.audio:GetVoiceLength("story_v_out_114241", "114241028", "story_v_out_114241.awb") / 1000

					if var_116_31 + var_116_23 > arg_113_1.duration_ then
						arg_113_1.duration_ = var_116_31 + var_116_23
					end

					if var_116_26.prefab_name ~= "" and arg_113_1.actors_[var_116_26.prefab_name] ~= nil then
						local var_116_32 = LuaForUtil.PlayVoiceWithCriLipsync(arg_113_1.actors_[var_116_26.prefab_name].transform, "story_v_out_114241", "114241028", "story_v_out_114241.awb")

						arg_113_1:RecordAudio("114241028", var_116_32)
						arg_113_1:RecordAudio("114241028", var_116_32)
					else
						arg_113_1:AudioAction("play", "voice", "story_v_out_114241", "114241028", "story_v_out_114241.awb")
					end

					arg_113_1:RecordHistoryTalkVoice("story_v_out_114241", "114241028", "story_v_out_114241.awb")
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
				actorName = "10015",
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
	Play114241029 = function(arg_117_0, arg_117_1)
		arg_117_1.time_ = 0
		arg_117_1.frameCnt_ = 0
		arg_117_1.state_ = "playing"
		arg_117_1.curTalkId_ = 114241029
		arg_117_1.duration_ = 2.33

		local var_117_0 = {
			ja = 2.333,
			ko = 1.2,
			zh = 2.333,
			en = 1.366
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
				arg_117_0:Play114241030(arg_117_1)
			end
		end

		function arg_117_1.onSingleLineUpdate_(arg_120_0)
			local var_120_0 = arg_117_1.actors_["10015"]
			local var_120_1 = 0

			if var_120_1 < arg_117_1.time_ and arg_117_1.time_ <= var_120_1 + arg_120_0 and not isNil(var_120_0) and arg_117_1.var_.actorSpriteComps10015 == nil then
				arg_117_1.var_.actorSpriteComps10015 = var_120_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_120_2 = 0.034

			if var_120_1 <= arg_117_1.time_ and arg_117_1.time_ < var_120_1 + var_120_2 and not isNil(var_120_0) then
				local var_120_3 = (arg_117_1.time_ - var_120_1) / var_120_2

				if arg_117_1.var_.actorSpriteComps10015 then
					for iter_120_0, iter_120_1 in pairs(arg_117_1.var_.actorSpriteComps10015:ToTable()) do
						if iter_120_1 then
							if arg_117_1.isInRecall_ then
								local var_120_4 = Mathf.Lerp(iter_120_1.color.r, arg_117_1.hightColor2.r, var_120_3)
								local var_120_5 = Mathf.Lerp(iter_120_1.color.g, arg_117_1.hightColor2.g, var_120_3)
								local var_120_6 = Mathf.Lerp(iter_120_1.color.b, arg_117_1.hightColor2.b, var_120_3)

								iter_120_1.color = Color.New(var_120_4, var_120_5, var_120_6)
							else
								local var_120_7 = Mathf.Lerp(iter_120_1.color.r, 0.5, var_120_3)

								iter_120_1.color = Color.New(var_120_7, var_120_7, var_120_7)
							end
						end
					end
				end
			end

			if arg_117_1.time_ >= var_120_1 + var_120_2 and arg_117_1.time_ < var_120_1 + var_120_2 + arg_120_0 and not isNil(var_120_0) and arg_117_1.var_.actorSpriteComps10015 then
				for iter_120_2, iter_120_3 in pairs(arg_117_1.var_.actorSpriteComps10015:ToTable()) do
					if iter_120_3 then
						if arg_117_1.isInRecall_ then
							iter_120_3.color = arg_117_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_120_3.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_117_1.var_.actorSpriteComps10015 = nil
			end

			local var_120_8 = arg_117_1.actors_["10018"]
			local var_120_9 = 0

			if var_120_9 < arg_117_1.time_ and arg_117_1.time_ <= var_120_9 + arg_120_0 and not isNil(var_120_8) and arg_117_1.var_.actorSpriteComps10018 == nil then
				arg_117_1.var_.actorSpriteComps10018 = var_120_8:GetComponentsInChildren(typeof(Image), true)
			end

			local var_120_10 = 0.034

			if var_120_9 <= arg_117_1.time_ and arg_117_1.time_ < var_120_9 + var_120_10 and not isNil(var_120_8) then
				local var_120_11 = (arg_117_1.time_ - var_120_9) / var_120_10

				if arg_117_1.var_.actorSpriteComps10018 then
					for iter_120_4, iter_120_5 in pairs(arg_117_1.var_.actorSpriteComps10018:ToTable()) do
						if iter_120_5 then
							if arg_117_1.isInRecall_ then
								local var_120_12 = Mathf.Lerp(iter_120_5.color.r, arg_117_1.hightColor1.r, var_120_11)
								local var_120_13 = Mathf.Lerp(iter_120_5.color.g, arg_117_1.hightColor1.g, var_120_11)
								local var_120_14 = Mathf.Lerp(iter_120_5.color.b, arg_117_1.hightColor1.b, var_120_11)

								iter_120_5.color = Color.New(var_120_12, var_120_13, var_120_14)
							else
								local var_120_15 = Mathf.Lerp(iter_120_5.color.r, 1, var_120_11)

								iter_120_5.color = Color.New(var_120_15, var_120_15, var_120_15)
							end
						end
					end
				end
			end

			if arg_117_1.time_ >= var_120_9 + var_120_10 and arg_117_1.time_ < var_120_9 + var_120_10 + arg_120_0 and not isNil(var_120_8) and arg_117_1.var_.actorSpriteComps10018 then
				for iter_120_6, iter_120_7 in pairs(arg_117_1.var_.actorSpriteComps10018:ToTable()) do
					if iter_120_7 then
						if arg_117_1.isInRecall_ then
							iter_120_7.color = arg_117_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_120_7.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_117_1.var_.actorSpriteComps10018 = nil
			end

			local var_120_16 = 0
			local var_120_17 = 0.075

			if var_120_16 < arg_117_1.time_ and arg_117_1.time_ <= var_120_16 + arg_120_0 then
				arg_117_1.talkMaxDuration = 0
				arg_117_1.dialogCg_.alpha = 1

				arg_117_1.dialog_:SetActive(true)
				SetActive(arg_117_1.leftNameGo_, true)

				local var_120_18 = arg_117_1:FormatText(StoryNameCfg[257].name)

				arg_117_1.leftNameTxt_.text = var_120_18

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_117_1.leftNameTxt_.transform)

				arg_117_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_117_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_117_1:RecordName(arg_117_1.leftNameTxt_.text)
				SetActive(arg_117_1.iconTrs_.gameObject, false)
				arg_117_1.callingController_:SetSelectedState("normal")

				local var_120_19 = arg_117_1:GetWordFromCfg(114241029)
				local var_120_20 = arg_117_1:FormatText(var_120_19.content)

				arg_117_1.text_.text = var_120_20

				LuaForUtil.ClearLinePrefixSymbol(arg_117_1.text_)

				local var_120_21 = 3
				local var_120_22 = utf8.len(var_120_20)
				local var_120_23 = var_120_21 <= 0 and var_120_17 or var_120_17 * (var_120_22 / var_120_21)

				if var_120_23 > 0 and var_120_17 < var_120_23 then
					arg_117_1.talkMaxDuration = var_120_23

					if var_120_23 + var_120_16 > arg_117_1.duration_ then
						arg_117_1.duration_ = var_120_23 + var_120_16
					end
				end

				arg_117_1.text_.text = var_120_20
				arg_117_1.typewritter.percent = 0

				arg_117_1.typewritter:SetDirty()
				arg_117_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_114241", "114241029", "story_v_out_114241.awb") ~= 0 then
					local var_120_24 = manager.audio:GetVoiceLength("story_v_out_114241", "114241029", "story_v_out_114241.awb") / 1000

					if var_120_24 + var_120_16 > arg_117_1.duration_ then
						arg_117_1.duration_ = var_120_24 + var_120_16
					end

					if var_120_19.prefab_name ~= "" and arg_117_1.actors_[var_120_19.prefab_name] ~= nil then
						local var_120_25 = LuaForUtil.PlayVoiceWithCriLipsync(arg_117_1.actors_[var_120_19.prefab_name].transform, "story_v_out_114241", "114241029", "story_v_out_114241.awb")

						arg_117_1:RecordAudio("114241029", var_120_25)
						arg_117_1:RecordAudio("114241029", var_120_25)
					else
						arg_117_1:AudioAction("play", "voice", "story_v_out_114241", "114241029", "story_v_out_114241.awb")
					end

					arg_117_1:RecordHistoryTalkVoice("story_v_out_114241", "114241029", "story_v_out_114241.awb")
				end

				arg_117_1:RecordContent(arg_117_1.text_.text)
			end

			local var_120_26 = math.max(var_120_17, arg_117_1.talkMaxDuration)

			if var_120_16 <= arg_117_1.time_ and arg_117_1.time_ < var_120_16 + var_120_26 then
				arg_117_1.typewritter.percent = (arg_117_1.time_ - var_120_16) / var_120_26

				arg_117_1.typewritter:SetDirty()
			end

			if arg_117_1.time_ >= var_120_16 + var_120_26 and arg_117_1.time_ < var_120_16 + var_120_26 + arg_120_0 then
				arg_117_1.typewritter.percent = 1

				arg_117_1.typewritter:SetDirty()
				arg_117_1:ShowNextGo(true)
			end
		end

		arg_117_1.nodeConfigList_ = {}

		arg_117_1:InitPlayNodeList()
	end,
	Play114241030 = function(arg_121_0, arg_121_1)
		arg_121_1.time_ = 0
		arg_121_1.frameCnt_ = 0
		arg_121_1.state_ = "playing"
		arg_121_1.curTalkId_ = 114241030
		arg_121_1.duration_ = 10.73

		local var_121_0 = {
			ja = 10.733,
			ko = 9.8,
			zh = 7.9,
			en = 8.466
		}
		local var_121_1 = manager.audio:GetLocalizationFlag()

		if var_121_0[var_121_1] ~= nil then
			arg_121_1.duration_ = var_121_0[var_121_1]
		end

		SetActive(arg_121_1.tipsGo_, false)

		function arg_121_1.onSingleLineFinish_()
			arg_121_1.onSingleLineUpdate_ = nil
			arg_121_1.onSingleLineFinish_ = nil
			arg_121_1.state_ = "waiting"
		end

		function arg_121_1.playNext_(arg_123_0)
			if arg_123_0 == 1 then
				arg_121_0:Play114241031(arg_121_1)
			end
		end

		function arg_121_1.onSingleLineUpdate_(arg_124_0)
			local var_124_0 = arg_121_1.actors_["10015"]
			local var_124_1 = 0

			if var_124_1 < arg_121_1.time_ and arg_121_1.time_ <= var_124_1 + arg_124_0 and not isNil(var_124_0) and arg_121_1.var_.actorSpriteComps10015 == nil then
				arg_121_1.var_.actorSpriteComps10015 = var_124_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_124_2 = 0.034

			if var_124_1 <= arg_121_1.time_ and arg_121_1.time_ < var_124_1 + var_124_2 and not isNil(var_124_0) then
				local var_124_3 = (arg_121_1.time_ - var_124_1) / var_124_2

				if arg_121_1.var_.actorSpriteComps10015 then
					for iter_124_0, iter_124_1 in pairs(arg_121_1.var_.actorSpriteComps10015:ToTable()) do
						if iter_124_1 then
							if arg_121_1.isInRecall_ then
								local var_124_4 = Mathf.Lerp(iter_124_1.color.r, arg_121_1.hightColor1.r, var_124_3)
								local var_124_5 = Mathf.Lerp(iter_124_1.color.g, arg_121_1.hightColor1.g, var_124_3)
								local var_124_6 = Mathf.Lerp(iter_124_1.color.b, arg_121_1.hightColor1.b, var_124_3)

								iter_124_1.color = Color.New(var_124_4, var_124_5, var_124_6)
							else
								local var_124_7 = Mathf.Lerp(iter_124_1.color.r, 1, var_124_3)

								iter_124_1.color = Color.New(var_124_7, var_124_7, var_124_7)
							end
						end
					end
				end
			end

			if arg_121_1.time_ >= var_124_1 + var_124_2 and arg_121_1.time_ < var_124_1 + var_124_2 + arg_124_0 and not isNil(var_124_0) and arg_121_1.var_.actorSpriteComps10015 then
				for iter_124_2, iter_124_3 in pairs(arg_121_1.var_.actorSpriteComps10015:ToTable()) do
					if iter_124_3 then
						if arg_121_1.isInRecall_ then
							iter_124_3.color = arg_121_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_124_3.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_121_1.var_.actorSpriteComps10015 = nil
			end

			local var_124_8 = arg_121_1.actors_["10018"]
			local var_124_9 = 0

			if var_124_9 < arg_121_1.time_ and arg_121_1.time_ <= var_124_9 + arg_124_0 and not isNil(var_124_8) and arg_121_1.var_.actorSpriteComps10018 == nil then
				arg_121_1.var_.actorSpriteComps10018 = var_124_8:GetComponentsInChildren(typeof(Image), true)
			end

			local var_124_10 = 0.034

			if var_124_9 <= arg_121_1.time_ and arg_121_1.time_ < var_124_9 + var_124_10 and not isNil(var_124_8) then
				local var_124_11 = (arg_121_1.time_ - var_124_9) / var_124_10

				if arg_121_1.var_.actorSpriteComps10018 then
					for iter_124_4, iter_124_5 in pairs(arg_121_1.var_.actorSpriteComps10018:ToTable()) do
						if iter_124_5 then
							if arg_121_1.isInRecall_ then
								local var_124_12 = Mathf.Lerp(iter_124_5.color.r, arg_121_1.hightColor2.r, var_124_11)
								local var_124_13 = Mathf.Lerp(iter_124_5.color.g, arg_121_1.hightColor2.g, var_124_11)
								local var_124_14 = Mathf.Lerp(iter_124_5.color.b, arg_121_1.hightColor2.b, var_124_11)

								iter_124_5.color = Color.New(var_124_12, var_124_13, var_124_14)
							else
								local var_124_15 = Mathf.Lerp(iter_124_5.color.r, 0.5, var_124_11)

								iter_124_5.color = Color.New(var_124_15, var_124_15, var_124_15)
							end
						end
					end
				end
			end

			if arg_121_1.time_ >= var_124_9 + var_124_10 and arg_121_1.time_ < var_124_9 + var_124_10 + arg_124_0 and not isNil(var_124_8) and arg_121_1.var_.actorSpriteComps10018 then
				for iter_124_6, iter_124_7 in pairs(arg_121_1.var_.actorSpriteComps10018:ToTable()) do
					if iter_124_7 then
						if arg_121_1.isInRecall_ then
							iter_124_7.color = arg_121_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_124_7.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_121_1.var_.actorSpriteComps10018 = nil
			end

			local var_124_16 = 0
			local var_124_17 = 0.975

			if var_124_16 < arg_121_1.time_ and arg_121_1.time_ <= var_124_16 + arg_124_0 then
				arg_121_1.talkMaxDuration = 0
				arg_121_1.dialogCg_.alpha = 1

				arg_121_1.dialog_:SetActive(true)
				SetActive(arg_121_1.leftNameGo_, true)

				local var_124_18 = arg_121_1:FormatText(StoryNameCfg[208].name)

				arg_121_1.leftNameTxt_.text = var_124_18

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_121_1.leftNameTxt_.transform)

				arg_121_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_121_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_121_1:RecordName(arg_121_1.leftNameTxt_.text)
				SetActive(arg_121_1.iconTrs_.gameObject, false)
				arg_121_1.callingController_:SetSelectedState("normal")

				local var_124_19 = arg_121_1:GetWordFromCfg(114241030)
				local var_124_20 = arg_121_1:FormatText(var_124_19.content)

				arg_121_1.text_.text = var_124_20

				LuaForUtil.ClearLinePrefixSymbol(arg_121_1.text_)

				local var_124_21 = 39
				local var_124_22 = utf8.len(var_124_20)
				local var_124_23 = var_124_21 <= 0 and var_124_17 or var_124_17 * (var_124_22 / var_124_21)

				if var_124_23 > 0 and var_124_17 < var_124_23 then
					arg_121_1.talkMaxDuration = var_124_23

					if var_124_23 + var_124_16 > arg_121_1.duration_ then
						arg_121_1.duration_ = var_124_23 + var_124_16
					end
				end

				arg_121_1.text_.text = var_124_20
				arg_121_1.typewritter.percent = 0

				arg_121_1.typewritter:SetDirty()
				arg_121_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_114241", "114241030", "story_v_out_114241.awb") ~= 0 then
					local var_124_24 = manager.audio:GetVoiceLength("story_v_out_114241", "114241030", "story_v_out_114241.awb") / 1000

					if var_124_24 + var_124_16 > arg_121_1.duration_ then
						arg_121_1.duration_ = var_124_24 + var_124_16
					end

					if var_124_19.prefab_name ~= "" and arg_121_1.actors_[var_124_19.prefab_name] ~= nil then
						local var_124_25 = LuaForUtil.PlayVoiceWithCriLipsync(arg_121_1.actors_[var_124_19.prefab_name].transform, "story_v_out_114241", "114241030", "story_v_out_114241.awb")

						arg_121_1:RecordAudio("114241030", var_124_25)
						arg_121_1:RecordAudio("114241030", var_124_25)
					else
						arg_121_1:AudioAction("play", "voice", "story_v_out_114241", "114241030", "story_v_out_114241.awb")
					end

					arg_121_1:RecordHistoryTalkVoice("story_v_out_114241", "114241030", "story_v_out_114241.awb")
				end

				arg_121_1:RecordContent(arg_121_1.text_.text)
			end

			local var_124_26 = math.max(var_124_17, arg_121_1.talkMaxDuration)

			if var_124_16 <= arg_121_1.time_ and arg_121_1.time_ < var_124_16 + var_124_26 then
				arg_121_1.typewritter.percent = (arg_121_1.time_ - var_124_16) / var_124_26

				arg_121_1.typewritter:SetDirty()
			end

			if arg_121_1.time_ >= var_124_16 + var_124_26 and arg_121_1.time_ < var_124_16 + var_124_26 + arg_124_0 then
				arg_121_1.typewritter.percent = 1

				arg_121_1.typewritter:SetDirty()
				arg_121_1:ShowNextGo(true)
			end
		end

		arg_121_1.nodeConfigList_ = {}

		arg_121_1:InitPlayNodeList()
	end,
	Play114241031 = function(arg_125_0, arg_125_1)
		arg_125_1.time_ = 0
		arg_125_1.frameCnt_ = 0
		arg_125_1.state_ = "playing"
		arg_125_1.curTalkId_ = 114241031
		arg_125_1.duration_ = 5

		SetActive(arg_125_1.tipsGo_, false)

		function arg_125_1.onSingleLineFinish_()
			arg_125_1.onSingleLineUpdate_ = nil
			arg_125_1.onSingleLineFinish_ = nil
			arg_125_1.state_ = "waiting"
		end

		function arg_125_1.playNext_(arg_127_0)
			if arg_127_0 == 1 then
				arg_125_0:Play114241032(arg_125_1)
			end
		end

		function arg_125_1.onSingleLineUpdate_(arg_128_0)
			local var_128_0 = arg_125_1.actors_["10015"]
			local var_128_1 = 0

			if var_128_1 < arg_125_1.time_ and arg_125_1.time_ <= var_128_1 + arg_128_0 then
				local var_128_2 = var_128_0:GetComponentInChildren(typeof(CanvasGroup))

				if var_128_2 then
					arg_125_1.var_.alphaOldValue10015 = var_128_2.alpha
					arg_125_1.var_.characterEffect10015 = var_128_2
				end

				arg_125_1.var_.alphaOldValue10015 = 1
			end

			local var_128_3 = 0.5

			if var_128_1 <= arg_125_1.time_ and arg_125_1.time_ < var_128_1 + var_128_3 then
				local var_128_4 = (arg_125_1.time_ - var_128_1) / var_128_3
				local var_128_5 = Mathf.Lerp(arg_125_1.var_.alphaOldValue10015, 0, var_128_4)

				if arg_125_1.var_.characterEffect10015 then
					arg_125_1.var_.characterEffect10015.alpha = var_128_5
				end
			end

			if arg_125_1.time_ >= var_128_1 + var_128_3 and arg_125_1.time_ < var_128_1 + var_128_3 + arg_128_0 and arg_125_1.var_.characterEffect10015 then
				arg_125_1.var_.characterEffect10015.alpha = 0
			end

			local var_128_6 = arg_125_1.actors_["10018"]
			local var_128_7 = 0

			if var_128_7 < arg_125_1.time_ and arg_125_1.time_ <= var_128_7 + arg_128_0 then
				local var_128_8 = var_128_6:GetComponentInChildren(typeof(CanvasGroup))

				if var_128_8 then
					arg_125_1.var_.alphaOldValue10018 = var_128_8.alpha
					arg_125_1.var_.characterEffect10018 = var_128_8
				end

				arg_125_1.var_.alphaOldValue10018 = 1
			end

			local var_128_9 = 0.5

			if var_128_7 <= arg_125_1.time_ and arg_125_1.time_ < var_128_7 + var_128_9 then
				local var_128_10 = (arg_125_1.time_ - var_128_7) / var_128_9
				local var_128_11 = Mathf.Lerp(arg_125_1.var_.alphaOldValue10018, 0, var_128_10)

				if arg_125_1.var_.characterEffect10018 then
					arg_125_1.var_.characterEffect10018.alpha = var_128_11
				end
			end

			if arg_125_1.time_ >= var_128_7 + var_128_9 and arg_125_1.time_ < var_128_7 + var_128_9 + arg_128_0 and arg_125_1.var_.characterEffect10018 then
				arg_125_1.var_.characterEffect10018.alpha = 0
			end

			local var_128_12 = 0
			local var_128_13 = 1.275

			if var_128_12 < arg_125_1.time_ and arg_125_1.time_ <= var_128_12 + arg_128_0 then
				arg_125_1.talkMaxDuration = 0
				arg_125_1.dialogCg_.alpha = 1

				arg_125_1.dialog_:SetActive(true)
				SetActive(arg_125_1.leftNameGo_, false)

				arg_125_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_125_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_125_1:RecordName(arg_125_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_125_1.iconTrs_.gameObject, false)
				arg_125_1.callingController_:SetSelectedState("normal")

				local var_128_14 = arg_125_1:GetWordFromCfg(114241031)
				local var_128_15 = arg_125_1:FormatText(var_128_14.content)

				arg_125_1.text_.text = var_128_15

				LuaForUtil.ClearLinePrefixSymbol(arg_125_1.text_)

				local var_128_16 = 51
				local var_128_17 = utf8.len(var_128_15)
				local var_128_18 = var_128_16 <= 0 and var_128_13 or var_128_13 * (var_128_17 / var_128_16)

				if var_128_18 > 0 and var_128_13 < var_128_18 then
					arg_125_1.talkMaxDuration = var_128_18

					if var_128_18 + var_128_12 > arg_125_1.duration_ then
						arg_125_1.duration_ = var_128_18 + var_128_12
					end
				end

				arg_125_1.text_.text = var_128_15
				arg_125_1.typewritter.percent = 0

				arg_125_1.typewritter:SetDirty()
				arg_125_1:ShowNextGo(false)
				arg_125_1:RecordContent(arg_125_1.text_.text)
			end

			local var_128_19 = math.max(var_128_13, arg_125_1.talkMaxDuration)

			if var_128_12 <= arg_125_1.time_ and arg_125_1.time_ < var_128_12 + var_128_19 then
				arg_125_1.typewritter.percent = (arg_125_1.time_ - var_128_12) / var_128_19

				arg_125_1.typewritter:SetDirty()
			end

			if arg_125_1.time_ >= var_128_12 + var_128_19 and arg_125_1.time_ < var_128_12 + var_128_19 + arg_128_0 then
				arg_125_1.typewritter.percent = 1

				arg_125_1.typewritter:SetDirty()
				arg_125_1:ShowNextGo(true)
			end
		end

		arg_125_1.nodeConfigList_ = {}

		arg_125_1:InitPlayNodeList()
	end,
	Play114241032 = function(arg_129_0, arg_129_1)
		arg_129_1.time_ = 0
		arg_129_1.frameCnt_ = 0
		arg_129_1.state_ = "playing"
		arg_129_1.curTalkId_ = 114241032
		arg_129_1.duration_ = 1.83

		local var_129_0 = {
			ja = 1.5,
			ko = 1.833,
			zh = 1.666,
			en = 1.833
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
				arg_129_0:Play114241033(arg_129_1)
			end
		end

		function arg_129_1.onSingleLineUpdate_(arg_132_0)
			local var_132_0 = arg_129_1.actors_["10018"].transform
			local var_132_1 = 0

			if var_132_1 < arg_129_1.time_ and arg_129_1.time_ <= var_132_1 + arg_132_0 then
				arg_129_1.var_.moveOldPos10018 = var_132_0.localPosition
				var_132_0.localScale = Vector3.New(1, 1, 1)

				arg_129_1:CheckSpriteTmpPos("10018", 2)

				local var_132_2 = var_132_0.childCount

				for iter_132_0 = 0, var_132_2 - 1 do
					local var_132_3 = var_132_0:GetChild(iter_132_0)

					if var_132_3.name == "split_2" or not string.find(var_132_3.name, "split") then
						var_132_3.gameObject:SetActive(true)
					else
						var_132_3.gameObject:SetActive(false)
					end
				end
			end

			local var_132_4 = 0.001

			if var_132_1 <= arg_129_1.time_ and arg_129_1.time_ < var_132_1 + var_132_4 then
				local var_132_5 = (arg_129_1.time_ - var_132_1) / var_132_4
				local var_132_6 = Vector3.New(-390, -350, -180)

				var_132_0.localPosition = Vector3.Lerp(arg_129_1.var_.moveOldPos10018, var_132_6, var_132_5)
			end

			if arg_129_1.time_ >= var_132_1 + var_132_4 and arg_129_1.time_ < var_132_1 + var_132_4 + arg_132_0 then
				var_132_0.localPosition = Vector3.New(-390, -350, -180)
			end

			local var_132_7 = arg_129_1.actors_["10015"].transform
			local var_132_8 = 0

			if var_132_8 < arg_129_1.time_ and arg_129_1.time_ <= var_132_8 + arg_132_0 then
				arg_129_1.var_.moveOldPos10015 = var_132_7.localPosition
				var_132_7.localScale = Vector3.New(1, 1, 1)

				arg_129_1:CheckSpriteTmpPos("10015", 4)

				local var_132_9 = var_132_7.childCount

				for iter_132_1 = 0, var_132_9 - 1 do
					local var_132_10 = var_132_7:GetChild(iter_132_1)

					if var_132_10.name == "split_1" or not string.find(var_132_10.name, "split") then
						var_132_10.gameObject:SetActive(true)
					else
						var_132_10.gameObject:SetActive(false)
					end
				end
			end

			local var_132_11 = 0.001

			if var_132_8 <= arg_129_1.time_ and arg_129_1.time_ < var_132_8 + var_132_11 then
				local var_132_12 = (arg_129_1.time_ - var_132_8) / var_132_11
				local var_132_13 = Vector3.New(390, -350, -180)

				var_132_7.localPosition = Vector3.Lerp(arg_129_1.var_.moveOldPos10015, var_132_13, var_132_12)
			end

			if arg_129_1.time_ >= var_132_8 + var_132_11 and arg_129_1.time_ < var_132_8 + var_132_11 + arg_132_0 then
				var_132_7.localPosition = Vector3.New(390, -350, -180)
			end

			local var_132_14 = arg_129_1.actors_["10018"]
			local var_132_15 = 0

			if var_132_15 < arg_129_1.time_ and arg_129_1.time_ <= var_132_15 + arg_132_0 and not isNil(var_132_14) then
				local var_132_16 = var_132_14:GetComponent("Image")

				if var_132_16 then
					arg_129_1.var_.highlightMatValue10018 = var_132_16
				end
			end

			local var_132_17 = 0.034

			if var_132_15 <= arg_129_1.time_ and arg_129_1.time_ < var_132_15 + var_132_17 and not isNil(var_132_14) then
				local var_132_18 = (arg_129_1.time_ - var_132_15) / var_132_17

				if arg_129_1.var_.highlightMatValue10018 then
					local var_132_19 = Mathf.Lerp(0.5, 1, var_132_18)
					local var_132_20 = arg_129_1.var_.highlightMatValue10018
					local var_132_21 = var_132_20.color

					var_132_21.r = var_132_19
					var_132_21.g = var_132_19
					var_132_21.b = var_132_19
					var_132_20.color = var_132_21
				end
			end

			if arg_129_1.time_ >= var_132_15 + var_132_17 and arg_129_1.time_ < var_132_15 + var_132_17 + arg_132_0 and not isNil(var_132_14) and arg_129_1.var_.highlightMatValue10018 then
				local var_132_22 = 1

				var_132_14.transform:SetSiblingIndex(1)

				local var_132_23 = arg_129_1.var_.highlightMatValue10018
				local var_132_24 = var_132_23.color

				var_132_24.r = var_132_22
				var_132_24.g = var_132_22
				var_132_24.b = var_132_22
				var_132_23.color = var_132_24
			end

			local var_132_25 = arg_129_1.actors_["10015"]
			local var_132_26 = 0

			if var_132_26 < arg_129_1.time_ and arg_129_1.time_ <= var_132_26 + arg_132_0 and not isNil(var_132_25) and arg_129_1.var_.actorSpriteComps10015 == nil then
				arg_129_1.var_.actorSpriteComps10015 = var_132_25:GetComponentsInChildren(typeof(Image), true)
			end

			local var_132_27 = 0.034

			if var_132_26 <= arg_129_1.time_ and arg_129_1.time_ < var_132_26 + var_132_27 and not isNil(var_132_25) then
				local var_132_28 = (arg_129_1.time_ - var_132_26) / var_132_27

				if arg_129_1.var_.actorSpriteComps10015 then
					for iter_132_2, iter_132_3 in pairs(arg_129_1.var_.actorSpriteComps10015:ToTable()) do
						if iter_132_3 then
							if arg_129_1.isInRecall_ then
								local var_132_29 = Mathf.Lerp(iter_132_3.color.r, arg_129_1.hightColor2.r, var_132_28)
								local var_132_30 = Mathf.Lerp(iter_132_3.color.g, arg_129_1.hightColor2.g, var_132_28)
								local var_132_31 = Mathf.Lerp(iter_132_3.color.b, arg_129_1.hightColor2.b, var_132_28)

								iter_132_3.color = Color.New(var_132_29, var_132_30, var_132_31)
							else
								local var_132_32 = Mathf.Lerp(iter_132_3.color.r, 0.5, var_132_28)

								iter_132_3.color = Color.New(var_132_32, var_132_32, var_132_32)
							end
						end
					end
				end
			end

			if arg_129_1.time_ >= var_132_26 + var_132_27 and arg_129_1.time_ < var_132_26 + var_132_27 + arg_132_0 and not isNil(var_132_25) and arg_129_1.var_.actorSpriteComps10015 then
				for iter_132_4, iter_132_5 in pairs(arg_129_1.var_.actorSpriteComps10015:ToTable()) do
					if iter_132_5 then
						if arg_129_1.isInRecall_ then
							iter_132_5.color = arg_129_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_132_5.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_129_1.var_.actorSpriteComps10015 = nil
			end

			local var_132_33 = arg_129_1.actors_["10018"]
			local var_132_34 = 0

			if var_132_34 < arg_129_1.time_ and arg_129_1.time_ <= var_132_34 + arg_132_0 then
				local var_132_35 = var_132_33:GetComponentInChildren(typeof(CanvasGroup))

				if var_132_35 then
					arg_129_1.var_.alphaOldValue10018 = var_132_35.alpha
					arg_129_1.var_.characterEffect10018 = var_132_35
				end

				arg_129_1.var_.alphaOldValue10018 = 0
			end

			local var_132_36 = 0.5

			if var_132_34 <= arg_129_1.time_ and arg_129_1.time_ < var_132_34 + var_132_36 then
				local var_132_37 = (arg_129_1.time_ - var_132_34) / var_132_36
				local var_132_38 = Mathf.Lerp(arg_129_1.var_.alphaOldValue10018, 1, var_132_37)

				if arg_129_1.var_.characterEffect10018 then
					arg_129_1.var_.characterEffect10018.alpha = var_132_38
				end
			end

			if arg_129_1.time_ >= var_132_34 + var_132_36 and arg_129_1.time_ < var_132_34 + var_132_36 + arg_132_0 and arg_129_1.var_.characterEffect10018 then
				arg_129_1.var_.characterEffect10018.alpha = 1
			end

			local var_132_39 = arg_129_1.actors_["10015"]
			local var_132_40 = 0

			if var_132_40 < arg_129_1.time_ and arg_129_1.time_ <= var_132_40 + arg_132_0 then
				local var_132_41 = var_132_39:GetComponentInChildren(typeof(CanvasGroup))

				if var_132_41 then
					arg_129_1.var_.alphaOldValue10015 = var_132_41.alpha
					arg_129_1.var_.characterEffect10015 = var_132_41
				end

				arg_129_1.var_.alphaOldValue10015 = 0
			end

			local var_132_42 = 0.5

			if var_132_40 <= arg_129_1.time_ and arg_129_1.time_ < var_132_40 + var_132_42 then
				local var_132_43 = (arg_129_1.time_ - var_132_40) / var_132_42
				local var_132_44 = Mathf.Lerp(arg_129_1.var_.alphaOldValue10015, 1, var_132_43)

				if arg_129_1.var_.characterEffect10015 then
					arg_129_1.var_.characterEffect10015.alpha = var_132_44
				end
			end

			if arg_129_1.time_ >= var_132_40 + var_132_42 and arg_129_1.time_ < var_132_40 + var_132_42 + arg_132_0 and arg_129_1.var_.characterEffect10015 then
				arg_129_1.var_.characterEffect10015.alpha = 1
			end

			local var_132_45 = 0
			local var_132_46 = 0.2

			if var_132_45 < arg_129_1.time_ and arg_129_1.time_ <= var_132_45 + arg_132_0 then
				arg_129_1.talkMaxDuration = 0
				arg_129_1.dialogCg_.alpha = 1

				arg_129_1.dialog_:SetActive(true)
				SetActive(arg_129_1.leftNameGo_, true)

				local var_132_47 = arg_129_1:FormatText(StoryNameCfg[257].name)

				arg_129_1.leftNameTxt_.text = var_132_47

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_129_1.leftNameTxt_.transform)

				arg_129_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_129_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_129_1:RecordName(arg_129_1.leftNameTxt_.text)
				SetActive(arg_129_1.iconTrs_.gameObject, false)
				arg_129_1.callingController_:SetSelectedState("normal")

				local var_132_48 = arg_129_1:GetWordFromCfg(114241032)
				local var_132_49 = arg_129_1:FormatText(var_132_48.content)

				arg_129_1.text_.text = var_132_49

				LuaForUtil.ClearLinePrefixSymbol(arg_129_1.text_)

				local var_132_50 = 8
				local var_132_51 = utf8.len(var_132_49)
				local var_132_52 = var_132_50 <= 0 and var_132_46 or var_132_46 * (var_132_51 / var_132_50)

				if var_132_52 > 0 and var_132_46 < var_132_52 then
					arg_129_1.talkMaxDuration = var_132_52

					if var_132_52 + var_132_45 > arg_129_1.duration_ then
						arg_129_1.duration_ = var_132_52 + var_132_45
					end
				end

				arg_129_1.text_.text = var_132_49
				arg_129_1.typewritter.percent = 0

				arg_129_1.typewritter:SetDirty()
				arg_129_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_114241", "114241032", "story_v_out_114241.awb") ~= 0 then
					local var_132_53 = manager.audio:GetVoiceLength("story_v_out_114241", "114241032", "story_v_out_114241.awb") / 1000

					if var_132_53 + var_132_45 > arg_129_1.duration_ then
						arg_129_1.duration_ = var_132_53 + var_132_45
					end

					if var_132_48.prefab_name ~= "" and arg_129_1.actors_[var_132_48.prefab_name] ~= nil then
						local var_132_54 = LuaForUtil.PlayVoiceWithCriLipsync(arg_129_1.actors_[var_132_48.prefab_name].transform, "story_v_out_114241", "114241032", "story_v_out_114241.awb")

						arg_129_1:RecordAudio("114241032", var_132_54)
						arg_129_1:RecordAudio("114241032", var_132_54)
					else
						arg_129_1:AudioAction("play", "voice", "story_v_out_114241", "114241032", "story_v_out_114241.awb")
					end

					arg_129_1:RecordHistoryTalkVoice("story_v_out_114241", "114241032", "story_v_out_114241.awb")
				end

				arg_129_1:RecordContent(arg_129_1.text_.text)
			end

			local var_132_55 = math.max(var_132_46, arg_129_1.talkMaxDuration)

			if var_132_45 <= arg_129_1.time_ and arg_129_1.time_ < var_132_45 + var_132_55 then
				arg_129_1.typewritter.percent = (arg_129_1.time_ - var_132_45) / var_132_55

				arg_129_1.typewritter:SetDirty()
			end

			if arg_129_1.time_ >= var_132_45 + var_132_55 and arg_129_1.time_ < var_132_45 + var_132_55 + arg_132_0 then
				arg_129_1.typewritter.percent = 1

				arg_129_1.typewritter:SetDirty()
				arg_129_1:ShowNextGo(true)
			end
		end

		arg_129_1.nodeConfigList_ = {
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

		arg_129_1:InitPlayNodeList()
	end,
	Play114241033 = function(arg_133_0, arg_133_1)
		arg_133_1.time_ = 0
		arg_133_1.frameCnt_ = 0
		arg_133_1.state_ = "playing"
		arg_133_1.curTalkId_ = 114241033
		arg_133_1.duration_ = 2.3

		local var_133_0 = {
			ja = 1.8,
			ko = 1.966,
			zh = 2.3,
			en = 1.7
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
				arg_133_0:Play114241034(arg_133_1)
			end
		end

		function arg_133_1.onSingleLineUpdate_(arg_136_0)
			local var_136_0 = arg_133_1.actors_["10018"]
			local var_136_1 = 0

			if var_136_1 < arg_133_1.time_ and arg_133_1.time_ <= var_136_1 + arg_136_0 and not isNil(var_136_0) and arg_133_1.var_.actorSpriteComps10018 == nil then
				arg_133_1.var_.actorSpriteComps10018 = var_136_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_136_2 = 0.034

			if var_136_1 <= arg_133_1.time_ and arg_133_1.time_ < var_136_1 + var_136_2 and not isNil(var_136_0) then
				local var_136_3 = (arg_133_1.time_ - var_136_1) / var_136_2

				if arg_133_1.var_.actorSpriteComps10018 then
					for iter_136_0, iter_136_1 in pairs(arg_133_1.var_.actorSpriteComps10018:ToTable()) do
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

			if arg_133_1.time_ >= var_136_1 + var_136_2 and arg_133_1.time_ < var_136_1 + var_136_2 + arg_136_0 and not isNil(var_136_0) and arg_133_1.var_.actorSpriteComps10018 then
				for iter_136_2, iter_136_3 in pairs(arg_133_1.var_.actorSpriteComps10018:ToTable()) do
					if iter_136_3 then
						if arg_133_1.isInRecall_ then
							iter_136_3.color = arg_133_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_136_3.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_133_1.var_.actorSpriteComps10018 = nil
			end

			local var_136_8 = arg_133_1.actors_["10015"]
			local var_136_9 = 0

			if var_136_9 < arg_133_1.time_ and arg_133_1.time_ <= var_136_9 + arg_136_0 and not isNil(var_136_8) and arg_133_1.var_.actorSpriteComps10015 == nil then
				arg_133_1.var_.actorSpriteComps10015 = var_136_8:GetComponentsInChildren(typeof(Image), true)
			end

			local var_136_10 = 0.034

			if var_136_9 <= arg_133_1.time_ and arg_133_1.time_ < var_136_9 + var_136_10 and not isNil(var_136_8) then
				local var_136_11 = (arg_133_1.time_ - var_136_9) / var_136_10

				if arg_133_1.var_.actorSpriteComps10015 then
					for iter_136_4, iter_136_5 in pairs(arg_133_1.var_.actorSpriteComps10015:ToTable()) do
						if iter_136_5 then
							if arg_133_1.isInRecall_ then
								local var_136_12 = Mathf.Lerp(iter_136_5.color.r, arg_133_1.hightColor1.r, var_136_11)
								local var_136_13 = Mathf.Lerp(iter_136_5.color.g, arg_133_1.hightColor1.g, var_136_11)
								local var_136_14 = Mathf.Lerp(iter_136_5.color.b, arg_133_1.hightColor1.b, var_136_11)

								iter_136_5.color = Color.New(var_136_12, var_136_13, var_136_14)
							else
								local var_136_15 = Mathf.Lerp(iter_136_5.color.r, 1, var_136_11)

								iter_136_5.color = Color.New(var_136_15, var_136_15, var_136_15)
							end
						end
					end
				end
			end

			if arg_133_1.time_ >= var_136_9 + var_136_10 and arg_133_1.time_ < var_136_9 + var_136_10 + arg_136_0 and not isNil(var_136_8) and arg_133_1.var_.actorSpriteComps10015 then
				for iter_136_6, iter_136_7 in pairs(arg_133_1.var_.actorSpriteComps10015:ToTable()) do
					if iter_136_7 then
						if arg_133_1.isInRecall_ then
							iter_136_7.color = arg_133_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_136_7.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_133_1.var_.actorSpriteComps10015 = nil
			end

			local var_136_16 = 0
			local var_136_17 = 0.15

			if var_136_16 < arg_133_1.time_ and arg_133_1.time_ <= var_136_16 + arg_136_0 then
				arg_133_1.talkMaxDuration = 0
				arg_133_1.dialogCg_.alpha = 1

				arg_133_1.dialog_:SetActive(true)
				SetActive(arg_133_1.leftNameGo_, true)

				local var_136_18 = arg_133_1:FormatText(StoryNameCfg[208].name)

				arg_133_1.leftNameTxt_.text = var_136_18

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_133_1.leftNameTxt_.transform)

				arg_133_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_133_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_133_1:RecordName(arg_133_1.leftNameTxt_.text)
				SetActive(arg_133_1.iconTrs_.gameObject, false)
				arg_133_1.callingController_:SetSelectedState("normal")

				local var_136_19 = arg_133_1:GetWordFromCfg(114241033)
				local var_136_20 = arg_133_1:FormatText(var_136_19.content)

				arg_133_1.text_.text = var_136_20

				LuaForUtil.ClearLinePrefixSymbol(arg_133_1.text_)

				local var_136_21 = 6
				local var_136_22 = utf8.len(var_136_20)
				local var_136_23 = var_136_21 <= 0 and var_136_17 or var_136_17 * (var_136_22 / var_136_21)

				if var_136_23 > 0 and var_136_17 < var_136_23 then
					arg_133_1.talkMaxDuration = var_136_23

					if var_136_23 + var_136_16 > arg_133_1.duration_ then
						arg_133_1.duration_ = var_136_23 + var_136_16
					end
				end

				arg_133_1.text_.text = var_136_20
				arg_133_1.typewritter.percent = 0

				arg_133_1.typewritter:SetDirty()
				arg_133_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_114241", "114241033", "story_v_out_114241.awb") ~= 0 then
					local var_136_24 = manager.audio:GetVoiceLength("story_v_out_114241", "114241033", "story_v_out_114241.awb") / 1000

					if var_136_24 + var_136_16 > arg_133_1.duration_ then
						arg_133_1.duration_ = var_136_24 + var_136_16
					end

					if var_136_19.prefab_name ~= "" and arg_133_1.actors_[var_136_19.prefab_name] ~= nil then
						local var_136_25 = LuaForUtil.PlayVoiceWithCriLipsync(arg_133_1.actors_[var_136_19.prefab_name].transform, "story_v_out_114241", "114241033", "story_v_out_114241.awb")

						arg_133_1:RecordAudio("114241033", var_136_25)
						arg_133_1:RecordAudio("114241033", var_136_25)
					else
						arg_133_1:AudioAction("play", "voice", "story_v_out_114241", "114241033", "story_v_out_114241.awb")
					end

					arg_133_1:RecordHistoryTalkVoice("story_v_out_114241", "114241033", "story_v_out_114241.awb")
				end

				arg_133_1:RecordContent(arg_133_1.text_.text)
			end

			local var_136_26 = math.max(var_136_17, arg_133_1.talkMaxDuration)

			if var_136_16 <= arg_133_1.time_ and arg_133_1.time_ < var_136_16 + var_136_26 then
				arg_133_1.typewritter.percent = (arg_133_1.time_ - var_136_16) / var_136_26

				arg_133_1.typewritter:SetDirty()
			end

			if arg_133_1.time_ >= var_136_16 + var_136_26 and arg_133_1.time_ < var_136_16 + var_136_26 + arg_136_0 then
				arg_133_1.typewritter.percent = 1

				arg_133_1.typewritter:SetDirty()
				arg_133_1:ShowNextGo(true)
			end
		end

		arg_133_1.nodeConfigList_ = {}

		arg_133_1:InitPlayNodeList()
	end,
	Play114241034 = function(arg_137_0, arg_137_1)
		arg_137_1.time_ = 0
		arg_137_1.frameCnt_ = 0
		arg_137_1.state_ = "playing"
		arg_137_1.curTalkId_ = 114241034
		arg_137_1.duration_ = 8.47

		local var_137_0 = {
			ja = 8.466,
			ko = 5.6,
			zh = 4.9,
			en = 7.433
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
				arg_137_0:Play114241035(arg_137_1)
			end
		end

		function arg_137_1.onSingleLineUpdate_(arg_140_0)
			local var_140_0 = arg_137_1.actors_["10018"]
			local var_140_1 = 0

			if var_140_1 < arg_137_1.time_ and arg_137_1.time_ <= var_140_1 + arg_140_0 and not isNil(var_140_0) and arg_137_1.var_.actorSpriteComps10018 == nil then
				arg_137_1.var_.actorSpriteComps10018 = var_140_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_140_2 = 0.034

			if var_140_1 <= arg_137_1.time_ and arg_137_1.time_ < var_140_1 + var_140_2 and not isNil(var_140_0) then
				local var_140_3 = (arg_137_1.time_ - var_140_1) / var_140_2

				if arg_137_1.var_.actorSpriteComps10018 then
					for iter_140_0, iter_140_1 in pairs(arg_137_1.var_.actorSpriteComps10018:ToTable()) do
						if iter_140_1 then
							if arg_137_1.isInRecall_ then
								local var_140_4 = Mathf.Lerp(iter_140_1.color.r, arg_137_1.hightColor1.r, var_140_3)
								local var_140_5 = Mathf.Lerp(iter_140_1.color.g, arg_137_1.hightColor1.g, var_140_3)
								local var_140_6 = Mathf.Lerp(iter_140_1.color.b, arg_137_1.hightColor1.b, var_140_3)

								iter_140_1.color = Color.New(var_140_4, var_140_5, var_140_6)
							else
								local var_140_7 = Mathf.Lerp(iter_140_1.color.r, 1, var_140_3)

								iter_140_1.color = Color.New(var_140_7, var_140_7, var_140_7)
							end
						end
					end
				end
			end

			if arg_137_1.time_ >= var_140_1 + var_140_2 and arg_137_1.time_ < var_140_1 + var_140_2 + arg_140_0 and not isNil(var_140_0) and arg_137_1.var_.actorSpriteComps10018 then
				for iter_140_2, iter_140_3 in pairs(arg_137_1.var_.actorSpriteComps10018:ToTable()) do
					if iter_140_3 then
						if arg_137_1.isInRecall_ then
							iter_140_3.color = arg_137_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_140_3.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_137_1.var_.actorSpriteComps10018 = nil
			end

			local var_140_8 = arg_137_1.actors_["10015"]
			local var_140_9 = 0

			if var_140_9 < arg_137_1.time_ and arg_137_1.time_ <= var_140_9 + arg_140_0 and not isNil(var_140_8) and arg_137_1.var_.actorSpriteComps10015 == nil then
				arg_137_1.var_.actorSpriteComps10015 = var_140_8:GetComponentsInChildren(typeof(Image), true)
			end

			local var_140_10 = 0.034

			if var_140_9 <= arg_137_1.time_ and arg_137_1.time_ < var_140_9 + var_140_10 and not isNil(var_140_8) then
				local var_140_11 = (arg_137_1.time_ - var_140_9) / var_140_10

				if arg_137_1.var_.actorSpriteComps10015 then
					for iter_140_4, iter_140_5 in pairs(arg_137_1.var_.actorSpriteComps10015:ToTable()) do
						if iter_140_5 then
							if arg_137_1.isInRecall_ then
								local var_140_12 = Mathf.Lerp(iter_140_5.color.r, arg_137_1.hightColor2.r, var_140_11)
								local var_140_13 = Mathf.Lerp(iter_140_5.color.g, arg_137_1.hightColor2.g, var_140_11)
								local var_140_14 = Mathf.Lerp(iter_140_5.color.b, arg_137_1.hightColor2.b, var_140_11)

								iter_140_5.color = Color.New(var_140_12, var_140_13, var_140_14)
							else
								local var_140_15 = Mathf.Lerp(iter_140_5.color.r, 0.5, var_140_11)

								iter_140_5.color = Color.New(var_140_15, var_140_15, var_140_15)
							end
						end
					end
				end
			end

			if arg_137_1.time_ >= var_140_9 + var_140_10 and arg_137_1.time_ < var_140_9 + var_140_10 + arg_140_0 and not isNil(var_140_8) and arg_137_1.var_.actorSpriteComps10015 then
				for iter_140_6, iter_140_7 in pairs(arg_137_1.var_.actorSpriteComps10015:ToTable()) do
					if iter_140_7 then
						if arg_137_1.isInRecall_ then
							iter_140_7.color = arg_137_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_140_7.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_137_1.var_.actorSpriteComps10015 = nil
			end

			local var_140_16 = 0
			local var_140_17 = 0.65

			if var_140_16 < arg_137_1.time_ and arg_137_1.time_ <= var_140_16 + arg_140_0 then
				arg_137_1.talkMaxDuration = 0
				arg_137_1.dialogCg_.alpha = 1

				arg_137_1.dialog_:SetActive(true)
				SetActive(arg_137_1.leftNameGo_, true)

				local var_140_18 = arg_137_1:FormatText(StoryNameCfg[257].name)

				arg_137_1.leftNameTxt_.text = var_140_18

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_137_1.leftNameTxt_.transform)

				arg_137_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_137_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_137_1:RecordName(arg_137_1.leftNameTxt_.text)
				SetActive(arg_137_1.iconTrs_.gameObject, false)
				arg_137_1.callingController_:SetSelectedState("normal")

				local var_140_19 = arg_137_1:GetWordFromCfg(114241034)
				local var_140_20 = arg_137_1:FormatText(var_140_19.content)

				arg_137_1.text_.text = var_140_20

				LuaForUtil.ClearLinePrefixSymbol(arg_137_1.text_)

				local var_140_21 = 26
				local var_140_22 = utf8.len(var_140_20)
				local var_140_23 = var_140_21 <= 0 and var_140_17 or var_140_17 * (var_140_22 / var_140_21)

				if var_140_23 > 0 and var_140_17 < var_140_23 then
					arg_137_1.talkMaxDuration = var_140_23

					if var_140_23 + var_140_16 > arg_137_1.duration_ then
						arg_137_1.duration_ = var_140_23 + var_140_16
					end
				end

				arg_137_1.text_.text = var_140_20
				arg_137_1.typewritter.percent = 0

				arg_137_1.typewritter:SetDirty()
				arg_137_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_114241", "114241034", "story_v_out_114241.awb") ~= 0 then
					local var_140_24 = manager.audio:GetVoiceLength("story_v_out_114241", "114241034", "story_v_out_114241.awb") / 1000

					if var_140_24 + var_140_16 > arg_137_1.duration_ then
						arg_137_1.duration_ = var_140_24 + var_140_16
					end

					if var_140_19.prefab_name ~= "" and arg_137_1.actors_[var_140_19.prefab_name] ~= nil then
						local var_140_25 = LuaForUtil.PlayVoiceWithCriLipsync(arg_137_1.actors_[var_140_19.prefab_name].transform, "story_v_out_114241", "114241034", "story_v_out_114241.awb")

						arg_137_1:RecordAudio("114241034", var_140_25)
						arg_137_1:RecordAudio("114241034", var_140_25)
					else
						arg_137_1:AudioAction("play", "voice", "story_v_out_114241", "114241034", "story_v_out_114241.awb")
					end

					arg_137_1:RecordHistoryTalkVoice("story_v_out_114241", "114241034", "story_v_out_114241.awb")
				end

				arg_137_1:RecordContent(arg_137_1.text_.text)
			end

			local var_140_26 = math.max(var_140_17, arg_137_1.talkMaxDuration)

			if var_140_16 <= arg_137_1.time_ and arg_137_1.time_ < var_140_16 + var_140_26 then
				arg_137_1.typewritter.percent = (arg_137_1.time_ - var_140_16) / var_140_26

				arg_137_1.typewritter:SetDirty()
			end

			if arg_137_1.time_ >= var_140_16 + var_140_26 and arg_137_1.time_ < var_140_16 + var_140_26 + arg_140_0 then
				arg_137_1.typewritter.percent = 1

				arg_137_1.typewritter:SetDirty()
				arg_137_1:ShowNextGo(true)
			end
		end

		arg_137_1.nodeConfigList_ = {}

		arg_137_1:InitPlayNodeList()
	end,
	Play114241035 = function(arg_141_0, arg_141_1)
		arg_141_1.time_ = 0
		arg_141_1.frameCnt_ = 0
		arg_141_1.state_ = "playing"
		arg_141_1.curTalkId_ = 114241035
		arg_141_1.duration_ = 4.9

		local var_141_0 = {
			ja = 3,
			ko = 4.9,
			zh = 4.3,
			en = 4.866
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
				arg_141_0:Play114241036(arg_141_1)
			end
		end

		function arg_141_1.onSingleLineUpdate_(arg_144_0)
			local var_144_0 = arg_141_1.actors_["10018"]
			local var_144_1 = 0

			if var_144_1 < arg_141_1.time_ and arg_141_1.time_ <= var_144_1 + arg_144_0 and not isNil(var_144_0) and arg_141_1.var_.actorSpriteComps10018 == nil then
				arg_141_1.var_.actorSpriteComps10018 = var_144_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_144_2 = 0.034

			if var_144_1 <= arg_141_1.time_ and arg_141_1.time_ < var_144_1 + var_144_2 and not isNil(var_144_0) then
				local var_144_3 = (arg_141_1.time_ - var_144_1) / var_144_2

				if arg_141_1.var_.actorSpriteComps10018 then
					for iter_144_0, iter_144_1 in pairs(arg_141_1.var_.actorSpriteComps10018:ToTable()) do
						if iter_144_1 then
							if arg_141_1.isInRecall_ then
								local var_144_4 = Mathf.Lerp(iter_144_1.color.r, arg_141_1.hightColor2.r, var_144_3)
								local var_144_5 = Mathf.Lerp(iter_144_1.color.g, arg_141_1.hightColor2.g, var_144_3)
								local var_144_6 = Mathf.Lerp(iter_144_1.color.b, arg_141_1.hightColor2.b, var_144_3)

								iter_144_1.color = Color.New(var_144_4, var_144_5, var_144_6)
							else
								local var_144_7 = Mathf.Lerp(iter_144_1.color.r, 0.5, var_144_3)

								iter_144_1.color = Color.New(var_144_7, var_144_7, var_144_7)
							end
						end
					end
				end
			end

			if arg_141_1.time_ >= var_144_1 + var_144_2 and arg_141_1.time_ < var_144_1 + var_144_2 + arg_144_0 and not isNil(var_144_0) and arg_141_1.var_.actorSpriteComps10018 then
				for iter_144_2, iter_144_3 in pairs(arg_141_1.var_.actorSpriteComps10018:ToTable()) do
					if iter_144_3 then
						if arg_141_1.isInRecall_ then
							iter_144_3.color = arg_141_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_144_3.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_141_1.var_.actorSpriteComps10018 = nil
			end

			local var_144_8 = arg_141_1.actors_["10015"]
			local var_144_9 = 0

			if var_144_9 < arg_141_1.time_ and arg_141_1.time_ <= var_144_9 + arg_144_0 and not isNil(var_144_8) and arg_141_1.var_.actorSpriteComps10015 == nil then
				arg_141_1.var_.actorSpriteComps10015 = var_144_8:GetComponentsInChildren(typeof(Image), true)
			end

			local var_144_10 = 0.034

			if var_144_9 <= arg_141_1.time_ and arg_141_1.time_ < var_144_9 + var_144_10 and not isNil(var_144_8) then
				local var_144_11 = (arg_141_1.time_ - var_144_9) / var_144_10

				if arg_141_1.var_.actorSpriteComps10015 then
					for iter_144_4, iter_144_5 in pairs(arg_141_1.var_.actorSpriteComps10015:ToTable()) do
						if iter_144_5 then
							if arg_141_1.isInRecall_ then
								local var_144_12 = Mathf.Lerp(iter_144_5.color.r, arg_141_1.hightColor1.r, var_144_11)
								local var_144_13 = Mathf.Lerp(iter_144_5.color.g, arg_141_1.hightColor1.g, var_144_11)
								local var_144_14 = Mathf.Lerp(iter_144_5.color.b, arg_141_1.hightColor1.b, var_144_11)

								iter_144_5.color = Color.New(var_144_12, var_144_13, var_144_14)
							else
								local var_144_15 = Mathf.Lerp(iter_144_5.color.r, 1, var_144_11)

								iter_144_5.color = Color.New(var_144_15, var_144_15, var_144_15)
							end
						end
					end
				end
			end

			if arg_141_1.time_ >= var_144_9 + var_144_10 and arg_141_1.time_ < var_144_9 + var_144_10 + arg_144_0 and not isNil(var_144_8) and arg_141_1.var_.actorSpriteComps10015 then
				for iter_144_6, iter_144_7 in pairs(arg_141_1.var_.actorSpriteComps10015:ToTable()) do
					if iter_144_7 then
						if arg_141_1.isInRecall_ then
							iter_144_7.color = arg_141_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_144_7.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_141_1.var_.actorSpriteComps10015 = nil
			end

			local var_144_16 = 0
			local var_144_17 = 0.55

			if var_144_16 < arg_141_1.time_ and arg_141_1.time_ <= var_144_16 + arg_144_0 then
				arg_141_1.talkMaxDuration = 0
				arg_141_1.dialogCg_.alpha = 1

				arg_141_1.dialog_:SetActive(true)
				SetActive(arg_141_1.leftNameGo_, true)

				local var_144_18 = arg_141_1:FormatText(StoryNameCfg[208].name)

				arg_141_1.leftNameTxt_.text = var_144_18

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_141_1.leftNameTxt_.transform)

				arg_141_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_141_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_141_1:RecordName(arg_141_1.leftNameTxt_.text)
				SetActive(arg_141_1.iconTrs_.gameObject, false)
				arg_141_1.callingController_:SetSelectedState("normal")

				local var_144_19 = arg_141_1:GetWordFromCfg(114241035)
				local var_144_20 = arg_141_1:FormatText(var_144_19.content)

				arg_141_1.text_.text = var_144_20

				LuaForUtil.ClearLinePrefixSymbol(arg_141_1.text_)

				local var_144_21 = 22
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

				if manager.audio:GetVoiceLength("story_v_out_114241", "114241035", "story_v_out_114241.awb") ~= 0 then
					local var_144_24 = manager.audio:GetVoiceLength("story_v_out_114241", "114241035", "story_v_out_114241.awb") / 1000

					if var_144_24 + var_144_16 > arg_141_1.duration_ then
						arg_141_1.duration_ = var_144_24 + var_144_16
					end

					if var_144_19.prefab_name ~= "" and arg_141_1.actors_[var_144_19.prefab_name] ~= nil then
						local var_144_25 = LuaForUtil.PlayVoiceWithCriLipsync(arg_141_1.actors_[var_144_19.prefab_name].transform, "story_v_out_114241", "114241035", "story_v_out_114241.awb")

						arg_141_1:RecordAudio("114241035", var_144_25)
						arg_141_1:RecordAudio("114241035", var_144_25)
					else
						arg_141_1:AudioAction("play", "voice", "story_v_out_114241", "114241035", "story_v_out_114241.awb")
					end

					arg_141_1:RecordHistoryTalkVoice("story_v_out_114241", "114241035", "story_v_out_114241.awb")
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
	Play114241036 = function(arg_145_0, arg_145_1)
		arg_145_1.time_ = 0
		arg_145_1.frameCnt_ = 0
		arg_145_1.state_ = "playing"
		arg_145_1.curTalkId_ = 114241036
		arg_145_1.duration_ = 12.33

		local var_145_0 = {
			ja = 9.2,
			ko = 8.4,
			zh = 9.9,
			en = 12.333
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
				arg_145_0:Play114241037(arg_145_1)
			end
		end

		function arg_145_1.onSingleLineUpdate_(arg_148_0)
			local var_148_0 = arg_145_1.actors_["10018"]
			local var_148_1 = 0

			if var_148_1 < arg_145_1.time_ and arg_145_1.time_ <= var_148_1 + arg_148_0 and not isNil(var_148_0) and arg_145_1.var_.actorSpriteComps10018 == nil then
				arg_145_1.var_.actorSpriteComps10018 = var_148_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_148_2 = 0.034

			if var_148_1 <= arg_145_1.time_ and arg_145_1.time_ < var_148_1 + var_148_2 and not isNil(var_148_0) then
				local var_148_3 = (arg_145_1.time_ - var_148_1) / var_148_2

				if arg_145_1.var_.actorSpriteComps10018 then
					for iter_148_0, iter_148_1 in pairs(arg_145_1.var_.actorSpriteComps10018:ToTable()) do
						if iter_148_1 then
							if arg_145_1.isInRecall_ then
								local var_148_4 = Mathf.Lerp(iter_148_1.color.r, arg_145_1.hightColor1.r, var_148_3)
								local var_148_5 = Mathf.Lerp(iter_148_1.color.g, arg_145_1.hightColor1.g, var_148_3)
								local var_148_6 = Mathf.Lerp(iter_148_1.color.b, arg_145_1.hightColor1.b, var_148_3)

								iter_148_1.color = Color.New(var_148_4, var_148_5, var_148_6)
							else
								local var_148_7 = Mathf.Lerp(iter_148_1.color.r, 1, var_148_3)

								iter_148_1.color = Color.New(var_148_7, var_148_7, var_148_7)
							end
						end
					end
				end
			end

			if arg_145_1.time_ >= var_148_1 + var_148_2 and arg_145_1.time_ < var_148_1 + var_148_2 + arg_148_0 and not isNil(var_148_0) and arg_145_1.var_.actorSpriteComps10018 then
				for iter_148_2, iter_148_3 in pairs(arg_145_1.var_.actorSpriteComps10018:ToTable()) do
					if iter_148_3 then
						if arg_145_1.isInRecall_ then
							iter_148_3.color = arg_145_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_148_3.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_145_1.var_.actorSpriteComps10018 = nil
			end

			local var_148_8 = arg_145_1.actors_["10015"]
			local var_148_9 = 0

			if var_148_9 < arg_145_1.time_ and arg_145_1.time_ <= var_148_9 + arg_148_0 and not isNil(var_148_8) and arg_145_1.var_.actorSpriteComps10015 == nil then
				arg_145_1.var_.actorSpriteComps10015 = var_148_8:GetComponentsInChildren(typeof(Image), true)
			end

			local var_148_10 = 0.034

			if var_148_9 <= arg_145_1.time_ and arg_145_1.time_ < var_148_9 + var_148_10 and not isNil(var_148_8) then
				local var_148_11 = (arg_145_1.time_ - var_148_9) / var_148_10

				if arg_145_1.var_.actorSpriteComps10015 then
					for iter_148_4, iter_148_5 in pairs(arg_145_1.var_.actorSpriteComps10015:ToTable()) do
						if iter_148_5 then
							if arg_145_1.isInRecall_ then
								local var_148_12 = Mathf.Lerp(iter_148_5.color.r, arg_145_1.hightColor2.r, var_148_11)
								local var_148_13 = Mathf.Lerp(iter_148_5.color.g, arg_145_1.hightColor2.g, var_148_11)
								local var_148_14 = Mathf.Lerp(iter_148_5.color.b, arg_145_1.hightColor2.b, var_148_11)

								iter_148_5.color = Color.New(var_148_12, var_148_13, var_148_14)
							else
								local var_148_15 = Mathf.Lerp(iter_148_5.color.r, 0.5, var_148_11)

								iter_148_5.color = Color.New(var_148_15, var_148_15, var_148_15)
							end
						end
					end
				end
			end

			if arg_145_1.time_ >= var_148_9 + var_148_10 and arg_145_1.time_ < var_148_9 + var_148_10 + arg_148_0 and not isNil(var_148_8) and arg_145_1.var_.actorSpriteComps10015 then
				for iter_148_6, iter_148_7 in pairs(arg_145_1.var_.actorSpriteComps10015:ToTable()) do
					if iter_148_7 then
						if arg_145_1.isInRecall_ then
							iter_148_7.color = arg_145_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_148_7.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_145_1.var_.actorSpriteComps10015 = nil
			end

			local var_148_16 = 0
			local var_148_17 = 1.1

			if var_148_16 < arg_145_1.time_ and arg_145_1.time_ <= var_148_16 + arg_148_0 then
				arg_145_1.talkMaxDuration = 0
				arg_145_1.dialogCg_.alpha = 1

				arg_145_1.dialog_:SetActive(true)
				SetActive(arg_145_1.leftNameGo_, true)

				local var_148_18 = arg_145_1:FormatText(StoryNameCfg[257].name)

				arg_145_1.leftNameTxt_.text = var_148_18

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_145_1.leftNameTxt_.transform)

				arg_145_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_145_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_145_1:RecordName(arg_145_1.leftNameTxt_.text)
				SetActive(arg_145_1.iconTrs_.gameObject, false)
				arg_145_1.callingController_:SetSelectedState("normal")

				local var_148_19 = arg_145_1:GetWordFromCfg(114241036)
				local var_148_20 = arg_145_1:FormatText(var_148_19.content)

				arg_145_1.text_.text = var_148_20

				LuaForUtil.ClearLinePrefixSymbol(arg_145_1.text_)

				local var_148_21 = 44
				local var_148_22 = utf8.len(var_148_20)
				local var_148_23 = var_148_21 <= 0 and var_148_17 or var_148_17 * (var_148_22 / var_148_21)

				if var_148_23 > 0 and var_148_17 < var_148_23 then
					arg_145_1.talkMaxDuration = var_148_23

					if var_148_23 + var_148_16 > arg_145_1.duration_ then
						arg_145_1.duration_ = var_148_23 + var_148_16
					end
				end

				arg_145_1.text_.text = var_148_20
				arg_145_1.typewritter.percent = 0

				arg_145_1.typewritter:SetDirty()
				arg_145_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_114241", "114241036", "story_v_out_114241.awb") ~= 0 then
					local var_148_24 = manager.audio:GetVoiceLength("story_v_out_114241", "114241036", "story_v_out_114241.awb") / 1000

					if var_148_24 + var_148_16 > arg_145_1.duration_ then
						arg_145_1.duration_ = var_148_24 + var_148_16
					end

					if var_148_19.prefab_name ~= "" and arg_145_1.actors_[var_148_19.prefab_name] ~= nil then
						local var_148_25 = LuaForUtil.PlayVoiceWithCriLipsync(arg_145_1.actors_[var_148_19.prefab_name].transform, "story_v_out_114241", "114241036", "story_v_out_114241.awb")

						arg_145_1:RecordAudio("114241036", var_148_25)
						arg_145_1:RecordAudio("114241036", var_148_25)
					else
						arg_145_1:AudioAction("play", "voice", "story_v_out_114241", "114241036", "story_v_out_114241.awb")
					end

					arg_145_1:RecordHistoryTalkVoice("story_v_out_114241", "114241036", "story_v_out_114241.awb")
				end

				arg_145_1:RecordContent(arg_145_1.text_.text)
			end

			local var_148_26 = math.max(var_148_17, arg_145_1.talkMaxDuration)

			if var_148_16 <= arg_145_1.time_ and arg_145_1.time_ < var_148_16 + var_148_26 then
				arg_145_1.typewritter.percent = (arg_145_1.time_ - var_148_16) / var_148_26

				arg_145_1.typewritter:SetDirty()
			end

			if arg_145_1.time_ >= var_148_16 + var_148_26 and arg_145_1.time_ < var_148_16 + var_148_26 + arg_148_0 then
				arg_145_1.typewritter.percent = 1

				arg_145_1.typewritter:SetDirty()
				arg_145_1:ShowNextGo(true)
			end
		end

		arg_145_1.nodeConfigList_ = {}

		arg_145_1:InitPlayNodeList()
	end,
	Play114241037 = function(arg_149_0, arg_149_1)
		arg_149_1.time_ = 0
		arg_149_1.frameCnt_ = 0
		arg_149_1.state_ = "playing"
		arg_149_1.curTalkId_ = 114241037
		arg_149_1.duration_ = 9.57

		local var_149_0 = {
			ja = 2.833,
			ko = 9.566,
			zh = 6.9,
			en = 7.4
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
				arg_149_0:Play114241038(arg_149_1)
			end
		end

		function arg_149_1.onSingleLineUpdate_(arg_152_0)
			local var_152_0 = arg_149_1.actors_["10018"]
			local var_152_1 = 0

			if var_152_1 < arg_149_1.time_ and arg_149_1.time_ <= var_152_1 + arg_152_0 and not isNil(var_152_0) and arg_149_1.var_.actorSpriteComps10018 == nil then
				arg_149_1.var_.actorSpriteComps10018 = var_152_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_152_2 = 0.034

			if var_152_1 <= arg_149_1.time_ and arg_149_1.time_ < var_152_1 + var_152_2 and not isNil(var_152_0) then
				local var_152_3 = (arg_149_1.time_ - var_152_1) / var_152_2

				if arg_149_1.var_.actorSpriteComps10018 then
					for iter_152_0, iter_152_1 in pairs(arg_149_1.var_.actorSpriteComps10018:ToTable()) do
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

			if arg_149_1.time_ >= var_152_1 + var_152_2 and arg_149_1.time_ < var_152_1 + var_152_2 + arg_152_0 and not isNil(var_152_0) and arg_149_1.var_.actorSpriteComps10018 then
				for iter_152_2, iter_152_3 in pairs(arg_149_1.var_.actorSpriteComps10018:ToTable()) do
					if iter_152_3 then
						if arg_149_1.isInRecall_ then
							iter_152_3.color = arg_149_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_152_3.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_149_1.var_.actorSpriteComps10018 = nil
			end

			local var_152_8 = arg_149_1.actors_["10015"]
			local var_152_9 = 0

			if var_152_9 < arg_149_1.time_ and arg_149_1.time_ <= var_152_9 + arg_152_0 and not isNil(var_152_8) and arg_149_1.var_.actorSpriteComps10015 == nil then
				arg_149_1.var_.actorSpriteComps10015 = var_152_8:GetComponentsInChildren(typeof(Image), true)
			end

			local var_152_10 = 0.034

			if var_152_9 <= arg_149_1.time_ and arg_149_1.time_ < var_152_9 + var_152_10 and not isNil(var_152_8) then
				local var_152_11 = (arg_149_1.time_ - var_152_9) / var_152_10

				if arg_149_1.var_.actorSpriteComps10015 then
					for iter_152_4, iter_152_5 in pairs(arg_149_1.var_.actorSpriteComps10015:ToTable()) do
						if iter_152_5 then
							if arg_149_1.isInRecall_ then
								local var_152_12 = Mathf.Lerp(iter_152_5.color.r, arg_149_1.hightColor1.r, var_152_11)
								local var_152_13 = Mathf.Lerp(iter_152_5.color.g, arg_149_1.hightColor1.g, var_152_11)
								local var_152_14 = Mathf.Lerp(iter_152_5.color.b, arg_149_1.hightColor1.b, var_152_11)

								iter_152_5.color = Color.New(var_152_12, var_152_13, var_152_14)
							else
								local var_152_15 = Mathf.Lerp(iter_152_5.color.r, 1, var_152_11)

								iter_152_5.color = Color.New(var_152_15, var_152_15, var_152_15)
							end
						end
					end
				end
			end

			if arg_149_1.time_ >= var_152_9 + var_152_10 and arg_149_1.time_ < var_152_9 + var_152_10 + arg_152_0 and not isNil(var_152_8) and arg_149_1.var_.actorSpriteComps10015 then
				for iter_152_6, iter_152_7 in pairs(arg_149_1.var_.actorSpriteComps10015:ToTable()) do
					if iter_152_7 then
						if arg_149_1.isInRecall_ then
							iter_152_7.color = arg_149_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_152_7.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_149_1.var_.actorSpriteComps10015 = nil
			end

			local var_152_16 = arg_149_1.actors_["10015"].transform
			local var_152_17 = 0

			if var_152_17 < arg_149_1.time_ and arg_149_1.time_ <= var_152_17 + arg_152_0 then
				arg_149_1.var_.moveOldPos10015 = var_152_16.localPosition
				var_152_16.localScale = Vector3.New(1, 1, 1)

				arg_149_1:CheckSpriteTmpPos("10015", 4)

				local var_152_18 = var_152_16.childCount

				for iter_152_8 = 0, var_152_18 - 1 do
					local var_152_19 = var_152_16:GetChild(iter_152_8)

					if var_152_19.name == "split_5" or not string.find(var_152_19.name, "split") then
						var_152_19.gameObject:SetActive(true)
					else
						var_152_19.gameObject:SetActive(false)
					end
				end
			end

			local var_152_20 = 0.001

			if var_152_17 <= arg_149_1.time_ and arg_149_1.time_ < var_152_17 + var_152_20 then
				local var_152_21 = (arg_149_1.time_ - var_152_17) / var_152_20
				local var_152_22 = Vector3.New(390, -350, -180)

				var_152_16.localPosition = Vector3.Lerp(arg_149_1.var_.moveOldPos10015, var_152_22, var_152_21)
			end

			if arg_149_1.time_ >= var_152_17 + var_152_20 and arg_149_1.time_ < var_152_17 + var_152_20 + arg_152_0 then
				var_152_16.localPosition = Vector3.New(390, -350, -180)
			end

			local var_152_23 = 0
			local var_152_24 = 0.5

			if var_152_23 < arg_149_1.time_ and arg_149_1.time_ <= var_152_23 + arg_152_0 then
				arg_149_1.talkMaxDuration = 0
				arg_149_1.dialogCg_.alpha = 1

				arg_149_1.dialog_:SetActive(true)
				SetActive(arg_149_1.leftNameGo_, true)

				local var_152_25 = arg_149_1:FormatText(StoryNameCfg[208].name)

				arg_149_1.leftNameTxt_.text = var_152_25

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_149_1.leftNameTxt_.transform)

				arg_149_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_149_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_149_1:RecordName(arg_149_1.leftNameTxt_.text)
				SetActive(arg_149_1.iconTrs_.gameObject, false)
				arg_149_1.callingController_:SetSelectedState("normal")

				local var_152_26 = arg_149_1:GetWordFromCfg(114241037)
				local var_152_27 = arg_149_1:FormatText(var_152_26.content)

				arg_149_1.text_.text = var_152_27

				LuaForUtil.ClearLinePrefixSymbol(arg_149_1.text_)

				local var_152_28 = 20
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

				if manager.audio:GetVoiceLength("story_v_out_114241", "114241037", "story_v_out_114241.awb") ~= 0 then
					local var_152_31 = manager.audio:GetVoiceLength("story_v_out_114241", "114241037", "story_v_out_114241.awb") / 1000

					if var_152_31 + var_152_23 > arg_149_1.duration_ then
						arg_149_1.duration_ = var_152_31 + var_152_23
					end

					if var_152_26.prefab_name ~= "" and arg_149_1.actors_[var_152_26.prefab_name] ~= nil then
						local var_152_32 = LuaForUtil.PlayVoiceWithCriLipsync(arg_149_1.actors_[var_152_26.prefab_name].transform, "story_v_out_114241", "114241037", "story_v_out_114241.awb")

						arg_149_1:RecordAudio("114241037", var_152_32)
						arg_149_1:RecordAudio("114241037", var_152_32)
					else
						arg_149_1:AudioAction("play", "voice", "story_v_out_114241", "114241037", "story_v_out_114241.awb")
					end

					arg_149_1:RecordHistoryTalkVoice("story_v_out_114241", "114241037", "story_v_out_114241.awb")
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
				actorName = "10015",
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
	Play114241038 = function(arg_153_0, arg_153_1)
		arg_153_1.time_ = 0
		arg_153_1.frameCnt_ = 0
		arg_153_1.state_ = "playing"
		arg_153_1.curTalkId_ = 114241038
		arg_153_1.duration_ = 3.43

		local var_153_0 = {
			ja = 2.933,
			ko = 3.433,
			zh = 2.5,
			en = 1.333
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
				arg_153_0:Play114241039(arg_153_1)
			end
		end

		function arg_153_1.onSingleLineUpdate_(arg_156_0)
			local var_156_0 = arg_153_1.actors_["10018"]
			local var_156_1 = 0

			if var_156_1 < arg_153_1.time_ and arg_153_1.time_ <= var_156_1 + arg_156_0 and not isNil(var_156_0) and arg_153_1.var_.actorSpriteComps10018 == nil then
				arg_153_1.var_.actorSpriteComps10018 = var_156_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_156_2 = 0.034

			if var_156_1 <= arg_153_1.time_ and arg_153_1.time_ < var_156_1 + var_156_2 and not isNil(var_156_0) then
				local var_156_3 = (arg_153_1.time_ - var_156_1) / var_156_2

				if arg_153_1.var_.actorSpriteComps10018 then
					for iter_156_0, iter_156_1 in pairs(arg_153_1.var_.actorSpriteComps10018:ToTable()) do
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

			if arg_153_1.time_ >= var_156_1 + var_156_2 and arg_153_1.time_ < var_156_1 + var_156_2 + arg_156_0 and not isNil(var_156_0) and arg_153_1.var_.actorSpriteComps10018 then
				for iter_156_2, iter_156_3 in pairs(arg_153_1.var_.actorSpriteComps10018:ToTable()) do
					if iter_156_3 then
						if arg_153_1.isInRecall_ then
							iter_156_3.color = arg_153_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_156_3.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_153_1.var_.actorSpriteComps10018 = nil
			end

			local var_156_8 = arg_153_1.actors_["10015"]
			local var_156_9 = 0

			if var_156_9 < arg_153_1.time_ and arg_153_1.time_ <= var_156_9 + arg_156_0 and not isNil(var_156_8) and arg_153_1.var_.actorSpriteComps10015 == nil then
				arg_153_1.var_.actorSpriteComps10015 = var_156_8:GetComponentsInChildren(typeof(Image), true)
			end

			local var_156_10 = 0.034

			if var_156_9 <= arg_153_1.time_ and arg_153_1.time_ < var_156_9 + var_156_10 and not isNil(var_156_8) then
				local var_156_11 = (arg_153_1.time_ - var_156_9) / var_156_10

				if arg_153_1.var_.actorSpriteComps10015 then
					for iter_156_4, iter_156_5 in pairs(arg_153_1.var_.actorSpriteComps10015:ToTable()) do
						if iter_156_5 then
							if arg_153_1.isInRecall_ then
								local var_156_12 = Mathf.Lerp(iter_156_5.color.r, arg_153_1.hightColor2.r, var_156_11)
								local var_156_13 = Mathf.Lerp(iter_156_5.color.g, arg_153_1.hightColor2.g, var_156_11)
								local var_156_14 = Mathf.Lerp(iter_156_5.color.b, arg_153_1.hightColor2.b, var_156_11)

								iter_156_5.color = Color.New(var_156_12, var_156_13, var_156_14)
							else
								local var_156_15 = Mathf.Lerp(iter_156_5.color.r, 0.5, var_156_11)

								iter_156_5.color = Color.New(var_156_15, var_156_15, var_156_15)
							end
						end
					end
				end
			end

			if arg_153_1.time_ >= var_156_9 + var_156_10 and arg_153_1.time_ < var_156_9 + var_156_10 + arg_156_0 and not isNil(var_156_8) and arg_153_1.var_.actorSpriteComps10015 then
				for iter_156_6, iter_156_7 in pairs(arg_153_1.var_.actorSpriteComps10015:ToTable()) do
					if iter_156_7 then
						if arg_153_1.isInRecall_ then
							iter_156_7.color = arg_153_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_156_7.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_153_1.var_.actorSpriteComps10015 = nil
			end

			local var_156_16 = 0
			local var_156_17 = 0.2

			if var_156_16 < arg_153_1.time_ and arg_153_1.time_ <= var_156_16 + arg_156_0 then
				arg_153_1.talkMaxDuration = 0
				arg_153_1.dialogCg_.alpha = 1

				arg_153_1.dialog_:SetActive(true)
				SetActive(arg_153_1.leftNameGo_, true)

				local var_156_18 = arg_153_1:FormatText(StoryNameCfg[257].name)

				arg_153_1.leftNameTxt_.text = var_156_18

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_153_1.leftNameTxt_.transform)

				arg_153_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_153_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_153_1:RecordName(arg_153_1.leftNameTxt_.text)
				SetActive(arg_153_1.iconTrs_.gameObject, false)
				arg_153_1.callingController_:SetSelectedState("normal")

				local var_156_19 = arg_153_1:GetWordFromCfg(114241038)
				local var_156_20 = arg_153_1:FormatText(var_156_19.content)

				arg_153_1.text_.text = var_156_20

				LuaForUtil.ClearLinePrefixSymbol(arg_153_1.text_)

				local var_156_21 = 8
				local var_156_22 = utf8.len(var_156_20)
				local var_156_23 = var_156_21 <= 0 and var_156_17 or var_156_17 * (var_156_22 / var_156_21)

				if var_156_23 > 0 and var_156_17 < var_156_23 then
					arg_153_1.talkMaxDuration = var_156_23

					if var_156_23 + var_156_16 > arg_153_1.duration_ then
						arg_153_1.duration_ = var_156_23 + var_156_16
					end
				end

				arg_153_1.text_.text = var_156_20
				arg_153_1.typewritter.percent = 0

				arg_153_1.typewritter:SetDirty()
				arg_153_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_114241", "114241038", "story_v_out_114241.awb") ~= 0 then
					local var_156_24 = manager.audio:GetVoiceLength("story_v_out_114241", "114241038", "story_v_out_114241.awb") / 1000

					if var_156_24 + var_156_16 > arg_153_1.duration_ then
						arg_153_1.duration_ = var_156_24 + var_156_16
					end

					if var_156_19.prefab_name ~= "" and arg_153_1.actors_[var_156_19.prefab_name] ~= nil then
						local var_156_25 = LuaForUtil.PlayVoiceWithCriLipsync(arg_153_1.actors_[var_156_19.prefab_name].transform, "story_v_out_114241", "114241038", "story_v_out_114241.awb")

						arg_153_1:RecordAudio("114241038", var_156_25)
						arg_153_1:RecordAudio("114241038", var_156_25)
					else
						arg_153_1:AudioAction("play", "voice", "story_v_out_114241", "114241038", "story_v_out_114241.awb")
					end

					arg_153_1:RecordHistoryTalkVoice("story_v_out_114241", "114241038", "story_v_out_114241.awb")
				end

				arg_153_1:RecordContent(arg_153_1.text_.text)
			end

			local var_156_26 = math.max(var_156_17, arg_153_1.talkMaxDuration)

			if var_156_16 <= arg_153_1.time_ and arg_153_1.time_ < var_156_16 + var_156_26 then
				arg_153_1.typewritter.percent = (arg_153_1.time_ - var_156_16) / var_156_26

				arg_153_1.typewritter:SetDirty()
			end

			if arg_153_1.time_ >= var_156_16 + var_156_26 and arg_153_1.time_ < var_156_16 + var_156_26 + arg_156_0 then
				arg_153_1.typewritter.percent = 1

				arg_153_1.typewritter:SetDirty()
				arg_153_1:ShowNextGo(true)
			end
		end

		arg_153_1.nodeConfigList_ = {}

		arg_153_1:InitPlayNodeList()
	end,
	Play114241039 = function(arg_157_0, arg_157_1)
		arg_157_1.time_ = 0
		arg_157_1.frameCnt_ = 0
		arg_157_1.state_ = "playing"
		arg_157_1.curTalkId_ = 114241039
		arg_157_1.duration_ = 2.9

		local var_157_0 = {
			ja = 2.9,
			ko = 1.9,
			zh = 1.333,
			en = 2.4
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
				arg_157_0:Play114241040(arg_157_1)
			end
		end

		function arg_157_1.onSingleLineUpdate_(arg_160_0)
			local var_160_0 = arg_157_1.actors_["10015"].transform
			local var_160_1 = 0

			if var_160_1 < arg_157_1.time_ and arg_157_1.time_ <= var_160_1 + arg_160_0 then
				arg_157_1.var_.moveOldPos10015 = var_160_0.localPosition
				var_160_0.localScale = Vector3.New(1, 1, 1)

				arg_157_1:CheckSpriteTmpPos("10015", 4)

				local var_160_2 = var_160_0.childCount

				for iter_160_0 = 0, var_160_2 - 1 do
					local var_160_3 = var_160_0:GetChild(iter_160_0)

					if var_160_3.name == "split_2" or not string.find(var_160_3.name, "split") then
						var_160_3.gameObject:SetActive(true)
					else
						var_160_3.gameObject:SetActive(false)
					end
				end
			end

			local var_160_4 = 0.001

			if var_160_1 <= arg_157_1.time_ and arg_157_1.time_ < var_160_1 + var_160_4 then
				local var_160_5 = (arg_157_1.time_ - var_160_1) / var_160_4
				local var_160_6 = Vector3.New(390, -350, -180)

				var_160_0.localPosition = Vector3.Lerp(arg_157_1.var_.moveOldPos10015, var_160_6, var_160_5)
			end

			if arg_157_1.time_ >= var_160_1 + var_160_4 and arg_157_1.time_ < var_160_1 + var_160_4 + arg_160_0 then
				var_160_0.localPosition = Vector3.New(390, -350, -180)
			end

			local var_160_7 = arg_157_1.actors_["10018"]
			local var_160_8 = 0

			if var_160_8 < arg_157_1.time_ and arg_157_1.time_ <= var_160_8 + arg_160_0 and not isNil(var_160_7) and arg_157_1.var_.actorSpriteComps10018 == nil then
				arg_157_1.var_.actorSpriteComps10018 = var_160_7:GetComponentsInChildren(typeof(Image), true)
			end

			local var_160_9 = 0.034

			if var_160_8 <= arg_157_1.time_ and arg_157_1.time_ < var_160_8 + var_160_9 and not isNil(var_160_7) then
				local var_160_10 = (arg_157_1.time_ - var_160_8) / var_160_9

				if arg_157_1.var_.actorSpriteComps10018 then
					for iter_160_1, iter_160_2 in pairs(arg_157_1.var_.actorSpriteComps10018:ToTable()) do
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

			if arg_157_1.time_ >= var_160_8 + var_160_9 and arg_157_1.time_ < var_160_8 + var_160_9 + arg_160_0 and not isNil(var_160_7) and arg_157_1.var_.actorSpriteComps10018 then
				for iter_160_3, iter_160_4 in pairs(arg_157_1.var_.actorSpriteComps10018:ToTable()) do
					if iter_160_4 then
						if arg_157_1.isInRecall_ then
							iter_160_4.color = arg_157_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_160_4.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_157_1.var_.actorSpriteComps10018 = nil
			end

			local var_160_15 = arg_157_1.actors_["10015"]
			local var_160_16 = 0

			if var_160_16 < arg_157_1.time_ and arg_157_1.time_ <= var_160_16 + arg_160_0 and not isNil(var_160_15) and arg_157_1.var_.actorSpriteComps10015 == nil then
				arg_157_1.var_.actorSpriteComps10015 = var_160_15:GetComponentsInChildren(typeof(Image), true)
			end

			local var_160_17 = 0.034

			if var_160_16 <= arg_157_1.time_ and arg_157_1.time_ < var_160_16 + var_160_17 and not isNil(var_160_15) then
				local var_160_18 = (arg_157_1.time_ - var_160_16) / var_160_17

				if arg_157_1.var_.actorSpriteComps10015 then
					for iter_160_5, iter_160_6 in pairs(arg_157_1.var_.actorSpriteComps10015:ToTable()) do
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

			if arg_157_1.time_ >= var_160_16 + var_160_17 and arg_157_1.time_ < var_160_16 + var_160_17 + arg_160_0 and not isNil(var_160_15) and arg_157_1.var_.actorSpriteComps10015 then
				for iter_160_7, iter_160_8 in pairs(arg_157_1.var_.actorSpriteComps10015:ToTable()) do
					if iter_160_8 then
						if arg_157_1.isInRecall_ then
							iter_160_8.color = arg_157_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_160_8.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_157_1.var_.actorSpriteComps10015 = nil
			end

			local var_160_23 = 0
			local var_160_24 = 0.1

			if var_160_23 < arg_157_1.time_ and arg_157_1.time_ <= var_160_23 + arg_160_0 then
				arg_157_1.talkMaxDuration = 0
				arg_157_1.dialogCg_.alpha = 1

				arg_157_1.dialog_:SetActive(true)
				SetActive(arg_157_1.leftNameGo_, true)

				local var_160_25 = arg_157_1:FormatText(StoryNameCfg[208].name)

				arg_157_1.leftNameTxt_.text = var_160_25

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_157_1.leftNameTxt_.transform)

				arg_157_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_157_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_157_1:RecordName(arg_157_1.leftNameTxt_.text)
				SetActive(arg_157_1.iconTrs_.gameObject, false)
				arg_157_1.callingController_:SetSelectedState("normal")

				local var_160_26 = arg_157_1:GetWordFromCfg(114241039)
				local var_160_27 = arg_157_1:FormatText(var_160_26.content)

				arg_157_1.text_.text = var_160_27

				LuaForUtil.ClearLinePrefixSymbol(arg_157_1.text_)

				local var_160_28 = 4
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

				if manager.audio:GetVoiceLength("story_v_out_114241", "114241039", "story_v_out_114241.awb") ~= 0 then
					local var_160_31 = manager.audio:GetVoiceLength("story_v_out_114241", "114241039", "story_v_out_114241.awb") / 1000

					if var_160_31 + var_160_23 > arg_157_1.duration_ then
						arg_157_1.duration_ = var_160_31 + var_160_23
					end

					if var_160_26.prefab_name ~= "" and arg_157_1.actors_[var_160_26.prefab_name] ~= nil then
						local var_160_32 = LuaForUtil.PlayVoiceWithCriLipsync(arg_157_1.actors_[var_160_26.prefab_name].transform, "story_v_out_114241", "114241039", "story_v_out_114241.awb")

						arg_157_1:RecordAudio("114241039", var_160_32)
						arg_157_1:RecordAudio("114241039", var_160_32)
					else
						arg_157_1:AudioAction("play", "voice", "story_v_out_114241", "114241039", "story_v_out_114241.awb")
					end

					arg_157_1:RecordHistoryTalkVoice("story_v_out_114241", "114241039", "story_v_out_114241.awb")
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
				actorName = "10015",
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
	Play114241040 = function(arg_161_0, arg_161_1)
		arg_161_1.time_ = 0
		arg_161_1.frameCnt_ = 0
		arg_161_1.state_ = "playing"
		arg_161_1.curTalkId_ = 114241040
		arg_161_1.duration_ = 12.43

		local var_161_0 = {
			ja = 5.766,
			ko = 5.666,
			zh = 5.166,
			en = 12.433
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
				arg_161_0:Play114241041(arg_161_1)
			end
		end

		function arg_161_1.onSingleLineUpdate_(arg_164_0)
			local var_164_0 = arg_161_1.actors_["10018"]
			local var_164_1 = 0

			if var_164_1 < arg_161_1.time_ and arg_161_1.time_ <= var_164_1 + arg_164_0 and not isNil(var_164_0) and arg_161_1.var_.actorSpriteComps10018 == nil then
				arg_161_1.var_.actorSpriteComps10018 = var_164_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_164_2 = 0.034

			if var_164_1 <= arg_161_1.time_ and arg_161_1.time_ < var_164_1 + var_164_2 and not isNil(var_164_0) then
				local var_164_3 = (arg_161_1.time_ - var_164_1) / var_164_2

				if arg_161_1.var_.actorSpriteComps10018 then
					for iter_164_0, iter_164_1 in pairs(arg_161_1.var_.actorSpriteComps10018:ToTable()) do
						if iter_164_1 then
							if arg_161_1.isInRecall_ then
								local var_164_4 = Mathf.Lerp(iter_164_1.color.r, arg_161_1.hightColor1.r, var_164_3)
								local var_164_5 = Mathf.Lerp(iter_164_1.color.g, arg_161_1.hightColor1.g, var_164_3)
								local var_164_6 = Mathf.Lerp(iter_164_1.color.b, arg_161_1.hightColor1.b, var_164_3)

								iter_164_1.color = Color.New(var_164_4, var_164_5, var_164_6)
							else
								local var_164_7 = Mathf.Lerp(iter_164_1.color.r, 1, var_164_3)

								iter_164_1.color = Color.New(var_164_7, var_164_7, var_164_7)
							end
						end
					end
				end
			end

			if arg_161_1.time_ >= var_164_1 + var_164_2 and arg_161_1.time_ < var_164_1 + var_164_2 + arg_164_0 and not isNil(var_164_0) and arg_161_1.var_.actorSpriteComps10018 then
				for iter_164_2, iter_164_3 in pairs(arg_161_1.var_.actorSpriteComps10018:ToTable()) do
					if iter_164_3 then
						if arg_161_1.isInRecall_ then
							iter_164_3.color = arg_161_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_164_3.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_161_1.var_.actorSpriteComps10018 = nil
			end

			local var_164_8 = arg_161_1.actors_["10015"]
			local var_164_9 = 0

			if var_164_9 < arg_161_1.time_ and arg_161_1.time_ <= var_164_9 + arg_164_0 and not isNil(var_164_8) and arg_161_1.var_.actorSpriteComps10015 == nil then
				arg_161_1.var_.actorSpriteComps10015 = var_164_8:GetComponentsInChildren(typeof(Image), true)
			end

			local var_164_10 = 0.034

			if var_164_9 <= arg_161_1.time_ and arg_161_1.time_ < var_164_9 + var_164_10 and not isNil(var_164_8) then
				local var_164_11 = (arg_161_1.time_ - var_164_9) / var_164_10

				if arg_161_1.var_.actorSpriteComps10015 then
					for iter_164_4, iter_164_5 in pairs(arg_161_1.var_.actorSpriteComps10015:ToTable()) do
						if iter_164_5 then
							if arg_161_1.isInRecall_ then
								local var_164_12 = Mathf.Lerp(iter_164_5.color.r, arg_161_1.hightColor2.r, var_164_11)
								local var_164_13 = Mathf.Lerp(iter_164_5.color.g, arg_161_1.hightColor2.g, var_164_11)
								local var_164_14 = Mathf.Lerp(iter_164_5.color.b, arg_161_1.hightColor2.b, var_164_11)

								iter_164_5.color = Color.New(var_164_12, var_164_13, var_164_14)
							else
								local var_164_15 = Mathf.Lerp(iter_164_5.color.r, 0.5, var_164_11)

								iter_164_5.color = Color.New(var_164_15, var_164_15, var_164_15)
							end
						end
					end
				end
			end

			if arg_161_1.time_ >= var_164_9 + var_164_10 and arg_161_1.time_ < var_164_9 + var_164_10 + arg_164_0 and not isNil(var_164_8) and arg_161_1.var_.actorSpriteComps10015 then
				for iter_164_6, iter_164_7 in pairs(arg_161_1.var_.actorSpriteComps10015:ToTable()) do
					if iter_164_7 then
						if arg_161_1.isInRecall_ then
							iter_164_7.color = arg_161_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_164_7.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_161_1.var_.actorSpriteComps10015 = nil
			end

			local var_164_16 = arg_161_1.actors_["10018"].transform
			local var_164_17 = 0

			if var_164_17 < arg_161_1.time_ and arg_161_1.time_ <= var_164_17 + arg_164_0 then
				arg_161_1.var_.moveOldPos10018 = var_164_16.localPosition
				var_164_16.localScale = Vector3.New(1, 1, 1)

				arg_161_1:CheckSpriteTmpPos("10018", 2)

				local var_164_18 = var_164_16.childCount

				for iter_164_8 = 0, var_164_18 - 1 do
					local var_164_19 = var_164_16:GetChild(iter_164_8)

					if var_164_19.name == "split_2" or not string.find(var_164_19.name, "split") then
						var_164_19.gameObject:SetActive(true)
					else
						var_164_19.gameObject:SetActive(false)
					end
				end
			end

			local var_164_20 = 0.001

			if var_164_17 <= arg_161_1.time_ and arg_161_1.time_ < var_164_17 + var_164_20 then
				local var_164_21 = (arg_161_1.time_ - var_164_17) / var_164_20
				local var_164_22 = Vector3.New(-390, -350, -180)

				var_164_16.localPosition = Vector3.Lerp(arg_161_1.var_.moveOldPos10018, var_164_22, var_164_21)
			end

			if arg_161_1.time_ >= var_164_17 + var_164_20 and arg_161_1.time_ < var_164_17 + var_164_20 + arg_164_0 then
				var_164_16.localPosition = Vector3.New(-390, -350, -180)
			end

			local var_164_23 = 0
			local var_164_24 = 0.6

			if var_164_23 < arg_161_1.time_ and arg_161_1.time_ <= var_164_23 + arg_164_0 then
				arg_161_1.talkMaxDuration = 0
				arg_161_1.dialogCg_.alpha = 1

				arg_161_1.dialog_:SetActive(true)
				SetActive(arg_161_1.leftNameGo_, true)

				local var_164_25 = arg_161_1:FormatText(StoryNameCfg[257].name)

				arg_161_1.leftNameTxt_.text = var_164_25

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_161_1.leftNameTxt_.transform)

				arg_161_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_161_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_161_1:RecordName(arg_161_1.leftNameTxt_.text)
				SetActive(arg_161_1.iconTrs_.gameObject, false)
				arg_161_1.callingController_:SetSelectedState("normal")

				local var_164_26 = arg_161_1:GetWordFromCfg(114241040)
				local var_164_27 = arg_161_1:FormatText(var_164_26.content)

				arg_161_1.text_.text = var_164_27

				LuaForUtil.ClearLinePrefixSymbol(arg_161_1.text_)

				local var_164_28 = 24
				local var_164_29 = utf8.len(var_164_27)
				local var_164_30 = var_164_28 <= 0 and var_164_24 or var_164_24 * (var_164_29 / var_164_28)

				if var_164_30 > 0 and var_164_24 < var_164_30 then
					arg_161_1.talkMaxDuration = var_164_30

					if var_164_30 + var_164_23 > arg_161_1.duration_ then
						arg_161_1.duration_ = var_164_30 + var_164_23
					end
				end

				arg_161_1.text_.text = var_164_27
				arg_161_1.typewritter.percent = 0

				arg_161_1.typewritter:SetDirty()
				arg_161_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_114241", "114241040", "story_v_out_114241.awb") ~= 0 then
					local var_164_31 = manager.audio:GetVoiceLength("story_v_out_114241", "114241040", "story_v_out_114241.awb") / 1000

					if var_164_31 + var_164_23 > arg_161_1.duration_ then
						arg_161_1.duration_ = var_164_31 + var_164_23
					end

					if var_164_26.prefab_name ~= "" and arg_161_1.actors_[var_164_26.prefab_name] ~= nil then
						local var_164_32 = LuaForUtil.PlayVoiceWithCriLipsync(arg_161_1.actors_[var_164_26.prefab_name].transform, "story_v_out_114241", "114241040", "story_v_out_114241.awb")

						arg_161_1:RecordAudio("114241040", var_164_32)
						arg_161_1:RecordAudio("114241040", var_164_32)
					else
						arg_161_1:AudioAction("play", "voice", "story_v_out_114241", "114241040", "story_v_out_114241.awb")
					end

					arg_161_1:RecordHistoryTalkVoice("story_v_out_114241", "114241040", "story_v_out_114241.awb")
				end

				arg_161_1:RecordContent(arg_161_1.text_.text)
			end

			local var_164_33 = math.max(var_164_24, arg_161_1.talkMaxDuration)

			if var_164_23 <= arg_161_1.time_ and arg_161_1.time_ < var_164_23 + var_164_33 then
				arg_161_1.typewritter.percent = (arg_161_1.time_ - var_164_23) / var_164_33

				arg_161_1.typewritter:SetDirty()
			end

			if arg_161_1.time_ >= var_164_23 + var_164_33 and arg_161_1.time_ < var_164_23 + var_164_33 + arg_164_0 then
				arg_161_1.typewritter.percent = 1

				arg_161_1.typewritter:SetDirty()
				arg_161_1:ShowNextGo(true)
			end
		end

		arg_161_1.nodeConfigList_ = {
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

		arg_161_1:InitPlayNodeList()
	end,
	Play114241041 = function(arg_165_0, arg_165_1)
		arg_165_1.time_ = 0
		arg_165_1.frameCnt_ = 0
		arg_165_1.state_ = "playing"
		arg_165_1.curTalkId_ = 114241041
		arg_165_1.duration_ = 5.97

		local var_165_0 = {
			ja = 5.9,
			ko = 5.5,
			zh = 5.966,
			en = 5.1
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
				arg_165_0:Play114241042(arg_165_1)
			end
		end

		function arg_165_1.onSingleLineUpdate_(arg_168_0)
			local var_168_0 = arg_165_1.actors_["10015"].transform
			local var_168_1 = 0

			if var_168_1 < arg_165_1.time_ and arg_165_1.time_ <= var_168_1 + arg_168_0 then
				arg_165_1.var_.moveOldPos10015 = var_168_0.localPosition
				var_168_0.localScale = Vector3.New(1, 1, 1)

				arg_165_1:CheckSpriteTmpPos("10015", 4)

				local var_168_2 = var_168_0.childCount

				for iter_168_0 = 0, var_168_2 - 1 do
					local var_168_3 = var_168_0:GetChild(iter_168_0)

					if var_168_3.name == "split_1" or not string.find(var_168_3.name, "split") then
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

				var_168_0.localPosition = Vector3.Lerp(arg_165_1.var_.moveOldPos10015, var_168_6, var_168_5)
			end

			if arg_165_1.time_ >= var_168_1 + var_168_4 and arg_165_1.time_ < var_168_1 + var_168_4 + arg_168_0 then
				var_168_0.localPosition = Vector3.New(390, -350, -180)
			end

			local var_168_7 = arg_165_1.actors_["10018"]
			local var_168_8 = 0

			if var_168_8 < arg_165_1.time_ and arg_165_1.time_ <= var_168_8 + arg_168_0 and not isNil(var_168_7) and arg_165_1.var_.actorSpriteComps10018 == nil then
				arg_165_1.var_.actorSpriteComps10018 = var_168_7:GetComponentsInChildren(typeof(Image), true)
			end

			local var_168_9 = 0.034

			if var_168_8 <= arg_165_1.time_ and arg_165_1.time_ < var_168_8 + var_168_9 and not isNil(var_168_7) then
				local var_168_10 = (arg_165_1.time_ - var_168_8) / var_168_9

				if arg_165_1.var_.actorSpriteComps10018 then
					for iter_168_1, iter_168_2 in pairs(arg_165_1.var_.actorSpriteComps10018:ToTable()) do
						if iter_168_2 then
							if arg_165_1.isInRecall_ then
								local var_168_11 = Mathf.Lerp(iter_168_2.color.r, arg_165_1.hightColor2.r, var_168_10)
								local var_168_12 = Mathf.Lerp(iter_168_2.color.g, arg_165_1.hightColor2.g, var_168_10)
								local var_168_13 = Mathf.Lerp(iter_168_2.color.b, arg_165_1.hightColor2.b, var_168_10)

								iter_168_2.color = Color.New(var_168_11, var_168_12, var_168_13)
							else
								local var_168_14 = Mathf.Lerp(iter_168_2.color.r, 0.5, var_168_10)

								iter_168_2.color = Color.New(var_168_14, var_168_14, var_168_14)
							end
						end
					end
				end
			end

			if arg_165_1.time_ >= var_168_8 + var_168_9 and arg_165_1.time_ < var_168_8 + var_168_9 + arg_168_0 and not isNil(var_168_7) and arg_165_1.var_.actorSpriteComps10018 then
				for iter_168_3, iter_168_4 in pairs(arg_165_1.var_.actorSpriteComps10018:ToTable()) do
					if iter_168_4 then
						if arg_165_1.isInRecall_ then
							iter_168_4.color = arg_165_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_168_4.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_165_1.var_.actorSpriteComps10018 = nil
			end

			local var_168_15 = arg_165_1.actors_["10015"]
			local var_168_16 = 0

			if var_168_16 < arg_165_1.time_ and arg_165_1.time_ <= var_168_16 + arg_168_0 and not isNil(var_168_15) and arg_165_1.var_.actorSpriteComps10015 == nil then
				arg_165_1.var_.actorSpriteComps10015 = var_168_15:GetComponentsInChildren(typeof(Image), true)
			end

			local var_168_17 = 0.034

			if var_168_16 <= arg_165_1.time_ and arg_165_1.time_ < var_168_16 + var_168_17 and not isNil(var_168_15) then
				local var_168_18 = (arg_165_1.time_ - var_168_16) / var_168_17

				if arg_165_1.var_.actorSpriteComps10015 then
					for iter_168_5, iter_168_6 in pairs(arg_165_1.var_.actorSpriteComps10015:ToTable()) do
						if iter_168_6 then
							if arg_165_1.isInRecall_ then
								local var_168_19 = Mathf.Lerp(iter_168_6.color.r, arg_165_1.hightColor1.r, var_168_18)
								local var_168_20 = Mathf.Lerp(iter_168_6.color.g, arg_165_1.hightColor1.g, var_168_18)
								local var_168_21 = Mathf.Lerp(iter_168_6.color.b, arg_165_1.hightColor1.b, var_168_18)

								iter_168_6.color = Color.New(var_168_19, var_168_20, var_168_21)
							else
								local var_168_22 = Mathf.Lerp(iter_168_6.color.r, 1, var_168_18)

								iter_168_6.color = Color.New(var_168_22, var_168_22, var_168_22)
							end
						end
					end
				end
			end

			if arg_165_1.time_ >= var_168_16 + var_168_17 and arg_165_1.time_ < var_168_16 + var_168_17 + arg_168_0 and not isNil(var_168_15) and arg_165_1.var_.actorSpriteComps10015 then
				for iter_168_7, iter_168_8 in pairs(arg_165_1.var_.actorSpriteComps10015:ToTable()) do
					if iter_168_8 then
						if arg_165_1.isInRecall_ then
							iter_168_8.color = arg_165_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_168_8.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_165_1.var_.actorSpriteComps10015 = nil
			end

			local var_168_23 = 0
			local var_168_24 = 0.675

			if var_168_23 < arg_165_1.time_ and arg_165_1.time_ <= var_168_23 + arg_168_0 then
				arg_165_1.talkMaxDuration = 0
				arg_165_1.dialogCg_.alpha = 1

				arg_165_1.dialog_:SetActive(true)
				SetActive(arg_165_1.leftNameGo_, true)

				local var_168_25 = arg_165_1:FormatText(StoryNameCfg[208].name)

				arg_165_1.leftNameTxt_.text = var_168_25

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_165_1.leftNameTxt_.transform)

				arg_165_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_165_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_165_1:RecordName(arg_165_1.leftNameTxt_.text)
				SetActive(arg_165_1.iconTrs_.gameObject, false)
				arg_165_1.callingController_:SetSelectedState("normal")

				local var_168_26 = arg_165_1:GetWordFromCfg(114241041)
				local var_168_27 = arg_165_1:FormatText(var_168_26.content)

				arg_165_1.text_.text = var_168_27

				LuaForUtil.ClearLinePrefixSymbol(arg_165_1.text_)

				local var_168_28 = 27
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

				if manager.audio:GetVoiceLength("story_v_out_114241", "114241041", "story_v_out_114241.awb") ~= 0 then
					local var_168_31 = manager.audio:GetVoiceLength("story_v_out_114241", "114241041", "story_v_out_114241.awb") / 1000

					if var_168_31 + var_168_23 > arg_165_1.duration_ then
						arg_165_1.duration_ = var_168_31 + var_168_23
					end

					if var_168_26.prefab_name ~= "" and arg_165_1.actors_[var_168_26.prefab_name] ~= nil then
						local var_168_32 = LuaForUtil.PlayVoiceWithCriLipsync(arg_165_1.actors_[var_168_26.prefab_name].transform, "story_v_out_114241", "114241041", "story_v_out_114241.awb")

						arg_165_1:RecordAudio("114241041", var_168_32)
						arg_165_1:RecordAudio("114241041", var_168_32)
					else
						arg_165_1:AudioAction("play", "voice", "story_v_out_114241", "114241041", "story_v_out_114241.awb")
					end

					arg_165_1:RecordHistoryTalkVoice("story_v_out_114241", "114241041", "story_v_out_114241.awb")
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
				actorName = "10015",
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
	Play114241042 = function(arg_169_0, arg_169_1)
		arg_169_1.time_ = 0
		arg_169_1.frameCnt_ = 0
		arg_169_1.state_ = "playing"
		arg_169_1.curTalkId_ = 114241042
		arg_169_1.duration_ = 5

		SetActive(arg_169_1.tipsGo_, false)

		function arg_169_1.onSingleLineFinish_()
			arg_169_1.onSingleLineUpdate_ = nil
			arg_169_1.onSingleLineFinish_ = nil
			arg_169_1.state_ = "waiting"
		end

		function arg_169_1.playNext_(arg_171_0)
			if arg_171_0 == 1 then
				arg_169_0:Play114241043(arg_169_1)
			end
		end

		function arg_169_1.onSingleLineUpdate_(arg_172_0)
			local var_172_0 = arg_169_1.actors_["10015"]
			local var_172_1 = 0

			if var_172_1 < arg_169_1.time_ and arg_169_1.time_ <= var_172_1 + arg_172_0 and not isNil(var_172_0) and arg_169_1.var_.actorSpriteComps10015 == nil then
				arg_169_1.var_.actorSpriteComps10015 = var_172_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_172_2 = 0.034

			if var_172_1 <= arg_169_1.time_ and arg_169_1.time_ < var_172_1 + var_172_2 and not isNil(var_172_0) then
				local var_172_3 = (arg_169_1.time_ - var_172_1) / var_172_2

				if arg_169_1.var_.actorSpriteComps10015 then
					for iter_172_0, iter_172_1 in pairs(arg_169_1.var_.actorSpriteComps10015:ToTable()) do
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

			if arg_169_1.time_ >= var_172_1 + var_172_2 and arg_169_1.time_ < var_172_1 + var_172_2 + arg_172_0 and not isNil(var_172_0) and arg_169_1.var_.actorSpriteComps10015 then
				for iter_172_2, iter_172_3 in pairs(arg_169_1.var_.actorSpriteComps10015:ToTable()) do
					if iter_172_3 then
						if arg_169_1.isInRecall_ then
							iter_172_3.color = arg_169_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_172_3.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_169_1.var_.actorSpriteComps10015 = nil
			end

			local var_172_8 = 0
			local var_172_9 = 1.575

			if var_172_8 < arg_169_1.time_ and arg_169_1.time_ <= var_172_8 + arg_172_0 then
				arg_169_1.talkMaxDuration = 0
				arg_169_1.dialogCg_.alpha = 1

				arg_169_1.dialog_:SetActive(true)
				SetActive(arg_169_1.leftNameGo_, false)

				arg_169_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_169_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_169_1:RecordName(arg_169_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_169_1.iconTrs_.gameObject, false)
				arg_169_1.callingController_:SetSelectedState("normal")

				local var_172_10 = arg_169_1:GetWordFromCfg(114241042)
				local var_172_11 = arg_169_1:FormatText(var_172_10.content)

				arg_169_1.text_.text = var_172_11

				LuaForUtil.ClearLinePrefixSymbol(arg_169_1.text_)

				local var_172_12 = 63
				local var_172_13 = utf8.len(var_172_11)
				local var_172_14 = var_172_12 <= 0 and var_172_9 or var_172_9 * (var_172_13 / var_172_12)

				if var_172_14 > 0 and var_172_9 < var_172_14 then
					arg_169_1.talkMaxDuration = var_172_14

					if var_172_14 + var_172_8 > arg_169_1.duration_ then
						arg_169_1.duration_ = var_172_14 + var_172_8
					end
				end

				arg_169_1.text_.text = var_172_11
				arg_169_1.typewritter.percent = 0

				arg_169_1.typewritter:SetDirty()
				arg_169_1:ShowNextGo(false)
				arg_169_1:RecordContent(arg_169_1.text_.text)
			end

			local var_172_15 = math.max(var_172_9, arg_169_1.talkMaxDuration)

			if var_172_8 <= arg_169_1.time_ and arg_169_1.time_ < var_172_8 + var_172_15 then
				arg_169_1.typewritter.percent = (arg_169_1.time_ - var_172_8) / var_172_15

				arg_169_1.typewritter:SetDirty()
			end

			if arg_169_1.time_ >= var_172_8 + var_172_15 and arg_169_1.time_ < var_172_8 + var_172_15 + arg_172_0 then
				arg_169_1.typewritter.percent = 1

				arg_169_1.typewritter:SetDirty()
				arg_169_1:ShowNextGo(true)
			end
		end

		arg_169_1.nodeConfigList_ = {}

		arg_169_1:InitPlayNodeList()
	end,
	Play114241043 = function(arg_173_0, arg_173_1)
		arg_173_1.time_ = 0
		arg_173_1.frameCnt_ = 0
		arg_173_1.state_ = "playing"
		arg_173_1.curTalkId_ = 114241043
		arg_173_1.duration_ = 5

		SetActive(arg_173_1.tipsGo_, false)

		function arg_173_1.onSingleLineFinish_()
			arg_173_1.onSingleLineUpdate_ = nil
			arg_173_1.onSingleLineFinish_ = nil
			arg_173_1.state_ = "waiting"
		end

		function arg_173_1.playNext_(arg_175_0)
			if arg_175_0 == 1 then
				arg_173_0:Play114241044(arg_173_1)
			end
		end

		function arg_173_1.onSingleLineUpdate_(arg_176_0)
			local var_176_0 = 0
			local var_176_1 = 0.95

			if var_176_0 < arg_173_1.time_ and arg_173_1.time_ <= var_176_0 + arg_176_0 then
				arg_173_1.talkMaxDuration = 0
				arg_173_1.dialogCg_.alpha = 1

				arg_173_1.dialog_:SetActive(true)
				SetActive(arg_173_1.leftNameGo_, false)

				arg_173_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_173_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_173_1:RecordName(arg_173_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_173_1.iconTrs_.gameObject, false)
				arg_173_1.callingController_:SetSelectedState("normal")

				local var_176_2 = arg_173_1:GetWordFromCfg(114241043)
				local var_176_3 = arg_173_1:FormatText(var_176_2.content)

				arg_173_1.text_.text = var_176_3

				LuaForUtil.ClearLinePrefixSymbol(arg_173_1.text_)

				local var_176_4 = 38
				local var_176_5 = utf8.len(var_176_3)
				local var_176_6 = var_176_4 <= 0 and var_176_1 or var_176_1 * (var_176_5 / var_176_4)

				if var_176_6 > 0 and var_176_1 < var_176_6 then
					arg_173_1.talkMaxDuration = var_176_6

					if var_176_6 + var_176_0 > arg_173_1.duration_ then
						arg_173_1.duration_ = var_176_6 + var_176_0
					end
				end

				arg_173_1.text_.text = var_176_3
				arg_173_1.typewritter.percent = 0

				arg_173_1.typewritter:SetDirty()
				arg_173_1:ShowNextGo(false)
				arg_173_1:RecordContent(arg_173_1.text_.text)
			end

			local var_176_7 = math.max(var_176_1, arg_173_1.talkMaxDuration)

			if var_176_0 <= arg_173_1.time_ and arg_173_1.time_ < var_176_0 + var_176_7 then
				arg_173_1.typewritter.percent = (arg_173_1.time_ - var_176_0) / var_176_7

				arg_173_1.typewritter:SetDirty()
			end

			if arg_173_1.time_ >= var_176_0 + var_176_7 and arg_173_1.time_ < var_176_0 + var_176_7 + arg_176_0 then
				arg_173_1.typewritter.percent = 1

				arg_173_1.typewritter:SetDirty()
				arg_173_1:ShowNextGo(true)
			end
		end

		arg_173_1.nodeConfigList_ = {}

		arg_173_1:InitPlayNodeList()
	end,
	Play114241044 = function(arg_177_0, arg_177_1)
		arg_177_1.time_ = 0
		arg_177_1.frameCnt_ = 0
		arg_177_1.state_ = "playing"
		arg_177_1.curTalkId_ = 114241044
		arg_177_1.duration_ = 15.4

		local var_177_0 = {
			ja = 10.933,
			ko = 15.4,
			zh = 15.333,
			en = 12.566
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
				arg_177_0:Play114241045(arg_177_1)
			end
		end

		function arg_177_1.onSingleLineUpdate_(arg_180_0)
			local var_180_0 = arg_177_1.actors_["10015"]
			local var_180_1 = 0

			if var_180_1 < arg_177_1.time_ and arg_177_1.time_ <= var_180_1 + arg_180_0 and not isNil(var_180_0) and arg_177_1.var_.actorSpriteComps10015 == nil then
				arg_177_1.var_.actorSpriteComps10015 = var_180_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_180_2 = 0.034

			if var_180_1 <= arg_177_1.time_ and arg_177_1.time_ < var_180_1 + var_180_2 and not isNil(var_180_0) then
				local var_180_3 = (arg_177_1.time_ - var_180_1) / var_180_2

				if arg_177_1.var_.actorSpriteComps10015 then
					for iter_180_0, iter_180_1 in pairs(arg_177_1.var_.actorSpriteComps10015:ToTable()) do
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

			if arg_177_1.time_ >= var_180_1 + var_180_2 and arg_177_1.time_ < var_180_1 + var_180_2 + arg_180_0 and not isNil(var_180_0) and arg_177_1.var_.actorSpriteComps10015 then
				for iter_180_2, iter_180_3 in pairs(arg_177_1.var_.actorSpriteComps10015:ToTable()) do
					if iter_180_3 then
						if arg_177_1.isInRecall_ then
							iter_180_3.color = arg_177_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_180_3.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_177_1.var_.actorSpriteComps10015 = nil
			end

			local var_180_8 = 0
			local var_180_9 = 1.55

			if var_180_8 < arg_177_1.time_ and arg_177_1.time_ <= var_180_8 + arg_180_0 then
				arg_177_1.talkMaxDuration = 0
				arg_177_1.dialogCg_.alpha = 1

				arg_177_1.dialog_:SetActive(true)
				SetActive(arg_177_1.leftNameGo_, true)

				local var_180_10 = arg_177_1:FormatText(StoryNameCfg[208].name)

				arg_177_1.leftNameTxt_.text = var_180_10

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_177_1.leftNameTxt_.transform)

				arg_177_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_177_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_177_1:RecordName(arg_177_1.leftNameTxt_.text)
				SetActive(arg_177_1.iconTrs_.gameObject, false)
				arg_177_1.callingController_:SetSelectedState("normal")

				local var_180_11 = arg_177_1:GetWordFromCfg(114241044)
				local var_180_12 = arg_177_1:FormatText(var_180_11.content)

				arg_177_1.text_.text = var_180_12

				LuaForUtil.ClearLinePrefixSymbol(arg_177_1.text_)

				local var_180_13 = 62
				local var_180_14 = utf8.len(var_180_12)
				local var_180_15 = var_180_13 <= 0 and var_180_9 or var_180_9 * (var_180_14 / var_180_13)

				if var_180_15 > 0 and var_180_9 < var_180_15 then
					arg_177_1.talkMaxDuration = var_180_15

					if var_180_15 + var_180_8 > arg_177_1.duration_ then
						arg_177_1.duration_ = var_180_15 + var_180_8
					end
				end

				arg_177_1.text_.text = var_180_12
				arg_177_1.typewritter.percent = 0

				arg_177_1.typewritter:SetDirty()
				arg_177_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_114241", "114241044", "story_v_out_114241.awb") ~= 0 then
					local var_180_16 = manager.audio:GetVoiceLength("story_v_out_114241", "114241044", "story_v_out_114241.awb") / 1000

					if var_180_16 + var_180_8 > arg_177_1.duration_ then
						arg_177_1.duration_ = var_180_16 + var_180_8
					end

					if var_180_11.prefab_name ~= "" and arg_177_1.actors_[var_180_11.prefab_name] ~= nil then
						local var_180_17 = LuaForUtil.PlayVoiceWithCriLipsync(arg_177_1.actors_[var_180_11.prefab_name].transform, "story_v_out_114241", "114241044", "story_v_out_114241.awb")

						arg_177_1:RecordAudio("114241044", var_180_17)
						arg_177_1:RecordAudio("114241044", var_180_17)
					else
						arg_177_1:AudioAction("play", "voice", "story_v_out_114241", "114241044", "story_v_out_114241.awb")
					end

					arg_177_1:RecordHistoryTalkVoice("story_v_out_114241", "114241044", "story_v_out_114241.awb")
				end

				arg_177_1:RecordContent(arg_177_1.text_.text)
			end

			local var_180_18 = math.max(var_180_9, arg_177_1.talkMaxDuration)

			if var_180_8 <= arg_177_1.time_ and arg_177_1.time_ < var_180_8 + var_180_18 then
				arg_177_1.typewritter.percent = (arg_177_1.time_ - var_180_8) / var_180_18

				arg_177_1.typewritter:SetDirty()
			end

			if arg_177_1.time_ >= var_180_8 + var_180_18 and arg_177_1.time_ < var_180_8 + var_180_18 + arg_180_0 then
				arg_177_1.typewritter.percent = 1

				arg_177_1.typewritter:SetDirty()
				arg_177_1:ShowNextGo(true)
			end
		end

		arg_177_1.nodeConfigList_ = {}

		arg_177_1:InitPlayNodeList()
	end,
	Play114241045 = function(arg_181_0, arg_181_1)
		arg_181_1.time_ = 0
		arg_181_1.frameCnt_ = 0
		arg_181_1.state_ = "playing"
		arg_181_1.curTalkId_ = 114241045
		arg_181_1.duration_ = 5

		SetActive(arg_181_1.tipsGo_, false)

		function arg_181_1.onSingleLineFinish_()
			arg_181_1.onSingleLineUpdate_ = nil
			arg_181_1.onSingleLineFinish_ = nil
			arg_181_1.state_ = "waiting"
		end

		function arg_181_1.playNext_(arg_183_0)
			if arg_183_0 == 1 then
				arg_181_0:Play114241046(arg_181_1)
			end
		end

		function arg_181_1.onSingleLineUpdate_(arg_184_0)
			local var_184_0 = arg_181_1.actors_["10018"]
			local var_184_1 = 0

			if var_184_1 < arg_181_1.time_ and arg_181_1.time_ <= var_184_1 + arg_184_0 then
				local var_184_2 = var_184_0:GetComponentInChildren(typeof(CanvasGroup))

				if var_184_2 then
					arg_181_1.var_.alphaOldValue10018 = var_184_2.alpha
					arg_181_1.var_.characterEffect10018 = var_184_2
				end

				arg_181_1.var_.alphaOldValue10018 = 1
			end

			local var_184_3 = 0.5

			if var_184_1 <= arg_181_1.time_ and arg_181_1.time_ < var_184_1 + var_184_3 then
				local var_184_4 = (arg_181_1.time_ - var_184_1) / var_184_3
				local var_184_5 = Mathf.Lerp(arg_181_1.var_.alphaOldValue10018, 0, var_184_4)

				if arg_181_1.var_.characterEffect10018 then
					arg_181_1.var_.characterEffect10018.alpha = var_184_5
				end
			end

			if arg_181_1.time_ >= var_184_1 + var_184_3 and arg_181_1.time_ < var_184_1 + var_184_3 + arg_184_0 and arg_181_1.var_.characterEffect10018 then
				arg_181_1.var_.characterEffect10018.alpha = 0
			end

			local var_184_6 = arg_181_1.actors_["10015"]
			local var_184_7 = 0

			if var_184_7 < arg_181_1.time_ and arg_181_1.time_ <= var_184_7 + arg_184_0 then
				local var_184_8 = var_184_6:GetComponentInChildren(typeof(CanvasGroup))

				if var_184_8 then
					arg_181_1.var_.alphaOldValue10015 = var_184_8.alpha
					arg_181_1.var_.characterEffect10015 = var_184_8
				end

				arg_181_1.var_.alphaOldValue10015 = 1
			end

			local var_184_9 = 0.5

			if var_184_7 <= arg_181_1.time_ and arg_181_1.time_ < var_184_7 + var_184_9 then
				local var_184_10 = (arg_181_1.time_ - var_184_7) / var_184_9
				local var_184_11 = Mathf.Lerp(arg_181_1.var_.alphaOldValue10015, 0, var_184_10)

				if arg_181_1.var_.characterEffect10015 then
					arg_181_1.var_.characterEffect10015.alpha = var_184_11
				end
			end

			if arg_181_1.time_ >= var_184_7 + var_184_9 and arg_181_1.time_ < var_184_7 + var_184_9 + arg_184_0 and arg_181_1.var_.characterEffect10015 then
				arg_181_1.var_.characterEffect10015.alpha = 0
			end

			local var_184_12 = 0
			local var_184_13 = 0.85

			if var_184_12 < arg_181_1.time_ and arg_181_1.time_ <= var_184_12 + arg_184_0 then
				arg_181_1.talkMaxDuration = 0
				arg_181_1.dialogCg_.alpha = 1

				arg_181_1.dialog_:SetActive(true)
				SetActive(arg_181_1.leftNameGo_, false)

				arg_181_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_181_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_181_1:RecordName(arg_181_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_181_1.iconTrs_.gameObject, false)
				arg_181_1.callingController_:SetSelectedState("normal")

				local var_184_14 = arg_181_1:GetWordFromCfg(114241045)
				local var_184_15 = arg_181_1:FormatText(var_184_14.content)

				arg_181_1.text_.text = var_184_15

				LuaForUtil.ClearLinePrefixSymbol(arg_181_1.text_)

				local var_184_16 = 34
				local var_184_17 = utf8.len(var_184_15)
				local var_184_18 = var_184_16 <= 0 and var_184_13 or var_184_13 * (var_184_17 / var_184_16)

				if var_184_18 > 0 and var_184_13 < var_184_18 then
					arg_181_1.talkMaxDuration = var_184_18

					if var_184_18 + var_184_12 > arg_181_1.duration_ then
						arg_181_1.duration_ = var_184_18 + var_184_12
					end
				end

				arg_181_1.text_.text = var_184_15
				arg_181_1.typewritter.percent = 0

				arg_181_1.typewritter:SetDirty()
				arg_181_1:ShowNextGo(false)
				arg_181_1:RecordContent(arg_181_1.text_.text)
			end

			local var_184_19 = math.max(var_184_13, arg_181_1.talkMaxDuration)

			if var_184_12 <= arg_181_1.time_ and arg_181_1.time_ < var_184_12 + var_184_19 then
				arg_181_1.typewritter.percent = (arg_181_1.time_ - var_184_12) / var_184_19

				arg_181_1.typewritter:SetDirty()
			end

			if arg_181_1.time_ >= var_184_12 + var_184_19 and arg_181_1.time_ < var_184_12 + var_184_19 + arg_184_0 then
				arg_181_1.typewritter.percent = 1

				arg_181_1.typewritter:SetDirty()
				arg_181_1:ShowNextGo(true)
			end
		end

		arg_181_1.nodeConfigList_ = {}

		arg_181_1:InitPlayNodeList()
	end,
	Play114241046 = function(arg_185_0, arg_185_1)
		arg_185_1.time_ = 0
		arg_185_1.frameCnt_ = 0
		arg_185_1.state_ = "playing"
		arg_185_1.curTalkId_ = 114241046
		arg_185_1.duration_ = 5

		SetActive(arg_185_1.tipsGo_, false)

		function arg_185_1.onSingleLineFinish_()
			arg_185_1.onSingleLineUpdate_ = nil
			arg_185_1.onSingleLineFinish_ = nil
			arg_185_1.state_ = "waiting"
		end

		function arg_185_1.playNext_(arg_187_0)
			if arg_187_0 == 1 then
				arg_185_0:Play114241047(arg_185_1)
			end
		end

		function arg_185_1.onSingleLineUpdate_(arg_188_0)
			local var_188_0 = 0
			local var_188_1 = 1.525

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

				local var_188_2 = arg_185_1:GetWordFromCfg(114241046)
				local var_188_3 = arg_185_1:FormatText(var_188_2.content)

				arg_185_1.text_.text = var_188_3

				LuaForUtil.ClearLinePrefixSymbol(arg_185_1.text_)

				local var_188_4 = 61
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
	Play114241047 = function(arg_189_0, arg_189_1)
		arg_189_1.time_ = 0
		arg_189_1.frameCnt_ = 0
		arg_189_1.state_ = "playing"
		arg_189_1.curTalkId_ = 114241047
		arg_189_1.duration_ = 5

		SetActive(arg_189_1.tipsGo_, false)

		function arg_189_1.onSingleLineFinish_()
			arg_189_1.onSingleLineUpdate_ = nil
			arg_189_1.onSingleLineFinish_ = nil
			arg_189_1.state_ = "waiting"
		end

		function arg_189_1.playNext_(arg_191_0)
			if arg_191_0 == 1 then
				arg_189_0:Play114241048(arg_189_1)
			end
		end

		function arg_189_1.onSingleLineUpdate_(arg_192_0)
			local var_192_0 = 0
			local var_192_1 = 0.575

			if var_192_0 < arg_189_1.time_ and arg_189_1.time_ <= var_192_0 + arg_192_0 then
				arg_189_1.talkMaxDuration = 0
				arg_189_1.dialogCg_.alpha = 1

				arg_189_1.dialog_:SetActive(true)
				SetActive(arg_189_1.leftNameGo_, false)

				arg_189_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_189_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_189_1:RecordName(arg_189_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_189_1.iconTrs_.gameObject, false)
				arg_189_1.callingController_:SetSelectedState("normal")

				local var_192_2 = arg_189_1:GetWordFromCfg(114241047)
				local var_192_3 = arg_189_1:FormatText(var_192_2.content)

				arg_189_1.text_.text = var_192_3

				LuaForUtil.ClearLinePrefixSymbol(arg_189_1.text_)

				local var_192_4 = 23
				local var_192_5 = utf8.len(var_192_3)
				local var_192_6 = var_192_4 <= 0 and var_192_1 or var_192_1 * (var_192_5 / var_192_4)

				if var_192_6 > 0 and var_192_1 < var_192_6 then
					arg_189_1.talkMaxDuration = var_192_6

					if var_192_6 + var_192_0 > arg_189_1.duration_ then
						arg_189_1.duration_ = var_192_6 + var_192_0
					end
				end

				arg_189_1.text_.text = var_192_3
				arg_189_1.typewritter.percent = 0

				arg_189_1.typewritter:SetDirty()
				arg_189_1:ShowNextGo(false)
				arg_189_1:RecordContent(arg_189_1.text_.text)
			end

			local var_192_7 = math.max(var_192_1, arg_189_1.talkMaxDuration)

			if var_192_0 <= arg_189_1.time_ and arg_189_1.time_ < var_192_0 + var_192_7 then
				arg_189_1.typewritter.percent = (arg_189_1.time_ - var_192_0) / var_192_7

				arg_189_1.typewritter:SetDirty()
			end

			if arg_189_1.time_ >= var_192_0 + var_192_7 and arg_189_1.time_ < var_192_0 + var_192_7 + arg_192_0 then
				arg_189_1.typewritter.percent = 1

				arg_189_1.typewritter:SetDirty()
				arg_189_1:ShowNextGo(true)
			end
		end

		arg_189_1.nodeConfigList_ = {}

		arg_189_1:InitPlayNodeList()
	end,
	Play114241048 = function(arg_193_0, arg_193_1)
		arg_193_1.time_ = 0
		arg_193_1.frameCnt_ = 0
		arg_193_1.state_ = "playing"
		arg_193_1.curTalkId_ = 114241048
		arg_193_1.duration_ = 5

		SetActive(arg_193_1.tipsGo_, false)

		function arg_193_1.onSingleLineFinish_()
			arg_193_1.onSingleLineUpdate_ = nil
			arg_193_1.onSingleLineFinish_ = nil
			arg_193_1.state_ = "waiting"
		end

		function arg_193_1.playNext_(arg_195_0)
			if arg_195_0 == 1 then
				arg_193_0:Play114241049(arg_193_1)
			end
		end

		function arg_193_1.onSingleLineUpdate_(arg_196_0)
			local var_196_0 = 0
			local var_196_1 = 0.7

			if var_196_0 < arg_193_1.time_ and arg_193_1.time_ <= var_196_0 + arg_196_0 then
				arg_193_1.talkMaxDuration = 0
				arg_193_1.dialogCg_.alpha = 1

				arg_193_1.dialog_:SetActive(true)
				SetActive(arg_193_1.leftNameGo_, false)

				arg_193_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_193_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_193_1:RecordName(arg_193_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_193_1.iconTrs_.gameObject, false)
				arg_193_1.callingController_:SetSelectedState("normal")

				local var_196_2 = arg_193_1:GetWordFromCfg(114241048)
				local var_196_3 = arg_193_1:FormatText(var_196_2.content)

				arg_193_1.text_.text = var_196_3

				LuaForUtil.ClearLinePrefixSymbol(arg_193_1.text_)

				local var_196_4 = 28
				local var_196_5 = utf8.len(var_196_3)
				local var_196_6 = var_196_4 <= 0 and var_196_1 or var_196_1 * (var_196_5 / var_196_4)

				if var_196_6 > 0 and var_196_1 < var_196_6 then
					arg_193_1.talkMaxDuration = var_196_6

					if var_196_6 + var_196_0 > arg_193_1.duration_ then
						arg_193_1.duration_ = var_196_6 + var_196_0
					end
				end

				arg_193_1.text_.text = var_196_3
				arg_193_1.typewritter.percent = 0

				arg_193_1.typewritter:SetDirty()
				arg_193_1:ShowNextGo(false)
				arg_193_1:RecordContent(arg_193_1.text_.text)
			end

			local var_196_7 = math.max(var_196_1, arg_193_1.talkMaxDuration)

			if var_196_0 <= arg_193_1.time_ and arg_193_1.time_ < var_196_0 + var_196_7 then
				arg_193_1.typewritter.percent = (arg_193_1.time_ - var_196_0) / var_196_7

				arg_193_1.typewritter:SetDirty()
			end

			if arg_193_1.time_ >= var_196_0 + var_196_7 and arg_193_1.time_ < var_196_0 + var_196_7 + arg_196_0 then
				arg_193_1.typewritter.percent = 1

				arg_193_1.typewritter:SetDirty()
				arg_193_1:ShowNextGo(true)
			end
		end

		arg_193_1.nodeConfigList_ = {}

		arg_193_1:InitPlayNodeList()
	end,
	Play114241049 = function(arg_197_0, arg_197_1)
		arg_197_1.time_ = 0
		arg_197_1.frameCnt_ = 0
		arg_197_1.state_ = "playing"
		arg_197_1.curTalkId_ = 114241049
		arg_197_1.duration_ = 5

		SetActive(arg_197_1.tipsGo_, false)

		function arg_197_1.onSingleLineFinish_()
			arg_197_1.onSingleLineUpdate_ = nil
			arg_197_1.onSingleLineFinish_ = nil
			arg_197_1.state_ = "waiting"
		end

		function arg_197_1.playNext_(arg_199_0)
			if arg_199_0 == 1 then
				arg_197_0:Play114241050(arg_197_1)
			end
		end

		function arg_197_1.onSingleLineUpdate_(arg_200_0)
			local var_200_0 = 0
			local var_200_1 = 1.1

			if var_200_0 < arg_197_1.time_ and arg_197_1.time_ <= var_200_0 + arg_200_0 then
				arg_197_1.talkMaxDuration = 0
				arg_197_1.dialogCg_.alpha = 1

				arg_197_1.dialog_:SetActive(true)
				SetActive(arg_197_1.leftNameGo_, false)

				arg_197_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_197_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_197_1:RecordName(arg_197_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_197_1.iconTrs_.gameObject, false)
				arg_197_1.callingController_:SetSelectedState("normal")

				local var_200_2 = arg_197_1:GetWordFromCfg(114241049)
				local var_200_3 = arg_197_1:FormatText(var_200_2.content)

				arg_197_1.text_.text = var_200_3

				LuaForUtil.ClearLinePrefixSymbol(arg_197_1.text_)

				local var_200_4 = 44
				local var_200_5 = utf8.len(var_200_3)
				local var_200_6 = var_200_4 <= 0 and var_200_1 or var_200_1 * (var_200_5 / var_200_4)

				if var_200_6 > 0 and var_200_1 < var_200_6 then
					arg_197_1.talkMaxDuration = var_200_6

					if var_200_6 + var_200_0 > arg_197_1.duration_ then
						arg_197_1.duration_ = var_200_6 + var_200_0
					end
				end

				arg_197_1.text_.text = var_200_3
				arg_197_1.typewritter.percent = 0

				arg_197_1.typewritter:SetDirty()
				arg_197_1:ShowNextGo(false)
				arg_197_1:RecordContent(arg_197_1.text_.text)
			end

			local var_200_7 = math.max(var_200_1, arg_197_1.talkMaxDuration)

			if var_200_0 <= arg_197_1.time_ and arg_197_1.time_ < var_200_0 + var_200_7 then
				arg_197_1.typewritter.percent = (arg_197_1.time_ - var_200_0) / var_200_7

				arg_197_1.typewritter:SetDirty()
			end

			if arg_197_1.time_ >= var_200_0 + var_200_7 and arg_197_1.time_ < var_200_0 + var_200_7 + arg_200_0 then
				arg_197_1.typewritter.percent = 1

				arg_197_1.typewritter:SetDirty()
				arg_197_1:ShowNextGo(true)
			end
		end

		arg_197_1.nodeConfigList_ = {}

		arg_197_1:InitPlayNodeList()
	end,
	Play114241050 = function(arg_201_0, arg_201_1)
		arg_201_1.time_ = 0
		arg_201_1.frameCnt_ = 0
		arg_201_1.state_ = "playing"
		arg_201_1.curTalkId_ = 114241050
		arg_201_1.duration_ = 2.7

		local var_201_0 = {
			ja = 2.7,
			ko = 1.533,
			zh = 1.833,
			en = 1.666
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
				arg_201_0:Play114241051(arg_201_1)
			end
		end

		function arg_201_1.onSingleLineUpdate_(arg_204_0)
			local var_204_0 = arg_201_1.actors_["10015"].transform
			local var_204_1 = 0

			if var_204_1 < arg_201_1.time_ and arg_201_1.time_ <= var_204_1 + arg_204_0 then
				arg_201_1.var_.moveOldPos10015 = var_204_0.localPosition
				var_204_0.localScale = Vector3.New(1, 1, 1)

				arg_201_1:CheckSpriteTmpPos("10015", 3)

				local var_204_2 = var_204_0.childCount

				for iter_204_0 = 0, var_204_2 - 1 do
					local var_204_3 = var_204_0:GetChild(iter_204_0)

					if var_204_3.name == "split_5" or not string.find(var_204_3.name, "split") then
						var_204_3.gameObject:SetActive(true)
					else
						var_204_3.gameObject:SetActive(false)
					end
				end
			end

			local var_204_4 = 0.001

			if var_204_1 <= arg_201_1.time_ and arg_201_1.time_ < var_204_1 + var_204_4 then
				local var_204_5 = (arg_201_1.time_ - var_204_1) / var_204_4
				local var_204_6 = Vector3.New(0, -350, -180)

				var_204_0.localPosition = Vector3.Lerp(arg_201_1.var_.moveOldPos10015, var_204_6, var_204_5)
			end

			if arg_201_1.time_ >= var_204_1 + var_204_4 and arg_201_1.time_ < var_204_1 + var_204_4 + arg_204_0 then
				var_204_0.localPosition = Vector3.New(0, -350, -180)
			end

			local var_204_7 = arg_201_1.actors_["10015"]
			local var_204_8 = 0

			if var_204_8 < arg_201_1.time_ and arg_201_1.time_ <= var_204_8 + arg_204_0 and not isNil(var_204_7) and arg_201_1.var_.actorSpriteComps10015 == nil then
				arg_201_1.var_.actorSpriteComps10015 = var_204_7:GetComponentsInChildren(typeof(Image), true)
			end

			local var_204_9 = 0.034

			if var_204_8 <= arg_201_1.time_ and arg_201_1.time_ < var_204_8 + var_204_9 and not isNil(var_204_7) then
				local var_204_10 = (arg_201_1.time_ - var_204_8) / var_204_9

				if arg_201_1.var_.actorSpriteComps10015 then
					for iter_204_1, iter_204_2 in pairs(arg_201_1.var_.actorSpriteComps10015:ToTable()) do
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

			if arg_201_1.time_ >= var_204_8 + var_204_9 and arg_201_1.time_ < var_204_8 + var_204_9 + arg_204_0 and not isNil(var_204_7) and arg_201_1.var_.actorSpriteComps10015 then
				for iter_204_3, iter_204_4 in pairs(arg_201_1.var_.actorSpriteComps10015:ToTable()) do
					if iter_204_4 then
						if arg_201_1.isInRecall_ then
							iter_204_4.color = arg_201_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_204_4.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_201_1.var_.actorSpriteComps10015 = nil
			end

			local var_204_15 = arg_201_1.actors_["10015"]
			local var_204_16 = 0

			if var_204_16 < arg_201_1.time_ and arg_201_1.time_ <= var_204_16 + arg_204_0 then
				local var_204_17 = var_204_15:GetComponentInChildren(typeof(CanvasGroup))

				if var_204_17 then
					arg_201_1.var_.alphaOldValue10015 = var_204_17.alpha
					arg_201_1.var_.characterEffect10015 = var_204_17
				end

				arg_201_1.var_.alphaOldValue10015 = 0
			end

			local var_204_18 = 0.5

			if var_204_16 <= arg_201_1.time_ and arg_201_1.time_ < var_204_16 + var_204_18 then
				local var_204_19 = (arg_201_1.time_ - var_204_16) / var_204_18
				local var_204_20 = Mathf.Lerp(arg_201_1.var_.alphaOldValue10015, 1, var_204_19)

				if arg_201_1.var_.characterEffect10015 then
					arg_201_1.var_.characterEffect10015.alpha = var_204_20
				end
			end

			if arg_201_1.time_ >= var_204_16 + var_204_18 and arg_201_1.time_ < var_204_16 + var_204_18 + arg_204_0 and arg_201_1.var_.characterEffect10015 then
				arg_201_1.var_.characterEffect10015.alpha = 1
			end

			local var_204_21 = 0
			local var_204_22 = 0.125

			if var_204_21 < arg_201_1.time_ and arg_201_1.time_ <= var_204_21 + arg_204_0 then
				arg_201_1.talkMaxDuration = 0
				arg_201_1.dialogCg_.alpha = 1

				arg_201_1.dialog_:SetActive(true)
				SetActive(arg_201_1.leftNameGo_, true)

				local var_204_23 = arg_201_1:FormatText(StoryNameCfg[208].name)

				arg_201_1.leftNameTxt_.text = var_204_23

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_201_1.leftNameTxt_.transform)

				arg_201_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_201_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_201_1:RecordName(arg_201_1.leftNameTxt_.text)
				SetActive(arg_201_1.iconTrs_.gameObject, false)
				arg_201_1.callingController_:SetSelectedState("normal")

				local var_204_24 = arg_201_1:GetWordFromCfg(114241050)
				local var_204_25 = arg_201_1:FormatText(var_204_24.content)

				arg_201_1.text_.text = var_204_25

				LuaForUtil.ClearLinePrefixSymbol(arg_201_1.text_)

				local var_204_26 = 5
				local var_204_27 = utf8.len(var_204_25)
				local var_204_28 = var_204_26 <= 0 and var_204_22 or var_204_22 * (var_204_27 / var_204_26)

				if var_204_28 > 0 and var_204_22 < var_204_28 then
					arg_201_1.talkMaxDuration = var_204_28

					if var_204_28 + var_204_21 > arg_201_1.duration_ then
						arg_201_1.duration_ = var_204_28 + var_204_21
					end
				end

				arg_201_1.text_.text = var_204_25
				arg_201_1.typewritter.percent = 0

				arg_201_1.typewritter:SetDirty()
				arg_201_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_114241", "114241050", "story_v_out_114241.awb") ~= 0 then
					local var_204_29 = manager.audio:GetVoiceLength("story_v_out_114241", "114241050", "story_v_out_114241.awb") / 1000

					if var_204_29 + var_204_21 > arg_201_1.duration_ then
						arg_201_1.duration_ = var_204_29 + var_204_21
					end

					if var_204_24.prefab_name ~= "" and arg_201_1.actors_[var_204_24.prefab_name] ~= nil then
						local var_204_30 = LuaForUtil.PlayVoiceWithCriLipsync(arg_201_1.actors_[var_204_24.prefab_name].transform, "story_v_out_114241", "114241050", "story_v_out_114241.awb")

						arg_201_1:RecordAudio("114241050", var_204_30)
						arg_201_1:RecordAudio("114241050", var_204_30)
					else
						arg_201_1:AudioAction("play", "voice", "story_v_out_114241", "114241050", "story_v_out_114241.awb")
					end

					arg_201_1:RecordHistoryTalkVoice("story_v_out_114241", "114241050", "story_v_out_114241.awb")
				end

				arg_201_1:RecordContent(arg_201_1.text_.text)
			end

			local var_204_31 = math.max(var_204_22, arg_201_1.talkMaxDuration)

			if var_204_21 <= arg_201_1.time_ and arg_201_1.time_ < var_204_21 + var_204_31 then
				arg_201_1.typewritter.percent = (arg_201_1.time_ - var_204_21) / var_204_31

				arg_201_1.typewritter:SetDirty()
			end

			if arg_201_1.time_ >= var_204_21 + var_204_31 and arg_201_1.time_ < var_204_21 + var_204_31 + arg_204_0 then
				arg_201_1.typewritter.percent = 1

				arg_201_1.typewritter:SetDirty()
				arg_201_1:ShowNextGo(true)
			end
		end

		arg_201_1.nodeConfigList_ = {
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

		arg_201_1:InitPlayNodeList()
	end,
	Play114241051 = function(arg_205_0, arg_205_1)
		arg_205_1.time_ = 0
		arg_205_1.frameCnt_ = 0
		arg_205_1.state_ = "playing"
		arg_205_1.curTalkId_ = 114241051
		arg_205_1.duration_ = 5

		SetActive(arg_205_1.tipsGo_, false)

		function arg_205_1.onSingleLineFinish_()
			arg_205_1.onSingleLineUpdate_ = nil
			arg_205_1.onSingleLineFinish_ = nil
			arg_205_1.state_ = "waiting"
		end

		function arg_205_1.playNext_(arg_207_0)
			if arg_207_0 == 1 then
				arg_205_0:Play114241052(arg_205_1)
			end
		end

		function arg_205_1.onSingleLineUpdate_(arg_208_0)
			local var_208_0 = arg_205_1.actors_["10015"]
			local var_208_1 = 0

			if var_208_1 < arg_205_1.time_ and arg_205_1.time_ <= var_208_1 + arg_208_0 and not isNil(var_208_0) and arg_205_1.var_.actorSpriteComps10015 == nil then
				arg_205_1.var_.actorSpriteComps10015 = var_208_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_208_2 = 0.034

			if var_208_1 <= arg_205_1.time_ and arg_205_1.time_ < var_208_1 + var_208_2 and not isNil(var_208_0) then
				local var_208_3 = (arg_205_1.time_ - var_208_1) / var_208_2

				if arg_205_1.var_.actorSpriteComps10015 then
					for iter_208_0, iter_208_1 in pairs(arg_205_1.var_.actorSpriteComps10015:ToTable()) do
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

			if arg_205_1.time_ >= var_208_1 + var_208_2 and arg_205_1.time_ < var_208_1 + var_208_2 + arg_208_0 and not isNil(var_208_0) and arg_205_1.var_.actorSpriteComps10015 then
				for iter_208_2, iter_208_3 in pairs(arg_205_1.var_.actorSpriteComps10015:ToTable()) do
					if iter_208_3 then
						if arg_205_1.isInRecall_ then
							iter_208_3.color = arg_205_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_208_3.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_205_1.var_.actorSpriteComps10015 = nil
			end

			local var_208_8 = 0
			local var_208_9 = 1.6

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

				local var_208_10 = arg_205_1:GetWordFromCfg(114241051)
				local var_208_11 = arg_205_1:FormatText(var_208_10.content)

				arg_205_1.text_.text = var_208_11

				LuaForUtil.ClearLinePrefixSymbol(arg_205_1.text_)

				local var_208_12 = 64
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
	Play114241052 = function(arg_209_0, arg_209_1)
		arg_209_1.time_ = 0
		arg_209_1.frameCnt_ = 0
		arg_209_1.state_ = "playing"
		arg_209_1.curTalkId_ = 114241052
		arg_209_1.duration_ = 5

		SetActive(arg_209_1.tipsGo_, false)

		function arg_209_1.onSingleLineFinish_()
			arg_209_1.onSingleLineUpdate_ = nil
			arg_209_1.onSingleLineFinish_ = nil
			arg_209_1.state_ = "waiting"
		end

		function arg_209_1.playNext_(arg_211_0)
			if arg_211_0 == 1 then
				arg_209_0:Play114241053(arg_209_1)
			end
		end

		function arg_209_1.onSingleLineUpdate_(arg_212_0)
			local var_212_0 = arg_209_1.actors_["10015"]
			local var_212_1 = 0

			if var_212_1 < arg_209_1.time_ and arg_209_1.time_ <= var_212_1 + arg_212_0 then
				local var_212_2 = var_212_0:GetComponentInChildren(typeof(CanvasGroup))

				if var_212_2 then
					arg_209_1.var_.alphaOldValue10015 = var_212_2.alpha
					arg_209_1.var_.characterEffect10015 = var_212_2
				end

				arg_209_1.var_.alphaOldValue10015 = 1
			end

			local var_212_3 = 0.5

			if var_212_1 <= arg_209_1.time_ and arg_209_1.time_ < var_212_1 + var_212_3 then
				local var_212_4 = (arg_209_1.time_ - var_212_1) / var_212_3
				local var_212_5 = Mathf.Lerp(arg_209_1.var_.alphaOldValue10015, 0, var_212_4)

				if arg_209_1.var_.characterEffect10015 then
					arg_209_1.var_.characterEffect10015.alpha = var_212_5
				end
			end

			if arg_209_1.time_ >= var_212_1 + var_212_3 and arg_209_1.time_ < var_212_1 + var_212_3 + arg_212_0 and arg_209_1.var_.characterEffect10015 then
				arg_209_1.var_.characterEffect10015.alpha = 0
			end

			local var_212_6 = 0
			local var_212_7 = 0.85

			if var_212_6 < arg_209_1.time_ and arg_209_1.time_ <= var_212_6 + arg_212_0 then
				arg_209_1.talkMaxDuration = 0
				arg_209_1.dialogCg_.alpha = 1

				arg_209_1.dialog_:SetActive(true)
				SetActive(arg_209_1.leftNameGo_, false)

				arg_209_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_209_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_209_1:RecordName(arg_209_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_209_1.iconTrs_.gameObject, false)
				arg_209_1.callingController_:SetSelectedState("normal")

				local var_212_8 = arg_209_1:GetWordFromCfg(114241052)
				local var_212_9 = arg_209_1:FormatText(var_212_8.content)

				arg_209_1.text_.text = var_212_9

				LuaForUtil.ClearLinePrefixSymbol(arg_209_1.text_)

				local var_212_10 = 34
				local var_212_11 = utf8.len(var_212_9)
				local var_212_12 = var_212_10 <= 0 and var_212_7 or var_212_7 * (var_212_11 / var_212_10)

				if var_212_12 > 0 and var_212_7 < var_212_12 then
					arg_209_1.talkMaxDuration = var_212_12

					if var_212_12 + var_212_6 > arg_209_1.duration_ then
						arg_209_1.duration_ = var_212_12 + var_212_6
					end
				end

				arg_209_1.text_.text = var_212_9
				arg_209_1.typewritter.percent = 0

				arg_209_1.typewritter:SetDirty()
				arg_209_1:ShowNextGo(false)
				arg_209_1:RecordContent(arg_209_1.text_.text)
			end

			local var_212_13 = math.max(var_212_7, arg_209_1.talkMaxDuration)

			if var_212_6 <= arg_209_1.time_ and arg_209_1.time_ < var_212_6 + var_212_13 then
				arg_209_1.typewritter.percent = (arg_209_1.time_ - var_212_6) / var_212_13

				arg_209_1.typewritter:SetDirty()
			end

			if arg_209_1.time_ >= var_212_6 + var_212_13 and arg_209_1.time_ < var_212_6 + var_212_13 + arg_212_0 then
				arg_209_1.typewritter.percent = 1

				arg_209_1.typewritter:SetDirty()
				arg_209_1:ShowNextGo(true)
			end
		end

		arg_209_1.nodeConfigList_ = {}

		arg_209_1:InitPlayNodeList()
	end,
	Play114241053 = function(arg_213_0, arg_213_1)
		arg_213_1.time_ = 0
		arg_213_1.frameCnt_ = 0
		arg_213_1.state_ = "playing"
		arg_213_1.curTalkId_ = 114241053
		arg_213_1.duration_ = 4

		local var_213_0 = {
			ja = 3.666,
			ko = 2.633,
			zh = 4,
			en = 3.766
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
				arg_213_0:Play114241054(arg_213_1)
			end
		end

		function arg_213_1.onSingleLineUpdate_(arg_216_0)
			local var_216_0 = 0
			local var_216_1 = 0.375

			if var_216_0 < arg_213_1.time_ and arg_213_1.time_ <= var_216_0 + arg_216_0 then
				arg_213_1.talkMaxDuration = 0
				arg_213_1.dialogCg_.alpha = 1

				arg_213_1.dialog_:SetActive(true)
				SetActive(arg_213_1.leftNameGo_, true)

				local var_216_2 = arg_213_1:FormatText(StoryNameCfg[257].name)

				arg_213_1.leftNameTxt_.text = var_216_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_213_1.leftNameTxt_.transform)

				arg_213_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_213_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_213_1:RecordName(arg_213_1.leftNameTxt_.text)
				SetActive(arg_213_1.iconTrs_.gameObject, true)
				arg_213_1.iconController_:SetSelectedState("hero")

				arg_213_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_10018")

				arg_213_1.callingController_:SetSelectedState("normal")

				arg_213_1.keyicon_.color = Color.New(1, 1, 1)
				arg_213_1.icon_.color = Color.New(1, 1, 1)

				local var_216_3 = arg_213_1:GetWordFromCfg(114241053)
				local var_216_4 = arg_213_1:FormatText(var_216_3.content)

				arg_213_1.text_.text = var_216_4

				LuaForUtil.ClearLinePrefixSymbol(arg_213_1.text_)

				local var_216_5 = 15
				local var_216_6 = utf8.len(var_216_4)
				local var_216_7 = var_216_5 <= 0 and var_216_1 or var_216_1 * (var_216_6 / var_216_5)

				if var_216_7 > 0 and var_216_1 < var_216_7 then
					arg_213_1.talkMaxDuration = var_216_7

					if var_216_7 + var_216_0 > arg_213_1.duration_ then
						arg_213_1.duration_ = var_216_7 + var_216_0
					end
				end

				arg_213_1.text_.text = var_216_4
				arg_213_1.typewritter.percent = 0

				arg_213_1.typewritter:SetDirty()
				arg_213_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_114241", "114241053", "story_v_out_114241.awb") ~= 0 then
					local var_216_8 = manager.audio:GetVoiceLength("story_v_out_114241", "114241053", "story_v_out_114241.awb") / 1000

					if var_216_8 + var_216_0 > arg_213_1.duration_ then
						arg_213_1.duration_ = var_216_8 + var_216_0
					end

					if var_216_3.prefab_name ~= "" and arg_213_1.actors_[var_216_3.prefab_name] ~= nil then
						local var_216_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_213_1.actors_[var_216_3.prefab_name].transform, "story_v_out_114241", "114241053", "story_v_out_114241.awb")

						arg_213_1:RecordAudio("114241053", var_216_9)
						arg_213_1:RecordAudio("114241053", var_216_9)
					else
						arg_213_1:AudioAction("play", "voice", "story_v_out_114241", "114241053", "story_v_out_114241.awb")
					end

					arg_213_1:RecordHistoryTalkVoice("story_v_out_114241", "114241053", "story_v_out_114241.awb")
				end

				arg_213_1:RecordContent(arg_213_1.text_.text)
			end

			local var_216_10 = math.max(var_216_1, arg_213_1.talkMaxDuration)

			if var_216_0 <= arg_213_1.time_ and arg_213_1.time_ < var_216_0 + var_216_10 then
				arg_213_1.typewritter.percent = (arg_213_1.time_ - var_216_0) / var_216_10

				arg_213_1.typewritter:SetDirty()
			end

			if arg_213_1.time_ >= var_216_0 + var_216_10 and arg_213_1.time_ < var_216_0 + var_216_10 + arg_216_0 then
				arg_213_1.typewritter.percent = 1

				arg_213_1.typewritter:SetDirty()
				arg_213_1:ShowNextGo(true)
			end
		end

		arg_213_1.nodeConfigList_ = {}

		arg_213_1:InitPlayNodeList()
	end,
	Play114241054 = function(arg_217_0, arg_217_1)
		arg_217_1.time_ = 0
		arg_217_1.frameCnt_ = 0
		arg_217_1.state_ = "playing"
		arg_217_1.curTalkId_ = 114241054
		arg_217_1.duration_ = 5

		SetActive(arg_217_1.tipsGo_, false)

		function arg_217_1.onSingleLineFinish_()
			arg_217_1.onSingleLineUpdate_ = nil
			arg_217_1.onSingleLineFinish_ = nil
			arg_217_1.state_ = "waiting"
		end

		function arg_217_1.playNext_(arg_219_0)
			if arg_219_0 == 1 then
				arg_217_0:Play114241055(arg_217_1)
			end
		end

		function arg_217_1.onSingleLineUpdate_(arg_220_0)
			local var_220_0 = 0
			local var_220_1 = 0.475

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

				local var_220_2 = arg_217_1:GetWordFromCfg(114241054)
				local var_220_3 = arg_217_1:FormatText(var_220_2.content)

				arg_217_1.text_.text = var_220_3

				LuaForUtil.ClearLinePrefixSymbol(arg_217_1.text_)

				local var_220_4 = 19
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
	Play114241055 = function(arg_221_0, arg_221_1)
		arg_221_1.time_ = 0
		arg_221_1.frameCnt_ = 0
		arg_221_1.state_ = "playing"
		arg_221_1.curTalkId_ = 114241055
		arg_221_1.duration_ = 10.07

		local var_221_0 = {
			ja = 3.5,
			ko = 6.5,
			zh = 5.766,
			en = 10.066
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
				arg_221_0:Play114241056(arg_221_1)
			end
		end

		function arg_221_1.onSingleLineUpdate_(arg_224_0)
			local var_224_0 = arg_221_1.actors_["10015"].transform
			local var_224_1 = 0

			if var_224_1 < arg_221_1.time_ and arg_221_1.time_ <= var_224_1 + arg_224_0 then
				arg_221_1.var_.moveOldPos10015 = var_224_0.localPosition
				var_224_0.localScale = Vector3.New(1, 1, 1)

				arg_221_1:CheckSpriteTmpPos("10015", 4)

				local var_224_2 = var_224_0.childCount

				for iter_224_0 = 0, var_224_2 - 1 do
					local var_224_3 = var_224_0:GetChild(iter_224_0)

					if var_224_3.name == "split_5" or not string.find(var_224_3.name, "split") then
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

				var_224_0.localPosition = Vector3.Lerp(arg_221_1.var_.moveOldPos10015, var_224_6, var_224_5)
			end

			if arg_221_1.time_ >= var_224_1 + var_224_4 and arg_221_1.time_ < var_224_1 + var_224_4 + arg_224_0 then
				var_224_0.localPosition = Vector3.New(390, -350, -180)
			end

			local var_224_7 = arg_221_1.actors_["10015"]
			local var_224_8 = 0

			if var_224_8 < arg_221_1.time_ and arg_221_1.time_ <= var_224_8 + arg_224_0 and not isNil(var_224_7) and arg_221_1.var_.actorSpriteComps10015 == nil then
				arg_221_1.var_.actorSpriteComps10015 = var_224_7:GetComponentsInChildren(typeof(Image), true)
			end

			local var_224_9 = 0.034

			if var_224_8 <= arg_221_1.time_ and arg_221_1.time_ < var_224_8 + var_224_9 and not isNil(var_224_7) then
				local var_224_10 = (arg_221_1.time_ - var_224_8) / var_224_9

				if arg_221_1.var_.actorSpriteComps10015 then
					for iter_224_1, iter_224_2 in pairs(arg_221_1.var_.actorSpriteComps10015:ToTable()) do
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

			if arg_221_1.time_ >= var_224_8 + var_224_9 and arg_221_1.time_ < var_224_8 + var_224_9 + arg_224_0 and not isNil(var_224_7) and arg_221_1.var_.actorSpriteComps10015 then
				for iter_224_3, iter_224_4 in pairs(arg_221_1.var_.actorSpriteComps10015:ToTable()) do
					if iter_224_4 then
						if arg_221_1.isInRecall_ then
							iter_224_4.color = arg_221_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_224_4.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_221_1.var_.actorSpriteComps10015 = nil
			end

			local var_224_15 = arg_221_1.actors_["10015"]
			local var_224_16 = 0

			if var_224_16 < arg_221_1.time_ and arg_221_1.time_ <= var_224_16 + arg_224_0 then
				local var_224_17 = var_224_15:GetComponentInChildren(typeof(CanvasGroup))

				if var_224_17 then
					arg_221_1.var_.alphaOldValue10015 = var_224_17.alpha
					arg_221_1.var_.characterEffect10015 = var_224_17
				end

				arg_221_1.var_.alphaOldValue10015 = 0
			end

			local var_224_18 = 0.5

			if var_224_16 <= arg_221_1.time_ and arg_221_1.time_ < var_224_16 + var_224_18 then
				local var_224_19 = (arg_221_1.time_ - var_224_16) / var_224_18
				local var_224_20 = Mathf.Lerp(arg_221_1.var_.alphaOldValue10015, 1, var_224_19)

				if arg_221_1.var_.characterEffect10015 then
					arg_221_1.var_.characterEffect10015.alpha = var_224_20
				end
			end

			if arg_221_1.time_ >= var_224_16 + var_224_18 and arg_221_1.time_ < var_224_16 + var_224_18 + arg_224_0 and arg_221_1.var_.characterEffect10015 then
				arg_221_1.var_.characterEffect10015.alpha = 1
			end

			local var_224_21 = 0
			local var_224_22 = 0.675

			if var_224_21 < arg_221_1.time_ and arg_221_1.time_ <= var_224_21 + arg_224_0 then
				arg_221_1.talkMaxDuration = 0
				arg_221_1.dialogCg_.alpha = 1

				arg_221_1.dialog_:SetActive(true)
				SetActive(arg_221_1.leftNameGo_, true)

				local var_224_23 = arg_221_1:FormatText(StoryNameCfg[208].name)

				arg_221_1.leftNameTxt_.text = var_224_23

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_221_1.leftNameTxt_.transform)

				arg_221_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_221_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_221_1:RecordName(arg_221_1.leftNameTxt_.text)
				SetActive(arg_221_1.iconTrs_.gameObject, false)
				arg_221_1.callingController_:SetSelectedState("normal")

				local var_224_24 = arg_221_1:GetWordFromCfg(114241055)
				local var_224_25 = arg_221_1:FormatText(var_224_24.content)

				arg_221_1.text_.text = var_224_25

				LuaForUtil.ClearLinePrefixSymbol(arg_221_1.text_)

				local var_224_26 = 27
				local var_224_27 = utf8.len(var_224_25)
				local var_224_28 = var_224_26 <= 0 and var_224_22 or var_224_22 * (var_224_27 / var_224_26)

				if var_224_28 > 0 and var_224_22 < var_224_28 then
					arg_221_1.talkMaxDuration = var_224_28

					if var_224_28 + var_224_21 > arg_221_1.duration_ then
						arg_221_1.duration_ = var_224_28 + var_224_21
					end
				end

				arg_221_1.text_.text = var_224_25
				arg_221_1.typewritter.percent = 0

				arg_221_1.typewritter:SetDirty()
				arg_221_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_114241", "114241055", "story_v_out_114241.awb") ~= 0 then
					local var_224_29 = manager.audio:GetVoiceLength("story_v_out_114241", "114241055", "story_v_out_114241.awb") / 1000

					if var_224_29 + var_224_21 > arg_221_1.duration_ then
						arg_221_1.duration_ = var_224_29 + var_224_21
					end

					if var_224_24.prefab_name ~= "" and arg_221_1.actors_[var_224_24.prefab_name] ~= nil then
						local var_224_30 = LuaForUtil.PlayVoiceWithCriLipsync(arg_221_1.actors_[var_224_24.prefab_name].transform, "story_v_out_114241", "114241055", "story_v_out_114241.awb")

						arg_221_1:RecordAudio("114241055", var_224_30)
						arg_221_1:RecordAudio("114241055", var_224_30)
					else
						arg_221_1:AudioAction("play", "voice", "story_v_out_114241", "114241055", "story_v_out_114241.awb")
					end

					arg_221_1:RecordHistoryTalkVoice("story_v_out_114241", "114241055", "story_v_out_114241.awb")
				end

				arg_221_1:RecordContent(arg_221_1.text_.text)
			end

			local var_224_31 = math.max(var_224_22, arg_221_1.talkMaxDuration)

			if var_224_21 <= arg_221_1.time_ and arg_221_1.time_ < var_224_21 + var_224_31 then
				arg_221_1.typewritter.percent = (arg_221_1.time_ - var_224_21) / var_224_31

				arg_221_1.typewritter:SetDirty()
			end

			if arg_221_1.time_ >= var_224_21 + var_224_31 and arg_221_1.time_ < var_224_21 + var_224_31 + arg_224_0 then
				arg_221_1.typewritter.percent = 1

				arg_221_1.typewritter:SetDirty()
				arg_221_1:ShowNextGo(true)
			end
		end

		arg_221_1.nodeConfigList_ = {
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

		arg_221_1:InitPlayNodeList()
	end,
	Play114241056 = function(arg_225_0, arg_225_1)
		arg_225_1.time_ = 0
		arg_225_1.frameCnt_ = 0
		arg_225_1.state_ = "playing"
		arg_225_1.curTalkId_ = 114241056
		arg_225_1.duration_ = 12.13

		local var_225_0 = {
			ja = 11.633,
			ko = 10.266,
			zh = 12.133,
			en = 10.666
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
				arg_225_0:Play114241057(arg_225_1)
			end
		end

		function arg_225_1.onSingleLineUpdate_(arg_228_0)
			local var_228_0 = arg_225_1.actors_["10018"]
			local var_228_1 = 0

			if var_228_1 < arg_225_1.time_ and arg_225_1.time_ <= var_228_1 + arg_228_0 and not isNil(var_228_0) and arg_225_1.var_.actorSpriteComps10018 == nil then
				arg_225_1.var_.actorSpriteComps10018 = var_228_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_228_2 = 0.034

			if var_228_1 <= arg_225_1.time_ and arg_225_1.time_ < var_228_1 + var_228_2 and not isNil(var_228_0) then
				local var_228_3 = (arg_225_1.time_ - var_228_1) / var_228_2

				if arg_225_1.var_.actorSpriteComps10018 then
					for iter_228_0, iter_228_1 in pairs(arg_225_1.var_.actorSpriteComps10018:ToTable()) do
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

			if arg_225_1.time_ >= var_228_1 + var_228_2 and arg_225_1.time_ < var_228_1 + var_228_2 + arg_228_0 and not isNil(var_228_0) and arg_225_1.var_.actorSpriteComps10018 then
				for iter_228_2, iter_228_3 in pairs(arg_225_1.var_.actorSpriteComps10018:ToTable()) do
					if iter_228_3 then
						if arg_225_1.isInRecall_ then
							iter_228_3.color = arg_225_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_228_3.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_225_1.var_.actorSpriteComps10018 = nil
			end

			local var_228_8 = arg_225_1.actors_["10015"]
			local var_228_9 = 0

			if var_228_9 < arg_225_1.time_ and arg_225_1.time_ <= var_228_9 + arg_228_0 and not isNil(var_228_8) and arg_225_1.var_.actorSpriteComps10015 == nil then
				arg_225_1.var_.actorSpriteComps10015 = var_228_8:GetComponentsInChildren(typeof(Image), true)
			end

			local var_228_10 = 0.034

			if var_228_9 <= arg_225_1.time_ and arg_225_1.time_ < var_228_9 + var_228_10 and not isNil(var_228_8) then
				local var_228_11 = (arg_225_1.time_ - var_228_9) / var_228_10

				if arg_225_1.var_.actorSpriteComps10015 then
					for iter_228_4, iter_228_5 in pairs(arg_225_1.var_.actorSpriteComps10015:ToTable()) do
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

			if arg_225_1.time_ >= var_228_9 + var_228_10 and arg_225_1.time_ < var_228_9 + var_228_10 + arg_228_0 and not isNil(var_228_8) and arg_225_1.var_.actorSpriteComps10015 then
				for iter_228_6, iter_228_7 in pairs(arg_225_1.var_.actorSpriteComps10015:ToTable()) do
					if iter_228_7 then
						if arg_225_1.isInRecall_ then
							iter_228_7.color = arg_225_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_228_7.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_225_1.var_.actorSpriteComps10015 = nil
			end

			local var_228_16 = arg_225_1.actors_["10018"].transform
			local var_228_17 = 0

			if var_228_17 < arg_225_1.time_ and arg_225_1.time_ <= var_228_17 + arg_228_0 then
				arg_225_1.var_.moveOldPos10018 = var_228_16.localPosition
				var_228_16.localScale = Vector3.New(1, 1, 1)

				arg_225_1:CheckSpriteTmpPos("10018", 2)

				local var_228_18 = var_228_16.childCount

				for iter_228_8 = 0, var_228_18 - 1 do
					local var_228_19 = var_228_16:GetChild(iter_228_8)

					if var_228_19.name == "split_1" or not string.find(var_228_19.name, "split") then
						var_228_19.gameObject:SetActive(true)
					else
						var_228_19.gameObject:SetActive(false)
					end
				end
			end

			local var_228_20 = 0.001

			if var_228_17 <= arg_225_1.time_ and arg_225_1.time_ < var_228_17 + var_228_20 then
				local var_228_21 = (arg_225_1.time_ - var_228_17) / var_228_20
				local var_228_22 = Vector3.New(-390, -350, -180)

				var_228_16.localPosition = Vector3.Lerp(arg_225_1.var_.moveOldPos10018, var_228_22, var_228_21)
			end

			if arg_225_1.time_ >= var_228_17 + var_228_20 and arg_225_1.time_ < var_228_17 + var_228_20 + arg_228_0 then
				var_228_16.localPosition = Vector3.New(-390, -350, -180)
			end

			local var_228_23 = arg_225_1.actors_["10018"]
			local var_228_24 = 0

			if var_228_24 < arg_225_1.time_ and arg_225_1.time_ <= var_228_24 + arg_228_0 then
				local var_228_25 = var_228_23:GetComponentInChildren(typeof(CanvasGroup))

				if var_228_25 then
					arg_225_1.var_.alphaOldValue10018 = var_228_25.alpha
					arg_225_1.var_.characterEffect10018 = var_228_25
				end

				arg_225_1.var_.alphaOldValue10018 = 0
			end

			local var_228_26 = 0.5

			if var_228_24 <= arg_225_1.time_ and arg_225_1.time_ < var_228_24 + var_228_26 then
				local var_228_27 = (arg_225_1.time_ - var_228_24) / var_228_26
				local var_228_28 = Mathf.Lerp(arg_225_1.var_.alphaOldValue10018, 1, var_228_27)

				if arg_225_1.var_.characterEffect10018 then
					arg_225_1.var_.characterEffect10018.alpha = var_228_28
				end
			end

			if arg_225_1.time_ >= var_228_24 + var_228_26 and arg_225_1.time_ < var_228_24 + var_228_26 + arg_228_0 and arg_225_1.var_.characterEffect10018 then
				arg_225_1.var_.characterEffect10018.alpha = 1
			end

			local var_228_29 = 0
			local var_228_30 = 1.35

			if var_228_29 < arg_225_1.time_ and arg_225_1.time_ <= var_228_29 + arg_228_0 then
				arg_225_1.talkMaxDuration = 0
				arg_225_1.dialogCg_.alpha = 1

				arg_225_1.dialog_:SetActive(true)
				SetActive(arg_225_1.leftNameGo_, true)

				local var_228_31 = arg_225_1:FormatText(StoryNameCfg[257].name)

				arg_225_1.leftNameTxt_.text = var_228_31

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_225_1.leftNameTxt_.transform)

				arg_225_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_225_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_225_1:RecordName(arg_225_1.leftNameTxt_.text)
				SetActive(arg_225_1.iconTrs_.gameObject, false)
				arg_225_1.callingController_:SetSelectedState("normal")

				local var_228_32 = arg_225_1:GetWordFromCfg(114241056)
				local var_228_33 = arg_225_1:FormatText(var_228_32.content)

				arg_225_1.text_.text = var_228_33

				LuaForUtil.ClearLinePrefixSymbol(arg_225_1.text_)

				local var_228_34 = 54
				local var_228_35 = utf8.len(var_228_33)
				local var_228_36 = var_228_34 <= 0 and var_228_30 or var_228_30 * (var_228_35 / var_228_34)

				if var_228_36 > 0 and var_228_30 < var_228_36 then
					arg_225_1.talkMaxDuration = var_228_36

					if var_228_36 + var_228_29 > arg_225_1.duration_ then
						arg_225_1.duration_ = var_228_36 + var_228_29
					end
				end

				arg_225_1.text_.text = var_228_33
				arg_225_1.typewritter.percent = 0

				arg_225_1.typewritter:SetDirty()
				arg_225_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_114241", "114241056", "story_v_out_114241.awb") ~= 0 then
					local var_228_37 = manager.audio:GetVoiceLength("story_v_out_114241", "114241056", "story_v_out_114241.awb") / 1000

					if var_228_37 + var_228_29 > arg_225_1.duration_ then
						arg_225_1.duration_ = var_228_37 + var_228_29
					end

					if var_228_32.prefab_name ~= "" and arg_225_1.actors_[var_228_32.prefab_name] ~= nil then
						local var_228_38 = LuaForUtil.PlayVoiceWithCriLipsync(arg_225_1.actors_[var_228_32.prefab_name].transform, "story_v_out_114241", "114241056", "story_v_out_114241.awb")

						arg_225_1:RecordAudio("114241056", var_228_38)
						arg_225_1:RecordAudio("114241056", var_228_38)
					else
						arg_225_1:AudioAction("play", "voice", "story_v_out_114241", "114241056", "story_v_out_114241.awb")
					end

					arg_225_1:RecordHistoryTalkVoice("story_v_out_114241", "114241056", "story_v_out_114241.awb")
				end

				arg_225_1:RecordContent(arg_225_1.text_.text)
			end

			local var_228_39 = math.max(var_228_30, arg_225_1.talkMaxDuration)

			if var_228_29 <= arg_225_1.time_ and arg_225_1.time_ < var_228_29 + var_228_39 then
				arg_225_1.typewritter.percent = (arg_225_1.time_ - var_228_29) / var_228_39

				arg_225_1.typewritter:SetDirty()
			end

			if arg_225_1.time_ >= var_228_29 + var_228_39 and arg_225_1.time_ < var_228_29 + var_228_39 + arg_228_0 then
				arg_225_1.typewritter.percent = 1

				arg_225_1.typewritter:SetDirty()
				arg_225_1:ShowNextGo(true)
			end
		end

		arg_225_1.nodeConfigList_ = {
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

		arg_225_1:InitPlayNodeList()
	end,
	Play114241057 = function(arg_229_0, arg_229_1)
		arg_229_1.time_ = 0
		arg_229_1.frameCnt_ = 0
		arg_229_1.state_ = "playing"
		arg_229_1.curTalkId_ = 114241057
		arg_229_1.duration_ = 11.53

		local var_229_0 = {
			ja = 11.533,
			ko = 10,
			zh = 9.3,
			en = 10.266
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
				arg_229_0:Play114241058(arg_229_1)
			end
		end

		function arg_229_1.onSingleLineUpdate_(arg_232_0)
			local var_232_0 = 0
			local var_232_1 = 1.2

			if var_232_0 < arg_229_1.time_ and arg_229_1.time_ <= var_232_0 + arg_232_0 then
				arg_229_1.talkMaxDuration = 0
				arg_229_1.dialogCg_.alpha = 1

				arg_229_1.dialog_:SetActive(true)
				SetActive(arg_229_1.leftNameGo_, true)

				local var_232_2 = arg_229_1:FormatText(StoryNameCfg[257].name)

				arg_229_1.leftNameTxt_.text = var_232_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_229_1.leftNameTxt_.transform)

				arg_229_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_229_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_229_1:RecordName(arg_229_1.leftNameTxt_.text)
				SetActive(arg_229_1.iconTrs_.gameObject, false)
				arg_229_1.callingController_:SetSelectedState("normal")

				local var_232_3 = arg_229_1:GetWordFromCfg(114241057)
				local var_232_4 = arg_229_1:FormatText(var_232_3.content)

				arg_229_1.text_.text = var_232_4

				LuaForUtil.ClearLinePrefixSymbol(arg_229_1.text_)

				local var_232_5 = 48
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

				if manager.audio:GetVoiceLength("story_v_out_114241", "114241057", "story_v_out_114241.awb") ~= 0 then
					local var_232_8 = manager.audio:GetVoiceLength("story_v_out_114241", "114241057", "story_v_out_114241.awb") / 1000

					if var_232_8 + var_232_0 > arg_229_1.duration_ then
						arg_229_1.duration_ = var_232_8 + var_232_0
					end

					if var_232_3.prefab_name ~= "" and arg_229_1.actors_[var_232_3.prefab_name] ~= nil then
						local var_232_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_229_1.actors_[var_232_3.prefab_name].transform, "story_v_out_114241", "114241057", "story_v_out_114241.awb")

						arg_229_1:RecordAudio("114241057", var_232_9)
						arg_229_1:RecordAudio("114241057", var_232_9)
					else
						arg_229_1:AudioAction("play", "voice", "story_v_out_114241", "114241057", "story_v_out_114241.awb")
					end

					arg_229_1:RecordHistoryTalkVoice("story_v_out_114241", "114241057", "story_v_out_114241.awb")
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
	Play114241058 = function(arg_233_0, arg_233_1)
		arg_233_1.time_ = 0
		arg_233_1.frameCnt_ = 0
		arg_233_1.state_ = "playing"
		arg_233_1.curTalkId_ = 114241058
		arg_233_1.duration_ = 11.5

		local var_233_0 = {
			ja = 8.866,
			ko = 11.5,
			zh = 10.466,
			en = 10.8
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
				arg_233_0:Play114241059(arg_233_1)
			end
		end

		function arg_233_1.onSingleLineUpdate_(arg_236_0)
			local var_236_0 = arg_233_1.actors_["10018"].transform
			local var_236_1 = 1.966

			if var_236_1 < arg_233_1.time_ and arg_233_1.time_ <= var_236_1 + arg_236_0 then
				arg_233_1.var_.moveOldPos10018 = var_236_0.localPosition
				var_236_0.localScale = Vector3.New(1, 1, 1)

				arg_233_1:CheckSpriteTmpPos("10018", 7)

				local var_236_2 = var_236_0.childCount

				for iter_236_0 = 0, var_236_2 - 1 do
					local var_236_3 = var_236_0:GetChild(iter_236_0)

					if var_236_3.name == "split_1" or not string.find(var_236_3.name, "split") then
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

				var_236_0.localPosition = Vector3.Lerp(arg_233_1.var_.moveOldPos10018, var_236_6, var_236_5)
			end

			if arg_233_1.time_ >= var_236_1 + var_236_4 and arg_233_1.time_ < var_236_1 + var_236_4 + arg_236_0 then
				var_236_0.localPosition = Vector3.New(0, -2000, -180)
			end

			local var_236_7 = arg_233_1.actors_["10015"].transform
			local var_236_8 = 1.966

			if var_236_8 < arg_233_1.time_ and arg_233_1.time_ <= var_236_8 + arg_236_0 then
				arg_233_1.var_.moveOldPos10015 = var_236_7.localPosition
				var_236_7.localScale = Vector3.New(1, 1, 1)

				arg_233_1:CheckSpriteTmpPos("10015", 7)

				local var_236_9 = var_236_7.childCount

				for iter_236_1 = 0, var_236_9 - 1 do
					local var_236_10 = var_236_7:GetChild(iter_236_1)

					if var_236_10.name == "split_5" or not string.find(var_236_10.name, "split") then
						var_236_10.gameObject:SetActive(true)
					else
						var_236_10.gameObject:SetActive(false)
					end
				end
			end

			local var_236_11 = 0.001

			if var_236_8 <= arg_233_1.time_ and arg_233_1.time_ < var_236_8 + var_236_11 then
				local var_236_12 = (arg_233_1.time_ - var_236_8) / var_236_11
				local var_236_13 = Vector3.New(0, -2000, 450)

				var_236_7.localPosition = Vector3.Lerp(arg_233_1.var_.moveOldPos10015, var_236_13, var_236_12)
			end

			if arg_233_1.time_ >= var_236_8 + var_236_11 and arg_233_1.time_ < var_236_8 + var_236_11 + arg_236_0 then
				var_236_7.localPosition = Vector3.New(0, -2000, 450)
			end

			local var_236_14 = 0

			if var_236_14 < arg_233_1.time_ and arg_233_1.time_ <= var_236_14 + arg_236_0 then
				arg_233_1.mask_.enabled = true
				arg_233_1.mask_.raycastTarget = true

				arg_233_1:SetGaussion(false)
			end

			local var_236_15 = 2

			if var_236_14 <= arg_233_1.time_ and arg_233_1.time_ < var_236_14 + var_236_15 then
				local var_236_16 = (arg_233_1.time_ - var_236_14) / var_236_15
				local var_236_17 = Color.New(0, 0, 0)

				var_236_17.a = Mathf.Lerp(0, 1, var_236_16)
				arg_233_1.mask_.color = var_236_17
			end

			if arg_233_1.time_ >= var_236_14 + var_236_15 and arg_233_1.time_ < var_236_14 + var_236_15 + arg_236_0 then
				local var_236_18 = Color.New(0, 0, 0)

				var_236_18.a = 1
				arg_233_1.mask_.color = var_236_18
			end

			local var_236_19 = 2

			if var_236_19 < arg_233_1.time_ and arg_233_1.time_ <= var_236_19 + arg_236_0 then
				arg_233_1.mask_.enabled = true
				arg_233_1.mask_.raycastTarget = true

				arg_233_1:SetGaussion(false)
			end

			local var_236_20 = 2

			if var_236_19 <= arg_233_1.time_ and arg_233_1.time_ < var_236_19 + var_236_20 then
				local var_236_21 = (arg_233_1.time_ - var_236_19) / var_236_20
				local var_236_22 = Color.New(0, 0, 0)

				var_236_22.a = Mathf.Lerp(1, 0, var_236_21)
				arg_233_1.mask_.color = var_236_22
			end

			if arg_233_1.time_ >= var_236_19 + var_236_20 and arg_233_1.time_ < var_236_19 + var_236_20 + arg_236_0 then
				local var_236_23 = Color.New(0, 0, 0)
				local var_236_24 = 0

				arg_233_1.mask_.enabled = false
				var_236_23.a = var_236_24
				arg_233_1.mask_.color = var_236_23
			end

			local var_236_25 = "ST23"

			if arg_233_1.bgs_[var_236_25] == nil then
				local var_236_26 = Object.Instantiate(arg_233_1.paintGo_)

				var_236_26:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. var_236_25)
				var_236_26.name = var_236_25
				var_236_26.transform.parent = arg_233_1.stage_.transform
				var_236_26.transform.localPosition = Vector3.New(0, 100, 0)
				arg_233_1.bgs_[var_236_25] = var_236_26
			end

			local var_236_27 = 2

			if var_236_27 < arg_233_1.time_ and arg_233_1.time_ <= var_236_27 + arg_236_0 then
				local var_236_28 = manager.ui.mainCamera.transform.localPosition
				local var_236_29 = Vector3.New(0, 0, 10) + Vector3.New(var_236_28.x, var_236_28.y, 0)
				local var_236_30 = arg_233_1.bgs_.ST23

				var_236_30.transform.localPosition = var_236_29
				var_236_30.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_236_31 = var_236_30:GetComponent("SpriteRenderer")

				if var_236_31 and var_236_31.sprite then
					local var_236_32 = (var_236_30.transform.localPosition - var_236_28).z
					local var_236_33 = manager.ui.mainCameraCom_
					local var_236_34 = 2 * var_236_32 * Mathf.Tan(var_236_33.fieldOfView * 0.5 * Mathf.Deg2Rad)
					local var_236_35 = var_236_34 * var_236_33.aspect
					local var_236_36 = var_236_31.sprite.bounds.size.x
					local var_236_37 = var_236_31.sprite.bounds.size.y
					local var_236_38 = var_236_35 / var_236_36
					local var_236_39 = var_236_34 / var_236_37
					local var_236_40 = var_236_39 < var_236_38 and var_236_38 or var_236_39

					var_236_30.transform.localScale = Vector3.New(var_236_40, var_236_40, 0)
				end

				for iter_236_2, iter_236_3 in pairs(arg_233_1.bgs_) do
					if iter_236_2 ~= "ST23" then
						iter_236_3.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			if arg_233_1.frameCnt_ <= 1 then
				arg_233_1.dialog_:SetActive(false)
			end

			local var_236_41 = 4
			local var_236_42 = 0.625

			if var_236_41 < arg_233_1.time_ and arg_233_1.time_ <= var_236_41 + arg_236_0 then
				arg_233_1.talkMaxDuration = 0

				arg_233_1.dialog_:SetActive(true)

				arg_233_1.dialogCg_.alpha = 0

				local var_236_43 = LeanTween.value(arg_233_1.dialog_, 0, 1, 0.3)

				var_236_43:setOnUpdate(LuaHelper.FloatAction(function(arg_237_0)
					arg_233_1.dialogCg_.alpha = arg_237_0
				end))
				var_236_43:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_233_1.dialog_)
					var_236_43:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_233_1.duration_ = arg_233_1.duration_ + 0.3

				SetActive(arg_233_1.leftNameGo_, true)

				local var_236_44 = arg_233_1:FormatText(StoryNameCfg[258].name)

				arg_233_1.leftNameTxt_.text = var_236_44

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_233_1.leftNameTxt_.transform)

				arg_233_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_233_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_233_1:RecordName(arg_233_1.leftNameTxt_.text)
				SetActive(arg_233_1.iconTrs_.gameObject, true)
				arg_233_1.iconController_:SetSelectedState("hero")

				arg_233_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_10018")

				arg_233_1.callingController_:SetSelectedState("normal")

				arg_233_1.keyicon_.color = Color.New(1, 1, 1)
				arg_233_1.icon_.color = Color.New(1, 1, 1)

				local var_236_45 = arg_233_1:GetWordFromCfg(114241058)
				local var_236_46 = arg_233_1:FormatText(var_236_45.content)

				arg_233_1.text_.text = var_236_46

				LuaForUtil.ClearLinePrefixSymbol(arg_233_1.text_)

				local var_236_47 = 25
				local var_236_48 = utf8.len(var_236_46)
				local var_236_49 = var_236_47 <= 0 and var_236_42 or var_236_42 * (var_236_48 / var_236_47)

				if var_236_49 > 0 and var_236_42 < var_236_49 then
					arg_233_1.talkMaxDuration = var_236_49
					var_236_41 = var_236_41 + 0.3

					if var_236_49 + var_236_41 > arg_233_1.duration_ then
						arg_233_1.duration_ = var_236_49 + var_236_41
					end
				end

				arg_233_1.text_.text = var_236_46
				arg_233_1.typewritter.percent = 0

				arg_233_1.typewritter:SetDirty()
				arg_233_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_114241", "114241058", "story_v_out_114241.awb") ~= 0 then
					local var_236_50 = manager.audio:GetVoiceLength("story_v_out_114241", "114241058", "story_v_out_114241.awb") / 1000

					if var_236_50 + var_236_41 > arg_233_1.duration_ then
						arg_233_1.duration_ = var_236_50 + var_236_41
					end

					if var_236_45.prefab_name ~= "" and arg_233_1.actors_[var_236_45.prefab_name] ~= nil then
						local var_236_51 = LuaForUtil.PlayVoiceWithCriLipsync(arg_233_1.actors_[var_236_45.prefab_name].transform, "story_v_out_114241", "114241058", "story_v_out_114241.awb")

						arg_233_1:RecordAudio("114241058", var_236_51)
						arg_233_1:RecordAudio("114241058", var_236_51)
					else
						arg_233_1:AudioAction("play", "voice", "story_v_out_114241", "114241058", "story_v_out_114241.awb")
					end

					arg_233_1:RecordHistoryTalkVoice("story_v_out_114241", "114241058", "story_v_out_114241.awb")
				end

				arg_233_1:RecordContent(arg_233_1.text_.text)
			end

			local var_236_52 = var_236_41 + 0.3
			local var_236_53 = math.max(var_236_42, arg_233_1.talkMaxDuration)

			if var_236_52 <= arg_233_1.time_ and arg_233_1.time_ < var_236_52 + var_236_53 then
				arg_233_1.typewritter.percent = (arg_233_1.time_ - var_236_52) / var_236_53

				arg_233_1.typewritter:SetDirty()
			end

			if arg_233_1.time_ >= var_236_52 + var_236_53 and arg_233_1.time_ < var_236_52 + var_236_53 + arg_236_0 then
				arg_233_1.typewritter.percent = 1

				arg_233_1.typewritter:SetDirty()
				arg_233_1:ShowNextGo(true)
			end
		end

		arg_233_1.nodeConfigList_ = {
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

		arg_233_1:InitPlayNodeList()
	end,
	Play114241059 = function(arg_239_0, arg_239_1)
		arg_239_1.time_ = 0
		arg_239_1.frameCnt_ = 0
		arg_239_1.state_ = "playing"
		arg_239_1.curTalkId_ = 114241059
		arg_239_1.duration_ = 5

		SetActive(arg_239_1.tipsGo_, false)

		function arg_239_1.onSingleLineFinish_()
			arg_239_1.onSingleLineUpdate_ = nil
			arg_239_1.onSingleLineFinish_ = nil
			arg_239_1.state_ = "waiting"
		end

		function arg_239_1.playNext_(arg_241_0)
			if arg_241_0 == 1 then
				arg_239_0:Play114241060(arg_239_1)
			end
		end

		function arg_239_1.onSingleLineUpdate_(arg_242_0)
			local var_242_0 = 0
			local var_242_1 = 0.925

			if var_242_0 < arg_239_1.time_ and arg_239_1.time_ <= var_242_0 + arg_242_0 then
				arg_239_1.talkMaxDuration = 0
				arg_239_1.dialogCg_.alpha = 1

				arg_239_1.dialog_:SetActive(true)
				SetActive(arg_239_1.leftNameGo_, false)

				arg_239_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_239_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_239_1:RecordName(arg_239_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_239_1.iconTrs_.gameObject, false)
				arg_239_1.callingController_:SetSelectedState("normal")

				local var_242_2 = arg_239_1:GetWordFromCfg(114241059)
				local var_242_3 = arg_239_1:FormatText(var_242_2.content)

				arg_239_1.text_.text = var_242_3

				LuaForUtil.ClearLinePrefixSymbol(arg_239_1.text_)

				local var_242_4 = 37
				local var_242_5 = utf8.len(var_242_3)
				local var_242_6 = var_242_4 <= 0 and var_242_1 or var_242_1 * (var_242_5 / var_242_4)

				if var_242_6 > 0 and var_242_1 < var_242_6 then
					arg_239_1.talkMaxDuration = var_242_6

					if var_242_6 + var_242_0 > arg_239_1.duration_ then
						arg_239_1.duration_ = var_242_6 + var_242_0
					end
				end

				arg_239_1.text_.text = var_242_3
				arg_239_1.typewritter.percent = 0

				arg_239_1.typewritter:SetDirty()
				arg_239_1:ShowNextGo(false)
				arg_239_1:RecordContent(arg_239_1.text_.text)
			end

			local var_242_7 = math.max(var_242_1, arg_239_1.talkMaxDuration)

			if var_242_0 <= arg_239_1.time_ and arg_239_1.time_ < var_242_0 + var_242_7 then
				arg_239_1.typewritter.percent = (arg_239_1.time_ - var_242_0) / var_242_7

				arg_239_1.typewritter:SetDirty()
			end

			if arg_239_1.time_ >= var_242_0 + var_242_7 and arg_239_1.time_ < var_242_0 + var_242_7 + arg_242_0 then
				arg_239_1.typewritter.percent = 1

				arg_239_1.typewritter:SetDirty()
				arg_239_1:ShowNextGo(true)
			end
		end

		arg_239_1.nodeConfigList_ = {}

		arg_239_1:InitPlayNodeList()
	end,
	Play114241060 = function(arg_243_0, arg_243_1)
		arg_243_1.time_ = 0
		arg_243_1.frameCnt_ = 0
		arg_243_1.state_ = "playing"
		arg_243_1.curTalkId_ = 114241060
		arg_243_1.duration_ = 6.87

		local var_243_0 = {
			ja = 5.633,
			ko = 6.866,
			zh = 6.733,
			en = 5.833
		}
		local var_243_1 = manager.audio:GetLocalizationFlag()

		if var_243_0[var_243_1] ~= nil then
			arg_243_1.duration_ = var_243_0[var_243_1]
		end

		SetActive(arg_243_1.tipsGo_, false)

		function arg_243_1.onSingleLineFinish_()
			arg_243_1.onSingleLineUpdate_ = nil
			arg_243_1.onSingleLineFinish_ = nil
			arg_243_1.state_ = "waiting"
		end

		function arg_243_1.playNext_(arg_245_0)
			if arg_245_0 == 1 then
				arg_243_0:Play114241061(arg_243_1)
			end
		end

		function arg_243_1.onSingleLineUpdate_(arg_246_0)
			local var_246_0 = arg_243_1.actors_["10018"].transform
			local var_246_1 = 0

			if var_246_1 < arg_243_1.time_ and arg_243_1.time_ <= var_246_1 + arg_246_0 then
				arg_243_1.var_.moveOldPos10018 = var_246_0.localPosition
				var_246_0.localScale = Vector3.New(1, 1, 1)

				arg_243_1:CheckSpriteTmpPos("10018", 3)

				local var_246_2 = var_246_0.childCount

				for iter_246_0 = 0, var_246_2 - 1 do
					local var_246_3 = var_246_0:GetChild(iter_246_0)

					if var_246_3.name == "split_1" or not string.find(var_246_3.name, "split") then
						var_246_3.gameObject:SetActive(true)
					else
						var_246_3.gameObject:SetActive(false)
					end
				end
			end

			local var_246_4 = 0.001

			if var_246_1 <= arg_243_1.time_ and arg_243_1.time_ < var_246_1 + var_246_4 then
				local var_246_5 = (arg_243_1.time_ - var_246_1) / var_246_4
				local var_246_6 = Vector3.New(0, -350, -180)

				var_246_0.localPosition = Vector3.Lerp(arg_243_1.var_.moveOldPos10018, var_246_6, var_246_5)
			end

			if arg_243_1.time_ >= var_246_1 + var_246_4 and arg_243_1.time_ < var_246_1 + var_246_4 + arg_246_0 then
				var_246_0.localPosition = Vector3.New(0, -350, -180)
			end

			local var_246_7 = arg_243_1.actors_["10018"]
			local var_246_8 = 0

			if var_246_8 < arg_243_1.time_ and arg_243_1.time_ <= var_246_8 + arg_246_0 and not isNil(var_246_7) then
				local var_246_9 = var_246_7:GetComponent("Image")

				if var_246_9 then
					arg_243_1.var_.highlightMatValue10018 = var_246_9
				end
			end

			local var_246_10 = 0.034

			if var_246_8 <= arg_243_1.time_ and arg_243_1.time_ < var_246_8 + var_246_10 and not isNil(var_246_7) then
				local var_246_11 = (arg_243_1.time_ - var_246_8) / var_246_10

				if arg_243_1.var_.highlightMatValue10018 then
					local var_246_12 = Mathf.Lerp(0.5, 1, var_246_11)
					local var_246_13 = arg_243_1.var_.highlightMatValue10018
					local var_246_14 = var_246_13.color

					var_246_14.r = var_246_12
					var_246_14.g = var_246_12
					var_246_14.b = var_246_12
					var_246_13.color = var_246_14
				end
			end

			if arg_243_1.time_ >= var_246_8 + var_246_10 and arg_243_1.time_ < var_246_8 + var_246_10 + arg_246_0 and not isNil(var_246_7) and arg_243_1.var_.highlightMatValue10018 then
				local var_246_15 = 1

				var_246_7.transform:SetSiblingIndex(1)

				local var_246_16 = arg_243_1.var_.highlightMatValue10018
				local var_246_17 = var_246_16.color

				var_246_17.r = var_246_15
				var_246_17.g = var_246_15
				var_246_17.b = var_246_15
				var_246_16.color = var_246_17
			end

			local var_246_18 = arg_243_1.actors_["10018"]
			local var_246_19 = 0

			if var_246_19 < arg_243_1.time_ and arg_243_1.time_ <= var_246_19 + arg_246_0 then
				local var_246_20 = var_246_18:GetComponentInChildren(typeof(CanvasGroup))

				if var_246_20 then
					arg_243_1.var_.alphaOldValue10018 = var_246_20.alpha
					arg_243_1.var_.characterEffect10018 = var_246_20
				end

				arg_243_1.var_.alphaOldValue10018 = 0
			end

			local var_246_21 = 0.5

			if var_246_19 <= arg_243_1.time_ and arg_243_1.time_ < var_246_19 + var_246_21 then
				local var_246_22 = (arg_243_1.time_ - var_246_19) / var_246_21
				local var_246_23 = Mathf.Lerp(arg_243_1.var_.alphaOldValue10018, 1, var_246_22)

				if arg_243_1.var_.characterEffect10018 then
					arg_243_1.var_.characterEffect10018.alpha = var_246_23
				end
			end

			if arg_243_1.time_ >= var_246_19 + var_246_21 and arg_243_1.time_ < var_246_19 + var_246_21 + arg_246_0 and arg_243_1.var_.characterEffect10018 then
				arg_243_1.var_.characterEffect10018.alpha = 1
			end

			local var_246_24 = 0
			local var_246_25 = 0.925

			if var_246_24 < arg_243_1.time_ and arg_243_1.time_ <= var_246_24 + arg_246_0 then
				arg_243_1.talkMaxDuration = 0
				arg_243_1.dialogCg_.alpha = 1

				arg_243_1.dialog_:SetActive(true)
				SetActive(arg_243_1.leftNameGo_, true)

				local var_246_26 = arg_243_1:FormatText(StoryNameCfg[258].name)

				arg_243_1.leftNameTxt_.text = var_246_26

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_243_1.leftNameTxt_.transform)

				arg_243_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_243_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_243_1:RecordName(arg_243_1.leftNameTxt_.text)
				SetActive(arg_243_1.iconTrs_.gameObject, false)
				arg_243_1.callingController_:SetSelectedState("normal")

				local var_246_27 = arg_243_1:GetWordFromCfg(114241060)
				local var_246_28 = arg_243_1:FormatText(var_246_27.content)

				arg_243_1.text_.text = var_246_28

				LuaForUtil.ClearLinePrefixSymbol(arg_243_1.text_)

				local var_246_29 = 37
				local var_246_30 = utf8.len(var_246_28)
				local var_246_31 = var_246_29 <= 0 and var_246_25 or var_246_25 * (var_246_30 / var_246_29)

				if var_246_31 > 0 and var_246_25 < var_246_31 then
					arg_243_1.talkMaxDuration = var_246_31

					if var_246_31 + var_246_24 > arg_243_1.duration_ then
						arg_243_1.duration_ = var_246_31 + var_246_24
					end
				end

				arg_243_1.text_.text = var_246_28
				arg_243_1.typewritter.percent = 0

				arg_243_1.typewritter:SetDirty()
				arg_243_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_114241", "114241060", "story_v_out_114241.awb") ~= 0 then
					local var_246_32 = manager.audio:GetVoiceLength("story_v_out_114241", "114241060", "story_v_out_114241.awb") / 1000

					if var_246_32 + var_246_24 > arg_243_1.duration_ then
						arg_243_1.duration_ = var_246_32 + var_246_24
					end

					if var_246_27.prefab_name ~= "" and arg_243_1.actors_[var_246_27.prefab_name] ~= nil then
						local var_246_33 = LuaForUtil.PlayVoiceWithCriLipsync(arg_243_1.actors_[var_246_27.prefab_name].transform, "story_v_out_114241", "114241060", "story_v_out_114241.awb")

						arg_243_1:RecordAudio("114241060", var_246_33)
						arg_243_1:RecordAudio("114241060", var_246_33)
					else
						arg_243_1:AudioAction("play", "voice", "story_v_out_114241", "114241060", "story_v_out_114241.awb")
					end

					arg_243_1:RecordHistoryTalkVoice("story_v_out_114241", "114241060", "story_v_out_114241.awb")
				end

				arg_243_1:RecordContent(arg_243_1.text_.text)
			end

			local var_246_34 = math.max(var_246_25, arg_243_1.talkMaxDuration)

			if var_246_24 <= arg_243_1.time_ and arg_243_1.time_ < var_246_24 + var_246_34 then
				arg_243_1.typewritter.percent = (arg_243_1.time_ - var_246_24) / var_246_34

				arg_243_1.typewritter:SetDirty()
			end

			if arg_243_1.time_ >= var_246_24 + var_246_34 and arg_243_1.time_ < var_246_24 + var_246_34 + arg_246_0 then
				arg_243_1.typewritter.percent = 1

				arg_243_1.typewritter:SetDirty()
				arg_243_1:ShowNextGo(true)
			end
		end

		arg_243_1.nodeConfigList_ = {
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

		arg_243_1:InitPlayNodeList()
	end,
	Play114241061 = function(arg_247_0, arg_247_1)
		arg_247_1.time_ = 0
		arg_247_1.frameCnt_ = 0
		arg_247_1.state_ = "playing"
		arg_247_1.curTalkId_ = 114241061
		arg_247_1.duration_ = 1.5

		local var_247_0 = {
			ja = 1.166,
			ko = 1.1,
			zh = 1.4,
			en = 1.5
		}
		local var_247_1 = manager.audio:GetLocalizationFlag()

		if var_247_0[var_247_1] ~= nil then
			arg_247_1.duration_ = var_247_0[var_247_1]
		end

		SetActive(arg_247_1.tipsGo_, false)

		function arg_247_1.onSingleLineFinish_()
			arg_247_1.onSingleLineUpdate_ = nil
			arg_247_1.onSingleLineFinish_ = nil
			arg_247_1.state_ = "waiting"
		end

		function arg_247_1.playNext_(arg_249_0)
			if arg_249_0 == 1 then
				arg_247_0:Play114241062(arg_247_1)
			end
		end

		function arg_247_1.onSingleLineUpdate_(arg_250_0)
			local var_250_0 = arg_247_1.actors_["10018"]
			local var_250_1 = 0

			if var_250_1 < arg_247_1.time_ and arg_247_1.time_ <= var_250_1 + arg_250_0 and not isNil(var_250_0) and arg_247_1.var_.actorSpriteComps10018 == nil then
				arg_247_1.var_.actorSpriteComps10018 = var_250_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_250_2 = 0.034

			if var_250_1 <= arg_247_1.time_ and arg_247_1.time_ < var_250_1 + var_250_2 and not isNil(var_250_0) then
				local var_250_3 = (arg_247_1.time_ - var_250_1) / var_250_2

				if arg_247_1.var_.actorSpriteComps10018 then
					for iter_250_0, iter_250_1 in pairs(arg_247_1.var_.actorSpriteComps10018:ToTable()) do
						if iter_250_1 then
							if arg_247_1.isInRecall_ then
								local var_250_4 = Mathf.Lerp(iter_250_1.color.r, arg_247_1.hightColor2.r, var_250_3)
								local var_250_5 = Mathf.Lerp(iter_250_1.color.g, arg_247_1.hightColor2.g, var_250_3)
								local var_250_6 = Mathf.Lerp(iter_250_1.color.b, arg_247_1.hightColor2.b, var_250_3)

								iter_250_1.color = Color.New(var_250_4, var_250_5, var_250_6)
							else
								local var_250_7 = Mathf.Lerp(iter_250_1.color.r, 0.5, var_250_3)

								iter_250_1.color = Color.New(var_250_7, var_250_7, var_250_7)
							end
						end
					end
				end
			end

			if arg_247_1.time_ >= var_250_1 + var_250_2 and arg_247_1.time_ < var_250_1 + var_250_2 + arg_250_0 and not isNil(var_250_0) and arg_247_1.var_.actorSpriteComps10018 then
				for iter_250_2, iter_250_3 in pairs(arg_247_1.var_.actorSpriteComps10018:ToTable()) do
					if iter_250_3 then
						if arg_247_1.isInRecall_ then
							iter_250_3.color = arg_247_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_250_3.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_247_1.var_.actorSpriteComps10018 = nil
			end

			local var_250_8 = 0
			local var_250_9 = 0.05

			if var_250_8 < arg_247_1.time_ and arg_247_1.time_ <= var_250_8 + arg_250_0 then
				arg_247_1.talkMaxDuration = 0
				arg_247_1.dialogCg_.alpha = 1

				arg_247_1.dialog_:SetActive(true)
				SetActive(arg_247_1.leftNameGo_, true)

				local var_250_10 = arg_247_1:FormatText(StoryNameCfg[206].name)

				arg_247_1.leftNameTxt_.text = var_250_10

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_247_1.leftNameTxt_.transform)

				arg_247_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_247_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_247_1:RecordName(arg_247_1.leftNameTxt_.text)
				SetActive(arg_247_1.iconTrs_.gameObject, true)
				arg_247_1.iconController_:SetSelectedState("hero")

				arg_247_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_1067")

				arg_247_1.callingController_:SetSelectedState("normal")

				arg_247_1.keyicon_.color = Color.New(1, 1, 1)
				arg_247_1.icon_.color = Color.New(1, 1, 1)

				local var_250_11 = arg_247_1:GetWordFromCfg(114241061)
				local var_250_12 = arg_247_1:FormatText(var_250_11.content)

				arg_247_1.text_.text = var_250_12

				LuaForUtil.ClearLinePrefixSymbol(arg_247_1.text_)

				local var_250_13 = 2
				local var_250_14 = utf8.len(var_250_12)
				local var_250_15 = var_250_13 <= 0 and var_250_9 or var_250_9 * (var_250_14 / var_250_13)

				if var_250_15 > 0 and var_250_9 < var_250_15 then
					arg_247_1.talkMaxDuration = var_250_15

					if var_250_15 + var_250_8 > arg_247_1.duration_ then
						arg_247_1.duration_ = var_250_15 + var_250_8
					end
				end

				arg_247_1.text_.text = var_250_12
				arg_247_1.typewritter.percent = 0

				arg_247_1.typewritter:SetDirty()
				arg_247_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_114241", "114241061", "story_v_out_114241.awb") ~= 0 then
					local var_250_16 = manager.audio:GetVoiceLength("story_v_out_114241", "114241061", "story_v_out_114241.awb") / 1000

					if var_250_16 + var_250_8 > arg_247_1.duration_ then
						arg_247_1.duration_ = var_250_16 + var_250_8
					end

					if var_250_11.prefab_name ~= "" and arg_247_1.actors_[var_250_11.prefab_name] ~= nil then
						local var_250_17 = LuaForUtil.PlayVoiceWithCriLipsync(arg_247_1.actors_[var_250_11.prefab_name].transform, "story_v_out_114241", "114241061", "story_v_out_114241.awb")

						arg_247_1:RecordAudio("114241061", var_250_17)
						arg_247_1:RecordAudio("114241061", var_250_17)
					else
						arg_247_1:AudioAction("play", "voice", "story_v_out_114241", "114241061", "story_v_out_114241.awb")
					end

					arg_247_1:RecordHistoryTalkVoice("story_v_out_114241", "114241061", "story_v_out_114241.awb")
				end

				arg_247_1:RecordContent(arg_247_1.text_.text)
			end

			local var_250_18 = math.max(var_250_9, arg_247_1.talkMaxDuration)

			if var_250_8 <= arg_247_1.time_ and arg_247_1.time_ < var_250_8 + var_250_18 then
				arg_247_1.typewritter.percent = (arg_247_1.time_ - var_250_8) / var_250_18

				arg_247_1.typewritter:SetDirty()
			end

			if arg_247_1.time_ >= var_250_8 + var_250_18 and arg_247_1.time_ < var_250_8 + var_250_18 + arg_250_0 then
				arg_247_1.typewritter.percent = 1

				arg_247_1.typewritter:SetDirty()
				arg_247_1:ShowNextGo(true)
			end
		end

		arg_247_1.nodeConfigList_ = {}

		arg_247_1:InitPlayNodeList()
	end,
	Play114241062 = function(arg_251_0, arg_251_1)
		arg_251_1.time_ = 0
		arg_251_1.frameCnt_ = 0
		arg_251_1.state_ = "playing"
		arg_251_1.curTalkId_ = 114241062
		arg_251_1.duration_ = 8.8

		local var_251_0 = {
			ja = 8.8,
			ko = 7.533,
			zh = 7.833,
			en = 6.033
		}
		local var_251_1 = manager.audio:GetLocalizationFlag()

		if var_251_0[var_251_1] ~= nil then
			arg_251_1.duration_ = var_251_0[var_251_1]
		end

		SetActive(arg_251_1.tipsGo_, false)

		function arg_251_1.onSingleLineFinish_()
			arg_251_1.onSingleLineUpdate_ = nil
			arg_251_1.onSingleLineFinish_ = nil
			arg_251_1.state_ = "waiting"
		end

		function arg_251_1.playNext_(arg_253_0)
			if arg_253_0 == 1 then
				arg_251_0:Play114241063(arg_251_1)
			end
		end

		function arg_251_1.onSingleLineUpdate_(arg_254_0)
			local var_254_0 = 0
			local var_254_1 = 0.925

			if var_254_0 < arg_251_1.time_ and arg_251_1.time_ <= var_254_0 + arg_254_0 then
				arg_251_1.talkMaxDuration = 0
				arg_251_1.dialogCg_.alpha = 1

				arg_251_1.dialog_:SetActive(true)
				SetActive(arg_251_1.leftNameGo_, true)

				local var_254_2 = arg_251_1:FormatText(StoryNameCfg[206].name)

				arg_251_1.leftNameTxt_.text = var_254_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_251_1.leftNameTxt_.transform)

				arg_251_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_251_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_251_1:RecordName(arg_251_1.leftNameTxt_.text)
				SetActive(arg_251_1.iconTrs_.gameObject, true)
				arg_251_1.iconController_:SetSelectedState("hero")

				arg_251_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_1067")

				arg_251_1.callingController_:SetSelectedState("normal")

				arg_251_1.keyicon_.color = Color.New(1, 1, 1)
				arg_251_1.icon_.color = Color.New(1, 1, 1)

				local var_254_3 = arg_251_1:GetWordFromCfg(114241062)
				local var_254_4 = arg_251_1:FormatText(var_254_3.content)

				arg_251_1.text_.text = var_254_4

				LuaForUtil.ClearLinePrefixSymbol(arg_251_1.text_)

				local var_254_5 = 37
				local var_254_6 = utf8.len(var_254_4)
				local var_254_7 = var_254_5 <= 0 and var_254_1 or var_254_1 * (var_254_6 / var_254_5)

				if var_254_7 > 0 and var_254_1 < var_254_7 then
					arg_251_1.talkMaxDuration = var_254_7

					if var_254_7 + var_254_0 > arg_251_1.duration_ then
						arg_251_1.duration_ = var_254_7 + var_254_0
					end
				end

				arg_251_1.text_.text = var_254_4
				arg_251_1.typewritter.percent = 0

				arg_251_1.typewritter:SetDirty()
				arg_251_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_114241", "114241062", "story_v_out_114241.awb") ~= 0 then
					local var_254_8 = manager.audio:GetVoiceLength("story_v_out_114241", "114241062", "story_v_out_114241.awb") / 1000

					if var_254_8 + var_254_0 > arg_251_1.duration_ then
						arg_251_1.duration_ = var_254_8 + var_254_0
					end

					if var_254_3.prefab_name ~= "" and arg_251_1.actors_[var_254_3.prefab_name] ~= nil then
						local var_254_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_251_1.actors_[var_254_3.prefab_name].transform, "story_v_out_114241", "114241062", "story_v_out_114241.awb")

						arg_251_1:RecordAudio("114241062", var_254_9)
						arg_251_1:RecordAudio("114241062", var_254_9)
					else
						arg_251_1:AudioAction("play", "voice", "story_v_out_114241", "114241062", "story_v_out_114241.awb")
					end

					arg_251_1:RecordHistoryTalkVoice("story_v_out_114241", "114241062", "story_v_out_114241.awb")
				end

				arg_251_1:RecordContent(arg_251_1.text_.text)
			end

			local var_254_10 = math.max(var_254_1, arg_251_1.talkMaxDuration)

			if var_254_0 <= arg_251_1.time_ and arg_251_1.time_ < var_254_0 + var_254_10 then
				arg_251_1.typewritter.percent = (arg_251_1.time_ - var_254_0) / var_254_10

				arg_251_1.typewritter:SetDirty()
			end

			if arg_251_1.time_ >= var_254_0 + var_254_10 and arg_251_1.time_ < var_254_0 + var_254_10 + arg_254_0 then
				arg_251_1.typewritter.percent = 1

				arg_251_1.typewritter:SetDirty()
				arg_251_1:ShowNextGo(true)
			end
		end

		arg_251_1.nodeConfigList_ = {}

		arg_251_1:InitPlayNodeList()
	end,
	Play114241063 = function(arg_255_0, arg_255_1)
		arg_255_1.time_ = 0
		arg_255_1.frameCnt_ = 0
		arg_255_1.state_ = "playing"
		arg_255_1.curTalkId_ = 114241063
		arg_255_1.duration_ = 8.37

		local var_255_0 = {
			ja = 6.966,
			ko = 6.8,
			zh = 8.366,
			en = 5.966
		}
		local var_255_1 = manager.audio:GetLocalizationFlag()

		if var_255_0[var_255_1] ~= nil then
			arg_255_1.duration_ = var_255_0[var_255_1]
		end

		SetActive(arg_255_1.tipsGo_, false)

		function arg_255_1.onSingleLineFinish_()
			arg_255_1.onSingleLineUpdate_ = nil
			arg_255_1.onSingleLineFinish_ = nil
			arg_255_1.state_ = "waiting"
		end

		function arg_255_1.playNext_(arg_257_0)
			if arg_257_0 == 1 then
				arg_255_0:Play114241064(arg_255_1)
			end
		end

		function arg_255_1.onSingleLineUpdate_(arg_258_0)
			local var_258_0 = arg_255_1.actors_["10018"]
			local var_258_1 = 0

			if var_258_1 < arg_255_1.time_ and arg_255_1.time_ <= var_258_1 + arg_258_0 and not isNil(var_258_0) and arg_255_1.var_.actorSpriteComps10018 == nil then
				arg_255_1.var_.actorSpriteComps10018 = var_258_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_258_2 = 0.034

			if var_258_1 <= arg_255_1.time_ and arg_255_1.time_ < var_258_1 + var_258_2 and not isNil(var_258_0) then
				local var_258_3 = (arg_255_1.time_ - var_258_1) / var_258_2

				if arg_255_1.var_.actorSpriteComps10018 then
					for iter_258_0, iter_258_1 in pairs(arg_255_1.var_.actorSpriteComps10018:ToTable()) do
						if iter_258_1 then
							if arg_255_1.isInRecall_ then
								local var_258_4 = Mathf.Lerp(iter_258_1.color.r, arg_255_1.hightColor1.r, var_258_3)
								local var_258_5 = Mathf.Lerp(iter_258_1.color.g, arg_255_1.hightColor1.g, var_258_3)
								local var_258_6 = Mathf.Lerp(iter_258_1.color.b, arg_255_1.hightColor1.b, var_258_3)

								iter_258_1.color = Color.New(var_258_4, var_258_5, var_258_6)
							else
								local var_258_7 = Mathf.Lerp(iter_258_1.color.r, 1, var_258_3)

								iter_258_1.color = Color.New(var_258_7, var_258_7, var_258_7)
							end
						end
					end
				end
			end

			if arg_255_1.time_ >= var_258_1 + var_258_2 and arg_255_1.time_ < var_258_1 + var_258_2 + arg_258_0 and not isNil(var_258_0) and arg_255_1.var_.actorSpriteComps10018 then
				for iter_258_2, iter_258_3 in pairs(arg_255_1.var_.actorSpriteComps10018:ToTable()) do
					if iter_258_3 then
						if arg_255_1.isInRecall_ then
							iter_258_3.color = arg_255_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_258_3.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_255_1.var_.actorSpriteComps10018 = nil
			end

			local var_258_8 = 0
			local var_258_9 = 0.725

			if var_258_8 < arg_255_1.time_ and arg_255_1.time_ <= var_258_8 + arg_258_0 then
				arg_255_1.talkMaxDuration = 0
				arg_255_1.dialogCg_.alpha = 1

				arg_255_1.dialog_:SetActive(true)
				SetActive(arg_255_1.leftNameGo_, true)

				local var_258_10 = arg_255_1:FormatText(StoryNameCfg[258].name)

				arg_255_1.leftNameTxt_.text = var_258_10

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_255_1.leftNameTxt_.transform)

				arg_255_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_255_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_255_1:RecordName(arg_255_1.leftNameTxt_.text)
				SetActive(arg_255_1.iconTrs_.gameObject, false)
				arg_255_1.callingController_:SetSelectedState("normal")

				local var_258_11 = arg_255_1:GetWordFromCfg(114241063)
				local var_258_12 = arg_255_1:FormatText(var_258_11.content)

				arg_255_1.text_.text = var_258_12

				LuaForUtil.ClearLinePrefixSymbol(arg_255_1.text_)

				local var_258_13 = 29
				local var_258_14 = utf8.len(var_258_12)
				local var_258_15 = var_258_13 <= 0 and var_258_9 or var_258_9 * (var_258_14 / var_258_13)

				if var_258_15 > 0 and var_258_9 < var_258_15 then
					arg_255_1.talkMaxDuration = var_258_15

					if var_258_15 + var_258_8 > arg_255_1.duration_ then
						arg_255_1.duration_ = var_258_15 + var_258_8
					end
				end

				arg_255_1.text_.text = var_258_12
				arg_255_1.typewritter.percent = 0

				arg_255_1.typewritter:SetDirty()
				arg_255_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_114241", "114241063", "story_v_out_114241.awb") ~= 0 then
					local var_258_16 = manager.audio:GetVoiceLength("story_v_out_114241", "114241063", "story_v_out_114241.awb") / 1000

					if var_258_16 + var_258_8 > arg_255_1.duration_ then
						arg_255_1.duration_ = var_258_16 + var_258_8
					end

					if var_258_11.prefab_name ~= "" and arg_255_1.actors_[var_258_11.prefab_name] ~= nil then
						local var_258_17 = LuaForUtil.PlayVoiceWithCriLipsync(arg_255_1.actors_[var_258_11.prefab_name].transform, "story_v_out_114241", "114241063", "story_v_out_114241.awb")

						arg_255_1:RecordAudio("114241063", var_258_17)
						arg_255_1:RecordAudio("114241063", var_258_17)
					else
						arg_255_1:AudioAction("play", "voice", "story_v_out_114241", "114241063", "story_v_out_114241.awb")
					end

					arg_255_1:RecordHistoryTalkVoice("story_v_out_114241", "114241063", "story_v_out_114241.awb")
				end

				arg_255_1:RecordContent(arg_255_1.text_.text)
			end

			local var_258_18 = math.max(var_258_9, arg_255_1.talkMaxDuration)

			if var_258_8 <= arg_255_1.time_ and arg_255_1.time_ < var_258_8 + var_258_18 then
				arg_255_1.typewritter.percent = (arg_255_1.time_ - var_258_8) / var_258_18

				arg_255_1.typewritter:SetDirty()
			end

			if arg_255_1.time_ >= var_258_8 + var_258_18 and arg_255_1.time_ < var_258_8 + var_258_18 + arg_258_0 then
				arg_255_1.typewritter.percent = 1

				arg_255_1.typewritter:SetDirty()
				arg_255_1:ShowNextGo(true)
			end
		end

		arg_255_1.nodeConfigList_ = {}

		arg_255_1:InitPlayNodeList()
	end,
	Play114241064 = function(arg_259_0, arg_259_1)
		arg_259_1.time_ = 0
		arg_259_1.frameCnt_ = 0
		arg_259_1.state_ = "playing"
		arg_259_1.curTalkId_ = 114241064
		arg_259_1.duration_ = 9.83

		local var_259_0 = {
			ja = 7.8,
			ko = 6.233,
			zh = 9.833,
			en = 8.7
		}
		local var_259_1 = manager.audio:GetLocalizationFlag()

		if var_259_0[var_259_1] ~= nil then
			arg_259_1.duration_ = var_259_0[var_259_1]
		end

		SetActive(arg_259_1.tipsGo_, false)

		function arg_259_1.onSingleLineFinish_()
			arg_259_1.onSingleLineUpdate_ = nil
			arg_259_1.onSingleLineFinish_ = nil
			arg_259_1.state_ = "waiting"
		end

		function arg_259_1.playNext_(arg_261_0)
			if arg_261_0 == 1 then
				arg_259_0:Play114241065(arg_259_1)
			end
		end

		function arg_259_1.onSingleLineUpdate_(arg_262_0)
			local var_262_0 = arg_259_1.actors_["10018"]
			local var_262_1 = 0

			if var_262_1 < arg_259_1.time_ and arg_259_1.time_ <= var_262_1 + arg_262_0 and not isNil(var_262_0) and arg_259_1.var_.actorSpriteComps10018 == nil then
				arg_259_1.var_.actorSpriteComps10018 = var_262_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_262_2 = 0.034

			if var_262_1 <= arg_259_1.time_ and arg_259_1.time_ < var_262_1 + var_262_2 and not isNil(var_262_0) then
				local var_262_3 = (arg_259_1.time_ - var_262_1) / var_262_2

				if arg_259_1.var_.actorSpriteComps10018 then
					for iter_262_0, iter_262_1 in pairs(arg_259_1.var_.actorSpriteComps10018:ToTable()) do
						if iter_262_1 then
							if arg_259_1.isInRecall_ then
								local var_262_4 = Mathf.Lerp(iter_262_1.color.r, arg_259_1.hightColor2.r, var_262_3)
								local var_262_5 = Mathf.Lerp(iter_262_1.color.g, arg_259_1.hightColor2.g, var_262_3)
								local var_262_6 = Mathf.Lerp(iter_262_1.color.b, arg_259_1.hightColor2.b, var_262_3)

								iter_262_1.color = Color.New(var_262_4, var_262_5, var_262_6)
							else
								local var_262_7 = Mathf.Lerp(iter_262_1.color.r, 0.5, var_262_3)

								iter_262_1.color = Color.New(var_262_7, var_262_7, var_262_7)
							end
						end
					end
				end
			end

			if arg_259_1.time_ >= var_262_1 + var_262_2 and arg_259_1.time_ < var_262_1 + var_262_2 + arg_262_0 and not isNil(var_262_0) and arg_259_1.var_.actorSpriteComps10018 then
				for iter_262_2, iter_262_3 in pairs(arg_259_1.var_.actorSpriteComps10018:ToTable()) do
					if iter_262_3 then
						if arg_259_1.isInRecall_ then
							iter_262_3.color = arg_259_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_262_3.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_259_1.var_.actorSpriteComps10018 = nil
			end

			local var_262_8 = 0
			local var_262_9 = 0.925

			if var_262_8 < arg_259_1.time_ and arg_259_1.time_ <= var_262_8 + arg_262_0 then
				arg_259_1.talkMaxDuration = 0
				arg_259_1.dialogCg_.alpha = 1

				arg_259_1.dialog_:SetActive(true)
				SetActive(arg_259_1.leftNameGo_, true)

				local var_262_10 = arg_259_1:FormatText(StoryNameCfg[206].name)

				arg_259_1.leftNameTxt_.text = var_262_10

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_259_1.leftNameTxt_.transform)

				arg_259_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_259_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_259_1:RecordName(arg_259_1.leftNameTxt_.text)
				SetActive(arg_259_1.iconTrs_.gameObject, true)
				arg_259_1.iconController_:SetSelectedState("hero")

				arg_259_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_1067")

				arg_259_1.callingController_:SetSelectedState("normal")

				arg_259_1.keyicon_.color = Color.New(1, 1, 1)
				arg_259_1.icon_.color = Color.New(1, 1, 1)

				local var_262_11 = arg_259_1:GetWordFromCfg(114241064)
				local var_262_12 = arg_259_1:FormatText(var_262_11.content)

				arg_259_1.text_.text = var_262_12

				LuaForUtil.ClearLinePrefixSymbol(arg_259_1.text_)

				local var_262_13 = 37
				local var_262_14 = utf8.len(var_262_12)
				local var_262_15 = var_262_13 <= 0 and var_262_9 or var_262_9 * (var_262_14 / var_262_13)

				if var_262_15 > 0 and var_262_9 < var_262_15 then
					arg_259_1.talkMaxDuration = var_262_15

					if var_262_15 + var_262_8 > arg_259_1.duration_ then
						arg_259_1.duration_ = var_262_15 + var_262_8
					end
				end

				arg_259_1.text_.text = var_262_12
				arg_259_1.typewritter.percent = 0

				arg_259_1.typewritter:SetDirty()
				arg_259_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_114241", "114241064", "story_v_out_114241.awb") ~= 0 then
					local var_262_16 = manager.audio:GetVoiceLength("story_v_out_114241", "114241064", "story_v_out_114241.awb") / 1000

					if var_262_16 + var_262_8 > arg_259_1.duration_ then
						arg_259_1.duration_ = var_262_16 + var_262_8
					end

					if var_262_11.prefab_name ~= "" and arg_259_1.actors_[var_262_11.prefab_name] ~= nil then
						local var_262_17 = LuaForUtil.PlayVoiceWithCriLipsync(arg_259_1.actors_[var_262_11.prefab_name].transform, "story_v_out_114241", "114241064", "story_v_out_114241.awb")

						arg_259_1:RecordAudio("114241064", var_262_17)
						arg_259_1:RecordAudio("114241064", var_262_17)
					else
						arg_259_1:AudioAction("play", "voice", "story_v_out_114241", "114241064", "story_v_out_114241.awb")
					end

					arg_259_1:RecordHistoryTalkVoice("story_v_out_114241", "114241064", "story_v_out_114241.awb")
				end

				arg_259_1:RecordContent(arg_259_1.text_.text)
			end

			local var_262_18 = math.max(var_262_9, arg_259_1.talkMaxDuration)

			if var_262_8 <= arg_259_1.time_ and arg_259_1.time_ < var_262_8 + var_262_18 then
				arg_259_1.typewritter.percent = (arg_259_1.time_ - var_262_8) / var_262_18

				arg_259_1.typewritter:SetDirty()
			end

			if arg_259_1.time_ >= var_262_8 + var_262_18 and arg_259_1.time_ < var_262_8 + var_262_18 + arg_262_0 then
				arg_259_1.typewritter.percent = 1

				arg_259_1.typewritter:SetDirty()
				arg_259_1:ShowNextGo(true)
			end
		end

		arg_259_1.nodeConfigList_ = {}

		arg_259_1:InitPlayNodeList()
	end,
	Play114241065 = function(arg_263_0, arg_263_1)
		arg_263_1.time_ = 0
		arg_263_1.frameCnt_ = 0
		arg_263_1.state_ = "playing"
		arg_263_1.curTalkId_ = 114241065
		arg_263_1.duration_ = 12.6

		local var_263_0 = {
			ja = 8.966,
			ko = 10.833,
			zh = 11.8,
			en = 12.6
		}
		local var_263_1 = manager.audio:GetLocalizationFlag()

		if var_263_0[var_263_1] ~= nil then
			arg_263_1.duration_ = var_263_0[var_263_1]
		end

		SetActive(arg_263_1.tipsGo_, false)

		function arg_263_1.onSingleLineFinish_()
			arg_263_1.onSingleLineUpdate_ = nil
			arg_263_1.onSingleLineFinish_ = nil
			arg_263_1.state_ = "waiting"
		end

		function arg_263_1.playNext_(arg_265_0)
			if arg_265_0 == 1 then
				arg_263_0:Play114241066(arg_263_1)
			end
		end

		function arg_263_1.onSingleLineUpdate_(arg_266_0)
			local var_266_0 = arg_263_1.actors_["10018"]
			local var_266_1 = 0

			if var_266_1 < arg_263_1.time_ and arg_263_1.time_ <= var_266_1 + arg_266_0 and not isNil(var_266_0) and arg_263_1.var_.actorSpriteComps10018 == nil then
				arg_263_1.var_.actorSpriteComps10018 = var_266_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_266_2 = 0.034

			if var_266_1 <= arg_263_1.time_ and arg_263_1.time_ < var_266_1 + var_266_2 and not isNil(var_266_0) then
				local var_266_3 = (arg_263_1.time_ - var_266_1) / var_266_2

				if arg_263_1.var_.actorSpriteComps10018 then
					for iter_266_0, iter_266_1 in pairs(arg_263_1.var_.actorSpriteComps10018:ToTable()) do
						if iter_266_1 then
							if arg_263_1.isInRecall_ then
								local var_266_4 = Mathf.Lerp(iter_266_1.color.r, arg_263_1.hightColor1.r, var_266_3)
								local var_266_5 = Mathf.Lerp(iter_266_1.color.g, arg_263_1.hightColor1.g, var_266_3)
								local var_266_6 = Mathf.Lerp(iter_266_1.color.b, arg_263_1.hightColor1.b, var_266_3)

								iter_266_1.color = Color.New(var_266_4, var_266_5, var_266_6)
							else
								local var_266_7 = Mathf.Lerp(iter_266_1.color.r, 1, var_266_3)

								iter_266_1.color = Color.New(var_266_7, var_266_7, var_266_7)
							end
						end
					end
				end
			end

			if arg_263_1.time_ >= var_266_1 + var_266_2 and arg_263_1.time_ < var_266_1 + var_266_2 + arg_266_0 and not isNil(var_266_0) and arg_263_1.var_.actorSpriteComps10018 then
				for iter_266_2, iter_266_3 in pairs(arg_263_1.var_.actorSpriteComps10018:ToTable()) do
					if iter_266_3 then
						if arg_263_1.isInRecall_ then
							iter_266_3.color = arg_263_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_266_3.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_263_1.var_.actorSpriteComps10018 = nil
			end

			local var_266_8 = 0
			local var_266_9 = 1.3

			if var_266_8 < arg_263_1.time_ and arg_263_1.time_ <= var_266_8 + arg_266_0 then
				arg_263_1.talkMaxDuration = 0
				arg_263_1.dialogCg_.alpha = 1

				arg_263_1.dialog_:SetActive(true)
				SetActive(arg_263_1.leftNameGo_, true)

				local var_266_10 = arg_263_1:FormatText(StoryNameCfg[258].name)

				arg_263_1.leftNameTxt_.text = var_266_10

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_263_1.leftNameTxt_.transform)

				arg_263_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_263_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_263_1:RecordName(arg_263_1.leftNameTxt_.text)
				SetActive(arg_263_1.iconTrs_.gameObject, false)
				arg_263_1.callingController_:SetSelectedState("normal")

				local var_266_11 = arg_263_1:GetWordFromCfg(114241065)
				local var_266_12 = arg_263_1:FormatText(var_266_11.content)

				arg_263_1.text_.text = var_266_12

				LuaForUtil.ClearLinePrefixSymbol(arg_263_1.text_)

				local var_266_13 = 52
				local var_266_14 = utf8.len(var_266_12)
				local var_266_15 = var_266_13 <= 0 and var_266_9 or var_266_9 * (var_266_14 / var_266_13)

				if var_266_15 > 0 and var_266_9 < var_266_15 then
					arg_263_1.talkMaxDuration = var_266_15

					if var_266_15 + var_266_8 > arg_263_1.duration_ then
						arg_263_1.duration_ = var_266_15 + var_266_8
					end
				end

				arg_263_1.text_.text = var_266_12
				arg_263_1.typewritter.percent = 0

				arg_263_1.typewritter:SetDirty()
				arg_263_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_114241", "114241065", "story_v_out_114241.awb") ~= 0 then
					local var_266_16 = manager.audio:GetVoiceLength("story_v_out_114241", "114241065", "story_v_out_114241.awb") / 1000

					if var_266_16 + var_266_8 > arg_263_1.duration_ then
						arg_263_1.duration_ = var_266_16 + var_266_8
					end

					if var_266_11.prefab_name ~= "" and arg_263_1.actors_[var_266_11.prefab_name] ~= nil then
						local var_266_17 = LuaForUtil.PlayVoiceWithCriLipsync(arg_263_1.actors_[var_266_11.prefab_name].transform, "story_v_out_114241", "114241065", "story_v_out_114241.awb")

						arg_263_1:RecordAudio("114241065", var_266_17)
						arg_263_1:RecordAudio("114241065", var_266_17)
					else
						arg_263_1:AudioAction("play", "voice", "story_v_out_114241", "114241065", "story_v_out_114241.awb")
					end

					arg_263_1:RecordHistoryTalkVoice("story_v_out_114241", "114241065", "story_v_out_114241.awb")
				end

				arg_263_1:RecordContent(arg_263_1.text_.text)
			end

			local var_266_18 = math.max(var_266_9, arg_263_1.talkMaxDuration)

			if var_266_8 <= arg_263_1.time_ and arg_263_1.time_ < var_266_8 + var_266_18 then
				arg_263_1.typewritter.percent = (arg_263_1.time_ - var_266_8) / var_266_18

				arg_263_1.typewritter:SetDirty()
			end

			if arg_263_1.time_ >= var_266_8 + var_266_18 and arg_263_1.time_ < var_266_8 + var_266_18 + arg_266_0 then
				arg_263_1.typewritter.percent = 1

				arg_263_1.typewritter:SetDirty()
				arg_263_1:ShowNextGo(true)
			end
		end

		arg_263_1.nodeConfigList_ = {}

		arg_263_1:InitPlayNodeList()
	end,
	Play114241066 = function(arg_267_0, arg_267_1)
		arg_267_1.time_ = 0
		arg_267_1.frameCnt_ = 0
		arg_267_1.state_ = "playing"
		arg_267_1.curTalkId_ = 114241066
		arg_267_1.duration_ = 9.13

		local var_267_0 = {
			ja = 9.133,
			ko = 7.666,
			zh = 7.4,
			en = 7.9
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
				arg_267_0:Play114241067(arg_267_1)
			end
		end

		function arg_267_1.onSingleLineUpdate_(arg_270_0)
			local var_270_0 = arg_267_1.actors_["10018"]
			local var_270_1 = 0

			if var_270_1 < arg_267_1.time_ and arg_267_1.time_ <= var_270_1 + arg_270_0 and not isNil(var_270_0) and arg_267_1.var_.actorSpriteComps10018 == nil then
				arg_267_1.var_.actorSpriteComps10018 = var_270_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_270_2 = 0.034

			if var_270_1 <= arg_267_1.time_ and arg_267_1.time_ < var_270_1 + var_270_2 and not isNil(var_270_0) then
				local var_270_3 = (arg_267_1.time_ - var_270_1) / var_270_2

				if arg_267_1.var_.actorSpriteComps10018 then
					for iter_270_0, iter_270_1 in pairs(arg_267_1.var_.actorSpriteComps10018:ToTable()) do
						if iter_270_1 then
							if arg_267_1.isInRecall_ then
								local var_270_4 = Mathf.Lerp(iter_270_1.color.r, arg_267_1.hightColor2.r, var_270_3)
								local var_270_5 = Mathf.Lerp(iter_270_1.color.g, arg_267_1.hightColor2.g, var_270_3)
								local var_270_6 = Mathf.Lerp(iter_270_1.color.b, arg_267_1.hightColor2.b, var_270_3)

								iter_270_1.color = Color.New(var_270_4, var_270_5, var_270_6)
							else
								local var_270_7 = Mathf.Lerp(iter_270_1.color.r, 0.5, var_270_3)

								iter_270_1.color = Color.New(var_270_7, var_270_7, var_270_7)
							end
						end
					end
				end
			end

			if arg_267_1.time_ >= var_270_1 + var_270_2 and arg_267_1.time_ < var_270_1 + var_270_2 + arg_270_0 and not isNil(var_270_0) and arg_267_1.var_.actorSpriteComps10018 then
				for iter_270_2, iter_270_3 in pairs(arg_267_1.var_.actorSpriteComps10018:ToTable()) do
					if iter_270_3 then
						if arg_267_1.isInRecall_ then
							iter_270_3.color = arg_267_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_270_3.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_267_1.var_.actorSpriteComps10018 = nil
			end

			local var_270_8 = 0
			local var_270_9 = 0.9

			if var_270_8 < arg_267_1.time_ and arg_267_1.time_ <= var_270_8 + arg_270_0 then
				arg_267_1.talkMaxDuration = 0
				arg_267_1.dialogCg_.alpha = 1

				arg_267_1.dialog_:SetActive(true)
				SetActive(arg_267_1.leftNameGo_, true)

				local var_270_10 = arg_267_1:FormatText(StoryNameCfg[206].name)

				arg_267_1.leftNameTxt_.text = var_270_10

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_267_1.leftNameTxt_.transform)

				arg_267_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_267_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_267_1:RecordName(arg_267_1.leftNameTxt_.text)
				SetActive(arg_267_1.iconTrs_.gameObject, true)
				arg_267_1.iconController_:SetSelectedState("hero")

				arg_267_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_1067")

				arg_267_1.callingController_:SetSelectedState("normal")

				arg_267_1.keyicon_.color = Color.New(1, 1, 1)
				arg_267_1.icon_.color = Color.New(1, 1, 1)

				local var_270_11 = arg_267_1:GetWordFromCfg(114241066)
				local var_270_12 = arg_267_1:FormatText(var_270_11.content)

				arg_267_1.text_.text = var_270_12

				LuaForUtil.ClearLinePrefixSymbol(arg_267_1.text_)

				local var_270_13 = 36
				local var_270_14 = utf8.len(var_270_12)
				local var_270_15 = var_270_13 <= 0 and var_270_9 or var_270_9 * (var_270_14 / var_270_13)

				if var_270_15 > 0 and var_270_9 < var_270_15 then
					arg_267_1.talkMaxDuration = var_270_15

					if var_270_15 + var_270_8 > arg_267_1.duration_ then
						arg_267_1.duration_ = var_270_15 + var_270_8
					end
				end

				arg_267_1.text_.text = var_270_12
				arg_267_1.typewritter.percent = 0

				arg_267_1.typewritter:SetDirty()
				arg_267_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_114241", "114241066", "story_v_out_114241.awb") ~= 0 then
					local var_270_16 = manager.audio:GetVoiceLength("story_v_out_114241", "114241066", "story_v_out_114241.awb") / 1000

					if var_270_16 + var_270_8 > arg_267_1.duration_ then
						arg_267_1.duration_ = var_270_16 + var_270_8
					end

					if var_270_11.prefab_name ~= "" and arg_267_1.actors_[var_270_11.prefab_name] ~= nil then
						local var_270_17 = LuaForUtil.PlayVoiceWithCriLipsync(arg_267_1.actors_[var_270_11.prefab_name].transform, "story_v_out_114241", "114241066", "story_v_out_114241.awb")

						arg_267_1:RecordAudio("114241066", var_270_17)
						arg_267_1:RecordAudio("114241066", var_270_17)
					else
						arg_267_1:AudioAction("play", "voice", "story_v_out_114241", "114241066", "story_v_out_114241.awb")
					end

					arg_267_1:RecordHistoryTalkVoice("story_v_out_114241", "114241066", "story_v_out_114241.awb")
				end

				arg_267_1:RecordContent(arg_267_1.text_.text)
			end

			local var_270_18 = math.max(var_270_9, arg_267_1.talkMaxDuration)

			if var_270_8 <= arg_267_1.time_ and arg_267_1.time_ < var_270_8 + var_270_18 then
				arg_267_1.typewritter.percent = (arg_267_1.time_ - var_270_8) / var_270_18

				arg_267_1.typewritter:SetDirty()
			end

			if arg_267_1.time_ >= var_270_8 + var_270_18 and arg_267_1.time_ < var_270_8 + var_270_18 + arg_270_0 then
				arg_267_1.typewritter.percent = 1

				arg_267_1.typewritter:SetDirty()
				arg_267_1:ShowNextGo(true)
			end
		end

		arg_267_1.nodeConfigList_ = {}

		arg_267_1:InitPlayNodeList()
	end,
	Play114241067 = function(arg_271_0, arg_271_1)
		arg_271_1.time_ = 0
		arg_271_1.frameCnt_ = 0
		arg_271_1.state_ = "playing"
		arg_271_1.curTalkId_ = 114241067
		arg_271_1.duration_ = 9

		SetActive(arg_271_1.tipsGo_, false)

		function arg_271_1.onSingleLineFinish_()
			arg_271_1.onSingleLineUpdate_ = nil
			arg_271_1.onSingleLineFinish_ = nil
			arg_271_1.state_ = "waiting"
		end

		function arg_271_1.playNext_(arg_273_0)
			if arg_273_0 == 1 then
				arg_271_0:Play114241068(arg_271_1)
			end
		end

		function arg_271_1.onSingleLineUpdate_(arg_274_0)
			local var_274_0 = "F04"

			if arg_271_1.bgs_[var_274_0] == nil then
				local var_274_1 = Object.Instantiate(arg_271_1.paintGo_)

				var_274_1:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. var_274_0)
				var_274_1.name = var_274_0
				var_274_1.transform.parent = arg_271_1.stage_.transform
				var_274_1.transform.localPosition = Vector3.New(0, 100, 0)
				arg_271_1.bgs_[var_274_0] = var_274_1
			end

			local var_274_2 = 2

			if var_274_2 < arg_271_1.time_ and arg_271_1.time_ <= var_274_2 + arg_274_0 then
				local var_274_3 = manager.ui.mainCamera.transform.localPosition
				local var_274_4 = Vector3.New(0, 0, 10) + Vector3.New(var_274_3.x, var_274_3.y, 0)
				local var_274_5 = arg_271_1.bgs_.F04

				var_274_5.transform.localPosition = var_274_4
				var_274_5.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_274_6 = var_274_5:GetComponent("SpriteRenderer")

				if var_274_6 and var_274_6.sprite then
					local var_274_7 = (var_274_5.transform.localPosition - var_274_3).z
					local var_274_8 = manager.ui.mainCameraCom_
					local var_274_9 = 2 * var_274_7 * Mathf.Tan(var_274_8.fieldOfView * 0.5 * Mathf.Deg2Rad)
					local var_274_10 = var_274_9 * var_274_8.aspect
					local var_274_11 = var_274_6.sprite.bounds.size.x
					local var_274_12 = var_274_6.sprite.bounds.size.y
					local var_274_13 = var_274_10 / var_274_11
					local var_274_14 = var_274_9 / var_274_12
					local var_274_15 = var_274_14 < var_274_13 and var_274_13 or var_274_14

					var_274_5.transform.localScale = Vector3.New(var_274_15, var_274_15, 0)
				end

				for iter_274_0, iter_274_1 in pairs(arg_271_1.bgs_) do
					if iter_274_0 ~= "F04" then
						iter_274_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_274_16 = 0

			if var_274_16 < arg_271_1.time_ and arg_271_1.time_ <= var_274_16 + arg_274_0 then
				arg_271_1.mask_.enabled = true
				arg_271_1.mask_.raycastTarget = true

				arg_271_1:SetGaussion(false)
			end

			local var_274_17 = 2

			if var_274_16 <= arg_271_1.time_ and arg_271_1.time_ < var_274_16 + var_274_17 then
				local var_274_18 = (arg_271_1.time_ - var_274_16) / var_274_17
				local var_274_19 = Color.New(0, 0, 0)

				var_274_19.a = Mathf.Lerp(0, 1, var_274_18)
				arg_271_1.mask_.color = var_274_19
			end

			if arg_271_1.time_ >= var_274_16 + var_274_17 and arg_271_1.time_ < var_274_16 + var_274_17 + arg_274_0 then
				local var_274_20 = Color.New(0, 0, 0)

				var_274_20.a = 1
				arg_271_1.mask_.color = var_274_20
			end

			local var_274_21 = 2

			if var_274_21 < arg_271_1.time_ and arg_271_1.time_ <= var_274_21 + arg_274_0 then
				arg_271_1.mask_.enabled = true
				arg_271_1.mask_.raycastTarget = true

				arg_271_1:SetGaussion(false)
			end

			local var_274_22 = 2

			if var_274_21 <= arg_271_1.time_ and arg_271_1.time_ < var_274_21 + var_274_22 then
				local var_274_23 = (arg_271_1.time_ - var_274_21) / var_274_22
				local var_274_24 = Color.New(0, 0, 0)

				var_274_24.a = Mathf.Lerp(1, 0, var_274_23)
				arg_271_1.mask_.color = var_274_24
			end

			if arg_271_1.time_ >= var_274_21 + var_274_22 and arg_271_1.time_ < var_274_21 + var_274_22 + arg_274_0 then
				local var_274_25 = Color.New(0, 0, 0)
				local var_274_26 = 0

				arg_271_1.mask_.enabled = false
				var_274_25.a = var_274_26
				arg_271_1.mask_.color = var_274_25
			end

			local var_274_27 = arg_271_1.actors_["10018"].transform
			local var_274_28 = 1.966

			if var_274_28 < arg_271_1.time_ and arg_271_1.time_ <= var_274_28 + arg_274_0 then
				arg_271_1.var_.moveOldPos10018 = var_274_27.localPosition
				var_274_27.localScale = Vector3.New(1, 1, 1)

				arg_271_1:CheckSpriteTmpPos("10018", 7)

				local var_274_29 = var_274_27.childCount

				for iter_274_2 = 0, var_274_29 - 1 do
					local var_274_30 = var_274_27:GetChild(iter_274_2)

					if var_274_30.name == "split_1" or not string.find(var_274_30.name, "split") then
						var_274_30.gameObject:SetActive(true)
					else
						var_274_30.gameObject:SetActive(false)
					end
				end
			end

			local var_274_31 = 0.001

			if var_274_28 <= arg_271_1.time_ and arg_271_1.time_ < var_274_28 + var_274_31 then
				local var_274_32 = (arg_271_1.time_ - var_274_28) / var_274_31
				local var_274_33 = Vector3.New(0, -2000, -180)

				var_274_27.localPosition = Vector3.Lerp(arg_271_1.var_.moveOldPos10018, var_274_33, var_274_32)
			end

			if arg_271_1.time_ >= var_274_28 + var_274_31 and arg_271_1.time_ < var_274_28 + var_274_31 + arg_274_0 then
				var_274_27.localPosition = Vector3.New(0, -2000, -180)
			end

			if arg_271_1.frameCnt_ <= 1 then
				arg_271_1.dialog_:SetActive(false)
			end

			local var_274_34 = 4
			local var_274_35 = 0.9

			if var_274_34 < arg_271_1.time_ and arg_271_1.time_ <= var_274_34 + arg_274_0 then
				arg_271_1.talkMaxDuration = 0

				arg_271_1.dialog_:SetActive(true)

				arg_271_1.dialogCg_.alpha = 0

				local var_274_36 = LeanTween.value(arg_271_1.dialog_, 0, 1, 0.3)

				var_274_36:setOnUpdate(LuaHelper.FloatAction(function(arg_275_0)
					arg_271_1.dialogCg_.alpha = arg_275_0
				end))
				var_274_36:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_271_1.dialog_)
					var_274_36:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_271_1.duration_ = arg_271_1.duration_ + 0.3

				SetActive(arg_271_1.leftNameGo_, false)

				arg_271_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_271_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_271_1:RecordName(arg_271_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_271_1.iconTrs_.gameObject, false)
				arg_271_1.callingController_:SetSelectedState("normal")

				local var_274_37 = arg_271_1:GetWordFromCfg(114241067)
				local var_274_38 = arg_271_1:FormatText(var_274_37.content)

				arg_271_1.text_.text = var_274_38

				LuaForUtil.ClearLinePrefixSymbol(arg_271_1.text_)

				local var_274_39 = 36
				local var_274_40 = utf8.len(var_274_38)
				local var_274_41 = var_274_39 <= 0 and var_274_35 or var_274_35 * (var_274_40 / var_274_39)

				if var_274_41 > 0 and var_274_35 < var_274_41 then
					arg_271_1.talkMaxDuration = var_274_41
					var_274_34 = var_274_34 + 0.3

					if var_274_41 + var_274_34 > arg_271_1.duration_ then
						arg_271_1.duration_ = var_274_41 + var_274_34
					end
				end

				arg_271_1.text_.text = var_274_38
				arg_271_1.typewritter.percent = 0

				arg_271_1.typewritter:SetDirty()
				arg_271_1:ShowNextGo(false)
				arg_271_1:RecordContent(arg_271_1.text_.text)
			end

			local var_274_42 = var_274_34 + 0.3
			local var_274_43 = math.max(var_274_35, arg_271_1.talkMaxDuration)

			if var_274_42 <= arg_271_1.time_ and arg_271_1.time_ < var_274_42 + var_274_43 then
				arg_271_1.typewritter.percent = (arg_271_1.time_ - var_274_42) / var_274_43

				arg_271_1.typewritter:SetDirty()
			end

			if arg_271_1.time_ >= var_274_42 + var_274_43 and arg_271_1.time_ < var_274_42 + var_274_43 + arg_274_0 then
				arg_271_1.typewritter.percent = 1

				arg_271_1.typewritter:SetDirty()
				arg_271_1:ShowNextGo(true)
			end
		end

		arg_271_1.nodeConfigList_ = {
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

		arg_271_1:InitPlayNodeList()
	end,
	Play114241068 = function(arg_277_0, arg_277_1)
		arg_277_1.time_ = 0
		arg_277_1.frameCnt_ = 0
		arg_277_1.state_ = "playing"
		arg_277_1.curTalkId_ = 114241068
		arg_277_1.duration_ = 5

		SetActive(arg_277_1.tipsGo_, false)

		function arg_277_1.onSingleLineFinish_()
			arg_277_1.onSingleLineUpdate_ = nil
			arg_277_1.onSingleLineFinish_ = nil
			arg_277_1.state_ = "waiting"
		end

		function arg_277_1.playNext_(arg_279_0)
			if arg_279_0 == 1 then
				arg_277_0:Play114241069(arg_277_1)
			end
		end

		function arg_277_1.onSingleLineUpdate_(arg_280_0)
			local var_280_0 = 0
			local var_280_1 = 1.7

			if var_280_0 < arg_277_1.time_ and arg_277_1.time_ <= var_280_0 + arg_280_0 then
				arg_277_1.talkMaxDuration = 0
				arg_277_1.dialogCg_.alpha = 1

				arg_277_1.dialog_:SetActive(true)
				SetActive(arg_277_1.leftNameGo_, false)

				arg_277_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_277_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_277_1:RecordName(arg_277_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_277_1.iconTrs_.gameObject, false)
				arg_277_1.callingController_:SetSelectedState("normal")

				local var_280_2 = arg_277_1:GetWordFromCfg(114241068)
				local var_280_3 = arg_277_1:FormatText(var_280_2.content)

				arg_277_1.text_.text = var_280_3

				LuaForUtil.ClearLinePrefixSymbol(arg_277_1.text_)

				local var_280_4 = 68
				local var_280_5 = utf8.len(var_280_3)
				local var_280_6 = var_280_4 <= 0 and var_280_1 or var_280_1 * (var_280_5 / var_280_4)

				if var_280_6 > 0 and var_280_1 < var_280_6 then
					arg_277_1.talkMaxDuration = var_280_6

					if var_280_6 + var_280_0 > arg_277_1.duration_ then
						arg_277_1.duration_ = var_280_6 + var_280_0
					end
				end

				arg_277_1.text_.text = var_280_3
				arg_277_1.typewritter.percent = 0

				arg_277_1.typewritter:SetDirty()
				arg_277_1:ShowNextGo(false)
				arg_277_1:RecordContent(arg_277_1.text_.text)
			end

			local var_280_7 = math.max(var_280_1, arg_277_1.talkMaxDuration)

			if var_280_0 <= arg_277_1.time_ and arg_277_1.time_ < var_280_0 + var_280_7 then
				arg_277_1.typewritter.percent = (arg_277_1.time_ - var_280_0) / var_280_7

				arg_277_1.typewritter:SetDirty()
			end

			if arg_277_1.time_ >= var_280_0 + var_280_7 and arg_277_1.time_ < var_280_0 + var_280_7 + arg_280_0 then
				arg_277_1.typewritter.percent = 1

				arg_277_1.typewritter:SetDirty()
				arg_277_1:ShowNextGo(true)
			end
		end

		arg_277_1.nodeConfigList_ = {}

		arg_277_1:InitPlayNodeList()
	end,
	Play114241069 = function(arg_281_0, arg_281_1)
		arg_281_1.time_ = 0
		arg_281_1.frameCnt_ = 0
		arg_281_1.state_ = "playing"
		arg_281_1.curTalkId_ = 114241069
		arg_281_1.duration_ = 5

		SetActive(arg_281_1.tipsGo_, false)

		function arg_281_1.onSingleLineFinish_()
			arg_281_1.onSingleLineUpdate_ = nil
			arg_281_1.onSingleLineFinish_ = nil
			arg_281_1.state_ = "waiting"
		end

		function arg_281_1.playNext_(arg_283_0)
			if arg_283_0 == 1 then
				arg_281_0:Play114241070(arg_281_1)
			end
		end

		function arg_281_1.onSingleLineUpdate_(arg_284_0)
			local var_284_0 = 0
			local var_284_1 = 1.35

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

				local var_284_2 = arg_281_1:GetWordFromCfg(114241069)
				local var_284_3 = arg_281_1:FormatText(var_284_2.content)

				arg_281_1.text_.text = var_284_3

				LuaForUtil.ClearLinePrefixSymbol(arg_281_1.text_)

				local var_284_4 = 54
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
	Play114241070 = function(arg_285_0, arg_285_1)
		arg_285_1.time_ = 0
		arg_285_1.frameCnt_ = 0
		arg_285_1.state_ = "playing"
		arg_285_1.curTalkId_ = 114241070
		arg_285_1.duration_ = 5

		SetActive(arg_285_1.tipsGo_, false)

		function arg_285_1.onSingleLineFinish_()
			arg_285_1.onSingleLineUpdate_ = nil
			arg_285_1.onSingleLineFinish_ = nil
			arg_285_1.state_ = "waiting"
		end

		function arg_285_1.playNext_(arg_287_0)
			if arg_287_0 == 1 then
				arg_285_0:Play114241071(arg_285_1)
			end
		end

		function arg_285_1.onSingleLineUpdate_(arg_288_0)
			local var_288_0 = 0
			local var_288_1 = 0.525

			if var_288_0 < arg_285_1.time_ and arg_285_1.time_ <= var_288_0 + arg_288_0 then
				arg_285_1.talkMaxDuration = 0
				arg_285_1.dialogCg_.alpha = 1

				arg_285_1.dialog_:SetActive(true)
				SetActive(arg_285_1.leftNameGo_, false)

				arg_285_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_285_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_285_1:RecordName(arg_285_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_285_1.iconTrs_.gameObject, false)
				arg_285_1.callingController_:SetSelectedState("normal")

				local var_288_2 = arg_285_1:GetWordFromCfg(114241070)
				local var_288_3 = arg_285_1:FormatText(var_288_2.content)

				arg_285_1.text_.text = var_288_3

				LuaForUtil.ClearLinePrefixSymbol(arg_285_1.text_)

				local var_288_4 = 21
				local var_288_5 = utf8.len(var_288_3)
				local var_288_6 = var_288_4 <= 0 and var_288_1 or var_288_1 * (var_288_5 / var_288_4)

				if var_288_6 > 0 and var_288_1 < var_288_6 then
					arg_285_1.talkMaxDuration = var_288_6

					if var_288_6 + var_288_0 > arg_285_1.duration_ then
						arg_285_1.duration_ = var_288_6 + var_288_0
					end
				end

				arg_285_1.text_.text = var_288_3
				arg_285_1.typewritter.percent = 0

				arg_285_1.typewritter:SetDirty()
				arg_285_1:ShowNextGo(false)
				arg_285_1:RecordContent(arg_285_1.text_.text)
			end

			local var_288_7 = math.max(var_288_1, arg_285_1.talkMaxDuration)

			if var_288_0 <= arg_285_1.time_ and arg_285_1.time_ < var_288_0 + var_288_7 then
				arg_285_1.typewritter.percent = (arg_285_1.time_ - var_288_0) / var_288_7

				arg_285_1.typewritter:SetDirty()
			end

			if arg_285_1.time_ >= var_288_0 + var_288_7 and arg_285_1.time_ < var_288_0 + var_288_7 + arg_288_0 then
				arg_285_1.typewritter.percent = 1

				arg_285_1.typewritter:SetDirty()
				arg_285_1:ShowNextGo(true)
			end
		end

		arg_285_1.nodeConfigList_ = {}

		arg_285_1:InitPlayNodeList()
	end,
	Play114241071 = function(arg_289_0, arg_289_1)
		arg_289_1.time_ = 0
		arg_289_1.frameCnt_ = 0
		arg_289_1.state_ = "playing"
		arg_289_1.curTalkId_ = 114241071
		arg_289_1.duration_ = 5

		SetActive(arg_289_1.tipsGo_, false)

		function arg_289_1.onSingleLineFinish_()
			arg_289_1.onSingleLineUpdate_ = nil
			arg_289_1.onSingleLineFinish_ = nil
			arg_289_1.state_ = "waiting"
		end

		function arg_289_1.playNext_(arg_291_0)
			if arg_291_0 == 1 then
				arg_289_0:Play114241072(arg_289_1)
			end
		end

		function arg_289_1.onSingleLineUpdate_(arg_292_0)
			local var_292_0 = 0
			local var_292_1 = 1.325

			if var_292_0 < arg_289_1.time_ and arg_289_1.time_ <= var_292_0 + arg_292_0 then
				arg_289_1.talkMaxDuration = 0
				arg_289_1.dialogCg_.alpha = 1

				arg_289_1.dialog_:SetActive(true)
				SetActive(arg_289_1.leftNameGo_, false)

				arg_289_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_289_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_289_1:RecordName(arg_289_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_289_1.iconTrs_.gameObject, false)
				arg_289_1.callingController_:SetSelectedState("normal")

				local var_292_2 = arg_289_1:GetWordFromCfg(114241071)
				local var_292_3 = arg_289_1:FormatText(var_292_2.content)

				arg_289_1.text_.text = var_292_3

				LuaForUtil.ClearLinePrefixSymbol(arg_289_1.text_)

				local var_292_4 = 53
				local var_292_5 = utf8.len(var_292_3)
				local var_292_6 = var_292_4 <= 0 and var_292_1 or var_292_1 * (var_292_5 / var_292_4)

				if var_292_6 > 0 and var_292_1 < var_292_6 then
					arg_289_1.talkMaxDuration = var_292_6

					if var_292_6 + var_292_0 > arg_289_1.duration_ then
						arg_289_1.duration_ = var_292_6 + var_292_0
					end
				end

				arg_289_1.text_.text = var_292_3
				arg_289_1.typewritter.percent = 0

				arg_289_1.typewritter:SetDirty()
				arg_289_1:ShowNextGo(false)
				arg_289_1:RecordContent(arg_289_1.text_.text)
			end

			local var_292_7 = math.max(var_292_1, arg_289_1.talkMaxDuration)

			if var_292_0 <= arg_289_1.time_ and arg_289_1.time_ < var_292_0 + var_292_7 then
				arg_289_1.typewritter.percent = (arg_289_1.time_ - var_292_0) / var_292_7

				arg_289_1.typewritter:SetDirty()
			end

			if arg_289_1.time_ >= var_292_0 + var_292_7 and arg_289_1.time_ < var_292_0 + var_292_7 + arg_292_0 then
				arg_289_1.typewritter.percent = 1

				arg_289_1.typewritter:SetDirty()
				arg_289_1:ShowNextGo(true)
			end
		end

		arg_289_1.nodeConfigList_ = {}

		arg_289_1:InitPlayNodeList()
	end,
	Play114241072 = function(arg_293_0, arg_293_1)
		arg_293_1.time_ = 0
		arg_293_1.frameCnt_ = 0
		arg_293_1.state_ = "playing"
		arg_293_1.curTalkId_ = 114241072
		arg_293_1.duration_ = 5

		SetActive(arg_293_1.tipsGo_, false)

		function arg_293_1.onSingleLineFinish_()
			arg_293_1.onSingleLineUpdate_ = nil
			arg_293_1.onSingleLineFinish_ = nil
			arg_293_1.state_ = "waiting"
		end

		function arg_293_1.playNext_(arg_295_0)
			if arg_295_0 == 1 then
				arg_293_0:Play114241073(arg_293_1)
			end
		end

		function arg_293_1.onSingleLineUpdate_(arg_296_0)
			local var_296_0 = 0
			local var_296_1 = 1.05

			if var_296_0 < arg_293_1.time_ and arg_293_1.time_ <= var_296_0 + arg_296_0 then
				arg_293_1.talkMaxDuration = 0
				arg_293_1.dialogCg_.alpha = 1

				arg_293_1.dialog_:SetActive(true)
				SetActive(arg_293_1.leftNameGo_, false)

				arg_293_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_293_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_293_1:RecordName(arg_293_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_293_1.iconTrs_.gameObject, false)
				arg_293_1.callingController_:SetSelectedState("normal")

				local var_296_2 = arg_293_1:GetWordFromCfg(114241072)
				local var_296_3 = arg_293_1:FormatText(var_296_2.content)

				arg_293_1.text_.text = var_296_3

				LuaForUtil.ClearLinePrefixSymbol(arg_293_1.text_)

				local var_296_4 = 42
				local var_296_5 = utf8.len(var_296_3)
				local var_296_6 = var_296_4 <= 0 and var_296_1 or var_296_1 * (var_296_5 / var_296_4)

				if var_296_6 > 0 and var_296_1 < var_296_6 then
					arg_293_1.talkMaxDuration = var_296_6

					if var_296_6 + var_296_0 > arg_293_1.duration_ then
						arg_293_1.duration_ = var_296_6 + var_296_0
					end
				end

				arg_293_1.text_.text = var_296_3
				arg_293_1.typewritter.percent = 0

				arg_293_1.typewritter:SetDirty()
				arg_293_1:ShowNextGo(false)
				arg_293_1:RecordContent(arg_293_1.text_.text)
			end

			local var_296_7 = math.max(var_296_1, arg_293_1.talkMaxDuration)

			if var_296_0 <= arg_293_1.time_ and arg_293_1.time_ < var_296_0 + var_296_7 then
				arg_293_1.typewritter.percent = (arg_293_1.time_ - var_296_0) / var_296_7

				arg_293_1.typewritter:SetDirty()
			end

			if arg_293_1.time_ >= var_296_0 + var_296_7 and arg_293_1.time_ < var_296_0 + var_296_7 + arg_296_0 then
				arg_293_1.typewritter.percent = 1

				arg_293_1.typewritter:SetDirty()
				arg_293_1:ShowNextGo(true)
			end
		end

		arg_293_1.nodeConfigList_ = {}

		arg_293_1:InitPlayNodeList()
	end,
	Play114241073 = function(arg_297_0, arg_297_1)
		arg_297_1.time_ = 0
		arg_297_1.frameCnt_ = 0
		arg_297_1.state_ = "playing"
		arg_297_1.curTalkId_ = 114241073
		arg_297_1.duration_ = 9.43

		local var_297_0 = {
			ja = 9.433,
			ko = 7.8,
			zh = 8.5,
			en = 6.966
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
				arg_297_0:Play114241074(arg_297_1)
			end
		end

		function arg_297_1.onSingleLineUpdate_(arg_300_0)
			local var_300_0 = 0

			if var_300_0 < arg_297_1.time_ and arg_297_1.time_ <= var_300_0 + arg_300_0 then
				arg_297_1.mask_.enabled = true
				arg_297_1.mask_.raycastTarget = true

				arg_297_1:SetGaussion(false)
			end

			local var_300_1 = 2

			if var_300_0 <= arg_297_1.time_ and arg_297_1.time_ < var_300_0 + var_300_1 then
				local var_300_2 = (arg_297_1.time_ - var_300_0) / var_300_1
				local var_300_3 = Color.New(1, 1, 1)

				var_300_3.a = Mathf.Lerp(1, 0, var_300_2)
				arg_297_1.mask_.color = var_300_3
			end

			if arg_297_1.time_ >= var_300_0 + var_300_1 and arg_297_1.time_ < var_300_0 + var_300_1 + arg_300_0 then
				local var_300_4 = Color.New(1, 1, 1)
				local var_300_5 = 0

				arg_297_1.mask_.enabled = false
				var_300_4.a = var_300_5
				arg_297_1.mask_.color = var_300_4
			end

			local var_300_6 = "OM0505"

			if arg_297_1.bgs_[var_300_6] == nil then
				local var_300_7 = Object.Instantiate(arg_297_1.paintGo_)

				var_300_7:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. var_300_6)
				var_300_7.name = var_300_6
				var_300_7.transform.parent = arg_297_1.stage_.transform
				var_300_7.transform.localPosition = Vector3.New(0, 100, 0)
				arg_297_1.bgs_[var_300_6] = var_300_7
			end

			local var_300_8 = 0

			if var_300_8 < arg_297_1.time_ and arg_297_1.time_ <= var_300_8 + arg_300_0 then
				local var_300_9 = manager.ui.mainCamera.transform.localPosition
				local var_300_10 = Vector3.New(0, 0, 10) + Vector3.New(var_300_9.x, var_300_9.y, 0)
				local var_300_11 = arg_297_1.bgs_.OM0505

				var_300_11.transform.localPosition = var_300_10
				var_300_11.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_300_12 = var_300_11:GetComponent("SpriteRenderer")

				if var_300_12 and var_300_12.sprite then
					local var_300_13 = (var_300_11.transform.localPosition - var_300_9).z
					local var_300_14 = manager.ui.mainCameraCom_
					local var_300_15 = 2 * var_300_13 * Mathf.Tan(var_300_14.fieldOfView * 0.5 * Mathf.Deg2Rad)
					local var_300_16 = var_300_15 * var_300_14.aspect
					local var_300_17 = var_300_12.sprite.bounds.size.x
					local var_300_18 = var_300_12.sprite.bounds.size.y
					local var_300_19 = var_300_16 / var_300_17
					local var_300_20 = var_300_15 / var_300_18
					local var_300_21 = var_300_20 < var_300_19 and var_300_19 or var_300_20

					var_300_11.transform.localScale = Vector3.New(var_300_21, var_300_21, 0)
				end

				for iter_300_0, iter_300_1 in pairs(arg_297_1.bgs_) do
					if iter_300_0 ~= "OM0505" then
						iter_300_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			if arg_297_1.frameCnt_ <= 1 then
				arg_297_1.dialog_:SetActive(false)
			end

			local var_300_22 = 2
			local var_300_23 = 0.55

			if var_300_22 < arg_297_1.time_ and arg_297_1.time_ <= var_300_22 + arg_300_0 then
				arg_297_1.talkMaxDuration = 0

				arg_297_1.dialog_:SetActive(true)

				arg_297_1.dialogCg_.alpha = 0

				local var_300_24 = LeanTween.value(arg_297_1.dialog_, 0, 1, 0.3)

				var_300_24:setOnUpdate(LuaHelper.FloatAction(function(arg_301_0)
					arg_297_1.dialogCg_.alpha = arg_301_0
				end))
				var_300_24:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_297_1.dialog_)
					var_300_24:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_297_1.duration_ = arg_297_1.duration_ + 0.3

				SetActive(arg_297_1.leftNameGo_, true)

				local var_300_25 = arg_297_1:FormatText(StoryNameCfg[258].name)

				arg_297_1.leftNameTxt_.text = var_300_25

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_297_1.leftNameTxt_.transform)

				arg_297_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_297_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_297_1:RecordName(arg_297_1.leftNameTxt_.text)
				SetActive(arg_297_1.iconTrs_.gameObject, true)
				arg_297_1.iconController_:SetSelectedState("hero")

				arg_297_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_10018")

				arg_297_1.callingController_:SetSelectedState("normal")

				arg_297_1.keyicon_.color = Color.New(1, 1, 1)
				arg_297_1.icon_.color = Color.New(1, 1, 1)

				local var_300_26 = arg_297_1:GetWordFromCfg(114241073)
				local var_300_27 = arg_297_1:FormatText(var_300_26.content)

				arg_297_1.text_.text = var_300_27

				LuaForUtil.ClearLinePrefixSymbol(arg_297_1.text_)

				local var_300_28 = 22
				local var_300_29 = utf8.len(var_300_27)
				local var_300_30 = var_300_28 <= 0 and var_300_23 or var_300_23 * (var_300_29 / var_300_28)

				if var_300_30 > 0 and var_300_23 < var_300_30 then
					arg_297_1.talkMaxDuration = var_300_30
					var_300_22 = var_300_22 + 0.3

					if var_300_30 + var_300_22 > arg_297_1.duration_ then
						arg_297_1.duration_ = var_300_30 + var_300_22
					end
				end

				arg_297_1.text_.text = var_300_27
				arg_297_1.typewritter.percent = 0

				arg_297_1.typewritter:SetDirty()
				arg_297_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_114241", "114241073", "story_v_out_114241.awb") ~= 0 then
					local var_300_31 = manager.audio:GetVoiceLength("story_v_out_114241", "114241073", "story_v_out_114241.awb") / 1000

					if var_300_31 + var_300_22 > arg_297_1.duration_ then
						arg_297_1.duration_ = var_300_31 + var_300_22
					end

					if var_300_26.prefab_name ~= "" and arg_297_1.actors_[var_300_26.prefab_name] ~= nil then
						local var_300_32 = LuaForUtil.PlayVoiceWithCriLipsync(arg_297_1.actors_[var_300_26.prefab_name].transform, "story_v_out_114241", "114241073", "story_v_out_114241.awb")

						arg_297_1:RecordAudio("114241073", var_300_32)
						arg_297_1:RecordAudio("114241073", var_300_32)
					else
						arg_297_1:AudioAction("play", "voice", "story_v_out_114241", "114241073", "story_v_out_114241.awb")
					end

					arg_297_1:RecordHistoryTalkVoice("story_v_out_114241", "114241073", "story_v_out_114241.awb")
				end

				arg_297_1:RecordContent(arg_297_1.text_.text)
			end

			local var_300_33 = var_300_22 + 0.3
			local var_300_34 = math.max(var_300_23, arg_297_1.talkMaxDuration)

			if var_300_33 <= arg_297_1.time_ and arg_297_1.time_ < var_300_33 + var_300_34 then
				arg_297_1.typewritter.percent = (arg_297_1.time_ - var_300_33) / var_300_34

				arg_297_1.typewritter:SetDirty()
			end

			if arg_297_1.time_ >= var_300_33 + var_300_34 and arg_297_1.time_ < var_300_33 + var_300_34 + arg_300_0 then
				arg_297_1.typewritter.percent = 1

				arg_297_1.typewritter:SetDirty()
				arg_297_1:ShowNextGo(true)
			end
		end

		arg_297_1.nodeConfigList_ = {}

		arg_297_1:InitPlayNodeList()
	end,
	Play114241074 = function(arg_303_0, arg_303_1)
		arg_303_1.time_ = 0
		arg_303_1.frameCnt_ = 0
		arg_303_1.state_ = "playing"
		arg_303_1.curTalkId_ = 114241074
		arg_303_1.duration_ = 8.13

		local var_303_0 = {
			ja = 7.833,
			ko = 6.633,
			zh = 8.133,
			en = 5.733
		}
		local var_303_1 = manager.audio:GetLocalizationFlag()

		if var_303_0[var_303_1] ~= nil then
			arg_303_1.duration_ = var_303_0[var_303_1]
		end

		SetActive(arg_303_1.tipsGo_, false)

		function arg_303_1.onSingleLineFinish_()
			arg_303_1.onSingleLineUpdate_ = nil
			arg_303_1.onSingleLineFinish_ = nil
			arg_303_1.state_ = "waiting"
		end

		function arg_303_1.playNext_(arg_305_0)
			if arg_305_0 == 1 then
				arg_303_0:Play114241075(arg_303_1)
			end
		end

		function arg_303_1.onSingleLineUpdate_(arg_306_0)
			local var_306_0 = 0
			local var_306_1 = 0.85

			if var_306_0 < arg_303_1.time_ and arg_303_1.time_ <= var_306_0 + arg_306_0 then
				arg_303_1.talkMaxDuration = 0
				arg_303_1.dialogCg_.alpha = 1

				arg_303_1.dialog_:SetActive(true)
				SetActive(arg_303_1.leftNameGo_, true)

				local var_306_2 = arg_303_1:FormatText(StoryNameCfg[206].name)

				arg_303_1.leftNameTxt_.text = var_306_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_303_1.leftNameTxt_.transform)

				arg_303_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_303_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_303_1:RecordName(arg_303_1.leftNameTxt_.text)
				SetActive(arg_303_1.iconTrs_.gameObject, false)
				arg_303_1.callingController_:SetSelectedState("normal")

				local var_306_3 = arg_303_1:GetWordFromCfg(114241074)
				local var_306_4 = arg_303_1:FormatText(var_306_3.content)

				arg_303_1.text_.text = var_306_4

				LuaForUtil.ClearLinePrefixSymbol(arg_303_1.text_)

				local var_306_5 = 34
				local var_306_6 = utf8.len(var_306_4)
				local var_306_7 = var_306_5 <= 0 and var_306_1 or var_306_1 * (var_306_6 / var_306_5)

				if var_306_7 > 0 and var_306_1 < var_306_7 then
					arg_303_1.talkMaxDuration = var_306_7

					if var_306_7 + var_306_0 > arg_303_1.duration_ then
						arg_303_1.duration_ = var_306_7 + var_306_0
					end
				end

				arg_303_1.text_.text = var_306_4
				arg_303_1.typewritter.percent = 0

				arg_303_1.typewritter:SetDirty()
				arg_303_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_114241", "114241074", "story_v_out_114241.awb") ~= 0 then
					local var_306_8 = manager.audio:GetVoiceLength("story_v_out_114241", "114241074", "story_v_out_114241.awb") / 1000

					if var_306_8 + var_306_0 > arg_303_1.duration_ then
						arg_303_1.duration_ = var_306_8 + var_306_0
					end

					if var_306_3.prefab_name ~= "" and arg_303_1.actors_[var_306_3.prefab_name] ~= nil then
						local var_306_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_303_1.actors_[var_306_3.prefab_name].transform, "story_v_out_114241", "114241074", "story_v_out_114241.awb")

						arg_303_1:RecordAudio("114241074", var_306_9)
						arg_303_1:RecordAudio("114241074", var_306_9)
					else
						arg_303_1:AudioAction("play", "voice", "story_v_out_114241", "114241074", "story_v_out_114241.awb")
					end

					arg_303_1:RecordHistoryTalkVoice("story_v_out_114241", "114241074", "story_v_out_114241.awb")
				end

				arg_303_1:RecordContent(arg_303_1.text_.text)
			end

			local var_306_10 = math.max(var_306_1, arg_303_1.talkMaxDuration)

			if var_306_0 <= arg_303_1.time_ and arg_303_1.time_ < var_306_0 + var_306_10 then
				arg_303_1.typewritter.percent = (arg_303_1.time_ - var_306_0) / var_306_10

				arg_303_1.typewritter:SetDirty()
			end

			if arg_303_1.time_ >= var_306_0 + var_306_10 and arg_303_1.time_ < var_306_0 + var_306_10 + arg_306_0 then
				arg_303_1.typewritter.percent = 1

				arg_303_1.typewritter:SetDirty()
				arg_303_1:ShowNextGo(true)
			end
		end

		arg_303_1.nodeConfigList_ = {}

		arg_303_1:InitPlayNodeList()
	end,
	Play114241075 = function(arg_307_0, arg_307_1)
		arg_307_1.time_ = 0
		arg_307_1.frameCnt_ = 0
		arg_307_1.state_ = "playing"
		arg_307_1.curTalkId_ = 114241075
		arg_307_1.duration_ = 10.23

		local var_307_0 = {
			ja = 10.233,
			ko = 8.4,
			zh = 8.933,
			en = 9.8
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
				arg_307_0:Play114241076(arg_307_1)
			end
		end

		function arg_307_1.onSingleLineUpdate_(arg_310_0)
			local var_310_0 = 0
			local var_310_1 = 1.05

			if var_310_0 < arg_307_1.time_ and arg_307_1.time_ <= var_310_0 + arg_310_0 then
				arg_307_1.talkMaxDuration = 0
				arg_307_1.dialogCg_.alpha = 1

				arg_307_1.dialog_:SetActive(true)
				SetActive(arg_307_1.leftNameGo_, true)

				local var_310_2 = arg_307_1:FormatText(StoryNameCfg[258].name)

				arg_307_1.leftNameTxt_.text = var_310_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_307_1.leftNameTxt_.transform)

				arg_307_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_307_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_307_1:RecordName(arg_307_1.leftNameTxt_.text)
				SetActive(arg_307_1.iconTrs_.gameObject, true)
				arg_307_1.iconController_:SetSelectedState("hero")

				arg_307_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_10018")

				arg_307_1.callingController_:SetSelectedState("normal")

				arg_307_1.keyicon_.color = Color.New(1, 1, 1)
				arg_307_1.icon_.color = Color.New(1, 1, 1)

				local var_310_3 = arg_307_1:GetWordFromCfg(114241075)
				local var_310_4 = arg_307_1:FormatText(var_310_3.content)

				arg_307_1.text_.text = var_310_4

				LuaForUtil.ClearLinePrefixSymbol(arg_307_1.text_)

				local var_310_5 = 42
				local var_310_6 = utf8.len(var_310_4)
				local var_310_7 = var_310_5 <= 0 and var_310_1 or var_310_1 * (var_310_6 / var_310_5)

				if var_310_7 > 0 and var_310_1 < var_310_7 then
					arg_307_1.talkMaxDuration = var_310_7

					if var_310_7 + var_310_0 > arg_307_1.duration_ then
						arg_307_1.duration_ = var_310_7 + var_310_0
					end
				end

				arg_307_1.text_.text = var_310_4
				arg_307_1.typewritter.percent = 0

				arg_307_1.typewritter:SetDirty()
				arg_307_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_114241", "114241075", "story_v_out_114241.awb") ~= 0 then
					local var_310_8 = manager.audio:GetVoiceLength("story_v_out_114241", "114241075", "story_v_out_114241.awb") / 1000

					if var_310_8 + var_310_0 > arg_307_1.duration_ then
						arg_307_1.duration_ = var_310_8 + var_310_0
					end

					if var_310_3.prefab_name ~= "" and arg_307_1.actors_[var_310_3.prefab_name] ~= nil then
						local var_310_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_307_1.actors_[var_310_3.prefab_name].transform, "story_v_out_114241", "114241075", "story_v_out_114241.awb")

						arg_307_1:RecordAudio("114241075", var_310_9)
						arg_307_1:RecordAudio("114241075", var_310_9)
					else
						arg_307_1:AudioAction("play", "voice", "story_v_out_114241", "114241075", "story_v_out_114241.awb")
					end

					arg_307_1:RecordHistoryTalkVoice("story_v_out_114241", "114241075", "story_v_out_114241.awb")
				end

				arg_307_1:RecordContent(arg_307_1.text_.text)
			end

			local var_310_10 = math.max(var_310_1, arg_307_1.talkMaxDuration)

			if var_310_0 <= arg_307_1.time_ and arg_307_1.time_ < var_310_0 + var_310_10 then
				arg_307_1.typewritter.percent = (arg_307_1.time_ - var_310_0) / var_310_10

				arg_307_1.typewritter:SetDirty()
			end

			if arg_307_1.time_ >= var_310_0 + var_310_10 and arg_307_1.time_ < var_310_0 + var_310_10 + arg_310_0 then
				arg_307_1.typewritter.percent = 1

				arg_307_1.typewritter:SetDirty()
				arg_307_1:ShowNextGo(true)
			end
		end

		arg_307_1.nodeConfigList_ = {}

		arg_307_1:InitPlayNodeList()
	end,
	Play114241076 = function(arg_311_0, arg_311_1)
		arg_311_1.time_ = 0
		arg_311_1.frameCnt_ = 0
		arg_311_1.state_ = "playing"
		arg_311_1.curTalkId_ = 114241076
		arg_311_1.duration_ = 8.47

		local var_311_0 = {
			ja = 8.166,
			ko = 7.766,
			zh = 7.366,
			en = 8.466
		}
		local var_311_1 = manager.audio:GetLocalizationFlag()

		if var_311_0[var_311_1] ~= nil then
			arg_311_1.duration_ = var_311_0[var_311_1]
		end

		SetActive(arg_311_1.tipsGo_, false)

		function arg_311_1.onSingleLineFinish_()
			arg_311_1.onSingleLineUpdate_ = nil
			arg_311_1.onSingleLineFinish_ = nil
			arg_311_1.state_ = "waiting"
		end

		function arg_311_1.playNext_(arg_313_0)
			if arg_313_0 == 1 then
				arg_311_0:Play114241077(arg_311_1)
			end
		end

		function arg_311_1.onSingleLineUpdate_(arg_314_0)
			local var_314_0 = 0
			local var_314_1 = 0.875

			if var_314_0 < arg_311_1.time_ and arg_311_1.time_ <= var_314_0 + arg_314_0 then
				arg_311_1.talkMaxDuration = 0
				arg_311_1.dialogCg_.alpha = 1

				arg_311_1.dialog_:SetActive(true)
				SetActive(arg_311_1.leftNameGo_, true)

				local var_314_2 = arg_311_1:FormatText(StoryNameCfg[206].name)

				arg_311_1.leftNameTxt_.text = var_314_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_311_1.leftNameTxt_.transform)

				arg_311_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_311_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_311_1:RecordName(arg_311_1.leftNameTxt_.text)
				SetActive(arg_311_1.iconTrs_.gameObject, false)
				arg_311_1.callingController_:SetSelectedState("normal")

				local var_314_3 = arg_311_1:GetWordFromCfg(114241076)
				local var_314_4 = arg_311_1:FormatText(var_314_3.content)

				arg_311_1.text_.text = var_314_4

				LuaForUtil.ClearLinePrefixSymbol(arg_311_1.text_)

				local var_314_5 = 35
				local var_314_6 = utf8.len(var_314_4)
				local var_314_7 = var_314_5 <= 0 and var_314_1 or var_314_1 * (var_314_6 / var_314_5)

				if var_314_7 > 0 and var_314_1 < var_314_7 then
					arg_311_1.talkMaxDuration = var_314_7

					if var_314_7 + var_314_0 > arg_311_1.duration_ then
						arg_311_1.duration_ = var_314_7 + var_314_0
					end
				end

				arg_311_1.text_.text = var_314_4
				arg_311_1.typewritter.percent = 0

				arg_311_1.typewritter:SetDirty()
				arg_311_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_114241", "114241076", "story_v_out_114241.awb") ~= 0 then
					local var_314_8 = manager.audio:GetVoiceLength("story_v_out_114241", "114241076", "story_v_out_114241.awb") / 1000

					if var_314_8 + var_314_0 > arg_311_1.duration_ then
						arg_311_1.duration_ = var_314_8 + var_314_0
					end

					if var_314_3.prefab_name ~= "" and arg_311_1.actors_[var_314_3.prefab_name] ~= nil then
						local var_314_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_311_1.actors_[var_314_3.prefab_name].transform, "story_v_out_114241", "114241076", "story_v_out_114241.awb")

						arg_311_1:RecordAudio("114241076", var_314_9)
						arg_311_1:RecordAudio("114241076", var_314_9)
					else
						arg_311_1:AudioAction("play", "voice", "story_v_out_114241", "114241076", "story_v_out_114241.awb")
					end

					arg_311_1:RecordHistoryTalkVoice("story_v_out_114241", "114241076", "story_v_out_114241.awb")
				end

				arg_311_1:RecordContent(arg_311_1.text_.text)
			end

			local var_314_10 = math.max(var_314_1, arg_311_1.talkMaxDuration)

			if var_314_0 <= arg_311_1.time_ and arg_311_1.time_ < var_314_0 + var_314_10 then
				arg_311_1.typewritter.percent = (arg_311_1.time_ - var_314_0) / var_314_10

				arg_311_1.typewritter:SetDirty()
			end

			if arg_311_1.time_ >= var_314_0 + var_314_10 and arg_311_1.time_ < var_314_0 + var_314_10 + arg_314_0 then
				arg_311_1.typewritter.percent = 1

				arg_311_1.typewritter:SetDirty()
				arg_311_1:ShowNextGo(true)
			end
		end

		arg_311_1.nodeConfigList_ = {}

		arg_311_1:InitPlayNodeList()
	end,
	Play114241077 = function(arg_315_0, arg_315_1)
		arg_315_1.time_ = 0
		arg_315_1.frameCnt_ = 0
		arg_315_1.state_ = "playing"
		arg_315_1.curTalkId_ = 114241077
		arg_315_1.duration_ = 13.53

		local var_315_0 = {
			ja = 13.533,
			ko = 10.933,
			zh = 12.1,
			en = 9.566
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
				arg_315_0:Play114241078(arg_315_1)
			end
		end

		function arg_315_1.onSingleLineUpdate_(arg_318_0)
			local var_318_0 = 0
			local var_318_1 = 1.25

			if var_318_0 < arg_315_1.time_ and arg_315_1.time_ <= var_318_0 + arg_318_0 then
				arg_315_1.talkMaxDuration = 0
				arg_315_1.dialogCg_.alpha = 1

				arg_315_1.dialog_:SetActive(true)
				SetActive(arg_315_1.leftNameGo_, true)

				local var_318_2 = arg_315_1:FormatText(StoryNameCfg[258].name)

				arg_315_1.leftNameTxt_.text = var_318_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_315_1.leftNameTxt_.transform)

				arg_315_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_315_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_315_1:RecordName(arg_315_1.leftNameTxt_.text)
				SetActive(arg_315_1.iconTrs_.gameObject, true)
				arg_315_1.iconController_:SetSelectedState("hero")

				arg_315_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_10018")

				arg_315_1.callingController_:SetSelectedState("normal")

				arg_315_1.keyicon_.color = Color.New(1, 1, 1)
				arg_315_1.icon_.color = Color.New(1, 1, 1)

				local var_318_3 = arg_315_1:GetWordFromCfg(114241077)
				local var_318_4 = arg_315_1:FormatText(var_318_3.content)

				arg_315_1.text_.text = var_318_4

				LuaForUtil.ClearLinePrefixSymbol(arg_315_1.text_)

				local var_318_5 = 50
				local var_318_6 = utf8.len(var_318_4)
				local var_318_7 = var_318_5 <= 0 and var_318_1 or var_318_1 * (var_318_6 / var_318_5)

				if var_318_7 > 0 and var_318_1 < var_318_7 then
					arg_315_1.talkMaxDuration = var_318_7

					if var_318_7 + var_318_0 > arg_315_1.duration_ then
						arg_315_1.duration_ = var_318_7 + var_318_0
					end
				end

				arg_315_1.text_.text = var_318_4
				arg_315_1.typewritter.percent = 0

				arg_315_1.typewritter:SetDirty()
				arg_315_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_114241", "114241077", "story_v_out_114241.awb") ~= 0 then
					local var_318_8 = manager.audio:GetVoiceLength("story_v_out_114241", "114241077", "story_v_out_114241.awb") / 1000

					if var_318_8 + var_318_0 > arg_315_1.duration_ then
						arg_315_1.duration_ = var_318_8 + var_318_0
					end

					if var_318_3.prefab_name ~= "" and arg_315_1.actors_[var_318_3.prefab_name] ~= nil then
						local var_318_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_315_1.actors_[var_318_3.prefab_name].transform, "story_v_out_114241", "114241077", "story_v_out_114241.awb")

						arg_315_1:RecordAudio("114241077", var_318_9)
						arg_315_1:RecordAudio("114241077", var_318_9)
					else
						arg_315_1:AudioAction("play", "voice", "story_v_out_114241", "114241077", "story_v_out_114241.awb")
					end

					arg_315_1:RecordHistoryTalkVoice("story_v_out_114241", "114241077", "story_v_out_114241.awb")
				end

				arg_315_1:RecordContent(arg_315_1.text_.text)
			end

			local var_318_10 = math.max(var_318_1, arg_315_1.talkMaxDuration)

			if var_318_0 <= arg_315_1.time_ and arg_315_1.time_ < var_318_0 + var_318_10 then
				arg_315_1.typewritter.percent = (arg_315_1.time_ - var_318_0) / var_318_10

				arg_315_1.typewritter:SetDirty()
			end

			if arg_315_1.time_ >= var_318_0 + var_318_10 and arg_315_1.time_ < var_318_0 + var_318_10 + arg_318_0 then
				arg_315_1.typewritter.percent = 1

				arg_315_1.typewritter:SetDirty()
				arg_315_1:ShowNextGo(true)
			end
		end

		arg_315_1.nodeConfigList_ = {}

		arg_315_1:InitPlayNodeList()
	end,
	Play114241078 = function(arg_319_0, arg_319_1)
		arg_319_1.time_ = 0
		arg_319_1.frameCnt_ = 0
		arg_319_1.state_ = "playing"
		arg_319_1.curTalkId_ = 114241078
		arg_319_1.duration_ = 8

		local var_319_0 = {
			ja = 8,
			ko = 4.966,
			zh = 6.433,
			en = 6.766
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
				arg_319_0:Play114241079(arg_319_1)
			end
		end

		function arg_319_1.onSingleLineUpdate_(arg_322_0)
			local var_322_0 = 0
			local var_322_1 = 0.65

			if var_322_0 < arg_319_1.time_ and arg_319_1.time_ <= var_322_0 + arg_322_0 then
				arg_319_1.talkMaxDuration = 0
				arg_319_1.dialogCg_.alpha = 1

				arg_319_1.dialog_:SetActive(true)
				SetActive(arg_319_1.leftNameGo_, true)

				local var_322_2 = arg_319_1:FormatText(StoryNameCfg[258].name)

				arg_319_1.leftNameTxt_.text = var_322_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_319_1.leftNameTxt_.transform)

				arg_319_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_319_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_319_1:RecordName(arg_319_1.leftNameTxt_.text)
				SetActive(arg_319_1.iconTrs_.gameObject, true)
				arg_319_1.iconController_:SetSelectedState("hero")

				arg_319_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_10018")

				arg_319_1.callingController_:SetSelectedState("normal")

				arg_319_1.keyicon_.color = Color.New(1, 1, 1)
				arg_319_1.icon_.color = Color.New(1, 1, 1)

				local var_322_3 = arg_319_1:GetWordFromCfg(114241078)
				local var_322_4 = arg_319_1:FormatText(var_322_3.content)

				arg_319_1.text_.text = var_322_4

				LuaForUtil.ClearLinePrefixSymbol(arg_319_1.text_)

				local var_322_5 = 26
				local var_322_6 = utf8.len(var_322_4)
				local var_322_7 = var_322_5 <= 0 and var_322_1 or var_322_1 * (var_322_6 / var_322_5)

				if var_322_7 > 0 and var_322_1 < var_322_7 then
					arg_319_1.talkMaxDuration = var_322_7

					if var_322_7 + var_322_0 > arg_319_1.duration_ then
						arg_319_1.duration_ = var_322_7 + var_322_0
					end
				end

				arg_319_1.text_.text = var_322_4
				arg_319_1.typewritter.percent = 0

				arg_319_1.typewritter:SetDirty()
				arg_319_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_114241", "114241078", "story_v_out_114241.awb") ~= 0 then
					local var_322_8 = manager.audio:GetVoiceLength("story_v_out_114241", "114241078", "story_v_out_114241.awb") / 1000

					if var_322_8 + var_322_0 > arg_319_1.duration_ then
						arg_319_1.duration_ = var_322_8 + var_322_0
					end

					if var_322_3.prefab_name ~= "" and arg_319_1.actors_[var_322_3.prefab_name] ~= nil then
						local var_322_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_319_1.actors_[var_322_3.prefab_name].transform, "story_v_out_114241", "114241078", "story_v_out_114241.awb")

						arg_319_1:RecordAudio("114241078", var_322_9)
						arg_319_1:RecordAudio("114241078", var_322_9)
					else
						arg_319_1:AudioAction("play", "voice", "story_v_out_114241", "114241078", "story_v_out_114241.awb")
					end

					arg_319_1:RecordHistoryTalkVoice("story_v_out_114241", "114241078", "story_v_out_114241.awb")
				end

				arg_319_1:RecordContent(arg_319_1.text_.text)
			end

			local var_322_10 = math.max(var_322_1, arg_319_1.talkMaxDuration)

			if var_322_0 <= arg_319_1.time_ and arg_319_1.time_ < var_322_0 + var_322_10 then
				arg_319_1.typewritter.percent = (arg_319_1.time_ - var_322_0) / var_322_10

				arg_319_1.typewritter:SetDirty()
			end

			if arg_319_1.time_ >= var_322_0 + var_322_10 and arg_319_1.time_ < var_322_0 + var_322_10 + arg_322_0 then
				arg_319_1.typewritter.percent = 1

				arg_319_1.typewritter:SetDirty()
				arg_319_1:ShowNextGo(true)
			end
		end

		arg_319_1.nodeConfigList_ = {}

		arg_319_1:InitPlayNodeList()
	end,
	Play114241079 = function(arg_323_0, arg_323_1)
		arg_323_1.time_ = 0
		arg_323_1.frameCnt_ = 0
		arg_323_1.state_ = "playing"
		arg_323_1.curTalkId_ = 114241079
		arg_323_1.duration_ = 10.87

		local var_323_0 = {
			ja = 6.4,
			ko = 7.233,
			zh = 10.866,
			en = 9.4
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
				arg_323_0:Play114241080(arg_323_1)
			end
		end

		function arg_323_1.onSingleLineUpdate_(arg_326_0)
			local var_326_0 = 0
			local var_326_1 = 1.175

			if var_326_0 < arg_323_1.time_ and arg_323_1.time_ <= var_326_0 + arg_326_0 then
				arg_323_1.talkMaxDuration = 0
				arg_323_1.dialogCg_.alpha = 1

				arg_323_1.dialog_:SetActive(true)
				SetActive(arg_323_1.leftNameGo_, true)

				local var_326_2 = arg_323_1:FormatText(StoryNameCfg[206].name)

				arg_323_1.leftNameTxt_.text = var_326_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_323_1.leftNameTxt_.transform)

				arg_323_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_323_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_323_1:RecordName(arg_323_1.leftNameTxt_.text)
				SetActive(arg_323_1.iconTrs_.gameObject, false)
				arg_323_1.callingController_:SetSelectedState("normal")

				local var_326_3 = arg_323_1:GetWordFromCfg(114241079)
				local var_326_4 = arg_323_1:FormatText(var_326_3.content)

				arg_323_1.text_.text = var_326_4

				LuaForUtil.ClearLinePrefixSymbol(arg_323_1.text_)

				local var_326_5 = 47
				local var_326_6 = utf8.len(var_326_4)
				local var_326_7 = var_326_5 <= 0 and var_326_1 or var_326_1 * (var_326_6 / var_326_5)

				if var_326_7 > 0 and var_326_1 < var_326_7 then
					arg_323_1.talkMaxDuration = var_326_7

					if var_326_7 + var_326_0 > arg_323_1.duration_ then
						arg_323_1.duration_ = var_326_7 + var_326_0
					end
				end

				arg_323_1.text_.text = var_326_4
				arg_323_1.typewritter.percent = 0

				arg_323_1.typewritter:SetDirty()
				arg_323_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_114241", "114241079", "story_v_out_114241.awb") ~= 0 then
					local var_326_8 = manager.audio:GetVoiceLength("story_v_out_114241", "114241079", "story_v_out_114241.awb") / 1000

					if var_326_8 + var_326_0 > arg_323_1.duration_ then
						arg_323_1.duration_ = var_326_8 + var_326_0
					end

					if var_326_3.prefab_name ~= "" and arg_323_1.actors_[var_326_3.prefab_name] ~= nil then
						local var_326_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_323_1.actors_[var_326_3.prefab_name].transform, "story_v_out_114241", "114241079", "story_v_out_114241.awb")

						arg_323_1:RecordAudio("114241079", var_326_9)
						arg_323_1:RecordAudio("114241079", var_326_9)
					else
						arg_323_1:AudioAction("play", "voice", "story_v_out_114241", "114241079", "story_v_out_114241.awb")
					end

					arg_323_1:RecordHistoryTalkVoice("story_v_out_114241", "114241079", "story_v_out_114241.awb")
				end

				arg_323_1:RecordContent(arg_323_1.text_.text)
			end

			local var_326_10 = math.max(var_326_1, arg_323_1.talkMaxDuration)

			if var_326_0 <= arg_323_1.time_ and arg_323_1.time_ < var_326_0 + var_326_10 then
				arg_323_1.typewritter.percent = (arg_323_1.time_ - var_326_0) / var_326_10

				arg_323_1.typewritter:SetDirty()
			end

			if arg_323_1.time_ >= var_326_0 + var_326_10 and arg_323_1.time_ < var_326_0 + var_326_10 + arg_326_0 then
				arg_323_1.typewritter.percent = 1

				arg_323_1.typewritter:SetDirty()
				arg_323_1:ShowNextGo(true)
			end
		end

		arg_323_1.nodeConfigList_ = {}

		arg_323_1:InitPlayNodeList()
	end,
	Play114241080 = function(arg_327_0, arg_327_1)
		arg_327_1.time_ = 0
		arg_327_1.frameCnt_ = 0
		arg_327_1.state_ = "playing"
		arg_327_1.curTalkId_ = 114241080
		arg_327_1.duration_ = 5.13

		local var_327_0 = {
			ja = 5.133,
			ko = 4.2,
			zh = 4.833,
			en = 4.133
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
				arg_327_0:Play114241081(arg_327_1)
			end
		end

		function arg_327_1.onSingleLineUpdate_(arg_330_0)
			local var_330_0 = 0
			local var_330_1 = 0.5

			if var_330_0 < arg_327_1.time_ and arg_327_1.time_ <= var_330_0 + arg_330_0 then
				arg_327_1.talkMaxDuration = 0
				arg_327_1.dialogCg_.alpha = 1

				arg_327_1.dialog_:SetActive(true)
				SetActive(arg_327_1.leftNameGo_, true)

				local var_330_2 = arg_327_1:FormatText(StoryNameCfg[258].name)

				arg_327_1.leftNameTxt_.text = var_330_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_327_1.leftNameTxt_.transform)

				arg_327_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_327_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_327_1:RecordName(arg_327_1.leftNameTxt_.text)
				SetActive(arg_327_1.iconTrs_.gameObject, true)
				arg_327_1.iconController_:SetSelectedState("hero")

				arg_327_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_10018")

				arg_327_1.callingController_:SetSelectedState("normal")

				arg_327_1.keyicon_.color = Color.New(1, 1, 1)
				arg_327_1.icon_.color = Color.New(1, 1, 1)

				local var_330_3 = arg_327_1:GetWordFromCfg(114241080)
				local var_330_4 = arg_327_1:FormatText(var_330_3.content)

				arg_327_1.text_.text = var_330_4

				LuaForUtil.ClearLinePrefixSymbol(arg_327_1.text_)

				local var_330_5 = 20
				local var_330_6 = utf8.len(var_330_4)
				local var_330_7 = var_330_5 <= 0 and var_330_1 or var_330_1 * (var_330_6 / var_330_5)

				if var_330_7 > 0 and var_330_1 < var_330_7 then
					arg_327_1.talkMaxDuration = var_330_7

					if var_330_7 + var_330_0 > arg_327_1.duration_ then
						arg_327_1.duration_ = var_330_7 + var_330_0
					end
				end

				arg_327_1.text_.text = var_330_4
				arg_327_1.typewritter.percent = 0

				arg_327_1.typewritter:SetDirty()
				arg_327_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_114241", "114241080", "story_v_out_114241.awb") ~= 0 then
					local var_330_8 = manager.audio:GetVoiceLength("story_v_out_114241", "114241080", "story_v_out_114241.awb") / 1000

					if var_330_8 + var_330_0 > arg_327_1.duration_ then
						arg_327_1.duration_ = var_330_8 + var_330_0
					end

					if var_330_3.prefab_name ~= "" and arg_327_1.actors_[var_330_3.prefab_name] ~= nil then
						local var_330_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_327_1.actors_[var_330_3.prefab_name].transform, "story_v_out_114241", "114241080", "story_v_out_114241.awb")

						arg_327_1:RecordAudio("114241080", var_330_9)
						arg_327_1:RecordAudio("114241080", var_330_9)
					else
						arg_327_1:AudioAction("play", "voice", "story_v_out_114241", "114241080", "story_v_out_114241.awb")
					end

					arg_327_1:RecordHistoryTalkVoice("story_v_out_114241", "114241080", "story_v_out_114241.awb")
				end

				arg_327_1:RecordContent(arg_327_1.text_.text)
			end

			local var_330_10 = math.max(var_330_1, arg_327_1.talkMaxDuration)

			if var_330_0 <= arg_327_1.time_ and arg_327_1.time_ < var_330_0 + var_330_10 then
				arg_327_1.typewritter.percent = (arg_327_1.time_ - var_330_0) / var_330_10

				arg_327_1.typewritter:SetDirty()
			end

			if arg_327_1.time_ >= var_330_0 + var_330_10 and arg_327_1.time_ < var_330_0 + var_330_10 + arg_330_0 then
				arg_327_1.typewritter.percent = 1

				arg_327_1.typewritter:SetDirty()
				arg_327_1:ShowNextGo(true)
			end
		end

		arg_327_1.nodeConfigList_ = {}

		arg_327_1:InitPlayNodeList()
	end,
	Play114241081 = function(arg_331_0, arg_331_1)
		arg_331_1.time_ = 0
		arg_331_1.frameCnt_ = 0
		arg_331_1.state_ = "playing"
		arg_331_1.curTalkId_ = 114241081
		arg_331_1.duration_ = 6.8

		local var_331_0 = {
			ja = 6.8,
			ko = 4.566,
			zh = 5.866,
			en = 4.233
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
				arg_331_0:Play114241082(arg_331_1)
			end
		end

		function arg_331_1.onSingleLineUpdate_(arg_334_0)
			local var_334_0 = 0
			local var_334_1 = 0.65

			if var_334_0 < arg_331_1.time_ and arg_331_1.time_ <= var_334_0 + arg_334_0 then
				arg_331_1.talkMaxDuration = 0
				arg_331_1.dialogCg_.alpha = 1

				arg_331_1.dialog_:SetActive(true)
				SetActive(arg_331_1.leftNameGo_, true)

				local var_334_2 = arg_331_1:FormatText(StoryNameCfg[206].name)

				arg_331_1.leftNameTxt_.text = var_334_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_331_1.leftNameTxt_.transform)

				arg_331_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_331_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_331_1:RecordName(arg_331_1.leftNameTxt_.text)
				SetActive(arg_331_1.iconTrs_.gameObject, false)
				arg_331_1.callingController_:SetSelectedState("normal")

				local var_334_3 = arg_331_1:GetWordFromCfg(114241081)
				local var_334_4 = arg_331_1:FormatText(var_334_3.content)

				arg_331_1.text_.text = var_334_4

				LuaForUtil.ClearLinePrefixSymbol(arg_331_1.text_)

				local var_334_5 = 26
				local var_334_6 = utf8.len(var_334_4)
				local var_334_7 = var_334_5 <= 0 and var_334_1 or var_334_1 * (var_334_6 / var_334_5)

				if var_334_7 > 0 and var_334_1 < var_334_7 then
					arg_331_1.talkMaxDuration = var_334_7

					if var_334_7 + var_334_0 > arg_331_1.duration_ then
						arg_331_1.duration_ = var_334_7 + var_334_0
					end
				end

				arg_331_1.text_.text = var_334_4
				arg_331_1.typewritter.percent = 0

				arg_331_1.typewritter:SetDirty()
				arg_331_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_114241", "114241081", "story_v_out_114241.awb") ~= 0 then
					local var_334_8 = manager.audio:GetVoiceLength("story_v_out_114241", "114241081", "story_v_out_114241.awb") / 1000

					if var_334_8 + var_334_0 > arg_331_1.duration_ then
						arg_331_1.duration_ = var_334_8 + var_334_0
					end

					if var_334_3.prefab_name ~= "" and arg_331_1.actors_[var_334_3.prefab_name] ~= nil then
						local var_334_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_331_1.actors_[var_334_3.prefab_name].transform, "story_v_out_114241", "114241081", "story_v_out_114241.awb")

						arg_331_1:RecordAudio("114241081", var_334_9)
						arg_331_1:RecordAudio("114241081", var_334_9)
					else
						arg_331_1:AudioAction("play", "voice", "story_v_out_114241", "114241081", "story_v_out_114241.awb")
					end

					arg_331_1:RecordHistoryTalkVoice("story_v_out_114241", "114241081", "story_v_out_114241.awb")
				end

				arg_331_1:RecordContent(arg_331_1.text_.text)
			end

			local var_334_10 = math.max(var_334_1, arg_331_1.talkMaxDuration)

			if var_334_0 <= arg_331_1.time_ and arg_331_1.time_ < var_334_0 + var_334_10 then
				arg_331_1.typewritter.percent = (arg_331_1.time_ - var_334_0) / var_334_10

				arg_331_1.typewritter:SetDirty()
			end

			if arg_331_1.time_ >= var_334_0 + var_334_10 and arg_331_1.time_ < var_334_0 + var_334_10 + arg_334_0 then
				arg_331_1.typewritter.percent = 1

				arg_331_1.typewritter:SetDirty()
				arg_331_1:ShowNextGo(true)
			end
		end

		arg_331_1.nodeConfigList_ = {}

		arg_331_1:InitPlayNodeList()
	end,
	Play114241082 = function(arg_335_0, arg_335_1)
		arg_335_1.time_ = 0
		arg_335_1.frameCnt_ = 0
		arg_335_1.state_ = "playing"
		arg_335_1.curTalkId_ = 114241082
		arg_335_1.duration_ = 7.1

		local var_335_0 = {
			ja = 7.1,
			ko = 3.7,
			zh = 3.8,
			en = 2.9
		}
		local var_335_1 = manager.audio:GetLocalizationFlag()

		if var_335_0[var_335_1] ~= nil then
			arg_335_1.duration_ = var_335_0[var_335_1]
		end

		SetActive(arg_335_1.tipsGo_, false)

		function arg_335_1.onSingleLineFinish_()
			arg_335_1.onSingleLineUpdate_ = nil
			arg_335_1.onSingleLineFinish_ = nil
			arg_335_1.state_ = "waiting"
			arg_335_1.auto_ = false
		end

		function arg_335_1.playNext_(arg_337_0)
			arg_335_1.onStoryFinished_()
		end

		function arg_335_1.onSingleLineUpdate_(arg_338_0)
			local var_338_0 = 0
			local var_338_1 = 0.25

			if var_338_0 < arg_335_1.time_ and arg_335_1.time_ <= var_338_0 + arg_338_0 then
				arg_335_1.talkMaxDuration = 0
				arg_335_1.dialogCg_.alpha = 1

				arg_335_1.dialog_:SetActive(true)
				SetActive(arg_335_1.leftNameGo_, true)

				local var_338_2 = arg_335_1:FormatText(StoryNameCfg[258].name)

				arg_335_1.leftNameTxt_.text = var_338_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_335_1.leftNameTxt_.transform)

				arg_335_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_335_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_335_1:RecordName(arg_335_1.leftNameTxt_.text)
				SetActive(arg_335_1.iconTrs_.gameObject, true)
				arg_335_1.iconController_:SetSelectedState("hero")

				arg_335_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_10018")

				arg_335_1.callingController_:SetSelectedState("normal")

				arg_335_1.keyicon_.color = Color.New(1, 1, 1)
				arg_335_1.icon_.color = Color.New(1, 1, 1)

				local var_338_3 = arg_335_1:GetWordFromCfg(114241082)
				local var_338_4 = arg_335_1:FormatText(var_338_3.content)

				arg_335_1.text_.text = var_338_4

				LuaForUtil.ClearLinePrefixSymbol(arg_335_1.text_)

				local var_338_5 = 10
				local var_338_6 = utf8.len(var_338_4)
				local var_338_7 = var_338_5 <= 0 and var_338_1 or var_338_1 * (var_338_6 / var_338_5)

				if var_338_7 > 0 and var_338_1 < var_338_7 then
					arg_335_1.talkMaxDuration = var_338_7

					if var_338_7 + var_338_0 > arg_335_1.duration_ then
						arg_335_1.duration_ = var_338_7 + var_338_0
					end
				end

				arg_335_1.text_.text = var_338_4
				arg_335_1.typewritter.percent = 0

				arg_335_1.typewritter:SetDirty()
				arg_335_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_114241", "114241082", "story_v_out_114241.awb") ~= 0 then
					local var_338_8 = manager.audio:GetVoiceLength("story_v_out_114241", "114241082", "story_v_out_114241.awb") / 1000

					if var_338_8 + var_338_0 > arg_335_1.duration_ then
						arg_335_1.duration_ = var_338_8 + var_338_0
					end

					if var_338_3.prefab_name ~= "" and arg_335_1.actors_[var_338_3.prefab_name] ~= nil then
						local var_338_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_335_1.actors_[var_338_3.prefab_name].transform, "story_v_out_114241", "114241082", "story_v_out_114241.awb")

						arg_335_1:RecordAudio("114241082", var_338_9)
						arg_335_1:RecordAudio("114241082", var_338_9)
					else
						arg_335_1:AudioAction("play", "voice", "story_v_out_114241", "114241082", "story_v_out_114241.awb")
					end

					arg_335_1:RecordHistoryTalkVoice("story_v_out_114241", "114241082", "story_v_out_114241.awb")
				end

				arg_335_1:RecordContent(arg_335_1.text_.text)
			end

			local var_338_10 = math.max(var_338_1, arg_335_1.talkMaxDuration)

			if var_338_0 <= arg_335_1.time_ and arg_335_1.time_ < var_338_0 + var_338_10 then
				arg_335_1.typewritter.percent = (arg_335_1.time_ - var_338_0) / var_338_10

				arg_335_1.typewritter:SetDirty()
			end

			if arg_335_1.time_ >= var_338_0 + var_338_10 and arg_335_1.time_ < var_338_0 + var_338_10 + arg_338_0 then
				arg_335_1.typewritter.percent = 1

				arg_335_1.typewritter:SetDirty()
				arg_335_1:ShowNextGo(true)
			end
		end

		arg_335_1.nodeConfigList_ = {}

		arg_335_1:InitPlayNodeList()
	end,
	assets = {
		"TextureConfig/Background/ST25",
		"TextureConfig/Background/ST23",
		"TextureConfig/Background/F04",
		"TextureConfig/Background/OM0505"
	},
	voices = {
		"story_v_out_114241.awb"
	}
}
