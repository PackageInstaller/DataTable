return {
	Play324541001 = function(arg_1_0, arg_1_1)
		arg_1_1.time_ = 0
		arg_1_1.frameCnt_ = 0
		arg_1_1.state_ = "playing"
		arg_1_1.curTalkId_ = 324541001
		arg_1_1.duration_ = 7.67

		SetActive(arg_1_1.tipsGo_, false)

		function arg_1_1.onSingleLineFinish_()
			arg_1_1.onSingleLineUpdate_ = nil
			arg_1_1.onSingleLineFinish_ = nil
			arg_1_1.state_ = "waiting"
		end

		function arg_1_1.playNext_(arg_3_0)
			if arg_3_0 == 1 then
				arg_1_0:Play324541002(arg_1_1)
			end
		end

		function arg_1_1.onSingleLineUpdate_(arg_4_0)
			local var_4_0 = "MS2406"

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
				local var_4_5 = arg_1_1.bgs_.MS2406

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
					if iter_4_0 ~= "MS2406" then
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

			local var_4_24 = arg_1_1.bgs_.MS2406.transform
			local var_4_25 = 0

			if var_4_25 < arg_1_1.time_ and arg_1_1.time_ <= var_4_25 + arg_4_0 then
				arg_1_1.var_.moveOldPosMS2406 = var_4_24.localPosition
			end

			local var_4_26 = 2

			if var_4_25 <= arg_1_1.time_ and arg_1_1.time_ < var_4_25 + var_4_26 then
				local var_4_27 = (arg_1_1.time_ - var_4_25) / var_4_26
				local var_4_28 = Vector3.New(0, 0, 5.5)

				var_4_24.localPosition = Vector3.Lerp(arg_1_1.var_.moveOldPosMS2406, var_4_28, var_4_27)
			end

			if arg_1_1.time_ >= var_4_25 + var_4_26 and arg_1_1.time_ < var_4_25 + var_4_26 + arg_4_0 then
				var_4_24.localPosition = Vector3.New(0, 0, 5.5)
			end

			local var_4_29 = arg_1_1.bgs_.MS2406.transform
			local var_4_30 = 1.8

			if var_4_30 < arg_1_1.time_ and arg_1_1.time_ <= var_4_30 + arg_4_0 then
				arg_1_1.var_.moveOldPosMS2406 = var_4_29.localPosition
			end

			local var_4_31 = 1.1

			if var_4_30 <= arg_1_1.time_ and arg_1_1.time_ < var_4_30 + var_4_31 then
				local var_4_32 = (arg_1_1.time_ - var_4_30) / var_4_31
				local var_4_33 = Vector3.New(0, 1, 10)

				var_4_29.localPosition = Vector3.Lerp(arg_1_1.var_.moveOldPosMS2406, var_4_33, var_4_32)
			end

			if arg_1_1.time_ >= var_4_30 + var_4_31 and arg_1_1.time_ < var_4_30 + var_4_31 + arg_4_0 then
				var_4_29.localPosition = Vector3.New(0, 1, 10)
			end

			local var_4_34 = 0.1
			local var_4_35 = 1

			if var_4_34 < arg_1_1.time_ and arg_1_1.time_ <= var_4_34 + arg_4_0 then
				local var_4_36 = "play"
				local var_4_37 = "effect"

				arg_1_1:AudioAction(var_4_36, var_4_37, "se_story_143", "se_story_143_amb_dark", "")
			end

			local var_4_38 = 0
			local var_4_39 = 1

			if var_4_38 < arg_1_1.time_ and arg_1_1.time_ <= var_4_38 + arg_4_0 then
				local var_4_40 = "play"
				local var_4_41 = "effect"

				arg_1_1:AudioAction(var_4_40, var_4_41, "ui_battle", "ui_battle_stopbgm", "")
			end

			local var_4_42 = 1
			local var_4_43 = 1

			if var_4_42 < arg_1_1.time_ and arg_1_1.time_ <= var_4_42 + arg_4_0 then
				local var_4_44 = "play"
				local var_4_45 = "music"

				arg_1_1:AudioAction(var_4_44, var_4_45, "bgm_activity_4_8_story_taixu", "bgm_activity_4_8_story_taixu", "bgm_activity_4_8_story_taixu.awb")

				local var_4_46 = ""
				local var_4_47 = manager.audio:GetAudioName("bgm_activity_4_8_story_taixu", "bgm_activity_4_8_story_taixu")

				if var_4_47 ~= "" then
					if arg_1_1.bgmTxt_.text ~= var_4_47 and arg_1_1.bgmTxt_.text ~= "" then
						if arg_1_1.bgmTxt2_.text ~= "" then
							arg_1_1.bgmTxt_.text = arg_1_1.bgmTxt2_.text
						end

						arg_1_1.bgmTxt2_.text = var_4_47

						arg_1_1.musicChangeAnimator_:Play("music_change", 0, 0)
					else
						arg_1_1.bgmTxt_.text = var_4_47
						arg_1_1.bgmTxt2_.text = var_4_47
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

			local var_4_48 = 2.66666666666667
			local var_4_49 = 0.175

			if var_4_48 < arg_1_1.time_ and arg_1_1.time_ <= var_4_48 + arg_4_0 then
				arg_1_1.talkMaxDuration = 0

				arg_1_1.dialog_:SetActive(true)

				arg_1_1.dialogCg_.alpha = 0

				local var_4_50 = LeanTween.value(arg_1_1.dialog_, 0, 1, 0.3)

				var_4_50:setOnUpdate(LuaHelper.FloatAction(function(arg_6_0)
					arg_1_1.dialogCg_.alpha = arg_6_0
				end))
				var_4_50:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_1_1.dialog_)
					var_4_50:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_1_1.duration_ = arg_1_1.duration_ + 0.3

				SetActive(arg_1_1.leftNameGo_, true)

				local var_4_51 = arg_1_1:FormatText(StoryNameCfg[7].name)

				arg_1_1.leftNameTxt_.text = var_4_51

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_1_1.leftNameTxt_.transform)

				arg_1_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_1_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_1_1:RecordName(arg_1_1.leftNameTxt_.text)
				SetActive(arg_1_1.iconTrs_.gameObject, false)
				arg_1_1.callingController_:SetSelectedState("normal")

				local var_4_52 = arg_1_1:GetWordFromCfg(324541001)
				local var_4_53 = arg_1_1:FormatText(var_4_52.content)

				arg_1_1.text_.text = var_4_53

				LuaForUtil.ClearLinePrefixSymbol(arg_1_1.text_)

				local var_4_54 = 7
				local var_4_55 = utf8.len(var_4_53)
				local var_4_56 = var_4_54 <= 0 and var_4_49 or var_4_49 * (var_4_55 / var_4_54)

				if var_4_56 > 0 and var_4_49 < var_4_56 then
					arg_1_1.talkMaxDuration = var_4_56
					var_4_48 = var_4_48 + 0.3

					if var_4_56 + var_4_48 > arg_1_1.duration_ then
						arg_1_1.duration_ = var_4_56 + var_4_48
					end
				end

				arg_1_1.text_.text = var_4_53
				arg_1_1.typewritter.percent = 0

				arg_1_1.typewritter:SetDirty()
				arg_1_1:ShowNextGo(false)
				arg_1_1:RecordContent(arg_1_1.text_.text)
			end

			local var_4_57 = var_4_48 + 0.3
			local var_4_58 = math.max(var_4_49, arg_1_1.talkMaxDuration)

			if var_4_57 <= arg_1_1.time_ and arg_1_1.time_ < var_4_57 + var_4_58 then
				arg_1_1.typewritter.percent = (arg_1_1.time_ - var_4_57) / var_4_58

				arg_1_1.typewritter:SetDirty()
			end

			if arg_1_1.time_ >= var_4_57 + var_4_58 and arg_1_1.time_ < var_4_57 + var_4_58 + arg_4_0 then
				arg_1_1.typewritter.percent = 1

				arg_1_1.typewritter:SetDirty()
				arg_1_1:ShowNextGo(true)
			end
		end

		arg_1_1.nodeConfigList_ = {
			{
				assetPath = "",
				needEase = true,
				actorName = "MS2406",
				className = "StoryMoveNode",
				changeDisplayLayer = false,
				duration = 2,
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Background,
				easeData = {
					needAlphaEase = false,
					startAlpha = 0,
					endAlpha = 1,
					moveType = StoryPlayerConst.EASE_MOVE_TYPE.MOVE_IN,
					startPos = Vector3.New(1, 0, 5),
					endPos = Vector3.New(0, 0, 5.5),
					easeType = LeanTweenType.easeInOutQuint
				}
			},
			{
				assetPath = "",
				needEase = true,
				actorName = "MS2406",
				className = "StoryMoveNode",
				changeDisplayLayer = false,
				duration = 1.1,
				startTime = 1.8,
				actorType = StoryPlayerConst.ACTOR_TYPE.Background,
				easeData = {
					needAlphaEase = false,
					startAlpha = 0,
					endAlpha = 1,
					moveType = StoryPlayerConst.EASE_MOVE_TYPE.MOVE_IN,
					startPos = Vector3.New(0, 0, 5.5),
					endPos = Vector3.New(0, 1, 10),
					easeType = LeanTweenType.easeInOutExpo
				}
			}
		}

		arg_1_1:InitPlayNodeList()
	end,
	Play324541002 = function(arg_8_0, arg_8_1)
		arg_8_1.time_ = 0
		arg_8_1.frameCnt_ = 0
		arg_8_1.state_ = "playing"
		arg_8_1.curTalkId_ = 324541002
		arg_8_1.duration_ = 2.53

		SetActive(arg_8_1.tipsGo_, false)

		function arg_8_1.onSingleLineFinish_()
			arg_8_1.onSingleLineUpdate_ = nil
			arg_8_1.onSingleLineFinish_ = nil
			arg_8_1.state_ = "waiting"
		end

		function arg_8_1.playNext_(arg_10_0)
			if arg_10_0 == 1 then
				arg_8_0:Play324541003(arg_8_1)
			end
		end

		function arg_8_1.onSingleLineUpdate_(arg_11_0)
			local var_11_0 = "1012ui_story"

			if arg_8_1.actors_[var_11_0] == nil then
				local var_11_1 = Asset.Load("Char/" .. "1012ui_story")

				if not isNil(var_11_1) then
					local var_11_2 = Object.Instantiate(Asset.Load("Char/" .. "1012ui_story"), arg_8_1.stage_.transform)

					var_11_2.name = var_11_0
					var_11_2.transform.localPosition = Vector3.New(0, 100, 0)
					arg_8_1.actors_[var_11_0] = var_11_2

					local var_11_3 = var_11_2:GetComponentInChildren(typeof(CharacterEffect))

					var_11_3.enabled = true

					local var_11_4 = GameObjectTools.GetOrAddComponent(var_11_2, typeof(DynamicBoneHelper))

					if var_11_4 then
						var_11_4:EnableDynamicBone(false)
					end

					arg_8_1:ShowWeapon(var_11_3.transform, false)

					arg_8_1.var_[var_11_0 .. "Animator"] = var_11_3.gameObject:GetComponent(typeof(UnityEngine.Animator))
					arg_8_1.var_[var_11_0 .. "Animator"].applyRootMotion = true
					arg_8_1.var_[var_11_0 .. "LipSync"] = var_11_3.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
				end
			end

			local var_11_5 = arg_8_1.actors_["1012ui_story"]
			local var_11_6 = 0

			if var_11_6 < arg_8_1.time_ and arg_8_1.time_ <= var_11_6 + arg_11_0 and not isNil(var_11_5) and arg_8_1.var_.characterEffect1012ui_story == nil then
				arg_8_1.var_.characterEffect1012ui_story = var_11_5:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_11_7 = 0.200000002980232

			if var_11_6 <= arg_8_1.time_ and arg_8_1.time_ < var_11_6 + var_11_7 and not isNil(var_11_5) then
				local var_11_8 = (arg_8_1.time_ - var_11_6) / var_11_7

				if arg_8_1.var_.characterEffect1012ui_story and not isNil(var_11_5) then
					arg_8_1.var_.characterEffect1012ui_story.fillFlat = false
				end
			end

			if arg_8_1.time_ >= var_11_6 + var_11_7 and arg_8_1.time_ < var_11_6 + var_11_7 + arg_11_0 and not isNil(var_11_5) and arg_8_1.var_.characterEffect1012ui_story then
				arg_8_1.var_.characterEffect1012ui_story.fillFlat = false
			end

			local var_11_9 = 0
			local var_11_10 = 0.225

			if var_11_9 < arg_8_1.time_ and arg_8_1.time_ <= var_11_9 + arg_11_0 then
				arg_8_1.talkMaxDuration = 0
				arg_8_1.dialogCg_.alpha = 1

				arg_8_1.dialog_:SetActive(true)
				SetActive(arg_8_1.leftNameGo_, true)

				local var_11_11 = arg_8_1:FormatText(StoryNameCfg[1450].name)

				arg_8_1.leftNameTxt_.text = var_11_11

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_8_1.leftNameTxt_.transform)

				arg_8_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_8_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_8_1:RecordName(arg_8_1.leftNameTxt_.text)
				SetActive(arg_8_1.iconTrs_.gameObject, false)
				arg_8_1.callingController_:SetSelectedState("normal")

				local var_11_12 = arg_8_1:GetWordFromCfg(324541002)
				local var_11_13 = arg_8_1:FormatText(var_11_12.content)

				arg_8_1.text_.text = var_11_13

				LuaForUtil.ClearLinePrefixSymbol(arg_8_1.text_)

				local var_11_14 = 9
				local var_11_15 = utf8.len(var_11_13)
				local var_11_16 = var_11_14 <= 0 and var_11_10 or var_11_10 * (var_11_15 / var_11_14)

				if var_11_16 > 0 and var_11_10 < var_11_16 then
					arg_8_1.talkMaxDuration = var_11_16

					if var_11_16 + var_11_9 > arg_8_1.duration_ then
						arg_8_1.duration_ = var_11_16 + var_11_9
					end
				end

				arg_8_1.text_.text = var_11_13
				arg_8_1.typewritter.percent = 0

				arg_8_1.typewritter:SetDirty()
				arg_8_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_324541", "324541002", "story_v_out_324541.awb") ~= 0 then
					local var_11_17 = manager.audio:GetVoiceLength("story_v_out_324541", "324541002", "story_v_out_324541.awb") / 1000

					if var_11_17 + var_11_9 > arg_8_1.duration_ then
						arg_8_1.duration_ = var_11_17 + var_11_9
					end

					if var_11_12.prefab_name ~= "" and arg_8_1.actors_[var_11_12.prefab_name] ~= nil then
						local var_11_18 = LuaForUtil.PlayVoiceWithCriLipsync(arg_8_1.actors_[var_11_12.prefab_name].transform, "story_v_out_324541", "324541002", "story_v_out_324541.awb")

						arg_8_1:RecordAudio("324541002", var_11_18)
						arg_8_1:RecordAudio("324541002", var_11_18)
					else
						arg_8_1:AudioAction("play", "voice", "story_v_out_324541", "324541002", "story_v_out_324541.awb")
					end

					arg_8_1:RecordHistoryTalkVoice("story_v_out_324541", "324541002", "story_v_out_324541.awb")
				end

				arg_8_1:RecordContent(arg_8_1.text_.text)
			end

			local var_11_19 = math.max(var_11_10, arg_8_1.talkMaxDuration)

			if var_11_9 <= arg_8_1.time_ and arg_8_1.time_ < var_11_9 + var_11_19 then
				arg_8_1.typewritter.percent = (arg_8_1.time_ - var_11_9) / var_11_19

				arg_8_1.typewritter:SetDirty()
			end

			if arg_8_1.time_ >= var_11_9 + var_11_19 and arg_8_1.time_ < var_11_9 + var_11_19 + arg_11_0 then
				arg_8_1.typewritter.percent = 1

				arg_8_1.typewritter:SetDirty()
				arg_8_1:ShowNextGo(true)
			end
		end

		arg_8_1.nodeConfigList_ = {}

		arg_8_1:InitPlayNodeList()
	end,
	Play324541003 = function(arg_12_0, arg_12_1)
		arg_12_1.time_ = 0
		arg_12_1.frameCnt_ = 0
		arg_12_1.state_ = "playing"
		arg_12_1.curTalkId_ = 324541003
		arg_12_1.duration_ = 5

		SetActive(arg_12_1.tipsGo_, false)

		function arg_12_1.onSingleLineFinish_()
			arg_12_1.onSingleLineUpdate_ = nil
			arg_12_1.onSingleLineFinish_ = nil
			arg_12_1.state_ = "waiting"
		end

		function arg_12_1.playNext_(arg_14_0)
			if arg_14_0 == 1 then
				arg_12_0:Play324541004(arg_12_1)
			end
		end

		function arg_12_1.onSingleLineUpdate_(arg_15_0)
			local var_15_0 = arg_12_1.actors_["1012ui_story"]
			local var_15_1 = 0

			if var_15_1 < arg_12_1.time_ and arg_12_1.time_ <= var_15_1 + arg_15_0 and not isNil(var_15_0) and arg_12_1.var_.characterEffect1012ui_story == nil then
				arg_12_1.var_.characterEffect1012ui_story = var_15_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_15_2 = 0.200000002980232

			if var_15_1 <= arg_12_1.time_ and arg_12_1.time_ < var_15_1 + var_15_2 and not isNil(var_15_0) then
				local var_15_3 = (arg_12_1.time_ - var_15_1) / var_15_2

				if arg_12_1.var_.characterEffect1012ui_story and not isNil(var_15_0) then
					local var_15_4 = Mathf.Lerp(0, 0.5, var_15_3)

					arg_12_1.var_.characterEffect1012ui_story.fillFlat = true
					arg_12_1.var_.characterEffect1012ui_story.fillRatio = var_15_4
				end
			end

			if arg_12_1.time_ >= var_15_1 + var_15_2 and arg_12_1.time_ < var_15_1 + var_15_2 + arg_15_0 and not isNil(var_15_0) and arg_12_1.var_.characterEffect1012ui_story then
				local var_15_5 = 0.5

				arg_12_1.var_.characterEffect1012ui_story.fillFlat = true
				arg_12_1.var_.characterEffect1012ui_story.fillRatio = var_15_5
			end

			local var_15_6 = 0
			local var_15_7 = 0.25

			if var_15_6 < arg_12_1.time_ and arg_12_1.time_ <= var_15_6 + arg_15_0 then
				arg_12_1.talkMaxDuration = 0
				arg_12_1.dialogCg_.alpha = 1

				arg_12_1.dialog_:SetActive(true)
				SetActive(arg_12_1.leftNameGo_, true)

				local var_15_8 = arg_12_1:FormatText(StoryNameCfg[7].name)

				arg_12_1.leftNameTxt_.text = var_15_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_12_1.leftNameTxt_.transform)

				arg_12_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_12_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_12_1:RecordName(arg_12_1.leftNameTxt_.text)
				SetActive(arg_12_1.iconTrs_.gameObject, false)
				arg_12_1.callingController_:SetSelectedState("normal")

				local var_15_9 = arg_12_1:GetWordFromCfg(324541003)
				local var_15_10 = arg_12_1:FormatText(var_15_9.content)

				arg_12_1.text_.text = var_15_10

				LuaForUtil.ClearLinePrefixSymbol(arg_12_1.text_)

				local var_15_11 = 10
				local var_15_12 = utf8.len(var_15_10)
				local var_15_13 = var_15_11 <= 0 and var_15_7 or var_15_7 * (var_15_12 / var_15_11)

				if var_15_13 > 0 and var_15_7 < var_15_13 then
					arg_12_1.talkMaxDuration = var_15_13

					if var_15_13 + var_15_6 > arg_12_1.duration_ then
						arg_12_1.duration_ = var_15_13 + var_15_6
					end
				end

				arg_12_1.text_.text = var_15_10
				arg_12_1.typewritter.percent = 0

				arg_12_1.typewritter:SetDirty()
				arg_12_1:ShowNextGo(false)
				arg_12_1:RecordContent(arg_12_1.text_.text)
			end

			local var_15_14 = math.max(var_15_7, arg_12_1.talkMaxDuration)

			if var_15_6 <= arg_12_1.time_ and arg_12_1.time_ < var_15_6 + var_15_14 then
				arg_12_1.typewritter.percent = (arg_12_1.time_ - var_15_6) / var_15_14

				arg_12_1.typewritter:SetDirty()
			end

			if arg_12_1.time_ >= var_15_6 + var_15_14 and arg_12_1.time_ < var_15_6 + var_15_14 + arg_15_0 then
				arg_12_1.typewritter.percent = 1

				arg_12_1.typewritter:SetDirty()
				arg_12_1:ShowNextGo(true)
			end
		end

		arg_12_1.nodeConfigList_ = {}

		arg_12_1:InitPlayNodeList()
	end,
	Play324541004 = function(arg_16_0, arg_16_1)
		arg_16_1.time_ = 0
		arg_16_1.frameCnt_ = 0
		arg_16_1.state_ = "playing"
		arg_16_1.curTalkId_ = 324541004
		arg_16_1.duration_ = 5

		SetActive(arg_16_1.tipsGo_, false)

		function arg_16_1.onSingleLineFinish_()
			arg_16_1.onSingleLineUpdate_ = nil
			arg_16_1.onSingleLineFinish_ = nil
			arg_16_1.state_ = "waiting"
		end

		function arg_16_1.playNext_(arg_18_0)
			if arg_18_0 == 1 then
				arg_16_0:Play324541005(arg_16_1)
			end
		end

		function arg_16_1.onSingleLineUpdate_(arg_19_0)
			local var_19_0 = 0
			local var_19_1 = 0.7

			if var_19_0 < arg_16_1.time_ and arg_16_1.time_ <= var_19_0 + arg_19_0 then
				arg_16_1.talkMaxDuration = 0
				arg_16_1.dialogCg_.alpha = 1

				arg_16_1.dialog_:SetActive(true)
				SetActive(arg_16_1.leftNameGo_, false)

				arg_16_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_16_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_16_1:RecordName(arg_16_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_16_1.iconTrs_.gameObject, false)
				arg_16_1.callingController_:SetSelectedState("normal")

				local var_19_2 = arg_16_1:GetWordFromCfg(324541004)
				local var_19_3 = arg_16_1:FormatText(var_19_2.content)

				arg_16_1.text_.text = var_19_3

				LuaForUtil.ClearLinePrefixSymbol(arg_16_1.text_)

				local var_19_4 = 28
				local var_19_5 = utf8.len(var_19_3)
				local var_19_6 = var_19_4 <= 0 and var_19_1 or var_19_1 * (var_19_5 / var_19_4)

				if var_19_6 > 0 and var_19_1 < var_19_6 then
					arg_16_1.talkMaxDuration = var_19_6

					if var_19_6 + var_19_0 > arg_16_1.duration_ then
						arg_16_1.duration_ = var_19_6 + var_19_0
					end
				end

				arg_16_1.text_.text = var_19_3
				arg_16_1.typewritter.percent = 0

				arg_16_1.typewritter:SetDirty()
				arg_16_1:ShowNextGo(false)
				arg_16_1:RecordContent(arg_16_1.text_.text)
			end

			local var_19_7 = math.max(var_19_1, arg_16_1.talkMaxDuration)

			if var_19_0 <= arg_16_1.time_ and arg_16_1.time_ < var_19_0 + var_19_7 then
				arg_16_1.typewritter.percent = (arg_16_1.time_ - var_19_0) / var_19_7

				arg_16_1.typewritter:SetDirty()
			end

			if arg_16_1.time_ >= var_19_0 + var_19_7 and arg_16_1.time_ < var_19_0 + var_19_7 + arg_19_0 then
				arg_16_1.typewritter.percent = 1

				arg_16_1.typewritter:SetDirty()
				arg_16_1:ShowNextGo(true)
			end
		end

		arg_16_1.nodeConfigList_ = {}

		arg_16_1:InitPlayNodeList()
	end,
	Play324541005 = function(arg_20_0, arg_20_1)
		arg_20_1.time_ = 0
		arg_20_1.frameCnt_ = 0
		arg_20_1.state_ = "playing"
		arg_20_1.curTalkId_ = 324541005
		arg_20_1.duration_ = 5

		SetActive(arg_20_1.tipsGo_, false)

		function arg_20_1.onSingleLineFinish_()
			arg_20_1.onSingleLineUpdate_ = nil
			arg_20_1.onSingleLineFinish_ = nil
			arg_20_1.state_ = "waiting"
		end

		function arg_20_1.playNext_(arg_22_0)
			if arg_22_0 == 1 then
				arg_20_0:Play324541006(arg_20_1)
			end
		end

		function arg_20_1.onSingleLineUpdate_(arg_23_0)
			local var_23_0 = 0
			local var_23_1 = 0.75

			if var_23_0 < arg_20_1.time_ and arg_20_1.time_ <= var_23_0 + arg_23_0 then
				arg_20_1.talkMaxDuration = 0
				arg_20_1.dialogCg_.alpha = 1

				arg_20_1.dialog_:SetActive(true)
				SetActive(arg_20_1.leftNameGo_, true)

				local var_23_2 = arg_20_1:FormatText(StoryNameCfg[7].name)

				arg_20_1.leftNameTxt_.text = var_23_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_20_1.leftNameTxt_.transform)

				arg_20_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_20_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_20_1:RecordName(arg_20_1.leftNameTxt_.text)
				SetActive(arg_20_1.iconTrs_.gameObject, false)
				arg_20_1.callingController_:SetSelectedState("normal")

				local var_23_3 = arg_20_1:GetWordFromCfg(324541005)
				local var_23_4 = arg_20_1:FormatText(var_23_3.content)

				arg_20_1.text_.text = var_23_4

				LuaForUtil.ClearLinePrefixSymbol(arg_20_1.text_)

				local var_23_5 = 30
				local var_23_6 = utf8.len(var_23_4)
				local var_23_7 = var_23_5 <= 0 and var_23_1 or var_23_1 * (var_23_6 / var_23_5)

				if var_23_7 > 0 and var_23_1 < var_23_7 then
					arg_20_1.talkMaxDuration = var_23_7

					if var_23_7 + var_23_0 > arg_20_1.duration_ then
						arg_20_1.duration_ = var_23_7 + var_23_0
					end
				end

				arg_20_1.text_.text = var_23_4
				arg_20_1.typewritter.percent = 0

				arg_20_1.typewritter:SetDirty()
				arg_20_1:ShowNextGo(false)
				arg_20_1:RecordContent(arg_20_1.text_.text)
			end

			local var_23_8 = math.max(var_23_1, arg_20_1.talkMaxDuration)

			if var_23_0 <= arg_20_1.time_ and arg_20_1.time_ < var_23_0 + var_23_8 then
				arg_20_1.typewritter.percent = (arg_20_1.time_ - var_23_0) / var_23_8

				arg_20_1.typewritter:SetDirty()
			end

			if arg_20_1.time_ >= var_23_0 + var_23_8 and arg_20_1.time_ < var_23_0 + var_23_8 + arg_23_0 then
				arg_20_1.typewritter.percent = 1

				arg_20_1.typewritter:SetDirty()
				arg_20_1:ShowNextGo(true)
			end
		end

		arg_20_1.nodeConfigList_ = {}

		arg_20_1:InitPlayNodeList()
	end,
	Play324541006 = function(arg_24_0, arg_24_1)
		arg_24_1.time_ = 0
		arg_24_1.frameCnt_ = 0
		arg_24_1.state_ = "playing"
		arg_24_1.curTalkId_ = 324541006
		arg_24_1.duration_ = 5

		SetActive(arg_24_1.tipsGo_, false)

		function arg_24_1.onSingleLineFinish_()
			arg_24_1.onSingleLineUpdate_ = nil
			arg_24_1.onSingleLineFinish_ = nil
			arg_24_1.state_ = "waiting"
		end

		function arg_24_1.playNext_(arg_26_0)
			if arg_26_0 == 1 then
				arg_24_0:Play324541007(arg_24_1)
			end
		end

		function arg_24_1.onSingleLineUpdate_(arg_27_0)
			local var_27_0 = 0
			local var_27_1 = 0.4

			if var_27_0 < arg_24_1.time_ and arg_24_1.time_ <= var_27_0 + arg_27_0 then
				arg_24_1.talkMaxDuration = 0
				arg_24_1.dialogCg_.alpha = 1

				arg_24_1.dialog_:SetActive(true)
				SetActive(arg_24_1.leftNameGo_, true)

				local var_27_2 = arg_24_1:FormatText(StoryNameCfg[7].name)

				arg_24_1.leftNameTxt_.text = var_27_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_24_1.leftNameTxt_.transform)

				arg_24_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_24_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_24_1:RecordName(arg_24_1.leftNameTxt_.text)
				SetActive(arg_24_1.iconTrs_.gameObject, false)
				arg_24_1.callingController_:SetSelectedState("normal")

				local var_27_3 = arg_24_1:GetWordFromCfg(324541006)
				local var_27_4 = arg_24_1:FormatText(var_27_3.content)

				arg_24_1.text_.text = var_27_4

				LuaForUtil.ClearLinePrefixSymbol(arg_24_1.text_)

				local var_27_5 = 16
				local var_27_6 = utf8.len(var_27_4)
				local var_27_7 = var_27_5 <= 0 and var_27_1 or var_27_1 * (var_27_6 / var_27_5)

				if var_27_7 > 0 and var_27_1 < var_27_7 then
					arg_24_1.talkMaxDuration = var_27_7

					if var_27_7 + var_27_0 > arg_24_1.duration_ then
						arg_24_1.duration_ = var_27_7 + var_27_0
					end
				end

				arg_24_1.text_.text = var_27_4
				arg_24_1.typewritter.percent = 0

				arg_24_1.typewritter:SetDirty()
				arg_24_1:ShowNextGo(false)
				arg_24_1:RecordContent(arg_24_1.text_.text)
			end

			local var_27_8 = math.max(var_27_1, arg_24_1.talkMaxDuration)

			if var_27_0 <= arg_24_1.time_ and arg_24_1.time_ < var_27_0 + var_27_8 then
				arg_24_1.typewritter.percent = (arg_24_1.time_ - var_27_0) / var_27_8

				arg_24_1.typewritter:SetDirty()
			end

			if arg_24_1.time_ >= var_27_0 + var_27_8 and arg_24_1.time_ < var_27_0 + var_27_8 + arg_27_0 then
				arg_24_1.typewritter.percent = 1

				arg_24_1.typewritter:SetDirty()
				arg_24_1:ShowNextGo(true)
			end
		end

		arg_24_1.nodeConfigList_ = {}

		arg_24_1:InitPlayNodeList()
	end,
	Play324541007 = function(arg_28_0, arg_28_1)
		arg_28_1.time_ = 0
		arg_28_1.frameCnt_ = 0
		arg_28_1.state_ = "playing"
		arg_28_1.curTalkId_ = 324541007
		arg_28_1.duration_ = 4.27

		SetActive(arg_28_1.tipsGo_, false)

		function arg_28_1.onSingleLineFinish_()
			arg_28_1.onSingleLineUpdate_ = nil
			arg_28_1.onSingleLineFinish_ = nil
			arg_28_1.state_ = "waiting"
		end

		function arg_28_1.playNext_(arg_30_0)
			if arg_30_0 == 1 then
				arg_28_0:Play324541008(arg_28_1)
			end
		end

		function arg_28_1.onSingleLineUpdate_(arg_31_0)
			local var_31_0 = arg_28_1.actors_["1012ui_story"]
			local var_31_1 = 0

			if var_31_1 < arg_28_1.time_ and arg_28_1.time_ <= var_31_1 + arg_31_0 and not isNil(var_31_0) and arg_28_1.var_.characterEffect1012ui_story == nil then
				arg_28_1.var_.characterEffect1012ui_story = var_31_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_31_2 = 0.200000002980232

			if var_31_1 <= arg_28_1.time_ and arg_28_1.time_ < var_31_1 + var_31_2 and not isNil(var_31_0) then
				local var_31_3 = (arg_28_1.time_ - var_31_1) / var_31_2

				if arg_28_1.var_.characterEffect1012ui_story and not isNil(var_31_0) then
					arg_28_1.var_.characterEffect1012ui_story.fillFlat = false
				end
			end

			if arg_28_1.time_ >= var_31_1 + var_31_2 and arg_28_1.time_ < var_31_1 + var_31_2 + arg_31_0 and not isNil(var_31_0) and arg_28_1.var_.characterEffect1012ui_story then
				arg_28_1.var_.characterEffect1012ui_story.fillFlat = false
			end

			local var_31_4 = 0
			local var_31_5 = 0.475

			if var_31_4 < arg_28_1.time_ and arg_28_1.time_ <= var_31_4 + arg_31_0 then
				arg_28_1.talkMaxDuration = 0
				arg_28_1.dialogCg_.alpha = 1

				arg_28_1.dialog_:SetActive(true)
				SetActive(arg_28_1.leftNameGo_, true)

				local var_31_6 = arg_28_1:FormatText(StoryNameCfg[1450].name)

				arg_28_1.leftNameTxt_.text = var_31_6

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_28_1.leftNameTxt_.transform)

				arg_28_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_28_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_28_1:RecordName(arg_28_1.leftNameTxt_.text)
				SetActive(arg_28_1.iconTrs_.gameObject, false)
				arg_28_1.callingController_:SetSelectedState("normal")

				local var_31_7 = arg_28_1:GetWordFromCfg(324541007)
				local var_31_8 = arg_28_1:FormatText(var_31_7.content)

				arg_28_1.text_.text = var_31_8

				LuaForUtil.ClearLinePrefixSymbol(arg_28_1.text_)

				local var_31_9 = 19
				local var_31_10 = utf8.len(var_31_8)
				local var_31_11 = var_31_9 <= 0 and var_31_5 or var_31_5 * (var_31_10 / var_31_9)

				if var_31_11 > 0 and var_31_5 < var_31_11 then
					arg_28_1.talkMaxDuration = var_31_11

					if var_31_11 + var_31_4 > arg_28_1.duration_ then
						arg_28_1.duration_ = var_31_11 + var_31_4
					end
				end

				arg_28_1.text_.text = var_31_8
				arg_28_1.typewritter.percent = 0

				arg_28_1.typewritter:SetDirty()
				arg_28_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_324541", "324541007", "story_v_out_324541.awb") ~= 0 then
					local var_31_12 = manager.audio:GetVoiceLength("story_v_out_324541", "324541007", "story_v_out_324541.awb") / 1000

					if var_31_12 + var_31_4 > arg_28_1.duration_ then
						arg_28_1.duration_ = var_31_12 + var_31_4
					end

					if var_31_7.prefab_name ~= "" and arg_28_1.actors_[var_31_7.prefab_name] ~= nil then
						local var_31_13 = LuaForUtil.PlayVoiceWithCriLipsync(arg_28_1.actors_[var_31_7.prefab_name].transform, "story_v_out_324541", "324541007", "story_v_out_324541.awb")

						arg_28_1:RecordAudio("324541007", var_31_13)
						arg_28_1:RecordAudio("324541007", var_31_13)
					else
						arg_28_1:AudioAction("play", "voice", "story_v_out_324541", "324541007", "story_v_out_324541.awb")
					end

					arg_28_1:RecordHistoryTalkVoice("story_v_out_324541", "324541007", "story_v_out_324541.awb")
				end

				arg_28_1:RecordContent(arg_28_1.text_.text)
			end

			local var_31_14 = math.max(var_31_5, arg_28_1.talkMaxDuration)

			if var_31_4 <= arg_28_1.time_ and arg_28_1.time_ < var_31_4 + var_31_14 then
				arg_28_1.typewritter.percent = (arg_28_1.time_ - var_31_4) / var_31_14

				arg_28_1.typewritter:SetDirty()
			end

			if arg_28_1.time_ >= var_31_4 + var_31_14 and arg_28_1.time_ < var_31_4 + var_31_14 + arg_31_0 then
				arg_28_1.typewritter.percent = 1

				arg_28_1.typewritter:SetDirty()
				arg_28_1:ShowNextGo(true)
			end
		end

		arg_28_1.nodeConfigList_ = {}

		arg_28_1:InitPlayNodeList()
	end,
	Play324541008 = function(arg_32_0, arg_32_1)
		arg_32_1.time_ = 0
		arg_32_1.frameCnt_ = 0
		arg_32_1.state_ = "playing"
		arg_32_1.curTalkId_ = 324541008
		arg_32_1.duration_ = 5

		SetActive(arg_32_1.tipsGo_, false)

		function arg_32_1.onSingleLineFinish_()
			arg_32_1.onSingleLineUpdate_ = nil
			arg_32_1.onSingleLineFinish_ = nil
			arg_32_1.state_ = "waiting"
		end

		function arg_32_1.playNext_(arg_34_0)
			if arg_34_0 == 1 then
				arg_32_0:Play324541009(arg_32_1)
			end
		end

		function arg_32_1.onSingleLineUpdate_(arg_35_0)
			local var_35_0 = arg_32_1.actors_["1012ui_story"]
			local var_35_1 = 0

			if var_35_1 < arg_32_1.time_ and arg_32_1.time_ <= var_35_1 + arg_35_0 and not isNil(var_35_0) and arg_32_1.var_.characterEffect1012ui_story == nil then
				arg_32_1.var_.characterEffect1012ui_story = var_35_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_35_2 = 0.200000002980232

			if var_35_1 <= arg_32_1.time_ and arg_32_1.time_ < var_35_1 + var_35_2 and not isNil(var_35_0) then
				local var_35_3 = (arg_32_1.time_ - var_35_1) / var_35_2

				if arg_32_1.var_.characterEffect1012ui_story and not isNil(var_35_0) then
					local var_35_4 = Mathf.Lerp(0, 0.5, var_35_3)

					arg_32_1.var_.characterEffect1012ui_story.fillFlat = true
					arg_32_1.var_.characterEffect1012ui_story.fillRatio = var_35_4
				end
			end

			if arg_32_1.time_ >= var_35_1 + var_35_2 and arg_32_1.time_ < var_35_1 + var_35_2 + arg_35_0 and not isNil(var_35_0) and arg_32_1.var_.characterEffect1012ui_story then
				local var_35_5 = 0.5

				arg_32_1.var_.characterEffect1012ui_story.fillFlat = true
				arg_32_1.var_.characterEffect1012ui_story.fillRatio = var_35_5
			end

			local var_35_6 = 0
			local var_35_7 = 0.7

			if var_35_6 < arg_32_1.time_ and arg_32_1.time_ <= var_35_6 + arg_35_0 then
				arg_32_1.talkMaxDuration = 0
				arg_32_1.dialogCg_.alpha = 1

				arg_32_1.dialog_:SetActive(true)
				SetActive(arg_32_1.leftNameGo_, true)

				local var_35_8 = arg_32_1:FormatText(StoryNameCfg[7].name)

				arg_32_1.leftNameTxt_.text = var_35_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_32_1.leftNameTxt_.transform)

				arg_32_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_32_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_32_1:RecordName(arg_32_1.leftNameTxt_.text)
				SetActive(arg_32_1.iconTrs_.gameObject, false)
				arg_32_1.callingController_:SetSelectedState("normal")

				local var_35_9 = arg_32_1:GetWordFromCfg(324541008)
				local var_35_10 = arg_32_1:FormatText(var_35_9.content)

				arg_32_1.text_.text = var_35_10

				LuaForUtil.ClearLinePrefixSymbol(arg_32_1.text_)

				local var_35_11 = 28
				local var_35_12 = utf8.len(var_35_10)
				local var_35_13 = var_35_11 <= 0 and var_35_7 or var_35_7 * (var_35_12 / var_35_11)

				if var_35_13 > 0 and var_35_7 < var_35_13 then
					arg_32_1.talkMaxDuration = var_35_13

					if var_35_13 + var_35_6 > arg_32_1.duration_ then
						arg_32_1.duration_ = var_35_13 + var_35_6
					end
				end

				arg_32_1.text_.text = var_35_10
				arg_32_1.typewritter.percent = 0

				arg_32_1.typewritter:SetDirty()
				arg_32_1:ShowNextGo(false)
				arg_32_1:RecordContent(arg_32_1.text_.text)
			end

			local var_35_14 = math.max(var_35_7, arg_32_1.talkMaxDuration)

			if var_35_6 <= arg_32_1.time_ and arg_32_1.time_ < var_35_6 + var_35_14 then
				arg_32_1.typewritter.percent = (arg_32_1.time_ - var_35_6) / var_35_14

				arg_32_1.typewritter:SetDirty()
			end

			if arg_32_1.time_ >= var_35_6 + var_35_14 and arg_32_1.time_ < var_35_6 + var_35_14 + arg_35_0 then
				arg_32_1.typewritter.percent = 1

				arg_32_1.typewritter:SetDirty()
				arg_32_1:ShowNextGo(true)
			end
		end

		arg_32_1.nodeConfigList_ = {}

		arg_32_1:InitPlayNodeList()
	end,
	Play324541009 = function(arg_36_0, arg_36_1)
		arg_36_1.time_ = 0
		arg_36_1.frameCnt_ = 0
		arg_36_1.state_ = "playing"
		arg_36_1.curTalkId_ = 324541009
		arg_36_1.duration_ = 1.53

		SetActive(arg_36_1.tipsGo_, false)

		function arg_36_1.onSingleLineFinish_()
			arg_36_1.onSingleLineUpdate_ = nil
			arg_36_1.onSingleLineFinish_ = nil
			arg_36_1.state_ = "waiting"
		end

		function arg_36_1.playNext_(arg_38_0)
			if arg_38_0 == 1 then
				arg_36_0:Play324541010(arg_36_1)
			end
		end

		function arg_36_1.onSingleLineUpdate_(arg_39_0)
			local var_39_0 = arg_36_1.actors_["1012ui_story"]
			local var_39_1 = 0

			if var_39_1 < arg_36_1.time_ and arg_36_1.time_ <= var_39_1 + arg_39_0 and not isNil(var_39_0) and arg_36_1.var_.characterEffect1012ui_story == nil then
				arg_36_1.var_.characterEffect1012ui_story = var_39_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_39_2 = 0.200000002980232

			if var_39_1 <= arg_36_1.time_ and arg_36_1.time_ < var_39_1 + var_39_2 and not isNil(var_39_0) then
				local var_39_3 = (arg_36_1.time_ - var_39_1) / var_39_2

				if arg_36_1.var_.characterEffect1012ui_story and not isNil(var_39_0) then
					arg_36_1.var_.characterEffect1012ui_story.fillFlat = false
				end
			end

			if arg_36_1.time_ >= var_39_1 + var_39_2 and arg_36_1.time_ < var_39_1 + var_39_2 + arg_39_0 and not isNil(var_39_0) and arg_36_1.var_.characterEffect1012ui_story then
				arg_36_1.var_.characterEffect1012ui_story.fillFlat = false
			end

			local var_39_4 = 0
			local var_39_5 = 0.15

			if var_39_4 < arg_36_1.time_ and arg_36_1.time_ <= var_39_4 + arg_39_0 then
				arg_36_1.talkMaxDuration = 0
				arg_36_1.dialogCg_.alpha = 1

				arg_36_1.dialog_:SetActive(true)
				SetActive(arg_36_1.leftNameGo_, true)

				local var_39_6 = arg_36_1:FormatText(StoryNameCfg[1450].name)

				arg_36_1.leftNameTxt_.text = var_39_6

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_36_1.leftNameTxt_.transform)

				arg_36_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_36_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_36_1:RecordName(arg_36_1.leftNameTxt_.text)
				SetActive(arg_36_1.iconTrs_.gameObject, false)
				arg_36_1.callingController_:SetSelectedState("normal")

				local var_39_7 = arg_36_1:GetWordFromCfg(324541009)
				local var_39_8 = arg_36_1:FormatText(var_39_7.content)

				arg_36_1.text_.text = var_39_8

				LuaForUtil.ClearLinePrefixSymbol(arg_36_1.text_)

				local var_39_9 = 6
				local var_39_10 = utf8.len(var_39_8)
				local var_39_11 = var_39_9 <= 0 and var_39_5 or var_39_5 * (var_39_10 / var_39_9)

				if var_39_11 > 0 and var_39_5 < var_39_11 then
					arg_36_1.talkMaxDuration = var_39_11

					if var_39_11 + var_39_4 > arg_36_1.duration_ then
						arg_36_1.duration_ = var_39_11 + var_39_4
					end
				end

				arg_36_1.text_.text = var_39_8
				arg_36_1.typewritter.percent = 0

				arg_36_1.typewritter:SetDirty()
				arg_36_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_324541", "324541009", "story_v_out_324541.awb") ~= 0 then
					local var_39_12 = manager.audio:GetVoiceLength("story_v_out_324541", "324541009", "story_v_out_324541.awb") / 1000

					if var_39_12 + var_39_4 > arg_36_1.duration_ then
						arg_36_1.duration_ = var_39_12 + var_39_4
					end

					if var_39_7.prefab_name ~= "" and arg_36_1.actors_[var_39_7.prefab_name] ~= nil then
						local var_39_13 = LuaForUtil.PlayVoiceWithCriLipsync(arg_36_1.actors_[var_39_7.prefab_name].transform, "story_v_out_324541", "324541009", "story_v_out_324541.awb")

						arg_36_1:RecordAudio("324541009", var_39_13)
						arg_36_1:RecordAudio("324541009", var_39_13)
					else
						arg_36_1:AudioAction("play", "voice", "story_v_out_324541", "324541009", "story_v_out_324541.awb")
					end

					arg_36_1:RecordHistoryTalkVoice("story_v_out_324541", "324541009", "story_v_out_324541.awb")
				end

				arg_36_1:RecordContent(arg_36_1.text_.text)
			end

			local var_39_14 = math.max(var_39_5, arg_36_1.talkMaxDuration)

			if var_39_4 <= arg_36_1.time_ and arg_36_1.time_ < var_39_4 + var_39_14 then
				arg_36_1.typewritter.percent = (arg_36_1.time_ - var_39_4) / var_39_14

				arg_36_1.typewritter:SetDirty()
			end

			if arg_36_1.time_ >= var_39_4 + var_39_14 and arg_36_1.time_ < var_39_4 + var_39_14 + arg_39_0 then
				arg_36_1.typewritter.percent = 1

				arg_36_1.typewritter:SetDirty()
				arg_36_1:ShowNextGo(true)
			end
		end

		arg_36_1.nodeConfigList_ = {}

		arg_36_1:InitPlayNodeList()
	end,
	Play324541010 = function(arg_40_0, arg_40_1)
		arg_40_1.time_ = 0
		arg_40_1.frameCnt_ = 0
		arg_40_1.state_ = "playing"
		arg_40_1.curTalkId_ = 324541010
		arg_40_1.duration_ = 1

		SetActive(arg_40_1.tipsGo_, false)

		function arg_40_1.onSingleLineFinish_()
			arg_40_1.onSingleLineUpdate_ = nil
			arg_40_1.onSingleLineFinish_ = nil
			arg_40_1.state_ = "waiting"

			SetActive(arg_40_1.choicesGo_, true)

			for iter_41_0, iter_41_1 in ipairs(arg_40_1.choices_) do
				local var_41_0 = iter_41_0 <= 3

				SetActive(iter_41_1.go, var_41_0)
			end

			arg_40_1.choices_[1].txt.text = arg_40_1:FormatText(StoryChoiceCfg[1618].name)
			arg_40_1.choices_[2].txt.text = arg_40_1:FormatText(StoryChoiceCfg[1619].name)
			arg_40_1.choices_[3].txt.text = arg_40_1:FormatText(StoryChoiceCfg[1620].name)
		end

		function arg_40_1.playNext_(arg_42_0)
			if arg_42_0 == 1 then
				arg_40_0:Play324541011(arg_40_1)
			end

			if arg_42_0 == 2 then
				arg_40_0:Play324541011(arg_40_1)
			end

			if arg_42_0 == 3 then
				arg_40_0:Play324541011(arg_40_1)
			end

			arg_40_1:RecordChoiceLog(324541010, 1618, 1619, 1620)
		end

		function arg_40_1.onSingleLineUpdate_(arg_43_0)
			local var_43_0 = arg_40_1.actors_["1012ui_story"]
			local var_43_1 = 0

			if var_43_1 < arg_40_1.time_ and arg_40_1.time_ <= var_43_1 + arg_43_0 and not isNil(var_43_0) and arg_40_1.var_.characterEffect1012ui_story == nil then
				arg_40_1.var_.characterEffect1012ui_story = var_43_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_43_2 = 0.200000002980232

			if var_43_1 <= arg_40_1.time_ and arg_40_1.time_ < var_43_1 + var_43_2 and not isNil(var_43_0) then
				local var_43_3 = (arg_40_1.time_ - var_43_1) / var_43_2

				if arg_40_1.var_.characterEffect1012ui_story and not isNil(var_43_0) then
					local var_43_4 = Mathf.Lerp(0, 0.5, var_43_3)

					arg_40_1.var_.characterEffect1012ui_story.fillFlat = true
					arg_40_1.var_.characterEffect1012ui_story.fillRatio = var_43_4
				end
			end

			if arg_40_1.time_ >= var_43_1 + var_43_2 and arg_40_1.time_ < var_43_1 + var_43_2 + arg_43_0 and not isNil(var_43_0) and arg_40_1.var_.characterEffect1012ui_story then
				local var_43_5 = 0.5

				arg_40_1.var_.characterEffect1012ui_story.fillFlat = true
				arg_40_1.var_.characterEffect1012ui_story.fillRatio = var_43_5
			end

			local var_43_6 = 0

			if var_43_6 < arg_40_1.time_ and arg_40_1.time_ <= var_43_6 + arg_43_0 then
				arg_40_1.allBtn_.enabled = false
			end

			local var_43_7 = 0.6

			if arg_40_1.time_ >= var_43_6 + var_43_7 and arg_40_1.time_ < var_43_6 + var_43_7 + arg_43_0 then
				arg_40_1.allBtn_.enabled = true
			end
		end

		arg_40_1.nodeConfigList_ = {}

		arg_40_1:InitPlayNodeList()
	end,
	Play324541011 = function(arg_44_0, arg_44_1)
		arg_44_1.time_ = 0
		arg_44_1.frameCnt_ = 0
		arg_44_1.state_ = "playing"
		arg_44_1.curTalkId_ = 324541011
		arg_44_1.duration_ = 5

		SetActive(arg_44_1.tipsGo_, false)

		function arg_44_1.onSingleLineFinish_()
			arg_44_1.onSingleLineUpdate_ = nil
			arg_44_1.onSingleLineFinish_ = nil
			arg_44_1.state_ = "waiting"
		end

		function arg_44_1.playNext_(arg_46_0)
			if arg_46_0 == 1 then
				arg_44_0:Play324541012(arg_44_1)
			end
		end

		function arg_44_1.onSingleLineUpdate_(arg_47_0)
			local var_47_0 = 0
			local var_47_1 = 1.25

			if var_47_0 < arg_44_1.time_ and arg_44_1.time_ <= var_47_0 + arg_47_0 then
				arg_44_1.talkMaxDuration = 0
				arg_44_1.dialogCg_.alpha = 1

				arg_44_1.dialog_:SetActive(true)
				SetActive(arg_44_1.leftNameGo_, false)

				arg_44_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_44_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_44_1:RecordName(arg_44_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_44_1.iconTrs_.gameObject, false)
				arg_44_1.callingController_:SetSelectedState("normal")

				local var_47_2 = arg_44_1:GetWordFromCfg(324541011)
				local var_47_3 = arg_44_1:FormatText(var_47_2.content)

				arg_44_1.text_.text = var_47_3

				LuaForUtil.ClearLinePrefixSymbol(arg_44_1.text_)

				local var_47_4 = 50
				local var_47_5 = utf8.len(var_47_3)
				local var_47_6 = var_47_4 <= 0 and var_47_1 or var_47_1 * (var_47_5 / var_47_4)

				if var_47_6 > 0 and var_47_1 < var_47_6 then
					arg_44_1.talkMaxDuration = var_47_6

					if var_47_6 + var_47_0 > arg_44_1.duration_ then
						arg_44_1.duration_ = var_47_6 + var_47_0
					end
				end

				arg_44_1.text_.text = var_47_3
				arg_44_1.typewritter.percent = 0

				arg_44_1.typewritter:SetDirty()
				arg_44_1:ShowNextGo(false)
				arg_44_1:RecordContent(arg_44_1.text_.text)
			end

			local var_47_7 = math.max(var_47_1, arg_44_1.talkMaxDuration)

			if var_47_0 <= arg_44_1.time_ and arg_44_1.time_ < var_47_0 + var_47_7 then
				arg_44_1.typewritter.percent = (arg_44_1.time_ - var_47_0) / var_47_7

				arg_44_1.typewritter:SetDirty()
			end

			if arg_44_1.time_ >= var_47_0 + var_47_7 and arg_44_1.time_ < var_47_0 + var_47_7 + arg_47_0 then
				arg_44_1.typewritter.percent = 1

				arg_44_1.typewritter:SetDirty()
				arg_44_1:ShowNextGo(true)
			end
		end

		arg_44_1.nodeConfigList_ = {}

		arg_44_1:InitPlayNodeList()
	end,
	Play324541012 = function(arg_48_0, arg_48_1)
		arg_48_1.time_ = 0
		arg_48_1.frameCnt_ = 0
		arg_48_1.state_ = "playing"
		arg_48_1.curTalkId_ = 324541012
		arg_48_1.duration_ = 9

		SetActive(arg_48_1.tipsGo_, false)

		function arg_48_1.onSingleLineFinish_()
			arg_48_1.onSingleLineUpdate_ = nil
			arg_48_1.onSingleLineFinish_ = nil
			arg_48_1.state_ = "waiting"
		end

		function arg_48_1.playNext_(arg_50_0)
			if arg_50_0 == 1 then
				arg_48_0:Play324541013(arg_48_1)
			end
		end

		function arg_48_1.onSingleLineUpdate_(arg_51_0)
			local var_51_0 = "J25f"

			if arg_48_1.bgs_[var_51_0] == nil then
				local var_51_1 = Object.Instantiate(arg_48_1.paintGo_)

				var_51_1:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. var_51_0)
				var_51_1.name = var_51_0
				var_51_1.transform.parent = arg_48_1.stage_.transform
				var_51_1.transform.localPosition = Vector3.New(0, 100, 0)
				arg_48_1.bgs_[var_51_0] = var_51_1
			end

			local var_51_2 = 2

			if var_51_2 < arg_48_1.time_ and arg_48_1.time_ <= var_51_2 + arg_51_0 then
				local var_51_3 = manager.ui.mainCamera.transform.localPosition
				local var_51_4 = Vector3.New(0, 0, 10) + Vector3.New(var_51_3.x, var_51_3.y, 0)
				local var_51_5 = arg_48_1.bgs_.J25f

				var_51_5.transform.localPosition = var_51_4
				var_51_5.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_51_6 = var_51_5:GetComponent("SpriteRenderer")

				if var_51_6 and var_51_6.sprite then
					local var_51_7 = (var_51_5.transform.localPosition - var_51_3).z
					local var_51_8 = manager.ui.mainCameraCom_
					local var_51_9 = 2 * var_51_7 * Mathf.Tan(var_51_8.fieldOfView * 0.5 * Mathf.Deg2Rad)
					local var_51_10 = var_51_9 * var_51_8.aspect
					local var_51_11 = var_51_6.sprite.bounds.size.x
					local var_51_12 = var_51_6.sprite.bounds.size.y
					local var_51_13 = var_51_10 / var_51_11
					local var_51_14 = var_51_9 / var_51_12
					local var_51_15 = var_51_14 < var_51_13 and var_51_13 or var_51_14

					var_51_5.transform.localScale = Vector3.New(var_51_15, var_51_15, 0)
				end

				for iter_51_0, iter_51_1 in pairs(arg_48_1.bgs_) do
					if iter_51_0 ~= "J25f" then
						iter_51_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_51_16 = 4

			if var_51_16 < arg_48_1.time_ and arg_48_1.time_ <= var_51_16 + arg_51_0 then
				arg_48_1.allBtn_.enabled = false
			end

			local var_51_17 = 0.3

			if arg_48_1.time_ >= var_51_16 + var_51_17 and arg_48_1.time_ < var_51_16 + var_51_17 + arg_51_0 then
				arg_48_1.allBtn_.enabled = true
			end

			local var_51_18 = 0

			if var_51_18 < arg_48_1.time_ and arg_48_1.time_ <= var_51_18 + arg_51_0 then
				arg_48_1.mask_.enabled = true
				arg_48_1.mask_.raycastTarget = true

				arg_48_1:SetGaussion(false)
			end

			local var_51_19 = 2

			if var_51_18 <= arg_48_1.time_ and arg_48_1.time_ < var_51_18 + var_51_19 then
				local var_51_20 = (arg_48_1.time_ - var_51_18) / var_51_19
				local var_51_21 = Color.New(0, 0, 0)

				var_51_21.a = Mathf.Lerp(0, 1, var_51_20)
				arg_48_1.mask_.color = var_51_21
			end

			if arg_48_1.time_ >= var_51_18 + var_51_19 and arg_48_1.time_ < var_51_18 + var_51_19 + arg_51_0 then
				local var_51_22 = Color.New(0, 0, 0)

				var_51_22.a = 1
				arg_48_1.mask_.color = var_51_22
			end

			local var_51_23 = 2

			if var_51_23 < arg_48_1.time_ and arg_48_1.time_ <= var_51_23 + arg_51_0 then
				arg_48_1.mask_.enabled = true
				arg_48_1.mask_.raycastTarget = true

				arg_48_1:SetGaussion(false)
			end

			local var_51_24 = 2

			if var_51_23 <= arg_48_1.time_ and arg_48_1.time_ < var_51_23 + var_51_24 then
				local var_51_25 = (arg_48_1.time_ - var_51_23) / var_51_24
				local var_51_26 = Color.New(0, 0, 0)

				var_51_26.a = Mathf.Lerp(1, 0, var_51_25)
				arg_48_1.mask_.color = var_51_26
			end

			if arg_48_1.time_ >= var_51_23 + var_51_24 and arg_48_1.time_ < var_51_23 + var_51_24 + arg_51_0 then
				local var_51_27 = Color.New(0, 0, 0)
				local var_51_28 = 0

				arg_48_1.mask_.enabled = false
				var_51_27.a = var_51_28
				arg_48_1.mask_.color = var_51_27
			end

			if arg_48_1.frameCnt_ <= 1 then
				arg_48_1.dialog_:SetActive(false)
			end

			local var_51_29 = 4
			local var_51_30 = 1.325

			if var_51_29 < arg_48_1.time_ and arg_48_1.time_ <= var_51_29 + arg_51_0 then
				arg_48_1.talkMaxDuration = 0

				arg_48_1.dialog_:SetActive(true)

				arg_48_1.dialogCg_.alpha = 0

				local var_51_31 = LeanTween.value(arg_48_1.dialog_, 0, 1, 0.3)

				var_51_31:setOnUpdate(LuaHelper.FloatAction(function(arg_52_0)
					arg_48_1.dialogCg_.alpha = arg_52_0
				end))
				var_51_31:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_48_1.dialog_)
					var_51_31:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_48_1.duration_ = arg_48_1.duration_ + 0.3

				SetActive(arg_48_1.leftNameGo_, false)

				arg_48_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_48_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_48_1:RecordName(arg_48_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_48_1.iconTrs_.gameObject, false)
				arg_48_1.callingController_:SetSelectedState("normal")

				local var_51_32 = arg_48_1:GetWordFromCfg(324541012)
				local var_51_33 = arg_48_1:FormatText(var_51_32.content)

				arg_48_1.text_.text = var_51_33

				LuaForUtil.ClearLinePrefixSymbol(arg_48_1.text_)

				local var_51_34 = 53
				local var_51_35 = utf8.len(var_51_33)
				local var_51_36 = var_51_34 <= 0 and var_51_30 or var_51_30 * (var_51_35 / var_51_34)

				if var_51_36 > 0 and var_51_30 < var_51_36 then
					arg_48_1.talkMaxDuration = var_51_36
					var_51_29 = var_51_29 + 0.3

					if var_51_36 + var_51_29 > arg_48_1.duration_ then
						arg_48_1.duration_ = var_51_36 + var_51_29
					end
				end

				arg_48_1.text_.text = var_51_33
				arg_48_1.typewritter.percent = 0

				arg_48_1.typewritter:SetDirty()
				arg_48_1:ShowNextGo(false)
				arg_48_1:RecordContent(arg_48_1.text_.text)
			end

			local var_51_37 = var_51_29 + 0.3
			local var_51_38 = math.max(var_51_30, arg_48_1.talkMaxDuration)

			if var_51_37 <= arg_48_1.time_ and arg_48_1.time_ < var_51_37 + var_51_38 then
				arg_48_1.typewritter.percent = (arg_48_1.time_ - var_51_37) / var_51_38

				arg_48_1.typewritter:SetDirty()
			end

			if arg_48_1.time_ >= var_51_37 + var_51_38 and arg_48_1.time_ < var_51_37 + var_51_38 + arg_51_0 then
				arg_48_1.typewritter.percent = 1

				arg_48_1.typewritter:SetDirty()
				arg_48_1:ShowNextGo(true)
			end
		end

		arg_48_1.nodeConfigList_ = {}

		arg_48_1:InitPlayNodeList()
	end,
	Play324541013 = function(arg_54_0, arg_54_1)
		arg_54_1.time_ = 0
		arg_54_1.frameCnt_ = 0
		arg_54_1.state_ = "playing"
		arg_54_1.curTalkId_ = 324541013
		arg_54_1.duration_ = 5

		SetActive(arg_54_1.tipsGo_, false)

		function arg_54_1.onSingleLineFinish_()
			arg_54_1.onSingleLineUpdate_ = nil
			arg_54_1.onSingleLineFinish_ = nil
			arg_54_1.state_ = "waiting"
		end

		function arg_54_1.playNext_(arg_56_0)
			if arg_56_0 == 1 then
				arg_54_0:Play324541014(arg_54_1)
			end
		end

		function arg_54_1.onSingleLineUpdate_(arg_57_0)
			local var_57_0 = 0
			local var_57_1 = 1.2

			if var_57_0 < arg_54_1.time_ and arg_54_1.time_ <= var_57_0 + arg_57_0 then
				arg_54_1.talkMaxDuration = 0
				arg_54_1.dialogCg_.alpha = 1

				arg_54_1.dialog_:SetActive(true)
				SetActive(arg_54_1.leftNameGo_, false)

				arg_54_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_54_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_54_1:RecordName(arg_54_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_54_1.iconTrs_.gameObject, false)
				arg_54_1.callingController_:SetSelectedState("normal")

				local var_57_2 = arg_54_1:GetWordFromCfg(324541013)
				local var_57_3 = arg_54_1:FormatText(var_57_2.content)

				arg_54_1.text_.text = var_57_3

				LuaForUtil.ClearLinePrefixSymbol(arg_54_1.text_)

				local var_57_4 = 48
				local var_57_5 = utf8.len(var_57_3)
				local var_57_6 = var_57_4 <= 0 and var_57_1 or var_57_1 * (var_57_5 / var_57_4)

				if var_57_6 > 0 and var_57_1 < var_57_6 then
					arg_54_1.talkMaxDuration = var_57_6

					if var_57_6 + var_57_0 > arg_54_1.duration_ then
						arg_54_1.duration_ = var_57_6 + var_57_0
					end
				end

				arg_54_1.text_.text = var_57_3
				arg_54_1.typewritter.percent = 0

				arg_54_1.typewritter:SetDirty()
				arg_54_1:ShowNextGo(false)
				arg_54_1:RecordContent(arg_54_1.text_.text)
			end

			local var_57_7 = math.max(var_57_1, arg_54_1.talkMaxDuration)

			if var_57_0 <= arg_54_1.time_ and arg_54_1.time_ < var_57_0 + var_57_7 then
				arg_54_1.typewritter.percent = (arg_54_1.time_ - var_57_0) / var_57_7

				arg_54_1.typewritter:SetDirty()
			end

			if arg_54_1.time_ >= var_57_0 + var_57_7 and arg_54_1.time_ < var_57_0 + var_57_7 + arg_57_0 then
				arg_54_1.typewritter.percent = 1

				arg_54_1.typewritter:SetDirty()
				arg_54_1:ShowNextGo(true)
			end
		end

		arg_54_1.nodeConfigList_ = {}

		arg_54_1:InitPlayNodeList()
	end,
	Play324541014 = function(arg_58_0, arg_58_1)
		arg_58_1.time_ = 0
		arg_58_1.frameCnt_ = 0
		arg_58_1.state_ = "playing"
		arg_58_1.curTalkId_ = 324541014
		arg_58_1.duration_ = 5

		SetActive(arg_58_1.tipsGo_, false)

		function arg_58_1.onSingleLineFinish_()
			arg_58_1.onSingleLineUpdate_ = nil
			arg_58_1.onSingleLineFinish_ = nil
			arg_58_1.state_ = "waiting"
		end

		function arg_58_1.playNext_(arg_60_0)
			if arg_60_0 == 1 then
				arg_58_0:Play324541015(arg_58_1)
			end
		end

		function arg_58_1.onSingleLineUpdate_(arg_61_0)
			local var_61_0 = 0
			local var_61_1 = 0.675

			if var_61_0 < arg_58_1.time_ and arg_58_1.time_ <= var_61_0 + arg_61_0 then
				arg_58_1.talkMaxDuration = 0
				arg_58_1.dialogCg_.alpha = 1

				arg_58_1.dialog_:SetActive(true)
				SetActive(arg_58_1.leftNameGo_, true)

				local var_61_2 = arg_58_1:FormatText(StoryNameCfg[7].name)

				arg_58_1.leftNameTxt_.text = var_61_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_58_1.leftNameTxt_.transform)

				arg_58_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_58_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_58_1:RecordName(arg_58_1.leftNameTxt_.text)
				SetActive(arg_58_1.iconTrs_.gameObject, true)
				arg_58_1.iconController_:SetSelectedState("hero")

				arg_58_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_58_1.callingController_:SetSelectedState("normal")

				arg_58_1.keyicon_.color = Color.New(1, 1, 1)
				arg_58_1.icon_.color = Color.New(1, 1, 1)

				local var_61_3 = arg_58_1:GetWordFromCfg(324541014)
				local var_61_4 = arg_58_1:FormatText(var_61_3.content)

				arg_58_1.text_.text = var_61_4

				LuaForUtil.ClearLinePrefixSymbol(arg_58_1.text_)

				local var_61_5 = 27
				local var_61_6 = utf8.len(var_61_4)
				local var_61_7 = var_61_5 <= 0 and var_61_1 or var_61_1 * (var_61_6 / var_61_5)

				if var_61_7 > 0 and var_61_1 < var_61_7 then
					arg_58_1.talkMaxDuration = var_61_7

					if var_61_7 + var_61_0 > arg_58_1.duration_ then
						arg_58_1.duration_ = var_61_7 + var_61_0
					end
				end

				arg_58_1.text_.text = var_61_4
				arg_58_1.typewritter.percent = 0

				arg_58_1.typewritter:SetDirty()
				arg_58_1:ShowNextGo(false)
				arg_58_1:RecordContent(arg_58_1.text_.text)
			end

			local var_61_8 = math.max(var_61_1, arg_58_1.talkMaxDuration)

			if var_61_0 <= arg_58_1.time_ and arg_58_1.time_ < var_61_0 + var_61_8 then
				arg_58_1.typewritter.percent = (arg_58_1.time_ - var_61_0) / var_61_8

				arg_58_1.typewritter:SetDirty()
			end

			if arg_58_1.time_ >= var_61_0 + var_61_8 and arg_58_1.time_ < var_61_0 + var_61_8 + arg_61_0 then
				arg_58_1.typewritter.percent = 1

				arg_58_1.typewritter:SetDirty()
				arg_58_1:ShowNextGo(true)
			end
		end

		arg_58_1.nodeConfigList_ = {}

		arg_58_1:InitPlayNodeList()
	end,
	Play324541015 = function(arg_62_0, arg_62_1)
		arg_62_1.time_ = 0
		arg_62_1.frameCnt_ = 0
		arg_62_1.state_ = "playing"
		arg_62_1.curTalkId_ = 324541015
		arg_62_1.duration_ = 5

		SetActive(arg_62_1.tipsGo_, false)

		function arg_62_1.onSingleLineFinish_()
			arg_62_1.onSingleLineUpdate_ = nil
			arg_62_1.onSingleLineFinish_ = nil
			arg_62_1.state_ = "waiting"
		end

		function arg_62_1.playNext_(arg_64_0)
			if arg_64_0 == 1 then
				arg_62_0:Play324541016(arg_62_1)
			end
		end

		function arg_62_1.onSingleLineUpdate_(arg_65_0)
			local var_65_0 = 0
			local var_65_1 = 1.275

			if var_65_0 < arg_62_1.time_ and arg_62_1.time_ <= var_65_0 + arg_65_0 then
				arg_62_1.talkMaxDuration = 0
				arg_62_1.dialogCg_.alpha = 1

				arg_62_1.dialog_:SetActive(true)
				SetActive(arg_62_1.leftNameGo_, false)

				arg_62_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_62_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_62_1:RecordName(arg_62_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_62_1.iconTrs_.gameObject, false)
				arg_62_1.callingController_:SetSelectedState("normal")

				local var_65_2 = arg_62_1:GetWordFromCfg(324541015)
				local var_65_3 = arg_62_1:FormatText(var_65_2.content)

				arg_62_1.text_.text = var_65_3

				LuaForUtil.ClearLinePrefixSymbol(arg_62_1.text_)

				local var_65_4 = 51
				local var_65_5 = utf8.len(var_65_3)
				local var_65_6 = var_65_4 <= 0 and var_65_1 or var_65_1 * (var_65_5 / var_65_4)

				if var_65_6 > 0 and var_65_1 < var_65_6 then
					arg_62_1.talkMaxDuration = var_65_6

					if var_65_6 + var_65_0 > arg_62_1.duration_ then
						arg_62_1.duration_ = var_65_6 + var_65_0
					end
				end

				arg_62_1.text_.text = var_65_3
				arg_62_1.typewritter.percent = 0

				arg_62_1.typewritter:SetDirty()
				arg_62_1:ShowNextGo(false)
				arg_62_1:RecordContent(arg_62_1.text_.text)
			end

			local var_65_7 = math.max(var_65_1, arg_62_1.talkMaxDuration)

			if var_65_0 <= arg_62_1.time_ and arg_62_1.time_ < var_65_0 + var_65_7 then
				arg_62_1.typewritter.percent = (arg_62_1.time_ - var_65_0) / var_65_7

				arg_62_1.typewritter:SetDirty()
			end

			if arg_62_1.time_ >= var_65_0 + var_65_7 and arg_62_1.time_ < var_65_0 + var_65_7 + arg_65_0 then
				arg_62_1.typewritter.percent = 1

				arg_62_1.typewritter:SetDirty()
				arg_62_1:ShowNextGo(true)
			end
		end

		arg_62_1.nodeConfigList_ = {}

		arg_62_1:InitPlayNodeList()
	end,
	Play324541016 = function(arg_66_0, arg_66_1)
		arg_66_1.time_ = 0
		arg_66_1.frameCnt_ = 0
		arg_66_1.state_ = "playing"
		arg_66_1.curTalkId_ = 324541016
		arg_66_1.duration_ = 5

		SetActive(arg_66_1.tipsGo_, false)

		function arg_66_1.onSingleLineFinish_()
			arg_66_1.onSingleLineUpdate_ = nil
			arg_66_1.onSingleLineFinish_ = nil
			arg_66_1.state_ = "waiting"
		end

		function arg_66_1.playNext_(arg_68_0)
			if arg_68_0 == 1 then
				arg_66_0:Play324541017(arg_66_1)
			end
		end

		function arg_66_1.onSingleLineUpdate_(arg_69_0)
			local var_69_0 = 0
			local var_69_1 = 1.375

			if var_69_0 < arg_66_1.time_ and arg_66_1.time_ <= var_69_0 + arg_69_0 then
				arg_66_1.talkMaxDuration = 0
				arg_66_1.dialogCg_.alpha = 1

				arg_66_1.dialog_:SetActive(true)
				SetActive(arg_66_1.leftNameGo_, false)

				arg_66_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_66_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_66_1:RecordName(arg_66_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_66_1.iconTrs_.gameObject, false)
				arg_66_1.callingController_:SetSelectedState("normal")

				local var_69_2 = arg_66_1:GetWordFromCfg(324541016)
				local var_69_3 = arg_66_1:FormatText(var_69_2.content)

				arg_66_1.text_.text = var_69_3

				LuaForUtil.ClearLinePrefixSymbol(arg_66_1.text_)

				local var_69_4 = 55
				local var_69_5 = utf8.len(var_69_3)
				local var_69_6 = var_69_4 <= 0 and var_69_1 or var_69_1 * (var_69_5 / var_69_4)

				if var_69_6 > 0 and var_69_1 < var_69_6 then
					arg_66_1.talkMaxDuration = var_69_6

					if var_69_6 + var_69_0 > arg_66_1.duration_ then
						arg_66_1.duration_ = var_69_6 + var_69_0
					end
				end

				arg_66_1.text_.text = var_69_3
				arg_66_1.typewritter.percent = 0

				arg_66_1.typewritter:SetDirty()
				arg_66_1:ShowNextGo(false)
				arg_66_1:RecordContent(arg_66_1.text_.text)
			end

			local var_69_7 = math.max(var_69_1, arg_66_1.talkMaxDuration)

			if var_69_0 <= arg_66_1.time_ and arg_66_1.time_ < var_69_0 + var_69_7 then
				arg_66_1.typewritter.percent = (arg_66_1.time_ - var_69_0) / var_69_7

				arg_66_1.typewritter:SetDirty()
			end

			if arg_66_1.time_ >= var_69_0 + var_69_7 and arg_66_1.time_ < var_69_0 + var_69_7 + arg_69_0 then
				arg_66_1.typewritter.percent = 1

				arg_66_1.typewritter:SetDirty()
				arg_66_1:ShowNextGo(true)
			end
		end

		arg_66_1.nodeConfigList_ = {}

		arg_66_1:InitPlayNodeList()
	end,
	Play324541017 = function(arg_70_0, arg_70_1)
		arg_70_1.time_ = 0
		arg_70_1.frameCnt_ = 0
		arg_70_1.state_ = "playing"
		arg_70_1.curTalkId_ = 324541017
		arg_70_1.duration_ = 5

		SetActive(arg_70_1.tipsGo_, false)

		function arg_70_1.onSingleLineFinish_()
			arg_70_1.onSingleLineUpdate_ = nil
			arg_70_1.onSingleLineFinish_ = nil
			arg_70_1.state_ = "waiting"
		end

		function arg_70_1.playNext_(arg_72_0)
			if arg_72_0 == 1 then
				arg_70_0:Play324541018(arg_70_1)
			end
		end

		function arg_70_1.onSingleLineUpdate_(arg_73_0)
			local var_73_0 = 0
			local var_73_1 = 1.325

			if var_73_0 < arg_70_1.time_ and arg_70_1.time_ <= var_73_0 + arg_73_0 then
				arg_70_1.talkMaxDuration = 0
				arg_70_1.dialogCg_.alpha = 1

				arg_70_1.dialog_:SetActive(true)
				SetActive(arg_70_1.leftNameGo_, false)

				arg_70_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_70_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_70_1:RecordName(arg_70_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_70_1.iconTrs_.gameObject, false)
				arg_70_1.callingController_:SetSelectedState("normal")

				local var_73_2 = arg_70_1:GetWordFromCfg(324541017)
				local var_73_3 = arg_70_1:FormatText(var_73_2.content)

				arg_70_1.text_.text = var_73_3

				LuaForUtil.ClearLinePrefixSymbol(arg_70_1.text_)

				local var_73_4 = 53
				local var_73_5 = utf8.len(var_73_3)
				local var_73_6 = var_73_4 <= 0 and var_73_1 or var_73_1 * (var_73_5 / var_73_4)

				if var_73_6 > 0 and var_73_1 < var_73_6 then
					arg_70_1.talkMaxDuration = var_73_6

					if var_73_6 + var_73_0 > arg_70_1.duration_ then
						arg_70_1.duration_ = var_73_6 + var_73_0
					end
				end

				arg_70_1.text_.text = var_73_3
				arg_70_1.typewritter.percent = 0

				arg_70_1.typewritter:SetDirty()
				arg_70_1:ShowNextGo(false)
				arg_70_1:RecordContent(arg_70_1.text_.text)
			end

			local var_73_7 = math.max(var_73_1, arg_70_1.talkMaxDuration)

			if var_73_0 <= arg_70_1.time_ and arg_70_1.time_ < var_73_0 + var_73_7 then
				arg_70_1.typewritter.percent = (arg_70_1.time_ - var_73_0) / var_73_7

				arg_70_1.typewritter:SetDirty()
			end

			if arg_70_1.time_ >= var_73_0 + var_73_7 and arg_70_1.time_ < var_73_0 + var_73_7 + arg_73_0 then
				arg_70_1.typewritter.percent = 1

				arg_70_1.typewritter:SetDirty()
				arg_70_1:ShowNextGo(true)
			end
		end

		arg_70_1.nodeConfigList_ = {}

		arg_70_1:InitPlayNodeList()
	end,
	Play324541018 = function(arg_74_0, arg_74_1)
		arg_74_1.time_ = 0
		arg_74_1.frameCnt_ = 0
		arg_74_1.state_ = "playing"
		arg_74_1.curTalkId_ = 324541018
		arg_74_1.duration_ = 5

		SetActive(arg_74_1.tipsGo_, false)

		function arg_74_1.onSingleLineFinish_()
			arg_74_1.onSingleLineUpdate_ = nil
			arg_74_1.onSingleLineFinish_ = nil
			arg_74_1.state_ = "waiting"
		end

		function arg_74_1.playNext_(arg_76_0)
			if arg_76_0 == 1 then
				arg_74_0:Play324541019(arg_74_1)
			end
		end

		function arg_74_1.onSingleLineUpdate_(arg_77_0)
			local var_77_0 = 0
			local var_77_1 = 0.125

			if var_77_0 < arg_74_1.time_ and arg_74_1.time_ <= var_77_0 + arg_77_0 then
				arg_74_1.talkMaxDuration = 0
				arg_74_1.dialogCg_.alpha = 1

				arg_74_1.dialog_:SetActive(true)
				SetActive(arg_74_1.leftNameGo_, true)

				local var_77_2 = arg_74_1:FormatText(StoryNameCfg[7].name)

				arg_74_1.leftNameTxt_.text = var_77_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_74_1.leftNameTxt_.transform)

				arg_74_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_74_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_74_1:RecordName(arg_74_1.leftNameTxt_.text)
				SetActive(arg_74_1.iconTrs_.gameObject, true)
				arg_74_1.iconController_:SetSelectedState("hero")

				arg_74_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_74_1.callingController_:SetSelectedState("normal")

				arg_74_1.keyicon_.color = Color.New(1, 1, 1)
				arg_74_1.icon_.color = Color.New(1, 1, 1)

				local var_77_3 = arg_74_1:GetWordFromCfg(324541018)
				local var_77_4 = arg_74_1:FormatText(var_77_3.content)

				arg_74_1.text_.text = var_77_4

				LuaForUtil.ClearLinePrefixSymbol(arg_74_1.text_)

				local var_77_5 = 5
				local var_77_6 = utf8.len(var_77_4)
				local var_77_7 = var_77_5 <= 0 and var_77_1 or var_77_1 * (var_77_6 / var_77_5)

				if var_77_7 > 0 and var_77_1 < var_77_7 then
					arg_74_1.talkMaxDuration = var_77_7

					if var_77_7 + var_77_0 > arg_74_1.duration_ then
						arg_74_1.duration_ = var_77_7 + var_77_0
					end
				end

				arg_74_1.text_.text = var_77_4
				arg_74_1.typewritter.percent = 0

				arg_74_1.typewritter:SetDirty()
				arg_74_1:ShowNextGo(false)
				arg_74_1:RecordContent(arg_74_1.text_.text)
			end

			local var_77_8 = math.max(var_77_1, arg_74_1.talkMaxDuration)

			if var_77_0 <= arg_74_1.time_ and arg_74_1.time_ < var_77_0 + var_77_8 then
				arg_74_1.typewritter.percent = (arg_74_1.time_ - var_77_0) / var_77_8

				arg_74_1.typewritter:SetDirty()
			end

			if arg_74_1.time_ >= var_77_0 + var_77_8 and arg_74_1.time_ < var_77_0 + var_77_8 + arg_77_0 then
				arg_74_1.typewritter.percent = 1

				arg_74_1.typewritter:SetDirty()
				arg_74_1:ShowNextGo(true)
			end
		end

		arg_74_1.nodeConfigList_ = {}

		arg_74_1:InitPlayNodeList()
	end,
	Play324541019 = function(arg_78_0, arg_78_1)
		arg_78_1.time_ = 0
		arg_78_1.frameCnt_ = 0
		arg_78_1.state_ = "playing"
		arg_78_1.curTalkId_ = 324541019
		arg_78_1.duration_ = 5

		SetActive(arg_78_1.tipsGo_, false)

		function arg_78_1.onSingleLineFinish_()
			arg_78_1.onSingleLineUpdate_ = nil
			arg_78_1.onSingleLineFinish_ = nil
			arg_78_1.state_ = "waiting"
		end

		function arg_78_1.playNext_(arg_80_0)
			if arg_80_0 == 1 then
				arg_78_0:Play324541020(arg_78_1)
			end
		end

		function arg_78_1.onSingleLineUpdate_(arg_81_0)
			local var_81_0 = 0
			local var_81_1 = 0.6

			if var_81_0 < arg_78_1.time_ and arg_78_1.time_ <= var_81_0 + arg_81_0 then
				arg_78_1.talkMaxDuration = 0
				arg_78_1.dialogCg_.alpha = 1

				arg_78_1.dialog_:SetActive(true)
				SetActive(arg_78_1.leftNameGo_, false)

				arg_78_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_78_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_78_1:RecordName(arg_78_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_78_1.iconTrs_.gameObject, false)
				arg_78_1.callingController_:SetSelectedState("normal")

				local var_81_2 = arg_78_1:GetWordFromCfg(324541019)
				local var_81_3 = arg_78_1:FormatText(var_81_2.content)

				arg_78_1.text_.text = var_81_3

				LuaForUtil.ClearLinePrefixSymbol(arg_78_1.text_)

				local var_81_4 = 24
				local var_81_5 = utf8.len(var_81_3)
				local var_81_6 = var_81_4 <= 0 and var_81_1 or var_81_1 * (var_81_5 / var_81_4)

				if var_81_6 > 0 and var_81_1 < var_81_6 then
					arg_78_1.talkMaxDuration = var_81_6

					if var_81_6 + var_81_0 > arg_78_1.duration_ then
						arg_78_1.duration_ = var_81_6 + var_81_0
					end
				end

				arg_78_1.text_.text = var_81_3
				arg_78_1.typewritter.percent = 0

				arg_78_1.typewritter:SetDirty()
				arg_78_1:ShowNextGo(false)
				arg_78_1:RecordContent(arg_78_1.text_.text)
			end

			local var_81_7 = math.max(var_81_1, arg_78_1.talkMaxDuration)

			if var_81_0 <= arg_78_1.time_ and arg_78_1.time_ < var_81_0 + var_81_7 then
				arg_78_1.typewritter.percent = (arg_78_1.time_ - var_81_0) / var_81_7

				arg_78_1.typewritter:SetDirty()
			end

			if arg_78_1.time_ >= var_81_0 + var_81_7 and arg_78_1.time_ < var_81_0 + var_81_7 + arg_81_0 then
				arg_78_1.typewritter.percent = 1

				arg_78_1.typewritter:SetDirty()
				arg_78_1:ShowNextGo(true)
			end
		end

		arg_78_1.nodeConfigList_ = {}

		arg_78_1:InitPlayNodeList()
	end,
	Play324541020 = function(arg_82_0, arg_82_1)
		arg_82_1.time_ = 0
		arg_82_1.frameCnt_ = 0
		arg_82_1.state_ = "playing"
		arg_82_1.curTalkId_ = 324541020
		arg_82_1.duration_ = 5.7

		SetActive(arg_82_1.tipsGo_, false)

		function arg_82_1.onSingleLineFinish_()
			arg_82_1.onSingleLineUpdate_ = nil
			arg_82_1.onSingleLineFinish_ = nil
			arg_82_1.state_ = "waiting"
		end

		function arg_82_1.playNext_(arg_84_0)
			if arg_84_0 == 1 then
				arg_82_0:Play324541021(arg_82_1)
			end
		end

		function arg_82_1.onSingleLineUpdate_(arg_85_0)
			local var_85_0 = arg_82_1.bgs_.J25f.transform
			local var_85_1 = 0

			if var_85_1 < arg_82_1.time_ and arg_82_1.time_ <= var_85_1 + arg_85_0 then
				arg_82_1.var_.moveOldPosJ25f = var_85_0.localPosition
			end

			local var_85_2 = 1

			if var_85_1 <= arg_82_1.time_ and arg_82_1.time_ < var_85_1 + var_85_2 then
				local var_85_3 = (arg_82_1.time_ - var_85_1) / var_85_2
				local var_85_4 = Vector3.New(0, 1, 9.5)

				var_85_0.localPosition = Vector3.Lerp(arg_82_1.var_.moveOldPosJ25f, var_85_4, var_85_3)
			end

			if arg_82_1.time_ >= var_85_1 + var_85_2 and arg_82_1.time_ < var_85_1 + var_85_2 + arg_85_0 then
				var_85_0.localPosition = Vector3.New(0, 1, 9.5)
			end

			local var_85_5 = 0

			if var_85_5 < arg_82_1.time_ and arg_82_1.time_ <= var_85_5 + arg_85_0 then
				arg_82_1.allBtn_.enabled = false
			end

			local var_85_6 = 1.36666666666667

			if arg_82_1.time_ >= var_85_5 + var_85_6 and arg_82_1.time_ < var_85_5 + var_85_6 + arg_85_0 then
				arg_82_1.allBtn_.enabled = true
			end

			local var_85_7 = 0.7
			local var_85_8 = 1.2

			if var_85_7 < arg_82_1.time_ and arg_82_1.time_ <= var_85_7 + arg_85_0 then
				arg_82_1.talkMaxDuration = 0
				arg_82_1.dialogCg_.alpha = 1

				arg_82_1.dialog_:SetActive(true)
				SetActive(arg_82_1.leftNameGo_, false)

				arg_82_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_82_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_82_1:RecordName(arg_82_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_82_1.iconTrs_.gameObject, false)
				arg_82_1.callingController_:SetSelectedState("normal")

				local var_85_9 = arg_82_1:GetWordFromCfg(324541020)
				local var_85_10 = arg_82_1:FormatText(var_85_9.content)

				arg_82_1.text_.text = var_85_10

				LuaForUtil.ClearLinePrefixSymbol(arg_82_1.text_)

				local var_85_11 = 48
				local var_85_12 = utf8.len(var_85_10)
				local var_85_13 = var_85_11 <= 0 and var_85_8 or var_85_8 * (var_85_12 / var_85_11)

				if var_85_13 > 0 and var_85_8 < var_85_13 then
					arg_82_1.talkMaxDuration = var_85_13

					if var_85_13 + var_85_7 > arg_82_1.duration_ then
						arg_82_1.duration_ = var_85_13 + var_85_7
					end
				end

				arg_82_1.text_.text = var_85_10
				arg_82_1.typewritter.percent = 0

				arg_82_1.typewritter:SetDirty()
				arg_82_1:ShowNextGo(false)
				arg_82_1:RecordContent(arg_82_1.text_.text)
			end

			local var_85_14 = math.max(var_85_8, arg_82_1.talkMaxDuration)

			if var_85_7 <= arg_82_1.time_ and arg_82_1.time_ < var_85_7 + var_85_14 then
				arg_82_1.typewritter.percent = (arg_82_1.time_ - var_85_7) / var_85_14

				arg_82_1.typewritter:SetDirty()
			end

			if arg_82_1.time_ >= var_85_7 + var_85_14 and arg_82_1.time_ < var_85_7 + var_85_14 + arg_85_0 then
				arg_82_1.typewritter.percent = 1

				arg_82_1.typewritter:SetDirty()
				arg_82_1:ShowNextGo(true)
			end
		end

		arg_82_1.nodeConfigList_ = {
			{
				assetPath = "",
				needEase = true,
				actorName = "J25f",
				className = "StoryMoveNode",
				changeDisplayLayer = false,
				duration = 1,
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Background,
				easeData = {
					needAlphaEase = false,
					startAlpha = 0,
					endAlpha = 1,
					moveType = StoryPlayerConst.EASE_MOVE_TYPE.MOVE_IN,
					startPos = Vector3.New(0, 1, 10),
					endPos = Vector3.New(0, 1, 9.5),
					easeType = LeanTweenType.notUsed
				}
			}
		}

		arg_82_1:InitPlayNodeList()
	end,
	Play324541021 = function(arg_86_0, arg_86_1)
		arg_86_1.time_ = 0
		arg_86_1.frameCnt_ = 0
		arg_86_1.state_ = "playing"
		arg_86_1.curTalkId_ = 324541021
		arg_86_1.duration_ = 5

		SetActive(arg_86_1.tipsGo_, false)

		function arg_86_1.onSingleLineFinish_()
			arg_86_1.onSingleLineUpdate_ = nil
			arg_86_1.onSingleLineFinish_ = nil
			arg_86_1.state_ = "waiting"
		end

		function arg_86_1.playNext_(arg_88_0)
			if arg_88_0 == 1 then
				arg_86_0:Play324541022(arg_86_1)
			end
		end

		function arg_86_1.onSingleLineUpdate_(arg_89_0)
			local var_89_0 = 0
			local var_89_1 = 0.15

			if var_89_0 < arg_86_1.time_ and arg_86_1.time_ <= var_89_0 + arg_89_0 then
				arg_86_1.talkMaxDuration = 0
				arg_86_1.dialogCg_.alpha = 1

				arg_86_1.dialog_:SetActive(true)
				SetActive(arg_86_1.leftNameGo_, true)

				local var_89_2 = arg_86_1:FormatText(StoryNameCfg[7].name)

				arg_86_1.leftNameTxt_.text = var_89_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_86_1.leftNameTxt_.transform)

				arg_86_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_86_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_86_1:RecordName(arg_86_1.leftNameTxt_.text)
				SetActive(arg_86_1.iconTrs_.gameObject, true)
				arg_86_1.iconController_:SetSelectedState("hero")

				arg_86_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_86_1.callingController_:SetSelectedState("normal")

				arg_86_1.keyicon_.color = Color.New(1, 1, 1)
				arg_86_1.icon_.color = Color.New(1, 1, 1)

				local var_89_3 = arg_86_1:GetWordFromCfg(324541021)
				local var_89_4 = arg_86_1:FormatText(var_89_3.content)

				arg_86_1.text_.text = var_89_4

				LuaForUtil.ClearLinePrefixSymbol(arg_86_1.text_)

				local var_89_5 = 6
				local var_89_6 = utf8.len(var_89_4)
				local var_89_7 = var_89_5 <= 0 and var_89_1 or var_89_1 * (var_89_6 / var_89_5)

				if var_89_7 > 0 and var_89_1 < var_89_7 then
					arg_86_1.talkMaxDuration = var_89_7

					if var_89_7 + var_89_0 > arg_86_1.duration_ then
						arg_86_1.duration_ = var_89_7 + var_89_0
					end
				end

				arg_86_1.text_.text = var_89_4
				arg_86_1.typewritter.percent = 0

				arg_86_1.typewritter:SetDirty()
				arg_86_1:ShowNextGo(false)
				arg_86_1:RecordContent(arg_86_1.text_.text)
			end

			local var_89_8 = math.max(var_89_1, arg_86_1.talkMaxDuration)

			if var_89_0 <= arg_86_1.time_ and arg_86_1.time_ < var_89_0 + var_89_8 then
				arg_86_1.typewritter.percent = (arg_86_1.time_ - var_89_0) / var_89_8

				arg_86_1.typewritter:SetDirty()
			end

			if arg_86_1.time_ >= var_89_0 + var_89_8 and arg_86_1.time_ < var_89_0 + var_89_8 + arg_89_0 then
				arg_86_1.typewritter.percent = 1

				arg_86_1.typewritter:SetDirty()
				arg_86_1:ShowNextGo(true)
			end
		end

		arg_86_1.nodeConfigList_ = {}

		arg_86_1:InitPlayNodeList()
	end,
	Play324541022 = function(arg_90_0, arg_90_1)
		arg_90_1.time_ = 0
		arg_90_1.frameCnt_ = 0
		arg_90_1.state_ = "playing"
		arg_90_1.curTalkId_ = 324541022
		arg_90_1.duration_ = 5

		SetActive(arg_90_1.tipsGo_, false)

		function arg_90_1.onSingleLineFinish_()
			arg_90_1.onSingleLineUpdate_ = nil
			arg_90_1.onSingleLineFinish_ = nil
			arg_90_1.state_ = "waiting"
		end

		function arg_90_1.playNext_(arg_92_0)
			if arg_92_0 == 1 then
				arg_90_0:Play324541023(arg_90_1)
			end
		end

		function arg_90_1.onSingleLineUpdate_(arg_93_0)
			local var_93_0 = 0
			local var_93_1 = 1.575

			if var_93_0 < arg_90_1.time_ and arg_90_1.time_ <= var_93_0 + arg_93_0 then
				arg_90_1.talkMaxDuration = 0
				arg_90_1.dialogCg_.alpha = 1

				arg_90_1.dialog_:SetActive(true)
				SetActive(arg_90_1.leftNameGo_, false)

				arg_90_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_90_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_90_1:RecordName(arg_90_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_90_1.iconTrs_.gameObject, false)
				arg_90_1.callingController_:SetSelectedState("normal")

				local var_93_2 = arg_90_1:GetWordFromCfg(324541022)
				local var_93_3 = arg_90_1:FormatText(var_93_2.content)

				arg_90_1.text_.text = var_93_3

				LuaForUtil.ClearLinePrefixSymbol(arg_90_1.text_)

				local var_93_4 = 63
				local var_93_5 = utf8.len(var_93_3)
				local var_93_6 = var_93_4 <= 0 and var_93_1 or var_93_1 * (var_93_5 / var_93_4)

				if var_93_6 > 0 and var_93_1 < var_93_6 then
					arg_90_1.talkMaxDuration = var_93_6

					if var_93_6 + var_93_0 > arg_90_1.duration_ then
						arg_90_1.duration_ = var_93_6 + var_93_0
					end
				end

				arg_90_1.text_.text = var_93_3
				arg_90_1.typewritter.percent = 0

				arg_90_1.typewritter:SetDirty()
				arg_90_1:ShowNextGo(false)
				arg_90_1:RecordContent(arg_90_1.text_.text)
			end

			local var_93_7 = math.max(var_93_1, arg_90_1.talkMaxDuration)

			if var_93_0 <= arg_90_1.time_ and arg_90_1.time_ < var_93_0 + var_93_7 then
				arg_90_1.typewritter.percent = (arg_90_1.time_ - var_93_0) / var_93_7

				arg_90_1.typewritter:SetDirty()
			end

			if arg_90_1.time_ >= var_93_0 + var_93_7 and arg_90_1.time_ < var_93_0 + var_93_7 + arg_93_0 then
				arg_90_1.typewritter.percent = 1

				arg_90_1.typewritter:SetDirty()
				arg_90_1:ShowNextGo(true)
			end
		end

		arg_90_1.nodeConfigList_ = {}

		arg_90_1:InitPlayNodeList()
	end,
	Play324541023 = function(arg_94_0, arg_94_1)
		arg_94_1.time_ = 0
		arg_94_1.frameCnt_ = 0
		arg_94_1.state_ = "playing"
		arg_94_1.curTalkId_ = 324541023
		arg_94_1.duration_ = 5

		SetActive(arg_94_1.tipsGo_, false)

		function arg_94_1.onSingleLineFinish_()
			arg_94_1.onSingleLineUpdate_ = nil
			arg_94_1.onSingleLineFinish_ = nil
			arg_94_1.state_ = "waiting"
		end

		function arg_94_1.playNext_(arg_96_0)
			if arg_96_0 == 1 then
				arg_94_0:Play324541024(arg_94_1)
			end
		end

		function arg_94_1.onSingleLineUpdate_(arg_97_0)
			local var_97_0 = 0
			local var_97_1 = 1.45

			if var_97_0 < arg_94_1.time_ and arg_94_1.time_ <= var_97_0 + arg_97_0 then
				arg_94_1.talkMaxDuration = 0
				arg_94_1.dialogCg_.alpha = 1

				arg_94_1.dialog_:SetActive(true)
				SetActive(arg_94_1.leftNameGo_, false)

				arg_94_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_94_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_94_1:RecordName(arg_94_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_94_1.iconTrs_.gameObject, false)
				arg_94_1.callingController_:SetSelectedState("normal")

				local var_97_2 = arg_94_1:GetWordFromCfg(324541023)
				local var_97_3 = arg_94_1:FormatText(var_97_2.content)

				arg_94_1.text_.text = var_97_3

				LuaForUtil.ClearLinePrefixSymbol(arg_94_1.text_)

				local var_97_4 = 58
				local var_97_5 = utf8.len(var_97_3)
				local var_97_6 = var_97_4 <= 0 and var_97_1 or var_97_1 * (var_97_5 / var_97_4)

				if var_97_6 > 0 and var_97_1 < var_97_6 then
					arg_94_1.talkMaxDuration = var_97_6

					if var_97_6 + var_97_0 > arg_94_1.duration_ then
						arg_94_1.duration_ = var_97_6 + var_97_0
					end
				end

				arg_94_1.text_.text = var_97_3
				arg_94_1.typewritter.percent = 0

				arg_94_1.typewritter:SetDirty()
				arg_94_1:ShowNextGo(false)
				arg_94_1:RecordContent(arg_94_1.text_.text)
			end

			local var_97_7 = math.max(var_97_1, arg_94_1.talkMaxDuration)

			if var_97_0 <= arg_94_1.time_ and arg_94_1.time_ < var_97_0 + var_97_7 then
				arg_94_1.typewritter.percent = (arg_94_1.time_ - var_97_0) / var_97_7

				arg_94_1.typewritter:SetDirty()
			end

			if arg_94_1.time_ >= var_97_0 + var_97_7 and arg_94_1.time_ < var_97_0 + var_97_7 + arg_97_0 then
				arg_94_1.typewritter.percent = 1

				arg_94_1.typewritter:SetDirty()
				arg_94_1:ShowNextGo(true)
			end
		end

		arg_94_1.nodeConfigList_ = {}

		arg_94_1:InitPlayNodeList()
	end,
	Play324541024 = function(arg_98_0, arg_98_1)
		arg_98_1.time_ = 0
		arg_98_1.frameCnt_ = 0
		arg_98_1.state_ = "playing"
		arg_98_1.curTalkId_ = 324541024
		arg_98_1.duration_ = 5

		SetActive(arg_98_1.tipsGo_, false)

		function arg_98_1.onSingleLineFinish_()
			arg_98_1.onSingleLineUpdate_ = nil
			arg_98_1.onSingleLineFinish_ = nil
			arg_98_1.state_ = "waiting"
		end

		function arg_98_1.playNext_(arg_100_0)
			if arg_100_0 == 1 then
				arg_98_0:Play324541025(arg_98_1)
			end
		end

		function arg_98_1.onSingleLineUpdate_(arg_101_0)
			local var_101_0 = 0
			local var_101_1 = 0.15

			if var_101_0 < arg_98_1.time_ and arg_98_1.time_ <= var_101_0 + arg_101_0 then
				arg_98_1.talkMaxDuration = 0
				arg_98_1.dialogCg_.alpha = 1

				arg_98_1.dialog_:SetActive(true)
				SetActive(arg_98_1.leftNameGo_, true)

				local var_101_2 = arg_98_1:FormatText(StoryNameCfg[7].name)

				arg_98_1.leftNameTxt_.text = var_101_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_98_1.leftNameTxt_.transform)

				arg_98_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_98_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_98_1:RecordName(arg_98_1.leftNameTxt_.text)
				SetActive(arg_98_1.iconTrs_.gameObject, true)
				arg_98_1.iconController_:SetSelectedState("hero")

				arg_98_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_98_1.callingController_:SetSelectedState("normal")

				arg_98_1.keyicon_.color = Color.New(1, 1, 1)
				arg_98_1.icon_.color = Color.New(1, 1, 1)

				local var_101_3 = arg_98_1:GetWordFromCfg(324541024)
				local var_101_4 = arg_98_1:FormatText(var_101_3.content)

				arg_98_1.text_.text = var_101_4

				LuaForUtil.ClearLinePrefixSymbol(arg_98_1.text_)

				local var_101_5 = 6
				local var_101_6 = utf8.len(var_101_4)
				local var_101_7 = var_101_5 <= 0 and var_101_1 or var_101_1 * (var_101_6 / var_101_5)

				if var_101_7 > 0 and var_101_1 < var_101_7 then
					arg_98_1.talkMaxDuration = var_101_7

					if var_101_7 + var_101_0 > arg_98_1.duration_ then
						arg_98_1.duration_ = var_101_7 + var_101_0
					end
				end

				arg_98_1.text_.text = var_101_4
				arg_98_1.typewritter.percent = 0

				arg_98_1.typewritter:SetDirty()
				arg_98_1:ShowNextGo(false)
				arg_98_1:RecordContent(arg_98_1.text_.text)
			end

			local var_101_8 = math.max(var_101_1, arg_98_1.talkMaxDuration)

			if var_101_0 <= arg_98_1.time_ and arg_98_1.time_ < var_101_0 + var_101_8 then
				arg_98_1.typewritter.percent = (arg_98_1.time_ - var_101_0) / var_101_8

				arg_98_1.typewritter:SetDirty()
			end

			if arg_98_1.time_ >= var_101_0 + var_101_8 and arg_98_1.time_ < var_101_0 + var_101_8 + arg_101_0 then
				arg_98_1.typewritter.percent = 1

				arg_98_1.typewritter:SetDirty()
				arg_98_1:ShowNextGo(true)
			end
		end

		arg_98_1.nodeConfigList_ = {}

		arg_98_1:InitPlayNodeList()
	end,
	Play324541025 = function(arg_102_0, arg_102_1)
		arg_102_1.time_ = 0
		arg_102_1.frameCnt_ = 0
		arg_102_1.state_ = "playing"
		arg_102_1.curTalkId_ = 324541025
		arg_102_1.duration_ = 5

		SetActive(arg_102_1.tipsGo_, false)

		function arg_102_1.onSingleLineFinish_()
			arg_102_1.onSingleLineUpdate_ = nil
			arg_102_1.onSingleLineFinish_ = nil
			arg_102_1.state_ = "waiting"
		end

		function arg_102_1.playNext_(arg_104_0)
			if arg_104_0 == 1 then
				arg_102_0:Play324541026(arg_102_1)
			end
		end

		function arg_102_1.onSingleLineUpdate_(arg_105_0)
			local var_105_0 = 0
			local var_105_1 = 1.05

			if var_105_0 < arg_102_1.time_ and arg_102_1.time_ <= var_105_0 + arg_105_0 then
				arg_102_1.talkMaxDuration = 0
				arg_102_1.dialogCg_.alpha = 1

				arg_102_1.dialog_:SetActive(true)
				SetActive(arg_102_1.leftNameGo_, false)

				arg_102_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_102_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_102_1:RecordName(arg_102_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_102_1.iconTrs_.gameObject, false)
				arg_102_1.callingController_:SetSelectedState("normal")

				local var_105_2 = arg_102_1:GetWordFromCfg(324541025)
				local var_105_3 = arg_102_1:FormatText(var_105_2.content)

				arg_102_1.text_.text = var_105_3

				LuaForUtil.ClearLinePrefixSymbol(arg_102_1.text_)

				local var_105_4 = 42
				local var_105_5 = utf8.len(var_105_3)
				local var_105_6 = var_105_4 <= 0 and var_105_1 or var_105_1 * (var_105_5 / var_105_4)

				if var_105_6 > 0 and var_105_1 < var_105_6 then
					arg_102_1.talkMaxDuration = var_105_6

					if var_105_6 + var_105_0 > arg_102_1.duration_ then
						arg_102_1.duration_ = var_105_6 + var_105_0
					end
				end

				arg_102_1.text_.text = var_105_3
				arg_102_1.typewritter.percent = 0

				arg_102_1.typewritter:SetDirty()
				arg_102_1:ShowNextGo(false)
				arg_102_1:RecordContent(arg_102_1.text_.text)
			end

			local var_105_7 = math.max(var_105_1, arg_102_1.talkMaxDuration)

			if var_105_0 <= arg_102_1.time_ and arg_102_1.time_ < var_105_0 + var_105_7 then
				arg_102_1.typewritter.percent = (arg_102_1.time_ - var_105_0) / var_105_7

				arg_102_1.typewritter:SetDirty()
			end

			if arg_102_1.time_ >= var_105_0 + var_105_7 and arg_102_1.time_ < var_105_0 + var_105_7 + arg_105_0 then
				arg_102_1.typewritter.percent = 1

				arg_102_1.typewritter:SetDirty()
				arg_102_1:ShowNextGo(true)
			end
		end

		arg_102_1.nodeConfigList_ = {}

		arg_102_1:InitPlayNodeList()
	end,
	Play324541026 = function(arg_106_0, arg_106_1)
		arg_106_1.time_ = 0
		arg_106_1.frameCnt_ = 0
		arg_106_1.state_ = "playing"
		arg_106_1.curTalkId_ = 324541026
		arg_106_1.duration_ = 5

		SetActive(arg_106_1.tipsGo_, false)

		function arg_106_1.onSingleLineFinish_()
			arg_106_1.onSingleLineUpdate_ = nil
			arg_106_1.onSingleLineFinish_ = nil
			arg_106_1.state_ = "waiting"
		end

		function arg_106_1.playNext_(arg_108_0)
			if arg_108_0 == 1 then
				arg_106_0:Play324541027(arg_106_1)
			end
		end

		function arg_106_1.onSingleLineUpdate_(arg_109_0)
			local var_109_0 = 0
			local var_109_1 = 1.225

			if var_109_0 < arg_106_1.time_ and arg_106_1.time_ <= var_109_0 + arg_109_0 then
				arg_106_1.talkMaxDuration = 0
				arg_106_1.dialogCg_.alpha = 1

				arg_106_1.dialog_:SetActive(true)
				SetActive(arg_106_1.leftNameGo_, false)

				arg_106_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_106_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_106_1:RecordName(arg_106_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_106_1.iconTrs_.gameObject, false)
				arg_106_1.callingController_:SetSelectedState("normal")

				local var_109_2 = arg_106_1:GetWordFromCfg(324541026)
				local var_109_3 = arg_106_1:FormatText(var_109_2.content)

				arg_106_1.text_.text = var_109_3

				LuaForUtil.ClearLinePrefixSymbol(arg_106_1.text_)

				local var_109_4 = 49
				local var_109_5 = utf8.len(var_109_3)
				local var_109_6 = var_109_4 <= 0 and var_109_1 or var_109_1 * (var_109_5 / var_109_4)

				if var_109_6 > 0 and var_109_1 < var_109_6 then
					arg_106_1.talkMaxDuration = var_109_6

					if var_109_6 + var_109_0 > arg_106_1.duration_ then
						arg_106_1.duration_ = var_109_6 + var_109_0
					end
				end

				arg_106_1.text_.text = var_109_3
				arg_106_1.typewritter.percent = 0

				arg_106_1.typewritter:SetDirty()
				arg_106_1:ShowNextGo(false)
				arg_106_1:RecordContent(arg_106_1.text_.text)
			end

			local var_109_7 = math.max(var_109_1, arg_106_1.talkMaxDuration)

			if var_109_0 <= arg_106_1.time_ and arg_106_1.time_ < var_109_0 + var_109_7 then
				arg_106_1.typewritter.percent = (arg_106_1.time_ - var_109_0) / var_109_7

				arg_106_1.typewritter:SetDirty()
			end

			if arg_106_1.time_ >= var_109_0 + var_109_7 and arg_106_1.time_ < var_109_0 + var_109_7 + arg_109_0 then
				arg_106_1.typewritter.percent = 1

				arg_106_1.typewritter:SetDirty()
				arg_106_1:ShowNextGo(true)
			end
		end

		arg_106_1.nodeConfigList_ = {}

		arg_106_1:InitPlayNodeList()
	end,
	Play324541027 = function(arg_110_0, arg_110_1)
		arg_110_1.time_ = 0
		arg_110_1.frameCnt_ = 0
		arg_110_1.state_ = "playing"
		arg_110_1.curTalkId_ = 324541027
		arg_110_1.duration_ = 5

		SetActive(arg_110_1.tipsGo_, false)

		function arg_110_1.onSingleLineFinish_()
			arg_110_1.onSingleLineUpdate_ = nil
			arg_110_1.onSingleLineFinish_ = nil
			arg_110_1.state_ = "waiting"
		end

		function arg_110_1.playNext_(arg_112_0)
			if arg_112_0 == 1 then
				arg_110_0:Play324541028(arg_110_1)
			end
		end

		function arg_110_1.onSingleLineUpdate_(arg_113_0)
			local var_113_0 = 0
			local var_113_1 = 0.25

			if var_113_0 < arg_110_1.time_ and arg_110_1.time_ <= var_113_0 + arg_113_0 then
				arg_110_1.talkMaxDuration = 0
				arg_110_1.dialogCg_.alpha = 1

				arg_110_1.dialog_:SetActive(true)
				SetActive(arg_110_1.leftNameGo_, true)

				local var_113_2 = arg_110_1:FormatText(StoryNameCfg[7].name)

				arg_110_1.leftNameTxt_.text = var_113_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_110_1.leftNameTxt_.transform)

				arg_110_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_110_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_110_1:RecordName(arg_110_1.leftNameTxt_.text)
				SetActive(arg_110_1.iconTrs_.gameObject, true)
				arg_110_1.iconController_:SetSelectedState("hero")

				arg_110_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_110_1.callingController_:SetSelectedState("normal")

				arg_110_1.keyicon_.color = Color.New(1, 1, 1)
				arg_110_1.icon_.color = Color.New(1, 1, 1)

				local var_113_3 = arg_110_1:GetWordFromCfg(324541027)
				local var_113_4 = arg_110_1:FormatText(var_113_3.content)

				arg_110_1.text_.text = var_113_4

				LuaForUtil.ClearLinePrefixSymbol(arg_110_1.text_)

				local var_113_5 = 10
				local var_113_6 = utf8.len(var_113_4)
				local var_113_7 = var_113_5 <= 0 and var_113_1 or var_113_1 * (var_113_6 / var_113_5)

				if var_113_7 > 0 and var_113_1 < var_113_7 then
					arg_110_1.talkMaxDuration = var_113_7

					if var_113_7 + var_113_0 > arg_110_1.duration_ then
						arg_110_1.duration_ = var_113_7 + var_113_0
					end
				end

				arg_110_1.text_.text = var_113_4
				arg_110_1.typewritter.percent = 0

				arg_110_1.typewritter:SetDirty()
				arg_110_1:ShowNextGo(false)
				arg_110_1:RecordContent(arg_110_1.text_.text)
			end

			local var_113_8 = math.max(var_113_1, arg_110_1.talkMaxDuration)

			if var_113_0 <= arg_110_1.time_ and arg_110_1.time_ < var_113_0 + var_113_8 then
				arg_110_1.typewritter.percent = (arg_110_1.time_ - var_113_0) / var_113_8

				arg_110_1.typewritter:SetDirty()
			end

			if arg_110_1.time_ >= var_113_0 + var_113_8 and arg_110_1.time_ < var_113_0 + var_113_8 + arg_113_0 then
				arg_110_1.typewritter.percent = 1

				arg_110_1.typewritter:SetDirty()
				arg_110_1:ShowNextGo(true)
			end
		end

		arg_110_1.nodeConfigList_ = {}

		arg_110_1:InitPlayNodeList()
	end,
	Play324541028 = function(arg_114_0, arg_114_1)
		arg_114_1.time_ = 0
		arg_114_1.frameCnt_ = 0
		arg_114_1.state_ = "playing"
		arg_114_1.curTalkId_ = 324541028
		arg_114_1.duration_ = 5

		SetActive(arg_114_1.tipsGo_, false)

		function arg_114_1.onSingleLineFinish_()
			arg_114_1.onSingleLineUpdate_ = nil
			arg_114_1.onSingleLineFinish_ = nil
			arg_114_1.state_ = "waiting"
		end

		function arg_114_1.playNext_(arg_116_0)
			if arg_116_0 == 1 then
				arg_114_0:Play324541029(arg_114_1)
			end
		end

		function arg_114_1.onSingleLineUpdate_(arg_117_0)
			local var_117_0 = 0
			local var_117_1 = 1.45

			if var_117_0 < arg_114_1.time_ and arg_114_1.time_ <= var_117_0 + arg_117_0 then
				arg_114_1.talkMaxDuration = 0
				arg_114_1.dialogCg_.alpha = 1

				arg_114_1.dialog_:SetActive(true)
				SetActive(arg_114_1.leftNameGo_, false)

				arg_114_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_114_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_114_1:RecordName(arg_114_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_114_1.iconTrs_.gameObject, false)
				arg_114_1.callingController_:SetSelectedState("normal")

				local var_117_2 = arg_114_1:GetWordFromCfg(324541028)
				local var_117_3 = arg_114_1:FormatText(var_117_2.content)

				arg_114_1.text_.text = var_117_3

				LuaForUtil.ClearLinePrefixSymbol(arg_114_1.text_)

				local var_117_4 = 58
				local var_117_5 = utf8.len(var_117_3)
				local var_117_6 = var_117_4 <= 0 and var_117_1 or var_117_1 * (var_117_5 / var_117_4)

				if var_117_6 > 0 and var_117_1 < var_117_6 then
					arg_114_1.talkMaxDuration = var_117_6

					if var_117_6 + var_117_0 > arg_114_1.duration_ then
						arg_114_1.duration_ = var_117_6 + var_117_0
					end
				end

				arg_114_1.text_.text = var_117_3
				arg_114_1.typewritter.percent = 0

				arg_114_1.typewritter:SetDirty()
				arg_114_1:ShowNextGo(false)
				arg_114_1:RecordContent(arg_114_1.text_.text)
			end

			local var_117_7 = math.max(var_117_1, arg_114_1.talkMaxDuration)

			if var_117_0 <= arg_114_1.time_ and arg_114_1.time_ < var_117_0 + var_117_7 then
				arg_114_1.typewritter.percent = (arg_114_1.time_ - var_117_0) / var_117_7

				arg_114_1.typewritter:SetDirty()
			end

			if arg_114_1.time_ >= var_117_0 + var_117_7 and arg_114_1.time_ < var_117_0 + var_117_7 + arg_117_0 then
				arg_114_1.typewritter.percent = 1

				arg_114_1.typewritter:SetDirty()
				arg_114_1:ShowNextGo(true)
			end
		end

		arg_114_1.nodeConfigList_ = {}

		arg_114_1:InitPlayNodeList()
	end,
	Play324541029 = function(arg_118_0, arg_118_1)
		arg_118_1.time_ = 0
		arg_118_1.frameCnt_ = 0
		arg_118_1.state_ = "playing"
		arg_118_1.curTalkId_ = 324541029
		arg_118_1.duration_ = 5

		SetActive(arg_118_1.tipsGo_, false)

		function arg_118_1.onSingleLineFinish_()
			arg_118_1.onSingleLineUpdate_ = nil
			arg_118_1.onSingleLineFinish_ = nil
			arg_118_1.state_ = "waiting"
		end

		function arg_118_1.playNext_(arg_120_0)
			if arg_120_0 == 1 then
				arg_118_0:Play324541030(arg_118_1)
			end
		end

		function arg_118_1.onSingleLineUpdate_(arg_121_0)
			local var_121_0 = 0
			local var_121_1 = 1.1

			if var_121_0 < arg_118_1.time_ and arg_118_1.time_ <= var_121_0 + arg_121_0 then
				arg_118_1.talkMaxDuration = 0
				arg_118_1.dialogCg_.alpha = 1

				arg_118_1.dialog_:SetActive(true)
				SetActive(arg_118_1.leftNameGo_, false)

				arg_118_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_118_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_118_1:RecordName(arg_118_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_118_1.iconTrs_.gameObject, false)
				arg_118_1.callingController_:SetSelectedState("normal")

				local var_121_2 = arg_118_1:GetWordFromCfg(324541029)
				local var_121_3 = arg_118_1:FormatText(var_121_2.content)

				arg_118_1.text_.text = var_121_3

				LuaForUtil.ClearLinePrefixSymbol(arg_118_1.text_)

				local var_121_4 = 44
				local var_121_5 = utf8.len(var_121_3)
				local var_121_6 = var_121_4 <= 0 and var_121_1 or var_121_1 * (var_121_5 / var_121_4)

				if var_121_6 > 0 and var_121_1 < var_121_6 then
					arg_118_1.talkMaxDuration = var_121_6

					if var_121_6 + var_121_0 > arg_118_1.duration_ then
						arg_118_1.duration_ = var_121_6 + var_121_0
					end
				end

				arg_118_1.text_.text = var_121_3
				arg_118_1.typewritter.percent = 0

				arg_118_1.typewritter:SetDirty()
				arg_118_1:ShowNextGo(false)
				arg_118_1:RecordContent(arg_118_1.text_.text)
			end

			local var_121_7 = math.max(var_121_1, arg_118_1.talkMaxDuration)

			if var_121_0 <= arg_118_1.time_ and arg_118_1.time_ < var_121_0 + var_121_7 then
				arg_118_1.typewritter.percent = (arg_118_1.time_ - var_121_0) / var_121_7

				arg_118_1.typewritter:SetDirty()
			end

			if arg_118_1.time_ >= var_121_0 + var_121_7 and arg_118_1.time_ < var_121_0 + var_121_7 + arg_121_0 then
				arg_118_1.typewritter.percent = 1

				arg_118_1.typewritter:SetDirty()
				arg_118_1:ShowNextGo(true)
			end
		end

		arg_118_1.nodeConfigList_ = {}

		arg_118_1:InitPlayNodeList()
	end,
	Play324541030 = function(arg_122_0, arg_122_1)
		arg_122_1.time_ = 0
		arg_122_1.frameCnt_ = 0
		arg_122_1.state_ = "playing"
		arg_122_1.curTalkId_ = 324541030
		arg_122_1.duration_ = 5

		SetActive(arg_122_1.tipsGo_, false)

		function arg_122_1.onSingleLineFinish_()
			arg_122_1.onSingleLineUpdate_ = nil
			arg_122_1.onSingleLineFinish_ = nil
			arg_122_1.state_ = "waiting"
		end

		function arg_122_1.playNext_(arg_124_0)
			if arg_124_0 == 1 then
				arg_122_0:Play324541031(arg_122_1)
			end
		end

		function arg_122_1.onSingleLineUpdate_(arg_125_0)
			local var_125_0 = 0
			local var_125_1 = 1.375

			if var_125_0 < arg_122_1.time_ and arg_122_1.time_ <= var_125_0 + arg_125_0 then
				arg_122_1.talkMaxDuration = 0
				arg_122_1.dialogCg_.alpha = 1

				arg_122_1.dialog_:SetActive(true)
				SetActive(arg_122_1.leftNameGo_, false)

				arg_122_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_122_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_122_1:RecordName(arg_122_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_122_1.iconTrs_.gameObject, false)
				arg_122_1.callingController_:SetSelectedState("normal")

				local var_125_2 = arg_122_1:GetWordFromCfg(324541030)
				local var_125_3 = arg_122_1:FormatText(var_125_2.content)

				arg_122_1.text_.text = var_125_3

				LuaForUtil.ClearLinePrefixSymbol(arg_122_1.text_)

				local var_125_4 = 55
				local var_125_5 = utf8.len(var_125_3)
				local var_125_6 = var_125_4 <= 0 and var_125_1 or var_125_1 * (var_125_5 / var_125_4)

				if var_125_6 > 0 and var_125_1 < var_125_6 then
					arg_122_1.talkMaxDuration = var_125_6

					if var_125_6 + var_125_0 > arg_122_1.duration_ then
						arg_122_1.duration_ = var_125_6 + var_125_0
					end
				end

				arg_122_1.text_.text = var_125_3
				arg_122_1.typewritter.percent = 0

				arg_122_1.typewritter:SetDirty()
				arg_122_1:ShowNextGo(false)
				arg_122_1:RecordContent(arg_122_1.text_.text)
			end

			local var_125_7 = math.max(var_125_1, arg_122_1.talkMaxDuration)

			if var_125_0 <= arg_122_1.time_ and arg_122_1.time_ < var_125_0 + var_125_7 then
				arg_122_1.typewritter.percent = (arg_122_1.time_ - var_125_0) / var_125_7

				arg_122_1.typewritter:SetDirty()
			end

			if arg_122_1.time_ >= var_125_0 + var_125_7 and arg_122_1.time_ < var_125_0 + var_125_7 + arg_125_0 then
				arg_122_1.typewritter.percent = 1

				arg_122_1.typewritter:SetDirty()
				arg_122_1:ShowNextGo(true)
			end
		end

		arg_122_1.nodeConfigList_ = {}

		arg_122_1:InitPlayNodeList()
	end,
	Play324541031 = function(arg_126_0, arg_126_1)
		arg_126_1.time_ = 0
		arg_126_1.frameCnt_ = 0
		arg_126_1.state_ = "playing"
		arg_126_1.curTalkId_ = 324541031
		arg_126_1.duration_ = 5

		SetActive(arg_126_1.tipsGo_, false)

		function arg_126_1.onSingleLineFinish_()
			arg_126_1.onSingleLineUpdate_ = nil
			arg_126_1.onSingleLineFinish_ = nil
			arg_126_1.state_ = "waiting"
		end

		function arg_126_1.playNext_(arg_128_0)
			if arg_128_0 == 1 then
				arg_126_0:Play324541032(arg_126_1)
			end
		end

		function arg_126_1.onSingleLineUpdate_(arg_129_0)
			local var_129_0 = 0
			local var_129_1 = 0.4

			if var_129_0 < arg_126_1.time_ and arg_126_1.time_ <= var_129_0 + arg_129_0 then
				arg_126_1.talkMaxDuration = 0
				arg_126_1.dialogCg_.alpha = 1

				arg_126_1.dialog_:SetActive(true)
				SetActive(arg_126_1.leftNameGo_, true)

				local var_129_2 = arg_126_1:FormatText(StoryNameCfg[7].name)

				arg_126_1.leftNameTxt_.text = var_129_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_126_1.leftNameTxt_.transform)

				arg_126_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_126_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_126_1:RecordName(arg_126_1.leftNameTxt_.text)
				SetActive(arg_126_1.iconTrs_.gameObject, true)
				arg_126_1.iconController_:SetSelectedState("hero")

				arg_126_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_126_1.callingController_:SetSelectedState("normal")

				arg_126_1.keyicon_.color = Color.New(1, 1, 1)
				arg_126_1.icon_.color = Color.New(1, 1, 1)

				local var_129_3 = arg_126_1:GetWordFromCfg(324541031)
				local var_129_4 = arg_126_1:FormatText(var_129_3.content)

				arg_126_1.text_.text = var_129_4

				LuaForUtil.ClearLinePrefixSymbol(arg_126_1.text_)

				local var_129_5 = 16
				local var_129_6 = utf8.len(var_129_4)
				local var_129_7 = var_129_5 <= 0 and var_129_1 or var_129_1 * (var_129_6 / var_129_5)

				if var_129_7 > 0 and var_129_1 < var_129_7 then
					arg_126_1.talkMaxDuration = var_129_7

					if var_129_7 + var_129_0 > arg_126_1.duration_ then
						arg_126_1.duration_ = var_129_7 + var_129_0
					end
				end

				arg_126_1.text_.text = var_129_4
				arg_126_1.typewritter.percent = 0

				arg_126_1.typewritter:SetDirty()
				arg_126_1:ShowNextGo(false)
				arg_126_1:RecordContent(arg_126_1.text_.text)
			end

			local var_129_8 = math.max(var_129_1, arg_126_1.talkMaxDuration)

			if var_129_0 <= arg_126_1.time_ and arg_126_1.time_ < var_129_0 + var_129_8 then
				arg_126_1.typewritter.percent = (arg_126_1.time_ - var_129_0) / var_129_8

				arg_126_1.typewritter:SetDirty()
			end

			if arg_126_1.time_ >= var_129_0 + var_129_8 and arg_126_1.time_ < var_129_0 + var_129_8 + arg_129_0 then
				arg_126_1.typewritter.percent = 1

				arg_126_1.typewritter:SetDirty()
				arg_126_1:ShowNextGo(true)
			end
		end

		arg_126_1.nodeConfigList_ = {}

		arg_126_1:InitPlayNodeList()
	end,
	Play324541032 = function(arg_130_0, arg_130_1)
		arg_130_1.time_ = 0
		arg_130_1.frameCnt_ = 0
		arg_130_1.state_ = "playing"
		arg_130_1.curTalkId_ = 324541032
		arg_130_1.duration_ = 5

		SetActive(arg_130_1.tipsGo_, false)

		function arg_130_1.onSingleLineFinish_()
			arg_130_1.onSingleLineUpdate_ = nil
			arg_130_1.onSingleLineFinish_ = nil
			arg_130_1.state_ = "waiting"
		end

		function arg_130_1.playNext_(arg_132_0)
			if arg_132_0 == 1 then
				arg_130_0:Play324541033(arg_130_1)
			end
		end

		function arg_130_1.onSingleLineUpdate_(arg_133_0)
			local var_133_0 = 0
			local var_133_1 = 1.2

			if var_133_0 < arg_130_1.time_ and arg_130_1.time_ <= var_133_0 + arg_133_0 then
				arg_130_1.talkMaxDuration = 0
				arg_130_1.dialogCg_.alpha = 1

				arg_130_1.dialog_:SetActive(true)
				SetActive(arg_130_1.leftNameGo_, false)

				arg_130_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_130_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_130_1:RecordName(arg_130_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_130_1.iconTrs_.gameObject, false)
				arg_130_1.callingController_:SetSelectedState("normal")

				local var_133_2 = arg_130_1:GetWordFromCfg(324541032)
				local var_133_3 = arg_130_1:FormatText(var_133_2.content)

				arg_130_1.text_.text = var_133_3

				LuaForUtil.ClearLinePrefixSymbol(arg_130_1.text_)

				local var_133_4 = 48
				local var_133_5 = utf8.len(var_133_3)
				local var_133_6 = var_133_4 <= 0 and var_133_1 or var_133_1 * (var_133_5 / var_133_4)

				if var_133_6 > 0 and var_133_1 < var_133_6 then
					arg_130_1.talkMaxDuration = var_133_6

					if var_133_6 + var_133_0 > arg_130_1.duration_ then
						arg_130_1.duration_ = var_133_6 + var_133_0
					end
				end

				arg_130_1.text_.text = var_133_3
				arg_130_1.typewritter.percent = 0

				arg_130_1.typewritter:SetDirty()
				arg_130_1:ShowNextGo(false)
				arg_130_1:RecordContent(arg_130_1.text_.text)
			end

			local var_133_7 = math.max(var_133_1, arg_130_1.talkMaxDuration)

			if var_133_0 <= arg_130_1.time_ and arg_130_1.time_ < var_133_0 + var_133_7 then
				arg_130_1.typewritter.percent = (arg_130_1.time_ - var_133_0) / var_133_7

				arg_130_1.typewritter:SetDirty()
			end

			if arg_130_1.time_ >= var_133_0 + var_133_7 and arg_130_1.time_ < var_133_0 + var_133_7 + arg_133_0 then
				arg_130_1.typewritter.percent = 1

				arg_130_1.typewritter:SetDirty()
				arg_130_1:ShowNextGo(true)
			end
		end

		arg_130_1.nodeConfigList_ = {}

		arg_130_1:InitPlayNodeList()
	end,
	Play324541033 = function(arg_134_0, arg_134_1)
		arg_134_1.time_ = 0
		arg_134_1.frameCnt_ = 0
		arg_134_1.state_ = "playing"
		arg_134_1.curTalkId_ = 324541033
		arg_134_1.duration_ = 5

		SetActive(arg_134_1.tipsGo_, false)

		function arg_134_1.onSingleLineFinish_()
			arg_134_1.onSingleLineUpdate_ = nil
			arg_134_1.onSingleLineFinish_ = nil
			arg_134_1.state_ = "waiting"
		end

		function arg_134_1.playNext_(arg_136_0)
			if arg_136_0 == 1 then
				arg_134_0:Play324541034(arg_134_1)
			end
		end

		function arg_134_1.onSingleLineUpdate_(arg_137_0)
			local var_137_0 = 0
			local var_137_1 = 0.225

			if var_137_0 < arg_134_1.time_ and arg_134_1.time_ <= var_137_0 + arg_137_0 then
				arg_134_1.talkMaxDuration = 0
				arg_134_1.dialogCg_.alpha = 1

				arg_134_1.dialog_:SetActive(true)
				SetActive(arg_134_1.leftNameGo_, true)

				local var_137_2 = arg_134_1:FormatText(StoryNameCfg[7].name)

				arg_134_1.leftNameTxt_.text = var_137_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_134_1.leftNameTxt_.transform)

				arg_134_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_134_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_134_1:RecordName(arg_134_1.leftNameTxt_.text)
				SetActive(arg_134_1.iconTrs_.gameObject, true)
				arg_134_1.iconController_:SetSelectedState("hero")

				arg_134_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_134_1.callingController_:SetSelectedState("normal")

				arg_134_1.keyicon_.color = Color.New(1, 1, 1)
				arg_134_1.icon_.color = Color.New(1, 1, 1)

				local var_137_3 = arg_134_1:GetWordFromCfg(324541033)
				local var_137_4 = arg_134_1:FormatText(var_137_3.content)

				arg_134_1.text_.text = var_137_4

				LuaForUtil.ClearLinePrefixSymbol(arg_134_1.text_)

				local var_137_5 = 9
				local var_137_6 = utf8.len(var_137_4)
				local var_137_7 = var_137_5 <= 0 and var_137_1 or var_137_1 * (var_137_6 / var_137_5)

				if var_137_7 > 0 and var_137_1 < var_137_7 then
					arg_134_1.talkMaxDuration = var_137_7

					if var_137_7 + var_137_0 > arg_134_1.duration_ then
						arg_134_1.duration_ = var_137_7 + var_137_0
					end
				end

				arg_134_1.text_.text = var_137_4
				arg_134_1.typewritter.percent = 0

				arg_134_1.typewritter:SetDirty()
				arg_134_1:ShowNextGo(false)
				arg_134_1:RecordContent(arg_134_1.text_.text)
			end

			local var_137_8 = math.max(var_137_1, arg_134_1.talkMaxDuration)

			if var_137_0 <= arg_134_1.time_ and arg_134_1.time_ < var_137_0 + var_137_8 then
				arg_134_1.typewritter.percent = (arg_134_1.time_ - var_137_0) / var_137_8

				arg_134_1.typewritter:SetDirty()
			end

			if arg_134_1.time_ >= var_137_0 + var_137_8 and arg_134_1.time_ < var_137_0 + var_137_8 + arg_137_0 then
				arg_134_1.typewritter.percent = 1

				arg_134_1.typewritter:SetDirty()
				arg_134_1:ShowNextGo(true)
			end
		end

		arg_134_1.nodeConfigList_ = {}

		arg_134_1:InitPlayNodeList()
	end,
	Play324541034 = function(arg_138_0, arg_138_1)
		arg_138_1.time_ = 0
		arg_138_1.frameCnt_ = 0
		arg_138_1.state_ = "playing"
		arg_138_1.curTalkId_ = 324541034
		arg_138_1.duration_ = 5

		SetActive(arg_138_1.tipsGo_, false)

		function arg_138_1.onSingleLineFinish_()
			arg_138_1.onSingleLineUpdate_ = nil
			arg_138_1.onSingleLineFinish_ = nil
			arg_138_1.state_ = "waiting"
		end

		function arg_138_1.playNext_(arg_140_0)
			if arg_140_0 == 1 then
				arg_138_0:Play324541035(arg_138_1)
			end
		end

		function arg_138_1.onSingleLineUpdate_(arg_141_0)
			local var_141_0 = 0
			local var_141_1 = 0.45

			if var_141_0 < arg_138_1.time_ and arg_138_1.time_ <= var_141_0 + arg_141_0 then
				arg_138_1.talkMaxDuration = 0
				arg_138_1.dialogCg_.alpha = 1

				arg_138_1.dialog_:SetActive(true)
				SetActive(arg_138_1.leftNameGo_, true)

				local var_141_2 = arg_138_1:FormatText(StoryNameCfg[7].name)

				arg_138_1.leftNameTxt_.text = var_141_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_138_1.leftNameTxt_.transform)

				arg_138_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_138_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_138_1:RecordName(arg_138_1.leftNameTxt_.text)
				SetActive(arg_138_1.iconTrs_.gameObject, true)
				arg_138_1.iconController_:SetSelectedState("hero")

				arg_138_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_138_1.callingController_:SetSelectedState("normal")

				arg_138_1.keyicon_.color = Color.New(1, 1, 1)
				arg_138_1.icon_.color = Color.New(1, 1, 1)

				local var_141_3 = arg_138_1:GetWordFromCfg(324541034)
				local var_141_4 = arg_138_1:FormatText(var_141_3.content)

				arg_138_1.text_.text = var_141_4

				LuaForUtil.ClearLinePrefixSymbol(arg_138_1.text_)

				local var_141_5 = 18
				local var_141_6 = utf8.len(var_141_4)
				local var_141_7 = var_141_5 <= 0 and var_141_1 or var_141_1 * (var_141_6 / var_141_5)

				if var_141_7 > 0 and var_141_1 < var_141_7 then
					arg_138_1.talkMaxDuration = var_141_7

					if var_141_7 + var_141_0 > arg_138_1.duration_ then
						arg_138_1.duration_ = var_141_7 + var_141_0
					end
				end

				arg_138_1.text_.text = var_141_4
				arg_138_1.typewritter.percent = 0

				arg_138_1.typewritter:SetDirty()
				arg_138_1:ShowNextGo(false)
				arg_138_1:RecordContent(arg_138_1.text_.text)
			end

			local var_141_8 = math.max(var_141_1, arg_138_1.talkMaxDuration)

			if var_141_0 <= arg_138_1.time_ and arg_138_1.time_ < var_141_0 + var_141_8 then
				arg_138_1.typewritter.percent = (arg_138_1.time_ - var_141_0) / var_141_8

				arg_138_1.typewritter:SetDirty()
			end

			if arg_138_1.time_ >= var_141_0 + var_141_8 and arg_138_1.time_ < var_141_0 + var_141_8 + arg_141_0 then
				arg_138_1.typewritter.percent = 1

				arg_138_1.typewritter:SetDirty()
				arg_138_1:ShowNextGo(true)
			end
		end

		arg_138_1.nodeConfigList_ = {}

		arg_138_1:InitPlayNodeList()
	end,
	Play324541035 = function(arg_142_0, arg_142_1)
		arg_142_1.time_ = 0
		arg_142_1.frameCnt_ = 0
		arg_142_1.state_ = "playing"
		arg_142_1.curTalkId_ = 324541035
		arg_142_1.duration_ = 5

		SetActive(arg_142_1.tipsGo_, false)

		function arg_142_1.onSingleLineFinish_()
			arg_142_1.onSingleLineUpdate_ = nil
			arg_142_1.onSingleLineFinish_ = nil
			arg_142_1.state_ = "waiting"
		end

		function arg_142_1.playNext_(arg_144_0)
			if arg_144_0 == 1 then
				arg_142_0:Play324541036(arg_142_1)
			end
		end

		function arg_142_1.onSingleLineUpdate_(arg_145_0)
			local var_145_0 = 0
			local var_145_1 = 1.35

			if var_145_0 < arg_142_1.time_ and arg_142_1.time_ <= var_145_0 + arg_145_0 then
				arg_142_1.talkMaxDuration = 0
				arg_142_1.dialogCg_.alpha = 1

				arg_142_1.dialog_:SetActive(true)
				SetActive(arg_142_1.leftNameGo_, false)

				arg_142_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_142_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_142_1:RecordName(arg_142_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_142_1.iconTrs_.gameObject, false)
				arg_142_1.callingController_:SetSelectedState("normal")

				local var_145_2 = arg_142_1:GetWordFromCfg(324541035)
				local var_145_3 = arg_142_1:FormatText(var_145_2.content)

				arg_142_1.text_.text = var_145_3

				LuaForUtil.ClearLinePrefixSymbol(arg_142_1.text_)

				local var_145_4 = 54
				local var_145_5 = utf8.len(var_145_3)
				local var_145_6 = var_145_4 <= 0 and var_145_1 or var_145_1 * (var_145_5 / var_145_4)

				if var_145_6 > 0 and var_145_1 < var_145_6 then
					arg_142_1.talkMaxDuration = var_145_6

					if var_145_6 + var_145_0 > arg_142_1.duration_ then
						arg_142_1.duration_ = var_145_6 + var_145_0
					end
				end

				arg_142_1.text_.text = var_145_3
				arg_142_1.typewritter.percent = 0

				arg_142_1.typewritter:SetDirty()
				arg_142_1:ShowNextGo(false)
				arg_142_1:RecordContent(arg_142_1.text_.text)
			end

			local var_145_7 = math.max(var_145_1, arg_142_1.talkMaxDuration)

			if var_145_0 <= arg_142_1.time_ and arg_142_1.time_ < var_145_0 + var_145_7 then
				arg_142_1.typewritter.percent = (arg_142_1.time_ - var_145_0) / var_145_7

				arg_142_1.typewritter:SetDirty()
			end

			if arg_142_1.time_ >= var_145_0 + var_145_7 and arg_142_1.time_ < var_145_0 + var_145_7 + arg_145_0 then
				arg_142_1.typewritter.percent = 1

				arg_142_1.typewritter:SetDirty()
				arg_142_1:ShowNextGo(true)
			end
		end

		arg_142_1.nodeConfigList_ = {}

		arg_142_1:InitPlayNodeList()
	end,
	Play324541036 = function(arg_146_0, arg_146_1)
		arg_146_1.time_ = 0
		arg_146_1.frameCnt_ = 0
		arg_146_1.state_ = "playing"
		arg_146_1.curTalkId_ = 324541036
		arg_146_1.duration_ = 5

		SetActive(arg_146_1.tipsGo_, false)

		function arg_146_1.onSingleLineFinish_()
			arg_146_1.onSingleLineUpdate_ = nil
			arg_146_1.onSingleLineFinish_ = nil
			arg_146_1.state_ = "waiting"
		end

		function arg_146_1.playNext_(arg_148_0)
			if arg_148_0 == 1 then
				arg_146_0:Play324541037(arg_146_1)
			end
		end

		function arg_146_1.onSingleLineUpdate_(arg_149_0)
			local var_149_0 = 0
			local var_149_1 = 1.675

			if var_149_0 < arg_146_1.time_ and arg_146_1.time_ <= var_149_0 + arg_149_0 then
				arg_146_1.talkMaxDuration = 0
				arg_146_1.dialogCg_.alpha = 1

				arg_146_1.dialog_:SetActive(true)
				SetActive(arg_146_1.leftNameGo_, false)

				arg_146_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_146_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_146_1:RecordName(arg_146_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_146_1.iconTrs_.gameObject, false)
				arg_146_1.callingController_:SetSelectedState("normal")

				local var_149_2 = arg_146_1:GetWordFromCfg(324541036)
				local var_149_3 = arg_146_1:FormatText(var_149_2.content)

				arg_146_1.text_.text = var_149_3

				LuaForUtil.ClearLinePrefixSymbol(arg_146_1.text_)

				local var_149_4 = 67
				local var_149_5 = utf8.len(var_149_3)
				local var_149_6 = var_149_4 <= 0 and var_149_1 or var_149_1 * (var_149_5 / var_149_4)

				if var_149_6 > 0 and var_149_1 < var_149_6 then
					arg_146_1.talkMaxDuration = var_149_6

					if var_149_6 + var_149_0 > arg_146_1.duration_ then
						arg_146_1.duration_ = var_149_6 + var_149_0
					end
				end

				arg_146_1.text_.text = var_149_3
				arg_146_1.typewritter.percent = 0

				arg_146_1.typewritter:SetDirty()
				arg_146_1:ShowNextGo(false)
				arg_146_1:RecordContent(arg_146_1.text_.text)
			end

			local var_149_7 = math.max(var_149_1, arg_146_1.talkMaxDuration)

			if var_149_0 <= arg_146_1.time_ and arg_146_1.time_ < var_149_0 + var_149_7 then
				arg_146_1.typewritter.percent = (arg_146_1.time_ - var_149_0) / var_149_7

				arg_146_1.typewritter:SetDirty()
			end

			if arg_146_1.time_ >= var_149_0 + var_149_7 and arg_146_1.time_ < var_149_0 + var_149_7 + arg_149_0 then
				arg_146_1.typewritter.percent = 1

				arg_146_1.typewritter:SetDirty()
				arg_146_1:ShowNextGo(true)
			end
		end

		arg_146_1.nodeConfigList_ = {}

		arg_146_1:InitPlayNodeList()
	end,
	Play324541037 = function(arg_150_0, arg_150_1)
		arg_150_1.time_ = 0
		arg_150_1.frameCnt_ = 0
		arg_150_1.state_ = "playing"
		arg_150_1.curTalkId_ = 324541037
		arg_150_1.duration_ = 5

		SetActive(arg_150_1.tipsGo_, false)

		function arg_150_1.onSingleLineFinish_()
			arg_150_1.onSingleLineUpdate_ = nil
			arg_150_1.onSingleLineFinish_ = nil
			arg_150_1.state_ = "waiting"
		end

		function arg_150_1.playNext_(arg_152_0)
			if arg_152_0 == 1 then
				arg_150_0:Play324541038(arg_150_1)
			end
		end

		function arg_150_1.onSingleLineUpdate_(arg_153_0)
			local var_153_0 = 0
			local var_153_1 = 1.3

			if var_153_0 < arg_150_1.time_ and arg_150_1.time_ <= var_153_0 + arg_153_0 then
				arg_150_1.talkMaxDuration = 0
				arg_150_1.dialogCg_.alpha = 1

				arg_150_1.dialog_:SetActive(true)
				SetActive(arg_150_1.leftNameGo_, false)

				arg_150_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_150_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_150_1:RecordName(arg_150_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_150_1.iconTrs_.gameObject, false)
				arg_150_1.callingController_:SetSelectedState("normal")

				local var_153_2 = arg_150_1:GetWordFromCfg(324541037)
				local var_153_3 = arg_150_1:FormatText(var_153_2.content)

				arg_150_1.text_.text = var_153_3

				LuaForUtil.ClearLinePrefixSymbol(arg_150_1.text_)

				local var_153_4 = 52
				local var_153_5 = utf8.len(var_153_3)
				local var_153_6 = var_153_4 <= 0 and var_153_1 or var_153_1 * (var_153_5 / var_153_4)

				if var_153_6 > 0 and var_153_1 < var_153_6 then
					arg_150_1.talkMaxDuration = var_153_6

					if var_153_6 + var_153_0 > arg_150_1.duration_ then
						arg_150_1.duration_ = var_153_6 + var_153_0
					end
				end

				arg_150_1.text_.text = var_153_3
				arg_150_1.typewritter.percent = 0

				arg_150_1.typewritter:SetDirty()
				arg_150_1:ShowNextGo(false)
				arg_150_1:RecordContent(arg_150_1.text_.text)
			end

			local var_153_7 = math.max(var_153_1, arg_150_1.talkMaxDuration)

			if var_153_0 <= arg_150_1.time_ and arg_150_1.time_ < var_153_0 + var_153_7 then
				arg_150_1.typewritter.percent = (arg_150_1.time_ - var_153_0) / var_153_7

				arg_150_1.typewritter:SetDirty()
			end

			if arg_150_1.time_ >= var_153_0 + var_153_7 and arg_150_1.time_ < var_153_0 + var_153_7 + arg_153_0 then
				arg_150_1.typewritter.percent = 1

				arg_150_1.typewritter:SetDirty()
				arg_150_1:ShowNextGo(true)
			end
		end

		arg_150_1.nodeConfigList_ = {}

		arg_150_1:InitPlayNodeList()
	end,
	Play324541038 = function(arg_154_0, arg_154_1)
		arg_154_1.time_ = 0
		arg_154_1.frameCnt_ = 0
		arg_154_1.state_ = "playing"
		arg_154_1.curTalkId_ = 324541038
		arg_154_1.duration_ = 5

		SetActive(arg_154_1.tipsGo_, false)

		function arg_154_1.onSingleLineFinish_()
			arg_154_1.onSingleLineUpdate_ = nil
			arg_154_1.onSingleLineFinish_ = nil
			arg_154_1.state_ = "waiting"
		end

		function arg_154_1.playNext_(arg_156_0)
			if arg_156_0 == 1 then
				arg_154_0:Play324541039(arg_154_1)
			end
		end

		function arg_154_1.onSingleLineUpdate_(arg_157_0)
			local var_157_0 = 0
			local var_157_1 = 0.225

			if var_157_0 < arg_154_1.time_ and arg_154_1.time_ <= var_157_0 + arg_157_0 then
				arg_154_1.talkMaxDuration = 0
				arg_154_1.dialogCg_.alpha = 1

				arg_154_1.dialog_:SetActive(true)
				SetActive(arg_154_1.leftNameGo_, true)

				local var_157_2 = arg_154_1:FormatText(StoryNameCfg[7].name)

				arg_154_1.leftNameTxt_.text = var_157_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_154_1.leftNameTxt_.transform)

				arg_154_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_154_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_154_1:RecordName(arg_154_1.leftNameTxt_.text)
				SetActive(arg_154_1.iconTrs_.gameObject, true)
				arg_154_1.iconController_:SetSelectedState("hero")

				arg_154_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_154_1.callingController_:SetSelectedState("normal")

				arg_154_1.keyicon_.color = Color.New(1, 1, 1)
				arg_154_1.icon_.color = Color.New(1, 1, 1)

				local var_157_3 = arg_154_1:GetWordFromCfg(324541038)
				local var_157_4 = arg_154_1:FormatText(var_157_3.content)

				arg_154_1.text_.text = var_157_4

				LuaForUtil.ClearLinePrefixSymbol(arg_154_1.text_)

				local var_157_5 = 9
				local var_157_6 = utf8.len(var_157_4)
				local var_157_7 = var_157_5 <= 0 and var_157_1 or var_157_1 * (var_157_6 / var_157_5)

				if var_157_7 > 0 and var_157_1 < var_157_7 then
					arg_154_1.talkMaxDuration = var_157_7

					if var_157_7 + var_157_0 > arg_154_1.duration_ then
						arg_154_1.duration_ = var_157_7 + var_157_0
					end
				end

				arg_154_1.text_.text = var_157_4
				arg_154_1.typewritter.percent = 0

				arg_154_1.typewritter:SetDirty()
				arg_154_1:ShowNextGo(false)
				arg_154_1:RecordContent(arg_154_1.text_.text)
			end

			local var_157_8 = math.max(var_157_1, arg_154_1.talkMaxDuration)

			if var_157_0 <= arg_154_1.time_ and arg_154_1.time_ < var_157_0 + var_157_8 then
				arg_154_1.typewritter.percent = (arg_154_1.time_ - var_157_0) / var_157_8

				arg_154_1.typewritter:SetDirty()
			end

			if arg_154_1.time_ >= var_157_0 + var_157_8 and arg_154_1.time_ < var_157_0 + var_157_8 + arg_157_0 then
				arg_154_1.typewritter.percent = 1

				arg_154_1.typewritter:SetDirty()
				arg_154_1:ShowNextGo(true)
			end
		end

		arg_154_1.nodeConfigList_ = {}

		arg_154_1:InitPlayNodeList()
	end,
	Play324541039 = function(arg_158_0, arg_158_1)
		arg_158_1.time_ = 0
		arg_158_1.frameCnt_ = 0
		arg_158_1.state_ = "playing"
		arg_158_1.curTalkId_ = 324541039
		arg_158_1.duration_ = 5

		SetActive(arg_158_1.tipsGo_, false)

		function arg_158_1.onSingleLineFinish_()
			arg_158_1.onSingleLineUpdate_ = nil
			arg_158_1.onSingleLineFinish_ = nil
			arg_158_1.state_ = "waiting"
		end

		function arg_158_1.playNext_(arg_160_0)
			if arg_160_0 == 1 then
				arg_158_0:Play324541040(arg_158_1)
			end
		end

		function arg_158_1.onSingleLineUpdate_(arg_161_0)
			local var_161_0 = 0
			local var_161_1 = 0.85

			if var_161_0 < arg_158_1.time_ and arg_158_1.time_ <= var_161_0 + arg_161_0 then
				arg_158_1.talkMaxDuration = 0
				arg_158_1.dialogCg_.alpha = 1

				arg_158_1.dialog_:SetActive(true)
				SetActive(arg_158_1.leftNameGo_, false)

				arg_158_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_158_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_158_1:RecordName(arg_158_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_158_1.iconTrs_.gameObject, false)
				arg_158_1.callingController_:SetSelectedState("normal")

				local var_161_2 = arg_158_1:GetWordFromCfg(324541039)
				local var_161_3 = arg_158_1:FormatText(var_161_2.content)

				arg_158_1.text_.text = var_161_3

				LuaForUtil.ClearLinePrefixSymbol(arg_158_1.text_)

				local var_161_4 = 34
				local var_161_5 = utf8.len(var_161_3)
				local var_161_6 = var_161_4 <= 0 and var_161_1 or var_161_1 * (var_161_5 / var_161_4)

				if var_161_6 > 0 and var_161_1 < var_161_6 then
					arg_158_1.talkMaxDuration = var_161_6

					if var_161_6 + var_161_0 > arg_158_1.duration_ then
						arg_158_1.duration_ = var_161_6 + var_161_0
					end
				end

				arg_158_1.text_.text = var_161_3
				arg_158_1.typewritter.percent = 0

				arg_158_1.typewritter:SetDirty()
				arg_158_1:ShowNextGo(false)
				arg_158_1:RecordContent(arg_158_1.text_.text)
			end

			local var_161_7 = math.max(var_161_1, arg_158_1.talkMaxDuration)

			if var_161_0 <= arg_158_1.time_ and arg_158_1.time_ < var_161_0 + var_161_7 then
				arg_158_1.typewritter.percent = (arg_158_1.time_ - var_161_0) / var_161_7

				arg_158_1.typewritter:SetDirty()
			end

			if arg_158_1.time_ >= var_161_0 + var_161_7 and arg_158_1.time_ < var_161_0 + var_161_7 + arg_161_0 then
				arg_158_1.typewritter.percent = 1

				arg_158_1.typewritter:SetDirty()
				arg_158_1:ShowNextGo(true)
			end
		end

		arg_158_1.nodeConfigList_ = {}

		arg_158_1:InitPlayNodeList()
	end,
	Play324541040 = function(arg_162_0, arg_162_1)
		arg_162_1.time_ = 0
		arg_162_1.frameCnt_ = 0
		arg_162_1.state_ = "playing"
		arg_162_1.curTalkId_ = 324541040
		arg_162_1.duration_ = 5

		SetActive(arg_162_1.tipsGo_, false)

		function arg_162_1.onSingleLineFinish_()
			arg_162_1.onSingleLineUpdate_ = nil
			arg_162_1.onSingleLineFinish_ = nil
			arg_162_1.state_ = "waiting"
		end

		function arg_162_1.playNext_(arg_164_0)
			if arg_164_0 == 1 then
				arg_162_0:Play324541041(arg_162_1)
			end
		end

		function arg_162_1.onSingleLineUpdate_(arg_165_0)
			local var_165_0 = 0
			local var_165_1 = 1.05

			if var_165_0 < arg_162_1.time_ and arg_162_1.time_ <= var_165_0 + arg_165_0 then
				arg_162_1.talkMaxDuration = 0
				arg_162_1.dialogCg_.alpha = 1

				arg_162_1.dialog_:SetActive(true)
				SetActive(arg_162_1.leftNameGo_, false)

				arg_162_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_162_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_162_1:RecordName(arg_162_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_162_1.iconTrs_.gameObject, false)
				arg_162_1.callingController_:SetSelectedState("normal")

				local var_165_2 = arg_162_1:GetWordFromCfg(324541040)
				local var_165_3 = arg_162_1:FormatText(var_165_2.content)

				arg_162_1.text_.text = var_165_3

				LuaForUtil.ClearLinePrefixSymbol(arg_162_1.text_)

				local var_165_4 = 42
				local var_165_5 = utf8.len(var_165_3)
				local var_165_6 = var_165_4 <= 0 and var_165_1 or var_165_1 * (var_165_5 / var_165_4)

				if var_165_6 > 0 and var_165_1 < var_165_6 then
					arg_162_1.talkMaxDuration = var_165_6

					if var_165_6 + var_165_0 > arg_162_1.duration_ then
						arg_162_1.duration_ = var_165_6 + var_165_0
					end
				end

				arg_162_1.text_.text = var_165_3
				arg_162_1.typewritter.percent = 0

				arg_162_1.typewritter:SetDirty()
				arg_162_1:ShowNextGo(false)
				arg_162_1:RecordContent(arg_162_1.text_.text)
			end

			local var_165_7 = math.max(var_165_1, arg_162_1.talkMaxDuration)

			if var_165_0 <= arg_162_1.time_ and arg_162_1.time_ < var_165_0 + var_165_7 then
				arg_162_1.typewritter.percent = (arg_162_1.time_ - var_165_0) / var_165_7

				arg_162_1.typewritter:SetDirty()
			end

			if arg_162_1.time_ >= var_165_0 + var_165_7 and arg_162_1.time_ < var_165_0 + var_165_7 + arg_165_0 then
				arg_162_1.typewritter.percent = 1

				arg_162_1.typewritter:SetDirty()
				arg_162_1:ShowNextGo(true)
			end
		end

		arg_162_1.nodeConfigList_ = {}

		arg_162_1:InitPlayNodeList()
	end,
	Play324541041 = function(arg_166_0, arg_166_1)
		arg_166_1.time_ = 0
		arg_166_1.frameCnt_ = 0
		arg_166_1.state_ = "playing"
		arg_166_1.curTalkId_ = 324541041
		arg_166_1.duration_ = 3.2

		SetActive(arg_166_1.tipsGo_, false)

		function arg_166_1.onSingleLineFinish_()
			arg_166_1.onSingleLineUpdate_ = nil
			arg_166_1.onSingleLineFinish_ = nil
			arg_166_1.state_ = "waiting"
		end

		function arg_166_1.playNext_(arg_168_0)
			if arg_168_0 == 1 then
				arg_166_0:Play324541042(arg_166_1)
			end
		end

		function arg_166_1.onSingleLineUpdate_(arg_169_0)
			local var_169_0 = "STblack"

			if arg_166_1.bgs_[var_169_0] == nil then
				local var_169_1 = Object.Instantiate(arg_166_1.paintGo_)

				var_169_1:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. var_169_0)
				var_169_1.name = var_169_0
				var_169_1.transform.parent = arg_166_1.stage_.transform
				var_169_1.transform.localPosition = Vector3.New(0, 100, 0)
				arg_166_1.bgs_[var_169_0] = var_169_1
			end

			local var_169_2 = 0

			if var_169_2 < arg_166_1.time_ and arg_166_1.time_ <= var_169_2 + arg_169_0 then
				local var_169_3 = manager.ui.mainCamera.transform.localPosition
				local var_169_4 = Vector3.New(0, 0, 10) + Vector3.New(var_169_3.x, var_169_3.y, 0)
				local var_169_5 = arg_166_1.bgs_.STblack

				var_169_5.transform.localPosition = var_169_4
				var_169_5.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_169_6 = var_169_5:GetComponent("SpriteRenderer")

				if var_169_6 and var_169_6.sprite then
					local var_169_7 = (var_169_5.transform.localPosition - var_169_3).z
					local var_169_8 = manager.ui.mainCameraCom_
					local var_169_9 = 2 * var_169_7 * Mathf.Tan(var_169_8.fieldOfView * 0.5 * Mathf.Deg2Rad)
					local var_169_10 = var_169_9 * var_169_8.aspect
					local var_169_11 = var_169_6.sprite.bounds.size.x
					local var_169_12 = var_169_6.sprite.bounds.size.y
					local var_169_13 = var_169_10 / var_169_11
					local var_169_14 = var_169_9 / var_169_12
					local var_169_15 = var_169_14 < var_169_13 and var_169_13 or var_169_14

					var_169_5.transform.localScale = Vector3.New(var_169_15, var_169_15, 0)
				end

				for iter_169_0, iter_169_1 in pairs(arg_166_1.bgs_) do
					if iter_169_0 ~= "STblack" then
						iter_169_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_169_16 = 0.9

			if var_169_16 < arg_166_1.time_ and arg_166_1.time_ <= var_169_16 + arg_169_0 then
				local var_169_17 = manager.ui.mainCamera.transform.localPosition
				local var_169_18 = Vector3.New(0, 0, 10) + Vector3.New(var_169_17.x, var_169_17.y, 0)
				local var_169_19 = arg_166_1.bgs_.J25f

				var_169_19.transform.localPosition = var_169_18
				var_169_19.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_169_20 = var_169_19:GetComponent("SpriteRenderer")

				if var_169_20 and var_169_20.sprite then
					local var_169_21 = (var_169_19.transform.localPosition - var_169_17).z
					local var_169_22 = manager.ui.mainCameraCom_
					local var_169_23 = 2 * var_169_21 * Mathf.Tan(var_169_22.fieldOfView * 0.5 * Mathf.Deg2Rad)
					local var_169_24 = var_169_23 * var_169_22.aspect
					local var_169_25 = var_169_20.sprite.bounds.size.x
					local var_169_26 = var_169_20.sprite.bounds.size.y
					local var_169_27 = var_169_24 / var_169_25
					local var_169_28 = var_169_23 / var_169_26
					local var_169_29 = var_169_28 < var_169_27 and var_169_27 or var_169_28

					var_169_19.transform.localScale = Vector3.New(var_169_29, var_169_29, 0)
				end

				for iter_169_2, iter_169_3 in pairs(arg_166_1.bgs_) do
					if iter_169_2 ~= "J25f" then
						iter_169_3.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_169_30 = 2

			if var_169_30 < arg_166_1.time_ and arg_166_1.time_ <= var_169_30 + arg_169_0 then
				arg_166_1.allBtn_.enabled = false
			end

			local var_169_31 = 0.3

			if arg_166_1.time_ >= var_169_30 + var_169_31 and arg_166_1.time_ < var_169_30 + var_169_31 + arg_169_0 then
				arg_166_1.allBtn_.enabled = true
			end

			local var_169_32 = 0.8

			if var_169_32 < arg_166_1.time_ and arg_166_1.time_ <= var_169_32 + arg_169_0 then
				arg_166_1.mask_.enabled = true
				arg_166_1.mask_.raycastTarget = true

				arg_166_1:SetGaussion(false)
			end

			local var_169_33 = 0.5

			if var_169_32 <= arg_166_1.time_ and arg_166_1.time_ < var_169_32 + var_169_33 then
				local var_169_34 = (arg_166_1.time_ - var_169_32) / var_169_33
				local var_169_35 = Color.New(1, 1, 1)

				var_169_35.a = Mathf.Lerp(1, 0, var_169_34)
				arg_166_1.mask_.color = var_169_35
			end

			if arg_166_1.time_ >= var_169_32 + var_169_33 and arg_166_1.time_ < var_169_32 + var_169_33 + arg_169_0 then
				local var_169_36 = Color.New(1, 1, 1)
				local var_169_37 = 0

				arg_166_1.mask_.enabled = false
				var_169_36.a = var_169_37
				arg_166_1.mask_.color = var_169_36
			end

			local var_169_38 = "1037ui_story"

			if arg_166_1.actors_[var_169_38] == nil then
				local var_169_39 = Asset.Load("Char/" .. "1037ui_story")

				if not isNil(var_169_39) then
					local var_169_40 = Object.Instantiate(Asset.Load("Char/" .. "1037ui_story"), arg_166_1.stage_.transform)

					var_169_40.name = var_169_38
					var_169_40.transform.localPosition = Vector3.New(0, 100, 0)
					arg_166_1.actors_[var_169_38] = var_169_40

					local var_169_41 = var_169_40:GetComponentInChildren(typeof(CharacterEffect))

					var_169_41.enabled = true

					local var_169_42 = GameObjectTools.GetOrAddComponent(var_169_40, typeof(DynamicBoneHelper))

					if var_169_42 then
						var_169_42:EnableDynamicBone(false)
					end

					arg_166_1:ShowWeapon(var_169_41.transform, false)

					arg_166_1.var_[var_169_38 .. "Animator"] = var_169_41.gameObject:GetComponent(typeof(UnityEngine.Animator))
					arg_166_1.var_[var_169_38 .. "Animator"].applyRootMotion = true
					arg_166_1.var_[var_169_38 .. "LipSync"] = var_169_41.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
				end
			end

			local var_169_43 = arg_166_1.actors_["1037ui_story"]
			local var_169_44 = 2

			if var_169_44 < arg_166_1.time_ and arg_166_1.time_ <= var_169_44 + arg_169_0 and not isNil(var_169_43) and arg_166_1.var_.characterEffect1037ui_story == nil then
				arg_166_1.var_.characterEffect1037ui_story = var_169_43:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_169_45 = 0.200000002980232

			if var_169_44 <= arg_166_1.time_ and arg_166_1.time_ < var_169_44 + var_169_45 and not isNil(var_169_43) then
				local var_169_46 = (arg_166_1.time_ - var_169_44) / var_169_45

				if arg_166_1.var_.characterEffect1037ui_story and not isNil(var_169_43) then
					arg_166_1.var_.characterEffect1037ui_story.fillFlat = false
				end
			end

			if arg_166_1.time_ >= var_169_44 + var_169_45 and arg_166_1.time_ < var_169_44 + var_169_45 + arg_169_0 and not isNil(var_169_43) and arg_166_1.var_.characterEffect1037ui_story then
				arg_166_1.var_.characterEffect1037ui_story.fillFlat = false
			end

			local var_169_47 = 0.0333333333333333

			if var_169_47 < arg_166_1.time_ and arg_166_1.time_ <= var_169_47 + arg_169_0 then
				arg_166_1.fswbg_:SetActive(true)
				arg_166_1.dialog_:SetActive(false)

				arg_166_1.fswtw_.percent = 0

				local var_169_48 = arg_166_1:GetWordFromCfg(102)
				local var_169_49 = arg_166_1:FormatText(var_169_48.content)

				arg_166_1.fswt_.text = var_169_49

				LuaForUtil.ClearLinePrefixSymbol(arg_166_1.fswt_)

				arg_166_1.fswt_:GetComponent("Text").color = Color(1, 1, 1)
				arg_166_1.fswbg_.transform:Find("textbox/bg"):GetComponent("Image").enabled = false

				arg_166_1.fswtw_:SetDirty()

				arg_166_1.typewritterCharCountI18N = 0

				SetActive(arg_166_1.fswtw_.transform.parent.parent:Find("bg/line").gameObject, false)
				arg_166_1:ShowNextGo(false)
			end

			local var_169_50 = 0.266666666666667

			if var_169_50 < arg_166_1.time_ and arg_166_1.time_ <= var_169_50 + arg_169_0 then
				arg_166_1.var_.oldValueTypewriter = arg_166_1.fswtw_.percent

				SetActive(arg_166_1.fswtw_.transform.parent.parent:Find("bg/line").gameObject, false)
				arg_166_1:ShowNextGo(false)
			end

			local var_169_51 = 0
			local var_169_52 = 0.233333333333333
			local var_169_53 = arg_166_1:GetWordFromCfg(102)
			local var_169_54 = arg_166_1:FormatText(var_169_53.content)
			local var_169_55, var_169_56 = arg_166_1:GetPercentByPara(var_169_54, 1)

			if var_169_50 < arg_166_1.time_ and arg_166_1.time_ <= var_169_50 + arg_169_0 then
				arg_166_1.talkMaxDuration = 0

				local var_169_57 = var_169_51 <= 0 and var_169_52 or var_169_52 * ((var_169_56 - arg_166_1.typewritterCharCountI18N) / var_169_51)

				if var_169_57 > 0 and var_169_52 < var_169_57 then
					arg_166_1.talkMaxDuration = var_169_57

					if var_169_57 + var_169_50 > arg_166_1.duration_ then
						arg_166_1.duration_ = var_169_57 + var_169_50
					end
				end
			end

			local var_169_58 = 0.233333333333333
			local var_169_59 = math.max(var_169_58, arg_166_1.talkMaxDuration)

			if var_169_50 <= arg_166_1.time_ and arg_166_1.time_ < var_169_50 + var_169_59 then
				local var_169_60 = (arg_166_1.time_ - var_169_50) / var_169_59

				arg_166_1.fswtw_.percent = Mathf.Lerp(arg_166_1.var_.oldValueTypewriter, var_169_55, var_169_60)
				arg_166_1.fswt_:GetComponent("Text").color = Color(1, 1, 1)

				arg_166_1.fswtw_:SetDirty()
			end

			if arg_166_1.time_ >= var_169_50 + var_169_59 and arg_166_1.time_ < var_169_50 + var_169_59 + arg_169_0 then
				arg_166_1.fswtw_.percent = var_169_55

				arg_166_1.fswtw_:SetDirty()
				arg_166_1:ShowNextGo(true)

				arg_166_1.typewritterCharCountI18N = var_169_56
			end

			local var_169_61 = 0

			if var_169_61 < arg_166_1.time_ and arg_166_1.time_ <= var_169_61 + arg_169_0 then
				arg_166_1.cswbg_:SetActive(true)

				local var_169_62 = arg_166_1.cswt_:GetComponent("RectTransform")

				arg_166_1.cswt_.alignment = UnityEngine.TextAnchor.MiddleCenter
				var_169_62.offsetMin = Vector2.New(400, 300)
				var_169_62.offsetMax = Vector2.New(-400, -200)

				local var_169_63 = arg_166_1:GetWordFromCfg(419180)
				local var_169_64 = arg_166_1:FormatText(var_169_63.content)

				arg_166_1.cswt_.text = var_169_64

				LuaForUtil.ClearLinePrefixSymbol(arg_166_1.cswt_)

				arg_166_1.cswt_.fontSize = 108
				arg_166_1.cswt_:GetComponent("Text").color = Color(1, 1, 1)

				arg_166_1.cswt_:GetComponent("I18NTextKeyToValue"):SetFontPath("Fonts/SourceHanSerifCN-Bold-3.0")

				arg_166_1.cswt_.font = Asset.Load("Fonts/SourceHanSerifCN-Bold-3.0")
			end

			local var_169_65 = 0.9

			if var_169_65 < arg_166_1.time_ and arg_166_1.time_ <= var_169_65 + arg_169_0 then
				arg_166_1.cswbg_:SetActive(false)
			end

			local var_169_66 = 0
			local var_169_67 = 1

			if var_169_66 < arg_166_1.time_ and arg_166_1.time_ <= var_169_66 + arg_169_0 then
				local var_169_68 = "play"
				local var_169_69 = "music"

				arg_166_1:AudioAction(var_169_68, var_169_69, "ui_skip", "ui_bgm_33", "ui_skip.awb")

				local var_169_70 = ""
				local var_169_71 = manager.audio:GetAudioName("ui_skip", "ui_bgm_33")

				if var_169_71 ~= "" then
					if arg_166_1.bgmTxt_.text ~= var_169_71 and arg_166_1.bgmTxt_.text ~= "" then
						if arg_166_1.bgmTxt2_.text ~= "" then
							arg_166_1.bgmTxt_.text = arg_166_1.bgmTxt2_.text
						end

						arg_166_1.bgmTxt2_.text = var_169_71

						arg_166_1.musicChangeAnimator_:Play("music_change", 0, 0)
					else
						arg_166_1.bgmTxt_.text = var_169_71
						arg_166_1.bgmTxt2_.text = var_169_71
					end

					if arg_166_1.bgmTimer then
						arg_166_1.bgmTimer:Stop()

						arg_166_1.bgmTimer = nil
					end

					if arg_166_1.settingData.show_music_name == 1 then
						arg_166_1.musicController:SetSelectedState("show")
						arg_166_1.musicAnimator_:Play("open", 0, 0)

						if arg_166_1.settingData.music_time ~= 0 then
							arg_166_1.bgmTimer = TimeTools.StartAfterSeconds(tonumber(arg_166_1.settingData.music_time), function()
								if arg_166_1 == nil or isNil(arg_166_1.bgmTxt_) then
									return
								end

								arg_166_1.musicController:SetSelectedState("hide")
								arg_166_1.musicAnimator_:Play("back", 0, 0)
							end, {})
						end
					end
				end
			end

			local var_169_72 = 1.3
			local var_169_73 = 1.9
			local var_169_74 = manager.audio:GetVoiceLength("story_v_out_324541", "324541041", "0") / 1000

			if var_169_74 > 0 and var_169_73 < var_169_74 and var_169_74 + var_169_72 > arg_166_1.duration_ then
				local var_169_75 = var_169_74

				arg_166_1.duration_ = var_169_74 + var_169_72
			end

			if var_169_72 < arg_166_1.time_ and arg_166_1.time_ <= var_169_72 + arg_169_0 then
				local var_169_76 = "play"
				local var_169_77 = "voice"

				arg_166_1:AudioAction(var_169_76, var_169_77, "story_v_out_324541", "324541041", "0")
			end

			local var_169_78 = 0

			if var_169_78 < arg_166_1.time_ and arg_166_1.time_ <= var_169_78 + arg_169_0 then
				arg_166_1.allBtn_.enabled = false
			end

			local var_169_79 = 2.83333333333333

			if arg_166_1.time_ >= var_169_78 + var_169_79 and arg_166_1.time_ < var_169_78 + var_169_79 + arg_169_0 then
				arg_166_1.allBtn_.enabled = true
			end
		end

		arg_166_1.nodeConfigList_ = {}

		arg_166_1:InitPlayNodeList()
	end,
	Play324541042 = function(arg_171_0, arg_171_1)
		arg_171_1.time_ = 0
		arg_171_1.frameCnt_ = 0
		arg_171_1.state_ = "playing"
		arg_171_1.curTalkId_ = 324541042
		arg_171_1.duration_ = 1

		SetActive(arg_171_1.tipsGo_, false)

		function arg_171_1.onSingleLineFinish_()
			arg_171_1.onSingleLineUpdate_ = nil
			arg_171_1.onSingleLineFinish_ = nil
			arg_171_1.state_ = "waiting"

			SetActive(arg_171_1.choicesGo_, true)

			for iter_172_0, iter_172_1 in ipairs(arg_171_1.choices_) do
				local var_172_0 = iter_172_0 <= 3

				SetActive(iter_172_1.go, var_172_0)
			end

			arg_171_1.choices_[1].txt.text = arg_171_1:FormatText(StoryChoiceCfg[1621].name)
			arg_171_1.choices_[2].txt.text = arg_171_1:FormatText(StoryChoiceCfg[1622].name)
			arg_171_1.choices_[3].txt.text = arg_171_1:FormatText(StoryChoiceCfg[1623].name)
		end

		function arg_171_1.playNext_(arg_173_0)
			if arg_173_0 == 1 then
				arg_171_0:Play324541043(arg_171_1)
			end

			if arg_173_0 == 2 then
				arg_171_0:Play324541043(arg_171_1)
			end

			if arg_173_0 == 3 then
				arg_171_0:Play324541043(arg_171_1)
			end

			arg_171_1:RecordChoiceLog(324541042, 1621, 1622, 1623)
		end

		function arg_171_1.onSingleLineUpdate_(arg_174_0)
			local var_174_0 = arg_171_1.actors_["1037ui_story"]
			local var_174_1 = 0

			if var_174_1 < arg_171_1.time_ and arg_171_1.time_ <= var_174_1 + arg_174_0 and not isNil(var_174_0) and arg_171_1.var_.characterEffect1037ui_story == nil then
				arg_171_1.var_.characterEffect1037ui_story = var_174_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_174_2 = 0.200000002980232

			if var_174_1 <= arg_171_1.time_ and arg_171_1.time_ < var_174_1 + var_174_2 and not isNil(var_174_0) then
				local var_174_3 = (arg_171_1.time_ - var_174_1) / var_174_2

				if arg_171_1.var_.characterEffect1037ui_story and not isNil(var_174_0) then
					local var_174_4 = Mathf.Lerp(0, 0.5, var_174_3)

					arg_171_1.var_.characterEffect1037ui_story.fillFlat = true
					arg_171_1.var_.characterEffect1037ui_story.fillRatio = var_174_4
				end
			end

			if arg_171_1.time_ >= var_174_1 + var_174_2 and arg_171_1.time_ < var_174_1 + var_174_2 + arg_174_0 and not isNil(var_174_0) and arg_171_1.var_.characterEffect1037ui_story then
				local var_174_5 = 0.5

				arg_171_1.var_.characterEffect1037ui_story.fillFlat = true
				arg_171_1.var_.characterEffect1037ui_story.fillRatio = var_174_5
			end
		end

		arg_171_1.nodeConfigList_ = {}

		arg_171_1:InitPlayNodeList()
	end,
	Play324541043 = function(arg_175_0, arg_175_1)
		arg_175_1.time_ = 0
		arg_175_1.frameCnt_ = 0
		arg_175_1.state_ = "playing"
		arg_175_1.curTalkId_ = 324541043
		arg_175_1.duration_ = 2.77

		SetActive(arg_175_1.tipsGo_, false)

		function arg_175_1.onSingleLineFinish_()
			arg_175_1.onSingleLineUpdate_ = nil
			arg_175_1.onSingleLineFinish_ = nil
			arg_175_1.state_ = "waiting"
		end

		function arg_175_1.playNext_(arg_177_0)
			if arg_177_0 == 1 then
				arg_175_0:Play324541044(arg_175_1)
			end
		end

		function arg_175_1.onSingleLineUpdate_(arg_178_0)
			local var_178_0 = arg_175_1.actors_["1037ui_story"]
			local var_178_1 = 0

			if var_178_1 < arg_175_1.time_ and arg_175_1.time_ <= var_178_1 + arg_178_0 and not isNil(var_178_0) and arg_175_1.var_.characterEffect1037ui_story == nil then
				arg_175_1.var_.characterEffect1037ui_story = var_178_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_178_2 = 0.200000002980232

			if var_178_1 <= arg_175_1.time_ and arg_175_1.time_ < var_178_1 + var_178_2 and not isNil(var_178_0) then
				local var_178_3 = (arg_175_1.time_ - var_178_1) / var_178_2

				if arg_175_1.var_.characterEffect1037ui_story and not isNil(var_178_0) then
					arg_175_1.var_.characterEffect1037ui_story.fillFlat = false
				end
			end

			if arg_175_1.time_ >= var_178_1 + var_178_2 and arg_175_1.time_ < var_178_1 + var_178_2 + arg_178_0 and not isNil(var_178_0) and arg_175_1.var_.characterEffect1037ui_story then
				arg_175_1.var_.characterEffect1037ui_story.fillFlat = false
			end

			local var_178_4 = 0

			if var_178_4 < arg_175_1.time_ and arg_175_1.time_ <= var_178_4 + arg_178_0 then
				arg_175_1.cswbg_:SetActive(true)

				local var_178_5 = arg_175_1.cswt_:GetComponent("RectTransform")

				arg_175_1.cswt_.alignment = UnityEngine.TextAnchor.MiddleCenter
				var_178_5.offsetMin = Vector2.New(400, 300)
				var_178_5.offsetMax = Vector2.New(-400, -200)

				local var_178_6 = arg_175_1:GetWordFromCfg(419181)
				local var_178_7 = arg_175_1:FormatText(var_178_6.content)

				arg_175_1.cswt_.text = var_178_7

				LuaForUtil.ClearLinePrefixSymbol(arg_175_1.cswt_)

				arg_175_1.cswt_.fontSize = 108
				arg_175_1.cswt_:GetComponent("Text").color = Color(1, 1, 1)

				arg_175_1.cswt_:GetComponent("I18NTextKeyToValue"):SetFontPath("Fonts/SourceHanSerifCN-Bold-3.0")

				arg_175_1.cswt_.font = Asset.Load("Fonts/SourceHanSerifCN-Bold-3.0")
			end

			local var_178_8 = 0.833333330353101

			if var_178_8 < arg_175_1.time_ and arg_175_1.time_ <= var_178_8 + arg_178_0 then
				arg_175_1.cswbg_:SetActive(false)
			end

			local var_178_9 = manager.ui.mainCamera.transform
			local var_178_10 = 0

			if var_178_10 < arg_175_1.time_ and arg_175_1.time_ <= var_178_10 + arg_178_0 then
				local var_178_11 = arg_175_1.var_.effect32131
				local var_178_12
				local var_178_13 = var_178_9

				if not var_178_11 then
					var_178_11 = Object.Instantiate(Asset.Load("Effect/Scene/fx_uistory_error"), var_178_13)
					var_178_11.name = "32131"
					arg_175_1.var_.effect32131 = var_178_11
				else
					var_178_11.transform:SetParent(var_178_13)
				end

				var_178_11.transform.localPosition = Vector3.New(0, 0, 0)
				var_178_11.transform.localRotation = Quaternion.Euler(0, 0, 0)

				local var_178_14 = 1.7777777777777777
				local var_178_15 = Screen.width / Screen.height
				local var_178_16 = var_178_15 / var_178_14
				local var_178_17 = Mathf.Max(var_178_14 / var_178_15, 1)

				var_178_11.transform.localScale = Vector3.New(var_178_11.transform.localScale.x * var_178_16, var_178_11.transform.localScale.y * var_178_17, var_178_11.transform.localScale.z)
			end

			local var_178_18 = manager.ui.mainCamera.transform
			local var_178_19 = 1.16666666666667

			if var_178_19 < arg_175_1.time_ and arg_175_1.time_ <= var_178_19 + arg_178_0 then
				local var_178_20 = arg_175_1.var_.effect32131

				if var_178_20 then
					Object.Destroy(var_178_20)

					arg_175_1.var_.effect32131 = nil
				end
			end

			local var_178_21 = 1.16666666666667
			local var_178_22 = 1.6
			local var_178_23 = manager.audio:GetVoiceLength("story_v_out_324541", "324541043", "0") / 1000

			if var_178_23 > 0 and var_178_22 < var_178_23 and var_178_23 + var_178_21 > arg_175_1.duration_ then
				local var_178_24 = var_178_23

				arg_175_1.duration_ = var_178_23 + var_178_21
			end

			if var_178_21 < arg_175_1.time_ and arg_175_1.time_ <= var_178_21 + arg_178_0 then
				local var_178_25 = "play"
				local var_178_26 = "voice"

				arg_175_1:AudioAction(var_178_25, var_178_26, "story_v_out_324541", "324541043", "0")
			end

			local var_178_27 = 0

			if var_178_27 < arg_175_1.time_ and arg_175_1.time_ <= var_178_27 + arg_178_0 then
				local var_178_28 = manager.ui.mainCamera.transform.localPosition
				local var_178_29 = Vector3.New(0, 0, 10) + Vector3.New(var_178_28.x, var_178_28.y, 0)
				local var_178_30 = arg_175_1.bgs_.STblack

				var_178_30.transform.localPosition = var_178_29
				var_178_30.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_178_31 = var_178_30:GetComponent("SpriteRenderer")

				if var_178_31 and var_178_31.sprite then
					local var_178_32 = (var_178_30.transform.localPosition - var_178_28).z
					local var_178_33 = manager.ui.mainCameraCom_
					local var_178_34 = 2 * var_178_32 * Mathf.Tan(var_178_33.fieldOfView * 0.5 * Mathf.Deg2Rad)
					local var_178_35 = var_178_34 * var_178_33.aspect
					local var_178_36 = var_178_31.sprite.bounds.size.x
					local var_178_37 = var_178_31.sprite.bounds.size.y
					local var_178_38 = var_178_35 / var_178_36
					local var_178_39 = var_178_34 / var_178_37
					local var_178_40 = var_178_39 < var_178_38 and var_178_38 or var_178_39

					var_178_30.transform.localScale = Vector3.New(var_178_40, var_178_40, 0)
				end

				for iter_178_0, iter_178_1 in pairs(arg_175_1.bgs_) do
					if iter_178_0 ~= "STblack" then
						iter_178_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_178_41 = 0.699999997019768

			if var_178_41 < arg_175_1.time_ and arg_175_1.time_ <= var_178_41 + arg_178_0 then
				local var_178_42 = manager.ui.mainCamera.transform.localPosition
				local var_178_43 = Vector3.New(0, 0, 10) + Vector3.New(var_178_42.x, var_178_42.y, 0)
				local var_178_44 = arg_175_1.bgs_.J25f

				var_178_44.transform.localPosition = var_178_43
				var_178_44.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_178_45 = var_178_44:GetComponent("SpriteRenderer")

				if var_178_45 and var_178_45.sprite then
					local var_178_46 = (var_178_44.transform.localPosition - var_178_42).z
					local var_178_47 = manager.ui.mainCameraCom_
					local var_178_48 = 2 * var_178_46 * Mathf.Tan(var_178_47.fieldOfView * 0.5 * Mathf.Deg2Rad)
					local var_178_49 = var_178_48 * var_178_47.aspect
					local var_178_50 = var_178_45.sprite.bounds.size.x
					local var_178_51 = var_178_45.sprite.bounds.size.y
					local var_178_52 = var_178_49 / var_178_50
					local var_178_53 = var_178_48 / var_178_51
					local var_178_54 = var_178_53 < var_178_52 and var_178_52 or var_178_53

					var_178_44.transform.localScale = Vector3.New(var_178_54, var_178_54, 0)
				end

				for iter_178_2, iter_178_3 in pairs(arg_175_1.bgs_) do
					if iter_178_2 ~= "J25f" then
						iter_178_3.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_178_55 = 0.6

			if var_178_55 < arg_175_1.time_ and arg_175_1.time_ <= var_178_55 + arg_178_0 then
				arg_175_1.mask_.enabled = true
				arg_175_1.mask_.raycastTarget = true

				arg_175_1:SetGaussion(false)
			end

			local var_178_56 = 0.566666666666667

			if var_178_55 <= arg_175_1.time_ and arg_175_1.time_ < var_178_55 + var_178_56 then
				local var_178_57 = (arg_175_1.time_ - var_178_55) / var_178_56
				local var_178_58 = Color.New(1, 1, 1)

				var_178_58.a = Mathf.Lerp(1, 0, var_178_57)
				arg_175_1.mask_.color = var_178_58
			end

			if arg_175_1.time_ >= var_178_55 + var_178_56 and arg_175_1.time_ < var_178_55 + var_178_56 + arg_178_0 then
				local var_178_59 = Color.New(1, 1, 1)
				local var_178_60 = 0

				arg_175_1.mask_.enabled = false
				var_178_59.a = var_178_60
				arg_175_1.mask_.color = var_178_59
			end

			local var_178_61 = 0

			if var_178_61 < arg_175_1.time_ and arg_175_1.time_ <= var_178_61 + arg_178_0 then
				arg_175_1.allBtn_.enabled = false
			end

			local var_178_62 = 2.13333333333333

			if arg_175_1.time_ >= var_178_61 + var_178_62 and arg_175_1.time_ < var_178_61 + var_178_62 + arg_178_0 then
				arg_175_1.allBtn_.enabled = true
			end
		end

		arg_175_1.nodeConfigList_ = {}

		arg_175_1:InitPlayNodeList()
	end,
	Play324541044 = function(arg_179_0, arg_179_1)
		arg_179_1.time_ = 0
		arg_179_1.frameCnt_ = 0
		arg_179_1.state_ = "playing"
		arg_179_1.curTalkId_ = 324541044
		arg_179_1.duration_ = 1

		SetActive(arg_179_1.tipsGo_, false)

		function arg_179_1.onSingleLineFinish_()
			arg_179_1.onSingleLineUpdate_ = nil
			arg_179_1.onSingleLineFinish_ = nil
			arg_179_1.state_ = "waiting"

			SetActive(arg_179_1.choicesGo_, true)

			for iter_180_0, iter_180_1 in ipairs(arg_179_1.choices_) do
				local var_180_0 = iter_180_0 <= 3

				SetActive(iter_180_1.go, var_180_0)
			end

			arg_179_1.choices_[1].txt.text = arg_179_1:FormatText(StoryChoiceCfg[1624].name)
			arg_179_1.choices_[2].txt.text = arg_179_1:FormatText(StoryChoiceCfg[1625].name)
			arg_179_1.choices_[3].txt.text = arg_179_1:FormatText(StoryChoiceCfg[1626].name)
		end

		function arg_179_1.playNext_(arg_181_0)
			if arg_181_0 == 1 then
				arg_179_0:Play324541045(arg_179_1)
			end

			if arg_181_0 == 2 then
				arg_179_0:Play324541045(arg_179_1)
			end

			if arg_181_0 == 3 then
				arg_179_0:Play324541045(arg_179_1)
			end

			arg_179_1:RecordChoiceLog(324541044, 1624, 1625, 1626)
		end

		function arg_179_1.onSingleLineUpdate_(arg_182_0)
			return
		end

		arg_179_1.nodeConfigList_ = {}

		arg_179_1:InitPlayNodeList()
	end,
	Play324541045 = function(arg_183_0, arg_183_1)
		arg_183_1.time_ = 0
		arg_183_1.frameCnt_ = 0
		arg_183_1.state_ = "playing"
		arg_183_1.curTalkId_ = 324541045
		arg_183_1.duration_ = 2.67

		SetActive(arg_183_1.tipsGo_, false)

		function arg_183_1.onSingleLineFinish_()
			arg_183_1.onSingleLineUpdate_ = nil
			arg_183_1.onSingleLineFinish_ = nil
			arg_183_1.state_ = "waiting"
		end

		function arg_183_1.playNext_(arg_185_0)
			if arg_185_0 == 1 then
				arg_183_0:Play324541046(arg_183_1)
			end
		end

		function arg_183_1.onSingleLineUpdate_(arg_186_0)
			local var_186_0 = arg_183_1.actors_["1037ui_story"]
			local var_186_1 = 0

			if var_186_1 < arg_183_1.time_ and arg_183_1.time_ <= var_186_1 + arg_186_0 and not isNil(var_186_0) and arg_183_1.var_.characterEffect1037ui_story == nil then
				arg_183_1.var_.characterEffect1037ui_story = var_186_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_186_2 = 0.200000002980232

			if var_186_1 <= arg_183_1.time_ and arg_183_1.time_ < var_186_1 + var_186_2 and not isNil(var_186_0) then
				local var_186_3 = (arg_183_1.time_ - var_186_1) / var_186_2

				if arg_183_1.var_.characterEffect1037ui_story and not isNil(var_186_0) then
					arg_183_1.var_.characterEffect1037ui_story.fillFlat = false
				end
			end

			if arg_183_1.time_ >= var_186_1 + var_186_2 and arg_183_1.time_ < var_186_1 + var_186_2 + arg_186_0 and not isNil(var_186_0) and arg_183_1.var_.characterEffect1037ui_story then
				arg_183_1.var_.characterEffect1037ui_story.fillFlat = false
			end

			local var_186_4 = 0

			if var_186_4 < arg_183_1.time_ and arg_183_1.time_ <= var_186_4 + arg_186_0 then
				arg_183_1.cswbg_:SetActive(true)

				local var_186_5 = arg_183_1.cswt_:GetComponent("RectTransform")

				arg_183_1.cswt_.alignment = UnityEngine.TextAnchor.MiddleCenter
				var_186_5.offsetMin = Vector2.New(400, 300)
				var_186_5.offsetMax = Vector2.New(-400, -200)

				local var_186_6 = arg_183_1:GetWordFromCfg(419182)
				local var_186_7 = arg_183_1:FormatText(var_186_6.content)

				arg_183_1.cswt_.text = var_186_7

				LuaForUtil.ClearLinePrefixSymbol(arg_183_1.cswt_)

				arg_183_1.cswt_.fontSize = 108
				arg_183_1.cswt_:GetComponent("Text").color = Color(1, 1, 1)

				arg_183_1.cswt_:GetComponent("I18NTextKeyToValue"):SetFontPath("Fonts/SourceHanSerifCN-Bold-3.0")

				arg_183_1.cswt_.font = Asset.Load("Fonts/SourceHanSerifCN-Bold-3.0")
			end

			local var_186_8 = 0.839815799146891

			if var_186_8 < arg_183_1.time_ and arg_183_1.time_ <= var_186_8 + arg_186_0 then
				arg_183_1.cswbg_:SetActive(false)
			end

			local var_186_9 = manager.ui.mainCamera.transform
			local var_186_10 = 0

			if var_186_10 < arg_183_1.time_ and arg_183_1.time_ <= var_186_10 + arg_186_0 then
				local var_186_11 = arg_183_1.var_.effect223131
				local var_186_12
				local var_186_13 = var_186_9

				if not var_186_11 then
					var_186_11 = Object.Instantiate(Asset.Load("Effect/Scene/fx_uistory_error"), var_186_13)
					var_186_11.name = "223131"
					arg_183_1.var_.effect223131 = var_186_11
				else
					var_186_11.transform:SetParent(var_186_13)
				end

				var_186_11.transform.localPosition = Vector3.New(0, 0, 0)
				var_186_11.transform.localRotation = Quaternion.Euler(0, 0, 0)

				local var_186_14 = 1.7777777777777777
				local var_186_15 = Screen.width / Screen.height
				local var_186_16 = var_186_15 / var_186_14
				local var_186_17 = Mathf.Max(var_186_14 / var_186_15, 1)

				var_186_11.transform.localScale = Vector3.New(var_186_11.transform.localScale.x * var_186_16, var_186_11.transform.localScale.y * var_186_17, var_186_11.transform.localScale.z)
			end

			local var_186_18 = manager.ui.mainCamera.transform
			local var_186_19 = 1.16666666666667

			if var_186_19 < arg_183_1.time_ and arg_183_1.time_ <= var_186_19 + arg_186_0 then
				local var_186_20 = arg_183_1.var_.effect223131

				if var_186_20 then
					Object.Destroy(var_186_20)

					arg_183_1.var_.effect223131 = nil
				end
			end

			local var_186_21 = 0.633333333333333
			local var_186_22 = 2.033
			local var_186_23 = manager.audio:GetVoiceLength("story_v_out_324541", "324541045", "0") / 1000

			if var_186_23 > 0 and var_186_22 < var_186_23 and var_186_23 + var_186_21 > arg_183_1.duration_ then
				local var_186_24 = var_186_23

				arg_183_1.duration_ = var_186_23 + var_186_21
			end

			if var_186_21 < arg_183_1.time_ and arg_183_1.time_ <= var_186_21 + arg_186_0 then
				local var_186_25 = "play"
				local var_186_26 = "voice"

				arg_183_1:AudioAction(var_186_25, var_186_26, "story_v_out_324541", "324541045", "0")
			end

			local var_186_27 = 0

			if var_186_27 < arg_183_1.time_ and arg_183_1.time_ <= var_186_27 + arg_186_0 then
				local var_186_28 = manager.ui.mainCamera.transform.localPosition
				local var_186_29 = Vector3.New(0, 0, 10) + Vector3.New(var_186_28.x, var_186_28.y, 0)
				local var_186_30 = arg_183_1.bgs_.STblack

				var_186_30.transform.localPosition = var_186_29
				var_186_30.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_186_31 = var_186_30:GetComponent("SpriteRenderer")

				if var_186_31 and var_186_31.sprite then
					local var_186_32 = (var_186_30.transform.localPosition - var_186_28).z
					local var_186_33 = manager.ui.mainCameraCom_
					local var_186_34 = 2 * var_186_32 * Mathf.Tan(var_186_33.fieldOfView * 0.5 * Mathf.Deg2Rad)
					local var_186_35 = var_186_34 * var_186_33.aspect
					local var_186_36 = var_186_31.sprite.bounds.size.x
					local var_186_37 = var_186_31.sprite.bounds.size.y
					local var_186_38 = var_186_35 / var_186_36
					local var_186_39 = var_186_34 / var_186_37
					local var_186_40 = var_186_39 < var_186_38 and var_186_38 or var_186_39

					var_186_30.transform.localScale = Vector3.New(var_186_40, var_186_40, 0)
				end

				for iter_186_0, iter_186_1 in pairs(arg_183_1.bgs_) do
					if iter_186_0 ~= "STblack" then
						iter_186_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_186_41 = 0.839815799146891

			if var_186_41 < arg_183_1.time_ and arg_183_1.time_ <= var_186_41 + arg_186_0 then
				local var_186_42 = manager.ui.mainCamera.transform.localPosition
				local var_186_43 = Vector3.New(0, 0, 10) + Vector3.New(var_186_42.x, var_186_42.y, 0)
				local var_186_44 = arg_183_1.bgs_.J25f

				var_186_44.transform.localPosition = var_186_43
				var_186_44.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_186_45 = var_186_44:GetComponent("SpriteRenderer")

				if var_186_45 and var_186_45.sprite then
					local var_186_46 = (var_186_44.transform.localPosition - var_186_42).z
					local var_186_47 = manager.ui.mainCameraCom_
					local var_186_48 = 2 * var_186_46 * Mathf.Tan(var_186_47.fieldOfView * 0.5 * Mathf.Deg2Rad)
					local var_186_49 = var_186_48 * var_186_47.aspect
					local var_186_50 = var_186_45.sprite.bounds.size.x
					local var_186_51 = var_186_45.sprite.bounds.size.y
					local var_186_52 = var_186_49 / var_186_50
					local var_186_53 = var_186_48 / var_186_51
					local var_186_54 = var_186_53 < var_186_52 and var_186_52 or var_186_53

					var_186_44.transform.localScale = Vector3.New(var_186_54, var_186_54, 0)
				end

				for iter_186_2, iter_186_3 in pairs(arg_183_1.bgs_) do
					if iter_186_2 ~= "J25f" then
						iter_186_3.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_186_55 = 0.633333333333333

			if var_186_55 < arg_183_1.time_ and arg_183_1.time_ <= var_186_55 + arg_186_0 then
				arg_183_1.mask_.enabled = true
				arg_183_1.mask_.raycastTarget = true

				arg_183_1:SetGaussion(false)
			end

			local var_186_56 = 0.8

			if var_186_55 <= arg_183_1.time_ and arg_183_1.time_ < var_186_55 + var_186_56 then
				local var_186_57 = (arg_183_1.time_ - var_186_55) / var_186_56
				local var_186_58 = Color.New(1, 1, 1)

				var_186_58.a = Mathf.Lerp(1, 0, var_186_57)
				arg_183_1.mask_.color = var_186_58
			end

			if arg_183_1.time_ >= var_186_55 + var_186_56 and arg_183_1.time_ < var_186_55 + var_186_56 + arg_186_0 then
				local var_186_59 = Color.New(1, 1, 1)
				local var_186_60 = 0

				arg_183_1.mask_.enabled = false
				var_186_59.a = var_186_60
				arg_183_1.mask_.color = var_186_59
			end
		end

		arg_183_1.nodeConfigList_ = {}

		arg_183_1:InitPlayNodeList()
	end,
	Play324541046 = function(arg_187_0, arg_187_1)
		arg_187_1.time_ = 0
		arg_187_1.frameCnt_ = 0
		arg_187_1.state_ = "playing"
		arg_187_1.curTalkId_ = 324541046
		arg_187_1.duration_ = 3.83

		SetActive(arg_187_1.tipsGo_, false)

		function arg_187_1.onSingleLineFinish_()
			arg_187_1.onSingleLineUpdate_ = nil
			arg_187_1.onSingleLineFinish_ = nil
			arg_187_1.state_ = "waiting"
		end

		function arg_187_1.playNext_(arg_189_0)
			if arg_189_0 == 1 then
				arg_187_0:Play324541047(arg_187_1)
			end
		end

		function arg_187_1.onSingleLineUpdate_(arg_190_0)
			local var_190_0 = 0

			if var_190_0 < arg_187_1.time_ and arg_187_1.time_ <= var_190_0 + arg_190_0 then
				arg_187_1.cswbg_:SetActive(true)

				local var_190_1 = arg_187_1.cswt_:GetComponent("RectTransform")

				arg_187_1.cswt_.alignment = UnityEngine.TextAnchor.MiddleCenter
				var_190_1.offsetMin = Vector2.New(400, 300)
				var_190_1.offsetMax = Vector2.New(-400, -200)

				local var_190_2 = arg_187_1:GetWordFromCfg(419183)
				local var_190_3 = arg_187_1:FormatText(var_190_2.content)

				arg_187_1.cswt_.text = var_190_3

				LuaForUtil.ClearLinePrefixSymbol(arg_187_1.cswt_)

				arg_187_1.cswt_.fontSize = 108
				arg_187_1.cswt_:GetComponent("Text").color = Color(1, 1, 1)

				arg_187_1.cswt_:GetComponent("I18NTextKeyToValue"):SetFontPath("Fonts/SourceHanSerifCN-Bold-3.0")

				arg_187_1.cswt_.font = Asset.Load("Fonts/SourceHanSerifCN-Bold-3.0")
			end

			local var_190_4 = manager.ui.mainCamera.transform
			local var_190_5 = 0

			if var_190_5 < arg_187_1.time_ and arg_187_1.time_ <= var_190_5 + arg_190_0 then
				local var_190_6 = arg_187_1.var_.effect321313
				local var_190_7
				local var_190_8 = var_190_4

				if not var_190_6 then
					var_190_6 = Object.Instantiate(Asset.Load("Effect/Scene/fx_uistory_error"), var_190_8)
					var_190_6.name = "321313"
					arg_187_1.var_.effect321313 = var_190_6
				else
					var_190_6.transform:SetParent(var_190_8)
				end

				var_190_6.transform.localPosition = Vector3.New(0, 0, 0)
				var_190_6.transform.localRotation = Quaternion.Euler(0, 0, 0)

				local var_190_9 = 1.7777777777777777
				local var_190_10 = Screen.width / Screen.height
				local var_190_11 = var_190_10 / var_190_9
				local var_190_12 = Mathf.Max(var_190_9 / var_190_10, 1)

				var_190_6.transform.localScale = Vector3.New(var_190_6.transform.localScale.x * var_190_11, var_190_6.transform.localScale.y * var_190_12, var_190_6.transform.localScale.z)
			end

			local var_190_13 = manager.ui.mainCamera.transform
			local var_190_14 = 2.06666666666667

			if var_190_14 < arg_187_1.time_ and arg_187_1.time_ <= var_190_14 + arg_190_0 then
				local var_190_15 = arg_187_1.var_.effect321313

				if var_190_15 then
					Object.Destroy(var_190_15)

					arg_187_1.var_.effect321313 = nil
				end
			end

			local var_190_16 = manager.ui.mainCamera.transform
			local var_190_17 = 0.266666666666667

			if var_190_17 < arg_187_1.time_ and arg_187_1.time_ <= var_190_17 + arg_190_0 then
				local var_190_18 = arg_187_1.var_.effect321314
				local var_190_19
				local var_190_20 = var_190_16

				if not var_190_18 then
					var_190_18 = Object.Instantiate(Asset.Load("Effect/Scene/fx_uistory_error"), var_190_20)
					var_190_18.name = "321314"
					arg_187_1.var_.effect321314 = var_190_18
				else
					var_190_18.transform:SetParent(var_190_20)
				end

				var_190_18.transform.localPosition = Vector3.New(0, 0, 18.4)
				var_190_18.transform.localRotation = Quaternion.Euler(0, 0, 0)

				local var_190_21 = 1.7777777777777777
				local var_190_22 = Screen.width / Screen.height
				local var_190_23 = var_190_22 / var_190_21
				local var_190_24 = Mathf.Max(var_190_21 / var_190_22, 1)

				var_190_18.transform.localScale = Vector3.New(var_190_18.transform.localScale.x * var_190_23, var_190_18.transform.localScale.y * var_190_24, var_190_18.transform.localScale.z)
			end

			local var_190_25 = manager.ui.mainCamera.transform
			local var_190_26 = 2.33333333333333

			if var_190_26 < arg_187_1.time_ and arg_187_1.time_ <= var_190_26 + arg_190_0 then
				local var_190_27 = arg_187_1.var_.effect321314

				if var_190_27 then
					Object.Destroy(var_190_27)

					arg_187_1.var_.effect321314 = nil
				end
			end

			local var_190_28 = manager.ui.mainCamera.transform
			local var_190_29 = 0.599999999998666

			if var_190_29 < arg_187_1.time_ and arg_187_1.time_ <= var_190_29 + arg_190_0 then
				local var_190_30 = arg_187_1.var_.effect321315
				local var_190_31
				local var_190_32 = var_190_28

				if not var_190_30 then
					var_190_30 = Object.Instantiate(Asset.Load("Effect/Scene/fx_uistory_error"), var_190_32)
					var_190_30.name = "321315"
					arg_187_1.var_.effect321315 = var_190_30
				else
					var_190_30.transform:SetParent(var_190_32)
				end

				var_190_30.transform.localPosition = Vector3.New(0, 0.23, 0.31)
				var_190_30.transform.localRotation = Quaternion.Euler(0, 0, 0)

				local var_190_33 = 1.7777777777777777
				local var_190_34 = Screen.width / Screen.height
				local var_190_35 = var_190_34 / var_190_33
				local var_190_36 = Mathf.Max(var_190_33 / var_190_34, 1)

				var_190_30.transform.localScale = Vector3.New(var_190_30.transform.localScale.x * var_190_35, var_190_30.transform.localScale.y * var_190_36, var_190_30.transform.localScale.z)
			end

			local var_190_37 = manager.ui.mainCamera.transform
			local var_190_38 = 2.66666666666667

			if var_190_38 < arg_187_1.time_ and arg_187_1.time_ <= var_190_38 + arg_190_0 then
				local var_190_39 = arg_187_1.var_.effect321315

				if var_190_39 then
					Object.Destroy(var_190_39)

					arg_187_1.var_.effect321315 = nil
				end
			end

			local var_190_40 = 0

			if var_190_40 < arg_187_1.time_ and arg_187_1.time_ <= var_190_40 + arg_190_0 then
				arg_187_1.allBtn_.enabled = false
			end

			local var_190_41 = 0.599999999998666

			if arg_187_1.time_ >= var_190_40 + var_190_41 and arg_187_1.time_ < var_190_40 + var_190_41 + arg_190_0 then
				arg_187_1.allBtn_.enabled = true
			end

			local var_190_42 = 0
			local var_190_43 = 1
			local var_190_44 = manager.audio:GetVoiceLength("story_v_out_324541", "324541046", "0") / 1000

			if var_190_44 > 0 and var_190_43 < var_190_44 and var_190_44 + var_190_42 > arg_187_1.duration_ then
				local var_190_45 = var_190_44

				arg_187_1.duration_ = var_190_44 + var_190_42
			end

			if var_190_42 < arg_187_1.time_ and arg_187_1.time_ <= var_190_42 + arg_190_0 then
				local var_190_46 = "play"
				local var_190_47 = "voice"

				arg_187_1:AudioAction(var_190_46, var_190_47, "story_v_out_324541", "324541046", "0")
			end
		end

		arg_187_1.nodeConfigList_ = {}

		arg_187_1:InitPlayNodeList()
	end,
	Play324541047 = function(arg_191_0, arg_191_1)
		arg_191_1.time_ = 0
		arg_191_1.frameCnt_ = 0
		arg_191_1.state_ = "playing"
		arg_191_1.curTalkId_ = 324541047
		arg_191_1.duration_ = 2.8

		SetActive(arg_191_1.tipsGo_, false)

		function arg_191_1.onSingleLineFinish_()
			arg_191_1.onSingleLineUpdate_ = nil
			arg_191_1.onSingleLineFinish_ = nil
			arg_191_1.state_ = "waiting"
		end

		function arg_191_1.playNext_(arg_193_0)
			if arg_193_0 == 1 then
				arg_191_0:Play324541048(arg_191_1)
			end
		end

		function arg_191_1.onSingleLineUpdate_(arg_194_0)
			local var_194_0 = manager.ui.mainCamera.transform
			local var_194_1 = 0.466666666666667

			if var_194_1 < arg_191_1.time_ and arg_191_1.time_ <= var_194_1 + arg_194_0 then
				local var_194_2 = arg_191_1.var_.effect32131
				local var_194_3
				local var_194_4 = var_194_0

				if not var_194_2 then
					var_194_2 = Object.Instantiate(Asset.Load("Effect/Scene/fx_uistory_error"), var_194_4)
					var_194_2.name = "32131"
					arg_191_1.var_.effect32131 = var_194_2
				else
					var_194_2.transform:SetParent(var_194_4)
				end

				var_194_2.transform.localPosition = Vector3.New(0, 0, 0)
				var_194_2.transform.localRotation = Quaternion.Euler(0, 0, 0)

				local var_194_5 = 1.7777777777777777
				local var_194_6 = Screen.width / Screen.height
				local var_194_7 = var_194_6 / var_194_5
				local var_194_8 = Mathf.Max(var_194_5 / var_194_6, 1)

				var_194_2.transform.localScale = Vector3.New(var_194_2.transform.localScale.x * var_194_7, var_194_2.transform.localScale.y * var_194_8, var_194_2.transform.localScale.z)
			end

			local var_194_9 = manager.ui.mainCamera.transform
			local var_194_10 = 1.63333333333333

			if var_194_10 < arg_191_1.time_ and arg_191_1.time_ <= var_194_10 + arg_194_0 then
				local var_194_11 = arg_191_1.var_.effect32131

				if var_194_11 then
					Object.Destroy(var_194_11)

					arg_191_1.var_.effect32131 = nil
				end
			end

			local var_194_12 = 0

			if var_194_12 < arg_191_1.time_ and arg_191_1.time_ <= var_194_12 + arg_194_0 then
				arg_191_1.cswbg_:SetActive(true)

				local var_194_13 = arg_191_1.cswt_:GetComponent("RectTransform")

				arg_191_1.cswt_.alignment = UnityEngine.TextAnchor.MiddleCenter
				var_194_13.offsetMin = Vector2.New(400, 300)
				var_194_13.offsetMax = Vector2.New(-400, -200)

				local var_194_14 = arg_191_1:GetWordFromCfg(419184)
				local var_194_15 = arg_191_1:FormatText(var_194_14.content)

				arg_191_1.cswt_.text = var_194_15

				LuaForUtil.ClearLinePrefixSymbol(arg_191_1.cswt_)

				arg_191_1.cswt_.fontSize = 108
				arg_191_1.cswt_:GetComponent("Text").color = Color(1, 1, 1)

				arg_191_1.cswt_:GetComponent("I18NTextKeyToValue"):SetFontPath("Fonts/SourceHanSerifCN-Bold-3.0")

				arg_191_1.cswt_.font = Asset.Load("Fonts/SourceHanSerifCN-Bold-3.0")
			end

			local var_194_16 = 0.0333333333333333

			if var_194_16 < arg_191_1.time_ and arg_191_1.time_ <= var_194_16 + arg_194_0 then
				arg_191_1.fswbg_:SetActive(true)
				arg_191_1.dialog_:SetActive(false)

				arg_191_1.fswtw_.percent = 0

				local var_194_17 = arg_191_1:GetWordFromCfg(324541047)
				local var_194_18 = arg_191_1:FormatText(var_194_17.content)

				arg_191_1.fswt_.text = var_194_18

				LuaForUtil.ClearLinePrefixSymbol(arg_191_1.fswt_)

				arg_191_1.fswt_:GetComponent("Text").color = Color(1, 1, 1)
				arg_191_1.fswbg_.transform:Find("textbox/bg"):GetComponent("Image").enabled = false

				arg_191_1.fswtw_:SetDirty()

				arg_191_1.typewritterCharCountI18N = 0

				SetActive(arg_191_1.fswtw_.transform.parent.parent:Find("bg/line").gameObject, false)
				arg_191_1:ShowNextGo(false)
			end

			local var_194_19 = 0.266666666666667

			if var_194_19 < arg_191_1.time_ and arg_191_1.time_ <= var_194_19 + arg_194_0 then
				arg_191_1.var_.oldValueTypewriter = arg_191_1.fswtw_.percent

				SetActive(arg_191_1.fswtw_.transform.parent.parent:Find("bg/line").gameObject, false)
				arg_191_1:ShowNextGo(false)
			end

			local var_194_20 = 12
			local var_194_21 = 0.8
			local var_194_22 = arg_191_1:GetWordFromCfg(324541047)
			local var_194_23 = arg_191_1:FormatText(var_194_22.content)
			local var_194_24, var_194_25 = arg_191_1:GetPercentByPara(var_194_23, 1)

			if var_194_19 < arg_191_1.time_ and arg_191_1.time_ <= var_194_19 + arg_194_0 then
				arg_191_1.talkMaxDuration = 0

				local var_194_26 = var_194_20 <= 0 and var_194_21 or var_194_21 * ((var_194_25 - arg_191_1.typewritterCharCountI18N) / var_194_20)

				if var_194_26 > 0 and var_194_21 < var_194_26 then
					arg_191_1.talkMaxDuration = var_194_26

					if var_194_26 + var_194_19 > arg_191_1.duration_ then
						arg_191_1.duration_ = var_194_26 + var_194_19
					end
				end
			end

			local var_194_27 = 0.8
			local var_194_28 = math.max(var_194_27, arg_191_1.talkMaxDuration)

			if var_194_19 <= arg_191_1.time_ and arg_191_1.time_ < var_194_19 + var_194_28 then
				local var_194_29 = (arg_191_1.time_ - var_194_19) / var_194_28

				arg_191_1.fswtw_.percent = Mathf.Lerp(arg_191_1.var_.oldValueTypewriter, var_194_24, var_194_29)
				arg_191_1.fswt_:GetComponent("Text").color = Color(1, 1, 1)

				arg_191_1.fswtw_:SetDirty()
			end

			if arg_191_1.time_ >= var_194_19 + var_194_28 and arg_191_1.time_ < var_194_19 + var_194_28 + arg_194_0 then
				arg_191_1.fswtw_.percent = var_194_24

				arg_191_1.fswtw_:SetDirty()
				arg_191_1:ShowNextGo(true)

				arg_191_1.typewritterCharCountI18N = var_194_25
			end

			local var_194_30 = 0

			if var_194_30 < arg_191_1.time_ and arg_191_1.time_ <= var_194_30 + arg_194_0 then
				local var_194_31 = arg_191_1.fswbg_.transform:Find("textbox/adapt/content") or arg_191_1.fswbg_.transform:Find("textbox/content")
				local var_194_32 = arg_191_1.fswbg_.transform:Find("textbox/bg"):GetComponent("Image")
				local var_194_33 = var_194_31:GetComponent("Text")
				local var_194_34 = var_194_31:GetComponent("RectTransform")

				var_194_33.alignment = UnityEngine.TextAnchor.LowerCenter
				var_194_34.offsetMin = Vector2.New(0, 0)
				var_194_34.offsetMax = Vector2.New(0, 0)
			end

			local var_194_35 = 0.466666666666667
			local var_194_36 = 1.8
			local var_194_37 = manager.audio:GetVoiceLength("story_v_out_324541", "324541047", "0") / 1000

			if var_194_37 > 0 and var_194_36 < var_194_37 and var_194_37 + var_194_35 > arg_191_1.duration_ then
				local var_194_38 = var_194_37

				arg_191_1.duration_ = var_194_37 + var_194_35
			end

			if var_194_35 < arg_191_1.time_ and arg_191_1.time_ <= var_194_35 + arg_194_0 then
				local var_194_39 = "play"
				local var_194_40 = "voice"

				arg_191_1:AudioAction(var_194_39, var_194_40, "story_v_out_324541", "324541047", "0")
			end

			local var_194_41 = 0.266666666666667

			if var_194_41 < arg_191_1.time_ and arg_191_1.time_ <= var_194_41 + arg_194_0 then
				arg_191_1.mask_.enabled = true
				arg_191_1.mask_.raycastTarget = true

				arg_191_1:SetGaussion(false)
			end

			local var_194_42 = 0.2

			if var_194_41 <= arg_191_1.time_ and arg_191_1.time_ < var_194_41 + var_194_42 then
				local var_194_43 = (arg_191_1.time_ - var_194_41) / var_194_42
				local var_194_44 = Color.New(1, 1, 1)

				var_194_44.a = Mathf.Lerp(1, 0, var_194_43)
				arg_191_1.mask_.color = var_194_44
			end

			if arg_191_1.time_ >= var_194_41 + var_194_42 and arg_191_1.time_ < var_194_41 + var_194_42 + arg_194_0 then
				local var_194_45 = Color.New(1, 1, 1)
				local var_194_46 = 0

				arg_191_1.mask_.enabled = false
				var_194_45.a = var_194_46
				arg_191_1.mask_.color = var_194_45
			end

			local var_194_47 = 0

			if var_194_47 < arg_191_1.time_ and arg_191_1.time_ <= var_194_47 + arg_194_0 then
				local var_194_48 = manager.ui.mainCamera.transform.localPosition
				local var_194_49 = Vector3.New(0, 0, 10) + Vector3.New(var_194_48.x, var_194_48.y, 0)
				local var_194_50 = arg_191_1.bgs_.STblack

				var_194_50.transform.localPosition = var_194_49
				var_194_50.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_194_51 = var_194_50:GetComponent("SpriteRenderer")

				if var_194_51 and var_194_51.sprite then
					local var_194_52 = (var_194_50.transform.localPosition - var_194_48).z
					local var_194_53 = manager.ui.mainCameraCom_
					local var_194_54 = 2 * var_194_52 * Mathf.Tan(var_194_53.fieldOfView * 0.5 * Mathf.Deg2Rad)
					local var_194_55 = var_194_54 * var_194_53.aspect
					local var_194_56 = var_194_51.sprite.bounds.size.x
					local var_194_57 = var_194_51.sprite.bounds.size.y
					local var_194_58 = var_194_55 / var_194_56
					local var_194_59 = var_194_54 / var_194_57
					local var_194_60 = var_194_59 < var_194_58 and var_194_58 or var_194_59

					var_194_50.transform.localScale = Vector3.New(var_194_60, var_194_60, 0)
				end

				for iter_194_0, iter_194_1 in pairs(arg_191_1.bgs_) do
					if iter_194_0 ~= "STblack" then
						iter_194_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_194_61 = 0
			local var_194_62 = 2.63333333333333
			local var_194_63 = manager.audio:GetVoiceLength("story_v_out_324541", "324541047", "0") / 1000

			if var_194_63 > 0 and var_194_62 < var_194_63 and var_194_63 + var_194_61 > arg_191_1.duration_ then
				local var_194_64 = var_194_63

				arg_191_1.duration_ = var_194_63 + var_194_61
			end

			if var_194_61 < arg_191_1.time_ and arg_191_1.time_ <= var_194_61 + arg_194_0 then
				local var_194_65 = "play"
				local var_194_66 = "voice"

				arg_191_1:AudioAction(var_194_65, var_194_66, "story_v_out_324541", "324541047", "0")
			end
		end

		arg_191_1.nodeConfigList_ = {}

		arg_191_1:InitPlayNodeList()
	end,
	Play324541048 = function(arg_195_0, arg_195_1)
		arg_195_1.time_ = 0
		arg_195_1.frameCnt_ = 0
		arg_195_1.state_ = "playing"
		arg_195_1.curTalkId_ = 324541048
		arg_195_1.duration_ = 1

		SetActive(arg_195_1.tipsGo_, false)

		function arg_195_1.onSingleLineFinish_()
			arg_195_1.onSingleLineUpdate_ = nil
			arg_195_1.onSingleLineFinish_ = nil
			arg_195_1.state_ = "waiting"

			SetActive(arg_195_1.choicesGo_, true)

			for iter_196_0, iter_196_1 in ipairs(arg_195_1.choices_) do
				local var_196_0 = iter_196_0 <= 3

				SetActive(iter_196_1.go, var_196_0)
			end

			arg_195_1.choices_[1].txt.text = arg_195_1:FormatText(StoryChoiceCfg[1627].name)
			arg_195_1.choices_[2].txt.text = arg_195_1:FormatText(StoryChoiceCfg[1628].name)
			arg_195_1.choices_[3].txt.text = arg_195_1:FormatText(StoryChoiceCfg[1629].name)
		end

		function arg_195_1.playNext_(arg_197_0)
			if arg_197_0 == 1 then
				arg_195_0:Play324541049(arg_195_1)
			end

			if arg_197_0 == 2 then
				arg_195_0:Play324541049(arg_195_1)
			end

			if arg_197_0 == 3 then
				arg_195_0:Play324541049(arg_195_1)
			end

			arg_195_1:RecordChoiceLog(324541048, 1627, 1628, 1629)
		end

		function arg_195_1.onSingleLineUpdate_(arg_198_0)
			local var_198_0 = arg_195_1.actors_["1037ui_story"]
			local var_198_1 = 0

			if var_198_1 < arg_195_1.time_ and arg_195_1.time_ <= var_198_1 + arg_198_0 and not isNil(var_198_0) and arg_195_1.var_.characterEffect1037ui_story == nil then
				arg_195_1.var_.characterEffect1037ui_story = var_198_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_198_2 = 0.200000002980232

			if var_198_1 <= arg_195_1.time_ and arg_195_1.time_ < var_198_1 + var_198_2 and not isNil(var_198_0) then
				local var_198_3 = (arg_195_1.time_ - var_198_1) / var_198_2

				if arg_195_1.var_.characterEffect1037ui_story and not isNil(var_198_0) then
					local var_198_4 = Mathf.Lerp(0, 0.5, var_198_3)

					arg_195_1.var_.characterEffect1037ui_story.fillFlat = true
					arg_195_1.var_.characterEffect1037ui_story.fillRatio = var_198_4
				end
			end

			if arg_195_1.time_ >= var_198_1 + var_198_2 and arg_195_1.time_ < var_198_1 + var_198_2 + arg_198_0 and not isNil(var_198_0) and arg_195_1.var_.characterEffect1037ui_story then
				local var_198_5 = 0.5

				arg_195_1.var_.characterEffect1037ui_story.fillFlat = true
				arg_195_1.var_.characterEffect1037ui_story.fillRatio = var_198_5
			end
		end

		arg_195_1.nodeConfigList_ = {}

		arg_195_1:InitPlayNodeList()
	end,
	Play324541049 = function(arg_199_0, arg_199_1)
		arg_199_1.time_ = 0
		arg_199_1.frameCnt_ = 0
		arg_199_1.state_ = "playing"
		arg_199_1.curTalkId_ = 324541049
		arg_199_1.duration_ = 1.07

		SetActive(arg_199_1.tipsGo_, false)

		function arg_199_1.onSingleLineFinish_()
			arg_199_1.onSingleLineUpdate_ = nil
			arg_199_1.onSingleLineFinish_ = nil
			arg_199_1.state_ = "waiting"
		end

		function arg_199_1.playNext_(arg_201_0)
			if arg_201_0 == 1 then
				arg_199_0:Play324541050(arg_199_1)
			end
		end

		function arg_199_1.onSingleLineUpdate_(arg_202_0)
			local var_202_0 = 0.0333333333333333

			if var_202_0 < arg_199_1.time_ and arg_199_1.time_ <= var_202_0 + arg_202_0 then
				arg_199_1.fswbg_:SetActive(true)
				arg_199_1.dialog_:SetActive(false)

				arg_199_1.fswtw_.percent = 0

				local var_202_1 = arg_199_1:GetWordFromCfg(324541047)
				local var_202_2 = arg_199_1:FormatText(var_202_1.content)

				arg_199_1.fswt_.text = var_202_2

				LuaForUtil.ClearLinePrefixSymbol(arg_199_1.fswt_)

				arg_199_1.fswt_:GetComponent("Text").color = Color(1, 1, 1)
				arg_199_1.fswbg_.transform:Find("textbox/bg"):GetComponent("Image").enabled = false

				arg_199_1.fswtw_:SetDirty()

				arg_199_1.typewritterCharCountI18N = 0

				SetActive(arg_199_1.fswtw_.transform.parent.parent:Find("bg/line").gameObject, false)
				arg_199_1:ShowNextGo(false)
			end

			local var_202_3 = 0.266666666666667

			if var_202_3 < arg_199_1.time_ and arg_199_1.time_ <= var_202_3 + arg_202_0 then
				arg_199_1.var_.oldValueTypewriter = arg_199_1.fswtw_.percent

				SetActive(arg_199_1.fswtw_.transform.parent.parent:Find("bg/line").gameObject, false)
				arg_199_1:ShowNextGo(false)
			end

			local var_202_4 = 12
			local var_202_5 = 0.8
			local var_202_6 = arg_199_1:GetWordFromCfg(324541047)
			local var_202_7 = arg_199_1:FormatText(var_202_6.content)
			local var_202_8, var_202_9 = arg_199_1:GetPercentByPara(var_202_7, 1)

			if var_202_3 < arg_199_1.time_ and arg_199_1.time_ <= var_202_3 + arg_202_0 then
				arg_199_1.talkMaxDuration = 0

				local var_202_10 = var_202_4 <= 0 and var_202_5 or var_202_5 * ((var_202_9 - arg_199_1.typewritterCharCountI18N) / var_202_4)

				if var_202_10 > 0 and var_202_5 < var_202_10 then
					arg_199_1.talkMaxDuration = var_202_10

					if var_202_10 + var_202_3 > arg_199_1.duration_ then
						arg_199_1.duration_ = var_202_10 + var_202_3
					end
				end
			end

			local var_202_11 = 0.8
			local var_202_12 = math.max(var_202_11, arg_199_1.talkMaxDuration)

			if var_202_3 <= arg_199_1.time_ and arg_199_1.time_ < var_202_3 + var_202_12 then
				local var_202_13 = (arg_199_1.time_ - var_202_3) / var_202_12

				arg_199_1.fswtw_.percent = Mathf.Lerp(arg_199_1.var_.oldValueTypewriter, var_202_8, var_202_13)
				arg_199_1.fswt_:GetComponent("Text").color = Color(1, 1, 1)

				arg_199_1.fswtw_:SetDirty()
			end

			if arg_199_1.time_ >= var_202_3 + var_202_12 and arg_199_1.time_ < var_202_3 + var_202_12 + arg_202_0 then
				arg_199_1.fswtw_.percent = var_202_8

				arg_199_1.fswtw_:SetDirty()
				arg_199_1:ShowNextGo(true)

				arg_199_1.typewritterCharCountI18N = var_202_9
			end

			local var_202_14 = 0

			if var_202_14 < arg_199_1.time_ and arg_199_1.time_ <= var_202_14 + arg_202_0 then
				arg_199_1.mask_.enabled = true
				arg_199_1.mask_.raycastTarget = true

				arg_199_1:SetGaussion(false)
			end

			local var_202_15 = 0.433333333333333

			if var_202_14 <= arg_199_1.time_ and arg_199_1.time_ < var_202_14 + var_202_15 then
				local var_202_16 = (arg_199_1.time_ - var_202_14) / var_202_15
				local var_202_17 = Color.New(1, 1, 1)

				var_202_17.a = Mathf.Lerp(1, 0, var_202_16)
				arg_199_1.mask_.color = var_202_17
			end

			if arg_199_1.time_ >= var_202_14 + var_202_15 and arg_199_1.time_ < var_202_14 + var_202_15 + arg_202_0 then
				local var_202_18 = Color.New(1, 1, 1)
				local var_202_19 = 0

				arg_199_1.mask_.enabled = false
				var_202_18.a = var_202_19
				arg_199_1.mask_.color = var_202_18
			end

			local var_202_20 = 0.433333333333333

			if var_202_20 < arg_199_1.time_ and arg_199_1.time_ <= var_202_20 + arg_202_0 then
				arg_199_1.mask_.enabled = true
				arg_199_1.mask_.raycastTarget = true

				arg_199_1:SetGaussion(false)
			end

			local var_202_21 = 0.433333333333333

			if var_202_20 <= arg_199_1.time_ and arg_199_1.time_ < var_202_20 + var_202_21 then
				local var_202_22 = (arg_199_1.time_ - var_202_20) / var_202_21
				local var_202_23 = Color.New(1, 1, 1)

				var_202_23.a = Mathf.Lerp(1, 0, var_202_22)
				arg_199_1.mask_.color = var_202_23
			end

			if arg_199_1.time_ >= var_202_20 + var_202_21 and arg_199_1.time_ < var_202_20 + var_202_21 + arg_202_0 then
				local var_202_24 = Color.New(1, 1, 1)
				local var_202_25 = 0

				arg_199_1.mask_.enabled = false
				var_202_24.a = var_202_25
				arg_199_1.mask_.color = var_202_24
			end

			local var_202_26 = 0
			local var_202_27 = 1
			local var_202_28 = manager.audio:GetVoiceLength("story_v_out_324541", "324541049", "0") / 1000

			if var_202_28 > 0 and var_202_27 < var_202_28 and var_202_28 + var_202_26 > arg_199_1.duration_ then
				local var_202_29 = var_202_28

				arg_199_1.duration_ = var_202_28 + var_202_26
			end

			if var_202_26 < arg_199_1.time_ and arg_199_1.time_ <= var_202_26 + arg_202_0 then
				local var_202_30 = "play"
				local var_202_31 = "voice"

				arg_199_1:AudioAction(var_202_30, var_202_31, "story_v_out_324541", "324541049", "0")
			end
		end

		arg_199_1.nodeConfigList_ = {}

		arg_199_1:InitPlayNodeList()
	end,
	Play324541050 = function(arg_203_0, arg_203_1)
		arg_203_1.time_ = 0
		arg_203_1.frameCnt_ = 0
		arg_203_1.state_ = "playing"
		arg_203_1.curTalkId_ = 324541050
		arg_203_1.duration_ = 1.1

		SetActive(arg_203_1.tipsGo_, false)

		function arg_203_1.onSingleLineFinish_()
			arg_203_1.onSingleLineUpdate_ = nil
			arg_203_1.onSingleLineFinish_ = nil
			arg_203_1.state_ = "waiting"
		end

		function arg_203_1.playNext_(arg_205_0)
			if arg_205_0 == 1 then
				arg_203_0:Play324541051(arg_203_1)
			end
		end

		function arg_203_1.onSingleLineUpdate_(arg_206_0)
			local var_206_0 = 0

			if var_206_0 < arg_203_1.time_ and arg_203_1.time_ <= var_206_0 + arg_206_0 then
				arg_203_1.fswbg_:SetActive(true)
				arg_203_1.dialog_:SetActive(false)

				arg_203_1.fswtw_.percent = 0

				local var_206_1 = arg_203_1:GetWordFromCfg(324541050)
				local var_206_2 = arg_203_1:FormatText(var_206_1.content)

				arg_203_1.fswt_.text = var_206_2

				LuaForUtil.ClearLinePrefixSymbol(arg_203_1.fswt_)

				arg_203_1.fswt_:GetComponent("Text").color = Color(1, 1, 1)
				arg_203_1.fswbg_.transform:Find("textbox/bg"):GetComponent("Image").enabled = false

				arg_203_1.fswtw_:SetDirty()

				arg_203_1.typewritterCharCountI18N = 0

				SetActive(arg_203_1.fswtw_.transform.parent.parent:Find("bg/line").gameObject, false)
				arg_203_1:ShowNextGo(false)
			end

			local var_206_3 = 0.266666666666667

			if var_206_3 < arg_203_1.time_ and arg_203_1.time_ <= var_206_3 + arg_206_0 then
				arg_203_1.var_.oldValueTypewriter = arg_203_1.fswtw_.percent

				SetActive(arg_203_1.fswtw_.transform.parent.parent:Find("bg/line").gameObject, false)
				arg_203_1:ShowNextGo(false)
			end

			local var_206_4 = 0
			local var_206_5 = 0.233333333333333
			local var_206_6 = arg_203_1:GetWordFromCfg(324541050)
			local var_206_7 = arg_203_1:FormatText(var_206_6.content)
			local var_206_8, var_206_9 = arg_203_1:GetPercentByPara(var_206_7, 1)

			if var_206_3 < arg_203_1.time_ and arg_203_1.time_ <= var_206_3 + arg_206_0 then
				arg_203_1.talkMaxDuration = 0

				local var_206_10 = var_206_4 <= 0 and var_206_5 or var_206_5 * ((var_206_9 - arg_203_1.typewritterCharCountI18N) / var_206_4)

				if var_206_10 > 0 and var_206_5 < var_206_10 then
					arg_203_1.talkMaxDuration = var_206_10

					if var_206_10 + var_206_3 > arg_203_1.duration_ then
						arg_203_1.duration_ = var_206_10 + var_206_3
					end
				end
			end

			local var_206_11 = 0.233333333333333
			local var_206_12 = math.max(var_206_11, arg_203_1.talkMaxDuration)

			if var_206_3 <= arg_203_1.time_ and arg_203_1.time_ < var_206_3 + var_206_12 then
				local var_206_13 = (arg_203_1.time_ - var_206_3) / var_206_12

				arg_203_1.fswtw_.percent = Mathf.Lerp(arg_203_1.var_.oldValueTypewriter, var_206_8, var_206_13)
				arg_203_1.fswt_:GetComponent("Text").color = Color(1, 1, 1)

				arg_203_1.fswtw_:SetDirty()
			end

			if arg_203_1.time_ >= var_206_3 + var_206_12 and arg_203_1.time_ < var_206_3 + var_206_12 + arg_206_0 then
				arg_203_1.fswtw_.percent = var_206_8

				arg_203_1.fswtw_:SetDirty()
				arg_203_1:ShowNextGo(true)

				arg_203_1.typewritterCharCountI18N = var_206_9
			end

			local var_206_14 = 0

			if var_206_14 < arg_203_1.time_ and arg_203_1.time_ <= var_206_14 + arg_206_0 then
				arg_203_1.mask_.enabled = true
				arg_203_1.mask_.raycastTarget = true

				arg_203_1:SetGaussion(false)
			end

			local var_206_15 = 0.433333333333333

			if var_206_14 <= arg_203_1.time_ and arg_203_1.time_ < var_206_14 + var_206_15 then
				local var_206_16 = (arg_203_1.time_ - var_206_14) / var_206_15
				local var_206_17 = Color.New(1, 1, 1)

				var_206_17.a = Mathf.Lerp(1, 0, var_206_16)
				arg_203_1.mask_.color = var_206_17
			end

			if arg_203_1.time_ >= var_206_14 + var_206_15 and arg_203_1.time_ < var_206_14 + var_206_15 + arg_206_0 then
				local var_206_18 = Color.New(1, 1, 1)
				local var_206_19 = 0

				arg_203_1.mask_.enabled = false
				var_206_18.a = var_206_19
				arg_203_1.mask_.color = var_206_18
			end

			local var_206_20 = 0.433333333333333

			if var_206_20 < arg_203_1.time_ and arg_203_1.time_ <= var_206_20 + arg_206_0 then
				arg_203_1.mask_.enabled = true
				arg_203_1.mask_.raycastTarget = true

				arg_203_1:SetGaussion(false)
			end

			local var_206_21 = 0.433333333333333

			if var_206_20 <= arg_203_1.time_ and arg_203_1.time_ < var_206_20 + var_206_21 then
				local var_206_22 = (arg_203_1.time_ - var_206_20) / var_206_21
				local var_206_23 = Color.New(1, 1, 1)

				var_206_23.a = Mathf.Lerp(1, 0, var_206_22)
				arg_203_1.mask_.color = var_206_23
			end

			if arg_203_1.time_ >= var_206_20 + var_206_21 and arg_203_1.time_ < var_206_20 + var_206_21 + arg_206_0 then
				local var_206_24 = Color.New(1, 1, 1)
				local var_206_25 = 0

				arg_203_1.mask_.enabled = false
				var_206_24.a = var_206_25
				arg_203_1.mask_.color = var_206_24
			end

			local var_206_26 = 0.666666666666667

			if var_206_26 < arg_203_1.time_ and arg_203_1.time_ <= var_206_26 + arg_206_0 then
				arg_203_1.mask_.enabled = true
				arg_203_1.mask_.raycastTarget = true

				arg_203_1:SetGaussion(false)
			end

			local var_206_27 = 0.433333333333333

			if var_206_26 <= arg_203_1.time_ and arg_203_1.time_ < var_206_26 + var_206_27 then
				local var_206_28 = (arg_203_1.time_ - var_206_26) / var_206_27
				local var_206_29 = Color.New(1, 1, 1)

				var_206_29.a = Mathf.Lerp(1, 0, var_206_28)
				arg_203_1.mask_.color = var_206_29
			end

			if arg_203_1.time_ >= var_206_26 + var_206_27 and arg_203_1.time_ < var_206_26 + var_206_27 + arg_206_0 then
				local var_206_30 = Color.New(1, 1, 1)
				local var_206_31 = 0

				arg_203_1.mask_.enabled = false
				var_206_30.a = var_206_31
				arg_203_1.mask_.color = var_206_30
			end

			local var_206_32 = 0.1
			local var_206_33 = 1

			if var_206_32 < arg_203_1.time_ and arg_203_1.time_ <= var_206_32 + arg_206_0 then
				local var_206_34 = "play"
				local var_206_35 = "effect"

				arg_203_1:AudioAction(var_206_34, var_206_35, "se_story_side_1095", "se_story_side_1095_amb_beach_night", "")
			end

			local var_206_36 = 0.1
			local var_206_37 = 1

			if var_206_36 < arg_203_1.time_ and arg_203_1.time_ <= var_206_36 + arg_206_0 then
				local var_206_38 = "play"
				local var_206_39 = "effect"

				arg_203_1:AudioAction(var_206_38, var_206_39, "se_story_150", "se_story_150_beach_down", "")
			end

			local var_206_40 = 0
			local var_206_41 = 1
			local var_206_42 = manager.audio:GetVoiceLength("story_v_out_324541", "324541050", "0") / 1000

			if var_206_42 > 0 and var_206_41 < var_206_42 and var_206_42 + var_206_40 > arg_203_1.duration_ then
				local var_206_43 = var_206_42

				arg_203_1.duration_ = var_206_42 + var_206_40
			end

			if var_206_40 < arg_203_1.time_ and arg_203_1.time_ <= var_206_40 + arg_206_0 then
				local var_206_44 = "play"
				local var_206_45 = "voice"

				arg_203_1:AudioAction(var_206_44, var_206_45, "story_v_out_324541", "324541050", "0")
			end
		end

		arg_203_1.nodeConfigList_ = {}

		arg_203_1:InitPlayNodeList()
	end,
	Play324541051 = function(arg_207_0, arg_207_1)
		arg_207_1.time_ = 0
		arg_207_1.frameCnt_ = 0
		arg_207_1.state_ = "playing"
		arg_207_1.curTalkId_ = 324541051
		arg_207_1.duration_ = 7.2

		SetActive(arg_207_1.tipsGo_, false)

		function arg_207_1.onSingleLineFinish_()
			arg_207_1.onSingleLineUpdate_ = nil
			arg_207_1.onSingleLineFinish_ = nil
			arg_207_1.state_ = "waiting"
		end

		function arg_207_1.playNext_(arg_209_0)
			if arg_209_0 == 1 then
				arg_207_0:Play324541052(arg_207_1)
			end
		end

		function arg_207_1.onSingleLineUpdate_(arg_210_0)
			local var_210_0 = arg_207_1.actors_["1037ui_story"]
			local var_210_1 = 0

			if var_210_1 < arg_207_1.time_ and arg_207_1.time_ <= var_210_1 + arg_210_0 and not isNil(var_210_0) and arg_207_1.var_.characterEffect1037ui_story == nil then
				arg_207_1.var_.characterEffect1037ui_story = var_210_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_210_2 = 0.200000002980232

			if var_210_1 <= arg_207_1.time_ and arg_207_1.time_ < var_210_1 + var_210_2 and not isNil(var_210_0) then
				local var_210_3 = (arg_207_1.time_ - var_210_1) / var_210_2

				if arg_207_1.var_.characterEffect1037ui_story and not isNil(var_210_0) then
					local var_210_4 = Mathf.Lerp(0, 0.5, var_210_3)

					arg_207_1.var_.characterEffect1037ui_story.fillFlat = true
					arg_207_1.var_.characterEffect1037ui_story.fillRatio = var_210_4
				end
			end

			if arg_207_1.time_ >= var_210_1 + var_210_2 and arg_207_1.time_ < var_210_1 + var_210_2 + arg_210_0 and not isNil(var_210_0) and arg_207_1.var_.characterEffect1037ui_story then
				local var_210_5 = 0.5

				arg_207_1.var_.characterEffect1037ui_story.fillFlat = true
				arg_207_1.var_.characterEffect1037ui_story.fillRatio = var_210_5
			end

			local var_210_6 = 0.0333333333333333

			if var_210_6 < arg_207_1.time_ and arg_207_1.time_ <= var_210_6 + arg_210_0 then
				arg_207_1.fswbg_:SetActive(false)
				arg_207_1.dialog_:SetActive(false)
				SetActive(arg_207_1.fswtw_.transform.parent.parent:Find("bg/line").gameObject, false)
				arg_207_1:ShowNextGo(false)
			end

			local var_210_7 = 0.266666666666667

			if var_210_7 < arg_207_1.time_ and arg_207_1.time_ <= var_210_7 + arg_210_0 then
				arg_207_1.fswbg_:SetActive(false)
				arg_207_1.dialog_:SetActive(false)
				SetActive(arg_207_1.fswtw_.transform.parent.parent:Find("bg/line").gameObject, false)
				arg_207_1:ShowNextGo(false)
			end

			local var_210_8 = 0

			if var_210_8 < arg_207_1.time_ and arg_207_1.time_ <= var_210_8 + arg_210_0 then
				arg_207_1.allBtn_.enabled = false
			end

			local var_210_9 = 2.2

			if arg_207_1.time_ >= var_210_8 + var_210_9 and arg_207_1.time_ < var_210_8 + var_210_9 + arg_210_0 then
				arg_207_1.allBtn_.enabled = true
			end

			local var_210_10 = manager.ui.mainCamera.transform
			local var_210_11 = 0

			if var_210_11 < arg_207_1.time_ and arg_207_1.time_ <= var_210_11 + arg_210_0 then
				local var_210_12 = arg_207_1.var_.effectfdsfsf
				local var_210_13
				local var_210_14 = var_210_10

				if not var_210_12 then
					var_210_12 = Object.Instantiate(Asset.Load("Effect/Scene/fx_uistory_starheart"), var_210_14)
					var_210_12.name = "fdsfsf"
					arg_207_1.var_.effectfdsfsf = var_210_12
				else
					var_210_12.transform:SetParent(var_210_14)
				end

				var_210_12.transform.localPosition = Vector3.New(0, -0.2, 0)
				var_210_12.transform.localRotation = Quaternion.Euler(0, 0, 0)
			end

			local var_210_15 = 0.1
			local var_210_16 = 1

			if var_210_15 < arg_207_1.time_ and arg_207_1.time_ <= var_210_15 + arg_210_0 then
				local var_210_17 = "play"
				local var_210_18 = "effect"

				arg_207_1:AudioAction(var_210_17, var_210_18, "se_story_150", "se_story_150_beach_up", "")
			end

			local var_210_19 = 0
			local var_210_20 = 1

			if var_210_19 < arg_207_1.time_ and arg_207_1.time_ <= var_210_19 + arg_210_0 then
				local var_210_21 = "play"
				local var_210_22 = "effect"

				arg_207_1:AudioAction(var_210_21, var_210_22, "ui_battle", "ui_battle_stopbgm", "")
			end

			local var_210_23 = 0

			if var_210_23 < arg_207_1.time_ and arg_207_1.time_ <= var_210_23 + arg_210_0 then
				arg_207_1.cswbg_:SetActive(false)
			end

			if arg_207_1.frameCnt_ <= 1 then
				arg_207_1.dialog_:SetActive(false)
			end

			local var_210_24 = 2.2
			local var_210_25 = 0.175

			if var_210_24 < arg_207_1.time_ and arg_207_1.time_ <= var_210_24 + arg_210_0 then
				arg_207_1.talkMaxDuration = 0

				arg_207_1.dialog_:SetActive(true)

				arg_207_1.dialogCg_.alpha = 0

				local var_210_26 = LeanTween.value(arg_207_1.dialog_, 0, 1, 0.3)

				var_210_26:setOnUpdate(LuaHelper.FloatAction(function(arg_211_0)
					arg_207_1.dialogCg_.alpha = arg_211_0
				end))
				var_210_26:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_207_1.dialog_)
					var_210_26:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_207_1.duration_ = arg_207_1.duration_ + 0.3

				SetActive(arg_207_1.leftNameGo_, false)

				arg_207_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_207_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_207_1:RecordName(arg_207_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_207_1.iconTrs_.gameObject, false)
				arg_207_1.callingController_:SetSelectedState("normal")

				local var_210_27 = arg_207_1:GetWordFromCfg(324541051)
				local var_210_28 = arg_207_1:FormatText(var_210_27.content)

				arg_207_1.text_.text = var_210_28

				LuaForUtil.ClearLinePrefixSymbol(arg_207_1.text_)

				local var_210_29 = 7
				local var_210_30 = utf8.len(var_210_28)
				local var_210_31 = var_210_29 <= 0 and var_210_25 or var_210_25 * (var_210_30 / var_210_29)

				if var_210_31 > 0 and var_210_25 < var_210_31 then
					arg_207_1.talkMaxDuration = var_210_31
					var_210_24 = var_210_24 + 0.3

					if var_210_31 + var_210_24 > arg_207_1.duration_ then
						arg_207_1.duration_ = var_210_31 + var_210_24
					end
				end

				arg_207_1.text_.text = var_210_28
				arg_207_1.typewritter.percent = 0

				arg_207_1.typewritter:SetDirty()
				arg_207_1:ShowNextGo(false)
				arg_207_1:RecordContent(arg_207_1.text_.text)
			end

			local var_210_32 = var_210_24 + 0.3
			local var_210_33 = math.max(var_210_25, arg_207_1.talkMaxDuration)

			if var_210_32 <= arg_207_1.time_ and arg_207_1.time_ < var_210_32 + var_210_33 then
				arg_207_1.typewritter.percent = (arg_207_1.time_ - var_210_32) / var_210_33

				arg_207_1.typewritter:SetDirty()
			end

			if arg_207_1.time_ >= var_210_32 + var_210_33 and arg_207_1.time_ < var_210_32 + var_210_33 + arg_210_0 then
				arg_207_1.typewritter.percent = 1

				arg_207_1.typewritter:SetDirty()
				arg_207_1:ShowNextGo(true)
			end
		end

		arg_207_1.nodeConfigList_ = {}

		arg_207_1:InitPlayNodeList()
	end,
	Play324541052 = function(arg_213_0, arg_213_1)
		arg_213_1.time_ = 0
		arg_213_1.frameCnt_ = 0
		arg_213_1.state_ = "playing"
		arg_213_1.curTalkId_ = 324541052
		arg_213_1.duration_ = 5.18

		SetActive(arg_213_1.tipsGo_, false)

		function arg_213_1.onSingleLineFinish_()
			arg_213_1.onSingleLineUpdate_ = nil
			arg_213_1.onSingleLineFinish_ = nil
			arg_213_1.state_ = "waiting"
		end

		function arg_213_1.playNext_(arg_215_0)
			if arg_215_0 == 1 then
				arg_213_0:Play324541053(arg_213_1)
			end
		end

		function arg_213_1.onSingleLineUpdate_(arg_216_0)
			local var_216_0 = 0

			if var_216_0 < arg_213_1.time_ and arg_213_1.time_ <= var_216_0 + arg_216_0 then
				arg_213_1.cswbg_:SetActive(true)

				local var_216_1 = arg_213_1.cswt_:GetComponent("RectTransform")

				arg_213_1.cswt_.alignment = UnityEngine.TextAnchor.MiddleCenter
				var_216_1.offsetMin = Vector2.New(400, 300)
				var_216_1.offsetMax = Vector2.New(-400, -200)

				local var_216_2 = arg_213_1:GetWordFromCfg(419185)
				local var_216_3 = arg_213_1:FormatText(var_216_2.content)

				arg_213_1.cswt_.text = var_216_3

				LuaForUtil.ClearLinePrefixSymbol(arg_213_1.cswt_)

				arg_213_1.cswt_.fontSize = 108
				arg_213_1.cswt_:GetComponent("Text").color = Color(1, 1, 1)

				arg_213_1.cswt_:GetComponent("I18NTextKeyToValue"):SetFontPath("Fonts/SourceHanSerifCN-Bold-3.0")

				arg_213_1.cswt_.font = Asset.Load("Fonts/SourceHanSerifCN-Bold-3.0")
			end

			local var_216_4 = 0.866666666666667

			if var_216_4 < arg_213_1.time_ and arg_213_1.time_ <= var_216_4 + arg_216_0 then
				arg_213_1.cswbg_:SetActive(true)

				local var_216_5 = arg_213_1.cswt_:GetComponent("RectTransform")

				arg_213_1.cswt_.alignment = UnityEngine.TextAnchor.MiddleCenter
				var_216_5.offsetMin = Vector2.New(400, 300)
				var_216_5.offsetMax = Vector2.New(-400, -200)

				local var_216_6 = arg_213_1:GetWordFromCfg(419186)
				local var_216_7 = arg_213_1:FormatText(var_216_6.content)

				arg_213_1.cswt_.text = var_216_7

				LuaForUtil.ClearLinePrefixSymbol(arg_213_1.cswt_)

				arg_213_1.cswt_.fontSize = 108
				arg_213_1.cswt_:GetComponent("Text").color = Color(1, 1, 1)

				arg_213_1.cswt_:GetComponent("I18NTextKeyToValue"):SetFontPath("Fonts/SourceHanSerifCN-Bold-3.0")

				arg_213_1.cswt_.font = Asset.Load("Fonts/SourceHanSerifCN-Bold-3.0")
			end

			local var_216_8 = 0

			if var_216_8 < arg_213_1.time_ and arg_213_1.time_ <= var_216_8 + arg_216_0 then
				arg_213_1.allBtn_.enabled = false
			end

			local var_216_9 = 1.86666666666667

			if arg_213_1.time_ >= var_216_8 + var_216_9 and arg_213_1.time_ < var_216_8 + var_216_9 + arg_216_0 then
				arg_213_1.allBtn_.enabled = true
			end

			local var_216_10 = manager.ui.mainCamera.transform
			local var_216_11 = 0.4

			if var_216_11 < arg_213_1.time_ and arg_213_1.time_ <= var_216_11 + arg_216_0 then
				local var_216_12 = arg_213_1.var_.effectdsdsd
				local var_216_13
				local var_216_14 = var_216_10

				if not var_216_12 then
					var_216_12 = Object.Instantiate(Asset.Load("Effect/Scene/fx_uistory_erro2_small"), var_216_14)
					var_216_12.name = "dsdsd"
					arg_213_1.var_.effectdsdsd = var_216_12
				else
					var_216_12.transform:SetParent(var_216_14)
				end

				var_216_12.transform.localPosition = Vector3.New(0, 0.04, 1.15)
				var_216_12.transform.localRotation = Quaternion.Euler(0, 0, 0)
			end

			local var_216_15 = manager.ui.mainCamera.transform
			local var_216_16 = 1.46666666666667

			if var_216_16 < arg_213_1.time_ and arg_213_1.time_ <= var_216_16 + arg_216_0 then
				local var_216_17 = arg_213_1.var_.effectdsdsd

				if var_216_17 then
					Object.Destroy(var_216_17)

					arg_213_1.var_.effectdsdsd = nil
				end
			end

			if arg_213_1.frameCnt_ <= 1 then
				arg_213_1.dialog_:SetActive(false)
			end

			local var_216_18 = 0.175
			local var_216_19 = 0.825

			if var_216_18 < arg_213_1.time_ and arg_213_1.time_ <= var_216_18 + arg_216_0 then
				arg_213_1.talkMaxDuration = 0

				arg_213_1.dialog_:SetActive(true)

				arg_213_1.dialogCg_.alpha = 0

				local var_216_20 = LeanTween.value(arg_213_1.dialog_, 0, 1, 0.3)

				var_216_20:setOnUpdate(LuaHelper.FloatAction(function(arg_217_0)
					arg_213_1.dialogCg_.alpha = arg_217_0
				end))
				var_216_20:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_213_1.dialog_)
					var_216_20:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_213_1.duration_ = arg_213_1.duration_ + 0.3

				SetActive(arg_213_1.leftNameGo_, false)

				arg_213_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_213_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_213_1:RecordName(arg_213_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_213_1.iconTrs_.gameObject, false)
				arg_213_1.callingController_:SetSelectedState("normal")

				local var_216_21 = arg_213_1:GetWordFromCfg(324541052)
				local var_216_22 = arg_213_1:FormatText(var_216_21.content)

				arg_213_1.text_.text = var_216_22

				LuaForUtil.ClearLinePrefixSymbol(arg_213_1.text_)

				local var_216_23 = 33
				local var_216_24 = utf8.len(var_216_22)
				local var_216_25 = var_216_23 <= 0 and var_216_19 or var_216_19 * (var_216_24 / var_216_23)

				if var_216_25 > 0 and var_216_19 < var_216_25 then
					arg_213_1.talkMaxDuration = var_216_25
					var_216_18 = var_216_18 + 0.3

					if var_216_25 + var_216_18 > arg_213_1.duration_ then
						arg_213_1.duration_ = var_216_25 + var_216_18
					end
				end

				arg_213_1.text_.text = var_216_22
				arg_213_1.typewritter.percent = 0

				arg_213_1.typewritter:SetDirty()
				arg_213_1:ShowNextGo(false)
				arg_213_1:RecordContent(arg_213_1.text_.text)
			end

			local var_216_26 = var_216_18 + 0.3
			local var_216_27 = math.max(var_216_19, arg_213_1.talkMaxDuration)

			if var_216_26 <= arg_213_1.time_ and arg_213_1.time_ < var_216_26 + var_216_27 then
				arg_213_1.typewritter.percent = (arg_213_1.time_ - var_216_26) / var_216_27

				arg_213_1.typewritter:SetDirty()
			end

			if arg_213_1.time_ >= var_216_26 + var_216_27 and arg_213_1.time_ < var_216_26 + var_216_27 + arg_216_0 then
				arg_213_1.typewritter.percent = 1

				arg_213_1.typewritter:SetDirty()
				arg_213_1:ShowNextGo(true)
			end
		end

		arg_213_1.nodeConfigList_ = {}

		arg_213_1:InitPlayNodeList()
	end,
	Play324541053 = function(arg_219_0, arg_219_1)
		arg_219_1.time_ = 0
		arg_219_1.frameCnt_ = 0
		arg_219_1.state_ = "playing"
		arg_219_1.curTalkId_ = 324541053
		arg_219_1.duration_ = 5

		SetActive(arg_219_1.tipsGo_, false)

		function arg_219_1.onSingleLineFinish_()
			arg_219_1.onSingleLineUpdate_ = nil
			arg_219_1.onSingleLineFinish_ = nil
			arg_219_1.state_ = "waiting"
		end

		function arg_219_1.playNext_(arg_221_0)
			if arg_221_0 == 1 then
				arg_219_0:Play324541054(arg_219_1)
			end
		end

		function arg_219_1.onSingleLineUpdate_(arg_222_0)
			local var_222_0 = 0

			if var_222_0 < arg_219_1.time_ and arg_219_1.time_ <= var_222_0 + arg_222_0 then
				arg_219_1.cswbg_:SetActive(true)

				local var_222_1 = arg_219_1.cswt_:GetComponent("RectTransform")

				arg_219_1.cswt_.alignment = UnityEngine.TextAnchor.MiddleCenter
				var_222_1.offsetMin = Vector2.New(400, 300)
				var_222_1.offsetMax = Vector2.New(-400, -200)

				local var_222_2 = arg_219_1:GetWordFromCfg(419187)
				local var_222_3 = arg_219_1:FormatText(var_222_2.content)

				arg_219_1.cswt_.text = var_222_3

				LuaForUtil.ClearLinePrefixSymbol(arg_219_1.cswt_)

				arg_219_1.cswt_.fontSize = 108
				arg_219_1.cswt_:GetComponent("Text").color = Color(1, 1, 1)

				arg_219_1.cswt_:GetComponent("I18NTextKeyToValue"):SetFontPath("Fonts/SourceHanSerifCN-Bold-3.0")

				arg_219_1.cswt_.font = Asset.Load("Fonts/SourceHanSerifCN-Bold-3.0")
			end

			local var_222_4 = 0.666666666666667

			if var_222_4 < arg_219_1.time_ and arg_219_1.time_ <= var_222_4 + arg_222_0 then
				arg_219_1.cswbg_:SetActive(true)

				local var_222_5 = arg_219_1.cswt_:GetComponent("RectTransform")

				arg_219_1.cswt_.alignment = UnityEngine.TextAnchor.MiddleCenter
				var_222_5.offsetMin = Vector2.New(400, 300)
				var_222_5.offsetMax = Vector2.New(-400, -200)

				local var_222_6 = arg_219_1:GetWordFromCfg(419188)
				local var_222_7 = arg_219_1:FormatText(var_222_6.content)

				arg_219_1.cswt_.text = var_222_7

				LuaForUtil.ClearLinePrefixSymbol(arg_219_1.cswt_)

				arg_219_1.cswt_.fontSize = 108
				arg_219_1.cswt_:GetComponent("Text").color = Color(1, 1, 1)

				arg_219_1.cswt_:GetComponent("I18NTextKeyToValue"):SetFontPath("Fonts/SourceHanSerifCN-Bold-3.0")

				arg_219_1.cswt_.font = Asset.Load("Fonts/SourceHanSerifCN-Bold-3.0")
			end

			local var_222_8 = 1.43333333333333

			if var_222_8 < arg_219_1.time_ and arg_219_1.time_ <= var_222_8 + arg_222_0 then
				arg_219_1.cswbg_:SetActive(true)

				local var_222_9 = arg_219_1.cswt_:GetComponent("RectTransform")

				arg_219_1.cswt_.alignment = UnityEngine.TextAnchor.MiddleCenter
				var_222_9.offsetMin = Vector2.New(400, 300)
				var_222_9.offsetMax = Vector2.New(-400, -200)

				local var_222_10 = arg_219_1:GetWordFromCfg(419189)
				local var_222_11 = arg_219_1:FormatText(var_222_10.content)

				arg_219_1.cswt_.text = var_222_11

				LuaForUtil.ClearLinePrefixSymbol(arg_219_1.cswt_)

				arg_219_1.cswt_.fontSize = 108
				arg_219_1.cswt_:GetComponent("Text").color = Color(1, 1, 1)

				arg_219_1.cswt_:GetComponent("I18NTextKeyToValue"):SetFontPath("Fonts/SourceHanSerifCN-Bold-3.0")

				arg_219_1.cswt_.font = Asset.Load("Fonts/SourceHanSerifCN-Bold-3.0")
			end

			local var_222_12 = manager.ui.mainCamera.transform
			local var_222_13 = 1

			if var_222_13 < arg_219_1.time_ and arg_219_1.time_ <= var_222_13 + arg_222_0 then
				local var_222_14 = arg_219_1.var_.effectewqew
				local var_222_15
				local var_222_16 = var_222_12

				if not var_222_14 then
					var_222_14 = Object.Instantiate(Asset.Load("Effect/Scene/fx_uistory_erro2_big"), var_222_16)
					var_222_14.name = "ewqew"
					arg_219_1.var_.effectewqew = var_222_14
				else
					var_222_14.transform:SetParent(var_222_16)
				end

				var_222_14.transform.localPosition = Vector3.New(0, 0, 0)
				var_222_14.transform.localRotation = Quaternion.Euler(0, 0, 0)
			end

			local var_222_17 = manager.ui.mainCamera.transform
			local var_222_18 = 2.26666666666667

			if var_222_18 < arg_219_1.time_ and arg_219_1.time_ <= var_222_18 + arg_222_0 then
				local var_222_19 = arg_219_1.var_.effectewqew

				if var_222_19 then
					Object.Destroy(var_222_19)

					arg_219_1.var_.effectewqew = nil
				end
			end

			local var_222_20 = 0

			if var_222_20 < arg_219_1.time_ and arg_219_1.time_ <= var_222_20 + arg_222_0 then
				arg_219_1.allBtn_.enabled = false
			end

			local var_222_21 = 1.8

			if arg_219_1.time_ >= var_222_20 + var_222_21 and arg_219_1.time_ < var_222_20 + var_222_21 + arg_222_0 then
				arg_219_1.allBtn_.enabled = true
			end

			local var_222_22 = 0
			local var_222_23 = 0.575

			if var_222_22 < arg_219_1.time_ and arg_219_1.time_ <= var_222_22 + arg_222_0 then
				arg_219_1.talkMaxDuration = 0
				arg_219_1.dialogCg_.alpha = 1

				arg_219_1.dialog_:SetActive(true)
				SetActive(arg_219_1.leftNameGo_, false)

				arg_219_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_219_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_219_1:RecordName(arg_219_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_219_1.iconTrs_.gameObject, false)
				arg_219_1.callingController_:SetSelectedState("normal")

				local var_222_24 = arg_219_1:GetWordFromCfg(324541053)
				local var_222_25 = arg_219_1:FormatText(var_222_24.content)

				arg_219_1.text_.text = var_222_25

				LuaForUtil.ClearLinePrefixSymbol(arg_219_1.text_)

				local var_222_26 = 23
				local var_222_27 = utf8.len(var_222_25)
				local var_222_28 = var_222_26 <= 0 and var_222_23 or var_222_23 * (var_222_27 / var_222_26)

				if var_222_28 > 0 and var_222_23 < var_222_28 then
					arg_219_1.talkMaxDuration = var_222_28

					if var_222_28 + var_222_22 > arg_219_1.duration_ then
						arg_219_1.duration_ = var_222_28 + var_222_22
					end
				end

				arg_219_1.text_.text = var_222_25
				arg_219_1.typewritter.percent = 0

				arg_219_1.typewritter:SetDirty()
				arg_219_1:ShowNextGo(false)
				arg_219_1:RecordContent(arg_219_1.text_.text)
			end

			local var_222_29 = math.max(var_222_23, arg_219_1.talkMaxDuration)

			if var_222_22 <= arg_219_1.time_ and arg_219_1.time_ < var_222_22 + var_222_29 then
				arg_219_1.typewritter.percent = (arg_219_1.time_ - var_222_22) / var_222_29

				arg_219_1.typewritter:SetDirty()
			end

			if arg_219_1.time_ >= var_222_22 + var_222_29 and arg_219_1.time_ < var_222_22 + var_222_29 + arg_222_0 then
				arg_219_1.typewritter.percent = 1

				arg_219_1.typewritter:SetDirty()
				arg_219_1:ShowNextGo(true)
			end
		end

		arg_219_1.nodeConfigList_ = {}

		arg_219_1:InitPlayNodeList()
	end,
	Play324541054 = function(arg_223_0, arg_223_1)
		arg_223_1.time_ = 0
		arg_223_1.frameCnt_ = 0
		arg_223_1.state_ = "playing"
		arg_223_1.curTalkId_ = 324541054
		arg_223_1.duration_ = 7.43

		SetActive(arg_223_1.tipsGo_, false)

		function arg_223_1.onSingleLineFinish_()
			arg_223_1.onSingleLineUpdate_ = nil
			arg_223_1.onSingleLineFinish_ = nil
			arg_223_1.state_ = "waiting"
			arg_223_1.auto_ = false
		end

		function arg_223_1.playNext_(arg_225_0)
			arg_223_1.onStoryFinished_()
		end

		function arg_223_1.onSingleLineUpdate_(arg_226_0)
			local var_226_0 = 0

			if var_226_0 < arg_223_1.time_ and arg_223_1.time_ <= var_226_0 + arg_226_0 then
				arg_223_1.cswbg_:SetActive(true)

				local var_226_1 = arg_223_1.cswt_:GetComponent("RectTransform")

				arg_223_1.cswt_.alignment = UnityEngine.TextAnchor.MiddleCenter
				var_226_1.offsetMin = Vector2.New(400, 300)
				var_226_1.offsetMax = Vector2.New(-400, -200)

				local var_226_2 = arg_223_1:GetWordFromCfg(419190)
				local var_226_3 = arg_223_1:FormatText(var_226_2.content)

				arg_223_1.cswt_.text = var_226_3

				LuaForUtil.ClearLinePrefixSymbol(arg_223_1.cswt_)

				arg_223_1.cswt_.fontSize = 108
				arg_223_1.cswt_:GetComponent("Text").color = Color(1, 1, 1)

				arg_223_1.cswt_:GetComponent("I18NTextKeyToValue"):SetFontPath("Fonts/SourceHanSerifCN-Bold-3.0")

				arg_223_1.cswt_.font = Asset.Load("Fonts/SourceHanSerifCN-Bold-3.0")
			end

			local var_226_4 = 0.4

			if var_226_4 < arg_223_1.time_ and arg_223_1.time_ <= var_226_4 + arg_226_0 then
				arg_223_1.cswbg_:SetActive(true)

				local var_226_5 = arg_223_1.cswt_:GetComponent("RectTransform")

				arg_223_1.cswt_.alignment = UnityEngine.TextAnchor.MiddleCenter
				var_226_5.offsetMin = Vector2.New(400, 300)
				var_226_5.offsetMax = Vector2.New(-400, -200)

				local var_226_6 = arg_223_1:GetWordFromCfg(419191)
				local var_226_7 = arg_223_1:FormatText(var_226_6.content)

				arg_223_1.cswt_.text = var_226_7

				LuaForUtil.ClearLinePrefixSymbol(arg_223_1.cswt_)

				arg_223_1.cswt_.fontSize = 108
				arg_223_1.cswt_:GetComponent("Text").color = Color(1, 1, 1)

				arg_223_1.cswt_:GetComponent("I18NTextKeyToValue"):SetFontPath("Fonts/SourceHanSerifCN-Bold-3.0")

				arg_223_1.cswt_.font = Asset.Load("Fonts/SourceHanSerifCN-Bold-3.0")
			end

			local var_226_8 = 0.6

			if var_226_8 < arg_223_1.time_ and arg_223_1.time_ <= var_226_8 + arg_226_0 then
				arg_223_1.cswbg_:SetActive(true)

				local var_226_9 = arg_223_1.cswt_:GetComponent("RectTransform")

				arg_223_1.cswt_.alignment = UnityEngine.TextAnchor.MiddleCenter
				var_226_9.offsetMin = Vector2.New(400, 300)
				var_226_9.offsetMax = Vector2.New(-400, -200)

				local var_226_10 = arg_223_1:GetWordFromCfg(419192)
				local var_226_11 = arg_223_1:FormatText(var_226_10.content)

				arg_223_1.cswt_.text = var_226_11

				LuaForUtil.ClearLinePrefixSymbol(arg_223_1.cswt_)

				arg_223_1.cswt_.fontSize = 108
				arg_223_1.cswt_:GetComponent("Text").color = Color(1, 1, 1)

				arg_223_1.cswt_:GetComponent("I18NTextKeyToValue"):SetFontPath("Fonts/SourceHanSerifCN-Bold-3.0")

				arg_223_1.cswt_.font = Asset.Load("Fonts/SourceHanSerifCN-Bold-3.0")
			end

			local var_226_12 = 0.833333333333333

			if var_226_12 < arg_223_1.time_ and arg_223_1.time_ <= var_226_12 + arg_226_0 then
				arg_223_1.cswbg_:SetActive(true)

				local var_226_13 = arg_223_1.cswt_:GetComponent("RectTransform")

				arg_223_1.cswt_.alignment = UnityEngine.TextAnchor.MiddleCenter
				var_226_13.offsetMin = Vector2.New(400, 300)
				var_226_13.offsetMax = Vector2.New(-400, -200)

				local var_226_14 = arg_223_1:GetWordFromCfg(419193)
				local var_226_15 = arg_223_1:FormatText(var_226_14.content)

				arg_223_1.cswt_.text = var_226_15

				LuaForUtil.ClearLinePrefixSymbol(arg_223_1.cswt_)

				arg_223_1.cswt_.fontSize = 108
				arg_223_1.cswt_:GetComponent("Text").color = Color(1, 1, 1)

				arg_223_1.cswt_:GetComponent("I18NTextKeyToValue"):SetFontPath("Fonts/SourceHanSerifCN-Bold-3.0")

				arg_223_1.cswt_.font = Asset.Load("Fonts/SourceHanSerifCN-Bold-3.0")
			end

			local var_226_16 = 1.19999999999867

			if var_226_16 < arg_223_1.time_ and arg_223_1.time_ <= var_226_16 + arg_226_0 then
				arg_223_1.cswbg_:SetActive(true)

				local var_226_17 = arg_223_1.cswt_:GetComponent("RectTransform")

				arg_223_1.cswt_.alignment = UnityEngine.TextAnchor.MiddleCenter
				var_226_17.offsetMin = Vector2.New(400, 300)
				var_226_17.offsetMax = Vector2.New(-400, -200)

				local var_226_18 = arg_223_1:GetWordFromCfg(419194)
				local var_226_19 = arg_223_1:FormatText(var_226_18.content)

				arg_223_1.cswt_.text = var_226_19

				LuaForUtil.ClearLinePrefixSymbol(arg_223_1.cswt_)

				arg_223_1.cswt_.fontSize = 108
				arg_223_1.cswt_:GetComponent("Text").color = Color(1, 1, 1)

				arg_223_1.cswt_:GetComponent("I18NTextKeyToValue"):SetFontPath("Fonts/SourceHanSerifCN-Bold-3.0")

				arg_223_1.cswt_.font = Asset.Load("Fonts/SourceHanSerifCN-Bold-3.0")
			end

			local var_226_20 = manager.ui.mainCamera.transform
			local var_226_21 = 0.433333333333333

			if var_226_21 < arg_223_1.time_ and arg_223_1.time_ <= var_226_21 + arg_226_0 then
				local var_226_22 = arg_223_1.var_.effect12314
				local var_226_23
				local var_226_24 = var_226_20

				if not var_226_22 then
					var_226_22 = Object.Instantiate(Asset.Load("Effect/Scene/fx_uistory_error"), var_226_24)
					var_226_22.name = "12314"
					arg_223_1.var_.effect12314 = var_226_22
				else
					var_226_22.transform:SetParent(var_226_24)
				end

				var_226_22.transform.localPosition = Vector3.New(0, 0, 0)
				var_226_22.transform.localRotation = Quaternion.Euler(0, 0, 0)

				local var_226_25 = 1.7777777777777777
				local var_226_26 = Screen.width / Screen.height
				local var_226_27 = var_226_26 / var_226_25
				local var_226_28 = Mathf.Max(var_226_25 / var_226_26, 1)

				var_226_22.transform.localScale = Vector3.New(var_226_22.transform.localScale.x * var_226_27, var_226_22.transform.localScale.y * var_226_28, var_226_22.transform.localScale.z)
			end

			local var_226_29 = 0

			if var_226_29 < arg_223_1.time_ and arg_223_1.time_ <= var_226_29 + arg_226_0 then
				arg_223_1.allBtn_.enabled = false
			end

			local var_226_30 = 2.6

			if arg_223_1.time_ >= var_226_29 + var_226_30 and arg_223_1.time_ < var_226_29 + var_226_30 + arg_226_0 then
				arg_223_1.allBtn_.enabled = true
			end

			if arg_223_1.frameCnt_ <= 1 then
				arg_223_1.dialog_:SetActive(false)
			end

			local var_226_31 = 2.43333333333333
			local var_226_32 = 0.3

			if var_226_31 < arg_223_1.time_ and arg_223_1.time_ <= var_226_31 + arg_226_0 then
				arg_223_1.talkMaxDuration = 0

				arg_223_1.dialog_:SetActive(true)

				arg_223_1.dialogCg_.alpha = 0

				local var_226_33 = LeanTween.value(arg_223_1.dialog_, 0, 1, 0.3)

				var_226_33:setOnUpdate(LuaHelper.FloatAction(function(arg_227_0)
					arg_223_1.dialogCg_.alpha = arg_227_0
				end))
				var_226_33:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_223_1.dialog_)
					var_226_33:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_223_1.duration_ = arg_223_1.duration_ + 0.3

				SetActive(arg_223_1.leftNameGo_, false)

				arg_223_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_223_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_223_1:RecordName(arg_223_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_223_1.iconTrs_.gameObject, false)
				arg_223_1.callingController_:SetSelectedState("normal")

				local var_226_34 = arg_223_1:GetWordFromCfg(324541054)
				local var_226_35 = arg_223_1:FormatText(var_226_34.content)

				arg_223_1.text_.text = var_226_35

				LuaForUtil.ClearLinePrefixSymbol(arg_223_1.text_)

				local var_226_36 = 12
				local var_226_37 = utf8.len(var_226_35)
				local var_226_38 = var_226_36 <= 0 and var_226_32 or var_226_32 * (var_226_37 / var_226_36)

				if var_226_38 > 0 and var_226_32 < var_226_38 then
					arg_223_1.talkMaxDuration = var_226_38
					var_226_31 = var_226_31 + 0.3

					if var_226_38 + var_226_31 > arg_223_1.duration_ then
						arg_223_1.duration_ = var_226_38 + var_226_31
					end
				end

				arg_223_1.text_.text = var_226_35
				arg_223_1.typewritter.percent = 0

				arg_223_1.typewritter:SetDirty()
				arg_223_1:ShowNextGo(false)
				arg_223_1:RecordContent(arg_223_1.text_.text)
			end

			local var_226_39 = var_226_31 + 0.3
			local var_226_40 = math.max(var_226_32, arg_223_1.talkMaxDuration)

			if var_226_39 <= arg_223_1.time_ and arg_223_1.time_ < var_226_39 + var_226_40 then
				arg_223_1.typewritter.percent = (arg_223_1.time_ - var_226_39) / var_226_40

				arg_223_1.typewritter:SetDirty()
			end

			if arg_223_1.time_ >= var_226_39 + var_226_40 and arg_223_1.time_ < var_226_39 + var_226_40 + arg_226_0 then
				arg_223_1.typewritter.percent = 1

				arg_223_1.typewritter:SetDirty()
				arg_223_1:ShowNextGo(true)
			end
		end

		arg_223_1.nodeConfigList_ = {}

		arg_223_1:InitPlayNodeList()
	end,
	assets = {
		"TextureConfig/Background/MS2406",
		"TextureConfig/Background/J25f",
		"TextureConfig/Background/STblack"
	},
	voices = {
		"story_v_out_324541.awb"
	}
}
