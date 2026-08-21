return {
	Play325591001 = function(arg_1_0, arg_1_1)
		arg_1_1.time_ = 0
		arg_1_1.frameCnt_ = 0
		arg_1_1.state_ = "playing"
		arg_1_1.curTalkId_ = 325591001
		arg_1_1.duration_ = 7.7

		local var_1_0 = {
			zh = 6.466,
			ja = 7.7
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
				arg_1_0:Play325591002(arg_1_1)
			end
		end

		function arg_1_1.onSingleLineUpdate_(arg_4_0)
			local var_4_0 = "J28f"

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
				local var_4_5 = arg_1_1.bgs_.J28f

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
					if iter_4_0 ~= "J28f" then
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

			local var_4_24 = "1054ui_story"

			if arg_1_1.actors_[var_4_24] == nil then
				local var_4_25 = Asset.Load("Char/" .. "1054ui_story")

				if not isNil(var_4_25) then
					local var_4_26 = Object.Instantiate(Asset.Load("Char/" .. "1054ui_story"), arg_1_1.stage_.transform)

					var_4_26.name = var_4_24
					var_4_26.transform.localPosition = Vector3.New(0, 100, 0)
					arg_1_1.actors_[var_4_24] = var_4_26

					local var_4_27 = var_4_26:GetComponentInChildren(typeof(CharacterEffect))

					var_4_27.enabled = true

					local var_4_28 = GameObjectTools.GetOrAddComponent(var_4_26, typeof(DynamicBoneHelper))

					if var_4_28 then
						var_4_28:EnableDynamicBone(false)
					end

					arg_1_1:ShowWeapon(var_4_27.transform, false)

					arg_1_1.var_[var_4_24 .. "Animator"] = var_4_27.gameObject:GetComponent(typeof(UnityEngine.Animator))
					arg_1_1.var_[var_4_24 .. "Animator"].applyRootMotion = true
					arg_1_1.var_[var_4_24 .. "LipSync"] = var_4_27.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
				end
			end

			local var_4_29 = arg_1_1.actors_["1054ui_story"].transform
			local var_4_30 = 2

			if var_4_30 < arg_1_1.time_ and arg_1_1.time_ <= var_4_30 + arg_4_0 then
				arg_1_1.var_.moveOldPos1054ui_story = var_4_29.localPosition

				local var_4_31 = GameObjectTools.GetOrAddComponent(var_4_29.gameObject, typeof(DynamicBoneHelper))

				if var_4_31 then
					var_4_31:EnableDynamicBone(false)
				end
			end

			local var_4_32 = 0.001

			if var_4_30 <= arg_1_1.time_ and arg_1_1.time_ < var_4_30 + var_4_32 then
				local var_4_33 = (arg_1_1.time_ - var_4_30) / var_4_32
				local var_4_34 = Vector3.New(0, -0.985, -6)

				var_4_29.localPosition = Vector3.Lerp(arg_1_1.var_.moveOldPos1054ui_story, var_4_34, var_4_33)

				local var_4_35 = manager.ui.mainCamera.transform.position - var_4_29.position

				var_4_29.forward = Vector3.New(var_4_35.x, var_4_35.y, var_4_35.z)

				local var_4_36 = var_4_29.localEulerAngles

				var_4_36.z = 0
				var_4_36.x = 0
				var_4_29.localEulerAngles = var_4_36
			end

			if arg_1_1.time_ >= var_4_30 + var_4_32 and arg_1_1.time_ < var_4_30 + var_4_32 + arg_4_0 then
				var_4_29.localPosition = Vector3.New(0, -0.985, -6)

				local var_4_37 = manager.ui.mainCamera.transform.position - var_4_29.position

				var_4_29.forward = Vector3.New(var_4_37.x, var_4_37.y, var_4_37.z)

				local var_4_38 = var_4_29.localEulerAngles

				var_4_38.z = 0
				var_4_38.x = 0
				var_4_29.localEulerAngles = var_4_38

				local var_4_39 = GameObjectTools.GetOrAddComponent(var_4_29.gameObject, typeof(DynamicBoneHelper))

				if var_4_39 then
					var_4_39:EnableDynamicBone(true)
				end
			end

			local var_4_40 = arg_1_1.actors_["1054ui_story"]
			local var_4_41 = 2

			if var_4_41 < arg_1_1.time_ and arg_1_1.time_ <= var_4_41 + arg_4_0 and not isNil(var_4_40) and arg_1_1.var_.characterEffect1054ui_story == nil then
				arg_1_1.var_.characterEffect1054ui_story = var_4_40:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_4_42 = 0.200000002980232

			if var_4_41 <= arg_1_1.time_ and arg_1_1.time_ < var_4_41 + var_4_42 and not isNil(var_4_40) then
				local var_4_43 = (arg_1_1.time_ - var_4_41) / var_4_42

				if arg_1_1.var_.characterEffect1054ui_story and not isNil(var_4_40) then
					arg_1_1.var_.characterEffect1054ui_story.fillFlat = false
				end
			end

			if arg_1_1.time_ >= var_4_41 + var_4_42 and arg_1_1.time_ < var_4_41 + var_4_42 + arg_4_0 and not isNil(var_4_40) and arg_1_1.var_.characterEffect1054ui_story then
				arg_1_1.var_.characterEffect1054ui_story.fillFlat = false
			end

			local var_4_44 = 2

			if var_4_44 < arg_1_1.time_ and arg_1_1.time_ <= var_4_44 + arg_4_0 then
				arg_1_1:PlayTimeline("1054ui_story", "StoryTimeline/CharAction/story1054/story1054action/1054action1_1")
			end

			local var_4_45 = 2

			if var_4_45 < arg_1_1.time_ and arg_1_1.time_ <= var_4_45 + arg_4_0 then
				arg_1_1:PlayTimeline("1054ui_story", "StoryTimeline/CharAction/public_expression/expr_youyu", "EmotionTimelineAnimator")
			end

			local var_4_46 = 0.1
			local var_4_47 = 1

			if var_4_46 < arg_1_1.time_ and arg_1_1.time_ <= var_4_46 + arg_4_0 then
				local var_4_48 = "play"
				local var_4_49 = "effect"

				arg_1_1:AudioAction(var_4_48, var_4_49, "se_story_148", "se_story_148_amb_wind", "")
			end

			local var_4_50 = 0
			local var_4_51 = 1

			if var_4_50 < arg_1_1.time_ and arg_1_1.time_ <= var_4_50 + arg_4_0 then
				local var_4_52 = "play"
				local var_4_53 = "music"

				arg_1_1:AudioAction(var_4_52, var_4_53, "bgm_activity_4_8_story_dahuang_pingyuan", "bgm_activity_4_8_story_dahuang_pingyuan", "bgm_activity_4_8_story_dahuang_pingyuan.awb")

				local var_4_54 = ""
				local var_4_55 = manager.audio:GetAudioName("bgm_activity_4_8_story_dahuang_pingyuan", "bgm_activity_4_8_story_dahuang_pingyuan")

				if var_4_55 ~= "" then
					if arg_1_1.bgmTxt_.text ~= var_4_55 and arg_1_1.bgmTxt_.text ~= "" then
						if arg_1_1.bgmTxt2_.text ~= "" then
							arg_1_1.bgmTxt_.text = arg_1_1.bgmTxt2_.text
						end

						arg_1_1.bgmTxt2_.text = var_4_55

						arg_1_1.musicChangeAnimator_:Play("music_change", 0, 0)
					else
						arg_1_1.bgmTxt_.text = var_4_55
						arg_1_1.bgmTxt2_.text = var_4_55
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

			local var_4_56 = 2
			local var_4_57 = 0.425

			if var_4_56 < arg_1_1.time_ and arg_1_1.time_ <= var_4_56 + arg_4_0 then
				arg_1_1.talkMaxDuration = 0

				arg_1_1.dialog_:SetActive(true)

				arg_1_1.dialogCg_.alpha = 0

				local var_4_58 = LeanTween.value(arg_1_1.dialog_, 0, 1, 0.3)

				var_4_58:setOnUpdate(LuaHelper.FloatAction(function(arg_6_0)
					arg_1_1.dialogCg_.alpha = arg_6_0
				end))
				var_4_58:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_1_1.dialog_)
					var_4_58:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_1_1.duration_ = arg_1_1.duration_ + 0.3

				SetActive(arg_1_1.leftNameGo_, true)

				local var_4_59 = arg_1_1:FormatText(StoryNameCfg[1487].name)

				arg_1_1.leftNameTxt_.text = var_4_59

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_1_1.leftNameTxt_.transform)

				arg_1_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_1_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_1_1:RecordName(arg_1_1.leftNameTxt_.text)
				SetActive(arg_1_1.iconTrs_.gameObject, false)
				arg_1_1.callingController_:SetSelectedState("normal")

				local var_4_60 = arg_1_1:GetWordFromCfg(325591001)
				local var_4_61 = arg_1_1:FormatText(var_4_60.content)

				arg_1_1.text_.text = var_4_61

				LuaForUtil.ClearLinePrefixSymbol(arg_1_1.text_)

				local var_4_62 = 17
				local var_4_63 = utf8.len(var_4_61)
				local var_4_64 = var_4_62 <= 0 and var_4_57 or var_4_57 * (var_4_63 / var_4_62)

				if var_4_64 > 0 and var_4_57 < var_4_64 then
					arg_1_1.talkMaxDuration = var_4_64
					var_4_56 = var_4_56 + 0.3

					if var_4_64 + var_4_56 > arg_1_1.duration_ then
						arg_1_1.duration_ = var_4_64 + var_4_56
					end
				end

				arg_1_1.text_.text = var_4_61
				arg_1_1.typewritter.percent = 0

				arg_1_1.typewritter:SetDirty()
				arg_1_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_325591", "325591001", "story_v_out_325591.awb") ~= 0 then
					local var_4_65 = manager.audio:GetVoiceLength("story_v_out_325591", "325591001", "story_v_out_325591.awb") / 1000

					if var_4_65 + var_4_56 > arg_1_1.duration_ then
						arg_1_1.duration_ = var_4_65 + var_4_56
					end

					if var_4_60.prefab_name ~= "" and arg_1_1.actors_[var_4_60.prefab_name] ~= nil then
						local var_4_66 = LuaForUtil.PlayVoiceWithCriLipsync(arg_1_1.actors_[var_4_60.prefab_name].transform, "story_v_out_325591", "325591001", "story_v_out_325591.awb")

						arg_1_1:RecordAudio("325591001", var_4_66)
						arg_1_1:RecordAudio("325591001", var_4_66)
					else
						arg_1_1:AudioAction("play", "voice", "story_v_out_325591", "325591001", "story_v_out_325591.awb")
					end

					arg_1_1:RecordHistoryTalkVoice("story_v_out_325591", "325591001", "story_v_out_325591.awb")
				end

				arg_1_1:RecordContent(arg_1_1.text_.text)
			end

			local var_4_67 = var_4_56 + 0.3
			local var_4_68 = math.max(var_4_57, arg_1_1.talkMaxDuration)

			if var_4_67 <= arg_1_1.time_ and arg_1_1.time_ < var_4_67 + var_4_68 then
				arg_1_1.typewritter.percent = (arg_1_1.time_ - var_4_67) / var_4_68

				arg_1_1.typewritter:SetDirty()
			end

			if arg_1_1.time_ >= var_4_67 + var_4_68 and arg_1_1.time_ < var_4_67 + var_4_68 + arg_4_0 then
				arg_1_1.typewritter.percent = 1

				arg_1_1.typewritter:SetDirty()
				arg_1_1:ShowNextGo(true)
			end
		end

		arg_1_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1054ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 2,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_1_1:InitPlayNodeList()
	end,
	Play325591002 = function(arg_8_0, arg_8_1)
		arg_8_1.time_ = 0
		arg_8_1.frameCnt_ = 0
		arg_8_1.state_ = "playing"
		arg_8_1.curTalkId_ = 325591002
		arg_8_1.duration_ = 5

		SetActive(arg_8_1.tipsGo_, false)

		function arg_8_1.onSingleLineFinish_()
			arg_8_1.onSingleLineUpdate_ = nil
			arg_8_1.onSingleLineFinish_ = nil
			arg_8_1.state_ = "waiting"
		end

		function arg_8_1.playNext_(arg_10_0)
			if arg_10_0 == 1 then
				arg_8_0:Play325591003(arg_8_1)
			end
		end

		function arg_8_1.onSingleLineUpdate_(arg_11_0)
			local var_11_0 = arg_8_1.actors_["1054ui_story"].transform
			local var_11_1 = 0

			if var_11_1 < arg_8_1.time_ and arg_8_1.time_ <= var_11_1 + arg_11_0 then
				arg_8_1.var_.moveOldPos1054ui_story = var_11_0.localPosition

				local var_11_2 = GameObjectTools.GetOrAddComponent(var_11_0.gameObject, typeof(DynamicBoneHelper))

				if var_11_2 then
					var_11_2:EnableDynamicBone(false)
				end
			end

			local var_11_3 = 0.001

			if var_11_1 <= arg_8_1.time_ and arg_8_1.time_ < var_11_1 + var_11_3 then
				local var_11_4 = (arg_8_1.time_ - var_11_1) / var_11_3
				local var_11_5 = Vector3.New(0, 100, 0)

				var_11_0.localPosition = Vector3.Lerp(arg_8_1.var_.moveOldPos1054ui_story, var_11_5, var_11_4)

				local var_11_6 = manager.ui.mainCamera.transform.position - var_11_0.position

				var_11_0.forward = Vector3.New(var_11_6.x, var_11_6.y, var_11_6.z)

				local var_11_7 = var_11_0.localEulerAngles

				var_11_7.z = 0
				var_11_7.x = 0
				var_11_0.localEulerAngles = var_11_7
			end

			if arg_8_1.time_ >= var_11_1 + var_11_3 and arg_8_1.time_ < var_11_1 + var_11_3 + arg_11_0 then
				var_11_0.localPosition = Vector3.New(0, 100, 0)

				local var_11_8 = manager.ui.mainCamera.transform.position - var_11_0.position

				var_11_0.forward = Vector3.New(var_11_8.x, var_11_8.y, var_11_8.z)

				local var_11_9 = var_11_0.localEulerAngles

				var_11_9.z = 0
				var_11_9.x = 0
				var_11_0.localEulerAngles = var_11_9

				local var_11_10 = GameObjectTools.GetOrAddComponent(var_11_0.gameObject, typeof(DynamicBoneHelper))

				if var_11_10 then
					var_11_10:EnableDynamicBone(true)
				end
			end

			local var_11_11 = arg_8_1.actors_["1054ui_story"]
			local var_11_12 = 0

			if var_11_12 < arg_8_1.time_ and arg_8_1.time_ <= var_11_12 + arg_11_0 and not isNil(var_11_11) and arg_8_1.var_.characterEffect1054ui_story == nil then
				arg_8_1.var_.characterEffect1054ui_story = var_11_11:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_11_13 = 0.200000002980232

			if var_11_12 <= arg_8_1.time_ and arg_8_1.time_ < var_11_12 + var_11_13 and not isNil(var_11_11) then
				local var_11_14 = (arg_8_1.time_ - var_11_12) / var_11_13

				if arg_8_1.var_.characterEffect1054ui_story and not isNil(var_11_11) then
					local var_11_15 = Mathf.Lerp(0, 0.5, var_11_14)

					arg_8_1.var_.characterEffect1054ui_story.fillFlat = true
					arg_8_1.var_.characterEffect1054ui_story.fillRatio = var_11_15
				end
			end

			if arg_8_1.time_ >= var_11_12 + var_11_13 and arg_8_1.time_ < var_11_12 + var_11_13 + arg_11_0 and not isNil(var_11_11) and arg_8_1.var_.characterEffect1054ui_story then
				local var_11_16 = 0.5

				arg_8_1.var_.characterEffect1054ui_story.fillFlat = true
				arg_8_1.var_.characterEffect1054ui_story.fillRatio = var_11_16
			end

			local var_11_17 = 0
			local var_11_18 = 1.75

			if var_11_17 < arg_8_1.time_ and arg_8_1.time_ <= var_11_17 + arg_11_0 then
				arg_8_1.talkMaxDuration = 0
				arg_8_1.dialogCg_.alpha = 1

				arg_8_1.dialog_:SetActive(true)
				SetActive(arg_8_1.leftNameGo_, false)

				arg_8_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_8_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_8_1:RecordName(arg_8_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_8_1.iconTrs_.gameObject, false)
				arg_8_1.callingController_:SetSelectedState("normal")

				local var_11_19 = arg_8_1:GetWordFromCfg(325591002)
				local var_11_20 = arg_8_1:FormatText(var_11_19.content)

				arg_8_1.text_.text = var_11_20

				LuaForUtil.ClearLinePrefixSymbol(arg_8_1.text_)

				local var_11_21 = 70
				local var_11_22 = utf8.len(var_11_20)
				local var_11_23 = var_11_21 <= 0 and var_11_18 or var_11_18 * (var_11_22 / var_11_21)

				if var_11_23 > 0 and var_11_18 < var_11_23 then
					arg_8_1.talkMaxDuration = var_11_23

					if var_11_23 + var_11_17 > arg_8_1.duration_ then
						arg_8_1.duration_ = var_11_23 + var_11_17
					end
				end

				arg_8_1.text_.text = var_11_20
				arg_8_1.typewritter.percent = 0

				arg_8_1.typewritter:SetDirty()
				arg_8_1:ShowNextGo(false)
				arg_8_1:RecordContent(arg_8_1.text_.text)
			end

			local var_11_24 = math.max(var_11_18, arg_8_1.talkMaxDuration)

			if var_11_17 <= arg_8_1.time_ and arg_8_1.time_ < var_11_17 + var_11_24 then
				arg_8_1.typewritter.percent = (arg_8_1.time_ - var_11_17) / var_11_24

				arg_8_1.typewritter:SetDirty()
			end

			if arg_8_1.time_ >= var_11_17 + var_11_24 and arg_8_1.time_ < var_11_17 + var_11_24 + arg_11_0 then
				arg_8_1.typewritter.percent = 1

				arg_8_1.typewritter:SetDirty()
				arg_8_1:ShowNextGo(true)
			end
		end

		arg_8_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1054ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_8_1:InitPlayNodeList()
	end,
	Play325591003 = function(arg_12_0, arg_12_1)
		arg_12_1.time_ = 0
		arg_12_1.frameCnt_ = 0
		arg_12_1.state_ = "playing"
		arg_12_1.curTalkId_ = 325591003
		arg_12_1.duration_ = 10.23

		local var_12_0 = {
			zh = 6.9,
			ja = 10.233
		}
		local var_12_1 = manager.audio:GetLocalizationFlag()

		if var_12_0[var_12_1] ~= nil then
			arg_12_1.duration_ = var_12_0[var_12_1]
		end

		SetActive(arg_12_1.tipsGo_, false)

		function arg_12_1.onSingleLineFinish_()
			arg_12_1.onSingleLineUpdate_ = nil
			arg_12_1.onSingleLineFinish_ = nil
			arg_12_1.state_ = "waiting"
		end

		function arg_12_1.playNext_(arg_14_0)
			if arg_14_0 == 1 then
				arg_12_0:Play325591004(arg_12_1)
			end
		end

		function arg_12_1.onSingleLineUpdate_(arg_15_0)
			local var_15_0 = "6148ui_story"

			if arg_12_1.actors_[var_15_0] == nil then
				local var_15_1 = Asset.Load("Char/" .. "6148ui_story")

				if not isNil(var_15_1) then
					local var_15_2 = Object.Instantiate(Asset.Load("Char/" .. "6148ui_story"), arg_12_1.stage_.transform)

					var_15_2.name = var_15_0
					var_15_2.transform.localPosition = Vector3.New(0, 100, 0)
					arg_12_1.actors_[var_15_0] = var_15_2

					local var_15_3 = var_15_2:GetComponentInChildren(typeof(CharacterEffect))

					var_15_3.enabled = true

					local var_15_4 = GameObjectTools.GetOrAddComponent(var_15_2, typeof(DynamicBoneHelper))

					if var_15_4 then
						var_15_4:EnableDynamicBone(false)
					end

					arg_12_1:ShowWeapon(var_15_3.transform, false)

					arg_12_1.var_[var_15_0 .. "Animator"] = var_15_3.gameObject:GetComponent(typeof(UnityEngine.Animator))
					arg_12_1.var_[var_15_0 .. "Animator"].applyRootMotion = true
					arg_12_1.var_[var_15_0 .. "LipSync"] = var_15_3.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
				end
			end

			local var_15_5 = arg_12_1.actors_["6148ui_story"].transform
			local var_15_6 = 0

			if var_15_6 < arg_12_1.time_ and arg_12_1.time_ <= var_15_6 + arg_15_0 then
				arg_12_1.var_.moveOldPos6148ui_story = var_15_5.localPosition

				local var_15_7 = GameObjectTools.GetOrAddComponent(var_15_5.gameObject, typeof(DynamicBoneHelper))

				if var_15_7 then
					var_15_7:EnableDynamicBone(false)
				end
			end

			local var_15_8 = 0.001

			if var_15_6 <= arg_12_1.time_ and arg_12_1.time_ < var_15_6 + var_15_8 then
				local var_15_9 = (arg_12_1.time_ - var_15_6) / var_15_8
				local var_15_10 = Vector3.New(0, -0.985, -6)

				var_15_5.localPosition = Vector3.Lerp(arg_12_1.var_.moveOldPos6148ui_story, var_15_10, var_15_9)

				local var_15_11 = manager.ui.mainCamera.transform.position - var_15_5.position

				var_15_5.forward = Vector3.New(var_15_11.x, var_15_11.y, var_15_11.z)

				local var_15_12 = var_15_5.localEulerAngles

				var_15_12.z = 0
				var_15_12.x = 0
				var_15_5.localEulerAngles = var_15_12
			end

			if arg_12_1.time_ >= var_15_6 + var_15_8 and arg_12_1.time_ < var_15_6 + var_15_8 + arg_15_0 then
				var_15_5.localPosition = Vector3.New(0, -0.985, -6)

				local var_15_13 = manager.ui.mainCamera.transform.position - var_15_5.position

				var_15_5.forward = Vector3.New(var_15_13.x, var_15_13.y, var_15_13.z)

				local var_15_14 = var_15_5.localEulerAngles

				var_15_14.z = 0
				var_15_14.x = 0
				var_15_5.localEulerAngles = var_15_14

				local var_15_15 = GameObjectTools.GetOrAddComponent(var_15_5.gameObject, typeof(DynamicBoneHelper))

				if var_15_15 then
					var_15_15:EnableDynamicBone(true)
				end
			end

			local var_15_16 = arg_12_1.actors_["6148ui_story"]
			local var_15_17 = 0

			if var_15_17 < arg_12_1.time_ and arg_12_1.time_ <= var_15_17 + arg_15_0 and not isNil(var_15_16) and arg_12_1.var_.characterEffect6148ui_story == nil then
				arg_12_1.var_.characterEffect6148ui_story = var_15_16:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_15_18 = 0.200000002980232

			if var_15_17 <= arg_12_1.time_ and arg_12_1.time_ < var_15_17 + var_15_18 and not isNil(var_15_16) then
				local var_15_19 = (arg_12_1.time_ - var_15_17) / var_15_18

				if arg_12_1.var_.characterEffect6148ui_story and not isNil(var_15_16) then
					arg_12_1.var_.characterEffect6148ui_story.fillFlat = false
				end
			end

			if arg_12_1.time_ >= var_15_17 + var_15_18 and arg_12_1.time_ < var_15_17 + var_15_18 + arg_15_0 and not isNil(var_15_16) and arg_12_1.var_.characterEffect6148ui_story then
				arg_12_1.var_.characterEffect6148ui_story.fillFlat = false
			end

			local var_15_20 = 0

			if var_15_20 < arg_12_1.time_ and arg_12_1.time_ <= var_15_20 + arg_15_0 then
				arg_12_1:PlayTimeline("6148ui_story", "StoryTimeline/CharAction/story6148/story6148action/6148action1_1")
			end

			local var_15_21 = 0

			if var_15_21 < arg_12_1.time_ and arg_12_1.time_ <= var_15_21 + arg_15_0 then
				arg_12_1:PlayTimeline("6148ui_story", "StoryTimeline/CharAction/public_expression/expr_youyu", "EmotionTimelineAnimator")
			end

			local var_15_22 = 0
			local var_15_23 = 0.925

			if var_15_22 < arg_12_1.time_ and arg_12_1.time_ <= var_15_22 + arg_15_0 then
				arg_12_1.talkMaxDuration = 0
				arg_12_1.dialogCg_.alpha = 1

				arg_12_1.dialog_:SetActive(true)
				SetActive(arg_12_1.leftNameGo_, true)

				local var_15_24 = arg_12_1:FormatText(StoryNameCfg[1488].name)

				arg_12_1.leftNameTxt_.text = var_15_24

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_12_1.leftNameTxt_.transform)

				arg_12_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_12_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_12_1:RecordName(arg_12_1.leftNameTxt_.text)
				SetActive(arg_12_1.iconTrs_.gameObject, false)
				arg_12_1.callingController_:SetSelectedState("normal")

				local var_15_25 = arg_12_1:GetWordFromCfg(325591003)
				local var_15_26 = arg_12_1:FormatText(var_15_25.content)

				arg_12_1.text_.text = var_15_26

				LuaForUtil.ClearLinePrefixSymbol(arg_12_1.text_)

				local var_15_27 = 37
				local var_15_28 = utf8.len(var_15_26)
				local var_15_29 = var_15_27 <= 0 and var_15_23 or var_15_23 * (var_15_28 / var_15_27)

				if var_15_29 > 0 and var_15_23 < var_15_29 then
					arg_12_1.talkMaxDuration = var_15_29

					if var_15_29 + var_15_22 > arg_12_1.duration_ then
						arg_12_1.duration_ = var_15_29 + var_15_22
					end
				end

				arg_12_1.text_.text = var_15_26
				arg_12_1.typewritter.percent = 0

				arg_12_1.typewritter:SetDirty()
				arg_12_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_325591", "325591003", "story_v_out_325591.awb") ~= 0 then
					local var_15_30 = manager.audio:GetVoiceLength("story_v_out_325591", "325591003", "story_v_out_325591.awb") / 1000

					if var_15_30 + var_15_22 > arg_12_1.duration_ then
						arg_12_1.duration_ = var_15_30 + var_15_22
					end

					if var_15_25.prefab_name ~= "" and arg_12_1.actors_[var_15_25.prefab_name] ~= nil then
						local var_15_31 = LuaForUtil.PlayVoiceWithCriLipsync(arg_12_1.actors_[var_15_25.prefab_name].transform, "story_v_out_325591", "325591003", "story_v_out_325591.awb")

						arg_12_1:RecordAudio("325591003", var_15_31)
						arg_12_1:RecordAudio("325591003", var_15_31)
					else
						arg_12_1:AudioAction("play", "voice", "story_v_out_325591", "325591003", "story_v_out_325591.awb")
					end

					arg_12_1:RecordHistoryTalkVoice("story_v_out_325591", "325591003", "story_v_out_325591.awb")
				end

				arg_12_1:RecordContent(arg_12_1.text_.text)
			end

			local var_15_32 = math.max(var_15_23, arg_12_1.talkMaxDuration)

			if var_15_22 <= arg_12_1.time_ and arg_12_1.time_ < var_15_22 + var_15_32 then
				arg_12_1.typewritter.percent = (arg_12_1.time_ - var_15_22) / var_15_32

				arg_12_1.typewritter:SetDirty()
			end

			if arg_12_1.time_ >= var_15_22 + var_15_32 and arg_12_1.time_ < var_15_22 + var_15_32 + arg_15_0 then
				arg_12_1.typewritter.percent = 1

				arg_12_1.typewritter:SetDirty()
				arg_12_1:ShowNextGo(true)
			end
		end

		arg_12_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "6148ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_12_1:InitPlayNodeList()
	end,
	Play325591004 = function(arg_16_0, arg_16_1)
		arg_16_1.time_ = 0
		arg_16_1.frameCnt_ = 0
		arg_16_1.state_ = "playing"
		arg_16_1.curTalkId_ = 325591004
		arg_16_1.duration_ = 4.6

		local var_16_0 = {
			zh = 3.866,
			ja = 4.6
		}
		local var_16_1 = manager.audio:GetLocalizationFlag()

		if var_16_0[var_16_1] ~= nil then
			arg_16_1.duration_ = var_16_0[var_16_1]
		end

		SetActive(arg_16_1.tipsGo_, false)

		function arg_16_1.onSingleLineFinish_()
			arg_16_1.onSingleLineUpdate_ = nil
			arg_16_1.onSingleLineFinish_ = nil
			arg_16_1.state_ = "waiting"
		end

		function arg_16_1.playNext_(arg_18_0)
			if arg_18_0 == 1 then
				arg_16_0:Play325591005(arg_16_1)
			end
		end

		function arg_16_1.onSingleLineUpdate_(arg_19_0)
			local var_19_0 = arg_16_1.actors_["6148ui_story"].transform
			local var_19_1 = 0

			if var_19_1 < arg_16_1.time_ and arg_16_1.time_ <= var_19_1 + arg_19_0 then
				arg_16_1.var_.moveOldPos6148ui_story = var_19_0.localPosition

				local var_19_2 = GameObjectTools.GetOrAddComponent(var_19_0.gameObject, typeof(DynamicBoneHelper))

				if var_19_2 then
					var_19_2:EnableDynamicBone(false)
				end
			end

			local var_19_3 = 0.001

			if var_19_1 <= arg_16_1.time_ and arg_16_1.time_ < var_19_1 + var_19_3 then
				local var_19_4 = (arg_16_1.time_ - var_19_1) / var_19_3
				local var_19_5 = Vector3.New(-0.7, -0.985, -6)

				var_19_0.localPosition = Vector3.Lerp(arg_16_1.var_.moveOldPos6148ui_story, var_19_5, var_19_4)

				local var_19_6 = manager.ui.mainCamera.transform.position - var_19_0.position

				var_19_0.forward = Vector3.New(var_19_6.x, var_19_6.y, var_19_6.z)

				local var_19_7 = var_19_0.localEulerAngles

				var_19_7.z = 0
				var_19_7.x = 0
				var_19_0.localEulerAngles = var_19_7
			end

			if arg_16_1.time_ >= var_19_1 + var_19_3 and arg_16_1.time_ < var_19_1 + var_19_3 + arg_19_0 then
				var_19_0.localPosition = Vector3.New(-0.7, -0.985, -6)

				local var_19_8 = manager.ui.mainCamera.transform.position - var_19_0.position

				var_19_0.forward = Vector3.New(var_19_8.x, var_19_8.y, var_19_8.z)

				local var_19_9 = var_19_0.localEulerAngles

				var_19_9.z = 0
				var_19_9.x = 0
				var_19_0.localEulerAngles = var_19_9

				local var_19_10 = GameObjectTools.GetOrAddComponent(var_19_0.gameObject, typeof(DynamicBoneHelper))

				if var_19_10 then
					var_19_10:EnableDynamicBone(true)
				end
			end

			local var_19_11 = arg_16_1.actors_["1054ui_story"].transform
			local var_19_12 = 0

			if var_19_12 < arg_16_1.time_ and arg_16_1.time_ <= var_19_12 + arg_19_0 then
				arg_16_1.var_.moveOldPos1054ui_story = var_19_11.localPosition

				local var_19_13 = GameObjectTools.GetOrAddComponent(var_19_11.gameObject, typeof(DynamicBoneHelper))

				if var_19_13 then
					var_19_13:EnableDynamicBone(false)
				end
			end

			local var_19_14 = 0.001

			if var_19_12 <= arg_16_1.time_ and arg_16_1.time_ < var_19_12 + var_19_14 then
				local var_19_15 = (arg_16_1.time_ - var_19_12) / var_19_14
				local var_19_16 = Vector3.New(0.7, -0.985, -6)

				var_19_11.localPosition = Vector3.Lerp(arg_16_1.var_.moveOldPos1054ui_story, var_19_16, var_19_15)

				local var_19_17 = manager.ui.mainCamera.transform.position - var_19_11.position

				var_19_11.forward = Vector3.New(var_19_17.x, var_19_17.y, var_19_17.z)

				local var_19_18 = var_19_11.localEulerAngles

				var_19_18.z = 0
				var_19_18.x = 0
				var_19_11.localEulerAngles = var_19_18
			end

			if arg_16_1.time_ >= var_19_12 + var_19_14 and arg_16_1.time_ < var_19_12 + var_19_14 + arg_19_0 then
				var_19_11.localPosition = Vector3.New(0.7, -0.985, -6)

				local var_19_19 = manager.ui.mainCamera.transform.position - var_19_11.position

				var_19_11.forward = Vector3.New(var_19_19.x, var_19_19.y, var_19_19.z)

				local var_19_20 = var_19_11.localEulerAngles

				var_19_20.z = 0
				var_19_20.x = 0
				var_19_11.localEulerAngles = var_19_20

				local var_19_21 = GameObjectTools.GetOrAddComponent(var_19_11.gameObject, typeof(DynamicBoneHelper))

				if var_19_21 then
					var_19_21:EnableDynamicBone(true)
				end
			end

			local var_19_22 = arg_16_1.actors_["1054ui_story"]
			local var_19_23 = 0

			if var_19_23 < arg_16_1.time_ and arg_16_1.time_ <= var_19_23 + arg_19_0 and not isNil(var_19_22) and arg_16_1.var_.characterEffect1054ui_story == nil then
				arg_16_1.var_.characterEffect1054ui_story = var_19_22:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_19_24 = 0.200000002980232

			if var_19_23 <= arg_16_1.time_ and arg_16_1.time_ < var_19_23 + var_19_24 and not isNil(var_19_22) then
				local var_19_25 = (arg_16_1.time_ - var_19_23) / var_19_24

				if arg_16_1.var_.characterEffect1054ui_story and not isNil(var_19_22) then
					arg_16_1.var_.characterEffect1054ui_story.fillFlat = false
				end
			end

			if arg_16_1.time_ >= var_19_23 + var_19_24 and arg_16_1.time_ < var_19_23 + var_19_24 + arg_19_0 and not isNil(var_19_22) and arg_16_1.var_.characterEffect1054ui_story then
				arg_16_1.var_.characterEffect1054ui_story.fillFlat = false
			end

			local var_19_26 = arg_16_1.actors_["6148ui_story"]
			local var_19_27 = 0

			if var_19_27 < arg_16_1.time_ and arg_16_1.time_ <= var_19_27 + arg_19_0 and not isNil(var_19_26) and arg_16_1.var_.characterEffect6148ui_story == nil then
				arg_16_1.var_.characterEffect6148ui_story = var_19_26:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_19_28 = 0.200000002980232

			if var_19_27 <= arg_16_1.time_ and arg_16_1.time_ < var_19_27 + var_19_28 and not isNil(var_19_26) then
				local var_19_29 = (arg_16_1.time_ - var_19_27) / var_19_28

				if arg_16_1.var_.characterEffect6148ui_story and not isNil(var_19_26) then
					local var_19_30 = Mathf.Lerp(0, 0.5, var_19_29)

					arg_16_1.var_.characterEffect6148ui_story.fillFlat = true
					arg_16_1.var_.characterEffect6148ui_story.fillRatio = var_19_30
				end
			end

			if arg_16_1.time_ >= var_19_27 + var_19_28 and arg_16_1.time_ < var_19_27 + var_19_28 + arg_19_0 and not isNil(var_19_26) and arg_16_1.var_.characterEffect6148ui_story then
				local var_19_31 = 0.5

				arg_16_1.var_.characterEffect6148ui_story.fillFlat = true
				arg_16_1.var_.characterEffect6148ui_story.fillRatio = var_19_31
			end

			local var_19_32 = 0
			local var_19_33 = 0.325

			if var_19_32 < arg_16_1.time_ and arg_16_1.time_ <= var_19_32 + arg_19_0 then
				arg_16_1.talkMaxDuration = 0
				arg_16_1.dialogCg_.alpha = 1

				arg_16_1.dialog_:SetActive(true)
				SetActive(arg_16_1.leftNameGo_, true)

				local var_19_34 = arg_16_1:FormatText(StoryNameCfg[1487].name)

				arg_16_1.leftNameTxt_.text = var_19_34

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_16_1.leftNameTxt_.transform)

				arg_16_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_16_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_16_1:RecordName(arg_16_1.leftNameTxt_.text)
				SetActive(arg_16_1.iconTrs_.gameObject, false)
				arg_16_1.callingController_:SetSelectedState("normal")

				local var_19_35 = arg_16_1:GetWordFromCfg(325591004)
				local var_19_36 = arg_16_1:FormatText(var_19_35.content)

				arg_16_1.text_.text = var_19_36

				LuaForUtil.ClearLinePrefixSymbol(arg_16_1.text_)

				local var_19_37 = 13
				local var_19_38 = utf8.len(var_19_36)
				local var_19_39 = var_19_37 <= 0 and var_19_33 or var_19_33 * (var_19_38 / var_19_37)

				if var_19_39 > 0 and var_19_33 < var_19_39 then
					arg_16_1.talkMaxDuration = var_19_39

					if var_19_39 + var_19_32 > arg_16_1.duration_ then
						arg_16_1.duration_ = var_19_39 + var_19_32
					end
				end

				arg_16_1.text_.text = var_19_36
				arg_16_1.typewritter.percent = 0

				arg_16_1.typewritter:SetDirty()
				arg_16_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_325591", "325591004", "story_v_out_325591.awb") ~= 0 then
					local var_19_40 = manager.audio:GetVoiceLength("story_v_out_325591", "325591004", "story_v_out_325591.awb") / 1000

					if var_19_40 + var_19_32 > arg_16_1.duration_ then
						arg_16_1.duration_ = var_19_40 + var_19_32
					end

					if var_19_35.prefab_name ~= "" and arg_16_1.actors_[var_19_35.prefab_name] ~= nil then
						local var_19_41 = LuaForUtil.PlayVoiceWithCriLipsync(arg_16_1.actors_[var_19_35.prefab_name].transform, "story_v_out_325591", "325591004", "story_v_out_325591.awb")

						arg_16_1:RecordAudio("325591004", var_19_41)
						arg_16_1:RecordAudio("325591004", var_19_41)
					else
						arg_16_1:AudioAction("play", "voice", "story_v_out_325591", "325591004", "story_v_out_325591.awb")
					end

					arg_16_1:RecordHistoryTalkVoice("story_v_out_325591", "325591004", "story_v_out_325591.awb")
				end

				arg_16_1:RecordContent(arg_16_1.text_.text)
			end

			local var_19_42 = math.max(var_19_33, arg_16_1.talkMaxDuration)

			if var_19_32 <= arg_16_1.time_ and arg_16_1.time_ < var_19_32 + var_19_42 then
				arg_16_1.typewritter.percent = (arg_16_1.time_ - var_19_32) / var_19_42

				arg_16_1.typewritter:SetDirty()
			end

			if arg_16_1.time_ >= var_19_32 + var_19_42 and arg_16_1.time_ < var_19_32 + var_19_42 + arg_19_0 then
				arg_16_1.typewritter.percent = 1

				arg_16_1.typewritter:SetDirty()
				arg_16_1:ShowNextGo(true)
			end
		end

		arg_16_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "6148ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1054ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_16_1:InitPlayNodeList()
	end,
	Play325591005 = function(arg_20_0, arg_20_1)
		arg_20_1.time_ = 0
		arg_20_1.frameCnt_ = 0
		arg_20_1.state_ = "playing"
		arg_20_1.curTalkId_ = 325591005
		arg_20_1.duration_ = 6.53

		local var_20_0 = {
			zh = 5.433,
			ja = 6.533
		}
		local var_20_1 = manager.audio:GetLocalizationFlag()

		if var_20_0[var_20_1] ~= nil then
			arg_20_1.duration_ = var_20_0[var_20_1]
		end

		SetActive(arg_20_1.tipsGo_, false)

		function arg_20_1.onSingleLineFinish_()
			arg_20_1.onSingleLineUpdate_ = nil
			arg_20_1.onSingleLineFinish_ = nil
			arg_20_1.state_ = "waiting"
		end

		function arg_20_1.playNext_(arg_22_0)
			if arg_22_0 == 1 then
				arg_20_0:Play325591006(arg_20_1)
			end
		end

		function arg_20_1.onSingleLineUpdate_(arg_23_0)
			local var_23_0 = arg_20_1.actors_["6148ui_story"]
			local var_23_1 = 0

			if var_23_1 < arg_20_1.time_ and arg_20_1.time_ <= var_23_1 + arg_23_0 and not isNil(var_23_0) and arg_20_1.var_.characterEffect6148ui_story == nil then
				arg_20_1.var_.characterEffect6148ui_story = var_23_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_23_2 = 0.200000002980232

			if var_23_1 <= arg_20_1.time_ and arg_20_1.time_ < var_23_1 + var_23_2 and not isNil(var_23_0) then
				local var_23_3 = (arg_20_1.time_ - var_23_1) / var_23_2

				if arg_20_1.var_.characterEffect6148ui_story and not isNil(var_23_0) then
					arg_20_1.var_.characterEffect6148ui_story.fillFlat = false
				end
			end

			if arg_20_1.time_ >= var_23_1 + var_23_2 and arg_20_1.time_ < var_23_1 + var_23_2 + arg_23_0 and not isNil(var_23_0) and arg_20_1.var_.characterEffect6148ui_story then
				arg_20_1.var_.characterEffect6148ui_story.fillFlat = false
			end

			local var_23_4 = arg_20_1.actors_["1054ui_story"]
			local var_23_5 = 0

			if var_23_5 < arg_20_1.time_ and arg_20_1.time_ <= var_23_5 + arg_23_0 and not isNil(var_23_4) and arg_20_1.var_.characterEffect1054ui_story == nil then
				arg_20_1.var_.characterEffect1054ui_story = var_23_4:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_23_6 = 0.200000002980232

			if var_23_5 <= arg_20_1.time_ and arg_20_1.time_ < var_23_5 + var_23_6 and not isNil(var_23_4) then
				local var_23_7 = (arg_20_1.time_ - var_23_5) / var_23_6

				if arg_20_1.var_.characterEffect1054ui_story and not isNil(var_23_4) then
					local var_23_8 = Mathf.Lerp(0, 0.5, var_23_7)

					arg_20_1.var_.characterEffect1054ui_story.fillFlat = true
					arg_20_1.var_.characterEffect1054ui_story.fillRatio = var_23_8
				end
			end

			if arg_20_1.time_ >= var_23_5 + var_23_6 and arg_20_1.time_ < var_23_5 + var_23_6 + arg_23_0 and not isNil(var_23_4) and arg_20_1.var_.characterEffect1054ui_story then
				local var_23_9 = 0.5

				arg_20_1.var_.characterEffect1054ui_story.fillFlat = true
				arg_20_1.var_.characterEffect1054ui_story.fillRatio = var_23_9
			end

			local var_23_10 = 0
			local var_23_11 = 0.7

			if var_23_10 < arg_20_1.time_ and arg_20_1.time_ <= var_23_10 + arg_23_0 then
				arg_20_1.talkMaxDuration = 0
				arg_20_1.dialogCg_.alpha = 1

				arg_20_1.dialog_:SetActive(true)
				SetActive(arg_20_1.leftNameGo_, true)

				local var_23_12 = arg_20_1:FormatText(StoryNameCfg[1488].name)

				arg_20_1.leftNameTxt_.text = var_23_12

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_20_1.leftNameTxt_.transform)

				arg_20_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_20_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_20_1:RecordName(arg_20_1.leftNameTxt_.text)
				SetActive(arg_20_1.iconTrs_.gameObject, false)
				arg_20_1.callingController_:SetSelectedState("normal")

				local var_23_13 = arg_20_1:GetWordFromCfg(325591005)
				local var_23_14 = arg_20_1:FormatText(var_23_13.content)

				arg_20_1.text_.text = var_23_14

				LuaForUtil.ClearLinePrefixSymbol(arg_20_1.text_)

				local var_23_15 = 28
				local var_23_16 = utf8.len(var_23_14)
				local var_23_17 = var_23_15 <= 0 and var_23_11 or var_23_11 * (var_23_16 / var_23_15)

				if var_23_17 > 0 and var_23_11 < var_23_17 then
					arg_20_1.talkMaxDuration = var_23_17

					if var_23_17 + var_23_10 > arg_20_1.duration_ then
						arg_20_1.duration_ = var_23_17 + var_23_10
					end
				end

				arg_20_1.text_.text = var_23_14
				arg_20_1.typewritter.percent = 0

				arg_20_1.typewritter:SetDirty()
				arg_20_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_325591", "325591005", "story_v_out_325591.awb") ~= 0 then
					local var_23_18 = manager.audio:GetVoiceLength("story_v_out_325591", "325591005", "story_v_out_325591.awb") / 1000

					if var_23_18 + var_23_10 > arg_20_1.duration_ then
						arg_20_1.duration_ = var_23_18 + var_23_10
					end

					if var_23_13.prefab_name ~= "" and arg_20_1.actors_[var_23_13.prefab_name] ~= nil then
						local var_23_19 = LuaForUtil.PlayVoiceWithCriLipsync(arg_20_1.actors_[var_23_13.prefab_name].transform, "story_v_out_325591", "325591005", "story_v_out_325591.awb")

						arg_20_1:RecordAudio("325591005", var_23_19)
						arg_20_1:RecordAudio("325591005", var_23_19)
					else
						arg_20_1:AudioAction("play", "voice", "story_v_out_325591", "325591005", "story_v_out_325591.awb")
					end

					arg_20_1:RecordHistoryTalkVoice("story_v_out_325591", "325591005", "story_v_out_325591.awb")
				end

				arg_20_1:RecordContent(arg_20_1.text_.text)
			end

			local var_23_20 = math.max(var_23_11, arg_20_1.talkMaxDuration)

			if var_23_10 <= arg_20_1.time_ and arg_20_1.time_ < var_23_10 + var_23_20 then
				arg_20_1.typewritter.percent = (arg_20_1.time_ - var_23_10) / var_23_20

				arg_20_1.typewritter:SetDirty()
			end

			if arg_20_1.time_ >= var_23_10 + var_23_20 and arg_20_1.time_ < var_23_10 + var_23_20 + arg_23_0 then
				arg_20_1.typewritter.percent = 1

				arg_20_1.typewritter:SetDirty()
				arg_20_1:ShowNextGo(true)
			end
		end

		arg_20_1.nodeConfigList_ = {}

		arg_20_1:InitPlayNodeList()
	end,
	Play325591006 = function(arg_24_0, arg_24_1)
		arg_24_1.time_ = 0
		arg_24_1.frameCnt_ = 0
		arg_24_1.state_ = "playing"
		arg_24_1.curTalkId_ = 325591006
		arg_24_1.duration_ = 5.5

		local var_24_0 = {
			zh = 4.966,
			ja = 5.5
		}
		local var_24_1 = manager.audio:GetLocalizationFlag()

		if var_24_0[var_24_1] ~= nil then
			arg_24_1.duration_ = var_24_0[var_24_1]
		end

		SetActive(arg_24_1.tipsGo_, false)

		function arg_24_1.onSingleLineFinish_()
			arg_24_1.onSingleLineUpdate_ = nil
			arg_24_1.onSingleLineFinish_ = nil
			arg_24_1.state_ = "waiting"
		end

		function arg_24_1.playNext_(arg_26_0)
			if arg_26_0 == 1 then
				arg_24_0:Play325591007(arg_24_1)
			end
		end

		function arg_24_1.onSingleLineUpdate_(arg_27_0)
			local var_27_0 = arg_24_1.actors_["1054ui_story"]
			local var_27_1 = 0

			if var_27_1 < arg_24_1.time_ and arg_24_1.time_ <= var_27_1 + arg_27_0 and not isNil(var_27_0) and arg_24_1.var_.characterEffect1054ui_story == nil then
				arg_24_1.var_.characterEffect1054ui_story = var_27_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_27_2 = 0.200000002980232

			if var_27_1 <= arg_24_1.time_ and arg_24_1.time_ < var_27_1 + var_27_2 and not isNil(var_27_0) then
				local var_27_3 = (arg_24_1.time_ - var_27_1) / var_27_2

				if arg_24_1.var_.characterEffect1054ui_story and not isNil(var_27_0) then
					arg_24_1.var_.characterEffect1054ui_story.fillFlat = false
				end
			end

			if arg_24_1.time_ >= var_27_1 + var_27_2 and arg_24_1.time_ < var_27_1 + var_27_2 + arg_27_0 and not isNil(var_27_0) and arg_24_1.var_.characterEffect1054ui_story then
				arg_24_1.var_.characterEffect1054ui_story.fillFlat = false
			end

			local var_27_4 = arg_24_1.actors_["6148ui_story"]
			local var_27_5 = 0

			if var_27_5 < arg_24_1.time_ and arg_24_1.time_ <= var_27_5 + arg_27_0 and not isNil(var_27_4) and arg_24_1.var_.characterEffect6148ui_story == nil then
				arg_24_1.var_.characterEffect6148ui_story = var_27_4:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_27_6 = 0.200000002980232

			if var_27_5 <= arg_24_1.time_ and arg_24_1.time_ < var_27_5 + var_27_6 and not isNil(var_27_4) then
				local var_27_7 = (arg_24_1.time_ - var_27_5) / var_27_6

				if arg_24_1.var_.characterEffect6148ui_story and not isNil(var_27_4) then
					local var_27_8 = Mathf.Lerp(0, 0.5, var_27_7)

					arg_24_1.var_.characterEffect6148ui_story.fillFlat = true
					arg_24_1.var_.characterEffect6148ui_story.fillRatio = var_27_8
				end
			end

			if arg_24_1.time_ >= var_27_5 + var_27_6 and arg_24_1.time_ < var_27_5 + var_27_6 + arg_27_0 and not isNil(var_27_4) and arg_24_1.var_.characterEffect6148ui_story then
				local var_27_9 = 0.5

				arg_24_1.var_.characterEffect6148ui_story.fillFlat = true
				arg_24_1.var_.characterEffect6148ui_story.fillRatio = var_27_9
			end

			local var_27_10 = 0

			if var_27_10 < arg_24_1.time_ and arg_24_1.time_ <= var_27_10 + arg_27_0 then
				arg_24_1:PlayTimeline("1054ui_story", "StoryTimeline/CharAction/story1054/story1054action/1054action4_1")
			end

			local var_27_11 = 0
			local var_27_12 = 0.4

			if var_27_11 < arg_24_1.time_ and arg_24_1.time_ <= var_27_11 + arg_27_0 then
				arg_24_1.talkMaxDuration = 0
				arg_24_1.dialogCg_.alpha = 1

				arg_24_1.dialog_:SetActive(true)
				SetActive(arg_24_1.leftNameGo_, true)

				local var_27_13 = arg_24_1:FormatText(StoryNameCfg[1487].name)

				arg_24_1.leftNameTxt_.text = var_27_13

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_24_1.leftNameTxt_.transform)

				arg_24_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_24_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_24_1:RecordName(arg_24_1.leftNameTxt_.text)
				SetActive(arg_24_1.iconTrs_.gameObject, false)
				arg_24_1.callingController_:SetSelectedState("normal")

				local var_27_14 = arg_24_1:GetWordFromCfg(325591006)
				local var_27_15 = arg_24_1:FormatText(var_27_14.content)

				arg_24_1.text_.text = var_27_15

				LuaForUtil.ClearLinePrefixSymbol(arg_24_1.text_)

				local var_27_16 = 16
				local var_27_17 = utf8.len(var_27_15)
				local var_27_18 = var_27_16 <= 0 and var_27_12 or var_27_12 * (var_27_17 / var_27_16)

				if var_27_18 > 0 and var_27_12 < var_27_18 then
					arg_24_1.talkMaxDuration = var_27_18

					if var_27_18 + var_27_11 > arg_24_1.duration_ then
						arg_24_1.duration_ = var_27_18 + var_27_11
					end
				end

				arg_24_1.text_.text = var_27_15
				arg_24_1.typewritter.percent = 0

				arg_24_1.typewritter:SetDirty()
				arg_24_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_325591", "325591006", "story_v_out_325591.awb") ~= 0 then
					local var_27_19 = manager.audio:GetVoiceLength("story_v_out_325591", "325591006", "story_v_out_325591.awb") / 1000

					if var_27_19 + var_27_11 > arg_24_1.duration_ then
						arg_24_1.duration_ = var_27_19 + var_27_11
					end

					if var_27_14.prefab_name ~= "" and arg_24_1.actors_[var_27_14.prefab_name] ~= nil then
						local var_27_20 = LuaForUtil.PlayVoiceWithCriLipsync(arg_24_1.actors_[var_27_14.prefab_name].transform, "story_v_out_325591", "325591006", "story_v_out_325591.awb")

						arg_24_1:RecordAudio("325591006", var_27_20)
						arg_24_1:RecordAudio("325591006", var_27_20)
					else
						arg_24_1:AudioAction("play", "voice", "story_v_out_325591", "325591006", "story_v_out_325591.awb")
					end

					arg_24_1:RecordHistoryTalkVoice("story_v_out_325591", "325591006", "story_v_out_325591.awb")
				end

				arg_24_1:RecordContent(arg_24_1.text_.text)
			end

			local var_27_21 = math.max(var_27_12, arg_24_1.talkMaxDuration)

			if var_27_11 <= arg_24_1.time_ and arg_24_1.time_ < var_27_11 + var_27_21 then
				arg_24_1.typewritter.percent = (arg_24_1.time_ - var_27_11) / var_27_21

				arg_24_1.typewritter:SetDirty()
			end

			if arg_24_1.time_ >= var_27_11 + var_27_21 and arg_24_1.time_ < var_27_11 + var_27_21 + arg_27_0 then
				arg_24_1.typewritter.percent = 1

				arg_24_1.typewritter:SetDirty()
				arg_24_1:ShowNextGo(true)
			end
		end

		arg_24_1.nodeConfigList_ = {}

		arg_24_1:InitPlayNodeList()
	end,
	Play325591007 = function(arg_28_0, arg_28_1)
		arg_28_1.time_ = 0
		arg_28_1.frameCnt_ = 0
		arg_28_1.state_ = "playing"
		arg_28_1.curTalkId_ = 325591007
		arg_28_1.duration_ = 8.57

		local var_28_0 = {
			zh = 4,
			ja = 8.566
		}
		local var_28_1 = manager.audio:GetLocalizationFlag()

		if var_28_0[var_28_1] ~= nil then
			arg_28_1.duration_ = var_28_0[var_28_1]
		end

		SetActive(arg_28_1.tipsGo_, false)

		function arg_28_1.onSingleLineFinish_()
			arg_28_1.onSingleLineUpdate_ = nil
			arg_28_1.onSingleLineFinish_ = nil
			arg_28_1.state_ = "waiting"
		end

		function arg_28_1.playNext_(arg_30_0)
			if arg_30_0 == 1 then
				arg_28_0:Play325591008(arg_28_1)
			end
		end

		function arg_28_1.onSingleLineUpdate_(arg_31_0)
			local var_31_0 = arg_28_1.actors_["6148ui_story"]
			local var_31_1 = 0

			if var_31_1 < arg_28_1.time_ and arg_28_1.time_ <= var_31_1 + arg_31_0 and not isNil(var_31_0) and arg_28_1.var_.characterEffect6148ui_story == nil then
				arg_28_1.var_.characterEffect6148ui_story = var_31_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_31_2 = 0.200000002980232

			if var_31_1 <= arg_28_1.time_ and arg_28_1.time_ < var_31_1 + var_31_2 and not isNil(var_31_0) then
				local var_31_3 = (arg_28_1.time_ - var_31_1) / var_31_2

				if arg_28_1.var_.characterEffect6148ui_story and not isNil(var_31_0) then
					arg_28_1.var_.characterEffect6148ui_story.fillFlat = false
				end
			end

			if arg_28_1.time_ >= var_31_1 + var_31_2 and arg_28_1.time_ < var_31_1 + var_31_2 + arg_31_0 and not isNil(var_31_0) and arg_28_1.var_.characterEffect6148ui_story then
				arg_28_1.var_.characterEffect6148ui_story.fillFlat = false
			end

			local var_31_4 = arg_28_1.actors_["1054ui_story"]
			local var_31_5 = 0

			if var_31_5 < arg_28_1.time_ and arg_28_1.time_ <= var_31_5 + arg_31_0 and not isNil(var_31_4) and arg_28_1.var_.characterEffect1054ui_story == nil then
				arg_28_1.var_.characterEffect1054ui_story = var_31_4:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_31_6 = 0.200000002980232

			if var_31_5 <= arg_28_1.time_ and arg_28_1.time_ < var_31_5 + var_31_6 and not isNil(var_31_4) then
				local var_31_7 = (arg_28_1.time_ - var_31_5) / var_31_6

				if arg_28_1.var_.characterEffect1054ui_story and not isNil(var_31_4) then
					local var_31_8 = Mathf.Lerp(0, 0.5, var_31_7)

					arg_28_1.var_.characterEffect1054ui_story.fillFlat = true
					arg_28_1.var_.characterEffect1054ui_story.fillRatio = var_31_8
				end
			end

			if arg_28_1.time_ >= var_31_5 + var_31_6 and arg_28_1.time_ < var_31_5 + var_31_6 + arg_31_0 and not isNil(var_31_4) and arg_28_1.var_.characterEffect1054ui_story then
				local var_31_9 = 0.5

				arg_28_1.var_.characterEffect1054ui_story.fillFlat = true
				arg_28_1.var_.characterEffect1054ui_story.fillRatio = var_31_9
			end

			local var_31_10 = 0

			if var_31_10 < arg_28_1.time_ and arg_28_1.time_ <= var_31_10 + arg_31_0 then
				arg_28_1:PlayTimeline("6148ui_story", "StoryTimeline/CharAction/story6148/story6148action/6148action2_1")
			end

			local var_31_11 = 0
			local var_31_12 = 0.4

			if var_31_11 < arg_28_1.time_ and arg_28_1.time_ <= var_31_11 + arg_31_0 then
				arg_28_1.talkMaxDuration = 0
				arg_28_1.dialogCg_.alpha = 1

				arg_28_1.dialog_:SetActive(true)
				SetActive(arg_28_1.leftNameGo_, true)

				local var_31_13 = arg_28_1:FormatText(StoryNameCfg[1488].name)

				arg_28_1.leftNameTxt_.text = var_31_13

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_28_1.leftNameTxt_.transform)

				arg_28_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_28_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_28_1:RecordName(arg_28_1.leftNameTxt_.text)
				SetActive(arg_28_1.iconTrs_.gameObject, false)
				arg_28_1.callingController_:SetSelectedState("normal")

				local var_31_14 = arg_28_1:GetWordFromCfg(325591007)
				local var_31_15 = arg_28_1:FormatText(var_31_14.content)

				arg_28_1.text_.text = var_31_15

				LuaForUtil.ClearLinePrefixSymbol(arg_28_1.text_)

				local var_31_16 = 16
				local var_31_17 = utf8.len(var_31_15)
				local var_31_18 = var_31_16 <= 0 and var_31_12 or var_31_12 * (var_31_17 / var_31_16)

				if var_31_18 > 0 and var_31_12 < var_31_18 then
					arg_28_1.talkMaxDuration = var_31_18

					if var_31_18 + var_31_11 > arg_28_1.duration_ then
						arg_28_1.duration_ = var_31_18 + var_31_11
					end
				end

				arg_28_1.text_.text = var_31_15
				arg_28_1.typewritter.percent = 0

				arg_28_1.typewritter:SetDirty()
				arg_28_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_325591", "325591007", "story_v_out_325591.awb") ~= 0 then
					local var_31_19 = manager.audio:GetVoiceLength("story_v_out_325591", "325591007", "story_v_out_325591.awb") / 1000

					if var_31_19 + var_31_11 > arg_28_1.duration_ then
						arg_28_1.duration_ = var_31_19 + var_31_11
					end

					if var_31_14.prefab_name ~= "" and arg_28_1.actors_[var_31_14.prefab_name] ~= nil then
						local var_31_20 = LuaForUtil.PlayVoiceWithCriLipsync(arg_28_1.actors_[var_31_14.prefab_name].transform, "story_v_out_325591", "325591007", "story_v_out_325591.awb")

						arg_28_1:RecordAudio("325591007", var_31_20)
						arg_28_1:RecordAudio("325591007", var_31_20)
					else
						arg_28_1:AudioAction("play", "voice", "story_v_out_325591", "325591007", "story_v_out_325591.awb")
					end

					arg_28_1:RecordHistoryTalkVoice("story_v_out_325591", "325591007", "story_v_out_325591.awb")
				end

				arg_28_1:RecordContent(arg_28_1.text_.text)
			end

			local var_31_21 = math.max(var_31_12, arg_28_1.talkMaxDuration)

			if var_31_11 <= arg_28_1.time_ and arg_28_1.time_ < var_31_11 + var_31_21 then
				arg_28_1.typewritter.percent = (arg_28_1.time_ - var_31_11) / var_31_21

				arg_28_1.typewritter:SetDirty()
			end

			if arg_28_1.time_ >= var_31_11 + var_31_21 and arg_28_1.time_ < var_31_11 + var_31_21 + arg_31_0 then
				arg_28_1.typewritter.percent = 1

				arg_28_1.typewritter:SetDirty()
				arg_28_1:ShowNextGo(true)
			end
		end

		arg_28_1.nodeConfigList_ = {}

		arg_28_1:InitPlayNodeList()
	end,
	Play325591008 = function(arg_32_0, arg_32_1)
		arg_32_1.time_ = 0
		arg_32_1.frameCnt_ = 0
		arg_32_1.state_ = "playing"
		arg_32_1.curTalkId_ = 325591008
		arg_32_1.duration_ = 5

		SetActive(arg_32_1.tipsGo_, false)

		function arg_32_1.onSingleLineFinish_()
			arg_32_1.onSingleLineUpdate_ = nil
			arg_32_1.onSingleLineFinish_ = nil
			arg_32_1.state_ = "waiting"
		end

		function arg_32_1.playNext_(arg_34_0)
			if arg_34_0 == 1 then
				arg_32_0:Play325591009(arg_32_1)
			end
		end

		function arg_32_1.onSingleLineUpdate_(arg_35_0)
			local var_35_0 = arg_32_1.actors_["6148ui_story"].transform
			local var_35_1 = 0

			if var_35_1 < arg_32_1.time_ and arg_32_1.time_ <= var_35_1 + arg_35_0 then
				arg_32_1.var_.moveOldPos6148ui_story = var_35_0.localPosition

				local var_35_2 = GameObjectTools.GetOrAddComponent(var_35_0.gameObject, typeof(DynamicBoneHelper))

				if var_35_2 then
					var_35_2:EnableDynamicBone(false)
				end
			end

			local var_35_3 = 0.001

			if var_35_1 <= arg_32_1.time_ and arg_32_1.time_ < var_35_1 + var_35_3 then
				local var_35_4 = (arg_32_1.time_ - var_35_1) / var_35_3
				local var_35_5 = Vector3.New(0, 100, 0)

				var_35_0.localPosition = Vector3.Lerp(arg_32_1.var_.moveOldPos6148ui_story, var_35_5, var_35_4)

				local var_35_6 = manager.ui.mainCamera.transform.position - var_35_0.position

				var_35_0.forward = Vector3.New(var_35_6.x, var_35_6.y, var_35_6.z)

				local var_35_7 = var_35_0.localEulerAngles

				var_35_7.z = 0
				var_35_7.x = 0
				var_35_0.localEulerAngles = var_35_7
			end

			if arg_32_1.time_ >= var_35_1 + var_35_3 and arg_32_1.time_ < var_35_1 + var_35_3 + arg_35_0 then
				var_35_0.localPosition = Vector3.New(0, 100, 0)

				local var_35_8 = manager.ui.mainCamera.transform.position - var_35_0.position

				var_35_0.forward = Vector3.New(var_35_8.x, var_35_8.y, var_35_8.z)

				local var_35_9 = var_35_0.localEulerAngles

				var_35_9.z = 0
				var_35_9.x = 0
				var_35_0.localEulerAngles = var_35_9

				local var_35_10 = GameObjectTools.GetOrAddComponent(var_35_0.gameObject, typeof(DynamicBoneHelper))

				if var_35_10 then
					var_35_10:EnableDynamicBone(true)
				end
			end

			local var_35_11 = arg_32_1.actors_["1054ui_story"].transform
			local var_35_12 = 0

			if var_35_12 < arg_32_1.time_ and arg_32_1.time_ <= var_35_12 + arg_35_0 then
				arg_32_1.var_.moveOldPos1054ui_story = var_35_11.localPosition

				local var_35_13 = GameObjectTools.GetOrAddComponent(var_35_11.gameObject, typeof(DynamicBoneHelper))

				if var_35_13 then
					var_35_13:EnableDynamicBone(false)
				end
			end

			local var_35_14 = 0.001

			if var_35_12 <= arg_32_1.time_ and arg_32_1.time_ < var_35_12 + var_35_14 then
				local var_35_15 = (arg_32_1.time_ - var_35_12) / var_35_14
				local var_35_16 = Vector3.New(0, 100, 0)

				var_35_11.localPosition = Vector3.Lerp(arg_32_1.var_.moveOldPos1054ui_story, var_35_16, var_35_15)

				local var_35_17 = manager.ui.mainCamera.transform.position - var_35_11.position

				var_35_11.forward = Vector3.New(var_35_17.x, var_35_17.y, var_35_17.z)

				local var_35_18 = var_35_11.localEulerAngles

				var_35_18.z = 0
				var_35_18.x = 0
				var_35_11.localEulerAngles = var_35_18
			end

			if arg_32_1.time_ >= var_35_12 + var_35_14 and arg_32_1.time_ < var_35_12 + var_35_14 + arg_35_0 then
				var_35_11.localPosition = Vector3.New(0, 100, 0)

				local var_35_19 = manager.ui.mainCamera.transform.position - var_35_11.position

				var_35_11.forward = Vector3.New(var_35_19.x, var_35_19.y, var_35_19.z)

				local var_35_20 = var_35_11.localEulerAngles

				var_35_20.z = 0
				var_35_20.x = 0
				var_35_11.localEulerAngles = var_35_20

				local var_35_21 = GameObjectTools.GetOrAddComponent(var_35_11.gameObject, typeof(DynamicBoneHelper))

				if var_35_21 then
					var_35_21:EnableDynamicBone(true)
				end
			end

			local var_35_22 = arg_32_1.actors_["6148ui_story"]
			local var_35_23 = 0

			if var_35_23 < arg_32_1.time_ and arg_32_1.time_ <= var_35_23 + arg_35_0 and not isNil(var_35_22) and arg_32_1.var_.characterEffect6148ui_story == nil then
				arg_32_1.var_.characterEffect6148ui_story = var_35_22:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_35_24 = 0.200000002980232

			if var_35_23 <= arg_32_1.time_ and arg_32_1.time_ < var_35_23 + var_35_24 and not isNil(var_35_22) then
				local var_35_25 = (arg_32_1.time_ - var_35_23) / var_35_24

				if arg_32_1.var_.characterEffect6148ui_story and not isNil(var_35_22) then
					local var_35_26 = Mathf.Lerp(0, 0.5, var_35_25)

					arg_32_1.var_.characterEffect6148ui_story.fillFlat = true
					arg_32_1.var_.characterEffect6148ui_story.fillRatio = var_35_26
				end
			end

			if arg_32_1.time_ >= var_35_23 + var_35_24 and arg_32_1.time_ < var_35_23 + var_35_24 + arg_35_0 and not isNil(var_35_22) and arg_32_1.var_.characterEffect6148ui_story then
				local var_35_27 = 0.5

				arg_32_1.var_.characterEffect6148ui_story.fillFlat = true
				arg_32_1.var_.characterEffect6148ui_story.fillRatio = var_35_27
			end

			local var_35_28 = 0

			if var_35_28 < arg_32_1.time_ and arg_32_1.time_ <= var_35_28 + arg_35_0 then
				arg_32_1:PlayTimeline("1054ui_story", "StoryTimeline/CharAction/story1054/story1054action/1054action4_2")
			end

			local var_35_29 = 0
			local var_35_30 = 1.375

			if var_35_29 < arg_32_1.time_ and arg_32_1.time_ <= var_35_29 + arg_35_0 then
				arg_32_1.talkMaxDuration = 0
				arg_32_1.dialogCg_.alpha = 1

				arg_32_1.dialog_:SetActive(true)
				SetActive(arg_32_1.leftNameGo_, false)

				arg_32_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_32_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_32_1:RecordName(arg_32_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_32_1.iconTrs_.gameObject, false)
				arg_32_1.callingController_:SetSelectedState("normal")

				local var_35_31 = arg_32_1:GetWordFromCfg(325591008)
				local var_35_32 = arg_32_1:FormatText(var_35_31.content)

				arg_32_1.text_.text = var_35_32

				LuaForUtil.ClearLinePrefixSymbol(arg_32_1.text_)

				local var_35_33 = 55
				local var_35_34 = utf8.len(var_35_32)
				local var_35_35 = var_35_33 <= 0 and var_35_30 or var_35_30 * (var_35_34 / var_35_33)

				if var_35_35 > 0 and var_35_30 < var_35_35 then
					arg_32_1.talkMaxDuration = var_35_35

					if var_35_35 + var_35_29 > arg_32_1.duration_ then
						arg_32_1.duration_ = var_35_35 + var_35_29
					end
				end

				arg_32_1.text_.text = var_35_32
				arg_32_1.typewritter.percent = 0

				arg_32_1.typewritter:SetDirty()
				arg_32_1:ShowNextGo(false)
				arg_32_1:RecordContent(arg_32_1.text_.text)
			end

			local var_35_36 = math.max(var_35_30, arg_32_1.talkMaxDuration)

			if var_35_29 <= arg_32_1.time_ and arg_32_1.time_ < var_35_29 + var_35_36 then
				arg_32_1.typewritter.percent = (arg_32_1.time_ - var_35_29) / var_35_36

				arg_32_1.typewritter:SetDirty()
			end

			if arg_32_1.time_ >= var_35_29 + var_35_36 and arg_32_1.time_ < var_35_29 + var_35_36 + arg_35_0 then
				arg_32_1.typewritter.percent = 1

				arg_32_1.typewritter:SetDirty()
				arg_32_1:ShowNextGo(true)
			end
		end

		arg_32_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "6148ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1054ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_32_1:InitPlayNodeList()
	end,
	Play325591009 = function(arg_36_0, arg_36_1)
		arg_36_1.time_ = 0
		arg_36_1.frameCnt_ = 0
		arg_36_1.state_ = "playing"
		arg_36_1.curTalkId_ = 325591009
		arg_36_1.duration_ = 5.97

		local var_36_0 = {
			zh = 3.966,
			ja = 5.966
		}
		local var_36_1 = manager.audio:GetLocalizationFlag()

		if var_36_0[var_36_1] ~= nil then
			arg_36_1.duration_ = var_36_0[var_36_1]
		end

		SetActive(arg_36_1.tipsGo_, false)

		function arg_36_1.onSingleLineFinish_()
			arg_36_1.onSingleLineUpdate_ = nil
			arg_36_1.onSingleLineFinish_ = nil
			arg_36_1.state_ = "waiting"
		end

		function arg_36_1.playNext_(arg_38_0)
			if arg_38_0 == 1 then
				arg_36_0:Play325591010(arg_36_1)
			end
		end

		function arg_36_1.onSingleLineUpdate_(arg_39_0)
			local var_39_0 = arg_36_1.actors_["1054ui_story"].transform
			local var_39_1 = 0

			if var_39_1 < arg_36_1.time_ and arg_36_1.time_ <= var_39_1 + arg_39_0 then
				arg_36_1.var_.moveOldPos1054ui_story = var_39_0.localPosition

				local var_39_2 = GameObjectTools.GetOrAddComponent(var_39_0.gameObject, typeof(DynamicBoneHelper))

				if var_39_2 then
					var_39_2:EnableDynamicBone(false)
				end
			end

			local var_39_3 = 0.001

			if var_39_1 <= arg_36_1.time_ and arg_36_1.time_ < var_39_1 + var_39_3 then
				local var_39_4 = (arg_36_1.time_ - var_39_1) / var_39_3
				local var_39_5 = Vector3.New(0, -0.985, -6)

				var_39_0.localPosition = Vector3.Lerp(arg_36_1.var_.moveOldPos1054ui_story, var_39_5, var_39_4)

				local var_39_6 = manager.ui.mainCamera.transform.position - var_39_0.position

				var_39_0.forward = Vector3.New(var_39_6.x, var_39_6.y, var_39_6.z)

				local var_39_7 = var_39_0.localEulerAngles

				var_39_7.z = 0
				var_39_7.x = 0
				var_39_0.localEulerAngles = var_39_7
			end

			if arg_36_1.time_ >= var_39_1 + var_39_3 and arg_36_1.time_ < var_39_1 + var_39_3 + arg_39_0 then
				var_39_0.localPosition = Vector3.New(0, -0.985, -6)

				local var_39_8 = manager.ui.mainCamera.transform.position - var_39_0.position

				var_39_0.forward = Vector3.New(var_39_8.x, var_39_8.y, var_39_8.z)

				local var_39_9 = var_39_0.localEulerAngles

				var_39_9.z = 0
				var_39_9.x = 0
				var_39_0.localEulerAngles = var_39_9

				local var_39_10 = GameObjectTools.GetOrAddComponent(var_39_0.gameObject, typeof(DynamicBoneHelper))

				if var_39_10 then
					var_39_10:EnableDynamicBone(true)
				end
			end

			local var_39_11 = arg_36_1.actors_["1054ui_story"]
			local var_39_12 = 0

			if var_39_12 < arg_36_1.time_ and arg_36_1.time_ <= var_39_12 + arg_39_0 and not isNil(var_39_11) and arg_36_1.var_.characterEffect1054ui_story == nil then
				arg_36_1.var_.characterEffect1054ui_story = var_39_11:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_39_13 = 0.200000002980232

			if var_39_12 <= arg_36_1.time_ and arg_36_1.time_ < var_39_12 + var_39_13 and not isNil(var_39_11) then
				local var_39_14 = (arg_36_1.time_ - var_39_12) / var_39_13

				if arg_36_1.var_.characterEffect1054ui_story and not isNil(var_39_11) then
					arg_36_1.var_.characterEffect1054ui_story.fillFlat = false
				end
			end

			if arg_36_1.time_ >= var_39_12 + var_39_13 and arg_36_1.time_ < var_39_12 + var_39_13 + arg_39_0 and not isNil(var_39_11) and arg_36_1.var_.characterEffect1054ui_story then
				arg_36_1.var_.characterEffect1054ui_story.fillFlat = false
			end

			local var_39_15 = 0

			if var_39_15 < arg_36_1.time_ and arg_36_1.time_ <= var_39_15 + arg_39_0 then
				arg_36_1:PlayTimeline("6148ui_story", "StoryTimeline/CharAction/story1054/story1054action/1054action1_1")
			end

			local var_39_16 = 0
			local var_39_17 = 0.3

			if var_39_16 < arg_36_1.time_ and arg_36_1.time_ <= var_39_16 + arg_39_0 then
				arg_36_1.talkMaxDuration = 0
				arg_36_1.dialogCg_.alpha = 1

				arg_36_1.dialog_:SetActive(true)
				SetActive(arg_36_1.leftNameGo_, true)

				local var_39_18 = arg_36_1:FormatText(StoryNameCfg[1487].name)

				arg_36_1.leftNameTxt_.text = var_39_18

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_36_1.leftNameTxt_.transform)

				arg_36_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_36_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_36_1:RecordName(arg_36_1.leftNameTxt_.text)
				SetActive(arg_36_1.iconTrs_.gameObject, false)
				arg_36_1.callingController_:SetSelectedState("normal")

				local var_39_19 = arg_36_1:GetWordFromCfg(325591009)
				local var_39_20 = arg_36_1:FormatText(var_39_19.content)

				arg_36_1.text_.text = var_39_20

				LuaForUtil.ClearLinePrefixSymbol(arg_36_1.text_)

				local var_39_21 = 12
				local var_39_22 = utf8.len(var_39_20)
				local var_39_23 = var_39_21 <= 0 and var_39_17 or var_39_17 * (var_39_22 / var_39_21)

				if var_39_23 > 0 and var_39_17 < var_39_23 then
					arg_36_1.talkMaxDuration = var_39_23

					if var_39_23 + var_39_16 > arg_36_1.duration_ then
						arg_36_1.duration_ = var_39_23 + var_39_16
					end
				end

				arg_36_1.text_.text = var_39_20
				arg_36_1.typewritter.percent = 0

				arg_36_1.typewritter:SetDirty()
				arg_36_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_325591", "325591009", "story_v_out_325591.awb") ~= 0 then
					local var_39_24 = manager.audio:GetVoiceLength("story_v_out_325591", "325591009", "story_v_out_325591.awb") / 1000

					if var_39_24 + var_39_16 > arg_36_1.duration_ then
						arg_36_1.duration_ = var_39_24 + var_39_16
					end

					if var_39_19.prefab_name ~= "" and arg_36_1.actors_[var_39_19.prefab_name] ~= nil then
						local var_39_25 = LuaForUtil.PlayVoiceWithCriLipsync(arg_36_1.actors_[var_39_19.prefab_name].transform, "story_v_out_325591", "325591009", "story_v_out_325591.awb")

						arg_36_1:RecordAudio("325591009", var_39_25)
						arg_36_1:RecordAudio("325591009", var_39_25)
					else
						arg_36_1:AudioAction("play", "voice", "story_v_out_325591", "325591009", "story_v_out_325591.awb")
					end

					arg_36_1:RecordHistoryTalkVoice("story_v_out_325591", "325591009", "story_v_out_325591.awb")
				end

				arg_36_1:RecordContent(arg_36_1.text_.text)
			end

			local var_39_26 = math.max(var_39_17, arg_36_1.talkMaxDuration)

			if var_39_16 <= arg_36_1.time_ and arg_36_1.time_ < var_39_16 + var_39_26 then
				arg_36_1.typewritter.percent = (arg_36_1.time_ - var_39_16) / var_39_26

				arg_36_1.typewritter:SetDirty()
			end

			if arg_36_1.time_ >= var_39_16 + var_39_26 and arg_36_1.time_ < var_39_16 + var_39_26 + arg_39_0 then
				arg_36_1.typewritter.percent = 1

				arg_36_1.typewritter:SetDirty()
				arg_36_1:ShowNextGo(true)
			end
		end

		arg_36_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1054ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_36_1:InitPlayNodeList()
	end,
	Play325591010 = function(arg_40_0, arg_40_1)
		arg_40_1.time_ = 0
		arg_40_1.frameCnt_ = 0
		arg_40_1.state_ = "playing"
		arg_40_1.curTalkId_ = 325591010
		arg_40_1.duration_ = 5.77

		local var_40_0 = {
			zh = 4.733,
			ja = 5.766
		}
		local var_40_1 = manager.audio:GetLocalizationFlag()

		if var_40_0[var_40_1] ~= nil then
			arg_40_1.duration_ = var_40_0[var_40_1]
		end

		SetActive(arg_40_1.tipsGo_, false)

		function arg_40_1.onSingleLineFinish_()
			arg_40_1.onSingleLineUpdate_ = nil
			arg_40_1.onSingleLineFinish_ = nil
			arg_40_1.state_ = "waiting"
		end

		function arg_40_1.playNext_(arg_42_0)
			if arg_42_0 == 1 then
				arg_40_0:Play325591011(arg_40_1)
			end
		end

		function arg_40_1.onSingleLineUpdate_(arg_43_0)
			local var_43_0 = 0

			if var_43_0 < arg_40_1.time_ and arg_40_1.time_ <= var_43_0 + arg_43_0 then
				arg_40_1:PlayTimeline("1054ui_story", "StoryTimeline/CharAction/story1054/story1054action/1054action3_1")
			end

			local var_43_1 = 0

			if var_43_1 < arg_40_1.time_ and arg_40_1.time_ <= var_43_1 + arg_43_0 then
				arg_40_1:PlayTimeline("1054ui_story", "StoryTimeline/CharAction/public_expression/expr_nanguoC", "EmotionTimelineAnimator")
			end

			local var_43_2 = 0
			local var_43_3 = 0.4

			if var_43_2 < arg_40_1.time_ and arg_40_1.time_ <= var_43_2 + arg_43_0 then
				arg_40_1.talkMaxDuration = 0
				arg_40_1.dialogCg_.alpha = 1

				arg_40_1.dialog_:SetActive(true)
				SetActive(arg_40_1.leftNameGo_, true)

				local var_43_4 = arg_40_1:FormatText(StoryNameCfg[1487].name)

				arg_40_1.leftNameTxt_.text = var_43_4

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_40_1.leftNameTxt_.transform)

				arg_40_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_40_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_40_1:RecordName(arg_40_1.leftNameTxt_.text)
				SetActive(arg_40_1.iconTrs_.gameObject, false)
				arg_40_1.callingController_:SetSelectedState("normal")

				local var_43_5 = arg_40_1:GetWordFromCfg(325591010)
				local var_43_6 = arg_40_1:FormatText(var_43_5.content)

				arg_40_1.text_.text = var_43_6

				LuaForUtil.ClearLinePrefixSymbol(arg_40_1.text_)

				local var_43_7 = 16
				local var_43_8 = utf8.len(var_43_6)
				local var_43_9 = var_43_7 <= 0 and var_43_3 or var_43_3 * (var_43_8 / var_43_7)

				if var_43_9 > 0 and var_43_3 < var_43_9 then
					arg_40_1.talkMaxDuration = var_43_9

					if var_43_9 + var_43_2 > arg_40_1.duration_ then
						arg_40_1.duration_ = var_43_9 + var_43_2
					end
				end

				arg_40_1.text_.text = var_43_6
				arg_40_1.typewritter.percent = 0

				arg_40_1.typewritter:SetDirty()
				arg_40_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_325591", "325591010", "story_v_out_325591.awb") ~= 0 then
					local var_43_10 = manager.audio:GetVoiceLength("story_v_out_325591", "325591010", "story_v_out_325591.awb") / 1000

					if var_43_10 + var_43_2 > arg_40_1.duration_ then
						arg_40_1.duration_ = var_43_10 + var_43_2
					end

					if var_43_5.prefab_name ~= "" and arg_40_1.actors_[var_43_5.prefab_name] ~= nil then
						local var_43_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_40_1.actors_[var_43_5.prefab_name].transform, "story_v_out_325591", "325591010", "story_v_out_325591.awb")

						arg_40_1:RecordAudio("325591010", var_43_11)
						arg_40_1:RecordAudio("325591010", var_43_11)
					else
						arg_40_1:AudioAction("play", "voice", "story_v_out_325591", "325591010", "story_v_out_325591.awb")
					end

					arg_40_1:RecordHistoryTalkVoice("story_v_out_325591", "325591010", "story_v_out_325591.awb")
				end

				arg_40_1:RecordContent(arg_40_1.text_.text)
			end

			local var_43_12 = math.max(var_43_3, arg_40_1.talkMaxDuration)

			if var_43_2 <= arg_40_1.time_ and arg_40_1.time_ < var_43_2 + var_43_12 then
				arg_40_1.typewritter.percent = (arg_40_1.time_ - var_43_2) / var_43_12

				arg_40_1.typewritter:SetDirty()
			end

			if arg_40_1.time_ >= var_43_2 + var_43_12 and arg_40_1.time_ < var_43_2 + var_43_12 + arg_43_0 then
				arg_40_1.typewritter.percent = 1

				arg_40_1.typewritter:SetDirty()
				arg_40_1:ShowNextGo(true)
			end
		end

		arg_40_1.nodeConfigList_ = {}

		arg_40_1:InitPlayNodeList()
	end,
	Play325591011 = function(arg_44_0, arg_44_1)
		arg_44_1.time_ = 0
		arg_44_1.frameCnt_ = 0
		arg_44_1.state_ = "playing"
		arg_44_1.curTalkId_ = 325591011
		arg_44_1.duration_ = 7.77

		local var_44_0 = {
			zh = 6.733,
			ja = 7.766
		}
		local var_44_1 = manager.audio:GetLocalizationFlag()

		if var_44_0[var_44_1] ~= nil then
			arg_44_1.duration_ = var_44_0[var_44_1]
		end

		SetActive(arg_44_1.tipsGo_, false)

		function arg_44_1.onSingleLineFinish_()
			arg_44_1.onSingleLineUpdate_ = nil
			arg_44_1.onSingleLineFinish_ = nil
			arg_44_1.state_ = "waiting"
		end

		function arg_44_1.playNext_(arg_46_0)
			if arg_46_0 == 1 then
				arg_44_0:Play325591012(arg_44_1)
			end
		end

		function arg_44_1.onSingleLineUpdate_(arg_47_0)
			local var_47_0 = arg_44_1.actors_["1054ui_story"].transform
			local var_47_1 = 0

			if var_47_1 < arg_44_1.time_ and arg_44_1.time_ <= var_47_1 + arg_47_0 then
				arg_44_1.var_.moveOldPos1054ui_story = var_47_0.localPosition

				local var_47_2 = GameObjectTools.GetOrAddComponent(var_47_0.gameObject, typeof(DynamicBoneHelper))

				if var_47_2 then
					var_47_2:EnableDynamicBone(false)
				end
			end

			local var_47_3 = 0.001

			if var_47_1 <= arg_44_1.time_ and arg_44_1.time_ < var_47_1 + var_47_3 then
				local var_47_4 = (arg_44_1.time_ - var_47_1) / var_47_3
				local var_47_5 = Vector3.New(-0.7, -0.985, -6)

				var_47_0.localPosition = Vector3.Lerp(arg_44_1.var_.moveOldPos1054ui_story, var_47_5, var_47_4)

				local var_47_6 = manager.ui.mainCamera.transform.position - var_47_0.position

				var_47_0.forward = Vector3.New(var_47_6.x, var_47_6.y, var_47_6.z)

				local var_47_7 = var_47_0.localEulerAngles

				var_47_7.z = 0
				var_47_7.x = 0
				var_47_0.localEulerAngles = var_47_7
			end

			if arg_44_1.time_ >= var_47_1 + var_47_3 and arg_44_1.time_ < var_47_1 + var_47_3 + arg_47_0 then
				var_47_0.localPosition = Vector3.New(-0.7, -0.985, -6)

				local var_47_8 = manager.ui.mainCamera.transform.position - var_47_0.position

				var_47_0.forward = Vector3.New(var_47_8.x, var_47_8.y, var_47_8.z)

				local var_47_9 = var_47_0.localEulerAngles

				var_47_9.z = 0
				var_47_9.x = 0
				var_47_0.localEulerAngles = var_47_9

				local var_47_10 = GameObjectTools.GetOrAddComponent(var_47_0.gameObject, typeof(DynamicBoneHelper))

				if var_47_10 then
					var_47_10:EnableDynamicBone(true)
				end
			end

			local var_47_11 = arg_44_1.actors_["6148ui_story"].transform
			local var_47_12 = 0

			if var_47_12 < arg_44_1.time_ and arg_44_1.time_ <= var_47_12 + arg_47_0 then
				arg_44_1.var_.moveOldPos6148ui_story = var_47_11.localPosition

				local var_47_13 = GameObjectTools.GetOrAddComponent(var_47_11.gameObject, typeof(DynamicBoneHelper))

				if var_47_13 then
					var_47_13:EnableDynamicBone(false)
				end
			end

			local var_47_14 = 0.001

			if var_47_12 <= arg_44_1.time_ and arg_44_1.time_ < var_47_12 + var_47_14 then
				local var_47_15 = (arg_44_1.time_ - var_47_12) / var_47_14
				local var_47_16 = Vector3.New(0.7, -0.985, -6)

				var_47_11.localPosition = Vector3.Lerp(arg_44_1.var_.moveOldPos6148ui_story, var_47_16, var_47_15)

				local var_47_17 = manager.ui.mainCamera.transform.position - var_47_11.position

				var_47_11.forward = Vector3.New(var_47_17.x, var_47_17.y, var_47_17.z)

				local var_47_18 = var_47_11.localEulerAngles

				var_47_18.z = 0
				var_47_18.x = 0
				var_47_11.localEulerAngles = var_47_18
			end

			if arg_44_1.time_ >= var_47_12 + var_47_14 and arg_44_1.time_ < var_47_12 + var_47_14 + arg_47_0 then
				var_47_11.localPosition = Vector3.New(0.7, -0.985, -6)

				local var_47_19 = manager.ui.mainCamera.transform.position - var_47_11.position

				var_47_11.forward = Vector3.New(var_47_19.x, var_47_19.y, var_47_19.z)

				local var_47_20 = var_47_11.localEulerAngles

				var_47_20.z = 0
				var_47_20.x = 0
				var_47_11.localEulerAngles = var_47_20

				local var_47_21 = GameObjectTools.GetOrAddComponent(var_47_11.gameObject, typeof(DynamicBoneHelper))

				if var_47_21 then
					var_47_21:EnableDynamicBone(true)
				end
			end

			local var_47_22 = arg_44_1.actors_["6148ui_story"]
			local var_47_23 = 0

			if var_47_23 < arg_44_1.time_ and arg_44_1.time_ <= var_47_23 + arg_47_0 and not isNil(var_47_22) and arg_44_1.var_.characterEffect6148ui_story == nil then
				arg_44_1.var_.characterEffect6148ui_story = var_47_22:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_47_24 = 0.200000002980232

			if var_47_23 <= arg_44_1.time_ and arg_44_1.time_ < var_47_23 + var_47_24 and not isNil(var_47_22) then
				local var_47_25 = (arg_44_1.time_ - var_47_23) / var_47_24

				if arg_44_1.var_.characterEffect6148ui_story and not isNil(var_47_22) then
					arg_44_1.var_.characterEffect6148ui_story.fillFlat = false
				end
			end

			if arg_44_1.time_ >= var_47_23 + var_47_24 and arg_44_1.time_ < var_47_23 + var_47_24 + arg_47_0 and not isNil(var_47_22) and arg_44_1.var_.characterEffect6148ui_story then
				arg_44_1.var_.characterEffect6148ui_story.fillFlat = false
			end

			local var_47_26 = arg_44_1.actors_["1054ui_story"]
			local var_47_27 = 0

			if var_47_27 < arg_44_1.time_ and arg_44_1.time_ <= var_47_27 + arg_47_0 and not isNil(var_47_26) and arg_44_1.var_.characterEffect1054ui_story == nil then
				arg_44_1.var_.characterEffect1054ui_story = var_47_26:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_47_28 = 0.200000002980232

			if var_47_27 <= arg_44_1.time_ and arg_44_1.time_ < var_47_27 + var_47_28 and not isNil(var_47_26) then
				local var_47_29 = (arg_44_1.time_ - var_47_27) / var_47_28

				if arg_44_1.var_.characterEffect1054ui_story and not isNil(var_47_26) then
					local var_47_30 = Mathf.Lerp(0, 0.5, var_47_29)

					arg_44_1.var_.characterEffect1054ui_story.fillFlat = true
					arg_44_1.var_.characterEffect1054ui_story.fillRatio = var_47_30
				end
			end

			if arg_44_1.time_ >= var_47_27 + var_47_28 and arg_44_1.time_ < var_47_27 + var_47_28 + arg_47_0 and not isNil(var_47_26) and arg_44_1.var_.characterEffect1054ui_story then
				local var_47_31 = 0.5

				arg_44_1.var_.characterEffect1054ui_story.fillFlat = true
				arg_44_1.var_.characterEffect1054ui_story.fillRatio = var_47_31
			end

			local var_47_32 = 0
			local var_47_33 = 0.8

			if var_47_32 < arg_44_1.time_ and arg_44_1.time_ <= var_47_32 + arg_47_0 then
				arg_44_1.talkMaxDuration = 0
				arg_44_1.dialogCg_.alpha = 1

				arg_44_1.dialog_:SetActive(true)
				SetActive(arg_44_1.leftNameGo_, true)

				local var_47_34 = arg_44_1:FormatText(StoryNameCfg[1488].name)

				arg_44_1.leftNameTxt_.text = var_47_34

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_44_1.leftNameTxt_.transform)

				arg_44_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_44_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_44_1:RecordName(arg_44_1.leftNameTxt_.text)
				SetActive(arg_44_1.iconTrs_.gameObject, false)
				arg_44_1.callingController_:SetSelectedState("normal")

				local var_47_35 = arg_44_1:GetWordFromCfg(325591011)
				local var_47_36 = arg_44_1:FormatText(var_47_35.content)

				arg_44_1.text_.text = var_47_36

				LuaForUtil.ClearLinePrefixSymbol(arg_44_1.text_)

				local var_47_37 = 32
				local var_47_38 = utf8.len(var_47_36)
				local var_47_39 = var_47_37 <= 0 and var_47_33 or var_47_33 * (var_47_38 / var_47_37)

				if var_47_39 > 0 and var_47_33 < var_47_39 then
					arg_44_1.talkMaxDuration = var_47_39

					if var_47_39 + var_47_32 > arg_44_1.duration_ then
						arg_44_1.duration_ = var_47_39 + var_47_32
					end
				end

				arg_44_1.text_.text = var_47_36
				arg_44_1.typewritter.percent = 0

				arg_44_1.typewritter:SetDirty()
				arg_44_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_325591", "325591011", "story_v_out_325591.awb") ~= 0 then
					local var_47_40 = manager.audio:GetVoiceLength("story_v_out_325591", "325591011", "story_v_out_325591.awb") / 1000

					if var_47_40 + var_47_32 > arg_44_1.duration_ then
						arg_44_1.duration_ = var_47_40 + var_47_32
					end

					if var_47_35.prefab_name ~= "" and arg_44_1.actors_[var_47_35.prefab_name] ~= nil then
						local var_47_41 = LuaForUtil.PlayVoiceWithCriLipsync(arg_44_1.actors_[var_47_35.prefab_name].transform, "story_v_out_325591", "325591011", "story_v_out_325591.awb")

						arg_44_1:RecordAudio("325591011", var_47_41)
						arg_44_1:RecordAudio("325591011", var_47_41)
					else
						arg_44_1:AudioAction("play", "voice", "story_v_out_325591", "325591011", "story_v_out_325591.awb")
					end

					arg_44_1:RecordHistoryTalkVoice("story_v_out_325591", "325591011", "story_v_out_325591.awb")
				end

				arg_44_1:RecordContent(arg_44_1.text_.text)
			end

			local var_47_42 = math.max(var_47_33, arg_44_1.talkMaxDuration)

			if var_47_32 <= arg_44_1.time_ and arg_44_1.time_ < var_47_32 + var_47_42 then
				arg_44_1.typewritter.percent = (arg_44_1.time_ - var_47_32) / var_47_42

				arg_44_1.typewritter:SetDirty()
			end

			if arg_44_1.time_ >= var_47_32 + var_47_42 and arg_44_1.time_ < var_47_32 + var_47_42 + arg_47_0 then
				arg_44_1.typewritter.percent = 1

				arg_44_1.typewritter:SetDirty()
				arg_44_1:ShowNextGo(true)
			end
		end

		arg_44_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1054ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "6148ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_44_1:InitPlayNodeList()
	end,
	Play325591012 = function(arg_48_0, arg_48_1)
		arg_48_1.time_ = 0
		arg_48_1.frameCnt_ = 0
		arg_48_1.state_ = "playing"
		arg_48_1.curTalkId_ = 325591012
		arg_48_1.duration_ = 8.57

		local var_48_0 = {
			zh = 8.566,
			ja = 7.833
		}
		local var_48_1 = manager.audio:GetLocalizationFlag()

		if var_48_0[var_48_1] ~= nil then
			arg_48_1.duration_ = var_48_0[var_48_1]
		end

		SetActive(arg_48_1.tipsGo_, false)

		function arg_48_1.onSingleLineFinish_()
			arg_48_1.onSingleLineUpdate_ = nil
			arg_48_1.onSingleLineFinish_ = nil
			arg_48_1.state_ = "waiting"
		end

		function arg_48_1.playNext_(arg_50_0)
			if arg_50_0 == 1 then
				arg_48_0:Play325591013(arg_48_1)
			end
		end

		function arg_48_1.onSingleLineUpdate_(arg_51_0)
			local var_51_0 = 0

			if var_51_0 < arg_48_1.time_ and arg_48_1.time_ <= var_51_0 + arg_51_0 then
				arg_48_1:PlayTimeline("6148ui_story", "StoryTimeline/CharAction/story6148/story6148action/6148action5_1")
			end

			local var_51_1 = 0

			if var_51_1 < arg_48_1.time_ and arg_48_1.time_ <= var_51_1 + arg_51_0 then
				arg_48_1:PlayTimeline("6148ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0101cva", "EmotionTimelineAnimator")
			end

			local var_51_2 = 0
			local var_51_3 = 0.95

			if var_51_2 < arg_48_1.time_ and arg_48_1.time_ <= var_51_2 + arg_51_0 then
				arg_48_1.talkMaxDuration = 0
				arg_48_1.dialogCg_.alpha = 1

				arg_48_1.dialog_:SetActive(true)
				SetActive(arg_48_1.leftNameGo_, true)

				local var_51_4 = arg_48_1:FormatText(StoryNameCfg[1488].name)

				arg_48_1.leftNameTxt_.text = var_51_4

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_48_1.leftNameTxt_.transform)

				arg_48_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_48_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_48_1:RecordName(arg_48_1.leftNameTxt_.text)
				SetActive(arg_48_1.iconTrs_.gameObject, false)
				arg_48_1.callingController_:SetSelectedState("normal")

				local var_51_5 = arg_48_1:GetWordFromCfg(325591012)
				local var_51_6 = arg_48_1:FormatText(var_51_5.content)

				arg_48_1.text_.text = var_51_6

				LuaForUtil.ClearLinePrefixSymbol(arg_48_1.text_)

				local var_51_7 = 38
				local var_51_8 = utf8.len(var_51_6)
				local var_51_9 = var_51_7 <= 0 and var_51_3 or var_51_3 * (var_51_8 / var_51_7)

				if var_51_9 > 0 and var_51_3 < var_51_9 then
					arg_48_1.talkMaxDuration = var_51_9

					if var_51_9 + var_51_2 > arg_48_1.duration_ then
						arg_48_1.duration_ = var_51_9 + var_51_2
					end
				end

				arg_48_1.text_.text = var_51_6
				arg_48_1.typewritter.percent = 0

				arg_48_1.typewritter:SetDirty()
				arg_48_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_325591", "325591012", "story_v_out_325591.awb") ~= 0 then
					local var_51_10 = manager.audio:GetVoiceLength("story_v_out_325591", "325591012", "story_v_out_325591.awb") / 1000

					if var_51_10 + var_51_2 > arg_48_1.duration_ then
						arg_48_1.duration_ = var_51_10 + var_51_2
					end

					if var_51_5.prefab_name ~= "" and arg_48_1.actors_[var_51_5.prefab_name] ~= nil then
						local var_51_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_48_1.actors_[var_51_5.prefab_name].transform, "story_v_out_325591", "325591012", "story_v_out_325591.awb")

						arg_48_1:RecordAudio("325591012", var_51_11)
						arg_48_1:RecordAudio("325591012", var_51_11)
					else
						arg_48_1:AudioAction("play", "voice", "story_v_out_325591", "325591012", "story_v_out_325591.awb")
					end

					arg_48_1:RecordHistoryTalkVoice("story_v_out_325591", "325591012", "story_v_out_325591.awb")
				end

				arg_48_1:RecordContent(arg_48_1.text_.text)
			end

			local var_51_12 = math.max(var_51_3, arg_48_1.talkMaxDuration)

			if var_51_2 <= arg_48_1.time_ and arg_48_1.time_ < var_51_2 + var_51_12 then
				arg_48_1.typewritter.percent = (arg_48_1.time_ - var_51_2) / var_51_12

				arg_48_1.typewritter:SetDirty()
			end

			if arg_48_1.time_ >= var_51_2 + var_51_12 and arg_48_1.time_ < var_51_2 + var_51_12 + arg_51_0 then
				arg_48_1.typewritter.percent = 1

				arg_48_1.typewritter:SetDirty()
				arg_48_1:ShowNextGo(true)
			end
		end

		arg_48_1.nodeConfigList_ = {}

		arg_48_1:InitPlayNodeList()
	end,
	Play325591013 = function(arg_52_0, arg_52_1)
		arg_52_1.time_ = 0
		arg_52_1.frameCnt_ = 0
		arg_52_1.state_ = "playing"
		arg_52_1.curTalkId_ = 325591013
		arg_52_1.duration_ = 5.4

		local var_52_0 = {
			zh = 5.4,
			ja = 4.9
		}
		local var_52_1 = manager.audio:GetLocalizationFlag()

		if var_52_0[var_52_1] ~= nil then
			arg_52_1.duration_ = var_52_0[var_52_1]
		end

		SetActive(arg_52_1.tipsGo_, false)

		function arg_52_1.onSingleLineFinish_()
			arg_52_1.onSingleLineUpdate_ = nil
			arg_52_1.onSingleLineFinish_ = nil
			arg_52_1.state_ = "waiting"
		end

		function arg_52_1.playNext_(arg_54_0)
			if arg_54_0 == 1 then
				arg_52_0:Play325591014(arg_52_1)
			end
		end

		function arg_52_1.onSingleLineUpdate_(arg_55_0)
			local var_55_0 = arg_52_1.actors_["1054ui_story"]
			local var_55_1 = 0

			if var_55_1 < arg_52_1.time_ and arg_52_1.time_ <= var_55_1 + arg_55_0 and not isNil(var_55_0) and arg_52_1.var_.characterEffect1054ui_story == nil then
				arg_52_1.var_.characterEffect1054ui_story = var_55_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_55_2 = 0.200000002980232

			if var_55_1 <= arg_52_1.time_ and arg_52_1.time_ < var_55_1 + var_55_2 and not isNil(var_55_0) then
				local var_55_3 = (arg_52_1.time_ - var_55_1) / var_55_2

				if arg_52_1.var_.characterEffect1054ui_story and not isNil(var_55_0) then
					arg_52_1.var_.characterEffect1054ui_story.fillFlat = false
				end
			end

			if arg_52_1.time_ >= var_55_1 + var_55_2 and arg_52_1.time_ < var_55_1 + var_55_2 + arg_55_0 and not isNil(var_55_0) and arg_52_1.var_.characterEffect1054ui_story then
				arg_52_1.var_.characterEffect1054ui_story.fillFlat = false
			end

			local var_55_4 = arg_52_1.actors_["6148ui_story"]
			local var_55_5 = 0

			if var_55_5 < arg_52_1.time_ and arg_52_1.time_ <= var_55_5 + arg_55_0 and not isNil(var_55_4) and arg_52_1.var_.characterEffect6148ui_story == nil then
				arg_52_1.var_.characterEffect6148ui_story = var_55_4:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_55_6 = 0.200000002980232

			if var_55_5 <= arg_52_1.time_ and arg_52_1.time_ < var_55_5 + var_55_6 and not isNil(var_55_4) then
				local var_55_7 = (arg_52_1.time_ - var_55_5) / var_55_6

				if arg_52_1.var_.characterEffect6148ui_story and not isNil(var_55_4) then
					local var_55_8 = Mathf.Lerp(0, 0.5, var_55_7)

					arg_52_1.var_.characterEffect6148ui_story.fillFlat = true
					arg_52_1.var_.characterEffect6148ui_story.fillRatio = var_55_8
				end
			end

			if arg_52_1.time_ >= var_55_5 + var_55_6 and arg_52_1.time_ < var_55_5 + var_55_6 + arg_55_0 and not isNil(var_55_4) and arg_52_1.var_.characterEffect6148ui_story then
				local var_55_9 = 0.5

				arg_52_1.var_.characterEffect6148ui_story.fillFlat = true
				arg_52_1.var_.characterEffect6148ui_story.fillRatio = var_55_9
			end

			local var_55_10 = 0

			if var_55_10 < arg_52_1.time_ and arg_52_1.time_ <= var_55_10 + arg_55_0 then
				arg_52_1:PlayTimeline("1054ui_story", "StoryTimeline/CharAction/story1054/story1054action/1054action3_2")
			end

			local var_55_11 = 0

			if var_55_11 < arg_52_1.time_ and arg_52_1.time_ <= var_55_11 + arg_55_0 then
				arg_52_1:PlayTimeline("1054ui_story", "StoryTimeline/CharAction/public_expression/expr_nanguoC", "EmotionTimelineAnimator")
			end

			local var_55_12 = 0
			local var_55_13 = 0.475

			if var_55_12 < arg_52_1.time_ and arg_52_1.time_ <= var_55_12 + arg_55_0 then
				arg_52_1.talkMaxDuration = 0
				arg_52_1.dialogCg_.alpha = 1

				arg_52_1.dialog_:SetActive(true)
				SetActive(arg_52_1.leftNameGo_, true)

				local var_55_14 = arg_52_1:FormatText(StoryNameCfg[1487].name)

				arg_52_1.leftNameTxt_.text = var_55_14

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_52_1.leftNameTxt_.transform)

				arg_52_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_52_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_52_1:RecordName(arg_52_1.leftNameTxt_.text)
				SetActive(arg_52_1.iconTrs_.gameObject, false)
				arg_52_1.callingController_:SetSelectedState("normal")

				local var_55_15 = arg_52_1:GetWordFromCfg(325591013)
				local var_55_16 = arg_52_1:FormatText(var_55_15.content)

				arg_52_1.text_.text = var_55_16

				LuaForUtil.ClearLinePrefixSymbol(arg_52_1.text_)

				local var_55_17 = 19
				local var_55_18 = utf8.len(var_55_16)
				local var_55_19 = var_55_17 <= 0 and var_55_13 or var_55_13 * (var_55_18 / var_55_17)

				if var_55_19 > 0 and var_55_13 < var_55_19 then
					arg_52_1.talkMaxDuration = var_55_19

					if var_55_19 + var_55_12 > arg_52_1.duration_ then
						arg_52_1.duration_ = var_55_19 + var_55_12
					end
				end

				arg_52_1.text_.text = var_55_16
				arg_52_1.typewritter.percent = 0

				arg_52_1.typewritter:SetDirty()
				arg_52_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_325591", "325591013", "story_v_out_325591.awb") ~= 0 then
					local var_55_20 = manager.audio:GetVoiceLength("story_v_out_325591", "325591013", "story_v_out_325591.awb") / 1000

					if var_55_20 + var_55_12 > arg_52_1.duration_ then
						arg_52_1.duration_ = var_55_20 + var_55_12
					end

					if var_55_15.prefab_name ~= "" and arg_52_1.actors_[var_55_15.prefab_name] ~= nil then
						local var_55_21 = LuaForUtil.PlayVoiceWithCriLipsync(arg_52_1.actors_[var_55_15.prefab_name].transform, "story_v_out_325591", "325591013", "story_v_out_325591.awb")

						arg_52_1:RecordAudio("325591013", var_55_21)
						arg_52_1:RecordAudio("325591013", var_55_21)
					else
						arg_52_1:AudioAction("play", "voice", "story_v_out_325591", "325591013", "story_v_out_325591.awb")
					end

					arg_52_1:RecordHistoryTalkVoice("story_v_out_325591", "325591013", "story_v_out_325591.awb")
				end

				arg_52_1:RecordContent(arg_52_1.text_.text)
			end

			local var_55_22 = math.max(var_55_13, arg_52_1.talkMaxDuration)

			if var_55_12 <= arg_52_1.time_ and arg_52_1.time_ < var_55_12 + var_55_22 then
				arg_52_1.typewritter.percent = (arg_52_1.time_ - var_55_12) / var_55_22

				arg_52_1.typewritter:SetDirty()
			end

			if arg_52_1.time_ >= var_55_12 + var_55_22 and arg_52_1.time_ < var_55_12 + var_55_22 + arg_55_0 then
				arg_52_1.typewritter.percent = 1

				arg_52_1.typewritter:SetDirty()
				arg_52_1:ShowNextGo(true)
			end
		end

		arg_52_1.nodeConfigList_ = {}

		arg_52_1:InitPlayNodeList()
	end,
	Play325591014 = function(arg_56_0, arg_56_1)
		arg_56_1.time_ = 0
		arg_56_1.frameCnt_ = 0
		arg_56_1.state_ = "playing"
		arg_56_1.curTalkId_ = 325591014
		arg_56_1.duration_ = 4

		local var_56_0 = {
			zh = 3.066,
			ja = 4
		}
		local var_56_1 = manager.audio:GetLocalizationFlag()

		if var_56_0[var_56_1] ~= nil then
			arg_56_1.duration_ = var_56_0[var_56_1]
		end

		SetActive(arg_56_1.tipsGo_, false)

		function arg_56_1.onSingleLineFinish_()
			arg_56_1.onSingleLineUpdate_ = nil
			arg_56_1.onSingleLineFinish_ = nil
			arg_56_1.state_ = "waiting"
		end

		function arg_56_1.playNext_(arg_58_0)
			if arg_58_0 == 1 then
				arg_56_0:Play325591015(arg_56_1)
			end
		end

		function arg_56_1.onSingleLineUpdate_(arg_59_0)
			local var_59_0 = 0
			local var_59_1 = 0.2

			if var_59_0 < arg_56_1.time_ and arg_56_1.time_ <= var_59_0 + arg_59_0 then
				arg_56_1.talkMaxDuration = 0
				arg_56_1.dialogCg_.alpha = 1

				arg_56_1.dialog_:SetActive(true)
				SetActive(arg_56_1.leftNameGo_, true)

				local var_59_2 = arg_56_1:FormatText(StoryNameCfg[1487].name)

				arg_56_1.leftNameTxt_.text = var_59_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_56_1.leftNameTxt_.transform)

				arg_56_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_56_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_56_1:RecordName(arg_56_1.leftNameTxt_.text)
				SetActive(arg_56_1.iconTrs_.gameObject, false)
				arg_56_1.callingController_:SetSelectedState("normal")

				local var_59_3 = arg_56_1:GetWordFromCfg(325591014)
				local var_59_4 = arg_56_1:FormatText(var_59_3.content)

				arg_56_1.text_.text = var_59_4

				LuaForUtil.ClearLinePrefixSymbol(arg_56_1.text_)

				local var_59_5 = 8
				local var_59_6 = utf8.len(var_59_4)
				local var_59_7 = var_59_5 <= 0 and var_59_1 or var_59_1 * (var_59_6 / var_59_5)

				if var_59_7 > 0 and var_59_1 < var_59_7 then
					arg_56_1.talkMaxDuration = var_59_7

					if var_59_7 + var_59_0 > arg_56_1.duration_ then
						arg_56_1.duration_ = var_59_7 + var_59_0
					end
				end

				arg_56_1.text_.text = var_59_4
				arg_56_1.typewritter.percent = 0

				arg_56_1.typewritter:SetDirty()
				arg_56_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_325591", "325591014", "story_v_out_325591.awb") ~= 0 then
					local var_59_8 = manager.audio:GetVoiceLength("story_v_out_325591", "325591014", "story_v_out_325591.awb") / 1000

					if var_59_8 + var_59_0 > arg_56_1.duration_ then
						arg_56_1.duration_ = var_59_8 + var_59_0
					end

					if var_59_3.prefab_name ~= "" and arg_56_1.actors_[var_59_3.prefab_name] ~= nil then
						local var_59_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_56_1.actors_[var_59_3.prefab_name].transform, "story_v_out_325591", "325591014", "story_v_out_325591.awb")

						arg_56_1:RecordAudio("325591014", var_59_9)
						arg_56_1:RecordAudio("325591014", var_59_9)
					else
						arg_56_1:AudioAction("play", "voice", "story_v_out_325591", "325591014", "story_v_out_325591.awb")
					end

					arg_56_1:RecordHistoryTalkVoice("story_v_out_325591", "325591014", "story_v_out_325591.awb")
				end

				arg_56_1:RecordContent(arg_56_1.text_.text)
			end

			local var_59_10 = math.max(var_59_1, arg_56_1.talkMaxDuration)

			if var_59_0 <= arg_56_1.time_ and arg_56_1.time_ < var_59_0 + var_59_10 then
				arg_56_1.typewritter.percent = (arg_56_1.time_ - var_59_0) / var_59_10

				arg_56_1.typewritter:SetDirty()
			end

			if arg_56_1.time_ >= var_59_0 + var_59_10 and arg_56_1.time_ < var_59_0 + var_59_10 + arg_59_0 then
				arg_56_1.typewritter.percent = 1

				arg_56_1.typewritter:SetDirty()
				arg_56_1:ShowNextGo(true)
			end
		end

		arg_56_1.nodeConfigList_ = {}

		arg_56_1:InitPlayNodeList()
	end,
	Play325591015 = function(arg_60_0, arg_60_1)
		arg_60_1.time_ = 0
		arg_60_1.frameCnt_ = 0
		arg_60_1.state_ = "playing"
		arg_60_1.curTalkId_ = 325591015
		arg_60_1.duration_ = 5.67

		local var_60_0 = {
			zh = 5.633,
			ja = 5.666
		}
		local var_60_1 = manager.audio:GetLocalizationFlag()

		if var_60_0[var_60_1] ~= nil then
			arg_60_1.duration_ = var_60_0[var_60_1]
		end

		SetActive(arg_60_1.tipsGo_, false)

		function arg_60_1.onSingleLineFinish_()
			arg_60_1.onSingleLineUpdate_ = nil
			arg_60_1.onSingleLineFinish_ = nil
			arg_60_1.state_ = "waiting"
		end

		function arg_60_1.playNext_(arg_62_0)
			if arg_62_0 == 1 then
				arg_60_0:Play325591016(arg_60_1)
			end
		end

		function arg_60_1.onSingleLineUpdate_(arg_63_0)
			local var_63_0 = arg_60_1.actors_["6148ui_story"]
			local var_63_1 = 0

			if var_63_1 < arg_60_1.time_ and arg_60_1.time_ <= var_63_1 + arg_63_0 and not isNil(var_63_0) and arg_60_1.var_.characterEffect6148ui_story == nil then
				arg_60_1.var_.characterEffect6148ui_story = var_63_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_63_2 = 0.200000002980232

			if var_63_1 <= arg_60_1.time_ and arg_60_1.time_ < var_63_1 + var_63_2 and not isNil(var_63_0) then
				local var_63_3 = (arg_60_1.time_ - var_63_1) / var_63_2

				if arg_60_1.var_.characterEffect6148ui_story and not isNil(var_63_0) then
					arg_60_1.var_.characterEffect6148ui_story.fillFlat = false
				end
			end

			if arg_60_1.time_ >= var_63_1 + var_63_2 and arg_60_1.time_ < var_63_1 + var_63_2 + arg_63_0 and not isNil(var_63_0) and arg_60_1.var_.characterEffect6148ui_story then
				arg_60_1.var_.characterEffect6148ui_story.fillFlat = false
			end

			local var_63_4 = arg_60_1.actors_["1054ui_story"]
			local var_63_5 = 0

			if var_63_5 < arg_60_1.time_ and arg_60_1.time_ <= var_63_5 + arg_63_0 and not isNil(var_63_4) and arg_60_1.var_.characterEffect1054ui_story == nil then
				arg_60_1.var_.characterEffect1054ui_story = var_63_4:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_63_6 = 0.200000002980232

			if var_63_5 <= arg_60_1.time_ and arg_60_1.time_ < var_63_5 + var_63_6 and not isNil(var_63_4) then
				local var_63_7 = (arg_60_1.time_ - var_63_5) / var_63_6

				if arg_60_1.var_.characterEffect1054ui_story and not isNil(var_63_4) then
					local var_63_8 = Mathf.Lerp(0, 0.5, var_63_7)

					arg_60_1.var_.characterEffect1054ui_story.fillFlat = true
					arg_60_1.var_.characterEffect1054ui_story.fillRatio = var_63_8
				end
			end

			if arg_60_1.time_ >= var_63_5 + var_63_6 and arg_60_1.time_ < var_63_5 + var_63_6 + arg_63_0 and not isNil(var_63_4) and arg_60_1.var_.characterEffect1054ui_story then
				local var_63_9 = 0.5

				arg_60_1.var_.characterEffect1054ui_story.fillFlat = true
				arg_60_1.var_.characterEffect1054ui_story.fillRatio = var_63_9
			end

			local var_63_10 = 0

			if var_63_10 < arg_60_1.time_ and arg_60_1.time_ <= var_63_10 + arg_63_0 then
				arg_60_1:PlayTimeline("6148ui_story", "StoryTimeline/CharAction/story6148/story6148action/6148action5_2")
			end

			local var_63_11 = 0

			if var_63_11 < arg_60_1.time_ and arg_60_1.time_ <= var_63_11 + arg_63_0 then
				arg_60_1:PlayTimeline("6148ui_story", "StoryTimeline/CharAction/public_expression/expr_youyu", "EmotionTimelineAnimator")
			end

			local var_63_12 = 0
			local var_63_13 = 0.675

			if var_63_12 < arg_60_1.time_ and arg_60_1.time_ <= var_63_12 + arg_63_0 then
				arg_60_1.talkMaxDuration = 0
				arg_60_1.dialogCg_.alpha = 1

				arg_60_1.dialog_:SetActive(true)
				SetActive(arg_60_1.leftNameGo_, true)

				local var_63_14 = arg_60_1:FormatText(StoryNameCfg[1488].name)

				arg_60_1.leftNameTxt_.text = var_63_14

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_60_1.leftNameTxt_.transform)

				arg_60_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_60_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_60_1:RecordName(arg_60_1.leftNameTxt_.text)
				SetActive(arg_60_1.iconTrs_.gameObject, false)
				arg_60_1.callingController_:SetSelectedState("normal")

				local var_63_15 = arg_60_1:GetWordFromCfg(325591015)
				local var_63_16 = arg_60_1:FormatText(var_63_15.content)

				arg_60_1.text_.text = var_63_16

				LuaForUtil.ClearLinePrefixSymbol(arg_60_1.text_)

				local var_63_17 = 27
				local var_63_18 = utf8.len(var_63_16)
				local var_63_19 = var_63_17 <= 0 and var_63_13 or var_63_13 * (var_63_18 / var_63_17)

				if var_63_19 > 0 and var_63_13 < var_63_19 then
					arg_60_1.talkMaxDuration = var_63_19

					if var_63_19 + var_63_12 > arg_60_1.duration_ then
						arg_60_1.duration_ = var_63_19 + var_63_12
					end
				end

				arg_60_1.text_.text = var_63_16
				arg_60_1.typewritter.percent = 0

				arg_60_1.typewritter:SetDirty()
				arg_60_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_325591", "325591015", "story_v_out_325591.awb") ~= 0 then
					local var_63_20 = manager.audio:GetVoiceLength("story_v_out_325591", "325591015", "story_v_out_325591.awb") / 1000

					if var_63_20 + var_63_12 > arg_60_1.duration_ then
						arg_60_1.duration_ = var_63_20 + var_63_12
					end

					if var_63_15.prefab_name ~= "" and arg_60_1.actors_[var_63_15.prefab_name] ~= nil then
						local var_63_21 = LuaForUtil.PlayVoiceWithCriLipsync(arg_60_1.actors_[var_63_15.prefab_name].transform, "story_v_out_325591", "325591015", "story_v_out_325591.awb")

						arg_60_1:RecordAudio("325591015", var_63_21)
						arg_60_1:RecordAudio("325591015", var_63_21)
					else
						arg_60_1:AudioAction("play", "voice", "story_v_out_325591", "325591015", "story_v_out_325591.awb")
					end

					arg_60_1:RecordHistoryTalkVoice("story_v_out_325591", "325591015", "story_v_out_325591.awb")
				end

				arg_60_1:RecordContent(arg_60_1.text_.text)
			end

			local var_63_22 = math.max(var_63_13, arg_60_1.talkMaxDuration)

			if var_63_12 <= arg_60_1.time_ and arg_60_1.time_ < var_63_12 + var_63_22 then
				arg_60_1.typewritter.percent = (arg_60_1.time_ - var_63_12) / var_63_22

				arg_60_1.typewritter:SetDirty()
			end

			if arg_60_1.time_ >= var_63_12 + var_63_22 and arg_60_1.time_ < var_63_12 + var_63_22 + arg_63_0 then
				arg_60_1.typewritter.percent = 1

				arg_60_1.typewritter:SetDirty()
				arg_60_1:ShowNextGo(true)
			end
		end

		arg_60_1.nodeConfigList_ = {}

		arg_60_1:InitPlayNodeList()
	end,
	Play325591016 = function(arg_64_0, arg_64_1)
		arg_64_1.time_ = 0
		arg_64_1.frameCnt_ = 0
		arg_64_1.state_ = "playing"
		arg_64_1.curTalkId_ = 325591016
		arg_64_1.duration_ = 9

		local var_64_0 = {
			zh = 9,
			ja = 8.833
		}
		local var_64_1 = manager.audio:GetLocalizationFlag()

		if var_64_0[var_64_1] ~= nil then
			arg_64_1.duration_ = var_64_0[var_64_1]
		end

		SetActive(arg_64_1.tipsGo_, false)

		function arg_64_1.onSingleLineFinish_()
			arg_64_1.onSingleLineUpdate_ = nil
			arg_64_1.onSingleLineFinish_ = nil
			arg_64_1.state_ = "waiting"
		end

		function arg_64_1.playNext_(arg_66_0)
			if arg_66_0 == 1 then
				arg_64_0:Play325591017(arg_64_1)
			end
		end

		function arg_64_1.onSingleLineUpdate_(arg_67_0)
			local var_67_0 = "J28h"

			if arg_64_1.bgs_[var_67_0] == nil then
				local var_67_1 = Object.Instantiate(arg_64_1.paintGo_)

				var_67_1:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. var_67_0)
				var_67_1.name = var_67_0
				var_67_1.transform.parent = arg_64_1.stage_.transform
				var_67_1.transform.localPosition = Vector3.New(0, 100, 0)
				arg_64_1.bgs_[var_67_0] = var_67_1
			end

			local var_67_2 = 2

			if var_67_2 < arg_64_1.time_ and arg_64_1.time_ <= var_67_2 + arg_67_0 then
				local var_67_3 = manager.ui.mainCamera.transform.localPosition
				local var_67_4 = Vector3.New(0, 0, 10) + Vector3.New(var_67_3.x, var_67_3.y, 0)
				local var_67_5 = arg_64_1.bgs_.J28h

				var_67_5.transform.localPosition = var_67_4
				var_67_5.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_67_6 = var_67_5:GetComponent("SpriteRenderer")

				if var_67_6 and var_67_6.sprite then
					local var_67_7 = (var_67_5.transform.localPosition - var_67_3).z
					local var_67_8 = manager.ui.mainCameraCom_
					local var_67_9 = 2 * var_67_7 * Mathf.Tan(var_67_8.fieldOfView * 0.5 * Mathf.Deg2Rad)
					local var_67_10 = var_67_9 * var_67_8.aspect
					local var_67_11 = var_67_6.sprite.bounds.size.x
					local var_67_12 = var_67_6.sprite.bounds.size.y
					local var_67_13 = var_67_10 / var_67_11
					local var_67_14 = var_67_9 / var_67_12
					local var_67_15 = var_67_14 < var_67_13 and var_67_13 or var_67_14

					var_67_5.transform.localScale = Vector3.New(var_67_15, var_67_15, 0)
				end

				for iter_67_0, iter_67_1 in pairs(arg_64_1.bgs_) do
					if iter_67_0 ~= "J28h" then
						iter_67_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_67_16 = 4

			if var_67_16 < arg_64_1.time_ and arg_64_1.time_ <= var_67_16 + arg_67_0 then
				arg_64_1.allBtn_.enabled = false
			end

			local var_67_17 = 0.3

			if arg_64_1.time_ >= var_67_16 + var_67_17 and arg_64_1.time_ < var_67_16 + var_67_17 + arg_67_0 then
				arg_64_1.allBtn_.enabled = true
			end

			local var_67_18 = 0

			if var_67_18 < arg_64_1.time_ and arg_64_1.time_ <= var_67_18 + arg_67_0 then
				arg_64_1.mask_.enabled = true
				arg_64_1.mask_.raycastTarget = true

				arg_64_1:SetGaussion(false)
			end

			local var_67_19 = 2

			if var_67_18 <= arg_64_1.time_ and arg_64_1.time_ < var_67_18 + var_67_19 then
				local var_67_20 = (arg_64_1.time_ - var_67_18) / var_67_19
				local var_67_21 = Color.New(0, 0, 0)

				var_67_21.a = Mathf.Lerp(0, 1, var_67_20)
				arg_64_1.mask_.color = var_67_21
			end

			if arg_64_1.time_ >= var_67_18 + var_67_19 and arg_64_1.time_ < var_67_18 + var_67_19 + arg_67_0 then
				local var_67_22 = Color.New(0, 0, 0)

				var_67_22.a = 1
				arg_64_1.mask_.color = var_67_22
			end

			local var_67_23 = 2

			if var_67_23 < arg_64_1.time_ and arg_64_1.time_ <= var_67_23 + arg_67_0 then
				arg_64_1.mask_.enabled = true
				arg_64_1.mask_.raycastTarget = true

				arg_64_1:SetGaussion(false)
			end

			local var_67_24 = 2

			if var_67_23 <= arg_64_1.time_ and arg_64_1.time_ < var_67_23 + var_67_24 then
				local var_67_25 = (arg_64_1.time_ - var_67_23) / var_67_24
				local var_67_26 = Color.New(0, 0, 0)

				var_67_26.a = Mathf.Lerp(1, 0, var_67_25)
				arg_64_1.mask_.color = var_67_26
			end

			if arg_64_1.time_ >= var_67_23 + var_67_24 and arg_64_1.time_ < var_67_23 + var_67_24 + arg_67_0 then
				local var_67_27 = Color.New(0, 0, 0)
				local var_67_28 = 0

				arg_64_1.mask_.enabled = false
				var_67_27.a = var_67_28
				arg_64_1.mask_.color = var_67_27
			end

			local var_67_29 = arg_64_1.actors_["6148ui_story"].transform
			local var_67_30 = 1.96599999815226

			if var_67_30 < arg_64_1.time_ and arg_64_1.time_ <= var_67_30 + arg_67_0 then
				arg_64_1.var_.moveOldPos6148ui_story = var_67_29.localPosition

				local var_67_31 = GameObjectTools.GetOrAddComponent(var_67_29.gameObject, typeof(DynamicBoneHelper))

				if var_67_31 then
					var_67_31:EnableDynamicBone(false)
				end
			end

			local var_67_32 = 0.001

			if var_67_30 <= arg_64_1.time_ and arg_64_1.time_ < var_67_30 + var_67_32 then
				local var_67_33 = (arg_64_1.time_ - var_67_30) / var_67_32
				local var_67_34 = Vector3.New(0, 100, 0)

				var_67_29.localPosition = Vector3.Lerp(arg_64_1.var_.moveOldPos6148ui_story, var_67_34, var_67_33)

				local var_67_35 = manager.ui.mainCamera.transform.position - var_67_29.position

				var_67_29.forward = Vector3.New(var_67_35.x, var_67_35.y, var_67_35.z)

				local var_67_36 = var_67_29.localEulerAngles

				var_67_36.z = 0
				var_67_36.x = 0
				var_67_29.localEulerAngles = var_67_36
			end

			if arg_64_1.time_ >= var_67_30 + var_67_32 and arg_64_1.time_ < var_67_30 + var_67_32 + arg_67_0 then
				var_67_29.localPosition = Vector3.New(0, 100, 0)

				local var_67_37 = manager.ui.mainCamera.transform.position - var_67_29.position

				var_67_29.forward = Vector3.New(var_67_37.x, var_67_37.y, var_67_37.z)

				local var_67_38 = var_67_29.localEulerAngles

				var_67_38.z = 0
				var_67_38.x = 0
				var_67_29.localEulerAngles = var_67_38

				local var_67_39 = GameObjectTools.GetOrAddComponent(var_67_29.gameObject, typeof(DynamicBoneHelper))

				if var_67_39 then
					var_67_39:EnableDynamicBone(true)
				end
			end

			local var_67_40 = arg_64_1.actors_["1054ui_story"].transform
			local var_67_41 = 1.96599999815226

			if var_67_41 < arg_64_1.time_ and arg_64_1.time_ <= var_67_41 + arg_67_0 then
				arg_64_1.var_.moveOldPos1054ui_story = var_67_40.localPosition

				local var_67_42 = GameObjectTools.GetOrAddComponent(var_67_40.gameObject, typeof(DynamicBoneHelper))

				if var_67_42 then
					var_67_42:EnableDynamicBone(false)
				end
			end

			local var_67_43 = 0.001

			if var_67_41 <= arg_64_1.time_ and arg_64_1.time_ < var_67_41 + var_67_43 then
				local var_67_44 = (arg_64_1.time_ - var_67_41) / var_67_43
				local var_67_45 = Vector3.New(0, 100, 0)

				var_67_40.localPosition = Vector3.Lerp(arg_64_1.var_.moveOldPos1054ui_story, var_67_45, var_67_44)

				local var_67_46 = manager.ui.mainCamera.transform.position - var_67_40.position

				var_67_40.forward = Vector3.New(var_67_46.x, var_67_46.y, var_67_46.z)

				local var_67_47 = var_67_40.localEulerAngles

				var_67_47.z = 0
				var_67_47.x = 0
				var_67_40.localEulerAngles = var_67_47
			end

			if arg_64_1.time_ >= var_67_41 + var_67_43 and arg_64_1.time_ < var_67_41 + var_67_43 + arg_67_0 then
				var_67_40.localPosition = Vector3.New(0, 100, 0)

				local var_67_48 = manager.ui.mainCamera.transform.position - var_67_40.position

				var_67_40.forward = Vector3.New(var_67_48.x, var_67_48.y, var_67_48.z)

				local var_67_49 = var_67_40.localEulerAngles

				var_67_49.z = 0
				var_67_49.x = 0
				var_67_40.localEulerAngles = var_67_49

				local var_67_50 = GameObjectTools.GetOrAddComponent(var_67_40.gameObject, typeof(DynamicBoneHelper))

				if var_67_50 then
					var_67_50:EnableDynamicBone(true)
				end
			end

			local var_67_51 = arg_64_1.actors_["1054ui_story"]
			local var_67_52 = 1.96599999815226

			if var_67_52 < arg_64_1.time_ and arg_64_1.time_ <= var_67_52 + arg_67_0 and not isNil(var_67_51) and arg_64_1.var_.characterEffect1054ui_story == nil then
				arg_64_1.var_.characterEffect1054ui_story = var_67_51:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_67_53 = 0.034000001847744

			if var_67_52 <= arg_64_1.time_ and arg_64_1.time_ < var_67_52 + var_67_53 and not isNil(var_67_51) then
				local var_67_54 = (arg_64_1.time_ - var_67_52) / var_67_53

				if arg_64_1.var_.characterEffect1054ui_story and not isNil(var_67_51) then
					arg_64_1.var_.characterEffect1054ui_story.fillFlat = false
				end
			end

			if arg_64_1.time_ >= var_67_52 + var_67_53 and arg_64_1.time_ < var_67_52 + var_67_53 + arg_67_0 and not isNil(var_67_51) and arg_64_1.var_.characterEffect1054ui_story then
				arg_64_1.var_.characterEffect1054ui_story.fillFlat = false
			end

			local var_67_55 = arg_64_1.actors_["6148ui_story"]
			local var_67_56 = 1.96599999815226

			if var_67_56 < arg_64_1.time_ and arg_64_1.time_ <= var_67_56 + arg_67_0 and not isNil(var_67_55) and arg_64_1.var_.characterEffect6148ui_story == nil then
				arg_64_1.var_.characterEffect6148ui_story = var_67_55:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_67_57 = 0.034000001847744

			if var_67_56 <= arg_64_1.time_ and arg_64_1.time_ < var_67_56 + var_67_57 and not isNil(var_67_55) then
				local var_67_58 = (arg_64_1.time_ - var_67_56) / var_67_57

				if arg_64_1.var_.characterEffect6148ui_story and not isNil(var_67_55) then
					local var_67_59 = Mathf.Lerp(0, 0.5, var_67_58)

					arg_64_1.var_.characterEffect6148ui_story.fillFlat = true
					arg_64_1.var_.characterEffect6148ui_story.fillRatio = var_67_59
				end
			end

			if arg_64_1.time_ >= var_67_56 + var_67_57 and arg_64_1.time_ < var_67_56 + var_67_57 + arg_67_0 and not isNil(var_67_55) and arg_64_1.var_.characterEffect6148ui_story then
				local var_67_60 = 0.5

				arg_64_1.var_.characterEffect6148ui_story.fillFlat = true
				arg_64_1.var_.characterEffect6148ui_story.fillRatio = var_67_60
			end

			local var_67_61 = arg_64_1.actors_["1054ui_story"].transform
			local var_67_62 = 3.8

			if var_67_62 < arg_64_1.time_ and arg_64_1.time_ <= var_67_62 + arg_67_0 then
				arg_64_1.var_.moveOldPos1054ui_story = var_67_61.localPosition

				local var_67_63 = GameObjectTools.GetOrAddComponent(var_67_61.gameObject, typeof(DynamicBoneHelper))

				if var_67_63 then
					var_67_63:EnableDynamicBone(false)
				end
			end

			local var_67_64 = 0.001

			if var_67_62 <= arg_64_1.time_ and arg_64_1.time_ < var_67_62 + var_67_64 then
				local var_67_65 = (arg_64_1.time_ - var_67_62) / var_67_64
				local var_67_66 = Vector3.New(0, -0.985, -6)

				var_67_61.localPosition = Vector3.Lerp(arg_64_1.var_.moveOldPos1054ui_story, var_67_66, var_67_65)

				local var_67_67 = manager.ui.mainCamera.transform.position - var_67_61.position

				var_67_61.forward = Vector3.New(var_67_67.x, var_67_67.y, var_67_67.z)

				local var_67_68 = var_67_61.localEulerAngles

				var_67_68.z = 0
				var_67_68.x = 0
				var_67_61.localEulerAngles = var_67_68
			end

			if arg_64_1.time_ >= var_67_62 + var_67_64 and arg_64_1.time_ < var_67_62 + var_67_64 + arg_67_0 then
				var_67_61.localPosition = Vector3.New(0, -0.985, -6)

				local var_67_69 = manager.ui.mainCamera.transform.position - var_67_61.position

				var_67_61.forward = Vector3.New(var_67_69.x, var_67_69.y, var_67_69.z)

				local var_67_70 = var_67_61.localEulerAngles

				var_67_70.z = 0
				var_67_70.x = 0
				var_67_61.localEulerAngles = var_67_70

				local var_67_71 = GameObjectTools.GetOrAddComponent(var_67_61.gameObject, typeof(DynamicBoneHelper))

				if var_67_71 then
					var_67_71:EnableDynamicBone(true)
				end
			end

			local var_67_72 = arg_64_1.actors_["1054ui_story"]
			local var_67_73 = 3.8

			if var_67_73 < arg_64_1.time_ and arg_64_1.time_ <= var_67_73 + arg_67_0 and not isNil(var_67_72) and arg_64_1.var_.characterEffect1054ui_story == nil then
				arg_64_1.var_.characterEffect1054ui_story = var_67_72:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_67_74 = 0.200000002980232

			if var_67_73 <= arg_64_1.time_ and arg_64_1.time_ < var_67_73 + var_67_74 and not isNil(var_67_72) then
				local var_67_75 = (arg_64_1.time_ - var_67_73) / var_67_74

				if arg_64_1.var_.characterEffect1054ui_story and not isNil(var_67_72) then
					arg_64_1.var_.characterEffect1054ui_story.fillFlat = false
				end
			end

			if arg_64_1.time_ >= var_67_73 + var_67_74 and arg_64_1.time_ < var_67_73 + var_67_74 + arg_67_0 and not isNil(var_67_72) and arg_64_1.var_.characterEffect1054ui_story then
				arg_64_1.var_.characterEffect1054ui_story.fillFlat = false
			end

			local var_67_76 = 3.8

			if var_67_76 < arg_64_1.time_ and arg_64_1.time_ <= var_67_76 + arg_67_0 then
				arg_64_1:PlayTimeline("1054ui_story", "StoryTimeline/CharAction/story1054/story1054action/1054action1_1")
			end

			local var_67_77 = 3.8

			if var_67_77 < arg_64_1.time_ and arg_64_1.time_ <= var_67_77 + arg_67_0 then
				arg_64_1:PlayTimeline("1054ui_story", "StoryTimeline/CharAction/public_expression/expr_youyu", "EmotionTimelineAnimator")
			end

			if arg_64_1.frameCnt_ <= 1 then
				arg_64_1.dialog_:SetActive(false)
			end

			local var_67_78 = 4
			local var_67_79 = 0.325

			if var_67_78 < arg_64_1.time_ and arg_64_1.time_ <= var_67_78 + arg_67_0 then
				arg_64_1.talkMaxDuration = 0

				arg_64_1.dialog_:SetActive(true)

				arg_64_1.dialogCg_.alpha = 0

				local var_67_80 = LeanTween.value(arg_64_1.dialog_, 0, 1, 0.3)

				var_67_80:setOnUpdate(LuaHelper.FloatAction(function(arg_68_0)
					arg_64_1.dialogCg_.alpha = arg_68_0
				end))
				var_67_80:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_64_1.dialog_)
					var_67_80:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_64_1.duration_ = arg_64_1.duration_ + 0.3

				SetActive(arg_64_1.leftNameGo_, true)

				local var_67_81 = arg_64_1:FormatText(StoryNameCfg[1487].name)

				arg_64_1.leftNameTxt_.text = var_67_81

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_64_1.leftNameTxt_.transform)

				arg_64_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_64_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_64_1:RecordName(arg_64_1.leftNameTxt_.text)
				SetActive(arg_64_1.iconTrs_.gameObject, false)
				arg_64_1.callingController_:SetSelectedState("normal")

				local var_67_82 = arg_64_1:GetWordFromCfg(325591016)
				local var_67_83 = arg_64_1:FormatText(var_67_82.content)

				arg_64_1.text_.text = var_67_83

				LuaForUtil.ClearLinePrefixSymbol(arg_64_1.text_)

				local var_67_84 = 13
				local var_67_85 = utf8.len(var_67_83)
				local var_67_86 = var_67_84 <= 0 and var_67_79 or var_67_79 * (var_67_85 / var_67_84)

				if var_67_86 > 0 and var_67_79 < var_67_86 then
					arg_64_1.talkMaxDuration = var_67_86
					var_67_78 = var_67_78 + 0.3

					if var_67_86 + var_67_78 > arg_64_1.duration_ then
						arg_64_1.duration_ = var_67_86 + var_67_78
					end
				end

				arg_64_1.text_.text = var_67_83
				arg_64_1.typewritter.percent = 0

				arg_64_1.typewritter:SetDirty()
				arg_64_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_325591", "325591016", "story_v_out_325591.awb") ~= 0 then
					local var_67_87 = manager.audio:GetVoiceLength("story_v_out_325591", "325591016", "story_v_out_325591.awb") / 1000

					if var_67_87 + var_67_78 > arg_64_1.duration_ then
						arg_64_1.duration_ = var_67_87 + var_67_78
					end

					if var_67_82.prefab_name ~= "" and arg_64_1.actors_[var_67_82.prefab_name] ~= nil then
						local var_67_88 = LuaForUtil.PlayVoiceWithCriLipsync(arg_64_1.actors_[var_67_82.prefab_name].transform, "story_v_out_325591", "325591016", "story_v_out_325591.awb")

						arg_64_1:RecordAudio("325591016", var_67_88)
						arg_64_1:RecordAudio("325591016", var_67_88)
					else
						arg_64_1:AudioAction("play", "voice", "story_v_out_325591", "325591016", "story_v_out_325591.awb")
					end

					arg_64_1:RecordHistoryTalkVoice("story_v_out_325591", "325591016", "story_v_out_325591.awb")
				end

				arg_64_1:RecordContent(arg_64_1.text_.text)
			end

			local var_67_89 = var_67_78 + 0.3
			local var_67_90 = math.max(var_67_79, arg_64_1.talkMaxDuration)

			if var_67_89 <= arg_64_1.time_ and arg_64_1.time_ < var_67_89 + var_67_90 then
				arg_64_1.typewritter.percent = (arg_64_1.time_ - var_67_89) / var_67_90

				arg_64_1.typewritter:SetDirty()
			end

			if arg_64_1.time_ >= var_67_89 + var_67_90 and arg_64_1.time_ < var_67_89 + var_67_90 + arg_67_0 then
				arg_64_1.typewritter.percent = 1

				arg_64_1.typewritter:SetDirty()
				arg_64_1:ShowNextGo(true)
			end
		end

		arg_64_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "6148ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 1.96599999815226,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1054ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 1.96599999815226,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1054ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 3.8,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_64_1:InitPlayNodeList()
	end,
	Play325591017 = function(arg_70_0, arg_70_1)
		arg_70_1.time_ = 0
		arg_70_1.frameCnt_ = 0
		arg_70_1.state_ = "playing"
		arg_70_1.curTalkId_ = 325591017
		arg_70_1.duration_ = 4.23

		local var_70_0 = {
			zh = 4.233,
			ja = 3.3
		}
		local var_70_1 = manager.audio:GetLocalizationFlag()

		if var_70_0[var_70_1] ~= nil then
			arg_70_1.duration_ = var_70_0[var_70_1]
		end

		SetActive(arg_70_1.tipsGo_, false)

		function arg_70_1.onSingleLineFinish_()
			arg_70_1.onSingleLineUpdate_ = nil
			arg_70_1.onSingleLineFinish_ = nil
			arg_70_1.state_ = "waiting"
		end

		function arg_70_1.playNext_(arg_72_0)
			if arg_72_0 == 1 then
				arg_70_0:Play325591018(arg_70_1)
			end
		end

		function arg_70_1.onSingleLineUpdate_(arg_73_0)
			local var_73_0 = arg_70_1.actors_["1054ui_story"].transform
			local var_73_1 = 0

			if var_73_1 < arg_70_1.time_ and arg_70_1.time_ <= var_73_1 + arg_73_0 then
				arg_70_1.var_.moveOldPos1054ui_story = var_73_0.localPosition

				local var_73_2 = GameObjectTools.GetOrAddComponent(var_73_0.gameObject, typeof(DynamicBoneHelper))

				if var_73_2 then
					var_73_2:EnableDynamicBone(false)
				end
			end

			local var_73_3 = 0.001

			if var_73_1 <= arg_70_1.time_ and arg_70_1.time_ < var_73_1 + var_73_3 then
				local var_73_4 = (arg_70_1.time_ - var_73_1) / var_73_3
				local var_73_5 = Vector3.New(-0.7, -0.985, -6)

				var_73_0.localPosition = Vector3.Lerp(arg_70_1.var_.moveOldPos1054ui_story, var_73_5, var_73_4)

				local var_73_6 = manager.ui.mainCamera.transform.position - var_73_0.position

				var_73_0.forward = Vector3.New(var_73_6.x, var_73_6.y, var_73_6.z)

				local var_73_7 = var_73_0.localEulerAngles

				var_73_7.z = 0
				var_73_7.x = 0
				var_73_0.localEulerAngles = var_73_7
			end

			if arg_70_1.time_ >= var_73_1 + var_73_3 and arg_70_1.time_ < var_73_1 + var_73_3 + arg_73_0 then
				var_73_0.localPosition = Vector3.New(-0.7, -0.985, -6)

				local var_73_8 = manager.ui.mainCamera.transform.position - var_73_0.position

				var_73_0.forward = Vector3.New(var_73_8.x, var_73_8.y, var_73_8.z)

				local var_73_9 = var_73_0.localEulerAngles

				var_73_9.z = 0
				var_73_9.x = 0
				var_73_0.localEulerAngles = var_73_9

				local var_73_10 = GameObjectTools.GetOrAddComponent(var_73_0.gameObject, typeof(DynamicBoneHelper))

				if var_73_10 then
					var_73_10:EnableDynamicBone(true)
				end
			end

			local var_73_11 = arg_70_1.actors_["6148ui_story"].transform
			local var_73_12 = 0

			if var_73_12 < arg_70_1.time_ and arg_70_1.time_ <= var_73_12 + arg_73_0 then
				arg_70_1.var_.moveOldPos6148ui_story = var_73_11.localPosition

				local var_73_13 = GameObjectTools.GetOrAddComponent(var_73_11.gameObject, typeof(DynamicBoneHelper))

				if var_73_13 then
					var_73_13:EnableDynamicBone(false)
				end
			end

			local var_73_14 = 0.001

			if var_73_12 <= arg_70_1.time_ and arg_70_1.time_ < var_73_12 + var_73_14 then
				local var_73_15 = (arg_70_1.time_ - var_73_12) / var_73_14
				local var_73_16 = Vector3.New(0.7, -0.985, -6)

				var_73_11.localPosition = Vector3.Lerp(arg_70_1.var_.moveOldPos6148ui_story, var_73_16, var_73_15)

				local var_73_17 = manager.ui.mainCamera.transform.position - var_73_11.position

				var_73_11.forward = Vector3.New(var_73_17.x, var_73_17.y, var_73_17.z)

				local var_73_18 = var_73_11.localEulerAngles

				var_73_18.z = 0
				var_73_18.x = 0
				var_73_11.localEulerAngles = var_73_18
			end

			if arg_70_1.time_ >= var_73_12 + var_73_14 and arg_70_1.time_ < var_73_12 + var_73_14 + arg_73_0 then
				var_73_11.localPosition = Vector3.New(0.7, -0.985, -6)

				local var_73_19 = manager.ui.mainCamera.transform.position - var_73_11.position

				var_73_11.forward = Vector3.New(var_73_19.x, var_73_19.y, var_73_19.z)

				local var_73_20 = var_73_11.localEulerAngles

				var_73_20.z = 0
				var_73_20.x = 0
				var_73_11.localEulerAngles = var_73_20

				local var_73_21 = GameObjectTools.GetOrAddComponent(var_73_11.gameObject, typeof(DynamicBoneHelper))

				if var_73_21 then
					var_73_21:EnableDynamicBone(true)
				end
			end

			local var_73_22 = arg_70_1.actors_["6148ui_story"]
			local var_73_23 = 0

			if var_73_23 < arg_70_1.time_ and arg_70_1.time_ <= var_73_23 + arg_73_0 and not isNil(var_73_22) and arg_70_1.var_.characterEffect6148ui_story == nil then
				arg_70_1.var_.characterEffect6148ui_story = var_73_22:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_73_24 = 0.200000002980232

			if var_73_23 <= arg_70_1.time_ and arg_70_1.time_ < var_73_23 + var_73_24 and not isNil(var_73_22) then
				local var_73_25 = (arg_70_1.time_ - var_73_23) / var_73_24

				if arg_70_1.var_.characterEffect6148ui_story and not isNil(var_73_22) then
					arg_70_1.var_.characterEffect6148ui_story.fillFlat = false
				end
			end

			if arg_70_1.time_ >= var_73_23 + var_73_24 and arg_70_1.time_ < var_73_23 + var_73_24 + arg_73_0 and not isNil(var_73_22) and arg_70_1.var_.characterEffect6148ui_story then
				arg_70_1.var_.characterEffect6148ui_story.fillFlat = false
			end

			local var_73_26 = arg_70_1.actors_["1054ui_story"]
			local var_73_27 = 0

			if var_73_27 < arg_70_1.time_ and arg_70_1.time_ <= var_73_27 + arg_73_0 and not isNil(var_73_26) and arg_70_1.var_.characterEffect1054ui_story == nil then
				arg_70_1.var_.characterEffect1054ui_story = var_73_26:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_73_28 = 0.200000002980232

			if var_73_27 <= arg_70_1.time_ and arg_70_1.time_ < var_73_27 + var_73_28 and not isNil(var_73_26) then
				local var_73_29 = (arg_70_1.time_ - var_73_27) / var_73_28

				if arg_70_1.var_.characterEffect1054ui_story and not isNil(var_73_26) then
					local var_73_30 = Mathf.Lerp(0, 0.5, var_73_29)

					arg_70_1.var_.characterEffect1054ui_story.fillFlat = true
					arg_70_1.var_.characterEffect1054ui_story.fillRatio = var_73_30
				end
			end

			if arg_70_1.time_ >= var_73_27 + var_73_28 and arg_70_1.time_ < var_73_27 + var_73_28 + arg_73_0 and not isNil(var_73_26) and arg_70_1.var_.characterEffect1054ui_story then
				local var_73_31 = 0.5

				arg_70_1.var_.characterEffect1054ui_story.fillFlat = true
				arg_70_1.var_.characterEffect1054ui_story.fillRatio = var_73_31
			end

			local var_73_32 = 0

			if var_73_32 < arg_70_1.time_ and arg_70_1.time_ <= var_73_32 + arg_73_0 then
				arg_70_1:PlayTimeline("6148ui_story", "StoryTimeline/CharAction/story6148/story6148action/6148action4_1")
			end

			local var_73_33 = 0

			if var_73_33 < arg_70_1.time_ and arg_70_1.time_ <= var_73_33 + arg_73_0 then
				arg_70_1:PlayTimeline("6148ui_story", "StoryTimeline/CharAction/public_expression/expr_youyu", "EmotionTimelineAnimator")
			end

			local var_73_34 = 0
			local var_73_35 = 0.45

			if var_73_34 < arg_70_1.time_ and arg_70_1.time_ <= var_73_34 + arg_73_0 then
				arg_70_1.talkMaxDuration = 0
				arg_70_1.dialogCg_.alpha = 1

				arg_70_1.dialog_:SetActive(true)
				SetActive(arg_70_1.leftNameGo_, true)

				local var_73_36 = arg_70_1:FormatText(StoryNameCfg[1488].name)

				arg_70_1.leftNameTxt_.text = var_73_36

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_70_1.leftNameTxt_.transform)

				arg_70_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_70_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_70_1:RecordName(arg_70_1.leftNameTxt_.text)
				SetActive(arg_70_1.iconTrs_.gameObject, false)
				arg_70_1.callingController_:SetSelectedState("normal")

				local var_73_37 = arg_70_1:GetWordFromCfg(325591017)
				local var_73_38 = arg_70_1:FormatText(var_73_37.content)

				arg_70_1.text_.text = var_73_38

				LuaForUtil.ClearLinePrefixSymbol(arg_70_1.text_)

				local var_73_39 = 18
				local var_73_40 = utf8.len(var_73_38)
				local var_73_41 = var_73_39 <= 0 and var_73_35 or var_73_35 * (var_73_40 / var_73_39)

				if var_73_41 > 0 and var_73_35 < var_73_41 then
					arg_70_1.talkMaxDuration = var_73_41

					if var_73_41 + var_73_34 > arg_70_1.duration_ then
						arg_70_1.duration_ = var_73_41 + var_73_34
					end
				end

				arg_70_1.text_.text = var_73_38
				arg_70_1.typewritter.percent = 0

				arg_70_1.typewritter:SetDirty()
				arg_70_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_325591", "325591017", "story_v_out_325591.awb") ~= 0 then
					local var_73_42 = manager.audio:GetVoiceLength("story_v_out_325591", "325591017", "story_v_out_325591.awb") / 1000

					if var_73_42 + var_73_34 > arg_70_1.duration_ then
						arg_70_1.duration_ = var_73_42 + var_73_34
					end

					if var_73_37.prefab_name ~= "" and arg_70_1.actors_[var_73_37.prefab_name] ~= nil then
						local var_73_43 = LuaForUtil.PlayVoiceWithCriLipsync(arg_70_1.actors_[var_73_37.prefab_name].transform, "story_v_out_325591", "325591017", "story_v_out_325591.awb")

						arg_70_1:RecordAudio("325591017", var_73_43)
						arg_70_1:RecordAudio("325591017", var_73_43)
					else
						arg_70_1:AudioAction("play", "voice", "story_v_out_325591", "325591017", "story_v_out_325591.awb")
					end

					arg_70_1:RecordHistoryTalkVoice("story_v_out_325591", "325591017", "story_v_out_325591.awb")
				end

				arg_70_1:RecordContent(arg_70_1.text_.text)
			end

			local var_73_44 = math.max(var_73_35, arg_70_1.talkMaxDuration)

			if var_73_34 <= arg_70_1.time_ and arg_70_1.time_ < var_73_34 + var_73_44 then
				arg_70_1.typewritter.percent = (arg_70_1.time_ - var_73_34) / var_73_44

				arg_70_1.typewritter:SetDirty()
			end

			if arg_70_1.time_ >= var_73_34 + var_73_44 and arg_70_1.time_ < var_73_34 + var_73_44 + arg_73_0 then
				arg_70_1.typewritter.percent = 1

				arg_70_1.typewritter:SetDirty()
				arg_70_1:ShowNextGo(true)
			end
		end

		arg_70_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1054ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "6148ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_70_1:InitPlayNodeList()
	end,
	Play325591018 = function(arg_74_0, arg_74_1)
		arg_74_1.time_ = 0
		arg_74_1.frameCnt_ = 0
		arg_74_1.state_ = "playing"
		arg_74_1.curTalkId_ = 325591018
		arg_74_1.duration_ = 5

		SetActive(arg_74_1.tipsGo_, false)

		function arg_74_1.onSingleLineFinish_()
			arg_74_1.onSingleLineUpdate_ = nil
			arg_74_1.onSingleLineFinish_ = nil
			arg_74_1.state_ = "waiting"
		end

		function arg_74_1.playNext_(arg_76_0)
			if arg_76_0 == 1 then
				arg_74_0:Play325591019(arg_74_1)
			end
		end

		function arg_74_1.onSingleLineUpdate_(arg_77_0)
			local var_77_0 = arg_74_1.actors_["6148ui_story"].transform
			local var_77_1 = 0

			if var_77_1 < arg_74_1.time_ and arg_74_1.time_ <= var_77_1 + arg_77_0 then
				arg_74_1.var_.moveOldPos6148ui_story = var_77_0.localPosition

				local var_77_2 = GameObjectTools.GetOrAddComponent(var_77_0.gameObject, typeof(DynamicBoneHelper))

				if var_77_2 then
					var_77_2:EnableDynamicBone(false)
				end
			end

			local var_77_3 = 0.001

			if var_77_1 <= arg_74_1.time_ and arg_74_1.time_ < var_77_1 + var_77_3 then
				local var_77_4 = (arg_74_1.time_ - var_77_1) / var_77_3
				local var_77_5 = Vector3.New(0, 100, 0)

				var_77_0.localPosition = Vector3.Lerp(arg_74_1.var_.moveOldPos6148ui_story, var_77_5, var_77_4)

				local var_77_6 = manager.ui.mainCamera.transform.position - var_77_0.position

				var_77_0.forward = Vector3.New(var_77_6.x, var_77_6.y, var_77_6.z)

				local var_77_7 = var_77_0.localEulerAngles

				var_77_7.z = 0
				var_77_7.x = 0
				var_77_0.localEulerAngles = var_77_7
			end

			if arg_74_1.time_ >= var_77_1 + var_77_3 and arg_74_1.time_ < var_77_1 + var_77_3 + arg_77_0 then
				var_77_0.localPosition = Vector3.New(0, 100, 0)

				local var_77_8 = manager.ui.mainCamera.transform.position - var_77_0.position

				var_77_0.forward = Vector3.New(var_77_8.x, var_77_8.y, var_77_8.z)

				local var_77_9 = var_77_0.localEulerAngles

				var_77_9.z = 0
				var_77_9.x = 0
				var_77_0.localEulerAngles = var_77_9

				local var_77_10 = GameObjectTools.GetOrAddComponent(var_77_0.gameObject, typeof(DynamicBoneHelper))

				if var_77_10 then
					var_77_10:EnableDynamicBone(true)
				end
			end

			local var_77_11 = arg_74_1.actors_["1054ui_story"].transform
			local var_77_12 = 0

			if var_77_12 < arg_74_1.time_ and arg_74_1.time_ <= var_77_12 + arg_77_0 then
				arg_74_1.var_.moveOldPos1054ui_story = var_77_11.localPosition

				local var_77_13 = GameObjectTools.GetOrAddComponent(var_77_11.gameObject, typeof(DynamicBoneHelper))

				if var_77_13 then
					var_77_13:EnableDynamicBone(false)
				end
			end

			local var_77_14 = 0.001

			if var_77_12 <= arg_74_1.time_ and arg_74_1.time_ < var_77_12 + var_77_14 then
				local var_77_15 = (arg_74_1.time_ - var_77_12) / var_77_14
				local var_77_16 = Vector3.New(0, 100, 0)

				var_77_11.localPosition = Vector3.Lerp(arg_74_1.var_.moveOldPos1054ui_story, var_77_16, var_77_15)

				local var_77_17 = manager.ui.mainCamera.transform.position - var_77_11.position

				var_77_11.forward = Vector3.New(var_77_17.x, var_77_17.y, var_77_17.z)

				local var_77_18 = var_77_11.localEulerAngles

				var_77_18.z = 0
				var_77_18.x = 0
				var_77_11.localEulerAngles = var_77_18
			end

			if arg_74_1.time_ >= var_77_12 + var_77_14 and arg_74_1.time_ < var_77_12 + var_77_14 + arg_77_0 then
				var_77_11.localPosition = Vector3.New(0, 100, 0)

				local var_77_19 = manager.ui.mainCamera.transform.position - var_77_11.position

				var_77_11.forward = Vector3.New(var_77_19.x, var_77_19.y, var_77_19.z)

				local var_77_20 = var_77_11.localEulerAngles

				var_77_20.z = 0
				var_77_20.x = 0
				var_77_11.localEulerAngles = var_77_20

				local var_77_21 = GameObjectTools.GetOrAddComponent(var_77_11.gameObject, typeof(DynamicBoneHelper))

				if var_77_21 then
					var_77_21:EnableDynamicBone(true)
				end
			end

			local var_77_22 = arg_74_1.actors_["6148ui_story"]
			local var_77_23 = 0

			if var_77_23 < arg_74_1.time_ and arg_74_1.time_ <= var_77_23 + arg_77_0 and not isNil(var_77_22) and arg_74_1.var_.characterEffect6148ui_story == nil then
				arg_74_1.var_.characterEffect6148ui_story = var_77_22:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_77_24 = 0.200000002980232

			if var_77_23 <= arg_74_1.time_ and arg_74_1.time_ < var_77_23 + var_77_24 and not isNil(var_77_22) then
				local var_77_25 = (arg_74_1.time_ - var_77_23) / var_77_24

				if arg_74_1.var_.characterEffect6148ui_story and not isNil(var_77_22) then
					local var_77_26 = Mathf.Lerp(0, 0.5, var_77_25)

					arg_74_1.var_.characterEffect6148ui_story.fillFlat = true
					arg_74_1.var_.characterEffect6148ui_story.fillRatio = var_77_26
				end
			end

			if arg_74_1.time_ >= var_77_23 + var_77_24 and arg_74_1.time_ < var_77_23 + var_77_24 + arg_77_0 and not isNil(var_77_22) and arg_74_1.var_.characterEffect6148ui_story then
				local var_77_27 = 0.5

				arg_74_1.var_.characterEffect6148ui_story.fillFlat = true
				arg_74_1.var_.characterEffect6148ui_story.fillRatio = var_77_27
			end

			local var_77_28 = 0
			local var_77_29 = 1.325

			if var_77_28 < arg_74_1.time_ and arg_74_1.time_ <= var_77_28 + arg_77_0 then
				arg_74_1.talkMaxDuration = 0
				arg_74_1.dialogCg_.alpha = 1

				arg_74_1.dialog_:SetActive(true)
				SetActive(arg_74_1.leftNameGo_, false)

				arg_74_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_74_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_74_1:RecordName(arg_74_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_74_1.iconTrs_.gameObject, false)
				arg_74_1.callingController_:SetSelectedState("normal")

				local var_77_30 = arg_74_1:GetWordFromCfg(325591018)
				local var_77_31 = arg_74_1:FormatText(var_77_30.content)

				arg_74_1.text_.text = var_77_31

				LuaForUtil.ClearLinePrefixSymbol(arg_74_1.text_)

				local var_77_32 = 53
				local var_77_33 = utf8.len(var_77_31)
				local var_77_34 = var_77_32 <= 0 and var_77_29 or var_77_29 * (var_77_33 / var_77_32)

				if var_77_34 > 0 and var_77_29 < var_77_34 then
					arg_74_1.talkMaxDuration = var_77_34

					if var_77_34 + var_77_28 > arg_74_1.duration_ then
						arg_74_1.duration_ = var_77_34 + var_77_28
					end
				end

				arg_74_1.text_.text = var_77_31
				arg_74_1.typewritter.percent = 0

				arg_74_1.typewritter:SetDirty()
				arg_74_1:ShowNextGo(false)
				arg_74_1:RecordContent(arg_74_1.text_.text)
			end

			local var_77_35 = math.max(var_77_29, arg_74_1.talkMaxDuration)

			if var_77_28 <= arg_74_1.time_ and arg_74_1.time_ < var_77_28 + var_77_35 then
				arg_74_1.typewritter.percent = (arg_74_1.time_ - var_77_28) / var_77_35

				arg_74_1.typewritter:SetDirty()
			end

			if arg_74_1.time_ >= var_77_28 + var_77_35 and arg_74_1.time_ < var_77_28 + var_77_35 + arg_77_0 then
				arg_74_1.typewritter.percent = 1

				arg_74_1.typewritter:SetDirty()
				arg_74_1:ShowNextGo(true)
			end
		end

		arg_74_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "6148ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1054ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_74_1:InitPlayNodeList()
	end,
	Play325591019 = function(arg_78_0, arg_78_1)
		arg_78_1.time_ = 0
		arg_78_1.frameCnt_ = 0
		arg_78_1.state_ = "playing"
		arg_78_1.curTalkId_ = 325591019
		arg_78_1.duration_ = 5

		SetActive(arg_78_1.tipsGo_, false)

		function arg_78_1.onSingleLineFinish_()
			arg_78_1.onSingleLineUpdate_ = nil
			arg_78_1.onSingleLineFinish_ = nil
			arg_78_1.state_ = "waiting"
		end

		function arg_78_1.playNext_(arg_80_0)
			if arg_80_0 == 1 then
				arg_78_0:Play325591020(arg_78_1)
			end
		end

		function arg_78_1.onSingleLineUpdate_(arg_81_0)
			local var_81_0 = 0
			local var_81_1 = 0.95

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

				local var_81_2 = arg_78_1:GetWordFromCfg(325591019)
				local var_81_3 = arg_78_1:FormatText(var_81_2.content)

				arg_78_1.text_.text = var_81_3

				LuaForUtil.ClearLinePrefixSymbol(arg_78_1.text_)

				local var_81_4 = 38
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
	Play325591020 = function(arg_82_0, arg_82_1)
		arg_82_1.time_ = 0
		arg_82_1.frameCnt_ = 0
		arg_82_1.state_ = "playing"
		arg_82_1.curTalkId_ = 325591020
		arg_82_1.duration_ = 6.8

		local var_82_0 = {
			zh = 6.8,
			ja = 6
		}
		local var_82_1 = manager.audio:GetLocalizationFlag()

		if var_82_0[var_82_1] ~= nil then
			arg_82_1.duration_ = var_82_0[var_82_1]
		end

		SetActive(arg_82_1.tipsGo_, false)

		function arg_82_1.onSingleLineFinish_()
			arg_82_1.onSingleLineUpdate_ = nil
			arg_82_1.onSingleLineFinish_ = nil
			arg_82_1.state_ = "waiting"
		end

		function arg_82_1.playNext_(arg_84_0)
			if arg_84_0 == 1 then
				arg_82_0:Play325591021(arg_82_1)
			end
		end

		function arg_82_1.onSingleLineUpdate_(arg_85_0)
			local var_85_0 = arg_82_1.actors_["1054ui_story"].transform
			local var_85_1 = 0

			if var_85_1 < arg_82_1.time_ and arg_82_1.time_ <= var_85_1 + arg_85_0 then
				arg_82_1.var_.moveOldPos1054ui_story = var_85_0.localPosition

				local var_85_2 = GameObjectTools.GetOrAddComponent(var_85_0.gameObject, typeof(DynamicBoneHelper))

				if var_85_2 then
					var_85_2:EnableDynamicBone(false)
				end
			end

			local var_85_3 = 0.001

			if var_85_1 <= arg_82_1.time_ and arg_82_1.time_ < var_85_1 + var_85_3 then
				local var_85_4 = (arg_82_1.time_ - var_85_1) / var_85_3
				local var_85_5 = Vector3.New(0, -0.985, -6)

				var_85_0.localPosition = Vector3.Lerp(arg_82_1.var_.moveOldPos1054ui_story, var_85_5, var_85_4)

				local var_85_6 = manager.ui.mainCamera.transform.position - var_85_0.position

				var_85_0.forward = Vector3.New(var_85_6.x, var_85_6.y, var_85_6.z)

				local var_85_7 = var_85_0.localEulerAngles

				var_85_7.z = 0
				var_85_7.x = 0
				var_85_0.localEulerAngles = var_85_7
			end

			if arg_82_1.time_ >= var_85_1 + var_85_3 and arg_82_1.time_ < var_85_1 + var_85_3 + arg_85_0 then
				var_85_0.localPosition = Vector3.New(0, -0.985, -6)

				local var_85_8 = manager.ui.mainCamera.transform.position - var_85_0.position

				var_85_0.forward = Vector3.New(var_85_8.x, var_85_8.y, var_85_8.z)

				local var_85_9 = var_85_0.localEulerAngles

				var_85_9.z = 0
				var_85_9.x = 0
				var_85_0.localEulerAngles = var_85_9

				local var_85_10 = GameObjectTools.GetOrAddComponent(var_85_0.gameObject, typeof(DynamicBoneHelper))

				if var_85_10 then
					var_85_10:EnableDynamicBone(true)
				end
			end

			local var_85_11 = arg_82_1.actors_["1054ui_story"]
			local var_85_12 = 0

			if var_85_12 < arg_82_1.time_ and arg_82_1.time_ <= var_85_12 + arg_85_0 and not isNil(var_85_11) and arg_82_1.var_.characterEffect1054ui_story == nil then
				arg_82_1.var_.characterEffect1054ui_story = var_85_11:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_85_13 = 0.200000002980232

			if var_85_12 <= arg_82_1.time_ and arg_82_1.time_ < var_85_12 + var_85_13 and not isNil(var_85_11) then
				local var_85_14 = (arg_82_1.time_ - var_85_12) / var_85_13

				if arg_82_1.var_.characterEffect1054ui_story and not isNil(var_85_11) then
					arg_82_1.var_.characterEffect1054ui_story.fillFlat = false
				end
			end

			if arg_82_1.time_ >= var_85_12 + var_85_13 and arg_82_1.time_ < var_85_12 + var_85_13 + arg_85_0 and not isNil(var_85_11) and arg_82_1.var_.characterEffect1054ui_story then
				arg_82_1.var_.characterEffect1054ui_story.fillFlat = false
			end

			local var_85_15 = 0

			if var_85_15 < arg_82_1.time_ and arg_82_1.time_ <= var_85_15 + arg_85_0 then
				arg_82_1:PlayTimeline("1054ui_story", "StoryTimeline/CharAction/story1054/story1054action/1054action4_1")
			end

			local var_85_16 = 0

			if var_85_16 < arg_82_1.time_ and arg_82_1.time_ <= var_85_16 + arg_85_0 then
				arg_82_1:PlayTimeline("1054ui_story", "StoryTimeline/CharAction/public_expression/expr_youyu", "EmotionTimelineAnimator")
			end

			local var_85_17 = 0
			local var_85_18 = 0.5

			if var_85_17 < arg_82_1.time_ and arg_82_1.time_ <= var_85_17 + arg_85_0 then
				arg_82_1.talkMaxDuration = 0
				arg_82_1.dialogCg_.alpha = 1

				arg_82_1.dialog_:SetActive(true)
				SetActive(arg_82_1.leftNameGo_, true)

				local var_85_19 = arg_82_1:FormatText(StoryNameCfg[1487].name)

				arg_82_1.leftNameTxt_.text = var_85_19

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_82_1.leftNameTxt_.transform)

				arg_82_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_82_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_82_1:RecordName(arg_82_1.leftNameTxt_.text)
				SetActive(arg_82_1.iconTrs_.gameObject, false)
				arg_82_1.callingController_:SetSelectedState("normal")

				local var_85_20 = arg_82_1:GetWordFromCfg(325591020)
				local var_85_21 = arg_82_1:FormatText(var_85_20.content)

				arg_82_1.text_.text = var_85_21

				LuaForUtil.ClearLinePrefixSymbol(arg_82_1.text_)

				local var_85_22 = 20
				local var_85_23 = utf8.len(var_85_21)
				local var_85_24 = var_85_22 <= 0 and var_85_18 or var_85_18 * (var_85_23 / var_85_22)

				if var_85_24 > 0 and var_85_18 < var_85_24 then
					arg_82_1.talkMaxDuration = var_85_24

					if var_85_24 + var_85_17 > arg_82_1.duration_ then
						arg_82_1.duration_ = var_85_24 + var_85_17
					end
				end

				arg_82_1.text_.text = var_85_21
				arg_82_1.typewritter.percent = 0

				arg_82_1.typewritter:SetDirty()
				arg_82_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_325591", "325591020", "story_v_out_325591.awb") ~= 0 then
					local var_85_25 = manager.audio:GetVoiceLength("story_v_out_325591", "325591020", "story_v_out_325591.awb") / 1000

					if var_85_25 + var_85_17 > arg_82_1.duration_ then
						arg_82_1.duration_ = var_85_25 + var_85_17
					end

					if var_85_20.prefab_name ~= "" and arg_82_1.actors_[var_85_20.prefab_name] ~= nil then
						local var_85_26 = LuaForUtil.PlayVoiceWithCriLipsync(arg_82_1.actors_[var_85_20.prefab_name].transform, "story_v_out_325591", "325591020", "story_v_out_325591.awb")

						arg_82_1:RecordAudio("325591020", var_85_26)
						arg_82_1:RecordAudio("325591020", var_85_26)
					else
						arg_82_1:AudioAction("play", "voice", "story_v_out_325591", "325591020", "story_v_out_325591.awb")
					end

					arg_82_1:RecordHistoryTalkVoice("story_v_out_325591", "325591020", "story_v_out_325591.awb")
				end

				arg_82_1:RecordContent(arg_82_1.text_.text)
			end

			local var_85_27 = math.max(var_85_18, arg_82_1.talkMaxDuration)

			if var_85_17 <= arg_82_1.time_ and arg_82_1.time_ < var_85_17 + var_85_27 then
				arg_82_1.typewritter.percent = (arg_82_1.time_ - var_85_17) / var_85_27

				arg_82_1.typewritter:SetDirty()
			end

			if arg_82_1.time_ >= var_85_17 + var_85_27 and arg_82_1.time_ < var_85_17 + var_85_27 + arg_85_0 then
				arg_82_1.typewritter.percent = 1

				arg_82_1.typewritter:SetDirty()
				arg_82_1:ShowNextGo(true)
			end
		end

		arg_82_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1054ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_82_1:InitPlayNodeList()
	end,
	Play325591021 = function(arg_86_0, arg_86_1)
		arg_86_1.time_ = 0
		arg_86_1.frameCnt_ = 0
		arg_86_1.state_ = "playing"
		arg_86_1.curTalkId_ = 325591021
		arg_86_1.duration_ = 9.63

		local var_86_0 = {
			zh = 5.6,
			ja = 9.633
		}
		local var_86_1 = manager.audio:GetLocalizationFlag()

		if var_86_0[var_86_1] ~= nil then
			arg_86_1.duration_ = var_86_0[var_86_1]
		end

		SetActive(arg_86_1.tipsGo_, false)

		function arg_86_1.onSingleLineFinish_()
			arg_86_1.onSingleLineUpdate_ = nil
			arg_86_1.onSingleLineFinish_ = nil
			arg_86_1.state_ = "waiting"
		end

		function arg_86_1.playNext_(arg_88_0)
			if arg_88_0 == 1 then
				arg_86_0:Play325591022(arg_86_1)
			end
		end

		function arg_86_1.onSingleLineUpdate_(arg_89_0)
			local var_89_0 = arg_86_1.actors_["1054ui_story"].transform
			local var_89_1 = 0

			if var_89_1 < arg_86_1.time_ and arg_86_1.time_ <= var_89_1 + arg_89_0 then
				arg_86_1.var_.moveOldPos1054ui_story = var_89_0.localPosition

				local var_89_2 = GameObjectTools.GetOrAddComponent(var_89_0.gameObject, typeof(DynamicBoneHelper))

				if var_89_2 then
					var_89_2:EnableDynamicBone(false)
				end
			end

			local var_89_3 = 0.001

			if var_89_1 <= arg_86_1.time_ and arg_86_1.time_ < var_89_1 + var_89_3 then
				local var_89_4 = (arg_86_1.time_ - var_89_1) / var_89_3
				local var_89_5 = Vector3.New(-0.7, -0.985, -6)

				var_89_0.localPosition = Vector3.Lerp(arg_86_1.var_.moveOldPos1054ui_story, var_89_5, var_89_4)

				local var_89_6 = manager.ui.mainCamera.transform.position - var_89_0.position

				var_89_0.forward = Vector3.New(var_89_6.x, var_89_6.y, var_89_6.z)

				local var_89_7 = var_89_0.localEulerAngles

				var_89_7.z = 0
				var_89_7.x = 0
				var_89_0.localEulerAngles = var_89_7
			end

			if arg_86_1.time_ >= var_89_1 + var_89_3 and arg_86_1.time_ < var_89_1 + var_89_3 + arg_89_0 then
				var_89_0.localPosition = Vector3.New(-0.7, -0.985, -6)

				local var_89_8 = manager.ui.mainCamera.transform.position - var_89_0.position

				var_89_0.forward = Vector3.New(var_89_8.x, var_89_8.y, var_89_8.z)

				local var_89_9 = var_89_0.localEulerAngles

				var_89_9.z = 0
				var_89_9.x = 0
				var_89_0.localEulerAngles = var_89_9

				local var_89_10 = GameObjectTools.GetOrAddComponent(var_89_0.gameObject, typeof(DynamicBoneHelper))

				if var_89_10 then
					var_89_10:EnableDynamicBone(true)
				end
			end

			local var_89_11 = arg_86_1.actors_["6148ui_story"].transform
			local var_89_12 = 0

			if var_89_12 < arg_86_1.time_ and arg_86_1.time_ <= var_89_12 + arg_89_0 then
				arg_86_1.var_.moveOldPos6148ui_story = var_89_11.localPosition

				local var_89_13 = GameObjectTools.GetOrAddComponent(var_89_11.gameObject, typeof(DynamicBoneHelper))

				if var_89_13 then
					var_89_13:EnableDynamicBone(false)
				end
			end

			local var_89_14 = 0.001

			if var_89_12 <= arg_86_1.time_ and arg_86_1.time_ < var_89_12 + var_89_14 then
				local var_89_15 = (arg_86_1.time_ - var_89_12) / var_89_14
				local var_89_16 = Vector3.New(0.7, -0.985, -6)

				var_89_11.localPosition = Vector3.Lerp(arg_86_1.var_.moveOldPos6148ui_story, var_89_16, var_89_15)

				local var_89_17 = manager.ui.mainCamera.transform.position - var_89_11.position

				var_89_11.forward = Vector3.New(var_89_17.x, var_89_17.y, var_89_17.z)

				local var_89_18 = var_89_11.localEulerAngles

				var_89_18.z = 0
				var_89_18.x = 0
				var_89_11.localEulerAngles = var_89_18
			end

			if arg_86_1.time_ >= var_89_12 + var_89_14 and arg_86_1.time_ < var_89_12 + var_89_14 + arg_89_0 then
				var_89_11.localPosition = Vector3.New(0.7, -0.985, -6)

				local var_89_19 = manager.ui.mainCamera.transform.position - var_89_11.position

				var_89_11.forward = Vector3.New(var_89_19.x, var_89_19.y, var_89_19.z)

				local var_89_20 = var_89_11.localEulerAngles

				var_89_20.z = 0
				var_89_20.x = 0
				var_89_11.localEulerAngles = var_89_20

				local var_89_21 = GameObjectTools.GetOrAddComponent(var_89_11.gameObject, typeof(DynamicBoneHelper))

				if var_89_21 then
					var_89_21:EnableDynamicBone(true)
				end
			end

			local var_89_22 = arg_86_1.actors_["6148ui_story"]
			local var_89_23 = 0

			if var_89_23 < arg_86_1.time_ and arg_86_1.time_ <= var_89_23 + arg_89_0 and not isNil(var_89_22) and arg_86_1.var_.characterEffect6148ui_story == nil then
				arg_86_1.var_.characterEffect6148ui_story = var_89_22:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_89_24 = 0.200000002980232

			if var_89_23 <= arg_86_1.time_ and arg_86_1.time_ < var_89_23 + var_89_24 and not isNil(var_89_22) then
				local var_89_25 = (arg_86_1.time_ - var_89_23) / var_89_24

				if arg_86_1.var_.characterEffect6148ui_story and not isNil(var_89_22) then
					arg_86_1.var_.characterEffect6148ui_story.fillFlat = false
				end
			end

			if arg_86_1.time_ >= var_89_23 + var_89_24 and arg_86_1.time_ < var_89_23 + var_89_24 + arg_89_0 and not isNil(var_89_22) and arg_86_1.var_.characterEffect6148ui_story then
				arg_86_1.var_.characterEffect6148ui_story.fillFlat = false
			end

			local var_89_26 = arg_86_1.actors_["1054ui_story"]
			local var_89_27 = 0

			if var_89_27 < arg_86_1.time_ and arg_86_1.time_ <= var_89_27 + arg_89_0 and not isNil(var_89_26) and arg_86_1.var_.characterEffect1054ui_story == nil then
				arg_86_1.var_.characterEffect1054ui_story = var_89_26:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_89_28 = 0.200000002980232

			if var_89_27 <= arg_86_1.time_ and arg_86_1.time_ < var_89_27 + var_89_28 and not isNil(var_89_26) then
				local var_89_29 = (arg_86_1.time_ - var_89_27) / var_89_28

				if arg_86_1.var_.characterEffect1054ui_story and not isNil(var_89_26) then
					local var_89_30 = Mathf.Lerp(0, 0.5, var_89_29)

					arg_86_1.var_.characterEffect1054ui_story.fillFlat = true
					arg_86_1.var_.characterEffect1054ui_story.fillRatio = var_89_30
				end
			end

			if arg_86_1.time_ >= var_89_27 + var_89_28 and arg_86_1.time_ < var_89_27 + var_89_28 + arg_89_0 and not isNil(var_89_26) and arg_86_1.var_.characterEffect1054ui_story then
				local var_89_31 = 0.5

				arg_86_1.var_.characterEffect1054ui_story.fillFlat = true
				arg_86_1.var_.characterEffect1054ui_story.fillRatio = var_89_31
			end

			local var_89_32 = 0
			local var_89_33 = 0.675

			if var_89_32 < arg_86_1.time_ and arg_86_1.time_ <= var_89_32 + arg_89_0 then
				arg_86_1.talkMaxDuration = 0
				arg_86_1.dialogCg_.alpha = 1

				arg_86_1.dialog_:SetActive(true)
				SetActive(arg_86_1.leftNameGo_, true)

				local var_89_34 = arg_86_1:FormatText(StoryNameCfg[1488].name)

				arg_86_1.leftNameTxt_.text = var_89_34

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_86_1.leftNameTxt_.transform)

				arg_86_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_86_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_86_1:RecordName(arg_86_1.leftNameTxt_.text)
				SetActive(arg_86_1.iconTrs_.gameObject, false)
				arg_86_1.callingController_:SetSelectedState("normal")

				local var_89_35 = arg_86_1:GetWordFromCfg(325591021)
				local var_89_36 = arg_86_1:FormatText(var_89_35.content)

				arg_86_1.text_.text = var_89_36

				LuaForUtil.ClearLinePrefixSymbol(arg_86_1.text_)

				local var_89_37 = 27
				local var_89_38 = utf8.len(var_89_36)
				local var_89_39 = var_89_37 <= 0 and var_89_33 or var_89_33 * (var_89_38 / var_89_37)

				if var_89_39 > 0 and var_89_33 < var_89_39 then
					arg_86_1.talkMaxDuration = var_89_39

					if var_89_39 + var_89_32 > arg_86_1.duration_ then
						arg_86_1.duration_ = var_89_39 + var_89_32
					end
				end

				arg_86_1.text_.text = var_89_36
				arg_86_1.typewritter.percent = 0

				arg_86_1.typewritter:SetDirty()
				arg_86_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_325591", "325591021", "story_v_out_325591.awb") ~= 0 then
					local var_89_40 = manager.audio:GetVoiceLength("story_v_out_325591", "325591021", "story_v_out_325591.awb") / 1000

					if var_89_40 + var_89_32 > arg_86_1.duration_ then
						arg_86_1.duration_ = var_89_40 + var_89_32
					end

					if var_89_35.prefab_name ~= "" and arg_86_1.actors_[var_89_35.prefab_name] ~= nil then
						local var_89_41 = LuaForUtil.PlayVoiceWithCriLipsync(arg_86_1.actors_[var_89_35.prefab_name].transform, "story_v_out_325591", "325591021", "story_v_out_325591.awb")

						arg_86_1:RecordAudio("325591021", var_89_41)
						arg_86_1:RecordAudio("325591021", var_89_41)
					else
						arg_86_1:AudioAction("play", "voice", "story_v_out_325591", "325591021", "story_v_out_325591.awb")
					end

					arg_86_1:RecordHistoryTalkVoice("story_v_out_325591", "325591021", "story_v_out_325591.awb")
				end

				arg_86_1:RecordContent(arg_86_1.text_.text)
			end

			local var_89_42 = math.max(var_89_33, arg_86_1.talkMaxDuration)

			if var_89_32 <= arg_86_1.time_ and arg_86_1.time_ < var_89_32 + var_89_42 then
				arg_86_1.typewritter.percent = (arg_86_1.time_ - var_89_32) / var_89_42

				arg_86_1.typewritter:SetDirty()
			end

			if arg_86_1.time_ >= var_89_32 + var_89_42 and arg_86_1.time_ < var_89_32 + var_89_42 + arg_89_0 then
				arg_86_1.typewritter.percent = 1

				arg_86_1.typewritter:SetDirty()
				arg_86_1:ShowNextGo(true)
			end
		end

		arg_86_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1054ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "6148ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_86_1:InitPlayNodeList()
	end,
	Play325591022 = function(arg_90_0, arg_90_1)
		arg_90_1.time_ = 0
		arg_90_1.frameCnt_ = 0
		arg_90_1.state_ = "playing"
		arg_90_1.curTalkId_ = 325591022
		arg_90_1.duration_ = 8.7

		local var_90_0 = {
			zh = 8.7,
			ja = 8.066
		}
		local var_90_1 = manager.audio:GetLocalizationFlag()

		if var_90_0[var_90_1] ~= nil then
			arg_90_1.duration_ = var_90_0[var_90_1]
		end

		SetActive(arg_90_1.tipsGo_, false)

		function arg_90_1.onSingleLineFinish_()
			arg_90_1.onSingleLineUpdate_ = nil
			arg_90_1.onSingleLineFinish_ = nil
			arg_90_1.state_ = "waiting"
		end

		function arg_90_1.playNext_(arg_92_0)
			if arg_92_0 == 1 then
				arg_90_0:Play325591023(arg_90_1)
			end
		end

		function arg_90_1.onSingleLineUpdate_(arg_93_0)
			local var_93_0 = 0

			if var_93_0 < arg_90_1.time_ and arg_90_1.time_ <= var_93_0 + arg_93_0 then
				arg_90_1:PlayTimeline("6148ui_story", "StoryTimeline/CharAction/story6148/story6148actionlink/6148action445")
			end

			local var_93_1 = 0
			local var_93_2 = 1.025

			if var_93_1 < arg_90_1.time_ and arg_90_1.time_ <= var_93_1 + arg_93_0 then
				arg_90_1.talkMaxDuration = 0
				arg_90_1.dialogCg_.alpha = 1

				arg_90_1.dialog_:SetActive(true)
				SetActive(arg_90_1.leftNameGo_, true)

				local var_93_3 = arg_90_1:FormatText(StoryNameCfg[1488].name)

				arg_90_1.leftNameTxt_.text = var_93_3

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_90_1.leftNameTxt_.transform)

				arg_90_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_90_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_90_1:RecordName(arg_90_1.leftNameTxt_.text)
				SetActive(arg_90_1.iconTrs_.gameObject, false)
				arg_90_1.callingController_:SetSelectedState("normal")

				local var_93_4 = arg_90_1:GetWordFromCfg(325591022)
				local var_93_5 = arg_90_1:FormatText(var_93_4.content)

				arg_90_1.text_.text = var_93_5

				LuaForUtil.ClearLinePrefixSymbol(arg_90_1.text_)

				local var_93_6 = 41
				local var_93_7 = utf8.len(var_93_5)
				local var_93_8 = var_93_6 <= 0 and var_93_2 or var_93_2 * (var_93_7 / var_93_6)

				if var_93_8 > 0 and var_93_2 < var_93_8 then
					arg_90_1.talkMaxDuration = var_93_8

					if var_93_8 + var_93_1 > arg_90_1.duration_ then
						arg_90_1.duration_ = var_93_8 + var_93_1
					end
				end

				arg_90_1.text_.text = var_93_5
				arg_90_1.typewritter.percent = 0

				arg_90_1.typewritter:SetDirty()
				arg_90_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_325591", "325591022", "story_v_out_325591.awb") ~= 0 then
					local var_93_9 = manager.audio:GetVoiceLength("story_v_out_325591", "325591022", "story_v_out_325591.awb") / 1000

					if var_93_9 + var_93_1 > arg_90_1.duration_ then
						arg_90_1.duration_ = var_93_9 + var_93_1
					end

					if var_93_4.prefab_name ~= "" and arg_90_1.actors_[var_93_4.prefab_name] ~= nil then
						local var_93_10 = LuaForUtil.PlayVoiceWithCriLipsync(arg_90_1.actors_[var_93_4.prefab_name].transform, "story_v_out_325591", "325591022", "story_v_out_325591.awb")

						arg_90_1:RecordAudio("325591022", var_93_10)
						arg_90_1:RecordAudio("325591022", var_93_10)
					else
						arg_90_1:AudioAction("play", "voice", "story_v_out_325591", "325591022", "story_v_out_325591.awb")
					end

					arg_90_1:RecordHistoryTalkVoice("story_v_out_325591", "325591022", "story_v_out_325591.awb")
				end

				arg_90_1:RecordContent(arg_90_1.text_.text)
			end

			local var_93_11 = math.max(var_93_2, arg_90_1.talkMaxDuration)

			if var_93_1 <= arg_90_1.time_ and arg_90_1.time_ < var_93_1 + var_93_11 then
				arg_90_1.typewritter.percent = (arg_90_1.time_ - var_93_1) / var_93_11

				arg_90_1.typewritter:SetDirty()
			end

			if arg_90_1.time_ >= var_93_1 + var_93_11 and arg_90_1.time_ < var_93_1 + var_93_11 + arg_93_0 then
				arg_90_1.typewritter.percent = 1

				arg_90_1.typewritter:SetDirty()
				arg_90_1:ShowNextGo(true)
			end
		end

		arg_90_1.nodeConfigList_ = {}

		arg_90_1:InitPlayNodeList()
	end,
	Play325591023 = function(arg_94_0, arg_94_1)
		arg_94_1.time_ = 0
		arg_94_1.frameCnt_ = 0
		arg_94_1.state_ = "playing"
		arg_94_1.curTalkId_ = 325591023
		arg_94_1.duration_ = 9.73

		local var_94_0 = {
			zh = 6.3,
			ja = 9.733
		}
		local var_94_1 = manager.audio:GetLocalizationFlag()

		if var_94_0[var_94_1] ~= nil then
			arg_94_1.duration_ = var_94_0[var_94_1]
		end

		SetActive(arg_94_1.tipsGo_, false)

		function arg_94_1.onSingleLineFinish_()
			arg_94_1.onSingleLineUpdate_ = nil
			arg_94_1.onSingleLineFinish_ = nil
			arg_94_1.state_ = "waiting"
		end

		function arg_94_1.playNext_(arg_96_0)
			if arg_96_0 == 1 then
				arg_94_0:Play325591024(arg_94_1)
			end
		end

		function arg_94_1.onSingleLineUpdate_(arg_97_0)
			local var_97_0 = arg_94_1.actors_["1054ui_story"]
			local var_97_1 = 0

			if var_97_1 < arg_94_1.time_ and arg_94_1.time_ <= var_97_1 + arg_97_0 and not isNil(var_97_0) and arg_94_1.var_.characterEffect1054ui_story == nil then
				arg_94_1.var_.characterEffect1054ui_story = var_97_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_97_2 = 0.200000002980232

			if var_97_1 <= arg_94_1.time_ and arg_94_1.time_ < var_97_1 + var_97_2 and not isNil(var_97_0) then
				local var_97_3 = (arg_94_1.time_ - var_97_1) / var_97_2

				if arg_94_1.var_.characterEffect1054ui_story and not isNil(var_97_0) then
					arg_94_1.var_.characterEffect1054ui_story.fillFlat = false
				end
			end

			if arg_94_1.time_ >= var_97_1 + var_97_2 and arg_94_1.time_ < var_97_1 + var_97_2 + arg_97_0 and not isNil(var_97_0) and arg_94_1.var_.characterEffect1054ui_story then
				arg_94_1.var_.characterEffect1054ui_story.fillFlat = false
			end

			local var_97_4 = arg_94_1.actors_["6148ui_story"]
			local var_97_5 = 0

			if var_97_5 < arg_94_1.time_ and arg_94_1.time_ <= var_97_5 + arg_97_0 and not isNil(var_97_4) and arg_94_1.var_.characterEffect6148ui_story == nil then
				arg_94_1.var_.characterEffect6148ui_story = var_97_4:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_97_6 = 0.200000002980232

			if var_97_5 <= arg_94_1.time_ and arg_94_1.time_ < var_97_5 + var_97_6 and not isNil(var_97_4) then
				local var_97_7 = (arg_94_1.time_ - var_97_5) / var_97_6

				if arg_94_1.var_.characterEffect6148ui_story and not isNil(var_97_4) then
					local var_97_8 = Mathf.Lerp(0, 0.5, var_97_7)

					arg_94_1.var_.characterEffect6148ui_story.fillFlat = true
					arg_94_1.var_.characterEffect6148ui_story.fillRatio = var_97_8
				end
			end

			if arg_94_1.time_ >= var_97_5 + var_97_6 and arg_94_1.time_ < var_97_5 + var_97_6 + arg_97_0 and not isNil(var_97_4) and arg_94_1.var_.characterEffect6148ui_story then
				local var_97_9 = 0.5

				arg_94_1.var_.characterEffect6148ui_story.fillFlat = true
				arg_94_1.var_.characterEffect6148ui_story.fillRatio = var_97_9
			end

			local var_97_10 = 0

			if var_97_10 < arg_94_1.time_ and arg_94_1.time_ <= var_97_10 + arg_97_0 then
				arg_94_1:PlayTimeline("1054ui_story", "StoryTimeline/CharAction/story1054/story1054action/1054action4_2")
			end

			local var_97_11 = 0

			if var_97_11 < arg_94_1.time_ and arg_94_1.time_ <= var_97_11 + arg_97_0 then
				arg_94_1:PlayTimeline("1054ui_story", "StoryTimeline/CharAction/public_expression/expr_youyu", "EmotionTimelineAnimator")
			end

			local var_97_12 = 0
			local var_97_13 = 0.6

			if var_97_12 < arg_94_1.time_ and arg_94_1.time_ <= var_97_12 + arg_97_0 then
				arg_94_1.talkMaxDuration = 0
				arg_94_1.dialogCg_.alpha = 1

				arg_94_1.dialog_:SetActive(true)
				SetActive(arg_94_1.leftNameGo_, true)

				local var_97_14 = arg_94_1:FormatText(StoryNameCfg[1487].name)

				arg_94_1.leftNameTxt_.text = var_97_14

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_94_1.leftNameTxt_.transform)

				arg_94_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_94_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_94_1:RecordName(arg_94_1.leftNameTxt_.text)
				SetActive(arg_94_1.iconTrs_.gameObject, false)
				arg_94_1.callingController_:SetSelectedState("normal")

				local var_97_15 = arg_94_1:GetWordFromCfg(325591023)
				local var_97_16 = arg_94_1:FormatText(var_97_15.content)

				arg_94_1.text_.text = var_97_16

				LuaForUtil.ClearLinePrefixSymbol(arg_94_1.text_)

				local var_97_17 = 24
				local var_97_18 = utf8.len(var_97_16)
				local var_97_19 = var_97_17 <= 0 and var_97_13 or var_97_13 * (var_97_18 / var_97_17)

				if var_97_19 > 0 and var_97_13 < var_97_19 then
					arg_94_1.talkMaxDuration = var_97_19

					if var_97_19 + var_97_12 > arg_94_1.duration_ then
						arg_94_1.duration_ = var_97_19 + var_97_12
					end
				end

				arg_94_1.text_.text = var_97_16
				arg_94_1.typewritter.percent = 0

				arg_94_1.typewritter:SetDirty()
				arg_94_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_325591", "325591023", "story_v_out_325591.awb") ~= 0 then
					local var_97_20 = manager.audio:GetVoiceLength("story_v_out_325591", "325591023", "story_v_out_325591.awb") / 1000

					if var_97_20 + var_97_12 > arg_94_1.duration_ then
						arg_94_1.duration_ = var_97_20 + var_97_12
					end

					if var_97_15.prefab_name ~= "" and arg_94_1.actors_[var_97_15.prefab_name] ~= nil then
						local var_97_21 = LuaForUtil.PlayVoiceWithCriLipsync(arg_94_1.actors_[var_97_15.prefab_name].transform, "story_v_out_325591", "325591023", "story_v_out_325591.awb")

						arg_94_1:RecordAudio("325591023", var_97_21)
						arg_94_1:RecordAudio("325591023", var_97_21)
					else
						arg_94_1:AudioAction("play", "voice", "story_v_out_325591", "325591023", "story_v_out_325591.awb")
					end

					arg_94_1:RecordHistoryTalkVoice("story_v_out_325591", "325591023", "story_v_out_325591.awb")
				end

				arg_94_1:RecordContent(arg_94_1.text_.text)
			end

			local var_97_22 = math.max(var_97_13, arg_94_1.talkMaxDuration)

			if var_97_12 <= arg_94_1.time_ and arg_94_1.time_ < var_97_12 + var_97_22 then
				arg_94_1.typewritter.percent = (arg_94_1.time_ - var_97_12) / var_97_22

				arg_94_1.typewritter:SetDirty()
			end

			if arg_94_1.time_ >= var_97_12 + var_97_22 and arg_94_1.time_ < var_97_12 + var_97_22 + arg_97_0 then
				arg_94_1.typewritter.percent = 1

				arg_94_1.typewritter:SetDirty()
				arg_94_1:ShowNextGo(true)
			end
		end

		arg_94_1.nodeConfigList_ = {}

		arg_94_1:InitPlayNodeList()
	end,
	Play325591024 = function(arg_98_0, arg_98_1)
		arg_98_1.time_ = 0
		arg_98_1.frameCnt_ = 0
		arg_98_1.state_ = "playing"
		arg_98_1.curTalkId_ = 325591024
		arg_98_1.duration_ = 7

		local var_98_0 = {
			zh = 6.166,
			ja = 7
		}
		local var_98_1 = manager.audio:GetLocalizationFlag()

		if var_98_0[var_98_1] ~= nil then
			arg_98_1.duration_ = var_98_0[var_98_1]
		end

		SetActive(arg_98_1.tipsGo_, false)

		function arg_98_1.onSingleLineFinish_()
			arg_98_1.onSingleLineUpdate_ = nil
			arg_98_1.onSingleLineFinish_ = nil
			arg_98_1.state_ = "waiting"
		end

		function arg_98_1.playNext_(arg_100_0)
			if arg_100_0 == 1 then
				arg_98_0:Play325591025(arg_98_1)
			end
		end

		function arg_98_1.onSingleLineUpdate_(arg_101_0)
			local var_101_0 = arg_98_1.actors_["6148ui_story"]
			local var_101_1 = 0

			if var_101_1 < arg_98_1.time_ and arg_98_1.time_ <= var_101_1 + arg_101_0 and not isNil(var_101_0) and arg_98_1.var_.characterEffect6148ui_story == nil then
				arg_98_1.var_.characterEffect6148ui_story = var_101_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_101_2 = 0.200000002980232

			if var_101_1 <= arg_98_1.time_ and arg_98_1.time_ < var_101_1 + var_101_2 and not isNil(var_101_0) then
				local var_101_3 = (arg_98_1.time_ - var_101_1) / var_101_2

				if arg_98_1.var_.characterEffect6148ui_story and not isNil(var_101_0) then
					arg_98_1.var_.characterEffect6148ui_story.fillFlat = false
				end
			end

			if arg_98_1.time_ >= var_101_1 + var_101_2 and arg_98_1.time_ < var_101_1 + var_101_2 + arg_101_0 and not isNil(var_101_0) and arg_98_1.var_.characterEffect6148ui_story then
				arg_98_1.var_.characterEffect6148ui_story.fillFlat = false
			end

			local var_101_4 = arg_98_1.actors_["1054ui_story"]
			local var_101_5 = 0

			if var_101_5 < arg_98_1.time_ and arg_98_1.time_ <= var_101_5 + arg_101_0 and not isNil(var_101_4) and arg_98_1.var_.characterEffect1054ui_story == nil then
				arg_98_1.var_.characterEffect1054ui_story = var_101_4:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_101_6 = 0.200000002980232

			if var_101_5 <= arg_98_1.time_ and arg_98_1.time_ < var_101_5 + var_101_6 and not isNil(var_101_4) then
				local var_101_7 = (arg_98_1.time_ - var_101_5) / var_101_6

				if arg_98_1.var_.characterEffect1054ui_story and not isNil(var_101_4) then
					local var_101_8 = Mathf.Lerp(0, 0.5, var_101_7)

					arg_98_1.var_.characterEffect1054ui_story.fillFlat = true
					arg_98_1.var_.characterEffect1054ui_story.fillRatio = var_101_8
				end
			end

			if arg_98_1.time_ >= var_101_5 + var_101_6 and arg_98_1.time_ < var_101_5 + var_101_6 + arg_101_0 and not isNil(var_101_4) and arg_98_1.var_.characterEffect1054ui_story then
				local var_101_9 = 0.5

				arg_98_1.var_.characterEffect1054ui_story.fillFlat = true
				arg_98_1.var_.characterEffect1054ui_story.fillRatio = var_101_9
			end

			local var_101_10 = 0

			if var_101_10 < arg_98_1.time_ and arg_98_1.time_ <= var_101_10 + arg_101_0 then
				arg_98_1:PlayTimeline("6148ui_story", "StoryTimeline/CharAction/story6148/story6148action/6148action5_2")
			end

			local var_101_11 = 0
			local var_101_12 = 0.675

			if var_101_11 < arg_98_1.time_ and arg_98_1.time_ <= var_101_11 + arg_101_0 then
				arg_98_1.talkMaxDuration = 0
				arg_98_1.dialogCg_.alpha = 1

				arg_98_1.dialog_:SetActive(true)
				SetActive(arg_98_1.leftNameGo_, true)

				local var_101_13 = arg_98_1:FormatText(StoryNameCfg[1488].name)

				arg_98_1.leftNameTxt_.text = var_101_13

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_98_1.leftNameTxt_.transform)

				arg_98_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_98_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_98_1:RecordName(arg_98_1.leftNameTxt_.text)
				SetActive(arg_98_1.iconTrs_.gameObject, false)
				arg_98_1.callingController_:SetSelectedState("normal")

				local var_101_14 = arg_98_1:GetWordFromCfg(325591024)
				local var_101_15 = arg_98_1:FormatText(var_101_14.content)

				arg_98_1.text_.text = var_101_15

				LuaForUtil.ClearLinePrefixSymbol(arg_98_1.text_)

				local var_101_16 = 27
				local var_101_17 = utf8.len(var_101_15)
				local var_101_18 = var_101_16 <= 0 and var_101_12 or var_101_12 * (var_101_17 / var_101_16)

				if var_101_18 > 0 and var_101_12 < var_101_18 then
					arg_98_1.talkMaxDuration = var_101_18

					if var_101_18 + var_101_11 > arg_98_1.duration_ then
						arg_98_1.duration_ = var_101_18 + var_101_11
					end
				end

				arg_98_1.text_.text = var_101_15
				arg_98_1.typewritter.percent = 0

				arg_98_1.typewritter:SetDirty()
				arg_98_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_325591", "325591024", "story_v_out_325591.awb") ~= 0 then
					local var_101_19 = manager.audio:GetVoiceLength("story_v_out_325591", "325591024", "story_v_out_325591.awb") / 1000

					if var_101_19 + var_101_11 > arg_98_1.duration_ then
						arg_98_1.duration_ = var_101_19 + var_101_11
					end

					if var_101_14.prefab_name ~= "" and arg_98_1.actors_[var_101_14.prefab_name] ~= nil then
						local var_101_20 = LuaForUtil.PlayVoiceWithCriLipsync(arg_98_1.actors_[var_101_14.prefab_name].transform, "story_v_out_325591", "325591024", "story_v_out_325591.awb")

						arg_98_1:RecordAudio("325591024", var_101_20)
						arg_98_1:RecordAudio("325591024", var_101_20)
					else
						arg_98_1:AudioAction("play", "voice", "story_v_out_325591", "325591024", "story_v_out_325591.awb")
					end

					arg_98_1:RecordHistoryTalkVoice("story_v_out_325591", "325591024", "story_v_out_325591.awb")
				end

				arg_98_1:RecordContent(arg_98_1.text_.text)
			end

			local var_101_21 = math.max(var_101_12, arg_98_1.talkMaxDuration)

			if var_101_11 <= arg_98_1.time_ and arg_98_1.time_ < var_101_11 + var_101_21 then
				arg_98_1.typewritter.percent = (arg_98_1.time_ - var_101_11) / var_101_21

				arg_98_1.typewritter:SetDirty()
			end

			if arg_98_1.time_ >= var_101_11 + var_101_21 and arg_98_1.time_ < var_101_11 + var_101_21 + arg_101_0 then
				arg_98_1.typewritter.percent = 1

				arg_98_1.typewritter:SetDirty()
				arg_98_1:ShowNextGo(true)
			end
		end

		arg_98_1.nodeConfigList_ = {}

		arg_98_1:InitPlayNodeList()
	end,
	Play325591025 = function(arg_102_0, arg_102_1)
		arg_102_1.time_ = 0
		arg_102_1.frameCnt_ = 0
		arg_102_1.state_ = "playing"
		arg_102_1.curTalkId_ = 325591025
		arg_102_1.duration_ = 4.3

		local var_102_0 = {
			zh = 4.3,
			ja = 3.933
		}
		local var_102_1 = manager.audio:GetLocalizationFlag()

		if var_102_0[var_102_1] ~= nil then
			arg_102_1.duration_ = var_102_0[var_102_1]
		end

		SetActive(arg_102_1.tipsGo_, false)

		function arg_102_1.onSingleLineFinish_()
			arg_102_1.onSingleLineUpdate_ = nil
			arg_102_1.onSingleLineFinish_ = nil
			arg_102_1.state_ = "waiting"
		end

		function arg_102_1.playNext_(arg_104_0)
			if arg_104_0 == 1 then
				arg_102_0:Play325591026(arg_102_1)
			end
		end

		function arg_102_1.onSingleLineUpdate_(arg_105_0)
			local var_105_0 = arg_102_1.actors_["1054ui_story"]
			local var_105_1 = 0

			if var_105_1 < arg_102_1.time_ and arg_102_1.time_ <= var_105_1 + arg_105_0 and not isNil(var_105_0) and arg_102_1.var_.characterEffect1054ui_story == nil then
				arg_102_1.var_.characterEffect1054ui_story = var_105_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_105_2 = 0.200000002980232

			if var_105_1 <= arg_102_1.time_ and arg_102_1.time_ < var_105_1 + var_105_2 and not isNil(var_105_0) then
				local var_105_3 = (arg_102_1.time_ - var_105_1) / var_105_2

				if arg_102_1.var_.characterEffect1054ui_story and not isNil(var_105_0) then
					arg_102_1.var_.characterEffect1054ui_story.fillFlat = false
				end
			end

			if arg_102_1.time_ >= var_105_1 + var_105_2 and arg_102_1.time_ < var_105_1 + var_105_2 + arg_105_0 and not isNil(var_105_0) and arg_102_1.var_.characterEffect1054ui_story then
				arg_102_1.var_.characterEffect1054ui_story.fillFlat = false
			end

			local var_105_4 = arg_102_1.actors_["6148ui_story"]
			local var_105_5 = 0

			if var_105_5 < arg_102_1.time_ and arg_102_1.time_ <= var_105_5 + arg_105_0 and not isNil(var_105_4) and arg_102_1.var_.characterEffect6148ui_story == nil then
				arg_102_1.var_.characterEffect6148ui_story = var_105_4:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_105_6 = 0.200000002980232

			if var_105_5 <= arg_102_1.time_ and arg_102_1.time_ < var_105_5 + var_105_6 and not isNil(var_105_4) then
				local var_105_7 = (arg_102_1.time_ - var_105_5) / var_105_6

				if arg_102_1.var_.characterEffect6148ui_story and not isNil(var_105_4) then
					local var_105_8 = Mathf.Lerp(0, 0.5, var_105_7)

					arg_102_1.var_.characterEffect6148ui_story.fillFlat = true
					arg_102_1.var_.characterEffect6148ui_story.fillRatio = var_105_8
				end
			end

			if arg_102_1.time_ >= var_105_5 + var_105_6 and arg_102_1.time_ < var_105_5 + var_105_6 + arg_105_0 and not isNil(var_105_4) and arg_102_1.var_.characterEffect6148ui_story then
				local var_105_9 = 0.5

				arg_102_1.var_.characterEffect6148ui_story.fillFlat = true
				arg_102_1.var_.characterEffect6148ui_story.fillRatio = var_105_9
			end

			local var_105_10 = 0

			if var_105_10 < arg_102_1.time_ and arg_102_1.time_ <= var_105_10 + arg_105_0 then
				arg_102_1:PlayTimeline("1054ui_story", "StoryTimeline/CharAction/story1054/story1054action/1054action6_1")
			end

			local var_105_11 = 0

			if var_105_11 < arg_102_1.time_ and arg_102_1.time_ <= var_105_11 + arg_105_0 then
				arg_102_1:PlayTimeline("1054ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0101cva", "EmotionTimelineAnimator")
			end

			local var_105_12 = 0.1
			local var_105_13 = 1

			if var_105_12 < arg_102_1.time_ and arg_102_1.time_ <= var_105_12 + arg_105_0 then
				local var_105_14 = "play"
				local var_105_15 = "effect"

				arg_102_1:AudioAction(var_105_14, var_105_15, "se_story_121_04", "se_story_121_04_blast", "")
			end

			local var_105_16 = 0
			local var_105_17 = 0.35

			if var_105_16 < arg_102_1.time_ and arg_102_1.time_ <= var_105_16 + arg_105_0 then
				arg_102_1.talkMaxDuration = 0
				arg_102_1.dialogCg_.alpha = 1

				arg_102_1.dialog_:SetActive(true)
				SetActive(arg_102_1.leftNameGo_, true)

				local var_105_18 = arg_102_1:FormatText(StoryNameCfg[1487].name)

				arg_102_1.leftNameTxt_.text = var_105_18

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_102_1.leftNameTxt_.transform)

				arg_102_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_102_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_102_1:RecordName(arg_102_1.leftNameTxt_.text)
				SetActive(arg_102_1.iconTrs_.gameObject, false)
				arg_102_1.callingController_:SetSelectedState("normal")

				local var_105_19 = arg_102_1:GetWordFromCfg(325591025)
				local var_105_20 = arg_102_1:FormatText(var_105_19.content)

				arg_102_1.text_.text = var_105_20

				LuaForUtil.ClearLinePrefixSymbol(arg_102_1.text_)

				local var_105_21 = 14
				local var_105_22 = utf8.len(var_105_20)
				local var_105_23 = var_105_21 <= 0 and var_105_17 or var_105_17 * (var_105_22 / var_105_21)

				if var_105_23 > 0 and var_105_17 < var_105_23 then
					arg_102_1.talkMaxDuration = var_105_23

					if var_105_23 + var_105_16 > arg_102_1.duration_ then
						arg_102_1.duration_ = var_105_23 + var_105_16
					end
				end

				arg_102_1.text_.text = var_105_20
				arg_102_1.typewritter.percent = 0

				arg_102_1.typewritter:SetDirty()
				arg_102_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_325591", "325591025", "story_v_out_325591.awb") ~= 0 then
					local var_105_24 = manager.audio:GetVoiceLength("story_v_out_325591", "325591025", "story_v_out_325591.awb") / 1000

					if var_105_24 + var_105_16 > arg_102_1.duration_ then
						arg_102_1.duration_ = var_105_24 + var_105_16
					end

					if var_105_19.prefab_name ~= "" and arg_102_1.actors_[var_105_19.prefab_name] ~= nil then
						local var_105_25 = LuaForUtil.PlayVoiceWithCriLipsync(arg_102_1.actors_[var_105_19.prefab_name].transform, "story_v_out_325591", "325591025", "story_v_out_325591.awb")

						arg_102_1:RecordAudio("325591025", var_105_25)
						arg_102_1:RecordAudio("325591025", var_105_25)
					else
						arg_102_1:AudioAction("play", "voice", "story_v_out_325591", "325591025", "story_v_out_325591.awb")
					end

					arg_102_1:RecordHistoryTalkVoice("story_v_out_325591", "325591025", "story_v_out_325591.awb")
				end

				arg_102_1:RecordContent(arg_102_1.text_.text)
			end

			local var_105_26 = math.max(var_105_17, arg_102_1.talkMaxDuration)

			if var_105_16 <= arg_102_1.time_ and arg_102_1.time_ < var_105_16 + var_105_26 then
				arg_102_1.typewritter.percent = (arg_102_1.time_ - var_105_16) / var_105_26

				arg_102_1.typewritter:SetDirty()
			end

			if arg_102_1.time_ >= var_105_16 + var_105_26 and arg_102_1.time_ < var_105_16 + var_105_26 + arg_105_0 then
				arg_102_1.typewritter.percent = 1

				arg_102_1.typewritter:SetDirty()
				arg_102_1:ShowNextGo(true)
			end
		end

		arg_102_1.nodeConfigList_ = {}

		arg_102_1:InitPlayNodeList()
	end,
	Play325591026 = function(arg_106_0, arg_106_1)
		arg_106_1.time_ = 0
		arg_106_1.frameCnt_ = 0
		arg_106_1.state_ = "playing"
		arg_106_1.curTalkId_ = 325591026
		arg_106_1.duration_ = 4.9

		local var_106_0 = {
			zh = 4.9,
			ja = 4.733
		}
		local var_106_1 = manager.audio:GetLocalizationFlag()

		if var_106_0[var_106_1] ~= nil then
			arg_106_1.duration_ = var_106_0[var_106_1]
		end

		SetActive(arg_106_1.tipsGo_, false)

		function arg_106_1.onSingleLineFinish_()
			arg_106_1.onSingleLineUpdate_ = nil
			arg_106_1.onSingleLineFinish_ = nil
			arg_106_1.state_ = "waiting"
		end

		function arg_106_1.playNext_(arg_108_0)
			if arg_108_0 == 1 then
				arg_106_0:Play325591027(arg_106_1)
			end
		end

		function arg_106_1.onSingleLineUpdate_(arg_109_0)
			local var_109_0 = 0

			if var_109_0 < arg_106_1.time_ and arg_106_1.time_ <= var_109_0 + arg_109_0 then
				arg_106_1:PlayTimeline("1054ui_story", "StoryTimeline/CharAction/story1054/story1054action/1054action6_2")
			end

			local var_109_1 = 0
			local var_109_2 = 0.475

			if var_109_1 < arg_106_1.time_ and arg_106_1.time_ <= var_109_1 + arg_109_0 then
				arg_106_1.talkMaxDuration = 0
				arg_106_1.dialogCg_.alpha = 1

				arg_106_1.dialog_:SetActive(true)
				SetActive(arg_106_1.leftNameGo_, true)

				local var_109_3 = arg_106_1:FormatText(StoryNameCfg[1487].name)

				arg_106_1.leftNameTxt_.text = var_109_3

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_106_1.leftNameTxt_.transform)

				arg_106_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_106_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_106_1:RecordName(arg_106_1.leftNameTxt_.text)
				SetActive(arg_106_1.iconTrs_.gameObject, false)
				arg_106_1.callingController_:SetSelectedState("normal")

				local var_109_4 = arg_106_1:GetWordFromCfg(325591026)
				local var_109_5 = arg_106_1:FormatText(var_109_4.content)

				arg_106_1.text_.text = var_109_5

				LuaForUtil.ClearLinePrefixSymbol(arg_106_1.text_)

				local var_109_6 = 19
				local var_109_7 = utf8.len(var_109_5)
				local var_109_8 = var_109_6 <= 0 and var_109_2 or var_109_2 * (var_109_7 / var_109_6)

				if var_109_8 > 0 and var_109_2 < var_109_8 then
					arg_106_1.talkMaxDuration = var_109_8

					if var_109_8 + var_109_1 > arg_106_1.duration_ then
						arg_106_1.duration_ = var_109_8 + var_109_1
					end
				end

				arg_106_1.text_.text = var_109_5
				arg_106_1.typewritter.percent = 0

				arg_106_1.typewritter:SetDirty()
				arg_106_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_325591", "325591026", "story_v_out_325591.awb") ~= 0 then
					local var_109_9 = manager.audio:GetVoiceLength("story_v_out_325591", "325591026", "story_v_out_325591.awb") / 1000

					if var_109_9 + var_109_1 > arg_106_1.duration_ then
						arg_106_1.duration_ = var_109_9 + var_109_1
					end

					if var_109_4.prefab_name ~= "" and arg_106_1.actors_[var_109_4.prefab_name] ~= nil then
						local var_109_10 = LuaForUtil.PlayVoiceWithCriLipsync(arg_106_1.actors_[var_109_4.prefab_name].transform, "story_v_out_325591", "325591026", "story_v_out_325591.awb")

						arg_106_1:RecordAudio("325591026", var_109_10)
						arg_106_1:RecordAudio("325591026", var_109_10)
					else
						arg_106_1:AudioAction("play", "voice", "story_v_out_325591", "325591026", "story_v_out_325591.awb")
					end

					arg_106_1:RecordHistoryTalkVoice("story_v_out_325591", "325591026", "story_v_out_325591.awb")
				end

				arg_106_1:RecordContent(arg_106_1.text_.text)
			end

			local var_109_11 = math.max(var_109_2, arg_106_1.talkMaxDuration)

			if var_109_1 <= arg_106_1.time_ and arg_106_1.time_ < var_109_1 + var_109_11 then
				arg_106_1.typewritter.percent = (arg_106_1.time_ - var_109_1) / var_109_11

				arg_106_1.typewritter:SetDirty()
			end

			if arg_106_1.time_ >= var_109_1 + var_109_11 and arg_106_1.time_ < var_109_1 + var_109_11 + arg_109_0 then
				arg_106_1.typewritter.percent = 1

				arg_106_1.typewritter:SetDirty()
				arg_106_1:ShowNextGo(true)
			end
		end

		arg_106_1.nodeConfigList_ = {}

		arg_106_1:InitPlayNodeList()
	end,
	Play325591027 = function(arg_110_0, arg_110_1)
		arg_110_1.time_ = 0
		arg_110_1.frameCnt_ = 0
		arg_110_1.state_ = "playing"
		arg_110_1.curTalkId_ = 325591027
		arg_110_1.duration_ = 7.85

		SetActive(arg_110_1.tipsGo_, false)

		function arg_110_1.onSingleLineFinish_()
			arg_110_1.onSingleLineUpdate_ = nil
			arg_110_1.onSingleLineFinish_ = nil
			arg_110_1.state_ = "waiting"
		end

		function arg_110_1.playNext_(arg_112_0)
			if arg_112_0 == 1 then
				arg_110_0:Play325591028(arg_110_1)
			end
		end

		function arg_110_1.onSingleLineUpdate_(arg_113_0)
			local var_113_0 = arg_110_1.actors_["6148ui_story"].transform
			local var_113_1 = 0

			if var_113_1 < arg_110_1.time_ and arg_110_1.time_ <= var_113_1 + arg_113_0 then
				arg_110_1.var_.moveOldPos6148ui_story = var_113_0.localPosition

				local var_113_2 = GameObjectTools.GetOrAddComponent(var_113_0.gameObject, typeof(DynamicBoneHelper))

				if var_113_2 then
					var_113_2:EnableDynamicBone(false)
				end
			end

			local var_113_3 = 0.001

			if var_113_1 <= arg_110_1.time_ and arg_110_1.time_ < var_113_1 + var_113_3 then
				local var_113_4 = (arg_110_1.time_ - var_113_1) / var_113_3
				local var_113_5 = Vector3.New(0, 100, 0)

				var_113_0.localPosition = Vector3.Lerp(arg_110_1.var_.moveOldPos6148ui_story, var_113_5, var_113_4)

				local var_113_6 = manager.ui.mainCamera.transform.position - var_113_0.position

				var_113_0.forward = Vector3.New(var_113_6.x, var_113_6.y, var_113_6.z)

				local var_113_7 = var_113_0.localEulerAngles

				var_113_7.z = 0
				var_113_7.x = 0
				var_113_0.localEulerAngles = var_113_7
			end

			if arg_110_1.time_ >= var_113_1 + var_113_3 and arg_110_1.time_ < var_113_1 + var_113_3 + arg_113_0 then
				var_113_0.localPosition = Vector3.New(0, 100, 0)

				local var_113_8 = manager.ui.mainCamera.transform.position - var_113_0.position

				var_113_0.forward = Vector3.New(var_113_8.x, var_113_8.y, var_113_8.z)

				local var_113_9 = var_113_0.localEulerAngles

				var_113_9.z = 0
				var_113_9.x = 0
				var_113_0.localEulerAngles = var_113_9

				local var_113_10 = GameObjectTools.GetOrAddComponent(var_113_0.gameObject, typeof(DynamicBoneHelper))

				if var_113_10 then
					var_113_10:EnableDynamicBone(true)
				end
			end

			local var_113_11 = arg_110_1.actors_["1054ui_story"].transform
			local var_113_12 = 0

			if var_113_12 < arg_110_1.time_ and arg_110_1.time_ <= var_113_12 + arg_113_0 then
				arg_110_1.var_.moveOldPos1054ui_story = var_113_11.localPosition

				local var_113_13 = GameObjectTools.GetOrAddComponent(var_113_11.gameObject, typeof(DynamicBoneHelper))

				if var_113_13 then
					var_113_13:EnableDynamicBone(false)
				end
			end

			local var_113_14 = 0.001

			if var_113_12 <= arg_110_1.time_ and arg_110_1.time_ < var_113_12 + var_113_14 then
				local var_113_15 = (arg_110_1.time_ - var_113_12) / var_113_14
				local var_113_16 = Vector3.New(0, 100, 0)

				var_113_11.localPosition = Vector3.Lerp(arg_110_1.var_.moveOldPos1054ui_story, var_113_16, var_113_15)

				local var_113_17 = manager.ui.mainCamera.transform.position - var_113_11.position

				var_113_11.forward = Vector3.New(var_113_17.x, var_113_17.y, var_113_17.z)

				local var_113_18 = var_113_11.localEulerAngles

				var_113_18.z = 0
				var_113_18.x = 0
				var_113_11.localEulerAngles = var_113_18
			end

			if arg_110_1.time_ >= var_113_12 + var_113_14 and arg_110_1.time_ < var_113_12 + var_113_14 + arg_113_0 then
				var_113_11.localPosition = Vector3.New(0, 100, 0)

				local var_113_19 = manager.ui.mainCamera.transform.position - var_113_11.position

				var_113_11.forward = Vector3.New(var_113_19.x, var_113_19.y, var_113_19.z)

				local var_113_20 = var_113_11.localEulerAngles

				var_113_20.z = 0
				var_113_20.x = 0
				var_113_11.localEulerAngles = var_113_20

				local var_113_21 = GameObjectTools.GetOrAddComponent(var_113_11.gameObject, typeof(DynamicBoneHelper))

				if var_113_21 then
					var_113_21:EnableDynamicBone(true)
				end
			end

			local var_113_22 = arg_110_1.actors_["1054ui_story"]
			local var_113_23 = 0

			if var_113_23 < arg_110_1.time_ and arg_110_1.time_ <= var_113_23 + arg_113_0 and not isNil(var_113_22) and arg_110_1.var_.characterEffect1054ui_story == nil then
				arg_110_1.var_.characterEffect1054ui_story = var_113_22:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_113_24 = 0.200000002980232

			if var_113_23 <= arg_110_1.time_ and arg_110_1.time_ < var_113_23 + var_113_24 and not isNil(var_113_22) then
				local var_113_25 = (arg_110_1.time_ - var_113_23) / var_113_24

				if arg_110_1.var_.characterEffect1054ui_story and not isNil(var_113_22) then
					local var_113_26 = Mathf.Lerp(0, 0.5, var_113_25)

					arg_110_1.var_.characterEffect1054ui_story.fillFlat = true
					arg_110_1.var_.characterEffect1054ui_story.fillRatio = var_113_26
				end
			end

			if arg_110_1.time_ >= var_113_23 + var_113_24 and arg_110_1.time_ < var_113_23 + var_113_24 + arg_113_0 and not isNil(var_113_22) and arg_110_1.var_.characterEffect1054ui_story then
				local var_113_27 = 0.5

				arg_110_1.var_.characterEffect1054ui_story.fillFlat = true
				arg_110_1.var_.characterEffect1054ui_story.fillRatio = var_113_27
			end

			local var_113_28 = manager.ui.mainCamera.transform
			local var_113_29 = 0

			if var_113_29 < arg_110_1.time_ and arg_110_1.time_ <= var_113_29 + arg_113_0 then
				arg_110_1.var_.shakeOldPos = var_113_28.localPosition
			end

			local var_113_30 = 2

			if var_113_29 <= arg_110_1.time_ and arg_110_1.time_ < var_113_29 + var_113_30 then
				local var_113_31 = (arg_110_1.time_ - var_113_29) / 0.066
				local var_113_32, var_113_33 = math.modf(var_113_31)

				var_113_28.localPosition = Vector3.New(var_113_33 * 0.13, var_113_33 * 0.13, var_113_33 * 0.13) + arg_110_1.var_.shakeOldPos
			end

			if arg_110_1.time_ >= var_113_29 + var_113_30 and arg_110_1.time_ < var_113_29 + var_113_30 + arg_113_0 then
				var_113_28.localPosition = arg_110_1.var_.shakeOldPos
			end

			local var_113_34 = manager.ui.mainCamera.transform
			local var_113_35 = 0

			if var_113_35 < arg_110_1.time_ and arg_110_1.time_ <= var_113_35 + arg_113_0 then
				local var_113_36 = arg_110_1.var_.effectdidongshanyao1
				local var_113_37
				local var_113_38 = var_113_34

				if not var_113_36 then
					var_113_36 = Object.Instantiate(Asset.Load("Effect/Scene/fx_uistory_rockfall"), var_113_38)
					var_113_36.name = "didongshanyao1"
					arg_110_1.var_.effectdidongshanyao1 = var_113_36
				else
					var_113_36.transform:SetParent(var_113_38)
				end

				var_113_36.transform.localPosition = Vector3.New(0, 0, 0)
				var_113_36.transform.localRotation = Quaternion.Euler(0, 0, 0)
			end

			local var_113_39 = manager.ui.mainCamera.transform
			local var_113_40 = 3.83333333333333

			if var_113_40 < arg_110_1.time_ and arg_110_1.time_ <= var_113_40 + arg_113_0 then
				local var_113_41 = arg_110_1.var_.effectdidongshanyao1

				if var_113_41 then
					Object.Destroy(var_113_41)

					arg_110_1.var_.effectdidongshanyao1 = nil
				end
			end

			local var_113_42 = 0

			if var_113_42 < arg_110_1.time_ and arg_110_1.time_ <= var_113_42 + arg_113_0 then
				arg_110_1.allBtn_.enabled = false
			end

			local var_113_43 = 4.299999999999

			if arg_110_1.time_ >= var_113_42 + var_113_43 and arg_110_1.time_ < var_113_42 + var_113_43 + arg_113_0 then
				arg_110_1.allBtn_.enabled = true
			end

			if arg_110_1.frameCnt_ <= 1 then
				arg_110_1.dialog_:SetActive(false)
			end

			local var_113_44 = 2.849999999999
			local var_113_45 = 1.45

			if var_113_44 < arg_110_1.time_ and arg_110_1.time_ <= var_113_44 + arg_113_0 then
				arg_110_1.talkMaxDuration = 0

				arg_110_1.dialog_:SetActive(true)

				arg_110_1.dialogCg_.alpha = 0

				local var_113_46 = LeanTween.value(arg_110_1.dialog_, 0, 1, 0.3)

				var_113_46:setOnUpdate(LuaHelper.FloatAction(function(arg_114_0)
					arg_110_1.dialogCg_.alpha = arg_114_0
				end))
				var_113_46:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_110_1.dialog_)
					var_113_46:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_110_1.duration_ = arg_110_1.duration_ + 0.3

				SetActive(arg_110_1.leftNameGo_, false)

				arg_110_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_110_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_110_1:RecordName(arg_110_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_110_1.iconTrs_.gameObject, false)
				arg_110_1.callingController_:SetSelectedState("normal")

				local var_113_47 = arg_110_1:GetWordFromCfg(325591027)
				local var_113_48 = arg_110_1:FormatText(var_113_47.content)

				arg_110_1.text_.text = var_113_48

				LuaForUtil.ClearLinePrefixSymbol(arg_110_1.text_)

				local var_113_49 = 58
				local var_113_50 = utf8.len(var_113_48)
				local var_113_51 = var_113_49 <= 0 and var_113_45 or var_113_45 * (var_113_50 / var_113_49)

				if var_113_51 > 0 and var_113_45 < var_113_51 then
					arg_110_1.talkMaxDuration = var_113_51
					var_113_44 = var_113_44 + 0.3

					if var_113_51 + var_113_44 > arg_110_1.duration_ then
						arg_110_1.duration_ = var_113_51 + var_113_44
					end
				end

				arg_110_1.text_.text = var_113_48
				arg_110_1.typewritter.percent = 0

				arg_110_1.typewritter:SetDirty()
				arg_110_1:ShowNextGo(false)
				arg_110_1:RecordContent(arg_110_1.text_.text)
			end

			local var_113_52 = var_113_44 + 0.3
			local var_113_53 = math.max(var_113_45, arg_110_1.talkMaxDuration)

			if var_113_52 <= arg_110_1.time_ and arg_110_1.time_ < var_113_52 + var_113_53 then
				arg_110_1.typewritter.percent = (arg_110_1.time_ - var_113_52) / var_113_53

				arg_110_1.typewritter:SetDirty()
			end

			if arg_110_1.time_ >= var_113_52 + var_113_53 and arg_110_1.time_ < var_113_52 + var_113_53 + arg_113_0 then
				arg_110_1.typewritter.percent = 1

				arg_110_1.typewritter:SetDirty()
				arg_110_1:ShowNextGo(true)
			end
		end

		arg_110_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "6148ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1054ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_110_1:InitPlayNodeList()
	end,
	Play325591028 = function(arg_116_0, arg_116_1)
		arg_116_1.time_ = 0
		arg_116_1.frameCnt_ = 0
		arg_116_1.state_ = "playing"
		arg_116_1.curTalkId_ = 325591028
		arg_116_1.duration_ = 7.5

		local var_116_0 = {
			zh = 5.3,
			ja = 7.5
		}
		local var_116_1 = manager.audio:GetLocalizationFlag()

		if var_116_0[var_116_1] ~= nil then
			arg_116_1.duration_ = var_116_0[var_116_1]
		end

		SetActive(arg_116_1.tipsGo_, false)

		function arg_116_1.onSingleLineFinish_()
			arg_116_1.onSingleLineUpdate_ = nil
			arg_116_1.onSingleLineFinish_ = nil
			arg_116_1.state_ = "waiting"
		end

		function arg_116_1.playNext_(arg_118_0)
			if arg_118_0 == 1 then
				arg_116_0:Play325591029(arg_116_1)
			end
		end

		function arg_116_1.onSingleLineUpdate_(arg_119_0)
			local var_119_0 = arg_116_1.actors_["6148ui_story"].transform
			local var_119_1 = 0

			if var_119_1 < arg_116_1.time_ and arg_116_1.time_ <= var_119_1 + arg_119_0 then
				arg_116_1.var_.moveOldPos6148ui_story = var_119_0.localPosition

				local var_119_2 = GameObjectTools.GetOrAddComponent(var_119_0.gameObject, typeof(DynamicBoneHelper))

				if var_119_2 then
					var_119_2:EnableDynamicBone(false)
				end
			end

			local var_119_3 = 0.001

			if var_119_1 <= arg_116_1.time_ and arg_116_1.time_ < var_119_1 + var_119_3 then
				local var_119_4 = (arg_116_1.time_ - var_119_1) / var_119_3
				local var_119_5 = Vector3.New(0, -0.985, -6)

				var_119_0.localPosition = Vector3.Lerp(arg_116_1.var_.moveOldPos6148ui_story, var_119_5, var_119_4)

				local var_119_6 = manager.ui.mainCamera.transform.position - var_119_0.position

				var_119_0.forward = Vector3.New(var_119_6.x, var_119_6.y, var_119_6.z)

				local var_119_7 = var_119_0.localEulerAngles

				var_119_7.z = 0
				var_119_7.x = 0
				var_119_0.localEulerAngles = var_119_7
			end

			if arg_116_1.time_ >= var_119_1 + var_119_3 and arg_116_1.time_ < var_119_1 + var_119_3 + arg_119_0 then
				var_119_0.localPosition = Vector3.New(0, -0.985, -6)

				local var_119_8 = manager.ui.mainCamera.transform.position - var_119_0.position

				var_119_0.forward = Vector3.New(var_119_8.x, var_119_8.y, var_119_8.z)

				local var_119_9 = var_119_0.localEulerAngles

				var_119_9.z = 0
				var_119_9.x = 0
				var_119_0.localEulerAngles = var_119_9

				local var_119_10 = GameObjectTools.GetOrAddComponent(var_119_0.gameObject, typeof(DynamicBoneHelper))

				if var_119_10 then
					var_119_10:EnableDynamicBone(true)
				end
			end

			local var_119_11 = arg_116_1.actors_["6148ui_story"]
			local var_119_12 = 0

			if var_119_12 < arg_116_1.time_ and arg_116_1.time_ <= var_119_12 + arg_119_0 and not isNil(var_119_11) and arg_116_1.var_.characterEffect6148ui_story == nil then
				arg_116_1.var_.characterEffect6148ui_story = var_119_11:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_119_13 = 0.200000002980232

			if var_119_12 <= arg_116_1.time_ and arg_116_1.time_ < var_119_12 + var_119_13 and not isNil(var_119_11) then
				local var_119_14 = (arg_116_1.time_ - var_119_12) / var_119_13

				if arg_116_1.var_.characterEffect6148ui_story and not isNil(var_119_11) then
					arg_116_1.var_.characterEffect6148ui_story.fillFlat = false
				end
			end

			if arg_116_1.time_ >= var_119_12 + var_119_13 and arg_116_1.time_ < var_119_12 + var_119_13 + arg_119_0 and not isNil(var_119_11) and arg_116_1.var_.characterEffect6148ui_story then
				arg_116_1.var_.characterEffect6148ui_story.fillFlat = false
			end

			local var_119_15 = 0

			if var_119_15 < arg_116_1.time_ and arg_116_1.time_ <= var_119_15 + arg_119_0 then
				arg_116_1:PlayTimeline("6148ui_story", "StoryTimeline/CharAction/story6148/story6148action/6148action6_1")
			end

			local var_119_16 = 0

			if var_119_16 < arg_116_1.time_ and arg_116_1.time_ <= var_119_16 + arg_119_0 then
				arg_116_1:PlayTimeline("6148ui_story", "StoryTimeline/CharAction/public_expression/expr_youyu", "EmotionTimelineAnimator")
			end

			local var_119_17 = 0
			local var_119_18 = 0.55

			if var_119_17 < arg_116_1.time_ and arg_116_1.time_ <= var_119_17 + arg_119_0 then
				arg_116_1.talkMaxDuration = 0
				arg_116_1.dialogCg_.alpha = 1

				arg_116_1.dialog_:SetActive(true)
				SetActive(arg_116_1.leftNameGo_, true)

				local var_119_19 = arg_116_1:FormatText(StoryNameCfg[1488].name)

				arg_116_1.leftNameTxt_.text = var_119_19

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_116_1.leftNameTxt_.transform)

				arg_116_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_116_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_116_1:RecordName(arg_116_1.leftNameTxt_.text)
				SetActive(arg_116_1.iconTrs_.gameObject, false)
				arg_116_1.callingController_:SetSelectedState("normal")

				local var_119_20 = arg_116_1:GetWordFromCfg(325591028)
				local var_119_21 = arg_116_1:FormatText(var_119_20.content)

				arg_116_1.text_.text = var_119_21

				LuaForUtil.ClearLinePrefixSymbol(arg_116_1.text_)

				local var_119_22 = 22
				local var_119_23 = utf8.len(var_119_21)
				local var_119_24 = var_119_22 <= 0 and var_119_18 or var_119_18 * (var_119_23 / var_119_22)

				if var_119_24 > 0 and var_119_18 < var_119_24 then
					arg_116_1.talkMaxDuration = var_119_24

					if var_119_24 + var_119_17 > arg_116_1.duration_ then
						arg_116_1.duration_ = var_119_24 + var_119_17
					end
				end

				arg_116_1.text_.text = var_119_21
				arg_116_1.typewritter.percent = 0

				arg_116_1.typewritter:SetDirty()
				arg_116_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_325591", "325591028", "story_v_out_325591.awb") ~= 0 then
					local var_119_25 = manager.audio:GetVoiceLength("story_v_out_325591", "325591028", "story_v_out_325591.awb") / 1000

					if var_119_25 + var_119_17 > arg_116_1.duration_ then
						arg_116_1.duration_ = var_119_25 + var_119_17
					end

					if var_119_20.prefab_name ~= "" and arg_116_1.actors_[var_119_20.prefab_name] ~= nil then
						local var_119_26 = LuaForUtil.PlayVoiceWithCriLipsync(arg_116_1.actors_[var_119_20.prefab_name].transform, "story_v_out_325591", "325591028", "story_v_out_325591.awb")

						arg_116_1:RecordAudio("325591028", var_119_26)
						arg_116_1:RecordAudio("325591028", var_119_26)
					else
						arg_116_1:AudioAction("play", "voice", "story_v_out_325591", "325591028", "story_v_out_325591.awb")
					end

					arg_116_1:RecordHistoryTalkVoice("story_v_out_325591", "325591028", "story_v_out_325591.awb")
				end

				arg_116_1:RecordContent(arg_116_1.text_.text)
			end

			local var_119_27 = math.max(var_119_18, arg_116_1.talkMaxDuration)

			if var_119_17 <= arg_116_1.time_ and arg_116_1.time_ < var_119_17 + var_119_27 then
				arg_116_1.typewritter.percent = (arg_116_1.time_ - var_119_17) / var_119_27

				arg_116_1.typewritter:SetDirty()
			end

			if arg_116_1.time_ >= var_119_17 + var_119_27 and arg_116_1.time_ < var_119_17 + var_119_27 + arg_119_0 then
				arg_116_1.typewritter.percent = 1

				arg_116_1.typewritter:SetDirty()
				arg_116_1:ShowNextGo(true)
			end
		end

		arg_116_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "6148ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_116_1:InitPlayNodeList()
	end,
	Play325591029 = function(arg_120_0, arg_120_1)
		arg_120_1.time_ = 0
		arg_120_1.frameCnt_ = 0
		arg_120_1.state_ = "playing"
		arg_120_1.curTalkId_ = 325591029
		arg_120_1.duration_ = 4.93

		SetActive(arg_120_1.tipsGo_, false)

		function arg_120_1.onSingleLineFinish_()
			arg_120_1.onSingleLineUpdate_ = nil
			arg_120_1.onSingleLineFinish_ = nil
			arg_120_1.state_ = "waiting"
		end

		function arg_120_1.playNext_(arg_122_0)
			if arg_122_0 == 1 then
				arg_120_0:Play325591030(arg_120_1)
			end
		end

		function arg_120_1.onSingleLineUpdate_(arg_123_0)
			local var_123_0 = arg_120_1.actors_["6148ui_story"].transform
			local var_123_1 = 0

			if var_123_1 < arg_120_1.time_ and arg_120_1.time_ <= var_123_1 + arg_123_0 then
				arg_120_1.var_.moveOldPos6148ui_story = var_123_0.localPosition

				local var_123_2 = GameObjectTools.GetOrAddComponent(var_123_0.gameObject, typeof(DynamicBoneHelper))

				if var_123_2 then
					var_123_2:EnableDynamicBone(false)
				end
			end

			local var_123_3 = 0.001

			if var_123_1 <= arg_120_1.time_ and arg_120_1.time_ < var_123_1 + var_123_3 then
				local var_123_4 = (arg_120_1.time_ - var_123_1) / var_123_3
				local var_123_5 = Vector3.New(-0.7, -0.985, -6)

				var_123_0.localPosition = Vector3.Lerp(arg_120_1.var_.moveOldPos6148ui_story, var_123_5, var_123_4)

				local var_123_6 = manager.ui.mainCamera.transform.position - var_123_0.position

				var_123_0.forward = Vector3.New(var_123_6.x, var_123_6.y, var_123_6.z)

				local var_123_7 = var_123_0.localEulerAngles

				var_123_7.z = 0
				var_123_7.x = 0
				var_123_0.localEulerAngles = var_123_7
			end

			if arg_120_1.time_ >= var_123_1 + var_123_3 and arg_120_1.time_ < var_123_1 + var_123_3 + arg_123_0 then
				var_123_0.localPosition = Vector3.New(-0.7, -0.985, -6)

				local var_123_8 = manager.ui.mainCamera.transform.position - var_123_0.position

				var_123_0.forward = Vector3.New(var_123_8.x, var_123_8.y, var_123_8.z)

				local var_123_9 = var_123_0.localEulerAngles

				var_123_9.z = 0
				var_123_9.x = 0
				var_123_0.localEulerAngles = var_123_9

				local var_123_10 = GameObjectTools.GetOrAddComponent(var_123_0.gameObject, typeof(DynamicBoneHelper))

				if var_123_10 then
					var_123_10:EnableDynamicBone(true)
				end
			end

			local var_123_11 = arg_120_1.actors_["1054ui_story"].transform
			local var_123_12 = 0

			if var_123_12 < arg_120_1.time_ and arg_120_1.time_ <= var_123_12 + arg_123_0 then
				arg_120_1.var_.moveOldPos1054ui_story = var_123_11.localPosition

				local var_123_13 = GameObjectTools.GetOrAddComponent(var_123_11.gameObject, typeof(DynamicBoneHelper))

				if var_123_13 then
					var_123_13:EnableDynamicBone(false)
				end
			end

			local var_123_14 = 0.001

			if var_123_12 <= arg_120_1.time_ and arg_120_1.time_ < var_123_12 + var_123_14 then
				local var_123_15 = (arg_120_1.time_ - var_123_12) / var_123_14
				local var_123_16 = Vector3.New(0.7, -0.985, -6)

				var_123_11.localPosition = Vector3.Lerp(arg_120_1.var_.moveOldPos1054ui_story, var_123_16, var_123_15)

				local var_123_17 = manager.ui.mainCamera.transform.position - var_123_11.position

				var_123_11.forward = Vector3.New(var_123_17.x, var_123_17.y, var_123_17.z)

				local var_123_18 = var_123_11.localEulerAngles

				var_123_18.z = 0
				var_123_18.x = 0
				var_123_11.localEulerAngles = var_123_18
			end

			if arg_120_1.time_ >= var_123_12 + var_123_14 and arg_120_1.time_ < var_123_12 + var_123_14 + arg_123_0 then
				var_123_11.localPosition = Vector3.New(0.7, -0.985, -6)

				local var_123_19 = manager.ui.mainCamera.transform.position - var_123_11.position

				var_123_11.forward = Vector3.New(var_123_19.x, var_123_19.y, var_123_19.z)

				local var_123_20 = var_123_11.localEulerAngles

				var_123_20.z = 0
				var_123_20.x = 0
				var_123_11.localEulerAngles = var_123_20

				local var_123_21 = GameObjectTools.GetOrAddComponent(var_123_11.gameObject, typeof(DynamicBoneHelper))

				if var_123_21 then
					var_123_21:EnableDynamicBone(true)
				end
			end

			local var_123_22 = arg_120_1.actors_["1054ui_story"]
			local var_123_23 = 0

			if var_123_23 < arg_120_1.time_ and arg_120_1.time_ <= var_123_23 + arg_123_0 and not isNil(var_123_22) and arg_120_1.var_.characterEffect1054ui_story == nil then
				arg_120_1.var_.characterEffect1054ui_story = var_123_22:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_123_24 = 0.200000002980232

			if var_123_23 <= arg_120_1.time_ and arg_120_1.time_ < var_123_23 + var_123_24 and not isNil(var_123_22) then
				local var_123_25 = (arg_120_1.time_ - var_123_23) / var_123_24

				if arg_120_1.var_.characterEffect1054ui_story and not isNil(var_123_22) then
					arg_120_1.var_.characterEffect1054ui_story.fillFlat = false
				end
			end

			if arg_120_1.time_ >= var_123_23 + var_123_24 and arg_120_1.time_ < var_123_23 + var_123_24 + arg_123_0 and not isNil(var_123_22) and arg_120_1.var_.characterEffect1054ui_story then
				arg_120_1.var_.characterEffect1054ui_story.fillFlat = false
			end

			local var_123_26 = arg_120_1.actors_["6148ui_story"]
			local var_123_27 = 0

			if var_123_27 < arg_120_1.time_ and arg_120_1.time_ <= var_123_27 + arg_123_0 and not isNil(var_123_26) and arg_120_1.var_.characterEffect6148ui_story == nil then
				arg_120_1.var_.characterEffect6148ui_story = var_123_26:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_123_28 = 0.200000002980232

			if var_123_27 <= arg_120_1.time_ and arg_120_1.time_ < var_123_27 + var_123_28 and not isNil(var_123_26) then
				local var_123_29 = (arg_120_1.time_ - var_123_27) / var_123_28

				if arg_120_1.var_.characterEffect6148ui_story and not isNil(var_123_26) then
					local var_123_30 = Mathf.Lerp(0, 0.5, var_123_29)

					arg_120_1.var_.characterEffect6148ui_story.fillFlat = true
					arg_120_1.var_.characterEffect6148ui_story.fillRatio = var_123_30
				end
			end

			if arg_120_1.time_ >= var_123_27 + var_123_28 and arg_120_1.time_ < var_123_27 + var_123_28 + arg_123_0 and not isNil(var_123_26) and arg_120_1.var_.characterEffect6148ui_story then
				local var_123_31 = 0.5

				arg_120_1.var_.characterEffect6148ui_story.fillFlat = true
				arg_120_1.var_.characterEffect6148ui_story.fillRatio = var_123_31
			end

			local var_123_32 = 0

			if var_123_32 < arg_120_1.time_ and arg_120_1.time_ <= var_123_32 + arg_123_0 then
				arg_120_1:PlayTimeline("1054ui_story", "StoryTimeline/CharAction/story1054/story1054action/1054action1_1")
			end

			local var_123_33 = 0

			if var_123_33 < arg_120_1.time_ and arg_120_1.time_ <= var_123_33 + arg_123_0 then
				arg_120_1:PlayTimeline("1054ui_story", "StoryTimeline/CharAction/public_expression/expr_zhushiA", "EmotionTimelineAnimator")
			end

			local var_123_34 = 0
			local var_123_35 = 0.525

			if var_123_34 < arg_120_1.time_ and arg_120_1.time_ <= var_123_34 + arg_123_0 then
				arg_120_1.talkMaxDuration = 0
				arg_120_1.dialogCg_.alpha = 1

				arg_120_1.dialog_:SetActive(true)
				SetActive(arg_120_1.leftNameGo_, true)

				local var_123_36 = arg_120_1:FormatText(StoryNameCfg[1487].name)

				arg_120_1.leftNameTxt_.text = var_123_36

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_120_1.leftNameTxt_.transform)

				arg_120_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_120_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_120_1:RecordName(arg_120_1.leftNameTxt_.text)
				SetActive(arg_120_1.iconTrs_.gameObject, false)
				arg_120_1.callingController_:SetSelectedState("normal")

				local var_123_37 = arg_120_1:GetWordFromCfg(325591029)
				local var_123_38 = arg_120_1:FormatText(var_123_37.content)

				arg_120_1.text_.text = var_123_38

				LuaForUtil.ClearLinePrefixSymbol(arg_120_1.text_)

				local var_123_39 = 21
				local var_123_40 = utf8.len(var_123_38)
				local var_123_41 = var_123_39 <= 0 and var_123_35 or var_123_35 * (var_123_40 / var_123_39)

				if var_123_41 > 0 and var_123_35 < var_123_41 then
					arg_120_1.talkMaxDuration = var_123_41

					if var_123_41 + var_123_34 > arg_120_1.duration_ then
						arg_120_1.duration_ = var_123_41 + var_123_34
					end
				end

				arg_120_1.text_.text = var_123_38
				arg_120_1.typewritter.percent = 0

				arg_120_1.typewritter:SetDirty()
				arg_120_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_325591", "325591029", "story_v_out_325591.awb") ~= 0 then
					local var_123_42 = manager.audio:GetVoiceLength("story_v_out_325591", "325591029", "story_v_out_325591.awb") / 1000

					if var_123_42 + var_123_34 > arg_120_1.duration_ then
						arg_120_1.duration_ = var_123_42 + var_123_34
					end

					if var_123_37.prefab_name ~= "" and arg_120_1.actors_[var_123_37.prefab_name] ~= nil then
						local var_123_43 = LuaForUtil.PlayVoiceWithCriLipsync(arg_120_1.actors_[var_123_37.prefab_name].transform, "story_v_out_325591", "325591029", "story_v_out_325591.awb")

						arg_120_1:RecordAudio("325591029", var_123_43)
						arg_120_1:RecordAudio("325591029", var_123_43)
					else
						arg_120_1:AudioAction("play", "voice", "story_v_out_325591", "325591029", "story_v_out_325591.awb")
					end

					arg_120_1:RecordHistoryTalkVoice("story_v_out_325591", "325591029", "story_v_out_325591.awb")
				end

				arg_120_1:RecordContent(arg_120_1.text_.text)
			end

			local var_123_44 = math.max(var_123_35, arg_120_1.talkMaxDuration)

			if var_123_34 <= arg_120_1.time_ and arg_120_1.time_ < var_123_34 + var_123_44 then
				arg_120_1.typewritter.percent = (arg_120_1.time_ - var_123_34) / var_123_44

				arg_120_1.typewritter:SetDirty()
			end

			if arg_120_1.time_ >= var_123_34 + var_123_44 and arg_120_1.time_ < var_123_34 + var_123_44 + arg_123_0 then
				arg_120_1.typewritter.percent = 1

				arg_120_1.typewritter:SetDirty()
				arg_120_1:ShowNextGo(true)
			end
		end

		arg_120_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "6148ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1054ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_120_1:InitPlayNodeList()
	end,
	Play325591030 = function(arg_124_0, arg_124_1)
		arg_124_1.time_ = 0
		arg_124_1.frameCnt_ = 0
		arg_124_1.state_ = "playing"
		arg_124_1.curTalkId_ = 325591030
		arg_124_1.duration_ = 2.97

		local var_124_0 = {
			zh = 2.866,
			ja = 2.966
		}
		local var_124_1 = manager.audio:GetLocalizationFlag()

		if var_124_0[var_124_1] ~= nil then
			arg_124_1.duration_ = var_124_0[var_124_1]
		end

		SetActive(arg_124_1.tipsGo_, false)

		function arg_124_1.onSingleLineFinish_()
			arg_124_1.onSingleLineUpdate_ = nil
			arg_124_1.onSingleLineFinish_ = nil
			arg_124_1.state_ = "waiting"
		end

		function arg_124_1.playNext_(arg_126_0)
			if arg_126_0 == 1 then
				arg_124_0:Play325591031(arg_124_1)
			end
		end

		function arg_124_1.onSingleLineUpdate_(arg_127_0)
			local var_127_0 = 0
			local var_127_1 = 0.2

			if var_127_0 < arg_124_1.time_ and arg_124_1.time_ <= var_127_0 + arg_127_0 then
				arg_124_1.talkMaxDuration = 0
				arg_124_1.dialogCg_.alpha = 1

				arg_124_1.dialog_:SetActive(true)
				SetActive(arg_124_1.leftNameGo_, true)

				local var_127_2 = arg_124_1:FormatText(StoryNameCfg[1487].name)

				arg_124_1.leftNameTxt_.text = var_127_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_124_1.leftNameTxt_.transform)

				arg_124_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_124_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_124_1:RecordName(arg_124_1.leftNameTxt_.text)
				SetActive(arg_124_1.iconTrs_.gameObject, false)
				arg_124_1.callingController_:SetSelectedState("normal")

				local var_127_3 = arg_124_1:GetWordFromCfg(325591030)
				local var_127_4 = arg_124_1:FormatText(var_127_3.content)

				arg_124_1.text_.text = var_127_4

				LuaForUtil.ClearLinePrefixSymbol(arg_124_1.text_)

				local var_127_5 = 8
				local var_127_6 = utf8.len(var_127_4)
				local var_127_7 = var_127_5 <= 0 and var_127_1 or var_127_1 * (var_127_6 / var_127_5)

				if var_127_7 > 0 and var_127_1 < var_127_7 then
					arg_124_1.talkMaxDuration = var_127_7

					if var_127_7 + var_127_0 > arg_124_1.duration_ then
						arg_124_1.duration_ = var_127_7 + var_127_0
					end
				end

				arg_124_1.text_.text = var_127_4
				arg_124_1.typewritter.percent = 0

				arg_124_1.typewritter:SetDirty()
				arg_124_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_325591", "325591030", "story_v_out_325591.awb") ~= 0 then
					local var_127_8 = manager.audio:GetVoiceLength("story_v_out_325591", "325591030", "story_v_out_325591.awb") / 1000

					if var_127_8 + var_127_0 > arg_124_1.duration_ then
						arg_124_1.duration_ = var_127_8 + var_127_0
					end

					if var_127_3.prefab_name ~= "" and arg_124_1.actors_[var_127_3.prefab_name] ~= nil then
						local var_127_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_124_1.actors_[var_127_3.prefab_name].transform, "story_v_out_325591", "325591030", "story_v_out_325591.awb")

						arg_124_1:RecordAudio("325591030", var_127_9)
						arg_124_1:RecordAudio("325591030", var_127_9)
					else
						arg_124_1:AudioAction("play", "voice", "story_v_out_325591", "325591030", "story_v_out_325591.awb")
					end

					arg_124_1:RecordHistoryTalkVoice("story_v_out_325591", "325591030", "story_v_out_325591.awb")
				end

				arg_124_1:RecordContent(arg_124_1.text_.text)
			end

			local var_127_10 = math.max(var_127_1, arg_124_1.talkMaxDuration)

			if var_127_0 <= arg_124_1.time_ and arg_124_1.time_ < var_127_0 + var_127_10 then
				arg_124_1.typewritter.percent = (arg_124_1.time_ - var_127_0) / var_127_10

				arg_124_1.typewritter:SetDirty()
			end

			if arg_124_1.time_ >= var_127_0 + var_127_10 and arg_124_1.time_ < var_127_0 + var_127_10 + arg_127_0 then
				arg_124_1.typewritter.percent = 1

				arg_124_1.typewritter:SetDirty()
				arg_124_1:ShowNextGo(true)
			end
		end

		arg_124_1.nodeConfigList_ = {}

		arg_124_1:InitPlayNodeList()
	end,
	Play325591031 = function(arg_128_0, arg_128_1)
		arg_128_1.time_ = 0
		arg_128_1.frameCnt_ = 0
		arg_128_1.state_ = "playing"
		arg_128_1.curTalkId_ = 325591031
		arg_128_1.duration_ = 6.77

		local var_128_0 = {
			zh = 5.1,
			ja = 6.766
		}
		local var_128_1 = manager.audio:GetLocalizationFlag()

		if var_128_0[var_128_1] ~= nil then
			arg_128_1.duration_ = var_128_0[var_128_1]
		end

		SetActive(arg_128_1.tipsGo_, false)

		function arg_128_1.onSingleLineFinish_()
			arg_128_1.onSingleLineUpdate_ = nil
			arg_128_1.onSingleLineFinish_ = nil
			arg_128_1.state_ = "waiting"
		end

		function arg_128_1.playNext_(arg_130_0)
			if arg_130_0 == 1 then
				arg_128_0:Play325591032(arg_128_1)
			end
		end

		function arg_128_1.onSingleLineUpdate_(arg_131_0)
			local var_131_0 = arg_128_1.actors_["6148ui_story"]
			local var_131_1 = 0

			if var_131_1 < arg_128_1.time_ and arg_128_1.time_ <= var_131_1 + arg_131_0 and not isNil(var_131_0) and arg_128_1.var_.characterEffect6148ui_story == nil then
				arg_128_1.var_.characterEffect6148ui_story = var_131_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_131_2 = 0.200000002980232

			if var_131_1 <= arg_128_1.time_ and arg_128_1.time_ < var_131_1 + var_131_2 and not isNil(var_131_0) then
				local var_131_3 = (arg_128_1.time_ - var_131_1) / var_131_2

				if arg_128_1.var_.characterEffect6148ui_story and not isNil(var_131_0) then
					arg_128_1.var_.characterEffect6148ui_story.fillFlat = false
				end
			end

			if arg_128_1.time_ >= var_131_1 + var_131_2 and arg_128_1.time_ < var_131_1 + var_131_2 + arg_131_0 and not isNil(var_131_0) and arg_128_1.var_.characterEffect6148ui_story then
				arg_128_1.var_.characterEffect6148ui_story.fillFlat = false
			end

			local var_131_4 = arg_128_1.actors_["1054ui_story"]
			local var_131_5 = 0

			if var_131_5 < arg_128_1.time_ and arg_128_1.time_ <= var_131_5 + arg_131_0 and not isNil(var_131_4) and arg_128_1.var_.characterEffect1054ui_story == nil then
				arg_128_1.var_.characterEffect1054ui_story = var_131_4:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_131_6 = 0.200000002980232

			if var_131_5 <= arg_128_1.time_ and arg_128_1.time_ < var_131_5 + var_131_6 and not isNil(var_131_4) then
				local var_131_7 = (arg_128_1.time_ - var_131_5) / var_131_6

				if arg_128_1.var_.characterEffect1054ui_story and not isNil(var_131_4) then
					local var_131_8 = Mathf.Lerp(0, 0.5, var_131_7)

					arg_128_1.var_.characterEffect1054ui_story.fillFlat = true
					arg_128_1.var_.characterEffect1054ui_story.fillRatio = var_131_8
				end
			end

			if arg_128_1.time_ >= var_131_5 + var_131_6 and arg_128_1.time_ < var_131_5 + var_131_6 + arg_131_0 and not isNil(var_131_4) and arg_128_1.var_.characterEffect1054ui_story then
				local var_131_9 = 0.5

				arg_128_1.var_.characterEffect1054ui_story.fillFlat = true
				arg_128_1.var_.characterEffect1054ui_story.fillRatio = var_131_9
			end

			local var_131_10 = 0
			local var_131_11 = 0.525

			if var_131_10 < arg_128_1.time_ and arg_128_1.time_ <= var_131_10 + arg_131_0 then
				arg_128_1.talkMaxDuration = 0
				arg_128_1.dialogCg_.alpha = 1

				arg_128_1.dialog_:SetActive(true)
				SetActive(arg_128_1.leftNameGo_, true)

				local var_131_12 = arg_128_1:FormatText(StoryNameCfg[1488].name)

				arg_128_1.leftNameTxt_.text = var_131_12

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_128_1.leftNameTxt_.transform)

				arg_128_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_128_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_128_1:RecordName(arg_128_1.leftNameTxt_.text)
				SetActive(arg_128_1.iconTrs_.gameObject, false)
				arg_128_1.callingController_:SetSelectedState("normal")

				local var_131_13 = arg_128_1:GetWordFromCfg(325591031)
				local var_131_14 = arg_128_1:FormatText(var_131_13.content)

				arg_128_1.text_.text = var_131_14

				LuaForUtil.ClearLinePrefixSymbol(arg_128_1.text_)

				local var_131_15 = 21
				local var_131_16 = utf8.len(var_131_14)
				local var_131_17 = var_131_15 <= 0 and var_131_11 or var_131_11 * (var_131_16 / var_131_15)

				if var_131_17 > 0 and var_131_11 < var_131_17 then
					arg_128_1.talkMaxDuration = var_131_17

					if var_131_17 + var_131_10 > arg_128_1.duration_ then
						arg_128_1.duration_ = var_131_17 + var_131_10
					end
				end

				arg_128_1.text_.text = var_131_14
				arg_128_1.typewritter.percent = 0

				arg_128_1.typewritter:SetDirty()
				arg_128_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_325591", "325591031", "story_v_out_325591.awb") ~= 0 then
					local var_131_18 = manager.audio:GetVoiceLength("story_v_out_325591", "325591031", "story_v_out_325591.awb") / 1000

					if var_131_18 + var_131_10 > arg_128_1.duration_ then
						arg_128_1.duration_ = var_131_18 + var_131_10
					end

					if var_131_13.prefab_name ~= "" and arg_128_1.actors_[var_131_13.prefab_name] ~= nil then
						local var_131_19 = LuaForUtil.PlayVoiceWithCriLipsync(arg_128_1.actors_[var_131_13.prefab_name].transform, "story_v_out_325591", "325591031", "story_v_out_325591.awb")

						arg_128_1:RecordAudio("325591031", var_131_19)
						arg_128_1:RecordAudio("325591031", var_131_19)
					else
						arg_128_1:AudioAction("play", "voice", "story_v_out_325591", "325591031", "story_v_out_325591.awb")
					end

					arg_128_1:RecordHistoryTalkVoice("story_v_out_325591", "325591031", "story_v_out_325591.awb")
				end

				arg_128_1:RecordContent(arg_128_1.text_.text)
			end

			local var_131_20 = math.max(var_131_11, arg_128_1.talkMaxDuration)

			if var_131_10 <= arg_128_1.time_ and arg_128_1.time_ < var_131_10 + var_131_20 then
				arg_128_1.typewritter.percent = (arg_128_1.time_ - var_131_10) / var_131_20

				arg_128_1.typewritter:SetDirty()
			end

			if arg_128_1.time_ >= var_131_10 + var_131_20 and arg_128_1.time_ < var_131_10 + var_131_20 + arg_131_0 then
				arg_128_1.typewritter.percent = 1

				arg_128_1.typewritter:SetDirty()
				arg_128_1:ShowNextGo(true)
			end
		end

		arg_128_1.nodeConfigList_ = {}

		arg_128_1:InitPlayNodeList()
	end,
	Play325591032 = function(arg_132_0, arg_132_1)
		arg_132_1.time_ = 0
		arg_132_1.frameCnt_ = 0
		arg_132_1.state_ = "playing"
		arg_132_1.curTalkId_ = 325591032
		arg_132_1.duration_ = 2.47

		local var_132_0 = {
			zh = 1.999999999999,
			ja = 2.466
		}
		local var_132_1 = manager.audio:GetLocalizationFlag()

		if var_132_0[var_132_1] ~= nil then
			arg_132_1.duration_ = var_132_0[var_132_1]
		end

		SetActive(arg_132_1.tipsGo_, false)

		function arg_132_1.onSingleLineFinish_()
			arg_132_1.onSingleLineUpdate_ = nil
			arg_132_1.onSingleLineFinish_ = nil
			arg_132_1.state_ = "waiting"
		end

		function arg_132_1.playNext_(arg_134_0)
			if arg_134_0 == 1 then
				arg_132_0:Play325591033(arg_132_1)
			end
		end

		function arg_132_1.onSingleLineUpdate_(arg_135_0)
			local var_135_0 = arg_132_1.actors_["6148ui_story"]
			local var_135_1 = 0

			if var_135_1 < arg_132_1.time_ and arg_132_1.time_ <= var_135_1 + arg_135_0 and not isNil(var_135_0) and arg_132_1.var_.characterEffect6148ui_story == nil then
				arg_132_1.var_.characterEffect6148ui_story = var_135_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_135_2 = 0.200000002980232

			if var_135_1 <= arg_132_1.time_ and arg_132_1.time_ < var_135_1 + var_135_2 and not isNil(var_135_0) then
				local var_135_3 = (arg_132_1.time_ - var_135_1) / var_135_2

				if arg_132_1.var_.characterEffect6148ui_story and not isNil(var_135_0) then
					arg_132_1.var_.characterEffect6148ui_story.fillFlat = false
				end
			end

			if arg_132_1.time_ >= var_135_1 + var_135_2 and arg_132_1.time_ < var_135_1 + var_135_2 + arg_135_0 and not isNil(var_135_0) and arg_132_1.var_.characterEffect6148ui_story then
				arg_132_1.var_.characterEffect6148ui_story.fillFlat = false
			end

			local var_135_4 = 0

			if var_135_4 < arg_132_1.time_ and arg_132_1.time_ <= var_135_4 + arg_135_0 then
				arg_132_1:PlayTimeline("6148ui_story", "StoryTimeline/CharAction/story6148/story6148action/6148action6_2")
			end

			local var_135_5 = 0

			if var_135_5 < arg_132_1.time_ and arg_132_1.time_ <= var_135_5 + arg_135_0 then
				arg_132_1:PlayTimeline("6148ui_story", "StoryTimeline/CharAction/public_expression/expr_youyu", "EmotionTimelineAnimator")
			end

			local var_135_6 = 0

			if var_135_6 < arg_132_1.time_ and arg_132_1.time_ <= var_135_6 + arg_135_0 then
				arg_132_1:PlayTimeline("1054ui_story", "StoryTimeline/CharAction/story1054/story1054action/1054action2_1")
			end

			local var_135_7 = 0

			if var_135_7 < arg_132_1.time_ and arg_132_1.time_ <= var_135_7 + arg_135_0 then
				arg_132_1:PlayTimeline("1054ui_story", "StoryTimeline/CharAction/public_expression/expr_zhushiA", "EmotionTimelineAnimator")
			end

			local var_135_8 = arg_132_1.actors_["1054ui_story"]
			local var_135_9 = 0

			if var_135_9 < arg_132_1.time_ and arg_132_1.time_ <= var_135_9 + arg_135_0 and not isNil(var_135_8) and arg_132_1.var_.characterEffect1054ui_story == nil then
				arg_132_1.var_.characterEffect1054ui_story = var_135_8:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_135_10 = 0.200000002980232

			if var_135_9 <= arg_132_1.time_ and arg_132_1.time_ < var_135_9 + var_135_10 and not isNil(var_135_8) then
				local var_135_11 = (arg_132_1.time_ - var_135_9) / var_135_10

				if arg_132_1.var_.characterEffect1054ui_story and not isNil(var_135_8) then
					arg_132_1.var_.characterEffect1054ui_story.fillFlat = false
				end
			end

			if arg_132_1.time_ >= var_135_9 + var_135_10 and arg_132_1.time_ < var_135_9 + var_135_10 + arg_135_0 and not isNil(var_135_8) and arg_132_1.var_.characterEffect1054ui_story then
				arg_132_1.var_.characterEffect1054ui_story.fillFlat = false
			end

			local var_135_12 = 0
			local var_135_13 = 0.15

			if var_135_12 < arg_132_1.time_ and arg_132_1.time_ <= var_135_12 + arg_135_0 then
				arg_132_1.talkMaxDuration = 0
				arg_132_1.dialogCg_.alpha = 1

				arg_132_1.dialog_:SetActive(true)
				SetActive(arg_132_1.leftNameGo_, true)

				local var_135_14 = arg_132_1:FormatText(StoryNameCfg[1489].name)

				arg_132_1.leftNameTxt_.text = var_135_14

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_132_1.leftNameTxt_.transform)

				arg_132_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_132_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_132_1:RecordName(arg_132_1.leftNameTxt_.text)
				SetActive(arg_132_1.iconTrs_.gameObject, false)
				arg_132_1.callingController_:SetSelectedState("normal")

				local var_135_15 = arg_132_1:GetWordFromCfg(325591032)
				local var_135_16 = arg_132_1:FormatText(var_135_15.content)

				arg_132_1.text_.text = var_135_16

				LuaForUtil.ClearLinePrefixSymbol(arg_132_1.text_)

				local var_135_17 = 6
				local var_135_18 = utf8.len(var_135_16)
				local var_135_19 = var_135_17 <= 0 and var_135_13 or var_135_13 * (var_135_18 / var_135_17)

				if var_135_19 > 0 and var_135_13 < var_135_19 then
					arg_132_1.talkMaxDuration = var_135_19

					if var_135_19 + var_135_12 > arg_132_1.duration_ then
						arg_132_1.duration_ = var_135_19 + var_135_12
					end
				end

				arg_132_1.text_.text = var_135_16
				arg_132_1.typewritter.percent = 0

				arg_132_1.typewritter:SetDirty()
				arg_132_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_325591", "325591032", "story_v_out_325591.awb") ~= 0 then
					local var_135_20 = manager.audio:GetVoiceLength("story_v_out_325591", "325591032", "story_v_out_325591.awb") / 1000

					if var_135_20 + var_135_12 > arg_132_1.duration_ then
						arg_132_1.duration_ = var_135_20 + var_135_12
					end

					if var_135_15.prefab_name ~= "" and arg_132_1.actors_[var_135_15.prefab_name] ~= nil then
						local var_135_21 = LuaForUtil.PlayVoiceWithCriLipsync(arg_132_1.actors_[var_135_15.prefab_name].transform, "story_v_out_325591", "325591032", "story_v_out_325591.awb")

						arg_132_1:RecordAudio("325591032", var_135_21)
						arg_132_1:RecordAudio("325591032", var_135_21)
					else
						arg_132_1:AudioAction("play", "voice", "story_v_out_325591", "325591032", "story_v_out_325591.awb")
					end

					arg_132_1:RecordHistoryTalkVoice("story_v_out_325591", "325591032", "story_v_out_325591.awb")
				end

				arg_132_1:RecordContent(arg_132_1.text_.text)
			end

			local var_135_22 = math.max(var_135_13, arg_132_1.talkMaxDuration)

			if var_135_12 <= arg_132_1.time_ and arg_132_1.time_ < var_135_12 + var_135_22 then
				arg_132_1.typewritter.percent = (arg_132_1.time_ - var_135_12) / var_135_22

				arg_132_1.typewritter:SetDirty()
			end

			if arg_132_1.time_ >= var_135_12 + var_135_22 and arg_132_1.time_ < var_135_12 + var_135_22 + arg_135_0 then
				arg_132_1.typewritter.percent = 1

				arg_132_1.typewritter:SetDirty()
				arg_132_1:ShowNextGo(true)
			end
		end

		arg_132_1.nodeConfigList_ = {}

		arg_132_1:InitPlayNodeList()
	end,
	Play325591033 = function(arg_136_0, arg_136_1)
		arg_136_1.time_ = 0
		arg_136_1.frameCnt_ = 0
		arg_136_1.state_ = "playing"
		arg_136_1.curTalkId_ = 325591033
		arg_136_1.duration_ = 5

		SetActive(arg_136_1.tipsGo_, false)

		function arg_136_1.onSingleLineFinish_()
			arg_136_1.onSingleLineUpdate_ = nil
			arg_136_1.onSingleLineFinish_ = nil
			arg_136_1.state_ = "waiting"
		end

		function arg_136_1.playNext_(arg_138_0)
			if arg_138_0 == 1 then
				arg_136_0:Play325591034(arg_136_1)
			end
		end

		function arg_136_1.onSingleLineUpdate_(arg_139_0)
			local var_139_0 = arg_136_1.actors_["6148ui_story"].transform
			local var_139_1 = 0

			if var_139_1 < arg_136_1.time_ and arg_136_1.time_ <= var_139_1 + arg_139_0 then
				arg_136_1.var_.moveOldPos6148ui_story = var_139_0.localPosition

				local var_139_2 = GameObjectTools.GetOrAddComponent(var_139_0.gameObject, typeof(DynamicBoneHelper))

				if var_139_2 then
					var_139_2:EnableDynamicBone(false)
				end
			end

			local var_139_3 = 0.001

			if var_139_1 <= arg_136_1.time_ and arg_136_1.time_ < var_139_1 + var_139_3 then
				local var_139_4 = (arg_136_1.time_ - var_139_1) / var_139_3
				local var_139_5 = Vector3.New(0, 100, 0)

				var_139_0.localPosition = Vector3.Lerp(arg_136_1.var_.moveOldPos6148ui_story, var_139_5, var_139_4)

				local var_139_6 = manager.ui.mainCamera.transform.position - var_139_0.position

				var_139_0.forward = Vector3.New(var_139_6.x, var_139_6.y, var_139_6.z)

				local var_139_7 = var_139_0.localEulerAngles

				var_139_7.z = 0
				var_139_7.x = 0
				var_139_0.localEulerAngles = var_139_7
			end

			if arg_136_1.time_ >= var_139_1 + var_139_3 and arg_136_1.time_ < var_139_1 + var_139_3 + arg_139_0 then
				var_139_0.localPosition = Vector3.New(0, 100, 0)

				local var_139_8 = manager.ui.mainCamera.transform.position - var_139_0.position

				var_139_0.forward = Vector3.New(var_139_8.x, var_139_8.y, var_139_8.z)

				local var_139_9 = var_139_0.localEulerAngles

				var_139_9.z = 0
				var_139_9.x = 0
				var_139_0.localEulerAngles = var_139_9

				local var_139_10 = GameObjectTools.GetOrAddComponent(var_139_0.gameObject, typeof(DynamicBoneHelper))

				if var_139_10 then
					var_139_10:EnableDynamicBone(true)
				end
			end

			local var_139_11 = arg_136_1.actors_["1054ui_story"].transform
			local var_139_12 = 0

			if var_139_12 < arg_136_1.time_ and arg_136_1.time_ <= var_139_12 + arg_139_0 then
				arg_136_1.var_.moveOldPos1054ui_story = var_139_11.localPosition

				local var_139_13 = GameObjectTools.GetOrAddComponent(var_139_11.gameObject, typeof(DynamicBoneHelper))

				if var_139_13 then
					var_139_13:EnableDynamicBone(false)
				end
			end

			local var_139_14 = 0.001

			if var_139_12 <= arg_136_1.time_ and arg_136_1.time_ < var_139_12 + var_139_14 then
				local var_139_15 = (arg_136_1.time_ - var_139_12) / var_139_14
				local var_139_16 = Vector3.New(0, 100, 0)

				var_139_11.localPosition = Vector3.Lerp(arg_136_1.var_.moveOldPos1054ui_story, var_139_16, var_139_15)

				local var_139_17 = manager.ui.mainCamera.transform.position - var_139_11.position

				var_139_11.forward = Vector3.New(var_139_17.x, var_139_17.y, var_139_17.z)

				local var_139_18 = var_139_11.localEulerAngles

				var_139_18.z = 0
				var_139_18.x = 0
				var_139_11.localEulerAngles = var_139_18
			end

			if arg_136_1.time_ >= var_139_12 + var_139_14 and arg_136_1.time_ < var_139_12 + var_139_14 + arg_139_0 then
				var_139_11.localPosition = Vector3.New(0, 100, 0)

				local var_139_19 = manager.ui.mainCamera.transform.position - var_139_11.position

				var_139_11.forward = Vector3.New(var_139_19.x, var_139_19.y, var_139_19.z)

				local var_139_20 = var_139_11.localEulerAngles

				var_139_20.z = 0
				var_139_20.x = 0
				var_139_11.localEulerAngles = var_139_20

				local var_139_21 = GameObjectTools.GetOrAddComponent(var_139_11.gameObject, typeof(DynamicBoneHelper))

				if var_139_21 then
					var_139_21:EnableDynamicBone(true)
				end
			end

			local var_139_22 = 0
			local var_139_23 = 0.875

			if var_139_22 < arg_136_1.time_ and arg_136_1.time_ <= var_139_22 + arg_139_0 then
				arg_136_1.talkMaxDuration = 0
				arg_136_1.dialogCg_.alpha = 1

				arg_136_1.dialog_:SetActive(true)
				SetActive(arg_136_1.leftNameGo_, false)

				arg_136_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_136_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_136_1:RecordName(arg_136_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_136_1.iconTrs_.gameObject, false)
				arg_136_1.callingController_:SetSelectedState("normal")

				local var_139_24 = arg_136_1:GetWordFromCfg(325591033)
				local var_139_25 = arg_136_1:FormatText(var_139_24.content)

				arg_136_1.text_.text = var_139_25

				LuaForUtil.ClearLinePrefixSymbol(arg_136_1.text_)

				local var_139_26 = 35
				local var_139_27 = utf8.len(var_139_25)
				local var_139_28 = var_139_26 <= 0 and var_139_23 or var_139_23 * (var_139_27 / var_139_26)

				if var_139_28 > 0 and var_139_23 < var_139_28 then
					arg_136_1.talkMaxDuration = var_139_28

					if var_139_28 + var_139_22 > arg_136_1.duration_ then
						arg_136_1.duration_ = var_139_28 + var_139_22
					end
				end

				arg_136_1.text_.text = var_139_25
				arg_136_1.typewritter.percent = 0

				arg_136_1.typewritter:SetDirty()
				arg_136_1:ShowNextGo(false)
				arg_136_1:RecordContent(arg_136_1.text_.text)
			end

			local var_139_29 = math.max(var_139_23, arg_136_1.talkMaxDuration)

			if var_139_22 <= arg_136_1.time_ and arg_136_1.time_ < var_139_22 + var_139_29 then
				arg_136_1.typewritter.percent = (arg_136_1.time_ - var_139_22) / var_139_29

				arg_136_1.typewritter:SetDirty()
			end

			if arg_136_1.time_ >= var_139_22 + var_139_29 and arg_136_1.time_ < var_139_22 + var_139_29 + arg_139_0 then
				arg_136_1.typewritter.percent = 1

				arg_136_1.typewritter:SetDirty()
				arg_136_1:ShowNextGo(true)
			end
		end

		arg_136_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "6148ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1054ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_136_1:InitPlayNodeList()
	end,
	Play325591034 = function(arg_140_0, arg_140_1)
		arg_140_1.time_ = 0
		arg_140_1.frameCnt_ = 0
		arg_140_1.state_ = "playing"
		arg_140_1.curTalkId_ = 325591034
		arg_140_1.duration_ = 9

		SetActive(arg_140_1.tipsGo_, false)

		function arg_140_1.onSingleLineFinish_()
			arg_140_1.onSingleLineUpdate_ = nil
			arg_140_1.onSingleLineFinish_ = nil
			arg_140_1.state_ = "waiting"
		end

		function arg_140_1.playNext_(arg_142_0)
			if arg_142_0 == 1 then
				arg_140_0:Play325591035(arg_140_1)
			end
		end

		function arg_140_1.onSingleLineUpdate_(arg_143_0)
			local var_143_0 = 1.999999999999

			if var_143_0 < arg_140_1.time_ and arg_140_1.time_ <= var_143_0 + arg_143_0 then
				local var_143_1 = manager.ui.mainCamera.transform.localPosition
				local var_143_2 = Vector3.New(0, 0, 10) + Vector3.New(var_143_1.x, var_143_1.y, 0)
				local var_143_3 = arg_140_1.bgs_.J28h

				var_143_3.transform.localPosition = var_143_2
				var_143_3.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_143_4 = var_143_3:GetComponent("SpriteRenderer")

				if var_143_4 and var_143_4.sprite then
					local var_143_5 = (var_143_3.transform.localPosition - var_143_1).z
					local var_143_6 = manager.ui.mainCameraCom_
					local var_143_7 = 2 * var_143_5 * Mathf.Tan(var_143_6.fieldOfView * 0.5 * Mathf.Deg2Rad)
					local var_143_8 = var_143_7 * var_143_6.aspect
					local var_143_9 = var_143_4.sprite.bounds.size.x
					local var_143_10 = var_143_4.sprite.bounds.size.y
					local var_143_11 = var_143_8 / var_143_9
					local var_143_12 = var_143_7 / var_143_10
					local var_143_13 = var_143_12 < var_143_11 and var_143_11 or var_143_12

					var_143_3.transform.localScale = Vector3.New(var_143_13, var_143_13, 0)
				end

				for iter_143_0, iter_143_1 in pairs(arg_140_1.bgs_) do
					if iter_143_0 ~= "J28h" then
						iter_143_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_143_14 = 3.999999999999

			if var_143_14 < arg_140_1.time_ and arg_140_1.time_ <= var_143_14 + arg_143_0 then
				arg_140_1.allBtn_.enabled = false
			end

			local var_143_15 = 0.3

			if arg_140_1.time_ >= var_143_14 + var_143_15 and arg_140_1.time_ < var_143_14 + var_143_15 + arg_143_0 then
				arg_140_1.allBtn_.enabled = true
			end

			local var_143_16 = 0

			if var_143_16 < arg_140_1.time_ and arg_140_1.time_ <= var_143_16 + arg_143_0 then
				arg_140_1.mask_.enabled = true
				arg_140_1.mask_.raycastTarget = true

				arg_140_1:SetGaussion(false)
			end

			local var_143_17 = 2

			if var_143_16 <= arg_140_1.time_ and arg_140_1.time_ < var_143_16 + var_143_17 then
				local var_143_18 = (arg_140_1.time_ - var_143_16) / var_143_17
				local var_143_19 = Color.New(0, 0, 0)

				var_143_19.a = Mathf.Lerp(0, 1, var_143_18)
				arg_140_1.mask_.color = var_143_19
			end

			if arg_140_1.time_ >= var_143_16 + var_143_17 and arg_140_1.time_ < var_143_16 + var_143_17 + arg_143_0 then
				local var_143_20 = Color.New(0, 0, 0)

				var_143_20.a = 1
				arg_140_1.mask_.color = var_143_20
			end

			local var_143_21 = 2

			if var_143_21 < arg_140_1.time_ and arg_140_1.time_ <= var_143_21 + arg_143_0 then
				arg_140_1.mask_.enabled = true
				arg_140_1.mask_.raycastTarget = true

				arg_140_1:SetGaussion(false)
			end

			local var_143_22 = 2

			if var_143_21 <= arg_140_1.time_ and arg_140_1.time_ < var_143_21 + var_143_22 then
				local var_143_23 = (arg_140_1.time_ - var_143_21) / var_143_22
				local var_143_24 = Color.New(0, 0, 0)

				var_143_24.a = Mathf.Lerp(1, 0, var_143_23)
				arg_140_1.mask_.color = var_143_24
			end

			if arg_140_1.time_ >= var_143_21 + var_143_22 and arg_140_1.time_ < var_143_21 + var_143_22 + arg_143_0 then
				local var_143_25 = Color.New(0, 0, 0)
				local var_143_26 = 0

				arg_140_1.mask_.enabled = false
				var_143_25.a = var_143_26
				arg_140_1.mask_.color = var_143_25
			end

			if arg_140_1.frameCnt_ <= 1 then
				arg_140_1.dialog_:SetActive(false)
			end

			local var_143_27 = 3.999999999999
			local var_143_28 = 1.5

			if var_143_27 < arg_140_1.time_ and arg_140_1.time_ <= var_143_27 + arg_143_0 then
				arg_140_1.talkMaxDuration = 0

				arg_140_1.dialog_:SetActive(true)

				arg_140_1.dialogCg_.alpha = 0

				local var_143_29 = LeanTween.value(arg_140_1.dialog_, 0, 1, 0.3)

				var_143_29:setOnUpdate(LuaHelper.FloatAction(function(arg_144_0)
					arg_140_1.dialogCg_.alpha = arg_144_0
				end))
				var_143_29:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_140_1.dialog_)
					var_143_29:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_140_1.duration_ = arg_140_1.duration_ + 0.3

				SetActive(arg_140_1.leftNameGo_, false)

				arg_140_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_140_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_140_1:RecordName(arg_140_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_140_1.iconTrs_.gameObject, false)
				arg_140_1.callingController_:SetSelectedState("normal")

				local var_143_30 = arg_140_1:GetWordFromCfg(325591034)
				local var_143_31 = arg_140_1:FormatText(var_143_30.content)

				arg_140_1.text_.text = var_143_31

				LuaForUtil.ClearLinePrefixSymbol(arg_140_1.text_)

				local var_143_32 = 60
				local var_143_33 = utf8.len(var_143_31)
				local var_143_34 = var_143_32 <= 0 and var_143_28 or var_143_28 * (var_143_33 / var_143_32)

				if var_143_34 > 0 and var_143_28 < var_143_34 then
					arg_140_1.talkMaxDuration = var_143_34
					var_143_27 = var_143_27 + 0.3

					if var_143_34 + var_143_27 > arg_140_1.duration_ then
						arg_140_1.duration_ = var_143_34 + var_143_27
					end
				end

				arg_140_1.text_.text = var_143_31
				arg_140_1.typewritter.percent = 0

				arg_140_1.typewritter:SetDirty()
				arg_140_1:ShowNextGo(false)
				arg_140_1:RecordContent(arg_140_1.text_.text)
			end

			local var_143_35 = var_143_27 + 0.3
			local var_143_36 = math.max(var_143_28, arg_140_1.talkMaxDuration)

			if var_143_35 <= arg_140_1.time_ and arg_140_1.time_ < var_143_35 + var_143_36 then
				arg_140_1.typewritter.percent = (arg_140_1.time_ - var_143_35) / var_143_36

				arg_140_1.typewritter:SetDirty()
			end

			if arg_140_1.time_ >= var_143_35 + var_143_36 and arg_140_1.time_ < var_143_35 + var_143_36 + arg_143_0 then
				arg_140_1.typewritter.percent = 1

				arg_140_1.typewritter:SetDirty()
				arg_140_1:ShowNextGo(true)
			end
		end

		arg_140_1.nodeConfigList_ = {}

		arg_140_1:InitPlayNodeList()
	end,
	Play325591035 = function(arg_146_0, arg_146_1)
		arg_146_1.time_ = 0
		arg_146_1.frameCnt_ = 0
		arg_146_1.state_ = "playing"
		arg_146_1.curTalkId_ = 325591035
		arg_146_1.duration_ = 5

		SetActive(arg_146_1.tipsGo_, false)

		function arg_146_1.onSingleLineFinish_()
			arg_146_1.onSingleLineUpdate_ = nil
			arg_146_1.onSingleLineFinish_ = nil
			arg_146_1.state_ = "waiting"
		end

		function arg_146_1.playNext_(arg_148_0)
			if arg_148_0 == 1 then
				arg_146_0:Play325591036(arg_146_1)
			end
		end

		function arg_146_1.onSingleLineUpdate_(arg_149_0)
			local var_149_0 = 0
			local var_149_1 = 1.65

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

				local var_149_2 = arg_146_1:GetWordFromCfg(325591035)
				local var_149_3 = arg_146_1:FormatText(var_149_2.content)

				arg_146_1.text_.text = var_149_3

				LuaForUtil.ClearLinePrefixSymbol(arg_146_1.text_)

				local var_149_4 = 66
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
	Play325591036 = function(arg_150_0, arg_150_1)
		arg_150_1.time_ = 0
		arg_150_1.frameCnt_ = 0
		arg_150_1.state_ = "playing"
		arg_150_1.curTalkId_ = 325591036
		arg_150_1.duration_ = 5.3

		local var_150_0 = {
			zh = 5.1,
			ja = 5.3
		}
		local var_150_1 = manager.audio:GetLocalizationFlag()

		if var_150_0[var_150_1] ~= nil then
			arg_150_1.duration_ = var_150_0[var_150_1]
		end

		SetActive(arg_150_1.tipsGo_, false)

		function arg_150_1.onSingleLineFinish_()
			arg_150_1.onSingleLineUpdate_ = nil
			arg_150_1.onSingleLineFinish_ = nil
			arg_150_1.state_ = "waiting"
		end

		function arg_150_1.playNext_(arg_152_0)
			if arg_152_0 == 1 then
				arg_150_0:Play325591037(arg_150_1)
			end
		end

		function arg_150_1.onSingleLineUpdate_(arg_153_0)
			local var_153_0 = "10176ui_story"

			if arg_150_1.actors_[var_153_0] == nil then
				local var_153_1 = Asset.Load("Char/" .. "10176ui_story")

				if not isNil(var_153_1) then
					local var_153_2 = Object.Instantiate(Asset.Load("Char/" .. "10176ui_story"), arg_150_1.stage_.transform)

					var_153_2.name = var_153_0
					var_153_2.transform.localPosition = Vector3.New(0, 100, 0)
					arg_150_1.actors_[var_153_0] = var_153_2

					local var_153_3 = var_153_2:GetComponentInChildren(typeof(CharacterEffect))

					var_153_3.enabled = true

					local var_153_4 = GameObjectTools.GetOrAddComponent(var_153_2, typeof(DynamicBoneHelper))

					if var_153_4 then
						var_153_4:EnableDynamicBone(false)
					end

					arg_150_1:ShowWeapon(var_153_3.transform, false)

					arg_150_1.var_[var_153_0 .. "Animator"] = var_153_3.gameObject:GetComponent(typeof(UnityEngine.Animator))
					arg_150_1.var_[var_153_0 .. "Animator"].applyRootMotion = true
					arg_150_1.var_[var_153_0 .. "LipSync"] = var_153_3.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
				end
			end

			local var_153_5 = arg_150_1.actors_["10176ui_story"].transform
			local var_153_6 = 0

			if var_153_6 < arg_150_1.time_ and arg_150_1.time_ <= var_153_6 + arg_153_0 then
				arg_150_1.var_.moveOldPos10176ui_story = var_153_5.localPosition

				local var_153_7 = GameObjectTools.GetOrAddComponent(var_153_5.gameObject, typeof(DynamicBoneHelper))

				if var_153_7 then
					var_153_7:EnableDynamicBone(false)
				end
			end

			local var_153_8 = 0.001

			if var_153_6 <= arg_150_1.time_ and arg_150_1.time_ < var_153_6 + var_153_8 then
				local var_153_9 = (arg_150_1.time_ - var_153_6) / var_153_8
				local var_153_10 = Vector3.New(-0.02, -1.09, -6.12)

				var_153_5.localPosition = Vector3.Lerp(arg_150_1.var_.moveOldPos10176ui_story, var_153_10, var_153_9)

				local var_153_11 = manager.ui.mainCamera.transform.position - var_153_5.position

				var_153_5.forward = Vector3.New(var_153_11.x, var_153_11.y, var_153_11.z)

				local var_153_12 = var_153_5.localEulerAngles

				var_153_12.z = 0
				var_153_12.x = 0
				var_153_5.localEulerAngles = var_153_12
			end

			if arg_150_1.time_ >= var_153_6 + var_153_8 and arg_150_1.time_ < var_153_6 + var_153_8 + arg_153_0 then
				var_153_5.localPosition = Vector3.New(-0.02, -1.09, -6.12)

				local var_153_13 = manager.ui.mainCamera.transform.position - var_153_5.position

				var_153_5.forward = Vector3.New(var_153_13.x, var_153_13.y, var_153_13.z)

				local var_153_14 = var_153_5.localEulerAngles

				var_153_14.z = 0
				var_153_14.x = 0
				var_153_5.localEulerAngles = var_153_14

				local var_153_15 = GameObjectTools.GetOrAddComponent(var_153_5.gameObject, typeof(DynamicBoneHelper))

				if var_153_15 then
					var_153_15:EnableDynamicBone(true)
				end
			end

			local var_153_16 = arg_150_1.actors_["10176ui_story"]
			local var_153_17 = 0

			if var_153_17 < arg_150_1.time_ and arg_150_1.time_ <= var_153_17 + arg_153_0 and not isNil(var_153_16) and arg_150_1.var_.characterEffect10176ui_story == nil then
				arg_150_1.var_.characterEffect10176ui_story = var_153_16:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_153_18 = 0.200000002980232

			if var_153_17 <= arg_150_1.time_ and arg_150_1.time_ < var_153_17 + var_153_18 and not isNil(var_153_16) then
				local var_153_19 = (arg_150_1.time_ - var_153_17) / var_153_18

				if arg_150_1.var_.characterEffect10176ui_story and not isNil(var_153_16) then
					arg_150_1.var_.characterEffect10176ui_story.fillFlat = false
				end
			end

			if arg_150_1.time_ >= var_153_17 + var_153_18 and arg_150_1.time_ < var_153_17 + var_153_18 + arg_153_0 and not isNil(var_153_16) and arg_150_1.var_.characterEffect10176ui_story then
				arg_150_1.var_.characterEffect10176ui_story.fillFlat = false
			end

			local var_153_20 = 0

			if var_153_20 < arg_150_1.time_ and arg_150_1.time_ <= var_153_20 + arg_153_0 then
				arg_150_1:PlayTimeline("10176ui_story", "StoryTimeline/CharAction/story10176/story10176action/10176action2_1")
			end

			local var_153_21 = 0

			if var_153_21 < arg_150_1.time_ and arg_150_1.time_ <= var_153_21 + arg_153_0 then
				arg_150_1:PlayTimeline("10176ui_story", "StoryTimeline/CharAction/public_expression/expr_nanguoC", "EmotionTimelineAnimator")
			end

			local var_153_22 = 0
			local var_153_23 = 0.5

			if var_153_22 < arg_150_1.time_ and arg_150_1.time_ <= var_153_22 + arg_153_0 then
				arg_150_1.talkMaxDuration = 0
				arg_150_1.dialogCg_.alpha = 1

				arg_150_1.dialog_:SetActive(true)
				SetActive(arg_150_1.leftNameGo_, true)

				local var_153_24 = arg_150_1:FormatText(StoryNameCfg[1510].name)

				arg_150_1.leftNameTxt_.text = var_153_24

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_150_1.leftNameTxt_.transform)

				arg_150_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_150_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_150_1:RecordName(arg_150_1.leftNameTxt_.text)
				SetActive(arg_150_1.iconTrs_.gameObject, false)
				arg_150_1.callingController_:SetSelectedState("normal")

				local var_153_25 = arg_150_1:GetWordFromCfg(325591036)
				local var_153_26 = arg_150_1:FormatText(var_153_25.content)

				arg_150_1.text_.text = var_153_26

				LuaForUtil.ClearLinePrefixSymbol(arg_150_1.text_)

				local var_153_27 = 20
				local var_153_28 = utf8.len(var_153_26)
				local var_153_29 = var_153_27 <= 0 and var_153_23 or var_153_23 * (var_153_28 / var_153_27)

				if var_153_29 > 0 and var_153_23 < var_153_29 then
					arg_150_1.talkMaxDuration = var_153_29

					if var_153_29 + var_153_22 > arg_150_1.duration_ then
						arg_150_1.duration_ = var_153_29 + var_153_22
					end
				end

				arg_150_1.text_.text = var_153_26
				arg_150_1.typewritter.percent = 0

				arg_150_1.typewritter:SetDirty()
				arg_150_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_325591", "325591036", "story_v_out_325591.awb") ~= 0 then
					local var_153_30 = manager.audio:GetVoiceLength("story_v_out_325591", "325591036", "story_v_out_325591.awb") / 1000

					if var_153_30 + var_153_22 > arg_150_1.duration_ then
						arg_150_1.duration_ = var_153_30 + var_153_22
					end

					if var_153_25.prefab_name ~= "" and arg_150_1.actors_[var_153_25.prefab_name] ~= nil then
						local var_153_31 = LuaForUtil.PlayVoiceWithCriLipsync(arg_150_1.actors_[var_153_25.prefab_name].transform, "story_v_out_325591", "325591036", "story_v_out_325591.awb")

						arg_150_1:RecordAudio("325591036", var_153_31)
						arg_150_1:RecordAudio("325591036", var_153_31)
					else
						arg_150_1:AudioAction("play", "voice", "story_v_out_325591", "325591036", "story_v_out_325591.awb")
					end

					arg_150_1:RecordHistoryTalkVoice("story_v_out_325591", "325591036", "story_v_out_325591.awb")
				end

				arg_150_1:RecordContent(arg_150_1.text_.text)
			end

			local var_153_32 = math.max(var_153_23, arg_150_1.talkMaxDuration)

			if var_153_22 <= arg_150_1.time_ and arg_150_1.time_ < var_153_22 + var_153_32 then
				arg_150_1.typewritter.percent = (arg_150_1.time_ - var_153_22) / var_153_32

				arg_150_1.typewritter:SetDirty()
			end

			if arg_150_1.time_ >= var_153_22 + var_153_32 and arg_150_1.time_ < var_153_22 + var_153_32 + arg_153_0 then
				arg_150_1.typewritter.percent = 1

				arg_150_1.typewritter:SetDirty()
				arg_150_1:ShowNextGo(true)
			end
		end

		arg_150_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10176ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_150_1:InitPlayNodeList()
	end,
	Play325591037 = function(arg_154_0, arg_154_1)
		arg_154_1.time_ = 0
		arg_154_1.frameCnt_ = 0
		arg_154_1.state_ = "playing"
		arg_154_1.curTalkId_ = 325591037
		arg_154_1.duration_ = 5.97

		local var_154_0 = {
			zh = 3.566,
			ja = 5.966
		}
		local var_154_1 = manager.audio:GetLocalizationFlag()

		if var_154_0[var_154_1] ~= nil then
			arg_154_1.duration_ = var_154_0[var_154_1]
		end

		SetActive(arg_154_1.tipsGo_, false)

		function arg_154_1.onSingleLineFinish_()
			arg_154_1.onSingleLineUpdate_ = nil
			arg_154_1.onSingleLineFinish_ = nil
			arg_154_1.state_ = "waiting"
		end

		function arg_154_1.playNext_(arg_156_0)
			if arg_156_0 == 1 then
				arg_154_0:Play325591038(arg_154_1)
			end
		end

		function arg_154_1.onSingleLineUpdate_(arg_157_0)
			local var_157_0 = arg_154_1.actors_["10176ui_story"]
			local var_157_1 = 0

			if var_157_1 < arg_154_1.time_ and arg_154_1.time_ <= var_157_1 + arg_157_0 and not isNil(var_157_0) and arg_154_1.var_.characterEffect10176ui_story == nil then
				arg_154_1.var_.characterEffect10176ui_story = var_157_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_157_2 = 0.200000002980232

			if var_157_1 <= arg_154_1.time_ and arg_154_1.time_ < var_157_1 + var_157_2 and not isNil(var_157_0) then
				local var_157_3 = (arg_154_1.time_ - var_157_1) / var_157_2

				if arg_154_1.var_.characterEffect10176ui_story and not isNil(var_157_0) then
					local var_157_4 = Mathf.Lerp(0, 0.5, var_157_3)

					arg_154_1.var_.characterEffect10176ui_story.fillFlat = true
					arg_154_1.var_.characterEffect10176ui_story.fillRatio = var_157_4
				end
			end

			if arg_154_1.time_ >= var_157_1 + var_157_2 and arg_154_1.time_ < var_157_1 + var_157_2 + arg_157_0 and not isNil(var_157_0) and arg_154_1.var_.characterEffect10176ui_story then
				local var_157_5 = 0.5

				arg_154_1.var_.characterEffect10176ui_story.fillFlat = true
				arg_154_1.var_.characterEffect10176ui_story.fillRatio = var_157_5
			end

			local var_157_6 = 0
			local var_157_7 = 0.4

			if var_157_6 < arg_154_1.time_ and arg_154_1.time_ <= var_157_6 + arg_157_0 then
				arg_154_1.talkMaxDuration = 0
				arg_154_1.dialogCg_.alpha = 1

				arg_154_1.dialog_:SetActive(true)
				SetActive(arg_154_1.leftNameGo_, true)

				local var_157_8 = arg_154_1:FormatText(StoryNameCfg[1489].name)

				arg_154_1.leftNameTxt_.text = var_157_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_154_1.leftNameTxt_.transform)

				arg_154_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_154_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_154_1:RecordName(arg_154_1.leftNameTxt_.text)
				SetActive(arg_154_1.iconTrs_.gameObject, false)
				arg_154_1.callingController_:SetSelectedState("normal")

				local var_157_9 = arg_154_1:GetWordFromCfg(325591037)
				local var_157_10 = arg_154_1:FormatText(var_157_9.content)

				arg_154_1.text_.text = var_157_10

				LuaForUtil.ClearLinePrefixSymbol(arg_154_1.text_)

				local var_157_11 = 16
				local var_157_12 = utf8.len(var_157_10)
				local var_157_13 = var_157_11 <= 0 and var_157_7 or var_157_7 * (var_157_12 / var_157_11)

				if var_157_13 > 0 and var_157_7 < var_157_13 then
					arg_154_1.talkMaxDuration = var_157_13

					if var_157_13 + var_157_6 > arg_154_1.duration_ then
						arg_154_1.duration_ = var_157_13 + var_157_6
					end
				end

				arg_154_1.text_.text = var_157_10
				arg_154_1.typewritter.percent = 0

				arg_154_1.typewritter:SetDirty()
				arg_154_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_325591", "325591037", "story_v_out_325591.awb") ~= 0 then
					local var_157_14 = manager.audio:GetVoiceLength("story_v_out_325591", "325591037", "story_v_out_325591.awb") / 1000

					if var_157_14 + var_157_6 > arg_154_1.duration_ then
						arg_154_1.duration_ = var_157_14 + var_157_6
					end

					if var_157_9.prefab_name ~= "" and arg_154_1.actors_[var_157_9.prefab_name] ~= nil then
						local var_157_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_154_1.actors_[var_157_9.prefab_name].transform, "story_v_out_325591", "325591037", "story_v_out_325591.awb")

						arg_154_1:RecordAudio("325591037", var_157_15)
						arg_154_1:RecordAudio("325591037", var_157_15)
					else
						arg_154_1:AudioAction("play", "voice", "story_v_out_325591", "325591037", "story_v_out_325591.awb")
					end

					arg_154_1:RecordHistoryTalkVoice("story_v_out_325591", "325591037", "story_v_out_325591.awb")
				end

				arg_154_1:RecordContent(arg_154_1.text_.text)
			end

			local var_157_16 = math.max(var_157_7, arg_154_1.talkMaxDuration)

			if var_157_6 <= arg_154_1.time_ and arg_154_1.time_ < var_157_6 + var_157_16 then
				arg_154_1.typewritter.percent = (arg_154_1.time_ - var_157_6) / var_157_16

				arg_154_1.typewritter:SetDirty()
			end

			if arg_154_1.time_ >= var_157_6 + var_157_16 and arg_154_1.time_ < var_157_6 + var_157_16 + arg_157_0 then
				arg_154_1.typewritter.percent = 1

				arg_154_1.typewritter:SetDirty()
				arg_154_1:ShowNextGo(true)
			end
		end

		arg_154_1.nodeConfigList_ = {}

		arg_154_1:InitPlayNodeList()
	end,
	Play325591038 = function(arg_158_0, arg_158_1)
		arg_158_1.time_ = 0
		arg_158_1.frameCnt_ = 0
		arg_158_1.state_ = "playing"
		arg_158_1.curTalkId_ = 325591038
		arg_158_1.duration_ = 4.43

		local var_158_0 = {
			zh = 4.166,
			ja = 4.433
		}
		local var_158_1 = manager.audio:GetLocalizationFlag()

		if var_158_0[var_158_1] ~= nil then
			arg_158_1.duration_ = var_158_0[var_158_1]
		end

		SetActive(arg_158_1.tipsGo_, false)

		function arg_158_1.onSingleLineFinish_()
			arg_158_1.onSingleLineUpdate_ = nil
			arg_158_1.onSingleLineFinish_ = nil
			arg_158_1.state_ = "waiting"
		end

		function arg_158_1.playNext_(arg_160_0)
			if arg_160_0 == 1 then
				arg_158_0:Play325591039(arg_158_1)
			end
		end

		function arg_158_1.onSingleLineUpdate_(arg_161_0)
			local var_161_0 = arg_158_1.actors_["10176ui_story"]
			local var_161_1 = 0

			if var_161_1 < arg_158_1.time_ and arg_158_1.time_ <= var_161_1 + arg_161_0 and not isNil(var_161_0) and arg_158_1.var_.characterEffect10176ui_story == nil then
				arg_158_1.var_.characterEffect10176ui_story = var_161_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_161_2 = 0.200000002980232

			if var_161_1 <= arg_158_1.time_ and arg_158_1.time_ < var_161_1 + var_161_2 and not isNil(var_161_0) then
				local var_161_3 = (arg_158_1.time_ - var_161_1) / var_161_2

				if arg_158_1.var_.characterEffect10176ui_story and not isNil(var_161_0) then
					arg_158_1.var_.characterEffect10176ui_story.fillFlat = false
				end
			end

			if arg_158_1.time_ >= var_161_1 + var_161_2 and arg_158_1.time_ < var_161_1 + var_161_2 + arg_161_0 and not isNil(var_161_0) and arg_158_1.var_.characterEffect10176ui_story then
				arg_158_1.var_.characterEffect10176ui_story.fillFlat = false
			end

			local var_161_4 = 0

			if var_161_4 < arg_158_1.time_ and arg_158_1.time_ <= var_161_4 + arg_161_0 then
				arg_158_1:PlayTimeline("10176ui_story", "StoryTimeline/CharAction/story10176/story10176action/10176action2_2")
			end

			local var_161_5 = 0

			if var_161_5 < arg_158_1.time_ and arg_158_1.time_ <= var_161_5 + arg_161_0 then
				arg_158_1:PlayTimeline("10176ui_story", "StoryTimeline/CharAction/public_expression/expr_jingyaC", "EmotionTimelineAnimator")
			end

			local var_161_6 = 0
			local var_161_7 = 0.275

			if var_161_6 < arg_158_1.time_ and arg_158_1.time_ <= var_161_6 + arg_161_0 then
				arg_158_1.talkMaxDuration = 0
				arg_158_1.dialogCg_.alpha = 1

				arg_158_1.dialog_:SetActive(true)
				SetActive(arg_158_1.leftNameGo_, true)

				local var_161_8 = arg_158_1:FormatText(StoryNameCfg[1510].name)

				arg_158_1.leftNameTxt_.text = var_161_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_158_1.leftNameTxt_.transform)

				arg_158_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_158_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_158_1:RecordName(arg_158_1.leftNameTxt_.text)
				SetActive(arg_158_1.iconTrs_.gameObject, false)
				arg_158_1.callingController_:SetSelectedState("normal")

				local var_161_9 = arg_158_1:GetWordFromCfg(325591038)
				local var_161_10 = arg_158_1:FormatText(var_161_9.content)

				arg_158_1.text_.text = var_161_10

				LuaForUtil.ClearLinePrefixSymbol(arg_158_1.text_)

				local var_161_11 = 11
				local var_161_12 = utf8.len(var_161_10)
				local var_161_13 = var_161_11 <= 0 and var_161_7 or var_161_7 * (var_161_12 / var_161_11)

				if var_161_13 > 0 and var_161_7 < var_161_13 then
					arg_158_1.talkMaxDuration = var_161_13

					if var_161_13 + var_161_6 > arg_158_1.duration_ then
						arg_158_1.duration_ = var_161_13 + var_161_6
					end
				end

				arg_158_1.text_.text = var_161_10
				arg_158_1.typewritter.percent = 0

				arg_158_1.typewritter:SetDirty()
				arg_158_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_325591", "325591038", "story_v_out_325591.awb") ~= 0 then
					local var_161_14 = manager.audio:GetVoiceLength("story_v_out_325591", "325591038", "story_v_out_325591.awb") / 1000

					if var_161_14 + var_161_6 > arg_158_1.duration_ then
						arg_158_1.duration_ = var_161_14 + var_161_6
					end

					if var_161_9.prefab_name ~= "" and arg_158_1.actors_[var_161_9.prefab_name] ~= nil then
						local var_161_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_158_1.actors_[var_161_9.prefab_name].transform, "story_v_out_325591", "325591038", "story_v_out_325591.awb")

						arg_158_1:RecordAudio("325591038", var_161_15)
						arg_158_1:RecordAudio("325591038", var_161_15)
					else
						arg_158_1:AudioAction("play", "voice", "story_v_out_325591", "325591038", "story_v_out_325591.awb")
					end

					arg_158_1:RecordHistoryTalkVoice("story_v_out_325591", "325591038", "story_v_out_325591.awb")
				end

				arg_158_1:RecordContent(arg_158_1.text_.text)
			end

			local var_161_16 = math.max(var_161_7, arg_158_1.talkMaxDuration)

			if var_161_6 <= arg_158_1.time_ and arg_158_1.time_ < var_161_6 + var_161_16 then
				arg_158_1.typewritter.percent = (arg_158_1.time_ - var_161_6) / var_161_16

				arg_158_1.typewritter:SetDirty()
			end

			if arg_158_1.time_ >= var_161_6 + var_161_16 and arg_158_1.time_ < var_161_6 + var_161_16 + arg_161_0 then
				arg_158_1.typewritter.percent = 1

				arg_158_1.typewritter:SetDirty()
				arg_158_1:ShowNextGo(true)
			end
		end

		arg_158_1.nodeConfigList_ = {}

		arg_158_1:InitPlayNodeList()
	end,
	Play325591039 = function(arg_162_0, arg_162_1)
		arg_162_1.time_ = 0
		arg_162_1.frameCnt_ = 0
		arg_162_1.state_ = "playing"
		arg_162_1.curTalkId_ = 325591039
		arg_162_1.duration_ = 5

		SetActive(arg_162_1.tipsGo_, false)

		function arg_162_1.onSingleLineFinish_()
			arg_162_1.onSingleLineUpdate_ = nil
			arg_162_1.onSingleLineFinish_ = nil
			arg_162_1.state_ = "waiting"
		end

		function arg_162_1.playNext_(arg_164_0)
			if arg_164_0 == 1 then
				arg_162_0:Play325591040(arg_162_1)
			end
		end

		function arg_162_1.onSingleLineUpdate_(arg_165_0)
			local var_165_0 = arg_162_1.actors_["10176ui_story"].transform
			local var_165_1 = 0

			if var_165_1 < arg_162_1.time_ and arg_162_1.time_ <= var_165_1 + arg_165_0 then
				arg_162_1.var_.moveOldPos10176ui_story = var_165_0.localPosition

				local var_165_2 = GameObjectTools.GetOrAddComponent(var_165_0.gameObject, typeof(DynamicBoneHelper))

				if var_165_2 then
					var_165_2:EnableDynamicBone(false)
				end
			end

			local var_165_3 = 0.001

			if var_165_1 <= arg_162_1.time_ and arg_162_1.time_ < var_165_1 + var_165_3 then
				local var_165_4 = (arg_162_1.time_ - var_165_1) / var_165_3
				local var_165_5 = Vector3.New(0, 100, 0)

				var_165_0.localPosition = Vector3.Lerp(arg_162_1.var_.moveOldPos10176ui_story, var_165_5, var_165_4)

				local var_165_6 = manager.ui.mainCamera.transform.position - var_165_0.position

				var_165_0.forward = Vector3.New(var_165_6.x, var_165_6.y, var_165_6.z)

				local var_165_7 = var_165_0.localEulerAngles

				var_165_7.z = 0
				var_165_7.x = 0
				var_165_0.localEulerAngles = var_165_7
			end

			if arg_162_1.time_ >= var_165_1 + var_165_3 and arg_162_1.time_ < var_165_1 + var_165_3 + arg_165_0 then
				var_165_0.localPosition = Vector3.New(0, 100, 0)

				local var_165_8 = manager.ui.mainCamera.transform.position - var_165_0.position

				var_165_0.forward = Vector3.New(var_165_8.x, var_165_8.y, var_165_8.z)

				local var_165_9 = var_165_0.localEulerAngles

				var_165_9.z = 0
				var_165_9.x = 0
				var_165_0.localEulerAngles = var_165_9

				local var_165_10 = GameObjectTools.GetOrAddComponent(var_165_0.gameObject, typeof(DynamicBoneHelper))

				if var_165_10 then
					var_165_10:EnableDynamicBone(true)
				end
			end

			local var_165_11 = arg_162_1.actors_["10176ui_story"]
			local var_165_12 = 0

			if var_165_12 < arg_162_1.time_ and arg_162_1.time_ <= var_165_12 + arg_165_0 and not isNil(var_165_11) and arg_162_1.var_.characterEffect10176ui_story == nil then
				arg_162_1.var_.characterEffect10176ui_story = var_165_11:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_165_13 = 0.200000002980232

			if var_165_12 <= arg_162_1.time_ and arg_162_1.time_ < var_165_12 + var_165_13 and not isNil(var_165_11) then
				local var_165_14 = (arg_162_1.time_ - var_165_12) / var_165_13

				if arg_162_1.var_.characterEffect10176ui_story and not isNil(var_165_11) then
					local var_165_15 = Mathf.Lerp(0, 0.5, var_165_14)

					arg_162_1.var_.characterEffect10176ui_story.fillFlat = true
					arg_162_1.var_.characterEffect10176ui_story.fillRatio = var_165_15
				end
			end

			if arg_162_1.time_ >= var_165_12 + var_165_13 and arg_162_1.time_ < var_165_12 + var_165_13 + arg_165_0 and not isNil(var_165_11) and arg_162_1.var_.characterEffect10176ui_story then
				local var_165_16 = 0.5

				arg_162_1.var_.characterEffect10176ui_story.fillFlat = true
				arg_162_1.var_.characterEffect10176ui_story.fillRatio = var_165_16
			end

			local var_165_17 = manager.ui.mainCamera.transform
			local var_165_18 = 0

			if var_165_18 < arg_162_1.time_ and arg_162_1.time_ <= var_165_18 + arg_165_0 then
				arg_162_1.var_.shakeOldPos = var_165_17.localPosition
			end

			local var_165_19 = 0.3

			if var_165_18 <= arg_162_1.time_ and arg_162_1.time_ < var_165_18 + var_165_19 then
				local var_165_20 = (arg_162_1.time_ - var_165_18) / 0.066
				local var_165_21, var_165_22 = math.modf(var_165_20)

				var_165_17.localPosition = Vector3.New(var_165_22 * 0.13, var_165_22 * 0.13, var_165_22 * 0.13) + arg_162_1.var_.shakeOldPos
			end

			if arg_162_1.time_ >= var_165_18 + var_165_19 and arg_162_1.time_ < var_165_18 + var_165_19 + arg_165_0 then
				var_165_17.localPosition = arg_162_1.var_.shakeOldPos
			end

			local var_165_23 = 0

			if var_165_23 < arg_162_1.time_ and arg_162_1.time_ <= var_165_23 + arg_165_0 then
				arg_162_1.allBtn_.enabled = false
			end

			local var_165_24 = 0.6

			if arg_162_1.time_ >= var_165_23 + var_165_24 and arg_162_1.time_ < var_165_23 + var_165_24 + arg_165_0 then
				arg_162_1.allBtn_.enabled = true
			end

			local var_165_25 = 0
			local var_165_26 = 1.175

			if var_165_25 < arg_162_1.time_ and arg_162_1.time_ <= var_165_25 + arg_165_0 then
				arg_162_1.talkMaxDuration = 0

				arg_162_1.dialog_:SetActive(true)

				arg_162_1.dialogCg_.alpha = 0

				local var_165_27 = LeanTween.value(arg_162_1.dialog_, 0, 1, 0.3)

				var_165_27:setOnUpdate(LuaHelper.FloatAction(function(arg_166_0)
					arg_162_1.dialogCg_.alpha = arg_166_0
				end))
				var_165_27:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_162_1.dialog_)
					var_165_27:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_162_1.duration_ = arg_162_1.duration_ + 0.3

				SetActive(arg_162_1.leftNameGo_, false)

				arg_162_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_162_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_162_1:RecordName(arg_162_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_162_1.iconTrs_.gameObject, false)
				arg_162_1.callingController_:SetSelectedState("normal")

				local var_165_28 = arg_162_1:GetWordFromCfg(325591039)
				local var_165_29 = arg_162_1:FormatText(var_165_28.content)

				arg_162_1.text_.text = var_165_29

				LuaForUtil.ClearLinePrefixSymbol(arg_162_1.text_)

				local var_165_30 = 47
				local var_165_31 = utf8.len(var_165_29)
				local var_165_32 = var_165_30 <= 0 and var_165_26 or var_165_26 * (var_165_31 / var_165_30)

				if var_165_32 > 0 and var_165_26 < var_165_32 then
					arg_162_1.talkMaxDuration = var_165_32
					var_165_25 = var_165_25 + 0.3

					if var_165_32 + var_165_25 > arg_162_1.duration_ then
						arg_162_1.duration_ = var_165_32 + var_165_25
					end
				end

				arg_162_1.text_.text = var_165_29
				arg_162_1.typewritter.percent = 0

				arg_162_1.typewritter:SetDirty()
				arg_162_1:ShowNextGo(false)
				arg_162_1:RecordContent(arg_162_1.text_.text)
			end

			local var_165_33 = var_165_25 + 0.3
			local var_165_34 = math.max(var_165_26, arg_162_1.talkMaxDuration)

			if var_165_33 <= arg_162_1.time_ and arg_162_1.time_ < var_165_33 + var_165_34 then
				arg_162_1.typewritter.percent = (arg_162_1.time_ - var_165_33) / var_165_34

				arg_162_1.typewritter:SetDirty()
			end

			if arg_162_1.time_ >= var_165_33 + var_165_34 and arg_162_1.time_ < var_165_33 + var_165_34 + arg_165_0 then
				arg_162_1.typewritter.percent = 1

				arg_162_1.typewritter:SetDirty()
				arg_162_1:ShowNextGo(true)
			end
		end

		arg_162_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10176ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_162_1:InitPlayNodeList()
	end,
	Play325591040 = function(arg_168_0, arg_168_1)
		arg_168_1.time_ = 0
		arg_168_1.frameCnt_ = 0
		arg_168_1.state_ = "playing"
		arg_168_1.curTalkId_ = 325591040
		arg_168_1.duration_ = 5

		SetActive(arg_168_1.tipsGo_, false)

		function arg_168_1.onSingleLineFinish_()
			arg_168_1.onSingleLineUpdate_ = nil
			arg_168_1.onSingleLineFinish_ = nil
			arg_168_1.state_ = "waiting"
		end

		function arg_168_1.playNext_(arg_170_0)
			if arg_170_0 == 1 then
				arg_168_0:Play325591041(arg_168_1)
			end
		end

		function arg_168_1.onSingleLineUpdate_(arg_171_0)
			local var_171_0 = 0
			local var_171_1 = 1.65

			if var_171_0 < arg_168_1.time_ and arg_168_1.time_ <= var_171_0 + arg_171_0 then
				arg_168_1.talkMaxDuration = 0
				arg_168_1.dialogCg_.alpha = 1

				arg_168_1.dialog_:SetActive(true)
				SetActive(arg_168_1.leftNameGo_, false)

				arg_168_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_168_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_168_1:RecordName(arg_168_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_168_1.iconTrs_.gameObject, false)
				arg_168_1.callingController_:SetSelectedState("normal")

				local var_171_2 = arg_168_1:GetWordFromCfg(325591040)
				local var_171_3 = arg_168_1:FormatText(var_171_2.content)

				arg_168_1.text_.text = var_171_3

				LuaForUtil.ClearLinePrefixSymbol(arg_168_1.text_)

				local var_171_4 = 66
				local var_171_5 = utf8.len(var_171_3)
				local var_171_6 = var_171_4 <= 0 and var_171_1 or var_171_1 * (var_171_5 / var_171_4)

				if var_171_6 > 0 and var_171_1 < var_171_6 then
					arg_168_1.talkMaxDuration = var_171_6

					if var_171_6 + var_171_0 > arg_168_1.duration_ then
						arg_168_1.duration_ = var_171_6 + var_171_0
					end
				end

				arg_168_1.text_.text = var_171_3
				arg_168_1.typewritter.percent = 0

				arg_168_1.typewritter:SetDirty()
				arg_168_1:ShowNextGo(false)
				arg_168_1:RecordContent(arg_168_1.text_.text)
			end

			local var_171_7 = math.max(var_171_1, arg_168_1.talkMaxDuration)

			if var_171_0 <= arg_168_1.time_ and arg_168_1.time_ < var_171_0 + var_171_7 then
				arg_168_1.typewritter.percent = (arg_168_1.time_ - var_171_0) / var_171_7

				arg_168_1.typewritter:SetDirty()
			end

			if arg_168_1.time_ >= var_171_0 + var_171_7 and arg_168_1.time_ < var_171_0 + var_171_7 + arg_171_0 then
				arg_168_1.typewritter.percent = 1

				arg_168_1.typewritter:SetDirty()
				arg_168_1:ShowNextGo(true)
			end
		end

		arg_168_1.nodeConfigList_ = {}

		arg_168_1:InitPlayNodeList()
	end,
	Play325591041 = function(arg_172_0, arg_172_1)
		arg_172_1.time_ = 0
		arg_172_1.frameCnt_ = 0
		arg_172_1.state_ = "playing"
		arg_172_1.curTalkId_ = 325591041
		arg_172_1.duration_ = 5.9

		local var_172_0 = {
			zh = 5.9,
			ja = 4.2
		}
		local var_172_1 = manager.audio:GetLocalizationFlag()

		if var_172_0[var_172_1] ~= nil then
			arg_172_1.duration_ = var_172_0[var_172_1]
		end

		SetActive(arg_172_1.tipsGo_, false)

		function arg_172_1.onSingleLineFinish_()
			arg_172_1.onSingleLineUpdate_ = nil
			arg_172_1.onSingleLineFinish_ = nil
			arg_172_1.state_ = "waiting"
		end

		function arg_172_1.playNext_(arg_174_0)
			if arg_174_0 == 1 then
				arg_172_0:Play325591042(arg_172_1)
			end
		end

		function arg_172_1.onSingleLineUpdate_(arg_175_0)
			local var_175_0 = arg_172_1.actors_["10176ui_story"].transform
			local var_175_1 = 0

			if var_175_1 < arg_172_1.time_ and arg_172_1.time_ <= var_175_1 + arg_175_0 then
				arg_172_1.var_.moveOldPos10176ui_story = var_175_0.localPosition

				local var_175_2 = GameObjectTools.GetOrAddComponent(var_175_0.gameObject, typeof(DynamicBoneHelper))

				if var_175_2 then
					var_175_2:EnableDynamicBone(false)
				end
			end

			local var_175_3 = 0.001

			if var_175_1 <= arg_172_1.time_ and arg_172_1.time_ < var_175_1 + var_175_3 then
				local var_175_4 = (arg_172_1.time_ - var_175_1) / var_175_3
				local var_175_5 = Vector3.New(-0.02, -1.09, -6.12)

				var_175_0.localPosition = Vector3.Lerp(arg_172_1.var_.moveOldPos10176ui_story, var_175_5, var_175_4)

				local var_175_6 = manager.ui.mainCamera.transform.position - var_175_0.position

				var_175_0.forward = Vector3.New(var_175_6.x, var_175_6.y, var_175_6.z)

				local var_175_7 = var_175_0.localEulerAngles

				var_175_7.z = 0
				var_175_7.x = 0
				var_175_0.localEulerAngles = var_175_7
			end

			if arg_172_1.time_ >= var_175_1 + var_175_3 and arg_172_1.time_ < var_175_1 + var_175_3 + arg_175_0 then
				var_175_0.localPosition = Vector3.New(-0.02, -1.09, -6.12)

				local var_175_8 = manager.ui.mainCamera.transform.position - var_175_0.position

				var_175_0.forward = Vector3.New(var_175_8.x, var_175_8.y, var_175_8.z)

				local var_175_9 = var_175_0.localEulerAngles

				var_175_9.z = 0
				var_175_9.x = 0
				var_175_0.localEulerAngles = var_175_9

				local var_175_10 = GameObjectTools.GetOrAddComponent(var_175_0.gameObject, typeof(DynamicBoneHelper))

				if var_175_10 then
					var_175_10:EnableDynamicBone(true)
				end
			end

			local var_175_11 = arg_172_1.actors_["10176ui_story"]
			local var_175_12 = 0

			if var_175_12 < arg_172_1.time_ and arg_172_1.time_ <= var_175_12 + arg_175_0 and not isNil(var_175_11) and arg_172_1.var_.characterEffect10176ui_story == nil then
				arg_172_1.var_.characterEffect10176ui_story = var_175_11:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_175_13 = 0.200000002980232

			if var_175_12 <= arg_172_1.time_ and arg_172_1.time_ < var_175_12 + var_175_13 and not isNil(var_175_11) then
				local var_175_14 = (arg_172_1.time_ - var_175_12) / var_175_13

				if arg_172_1.var_.characterEffect10176ui_story and not isNil(var_175_11) then
					arg_172_1.var_.characterEffect10176ui_story.fillFlat = false
				end
			end

			if arg_172_1.time_ >= var_175_12 + var_175_13 and arg_172_1.time_ < var_175_12 + var_175_13 + arg_175_0 and not isNil(var_175_11) and arg_172_1.var_.characterEffect10176ui_story then
				arg_172_1.var_.characterEffect10176ui_story.fillFlat = false
			end

			local var_175_15 = 0

			if var_175_15 < arg_172_1.time_ and arg_172_1.time_ <= var_175_15 + arg_175_0 then
				arg_172_1:PlayTimeline("10176ui_story", "StoryTimeline/CharAction/story10176/story10176action/10176action5_1")
			end

			local var_175_16 = 0

			if var_175_16 < arg_172_1.time_ and arg_172_1.time_ <= var_175_16 + arg_175_0 then
				arg_172_1:PlayTimeline("10176ui_story", "StoryTimeline/CharAction/public_expression/expr_xinwei", "EmotionTimelineAnimator")
			end

			local var_175_17 = 0
			local var_175_18 = 0.525

			if var_175_17 < arg_172_1.time_ and arg_172_1.time_ <= var_175_17 + arg_175_0 then
				arg_172_1.talkMaxDuration = 0
				arg_172_1.dialogCg_.alpha = 1

				arg_172_1.dialog_:SetActive(true)
				SetActive(arg_172_1.leftNameGo_, true)

				local var_175_19 = arg_172_1:FormatText(StoryNameCfg[1510].name)

				arg_172_1.leftNameTxt_.text = var_175_19

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_172_1.leftNameTxt_.transform)

				arg_172_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_172_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_172_1:RecordName(arg_172_1.leftNameTxt_.text)
				SetActive(arg_172_1.iconTrs_.gameObject, false)
				arg_172_1.callingController_:SetSelectedState("normal")

				local var_175_20 = arg_172_1:GetWordFromCfg(325591041)
				local var_175_21 = arg_172_1:FormatText(var_175_20.content)

				arg_172_1.text_.text = var_175_21

				LuaForUtil.ClearLinePrefixSymbol(arg_172_1.text_)

				local var_175_22 = 21
				local var_175_23 = utf8.len(var_175_21)
				local var_175_24 = var_175_22 <= 0 and var_175_18 or var_175_18 * (var_175_23 / var_175_22)

				if var_175_24 > 0 and var_175_18 < var_175_24 then
					arg_172_1.talkMaxDuration = var_175_24

					if var_175_24 + var_175_17 > arg_172_1.duration_ then
						arg_172_1.duration_ = var_175_24 + var_175_17
					end
				end

				arg_172_1.text_.text = var_175_21
				arg_172_1.typewritter.percent = 0

				arg_172_1.typewritter:SetDirty()
				arg_172_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_325591", "325591041", "story_v_out_325591.awb") ~= 0 then
					local var_175_25 = manager.audio:GetVoiceLength("story_v_out_325591", "325591041", "story_v_out_325591.awb") / 1000

					if var_175_25 + var_175_17 > arg_172_1.duration_ then
						arg_172_1.duration_ = var_175_25 + var_175_17
					end

					if var_175_20.prefab_name ~= "" and arg_172_1.actors_[var_175_20.prefab_name] ~= nil then
						local var_175_26 = LuaForUtil.PlayVoiceWithCriLipsync(arg_172_1.actors_[var_175_20.prefab_name].transform, "story_v_out_325591", "325591041", "story_v_out_325591.awb")

						arg_172_1:RecordAudio("325591041", var_175_26)
						arg_172_1:RecordAudio("325591041", var_175_26)
					else
						arg_172_1:AudioAction("play", "voice", "story_v_out_325591", "325591041", "story_v_out_325591.awb")
					end

					arg_172_1:RecordHistoryTalkVoice("story_v_out_325591", "325591041", "story_v_out_325591.awb")
				end

				arg_172_1:RecordContent(arg_172_1.text_.text)
			end

			local var_175_27 = math.max(var_175_18, arg_172_1.talkMaxDuration)

			if var_175_17 <= arg_172_1.time_ and arg_172_1.time_ < var_175_17 + var_175_27 then
				arg_172_1.typewritter.percent = (arg_172_1.time_ - var_175_17) / var_175_27

				arg_172_1.typewritter:SetDirty()
			end

			if arg_172_1.time_ >= var_175_17 + var_175_27 and arg_172_1.time_ < var_175_17 + var_175_27 + arg_175_0 then
				arg_172_1.typewritter.percent = 1

				arg_172_1.typewritter:SetDirty()
				arg_172_1:ShowNextGo(true)
			end
		end

		arg_172_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10176ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_172_1:InitPlayNodeList()
	end,
	Play325591042 = function(arg_176_0, arg_176_1)
		arg_176_1.time_ = 0
		arg_176_1.frameCnt_ = 0
		arg_176_1.state_ = "playing"
		arg_176_1.curTalkId_ = 325591042
		arg_176_1.duration_ = 5

		SetActive(arg_176_1.tipsGo_, false)

		function arg_176_1.onSingleLineFinish_()
			arg_176_1.onSingleLineUpdate_ = nil
			arg_176_1.onSingleLineFinish_ = nil
			arg_176_1.state_ = "waiting"
		end

		function arg_176_1.playNext_(arg_178_0)
			if arg_178_0 == 1 then
				arg_176_0:Play325591043(arg_176_1)
			end
		end

		function arg_176_1.onSingleLineUpdate_(arg_179_0)
			local var_179_0 = arg_176_1.actors_["10176ui_story"].transform
			local var_179_1 = 0

			if var_179_1 < arg_176_1.time_ and arg_176_1.time_ <= var_179_1 + arg_179_0 then
				arg_176_1.var_.moveOldPos10176ui_story = var_179_0.localPosition

				local var_179_2 = GameObjectTools.GetOrAddComponent(var_179_0.gameObject, typeof(DynamicBoneHelper))

				if var_179_2 then
					var_179_2:EnableDynamicBone(false)
				end
			end

			local var_179_3 = 0.001

			if var_179_1 <= arg_176_1.time_ and arg_176_1.time_ < var_179_1 + var_179_3 then
				local var_179_4 = (arg_176_1.time_ - var_179_1) / var_179_3
				local var_179_5 = Vector3.New(0, 100, 0)

				var_179_0.localPosition = Vector3.Lerp(arg_176_1.var_.moveOldPos10176ui_story, var_179_5, var_179_4)

				local var_179_6 = manager.ui.mainCamera.transform.position - var_179_0.position

				var_179_0.forward = Vector3.New(var_179_6.x, var_179_6.y, var_179_6.z)

				local var_179_7 = var_179_0.localEulerAngles

				var_179_7.z = 0
				var_179_7.x = 0
				var_179_0.localEulerAngles = var_179_7
			end

			if arg_176_1.time_ >= var_179_1 + var_179_3 and arg_176_1.time_ < var_179_1 + var_179_3 + arg_179_0 then
				var_179_0.localPosition = Vector3.New(0, 100, 0)

				local var_179_8 = manager.ui.mainCamera.transform.position - var_179_0.position

				var_179_0.forward = Vector3.New(var_179_8.x, var_179_8.y, var_179_8.z)

				local var_179_9 = var_179_0.localEulerAngles

				var_179_9.z = 0
				var_179_9.x = 0
				var_179_0.localEulerAngles = var_179_9

				local var_179_10 = GameObjectTools.GetOrAddComponent(var_179_0.gameObject, typeof(DynamicBoneHelper))

				if var_179_10 then
					var_179_10:EnableDynamicBone(true)
				end
			end

			local var_179_11 = arg_176_1.actors_["10176ui_story"]
			local var_179_12 = 0

			if var_179_12 < arg_176_1.time_ and arg_176_1.time_ <= var_179_12 + arg_179_0 and not isNil(var_179_11) and arg_176_1.var_.characterEffect10176ui_story == nil then
				arg_176_1.var_.characterEffect10176ui_story = var_179_11:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_179_13 = 0.200000002980232

			if var_179_12 <= arg_176_1.time_ and arg_176_1.time_ < var_179_12 + var_179_13 and not isNil(var_179_11) then
				local var_179_14 = (arg_176_1.time_ - var_179_12) / var_179_13

				if arg_176_1.var_.characterEffect10176ui_story and not isNil(var_179_11) then
					local var_179_15 = Mathf.Lerp(0, 0.5, var_179_14)

					arg_176_1.var_.characterEffect10176ui_story.fillFlat = true
					arg_176_1.var_.characterEffect10176ui_story.fillRatio = var_179_15
				end
			end

			if arg_176_1.time_ >= var_179_12 + var_179_13 and arg_176_1.time_ < var_179_12 + var_179_13 + arg_179_0 and not isNil(var_179_11) and arg_176_1.var_.characterEffect10176ui_story then
				local var_179_16 = 0.5

				arg_176_1.var_.characterEffect10176ui_story.fillFlat = true
				arg_176_1.var_.characterEffect10176ui_story.fillRatio = var_179_16
			end

			local var_179_17 = 0
			local var_179_18 = 1.4

			if var_179_17 < arg_176_1.time_ and arg_176_1.time_ <= var_179_17 + arg_179_0 then
				arg_176_1.talkMaxDuration = 0
				arg_176_1.dialogCg_.alpha = 1

				arg_176_1.dialog_:SetActive(true)
				SetActive(arg_176_1.leftNameGo_, false)

				arg_176_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_176_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_176_1:RecordName(arg_176_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_176_1.iconTrs_.gameObject, false)
				arg_176_1.callingController_:SetSelectedState("normal")

				local var_179_19 = arg_176_1:GetWordFromCfg(325591042)
				local var_179_20 = arg_176_1:FormatText(var_179_19.content)

				arg_176_1.text_.text = var_179_20

				LuaForUtil.ClearLinePrefixSymbol(arg_176_1.text_)

				local var_179_21 = 56
				local var_179_22 = utf8.len(var_179_20)
				local var_179_23 = var_179_21 <= 0 and var_179_18 or var_179_18 * (var_179_22 / var_179_21)

				if var_179_23 > 0 and var_179_18 < var_179_23 then
					arg_176_1.talkMaxDuration = var_179_23

					if var_179_23 + var_179_17 > arg_176_1.duration_ then
						arg_176_1.duration_ = var_179_23 + var_179_17
					end
				end

				arg_176_1.text_.text = var_179_20
				arg_176_1.typewritter.percent = 0

				arg_176_1.typewritter:SetDirty()
				arg_176_1:ShowNextGo(false)
				arg_176_1:RecordContent(arg_176_1.text_.text)
			end

			local var_179_24 = math.max(var_179_18, arg_176_1.talkMaxDuration)

			if var_179_17 <= arg_176_1.time_ and arg_176_1.time_ < var_179_17 + var_179_24 then
				arg_176_1.typewritter.percent = (arg_176_1.time_ - var_179_17) / var_179_24

				arg_176_1.typewritter:SetDirty()
			end

			if arg_176_1.time_ >= var_179_17 + var_179_24 and arg_176_1.time_ < var_179_17 + var_179_24 + arg_179_0 then
				arg_176_1.typewritter.percent = 1

				arg_176_1.typewritter:SetDirty()
				arg_176_1:ShowNextGo(true)
			end
		end

		arg_176_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10176ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_176_1:InitPlayNodeList()
	end,
	Play325591043 = function(arg_180_0, arg_180_1)
		arg_180_1.time_ = 0
		arg_180_1.frameCnt_ = 0
		arg_180_1.state_ = "playing"
		arg_180_1.curTalkId_ = 325591043
		arg_180_1.duration_ = 4.63

		local var_180_0 = {
			zh = 3.533,
			ja = 4.633
		}
		local var_180_1 = manager.audio:GetLocalizationFlag()

		if var_180_0[var_180_1] ~= nil then
			arg_180_1.duration_ = var_180_0[var_180_1]
		end

		SetActive(arg_180_1.tipsGo_, false)

		function arg_180_1.onSingleLineFinish_()
			arg_180_1.onSingleLineUpdate_ = nil
			arg_180_1.onSingleLineFinish_ = nil
			arg_180_1.state_ = "waiting"
		end

		function arg_180_1.playNext_(arg_182_0)
			if arg_182_0 == 1 then
				arg_180_0:Play325591044(arg_180_1)
			end
		end

		function arg_180_1.onSingleLineUpdate_(arg_183_0)
			local var_183_0 = arg_180_1.actors_["10176ui_story"].transform
			local var_183_1 = 0

			if var_183_1 < arg_180_1.time_ and arg_180_1.time_ <= var_183_1 + arg_183_0 then
				arg_180_1.var_.moveOldPos10176ui_story = var_183_0.localPosition

				local var_183_2 = GameObjectTools.GetOrAddComponent(var_183_0.gameObject, typeof(DynamicBoneHelper))

				if var_183_2 then
					var_183_2:EnableDynamicBone(false)
				end
			end

			local var_183_3 = 0.001

			if var_183_1 <= arg_180_1.time_ and arg_180_1.time_ < var_183_1 + var_183_3 then
				local var_183_4 = (arg_180_1.time_ - var_183_1) / var_183_3
				local var_183_5 = Vector3.New(-0.02, -1.09, -6.12)

				var_183_0.localPosition = Vector3.Lerp(arg_180_1.var_.moveOldPos10176ui_story, var_183_5, var_183_4)

				local var_183_6 = manager.ui.mainCamera.transform.position - var_183_0.position

				var_183_0.forward = Vector3.New(var_183_6.x, var_183_6.y, var_183_6.z)

				local var_183_7 = var_183_0.localEulerAngles

				var_183_7.z = 0
				var_183_7.x = 0
				var_183_0.localEulerAngles = var_183_7
			end

			if arg_180_1.time_ >= var_183_1 + var_183_3 and arg_180_1.time_ < var_183_1 + var_183_3 + arg_183_0 then
				var_183_0.localPosition = Vector3.New(-0.02, -1.09, -6.12)

				local var_183_8 = manager.ui.mainCamera.transform.position - var_183_0.position

				var_183_0.forward = Vector3.New(var_183_8.x, var_183_8.y, var_183_8.z)

				local var_183_9 = var_183_0.localEulerAngles

				var_183_9.z = 0
				var_183_9.x = 0
				var_183_0.localEulerAngles = var_183_9

				local var_183_10 = GameObjectTools.GetOrAddComponent(var_183_0.gameObject, typeof(DynamicBoneHelper))

				if var_183_10 then
					var_183_10:EnableDynamicBone(true)
				end
			end

			local var_183_11 = arg_180_1.actors_["10176ui_story"]
			local var_183_12 = 0

			if var_183_12 < arg_180_1.time_ and arg_180_1.time_ <= var_183_12 + arg_183_0 and not isNil(var_183_11) and arg_180_1.var_.characterEffect10176ui_story == nil then
				arg_180_1.var_.characterEffect10176ui_story = var_183_11:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_183_13 = 0.200000002980232

			if var_183_12 <= arg_180_1.time_ and arg_180_1.time_ < var_183_12 + var_183_13 and not isNil(var_183_11) then
				local var_183_14 = (arg_180_1.time_ - var_183_12) / var_183_13

				if arg_180_1.var_.characterEffect10176ui_story and not isNil(var_183_11) then
					arg_180_1.var_.characterEffect10176ui_story.fillFlat = false
				end
			end

			if arg_180_1.time_ >= var_183_12 + var_183_13 and arg_180_1.time_ < var_183_12 + var_183_13 + arg_183_0 and not isNil(var_183_11) and arg_180_1.var_.characterEffect10176ui_story then
				arg_180_1.var_.characterEffect10176ui_story.fillFlat = false
			end

			local var_183_15 = 0

			if var_183_15 < arg_180_1.time_ and arg_180_1.time_ <= var_183_15 + arg_183_0 then
				arg_180_1:PlayTimeline("10176ui_story", "StoryTimeline/CharAction/story10176/story10176action/10176action5_2")
			end

			local var_183_16 = 0

			if var_183_16 < arg_180_1.time_ and arg_180_1.time_ <= var_183_16 + arg_183_0 then
				arg_180_1:PlayTimeline("10176ui_story", "StoryTimeline/CharAction/public_expression/expr_xinwei", "EmotionTimelineAnimator")
			end

			local var_183_17 = 0
			local var_183_18 = 0.275

			if var_183_17 < arg_180_1.time_ and arg_180_1.time_ <= var_183_17 + arg_183_0 then
				arg_180_1.talkMaxDuration = 0
				arg_180_1.dialogCg_.alpha = 1

				arg_180_1.dialog_:SetActive(true)
				SetActive(arg_180_1.leftNameGo_, true)

				local var_183_19 = arg_180_1:FormatText(StoryNameCfg[1510].name)

				arg_180_1.leftNameTxt_.text = var_183_19

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_180_1.leftNameTxt_.transform)

				arg_180_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_180_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_180_1:RecordName(arg_180_1.leftNameTxt_.text)
				SetActive(arg_180_1.iconTrs_.gameObject, false)
				arg_180_1.callingController_:SetSelectedState("normal")

				local var_183_20 = arg_180_1:GetWordFromCfg(325591043)
				local var_183_21 = arg_180_1:FormatText(var_183_20.content)

				arg_180_1.text_.text = var_183_21

				LuaForUtil.ClearLinePrefixSymbol(arg_180_1.text_)

				local var_183_22 = 11
				local var_183_23 = utf8.len(var_183_21)
				local var_183_24 = var_183_22 <= 0 and var_183_18 or var_183_18 * (var_183_23 / var_183_22)

				if var_183_24 > 0 and var_183_18 < var_183_24 then
					arg_180_1.talkMaxDuration = var_183_24

					if var_183_24 + var_183_17 > arg_180_1.duration_ then
						arg_180_1.duration_ = var_183_24 + var_183_17
					end
				end

				arg_180_1.text_.text = var_183_21
				arg_180_1.typewritter.percent = 0

				arg_180_1.typewritter:SetDirty()
				arg_180_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_325591", "325591043", "story_v_out_325591.awb") ~= 0 then
					local var_183_25 = manager.audio:GetVoiceLength("story_v_out_325591", "325591043", "story_v_out_325591.awb") / 1000

					if var_183_25 + var_183_17 > arg_180_1.duration_ then
						arg_180_1.duration_ = var_183_25 + var_183_17
					end

					if var_183_20.prefab_name ~= "" and arg_180_1.actors_[var_183_20.prefab_name] ~= nil then
						local var_183_26 = LuaForUtil.PlayVoiceWithCriLipsync(arg_180_1.actors_[var_183_20.prefab_name].transform, "story_v_out_325591", "325591043", "story_v_out_325591.awb")

						arg_180_1:RecordAudio("325591043", var_183_26)
						arg_180_1:RecordAudio("325591043", var_183_26)
					else
						arg_180_1:AudioAction("play", "voice", "story_v_out_325591", "325591043", "story_v_out_325591.awb")
					end

					arg_180_1:RecordHistoryTalkVoice("story_v_out_325591", "325591043", "story_v_out_325591.awb")
				end

				arg_180_1:RecordContent(arg_180_1.text_.text)
			end

			local var_183_27 = math.max(var_183_18, arg_180_1.talkMaxDuration)

			if var_183_17 <= arg_180_1.time_ and arg_180_1.time_ < var_183_17 + var_183_27 then
				arg_180_1.typewritter.percent = (arg_180_1.time_ - var_183_17) / var_183_27

				arg_180_1.typewritter:SetDirty()
			end

			if arg_180_1.time_ >= var_183_17 + var_183_27 and arg_180_1.time_ < var_183_17 + var_183_27 + arg_183_0 then
				arg_180_1.typewritter.percent = 1

				arg_180_1.typewritter:SetDirty()
				arg_180_1:ShowNextGo(true)
			end
		end

		arg_180_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10176ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_180_1:InitPlayNodeList()
	end,
	Play325591044 = function(arg_184_0, arg_184_1)
		arg_184_1.time_ = 0
		arg_184_1.frameCnt_ = 0
		arg_184_1.state_ = "playing"
		arg_184_1.curTalkId_ = 325591044
		arg_184_1.duration_ = 7.17

		local var_184_0 = {
			zh = 5.4,
			ja = 7.166
		}
		local var_184_1 = manager.audio:GetLocalizationFlag()

		if var_184_0[var_184_1] ~= nil then
			arg_184_1.duration_ = var_184_0[var_184_1]
		end

		SetActive(arg_184_1.tipsGo_, false)

		function arg_184_1.onSingleLineFinish_()
			arg_184_1.onSingleLineUpdate_ = nil
			arg_184_1.onSingleLineFinish_ = nil
			arg_184_1.state_ = "waiting"
		end

		function arg_184_1.playNext_(arg_186_0)
			if arg_186_0 == 1 then
				arg_184_0:Play325591045(arg_184_1)
			end
		end

		function arg_184_1.onSingleLineUpdate_(arg_187_0)
			local var_187_0 = arg_184_1.actors_["10176ui_story"].transform
			local var_187_1 = 0

			if var_187_1 < arg_184_1.time_ and arg_184_1.time_ <= var_187_1 + arg_187_0 then
				arg_184_1.var_.moveOldPos10176ui_story = var_187_0.localPosition

				local var_187_2 = GameObjectTools.GetOrAddComponent(var_187_0.gameObject, typeof(DynamicBoneHelper))

				if var_187_2 then
					var_187_2:EnableDynamicBone(false)
				end
			end

			local var_187_3 = 0.001

			if var_187_1 <= arg_184_1.time_ and arg_184_1.time_ < var_187_1 + var_187_3 then
				local var_187_4 = (arg_184_1.time_ - var_187_1) / var_187_3
				local var_187_5 = Vector3.New(-0.7, -1.09, -6.12)

				var_187_0.localPosition = Vector3.Lerp(arg_184_1.var_.moveOldPos10176ui_story, var_187_5, var_187_4)

				local var_187_6 = manager.ui.mainCamera.transform.position - var_187_0.position

				var_187_0.forward = Vector3.New(var_187_6.x, var_187_6.y, var_187_6.z)

				local var_187_7 = var_187_0.localEulerAngles

				var_187_7.z = 0
				var_187_7.x = 0
				var_187_0.localEulerAngles = var_187_7
			end

			if arg_184_1.time_ >= var_187_1 + var_187_3 and arg_184_1.time_ < var_187_1 + var_187_3 + arg_187_0 then
				var_187_0.localPosition = Vector3.New(-0.7, -1.09, -6.12)

				local var_187_8 = manager.ui.mainCamera.transform.position - var_187_0.position

				var_187_0.forward = Vector3.New(var_187_8.x, var_187_8.y, var_187_8.z)

				local var_187_9 = var_187_0.localEulerAngles

				var_187_9.z = 0
				var_187_9.x = 0
				var_187_0.localEulerAngles = var_187_9

				local var_187_10 = GameObjectTools.GetOrAddComponent(var_187_0.gameObject, typeof(DynamicBoneHelper))

				if var_187_10 then
					var_187_10:EnableDynamicBone(true)
				end
			end

			local var_187_11 = arg_184_1.actors_["6148ui_story"].transform
			local var_187_12 = 0

			if var_187_12 < arg_184_1.time_ and arg_184_1.time_ <= var_187_12 + arg_187_0 then
				arg_184_1.var_.moveOldPos6148ui_story = var_187_11.localPosition

				local var_187_13 = GameObjectTools.GetOrAddComponent(var_187_11.gameObject, typeof(DynamicBoneHelper))

				if var_187_13 then
					var_187_13:EnableDynamicBone(false)
				end
			end

			local var_187_14 = 0.001

			if var_187_12 <= arg_184_1.time_ and arg_184_1.time_ < var_187_12 + var_187_14 then
				local var_187_15 = (arg_184_1.time_ - var_187_12) / var_187_14
				local var_187_16 = Vector3.New(0.7, -0.985, -6)

				var_187_11.localPosition = Vector3.Lerp(arg_184_1.var_.moveOldPos6148ui_story, var_187_16, var_187_15)

				local var_187_17 = manager.ui.mainCamera.transform.position - var_187_11.position

				var_187_11.forward = Vector3.New(var_187_17.x, var_187_17.y, var_187_17.z)

				local var_187_18 = var_187_11.localEulerAngles

				var_187_18.z = 0
				var_187_18.x = 0
				var_187_11.localEulerAngles = var_187_18
			end

			if arg_184_1.time_ >= var_187_12 + var_187_14 and arg_184_1.time_ < var_187_12 + var_187_14 + arg_187_0 then
				var_187_11.localPosition = Vector3.New(0.7, -0.985, -6)

				local var_187_19 = manager.ui.mainCamera.transform.position - var_187_11.position

				var_187_11.forward = Vector3.New(var_187_19.x, var_187_19.y, var_187_19.z)

				local var_187_20 = var_187_11.localEulerAngles

				var_187_20.z = 0
				var_187_20.x = 0
				var_187_11.localEulerAngles = var_187_20

				local var_187_21 = GameObjectTools.GetOrAddComponent(var_187_11.gameObject, typeof(DynamicBoneHelper))

				if var_187_21 then
					var_187_21:EnableDynamicBone(true)
				end
			end

			local var_187_22 = arg_184_1.actors_["6148ui_story"]
			local var_187_23 = 0

			if var_187_23 < arg_184_1.time_ and arg_184_1.time_ <= var_187_23 + arg_187_0 and not isNil(var_187_22) and arg_184_1.var_.characterEffect6148ui_story == nil then
				arg_184_1.var_.characterEffect6148ui_story = var_187_22:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_187_24 = 0.200000002980232

			if var_187_23 <= arg_184_1.time_ and arg_184_1.time_ < var_187_23 + var_187_24 and not isNil(var_187_22) then
				local var_187_25 = (arg_184_1.time_ - var_187_23) / var_187_24

				if arg_184_1.var_.characterEffect6148ui_story and not isNil(var_187_22) then
					arg_184_1.var_.characterEffect6148ui_story.fillFlat = false
				end
			end

			if arg_184_1.time_ >= var_187_23 + var_187_24 and arg_184_1.time_ < var_187_23 + var_187_24 + arg_187_0 and not isNil(var_187_22) and arg_184_1.var_.characterEffect6148ui_story then
				arg_184_1.var_.characterEffect6148ui_story.fillFlat = false
			end

			local var_187_26 = arg_184_1.actors_["10176ui_story"]
			local var_187_27 = 0

			if var_187_27 < arg_184_1.time_ and arg_184_1.time_ <= var_187_27 + arg_187_0 and not isNil(var_187_26) and arg_184_1.var_.characterEffect10176ui_story == nil then
				arg_184_1.var_.characterEffect10176ui_story = var_187_26:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_187_28 = 0.200000002980232

			if var_187_27 <= arg_184_1.time_ and arg_184_1.time_ < var_187_27 + var_187_28 and not isNil(var_187_26) then
				local var_187_29 = (arg_184_1.time_ - var_187_27) / var_187_28

				if arg_184_1.var_.characterEffect10176ui_story and not isNil(var_187_26) then
					local var_187_30 = Mathf.Lerp(0, 0.5, var_187_29)

					arg_184_1.var_.characterEffect10176ui_story.fillFlat = true
					arg_184_1.var_.characterEffect10176ui_story.fillRatio = var_187_30
				end
			end

			if arg_184_1.time_ >= var_187_27 + var_187_28 and arg_184_1.time_ < var_187_27 + var_187_28 + arg_187_0 and not isNil(var_187_26) and arg_184_1.var_.characterEffect10176ui_story then
				local var_187_31 = 0.5

				arg_184_1.var_.characterEffect10176ui_story.fillFlat = true
				arg_184_1.var_.characterEffect10176ui_story.fillRatio = var_187_31
			end

			local var_187_32 = 0

			if var_187_32 < arg_184_1.time_ and arg_184_1.time_ <= var_187_32 + arg_187_0 then
				arg_184_1:PlayTimeline("6148ui_story", "StoryTimeline/CharAction/story6148/story6148action/6148action1_1")
			end

			local var_187_33 = 0

			if var_187_33 < arg_184_1.time_ and arg_184_1.time_ <= var_187_33 + arg_187_0 then
				arg_184_1:PlayTimeline("6148ui_story", "StoryTimeline/CharAction/public_expression/expr_youyu", "EmotionTimelineAnimator")
			end

			local var_187_34 = 0
			local var_187_35 = 0.625

			if var_187_34 < arg_184_1.time_ and arg_184_1.time_ <= var_187_34 + arg_187_0 then
				arg_184_1.talkMaxDuration = 0
				arg_184_1.dialogCg_.alpha = 1

				arg_184_1.dialog_:SetActive(true)
				SetActive(arg_184_1.leftNameGo_, true)

				local var_187_36 = arg_184_1:FormatText(StoryNameCfg[1488].name)

				arg_184_1.leftNameTxt_.text = var_187_36

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_184_1.leftNameTxt_.transform)

				arg_184_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_184_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_184_1:RecordName(arg_184_1.leftNameTxt_.text)
				SetActive(arg_184_1.iconTrs_.gameObject, false)
				arg_184_1.callingController_:SetSelectedState("normal")

				local var_187_37 = arg_184_1:GetWordFromCfg(325591044)
				local var_187_38 = arg_184_1:FormatText(var_187_37.content)

				arg_184_1.text_.text = var_187_38

				LuaForUtil.ClearLinePrefixSymbol(arg_184_1.text_)

				local var_187_39 = 25
				local var_187_40 = utf8.len(var_187_38)
				local var_187_41 = var_187_39 <= 0 and var_187_35 or var_187_35 * (var_187_40 / var_187_39)

				if var_187_41 > 0 and var_187_35 < var_187_41 then
					arg_184_1.talkMaxDuration = var_187_41

					if var_187_41 + var_187_34 > arg_184_1.duration_ then
						arg_184_1.duration_ = var_187_41 + var_187_34
					end
				end

				arg_184_1.text_.text = var_187_38
				arg_184_1.typewritter.percent = 0

				arg_184_1.typewritter:SetDirty()
				arg_184_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_325591", "325591044", "story_v_out_325591.awb") ~= 0 then
					local var_187_42 = manager.audio:GetVoiceLength("story_v_out_325591", "325591044", "story_v_out_325591.awb") / 1000

					if var_187_42 + var_187_34 > arg_184_1.duration_ then
						arg_184_1.duration_ = var_187_42 + var_187_34
					end

					if var_187_37.prefab_name ~= "" and arg_184_1.actors_[var_187_37.prefab_name] ~= nil then
						local var_187_43 = LuaForUtil.PlayVoiceWithCriLipsync(arg_184_1.actors_[var_187_37.prefab_name].transform, "story_v_out_325591", "325591044", "story_v_out_325591.awb")

						arg_184_1:RecordAudio("325591044", var_187_43)
						arg_184_1:RecordAudio("325591044", var_187_43)
					else
						arg_184_1:AudioAction("play", "voice", "story_v_out_325591", "325591044", "story_v_out_325591.awb")
					end

					arg_184_1:RecordHistoryTalkVoice("story_v_out_325591", "325591044", "story_v_out_325591.awb")
				end

				arg_184_1:RecordContent(arg_184_1.text_.text)
			end

			local var_187_44 = math.max(var_187_35, arg_184_1.talkMaxDuration)

			if var_187_34 <= arg_184_1.time_ and arg_184_1.time_ < var_187_34 + var_187_44 then
				arg_184_1.typewritter.percent = (arg_184_1.time_ - var_187_34) / var_187_44

				arg_184_1.typewritter:SetDirty()
			end

			if arg_184_1.time_ >= var_187_34 + var_187_44 and arg_184_1.time_ < var_187_34 + var_187_44 + arg_187_0 then
				arg_184_1.typewritter.percent = 1

				arg_184_1.typewritter:SetDirty()
				arg_184_1:ShowNextGo(true)
			end
		end

		arg_184_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10176ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "6148ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_184_1:InitPlayNodeList()
	end,
	Play325591045 = function(arg_188_0, arg_188_1)
		arg_188_1.time_ = 0
		arg_188_1.frameCnt_ = 0
		arg_188_1.state_ = "playing"
		arg_188_1.curTalkId_ = 325591045
		arg_188_1.duration_ = 6.07

		local var_188_0 = {
			zh = 5.966,
			ja = 6.066
		}
		local var_188_1 = manager.audio:GetLocalizationFlag()

		if var_188_0[var_188_1] ~= nil then
			arg_188_1.duration_ = var_188_0[var_188_1]
		end

		SetActive(arg_188_1.tipsGo_, false)

		function arg_188_1.onSingleLineFinish_()
			arg_188_1.onSingleLineUpdate_ = nil
			arg_188_1.onSingleLineFinish_ = nil
			arg_188_1.state_ = "waiting"
		end

		function arg_188_1.playNext_(arg_190_0)
			if arg_190_0 == 1 then
				arg_188_0:Play325591046(arg_188_1)
			end
		end

		function arg_188_1.onSingleLineUpdate_(arg_191_0)
			local var_191_0 = 0
			local var_191_1 = 0.6

			if var_191_0 < arg_188_1.time_ and arg_188_1.time_ <= var_191_0 + arg_191_0 then
				arg_188_1.talkMaxDuration = 0
				arg_188_1.dialogCg_.alpha = 1

				arg_188_1.dialog_:SetActive(true)
				SetActive(arg_188_1.leftNameGo_, true)

				local var_191_2 = arg_188_1:FormatText(StoryNameCfg[1488].name)

				arg_188_1.leftNameTxt_.text = var_191_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_188_1.leftNameTxt_.transform)

				arg_188_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_188_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_188_1:RecordName(arg_188_1.leftNameTxt_.text)
				SetActive(arg_188_1.iconTrs_.gameObject, false)
				arg_188_1.callingController_:SetSelectedState("normal")

				local var_191_3 = arg_188_1:GetWordFromCfg(325591045)
				local var_191_4 = arg_188_1:FormatText(var_191_3.content)

				arg_188_1.text_.text = var_191_4

				LuaForUtil.ClearLinePrefixSymbol(arg_188_1.text_)

				local var_191_5 = 24
				local var_191_6 = utf8.len(var_191_4)
				local var_191_7 = var_191_5 <= 0 and var_191_1 or var_191_1 * (var_191_6 / var_191_5)

				if var_191_7 > 0 and var_191_1 < var_191_7 then
					arg_188_1.talkMaxDuration = var_191_7

					if var_191_7 + var_191_0 > arg_188_1.duration_ then
						arg_188_1.duration_ = var_191_7 + var_191_0
					end
				end

				arg_188_1.text_.text = var_191_4
				arg_188_1.typewritter.percent = 0

				arg_188_1.typewritter:SetDirty()
				arg_188_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_325591", "325591045", "story_v_out_325591.awb") ~= 0 then
					local var_191_8 = manager.audio:GetVoiceLength("story_v_out_325591", "325591045", "story_v_out_325591.awb") / 1000

					if var_191_8 + var_191_0 > arg_188_1.duration_ then
						arg_188_1.duration_ = var_191_8 + var_191_0
					end

					if var_191_3.prefab_name ~= "" and arg_188_1.actors_[var_191_3.prefab_name] ~= nil then
						local var_191_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_188_1.actors_[var_191_3.prefab_name].transform, "story_v_out_325591", "325591045", "story_v_out_325591.awb")

						arg_188_1:RecordAudio("325591045", var_191_9)
						arg_188_1:RecordAudio("325591045", var_191_9)
					else
						arg_188_1:AudioAction("play", "voice", "story_v_out_325591", "325591045", "story_v_out_325591.awb")
					end

					arg_188_1:RecordHistoryTalkVoice("story_v_out_325591", "325591045", "story_v_out_325591.awb")
				end

				arg_188_1:RecordContent(arg_188_1.text_.text)
			end

			local var_191_10 = math.max(var_191_1, arg_188_1.talkMaxDuration)

			if var_191_0 <= arg_188_1.time_ and arg_188_1.time_ < var_191_0 + var_191_10 then
				arg_188_1.typewritter.percent = (arg_188_1.time_ - var_191_0) / var_191_10

				arg_188_1.typewritter:SetDirty()
			end

			if arg_188_1.time_ >= var_191_0 + var_191_10 and arg_188_1.time_ < var_191_0 + var_191_10 + arg_191_0 then
				arg_188_1.typewritter.percent = 1

				arg_188_1.typewritter:SetDirty()
				arg_188_1:ShowNextGo(true)
			end
		end

		arg_188_1.nodeConfigList_ = {}

		arg_188_1:InitPlayNodeList()
	end,
	Play325591046 = function(arg_192_0, arg_192_1)
		arg_192_1.time_ = 0
		arg_192_1.frameCnt_ = 0
		arg_192_1.state_ = "playing"
		arg_192_1.curTalkId_ = 325591046
		arg_192_1.duration_ = 5.43

		local var_192_0 = {
			zh = 5.433,
			ja = 4.6
		}
		local var_192_1 = manager.audio:GetLocalizationFlag()

		if var_192_0[var_192_1] ~= nil then
			arg_192_1.duration_ = var_192_0[var_192_1]
		end

		SetActive(arg_192_1.tipsGo_, false)

		function arg_192_1.onSingleLineFinish_()
			arg_192_1.onSingleLineUpdate_ = nil
			arg_192_1.onSingleLineFinish_ = nil
			arg_192_1.state_ = "waiting"
		end

		function arg_192_1.playNext_(arg_194_0)
			if arg_194_0 == 1 then
				arg_192_0:Play325591047(arg_192_1)
			end
		end

		function arg_192_1.onSingleLineUpdate_(arg_195_0)
			local var_195_0 = arg_192_1.actors_["10176ui_story"]
			local var_195_1 = 0

			if var_195_1 < arg_192_1.time_ and arg_192_1.time_ <= var_195_1 + arg_195_0 and not isNil(var_195_0) and arg_192_1.var_.characterEffect10176ui_story == nil then
				arg_192_1.var_.characterEffect10176ui_story = var_195_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_195_2 = 0.200000002980232

			if var_195_1 <= arg_192_1.time_ and arg_192_1.time_ < var_195_1 + var_195_2 and not isNil(var_195_0) then
				local var_195_3 = (arg_192_1.time_ - var_195_1) / var_195_2

				if arg_192_1.var_.characterEffect10176ui_story and not isNil(var_195_0) then
					arg_192_1.var_.characterEffect10176ui_story.fillFlat = false
				end
			end

			if arg_192_1.time_ >= var_195_1 + var_195_2 and arg_192_1.time_ < var_195_1 + var_195_2 + arg_195_0 and not isNil(var_195_0) and arg_192_1.var_.characterEffect10176ui_story then
				arg_192_1.var_.characterEffect10176ui_story.fillFlat = false
			end

			local var_195_4 = arg_192_1.actors_["6148ui_story"]
			local var_195_5 = 0

			if var_195_5 < arg_192_1.time_ and arg_192_1.time_ <= var_195_5 + arg_195_0 and not isNil(var_195_4) and arg_192_1.var_.characterEffect6148ui_story == nil then
				arg_192_1.var_.characterEffect6148ui_story = var_195_4:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_195_6 = 0.200000002980232

			if var_195_5 <= arg_192_1.time_ and arg_192_1.time_ < var_195_5 + var_195_6 and not isNil(var_195_4) then
				local var_195_7 = (arg_192_1.time_ - var_195_5) / var_195_6

				if arg_192_1.var_.characterEffect6148ui_story and not isNil(var_195_4) then
					local var_195_8 = Mathf.Lerp(0, 0.5, var_195_7)

					arg_192_1.var_.characterEffect6148ui_story.fillFlat = true
					arg_192_1.var_.characterEffect6148ui_story.fillRatio = var_195_8
				end
			end

			if arg_192_1.time_ >= var_195_5 + var_195_6 and arg_192_1.time_ < var_195_5 + var_195_6 + arg_195_0 and not isNil(var_195_4) and arg_192_1.var_.characterEffect6148ui_story then
				local var_195_9 = 0.5

				arg_192_1.var_.characterEffect6148ui_story.fillFlat = true
				arg_192_1.var_.characterEffect6148ui_story.fillRatio = var_195_9
			end

			local var_195_10 = 0

			if var_195_10 < arg_192_1.time_ and arg_192_1.time_ <= var_195_10 + arg_195_0 then
				arg_192_1:PlayTimeline("10176ui_story", "StoryTimeline/CharAction/story10176/story10176action/10176action7_1")
			end

			local var_195_11 = 0

			if var_195_11 < arg_192_1.time_ and arg_192_1.time_ <= var_195_11 + arg_195_0 then
				arg_192_1:PlayTimeline("10176ui_story", "StoryTimeline/CharAction/public_expression/expr_xinwei", "EmotionTimelineAnimator")
			end

			local var_195_12 = 0
			local var_195_13 = 0.475

			if var_195_12 < arg_192_1.time_ and arg_192_1.time_ <= var_195_12 + arg_195_0 then
				arg_192_1.talkMaxDuration = 0
				arg_192_1.dialogCg_.alpha = 1

				arg_192_1.dialog_:SetActive(true)
				SetActive(arg_192_1.leftNameGo_, true)

				local var_195_14 = arg_192_1:FormatText(StoryNameCfg[1510].name)

				arg_192_1.leftNameTxt_.text = var_195_14

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_192_1.leftNameTxt_.transform)

				arg_192_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_192_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_192_1:RecordName(arg_192_1.leftNameTxt_.text)
				SetActive(arg_192_1.iconTrs_.gameObject, false)
				arg_192_1.callingController_:SetSelectedState("normal")

				local var_195_15 = arg_192_1:GetWordFromCfg(325591046)
				local var_195_16 = arg_192_1:FormatText(var_195_15.content)

				arg_192_1.text_.text = var_195_16

				LuaForUtil.ClearLinePrefixSymbol(arg_192_1.text_)

				local var_195_17 = 19
				local var_195_18 = utf8.len(var_195_16)
				local var_195_19 = var_195_17 <= 0 and var_195_13 or var_195_13 * (var_195_18 / var_195_17)

				if var_195_19 > 0 and var_195_13 < var_195_19 then
					arg_192_1.talkMaxDuration = var_195_19

					if var_195_19 + var_195_12 > arg_192_1.duration_ then
						arg_192_1.duration_ = var_195_19 + var_195_12
					end
				end

				arg_192_1.text_.text = var_195_16
				arg_192_1.typewritter.percent = 0

				arg_192_1.typewritter:SetDirty()
				arg_192_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_325591", "325591046", "story_v_out_325591.awb") ~= 0 then
					local var_195_20 = manager.audio:GetVoiceLength("story_v_out_325591", "325591046", "story_v_out_325591.awb") / 1000

					if var_195_20 + var_195_12 > arg_192_1.duration_ then
						arg_192_1.duration_ = var_195_20 + var_195_12
					end

					if var_195_15.prefab_name ~= "" and arg_192_1.actors_[var_195_15.prefab_name] ~= nil then
						local var_195_21 = LuaForUtil.PlayVoiceWithCriLipsync(arg_192_1.actors_[var_195_15.prefab_name].transform, "story_v_out_325591", "325591046", "story_v_out_325591.awb")

						arg_192_1:RecordAudio("325591046", var_195_21)
						arg_192_1:RecordAudio("325591046", var_195_21)
					else
						arg_192_1:AudioAction("play", "voice", "story_v_out_325591", "325591046", "story_v_out_325591.awb")
					end

					arg_192_1:RecordHistoryTalkVoice("story_v_out_325591", "325591046", "story_v_out_325591.awb")
				end

				arg_192_1:RecordContent(arg_192_1.text_.text)
			end

			local var_195_22 = math.max(var_195_13, arg_192_1.talkMaxDuration)

			if var_195_12 <= arg_192_1.time_ and arg_192_1.time_ < var_195_12 + var_195_22 then
				arg_192_1.typewritter.percent = (arg_192_1.time_ - var_195_12) / var_195_22

				arg_192_1.typewritter:SetDirty()
			end

			if arg_192_1.time_ >= var_195_12 + var_195_22 and arg_192_1.time_ < var_195_12 + var_195_22 + arg_195_0 then
				arg_192_1.typewritter.percent = 1

				arg_192_1.typewritter:SetDirty()
				arg_192_1:ShowNextGo(true)
			end
		end

		arg_192_1.nodeConfigList_ = {}

		arg_192_1:InitPlayNodeList()
	end,
	Play325591047 = function(arg_196_0, arg_196_1)
		arg_196_1.time_ = 0
		arg_196_1.frameCnt_ = 0
		arg_196_1.state_ = "playing"
		arg_196_1.curTalkId_ = 325591047
		arg_196_1.duration_ = 5.53

		local var_196_0 = {
			zh = 5.533,
			ja = 5.033
		}
		local var_196_1 = manager.audio:GetLocalizationFlag()

		if var_196_0[var_196_1] ~= nil then
			arg_196_1.duration_ = var_196_0[var_196_1]
		end

		SetActive(arg_196_1.tipsGo_, false)

		function arg_196_1.onSingleLineFinish_()
			arg_196_1.onSingleLineUpdate_ = nil
			arg_196_1.onSingleLineFinish_ = nil
			arg_196_1.state_ = "waiting"
		end

		function arg_196_1.playNext_(arg_198_0)
			if arg_198_0 == 1 then
				arg_196_0:Play325591048(arg_196_1)
			end
		end

		function arg_196_1.onSingleLineUpdate_(arg_199_0)
			local var_199_0 = arg_196_1.actors_["10176ui_story"].transform
			local var_199_1 = 0

			if var_199_1 < arg_196_1.time_ and arg_196_1.time_ <= var_199_1 + arg_199_0 then
				arg_196_1.var_.moveOldPos10176ui_story = var_199_0.localPosition

				local var_199_2 = GameObjectTools.GetOrAddComponent(var_199_0.gameObject, typeof(DynamicBoneHelper))

				if var_199_2 then
					var_199_2:EnableDynamicBone(false)
				end
			end

			local var_199_3 = 0.001

			if var_199_1 <= arg_196_1.time_ and arg_196_1.time_ < var_199_1 + var_199_3 then
				local var_199_4 = (arg_196_1.time_ - var_199_1) / var_199_3
				local var_199_5 = Vector3.New(0, 100, 0)

				var_199_0.localPosition = Vector3.Lerp(arg_196_1.var_.moveOldPos10176ui_story, var_199_5, var_199_4)

				local var_199_6 = manager.ui.mainCamera.transform.position - var_199_0.position

				var_199_0.forward = Vector3.New(var_199_6.x, var_199_6.y, var_199_6.z)

				local var_199_7 = var_199_0.localEulerAngles

				var_199_7.z = 0
				var_199_7.x = 0
				var_199_0.localEulerAngles = var_199_7
			end

			if arg_196_1.time_ >= var_199_1 + var_199_3 and arg_196_1.time_ < var_199_1 + var_199_3 + arg_199_0 then
				var_199_0.localPosition = Vector3.New(0, 100, 0)

				local var_199_8 = manager.ui.mainCamera.transform.position - var_199_0.position

				var_199_0.forward = Vector3.New(var_199_8.x, var_199_8.y, var_199_8.z)

				local var_199_9 = var_199_0.localEulerAngles

				var_199_9.z = 0
				var_199_9.x = 0
				var_199_0.localEulerAngles = var_199_9

				local var_199_10 = GameObjectTools.GetOrAddComponent(var_199_0.gameObject, typeof(DynamicBoneHelper))

				if var_199_10 then
					var_199_10:EnableDynamicBone(true)
				end
			end

			local var_199_11 = arg_196_1.actors_["1054ui_story"].transform
			local var_199_12 = 0

			if var_199_12 < arg_196_1.time_ and arg_196_1.time_ <= var_199_12 + arg_199_0 then
				arg_196_1.var_.moveOldPos1054ui_story = var_199_11.localPosition

				local var_199_13 = GameObjectTools.GetOrAddComponent(var_199_11.gameObject, typeof(DynamicBoneHelper))

				if var_199_13 then
					var_199_13:EnableDynamicBone(false)
				end
			end

			local var_199_14 = 0.001

			if var_199_12 <= arg_196_1.time_ and arg_196_1.time_ < var_199_12 + var_199_14 then
				local var_199_15 = (arg_196_1.time_ - var_199_12) / var_199_14
				local var_199_16 = Vector3.New(-0.7, -0.985, -6)

				var_199_11.localPosition = Vector3.Lerp(arg_196_1.var_.moveOldPos1054ui_story, var_199_16, var_199_15)

				local var_199_17 = manager.ui.mainCamera.transform.position - var_199_11.position

				var_199_11.forward = Vector3.New(var_199_17.x, var_199_17.y, var_199_17.z)

				local var_199_18 = var_199_11.localEulerAngles

				var_199_18.z = 0
				var_199_18.x = 0
				var_199_11.localEulerAngles = var_199_18
			end

			if arg_196_1.time_ >= var_199_12 + var_199_14 and arg_196_1.time_ < var_199_12 + var_199_14 + arg_199_0 then
				var_199_11.localPosition = Vector3.New(-0.7, -0.985, -6)

				local var_199_19 = manager.ui.mainCamera.transform.position - var_199_11.position

				var_199_11.forward = Vector3.New(var_199_19.x, var_199_19.y, var_199_19.z)

				local var_199_20 = var_199_11.localEulerAngles

				var_199_20.z = 0
				var_199_20.x = 0
				var_199_11.localEulerAngles = var_199_20

				local var_199_21 = GameObjectTools.GetOrAddComponent(var_199_11.gameObject, typeof(DynamicBoneHelper))

				if var_199_21 then
					var_199_21:EnableDynamicBone(true)
				end
			end

			local var_199_22 = arg_196_1.actors_["1054ui_story"]
			local var_199_23 = 0

			if var_199_23 < arg_196_1.time_ and arg_196_1.time_ <= var_199_23 + arg_199_0 and not isNil(var_199_22) and arg_196_1.var_.characterEffect1054ui_story == nil then
				arg_196_1.var_.characterEffect1054ui_story = var_199_22:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_199_24 = 0.200000002980232

			if var_199_23 <= arg_196_1.time_ and arg_196_1.time_ < var_199_23 + var_199_24 and not isNil(var_199_22) then
				local var_199_25 = (arg_196_1.time_ - var_199_23) / var_199_24

				if arg_196_1.var_.characterEffect1054ui_story and not isNil(var_199_22) then
					arg_196_1.var_.characterEffect1054ui_story.fillFlat = false
				end
			end

			if arg_196_1.time_ >= var_199_23 + var_199_24 and arg_196_1.time_ < var_199_23 + var_199_24 + arg_199_0 and not isNil(var_199_22) and arg_196_1.var_.characterEffect1054ui_story then
				arg_196_1.var_.characterEffect1054ui_story.fillFlat = false
			end

			local var_199_26 = arg_196_1.actors_["10176ui_story"]
			local var_199_27 = 0

			if var_199_27 < arg_196_1.time_ and arg_196_1.time_ <= var_199_27 + arg_199_0 and not isNil(var_199_26) and arg_196_1.var_.characterEffect10176ui_story == nil then
				arg_196_1.var_.characterEffect10176ui_story = var_199_26:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_199_28 = 0.200000002980232

			if var_199_27 <= arg_196_1.time_ and arg_196_1.time_ < var_199_27 + var_199_28 and not isNil(var_199_26) then
				local var_199_29 = (arg_196_1.time_ - var_199_27) / var_199_28

				if arg_196_1.var_.characterEffect10176ui_story and not isNil(var_199_26) then
					local var_199_30 = Mathf.Lerp(0, 0.5, var_199_29)

					arg_196_1.var_.characterEffect10176ui_story.fillFlat = true
					arg_196_1.var_.characterEffect10176ui_story.fillRatio = var_199_30
				end
			end

			if arg_196_1.time_ >= var_199_27 + var_199_28 and arg_196_1.time_ < var_199_27 + var_199_28 + arg_199_0 and not isNil(var_199_26) and arg_196_1.var_.characterEffect10176ui_story then
				local var_199_31 = 0.5

				arg_196_1.var_.characterEffect10176ui_story.fillFlat = true
				arg_196_1.var_.characterEffect10176ui_story.fillRatio = var_199_31
			end

			local var_199_32 = 0

			if var_199_32 < arg_196_1.time_ and arg_196_1.time_ <= var_199_32 + arg_199_0 then
				arg_196_1:PlayTimeline("1054ui_story", "StoryTimeline/CharAction/story1054/story1054action/1054action1_1")
			end

			local var_199_33 = 0

			if var_199_33 < arg_196_1.time_ and arg_196_1.time_ <= var_199_33 + arg_199_0 then
				arg_196_1:PlayTimeline("1054ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0101cva", "EmotionTimelineAnimator")
			end

			local var_199_34 = 0
			local var_199_35 = 0.55

			if var_199_34 < arg_196_1.time_ and arg_196_1.time_ <= var_199_34 + arg_199_0 then
				arg_196_1.talkMaxDuration = 0
				arg_196_1.dialogCg_.alpha = 1

				arg_196_1.dialog_:SetActive(true)
				SetActive(arg_196_1.leftNameGo_, true)

				local var_199_36 = arg_196_1:FormatText(StoryNameCfg[1487].name)

				arg_196_1.leftNameTxt_.text = var_199_36

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_196_1.leftNameTxt_.transform)

				arg_196_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_196_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_196_1:RecordName(arg_196_1.leftNameTxt_.text)
				SetActive(arg_196_1.iconTrs_.gameObject, false)
				arg_196_1.callingController_:SetSelectedState("normal")

				local var_199_37 = arg_196_1:GetWordFromCfg(325591047)
				local var_199_38 = arg_196_1:FormatText(var_199_37.content)

				arg_196_1.text_.text = var_199_38

				LuaForUtil.ClearLinePrefixSymbol(arg_196_1.text_)

				local var_199_39 = 22
				local var_199_40 = utf8.len(var_199_38)
				local var_199_41 = var_199_39 <= 0 and var_199_35 or var_199_35 * (var_199_40 / var_199_39)

				if var_199_41 > 0 and var_199_35 < var_199_41 then
					arg_196_1.talkMaxDuration = var_199_41

					if var_199_41 + var_199_34 > arg_196_1.duration_ then
						arg_196_1.duration_ = var_199_41 + var_199_34
					end
				end

				arg_196_1.text_.text = var_199_38
				arg_196_1.typewritter.percent = 0

				arg_196_1.typewritter:SetDirty()
				arg_196_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_325591", "325591047", "story_v_out_325591.awb") ~= 0 then
					local var_199_42 = manager.audio:GetVoiceLength("story_v_out_325591", "325591047", "story_v_out_325591.awb") / 1000

					if var_199_42 + var_199_34 > arg_196_1.duration_ then
						arg_196_1.duration_ = var_199_42 + var_199_34
					end

					if var_199_37.prefab_name ~= "" and arg_196_1.actors_[var_199_37.prefab_name] ~= nil then
						local var_199_43 = LuaForUtil.PlayVoiceWithCriLipsync(arg_196_1.actors_[var_199_37.prefab_name].transform, "story_v_out_325591", "325591047", "story_v_out_325591.awb")

						arg_196_1:RecordAudio("325591047", var_199_43)
						arg_196_1:RecordAudio("325591047", var_199_43)
					else
						arg_196_1:AudioAction("play", "voice", "story_v_out_325591", "325591047", "story_v_out_325591.awb")
					end

					arg_196_1:RecordHistoryTalkVoice("story_v_out_325591", "325591047", "story_v_out_325591.awb")
				end

				arg_196_1:RecordContent(arg_196_1.text_.text)
			end

			local var_199_44 = math.max(var_199_35, arg_196_1.talkMaxDuration)

			if var_199_34 <= arg_196_1.time_ and arg_196_1.time_ < var_199_34 + var_199_44 then
				arg_196_1.typewritter.percent = (arg_196_1.time_ - var_199_34) / var_199_44

				arg_196_1.typewritter:SetDirty()
			end

			if arg_196_1.time_ >= var_199_34 + var_199_44 and arg_196_1.time_ < var_199_34 + var_199_44 + arg_199_0 then
				arg_196_1.typewritter.percent = 1

				arg_196_1.typewritter:SetDirty()
				arg_196_1:ShowNextGo(true)
			end
		end

		arg_196_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10176ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1054ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_196_1:InitPlayNodeList()
	end,
	Play325591048 = function(arg_200_0, arg_200_1)
		arg_200_1.time_ = 0
		arg_200_1.frameCnt_ = 0
		arg_200_1.state_ = "playing"
		arg_200_1.curTalkId_ = 325591048
		arg_200_1.duration_ = 5

		SetActive(arg_200_1.tipsGo_, false)

		function arg_200_1.onSingleLineFinish_()
			arg_200_1.onSingleLineUpdate_ = nil
			arg_200_1.onSingleLineFinish_ = nil
			arg_200_1.state_ = "waiting"
		end

		function arg_200_1.playNext_(arg_202_0)
			if arg_202_0 == 1 then
				arg_200_0:Play325591049(arg_200_1)
			end
		end

		function arg_200_1.onSingleLineUpdate_(arg_203_0)
			local var_203_0 = arg_200_1.actors_["1054ui_story"]
			local var_203_1 = 0

			if var_203_1 < arg_200_1.time_ and arg_200_1.time_ <= var_203_1 + arg_203_0 and not isNil(var_203_0) and arg_200_1.var_.characterEffect1054ui_story == nil then
				arg_200_1.var_.characterEffect1054ui_story = var_203_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_203_2 = 0.200000002980232

			if var_203_1 <= arg_200_1.time_ and arg_200_1.time_ < var_203_1 + var_203_2 and not isNil(var_203_0) then
				local var_203_3 = (arg_200_1.time_ - var_203_1) / var_203_2

				if arg_200_1.var_.characterEffect1054ui_story and not isNil(var_203_0) then
					local var_203_4 = Mathf.Lerp(0, 0.5, var_203_3)

					arg_200_1.var_.characterEffect1054ui_story.fillFlat = true
					arg_200_1.var_.characterEffect1054ui_story.fillRatio = var_203_4
				end
			end

			if arg_200_1.time_ >= var_203_1 + var_203_2 and arg_200_1.time_ < var_203_1 + var_203_2 + arg_203_0 and not isNil(var_203_0) and arg_200_1.var_.characterEffect1054ui_story then
				local var_203_5 = 0.5

				arg_200_1.var_.characterEffect1054ui_story.fillFlat = true
				arg_200_1.var_.characterEffect1054ui_story.fillRatio = var_203_5
			end

			local var_203_6 = 0
			local var_203_7 = 0.85

			if var_203_6 < arg_200_1.time_ and arg_200_1.time_ <= var_203_6 + arg_203_0 then
				arg_200_1.talkMaxDuration = 0
				arg_200_1.dialogCg_.alpha = 1

				arg_200_1.dialog_:SetActive(true)
				SetActive(arg_200_1.leftNameGo_, false)

				arg_200_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_200_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_200_1:RecordName(arg_200_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_200_1.iconTrs_.gameObject, false)
				arg_200_1.callingController_:SetSelectedState("normal")

				local var_203_8 = arg_200_1:GetWordFromCfg(325591048)
				local var_203_9 = arg_200_1:FormatText(var_203_8.content)

				arg_200_1.text_.text = var_203_9

				LuaForUtil.ClearLinePrefixSymbol(arg_200_1.text_)

				local var_203_10 = 34
				local var_203_11 = utf8.len(var_203_9)
				local var_203_12 = var_203_10 <= 0 and var_203_7 or var_203_7 * (var_203_11 / var_203_10)

				if var_203_12 > 0 and var_203_7 < var_203_12 then
					arg_200_1.talkMaxDuration = var_203_12

					if var_203_12 + var_203_6 > arg_200_1.duration_ then
						arg_200_1.duration_ = var_203_12 + var_203_6
					end
				end

				arg_200_1.text_.text = var_203_9
				arg_200_1.typewritter.percent = 0

				arg_200_1.typewritter:SetDirty()
				arg_200_1:ShowNextGo(false)
				arg_200_1:RecordContent(arg_200_1.text_.text)
			end

			local var_203_13 = math.max(var_203_7, arg_200_1.talkMaxDuration)

			if var_203_6 <= arg_200_1.time_ and arg_200_1.time_ < var_203_6 + var_203_13 then
				arg_200_1.typewritter.percent = (arg_200_1.time_ - var_203_6) / var_203_13

				arg_200_1.typewritter:SetDirty()
			end

			if arg_200_1.time_ >= var_203_6 + var_203_13 and arg_200_1.time_ < var_203_6 + var_203_13 + arg_203_0 then
				arg_200_1.typewritter.percent = 1

				arg_200_1.typewritter:SetDirty()
				arg_200_1:ShowNextGo(true)
			end
		end

		arg_200_1.nodeConfigList_ = {}

		arg_200_1:InitPlayNodeList()
	end,
	Play325591049 = function(arg_204_0, arg_204_1)
		arg_204_1.time_ = 0
		arg_204_1.frameCnt_ = 0
		arg_204_1.state_ = "playing"
		arg_204_1.curTalkId_ = 325591049
		arg_204_1.duration_ = 12.8

		local var_204_0 = {
			zh = 9.433,
			ja = 12.8
		}
		local var_204_1 = manager.audio:GetLocalizationFlag()

		if var_204_0[var_204_1] ~= nil then
			arg_204_1.duration_ = var_204_0[var_204_1]
		end

		SetActive(arg_204_1.tipsGo_, false)

		function arg_204_1.onSingleLineFinish_()
			arg_204_1.onSingleLineUpdate_ = nil
			arg_204_1.onSingleLineFinish_ = nil
			arg_204_1.state_ = "waiting"
		end

		function arg_204_1.playNext_(arg_206_0)
			if arg_206_0 == 1 then
				arg_204_0:Play325591050(arg_204_1)
			end
		end

		function arg_204_1.onSingleLineUpdate_(arg_207_0)
			local var_207_0 = arg_204_1.actors_["10176ui_story"].transform
			local var_207_1 = 0

			if var_207_1 < arg_204_1.time_ and arg_204_1.time_ <= var_207_1 + arg_207_0 then
				arg_204_1.var_.moveOldPos10176ui_story = var_207_0.localPosition

				local var_207_2 = GameObjectTools.GetOrAddComponent(var_207_0.gameObject, typeof(DynamicBoneHelper))

				if var_207_2 then
					var_207_2:EnableDynamicBone(false)
				end
			end

			local var_207_3 = 0.001

			if var_207_1 <= arg_204_1.time_ and arg_204_1.time_ < var_207_1 + var_207_3 then
				local var_207_4 = (arg_204_1.time_ - var_207_1) / var_207_3
				local var_207_5 = Vector3.New(-0.02, -1.09, -6.12)

				var_207_0.localPosition = Vector3.Lerp(arg_204_1.var_.moveOldPos10176ui_story, var_207_5, var_207_4)

				local var_207_6 = manager.ui.mainCamera.transform.position - var_207_0.position

				var_207_0.forward = Vector3.New(var_207_6.x, var_207_6.y, var_207_6.z)

				local var_207_7 = var_207_0.localEulerAngles

				var_207_7.z = 0
				var_207_7.x = 0
				var_207_0.localEulerAngles = var_207_7
			end

			if arg_204_1.time_ >= var_207_1 + var_207_3 and arg_204_1.time_ < var_207_1 + var_207_3 + arg_207_0 then
				var_207_0.localPosition = Vector3.New(-0.02, -1.09, -6.12)

				local var_207_8 = manager.ui.mainCamera.transform.position - var_207_0.position

				var_207_0.forward = Vector3.New(var_207_8.x, var_207_8.y, var_207_8.z)

				local var_207_9 = var_207_0.localEulerAngles

				var_207_9.z = 0
				var_207_9.x = 0
				var_207_0.localEulerAngles = var_207_9

				local var_207_10 = GameObjectTools.GetOrAddComponent(var_207_0.gameObject, typeof(DynamicBoneHelper))

				if var_207_10 then
					var_207_10:EnableDynamicBone(true)
				end
			end

			local var_207_11 = arg_204_1.actors_["6148ui_story"].transform
			local var_207_12 = 0

			if var_207_12 < arg_204_1.time_ and arg_204_1.time_ <= var_207_12 + arg_207_0 then
				arg_204_1.var_.moveOldPos6148ui_story = var_207_11.localPosition

				local var_207_13 = GameObjectTools.GetOrAddComponent(var_207_11.gameObject, typeof(DynamicBoneHelper))

				if var_207_13 then
					var_207_13:EnableDynamicBone(false)
				end
			end

			local var_207_14 = 0.001

			if var_207_12 <= arg_204_1.time_ and arg_204_1.time_ < var_207_12 + var_207_14 then
				local var_207_15 = (arg_204_1.time_ - var_207_12) / var_207_14
				local var_207_16 = Vector3.New(0, 100, 0)

				var_207_11.localPosition = Vector3.Lerp(arg_204_1.var_.moveOldPos6148ui_story, var_207_16, var_207_15)

				local var_207_17 = manager.ui.mainCamera.transform.position - var_207_11.position

				var_207_11.forward = Vector3.New(var_207_17.x, var_207_17.y, var_207_17.z)

				local var_207_18 = var_207_11.localEulerAngles

				var_207_18.z = 0
				var_207_18.x = 0
				var_207_11.localEulerAngles = var_207_18
			end

			if arg_204_1.time_ >= var_207_12 + var_207_14 and arg_204_1.time_ < var_207_12 + var_207_14 + arg_207_0 then
				var_207_11.localPosition = Vector3.New(0, 100, 0)

				local var_207_19 = manager.ui.mainCamera.transform.position - var_207_11.position

				var_207_11.forward = Vector3.New(var_207_19.x, var_207_19.y, var_207_19.z)

				local var_207_20 = var_207_11.localEulerAngles

				var_207_20.z = 0
				var_207_20.x = 0
				var_207_11.localEulerAngles = var_207_20

				local var_207_21 = GameObjectTools.GetOrAddComponent(var_207_11.gameObject, typeof(DynamicBoneHelper))

				if var_207_21 then
					var_207_21:EnableDynamicBone(true)
				end
			end

			local var_207_22 = arg_204_1.actors_["1054ui_story"].transform
			local var_207_23 = 0

			if var_207_23 < arg_204_1.time_ and arg_204_1.time_ <= var_207_23 + arg_207_0 then
				arg_204_1.var_.moveOldPos1054ui_story = var_207_22.localPosition

				local var_207_24 = GameObjectTools.GetOrAddComponent(var_207_22.gameObject, typeof(DynamicBoneHelper))

				if var_207_24 then
					var_207_24:EnableDynamicBone(false)
				end
			end

			local var_207_25 = 0.001

			if var_207_23 <= arg_204_1.time_ and arg_204_1.time_ < var_207_23 + var_207_25 then
				local var_207_26 = (arg_204_1.time_ - var_207_23) / var_207_25
				local var_207_27 = Vector3.New(0, 100, 0)

				var_207_22.localPosition = Vector3.Lerp(arg_204_1.var_.moveOldPos1054ui_story, var_207_27, var_207_26)

				local var_207_28 = manager.ui.mainCamera.transform.position - var_207_22.position

				var_207_22.forward = Vector3.New(var_207_28.x, var_207_28.y, var_207_28.z)

				local var_207_29 = var_207_22.localEulerAngles

				var_207_29.z = 0
				var_207_29.x = 0
				var_207_22.localEulerAngles = var_207_29
			end

			if arg_204_1.time_ >= var_207_23 + var_207_25 and arg_204_1.time_ < var_207_23 + var_207_25 + arg_207_0 then
				var_207_22.localPosition = Vector3.New(0, 100, 0)

				local var_207_30 = manager.ui.mainCamera.transform.position - var_207_22.position

				var_207_22.forward = Vector3.New(var_207_30.x, var_207_30.y, var_207_30.z)

				local var_207_31 = var_207_22.localEulerAngles

				var_207_31.z = 0
				var_207_31.x = 0
				var_207_22.localEulerAngles = var_207_31

				local var_207_32 = GameObjectTools.GetOrAddComponent(var_207_22.gameObject, typeof(DynamicBoneHelper))

				if var_207_32 then
					var_207_32:EnableDynamicBone(true)
				end
			end

			local var_207_33 = arg_204_1.actors_["10176ui_story"]
			local var_207_34 = 0

			if var_207_34 < arg_204_1.time_ and arg_204_1.time_ <= var_207_34 + arg_207_0 and not isNil(var_207_33) and arg_204_1.var_.characterEffect10176ui_story == nil then
				arg_204_1.var_.characterEffect10176ui_story = var_207_33:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_207_35 = 0.200000002980232

			if var_207_34 <= arg_204_1.time_ and arg_204_1.time_ < var_207_34 + var_207_35 and not isNil(var_207_33) then
				local var_207_36 = (arg_204_1.time_ - var_207_34) / var_207_35

				if arg_204_1.var_.characterEffect10176ui_story and not isNil(var_207_33) then
					arg_204_1.var_.characterEffect10176ui_story.fillFlat = false
				end
			end

			if arg_204_1.time_ >= var_207_34 + var_207_35 and arg_204_1.time_ < var_207_34 + var_207_35 + arg_207_0 and not isNil(var_207_33) and arg_204_1.var_.characterEffect10176ui_story then
				arg_204_1.var_.characterEffect10176ui_story.fillFlat = false
			end

			local var_207_37 = 0

			if var_207_37 < arg_204_1.time_ and arg_204_1.time_ <= var_207_37 + arg_207_0 then
				arg_204_1:PlayTimeline("10176ui_story", "StoryTimeline/CharAction/story10176/story10176action/10176action4_1")
			end

			local var_207_38 = 0

			if var_207_38 < arg_204_1.time_ and arg_204_1.time_ <= var_207_38 + arg_207_0 then
				arg_204_1:PlayTimeline("10176ui_story", "StoryTimeline/CharAction/public_expression/expr_xinwei", "EmotionTimelineAnimator")
			end

			local var_207_39 = 0
			local var_207_40 = 0.975

			if var_207_39 < arg_204_1.time_ and arg_204_1.time_ <= var_207_39 + arg_207_0 then
				arg_204_1.talkMaxDuration = 0
				arg_204_1.dialogCg_.alpha = 1

				arg_204_1.dialog_:SetActive(true)
				SetActive(arg_204_1.leftNameGo_, true)

				local var_207_41 = arg_204_1:FormatText(StoryNameCfg[1510].name)

				arg_204_1.leftNameTxt_.text = var_207_41

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_204_1.leftNameTxt_.transform)

				arg_204_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_204_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_204_1:RecordName(arg_204_1.leftNameTxt_.text)
				SetActive(arg_204_1.iconTrs_.gameObject, false)
				arg_204_1.callingController_:SetSelectedState("normal")

				local var_207_42 = arg_204_1:GetWordFromCfg(325591049)
				local var_207_43 = arg_204_1:FormatText(var_207_42.content)

				arg_204_1.text_.text = var_207_43

				LuaForUtil.ClearLinePrefixSymbol(arg_204_1.text_)

				local var_207_44 = 39
				local var_207_45 = utf8.len(var_207_43)
				local var_207_46 = var_207_44 <= 0 and var_207_40 or var_207_40 * (var_207_45 / var_207_44)

				if var_207_46 > 0 and var_207_40 < var_207_46 then
					arg_204_1.talkMaxDuration = var_207_46

					if var_207_46 + var_207_39 > arg_204_1.duration_ then
						arg_204_1.duration_ = var_207_46 + var_207_39
					end
				end

				arg_204_1.text_.text = var_207_43
				arg_204_1.typewritter.percent = 0

				arg_204_1.typewritter:SetDirty()
				arg_204_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_325591", "325591049", "story_v_out_325591.awb") ~= 0 then
					local var_207_47 = manager.audio:GetVoiceLength("story_v_out_325591", "325591049", "story_v_out_325591.awb") / 1000

					if var_207_47 + var_207_39 > arg_204_1.duration_ then
						arg_204_1.duration_ = var_207_47 + var_207_39
					end

					if var_207_42.prefab_name ~= "" and arg_204_1.actors_[var_207_42.prefab_name] ~= nil then
						local var_207_48 = LuaForUtil.PlayVoiceWithCriLipsync(arg_204_1.actors_[var_207_42.prefab_name].transform, "story_v_out_325591", "325591049", "story_v_out_325591.awb")

						arg_204_1:RecordAudio("325591049", var_207_48)
						arg_204_1:RecordAudio("325591049", var_207_48)
					else
						arg_204_1:AudioAction("play", "voice", "story_v_out_325591", "325591049", "story_v_out_325591.awb")
					end

					arg_204_1:RecordHistoryTalkVoice("story_v_out_325591", "325591049", "story_v_out_325591.awb")
				end

				arg_204_1:RecordContent(arg_204_1.text_.text)
			end

			local var_207_49 = math.max(var_207_40, arg_204_1.talkMaxDuration)

			if var_207_39 <= arg_204_1.time_ and arg_204_1.time_ < var_207_39 + var_207_49 then
				arg_204_1.typewritter.percent = (arg_204_1.time_ - var_207_39) / var_207_49

				arg_204_1.typewritter:SetDirty()
			end

			if arg_204_1.time_ >= var_207_39 + var_207_49 and arg_204_1.time_ < var_207_39 + var_207_49 + arg_207_0 then
				arg_204_1.typewritter.percent = 1

				arg_204_1.typewritter:SetDirty()
				arg_204_1:ShowNextGo(true)
			end
		end

		arg_204_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10176ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "6148ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1054ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_204_1:InitPlayNodeList()
	end,
	Play325591050 = function(arg_208_0, arg_208_1)
		arg_208_1.time_ = 0
		arg_208_1.frameCnt_ = 0
		arg_208_1.state_ = "playing"
		arg_208_1.curTalkId_ = 325591050
		arg_208_1.duration_ = 7.47

		local var_208_0 = {
			zh = 6.9,
			ja = 7.466
		}
		local var_208_1 = manager.audio:GetLocalizationFlag()

		if var_208_0[var_208_1] ~= nil then
			arg_208_1.duration_ = var_208_0[var_208_1]
		end

		SetActive(arg_208_1.tipsGo_, false)

		function arg_208_1.onSingleLineFinish_()
			arg_208_1.onSingleLineUpdate_ = nil
			arg_208_1.onSingleLineFinish_ = nil
			arg_208_1.state_ = "waiting"
		end

		function arg_208_1.playNext_(arg_210_0)
			if arg_210_0 == 1 then
				arg_208_0:Play325591051(arg_208_1)
			end
		end

		function arg_208_1.onSingleLineUpdate_(arg_211_0)
			local var_211_0 = 0
			local var_211_1 = 0.725

			if var_211_0 < arg_208_1.time_ and arg_208_1.time_ <= var_211_0 + arg_211_0 then
				arg_208_1.talkMaxDuration = 0
				arg_208_1.dialogCg_.alpha = 1

				arg_208_1.dialog_:SetActive(true)
				SetActive(arg_208_1.leftNameGo_, true)

				local var_211_2 = arg_208_1:FormatText(StoryNameCfg[1510].name)

				arg_208_1.leftNameTxt_.text = var_211_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_208_1.leftNameTxt_.transform)

				arg_208_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_208_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_208_1:RecordName(arg_208_1.leftNameTxt_.text)
				SetActive(arg_208_1.iconTrs_.gameObject, false)
				arg_208_1.callingController_:SetSelectedState("normal")

				local var_211_3 = arg_208_1:GetWordFromCfg(325591050)
				local var_211_4 = arg_208_1:FormatText(var_211_3.content)

				arg_208_1.text_.text = var_211_4

				LuaForUtil.ClearLinePrefixSymbol(arg_208_1.text_)

				local var_211_5 = 29
				local var_211_6 = utf8.len(var_211_4)
				local var_211_7 = var_211_5 <= 0 and var_211_1 or var_211_1 * (var_211_6 / var_211_5)

				if var_211_7 > 0 and var_211_1 < var_211_7 then
					arg_208_1.talkMaxDuration = var_211_7

					if var_211_7 + var_211_0 > arg_208_1.duration_ then
						arg_208_1.duration_ = var_211_7 + var_211_0
					end
				end

				arg_208_1.text_.text = var_211_4
				arg_208_1.typewritter.percent = 0

				arg_208_1.typewritter:SetDirty()
				arg_208_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_325591", "325591050", "story_v_out_325591.awb") ~= 0 then
					local var_211_8 = manager.audio:GetVoiceLength("story_v_out_325591", "325591050", "story_v_out_325591.awb") / 1000

					if var_211_8 + var_211_0 > arg_208_1.duration_ then
						arg_208_1.duration_ = var_211_8 + var_211_0
					end

					if var_211_3.prefab_name ~= "" and arg_208_1.actors_[var_211_3.prefab_name] ~= nil then
						local var_211_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_208_1.actors_[var_211_3.prefab_name].transform, "story_v_out_325591", "325591050", "story_v_out_325591.awb")

						arg_208_1:RecordAudio("325591050", var_211_9)
						arg_208_1:RecordAudio("325591050", var_211_9)
					else
						arg_208_1:AudioAction("play", "voice", "story_v_out_325591", "325591050", "story_v_out_325591.awb")
					end

					arg_208_1:RecordHistoryTalkVoice("story_v_out_325591", "325591050", "story_v_out_325591.awb")
				end

				arg_208_1:RecordContent(arg_208_1.text_.text)
			end

			local var_211_10 = math.max(var_211_1, arg_208_1.talkMaxDuration)

			if var_211_0 <= arg_208_1.time_ and arg_208_1.time_ < var_211_0 + var_211_10 then
				arg_208_1.typewritter.percent = (arg_208_1.time_ - var_211_0) / var_211_10

				arg_208_1.typewritter:SetDirty()
			end

			if arg_208_1.time_ >= var_211_0 + var_211_10 and arg_208_1.time_ < var_211_0 + var_211_10 + arg_211_0 then
				arg_208_1.typewritter.percent = 1

				arg_208_1.typewritter:SetDirty()
				arg_208_1:ShowNextGo(true)
			end
		end

		arg_208_1.nodeConfigList_ = {}

		arg_208_1:InitPlayNodeList()
	end,
	Play325591051 = function(arg_212_0, arg_212_1)
		arg_212_1.time_ = 0
		arg_212_1.frameCnt_ = 0
		arg_212_1.state_ = "playing"
		arg_212_1.curTalkId_ = 325591051
		arg_212_1.duration_ = 8.37

		local var_212_0 = {
			zh = 6.333,
			ja = 8.366
		}
		local var_212_1 = manager.audio:GetLocalizationFlag()

		if var_212_0[var_212_1] ~= nil then
			arg_212_1.duration_ = var_212_0[var_212_1]
		end

		SetActive(arg_212_1.tipsGo_, false)

		function arg_212_1.onSingleLineFinish_()
			arg_212_1.onSingleLineUpdate_ = nil
			arg_212_1.onSingleLineFinish_ = nil
			arg_212_1.state_ = "waiting"
		end

		function arg_212_1.playNext_(arg_214_0)
			if arg_214_0 == 1 then
				arg_212_0:Play325591052(arg_212_1)
			end
		end

		function arg_212_1.onSingleLineUpdate_(arg_215_0)
			local var_215_0 = 0
			local var_215_1 = 0.625

			if var_215_0 < arg_212_1.time_ and arg_212_1.time_ <= var_215_0 + arg_215_0 then
				arg_212_1.talkMaxDuration = 0
				arg_212_1.dialogCg_.alpha = 1

				arg_212_1.dialog_:SetActive(true)
				SetActive(arg_212_1.leftNameGo_, true)

				local var_215_2 = arg_212_1:FormatText(StoryNameCfg[1510].name)

				arg_212_1.leftNameTxt_.text = var_215_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_212_1.leftNameTxt_.transform)

				arg_212_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_212_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_212_1:RecordName(arg_212_1.leftNameTxt_.text)
				SetActive(arg_212_1.iconTrs_.gameObject, false)
				arg_212_1.callingController_:SetSelectedState("normal")

				local var_215_3 = arg_212_1:GetWordFromCfg(325591051)
				local var_215_4 = arg_212_1:FormatText(var_215_3.content)

				arg_212_1.text_.text = var_215_4

				LuaForUtil.ClearLinePrefixSymbol(arg_212_1.text_)

				local var_215_5 = 25
				local var_215_6 = utf8.len(var_215_4)
				local var_215_7 = var_215_5 <= 0 and var_215_1 or var_215_1 * (var_215_6 / var_215_5)

				if var_215_7 > 0 and var_215_1 < var_215_7 then
					arg_212_1.talkMaxDuration = var_215_7

					if var_215_7 + var_215_0 > arg_212_1.duration_ then
						arg_212_1.duration_ = var_215_7 + var_215_0
					end
				end

				arg_212_1.text_.text = var_215_4
				arg_212_1.typewritter.percent = 0

				arg_212_1.typewritter:SetDirty()
				arg_212_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_325591", "325591051", "story_v_out_325591.awb") ~= 0 then
					local var_215_8 = manager.audio:GetVoiceLength("story_v_out_325591", "325591051", "story_v_out_325591.awb") / 1000

					if var_215_8 + var_215_0 > arg_212_1.duration_ then
						arg_212_1.duration_ = var_215_8 + var_215_0
					end

					if var_215_3.prefab_name ~= "" and arg_212_1.actors_[var_215_3.prefab_name] ~= nil then
						local var_215_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_212_1.actors_[var_215_3.prefab_name].transform, "story_v_out_325591", "325591051", "story_v_out_325591.awb")

						arg_212_1:RecordAudio("325591051", var_215_9)
						arg_212_1:RecordAudio("325591051", var_215_9)
					else
						arg_212_1:AudioAction("play", "voice", "story_v_out_325591", "325591051", "story_v_out_325591.awb")
					end

					arg_212_1:RecordHistoryTalkVoice("story_v_out_325591", "325591051", "story_v_out_325591.awb")
				end

				arg_212_1:RecordContent(arg_212_1.text_.text)
			end

			local var_215_10 = math.max(var_215_1, arg_212_1.talkMaxDuration)

			if var_215_0 <= arg_212_1.time_ and arg_212_1.time_ < var_215_0 + var_215_10 then
				arg_212_1.typewritter.percent = (arg_212_1.time_ - var_215_0) / var_215_10

				arg_212_1.typewritter:SetDirty()
			end

			if arg_212_1.time_ >= var_215_0 + var_215_10 and arg_212_1.time_ < var_215_0 + var_215_10 + arg_215_0 then
				arg_212_1.typewritter.percent = 1

				arg_212_1.typewritter:SetDirty()
				arg_212_1:ShowNextGo(true)
			end
		end

		arg_212_1.nodeConfigList_ = {}

		arg_212_1:InitPlayNodeList()
	end,
	Play325591052 = function(arg_216_0, arg_216_1)
		arg_216_1.time_ = 0
		arg_216_1.frameCnt_ = 0
		arg_216_1.state_ = "playing"
		arg_216_1.curTalkId_ = 325591052
		arg_216_1.duration_ = 5

		SetActive(arg_216_1.tipsGo_, false)

		function arg_216_1.onSingleLineFinish_()
			arg_216_1.onSingleLineUpdate_ = nil
			arg_216_1.onSingleLineFinish_ = nil
			arg_216_1.state_ = "waiting"
		end

		function arg_216_1.playNext_(arg_218_0)
			if arg_218_0 == 1 then
				arg_216_0:Play325591053(arg_216_1)
			end
		end

		function arg_216_1.onSingleLineUpdate_(arg_219_0)
			local var_219_0 = arg_216_1.actors_["10176ui_story"].transform
			local var_219_1 = 0

			if var_219_1 < arg_216_1.time_ and arg_216_1.time_ <= var_219_1 + arg_219_0 then
				arg_216_1.var_.moveOldPos10176ui_story = var_219_0.localPosition

				local var_219_2 = GameObjectTools.GetOrAddComponent(var_219_0.gameObject, typeof(DynamicBoneHelper))

				if var_219_2 then
					var_219_2:EnableDynamicBone(false)
				end
			end

			local var_219_3 = 0.001

			if var_219_1 <= arg_216_1.time_ and arg_216_1.time_ < var_219_1 + var_219_3 then
				local var_219_4 = (arg_216_1.time_ - var_219_1) / var_219_3
				local var_219_5 = Vector3.New(0, 100, 0)

				var_219_0.localPosition = Vector3.Lerp(arg_216_1.var_.moveOldPos10176ui_story, var_219_5, var_219_4)

				local var_219_6 = manager.ui.mainCamera.transform.position - var_219_0.position

				var_219_0.forward = Vector3.New(var_219_6.x, var_219_6.y, var_219_6.z)

				local var_219_7 = var_219_0.localEulerAngles

				var_219_7.z = 0
				var_219_7.x = 0
				var_219_0.localEulerAngles = var_219_7
			end

			if arg_216_1.time_ >= var_219_1 + var_219_3 and arg_216_1.time_ < var_219_1 + var_219_3 + arg_219_0 then
				var_219_0.localPosition = Vector3.New(0, 100, 0)

				local var_219_8 = manager.ui.mainCamera.transform.position - var_219_0.position

				var_219_0.forward = Vector3.New(var_219_8.x, var_219_8.y, var_219_8.z)

				local var_219_9 = var_219_0.localEulerAngles

				var_219_9.z = 0
				var_219_9.x = 0
				var_219_0.localEulerAngles = var_219_9

				local var_219_10 = GameObjectTools.GetOrAddComponent(var_219_0.gameObject, typeof(DynamicBoneHelper))

				if var_219_10 then
					var_219_10:EnableDynamicBone(true)
				end
			end

			local var_219_11 = arg_216_1.actors_["10176ui_story"]
			local var_219_12 = 0

			if var_219_12 < arg_216_1.time_ and arg_216_1.time_ <= var_219_12 + arg_219_0 and not isNil(var_219_11) and arg_216_1.var_.characterEffect10176ui_story == nil then
				arg_216_1.var_.characterEffect10176ui_story = var_219_11:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_219_13 = 0.200000002980232

			if var_219_12 <= arg_216_1.time_ and arg_216_1.time_ < var_219_12 + var_219_13 and not isNil(var_219_11) then
				local var_219_14 = (arg_216_1.time_ - var_219_12) / var_219_13

				if arg_216_1.var_.characterEffect10176ui_story and not isNil(var_219_11) then
					local var_219_15 = Mathf.Lerp(0, 0.5, var_219_14)

					arg_216_1.var_.characterEffect10176ui_story.fillFlat = true
					arg_216_1.var_.characterEffect10176ui_story.fillRatio = var_219_15
				end
			end

			if arg_216_1.time_ >= var_219_12 + var_219_13 and arg_216_1.time_ < var_219_12 + var_219_13 + arg_219_0 and not isNil(var_219_11) and arg_216_1.var_.characterEffect10176ui_story then
				local var_219_16 = 0.5

				arg_216_1.var_.characterEffect10176ui_story.fillFlat = true
				arg_216_1.var_.characterEffect10176ui_story.fillRatio = var_219_16
			end

			local var_219_17 = 0
			local var_219_18 = 0.725

			if var_219_17 < arg_216_1.time_ and arg_216_1.time_ <= var_219_17 + arg_219_0 then
				arg_216_1.talkMaxDuration = 0
				arg_216_1.dialogCg_.alpha = 1

				arg_216_1.dialog_:SetActive(true)
				SetActive(arg_216_1.leftNameGo_, false)

				arg_216_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_216_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_216_1:RecordName(arg_216_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_216_1.iconTrs_.gameObject, false)
				arg_216_1.callingController_:SetSelectedState("normal")

				local var_219_19 = arg_216_1:GetWordFromCfg(325591052)
				local var_219_20 = arg_216_1:FormatText(var_219_19.content)

				arg_216_1.text_.text = var_219_20

				LuaForUtil.ClearLinePrefixSymbol(arg_216_1.text_)

				local var_219_21 = 29
				local var_219_22 = utf8.len(var_219_20)
				local var_219_23 = var_219_21 <= 0 and var_219_18 or var_219_18 * (var_219_22 / var_219_21)

				if var_219_23 > 0 and var_219_18 < var_219_23 then
					arg_216_1.talkMaxDuration = var_219_23

					if var_219_23 + var_219_17 > arg_216_1.duration_ then
						arg_216_1.duration_ = var_219_23 + var_219_17
					end
				end

				arg_216_1.text_.text = var_219_20
				arg_216_1.typewritter.percent = 0

				arg_216_1.typewritter:SetDirty()
				arg_216_1:ShowNextGo(false)
				arg_216_1:RecordContent(arg_216_1.text_.text)
			end

			local var_219_24 = math.max(var_219_18, arg_216_1.talkMaxDuration)

			if var_219_17 <= arg_216_1.time_ and arg_216_1.time_ < var_219_17 + var_219_24 then
				arg_216_1.typewritter.percent = (arg_216_1.time_ - var_219_17) / var_219_24

				arg_216_1.typewritter:SetDirty()
			end

			if arg_216_1.time_ >= var_219_17 + var_219_24 and arg_216_1.time_ < var_219_17 + var_219_24 + arg_219_0 then
				arg_216_1.typewritter.percent = 1

				arg_216_1.typewritter:SetDirty()
				arg_216_1:ShowNextGo(true)
			end
		end

		arg_216_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10176ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_216_1:InitPlayNodeList()
	end,
	Play325591053 = function(arg_220_0, arg_220_1)
		arg_220_1.time_ = 0
		arg_220_1.frameCnt_ = 0
		arg_220_1.state_ = "playing"
		arg_220_1.curTalkId_ = 325591053
		arg_220_1.duration_ = 7.8

		local var_220_0 = {
			zh = 7.8,
			ja = 7.7
		}
		local var_220_1 = manager.audio:GetLocalizationFlag()

		if var_220_0[var_220_1] ~= nil then
			arg_220_1.duration_ = var_220_0[var_220_1]
		end

		SetActive(arg_220_1.tipsGo_, false)

		function arg_220_1.onSingleLineFinish_()
			arg_220_1.onSingleLineUpdate_ = nil
			arg_220_1.onSingleLineFinish_ = nil
			arg_220_1.state_ = "waiting"
		end

		function arg_220_1.playNext_(arg_222_0)
			if arg_222_0 == 1 then
				arg_220_0:Play325591054(arg_220_1)
			end
		end

		function arg_220_1.onSingleLineUpdate_(arg_223_0)
			local var_223_0 = arg_220_1.actors_["6148ui_story"].transform
			local var_223_1 = 0

			if var_223_1 < arg_220_1.time_ and arg_220_1.time_ <= var_223_1 + arg_223_0 then
				arg_220_1.var_.moveOldPos6148ui_story = var_223_0.localPosition

				local var_223_2 = GameObjectTools.GetOrAddComponent(var_223_0.gameObject, typeof(DynamicBoneHelper))

				if var_223_2 then
					var_223_2:EnableDynamicBone(false)
				end
			end

			local var_223_3 = 0.001

			if var_223_1 <= arg_220_1.time_ and arg_220_1.time_ < var_223_1 + var_223_3 then
				local var_223_4 = (arg_220_1.time_ - var_223_1) / var_223_3
				local var_223_5 = Vector3.New(0, -0.985, -6)

				var_223_0.localPosition = Vector3.Lerp(arg_220_1.var_.moveOldPos6148ui_story, var_223_5, var_223_4)

				local var_223_6 = manager.ui.mainCamera.transform.position - var_223_0.position

				var_223_0.forward = Vector3.New(var_223_6.x, var_223_6.y, var_223_6.z)

				local var_223_7 = var_223_0.localEulerAngles

				var_223_7.z = 0
				var_223_7.x = 0
				var_223_0.localEulerAngles = var_223_7
			end

			if arg_220_1.time_ >= var_223_1 + var_223_3 and arg_220_1.time_ < var_223_1 + var_223_3 + arg_223_0 then
				var_223_0.localPosition = Vector3.New(0, -0.985, -6)

				local var_223_8 = manager.ui.mainCamera.transform.position - var_223_0.position

				var_223_0.forward = Vector3.New(var_223_8.x, var_223_8.y, var_223_8.z)

				local var_223_9 = var_223_0.localEulerAngles

				var_223_9.z = 0
				var_223_9.x = 0
				var_223_0.localEulerAngles = var_223_9

				local var_223_10 = GameObjectTools.GetOrAddComponent(var_223_0.gameObject, typeof(DynamicBoneHelper))

				if var_223_10 then
					var_223_10:EnableDynamicBone(true)
				end
			end

			local var_223_11 = arg_220_1.actors_["6148ui_story"]
			local var_223_12 = 0

			if var_223_12 < arg_220_1.time_ and arg_220_1.time_ <= var_223_12 + arg_223_0 and not isNil(var_223_11) and arg_220_1.var_.characterEffect6148ui_story == nil then
				arg_220_1.var_.characterEffect6148ui_story = var_223_11:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_223_13 = 0.200000002980232

			if var_223_12 <= arg_220_1.time_ and arg_220_1.time_ < var_223_12 + var_223_13 and not isNil(var_223_11) then
				local var_223_14 = (arg_220_1.time_ - var_223_12) / var_223_13

				if arg_220_1.var_.characterEffect6148ui_story and not isNil(var_223_11) then
					arg_220_1.var_.characterEffect6148ui_story.fillFlat = false
				end
			end

			if arg_220_1.time_ >= var_223_12 + var_223_13 and arg_220_1.time_ < var_223_12 + var_223_13 + arg_223_0 and not isNil(var_223_11) and arg_220_1.var_.characterEffect6148ui_story then
				arg_220_1.var_.characterEffect6148ui_story.fillFlat = false
			end

			local var_223_15 = 0

			if var_223_15 < arg_220_1.time_ and arg_220_1.time_ <= var_223_15 + arg_223_0 then
				arg_220_1:PlayTimeline("6148ui_story", "StoryTimeline/CharAction/story6148/story6148action/6148action1_1")
			end

			local var_223_16 = 0

			if var_223_16 < arg_220_1.time_ and arg_220_1.time_ <= var_223_16 + arg_223_0 then
				arg_220_1:PlayTimeline("6148ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0101cva", "EmotionTimelineAnimator")
			end

			local var_223_17 = 0
			local var_223_18 = 0.9

			if var_223_17 < arg_220_1.time_ and arg_220_1.time_ <= var_223_17 + arg_223_0 then
				arg_220_1.talkMaxDuration = 0
				arg_220_1.dialogCg_.alpha = 1

				arg_220_1.dialog_:SetActive(true)
				SetActive(arg_220_1.leftNameGo_, true)

				local var_223_19 = arg_220_1:FormatText(StoryNameCfg[1488].name)

				arg_220_1.leftNameTxt_.text = var_223_19

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_220_1.leftNameTxt_.transform)

				arg_220_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_220_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_220_1:RecordName(arg_220_1.leftNameTxt_.text)
				SetActive(arg_220_1.iconTrs_.gameObject, false)
				arg_220_1.callingController_:SetSelectedState("normal")

				local var_223_20 = arg_220_1:GetWordFromCfg(325591053)
				local var_223_21 = arg_220_1:FormatText(var_223_20.content)

				arg_220_1.text_.text = var_223_21

				LuaForUtil.ClearLinePrefixSymbol(arg_220_1.text_)

				local var_223_22 = 36
				local var_223_23 = utf8.len(var_223_21)
				local var_223_24 = var_223_22 <= 0 and var_223_18 or var_223_18 * (var_223_23 / var_223_22)

				if var_223_24 > 0 and var_223_18 < var_223_24 then
					arg_220_1.talkMaxDuration = var_223_24

					if var_223_24 + var_223_17 > arg_220_1.duration_ then
						arg_220_1.duration_ = var_223_24 + var_223_17
					end
				end

				arg_220_1.text_.text = var_223_21
				arg_220_1.typewritter.percent = 0

				arg_220_1.typewritter:SetDirty()
				arg_220_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_325591", "325591053", "story_v_out_325591.awb") ~= 0 then
					local var_223_25 = manager.audio:GetVoiceLength("story_v_out_325591", "325591053", "story_v_out_325591.awb") / 1000

					if var_223_25 + var_223_17 > arg_220_1.duration_ then
						arg_220_1.duration_ = var_223_25 + var_223_17
					end

					if var_223_20.prefab_name ~= "" and arg_220_1.actors_[var_223_20.prefab_name] ~= nil then
						local var_223_26 = LuaForUtil.PlayVoiceWithCriLipsync(arg_220_1.actors_[var_223_20.prefab_name].transform, "story_v_out_325591", "325591053", "story_v_out_325591.awb")

						arg_220_1:RecordAudio("325591053", var_223_26)
						arg_220_1:RecordAudio("325591053", var_223_26)
					else
						arg_220_1:AudioAction("play", "voice", "story_v_out_325591", "325591053", "story_v_out_325591.awb")
					end

					arg_220_1:RecordHistoryTalkVoice("story_v_out_325591", "325591053", "story_v_out_325591.awb")
				end

				arg_220_1:RecordContent(arg_220_1.text_.text)
			end

			local var_223_27 = math.max(var_223_18, arg_220_1.talkMaxDuration)

			if var_223_17 <= arg_220_1.time_ and arg_220_1.time_ < var_223_17 + var_223_27 then
				arg_220_1.typewritter.percent = (arg_220_1.time_ - var_223_17) / var_223_27

				arg_220_1.typewritter:SetDirty()
			end

			if arg_220_1.time_ >= var_223_17 + var_223_27 and arg_220_1.time_ < var_223_17 + var_223_27 + arg_223_0 then
				arg_220_1.typewritter.percent = 1

				arg_220_1.typewritter:SetDirty()
				arg_220_1:ShowNextGo(true)
			end
		end

		arg_220_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "6148ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_220_1:InitPlayNodeList()
	end,
	Play325591054 = function(arg_224_0, arg_224_1)
		arg_224_1.time_ = 0
		arg_224_1.frameCnt_ = 0
		arg_224_1.state_ = "playing"
		arg_224_1.curTalkId_ = 325591054
		arg_224_1.duration_ = 5.73

		local var_224_0 = {
			zh = 5.733,
			ja = 4.833
		}
		local var_224_1 = manager.audio:GetLocalizationFlag()

		if var_224_0[var_224_1] ~= nil then
			arg_224_1.duration_ = var_224_0[var_224_1]
		end

		SetActive(arg_224_1.tipsGo_, false)

		function arg_224_1.onSingleLineFinish_()
			arg_224_1.onSingleLineUpdate_ = nil
			arg_224_1.onSingleLineFinish_ = nil
			arg_224_1.state_ = "waiting"
		end

		function arg_224_1.playNext_(arg_226_0)
			if arg_226_0 == 1 then
				arg_224_0:Play325591055(arg_224_1)
			end
		end

		function arg_224_1.onSingleLineUpdate_(arg_227_0)
			local var_227_0 = arg_224_1.actors_["6148ui_story"].transform
			local var_227_1 = 0

			if var_227_1 < arg_224_1.time_ and arg_224_1.time_ <= var_227_1 + arg_227_0 then
				arg_224_1.var_.moveOldPos6148ui_story = var_227_0.localPosition

				local var_227_2 = GameObjectTools.GetOrAddComponent(var_227_0.gameObject, typeof(DynamicBoneHelper))

				if var_227_2 then
					var_227_2:EnableDynamicBone(false)
				end
			end

			local var_227_3 = 0.001

			if var_227_1 <= arg_224_1.time_ and arg_224_1.time_ < var_227_1 + var_227_3 then
				local var_227_4 = (arg_224_1.time_ - var_227_1) / var_227_3
				local var_227_5 = Vector3.New(-0.7, -0.985, -6)

				var_227_0.localPosition = Vector3.Lerp(arg_224_1.var_.moveOldPos6148ui_story, var_227_5, var_227_4)

				local var_227_6 = manager.ui.mainCamera.transform.position - var_227_0.position

				var_227_0.forward = Vector3.New(var_227_6.x, var_227_6.y, var_227_6.z)

				local var_227_7 = var_227_0.localEulerAngles

				var_227_7.z = 0
				var_227_7.x = 0
				var_227_0.localEulerAngles = var_227_7
			end

			if arg_224_1.time_ >= var_227_1 + var_227_3 and arg_224_1.time_ < var_227_1 + var_227_3 + arg_227_0 then
				var_227_0.localPosition = Vector3.New(-0.7, -0.985, -6)

				local var_227_8 = manager.ui.mainCamera.transform.position - var_227_0.position

				var_227_0.forward = Vector3.New(var_227_8.x, var_227_8.y, var_227_8.z)

				local var_227_9 = var_227_0.localEulerAngles

				var_227_9.z = 0
				var_227_9.x = 0
				var_227_0.localEulerAngles = var_227_9

				local var_227_10 = GameObjectTools.GetOrAddComponent(var_227_0.gameObject, typeof(DynamicBoneHelper))

				if var_227_10 then
					var_227_10:EnableDynamicBone(true)
				end
			end

			local var_227_11 = arg_224_1.actors_["1054ui_story"].transform
			local var_227_12 = 0

			if var_227_12 < arg_224_1.time_ and arg_224_1.time_ <= var_227_12 + arg_227_0 then
				arg_224_1.var_.moveOldPos1054ui_story = var_227_11.localPosition

				local var_227_13 = GameObjectTools.GetOrAddComponent(var_227_11.gameObject, typeof(DynamicBoneHelper))

				if var_227_13 then
					var_227_13:EnableDynamicBone(false)
				end
			end

			local var_227_14 = 0.001

			if var_227_12 <= arg_224_1.time_ and arg_224_1.time_ < var_227_12 + var_227_14 then
				local var_227_15 = (arg_224_1.time_ - var_227_12) / var_227_14
				local var_227_16 = Vector3.New(0.7, -0.985, -6)

				var_227_11.localPosition = Vector3.Lerp(arg_224_1.var_.moveOldPos1054ui_story, var_227_16, var_227_15)

				local var_227_17 = manager.ui.mainCamera.transform.position - var_227_11.position

				var_227_11.forward = Vector3.New(var_227_17.x, var_227_17.y, var_227_17.z)

				local var_227_18 = var_227_11.localEulerAngles

				var_227_18.z = 0
				var_227_18.x = 0
				var_227_11.localEulerAngles = var_227_18
			end

			if arg_224_1.time_ >= var_227_12 + var_227_14 and arg_224_1.time_ < var_227_12 + var_227_14 + arg_227_0 then
				var_227_11.localPosition = Vector3.New(0.7, -0.985, -6)

				local var_227_19 = manager.ui.mainCamera.transform.position - var_227_11.position

				var_227_11.forward = Vector3.New(var_227_19.x, var_227_19.y, var_227_19.z)

				local var_227_20 = var_227_11.localEulerAngles

				var_227_20.z = 0
				var_227_20.x = 0
				var_227_11.localEulerAngles = var_227_20

				local var_227_21 = GameObjectTools.GetOrAddComponent(var_227_11.gameObject, typeof(DynamicBoneHelper))

				if var_227_21 then
					var_227_21:EnableDynamicBone(true)
				end
			end

			local var_227_22 = arg_224_1.actors_["1054ui_story"]
			local var_227_23 = 0

			if var_227_23 < arg_224_1.time_ and arg_224_1.time_ <= var_227_23 + arg_227_0 and not isNil(var_227_22) and arg_224_1.var_.characterEffect1054ui_story == nil then
				arg_224_1.var_.characterEffect1054ui_story = var_227_22:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_227_24 = 0.200000002980232

			if var_227_23 <= arg_224_1.time_ and arg_224_1.time_ < var_227_23 + var_227_24 and not isNil(var_227_22) then
				local var_227_25 = (arg_224_1.time_ - var_227_23) / var_227_24

				if arg_224_1.var_.characterEffect1054ui_story and not isNil(var_227_22) then
					arg_224_1.var_.characterEffect1054ui_story.fillFlat = false
				end
			end

			if arg_224_1.time_ >= var_227_23 + var_227_24 and arg_224_1.time_ < var_227_23 + var_227_24 + arg_227_0 and not isNil(var_227_22) and arg_224_1.var_.characterEffect1054ui_story then
				arg_224_1.var_.characterEffect1054ui_story.fillFlat = false
			end

			local var_227_26 = arg_224_1.actors_["6148ui_story"]
			local var_227_27 = 0

			if var_227_27 < arg_224_1.time_ and arg_224_1.time_ <= var_227_27 + arg_227_0 and not isNil(var_227_26) and arg_224_1.var_.characterEffect6148ui_story == nil then
				arg_224_1.var_.characterEffect6148ui_story = var_227_26:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_227_28 = 0.200000002980232

			if var_227_27 <= arg_224_1.time_ and arg_224_1.time_ < var_227_27 + var_227_28 and not isNil(var_227_26) then
				local var_227_29 = (arg_224_1.time_ - var_227_27) / var_227_28

				if arg_224_1.var_.characterEffect6148ui_story and not isNil(var_227_26) then
					local var_227_30 = Mathf.Lerp(0, 0.5, var_227_29)

					arg_224_1.var_.characterEffect6148ui_story.fillFlat = true
					arg_224_1.var_.characterEffect6148ui_story.fillRatio = var_227_30
				end
			end

			if arg_224_1.time_ >= var_227_27 + var_227_28 and arg_224_1.time_ < var_227_27 + var_227_28 + arg_227_0 and not isNil(var_227_26) and arg_224_1.var_.characterEffect6148ui_story then
				local var_227_31 = 0.5

				arg_224_1.var_.characterEffect6148ui_story.fillFlat = true
				arg_224_1.var_.characterEffect6148ui_story.fillRatio = var_227_31
			end

			local var_227_32 = 0
			local var_227_33 = 0.6

			if var_227_32 < arg_224_1.time_ and arg_224_1.time_ <= var_227_32 + arg_227_0 then
				arg_224_1.talkMaxDuration = 0
				arg_224_1.dialogCg_.alpha = 1

				arg_224_1.dialog_:SetActive(true)
				SetActive(arg_224_1.leftNameGo_, true)

				local var_227_34 = arg_224_1:FormatText(StoryNameCfg[1487].name)

				arg_224_1.leftNameTxt_.text = var_227_34

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_224_1.leftNameTxt_.transform)

				arg_224_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_224_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_224_1:RecordName(arg_224_1.leftNameTxt_.text)
				SetActive(arg_224_1.iconTrs_.gameObject, false)
				arg_224_1.callingController_:SetSelectedState("normal")

				local var_227_35 = arg_224_1:GetWordFromCfg(325591054)
				local var_227_36 = arg_224_1:FormatText(var_227_35.content)

				arg_224_1.text_.text = var_227_36

				LuaForUtil.ClearLinePrefixSymbol(arg_224_1.text_)

				local var_227_37 = 24
				local var_227_38 = utf8.len(var_227_36)
				local var_227_39 = var_227_37 <= 0 and var_227_33 or var_227_33 * (var_227_38 / var_227_37)

				if var_227_39 > 0 and var_227_33 < var_227_39 then
					arg_224_1.talkMaxDuration = var_227_39

					if var_227_39 + var_227_32 > arg_224_1.duration_ then
						arg_224_1.duration_ = var_227_39 + var_227_32
					end
				end

				arg_224_1.text_.text = var_227_36
				arg_224_1.typewritter.percent = 0

				arg_224_1.typewritter:SetDirty()
				arg_224_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_325591", "325591054", "story_v_out_325591.awb") ~= 0 then
					local var_227_40 = manager.audio:GetVoiceLength("story_v_out_325591", "325591054", "story_v_out_325591.awb") / 1000

					if var_227_40 + var_227_32 > arg_224_1.duration_ then
						arg_224_1.duration_ = var_227_40 + var_227_32
					end

					if var_227_35.prefab_name ~= "" and arg_224_1.actors_[var_227_35.prefab_name] ~= nil then
						local var_227_41 = LuaForUtil.PlayVoiceWithCriLipsync(arg_224_1.actors_[var_227_35.prefab_name].transform, "story_v_out_325591", "325591054", "story_v_out_325591.awb")

						arg_224_1:RecordAudio("325591054", var_227_41)
						arg_224_1:RecordAudio("325591054", var_227_41)
					else
						arg_224_1:AudioAction("play", "voice", "story_v_out_325591", "325591054", "story_v_out_325591.awb")
					end

					arg_224_1:RecordHistoryTalkVoice("story_v_out_325591", "325591054", "story_v_out_325591.awb")
				end

				arg_224_1:RecordContent(arg_224_1.text_.text)
			end

			local var_227_42 = math.max(var_227_33, arg_224_1.talkMaxDuration)

			if var_227_32 <= arg_224_1.time_ and arg_224_1.time_ < var_227_32 + var_227_42 then
				arg_224_1.typewritter.percent = (arg_224_1.time_ - var_227_32) / var_227_42

				arg_224_1.typewritter:SetDirty()
			end

			if arg_224_1.time_ >= var_227_32 + var_227_42 and arg_224_1.time_ < var_227_32 + var_227_42 + arg_227_0 then
				arg_224_1.typewritter.percent = 1

				arg_224_1.typewritter:SetDirty()
				arg_224_1:ShowNextGo(true)
			end
		end

		arg_224_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "6148ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1054ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_224_1:InitPlayNodeList()
	end,
	Play325591055 = function(arg_228_0, arg_228_1)
		arg_228_1.time_ = 0
		arg_228_1.frameCnt_ = 0
		arg_228_1.state_ = "playing"
		arg_228_1.curTalkId_ = 325591055
		arg_228_1.duration_ = 8.47

		local var_228_0 = {
			zh = 6.5,
			ja = 8.466
		}
		local var_228_1 = manager.audio:GetLocalizationFlag()

		if var_228_0[var_228_1] ~= nil then
			arg_228_1.duration_ = var_228_0[var_228_1]
		end

		SetActive(arg_228_1.tipsGo_, false)

		function arg_228_1.onSingleLineFinish_()
			arg_228_1.onSingleLineUpdate_ = nil
			arg_228_1.onSingleLineFinish_ = nil
			arg_228_1.state_ = "waiting"
		end

		function arg_228_1.playNext_(arg_230_0)
			if arg_230_0 == 1 then
				arg_228_0:Play325591056(arg_228_1)
			end
		end

		function arg_228_1.onSingleLineUpdate_(arg_231_0)
			local var_231_0 = 0

			if var_231_0 < arg_228_1.time_ and arg_228_1.time_ <= var_231_0 + arg_231_0 then
				arg_228_1:PlayTimeline("1054ui_story", "StoryTimeline/CharAction/story1054/story1054action/1054action3_1")
			end

			local var_231_1 = 0

			if var_231_1 < arg_228_1.time_ and arg_228_1.time_ <= var_231_1 + arg_231_0 then
				arg_228_1:PlayTimeline("1054ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0101cva", "EmotionTimelineAnimator")
			end

			local var_231_2 = 0
			local var_231_3 = 0.6

			if var_231_2 < arg_228_1.time_ and arg_228_1.time_ <= var_231_2 + arg_231_0 then
				arg_228_1.talkMaxDuration = 0
				arg_228_1.dialogCg_.alpha = 1

				arg_228_1.dialog_:SetActive(true)
				SetActive(arg_228_1.leftNameGo_, true)

				local var_231_4 = arg_228_1:FormatText(StoryNameCfg[1487].name)

				arg_228_1.leftNameTxt_.text = var_231_4

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_228_1.leftNameTxt_.transform)

				arg_228_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_228_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_228_1:RecordName(arg_228_1.leftNameTxt_.text)
				SetActive(arg_228_1.iconTrs_.gameObject, false)
				arg_228_1.callingController_:SetSelectedState("normal")

				local var_231_5 = arg_228_1:GetWordFromCfg(325591055)
				local var_231_6 = arg_228_1:FormatText(var_231_5.content)

				arg_228_1.text_.text = var_231_6

				LuaForUtil.ClearLinePrefixSymbol(arg_228_1.text_)

				local var_231_7 = 24
				local var_231_8 = utf8.len(var_231_6)
				local var_231_9 = var_231_7 <= 0 and var_231_3 or var_231_3 * (var_231_8 / var_231_7)

				if var_231_9 > 0 and var_231_3 < var_231_9 then
					arg_228_1.talkMaxDuration = var_231_9

					if var_231_9 + var_231_2 > arg_228_1.duration_ then
						arg_228_1.duration_ = var_231_9 + var_231_2
					end
				end

				arg_228_1.text_.text = var_231_6
				arg_228_1.typewritter.percent = 0

				arg_228_1.typewritter:SetDirty()
				arg_228_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_325591", "325591055", "story_v_out_325591.awb") ~= 0 then
					local var_231_10 = manager.audio:GetVoiceLength("story_v_out_325591", "325591055", "story_v_out_325591.awb") / 1000

					if var_231_10 + var_231_2 > arg_228_1.duration_ then
						arg_228_1.duration_ = var_231_10 + var_231_2
					end

					if var_231_5.prefab_name ~= "" and arg_228_1.actors_[var_231_5.prefab_name] ~= nil then
						local var_231_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_228_1.actors_[var_231_5.prefab_name].transform, "story_v_out_325591", "325591055", "story_v_out_325591.awb")

						arg_228_1:RecordAudio("325591055", var_231_11)
						arg_228_1:RecordAudio("325591055", var_231_11)
					else
						arg_228_1:AudioAction("play", "voice", "story_v_out_325591", "325591055", "story_v_out_325591.awb")
					end

					arg_228_1:RecordHistoryTalkVoice("story_v_out_325591", "325591055", "story_v_out_325591.awb")
				end

				arg_228_1:RecordContent(arg_228_1.text_.text)
			end

			local var_231_12 = math.max(var_231_3, arg_228_1.talkMaxDuration)

			if var_231_2 <= arg_228_1.time_ and arg_228_1.time_ < var_231_2 + var_231_12 then
				arg_228_1.typewritter.percent = (arg_228_1.time_ - var_231_2) / var_231_12

				arg_228_1.typewritter:SetDirty()
			end

			if arg_228_1.time_ >= var_231_2 + var_231_12 and arg_228_1.time_ < var_231_2 + var_231_12 + arg_231_0 then
				arg_228_1.typewritter.percent = 1

				arg_228_1.typewritter:SetDirty()
				arg_228_1:ShowNextGo(true)
			end
		end

		arg_228_1.nodeConfigList_ = {}

		arg_228_1:InitPlayNodeList()
	end,
	Play325591056 = function(arg_232_0, arg_232_1)
		arg_232_1.time_ = 0
		arg_232_1.frameCnt_ = 0
		arg_232_1.state_ = "playing"
		arg_232_1.curTalkId_ = 325591056
		arg_232_1.duration_ = 6.4

		local var_232_0 = {
			zh = 6,
			ja = 6.4
		}
		local var_232_1 = manager.audio:GetLocalizationFlag()

		if var_232_0[var_232_1] ~= nil then
			arg_232_1.duration_ = var_232_0[var_232_1]
		end

		SetActive(arg_232_1.tipsGo_, false)

		function arg_232_1.onSingleLineFinish_()
			arg_232_1.onSingleLineUpdate_ = nil
			arg_232_1.onSingleLineFinish_ = nil
			arg_232_1.state_ = "waiting"
		end

		function arg_232_1.playNext_(arg_234_0)
			if arg_234_0 == 1 then
				arg_232_0:Play325591057(arg_232_1)
			end
		end

		function arg_232_1.onSingleLineUpdate_(arg_235_0)
			local var_235_0 = arg_232_1.actors_["1054ui_story"].transform
			local var_235_1 = 0

			if var_235_1 < arg_232_1.time_ and arg_232_1.time_ <= var_235_1 + arg_235_0 then
				arg_232_1.var_.moveOldPos1054ui_story = var_235_0.localPosition

				local var_235_2 = GameObjectTools.GetOrAddComponent(var_235_0.gameObject, typeof(DynamicBoneHelper))

				if var_235_2 then
					var_235_2:EnableDynamicBone(false)
				end
			end

			local var_235_3 = 0.001

			if var_235_1 <= arg_232_1.time_ and arg_232_1.time_ < var_235_1 + var_235_3 then
				local var_235_4 = (arg_232_1.time_ - var_235_1) / var_235_3
				local var_235_5 = Vector3.New(0, 100, 0)

				var_235_0.localPosition = Vector3.Lerp(arg_232_1.var_.moveOldPos1054ui_story, var_235_5, var_235_4)

				local var_235_6 = manager.ui.mainCamera.transform.position - var_235_0.position

				var_235_0.forward = Vector3.New(var_235_6.x, var_235_6.y, var_235_6.z)

				local var_235_7 = var_235_0.localEulerAngles

				var_235_7.z = 0
				var_235_7.x = 0
				var_235_0.localEulerAngles = var_235_7
			end

			if arg_232_1.time_ >= var_235_1 + var_235_3 and arg_232_1.time_ < var_235_1 + var_235_3 + arg_235_0 then
				var_235_0.localPosition = Vector3.New(0, 100, 0)

				local var_235_8 = manager.ui.mainCamera.transform.position - var_235_0.position

				var_235_0.forward = Vector3.New(var_235_8.x, var_235_8.y, var_235_8.z)

				local var_235_9 = var_235_0.localEulerAngles

				var_235_9.z = 0
				var_235_9.x = 0
				var_235_0.localEulerAngles = var_235_9

				local var_235_10 = GameObjectTools.GetOrAddComponent(var_235_0.gameObject, typeof(DynamicBoneHelper))

				if var_235_10 then
					var_235_10:EnableDynamicBone(true)
				end
			end

			local var_235_11 = arg_232_1.actors_["10176ui_story"].transform
			local var_235_12 = 0

			if var_235_12 < arg_232_1.time_ and arg_232_1.time_ <= var_235_12 + arg_235_0 then
				arg_232_1.var_.moveOldPos10176ui_story = var_235_11.localPosition

				local var_235_13 = GameObjectTools.GetOrAddComponent(var_235_11.gameObject, typeof(DynamicBoneHelper))

				if var_235_13 then
					var_235_13:EnableDynamicBone(false)
				end
			end

			local var_235_14 = 0.001

			if var_235_12 <= arg_232_1.time_ and arg_232_1.time_ < var_235_12 + var_235_14 then
				local var_235_15 = (arg_232_1.time_ - var_235_12) / var_235_14
				local var_235_16 = Vector3.New(-0.02, -1.09, -6.12)

				var_235_11.localPosition = Vector3.Lerp(arg_232_1.var_.moveOldPos10176ui_story, var_235_16, var_235_15)

				local var_235_17 = manager.ui.mainCamera.transform.position - var_235_11.position

				var_235_11.forward = Vector3.New(var_235_17.x, var_235_17.y, var_235_17.z)

				local var_235_18 = var_235_11.localEulerAngles

				var_235_18.z = 0
				var_235_18.x = 0
				var_235_11.localEulerAngles = var_235_18
			end

			if arg_232_1.time_ >= var_235_12 + var_235_14 and arg_232_1.time_ < var_235_12 + var_235_14 + arg_235_0 then
				var_235_11.localPosition = Vector3.New(-0.02, -1.09, -6.12)

				local var_235_19 = manager.ui.mainCamera.transform.position - var_235_11.position

				var_235_11.forward = Vector3.New(var_235_19.x, var_235_19.y, var_235_19.z)

				local var_235_20 = var_235_11.localEulerAngles

				var_235_20.z = 0
				var_235_20.x = 0
				var_235_11.localEulerAngles = var_235_20

				local var_235_21 = GameObjectTools.GetOrAddComponent(var_235_11.gameObject, typeof(DynamicBoneHelper))

				if var_235_21 then
					var_235_21:EnableDynamicBone(true)
				end
			end

			local var_235_22 = arg_232_1.actors_["6148ui_story"].transform
			local var_235_23 = 0

			if var_235_23 < arg_232_1.time_ and arg_232_1.time_ <= var_235_23 + arg_235_0 then
				arg_232_1.var_.moveOldPos6148ui_story = var_235_22.localPosition

				local var_235_24 = GameObjectTools.GetOrAddComponent(var_235_22.gameObject, typeof(DynamicBoneHelper))

				if var_235_24 then
					var_235_24:EnableDynamicBone(false)
				end
			end

			local var_235_25 = 0.001

			if var_235_23 <= arg_232_1.time_ and arg_232_1.time_ < var_235_23 + var_235_25 then
				local var_235_26 = (arg_232_1.time_ - var_235_23) / var_235_25
				local var_235_27 = Vector3.New(0, 100, 0)

				var_235_22.localPosition = Vector3.Lerp(arg_232_1.var_.moveOldPos6148ui_story, var_235_27, var_235_26)

				local var_235_28 = manager.ui.mainCamera.transform.position - var_235_22.position

				var_235_22.forward = Vector3.New(var_235_28.x, var_235_28.y, var_235_28.z)

				local var_235_29 = var_235_22.localEulerAngles

				var_235_29.z = 0
				var_235_29.x = 0
				var_235_22.localEulerAngles = var_235_29
			end

			if arg_232_1.time_ >= var_235_23 + var_235_25 and arg_232_1.time_ < var_235_23 + var_235_25 + arg_235_0 then
				var_235_22.localPosition = Vector3.New(0, 100, 0)

				local var_235_30 = manager.ui.mainCamera.transform.position - var_235_22.position

				var_235_22.forward = Vector3.New(var_235_30.x, var_235_30.y, var_235_30.z)

				local var_235_31 = var_235_22.localEulerAngles

				var_235_31.z = 0
				var_235_31.x = 0
				var_235_22.localEulerAngles = var_235_31

				local var_235_32 = GameObjectTools.GetOrAddComponent(var_235_22.gameObject, typeof(DynamicBoneHelper))

				if var_235_32 then
					var_235_32:EnableDynamicBone(true)
				end
			end

			local var_235_33 = arg_232_1.actors_["10176ui_story"]
			local var_235_34 = 0

			if var_235_34 < arg_232_1.time_ and arg_232_1.time_ <= var_235_34 + arg_235_0 and not isNil(var_235_33) and arg_232_1.var_.characterEffect10176ui_story == nil then
				arg_232_1.var_.characterEffect10176ui_story = var_235_33:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_235_35 = 0.200000002980232

			if var_235_34 <= arg_232_1.time_ and arg_232_1.time_ < var_235_34 + var_235_35 and not isNil(var_235_33) then
				local var_235_36 = (arg_232_1.time_ - var_235_34) / var_235_35

				if arg_232_1.var_.characterEffect10176ui_story and not isNil(var_235_33) then
					arg_232_1.var_.characterEffect10176ui_story.fillFlat = false
				end
			end

			if arg_232_1.time_ >= var_235_34 + var_235_35 and arg_232_1.time_ < var_235_34 + var_235_35 + arg_235_0 and not isNil(var_235_33) and arg_232_1.var_.characterEffect10176ui_story then
				arg_232_1.var_.characterEffect10176ui_story.fillFlat = false
			end

			local var_235_37 = arg_232_1.actors_["1054ui_story"]
			local var_235_38 = 0

			if var_235_38 < arg_232_1.time_ and arg_232_1.time_ <= var_235_38 + arg_235_0 and not isNil(var_235_37) and arg_232_1.var_.characterEffect1054ui_story == nil then
				arg_232_1.var_.characterEffect1054ui_story = var_235_37:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_235_39 = 0.200000002980232

			if var_235_38 <= arg_232_1.time_ and arg_232_1.time_ < var_235_38 + var_235_39 and not isNil(var_235_37) then
				local var_235_40 = (arg_232_1.time_ - var_235_38) / var_235_39

				if arg_232_1.var_.characterEffect1054ui_story and not isNil(var_235_37) then
					local var_235_41 = Mathf.Lerp(0, 0.5, var_235_40)

					arg_232_1.var_.characterEffect1054ui_story.fillFlat = true
					arg_232_1.var_.characterEffect1054ui_story.fillRatio = var_235_41
				end
			end

			if arg_232_1.time_ >= var_235_38 + var_235_39 and arg_232_1.time_ < var_235_38 + var_235_39 + arg_235_0 and not isNil(var_235_37) and arg_232_1.var_.characterEffect1054ui_story then
				local var_235_42 = 0.5

				arg_232_1.var_.characterEffect1054ui_story.fillFlat = true
				arg_232_1.var_.characterEffect1054ui_story.fillRatio = var_235_42
			end

			local var_235_43 = 0

			if var_235_43 < arg_232_1.time_ and arg_232_1.time_ <= var_235_43 + arg_235_0 then
				arg_232_1:PlayTimeline("10176ui_story", "StoryTimeline/CharAction/story10176/story10176action/10176action5_1")
			end

			local var_235_44 = 0

			if var_235_44 < arg_232_1.time_ and arg_232_1.time_ <= var_235_44 + arg_235_0 then
				arg_232_1:PlayTimeline("10176ui_story", "StoryTimeline/CharAction/public_expression/expr_wubiaoqing", "EmotionTimelineAnimator")
			end

			local var_235_45 = 0
			local var_235_46 = 0.575

			if var_235_45 < arg_232_1.time_ and arg_232_1.time_ <= var_235_45 + arg_235_0 then
				arg_232_1.talkMaxDuration = 0
				arg_232_1.dialogCg_.alpha = 1

				arg_232_1.dialog_:SetActive(true)
				SetActive(arg_232_1.leftNameGo_, true)

				local var_235_47 = arg_232_1:FormatText(StoryNameCfg[1510].name)

				arg_232_1.leftNameTxt_.text = var_235_47

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_232_1.leftNameTxt_.transform)

				arg_232_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_232_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_232_1:RecordName(arg_232_1.leftNameTxt_.text)
				SetActive(arg_232_1.iconTrs_.gameObject, false)
				arg_232_1.callingController_:SetSelectedState("normal")

				local var_235_48 = arg_232_1:GetWordFromCfg(325591056)
				local var_235_49 = arg_232_1:FormatText(var_235_48.content)

				arg_232_1.text_.text = var_235_49

				LuaForUtil.ClearLinePrefixSymbol(arg_232_1.text_)

				local var_235_50 = 23
				local var_235_51 = utf8.len(var_235_49)
				local var_235_52 = var_235_50 <= 0 and var_235_46 or var_235_46 * (var_235_51 / var_235_50)

				if var_235_52 > 0 and var_235_46 < var_235_52 then
					arg_232_1.talkMaxDuration = var_235_52

					if var_235_52 + var_235_45 > arg_232_1.duration_ then
						arg_232_1.duration_ = var_235_52 + var_235_45
					end
				end

				arg_232_1.text_.text = var_235_49
				arg_232_1.typewritter.percent = 0

				arg_232_1.typewritter:SetDirty()
				arg_232_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_325591", "325591056", "story_v_out_325591.awb") ~= 0 then
					local var_235_53 = manager.audio:GetVoiceLength("story_v_out_325591", "325591056", "story_v_out_325591.awb") / 1000

					if var_235_53 + var_235_45 > arg_232_1.duration_ then
						arg_232_1.duration_ = var_235_53 + var_235_45
					end

					if var_235_48.prefab_name ~= "" and arg_232_1.actors_[var_235_48.prefab_name] ~= nil then
						local var_235_54 = LuaForUtil.PlayVoiceWithCriLipsync(arg_232_1.actors_[var_235_48.prefab_name].transform, "story_v_out_325591", "325591056", "story_v_out_325591.awb")

						arg_232_1:RecordAudio("325591056", var_235_54)
						arg_232_1:RecordAudio("325591056", var_235_54)
					else
						arg_232_1:AudioAction("play", "voice", "story_v_out_325591", "325591056", "story_v_out_325591.awb")
					end

					arg_232_1:RecordHistoryTalkVoice("story_v_out_325591", "325591056", "story_v_out_325591.awb")
				end

				arg_232_1:RecordContent(arg_232_1.text_.text)
			end

			local var_235_55 = math.max(var_235_46, arg_232_1.talkMaxDuration)

			if var_235_45 <= arg_232_1.time_ and arg_232_1.time_ < var_235_45 + var_235_55 then
				arg_232_1.typewritter.percent = (arg_232_1.time_ - var_235_45) / var_235_55

				arg_232_1.typewritter:SetDirty()
			end

			if arg_232_1.time_ >= var_235_45 + var_235_55 and arg_232_1.time_ < var_235_45 + var_235_55 + arg_235_0 then
				arg_232_1.typewritter.percent = 1

				arg_232_1.typewritter:SetDirty()
				arg_232_1:ShowNextGo(true)
			end
		end

		arg_232_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1054ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "10176ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "6148ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_232_1:InitPlayNodeList()
	end,
	Play325591057 = function(arg_236_0, arg_236_1)
		arg_236_1.time_ = 0
		arg_236_1.frameCnt_ = 0
		arg_236_1.state_ = "playing"
		arg_236_1.curTalkId_ = 325591057
		arg_236_1.duration_ = 9.67

		local var_236_0 = {
			zh = 9.166,
			ja = 9.666
		}
		local var_236_1 = manager.audio:GetLocalizationFlag()

		if var_236_0[var_236_1] ~= nil then
			arg_236_1.duration_ = var_236_0[var_236_1]
		end

		SetActive(arg_236_1.tipsGo_, false)

		function arg_236_1.onSingleLineFinish_()
			arg_236_1.onSingleLineUpdate_ = nil
			arg_236_1.onSingleLineFinish_ = nil
			arg_236_1.state_ = "waiting"
		end

		function arg_236_1.playNext_(arg_238_0)
			if arg_238_0 == 1 then
				arg_236_0:Play325591058(arg_236_1)
			end
		end

		function arg_236_1.onSingleLineUpdate_(arg_239_0)
			local var_239_0 = 0
			local var_239_1 = 0.825

			if var_239_0 < arg_236_1.time_ and arg_236_1.time_ <= var_239_0 + arg_239_0 then
				arg_236_1.talkMaxDuration = 0
				arg_236_1.dialogCg_.alpha = 1

				arg_236_1.dialog_:SetActive(true)
				SetActive(arg_236_1.leftNameGo_, true)

				local var_239_2 = arg_236_1:FormatText(StoryNameCfg[1510].name)

				arg_236_1.leftNameTxt_.text = var_239_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_236_1.leftNameTxt_.transform)

				arg_236_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_236_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_236_1:RecordName(arg_236_1.leftNameTxt_.text)
				SetActive(arg_236_1.iconTrs_.gameObject, false)
				arg_236_1.callingController_:SetSelectedState("normal")

				local var_239_3 = arg_236_1:GetWordFromCfg(325591057)
				local var_239_4 = arg_236_1:FormatText(var_239_3.content)

				arg_236_1.text_.text = var_239_4

				LuaForUtil.ClearLinePrefixSymbol(arg_236_1.text_)

				local var_239_5 = 33
				local var_239_6 = utf8.len(var_239_4)
				local var_239_7 = var_239_5 <= 0 and var_239_1 or var_239_1 * (var_239_6 / var_239_5)

				if var_239_7 > 0 and var_239_1 < var_239_7 then
					arg_236_1.talkMaxDuration = var_239_7

					if var_239_7 + var_239_0 > arg_236_1.duration_ then
						arg_236_1.duration_ = var_239_7 + var_239_0
					end
				end

				arg_236_1.text_.text = var_239_4
				arg_236_1.typewritter.percent = 0

				arg_236_1.typewritter:SetDirty()
				arg_236_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_325591", "325591057", "story_v_out_325591.awb") ~= 0 then
					local var_239_8 = manager.audio:GetVoiceLength("story_v_out_325591", "325591057", "story_v_out_325591.awb") / 1000

					if var_239_8 + var_239_0 > arg_236_1.duration_ then
						arg_236_1.duration_ = var_239_8 + var_239_0
					end

					if var_239_3.prefab_name ~= "" and arg_236_1.actors_[var_239_3.prefab_name] ~= nil then
						local var_239_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_236_1.actors_[var_239_3.prefab_name].transform, "story_v_out_325591", "325591057", "story_v_out_325591.awb")

						arg_236_1:RecordAudio("325591057", var_239_9)
						arg_236_1:RecordAudio("325591057", var_239_9)
					else
						arg_236_1:AudioAction("play", "voice", "story_v_out_325591", "325591057", "story_v_out_325591.awb")
					end

					arg_236_1:RecordHistoryTalkVoice("story_v_out_325591", "325591057", "story_v_out_325591.awb")
				end

				arg_236_1:RecordContent(arg_236_1.text_.text)
			end

			local var_239_10 = math.max(var_239_1, arg_236_1.talkMaxDuration)

			if var_239_0 <= arg_236_1.time_ and arg_236_1.time_ < var_239_0 + var_239_10 then
				arg_236_1.typewritter.percent = (arg_236_1.time_ - var_239_0) / var_239_10

				arg_236_1.typewritter:SetDirty()
			end

			if arg_236_1.time_ >= var_239_0 + var_239_10 and arg_236_1.time_ < var_239_0 + var_239_10 + arg_239_0 then
				arg_236_1.typewritter.percent = 1

				arg_236_1.typewritter:SetDirty()
				arg_236_1:ShowNextGo(true)
			end
		end

		arg_236_1.nodeConfigList_ = {}

		arg_236_1:InitPlayNodeList()
	end,
	Play325591058 = function(arg_240_0, arg_240_1)
		arg_240_1.time_ = 0
		arg_240_1.frameCnt_ = 0
		arg_240_1.state_ = "playing"
		arg_240_1.curTalkId_ = 325591058
		arg_240_1.duration_ = 6.4

		local var_240_0 = {
			zh = 5.033,
			ja = 6.4
		}
		local var_240_1 = manager.audio:GetLocalizationFlag()

		if var_240_0[var_240_1] ~= nil then
			arg_240_1.duration_ = var_240_0[var_240_1]
		end

		SetActive(arg_240_1.tipsGo_, false)

		function arg_240_1.onSingleLineFinish_()
			arg_240_1.onSingleLineUpdate_ = nil
			arg_240_1.onSingleLineFinish_ = nil
			arg_240_1.state_ = "waiting"
		end

		function arg_240_1.playNext_(arg_242_0)
			if arg_242_0 == 1 then
				arg_240_0:Play325591059(arg_240_1)
			end
		end

		function arg_240_1.onSingleLineUpdate_(arg_243_0)
			local var_243_0 = arg_240_1.actors_["10176ui_story"].transform
			local var_243_1 = 0

			if var_243_1 < arg_240_1.time_ and arg_240_1.time_ <= var_243_1 + arg_243_0 then
				arg_240_1.var_.moveOldPos10176ui_story = var_243_0.localPosition

				local var_243_2 = GameObjectTools.GetOrAddComponent(var_243_0.gameObject, typeof(DynamicBoneHelper))

				if var_243_2 then
					var_243_2:EnableDynamicBone(false)
				end
			end

			local var_243_3 = 0.001

			if var_243_1 <= arg_240_1.time_ and arg_240_1.time_ < var_243_1 + var_243_3 then
				local var_243_4 = (arg_240_1.time_ - var_243_1) / var_243_3
				local var_243_5 = Vector3.New(-0.7, -1.09, -6.12)

				var_243_0.localPosition = Vector3.Lerp(arg_240_1.var_.moveOldPos10176ui_story, var_243_5, var_243_4)

				local var_243_6 = manager.ui.mainCamera.transform.position - var_243_0.position

				var_243_0.forward = Vector3.New(var_243_6.x, var_243_6.y, var_243_6.z)

				local var_243_7 = var_243_0.localEulerAngles

				var_243_7.z = 0
				var_243_7.x = 0
				var_243_0.localEulerAngles = var_243_7
			end

			if arg_240_1.time_ >= var_243_1 + var_243_3 and arg_240_1.time_ < var_243_1 + var_243_3 + arg_243_0 then
				var_243_0.localPosition = Vector3.New(-0.7, -1.09, -6.12)

				local var_243_8 = manager.ui.mainCamera.transform.position - var_243_0.position

				var_243_0.forward = Vector3.New(var_243_8.x, var_243_8.y, var_243_8.z)

				local var_243_9 = var_243_0.localEulerAngles

				var_243_9.z = 0
				var_243_9.x = 0
				var_243_0.localEulerAngles = var_243_9

				local var_243_10 = GameObjectTools.GetOrAddComponent(var_243_0.gameObject, typeof(DynamicBoneHelper))

				if var_243_10 then
					var_243_10:EnableDynamicBone(true)
				end
			end

			local var_243_11 = arg_240_1.actors_["1054ui_story"].transform
			local var_243_12 = 0

			if var_243_12 < arg_240_1.time_ and arg_240_1.time_ <= var_243_12 + arg_243_0 then
				arg_240_1.var_.moveOldPos1054ui_story = var_243_11.localPosition

				local var_243_13 = GameObjectTools.GetOrAddComponent(var_243_11.gameObject, typeof(DynamicBoneHelper))

				if var_243_13 then
					var_243_13:EnableDynamicBone(false)
				end
			end

			local var_243_14 = 0.001

			if var_243_12 <= arg_240_1.time_ and arg_240_1.time_ < var_243_12 + var_243_14 then
				local var_243_15 = (arg_240_1.time_ - var_243_12) / var_243_14
				local var_243_16 = Vector3.New(0.7, -0.985, -6)

				var_243_11.localPosition = Vector3.Lerp(arg_240_1.var_.moveOldPos1054ui_story, var_243_16, var_243_15)

				local var_243_17 = manager.ui.mainCamera.transform.position - var_243_11.position

				var_243_11.forward = Vector3.New(var_243_17.x, var_243_17.y, var_243_17.z)

				local var_243_18 = var_243_11.localEulerAngles

				var_243_18.z = 0
				var_243_18.x = 0
				var_243_11.localEulerAngles = var_243_18
			end

			if arg_240_1.time_ >= var_243_12 + var_243_14 and arg_240_1.time_ < var_243_12 + var_243_14 + arg_243_0 then
				var_243_11.localPosition = Vector3.New(0.7, -0.985, -6)

				local var_243_19 = manager.ui.mainCamera.transform.position - var_243_11.position

				var_243_11.forward = Vector3.New(var_243_19.x, var_243_19.y, var_243_19.z)

				local var_243_20 = var_243_11.localEulerAngles

				var_243_20.z = 0
				var_243_20.x = 0
				var_243_11.localEulerAngles = var_243_20

				local var_243_21 = GameObjectTools.GetOrAddComponent(var_243_11.gameObject, typeof(DynamicBoneHelper))

				if var_243_21 then
					var_243_21:EnableDynamicBone(true)
				end
			end

			local var_243_22 = arg_240_1.actors_["1054ui_story"]
			local var_243_23 = 0

			if var_243_23 < arg_240_1.time_ and arg_240_1.time_ <= var_243_23 + arg_243_0 and not isNil(var_243_22) and arg_240_1.var_.characterEffect1054ui_story == nil then
				arg_240_1.var_.characterEffect1054ui_story = var_243_22:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_243_24 = 0.200000002980232

			if var_243_23 <= arg_240_1.time_ and arg_240_1.time_ < var_243_23 + var_243_24 and not isNil(var_243_22) then
				local var_243_25 = (arg_240_1.time_ - var_243_23) / var_243_24

				if arg_240_1.var_.characterEffect1054ui_story and not isNil(var_243_22) then
					arg_240_1.var_.characterEffect1054ui_story.fillFlat = false
				end
			end

			if arg_240_1.time_ >= var_243_23 + var_243_24 and arg_240_1.time_ < var_243_23 + var_243_24 + arg_243_0 and not isNil(var_243_22) and arg_240_1.var_.characterEffect1054ui_story then
				arg_240_1.var_.characterEffect1054ui_story.fillFlat = false
			end

			local var_243_26 = arg_240_1.actors_["10176ui_story"]
			local var_243_27 = 0

			if var_243_27 < arg_240_1.time_ and arg_240_1.time_ <= var_243_27 + arg_243_0 and not isNil(var_243_26) and arg_240_1.var_.characterEffect10176ui_story == nil then
				arg_240_1.var_.characterEffect10176ui_story = var_243_26:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_243_28 = 0.200000002980232

			if var_243_27 <= arg_240_1.time_ and arg_240_1.time_ < var_243_27 + var_243_28 and not isNil(var_243_26) then
				local var_243_29 = (arg_240_1.time_ - var_243_27) / var_243_28

				if arg_240_1.var_.characterEffect10176ui_story and not isNil(var_243_26) then
					local var_243_30 = Mathf.Lerp(0, 0.5, var_243_29)

					arg_240_1.var_.characterEffect10176ui_story.fillFlat = true
					arg_240_1.var_.characterEffect10176ui_story.fillRatio = var_243_30
				end
			end

			if arg_240_1.time_ >= var_243_27 + var_243_28 and arg_240_1.time_ < var_243_27 + var_243_28 + arg_243_0 and not isNil(var_243_26) and arg_240_1.var_.characterEffect10176ui_story then
				local var_243_31 = 0.5

				arg_240_1.var_.characterEffect10176ui_story.fillFlat = true
				arg_240_1.var_.characterEffect10176ui_story.fillRatio = var_243_31
			end

			local var_243_32 = 0
			local var_243_33 = 0.525

			if var_243_32 < arg_240_1.time_ and arg_240_1.time_ <= var_243_32 + arg_243_0 then
				arg_240_1.talkMaxDuration = 0
				arg_240_1.dialogCg_.alpha = 1

				arg_240_1.dialog_:SetActive(true)
				SetActive(arg_240_1.leftNameGo_, true)

				local var_243_34 = arg_240_1:FormatText(StoryNameCfg[1487].name)

				arg_240_1.leftNameTxt_.text = var_243_34

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_240_1.leftNameTxt_.transform)

				arg_240_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_240_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_240_1:RecordName(arg_240_1.leftNameTxt_.text)
				SetActive(arg_240_1.iconTrs_.gameObject, false)
				arg_240_1.callingController_:SetSelectedState("normal")

				local var_243_35 = arg_240_1:GetWordFromCfg(325591058)
				local var_243_36 = arg_240_1:FormatText(var_243_35.content)

				arg_240_1.text_.text = var_243_36

				LuaForUtil.ClearLinePrefixSymbol(arg_240_1.text_)

				local var_243_37 = 21
				local var_243_38 = utf8.len(var_243_36)
				local var_243_39 = var_243_37 <= 0 and var_243_33 or var_243_33 * (var_243_38 / var_243_37)

				if var_243_39 > 0 and var_243_33 < var_243_39 then
					arg_240_1.talkMaxDuration = var_243_39

					if var_243_39 + var_243_32 > arg_240_1.duration_ then
						arg_240_1.duration_ = var_243_39 + var_243_32
					end
				end

				arg_240_1.text_.text = var_243_36
				arg_240_1.typewritter.percent = 0

				arg_240_1.typewritter:SetDirty()
				arg_240_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_325591", "325591058", "story_v_out_325591.awb") ~= 0 then
					local var_243_40 = manager.audio:GetVoiceLength("story_v_out_325591", "325591058", "story_v_out_325591.awb") / 1000

					if var_243_40 + var_243_32 > arg_240_1.duration_ then
						arg_240_1.duration_ = var_243_40 + var_243_32
					end

					if var_243_35.prefab_name ~= "" and arg_240_1.actors_[var_243_35.prefab_name] ~= nil then
						local var_243_41 = LuaForUtil.PlayVoiceWithCriLipsync(arg_240_1.actors_[var_243_35.prefab_name].transform, "story_v_out_325591", "325591058", "story_v_out_325591.awb")

						arg_240_1:RecordAudio("325591058", var_243_41)
						arg_240_1:RecordAudio("325591058", var_243_41)
					else
						arg_240_1:AudioAction("play", "voice", "story_v_out_325591", "325591058", "story_v_out_325591.awb")
					end

					arg_240_1:RecordHistoryTalkVoice("story_v_out_325591", "325591058", "story_v_out_325591.awb")
				end

				arg_240_1:RecordContent(arg_240_1.text_.text)
			end

			local var_243_42 = math.max(var_243_33, arg_240_1.talkMaxDuration)

			if var_243_32 <= arg_240_1.time_ and arg_240_1.time_ < var_243_32 + var_243_42 then
				arg_240_1.typewritter.percent = (arg_240_1.time_ - var_243_32) / var_243_42

				arg_240_1.typewritter:SetDirty()
			end

			if arg_240_1.time_ >= var_243_32 + var_243_42 and arg_240_1.time_ < var_243_32 + var_243_42 + arg_243_0 then
				arg_240_1.typewritter.percent = 1

				arg_240_1.typewritter:SetDirty()
				arg_240_1:ShowNextGo(true)
			end
		end

		arg_240_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10176ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1054ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_240_1:InitPlayNodeList()
	end,
	Play325591059 = function(arg_244_0, arg_244_1)
		arg_244_1.time_ = 0
		arg_244_1.frameCnt_ = 0
		arg_244_1.state_ = "playing"
		arg_244_1.curTalkId_ = 325591059
		arg_244_1.duration_ = 9.23

		local var_244_0 = {
			zh = 8.633,
			ja = 9.233
		}
		local var_244_1 = manager.audio:GetLocalizationFlag()

		if var_244_0[var_244_1] ~= nil then
			arg_244_1.duration_ = var_244_0[var_244_1]
		end

		SetActive(arg_244_1.tipsGo_, false)

		function arg_244_1.onSingleLineFinish_()
			arg_244_1.onSingleLineUpdate_ = nil
			arg_244_1.onSingleLineFinish_ = nil
			arg_244_1.state_ = "waiting"
		end

		function arg_244_1.playNext_(arg_246_0)
			if arg_246_0 == 1 then
				arg_244_0:Play325591060(arg_244_1)
			end
		end

		function arg_244_1.onSingleLineUpdate_(arg_247_0)
			local var_247_0 = arg_244_1.actors_["10176ui_story"]
			local var_247_1 = 0

			if var_247_1 < arg_244_1.time_ and arg_244_1.time_ <= var_247_1 + arg_247_0 and not isNil(var_247_0) and arg_244_1.var_.characterEffect10176ui_story == nil then
				arg_244_1.var_.characterEffect10176ui_story = var_247_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_247_2 = 0.200000002980232

			if var_247_1 <= arg_244_1.time_ and arg_244_1.time_ < var_247_1 + var_247_2 and not isNil(var_247_0) then
				local var_247_3 = (arg_244_1.time_ - var_247_1) / var_247_2

				if arg_244_1.var_.characterEffect10176ui_story and not isNil(var_247_0) then
					arg_244_1.var_.characterEffect10176ui_story.fillFlat = false
				end
			end

			if arg_244_1.time_ >= var_247_1 + var_247_2 and arg_244_1.time_ < var_247_1 + var_247_2 + arg_247_0 and not isNil(var_247_0) and arg_244_1.var_.characterEffect10176ui_story then
				arg_244_1.var_.characterEffect10176ui_story.fillFlat = false
			end

			local var_247_4 = arg_244_1.actors_["1054ui_story"]
			local var_247_5 = 0

			if var_247_5 < arg_244_1.time_ and arg_244_1.time_ <= var_247_5 + arg_247_0 and not isNil(var_247_4) and arg_244_1.var_.characterEffect1054ui_story == nil then
				arg_244_1.var_.characterEffect1054ui_story = var_247_4:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_247_6 = 0.200000002980232

			if var_247_5 <= arg_244_1.time_ and arg_244_1.time_ < var_247_5 + var_247_6 and not isNil(var_247_4) then
				local var_247_7 = (arg_244_1.time_ - var_247_5) / var_247_6

				if arg_244_1.var_.characterEffect1054ui_story and not isNil(var_247_4) then
					local var_247_8 = Mathf.Lerp(0, 0.5, var_247_7)

					arg_244_1.var_.characterEffect1054ui_story.fillFlat = true
					arg_244_1.var_.characterEffect1054ui_story.fillRatio = var_247_8
				end
			end

			if arg_244_1.time_ >= var_247_5 + var_247_6 and arg_244_1.time_ < var_247_5 + var_247_6 + arg_247_0 and not isNil(var_247_4) and arg_244_1.var_.characterEffect1054ui_story then
				local var_247_9 = 0.5

				arg_244_1.var_.characterEffect1054ui_story.fillFlat = true
				arg_244_1.var_.characterEffect1054ui_story.fillRatio = var_247_9
			end

			local var_247_10 = 0

			if var_247_10 < arg_244_1.time_ and arg_244_1.time_ <= var_247_10 + arg_247_0 then
				arg_244_1:PlayTimeline("10176ui_story", "StoryTimeline/CharAction/story10176/story10176action/10176action5_2")
			end

			local var_247_11 = 0

			if var_247_11 < arg_244_1.time_ and arg_244_1.time_ <= var_247_11 + arg_247_0 then
				arg_244_1:PlayTimeline("10176ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0101cva", "EmotionTimelineAnimator")
			end

			local var_247_12 = 0
			local var_247_13 = 0.725

			if var_247_12 < arg_244_1.time_ and arg_244_1.time_ <= var_247_12 + arg_247_0 then
				arg_244_1.talkMaxDuration = 0
				arg_244_1.dialogCg_.alpha = 1

				arg_244_1.dialog_:SetActive(true)
				SetActive(arg_244_1.leftNameGo_, true)

				local var_247_14 = arg_244_1:FormatText(StoryNameCfg[1510].name)

				arg_244_1.leftNameTxt_.text = var_247_14

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_244_1.leftNameTxt_.transform)

				arg_244_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_244_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_244_1:RecordName(arg_244_1.leftNameTxt_.text)
				SetActive(arg_244_1.iconTrs_.gameObject, false)
				arg_244_1.callingController_:SetSelectedState("normal")

				local var_247_15 = arg_244_1:GetWordFromCfg(325591059)
				local var_247_16 = arg_244_1:FormatText(var_247_15.content)

				arg_244_1.text_.text = var_247_16

				LuaForUtil.ClearLinePrefixSymbol(arg_244_1.text_)

				local var_247_17 = 29
				local var_247_18 = utf8.len(var_247_16)
				local var_247_19 = var_247_17 <= 0 and var_247_13 or var_247_13 * (var_247_18 / var_247_17)

				if var_247_19 > 0 and var_247_13 < var_247_19 then
					arg_244_1.talkMaxDuration = var_247_19

					if var_247_19 + var_247_12 > arg_244_1.duration_ then
						arg_244_1.duration_ = var_247_19 + var_247_12
					end
				end

				arg_244_1.text_.text = var_247_16
				arg_244_1.typewritter.percent = 0

				arg_244_1.typewritter:SetDirty()
				arg_244_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_325591", "325591059", "story_v_out_325591.awb") ~= 0 then
					local var_247_20 = manager.audio:GetVoiceLength("story_v_out_325591", "325591059", "story_v_out_325591.awb") / 1000

					if var_247_20 + var_247_12 > arg_244_1.duration_ then
						arg_244_1.duration_ = var_247_20 + var_247_12
					end

					if var_247_15.prefab_name ~= "" and arg_244_1.actors_[var_247_15.prefab_name] ~= nil then
						local var_247_21 = LuaForUtil.PlayVoiceWithCriLipsync(arg_244_1.actors_[var_247_15.prefab_name].transform, "story_v_out_325591", "325591059", "story_v_out_325591.awb")

						arg_244_1:RecordAudio("325591059", var_247_21)
						arg_244_1:RecordAudio("325591059", var_247_21)
					else
						arg_244_1:AudioAction("play", "voice", "story_v_out_325591", "325591059", "story_v_out_325591.awb")
					end

					arg_244_1:RecordHistoryTalkVoice("story_v_out_325591", "325591059", "story_v_out_325591.awb")
				end

				arg_244_1:RecordContent(arg_244_1.text_.text)
			end

			local var_247_22 = math.max(var_247_13, arg_244_1.talkMaxDuration)

			if var_247_12 <= arg_244_1.time_ and arg_244_1.time_ < var_247_12 + var_247_22 then
				arg_244_1.typewritter.percent = (arg_244_1.time_ - var_247_12) / var_247_22

				arg_244_1.typewritter:SetDirty()
			end

			if arg_244_1.time_ >= var_247_12 + var_247_22 and arg_244_1.time_ < var_247_12 + var_247_22 + arg_247_0 then
				arg_244_1.typewritter.percent = 1

				arg_244_1.typewritter:SetDirty()
				arg_244_1:ShowNextGo(true)
			end
		end

		arg_244_1.nodeConfigList_ = {}

		arg_244_1:InitPlayNodeList()
	end,
	Play325591060 = function(arg_248_0, arg_248_1)
		arg_248_1.time_ = 0
		arg_248_1.frameCnt_ = 0
		arg_248_1.state_ = "playing"
		arg_248_1.curTalkId_ = 325591060
		arg_248_1.duration_ = 3.87

		local var_248_0 = {
			zh = 3.466,
			ja = 3.866
		}
		local var_248_1 = manager.audio:GetLocalizationFlag()

		if var_248_0[var_248_1] ~= nil then
			arg_248_1.duration_ = var_248_0[var_248_1]
		end

		SetActive(arg_248_1.tipsGo_, false)

		function arg_248_1.onSingleLineFinish_()
			arg_248_1.onSingleLineUpdate_ = nil
			arg_248_1.onSingleLineFinish_ = nil
			arg_248_1.state_ = "waiting"
		end

		function arg_248_1.playNext_(arg_250_0)
			if arg_250_0 == 1 then
				arg_248_0:Play325591061(arg_248_1)
			end
		end

		function arg_248_1.onSingleLineUpdate_(arg_251_0)
			local var_251_0 = 0
			local var_251_1 = 0.375

			if var_251_0 < arg_248_1.time_ and arg_248_1.time_ <= var_251_0 + arg_251_0 then
				arg_248_1.talkMaxDuration = 0
				arg_248_1.dialogCg_.alpha = 1

				arg_248_1.dialog_:SetActive(true)
				SetActive(arg_248_1.leftNameGo_, true)

				local var_251_2 = arg_248_1:FormatText(StoryNameCfg[1510].name)

				arg_248_1.leftNameTxt_.text = var_251_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_248_1.leftNameTxt_.transform)

				arg_248_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_248_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_248_1:RecordName(arg_248_1.leftNameTxt_.text)
				SetActive(arg_248_1.iconTrs_.gameObject, false)
				arg_248_1.callingController_:SetSelectedState("normal")

				local var_251_3 = arg_248_1:GetWordFromCfg(325591060)
				local var_251_4 = arg_248_1:FormatText(var_251_3.content)

				arg_248_1.text_.text = var_251_4

				LuaForUtil.ClearLinePrefixSymbol(arg_248_1.text_)

				local var_251_5 = 15
				local var_251_6 = utf8.len(var_251_4)
				local var_251_7 = var_251_5 <= 0 and var_251_1 or var_251_1 * (var_251_6 / var_251_5)

				if var_251_7 > 0 and var_251_1 < var_251_7 then
					arg_248_1.talkMaxDuration = var_251_7

					if var_251_7 + var_251_0 > arg_248_1.duration_ then
						arg_248_1.duration_ = var_251_7 + var_251_0
					end
				end

				arg_248_1.text_.text = var_251_4
				arg_248_1.typewritter.percent = 0

				arg_248_1.typewritter:SetDirty()
				arg_248_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_325591", "325591060", "story_v_out_325591.awb") ~= 0 then
					local var_251_8 = manager.audio:GetVoiceLength("story_v_out_325591", "325591060", "story_v_out_325591.awb") / 1000

					if var_251_8 + var_251_0 > arg_248_1.duration_ then
						arg_248_1.duration_ = var_251_8 + var_251_0
					end

					if var_251_3.prefab_name ~= "" and arg_248_1.actors_[var_251_3.prefab_name] ~= nil then
						local var_251_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_248_1.actors_[var_251_3.prefab_name].transform, "story_v_out_325591", "325591060", "story_v_out_325591.awb")

						arg_248_1:RecordAudio("325591060", var_251_9)
						arg_248_1:RecordAudio("325591060", var_251_9)
					else
						arg_248_1:AudioAction("play", "voice", "story_v_out_325591", "325591060", "story_v_out_325591.awb")
					end

					arg_248_1:RecordHistoryTalkVoice("story_v_out_325591", "325591060", "story_v_out_325591.awb")
				end

				arg_248_1:RecordContent(arg_248_1.text_.text)
			end

			local var_251_10 = math.max(var_251_1, arg_248_1.talkMaxDuration)

			if var_251_0 <= arg_248_1.time_ and arg_248_1.time_ < var_251_0 + var_251_10 then
				arg_248_1.typewritter.percent = (arg_248_1.time_ - var_251_0) / var_251_10

				arg_248_1.typewritter:SetDirty()
			end

			if arg_248_1.time_ >= var_251_0 + var_251_10 and arg_248_1.time_ < var_251_0 + var_251_10 + arg_251_0 then
				arg_248_1.typewritter.percent = 1

				arg_248_1.typewritter:SetDirty()
				arg_248_1:ShowNextGo(true)
			end
		end

		arg_248_1.nodeConfigList_ = {}

		arg_248_1:InitPlayNodeList()
	end,
	Play325591061 = function(arg_252_0, arg_252_1)
		arg_252_1.time_ = 0
		arg_252_1.frameCnt_ = 0
		arg_252_1.state_ = "playing"
		arg_252_1.curTalkId_ = 325591061
		arg_252_1.duration_ = 3.77

		local var_252_0 = {
			zh = 3,
			ja = 3.766
		}
		local var_252_1 = manager.audio:GetLocalizationFlag()

		if var_252_0[var_252_1] ~= nil then
			arg_252_1.duration_ = var_252_0[var_252_1]
		end

		SetActive(arg_252_1.tipsGo_, false)

		function arg_252_1.onSingleLineFinish_()
			arg_252_1.onSingleLineUpdate_ = nil
			arg_252_1.onSingleLineFinish_ = nil
			arg_252_1.state_ = "waiting"
		end

		function arg_252_1.playNext_(arg_254_0)
			if arg_254_0 == 1 then
				arg_252_0:Play325591062(arg_252_1)
			end
		end

		function arg_252_1.onSingleLineUpdate_(arg_255_0)
			local var_255_0 = arg_252_1.actors_["1054ui_story"].transform
			local var_255_1 = 0

			if var_255_1 < arg_252_1.time_ and arg_252_1.time_ <= var_255_1 + arg_255_0 then
				arg_252_1.var_.moveOldPos1054ui_story = var_255_0.localPosition

				local var_255_2 = GameObjectTools.GetOrAddComponent(var_255_0.gameObject, typeof(DynamicBoneHelper))

				if var_255_2 then
					var_255_2:EnableDynamicBone(false)
				end
			end

			local var_255_3 = 0.001

			if var_255_1 <= arg_252_1.time_ and arg_252_1.time_ < var_255_1 + var_255_3 then
				local var_255_4 = (arg_252_1.time_ - var_255_1) / var_255_3
				local var_255_5 = Vector3.New(0, 100, 0)

				var_255_0.localPosition = Vector3.Lerp(arg_252_1.var_.moveOldPos1054ui_story, var_255_5, var_255_4)

				local var_255_6 = manager.ui.mainCamera.transform.position - var_255_0.position

				var_255_0.forward = Vector3.New(var_255_6.x, var_255_6.y, var_255_6.z)

				local var_255_7 = var_255_0.localEulerAngles

				var_255_7.z = 0
				var_255_7.x = 0
				var_255_0.localEulerAngles = var_255_7
			end

			if arg_252_1.time_ >= var_255_1 + var_255_3 and arg_252_1.time_ < var_255_1 + var_255_3 + arg_255_0 then
				var_255_0.localPosition = Vector3.New(0, 100, 0)

				local var_255_8 = manager.ui.mainCamera.transform.position - var_255_0.position

				var_255_0.forward = Vector3.New(var_255_8.x, var_255_8.y, var_255_8.z)

				local var_255_9 = var_255_0.localEulerAngles

				var_255_9.z = 0
				var_255_9.x = 0
				var_255_0.localEulerAngles = var_255_9

				local var_255_10 = GameObjectTools.GetOrAddComponent(var_255_0.gameObject, typeof(DynamicBoneHelper))

				if var_255_10 then
					var_255_10:EnableDynamicBone(true)
				end
			end

			local var_255_11 = arg_252_1.actors_["6148ui_story"].transform
			local var_255_12 = 0

			if var_255_12 < arg_252_1.time_ and arg_252_1.time_ <= var_255_12 + arg_255_0 then
				arg_252_1.var_.moveOldPos6148ui_story = var_255_11.localPosition

				local var_255_13 = GameObjectTools.GetOrAddComponent(var_255_11.gameObject, typeof(DynamicBoneHelper))

				if var_255_13 then
					var_255_13:EnableDynamicBone(false)
				end
			end

			local var_255_14 = 0.001

			if var_255_12 <= arg_252_1.time_ and arg_252_1.time_ < var_255_12 + var_255_14 then
				local var_255_15 = (arg_252_1.time_ - var_255_12) / var_255_14
				local var_255_16 = Vector3.New(0.7, -0.985, -6)

				var_255_11.localPosition = Vector3.Lerp(arg_252_1.var_.moveOldPos6148ui_story, var_255_16, var_255_15)

				local var_255_17 = manager.ui.mainCamera.transform.position - var_255_11.position

				var_255_11.forward = Vector3.New(var_255_17.x, var_255_17.y, var_255_17.z)

				local var_255_18 = var_255_11.localEulerAngles

				var_255_18.z = 0
				var_255_18.x = 0
				var_255_11.localEulerAngles = var_255_18
			end

			if arg_252_1.time_ >= var_255_12 + var_255_14 and arg_252_1.time_ < var_255_12 + var_255_14 + arg_255_0 then
				var_255_11.localPosition = Vector3.New(0.7, -0.985, -6)

				local var_255_19 = manager.ui.mainCamera.transform.position - var_255_11.position

				var_255_11.forward = Vector3.New(var_255_19.x, var_255_19.y, var_255_19.z)

				local var_255_20 = var_255_11.localEulerAngles

				var_255_20.z = 0
				var_255_20.x = 0
				var_255_11.localEulerAngles = var_255_20

				local var_255_21 = GameObjectTools.GetOrAddComponent(var_255_11.gameObject, typeof(DynamicBoneHelper))

				if var_255_21 then
					var_255_21:EnableDynamicBone(true)
				end
			end

			local var_255_22 = arg_252_1.actors_["6148ui_story"]
			local var_255_23 = 0

			if var_255_23 < arg_252_1.time_ and arg_252_1.time_ <= var_255_23 + arg_255_0 and not isNil(var_255_22) and arg_252_1.var_.characterEffect6148ui_story == nil then
				arg_252_1.var_.characterEffect6148ui_story = var_255_22:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_255_24 = 0.200000002980232

			if var_255_23 <= arg_252_1.time_ and arg_252_1.time_ < var_255_23 + var_255_24 and not isNil(var_255_22) then
				local var_255_25 = (arg_252_1.time_ - var_255_23) / var_255_24

				if arg_252_1.var_.characterEffect6148ui_story and not isNil(var_255_22) then
					arg_252_1.var_.characterEffect6148ui_story.fillFlat = false
				end
			end

			if arg_252_1.time_ >= var_255_23 + var_255_24 and arg_252_1.time_ < var_255_23 + var_255_24 + arg_255_0 and not isNil(var_255_22) and arg_252_1.var_.characterEffect6148ui_story then
				arg_252_1.var_.characterEffect6148ui_story.fillFlat = false
			end

			local var_255_26 = arg_252_1.actors_["10176ui_story"]
			local var_255_27 = 0

			if var_255_27 < arg_252_1.time_ and arg_252_1.time_ <= var_255_27 + arg_255_0 and not isNil(var_255_26) and arg_252_1.var_.characterEffect10176ui_story == nil then
				arg_252_1.var_.characterEffect10176ui_story = var_255_26:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_255_28 = 0.200000002980232

			if var_255_27 <= arg_252_1.time_ and arg_252_1.time_ < var_255_27 + var_255_28 and not isNil(var_255_26) then
				local var_255_29 = (arg_252_1.time_ - var_255_27) / var_255_28

				if arg_252_1.var_.characterEffect10176ui_story and not isNil(var_255_26) then
					local var_255_30 = Mathf.Lerp(0, 0.5, var_255_29)

					arg_252_1.var_.characterEffect10176ui_story.fillFlat = true
					arg_252_1.var_.characterEffect10176ui_story.fillRatio = var_255_30
				end
			end

			if arg_252_1.time_ >= var_255_27 + var_255_28 and arg_252_1.time_ < var_255_27 + var_255_28 + arg_255_0 and not isNil(var_255_26) and arg_252_1.var_.characterEffect10176ui_story then
				local var_255_31 = 0.5

				arg_252_1.var_.characterEffect10176ui_story.fillFlat = true
				arg_252_1.var_.characterEffect10176ui_story.fillRatio = var_255_31
			end

			local var_255_32 = 0
			local var_255_33 = 0.225

			if var_255_32 < arg_252_1.time_ and arg_252_1.time_ <= var_255_32 + arg_255_0 then
				arg_252_1.talkMaxDuration = 0
				arg_252_1.dialogCg_.alpha = 1

				arg_252_1.dialog_:SetActive(true)
				SetActive(arg_252_1.leftNameGo_, true)

				local var_255_34 = arg_252_1:FormatText(StoryNameCfg[1488].name)

				arg_252_1.leftNameTxt_.text = var_255_34

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_252_1.leftNameTxt_.transform)

				arg_252_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_252_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_252_1:RecordName(arg_252_1.leftNameTxt_.text)
				SetActive(arg_252_1.iconTrs_.gameObject, false)
				arg_252_1.callingController_:SetSelectedState("normal")

				local var_255_35 = arg_252_1:GetWordFromCfg(325591061)
				local var_255_36 = arg_252_1:FormatText(var_255_35.content)

				arg_252_1.text_.text = var_255_36

				LuaForUtil.ClearLinePrefixSymbol(arg_252_1.text_)

				local var_255_37 = 9
				local var_255_38 = utf8.len(var_255_36)
				local var_255_39 = var_255_37 <= 0 and var_255_33 or var_255_33 * (var_255_38 / var_255_37)

				if var_255_39 > 0 and var_255_33 < var_255_39 then
					arg_252_1.talkMaxDuration = var_255_39

					if var_255_39 + var_255_32 > arg_252_1.duration_ then
						arg_252_1.duration_ = var_255_39 + var_255_32
					end
				end

				arg_252_1.text_.text = var_255_36
				arg_252_1.typewritter.percent = 0

				arg_252_1.typewritter:SetDirty()
				arg_252_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_325591", "325591061", "story_v_out_325591.awb") ~= 0 then
					local var_255_40 = manager.audio:GetVoiceLength("story_v_out_325591", "325591061", "story_v_out_325591.awb") / 1000

					if var_255_40 + var_255_32 > arg_252_1.duration_ then
						arg_252_1.duration_ = var_255_40 + var_255_32
					end

					if var_255_35.prefab_name ~= "" and arg_252_1.actors_[var_255_35.prefab_name] ~= nil then
						local var_255_41 = LuaForUtil.PlayVoiceWithCriLipsync(arg_252_1.actors_[var_255_35.prefab_name].transform, "story_v_out_325591", "325591061", "story_v_out_325591.awb")

						arg_252_1:RecordAudio("325591061", var_255_41)
						arg_252_1:RecordAudio("325591061", var_255_41)
					else
						arg_252_1:AudioAction("play", "voice", "story_v_out_325591", "325591061", "story_v_out_325591.awb")
					end

					arg_252_1:RecordHistoryTalkVoice("story_v_out_325591", "325591061", "story_v_out_325591.awb")
				end

				arg_252_1:RecordContent(arg_252_1.text_.text)
			end

			local var_255_42 = math.max(var_255_33, arg_252_1.talkMaxDuration)

			if var_255_32 <= arg_252_1.time_ and arg_252_1.time_ < var_255_32 + var_255_42 then
				arg_252_1.typewritter.percent = (arg_252_1.time_ - var_255_32) / var_255_42

				arg_252_1.typewritter:SetDirty()
			end

			if arg_252_1.time_ >= var_255_32 + var_255_42 and arg_252_1.time_ < var_255_32 + var_255_42 + arg_255_0 then
				arg_252_1.typewritter.percent = 1

				arg_252_1.typewritter:SetDirty()
				arg_252_1:ShowNextGo(true)
			end
		end

		arg_252_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1054ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "6148ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_252_1:InitPlayNodeList()
	end,
	Play325591062 = function(arg_256_0, arg_256_1)
		arg_256_1.time_ = 0
		arg_256_1.frameCnt_ = 0
		arg_256_1.state_ = "playing"
		arg_256_1.curTalkId_ = 325591062
		arg_256_1.duration_ = 8.27

		local var_256_0 = {
			zh = 7.2,
			ja = 8.266
		}
		local var_256_1 = manager.audio:GetLocalizationFlag()

		if var_256_0[var_256_1] ~= nil then
			arg_256_1.duration_ = var_256_0[var_256_1]
		end

		SetActive(arg_256_1.tipsGo_, false)

		function arg_256_1.onSingleLineFinish_()
			arg_256_1.onSingleLineUpdate_ = nil
			arg_256_1.onSingleLineFinish_ = nil
			arg_256_1.state_ = "waiting"
		end

		function arg_256_1.playNext_(arg_258_0)
			if arg_258_0 == 1 then
				arg_256_0:Play325591063(arg_256_1)
			end
		end

		function arg_256_1.onSingleLineUpdate_(arg_259_0)
			local var_259_0 = arg_256_1.actors_["10176ui_story"]
			local var_259_1 = 0

			if var_259_1 < arg_256_1.time_ and arg_256_1.time_ <= var_259_1 + arg_259_0 and not isNil(var_259_0) and arg_256_1.var_.characterEffect10176ui_story == nil then
				arg_256_1.var_.characterEffect10176ui_story = var_259_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_259_2 = 0.200000002980232

			if var_259_1 <= arg_256_1.time_ and arg_256_1.time_ < var_259_1 + var_259_2 and not isNil(var_259_0) then
				local var_259_3 = (arg_256_1.time_ - var_259_1) / var_259_2

				if arg_256_1.var_.characterEffect10176ui_story and not isNil(var_259_0) then
					arg_256_1.var_.characterEffect10176ui_story.fillFlat = false
				end
			end

			if arg_256_1.time_ >= var_259_1 + var_259_2 and arg_256_1.time_ < var_259_1 + var_259_2 + arg_259_0 and not isNil(var_259_0) and arg_256_1.var_.characterEffect10176ui_story then
				arg_256_1.var_.characterEffect10176ui_story.fillFlat = false
			end

			local var_259_4 = arg_256_1.actors_["6148ui_story"]
			local var_259_5 = 0

			if var_259_5 < arg_256_1.time_ and arg_256_1.time_ <= var_259_5 + arg_259_0 and not isNil(var_259_4) and arg_256_1.var_.characterEffect6148ui_story == nil then
				arg_256_1.var_.characterEffect6148ui_story = var_259_4:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_259_6 = 0.200000002980232

			if var_259_5 <= arg_256_1.time_ and arg_256_1.time_ < var_259_5 + var_259_6 and not isNil(var_259_4) then
				local var_259_7 = (arg_256_1.time_ - var_259_5) / var_259_6

				if arg_256_1.var_.characterEffect6148ui_story and not isNil(var_259_4) then
					local var_259_8 = Mathf.Lerp(0, 0.5, var_259_7)

					arg_256_1.var_.characterEffect6148ui_story.fillFlat = true
					arg_256_1.var_.characterEffect6148ui_story.fillRatio = var_259_8
				end
			end

			if arg_256_1.time_ >= var_259_5 + var_259_6 and arg_256_1.time_ < var_259_5 + var_259_6 + arg_259_0 and not isNil(var_259_4) and arg_256_1.var_.characterEffect6148ui_story then
				local var_259_9 = 0.5

				arg_256_1.var_.characterEffect6148ui_story.fillFlat = true
				arg_256_1.var_.characterEffect6148ui_story.fillRatio = var_259_9
			end

			local var_259_10 = 0

			if var_259_10 < arg_256_1.time_ and arg_256_1.time_ <= var_259_10 + arg_259_0 then
				arg_256_1:PlayTimeline("10176ui_story", "StoryTimeline/CharAction/story10176/story10176action/10176action1_1")
			end

			local var_259_11 = 0
			local var_259_12 = 0.775

			if var_259_11 < arg_256_1.time_ and arg_256_1.time_ <= var_259_11 + arg_259_0 then
				arg_256_1.talkMaxDuration = 0
				arg_256_1.dialogCg_.alpha = 1

				arg_256_1.dialog_:SetActive(true)
				SetActive(arg_256_1.leftNameGo_, true)

				local var_259_13 = arg_256_1:FormatText(StoryNameCfg[1510].name)

				arg_256_1.leftNameTxt_.text = var_259_13

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_256_1.leftNameTxt_.transform)

				arg_256_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_256_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_256_1:RecordName(arg_256_1.leftNameTxt_.text)
				SetActive(arg_256_1.iconTrs_.gameObject, false)
				arg_256_1.callingController_:SetSelectedState("normal")

				local var_259_14 = arg_256_1:GetWordFromCfg(325591062)
				local var_259_15 = arg_256_1:FormatText(var_259_14.content)

				arg_256_1.text_.text = var_259_15

				LuaForUtil.ClearLinePrefixSymbol(arg_256_1.text_)

				local var_259_16 = 31
				local var_259_17 = utf8.len(var_259_15)
				local var_259_18 = var_259_16 <= 0 and var_259_12 or var_259_12 * (var_259_17 / var_259_16)

				if var_259_18 > 0 and var_259_12 < var_259_18 then
					arg_256_1.talkMaxDuration = var_259_18

					if var_259_18 + var_259_11 > arg_256_1.duration_ then
						arg_256_1.duration_ = var_259_18 + var_259_11
					end
				end

				arg_256_1.text_.text = var_259_15
				arg_256_1.typewritter.percent = 0

				arg_256_1.typewritter:SetDirty()
				arg_256_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_325591", "325591062", "story_v_out_325591.awb") ~= 0 then
					local var_259_19 = manager.audio:GetVoiceLength("story_v_out_325591", "325591062", "story_v_out_325591.awb") / 1000

					if var_259_19 + var_259_11 > arg_256_1.duration_ then
						arg_256_1.duration_ = var_259_19 + var_259_11
					end

					if var_259_14.prefab_name ~= "" and arg_256_1.actors_[var_259_14.prefab_name] ~= nil then
						local var_259_20 = LuaForUtil.PlayVoiceWithCriLipsync(arg_256_1.actors_[var_259_14.prefab_name].transform, "story_v_out_325591", "325591062", "story_v_out_325591.awb")

						arg_256_1:RecordAudio("325591062", var_259_20)
						arg_256_1:RecordAudio("325591062", var_259_20)
					else
						arg_256_1:AudioAction("play", "voice", "story_v_out_325591", "325591062", "story_v_out_325591.awb")
					end

					arg_256_1:RecordHistoryTalkVoice("story_v_out_325591", "325591062", "story_v_out_325591.awb")
				end

				arg_256_1:RecordContent(arg_256_1.text_.text)
			end

			local var_259_21 = math.max(var_259_12, arg_256_1.talkMaxDuration)

			if var_259_11 <= arg_256_1.time_ and arg_256_1.time_ < var_259_11 + var_259_21 then
				arg_256_1.typewritter.percent = (arg_256_1.time_ - var_259_11) / var_259_21

				arg_256_1.typewritter:SetDirty()
			end

			if arg_256_1.time_ >= var_259_11 + var_259_21 and arg_256_1.time_ < var_259_11 + var_259_21 + arg_259_0 then
				arg_256_1.typewritter.percent = 1

				arg_256_1.typewritter:SetDirty()
				arg_256_1:ShowNextGo(true)
			end
		end

		arg_256_1.nodeConfigList_ = {}

		arg_256_1:InitPlayNodeList()
	end,
	Play325591063 = function(arg_260_0, arg_260_1)
		arg_260_1.time_ = 0
		arg_260_1.frameCnt_ = 0
		arg_260_1.state_ = "playing"
		arg_260_1.curTalkId_ = 325591063
		arg_260_1.duration_ = 5.13

		local var_260_0 = {
			zh = 3.9,
			ja = 5.133
		}
		local var_260_1 = manager.audio:GetLocalizationFlag()

		if var_260_0[var_260_1] ~= nil then
			arg_260_1.duration_ = var_260_0[var_260_1]
		end

		SetActive(arg_260_1.tipsGo_, false)

		function arg_260_1.onSingleLineFinish_()
			arg_260_1.onSingleLineUpdate_ = nil
			arg_260_1.onSingleLineFinish_ = nil
			arg_260_1.state_ = "waiting"
		end

		function arg_260_1.playNext_(arg_262_0)
			if arg_262_0 == 1 then
				arg_260_0:Play325591064(arg_260_1)
			end
		end

		function arg_260_1.onSingleLineUpdate_(arg_263_0)
			local var_263_0 = 0
			local var_263_1 = 0.35

			if var_263_0 < arg_260_1.time_ and arg_260_1.time_ <= var_263_0 + arg_263_0 then
				arg_260_1.talkMaxDuration = 0
				arg_260_1.dialogCg_.alpha = 1

				arg_260_1.dialog_:SetActive(true)
				SetActive(arg_260_1.leftNameGo_, true)

				local var_263_2 = arg_260_1:FormatText(StoryNameCfg[1510].name)

				arg_260_1.leftNameTxt_.text = var_263_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_260_1.leftNameTxt_.transform)

				arg_260_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_260_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_260_1:RecordName(arg_260_1.leftNameTxt_.text)
				SetActive(arg_260_1.iconTrs_.gameObject, false)
				arg_260_1.callingController_:SetSelectedState("normal")

				local var_263_3 = arg_260_1:GetWordFromCfg(325591063)
				local var_263_4 = arg_260_1:FormatText(var_263_3.content)

				arg_260_1.text_.text = var_263_4

				LuaForUtil.ClearLinePrefixSymbol(arg_260_1.text_)

				local var_263_5 = 14
				local var_263_6 = utf8.len(var_263_4)
				local var_263_7 = var_263_5 <= 0 and var_263_1 or var_263_1 * (var_263_6 / var_263_5)

				if var_263_7 > 0 and var_263_1 < var_263_7 then
					arg_260_1.talkMaxDuration = var_263_7

					if var_263_7 + var_263_0 > arg_260_1.duration_ then
						arg_260_1.duration_ = var_263_7 + var_263_0
					end
				end

				arg_260_1.text_.text = var_263_4
				arg_260_1.typewritter.percent = 0

				arg_260_1.typewritter:SetDirty()
				arg_260_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_325591", "325591063", "story_v_out_325591.awb") ~= 0 then
					local var_263_8 = manager.audio:GetVoiceLength("story_v_out_325591", "325591063", "story_v_out_325591.awb") / 1000

					if var_263_8 + var_263_0 > arg_260_1.duration_ then
						arg_260_1.duration_ = var_263_8 + var_263_0
					end

					if var_263_3.prefab_name ~= "" and arg_260_1.actors_[var_263_3.prefab_name] ~= nil then
						local var_263_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_260_1.actors_[var_263_3.prefab_name].transform, "story_v_out_325591", "325591063", "story_v_out_325591.awb")

						arg_260_1:RecordAudio("325591063", var_263_9)
						arg_260_1:RecordAudio("325591063", var_263_9)
					else
						arg_260_1:AudioAction("play", "voice", "story_v_out_325591", "325591063", "story_v_out_325591.awb")
					end

					arg_260_1:RecordHistoryTalkVoice("story_v_out_325591", "325591063", "story_v_out_325591.awb")
				end

				arg_260_1:RecordContent(arg_260_1.text_.text)
			end

			local var_263_10 = math.max(var_263_1, arg_260_1.talkMaxDuration)

			if var_263_0 <= arg_260_1.time_ and arg_260_1.time_ < var_263_0 + var_263_10 then
				arg_260_1.typewritter.percent = (arg_260_1.time_ - var_263_0) / var_263_10

				arg_260_1.typewritter:SetDirty()
			end

			if arg_260_1.time_ >= var_263_0 + var_263_10 and arg_260_1.time_ < var_263_0 + var_263_10 + arg_263_0 then
				arg_260_1.typewritter.percent = 1

				arg_260_1.typewritter:SetDirty()
				arg_260_1:ShowNextGo(true)
			end
		end

		arg_260_1.nodeConfigList_ = {}

		arg_260_1:InitPlayNodeList()
	end,
	Play325591064 = function(arg_264_0, arg_264_1)
		arg_264_1.time_ = 0
		arg_264_1.frameCnt_ = 0
		arg_264_1.state_ = "playing"
		arg_264_1.curTalkId_ = 325591064
		arg_264_1.duration_ = 8

		local var_264_0 = {
			zh = 5.866,
			ja = 8
		}
		local var_264_1 = manager.audio:GetLocalizationFlag()

		if var_264_0[var_264_1] ~= nil then
			arg_264_1.duration_ = var_264_0[var_264_1]
		end

		SetActive(arg_264_1.tipsGo_, false)

		function arg_264_1.onSingleLineFinish_()
			arg_264_1.onSingleLineUpdate_ = nil
			arg_264_1.onSingleLineFinish_ = nil
			arg_264_1.state_ = "waiting"
		end

		function arg_264_1.playNext_(arg_266_0)
			if arg_266_0 == 1 then
				arg_264_0:Play325591065(arg_264_1)
			end
		end

		function arg_264_1.onSingleLineUpdate_(arg_267_0)
			local var_267_0 = arg_264_1.actors_["6148ui_story"]
			local var_267_1 = 0

			if var_267_1 < arg_264_1.time_ and arg_264_1.time_ <= var_267_1 + arg_267_0 and not isNil(var_267_0) and arg_264_1.var_.characterEffect6148ui_story == nil then
				arg_264_1.var_.characterEffect6148ui_story = var_267_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_267_2 = 0.200000002980232

			if var_267_1 <= arg_264_1.time_ and arg_264_1.time_ < var_267_1 + var_267_2 and not isNil(var_267_0) then
				local var_267_3 = (arg_264_1.time_ - var_267_1) / var_267_2

				if arg_264_1.var_.characterEffect6148ui_story and not isNil(var_267_0) then
					arg_264_1.var_.characterEffect6148ui_story.fillFlat = false
				end
			end

			if arg_264_1.time_ >= var_267_1 + var_267_2 and arg_264_1.time_ < var_267_1 + var_267_2 + arg_267_0 and not isNil(var_267_0) and arg_264_1.var_.characterEffect6148ui_story then
				arg_264_1.var_.characterEffect6148ui_story.fillFlat = false
			end

			local var_267_4 = arg_264_1.actors_["10176ui_story"]
			local var_267_5 = 0

			if var_267_5 < arg_264_1.time_ and arg_264_1.time_ <= var_267_5 + arg_267_0 and not isNil(var_267_4) and arg_264_1.var_.characterEffect10176ui_story == nil then
				arg_264_1.var_.characterEffect10176ui_story = var_267_4:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_267_6 = 0.200000002980232

			if var_267_5 <= arg_264_1.time_ and arg_264_1.time_ < var_267_5 + var_267_6 and not isNil(var_267_4) then
				local var_267_7 = (arg_264_1.time_ - var_267_5) / var_267_6

				if arg_264_1.var_.characterEffect10176ui_story and not isNil(var_267_4) then
					local var_267_8 = Mathf.Lerp(0, 0.5, var_267_7)

					arg_264_1.var_.characterEffect10176ui_story.fillFlat = true
					arg_264_1.var_.characterEffect10176ui_story.fillRatio = var_267_8
				end
			end

			if arg_264_1.time_ >= var_267_5 + var_267_6 and arg_264_1.time_ < var_267_5 + var_267_6 + arg_267_0 and not isNil(var_267_4) and arg_264_1.var_.characterEffect10176ui_story then
				local var_267_9 = 0.5

				arg_264_1.var_.characterEffect10176ui_story.fillFlat = true
				arg_264_1.var_.characterEffect10176ui_story.fillRatio = var_267_9
			end

			local var_267_10 = 0

			if var_267_10 < arg_264_1.time_ and arg_264_1.time_ <= var_267_10 + arg_267_0 then
				arg_264_1:PlayTimeline("6148ui_story", "StoryTimeline/CharAction/story6148/story6148action/6148action4_1")
			end

			local var_267_11 = 0

			if var_267_11 < arg_264_1.time_ and arg_264_1.time_ <= var_267_11 + arg_267_0 then
				arg_264_1:PlayTimeline("6148ui_story", "StoryTimeline/CharAction/public_expression/expr_youyu", "EmotionTimelineAnimator")
			end

			local var_267_12 = 0
			local var_267_13 = 0.675

			if var_267_12 < arg_264_1.time_ and arg_264_1.time_ <= var_267_12 + arg_267_0 then
				arg_264_1.talkMaxDuration = 0
				arg_264_1.dialogCg_.alpha = 1

				arg_264_1.dialog_:SetActive(true)
				SetActive(arg_264_1.leftNameGo_, true)

				local var_267_14 = arg_264_1:FormatText(StoryNameCfg[1488].name)

				arg_264_1.leftNameTxt_.text = var_267_14

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_264_1.leftNameTxt_.transform)

				arg_264_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_264_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_264_1:RecordName(arg_264_1.leftNameTxt_.text)
				SetActive(arg_264_1.iconTrs_.gameObject, false)
				arg_264_1.callingController_:SetSelectedState("normal")

				local var_267_15 = arg_264_1:GetWordFromCfg(325591064)
				local var_267_16 = arg_264_1:FormatText(var_267_15.content)

				arg_264_1.text_.text = var_267_16

				LuaForUtil.ClearLinePrefixSymbol(arg_264_1.text_)

				local var_267_17 = 27
				local var_267_18 = utf8.len(var_267_16)
				local var_267_19 = var_267_17 <= 0 and var_267_13 or var_267_13 * (var_267_18 / var_267_17)

				if var_267_19 > 0 and var_267_13 < var_267_19 then
					arg_264_1.talkMaxDuration = var_267_19

					if var_267_19 + var_267_12 > arg_264_1.duration_ then
						arg_264_1.duration_ = var_267_19 + var_267_12
					end
				end

				arg_264_1.text_.text = var_267_16
				arg_264_1.typewritter.percent = 0

				arg_264_1.typewritter:SetDirty()
				arg_264_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_325591", "325591064", "story_v_out_325591.awb") ~= 0 then
					local var_267_20 = manager.audio:GetVoiceLength("story_v_out_325591", "325591064", "story_v_out_325591.awb") / 1000

					if var_267_20 + var_267_12 > arg_264_1.duration_ then
						arg_264_1.duration_ = var_267_20 + var_267_12
					end

					if var_267_15.prefab_name ~= "" and arg_264_1.actors_[var_267_15.prefab_name] ~= nil then
						local var_267_21 = LuaForUtil.PlayVoiceWithCriLipsync(arg_264_1.actors_[var_267_15.prefab_name].transform, "story_v_out_325591", "325591064", "story_v_out_325591.awb")

						arg_264_1:RecordAudio("325591064", var_267_21)
						arg_264_1:RecordAudio("325591064", var_267_21)
					else
						arg_264_1:AudioAction("play", "voice", "story_v_out_325591", "325591064", "story_v_out_325591.awb")
					end

					arg_264_1:RecordHistoryTalkVoice("story_v_out_325591", "325591064", "story_v_out_325591.awb")
				end

				arg_264_1:RecordContent(arg_264_1.text_.text)
			end

			local var_267_22 = math.max(var_267_13, arg_264_1.talkMaxDuration)

			if var_267_12 <= arg_264_1.time_ and arg_264_1.time_ < var_267_12 + var_267_22 then
				arg_264_1.typewritter.percent = (arg_264_1.time_ - var_267_12) / var_267_22

				arg_264_1.typewritter:SetDirty()
			end

			if arg_264_1.time_ >= var_267_12 + var_267_22 and arg_264_1.time_ < var_267_12 + var_267_22 + arg_267_0 then
				arg_264_1.typewritter.percent = 1

				arg_264_1.typewritter:SetDirty()
				arg_264_1:ShowNextGo(true)
			end
		end

		arg_264_1.nodeConfigList_ = {}

		arg_264_1:InitPlayNodeList()
	end,
	Play325591065 = function(arg_268_0, arg_268_1)
		arg_268_1.time_ = 0
		arg_268_1.frameCnt_ = 0
		arg_268_1.state_ = "playing"
		arg_268_1.curTalkId_ = 325591065
		arg_268_1.duration_ = 2.6

		local var_268_0 = {
			zh = 2.533,
			ja = 2.6
		}
		local var_268_1 = manager.audio:GetLocalizationFlag()

		if var_268_0[var_268_1] ~= nil then
			arg_268_1.duration_ = var_268_0[var_268_1]
		end

		SetActive(arg_268_1.tipsGo_, false)

		function arg_268_1.onSingleLineFinish_()
			arg_268_1.onSingleLineUpdate_ = nil
			arg_268_1.onSingleLineFinish_ = nil
			arg_268_1.state_ = "waiting"
		end

		function arg_268_1.playNext_(arg_270_0)
			if arg_270_0 == 1 then
				arg_268_0:Play325591066(arg_268_1)
			end
		end

		function arg_268_1.onSingleLineUpdate_(arg_271_0)
			local var_271_0 = 0

			if var_271_0 < arg_268_1.time_ and arg_268_1.time_ <= var_271_0 + arg_271_0 then
				arg_268_1:PlayTimeline("6148ui_story", "StoryTimeline/CharAction/story6148/story6148action/6148action4_2")
			end

			local var_271_1 = 0
			local var_271_2 = 0.25

			if var_271_1 < arg_268_1.time_ and arg_268_1.time_ <= var_271_1 + arg_271_0 then
				arg_268_1.talkMaxDuration = 0
				arg_268_1.dialogCg_.alpha = 1

				arg_268_1.dialog_:SetActive(true)
				SetActive(arg_268_1.leftNameGo_, true)

				local var_271_3 = arg_268_1:FormatText(StoryNameCfg[1488].name)

				arg_268_1.leftNameTxt_.text = var_271_3

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_268_1.leftNameTxt_.transform)

				arg_268_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_268_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_268_1:RecordName(arg_268_1.leftNameTxt_.text)
				SetActive(arg_268_1.iconTrs_.gameObject, false)
				arg_268_1.callingController_:SetSelectedState("normal")

				local var_271_4 = arg_268_1:GetWordFromCfg(325591065)
				local var_271_5 = arg_268_1:FormatText(var_271_4.content)

				arg_268_1.text_.text = var_271_5

				LuaForUtil.ClearLinePrefixSymbol(arg_268_1.text_)

				local var_271_6 = 10
				local var_271_7 = utf8.len(var_271_5)
				local var_271_8 = var_271_6 <= 0 and var_271_2 or var_271_2 * (var_271_7 / var_271_6)

				if var_271_8 > 0 and var_271_2 < var_271_8 then
					arg_268_1.talkMaxDuration = var_271_8

					if var_271_8 + var_271_1 > arg_268_1.duration_ then
						arg_268_1.duration_ = var_271_8 + var_271_1
					end
				end

				arg_268_1.text_.text = var_271_5
				arg_268_1.typewritter.percent = 0

				arg_268_1.typewritter:SetDirty()
				arg_268_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_325591", "325591065", "story_v_out_325591.awb") ~= 0 then
					local var_271_9 = manager.audio:GetVoiceLength("story_v_out_325591", "325591065", "story_v_out_325591.awb") / 1000

					if var_271_9 + var_271_1 > arg_268_1.duration_ then
						arg_268_1.duration_ = var_271_9 + var_271_1
					end

					if var_271_4.prefab_name ~= "" and arg_268_1.actors_[var_271_4.prefab_name] ~= nil then
						local var_271_10 = LuaForUtil.PlayVoiceWithCriLipsync(arg_268_1.actors_[var_271_4.prefab_name].transform, "story_v_out_325591", "325591065", "story_v_out_325591.awb")

						arg_268_1:RecordAudio("325591065", var_271_10)
						arg_268_1:RecordAudio("325591065", var_271_10)
					else
						arg_268_1:AudioAction("play", "voice", "story_v_out_325591", "325591065", "story_v_out_325591.awb")
					end

					arg_268_1:RecordHistoryTalkVoice("story_v_out_325591", "325591065", "story_v_out_325591.awb")
				end

				arg_268_1:RecordContent(arg_268_1.text_.text)
			end

			local var_271_11 = math.max(var_271_2, arg_268_1.talkMaxDuration)

			if var_271_1 <= arg_268_1.time_ and arg_268_1.time_ < var_271_1 + var_271_11 then
				arg_268_1.typewritter.percent = (arg_268_1.time_ - var_271_1) / var_271_11

				arg_268_1.typewritter:SetDirty()
			end

			if arg_268_1.time_ >= var_271_1 + var_271_11 and arg_268_1.time_ < var_271_1 + var_271_11 + arg_271_0 then
				arg_268_1.typewritter.percent = 1

				arg_268_1.typewritter:SetDirty()
				arg_268_1:ShowNextGo(true)
			end
		end

		arg_268_1.nodeConfigList_ = {}

		arg_268_1:InitPlayNodeList()
	end,
	Play325591066 = function(arg_272_0, arg_272_1)
		arg_272_1.time_ = 0
		arg_272_1.frameCnt_ = 0
		arg_272_1.state_ = "playing"
		arg_272_1.curTalkId_ = 325591066
		arg_272_1.duration_ = 12.83

		local var_272_0 = {
			zh = 10.633,
			ja = 12.833
		}
		local var_272_1 = manager.audio:GetLocalizationFlag()

		if var_272_0[var_272_1] ~= nil then
			arg_272_1.duration_ = var_272_0[var_272_1]
		end

		SetActive(arg_272_1.tipsGo_, false)

		function arg_272_1.onSingleLineFinish_()
			arg_272_1.onSingleLineUpdate_ = nil
			arg_272_1.onSingleLineFinish_ = nil
			arg_272_1.state_ = "waiting"
		end

		function arg_272_1.playNext_(arg_274_0)
			if arg_274_0 == 1 then
				arg_272_0:Play325591067(arg_272_1)
			end
		end

		function arg_272_1.onSingleLineUpdate_(arg_275_0)
			local var_275_0 = arg_272_1.actors_["6148ui_story"].transform
			local var_275_1 = 0

			if var_275_1 < arg_272_1.time_ and arg_272_1.time_ <= var_275_1 + arg_275_0 then
				arg_272_1.var_.moveOldPos6148ui_story = var_275_0.localPosition

				local var_275_2 = GameObjectTools.GetOrAddComponent(var_275_0.gameObject, typeof(DynamicBoneHelper))

				if var_275_2 then
					var_275_2:EnableDynamicBone(false)
				end
			end

			local var_275_3 = 0.001

			if var_275_1 <= arg_272_1.time_ and arg_272_1.time_ < var_275_1 + var_275_3 then
				local var_275_4 = (arg_272_1.time_ - var_275_1) / var_275_3
				local var_275_5 = Vector3.New(0, 100, 0)

				var_275_0.localPosition = Vector3.Lerp(arg_272_1.var_.moveOldPos6148ui_story, var_275_5, var_275_4)

				local var_275_6 = manager.ui.mainCamera.transform.position - var_275_0.position

				var_275_0.forward = Vector3.New(var_275_6.x, var_275_6.y, var_275_6.z)

				local var_275_7 = var_275_0.localEulerAngles

				var_275_7.z = 0
				var_275_7.x = 0
				var_275_0.localEulerAngles = var_275_7
			end

			if arg_272_1.time_ >= var_275_1 + var_275_3 and arg_272_1.time_ < var_275_1 + var_275_3 + arg_275_0 then
				var_275_0.localPosition = Vector3.New(0, 100, 0)

				local var_275_8 = manager.ui.mainCamera.transform.position - var_275_0.position

				var_275_0.forward = Vector3.New(var_275_8.x, var_275_8.y, var_275_8.z)

				local var_275_9 = var_275_0.localEulerAngles

				var_275_9.z = 0
				var_275_9.x = 0
				var_275_0.localEulerAngles = var_275_9

				local var_275_10 = GameObjectTools.GetOrAddComponent(var_275_0.gameObject, typeof(DynamicBoneHelper))

				if var_275_10 then
					var_275_10:EnableDynamicBone(true)
				end
			end

			local var_275_11 = arg_272_1.actors_["1054ui_story"].transform
			local var_275_12 = 0

			if var_275_12 < arg_272_1.time_ and arg_272_1.time_ <= var_275_12 + arg_275_0 then
				arg_272_1.var_.moveOldPos1054ui_story = var_275_11.localPosition

				local var_275_13 = GameObjectTools.GetOrAddComponent(var_275_11.gameObject, typeof(DynamicBoneHelper))

				if var_275_13 then
					var_275_13:EnableDynamicBone(false)
				end
			end

			local var_275_14 = 0.001

			if var_275_12 <= arg_272_1.time_ and arg_272_1.time_ < var_275_12 + var_275_14 then
				local var_275_15 = (arg_272_1.time_ - var_275_12) / var_275_14
				local var_275_16 = Vector3.New(0.7, -0.985, -6)

				var_275_11.localPosition = Vector3.Lerp(arg_272_1.var_.moveOldPos1054ui_story, var_275_16, var_275_15)

				local var_275_17 = manager.ui.mainCamera.transform.position - var_275_11.position

				var_275_11.forward = Vector3.New(var_275_17.x, var_275_17.y, var_275_17.z)

				local var_275_18 = var_275_11.localEulerAngles

				var_275_18.z = 0
				var_275_18.x = 0
				var_275_11.localEulerAngles = var_275_18
			end

			if arg_272_1.time_ >= var_275_12 + var_275_14 and arg_272_1.time_ < var_275_12 + var_275_14 + arg_275_0 then
				var_275_11.localPosition = Vector3.New(0.7, -0.985, -6)

				local var_275_19 = manager.ui.mainCamera.transform.position - var_275_11.position

				var_275_11.forward = Vector3.New(var_275_19.x, var_275_19.y, var_275_19.z)

				local var_275_20 = var_275_11.localEulerAngles

				var_275_20.z = 0
				var_275_20.x = 0
				var_275_11.localEulerAngles = var_275_20

				local var_275_21 = GameObjectTools.GetOrAddComponent(var_275_11.gameObject, typeof(DynamicBoneHelper))

				if var_275_21 then
					var_275_21:EnableDynamicBone(true)
				end
			end

			local var_275_22 = arg_272_1.actors_["1054ui_story"]
			local var_275_23 = 0

			if var_275_23 < arg_272_1.time_ and arg_272_1.time_ <= var_275_23 + arg_275_0 and not isNil(var_275_22) and arg_272_1.var_.characterEffect1054ui_story == nil then
				arg_272_1.var_.characterEffect1054ui_story = var_275_22:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_275_24 = 0.200000002980232

			if var_275_23 <= arg_272_1.time_ and arg_272_1.time_ < var_275_23 + var_275_24 and not isNil(var_275_22) then
				local var_275_25 = (arg_272_1.time_ - var_275_23) / var_275_24

				if arg_272_1.var_.characterEffect1054ui_story and not isNil(var_275_22) then
					arg_272_1.var_.characterEffect1054ui_story.fillFlat = false
				end
			end

			if arg_272_1.time_ >= var_275_23 + var_275_24 and arg_272_1.time_ < var_275_23 + var_275_24 + arg_275_0 and not isNil(var_275_22) and arg_272_1.var_.characterEffect1054ui_story then
				arg_272_1.var_.characterEffect1054ui_story.fillFlat = false
			end

			local var_275_26 = arg_272_1.actors_["6148ui_story"]
			local var_275_27 = 0

			if var_275_27 < arg_272_1.time_ and arg_272_1.time_ <= var_275_27 + arg_275_0 and not isNil(var_275_26) and arg_272_1.var_.characterEffect6148ui_story == nil then
				arg_272_1.var_.characterEffect6148ui_story = var_275_26:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_275_28 = 0.200000002980232

			if var_275_27 <= arg_272_1.time_ and arg_272_1.time_ < var_275_27 + var_275_28 and not isNil(var_275_26) then
				local var_275_29 = (arg_272_1.time_ - var_275_27) / var_275_28

				if arg_272_1.var_.characterEffect6148ui_story and not isNil(var_275_26) then
					local var_275_30 = Mathf.Lerp(0, 0.5, var_275_29)

					arg_272_1.var_.characterEffect6148ui_story.fillFlat = true
					arg_272_1.var_.characterEffect6148ui_story.fillRatio = var_275_30
				end
			end

			if arg_272_1.time_ >= var_275_27 + var_275_28 and arg_272_1.time_ < var_275_27 + var_275_28 + arg_275_0 and not isNil(var_275_26) and arg_272_1.var_.characterEffect6148ui_story then
				local var_275_31 = 0.5

				arg_272_1.var_.characterEffect6148ui_story.fillFlat = true
				arg_272_1.var_.characterEffect6148ui_story.fillRatio = var_275_31
			end

			local var_275_32 = 0

			if var_275_32 < arg_272_1.time_ and arg_272_1.time_ <= var_275_32 + arg_275_0 then
				arg_272_1:PlayTimeline("1054ui_story", "StoryTimeline/CharAction/story1054/story1054action/1054action1_1")
			end

			local var_275_33 = 0

			if var_275_33 < arg_272_1.time_ and arg_272_1.time_ <= var_275_33 + arg_275_0 then
				arg_272_1:PlayTimeline("1054ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0101cva", "EmotionTimelineAnimator")
			end

			local var_275_34 = 0
			local var_275_35 = 0.9

			if var_275_34 < arg_272_1.time_ and arg_272_1.time_ <= var_275_34 + arg_275_0 then
				arg_272_1.talkMaxDuration = 0
				arg_272_1.dialogCg_.alpha = 1

				arg_272_1.dialog_:SetActive(true)
				SetActive(arg_272_1.leftNameGo_, true)

				local var_275_36 = arg_272_1:FormatText(StoryNameCfg[1487].name)

				arg_272_1.leftNameTxt_.text = var_275_36

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_272_1.leftNameTxt_.transform)

				arg_272_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_272_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_272_1:RecordName(arg_272_1.leftNameTxt_.text)
				SetActive(arg_272_1.iconTrs_.gameObject, false)
				arg_272_1.callingController_:SetSelectedState("normal")

				local var_275_37 = arg_272_1:GetWordFromCfg(325591066)
				local var_275_38 = arg_272_1:FormatText(var_275_37.content)

				arg_272_1.text_.text = var_275_38

				LuaForUtil.ClearLinePrefixSymbol(arg_272_1.text_)

				local var_275_39 = 36
				local var_275_40 = utf8.len(var_275_38)
				local var_275_41 = var_275_39 <= 0 and var_275_35 or var_275_35 * (var_275_40 / var_275_39)

				if var_275_41 > 0 and var_275_35 < var_275_41 then
					arg_272_1.talkMaxDuration = var_275_41

					if var_275_41 + var_275_34 > arg_272_1.duration_ then
						arg_272_1.duration_ = var_275_41 + var_275_34
					end
				end

				arg_272_1.text_.text = var_275_38
				arg_272_1.typewritter.percent = 0

				arg_272_1.typewritter:SetDirty()
				arg_272_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_325591", "325591066", "story_v_out_325591.awb") ~= 0 then
					local var_275_42 = manager.audio:GetVoiceLength("story_v_out_325591", "325591066", "story_v_out_325591.awb") / 1000

					if var_275_42 + var_275_34 > arg_272_1.duration_ then
						arg_272_1.duration_ = var_275_42 + var_275_34
					end

					if var_275_37.prefab_name ~= "" and arg_272_1.actors_[var_275_37.prefab_name] ~= nil then
						local var_275_43 = LuaForUtil.PlayVoiceWithCriLipsync(arg_272_1.actors_[var_275_37.prefab_name].transform, "story_v_out_325591", "325591066", "story_v_out_325591.awb")

						arg_272_1:RecordAudio("325591066", var_275_43)
						arg_272_1:RecordAudio("325591066", var_275_43)
					else
						arg_272_1:AudioAction("play", "voice", "story_v_out_325591", "325591066", "story_v_out_325591.awb")
					end

					arg_272_1:RecordHistoryTalkVoice("story_v_out_325591", "325591066", "story_v_out_325591.awb")
				end

				arg_272_1:RecordContent(arg_272_1.text_.text)
			end

			local var_275_44 = math.max(var_275_35, arg_272_1.talkMaxDuration)

			if var_275_34 <= arg_272_1.time_ and arg_272_1.time_ < var_275_34 + var_275_44 then
				arg_272_1.typewritter.percent = (arg_272_1.time_ - var_275_34) / var_275_44

				arg_272_1.typewritter:SetDirty()
			end

			if arg_272_1.time_ >= var_275_34 + var_275_44 and arg_272_1.time_ < var_275_34 + var_275_44 + arg_275_0 then
				arg_272_1.typewritter.percent = 1

				arg_272_1.typewritter:SetDirty()
				arg_272_1:ShowNextGo(true)
			end
		end

		arg_272_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "6148ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1054ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_272_1:InitPlayNodeList()
	end,
	Play325591067 = function(arg_276_0, arg_276_1)
		arg_276_1.time_ = 0
		arg_276_1.frameCnt_ = 0
		arg_276_1.state_ = "playing"
		arg_276_1.curTalkId_ = 325591067
		arg_276_1.duration_ = 5

		SetActive(arg_276_1.tipsGo_, false)

		function arg_276_1.onSingleLineFinish_()
			arg_276_1.onSingleLineUpdate_ = nil
			arg_276_1.onSingleLineFinish_ = nil
			arg_276_1.state_ = "waiting"
		end

		function arg_276_1.playNext_(arg_278_0)
			if arg_278_0 == 1 then
				arg_276_0:Play325591068(arg_276_1)
			end
		end

		function arg_276_1.onSingleLineUpdate_(arg_279_0)
			local var_279_0 = arg_276_1.actors_["1054ui_story"].transform
			local var_279_1 = 0

			if var_279_1 < arg_276_1.time_ and arg_276_1.time_ <= var_279_1 + arg_279_0 then
				arg_276_1.var_.moveOldPos1054ui_story = var_279_0.localPosition

				local var_279_2 = GameObjectTools.GetOrAddComponent(var_279_0.gameObject, typeof(DynamicBoneHelper))

				if var_279_2 then
					var_279_2:EnableDynamicBone(false)
				end
			end

			local var_279_3 = 0.001

			if var_279_1 <= arg_276_1.time_ and arg_276_1.time_ < var_279_1 + var_279_3 then
				local var_279_4 = (arg_276_1.time_ - var_279_1) / var_279_3
				local var_279_5 = Vector3.New(0, 100, 0)

				var_279_0.localPosition = Vector3.Lerp(arg_276_1.var_.moveOldPos1054ui_story, var_279_5, var_279_4)

				local var_279_6 = manager.ui.mainCamera.transform.position - var_279_0.position

				var_279_0.forward = Vector3.New(var_279_6.x, var_279_6.y, var_279_6.z)

				local var_279_7 = var_279_0.localEulerAngles

				var_279_7.z = 0
				var_279_7.x = 0
				var_279_0.localEulerAngles = var_279_7
			end

			if arg_276_1.time_ >= var_279_1 + var_279_3 and arg_276_1.time_ < var_279_1 + var_279_3 + arg_279_0 then
				var_279_0.localPosition = Vector3.New(0, 100, 0)

				local var_279_8 = manager.ui.mainCamera.transform.position - var_279_0.position

				var_279_0.forward = Vector3.New(var_279_8.x, var_279_8.y, var_279_8.z)

				local var_279_9 = var_279_0.localEulerAngles

				var_279_9.z = 0
				var_279_9.x = 0
				var_279_0.localEulerAngles = var_279_9

				local var_279_10 = GameObjectTools.GetOrAddComponent(var_279_0.gameObject, typeof(DynamicBoneHelper))

				if var_279_10 then
					var_279_10:EnableDynamicBone(true)
				end
			end

			local var_279_11 = arg_276_1.actors_["10176ui_story"].transform
			local var_279_12 = 0

			if var_279_12 < arg_276_1.time_ and arg_276_1.time_ <= var_279_12 + arg_279_0 then
				arg_276_1.var_.moveOldPos10176ui_story = var_279_11.localPosition

				local var_279_13 = GameObjectTools.GetOrAddComponent(var_279_11.gameObject, typeof(DynamicBoneHelper))

				if var_279_13 then
					var_279_13:EnableDynamicBone(false)
				end
			end

			local var_279_14 = 0.001

			if var_279_12 <= arg_276_1.time_ and arg_276_1.time_ < var_279_12 + var_279_14 then
				local var_279_15 = (arg_276_1.time_ - var_279_12) / var_279_14
				local var_279_16 = Vector3.New(0, 100, 0)

				var_279_11.localPosition = Vector3.Lerp(arg_276_1.var_.moveOldPos10176ui_story, var_279_16, var_279_15)

				local var_279_17 = manager.ui.mainCamera.transform.position - var_279_11.position

				var_279_11.forward = Vector3.New(var_279_17.x, var_279_17.y, var_279_17.z)

				local var_279_18 = var_279_11.localEulerAngles

				var_279_18.z = 0
				var_279_18.x = 0
				var_279_11.localEulerAngles = var_279_18
			end

			if arg_276_1.time_ >= var_279_12 + var_279_14 and arg_276_1.time_ < var_279_12 + var_279_14 + arg_279_0 then
				var_279_11.localPosition = Vector3.New(0, 100, 0)

				local var_279_19 = manager.ui.mainCamera.transform.position - var_279_11.position

				var_279_11.forward = Vector3.New(var_279_19.x, var_279_19.y, var_279_19.z)

				local var_279_20 = var_279_11.localEulerAngles

				var_279_20.z = 0
				var_279_20.x = 0
				var_279_11.localEulerAngles = var_279_20

				local var_279_21 = GameObjectTools.GetOrAddComponent(var_279_11.gameObject, typeof(DynamicBoneHelper))

				if var_279_21 then
					var_279_21:EnableDynamicBone(true)
				end
			end

			local var_279_22 = arg_276_1.actors_["1054ui_story"]
			local var_279_23 = 0

			if var_279_23 < arg_276_1.time_ and arg_276_1.time_ <= var_279_23 + arg_279_0 and not isNil(var_279_22) and arg_276_1.var_.characterEffect1054ui_story == nil then
				arg_276_1.var_.characterEffect1054ui_story = var_279_22:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_279_24 = 0.200000002980232

			if var_279_23 <= arg_276_1.time_ and arg_276_1.time_ < var_279_23 + var_279_24 and not isNil(var_279_22) then
				local var_279_25 = (arg_276_1.time_ - var_279_23) / var_279_24

				if arg_276_1.var_.characterEffect1054ui_story and not isNil(var_279_22) then
					local var_279_26 = Mathf.Lerp(0, 0.5, var_279_25)

					arg_276_1.var_.characterEffect1054ui_story.fillFlat = true
					arg_276_1.var_.characterEffect1054ui_story.fillRatio = var_279_26
				end
			end

			if arg_276_1.time_ >= var_279_23 + var_279_24 and arg_276_1.time_ < var_279_23 + var_279_24 + arg_279_0 and not isNil(var_279_22) and arg_276_1.var_.characterEffect1054ui_story then
				local var_279_27 = 0.5

				arg_276_1.var_.characterEffect1054ui_story.fillFlat = true
				arg_276_1.var_.characterEffect1054ui_story.fillRatio = var_279_27
			end

			local var_279_28 = 0
			local var_279_29 = 0.925

			if var_279_28 < arg_276_1.time_ and arg_276_1.time_ <= var_279_28 + arg_279_0 then
				arg_276_1.talkMaxDuration = 0
				arg_276_1.dialogCg_.alpha = 1

				arg_276_1.dialog_:SetActive(true)
				SetActive(arg_276_1.leftNameGo_, false)

				arg_276_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_276_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_276_1:RecordName(arg_276_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_276_1.iconTrs_.gameObject, false)
				arg_276_1.callingController_:SetSelectedState("normal")

				local var_279_30 = arg_276_1:GetWordFromCfg(325591067)
				local var_279_31 = arg_276_1:FormatText(var_279_30.content)

				arg_276_1.text_.text = var_279_31

				LuaForUtil.ClearLinePrefixSymbol(arg_276_1.text_)

				local var_279_32 = 37
				local var_279_33 = utf8.len(var_279_31)
				local var_279_34 = var_279_32 <= 0 and var_279_29 or var_279_29 * (var_279_33 / var_279_32)

				if var_279_34 > 0 and var_279_29 < var_279_34 then
					arg_276_1.talkMaxDuration = var_279_34

					if var_279_34 + var_279_28 > arg_276_1.duration_ then
						arg_276_1.duration_ = var_279_34 + var_279_28
					end
				end

				arg_276_1.text_.text = var_279_31
				arg_276_1.typewritter.percent = 0

				arg_276_1.typewritter:SetDirty()
				arg_276_1:ShowNextGo(false)
				arg_276_1:RecordContent(arg_276_1.text_.text)
			end

			local var_279_35 = math.max(var_279_29, arg_276_1.talkMaxDuration)

			if var_279_28 <= arg_276_1.time_ and arg_276_1.time_ < var_279_28 + var_279_35 then
				arg_276_1.typewritter.percent = (arg_276_1.time_ - var_279_28) / var_279_35

				arg_276_1.typewritter:SetDirty()
			end

			if arg_276_1.time_ >= var_279_28 + var_279_35 and arg_276_1.time_ < var_279_28 + var_279_35 + arg_279_0 then
				arg_276_1.typewritter.percent = 1

				arg_276_1.typewritter:SetDirty()
				arg_276_1:ShowNextGo(true)
			end
		end

		arg_276_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1054ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "10176ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_276_1:InitPlayNodeList()
	end,
	Play325591068 = function(arg_280_0, arg_280_1)
		arg_280_1.time_ = 0
		arg_280_1.frameCnt_ = 0
		arg_280_1.state_ = "playing"
		arg_280_1.curTalkId_ = 325591068
		arg_280_1.duration_ = 11.5

		local var_280_0 = {
			zh = 10.1,
			ja = 11.5
		}
		local var_280_1 = manager.audio:GetLocalizationFlag()

		if var_280_0[var_280_1] ~= nil then
			arg_280_1.duration_ = var_280_0[var_280_1]
		end

		SetActive(arg_280_1.tipsGo_, false)

		function arg_280_1.onSingleLineFinish_()
			arg_280_1.onSingleLineUpdate_ = nil
			arg_280_1.onSingleLineFinish_ = nil
			arg_280_1.state_ = "waiting"
		end

		function arg_280_1.playNext_(arg_282_0)
			if arg_282_0 == 1 then
				arg_280_0:Play325591069(arg_280_1)
			end
		end

		function arg_280_1.onSingleLineUpdate_(arg_283_0)
			local var_283_0 = arg_280_1.actors_["10176ui_story"].transform
			local var_283_1 = 0

			if var_283_1 < arg_280_1.time_ and arg_280_1.time_ <= var_283_1 + arg_283_0 then
				arg_280_1.var_.moveOldPos10176ui_story = var_283_0.localPosition

				local var_283_2 = GameObjectTools.GetOrAddComponent(var_283_0.gameObject, typeof(DynamicBoneHelper))

				if var_283_2 then
					var_283_2:EnableDynamicBone(false)
				end
			end

			local var_283_3 = 0.001

			if var_283_1 <= arg_280_1.time_ and arg_280_1.time_ < var_283_1 + var_283_3 then
				local var_283_4 = (arg_280_1.time_ - var_283_1) / var_283_3
				local var_283_5 = Vector3.New(-0.02, -1.09, -6.12)

				var_283_0.localPosition = Vector3.Lerp(arg_280_1.var_.moveOldPos10176ui_story, var_283_5, var_283_4)

				local var_283_6 = manager.ui.mainCamera.transform.position - var_283_0.position

				var_283_0.forward = Vector3.New(var_283_6.x, var_283_6.y, var_283_6.z)

				local var_283_7 = var_283_0.localEulerAngles

				var_283_7.z = 0
				var_283_7.x = 0
				var_283_0.localEulerAngles = var_283_7
			end

			if arg_280_1.time_ >= var_283_1 + var_283_3 and arg_280_1.time_ < var_283_1 + var_283_3 + arg_283_0 then
				var_283_0.localPosition = Vector3.New(-0.02, -1.09, -6.12)

				local var_283_8 = manager.ui.mainCamera.transform.position - var_283_0.position

				var_283_0.forward = Vector3.New(var_283_8.x, var_283_8.y, var_283_8.z)

				local var_283_9 = var_283_0.localEulerAngles

				var_283_9.z = 0
				var_283_9.x = 0
				var_283_0.localEulerAngles = var_283_9

				local var_283_10 = GameObjectTools.GetOrAddComponent(var_283_0.gameObject, typeof(DynamicBoneHelper))

				if var_283_10 then
					var_283_10:EnableDynamicBone(true)
				end
			end

			local var_283_11 = arg_280_1.actors_["10176ui_story"]
			local var_283_12 = 0

			if var_283_12 < arg_280_1.time_ and arg_280_1.time_ <= var_283_12 + arg_283_0 and not isNil(var_283_11) and arg_280_1.var_.characterEffect10176ui_story == nil then
				arg_280_1.var_.characterEffect10176ui_story = var_283_11:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_283_13 = 0.200000002980232

			if var_283_12 <= arg_280_1.time_ and arg_280_1.time_ < var_283_12 + var_283_13 and not isNil(var_283_11) then
				local var_283_14 = (arg_280_1.time_ - var_283_12) / var_283_13

				if arg_280_1.var_.characterEffect10176ui_story and not isNil(var_283_11) then
					arg_280_1.var_.characterEffect10176ui_story.fillFlat = false
				end
			end

			if arg_280_1.time_ >= var_283_12 + var_283_13 and arg_280_1.time_ < var_283_12 + var_283_13 + arg_283_0 and not isNil(var_283_11) and arg_280_1.var_.characterEffect10176ui_story then
				arg_280_1.var_.characterEffect10176ui_story.fillFlat = false
			end

			local var_283_15 = 0

			if var_283_15 < arg_280_1.time_ and arg_280_1.time_ <= var_283_15 + arg_283_0 then
				arg_280_1:PlayTimeline("10176ui_story", "StoryTimeline/CharAction/story10176/story10176action/10176action1_1")
			end

			local var_283_16 = 0

			if var_283_16 < arg_280_1.time_ and arg_280_1.time_ <= var_283_16 + arg_283_0 then
				arg_280_1:PlayTimeline("10176ui_story", "StoryTimeline/CharAction/public_expression/expr_shengqiA", "EmotionTimelineAnimator")
			end

			local var_283_17 = 0
			local var_283_18 = 0.925

			if var_283_17 < arg_280_1.time_ and arg_280_1.time_ <= var_283_17 + arg_283_0 then
				arg_280_1.talkMaxDuration = 0
				arg_280_1.dialogCg_.alpha = 1

				arg_280_1.dialog_:SetActive(true)
				SetActive(arg_280_1.leftNameGo_, true)

				local var_283_19 = arg_280_1:FormatText(StoryNameCfg[1510].name)

				arg_280_1.leftNameTxt_.text = var_283_19

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_280_1.leftNameTxt_.transform)

				arg_280_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_280_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_280_1:RecordName(arg_280_1.leftNameTxt_.text)
				SetActive(arg_280_1.iconTrs_.gameObject, false)
				arg_280_1.callingController_:SetSelectedState("normal")

				local var_283_20 = arg_280_1:GetWordFromCfg(325591068)
				local var_283_21 = arg_280_1:FormatText(var_283_20.content)

				arg_280_1.text_.text = var_283_21

				LuaForUtil.ClearLinePrefixSymbol(arg_280_1.text_)

				local var_283_22 = 37
				local var_283_23 = utf8.len(var_283_21)
				local var_283_24 = var_283_22 <= 0 and var_283_18 or var_283_18 * (var_283_23 / var_283_22)

				if var_283_24 > 0 and var_283_18 < var_283_24 then
					arg_280_1.talkMaxDuration = var_283_24

					if var_283_24 + var_283_17 > arg_280_1.duration_ then
						arg_280_1.duration_ = var_283_24 + var_283_17
					end
				end

				arg_280_1.text_.text = var_283_21
				arg_280_1.typewritter.percent = 0

				arg_280_1.typewritter:SetDirty()
				arg_280_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_325591", "325591068", "story_v_out_325591.awb") ~= 0 then
					local var_283_25 = manager.audio:GetVoiceLength("story_v_out_325591", "325591068", "story_v_out_325591.awb") / 1000

					if var_283_25 + var_283_17 > arg_280_1.duration_ then
						arg_280_1.duration_ = var_283_25 + var_283_17
					end

					if var_283_20.prefab_name ~= "" and arg_280_1.actors_[var_283_20.prefab_name] ~= nil then
						local var_283_26 = LuaForUtil.PlayVoiceWithCriLipsync(arg_280_1.actors_[var_283_20.prefab_name].transform, "story_v_out_325591", "325591068", "story_v_out_325591.awb")

						arg_280_1:RecordAudio("325591068", var_283_26)
						arg_280_1:RecordAudio("325591068", var_283_26)
					else
						arg_280_1:AudioAction("play", "voice", "story_v_out_325591", "325591068", "story_v_out_325591.awb")
					end

					arg_280_1:RecordHistoryTalkVoice("story_v_out_325591", "325591068", "story_v_out_325591.awb")
				end

				arg_280_1:RecordContent(arg_280_1.text_.text)
			end

			local var_283_27 = math.max(var_283_18, arg_280_1.talkMaxDuration)

			if var_283_17 <= arg_280_1.time_ and arg_280_1.time_ < var_283_17 + var_283_27 then
				arg_280_1.typewritter.percent = (arg_280_1.time_ - var_283_17) / var_283_27

				arg_280_1.typewritter:SetDirty()
			end

			if arg_280_1.time_ >= var_283_17 + var_283_27 and arg_280_1.time_ < var_283_17 + var_283_27 + arg_283_0 then
				arg_280_1.typewritter.percent = 1

				arg_280_1.typewritter:SetDirty()
				arg_280_1:ShowNextGo(true)
			end
		end

		arg_280_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10176ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_280_1:InitPlayNodeList()
	end,
	Play325591069 = function(arg_284_0, arg_284_1)
		arg_284_1.time_ = 0
		arg_284_1.frameCnt_ = 0
		arg_284_1.state_ = "playing"
		arg_284_1.curTalkId_ = 325591069
		arg_284_1.duration_ = 6.33

		local var_284_0 = {
			zh = 6.266,
			ja = 6.333
		}
		local var_284_1 = manager.audio:GetLocalizationFlag()

		if var_284_0[var_284_1] ~= nil then
			arg_284_1.duration_ = var_284_0[var_284_1]
		end

		SetActive(arg_284_1.tipsGo_, false)

		function arg_284_1.onSingleLineFinish_()
			arg_284_1.onSingleLineUpdate_ = nil
			arg_284_1.onSingleLineFinish_ = nil
			arg_284_1.state_ = "waiting"
		end

		function arg_284_1.playNext_(arg_286_0)
			if arg_286_0 == 1 then
				arg_284_0:Play325591070(arg_284_1)
			end
		end

		function arg_284_1.onSingleLineUpdate_(arg_287_0)
			local var_287_0 = 0
			local var_287_1 = 0.5

			if var_287_0 < arg_284_1.time_ and arg_284_1.time_ <= var_287_0 + arg_287_0 then
				arg_284_1.talkMaxDuration = 0
				arg_284_1.dialogCg_.alpha = 1

				arg_284_1.dialog_:SetActive(true)
				SetActive(arg_284_1.leftNameGo_, true)

				local var_287_2 = arg_284_1:FormatText(StoryNameCfg[1510].name)

				arg_284_1.leftNameTxt_.text = var_287_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_284_1.leftNameTxt_.transform)

				arg_284_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_284_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_284_1:RecordName(arg_284_1.leftNameTxt_.text)
				SetActive(arg_284_1.iconTrs_.gameObject, false)
				arg_284_1.callingController_:SetSelectedState("normal")

				local var_287_3 = arg_284_1:GetWordFromCfg(325591069)
				local var_287_4 = arg_284_1:FormatText(var_287_3.content)

				arg_284_1.text_.text = var_287_4

				LuaForUtil.ClearLinePrefixSymbol(arg_284_1.text_)

				local var_287_5 = 20
				local var_287_6 = utf8.len(var_287_4)
				local var_287_7 = var_287_5 <= 0 and var_287_1 or var_287_1 * (var_287_6 / var_287_5)

				if var_287_7 > 0 and var_287_1 < var_287_7 then
					arg_284_1.talkMaxDuration = var_287_7

					if var_287_7 + var_287_0 > arg_284_1.duration_ then
						arg_284_1.duration_ = var_287_7 + var_287_0
					end
				end

				arg_284_1.text_.text = var_287_4
				arg_284_1.typewritter.percent = 0

				arg_284_1.typewritter:SetDirty()
				arg_284_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_325591", "325591069", "story_v_out_325591.awb") ~= 0 then
					local var_287_8 = manager.audio:GetVoiceLength("story_v_out_325591", "325591069", "story_v_out_325591.awb") / 1000

					if var_287_8 + var_287_0 > arg_284_1.duration_ then
						arg_284_1.duration_ = var_287_8 + var_287_0
					end

					if var_287_3.prefab_name ~= "" and arg_284_1.actors_[var_287_3.prefab_name] ~= nil then
						local var_287_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_284_1.actors_[var_287_3.prefab_name].transform, "story_v_out_325591", "325591069", "story_v_out_325591.awb")

						arg_284_1:RecordAudio("325591069", var_287_9)
						arg_284_1:RecordAudio("325591069", var_287_9)
					else
						arg_284_1:AudioAction("play", "voice", "story_v_out_325591", "325591069", "story_v_out_325591.awb")
					end

					arg_284_1:RecordHistoryTalkVoice("story_v_out_325591", "325591069", "story_v_out_325591.awb")
				end

				arg_284_1:RecordContent(arg_284_1.text_.text)
			end

			local var_287_10 = math.max(var_287_1, arg_284_1.talkMaxDuration)

			if var_287_0 <= arg_284_1.time_ and arg_284_1.time_ < var_287_0 + var_287_10 then
				arg_284_1.typewritter.percent = (arg_284_1.time_ - var_287_0) / var_287_10

				arg_284_1.typewritter:SetDirty()
			end

			if arg_284_1.time_ >= var_287_0 + var_287_10 and arg_284_1.time_ < var_287_0 + var_287_10 + arg_287_0 then
				arg_284_1.typewritter.percent = 1

				arg_284_1.typewritter:SetDirty()
				arg_284_1:ShowNextGo(true)
			end
		end

		arg_284_1.nodeConfigList_ = {}

		arg_284_1:InitPlayNodeList()
	end,
	Play325591070 = function(arg_288_0, arg_288_1)
		arg_288_1.time_ = 0
		arg_288_1.frameCnt_ = 0
		arg_288_1.state_ = "playing"
		arg_288_1.curTalkId_ = 325591070
		arg_288_1.duration_ = 2.27

		local var_288_0 = {
			zh = 2.266,
			ja = 1.066
		}
		local var_288_1 = manager.audio:GetLocalizationFlag()

		if var_288_0[var_288_1] ~= nil then
			arg_288_1.duration_ = var_288_0[var_288_1]
		end

		SetActive(arg_288_1.tipsGo_, false)

		function arg_288_1.onSingleLineFinish_()
			arg_288_1.onSingleLineUpdate_ = nil
			arg_288_1.onSingleLineFinish_ = nil
			arg_288_1.state_ = "waiting"
		end

		function arg_288_1.playNext_(arg_290_0)
			if arg_290_0 == 1 then
				arg_288_0:Play325591071(arg_288_1)
			end
		end

		function arg_288_1.onSingleLineUpdate_(arg_291_0)
			local var_291_0 = arg_288_1.actors_["10176ui_story"].transform
			local var_291_1 = 0

			if var_291_1 < arg_288_1.time_ and arg_288_1.time_ <= var_291_1 + arg_291_0 then
				arg_288_1.var_.moveOldPos10176ui_story = var_291_0.localPosition

				local var_291_2 = GameObjectTools.GetOrAddComponent(var_291_0.gameObject, typeof(DynamicBoneHelper))

				if var_291_2 then
					var_291_2:EnableDynamicBone(false)
				end
			end

			local var_291_3 = 0.001

			if var_291_1 <= arg_288_1.time_ and arg_288_1.time_ < var_291_1 + var_291_3 then
				local var_291_4 = (arg_288_1.time_ - var_291_1) / var_291_3
				local var_291_5 = Vector3.New(0, 100, 0)

				var_291_0.localPosition = Vector3.Lerp(arg_288_1.var_.moveOldPos10176ui_story, var_291_5, var_291_4)

				local var_291_6 = manager.ui.mainCamera.transform.position - var_291_0.position

				var_291_0.forward = Vector3.New(var_291_6.x, var_291_6.y, var_291_6.z)

				local var_291_7 = var_291_0.localEulerAngles

				var_291_7.z = 0
				var_291_7.x = 0
				var_291_0.localEulerAngles = var_291_7
			end

			if arg_288_1.time_ >= var_291_1 + var_291_3 and arg_288_1.time_ < var_291_1 + var_291_3 + arg_291_0 then
				var_291_0.localPosition = Vector3.New(0, 100, 0)

				local var_291_8 = manager.ui.mainCamera.transform.position - var_291_0.position

				var_291_0.forward = Vector3.New(var_291_8.x, var_291_8.y, var_291_8.z)

				local var_291_9 = var_291_0.localEulerAngles

				var_291_9.z = 0
				var_291_9.x = 0
				var_291_0.localEulerAngles = var_291_9

				local var_291_10 = GameObjectTools.GetOrAddComponent(var_291_0.gameObject, typeof(DynamicBoneHelper))

				if var_291_10 then
					var_291_10:EnableDynamicBone(true)
				end
			end

			local var_291_11 = arg_288_1.actors_["1054ui_story"].transform
			local var_291_12 = 0

			if var_291_12 < arg_288_1.time_ and arg_288_1.time_ <= var_291_12 + arg_291_0 then
				arg_288_1.var_.moveOldPos1054ui_story = var_291_11.localPosition

				local var_291_13 = GameObjectTools.GetOrAddComponent(var_291_11.gameObject, typeof(DynamicBoneHelper))

				if var_291_13 then
					var_291_13:EnableDynamicBone(false)
				end
			end

			local var_291_14 = 0.001

			if var_291_12 <= arg_288_1.time_ and arg_288_1.time_ < var_291_12 + var_291_14 then
				local var_291_15 = (arg_288_1.time_ - var_291_12) / var_291_14
				local var_291_16 = Vector3.New(-0.7, -0.985, -6)

				var_291_11.localPosition = Vector3.Lerp(arg_288_1.var_.moveOldPos1054ui_story, var_291_16, var_291_15)

				local var_291_17 = manager.ui.mainCamera.transform.position - var_291_11.position

				var_291_11.forward = Vector3.New(var_291_17.x, var_291_17.y, var_291_17.z)

				local var_291_18 = var_291_11.localEulerAngles

				var_291_18.z = 0
				var_291_18.x = 0
				var_291_11.localEulerAngles = var_291_18
			end

			if arg_288_1.time_ >= var_291_12 + var_291_14 and arg_288_1.time_ < var_291_12 + var_291_14 + arg_291_0 then
				var_291_11.localPosition = Vector3.New(-0.7, -0.985, -6)

				local var_291_19 = manager.ui.mainCamera.transform.position - var_291_11.position

				var_291_11.forward = Vector3.New(var_291_19.x, var_291_19.y, var_291_19.z)

				local var_291_20 = var_291_11.localEulerAngles

				var_291_20.z = 0
				var_291_20.x = 0
				var_291_11.localEulerAngles = var_291_20

				local var_291_21 = GameObjectTools.GetOrAddComponent(var_291_11.gameObject, typeof(DynamicBoneHelper))

				if var_291_21 then
					var_291_21:EnableDynamicBone(true)
				end
			end

			local var_291_22 = arg_288_1.actors_["6148ui_story"].transform
			local var_291_23 = 0

			if var_291_23 < arg_288_1.time_ and arg_288_1.time_ <= var_291_23 + arg_291_0 then
				arg_288_1.var_.moveOldPos6148ui_story = var_291_22.localPosition

				local var_291_24 = GameObjectTools.GetOrAddComponent(var_291_22.gameObject, typeof(DynamicBoneHelper))

				if var_291_24 then
					var_291_24:EnableDynamicBone(false)
				end
			end

			local var_291_25 = 0.001

			if var_291_23 <= arg_288_1.time_ and arg_288_1.time_ < var_291_23 + var_291_25 then
				local var_291_26 = (arg_288_1.time_ - var_291_23) / var_291_25
				local var_291_27 = Vector3.New(0.7, -0.985, -6)

				var_291_22.localPosition = Vector3.Lerp(arg_288_1.var_.moveOldPos6148ui_story, var_291_27, var_291_26)

				local var_291_28 = manager.ui.mainCamera.transform.position - var_291_22.position

				var_291_22.forward = Vector3.New(var_291_28.x, var_291_28.y, var_291_28.z)

				local var_291_29 = var_291_22.localEulerAngles

				var_291_29.z = 0
				var_291_29.x = 0
				var_291_22.localEulerAngles = var_291_29
			end

			if arg_288_1.time_ >= var_291_23 + var_291_25 and arg_288_1.time_ < var_291_23 + var_291_25 + arg_291_0 then
				var_291_22.localPosition = Vector3.New(0.7, -0.985, -6)

				local var_291_30 = manager.ui.mainCamera.transform.position - var_291_22.position

				var_291_22.forward = Vector3.New(var_291_30.x, var_291_30.y, var_291_30.z)

				local var_291_31 = var_291_22.localEulerAngles

				var_291_31.z = 0
				var_291_31.x = 0
				var_291_22.localEulerAngles = var_291_31

				local var_291_32 = GameObjectTools.GetOrAddComponent(var_291_22.gameObject, typeof(DynamicBoneHelper))

				if var_291_32 then
					var_291_32:EnableDynamicBone(true)
				end
			end

			local var_291_33 = arg_288_1.actors_["1054ui_story"]
			local var_291_34 = 0

			if var_291_34 < arg_288_1.time_ and arg_288_1.time_ <= var_291_34 + arg_291_0 and not isNil(var_291_33) and arg_288_1.var_.characterEffect1054ui_story == nil then
				arg_288_1.var_.characterEffect1054ui_story = var_291_33:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_291_35 = 0.200000002980232

			if var_291_34 <= arg_288_1.time_ and arg_288_1.time_ < var_291_34 + var_291_35 and not isNil(var_291_33) then
				local var_291_36 = (arg_288_1.time_ - var_291_34) / var_291_35

				if arg_288_1.var_.characterEffect1054ui_story and not isNil(var_291_33) then
					arg_288_1.var_.characterEffect1054ui_story.fillFlat = false
				end
			end

			if arg_288_1.time_ >= var_291_34 + var_291_35 and arg_288_1.time_ < var_291_34 + var_291_35 + arg_291_0 and not isNil(var_291_33) and arg_288_1.var_.characterEffect1054ui_story then
				arg_288_1.var_.characterEffect1054ui_story.fillFlat = false
			end

			local var_291_37 = arg_288_1.actors_["6148ui_story"]
			local var_291_38 = 0

			if var_291_38 < arg_288_1.time_ and arg_288_1.time_ <= var_291_38 + arg_291_0 and not isNil(var_291_37) and arg_288_1.var_.characterEffect6148ui_story == nil then
				arg_288_1.var_.characterEffect6148ui_story = var_291_37:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_291_39 = 0.200000002980232

			if var_291_38 <= arg_288_1.time_ and arg_288_1.time_ < var_291_38 + var_291_39 and not isNil(var_291_37) then
				local var_291_40 = (arg_288_1.time_ - var_291_38) / var_291_39

				if arg_288_1.var_.characterEffect6148ui_story and not isNil(var_291_37) then
					arg_288_1.var_.characterEffect6148ui_story.fillFlat = false
				end
			end

			if arg_288_1.time_ >= var_291_38 + var_291_39 and arg_288_1.time_ < var_291_38 + var_291_39 + arg_291_0 and not isNil(var_291_37) and arg_288_1.var_.characterEffect6148ui_story then
				arg_288_1.var_.characterEffect6148ui_story.fillFlat = false
			end

			local var_291_41 = 0
			local var_291_42 = 0.2

			if var_291_41 < arg_288_1.time_ and arg_288_1.time_ <= var_291_41 + arg_291_0 then
				arg_288_1.talkMaxDuration = 0
				arg_288_1.dialogCg_.alpha = 1

				arg_288_1.dialog_:SetActive(true)
				SetActive(arg_288_1.leftNameGo_, true)

				local var_291_43 = arg_288_1:FormatText(StoryNameCfg[1489].name)

				arg_288_1.leftNameTxt_.text = var_291_43

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_288_1.leftNameTxt_.transform)

				arg_288_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_288_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_288_1:RecordName(arg_288_1.leftNameTxt_.text)
				SetActive(arg_288_1.iconTrs_.gameObject, false)
				arg_288_1.callingController_:SetSelectedState("normal")

				local var_291_44 = arg_288_1:GetWordFromCfg(325591070)
				local var_291_45 = arg_288_1:FormatText(var_291_44.content)

				arg_288_1.text_.text = var_291_45

				LuaForUtil.ClearLinePrefixSymbol(arg_288_1.text_)

				local var_291_46 = 8
				local var_291_47 = utf8.len(var_291_45)
				local var_291_48 = var_291_46 <= 0 and var_291_42 or var_291_42 * (var_291_47 / var_291_46)

				if var_291_48 > 0 and var_291_42 < var_291_48 then
					arg_288_1.talkMaxDuration = var_291_48

					if var_291_48 + var_291_41 > arg_288_1.duration_ then
						arg_288_1.duration_ = var_291_48 + var_291_41
					end
				end

				arg_288_1.text_.text = var_291_45
				arg_288_1.typewritter.percent = 0

				arg_288_1.typewritter:SetDirty()
				arg_288_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_325591", "325591070", "story_v_out_325591.awb") ~= 0 then
					local var_291_49 = manager.audio:GetVoiceLength("story_v_out_325591", "325591070", "story_v_out_325591.awb") / 1000

					if var_291_49 + var_291_41 > arg_288_1.duration_ then
						arg_288_1.duration_ = var_291_49 + var_291_41
					end

					if var_291_44.prefab_name ~= "" and arg_288_1.actors_[var_291_44.prefab_name] ~= nil then
						local var_291_50 = LuaForUtil.PlayVoiceWithCriLipsync(arg_288_1.actors_[var_291_44.prefab_name].transform, "story_v_out_325591", "325591070", "story_v_out_325591.awb")

						arg_288_1:RecordAudio("325591070", var_291_50)
						arg_288_1:RecordAudio("325591070", var_291_50)
					else
						arg_288_1:AudioAction("play", "voice", "story_v_out_325591", "325591070", "story_v_out_325591.awb")
					end

					arg_288_1:RecordHistoryTalkVoice("story_v_out_325591", "325591070", "story_v_out_325591.awb")
				end

				arg_288_1:RecordContent(arg_288_1.text_.text)
			end

			local var_291_51 = math.max(var_291_42, arg_288_1.talkMaxDuration)

			if var_291_41 <= arg_288_1.time_ and arg_288_1.time_ < var_291_41 + var_291_51 then
				arg_288_1.typewritter.percent = (arg_288_1.time_ - var_291_41) / var_291_51

				arg_288_1.typewritter:SetDirty()
			end

			if arg_288_1.time_ >= var_291_41 + var_291_51 and arg_288_1.time_ < var_291_41 + var_291_51 + arg_291_0 then
				arg_288_1.typewritter.percent = 1

				arg_288_1.typewritter:SetDirty()
				arg_288_1:ShowNextGo(true)
			end
		end

		arg_288_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10176ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1054ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "6148ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_288_1:InitPlayNodeList()
	end,
	Play325591071 = function(arg_292_0, arg_292_1)
		arg_292_1.time_ = 0
		arg_292_1.frameCnt_ = 0
		arg_292_1.state_ = "playing"
		arg_292_1.curTalkId_ = 325591071
		arg_292_1.duration_ = 7.03

		local var_292_0 = {
			zh = 5.833,
			ja = 7.033
		}
		local var_292_1 = manager.audio:GetLocalizationFlag()

		if var_292_0[var_292_1] ~= nil then
			arg_292_1.duration_ = var_292_0[var_292_1]
		end

		SetActive(arg_292_1.tipsGo_, false)

		function arg_292_1.onSingleLineFinish_()
			arg_292_1.onSingleLineUpdate_ = nil
			arg_292_1.onSingleLineFinish_ = nil
			arg_292_1.state_ = "waiting"
		end

		function arg_292_1.playNext_(arg_294_0)
			if arg_294_0 == 1 then
				arg_292_0:Play325591072(arg_292_1)
			end
		end

		function arg_292_1.onSingleLineUpdate_(arg_295_0)
			local var_295_0 = arg_292_1.actors_["10176ui_story"]
			local var_295_1 = 0

			if var_295_1 < arg_292_1.time_ and arg_292_1.time_ <= var_295_1 + arg_295_0 and not isNil(var_295_0) and arg_292_1.var_.characterEffect10176ui_story == nil then
				arg_292_1.var_.characterEffect10176ui_story = var_295_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_295_2 = 0.200000002980232

			if var_295_1 <= arg_292_1.time_ and arg_292_1.time_ < var_295_1 + var_295_2 and not isNil(var_295_0) then
				local var_295_3 = (arg_292_1.time_ - var_295_1) / var_295_2

				if arg_292_1.var_.characterEffect10176ui_story and not isNil(var_295_0) then
					arg_292_1.var_.characterEffect10176ui_story.fillFlat = false
				end
			end

			if arg_292_1.time_ >= var_295_1 + var_295_2 and arg_292_1.time_ < var_295_1 + var_295_2 + arg_295_0 and not isNil(var_295_0) and arg_292_1.var_.characterEffect10176ui_story then
				arg_292_1.var_.characterEffect10176ui_story.fillFlat = false
			end

			local var_295_4 = 0

			if var_295_4 < arg_292_1.time_ and arg_292_1.time_ <= var_295_4 + arg_295_0 then
				arg_292_1:PlayTimeline("10176ui_story", "StoryTimeline/CharAction/story10176/story10176action/10176action5_1")
			end

			local var_295_5 = 0

			if var_295_5 < arg_292_1.time_ and arg_292_1.time_ <= var_295_5 + arg_295_0 then
				arg_292_1:PlayTimeline("10176ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0101cva", "EmotionTimelineAnimator")
			end

			local var_295_6 = arg_292_1.actors_["10176ui_story"].transform
			local var_295_7 = 0

			if var_295_7 < arg_292_1.time_ and arg_292_1.time_ <= var_295_7 + arg_295_0 then
				arg_292_1.var_.moveOldPos10176ui_story = var_295_6.localPosition

				local var_295_8 = GameObjectTools.GetOrAddComponent(var_295_6.gameObject, typeof(DynamicBoneHelper))

				if var_295_8 then
					var_295_8:EnableDynamicBone(false)
				end
			end

			local var_295_9 = 0.001

			if var_295_7 <= arg_292_1.time_ and arg_292_1.time_ < var_295_7 + var_295_9 then
				local var_295_10 = (arg_292_1.time_ - var_295_7) / var_295_9
				local var_295_11 = Vector3.New(-0.02, -1.09, -6.12)

				var_295_6.localPosition = Vector3.Lerp(arg_292_1.var_.moveOldPos10176ui_story, var_295_11, var_295_10)

				local var_295_12 = manager.ui.mainCamera.transform.position - var_295_6.position

				var_295_6.forward = Vector3.New(var_295_12.x, var_295_12.y, var_295_12.z)

				local var_295_13 = var_295_6.localEulerAngles

				var_295_13.z = 0
				var_295_13.x = 0
				var_295_6.localEulerAngles = var_295_13
			end

			if arg_292_1.time_ >= var_295_7 + var_295_9 and arg_292_1.time_ < var_295_7 + var_295_9 + arg_295_0 then
				var_295_6.localPosition = Vector3.New(-0.02, -1.09, -6.12)

				local var_295_14 = manager.ui.mainCamera.transform.position - var_295_6.position

				var_295_6.forward = Vector3.New(var_295_14.x, var_295_14.y, var_295_14.z)

				local var_295_15 = var_295_6.localEulerAngles

				var_295_15.z = 0
				var_295_15.x = 0
				var_295_6.localEulerAngles = var_295_15

				local var_295_16 = GameObjectTools.GetOrAddComponent(var_295_6.gameObject, typeof(DynamicBoneHelper))

				if var_295_16 then
					var_295_16:EnableDynamicBone(true)
				end
			end

			local var_295_17 = arg_292_1.actors_["1054ui_story"].transform
			local var_295_18 = 0

			if var_295_18 < arg_292_1.time_ and arg_292_1.time_ <= var_295_18 + arg_295_0 then
				arg_292_1.var_.moveOldPos1054ui_story = var_295_17.localPosition

				local var_295_19 = GameObjectTools.GetOrAddComponent(var_295_17.gameObject, typeof(DynamicBoneHelper))

				if var_295_19 then
					var_295_19:EnableDynamicBone(false)
				end
			end

			local var_295_20 = 0.001

			if var_295_18 <= arg_292_1.time_ and arg_292_1.time_ < var_295_18 + var_295_20 then
				local var_295_21 = (arg_292_1.time_ - var_295_18) / var_295_20
				local var_295_22 = Vector3.New(0, 100, 0)

				var_295_17.localPosition = Vector3.Lerp(arg_292_1.var_.moveOldPos1054ui_story, var_295_22, var_295_21)

				local var_295_23 = manager.ui.mainCamera.transform.position - var_295_17.position

				var_295_17.forward = Vector3.New(var_295_23.x, var_295_23.y, var_295_23.z)

				local var_295_24 = var_295_17.localEulerAngles

				var_295_24.z = 0
				var_295_24.x = 0
				var_295_17.localEulerAngles = var_295_24
			end

			if arg_292_1.time_ >= var_295_18 + var_295_20 and arg_292_1.time_ < var_295_18 + var_295_20 + arg_295_0 then
				var_295_17.localPosition = Vector3.New(0, 100, 0)

				local var_295_25 = manager.ui.mainCamera.transform.position - var_295_17.position

				var_295_17.forward = Vector3.New(var_295_25.x, var_295_25.y, var_295_25.z)

				local var_295_26 = var_295_17.localEulerAngles

				var_295_26.z = 0
				var_295_26.x = 0
				var_295_17.localEulerAngles = var_295_26

				local var_295_27 = GameObjectTools.GetOrAddComponent(var_295_17.gameObject, typeof(DynamicBoneHelper))

				if var_295_27 then
					var_295_27:EnableDynamicBone(true)
				end
			end

			local var_295_28 = arg_292_1.actors_["6148ui_story"].transform
			local var_295_29 = 0

			if var_295_29 < arg_292_1.time_ and arg_292_1.time_ <= var_295_29 + arg_295_0 then
				arg_292_1.var_.moveOldPos6148ui_story = var_295_28.localPosition

				local var_295_30 = GameObjectTools.GetOrAddComponent(var_295_28.gameObject, typeof(DynamicBoneHelper))

				if var_295_30 then
					var_295_30:EnableDynamicBone(false)
				end
			end

			local var_295_31 = 0.001

			if var_295_29 <= arg_292_1.time_ and arg_292_1.time_ < var_295_29 + var_295_31 then
				local var_295_32 = (arg_292_1.time_ - var_295_29) / var_295_31
				local var_295_33 = Vector3.New(0, 100, 0)

				var_295_28.localPosition = Vector3.Lerp(arg_292_1.var_.moveOldPos6148ui_story, var_295_33, var_295_32)

				local var_295_34 = manager.ui.mainCamera.transform.position - var_295_28.position

				var_295_28.forward = Vector3.New(var_295_34.x, var_295_34.y, var_295_34.z)

				local var_295_35 = var_295_28.localEulerAngles

				var_295_35.z = 0
				var_295_35.x = 0
				var_295_28.localEulerAngles = var_295_35
			end

			if arg_292_1.time_ >= var_295_29 + var_295_31 and arg_292_1.time_ < var_295_29 + var_295_31 + arg_295_0 then
				var_295_28.localPosition = Vector3.New(0, 100, 0)

				local var_295_36 = manager.ui.mainCamera.transform.position - var_295_28.position

				var_295_28.forward = Vector3.New(var_295_36.x, var_295_36.y, var_295_36.z)

				local var_295_37 = var_295_28.localEulerAngles

				var_295_37.z = 0
				var_295_37.x = 0
				var_295_28.localEulerAngles = var_295_37

				local var_295_38 = GameObjectTools.GetOrAddComponent(var_295_28.gameObject, typeof(DynamicBoneHelper))

				if var_295_38 then
					var_295_38:EnableDynamicBone(true)
				end
			end

			local var_295_39 = 0
			local var_295_40 = 0.425

			if var_295_39 < arg_292_1.time_ and arg_292_1.time_ <= var_295_39 + arg_295_0 then
				arg_292_1.talkMaxDuration = 0
				arg_292_1.dialogCg_.alpha = 1

				arg_292_1.dialog_:SetActive(true)
				SetActive(arg_292_1.leftNameGo_, true)

				local var_295_41 = arg_292_1:FormatText(StoryNameCfg[1510].name)

				arg_292_1.leftNameTxt_.text = var_295_41

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_292_1.leftNameTxt_.transform)

				arg_292_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_292_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_292_1:RecordName(arg_292_1.leftNameTxt_.text)
				SetActive(arg_292_1.iconTrs_.gameObject, false)
				arg_292_1.callingController_:SetSelectedState("normal")

				local var_295_42 = arg_292_1:GetWordFromCfg(325591071)
				local var_295_43 = arg_292_1:FormatText(var_295_42.content)

				arg_292_1.text_.text = var_295_43

				LuaForUtil.ClearLinePrefixSymbol(arg_292_1.text_)

				local var_295_44 = 17
				local var_295_45 = utf8.len(var_295_43)
				local var_295_46 = var_295_44 <= 0 and var_295_40 or var_295_40 * (var_295_45 / var_295_44)

				if var_295_46 > 0 and var_295_40 < var_295_46 then
					arg_292_1.talkMaxDuration = var_295_46

					if var_295_46 + var_295_39 > arg_292_1.duration_ then
						arg_292_1.duration_ = var_295_46 + var_295_39
					end
				end

				arg_292_1.text_.text = var_295_43
				arg_292_1.typewritter.percent = 0

				arg_292_1.typewritter:SetDirty()
				arg_292_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_325591", "325591071", "story_v_out_325591.awb") ~= 0 then
					local var_295_47 = manager.audio:GetVoiceLength("story_v_out_325591", "325591071", "story_v_out_325591.awb") / 1000

					if var_295_47 + var_295_39 > arg_292_1.duration_ then
						arg_292_1.duration_ = var_295_47 + var_295_39
					end

					if var_295_42.prefab_name ~= "" and arg_292_1.actors_[var_295_42.prefab_name] ~= nil then
						local var_295_48 = LuaForUtil.PlayVoiceWithCriLipsync(arg_292_1.actors_[var_295_42.prefab_name].transform, "story_v_out_325591", "325591071", "story_v_out_325591.awb")

						arg_292_1:RecordAudio("325591071", var_295_48)
						arg_292_1:RecordAudio("325591071", var_295_48)
					else
						arg_292_1:AudioAction("play", "voice", "story_v_out_325591", "325591071", "story_v_out_325591.awb")
					end

					arg_292_1:RecordHistoryTalkVoice("story_v_out_325591", "325591071", "story_v_out_325591.awb")
				end

				arg_292_1:RecordContent(arg_292_1.text_.text)
			end

			local var_295_49 = math.max(var_295_40, arg_292_1.talkMaxDuration)

			if var_295_39 <= arg_292_1.time_ and arg_292_1.time_ < var_295_39 + var_295_49 then
				arg_292_1.typewritter.percent = (arg_292_1.time_ - var_295_39) / var_295_49

				arg_292_1.typewritter:SetDirty()
			end

			if arg_292_1.time_ >= var_295_39 + var_295_49 and arg_292_1.time_ < var_295_39 + var_295_49 + arg_295_0 then
				arg_292_1.typewritter.percent = 1

				arg_292_1.typewritter:SetDirty()
				arg_292_1:ShowNextGo(true)
			end
		end

		arg_292_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10176ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1054ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "6148ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_292_1:InitPlayNodeList()
	end,
	Play325591072 = function(arg_296_0, arg_296_1)
		arg_296_1.time_ = 0
		arg_296_1.frameCnt_ = 0
		arg_296_1.state_ = "playing"
		arg_296_1.curTalkId_ = 325591072
		arg_296_1.duration_ = 3.73

		local var_296_0 = {
			zh = 3.733,
			ja = 2.7
		}
		local var_296_1 = manager.audio:GetLocalizationFlag()

		if var_296_0[var_296_1] ~= nil then
			arg_296_1.duration_ = var_296_0[var_296_1]
		end

		SetActive(arg_296_1.tipsGo_, false)

		function arg_296_1.onSingleLineFinish_()
			arg_296_1.onSingleLineUpdate_ = nil
			arg_296_1.onSingleLineFinish_ = nil
			arg_296_1.state_ = "waiting"
		end

		function arg_296_1.playNext_(arg_298_0)
			if arg_298_0 == 1 then
				arg_296_0:Play325591073(arg_296_1)
			end
		end

		function arg_296_1.onSingleLineUpdate_(arg_299_0)
			local var_299_0 = 0

			if var_299_0 < arg_296_1.time_ and arg_296_1.time_ <= var_299_0 + arg_299_0 then
				arg_296_1:PlayTimeline("10176ui_story", "StoryTimeline/CharAction/story10176/story10176action/10176action5_2")
			end

			local var_299_1 = 0
			local var_299_2 = 0.3

			if var_299_1 < arg_296_1.time_ and arg_296_1.time_ <= var_299_1 + arg_299_0 then
				arg_296_1.talkMaxDuration = 0
				arg_296_1.dialogCg_.alpha = 1

				arg_296_1.dialog_:SetActive(true)
				SetActive(arg_296_1.leftNameGo_, true)

				local var_299_3 = arg_296_1:FormatText(StoryNameCfg[1510].name)

				arg_296_1.leftNameTxt_.text = var_299_3

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_296_1.leftNameTxt_.transform)

				arg_296_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_296_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_296_1:RecordName(arg_296_1.leftNameTxt_.text)
				SetActive(arg_296_1.iconTrs_.gameObject, false)
				arg_296_1.callingController_:SetSelectedState("normal")

				local var_299_4 = arg_296_1:GetWordFromCfg(325591072)
				local var_299_5 = arg_296_1:FormatText(var_299_4.content)

				arg_296_1.text_.text = var_299_5

				LuaForUtil.ClearLinePrefixSymbol(arg_296_1.text_)

				local var_299_6 = 12
				local var_299_7 = utf8.len(var_299_5)
				local var_299_8 = var_299_6 <= 0 and var_299_2 or var_299_2 * (var_299_7 / var_299_6)

				if var_299_8 > 0 and var_299_2 < var_299_8 then
					arg_296_1.talkMaxDuration = var_299_8

					if var_299_8 + var_299_1 > arg_296_1.duration_ then
						arg_296_1.duration_ = var_299_8 + var_299_1
					end
				end

				arg_296_1.text_.text = var_299_5
				arg_296_1.typewritter.percent = 0

				arg_296_1.typewritter:SetDirty()
				arg_296_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_325591", "325591072", "story_v_out_325591.awb") ~= 0 then
					local var_299_9 = manager.audio:GetVoiceLength("story_v_out_325591", "325591072", "story_v_out_325591.awb") / 1000

					if var_299_9 + var_299_1 > arg_296_1.duration_ then
						arg_296_1.duration_ = var_299_9 + var_299_1
					end

					if var_299_4.prefab_name ~= "" and arg_296_1.actors_[var_299_4.prefab_name] ~= nil then
						local var_299_10 = LuaForUtil.PlayVoiceWithCriLipsync(arg_296_1.actors_[var_299_4.prefab_name].transform, "story_v_out_325591", "325591072", "story_v_out_325591.awb")

						arg_296_1:RecordAudio("325591072", var_299_10)
						arg_296_1:RecordAudio("325591072", var_299_10)
					else
						arg_296_1:AudioAction("play", "voice", "story_v_out_325591", "325591072", "story_v_out_325591.awb")
					end

					arg_296_1:RecordHistoryTalkVoice("story_v_out_325591", "325591072", "story_v_out_325591.awb")
				end

				arg_296_1:RecordContent(arg_296_1.text_.text)
			end

			local var_299_11 = math.max(var_299_2, arg_296_1.talkMaxDuration)

			if var_299_1 <= arg_296_1.time_ and arg_296_1.time_ < var_299_1 + var_299_11 then
				arg_296_1.typewritter.percent = (arg_296_1.time_ - var_299_1) / var_299_11

				arg_296_1.typewritter:SetDirty()
			end

			if arg_296_1.time_ >= var_299_1 + var_299_11 and arg_296_1.time_ < var_299_1 + var_299_11 + arg_299_0 then
				arg_296_1.typewritter.percent = 1

				arg_296_1.typewritter:SetDirty()
				arg_296_1:ShowNextGo(true)
			end
		end

		arg_296_1.nodeConfigList_ = {}

		arg_296_1:InitPlayNodeList()
	end,
	Play325591073 = function(arg_300_0, arg_300_1)
		arg_300_1.time_ = 0
		arg_300_1.frameCnt_ = 0
		arg_300_1.state_ = "playing"
		arg_300_1.curTalkId_ = 325591073
		arg_300_1.duration_ = 5

		SetActive(arg_300_1.tipsGo_, false)

		function arg_300_1.onSingleLineFinish_()
			arg_300_1.onSingleLineUpdate_ = nil
			arg_300_1.onSingleLineFinish_ = nil
			arg_300_1.state_ = "waiting"
		end

		function arg_300_1.playNext_(arg_302_0)
			if arg_302_0 == 1 then
				arg_300_0:Play325591074(arg_300_1)
			end
		end

		function arg_300_1.onSingleLineUpdate_(arg_303_0)
			local var_303_0 = arg_300_1.actors_["10176ui_story"].transform
			local var_303_1 = 0

			if var_303_1 < arg_300_1.time_ and arg_300_1.time_ <= var_303_1 + arg_303_0 then
				arg_300_1.var_.moveOldPos10176ui_story = var_303_0.localPosition

				local var_303_2 = GameObjectTools.GetOrAddComponent(var_303_0.gameObject, typeof(DynamicBoneHelper))

				if var_303_2 then
					var_303_2:EnableDynamicBone(false)
				end
			end

			local var_303_3 = 0.001

			if var_303_1 <= arg_300_1.time_ and arg_300_1.time_ < var_303_1 + var_303_3 then
				local var_303_4 = (arg_300_1.time_ - var_303_1) / var_303_3
				local var_303_5 = Vector3.New(0, 100, 0)

				var_303_0.localPosition = Vector3.Lerp(arg_300_1.var_.moveOldPos10176ui_story, var_303_5, var_303_4)

				local var_303_6 = manager.ui.mainCamera.transform.position - var_303_0.position

				var_303_0.forward = Vector3.New(var_303_6.x, var_303_6.y, var_303_6.z)

				local var_303_7 = var_303_0.localEulerAngles

				var_303_7.z = 0
				var_303_7.x = 0
				var_303_0.localEulerAngles = var_303_7
			end

			if arg_300_1.time_ >= var_303_1 + var_303_3 and arg_300_1.time_ < var_303_1 + var_303_3 + arg_303_0 then
				var_303_0.localPosition = Vector3.New(0, 100, 0)

				local var_303_8 = manager.ui.mainCamera.transform.position - var_303_0.position

				var_303_0.forward = Vector3.New(var_303_8.x, var_303_8.y, var_303_8.z)

				local var_303_9 = var_303_0.localEulerAngles

				var_303_9.z = 0
				var_303_9.x = 0
				var_303_0.localEulerAngles = var_303_9

				local var_303_10 = GameObjectTools.GetOrAddComponent(var_303_0.gameObject, typeof(DynamicBoneHelper))

				if var_303_10 then
					var_303_10:EnableDynamicBone(true)
				end
			end

			local var_303_11 = arg_300_1.actors_["6148ui_story"].transform
			local var_303_12 = 0

			if var_303_12 < arg_300_1.time_ and arg_300_1.time_ <= var_303_12 + arg_303_0 then
				arg_300_1.var_.moveOldPos6148ui_story = var_303_11.localPosition

				local var_303_13 = GameObjectTools.GetOrAddComponent(var_303_11.gameObject, typeof(DynamicBoneHelper))

				if var_303_13 then
					var_303_13:EnableDynamicBone(false)
				end
			end

			local var_303_14 = 0.001

			if var_303_12 <= arg_300_1.time_ and arg_300_1.time_ < var_303_12 + var_303_14 then
				local var_303_15 = (arg_300_1.time_ - var_303_12) / var_303_14
				local var_303_16 = Vector3.New(0, 100, 0)

				var_303_11.localPosition = Vector3.Lerp(arg_300_1.var_.moveOldPos6148ui_story, var_303_16, var_303_15)

				local var_303_17 = manager.ui.mainCamera.transform.position - var_303_11.position

				var_303_11.forward = Vector3.New(var_303_17.x, var_303_17.y, var_303_17.z)

				local var_303_18 = var_303_11.localEulerAngles

				var_303_18.z = 0
				var_303_18.x = 0
				var_303_11.localEulerAngles = var_303_18
			end

			if arg_300_1.time_ >= var_303_12 + var_303_14 and arg_300_1.time_ < var_303_12 + var_303_14 + arg_303_0 then
				var_303_11.localPosition = Vector3.New(0, 100, 0)

				local var_303_19 = manager.ui.mainCamera.transform.position - var_303_11.position

				var_303_11.forward = Vector3.New(var_303_19.x, var_303_19.y, var_303_19.z)

				local var_303_20 = var_303_11.localEulerAngles

				var_303_20.z = 0
				var_303_20.x = 0
				var_303_11.localEulerAngles = var_303_20

				local var_303_21 = GameObjectTools.GetOrAddComponent(var_303_11.gameObject, typeof(DynamicBoneHelper))

				if var_303_21 then
					var_303_21:EnableDynamicBone(true)
				end
			end

			local var_303_22 = arg_300_1.actors_["1054ui_story"].transform
			local var_303_23 = 0

			if var_303_23 < arg_300_1.time_ and arg_300_1.time_ <= var_303_23 + arg_303_0 then
				arg_300_1.var_.moveOldPos1054ui_story = var_303_22.localPosition

				local var_303_24 = GameObjectTools.GetOrAddComponent(var_303_22.gameObject, typeof(DynamicBoneHelper))

				if var_303_24 then
					var_303_24:EnableDynamicBone(false)
				end
			end

			local var_303_25 = 0.001

			if var_303_23 <= arg_300_1.time_ and arg_300_1.time_ < var_303_23 + var_303_25 then
				local var_303_26 = (arg_300_1.time_ - var_303_23) / var_303_25
				local var_303_27 = Vector3.New(0, 100, 0)

				var_303_22.localPosition = Vector3.Lerp(arg_300_1.var_.moveOldPos1054ui_story, var_303_27, var_303_26)

				local var_303_28 = manager.ui.mainCamera.transform.position - var_303_22.position

				var_303_22.forward = Vector3.New(var_303_28.x, var_303_28.y, var_303_28.z)

				local var_303_29 = var_303_22.localEulerAngles

				var_303_29.z = 0
				var_303_29.x = 0
				var_303_22.localEulerAngles = var_303_29
			end

			if arg_300_1.time_ >= var_303_23 + var_303_25 and arg_300_1.time_ < var_303_23 + var_303_25 + arg_303_0 then
				var_303_22.localPosition = Vector3.New(0, 100, 0)

				local var_303_30 = manager.ui.mainCamera.transform.position - var_303_22.position

				var_303_22.forward = Vector3.New(var_303_30.x, var_303_30.y, var_303_30.z)

				local var_303_31 = var_303_22.localEulerAngles

				var_303_31.z = 0
				var_303_31.x = 0
				var_303_22.localEulerAngles = var_303_31

				local var_303_32 = GameObjectTools.GetOrAddComponent(var_303_22.gameObject, typeof(DynamicBoneHelper))

				if var_303_32 then
					var_303_32:EnableDynamicBone(true)
				end
			end

			local var_303_33 = arg_300_1.actors_["10176ui_story"]
			local var_303_34 = 0

			if var_303_34 < arg_300_1.time_ and arg_300_1.time_ <= var_303_34 + arg_303_0 and not isNil(var_303_33) and arg_300_1.var_.characterEffect10176ui_story == nil then
				arg_300_1.var_.characterEffect10176ui_story = var_303_33:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_303_35 = 0.200000002980232

			if var_303_34 <= arg_300_1.time_ and arg_300_1.time_ < var_303_34 + var_303_35 and not isNil(var_303_33) then
				local var_303_36 = (arg_300_1.time_ - var_303_34) / var_303_35

				if arg_300_1.var_.characterEffect10176ui_story and not isNil(var_303_33) then
					local var_303_37 = Mathf.Lerp(0, 0.5, var_303_36)

					arg_300_1.var_.characterEffect10176ui_story.fillFlat = true
					arg_300_1.var_.characterEffect10176ui_story.fillRatio = var_303_37
				end
			end

			if arg_300_1.time_ >= var_303_34 + var_303_35 and arg_300_1.time_ < var_303_34 + var_303_35 + arg_303_0 and not isNil(var_303_33) and arg_300_1.var_.characterEffect10176ui_story then
				local var_303_38 = 0.5

				arg_300_1.var_.characterEffect10176ui_story.fillFlat = true
				arg_300_1.var_.characterEffect10176ui_story.fillRatio = var_303_38
			end

			local var_303_39 = 0
			local var_303_40 = 1

			if var_303_39 < arg_300_1.time_ and arg_300_1.time_ <= var_303_39 + arg_303_0 then
				local var_303_41 = "play"
				local var_303_42 = "effect"

				arg_300_1:AudioAction(var_303_41, var_303_42, "ui_battle", "ui_battle_stopbgm", "")
			end

			local var_303_43 = 0
			local var_303_44 = 1.175

			if var_303_43 < arg_300_1.time_ and arg_300_1.time_ <= var_303_43 + arg_303_0 then
				arg_300_1.talkMaxDuration = 0
				arg_300_1.dialogCg_.alpha = 1

				arg_300_1.dialog_:SetActive(true)
				SetActive(arg_300_1.leftNameGo_, false)

				arg_300_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_300_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_300_1:RecordName(arg_300_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_300_1.iconTrs_.gameObject, false)
				arg_300_1.callingController_:SetSelectedState("normal")

				local var_303_45 = arg_300_1:GetWordFromCfg(325591073)
				local var_303_46 = arg_300_1:FormatText(var_303_45.content)

				arg_300_1.text_.text = var_303_46

				LuaForUtil.ClearLinePrefixSymbol(arg_300_1.text_)

				local var_303_47 = 47
				local var_303_48 = utf8.len(var_303_46)
				local var_303_49 = var_303_47 <= 0 and var_303_44 or var_303_44 * (var_303_48 / var_303_47)

				if var_303_49 > 0 and var_303_44 < var_303_49 then
					arg_300_1.talkMaxDuration = var_303_49

					if var_303_49 + var_303_43 > arg_300_1.duration_ then
						arg_300_1.duration_ = var_303_49 + var_303_43
					end
				end

				arg_300_1.text_.text = var_303_46
				arg_300_1.typewritter.percent = 0

				arg_300_1.typewritter:SetDirty()
				arg_300_1:ShowNextGo(false)
				arg_300_1:RecordContent(arg_300_1.text_.text)
			end

			local var_303_50 = math.max(var_303_44, arg_300_1.talkMaxDuration)

			if var_303_43 <= arg_300_1.time_ and arg_300_1.time_ < var_303_43 + var_303_50 then
				arg_300_1.typewritter.percent = (arg_300_1.time_ - var_303_43) / var_303_50

				arg_300_1.typewritter:SetDirty()
			end

			if arg_300_1.time_ >= var_303_43 + var_303_50 and arg_300_1.time_ < var_303_43 + var_303_50 + arg_303_0 then
				arg_300_1.typewritter.percent = 1

				arg_300_1.typewritter:SetDirty()
				arg_300_1:ShowNextGo(true)
			end
		end

		arg_300_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10176ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "6148ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1054ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_300_1:InitPlayNodeList()
	end,
	Play325591074 = function(arg_304_0, arg_304_1)
		arg_304_1.time_ = 0
		arg_304_1.frameCnt_ = 0
		arg_304_1.state_ = "playing"
		arg_304_1.curTalkId_ = 325591074
		arg_304_1.duration_ = 9.87

		local var_304_0 = {
			zh = 9.4,
			ja = 9.866
		}
		local var_304_1 = manager.audio:GetLocalizationFlag()

		if var_304_0[var_304_1] ~= nil then
			arg_304_1.duration_ = var_304_0[var_304_1]
		end

		SetActive(arg_304_1.tipsGo_, false)

		function arg_304_1.onSingleLineFinish_()
			arg_304_1.onSingleLineUpdate_ = nil
			arg_304_1.onSingleLineFinish_ = nil
			arg_304_1.state_ = "waiting"
		end

		function arg_304_1.playNext_(arg_306_0)
			if arg_306_0 == 1 then
				arg_304_0:Play325591075(arg_304_1)
			end
		end

		function arg_304_1.onSingleLineUpdate_(arg_307_0)
			local var_307_0 = "J26h"

			if arg_304_1.bgs_[var_307_0] == nil then
				local var_307_1 = Object.Instantiate(arg_304_1.paintGo_)

				var_307_1:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. var_307_0)
				var_307_1.name = var_307_0
				var_307_1.transform.parent = arg_304_1.stage_.transform
				var_307_1.transform.localPosition = Vector3.New(0, 100, 0)
				arg_304_1.bgs_[var_307_0] = var_307_1
			end

			local var_307_2 = 2

			if var_307_2 < arg_304_1.time_ and arg_304_1.time_ <= var_307_2 + arg_307_0 then
				local var_307_3 = manager.ui.mainCamera.transform.localPosition
				local var_307_4 = Vector3.New(0, 0, 10) + Vector3.New(var_307_3.x, var_307_3.y, 0)
				local var_307_5 = arg_304_1.bgs_.J26h

				var_307_5.transform.localPosition = var_307_4
				var_307_5.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_307_6 = var_307_5:GetComponent("SpriteRenderer")

				if var_307_6 and var_307_6.sprite then
					local var_307_7 = (var_307_5.transform.localPosition - var_307_3).z
					local var_307_8 = manager.ui.mainCameraCom_
					local var_307_9 = 2 * var_307_7 * Mathf.Tan(var_307_8.fieldOfView * 0.5 * Mathf.Deg2Rad)
					local var_307_10 = var_307_9 * var_307_8.aspect
					local var_307_11 = var_307_6.sprite.bounds.size.x
					local var_307_12 = var_307_6.sprite.bounds.size.y
					local var_307_13 = var_307_10 / var_307_11
					local var_307_14 = var_307_9 / var_307_12
					local var_307_15 = var_307_14 < var_307_13 and var_307_13 or var_307_14

					var_307_5.transform.localScale = Vector3.New(var_307_15, var_307_15, 0)
				end

				for iter_307_0, iter_307_1 in pairs(arg_304_1.bgs_) do
					if iter_307_0 ~= "J26h" then
						iter_307_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_307_16 = 4

			if var_307_16 < arg_304_1.time_ and arg_304_1.time_ <= var_307_16 + arg_307_0 then
				arg_304_1.allBtn_.enabled = false
			end

			local var_307_17 = 0.3

			if arg_304_1.time_ >= var_307_16 + var_307_17 and arg_304_1.time_ < var_307_16 + var_307_17 + arg_307_0 then
				arg_304_1.allBtn_.enabled = true
			end

			local var_307_18 = 0

			if var_307_18 < arg_304_1.time_ and arg_304_1.time_ <= var_307_18 + arg_307_0 then
				arg_304_1.mask_.enabled = true
				arg_304_1.mask_.raycastTarget = true

				arg_304_1:SetGaussion(false)
			end

			local var_307_19 = 2

			if var_307_18 <= arg_304_1.time_ and arg_304_1.time_ < var_307_18 + var_307_19 then
				local var_307_20 = (arg_304_1.time_ - var_307_18) / var_307_19
				local var_307_21 = Color.New(0, 0, 0)

				var_307_21.a = Mathf.Lerp(0, 1, var_307_20)
				arg_304_1.mask_.color = var_307_21
			end

			if arg_304_1.time_ >= var_307_18 + var_307_19 and arg_304_1.time_ < var_307_18 + var_307_19 + arg_307_0 then
				local var_307_22 = Color.New(0, 0, 0)

				var_307_22.a = 1
				arg_304_1.mask_.color = var_307_22
			end

			local var_307_23 = 2

			if var_307_23 < arg_304_1.time_ and arg_304_1.time_ <= var_307_23 + arg_307_0 then
				arg_304_1.mask_.enabled = true
				arg_304_1.mask_.raycastTarget = true

				arg_304_1:SetGaussion(false)
			end

			local var_307_24 = 2

			if var_307_23 <= arg_304_1.time_ and arg_304_1.time_ < var_307_23 + var_307_24 then
				local var_307_25 = (arg_304_1.time_ - var_307_23) / var_307_24
				local var_307_26 = Color.New(0, 0, 0)

				var_307_26.a = Mathf.Lerp(1, 0, var_307_25)
				arg_304_1.mask_.color = var_307_26
			end

			if arg_304_1.time_ >= var_307_23 + var_307_24 and arg_304_1.time_ < var_307_23 + var_307_24 + arg_307_0 then
				local var_307_27 = Color.New(0, 0, 0)
				local var_307_28 = 0

				arg_304_1.mask_.enabled = false
				var_307_27.a = var_307_28
				arg_304_1.mask_.color = var_307_27
			end

			local var_307_29 = "10175ui_story"

			if arg_304_1.actors_[var_307_29] == nil then
				local var_307_30 = Asset.Load("Char/" .. "10175ui_story")

				if not isNil(var_307_30) then
					local var_307_31 = Object.Instantiate(Asset.Load("Char/" .. "10175ui_story"), arg_304_1.stage_.transform)

					var_307_31.name = var_307_29
					var_307_31.transform.localPosition = Vector3.New(0, 100, 0)
					arg_304_1.actors_[var_307_29] = var_307_31

					local var_307_32 = var_307_31:GetComponentInChildren(typeof(CharacterEffect))

					var_307_32.enabled = true

					local var_307_33 = GameObjectTools.GetOrAddComponent(var_307_31, typeof(DynamicBoneHelper))

					if var_307_33 then
						var_307_33:EnableDynamicBone(false)
					end

					arg_304_1:ShowWeapon(var_307_32.transform, false)

					arg_304_1.var_[var_307_29 .. "Animator"] = var_307_32.gameObject:GetComponent(typeof(UnityEngine.Animator))
					arg_304_1.var_[var_307_29 .. "Animator"].applyRootMotion = true
					arg_304_1.var_[var_307_29 .. "LipSync"] = var_307_32.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
				end
			end

			local var_307_34 = arg_304_1.actors_["10175ui_story"].transform
			local var_307_35 = 3.83333333333333

			if var_307_35 < arg_304_1.time_ and arg_304_1.time_ <= var_307_35 + arg_307_0 then
				arg_304_1.var_.moveOldPos10175ui_story = var_307_34.localPosition

				local var_307_36 = GameObjectTools.GetOrAddComponent(var_307_34.gameObject, typeof(DynamicBoneHelper))

				if var_307_36 then
					var_307_36:EnableDynamicBone(false)
				end
			end

			local var_307_37 = 0.001

			if var_307_35 <= arg_304_1.time_ and arg_304_1.time_ < var_307_35 + var_307_37 then
				local var_307_38 = (arg_304_1.time_ - var_307_35) / var_307_37
				local var_307_39 = Vector3.New(0, -1, -6.05)

				var_307_34.localPosition = Vector3.Lerp(arg_304_1.var_.moveOldPos10175ui_story, var_307_39, var_307_38)

				local var_307_40 = manager.ui.mainCamera.transform.position - var_307_34.position

				var_307_34.forward = Vector3.New(var_307_40.x, var_307_40.y, var_307_40.z)

				local var_307_41 = var_307_34.localEulerAngles

				var_307_41.z = 0
				var_307_41.x = 0
				var_307_34.localEulerAngles = var_307_41
			end

			if arg_304_1.time_ >= var_307_35 + var_307_37 and arg_304_1.time_ < var_307_35 + var_307_37 + arg_307_0 then
				var_307_34.localPosition = Vector3.New(0, -1, -6.05)

				local var_307_42 = manager.ui.mainCamera.transform.position - var_307_34.position

				var_307_34.forward = Vector3.New(var_307_42.x, var_307_42.y, var_307_42.z)

				local var_307_43 = var_307_34.localEulerAngles

				var_307_43.z = 0
				var_307_43.x = 0
				var_307_34.localEulerAngles = var_307_43

				local var_307_44 = GameObjectTools.GetOrAddComponent(var_307_34.gameObject, typeof(DynamicBoneHelper))

				if var_307_44 then
					var_307_44:EnableDynamicBone(true)
				end
			end

			local var_307_45 = arg_304_1.actors_["10175ui_story"]
			local var_307_46 = 3.83333333333333

			if var_307_46 < arg_304_1.time_ and arg_304_1.time_ <= var_307_46 + arg_307_0 and not isNil(var_307_45) and arg_304_1.var_.characterEffect10175ui_story == nil then
				arg_304_1.var_.characterEffect10175ui_story = var_307_45:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_307_47 = 0.200000002980232

			if var_307_46 <= arg_304_1.time_ and arg_304_1.time_ < var_307_46 + var_307_47 and not isNil(var_307_45) then
				local var_307_48 = (arg_304_1.time_ - var_307_46) / var_307_47

				if arg_304_1.var_.characterEffect10175ui_story and not isNil(var_307_45) then
					arg_304_1.var_.characterEffect10175ui_story.fillFlat = false
				end
			end

			if arg_304_1.time_ >= var_307_46 + var_307_47 and arg_304_1.time_ < var_307_46 + var_307_47 + arg_307_0 and not isNil(var_307_45) and arg_304_1.var_.characterEffect10175ui_story then
				arg_304_1.var_.characterEffect10175ui_story.fillFlat = false
			end

			local var_307_49 = 3.83333333333333

			if var_307_49 < arg_304_1.time_ and arg_304_1.time_ <= var_307_49 + arg_307_0 then
				arg_304_1:PlayTimeline("10175ui_story", "StoryTimeline/CharAction/story10175/story10175action/10175action1_1")
			end

			local var_307_50 = 3.83333333333333

			if var_307_50 < arg_304_1.time_ and arg_304_1.time_ <= var_307_50 + arg_307_0 then
				arg_304_1:PlayTimeline("10175ui_story", "StoryTimeline/CharAction/public_expression/expr_shengqiA", "EmotionTimelineAnimator")
			end

			local var_307_51 = 0
			local var_307_52 = 1

			if var_307_51 < arg_304_1.time_ and arg_304_1.time_ <= var_307_51 + arg_307_0 then
				local var_307_53 = "play"
				local var_307_54 = "music"

				arg_304_1:AudioAction(var_307_53, var_307_54, "bgm_activity_4_8_story_dahuang_jianmenguan", "bgm_activity_4_8_story_dahuang_jianmenguan", "bgm_activity_4_8_story_dahuang_jianmenguan.awb")

				local var_307_55 = ""
				local var_307_56 = manager.audio:GetAudioName("bgm_activity_4_8_story_dahuang_jianmenguan", "bgm_activity_4_8_story_dahuang_jianmenguan")

				if var_307_56 ~= "" then
					if arg_304_1.bgmTxt_.text ~= var_307_56 and arg_304_1.bgmTxt_.text ~= "" then
						if arg_304_1.bgmTxt2_.text ~= "" then
							arg_304_1.bgmTxt_.text = arg_304_1.bgmTxt2_.text
						end

						arg_304_1.bgmTxt2_.text = var_307_56

						arg_304_1.musicChangeAnimator_:Play("music_change", 0, 0)
					else
						arg_304_1.bgmTxt_.text = var_307_56
						arg_304_1.bgmTxt2_.text = var_307_56
					end

					if arg_304_1.bgmTimer then
						arg_304_1.bgmTimer:Stop()

						arg_304_1.bgmTimer = nil
					end

					if arg_304_1.settingData.show_music_name == 1 then
						arg_304_1.musicController:SetSelectedState("show")
						arg_304_1.musicAnimator_:Play("open", 0, 0)

						if arg_304_1.settingData.music_time ~= 0 then
							arg_304_1.bgmTimer = TimeTools.StartAfterSeconds(tonumber(arg_304_1.settingData.music_time), function()
								if arg_304_1 == nil or isNil(arg_304_1.bgmTxt_) then
									return
								end

								arg_304_1.musicController:SetSelectedState("hide")
								arg_304_1.musicAnimator_:Play("back", 0, 0)
							end, {})
						end
					end
				end
			end

			if arg_304_1.frameCnt_ <= 1 then
				arg_304_1.dialog_:SetActive(false)
			end

			local var_307_57 = 4
			local var_307_58 = 0.725

			if var_307_57 < arg_304_1.time_ and arg_304_1.time_ <= var_307_57 + arg_307_0 then
				arg_304_1.talkMaxDuration = 0

				arg_304_1.dialog_:SetActive(true)

				arg_304_1.dialogCg_.alpha = 0

				local var_307_59 = LeanTween.value(arg_304_1.dialog_, 0, 1, 0.3)

				var_307_59:setOnUpdate(LuaHelper.FloatAction(function(arg_309_0)
					arg_304_1.dialogCg_.alpha = arg_309_0
				end))
				var_307_59:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_304_1.dialog_)
					var_307_59:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_304_1.duration_ = arg_304_1.duration_ + 0.3

				SetActive(arg_304_1.leftNameGo_, true)

				local var_307_60 = arg_304_1:FormatText(StoryNameCfg[1473].name)

				arg_304_1.leftNameTxt_.text = var_307_60

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_304_1.leftNameTxt_.transform)

				arg_304_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_304_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_304_1:RecordName(arg_304_1.leftNameTxt_.text)
				SetActive(arg_304_1.iconTrs_.gameObject, false)
				arg_304_1.callingController_:SetSelectedState("normal")

				local var_307_61 = arg_304_1:GetWordFromCfg(325591074)
				local var_307_62 = arg_304_1:FormatText(var_307_61.content)

				arg_304_1.text_.text = var_307_62

				LuaForUtil.ClearLinePrefixSymbol(arg_304_1.text_)

				local var_307_63 = 29
				local var_307_64 = utf8.len(var_307_62)
				local var_307_65 = var_307_63 <= 0 and var_307_58 or var_307_58 * (var_307_64 / var_307_63)

				if var_307_65 > 0 and var_307_58 < var_307_65 then
					arg_304_1.talkMaxDuration = var_307_65
					var_307_57 = var_307_57 + 0.3

					if var_307_65 + var_307_57 > arg_304_1.duration_ then
						arg_304_1.duration_ = var_307_65 + var_307_57
					end
				end

				arg_304_1.text_.text = var_307_62
				arg_304_1.typewritter.percent = 0

				arg_304_1.typewritter:SetDirty()
				arg_304_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_325591", "325591074", "story_v_out_325591.awb") ~= 0 then
					local var_307_66 = manager.audio:GetVoiceLength("story_v_out_325591", "325591074", "story_v_out_325591.awb") / 1000

					if var_307_66 + var_307_57 > arg_304_1.duration_ then
						arg_304_1.duration_ = var_307_66 + var_307_57
					end

					if var_307_61.prefab_name ~= "" and arg_304_1.actors_[var_307_61.prefab_name] ~= nil then
						local var_307_67 = LuaForUtil.PlayVoiceWithCriLipsync(arg_304_1.actors_[var_307_61.prefab_name].transform, "story_v_out_325591", "325591074", "story_v_out_325591.awb")

						arg_304_1:RecordAudio("325591074", var_307_67)
						arg_304_1:RecordAudio("325591074", var_307_67)
					else
						arg_304_1:AudioAction("play", "voice", "story_v_out_325591", "325591074", "story_v_out_325591.awb")
					end

					arg_304_1:RecordHistoryTalkVoice("story_v_out_325591", "325591074", "story_v_out_325591.awb")
				end

				arg_304_1:RecordContent(arg_304_1.text_.text)
			end

			local var_307_68 = var_307_57 + 0.3
			local var_307_69 = math.max(var_307_58, arg_304_1.talkMaxDuration)

			if var_307_68 <= arg_304_1.time_ and arg_304_1.time_ < var_307_68 + var_307_69 then
				arg_304_1.typewritter.percent = (arg_304_1.time_ - var_307_68) / var_307_69

				arg_304_1.typewritter:SetDirty()
			end

			if arg_304_1.time_ >= var_307_68 + var_307_69 and arg_304_1.time_ < var_307_68 + var_307_69 + arg_307_0 then
				arg_304_1.typewritter.percent = 1

				arg_304_1.typewritter:SetDirty()
				arg_304_1:ShowNextGo(true)
			end
		end

		arg_304_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10175ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 3.83333333333333,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_304_1:InitPlayNodeList()
	end,
	Play325591075 = function(arg_311_0, arg_311_1)
		arg_311_1.time_ = 0
		arg_311_1.frameCnt_ = 0
		arg_311_1.state_ = "playing"
		arg_311_1.curTalkId_ = 325591075
		arg_311_1.duration_ = 6.3

		local var_311_0 = {
			zh = 5.933,
			ja = 6.3
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
				arg_311_0:Play325591076(arg_311_1)
			end
		end

		function arg_311_1.onSingleLineUpdate_(arg_314_0)
			local var_314_0 = 0
			local var_314_1 = 0.675

			if var_314_0 < arg_311_1.time_ and arg_311_1.time_ <= var_314_0 + arg_314_0 then
				arg_311_1.talkMaxDuration = 0
				arg_311_1.dialogCg_.alpha = 1

				arg_311_1.dialog_:SetActive(true)
				SetActive(arg_311_1.leftNameGo_, true)

				local var_314_2 = arg_311_1:FormatText(StoryNameCfg[1473].name)

				arg_311_1.leftNameTxt_.text = var_314_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_311_1.leftNameTxt_.transform)

				arg_311_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_311_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_311_1:RecordName(arg_311_1.leftNameTxt_.text)
				SetActive(arg_311_1.iconTrs_.gameObject, false)
				arg_311_1.callingController_:SetSelectedState("normal")

				local var_314_3 = arg_311_1:GetWordFromCfg(325591075)
				local var_314_4 = arg_311_1:FormatText(var_314_3.content)

				arg_311_1.text_.text = var_314_4

				LuaForUtil.ClearLinePrefixSymbol(arg_311_1.text_)

				local var_314_5 = 27
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

				if manager.audio:GetVoiceLength("story_v_out_325591", "325591075", "story_v_out_325591.awb") ~= 0 then
					local var_314_8 = manager.audio:GetVoiceLength("story_v_out_325591", "325591075", "story_v_out_325591.awb") / 1000

					if var_314_8 + var_314_0 > arg_311_1.duration_ then
						arg_311_1.duration_ = var_314_8 + var_314_0
					end

					if var_314_3.prefab_name ~= "" and arg_311_1.actors_[var_314_3.prefab_name] ~= nil then
						local var_314_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_311_1.actors_[var_314_3.prefab_name].transform, "story_v_out_325591", "325591075", "story_v_out_325591.awb")

						arg_311_1:RecordAudio("325591075", var_314_9)
						arg_311_1:RecordAudio("325591075", var_314_9)
					else
						arg_311_1:AudioAction("play", "voice", "story_v_out_325591", "325591075", "story_v_out_325591.awb")
					end

					arg_311_1:RecordHistoryTalkVoice("story_v_out_325591", "325591075", "story_v_out_325591.awb")
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
	Play325591076 = function(arg_315_0, arg_315_1)
		arg_315_1.time_ = 0
		arg_315_1.frameCnt_ = 0
		arg_315_1.state_ = "playing"
		arg_315_1.curTalkId_ = 325591076
		arg_315_1.duration_ = 6.5

		local var_315_0 = {
			zh = 5.566,
			ja = 6.5
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
				arg_315_0:Play325591077(arg_315_1)
			end
		end

		function arg_315_1.onSingleLineUpdate_(arg_318_0)
			local var_318_0 = arg_315_1.actors_["10175ui_story"].transform
			local var_318_1 = 0

			if var_318_1 < arg_315_1.time_ and arg_315_1.time_ <= var_318_1 + arg_318_0 then
				arg_315_1.var_.moveOldPos10175ui_story = var_318_0.localPosition

				local var_318_2 = GameObjectTools.GetOrAddComponent(var_318_0.gameObject, typeof(DynamicBoneHelper))

				if var_318_2 then
					var_318_2:EnableDynamicBone(false)
				end
			end

			local var_318_3 = 0.001

			if var_318_1 <= arg_315_1.time_ and arg_315_1.time_ < var_318_1 + var_318_3 then
				local var_318_4 = (arg_315_1.time_ - var_318_1) / var_318_3
				local var_318_5 = Vector3.New(-0.7, -1, -6.05)

				var_318_0.localPosition = Vector3.Lerp(arg_315_1.var_.moveOldPos10175ui_story, var_318_5, var_318_4)

				local var_318_6 = manager.ui.mainCamera.transform.position - var_318_0.position

				var_318_0.forward = Vector3.New(var_318_6.x, var_318_6.y, var_318_6.z)

				local var_318_7 = var_318_0.localEulerAngles

				var_318_7.z = 0
				var_318_7.x = 0
				var_318_0.localEulerAngles = var_318_7
			end

			if arg_315_1.time_ >= var_318_1 + var_318_3 and arg_315_1.time_ < var_318_1 + var_318_3 + arg_318_0 then
				var_318_0.localPosition = Vector3.New(-0.7, -1, -6.05)

				local var_318_8 = manager.ui.mainCamera.transform.position - var_318_0.position

				var_318_0.forward = Vector3.New(var_318_8.x, var_318_8.y, var_318_8.z)

				local var_318_9 = var_318_0.localEulerAngles

				var_318_9.z = 0
				var_318_9.x = 0
				var_318_0.localEulerAngles = var_318_9

				local var_318_10 = GameObjectTools.GetOrAddComponent(var_318_0.gameObject, typeof(DynamicBoneHelper))

				if var_318_10 then
					var_318_10:EnableDynamicBone(true)
				end
			end

			local var_318_11 = arg_315_1.actors_["6148ui_story"].transform
			local var_318_12 = 0

			if var_318_12 < arg_315_1.time_ and arg_315_1.time_ <= var_318_12 + arg_318_0 then
				arg_315_1.var_.moveOldPos6148ui_story = var_318_11.localPosition

				local var_318_13 = GameObjectTools.GetOrAddComponent(var_318_11.gameObject, typeof(DynamicBoneHelper))

				if var_318_13 then
					var_318_13:EnableDynamicBone(false)
				end
			end

			local var_318_14 = 0.001

			if var_318_12 <= arg_315_1.time_ and arg_315_1.time_ < var_318_12 + var_318_14 then
				local var_318_15 = (arg_315_1.time_ - var_318_12) / var_318_14
				local var_318_16 = Vector3.New(0.7, -0.985, -6)

				var_318_11.localPosition = Vector3.Lerp(arg_315_1.var_.moveOldPos6148ui_story, var_318_16, var_318_15)

				local var_318_17 = manager.ui.mainCamera.transform.position - var_318_11.position

				var_318_11.forward = Vector3.New(var_318_17.x, var_318_17.y, var_318_17.z)

				local var_318_18 = var_318_11.localEulerAngles

				var_318_18.z = 0
				var_318_18.x = 0
				var_318_11.localEulerAngles = var_318_18
			end

			if arg_315_1.time_ >= var_318_12 + var_318_14 and arg_315_1.time_ < var_318_12 + var_318_14 + arg_318_0 then
				var_318_11.localPosition = Vector3.New(0.7, -0.985, -6)

				local var_318_19 = manager.ui.mainCamera.transform.position - var_318_11.position

				var_318_11.forward = Vector3.New(var_318_19.x, var_318_19.y, var_318_19.z)

				local var_318_20 = var_318_11.localEulerAngles

				var_318_20.z = 0
				var_318_20.x = 0
				var_318_11.localEulerAngles = var_318_20

				local var_318_21 = GameObjectTools.GetOrAddComponent(var_318_11.gameObject, typeof(DynamicBoneHelper))

				if var_318_21 then
					var_318_21:EnableDynamicBone(true)
				end
			end

			local var_318_22 = arg_315_1.actors_["6148ui_story"]
			local var_318_23 = 0

			if var_318_23 < arg_315_1.time_ and arg_315_1.time_ <= var_318_23 + arg_318_0 and not isNil(var_318_22) and arg_315_1.var_.characterEffect6148ui_story == nil then
				arg_315_1.var_.characterEffect6148ui_story = var_318_22:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_318_24 = 0.200000002980232

			if var_318_23 <= arg_315_1.time_ and arg_315_1.time_ < var_318_23 + var_318_24 and not isNil(var_318_22) then
				local var_318_25 = (arg_315_1.time_ - var_318_23) / var_318_24

				if arg_315_1.var_.characterEffect6148ui_story and not isNil(var_318_22) then
					arg_315_1.var_.characterEffect6148ui_story.fillFlat = false
				end
			end

			if arg_315_1.time_ >= var_318_23 + var_318_24 and arg_315_1.time_ < var_318_23 + var_318_24 + arg_318_0 and not isNil(var_318_22) and arg_315_1.var_.characterEffect6148ui_story then
				arg_315_1.var_.characterEffect6148ui_story.fillFlat = false
			end

			local var_318_26 = arg_315_1.actors_["10175ui_story"]
			local var_318_27 = 0

			if var_318_27 < arg_315_1.time_ and arg_315_1.time_ <= var_318_27 + arg_318_0 and not isNil(var_318_26) and arg_315_1.var_.characterEffect10175ui_story == nil then
				arg_315_1.var_.characterEffect10175ui_story = var_318_26:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_318_28 = 0.200000002980232

			if var_318_27 <= arg_315_1.time_ and arg_315_1.time_ < var_318_27 + var_318_28 and not isNil(var_318_26) then
				local var_318_29 = (arg_315_1.time_ - var_318_27) / var_318_28

				if arg_315_1.var_.characterEffect10175ui_story and not isNil(var_318_26) then
					local var_318_30 = Mathf.Lerp(0, 0.5, var_318_29)

					arg_315_1.var_.characterEffect10175ui_story.fillFlat = true
					arg_315_1.var_.characterEffect10175ui_story.fillRatio = var_318_30
				end
			end

			if arg_315_1.time_ >= var_318_27 + var_318_28 and arg_315_1.time_ < var_318_27 + var_318_28 + arg_318_0 and not isNil(var_318_26) and arg_315_1.var_.characterEffect10175ui_story then
				local var_318_31 = 0.5

				arg_315_1.var_.characterEffect10175ui_story.fillFlat = true
				arg_315_1.var_.characterEffect10175ui_story.fillRatio = var_318_31
			end

			local var_318_32 = 0

			if var_318_32 < arg_315_1.time_ and arg_315_1.time_ <= var_318_32 + arg_318_0 then
				arg_315_1:PlayTimeline("6148ui_story", "StoryTimeline/CharAction/story6148/story6148action/6148action1_1")
			end

			local var_318_33 = 0

			if var_318_33 < arg_315_1.time_ and arg_315_1.time_ <= var_318_33 + arg_318_0 then
				arg_315_1:PlayTimeline("6148ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0101cva", "EmotionTimelineAnimator")
			end

			local var_318_34 = 0
			local var_318_35 = 0.65

			if var_318_34 < arg_315_1.time_ and arg_315_1.time_ <= var_318_34 + arg_318_0 then
				arg_315_1.talkMaxDuration = 0
				arg_315_1.dialogCg_.alpha = 1

				arg_315_1.dialog_:SetActive(true)
				SetActive(arg_315_1.leftNameGo_, true)

				local var_318_36 = arg_315_1:FormatText(StoryNameCfg[1488].name)

				arg_315_1.leftNameTxt_.text = var_318_36

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_315_1.leftNameTxt_.transform)

				arg_315_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_315_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_315_1:RecordName(arg_315_1.leftNameTxt_.text)
				SetActive(arg_315_1.iconTrs_.gameObject, false)
				arg_315_1.callingController_:SetSelectedState("normal")

				local var_318_37 = arg_315_1:GetWordFromCfg(325591076)
				local var_318_38 = arg_315_1:FormatText(var_318_37.content)

				arg_315_1.text_.text = var_318_38

				LuaForUtil.ClearLinePrefixSymbol(arg_315_1.text_)

				local var_318_39 = 26
				local var_318_40 = utf8.len(var_318_38)
				local var_318_41 = var_318_39 <= 0 and var_318_35 or var_318_35 * (var_318_40 / var_318_39)

				if var_318_41 > 0 and var_318_35 < var_318_41 then
					arg_315_1.talkMaxDuration = var_318_41

					if var_318_41 + var_318_34 > arg_315_1.duration_ then
						arg_315_1.duration_ = var_318_41 + var_318_34
					end
				end

				arg_315_1.text_.text = var_318_38
				arg_315_1.typewritter.percent = 0

				arg_315_1.typewritter:SetDirty()
				arg_315_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_325591", "325591076", "story_v_out_325591.awb") ~= 0 then
					local var_318_42 = manager.audio:GetVoiceLength("story_v_out_325591", "325591076", "story_v_out_325591.awb") / 1000

					if var_318_42 + var_318_34 > arg_315_1.duration_ then
						arg_315_1.duration_ = var_318_42 + var_318_34
					end

					if var_318_37.prefab_name ~= "" and arg_315_1.actors_[var_318_37.prefab_name] ~= nil then
						local var_318_43 = LuaForUtil.PlayVoiceWithCriLipsync(arg_315_1.actors_[var_318_37.prefab_name].transform, "story_v_out_325591", "325591076", "story_v_out_325591.awb")

						arg_315_1:RecordAudio("325591076", var_318_43)
						arg_315_1:RecordAudio("325591076", var_318_43)
					else
						arg_315_1:AudioAction("play", "voice", "story_v_out_325591", "325591076", "story_v_out_325591.awb")
					end

					arg_315_1:RecordHistoryTalkVoice("story_v_out_325591", "325591076", "story_v_out_325591.awb")
				end

				arg_315_1:RecordContent(arg_315_1.text_.text)
			end

			local var_318_44 = math.max(var_318_35, arg_315_1.talkMaxDuration)

			if var_318_34 <= arg_315_1.time_ and arg_315_1.time_ < var_318_34 + var_318_44 then
				arg_315_1.typewritter.percent = (arg_315_1.time_ - var_318_34) / var_318_44

				arg_315_1.typewritter:SetDirty()
			end

			if arg_315_1.time_ >= var_318_34 + var_318_44 and arg_315_1.time_ < var_318_34 + var_318_44 + arg_318_0 then
				arg_315_1.typewritter.percent = 1

				arg_315_1.typewritter:SetDirty()
				arg_315_1:ShowNextGo(true)
			end
		end

		arg_315_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10175ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "6148ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_315_1:InitPlayNodeList()
	end,
	Play325591077 = function(arg_319_0, arg_319_1)
		arg_319_1.time_ = 0
		arg_319_1.frameCnt_ = 0
		arg_319_1.state_ = "playing"
		arg_319_1.curTalkId_ = 325591077
		arg_319_1.duration_ = 5

		SetActive(arg_319_1.tipsGo_, false)

		function arg_319_1.onSingleLineFinish_()
			arg_319_1.onSingleLineUpdate_ = nil
			arg_319_1.onSingleLineFinish_ = nil
			arg_319_1.state_ = "waiting"
		end

		function arg_319_1.playNext_(arg_321_0)
			if arg_321_0 == 1 then
				arg_319_0:Play325591078(arg_319_1)
			end
		end

		function arg_319_1.onSingleLineUpdate_(arg_322_0)
			local var_322_0 = arg_319_1.actors_["6148ui_story"].transform
			local var_322_1 = 0

			if var_322_1 < arg_319_1.time_ and arg_319_1.time_ <= var_322_1 + arg_322_0 then
				arg_319_1.var_.moveOldPos6148ui_story = var_322_0.localPosition

				local var_322_2 = GameObjectTools.GetOrAddComponent(var_322_0.gameObject, typeof(DynamicBoneHelper))

				if var_322_2 then
					var_322_2:EnableDynamicBone(false)
				end
			end

			local var_322_3 = 0.001

			if var_322_1 <= arg_319_1.time_ and arg_319_1.time_ < var_322_1 + var_322_3 then
				local var_322_4 = (arg_319_1.time_ - var_322_1) / var_322_3
				local var_322_5 = Vector3.New(0, 100, 0)

				var_322_0.localPosition = Vector3.Lerp(arg_319_1.var_.moveOldPos6148ui_story, var_322_5, var_322_4)

				local var_322_6 = manager.ui.mainCamera.transform.position - var_322_0.position

				var_322_0.forward = Vector3.New(var_322_6.x, var_322_6.y, var_322_6.z)

				local var_322_7 = var_322_0.localEulerAngles

				var_322_7.z = 0
				var_322_7.x = 0
				var_322_0.localEulerAngles = var_322_7
			end

			if arg_319_1.time_ >= var_322_1 + var_322_3 and arg_319_1.time_ < var_322_1 + var_322_3 + arg_322_0 then
				var_322_0.localPosition = Vector3.New(0, 100, 0)

				local var_322_8 = manager.ui.mainCamera.transform.position - var_322_0.position

				var_322_0.forward = Vector3.New(var_322_8.x, var_322_8.y, var_322_8.z)

				local var_322_9 = var_322_0.localEulerAngles

				var_322_9.z = 0
				var_322_9.x = 0
				var_322_0.localEulerAngles = var_322_9

				local var_322_10 = GameObjectTools.GetOrAddComponent(var_322_0.gameObject, typeof(DynamicBoneHelper))

				if var_322_10 then
					var_322_10:EnableDynamicBone(true)
				end
			end

			local var_322_11 = arg_319_1.actors_["10175ui_story"].transform
			local var_322_12 = 0

			if var_322_12 < arg_319_1.time_ and arg_319_1.time_ <= var_322_12 + arg_322_0 then
				arg_319_1.var_.moveOldPos10175ui_story = var_322_11.localPosition

				local var_322_13 = GameObjectTools.GetOrAddComponent(var_322_11.gameObject, typeof(DynamicBoneHelper))

				if var_322_13 then
					var_322_13:EnableDynamicBone(false)
				end
			end

			local var_322_14 = 0.001

			if var_322_12 <= arg_319_1.time_ and arg_319_1.time_ < var_322_12 + var_322_14 then
				local var_322_15 = (arg_319_1.time_ - var_322_12) / var_322_14
				local var_322_16 = Vector3.New(0, 100, 0)

				var_322_11.localPosition = Vector3.Lerp(arg_319_1.var_.moveOldPos10175ui_story, var_322_16, var_322_15)

				local var_322_17 = manager.ui.mainCamera.transform.position - var_322_11.position

				var_322_11.forward = Vector3.New(var_322_17.x, var_322_17.y, var_322_17.z)

				local var_322_18 = var_322_11.localEulerAngles

				var_322_18.z = 0
				var_322_18.x = 0
				var_322_11.localEulerAngles = var_322_18
			end

			if arg_319_1.time_ >= var_322_12 + var_322_14 and arg_319_1.time_ < var_322_12 + var_322_14 + arg_322_0 then
				var_322_11.localPosition = Vector3.New(0, 100, 0)

				local var_322_19 = manager.ui.mainCamera.transform.position - var_322_11.position

				var_322_11.forward = Vector3.New(var_322_19.x, var_322_19.y, var_322_19.z)

				local var_322_20 = var_322_11.localEulerAngles

				var_322_20.z = 0
				var_322_20.x = 0
				var_322_11.localEulerAngles = var_322_20

				local var_322_21 = GameObjectTools.GetOrAddComponent(var_322_11.gameObject, typeof(DynamicBoneHelper))

				if var_322_21 then
					var_322_21:EnableDynamicBone(true)
				end
			end

			local var_322_22 = arg_319_1.actors_["6148ui_story"]
			local var_322_23 = 0

			if var_322_23 < arg_319_1.time_ and arg_319_1.time_ <= var_322_23 + arg_322_0 and not isNil(var_322_22) and arg_319_1.var_.characterEffect6148ui_story == nil then
				arg_319_1.var_.characterEffect6148ui_story = var_322_22:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_322_24 = 0.200000002980232

			if var_322_23 <= arg_319_1.time_ and arg_319_1.time_ < var_322_23 + var_322_24 and not isNil(var_322_22) then
				local var_322_25 = (arg_319_1.time_ - var_322_23) / var_322_24

				if arg_319_1.var_.characterEffect6148ui_story and not isNil(var_322_22) then
					local var_322_26 = Mathf.Lerp(0, 0.5, var_322_25)

					arg_319_1.var_.characterEffect6148ui_story.fillFlat = true
					arg_319_1.var_.characterEffect6148ui_story.fillRatio = var_322_26
				end
			end

			if arg_319_1.time_ >= var_322_23 + var_322_24 and arg_319_1.time_ < var_322_23 + var_322_24 + arg_322_0 and not isNil(var_322_22) and arg_319_1.var_.characterEffect6148ui_story then
				local var_322_27 = 0.5

				arg_319_1.var_.characterEffect6148ui_story.fillFlat = true
				arg_319_1.var_.characterEffect6148ui_story.fillRatio = var_322_27
			end

			local var_322_28 = 0
			local var_322_29 = 1.3

			if var_322_28 < arg_319_1.time_ and arg_319_1.time_ <= var_322_28 + arg_322_0 then
				arg_319_1.talkMaxDuration = 0
				arg_319_1.dialogCg_.alpha = 1

				arg_319_1.dialog_:SetActive(true)
				SetActive(arg_319_1.leftNameGo_, false)

				arg_319_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_319_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_319_1:RecordName(arg_319_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_319_1.iconTrs_.gameObject, false)
				arg_319_1.callingController_:SetSelectedState("normal")

				local var_322_30 = arg_319_1:GetWordFromCfg(325591077)
				local var_322_31 = arg_319_1:FormatText(var_322_30.content)

				arg_319_1.text_.text = var_322_31

				LuaForUtil.ClearLinePrefixSymbol(arg_319_1.text_)

				local var_322_32 = 52
				local var_322_33 = utf8.len(var_322_31)
				local var_322_34 = var_322_32 <= 0 and var_322_29 or var_322_29 * (var_322_33 / var_322_32)

				if var_322_34 > 0 and var_322_29 < var_322_34 then
					arg_319_1.talkMaxDuration = var_322_34

					if var_322_34 + var_322_28 > arg_319_1.duration_ then
						arg_319_1.duration_ = var_322_34 + var_322_28
					end
				end

				arg_319_1.text_.text = var_322_31
				arg_319_1.typewritter.percent = 0

				arg_319_1.typewritter:SetDirty()
				arg_319_1:ShowNextGo(false)
				arg_319_1:RecordContent(arg_319_1.text_.text)
			end

			local var_322_35 = math.max(var_322_29, arg_319_1.talkMaxDuration)

			if var_322_28 <= arg_319_1.time_ and arg_319_1.time_ < var_322_28 + var_322_35 then
				arg_319_1.typewritter.percent = (arg_319_1.time_ - var_322_28) / var_322_35

				arg_319_1.typewritter:SetDirty()
			end

			if arg_319_1.time_ >= var_322_28 + var_322_35 and arg_319_1.time_ < var_322_28 + var_322_35 + arg_322_0 then
				arg_319_1.typewritter.percent = 1

				arg_319_1.typewritter:SetDirty()
				arg_319_1:ShowNextGo(true)
			end
		end

		arg_319_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "6148ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "10175ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_319_1:InitPlayNodeList()
	end,
	Play325591078 = function(arg_323_0, arg_323_1)
		arg_323_1.time_ = 0
		arg_323_1.frameCnt_ = 0
		arg_323_1.state_ = "playing"
		arg_323_1.curTalkId_ = 325591078
		arg_323_1.duration_ = 5.3

		local var_323_0 = {
			zh = 4.433,
			ja = 5.3
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
			arg_323_1.auto_ = false
		end

		function arg_323_1.playNext_(arg_325_0)
			arg_323_1.onStoryFinished_()
		end

		function arg_323_1.onSingleLineUpdate_(arg_326_0)
			local var_326_0 = arg_323_1.actors_["10175ui_story"].transform
			local var_326_1 = 0

			if var_326_1 < arg_323_1.time_ and arg_323_1.time_ <= var_326_1 + arg_326_0 then
				arg_323_1.var_.moveOldPos10175ui_story = var_326_0.localPosition

				local var_326_2 = GameObjectTools.GetOrAddComponent(var_326_0.gameObject, typeof(DynamicBoneHelper))

				if var_326_2 then
					var_326_2:EnableDynamicBone(false)
				end
			end

			local var_326_3 = 0.001

			if var_326_1 <= arg_323_1.time_ and arg_323_1.time_ < var_326_1 + var_326_3 then
				local var_326_4 = (arg_323_1.time_ - var_326_1) / var_326_3
				local var_326_5 = Vector3.New(0, -1, -6.05)

				var_326_0.localPosition = Vector3.Lerp(arg_323_1.var_.moveOldPos10175ui_story, var_326_5, var_326_4)

				local var_326_6 = manager.ui.mainCamera.transform.position - var_326_0.position

				var_326_0.forward = Vector3.New(var_326_6.x, var_326_6.y, var_326_6.z)

				local var_326_7 = var_326_0.localEulerAngles

				var_326_7.z = 0
				var_326_7.x = 0
				var_326_0.localEulerAngles = var_326_7
			end

			if arg_323_1.time_ >= var_326_1 + var_326_3 and arg_323_1.time_ < var_326_1 + var_326_3 + arg_326_0 then
				var_326_0.localPosition = Vector3.New(0, -1, -6.05)

				local var_326_8 = manager.ui.mainCamera.transform.position - var_326_0.position

				var_326_0.forward = Vector3.New(var_326_8.x, var_326_8.y, var_326_8.z)

				local var_326_9 = var_326_0.localEulerAngles

				var_326_9.z = 0
				var_326_9.x = 0
				var_326_0.localEulerAngles = var_326_9

				local var_326_10 = GameObjectTools.GetOrAddComponent(var_326_0.gameObject, typeof(DynamicBoneHelper))

				if var_326_10 then
					var_326_10:EnableDynamicBone(true)
				end
			end

			local var_326_11 = arg_323_1.actors_["10175ui_story"]
			local var_326_12 = 0

			if var_326_12 < arg_323_1.time_ and arg_323_1.time_ <= var_326_12 + arg_326_0 and not isNil(var_326_11) and arg_323_1.var_.characterEffect10175ui_story == nil then
				arg_323_1.var_.characterEffect10175ui_story = var_326_11:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_326_13 = 0.200000002980232

			if var_326_12 <= arg_323_1.time_ and arg_323_1.time_ < var_326_12 + var_326_13 and not isNil(var_326_11) then
				local var_326_14 = (arg_323_1.time_ - var_326_12) / var_326_13

				if arg_323_1.var_.characterEffect10175ui_story and not isNil(var_326_11) then
					arg_323_1.var_.characterEffect10175ui_story.fillFlat = false
				end
			end

			if arg_323_1.time_ >= var_326_12 + var_326_13 and arg_323_1.time_ < var_326_12 + var_326_13 + arg_326_0 and not isNil(var_326_11) and arg_323_1.var_.characterEffect10175ui_story then
				arg_323_1.var_.characterEffect10175ui_story.fillFlat = false
			end

			local var_326_15 = 0

			if var_326_15 < arg_323_1.time_ and arg_323_1.time_ <= var_326_15 + arg_326_0 then
				arg_323_1:PlayTimeline("10175ui_story", "StoryTimeline/CharAction/story10175/story10175action/10175action38_1")
			end

			local var_326_16 = 0

			if var_326_16 < arg_323_1.time_ and arg_323_1.time_ <= var_326_16 + arg_326_0 then
				arg_323_1:PlayTimeline("10175ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0101cva", "EmotionTimelineAnimator")
			end

			local var_326_17 = 0
			local var_326_18 = 1

			if var_326_17 < arg_323_1.time_ and arg_323_1.time_ <= var_326_17 + arg_326_0 then
				local var_326_19 = "play"
				local var_326_20 = "effect"

				arg_323_1:AudioAction(var_326_19, var_326_20, "ui_battle", "ui_battle_stopbgm", "")
			end

			local var_326_21 = 0
			local var_326_22 = 0.325

			if var_326_21 < arg_323_1.time_ and arg_323_1.time_ <= var_326_21 + arg_326_0 then
				arg_323_1.talkMaxDuration = 0
				arg_323_1.dialogCg_.alpha = 1

				arg_323_1.dialog_:SetActive(true)
				SetActive(arg_323_1.leftNameGo_, true)

				local var_326_23 = arg_323_1:FormatText(StoryNameCfg[1473].name)

				arg_323_1.leftNameTxt_.text = var_326_23

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_323_1.leftNameTxt_.transform)

				arg_323_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_323_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_323_1:RecordName(arg_323_1.leftNameTxt_.text)
				SetActive(arg_323_1.iconTrs_.gameObject, false)
				arg_323_1.callingController_:SetSelectedState("normal")

				local var_326_24 = arg_323_1:GetWordFromCfg(325591078)
				local var_326_25 = arg_323_1:FormatText(var_326_24.content)

				arg_323_1.text_.text = var_326_25

				LuaForUtil.ClearLinePrefixSymbol(arg_323_1.text_)

				local var_326_26 = 13
				local var_326_27 = utf8.len(var_326_25)
				local var_326_28 = var_326_26 <= 0 and var_326_22 or var_326_22 * (var_326_27 / var_326_26)

				if var_326_28 > 0 and var_326_22 < var_326_28 then
					arg_323_1.talkMaxDuration = var_326_28

					if var_326_28 + var_326_21 > arg_323_1.duration_ then
						arg_323_1.duration_ = var_326_28 + var_326_21
					end
				end

				arg_323_1.text_.text = var_326_25
				arg_323_1.typewritter.percent = 0

				arg_323_1.typewritter:SetDirty()
				arg_323_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_325591", "325591078", "story_v_out_325591.awb") ~= 0 then
					local var_326_29 = manager.audio:GetVoiceLength("story_v_out_325591", "325591078", "story_v_out_325591.awb") / 1000

					if var_326_29 + var_326_21 > arg_323_1.duration_ then
						arg_323_1.duration_ = var_326_29 + var_326_21
					end

					if var_326_24.prefab_name ~= "" and arg_323_1.actors_[var_326_24.prefab_name] ~= nil then
						local var_326_30 = LuaForUtil.PlayVoiceWithCriLipsync(arg_323_1.actors_[var_326_24.prefab_name].transform, "story_v_out_325591", "325591078", "story_v_out_325591.awb")

						arg_323_1:RecordAudio("325591078", var_326_30)
						arg_323_1:RecordAudio("325591078", var_326_30)
					else
						arg_323_1:AudioAction("play", "voice", "story_v_out_325591", "325591078", "story_v_out_325591.awb")
					end

					arg_323_1:RecordHistoryTalkVoice("story_v_out_325591", "325591078", "story_v_out_325591.awb")
				end

				arg_323_1:RecordContent(arg_323_1.text_.text)
			end

			local var_326_31 = math.max(var_326_22, arg_323_1.talkMaxDuration)

			if var_326_21 <= arg_323_1.time_ and arg_323_1.time_ < var_326_21 + var_326_31 then
				arg_323_1.typewritter.percent = (arg_323_1.time_ - var_326_21) / var_326_31

				arg_323_1.typewritter:SetDirty()
			end

			if arg_323_1.time_ >= var_326_21 + var_326_31 and arg_323_1.time_ < var_326_21 + var_326_31 + arg_326_0 then
				arg_323_1.typewritter.percent = 1

				arg_323_1.typewritter:SetDirty()
				arg_323_1:ShowNextGo(true)
			end
		end

		arg_323_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10175ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_323_1:InitPlayNodeList()
	end,
	assets = {
		"TextureConfig/Background/J28f",
		"TextureConfig/Background/J28h",
		"TextureConfig/Background/J26h"
	},
	voices = {
		"story_v_out_325591.awb"
	}
}
