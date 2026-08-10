return {
	Play416071001 = function(arg_1_0, arg_1_1)
		arg_1_1.time_ = 0
		arg_1_1.frameCnt_ = 0
		arg_1_1.state_ = "playing"
		arg_1_1.curTalkId_ = 416071001
		arg_1_1.duration_ = 7.5

		local var_1_0 = {
			zh = 5.766,
			ja = 7.5
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
				arg_1_0:Play416071002(arg_1_1)
			end
		end

		function arg_1_1.onSingleLineUpdate_(arg_4_0)
			local var_4_0 = 2

			if var_4_0 < arg_1_1.time_ and arg_1_1.time_ <= var_4_0 + arg_4_0 then
				arg_1_1.allBtn_.enabled = false
			end

			local var_4_1 = 0.3

			if arg_1_1.time_ >= var_4_0 + var_4_1 and arg_1_1.time_ < var_4_0 + var_4_1 + arg_4_0 then
				arg_1_1.allBtn_.enabled = true
			end

			local var_4_2 = "I14f"

			if arg_1_1.bgs_[var_4_2] == nil then
				local var_4_3 = Object.Instantiate(arg_1_1.paintGo_)

				var_4_3:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. var_4_2)
				var_4_3.name = var_4_2
				var_4_3.transform.parent = arg_1_1.stage_.transform
				var_4_3.transform.localPosition = Vector3.New(0, 100, 0)
				arg_1_1.bgs_[var_4_2] = var_4_3
			end

			local var_4_4 = 0

			if var_4_4 < arg_1_1.time_ and arg_1_1.time_ <= var_4_4 + arg_4_0 then
				local var_4_5 = manager.ui.mainCamera.transform.localPosition
				local var_4_6 = Vector3.New(0, 0, 10) + Vector3.New(var_4_5.x, var_4_5.y, 0)
				local var_4_7 = arg_1_1.bgs_.I14f

				var_4_7.transform.localPosition = var_4_6
				var_4_7.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_4_8 = var_4_7:GetComponent("SpriteRenderer")

				if var_4_8 and var_4_8.sprite then
					local var_4_9 = (var_4_7.transform.localPosition - var_4_5).z
					local var_4_10 = manager.ui.mainCameraCom_
					local var_4_11 = 2 * var_4_9 * Mathf.Tan(var_4_10.fieldOfView * 0.5 * Mathf.Deg2Rad)
					local var_4_12 = var_4_11 * var_4_10.aspect
					local var_4_13 = var_4_8.sprite.bounds.size.x
					local var_4_14 = var_4_8.sprite.bounds.size.y
					local var_4_15 = var_4_12 / var_4_13
					local var_4_16 = var_4_11 / var_4_14
					local var_4_17 = var_4_16 < var_4_15 and var_4_15 or var_4_16

					var_4_7.transform.localScale = Vector3.New(var_4_17, var_4_17, 0)
				end

				for iter_4_0, iter_4_1 in pairs(arg_1_1.bgs_) do
					if iter_4_0 ~= "I14f" then
						iter_4_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
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

			local var_4_24 = "1148"

			if arg_1_1.actors_[var_4_24] == nil then
				local var_4_25 = Asset.Load("Widget/System/Story/StoryExpression/" .. "1148")

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

			local var_4_28 = arg_1_1.actors_["1148"].transform
			local var_4_29 = 1.66666666666667

			if var_4_29 < arg_1_1.time_ and arg_1_1.time_ <= var_4_29 + arg_4_0 then
				arg_1_1.var_.moveOldPos1148 = var_4_28.localPosition
				var_4_28.localScale = Vector3.New(1, 1, 1)

				arg_1_1:CheckSpriteTmpPos("1148", 3)

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
				local var_4_34 = Vector3.New(0, -429, -180)

				var_4_28.localPosition = Vector3.Lerp(arg_1_1.var_.moveOldPos1148, var_4_34, var_4_33)
			end

			if arg_1_1.time_ >= var_4_29 + var_4_32 and arg_1_1.time_ < var_4_29 + var_4_32 + arg_4_0 then
				var_4_28.localPosition = Vector3.New(0, -429, -180)
			end

			local var_4_35 = arg_1_1.actors_["1148"]
			local var_4_36 = 1.66666666666667

			if var_4_36 < arg_1_1.time_ and arg_1_1.time_ <= var_4_36 + arg_4_0 and not isNil(var_4_35) and arg_1_1.var_.actorSpriteComps1148 == nil then
				arg_1_1.var_.actorSpriteComps1148 = var_4_35:GetComponentsInChildren(typeof(Image), true)
			end

			local var_4_37 = 0.125

			if var_4_36 <= arg_1_1.time_ and arg_1_1.time_ < var_4_36 + var_4_37 and not isNil(var_4_35) then
				local var_4_38 = (arg_1_1.time_ - var_4_36) / var_4_37

				if arg_1_1.var_.actorSpriteComps1148 then
					for iter_4_5, iter_4_6 in pairs(arg_1_1.var_.actorSpriteComps1148:ToTable()) do
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

			if arg_1_1.time_ >= var_4_36 + var_4_37 and arg_1_1.time_ < var_4_36 + var_4_37 + arg_4_0 and not isNil(var_4_35) and arg_1_1.var_.actorSpriteComps1148 then
				for iter_4_7, iter_4_8 in pairs(arg_1_1.var_.actorSpriteComps1148:ToTable()) do
					if iter_4_8 then
						if arg_1_1.isInRecall_ then
							iter_4_8.color = arg_1_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_4_8.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_1_1.var_.actorSpriteComps1148 = nil
			end

			local var_4_43 = arg_1_1.actors_["1148"]
			local var_4_44 = 1.66666666666667

			if var_4_44 < arg_1_1.time_ and arg_1_1.time_ <= var_4_44 + arg_4_0 then
				local var_4_45 = var_4_43:GetComponentInChildren(typeof(CanvasGroup))

				if var_4_45 then
					arg_1_1.var_.alphaOldValue1148 = var_4_45.alpha
					arg_1_1.var_.characterEffect1148 = var_4_45
				end

				arg_1_1.var_.alphaOldValue1148 = 0
			end

			local var_4_46 = 0.857666666666667

			if var_4_44 <= arg_1_1.time_ and arg_1_1.time_ < var_4_44 + var_4_46 then
				local var_4_47 = (arg_1_1.time_ - var_4_44) / var_4_46
				local var_4_48 = Mathf.Lerp(arg_1_1.var_.alphaOldValue1148, 1, var_4_47)

				if arg_1_1.var_.characterEffect1148 then
					arg_1_1.var_.characterEffect1148.alpha = var_4_48
				end
			end

			if arg_1_1.time_ >= var_4_44 + var_4_46 and arg_1_1.time_ < var_4_44 + var_4_46 + arg_4_0 and arg_1_1.var_.characterEffect1148 then
				arg_1_1.var_.characterEffect1148.alpha = 1
			end

			local var_4_49 = 0
			local var_4_50 = 0.2

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

			local var_4_55 = 0.466666666666667
			local var_4_56 = 1

			if var_4_55 < arg_1_1.time_ and arg_1_1.time_ <= var_4_55 + arg_4_0 then
				local var_4_57 = "play"
				local var_4_58 = "music"

				arg_1_1:AudioAction(var_4_57, var_4_58, "bgm_activity_3_8_story_village", "bgm_activity_3_8_story_village", "bgm_activity_3_8_story_village.awb")

				local var_4_59 = ""
				local var_4_60 = manager.audio:GetAudioName("bgm_activity_3_8_story_village", "bgm_activity_3_8_story_village")

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
			local var_4_62 = 0.45

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

				local var_4_64 = arg_1_1:FormatText(StoryNameCfg[8].name)

				arg_1_1.leftNameTxt_.text = var_4_64

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_1_1.leftNameTxt_.transform)

				arg_1_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_1_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_1_1:RecordName(arg_1_1.leftNameTxt_.text)
				SetActive(arg_1_1.iconTrs_.gameObject, false)
				arg_1_1.callingController_:SetSelectedState("normal")

				local var_4_65 = arg_1_1:GetWordFromCfg(416071001)
				local var_4_66 = arg_1_1:FormatText(var_4_65.content)

				arg_1_1.text_.text = var_4_66

				LuaForUtil.ClearLinePrefixSymbol(arg_1_1.text_)

				local var_4_67 = 18
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

				if manager.audio:GetVoiceLength("story_v_out_416071", "416071001", "story_v_out_416071.awb") ~= 0 then
					local var_4_70 = manager.audio:GetVoiceLength("story_v_out_416071", "416071001", "story_v_out_416071.awb") / 1000

					if var_4_70 + var_4_61 > arg_1_1.duration_ then
						arg_1_1.duration_ = var_4_70 + var_4_61
					end

					if var_4_65.prefab_name ~= "" and arg_1_1.actors_[var_4_65.prefab_name] ~= nil then
						local var_4_71 = LuaForUtil.PlayVoiceWithCriLipsync(arg_1_1.actors_[var_4_65.prefab_name].transform, "story_v_out_416071", "416071001", "story_v_out_416071.awb")

						arg_1_1:RecordAudio("416071001", var_4_71)
						arg_1_1:RecordAudio("416071001", var_4_71)
					else
						arg_1_1:AudioAction("play", "voice", "story_v_out_416071", "416071001", "story_v_out_416071.awb")
					end

					arg_1_1:RecordHistoryTalkVoice("story_v_out_416071", "416071001", "story_v_out_416071.awb")
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
				actorName = "1148",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 1.66666666666667,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_1_1:InitPlayNodeList()
	end,
	Play416071002 = function(arg_9_0, arg_9_1)
		arg_9_1.time_ = 0
		arg_9_1.frameCnt_ = 0
		arg_9_1.state_ = "playing"
		arg_9_1.curTalkId_ = 416071002
		arg_9_1.duration_ = 8.03

		local var_9_0 = {
			zh = 3.833,
			ja = 8.033
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
				arg_9_0:Play416071003(arg_9_1)
			end
		end

		function arg_9_1.onSingleLineUpdate_(arg_12_0)
			local var_12_0 = 0
			local var_12_1 = 0.35

			if var_12_0 < arg_9_1.time_ and arg_9_1.time_ <= var_12_0 + arg_12_0 then
				arg_9_1.talkMaxDuration = 0
				arg_9_1.dialogCg_.alpha = 1

				arg_9_1.dialog_:SetActive(true)
				SetActive(arg_9_1.leftNameGo_, true)

				local var_12_2 = arg_9_1:FormatText(StoryNameCfg[8].name)

				arg_9_1.leftNameTxt_.text = var_12_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_9_1.leftNameTxt_.transform)

				arg_9_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_9_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_9_1:RecordName(arg_9_1.leftNameTxt_.text)
				SetActive(arg_9_1.iconTrs_.gameObject, false)
				arg_9_1.callingController_:SetSelectedState("normal")

				local var_12_3 = arg_9_1:GetWordFromCfg(416071002)
				local var_12_4 = arg_9_1:FormatText(var_12_3.content)

				arg_9_1.text_.text = var_12_4

				LuaForUtil.ClearLinePrefixSymbol(arg_9_1.text_)

				local var_12_5 = 14
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

				if manager.audio:GetVoiceLength("story_v_out_416071", "416071002", "story_v_out_416071.awb") ~= 0 then
					local var_12_8 = manager.audio:GetVoiceLength("story_v_out_416071", "416071002", "story_v_out_416071.awb") / 1000

					if var_12_8 + var_12_0 > arg_9_1.duration_ then
						arg_9_1.duration_ = var_12_8 + var_12_0
					end

					if var_12_3.prefab_name ~= "" and arg_9_1.actors_[var_12_3.prefab_name] ~= nil then
						local var_12_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_9_1.actors_[var_12_3.prefab_name].transform, "story_v_out_416071", "416071002", "story_v_out_416071.awb")

						arg_9_1:RecordAudio("416071002", var_12_9)
						arg_9_1:RecordAudio("416071002", var_12_9)
					else
						arg_9_1:AudioAction("play", "voice", "story_v_out_416071", "416071002", "story_v_out_416071.awb")
					end

					arg_9_1:RecordHistoryTalkVoice("story_v_out_416071", "416071002", "story_v_out_416071.awb")
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
	Play416071003 = function(arg_13_0, arg_13_1)
		arg_13_1.time_ = 0
		arg_13_1.frameCnt_ = 0
		arg_13_1.state_ = "playing"
		arg_13_1.curTalkId_ = 416071003
		arg_13_1.duration_ = 5

		SetActive(arg_13_1.tipsGo_, false)

		function arg_13_1.onSingleLineFinish_()
			arg_13_1.onSingleLineUpdate_ = nil
			arg_13_1.onSingleLineFinish_ = nil
			arg_13_1.state_ = "waiting"
		end

		function arg_13_1.playNext_(arg_15_0)
			if arg_15_0 == 1 then
				arg_13_0:Play416071004(arg_13_1)
			end
		end

		function arg_13_1.onSingleLineUpdate_(arg_16_0)
			local var_16_0 = arg_13_1.actors_["1148"].transform
			local var_16_1 = 0

			if var_16_1 < arg_13_1.time_ and arg_13_1.time_ <= var_16_1 + arg_16_0 then
				arg_13_1.var_.moveOldPos1148 = var_16_0.localPosition
				var_16_0.localScale = Vector3.New(1, 1, 1)

				arg_13_1:CheckSpriteTmpPos("1148", 7)

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
				local var_16_6 = Vector3.New(0, -2000, 0)

				var_16_0.localPosition = Vector3.Lerp(arg_13_1.var_.moveOldPos1148, var_16_6, var_16_5)
			end

			if arg_13_1.time_ >= var_16_1 + var_16_4 and arg_13_1.time_ < var_16_1 + var_16_4 + arg_16_0 then
				var_16_0.localPosition = Vector3.New(0, -2000, 0)
			end

			local var_16_7 = 0
			local var_16_8 = 1.375

			if var_16_7 < arg_13_1.time_ and arg_13_1.time_ <= var_16_7 + arg_16_0 then
				arg_13_1.talkMaxDuration = 0
				arg_13_1.dialogCg_.alpha = 1

				arg_13_1.dialog_:SetActive(true)
				SetActive(arg_13_1.leftNameGo_, false)

				arg_13_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_13_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_13_1:RecordName(arg_13_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_13_1.iconTrs_.gameObject, false)
				arg_13_1.callingController_:SetSelectedState("normal")

				local var_16_9 = arg_13_1:GetWordFromCfg(416071003)
				local var_16_10 = arg_13_1:FormatText(var_16_9.content)

				arg_13_1.text_.text = var_16_10

				LuaForUtil.ClearLinePrefixSymbol(arg_13_1.text_)

				local var_16_11 = 55
				local var_16_12 = utf8.len(var_16_10)
				local var_16_13 = var_16_11 <= 0 and var_16_8 or var_16_8 * (var_16_12 / var_16_11)

				if var_16_13 > 0 and var_16_8 < var_16_13 then
					arg_13_1.talkMaxDuration = var_16_13

					if var_16_13 + var_16_7 > arg_13_1.duration_ then
						arg_13_1.duration_ = var_16_13 + var_16_7
					end
				end

				arg_13_1.text_.text = var_16_10
				arg_13_1.typewritter.percent = 0

				arg_13_1.typewritter:SetDirty()
				arg_13_1:ShowNextGo(false)
				arg_13_1:RecordContent(arg_13_1.text_.text)
			end

			local var_16_14 = math.max(var_16_8, arg_13_1.talkMaxDuration)

			if var_16_7 <= arg_13_1.time_ and arg_13_1.time_ < var_16_7 + var_16_14 then
				arg_13_1.typewritter.percent = (arg_13_1.time_ - var_16_7) / var_16_14

				arg_13_1.typewritter:SetDirty()
			end

			if arg_13_1.time_ >= var_16_7 + var_16_14 and arg_13_1.time_ < var_16_7 + var_16_14 + arg_16_0 then
				arg_13_1.typewritter.percent = 1

				arg_13_1.typewritter:SetDirty()
				arg_13_1:ShowNextGo(true)
			end
		end

		arg_13_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1148",
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
	Play416071004 = function(arg_17_0, arg_17_1)
		arg_17_1.time_ = 0
		arg_17_1.frameCnt_ = 0
		arg_17_1.state_ = "playing"
		arg_17_1.curTalkId_ = 416071004
		arg_17_1.duration_ = 5.07

		local var_17_0 = {
			zh = 4.166,
			ja = 5.066
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
				arg_17_0:Play416071005(arg_17_1)
			end
		end

		function arg_17_1.onSingleLineUpdate_(arg_20_0)
			local var_20_0 = "10121"

			if arg_17_1.actors_[var_20_0] == nil then
				local var_20_1 = Asset.Load("Widget/System/Story/StoryExpression/" .. "10121")

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

			local var_20_4 = arg_17_1.actors_["10121"]
			local var_20_5 = 0

			if var_20_5 < arg_17_1.time_ and arg_17_1.time_ <= var_20_5 + arg_20_0 and not isNil(var_20_4) and arg_17_1.var_.actorSpriteComps10121 == nil then
				arg_17_1.var_.actorSpriteComps10121 = var_20_4:GetComponentsInChildren(typeof(Image), true)
			end

			local var_20_6 = 0.125

			if var_20_5 <= arg_17_1.time_ and arg_17_1.time_ < var_20_5 + var_20_6 and not isNil(var_20_4) then
				local var_20_7 = (arg_17_1.time_ - var_20_5) / var_20_6

				if arg_17_1.var_.actorSpriteComps10121 then
					for iter_20_2, iter_20_3 in pairs(arg_17_1.var_.actorSpriteComps10121:ToTable()) do
						if iter_20_3 then
							if arg_17_1.isInRecall_ then
								local var_20_8 = Mathf.Lerp(iter_20_3.color.r, arg_17_1.hightColor1.r, var_20_7)
								local var_20_9 = Mathf.Lerp(iter_20_3.color.g, arg_17_1.hightColor1.g, var_20_7)
								local var_20_10 = Mathf.Lerp(iter_20_3.color.b, arg_17_1.hightColor1.b, var_20_7)

								iter_20_3.color = Color.New(var_20_8, var_20_9, var_20_10)
							else
								local var_20_11 = Mathf.Lerp(iter_20_3.color.r, 1, var_20_7)

								iter_20_3.color = Color.New(var_20_11, var_20_11, var_20_11)
							end
						end
					end
				end
			end

			if arg_17_1.time_ >= var_20_5 + var_20_6 and arg_17_1.time_ < var_20_5 + var_20_6 + arg_20_0 and not isNil(var_20_4) and arg_17_1.var_.actorSpriteComps10121 then
				for iter_20_4, iter_20_5 in pairs(arg_17_1.var_.actorSpriteComps10121:ToTable()) do
					if iter_20_5 then
						if arg_17_1.isInRecall_ then
							iter_20_5.color = arg_17_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_20_5.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_17_1.var_.actorSpriteComps10121 = nil
			end

			local var_20_12 = arg_17_1.actors_["10121"].transform
			local var_20_13 = 0

			if var_20_13 < arg_17_1.time_ and arg_17_1.time_ <= var_20_13 + arg_20_0 then
				arg_17_1.var_.moveOldPos10121 = var_20_12.localPosition
				var_20_12.localScale = Vector3.New(1, 1, 1)

				arg_17_1:CheckSpriteTmpPos("10121", 3)

				local var_20_14 = var_20_12.childCount

				for iter_20_6 = 0, var_20_14 - 1 do
					local var_20_15 = var_20_12:GetChild(iter_20_6)

					if var_20_15.name == "" or not string.find(var_20_15.name, "split") then
						var_20_15.gameObject:SetActive(true)
					else
						var_20_15.gameObject:SetActive(false)
					end
				end
			end

			local var_20_16 = 0.001

			if var_20_13 <= arg_17_1.time_ and arg_17_1.time_ < var_20_13 + var_20_16 then
				local var_20_17 = (arg_17_1.time_ - var_20_13) / var_20_16
				local var_20_18 = Vector3.New(0, -260.5, -275)

				var_20_12.localPosition = Vector3.Lerp(arg_17_1.var_.moveOldPos10121, var_20_18, var_20_17)
			end

			if arg_17_1.time_ >= var_20_13 + var_20_16 and arg_17_1.time_ < var_20_13 + var_20_16 + arg_20_0 then
				var_20_12.localPosition = Vector3.New(0, -260.5, -275)
			end

			local var_20_19 = 0
			local var_20_20 = 0.525

			if var_20_19 < arg_17_1.time_ and arg_17_1.time_ <= var_20_19 + arg_20_0 then
				arg_17_1.talkMaxDuration = 0
				arg_17_1.dialogCg_.alpha = 1

				arg_17_1.dialog_:SetActive(true)
				SetActive(arg_17_1.leftNameGo_, true)

				local var_20_21 = arg_17_1:FormatText(StoryNameCfg[1081].name)

				arg_17_1.leftNameTxt_.text = var_20_21

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_17_1.leftNameTxt_.transform)

				arg_17_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_17_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_17_1:RecordName(arg_17_1.leftNameTxt_.text)
				SetActive(arg_17_1.iconTrs_.gameObject, false)
				arg_17_1.callingController_:SetSelectedState("normal")

				local var_20_22 = arg_17_1:GetWordFromCfg(416071004)
				local var_20_23 = arg_17_1:FormatText(var_20_22.content)

				arg_17_1.text_.text = var_20_23

				LuaForUtil.ClearLinePrefixSymbol(arg_17_1.text_)

				local var_20_24 = 21
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

				if manager.audio:GetVoiceLength("story_v_out_416071", "416071004", "story_v_out_416071.awb") ~= 0 then
					local var_20_27 = manager.audio:GetVoiceLength("story_v_out_416071", "416071004", "story_v_out_416071.awb") / 1000

					if var_20_27 + var_20_19 > arg_17_1.duration_ then
						arg_17_1.duration_ = var_20_27 + var_20_19
					end

					if var_20_22.prefab_name ~= "" and arg_17_1.actors_[var_20_22.prefab_name] ~= nil then
						local var_20_28 = LuaForUtil.PlayVoiceWithCriLipsync(arg_17_1.actors_[var_20_22.prefab_name].transform, "story_v_out_416071", "416071004", "story_v_out_416071.awb")

						arg_17_1:RecordAudio("416071004", var_20_28)
						arg_17_1:RecordAudio("416071004", var_20_28)
					else
						arg_17_1:AudioAction("play", "voice", "story_v_out_416071", "416071004", "story_v_out_416071.awb")
					end

					arg_17_1:RecordHistoryTalkVoice("story_v_out_416071", "416071004", "story_v_out_416071.awb")
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
				actorName = "10121",
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
	Play416071005 = function(arg_21_0, arg_21_1)
		arg_21_1.time_ = 0
		arg_21_1.frameCnt_ = 0
		arg_21_1.state_ = "playing"
		arg_21_1.curTalkId_ = 416071005
		arg_21_1.duration_ = 5.97

		local var_21_0 = {
			zh = 4.566,
			ja = 5.966
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
				arg_21_0:Play416071006(arg_21_1)
			end
		end

		function arg_21_1.onSingleLineUpdate_(arg_24_0)
			local var_24_0 = arg_21_1.actors_["10121"].transform
			local var_24_1 = 0

			if var_24_1 < arg_21_1.time_ and arg_21_1.time_ <= var_24_1 + arg_24_0 then
				arg_21_1.var_.moveOldPos10121 = var_24_0.localPosition
				var_24_0.localScale = Vector3.New(1, 1, 1)

				arg_21_1:CheckSpriteTmpPos("10121", 2)

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
				local var_24_6 = Vector3.New(-390, -260.5, -275)

				var_24_0.localPosition = Vector3.Lerp(arg_21_1.var_.moveOldPos10121, var_24_6, var_24_5)
			end

			if arg_21_1.time_ >= var_24_1 + var_24_4 and arg_21_1.time_ < var_24_1 + var_24_4 + arg_24_0 then
				var_24_0.localPosition = Vector3.New(-390, -260.5, -275)
			end

			local var_24_7 = arg_21_1.actors_["1148"].transform
			local var_24_8 = 0

			if var_24_8 < arg_21_1.time_ and arg_21_1.time_ <= var_24_8 + arg_24_0 then
				arg_21_1.var_.moveOldPos1148 = var_24_7.localPosition
				var_24_7.localScale = Vector3.New(1, 1, 1)

				arg_21_1:CheckSpriteTmpPos("1148", 4)

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
				local var_24_13 = Vector3.New(390, -429, -180)

				var_24_7.localPosition = Vector3.Lerp(arg_21_1.var_.moveOldPos1148, var_24_13, var_24_12)
			end

			if arg_21_1.time_ >= var_24_8 + var_24_11 and arg_21_1.time_ < var_24_8 + var_24_11 + arg_24_0 then
				var_24_7.localPosition = Vector3.New(390, -429, -180)
			end

			local var_24_14 = arg_21_1.actors_["1148"]
			local var_24_15 = 0

			if var_24_15 < arg_21_1.time_ and arg_21_1.time_ <= var_24_15 + arg_24_0 and not isNil(var_24_14) and arg_21_1.var_.actorSpriteComps1148 == nil then
				arg_21_1.var_.actorSpriteComps1148 = var_24_14:GetComponentsInChildren(typeof(Image), true)
			end

			local var_24_16 = 0.125

			if var_24_15 <= arg_21_1.time_ and arg_21_1.time_ < var_24_15 + var_24_16 and not isNil(var_24_14) then
				local var_24_17 = (arg_21_1.time_ - var_24_15) / var_24_16

				if arg_21_1.var_.actorSpriteComps1148 then
					for iter_24_2, iter_24_3 in pairs(arg_21_1.var_.actorSpriteComps1148:ToTable()) do
						if iter_24_3 then
							if arg_21_1.isInRecall_ then
								local var_24_18 = Mathf.Lerp(iter_24_3.color.r, arg_21_1.hightColor1.r, var_24_17)
								local var_24_19 = Mathf.Lerp(iter_24_3.color.g, arg_21_1.hightColor1.g, var_24_17)
								local var_24_20 = Mathf.Lerp(iter_24_3.color.b, arg_21_1.hightColor1.b, var_24_17)

								iter_24_3.color = Color.New(var_24_18, var_24_19, var_24_20)
							else
								local var_24_21 = Mathf.Lerp(iter_24_3.color.r, 1, var_24_17)

								iter_24_3.color = Color.New(var_24_21, var_24_21, var_24_21)
							end
						end
					end
				end
			end

			if arg_21_1.time_ >= var_24_15 + var_24_16 and arg_21_1.time_ < var_24_15 + var_24_16 + arg_24_0 and not isNil(var_24_14) and arg_21_1.var_.actorSpriteComps1148 then
				for iter_24_4, iter_24_5 in pairs(arg_21_1.var_.actorSpriteComps1148:ToTable()) do
					if iter_24_5 then
						if arg_21_1.isInRecall_ then
							iter_24_5.color = arg_21_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_24_5.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_21_1.var_.actorSpriteComps1148 = nil
			end

			local var_24_22 = arg_21_1.actors_["10121"]
			local var_24_23 = 0

			if var_24_23 < arg_21_1.time_ and arg_21_1.time_ <= var_24_23 + arg_24_0 and not isNil(var_24_22) and arg_21_1.var_.actorSpriteComps10121 == nil then
				arg_21_1.var_.actorSpriteComps10121 = var_24_22:GetComponentsInChildren(typeof(Image), true)
			end

			local var_24_24 = 0.125

			if var_24_23 <= arg_21_1.time_ and arg_21_1.time_ < var_24_23 + var_24_24 and not isNil(var_24_22) then
				local var_24_25 = (arg_21_1.time_ - var_24_23) / var_24_24

				if arg_21_1.var_.actorSpriteComps10121 then
					for iter_24_6, iter_24_7 in pairs(arg_21_1.var_.actorSpriteComps10121:ToTable()) do
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

			if arg_21_1.time_ >= var_24_23 + var_24_24 and arg_21_1.time_ < var_24_23 + var_24_24 + arg_24_0 and not isNil(var_24_22) and arg_21_1.var_.actorSpriteComps10121 then
				for iter_24_8, iter_24_9 in pairs(arg_21_1.var_.actorSpriteComps10121:ToTable()) do
					if iter_24_9 then
						if arg_21_1.isInRecall_ then
							iter_24_9.color = arg_21_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_24_9.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_21_1.var_.actorSpriteComps10121 = nil
			end

			local var_24_30 = 0
			local var_24_31 = 0.475

			if var_24_30 < arg_21_1.time_ and arg_21_1.time_ <= var_24_30 + arg_24_0 then
				arg_21_1.talkMaxDuration = 0
				arg_21_1.dialogCg_.alpha = 1

				arg_21_1.dialog_:SetActive(true)
				SetActive(arg_21_1.leftNameGo_, true)

				local var_24_32 = arg_21_1:FormatText(StoryNameCfg[8].name)

				arg_21_1.leftNameTxt_.text = var_24_32

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_21_1.leftNameTxt_.transform)

				arg_21_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_21_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_21_1:RecordName(arg_21_1.leftNameTxt_.text)
				SetActive(arg_21_1.iconTrs_.gameObject, false)
				arg_21_1.callingController_:SetSelectedState("normal")

				local var_24_33 = arg_21_1:GetWordFromCfg(416071005)
				local var_24_34 = arg_21_1:FormatText(var_24_33.content)

				arg_21_1.text_.text = var_24_34

				LuaForUtil.ClearLinePrefixSymbol(arg_21_1.text_)

				local var_24_35 = 19
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

				if manager.audio:GetVoiceLength("story_v_out_416071", "416071005", "story_v_out_416071.awb") ~= 0 then
					local var_24_38 = manager.audio:GetVoiceLength("story_v_out_416071", "416071005", "story_v_out_416071.awb") / 1000

					if var_24_38 + var_24_30 > arg_21_1.duration_ then
						arg_21_1.duration_ = var_24_38 + var_24_30
					end

					if var_24_33.prefab_name ~= "" and arg_21_1.actors_[var_24_33.prefab_name] ~= nil then
						local var_24_39 = LuaForUtil.PlayVoiceWithCriLipsync(arg_21_1.actors_[var_24_33.prefab_name].transform, "story_v_out_416071", "416071005", "story_v_out_416071.awb")

						arg_21_1:RecordAudio("416071005", var_24_39)
						arg_21_1:RecordAudio("416071005", var_24_39)
					else
						arg_21_1:AudioAction("play", "voice", "story_v_out_416071", "416071005", "story_v_out_416071.awb")
					end

					arg_21_1:RecordHistoryTalkVoice("story_v_out_416071", "416071005", "story_v_out_416071.awb")
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
				actorName = "10121",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			},
			{
				assetPath = "",
				actorName = "1148",
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
	Play416071006 = function(arg_25_0, arg_25_1)
		arg_25_1.time_ = 0
		arg_25_1.frameCnt_ = 0
		arg_25_1.state_ = "playing"
		arg_25_1.curTalkId_ = 416071006
		arg_25_1.duration_ = 5.67

		local var_25_0 = {
			zh = 3.1,
			ja = 5.666
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
				arg_25_0:Play416071007(arg_25_1)
			end
		end

		function arg_25_1.onSingleLineUpdate_(arg_28_0)
			local var_28_0 = 0
			local var_28_1 = 0.4

			if var_28_0 < arg_25_1.time_ and arg_25_1.time_ <= var_28_0 + arg_28_0 then
				arg_25_1.talkMaxDuration = 0
				arg_25_1.dialogCg_.alpha = 1

				arg_25_1.dialog_:SetActive(true)
				SetActive(arg_25_1.leftNameGo_, true)

				local var_28_2 = arg_25_1:FormatText(StoryNameCfg[8].name)

				arg_25_1.leftNameTxt_.text = var_28_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_25_1.leftNameTxt_.transform)

				arg_25_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_25_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_25_1:RecordName(arg_25_1.leftNameTxt_.text)
				SetActive(arg_25_1.iconTrs_.gameObject, false)
				arg_25_1.callingController_:SetSelectedState("normal")

				local var_28_3 = arg_25_1:GetWordFromCfg(416071006)
				local var_28_4 = arg_25_1:FormatText(var_28_3.content)

				arg_25_1.text_.text = var_28_4

				LuaForUtil.ClearLinePrefixSymbol(arg_25_1.text_)

				local var_28_5 = 16
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

				if manager.audio:GetVoiceLength("story_v_out_416071", "416071006", "story_v_out_416071.awb") ~= 0 then
					local var_28_8 = manager.audio:GetVoiceLength("story_v_out_416071", "416071006", "story_v_out_416071.awb") / 1000

					if var_28_8 + var_28_0 > arg_25_1.duration_ then
						arg_25_1.duration_ = var_28_8 + var_28_0
					end

					if var_28_3.prefab_name ~= "" and arg_25_1.actors_[var_28_3.prefab_name] ~= nil then
						local var_28_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_25_1.actors_[var_28_3.prefab_name].transform, "story_v_out_416071", "416071006", "story_v_out_416071.awb")

						arg_25_1:RecordAudio("416071006", var_28_9)
						arg_25_1:RecordAudio("416071006", var_28_9)
					else
						arg_25_1:AudioAction("play", "voice", "story_v_out_416071", "416071006", "story_v_out_416071.awb")
					end

					arg_25_1:RecordHistoryTalkVoice("story_v_out_416071", "416071006", "story_v_out_416071.awb")
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
	Play416071007 = function(arg_29_0, arg_29_1)
		arg_29_1.time_ = 0
		arg_29_1.frameCnt_ = 0
		arg_29_1.state_ = "playing"
		arg_29_1.curTalkId_ = 416071007
		arg_29_1.duration_ = 5.9

		local var_29_0 = {
			zh = 4.833,
			ja = 5.9
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
				arg_29_0:Play416071008(arg_29_1)
			end
		end

		function arg_29_1.onSingleLineUpdate_(arg_32_0)
			local var_32_0 = arg_29_1.actors_["10121"]
			local var_32_1 = 0

			if var_32_1 < arg_29_1.time_ and arg_29_1.time_ <= var_32_1 + arg_32_0 and not isNil(var_32_0) and arg_29_1.var_.actorSpriteComps10121 == nil then
				arg_29_1.var_.actorSpriteComps10121 = var_32_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_32_2 = 0.125

			if var_32_1 <= arg_29_1.time_ and arg_29_1.time_ < var_32_1 + var_32_2 and not isNil(var_32_0) then
				local var_32_3 = (arg_29_1.time_ - var_32_1) / var_32_2

				if arg_29_1.var_.actorSpriteComps10121 then
					for iter_32_0, iter_32_1 in pairs(arg_29_1.var_.actorSpriteComps10121:ToTable()) do
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

			if arg_29_1.time_ >= var_32_1 + var_32_2 and arg_29_1.time_ < var_32_1 + var_32_2 + arg_32_0 and not isNil(var_32_0) and arg_29_1.var_.actorSpriteComps10121 then
				for iter_32_2, iter_32_3 in pairs(arg_29_1.var_.actorSpriteComps10121:ToTable()) do
					if iter_32_3 then
						if arg_29_1.isInRecall_ then
							iter_32_3.color = arg_29_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_32_3.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_29_1.var_.actorSpriteComps10121 = nil
			end

			local var_32_8 = arg_29_1.actors_["1148"]
			local var_32_9 = 0

			if var_32_9 < arg_29_1.time_ and arg_29_1.time_ <= var_32_9 + arg_32_0 and not isNil(var_32_8) and arg_29_1.var_.actorSpriteComps1148 == nil then
				arg_29_1.var_.actorSpriteComps1148 = var_32_8:GetComponentsInChildren(typeof(Image), true)
			end

			local var_32_10 = 0.125

			if var_32_9 <= arg_29_1.time_ and arg_29_1.time_ < var_32_9 + var_32_10 and not isNil(var_32_8) then
				local var_32_11 = (arg_29_1.time_ - var_32_9) / var_32_10

				if arg_29_1.var_.actorSpriteComps1148 then
					for iter_32_4, iter_32_5 in pairs(arg_29_1.var_.actorSpriteComps1148:ToTable()) do
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

			if arg_29_1.time_ >= var_32_9 + var_32_10 and arg_29_1.time_ < var_32_9 + var_32_10 + arg_32_0 and not isNil(var_32_8) and arg_29_1.var_.actorSpriteComps1148 then
				for iter_32_6, iter_32_7 in pairs(arg_29_1.var_.actorSpriteComps1148:ToTable()) do
					if iter_32_7 then
						if arg_29_1.isInRecall_ then
							iter_32_7.color = arg_29_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_32_7.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_29_1.var_.actorSpriteComps1148 = nil
			end

			local var_32_16 = 0
			local var_32_17 = 0.65

			if var_32_16 < arg_29_1.time_ and arg_29_1.time_ <= var_32_16 + arg_32_0 then
				arg_29_1.talkMaxDuration = 0
				arg_29_1.dialogCg_.alpha = 1

				arg_29_1.dialog_:SetActive(true)
				SetActive(arg_29_1.leftNameGo_, true)

				local var_32_18 = arg_29_1:FormatText(StoryNameCfg[1081].name)

				arg_29_1.leftNameTxt_.text = var_32_18

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_29_1.leftNameTxt_.transform)

				arg_29_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_29_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_29_1:RecordName(arg_29_1.leftNameTxt_.text)
				SetActive(arg_29_1.iconTrs_.gameObject, false)
				arg_29_1.callingController_:SetSelectedState("normal")

				local var_32_19 = arg_29_1:GetWordFromCfg(416071007)
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

				if manager.audio:GetVoiceLength("story_v_out_416071", "416071007", "story_v_out_416071.awb") ~= 0 then
					local var_32_24 = manager.audio:GetVoiceLength("story_v_out_416071", "416071007", "story_v_out_416071.awb") / 1000

					if var_32_24 + var_32_16 > arg_29_1.duration_ then
						arg_29_1.duration_ = var_32_24 + var_32_16
					end

					if var_32_19.prefab_name ~= "" and arg_29_1.actors_[var_32_19.prefab_name] ~= nil then
						local var_32_25 = LuaForUtil.PlayVoiceWithCriLipsync(arg_29_1.actors_[var_32_19.prefab_name].transform, "story_v_out_416071", "416071007", "story_v_out_416071.awb")

						arg_29_1:RecordAudio("416071007", var_32_25)
						arg_29_1:RecordAudio("416071007", var_32_25)
					else
						arg_29_1:AudioAction("play", "voice", "story_v_out_416071", "416071007", "story_v_out_416071.awb")
					end

					arg_29_1:RecordHistoryTalkVoice("story_v_out_416071", "416071007", "story_v_out_416071.awb")
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
	Play416071008 = function(arg_33_0, arg_33_1)
		arg_33_1.time_ = 0
		arg_33_1.frameCnt_ = 0
		arg_33_1.state_ = "playing"
		arg_33_1.curTalkId_ = 416071008
		arg_33_1.duration_ = 7.97

		local var_33_0 = {
			zh = 5.4,
			ja = 7.966
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
				arg_33_0:Play416071009(arg_33_1)
			end
		end

		function arg_33_1.onSingleLineUpdate_(arg_36_0)
			local var_36_0 = arg_33_1.actors_["10121"]
			local var_36_1 = 0

			if var_36_1 < arg_33_1.time_ and arg_33_1.time_ <= var_36_1 + arg_36_0 and not isNil(var_36_0) and arg_33_1.var_.actorSpriteComps10121 == nil then
				arg_33_1.var_.actorSpriteComps10121 = var_36_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_36_2 = 0.125

			if var_36_1 <= arg_33_1.time_ and arg_33_1.time_ < var_36_1 + var_36_2 and not isNil(var_36_0) then
				local var_36_3 = (arg_33_1.time_ - var_36_1) / var_36_2

				if arg_33_1.var_.actorSpriteComps10121 then
					for iter_36_0, iter_36_1 in pairs(arg_33_1.var_.actorSpriteComps10121:ToTable()) do
						if iter_36_1 then
							if arg_33_1.isInRecall_ then
								local var_36_4 = Mathf.Lerp(iter_36_1.color.r, arg_33_1.hightColor2.r, var_36_3)
								local var_36_5 = Mathf.Lerp(iter_36_1.color.g, arg_33_1.hightColor2.g, var_36_3)
								local var_36_6 = Mathf.Lerp(iter_36_1.color.b, arg_33_1.hightColor2.b, var_36_3)

								iter_36_1.color = Color.New(var_36_4, var_36_5, var_36_6)
							else
								local var_36_7 = Mathf.Lerp(iter_36_1.color.r, 0.5, var_36_3)

								iter_36_1.color = Color.New(var_36_7, var_36_7, var_36_7)
							end
						end
					end
				end
			end

			if arg_33_1.time_ >= var_36_1 + var_36_2 and arg_33_1.time_ < var_36_1 + var_36_2 + arg_36_0 and not isNil(var_36_0) and arg_33_1.var_.actorSpriteComps10121 then
				for iter_36_2, iter_36_3 in pairs(arg_33_1.var_.actorSpriteComps10121:ToTable()) do
					if iter_36_3 then
						if arg_33_1.isInRecall_ then
							iter_36_3.color = arg_33_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_36_3.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_33_1.var_.actorSpriteComps10121 = nil
			end

			local var_36_8 = arg_33_1.actors_["1148"]
			local var_36_9 = 0

			if var_36_9 < arg_33_1.time_ and arg_33_1.time_ <= var_36_9 + arg_36_0 and not isNil(var_36_8) and arg_33_1.var_.actorSpriteComps1148 == nil then
				arg_33_1.var_.actorSpriteComps1148 = var_36_8:GetComponentsInChildren(typeof(Image), true)
			end

			local var_36_10 = 0.125

			if var_36_9 <= arg_33_1.time_ and arg_33_1.time_ < var_36_9 + var_36_10 and not isNil(var_36_8) then
				local var_36_11 = (arg_33_1.time_ - var_36_9) / var_36_10

				if arg_33_1.var_.actorSpriteComps1148 then
					for iter_36_4, iter_36_5 in pairs(arg_33_1.var_.actorSpriteComps1148:ToTable()) do
						if iter_36_5 then
							if arg_33_1.isInRecall_ then
								local var_36_12 = Mathf.Lerp(iter_36_5.color.r, arg_33_1.hightColor1.r, var_36_11)
								local var_36_13 = Mathf.Lerp(iter_36_5.color.g, arg_33_1.hightColor1.g, var_36_11)
								local var_36_14 = Mathf.Lerp(iter_36_5.color.b, arg_33_1.hightColor1.b, var_36_11)

								iter_36_5.color = Color.New(var_36_12, var_36_13, var_36_14)
							else
								local var_36_15 = Mathf.Lerp(iter_36_5.color.r, 1, var_36_11)

								iter_36_5.color = Color.New(var_36_15, var_36_15, var_36_15)
							end
						end
					end
				end
			end

			if arg_33_1.time_ >= var_36_9 + var_36_10 and arg_33_1.time_ < var_36_9 + var_36_10 + arg_36_0 and not isNil(var_36_8) and arg_33_1.var_.actorSpriteComps1148 then
				for iter_36_6, iter_36_7 in pairs(arg_33_1.var_.actorSpriteComps1148:ToTable()) do
					if iter_36_7 then
						if arg_33_1.isInRecall_ then
							iter_36_7.color = arg_33_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_36_7.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_33_1.var_.actorSpriteComps1148 = nil
			end

			local var_36_16 = 0
			local var_36_17 = 0.575

			if var_36_16 < arg_33_1.time_ and arg_33_1.time_ <= var_36_16 + arg_36_0 then
				arg_33_1.talkMaxDuration = 0
				arg_33_1.dialogCg_.alpha = 1

				arg_33_1.dialog_:SetActive(true)
				SetActive(arg_33_1.leftNameGo_, true)

				local var_36_18 = arg_33_1:FormatText(StoryNameCfg[8].name)

				arg_33_1.leftNameTxt_.text = var_36_18

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_33_1.leftNameTxt_.transform)

				arg_33_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_33_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_33_1:RecordName(arg_33_1.leftNameTxt_.text)
				SetActive(arg_33_1.iconTrs_.gameObject, false)
				arg_33_1.callingController_:SetSelectedState("normal")

				local var_36_19 = arg_33_1:GetWordFromCfg(416071008)
				local var_36_20 = arg_33_1:FormatText(var_36_19.content)

				arg_33_1.text_.text = var_36_20

				LuaForUtil.ClearLinePrefixSymbol(arg_33_1.text_)

				local var_36_21 = 23
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

				if manager.audio:GetVoiceLength("story_v_out_416071", "416071008", "story_v_out_416071.awb") ~= 0 then
					local var_36_24 = manager.audio:GetVoiceLength("story_v_out_416071", "416071008", "story_v_out_416071.awb") / 1000

					if var_36_24 + var_36_16 > arg_33_1.duration_ then
						arg_33_1.duration_ = var_36_24 + var_36_16
					end

					if var_36_19.prefab_name ~= "" and arg_33_1.actors_[var_36_19.prefab_name] ~= nil then
						local var_36_25 = LuaForUtil.PlayVoiceWithCriLipsync(arg_33_1.actors_[var_36_19.prefab_name].transform, "story_v_out_416071", "416071008", "story_v_out_416071.awb")

						arg_33_1:RecordAudio("416071008", var_36_25)
						arg_33_1:RecordAudio("416071008", var_36_25)
					else
						arg_33_1:AudioAction("play", "voice", "story_v_out_416071", "416071008", "story_v_out_416071.awb")
					end

					arg_33_1:RecordHistoryTalkVoice("story_v_out_416071", "416071008", "story_v_out_416071.awb")
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
	Play416071009 = function(arg_37_0, arg_37_1)
		arg_37_1.time_ = 0
		arg_37_1.frameCnt_ = 0
		arg_37_1.state_ = "playing"
		arg_37_1.curTalkId_ = 416071009
		arg_37_1.duration_ = 5

		SetActive(arg_37_1.tipsGo_, false)

		function arg_37_1.onSingleLineFinish_()
			arg_37_1.onSingleLineUpdate_ = nil
			arg_37_1.onSingleLineFinish_ = nil
			arg_37_1.state_ = "waiting"
		end

		function arg_37_1.playNext_(arg_39_0)
			if arg_39_0 == 1 then
				arg_37_0:Play416071010(arg_37_1)
			end
		end

		function arg_37_1.onSingleLineUpdate_(arg_40_0)
			local var_40_0 = arg_37_1.actors_["10121"].transform
			local var_40_1 = 0

			if var_40_1 < arg_37_1.time_ and arg_37_1.time_ <= var_40_1 + arg_40_0 then
				arg_37_1.var_.moveOldPos10121 = var_40_0.localPosition
				var_40_0.localScale = Vector3.New(1, 1, 1)

				arg_37_1:CheckSpriteTmpPos("10121", 7)

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
				local var_40_6 = Vector3.New(0, -2000, 0)

				var_40_0.localPosition = Vector3.Lerp(arg_37_1.var_.moveOldPos10121, var_40_6, var_40_5)
			end

			if arg_37_1.time_ >= var_40_1 + var_40_4 and arg_37_1.time_ < var_40_1 + var_40_4 + arg_40_0 then
				var_40_0.localPosition = Vector3.New(0, -2000, 0)
			end

			local var_40_7 = arg_37_1.actors_["1148"].transform
			local var_40_8 = 0

			if var_40_8 < arg_37_1.time_ and arg_37_1.time_ <= var_40_8 + arg_40_0 then
				arg_37_1.var_.moveOldPos1148 = var_40_7.localPosition
				var_40_7.localScale = Vector3.New(1, 1, 1)

				arg_37_1:CheckSpriteTmpPos("1148", 7)

				local var_40_9 = var_40_7.childCount

				for iter_40_1 = 0, var_40_9 - 1 do
					local var_40_10 = var_40_7:GetChild(iter_40_1)

					if var_40_10.name == "" or not string.find(var_40_10.name, "split") then
						var_40_10.gameObject:SetActive(true)
					else
						var_40_10.gameObject:SetActive(false)
					end
				end
			end

			local var_40_11 = 0.001

			if var_40_8 <= arg_37_1.time_ and arg_37_1.time_ < var_40_8 + var_40_11 then
				local var_40_12 = (arg_37_1.time_ - var_40_8) / var_40_11
				local var_40_13 = Vector3.New(0, -2000, 0)

				var_40_7.localPosition = Vector3.Lerp(arg_37_1.var_.moveOldPos1148, var_40_13, var_40_12)
			end

			if arg_37_1.time_ >= var_40_8 + var_40_11 and arg_37_1.time_ < var_40_8 + var_40_11 + arg_40_0 then
				var_40_7.localPosition = Vector3.New(0, -2000, 0)
			end

			local var_40_14 = 0
			local var_40_15 = 1.325

			if var_40_14 < arg_37_1.time_ and arg_37_1.time_ <= var_40_14 + arg_40_0 then
				arg_37_1.talkMaxDuration = 0
				arg_37_1.dialogCg_.alpha = 1

				arg_37_1.dialog_:SetActive(true)
				SetActive(arg_37_1.leftNameGo_, false)

				arg_37_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_37_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_37_1:RecordName(arg_37_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_37_1.iconTrs_.gameObject, false)
				arg_37_1.callingController_:SetSelectedState("normal")

				local var_40_16 = arg_37_1:GetWordFromCfg(416071009)
				local var_40_17 = arg_37_1:FormatText(var_40_16.content)

				arg_37_1.text_.text = var_40_17

				LuaForUtil.ClearLinePrefixSymbol(arg_37_1.text_)

				local var_40_18 = 53
				local var_40_19 = utf8.len(var_40_17)
				local var_40_20 = var_40_18 <= 0 and var_40_15 or var_40_15 * (var_40_19 / var_40_18)

				if var_40_20 > 0 and var_40_15 < var_40_20 then
					arg_37_1.talkMaxDuration = var_40_20

					if var_40_20 + var_40_14 > arg_37_1.duration_ then
						arg_37_1.duration_ = var_40_20 + var_40_14
					end
				end

				arg_37_1.text_.text = var_40_17
				arg_37_1.typewritter.percent = 0

				arg_37_1.typewritter:SetDirty()
				arg_37_1:ShowNextGo(false)
				arg_37_1:RecordContent(arg_37_1.text_.text)
			end

			local var_40_21 = math.max(var_40_15, arg_37_1.talkMaxDuration)

			if var_40_14 <= arg_37_1.time_ and arg_37_1.time_ < var_40_14 + var_40_21 then
				arg_37_1.typewritter.percent = (arg_37_1.time_ - var_40_14) / var_40_21

				arg_37_1.typewritter:SetDirty()
			end

			if arg_37_1.time_ >= var_40_14 + var_40_21 and arg_37_1.time_ < var_40_14 + var_40_21 + arg_40_0 then
				arg_37_1.typewritter.percent = 1

				arg_37_1.typewritter:SetDirty()
				arg_37_1:ShowNextGo(true)
			end
		end

		arg_37_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10121",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			},
			{
				assetPath = "",
				actorName = "1148",
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
	Play416071010 = function(arg_41_0, arg_41_1)
		arg_41_1.time_ = 0
		arg_41_1.frameCnt_ = 0
		arg_41_1.state_ = "playing"
		arg_41_1.curTalkId_ = 416071010
		arg_41_1.duration_ = 9.4

		local var_41_0 = {
			zh = 4.8,
			ja = 9.4
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
				arg_41_0:Play416071011(arg_41_1)
			end
		end

		function arg_41_1.onSingleLineUpdate_(arg_44_0)
			local var_44_0 = arg_41_1.actors_["1148"]
			local var_44_1 = 0

			if var_44_1 < arg_41_1.time_ and arg_41_1.time_ <= var_44_1 + arg_44_0 and not isNil(var_44_0) and arg_41_1.var_.actorSpriteComps1148 == nil then
				arg_41_1.var_.actorSpriteComps1148 = var_44_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_44_2 = 0.125

			if var_44_1 <= arg_41_1.time_ and arg_41_1.time_ < var_44_1 + var_44_2 and not isNil(var_44_0) then
				local var_44_3 = (arg_41_1.time_ - var_44_1) / var_44_2

				if arg_41_1.var_.actorSpriteComps1148 then
					for iter_44_0, iter_44_1 in pairs(arg_41_1.var_.actorSpriteComps1148:ToTable()) do
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

			if arg_41_1.time_ >= var_44_1 + var_44_2 and arg_41_1.time_ < var_44_1 + var_44_2 + arg_44_0 and not isNil(var_44_0) and arg_41_1.var_.actorSpriteComps1148 then
				for iter_44_2, iter_44_3 in pairs(arg_41_1.var_.actorSpriteComps1148:ToTable()) do
					if iter_44_3 then
						if arg_41_1.isInRecall_ then
							iter_44_3.color = arg_41_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_44_3.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_41_1.var_.actorSpriteComps1148 = nil
			end

			local var_44_8 = arg_41_1.actors_["1148"].transform
			local var_44_9 = 0

			if var_44_9 < arg_41_1.time_ and arg_41_1.time_ <= var_44_9 + arg_44_0 then
				arg_41_1.var_.moveOldPos1148 = var_44_8.localPosition
				var_44_8.localScale = Vector3.New(1, 1, 1)

				arg_41_1:CheckSpriteTmpPos("1148", 3)

				local var_44_10 = var_44_8.childCount

				for iter_44_4 = 0, var_44_10 - 1 do
					local var_44_11 = var_44_8:GetChild(iter_44_4)

					if var_44_11.name == "" or not string.find(var_44_11.name, "split") then
						var_44_11.gameObject:SetActive(true)
					else
						var_44_11.gameObject:SetActive(false)
					end
				end
			end

			local var_44_12 = 0.001

			if var_44_9 <= arg_41_1.time_ and arg_41_1.time_ < var_44_9 + var_44_12 then
				local var_44_13 = (arg_41_1.time_ - var_44_9) / var_44_12
				local var_44_14 = Vector3.New(0, -429, -180)

				var_44_8.localPosition = Vector3.Lerp(arg_41_1.var_.moveOldPos1148, var_44_14, var_44_13)
			end

			if arg_41_1.time_ >= var_44_9 + var_44_12 and arg_41_1.time_ < var_44_9 + var_44_12 + arg_44_0 then
				var_44_8.localPosition = Vector3.New(0, -429, -180)
			end

			local var_44_15 = 0
			local var_44_16 = 0.475

			if var_44_15 < arg_41_1.time_ and arg_41_1.time_ <= var_44_15 + arg_44_0 then
				arg_41_1.talkMaxDuration = 0
				arg_41_1.dialogCg_.alpha = 1

				arg_41_1.dialog_:SetActive(true)
				SetActive(arg_41_1.leftNameGo_, true)

				local var_44_17 = arg_41_1:FormatText(StoryNameCfg[8].name)

				arg_41_1.leftNameTxt_.text = var_44_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_41_1.leftNameTxt_.transform)

				arg_41_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_41_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_41_1:RecordName(arg_41_1.leftNameTxt_.text)
				SetActive(arg_41_1.iconTrs_.gameObject, false)
				arg_41_1.callingController_:SetSelectedState("normal")

				local var_44_18 = arg_41_1:GetWordFromCfg(416071010)
				local var_44_19 = arg_41_1:FormatText(var_44_18.content)

				arg_41_1.text_.text = var_44_19

				LuaForUtil.ClearLinePrefixSymbol(arg_41_1.text_)

				local var_44_20 = 19
				local var_44_21 = utf8.len(var_44_19)
				local var_44_22 = var_44_20 <= 0 and var_44_16 or var_44_16 * (var_44_21 / var_44_20)

				if var_44_22 > 0 and var_44_16 < var_44_22 then
					arg_41_1.talkMaxDuration = var_44_22

					if var_44_22 + var_44_15 > arg_41_1.duration_ then
						arg_41_1.duration_ = var_44_22 + var_44_15
					end
				end

				arg_41_1.text_.text = var_44_19
				arg_41_1.typewritter.percent = 0

				arg_41_1.typewritter:SetDirty()
				arg_41_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_416071", "416071010", "story_v_out_416071.awb") ~= 0 then
					local var_44_23 = manager.audio:GetVoiceLength("story_v_out_416071", "416071010", "story_v_out_416071.awb") / 1000

					if var_44_23 + var_44_15 > arg_41_1.duration_ then
						arg_41_1.duration_ = var_44_23 + var_44_15
					end

					if var_44_18.prefab_name ~= "" and arg_41_1.actors_[var_44_18.prefab_name] ~= nil then
						local var_44_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_41_1.actors_[var_44_18.prefab_name].transform, "story_v_out_416071", "416071010", "story_v_out_416071.awb")

						arg_41_1:RecordAudio("416071010", var_44_24)
						arg_41_1:RecordAudio("416071010", var_44_24)
					else
						arg_41_1:AudioAction("play", "voice", "story_v_out_416071", "416071010", "story_v_out_416071.awb")
					end

					arg_41_1:RecordHistoryTalkVoice("story_v_out_416071", "416071010", "story_v_out_416071.awb")
				end

				arg_41_1:RecordContent(arg_41_1.text_.text)
			end

			local var_44_25 = math.max(var_44_16, arg_41_1.talkMaxDuration)

			if var_44_15 <= arg_41_1.time_ and arg_41_1.time_ < var_44_15 + var_44_25 then
				arg_41_1.typewritter.percent = (arg_41_1.time_ - var_44_15) / var_44_25

				arg_41_1.typewritter:SetDirty()
			end

			if arg_41_1.time_ >= var_44_15 + var_44_25 and arg_41_1.time_ < var_44_15 + var_44_25 + arg_44_0 then
				arg_41_1.typewritter.percent = 1

				arg_41_1.typewritter:SetDirty()
				arg_41_1:ShowNextGo(true)
			end
		end

		arg_41_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1148",
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
	Play416071011 = function(arg_45_0, arg_45_1)
		arg_45_1.time_ = 0
		arg_45_1.frameCnt_ = 0
		arg_45_1.state_ = "playing"
		arg_45_1.curTalkId_ = 416071011
		arg_45_1.duration_ = 5.37

		local var_45_0 = {
			zh = 4.2,
			ja = 5.366
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
				arg_45_0:Play416071012(arg_45_1)
			end
		end

		function arg_45_1.onSingleLineUpdate_(arg_48_0)
			local var_48_0 = arg_45_1.actors_["10121"]
			local var_48_1 = 0

			if var_48_1 < arg_45_1.time_ and arg_45_1.time_ <= var_48_1 + arg_48_0 and not isNil(var_48_0) and arg_45_1.var_.actorSpriteComps10121 == nil then
				arg_45_1.var_.actorSpriteComps10121 = var_48_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_48_2 = 0.125

			if var_48_1 <= arg_45_1.time_ and arg_45_1.time_ < var_48_1 + var_48_2 and not isNil(var_48_0) then
				local var_48_3 = (arg_45_1.time_ - var_48_1) / var_48_2

				if arg_45_1.var_.actorSpriteComps10121 then
					for iter_48_0, iter_48_1 in pairs(arg_45_1.var_.actorSpriteComps10121:ToTable()) do
						if iter_48_1 then
							if arg_45_1.isInRecall_ then
								local var_48_4 = Mathf.Lerp(iter_48_1.color.r, arg_45_1.hightColor1.r, var_48_3)
								local var_48_5 = Mathf.Lerp(iter_48_1.color.g, arg_45_1.hightColor1.g, var_48_3)
								local var_48_6 = Mathf.Lerp(iter_48_1.color.b, arg_45_1.hightColor1.b, var_48_3)

								iter_48_1.color = Color.New(var_48_4, var_48_5, var_48_6)
							else
								local var_48_7 = Mathf.Lerp(iter_48_1.color.r, 1, var_48_3)

								iter_48_1.color = Color.New(var_48_7, var_48_7, var_48_7)
							end
						end
					end
				end
			end

			if arg_45_1.time_ >= var_48_1 + var_48_2 and arg_45_1.time_ < var_48_1 + var_48_2 + arg_48_0 and not isNil(var_48_0) and arg_45_1.var_.actorSpriteComps10121 then
				for iter_48_2, iter_48_3 in pairs(arg_45_1.var_.actorSpriteComps10121:ToTable()) do
					if iter_48_3 then
						if arg_45_1.isInRecall_ then
							iter_48_3.color = arg_45_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_48_3.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_45_1.var_.actorSpriteComps10121 = nil
			end

			local var_48_8 = arg_45_1.actors_["1148"]
			local var_48_9 = 0

			if var_48_9 < arg_45_1.time_ and arg_45_1.time_ <= var_48_9 + arg_48_0 and not isNil(var_48_8) and arg_45_1.var_.actorSpriteComps1148 == nil then
				arg_45_1.var_.actorSpriteComps1148 = var_48_8:GetComponentsInChildren(typeof(Image), true)
			end

			local var_48_10 = 0.125

			if var_48_9 <= arg_45_1.time_ and arg_45_1.time_ < var_48_9 + var_48_10 and not isNil(var_48_8) then
				local var_48_11 = (arg_45_1.time_ - var_48_9) / var_48_10

				if arg_45_1.var_.actorSpriteComps1148 then
					for iter_48_4, iter_48_5 in pairs(arg_45_1.var_.actorSpriteComps1148:ToTable()) do
						if iter_48_5 then
							if arg_45_1.isInRecall_ then
								local var_48_12 = Mathf.Lerp(iter_48_5.color.r, arg_45_1.hightColor2.r, var_48_11)
								local var_48_13 = Mathf.Lerp(iter_48_5.color.g, arg_45_1.hightColor2.g, var_48_11)
								local var_48_14 = Mathf.Lerp(iter_48_5.color.b, arg_45_1.hightColor2.b, var_48_11)

								iter_48_5.color = Color.New(var_48_12, var_48_13, var_48_14)
							else
								local var_48_15 = Mathf.Lerp(iter_48_5.color.r, 0.5, var_48_11)

								iter_48_5.color = Color.New(var_48_15, var_48_15, var_48_15)
							end
						end
					end
				end
			end

			if arg_45_1.time_ >= var_48_9 + var_48_10 and arg_45_1.time_ < var_48_9 + var_48_10 + arg_48_0 and not isNil(var_48_8) and arg_45_1.var_.actorSpriteComps1148 then
				for iter_48_6, iter_48_7 in pairs(arg_45_1.var_.actorSpriteComps1148:ToTable()) do
					if iter_48_7 then
						if arg_45_1.isInRecall_ then
							iter_48_7.color = arg_45_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_48_7.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_45_1.var_.actorSpriteComps1148 = nil
			end

			local var_48_16 = arg_45_1.actors_["1148"].transform
			local var_48_17 = 0

			if var_48_17 < arg_45_1.time_ and arg_45_1.time_ <= var_48_17 + arg_48_0 then
				arg_45_1.var_.moveOldPos1148 = var_48_16.localPosition
				var_48_16.localScale = Vector3.New(1, 1, 1)

				arg_45_1:CheckSpriteTmpPos("1148", 2)

				local var_48_18 = var_48_16.childCount

				for iter_48_8 = 0, var_48_18 - 1 do
					local var_48_19 = var_48_16:GetChild(iter_48_8)

					if var_48_19.name == "" or not string.find(var_48_19.name, "split") then
						var_48_19.gameObject:SetActive(true)
					else
						var_48_19.gameObject:SetActive(false)
					end
				end
			end

			local var_48_20 = 0.001

			if var_48_17 <= arg_45_1.time_ and arg_45_1.time_ < var_48_17 + var_48_20 then
				local var_48_21 = (arg_45_1.time_ - var_48_17) / var_48_20
				local var_48_22 = Vector3.New(-390, -429, -180)

				var_48_16.localPosition = Vector3.Lerp(arg_45_1.var_.moveOldPos1148, var_48_22, var_48_21)
			end

			if arg_45_1.time_ >= var_48_17 + var_48_20 and arg_45_1.time_ < var_48_17 + var_48_20 + arg_48_0 then
				var_48_16.localPosition = Vector3.New(-390, -429, -180)
			end

			local var_48_23 = arg_45_1.actors_["10121"].transform
			local var_48_24 = 0

			if var_48_24 < arg_45_1.time_ and arg_45_1.time_ <= var_48_24 + arg_48_0 then
				arg_45_1.var_.moveOldPos10121 = var_48_23.localPosition
				var_48_23.localScale = Vector3.New(1, 1, 1)

				arg_45_1:CheckSpriteTmpPos("10121", 4)

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
				local var_48_29 = Vector3.New(390, -260.5, -275)

				var_48_23.localPosition = Vector3.Lerp(arg_45_1.var_.moveOldPos10121, var_48_29, var_48_28)
			end

			if arg_45_1.time_ >= var_48_24 + var_48_27 and arg_45_1.time_ < var_48_24 + var_48_27 + arg_48_0 then
				var_48_23.localPosition = Vector3.New(390, -260.5, -275)
			end

			local var_48_30 = 0
			local var_48_31 = 0.55

			if var_48_30 < arg_45_1.time_ and arg_45_1.time_ <= var_48_30 + arg_48_0 then
				arg_45_1.talkMaxDuration = 0
				arg_45_1.dialogCg_.alpha = 1

				arg_45_1.dialog_:SetActive(true)
				SetActive(arg_45_1.leftNameGo_, true)

				local var_48_32 = arg_45_1:FormatText(StoryNameCfg[1081].name)

				arg_45_1.leftNameTxt_.text = var_48_32

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_45_1.leftNameTxt_.transform)

				arg_45_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_45_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_45_1:RecordName(arg_45_1.leftNameTxt_.text)
				SetActive(arg_45_1.iconTrs_.gameObject, false)
				arg_45_1.callingController_:SetSelectedState("normal")

				local var_48_33 = arg_45_1:GetWordFromCfg(416071011)
				local var_48_34 = arg_45_1:FormatText(var_48_33.content)

				arg_45_1.text_.text = var_48_34

				LuaForUtil.ClearLinePrefixSymbol(arg_45_1.text_)

				local var_48_35 = 22
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

				if manager.audio:GetVoiceLength("story_v_out_416071", "416071011", "story_v_out_416071.awb") ~= 0 then
					local var_48_38 = manager.audio:GetVoiceLength("story_v_out_416071", "416071011", "story_v_out_416071.awb") / 1000

					if var_48_38 + var_48_30 > arg_45_1.duration_ then
						arg_45_1.duration_ = var_48_38 + var_48_30
					end

					if var_48_33.prefab_name ~= "" and arg_45_1.actors_[var_48_33.prefab_name] ~= nil then
						local var_48_39 = LuaForUtil.PlayVoiceWithCriLipsync(arg_45_1.actors_[var_48_33.prefab_name].transform, "story_v_out_416071", "416071011", "story_v_out_416071.awb")

						arg_45_1:RecordAudio("416071011", var_48_39)
						arg_45_1:RecordAudio("416071011", var_48_39)
					else
						arg_45_1:AudioAction("play", "voice", "story_v_out_416071", "416071011", "story_v_out_416071.awb")
					end

					arg_45_1:RecordHistoryTalkVoice("story_v_out_416071", "416071011", "story_v_out_416071.awb")
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
				actorName = "1148",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			},
			{
				assetPath = "",
				actorName = "10121",
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
	Play416071012 = function(arg_49_0, arg_49_1)
		arg_49_1.time_ = 0
		arg_49_1.frameCnt_ = 0
		arg_49_1.state_ = "playing"
		arg_49_1.curTalkId_ = 416071012
		arg_49_1.duration_ = 12

		local var_49_0 = {
			zh = 6.9,
			ja = 12
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
				arg_49_0:Play416071013(arg_49_1)
			end
		end

		function arg_49_1.onSingleLineUpdate_(arg_52_0)
			local var_52_0 = 0
			local var_52_1 = 0.95

			if var_52_0 < arg_49_1.time_ and arg_49_1.time_ <= var_52_0 + arg_52_0 then
				arg_49_1.talkMaxDuration = 0
				arg_49_1.dialogCg_.alpha = 1

				arg_49_1.dialog_:SetActive(true)
				SetActive(arg_49_1.leftNameGo_, true)

				local var_52_2 = arg_49_1:FormatText(StoryNameCfg[1081].name)

				arg_49_1.leftNameTxt_.text = var_52_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_49_1.leftNameTxt_.transform)

				arg_49_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_49_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_49_1:RecordName(arg_49_1.leftNameTxt_.text)
				SetActive(arg_49_1.iconTrs_.gameObject, false)
				arg_49_1.callingController_:SetSelectedState("normal")

				local var_52_3 = arg_49_1:GetWordFromCfg(416071012)
				local var_52_4 = arg_49_1:FormatText(var_52_3.content)

				arg_49_1.text_.text = var_52_4

				LuaForUtil.ClearLinePrefixSymbol(arg_49_1.text_)

				local var_52_5 = 38
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

				if manager.audio:GetVoiceLength("story_v_out_416071", "416071012", "story_v_out_416071.awb") ~= 0 then
					local var_52_8 = manager.audio:GetVoiceLength("story_v_out_416071", "416071012", "story_v_out_416071.awb") / 1000

					if var_52_8 + var_52_0 > arg_49_1.duration_ then
						arg_49_1.duration_ = var_52_8 + var_52_0
					end

					if var_52_3.prefab_name ~= "" and arg_49_1.actors_[var_52_3.prefab_name] ~= nil then
						local var_52_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_49_1.actors_[var_52_3.prefab_name].transform, "story_v_out_416071", "416071012", "story_v_out_416071.awb")

						arg_49_1:RecordAudio("416071012", var_52_9)
						arg_49_1:RecordAudio("416071012", var_52_9)
					else
						arg_49_1:AudioAction("play", "voice", "story_v_out_416071", "416071012", "story_v_out_416071.awb")
					end

					arg_49_1:RecordHistoryTalkVoice("story_v_out_416071", "416071012", "story_v_out_416071.awb")
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
	Play416071013 = function(arg_53_0, arg_53_1)
		arg_53_1.time_ = 0
		arg_53_1.frameCnt_ = 0
		arg_53_1.state_ = "playing"
		arg_53_1.curTalkId_ = 416071013
		arg_53_1.duration_ = 12.33

		local var_53_0 = {
			zh = 9.2,
			ja = 12.333
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
				arg_53_0:Play416071014(arg_53_1)
			end
		end

		function arg_53_1.onSingleLineUpdate_(arg_56_0)
			local var_56_0 = arg_53_1.actors_["10121"]
			local var_56_1 = 0

			if var_56_1 < arg_53_1.time_ and arg_53_1.time_ <= var_56_1 + arg_56_0 and not isNil(var_56_0) and arg_53_1.var_.actorSpriteComps10121 == nil then
				arg_53_1.var_.actorSpriteComps10121 = var_56_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_56_2 = 0.125

			if var_56_1 <= arg_53_1.time_ and arg_53_1.time_ < var_56_1 + var_56_2 and not isNil(var_56_0) then
				local var_56_3 = (arg_53_1.time_ - var_56_1) / var_56_2

				if arg_53_1.var_.actorSpriteComps10121 then
					for iter_56_0, iter_56_1 in pairs(arg_53_1.var_.actorSpriteComps10121:ToTable()) do
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

			if arg_53_1.time_ >= var_56_1 + var_56_2 and arg_53_1.time_ < var_56_1 + var_56_2 + arg_56_0 and not isNil(var_56_0) and arg_53_1.var_.actorSpriteComps10121 then
				for iter_56_2, iter_56_3 in pairs(arg_53_1.var_.actorSpriteComps10121:ToTable()) do
					if iter_56_3 then
						if arg_53_1.isInRecall_ then
							iter_56_3.color = arg_53_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_56_3.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_53_1.var_.actorSpriteComps10121 = nil
			end

			local var_56_8 = arg_53_1.actors_["1148"]
			local var_56_9 = 0

			if var_56_9 < arg_53_1.time_ and arg_53_1.time_ <= var_56_9 + arg_56_0 and not isNil(var_56_8) and arg_53_1.var_.actorSpriteComps1148 == nil then
				arg_53_1.var_.actorSpriteComps1148 = var_56_8:GetComponentsInChildren(typeof(Image), true)
			end

			local var_56_10 = 0.125

			if var_56_9 <= arg_53_1.time_ and arg_53_1.time_ < var_56_9 + var_56_10 and not isNil(var_56_8) then
				local var_56_11 = (arg_53_1.time_ - var_56_9) / var_56_10

				if arg_53_1.var_.actorSpriteComps1148 then
					for iter_56_4, iter_56_5 in pairs(arg_53_1.var_.actorSpriteComps1148:ToTable()) do
						if iter_56_5 then
							if arg_53_1.isInRecall_ then
								local var_56_12 = Mathf.Lerp(iter_56_5.color.r, arg_53_1.hightColor1.r, var_56_11)
								local var_56_13 = Mathf.Lerp(iter_56_5.color.g, arg_53_1.hightColor1.g, var_56_11)
								local var_56_14 = Mathf.Lerp(iter_56_5.color.b, arg_53_1.hightColor1.b, var_56_11)

								iter_56_5.color = Color.New(var_56_12, var_56_13, var_56_14)
							else
								local var_56_15 = Mathf.Lerp(iter_56_5.color.r, 1, var_56_11)

								iter_56_5.color = Color.New(var_56_15, var_56_15, var_56_15)
							end
						end
					end
				end
			end

			if arg_53_1.time_ >= var_56_9 + var_56_10 and arg_53_1.time_ < var_56_9 + var_56_10 + arg_56_0 and not isNil(var_56_8) and arg_53_1.var_.actorSpriteComps1148 then
				for iter_56_6, iter_56_7 in pairs(arg_53_1.var_.actorSpriteComps1148:ToTable()) do
					if iter_56_7 then
						if arg_53_1.isInRecall_ then
							iter_56_7.color = arg_53_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_56_7.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_53_1.var_.actorSpriteComps1148 = nil
			end

			local var_56_16 = 0
			local var_56_17 = 1

			if var_56_16 < arg_53_1.time_ and arg_53_1.time_ <= var_56_16 + arg_56_0 then
				arg_53_1.talkMaxDuration = 0
				arg_53_1.dialogCg_.alpha = 1

				arg_53_1.dialog_:SetActive(true)
				SetActive(arg_53_1.leftNameGo_, true)

				local var_56_18 = arg_53_1:FormatText(StoryNameCfg[8].name)

				arg_53_1.leftNameTxt_.text = var_56_18

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_53_1.leftNameTxt_.transform)

				arg_53_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_53_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_53_1:RecordName(arg_53_1.leftNameTxt_.text)
				SetActive(arg_53_1.iconTrs_.gameObject, false)
				arg_53_1.callingController_:SetSelectedState("normal")

				local var_56_19 = arg_53_1:GetWordFromCfg(416071013)
				local var_56_20 = arg_53_1:FormatText(var_56_19.content)

				arg_53_1.text_.text = var_56_20

				LuaForUtil.ClearLinePrefixSymbol(arg_53_1.text_)

				local var_56_21 = 40
				local var_56_22 = utf8.len(var_56_20)
				local var_56_23 = var_56_21 <= 0 and var_56_17 or var_56_17 * (var_56_22 / var_56_21)

				if var_56_23 > 0 and var_56_17 < var_56_23 then
					arg_53_1.talkMaxDuration = var_56_23

					if var_56_23 + var_56_16 > arg_53_1.duration_ then
						arg_53_1.duration_ = var_56_23 + var_56_16
					end
				end

				arg_53_1.text_.text = var_56_20
				arg_53_1.typewritter.percent = 0

				arg_53_1.typewritter:SetDirty()
				arg_53_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_416071", "416071013", "story_v_out_416071.awb") ~= 0 then
					local var_56_24 = manager.audio:GetVoiceLength("story_v_out_416071", "416071013", "story_v_out_416071.awb") / 1000

					if var_56_24 + var_56_16 > arg_53_1.duration_ then
						arg_53_1.duration_ = var_56_24 + var_56_16
					end

					if var_56_19.prefab_name ~= "" and arg_53_1.actors_[var_56_19.prefab_name] ~= nil then
						local var_56_25 = LuaForUtil.PlayVoiceWithCriLipsync(arg_53_1.actors_[var_56_19.prefab_name].transform, "story_v_out_416071", "416071013", "story_v_out_416071.awb")

						arg_53_1:RecordAudio("416071013", var_56_25)
						arg_53_1:RecordAudio("416071013", var_56_25)
					else
						arg_53_1:AudioAction("play", "voice", "story_v_out_416071", "416071013", "story_v_out_416071.awb")
					end

					arg_53_1:RecordHistoryTalkVoice("story_v_out_416071", "416071013", "story_v_out_416071.awb")
				end

				arg_53_1:RecordContent(arg_53_1.text_.text)
			end

			local var_56_26 = math.max(var_56_17, arg_53_1.talkMaxDuration)

			if var_56_16 <= arg_53_1.time_ and arg_53_1.time_ < var_56_16 + var_56_26 then
				arg_53_1.typewritter.percent = (arg_53_1.time_ - var_56_16) / var_56_26

				arg_53_1.typewritter:SetDirty()
			end

			if arg_53_1.time_ >= var_56_16 + var_56_26 and arg_53_1.time_ < var_56_16 + var_56_26 + arg_56_0 then
				arg_53_1.typewritter.percent = 1

				arg_53_1.typewritter:SetDirty()
				arg_53_1:ShowNextGo(true)
			end
		end

		arg_53_1.nodeConfigList_ = {}

		arg_53_1:InitPlayNodeList()
	end,
	Play416071014 = function(arg_57_0, arg_57_1)
		arg_57_1.time_ = 0
		arg_57_1.frameCnt_ = 0
		arg_57_1.state_ = "playing"
		arg_57_1.curTalkId_ = 416071014
		arg_57_1.duration_ = 3.8

		local var_57_0 = {
			zh = 3.5,
			ja = 3.8
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
				arg_57_0:Play416071015(arg_57_1)
			end
		end

		function arg_57_1.onSingleLineUpdate_(arg_60_0)
			local var_60_0 = arg_57_1.actors_["10121"]
			local var_60_1 = 0

			if var_60_1 < arg_57_1.time_ and arg_57_1.time_ <= var_60_1 + arg_60_0 and not isNil(var_60_0) and arg_57_1.var_.actorSpriteComps10121 == nil then
				arg_57_1.var_.actorSpriteComps10121 = var_60_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_60_2 = 0.125

			if var_60_1 <= arg_57_1.time_ and arg_57_1.time_ < var_60_1 + var_60_2 and not isNil(var_60_0) then
				local var_60_3 = (arg_57_1.time_ - var_60_1) / var_60_2

				if arg_57_1.var_.actorSpriteComps10121 then
					for iter_60_0, iter_60_1 in pairs(arg_57_1.var_.actorSpriteComps10121:ToTable()) do
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

			if arg_57_1.time_ >= var_60_1 + var_60_2 and arg_57_1.time_ < var_60_1 + var_60_2 + arg_60_0 and not isNil(var_60_0) and arg_57_1.var_.actorSpriteComps10121 then
				for iter_60_2, iter_60_3 in pairs(arg_57_1.var_.actorSpriteComps10121:ToTable()) do
					if iter_60_3 then
						if arg_57_1.isInRecall_ then
							iter_60_3.color = arg_57_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_60_3.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_57_1.var_.actorSpriteComps10121 = nil
			end

			local var_60_8 = arg_57_1.actors_["1148"]
			local var_60_9 = 0

			if var_60_9 < arg_57_1.time_ and arg_57_1.time_ <= var_60_9 + arg_60_0 and not isNil(var_60_8) and arg_57_1.var_.actorSpriteComps1148 == nil then
				arg_57_1.var_.actorSpriteComps1148 = var_60_8:GetComponentsInChildren(typeof(Image), true)
			end

			local var_60_10 = 0.125

			if var_60_9 <= arg_57_1.time_ and arg_57_1.time_ < var_60_9 + var_60_10 and not isNil(var_60_8) then
				local var_60_11 = (arg_57_1.time_ - var_60_9) / var_60_10

				if arg_57_1.var_.actorSpriteComps1148 then
					for iter_60_4, iter_60_5 in pairs(arg_57_1.var_.actorSpriteComps1148:ToTable()) do
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

			if arg_57_1.time_ >= var_60_9 + var_60_10 and arg_57_1.time_ < var_60_9 + var_60_10 + arg_60_0 and not isNil(var_60_8) and arg_57_1.var_.actorSpriteComps1148 then
				for iter_60_6, iter_60_7 in pairs(arg_57_1.var_.actorSpriteComps1148:ToTable()) do
					if iter_60_7 then
						if arg_57_1.isInRecall_ then
							iter_60_7.color = arg_57_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_60_7.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_57_1.var_.actorSpriteComps1148 = nil
			end

			local var_60_16 = 0
			local var_60_17 = 0.5

			if var_60_16 < arg_57_1.time_ and arg_57_1.time_ <= var_60_16 + arg_60_0 then
				arg_57_1.talkMaxDuration = 0
				arg_57_1.dialogCg_.alpha = 1

				arg_57_1.dialog_:SetActive(true)
				SetActive(arg_57_1.leftNameGo_, true)

				local var_60_18 = arg_57_1:FormatText(StoryNameCfg[1081].name)

				arg_57_1.leftNameTxt_.text = var_60_18

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_57_1.leftNameTxt_.transform)

				arg_57_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_57_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_57_1:RecordName(arg_57_1.leftNameTxt_.text)
				SetActive(arg_57_1.iconTrs_.gameObject, false)
				arg_57_1.callingController_:SetSelectedState("normal")

				local var_60_19 = arg_57_1:GetWordFromCfg(416071014)
				local var_60_20 = arg_57_1:FormatText(var_60_19.content)

				arg_57_1.text_.text = var_60_20

				LuaForUtil.ClearLinePrefixSymbol(arg_57_1.text_)

				local var_60_21 = 20
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

				if manager.audio:GetVoiceLength("story_v_out_416071", "416071014", "story_v_out_416071.awb") ~= 0 then
					local var_60_24 = manager.audio:GetVoiceLength("story_v_out_416071", "416071014", "story_v_out_416071.awb") / 1000

					if var_60_24 + var_60_16 > arg_57_1.duration_ then
						arg_57_1.duration_ = var_60_24 + var_60_16
					end

					if var_60_19.prefab_name ~= "" and arg_57_1.actors_[var_60_19.prefab_name] ~= nil then
						local var_60_25 = LuaForUtil.PlayVoiceWithCriLipsync(arg_57_1.actors_[var_60_19.prefab_name].transform, "story_v_out_416071", "416071014", "story_v_out_416071.awb")

						arg_57_1:RecordAudio("416071014", var_60_25)
						arg_57_1:RecordAudio("416071014", var_60_25)
					else
						arg_57_1:AudioAction("play", "voice", "story_v_out_416071", "416071014", "story_v_out_416071.awb")
					end

					arg_57_1:RecordHistoryTalkVoice("story_v_out_416071", "416071014", "story_v_out_416071.awb")
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
	Play416071015 = function(arg_61_0, arg_61_1)
		arg_61_1.time_ = 0
		arg_61_1.frameCnt_ = 0
		arg_61_1.state_ = "playing"
		arg_61_1.curTalkId_ = 416071015
		arg_61_1.duration_ = 8.07

		local var_61_0 = {
			zh = 4.933,
			ja = 8.066
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
				arg_61_0:Play416071016(arg_61_1)
			end
		end

		function arg_61_1.onSingleLineUpdate_(arg_64_0)
			local var_64_0 = arg_61_1.actors_["10121"]
			local var_64_1 = 0

			if var_64_1 < arg_61_1.time_ and arg_61_1.time_ <= var_64_1 + arg_64_0 and not isNil(var_64_0) and arg_61_1.var_.actorSpriteComps10121 == nil then
				arg_61_1.var_.actorSpriteComps10121 = var_64_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_64_2 = 0.125

			if var_64_1 <= arg_61_1.time_ and arg_61_1.time_ < var_64_1 + var_64_2 and not isNil(var_64_0) then
				local var_64_3 = (arg_61_1.time_ - var_64_1) / var_64_2

				if arg_61_1.var_.actorSpriteComps10121 then
					for iter_64_0, iter_64_1 in pairs(arg_61_1.var_.actorSpriteComps10121:ToTable()) do
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

			if arg_61_1.time_ >= var_64_1 + var_64_2 and arg_61_1.time_ < var_64_1 + var_64_2 + arg_64_0 and not isNil(var_64_0) and arg_61_1.var_.actorSpriteComps10121 then
				for iter_64_2, iter_64_3 in pairs(arg_61_1.var_.actorSpriteComps10121:ToTable()) do
					if iter_64_3 then
						if arg_61_1.isInRecall_ then
							iter_64_3.color = arg_61_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_64_3.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_61_1.var_.actorSpriteComps10121 = nil
			end

			local var_64_8 = arg_61_1.actors_["1148"]
			local var_64_9 = 0

			if var_64_9 < arg_61_1.time_ and arg_61_1.time_ <= var_64_9 + arg_64_0 and not isNil(var_64_8) and arg_61_1.var_.actorSpriteComps1148 == nil then
				arg_61_1.var_.actorSpriteComps1148 = var_64_8:GetComponentsInChildren(typeof(Image), true)
			end

			local var_64_10 = 0.125

			if var_64_9 <= arg_61_1.time_ and arg_61_1.time_ < var_64_9 + var_64_10 and not isNil(var_64_8) then
				local var_64_11 = (arg_61_1.time_ - var_64_9) / var_64_10

				if arg_61_1.var_.actorSpriteComps1148 then
					for iter_64_4, iter_64_5 in pairs(arg_61_1.var_.actorSpriteComps1148:ToTable()) do
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

			if arg_61_1.time_ >= var_64_9 + var_64_10 and arg_61_1.time_ < var_64_9 + var_64_10 + arg_64_0 and not isNil(var_64_8) and arg_61_1.var_.actorSpriteComps1148 then
				for iter_64_6, iter_64_7 in pairs(arg_61_1.var_.actorSpriteComps1148:ToTable()) do
					if iter_64_7 then
						if arg_61_1.isInRecall_ then
							iter_64_7.color = arg_61_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_64_7.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_61_1.var_.actorSpriteComps1148 = nil
			end

			local var_64_16 = 0
			local var_64_17 = 0.5

			if var_64_16 < arg_61_1.time_ and arg_61_1.time_ <= var_64_16 + arg_64_0 then
				arg_61_1.talkMaxDuration = 0
				arg_61_1.dialogCg_.alpha = 1

				arg_61_1.dialog_:SetActive(true)
				SetActive(arg_61_1.leftNameGo_, true)

				local var_64_18 = arg_61_1:FormatText(StoryNameCfg[8].name)

				arg_61_1.leftNameTxt_.text = var_64_18

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_61_1.leftNameTxt_.transform)

				arg_61_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_61_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_61_1:RecordName(arg_61_1.leftNameTxt_.text)
				SetActive(arg_61_1.iconTrs_.gameObject, false)
				arg_61_1.callingController_:SetSelectedState("normal")

				local var_64_19 = arg_61_1:GetWordFromCfg(416071015)
				local var_64_20 = arg_61_1:FormatText(var_64_19.content)

				arg_61_1.text_.text = var_64_20

				LuaForUtil.ClearLinePrefixSymbol(arg_61_1.text_)

				local var_64_21 = 20
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

				if manager.audio:GetVoiceLength("story_v_out_416071", "416071015", "story_v_out_416071.awb") ~= 0 then
					local var_64_24 = manager.audio:GetVoiceLength("story_v_out_416071", "416071015", "story_v_out_416071.awb") / 1000

					if var_64_24 + var_64_16 > arg_61_1.duration_ then
						arg_61_1.duration_ = var_64_24 + var_64_16
					end

					if var_64_19.prefab_name ~= "" and arg_61_1.actors_[var_64_19.prefab_name] ~= nil then
						local var_64_25 = LuaForUtil.PlayVoiceWithCriLipsync(arg_61_1.actors_[var_64_19.prefab_name].transform, "story_v_out_416071", "416071015", "story_v_out_416071.awb")

						arg_61_1:RecordAudio("416071015", var_64_25)
						arg_61_1:RecordAudio("416071015", var_64_25)
					else
						arg_61_1:AudioAction("play", "voice", "story_v_out_416071", "416071015", "story_v_out_416071.awb")
					end

					arg_61_1:RecordHistoryTalkVoice("story_v_out_416071", "416071015", "story_v_out_416071.awb")
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
	Play416071016 = function(arg_65_0, arg_65_1)
		arg_65_1.time_ = 0
		arg_65_1.frameCnt_ = 0
		arg_65_1.state_ = "playing"
		arg_65_1.curTalkId_ = 416071016
		arg_65_1.duration_ = 6.17

		local var_65_0 = {
			zh = 3.966,
			ja = 6.166
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
				arg_65_0:Play416071017(arg_65_1)
			end
		end

		function arg_65_1.onSingleLineUpdate_(arg_68_0)
			local var_68_0 = arg_65_1.actors_["10121"]
			local var_68_1 = 0

			if var_68_1 < arg_65_1.time_ and arg_65_1.time_ <= var_68_1 + arg_68_0 and not isNil(var_68_0) and arg_65_1.var_.actorSpriteComps10121 == nil then
				arg_65_1.var_.actorSpriteComps10121 = var_68_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_68_2 = 0.125

			if var_68_1 <= arg_65_1.time_ and arg_65_1.time_ < var_68_1 + var_68_2 and not isNil(var_68_0) then
				local var_68_3 = (arg_65_1.time_ - var_68_1) / var_68_2

				if arg_65_1.var_.actorSpriteComps10121 then
					for iter_68_0, iter_68_1 in pairs(arg_65_1.var_.actorSpriteComps10121:ToTable()) do
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

			if arg_65_1.time_ >= var_68_1 + var_68_2 and arg_65_1.time_ < var_68_1 + var_68_2 + arg_68_0 and not isNil(var_68_0) and arg_65_1.var_.actorSpriteComps10121 then
				for iter_68_2, iter_68_3 in pairs(arg_65_1.var_.actorSpriteComps10121:ToTable()) do
					if iter_68_3 then
						if arg_65_1.isInRecall_ then
							iter_68_3.color = arg_65_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_68_3.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_65_1.var_.actorSpriteComps10121 = nil
			end

			local var_68_8 = arg_65_1.actors_["1148"]
			local var_68_9 = 0

			if var_68_9 < arg_65_1.time_ and arg_65_1.time_ <= var_68_9 + arg_68_0 and not isNil(var_68_8) and arg_65_1.var_.actorSpriteComps1148 == nil then
				arg_65_1.var_.actorSpriteComps1148 = var_68_8:GetComponentsInChildren(typeof(Image), true)
			end

			local var_68_10 = 0.125

			if var_68_9 <= arg_65_1.time_ and arg_65_1.time_ < var_68_9 + var_68_10 and not isNil(var_68_8) then
				local var_68_11 = (arg_65_1.time_ - var_68_9) / var_68_10

				if arg_65_1.var_.actorSpriteComps1148 then
					for iter_68_4, iter_68_5 in pairs(arg_65_1.var_.actorSpriteComps1148:ToTable()) do
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

			if arg_65_1.time_ >= var_68_9 + var_68_10 and arg_65_1.time_ < var_68_9 + var_68_10 + arg_68_0 and not isNil(var_68_8) and arg_65_1.var_.actorSpriteComps1148 then
				for iter_68_6, iter_68_7 in pairs(arg_65_1.var_.actorSpriteComps1148:ToTable()) do
					if iter_68_7 then
						if arg_65_1.isInRecall_ then
							iter_68_7.color = arg_65_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_68_7.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_65_1.var_.actorSpriteComps1148 = nil
			end

			local var_68_16 = arg_65_1.actors_["10121"].transform
			local var_68_17 = 0

			if var_68_17 < arg_65_1.time_ and arg_65_1.time_ <= var_68_17 + arg_68_0 then
				arg_65_1.var_.moveOldPos10121 = var_68_16.localPosition
				var_68_16.localScale = Vector3.New(1, 1, 1)

				arg_65_1:CheckSpriteTmpPos("10121", 4)

				local var_68_18 = var_68_16.childCount

				for iter_68_8 = 0, var_68_18 - 1 do
					local var_68_19 = var_68_16:GetChild(iter_68_8)

					if var_68_19.name == "" or not string.find(var_68_19.name, "split") then
						var_68_19.gameObject:SetActive(true)
					else
						var_68_19.gameObject:SetActive(false)
					end
				end
			end

			local var_68_20 = 0.001

			if var_68_17 <= arg_65_1.time_ and arg_65_1.time_ < var_68_17 + var_68_20 then
				local var_68_21 = (arg_65_1.time_ - var_68_17) / var_68_20
				local var_68_22 = Vector3.New(390, -260.5, -275)

				var_68_16.localPosition = Vector3.Lerp(arg_65_1.var_.moveOldPos10121, var_68_22, var_68_21)
			end

			if arg_65_1.time_ >= var_68_17 + var_68_20 and arg_65_1.time_ < var_68_17 + var_68_20 + arg_68_0 then
				var_68_16.localPosition = Vector3.New(390, -260.5, -275)
			end

			local var_68_23 = 0
			local var_68_24 = 0.525

			if var_68_23 < arg_65_1.time_ and arg_65_1.time_ <= var_68_23 + arg_68_0 then
				arg_65_1.talkMaxDuration = 0
				arg_65_1.dialogCg_.alpha = 1

				arg_65_1.dialog_:SetActive(true)
				SetActive(arg_65_1.leftNameGo_, true)

				local var_68_25 = arg_65_1:FormatText(StoryNameCfg[1081].name)

				arg_65_1.leftNameTxt_.text = var_68_25

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_65_1.leftNameTxt_.transform)

				arg_65_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_65_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_65_1:RecordName(arg_65_1.leftNameTxt_.text)
				SetActive(arg_65_1.iconTrs_.gameObject, false)
				arg_65_1.callingController_:SetSelectedState("normal")

				local var_68_26 = arg_65_1:GetWordFromCfg(416071016)
				local var_68_27 = arg_65_1:FormatText(var_68_26.content)

				arg_65_1.text_.text = var_68_27

				LuaForUtil.ClearLinePrefixSymbol(arg_65_1.text_)

				local var_68_28 = 21
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

				if manager.audio:GetVoiceLength("story_v_out_416071", "416071016", "story_v_out_416071.awb") ~= 0 then
					local var_68_31 = manager.audio:GetVoiceLength("story_v_out_416071", "416071016", "story_v_out_416071.awb") / 1000

					if var_68_31 + var_68_23 > arg_65_1.duration_ then
						arg_65_1.duration_ = var_68_31 + var_68_23
					end

					if var_68_26.prefab_name ~= "" and arg_65_1.actors_[var_68_26.prefab_name] ~= nil then
						local var_68_32 = LuaForUtil.PlayVoiceWithCriLipsync(arg_65_1.actors_[var_68_26.prefab_name].transform, "story_v_out_416071", "416071016", "story_v_out_416071.awb")

						arg_65_1:RecordAudio("416071016", var_68_32)
						arg_65_1:RecordAudio("416071016", var_68_32)
					else
						arg_65_1:AudioAction("play", "voice", "story_v_out_416071", "416071016", "story_v_out_416071.awb")
					end

					arg_65_1:RecordHistoryTalkVoice("story_v_out_416071", "416071016", "story_v_out_416071.awb")
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
				actorName = "10121",
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
	Play416071017 = function(arg_69_0, arg_69_1)
		arg_69_1.time_ = 0
		arg_69_1.frameCnt_ = 0
		arg_69_1.state_ = "playing"
		arg_69_1.curTalkId_ = 416071017
		arg_69_1.duration_ = 5.13

		local var_69_0 = {
			zh = 4.566,
			ja = 5.133
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
				arg_69_0:Play416071018(arg_69_1)
			end
		end

		function arg_69_1.onSingleLineUpdate_(arg_72_0)
			local var_72_0 = arg_69_1.actors_["10121"]
			local var_72_1 = 0

			if var_72_1 < arg_69_1.time_ and arg_69_1.time_ <= var_72_1 + arg_72_0 and not isNil(var_72_0) and arg_69_1.var_.actorSpriteComps10121 == nil then
				arg_69_1.var_.actorSpriteComps10121 = var_72_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_72_2 = 0.125

			if var_72_1 <= arg_69_1.time_ and arg_69_1.time_ < var_72_1 + var_72_2 and not isNil(var_72_0) then
				local var_72_3 = (arg_69_1.time_ - var_72_1) / var_72_2

				if arg_69_1.var_.actorSpriteComps10121 then
					for iter_72_0, iter_72_1 in pairs(arg_69_1.var_.actorSpriteComps10121:ToTable()) do
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

			if arg_69_1.time_ >= var_72_1 + var_72_2 and arg_69_1.time_ < var_72_1 + var_72_2 + arg_72_0 and not isNil(var_72_0) and arg_69_1.var_.actorSpriteComps10121 then
				for iter_72_2, iter_72_3 in pairs(arg_69_1.var_.actorSpriteComps10121:ToTable()) do
					if iter_72_3 then
						if arg_69_1.isInRecall_ then
							iter_72_3.color = arg_69_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_72_3.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_69_1.var_.actorSpriteComps10121 = nil
			end

			local var_72_8 = arg_69_1.actors_["1148"]
			local var_72_9 = 0

			if var_72_9 < arg_69_1.time_ and arg_69_1.time_ <= var_72_9 + arg_72_0 and not isNil(var_72_8) and arg_69_1.var_.actorSpriteComps1148 == nil then
				arg_69_1.var_.actorSpriteComps1148 = var_72_8:GetComponentsInChildren(typeof(Image), true)
			end

			local var_72_10 = 0.125

			if var_72_9 <= arg_69_1.time_ and arg_69_1.time_ < var_72_9 + var_72_10 and not isNil(var_72_8) then
				local var_72_11 = (arg_69_1.time_ - var_72_9) / var_72_10

				if arg_69_1.var_.actorSpriteComps1148 then
					for iter_72_4, iter_72_5 in pairs(arg_69_1.var_.actorSpriteComps1148:ToTable()) do
						if iter_72_5 then
							if arg_69_1.isInRecall_ then
								local var_72_12 = Mathf.Lerp(iter_72_5.color.r, arg_69_1.hightColor1.r, var_72_11)
								local var_72_13 = Mathf.Lerp(iter_72_5.color.g, arg_69_1.hightColor1.g, var_72_11)
								local var_72_14 = Mathf.Lerp(iter_72_5.color.b, arg_69_1.hightColor1.b, var_72_11)

								iter_72_5.color = Color.New(var_72_12, var_72_13, var_72_14)
							else
								local var_72_15 = Mathf.Lerp(iter_72_5.color.r, 1, var_72_11)

								iter_72_5.color = Color.New(var_72_15, var_72_15, var_72_15)
							end
						end
					end
				end
			end

			if arg_69_1.time_ >= var_72_9 + var_72_10 and arg_69_1.time_ < var_72_9 + var_72_10 + arg_72_0 and not isNil(var_72_8) and arg_69_1.var_.actorSpriteComps1148 then
				for iter_72_6, iter_72_7 in pairs(arg_69_1.var_.actorSpriteComps1148:ToTable()) do
					if iter_72_7 then
						if arg_69_1.isInRecall_ then
							iter_72_7.color = arg_69_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_72_7.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_69_1.var_.actorSpriteComps1148 = nil
			end

			local var_72_16 = 0
			local var_72_17 = 0.525

			if var_72_16 < arg_69_1.time_ and arg_69_1.time_ <= var_72_16 + arg_72_0 then
				arg_69_1.talkMaxDuration = 0
				arg_69_1.dialogCg_.alpha = 1

				arg_69_1.dialog_:SetActive(true)
				SetActive(arg_69_1.leftNameGo_, true)

				local var_72_18 = arg_69_1:FormatText(StoryNameCfg[8].name)

				arg_69_1.leftNameTxt_.text = var_72_18

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_69_1.leftNameTxt_.transform)

				arg_69_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_69_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_69_1:RecordName(arg_69_1.leftNameTxt_.text)
				SetActive(arg_69_1.iconTrs_.gameObject, false)
				arg_69_1.callingController_:SetSelectedState("normal")

				local var_72_19 = arg_69_1:GetWordFromCfg(416071017)
				local var_72_20 = arg_69_1:FormatText(var_72_19.content)

				arg_69_1.text_.text = var_72_20

				LuaForUtil.ClearLinePrefixSymbol(arg_69_1.text_)

				local var_72_21 = 21
				local var_72_22 = utf8.len(var_72_20)
				local var_72_23 = var_72_21 <= 0 and var_72_17 or var_72_17 * (var_72_22 / var_72_21)

				if var_72_23 > 0 and var_72_17 < var_72_23 then
					arg_69_1.talkMaxDuration = var_72_23

					if var_72_23 + var_72_16 > arg_69_1.duration_ then
						arg_69_1.duration_ = var_72_23 + var_72_16
					end
				end

				arg_69_1.text_.text = var_72_20
				arg_69_1.typewritter.percent = 0

				arg_69_1.typewritter:SetDirty()
				arg_69_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_416071", "416071017", "story_v_out_416071.awb") ~= 0 then
					local var_72_24 = manager.audio:GetVoiceLength("story_v_out_416071", "416071017", "story_v_out_416071.awb") / 1000

					if var_72_24 + var_72_16 > arg_69_1.duration_ then
						arg_69_1.duration_ = var_72_24 + var_72_16
					end

					if var_72_19.prefab_name ~= "" and arg_69_1.actors_[var_72_19.prefab_name] ~= nil then
						local var_72_25 = LuaForUtil.PlayVoiceWithCriLipsync(arg_69_1.actors_[var_72_19.prefab_name].transform, "story_v_out_416071", "416071017", "story_v_out_416071.awb")

						arg_69_1:RecordAudio("416071017", var_72_25)
						arg_69_1:RecordAudio("416071017", var_72_25)
					else
						arg_69_1:AudioAction("play", "voice", "story_v_out_416071", "416071017", "story_v_out_416071.awb")
					end

					arg_69_1:RecordHistoryTalkVoice("story_v_out_416071", "416071017", "story_v_out_416071.awb")
				end

				arg_69_1:RecordContent(arg_69_1.text_.text)
			end

			local var_72_26 = math.max(var_72_17, arg_69_1.talkMaxDuration)

			if var_72_16 <= arg_69_1.time_ and arg_69_1.time_ < var_72_16 + var_72_26 then
				arg_69_1.typewritter.percent = (arg_69_1.time_ - var_72_16) / var_72_26

				arg_69_1.typewritter:SetDirty()
			end

			if arg_69_1.time_ >= var_72_16 + var_72_26 and arg_69_1.time_ < var_72_16 + var_72_26 + arg_72_0 then
				arg_69_1.typewritter.percent = 1

				arg_69_1.typewritter:SetDirty()
				arg_69_1:ShowNextGo(true)
			end
		end

		arg_69_1.nodeConfigList_ = {}

		arg_69_1:InitPlayNodeList()
	end,
	Play416071018 = function(arg_73_0, arg_73_1)
		arg_73_1.time_ = 0
		arg_73_1.frameCnt_ = 0
		arg_73_1.state_ = "playing"
		arg_73_1.curTalkId_ = 416071018
		arg_73_1.duration_ = 4.4

		local var_73_0 = {
			zh = 3.566,
			ja = 4.4
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
				arg_73_0:Play416071019(arg_73_1)
			end
		end

		function arg_73_1.onSingleLineUpdate_(arg_76_0)
			local var_76_0 = 0
			local var_76_1 = 0.4

			if var_76_0 < arg_73_1.time_ and arg_73_1.time_ <= var_76_0 + arg_76_0 then
				arg_73_1.talkMaxDuration = 0
				arg_73_1.dialogCg_.alpha = 1

				arg_73_1.dialog_:SetActive(true)
				SetActive(arg_73_1.leftNameGo_, true)

				local var_76_2 = arg_73_1:FormatText(StoryNameCfg[8].name)

				arg_73_1.leftNameTxt_.text = var_76_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_73_1.leftNameTxt_.transform)

				arg_73_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_73_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_73_1:RecordName(arg_73_1.leftNameTxt_.text)
				SetActive(arg_73_1.iconTrs_.gameObject, false)
				arg_73_1.callingController_:SetSelectedState("normal")

				local var_76_3 = arg_73_1:GetWordFromCfg(416071018)
				local var_76_4 = arg_73_1:FormatText(var_76_3.content)

				arg_73_1.text_.text = var_76_4

				LuaForUtil.ClearLinePrefixSymbol(arg_73_1.text_)

				local var_76_5 = 16
				local var_76_6 = utf8.len(var_76_4)
				local var_76_7 = var_76_5 <= 0 and var_76_1 or var_76_1 * (var_76_6 / var_76_5)

				if var_76_7 > 0 and var_76_1 < var_76_7 then
					arg_73_1.talkMaxDuration = var_76_7

					if var_76_7 + var_76_0 > arg_73_1.duration_ then
						arg_73_1.duration_ = var_76_7 + var_76_0
					end
				end

				arg_73_1.text_.text = var_76_4
				arg_73_1.typewritter.percent = 0

				arg_73_1.typewritter:SetDirty()
				arg_73_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_416071", "416071018", "story_v_out_416071.awb") ~= 0 then
					local var_76_8 = manager.audio:GetVoiceLength("story_v_out_416071", "416071018", "story_v_out_416071.awb") / 1000

					if var_76_8 + var_76_0 > arg_73_1.duration_ then
						arg_73_1.duration_ = var_76_8 + var_76_0
					end

					if var_76_3.prefab_name ~= "" and arg_73_1.actors_[var_76_3.prefab_name] ~= nil then
						local var_76_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_73_1.actors_[var_76_3.prefab_name].transform, "story_v_out_416071", "416071018", "story_v_out_416071.awb")

						arg_73_1:RecordAudio("416071018", var_76_9)
						arg_73_1:RecordAudio("416071018", var_76_9)
					else
						arg_73_1:AudioAction("play", "voice", "story_v_out_416071", "416071018", "story_v_out_416071.awb")
					end

					arg_73_1:RecordHistoryTalkVoice("story_v_out_416071", "416071018", "story_v_out_416071.awb")
				end

				arg_73_1:RecordContent(arg_73_1.text_.text)
			end

			local var_76_10 = math.max(var_76_1, arg_73_1.talkMaxDuration)

			if var_76_0 <= arg_73_1.time_ and arg_73_1.time_ < var_76_0 + var_76_10 then
				arg_73_1.typewritter.percent = (arg_73_1.time_ - var_76_0) / var_76_10

				arg_73_1.typewritter:SetDirty()
			end

			if arg_73_1.time_ >= var_76_0 + var_76_10 and arg_73_1.time_ < var_76_0 + var_76_10 + arg_76_0 then
				arg_73_1.typewritter.percent = 1

				arg_73_1.typewritter:SetDirty()
				arg_73_1:ShowNextGo(true)
			end
		end

		arg_73_1.nodeConfigList_ = {}

		arg_73_1:InitPlayNodeList()
	end,
	Play416071019 = function(arg_77_0, arg_77_1)
		arg_77_1.time_ = 0
		arg_77_1.frameCnt_ = 0
		arg_77_1.state_ = "playing"
		arg_77_1.curTalkId_ = 416071019
		arg_77_1.duration_ = 5.6

		local var_77_0 = {
			zh = 3.633,
			ja = 5.6
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
				arg_77_0:Play416071020(arg_77_1)
			end
		end

		function arg_77_1.onSingleLineUpdate_(arg_80_0)
			local var_80_0 = arg_77_1.actors_["10121"]
			local var_80_1 = 0

			if var_80_1 < arg_77_1.time_ and arg_77_1.time_ <= var_80_1 + arg_80_0 and not isNil(var_80_0) and arg_77_1.var_.actorSpriteComps10121 == nil then
				arg_77_1.var_.actorSpriteComps10121 = var_80_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_80_2 = 0.125

			if var_80_1 <= arg_77_1.time_ and arg_77_1.time_ < var_80_1 + var_80_2 and not isNil(var_80_0) then
				local var_80_3 = (arg_77_1.time_ - var_80_1) / var_80_2

				if arg_77_1.var_.actorSpriteComps10121 then
					for iter_80_0, iter_80_1 in pairs(arg_77_1.var_.actorSpriteComps10121:ToTable()) do
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

			if arg_77_1.time_ >= var_80_1 + var_80_2 and arg_77_1.time_ < var_80_1 + var_80_2 + arg_80_0 and not isNil(var_80_0) and arg_77_1.var_.actorSpriteComps10121 then
				for iter_80_2, iter_80_3 in pairs(arg_77_1.var_.actorSpriteComps10121:ToTable()) do
					if iter_80_3 then
						if arg_77_1.isInRecall_ then
							iter_80_3.color = arg_77_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_80_3.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_77_1.var_.actorSpriteComps10121 = nil
			end

			local var_80_8 = arg_77_1.actors_["1148"]
			local var_80_9 = 0

			if var_80_9 < arg_77_1.time_ and arg_77_1.time_ <= var_80_9 + arg_80_0 and not isNil(var_80_8) and arg_77_1.var_.actorSpriteComps1148 == nil then
				arg_77_1.var_.actorSpriteComps1148 = var_80_8:GetComponentsInChildren(typeof(Image), true)
			end

			local var_80_10 = 0.125

			if var_80_9 <= arg_77_1.time_ and arg_77_1.time_ < var_80_9 + var_80_10 and not isNil(var_80_8) then
				local var_80_11 = (arg_77_1.time_ - var_80_9) / var_80_10

				if arg_77_1.var_.actorSpriteComps1148 then
					for iter_80_4, iter_80_5 in pairs(arg_77_1.var_.actorSpriteComps1148:ToTable()) do
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

			if arg_77_1.time_ >= var_80_9 + var_80_10 and arg_77_1.time_ < var_80_9 + var_80_10 + arg_80_0 and not isNil(var_80_8) and arg_77_1.var_.actorSpriteComps1148 then
				for iter_80_6, iter_80_7 in pairs(arg_77_1.var_.actorSpriteComps1148:ToTable()) do
					if iter_80_7 then
						if arg_77_1.isInRecall_ then
							iter_80_7.color = arg_77_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_80_7.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_77_1.var_.actorSpriteComps1148 = nil
			end

			local var_80_16 = 0
			local var_80_17 = 0.475

			if var_80_16 < arg_77_1.time_ and arg_77_1.time_ <= var_80_16 + arg_80_0 then
				arg_77_1.talkMaxDuration = 0
				arg_77_1.dialogCg_.alpha = 1

				arg_77_1.dialog_:SetActive(true)
				SetActive(arg_77_1.leftNameGo_, true)

				local var_80_18 = arg_77_1:FormatText(StoryNameCfg[1081].name)

				arg_77_1.leftNameTxt_.text = var_80_18

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_77_1.leftNameTxt_.transform)

				arg_77_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_77_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_77_1:RecordName(arg_77_1.leftNameTxt_.text)
				SetActive(arg_77_1.iconTrs_.gameObject, false)
				arg_77_1.callingController_:SetSelectedState("normal")

				local var_80_19 = arg_77_1:GetWordFromCfg(416071019)
				local var_80_20 = arg_77_1:FormatText(var_80_19.content)

				arg_77_1.text_.text = var_80_20

				LuaForUtil.ClearLinePrefixSymbol(arg_77_1.text_)

				local var_80_21 = 19
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

				if manager.audio:GetVoiceLength("story_v_out_416071", "416071019", "story_v_out_416071.awb") ~= 0 then
					local var_80_24 = manager.audio:GetVoiceLength("story_v_out_416071", "416071019", "story_v_out_416071.awb") / 1000

					if var_80_24 + var_80_16 > arg_77_1.duration_ then
						arg_77_1.duration_ = var_80_24 + var_80_16
					end

					if var_80_19.prefab_name ~= "" and arg_77_1.actors_[var_80_19.prefab_name] ~= nil then
						local var_80_25 = LuaForUtil.PlayVoiceWithCriLipsync(arg_77_1.actors_[var_80_19.prefab_name].transform, "story_v_out_416071", "416071019", "story_v_out_416071.awb")

						arg_77_1:RecordAudio("416071019", var_80_25)
						arg_77_1:RecordAudio("416071019", var_80_25)
					else
						arg_77_1:AudioAction("play", "voice", "story_v_out_416071", "416071019", "story_v_out_416071.awb")
					end

					arg_77_1:RecordHistoryTalkVoice("story_v_out_416071", "416071019", "story_v_out_416071.awb")
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
	Play416071020 = function(arg_81_0, arg_81_1)
		arg_81_1.time_ = 0
		arg_81_1.frameCnt_ = 0
		arg_81_1.state_ = "playing"
		arg_81_1.curTalkId_ = 416071020
		arg_81_1.duration_ = 14.47

		local var_81_0 = {
			zh = 12.8,
			ja = 14.466
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
				arg_81_0:Play416071021(arg_81_1)
			end
		end

		function arg_81_1.onSingleLineUpdate_(arg_84_0)
			local var_84_0 = "ST0106"

			if arg_81_1.bgs_[var_84_0] == nil then
				local var_84_1 = Object.Instantiate(arg_81_1.paintGo_)

				var_84_1:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. var_84_0)
				var_84_1.name = var_84_0
				var_84_1.transform.parent = arg_81_1.stage_.transform
				var_84_1.transform.localPosition = Vector3.New(0, 100, 0)
				arg_81_1.bgs_[var_84_0] = var_84_1
			end

			local var_84_2 = 2

			if var_84_2 < arg_81_1.time_ and arg_81_1.time_ <= var_84_2 + arg_84_0 then
				local var_84_3 = manager.ui.mainCamera.transform.localPosition
				local var_84_4 = Vector3.New(0, 0, 10) + Vector3.New(var_84_3.x, var_84_3.y, 0)
				local var_84_5 = arg_81_1.bgs_.ST0106

				var_84_5.transform.localPosition = var_84_4
				var_84_5.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_84_6 = var_84_5:GetComponent("SpriteRenderer")

				if var_84_6 and var_84_6.sprite then
					local var_84_7 = (var_84_5.transform.localPosition - var_84_3).z
					local var_84_8 = manager.ui.mainCameraCom_
					local var_84_9 = 2 * var_84_7 * Mathf.Tan(var_84_8.fieldOfView * 0.5 * Mathf.Deg2Rad)
					local var_84_10 = var_84_9 * var_84_8.aspect
					local var_84_11 = var_84_6.sprite.bounds.size.x
					local var_84_12 = var_84_6.sprite.bounds.size.y
					local var_84_13 = var_84_10 / var_84_11
					local var_84_14 = var_84_9 / var_84_12
					local var_84_15 = var_84_14 < var_84_13 and var_84_13 or var_84_14

					var_84_5.transform.localScale = Vector3.New(var_84_15, var_84_15, 0)
				end

				for iter_84_0, iter_84_1 in pairs(arg_81_1.bgs_) do
					if iter_84_0 ~= "ST0106" then
						iter_84_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_84_16 = 4

			if var_84_16 < arg_81_1.time_ and arg_81_1.time_ <= var_84_16 + arg_84_0 then
				arg_81_1.allBtn_.enabled = false
			end

			local var_84_17 = 0.3

			if arg_81_1.time_ >= var_84_16 + var_84_17 and arg_81_1.time_ < var_84_16 + var_84_17 + arg_84_0 then
				arg_81_1.allBtn_.enabled = true
			end

			local var_84_18 = 0

			if var_84_18 < arg_81_1.time_ and arg_81_1.time_ <= var_84_18 + arg_84_0 then
				arg_81_1.mask_.enabled = true
				arg_81_1.mask_.raycastTarget = true

				arg_81_1:SetGaussion(false)
			end

			local var_84_19 = 2

			if var_84_18 <= arg_81_1.time_ and arg_81_1.time_ < var_84_18 + var_84_19 then
				local var_84_20 = (arg_81_1.time_ - var_84_18) / var_84_19
				local var_84_21 = Color.New(0, 0, 0)

				var_84_21.a = Mathf.Lerp(0, 1, var_84_20)
				arg_81_1.mask_.color = var_84_21
			end

			if arg_81_1.time_ >= var_84_18 + var_84_19 and arg_81_1.time_ < var_84_18 + var_84_19 + arg_84_0 then
				local var_84_22 = Color.New(0, 0, 0)

				var_84_22.a = 1
				arg_81_1.mask_.color = var_84_22
			end

			local var_84_23 = 2

			if var_84_23 < arg_81_1.time_ and arg_81_1.time_ <= var_84_23 + arg_84_0 then
				arg_81_1.mask_.enabled = true
				arg_81_1.mask_.raycastTarget = true

				arg_81_1:SetGaussion(false)
			end

			local var_84_24 = 2

			if var_84_23 <= arg_81_1.time_ and arg_81_1.time_ < var_84_23 + var_84_24 then
				local var_84_25 = (arg_81_1.time_ - var_84_23) / var_84_24
				local var_84_26 = Color.New(0, 0, 0)

				var_84_26.a = Mathf.Lerp(1, 0, var_84_25)
				arg_81_1.mask_.color = var_84_26
			end

			if arg_81_1.time_ >= var_84_23 + var_84_24 and arg_81_1.time_ < var_84_23 + var_84_24 + arg_84_0 then
				local var_84_27 = Color.New(0, 0, 0)
				local var_84_28 = 0

				arg_81_1.mask_.enabled = false
				var_84_27.a = var_84_28
				arg_81_1.mask_.color = var_84_27
			end

			local var_84_29 = arg_81_1.actors_["10121"].transform
			local var_84_30 = 1.966

			if var_84_30 < arg_81_1.time_ and arg_81_1.time_ <= var_84_30 + arg_84_0 then
				arg_81_1.var_.moveOldPos10121 = var_84_29.localPosition
				var_84_29.localScale = Vector3.New(1, 1, 1)

				arg_81_1:CheckSpriteTmpPos("10121", 7)

				local var_84_31 = var_84_29.childCount

				for iter_84_2 = 0, var_84_31 - 1 do
					local var_84_32 = var_84_29:GetChild(iter_84_2)

					if var_84_32.name == "" or not string.find(var_84_32.name, "split") then
						var_84_32.gameObject:SetActive(true)
					else
						var_84_32.gameObject:SetActive(false)
					end
				end
			end

			local var_84_33 = 0.001

			if var_84_30 <= arg_81_1.time_ and arg_81_1.time_ < var_84_30 + var_84_33 then
				local var_84_34 = (arg_81_1.time_ - var_84_30) / var_84_33
				local var_84_35 = Vector3.New(0, -2000, 0)

				var_84_29.localPosition = Vector3.Lerp(arg_81_1.var_.moveOldPos10121, var_84_35, var_84_34)
			end

			if arg_81_1.time_ >= var_84_30 + var_84_33 and arg_81_1.time_ < var_84_30 + var_84_33 + arg_84_0 then
				var_84_29.localPosition = Vector3.New(0, -2000, 0)
			end

			local var_84_36 = arg_81_1.actors_["1148"].transform
			local var_84_37 = 1.966

			if var_84_37 < arg_81_1.time_ and arg_81_1.time_ <= var_84_37 + arg_84_0 then
				arg_81_1.var_.moveOldPos1148 = var_84_36.localPosition
				var_84_36.localScale = Vector3.New(1, 1, 1)

				arg_81_1:CheckSpriteTmpPos("1148", 7)

				local var_84_38 = var_84_36.childCount

				for iter_84_3 = 0, var_84_38 - 1 do
					local var_84_39 = var_84_36:GetChild(iter_84_3)

					if var_84_39.name == "" or not string.find(var_84_39.name, "split") then
						var_84_39.gameObject:SetActive(true)
					else
						var_84_39.gameObject:SetActive(false)
					end
				end
			end

			local var_84_40 = 0.001

			if var_84_37 <= arg_81_1.time_ and arg_81_1.time_ < var_84_37 + var_84_40 then
				local var_84_41 = (arg_81_1.time_ - var_84_37) / var_84_40
				local var_84_42 = Vector3.New(0, -2000, 0)

				var_84_36.localPosition = Vector3.Lerp(arg_81_1.var_.moveOldPos1148, var_84_42, var_84_41)
			end

			if arg_81_1.time_ >= var_84_37 + var_84_40 and arg_81_1.time_ < var_84_37 + var_84_40 + arg_84_0 then
				var_84_36.localPosition = Vector3.New(0, -2000, 0)
			end

			local var_84_43 = "10108"

			if arg_81_1.actors_[var_84_43] == nil then
				local var_84_44 = Asset.Load("Widget/System/Story/StoryExpression/" .. "10108")

				if not isNil(var_84_44) then
					local var_84_45 = Object.Instantiate(var_84_44, arg_81_1.canvasGo_.transform)

					var_84_45.transform:SetSiblingIndex(1)

					var_84_45.name = var_84_43
					var_84_45.transform.localPosition = Vector3.New(0, 100000, 0)
					arg_81_1.actors_[var_84_43] = var_84_45

					local var_84_46 = var_84_45:GetComponentsInChildren(typeof(Image), true):ToTable()

					if arg_81_1.isInRecall_ then
						for iter_84_4, iter_84_5 in ipairs(var_84_46) do
							iter_84_5.color = arg_81_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						end
					end
				end
			end

			local var_84_47 = arg_81_1.actors_["10108"].transform
			local var_84_48 = 3.46733333333333

			if var_84_48 < arg_81_1.time_ and arg_81_1.time_ <= var_84_48 + arg_84_0 then
				arg_81_1.var_.moveOldPos10108 = var_84_47.localPosition
				var_84_47.localScale = Vector3.New(1, 1, 1)

				arg_81_1:CheckSpriteTmpPos("10108", 3)

				local var_84_49 = var_84_47.childCount

				for iter_84_6 = 0, var_84_49 - 1 do
					local var_84_50 = var_84_47:GetChild(iter_84_6)

					if var_84_50.name == "" or not string.find(var_84_50.name, "split") then
						var_84_50.gameObject:SetActive(true)
					else
						var_84_50.gameObject:SetActive(false)
					end
				end
			end

			local var_84_51 = 0.001

			if var_84_48 <= arg_81_1.time_ and arg_81_1.time_ < var_84_48 + var_84_51 then
				local var_84_52 = (arg_81_1.time_ - var_84_48) / var_84_51
				local var_84_53 = Vector3.New(0, -399.6, -130)

				var_84_47.localPosition = Vector3.Lerp(arg_81_1.var_.moveOldPos10108, var_84_53, var_84_52)
			end

			if arg_81_1.time_ >= var_84_48 + var_84_51 and arg_81_1.time_ < var_84_48 + var_84_51 + arg_84_0 then
				var_84_47.localPosition = Vector3.New(0, -399.6, -130)
			end

			local var_84_54 = arg_81_1.actors_["10108"]
			local var_84_55 = 3.46733333333333

			if var_84_55 < arg_81_1.time_ and arg_81_1.time_ <= var_84_55 + arg_84_0 and not isNil(var_84_54) and arg_81_1.var_.actorSpriteComps10108 == nil then
				arg_81_1.var_.actorSpriteComps10108 = var_84_54:GetComponentsInChildren(typeof(Image), true)
			end

			local var_84_56 = 0.125

			if var_84_55 <= arg_81_1.time_ and arg_81_1.time_ < var_84_55 + var_84_56 and not isNil(var_84_54) then
				local var_84_57 = (arg_81_1.time_ - var_84_55) / var_84_56

				if arg_81_1.var_.actorSpriteComps10108 then
					for iter_84_7, iter_84_8 in pairs(arg_81_1.var_.actorSpriteComps10108:ToTable()) do
						if iter_84_8 then
							if arg_81_1.isInRecall_ then
								local var_84_58 = Mathf.Lerp(iter_84_8.color.r, arg_81_1.hightColor1.r, var_84_57)
								local var_84_59 = Mathf.Lerp(iter_84_8.color.g, arg_81_1.hightColor1.g, var_84_57)
								local var_84_60 = Mathf.Lerp(iter_84_8.color.b, arg_81_1.hightColor1.b, var_84_57)

								iter_84_8.color = Color.New(var_84_58, var_84_59, var_84_60)
							else
								local var_84_61 = Mathf.Lerp(iter_84_8.color.r, 1, var_84_57)

								iter_84_8.color = Color.New(var_84_61, var_84_61, var_84_61)
							end
						end
					end
				end
			end

			if arg_81_1.time_ >= var_84_55 + var_84_56 and arg_81_1.time_ < var_84_55 + var_84_56 + arg_84_0 and not isNil(var_84_54) and arg_81_1.var_.actorSpriteComps10108 then
				for iter_84_9, iter_84_10 in pairs(arg_81_1.var_.actorSpriteComps10108:ToTable()) do
					if iter_84_10 then
						if arg_81_1.isInRecall_ then
							iter_84_10.color = arg_81_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_84_10.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_81_1.var_.actorSpriteComps10108 = nil
			end

			local var_84_62 = arg_81_1.actors_["10108"]
			local var_84_63 = 3.46733333333333

			if var_84_63 < arg_81_1.time_ and arg_81_1.time_ <= var_84_63 + arg_84_0 then
				local var_84_64 = var_84_62:GetComponentInChildren(typeof(CanvasGroup))

				if var_84_64 then
					arg_81_1.var_.alphaOldValue10108 = var_84_64.alpha
					arg_81_1.var_.characterEffect10108 = var_84_64
				end

				arg_81_1.var_.alphaOldValue10108 = 0
			end

			local var_84_65 = 0.857666666666667

			if var_84_63 <= arg_81_1.time_ and arg_81_1.time_ < var_84_63 + var_84_65 then
				local var_84_66 = (arg_81_1.time_ - var_84_63) / var_84_65
				local var_84_67 = Mathf.Lerp(arg_81_1.var_.alphaOldValue10108, 1, var_84_66)

				if arg_81_1.var_.characterEffect10108 then
					arg_81_1.var_.characterEffect10108.alpha = var_84_67
				end
			end

			if arg_81_1.time_ >= var_84_63 + var_84_65 and arg_81_1.time_ < var_84_63 + var_84_65 + arg_84_0 and arg_81_1.var_.characterEffect10108 then
				arg_81_1.var_.characterEffect10108.alpha = 1
			end

			if arg_81_1.frameCnt_ <= 1 then
				arg_81_1.dialog_:SetActive(false)
			end

			local var_84_68 = 4
			local var_84_69 = 0.85

			if var_84_68 < arg_81_1.time_ and arg_81_1.time_ <= var_84_68 + arg_84_0 then
				arg_81_1.talkMaxDuration = 0

				arg_81_1.dialog_:SetActive(true)

				arg_81_1.dialogCg_.alpha = 0

				local var_84_70 = LeanTween.value(arg_81_1.dialog_, 0, 1, 0.3)

				var_84_70:setOnUpdate(LuaHelper.FloatAction(function(arg_85_0)
					arg_81_1.dialogCg_.alpha = arg_85_0
				end))
				var_84_70:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_81_1.dialog_)
					var_84_70:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_81_1.duration_ = arg_81_1.duration_ + 0.3

				SetActive(arg_81_1.leftNameGo_, true)

				local var_84_71 = arg_81_1:FormatText(StoryNameCfg[1083].name)

				arg_81_1.leftNameTxt_.text = var_84_71

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_81_1.leftNameTxt_.transform)

				arg_81_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_81_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_81_1:RecordName(arg_81_1.leftNameTxt_.text)
				SetActive(arg_81_1.iconTrs_.gameObject, false)
				arg_81_1.callingController_:SetSelectedState("normal")

				local var_84_72 = arg_81_1:GetWordFromCfg(416071020)
				local var_84_73 = arg_81_1:FormatText(var_84_72.content)

				arg_81_1.text_.text = var_84_73

				LuaForUtil.ClearLinePrefixSymbol(arg_81_1.text_)

				local var_84_74 = 34
				local var_84_75 = utf8.len(var_84_73)
				local var_84_76 = var_84_74 <= 0 and var_84_69 or var_84_69 * (var_84_75 / var_84_74)

				if var_84_76 > 0 and var_84_69 < var_84_76 then
					arg_81_1.talkMaxDuration = var_84_76
					var_84_68 = var_84_68 + 0.3

					if var_84_76 + var_84_68 > arg_81_1.duration_ then
						arg_81_1.duration_ = var_84_76 + var_84_68
					end
				end

				arg_81_1.text_.text = var_84_73
				arg_81_1.typewritter.percent = 0

				arg_81_1.typewritter:SetDirty()
				arg_81_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_416071", "416071020", "story_v_out_416071.awb") ~= 0 then
					local var_84_77 = manager.audio:GetVoiceLength("story_v_out_416071", "416071020", "story_v_out_416071.awb") / 1000

					if var_84_77 + var_84_68 > arg_81_1.duration_ then
						arg_81_1.duration_ = var_84_77 + var_84_68
					end

					if var_84_72.prefab_name ~= "" and arg_81_1.actors_[var_84_72.prefab_name] ~= nil then
						local var_84_78 = LuaForUtil.PlayVoiceWithCriLipsync(arg_81_1.actors_[var_84_72.prefab_name].transform, "story_v_out_416071", "416071020", "story_v_out_416071.awb")

						arg_81_1:RecordAudio("416071020", var_84_78)
						arg_81_1:RecordAudio("416071020", var_84_78)
					else
						arg_81_1:AudioAction("play", "voice", "story_v_out_416071", "416071020", "story_v_out_416071.awb")
					end

					arg_81_1:RecordHistoryTalkVoice("story_v_out_416071", "416071020", "story_v_out_416071.awb")
				end

				arg_81_1:RecordContent(arg_81_1.text_.text)
			end

			local var_84_79 = var_84_68 + 0.3
			local var_84_80 = math.max(var_84_69, arg_81_1.talkMaxDuration)

			if var_84_79 <= arg_81_1.time_ and arg_81_1.time_ < var_84_79 + var_84_80 then
				arg_81_1.typewritter.percent = (arg_81_1.time_ - var_84_79) / var_84_80

				arg_81_1.typewritter:SetDirty()
			end

			if arg_81_1.time_ >= var_84_79 + var_84_80 and arg_81_1.time_ < var_84_79 + var_84_80 + arg_84_0 then
				arg_81_1.typewritter.percent = 1

				arg_81_1.typewritter:SetDirty()
				arg_81_1:ShowNextGo(true)
			end
		end

		arg_81_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10121",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 1.966,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			},
			{
				assetPath = "",
				actorName = "1148",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 1.966,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			},
			{
				assetPath = "",
				actorName = "10108",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 3.46733333333333,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_81_1:InitPlayNodeList()
	end,
	Play416071021 = function(arg_87_0, arg_87_1)
		arg_87_1.time_ = 0
		arg_87_1.frameCnt_ = 0
		arg_87_1.state_ = "playing"
		arg_87_1.curTalkId_ = 416071021
		arg_87_1.duration_ = 10.93

		local var_87_0 = {
			zh = 7,
			ja = 10.933
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
				arg_87_0:Play416071022(arg_87_1)
			end
		end

		function arg_87_1.onSingleLineUpdate_(arg_90_0)
			local var_90_0 = arg_87_1.actors_["10108"].transform
			local var_90_1 = 0

			if var_90_1 < arg_87_1.time_ and arg_87_1.time_ <= var_90_1 + arg_90_0 then
				arg_87_1.var_.moveOldPos10108 = var_90_0.localPosition
				var_90_0.localScale = Vector3.New(1, 1, 1)

				arg_87_1:CheckSpriteTmpPos("10108", 2)

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
				local var_90_6 = Vector3.New(-390, -399.6, -130)

				var_90_0.localPosition = Vector3.Lerp(arg_87_1.var_.moveOldPos10108, var_90_6, var_90_5)
			end

			if arg_87_1.time_ >= var_90_1 + var_90_4 and arg_87_1.time_ < var_90_1 + var_90_4 + arg_90_0 then
				var_90_0.localPosition = Vector3.New(-390, -399.6, -130)
			end

			local var_90_7 = arg_87_1.actors_["10108"]
			local var_90_8 = 0

			if var_90_8 < arg_87_1.time_ and arg_87_1.time_ <= var_90_8 + arg_90_0 and not isNil(var_90_7) and arg_87_1.var_.actorSpriteComps10108 == nil then
				arg_87_1.var_.actorSpriteComps10108 = var_90_7:GetComponentsInChildren(typeof(Image), true)
			end

			local var_90_9 = 0.125

			if var_90_8 <= arg_87_1.time_ and arg_87_1.time_ < var_90_8 + var_90_9 and not isNil(var_90_7) then
				local var_90_10 = (arg_87_1.time_ - var_90_8) / var_90_9

				if arg_87_1.var_.actorSpriteComps10108 then
					for iter_90_1, iter_90_2 in pairs(arg_87_1.var_.actorSpriteComps10108:ToTable()) do
						if iter_90_2 then
							if arg_87_1.isInRecall_ then
								local var_90_11 = Mathf.Lerp(iter_90_2.color.r, arg_87_1.hightColor2.r, var_90_10)
								local var_90_12 = Mathf.Lerp(iter_90_2.color.g, arg_87_1.hightColor2.g, var_90_10)
								local var_90_13 = Mathf.Lerp(iter_90_2.color.b, arg_87_1.hightColor2.b, var_90_10)

								iter_90_2.color = Color.New(var_90_11, var_90_12, var_90_13)
							else
								local var_90_14 = Mathf.Lerp(iter_90_2.color.r, 0.5, var_90_10)

								iter_90_2.color = Color.New(var_90_14, var_90_14, var_90_14)
							end
						end
					end
				end
			end

			if arg_87_1.time_ >= var_90_8 + var_90_9 and arg_87_1.time_ < var_90_8 + var_90_9 + arg_90_0 and not isNil(var_90_7) and arg_87_1.var_.actorSpriteComps10108 then
				for iter_90_3, iter_90_4 in pairs(arg_87_1.var_.actorSpriteComps10108:ToTable()) do
					if iter_90_4 then
						if arg_87_1.isInRecall_ then
							iter_90_4.color = arg_87_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_90_4.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_87_1.var_.actorSpriteComps10108 = nil
			end

			local var_90_15 = arg_87_1.actors_["1148"]
			local var_90_16 = 0

			if var_90_16 < arg_87_1.time_ and arg_87_1.time_ <= var_90_16 + arg_90_0 and not isNil(var_90_15) and arg_87_1.var_.actorSpriteComps1148 == nil then
				arg_87_1.var_.actorSpriteComps1148 = var_90_15:GetComponentsInChildren(typeof(Image), true)
			end

			local var_90_17 = 0.125

			if var_90_16 <= arg_87_1.time_ and arg_87_1.time_ < var_90_16 + var_90_17 and not isNil(var_90_15) then
				local var_90_18 = (arg_87_1.time_ - var_90_16) / var_90_17

				if arg_87_1.var_.actorSpriteComps1148 then
					for iter_90_5, iter_90_6 in pairs(arg_87_1.var_.actorSpriteComps1148:ToTable()) do
						if iter_90_6 then
							if arg_87_1.isInRecall_ then
								local var_90_19 = Mathf.Lerp(iter_90_6.color.r, arg_87_1.hightColor1.r, var_90_18)
								local var_90_20 = Mathf.Lerp(iter_90_6.color.g, arg_87_1.hightColor1.g, var_90_18)
								local var_90_21 = Mathf.Lerp(iter_90_6.color.b, arg_87_1.hightColor1.b, var_90_18)

								iter_90_6.color = Color.New(var_90_19, var_90_20, var_90_21)
							else
								local var_90_22 = Mathf.Lerp(iter_90_6.color.r, 1, var_90_18)

								iter_90_6.color = Color.New(var_90_22, var_90_22, var_90_22)
							end
						end
					end
				end
			end

			if arg_87_1.time_ >= var_90_16 + var_90_17 and arg_87_1.time_ < var_90_16 + var_90_17 + arg_90_0 and not isNil(var_90_15) and arg_87_1.var_.actorSpriteComps1148 then
				for iter_90_7, iter_90_8 in pairs(arg_87_1.var_.actorSpriteComps1148:ToTable()) do
					if iter_90_8 then
						if arg_87_1.isInRecall_ then
							iter_90_8.color = arg_87_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_90_8.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_87_1.var_.actorSpriteComps1148 = nil
			end

			local var_90_23 = arg_87_1.actors_["1148"].transform
			local var_90_24 = 0

			if var_90_24 < arg_87_1.time_ and arg_87_1.time_ <= var_90_24 + arg_90_0 then
				arg_87_1.var_.moveOldPos1148 = var_90_23.localPosition
				var_90_23.localScale = Vector3.New(1, 1, 1)

				arg_87_1:CheckSpriteTmpPos("1148", 4)

				local var_90_25 = var_90_23.childCount

				for iter_90_9 = 0, var_90_25 - 1 do
					local var_90_26 = var_90_23:GetChild(iter_90_9)

					if var_90_26.name == "split_1_1" or not string.find(var_90_26.name, "split") then
						var_90_26.gameObject:SetActive(true)
					else
						var_90_26.gameObject:SetActive(false)
					end
				end
			end

			local var_90_27 = 0.001

			if var_90_24 <= arg_87_1.time_ and arg_87_1.time_ < var_90_24 + var_90_27 then
				local var_90_28 = (arg_87_1.time_ - var_90_24) / var_90_27
				local var_90_29 = Vector3.New(390, -429, -180)

				var_90_23.localPosition = Vector3.Lerp(arg_87_1.var_.moveOldPos1148, var_90_29, var_90_28)
			end

			if arg_87_1.time_ >= var_90_24 + var_90_27 and arg_87_1.time_ < var_90_24 + var_90_27 + arg_90_0 then
				var_90_23.localPosition = Vector3.New(390, -429, -180)
			end

			local var_90_30 = 0
			local var_90_31 = 0.725

			if var_90_30 < arg_87_1.time_ and arg_87_1.time_ <= var_90_30 + arg_90_0 then
				arg_87_1.talkMaxDuration = 0
				arg_87_1.dialogCg_.alpha = 1

				arg_87_1.dialog_:SetActive(true)
				SetActive(arg_87_1.leftNameGo_, true)

				local var_90_32 = arg_87_1:FormatText(StoryNameCfg[8].name)

				arg_87_1.leftNameTxt_.text = var_90_32

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_87_1.leftNameTxt_.transform)

				arg_87_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_87_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_87_1:RecordName(arg_87_1.leftNameTxt_.text)
				SetActive(arg_87_1.iconTrs_.gameObject, false)
				arg_87_1.callingController_:SetSelectedState("normal")

				local var_90_33 = arg_87_1:GetWordFromCfg(416071021)
				local var_90_34 = arg_87_1:FormatText(var_90_33.content)

				arg_87_1.text_.text = var_90_34

				LuaForUtil.ClearLinePrefixSymbol(arg_87_1.text_)

				local var_90_35 = 29
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

				if manager.audio:GetVoiceLength("story_v_out_416071", "416071021", "story_v_out_416071.awb") ~= 0 then
					local var_90_38 = manager.audio:GetVoiceLength("story_v_out_416071", "416071021", "story_v_out_416071.awb") / 1000

					if var_90_38 + var_90_30 > arg_87_1.duration_ then
						arg_87_1.duration_ = var_90_38 + var_90_30
					end

					if var_90_33.prefab_name ~= "" and arg_87_1.actors_[var_90_33.prefab_name] ~= nil then
						local var_90_39 = LuaForUtil.PlayVoiceWithCriLipsync(arg_87_1.actors_[var_90_33.prefab_name].transform, "story_v_out_416071", "416071021", "story_v_out_416071.awb")

						arg_87_1:RecordAudio("416071021", var_90_39)
						arg_87_1:RecordAudio("416071021", var_90_39)
					else
						arg_87_1:AudioAction("play", "voice", "story_v_out_416071", "416071021", "story_v_out_416071.awb")
					end

					arg_87_1:RecordHistoryTalkVoice("story_v_out_416071", "416071021", "story_v_out_416071.awb")
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
				actorName = "10108",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			},
			{
				assetPath = "",
				actorName = "1148",
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
	Play416071022 = function(arg_91_0, arg_91_1)
		arg_91_1.time_ = 0
		arg_91_1.frameCnt_ = 0
		arg_91_1.state_ = "playing"
		arg_91_1.curTalkId_ = 416071022
		arg_91_1.duration_ = 18.07

		local var_91_0 = {
			zh = 8,
			ja = 18.066
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
				arg_91_0:Play416071023(arg_91_1)
			end
		end

		function arg_91_1.onSingleLineUpdate_(arg_94_0)
			local var_94_0 = arg_91_1.actors_["10108"]
			local var_94_1 = 0

			if var_94_1 < arg_91_1.time_ and arg_91_1.time_ <= var_94_1 + arg_94_0 and not isNil(var_94_0) and arg_91_1.var_.actorSpriteComps10108 == nil then
				arg_91_1.var_.actorSpriteComps10108 = var_94_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_94_2 = 0.125

			if var_94_1 <= arg_91_1.time_ and arg_91_1.time_ < var_94_1 + var_94_2 and not isNil(var_94_0) then
				local var_94_3 = (arg_91_1.time_ - var_94_1) / var_94_2

				if arg_91_1.var_.actorSpriteComps10108 then
					for iter_94_0, iter_94_1 in pairs(arg_91_1.var_.actorSpriteComps10108:ToTable()) do
						if iter_94_1 then
							if arg_91_1.isInRecall_ then
								local var_94_4 = Mathf.Lerp(iter_94_1.color.r, arg_91_1.hightColor1.r, var_94_3)
								local var_94_5 = Mathf.Lerp(iter_94_1.color.g, arg_91_1.hightColor1.g, var_94_3)
								local var_94_6 = Mathf.Lerp(iter_94_1.color.b, arg_91_1.hightColor1.b, var_94_3)

								iter_94_1.color = Color.New(var_94_4, var_94_5, var_94_6)
							else
								local var_94_7 = Mathf.Lerp(iter_94_1.color.r, 1, var_94_3)

								iter_94_1.color = Color.New(var_94_7, var_94_7, var_94_7)
							end
						end
					end
				end
			end

			if arg_91_1.time_ >= var_94_1 + var_94_2 and arg_91_1.time_ < var_94_1 + var_94_2 + arg_94_0 and not isNil(var_94_0) and arg_91_1.var_.actorSpriteComps10108 then
				for iter_94_2, iter_94_3 in pairs(arg_91_1.var_.actorSpriteComps10108:ToTable()) do
					if iter_94_3 then
						if arg_91_1.isInRecall_ then
							iter_94_3.color = arg_91_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_94_3.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_91_1.var_.actorSpriteComps10108 = nil
			end

			local var_94_8 = arg_91_1.actors_["1148"]
			local var_94_9 = 0

			if var_94_9 < arg_91_1.time_ and arg_91_1.time_ <= var_94_9 + arg_94_0 and not isNil(var_94_8) and arg_91_1.var_.actorSpriteComps1148 == nil then
				arg_91_1.var_.actorSpriteComps1148 = var_94_8:GetComponentsInChildren(typeof(Image), true)
			end

			local var_94_10 = 0.125

			if var_94_9 <= arg_91_1.time_ and arg_91_1.time_ < var_94_9 + var_94_10 and not isNil(var_94_8) then
				local var_94_11 = (arg_91_1.time_ - var_94_9) / var_94_10

				if arg_91_1.var_.actorSpriteComps1148 then
					for iter_94_4, iter_94_5 in pairs(arg_91_1.var_.actorSpriteComps1148:ToTable()) do
						if iter_94_5 then
							if arg_91_1.isInRecall_ then
								local var_94_12 = Mathf.Lerp(iter_94_5.color.r, arg_91_1.hightColor2.r, var_94_11)
								local var_94_13 = Mathf.Lerp(iter_94_5.color.g, arg_91_1.hightColor2.g, var_94_11)
								local var_94_14 = Mathf.Lerp(iter_94_5.color.b, arg_91_1.hightColor2.b, var_94_11)

								iter_94_5.color = Color.New(var_94_12, var_94_13, var_94_14)
							else
								local var_94_15 = Mathf.Lerp(iter_94_5.color.r, 0.5, var_94_11)

								iter_94_5.color = Color.New(var_94_15, var_94_15, var_94_15)
							end
						end
					end
				end
			end

			if arg_91_1.time_ >= var_94_9 + var_94_10 and arg_91_1.time_ < var_94_9 + var_94_10 + arg_94_0 and not isNil(var_94_8) and arg_91_1.var_.actorSpriteComps1148 then
				for iter_94_6, iter_94_7 in pairs(arg_91_1.var_.actorSpriteComps1148:ToTable()) do
					if iter_94_7 then
						if arg_91_1.isInRecall_ then
							iter_94_7.color = arg_91_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_94_7.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_91_1.var_.actorSpriteComps1148 = nil
			end

			local var_94_16 = 0
			local var_94_17 = 0.825

			if var_94_16 < arg_91_1.time_ and arg_91_1.time_ <= var_94_16 + arg_94_0 then
				arg_91_1.talkMaxDuration = 0
				arg_91_1.dialogCg_.alpha = 1

				arg_91_1.dialog_:SetActive(true)
				SetActive(arg_91_1.leftNameGo_, true)

				local var_94_18 = arg_91_1:FormatText(StoryNameCfg[1083].name)

				arg_91_1.leftNameTxt_.text = var_94_18

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_91_1.leftNameTxt_.transform)

				arg_91_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_91_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_91_1:RecordName(arg_91_1.leftNameTxt_.text)
				SetActive(arg_91_1.iconTrs_.gameObject, false)
				arg_91_1.callingController_:SetSelectedState("normal")

				local var_94_19 = arg_91_1:GetWordFromCfg(416071022)
				local var_94_20 = arg_91_1:FormatText(var_94_19.content)

				arg_91_1.text_.text = var_94_20

				LuaForUtil.ClearLinePrefixSymbol(arg_91_1.text_)

				local var_94_21 = 33
				local var_94_22 = utf8.len(var_94_20)
				local var_94_23 = var_94_21 <= 0 and var_94_17 or var_94_17 * (var_94_22 / var_94_21)

				if var_94_23 > 0 and var_94_17 < var_94_23 then
					arg_91_1.talkMaxDuration = var_94_23

					if var_94_23 + var_94_16 > arg_91_1.duration_ then
						arg_91_1.duration_ = var_94_23 + var_94_16
					end
				end

				arg_91_1.text_.text = var_94_20
				arg_91_1.typewritter.percent = 0

				arg_91_1.typewritter:SetDirty()
				arg_91_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_416071", "416071022", "story_v_out_416071.awb") ~= 0 then
					local var_94_24 = manager.audio:GetVoiceLength("story_v_out_416071", "416071022", "story_v_out_416071.awb") / 1000

					if var_94_24 + var_94_16 > arg_91_1.duration_ then
						arg_91_1.duration_ = var_94_24 + var_94_16
					end

					if var_94_19.prefab_name ~= "" and arg_91_1.actors_[var_94_19.prefab_name] ~= nil then
						local var_94_25 = LuaForUtil.PlayVoiceWithCriLipsync(arg_91_1.actors_[var_94_19.prefab_name].transform, "story_v_out_416071", "416071022", "story_v_out_416071.awb")

						arg_91_1:RecordAudio("416071022", var_94_25)
						arg_91_1:RecordAudio("416071022", var_94_25)
					else
						arg_91_1:AudioAction("play", "voice", "story_v_out_416071", "416071022", "story_v_out_416071.awb")
					end

					arg_91_1:RecordHistoryTalkVoice("story_v_out_416071", "416071022", "story_v_out_416071.awb")
				end

				arg_91_1:RecordContent(arg_91_1.text_.text)
			end

			local var_94_26 = math.max(var_94_17, arg_91_1.talkMaxDuration)

			if var_94_16 <= arg_91_1.time_ and arg_91_1.time_ < var_94_16 + var_94_26 then
				arg_91_1.typewritter.percent = (arg_91_1.time_ - var_94_16) / var_94_26

				arg_91_1.typewritter:SetDirty()
			end

			if arg_91_1.time_ >= var_94_16 + var_94_26 and arg_91_1.time_ < var_94_16 + var_94_26 + arg_94_0 then
				arg_91_1.typewritter.percent = 1

				arg_91_1.typewritter:SetDirty()
				arg_91_1:ShowNextGo(true)
			end
		end

		arg_91_1.nodeConfigList_ = {}

		arg_91_1:InitPlayNodeList()
	end,
	Play416071023 = function(arg_95_0, arg_95_1)
		arg_95_1.time_ = 0
		arg_95_1.frameCnt_ = 0
		arg_95_1.state_ = "playing"
		arg_95_1.curTalkId_ = 416071023
		arg_95_1.duration_ = 8.17

		local var_95_0 = {
			zh = 8,
			ja = 8.166
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
				arg_95_0:Play416071024(arg_95_1)
			end
		end

		function arg_95_1.onSingleLineUpdate_(arg_98_0)
			local var_98_0 = arg_95_1.actors_["10108"]
			local var_98_1 = 0

			if var_98_1 < arg_95_1.time_ and arg_95_1.time_ <= var_98_1 + arg_98_0 and not isNil(var_98_0) and arg_95_1.var_.actorSpriteComps10108 == nil then
				arg_95_1.var_.actorSpriteComps10108 = var_98_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_98_2 = 0.125

			if var_98_1 <= arg_95_1.time_ and arg_95_1.time_ < var_98_1 + var_98_2 and not isNil(var_98_0) then
				local var_98_3 = (arg_95_1.time_ - var_98_1) / var_98_2

				if arg_95_1.var_.actorSpriteComps10108 then
					for iter_98_0, iter_98_1 in pairs(arg_95_1.var_.actorSpriteComps10108:ToTable()) do
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

			if arg_95_1.time_ >= var_98_1 + var_98_2 and arg_95_1.time_ < var_98_1 + var_98_2 + arg_98_0 and not isNil(var_98_0) and arg_95_1.var_.actorSpriteComps10108 then
				for iter_98_2, iter_98_3 in pairs(arg_95_1.var_.actorSpriteComps10108:ToTable()) do
					if iter_98_3 then
						if arg_95_1.isInRecall_ then
							iter_98_3.color = arg_95_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_98_3.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_95_1.var_.actorSpriteComps10108 = nil
			end

			local var_98_8 = arg_95_1.actors_["1148"]
			local var_98_9 = 0

			if var_98_9 < arg_95_1.time_ and arg_95_1.time_ <= var_98_9 + arg_98_0 and not isNil(var_98_8) and arg_95_1.var_.actorSpriteComps1148 == nil then
				arg_95_1.var_.actorSpriteComps1148 = var_98_8:GetComponentsInChildren(typeof(Image), true)
			end

			local var_98_10 = 0.125

			if var_98_9 <= arg_95_1.time_ and arg_95_1.time_ < var_98_9 + var_98_10 and not isNil(var_98_8) then
				local var_98_11 = (arg_95_1.time_ - var_98_9) / var_98_10

				if arg_95_1.var_.actorSpriteComps1148 then
					for iter_98_4, iter_98_5 in pairs(arg_95_1.var_.actorSpriteComps1148:ToTable()) do
						if iter_98_5 then
							if arg_95_1.isInRecall_ then
								local var_98_12 = Mathf.Lerp(iter_98_5.color.r, arg_95_1.hightColor1.r, var_98_11)
								local var_98_13 = Mathf.Lerp(iter_98_5.color.g, arg_95_1.hightColor1.g, var_98_11)
								local var_98_14 = Mathf.Lerp(iter_98_5.color.b, arg_95_1.hightColor1.b, var_98_11)

								iter_98_5.color = Color.New(var_98_12, var_98_13, var_98_14)
							else
								local var_98_15 = Mathf.Lerp(iter_98_5.color.r, 1, var_98_11)

								iter_98_5.color = Color.New(var_98_15, var_98_15, var_98_15)
							end
						end
					end
				end
			end

			if arg_95_1.time_ >= var_98_9 + var_98_10 and arg_95_1.time_ < var_98_9 + var_98_10 + arg_98_0 and not isNil(var_98_8) and arg_95_1.var_.actorSpriteComps1148 then
				for iter_98_6, iter_98_7 in pairs(arg_95_1.var_.actorSpriteComps1148:ToTable()) do
					if iter_98_7 then
						if arg_95_1.isInRecall_ then
							iter_98_7.color = arg_95_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_98_7.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_95_1.var_.actorSpriteComps1148 = nil
			end

			local var_98_16 = arg_95_1.actors_["1148"].transform
			local var_98_17 = 0

			if var_98_17 < arg_95_1.time_ and arg_95_1.time_ <= var_98_17 + arg_98_0 then
				arg_95_1.var_.moveOldPos1148 = var_98_16.localPosition
				var_98_16.localScale = Vector3.New(1, 1, 1)

				arg_95_1:CheckSpriteTmpPos("1148", 4)

				local var_98_18 = var_98_16.childCount

				for iter_98_8 = 0, var_98_18 - 1 do
					local var_98_19 = var_98_16:GetChild(iter_98_8)

					if var_98_19.name == "split_5" or not string.find(var_98_19.name, "split") then
						var_98_19.gameObject:SetActive(true)
					else
						var_98_19.gameObject:SetActive(false)
					end
				end
			end

			local var_98_20 = 0.001

			if var_98_17 <= arg_95_1.time_ and arg_95_1.time_ < var_98_17 + var_98_20 then
				local var_98_21 = (arg_95_1.time_ - var_98_17) / var_98_20
				local var_98_22 = Vector3.New(390, -429, -180)

				var_98_16.localPosition = Vector3.Lerp(arg_95_1.var_.moveOldPos1148, var_98_22, var_98_21)
			end

			if arg_95_1.time_ >= var_98_17 + var_98_20 and arg_95_1.time_ < var_98_17 + var_98_20 + arg_98_0 then
				var_98_16.localPosition = Vector3.New(390, -429, -180)
			end

			local var_98_23 = 0
			local var_98_24 = 0.5

			if var_98_23 < arg_95_1.time_ and arg_95_1.time_ <= var_98_23 + arg_98_0 then
				arg_95_1.talkMaxDuration = 0
				arg_95_1.dialogCg_.alpha = 1

				arg_95_1.dialog_:SetActive(true)
				SetActive(arg_95_1.leftNameGo_, true)

				local var_98_25 = arg_95_1:FormatText(StoryNameCfg[8].name)

				arg_95_1.leftNameTxt_.text = var_98_25

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_95_1.leftNameTxt_.transform)

				arg_95_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_95_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_95_1:RecordName(arg_95_1.leftNameTxt_.text)
				SetActive(arg_95_1.iconTrs_.gameObject, false)
				arg_95_1.callingController_:SetSelectedState("normal")

				local var_98_26 = arg_95_1:GetWordFromCfg(416071023)
				local var_98_27 = arg_95_1:FormatText(var_98_26.content)

				arg_95_1.text_.text = var_98_27

				LuaForUtil.ClearLinePrefixSymbol(arg_95_1.text_)

				local var_98_28 = 20
				local var_98_29 = utf8.len(var_98_27)
				local var_98_30 = var_98_28 <= 0 and var_98_24 or var_98_24 * (var_98_29 / var_98_28)

				if var_98_30 > 0 and var_98_24 < var_98_30 then
					arg_95_1.talkMaxDuration = var_98_30

					if var_98_30 + var_98_23 > arg_95_1.duration_ then
						arg_95_1.duration_ = var_98_30 + var_98_23
					end
				end

				arg_95_1.text_.text = var_98_27
				arg_95_1.typewritter.percent = 0

				arg_95_1.typewritter:SetDirty()
				arg_95_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_416071", "416071023", "story_v_out_416071.awb") ~= 0 then
					local var_98_31 = manager.audio:GetVoiceLength("story_v_out_416071", "416071023", "story_v_out_416071.awb") / 1000

					if var_98_31 + var_98_23 > arg_95_1.duration_ then
						arg_95_1.duration_ = var_98_31 + var_98_23
					end

					if var_98_26.prefab_name ~= "" and arg_95_1.actors_[var_98_26.prefab_name] ~= nil then
						local var_98_32 = LuaForUtil.PlayVoiceWithCriLipsync(arg_95_1.actors_[var_98_26.prefab_name].transform, "story_v_out_416071", "416071023", "story_v_out_416071.awb")

						arg_95_1:RecordAudio("416071023", var_98_32)
						arg_95_1:RecordAudio("416071023", var_98_32)
					else
						arg_95_1:AudioAction("play", "voice", "story_v_out_416071", "416071023", "story_v_out_416071.awb")
					end

					arg_95_1:RecordHistoryTalkVoice("story_v_out_416071", "416071023", "story_v_out_416071.awb")
				end

				arg_95_1:RecordContent(arg_95_1.text_.text)
			end

			local var_98_33 = math.max(var_98_24, arg_95_1.talkMaxDuration)

			if var_98_23 <= arg_95_1.time_ and arg_95_1.time_ < var_98_23 + var_98_33 then
				arg_95_1.typewritter.percent = (arg_95_1.time_ - var_98_23) / var_98_33

				arg_95_1.typewritter:SetDirty()
			end

			if arg_95_1.time_ >= var_98_23 + var_98_33 and arg_95_1.time_ < var_98_23 + var_98_33 + arg_98_0 then
				arg_95_1.typewritter.percent = 1

				arg_95_1.typewritter:SetDirty()
				arg_95_1:ShowNextGo(true)
			end
		end

		arg_95_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1148",
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
	Play416071024 = function(arg_99_0, arg_99_1)
		arg_99_1.time_ = 0
		arg_99_1.frameCnt_ = 0
		arg_99_1.state_ = "playing"
		arg_99_1.curTalkId_ = 416071024
		arg_99_1.duration_ = 8.17

		local var_99_0 = {
			zh = 7.1,
			ja = 8.166
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
				arg_99_0:Play416071025(arg_99_1)
			end
		end

		function arg_99_1.onSingleLineUpdate_(arg_102_0)
			local var_102_0 = arg_99_1.actors_["1148"].transform
			local var_102_1 = 0

			if var_102_1 < arg_99_1.time_ and arg_99_1.time_ <= var_102_1 + arg_102_0 then
				arg_99_1.var_.moveOldPos1148 = var_102_0.localPosition
				var_102_0.localScale = Vector3.New(1, 1, 1)

				arg_99_1:CheckSpriteTmpPos("1148", 4)

				local var_102_2 = var_102_0.childCount

				for iter_102_0 = 0, var_102_2 - 1 do
					local var_102_3 = var_102_0:GetChild(iter_102_0)

					if var_102_3.name == "split_2" or not string.find(var_102_3.name, "split") then
						var_102_3.gameObject:SetActive(true)
					else
						var_102_3.gameObject:SetActive(false)
					end
				end
			end

			local var_102_4 = 0.001

			if var_102_1 <= arg_99_1.time_ and arg_99_1.time_ < var_102_1 + var_102_4 then
				local var_102_5 = (arg_99_1.time_ - var_102_1) / var_102_4
				local var_102_6 = Vector3.New(390, -429, -180)

				var_102_0.localPosition = Vector3.Lerp(arg_99_1.var_.moveOldPos1148, var_102_6, var_102_5)
			end

			if arg_99_1.time_ >= var_102_1 + var_102_4 and arg_99_1.time_ < var_102_1 + var_102_4 + arg_102_0 then
				var_102_0.localPosition = Vector3.New(390, -429, -180)
			end

			local var_102_7 = 0
			local var_102_8 = 0.7

			if var_102_7 < arg_99_1.time_ and arg_99_1.time_ <= var_102_7 + arg_102_0 then
				arg_99_1.talkMaxDuration = 0
				arg_99_1.dialogCg_.alpha = 1

				arg_99_1.dialog_:SetActive(true)
				SetActive(arg_99_1.leftNameGo_, true)

				local var_102_9 = arg_99_1:FormatText(StoryNameCfg[8].name)

				arg_99_1.leftNameTxt_.text = var_102_9

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_99_1.leftNameTxt_.transform)

				arg_99_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_99_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_99_1:RecordName(arg_99_1.leftNameTxt_.text)
				SetActive(arg_99_1.iconTrs_.gameObject, false)
				arg_99_1.callingController_:SetSelectedState("normal")

				local var_102_10 = arg_99_1:GetWordFromCfg(416071024)
				local var_102_11 = arg_99_1:FormatText(var_102_10.content)

				arg_99_1.text_.text = var_102_11

				LuaForUtil.ClearLinePrefixSymbol(arg_99_1.text_)

				local var_102_12 = 28
				local var_102_13 = utf8.len(var_102_11)
				local var_102_14 = var_102_12 <= 0 and var_102_8 or var_102_8 * (var_102_13 / var_102_12)

				if var_102_14 > 0 and var_102_8 < var_102_14 then
					arg_99_1.talkMaxDuration = var_102_14

					if var_102_14 + var_102_7 > arg_99_1.duration_ then
						arg_99_1.duration_ = var_102_14 + var_102_7
					end
				end

				arg_99_1.text_.text = var_102_11
				arg_99_1.typewritter.percent = 0

				arg_99_1.typewritter:SetDirty()
				arg_99_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_416071", "416071024", "story_v_out_416071.awb") ~= 0 then
					local var_102_15 = manager.audio:GetVoiceLength("story_v_out_416071", "416071024", "story_v_out_416071.awb") / 1000

					if var_102_15 + var_102_7 > arg_99_1.duration_ then
						arg_99_1.duration_ = var_102_15 + var_102_7
					end

					if var_102_10.prefab_name ~= "" and arg_99_1.actors_[var_102_10.prefab_name] ~= nil then
						local var_102_16 = LuaForUtil.PlayVoiceWithCriLipsync(arg_99_1.actors_[var_102_10.prefab_name].transform, "story_v_out_416071", "416071024", "story_v_out_416071.awb")

						arg_99_1:RecordAudio("416071024", var_102_16)
						arg_99_1:RecordAudio("416071024", var_102_16)
					else
						arg_99_1:AudioAction("play", "voice", "story_v_out_416071", "416071024", "story_v_out_416071.awb")
					end

					arg_99_1:RecordHistoryTalkVoice("story_v_out_416071", "416071024", "story_v_out_416071.awb")
				end

				arg_99_1:RecordContent(arg_99_1.text_.text)
			end

			local var_102_17 = math.max(var_102_8, arg_99_1.talkMaxDuration)

			if var_102_7 <= arg_99_1.time_ and arg_99_1.time_ < var_102_7 + var_102_17 then
				arg_99_1.typewritter.percent = (arg_99_1.time_ - var_102_7) / var_102_17

				arg_99_1.typewritter:SetDirty()
			end

			if arg_99_1.time_ >= var_102_7 + var_102_17 and arg_99_1.time_ < var_102_7 + var_102_17 + arg_102_0 then
				arg_99_1.typewritter.percent = 1

				arg_99_1.typewritter:SetDirty()
				arg_99_1:ShowNextGo(true)
			end
		end

		arg_99_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1148",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_99_1:InitPlayNodeList()
	end,
	Play416071025 = function(arg_103_0, arg_103_1)
		arg_103_1.time_ = 0
		arg_103_1.frameCnt_ = 0
		arg_103_1.state_ = "playing"
		arg_103_1.curTalkId_ = 416071025
		arg_103_1.duration_ = 16.03

		local var_103_0 = {
			zh = 9.5,
			ja = 16.033
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
				arg_103_0:Play416071026(arg_103_1)
			end
		end

		function arg_103_1.onSingleLineUpdate_(arg_106_0)
			local var_106_0 = arg_103_1.actors_["10108"]
			local var_106_1 = 0

			if var_106_1 < arg_103_1.time_ and arg_103_1.time_ <= var_106_1 + arg_106_0 and not isNil(var_106_0) and arg_103_1.var_.actorSpriteComps10108 == nil then
				arg_103_1.var_.actorSpriteComps10108 = var_106_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_106_2 = 0.125

			if var_106_1 <= arg_103_1.time_ and arg_103_1.time_ < var_106_1 + var_106_2 and not isNil(var_106_0) then
				local var_106_3 = (arg_103_1.time_ - var_106_1) / var_106_2

				if arg_103_1.var_.actorSpriteComps10108 then
					for iter_106_0, iter_106_1 in pairs(arg_103_1.var_.actorSpriteComps10108:ToTable()) do
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

			if arg_103_1.time_ >= var_106_1 + var_106_2 and arg_103_1.time_ < var_106_1 + var_106_2 + arg_106_0 and not isNil(var_106_0) and arg_103_1.var_.actorSpriteComps10108 then
				for iter_106_2, iter_106_3 in pairs(arg_103_1.var_.actorSpriteComps10108:ToTable()) do
					if iter_106_3 then
						if arg_103_1.isInRecall_ then
							iter_106_3.color = arg_103_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_106_3.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_103_1.var_.actorSpriteComps10108 = nil
			end

			local var_106_8 = arg_103_1.actors_["1148"]
			local var_106_9 = 0

			if var_106_9 < arg_103_1.time_ and arg_103_1.time_ <= var_106_9 + arg_106_0 and not isNil(var_106_8) and arg_103_1.var_.actorSpriteComps1148 == nil then
				arg_103_1.var_.actorSpriteComps1148 = var_106_8:GetComponentsInChildren(typeof(Image), true)
			end

			local var_106_10 = 0.125

			if var_106_9 <= arg_103_1.time_ and arg_103_1.time_ < var_106_9 + var_106_10 and not isNil(var_106_8) then
				local var_106_11 = (arg_103_1.time_ - var_106_9) / var_106_10

				if arg_103_1.var_.actorSpriteComps1148 then
					for iter_106_4, iter_106_5 in pairs(arg_103_1.var_.actorSpriteComps1148:ToTable()) do
						if iter_106_5 then
							if arg_103_1.isInRecall_ then
								local var_106_12 = Mathf.Lerp(iter_106_5.color.r, arg_103_1.hightColor2.r, var_106_11)
								local var_106_13 = Mathf.Lerp(iter_106_5.color.g, arg_103_1.hightColor2.g, var_106_11)
								local var_106_14 = Mathf.Lerp(iter_106_5.color.b, arg_103_1.hightColor2.b, var_106_11)

								iter_106_5.color = Color.New(var_106_12, var_106_13, var_106_14)
							else
								local var_106_15 = Mathf.Lerp(iter_106_5.color.r, 0.5, var_106_11)

								iter_106_5.color = Color.New(var_106_15, var_106_15, var_106_15)
							end
						end
					end
				end
			end

			if arg_103_1.time_ >= var_106_9 + var_106_10 and arg_103_1.time_ < var_106_9 + var_106_10 + arg_106_0 and not isNil(var_106_8) and arg_103_1.var_.actorSpriteComps1148 then
				for iter_106_6, iter_106_7 in pairs(arg_103_1.var_.actorSpriteComps1148:ToTable()) do
					if iter_106_7 then
						if arg_103_1.isInRecall_ then
							iter_106_7.color = arg_103_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_106_7.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_103_1.var_.actorSpriteComps1148 = nil
			end

			local var_106_16 = 0
			local var_106_17 = 0.775

			if var_106_16 < arg_103_1.time_ and arg_103_1.time_ <= var_106_16 + arg_106_0 then
				arg_103_1.talkMaxDuration = 0
				arg_103_1.dialogCg_.alpha = 1

				arg_103_1.dialog_:SetActive(true)
				SetActive(arg_103_1.leftNameGo_, true)

				local var_106_18 = arg_103_1:FormatText(StoryNameCfg[1083].name)

				arg_103_1.leftNameTxt_.text = var_106_18

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_103_1.leftNameTxt_.transform)

				arg_103_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_103_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_103_1:RecordName(arg_103_1.leftNameTxt_.text)
				SetActive(arg_103_1.iconTrs_.gameObject, false)
				arg_103_1.callingController_:SetSelectedState("normal")

				local var_106_19 = arg_103_1:GetWordFromCfg(416071025)
				local var_106_20 = arg_103_1:FormatText(var_106_19.content)

				arg_103_1.text_.text = var_106_20

				LuaForUtil.ClearLinePrefixSymbol(arg_103_1.text_)

				local var_106_21 = 31
				local var_106_22 = utf8.len(var_106_20)
				local var_106_23 = var_106_21 <= 0 and var_106_17 or var_106_17 * (var_106_22 / var_106_21)

				if var_106_23 > 0 and var_106_17 < var_106_23 then
					arg_103_1.talkMaxDuration = var_106_23

					if var_106_23 + var_106_16 > arg_103_1.duration_ then
						arg_103_1.duration_ = var_106_23 + var_106_16
					end
				end

				arg_103_1.text_.text = var_106_20
				arg_103_1.typewritter.percent = 0

				arg_103_1.typewritter:SetDirty()
				arg_103_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_416071", "416071025", "story_v_out_416071.awb") ~= 0 then
					local var_106_24 = manager.audio:GetVoiceLength("story_v_out_416071", "416071025", "story_v_out_416071.awb") / 1000

					if var_106_24 + var_106_16 > arg_103_1.duration_ then
						arg_103_1.duration_ = var_106_24 + var_106_16
					end

					if var_106_19.prefab_name ~= "" and arg_103_1.actors_[var_106_19.prefab_name] ~= nil then
						local var_106_25 = LuaForUtil.PlayVoiceWithCriLipsync(arg_103_1.actors_[var_106_19.prefab_name].transform, "story_v_out_416071", "416071025", "story_v_out_416071.awb")

						arg_103_1:RecordAudio("416071025", var_106_25)
						arg_103_1:RecordAudio("416071025", var_106_25)
					else
						arg_103_1:AudioAction("play", "voice", "story_v_out_416071", "416071025", "story_v_out_416071.awb")
					end

					arg_103_1:RecordHistoryTalkVoice("story_v_out_416071", "416071025", "story_v_out_416071.awb")
				end

				arg_103_1:RecordContent(arg_103_1.text_.text)
			end

			local var_106_26 = math.max(var_106_17, arg_103_1.talkMaxDuration)

			if var_106_16 <= arg_103_1.time_ and arg_103_1.time_ < var_106_16 + var_106_26 then
				arg_103_1.typewritter.percent = (arg_103_1.time_ - var_106_16) / var_106_26

				arg_103_1.typewritter:SetDirty()
			end

			if arg_103_1.time_ >= var_106_16 + var_106_26 and arg_103_1.time_ < var_106_16 + var_106_26 + arg_106_0 then
				arg_103_1.typewritter.percent = 1

				arg_103_1.typewritter:SetDirty()
				arg_103_1:ShowNextGo(true)
			end
		end

		arg_103_1.nodeConfigList_ = {}

		arg_103_1:InitPlayNodeList()
	end,
	Play416071026 = function(arg_107_0, arg_107_1)
		arg_107_1.time_ = 0
		arg_107_1.frameCnt_ = 0
		arg_107_1.state_ = "playing"
		arg_107_1.curTalkId_ = 416071026
		arg_107_1.duration_ = 6.23

		local var_107_0 = {
			zh = 4,
			ja = 6.233
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
				arg_107_0:Play416071027(arg_107_1)
			end
		end

		function arg_107_1.onSingleLineUpdate_(arg_110_0)
			local var_110_0 = arg_107_1.actors_["10108"]
			local var_110_1 = 0

			if var_110_1 < arg_107_1.time_ and arg_107_1.time_ <= var_110_1 + arg_110_0 and not isNil(var_110_0) and arg_107_1.var_.actorSpriteComps10108 == nil then
				arg_107_1.var_.actorSpriteComps10108 = var_110_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_110_2 = 0.125

			if var_110_1 <= arg_107_1.time_ and arg_107_1.time_ < var_110_1 + var_110_2 and not isNil(var_110_0) then
				local var_110_3 = (arg_107_1.time_ - var_110_1) / var_110_2

				if arg_107_1.var_.actorSpriteComps10108 then
					for iter_110_0, iter_110_1 in pairs(arg_107_1.var_.actorSpriteComps10108:ToTable()) do
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

			if arg_107_1.time_ >= var_110_1 + var_110_2 and arg_107_1.time_ < var_110_1 + var_110_2 + arg_110_0 and not isNil(var_110_0) and arg_107_1.var_.actorSpriteComps10108 then
				for iter_110_2, iter_110_3 in pairs(arg_107_1.var_.actorSpriteComps10108:ToTable()) do
					if iter_110_3 then
						if arg_107_1.isInRecall_ then
							iter_110_3.color = arg_107_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_110_3.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_107_1.var_.actorSpriteComps10108 = nil
			end

			local var_110_8 = arg_107_1.actors_["1148"]
			local var_110_9 = 0

			if var_110_9 < arg_107_1.time_ and arg_107_1.time_ <= var_110_9 + arg_110_0 and not isNil(var_110_8) and arg_107_1.var_.actorSpriteComps1148 == nil then
				arg_107_1.var_.actorSpriteComps1148 = var_110_8:GetComponentsInChildren(typeof(Image), true)
			end

			local var_110_10 = 0.125

			if var_110_9 <= arg_107_1.time_ and arg_107_1.time_ < var_110_9 + var_110_10 and not isNil(var_110_8) then
				local var_110_11 = (arg_107_1.time_ - var_110_9) / var_110_10

				if arg_107_1.var_.actorSpriteComps1148 then
					for iter_110_4, iter_110_5 in pairs(arg_107_1.var_.actorSpriteComps1148:ToTable()) do
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

			if arg_107_1.time_ >= var_110_9 + var_110_10 and arg_107_1.time_ < var_110_9 + var_110_10 + arg_110_0 and not isNil(var_110_8) and arg_107_1.var_.actorSpriteComps1148 then
				for iter_110_6, iter_110_7 in pairs(arg_107_1.var_.actorSpriteComps1148:ToTable()) do
					if iter_110_7 then
						if arg_107_1.isInRecall_ then
							iter_110_7.color = arg_107_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_110_7.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_107_1.var_.actorSpriteComps1148 = nil
			end

			local var_110_16 = arg_107_1.actors_["1148"].transform
			local var_110_17 = 0

			if var_110_17 < arg_107_1.time_ and arg_107_1.time_ <= var_110_17 + arg_110_0 then
				arg_107_1.var_.moveOldPos1148 = var_110_16.localPosition
				var_110_16.localScale = Vector3.New(1, 1, 1)

				arg_107_1:CheckSpriteTmpPos("1148", 4)

				local var_110_18 = var_110_16.childCount

				for iter_110_8 = 0, var_110_18 - 1 do
					local var_110_19 = var_110_16:GetChild(iter_110_8)

					if var_110_19.name == "split_1_1" or not string.find(var_110_19.name, "split") then
						var_110_19.gameObject:SetActive(true)
					else
						var_110_19.gameObject:SetActive(false)
					end
				end
			end

			local var_110_20 = 0.001

			if var_110_17 <= arg_107_1.time_ and arg_107_1.time_ < var_110_17 + var_110_20 then
				local var_110_21 = (arg_107_1.time_ - var_110_17) / var_110_20
				local var_110_22 = Vector3.New(390, -429, -180)

				var_110_16.localPosition = Vector3.Lerp(arg_107_1.var_.moveOldPos1148, var_110_22, var_110_21)
			end

			if arg_107_1.time_ >= var_110_17 + var_110_20 and arg_107_1.time_ < var_110_17 + var_110_20 + arg_110_0 then
				var_110_16.localPosition = Vector3.New(390, -429, -180)
			end

			local var_110_23 = 0
			local var_110_24 = 0.475

			if var_110_23 < arg_107_1.time_ and arg_107_1.time_ <= var_110_23 + arg_110_0 then
				arg_107_1.talkMaxDuration = 0
				arg_107_1.dialogCg_.alpha = 1

				arg_107_1.dialog_:SetActive(true)
				SetActive(arg_107_1.leftNameGo_, true)

				local var_110_25 = arg_107_1:FormatText(StoryNameCfg[8].name)

				arg_107_1.leftNameTxt_.text = var_110_25

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_107_1.leftNameTxt_.transform)

				arg_107_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_107_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_107_1:RecordName(arg_107_1.leftNameTxt_.text)
				SetActive(arg_107_1.iconTrs_.gameObject, false)
				arg_107_1.callingController_:SetSelectedState("normal")

				local var_110_26 = arg_107_1:GetWordFromCfg(416071026)
				local var_110_27 = arg_107_1:FormatText(var_110_26.content)

				arg_107_1.text_.text = var_110_27

				LuaForUtil.ClearLinePrefixSymbol(arg_107_1.text_)

				local var_110_28 = 19
				local var_110_29 = utf8.len(var_110_27)
				local var_110_30 = var_110_28 <= 0 and var_110_24 or var_110_24 * (var_110_29 / var_110_28)

				if var_110_30 > 0 and var_110_24 < var_110_30 then
					arg_107_1.talkMaxDuration = var_110_30

					if var_110_30 + var_110_23 > arg_107_1.duration_ then
						arg_107_1.duration_ = var_110_30 + var_110_23
					end
				end

				arg_107_1.text_.text = var_110_27
				arg_107_1.typewritter.percent = 0

				arg_107_1.typewritter:SetDirty()
				arg_107_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_416071", "416071026", "story_v_out_416071.awb") ~= 0 then
					local var_110_31 = manager.audio:GetVoiceLength("story_v_out_416071", "416071026", "story_v_out_416071.awb") / 1000

					if var_110_31 + var_110_23 > arg_107_1.duration_ then
						arg_107_1.duration_ = var_110_31 + var_110_23
					end

					if var_110_26.prefab_name ~= "" and arg_107_1.actors_[var_110_26.prefab_name] ~= nil then
						local var_110_32 = LuaForUtil.PlayVoiceWithCriLipsync(arg_107_1.actors_[var_110_26.prefab_name].transform, "story_v_out_416071", "416071026", "story_v_out_416071.awb")

						arg_107_1:RecordAudio("416071026", var_110_32)
						arg_107_1:RecordAudio("416071026", var_110_32)
					else
						arg_107_1:AudioAction("play", "voice", "story_v_out_416071", "416071026", "story_v_out_416071.awb")
					end

					arg_107_1:RecordHistoryTalkVoice("story_v_out_416071", "416071026", "story_v_out_416071.awb")
				end

				arg_107_1:RecordContent(arg_107_1.text_.text)
			end

			local var_110_33 = math.max(var_110_24, arg_107_1.talkMaxDuration)

			if var_110_23 <= arg_107_1.time_ and arg_107_1.time_ < var_110_23 + var_110_33 then
				arg_107_1.typewritter.percent = (arg_107_1.time_ - var_110_23) / var_110_33

				arg_107_1.typewritter:SetDirty()
			end

			if arg_107_1.time_ >= var_110_23 + var_110_33 and arg_107_1.time_ < var_110_23 + var_110_33 + arg_110_0 then
				arg_107_1.typewritter.percent = 1

				arg_107_1.typewritter:SetDirty()
				arg_107_1:ShowNextGo(true)
			end
		end

		arg_107_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1148",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_107_1:InitPlayNodeList()
	end,
	Play416071027 = function(arg_111_0, arg_111_1)
		arg_111_1.time_ = 0
		arg_111_1.frameCnt_ = 0
		arg_111_1.state_ = "playing"
		arg_111_1.curTalkId_ = 416071027
		arg_111_1.duration_ = 5

		SetActive(arg_111_1.tipsGo_, false)

		function arg_111_1.onSingleLineFinish_()
			arg_111_1.onSingleLineUpdate_ = nil
			arg_111_1.onSingleLineFinish_ = nil
			arg_111_1.state_ = "waiting"
		end

		function arg_111_1.playNext_(arg_113_0)
			if arg_113_0 == 1 then
				arg_111_0:Play416071028(arg_111_1)
			end
		end

		function arg_111_1.onSingleLineUpdate_(arg_114_0)
			local var_114_0 = arg_111_1.actors_["10108"]
			local var_114_1 = 0

			if var_114_1 < arg_111_1.time_ and arg_111_1.time_ <= var_114_1 + arg_114_0 and not isNil(var_114_0) and arg_111_1.var_.actorSpriteComps10108 == nil then
				arg_111_1.var_.actorSpriteComps10108 = var_114_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_114_2 = 0.125

			if var_114_1 <= arg_111_1.time_ and arg_111_1.time_ < var_114_1 + var_114_2 and not isNil(var_114_0) then
				local var_114_3 = (arg_111_1.time_ - var_114_1) / var_114_2

				if arg_111_1.var_.actorSpriteComps10108 then
					for iter_114_0, iter_114_1 in pairs(arg_111_1.var_.actorSpriteComps10108:ToTable()) do
						if iter_114_1 then
							if arg_111_1.isInRecall_ then
								local var_114_4 = Mathf.Lerp(iter_114_1.color.r, arg_111_1.hightColor2.r, var_114_3)
								local var_114_5 = Mathf.Lerp(iter_114_1.color.g, arg_111_1.hightColor2.g, var_114_3)
								local var_114_6 = Mathf.Lerp(iter_114_1.color.b, arg_111_1.hightColor2.b, var_114_3)

								iter_114_1.color = Color.New(var_114_4, var_114_5, var_114_6)
							else
								local var_114_7 = Mathf.Lerp(iter_114_1.color.r, 0.5, var_114_3)

								iter_114_1.color = Color.New(var_114_7, var_114_7, var_114_7)
							end
						end
					end
				end
			end

			if arg_111_1.time_ >= var_114_1 + var_114_2 and arg_111_1.time_ < var_114_1 + var_114_2 + arg_114_0 and not isNil(var_114_0) and arg_111_1.var_.actorSpriteComps10108 then
				for iter_114_2, iter_114_3 in pairs(arg_111_1.var_.actorSpriteComps10108:ToTable()) do
					if iter_114_3 then
						if arg_111_1.isInRecall_ then
							iter_114_3.color = arg_111_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_114_3.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_111_1.var_.actorSpriteComps10108 = nil
			end

			local var_114_8 = arg_111_1.actors_["1148"]
			local var_114_9 = 0

			if var_114_9 < arg_111_1.time_ and arg_111_1.time_ <= var_114_9 + arg_114_0 and not isNil(var_114_8) and arg_111_1.var_.actorSpriteComps1148 == nil then
				arg_111_1.var_.actorSpriteComps1148 = var_114_8:GetComponentsInChildren(typeof(Image), true)
			end

			local var_114_10 = 0.125

			if var_114_9 <= arg_111_1.time_ and arg_111_1.time_ < var_114_9 + var_114_10 and not isNil(var_114_8) then
				local var_114_11 = (arg_111_1.time_ - var_114_9) / var_114_10

				if arg_111_1.var_.actorSpriteComps1148 then
					for iter_114_4, iter_114_5 in pairs(arg_111_1.var_.actorSpriteComps1148:ToTable()) do
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

			if arg_111_1.time_ >= var_114_9 + var_114_10 and arg_111_1.time_ < var_114_9 + var_114_10 + arg_114_0 and not isNil(var_114_8) and arg_111_1.var_.actorSpriteComps1148 then
				for iter_114_6, iter_114_7 in pairs(arg_111_1.var_.actorSpriteComps1148:ToTable()) do
					if iter_114_7 then
						if arg_111_1.isInRecall_ then
							iter_114_7.color = arg_111_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_114_7.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_111_1.var_.actorSpriteComps1148 = nil
			end

			local var_114_16 = 0
			local var_114_17 = 1.375

			if var_114_16 < arg_111_1.time_ and arg_111_1.time_ <= var_114_16 + arg_114_0 then
				arg_111_1.talkMaxDuration = 0
				arg_111_1.dialogCg_.alpha = 1

				arg_111_1.dialog_:SetActive(true)
				SetActive(arg_111_1.leftNameGo_, false)

				arg_111_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_111_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_111_1:RecordName(arg_111_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_111_1.iconTrs_.gameObject, false)
				arg_111_1.callingController_:SetSelectedState("normal")

				local var_114_18 = arg_111_1:GetWordFromCfg(416071027)
				local var_114_19 = arg_111_1:FormatText(var_114_18.content)

				arg_111_1.text_.text = var_114_19

				LuaForUtil.ClearLinePrefixSymbol(arg_111_1.text_)

				local var_114_20 = 55
				local var_114_21 = utf8.len(var_114_19)
				local var_114_22 = var_114_20 <= 0 and var_114_17 or var_114_17 * (var_114_21 / var_114_20)

				if var_114_22 > 0 and var_114_17 < var_114_22 then
					arg_111_1.talkMaxDuration = var_114_22

					if var_114_22 + var_114_16 > arg_111_1.duration_ then
						arg_111_1.duration_ = var_114_22 + var_114_16
					end
				end

				arg_111_1.text_.text = var_114_19
				arg_111_1.typewritter.percent = 0

				arg_111_1.typewritter:SetDirty()
				arg_111_1:ShowNextGo(false)
				arg_111_1:RecordContent(arg_111_1.text_.text)
			end

			local var_114_23 = math.max(var_114_17, arg_111_1.talkMaxDuration)

			if var_114_16 <= arg_111_1.time_ and arg_111_1.time_ < var_114_16 + var_114_23 then
				arg_111_1.typewritter.percent = (arg_111_1.time_ - var_114_16) / var_114_23

				arg_111_1.typewritter:SetDirty()
			end

			if arg_111_1.time_ >= var_114_16 + var_114_23 and arg_111_1.time_ < var_114_16 + var_114_23 + arg_114_0 then
				arg_111_1.typewritter.percent = 1

				arg_111_1.typewritter:SetDirty()
				arg_111_1:ShowNextGo(true)
			end
		end

		arg_111_1.nodeConfigList_ = {}

		arg_111_1:InitPlayNodeList()
	end,
	Play416071028 = function(arg_115_0, arg_115_1)
		arg_115_1.time_ = 0
		arg_115_1.frameCnt_ = 0
		arg_115_1.state_ = "playing"
		arg_115_1.curTalkId_ = 416071028
		arg_115_1.duration_ = 13.87

		local var_115_0 = {
			zh = 11.333,
			ja = 13.866
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
				arg_115_0:Play416071029(arg_115_1)
			end
		end

		function arg_115_1.onSingleLineUpdate_(arg_118_0)
			local var_118_0 = arg_115_1.actors_["10108"]
			local var_118_1 = 0

			if var_118_1 < arg_115_1.time_ and arg_115_1.time_ <= var_118_1 + arg_118_0 and not isNil(var_118_0) and arg_115_1.var_.actorSpriteComps10108 == nil then
				arg_115_1.var_.actorSpriteComps10108 = var_118_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_118_2 = 0.125

			if var_118_1 <= arg_115_1.time_ and arg_115_1.time_ < var_118_1 + var_118_2 and not isNil(var_118_0) then
				local var_118_3 = (arg_115_1.time_ - var_118_1) / var_118_2

				if arg_115_1.var_.actorSpriteComps10108 then
					for iter_118_0, iter_118_1 in pairs(arg_115_1.var_.actorSpriteComps10108:ToTable()) do
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

			if arg_115_1.time_ >= var_118_1 + var_118_2 and arg_115_1.time_ < var_118_1 + var_118_2 + arg_118_0 and not isNil(var_118_0) and arg_115_1.var_.actorSpriteComps10108 then
				for iter_118_2, iter_118_3 in pairs(arg_115_1.var_.actorSpriteComps10108:ToTable()) do
					if iter_118_3 then
						if arg_115_1.isInRecall_ then
							iter_118_3.color = arg_115_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_118_3.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_115_1.var_.actorSpriteComps10108 = nil
			end

			local var_118_8 = arg_115_1.actors_["1148"]
			local var_118_9 = 0

			if var_118_9 < arg_115_1.time_ and arg_115_1.time_ <= var_118_9 + arg_118_0 and not isNil(var_118_8) and arg_115_1.var_.actorSpriteComps1148 == nil then
				arg_115_1.var_.actorSpriteComps1148 = var_118_8:GetComponentsInChildren(typeof(Image), true)
			end

			local var_118_10 = 0.125

			if var_118_9 <= arg_115_1.time_ and arg_115_1.time_ < var_118_9 + var_118_10 and not isNil(var_118_8) then
				local var_118_11 = (arg_115_1.time_ - var_118_9) / var_118_10

				if arg_115_1.var_.actorSpriteComps1148 then
					for iter_118_4, iter_118_5 in pairs(arg_115_1.var_.actorSpriteComps1148:ToTable()) do
						if iter_118_5 then
							if arg_115_1.isInRecall_ then
								local var_118_12 = Mathf.Lerp(iter_118_5.color.r, arg_115_1.hightColor1.r, var_118_11)
								local var_118_13 = Mathf.Lerp(iter_118_5.color.g, arg_115_1.hightColor1.g, var_118_11)
								local var_118_14 = Mathf.Lerp(iter_118_5.color.b, arg_115_1.hightColor1.b, var_118_11)

								iter_118_5.color = Color.New(var_118_12, var_118_13, var_118_14)
							else
								local var_118_15 = Mathf.Lerp(iter_118_5.color.r, 1, var_118_11)

								iter_118_5.color = Color.New(var_118_15, var_118_15, var_118_15)
							end
						end
					end
				end
			end

			if arg_115_1.time_ >= var_118_9 + var_118_10 and arg_115_1.time_ < var_118_9 + var_118_10 + arg_118_0 and not isNil(var_118_8) and arg_115_1.var_.actorSpriteComps1148 then
				for iter_118_6, iter_118_7 in pairs(arg_115_1.var_.actorSpriteComps1148:ToTable()) do
					if iter_118_7 then
						if arg_115_1.isInRecall_ then
							iter_118_7.color = arg_115_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_118_7.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_115_1.var_.actorSpriteComps1148 = nil
			end

			local var_118_16 = 0
			local var_118_17 = 1.1

			if var_118_16 < arg_115_1.time_ and arg_115_1.time_ <= var_118_16 + arg_118_0 then
				arg_115_1.talkMaxDuration = 0
				arg_115_1.dialogCg_.alpha = 1

				arg_115_1.dialog_:SetActive(true)
				SetActive(arg_115_1.leftNameGo_, true)

				local var_118_18 = arg_115_1:FormatText(StoryNameCfg[8].name)

				arg_115_1.leftNameTxt_.text = var_118_18

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_115_1.leftNameTxt_.transform)

				arg_115_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_115_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_115_1:RecordName(arg_115_1.leftNameTxt_.text)
				SetActive(arg_115_1.iconTrs_.gameObject, false)
				arg_115_1.callingController_:SetSelectedState("normal")

				local var_118_19 = arg_115_1:GetWordFromCfg(416071028)
				local var_118_20 = arg_115_1:FormatText(var_118_19.content)

				arg_115_1.text_.text = var_118_20

				LuaForUtil.ClearLinePrefixSymbol(arg_115_1.text_)

				local var_118_21 = 44
				local var_118_22 = utf8.len(var_118_20)
				local var_118_23 = var_118_21 <= 0 and var_118_17 or var_118_17 * (var_118_22 / var_118_21)

				if var_118_23 > 0 and var_118_17 < var_118_23 then
					arg_115_1.talkMaxDuration = var_118_23

					if var_118_23 + var_118_16 > arg_115_1.duration_ then
						arg_115_1.duration_ = var_118_23 + var_118_16
					end
				end

				arg_115_1.text_.text = var_118_20
				arg_115_1.typewritter.percent = 0

				arg_115_1.typewritter:SetDirty()
				arg_115_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_416071", "416071028", "story_v_out_416071.awb") ~= 0 then
					local var_118_24 = manager.audio:GetVoiceLength("story_v_out_416071", "416071028", "story_v_out_416071.awb") / 1000

					if var_118_24 + var_118_16 > arg_115_1.duration_ then
						arg_115_1.duration_ = var_118_24 + var_118_16
					end

					if var_118_19.prefab_name ~= "" and arg_115_1.actors_[var_118_19.prefab_name] ~= nil then
						local var_118_25 = LuaForUtil.PlayVoiceWithCriLipsync(arg_115_1.actors_[var_118_19.prefab_name].transform, "story_v_out_416071", "416071028", "story_v_out_416071.awb")

						arg_115_1:RecordAudio("416071028", var_118_25)
						arg_115_1:RecordAudio("416071028", var_118_25)
					else
						arg_115_1:AudioAction("play", "voice", "story_v_out_416071", "416071028", "story_v_out_416071.awb")
					end

					arg_115_1:RecordHistoryTalkVoice("story_v_out_416071", "416071028", "story_v_out_416071.awb")
				end

				arg_115_1:RecordContent(arg_115_1.text_.text)
			end

			local var_118_26 = math.max(var_118_17, arg_115_1.talkMaxDuration)

			if var_118_16 <= arg_115_1.time_ and arg_115_1.time_ < var_118_16 + var_118_26 then
				arg_115_1.typewritter.percent = (arg_115_1.time_ - var_118_16) / var_118_26

				arg_115_1.typewritter:SetDirty()
			end

			if arg_115_1.time_ >= var_118_16 + var_118_26 and arg_115_1.time_ < var_118_16 + var_118_26 + arg_118_0 then
				arg_115_1.typewritter.percent = 1

				arg_115_1.typewritter:SetDirty()
				arg_115_1:ShowNextGo(true)
			end
		end

		arg_115_1.nodeConfigList_ = {}

		arg_115_1:InitPlayNodeList()
	end,
	Play416071029 = function(arg_119_0, arg_119_1)
		arg_119_1.time_ = 0
		arg_119_1.frameCnt_ = 0
		arg_119_1.state_ = "playing"
		arg_119_1.curTalkId_ = 416071029
		arg_119_1.duration_ = 6.37

		local var_119_0 = {
			zh = 6.266,
			ja = 6.366
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
				arg_119_0:Play416071030(arg_119_1)
			end
		end

		function arg_119_1.onSingleLineUpdate_(arg_122_0)
			local var_122_0 = 0
			local var_122_1 = 0.725

			if var_122_0 < arg_119_1.time_ and arg_119_1.time_ <= var_122_0 + arg_122_0 then
				arg_119_1.talkMaxDuration = 0
				arg_119_1.dialogCg_.alpha = 1

				arg_119_1.dialog_:SetActive(true)
				SetActive(arg_119_1.leftNameGo_, true)

				local var_122_2 = arg_119_1:FormatText(StoryNameCfg[8].name)

				arg_119_1.leftNameTxt_.text = var_122_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_119_1.leftNameTxt_.transform)

				arg_119_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_119_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_119_1:RecordName(arg_119_1.leftNameTxt_.text)
				SetActive(arg_119_1.iconTrs_.gameObject, false)
				arg_119_1.callingController_:SetSelectedState("normal")

				local var_122_3 = arg_119_1:GetWordFromCfg(416071029)
				local var_122_4 = arg_119_1:FormatText(var_122_3.content)

				arg_119_1.text_.text = var_122_4

				LuaForUtil.ClearLinePrefixSymbol(arg_119_1.text_)

				local var_122_5 = 29
				local var_122_6 = utf8.len(var_122_4)
				local var_122_7 = var_122_5 <= 0 and var_122_1 or var_122_1 * (var_122_6 / var_122_5)

				if var_122_7 > 0 and var_122_1 < var_122_7 then
					arg_119_1.talkMaxDuration = var_122_7

					if var_122_7 + var_122_0 > arg_119_1.duration_ then
						arg_119_1.duration_ = var_122_7 + var_122_0
					end
				end

				arg_119_1.text_.text = var_122_4
				arg_119_1.typewritter.percent = 0

				arg_119_1.typewritter:SetDirty()
				arg_119_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_416071", "416071029", "story_v_out_416071.awb") ~= 0 then
					local var_122_8 = manager.audio:GetVoiceLength("story_v_out_416071", "416071029", "story_v_out_416071.awb") / 1000

					if var_122_8 + var_122_0 > arg_119_1.duration_ then
						arg_119_1.duration_ = var_122_8 + var_122_0
					end

					if var_122_3.prefab_name ~= "" and arg_119_1.actors_[var_122_3.prefab_name] ~= nil then
						local var_122_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_119_1.actors_[var_122_3.prefab_name].transform, "story_v_out_416071", "416071029", "story_v_out_416071.awb")

						arg_119_1:RecordAudio("416071029", var_122_9)
						arg_119_1:RecordAudio("416071029", var_122_9)
					else
						arg_119_1:AudioAction("play", "voice", "story_v_out_416071", "416071029", "story_v_out_416071.awb")
					end

					arg_119_1:RecordHistoryTalkVoice("story_v_out_416071", "416071029", "story_v_out_416071.awb")
				end

				arg_119_1:RecordContent(arg_119_1.text_.text)
			end

			local var_122_10 = math.max(var_122_1, arg_119_1.talkMaxDuration)

			if var_122_0 <= arg_119_1.time_ and arg_119_1.time_ < var_122_0 + var_122_10 then
				arg_119_1.typewritter.percent = (arg_119_1.time_ - var_122_0) / var_122_10

				arg_119_1.typewritter:SetDirty()
			end

			if arg_119_1.time_ >= var_122_0 + var_122_10 and arg_119_1.time_ < var_122_0 + var_122_10 + arg_122_0 then
				arg_119_1.typewritter.percent = 1

				arg_119_1.typewritter:SetDirty()
				arg_119_1:ShowNextGo(true)
			end
		end

		arg_119_1.nodeConfigList_ = {}

		arg_119_1:InitPlayNodeList()
	end,
	Play416071030 = function(arg_123_0, arg_123_1)
		arg_123_1.time_ = 0
		arg_123_1.frameCnt_ = 0
		arg_123_1.state_ = "playing"
		arg_123_1.curTalkId_ = 416071030
		arg_123_1.duration_ = 17.87

		local var_123_0 = {
			zh = 8.5,
			ja = 17.866
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
				arg_123_0:Play416071031(arg_123_1)
			end
		end

		function arg_123_1.onSingleLineUpdate_(arg_126_0)
			local var_126_0 = arg_123_1.actors_["10108"]
			local var_126_1 = 0

			if var_126_1 < arg_123_1.time_ and arg_123_1.time_ <= var_126_1 + arg_126_0 and not isNil(var_126_0) and arg_123_1.var_.actorSpriteComps10108 == nil then
				arg_123_1.var_.actorSpriteComps10108 = var_126_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_126_2 = 0.125

			if var_126_1 <= arg_123_1.time_ and arg_123_1.time_ < var_126_1 + var_126_2 and not isNil(var_126_0) then
				local var_126_3 = (arg_123_1.time_ - var_126_1) / var_126_2

				if arg_123_1.var_.actorSpriteComps10108 then
					for iter_126_0, iter_126_1 in pairs(arg_123_1.var_.actorSpriteComps10108:ToTable()) do
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

			if arg_123_1.time_ >= var_126_1 + var_126_2 and arg_123_1.time_ < var_126_1 + var_126_2 + arg_126_0 and not isNil(var_126_0) and arg_123_1.var_.actorSpriteComps10108 then
				for iter_126_2, iter_126_3 in pairs(arg_123_1.var_.actorSpriteComps10108:ToTable()) do
					if iter_126_3 then
						if arg_123_1.isInRecall_ then
							iter_126_3.color = arg_123_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_126_3.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_123_1.var_.actorSpriteComps10108 = nil
			end

			local var_126_8 = arg_123_1.actors_["1148"]
			local var_126_9 = 0

			if var_126_9 < arg_123_1.time_ and arg_123_1.time_ <= var_126_9 + arg_126_0 and not isNil(var_126_8) and arg_123_1.var_.actorSpriteComps1148 == nil then
				arg_123_1.var_.actorSpriteComps1148 = var_126_8:GetComponentsInChildren(typeof(Image), true)
			end

			local var_126_10 = 0.125

			if var_126_9 <= arg_123_1.time_ and arg_123_1.time_ < var_126_9 + var_126_10 and not isNil(var_126_8) then
				local var_126_11 = (arg_123_1.time_ - var_126_9) / var_126_10

				if arg_123_1.var_.actorSpriteComps1148 then
					for iter_126_4, iter_126_5 in pairs(arg_123_1.var_.actorSpriteComps1148:ToTable()) do
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

			if arg_123_1.time_ >= var_126_9 + var_126_10 and arg_123_1.time_ < var_126_9 + var_126_10 + arg_126_0 and not isNil(var_126_8) and arg_123_1.var_.actorSpriteComps1148 then
				for iter_126_6, iter_126_7 in pairs(arg_123_1.var_.actorSpriteComps1148:ToTable()) do
					if iter_126_7 then
						if arg_123_1.isInRecall_ then
							iter_126_7.color = arg_123_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_126_7.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_123_1.var_.actorSpriteComps1148 = nil
			end

			local var_126_16 = 0
			local var_126_17 = 0.65

			if var_126_16 < arg_123_1.time_ and arg_123_1.time_ <= var_126_16 + arg_126_0 then
				arg_123_1.talkMaxDuration = 0
				arg_123_1.dialogCg_.alpha = 1

				arg_123_1.dialog_:SetActive(true)
				SetActive(arg_123_1.leftNameGo_, true)

				local var_126_18 = arg_123_1:FormatText(StoryNameCfg[1083].name)

				arg_123_1.leftNameTxt_.text = var_126_18

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_123_1.leftNameTxt_.transform)

				arg_123_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_123_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_123_1:RecordName(arg_123_1.leftNameTxt_.text)
				SetActive(arg_123_1.iconTrs_.gameObject, false)
				arg_123_1.callingController_:SetSelectedState("normal")

				local var_126_19 = arg_123_1:GetWordFromCfg(416071030)
				local var_126_20 = arg_123_1:FormatText(var_126_19.content)

				arg_123_1.text_.text = var_126_20

				LuaForUtil.ClearLinePrefixSymbol(arg_123_1.text_)

				local var_126_21 = 26
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

				if manager.audio:GetVoiceLength("story_v_out_416071", "416071030", "story_v_out_416071.awb") ~= 0 then
					local var_126_24 = manager.audio:GetVoiceLength("story_v_out_416071", "416071030", "story_v_out_416071.awb") / 1000

					if var_126_24 + var_126_16 > arg_123_1.duration_ then
						arg_123_1.duration_ = var_126_24 + var_126_16
					end

					if var_126_19.prefab_name ~= "" and arg_123_1.actors_[var_126_19.prefab_name] ~= nil then
						local var_126_25 = LuaForUtil.PlayVoiceWithCriLipsync(arg_123_1.actors_[var_126_19.prefab_name].transform, "story_v_out_416071", "416071030", "story_v_out_416071.awb")

						arg_123_1:RecordAudio("416071030", var_126_25)
						arg_123_1:RecordAudio("416071030", var_126_25)
					else
						arg_123_1:AudioAction("play", "voice", "story_v_out_416071", "416071030", "story_v_out_416071.awb")
					end

					arg_123_1:RecordHistoryTalkVoice("story_v_out_416071", "416071030", "story_v_out_416071.awb")
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
	Play416071031 = function(arg_127_0, arg_127_1)
		arg_127_1.time_ = 0
		arg_127_1.frameCnt_ = 0
		arg_127_1.state_ = "playing"
		arg_127_1.curTalkId_ = 416071031
		arg_127_1.duration_ = 7.63

		local var_127_0 = {
			zh = 4.233,
			ja = 7.633
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
				arg_127_0:Play416071032(arg_127_1)
			end
		end

		function arg_127_1.onSingleLineUpdate_(arg_130_0)
			local var_130_0 = arg_127_1.actors_["10108"]
			local var_130_1 = 0

			if var_130_1 < arg_127_1.time_ and arg_127_1.time_ <= var_130_1 + arg_130_0 and not isNil(var_130_0) and arg_127_1.var_.actorSpriteComps10108 == nil then
				arg_127_1.var_.actorSpriteComps10108 = var_130_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_130_2 = 0.125

			if var_130_1 <= arg_127_1.time_ and arg_127_1.time_ < var_130_1 + var_130_2 and not isNil(var_130_0) then
				local var_130_3 = (arg_127_1.time_ - var_130_1) / var_130_2

				if arg_127_1.var_.actorSpriteComps10108 then
					for iter_130_0, iter_130_1 in pairs(arg_127_1.var_.actorSpriteComps10108:ToTable()) do
						if iter_130_1 then
							if arg_127_1.isInRecall_ then
								local var_130_4 = Mathf.Lerp(iter_130_1.color.r, arg_127_1.hightColor2.r, var_130_3)
								local var_130_5 = Mathf.Lerp(iter_130_1.color.g, arg_127_1.hightColor2.g, var_130_3)
								local var_130_6 = Mathf.Lerp(iter_130_1.color.b, arg_127_1.hightColor2.b, var_130_3)

								iter_130_1.color = Color.New(var_130_4, var_130_5, var_130_6)
							else
								local var_130_7 = Mathf.Lerp(iter_130_1.color.r, 0.5, var_130_3)

								iter_130_1.color = Color.New(var_130_7, var_130_7, var_130_7)
							end
						end
					end
				end
			end

			if arg_127_1.time_ >= var_130_1 + var_130_2 and arg_127_1.time_ < var_130_1 + var_130_2 + arg_130_0 and not isNil(var_130_0) and arg_127_1.var_.actorSpriteComps10108 then
				for iter_130_2, iter_130_3 in pairs(arg_127_1.var_.actorSpriteComps10108:ToTable()) do
					if iter_130_3 then
						if arg_127_1.isInRecall_ then
							iter_130_3.color = arg_127_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_130_3.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_127_1.var_.actorSpriteComps10108 = nil
			end

			local var_130_8 = arg_127_1.actors_["1148"]
			local var_130_9 = 0

			if var_130_9 < arg_127_1.time_ and arg_127_1.time_ <= var_130_9 + arg_130_0 and not isNil(var_130_8) and arg_127_1.var_.actorSpriteComps1148 == nil then
				arg_127_1.var_.actorSpriteComps1148 = var_130_8:GetComponentsInChildren(typeof(Image), true)
			end

			local var_130_10 = 0.125

			if var_130_9 <= arg_127_1.time_ and arg_127_1.time_ < var_130_9 + var_130_10 and not isNil(var_130_8) then
				local var_130_11 = (arg_127_1.time_ - var_130_9) / var_130_10

				if arg_127_1.var_.actorSpriteComps1148 then
					for iter_130_4, iter_130_5 in pairs(arg_127_1.var_.actorSpriteComps1148:ToTable()) do
						if iter_130_5 then
							if arg_127_1.isInRecall_ then
								local var_130_12 = Mathf.Lerp(iter_130_5.color.r, arg_127_1.hightColor1.r, var_130_11)
								local var_130_13 = Mathf.Lerp(iter_130_5.color.g, arg_127_1.hightColor1.g, var_130_11)
								local var_130_14 = Mathf.Lerp(iter_130_5.color.b, arg_127_1.hightColor1.b, var_130_11)

								iter_130_5.color = Color.New(var_130_12, var_130_13, var_130_14)
							else
								local var_130_15 = Mathf.Lerp(iter_130_5.color.r, 1, var_130_11)

								iter_130_5.color = Color.New(var_130_15, var_130_15, var_130_15)
							end
						end
					end
				end
			end

			if arg_127_1.time_ >= var_130_9 + var_130_10 and arg_127_1.time_ < var_130_9 + var_130_10 + arg_130_0 and not isNil(var_130_8) and arg_127_1.var_.actorSpriteComps1148 then
				for iter_130_6, iter_130_7 in pairs(arg_127_1.var_.actorSpriteComps1148:ToTable()) do
					if iter_130_7 then
						if arg_127_1.isInRecall_ then
							iter_130_7.color = arg_127_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_130_7.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_127_1.var_.actorSpriteComps1148 = nil
			end

			local var_130_16 = 0
			local var_130_17 = 0.5

			if var_130_16 < arg_127_1.time_ and arg_127_1.time_ <= var_130_16 + arg_130_0 then
				arg_127_1.talkMaxDuration = 0
				arg_127_1.dialogCg_.alpha = 1

				arg_127_1.dialog_:SetActive(true)
				SetActive(arg_127_1.leftNameGo_, true)

				local var_130_18 = arg_127_1:FormatText(StoryNameCfg[8].name)

				arg_127_1.leftNameTxt_.text = var_130_18

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_127_1.leftNameTxt_.transform)

				arg_127_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_127_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_127_1:RecordName(arg_127_1.leftNameTxt_.text)
				SetActive(arg_127_1.iconTrs_.gameObject, false)
				arg_127_1.callingController_:SetSelectedState("normal")

				local var_130_19 = arg_127_1:GetWordFromCfg(416071031)
				local var_130_20 = arg_127_1:FormatText(var_130_19.content)

				arg_127_1.text_.text = var_130_20

				LuaForUtil.ClearLinePrefixSymbol(arg_127_1.text_)

				local var_130_21 = 20
				local var_130_22 = utf8.len(var_130_20)
				local var_130_23 = var_130_21 <= 0 and var_130_17 or var_130_17 * (var_130_22 / var_130_21)

				if var_130_23 > 0 and var_130_17 < var_130_23 then
					arg_127_1.talkMaxDuration = var_130_23

					if var_130_23 + var_130_16 > arg_127_1.duration_ then
						arg_127_1.duration_ = var_130_23 + var_130_16
					end
				end

				arg_127_1.text_.text = var_130_20
				arg_127_1.typewritter.percent = 0

				arg_127_1.typewritter:SetDirty()
				arg_127_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_416071", "416071031", "story_v_out_416071.awb") ~= 0 then
					local var_130_24 = manager.audio:GetVoiceLength("story_v_out_416071", "416071031", "story_v_out_416071.awb") / 1000

					if var_130_24 + var_130_16 > arg_127_1.duration_ then
						arg_127_1.duration_ = var_130_24 + var_130_16
					end

					if var_130_19.prefab_name ~= "" and arg_127_1.actors_[var_130_19.prefab_name] ~= nil then
						local var_130_25 = LuaForUtil.PlayVoiceWithCriLipsync(arg_127_1.actors_[var_130_19.prefab_name].transform, "story_v_out_416071", "416071031", "story_v_out_416071.awb")

						arg_127_1:RecordAudio("416071031", var_130_25)
						arg_127_1:RecordAudio("416071031", var_130_25)
					else
						arg_127_1:AudioAction("play", "voice", "story_v_out_416071", "416071031", "story_v_out_416071.awb")
					end

					arg_127_1:RecordHistoryTalkVoice("story_v_out_416071", "416071031", "story_v_out_416071.awb")
				end

				arg_127_1:RecordContent(arg_127_1.text_.text)
			end

			local var_130_26 = math.max(var_130_17, arg_127_1.talkMaxDuration)

			if var_130_16 <= arg_127_1.time_ and arg_127_1.time_ < var_130_16 + var_130_26 then
				arg_127_1.typewritter.percent = (arg_127_1.time_ - var_130_16) / var_130_26

				arg_127_1.typewritter:SetDirty()
			end

			if arg_127_1.time_ >= var_130_16 + var_130_26 and arg_127_1.time_ < var_130_16 + var_130_26 + arg_130_0 then
				arg_127_1.typewritter.percent = 1

				arg_127_1.typewritter:SetDirty()
				arg_127_1:ShowNextGo(true)
			end
		end

		arg_127_1.nodeConfigList_ = {}

		arg_127_1:InitPlayNodeList()
	end,
	Play416071032 = function(arg_131_0, arg_131_1)
		arg_131_1.time_ = 0
		arg_131_1.frameCnt_ = 0
		arg_131_1.state_ = "playing"
		arg_131_1.curTalkId_ = 416071032
		arg_131_1.duration_ = 13.83

		local var_131_0 = {
			zh = 7.266,
			ja = 13.833
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
				arg_131_0:Play416071033(arg_131_1)
			end
		end

		function arg_131_1.onSingleLineUpdate_(arg_134_0)
			local var_134_0 = arg_131_1.actors_["10108"]
			local var_134_1 = 0

			if var_134_1 < arg_131_1.time_ and arg_131_1.time_ <= var_134_1 + arg_134_0 and not isNil(var_134_0) and arg_131_1.var_.actorSpriteComps10108 == nil then
				arg_131_1.var_.actorSpriteComps10108 = var_134_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_134_2 = 0.125

			if var_134_1 <= arg_131_1.time_ and arg_131_1.time_ < var_134_1 + var_134_2 and not isNil(var_134_0) then
				local var_134_3 = (arg_131_1.time_ - var_134_1) / var_134_2

				if arg_131_1.var_.actorSpriteComps10108 then
					for iter_134_0, iter_134_1 in pairs(arg_131_1.var_.actorSpriteComps10108:ToTable()) do
						if iter_134_1 then
							if arg_131_1.isInRecall_ then
								local var_134_4 = Mathf.Lerp(iter_134_1.color.r, arg_131_1.hightColor1.r, var_134_3)
								local var_134_5 = Mathf.Lerp(iter_134_1.color.g, arg_131_1.hightColor1.g, var_134_3)
								local var_134_6 = Mathf.Lerp(iter_134_1.color.b, arg_131_1.hightColor1.b, var_134_3)

								iter_134_1.color = Color.New(var_134_4, var_134_5, var_134_6)
							else
								local var_134_7 = Mathf.Lerp(iter_134_1.color.r, 1, var_134_3)

								iter_134_1.color = Color.New(var_134_7, var_134_7, var_134_7)
							end
						end
					end
				end
			end

			if arg_131_1.time_ >= var_134_1 + var_134_2 and arg_131_1.time_ < var_134_1 + var_134_2 + arg_134_0 and not isNil(var_134_0) and arg_131_1.var_.actorSpriteComps10108 then
				for iter_134_2, iter_134_3 in pairs(arg_131_1.var_.actorSpriteComps10108:ToTable()) do
					if iter_134_3 then
						if arg_131_1.isInRecall_ then
							iter_134_3.color = arg_131_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_134_3.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_131_1.var_.actorSpriteComps10108 = nil
			end

			local var_134_8 = arg_131_1.actors_["1148"]
			local var_134_9 = 0

			if var_134_9 < arg_131_1.time_ and arg_131_1.time_ <= var_134_9 + arg_134_0 and not isNil(var_134_8) and arg_131_1.var_.actorSpriteComps1148 == nil then
				arg_131_1.var_.actorSpriteComps1148 = var_134_8:GetComponentsInChildren(typeof(Image), true)
			end

			local var_134_10 = 0.125

			if var_134_9 <= arg_131_1.time_ and arg_131_1.time_ < var_134_9 + var_134_10 and not isNil(var_134_8) then
				local var_134_11 = (arg_131_1.time_ - var_134_9) / var_134_10

				if arg_131_1.var_.actorSpriteComps1148 then
					for iter_134_4, iter_134_5 in pairs(arg_131_1.var_.actorSpriteComps1148:ToTable()) do
						if iter_134_5 then
							if arg_131_1.isInRecall_ then
								local var_134_12 = Mathf.Lerp(iter_134_5.color.r, arg_131_1.hightColor2.r, var_134_11)
								local var_134_13 = Mathf.Lerp(iter_134_5.color.g, arg_131_1.hightColor2.g, var_134_11)
								local var_134_14 = Mathf.Lerp(iter_134_5.color.b, arg_131_1.hightColor2.b, var_134_11)

								iter_134_5.color = Color.New(var_134_12, var_134_13, var_134_14)
							else
								local var_134_15 = Mathf.Lerp(iter_134_5.color.r, 0.5, var_134_11)

								iter_134_5.color = Color.New(var_134_15, var_134_15, var_134_15)
							end
						end
					end
				end
			end

			if arg_131_1.time_ >= var_134_9 + var_134_10 and arg_131_1.time_ < var_134_9 + var_134_10 + arg_134_0 and not isNil(var_134_8) and arg_131_1.var_.actorSpriteComps1148 then
				for iter_134_6, iter_134_7 in pairs(arg_131_1.var_.actorSpriteComps1148:ToTable()) do
					if iter_134_7 then
						if arg_131_1.isInRecall_ then
							iter_134_7.color = arg_131_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_134_7.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_131_1.var_.actorSpriteComps1148 = nil
			end

			local var_134_16 = 0
			local var_134_17 = 0.725

			if var_134_16 < arg_131_1.time_ and arg_131_1.time_ <= var_134_16 + arg_134_0 then
				arg_131_1.talkMaxDuration = 0
				arg_131_1.dialogCg_.alpha = 1

				arg_131_1.dialog_:SetActive(true)
				SetActive(arg_131_1.leftNameGo_, true)

				local var_134_18 = arg_131_1:FormatText(StoryNameCfg[1083].name)

				arg_131_1.leftNameTxt_.text = var_134_18

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_131_1.leftNameTxt_.transform)

				arg_131_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_131_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_131_1:RecordName(arg_131_1.leftNameTxt_.text)
				SetActive(arg_131_1.iconTrs_.gameObject, false)
				arg_131_1.callingController_:SetSelectedState("normal")

				local var_134_19 = arg_131_1:GetWordFromCfg(416071032)
				local var_134_20 = arg_131_1:FormatText(var_134_19.content)

				arg_131_1.text_.text = var_134_20

				LuaForUtil.ClearLinePrefixSymbol(arg_131_1.text_)

				local var_134_21 = 29
				local var_134_22 = utf8.len(var_134_20)
				local var_134_23 = var_134_21 <= 0 and var_134_17 or var_134_17 * (var_134_22 / var_134_21)

				if var_134_23 > 0 and var_134_17 < var_134_23 then
					arg_131_1.talkMaxDuration = var_134_23

					if var_134_23 + var_134_16 > arg_131_1.duration_ then
						arg_131_1.duration_ = var_134_23 + var_134_16
					end
				end

				arg_131_1.text_.text = var_134_20
				arg_131_1.typewritter.percent = 0

				arg_131_1.typewritter:SetDirty()
				arg_131_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_416071", "416071032", "story_v_out_416071.awb") ~= 0 then
					local var_134_24 = manager.audio:GetVoiceLength("story_v_out_416071", "416071032", "story_v_out_416071.awb") / 1000

					if var_134_24 + var_134_16 > arg_131_1.duration_ then
						arg_131_1.duration_ = var_134_24 + var_134_16
					end

					if var_134_19.prefab_name ~= "" and arg_131_1.actors_[var_134_19.prefab_name] ~= nil then
						local var_134_25 = LuaForUtil.PlayVoiceWithCriLipsync(arg_131_1.actors_[var_134_19.prefab_name].transform, "story_v_out_416071", "416071032", "story_v_out_416071.awb")

						arg_131_1:RecordAudio("416071032", var_134_25)
						arg_131_1:RecordAudio("416071032", var_134_25)
					else
						arg_131_1:AudioAction("play", "voice", "story_v_out_416071", "416071032", "story_v_out_416071.awb")
					end

					arg_131_1:RecordHistoryTalkVoice("story_v_out_416071", "416071032", "story_v_out_416071.awb")
				end

				arg_131_1:RecordContent(arg_131_1.text_.text)
			end

			local var_134_26 = math.max(var_134_17, arg_131_1.talkMaxDuration)

			if var_134_16 <= arg_131_1.time_ and arg_131_1.time_ < var_134_16 + var_134_26 then
				arg_131_1.typewritter.percent = (arg_131_1.time_ - var_134_16) / var_134_26

				arg_131_1.typewritter:SetDirty()
			end

			if arg_131_1.time_ >= var_134_16 + var_134_26 and arg_131_1.time_ < var_134_16 + var_134_26 + arg_134_0 then
				arg_131_1.typewritter.percent = 1

				arg_131_1.typewritter:SetDirty()
				arg_131_1:ShowNextGo(true)
			end
		end

		arg_131_1.nodeConfigList_ = {}

		arg_131_1:InitPlayNodeList()
	end,
	Play416071033 = function(arg_135_0, arg_135_1)
		arg_135_1.time_ = 0
		arg_135_1.frameCnt_ = 0
		arg_135_1.state_ = "playing"
		arg_135_1.curTalkId_ = 416071033
		arg_135_1.duration_ = 15.6

		local var_135_0 = {
			zh = 6.5,
			ja = 15.6
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
				arg_135_0:Play416071034(arg_135_1)
			end
		end

		function arg_135_1.onSingleLineUpdate_(arg_138_0)
			local var_138_0 = 0
			local var_138_1 = 0.575

			if var_138_0 < arg_135_1.time_ and arg_135_1.time_ <= var_138_0 + arg_138_0 then
				arg_135_1.talkMaxDuration = 0
				arg_135_1.dialogCg_.alpha = 1

				arg_135_1.dialog_:SetActive(true)
				SetActive(arg_135_1.leftNameGo_, true)

				local var_138_2 = arg_135_1:FormatText(StoryNameCfg[1083].name)

				arg_135_1.leftNameTxt_.text = var_138_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_135_1.leftNameTxt_.transform)

				arg_135_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_135_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_135_1:RecordName(arg_135_1.leftNameTxt_.text)
				SetActive(arg_135_1.iconTrs_.gameObject, false)
				arg_135_1.callingController_:SetSelectedState("normal")

				local var_138_3 = arg_135_1:GetWordFromCfg(416071033)
				local var_138_4 = arg_135_1:FormatText(var_138_3.content)

				arg_135_1.text_.text = var_138_4

				LuaForUtil.ClearLinePrefixSymbol(arg_135_1.text_)

				local var_138_5 = 23
				local var_138_6 = utf8.len(var_138_4)
				local var_138_7 = var_138_5 <= 0 and var_138_1 or var_138_1 * (var_138_6 / var_138_5)

				if var_138_7 > 0 and var_138_1 < var_138_7 then
					arg_135_1.talkMaxDuration = var_138_7

					if var_138_7 + var_138_0 > arg_135_1.duration_ then
						arg_135_1.duration_ = var_138_7 + var_138_0
					end
				end

				arg_135_1.text_.text = var_138_4
				arg_135_1.typewritter.percent = 0

				arg_135_1.typewritter:SetDirty()
				arg_135_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_416071", "416071033", "story_v_out_416071.awb") ~= 0 then
					local var_138_8 = manager.audio:GetVoiceLength("story_v_out_416071", "416071033", "story_v_out_416071.awb") / 1000

					if var_138_8 + var_138_0 > arg_135_1.duration_ then
						arg_135_1.duration_ = var_138_8 + var_138_0
					end

					if var_138_3.prefab_name ~= "" and arg_135_1.actors_[var_138_3.prefab_name] ~= nil then
						local var_138_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_135_1.actors_[var_138_3.prefab_name].transform, "story_v_out_416071", "416071033", "story_v_out_416071.awb")

						arg_135_1:RecordAudio("416071033", var_138_9)
						arg_135_1:RecordAudio("416071033", var_138_9)
					else
						arg_135_1:AudioAction("play", "voice", "story_v_out_416071", "416071033", "story_v_out_416071.awb")
					end

					arg_135_1:RecordHistoryTalkVoice("story_v_out_416071", "416071033", "story_v_out_416071.awb")
				end

				arg_135_1:RecordContent(arg_135_1.text_.text)
			end

			local var_138_10 = math.max(var_138_1, arg_135_1.talkMaxDuration)

			if var_138_0 <= arg_135_1.time_ and arg_135_1.time_ < var_138_0 + var_138_10 then
				arg_135_1.typewritter.percent = (arg_135_1.time_ - var_138_0) / var_138_10

				arg_135_1.typewritter:SetDirty()
			end

			if arg_135_1.time_ >= var_138_0 + var_138_10 and arg_135_1.time_ < var_138_0 + var_138_10 + arg_138_0 then
				arg_135_1.typewritter.percent = 1

				arg_135_1.typewritter:SetDirty()
				arg_135_1:ShowNextGo(true)
			end
		end

		arg_135_1.nodeConfigList_ = {}

		arg_135_1:InitPlayNodeList()
	end,
	Play416071034 = function(arg_139_0, arg_139_1)
		arg_139_1.time_ = 0
		arg_139_1.frameCnt_ = 0
		arg_139_1.state_ = "playing"
		arg_139_1.curTalkId_ = 416071034
		arg_139_1.duration_ = 8.1

		local var_139_0 = {
			zh = 8.1,
			ja = 7.5
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
				arg_139_0:Play416071035(arg_139_1)
			end
		end

		function arg_139_1.onSingleLineUpdate_(arg_142_0)
			local var_142_0 = arg_139_1.actors_["10108"]
			local var_142_1 = 0

			if var_142_1 < arg_139_1.time_ and arg_139_1.time_ <= var_142_1 + arg_142_0 and not isNil(var_142_0) and arg_139_1.var_.actorSpriteComps10108 == nil then
				arg_139_1.var_.actorSpriteComps10108 = var_142_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_142_2 = 0.125

			if var_142_1 <= arg_139_1.time_ and arg_139_1.time_ < var_142_1 + var_142_2 and not isNil(var_142_0) then
				local var_142_3 = (arg_139_1.time_ - var_142_1) / var_142_2

				if arg_139_1.var_.actorSpriteComps10108 then
					for iter_142_0, iter_142_1 in pairs(arg_139_1.var_.actorSpriteComps10108:ToTable()) do
						if iter_142_1 then
							if arg_139_1.isInRecall_ then
								local var_142_4 = Mathf.Lerp(iter_142_1.color.r, arg_139_1.hightColor2.r, var_142_3)
								local var_142_5 = Mathf.Lerp(iter_142_1.color.g, arg_139_1.hightColor2.g, var_142_3)
								local var_142_6 = Mathf.Lerp(iter_142_1.color.b, arg_139_1.hightColor2.b, var_142_3)

								iter_142_1.color = Color.New(var_142_4, var_142_5, var_142_6)
							else
								local var_142_7 = Mathf.Lerp(iter_142_1.color.r, 0.5, var_142_3)

								iter_142_1.color = Color.New(var_142_7, var_142_7, var_142_7)
							end
						end
					end
				end
			end

			if arg_139_1.time_ >= var_142_1 + var_142_2 and arg_139_1.time_ < var_142_1 + var_142_2 + arg_142_0 and not isNil(var_142_0) and arg_139_1.var_.actorSpriteComps10108 then
				for iter_142_2, iter_142_3 in pairs(arg_139_1.var_.actorSpriteComps10108:ToTable()) do
					if iter_142_3 then
						if arg_139_1.isInRecall_ then
							iter_142_3.color = arg_139_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_142_3.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_139_1.var_.actorSpriteComps10108 = nil
			end

			local var_142_8 = arg_139_1.actors_["1148"]
			local var_142_9 = 0

			if var_142_9 < arg_139_1.time_ and arg_139_1.time_ <= var_142_9 + arg_142_0 and not isNil(var_142_8) and arg_139_1.var_.actorSpriteComps1148 == nil then
				arg_139_1.var_.actorSpriteComps1148 = var_142_8:GetComponentsInChildren(typeof(Image), true)
			end

			local var_142_10 = 0.125

			if var_142_9 <= arg_139_1.time_ and arg_139_1.time_ < var_142_9 + var_142_10 and not isNil(var_142_8) then
				local var_142_11 = (arg_139_1.time_ - var_142_9) / var_142_10

				if arg_139_1.var_.actorSpriteComps1148 then
					for iter_142_4, iter_142_5 in pairs(arg_139_1.var_.actorSpriteComps1148:ToTable()) do
						if iter_142_5 then
							if arg_139_1.isInRecall_ then
								local var_142_12 = Mathf.Lerp(iter_142_5.color.r, arg_139_1.hightColor1.r, var_142_11)
								local var_142_13 = Mathf.Lerp(iter_142_5.color.g, arg_139_1.hightColor1.g, var_142_11)
								local var_142_14 = Mathf.Lerp(iter_142_5.color.b, arg_139_1.hightColor1.b, var_142_11)

								iter_142_5.color = Color.New(var_142_12, var_142_13, var_142_14)
							else
								local var_142_15 = Mathf.Lerp(iter_142_5.color.r, 1, var_142_11)

								iter_142_5.color = Color.New(var_142_15, var_142_15, var_142_15)
							end
						end
					end
				end
			end

			if arg_139_1.time_ >= var_142_9 + var_142_10 and arg_139_1.time_ < var_142_9 + var_142_10 + arg_142_0 and not isNil(var_142_8) and arg_139_1.var_.actorSpriteComps1148 then
				for iter_142_6, iter_142_7 in pairs(arg_139_1.var_.actorSpriteComps1148:ToTable()) do
					if iter_142_7 then
						if arg_139_1.isInRecall_ then
							iter_142_7.color = arg_139_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_142_7.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_139_1.var_.actorSpriteComps1148 = nil
			end

			local var_142_16 = 0
			local var_142_17 = 0.65

			if var_142_16 < arg_139_1.time_ and arg_139_1.time_ <= var_142_16 + arg_142_0 then
				arg_139_1.talkMaxDuration = 0
				arg_139_1.dialogCg_.alpha = 1

				arg_139_1.dialog_:SetActive(true)
				SetActive(arg_139_1.leftNameGo_, true)

				local var_142_18 = arg_139_1:FormatText(StoryNameCfg[8].name)

				arg_139_1.leftNameTxt_.text = var_142_18

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_139_1.leftNameTxt_.transform)

				arg_139_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_139_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_139_1:RecordName(arg_139_1.leftNameTxt_.text)
				SetActive(arg_139_1.iconTrs_.gameObject, false)
				arg_139_1.callingController_:SetSelectedState("normal")

				local var_142_19 = arg_139_1:GetWordFromCfg(416071034)
				local var_142_20 = arg_139_1:FormatText(var_142_19.content)

				arg_139_1.text_.text = var_142_20

				LuaForUtil.ClearLinePrefixSymbol(arg_139_1.text_)

				local var_142_21 = 30
				local var_142_22 = utf8.len(var_142_20)
				local var_142_23 = var_142_21 <= 0 and var_142_17 or var_142_17 * (var_142_22 / var_142_21)

				if var_142_23 > 0 and var_142_17 < var_142_23 then
					arg_139_1.talkMaxDuration = var_142_23

					if var_142_23 + var_142_16 > arg_139_1.duration_ then
						arg_139_1.duration_ = var_142_23 + var_142_16
					end
				end

				arg_139_1.text_.text = var_142_20
				arg_139_1.typewritter.percent = 0

				arg_139_1.typewritter:SetDirty()
				arg_139_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_416071", "416071034", "story_v_out_416071.awb") ~= 0 then
					local var_142_24 = manager.audio:GetVoiceLength("story_v_out_416071", "416071034", "story_v_out_416071.awb") / 1000

					if var_142_24 + var_142_16 > arg_139_1.duration_ then
						arg_139_1.duration_ = var_142_24 + var_142_16
					end

					if var_142_19.prefab_name ~= "" and arg_139_1.actors_[var_142_19.prefab_name] ~= nil then
						local var_142_25 = LuaForUtil.PlayVoiceWithCriLipsync(arg_139_1.actors_[var_142_19.prefab_name].transform, "story_v_out_416071", "416071034", "story_v_out_416071.awb")

						arg_139_1:RecordAudio("416071034", var_142_25)
						arg_139_1:RecordAudio("416071034", var_142_25)
					else
						arg_139_1:AudioAction("play", "voice", "story_v_out_416071", "416071034", "story_v_out_416071.awb")
					end

					arg_139_1:RecordHistoryTalkVoice("story_v_out_416071", "416071034", "story_v_out_416071.awb")
				end

				arg_139_1:RecordContent(arg_139_1.text_.text)
			end

			local var_142_26 = math.max(var_142_17, arg_139_1.talkMaxDuration)

			if var_142_16 <= arg_139_1.time_ and arg_139_1.time_ < var_142_16 + var_142_26 then
				arg_139_1.typewritter.percent = (arg_139_1.time_ - var_142_16) / var_142_26

				arg_139_1.typewritter:SetDirty()
			end

			if arg_139_1.time_ >= var_142_16 + var_142_26 and arg_139_1.time_ < var_142_16 + var_142_26 + arg_142_0 then
				arg_139_1.typewritter.percent = 1

				arg_139_1.typewritter:SetDirty()
				arg_139_1:ShowNextGo(true)
			end
		end

		arg_139_1.nodeConfigList_ = {}

		arg_139_1:InitPlayNodeList()
	end,
	Play416071035 = function(arg_143_0, arg_143_1)
		arg_143_1.time_ = 0
		arg_143_1.frameCnt_ = 0
		arg_143_1.state_ = "playing"
		arg_143_1.curTalkId_ = 416071035
		arg_143_1.duration_ = 11.63

		local var_143_0 = {
			zh = 5.166,
			ja = 11.633
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
				arg_143_0:Play416071036(arg_143_1)
			end
		end

		function arg_143_1.onSingleLineUpdate_(arg_146_0)
			local var_146_0 = arg_143_1.actors_["10108"]
			local var_146_1 = 0

			if var_146_1 < arg_143_1.time_ and arg_143_1.time_ <= var_146_1 + arg_146_0 and not isNil(var_146_0) and arg_143_1.var_.actorSpriteComps10108 == nil then
				arg_143_1.var_.actorSpriteComps10108 = var_146_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_146_2 = 0.125

			if var_146_1 <= arg_143_1.time_ and arg_143_1.time_ < var_146_1 + var_146_2 and not isNil(var_146_0) then
				local var_146_3 = (arg_143_1.time_ - var_146_1) / var_146_2

				if arg_143_1.var_.actorSpriteComps10108 then
					for iter_146_0, iter_146_1 in pairs(arg_143_1.var_.actorSpriteComps10108:ToTable()) do
						if iter_146_1 then
							if arg_143_1.isInRecall_ then
								local var_146_4 = Mathf.Lerp(iter_146_1.color.r, arg_143_1.hightColor1.r, var_146_3)
								local var_146_5 = Mathf.Lerp(iter_146_1.color.g, arg_143_1.hightColor1.g, var_146_3)
								local var_146_6 = Mathf.Lerp(iter_146_1.color.b, arg_143_1.hightColor1.b, var_146_3)

								iter_146_1.color = Color.New(var_146_4, var_146_5, var_146_6)
							else
								local var_146_7 = Mathf.Lerp(iter_146_1.color.r, 1, var_146_3)

								iter_146_1.color = Color.New(var_146_7, var_146_7, var_146_7)
							end
						end
					end
				end
			end

			if arg_143_1.time_ >= var_146_1 + var_146_2 and arg_143_1.time_ < var_146_1 + var_146_2 + arg_146_0 and not isNil(var_146_0) and arg_143_1.var_.actorSpriteComps10108 then
				for iter_146_2, iter_146_3 in pairs(arg_143_1.var_.actorSpriteComps10108:ToTable()) do
					if iter_146_3 then
						if arg_143_1.isInRecall_ then
							iter_146_3.color = arg_143_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_146_3.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_143_1.var_.actorSpriteComps10108 = nil
			end

			local var_146_8 = arg_143_1.actors_["1148"]
			local var_146_9 = 0

			if var_146_9 < arg_143_1.time_ and arg_143_1.time_ <= var_146_9 + arg_146_0 and not isNil(var_146_8) and arg_143_1.var_.actorSpriteComps1148 == nil then
				arg_143_1.var_.actorSpriteComps1148 = var_146_8:GetComponentsInChildren(typeof(Image), true)
			end

			local var_146_10 = 0.125

			if var_146_9 <= arg_143_1.time_ and arg_143_1.time_ < var_146_9 + var_146_10 and not isNil(var_146_8) then
				local var_146_11 = (arg_143_1.time_ - var_146_9) / var_146_10

				if arg_143_1.var_.actorSpriteComps1148 then
					for iter_146_4, iter_146_5 in pairs(arg_143_1.var_.actorSpriteComps1148:ToTable()) do
						if iter_146_5 then
							if arg_143_1.isInRecall_ then
								local var_146_12 = Mathf.Lerp(iter_146_5.color.r, arg_143_1.hightColor2.r, var_146_11)
								local var_146_13 = Mathf.Lerp(iter_146_5.color.g, arg_143_1.hightColor2.g, var_146_11)
								local var_146_14 = Mathf.Lerp(iter_146_5.color.b, arg_143_1.hightColor2.b, var_146_11)

								iter_146_5.color = Color.New(var_146_12, var_146_13, var_146_14)
							else
								local var_146_15 = Mathf.Lerp(iter_146_5.color.r, 0.5, var_146_11)

								iter_146_5.color = Color.New(var_146_15, var_146_15, var_146_15)
							end
						end
					end
				end
			end

			if arg_143_1.time_ >= var_146_9 + var_146_10 and arg_143_1.time_ < var_146_9 + var_146_10 + arg_146_0 and not isNil(var_146_8) and arg_143_1.var_.actorSpriteComps1148 then
				for iter_146_6, iter_146_7 in pairs(arg_143_1.var_.actorSpriteComps1148:ToTable()) do
					if iter_146_7 then
						if arg_143_1.isInRecall_ then
							iter_146_7.color = arg_143_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_146_7.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_143_1.var_.actorSpriteComps1148 = nil
			end

			local var_146_16 = arg_143_1.actors_["10108"].transform
			local var_146_17 = 0

			if var_146_17 < arg_143_1.time_ and arg_143_1.time_ <= var_146_17 + arg_146_0 then
				arg_143_1.var_.moveOldPos10108 = var_146_16.localPosition
				var_146_16.localScale = Vector3.New(1, 1, 1)

				arg_143_1:CheckSpriteTmpPos("10108", 2)

				local var_146_18 = var_146_16.childCount

				for iter_146_8 = 0, var_146_18 - 1 do
					local var_146_19 = var_146_16:GetChild(iter_146_8)

					if var_146_19.name == "split_2" or not string.find(var_146_19.name, "split") then
						var_146_19.gameObject:SetActive(true)
					else
						var_146_19.gameObject:SetActive(false)
					end
				end
			end

			local var_146_20 = 0.001

			if var_146_17 <= arg_143_1.time_ and arg_143_1.time_ < var_146_17 + var_146_20 then
				local var_146_21 = (arg_143_1.time_ - var_146_17) / var_146_20
				local var_146_22 = Vector3.New(-390, -399.6, -130)

				var_146_16.localPosition = Vector3.Lerp(arg_143_1.var_.moveOldPos10108, var_146_22, var_146_21)
			end

			if arg_143_1.time_ >= var_146_17 + var_146_20 and arg_143_1.time_ < var_146_17 + var_146_20 + arg_146_0 then
				var_146_16.localPosition = Vector3.New(-390, -399.6, -130)
			end

			local var_146_23 = 0
			local var_146_24 = 0.425

			if var_146_23 < arg_143_1.time_ and arg_143_1.time_ <= var_146_23 + arg_146_0 then
				arg_143_1.talkMaxDuration = 0
				arg_143_1.dialogCg_.alpha = 1

				arg_143_1.dialog_:SetActive(true)
				SetActive(arg_143_1.leftNameGo_, true)

				local var_146_25 = arg_143_1:FormatText(StoryNameCfg[1083].name)

				arg_143_1.leftNameTxt_.text = var_146_25

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_143_1.leftNameTxt_.transform)

				arg_143_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_143_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_143_1:RecordName(arg_143_1.leftNameTxt_.text)
				SetActive(arg_143_1.iconTrs_.gameObject, false)
				arg_143_1.callingController_:SetSelectedState("normal")

				local var_146_26 = arg_143_1:GetWordFromCfg(416071035)
				local var_146_27 = arg_143_1:FormatText(var_146_26.content)

				arg_143_1.text_.text = var_146_27

				LuaForUtil.ClearLinePrefixSymbol(arg_143_1.text_)

				local var_146_28 = 17
				local var_146_29 = utf8.len(var_146_27)
				local var_146_30 = var_146_28 <= 0 and var_146_24 or var_146_24 * (var_146_29 / var_146_28)

				if var_146_30 > 0 and var_146_24 < var_146_30 then
					arg_143_1.talkMaxDuration = var_146_30

					if var_146_30 + var_146_23 > arg_143_1.duration_ then
						arg_143_1.duration_ = var_146_30 + var_146_23
					end
				end

				arg_143_1.text_.text = var_146_27
				arg_143_1.typewritter.percent = 0

				arg_143_1.typewritter:SetDirty()
				arg_143_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_416071", "416071035", "story_v_out_416071.awb") ~= 0 then
					local var_146_31 = manager.audio:GetVoiceLength("story_v_out_416071", "416071035", "story_v_out_416071.awb") / 1000

					if var_146_31 + var_146_23 > arg_143_1.duration_ then
						arg_143_1.duration_ = var_146_31 + var_146_23
					end

					if var_146_26.prefab_name ~= "" and arg_143_1.actors_[var_146_26.prefab_name] ~= nil then
						local var_146_32 = LuaForUtil.PlayVoiceWithCriLipsync(arg_143_1.actors_[var_146_26.prefab_name].transform, "story_v_out_416071", "416071035", "story_v_out_416071.awb")

						arg_143_1:RecordAudio("416071035", var_146_32)
						arg_143_1:RecordAudio("416071035", var_146_32)
					else
						arg_143_1:AudioAction("play", "voice", "story_v_out_416071", "416071035", "story_v_out_416071.awb")
					end

					arg_143_1:RecordHistoryTalkVoice("story_v_out_416071", "416071035", "story_v_out_416071.awb")
				end

				arg_143_1:RecordContent(arg_143_1.text_.text)
			end

			local var_146_33 = math.max(var_146_24, arg_143_1.talkMaxDuration)

			if var_146_23 <= arg_143_1.time_ and arg_143_1.time_ < var_146_23 + var_146_33 then
				arg_143_1.typewritter.percent = (arg_143_1.time_ - var_146_23) / var_146_33

				arg_143_1.typewritter:SetDirty()
			end

			if arg_143_1.time_ >= var_146_23 + var_146_33 and arg_143_1.time_ < var_146_23 + var_146_33 + arg_146_0 then
				arg_143_1.typewritter.percent = 1

				arg_143_1.typewritter:SetDirty()
				arg_143_1:ShowNextGo(true)
			end
		end

		arg_143_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10108",
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
	Play416071036 = function(arg_147_0, arg_147_1)
		arg_147_1.time_ = 0
		arg_147_1.frameCnt_ = 0
		arg_147_1.state_ = "playing"
		arg_147_1.curTalkId_ = 416071036
		arg_147_1.duration_ = 7.17

		local var_147_0 = {
			zh = 6.733,
			ja = 7.166
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
				arg_147_0:Play416071037(arg_147_1)
			end
		end

		function arg_147_1.onSingleLineUpdate_(arg_150_0)
			local var_150_0 = arg_147_1.actors_["10108"]
			local var_150_1 = 0

			if var_150_1 < arg_147_1.time_ and arg_147_1.time_ <= var_150_1 + arg_150_0 and not isNil(var_150_0) and arg_147_1.var_.actorSpriteComps10108 == nil then
				arg_147_1.var_.actorSpriteComps10108 = var_150_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_150_2 = 0.125

			if var_150_1 <= arg_147_1.time_ and arg_147_1.time_ < var_150_1 + var_150_2 and not isNil(var_150_0) then
				local var_150_3 = (arg_147_1.time_ - var_150_1) / var_150_2

				if arg_147_1.var_.actorSpriteComps10108 then
					for iter_150_0, iter_150_1 in pairs(arg_147_1.var_.actorSpriteComps10108:ToTable()) do
						if iter_150_1 then
							if arg_147_1.isInRecall_ then
								local var_150_4 = Mathf.Lerp(iter_150_1.color.r, arg_147_1.hightColor2.r, var_150_3)
								local var_150_5 = Mathf.Lerp(iter_150_1.color.g, arg_147_1.hightColor2.g, var_150_3)
								local var_150_6 = Mathf.Lerp(iter_150_1.color.b, arg_147_1.hightColor2.b, var_150_3)

								iter_150_1.color = Color.New(var_150_4, var_150_5, var_150_6)
							else
								local var_150_7 = Mathf.Lerp(iter_150_1.color.r, 0.5, var_150_3)

								iter_150_1.color = Color.New(var_150_7, var_150_7, var_150_7)
							end
						end
					end
				end
			end

			if arg_147_1.time_ >= var_150_1 + var_150_2 and arg_147_1.time_ < var_150_1 + var_150_2 + arg_150_0 and not isNil(var_150_0) and arg_147_1.var_.actorSpriteComps10108 then
				for iter_150_2, iter_150_3 in pairs(arg_147_1.var_.actorSpriteComps10108:ToTable()) do
					if iter_150_3 then
						if arg_147_1.isInRecall_ then
							iter_150_3.color = arg_147_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_150_3.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_147_1.var_.actorSpriteComps10108 = nil
			end

			local var_150_8 = arg_147_1.actors_["1148"]
			local var_150_9 = 0

			if var_150_9 < arg_147_1.time_ and arg_147_1.time_ <= var_150_9 + arg_150_0 and not isNil(var_150_8) and arg_147_1.var_.actorSpriteComps1148 == nil then
				arg_147_1.var_.actorSpriteComps1148 = var_150_8:GetComponentsInChildren(typeof(Image), true)
			end

			local var_150_10 = 0.125

			if var_150_9 <= arg_147_1.time_ and arg_147_1.time_ < var_150_9 + var_150_10 and not isNil(var_150_8) then
				local var_150_11 = (arg_147_1.time_ - var_150_9) / var_150_10

				if arg_147_1.var_.actorSpriteComps1148 then
					for iter_150_4, iter_150_5 in pairs(arg_147_1.var_.actorSpriteComps1148:ToTable()) do
						if iter_150_5 then
							if arg_147_1.isInRecall_ then
								local var_150_12 = Mathf.Lerp(iter_150_5.color.r, arg_147_1.hightColor1.r, var_150_11)
								local var_150_13 = Mathf.Lerp(iter_150_5.color.g, arg_147_1.hightColor1.g, var_150_11)
								local var_150_14 = Mathf.Lerp(iter_150_5.color.b, arg_147_1.hightColor1.b, var_150_11)

								iter_150_5.color = Color.New(var_150_12, var_150_13, var_150_14)
							else
								local var_150_15 = Mathf.Lerp(iter_150_5.color.r, 1, var_150_11)

								iter_150_5.color = Color.New(var_150_15, var_150_15, var_150_15)
							end
						end
					end
				end
			end

			if arg_147_1.time_ >= var_150_9 + var_150_10 and arg_147_1.time_ < var_150_9 + var_150_10 + arg_150_0 and not isNil(var_150_8) and arg_147_1.var_.actorSpriteComps1148 then
				for iter_150_6, iter_150_7 in pairs(arg_147_1.var_.actorSpriteComps1148:ToTable()) do
					if iter_150_7 then
						if arg_147_1.isInRecall_ then
							iter_150_7.color = arg_147_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_150_7.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_147_1.var_.actorSpriteComps1148 = nil
			end

			local var_150_16 = arg_147_1.actors_["1148"].transform
			local var_150_17 = 0

			if var_150_17 < arg_147_1.time_ and arg_147_1.time_ <= var_150_17 + arg_150_0 then
				arg_147_1.var_.moveOldPos1148 = var_150_16.localPosition
				var_150_16.localScale = Vector3.New(1, 1, 1)

				arg_147_1:CheckSpriteTmpPos("1148", 4)

				local var_150_18 = var_150_16.childCount

				for iter_150_8 = 0, var_150_18 - 1 do
					local var_150_19 = var_150_16:GetChild(iter_150_8)

					if var_150_19.name == "split_6" or not string.find(var_150_19.name, "split") then
						var_150_19.gameObject:SetActive(true)
					else
						var_150_19.gameObject:SetActive(false)
					end
				end
			end

			local var_150_20 = 0.001

			if var_150_17 <= arg_147_1.time_ and arg_147_1.time_ < var_150_17 + var_150_20 then
				local var_150_21 = (arg_147_1.time_ - var_150_17) / var_150_20
				local var_150_22 = Vector3.New(390, -429, -180)

				var_150_16.localPosition = Vector3.Lerp(arg_147_1.var_.moveOldPos1148, var_150_22, var_150_21)
			end

			if arg_147_1.time_ >= var_150_17 + var_150_20 and arg_147_1.time_ < var_150_17 + var_150_20 + arg_150_0 then
				var_150_16.localPosition = Vector3.New(390, -429, -180)
			end

			local var_150_23 = 0
			local var_150_24 = 0.825

			if var_150_23 < arg_147_1.time_ and arg_147_1.time_ <= var_150_23 + arg_150_0 then
				arg_147_1.talkMaxDuration = 0
				arg_147_1.dialogCg_.alpha = 1

				arg_147_1.dialog_:SetActive(true)
				SetActive(arg_147_1.leftNameGo_, true)

				local var_150_25 = arg_147_1:FormatText(StoryNameCfg[8].name)

				arg_147_1.leftNameTxt_.text = var_150_25

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_147_1.leftNameTxt_.transform)

				arg_147_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_147_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_147_1:RecordName(arg_147_1.leftNameTxt_.text)
				SetActive(arg_147_1.iconTrs_.gameObject, false)
				arg_147_1.callingController_:SetSelectedState("normal")

				local var_150_26 = arg_147_1:GetWordFromCfg(416071036)
				local var_150_27 = arg_147_1:FormatText(var_150_26.content)

				arg_147_1.text_.text = var_150_27

				LuaForUtil.ClearLinePrefixSymbol(arg_147_1.text_)

				local var_150_28 = 33
				local var_150_29 = utf8.len(var_150_27)
				local var_150_30 = var_150_28 <= 0 and var_150_24 or var_150_24 * (var_150_29 / var_150_28)

				if var_150_30 > 0 and var_150_24 < var_150_30 then
					arg_147_1.talkMaxDuration = var_150_30

					if var_150_30 + var_150_23 > arg_147_1.duration_ then
						arg_147_1.duration_ = var_150_30 + var_150_23
					end
				end

				arg_147_1.text_.text = var_150_27
				arg_147_1.typewritter.percent = 0

				arg_147_1.typewritter:SetDirty()
				arg_147_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_416071", "416071036", "story_v_out_416071.awb") ~= 0 then
					local var_150_31 = manager.audio:GetVoiceLength("story_v_out_416071", "416071036", "story_v_out_416071.awb") / 1000

					if var_150_31 + var_150_23 > arg_147_1.duration_ then
						arg_147_1.duration_ = var_150_31 + var_150_23
					end

					if var_150_26.prefab_name ~= "" and arg_147_1.actors_[var_150_26.prefab_name] ~= nil then
						local var_150_32 = LuaForUtil.PlayVoiceWithCriLipsync(arg_147_1.actors_[var_150_26.prefab_name].transform, "story_v_out_416071", "416071036", "story_v_out_416071.awb")

						arg_147_1:RecordAudio("416071036", var_150_32)
						arg_147_1:RecordAudio("416071036", var_150_32)
					else
						arg_147_1:AudioAction("play", "voice", "story_v_out_416071", "416071036", "story_v_out_416071.awb")
					end

					arg_147_1:RecordHistoryTalkVoice("story_v_out_416071", "416071036", "story_v_out_416071.awb")
				end

				arg_147_1:RecordContent(arg_147_1.text_.text)
			end

			local var_150_33 = math.max(var_150_24, arg_147_1.talkMaxDuration)

			if var_150_23 <= arg_147_1.time_ and arg_147_1.time_ < var_150_23 + var_150_33 then
				arg_147_1.typewritter.percent = (arg_147_1.time_ - var_150_23) / var_150_33

				arg_147_1.typewritter:SetDirty()
			end

			if arg_147_1.time_ >= var_150_23 + var_150_33 and arg_147_1.time_ < var_150_23 + var_150_33 + arg_150_0 then
				arg_147_1.typewritter.percent = 1

				arg_147_1.typewritter:SetDirty()
				arg_147_1:ShowNextGo(true)
			end
		end

		arg_147_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1148",
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
	Play416071037 = function(arg_151_0, arg_151_1)
		arg_151_1.time_ = 0
		arg_151_1.frameCnt_ = 0
		arg_151_1.state_ = "playing"
		arg_151_1.curTalkId_ = 416071037
		arg_151_1.duration_ = 12.6

		local var_151_0 = {
			zh = 6.233,
			ja = 12.6
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
				arg_151_0:Play416071038(arg_151_1)
			end
		end

		function arg_151_1.onSingleLineUpdate_(arg_154_0)
			local var_154_0 = arg_151_1.actors_["10108"]
			local var_154_1 = 0

			if var_154_1 < arg_151_1.time_ and arg_151_1.time_ <= var_154_1 + arg_154_0 and not isNil(var_154_0) and arg_151_1.var_.actorSpriteComps10108 == nil then
				arg_151_1.var_.actorSpriteComps10108 = var_154_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_154_2 = 0.125

			if var_154_1 <= arg_151_1.time_ and arg_151_1.time_ < var_154_1 + var_154_2 and not isNil(var_154_0) then
				local var_154_3 = (arg_151_1.time_ - var_154_1) / var_154_2

				if arg_151_1.var_.actorSpriteComps10108 then
					for iter_154_0, iter_154_1 in pairs(arg_151_1.var_.actorSpriteComps10108:ToTable()) do
						if iter_154_1 then
							if arg_151_1.isInRecall_ then
								local var_154_4 = Mathf.Lerp(iter_154_1.color.r, arg_151_1.hightColor1.r, var_154_3)
								local var_154_5 = Mathf.Lerp(iter_154_1.color.g, arg_151_1.hightColor1.g, var_154_3)
								local var_154_6 = Mathf.Lerp(iter_154_1.color.b, arg_151_1.hightColor1.b, var_154_3)

								iter_154_1.color = Color.New(var_154_4, var_154_5, var_154_6)
							else
								local var_154_7 = Mathf.Lerp(iter_154_1.color.r, 1, var_154_3)

								iter_154_1.color = Color.New(var_154_7, var_154_7, var_154_7)
							end
						end
					end
				end
			end

			if arg_151_1.time_ >= var_154_1 + var_154_2 and arg_151_1.time_ < var_154_1 + var_154_2 + arg_154_0 and not isNil(var_154_0) and arg_151_1.var_.actorSpriteComps10108 then
				for iter_154_2, iter_154_3 in pairs(arg_151_1.var_.actorSpriteComps10108:ToTable()) do
					if iter_154_3 then
						if arg_151_1.isInRecall_ then
							iter_154_3.color = arg_151_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_154_3.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_151_1.var_.actorSpriteComps10108 = nil
			end

			local var_154_8 = arg_151_1.actors_["1148"]
			local var_154_9 = 0

			if var_154_9 < arg_151_1.time_ and arg_151_1.time_ <= var_154_9 + arg_154_0 and not isNil(var_154_8) and arg_151_1.var_.actorSpriteComps1148 == nil then
				arg_151_1.var_.actorSpriteComps1148 = var_154_8:GetComponentsInChildren(typeof(Image), true)
			end

			local var_154_10 = 0.125

			if var_154_9 <= arg_151_1.time_ and arg_151_1.time_ < var_154_9 + var_154_10 and not isNil(var_154_8) then
				local var_154_11 = (arg_151_1.time_ - var_154_9) / var_154_10

				if arg_151_1.var_.actorSpriteComps1148 then
					for iter_154_4, iter_154_5 in pairs(arg_151_1.var_.actorSpriteComps1148:ToTable()) do
						if iter_154_5 then
							if arg_151_1.isInRecall_ then
								local var_154_12 = Mathf.Lerp(iter_154_5.color.r, arg_151_1.hightColor2.r, var_154_11)
								local var_154_13 = Mathf.Lerp(iter_154_5.color.g, arg_151_1.hightColor2.g, var_154_11)
								local var_154_14 = Mathf.Lerp(iter_154_5.color.b, arg_151_1.hightColor2.b, var_154_11)

								iter_154_5.color = Color.New(var_154_12, var_154_13, var_154_14)
							else
								local var_154_15 = Mathf.Lerp(iter_154_5.color.r, 0.5, var_154_11)

								iter_154_5.color = Color.New(var_154_15, var_154_15, var_154_15)
							end
						end
					end
				end
			end

			if arg_151_1.time_ >= var_154_9 + var_154_10 and arg_151_1.time_ < var_154_9 + var_154_10 + arg_154_0 and not isNil(var_154_8) and arg_151_1.var_.actorSpriteComps1148 then
				for iter_154_6, iter_154_7 in pairs(arg_151_1.var_.actorSpriteComps1148:ToTable()) do
					if iter_154_7 then
						if arg_151_1.isInRecall_ then
							iter_154_7.color = arg_151_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_154_7.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_151_1.var_.actorSpriteComps1148 = nil
			end

			local var_154_16 = arg_151_1.actors_["10108"].transform
			local var_154_17 = 0

			if var_154_17 < arg_151_1.time_ and arg_151_1.time_ <= var_154_17 + arg_154_0 then
				arg_151_1.var_.moveOldPos10108 = var_154_16.localPosition
				var_154_16.localScale = Vector3.New(1, 1, 1)

				arg_151_1:CheckSpriteTmpPos("10108", 2)

				local var_154_18 = var_154_16.childCount

				for iter_154_8 = 0, var_154_18 - 1 do
					local var_154_19 = var_154_16:GetChild(iter_154_8)

					if var_154_19.name == "split_4" or not string.find(var_154_19.name, "split") then
						var_154_19.gameObject:SetActive(true)
					else
						var_154_19.gameObject:SetActive(false)
					end
				end
			end

			local var_154_20 = 0.001

			if var_154_17 <= arg_151_1.time_ and arg_151_1.time_ < var_154_17 + var_154_20 then
				local var_154_21 = (arg_151_1.time_ - var_154_17) / var_154_20
				local var_154_22 = Vector3.New(-390, -399.6, -130)

				var_154_16.localPosition = Vector3.Lerp(arg_151_1.var_.moveOldPos10108, var_154_22, var_154_21)
			end

			if arg_151_1.time_ >= var_154_17 + var_154_20 and arg_151_1.time_ < var_154_17 + var_154_20 + arg_154_0 then
				var_154_16.localPosition = Vector3.New(-390, -399.6, -130)
			end

			local var_154_23 = 0
			local var_154_24 = 0.675

			if var_154_23 < arg_151_1.time_ and arg_151_1.time_ <= var_154_23 + arg_154_0 then
				arg_151_1.talkMaxDuration = 0
				arg_151_1.dialogCg_.alpha = 1

				arg_151_1.dialog_:SetActive(true)
				SetActive(arg_151_1.leftNameGo_, true)

				local var_154_25 = arg_151_1:FormatText(StoryNameCfg[1083].name)

				arg_151_1.leftNameTxt_.text = var_154_25

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_151_1.leftNameTxt_.transform)

				arg_151_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_151_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_151_1:RecordName(arg_151_1.leftNameTxt_.text)
				SetActive(arg_151_1.iconTrs_.gameObject, false)
				arg_151_1.callingController_:SetSelectedState("normal")

				local var_154_26 = arg_151_1:GetWordFromCfg(416071037)
				local var_154_27 = arg_151_1:FormatText(var_154_26.content)

				arg_151_1.text_.text = var_154_27

				LuaForUtil.ClearLinePrefixSymbol(arg_151_1.text_)

				local var_154_28 = 27
				local var_154_29 = utf8.len(var_154_27)
				local var_154_30 = var_154_28 <= 0 and var_154_24 or var_154_24 * (var_154_29 / var_154_28)

				if var_154_30 > 0 and var_154_24 < var_154_30 then
					arg_151_1.talkMaxDuration = var_154_30

					if var_154_30 + var_154_23 > arg_151_1.duration_ then
						arg_151_1.duration_ = var_154_30 + var_154_23
					end
				end

				arg_151_1.text_.text = var_154_27
				arg_151_1.typewritter.percent = 0

				arg_151_1.typewritter:SetDirty()
				arg_151_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_416071", "416071037", "story_v_out_416071.awb") ~= 0 then
					local var_154_31 = manager.audio:GetVoiceLength("story_v_out_416071", "416071037", "story_v_out_416071.awb") / 1000

					if var_154_31 + var_154_23 > arg_151_1.duration_ then
						arg_151_1.duration_ = var_154_31 + var_154_23
					end

					if var_154_26.prefab_name ~= "" and arg_151_1.actors_[var_154_26.prefab_name] ~= nil then
						local var_154_32 = LuaForUtil.PlayVoiceWithCriLipsync(arg_151_1.actors_[var_154_26.prefab_name].transform, "story_v_out_416071", "416071037", "story_v_out_416071.awb")

						arg_151_1:RecordAudio("416071037", var_154_32)
						arg_151_1:RecordAudio("416071037", var_154_32)
					else
						arg_151_1:AudioAction("play", "voice", "story_v_out_416071", "416071037", "story_v_out_416071.awb")
					end

					arg_151_1:RecordHistoryTalkVoice("story_v_out_416071", "416071037", "story_v_out_416071.awb")
				end

				arg_151_1:RecordContent(arg_151_1.text_.text)
			end

			local var_154_33 = math.max(var_154_24, arg_151_1.talkMaxDuration)

			if var_154_23 <= arg_151_1.time_ and arg_151_1.time_ < var_154_23 + var_154_33 then
				arg_151_1.typewritter.percent = (arg_151_1.time_ - var_154_23) / var_154_33

				arg_151_1.typewritter:SetDirty()
			end

			if arg_151_1.time_ >= var_154_23 + var_154_33 and arg_151_1.time_ < var_154_23 + var_154_33 + arg_154_0 then
				arg_151_1.typewritter.percent = 1

				arg_151_1.typewritter:SetDirty()
				arg_151_1:ShowNextGo(true)
			end
		end

		arg_151_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10108",
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
	Play416071038 = function(arg_155_0, arg_155_1)
		arg_155_1.time_ = 0
		arg_155_1.frameCnt_ = 0
		arg_155_1.state_ = "playing"
		arg_155_1.curTalkId_ = 416071038
		arg_155_1.duration_ = 6.37

		local var_155_0 = {
			zh = 5.1,
			ja = 6.366
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
				arg_155_0:Play416071039(arg_155_1)
			end
		end

		function arg_155_1.onSingleLineUpdate_(arg_158_0)
			local var_158_0 = arg_155_1.actors_["10108"]
			local var_158_1 = 0

			if var_158_1 < arg_155_1.time_ and arg_155_1.time_ <= var_158_1 + arg_158_0 and not isNil(var_158_0) and arg_155_1.var_.actorSpriteComps10108 == nil then
				arg_155_1.var_.actorSpriteComps10108 = var_158_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_158_2 = 0.125

			if var_158_1 <= arg_155_1.time_ and arg_155_1.time_ < var_158_1 + var_158_2 and not isNil(var_158_0) then
				local var_158_3 = (arg_155_1.time_ - var_158_1) / var_158_2

				if arg_155_1.var_.actorSpriteComps10108 then
					for iter_158_0, iter_158_1 in pairs(arg_155_1.var_.actorSpriteComps10108:ToTable()) do
						if iter_158_1 then
							if arg_155_1.isInRecall_ then
								local var_158_4 = Mathf.Lerp(iter_158_1.color.r, arg_155_1.hightColor2.r, var_158_3)
								local var_158_5 = Mathf.Lerp(iter_158_1.color.g, arg_155_1.hightColor2.g, var_158_3)
								local var_158_6 = Mathf.Lerp(iter_158_1.color.b, arg_155_1.hightColor2.b, var_158_3)

								iter_158_1.color = Color.New(var_158_4, var_158_5, var_158_6)
							else
								local var_158_7 = Mathf.Lerp(iter_158_1.color.r, 0.5, var_158_3)

								iter_158_1.color = Color.New(var_158_7, var_158_7, var_158_7)
							end
						end
					end
				end
			end

			if arg_155_1.time_ >= var_158_1 + var_158_2 and arg_155_1.time_ < var_158_1 + var_158_2 + arg_158_0 and not isNil(var_158_0) and arg_155_1.var_.actorSpriteComps10108 then
				for iter_158_2, iter_158_3 in pairs(arg_155_1.var_.actorSpriteComps10108:ToTable()) do
					if iter_158_3 then
						if arg_155_1.isInRecall_ then
							iter_158_3.color = arg_155_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_158_3.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_155_1.var_.actorSpriteComps10108 = nil
			end

			local var_158_8 = arg_155_1.actors_["1148"]
			local var_158_9 = 0

			if var_158_9 < arg_155_1.time_ and arg_155_1.time_ <= var_158_9 + arg_158_0 and not isNil(var_158_8) and arg_155_1.var_.actorSpriteComps1148 == nil then
				arg_155_1.var_.actorSpriteComps1148 = var_158_8:GetComponentsInChildren(typeof(Image), true)
			end

			local var_158_10 = 0.125

			if var_158_9 <= arg_155_1.time_ and arg_155_1.time_ < var_158_9 + var_158_10 and not isNil(var_158_8) then
				local var_158_11 = (arg_155_1.time_ - var_158_9) / var_158_10

				if arg_155_1.var_.actorSpriteComps1148 then
					for iter_158_4, iter_158_5 in pairs(arg_155_1.var_.actorSpriteComps1148:ToTable()) do
						if iter_158_5 then
							if arg_155_1.isInRecall_ then
								local var_158_12 = Mathf.Lerp(iter_158_5.color.r, arg_155_1.hightColor1.r, var_158_11)
								local var_158_13 = Mathf.Lerp(iter_158_5.color.g, arg_155_1.hightColor1.g, var_158_11)
								local var_158_14 = Mathf.Lerp(iter_158_5.color.b, arg_155_1.hightColor1.b, var_158_11)

								iter_158_5.color = Color.New(var_158_12, var_158_13, var_158_14)
							else
								local var_158_15 = Mathf.Lerp(iter_158_5.color.r, 1, var_158_11)

								iter_158_5.color = Color.New(var_158_15, var_158_15, var_158_15)
							end
						end
					end
				end
			end

			if arg_155_1.time_ >= var_158_9 + var_158_10 and arg_155_1.time_ < var_158_9 + var_158_10 + arg_158_0 and not isNil(var_158_8) and arg_155_1.var_.actorSpriteComps1148 then
				for iter_158_6, iter_158_7 in pairs(arg_155_1.var_.actorSpriteComps1148:ToTable()) do
					if iter_158_7 then
						if arg_155_1.isInRecall_ then
							iter_158_7.color = arg_155_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_158_7.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_155_1.var_.actorSpriteComps1148 = nil
			end

			local var_158_16 = 0
			local var_158_17 = 0.6

			if var_158_16 < arg_155_1.time_ and arg_155_1.time_ <= var_158_16 + arg_158_0 then
				arg_155_1.talkMaxDuration = 0
				arg_155_1.dialogCg_.alpha = 1

				arg_155_1.dialog_:SetActive(true)
				SetActive(arg_155_1.leftNameGo_, true)

				local var_158_18 = arg_155_1:FormatText(StoryNameCfg[8].name)

				arg_155_1.leftNameTxt_.text = var_158_18

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_155_1.leftNameTxt_.transform)

				arg_155_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_155_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_155_1:RecordName(arg_155_1.leftNameTxt_.text)
				SetActive(arg_155_1.iconTrs_.gameObject, false)
				arg_155_1.callingController_:SetSelectedState("normal")

				local var_158_19 = arg_155_1:GetWordFromCfg(416071038)
				local var_158_20 = arg_155_1:FormatText(var_158_19.content)

				arg_155_1.text_.text = var_158_20

				LuaForUtil.ClearLinePrefixSymbol(arg_155_1.text_)

				local var_158_21 = 24
				local var_158_22 = utf8.len(var_158_20)
				local var_158_23 = var_158_21 <= 0 and var_158_17 or var_158_17 * (var_158_22 / var_158_21)

				if var_158_23 > 0 and var_158_17 < var_158_23 then
					arg_155_1.talkMaxDuration = var_158_23

					if var_158_23 + var_158_16 > arg_155_1.duration_ then
						arg_155_1.duration_ = var_158_23 + var_158_16
					end
				end

				arg_155_1.text_.text = var_158_20
				arg_155_1.typewritter.percent = 0

				arg_155_1.typewritter:SetDirty()
				arg_155_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_416071", "416071038", "story_v_out_416071.awb") ~= 0 then
					local var_158_24 = manager.audio:GetVoiceLength("story_v_out_416071", "416071038", "story_v_out_416071.awb") / 1000

					if var_158_24 + var_158_16 > arg_155_1.duration_ then
						arg_155_1.duration_ = var_158_24 + var_158_16
					end

					if var_158_19.prefab_name ~= "" and arg_155_1.actors_[var_158_19.prefab_name] ~= nil then
						local var_158_25 = LuaForUtil.PlayVoiceWithCriLipsync(arg_155_1.actors_[var_158_19.prefab_name].transform, "story_v_out_416071", "416071038", "story_v_out_416071.awb")

						arg_155_1:RecordAudio("416071038", var_158_25)
						arg_155_1:RecordAudio("416071038", var_158_25)
					else
						arg_155_1:AudioAction("play", "voice", "story_v_out_416071", "416071038", "story_v_out_416071.awb")
					end

					arg_155_1:RecordHistoryTalkVoice("story_v_out_416071", "416071038", "story_v_out_416071.awb")
				end

				arg_155_1:RecordContent(arg_155_1.text_.text)
			end

			local var_158_26 = math.max(var_158_17, arg_155_1.talkMaxDuration)

			if var_158_16 <= arg_155_1.time_ and arg_155_1.time_ < var_158_16 + var_158_26 then
				arg_155_1.typewritter.percent = (arg_155_1.time_ - var_158_16) / var_158_26

				arg_155_1.typewritter:SetDirty()
			end

			if arg_155_1.time_ >= var_158_16 + var_158_26 and arg_155_1.time_ < var_158_16 + var_158_26 + arg_158_0 then
				arg_155_1.typewritter.percent = 1

				arg_155_1.typewritter:SetDirty()
				arg_155_1:ShowNextGo(true)
			end
		end

		arg_155_1.nodeConfigList_ = {}

		arg_155_1:InitPlayNodeList()
	end,
	Play416071039 = function(arg_159_0, arg_159_1)
		arg_159_1.time_ = 0
		arg_159_1.frameCnt_ = 0
		arg_159_1.state_ = "playing"
		arg_159_1.curTalkId_ = 416071039
		arg_159_1.duration_ = 12.5

		local var_159_0 = {
			zh = 9.566,
			ja = 12.5
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
				arg_159_0:Play416071040(arg_159_1)
			end
		end

		function arg_159_1.onSingleLineUpdate_(arg_162_0)
			local var_162_0 = arg_159_1.actors_["10108"]
			local var_162_1 = 0

			if var_162_1 < arg_159_1.time_ and arg_159_1.time_ <= var_162_1 + arg_162_0 and not isNil(var_162_0) and arg_159_1.var_.actorSpriteComps10108 == nil then
				arg_159_1.var_.actorSpriteComps10108 = var_162_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_162_2 = 0.125

			if var_162_1 <= arg_159_1.time_ and arg_159_1.time_ < var_162_1 + var_162_2 and not isNil(var_162_0) then
				local var_162_3 = (arg_159_1.time_ - var_162_1) / var_162_2

				if arg_159_1.var_.actorSpriteComps10108 then
					for iter_162_0, iter_162_1 in pairs(arg_159_1.var_.actorSpriteComps10108:ToTable()) do
						if iter_162_1 then
							if arg_159_1.isInRecall_ then
								local var_162_4 = Mathf.Lerp(iter_162_1.color.r, arg_159_1.hightColor1.r, var_162_3)
								local var_162_5 = Mathf.Lerp(iter_162_1.color.g, arg_159_1.hightColor1.g, var_162_3)
								local var_162_6 = Mathf.Lerp(iter_162_1.color.b, arg_159_1.hightColor1.b, var_162_3)

								iter_162_1.color = Color.New(var_162_4, var_162_5, var_162_6)
							else
								local var_162_7 = Mathf.Lerp(iter_162_1.color.r, 1, var_162_3)

								iter_162_1.color = Color.New(var_162_7, var_162_7, var_162_7)
							end
						end
					end
				end
			end

			if arg_159_1.time_ >= var_162_1 + var_162_2 and arg_159_1.time_ < var_162_1 + var_162_2 + arg_162_0 and not isNil(var_162_0) and arg_159_1.var_.actorSpriteComps10108 then
				for iter_162_2, iter_162_3 in pairs(arg_159_1.var_.actorSpriteComps10108:ToTable()) do
					if iter_162_3 then
						if arg_159_1.isInRecall_ then
							iter_162_3.color = arg_159_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_162_3.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_159_1.var_.actorSpriteComps10108 = nil
			end

			local var_162_8 = arg_159_1.actors_["1148"]
			local var_162_9 = 0

			if var_162_9 < arg_159_1.time_ and arg_159_1.time_ <= var_162_9 + arg_162_0 and not isNil(var_162_8) and arg_159_1.var_.actorSpriteComps1148 == nil then
				arg_159_1.var_.actorSpriteComps1148 = var_162_8:GetComponentsInChildren(typeof(Image), true)
			end

			local var_162_10 = 0.125

			if var_162_9 <= arg_159_1.time_ and arg_159_1.time_ < var_162_9 + var_162_10 and not isNil(var_162_8) then
				local var_162_11 = (arg_159_1.time_ - var_162_9) / var_162_10

				if arg_159_1.var_.actorSpriteComps1148 then
					for iter_162_4, iter_162_5 in pairs(arg_159_1.var_.actorSpriteComps1148:ToTable()) do
						if iter_162_5 then
							if arg_159_1.isInRecall_ then
								local var_162_12 = Mathf.Lerp(iter_162_5.color.r, arg_159_1.hightColor2.r, var_162_11)
								local var_162_13 = Mathf.Lerp(iter_162_5.color.g, arg_159_1.hightColor2.g, var_162_11)
								local var_162_14 = Mathf.Lerp(iter_162_5.color.b, arg_159_1.hightColor2.b, var_162_11)

								iter_162_5.color = Color.New(var_162_12, var_162_13, var_162_14)
							else
								local var_162_15 = Mathf.Lerp(iter_162_5.color.r, 0.5, var_162_11)

								iter_162_5.color = Color.New(var_162_15, var_162_15, var_162_15)
							end
						end
					end
				end
			end

			if arg_159_1.time_ >= var_162_9 + var_162_10 and arg_159_1.time_ < var_162_9 + var_162_10 + arg_162_0 and not isNil(var_162_8) and arg_159_1.var_.actorSpriteComps1148 then
				for iter_162_6, iter_162_7 in pairs(arg_159_1.var_.actorSpriteComps1148:ToTable()) do
					if iter_162_7 then
						if arg_159_1.isInRecall_ then
							iter_162_7.color = arg_159_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_162_7.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_159_1.var_.actorSpriteComps1148 = nil
			end

			local var_162_16 = 0
			local var_162_17 = 0.675

			if var_162_16 < arg_159_1.time_ and arg_159_1.time_ <= var_162_16 + arg_162_0 then
				arg_159_1.talkMaxDuration = 0
				arg_159_1.dialogCg_.alpha = 1

				arg_159_1.dialog_:SetActive(true)
				SetActive(arg_159_1.leftNameGo_, true)

				local var_162_18 = arg_159_1:FormatText(StoryNameCfg[1083].name)

				arg_159_1.leftNameTxt_.text = var_162_18

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_159_1.leftNameTxt_.transform)

				arg_159_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_159_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_159_1:RecordName(arg_159_1.leftNameTxt_.text)
				SetActive(arg_159_1.iconTrs_.gameObject, false)
				arg_159_1.callingController_:SetSelectedState("normal")

				local var_162_19 = arg_159_1:GetWordFromCfg(416071039)
				local var_162_20 = arg_159_1:FormatText(var_162_19.content)

				arg_159_1.text_.text = var_162_20

				LuaForUtil.ClearLinePrefixSymbol(arg_159_1.text_)

				local var_162_21 = 27
				local var_162_22 = utf8.len(var_162_20)
				local var_162_23 = var_162_21 <= 0 and var_162_17 or var_162_17 * (var_162_22 / var_162_21)

				if var_162_23 > 0 and var_162_17 < var_162_23 then
					arg_159_1.talkMaxDuration = var_162_23

					if var_162_23 + var_162_16 > arg_159_1.duration_ then
						arg_159_1.duration_ = var_162_23 + var_162_16
					end
				end

				arg_159_1.text_.text = var_162_20
				arg_159_1.typewritter.percent = 0

				arg_159_1.typewritter:SetDirty()
				arg_159_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_416071", "416071039", "story_v_out_416071.awb") ~= 0 then
					local var_162_24 = manager.audio:GetVoiceLength("story_v_out_416071", "416071039", "story_v_out_416071.awb") / 1000

					if var_162_24 + var_162_16 > arg_159_1.duration_ then
						arg_159_1.duration_ = var_162_24 + var_162_16
					end

					if var_162_19.prefab_name ~= "" and arg_159_1.actors_[var_162_19.prefab_name] ~= nil then
						local var_162_25 = LuaForUtil.PlayVoiceWithCriLipsync(arg_159_1.actors_[var_162_19.prefab_name].transform, "story_v_out_416071", "416071039", "story_v_out_416071.awb")

						arg_159_1:RecordAudio("416071039", var_162_25)
						arg_159_1:RecordAudio("416071039", var_162_25)
					else
						arg_159_1:AudioAction("play", "voice", "story_v_out_416071", "416071039", "story_v_out_416071.awb")
					end

					arg_159_1:RecordHistoryTalkVoice("story_v_out_416071", "416071039", "story_v_out_416071.awb")
				end

				arg_159_1:RecordContent(arg_159_1.text_.text)
			end

			local var_162_26 = math.max(var_162_17, arg_159_1.talkMaxDuration)

			if var_162_16 <= arg_159_1.time_ and arg_159_1.time_ < var_162_16 + var_162_26 then
				arg_159_1.typewritter.percent = (arg_159_1.time_ - var_162_16) / var_162_26

				arg_159_1.typewritter:SetDirty()
			end

			if arg_159_1.time_ >= var_162_16 + var_162_26 and arg_159_1.time_ < var_162_16 + var_162_26 + arg_162_0 then
				arg_159_1.typewritter.percent = 1

				arg_159_1.typewritter:SetDirty()
				arg_159_1:ShowNextGo(true)
			end
		end

		arg_159_1.nodeConfigList_ = {}

		arg_159_1:InitPlayNodeList()
	end,
	Play416071040 = function(arg_163_0, arg_163_1)
		arg_163_1.time_ = 0
		arg_163_1.frameCnt_ = 0
		arg_163_1.state_ = "playing"
		arg_163_1.curTalkId_ = 416071040
		arg_163_1.duration_ = 13.2

		local var_163_0 = {
			zh = 7.833,
			ja = 13.2
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
				arg_163_0:Play416071041(arg_163_1)
			end
		end

		function arg_163_1.onSingleLineUpdate_(arg_166_0)
			local var_166_0 = arg_163_1.actors_["10108"]
			local var_166_1 = 0

			if var_166_1 < arg_163_1.time_ and arg_163_1.time_ <= var_166_1 + arg_166_0 and not isNil(var_166_0) and arg_163_1.var_.actorSpriteComps10108 == nil then
				arg_163_1.var_.actorSpriteComps10108 = var_166_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_166_2 = 0.125

			if var_166_1 <= arg_163_1.time_ and arg_163_1.time_ < var_166_1 + var_166_2 and not isNil(var_166_0) then
				local var_166_3 = (arg_163_1.time_ - var_166_1) / var_166_2

				if arg_163_1.var_.actorSpriteComps10108 then
					for iter_166_0, iter_166_1 in pairs(arg_163_1.var_.actorSpriteComps10108:ToTable()) do
						if iter_166_1 then
							if arg_163_1.isInRecall_ then
								local var_166_4 = Mathf.Lerp(iter_166_1.color.r, arg_163_1.hightColor2.r, var_166_3)
								local var_166_5 = Mathf.Lerp(iter_166_1.color.g, arg_163_1.hightColor2.g, var_166_3)
								local var_166_6 = Mathf.Lerp(iter_166_1.color.b, arg_163_1.hightColor2.b, var_166_3)

								iter_166_1.color = Color.New(var_166_4, var_166_5, var_166_6)
							else
								local var_166_7 = Mathf.Lerp(iter_166_1.color.r, 0.5, var_166_3)

								iter_166_1.color = Color.New(var_166_7, var_166_7, var_166_7)
							end
						end
					end
				end
			end

			if arg_163_1.time_ >= var_166_1 + var_166_2 and arg_163_1.time_ < var_166_1 + var_166_2 + arg_166_0 and not isNil(var_166_0) and arg_163_1.var_.actorSpriteComps10108 then
				for iter_166_2, iter_166_3 in pairs(arg_163_1.var_.actorSpriteComps10108:ToTable()) do
					if iter_166_3 then
						if arg_163_1.isInRecall_ then
							iter_166_3.color = arg_163_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_166_3.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_163_1.var_.actorSpriteComps10108 = nil
			end

			local var_166_8 = arg_163_1.actors_["1148"]
			local var_166_9 = 0

			if var_166_9 < arg_163_1.time_ and arg_163_1.time_ <= var_166_9 + arg_166_0 and not isNil(var_166_8) and arg_163_1.var_.actorSpriteComps1148 == nil then
				arg_163_1.var_.actorSpriteComps1148 = var_166_8:GetComponentsInChildren(typeof(Image), true)
			end

			local var_166_10 = 0.125

			if var_166_9 <= arg_163_1.time_ and arg_163_1.time_ < var_166_9 + var_166_10 and not isNil(var_166_8) then
				local var_166_11 = (arg_163_1.time_ - var_166_9) / var_166_10

				if arg_163_1.var_.actorSpriteComps1148 then
					for iter_166_4, iter_166_5 in pairs(arg_163_1.var_.actorSpriteComps1148:ToTable()) do
						if iter_166_5 then
							if arg_163_1.isInRecall_ then
								local var_166_12 = Mathf.Lerp(iter_166_5.color.r, arg_163_1.hightColor1.r, var_166_11)
								local var_166_13 = Mathf.Lerp(iter_166_5.color.g, arg_163_1.hightColor1.g, var_166_11)
								local var_166_14 = Mathf.Lerp(iter_166_5.color.b, arg_163_1.hightColor1.b, var_166_11)

								iter_166_5.color = Color.New(var_166_12, var_166_13, var_166_14)
							else
								local var_166_15 = Mathf.Lerp(iter_166_5.color.r, 1, var_166_11)

								iter_166_5.color = Color.New(var_166_15, var_166_15, var_166_15)
							end
						end
					end
				end
			end

			if arg_163_1.time_ >= var_166_9 + var_166_10 and arg_163_1.time_ < var_166_9 + var_166_10 + arg_166_0 and not isNil(var_166_8) and arg_163_1.var_.actorSpriteComps1148 then
				for iter_166_6, iter_166_7 in pairs(arg_163_1.var_.actorSpriteComps1148:ToTable()) do
					if iter_166_7 then
						if arg_163_1.isInRecall_ then
							iter_166_7.color = arg_163_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_166_7.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_163_1.var_.actorSpriteComps1148 = nil
			end

			local var_166_16 = arg_163_1.actors_["1148"].transform
			local var_166_17 = 0

			if var_166_17 < arg_163_1.time_ and arg_163_1.time_ <= var_166_17 + arg_166_0 then
				arg_163_1.var_.moveOldPos1148 = var_166_16.localPosition
				var_166_16.localScale = Vector3.New(1, 1, 1)

				arg_163_1:CheckSpriteTmpPos("1148", 4)

				local var_166_18 = var_166_16.childCount

				for iter_166_8 = 0, var_166_18 - 1 do
					local var_166_19 = var_166_16:GetChild(iter_166_8)

					if var_166_19.name == "split_1_1" or not string.find(var_166_19.name, "split") then
						var_166_19.gameObject:SetActive(true)
					else
						var_166_19.gameObject:SetActive(false)
					end
				end
			end

			local var_166_20 = 0.001

			if var_166_17 <= arg_163_1.time_ and arg_163_1.time_ < var_166_17 + var_166_20 then
				local var_166_21 = (arg_163_1.time_ - var_166_17) / var_166_20
				local var_166_22 = Vector3.New(390, -429, -180)

				var_166_16.localPosition = Vector3.Lerp(arg_163_1.var_.moveOldPos1148, var_166_22, var_166_21)
			end

			if arg_163_1.time_ >= var_166_17 + var_166_20 and arg_163_1.time_ < var_166_17 + var_166_20 + arg_166_0 then
				var_166_16.localPosition = Vector3.New(390, -429, -180)
			end

			local var_166_23 = 0
			local var_166_24 = 0.775

			if var_166_23 < arg_163_1.time_ and arg_163_1.time_ <= var_166_23 + arg_166_0 then
				arg_163_1.talkMaxDuration = 0
				arg_163_1.dialogCg_.alpha = 1

				arg_163_1.dialog_:SetActive(true)
				SetActive(arg_163_1.leftNameGo_, true)

				local var_166_25 = arg_163_1:FormatText(StoryNameCfg[8].name)

				arg_163_1.leftNameTxt_.text = var_166_25

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_163_1.leftNameTxt_.transform)

				arg_163_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_163_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_163_1:RecordName(arg_163_1.leftNameTxt_.text)
				SetActive(arg_163_1.iconTrs_.gameObject, false)
				arg_163_1.callingController_:SetSelectedState("normal")

				local var_166_26 = arg_163_1:GetWordFromCfg(416071040)
				local var_166_27 = arg_163_1:FormatText(var_166_26.content)

				arg_163_1.text_.text = var_166_27

				LuaForUtil.ClearLinePrefixSymbol(arg_163_1.text_)

				local var_166_28 = 31
				local var_166_29 = utf8.len(var_166_27)
				local var_166_30 = var_166_28 <= 0 and var_166_24 or var_166_24 * (var_166_29 / var_166_28)

				if var_166_30 > 0 and var_166_24 < var_166_30 then
					arg_163_1.talkMaxDuration = var_166_30

					if var_166_30 + var_166_23 > arg_163_1.duration_ then
						arg_163_1.duration_ = var_166_30 + var_166_23
					end
				end

				arg_163_1.text_.text = var_166_27
				arg_163_1.typewritter.percent = 0

				arg_163_1.typewritter:SetDirty()
				arg_163_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_416071", "416071040", "story_v_out_416071.awb") ~= 0 then
					local var_166_31 = manager.audio:GetVoiceLength("story_v_out_416071", "416071040", "story_v_out_416071.awb") / 1000

					if var_166_31 + var_166_23 > arg_163_1.duration_ then
						arg_163_1.duration_ = var_166_31 + var_166_23
					end

					if var_166_26.prefab_name ~= "" and arg_163_1.actors_[var_166_26.prefab_name] ~= nil then
						local var_166_32 = LuaForUtil.PlayVoiceWithCriLipsync(arg_163_1.actors_[var_166_26.prefab_name].transform, "story_v_out_416071", "416071040", "story_v_out_416071.awb")

						arg_163_1:RecordAudio("416071040", var_166_32)
						arg_163_1:RecordAudio("416071040", var_166_32)
					else
						arg_163_1:AudioAction("play", "voice", "story_v_out_416071", "416071040", "story_v_out_416071.awb")
					end

					arg_163_1:RecordHistoryTalkVoice("story_v_out_416071", "416071040", "story_v_out_416071.awb")
				end

				arg_163_1:RecordContent(arg_163_1.text_.text)
			end

			local var_166_33 = math.max(var_166_24, arg_163_1.talkMaxDuration)

			if var_166_23 <= arg_163_1.time_ and arg_163_1.time_ < var_166_23 + var_166_33 then
				arg_163_1.typewritter.percent = (arg_163_1.time_ - var_166_23) / var_166_33

				arg_163_1.typewritter:SetDirty()
			end

			if arg_163_1.time_ >= var_166_23 + var_166_33 and arg_163_1.time_ < var_166_23 + var_166_33 + arg_166_0 then
				arg_163_1.typewritter.percent = 1

				arg_163_1.typewritter:SetDirty()
				arg_163_1:ShowNextGo(true)
			end
		end

		arg_163_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1148",
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
	Play416071041 = function(arg_167_0, arg_167_1)
		arg_167_1.time_ = 0
		arg_167_1.frameCnt_ = 0
		arg_167_1.state_ = "playing"
		arg_167_1.curTalkId_ = 416071041
		arg_167_1.duration_ = 8.23

		local var_167_0 = {
			zh = 6.566,
			ja = 8.233
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
				arg_167_0:Play416071042(arg_167_1)
			end
		end

		function arg_167_1.onSingleLineUpdate_(arg_170_0)
			local var_170_0 = 0
			local var_170_1 = 0.725

			if var_170_0 < arg_167_1.time_ and arg_167_1.time_ <= var_170_0 + arg_170_0 then
				arg_167_1.talkMaxDuration = 0
				arg_167_1.dialogCg_.alpha = 1

				arg_167_1.dialog_:SetActive(true)
				SetActive(arg_167_1.leftNameGo_, true)

				local var_170_2 = arg_167_1:FormatText(StoryNameCfg[8].name)

				arg_167_1.leftNameTxt_.text = var_170_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_167_1.leftNameTxt_.transform)

				arg_167_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_167_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_167_1:RecordName(arg_167_1.leftNameTxt_.text)
				SetActive(arg_167_1.iconTrs_.gameObject, false)
				arg_167_1.callingController_:SetSelectedState("normal")

				local var_170_3 = arg_167_1:GetWordFromCfg(416071041)
				local var_170_4 = arg_167_1:FormatText(var_170_3.content)

				arg_167_1.text_.text = var_170_4

				LuaForUtil.ClearLinePrefixSymbol(arg_167_1.text_)

				local var_170_5 = 29
				local var_170_6 = utf8.len(var_170_4)
				local var_170_7 = var_170_5 <= 0 and var_170_1 or var_170_1 * (var_170_6 / var_170_5)

				if var_170_7 > 0 and var_170_1 < var_170_7 then
					arg_167_1.talkMaxDuration = var_170_7

					if var_170_7 + var_170_0 > arg_167_1.duration_ then
						arg_167_1.duration_ = var_170_7 + var_170_0
					end
				end

				arg_167_1.text_.text = var_170_4
				arg_167_1.typewritter.percent = 0

				arg_167_1.typewritter:SetDirty()
				arg_167_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_416071", "416071041", "story_v_out_416071.awb") ~= 0 then
					local var_170_8 = manager.audio:GetVoiceLength("story_v_out_416071", "416071041", "story_v_out_416071.awb") / 1000

					if var_170_8 + var_170_0 > arg_167_1.duration_ then
						arg_167_1.duration_ = var_170_8 + var_170_0
					end

					if var_170_3.prefab_name ~= "" and arg_167_1.actors_[var_170_3.prefab_name] ~= nil then
						local var_170_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_167_1.actors_[var_170_3.prefab_name].transform, "story_v_out_416071", "416071041", "story_v_out_416071.awb")

						arg_167_1:RecordAudio("416071041", var_170_9)
						arg_167_1:RecordAudio("416071041", var_170_9)
					else
						arg_167_1:AudioAction("play", "voice", "story_v_out_416071", "416071041", "story_v_out_416071.awb")
					end

					arg_167_1:RecordHistoryTalkVoice("story_v_out_416071", "416071041", "story_v_out_416071.awb")
				end

				arg_167_1:RecordContent(arg_167_1.text_.text)
			end

			local var_170_10 = math.max(var_170_1, arg_167_1.talkMaxDuration)

			if var_170_0 <= arg_167_1.time_ and arg_167_1.time_ < var_170_0 + var_170_10 then
				arg_167_1.typewritter.percent = (arg_167_1.time_ - var_170_0) / var_170_10

				arg_167_1.typewritter:SetDirty()
			end

			if arg_167_1.time_ >= var_170_0 + var_170_10 and arg_167_1.time_ < var_170_0 + var_170_10 + arg_170_0 then
				arg_167_1.typewritter.percent = 1

				arg_167_1.typewritter:SetDirty()
				arg_167_1:ShowNextGo(true)
			end
		end

		arg_167_1.nodeConfigList_ = {}

		arg_167_1:InitPlayNodeList()
	end,
	Play416071042 = function(arg_171_0, arg_171_1)
		arg_171_1.time_ = 0
		arg_171_1.frameCnt_ = 0
		arg_171_1.state_ = "playing"
		arg_171_1.curTalkId_ = 416071042
		arg_171_1.duration_ = 12.1

		local var_171_0 = {
			zh = 6.833,
			ja = 12.1
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
				arg_171_0:Play416071043(arg_171_1)
			end
		end

		function arg_171_1.onSingleLineUpdate_(arg_174_0)
			local var_174_0 = arg_171_1.actors_["10108"]
			local var_174_1 = 0

			if var_174_1 < arg_171_1.time_ and arg_171_1.time_ <= var_174_1 + arg_174_0 and not isNil(var_174_0) and arg_171_1.var_.actorSpriteComps10108 == nil then
				arg_171_1.var_.actorSpriteComps10108 = var_174_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_174_2 = 0.125

			if var_174_1 <= arg_171_1.time_ and arg_171_1.time_ < var_174_1 + var_174_2 and not isNil(var_174_0) then
				local var_174_3 = (arg_171_1.time_ - var_174_1) / var_174_2

				if arg_171_1.var_.actorSpriteComps10108 then
					for iter_174_0, iter_174_1 in pairs(arg_171_1.var_.actorSpriteComps10108:ToTable()) do
						if iter_174_1 then
							if arg_171_1.isInRecall_ then
								local var_174_4 = Mathf.Lerp(iter_174_1.color.r, arg_171_1.hightColor1.r, var_174_3)
								local var_174_5 = Mathf.Lerp(iter_174_1.color.g, arg_171_1.hightColor1.g, var_174_3)
								local var_174_6 = Mathf.Lerp(iter_174_1.color.b, arg_171_1.hightColor1.b, var_174_3)

								iter_174_1.color = Color.New(var_174_4, var_174_5, var_174_6)
							else
								local var_174_7 = Mathf.Lerp(iter_174_1.color.r, 1, var_174_3)

								iter_174_1.color = Color.New(var_174_7, var_174_7, var_174_7)
							end
						end
					end
				end
			end

			if arg_171_1.time_ >= var_174_1 + var_174_2 and arg_171_1.time_ < var_174_1 + var_174_2 + arg_174_0 and not isNil(var_174_0) and arg_171_1.var_.actorSpriteComps10108 then
				for iter_174_2, iter_174_3 in pairs(arg_171_1.var_.actorSpriteComps10108:ToTable()) do
					if iter_174_3 then
						if arg_171_1.isInRecall_ then
							iter_174_3.color = arg_171_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_174_3.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_171_1.var_.actorSpriteComps10108 = nil
			end

			local var_174_8 = arg_171_1.actors_["1148"]
			local var_174_9 = 0

			if var_174_9 < arg_171_1.time_ and arg_171_1.time_ <= var_174_9 + arg_174_0 and not isNil(var_174_8) and arg_171_1.var_.actorSpriteComps1148 == nil then
				arg_171_1.var_.actorSpriteComps1148 = var_174_8:GetComponentsInChildren(typeof(Image), true)
			end

			local var_174_10 = 0.125

			if var_174_9 <= arg_171_1.time_ and arg_171_1.time_ < var_174_9 + var_174_10 and not isNil(var_174_8) then
				local var_174_11 = (arg_171_1.time_ - var_174_9) / var_174_10

				if arg_171_1.var_.actorSpriteComps1148 then
					for iter_174_4, iter_174_5 in pairs(arg_171_1.var_.actorSpriteComps1148:ToTable()) do
						if iter_174_5 then
							if arg_171_1.isInRecall_ then
								local var_174_12 = Mathf.Lerp(iter_174_5.color.r, arg_171_1.hightColor2.r, var_174_11)
								local var_174_13 = Mathf.Lerp(iter_174_5.color.g, arg_171_1.hightColor2.g, var_174_11)
								local var_174_14 = Mathf.Lerp(iter_174_5.color.b, arg_171_1.hightColor2.b, var_174_11)

								iter_174_5.color = Color.New(var_174_12, var_174_13, var_174_14)
							else
								local var_174_15 = Mathf.Lerp(iter_174_5.color.r, 0.5, var_174_11)

								iter_174_5.color = Color.New(var_174_15, var_174_15, var_174_15)
							end
						end
					end
				end
			end

			if arg_171_1.time_ >= var_174_9 + var_174_10 and arg_171_1.time_ < var_174_9 + var_174_10 + arg_174_0 and not isNil(var_174_8) and arg_171_1.var_.actorSpriteComps1148 then
				for iter_174_6, iter_174_7 in pairs(arg_171_1.var_.actorSpriteComps1148:ToTable()) do
					if iter_174_7 then
						if arg_171_1.isInRecall_ then
							iter_174_7.color = arg_171_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_174_7.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_171_1.var_.actorSpriteComps1148 = nil
			end

			local var_174_16 = 0
			local var_174_17 = 0.625

			if var_174_16 < arg_171_1.time_ and arg_171_1.time_ <= var_174_16 + arg_174_0 then
				arg_171_1.talkMaxDuration = 0
				arg_171_1.dialogCg_.alpha = 1

				arg_171_1.dialog_:SetActive(true)
				SetActive(arg_171_1.leftNameGo_, true)

				local var_174_18 = arg_171_1:FormatText(StoryNameCfg[1083].name)

				arg_171_1.leftNameTxt_.text = var_174_18

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_171_1.leftNameTxt_.transform)

				arg_171_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_171_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_171_1:RecordName(arg_171_1.leftNameTxt_.text)
				SetActive(arg_171_1.iconTrs_.gameObject, false)
				arg_171_1.callingController_:SetSelectedState("normal")

				local var_174_19 = arg_171_1:GetWordFromCfg(416071042)
				local var_174_20 = arg_171_1:FormatText(var_174_19.content)

				arg_171_1.text_.text = var_174_20

				LuaForUtil.ClearLinePrefixSymbol(arg_171_1.text_)

				local var_174_21 = 25
				local var_174_22 = utf8.len(var_174_20)
				local var_174_23 = var_174_21 <= 0 and var_174_17 or var_174_17 * (var_174_22 / var_174_21)

				if var_174_23 > 0 and var_174_17 < var_174_23 then
					arg_171_1.talkMaxDuration = var_174_23

					if var_174_23 + var_174_16 > arg_171_1.duration_ then
						arg_171_1.duration_ = var_174_23 + var_174_16
					end
				end

				arg_171_1.text_.text = var_174_20
				arg_171_1.typewritter.percent = 0

				arg_171_1.typewritter:SetDirty()
				arg_171_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_416071", "416071042", "story_v_out_416071.awb") ~= 0 then
					local var_174_24 = manager.audio:GetVoiceLength("story_v_out_416071", "416071042", "story_v_out_416071.awb") / 1000

					if var_174_24 + var_174_16 > arg_171_1.duration_ then
						arg_171_1.duration_ = var_174_24 + var_174_16
					end

					if var_174_19.prefab_name ~= "" and arg_171_1.actors_[var_174_19.prefab_name] ~= nil then
						local var_174_25 = LuaForUtil.PlayVoiceWithCriLipsync(arg_171_1.actors_[var_174_19.prefab_name].transform, "story_v_out_416071", "416071042", "story_v_out_416071.awb")

						arg_171_1:RecordAudio("416071042", var_174_25)
						arg_171_1:RecordAudio("416071042", var_174_25)
					else
						arg_171_1:AudioAction("play", "voice", "story_v_out_416071", "416071042", "story_v_out_416071.awb")
					end

					arg_171_1:RecordHistoryTalkVoice("story_v_out_416071", "416071042", "story_v_out_416071.awb")
				end

				arg_171_1:RecordContent(arg_171_1.text_.text)
			end

			local var_174_26 = math.max(var_174_17, arg_171_1.talkMaxDuration)

			if var_174_16 <= arg_171_1.time_ and arg_171_1.time_ < var_174_16 + var_174_26 then
				arg_171_1.typewritter.percent = (arg_171_1.time_ - var_174_16) / var_174_26

				arg_171_1.typewritter:SetDirty()
			end

			if arg_171_1.time_ >= var_174_16 + var_174_26 and arg_171_1.time_ < var_174_16 + var_174_26 + arg_174_0 then
				arg_171_1.typewritter.percent = 1

				arg_171_1.typewritter:SetDirty()
				arg_171_1:ShowNextGo(true)
			end
		end

		arg_171_1.nodeConfigList_ = {}

		arg_171_1:InitPlayNodeList()
	end,
	Play416071043 = function(arg_175_0, arg_175_1)
		arg_175_1.time_ = 0
		arg_175_1.frameCnt_ = 0
		arg_175_1.state_ = "playing"
		arg_175_1.curTalkId_ = 416071043
		arg_175_1.duration_ = 6.43

		local var_175_0 = {
			zh = 5.833,
			ja = 6.433
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
				arg_175_0:Play416071044(arg_175_1)
			end
		end

		function arg_175_1.onSingleLineUpdate_(arg_178_0)
			local var_178_0 = arg_175_1.actors_["10108"]
			local var_178_1 = 0

			if var_178_1 < arg_175_1.time_ and arg_175_1.time_ <= var_178_1 + arg_178_0 and not isNil(var_178_0) and arg_175_1.var_.actorSpriteComps10108 == nil then
				arg_175_1.var_.actorSpriteComps10108 = var_178_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_178_2 = 0.125

			if var_178_1 <= arg_175_1.time_ and arg_175_1.time_ < var_178_1 + var_178_2 and not isNil(var_178_0) then
				local var_178_3 = (arg_175_1.time_ - var_178_1) / var_178_2

				if arg_175_1.var_.actorSpriteComps10108 then
					for iter_178_0, iter_178_1 in pairs(arg_175_1.var_.actorSpriteComps10108:ToTable()) do
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

			if arg_175_1.time_ >= var_178_1 + var_178_2 and arg_175_1.time_ < var_178_1 + var_178_2 + arg_178_0 and not isNil(var_178_0) and arg_175_1.var_.actorSpriteComps10108 then
				for iter_178_2, iter_178_3 in pairs(arg_175_1.var_.actorSpriteComps10108:ToTable()) do
					if iter_178_3 then
						if arg_175_1.isInRecall_ then
							iter_178_3.color = arg_175_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_178_3.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_175_1.var_.actorSpriteComps10108 = nil
			end

			local var_178_8 = arg_175_1.actors_["1148"]
			local var_178_9 = 0

			if var_178_9 < arg_175_1.time_ and arg_175_1.time_ <= var_178_9 + arg_178_0 and not isNil(var_178_8) and arg_175_1.var_.actorSpriteComps1148 == nil then
				arg_175_1.var_.actorSpriteComps1148 = var_178_8:GetComponentsInChildren(typeof(Image), true)
			end

			local var_178_10 = 0.125

			if var_178_9 <= arg_175_1.time_ and arg_175_1.time_ < var_178_9 + var_178_10 and not isNil(var_178_8) then
				local var_178_11 = (arg_175_1.time_ - var_178_9) / var_178_10

				if arg_175_1.var_.actorSpriteComps1148 then
					for iter_178_4, iter_178_5 in pairs(arg_175_1.var_.actorSpriteComps1148:ToTable()) do
						if iter_178_5 then
							if arg_175_1.isInRecall_ then
								local var_178_12 = Mathf.Lerp(iter_178_5.color.r, arg_175_1.hightColor1.r, var_178_11)
								local var_178_13 = Mathf.Lerp(iter_178_5.color.g, arg_175_1.hightColor1.g, var_178_11)
								local var_178_14 = Mathf.Lerp(iter_178_5.color.b, arg_175_1.hightColor1.b, var_178_11)

								iter_178_5.color = Color.New(var_178_12, var_178_13, var_178_14)
							else
								local var_178_15 = Mathf.Lerp(iter_178_5.color.r, 1, var_178_11)

								iter_178_5.color = Color.New(var_178_15, var_178_15, var_178_15)
							end
						end
					end
				end
			end

			if arg_175_1.time_ >= var_178_9 + var_178_10 and arg_175_1.time_ < var_178_9 + var_178_10 + arg_178_0 and not isNil(var_178_8) and arg_175_1.var_.actorSpriteComps1148 then
				for iter_178_6, iter_178_7 in pairs(arg_175_1.var_.actorSpriteComps1148:ToTable()) do
					if iter_178_7 then
						if arg_175_1.isInRecall_ then
							iter_178_7.color = arg_175_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_178_7.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_175_1.var_.actorSpriteComps1148 = nil
			end

			local var_178_16 = 0
			local var_178_17 = 0.5

			if var_178_16 < arg_175_1.time_ and arg_175_1.time_ <= var_178_16 + arg_178_0 then
				arg_175_1.talkMaxDuration = 0
				arg_175_1.dialogCg_.alpha = 1

				arg_175_1.dialog_:SetActive(true)
				SetActive(arg_175_1.leftNameGo_, true)

				local var_178_18 = arg_175_1:FormatText(StoryNameCfg[8].name)

				arg_175_1.leftNameTxt_.text = var_178_18

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_175_1.leftNameTxt_.transform)

				arg_175_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_175_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_175_1:RecordName(arg_175_1.leftNameTxt_.text)
				SetActive(arg_175_1.iconTrs_.gameObject, false)
				arg_175_1.callingController_:SetSelectedState("normal")

				local var_178_19 = arg_175_1:GetWordFromCfg(416071043)
				local var_178_20 = arg_175_1:FormatText(var_178_19.content)

				arg_175_1.text_.text = var_178_20

				LuaForUtil.ClearLinePrefixSymbol(arg_175_1.text_)

				local var_178_21 = 20
				local var_178_22 = utf8.len(var_178_20)
				local var_178_23 = var_178_21 <= 0 and var_178_17 or var_178_17 * (var_178_22 / var_178_21)

				if var_178_23 > 0 and var_178_17 < var_178_23 then
					arg_175_1.talkMaxDuration = var_178_23

					if var_178_23 + var_178_16 > arg_175_1.duration_ then
						arg_175_1.duration_ = var_178_23 + var_178_16
					end
				end

				arg_175_1.text_.text = var_178_20
				arg_175_1.typewritter.percent = 0

				arg_175_1.typewritter:SetDirty()
				arg_175_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_416071", "416071043", "story_v_out_416071.awb") ~= 0 then
					local var_178_24 = manager.audio:GetVoiceLength("story_v_out_416071", "416071043", "story_v_out_416071.awb") / 1000

					if var_178_24 + var_178_16 > arg_175_1.duration_ then
						arg_175_1.duration_ = var_178_24 + var_178_16
					end

					if var_178_19.prefab_name ~= "" and arg_175_1.actors_[var_178_19.prefab_name] ~= nil then
						local var_178_25 = LuaForUtil.PlayVoiceWithCriLipsync(arg_175_1.actors_[var_178_19.prefab_name].transform, "story_v_out_416071", "416071043", "story_v_out_416071.awb")

						arg_175_1:RecordAudio("416071043", var_178_25)
						arg_175_1:RecordAudio("416071043", var_178_25)
					else
						arg_175_1:AudioAction("play", "voice", "story_v_out_416071", "416071043", "story_v_out_416071.awb")
					end

					arg_175_1:RecordHistoryTalkVoice("story_v_out_416071", "416071043", "story_v_out_416071.awb")
				end

				arg_175_1:RecordContent(arg_175_1.text_.text)
			end

			local var_178_26 = math.max(var_178_17, arg_175_1.talkMaxDuration)

			if var_178_16 <= arg_175_1.time_ and arg_175_1.time_ < var_178_16 + var_178_26 then
				arg_175_1.typewritter.percent = (arg_175_1.time_ - var_178_16) / var_178_26

				arg_175_1.typewritter:SetDirty()
			end

			if arg_175_1.time_ >= var_178_16 + var_178_26 and arg_175_1.time_ < var_178_16 + var_178_26 + arg_178_0 then
				arg_175_1.typewritter.percent = 1

				arg_175_1.typewritter:SetDirty()
				arg_175_1:ShowNextGo(true)
			end
		end

		arg_175_1.nodeConfigList_ = {}

		arg_175_1:InitPlayNodeList()
	end,
	Play416071044 = function(arg_179_0, arg_179_1)
		arg_179_1.time_ = 0
		arg_179_1.frameCnt_ = 0
		arg_179_1.state_ = "playing"
		arg_179_1.curTalkId_ = 416071044
		arg_179_1.duration_ = 7.97

		local var_179_0 = {
			zh = 4.233,
			ja = 7.966
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
				arg_179_0:Play416071045(arg_179_1)
			end
		end

		function arg_179_1.onSingleLineUpdate_(arg_182_0)
			local var_182_0 = 0
			local var_182_1 = 0.55

			if var_182_0 < arg_179_1.time_ and arg_179_1.time_ <= var_182_0 + arg_182_0 then
				arg_179_1.talkMaxDuration = 0
				arg_179_1.dialogCg_.alpha = 1

				arg_179_1.dialog_:SetActive(true)
				SetActive(arg_179_1.leftNameGo_, true)

				local var_182_2 = arg_179_1:FormatText(StoryNameCfg[8].name)

				arg_179_1.leftNameTxt_.text = var_182_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_179_1.leftNameTxt_.transform)

				arg_179_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_179_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_179_1:RecordName(arg_179_1.leftNameTxt_.text)
				SetActive(arg_179_1.iconTrs_.gameObject, false)
				arg_179_1.callingController_:SetSelectedState("normal")

				local var_182_3 = arg_179_1:GetWordFromCfg(416071044)
				local var_182_4 = arg_179_1:FormatText(var_182_3.content)

				arg_179_1.text_.text = var_182_4

				LuaForUtil.ClearLinePrefixSymbol(arg_179_1.text_)

				local var_182_5 = 22
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

				if manager.audio:GetVoiceLength("story_v_out_416071", "416071044", "story_v_out_416071.awb") ~= 0 then
					local var_182_8 = manager.audio:GetVoiceLength("story_v_out_416071", "416071044", "story_v_out_416071.awb") / 1000

					if var_182_8 + var_182_0 > arg_179_1.duration_ then
						arg_179_1.duration_ = var_182_8 + var_182_0
					end

					if var_182_3.prefab_name ~= "" and arg_179_1.actors_[var_182_3.prefab_name] ~= nil then
						local var_182_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_179_1.actors_[var_182_3.prefab_name].transform, "story_v_out_416071", "416071044", "story_v_out_416071.awb")

						arg_179_1:RecordAudio("416071044", var_182_9)
						arg_179_1:RecordAudio("416071044", var_182_9)
					else
						arg_179_1:AudioAction("play", "voice", "story_v_out_416071", "416071044", "story_v_out_416071.awb")
					end

					arg_179_1:RecordHistoryTalkVoice("story_v_out_416071", "416071044", "story_v_out_416071.awb")
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
	Play416071045 = function(arg_183_0, arg_183_1)
		arg_183_1.time_ = 0
		arg_183_1.frameCnt_ = 0
		arg_183_1.state_ = "playing"
		arg_183_1.curTalkId_ = 416071045
		arg_183_1.duration_ = 11.2

		local var_183_0 = {
			zh = 8.033,
			ja = 11.2
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
				arg_183_0:Play416071046(arg_183_1)
			end
		end

		function arg_183_1.onSingleLineUpdate_(arg_186_0)
			local var_186_0 = 4

			if var_186_0 < arg_183_1.time_ and arg_183_1.time_ <= var_186_0 + arg_186_0 then
				arg_183_1.allBtn_.enabled = false
			end

			local var_186_1 = 0.3

			if arg_183_1.time_ >= var_186_0 + var_186_1 and arg_183_1.time_ < var_186_0 + var_186_1 + arg_186_0 then
				arg_183_1.allBtn_.enabled = true
			end

			local var_186_2 = 2

			if var_186_2 < arg_183_1.time_ and arg_183_1.time_ <= var_186_2 + arg_186_0 then
				local var_186_3 = manager.ui.mainCamera.transform.localPosition
				local var_186_4 = Vector3.New(0, 0, 10) + Vector3.New(var_186_3.x, var_186_3.y, 0)
				local var_186_5 = arg_183_1.bgs_.ST0106

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
					if iter_186_0 ~= "ST0106" then
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

			local var_186_27 = arg_183_1.actors_["1148"]
			local var_186_28 = 3.73333333333333

			if var_186_28 < arg_183_1.time_ and arg_183_1.time_ <= var_186_28 + arg_186_0 and not isNil(var_186_27) and arg_183_1.var_.actorSpriteComps1148 == nil then
				arg_183_1.var_.actorSpriteComps1148 = var_186_27:GetComponentsInChildren(typeof(Image), true)
			end

			local var_186_29 = 0.125

			if var_186_28 <= arg_183_1.time_ and arg_183_1.time_ < var_186_28 + var_186_29 and not isNil(var_186_27) then
				local var_186_30 = (arg_183_1.time_ - var_186_28) / var_186_29

				if arg_183_1.var_.actorSpriteComps1148 then
					for iter_186_2, iter_186_3 in pairs(arg_183_1.var_.actorSpriteComps1148:ToTable()) do
						if iter_186_3 then
							if arg_183_1.isInRecall_ then
								local var_186_31 = Mathf.Lerp(iter_186_3.color.r, arg_183_1.hightColor1.r, var_186_30)
								local var_186_32 = Mathf.Lerp(iter_186_3.color.g, arg_183_1.hightColor1.g, var_186_30)
								local var_186_33 = Mathf.Lerp(iter_186_3.color.b, arg_183_1.hightColor1.b, var_186_30)

								iter_186_3.color = Color.New(var_186_31, var_186_32, var_186_33)
							else
								local var_186_34 = Mathf.Lerp(iter_186_3.color.r, 1, var_186_30)

								iter_186_3.color = Color.New(var_186_34, var_186_34, var_186_34)
							end
						end
					end
				end
			end

			if arg_183_1.time_ >= var_186_28 + var_186_29 and arg_183_1.time_ < var_186_28 + var_186_29 + arg_186_0 and not isNil(var_186_27) and arg_183_1.var_.actorSpriteComps1148 then
				for iter_186_4, iter_186_5 in pairs(arg_183_1.var_.actorSpriteComps1148:ToTable()) do
					if iter_186_5 then
						if arg_183_1.isInRecall_ then
							iter_186_5.color = arg_183_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_186_5.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_183_1.var_.actorSpriteComps1148 = nil
			end

			local var_186_35 = arg_183_1.actors_["1148"].transform
			local var_186_36 = 1.966

			if var_186_36 < arg_183_1.time_ and arg_183_1.time_ <= var_186_36 + arg_186_0 then
				arg_183_1.var_.moveOldPos1148 = var_186_35.localPosition
				var_186_35.localScale = Vector3.New(1, 1, 1)

				arg_183_1:CheckSpriteTmpPos("1148", 7)

				local var_186_37 = var_186_35.childCount

				for iter_186_6 = 0, var_186_37 - 1 do
					local var_186_38 = var_186_35:GetChild(iter_186_6)

					if var_186_38.name == "" or not string.find(var_186_38.name, "split") then
						var_186_38.gameObject:SetActive(true)
					else
						var_186_38.gameObject:SetActive(false)
					end
				end
			end

			local var_186_39 = 0.001

			if var_186_36 <= arg_183_1.time_ and arg_183_1.time_ < var_186_36 + var_186_39 then
				local var_186_40 = (arg_183_1.time_ - var_186_36) / var_186_39
				local var_186_41 = Vector3.New(0, -2000, 0)

				var_186_35.localPosition = Vector3.Lerp(arg_183_1.var_.moveOldPos1148, var_186_41, var_186_40)
			end

			if arg_183_1.time_ >= var_186_36 + var_186_39 and arg_183_1.time_ < var_186_36 + var_186_39 + arg_186_0 then
				var_186_35.localPosition = Vector3.New(0, -2000, 0)
			end

			local var_186_42 = arg_183_1.actors_["1148"].transform
			local var_186_43 = 3.73333333333333

			if var_186_43 < arg_183_1.time_ and arg_183_1.time_ <= var_186_43 + arg_186_0 then
				arg_183_1.var_.moveOldPos1148 = var_186_42.localPosition
				var_186_42.localScale = Vector3.New(1, 1, 1)

				arg_183_1:CheckSpriteTmpPos("1148", 3)

				local var_186_44 = var_186_42.childCount

				for iter_186_7 = 0, var_186_44 - 1 do
					local var_186_45 = var_186_42:GetChild(iter_186_7)

					if var_186_45.name == "" or not string.find(var_186_45.name, "split") then
						var_186_45.gameObject:SetActive(true)
					else
						var_186_45.gameObject:SetActive(false)
					end
				end
			end

			local var_186_46 = 0.001

			if var_186_43 <= arg_183_1.time_ and arg_183_1.time_ < var_186_43 + var_186_46 then
				local var_186_47 = (arg_183_1.time_ - var_186_43) / var_186_46
				local var_186_48 = Vector3.New(0, -429, -180)

				var_186_42.localPosition = Vector3.Lerp(arg_183_1.var_.moveOldPos1148, var_186_48, var_186_47)
			end

			if arg_183_1.time_ >= var_186_43 + var_186_46 and arg_183_1.time_ < var_186_43 + var_186_46 + arg_186_0 then
				var_186_42.localPosition = Vector3.New(0, -429, -180)
			end

			local var_186_49 = arg_183_1.actors_["10108"].transform
			local var_186_50 = 1.966

			if var_186_50 < arg_183_1.time_ and arg_183_1.time_ <= var_186_50 + arg_186_0 then
				arg_183_1.var_.moveOldPos10108 = var_186_49.localPosition
				var_186_49.localScale = Vector3.New(1, 1, 1)

				arg_183_1:CheckSpriteTmpPos("10108", 7)

				local var_186_51 = var_186_49.childCount

				for iter_186_8 = 0, var_186_51 - 1 do
					local var_186_52 = var_186_49:GetChild(iter_186_8)

					if var_186_52.name == "" or not string.find(var_186_52.name, "split") then
						var_186_52.gameObject:SetActive(true)
					else
						var_186_52.gameObject:SetActive(false)
					end
				end
			end

			local var_186_53 = 0.001

			if var_186_50 <= arg_183_1.time_ and arg_183_1.time_ < var_186_50 + var_186_53 then
				local var_186_54 = (arg_183_1.time_ - var_186_50) / var_186_53
				local var_186_55 = Vector3.New(0, -2000, 0)

				var_186_49.localPosition = Vector3.Lerp(arg_183_1.var_.moveOldPos10108, var_186_55, var_186_54)
			end

			if arg_183_1.time_ >= var_186_50 + var_186_53 and arg_183_1.time_ < var_186_50 + var_186_53 + arg_186_0 then
				var_186_49.localPosition = Vector3.New(0, -2000, 0)
			end

			local var_186_56 = arg_183_1.actors_["1148"]
			local var_186_57 = 3.73333333333333

			if var_186_57 < arg_183_1.time_ and arg_183_1.time_ <= var_186_57 + arg_186_0 then
				local var_186_58 = var_186_56:GetComponentInChildren(typeof(CanvasGroup))

				if var_186_58 then
					arg_183_1.var_.alphaOldValue1148 = var_186_58.alpha
					arg_183_1.var_.characterEffect1148 = var_186_58
				end

				arg_183_1.var_.alphaOldValue1148 = 0
			end

			local var_186_59 = 0.3

			if var_186_57 <= arg_183_1.time_ and arg_183_1.time_ < var_186_57 + var_186_59 then
				local var_186_60 = (arg_183_1.time_ - var_186_57) / var_186_59
				local var_186_61 = Mathf.Lerp(arg_183_1.var_.alphaOldValue1148, 1, var_186_60)

				if arg_183_1.var_.characterEffect1148 then
					arg_183_1.var_.characterEffect1148.alpha = var_186_61
				end
			end

			if arg_183_1.time_ >= var_186_57 + var_186_59 and arg_183_1.time_ < var_186_57 + var_186_59 + arg_186_0 and arg_183_1.var_.characterEffect1148 then
				arg_183_1.var_.characterEffect1148.alpha = 1
			end

			if arg_183_1.frameCnt_ <= 1 then
				arg_183_1.dialog_:SetActive(false)
			end

			local var_186_62 = 4
			local var_186_63 = 0.55

			if var_186_62 < arg_183_1.time_ and arg_183_1.time_ <= var_186_62 + arg_186_0 then
				arg_183_1.talkMaxDuration = 0

				arg_183_1.dialog_:SetActive(true)

				arg_183_1.dialogCg_.alpha = 0

				local var_186_64 = LeanTween.value(arg_183_1.dialog_, 0, 1, 0.3)

				var_186_64:setOnUpdate(LuaHelper.FloatAction(function(arg_187_0)
					arg_183_1.dialogCg_.alpha = arg_187_0
				end))
				var_186_64:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_183_1.dialog_)
					var_186_64:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_183_1.duration_ = arg_183_1.duration_ + 0.3

				SetActive(arg_183_1.leftNameGo_, true)

				local var_186_65 = arg_183_1:FormatText(StoryNameCfg[8].name)

				arg_183_1.leftNameTxt_.text = var_186_65

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_183_1.leftNameTxt_.transform)

				arg_183_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_183_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_183_1:RecordName(arg_183_1.leftNameTxt_.text)
				SetActive(arg_183_1.iconTrs_.gameObject, false)
				arg_183_1.callingController_:SetSelectedState("normal")

				local var_186_66 = arg_183_1:GetWordFromCfg(416071045)
				local var_186_67 = arg_183_1:FormatText(var_186_66.content)

				arg_183_1.text_.text = var_186_67

				LuaForUtil.ClearLinePrefixSymbol(arg_183_1.text_)

				local var_186_68 = 22
				local var_186_69 = utf8.len(var_186_67)
				local var_186_70 = var_186_68 <= 0 and var_186_63 or var_186_63 * (var_186_69 / var_186_68)

				if var_186_70 > 0 and var_186_63 < var_186_70 then
					arg_183_1.talkMaxDuration = var_186_70
					var_186_62 = var_186_62 + 0.3

					if var_186_70 + var_186_62 > arg_183_1.duration_ then
						arg_183_1.duration_ = var_186_70 + var_186_62
					end
				end

				arg_183_1.text_.text = var_186_67
				arg_183_1.typewritter.percent = 0

				arg_183_1.typewritter:SetDirty()
				arg_183_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_416071", "416071045", "story_v_out_416071.awb") ~= 0 then
					local var_186_71 = manager.audio:GetVoiceLength("story_v_out_416071", "416071045", "story_v_out_416071.awb") / 1000

					if var_186_71 + var_186_62 > arg_183_1.duration_ then
						arg_183_1.duration_ = var_186_71 + var_186_62
					end

					if var_186_66.prefab_name ~= "" and arg_183_1.actors_[var_186_66.prefab_name] ~= nil then
						local var_186_72 = LuaForUtil.PlayVoiceWithCriLipsync(arg_183_1.actors_[var_186_66.prefab_name].transform, "story_v_out_416071", "416071045", "story_v_out_416071.awb")

						arg_183_1:RecordAudio("416071045", var_186_72)
						arg_183_1:RecordAudio("416071045", var_186_72)
					else
						arg_183_1:AudioAction("play", "voice", "story_v_out_416071", "416071045", "story_v_out_416071.awb")
					end

					arg_183_1:RecordHistoryTalkVoice("story_v_out_416071", "416071045", "story_v_out_416071.awb")
				end

				arg_183_1:RecordContent(arg_183_1.text_.text)
			end

			local var_186_73 = var_186_62 + 0.3
			local var_186_74 = math.max(var_186_63, arg_183_1.talkMaxDuration)

			if var_186_73 <= arg_183_1.time_ and arg_183_1.time_ < var_186_73 + var_186_74 then
				arg_183_1.typewritter.percent = (arg_183_1.time_ - var_186_73) / var_186_74

				arg_183_1.typewritter:SetDirty()
			end

			if arg_183_1.time_ >= var_186_73 + var_186_74 and arg_183_1.time_ < var_186_73 + var_186_74 + arg_186_0 then
				arg_183_1.typewritter.percent = 1

				arg_183_1.typewritter:SetDirty()
				arg_183_1:ShowNextGo(true)
			end
		end

		arg_183_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1148",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 1.966,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			},
			{
				assetPath = "",
				actorName = "1148",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 3.73333333333333,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			},
			{
				assetPath = "",
				actorName = "10108",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 1.966,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_183_1:InitPlayNodeList()
	end,
	Play416071046 = function(arg_189_0, arg_189_1)
		arg_189_1.time_ = 0
		arg_189_1.frameCnt_ = 0
		arg_189_1.state_ = "playing"
		arg_189_1.curTalkId_ = 416071046
		arg_189_1.duration_ = 12.77

		local var_189_0 = {
			zh = 5.9,
			ja = 12.766
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
				arg_189_0:Play416071047(arg_189_1)
			end
		end

		function arg_189_1.onSingleLineUpdate_(arg_192_0)
			local var_192_0 = 0
			local var_192_1 = 0.75

			if var_192_0 < arg_189_1.time_ and arg_189_1.time_ <= var_192_0 + arg_192_0 then
				arg_189_1.talkMaxDuration = 0
				arg_189_1.dialogCg_.alpha = 1

				arg_189_1.dialog_:SetActive(true)
				SetActive(arg_189_1.leftNameGo_, true)

				local var_192_2 = arg_189_1:FormatText(StoryNameCfg[8].name)

				arg_189_1.leftNameTxt_.text = var_192_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_189_1.leftNameTxt_.transform)

				arg_189_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_189_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_189_1:RecordName(arg_189_1.leftNameTxt_.text)
				SetActive(arg_189_1.iconTrs_.gameObject, false)
				arg_189_1.callingController_:SetSelectedState("normal")

				local var_192_3 = arg_189_1:GetWordFromCfg(416071046)
				local var_192_4 = arg_189_1:FormatText(var_192_3.content)

				arg_189_1.text_.text = var_192_4

				LuaForUtil.ClearLinePrefixSymbol(arg_189_1.text_)

				local var_192_5 = 30
				local var_192_6 = utf8.len(var_192_4)
				local var_192_7 = var_192_5 <= 0 and var_192_1 or var_192_1 * (var_192_6 / var_192_5)

				if var_192_7 > 0 and var_192_1 < var_192_7 then
					arg_189_1.talkMaxDuration = var_192_7

					if var_192_7 + var_192_0 > arg_189_1.duration_ then
						arg_189_1.duration_ = var_192_7 + var_192_0
					end
				end

				arg_189_1.text_.text = var_192_4
				arg_189_1.typewritter.percent = 0

				arg_189_1.typewritter:SetDirty()
				arg_189_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_416071", "416071046", "story_v_out_416071.awb") ~= 0 then
					local var_192_8 = manager.audio:GetVoiceLength("story_v_out_416071", "416071046", "story_v_out_416071.awb") / 1000

					if var_192_8 + var_192_0 > arg_189_1.duration_ then
						arg_189_1.duration_ = var_192_8 + var_192_0
					end

					if var_192_3.prefab_name ~= "" and arg_189_1.actors_[var_192_3.prefab_name] ~= nil then
						local var_192_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_189_1.actors_[var_192_3.prefab_name].transform, "story_v_out_416071", "416071046", "story_v_out_416071.awb")

						arg_189_1:RecordAudio("416071046", var_192_9)
						arg_189_1:RecordAudio("416071046", var_192_9)
					else
						arg_189_1:AudioAction("play", "voice", "story_v_out_416071", "416071046", "story_v_out_416071.awb")
					end

					arg_189_1:RecordHistoryTalkVoice("story_v_out_416071", "416071046", "story_v_out_416071.awb")
				end

				arg_189_1:RecordContent(arg_189_1.text_.text)
			end

			local var_192_10 = math.max(var_192_1, arg_189_1.talkMaxDuration)

			if var_192_0 <= arg_189_1.time_ and arg_189_1.time_ < var_192_0 + var_192_10 then
				arg_189_1.typewritter.percent = (arg_189_1.time_ - var_192_0) / var_192_10

				arg_189_1.typewritter:SetDirty()
			end

			if arg_189_1.time_ >= var_192_0 + var_192_10 and arg_189_1.time_ < var_192_0 + var_192_10 + arg_192_0 then
				arg_189_1.typewritter.percent = 1

				arg_189_1.typewritter:SetDirty()
				arg_189_1:ShowNextGo(true)
			end
		end

		arg_189_1.nodeConfigList_ = {}

		arg_189_1:InitPlayNodeList()
	end,
	Play416071047 = function(arg_193_0, arg_193_1)
		arg_193_1.time_ = 0
		arg_193_1.frameCnt_ = 0
		arg_193_1.state_ = "playing"
		arg_193_1.curTalkId_ = 416071047
		arg_193_1.duration_ = 5

		SetActive(arg_193_1.tipsGo_, false)

		function arg_193_1.onSingleLineFinish_()
			arg_193_1.onSingleLineUpdate_ = nil
			arg_193_1.onSingleLineFinish_ = nil
			arg_193_1.state_ = "waiting"
		end

		function arg_193_1.playNext_(arg_195_0)
			if arg_195_0 == 1 then
				arg_193_0:Play416071048(arg_193_1)
			end
		end

		function arg_193_1.onSingleLineUpdate_(arg_196_0)
			local var_196_0 = arg_193_1.actors_["1148"]
			local var_196_1 = 0

			if var_196_1 < arg_193_1.time_ and arg_193_1.time_ <= var_196_1 + arg_196_0 and not isNil(var_196_0) and arg_193_1.var_.actorSpriteComps1148 == nil then
				arg_193_1.var_.actorSpriteComps1148 = var_196_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_196_2 = 0.125

			if var_196_1 <= arg_193_1.time_ and arg_193_1.time_ < var_196_1 + var_196_2 and not isNil(var_196_0) then
				local var_196_3 = (arg_193_1.time_ - var_196_1) / var_196_2

				if arg_193_1.var_.actorSpriteComps1148 then
					for iter_196_0, iter_196_1 in pairs(arg_193_1.var_.actorSpriteComps1148:ToTable()) do
						if iter_196_1 then
							if arg_193_1.isInRecall_ then
								local var_196_4 = Mathf.Lerp(iter_196_1.color.r, arg_193_1.hightColor2.r, var_196_3)
								local var_196_5 = Mathf.Lerp(iter_196_1.color.g, arg_193_1.hightColor2.g, var_196_3)
								local var_196_6 = Mathf.Lerp(iter_196_1.color.b, arg_193_1.hightColor2.b, var_196_3)

								iter_196_1.color = Color.New(var_196_4, var_196_5, var_196_6)
							else
								local var_196_7 = Mathf.Lerp(iter_196_1.color.r, 0.5, var_196_3)

								iter_196_1.color = Color.New(var_196_7, var_196_7, var_196_7)
							end
						end
					end
				end
			end

			if arg_193_1.time_ >= var_196_1 + var_196_2 and arg_193_1.time_ < var_196_1 + var_196_2 + arg_196_0 and not isNil(var_196_0) and arg_193_1.var_.actorSpriteComps1148 then
				for iter_196_2, iter_196_3 in pairs(arg_193_1.var_.actorSpriteComps1148:ToTable()) do
					if iter_196_3 then
						if arg_193_1.isInRecall_ then
							iter_196_3.color = arg_193_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_196_3.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_193_1.var_.actorSpriteComps1148 = nil
			end

			local var_196_8 = 0
			local var_196_9 = 1.325

			if var_196_8 < arg_193_1.time_ and arg_193_1.time_ <= var_196_8 + arg_196_0 then
				arg_193_1.talkMaxDuration = 0
				arg_193_1.dialogCg_.alpha = 1

				arg_193_1.dialog_:SetActive(true)
				SetActive(arg_193_1.leftNameGo_, false)

				arg_193_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_193_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_193_1:RecordName(arg_193_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_193_1.iconTrs_.gameObject, false)
				arg_193_1.callingController_:SetSelectedState("normal")

				local var_196_10 = arg_193_1:GetWordFromCfg(416071047)
				local var_196_11 = arg_193_1:FormatText(var_196_10.content)

				arg_193_1.text_.text = var_196_11

				LuaForUtil.ClearLinePrefixSymbol(arg_193_1.text_)

				local var_196_12 = 53
				local var_196_13 = utf8.len(var_196_11)
				local var_196_14 = var_196_12 <= 0 and var_196_9 or var_196_9 * (var_196_13 / var_196_12)

				if var_196_14 > 0 and var_196_9 < var_196_14 then
					arg_193_1.talkMaxDuration = var_196_14

					if var_196_14 + var_196_8 > arg_193_1.duration_ then
						arg_193_1.duration_ = var_196_14 + var_196_8
					end
				end

				arg_193_1.text_.text = var_196_11
				arg_193_1.typewritter.percent = 0

				arg_193_1.typewritter:SetDirty()
				arg_193_1:ShowNextGo(false)
				arg_193_1:RecordContent(arg_193_1.text_.text)
			end

			local var_196_15 = math.max(var_196_9, arg_193_1.talkMaxDuration)

			if var_196_8 <= arg_193_1.time_ and arg_193_1.time_ < var_196_8 + var_196_15 then
				arg_193_1.typewritter.percent = (arg_193_1.time_ - var_196_8) / var_196_15

				arg_193_1.typewritter:SetDirty()
			end

			if arg_193_1.time_ >= var_196_8 + var_196_15 and arg_193_1.time_ < var_196_8 + var_196_15 + arg_196_0 then
				arg_193_1.typewritter.percent = 1

				arg_193_1.typewritter:SetDirty()
				arg_193_1:ShowNextGo(true)
			end
		end

		arg_193_1.nodeConfigList_ = {}

		arg_193_1:InitPlayNodeList()
	end,
	Play416071048 = function(arg_197_0, arg_197_1)
		arg_197_1.time_ = 0
		arg_197_1.frameCnt_ = 0
		arg_197_1.state_ = "playing"
		arg_197_1.curTalkId_ = 416071048
		arg_197_1.duration_ = 6.6

		local var_197_0 = {
			zh = 4.533,
			ja = 6.6
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
				arg_197_0:Play416071049(arg_197_1)
			end
		end

		function arg_197_1.onSingleLineUpdate_(arg_200_0)
			local var_200_0 = arg_197_1.actors_["1148"]
			local var_200_1 = 0

			if var_200_1 < arg_197_1.time_ and arg_197_1.time_ <= var_200_1 + arg_200_0 and not isNil(var_200_0) and arg_197_1.var_.actorSpriteComps1148 == nil then
				arg_197_1.var_.actorSpriteComps1148 = var_200_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_200_2 = 0.125

			if var_200_1 <= arg_197_1.time_ and arg_197_1.time_ < var_200_1 + var_200_2 and not isNil(var_200_0) then
				local var_200_3 = (arg_197_1.time_ - var_200_1) / var_200_2

				if arg_197_1.var_.actorSpriteComps1148 then
					for iter_200_0, iter_200_1 in pairs(arg_197_1.var_.actorSpriteComps1148:ToTable()) do
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

			if arg_197_1.time_ >= var_200_1 + var_200_2 and arg_197_1.time_ < var_200_1 + var_200_2 + arg_200_0 and not isNil(var_200_0) and arg_197_1.var_.actorSpriteComps1148 then
				for iter_200_2, iter_200_3 in pairs(arg_197_1.var_.actorSpriteComps1148:ToTable()) do
					if iter_200_3 then
						if arg_197_1.isInRecall_ then
							iter_200_3.color = arg_197_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_200_3.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_197_1.var_.actorSpriteComps1148 = nil
			end

			local var_200_8 = 0
			local var_200_9 = 0.475

			if var_200_8 < arg_197_1.time_ and arg_197_1.time_ <= var_200_8 + arg_200_0 then
				arg_197_1.talkMaxDuration = 0
				arg_197_1.dialogCg_.alpha = 1

				arg_197_1.dialog_:SetActive(true)
				SetActive(arg_197_1.leftNameGo_, true)

				local var_200_10 = arg_197_1:FormatText(StoryNameCfg[8].name)

				arg_197_1.leftNameTxt_.text = var_200_10

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_197_1.leftNameTxt_.transform)

				arg_197_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_197_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_197_1:RecordName(arg_197_1.leftNameTxt_.text)
				SetActive(arg_197_1.iconTrs_.gameObject, false)
				arg_197_1.callingController_:SetSelectedState("normal")

				local var_200_11 = arg_197_1:GetWordFromCfg(416071048)
				local var_200_12 = arg_197_1:FormatText(var_200_11.content)

				arg_197_1.text_.text = var_200_12

				LuaForUtil.ClearLinePrefixSymbol(arg_197_1.text_)

				local var_200_13 = 19
				local var_200_14 = utf8.len(var_200_12)
				local var_200_15 = var_200_13 <= 0 and var_200_9 or var_200_9 * (var_200_14 / var_200_13)

				if var_200_15 > 0 and var_200_9 < var_200_15 then
					arg_197_1.talkMaxDuration = var_200_15

					if var_200_15 + var_200_8 > arg_197_1.duration_ then
						arg_197_1.duration_ = var_200_15 + var_200_8
					end
				end

				arg_197_1.text_.text = var_200_12
				arg_197_1.typewritter.percent = 0

				arg_197_1.typewritter:SetDirty()
				arg_197_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_416071", "416071048", "story_v_out_416071.awb") ~= 0 then
					local var_200_16 = manager.audio:GetVoiceLength("story_v_out_416071", "416071048", "story_v_out_416071.awb") / 1000

					if var_200_16 + var_200_8 > arg_197_1.duration_ then
						arg_197_1.duration_ = var_200_16 + var_200_8
					end

					if var_200_11.prefab_name ~= "" and arg_197_1.actors_[var_200_11.prefab_name] ~= nil then
						local var_200_17 = LuaForUtil.PlayVoiceWithCriLipsync(arg_197_1.actors_[var_200_11.prefab_name].transform, "story_v_out_416071", "416071048", "story_v_out_416071.awb")

						arg_197_1:RecordAudio("416071048", var_200_17)
						arg_197_1:RecordAudio("416071048", var_200_17)
					else
						arg_197_1:AudioAction("play", "voice", "story_v_out_416071", "416071048", "story_v_out_416071.awb")
					end

					arg_197_1:RecordHistoryTalkVoice("story_v_out_416071", "416071048", "story_v_out_416071.awb")
				end

				arg_197_1:RecordContent(arg_197_1.text_.text)
			end

			local var_200_18 = math.max(var_200_9, arg_197_1.talkMaxDuration)

			if var_200_8 <= arg_197_1.time_ and arg_197_1.time_ < var_200_8 + var_200_18 then
				arg_197_1.typewritter.percent = (arg_197_1.time_ - var_200_8) / var_200_18

				arg_197_1.typewritter:SetDirty()
			end

			if arg_197_1.time_ >= var_200_8 + var_200_18 and arg_197_1.time_ < var_200_8 + var_200_18 + arg_200_0 then
				arg_197_1.typewritter.percent = 1

				arg_197_1.typewritter:SetDirty()
				arg_197_1:ShowNextGo(true)
			end
		end

		arg_197_1.nodeConfigList_ = {}

		arg_197_1:InitPlayNodeList()
	end,
	Play416071049 = function(arg_201_0, arg_201_1)
		arg_201_1.time_ = 0
		arg_201_1.frameCnt_ = 0
		arg_201_1.state_ = "playing"
		arg_201_1.curTalkId_ = 416071049
		arg_201_1.duration_ = 9.37

		local var_201_0 = {
			zh = 5.466,
			ja = 9.366
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
				arg_201_0:Play416071050(arg_201_1)
			end
		end

		function arg_201_1.onSingleLineUpdate_(arg_204_0)
			local var_204_0 = arg_201_1.actors_["1148"]
			local var_204_1 = 0

			if var_204_1 < arg_201_1.time_ and arg_201_1.time_ <= var_204_1 + arg_204_0 and not isNil(var_204_0) and arg_201_1.var_.actorSpriteComps1148 == nil then
				arg_201_1.var_.actorSpriteComps1148 = var_204_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_204_2 = 0.125

			if var_204_1 <= arg_201_1.time_ and arg_201_1.time_ < var_204_1 + var_204_2 and not isNil(var_204_0) then
				local var_204_3 = (arg_201_1.time_ - var_204_1) / var_204_2

				if arg_201_1.var_.actorSpriteComps1148 then
					for iter_204_0, iter_204_1 in pairs(arg_201_1.var_.actorSpriteComps1148:ToTable()) do
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

			if arg_201_1.time_ >= var_204_1 + var_204_2 and arg_201_1.time_ < var_204_1 + var_204_2 + arg_204_0 and not isNil(var_204_0) and arg_201_1.var_.actorSpriteComps1148 then
				for iter_204_2, iter_204_3 in pairs(arg_201_1.var_.actorSpriteComps1148:ToTable()) do
					if iter_204_3 then
						if arg_201_1.isInRecall_ then
							iter_204_3.color = arg_201_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_204_3.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_201_1.var_.actorSpriteComps1148 = nil
			end

			local var_204_8 = arg_201_1.actors_["1148"].transform
			local var_204_9 = 0

			if var_204_9 < arg_201_1.time_ and arg_201_1.time_ <= var_204_9 + arg_204_0 then
				arg_201_1.var_.moveOldPos1148 = var_204_8.localPosition
				var_204_8.localScale = Vector3.New(1, 1, 1)

				arg_201_1:CheckSpriteTmpPos("1148", 2)

				local var_204_10 = var_204_8.childCount

				for iter_204_4 = 0, var_204_10 - 1 do
					local var_204_11 = var_204_8:GetChild(iter_204_4)

					if var_204_11.name == "" or not string.find(var_204_11.name, "split") then
						var_204_11.gameObject:SetActive(true)
					else
						var_204_11.gameObject:SetActive(false)
					end
				end
			end

			local var_204_12 = 0.001

			if var_204_9 <= arg_201_1.time_ and arg_201_1.time_ < var_204_9 + var_204_12 then
				local var_204_13 = (arg_201_1.time_ - var_204_9) / var_204_12
				local var_204_14 = Vector3.New(-390, -429, -180)

				var_204_8.localPosition = Vector3.Lerp(arg_201_1.var_.moveOldPos1148, var_204_14, var_204_13)
			end

			if arg_201_1.time_ >= var_204_9 + var_204_12 and arg_201_1.time_ < var_204_9 + var_204_12 + arg_204_0 then
				var_204_8.localPosition = Vector3.New(-390, -429, -180)
			end

			local var_204_15 = arg_201_1.actors_["10108"]
			local var_204_16 = 0

			if var_204_16 < arg_201_1.time_ and arg_201_1.time_ <= var_204_16 + arg_204_0 and not isNil(var_204_15) and arg_201_1.var_.actorSpriteComps10108 == nil then
				arg_201_1.var_.actorSpriteComps10108 = var_204_15:GetComponentsInChildren(typeof(Image), true)
			end

			local var_204_17 = 0.125

			if var_204_16 <= arg_201_1.time_ and arg_201_1.time_ < var_204_16 + var_204_17 and not isNil(var_204_15) then
				local var_204_18 = (arg_201_1.time_ - var_204_16) / var_204_17

				if arg_201_1.var_.actorSpriteComps10108 then
					for iter_204_5, iter_204_6 in pairs(arg_201_1.var_.actorSpriteComps10108:ToTable()) do
						if iter_204_6 then
							if arg_201_1.isInRecall_ then
								local var_204_19 = Mathf.Lerp(iter_204_6.color.r, arg_201_1.hightColor1.r, var_204_18)
								local var_204_20 = Mathf.Lerp(iter_204_6.color.g, arg_201_1.hightColor1.g, var_204_18)
								local var_204_21 = Mathf.Lerp(iter_204_6.color.b, arg_201_1.hightColor1.b, var_204_18)

								iter_204_6.color = Color.New(var_204_19, var_204_20, var_204_21)
							else
								local var_204_22 = Mathf.Lerp(iter_204_6.color.r, 1, var_204_18)

								iter_204_6.color = Color.New(var_204_22, var_204_22, var_204_22)
							end
						end
					end
				end
			end

			if arg_201_1.time_ >= var_204_16 + var_204_17 and arg_201_1.time_ < var_204_16 + var_204_17 + arg_204_0 and not isNil(var_204_15) and arg_201_1.var_.actorSpriteComps10108 then
				for iter_204_7, iter_204_8 in pairs(arg_201_1.var_.actorSpriteComps10108:ToTable()) do
					if iter_204_8 then
						if arg_201_1.isInRecall_ then
							iter_204_8.color = arg_201_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_204_8.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_201_1.var_.actorSpriteComps10108 = nil
			end

			local var_204_23 = arg_201_1.actors_["10108"].transform
			local var_204_24 = 0

			if var_204_24 < arg_201_1.time_ and arg_201_1.time_ <= var_204_24 + arg_204_0 then
				arg_201_1.var_.moveOldPos10108 = var_204_23.localPosition
				var_204_23.localScale = Vector3.New(1, 1, 1)

				arg_201_1:CheckSpriteTmpPos("10108", 4)

				local var_204_25 = var_204_23.childCount

				for iter_204_9 = 0, var_204_25 - 1 do
					local var_204_26 = var_204_23:GetChild(iter_204_9)

					if var_204_26.name == "" or not string.find(var_204_26.name, "split") then
						var_204_26.gameObject:SetActive(true)
					else
						var_204_26.gameObject:SetActive(false)
					end
				end
			end

			local var_204_27 = 0.001

			if var_204_24 <= arg_201_1.time_ and arg_201_1.time_ < var_204_24 + var_204_27 then
				local var_204_28 = (arg_201_1.time_ - var_204_24) / var_204_27
				local var_204_29 = Vector3.New(390, -399.6, -130)

				var_204_23.localPosition = Vector3.Lerp(arg_201_1.var_.moveOldPos10108, var_204_29, var_204_28)
			end

			if arg_201_1.time_ >= var_204_24 + var_204_27 and arg_201_1.time_ < var_204_24 + var_204_27 + arg_204_0 then
				var_204_23.localPosition = Vector3.New(390, -399.6, -130)
			end

			local var_204_30 = 0
			local var_204_31 = 0.525

			if var_204_30 < arg_201_1.time_ and arg_201_1.time_ <= var_204_30 + arg_204_0 then
				arg_201_1.talkMaxDuration = 0
				arg_201_1.dialogCg_.alpha = 1

				arg_201_1.dialog_:SetActive(true)
				SetActive(arg_201_1.leftNameGo_, true)

				local var_204_32 = arg_201_1:FormatText(StoryNameCfg[1083].name)

				arg_201_1.leftNameTxt_.text = var_204_32

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_201_1.leftNameTxt_.transform)

				arg_201_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_201_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_201_1:RecordName(arg_201_1.leftNameTxt_.text)
				SetActive(arg_201_1.iconTrs_.gameObject, false)
				arg_201_1.callingController_:SetSelectedState("normal")

				local var_204_33 = arg_201_1:GetWordFromCfg(416071049)
				local var_204_34 = arg_201_1:FormatText(var_204_33.content)

				arg_201_1.text_.text = var_204_34

				LuaForUtil.ClearLinePrefixSymbol(arg_201_1.text_)

				local var_204_35 = 21
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

				if manager.audio:GetVoiceLength("story_v_out_416071", "416071049", "story_v_out_416071.awb") ~= 0 then
					local var_204_38 = manager.audio:GetVoiceLength("story_v_out_416071", "416071049", "story_v_out_416071.awb") / 1000

					if var_204_38 + var_204_30 > arg_201_1.duration_ then
						arg_201_1.duration_ = var_204_38 + var_204_30
					end

					if var_204_33.prefab_name ~= "" and arg_201_1.actors_[var_204_33.prefab_name] ~= nil then
						local var_204_39 = LuaForUtil.PlayVoiceWithCriLipsync(arg_201_1.actors_[var_204_33.prefab_name].transform, "story_v_out_416071", "416071049", "story_v_out_416071.awb")

						arg_201_1:RecordAudio("416071049", var_204_39)
						arg_201_1:RecordAudio("416071049", var_204_39)
					else
						arg_201_1:AudioAction("play", "voice", "story_v_out_416071", "416071049", "story_v_out_416071.awb")
					end

					arg_201_1:RecordHistoryTalkVoice("story_v_out_416071", "416071049", "story_v_out_416071.awb")
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
				actorName = "1148",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			},
			{
				assetPath = "",
				actorName = "10108",
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
	Play416071050 = function(arg_205_0, arg_205_1)
		arg_205_1.time_ = 0
		arg_205_1.frameCnt_ = 0
		arg_205_1.state_ = "playing"
		arg_205_1.curTalkId_ = 416071050
		arg_205_1.duration_ = 5

		SetActive(arg_205_1.tipsGo_, false)

		function arg_205_1.onSingleLineFinish_()
			arg_205_1.onSingleLineUpdate_ = nil
			arg_205_1.onSingleLineFinish_ = nil
			arg_205_1.state_ = "waiting"
		end

		function arg_205_1.playNext_(arg_207_0)
			if arg_207_0 == 1 then
				arg_205_0:Play416071051(arg_205_1)
			end
		end

		function arg_205_1.onSingleLineUpdate_(arg_208_0)
			local var_208_0 = arg_205_1.actors_["10108"]
			local var_208_1 = 0

			if var_208_1 < arg_205_1.time_ and arg_205_1.time_ <= var_208_1 + arg_208_0 and not isNil(var_208_0) and arg_205_1.var_.actorSpriteComps10108 == nil then
				arg_205_1.var_.actorSpriteComps10108 = var_208_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_208_2 = 0.125

			if var_208_1 <= arg_205_1.time_ and arg_205_1.time_ < var_208_1 + var_208_2 and not isNil(var_208_0) then
				local var_208_3 = (arg_205_1.time_ - var_208_1) / var_208_2

				if arg_205_1.var_.actorSpriteComps10108 then
					for iter_208_0, iter_208_1 in pairs(arg_205_1.var_.actorSpriteComps10108:ToTable()) do
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

			if arg_205_1.time_ >= var_208_1 + var_208_2 and arg_205_1.time_ < var_208_1 + var_208_2 + arg_208_0 and not isNil(var_208_0) and arg_205_1.var_.actorSpriteComps10108 then
				for iter_208_2, iter_208_3 in pairs(arg_205_1.var_.actorSpriteComps10108:ToTable()) do
					if iter_208_3 then
						if arg_205_1.isInRecall_ then
							iter_208_3.color = arg_205_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_208_3.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_205_1.var_.actorSpriteComps10108 = nil
			end

			local var_208_8 = 0
			local var_208_9 = 0.725

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

				local var_208_10 = arg_205_1:GetWordFromCfg(416071050)
				local var_208_11 = arg_205_1:FormatText(var_208_10.content)

				arg_205_1.text_.text = var_208_11

				LuaForUtil.ClearLinePrefixSymbol(arg_205_1.text_)

				local var_208_12 = 29
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
	Play416071051 = function(arg_209_0, arg_209_1)
		arg_209_1.time_ = 0
		arg_209_1.frameCnt_ = 0
		arg_209_1.state_ = "playing"
		arg_209_1.curTalkId_ = 416071051
		arg_209_1.duration_ = 11.7

		local var_209_0 = {
			zh = 5.666,
			ja = 11.7
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
				arg_209_0:Play416071052(arg_209_1)
			end
		end

		function arg_209_1.onSingleLineUpdate_(arg_212_0)
			local var_212_0 = arg_209_1.actors_["10108"]
			local var_212_1 = 0

			if var_212_1 < arg_209_1.time_ and arg_209_1.time_ <= var_212_1 + arg_212_0 and not isNil(var_212_0) and arg_209_1.var_.actorSpriteComps10108 == nil then
				arg_209_1.var_.actorSpriteComps10108 = var_212_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_212_2 = 0.125

			if var_212_1 <= arg_209_1.time_ and arg_209_1.time_ < var_212_1 + var_212_2 and not isNil(var_212_0) then
				local var_212_3 = (arg_209_1.time_ - var_212_1) / var_212_2

				if arg_209_1.var_.actorSpriteComps10108 then
					for iter_212_0, iter_212_1 in pairs(arg_209_1.var_.actorSpriteComps10108:ToTable()) do
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

			if arg_209_1.time_ >= var_212_1 + var_212_2 and arg_209_1.time_ < var_212_1 + var_212_2 + arg_212_0 and not isNil(var_212_0) and arg_209_1.var_.actorSpriteComps10108 then
				for iter_212_2, iter_212_3 in pairs(arg_209_1.var_.actorSpriteComps10108:ToTable()) do
					if iter_212_3 then
						if arg_209_1.isInRecall_ then
							iter_212_3.color = arg_209_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_212_3.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_209_1.var_.actorSpriteComps10108 = nil
			end

			local var_212_8 = 0
			local var_212_9 = 0.525

			if var_212_8 < arg_209_1.time_ and arg_209_1.time_ <= var_212_8 + arg_212_0 then
				arg_209_1.talkMaxDuration = 0
				arg_209_1.dialogCg_.alpha = 1

				arg_209_1.dialog_:SetActive(true)
				SetActive(arg_209_1.leftNameGo_, true)

				local var_212_10 = arg_209_1:FormatText(StoryNameCfg[1083].name)

				arg_209_1.leftNameTxt_.text = var_212_10

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_209_1.leftNameTxt_.transform)

				arg_209_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_209_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_209_1:RecordName(arg_209_1.leftNameTxt_.text)
				SetActive(arg_209_1.iconTrs_.gameObject, false)
				arg_209_1.callingController_:SetSelectedState("normal")

				local var_212_11 = arg_209_1:GetWordFromCfg(416071051)
				local var_212_12 = arg_209_1:FormatText(var_212_11.content)

				arg_209_1.text_.text = var_212_12

				LuaForUtil.ClearLinePrefixSymbol(arg_209_1.text_)

				local var_212_13 = 21
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

				if manager.audio:GetVoiceLength("story_v_out_416071", "416071051", "story_v_out_416071.awb") ~= 0 then
					local var_212_16 = manager.audio:GetVoiceLength("story_v_out_416071", "416071051", "story_v_out_416071.awb") / 1000

					if var_212_16 + var_212_8 > arg_209_1.duration_ then
						arg_209_1.duration_ = var_212_16 + var_212_8
					end

					if var_212_11.prefab_name ~= "" and arg_209_1.actors_[var_212_11.prefab_name] ~= nil then
						local var_212_17 = LuaForUtil.PlayVoiceWithCriLipsync(arg_209_1.actors_[var_212_11.prefab_name].transform, "story_v_out_416071", "416071051", "story_v_out_416071.awb")

						arg_209_1:RecordAudio("416071051", var_212_17)
						arg_209_1:RecordAudio("416071051", var_212_17)
					else
						arg_209_1:AudioAction("play", "voice", "story_v_out_416071", "416071051", "story_v_out_416071.awb")
					end

					arg_209_1:RecordHistoryTalkVoice("story_v_out_416071", "416071051", "story_v_out_416071.awb")
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
	Play416071052 = function(arg_213_0, arg_213_1)
		arg_213_1.time_ = 0
		arg_213_1.frameCnt_ = 0
		arg_213_1.state_ = "playing"
		arg_213_1.curTalkId_ = 416071052
		arg_213_1.duration_ = 16.37

		local var_213_0 = {
			zh = 8.3,
			ja = 16.366
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
				arg_213_0:Play416071053(arg_213_1)
			end
		end

		function arg_213_1.onSingleLineUpdate_(arg_216_0)
			local var_216_0 = 0
			local var_216_1 = 0.8

			if var_216_0 < arg_213_1.time_ and arg_213_1.time_ <= var_216_0 + arg_216_0 then
				arg_213_1.talkMaxDuration = 0
				arg_213_1.dialogCg_.alpha = 1

				arg_213_1.dialog_:SetActive(true)
				SetActive(arg_213_1.leftNameGo_, true)

				local var_216_2 = arg_213_1:FormatText(StoryNameCfg[1083].name)

				arg_213_1.leftNameTxt_.text = var_216_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_213_1.leftNameTxt_.transform)

				arg_213_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_213_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_213_1:RecordName(arg_213_1.leftNameTxt_.text)
				SetActive(arg_213_1.iconTrs_.gameObject, false)
				arg_213_1.callingController_:SetSelectedState("normal")

				local var_216_3 = arg_213_1:GetWordFromCfg(416071052)
				local var_216_4 = arg_213_1:FormatText(var_216_3.content)

				arg_213_1.text_.text = var_216_4

				LuaForUtil.ClearLinePrefixSymbol(arg_213_1.text_)

				local var_216_5 = 32
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

				if manager.audio:GetVoiceLength("story_v_out_416071", "416071052", "story_v_out_416071.awb") ~= 0 then
					local var_216_8 = manager.audio:GetVoiceLength("story_v_out_416071", "416071052", "story_v_out_416071.awb") / 1000

					if var_216_8 + var_216_0 > arg_213_1.duration_ then
						arg_213_1.duration_ = var_216_8 + var_216_0
					end

					if var_216_3.prefab_name ~= "" and arg_213_1.actors_[var_216_3.prefab_name] ~= nil then
						local var_216_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_213_1.actors_[var_216_3.prefab_name].transform, "story_v_out_416071", "416071052", "story_v_out_416071.awb")

						arg_213_1:RecordAudio("416071052", var_216_9)
						arg_213_1:RecordAudio("416071052", var_216_9)
					else
						arg_213_1:AudioAction("play", "voice", "story_v_out_416071", "416071052", "story_v_out_416071.awb")
					end

					arg_213_1:RecordHistoryTalkVoice("story_v_out_416071", "416071052", "story_v_out_416071.awb")
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
	Play416071053 = function(arg_217_0, arg_217_1)
		arg_217_1.time_ = 0
		arg_217_1.frameCnt_ = 0
		arg_217_1.state_ = "playing"
		arg_217_1.curTalkId_ = 416071053
		arg_217_1.duration_ = 12.1

		local var_217_0 = {
			zh = 8.433,
			ja = 12.1
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
				arg_217_0:Play416071054(arg_217_1)
			end
		end

		function arg_217_1.onSingleLineUpdate_(arg_220_0)
			local var_220_0 = 0
			local var_220_1 = 0.775

			if var_220_0 < arg_217_1.time_ and arg_217_1.time_ <= var_220_0 + arg_220_0 then
				arg_217_1.talkMaxDuration = 0
				arg_217_1.dialogCg_.alpha = 1

				arg_217_1.dialog_:SetActive(true)
				SetActive(arg_217_1.leftNameGo_, true)

				local var_220_2 = arg_217_1:FormatText(StoryNameCfg[1083].name)

				arg_217_1.leftNameTxt_.text = var_220_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_217_1.leftNameTxt_.transform)

				arg_217_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_217_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_217_1:RecordName(arg_217_1.leftNameTxt_.text)
				SetActive(arg_217_1.iconTrs_.gameObject, false)
				arg_217_1.callingController_:SetSelectedState("normal")

				local var_220_3 = arg_217_1:GetWordFromCfg(416071053)
				local var_220_4 = arg_217_1:FormatText(var_220_3.content)

				arg_217_1.text_.text = var_220_4

				LuaForUtil.ClearLinePrefixSymbol(arg_217_1.text_)

				local var_220_5 = 31
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

				if manager.audio:GetVoiceLength("story_v_out_416071", "416071053", "story_v_out_416071.awb") ~= 0 then
					local var_220_8 = manager.audio:GetVoiceLength("story_v_out_416071", "416071053", "story_v_out_416071.awb") / 1000

					if var_220_8 + var_220_0 > arg_217_1.duration_ then
						arg_217_1.duration_ = var_220_8 + var_220_0
					end

					if var_220_3.prefab_name ~= "" and arg_217_1.actors_[var_220_3.prefab_name] ~= nil then
						local var_220_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_217_1.actors_[var_220_3.prefab_name].transform, "story_v_out_416071", "416071053", "story_v_out_416071.awb")

						arg_217_1:RecordAudio("416071053", var_220_9)
						arg_217_1:RecordAudio("416071053", var_220_9)
					else
						arg_217_1:AudioAction("play", "voice", "story_v_out_416071", "416071053", "story_v_out_416071.awb")
					end

					arg_217_1:RecordHistoryTalkVoice("story_v_out_416071", "416071053", "story_v_out_416071.awb")
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
	Play416071054 = function(arg_221_0, arg_221_1)
		arg_221_1.time_ = 0
		arg_221_1.frameCnt_ = 0
		arg_221_1.state_ = "playing"
		arg_221_1.curTalkId_ = 416071054
		arg_221_1.duration_ = 6.53

		local var_221_0 = {
			zh = 5.266,
			ja = 6.533
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
				arg_221_0:Play416071055(arg_221_1)
			end
		end

		function arg_221_1.onSingleLineUpdate_(arg_224_0)
			local var_224_0 = arg_221_1.actors_["10108"]
			local var_224_1 = 0

			if var_224_1 < arg_221_1.time_ and arg_221_1.time_ <= var_224_1 + arg_224_0 and not isNil(var_224_0) and arg_221_1.var_.actorSpriteComps10108 == nil then
				arg_221_1.var_.actorSpriteComps10108 = var_224_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_224_2 = 0.125

			if var_224_1 <= arg_221_1.time_ and arg_221_1.time_ < var_224_1 + var_224_2 and not isNil(var_224_0) then
				local var_224_3 = (arg_221_1.time_ - var_224_1) / var_224_2

				if arg_221_1.var_.actorSpriteComps10108 then
					for iter_224_0, iter_224_1 in pairs(arg_221_1.var_.actorSpriteComps10108:ToTable()) do
						if iter_224_1 then
							if arg_221_1.isInRecall_ then
								local var_224_4 = Mathf.Lerp(iter_224_1.color.r, arg_221_1.hightColor2.r, var_224_3)
								local var_224_5 = Mathf.Lerp(iter_224_1.color.g, arg_221_1.hightColor2.g, var_224_3)
								local var_224_6 = Mathf.Lerp(iter_224_1.color.b, arg_221_1.hightColor2.b, var_224_3)

								iter_224_1.color = Color.New(var_224_4, var_224_5, var_224_6)
							else
								local var_224_7 = Mathf.Lerp(iter_224_1.color.r, 0.5, var_224_3)

								iter_224_1.color = Color.New(var_224_7, var_224_7, var_224_7)
							end
						end
					end
				end
			end

			if arg_221_1.time_ >= var_224_1 + var_224_2 and arg_221_1.time_ < var_224_1 + var_224_2 + arg_224_0 and not isNil(var_224_0) and arg_221_1.var_.actorSpriteComps10108 then
				for iter_224_2, iter_224_3 in pairs(arg_221_1.var_.actorSpriteComps10108:ToTable()) do
					if iter_224_3 then
						if arg_221_1.isInRecall_ then
							iter_224_3.color = arg_221_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_224_3.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_221_1.var_.actorSpriteComps10108 = nil
			end

			local var_224_8 = arg_221_1.actors_["1148"]
			local var_224_9 = 0

			if var_224_9 < arg_221_1.time_ and arg_221_1.time_ <= var_224_9 + arg_224_0 and not isNil(var_224_8) and arg_221_1.var_.actorSpriteComps1148 == nil then
				arg_221_1.var_.actorSpriteComps1148 = var_224_8:GetComponentsInChildren(typeof(Image), true)
			end

			local var_224_10 = 0.125

			if var_224_9 <= arg_221_1.time_ and arg_221_1.time_ < var_224_9 + var_224_10 and not isNil(var_224_8) then
				local var_224_11 = (arg_221_1.time_ - var_224_9) / var_224_10

				if arg_221_1.var_.actorSpriteComps1148 then
					for iter_224_4, iter_224_5 in pairs(arg_221_1.var_.actorSpriteComps1148:ToTable()) do
						if iter_224_5 then
							if arg_221_1.isInRecall_ then
								local var_224_12 = Mathf.Lerp(iter_224_5.color.r, arg_221_1.hightColor1.r, var_224_11)
								local var_224_13 = Mathf.Lerp(iter_224_5.color.g, arg_221_1.hightColor1.g, var_224_11)
								local var_224_14 = Mathf.Lerp(iter_224_5.color.b, arg_221_1.hightColor1.b, var_224_11)

								iter_224_5.color = Color.New(var_224_12, var_224_13, var_224_14)
							else
								local var_224_15 = Mathf.Lerp(iter_224_5.color.r, 1, var_224_11)

								iter_224_5.color = Color.New(var_224_15, var_224_15, var_224_15)
							end
						end
					end
				end
			end

			if arg_221_1.time_ >= var_224_9 + var_224_10 and arg_221_1.time_ < var_224_9 + var_224_10 + arg_224_0 and not isNil(var_224_8) and arg_221_1.var_.actorSpriteComps1148 then
				for iter_224_6, iter_224_7 in pairs(arg_221_1.var_.actorSpriteComps1148:ToTable()) do
					if iter_224_7 then
						if arg_221_1.isInRecall_ then
							iter_224_7.color = arg_221_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_224_7.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_221_1.var_.actorSpriteComps1148 = nil
			end

			local var_224_16 = arg_221_1.actors_["1148"].transform
			local var_224_17 = 0

			if var_224_17 < arg_221_1.time_ and arg_221_1.time_ <= var_224_17 + arg_224_0 then
				arg_221_1.var_.moveOldPos1148 = var_224_16.localPosition
				var_224_16.localScale = Vector3.New(1, 1, 1)

				arg_221_1:CheckSpriteTmpPos("1148", 2)

				local var_224_18 = var_224_16.childCount

				for iter_224_8 = 0, var_224_18 - 1 do
					local var_224_19 = var_224_16:GetChild(iter_224_8)

					if var_224_19.name == "split_2" or not string.find(var_224_19.name, "split") then
						var_224_19.gameObject:SetActive(true)
					else
						var_224_19.gameObject:SetActive(false)
					end
				end
			end

			local var_224_20 = 0.001

			if var_224_17 <= arg_221_1.time_ and arg_221_1.time_ < var_224_17 + var_224_20 then
				local var_224_21 = (arg_221_1.time_ - var_224_17) / var_224_20
				local var_224_22 = Vector3.New(-390, -429, -180)

				var_224_16.localPosition = Vector3.Lerp(arg_221_1.var_.moveOldPos1148, var_224_22, var_224_21)
			end

			if arg_221_1.time_ >= var_224_17 + var_224_20 and arg_221_1.time_ < var_224_17 + var_224_20 + arg_224_0 then
				var_224_16.localPosition = Vector3.New(-390, -429, -180)
			end

			local var_224_23 = 0
			local var_224_24 = 0.6

			if var_224_23 < arg_221_1.time_ and arg_221_1.time_ <= var_224_23 + arg_224_0 then
				arg_221_1.talkMaxDuration = 0
				arg_221_1.dialogCg_.alpha = 1

				arg_221_1.dialog_:SetActive(true)
				SetActive(arg_221_1.leftNameGo_, true)

				local var_224_25 = arg_221_1:FormatText(StoryNameCfg[8].name)

				arg_221_1.leftNameTxt_.text = var_224_25

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_221_1.leftNameTxt_.transform)

				arg_221_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_221_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_221_1:RecordName(arg_221_1.leftNameTxt_.text)
				SetActive(arg_221_1.iconTrs_.gameObject, false)
				arg_221_1.callingController_:SetSelectedState("normal")

				local var_224_26 = arg_221_1:GetWordFromCfg(416071054)
				local var_224_27 = arg_221_1:FormatText(var_224_26.content)

				arg_221_1.text_.text = var_224_27

				LuaForUtil.ClearLinePrefixSymbol(arg_221_1.text_)

				local var_224_28 = 24
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

				if manager.audio:GetVoiceLength("story_v_out_416071", "416071054", "story_v_out_416071.awb") ~= 0 then
					local var_224_31 = manager.audio:GetVoiceLength("story_v_out_416071", "416071054", "story_v_out_416071.awb") / 1000

					if var_224_31 + var_224_23 > arg_221_1.duration_ then
						arg_221_1.duration_ = var_224_31 + var_224_23
					end

					if var_224_26.prefab_name ~= "" and arg_221_1.actors_[var_224_26.prefab_name] ~= nil then
						local var_224_32 = LuaForUtil.PlayVoiceWithCriLipsync(arg_221_1.actors_[var_224_26.prefab_name].transform, "story_v_out_416071", "416071054", "story_v_out_416071.awb")

						arg_221_1:RecordAudio("416071054", var_224_32)
						arg_221_1:RecordAudio("416071054", var_224_32)
					else
						arg_221_1:AudioAction("play", "voice", "story_v_out_416071", "416071054", "story_v_out_416071.awb")
					end

					arg_221_1:RecordHistoryTalkVoice("story_v_out_416071", "416071054", "story_v_out_416071.awb")
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
				actorName = "1148",
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
	Play416071055 = function(arg_225_0, arg_225_1)
		arg_225_1.time_ = 0
		arg_225_1.frameCnt_ = 0
		arg_225_1.state_ = "playing"
		arg_225_1.curTalkId_ = 416071055
		arg_225_1.duration_ = 14.1

		local var_225_0 = {
			zh = 11.8,
			ja = 14.1
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
				arg_225_0:Play416071056(arg_225_1)
			end
		end

		function arg_225_1.onSingleLineUpdate_(arg_228_0)
			local var_228_0 = arg_225_1.actors_["1148"]
			local var_228_1 = 0

			if var_228_1 < arg_225_1.time_ and arg_225_1.time_ <= var_228_1 + arg_228_0 and not isNil(var_228_0) and arg_225_1.var_.actorSpriteComps1148 == nil then
				arg_225_1.var_.actorSpriteComps1148 = var_228_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_228_2 = 0.125

			if var_228_1 <= arg_225_1.time_ and arg_225_1.time_ < var_228_1 + var_228_2 and not isNil(var_228_0) then
				local var_228_3 = (arg_225_1.time_ - var_228_1) / var_228_2

				if arg_225_1.var_.actorSpriteComps1148 then
					for iter_228_0, iter_228_1 in pairs(arg_225_1.var_.actorSpriteComps1148:ToTable()) do
						if iter_228_1 then
							if arg_225_1.isInRecall_ then
								local var_228_4 = Mathf.Lerp(iter_228_1.color.r, arg_225_1.hightColor2.r, var_228_3)
								local var_228_5 = Mathf.Lerp(iter_228_1.color.g, arg_225_1.hightColor2.g, var_228_3)
								local var_228_6 = Mathf.Lerp(iter_228_1.color.b, arg_225_1.hightColor2.b, var_228_3)

								iter_228_1.color = Color.New(var_228_4, var_228_5, var_228_6)
							else
								local var_228_7 = Mathf.Lerp(iter_228_1.color.r, 0.5, var_228_3)

								iter_228_1.color = Color.New(var_228_7, var_228_7, var_228_7)
							end
						end
					end
				end
			end

			if arg_225_1.time_ >= var_228_1 + var_228_2 and arg_225_1.time_ < var_228_1 + var_228_2 + arg_228_0 and not isNil(var_228_0) and arg_225_1.var_.actorSpriteComps1148 then
				for iter_228_2, iter_228_3 in pairs(arg_225_1.var_.actorSpriteComps1148:ToTable()) do
					if iter_228_3 then
						if arg_225_1.isInRecall_ then
							iter_228_3.color = arg_225_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_228_3.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_225_1.var_.actorSpriteComps1148 = nil
			end

			local var_228_8 = arg_225_1.actors_["10108"]
			local var_228_9 = 0

			if var_228_9 < arg_225_1.time_ and arg_225_1.time_ <= var_228_9 + arg_228_0 and not isNil(var_228_8) and arg_225_1.var_.actorSpriteComps10108 == nil then
				arg_225_1.var_.actorSpriteComps10108 = var_228_8:GetComponentsInChildren(typeof(Image), true)
			end

			local var_228_10 = 0.125

			if var_228_9 <= arg_225_1.time_ and arg_225_1.time_ < var_228_9 + var_228_10 and not isNil(var_228_8) then
				local var_228_11 = (arg_225_1.time_ - var_228_9) / var_228_10

				if arg_225_1.var_.actorSpriteComps10108 then
					for iter_228_4, iter_228_5 in pairs(arg_225_1.var_.actorSpriteComps10108:ToTable()) do
						if iter_228_5 then
							if arg_225_1.isInRecall_ then
								local var_228_12 = Mathf.Lerp(iter_228_5.color.r, arg_225_1.hightColor1.r, var_228_11)
								local var_228_13 = Mathf.Lerp(iter_228_5.color.g, arg_225_1.hightColor1.g, var_228_11)
								local var_228_14 = Mathf.Lerp(iter_228_5.color.b, arg_225_1.hightColor1.b, var_228_11)

								iter_228_5.color = Color.New(var_228_12, var_228_13, var_228_14)
							else
								local var_228_15 = Mathf.Lerp(iter_228_5.color.r, 1, var_228_11)

								iter_228_5.color = Color.New(var_228_15, var_228_15, var_228_15)
							end
						end
					end
				end
			end

			if arg_225_1.time_ >= var_228_9 + var_228_10 and arg_225_1.time_ < var_228_9 + var_228_10 + arg_228_0 and not isNil(var_228_8) and arg_225_1.var_.actorSpriteComps10108 then
				for iter_228_6, iter_228_7 in pairs(arg_225_1.var_.actorSpriteComps10108:ToTable()) do
					if iter_228_7 then
						if arg_225_1.isInRecall_ then
							iter_228_7.color = arg_225_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_228_7.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_225_1.var_.actorSpriteComps10108 = nil
			end

			local var_228_16 = 0
			local var_228_17 = 0.925

			if var_228_16 < arg_225_1.time_ and arg_225_1.time_ <= var_228_16 + arg_228_0 then
				arg_225_1.talkMaxDuration = 0
				arg_225_1.dialogCg_.alpha = 1

				arg_225_1.dialog_:SetActive(true)
				SetActive(arg_225_1.leftNameGo_, true)

				local var_228_18 = arg_225_1:FormatText(StoryNameCfg[1083].name)

				arg_225_1.leftNameTxt_.text = var_228_18

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_225_1.leftNameTxt_.transform)

				arg_225_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_225_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_225_1:RecordName(arg_225_1.leftNameTxt_.text)
				SetActive(arg_225_1.iconTrs_.gameObject, false)
				arg_225_1.callingController_:SetSelectedState("normal")

				local var_228_19 = arg_225_1:GetWordFromCfg(416071055)
				local var_228_20 = arg_225_1:FormatText(var_228_19.content)

				arg_225_1.text_.text = var_228_20

				LuaForUtil.ClearLinePrefixSymbol(arg_225_1.text_)

				local var_228_21 = 37
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

				if manager.audio:GetVoiceLength("story_v_out_416071", "416071055", "story_v_out_416071.awb") ~= 0 then
					local var_228_24 = manager.audio:GetVoiceLength("story_v_out_416071", "416071055", "story_v_out_416071.awb") / 1000

					if var_228_24 + var_228_16 > arg_225_1.duration_ then
						arg_225_1.duration_ = var_228_24 + var_228_16
					end

					if var_228_19.prefab_name ~= "" and arg_225_1.actors_[var_228_19.prefab_name] ~= nil then
						local var_228_25 = LuaForUtil.PlayVoiceWithCriLipsync(arg_225_1.actors_[var_228_19.prefab_name].transform, "story_v_out_416071", "416071055", "story_v_out_416071.awb")

						arg_225_1:RecordAudio("416071055", var_228_25)
						arg_225_1:RecordAudio("416071055", var_228_25)
					else
						arg_225_1:AudioAction("play", "voice", "story_v_out_416071", "416071055", "story_v_out_416071.awb")
					end

					arg_225_1:RecordHistoryTalkVoice("story_v_out_416071", "416071055", "story_v_out_416071.awb")
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
	Play416071056 = function(arg_229_0, arg_229_1)
		arg_229_1.time_ = 0
		arg_229_1.frameCnt_ = 0
		arg_229_1.state_ = "playing"
		arg_229_1.curTalkId_ = 416071056
		arg_229_1.duration_ = 3.53

		local var_229_0 = {
			zh = 3.533,
			ja = 2.933
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
				arg_229_0:Play416071057(arg_229_1)
			end
		end

		function arg_229_1.onSingleLineUpdate_(arg_232_0)
			local var_232_0 = arg_229_1.actors_["1148"]
			local var_232_1 = 0

			if var_232_1 < arg_229_1.time_ and arg_229_1.time_ <= var_232_1 + arg_232_0 and not isNil(var_232_0) and arg_229_1.var_.actorSpriteComps1148 == nil then
				arg_229_1.var_.actorSpriteComps1148 = var_232_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_232_2 = 0.125

			if var_232_1 <= arg_229_1.time_ and arg_229_1.time_ < var_232_1 + var_232_2 and not isNil(var_232_0) then
				local var_232_3 = (arg_229_1.time_ - var_232_1) / var_232_2

				if arg_229_1.var_.actorSpriteComps1148 then
					for iter_232_0, iter_232_1 in pairs(arg_229_1.var_.actorSpriteComps1148:ToTable()) do
						if iter_232_1 then
							if arg_229_1.isInRecall_ then
								local var_232_4 = Mathf.Lerp(iter_232_1.color.r, arg_229_1.hightColor1.r, var_232_3)
								local var_232_5 = Mathf.Lerp(iter_232_1.color.g, arg_229_1.hightColor1.g, var_232_3)
								local var_232_6 = Mathf.Lerp(iter_232_1.color.b, arg_229_1.hightColor1.b, var_232_3)

								iter_232_1.color = Color.New(var_232_4, var_232_5, var_232_6)
							else
								local var_232_7 = Mathf.Lerp(iter_232_1.color.r, 1, var_232_3)

								iter_232_1.color = Color.New(var_232_7, var_232_7, var_232_7)
							end
						end
					end
				end
			end

			if arg_229_1.time_ >= var_232_1 + var_232_2 and arg_229_1.time_ < var_232_1 + var_232_2 + arg_232_0 and not isNil(var_232_0) and arg_229_1.var_.actorSpriteComps1148 then
				for iter_232_2, iter_232_3 in pairs(arg_229_1.var_.actorSpriteComps1148:ToTable()) do
					if iter_232_3 then
						if arg_229_1.isInRecall_ then
							iter_232_3.color = arg_229_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_232_3.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_229_1.var_.actorSpriteComps1148 = nil
			end

			local var_232_8 = arg_229_1.actors_["10108"]
			local var_232_9 = 0

			if var_232_9 < arg_229_1.time_ and arg_229_1.time_ <= var_232_9 + arg_232_0 and not isNil(var_232_8) and arg_229_1.var_.actorSpriteComps10108 == nil then
				arg_229_1.var_.actorSpriteComps10108 = var_232_8:GetComponentsInChildren(typeof(Image), true)
			end

			local var_232_10 = 0.125

			if var_232_9 <= arg_229_1.time_ and arg_229_1.time_ < var_232_9 + var_232_10 and not isNil(var_232_8) then
				local var_232_11 = (arg_229_1.time_ - var_232_9) / var_232_10

				if arg_229_1.var_.actorSpriteComps10108 then
					for iter_232_4, iter_232_5 in pairs(arg_229_1.var_.actorSpriteComps10108:ToTable()) do
						if iter_232_5 then
							if arg_229_1.isInRecall_ then
								local var_232_12 = Mathf.Lerp(iter_232_5.color.r, arg_229_1.hightColor2.r, var_232_11)
								local var_232_13 = Mathf.Lerp(iter_232_5.color.g, arg_229_1.hightColor2.g, var_232_11)
								local var_232_14 = Mathf.Lerp(iter_232_5.color.b, arg_229_1.hightColor2.b, var_232_11)

								iter_232_5.color = Color.New(var_232_12, var_232_13, var_232_14)
							else
								local var_232_15 = Mathf.Lerp(iter_232_5.color.r, 0.5, var_232_11)

								iter_232_5.color = Color.New(var_232_15, var_232_15, var_232_15)
							end
						end
					end
				end
			end

			if arg_229_1.time_ >= var_232_9 + var_232_10 and arg_229_1.time_ < var_232_9 + var_232_10 + arg_232_0 and not isNil(var_232_8) and arg_229_1.var_.actorSpriteComps10108 then
				for iter_232_6, iter_232_7 in pairs(arg_229_1.var_.actorSpriteComps10108:ToTable()) do
					if iter_232_7 then
						if arg_229_1.isInRecall_ then
							iter_232_7.color = arg_229_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_232_7.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_229_1.var_.actorSpriteComps10108 = nil
			end

			local var_232_16 = arg_229_1.actors_["1148"].transform
			local var_232_17 = 0

			if var_232_17 < arg_229_1.time_ and arg_229_1.time_ <= var_232_17 + arg_232_0 then
				arg_229_1.var_.moveOldPos1148 = var_232_16.localPosition
				var_232_16.localScale = Vector3.New(1, 1, 1)

				arg_229_1:CheckSpriteTmpPos("1148", 2)

				local var_232_18 = var_232_16.childCount

				for iter_232_8 = 0, var_232_18 - 1 do
					local var_232_19 = var_232_16:GetChild(iter_232_8)

					if var_232_19.name == "split_1_1" or not string.find(var_232_19.name, "split") then
						var_232_19.gameObject:SetActive(true)
					else
						var_232_19.gameObject:SetActive(false)
					end
				end
			end

			local var_232_20 = 0.001

			if var_232_17 <= arg_229_1.time_ and arg_229_1.time_ < var_232_17 + var_232_20 then
				local var_232_21 = (arg_229_1.time_ - var_232_17) / var_232_20
				local var_232_22 = Vector3.New(-390, -429, -180)

				var_232_16.localPosition = Vector3.Lerp(arg_229_1.var_.moveOldPos1148, var_232_22, var_232_21)
			end

			if arg_229_1.time_ >= var_232_17 + var_232_20 and arg_229_1.time_ < var_232_17 + var_232_20 + arg_232_0 then
				var_232_16.localPosition = Vector3.New(-390, -429, -180)
			end

			local var_232_23 = 0
			local var_232_24 = 0.4

			if var_232_23 < arg_229_1.time_ and arg_229_1.time_ <= var_232_23 + arg_232_0 then
				arg_229_1.talkMaxDuration = 0
				arg_229_1.dialogCg_.alpha = 1

				arg_229_1.dialog_:SetActive(true)
				SetActive(arg_229_1.leftNameGo_, true)

				local var_232_25 = arg_229_1:FormatText(StoryNameCfg[8].name)

				arg_229_1.leftNameTxt_.text = var_232_25

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_229_1.leftNameTxt_.transform)

				arg_229_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_229_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_229_1:RecordName(arg_229_1.leftNameTxt_.text)
				SetActive(arg_229_1.iconTrs_.gameObject, false)
				arg_229_1.callingController_:SetSelectedState("normal")

				local var_232_26 = arg_229_1:GetWordFromCfg(416071056)
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

				if manager.audio:GetVoiceLength("story_v_out_416071", "416071056", "story_v_out_416071.awb") ~= 0 then
					local var_232_31 = manager.audio:GetVoiceLength("story_v_out_416071", "416071056", "story_v_out_416071.awb") / 1000

					if var_232_31 + var_232_23 > arg_229_1.duration_ then
						arg_229_1.duration_ = var_232_31 + var_232_23
					end

					if var_232_26.prefab_name ~= "" and arg_229_1.actors_[var_232_26.prefab_name] ~= nil then
						local var_232_32 = LuaForUtil.PlayVoiceWithCriLipsync(arg_229_1.actors_[var_232_26.prefab_name].transform, "story_v_out_416071", "416071056", "story_v_out_416071.awb")

						arg_229_1:RecordAudio("416071056", var_232_32)
						arg_229_1:RecordAudio("416071056", var_232_32)
					else
						arg_229_1:AudioAction("play", "voice", "story_v_out_416071", "416071056", "story_v_out_416071.awb")
					end

					arg_229_1:RecordHistoryTalkVoice("story_v_out_416071", "416071056", "story_v_out_416071.awb")
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
				actorName = "1148",
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
	Play416071057 = function(arg_233_0, arg_233_1)
		arg_233_1.time_ = 0
		arg_233_1.frameCnt_ = 0
		arg_233_1.state_ = "playing"
		arg_233_1.curTalkId_ = 416071057
		arg_233_1.duration_ = 21.93

		local var_233_0 = {
			zh = 8.033,
			ja = 21.933
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
				arg_233_0:Play416071058(arg_233_1)
			end
		end

		function arg_233_1.onSingleLineUpdate_(arg_236_0)
			local var_236_0 = arg_233_1.actors_["1148"]
			local var_236_1 = 0

			if var_236_1 < arg_233_1.time_ and arg_233_1.time_ <= var_236_1 + arg_236_0 and not isNil(var_236_0) and arg_233_1.var_.actorSpriteComps1148 == nil then
				arg_233_1.var_.actorSpriteComps1148 = var_236_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_236_2 = 0.125

			if var_236_1 <= arg_233_1.time_ and arg_233_1.time_ < var_236_1 + var_236_2 and not isNil(var_236_0) then
				local var_236_3 = (arg_233_1.time_ - var_236_1) / var_236_2

				if arg_233_1.var_.actorSpriteComps1148 then
					for iter_236_0, iter_236_1 in pairs(arg_233_1.var_.actorSpriteComps1148:ToTable()) do
						if iter_236_1 then
							if arg_233_1.isInRecall_ then
								local var_236_4 = Mathf.Lerp(iter_236_1.color.r, arg_233_1.hightColor2.r, var_236_3)
								local var_236_5 = Mathf.Lerp(iter_236_1.color.g, arg_233_1.hightColor2.g, var_236_3)
								local var_236_6 = Mathf.Lerp(iter_236_1.color.b, arg_233_1.hightColor2.b, var_236_3)

								iter_236_1.color = Color.New(var_236_4, var_236_5, var_236_6)
							else
								local var_236_7 = Mathf.Lerp(iter_236_1.color.r, 0.5, var_236_3)

								iter_236_1.color = Color.New(var_236_7, var_236_7, var_236_7)
							end
						end
					end
				end
			end

			if arg_233_1.time_ >= var_236_1 + var_236_2 and arg_233_1.time_ < var_236_1 + var_236_2 + arg_236_0 and not isNil(var_236_0) and arg_233_1.var_.actorSpriteComps1148 then
				for iter_236_2, iter_236_3 in pairs(arg_233_1.var_.actorSpriteComps1148:ToTable()) do
					if iter_236_3 then
						if arg_233_1.isInRecall_ then
							iter_236_3.color = arg_233_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_236_3.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_233_1.var_.actorSpriteComps1148 = nil
			end

			local var_236_8 = arg_233_1.actors_["10108"]
			local var_236_9 = 0

			if var_236_9 < arg_233_1.time_ and arg_233_1.time_ <= var_236_9 + arg_236_0 and not isNil(var_236_8) and arg_233_1.var_.actorSpriteComps10108 == nil then
				arg_233_1.var_.actorSpriteComps10108 = var_236_8:GetComponentsInChildren(typeof(Image), true)
			end

			local var_236_10 = 0.125

			if var_236_9 <= arg_233_1.time_ and arg_233_1.time_ < var_236_9 + var_236_10 and not isNil(var_236_8) then
				local var_236_11 = (arg_233_1.time_ - var_236_9) / var_236_10

				if arg_233_1.var_.actorSpriteComps10108 then
					for iter_236_4, iter_236_5 in pairs(arg_233_1.var_.actorSpriteComps10108:ToTable()) do
						if iter_236_5 then
							if arg_233_1.isInRecall_ then
								local var_236_12 = Mathf.Lerp(iter_236_5.color.r, arg_233_1.hightColor1.r, var_236_11)
								local var_236_13 = Mathf.Lerp(iter_236_5.color.g, arg_233_1.hightColor1.g, var_236_11)
								local var_236_14 = Mathf.Lerp(iter_236_5.color.b, arg_233_1.hightColor1.b, var_236_11)

								iter_236_5.color = Color.New(var_236_12, var_236_13, var_236_14)
							else
								local var_236_15 = Mathf.Lerp(iter_236_5.color.r, 1, var_236_11)

								iter_236_5.color = Color.New(var_236_15, var_236_15, var_236_15)
							end
						end
					end
				end
			end

			if arg_233_1.time_ >= var_236_9 + var_236_10 and arg_233_1.time_ < var_236_9 + var_236_10 + arg_236_0 and not isNil(var_236_8) and arg_233_1.var_.actorSpriteComps10108 then
				for iter_236_6, iter_236_7 in pairs(arg_233_1.var_.actorSpriteComps10108:ToTable()) do
					if iter_236_7 then
						if arg_233_1.isInRecall_ then
							iter_236_7.color = arg_233_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_236_7.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_233_1.var_.actorSpriteComps10108 = nil
			end

			local var_236_16 = 0
			local var_236_17 = 0.8

			if var_236_16 < arg_233_1.time_ and arg_233_1.time_ <= var_236_16 + arg_236_0 then
				arg_233_1.talkMaxDuration = 0
				arg_233_1.dialogCg_.alpha = 1

				arg_233_1.dialog_:SetActive(true)
				SetActive(arg_233_1.leftNameGo_, true)

				local var_236_18 = arg_233_1:FormatText(StoryNameCfg[1083].name)

				arg_233_1.leftNameTxt_.text = var_236_18

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_233_1.leftNameTxt_.transform)

				arg_233_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_233_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_233_1:RecordName(arg_233_1.leftNameTxt_.text)
				SetActive(arg_233_1.iconTrs_.gameObject, false)
				arg_233_1.callingController_:SetSelectedState("normal")

				local var_236_19 = arg_233_1:GetWordFromCfg(416071057)
				local var_236_20 = arg_233_1:FormatText(var_236_19.content)

				arg_233_1.text_.text = var_236_20

				LuaForUtil.ClearLinePrefixSymbol(arg_233_1.text_)

				local var_236_21 = 31
				local var_236_22 = utf8.len(var_236_20)
				local var_236_23 = var_236_21 <= 0 and var_236_17 or var_236_17 * (var_236_22 / var_236_21)

				if var_236_23 > 0 and var_236_17 < var_236_23 then
					arg_233_1.talkMaxDuration = var_236_23

					if var_236_23 + var_236_16 > arg_233_1.duration_ then
						arg_233_1.duration_ = var_236_23 + var_236_16
					end
				end

				arg_233_1.text_.text = var_236_20
				arg_233_1.typewritter.percent = 0

				arg_233_1.typewritter:SetDirty()
				arg_233_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_416071", "416071057", "story_v_out_416071.awb") ~= 0 then
					local var_236_24 = manager.audio:GetVoiceLength("story_v_out_416071", "416071057", "story_v_out_416071.awb") / 1000

					if var_236_24 + var_236_16 > arg_233_1.duration_ then
						arg_233_1.duration_ = var_236_24 + var_236_16
					end

					if var_236_19.prefab_name ~= "" and arg_233_1.actors_[var_236_19.prefab_name] ~= nil then
						local var_236_25 = LuaForUtil.PlayVoiceWithCriLipsync(arg_233_1.actors_[var_236_19.prefab_name].transform, "story_v_out_416071", "416071057", "story_v_out_416071.awb")

						arg_233_1:RecordAudio("416071057", var_236_25)
						arg_233_1:RecordAudio("416071057", var_236_25)
					else
						arg_233_1:AudioAction("play", "voice", "story_v_out_416071", "416071057", "story_v_out_416071.awb")
					end

					arg_233_1:RecordHistoryTalkVoice("story_v_out_416071", "416071057", "story_v_out_416071.awb")
				end

				arg_233_1:RecordContent(arg_233_1.text_.text)
			end

			local var_236_26 = math.max(var_236_17, arg_233_1.talkMaxDuration)

			if var_236_16 <= arg_233_1.time_ and arg_233_1.time_ < var_236_16 + var_236_26 then
				arg_233_1.typewritter.percent = (arg_233_1.time_ - var_236_16) / var_236_26

				arg_233_1.typewritter:SetDirty()
			end

			if arg_233_1.time_ >= var_236_16 + var_236_26 and arg_233_1.time_ < var_236_16 + var_236_26 + arg_236_0 then
				arg_233_1.typewritter.percent = 1

				arg_233_1.typewritter:SetDirty()
				arg_233_1:ShowNextGo(true)
			end
		end

		arg_233_1.nodeConfigList_ = {}

		arg_233_1:InitPlayNodeList()
	end,
	Play416071058 = function(arg_237_0, arg_237_1)
		arg_237_1.time_ = 0
		arg_237_1.frameCnt_ = 0
		arg_237_1.state_ = "playing"
		arg_237_1.curTalkId_ = 416071058
		arg_237_1.duration_ = 17.2

		local var_237_0 = {
			zh = 9.7,
			ja = 17.2
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
				arg_237_0:Play416071059(arg_237_1)
			end
		end

		function arg_237_1.onSingleLineUpdate_(arg_240_0)
			local var_240_0 = 0
			local var_240_1 = 0.95

			if var_240_0 < arg_237_1.time_ and arg_237_1.time_ <= var_240_0 + arg_240_0 then
				arg_237_1.talkMaxDuration = 0
				arg_237_1.dialogCg_.alpha = 1

				arg_237_1.dialog_:SetActive(true)
				SetActive(arg_237_1.leftNameGo_, true)

				local var_240_2 = arg_237_1:FormatText(StoryNameCfg[1083].name)

				arg_237_1.leftNameTxt_.text = var_240_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_237_1.leftNameTxt_.transform)

				arg_237_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_237_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_237_1:RecordName(arg_237_1.leftNameTxt_.text)
				SetActive(arg_237_1.iconTrs_.gameObject, false)
				arg_237_1.callingController_:SetSelectedState("normal")

				local var_240_3 = arg_237_1:GetWordFromCfg(416071058)
				local var_240_4 = arg_237_1:FormatText(var_240_3.content)

				arg_237_1.text_.text = var_240_4

				LuaForUtil.ClearLinePrefixSymbol(arg_237_1.text_)

				local var_240_5 = 38
				local var_240_6 = utf8.len(var_240_4)
				local var_240_7 = var_240_5 <= 0 and var_240_1 or var_240_1 * (var_240_6 / var_240_5)

				if var_240_7 > 0 and var_240_1 < var_240_7 then
					arg_237_1.talkMaxDuration = var_240_7

					if var_240_7 + var_240_0 > arg_237_1.duration_ then
						arg_237_1.duration_ = var_240_7 + var_240_0
					end
				end

				arg_237_1.text_.text = var_240_4
				arg_237_1.typewritter.percent = 0

				arg_237_1.typewritter:SetDirty()
				arg_237_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_416071", "416071058", "story_v_out_416071.awb") ~= 0 then
					local var_240_8 = manager.audio:GetVoiceLength("story_v_out_416071", "416071058", "story_v_out_416071.awb") / 1000

					if var_240_8 + var_240_0 > arg_237_1.duration_ then
						arg_237_1.duration_ = var_240_8 + var_240_0
					end

					if var_240_3.prefab_name ~= "" and arg_237_1.actors_[var_240_3.prefab_name] ~= nil then
						local var_240_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_237_1.actors_[var_240_3.prefab_name].transform, "story_v_out_416071", "416071058", "story_v_out_416071.awb")

						arg_237_1:RecordAudio("416071058", var_240_9)
						arg_237_1:RecordAudio("416071058", var_240_9)
					else
						arg_237_1:AudioAction("play", "voice", "story_v_out_416071", "416071058", "story_v_out_416071.awb")
					end

					arg_237_1:RecordHistoryTalkVoice("story_v_out_416071", "416071058", "story_v_out_416071.awb")
				end

				arg_237_1:RecordContent(arg_237_1.text_.text)
			end

			local var_240_10 = math.max(var_240_1, arg_237_1.talkMaxDuration)

			if var_240_0 <= arg_237_1.time_ and arg_237_1.time_ < var_240_0 + var_240_10 then
				arg_237_1.typewritter.percent = (arg_237_1.time_ - var_240_0) / var_240_10

				arg_237_1.typewritter:SetDirty()
			end

			if arg_237_1.time_ >= var_240_0 + var_240_10 and arg_237_1.time_ < var_240_0 + var_240_10 + arg_240_0 then
				arg_237_1.typewritter.percent = 1

				arg_237_1.typewritter:SetDirty()
				arg_237_1:ShowNextGo(true)
			end
		end

		arg_237_1.nodeConfigList_ = {}

		arg_237_1:InitPlayNodeList()
	end,
	Play416071059 = function(arg_241_0, arg_241_1)
		arg_241_1.time_ = 0
		arg_241_1.frameCnt_ = 0
		arg_241_1.state_ = "playing"
		arg_241_1.curTalkId_ = 416071059
		arg_241_1.duration_ = 5.67

		local var_241_0 = {
			zh = 3.033,
			ja = 5.666
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
				arg_241_0:Play416071060(arg_241_1)
			end
		end

		function arg_241_1.onSingleLineUpdate_(arg_244_0)
			local var_244_0 = arg_241_1.actors_["1148"]
			local var_244_1 = 0

			if var_244_1 < arg_241_1.time_ and arg_241_1.time_ <= var_244_1 + arg_244_0 and not isNil(var_244_0) and arg_241_1.var_.actorSpriteComps1148 == nil then
				arg_241_1.var_.actorSpriteComps1148 = var_244_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_244_2 = 0.125

			if var_244_1 <= arg_241_1.time_ and arg_241_1.time_ < var_244_1 + var_244_2 and not isNil(var_244_0) then
				local var_244_3 = (arg_241_1.time_ - var_244_1) / var_244_2

				if arg_241_1.var_.actorSpriteComps1148 then
					for iter_244_0, iter_244_1 in pairs(arg_241_1.var_.actorSpriteComps1148:ToTable()) do
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

			if arg_241_1.time_ >= var_244_1 + var_244_2 and arg_241_1.time_ < var_244_1 + var_244_2 + arg_244_0 and not isNil(var_244_0) and arg_241_1.var_.actorSpriteComps1148 then
				for iter_244_2, iter_244_3 in pairs(arg_241_1.var_.actorSpriteComps1148:ToTable()) do
					if iter_244_3 then
						if arg_241_1.isInRecall_ then
							iter_244_3.color = arg_241_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_244_3.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_241_1.var_.actorSpriteComps1148 = nil
			end

			local var_244_8 = arg_241_1.actors_["10108"]
			local var_244_9 = 0

			if var_244_9 < arg_241_1.time_ and arg_241_1.time_ <= var_244_9 + arg_244_0 and not isNil(var_244_8) and arg_241_1.var_.actorSpriteComps10108 == nil then
				arg_241_1.var_.actorSpriteComps10108 = var_244_8:GetComponentsInChildren(typeof(Image), true)
			end

			local var_244_10 = 0.125

			if var_244_9 <= arg_241_1.time_ and arg_241_1.time_ < var_244_9 + var_244_10 and not isNil(var_244_8) then
				local var_244_11 = (arg_241_1.time_ - var_244_9) / var_244_10

				if arg_241_1.var_.actorSpriteComps10108 then
					for iter_244_4, iter_244_5 in pairs(arg_241_1.var_.actorSpriteComps10108:ToTable()) do
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

			if arg_241_1.time_ >= var_244_9 + var_244_10 and arg_241_1.time_ < var_244_9 + var_244_10 + arg_244_0 and not isNil(var_244_8) and arg_241_1.var_.actorSpriteComps10108 then
				for iter_244_6, iter_244_7 in pairs(arg_241_1.var_.actorSpriteComps10108:ToTable()) do
					if iter_244_7 then
						if arg_241_1.isInRecall_ then
							iter_244_7.color = arg_241_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_244_7.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_241_1.var_.actorSpriteComps10108 = nil
			end

			local var_244_16 = 0
			local var_244_17 = 0.375

			if var_244_16 < arg_241_1.time_ and arg_241_1.time_ <= var_244_16 + arg_244_0 then
				arg_241_1.talkMaxDuration = 0
				arg_241_1.dialogCg_.alpha = 1

				arg_241_1.dialog_:SetActive(true)
				SetActive(arg_241_1.leftNameGo_, true)

				local var_244_18 = arg_241_1:FormatText(StoryNameCfg[8].name)

				arg_241_1.leftNameTxt_.text = var_244_18

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_241_1.leftNameTxt_.transform)

				arg_241_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_241_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_241_1:RecordName(arg_241_1.leftNameTxt_.text)
				SetActive(arg_241_1.iconTrs_.gameObject, false)
				arg_241_1.callingController_:SetSelectedState("normal")

				local var_244_19 = arg_241_1:GetWordFromCfg(416071059)
				local var_244_20 = arg_241_1:FormatText(var_244_19.content)

				arg_241_1.text_.text = var_244_20

				LuaForUtil.ClearLinePrefixSymbol(arg_241_1.text_)

				local var_244_21 = 15
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

				if manager.audio:GetVoiceLength("story_v_out_416071", "416071059", "story_v_out_416071.awb") ~= 0 then
					local var_244_24 = manager.audio:GetVoiceLength("story_v_out_416071", "416071059", "story_v_out_416071.awb") / 1000

					if var_244_24 + var_244_16 > arg_241_1.duration_ then
						arg_241_1.duration_ = var_244_24 + var_244_16
					end

					if var_244_19.prefab_name ~= "" and arg_241_1.actors_[var_244_19.prefab_name] ~= nil then
						local var_244_25 = LuaForUtil.PlayVoiceWithCriLipsync(arg_241_1.actors_[var_244_19.prefab_name].transform, "story_v_out_416071", "416071059", "story_v_out_416071.awb")

						arg_241_1:RecordAudio("416071059", var_244_25)
						arg_241_1:RecordAudio("416071059", var_244_25)
					else
						arg_241_1:AudioAction("play", "voice", "story_v_out_416071", "416071059", "story_v_out_416071.awb")
					end

					arg_241_1:RecordHistoryTalkVoice("story_v_out_416071", "416071059", "story_v_out_416071.awb")
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
	Play416071060 = function(arg_245_0, arg_245_1)
		arg_245_1.time_ = 0
		arg_245_1.frameCnt_ = 0
		arg_245_1.state_ = "playing"
		arg_245_1.curTalkId_ = 416071060
		arg_245_1.duration_ = 13.23

		local var_245_0 = {
			zh = 6.766,
			ja = 13.233
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
				arg_245_0:Play416071061(arg_245_1)
			end
		end

		function arg_245_1.onSingleLineUpdate_(arg_248_0)
			local var_248_0 = arg_245_1.actors_["1148"]
			local var_248_1 = 0

			if var_248_1 < arg_245_1.time_ and arg_245_1.time_ <= var_248_1 + arg_248_0 and not isNil(var_248_0) and arg_245_1.var_.actorSpriteComps1148 == nil then
				arg_245_1.var_.actorSpriteComps1148 = var_248_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_248_2 = 0.125

			if var_248_1 <= arg_245_1.time_ and arg_245_1.time_ < var_248_1 + var_248_2 and not isNil(var_248_0) then
				local var_248_3 = (arg_245_1.time_ - var_248_1) / var_248_2

				if arg_245_1.var_.actorSpriteComps1148 then
					for iter_248_0, iter_248_1 in pairs(arg_245_1.var_.actorSpriteComps1148:ToTable()) do
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

			if arg_245_1.time_ >= var_248_1 + var_248_2 and arg_245_1.time_ < var_248_1 + var_248_2 + arg_248_0 and not isNil(var_248_0) and arg_245_1.var_.actorSpriteComps1148 then
				for iter_248_2, iter_248_3 in pairs(arg_245_1.var_.actorSpriteComps1148:ToTable()) do
					if iter_248_3 then
						if arg_245_1.isInRecall_ then
							iter_248_3.color = arg_245_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_248_3.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_245_1.var_.actorSpriteComps1148 = nil
			end

			local var_248_8 = arg_245_1.actors_["10108"]
			local var_248_9 = 0

			if var_248_9 < arg_245_1.time_ and arg_245_1.time_ <= var_248_9 + arg_248_0 and not isNil(var_248_8) and arg_245_1.var_.actorSpriteComps10108 == nil then
				arg_245_1.var_.actorSpriteComps10108 = var_248_8:GetComponentsInChildren(typeof(Image), true)
			end

			local var_248_10 = 0.125

			if var_248_9 <= arg_245_1.time_ and arg_245_1.time_ < var_248_9 + var_248_10 and not isNil(var_248_8) then
				local var_248_11 = (arg_245_1.time_ - var_248_9) / var_248_10

				if arg_245_1.var_.actorSpriteComps10108 then
					for iter_248_4, iter_248_5 in pairs(arg_245_1.var_.actorSpriteComps10108:ToTable()) do
						if iter_248_5 then
							if arg_245_1.isInRecall_ then
								local var_248_12 = Mathf.Lerp(iter_248_5.color.r, arg_245_1.hightColor1.r, var_248_11)
								local var_248_13 = Mathf.Lerp(iter_248_5.color.g, arg_245_1.hightColor1.g, var_248_11)
								local var_248_14 = Mathf.Lerp(iter_248_5.color.b, arg_245_1.hightColor1.b, var_248_11)

								iter_248_5.color = Color.New(var_248_12, var_248_13, var_248_14)
							else
								local var_248_15 = Mathf.Lerp(iter_248_5.color.r, 1, var_248_11)

								iter_248_5.color = Color.New(var_248_15, var_248_15, var_248_15)
							end
						end
					end
				end
			end

			if arg_245_1.time_ >= var_248_9 + var_248_10 and arg_245_1.time_ < var_248_9 + var_248_10 + arg_248_0 and not isNil(var_248_8) and arg_245_1.var_.actorSpriteComps10108 then
				for iter_248_6, iter_248_7 in pairs(arg_245_1.var_.actorSpriteComps10108:ToTable()) do
					if iter_248_7 then
						if arg_245_1.isInRecall_ then
							iter_248_7.color = arg_245_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_248_7.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_245_1.var_.actorSpriteComps10108 = nil
			end

			local var_248_16 = 0
			local var_248_17 = 0.65

			if var_248_16 < arg_245_1.time_ and arg_245_1.time_ <= var_248_16 + arg_248_0 then
				arg_245_1.talkMaxDuration = 0
				arg_245_1.dialogCg_.alpha = 1

				arg_245_1.dialog_:SetActive(true)
				SetActive(arg_245_1.leftNameGo_, true)

				local var_248_18 = arg_245_1:FormatText(StoryNameCfg[1083].name)

				arg_245_1.leftNameTxt_.text = var_248_18

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_245_1.leftNameTxt_.transform)

				arg_245_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_245_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_245_1:RecordName(arg_245_1.leftNameTxt_.text)
				SetActive(arg_245_1.iconTrs_.gameObject, false)
				arg_245_1.callingController_:SetSelectedState("normal")

				local var_248_19 = arg_245_1:GetWordFromCfg(416071060)
				local var_248_20 = arg_245_1:FormatText(var_248_19.content)

				arg_245_1.text_.text = var_248_20

				LuaForUtil.ClearLinePrefixSymbol(arg_245_1.text_)

				local var_248_21 = 26
				local var_248_22 = utf8.len(var_248_20)
				local var_248_23 = var_248_21 <= 0 and var_248_17 or var_248_17 * (var_248_22 / var_248_21)

				if var_248_23 > 0 and var_248_17 < var_248_23 then
					arg_245_1.talkMaxDuration = var_248_23

					if var_248_23 + var_248_16 > arg_245_1.duration_ then
						arg_245_1.duration_ = var_248_23 + var_248_16
					end
				end

				arg_245_1.text_.text = var_248_20
				arg_245_1.typewritter.percent = 0

				arg_245_1.typewritter:SetDirty()
				arg_245_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_416071", "416071060", "story_v_out_416071.awb") ~= 0 then
					local var_248_24 = manager.audio:GetVoiceLength("story_v_out_416071", "416071060", "story_v_out_416071.awb") / 1000

					if var_248_24 + var_248_16 > arg_245_1.duration_ then
						arg_245_1.duration_ = var_248_24 + var_248_16
					end

					if var_248_19.prefab_name ~= "" and arg_245_1.actors_[var_248_19.prefab_name] ~= nil then
						local var_248_25 = LuaForUtil.PlayVoiceWithCriLipsync(arg_245_1.actors_[var_248_19.prefab_name].transform, "story_v_out_416071", "416071060", "story_v_out_416071.awb")

						arg_245_1:RecordAudio("416071060", var_248_25)
						arg_245_1:RecordAudio("416071060", var_248_25)
					else
						arg_245_1:AudioAction("play", "voice", "story_v_out_416071", "416071060", "story_v_out_416071.awb")
					end

					arg_245_1:RecordHistoryTalkVoice("story_v_out_416071", "416071060", "story_v_out_416071.awb")
				end

				arg_245_1:RecordContent(arg_245_1.text_.text)
			end

			local var_248_26 = math.max(var_248_17, arg_245_1.talkMaxDuration)

			if var_248_16 <= arg_245_1.time_ and arg_245_1.time_ < var_248_16 + var_248_26 then
				arg_245_1.typewritter.percent = (arg_245_1.time_ - var_248_16) / var_248_26

				arg_245_1.typewritter:SetDirty()
			end

			if arg_245_1.time_ >= var_248_16 + var_248_26 and arg_245_1.time_ < var_248_16 + var_248_26 + arg_248_0 then
				arg_245_1.typewritter.percent = 1

				arg_245_1.typewritter:SetDirty()
				arg_245_1:ShowNextGo(true)
			end
		end

		arg_245_1.nodeConfigList_ = {}

		arg_245_1:InitPlayNodeList()
	end,
	Play416071061 = function(arg_249_0, arg_249_1)
		arg_249_1.time_ = 0
		arg_249_1.frameCnt_ = 0
		arg_249_1.state_ = "playing"
		arg_249_1.curTalkId_ = 416071061
		arg_249_1.duration_ = 15.8

		local var_249_0 = {
			zh = 7.966,
			ja = 15.8
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
				arg_249_0:Play416071062(arg_249_1)
			end
		end

		function arg_249_1.onSingleLineUpdate_(arg_252_0)
			local var_252_0 = 0
			local var_252_1 = 0.65

			if var_252_0 < arg_249_1.time_ and arg_249_1.time_ <= var_252_0 + arg_252_0 then
				arg_249_1.talkMaxDuration = 0
				arg_249_1.dialogCg_.alpha = 1

				arg_249_1.dialog_:SetActive(true)
				SetActive(arg_249_1.leftNameGo_, true)

				local var_252_2 = arg_249_1:FormatText(StoryNameCfg[1083].name)

				arg_249_1.leftNameTxt_.text = var_252_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_249_1.leftNameTxt_.transform)

				arg_249_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_249_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_249_1:RecordName(arg_249_1.leftNameTxt_.text)
				SetActive(arg_249_1.iconTrs_.gameObject, false)
				arg_249_1.callingController_:SetSelectedState("normal")

				local var_252_3 = arg_249_1:GetWordFromCfg(416071061)
				local var_252_4 = arg_249_1:FormatText(var_252_3.content)

				arg_249_1.text_.text = var_252_4

				LuaForUtil.ClearLinePrefixSymbol(arg_249_1.text_)

				local var_252_5 = 26
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

				if manager.audio:GetVoiceLength("story_v_out_416071", "416071061", "story_v_out_416071.awb") ~= 0 then
					local var_252_8 = manager.audio:GetVoiceLength("story_v_out_416071", "416071061", "story_v_out_416071.awb") / 1000

					if var_252_8 + var_252_0 > arg_249_1.duration_ then
						arg_249_1.duration_ = var_252_8 + var_252_0
					end

					if var_252_3.prefab_name ~= "" and arg_249_1.actors_[var_252_3.prefab_name] ~= nil then
						local var_252_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_249_1.actors_[var_252_3.prefab_name].transform, "story_v_out_416071", "416071061", "story_v_out_416071.awb")

						arg_249_1:RecordAudio("416071061", var_252_9)
						arg_249_1:RecordAudio("416071061", var_252_9)
					else
						arg_249_1:AudioAction("play", "voice", "story_v_out_416071", "416071061", "story_v_out_416071.awb")
					end

					arg_249_1:RecordHistoryTalkVoice("story_v_out_416071", "416071061", "story_v_out_416071.awb")
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
	Play416071062 = function(arg_253_0, arg_253_1)
		arg_253_1.time_ = 0
		arg_253_1.frameCnt_ = 0
		arg_253_1.state_ = "playing"
		arg_253_1.curTalkId_ = 416071062
		arg_253_1.duration_ = 5.2

		local var_253_0 = {
			zh = 5.2,
			ja = 4.6
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
				arg_253_0:Play416071063(arg_253_1)
			end
		end

		function arg_253_1.onSingleLineUpdate_(arg_256_0)
			local var_256_0 = arg_253_1.actors_["1148"]
			local var_256_1 = 0

			if var_256_1 < arg_253_1.time_ and arg_253_1.time_ <= var_256_1 + arg_256_0 and not isNil(var_256_0) and arg_253_1.var_.actorSpriteComps1148 == nil then
				arg_253_1.var_.actorSpriteComps1148 = var_256_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_256_2 = 0.125

			if var_256_1 <= arg_253_1.time_ and arg_253_1.time_ < var_256_1 + var_256_2 and not isNil(var_256_0) then
				local var_256_3 = (arg_253_1.time_ - var_256_1) / var_256_2

				if arg_253_1.var_.actorSpriteComps1148 then
					for iter_256_0, iter_256_1 in pairs(arg_253_1.var_.actorSpriteComps1148:ToTable()) do
						if iter_256_1 then
							if arg_253_1.isInRecall_ then
								local var_256_4 = Mathf.Lerp(iter_256_1.color.r, arg_253_1.hightColor1.r, var_256_3)
								local var_256_5 = Mathf.Lerp(iter_256_1.color.g, arg_253_1.hightColor1.g, var_256_3)
								local var_256_6 = Mathf.Lerp(iter_256_1.color.b, arg_253_1.hightColor1.b, var_256_3)

								iter_256_1.color = Color.New(var_256_4, var_256_5, var_256_6)
							else
								local var_256_7 = Mathf.Lerp(iter_256_1.color.r, 1, var_256_3)

								iter_256_1.color = Color.New(var_256_7, var_256_7, var_256_7)
							end
						end
					end
				end
			end

			if arg_253_1.time_ >= var_256_1 + var_256_2 and arg_253_1.time_ < var_256_1 + var_256_2 + arg_256_0 and not isNil(var_256_0) and arg_253_1.var_.actorSpriteComps1148 then
				for iter_256_2, iter_256_3 in pairs(arg_253_1.var_.actorSpriteComps1148:ToTable()) do
					if iter_256_3 then
						if arg_253_1.isInRecall_ then
							iter_256_3.color = arg_253_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_256_3.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_253_1.var_.actorSpriteComps1148 = nil
			end

			local var_256_8 = arg_253_1.actors_["10108"]
			local var_256_9 = 0

			if var_256_9 < arg_253_1.time_ and arg_253_1.time_ <= var_256_9 + arg_256_0 and not isNil(var_256_8) and arg_253_1.var_.actorSpriteComps10108 == nil then
				arg_253_1.var_.actorSpriteComps10108 = var_256_8:GetComponentsInChildren(typeof(Image), true)
			end

			local var_256_10 = 0.125

			if var_256_9 <= arg_253_1.time_ and arg_253_1.time_ < var_256_9 + var_256_10 and not isNil(var_256_8) then
				local var_256_11 = (arg_253_1.time_ - var_256_9) / var_256_10

				if arg_253_1.var_.actorSpriteComps10108 then
					for iter_256_4, iter_256_5 in pairs(arg_253_1.var_.actorSpriteComps10108:ToTable()) do
						if iter_256_5 then
							if arg_253_1.isInRecall_ then
								local var_256_12 = Mathf.Lerp(iter_256_5.color.r, arg_253_1.hightColor2.r, var_256_11)
								local var_256_13 = Mathf.Lerp(iter_256_5.color.g, arg_253_1.hightColor2.g, var_256_11)
								local var_256_14 = Mathf.Lerp(iter_256_5.color.b, arg_253_1.hightColor2.b, var_256_11)

								iter_256_5.color = Color.New(var_256_12, var_256_13, var_256_14)
							else
								local var_256_15 = Mathf.Lerp(iter_256_5.color.r, 0.5, var_256_11)

								iter_256_5.color = Color.New(var_256_15, var_256_15, var_256_15)
							end
						end
					end
				end
			end

			if arg_253_1.time_ >= var_256_9 + var_256_10 and arg_253_1.time_ < var_256_9 + var_256_10 + arg_256_0 and not isNil(var_256_8) and arg_253_1.var_.actorSpriteComps10108 then
				for iter_256_6, iter_256_7 in pairs(arg_253_1.var_.actorSpriteComps10108:ToTable()) do
					if iter_256_7 then
						if arg_253_1.isInRecall_ then
							iter_256_7.color = arg_253_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_256_7.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_253_1.var_.actorSpriteComps10108 = nil
			end

			local var_256_16 = arg_253_1.actors_["1148"].transform
			local var_256_17 = 0

			if var_256_17 < arg_253_1.time_ and arg_253_1.time_ <= var_256_17 + arg_256_0 then
				arg_253_1.var_.moveOldPos1148 = var_256_16.localPosition
				var_256_16.localScale = Vector3.New(1, 1, 1)

				arg_253_1:CheckSpriteTmpPos("1148", 2)

				local var_256_18 = var_256_16.childCount

				for iter_256_8 = 0, var_256_18 - 1 do
					local var_256_19 = var_256_16:GetChild(iter_256_8)

					if var_256_19.name == "split_6" or not string.find(var_256_19.name, "split") then
						var_256_19.gameObject:SetActive(true)
					else
						var_256_19.gameObject:SetActive(false)
					end
				end
			end

			local var_256_20 = 0.001

			if var_256_17 <= arg_253_1.time_ and arg_253_1.time_ < var_256_17 + var_256_20 then
				local var_256_21 = (arg_253_1.time_ - var_256_17) / var_256_20
				local var_256_22 = Vector3.New(-390, -429, -180)

				var_256_16.localPosition = Vector3.Lerp(arg_253_1.var_.moveOldPos1148, var_256_22, var_256_21)
			end

			if arg_253_1.time_ >= var_256_17 + var_256_20 and arg_253_1.time_ < var_256_17 + var_256_20 + arg_256_0 then
				var_256_16.localPosition = Vector3.New(-390, -429, -180)
			end

			local var_256_23 = 0
			local var_256_24 = 0.525

			if var_256_23 < arg_253_1.time_ and arg_253_1.time_ <= var_256_23 + arg_256_0 then
				arg_253_1.talkMaxDuration = 0
				arg_253_1.dialogCg_.alpha = 1

				arg_253_1.dialog_:SetActive(true)
				SetActive(arg_253_1.leftNameGo_, true)

				local var_256_25 = arg_253_1:FormatText(StoryNameCfg[8].name)

				arg_253_1.leftNameTxt_.text = var_256_25

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_253_1.leftNameTxt_.transform)

				arg_253_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_253_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_253_1:RecordName(arg_253_1.leftNameTxt_.text)
				SetActive(arg_253_1.iconTrs_.gameObject, false)
				arg_253_1.callingController_:SetSelectedState("normal")

				local var_256_26 = arg_253_1:GetWordFromCfg(416071062)
				local var_256_27 = arg_253_1:FormatText(var_256_26.content)

				arg_253_1.text_.text = var_256_27

				LuaForUtil.ClearLinePrefixSymbol(arg_253_1.text_)

				local var_256_28 = 21
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

				if manager.audio:GetVoiceLength("story_v_out_416071", "416071062", "story_v_out_416071.awb") ~= 0 then
					local var_256_31 = manager.audio:GetVoiceLength("story_v_out_416071", "416071062", "story_v_out_416071.awb") / 1000

					if var_256_31 + var_256_23 > arg_253_1.duration_ then
						arg_253_1.duration_ = var_256_31 + var_256_23
					end

					if var_256_26.prefab_name ~= "" and arg_253_1.actors_[var_256_26.prefab_name] ~= nil then
						local var_256_32 = LuaForUtil.PlayVoiceWithCriLipsync(arg_253_1.actors_[var_256_26.prefab_name].transform, "story_v_out_416071", "416071062", "story_v_out_416071.awb")

						arg_253_1:RecordAudio("416071062", var_256_32)
						arg_253_1:RecordAudio("416071062", var_256_32)
					else
						arg_253_1:AudioAction("play", "voice", "story_v_out_416071", "416071062", "story_v_out_416071.awb")
					end

					arg_253_1:RecordHistoryTalkVoice("story_v_out_416071", "416071062", "story_v_out_416071.awb")
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
				actorName = "1148",
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
	Play416071063 = function(arg_257_0, arg_257_1)
		arg_257_1.time_ = 0
		arg_257_1.frameCnt_ = 0
		arg_257_1.state_ = "playing"
		arg_257_1.curTalkId_ = 416071063
		arg_257_1.duration_ = 15.57

		local var_257_0 = {
			zh = 6.766,
			ja = 15.566
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
				arg_257_0:Play416071064(arg_257_1)
			end
		end

		function arg_257_1.onSingleLineUpdate_(arg_260_0)
			local var_260_0 = arg_257_1.actors_["1148"]
			local var_260_1 = 0

			if var_260_1 < arg_257_1.time_ and arg_257_1.time_ <= var_260_1 + arg_260_0 and not isNil(var_260_0) and arg_257_1.var_.actorSpriteComps1148 == nil then
				arg_257_1.var_.actorSpriteComps1148 = var_260_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_260_2 = 0.125

			if var_260_1 <= arg_257_1.time_ and arg_257_1.time_ < var_260_1 + var_260_2 and not isNil(var_260_0) then
				local var_260_3 = (arg_257_1.time_ - var_260_1) / var_260_2

				if arg_257_1.var_.actorSpriteComps1148 then
					for iter_260_0, iter_260_1 in pairs(arg_257_1.var_.actorSpriteComps1148:ToTable()) do
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

			if arg_257_1.time_ >= var_260_1 + var_260_2 and arg_257_1.time_ < var_260_1 + var_260_2 + arg_260_0 and not isNil(var_260_0) and arg_257_1.var_.actorSpriteComps1148 then
				for iter_260_2, iter_260_3 in pairs(arg_257_1.var_.actorSpriteComps1148:ToTable()) do
					if iter_260_3 then
						if arg_257_1.isInRecall_ then
							iter_260_3.color = arg_257_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_260_3.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_257_1.var_.actorSpriteComps1148 = nil
			end

			local var_260_8 = arg_257_1.actors_["10108"]
			local var_260_9 = 0

			if var_260_9 < arg_257_1.time_ and arg_257_1.time_ <= var_260_9 + arg_260_0 and not isNil(var_260_8) and arg_257_1.var_.actorSpriteComps10108 == nil then
				arg_257_1.var_.actorSpriteComps10108 = var_260_8:GetComponentsInChildren(typeof(Image), true)
			end

			local var_260_10 = 0.125

			if var_260_9 <= arg_257_1.time_ and arg_257_1.time_ < var_260_9 + var_260_10 and not isNil(var_260_8) then
				local var_260_11 = (arg_257_1.time_ - var_260_9) / var_260_10

				if arg_257_1.var_.actorSpriteComps10108 then
					for iter_260_4, iter_260_5 in pairs(arg_257_1.var_.actorSpriteComps10108:ToTable()) do
						if iter_260_5 then
							if arg_257_1.isInRecall_ then
								local var_260_12 = Mathf.Lerp(iter_260_5.color.r, arg_257_1.hightColor1.r, var_260_11)
								local var_260_13 = Mathf.Lerp(iter_260_5.color.g, arg_257_1.hightColor1.g, var_260_11)
								local var_260_14 = Mathf.Lerp(iter_260_5.color.b, arg_257_1.hightColor1.b, var_260_11)

								iter_260_5.color = Color.New(var_260_12, var_260_13, var_260_14)
							else
								local var_260_15 = Mathf.Lerp(iter_260_5.color.r, 1, var_260_11)

								iter_260_5.color = Color.New(var_260_15, var_260_15, var_260_15)
							end
						end
					end
				end
			end

			if arg_257_1.time_ >= var_260_9 + var_260_10 and arg_257_1.time_ < var_260_9 + var_260_10 + arg_260_0 and not isNil(var_260_8) and arg_257_1.var_.actorSpriteComps10108 then
				for iter_260_6, iter_260_7 in pairs(arg_257_1.var_.actorSpriteComps10108:ToTable()) do
					if iter_260_7 then
						if arg_257_1.isInRecall_ then
							iter_260_7.color = arg_257_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_260_7.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_257_1.var_.actorSpriteComps10108 = nil
			end

			local var_260_16 = 0
			local var_260_17 = 0.65

			if var_260_16 < arg_257_1.time_ and arg_257_1.time_ <= var_260_16 + arg_260_0 then
				arg_257_1.talkMaxDuration = 0
				arg_257_1.dialogCg_.alpha = 1

				arg_257_1.dialog_:SetActive(true)
				SetActive(arg_257_1.leftNameGo_, true)

				local var_260_18 = arg_257_1:FormatText(StoryNameCfg[1083].name)

				arg_257_1.leftNameTxt_.text = var_260_18

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_257_1.leftNameTxt_.transform)

				arg_257_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_257_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_257_1:RecordName(arg_257_1.leftNameTxt_.text)
				SetActive(arg_257_1.iconTrs_.gameObject, false)
				arg_257_1.callingController_:SetSelectedState("normal")

				local var_260_19 = arg_257_1:GetWordFromCfg(416071063)
				local var_260_20 = arg_257_1:FormatText(var_260_19.content)

				arg_257_1.text_.text = var_260_20

				LuaForUtil.ClearLinePrefixSymbol(arg_257_1.text_)

				local var_260_21 = 26
				local var_260_22 = utf8.len(var_260_20)
				local var_260_23 = var_260_21 <= 0 and var_260_17 or var_260_17 * (var_260_22 / var_260_21)

				if var_260_23 > 0 and var_260_17 < var_260_23 then
					arg_257_1.talkMaxDuration = var_260_23

					if var_260_23 + var_260_16 > arg_257_1.duration_ then
						arg_257_1.duration_ = var_260_23 + var_260_16
					end
				end

				arg_257_1.text_.text = var_260_20
				arg_257_1.typewritter.percent = 0

				arg_257_1.typewritter:SetDirty()
				arg_257_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_416071", "416071063", "story_v_out_416071.awb") ~= 0 then
					local var_260_24 = manager.audio:GetVoiceLength("story_v_out_416071", "416071063", "story_v_out_416071.awb") / 1000

					if var_260_24 + var_260_16 > arg_257_1.duration_ then
						arg_257_1.duration_ = var_260_24 + var_260_16
					end

					if var_260_19.prefab_name ~= "" and arg_257_1.actors_[var_260_19.prefab_name] ~= nil then
						local var_260_25 = LuaForUtil.PlayVoiceWithCriLipsync(arg_257_1.actors_[var_260_19.prefab_name].transform, "story_v_out_416071", "416071063", "story_v_out_416071.awb")

						arg_257_1:RecordAudio("416071063", var_260_25)
						arg_257_1:RecordAudio("416071063", var_260_25)
					else
						arg_257_1:AudioAction("play", "voice", "story_v_out_416071", "416071063", "story_v_out_416071.awb")
					end

					arg_257_1:RecordHistoryTalkVoice("story_v_out_416071", "416071063", "story_v_out_416071.awb")
				end

				arg_257_1:RecordContent(arg_257_1.text_.text)
			end

			local var_260_26 = math.max(var_260_17, arg_257_1.talkMaxDuration)

			if var_260_16 <= arg_257_1.time_ and arg_257_1.time_ < var_260_16 + var_260_26 then
				arg_257_1.typewritter.percent = (arg_257_1.time_ - var_260_16) / var_260_26

				arg_257_1.typewritter:SetDirty()
			end

			if arg_257_1.time_ >= var_260_16 + var_260_26 and arg_257_1.time_ < var_260_16 + var_260_26 + arg_260_0 then
				arg_257_1.typewritter.percent = 1

				arg_257_1.typewritter:SetDirty()
				arg_257_1:ShowNextGo(true)
			end
		end

		arg_257_1.nodeConfigList_ = {}

		arg_257_1:InitPlayNodeList()
	end,
	Play416071064 = function(arg_261_0, arg_261_1)
		arg_261_1.time_ = 0
		arg_261_1.frameCnt_ = 0
		arg_261_1.state_ = "playing"
		arg_261_1.curTalkId_ = 416071064
		arg_261_1.duration_ = 10.87

		local var_261_0 = {
			zh = 6.433,
			ja = 10.866
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
				arg_261_0:Play416071065(arg_261_1)
			end
		end

		function arg_261_1.onSingleLineUpdate_(arg_264_0)
			local var_264_0 = 0
			local var_264_1 = 0.575

			if var_264_0 < arg_261_1.time_ and arg_261_1.time_ <= var_264_0 + arg_264_0 then
				arg_261_1.talkMaxDuration = 0
				arg_261_1.dialogCg_.alpha = 1

				arg_261_1.dialog_:SetActive(true)
				SetActive(arg_261_1.leftNameGo_, true)

				local var_264_2 = arg_261_1:FormatText(StoryNameCfg[1083].name)

				arg_261_1.leftNameTxt_.text = var_264_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_261_1.leftNameTxt_.transform)

				arg_261_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_261_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_261_1:RecordName(arg_261_1.leftNameTxt_.text)
				SetActive(arg_261_1.iconTrs_.gameObject, false)
				arg_261_1.callingController_:SetSelectedState("normal")

				local var_264_3 = arg_261_1:GetWordFromCfg(416071064)
				local var_264_4 = arg_261_1:FormatText(var_264_3.content)

				arg_261_1.text_.text = var_264_4

				LuaForUtil.ClearLinePrefixSymbol(arg_261_1.text_)

				local var_264_5 = 23
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

				if manager.audio:GetVoiceLength("story_v_out_416071", "416071064", "story_v_out_416071.awb") ~= 0 then
					local var_264_8 = manager.audio:GetVoiceLength("story_v_out_416071", "416071064", "story_v_out_416071.awb") / 1000

					if var_264_8 + var_264_0 > arg_261_1.duration_ then
						arg_261_1.duration_ = var_264_8 + var_264_0
					end

					if var_264_3.prefab_name ~= "" and arg_261_1.actors_[var_264_3.prefab_name] ~= nil then
						local var_264_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_261_1.actors_[var_264_3.prefab_name].transform, "story_v_out_416071", "416071064", "story_v_out_416071.awb")

						arg_261_1:RecordAudio("416071064", var_264_9)
						arg_261_1:RecordAudio("416071064", var_264_9)
					else
						arg_261_1:AudioAction("play", "voice", "story_v_out_416071", "416071064", "story_v_out_416071.awb")
					end

					arg_261_1:RecordHistoryTalkVoice("story_v_out_416071", "416071064", "story_v_out_416071.awb")
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
	Play416071065 = function(arg_265_0, arg_265_1)
		arg_265_1.time_ = 0
		arg_265_1.frameCnt_ = 0
		arg_265_1.state_ = "playing"
		arg_265_1.curTalkId_ = 416071065
		arg_265_1.duration_ = 9.8

		local var_265_0 = {
			zh = 6.866,
			ja = 9.8
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
				arg_265_0:Play416071066(arg_265_1)
			end
		end

		function arg_265_1.onSingleLineUpdate_(arg_268_0)
			local var_268_0 = 0
			local var_268_1 = 0.55

			if var_268_0 < arg_265_1.time_ and arg_265_1.time_ <= var_268_0 + arg_268_0 then
				arg_265_1.talkMaxDuration = 0
				arg_265_1.dialogCg_.alpha = 1

				arg_265_1.dialog_:SetActive(true)
				SetActive(arg_265_1.leftNameGo_, true)

				local var_268_2 = arg_265_1:FormatText(StoryNameCfg[1083].name)

				arg_265_1.leftNameTxt_.text = var_268_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_265_1.leftNameTxt_.transform)

				arg_265_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_265_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_265_1:RecordName(arg_265_1.leftNameTxt_.text)
				SetActive(arg_265_1.iconTrs_.gameObject, false)
				arg_265_1.callingController_:SetSelectedState("normal")

				local var_268_3 = arg_265_1:GetWordFromCfg(416071065)
				local var_268_4 = arg_265_1:FormatText(var_268_3.content)

				arg_265_1.text_.text = var_268_4

				LuaForUtil.ClearLinePrefixSymbol(arg_265_1.text_)

				local var_268_5 = 22
				local var_268_6 = utf8.len(var_268_4)
				local var_268_7 = var_268_5 <= 0 and var_268_1 or var_268_1 * (var_268_6 / var_268_5)

				if var_268_7 > 0 and var_268_1 < var_268_7 then
					arg_265_1.talkMaxDuration = var_268_7

					if var_268_7 + var_268_0 > arg_265_1.duration_ then
						arg_265_1.duration_ = var_268_7 + var_268_0
					end
				end

				arg_265_1.text_.text = var_268_4
				arg_265_1.typewritter.percent = 0

				arg_265_1.typewritter:SetDirty()
				arg_265_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_416071", "416071065", "story_v_out_416071.awb") ~= 0 then
					local var_268_8 = manager.audio:GetVoiceLength("story_v_out_416071", "416071065", "story_v_out_416071.awb") / 1000

					if var_268_8 + var_268_0 > arg_265_1.duration_ then
						arg_265_1.duration_ = var_268_8 + var_268_0
					end

					if var_268_3.prefab_name ~= "" and arg_265_1.actors_[var_268_3.prefab_name] ~= nil then
						local var_268_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_265_1.actors_[var_268_3.prefab_name].transform, "story_v_out_416071", "416071065", "story_v_out_416071.awb")

						arg_265_1:RecordAudio("416071065", var_268_9)
						arg_265_1:RecordAudio("416071065", var_268_9)
					else
						arg_265_1:AudioAction("play", "voice", "story_v_out_416071", "416071065", "story_v_out_416071.awb")
					end

					arg_265_1:RecordHistoryTalkVoice("story_v_out_416071", "416071065", "story_v_out_416071.awb")
				end

				arg_265_1:RecordContent(arg_265_1.text_.text)
			end

			local var_268_10 = math.max(var_268_1, arg_265_1.talkMaxDuration)

			if var_268_0 <= arg_265_1.time_ and arg_265_1.time_ < var_268_0 + var_268_10 then
				arg_265_1.typewritter.percent = (arg_265_1.time_ - var_268_0) / var_268_10

				arg_265_1.typewritter:SetDirty()
			end

			if arg_265_1.time_ >= var_268_0 + var_268_10 and arg_265_1.time_ < var_268_0 + var_268_10 + arg_268_0 then
				arg_265_1.typewritter.percent = 1

				arg_265_1.typewritter:SetDirty()
				arg_265_1:ShowNextGo(true)
			end
		end

		arg_265_1.nodeConfigList_ = {}

		arg_265_1:InitPlayNodeList()
	end,
	Play416071066 = function(arg_269_0, arg_269_1)
		arg_269_1.time_ = 0
		arg_269_1.frameCnt_ = 0
		arg_269_1.state_ = "playing"
		arg_269_1.curTalkId_ = 416071066
		arg_269_1.duration_ = 3.93

		local var_269_0 = {
			zh = 3.133,
			ja = 3.933
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
				arg_269_0:Play416071067(arg_269_1)
			end
		end

		function arg_269_1.onSingleLineUpdate_(arg_272_0)
			local var_272_0 = arg_269_1.actors_["1148"]
			local var_272_1 = 0

			if var_272_1 < arg_269_1.time_ and arg_269_1.time_ <= var_272_1 + arg_272_0 and not isNil(var_272_0) and arg_269_1.var_.actorSpriteComps1148 == nil then
				arg_269_1.var_.actorSpriteComps1148 = var_272_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_272_2 = 0.125

			if var_272_1 <= arg_269_1.time_ and arg_269_1.time_ < var_272_1 + var_272_2 and not isNil(var_272_0) then
				local var_272_3 = (arg_269_1.time_ - var_272_1) / var_272_2

				if arg_269_1.var_.actorSpriteComps1148 then
					for iter_272_0, iter_272_1 in pairs(arg_269_1.var_.actorSpriteComps1148:ToTable()) do
						if iter_272_1 then
							if arg_269_1.isInRecall_ then
								local var_272_4 = Mathf.Lerp(iter_272_1.color.r, arg_269_1.hightColor1.r, var_272_3)
								local var_272_5 = Mathf.Lerp(iter_272_1.color.g, arg_269_1.hightColor1.g, var_272_3)
								local var_272_6 = Mathf.Lerp(iter_272_1.color.b, arg_269_1.hightColor1.b, var_272_3)

								iter_272_1.color = Color.New(var_272_4, var_272_5, var_272_6)
							else
								local var_272_7 = Mathf.Lerp(iter_272_1.color.r, 1, var_272_3)

								iter_272_1.color = Color.New(var_272_7, var_272_7, var_272_7)
							end
						end
					end
				end
			end

			if arg_269_1.time_ >= var_272_1 + var_272_2 and arg_269_1.time_ < var_272_1 + var_272_2 + arg_272_0 and not isNil(var_272_0) and arg_269_1.var_.actorSpriteComps1148 then
				for iter_272_2, iter_272_3 in pairs(arg_269_1.var_.actorSpriteComps1148:ToTable()) do
					if iter_272_3 then
						if arg_269_1.isInRecall_ then
							iter_272_3.color = arg_269_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_272_3.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_269_1.var_.actorSpriteComps1148 = nil
			end

			local var_272_8 = arg_269_1.actors_["10108"]
			local var_272_9 = 0

			if var_272_9 < arg_269_1.time_ and arg_269_1.time_ <= var_272_9 + arg_272_0 and not isNil(var_272_8) and arg_269_1.var_.actorSpriteComps10108 == nil then
				arg_269_1.var_.actorSpriteComps10108 = var_272_8:GetComponentsInChildren(typeof(Image), true)
			end

			local var_272_10 = 0.125

			if var_272_9 <= arg_269_1.time_ and arg_269_1.time_ < var_272_9 + var_272_10 and not isNil(var_272_8) then
				local var_272_11 = (arg_269_1.time_ - var_272_9) / var_272_10

				if arg_269_1.var_.actorSpriteComps10108 then
					for iter_272_4, iter_272_5 in pairs(arg_269_1.var_.actorSpriteComps10108:ToTable()) do
						if iter_272_5 then
							if arg_269_1.isInRecall_ then
								local var_272_12 = Mathf.Lerp(iter_272_5.color.r, arg_269_1.hightColor2.r, var_272_11)
								local var_272_13 = Mathf.Lerp(iter_272_5.color.g, arg_269_1.hightColor2.g, var_272_11)
								local var_272_14 = Mathf.Lerp(iter_272_5.color.b, arg_269_1.hightColor2.b, var_272_11)

								iter_272_5.color = Color.New(var_272_12, var_272_13, var_272_14)
							else
								local var_272_15 = Mathf.Lerp(iter_272_5.color.r, 0.5, var_272_11)

								iter_272_5.color = Color.New(var_272_15, var_272_15, var_272_15)
							end
						end
					end
				end
			end

			if arg_269_1.time_ >= var_272_9 + var_272_10 and arg_269_1.time_ < var_272_9 + var_272_10 + arg_272_0 and not isNil(var_272_8) and arg_269_1.var_.actorSpriteComps10108 then
				for iter_272_6, iter_272_7 in pairs(arg_269_1.var_.actorSpriteComps10108:ToTable()) do
					if iter_272_7 then
						if arg_269_1.isInRecall_ then
							iter_272_7.color = arg_269_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_272_7.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_269_1.var_.actorSpriteComps10108 = nil
			end

			local var_272_16 = 0
			local var_272_17 = 0.375

			if var_272_16 < arg_269_1.time_ and arg_269_1.time_ <= var_272_16 + arg_272_0 then
				arg_269_1.talkMaxDuration = 0
				arg_269_1.dialogCg_.alpha = 1

				arg_269_1.dialog_:SetActive(true)
				SetActive(arg_269_1.leftNameGo_, true)

				local var_272_18 = arg_269_1:FormatText(StoryNameCfg[8].name)

				arg_269_1.leftNameTxt_.text = var_272_18

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_269_1.leftNameTxt_.transform)

				arg_269_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_269_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_269_1:RecordName(arg_269_1.leftNameTxt_.text)
				SetActive(arg_269_1.iconTrs_.gameObject, false)
				arg_269_1.callingController_:SetSelectedState("normal")

				local var_272_19 = arg_269_1:GetWordFromCfg(416071066)
				local var_272_20 = arg_269_1:FormatText(var_272_19.content)

				arg_269_1.text_.text = var_272_20

				LuaForUtil.ClearLinePrefixSymbol(arg_269_1.text_)

				local var_272_21 = 15
				local var_272_22 = utf8.len(var_272_20)
				local var_272_23 = var_272_21 <= 0 and var_272_17 or var_272_17 * (var_272_22 / var_272_21)

				if var_272_23 > 0 and var_272_17 < var_272_23 then
					arg_269_1.talkMaxDuration = var_272_23

					if var_272_23 + var_272_16 > arg_269_1.duration_ then
						arg_269_1.duration_ = var_272_23 + var_272_16
					end
				end

				arg_269_1.text_.text = var_272_20
				arg_269_1.typewritter.percent = 0

				arg_269_1.typewritter:SetDirty()
				arg_269_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_416071", "416071066", "story_v_out_416071.awb") ~= 0 then
					local var_272_24 = manager.audio:GetVoiceLength("story_v_out_416071", "416071066", "story_v_out_416071.awb") / 1000

					if var_272_24 + var_272_16 > arg_269_1.duration_ then
						arg_269_1.duration_ = var_272_24 + var_272_16
					end

					if var_272_19.prefab_name ~= "" and arg_269_1.actors_[var_272_19.prefab_name] ~= nil then
						local var_272_25 = LuaForUtil.PlayVoiceWithCriLipsync(arg_269_1.actors_[var_272_19.prefab_name].transform, "story_v_out_416071", "416071066", "story_v_out_416071.awb")

						arg_269_1:RecordAudio("416071066", var_272_25)
						arg_269_1:RecordAudio("416071066", var_272_25)
					else
						arg_269_1:AudioAction("play", "voice", "story_v_out_416071", "416071066", "story_v_out_416071.awb")
					end

					arg_269_1:RecordHistoryTalkVoice("story_v_out_416071", "416071066", "story_v_out_416071.awb")
				end

				arg_269_1:RecordContent(arg_269_1.text_.text)
			end

			local var_272_26 = math.max(var_272_17, arg_269_1.talkMaxDuration)

			if var_272_16 <= arg_269_1.time_ and arg_269_1.time_ < var_272_16 + var_272_26 then
				arg_269_1.typewritter.percent = (arg_269_1.time_ - var_272_16) / var_272_26

				arg_269_1.typewritter:SetDirty()
			end

			if arg_269_1.time_ >= var_272_16 + var_272_26 and arg_269_1.time_ < var_272_16 + var_272_26 + arg_272_0 then
				arg_269_1.typewritter.percent = 1

				arg_269_1.typewritter:SetDirty()
				arg_269_1:ShowNextGo(true)
			end
		end

		arg_269_1.nodeConfigList_ = {}

		arg_269_1:InitPlayNodeList()
	end,
	Play416071067 = function(arg_273_0, arg_273_1)
		arg_273_1.time_ = 0
		arg_273_1.frameCnt_ = 0
		arg_273_1.state_ = "playing"
		arg_273_1.curTalkId_ = 416071067
		arg_273_1.duration_ = 4.7

		local var_273_0 = {
			zh = 4.7,
			ja = 4
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
				arg_273_0:Play416071068(arg_273_1)
			end
		end

		function arg_273_1.onSingleLineUpdate_(arg_276_0)
			local var_276_0 = 0
			local var_276_1 = 0.525

			if var_276_0 < arg_273_1.time_ and arg_273_1.time_ <= var_276_0 + arg_276_0 then
				arg_273_1.talkMaxDuration = 0
				arg_273_1.dialogCg_.alpha = 1

				arg_273_1.dialog_:SetActive(true)
				SetActive(arg_273_1.leftNameGo_, true)

				local var_276_2 = arg_273_1:FormatText(StoryNameCfg[8].name)

				arg_273_1.leftNameTxt_.text = var_276_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_273_1.leftNameTxt_.transform)

				arg_273_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_273_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_273_1:RecordName(arg_273_1.leftNameTxt_.text)
				SetActive(arg_273_1.iconTrs_.gameObject, false)
				arg_273_1.callingController_:SetSelectedState("normal")

				local var_276_3 = arg_273_1:GetWordFromCfg(416071067)
				local var_276_4 = arg_273_1:FormatText(var_276_3.content)

				arg_273_1.text_.text = var_276_4

				LuaForUtil.ClearLinePrefixSymbol(arg_273_1.text_)

				local var_276_5 = 22
				local var_276_6 = utf8.len(var_276_4)
				local var_276_7 = var_276_5 <= 0 and var_276_1 or var_276_1 * (var_276_6 / var_276_5)

				if var_276_7 > 0 and var_276_1 < var_276_7 then
					arg_273_1.talkMaxDuration = var_276_7

					if var_276_7 + var_276_0 > arg_273_1.duration_ then
						arg_273_1.duration_ = var_276_7 + var_276_0
					end
				end

				arg_273_1.text_.text = var_276_4
				arg_273_1.typewritter.percent = 0

				arg_273_1.typewritter:SetDirty()
				arg_273_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_416071", "416071067", "story_v_out_416071.awb") ~= 0 then
					local var_276_8 = manager.audio:GetVoiceLength("story_v_out_416071", "416071067", "story_v_out_416071.awb") / 1000

					if var_276_8 + var_276_0 > arg_273_1.duration_ then
						arg_273_1.duration_ = var_276_8 + var_276_0
					end

					if var_276_3.prefab_name ~= "" and arg_273_1.actors_[var_276_3.prefab_name] ~= nil then
						local var_276_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_273_1.actors_[var_276_3.prefab_name].transform, "story_v_out_416071", "416071067", "story_v_out_416071.awb")

						arg_273_1:RecordAudio("416071067", var_276_9)
						arg_273_1:RecordAudio("416071067", var_276_9)
					else
						arg_273_1:AudioAction("play", "voice", "story_v_out_416071", "416071067", "story_v_out_416071.awb")
					end

					arg_273_1:RecordHistoryTalkVoice("story_v_out_416071", "416071067", "story_v_out_416071.awb")
				end

				arg_273_1:RecordContent(arg_273_1.text_.text)
			end

			local var_276_10 = math.max(var_276_1, arg_273_1.talkMaxDuration)

			if var_276_0 <= arg_273_1.time_ and arg_273_1.time_ < var_276_0 + var_276_10 then
				arg_273_1.typewritter.percent = (arg_273_1.time_ - var_276_0) / var_276_10

				arg_273_1.typewritter:SetDirty()
			end

			if arg_273_1.time_ >= var_276_0 + var_276_10 and arg_273_1.time_ < var_276_0 + var_276_10 + arg_276_0 then
				arg_273_1.typewritter.percent = 1

				arg_273_1.typewritter:SetDirty()
				arg_273_1:ShowNextGo(true)
			end
		end

		arg_273_1.nodeConfigList_ = {}

		arg_273_1:InitPlayNodeList()
	end,
	Play416071068 = function(arg_277_0, arg_277_1)
		arg_277_1.time_ = 0
		arg_277_1.frameCnt_ = 0
		arg_277_1.state_ = "playing"
		arg_277_1.curTalkId_ = 416071068
		arg_277_1.duration_ = 19.7

		local var_277_0 = {
			zh = 11.6,
			ja = 19.7
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
				arg_277_0:Play416071069(arg_277_1)
			end
		end

		function arg_277_1.onSingleLineUpdate_(arg_280_0)
			local var_280_0 = arg_277_1.actors_["1148"]
			local var_280_1 = 0

			if var_280_1 < arg_277_1.time_ and arg_277_1.time_ <= var_280_1 + arg_280_0 and not isNil(var_280_0) and arg_277_1.var_.actorSpriteComps1148 == nil then
				arg_277_1.var_.actorSpriteComps1148 = var_280_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_280_2 = 0.125

			if var_280_1 <= arg_277_1.time_ and arg_277_1.time_ < var_280_1 + var_280_2 and not isNil(var_280_0) then
				local var_280_3 = (arg_277_1.time_ - var_280_1) / var_280_2

				if arg_277_1.var_.actorSpriteComps1148 then
					for iter_280_0, iter_280_1 in pairs(arg_277_1.var_.actorSpriteComps1148:ToTable()) do
						if iter_280_1 then
							if arg_277_1.isInRecall_ then
								local var_280_4 = Mathf.Lerp(iter_280_1.color.r, arg_277_1.hightColor2.r, var_280_3)
								local var_280_5 = Mathf.Lerp(iter_280_1.color.g, arg_277_1.hightColor2.g, var_280_3)
								local var_280_6 = Mathf.Lerp(iter_280_1.color.b, arg_277_1.hightColor2.b, var_280_3)

								iter_280_1.color = Color.New(var_280_4, var_280_5, var_280_6)
							else
								local var_280_7 = Mathf.Lerp(iter_280_1.color.r, 0.5, var_280_3)

								iter_280_1.color = Color.New(var_280_7, var_280_7, var_280_7)
							end
						end
					end
				end
			end

			if arg_277_1.time_ >= var_280_1 + var_280_2 and arg_277_1.time_ < var_280_1 + var_280_2 + arg_280_0 and not isNil(var_280_0) and arg_277_1.var_.actorSpriteComps1148 then
				for iter_280_2, iter_280_3 in pairs(arg_277_1.var_.actorSpriteComps1148:ToTable()) do
					if iter_280_3 then
						if arg_277_1.isInRecall_ then
							iter_280_3.color = arg_277_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_280_3.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_277_1.var_.actorSpriteComps1148 = nil
			end

			local var_280_8 = arg_277_1.actors_["10108"]
			local var_280_9 = 0

			if var_280_9 < arg_277_1.time_ and arg_277_1.time_ <= var_280_9 + arg_280_0 and not isNil(var_280_8) and arg_277_1.var_.actorSpriteComps10108 == nil then
				arg_277_1.var_.actorSpriteComps10108 = var_280_8:GetComponentsInChildren(typeof(Image), true)
			end

			local var_280_10 = 0.125

			if var_280_9 <= arg_277_1.time_ and arg_277_1.time_ < var_280_9 + var_280_10 and not isNil(var_280_8) then
				local var_280_11 = (arg_277_1.time_ - var_280_9) / var_280_10

				if arg_277_1.var_.actorSpriteComps10108 then
					for iter_280_4, iter_280_5 in pairs(arg_277_1.var_.actorSpriteComps10108:ToTable()) do
						if iter_280_5 then
							if arg_277_1.isInRecall_ then
								local var_280_12 = Mathf.Lerp(iter_280_5.color.r, arg_277_1.hightColor1.r, var_280_11)
								local var_280_13 = Mathf.Lerp(iter_280_5.color.g, arg_277_1.hightColor1.g, var_280_11)
								local var_280_14 = Mathf.Lerp(iter_280_5.color.b, arg_277_1.hightColor1.b, var_280_11)

								iter_280_5.color = Color.New(var_280_12, var_280_13, var_280_14)
							else
								local var_280_15 = Mathf.Lerp(iter_280_5.color.r, 1, var_280_11)

								iter_280_5.color = Color.New(var_280_15, var_280_15, var_280_15)
							end
						end
					end
				end
			end

			if arg_277_1.time_ >= var_280_9 + var_280_10 and arg_277_1.time_ < var_280_9 + var_280_10 + arg_280_0 and not isNil(var_280_8) and arg_277_1.var_.actorSpriteComps10108 then
				for iter_280_6, iter_280_7 in pairs(arg_277_1.var_.actorSpriteComps10108:ToTable()) do
					if iter_280_7 then
						if arg_277_1.isInRecall_ then
							iter_280_7.color = arg_277_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_280_7.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_277_1.var_.actorSpriteComps10108 = nil
			end

			local var_280_16 = 0
			local var_280_17 = 1.025

			if var_280_16 < arg_277_1.time_ and arg_277_1.time_ <= var_280_16 + arg_280_0 then
				arg_277_1.talkMaxDuration = 0
				arg_277_1.dialogCg_.alpha = 1

				arg_277_1.dialog_:SetActive(true)
				SetActive(arg_277_1.leftNameGo_, true)

				local var_280_18 = arg_277_1:FormatText(StoryNameCfg[1083].name)

				arg_277_1.leftNameTxt_.text = var_280_18

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_277_1.leftNameTxt_.transform)

				arg_277_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_277_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_277_1:RecordName(arg_277_1.leftNameTxt_.text)
				SetActive(arg_277_1.iconTrs_.gameObject, false)
				arg_277_1.callingController_:SetSelectedState("normal")

				local var_280_19 = arg_277_1:GetWordFromCfg(416071068)
				local var_280_20 = arg_277_1:FormatText(var_280_19.content)

				arg_277_1.text_.text = var_280_20

				LuaForUtil.ClearLinePrefixSymbol(arg_277_1.text_)

				local var_280_21 = 42
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

				if manager.audio:GetVoiceLength("story_v_out_416071", "416071068", "story_v_out_416071.awb") ~= 0 then
					local var_280_24 = manager.audio:GetVoiceLength("story_v_out_416071", "416071068", "story_v_out_416071.awb") / 1000

					if var_280_24 + var_280_16 > arg_277_1.duration_ then
						arg_277_1.duration_ = var_280_24 + var_280_16
					end

					if var_280_19.prefab_name ~= "" and arg_277_1.actors_[var_280_19.prefab_name] ~= nil then
						local var_280_25 = LuaForUtil.PlayVoiceWithCriLipsync(arg_277_1.actors_[var_280_19.prefab_name].transform, "story_v_out_416071", "416071068", "story_v_out_416071.awb")

						arg_277_1:RecordAudio("416071068", var_280_25)
						arg_277_1:RecordAudio("416071068", var_280_25)
					else
						arg_277_1:AudioAction("play", "voice", "story_v_out_416071", "416071068", "story_v_out_416071.awb")
					end

					arg_277_1:RecordHistoryTalkVoice("story_v_out_416071", "416071068", "story_v_out_416071.awb")
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
	Play416071069 = function(arg_281_0, arg_281_1)
		arg_281_1.time_ = 0
		arg_281_1.frameCnt_ = 0
		arg_281_1.state_ = "playing"
		arg_281_1.curTalkId_ = 416071069
		arg_281_1.duration_ = 18.73

		local var_281_0 = {
			zh = 11.1,
			ja = 18.733
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
				arg_281_0:Play416071070(arg_281_1)
			end
		end

		function arg_281_1.onSingleLineUpdate_(arg_284_0)
			local var_284_0 = 0
			local var_284_1 = 1.075

			if var_284_0 < arg_281_1.time_ and arg_281_1.time_ <= var_284_0 + arg_284_0 then
				arg_281_1.talkMaxDuration = 0
				arg_281_1.dialogCg_.alpha = 1

				arg_281_1.dialog_:SetActive(true)
				SetActive(arg_281_1.leftNameGo_, true)

				local var_284_2 = arg_281_1:FormatText(StoryNameCfg[1083].name)

				arg_281_1.leftNameTxt_.text = var_284_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_281_1.leftNameTxt_.transform)

				arg_281_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_281_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_281_1:RecordName(arg_281_1.leftNameTxt_.text)
				SetActive(arg_281_1.iconTrs_.gameObject, false)
				arg_281_1.callingController_:SetSelectedState("normal")

				local var_284_3 = arg_281_1:GetWordFromCfg(416071069)
				local var_284_4 = arg_281_1:FormatText(var_284_3.content)

				arg_281_1.text_.text = var_284_4

				LuaForUtil.ClearLinePrefixSymbol(arg_281_1.text_)

				local var_284_5 = 43
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

				if manager.audio:GetVoiceLength("story_v_out_416071", "416071069", "story_v_out_416071.awb") ~= 0 then
					local var_284_8 = manager.audio:GetVoiceLength("story_v_out_416071", "416071069", "story_v_out_416071.awb") / 1000

					if var_284_8 + var_284_0 > arg_281_1.duration_ then
						arg_281_1.duration_ = var_284_8 + var_284_0
					end

					if var_284_3.prefab_name ~= "" and arg_281_1.actors_[var_284_3.prefab_name] ~= nil then
						local var_284_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_281_1.actors_[var_284_3.prefab_name].transform, "story_v_out_416071", "416071069", "story_v_out_416071.awb")

						arg_281_1:RecordAudio("416071069", var_284_9)
						arg_281_1:RecordAudio("416071069", var_284_9)
					else
						arg_281_1:AudioAction("play", "voice", "story_v_out_416071", "416071069", "story_v_out_416071.awb")
					end

					arg_281_1:RecordHistoryTalkVoice("story_v_out_416071", "416071069", "story_v_out_416071.awb")
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
	Play416071070 = function(arg_285_0, arg_285_1)
		arg_285_1.time_ = 0
		arg_285_1.frameCnt_ = 0
		arg_285_1.state_ = "playing"
		arg_285_1.curTalkId_ = 416071070
		arg_285_1.duration_ = 6.23

		local var_285_0 = {
			zh = 6.233,
			ja = 5.933
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
				arg_285_0:Play416071071(arg_285_1)
			end
		end

		function arg_285_1.onSingleLineUpdate_(arg_288_0)
			local var_288_0 = arg_285_1.actors_["1148"]
			local var_288_1 = 0

			if var_288_1 < arg_285_1.time_ and arg_285_1.time_ <= var_288_1 + arg_288_0 and not isNil(var_288_0) and arg_285_1.var_.actorSpriteComps1148 == nil then
				arg_285_1.var_.actorSpriteComps1148 = var_288_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_288_2 = 0.125

			if var_288_1 <= arg_285_1.time_ and arg_285_1.time_ < var_288_1 + var_288_2 and not isNil(var_288_0) then
				local var_288_3 = (arg_285_1.time_ - var_288_1) / var_288_2

				if arg_285_1.var_.actorSpriteComps1148 then
					for iter_288_0, iter_288_1 in pairs(arg_285_1.var_.actorSpriteComps1148:ToTable()) do
						if iter_288_1 then
							if arg_285_1.isInRecall_ then
								local var_288_4 = Mathf.Lerp(iter_288_1.color.r, arg_285_1.hightColor1.r, var_288_3)
								local var_288_5 = Mathf.Lerp(iter_288_1.color.g, arg_285_1.hightColor1.g, var_288_3)
								local var_288_6 = Mathf.Lerp(iter_288_1.color.b, arg_285_1.hightColor1.b, var_288_3)

								iter_288_1.color = Color.New(var_288_4, var_288_5, var_288_6)
							else
								local var_288_7 = Mathf.Lerp(iter_288_1.color.r, 1, var_288_3)

								iter_288_1.color = Color.New(var_288_7, var_288_7, var_288_7)
							end
						end
					end
				end
			end

			if arg_285_1.time_ >= var_288_1 + var_288_2 and arg_285_1.time_ < var_288_1 + var_288_2 + arg_288_0 and not isNil(var_288_0) and arg_285_1.var_.actorSpriteComps1148 then
				for iter_288_2, iter_288_3 in pairs(arg_285_1.var_.actorSpriteComps1148:ToTable()) do
					if iter_288_3 then
						if arg_285_1.isInRecall_ then
							iter_288_3.color = arg_285_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_288_3.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_285_1.var_.actorSpriteComps1148 = nil
			end

			local var_288_8 = arg_285_1.actors_["10108"]
			local var_288_9 = 0

			if var_288_9 < arg_285_1.time_ and arg_285_1.time_ <= var_288_9 + arg_288_0 and not isNil(var_288_8) and arg_285_1.var_.actorSpriteComps10108 == nil then
				arg_285_1.var_.actorSpriteComps10108 = var_288_8:GetComponentsInChildren(typeof(Image), true)
			end

			local var_288_10 = 0.125

			if var_288_9 <= arg_285_1.time_ and arg_285_1.time_ < var_288_9 + var_288_10 and not isNil(var_288_8) then
				local var_288_11 = (arg_285_1.time_ - var_288_9) / var_288_10

				if arg_285_1.var_.actorSpriteComps10108 then
					for iter_288_4, iter_288_5 in pairs(arg_285_1.var_.actorSpriteComps10108:ToTable()) do
						if iter_288_5 then
							if arg_285_1.isInRecall_ then
								local var_288_12 = Mathf.Lerp(iter_288_5.color.r, arg_285_1.hightColor2.r, var_288_11)
								local var_288_13 = Mathf.Lerp(iter_288_5.color.g, arg_285_1.hightColor2.g, var_288_11)
								local var_288_14 = Mathf.Lerp(iter_288_5.color.b, arg_285_1.hightColor2.b, var_288_11)

								iter_288_5.color = Color.New(var_288_12, var_288_13, var_288_14)
							else
								local var_288_15 = Mathf.Lerp(iter_288_5.color.r, 0.5, var_288_11)

								iter_288_5.color = Color.New(var_288_15, var_288_15, var_288_15)
							end
						end
					end
				end
			end

			if arg_285_1.time_ >= var_288_9 + var_288_10 and arg_285_1.time_ < var_288_9 + var_288_10 + arg_288_0 and not isNil(var_288_8) and arg_285_1.var_.actorSpriteComps10108 then
				for iter_288_6, iter_288_7 in pairs(arg_285_1.var_.actorSpriteComps10108:ToTable()) do
					if iter_288_7 then
						if arg_285_1.isInRecall_ then
							iter_288_7.color = arg_285_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_288_7.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_285_1.var_.actorSpriteComps10108 = nil
			end

			local var_288_16 = 0
			local var_288_17 = 0.8

			if var_288_16 < arg_285_1.time_ and arg_285_1.time_ <= var_288_16 + arg_288_0 then
				arg_285_1.talkMaxDuration = 0
				arg_285_1.dialogCg_.alpha = 1

				arg_285_1.dialog_:SetActive(true)
				SetActive(arg_285_1.leftNameGo_, true)

				local var_288_18 = arg_285_1:FormatText(StoryNameCfg[8].name)

				arg_285_1.leftNameTxt_.text = var_288_18

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_285_1.leftNameTxt_.transform)

				arg_285_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_285_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_285_1:RecordName(arg_285_1.leftNameTxt_.text)
				SetActive(arg_285_1.iconTrs_.gameObject, false)
				arg_285_1.callingController_:SetSelectedState("normal")

				local var_288_19 = arg_285_1:GetWordFromCfg(416071070)
				local var_288_20 = arg_285_1:FormatText(var_288_19.content)

				arg_285_1.text_.text = var_288_20

				LuaForUtil.ClearLinePrefixSymbol(arg_285_1.text_)

				local var_288_21 = 32
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

				if manager.audio:GetVoiceLength("story_v_out_416071", "416071070", "story_v_out_416071.awb") ~= 0 then
					local var_288_24 = manager.audio:GetVoiceLength("story_v_out_416071", "416071070", "story_v_out_416071.awb") / 1000

					if var_288_24 + var_288_16 > arg_285_1.duration_ then
						arg_285_1.duration_ = var_288_24 + var_288_16
					end

					if var_288_19.prefab_name ~= "" and arg_285_1.actors_[var_288_19.prefab_name] ~= nil then
						local var_288_25 = LuaForUtil.PlayVoiceWithCriLipsync(arg_285_1.actors_[var_288_19.prefab_name].transform, "story_v_out_416071", "416071070", "story_v_out_416071.awb")

						arg_285_1:RecordAudio("416071070", var_288_25)
						arg_285_1:RecordAudio("416071070", var_288_25)
					else
						arg_285_1:AudioAction("play", "voice", "story_v_out_416071", "416071070", "story_v_out_416071.awb")
					end

					arg_285_1:RecordHistoryTalkVoice("story_v_out_416071", "416071070", "story_v_out_416071.awb")
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
	Play416071071 = function(arg_289_0, arg_289_1)
		arg_289_1.time_ = 0
		arg_289_1.frameCnt_ = 0
		arg_289_1.state_ = "playing"
		arg_289_1.curTalkId_ = 416071071
		arg_289_1.duration_ = 5.3

		local var_289_0 = {
			zh = 4.8,
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
				arg_289_0:Play416071072(arg_289_1)
			end
		end

		function arg_289_1.onSingleLineUpdate_(arg_292_0)
			local var_292_0 = arg_289_1.actors_["1148"]
			local var_292_1 = 0

			if var_292_1 < arg_289_1.time_ and arg_289_1.time_ <= var_292_1 + arg_292_0 and not isNil(var_292_0) and arg_289_1.var_.actorSpriteComps1148 == nil then
				arg_289_1.var_.actorSpriteComps1148 = var_292_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_292_2 = 0.125

			if var_292_1 <= arg_289_1.time_ and arg_289_1.time_ < var_292_1 + var_292_2 and not isNil(var_292_0) then
				local var_292_3 = (arg_289_1.time_ - var_292_1) / var_292_2

				if arg_289_1.var_.actorSpriteComps1148 then
					for iter_292_0, iter_292_1 in pairs(arg_289_1.var_.actorSpriteComps1148:ToTable()) do
						if iter_292_1 then
							if arg_289_1.isInRecall_ then
								local var_292_4 = Mathf.Lerp(iter_292_1.color.r, arg_289_1.hightColor2.r, var_292_3)
								local var_292_5 = Mathf.Lerp(iter_292_1.color.g, arg_289_1.hightColor2.g, var_292_3)
								local var_292_6 = Mathf.Lerp(iter_292_1.color.b, arg_289_1.hightColor2.b, var_292_3)

								iter_292_1.color = Color.New(var_292_4, var_292_5, var_292_6)
							else
								local var_292_7 = Mathf.Lerp(iter_292_1.color.r, 0.5, var_292_3)

								iter_292_1.color = Color.New(var_292_7, var_292_7, var_292_7)
							end
						end
					end
				end
			end

			if arg_289_1.time_ >= var_292_1 + var_292_2 and arg_289_1.time_ < var_292_1 + var_292_2 + arg_292_0 and not isNil(var_292_0) and arg_289_1.var_.actorSpriteComps1148 then
				for iter_292_2, iter_292_3 in pairs(arg_289_1.var_.actorSpriteComps1148:ToTable()) do
					if iter_292_3 then
						if arg_289_1.isInRecall_ then
							iter_292_3.color = arg_289_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_292_3.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_289_1.var_.actorSpriteComps1148 = nil
			end

			local var_292_8 = arg_289_1.actors_["10108"]
			local var_292_9 = 0

			if var_292_9 < arg_289_1.time_ and arg_289_1.time_ <= var_292_9 + arg_292_0 and not isNil(var_292_8) and arg_289_1.var_.actorSpriteComps10108 == nil then
				arg_289_1.var_.actorSpriteComps10108 = var_292_8:GetComponentsInChildren(typeof(Image), true)
			end

			local var_292_10 = 0.125

			if var_292_9 <= arg_289_1.time_ and arg_289_1.time_ < var_292_9 + var_292_10 and not isNil(var_292_8) then
				local var_292_11 = (arg_289_1.time_ - var_292_9) / var_292_10

				if arg_289_1.var_.actorSpriteComps10108 then
					for iter_292_4, iter_292_5 in pairs(arg_289_1.var_.actorSpriteComps10108:ToTable()) do
						if iter_292_5 then
							if arg_289_1.isInRecall_ then
								local var_292_12 = Mathf.Lerp(iter_292_5.color.r, arg_289_1.hightColor1.r, var_292_11)
								local var_292_13 = Mathf.Lerp(iter_292_5.color.g, arg_289_1.hightColor1.g, var_292_11)
								local var_292_14 = Mathf.Lerp(iter_292_5.color.b, arg_289_1.hightColor1.b, var_292_11)

								iter_292_5.color = Color.New(var_292_12, var_292_13, var_292_14)
							else
								local var_292_15 = Mathf.Lerp(iter_292_5.color.r, 1, var_292_11)

								iter_292_5.color = Color.New(var_292_15, var_292_15, var_292_15)
							end
						end
					end
				end
			end

			if arg_289_1.time_ >= var_292_9 + var_292_10 and arg_289_1.time_ < var_292_9 + var_292_10 + arg_292_0 and not isNil(var_292_8) and arg_289_1.var_.actorSpriteComps10108 then
				for iter_292_6, iter_292_7 in pairs(arg_289_1.var_.actorSpriteComps10108:ToTable()) do
					if iter_292_7 then
						if arg_289_1.isInRecall_ then
							iter_292_7.color = arg_289_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_292_7.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_289_1.var_.actorSpriteComps10108 = nil
			end

			local var_292_16 = arg_289_1.actors_["10108"].transform
			local var_292_17 = 0

			if var_292_17 < arg_289_1.time_ and arg_289_1.time_ <= var_292_17 + arg_292_0 then
				arg_289_1.var_.moveOldPos10108 = var_292_16.localPosition
				var_292_16.localScale = Vector3.New(1, 1, 1)

				arg_289_1:CheckSpriteTmpPos("10108", 4)

				local var_292_18 = var_292_16.childCount

				for iter_292_8 = 0, var_292_18 - 1 do
					local var_292_19 = var_292_16:GetChild(iter_292_8)

					if var_292_19.name == "split_2" or not string.find(var_292_19.name, "split") then
						var_292_19.gameObject:SetActive(true)
					else
						var_292_19.gameObject:SetActive(false)
					end
				end
			end

			local var_292_20 = 0.001

			if var_292_17 <= arg_289_1.time_ and arg_289_1.time_ < var_292_17 + var_292_20 then
				local var_292_21 = (arg_289_1.time_ - var_292_17) / var_292_20
				local var_292_22 = Vector3.New(390, -399.6, -130)

				var_292_16.localPosition = Vector3.Lerp(arg_289_1.var_.moveOldPos10108, var_292_22, var_292_21)
			end

			if arg_289_1.time_ >= var_292_17 + var_292_20 and arg_289_1.time_ < var_292_17 + var_292_20 + arg_292_0 then
				var_292_16.localPosition = Vector3.New(390, -399.6, -130)
			end

			local var_292_23 = 0
			local var_292_24 = 0.325

			if var_292_23 < arg_289_1.time_ and arg_289_1.time_ <= var_292_23 + arg_292_0 then
				arg_289_1.talkMaxDuration = 0
				arg_289_1.dialogCg_.alpha = 1

				arg_289_1.dialog_:SetActive(true)
				SetActive(arg_289_1.leftNameGo_, true)

				local var_292_25 = arg_289_1:FormatText(StoryNameCfg[1083].name)

				arg_289_1.leftNameTxt_.text = var_292_25

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_289_1.leftNameTxt_.transform)

				arg_289_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_289_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_289_1:RecordName(arg_289_1.leftNameTxt_.text)
				SetActive(arg_289_1.iconTrs_.gameObject, false)
				arg_289_1.callingController_:SetSelectedState("normal")

				local var_292_26 = arg_289_1:GetWordFromCfg(416071071)
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

				if manager.audio:GetVoiceLength("story_v_out_416071", "416071071", "story_v_out_416071.awb") ~= 0 then
					local var_292_31 = manager.audio:GetVoiceLength("story_v_out_416071", "416071071", "story_v_out_416071.awb") / 1000

					if var_292_31 + var_292_23 > arg_289_1.duration_ then
						arg_289_1.duration_ = var_292_31 + var_292_23
					end

					if var_292_26.prefab_name ~= "" and arg_289_1.actors_[var_292_26.prefab_name] ~= nil then
						local var_292_32 = LuaForUtil.PlayVoiceWithCriLipsync(arg_289_1.actors_[var_292_26.prefab_name].transform, "story_v_out_416071", "416071071", "story_v_out_416071.awb")

						arg_289_1:RecordAudio("416071071", var_292_32)
						arg_289_1:RecordAudio("416071071", var_292_32)
					else
						arg_289_1:AudioAction("play", "voice", "story_v_out_416071", "416071071", "story_v_out_416071.awb")
					end

					arg_289_1:RecordHistoryTalkVoice("story_v_out_416071", "416071071", "story_v_out_416071.awb")
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
				actorName = "10108",
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
	Play416071072 = function(arg_293_0, arg_293_1)
		arg_293_1.time_ = 0
		arg_293_1.frameCnt_ = 0
		arg_293_1.state_ = "playing"
		arg_293_1.curTalkId_ = 416071072
		arg_293_1.duration_ = 5.97

		local var_293_0 = {
			zh = 4.4,
			ja = 5.966
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
				arg_293_0:Play416071073(arg_293_1)
			end
		end

		function arg_293_1.onSingleLineUpdate_(arg_296_0)
			local var_296_0 = arg_293_1.actors_["1148"]
			local var_296_1 = 0

			if var_296_1 < arg_293_1.time_ and arg_293_1.time_ <= var_296_1 + arg_296_0 and not isNil(var_296_0) and arg_293_1.var_.actorSpriteComps1148 == nil then
				arg_293_1.var_.actorSpriteComps1148 = var_296_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_296_2 = 0.125

			if var_296_1 <= arg_293_1.time_ and arg_293_1.time_ < var_296_1 + var_296_2 and not isNil(var_296_0) then
				local var_296_3 = (arg_293_1.time_ - var_296_1) / var_296_2

				if arg_293_1.var_.actorSpriteComps1148 then
					for iter_296_0, iter_296_1 in pairs(arg_293_1.var_.actorSpriteComps1148:ToTable()) do
						if iter_296_1 then
							if arg_293_1.isInRecall_ then
								local var_296_4 = Mathf.Lerp(iter_296_1.color.r, arg_293_1.hightColor1.r, var_296_3)
								local var_296_5 = Mathf.Lerp(iter_296_1.color.g, arg_293_1.hightColor1.g, var_296_3)
								local var_296_6 = Mathf.Lerp(iter_296_1.color.b, arg_293_1.hightColor1.b, var_296_3)

								iter_296_1.color = Color.New(var_296_4, var_296_5, var_296_6)
							else
								local var_296_7 = Mathf.Lerp(iter_296_1.color.r, 1, var_296_3)

								iter_296_1.color = Color.New(var_296_7, var_296_7, var_296_7)
							end
						end
					end
				end
			end

			if arg_293_1.time_ >= var_296_1 + var_296_2 and arg_293_1.time_ < var_296_1 + var_296_2 + arg_296_0 and not isNil(var_296_0) and arg_293_1.var_.actorSpriteComps1148 then
				for iter_296_2, iter_296_3 in pairs(arg_293_1.var_.actorSpriteComps1148:ToTable()) do
					if iter_296_3 then
						if arg_293_1.isInRecall_ then
							iter_296_3.color = arg_293_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_296_3.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_293_1.var_.actorSpriteComps1148 = nil
			end

			local var_296_8 = arg_293_1.actors_["10108"]
			local var_296_9 = 0

			if var_296_9 < arg_293_1.time_ and arg_293_1.time_ <= var_296_9 + arg_296_0 and not isNil(var_296_8) and arg_293_1.var_.actorSpriteComps10108 == nil then
				arg_293_1.var_.actorSpriteComps10108 = var_296_8:GetComponentsInChildren(typeof(Image), true)
			end

			local var_296_10 = 0.125

			if var_296_9 <= arg_293_1.time_ and arg_293_1.time_ < var_296_9 + var_296_10 and not isNil(var_296_8) then
				local var_296_11 = (arg_293_1.time_ - var_296_9) / var_296_10

				if arg_293_1.var_.actorSpriteComps10108 then
					for iter_296_4, iter_296_5 in pairs(arg_293_1.var_.actorSpriteComps10108:ToTable()) do
						if iter_296_5 then
							if arg_293_1.isInRecall_ then
								local var_296_12 = Mathf.Lerp(iter_296_5.color.r, arg_293_1.hightColor2.r, var_296_11)
								local var_296_13 = Mathf.Lerp(iter_296_5.color.g, arg_293_1.hightColor2.g, var_296_11)
								local var_296_14 = Mathf.Lerp(iter_296_5.color.b, arg_293_1.hightColor2.b, var_296_11)

								iter_296_5.color = Color.New(var_296_12, var_296_13, var_296_14)
							else
								local var_296_15 = Mathf.Lerp(iter_296_5.color.r, 0.5, var_296_11)

								iter_296_5.color = Color.New(var_296_15, var_296_15, var_296_15)
							end
						end
					end
				end
			end

			if arg_293_1.time_ >= var_296_9 + var_296_10 and arg_293_1.time_ < var_296_9 + var_296_10 + arg_296_0 and not isNil(var_296_8) and arg_293_1.var_.actorSpriteComps10108 then
				for iter_296_6, iter_296_7 in pairs(arg_293_1.var_.actorSpriteComps10108:ToTable()) do
					if iter_296_7 then
						if arg_293_1.isInRecall_ then
							iter_296_7.color = arg_293_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_296_7.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_293_1.var_.actorSpriteComps10108 = nil
			end

			local var_296_16 = arg_293_1.actors_["1148"].transform
			local var_296_17 = 0

			if var_296_17 < arg_293_1.time_ and arg_293_1.time_ <= var_296_17 + arg_296_0 then
				arg_293_1.var_.moveOldPos1148 = var_296_16.localPosition
				var_296_16.localScale = Vector3.New(1, 1, 1)

				arg_293_1:CheckSpriteTmpPos("1148", 2)

				local var_296_18 = var_296_16.childCount

				for iter_296_8 = 0, var_296_18 - 1 do
					local var_296_19 = var_296_16:GetChild(iter_296_8)

					if var_296_19.name == "split_4" or not string.find(var_296_19.name, "split") then
						var_296_19.gameObject:SetActive(true)
					else
						var_296_19.gameObject:SetActive(false)
					end
				end
			end

			local var_296_20 = 0.001

			if var_296_17 <= arg_293_1.time_ and arg_293_1.time_ < var_296_17 + var_296_20 then
				local var_296_21 = (arg_293_1.time_ - var_296_17) / var_296_20
				local var_296_22 = Vector3.New(-390, -429, -180)

				var_296_16.localPosition = Vector3.Lerp(arg_293_1.var_.moveOldPos1148, var_296_22, var_296_21)
			end

			if arg_293_1.time_ >= var_296_17 + var_296_20 and arg_293_1.time_ < var_296_17 + var_296_20 + arg_296_0 then
				var_296_16.localPosition = Vector3.New(-390, -429, -180)
			end

			local var_296_23 = 0
			local var_296_24 = 0.35

			if var_296_23 < arg_293_1.time_ and arg_293_1.time_ <= var_296_23 + arg_296_0 then
				arg_293_1.talkMaxDuration = 0
				arg_293_1.dialogCg_.alpha = 1

				arg_293_1.dialog_:SetActive(true)
				SetActive(arg_293_1.leftNameGo_, true)

				local var_296_25 = arg_293_1:FormatText(StoryNameCfg[8].name)

				arg_293_1.leftNameTxt_.text = var_296_25

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_293_1.leftNameTxt_.transform)

				arg_293_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_293_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_293_1:RecordName(arg_293_1.leftNameTxt_.text)
				SetActive(arg_293_1.iconTrs_.gameObject, false)
				arg_293_1.callingController_:SetSelectedState("normal")

				local var_296_26 = arg_293_1:GetWordFromCfg(416071072)
				local var_296_27 = arg_293_1:FormatText(var_296_26.content)

				arg_293_1.text_.text = var_296_27

				LuaForUtil.ClearLinePrefixSymbol(arg_293_1.text_)

				local var_296_28 = 14
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

				if manager.audio:GetVoiceLength("story_v_out_416071", "416071072", "story_v_out_416071.awb") ~= 0 then
					local var_296_31 = manager.audio:GetVoiceLength("story_v_out_416071", "416071072", "story_v_out_416071.awb") / 1000

					if var_296_31 + var_296_23 > arg_293_1.duration_ then
						arg_293_1.duration_ = var_296_31 + var_296_23
					end

					if var_296_26.prefab_name ~= "" and arg_293_1.actors_[var_296_26.prefab_name] ~= nil then
						local var_296_32 = LuaForUtil.PlayVoiceWithCriLipsync(arg_293_1.actors_[var_296_26.prefab_name].transform, "story_v_out_416071", "416071072", "story_v_out_416071.awb")

						arg_293_1:RecordAudio("416071072", var_296_32)
						arg_293_1:RecordAudio("416071072", var_296_32)
					else
						arg_293_1:AudioAction("play", "voice", "story_v_out_416071", "416071072", "story_v_out_416071.awb")
					end

					arg_293_1:RecordHistoryTalkVoice("story_v_out_416071", "416071072", "story_v_out_416071.awb")
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
				actorName = "1148",
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
	Play416071073 = function(arg_297_0, arg_297_1)
		arg_297_1.time_ = 0
		arg_297_1.frameCnt_ = 0
		arg_297_1.state_ = "playing"
		arg_297_1.curTalkId_ = 416071073
		arg_297_1.duration_ = 10.27

		local var_297_0 = {
			zh = 5.2,
			ja = 10.266
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
				arg_297_0:Play416071074(arg_297_1)
			end
		end

		function arg_297_1.onSingleLineUpdate_(arg_300_0)
			local var_300_0 = arg_297_1.actors_["1148"]
			local var_300_1 = 0

			if var_300_1 < arg_297_1.time_ and arg_297_1.time_ <= var_300_1 + arg_300_0 and not isNil(var_300_0) and arg_297_1.var_.actorSpriteComps1148 == nil then
				arg_297_1.var_.actorSpriteComps1148 = var_300_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_300_2 = 0.125

			if var_300_1 <= arg_297_1.time_ and arg_297_1.time_ < var_300_1 + var_300_2 and not isNil(var_300_0) then
				local var_300_3 = (arg_297_1.time_ - var_300_1) / var_300_2

				if arg_297_1.var_.actorSpriteComps1148 then
					for iter_300_0, iter_300_1 in pairs(arg_297_1.var_.actorSpriteComps1148:ToTable()) do
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

			if arg_297_1.time_ >= var_300_1 + var_300_2 and arg_297_1.time_ < var_300_1 + var_300_2 + arg_300_0 and not isNil(var_300_0) and arg_297_1.var_.actorSpriteComps1148 then
				for iter_300_2, iter_300_3 in pairs(arg_297_1.var_.actorSpriteComps1148:ToTable()) do
					if iter_300_3 then
						if arg_297_1.isInRecall_ then
							iter_300_3.color = arg_297_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_300_3.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_297_1.var_.actorSpriteComps1148 = nil
			end

			local var_300_8 = arg_297_1.actors_["10108"]
			local var_300_9 = 0

			if var_300_9 < arg_297_1.time_ and arg_297_1.time_ <= var_300_9 + arg_300_0 and not isNil(var_300_8) and arg_297_1.var_.actorSpriteComps10108 == nil then
				arg_297_1.var_.actorSpriteComps10108 = var_300_8:GetComponentsInChildren(typeof(Image), true)
			end

			local var_300_10 = 0.125

			if var_300_9 <= arg_297_1.time_ and arg_297_1.time_ < var_300_9 + var_300_10 and not isNil(var_300_8) then
				local var_300_11 = (arg_297_1.time_ - var_300_9) / var_300_10

				if arg_297_1.var_.actorSpriteComps10108 then
					for iter_300_4, iter_300_5 in pairs(arg_297_1.var_.actorSpriteComps10108:ToTable()) do
						if iter_300_5 then
							if arg_297_1.isInRecall_ then
								local var_300_12 = Mathf.Lerp(iter_300_5.color.r, arg_297_1.hightColor1.r, var_300_11)
								local var_300_13 = Mathf.Lerp(iter_300_5.color.g, arg_297_1.hightColor1.g, var_300_11)
								local var_300_14 = Mathf.Lerp(iter_300_5.color.b, arg_297_1.hightColor1.b, var_300_11)

								iter_300_5.color = Color.New(var_300_12, var_300_13, var_300_14)
							else
								local var_300_15 = Mathf.Lerp(iter_300_5.color.r, 1, var_300_11)

								iter_300_5.color = Color.New(var_300_15, var_300_15, var_300_15)
							end
						end
					end
				end
			end

			if arg_297_1.time_ >= var_300_9 + var_300_10 and arg_297_1.time_ < var_300_9 + var_300_10 + arg_300_0 and not isNil(var_300_8) and arg_297_1.var_.actorSpriteComps10108 then
				for iter_300_6, iter_300_7 in pairs(arg_297_1.var_.actorSpriteComps10108:ToTable()) do
					if iter_300_7 then
						if arg_297_1.isInRecall_ then
							iter_300_7.color = arg_297_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_300_7.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_297_1.var_.actorSpriteComps10108 = nil
			end

			local var_300_16 = 0
			local var_300_17 = 0.45

			if var_300_16 < arg_297_1.time_ and arg_297_1.time_ <= var_300_16 + arg_300_0 then
				arg_297_1.talkMaxDuration = 0
				arg_297_1.dialogCg_.alpha = 1

				arg_297_1.dialog_:SetActive(true)
				SetActive(arg_297_1.leftNameGo_, true)

				local var_300_18 = arg_297_1:FormatText(StoryNameCfg[1083].name)

				arg_297_1.leftNameTxt_.text = var_300_18

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_297_1.leftNameTxt_.transform)

				arg_297_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_297_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_297_1:RecordName(arg_297_1.leftNameTxt_.text)
				SetActive(arg_297_1.iconTrs_.gameObject, false)
				arg_297_1.callingController_:SetSelectedState("normal")

				local var_300_19 = arg_297_1:GetWordFromCfg(416071073)
				local var_300_20 = arg_297_1:FormatText(var_300_19.content)

				arg_297_1.text_.text = var_300_20

				LuaForUtil.ClearLinePrefixSymbol(arg_297_1.text_)

				local var_300_21 = 18
				local var_300_22 = utf8.len(var_300_20)
				local var_300_23 = var_300_21 <= 0 and var_300_17 or var_300_17 * (var_300_22 / var_300_21)

				if var_300_23 > 0 and var_300_17 < var_300_23 then
					arg_297_1.talkMaxDuration = var_300_23

					if var_300_23 + var_300_16 > arg_297_1.duration_ then
						arg_297_1.duration_ = var_300_23 + var_300_16
					end
				end

				arg_297_1.text_.text = var_300_20
				arg_297_1.typewritter.percent = 0

				arg_297_1.typewritter:SetDirty()
				arg_297_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_416071", "416071073", "story_v_out_416071.awb") ~= 0 then
					local var_300_24 = manager.audio:GetVoiceLength("story_v_out_416071", "416071073", "story_v_out_416071.awb") / 1000

					if var_300_24 + var_300_16 > arg_297_1.duration_ then
						arg_297_1.duration_ = var_300_24 + var_300_16
					end

					if var_300_19.prefab_name ~= "" and arg_297_1.actors_[var_300_19.prefab_name] ~= nil then
						local var_300_25 = LuaForUtil.PlayVoiceWithCriLipsync(arg_297_1.actors_[var_300_19.prefab_name].transform, "story_v_out_416071", "416071073", "story_v_out_416071.awb")

						arg_297_1:RecordAudio("416071073", var_300_25)
						arg_297_1:RecordAudio("416071073", var_300_25)
					else
						arg_297_1:AudioAction("play", "voice", "story_v_out_416071", "416071073", "story_v_out_416071.awb")
					end

					arg_297_1:RecordHistoryTalkVoice("story_v_out_416071", "416071073", "story_v_out_416071.awb")
				end

				arg_297_1:RecordContent(arg_297_1.text_.text)
			end

			local var_300_26 = math.max(var_300_17, arg_297_1.talkMaxDuration)

			if var_300_16 <= arg_297_1.time_ and arg_297_1.time_ < var_300_16 + var_300_26 then
				arg_297_1.typewritter.percent = (arg_297_1.time_ - var_300_16) / var_300_26

				arg_297_1.typewritter:SetDirty()
			end

			if arg_297_1.time_ >= var_300_16 + var_300_26 and arg_297_1.time_ < var_300_16 + var_300_26 + arg_300_0 then
				arg_297_1.typewritter.percent = 1

				arg_297_1.typewritter:SetDirty()
				arg_297_1:ShowNextGo(true)
			end
		end

		arg_297_1.nodeConfigList_ = {}

		arg_297_1:InitPlayNodeList()
	end,
	Play416071074 = function(arg_301_0, arg_301_1)
		arg_301_1.time_ = 0
		arg_301_1.frameCnt_ = 0
		arg_301_1.state_ = "playing"
		arg_301_1.curTalkId_ = 416071074
		arg_301_1.duration_ = 9.57

		local var_301_0 = {
			zh = 6.5,
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
				arg_301_0:Play416071075(arg_301_1)
			end
		end

		function arg_301_1.onSingleLineUpdate_(arg_304_0)
			local var_304_0 = 0
			local var_304_1 = 0.6

			if var_304_0 < arg_301_1.time_ and arg_301_1.time_ <= var_304_0 + arg_304_0 then
				arg_301_1.talkMaxDuration = 0
				arg_301_1.dialogCg_.alpha = 1

				arg_301_1.dialog_:SetActive(true)
				SetActive(arg_301_1.leftNameGo_, true)

				local var_304_2 = arg_301_1:FormatText(StoryNameCfg[1083].name)

				arg_301_1.leftNameTxt_.text = var_304_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_301_1.leftNameTxt_.transform)

				arg_301_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_301_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_301_1:RecordName(arg_301_1.leftNameTxt_.text)
				SetActive(arg_301_1.iconTrs_.gameObject, false)
				arg_301_1.callingController_:SetSelectedState("normal")

				local var_304_3 = arg_301_1:GetWordFromCfg(416071074)
				local var_304_4 = arg_301_1:FormatText(var_304_3.content)

				arg_301_1.text_.text = var_304_4

				LuaForUtil.ClearLinePrefixSymbol(arg_301_1.text_)

				local var_304_5 = 24
				local var_304_6 = utf8.len(var_304_4)
				local var_304_7 = var_304_5 <= 0 and var_304_1 or var_304_1 * (var_304_6 / var_304_5)

				if var_304_7 > 0 and var_304_1 < var_304_7 then
					arg_301_1.talkMaxDuration = var_304_7

					if var_304_7 + var_304_0 > arg_301_1.duration_ then
						arg_301_1.duration_ = var_304_7 + var_304_0
					end
				end

				arg_301_1.text_.text = var_304_4
				arg_301_1.typewritter.percent = 0

				arg_301_1.typewritter:SetDirty()
				arg_301_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_416071", "416071074", "story_v_out_416071.awb") ~= 0 then
					local var_304_8 = manager.audio:GetVoiceLength("story_v_out_416071", "416071074", "story_v_out_416071.awb") / 1000

					if var_304_8 + var_304_0 > arg_301_1.duration_ then
						arg_301_1.duration_ = var_304_8 + var_304_0
					end

					if var_304_3.prefab_name ~= "" and arg_301_1.actors_[var_304_3.prefab_name] ~= nil then
						local var_304_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_301_1.actors_[var_304_3.prefab_name].transform, "story_v_out_416071", "416071074", "story_v_out_416071.awb")

						arg_301_1:RecordAudio("416071074", var_304_9)
						arg_301_1:RecordAudio("416071074", var_304_9)
					else
						arg_301_1:AudioAction("play", "voice", "story_v_out_416071", "416071074", "story_v_out_416071.awb")
					end

					arg_301_1:RecordHistoryTalkVoice("story_v_out_416071", "416071074", "story_v_out_416071.awb")
				end

				arg_301_1:RecordContent(arg_301_1.text_.text)
			end

			local var_304_10 = math.max(var_304_1, arg_301_1.talkMaxDuration)

			if var_304_0 <= arg_301_1.time_ and arg_301_1.time_ < var_304_0 + var_304_10 then
				arg_301_1.typewritter.percent = (arg_301_1.time_ - var_304_0) / var_304_10

				arg_301_1.typewritter:SetDirty()
			end

			if arg_301_1.time_ >= var_304_0 + var_304_10 and arg_301_1.time_ < var_304_0 + var_304_10 + arg_304_0 then
				arg_301_1.typewritter.percent = 1

				arg_301_1.typewritter:SetDirty()
				arg_301_1:ShowNextGo(true)
			end
		end

		arg_301_1.nodeConfigList_ = {}

		arg_301_1:InitPlayNodeList()
	end,
	Play416071075 = function(arg_305_0, arg_305_1)
		arg_305_1.time_ = 0
		arg_305_1.frameCnt_ = 0
		arg_305_1.state_ = "playing"
		arg_305_1.curTalkId_ = 416071075
		arg_305_1.duration_ = 7.2

		local var_305_0 = {
			zh = 6.6,
			ja = 7.2
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
				arg_305_0:Play416071076(arg_305_1)
			end
		end

		function arg_305_1.onSingleLineUpdate_(arg_308_0)
			local var_308_0 = arg_305_1.actors_["1148"]
			local var_308_1 = 0

			if var_308_1 < arg_305_1.time_ and arg_305_1.time_ <= var_308_1 + arg_308_0 and not isNil(var_308_0) and arg_305_1.var_.actorSpriteComps1148 == nil then
				arg_305_1.var_.actorSpriteComps1148 = var_308_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_308_2 = 0.125

			if var_308_1 <= arg_305_1.time_ and arg_305_1.time_ < var_308_1 + var_308_2 and not isNil(var_308_0) then
				local var_308_3 = (arg_305_1.time_ - var_308_1) / var_308_2

				if arg_305_1.var_.actorSpriteComps1148 then
					for iter_308_0, iter_308_1 in pairs(arg_305_1.var_.actorSpriteComps1148:ToTable()) do
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

			if arg_305_1.time_ >= var_308_1 + var_308_2 and arg_305_1.time_ < var_308_1 + var_308_2 + arg_308_0 and not isNil(var_308_0) and arg_305_1.var_.actorSpriteComps1148 then
				for iter_308_2, iter_308_3 in pairs(arg_305_1.var_.actorSpriteComps1148:ToTable()) do
					if iter_308_3 then
						if arg_305_1.isInRecall_ then
							iter_308_3.color = arg_305_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_308_3.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_305_1.var_.actorSpriteComps1148 = nil
			end

			local var_308_8 = arg_305_1.actors_["10108"]
			local var_308_9 = 0

			if var_308_9 < arg_305_1.time_ and arg_305_1.time_ <= var_308_9 + arg_308_0 and not isNil(var_308_8) and arg_305_1.var_.actorSpriteComps10108 == nil then
				arg_305_1.var_.actorSpriteComps10108 = var_308_8:GetComponentsInChildren(typeof(Image), true)
			end

			local var_308_10 = 0.125

			if var_308_9 <= arg_305_1.time_ and arg_305_1.time_ < var_308_9 + var_308_10 and not isNil(var_308_8) then
				local var_308_11 = (arg_305_1.time_ - var_308_9) / var_308_10

				if arg_305_1.var_.actorSpriteComps10108 then
					for iter_308_4, iter_308_5 in pairs(arg_305_1.var_.actorSpriteComps10108:ToTable()) do
						if iter_308_5 then
							if arg_305_1.isInRecall_ then
								local var_308_12 = Mathf.Lerp(iter_308_5.color.r, arg_305_1.hightColor2.r, var_308_11)
								local var_308_13 = Mathf.Lerp(iter_308_5.color.g, arg_305_1.hightColor2.g, var_308_11)
								local var_308_14 = Mathf.Lerp(iter_308_5.color.b, arg_305_1.hightColor2.b, var_308_11)

								iter_308_5.color = Color.New(var_308_12, var_308_13, var_308_14)
							else
								local var_308_15 = Mathf.Lerp(iter_308_5.color.r, 0.5, var_308_11)

								iter_308_5.color = Color.New(var_308_15, var_308_15, var_308_15)
							end
						end
					end
				end
			end

			if arg_305_1.time_ >= var_308_9 + var_308_10 and arg_305_1.time_ < var_308_9 + var_308_10 + arg_308_0 and not isNil(var_308_8) and arg_305_1.var_.actorSpriteComps10108 then
				for iter_308_6, iter_308_7 in pairs(arg_305_1.var_.actorSpriteComps10108:ToTable()) do
					if iter_308_7 then
						if arg_305_1.isInRecall_ then
							iter_308_7.color = arg_305_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_308_7.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_305_1.var_.actorSpriteComps10108 = nil
			end

			local var_308_16 = 0
			local var_308_17 = 0.675

			if var_308_16 < arg_305_1.time_ and arg_305_1.time_ <= var_308_16 + arg_308_0 then
				arg_305_1.talkMaxDuration = 0
				arg_305_1.dialogCg_.alpha = 1

				arg_305_1.dialog_:SetActive(true)
				SetActive(arg_305_1.leftNameGo_, true)

				local var_308_18 = arg_305_1:FormatText(StoryNameCfg[8].name)

				arg_305_1.leftNameTxt_.text = var_308_18

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_305_1.leftNameTxt_.transform)

				arg_305_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_305_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_305_1:RecordName(arg_305_1.leftNameTxt_.text)
				SetActive(arg_305_1.iconTrs_.gameObject, false)
				arg_305_1.callingController_:SetSelectedState("normal")

				local var_308_19 = arg_305_1:GetWordFromCfg(416071075)
				local var_308_20 = arg_305_1:FormatText(var_308_19.content)

				arg_305_1.text_.text = var_308_20

				LuaForUtil.ClearLinePrefixSymbol(arg_305_1.text_)

				local var_308_21 = 27
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

				if manager.audio:GetVoiceLength("story_v_out_416071", "416071075", "story_v_out_416071.awb") ~= 0 then
					local var_308_24 = manager.audio:GetVoiceLength("story_v_out_416071", "416071075", "story_v_out_416071.awb") / 1000

					if var_308_24 + var_308_16 > arg_305_1.duration_ then
						arg_305_1.duration_ = var_308_24 + var_308_16
					end

					if var_308_19.prefab_name ~= "" and arg_305_1.actors_[var_308_19.prefab_name] ~= nil then
						local var_308_25 = LuaForUtil.PlayVoiceWithCriLipsync(arg_305_1.actors_[var_308_19.prefab_name].transform, "story_v_out_416071", "416071075", "story_v_out_416071.awb")

						arg_305_1:RecordAudio("416071075", var_308_25)
						arg_305_1:RecordAudio("416071075", var_308_25)
					else
						arg_305_1:AudioAction("play", "voice", "story_v_out_416071", "416071075", "story_v_out_416071.awb")
					end

					arg_305_1:RecordHistoryTalkVoice("story_v_out_416071", "416071075", "story_v_out_416071.awb")
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
	Play416071076 = function(arg_309_0, arg_309_1)
		arg_309_1.time_ = 0
		arg_309_1.frameCnt_ = 0
		arg_309_1.state_ = "playing"
		arg_309_1.curTalkId_ = 416071076
		arg_309_1.duration_ = 7.5

		local var_309_0 = {
			zh = 5.366,
			ja = 7.5
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
				arg_309_0:Play416071077(arg_309_1)
			end
		end

		function arg_309_1.onSingleLineUpdate_(arg_312_0)
			local var_312_0 = arg_309_1.actors_["1148"].transform
			local var_312_1 = 0

			if var_312_1 < arg_309_1.time_ and arg_309_1.time_ <= var_312_1 + arg_312_0 then
				arg_309_1.var_.moveOldPos1148 = var_312_0.localPosition
				var_312_0.localScale = Vector3.New(1, 1, 1)

				arg_309_1:CheckSpriteTmpPos("1148", 2)

				local var_312_2 = var_312_0.childCount

				for iter_312_0 = 0, var_312_2 - 1 do
					local var_312_3 = var_312_0:GetChild(iter_312_0)

					if var_312_3.name == "split_6" or not string.find(var_312_3.name, "split") then
						var_312_3.gameObject:SetActive(true)
					else
						var_312_3.gameObject:SetActive(false)
					end
				end
			end

			local var_312_4 = 0.001

			if var_312_1 <= arg_309_1.time_ and arg_309_1.time_ < var_312_1 + var_312_4 then
				local var_312_5 = (arg_309_1.time_ - var_312_1) / var_312_4
				local var_312_6 = Vector3.New(-390, -429, -180)

				var_312_0.localPosition = Vector3.Lerp(arg_309_1.var_.moveOldPos1148, var_312_6, var_312_5)
			end

			if arg_309_1.time_ >= var_312_1 + var_312_4 and arg_309_1.time_ < var_312_1 + var_312_4 + arg_312_0 then
				var_312_0.localPosition = Vector3.New(-390, -429, -180)
			end

			local var_312_7 = 0
			local var_312_8 = 0.5

			if var_312_7 < arg_309_1.time_ and arg_309_1.time_ <= var_312_7 + arg_312_0 then
				arg_309_1.talkMaxDuration = 0
				arg_309_1.dialogCg_.alpha = 1

				arg_309_1.dialog_:SetActive(true)
				SetActive(arg_309_1.leftNameGo_, true)

				local var_312_9 = arg_309_1:FormatText(StoryNameCfg[8].name)

				arg_309_1.leftNameTxt_.text = var_312_9

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_309_1.leftNameTxt_.transform)

				arg_309_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_309_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_309_1:RecordName(arg_309_1.leftNameTxt_.text)
				SetActive(arg_309_1.iconTrs_.gameObject, false)
				arg_309_1.callingController_:SetSelectedState("normal")

				local var_312_10 = arg_309_1:GetWordFromCfg(416071076)
				local var_312_11 = arg_309_1:FormatText(var_312_10.content)

				arg_309_1.text_.text = var_312_11

				LuaForUtil.ClearLinePrefixSymbol(arg_309_1.text_)

				local var_312_12 = 20
				local var_312_13 = utf8.len(var_312_11)
				local var_312_14 = var_312_12 <= 0 and var_312_8 or var_312_8 * (var_312_13 / var_312_12)

				if var_312_14 > 0 and var_312_8 < var_312_14 then
					arg_309_1.talkMaxDuration = var_312_14

					if var_312_14 + var_312_7 > arg_309_1.duration_ then
						arg_309_1.duration_ = var_312_14 + var_312_7
					end
				end

				arg_309_1.text_.text = var_312_11
				arg_309_1.typewritter.percent = 0

				arg_309_1.typewritter:SetDirty()
				arg_309_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_416071", "416071076", "story_v_out_416071.awb") ~= 0 then
					local var_312_15 = manager.audio:GetVoiceLength("story_v_out_416071", "416071076", "story_v_out_416071.awb") / 1000

					if var_312_15 + var_312_7 > arg_309_1.duration_ then
						arg_309_1.duration_ = var_312_15 + var_312_7
					end

					if var_312_10.prefab_name ~= "" and arg_309_1.actors_[var_312_10.prefab_name] ~= nil then
						local var_312_16 = LuaForUtil.PlayVoiceWithCriLipsync(arg_309_1.actors_[var_312_10.prefab_name].transform, "story_v_out_416071", "416071076", "story_v_out_416071.awb")

						arg_309_1:RecordAudio("416071076", var_312_16)
						arg_309_1:RecordAudio("416071076", var_312_16)
					else
						arg_309_1:AudioAction("play", "voice", "story_v_out_416071", "416071076", "story_v_out_416071.awb")
					end

					arg_309_1:RecordHistoryTalkVoice("story_v_out_416071", "416071076", "story_v_out_416071.awb")
				end

				arg_309_1:RecordContent(arg_309_1.text_.text)
			end

			local var_312_17 = math.max(var_312_8, arg_309_1.talkMaxDuration)

			if var_312_7 <= arg_309_1.time_ and arg_309_1.time_ < var_312_7 + var_312_17 then
				arg_309_1.typewritter.percent = (arg_309_1.time_ - var_312_7) / var_312_17

				arg_309_1.typewritter:SetDirty()
			end

			if arg_309_1.time_ >= var_312_7 + var_312_17 and arg_309_1.time_ < var_312_7 + var_312_17 + arg_312_0 then
				arg_309_1.typewritter.percent = 1

				arg_309_1.typewritter:SetDirty()
				arg_309_1:ShowNextGo(true)
			end
		end

		arg_309_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1148",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_309_1:InitPlayNodeList()
	end,
	Play416071077 = function(arg_313_0, arg_313_1)
		arg_313_1.time_ = 0
		arg_313_1.frameCnt_ = 0
		arg_313_1.state_ = "playing"
		arg_313_1.curTalkId_ = 416071077
		arg_313_1.duration_ = 6.83

		local var_313_0 = {
			zh = 5.233,
			ja = 6.833
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
				arg_313_0:Play416071078(arg_313_1)
			end
		end

		function arg_313_1.onSingleLineUpdate_(arg_316_0)
			local var_316_0 = arg_313_1.actors_["10108"].transform
			local var_316_1 = 0

			if var_316_1 < arg_313_1.time_ and arg_313_1.time_ <= var_316_1 + arg_316_0 then
				arg_313_1.var_.moveOldPos10108 = var_316_0.localPosition
				var_316_0.localScale = Vector3.New(1, 1, 1)

				arg_313_1:CheckSpriteTmpPos("10108", 7)

				local var_316_2 = var_316_0.childCount

				for iter_316_0 = 0, var_316_2 - 1 do
					local var_316_3 = var_316_0:GetChild(iter_316_0)

					if var_316_3.name == "" or not string.find(var_316_3.name, "split") then
						var_316_3.gameObject:SetActive(true)
					else
						var_316_3.gameObject:SetActive(false)
					end
				end
			end

			local var_316_4 = 0.001

			if var_316_1 <= arg_313_1.time_ and arg_313_1.time_ < var_316_1 + var_316_4 then
				local var_316_5 = (arg_313_1.time_ - var_316_1) / var_316_4
				local var_316_6 = Vector3.New(0, -2000, 0)

				var_316_0.localPosition = Vector3.Lerp(arg_313_1.var_.moveOldPos10108, var_316_6, var_316_5)
			end

			if arg_313_1.time_ >= var_316_1 + var_316_4 and arg_313_1.time_ < var_316_1 + var_316_4 + arg_316_0 then
				var_316_0.localPosition = Vector3.New(0, -2000, 0)
			end

			local var_316_7 = arg_313_1.actors_["1148"].transform
			local var_316_8 = 0

			if var_316_8 < arg_313_1.time_ and arg_313_1.time_ <= var_316_8 + arg_316_0 then
				arg_313_1.var_.moveOldPos1148 = var_316_7.localPosition
				var_316_7.localScale = Vector3.New(1, 1, 1)

				arg_313_1:CheckSpriteTmpPos("1148", 7)

				local var_316_9 = var_316_7.childCount

				for iter_316_1 = 0, var_316_9 - 1 do
					local var_316_10 = var_316_7:GetChild(iter_316_1)

					if var_316_10.name == "" or not string.find(var_316_10.name, "split") then
						var_316_10.gameObject:SetActive(true)
					else
						var_316_10.gameObject:SetActive(false)
					end
				end
			end

			local var_316_11 = 0.001

			if var_316_8 <= arg_313_1.time_ and arg_313_1.time_ < var_316_8 + var_316_11 then
				local var_316_12 = (arg_313_1.time_ - var_316_8) / var_316_11
				local var_316_13 = Vector3.New(0, -2000, 0)

				var_316_7.localPosition = Vector3.Lerp(arg_313_1.var_.moveOldPos1148, var_316_13, var_316_12)
			end

			if arg_313_1.time_ >= var_316_8 + var_316_11 and arg_313_1.time_ < var_316_8 + var_316_11 + arg_316_0 then
				var_316_7.localPosition = Vector3.New(0, -2000, 0)
			end

			local var_316_14 = manager.ui.mainCamera.transform
			local var_316_15 = 0

			if var_316_15 < arg_313_1.time_ and arg_313_1.time_ <= var_316_15 + arg_316_0 then
				local var_316_16 = arg_313_1.var_.effect77
				local var_316_17
				local var_316_18 = var_316_14

				if not var_316_16 then
					var_316_16 = Object.Instantiate(Asset.Load("Effect/Scene/fx_uistory_error"), var_316_18)
					var_316_16.name = "77"
					arg_313_1.var_.effect77 = var_316_16
				else
					var_316_16.transform:SetParent(var_316_18)
				end

				var_316_16.transform.localPosition = Vector3.New(0, 0, 0)
				var_316_16.transform.localRotation = Quaternion.Euler(0, 0, 0)
			end

			local var_316_19 = manager.ui.mainCamera.transform
			local var_316_20 = 1

			if var_316_20 < arg_313_1.time_ and arg_313_1.time_ <= var_316_20 + arg_316_0 then
				local var_316_21 = arg_313_1.var_.effect77

				if var_316_21 then
					Object.Destroy(var_316_21)

					arg_313_1.var_.effect77 = nil
				end
			end

			local var_316_22 = 0
			local var_316_23 = 1

			if var_316_22 < arg_313_1.time_ and arg_313_1.time_ <= var_316_22 + arg_316_0 then
				local var_316_24 = "play"
				local var_316_25 = "effect"

				arg_313_1:AudioAction(var_316_24, var_316_25, "se_story_16", "se_story_16_channel", "")
			end

			if arg_313_1.frameCnt_ <= 1 then
				arg_313_1.dialog_:SetActive(false)
			end

			local var_316_26 = 1
			local var_316_27 = 0.5

			if var_316_26 < arg_313_1.time_ and arg_313_1.time_ <= var_316_26 + arg_316_0 then
				arg_313_1.talkMaxDuration = 0

				arg_313_1.dialog_:SetActive(true)

				arg_313_1.dialogCg_.alpha = 0

				local var_316_28 = LeanTween.value(arg_313_1.dialog_, 0, 1, 0.3)

				var_316_28:setOnUpdate(LuaHelper.FloatAction(function(arg_317_0)
					arg_313_1.dialogCg_.alpha = arg_317_0
				end))
				var_316_28:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_313_1.dialog_)
					var_316_28:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_313_1.duration_ = arg_313_1.duration_ + 0.3

				SetActive(arg_313_1.leftNameGo_, true)

				local var_316_29 = arg_313_1:FormatText(StoryNameCfg[36].name)

				arg_313_1.leftNameTxt_.text = var_316_29

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_313_1.leftNameTxt_.transform)

				arg_313_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_313_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_313_1:RecordName(arg_313_1.leftNameTxt_.text)
				SetActive(arg_313_1.iconTrs_.gameObject, true)
				arg_313_1.iconController_:SetSelectedState("hero")

				arg_313_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_soundonly")

				arg_313_1.callingController_:SetSelectedState("normal")

				arg_313_1.keyicon_.color = Color.New(1, 1, 1)
				arg_313_1.icon_.color = Color.New(1, 1, 1)

				local var_316_30 = arg_313_1:GetWordFromCfg(416071077)
				local var_316_31 = arg_313_1:FormatText(var_316_30.content)

				arg_313_1.text_.text = var_316_31

				LuaForUtil.ClearLinePrefixSymbol(arg_313_1.text_)

				local var_316_32 = 20
				local var_316_33 = utf8.len(var_316_31)
				local var_316_34 = var_316_32 <= 0 and var_316_27 or var_316_27 * (var_316_33 / var_316_32)

				if var_316_34 > 0 and var_316_27 < var_316_34 then
					arg_313_1.talkMaxDuration = var_316_34
					var_316_26 = var_316_26 + 0.3

					if var_316_34 + var_316_26 > arg_313_1.duration_ then
						arg_313_1.duration_ = var_316_34 + var_316_26
					end
				end

				arg_313_1.text_.text = var_316_31
				arg_313_1.typewritter.percent = 0

				arg_313_1.typewritter:SetDirty()
				arg_313_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_416071", "416071077", "story_v_out_416071.awb") ~= 0 then
					local var_316_35 = manager.audio:GetVoiceLength("story_v_out_416071", "416071077", "story_v_out_416071.awb") / 1000

					if var_316_35 + var_316_26 > arg_313_1.duration_ then
						arg_313_1.duration_ = var_316_35 + var_316_26
					end

					if var_316_30.prefab_name ~= "" and arg_313_1.actors_[var_316_30.prefab_name] ~= nil then
						local var_316_36 = LuaForUtil.PlayVoiceWithCriLipsync(arg_313_1.actors_[var_316_30.prefab_name].transform, "story_v_out_416071", "416071077", "story_v_out_416071.awb")

						arg_313_1:RecordAudio("416071077", var_316_36)
						arg_313_1:RecordAudio("416071077", var_316_36)
					else
						arg_313_1:AudioAction("play", "voice", "story_v_out_416071", "416071077", "story_v_out_416071.awb")
					end

					arg_313_1:RecordHistoryTalkVoice("story_v_out_416071", "416071077", "story_v_out_416071.awb")
				end

				arg_313_1:RecordContent(arg_313_1.text_.text)
			end

			local var_316_37 = var_316_26 + 0.3
			local var_316_38 = math.max(var_316_27, arg_313_1.talkMaxDuration)

			if var_316_37 <= arg_313_1.time_ and arg_313_1.time_ < var_316_37 + var_316_38 then
				arg_313_1.typewritter.percent = (arg_313_1.time_ - var_316_37) / var_316_38

				arg_313_1.typewritter:SetDirty()
			end

			if arg_313_1.time_ >= var_316_37 + var_316_38 and arg_313_1.time_ < var_316_37 + var_316_38 + arg_316_0 then
				arg_313_1.typewritter.percent = 1

				arg_313_1.typewritter:SetDirty()
				arg_313_1:ShowNextGo(true)
			end
		end

		arg_313_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10108",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			},
			{
				assetPath = "",
				actorName = "1148",
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
	Play416071078 = function(arg_319_0, arg_319_1)
		arg_319_1.time_ = 0
		arg_319_1.frameCnt_ = 0
		arg_319_1.state_ = "playing"
		arg_319_1.curTalkId_ = 416071078
		arg_319_1.duration_ = 5

		SetActive(arg_319_1.tipsGo_, false)

		function arg_319_1.onSingleLineFinish_()
			arg_319_1.onSingleLineUpdate_ = nil
			arg_319_1.onSingleLineFinish_ = nil
			arg_319_1.state_ = "waiting"
		end

		function arg_319_1.playNext_(arg_321_0)
			if arg_321_0 == 1 then
				arg_319_0:Play416071079(arg_319_1)
			end
		end

		function arg_319_1.onSingleLineUpdate_(arg_322_0)
			local var_322_0 = 0
			local var_322_1 = 1.225

			if var_322_0 < arg_319_1.time_ and arg_319_1.time_ <= var_322_0 + arg_322_0 then
				arg_319_1.talkMaxDuration = 0
				arg_319_1.dialogCg_.alpha = 1

				arg_319_1.dialog_:SetActive(true)
				SetActive(arg_319_1.leftNameGo_, false)

				arg_319_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_319_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_319_1:RecordName(arg_319_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_319_1.iconTrs_.gameObject, false)
				arg_319_1.callingController_:SetSelectedState("normal")

				local var_322_2 = arg_319_1:GetWordFromCfg(416071078)
				local var_322_3 = arg_319_1:FormatText(var_322_2.content)

				arg_319_1.text_.text = var_322_3

				LuaForUtil.ClearLinePrefixSymbol(arg_319_1.text_)

				local var_322_4 = 49
				local var_322_5 = utf8.len(var_322_3)
				local var_322_6 = var_322_4 <= 0 and var_322_1 or var_322_1 * (var_322_5 / var_322_4)

				if var_322_6 > 0 and var_322_1 < var_322_6 then
					arg_319_1.talkMaxDuration = var_322_6

					if var_322_6 + var_322_0 > arg_319_1.duration_ then
						arg_319_1.duration_ = var_322_6 + var_322_0
					end
				end

				arg_319_1.text_.text = var_322_3
				arg_319_1.typewritter.percent = 0

				arg_319_1.typewritter:SetDirty()
				arg_319_1:ShowNextGo(false)
				arg_319_1:RecordContent(arg_319_1.text_.text)
			end

			local var_322_7 = math.max(var_322_1, arg_319_1.talkMaxDuration)

			if var_322_0 <= arg_319_1.time_ and arg_319_1.time_ < var_322_0 + var_322_7 then
				arg_319_1.typewritter.percent = (arg_319_1.time_ - var_322_0) / var_322_7

				arg_319_1.typewritter:SetDirty()
			end

			if arg_319_1.time_ >= var_322_0 + var_322_7 and arg_319_1.time_ < var_322_0 + var_322_7 + arg_322_0 then
				arg_319_1.typewritter.percent = 1

				arg_319_1.typewritter:SetDirty()
				arg_319_1:ShowNextGo(true)
			end
		end

		arg_319_1.nodeConfigList_ = {}

		arg_319_1:InitPlayNodeList()
	end,
	Play416071079 = function(arg_323_0, arg_323_1)
		arg_323_1.time_ = 0
		arg_323_1.frameCnt_ = 0
		arg_323_1.state_ = "playing"
		arg_323_1.curTalkId_ = 416071079
		arg_323_1.duration_ = 3.03

		SetActive(arg_323_1.tipsGo_, false)

		function arg_323_1.onSingleLineFinish_()
			arg_323_1.onSingleLineUpdate_ = nil
			arg_323_1.onSingleLineFinish_ = nil
			arg_323_1.state_ = "waiting"
		end

		function arg_323_1.playNext_(arg_325_0)
			if arg_325_0 == 1 then
				arg_323_0:Play416071080(arg_323_1)
			end
		end

		function arg_323_1.onSingleLineUpdate_(arg_326_0)
			local var_326_0 = arg_323_1.actors_["1148"]
			local var_326_1 = 0

			if var_326_1 < arg_323_1.time_ and arg_323_1.time_ <= var_326_1 + arg_326_0 and not isNil(var_326_0) and arg_323_1.var_.actorSpriteComps1148 == nil then
				arg_323_1.var_.actorSpriteComps1148 = var_326_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_326_2 = 0.125

			if var_326_1 <= arg_323_1.time_ and arg_323_1.time_ < var_326_1 + var_326_2 and not isNil(var_326_0) then
				local var_326_3 = (arg_323_1.time_ - var_326_1) / var_326_2

				if arg_323_1.var_.actorSpriteComps1148 then
					for iter_326_0, iter_326_1 in pairs(arg_323_1.var_.actorSpriteComps1148:ToTable()) do
						if iter_326_1 then
							if arg_323_1.isInRecall_ then
								local var_326_4 = Mathf.Lerp(iter_326_1.color.r, arg_323_1.hightColor1.r, var_326_3)
								local var_326_5 = Mathf.Lerp(iter_326_1.color.g, arg_323_1.hightColor1.g, var_326_3)
								local var_326_6 = Mathf.Lerp(iter_326_1.color.b, arg_323_1.hightColor1.b, var_326_3)

								iter_326_1.color = Color.New(var_326_4, var_326_5, var_326_6)
							else
								local var_326_7 = Mathf.Lerp(iter_326_1.color.r, 1, var_326_3)

								iter_326_1.color = Color.New(var_326_7, var_326_7, var_326_7)
							end
						end
					end
				end
			end

			if arg_323_1.time_ >= var_326_1 + var_326_2 and arg_323_1.time_ < var_326_1 + var_326_2 + arg_326_0 and not isNil(var_326_0) and arg_323_1.var_.actorSpriteComps1148 then
				for iter_326_2, iter_326_3 in pairs(arg_323_1.var_.actorSpriteComps1148:ToTable()) do
					if iter_326_3 then
						if arg_323_1.isInRecall_ then
							iter_326_3.color = arg_323_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_326_3.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_323_1.var_.actorSpriteComps1148 = nil
			end

			local var_326_8 = arg_323_1.actors_["1148"].transform
			local var_326_9 = 0

			if var_326_9 < arg_323_1.time_ and arg_323_1.time_ <= var_326_9 + arg_326_0 then
				arg_323_1.var_.moveOldPos1148 = var_326_8.localPosition
				var_326_8.localScale = Vector3.New(1, 1, 1)

				arg_323_1:CheckSpriteTmpPos("1148", 3)

				local var_326_10 = var_326_8.childCount

				for iter_326_4 = 0, var_326_10 - 1 do
					local var_326_11 = var_326_8:GetChild(iter_326_4)

					if var_326_11.name == "split_6" or not string.find(var_326_11.name, "split") then
						var_326_11.gameObject:SetActive(true)
					else
						var_326_11.gameObject:SetActive(false)
					end
				end
			end

			local var_326_12 = 0.001

			if var_326_9 <= arg_323_1.time_ and arg_323_1.time_ < var_326_9 + var_326_12 then
				local var_326_13 = (arg_323_1.time_ - var_326_9) / var_326_12
				local var_326_14 = Vector3.New(0, -429, -180)

				var_326_8.localPosition = Vector3.Lerp(arg_323_1.var_.moveOldPos1148, var_326_14, var_326_13)
			end

			if arg_323_1.time_ >= var_326_9 + var_326_12 and arg_323_1.time_ < var_326_9 + var_326_12 + arg_326_0 then
				var_326_8.localPosition = Vector3.New(0, -429, -180)
			end

			local var_326_15 = 0
			local var_326_16 = 0.3

			if var_326_15 < arg_323_1.time_ and arg_323_1.time_ <= var_326_15 + arg_326_0 then
				arg_323_1.talkMaxDuration = 0
				arg_323_1.dialogCg_.alpha = 1

				arg_323_1.dialog_:SetActive(true)
				SetActive(arg_323_1.leftNameGo_, true)

				local var_326_17 = arg_323_1:FormatText(StoryNameCfg[8].name)

				arg_323_1.leftNameTxt_.text = var_326_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_323_1.leftNameTxt_.transform)

				arg_323_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_323_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_323_1:RecordName(arg_323_1.leftNameTxt_.text)
				SetActive(arg_323_1.iconTrs_.gameObject, false)
				arg_323_1.callingController_:SetSelectedState("normal")

				local var_326_18 = arg_323_1:GetWordFromCfg(416071079)
				local var_326_19 = arg_323_1:FormatText(var_326_18.content)

				arg_323_1.text_.text = var_326_19

				LuaForUtil.ClearLinePrefixSymbol(arg_323_1.text_)

				local var_326_20 = 12
				local var_326_21 = utf8.len(var_326_19)
				local var_326_22 = var_326_20 <= 0 and var_326_16 or var_326_16 * (var_326_21 / var_326_20)

				if var_326_22 > 0 and var_326_16 < var_326_22 then
					arg_323_1.talkMaxDuration = var_326_22

					if var_326_22 + var_326_15 > arg_323_1.duration_ then
						arg_323_1.duration_ = var_326_22 + var_326_15
					end
				end

				arg_323_1.text_.text = var_326_19
				arg_323_1.typewritter.percent = 0

				arg_323_1.typewritter:SetDirty()
				arg_323_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_416071", "416071079", "story_v_out_416071.awb") ~= 0 then
					local var_326_23 = manager.audio:GetVoiceLength("story_v_out_416071", "416071079", "story_v_out_416071.awb") / 1000

					if var_326_23 + var_326_15 > arg_323_1.duration_ then
						arg_323_1.duration_ = var_326_23 + var_326_15
					end

					if var_326_18.prefab_name ~= "" and arg_323_1.actors_[var_326_18.prefab_name] ~= nil then
						local var_326_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_323_1.actors_[var_326_18.prefab_name].transform, "story_v_out_416071", "416071079", "story_v_out_416071.awb")

						arg_323_1:RecordAudio("416071079", var_326_24)
						arg_323_1:RecordAudio("416071079", var_326_24)
					else
						arg_323_1:AudioAction("play", "voice", "story_v_out_416071", "416071079", "story_v_out_416071.awb")
					end

					arg_323_1:RecordHistoryTalkVoice("story_v_out_416071", "416071079", "story_v_out_416071.awb")
				end

				arg_323_1:RecordContent(arg_323_1.text_.text)
			end

			local var_326_25 = math.max(var_326_16, arg_323_1.talkMaxDuration)

			if var_326_15 <= arg_323_1.time_ and arg_323_1.time_ < var_326_15 + var_326_25 then
				arg_323_1.typewritter.percent = (arg_323_1.time_ - var_326_15) / var_326_25

				arg_323_1.typewritter:SetDirty()
			end

			if arg_323_1.time_ >= var_326_15 + var_326_25 and arg_323_1.time_ < var_326_15 + var_326_25 + arg_326_0 then
				arg_323_1.typewritter.percent = 1

				arg_323_1.typewritter:SetDirty()
				arg_323_1:ShowNextGo(true)
			end
		end

		arg_323_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1148",
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
	Play416071080 = function(arg_327_0, arg_327_1)
		arg_327_1.time_ = 0
		arg_327_1.frameCnt_ = 0
		arg_327_1.state_ = "playing"
		arg_327_1.curTalkId_ = 416071080
		arg_327_1.duration_ = 1.4

		SetActive(arg_327_1.tipsGo_, false)

		function arg_327_1.onSingleLineFinish_()
			arg_327_1.onSingleLineUpdate_ = nil
			arg_327_1.onSingleLineFinish_ = nil
			arg_327_1.state_ = "waiting"
		end

		function arg_327_1.playNext_(arg_329_0)
			if arg_329_0 == 1 then
				arg_327_0:Play416071081(arg_327_1)
			end
		end

		function arg_327_1.onSingleLineUpdate_(arg_330_0)
			local var_330_0 = arg_327_1.actors_["1148"].transform
			local var_330_1 = 0

			if var_330_1 < arg_327_1.time_ and arg_327_1.time_ <= var_330_1 + arg_330_0 then
				arg_327_1.var_.moveOldPos1148 = var_330_0.localPosition
				var_330_0.localScale = Vector3.New(1, 1, 1)

				arg_327_1:CheckSpriteTmpPos("1148", 2)

				local var_330_2 = var_330_0.childCount

				for iter_330_0 = 0, var_330_2 - 1 do
					local var_330_3 = var_330_0:GetChild(iter_330_0)

					if var_330_3.name == "split_6" or not string.find(var_330_3.name, "split") then
						var_330_3.gameObject:SetActive(true)
					else
						var_330_3.gameObject:SetActive(false)
					end
				end
			end

			local var_330_4 = 0.001

			if var_330_1 <= arg_327_1.time_ and arg_327_1.time_ < var_330_1 + var_330_4 then
				local var_330_5 = (arg_327_1.time_ - var_330_1) / var_330_4
				local var_330_6 = Vector3.New(-390, -429, -180)

				var_330_0.localPosition = Vector3.Lerp(arg_327_1.var_.moveOldPos1148, var_330_6, var_330_5)
			end

			if arg_327_1.time_ >= var_330_1 + var_330_4 and arg_327_1.time_ < var_330_1 + var_330_4 + arg_330_0 then
				var_330_0.localPosition = Vector3.New(-390, -429, -180)
			end

			local var_330_7 = arg_327_1.actors_["1148"]
			local var_330_8 = 0

			if var_330_8 < arg_327_1.time_ and arg_327_1.time_ <= var_330_8 + arg_330_0 and not isNil(var_330_7) and arg_327_1.var_.actorSpriteComps1148 == nil then
				arg_327_1.var_.actorSpriteComps1148 = var_330_7:GetComponentsInChildren(typeof(Image), true)
			end

			local var_330_9 = 0.125

			if var_330_8 <= arg_327_1.time_ and arg_327_1.time_ < var_330_8 + var_330_9 and not isNil(var_330_7) then
				local var_330_10 = (arg_327_1.time_ - var_330_8) / var_330_9

				if arg_327_1.var_.actorSpriteComps1148 then
					for iter_330_1, iter_330_2 in pairs(arg_327_1.var_.actorSpriteComps1148:ToTable()) do
						if iter_330_2 then
							if arg_327_1.isInRecall_ then
								local var_330_11 = Mathf.Lerp(iter_330_2.color.r, arg_327_1.hightColor2.r, var_330_10)
								local var_330_12 = Mathf.Lerp(iter_330_2.color.g, arg_327_1.hightColor2.g, var_330_10)
								local var_330_13 = Mathf.Lerp(iter_330_2.color.b, arg_327_1.hightColor2.b, var_330_10)

								iter_330_2.color = Color.New(var_330_11, var_330_12, var_330_13)
							else
								local var_330_14 = Mathf.Lerp(iter_330_2.color.r, 0.5, var_330_10)

								iter_330_2.color = Color.New(var_330_14, var_330_14, var_330_14)
							end
						end
					end
				end
			end

			if arg_327_1.time_ >= var_330_8 + var_330_9 and arg_327_1.time_ < var_330_8 + var_330_9 + arg_330_0 and not isNil(var_330_7) and arg_327_1.var_.actorSpriteComps1148 then
				for iter_330_3, iter_330_4 in pairs(arg_327_1.var_.actorSpriteComps1148:ToTable()) do
					if iter_330_4 then
						if arg_327_1.isInRecall_ then
							iter_330_4.color = arg_327_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_330_4.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_327_1.var_.actorSpriteComps1148 = nil
			end

			local var_330_15 = arg_327_1.actors_["10108"]
			local var_330_16 = 0

			if var_330_16 < arg_327_1.time_ and arg_327_1.time_ <= var_330_16 + arg_330_0 and not isNil(var_330_15) and arg_327_1.var_.actorSpriteComps10108 == nil then
				arg_327_1.var_.actorSpriteComps10108 = var_330_15:GetComponentsInChildren(typeof(Image), true)
			end

			local var_330_17 = 0.125

			if var_330_16 <= arg_327_1.time_ and arg_327_1.time_ < var_330_16 + var_330_17 and not isNil(var_330_15) then
				local var_330_18 = (arg_327_1.time_ - var_330_16) / var_330_17

				if arg_327_1.var_.actorSpriteComps10108 then
					for iter_330_5, iter_330_6 in pairs(arg_327_1.var_.actorSpriteComps10108:ToTable()) do
						if iter_330_6 then
							if arg_327_1.isInRecall_ then
								local var_330_19 = Mathf.Lerp(iter_330_6.color.r, arg_327_1.hightColor1.r, var_330_18)
								local var_330_20 = Mathf.Lerp(iter_330_6.color.g, arg_327_1.hightColor1.g, var_330_18)
								local var_330_21 = Mathf.Lerp(iter_330_6.color.b, arg_327_1.hightColor1.b, var_330_18)

								iter_330_6.color = Color.New(var_330_19, var_330_20, var_330_21)
							else
								local var_330_22 = Mathf.Lerp(iter_330_6.color.r, 1, var_330_18)

								iter_330_6.color = Color.New(var_330_22, var_330_22, var_330_22)
							end
						end
					end
				end
			end

			if arg_327_1.time_ >= var_330_16 + var_330_17 and arg_327_1.time_ < var_330_16 + var_330_17 + arg_330_0 and not isNil(var_330_15) and arg_327_1.var_.actorSpriteComps10108 then
				for iter_330_7, iter_330_8 in pairs(arg_327_1.var_.actorSpriteComps10108:ToTable()) do
					if iter_330_8 then
						if arg_327_1.isInRecall_ then
							iter_330_8.color = arg_327_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_330_8.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_327_1.var_.actorSpriteComps10108 = nil
			end

			local var_330_23 = arg_327_1.actors_["10108"].transform
			local var_330_24 = 0

			if var_330_24 < arg_327_1.time_ and arg_327_1.time_ <= var_330_24 + arg_330_0 then
				arg_327_1.var_.moveOldPos10108 = var_330_23.localPosition
				var_330_23.localScale = Vector3.New(1, 1, 1)

				arg_327_1:CheckSpriteTmpPos("10108", 4)

				local var_330_25 = var_330_23.childCount

				for iter_330_9 = 0, var_330_25 - 1 do
					local var_330_26 = var_330_23:GetChild(iter_330_9)

					if var_330_26.name == "split_1" or not string.find(var_330_26.name, "split") then
						var_330_26.gameObject:SetActive(true)
					else
						var_330_26.gameObject:SetActive(false)
					end
				end
			end

			local var_330_27 = 0.001

			if var_330_24 <= arg_327_1.time_ and arg_327_1.time_ < var_330_24 + var_330_27 then
				local var_330_28 = (arg_327_1.time_ - var_330_24) / var_330_27
				local var_330_29 = Vector3.New(390, -399.6, -130)

				var_330_23.localPosition = Vector3.Lerp(arg_327_1.var_.moveOldPos10108, var_330_29, var_330_28)
			end

			if arg_327_1.time_ >= var_330_24 + var_330_27 and arg_327_1.time_ < var_330_24 + var_330_27 + arg_330_0 then
				var_330_23.localPosition = Vector3.New(390, -399.6, -130)
			end

			local var_330_30 = 0
			local var_330_31 = 0.1

			if var_330_30 < arg_327_1.time_ and arg_327_1.time_ <= var_330_30 + arg_330_0 then
				arg_327_1.talkMaxDuration = 0
				arg_327_1.dialogCg_.alpha = 1

				arg_327_1.dialog_:SetActive(true)
				SetActive(arg_327_1.leftNameGo_, true)

				local var_330_32 = arg_327_1:FormatText(StoryNameCfg[1083].name)

				arg_327_1.leftNameTxt_.text = var_330_32

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_327_1.leftNameTxt_.transform)

				arg_327_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_327_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_327_1:RecordName(arg_327_1.leftNameTxt_.text)
				SetActive(arg_327_1.iconTrs_.gameObject, false)
				arg_327_1.callingController_:SetSelectedState("normal")

				local var_330_33 = arg_327_1:GetWordFromCfg(416071080)
				local var_330_34 = arg_327_1:FormatText(var_330_33.content)

				arg_327_1.text_.text = var_330_34

				LuaForUtil.ClearLinePrefixSymbol(arg_327_1.text_)

				local var_330_35 = 4
				local var_330_36 = utf8.len(var_330_34)
				local var_330_37 = var_330_35 <= 0 and var_330_31 or var_330_31 * (var_330_36 / var_330_35)

				if var_330_37 > 0 and var_330_31 < var_330_37 then
					arg_327_1.talkMaxDuration = var_330_37

					if var_330_37 + var_330_30 > arg_327_1.duration_ then
						arg_327_1.duration_ = var_330_37 + var_330_30
					end
				end

				arg_327_1.text_.text = var_330_34
				arg_327_1.typewritter.percent = 0

				arg_327_1.typewritter:SetDirty()
				arg_327_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_416071", "416071080", "story_v_out_416071.awb") ~= 0 then
					local var_330_38 = manager.audio:GetVoiceLength("story_v_out_416071", "416071080", "story_v_out_416071.awb") / 1000

					if var_330_38 + var_330_30 > arg_327_1.duration_ then
						arg_327_1.duration_ = var_330_38 + var_330_30
					end

					if var_330_33.prefab_name ~= "" and arg_327_1.actors_[var_330_33.prefab_name] ~= nil then
						local var_330_39 = LuaForUtil.PlayVoiceWithCriLipsync(arg_327_1.actors_[var_330_33.prefab_name].transform, "story_v_out_416071", "416071080", "story_v_out_416071.awb")

						arg_327_1:RecordAudio("416071080", var_330_39)
						arg_327_1:RecordAudio("416071080", var_330_39)
					else
						arg_327_1:AudioAction("play", "voice", "story_v_out_416071", "416071080", "story_v_out_416071.awb")
					end

					arg_327_1:RecordHistoryTalkVoice("story_v_out_416071", "416071080", "story_v_out_416071.awb")
				end

				arg_327_1:RecordContent(arg_327_1.text_.text)
			end

			local var_330_40 = math.max(var_330_31, arg_327_1.talkMaxDuration)

			if var_330_30 <= arg_327_1.time_ and arg_327_1.time_ < var_330_30 + var_330_40 then
				arg_327_1.typewritter.percent = (arg_327_1.time_ - var_330_30) / var_330_40

				arg_327_1.typewritter:SetDirty()
			end

			if arg_327_1.time_ >= var_330_30 + var_330_40 and arg_327_1.time_ < var_330_30 + var_330_40 + arg_330_0 then
				arg_327_1.typewritter.percent = 1

				arg_327_1.typewritter:SetDirty()
				arg_327_1:ShowNextGo(true)
			end
		end

		arg_327_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1148",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			},
			{
				assetPath = "",
				actorName = "10108",
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
	Play416071081 = function(arg_331_0, arg_331_1)
		arg_331_1.time_ = 0
		arg_331_1.frameCnt_ = 0
		arg_331_1.state_ = "playing"
		arg_331_1.curTalkId_ = 416071081
		arg_331_1.duration_ = 4.47

		local var_331_0 = {
			zh = 4.466,
			ja = 3.9
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
				arg_331_0:Play416071082(arg_331_1)
			end
		end

		function arg_331_1.onSingleLineUpdate_(arg_334_0)
			local var_334_0 = arg_331_1.actors_["1148"]
			local var_334_1 = 0

			if var_334_1 < arg_331_1.time_ and arg_331_1.time_ <= var_334_1 + arg_334_0 and not isNil(var_334_0) and arg_331_1.var_.actorSpriteComps1148 == nil then
				arg_331_1.var_.actorSpriteComps1148 = var_334_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_334_2 = 0.125

			if var_334_1 <= arg_331_1.time_ and arg_331_1.time_ < var_334_1 + var_334_2 and not isNil(var_334_0) then
				local var_334_3 = (arg_331_1.time_ - var_334_1) / var_334_2

				if arg_331_1.var_.actorSpriteComps1148 then
					for iter_334_0, iter_334_1 in pairs(arg_331_1.var_.actorSpriteComps1148:ToTable()) do
						if iter_334_1 then
							if arg_331_1.isInRecall_ then
								local var_334_4 = Mathf.Lerp(iter_334_1.color.r, arg_331_1.hightColor1.r, var_334_3)
								local var_334_5 = Mathf.Lerp(iter_334_1.color.g, arg_331_1.hightColor1.g, var_334_3)
								local var_334_6 = Mathf.Lerp(iter_334_1.color.b, arg_331_1.hightColor1.b, var_334_3)

								iter_334_1.color = Color.New(var_334_4, var_334_5, var_334_6)
							else
								local var_334_7 = Mathf.Lerp(iter_334_1.color.r, 1, var_334_3)

								iter_334_1.color = Color.New(var_334_7, var_334_7, var_334_7)
							end
						end
					end
				end
			end

			if arg_331_1.time_ >= var_334_1 + var_334_2 and arg_331_1.time_ < var_334_1 + var_334_2 + arg_334_0 and not isNil(var_334_0) and arg_331_1.var_.actorSpriteComps1148 then
				for iter_334_2, iter_334_3 in pairs(arg_331_1.var_.actorSpriteComps1148:ToTable()) do
					if iter_334_3 then
						if arg_331_1.isInRecall_ then
							iter_334_3.color = arg_331_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_334_3.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_331_1.var_.actorSpriteComps1148 = nil
			end

			local var_334_8 = arg_331_1.actors_["10108"]
			local var_334_9 = 0

			if var_334_9 < arg_331_1.time_ and arg_331_1.time_ <= var_334_9 + arg_334_0 and not isNil(var_334_8) and arg_331_1.var_.actorSpriteComps10108 == nil then
				arg_331_1.var_.actorSpriteComps10108 = var_334_8:GetComponentsInChildren(typeof(Image), true)
			end

			local var_334_10 = 0.125

			if var_334_9 <= arg_331_1.time_ and arg_331_1.time_ < var_334_9 + var_334_10 and not isNil(var_334_8) then
				local var_334_11 = (arg_331_1.time_ - var_334_9) / var_334_10

				if arg_331_1.var_.actorSpriteComps10108 then
					for iter_334_4, iter_334_5 in pairs(arg_331_1.var_.actorSpriteComps10108:ToTable()) do
						if iter_334_5 then
							if arg_331_1.isInRecall_ then
								local var_334_12 = Mathf.Lerp(iter_334_5.color.r, arg_331_1.hightColor2.r, var_334_11)
								local var_334_13 = Mathf.Lerp(iter_334_5.color.g, arg_331_1.hightColor2.g, var_334_11)
								local var_334_14 = Mathf.Lerp(iter_334_5.color.b, arg_331_1.hightColor2.b, var_334_11)

								iter_334_5.color = Color.New(var_334_12, var_334_13, var_334_14)
							else
								local var_334_15 = Mathf.Lerp(iter_334_5.color.r, 0.5, var_334_11)

								iter_334_5.color = Color.New(var_334_15, var_334_15, var_334_15)
							end
						end
					end
				end
			end

			if arg_331_1.time_ >= var_334_9 + var_334_10 and arg_331_1.time_ < var_334_9 + var_334_10 + arg_334_0 and not isNil(var_334_8) and arg_331_1.var_.actorSpriteComps10108 then
				for iter_334_6, iter_334_7 in pairs(arg_331_1.var_.actorSpriteComps10108:ToTable()) do
					if iter_334_7 then
						if arg_331_1.isInRecall_ then
							iter_334_7.color = arg_331_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_334_7.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_331_1.var_.actorSpriteComps10108 = nil
			end

			local var_334_16 = 0
			local var_334_17 = 0.45

			if var_334_16 < arg_331_1.time_ and arg_331_1.time_ <= var_334_16 + arg_334_0 then
				arg_331_1.talkMaxDuration = 0
				arg_331_1.dialogCg_.alpha = 1

				arg_331_1.dialog_:SetActive(true)
				SetActive(arg_331_1.leftNameGo_, true)

				local var_334_18 = arg_331_1:FormatText(StoryNameCfg[8].name)

				arg_331_1.leftNameTxt_.text = var_334_18

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_331_1.leftNameTxt_.transform)

				arg_331_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_331_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_331_1:RecordName(arg_331_1.leftNameTxt_.text)
				SetActive(arg_331_1.iconTrs_.gameObject, false)
				arg_331_1.callingController_:SetSelectedState("normal")

				local var_334_19 = arg_331_1:GetWordFromCfg(416071081)
				local var_334_20 = arg_331_1:FormatText(var_334_19.content)

				arg_331_1.text_.text = var_334_20

				LuaForUtil.ClearLinePrefixSymbol(arg_331_1.text_)

				local var_334_21 = 18
				local var_334_22 = utf8.len(var_334_20)
				local var_334_23 = var_334_21 <= 0 and var_334_17 or var_334_17 * (var_334_22 / var_334_21)

				if var_334_23 > 0 and var_334_17 < var_334_23 then
					arg_331_1.talkMaxDuration = var_334_23

					if var_334_23 + var_334_16 > arg_331_1.duration_ then
						arg_331_1.duration_ = var_334_23 + var_334_16
					end
				end

				arg_331_1.text_.text = var_334_20
				arg_331_1.typewritter.percent = 0

				arg_331_1.typewritter:SetDirty()
				arg_331_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_416071", "416071081", "story_v_out_416071.awb") ~= 0 then
					local var_334_24 = manager.audio:GetVoiceLength("story_v_out_416071", "416071081", "story_v_out_416071.awb") / 1000

					if var_334_24 + var_334_16 > arg_331_1.duration_ then
						arg_331_1.duration_ = var_334_24 + var_334_16
					end

					if var_334_19.prefab_name ~= "" and arg_331_1.actors_[var_334_19.prefab_name] ~= nil then
						local var_334_25 = LuaForUtil.PlayVoiceWithCriLipsync(arg_331_1.actors_[var_334_19.prefab_name].transform, "story_v_out_416071", "416071081", "story_v_out_416071.awb")

						arg_331_1:RecordAudio("416071081", var_334_25)
						arg_331_1:RecordAudio("416071081", var_334_25)
					else
						arg_331_1:AudioAction("play", "voice", "story_v_out_416071", "416071081", "story_v_out_416071.awb")
					end

					arg_331_1:RecordHistoryTalkVoice("story_v_out_416071", "416071081", "story_v_out_416071.awb")
				end

				arg_331_1:RecordContent(arg_331_1.text_.text)
			end

			local var_334_26 = math.max(var_334_17, arg_331_1.talkMaxDuration)

			if var_334_16 <= arg_331_1.time_ and arg_331_1.time_ < var_334_16 + var_334_26 then
				arg_331_1.typewritter.percent = (arg_331_1.time_ - var_334_16) / var_334_26

				arg_331_1.typewritter:SetDirty()
			end

			if arg_331_1.time_ >= var_334_16 + var_334_26 and arg_331_1.time_ < var_334_16 + var_334_26 + arg_334_0 then
				arg_331_1.typewritter.percent = 1

				arg_331_1.typewritter:SetDirty()
				arg_331_1:ShowNextGo(true)
			end
		end

		arg_331_1.nodeConfigList_ = {}

		arg_331_1:InitPlayNodeList()
	end,
	Play416071082 = function(arg_335_0, arg_335_1)
		arg_335_1.time_ = 0
		arg_335_1.frameCnt_ = 0
		arg_335_1.state_ = "playing"
		arg_335_1.curTalkId_ = 416071082
		arg_335_1.duration_ = 14.5

		local var_335_0 = {
			zh = 10.6,
			ja = 14.5
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
		end

		function arg_335_1.playNext_(arg_337_0)
			if arg_337_0 == 1 then
				arg_335_0:Play416071083(arg_335_1)
			end
		end

		function arg_335_1.onSingleLineUpdate_(arg_338_0)
			local var_338_0 = arg_335_1.actors_["1148"]
			local var_338_1 = 0

			if var_338_1 < arg_335_1.time_ and arg_335_1.time_ <= var_338_1 + arg_338_0 and not isNil(var_338_0) and arg_335_1.var_.actorSpriteComps1148 == nil then
				arg_335_1.var_.actorSpriteComps1148 = var_338_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_338_2 = 0.125

			if var_338_1 <= arg_335_1.time_ and arg_335_1.time_ < var_338_1 + var_338_2 and not isNil(var_338_0) then
				local var_338_3 = (arg_335_1.time_ - var_338_1) / var_338_2

				if arg_335_1.var_.actorSpriteComps1148 then
					for iter_338_0, iter_338_1 in pairs(arg_335_1.var_.actorSpriteComps1148:ToTable()) do
						if iter_338_1 then
							if arg_335_1.isInRecall_ then
								local var_338_4 = Mathf.Lerp(iter_338_1.color.r, arg_335_1.hightColor2.r, var_338_3)
								local var_338_5 = Mathf.Lerp(iter_338_1.color.g, arg_335_1.hightColor2.g, var_338_3)
								local var_338_6 = Mathf.Lerp(iter_338_1.color.b, arg_335_1.hightColor2.b, var_338_3)

								iter_338_1.color = Color.New(var_338_4, var_338_5, var_338_6)
							else
								local var_338_7 = Mathf.Lerp(iter_338_1.color.r, 0.5, var_338_3)

								iter_338_1.color = Color.New(var_338_7, var_338_7, var_338_7)
							end
						end
					end
				end
			end

			if arg_335_1.time_ >= var_338_1 + var_338_2 and arg_335_1.time_ < var_338_1 + var_338_2 + arg_338_0 and not isNil(var_338_0) and arg_335_1.var_.actorSpriteComps1148 then
				for iter_338_2, iter_338_3 in pairs(arg_335_1.var_.actorSpriteComps1148:ToTable()) do
					if iter_338_3 then
						if arg_335_1.isInRecall_ then
							iter_338_3.color = arg_335_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_338_3.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_335_1.var_.actorSpriteComps1148 = nil
			end

			local var_338_8 = arg_335_1.actors_["10108"]
			local var_338_9 = 0

			if var_338_9 < arg_335_1.time_ and arg_335_1.time_ <= var_338_9 + arg_338_0 and not isNil(var_338_8) and arg_335_1.var_.actorSpriteComps10108 == nil then
				arg_335_1.var_.actorSpriteComps10108 = var_338_8:GetComponentsInChildren(typeof(Image), true)
			end

			local var_338_10 = 0.125

			if var_338_9 <= arg_335_1.time_ and arg_335_1.time_ < var_338_9 + var_338_10 and not isNil(var_338_8) then
				local var_338_11 = (arg_335_1.time_ - var_338_9) / var_338_10

				if arg_335_1.var_.actorSpriteComps10108 then
					for iter_338_4, iter_338_5 in pairs(arg_335_1.var_.actorSpriteComps10108:ToTable()) do
						if iter_338_5 then
							if arg_335_1.isInRecall_ then
								local var_338_12 = Mathf.Lerp(iter_338_5.color.r, arg_335_1.hightColor1.r, var_338_11)
								local var_338_13 = Mathf.Lerp(iter_338_5.color.g, arg_335_1.hightColor1.g, var_338_11)
								local var_338_14 = Mathf.Lerp(iter_338_5.color.b, arg_335_1.hightColor1.b, var_338_11)

								iter_338_5.color = Color.New(var_338_12, var_338_13, var_338_14)
							else
								local var_338_15 = Mathf.Lerp(iter_338_5.color.r, 1, var_338_11)

								iter_338_5.color = Color.New(var_338_15, var_338_15, var_338_15)
							end
						end
					end
				end
			end

			if arg_335_1.time_ >= var_338_9 + var_338_10 and arg_335_1.time_ < var_338_9 + var_338_10 + arg_338_0 and not isNil(var_338_8) and arg_335_1.var_.actorSpriteComps10108 then
				for iter_338_6, iter_338_7 in pairs(arg_335_1.var_.actorSpriteComps10108:ToTable()) do
					if iter_338_7 then
						if arg_335_1.isInRecall_ then
							iter_338_7.color = arg_335_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_338_7.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_335_1.var_.actorSpriteComps10108 = nil
			end

			local var_338_16 = 0
			local var_338_17 = 0.925

			if var_338_16 < arg_335_1.time_ and arg_335_1.time_ <= var_338_16 + arg_338_0 then
				arg_335_1.talkMaxDuration = 0
				arg_335_1.dialogCg_.alpha = 1

				arg_335_1.dialog_:SetActive(true)
				SetActive(arg_335_1.leftNameGo_, true)

				local var_338_18 = arg_335_1:FormatText(StoryNameCfg[1083].name)

				arg_335_1.leftNameTxt_.text = var_338_18

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_335_1.leftNameTxt_.transform)

				arg_335_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_335_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_335_1:RecordName(arg_335_1.leftNameTxt_.text)
				SetActive(arg_335_1.iconTrs_.gameObject, false)
				arg_335_1.callingController_:SetSelectedState("normal")

				local var_338_19 = arg_335_1:GetWordFromCfg(416071082)
				local var_338_20 = arg_335_1:FormatText(var_338_19.content)

				arg_335_1.text_.text = var_338_20

				LuaForUtil.ClearLinePrefixSymbol(arg_335_1.text_)

				local var_338_21 = 36
				local var_338_22 = utf8.len(var_338_20)
				local var_338_23 = var_338_21 <= 0 and var_338_17 or var_338_17 * (var_338_22 / var_338_21)

				if var_338_23 > 0 and var_338_17 < var_338_23 then
					arg_335_1.talkMaxDuration = var_338_23

					if var_338_23 + var_338_16 > arg_335_1.duration_ then
						arg_335_1.duration_ = var_338_23 + var_338_16
					end
				end

				arg_335_1.text_.text = var_338_20
				arg_335_1.typewritter.percent = 0

				arg_335_1.typewritter:SetDirty()
				arg_335_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_416071", "416071082", "story_v_out_416071.awb") ~= 0 then
					local var_338_24 = manager.audio:GetVoiceLength("story_v_out_416071", "416071082", "story_v_out_416071.awb") / 1000

					if var_338_24 + var_338_16 > arg_335_1.duration_ then
						arg_335_1.duration_ = var_338_24 + var_338_16
					end

					if var_338_19.prefab_name ~= "" and arg_335_1.actors_[var_338_19.prefab_name] ~= nil then
						local var_338_25 = LuaForUtil.PlayVoiceWithCriLipsync(arg_335_1.actors_[var_338_19.prefab_name].transform, "story_v_out_416071", "416071082", "story_v_out_416071.awb")

						arg_335_1:RecordAudio("416071082", var_338_25)
						arg_335_1:RecordAudio("416071082", var_338_25)
					else
						arg_335_1:AudioAction("play", "voice", "story_v_out_416071", "416071082", "story_v_out_416071.awb")
					end

					arg_335_1:RecordHistoryTalkVoice("story_v_out_416071", "416071082", "story_v_out_416071.awb")
				end

				arg_335_1:RecordContent(arg_335_1.text_.text)
			end

			local var_338_26 = math.max(var_338_17, arg_335_1.talkMaxDuration)

			if var_338_16 <= arg_335_1.time_ and arg_335_1.time_ < var_338_16 + var_338_26 then
				arg_335_1.typewritter.percent = (arg_335_1.time_ - var_338_16) / var_338_26

				arg_335_1.typewritter:SetDirty()
			end

			if arg_335_1.time_ >= var_338_16 + var_338_26 and arg_335_1.time_ < var_338_16 + var_338_26 + arg_338_0 then
				arg_335_1.typewritter.percent = 1

				arg_335_1.typewritter:SetDirty()
				arg_335_1:ShowNextGo(true)
			end
		end

		arg_335_1.nodeConfigList_ = {}

		arg_335_1:InitPlayNodeList()
	end,
	Play416071083 = function(arg_339_0, arg_339_1)
		arg_339_1.time_ = 0
		arg_339_1.frameCnt_ = 0
		arg_339_1.state_ = "playing"
		arg_339_1.curTalkId_ = 416071083
		arg_339_1.duration_ = 9.3

		local var_339_0 = {
			zh = 9.3,
			ja = 7
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
				arg_339_0:Play416071084(arg_339_1)
			end
		end

		function arg_339_1.onSingleLineUpdate_(arg_342_0)
			local var_342_0 = arg_339_1.actors_["1148"]
			local var_342_1 = 0

			if var_342_1 < arg_339_1.time_ and arg_339_1.time_ <= var_342_1 + arg_342_0 and not isNil(var_342_0) and arg_339_1.var_.actorSpriteComps1148 == nil then
				arg_339_1.var_.actorSpriteComps1148 = var_342_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_342_2 = 0.125

			if var_342_1 <= arg_339_1.time_ and arg_339_1.time_ < var_342_1 + var_342_2 and not isNil(var_342_0) then
				local var_342_3 = (arg_339_1.time_ - var_342_1) / var_342_2

				if arg_339_1.var_.actorSpriteComps1148 then
					for iter_342_0, iter_342_1 in pairs(arg_339_1.var_.actorSpriteComps1148:ToTable()) do
						if iter_342_1 then
							if arg_339_1.isInRecall_ then
								local var_342_4 = Mathf.Lerp(iter_342_1.color.r, arg_339_1.hightColor1.r, var_342_3)
								local var_342_5 = Mathf.Lerp(iter_342_1.color.g, arg_339_1.hightColor1.g, var_342_3)
								local var_342_6 = Mathf.Lerp(iter_342_1.color.b, arg_339_1.hightColor1.b, var_342_3)

								iter_342_1.color = Color.New(var_342_4, var_342_5, var_342_6)
							else
								local var_342_7 = Mathf.Lerp(iter_342_1.color.r, 1, var_342_3)

								iter_342_1.color = Color.New(var_342_7, var_342_7, var_342_7)
							end
						end
					end
				end
			end

			if arg_339_1.time_ >= var_342_1 + var_342_2 and arg_339_1.time_ < var_342_1 + var_342_2 + arg_342_0 and not isNil(var_342_0) and arg_339_1.var_.actorSpriteComps1148 then
				for iter_342_2, iter_342_3 in pairs(arg_339_1.var_.actorSpriteComps1148:ToTable()) do
					if iter_342_3 then
						if arg_339_1.isInRecall_ then
							iter_342_3.color = arg_339_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_342_3.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_339_1.var_.actorSpriteComps1148 = nil
			end

			local var_342_8 = arg_339_1.actors_["10108"]
			local var_342_9 = 0

			if var_342_9 < arg_339_1.time_ and arg_339_1.time_ <= var_342_9 + arg_342_0 and not isNil(var_342_8) and arg_339_1.var_.actorSpriteComps10108 == nil then
				arg_339_1.var_.actorSpriteComps10108 = var_342_8:GetComponentsInChildren(typeof(Image), true)
			end

			local var_342_10 = 0.125

			if var_342_9 <= arg_339_1.time_ and arg_339_1.time_ < var_342_9 + var_342_10 and not isNil(var_342_8) then
				local var_342_11 = (arg_339_1.time_ - var_342_9) / var_342_10

				if arg_339_1.var_.actorSpriteComps10108 then
					for iter_342_4, iter_342_5 in pairs(arg_339_1.var_.actorSpriteComps10108:ToTable()) do
						if iter_342_5 then
							if arg_339_1.isInRecall_ then
								local var_342_12 = Mathf.Lerp(iter_342_5.color.r, arg_339_1.hightColor2.r, var_342_11)
								local var_342_13 = Mathf.Lerp(iter_342_5.color.g, arg_339_1.hightColor2.g, var_342_11)
								local var_342_14 = Mathf.Lerp(iter_342_5.color.b, arg_339_1.hightColor2.b, var_342_11)

								iter_342_5.color = Color.New(var_342_12, var_342_13, var_342_14)
							else
								local var_342_15 = Mathf.Lerp(iter_342_5.color.r, 0.5, var_342_11)

								iter_342_5.color = Color.New(var_342_15, var_342_15, var_342_15)
							end
						end
					end
				end
			end

			if arg_339_1.time_ >= var_342_9 + var_342_10 and arg_339_1.time_ < var_342_9 + var_342_10 + arg_342_0 and not isNil(var_342_8) and arg_339_1.var_.actorSpriteComps10108 then
				for iter_342_6, iter_342_7 in pairs(arg_339_1.var_.actorSpriteComps10108:ToTable()) do
					if iter_342_7 then
						if arg_339_1.isInRecall_ then
							iter_342_7.color = arg_339_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_342_7.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_339_1.var_.actorSpriteComps10108 = nil
			end

			local var_342_16 = 0
			local var_342_17 = 0.75

			if var_342_16 < arg_339_1.time_ and arg_339_1.time_ <= var_342_16 + arg_342_0 then
				arg_339_1.talkMaxDuration = 0
				arg_339_1.dialogCg_.alpha = 1

				arg_339_1.dialog_:SetActive(true)
				SetActive(arg_339_1.leftNameGo_, true)

				local var_342_18 = arg_339_1:FormatText(StoryNameCfg[8].name)

				arg_339_1.leftNameTxt_.text = var_342_18

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_339_1.leftNameTxt_.transform)

				arg_339_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_339_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_339_1:RecordName(arg_339_1.leftNameTxt_.text)
				SetActive(arg_339_1.iconTrs_.gameObject, false)
				arg_339_1.callingController_:SetSelectedState("normal")

				local var_342_19 = arg_339_1:GetWordFromCfg(416071083)
				local var_342_20 = arg_339_1:FormatText(var_342_19.content)

				arg_339_1.text_.text = var_342_20

				LuaForUtil.ClearLinePrefixSymbol(arg_339_1.text_)

				local var_342_21 = 30
				local var_342_22 = utf8.len(var_342_20)
				local var_342_23 = var_342_21 <= 0 and var_342_17 or var_342_17 * (var_342_22 / var_342_21)

				if var_342_23 > 0 and var_342_17 < var_342_23 then
					arg_339_1.talkMaxDuration = var_342_23

					if var_342_23 + var_342_16 > arg_339_1.duration_ then
						arg_339_1.duration_ = var_342_23 + var_342_16
					end
				end

				arg_339_1.text_.text = var_342_20
				arg_339_1.typewritter.percent = 0

				arg_339_1.typewritter:SetDirty()
				arg_339_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_416071", "416071083", "story_v_out_416071.awb") ~= 0 then
					local var_342_24 = manager.audio:GetVoiceLength("story_v_out_416071", "416071083", "story_v_out_416071.awb") / 1000

					if var_342_24 + var_342_16 > arg_339_1.duration_ then
						arg_339_1.duration_ = var_342_24 + var_342_16
					end

					if var_342_19.prefab_name ~= "" and arg_339_1.actors_[var_342_19.prefab_name] ~= nil then
						local var_342_25 = LuaForUtil.PlayVoiceWithCriLipsync(arg_339_1.actors_[var_342_19.prefab_name].transform, "story_v_out_416071", "416071083", "story_v_out_416071.awb")

						arg_339_1:RecordAudio("416071083", var_342_25)
						arg_339_1:RecordAudio("416071083", var_342_25)
					else
						arg_339_1:AudioAction("play", "voice", "story_v_out_416071", "416071083", "story_v_out_416071.awb")
					end

					arg_339_1:RecordHistoryTalkVoice("story_v_out_416071", "416071083", "story_v_out_416071.awb")
				end

				arg_339_1:RecordContent(arg_339_1.text_.text)
			end

			local var_342_26 = math.max(var_342_17, arg_339_1.talkMaxDuration)

			if var_342_16 <= arg_339_1.time_ and arg_339_1.time_ < var_342_16 + var_342_26 then
				arg_339_1.typewritter.percent = (arg_339_1.time_ - var_342_16) / var_342_26

				arg_339_1.typewritter:SetDirty()
			end

			if arg_339_1.time_ >= var_342_16 + var_342_26 and arg_339_1.time_ < var_342_16 + var_342_26 + arg_342_0 then
				arg_339_1.typewritter.percent = 1

				arg_339_1.typewritter:SetDirty()
				arg_339_1:ShowNextGo(true)
			end
		end

		arg_339_1.nodeConfigList_ = {}

		arg_339_1:InitPlayNodeList()
	end,
	Play416071084 = function(arg_343_0, arg_343_1)
		arg_343_1.time_ = 0
		arg_343_1.frameCnt_ = 0
		arg_343_1.state_ = "playing"
		arg_343_1.curTalkId_ = 416071084
		arg_343_1.duration_ = 7.37

		local var_343_0 = {
			zh = 3.666,
			ja = 7.366
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
				arg_343_0:Play416071085(arg_343_1)
			end
		end

		function arg_343_1.onSingleLineUpdate_(arg_346_0)
			local var_346_0 = 0
			local var_346_1 = 0.35

			if var_346_0 < arg_343_1.time_ and arg_343_1.time_ <= var_346_0 + arg_346_0 then
				arg_343_1.talkMaxDuration = 0
				arg_343_1.dialogCg_.alpha = 1

				arg_343_1.dialog_:SetActive(true)
				SetActive(arg_343_1.leftNameGo_, true)

				local var_346_2 = arg_343_1:FormatText(StoryNameCfg[8].name)

				arg_343_1.leftNameTxt_.text = var_346_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_343_1.leftNameTxt_.transform)

				arg_343_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_343_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_343_1:RecordName(arg_343_1.leftNameTxt_.text)
				SetActive(arg_343_1.iconTrs_.gameObject, false)
				arg_343_1.callingController_:SetSelectedState("normal")

				local var_346_3 = arg_343_1:GetWordFromCfg(416071084)
				local var_346_4 = arg_343_1:FormatText(var_346_3.content)

				arg_343_1.text_.text = var_346_4

				LuaForUtil.ClearLinePrefixSymbol(arg_343_1.text_)

				local var_346_5 = 14
				local var_346_6 = utf8.len(var_346_4)
				local var_346_7 = var_346_5 <= 0 and var_346_1 or var_346_1 * (var_346_6 / var_346_5)

				if var_346_7 > 0 and var_346_1 < var_346_7 then
					arg_343_1.talkMaxDuration = var_346_7

					if var_346_7 + var_346_0 > arg_343_1.duration_ then
						arg_343_1.duration_ = var_346_7 + var_346_0
					end
				end

				arg_343_1.text_.text = var_346_4
				arg_343_1.typewritter.percent = 0

				arg_343_1.typewritter:SetDirty()
				arg_343_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_416071", "416071084", "story_v_out_416071.awb") ~= 0 then
					local var_346_8 = manager.audio:GetVoiceLength("story_v_out_416071", "416071084", "story_v_out_416071.awb") / 1000

					if var_346_8 + var_346_0 > arg_343_1.duration_ then
						arg_343_1.duration_ = var_346_8 + var_346_0
					end

					if var_346_3.prefab_name ~= "" and arg_343_1.actors_[var_346_3.prefab_name] ~= nil then
						local var_346_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_343_1.actors_[var_346_3.prefab_name].transform, "story_v_out_416071", "416071084", "story_v_out_416071.awb")

						arg_343_1:RecordAudio("416071084", var_346_9)
						arg_343_1:RecordAudio("416071084", var_346_9)
					else
						arg_343_1:AudioAction("play", "voice", "story_v_out_416071", "416071084", "story_v_out_416071.awb")
					end

					arg_343_1:RecordHistoryTalkVoice("story_v_out_416071", "416071084", "story_v_out_416071.awb")
				end

				arg_343_1:RecordContent(arg_343_1.text_.text)
			end

			local var_346_10 = math.max(var_346_1, arg_343_1.talkMaxDuration)

			if var_346_0 <= arg_343_1.time_ and arg_343_1.time_ < var_346_0 + var_346_10 then
				arg_343_1.typewritter.percent = (arg_343_1.time_ - var_346_0) / var_346_10

				arg_343_1.typewritter:SetDirty()
			end

			if arg_343_1.time_ >= var_346_0 + var_346_10 and arg_343_1.time_ < var_346_0 + var_346_10 + arg_346_0 then
				arg_343_1.typewritter.percent = 1

				arg_343_1.typewritter:SetDirty()
				arg_343_1:ShowNextGo(true)
			end
		end

		arg_343_1.nodeConfigList_ = {}

		arg_343_1:InitPlayNodeList()
	end,
	Play416071085 = function(arg_347_0, arg_347_1)
		arg_347_1.time_ = 0
		arg_347_1.frameCnt_ = 0
		arg_347_1.state_ = "playing"
		arg_347_1.curTalkId_ = 416071085
		arg_347_1.duration_ = 4.73

		local var_347_0 = {
			zh = 3,
			ja = 4.733
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
				arg_347_0:Play416071086(arg_347_1)
			end
		end

		function arg_347_1.onSingleLineUpdate_(arg_350_0)
			local var_350_0 = 0
			local var_350_1 = 0.325

			if var_350_0 < arg_347_1.time_ and arg_347_1.time_ <= var_350_0 + arg_350_0 then
				arg_347_1.talkMaxDuration = 0
				arg_347_1.dialogCg_.alpha = 1

				arg_347_1.dialog_:SetActive(true)
				SetActive(arg_347_1.leftNameGo_, true)

				local var_350_2 = arg_347_1:FormatText(StoryNameCfg[8].name)

				arg_347_1.leftNameTxt_.text = var_350_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_347_1.leftNameTxt_.transform)

				arg_347_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_347_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_347_1:RecordName(arg_347_1.leftNameTxt_.text)
				SetActive(arg_347_1.iconTrs_.gameObject, false)
				arg_347_1.callingController_:SetSelectedState("normal")

				local var_350_3 = arg_347_1:GetWordFromCfg(416071085)
				local var_350_4 = arg_347_1:FormatText(var_350_3.content)

				arg_347_1.text_.text = var_350_4

				LuaForUtil.ClearLinePrefixSymbol(arg_347_1.text_)

				local var_350_5 = 13
				local var_350_6 = utf8.len(var_350_4)
				local var_350_7 = var_350_5 <= 0 and var_350_1 or var_350_1 * (var_350_6 / var_350_5)

				if var_350_7 > 0 and var_350_1 < var_350_7 then
					arg_347_1.talkMaxDuration = var_350_7

					if var_350_7 + var_350_0 > arg_347_1.duration_ then
						arg_347_1.duration_ = var_350_7 + var_350_0
					end
				end

				arg_347_1.text_.text = var_350_4
				arg_347_1.typewritter.percent = 0

				arg_347_1.typewritter:SetDirty()
				arg_347_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_416071", "416071085", "story_v_out_416071.awb") ~= 0 then
					local var_350_8 = manager.audio:GetVoiceLength("story_v_out_416071", "416071085", "story_v_out_416071.awb") / 1000

					if var_350_8 + var_350_0 > arg_347_1.duration_ then
						arg_347_1.duration_ = var_350_8 + var_350_0
					end

					if var_350_3.prefab_name ~= "" and arg_347_1.actors_[var_350_3.prefab_name] ~= nil then
						local var_350_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_347_1.actors_[var_350_3.prefab_name].transform, "story_v_out_416071", "416071085", "story_v_out_416071.awb")

						arg_347_1:RecordAudio("416071085", var_350_9)
						arg_347_1:RecordAudio("416071085", var_350_9)
					else
						arg_347_1:AudioAction("play", "voice", "story_v_out_416071", "416071085", "story_v_out_416071.awb")
					end

					arg_347_1:RecordHistoryTalkVoice("story_v_out_416071", "416071085", "story_v_out_416071.awb")
				end

				arg_347_1:RecordContent(arg_347_1.text_.text)
			end

			local var_350_10 = math.max(var_350_1, arg_347_1.talkMaxDuration)

			if var_350_0 <= arg_347_1.time_ and arg_347_1.time_ < var_350_0 + var_350_10 then
				arg_347_1.typewritter.percent = (arg_347_1.time_ - var_350_0) / var_350_10

				arg_347_1.typewritter:SetDirty()
			end

			if arg_347_1.time_ >= var_350_0 + var_350_10 and arg_347_1.time_ < var_350_0 + var_350_10 + arg_350_0 then
				arg_347_1.typewritter.percent = 1

				arg_347_1.typewritter:SetDirty()
				arg_347_1:ShowNextGo(true)
			end
		end

		arg_347_1.nodeConfigList_ = {}

		arg_347_1:InitPlayNodeList()
	end,
	Play416071086 = function(arg_351_0, arg_351_1)
		arg_351_1.time_ = 0
		arg_351_1.frameCnt_ = 0
		arg_351_1.state_ = "playing"
		arg_351_1.curTalkId_ = 416071086
		arg_351_1.duration_ = 9

		SetActive(arg_351_1.tipsGo_, false)

		function arg_351_1.onSingleLineFinish_()
			arg_351_1.onSingleLineUpdate_ = nil
			arg_351_1.onSingleLineFinish_ = nil
			arg_351_1.state_ = "waiting"
		end

		function arg_351_1.playNext_(arg_353_0)
			if arg_353_0 == 1 then
				arg_351_0:Play416071087(arg_351_1)
			end
		end

		function arg_351_1.onSingleLineUpdate_(arg_354_0)
			local var_354_0 = 4

			if var_354_0 < arg_351_1.time_ and arg_351_1.time_ <= var_354_0 + arg_354_0 then
				arg_351_1.allBtn_.enabled = false
			end

			local var_354_1 = 0.3

			if arg_351_1.time_ >= var_354_0 + var_354_1 and arg_351_1.time_ < var_354_0 + var_354_1 + arg_354_0 then
				arg_351_1.allBtn_.enabled = true
			end

			local var_354_2 = 2

			if var_354_2 < arg_351_1.time_ and arg_351_1.time_ <= var_354_2 + arg_354_0 then
				local var_354_3 = manager.ui.mainCamera.transform.localPosition
				local var_354_4 = Vector3.New(0, 0, 10) + Vector3.New(var_354_3.x, var_354_3.y, 0)
				local var_354_5 = arg_351_1.bgs_.ST0106

				var_354_5.transform.localPosition = var_354_4
				var_354_5.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_354_6 = var_354_5:GetComponent("SpriteRenderer")

				if var_354_6 and var_354_6.sprite then
					local var_354_7 = (var_354_5.transform.localPosition - var_354_3).z
					local var_354_8 = manager.ui.mainCameraCom_
					local var_354_9 = 2 * var_354_7 * Mathf.Tan(var_354_8.fieldOfView * 0.5 * Mathf.Deg2Rad)
					local var_354_10 = var_354_9 * var_354_8.aspect
					local var_354_11 = var_354_6.sprite.bounds.size.x
					local var_354_12 = var_354_6.sprite.bounds.size.y
					local var_354_13 = var_354_10 / var_354_11
					local var_354_14 = var_354_9 / var_354_12
					local var_354_15 = var_354_14 < var_354_13 and var_354_13 or var_354_14

					var_354_5.transform.localScale = Vector3.New(var_354_15, var_354_15, 0)
				end

				for iter_354_0, iter_354_1 in pairs(arg_351_1.bgs_) do
					if iter_354_0 ~= "ST0106" then
						iter_354_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_354_16 = 0

			if var_354_16 < arg_351_1.time_ and arg_351_1.time_ <= var_354_16 + arg_354_0 then
				arg_351_1.mask_.enabled = true
				arg_351_1.mask_.raycastTarget = true

				arg_351_1:SetGaussion(false)
			end

			local var_354_17 = 2

			if var_354_16 <= arg_351_1.time_ and arg_351_1.time_ < var_354_16 + var_354_17 then
				local var_354_18 = (arg_351_1.time_ - var_354_16) / var_354_17
				local var_354_19 = Color.New(0, 0, 0)

				var_354_19.a = Mathf.Lerp(0, 1, var_354_18)
				arg_351_1.mask_.color = var_354_19
			end

			if arg_351_1.time_ >= var_354_16 + var_354_17 and arg_351_1.time_ < var_354_16 + var_354_17 + arg_354_0 then
				local var_354_20 = Color.New(0, 0, 0)

				var_354_20.a = 1
				arg_351_1.mask_.color = var_354_20
			end

			local var_354_21 = 2

			if var_354_21 < arg_351_1.time_ and arg_351_1.time_ <= var_354_21 + arg_354_0 then
				arg_351_1.mask_.enabled = true
				arg_351_1.mask_.raycastTarget = true

				arg_351_1:SetGaussion(false)
			end

			local var_354_22 = 2

			if var_354_21 <= arg_351_1.time_ and arg_351_1.time_ < var_354_21 + var_354_22 then
				local var_354_23 = (arg_351_1.time_ - var_354_21) / var_354_22
				local var_354_24 = Color.New(0, 0, 0)

				var_354_24.a = Mathf.Lerp(1, 0, var_354_23)
				arg_351_1.mask_.color = var_354_24
			end

			if arg_351_1.time_ >= var_354_21 + var_354_22 and arg_351_1.time_ < var_354_21 + var_354_22 + arg_354_0 then
				local var_354_25 = Color.New(0, 0, 0)
				local var_354_26 = 0

				arg_351_1.mask_.enabled = false
				var_354_25.a = var_354_26
				arg_351_1.mask_.color = var_354_25
			end

			local var_354_27 = arg_351_1.actors_["10108"].transform
			local var_354_28 = 1.966

			if var_354_28 < arg_351_1.time_ and arg_351_1.time_ <= var_354_28 + arg_354_0 then
				arg_351_1.var_.moveOldPos10108 = var_354_27.localPosition
				var_354_27.localScale = Vector3.New(1, 1, 1)

				arg_351_1:CheckSpriteTmpPos("10108", 7)

				local var_354_29 = var_354_27.childCount

				for iter_354_2 = 0, var_354_29 - 1 do
					local var_354_30 = var_354_27:GetChild(iter_354_2)

					if var_354_30.name == "" or not string.find(var_354_30.name, "split") then
						var_354_30.gameObject:SetActive(true)
					else
						var_354_30.gameObject:SetActive(false)
					end
				end
			end

			local var_354_31 = 0.001

			if var_354_28 <= arg_351_1.time_ and arg_351_1.time_ < var_354_28 + var_354_31 then
				local var_354_32 = (arg_351_1.time_ - var_354_28) / var_354_31
				local var_354_33 = Vector3.New(0, -2000, 0)

				var_354_27.localPosition = Vector3.Lerp(arg_351_1.var_.moveOldPos10108, var_354_33, var_354_32)
			end

			if arg_351_1.time_ >= var_354_28 + var_354_31 and arg_351_1.time_ < var_354_28 + var_354_31 + arg_354_0 then
				var_354_27.localPosition = Vector3.New(0, -2000, 0)
			end

			local var_354_34 = arg_351_1.actors_["1148"].transform
			local var_354_35 = 1.966

			if var_354_35 < arg_351_1.time_ and arg_351_1.time_ <= var_354_35 + arg_354_0 then
				arg_351_1.var_.moveOldPos1148 = var_354_34.localPosition
				var_354_34.localScale = Vector3.New(1, 1, 1)

				arg_351_1:CheckSpriteTmpPos("1148", 7)

				local var_354_36 = var_354_34.childCount

				for iter_354_3 = 0, var_354_36 - 1 do
					local var_354_37 = var_354_34:GetChild(iter_354_3)

					if var_354_37.name == "" or not string.find(var_354_37.name, "split") then
						var_354_37.gameObject:SetActive(true)
					else
						var_354_37.gameObject:SetActive(false)
					end
				end
			end

			local var_354_38 = 0.001

			if var_354_35 <= arg_351_1.time_ and arg_351_1.time_ < var_354_35 + var_354_38 then
				local var_354_39 = (arg_351_1.time_ - var_354_35) / var_354_38
				local var_354_40 = Vector3.New(0, -2000, 0)

				var_354_34.localPosition = Vector3.Lerp(arg_351_1.var_.moveOldPos1148, var_354_40, var_354_39)
			end

			if arg_351_1.time_ >= var_354_35 + var_354_38 and arg_351_1.time_ < var_354_35 + var_354_38 + arg_354_0 then
				var_354_34.localPosition = Vector3.New(0, -2000, 0)
			end

			if arg_351_1.frameCnt_ <= 1 then
				arg_351_1.dialog_:SetActive(false)
			end

			local var_354_41 = 4
			local var_354_42 = 1

			if var_354_41 < arg_351_1.time_ and arg_351_1.time_ <= var_354_41 + arg_354_0 then
				arg_351_1.talkMaxDuration = 0

				arg_351_1.dialog_:SetActive(true)

				arg_351_1.dialogCg_.alpha = 0

				local var_354_43 = LeanTween.value(arg_351_1.dialog_, 0, 1, 0.3)

				var_354_43:setOnUpdate(LuaHelper.FloatAction(function(arg_355_0)
					arg_351_1.dialogCg_.alpha = arg_355_0
				end))
				var_354_43:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_351_1.dialog_)
					var_354_43:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_351_1.duration_ = arg_351_1.duration_ + 0.3

				SetActive(arg_351_1.leftNameGo_, false)

				arg_351_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_351_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_351_1:RecordName(arg_351_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_351_1.iconTrs_.gameObject, false)
				arg_351_1.callingController_:SetSelectedState("normal")

				local var_354_44 = arg_351_1:GetWordFromCfg(416071086)
				local var_354_45 = arg_351_1:FormatText(var_354_44.content)

				arg_351_1.text_.text = var_354_45

				LuaForUtil.ClearLinePrefixSymbol(arg_351_1.text_)

				local var_354_46 = 40
				local var_354_47 = utf8.len(var_354_45)
				local var_354_48 = var_354_46 <= 0 and var_354_42 or var_354_42 * (var_354_47 / var_354_46)

				if var_354_48 > 0 and var_354_42 < var_354_48 then
					arg_351_1.talkMaxDuration = var_354_48
					var_354_41 = var_354_41 + 0.3

					if var_354_48 + var_354_41 > arg_351_1.duration_ then
						arg_351_1.duration_ = var_354_48 + var_354_41
					end
				end

				arg_351_1.text_.text = var_354_45
				arg_351_1.typewritter.percent = 0

				arg_351_1.typewritter:SetDirty()
				arg_351_1:ShowNextGo(false)
				arg_351_1:RecordContent(arg_351_1.text_.text)
			end

			local var_354_49 = var_354_41 + 0.3
			local var_354_50 = math.max(var_354_42, arg_351_1.talkMaxDuration)

			if var_354_49 <= arg_351_1.time_ and arg_351_1.time_ < var_354_49 + var_354_50 then
				arg_351_1.typewritter.percent = (arg_351_1.time_ - var_354_49) / var_354_50

				arg_351_1.typewritter:SetDirty()
			end

			if arg_351_1.time_ >= var_354_49 + var_354_50 and arg_351_1.time_ < var_354_49 + var_354_50 + arg_354_0 then
				arg_351_1.typewritter.percent = 1

				arg_351_1.typewritter:SetDirty()
				arg_351_1:ShowNextGo(true)
			end
		end

		arg_351_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10108",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 1.966,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			},
			{
				assetPath = "",
				actorName = "1148",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 1.966,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_351_1:InitPlayNodeList()
	end,
	Play416071087 = function(arg_357_0, arg_357_1)
		arg_357_1.time_ = 0
		arg_357_1.frameCnt_ = 0
		arg_357_1.state_ = "playing"
		arg_357_1.curTalkId_ = 416071087
		arg_357_1.duration_ = 5.63

		local var_357_0 = {
			zh = 4.033,
			ja = 5.633
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
				arg_357_0:Play416071088(arg_357_1)
			end
		end

		function arg_357_1.onSingleLineUpdate_(arg_360_0)
			local var_360_0 = arg_357_1.actors_["1148"].transform
			local var_360_1 = 0

			if var_360_1 < arg_357_1.time_ and arg_357_1.time_ <= var_360_1 + arg_360_0 then
				arg_357_1.var_.moveOldPos1148 = var_360_0.localPosition
				var_360_0.localScale = Vector3.New(1, 1, 1)

				arg_357_1:CheckSpriteTmpPos("1148", 3)

				local var_360_2 = var_360_0.childCount

				for iter_360_0 = 0, var_360_2 - 1 do
					local var_360_3 = var_360_0:GetChild(iter_360_0)

					if var_360_3.name == "split_6" or not string.find(var_360_3.name, "split") then
						var_360_3.gameObject:SetActive(true)
					else
						var_360_3.gameObject:SetActive(false)
					end
				end
			end

			local var_360_4 = 0.001

			if var_360_1 <= arg_357_1.time_ and arg_357_1.time_ < var_360_1 + var_360_4 then
				local var_360_5 = (arg_357_1.time_ - var_360_1) / var_360_4
				local var_360_6 = Vector3.New(0, -429, -180)

				var_360_0.localPosition = Vector3.Lerp(arg_357_1.var_.moveOldPos1148, var_360_6, var_360_5)
			end

			if arg_357_1.time_ >= var_360_1 + var_360_4 and arg_357_1.time_ < var_360_1 + var_360_4 + arg_360_0 then
				var_360_0.localPosition = Vector3.New(0, -429, -180)
			end

			local var_360_7 = arg_357_1.actors_["1148"]
			local var_360_8 = 0

			if var_360_8 < arg_357_1.time_ and arg_357_1.time_ <= var_360_8 + arg_360_0 and not isNil(var_360_7) and arg_357_1.var_.actorSpriteComps1148 == nil then
				arg_357_1.var_.actorSpriteComps1148 = var_360_7:GetComponentsInChildren(typeof(Image), true)
			end

			local var_360_9 = 0.125

			if var_360_8 <= arg_357_1.time_ and arg_357_1.time_ < var_360_8 + var_360_9 and not isNil(var_360_7) then
				local var_360_10 = (arg_357_1.time_ - var_360_8) / var_360_9

				if arg_357_1.var_.actorSpriteComps1148 then
					for iter_360_1, iter_360_2 in pairs(arg_357_1.var_.actorSpriteComps1148:ToTable()) do
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

			if arg_357_1.time_ >= var_360_8 + var_360_9 and arg_357_1.time_ < var_360_8 + var_360_9 + arg_360_0 and not isNil(var_360_7) and arg_357_1.var_.actorSpriteComps1148 then
				for iter_360_3, iter_360_4 in pairs(arg_357_1.var_.actorSpriteComps1148:ToTable()) do
					if iter_360_4 then
						if arg_357_1.isInRecall_ then
							iter_360_4.color = arg_357_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_360_4.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_357_1.var_.actorSpriteComps1148 = nil
			end

			local var_360_15 = 0
			local var_360_16 = 0.55

			if var_360_15 < arg_357_1.time_ and arg_357_1.time_ <= var_360_15 + arg_360_0 then
				arg_357_1.talkMaxDuration = 0
				arg_357_1.dialogCg_.alpha = 1

				arg_357_1.dialog_:SetActive(true)
				SetActive(arg_357_1.leftNameGo_, true)

				local var_360_17 = arg_357_1:FormatText(StoryNameCfg[8].name)

				arg_357_1.leftNameTxt_.text = var_360_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_357_1.leftNameTxt_.transform)

				arg_357_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_357_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_357_1:RecordName(arg_357_1.leftNameTxt_.text)
				SetActive(arg_357_1.iconTrs_.gameObject, false)
				arg_357_1.callingController_:SetSelectedState("normal")

				local var_360_18 = arg_357_1:GetWordFromCfg(416071087)
				local var_360_19 = arg_357_1:FormatText(var_360_18.content)

				arg_357_1.text_.text = var_360_19

				LuaForUtil.ClearLinePrefixSymbol(arg_357_1.text_)

				local var_360_20 = 22
				local var_360_21 = utf8.len(var_360_19)
				local var_360_22 = var_360_20 <= 0 and var_360_16 or var_360_16 * (var_360_21 / var_360_20)

				if var_360_22 > 0 and var_360_16 < var_360_22 then
					arg_357_1.talkMaxDuration = var_360_22

					if var_360_22 + var_360_15 > arg_357_1.duration_ then
						arg_357_1.duration_ = var_360_22 + var_360_15
					end
				end

				arg_357_1.text_.text = var_360_19
				arg_357_1.typewritter.percent = 0

				arg_357_1.typewritter:SetDirty()
				arg_357_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_416071", "416071087", "story_v_out_416071.awb") ~= 0 then
					local var_360_23 = manager.audio:GetVoiceLength("story_v_out_416071", "416071087", "story_v_out_416071.awb") / 1000

					if var_360_23 + var_360_15 > arg_357_1.duration_ then
						arg_357_1.duration_ = var_360_23 + var_360_15
					end

					if var_360_18.prefab_name ~= "" and arg_357_1.actors_[var_360_18.prefab_name] ~= nil then
						local var_360_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_357_1.actors_[var_360_18.prefab_name].transform, "story_v_out_416071", "416071087", "story_v_out_416071.awb")

						arg_357_1:RecordAudio("416071087", var_360_24)
						arg_357_1:RecordAudio("416071087", var_360_24)
					else
						arg_357_1:AudioAction("play", "voice", "story_v_out_416071", "416071087", "story_v_out_416071.awb")
					end

					arg_357_1:RecordHistoryTalkVoice("story_v_out_416071", "416071087", "story_v_out_416071.awb")
				end

				arg_357_1:RecordContent(arg_357_1.text_.text)
			end

			local var_360_25 = math.max(var_360_16, arg_357_1.talkMaxDuration)

			if var_360_15 <= arg_357_1.time_ and arg_357_1.time_ < var_360_15 + var_360_25 then
				arg_357_1.typewritter.percent = (arg_357_1.time_ - var_360_15) / var_360_25

				arg_357_1.typewritter:SetDirty()
			end

			if arg_357_1.time_ >= var_360_15 + var_360_25 and arg_357_1.time_ < var_360_15 + var_360_25 + arg_360_0 then
				arg_357_1.typewritter.percent = 1

				arg_357_1.typewritter:SetDirty()
				arg_357_1:ShowNextGo(true)
			end
		end

		arg_357_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1148",
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
	Play416071088 = function(arg_361_0, arg_361_1)
		arg_361_1.time_ = 0
		arg_361_1.frameCnt_ = 0
		arg_361_1.state_ = "playing"
		arg_361_1.curTalkId_ = 416071088
		arg_361_1.duration_ = 5.93

		local var_361_0 = {
			zh = 4.366,
			ja = 5.933
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
				arg_361_0:Play416071089(arg_361_1)
			end
		end

		function arg_361_1.onSingleLineUpdate_(arg_364_0)
			local var_364_0 = arg_361_1.actors_["1148"].transform
			local var_364_1 = 0

			if var_364_1 < arg_361_1.time_ and arg_361_1.time_ <= var_364_1 + arg_364_0 then
				arg_361_1.var_.moveOldPos1148 = var_364_0.localPosition
				var_364_0.localScale = Vector3.New(1, 1, 1)

				arg_361_1:CheckSpriteTmpPos("1148", 3)

				local var_364_2 = var_364_0.childCount

				for iter_364_0 = 0, var_364_2 - 1 do
					local var_364_3 = var_364_0:GetChild(iter_364_0)

					if var_364_3.name == "split_1_1" or not string.find(var_364_3.name, "split") then
						var_364_3.gameObject:SetActive(true)
					else
						var_364_3.gameObject:SetActive(false)
					end
				end
			end

			local var_364_4 = 0.001

			if var_364_1 <= arg_361_1.time_ and arg_361_1.time_ < var_364_1 + var_364_4 then
				local var_364_5 = (arg_361_1.time_ - var_364_1) / var_364_4
				local var_364_6 = Vector3.New(0, -429, -180)

				var_364_0.localPosition = Vector3.Lerp(arg_361_1.var_.moveOldPos1148, var_364_6, var_364_5)
			end

			if arg_361_1.time_ >= var_364_1 + var_364_4 and arg_361_1.time_ < var_364_1 + var_364_4 + arg_364_0 then
				var_364_0.localPosition = Vector3.New(0, -429, -180)
			end

			local var_364_7 = 0
			local var_364_8 = 0.55

			if var_364_7 < arg_361_1.time_ and arg_361_1.time_ <= var_364_7 + arg_364_0 then
				arg_361_1.talkMaxDuration = 0
				arg_361_1.dialogCg_.alpha = 1

				arg_361_1.dialog_:SetActive(true)
				SetActive(arg_361_1.leftNameGo_, true)

				local var_364_9 = arg_361_1:FormatText(StoryNameCfg[8].name)

				arg_361_1.leftNameTxt_.text = var_364_9

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_361_1.leftNameTxt_.transform)

				arg_361_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_361_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_361_1:RecordName(arg_361_1.leftNameTxt_.text)
				SetActive(arg_361_1.iconTrs_.gameObject, false)
				arg_361_1.callingController_:SetSelectedState("normal")

				local var_364_10 = arg_361_1:GetWordFromCfg(416071088)
				local var_364_11 = arg_361_1:FormatText(var_364_10.content)

				arg_361_1.text_.text = var_364_11

				LuaForUtil.ClearLinePrefixSymbol(arg_361_1.text_)

				local var_364_12 = 22
				local var_364_13 = utf8.len(var_364_11)
				local var_364_14 = var_364_12 <= 0 and var_364_8 or var_364_8 * (var_364_13 / var_364_12)

				if var_364_14 > 0 and var_364_8 < var_364_14 then
					arg_361_1.talkMaxDuration = var_364_14

					if var_364_14 + var_364_7 > arg_361_1.duration_ then
						arg_361_1.duration_ = var_364_14 + var_364_7
					end
				end

				arg_361_1.text_.text = var_364_11
				arg_361_1.typewritter.percent = 0

				arg_361_1.typewritter:SetDirty()
				arg_361_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_416071", "416071088", "story_v_out_416071.awb") ~= 0 then
					local var_364_15 = manager.audio:GetVoiceLength("story_v_out_416071", "416071088", "story_v_out_416071.awb") / 1000

					if var_364_15 + var_364_7 > arg_361_1.duration_ then
						arg_361_1.duration_ = var_364_15 + var_364_7
					end

					if var_364_10.prefab_name ~= "" and arg_361_1.actors_[var_364_10.prefab_name] ~= nil then
						local var_364_16 = LuaForUtil.PlayVoiceWithCriLipsync(arg_361_1.actors_[var_364_10.prefab_name].transform, "story_v_out_416071", "416071088", "story_v_out_416071.awb")

						arg_361_1:RecordAudio("416071088", var_364_16)
						arg_361_1:RecordAudio("416071088", var_364_16)
					else
						arg_361_1:AudioAction("play", "voice", "story_v_out_416071", "416071088", "story_v_out_416071.awb")
					end

					arg_361_1:RecordHistoryTalkVoice("story_v_out_416071", "416071088", "story_v_out_416071.awb")
				end

				arg_361_1:RecordContent(arg_361_1.text_.text)
			end

			local var_364_17 = math.max(var_364_8, arg_361_1.talkMaxDuration)

			if var_364_7 <= arg_361_1.time_ and arg_361_1.time_ < var_364_7 + var_364_17 then
				arg_361_1.typewritter.percent = (arg_361_1.time_ - var_364_7) / var_364_17

				arg_361_1.typewritter:SetDirty()
			end

			if arg_361_1.time_ >= var_364_7 + var_364_17 and arg_361_1.time_ < var_364_7 + var_364_17 + arg_364_0 then
				arg_361_1.typewritter.percent = 1

				arg_361_1.typewritter:SetDirty()
				arg_361_1:ShowNextGo(true)
			end
		end

		arg_361_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1148",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_361_1:InitPlayNodeList()
	end,
	Play416071089 = function(arg_365_0, arg_365_1)
		arg_365_1.time_ = 0
		arg_365_1.frameCnt_ = 0
		arg_365_1.state_ = "playing"
		arg_365_1.curTalkId_ = 416071089
		arg_365_1.duration_ = 7.53

		local var_365_0 = {
			zh = 3.966,
			ja = 7.533
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
				arg_365_0:Play416071090(arg_365_1)
			end
		end

		function arg_365_1.onSingleLineUpdate_(arg_368_0)
			local var_368_0 = manager.ui.mainCamera.transform
			local var_368_1 = 0

			if var_368_1 < arg_365_1.time_ and arg_365_1.time_ <= var_368_1 + arg_368_0 then
				local var_368_2 = arg_365_1.var_.effect77
				local var_368_3
				local var_368_4 = var_368_0

				if not var_368_2 then
					var_368_2 = Object.Instantiate(Asset.Load("Effect/Scene/fx_uistory_error"), var_368_4)
					var_368_2.name = "77"
					arg_365_1.var_.effect77 = var_368_2
				else
					var_368_2.transform:SetParent(var_368_4)
				end

				var_368_2.transform.localPosition = Vector3.New(0, 0, 0)
				var_368_2.transform.localRotation = Quaternion.Euler(0, 0, 0)
			end

			local var_368_5 = manager.ui.mainCamera.transform
			local var_368_6 = 1

			if var_368_6 < arg_365_1.time_ and arg_365_1.time_ <= var_368_6 + arg_368_0 then
				local var_368_7 = arg_365_1.var_.effect77

				if var_368_7 then
					Object.Destroy(var_368_7)

					arg_365_1.var_.effect77 = nil
				end
			end

			local var_368_8 = 0
			local var_368_9 = 1

			if var_368_8 < arg_365_1.time_ and arg_365_1.time_ <= var_368_8 + arg_368_0 then
				local var_368_10 = "play"
				local var_368_11 = "effect"

				arg_365_1:AudioAction(var_368_10, var_368_11, "se_story_16", "se_story_16_channel", "")
			end

			local var_368_12 = arg_365_1.actors_["1148"].transform
			local var_368_13 = 0

			if var_368_13 < arg_365_1.time_ and arg_365_1.time_ <= var_368_13 + arg_368_0 then
				arg_365_1.var_.moveOldPos1148 = var_368_12.localPosition
				var_368_12.localScale = Vector3.New(1, 1, 1)

				arg_365_1:CheckSpriteTmpPos("1148", 7)

				local var_368_14 = var_368_12.childCount

				for iter_368_0 = 0, var_368_14 - 1 do
					local var_368_15 = var_368_12:GetChild(iter_368_0)

					if var_368_15.name == "split_1_1" or not string.find(var_368_15.name, "split") then
						var_368_15.gameObject:SetActive(true)
					else
						var_368_15.gameObject:SetActive(false)
					end
				end
			end

			local var_368_16 = 0.001

			if var_368_13 <= arg_365_1.time_ and arg_365_1.time_ < var_368_13 + var_368_16 then
				local var_368_17 = (arg_365_1.time_ - var_368_13) / var_368_16
				local var_368_18 = Vector3.New(0, -2000, 0)

				var_368_12.localPosition = Vector3.Lerp(arg_365_1.var_.moveOldPos1148, var_368_18, var_368_17)
			end

			if arg_365_1.time_ >= var_368_13 + var_368_16 and arg_365_1.time_ < var_368_13 + var_368_16 + arg_368_0 then
				var_368_12.localPosition = Vector3.New(0, -2000, 0)
			end

			local var_368_19 = 0
			local var_368_20 = 0.2

			if var_368_19 < arg_365_1.time_ and arg_365_1.time_ <= var_368_19 + arg_368_0 then
				local var_368_21 = "play"
				local var_368_22 = "music"

				arg_365_1:AudioAction(var_368_21, var_368_22, "ui_battle", "ui_battle_stopbgm", "")

				local var_368_23 = ""
				local var_368_24 = manager.audio:GetAudioName("ui_battle", "ui_battle_stopbgm")

				if var_368_24 ~= "" then
					if arg_365_1.bgmTxt_.text ~= var_368_24 and arg_365_1.bgmTxt_.text ~= "" then
						if arg_365_1.bgmTxt2_.text ~= "" then
							arg_365_1.bgmTxt_.text = arg_365_1.bgmTxt2_.text
						end

						arg_365_1.bgmTxt2_.text = var_368_24

						arg_365_1.musicChangeAnimator_:Play("music_change", 0, 0)
					else
						arg_365_1.bgmTxt_.text = var_368_24
						arg_365_1.bgmTxt2_.text = var_368_24
					end

					if arg_365_1.bgmTimer then
						arg_365_1.bgmTimer:Stop()

						arg_365_1.bgmTimer = nil
					end

					if arg_365_1.settingData.show_music_name == 1 then
						arg_365_1.musicController:SetSelectedState("show")
						arg_365_1.musicAnimator_:Play("open", 0, 0)

						if arg_365_1.settingData.music_time ~= 0 then
							arg_365_1.bgmTimer = TimeTools.StartAfterSeconds(tonumber(arg_365_1.settingData.music_time), function()
								if arg_365_1 == nil or isNil(arg_365_1.bgmTxt_) then
									return
								end

								arg_365_1.musicController:SetSelectedState("hide")
								arg_365_1.musicAnimator_:Play("back", 0, 0)
							end, {})
						end
					end
				end
			end

			if arg_365_1.frameCnt_ <= 1 then
				arg_365_1.dialog_:SetActive(false)
			end

			local var_368_25 = 1
			local var_368_26 = 0.525

			if var_368_25 < arg_365_1.time_ and arg_365_1.time_ <= var_368_25 + arg_368_0 then
				arg_365_1.talkMaxDuration = 0

				arg_365_1.dialog_:SetActive(true)

				arg_365_1.dialogCg_.alpha = 0

				local var_368_27 = LeanTween.value(arg_365_1.dialog_, 0, 1, 0.3)

				var_368_27:setOnUpdate(LuaHelper.FloatAction(function(arg_370_0)
					arg_365_1.dialogCg_.alpha = arg_370_0
				end))
				var_368_27:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_365_1.dialog_)
					var_368_27:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_365_1.duration_ = arg_365_1.duration_ + 0.3

				SetActive(arg_365_1.leftNameGo_, true)

				local var_368_28 = arg_365_1:FormatText(StoryNameCfg[36].name)

				arg_365_1.leftNameTxt_.text = var_368_28

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_365_1.leftNameTxt_.transform)

				arg_365_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_365_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_365_1:RecordName(arg_365_1.leftNameTxt_.text)
				SetActive(arg_365_1.iconTrs_.gameObject, true)
				arg_365_1.iconController_:SetSelectedState("hero")

				arg_365_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_soundonly")

				arg_365_1.callingController_:SetSelectedState("normal")

				arg_365_1.keyicon_.color = Color.New(1, 1, 1)
				arg_365_1.icon_.color = Color.New(1, 1, 1)

				local var_368_29 = arg_365_1:GetWordFromCfg(416071089)
				local var_368_30 = arg_365_1:FormatText(var_368_29.content)

				arg_365_1.text_.text = var_368_30

				LuaForUtil.ClearLinePrefixSymbol(arg_365_1.text_)

				local var_368_31 = 21
				local var_368_32 = utf8.len(var_368_30)
				local var_368_33 = var_368_31 <= 0 and var_368_26 or var_368_26 * (var_368_32 / var_368_31)

				if var_368_33 > 0 and var_368_26 < var_368_33 then
					arg_365_1.talkMaxDuration = var_368_33
					var_368_25 = var_368_25 + 0.3

					if var_368_33 + var_368_25 > arg_365_1.duration_ then
						arg_365_1.duration_ = var_368_33 + var_368_25
					end
				end

				arg_365_1.text_.text = var_368_30
				arg_365_1.typewritter.percent = 0

				arg_365_1.typewritter:SetDirty()
				arg_365_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_416071", "416071089", "story_v_out_416071.awb") ~= 0 then
					local var_368_34 = manager.audio:GetVoiceLength("story_v_out_416071", "416071089", "story_v_out_416071.awb") / 1000

					if var_368_34 + var_368_25 > arg_365_1.duration_ then
						arg_365_1.duration_ = var_368_34 + var_368_25
					end

					if var_368_29.prefab_name ~= "" and arg_365_1.actors_[var_368_29.prefab_name] ~= nil then
						local var_368_35 = LuaForUtil.PlayVoiceWithCriLipsync(arg_365_1.actors_[var_368_29.prefab_name].transform, "story_v_out_416071", "416071089", "story_v_out_416071.awb")

						arg_365_1:RecordAudio("416071089", var_368_35)
						arg_365_1:RecordAudio("416071089", var_368_35)
					else
						arg_365_1:AudioAction("play", "voice", "story_v_out_416071", "416071089", "story_v_out_416071.awb")
					end

					arg_365_1:RecordHistoryTalkVoice("story_v_out_416071", "416071089", "story_v_out_416071.awb")
				end

				arg_365_1:RecordContent(arg_365_1.text_.text)
			end

			local var_368_36 = var_368_25 + 0.3
			local var_368_37 = math.max(var_368_26, arg_365_1.talkMaxDuration)

			if var_368_36 <= arg_365_1.time_ and arg_365_1.time_ < var_368_36 + var_368_37 then
				arg_365_1.typewritter.percent = (arg_365_1.time_ - var_368_36) / var_368_37

				arg_365_1.typewritter:SetDirty()
			end

			if arg_365_1.time_ >= var_368_36 + var_368_37 and arg_365_1.time_ < var_368_36 + var_368_37 + arg_368_0 then
				arg_365_1.typewritter.percent = 1

				arg_365_1.typewritter:SetDirty()
				arg_365_1:ShowNextGo(true)
			end
		end

		arg_365_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1148",
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
	Play416071090 = function(arg_372_0, arg_372_1)
		arg_372_1.time_ = 0
		arg_372_1.frameCnt_ = 0
		arg_372_1.state_ = "playing"
		arg_372_1.curTalkId_ = 416071090
		arg_372_1.duration_ = 8.2

		local var_372_0 = {
			zh = 4.466,
			ja = 8.2
		}
		local var_372_1 = manager.audio:GetLocalizationFlag()

		if var_372_0[var_372_1] ~= nil then
			arg_372_1.duration_ = var_372_0[var_372_1]
		end

		SetActive(arg_372_1.tipsGo_, false)

		function arg_372_1.onSingleLineFinish_()
			arg_372_1.onSingleLineUpdate_ = nil
			arg_372_1.onSingleLineFinish_ = nil
			arg_372_1.state_ = "waiting"
		end

		function arg_372_1.playNext_(arg_374_0)
			if arg_374_0 == 1 then
				arg_372_0:Play416071091(arg_372_1)
			end
		end

		function arg_372_1.onSingleLineUpdate_(arg_375_0)
			local var_375_0 = 0
			local var_375_1 = 1

			if var_375_0 < arg_372_1.time_ and arg_372_1.time_ <= var_375_0 + arg_375_0 then
				local var_375_2 = "play"
				local var_375_3 = "effect"

				arg_372_1:AudioAction(var_375_2, var_375_3, "se_story_16", "se_story_16_channel", "")
			end

			local var_375_4 = 0
			local var_375_5 = 0.65

			if var_375_4 < arg_372_1.time_ and arg_372_1.time_ <= var_375_4 + arg_375_0 then
				arg_372_1.talkMaxDuration = 0
				arg_372_1.dialogCg_.alpha = 1

				arg_372_1.dialog_:SetActive(true)
				SetActive(arg_372_1.leftNameGo_, true)

				local var_375_6 = arg_372_1:FormatText(StoryNameCfg[36].name)

				arg_372_1.leftNameTxt_.text = var_375_6

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_372_1.leftNameTxt_.transform)

				arg_372_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_372_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_372_1:RecordName(arg_372_1.leftNameTxt_.text)
				SetActive(arg_372_1.iconTrs_.gameObject, true)
				arg_372_1.iconController_:SetSelectedState("hero")

				arg_372_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_soundonly")

				arg_372_1.callingController_:SetSelectedState("normal")

				arg_372_1.keyicon_.color = Color.New(1, 1, 1)
				arg_372_1.icon_.color = Color.New(1, 1, 1)

				local var_375_7 = arg_372_1:GetWordFromCfg(416071090)
				local var_375_8 = arg_372_1:FormatText(var_375_7.content)

				arg_372_1.text_.text = var_375_8

				LuaForUtil.ClearLinePrefixSymbol(arg_372_1.text_)

				local var_375_9 = 26
				local var_375_10 = utf8.len(var_375_8)
				local var_375_11 = var_375_9 <= 0 and var_375_5 or var_375_5 * (var_375_10 / var_375_9)

				if var_375_11 > 0 and var_375_5 < var_375_11 then
					arg_372_1.talkMaxDuration = var_375_11

					if var_375_11 + var_375_4 > arg_372_1.duration_ then
						arg_372_1.duration_ = var_375_11 + var_375_4
					end
				end

				arg_372_1.text_.text = var_375_8
				arg_372_1.typewritter.percent = 0

				arg_372_1.typewritter:SetDirty()
				arg_372_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_416071", "416071090", "story_v_out_416071.awb") ~= 0 then
					local var_375_12 = manager.audio:GetVoiceLength("story_v_out_416071", "416071090", "story_v_out_416071.awb") / 1000

					if var_375_12 + var_375_4 > arg_372_1.duration_ then
						arg_372_1.duration_ = var_375_12 + var_375_4
					end

					if var_375_7.prefab_name ~= "" and arg_372_1.actors_[var_375_7.prefab_name] ~= nil then
						local var_375_13 = LuaForUtil.PlayVoiceWithCriLipsync(arg_372_1.actors_[var_375_7.prefab_name].transform, "story_v_out_416071", "416071090", "story_v_out_416071.awb")

						arg_372_1:RecordAudio("416071090", var_375_13)
						arg_372_1:RecordAudio("416071090", var_375_13)
					else
						arg_372_1:AudioAction("play", "voice", "story_v_out_416071", "416071090", "story_v_out_416071.awb")
					end

					arg_372_1:RecordHistoryTalkVoice("story_v_out_416071", "416071090", "story_v_out_416071.awb")
				end

				arg_372_1:RecordContent(arg_372_1.text_.text)
			end

			local var_375_14 = math.max(var_375_5, arg_372_1.talkMaxDuration)

			if var_375_4 <= arg_372_1.time_ and arg_372_1.time_ < var_375_4 + var_375_14 then
				arg_372_1.typewritter.percent = (arg_372_1.time_ - var_375_4) / var_375_14

				arg_372_1.typewritter:SetDirty()
			end

			if arg_372_1.time_ >= var_375_4 + var_375_14 and arg_372_1.time_ < var_375_4 + var_375_14 + arg_375_0 then
				arg_372_1.typewritter.percent = 1

				arg_372_1.typewritter:SetDirty()
				arg_372_1:ShowNextGo(true)
			end
		end

		arg_372_1.nodeConfigList_ = {}

		arg_372_1:InitPlayNodeList()
	end,
	Play416071091 = function(arg_376_0, arg_376_1)
		arg_376_1.time_ = 0
		arg_376_1.frameCnt_ = 0
		arg_376_1.state_ = "playing"
		arg_376_1.curTalkId_ = 416071091
		arg_376_1.duration_ = 6.27

		local var_376_0 = {
			zh = 6.266,
			ja = 4.133
		}
		local var_376_1 = manager.audio:GetLocalizationFlag()

		if var_376_0[var_376_1] ~= nil then
			arg_376_1.duration_ = var_376_0[var_376_1]
		end

		SetActive(arg_376_1.tipsGo_, false)

		function arg_376_1.onSingleLineFinish_()
			arg_376_1.onSingleLineUpdate_ = nil
			arg_376_1.onSingleLineFinish_ = nil
			arg_376_1.state_ = "waiting"
		end

		function arg_376_1.playNext_(arg_378_0)
			if arg_378_0 == 1 then
				arg_376_0:Play416071092(arg_376_1)
			end
		end

		function arg_376_1.onSingleLineUpdate_(arg_379_0)
			local var_379_0 = arg_376_1.actors_["1148"]
			local var_379_1 = 0

			if var_379_1 < arg_376_1.time_ and arg_376_1.time_ <= var_379_1 + arg_379_0 and not isNil(var_379_0) and arg_376_1.var_.actorSpriteComps1148 == nil then
				arg_376_1.var_.actorSpriteComps1148 = var_379_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_379_2 = 0.125

			if var_379_1 <= arg_376_1.time_ and arg_376_1.time_ < var_379_1 + var_379_2 and not isNil(var_379_0) then
				local var_379_3 = (arg_376_1.time_ - var_379_1) / var_379_2

				if arg_376_1.var_.actorSpriteComps1148 then
					for iter_379_0, iter_379_1 in pairs(arg_376_1.var_.actorSpriteComps1148:ToTable()) do
						if iter_379_1 then
							if arg_376_1.isInRecall_ then
								local var_379_4 = Mathf.Lerp(iter_379_1.color.r, arg_376_1.hightColor1.r, var_379_3)
								local var_379_5 = Mathf.Lerp(iter_379_1.color.g, arg_376_1.hightColor1.g, var_379_3)
								local var_379_6 = Mathf.Lerp(iter_379_1.color.b, arg_376_1.hightColor1.b, var_379_3)

								iter_379_1.color = Color.New(var_379_4, var_379_5, var_379_6)
							else
								local var_379_7 = Mathf.Lerp(iter_379_1.color.r, 1, var_379_3)

								iter_379_1.color = Color.New(var_379_7, var_379_7, var_379_7)
							end
						end
					end
				end
			end

			if arg_376_1.time_ >= var_379_1 + var_379_2 and arg_376_1.time_ < var_379_1 + var_379_2 + arg_379_0 and not isNil(var_379_0) and arg_376_1.var_.actorSpriteComps1148 then
				for iter_379_2, iter_379_3 in pairs(arg_376_1.var_.actorSpriteComps1148:ToTable()) do
					if iter_379_3 then
						if arg_376_1.isInRecall_ then
							iter_379_3.color = arg_376_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_379_3.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_376_1.var_.actorSpriteComps1148 = nil
			end

			local var_379_8 = arg_376_1.actors_["1148"].transform
			local var_379_9 = 0

			if var_379_9 < arg_376_1.time_ and arg_376_1.time_ <= var_379_9 + arg_379_0 then
				arg_376_1.var_.moveOldPos1148 = var_379_8.localPosition
				var_379_8.localScale = Vector3.New(1, 1, 1)

				arg_376_1:CheckSpriteTmpPos("1148", 3)

				local var_379_10 = var_379_8.childCount

				for iter_379_4 = 0, var_379_10 - 1 do
					local var_379_11 = var_379_8:GetChild(iter_379_4)

					if var_379_11.name == "split_1_1" or not string.find(var_379_11.name, "split") then
						var_379_11.gameObject:SetActive(true)
					else
						var_379_11.gameObject:SetActive(false)
					end
				end
			end

			local var_379_12 = 0.001

			if var_379_9 <= arg_376_1.time_ and arg_376_1.time_ < var_379_9 + var_379_12 then
				local var_379_13 = (arg_376_1.time_ - var_379_9) / var_379_12
				local var_379_14 = Vector3.New(0, -429, -180)

				var_379_8.localPosition = Vector3.Lerp(arg_376_1.var_.moveOldPos1148, var_379_14, var_379_13)
			end

			if arg_376_1.time_ >= var_379_9 + var_379_12 and arg_376_1.time_ < var_379_9 + var_379_12 + arg_379_0 then
				var_379_8.localPosition = Vector3.New(0, -429, -180)
			end

			local var_379_15 = 0
			local var_379_16 = 0.475

			if var_379_15 < arg_376_1.time_ and arg_376_1.time_ <= var_379_15 + arg_379_0 then
				arg_376_1.talkMaxDuration = 0
				arg_376_1.dialogCg_.alpha = 1

				arg_376_1.dialog_:SetActive(true)
				SetActive(arg_376_1.leftNameGo_, true)

				local var_379_17 = arg_376_1:FormatText(StoryNameCfg[8].name)

				arg_376_1.leftNameTxt_.text = var_379_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_376_1.leftNameTxt_.transform)

				arg_376_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_376_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_376_1:RecordName(arg_376_1.leftNameTxt_.text)
				SetActive(arg_376_1.iconTrs_.gameObject, false)
				arg_376_1.callingController_:SetSelectedState("normal")

				local var_379_18 = arg_376_1:GetWordFromCfg(416071091)
				local var_379_19 = arg_376_1:FormatText(var_379_18.content)

				arg_376_1.text_.text = var_379_19

				LuaForUtil.ClearLinePrefixSymbol(arg_376_1.text_)

				local var_379_20 = 19
				local var_379_21 = utf8.len(var_379_19)
				local var_379_22 = var_379_20 <= 0 and var_379_16 or var_379_16 * (var_379_21 / var_379_20)

				if var_379_22 > 0 and var_379_16 < var_379_22 then
					arg_376_1.talkMaxDuration = var_379_22

					if var_379_22 + var_379_15 > arg_376_1.duration_ then
						arg_376_1.duration_ = var_379_22 + var_379_15
					end
				end

				arg_376_1.text_.text = var_379_19
				arg_376_1.typewritter.percent = 0

				arg_376_1.typewritter:SetDirty()
				arg_376_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_416071", "416071091", "story_v_out_416071.awb") ~= 0 then
					local var_379_23 = manager.audio:GetVoiceLength("story_v_out_416071", "416071091", "story_v_out_416071.awb") / 1000

					if var_379_23 + var_379_15 > arg_376_1.duration_ then
						arg_376_1.duration_ = var_379_23 + var_379_15
					end

					if var_379_18.prefab_name ~= "" and arg_376_1.actors_[var_379_18.prefab_name] ~= nil then
						local var_379_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_376_1.actors_[var_379_18.prefab_name].transform, "story_v_out_416071", "416071091", "story_v_out_416071.awb")

						arg_376_1:RecordAudio("416071091", var_379_24)
						arg_376_1:RecordAudio("416071091", var_379_24)
					else
						arg_376_1:AudioAction("play", "voice", "story_v_out_416071", "416071091", "story_v_out_416071.awb")
					end

					arg_376_1:RecordHistoryTalkVoice("story_v_out_416071", "416071091", "story_v_out_416071.awb")
				end

				arg_376_1:RecordContent(arg_376_1.text_.text)
			end

			local var_379_25 = math.max(var_379_16, arg_376_1.talkMaxDuration)

			if var_379_15 <= arg_376_1.time_ and arg_376_1.time_ < var_379_15 + var_379_25 then
				arg_376_1.typewritter.percent = (arg_376_1.time_ - var_379_15) / var_379_25

				arg_376_1.typewritter:SetDirty()
			end

			if arg_376_1.time_ >= var_379_15 + var_379_25 and arg_376_1.time_ < var_379_15 + var_379_25 + arg_379_0 then
				arg_376_1.typewritter.percent = 1

				arg_376_1.typewritter:SetDirty()
				arg_376_1:ShowNextGo(true)
			end
		end

		arg_376_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1148",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_376_1:InitPlayNodeList()
	end,
	Play416071092 = function(arg_380_0, arg_380_1)
		arg_380_1.time_ = 0
		arg_380_1.frameCnt_ = 0
		arg_380_1.state_ = "playing"
		arg_380_1.curTalkId_ = 416071092
		arg_380_1.duration_ = 9.7

		local var_380_0 = {
			zh = 5.833,
			ja = 9.7
		}
		local var_380_1 = manager.audio:GetLocalizationFlag()

		if var_380_0[var_380_1] ~= nil then
			arg_380_1.duration_ = var_380_0[var_380_1]
		end

		SetActive(arg_380_1.tipsGo_, false)

		function arg_380_1.onSingleLineFinish_()
			arg_380_1.onSingleLineUpdate_ = nil
			arg_380_1.onSingleLineFinish_ = nil
			arg_380_1.state_ = "waiting"
		end

		function arg_380_1.playNext_(arg_382_0)
			if arg_382_0 == 1 then
				arg_380_0:Play416071093(arg_380_1)
			end
		end

		function arg_380_1.onSingleLineUpdate_(arg_383_0)
			local var_383_0 = arg_380_1.actors_["1148"]
			local var_383_1 = 0

			if var_383_1 < arg_380_1.time_ and arg_380_1.time_ <= var_383_1 + arg_383_0 and not isNil(var_383_0) and arg_380_1.var_.actorSpriteComps1148 == nil then
				arg_380_1.var_.actorSpriteComps1148 = var_383_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_383_2 = 0.125

			if var_383_1 <= arg_380_1.time_ and arg_380_1.time_ < var_383_1 + var_383_2 and not isNil(var_383_0) then
				local var_383_3 = (arg_380_1.time_ - var_383_1) / var_383_2

				if arg_380_1.var_.actorSpriteComps1148 then
					for iter_383_0, iter_383_1 in pairs(arg_380_1.var_.actorSpriteComps1148:ToTable()) do
						if iter_383_1 then
							if arg_380_1.isInRecall_ then
								local var_383_4 = Mathf.Lerp(iter_383_1.color.r, arg_380_1.hightColor2.r, var_383_3)
								local var_383_5 = Mathf.Lerp(iter_383_1.color.g, arg_380_1.hightColor2.g, var_383_3)
								local var_383_6 = Mathf.Lerp(iter_383_1.color.b, arg_380_1.hightColor2.b, var_383_3)

								iter_383_1.color = Color.New(var_383_4, var_383_5, var_383_6)
							else
								local var_383_7 = Mathf.Lerp(iter_383_1.color.r, 0.5, var_383_3)

								iter_383_1.color = Color.New(var_383_7, var_383_7, var_383_7)
							end
						end
					end
				end
			end

			if arg_380_1.time_ >= var_383_1 + var_383_2 and arg_380_1.time_ < var_383_1 + var_383_2 + arg_383_0 and not isNil(var_383_0) and arg_380_1.var_.actorSpriteComps1148 then
				for iter_383_2, iter_383_3 in pairs(arg_380_1.var_.actorSpriteComps1148:ToTable()) do
					if iter_383_3 then
						if arg_380_1.isInRecall_ then
							iter_383_3.color = arg_380_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_383_3.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_380_1.var_.actorSpriteComps1148 = nil
			end

			local var_383_8 = manager.ui.mainCamera.transform
			local var_383_9 = 0

			if var_383_9 < arg_380_1.time_ and arg_380_1.time_ <= var_383_9 + arg_383_0 then
				local var_383_10 = arg_380_1.var_.effect77
				local var_383_11
				local var_383_12 = var_383_8

				if not var_383_10 then
					var_383_10 = Object.Instantiate(Asset.Load("Effect/Scene/fx_uistory_error"), var_383_12)
					var_383_10.name = "77"
					arg_380_1.var_.effect77 = var_383_10
				else
					var_383_10.transform:SetParent(var_383_12)
				end

				var_383_10.transform.localPosition = Vector3.New(0, 0, 0)
				var_383_10.transform.localRotation = Quaternion.Euler(0, 0, 0)
			end

			local var_383_13 = manager.ui.mainCamera.transform
			local var_383_14 = 1

			if var_383_14 < arg_380_1.time_ and arg_380_1.time_ <= var_383_14 + arg_383_0 then
				local var_383_15 = arg_380_1.var_.effect77

				if var_383_15 then
					Object.Destroy(var_383_15)

					arg_380_1.var_.effect77 = nil
				end
			end

			local var_383_16 = 0
			local var_383_17 = 1

			if var_383_16 < arg_380_1.time_ and arg_380_1.time_ <= var_383_16 + arg_383_0 then
				local var_383_18 = "play"
				local var_383_19 = "effect"

				arg_380_1:AudioAction(var_383_18, var_383_19, "se_story_16", "se_story_16_channel", "")
			end

			if arg_380_1.frameCnt_ <= 1 then
				arg_380_1.dialog_:SetActive(false)
			end

			local var_383_20 = 1
			local var_383_21 = 0.6

			if var_383_20 < arg_380_1.time_ and arg_380_1.time_ <= var_383_20 + arg_383_0 then
				arg_380_1.talkMaxDuration = 0

				arg_380_1.dialog_:SetActive(true)

				arg_380_1.dialogCg_.alpha = 0

				local var_383_22 = LeanTween.value(arg_380_1.dialog_, 0, 1, 0.3)

				var_383_22:setOnUpdate(LuaHelper.FloatAction(function(arg_384_0)
					arg_380_1.dialogCg_.alpha = arg_384_0
				end))
				var_383_22:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_380_1.dialog_)
					var_383_22:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_380_1.duration_ = arg_380_1.duration_ + 0.3

				SetActive(arg_380_1.leftNameGo_, true)

				local var_383_23 = arg_380_1:FormatText(StoryNameCfg[36].name)

				arg_380_1.leftNameTxt_.text = var_383_23

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_380_1.leftNameTxt_.transform)

				arg_380_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_380_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_380_1:RecordName(arg_380_1.leftNameTxt_.text)
				SetActive(arg_380_1.iconTrs_.gameObject, true)
				arg_380_1.iconController_:SetSelectedState("hero")

				arg_380_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_soundonly")

				arg_380_1.callingController_:SetSelectedState("normal")

				arg_380_1.keyicon_.color = Color.New(1, 1, 1)
				arg_380_1.icon_.color = Color.New(1, 1, 1)

				local var_383_24 = arg_380_1:GetWordFromCfg(416071092)
				local var_383_25 = arg_380_1:FormatText(var_383_24.content)

				arg_380_1.text_.text = var_383_25

				LuaForUtil.ClearLinePrefixSymbol(arg_380_1.text_)

				local var_383_26 = 24
				local var_383_27 = utf8.len(var_383_25)
				local var_383_28 = var_383_26 <= 0 and var_383_21 or var_383_21 * (var_383_27 / var_383_26)

				if var_383_28 > 0 and var_383_21 < var_383_28 then
					arg_380_1.talkMaxDuration = var_383_28
					var_383_20 = var_383_20 + 0.3

					if var_383_28 + var_383_20 > arg_380_1.duration_ then
						arg_380_1.duration_ = var_383_28 + var_383_20
					end
				end

				arg_380_1.text_.text = var_383_25
				arg_380_1.typewritter.percent = 0

				arg_380_1.typewritter:SetDirty()
				arg_380_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_416071", "416071092", "story_v_out_416071.awb") ~= 0 then
					local var_383_29 = manager.audio:GetVoiceLength("story_v_out_416071", "416071092", "story_v_out_416071.awb") / 1000

					if var_383_29 + var_383_20 > arg_380_1.duration_ then
						arg_380_1.duration_ = var_383_29 + var_383_20
					end

					if var_383_24.prefab_name ~= "" and arg_380_1.actors_[var_383_24.prefab_name] ~= nil then
						local var_383_30 = LuaForUtil.PlayVoiceWithCriLipsync(arg_380_1.actors_[var_383_24.prefab_name].transform, "story_v_out_416071", "416071092", "story_v_out_416071.awb")

						arg_380_1:RecordAudio("416071092", var_383_30)
						arg_380_1:RecordAudio("416071092", var_383_30)
					else
						arg_380_1:AudioAction("play", "voice", "story_v_out_416071", "416071092", "story_v_out_416071.awb")
					end

					arg_380_1:RecordHistoryTalkVoice("story_v_out_416071", "416071092", "story_v_out_416071.awb")
				end

				arg_380_1:RecordContent(arg_380_1.text_.text)
			end

			local var_383_31 = var_383_20 + 0.3
			local var_383_32 = math.max(var_383_21, arg_380_1.talkMaxDuration)

			if var_383_31 <= arg_380_1.time_ and arg_380_1.time_ < var_383_31 + var_383_32 then
				arg_380_1.typewritter.percent = (arg_380_1.time_ - var_383_31) / var_383_32

				arg_380_1.typewritter:SetDirty()
			end

			if arg_380_1.time_ >= var_383_31 + var_383_32 and arg_380_1.time_ < var_383_31 + var_383_32 + arg_383_0 then
				arg_380_1.typewritter.percent = 1

				arg_380_1.typewritter:SetDirty()
				arg_380_1:ShowNextGo(true)
			end
		end

		arg_380_1.nodeConfigList_ = {}

		arg_380_1:InitPlayNodeList()
	end,
	Play416071093 = function(arg_386_0, arg_386_1)
		arg_386_1.time_ = 0
		arg_386_1.frameCnt_ = 0
		arg_386_1.state_ = "playing"
		arg_386_1.curTalkId_ = 416071093
		arg_386_1.duration_ = 9

		SetActive(arg_386_1.tipsGo_, false)

		function arg_386_1.onSingleLineFinish_()
			arg_386_1.onSingleLineUpdate_ = nil
			arg_386_1.onSingleLineFinish_ = nil
			arg_386_1.state_ = "waiting"
		end

		function arg_386_1.playNext_(arg_388_0)
			if arg_388_0 == 1 then
				arg_386_0:Play416071094(arg_386_1)
			end
		end

		function arg_386_1.onSingleLineUpdate_(arg_389_0)
			local var_389_0 = 4

			if var_389_0 < arg_386_1.time_ and arg_386_1.time_ <= var_389_0 + arg_389_0 then
				arg_386_1.allBtn_.enabled = false
			end

			local var_389_1 = 0.3

			if arg_386_1.time_ >= var_389_0 + var_389_1 and arg_386_1.time_ < var_389_0 + var_389_1 + arg_389_0 then
				arg_386_1.allBtn_.enabled = true
			end

			local var_389_2 = "STblack"

			if arg_386_1.bgs_[var_389_2] == nil then
				local var_389_3 = Object.Instantiate(arg_386_1.paintGo_)

				var_389_3:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. var_389_2)
				var_389_3.name = var_389_2
				var_389_3.transform.parent = arg_386_1.stage_.transform
				var_389_3.transform.localPosition = Vector3.New(0, 100, 0)
				arg_386_1.bgs_[var_389_2] = var_389_3
			end

			local var_389_4 = 2

			if var_389_4 < arg_386_1.time_ and arg_386_1.time_ <= var_389_4 + arg_389_0 then
				local var_389_5 = manager.ui.mainCamera.transform.localPosition
				local var_389_6 = Vector3.New(0, 0, 10) + Vector3.New(var_389_5.x, var_389_5.y, 0)
				local var_389_7 = arg_386_1.bgs_.STblack

				var_389_7.transform.localPosition = var_389_6
				var_389_7.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_389_8 = var_389_7:GetComponent("SpriteRenderer")

				if var_389_8 and var_389_8.sprite then
					local var_389_9 = (var_389_7.transform.localPosition - var_389_5).z
					local var_389_10 = manager.ui.mainCameraCom_
					local var_389_11 = 2 * var_389_9 * Mathf.Tan(var_389_10.fieldOfView * 0.5 * Mathf.Deg2Rad)
					local var_389_12 = var_389_11 * var_389_10.aspect
					local var_389_13 = var_389_8.sprite.bounds.size.x
					local var_389_14 = var_389_8.sprite.bounds.size.y
					local var_389_15 = var_389_12 / var_389_13
					local var_389_16 = var_389_11 / var_389_14
					local var_389_17 = var_389_16 < var_389_15 and var_389_15 or var_389_16

					var_389_7.transform.localScale = Vector3.New(var_389_17, var_389_17, 0)
				end

				for iter_389_0, iter_389_1 in pairs(arg_386_1.bgs_) do
					if iter_389_0 ~= "STblack" then
						iter_389_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_389_18 = 0

			if var_389_18 < arg_386_1.time_ and arg_386_1.time_ <= var_389_18 + arg_389_0 then
				arg_386_1.mask_.enabled = true
				arg_386_1.mask_.raycastTarget = true

				arg_386_1:SetGaussion(false)
			end

			local var_389_19 = 2

			if var_389_18 <= arg_386_1.time_ and arg_386_1.time_ < var_389_18 + var_389_19 then
				local var_389_20 = (arg_386_1.time_ - var_389_18) / var_389_19
				local var_389_21 = Color.New(0, 0, 0)

				var_389_21.a = Mathf.Lerp(0, 1, var_389_20)
				arg_386_1.mask_.color = var_389_21
			end

			if arg_386_1.time_ >= var_389_18 + var_389_19 and arg_386_1.time_ < var_389_18 + var_389_19 + arg_389_0 then
				local var_389_22 = Color.New(0, 0, 0)

				var_389_22.a = 1
				arg_386_1.mask_.color = var_389_22
			end

			local var_389_23 = 2

			if var_389_23 < arg_386_1.time_ and arg_386_1.time_ <= var_389_23 + arg_389_0 then
				arg_386_1.mask_.enabled = true
				arg_386_1.mask_.raycastTarget = true

				arg_386_1:SetGaussion(false)
			end

			local var_389_24 = 2

			if var_389_23 <= arg_386_1.time_ and arg_386_1.time_ < var_389_23 + var_389_24 then
				local var_389_25 = (arg_386_1.time_ - var_389_23) / var_389_24
				local var_389_26 = Color.New(0, 0, 0)

				var_389_26.a = Mathf.Lerp(1, 0, var_389_25)
				arg_386_1.mask_.color = var_389_26
			end

			if arg_386_1.time_ >= var_389_23 + var_389_24 and arg_386_1.time_ < var_389_23 + var_389_24 + arg_389_0 then
				local var_389_27 = Color.New(0, 0, 0)
				local var_389_28 = 0

				arg_386_1.mask_.enabled = false
				var_389_27.a = var_389_28
				arg_386_1.mask_.color = var_389_27
			end

			local var_389_29 = arg_386_1.actors_["1148"].transform
			local var_389_30 = 1.966

			if var_389_30 < arg_386_1.time_ and arg_386_1.time_ <= var_389_30 + arg_389_0 then
				arg_386_1.var_.moveOldPos1148 = var_389_29.localPosition
				var_389_29.localScale = Vector3.New(1, 1, 1)

				arg_386_1:CheckSpriteTmpPos("1148", 7)

				local var_389_31 = var_389_29.childCount

				for iter_389_2 = 0, var_389_31 - 1 do
					local var_389_32 = var_389_29:GetChild(iter_389_2)

					if var_389_32.name == "" or not string.find(var_389_32.name, "split") then
						var_389_32.gameObject:SetActive(true)
					else
						var_389_32.gameObject:SetActive(false)
					end
				end
			end

			local var_389_33 = 0.001

			if var_389_30 <= arg_386_1.time_ and arg_386_1.time_ < var_389_30 + var_389_33 then
				local var_389_34 = (arg_386_1.time_ - var_389_30) / var_389_33
				local var_389_35 = Vector3.New(0, -2000, 0)

				var_389_29.localPosition = Vector3.Lerp(arg_386_1.var_.moveOldPos1148, var_389_35, var_389_34)
			end

			if arg_386_1.time_ >= var_389_30 + var_389_33 and arg_386_1.time_ < var_389_30 + var_389_33 + arg_389_0 then
				var_389_29.localPosition = Vector3.New(0, -2000, 0)
			end

			local var_389_36 = 1.7
			local var_389_37 = 1

			if var_389_36 < arg_386_1.time_ and arg_386_1.time_ <= var_389_36 + arg_389_0 then
				local var_389_38 = "play"
				local var_389_39 = "effect"

				arg_386_1:AudioAction(var_389_38, var_389_39, "se_story_16", "se_story_16_thunder02", "")
			end

			if arg_386_1.frameCnt_ <= 1 then
				arg_386_1.dialog_:SetActive(false)
			end

			local var_389_40 = 4
			local var_389_41 = 1.3

			if var_389_40 < arg_386_1.time_ and arg_386_1.time_ <= var_389_40 + arg_389_0 then
				arg_386_1.talkMaxDuration = 0

				arg_386_1.dialog_:SetActive(true)

				arg_386_1.dialogCg_.alpha = 0

				local var_389_42 = LeanTween.value(arg_386_1.dialog_, 0, 1, 0.3)

				var_389_42:setOnUpdate(LuaHelper.FloatAction(function(arg_390_0)
					arg_386_1.dialogCg_.alpha = arg_390_0
				end))
				var_389_42:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_386_1.dialog_)
					var_389_42:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_386_1.duration_ = arg_386_1.duration_ + 0.3

				SetActive(arg_386_1.leftNameGo_, false)

				arg_386_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_386_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_386_1:RecordName(arg_386_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_386_1.iconTrs_.gameObject, false)
				arg_386_1.callingController_:SetSelectedState("normal")

				local var_389_43 = arg_386_1:GetWordFromCfg(416071093)
				local var_389_44 = arg_386_1:FormatText(var_389_43.content)

				arg_386_1.text_.text = var_389_44

				LuaForUtil.ClearLinePrefixSymbol(arg_386_1.text_)

				local var_389_45 = 52
				local var_389_46 = utf8.len(var_389_44)
				local var_389_47 = var_389_45 <= 0 and var_389_41 or var_389_41 * (var_389_46 / var_389_45)

				if var_389_47 > 0 and var_389_41 < var_389_47 then
					arg_386_1.talkMaxDuration = var_389_47
					var_389_40 = var_389_40 + 0.3

					if var_389_47 + var_389_40 > arg_386_1.duration_ then
						arg_386_1.duration_ = var_389_47 + var_389_40
					end
				end

				arg_386_1.text_.text = var_389_44
				arg_386_1.typewritter.percent = 0

				arg_386_1.typewritter:SetDirty()
				arg_386_1:ShowNextGo(false)
				arg_386_1:RecordContent(arg_386_1.text_.text)
			end

			local var_389_48 = var_389_40 + 0.3
			local var_389_49 = math.max(var_389_41, arg_386_1.talkMaxDuration)

			if var_389_48 <= arg_386_1.time_ and arg_386_1.time_ < var_389_48 + var_389_49 then
				arg_386_1.typewritter.percent = (arg_386_1.time_ - var_389_48) / var_389_49

				arg_386_1.typewritter:SetDirty()
			end

			if arg_386_1.time_ >= var_389_48 + var_389_49 and arg_386_1.time_ < var_389_48 + var_389_49 + arg_389_0 then
				arg_386_1.typewritter.percent = 1

				arg_386_1.typewritter:SetDirty()
				arg_386_1:ShowNextGo(true)
			end
		end

		arg_386_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1148",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 1.966,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_386_1:InitPlayNodeList()
	end,
	Play416071094 = function(arg_392_0, arg_392_1)
		arg_392_1.time_ = 0
		arg_392_1.frameCnt_ = 0
		arg_392_1.state_ = "playing"
		arg_392_1.curTalkId_ = 416071094
		arg_392_1.duration_ = 2.4

		local var_392_0 = {
			zh = 2.333,
			ja = 2.4
		}
		local var_392_1 = manager.audio:GetLocalizationFlag()

		if var_392_0[var_392_1] ~= nil then
			arg_392_1.duration_ = var_392_0[var_392_1]
		end

		SetActive(arg_392_1.tipsGo_, false)

		function arg_392_1.onSingleLineFinish_()
			arg_392_1.onSingleLineUpdate_ = nil
			arg_392_1.onSingleLineFinish_ = nil
			arg_392_1.state_ = "waiting"
		end

		function arg_392_1.playNext_(arg_394_0)
			if arg_394_0 == 1 then
				arg_392_0:Play416071095(arg_392_1)
			end
		end

		function arg_392_1.onSingleLineUpdate_(arg_395_0)
			local var_395_0 = arg_392_1.actors_["1148"].transform
			local var_395_1 = 0

			if var_395_1 < arg_392_1.time_ and arg_392_1.time_ <= var_395_1 + arg_395_0 then
				arg_392_1.var_.moveOldPos1148 = var_395_0.localPosition
				var_395_0.localScale = Vector3.New(1, 1, 1)

				arg_392_1:CheckSpriteTmpPos("1148", 3)

				local var_395_2 = var_395_0.childCount

				for iter_395_0 = 0, var_395_2 - 1 do
					local var_395_3 = var_395_0:GetChild(iter_395_0)

					if var_395_3.name == "split_6" or not string.find(var_395_3.name, "split") then
						var_395_3.gameObject:SetActive(true)
					else
						var_395_3.gameObject:SetActive(false)
					end
				end
			end

			local var_395_4 = 0.001

			if var_395_1 <= arg_392_1.time_ and arg_392_1.time_ < var_395_1 + var_395_4 then
				local var_395_5 = (arg_392_1.time_ - var_395_1) / var_395_4
				local var_395_6 = Vector3.New(0, -429, -180)

				var_395_0.localPosition = Vector3.Lerp(arg_392_1.var_.moveOldPos1148, var_395_6, var_395_5)
			end

			if arg_392_1.time_ >= var_395_1 + var_395_4 and arg_392_1.time_ < var_395_1 + var_395_4 + arg_395_0 then
				var_395_0.localPosition = Vector3.New(0, -429, -180)
			end

			local var_395_7 = arg_392_1.actors_["1148"]
			local var_395_8 = 0

			if var_395_8 < arg_392_1.time_ and arg_392_1.time_ <= var_395_8 + arg_395_0 and not isNil(var_395_7) and arg_392_1.var_.actorSpriteComps1148 == nil then
				arg_392_1.var_.actorSpriteComps1148 = var_395_7:GetComponentsInChildren(typeof(Image), true)
			end

			local var_395_9 = 0.125

			if var_395_8 <= arg_392_1.time_ and arg_392_1.time_ < var_395_8 + var_395_9 and not isNil(var_395_7) then
				local var_395_10 = (arg_392_1.time_ - var_395_8) / var_395_9

				if arg_392_1.var_.actorSpriteComps1148 then
					for iter_395_1, iter_395_2 in pairs(arg_392_1.var_.actorSpriteComps1148:ToTable()) do
						if iter_395_2 then
							if arg_392_1.isInRecall_ then
								local var_395_11 = Mathf.Lerp(iter_395_2.color.r, arg_392_1.hightColor1.r, var_395_10)
								local var_395_12 = Mathf.Lerp(iter_395_2.color.g, arg_392_1.hightColor1.g, var_395_10)
								local var_395_13 = Mathf.Lerp(iter_395_2.color.b, arg_392_1.hightColor1.b, var_395_10)

								iter_395_2.color = Color.New(var_395_11, var_395_12, var_395_13)
							else
								local var_395_14 = Mathf.Lerp(iter_395_2.color.r, 1, var_395_10)

								iter_395_2.color = Color.New(var_395_14, var_395_14, var_395_14)
							end
						end
					end
				end
			end

			if arg_392_1.time_ >= var_395_8 + var_395_9 and arg_392_1.time_ < var_395_8 + var_395_9 + arg_395_0 and not isNil(var_395_7) and arg_392_1.var_.actorSpriteComps1148 then
				for iter_395_3, iter_395_4 in pairs(arg_392_1.var_.actorSpriteComps1148:ToTable()) do
					if iter_395_4 then
						if arg_392_1.isInRecall_ then
							iter_395_4.color = arg_392_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_395_4.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_392_1.var_.actorSpriteComps1148 = nil
			end

			local var_395_15 = 0
			local var_395_16 = 0.15

			if var_395_15 < arg_392_1.time_ and arg_392_1.time_ <= var_395_15 + arg_395_0 then
				arg_392_1.talkMaxDuration = 0
				arg_392_1.dialogCg_.alpha = 1

				arg_392_1.dialog_:SetActive(true)
				SetActive(arg_392_1.leftNameGo_, true)

				local var_395_17 = arg_392_1:FormatText(StoryNameCfg[8].name)

				arg_392_1.leftNameTxt_.text = var_395_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_392_1.leftNameTxt_.transform)

				arg_392_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_392_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_392_1:RecordName(arg_392_1.leftNameTxt_.text)
				SetActive(arg_392_1.iconTrs_.gameObject, false)
				arg_392_1.callingController_:SetSelectedState("normal")

				local var_395_18 = arg_392_1:GetWordFromCfg(416071094)
				local var_395_19 = arg_392_1:FormatText(var_395_18.content)

				arg_392_1.text_.text = var_395_19

				LuaForUtil.ClearLinePrefixSymbol(arg_392_1.text_)

				local var_395_20 = 6
				local var_395_21 = utf8.len(var_395_19)
				local var_395_22 = var_395_20 <= 0 and var_395_16 or var_395_16 * (var_395_21 / var_395_20)

				if var_395_22 > 0 and var_395_16 < var_395_22 then
					arg_392_1.talkMaxDuration = var_395_22

					if var_395_22 + var_395_15 > arg_392_1.duration_ then
						arg_392_1.duration_ = var_395_22 + var_395_15
					end
				end

				arg_392_1.text_.text = var_395_19
				arg_392_1.typewritter.percent = 0

				arg_392_1.typewritter:SetDirty()
				arg_392_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_416071", "416071094", "story_v_out_416071.awb") ~= 0 then
					local var_395_23 = manager.audio:GetVoiceLength("story_v_out_416071", "416071094", "story_v_out_416071.awb") / 1000

					if var_395_23 + var_395_15 > arg_392_1.duration_ then
						arg_392_1.duration_ = var_395_23 + var_395_15
					end

					if var_395_18.prefab_name ~= "" and arg_392_1.actors_[var_395_18.prefab_name] ~= nil then
						local var_395_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_392_1.actors_[var_395_18.prefab_name].transform, "story_v_out_416071", "416071094", "story_v_out_416071.awb")

						arg_392_1:RecordAudio("416071094", var_395_24)
						arg_392_1:RecordAudio("416071094", var_395_24)
					else
						arg_392_1:AudioAction("play", "voice", "story_v_out_416071", "416071094", "story_v_out_416071.awb")
					end

					arg_392_1:RecordHistoryTalkVoice("story_v_out_416071", "416071094", "story_v_out_416071.awb")
				end

				arg_392_1:RecordContent(arg_392_1.text_.text)
			end

			local var_395_25 = math.max(var_395_16, arg_392_1.talkMaxDuration)

			if var_395_15 <= arg_392_1.time_ and arg_392_1.time_ < var_395_15 + var_395_25 then
				arg_392_1.typewritter.percent = (arg_392_1.time_ - var_395_15) / var_395_25

				arg_392_1.typewritter:SetDirty()
			end

			if arg_392_1.time_ >= var_395_15 + var_395_25 and arg_392_1.time_ < var_395_15 + var_395_25 + arg_395_0 then
				arg_392_1.typewritter.percent = 1

				arg_392_1.typewritter:SetDirty()
				arg_392_1:ShowNextGo(true)
			end
		end

		arg_392_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1148",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_392_1:InitPlayNodeList()
	end,
	Play416071095 = function(arg_396_0, arg_396_1)
		arg_396_1.time_ = 0
		arg_396_1.frameCnt_ = 0
		arg_396_1.state_ = "playing"
		arg_396_1.curTalkId_ = 416071095
		arg_396_1.duration_ = 5.7

		local var_396_0 = {
			zh = 3.566,
			ja = 5.7
		}
		local var_396_1 = manager.audio:GetLocalizationFlag()

		if var_396_0[var_396_1] ~= nil then
			arg_396_1.duration_ = var_396_0[var_396_1]
		end

		SetActive(arg_396_1.tipsGo_, false)

		function arg_396_1.onSingleLineFinish_()
			arg_396_1.onSingleLineUpdate_ = nil
			arg_396_1.onSingleLineFinish_ = nil
			arg_396_1.state_ = "waiting"
		end

		function arg_396_1.playNext_(arg_398_0)
			if arg_398_0 == 1 then
				arg_396_0:Play416071096(arg_396_1)
			end
		end

		function arg_396_1.onSingleLineUpdate_(arg_399_0)
			local var_399_0 = arg_396_1.actors_["1148"].transform
			local var_399_1 = 0

			if var_399_1 < arg_396_1.time_ and arg_396_1.time_ <= var_399_1 + arg_399_0 then
				arg_396_1.var_.moveOldPos1148 = var_399_0.localPosition
				var_399_0.localScale = Vector3.New(1, 1, 1)

				arg_396_1:CheckSpriteTmpPos("1148", 2)

				local var_399_2 = var_399_0.childCount

				for iter_399_0 = 0, var_399_2 - 1 do
					local var_399_3 = var_399_0:GetChild(iter_399_0)

					if var_399_3.name == "" or not string.find(var_399_3.name, "split") then
						var_399_3.gameObject:SetActive(true)
					else
						var_399_3.gameObject:SetActive(false)
					end
				end
			end

			local var_399_4 = 0.001

			if var_399_1 <= arg_396_1.time_ and arg_396_1.time_ < var_399_1 + var_399_4 then
				local var_399_5 = (arg_396_1.time_ - var_399_1) / var_399_4
				local var_399_6 = Vector3.New(-390, -429, -180)

				var_399_0.localPosition = Vector3.Lerp(arg_396_1.var_.moveOldPos1148, var_399_6, var_399_5)
			end

			if arg_396_1.time_ >= var_399_1 + var_399_4 and arg_396_1.time_ < var_399_1 + var_399_4 + arg_399_0 then
				var_399_0.localPosition = Vector3.New(-390, -429, -180)
			end

			local var_399_7 = arg_396_1.actors_["1148"]
			local var_399_8 = 0

			if var_399_8 < arg_396_1.time_ and arg_396_1.time_ <= var_399_8 + arg_399_0 and not isNil(var_399_7) and arg_396_1.var_.actorSpriteComps1148 == nil then
				arg_396_1.var_.actorSpriteComps1148 = var_399_7:GetComponentsInChildren(typeof(Image), true)
			end

			local var_399_9 = 0.125

			if var_399_8 <= arg_396_1.time_ and arg_396_1.time_ < var_399_8 + var_399_9 and not isNil(var_399_7) then
				local var_399_10 = (arg_396_1.time_ - var_399_8) / var_399_9

				if arg_396_1.var_.actorSpriteComps1148 then
					for iter_399_1, iter_399_2 in pairs(arg_396_1.var_.actorSpriteComps1148:ToTable()) do
						if iter_399_2 then
							if arg_396_1.isInRecall_ then
								local var_399_11 = Mathf.Lerp(iter_399_2.color.r, arg_396_1.hightColor2.r, var_399_10)
								local var_399_12 = Mathf.Lerp(iter_399_2.color.g, arg_396_1.hightColor2.g, var_399_10)
								local var_399_13 = Mathf.Lerp(iter_399_2.color.b, arg_396_1.hightColor2.b, var_399_10)

								iter_399_2.color = Color.New(var_399_11, var_399_12, var_399_13)
							else
								local var_399_14 = Mathf.Lerp(iter_399_2.color.r, 0.5, var_399_10)

								iter_399_2.color = Color.New(var_399_14, var_399_14, var_399_14)
							end
						end
					end
				end
			end

			if arg_396_1.time_ >= var_399_8 + var_399_9 and arg_396_1.time_ < var_399_8 + var_399_9 + arg_399_0 and not isNil(var_399_7) and arg_396_1.var_.actorSpriteComps1148 then
				for iter_399_3, iter_399_4 in pairs(arg_396_1.var_.actorSpriteComps1148:ToTable()) do
					if iter_399_4 then
						if arg_396_1.isInRecall_ then
							iter_399_4.color = arg_396_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_399_4.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_396_1.var_.actorSpriteComps1148 = nil
			end

			local var_399_15 = arg_396_1.actors_["10108"].transform
			local var_399_16 = 0

			if var_399_16 < arg_396_1.time_ and arg_396_1.time_ <= var_399_16 + arg_399_0 then
				arg_396_1.var_.moveOldPos10108 = var_399_15.localPosition
				var_399_15.localScale = Vector3.New(1, 1, 1)

				arg_396_1:CheckSpriteTmpPos("10108", 4)

				local var_399_17 = var_399_15.childCount

				for iter_399_5 = 0, var_399_17 - 1 do
					local var_399_18 = var_399_15:GetChild(iter_399_5)

					if var_399_18.name == "" or not string.find(var_399_18.name, "split") then
						var_399_18.gameObject:SetActive(true)
					else
						var_399_18.gameObject:SetActive(false)
					end
				end
			end

			local var_399_19 = 0.001

			if var_399_16 <= arg_396_1.time_ and arg_396_1.time_ < var_399_16 + var_399_19 then
				local var_399_20 = (arg_396_1.time_ - var_399_16) / var_399_19
				local var_399_21 = Vector3.New(390, -399.6, -130)

				var_399_15.localPosition = Vector3.Lerp(arg_396_1.var_.moveOldPos10108, var_399_21, var_399_20)
			end

			if arg_396_1.time_ >= var_399_16 + var_399_19 and arg_396_1.time_ < var_399_16 + var_399_19 + arg_399_0 then
				var_399_15.localPosition = Vector3.New(390, -399.6, -130)
			end

			local var_399_22 = arg_396_1.actors_["10108"]
			local var_399_23 = 0

			if var_399_23 < arg_396_1.time_ and arg_396_1.time_ <= var_399_23 + arg_399_0 and not isNil(var_399_22) and arg_396_1.var_.actorSpriteComps10108 == nil then
				arg_396_1.var_.actorSpriteComps10108 = var_399_22:GetComponentsInChildren(typeof(Image), true)
			end

			local var_399_24 = 0.125

			if var_399_23 <= arg_396_1.time_ and arg_396_1.time_ < var_399_23 + var_399_24 and not isNil(var_399_22) then
				local var_399_25 = (arg_396_1.time_ - var_399_23) / var_399_24

				if arg_396_1.var_.actorSpriteComps10108 then
					for iter_399_6, iter_399_7 in pairs(arg_396_1.var_.actorSpriteComps10108:ToTable()) do
						if iter_399_7 then
							if arg_396_1.isInRecall_ then
								local var_399_26 = Mathf.Lerp(iter_399_7.color.r, arg_396_1.hightColor1.r, var_399_25)
								local var_399_27 = Mathf.Lerp(iter_399_7.color.g, arg_396_1.hightColor1.g, var_399_25)
								local var_399_28 = Mathf.Lerp(iter_399_7.color.b, arg_396_1.hightColor1.b, var_399_25)

								iter_399_7.color = Color.New(var_399_26, var_399_27, var_399_28)
							else
								local var_399_29 = Mathf.Lerp(iter_399_7.color.r, 1, var_399_25)

								iter_399_7.color = Color.New(var_399_29, var_399_29, var_399_29)
							end
						end
					end
				end
			end

			if arg_396_1.time_ >= var_399_23 + var_399_24 and arg_396_1.time_ < var_399_23 + var_399_24 + arg_399_0 and not isNil(var_399_22) and arg_396_1.var_.actorSpriteComps10108 then
				for iter_399_8, iter_399_9 in pairs(arg_396_1.var_.actorSpriteComps10108:ToTable()) do
					if iter_399_9 then
						if arg_396_1.isInRecall_ then
							iter_399_9.color = arg_396_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_399_9.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_396_1.var_.actorSpriteComps10108 = nil
			end

			local var_399_30 = 0
			local var_399_31 = 0.35

			if var_399_30 < arg_396_1.time_ and arg_396_1.time_ <= var_399_30 + arg_399_0 then
				arg_396_1.talkMaxDuration = 0
				arg_396_1.dialogCg_.alpha = 1

				arg_396_1.dialog_:SetActive(true)
				SetActive(arg_396_1.leftNameGo_, true)

				local var_399_32 = arg_396_1:FormatText(StoryNameCfg[1083].name)

				arg_396_1.leftNameTxt_.text = var_399_32

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_396_1.leftNameTxt_.transform)

				arg_396_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_396_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_396_1:RecordName(arg_396_1.leftNameTxt_.text)
				SetActive(arg_396_1.iconTrs_.gameObject, false)
				arg_396_1.callingController_:SetSelectedState("normal")

				local var_399_33 = arg_396_1:GetWordFromCfg(416071095)
				local var_399_34 = arg_396_1:FormatText(var_399_33.content)

				arg_396_1.text_.text = var_399_34

				LuaForUtil.ClearLinePrefixSymbol(arg_396_1.text_)

				local var_399_35 = 14
				local var_399_36 = utf8.len(var_399_34)
				local var_399_37 = var_399_35 <= 0 and var_399_31 or var_399_31 * (var_399_36 / var_399_35)

				if var_399_37 > 0 and var_399_31 < var_399_37 then
					arg_396_1.talkMaxDuration = var_399_37

					if var_399_37 + var_399_30 > arg_396_1.duration_ then
						arg_396_1.duration_ = var_399_37 + var_399_30
					end
				end

				arg_396_1.text_.text = var_399_34
				arg_396_1.typewritter.percent = 0

				arg_396_1.typewritter:SetDirty()
				arg_396_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_416071", "416071095", "story_v_out_416071.awb") ~= 0 then
					local var_399_38 = manager.audio:GetVoiceLength("story_v_out_416071", "416071095", "story_v_out_416071.awb") / 1000

					if var_399_38 + var_399_30 > arg_396_1.duration_ then
						arg_396_1.duration_ = var_399_38 + var_399_30
					end

					if var_399_33.prefab_name ~= "" and arg_396_1.actors_[var_399_33.prefab_name] ~= nil then
						local var_399_39 = LuaForUtil.PlayVoiceWithCriLipsync(arg_396_1.actors_[var_399_33.prefab_name].transform, "story_v_out_416071", "416071095", "story_v_out_416071.awb")

						arg_396_1:RecordAudio("416071095", var_399_39)
						arg_396_1:RecordAudio("416071095", var_399_39)
					else
						arg_396_1:AudioAction("play", "voice", "story_v_out_416071", "416071095", "story_v_out_416071.awb")
					end

					arg_396_1:RecordHistoryTalkVoice("story_v_out_416071", "416071095", "story_v_out_416071.awb")
				end

				arg_396_1:RecordContent(arg_396_1.text_.text)
			end

			local var_399_40 = math.max(var_399_31, arg_396_1.talkMaxDuration)

			if var_399_30 <= arg_396_1.time_ and arg_396_1.time_ < var_399_30 + var_399_40 then
				arg_396_1.typewritter.percent = (arg_396_1.time_ - var_399_30) / var_399_40

				arg_396_1.typewritter:SetDirty()
			end

			if arg_396_1.time_ >= var_399_30 + var_399_40 and arg_396_1.time_ < var_399_30 + var_399_40 + arg_399_0 then
				arg_396_1.typewritter.percent = 1

				arg_396_1.typewritter:SetDirty()
				arg_396_1:ShowNextGo(true)
			end
		end

		arg_396_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1148",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			},
			{
				assetPath = "",
				actorName = "10108",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_396_1:InitPlayNodeList()
	end,
	Play416071096 = function(arg_400_0, arg_400_1)
		arg_400_1.time_ = 0
		arg_400_1.frameCnt_ = 0
		arg_400_1.state_ = "playing"
		arg_400_1.curTalkId_ = 416071096
		arg_400_1.duration_ = 10.27

		local var_400_0 = {
			zh = 10.266,
			ja = 9.8
		}
		local var_400_1 = manager.audio:GetLocalizationFlag()

		if var_400_0[var_400_1] ~= nil then
			arg_400_1.duration_ = var_400_0[var_400_1]
		end

		SetActive(arg_400_1.tipsGo_, false)

		function arg_400_1.onSingleLineFinish_()
			arg_400_1.onSingleLineUpdate_ = nil
			arg_400_1.onSingleLineFinish_ = nil
			arg_400_1.state_ = "waiting"
		end

		function arg_400_1.playNext_(arg_402_0)
			if arg_402_0 == 1 then
				arg_400_0:Play416071097(arg_400_1)
			end
		end

		function arg_400_1.onSingleLineUpdate_(arg_403_0)
			local var_403_0 = 4

			if var_403_0 < arg_400_1.time_ and arg_400_1.time_ <= var_403_0 + arg_403_0 then
				arg_400_1.allBtn_.enabled = false
			end

			local var_403_1 = 0.3

			if arg_400_1.time_ >= var_403_0 + var_403_1 and arg_400_1.time_ < var_403_0 + var_403_1 + arg_403_0 then
				arg_400_1.allBtn_.enabled = true
			end

			local var_403_2 = 2

			if var_403_2 < arg_400_1.time_ and arg_400_1.time_ <= var_403_2 + arg_403_0 then
				local var_403_3 = manager.ui.mainCamera.transform.localPosition
				local var_403_4 = Vector3.New(0, 0, 10) + Vector3.New(var_403_3.x, var_403_3.y, 0)
				local var_403_5 = arg_400_1.bgs_.ST0106

				var_403_5.transform.localPosition = var_403_4
				var_403_5.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_403_6 = var_403_5:GetComponent("SpriteRenderer")

				if var_403_6 and var_403_6.sprite then
					local var_403_7 = (var_403_5.transform.localPosition - var_403_3).z
					local var_403_8 = manager.ui.mainCameraCom_
					local var_403_9 = 2 * var_403_7 * Mathf.Tan(var_403_8.fieldOfView * 0.5 * Mathf.Deg2Rad)
					local var_403_10 = var_403_9 * var_403_8.aspect
					local var_403_11 = var_403_6.sprite.bounds.size.x
					local var_403_12 = var_403_6.sprite.bounds.size.y
					local var_403_13 = var_403_10 / var_403_11
					local var_403_14 = var_403_9 / var_403_12
					local var_403_15 = var_403_14 < var_403_13 and var_403_13 or var_403_14

					var_403_5.transform.localScale = Vector3.New(var_403_15, var_403_15, 0)
				end

				for iter_403_0, iter_403_1 in pairs(arg_400_1.bgs_) do
					if iter_403_0 ~= "ST0106" then
						iter_403_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_403_16 = 0

			if var_403_16 < arg_400_1.time_ and arg_400_1.time_ <= var_403_16 + arg_403_0 then
				arg_400_1.mask_.enabled = true
				arg_400_1.mask_.raycastTarget = true

				arg_400_1:SetGaussion(false)
			end

			local var_403_17 = 2

			if var_403_16 <= arg_400_1.time_ and arg_400_1.time_ < var_403_16 + var_403_17 then
				local var_403_18 = (arg_400_1.time_ - var_403_16) / var_403_17
				local var_403_19 = Color.New(0, 0, 0)

				var_403_19.a = Mathf.Lerp(0, 1, var_403_18)
				arg_400_1.mask_.color = var_403_19
			end

			if arg_400_1.time_ >= var_403_16 + var_403_17 and arg_400_1.time_ < var_403_16 + var_403_17 + arg_403_0 then
				local var_403_20 = Color.New(0, 0, 0)

				var_403_20.a = 1
				arg_400_1.mask_.color = var_403_20
			end

			local var_403_21 = 2

			if var_403_21 < arg_400_1.time_ and arg_400_1.time_ <= var_403_21 + arg_403_0 then
				arg_400_1.mask_.enabled = true
				arg_400_1.mask_.raycastTarget = true

				arg_400_1:SetGaussion(false)
			end

			local var_403_22 = 2

			if var_403_21 <= arg_400_1.time_ and arg_400_1.time_ < var_403_21 + var_403_22 then
				local var_403_23 = (arg_400_1.time_ - var_403_21) / var_403_22
				local var_403_24 = Color.New(0, 0, 0)

				var_403_24.a = Mathf.Lerp(1, 0, var_403_23)
				arg_400_1.mask_.color = var_403_24
			end

			if arg_400_1.time_ >= var_403_21 + var_403_22 and arg_400_1.time_ < var_403_21 + var_403_22 + arg_403_0 then
				local var_403_25 = Color.New(0, 0, 0)
				local var_403_26 = 0

				arg_400_1.mask_.enabled = false
				var_403_25.a = var_403_26
				arg_400_1.mask_.color = var_403_25
			end

			local var_403_27 = arg_400_1.actors_["10108"].transform
			local var_403_28 = 1.966

			if var_403_28 < arg_400_1.time_ and arg_400_1.time_ <= var_403_28 + arg_403_0 then
				arg_400_1.var_.moveOldPos10108 = var_403_27.localPosition
				var_403_27.localScale = Vector3.New(1, 1, 1)

				arg_400_1:CheckSpriteTmpPos("10108", 7)

				local var_403_29 = var_403_27.childCount

				for iter_403_2 = 0, var_403_29 - 1 do
					local var_403_30 = var_403_27:GetChild(iter_403_2)

					if var_403_30.name == "" or not string.find(var_403_30.name, "split") then
						var_403_30.gameObject:SetActive(true)
					else
						var_403_30.gameObject:SetActive(false)
					end
				end
			end

			local var_403_31 = 0.001

			if var_403_28 <= arg_400_1.time_ and arg_400_1.time_ < var_403_28 + var_403_31 then
				local var_403_32 = (arg_400_1.time_ - var_403_28) / var_403_31
				local var_403_33 = Vector3.New(0, -2000, 0)

				var_403_27.localPosition = Vector3.Lerp(arg_400_1.var_.moveOldPos10108, var_403_33, var_403_32)
			end

			if arg_400_1.time_ >= var_403_28 + var_403_31 and arg_400_1.time_ < var_403_28 + var_403_31 + arg_403_0 then
				var_403_27.localPosition = Vector3.New(0, -2000, 0)
			end

			local var_403_34 = arg_400_1.actors_["1148"].transform
			local var_403_35 = 1.966

			if var_403_35 < arg_400_1.time_ and arg_400_1.time_ <= var_403_35 + arg_403_0 then
				arg_400_1.var_.moveOldPos1148 = var_403_34.localPosition
				var_403_34.localScale = Vector3.New(1, 1, 1)

				arg_400_1:CheckSpriteTmpPos("1148", 7)

				local var_403_36 = var_403_34.childCount

				for iter_403_3 = 0, var_403_36 - 1 do
					local var_403_37 = var_403_34:GetChild(iter_403_3)

					if var_403_37.name == "" or not string.find(var_403_37.name, "split") then
						var_403_37.gameObject:SetActive(true)
					else
						var_403_37.gameObject:SetActive(false)
					end
				end
			end

			local var_403_38 = 0.001

			if var_403_35 <= arg_400_1.time_ and arg_400_1.time_ < var_403_35 + var_403_38 then
				local var_403_39 = (arg_400_1.time_ - var_403_35) / var_403_38
				local var_403_40 = Vector3.New(0, -2000, 0)

				var_403_34.localPosition = Vector3.Lerp(arg_400_1.var_.moveOldPos1148, var_403_40, var_403_39)
			end

			if arg_400_1.time_ >= var_403_35 + var_403_38 and arg_400_1.time_ < var_403_35 + var_403_38 + arg_403_0 then
				var_403_34.localPosition = Vector3.New(0, -2000, 0)
			end

			local var_403_41 = arg_400_1.actors_["1148"]
			local var_403_42 = 3.96666666666667

			if var_403_42 < arg_400_1.time_ and arg_400_1.time_ <= var_403_42 + arg_403_0 and not isNil(var_403_41) and arg_400_1.var_.actorSpriteComps1148 == nil then
				arg_400_1.var_.actorSpriteComps1148 = var_403_41:GetComponentsInChildren(typeof(Image), true)
			end

			local var_403_43 = 0.125

			if var_403_42 <= arg_400_1.time_ and arg_400_1.time_ < var_403_42 + var_403_43 and not isNil(var_403_41) then
				local var_403_44 = (arg_400_1.time_ - var_403_42) / var_403_43

				if arg_400_1.var_.actorSpriteComps1148 then
					for iter_403_4, iter_403_5 in pairs(arg_400_1.var_.actorSpriteComps1148:ToTable()) do
						if iter_403_5 then
							if arg_400_1.isInRecall_ then
								local var_403_45 = Mathf.Lerp(iter_403_5.color.r, arg_400_1.hightColor1.r, var_403_44)
								local var_403_46 = Mathf.Lerp(iter_403_5.color.g, arg_400_1.hightColor1.g, var_403_44)
								local var_403_47 = Mathf.Lerp(iter_403_5.color.b, arg_400_1.hightColor1.b, var_403_44)

								iter_403_5.color = Color.New(var_403_45, var_403_46, var_403_47)
							else
								local var_403_48 = Mathf.Lerp(iter_403_5.color.r, 1, var_403_44)

								iter_403_5.color = Color.New(var_403_48, var_403_48, var_403_48)
							end
						end
					end
				end
			end

			if arg_400_1.time_ >= var_403_42 + var_403_43 and arg_400_1.time_ < var_403_42 + var_403_43 + arg_403_0 and not isNil(var_403_41) and arg_400_1.var_.actorSpriteComps1148 then
				for iter_403_6, iter_403_7 in pairs(arg_400_1.var_.actorSpriteComps1148:ToTable()) do
					if iter_403_7 then
						if arg_400_1.isInRecall_ then
							iter_403_7.color = arg_400_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_403_7.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_400_1.var_.actorSpriteComps1148 = nil
			end

			local var_403_49 = arg_400_1.actors_["1148"].transform
			local var_403_50 = 3.96666666666667

			if var_403_50 < arg_400_1.time_ and arg_400_1.time_ <= var_403_50 + arg_403_0 then
				arg_400_1.var_.moveOldPos1148 = var_403_49.localPosition
				var_403_49.localScale = Vector3.New(1, 1, 1)

				arg_400_1:CheckSpriteTmpPos("1148", 3)

				local var_403_51 = var_403_49.childCount

				for iter_403_8 = 0, var_403_51 - 1 do
					local var_403_52 = var_403_49:GetChild(iter_403_8)

					if var_403_52.name == "" or not string.find(var_403_52.name, "split") then
						var_403_52.gameObject:SetActive(true)
					else
						var_403_52.gameObject:SetActive(false)
					end
				end
			end

			local var_403_53 = 0.001

			if var_403_50 <= arg_400_1.time_ and arg_400_1.time_ < var_403_50 + var_403_53 then
				local var_403_54 = (arg_400_1.time_ - var_403_50) / var_403_53
				local var_403_55 = Vector3.New(0, -429, -180)

				var_403_49.localPosition = Vector3.Lerp(arg_400_1.var_.moveOldPos1148, var_403_55, var_403_54)
			end

			if arg_400_1.time_ >= var_403_50 + var_403_53 and arg_400_1.time_ < var_403_50 + var_403_53 + arg_403_0 then
				var_403_49.localPosition = Vector3.New(0, -429, -180)
			end

			if arg_400_1.frameCnt_ <= 1 then
				arg_400_1.dialog_:SetActive(false)
			end

			local var_403_56 = 4
			local var_403_57 = 0.5

			if var_403_56 < arg_400_1.time_ and arg_400_1.time_ <= var_403_56 + arg_403_0 then
				arg_400_1.talkMaxDuration = 0

				arg_400_1.dialog_:SetActive(true)

				arg_400_1.dialogCg_.alpha = 0

				local var_403_58 = LeanTween.value(arg_400_1.dialog_, 0, 1, 0.3)

				var_403_58:setOnUpdate(LuaHelper.FloatAction(function(arg_404_0)
					arg_400_1.dialogCg_.alpha = arg_404_0
				end))
				var_403_58:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_400_1.dialog_)
					var_403_58:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_400_1.duration_ = arg_400_1.duration_ + 0.3

				SetActive(arg_400_1.leftNameGo_, true)

				local var_403_59 = arg_400_1:FormatText(StoryNameCfg[8].name)

				arg_400_1.leftNameTxt_.text = var_403_59

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_400_1.leftNameTxt_.transform)

				arg_400_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_400_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_400_1:RecordName(arg_400_1.leftNameTxt_.text)
				SetActive(arg_400_1.iconTrs_.gameObject, false)
				arg_400_1.callingController_:SetSelectedState("normal")

				local var_403_60 = arg_400_1:GetWordFromCfg(416071096)
				local var_403_61 = arg_400_1:FormatText(var_403_60.content)

				arg_400_1.text_.text = var_403_61

				LuaForUtil.ClearLinePrefixSymbol(arg_400_1.text_)

				local var_403_62 = 20
				local var_403_63 = utf8.len(var_403_61)
				local var_403_64 = var_403_62 <= 0 and var_403_57 or var_403_57 * (var_403_63 / var_403_62)

				if var_403_64 > 0 and var_403_57 < var_403_64 then
					arg_400_1.talkMaxDuration = var_403_64
					var_403_56 = var_403_56 + 0.3

					if var_403_64 + var_403_56 > arg_400_1.duration_ then
						arg_400_1.duration_ = var_403_64 + var_403_56
					end
				end

				arg_400_1.text_.text = var_403_61
				arg_400_1.typewritter.percent = 0

				arg_400_1.typewritter:SetDirty()
				arg_400_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_416071", "416071096", "story_v_out_416071.awb") ~= 0 then
					local var_403_65 = manager.audio:GetVoiceLength("story_v_out_416071", "416071096", "story_v_out_416071.awb") / 1000

					if var_403_65 + var_403_56 > arg_400_1.duration_ then
						arg_400_1.duration_ = var_403_65 + var_403_56
					end

					if var_403_60.prefab_name ~= "" and arg_400_1.actors_[var_403_60.prefab_name] ~= nil then
						local var_403_66 = LuaForUtil.PlayVoiceWithCriLipsync(arg_400_1.actors_[var_403_60.prefab_name].transform, "story_v_out_416071", "416071096", "story_v_out_416071.awb")

						arg_400_1:RecordAudio("416071096", var_403_66)
						arg_400_1:RecordAudio("416071096", var_403_66)
					else
						arg_400_1:AudioAction("play", "voice", "story_v_out_416071", "416071096", "story_v_out_416071.awb")
					end

					arg_400_1:RecordHistoryTalkVoice("story_v_out_416071", "416071096", "story_v_out_416071.awb")
				end

				arg_400_1:RecordContent(arg_400_1.text_.text)
			end

			local var_403_67 = var_403_56 + 0.3
			local var_403_68 = math.max(var_403_57, arg_400_1.talkMaxDuration)

			if var_403_67 <= arg_400_1.time_ and arg_400_1.time_ < var_403_67 + var_403_68 then
				arg_400_1.typewritter.percent = (arg_400_1.time_ - var_403_67) / var_403_68

				arg_400_1.typewritter:SetDirty()
			end

			if arg_400_1.time_ >= var_403_67 + var_403_68 and arg_400_1.time_ < var_403_67 + var_403_68 + arg_403_0 then
				arg_400_1.typewritter.percent = 1

				arg_400_1.typewritter:SetDirty()
				arg_400_1:ShowNextGo(true)
			end
		end

		arg_400_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10108",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 1.966,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			},
			{
				assetPath = "",
				actorName = "1148",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 1.966,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			},
			{
				assetPath = "",
				actorName = "1148",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 3.96666666666667,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_400_1:InitPlayNodeList()
	end,
	Play416071097 = function(arg_406_0, arg_406_1)
		arg_406_1.time_ = 0
		arg_406_1.frameCnt_ = 0
		arg_406_1.state_ = "playing"
		arg_406_1.curTalkId_ = 416071097
		arg_406_1.duration_ = 7.5

		local var_406_0 = {
			zh = 6.233,
			ja = 7.5
		}
		local var_406_1 = manager.audio:GetLocalizationFlag()

		if var_406_0[var_406_1] ~= nil then
			arg_406_1.duration_ = var_406_0[var_406_1]
		end

		SetActive(arg_406_1.tipsGo_, false)

		function arg_406_1.onSingleLineFinish_()
			arg_406_1.onSingleLineUpdate_ = nil
			arg_406_1.onSingleLineFinish_ = nil
			arg_406_1.state_ = "waiting"
		end

		function arg_406_1.playNext_(arg_408_0)
			if arg_408_0 == 1 then
				arg_406_0:Play416071098(arg_406_1)
			end
		end

		function arg_406_1.onSingleLineUpdate_(arg_409_0)
			local var_409_0 = 1

			if var_409_0 < arg_406_1.time_ and arg_406_1.time_ <= var_409_0 + arg_409_0 then
				local var_409_1 = manager.ui.mainCamera.transform.localPosition
				local var_409_2 = Vector3.New(0, 0, 10) + Vector3.New(var_409_1.x, var_409_1.y, 0)
				local var_409_3 = arg_406_1.bgs_.STblack

				var_409_3.transform.localPosition = var_409_2
				var_409_3.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_409_4 = var_409_3:GetComponent("SpriteRenderer")

				if var_409_4 and var_409_4.sprite then
					local var_409_5 = (var_409_3.transform.localPosition - var_409_1).z
					local var_409_6 = manager.ui.mainCameraCom_
					local var_409_7 = 2 * var_409_5 * Mathf.Tan(var_409_6.fieldOfView * 0.5 * Mathf.Deg2Rad)
					local var_409_8 = var_409_7 * var_409_6.aspect
					local var_409_9 = var_409_4.sprite.bounds.size.x
					local var_409_10 = var_409_4.sprite.bounds.size.y
					local var_409_11 = var_409_8 / var_409_9
					local var_409_12 = var_409_7 / var_409_10
					local var_409_13 = var_409_12 < var_409_11 and var_409_11 or var_409_12

					var_409_3.transform.localScale = Vector3.New(var_409_13, var_409_13, 0)
				end

				for iter_409_0, iter_409_1 in pairs(arg_406_1.bgs_) do
					if iter_409_0 ~= "STblack" then
						iter_409_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_409_14 = 3

			if var_409_14 < arg_406_1.time_ and arg_406_1.time_ <= var_409_14 + arg_409_0 then
				arg_406_1.allBtn_.enabled = false
			end

			local var_409_15 = 0.3

			if arg_406_1.time_ >= var_409_14 + var_409_15 and arg_406_1.time_ < var_409_14 + var_409_15 + arg_409_0 then
				arg_406_1.allBtn_.enabled = true
			end

			local var_409_16 = 0

			if var_409_16 < arg_406_1.time_ and arg_406_1.time_ <= var_409_16 + arg_409_0 then
				arg_406_1.mask_.enabled = true
				arg_406_1.mask_.raycastTarget = true

				arg_406_1:SetGaussion(false)
			end

			local var_409_17 = 1

			if var_409_16 <= arg_406_1.time_ and arg_406_1.time_ < var_409_16 + var_409_17 then
				local var_409_18 = (arg_406_1.time_ - var_409_16) / var_409_17
				local var_409_19 = Color.New(0, 0, 0)

				var_409_19.a = Mathf.Lerp(0, 1, var_409_18)
				arg_406_1.mask_.color = var_409_19
			end

			if arg_406_1.time_ >= var_409_16 + var_409_17 and arg_406_1.time_ < var_409_16 + var_409_17 + arg_409_0 then
				local var_409_20 = Color.New(0, 0, 0)

				var_409_20.a = 1
				arg_406_1.mask_.color = var_409_20
			end

			local var_409_21 = 1

			if var_409_21 < arg_406_1.time_ and arg_406_1.time_ <= var_409_21 + arg_409_0 then
				arg_406_1.mask_.enabled = true
				arg_406_1.mask_.raycastTarget = true

				arg_406_1:SetGaussion(false)
			end

			local var_409_22 = 2

			if var_409_21 <= arg_406_1.time_ and arg_406_1.time_ < var_409_21 + var_409_22 then
				local var_409_23 = (arg_406_1.time_ - var_409_21) / var_409_22
				local var_409_24 = Color.New(0, 0, 0)

				var_409_24.a = Mathf.Lerp(1, 0, var_409_23)
				arg_406_1.mask_.color = var_409_24
			end

			if arg_406_1.time_ >= var_409_21 + var_409_22 and arg_406_1.time_ < var_409_21 + var_409_22 + arg_409_0 then
				local var_409_25 = Color.New(0, 0, 0)
				local var_409_26 = 0

				arg_406_1.mask_.enabled = false
				var_409_25.a = var_409_26
				arg_406_1.mask_.color = var_409_25
			end

			local var_409_27 = arg_406_1.actors_["1148"]
			local var_409_28 = 2.966

			if var_409_28 < arg_406_1.time_ and arg_406_1.time_ <= var_409_28 + arg_409_0 and not isNil(var_409_27) and arg_406_1.var_.actorSpriteComps1148 == nil then
				arg_406_1.var_.actorSpriteComps1148 = var_409_27:GetComponentsInChildren(typeof(Image), true)
			end

			local var_409_29 = 0.125

			if var_409_28 <= arg_406_1.time_ and arg_406_1.time_ < var_409_28 + var_409_29 and not isNil(var_409_27) then
				local var_409_30 = (arg_406_1.time_ - var_409_28) / var_409_29

				if arg_406_1.var_.actorSpriteComps1148 then
					for iter_409_2, iter_409_3 in pairs(arg_406_1.var_.actorSpriteComps1148:ToTable()) do
						if iter_409_3 then
							if arg_406_1.isInRecall_ then
								local var_409_31 = Mathf.Lerp(iter_409_3.color.r, arg_406_1.hightColor1.r, var_409_30)
								local var_409_32 = Mathf.Lerp(iter_409_3.color.g, arg_406_1.hightColor1.g, var_409_30)
								local var_409_33 = Mathf.Lerp(iter_409_3.color.b, arg_406_1.hightColor1.b, var_409_30)

								iter_409_3.color = Color.New(var_409_31, var_409_32, var_409_33)
							else
								local var_409_34 = Mathf.Lerp(iter_409_3.color.r, 1, var_409_30)

								iter_409_3.color = Color.New(var_409_34, var_409_34, var_409_34)
							end
						end
					end
				end
			end

			if arg_406_1.time_ >= var_409_28 + var_409_29 and arg_406_1.time_ < var_409_28 + var_409_29 + arg_409_0 and not isNil(var_409_27) and arg_406_1.var_.actorSpriteComps1148 then
				for iter_409_4, iter_409_5 in pairs(arg_406_1.var_.actorSpriteComps1148:ToTable()) do
					if iter_409_5 then
						if arg_406_1.isInRecall_ then
							iter_409_5.color = arg_406_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_409_5.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_406_1.var_.actorSpriteComps1148 = nil
			end

			local var_409_35 = 0
			local var_409_36 = 1

			if var_409_35 < arg_406_1.time_ and arg_406_1.time_ <= var_409_35 + arg_409_0 then
				local var_409_37 = "play"
				local var_409_38 = "effect"

				arg_406_1:AudioAction(var_409_37, var_409_38, "se_story_132", "se_story_132_fall", "")
			end

			if arg_406_1.frameCnt_ <= 1 then
				arg_406_1.dialog_:SetActive(false)
			end

			local var_409_39 = 3
			local var_409_40 = 0.25

			if var_409_39 < arg_406_1.time_ and arg_406_1.time_ <= var_409_39 + arg_409_0 then
				arg_406_1.talkMaxDuration = 0

				arg_406_1.dialog_:SetActive(true)

				arg_406_1.dialogCg_.alpha = 0

				local var_409_41 = LeanTween.value(arg_406_1.dialog_, 0, 1, 0.3)

				var_409_41:setOnUpdate(LuaHelper.FloatAction(function(arg_410_0)
					arg_406_1.dialogCg_.alpha = arg_410_0
				end))
				var_409_41:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_406_1.dialog_)
					var_409_41:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_406_1.duration_ = arg_406_1.duration_ + 0.3

				SetActive(arg_406_1.leftNameGo_, true)

				local var_409_42 = arg_406_1:FormatText(StoryNameCfg[8].name)

				arg_406_1.leftNameTxt_.text = var_409_42

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_406_1.leftNameTxt_.transform)

				arg_406_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_406_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_406_1:RecordName(arg_406_1.leftNameTxt_.text)
				SetActive(arg_406_1.iconTrs_.gameObject, false)
				arg_406_1.callingController_:SetSelectedState("normal")

				local var_409_43 = arg_406_1:GetWordFromCfg(416071097)
				local var_409_44 = arg_406_1:FormatText(var_409_43.content)

				arg_406_1.text_.text = var_409_44

				LuaForUtil.ClearLinePrefixSymbol(arg_406_1.text_)

				local var_409_45 = 10
				local var_409_46 = utf8.len(var_409_44)
				local var_409_47 = var_409_45 <= 0 and var_409_40 or var_409_40 * (var_409_46 / var_409_45)

				if var_409_47 > 0 and var_409_40 < var_409_47 then
					arg_406_1.talkMaxDuration = var_409_47
					var_409_39 = var_409_39 + 0.3

					if var_409_47 + var_409_39 > arg_406_1.duration_ then
						arg_406_1.duration_ = var_409_47 + var_409_39
					end
				end

				arg_406_1.text_.text = var_409_44
				arg_406_1.typewritter.percent = 0

				arg_406_1.typewritter:SetDirty()
				arg_406_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_416071", "416071097", "story_v_out_416071.awb") ~= 0 then
					local var_409_48 = manager.audio:GetVoiceLength("story_v_out_416071", "416071097", "story_v_out_416071.awb") / 1000

					if var_409_48 + var_409_39 > arg_406_1.duration_ then
						arg_406_1.duration_ = var_409_48 + var_409_39
					end

					if var_409_43.prefab_name ~= "" and arg_406_1.actors_[var_409_43.prefab_name] ~= nil then
						local var_409_49 = LuaForUtil.PlayVoiceWithCriLipsync(arg_406_1.actors_[var_409_43.prefab_name].transform, "story_v_out_416071", "416071097", "story_v_out_416071.awb")

						arg_406_1:RecordAudio("416071097", var_409_49)
						arg_406_1:RecordAudio("416071097", var_409_49)
					else
						arg_406_1:AudioAction("play", "voice", "story_v_out_416071", "416071097", "story_v_out_416071.awb")
					end

					arg_406_1:RecordHistoryTalkVoice("story_v_out_416071", "416071097", "story_v_out_416071.awb")
				end

				arg_406_1:RecordContent(arg_406_1.text_.text)
			end

			local var_409_50 = var_409_39 + 0.3
			local var_409_51 = math.max(var_409_40, arg_406_1.talkMaxDuration)

			if var_409_50 <= arg_406_1.time_ and arg_406_1.time_ < var_409_50 + var_409_51 then
				arg_406_1.typewritter.percent = (arg_406_1.time_ - var_409_50) / var_409_51

				arg_406_1.typewritter:SetDirty()
			end

			if arg_406_1.time_ >= var_409_50 + var_409_51 and arg_406_1.time_ < var_409_50 + var_409_51 + arg_409_0 then
				arg_406_1.typewritter.percent = 1

				arg_406_1.typewritter:SetDirty()
				arg_406_1:ShowNextGo(true)
			end
		end

		arg_406_1.nodeConfigList_ = {}

		arg_406_1:InitPlayNodeList()
	end,
	Play416071098 = function(arg_412_0, arg_412_1)
		arg_412_1.time_ = 0
		arg_412_1.frameCnt_ = 0
		arg_412_1.state_ = "playing"
		arg_412_1.curTalkId_ = 416071098
		arg_412_1.duration_ = 3.27

		local var_412_0 = {
			zh = 3.266,
			ja = 2.633
		}
		local var_412_1 = manager.audio:GetLocalizationFlag()

		if var_412_0[var_412_1] ~= nil then
			arg_412_1.duration_ = var_412_0[var_412_1]
		end

		SetActive(arg_412_1.tipsGo_, false)

		function arg_412_1.onSingleLineFinish_()
			arg_412_1.onSingleLineUpdate_ = nil
			arg_412_1.onSingleLineFinish_ = nil
			arg_412_1.state_ = "waiting"
		end

		function arg_412_1.playNext_(arg_414_0)
			if arg_414_0 == 1 then
				arg_412_0:Play416071099(arg_412_1)
			end
		end

		function arg_412_1.onSingleLineUpdate_(arg_415_0)
			local var_415_0 = arg_412_1.actors_["1148"].transform
			local var_415_1 = 0

			if var_415_1 < arg_412_1.time_ and arg_412_1.time_ <= var_415_1 + arg_415_0 then
				arg_412_1.var_.moveOldPos1148 = var_415_0.localPosition
				var_415_0.localScale = Vector3.New(1, 1, 1)

				arg_412_1:CheckSpriteTmpPos("1148", 3)

				local var_415_2 = var_415_0.childCount

				for iter_415_0 = 0, var_415_2 - 1 do
					local var_415_3 = var_415_0:GetChild(iter_415_0)

					if var_415_3.name == "split_4" or not string.find(var_415_3.name, "split") then
						var_415_3.gameObject:SetActive(true)
					else
						var_415_3.gameObject:SetActive(false)
					end
				end
			end

			local var_415_4 = 0.001

			if var_415_1 <= arg_412_1.time_ and arg_412_1.time_ < var_415_1 + var_415_4 then
				local var_415_5 = (arg_412_1.time_ - var_415_1) / var_415_4
				local var_415_6 = Vector3.New(0, -429, -180)

				var_415_0.localPosition = Vector3.Lerp(arg_412_1.var_.moveOldPos1148, var_415_6, var_415_5)
			end

			if arg_412_1.time_ >= var_415_1 + var_415_4 and arg_412_1.time_ < var_415_1 + var_415_4 + arg_415_0 then
				var_415_0.localPosition = Vector3.New(0, -429, -180)
			end

			local var_415_7 = 0
			local var_415_8 = 1

			if var_415_7 < arg_412_1.time_ and arg_412_1.time_ <= var_415_7 + arg_415_0 then
				local var_415_9 = "play"
				local var_415_10 = "effect"

				arg_412_1:AudioAction(var_415_9, var_415_10, "se_story_16", "se_story_16_hit", "")
			end

			local var_415_11 = 0
			local var_415_12 = 0.175

			if var_415_11 < arg_412_1.time_ and arg_412_1.time_ <= var_415_11 + arg_415_0 then
				arg_412_1.talkMaxDuration = 0
				arg_412_1.dialogCg_.alpha = 1

				arg_412_1.dialog_:SetActive(true)
				SetActive(arg_412_1.leftNameGo_, true)

				local var_415_13 = arg_412_1:FormatText(StoryNameCfg[8].name)

				arg_412_1.leftNameTxt_.text = var_415_13

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_412_1.leftNameTxt_.transform)

				arg_412_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_412_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_412_1:RecordName(arg_412_1.leftNameTxt_.text)
				SetActive(arg_412_1.iconTrs_.gameObject, false)
				arg_412_1.callingController_:SetSelectedState("normal")

				local var_415_14 = arg_412_1:GetWordFromCfg(416071098)
				local var_415_15 = arg_412_1:FormatText(var_415_14.content)

				arg_412_1.text_.text = var_415_15

				LuaForUtil.ClearLinePrefixSymbol(arg_412_1.text_)

				local var_415_16 = 7
				local var_415_17 = utf8.len(var_415_15)
				local var_415_18 = var_415_16 <= 0 and var_415_12 or var_415_12 * (var_415_17 / var_415_16)

				if var_415_18 > 0 and var_415_12 < var_415_18 then
					arg_412_1.talkMaxDuration = var_415_18

					if var_415_18 + var_415_11 > arg_412_1.duration_ then
						arg_412_1.duration_ = var_415_18 + var_415_11
					end
				end

				arg_412_1.text_.text = var_415_15
				arg_412_1.typewritter.percent = 0

				arg_412_1.typewritter:SetDirty()
				arg_412_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_416071", "416071098", "story_v_out_416071.awb") ~= 0 then
					local var_415_19 = manager.audio:GetVoiceLength("story_v_out_416071", "416071098", "story_v_out_416071.awb") / 1000

					if var_415_19 + var_415_11 > arg_412_1.duration_ then
						arg_412_1.duration_ = var_415_19 + var_415_11
					end

					if var_415_14.prefab_name ~= "" and arg_412_1.actors_[var_415_14.prefab_name] ~= nil then
						local var_415_20 = LuaForUtil.PlayVoiceWithCriLipsync(arg_412_1.actors_[var_415_14.prefab_name].transform, "story_v_out_416071", "416071098", "story_v_out_416071.awb")

						arg_412_1:RecordAudio("416071098", var_415_20)
						arg_412_1:RecordAudio("416071098", var_415_20)
					else
						arg_412_1:AudioAction("play", "voice", "story_v_out_416071", "416071098", "story_v_out_416071.awb")
					end

					arg_412_1:RecordHistoryTalkVoice("story_v_out_416071", "416071098", "story_v_out_416071.awb")
				end

				arg_412_1:RecordContent(arg_412_1.text_.text)
			end

			local var_415_21 = math.max(var_415_12, arg_412_1.talkMaxDuration)

			if var_415_11 <= arg_412_1.time_ and arg_412_1.time_ < var_415_11 + var_415_21 then
				arg_412_1.typewritter.percent = (arg_412_1.time_ - var_415_11) / var_415_21

				arg_412_1.typewritter:SetDirty()
			end

			if arg_412_1.time_ >= var_415_11 + var_415_21 and arg_412_1.time_ < var_415_11 + var_415_21 + arg_415_0 then
				arg_412_1.typewritter.percent = 1

				arg_412_1.typewritter:SetDirty()
				arg_412_1:ShowNextGo(true)
			end
		end

		arg_412_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1148",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_412_1:InitPlayNodeList()
	end,
	Play416071099 = function(arg_416_0, arg_416_1)
		arg_416_1.time_ = 0
		arg_416_1.frameCnt_ = 0
		arg_416_1.state_ = "playing"
		arg_416_1.curTalkId_ = 416071099
		arg_416_1.duration_ = 3.53

		local var_416_0 = {
			zh = 3.533,
			ja = 2.7
		}
		local var_416_1 = manager.audio:GetLocalizationFlag()

		if var_416_0[var_416_1] ~= nil then
			arg_416_1.duration_ = var_416_0[var_416_1]
		end

		SetActive(arg_416_1.tipsGo_, false)

		function arg_416_1.onSingleLineFinish_()
			arg_416_1.onSingleLineUpdate_ = nil
			arg_416_1.onSingleLineFinish_ = nil
			arg_416_1.state_ = "waiting"
		end

		function arg_416_1.playNext_(arg_418_0)
			if arg_418_0 == 1 then
				arg_416_0:Play416071100(arg_416_1)
			end
		end

		function arg_416_1.onSingleLineUpdate_(arg_419_0)
			local var_419_0 = arg_416_1.actors_["1148"]
			local var_419_1 = 0

			if var_419_1 < arg_416_1.time_ and arg_416_1.time_ <= var_419_1 + arg_419_0 and not isNil(var_419_0) and arg_416_1.var_.actorSpriteComps1148 == nil then
				arg_416_1.var_.actorSpriteComps1148 = var_419_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_419_2 = 0.125

			if var_419_1 <= arg_416_1.time_ and arg_416_1.time_ < var_419_1 + var_419_2 and not isNil(var_419_0) then
				local var_419_3 = (arg_416_1.time_ - var_419_1) / var_419_2

				if arg_416_1.var_.actorSpriteComps1148 then
					for iter_419_0, iter_419_1 in pairs(arg_416_1.var_.actorSpriteComps1148:ToTable()) do
						if iter_419_1 then
							if arg_416_1.isInRecall_ then
								local var_419_4 = Mathf.Lerp(iter_419_1.color.r, arg_416_1.hightColor2.r, var_419_3)
								local var_419_5 = Mathf.Lerp(iter_419_1.color.g, arg_416_1.hightColor2.g, var_419_3)
								local var_419_6 = Mathf.Lerp(iter_419_1.color.b, arg_416_1.hightColor2.b, var_419_3)

								iter_419_1.color = Color.New(var_419_4, var_419_5, var_419_6)
							else
								local var_419_7 = Mathf.Lerp(iter_419_1.color.r, 0.5, var_419_3)

								iter_419_1.color = Color.New(var_419_7, var_419_7, var_419_7)
							end
						end
					end
				end
			end

			if arg_416_1.time_ >= var_419_1 + var_419_2 and arg_416_1.time_ < var_419_1 + var_419_2 + arg_419_0 and not isNil(var_419_0) and arg_416_1.var_.actorSpriteComps1148 then
				for iter_419_2, iter_419_3 in pairs(arg_416_1.var_.actorSpriteComps1148:ToTable()) do
					if iter_419_3 then
						if arg_416_1.isInRecall_ then
							iter_419_3.color = arg_416_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_419_3.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_416_1.var_.actorSpriteComps1148 = nil
			end

			local var_419_8 = arg_416_1.actors_["1148"].transform
			local var_419_9 = 0

			if var_419_9 < arg_416_1.time_ and arg_416_1.time_ <= var_419_9 + arg_419_0 then
				arg_416_1.var_.moveOldPos1148 = var_419_8.localPosition
				var_419_8.localScale = Vector3.New(1, 1, 1)

				arg_416_1:CheckSpriteTmpPos("1148", 2)

				local var_419_10 = var_419_8.childCount

				for iter_419_4 = 0, var_419_10 - 1 do
					local var_419_11 = var_419_8:GetChild(iter_419_4)

					if var_419_11.name == "split_4" or not string.find(var_419_11.name, "split") then
						var_419_11.gameObject:SetActive(true)
					else
						var_419_11.gameObject:SetActive(false)
					end
				end
			end

			local var_419_12 = 0.001

			if var_419_9 <= arg_416_1.time_ and arg_416_1.time_ < var_419_9 + var_419_12 then
				local var_419_13 = (arg_416_1.time_ - var_419_9) / var_419_12
				local var_419_14 = Vector3.New(-390, -429, -180)

				var_419_8.localPosition = Vector3.Lerp(arg_416_1.var_.moveOldPos1148, var_419_14, var_419_13)
			end

			if arg_416_1.time_ >= var_419_9 + var_419_12 and arg_416_1.time_ < var_419_9 + var_419_12 + arg_419_0 then
				var_419_8.localPosition = Vector3.New(-390, -429, -180)
			end

			local var_419_15 = arg_416_1.actors_["10108"].transform
			local var_419_16 = 0

			if var_419_16 < arg_416_1.time_ and arg_416_1.time_ <= var_419_16 + arg_419_0 then
				arg_416_1.var_.moveOldPos10108 = var_419_15.localPosition
				var_419_15.localScale = Vector3.New(1, 1, 1)

				arg_416_1:CheckSpriteTmpPos("10108", 4)

				local var_419_17 = var_419_15.childCount

				for iter_419_5 = 0, var_419_17 - 1 do
					local var_419_18 = var_419_15:GetChild(iter_419_5)

					if var_419_18.name == "split_1" or not string.find(var_419_18.name, "split") then
						var_419_18.gameObject:SetActive(true)
					else
						var_419_18.gameObject:SetActive(false)
					end
				end
			end

			local var_419_19 = 0.001

			if var_419_16 <= arg_416_1.time_ and arg_416_1.time_ < var_419_16 + var_419_19 then
				local var_419_20 = (arg_416_1.time_ - var_419_16) / var_419_19
				local var_419_21 = Vector3.New(390, -399.6, -130)

				var_419_15.localPosition = Vector3.Lerp(arg_416_1.var_.moveOldPos10108, var_419_21, var_419_20)
			end

			if arg_416_1.time_ >= var_419_16 + var_419_19 and arg_416_1.time_ < var_419_16 + var_419_19 + arg_419_0 then
				var_419_15.localPosition = Vector3.New(390, -399.6, -130)
			end

			local var_419_22 = arg_416_1.actors_["10108"]
			local var_419_23 = 0

			if var_419_23 < arg_416_1.time_ and arg_416_1.time_ <= var_419_23 + arg_419_0 and not isNil(var_419_22) and arg_416_1.var_.actorSpriteComps10108 == nil then
				arg_416_1.var_.actorSpriteComps10108 = var_419_22:GetComponentsInChildren(typeof(Image), true)
			end

			local var_419_24 = 0.125

			if var_419_23 <= arg_416_1.time_ and arg_416_1.time_ < var_419_23 + var_419_24 and not isNil(var_419_22) then
				local var_419_25 = (arg_416_1.time_ - var_419_23) / var_419_24

				if arg_416_1.var_.actorSpriteComps10108 then
					for iter_419_6, iter_419_7 in pairs(arg_416_1.var_.actorSpriteComps10108:ToTable()) do
						if iter_419_7 then
							if arg_416_1.isInRecall_ then
								local var_419_26 = Mathf.Lerp(iter_419_7.color.r, arg_416_1.hightColor1.r, var_419_25)
								local var_419_27 = Mathf.Lerp(iter_419_7.color.g, arg_416_1.hightColor1.g, var_419_25)
								local var_419_28 = Mathf.Lerp(iter_419_7.color.b, arg_416_1.hightColor1.b, var_419_25)

								iter_419_7.color = Color.New(var_419_26, var_419_27, var_419_28)
							else
								local var_419_29 = Mathf.Lerp(iter_419_7.color.r, 1, var_419_25)

								iter_419_7.color = Color.New(var_419_29, var_419_29, var_419_29)
							end
						end
					end
				end
			end

			if arg_416_1.time_ >= var_419_23 + var_419_24 and arg_416_1.time_ < var_419_23 + var_419_24 + arg_419_0 and not isNil(var_419_22) and arg_416_1.var_.actorSpriteComps10108 then
				for iter_419_8, iter_419_9 in pairs(arg_416_1.var_.actorSpriteComps10108:ToTable()) do
					if iter_419_9 then
						if arg_416_1.isInRecall_ then
							iter_419_9.color = arg_416_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_419_9.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_416_1.var_.actorSpriteComps10108 = nil
			end

			local var_419_30 = 0
			local var_419_31 = 1

			if var_419_30 < arg_416_1.time_ and arg_416_1.time_ <= var_419_30 + arg_419_0 then
				local var_419_32 = "play"
				local var_419_33 = "effect"

				arg_416_1:AudioAction(var_419_32, var_419_33, "se_story_138", "se_story_138_footstep", "")
			end

			local var_419_34 = 0
			local var_419_35 = 0.225

			if var_419_34 < arg_416_1.time_ and arg_416_1.time_ <= var_419_34 + arg_419_0 then
				arg_416_1.talkMaxDuration = 0
				arg_416_1.dialogCg_.alpha = 1

				arg_416_1.dialog_:SetActive(true)
				SetActive(arg_416_1.leftNameGo_, true)

				local var_419_36 = arg_416_1:FormatText(StoryNameCfg[1083].name)

				arg_416_1.leftNameTxt_.text = var_419_36

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_416_1.leftNameTxt_.transform)

				arg_416_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_416_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_416_1:RecordName(arg_416_1.leftNameTxt_.text)
				SetActive(arg_416_1.iconTrs_.gameObject, false)
				arg_416_1.callingController_:SetSelectedState("normal")

				local var_419_37 = arg_416_1:GetWordFromCfg(416071099)
				local var_419_38 = arg_416_1:FormatText(var_419_37.content)

				arg_416_1.text_.text = var_419_38

				LuaForUtil.ClearLinePrefixSymbol(arg_416_1.text_)

				local var_419_39 = 9
				local var_419_40 = utf8.len(var_419_38)
				local var_419_41 = var_419_39 <= 0 and var_419_35 or var_419_35 * (var_419_40 / var_419_39)

				if var_419_41 > 0 and var_419_35 < var_419_41 then
					arg_416_1.talkMaxDuration = var_419_41

					if var_419_41 + var_419_34 > arg_416_1.duration_ then
						arg_416_1.duration_ = var_419_41 + var_419_34
					end
				end

				arg_416_1.text_.text = var_419_38
				arg_416_1.typewritter.percent = 0

				arg_416_1.typewritter:SetDirty()
				arg_416_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_416071", "416071099", "story_v_out_416071.awb") ~= 0 then
					local var_419_42 = manager.audio:GetVoiceLength("story_v_out_416071", "416071099", "story_v_out_416071.awb") / 1000

					if var_419_42 + var_419_34 > arg_416_1.duration_ then
						arg_416_1.duration_ = var_419_42 + var_419_34
					end

					if var_419_37.prefab_name ~= "" and arg_416_1.actors_[var_419_37.prefab_name] ~= nil then
						local var_419_43 = LuaForUtil.PlayVoiceWithCriLipsync(arg_416_1.actors_[var_419_37.prefab_name].transform, "story_v_out_416071", "416071099", "story_v_out_416071.awb")

						arg_416_1:RecordAudio("416071099", var_419_43)
						arg_416_1:RecordAudio("416071099", var_419_43)
					else
						arg_416_1:AudioAction("play", "voice", "story_v_out_416071", "416071099", "story_v_out_416071.awb")
					end

					arg_416_1:RecordHistoryTalkVoice("story_v_out_416071", "416071099", "story_v_out_416071.awb")
				end

				arg_416_1:RecordContent(arg_416_1.text_.text)
			end

			local var_419_44 = math.max(var_419_35, arg_416_1.talkMaxDuration)

			if var_419_34 <= arg_416_1.time_ and arg_416_1.time_ < var_419_34 + var_419_44 then
				arg_416_1.typewritter.percent = (arg_416_1.time_ - var_419_34) / var_419_44

				arg_416_1.typewritter:SetDirty()
			end

			if arg_416_1.time_ >= var_419_34 + var_419_44 and arg_416_1.time_ < var_419_34 + var_419_44 + arg_419_0 then
				arg_416_1.typewritter.percent = 1

				arg_416_1.typewritter:SetDirty()
				arg_416_1:ShowNextGo(true)
			end
		end

		arg_416_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1148",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			},
			{
				assetPath = "",
				actorName = "10108",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_416_1:InitPlayNodeList()
	end,
	Play416071100 = function(arg_420_0, arg_420_1)
		arg_420_1.time_ = 0
		arg_420_1.frameCnt_ = 0
		arg_420_1.state_ = "playing"
		arg_420_1.curTalkId_ = 416071100
		arg_420_1.duration_ = 3.83

		local var_420_0 = {
			zh = 3.833,
			ja = 3.666
		}
		local var_420_1 = manager.audio:GetLocalizationFlag()

		if var_420_0[var_420_1] ~= nil then
			arg_420_1.duration_ = var_420_0[var_420_1]
		end

		SetActive(arg_420_1.tipsGo_, false)

		function arg_420_1.onSingleLineFinish_()
			arg_420_1.onSingleLineUpdate_ = nil
			arg_420_1.onSingleLineFinish_ = nil
			arg_420_1.state_ = "waiting"
			arg_420_1.auto_ = false
		end

		function arg_420_1.playNext_(arg_422_0)
			arg_420_1.onStoryFinished_()
		end

		function arg_420_1.onSingleLineUpdate_(arg_423_0)
			local var_423_0 = arg_420_1.actors_["1148"]
			local var_423_1 = 0

			if var_423_1 < arg_420_1.time_ and arg_420_1.time_ <= var_423_1 + arg_423_0 and not isNil(var_423_0) and arg_420_1.var_.actorSpriteComps1148 == nil then
				arg_420_1.var_.actorSpriteComps1148 = var_423_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_423_2 = 0.125

			if var_423_1 <= arg_420_1.time_ and arg_420_1.time_ < var_423_1 + var_423_2 and not isNil(var_423_0) then
				local var_423_3 = (arg_420_1.time_ - var_423_1) / var_423_2

				if arg_420_1.var_.actorSpriteComps1148 then
					for iter_423_0, iter_423_1 in pairs(arg_420_1.var_.actorSpriteComps1148:ToTable()) do
						if iter_423_1 then
							if arg_420_1.isInRecall_ then
								local var_423_4 = Mathf.Lerp(iter_423_1.color.r, arg_420_1.hightColor1.r, var_423_3)
								local var_423_5 = Mathf.Lerp(iter_423_1.color.g, arg_420_1.hightColor1.g, var_423_3)
								local var_423_6 = Mathf.Lerp(iter_423_1.color.b, arg_420_1.hightColor1.b, var_423_3)

								iter_423_1.color = Color.New(var_423_4, var_423_5, var_423_6)
							else
								local var_423_7 = Mathf.Lerp(iter_423_1.color.r, 1, var_423_3)

								iter_423_1.color = Color.New(var_423_7, var_423_7, var_423_7)
							end
						end
					end
				end
			end

			if arg_420_1.time_ >= var_423_1 + var_423_2 and arg_420_1.time_ < var_423_1 + var_423_2 + arg_423_0 and not isNil(var_423_0) and arg_420_1.var_.actorSpriteComps1148 then
				for iter_423_2, iter_423_3 in pairs(arg_420_1.var_.actorSpriteComps1148:ToTable()) do
					if iter_423_3 then
						if arg_420_1.isInRecall_ then
							iter_423_3.color = arg_420_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_423_3.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_420_1.var_.actorSpriteComps1148 = nil
			end

			local var_423_8 = arg_420_1.actors_["10108"]
			local var_423_9 = 0

			if var_423_9 < arg_420_1.time_ and arg_420_1.time_ <= var_423_9 + arg_423_0 and not isNil(var_423_8) and arg_420_1.var_.actorSpriteComps10108 == nil then
				arg_420_1.var_.actorSpriteComps10108 = var_423_8:GetComponentsInChildren(typeof(Image), true)
			end

			local var_423_10 = 0.125

			if var_423_9 <= arg_420_1.time_ and arg_420_1.time_ < var_423_9 + var_423_10 and not isNil(var_423_8) then
				local var_423_11 = (arg_420_1.time_ - var_423_9) / var_423_10

				if arg_420_1.var_.actorSpriteComps10108 then
					for iter_423_4, iter_423_5 in pairs(arg_420_1.var_.actorSpriteComps10108:ToTable()) do
						if iter_423_5 then
							if arg_420_1.isInRecall_ then
								local var_423_12 = Mathf.Lerp(iter_423_5.color.r, arg_420_1.hightColor2.r, var_423_11)
								local var_423_13 = Mathf.Lerp(iter_423_5.color.g, arg_420_1.hightColor2.g, var_423_11)
								local var_423_14 = Mathf.Lerp(iter_423_5.color.b, arg_420_1.hightColor2.b, var_423_11)

								iter_423_5.color = Color.New(var_423_12, var_423_13, var_423_14)
							else
								local var_423_15 = Mathf.Lerp(iter_423_5.color.r, 0.5, var_423_11)

								iter_423_5.color = Color.New(var_423_15, var_423_15, var_423_15)
							end
						end
					end
				end
			end

			if arg_420_1.time_ >= var_423_9 + var_423_10 and arg_420_1.time_ < var_423_9 + var_423_10 + arg_423_0 and not isNil(var_423_8) and arg_420_1.var_.actorSpriteComps10108 then
				for iter_423_6, iter_423_7 in pairs(arg_420_1.var_.actorSpriteComps10108:ToTable()) do
					if iter_423_7 then
						if arg_420_1.isInRecall_ then
							iter_423_7.color = arg_420_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_423_7.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_420_1.var_.actorSpriteComps10108 = nil
			end

			local var_423_16 = 0
			local var_423_17 = 1

			if var_423_16 < arg_420_1.time_ and arg_420_1.time_ <= var_423_16 + arg_423_0 then
				local var_423_18 = "play"
				local var_423_19 = "effect"

				arg_420_1:AudioAction(var_423_18, var_423_19, "se_story_138", "se_story_138_footstep", "")
			end

			local var_423_20 = 0
			local var_423_21 = 0.275

			if var_423_20 < arg_420_1.time_ and arg_420_1.time_ <= var_423_20 + arg_423_0 then
				arg_420_1.talkMaxDuration = 0
				arg_420_1.dialogCg_.alpha = 1

				arg_420_1.dialog_:SetActive(true)
				SetActive(arg_420_1.leftNameGo_, true)

				local var_423_22 = arg_420_1:FormatText(StoryNameCfg[8].name)

				arg_420_1.leftNameTxt_.text = var_423_22

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_420_1.leftNameTxt_.transform)

				arg_420_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_420_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_420_1:RecordName(arg_420_1.leftNameTxt_.text)
				SetActive(arg_420_1.iconTrs_.gameObject, false)
				arg_420_1.callingController_:SetSelectedState("normal")

				local var_423_23 = arg_420_1:GetWordFromCfg(416071100)
				local var_423_24 = arg_420_1:FormatText(var_423_23.content)

				arg_420_1.text_.text = var_423_24

				LuaForUtil.ClearLinePrefixSymbol(arg_420_1.text_)

				local var_423_25 = 11
				local var_423_26 = utf8.len(var_423_24)
				local var_423_27 = var_423_25 <= 0 and var_423_21 or var_423_21 * (var_423_26 / var_423_25)

				if var_423_27 > 0 and var_423_21 < var_423_27 then
					arg_420_1.talkMaxDuration = var_423_27

					if var_423_27 + var_423_20 > arg_420_1.duration_ then
						arg_420_1.duration_ = var_423_27 + var_423_20
					end
				end

				arg_420_1.text_.text = var_423_24
				arg_420_1.typewritter.percent = 0

				arg_420_1.typewritter:SetDirty()
				arg_420_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_416071", "416071100", "story_v_out_416071.awb") ~= 0 then
					local var_423_28 = manager.audio:GetVoiceLength("story_v_out_416071", "416071100", "story_v_out_416071.awb") / 1000

					if var_423_28 + var_423_20 > arg_420_1.duration_ then
						arg_420_1.duration_ = var_423_28 + var_423_20
					end

					if var_423_23.prefab_name ~= "" and arg_420_1.actors_[var_423_23.prefab_name] ~= nil then
						local var_423_29 = LuaForUtil.PlayVoiceWithCriLipsync(arg_420_1.actors_[var_423_23.prefab_name].transform, "story_v_out_416071", "416071100", "story_v_out_416071.awb")

						arg_420_1:RecordAudio("416071100", var_423_29)
						arg_420_1:RecordAudio("416071100", var_423_29)
					else
						arg_420_1:AudioAction("play", "voice", "story_v_out_416071", "416071100", "story_v_out_416071.awb")
					end

					arg_420_1:RecordHistoryTalkVoice("story_v_out_416071", "416071100", "story_v_out_416071.awb")
				end

				arg_420_1:RecordContent(arg_420_1.text_.text)
			end

			local var_423_30 = math.max(var_423_21, arg_420_1.talkMaxDuration)

			if var_423_20 <= arg_420_1.time_ and arg_420_1.time_ < var_423_20 + var_423_30 then
				arg_420_1.typewritter.percent = (arg_420_1.time_ - var_423_20) / var_423_30

				arg_420_1.typewritter:SetDirty()
			end

			if arg_420_1.time_ >= var_423_20 + var_423_30 and arg_420_1.time_ < var_423_20 + var_423_30 + arg_423_0 then
				arg_420_1.typewritter.percent = 1

				arg_420_1.typewritter:SetDirty()
				arg_420_1:ShowNextGo(true)
			end
		end

		arg_420_1.nodeConfigList_ = {}

		arg_420_1:InitPlayNodeList()
	end,
	assets = {
		"TextureConfig/Background/I14f",
		"TextureConfig/Background/ST0106",
		"TextureConfig/Background/STblack"
	},
	voices = {
		"story_v_out_416071.awb"
	}
}
