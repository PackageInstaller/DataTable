return {
	Play325731001 = function(arg_1_0, arg_1_1)
		arg_1_1.time_ = 0
		arg_1_1.frameCnt_ = 0
		arg_1_1.state_ = "playing"
		arg_1_1.curTalkId_ = 325731001
		arg_1_1.duration_ = 7.6

		local var_1_0 = {
			zh = 7.266,
			ja = 7.6
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
				arg_1_0:Play325731002(arg_1_1)
			end
		end

		function arg_1_1.onSingleLineUpdate_(arg_4_0)
			local var_4_0 = "ST31"

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
				local var_4_5 = arg_1_1.bgs_.ST31

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
					if iter_4_0 ~= "ST31" then
						iter_4_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_4_16 = 0

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

			local var_4_24 = "1077ui_story"

			if arg_1_1.actors_[var_4_24] == nil then
				local var_4_25 = Asset.Load("Char/" .. "1077ui_story")

				if not isNil(var_4_25) then
					local var_4_26 = Object.Instantiate(Asset.Load("Char/" .. "1077ui_story"), arg_1_1.stage_.transform)

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

			local var_4_29 = arg_1_1.actors_["1077ui_story"].transform
			local var_4_30 = 1.8

			if var_4_30 < arg_1_1.time_ and arg_1_1.time_ <= var_4_30 + arg_4_0 then
				arg_1_1.var_.moveOldPos1077ui_story = var_4_29.localPosition

				local var_4_31 = GameObjectTools.GetOrAddComponent(var_4_29.gameObject, typeof(DynamicBoneHelper))

				if var_4_31 then
					var_4_31:EnableDynamicBone(false)
				end
			end

			local var_4_32 = 0.001

			if var_4_30 <= arg_1_1.time_ and arg_1_1.time_ < var_4_30 + var_4_32 then
				local var_4_33 = (arg_1_1.time_ - var_4_30) / var_4_32
				local var_4_34 = Vector3.New(-0.03, -1.02, -5.92)

				var_4_29.localPosition = Vector3.Lerp(arg_1_1.var_.moveOldPos1077ui_story, var_4_34, var_4_33)

				local var_4_35 = manager.ui.mainCamera.transform.position - var_4_29.position

				var_4_29.forward = Vector3.New(var_4_35.x, var_4_35.y, var_4_35.z)

				local var_4_36 = var_4_29.localEulerAngles

				var_4_36.z = 0
				var_4_36.x = 0
				var_4_29.localEulerAngles = var_4_36
			end

			if arg_1_1.time_ >= var_4_30 + var_4_32 and arg_1_1.time_ < var_4_30 + var_4_32 + arg_4_0 then
				var_4_29.localPosition = Vector3.New(-0.03, -1.02, -5.92)

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

			local var_4_40 = arg_1_1.actors_["1077ui_story"]
			local var_4_41 = 1.8

			if var_4_41 < arg_1_1.time_ and arg_1_1.time_ <= var_4_41 + arg_4_0 and not isNil(var_4_40) and arg_1_1.var_.characterEffect1077ui_story == nil then
				arg_1_1.var_.characterEffect1077ui_story = var_4_40:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_4_42 = 0.200000002980232

			if var_4_41 <= arg_1_1.time_ and arg_1_1.time_ < var_4_41 + var_4_42 and not isNil(var_4_40) then
				local var_4_43 = (arg_1_1.time_ - var_4_41) / var_4_42

				if arg_1_1.var_.characterEffect1077ui_story and not isNil(var_4_40) then
					arg_1_1.var_.characterEffect1077ui_story.fillFlat = false
				end
			end

			if arg_1_1.time_ >= var_4_41 + var_4_42 and arg_1_1.time_ < var_4_41 + var_4_42 + arg_4_0 and not isNil(var_4_40) and arg_1_1.var_.characterEffect1077ui_story then
				arg_1_1.var_.characterEffect1077ui_story.fillFlat = false
			end

			local var_4_44 = 1.8

			if var_4_44 < arg_1_1.time_ and arg_1_1.time_ <= var_4_44 + arg_4_0 then
				arg_1_1:PlayTimeline("1077ui_story", "StoryTimeline/CharAction/story1077/story1077action/1077action2_1")
			end

			local var_4_45 = 1.8

			if var_4_45 < arg_1_1.time_ and arg_1_1.time_ <= var_4_45 + arg_4_0 then
				arg_1_1:PlayTimeline("1077ui_story", "StoryTimeline/CharAction/public_expression/expr_renzhen", "EmotionTimelineAnimator")
			end

			local var_4_46 = 0.1
			local var_4_47 = 1

			if var_4_46 < arg_1_1.time_ and arg_1_1.time_ <= var_4_46 + arg_4_0 then
				local var_4_48 = "play"
				local var_4_49 = "effect"

				arg_1_1:AudioAction(var_4_48, var_4_49, "se_story_141", "se_story_141_amb_street_night02", "")
			end

			local var_4_50 = 0
			local var_4_51 = 1

			if var_4_50 < arg_1_1.time_ and arg_1_1.time_ <= var_4_50 + arg_4_0 then
				local var_4_52 = "play"
				local var_4_53 = "music"

				arg_1_1:AudioAction(var_4_52, var_4_53, "bgm_activity_5_0_story_xuheng_quiet", "bgm_activity_5_0_story_xuheng_quiet", "bgm_activity_5_0_story_xuheng_quiet.awb")

				local var_4_54 = ""
				local var_4_55 = manager.audio:GetAudioName("bgm_activity_5_0_story_xuheng_quiet", "bgm_activity_5_0_story_xuheng_quiet")

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

			local var_4_56 = 1.9
			local var_4_57 = 0.625

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

				local var_4_59 = arg_1_1:FormatText(StoryNameCfg[1467].name)

				arg_1_1.leftNameTxt_.text = var_4_59

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_1_1.leftNameTxt_.transform)

				arg_1_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_1_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_1_1:RecordName(arg_1_1.leftNameTxt_.text)
				SetActive(arg_1_1.iconTrs_.gameObject, false)
				arg_1_1.callingController_:SetSelectedState("normal")

				local var_4_60 = arg_1_1:GetWordFromCfg(325731001)
				local var_4_61 = arg_1_1:FormatText(var_4_60.content)

				arg_1_1.text_.text = var_4_61

				LuaForUtil.ClearLinePrefixSymbol(arg_1_1.text_)

				local var_4_62 = 25
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

				if manager.audio:GetVoiceLength("story_v_out_325731", "325731001", "story_v_out_325731.awb") ~= 0 then
					local var_4_65 = manager.audio:GetVoiceLength("story_v_out_325731", "325731001", "story_v_out_325731.awb") / 1000

					if var_4_65 + var_4_56 > arg_1_1.duration_ then
						arg_1_1.duration_ = var_4_65 + var_4_56
					end

					if var_4_60.prefab_name ~= "" and arg_1_1.actors_[var_4_60.prefab_name] ~= nil then
						local var_4_66 = LuaForUtil.PlayVoiceWithCriLipsync(arg_1_1.actors_[var_4_60.prefab_name].transform, "story_v_out_325731", "325731001", "story_v_out_325731.awb")

						arg_1_1:RecordAudio("325731001", var_4_66)
						arg_1_1:RecordAudio("325731001", var_4_66)
					else
						arg_1_1:AudioAction("play", "voice", "story_v_out_325731", "325731001", "story_v_out_325731.awb")
					end

					arg_1_1:RecordHistoryTalkVoice("story_v_out_325731", "325731001", "story_v_out_325731.awb")
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
				actorName = "1077ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 1.8,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_1_1:InitPlayNodeList()
	end,
	Play325731002 = function(arg_8_0, arg_8_1)
		arg_8_1.time_ = 0
		arg_8_1.frameCnt_ = 0
		arg_8_1.state_ = "playing"
		arg_8_1.curTalkId_ = 325731002
		arg_8_1.duration_ = 5

		SetActive(arg_8_1.tipsGo_, false)

		function arg_8_1.onSingleLineFinish_()
			arg_8_1.onSingleLineUpdate_ = nil
			arg_8_1.onSingleLineFinish_ = nil
			arg_8_1.state_ = "waiting"
		end

		function arg_8_1.playNext_(arg_10_0)
			if arg_10_0 == 1 then
				arg_8_0:Play325731003(arg_8_1)
			end
		end

		function arg_8_1.onSingleLineUpdate_(arg_11_0)
			local var_11_0 = arg_8_1.actors_["1077ui_story"].transform
			local var_11_1 = 0

			if var_11_1 < arg_8_1.time_ and arg_8_1.time_ <= var_11_1 + arg_11_0 then
				arg_8_1.var_.moveOldPos1077ui_story = var_11_0.localPosition

				local var_11_2 = GameObjectTools.GetOrAddComponent(var_11_0.gameObject, typeof(DynamicBoneHelper))

				if var_11_2 then
					var_11_2:EnableDynamicBone(false)
				end
			end

			local var_11_3 = 0.001

			if var_11_1 <= arg_8_1.time_ and arg_8_1.time_ < var_11_1 + var_11_3 then
				local var_11_4 = (arg_8_1.time_ - var_11_1) / var_11_3
				local var_11_5 = Vector3.New(0, 100, 0)

				var_11_0.localPosition = Vector3.Lerp(arg_8_1.var_.moveOldPos1077ui_story, var_11_5, var_11_4)

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

			local var_11_11 = arg_8_1.actors_["1077ui_story"]
			local var_11_12 = 0

			if var_11_12 < arg_8_1.time_ and arg_8_1.time_ <= var_11_12 + arg_11_0 and not isNil(var_11_11) and arg_8_1.var_.characterEffect1077ui_story == nil then
				arg_8_1.var_.characterEffect1077ui_story = var_11_11:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_11_13 = 0.200000002980232

			if var_11_12 <= arg_8_1.time_ and arg_8_1.time_ < var_11_12 + var_11_13 and not isNil(var_11_11) then
				local var_11_14 = (arg_8_1.time_ - var_11_12) / var_11_13

				if arg_8_1.var_.characterEffect1077ui_story and not isNil(var_11_11) then
					local var_11_15 = Mathf.Lerp(0, 0.5, var_11_14)

					arg_8_1.var_.characterEffect1077ui_story.fillFlat = true
					arg_8_1.var_.characterEffect1077ui_story.fillRatio = var_11_15
				end
			end

			if arg_8_1.time_ >= var_11_12 + var_11_13 and arg_8_1.time_ < var_11_12 + var_11_13 + arg_11_0 and not isNil(var_11_11) and arg_8_1.var_.characterEffect1077ui_story then
				local var_11_16 = 0.5

				arg_8_1.var_.characterEffect1077ui_story.fillFlat = true
				arg_8_1.var_.characterEffect1077ui_story.fillRatio = var_11_16
			end

			local var_11_17 = 0
			local var_11_18 = 0.575

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

				local var_11_19 = arg_8_1:GetWordFromCfg(325731002)
				local var_11_20 = arg_8_1:FormatText(var_11_19.content)

				arg_8_1.text_.text = var_11_20

				LuaForUtil.ClearLinePrefixSymbol(arg_8_1.text_)

				local var_11_21 = 23
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
				actorName = "1077ui_story",
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
	Play325731003 = function(arg_12_0, arg_12_1)
		arg_12_1.time_ = 0
		arg_12_1.frameCnt_ = 0
		arg_12_1.state_ = "playing"
		arg_12_1.curTalkId_ = 325731003
		arg_12_1.duration_ = 7.23

		local var_12_0 = {
			zh = 6.9,
			ja = 7.233
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
				arg_12_0:Play325731004(arg_12_1)
			end
		end

		function arg_12_1.onSingleLineUpdate_(arg_15_0)
			local var_15_0 = arg_12_1.actors_["1077ui_story"].transform
			local var_15_1 = 0

			if var_15_1 < arg_12_1.time_ and arg_12_1.time_ <= var_15_1 + arg_15_0 then
				arg_12_1.var_.moveOldPos1077ui_story = var_15_0.localPosition

				local var_15_2 = GameObjectTools.GetOrAddComponent(var_15_0.gameObject, typeof(DynamicBoneHelper))

				if var_15_2 then
					var_15_2:EnableDynamicBone(false)
				end
			end

			local var_15_3 = 0.001

			if var_15_1 <= arg_12_1.time_ and arg_12_1.time_ < var_15_1 + var_15_3 then
				local var_15_4 = (arg_12_1.time_ - var_15_1) / var_15_3
				local var_15_5 = Vector3.New(-0.03, -1.02, -5.92)

				var_15_0.localPosition = Vector3.Lerp(arg_12_1.var_.moveOldPos1077ui_story, var_15_5, var_15_4)

				local var_15_6 = manager.ui.mainCamera.transform.position - var_15_0.position

				var_15_0.forward = Vector3.New(var_15_6.x, var_15_6.y, var_15_6.z)

				local var_15_7 = var_15_0.localEulerAngles

				var_15_7.z = 0
				var_15_7.x = 0
				var_15_0.localEulerAngles = var_15_7
			end

			if arg_12_1.time_ >= var_15_1 + var_15_3 and arg_12_1.time_ < var_15_1 + var_15_3 + arg_15_0 then
				var_15_0.localPosition = Vector3.New(-0.03, -1.02, -5.92)

				local var_15_8 = manager.ui.mainCamera.transform.position - var_15_0.position

				var_15_0.forward = Vector3.New(var_15_8.x, var_15_8.y, var_15_8.z)

				local var_15_9 = var_15_0.localEulerAngles

				var_15_9.z = 0
				var_15_9.x = 0
				var_15_0.localEulerAngles = var_15_9

				local var_15_10 = GameObjectTools.GetOrAddComponent(var_15_0.gameObject, typeof(DynamicBoneHelper))

				if var_15_10 then
					var_15_10:EnableDynamicBone(true)
				end
			end

			local var_15_11 = arg_12_1.actors_["1077ui_story"]
			local var_15_12 = 0

			if var_15_12 < arg_12_1.time_ and arg_12_1.time_ <= var_15_12 + arg_15_0 and not isNil(var_15_11) and arg_12_1.var_.characterEffect1077ui_story == nil then
				arg_12_1.var_.characterEffect1077ui_story = var_15_11:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_15_13 = 0.200000002980232

			if var_15_12 <= arg_12_1.time_ and arg_12_1.time_ < var_15_12 + var_15_13 and not isNil(var_15_11) then
				local var_15_14 = (arg_12_1.time_ - var_15_12) / var_15_13

				if arg_12_1.var_.characterEffect1077ui_story and not isNil(var_15_11) then
					arg_12_1.var_.characterEffect1077ui_story.fillFlat = false
				end
			end

			if arg_12_1.time_ >= var_15_12 + var_15_13 and arg_12_1.time_ < var_15_12 + var_15_13 + arg_15_0 and not isNil(var_15_11) and arg_12_1.var_.characterEffect1077ui_story then
				arg_12_1.var_.characterEffect1077ui_story.fillFlat = false
			end

			local var_15_15 = 0

			if var_15_15 < arg_12_1.time_ and arg_12_1.time_ <= var_15_15 + arg_15_0 then
				arg_12_1:PlayTimeline("1077ui_story", "StoryTimeline/CharAction/story1077/story1077action/1077action2_2")
			end

			local var_15_16 = 0
			local var_15_17 = 0.6

			if var_15_16 < arg_12_1.time_ and arg_12_1.time_ <= var_15_16 + arg_15_0 then
				arg_12_1.talkMaxDuration = 0
				arg_12_1.dialogCg_.alpha = 1

				arg_12_1.dialog_:SetActive(true)
				SetActive(arg_12_1.leftNameGo_, true)

				local var_15_18 = arg_12_1:FormatText(StoryNameCfg[1467].name)

				arg_12_1.leftNameTxt_.text = var_15_18

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_12_1.leftNameTxt_.transform)

				arg_12_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_12_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_12_1:RecordName(arg_12_1.leftNameTxt_.text)
				SetActive(arg_12_1.iconTrs_.gameObject, false)
				arg_12_1.callingController_:SetSelectedState("normal")

				local var_15_19 = arg_12_1:GetWordFromCfg(325731003)
				local var_15_20 = arg_12_1:FormatText(var_15_19.content)

				arg_12_1.text_.text = var_15_20

				LuaForUtil.ClearLinePrefixSymbol(arg_12_1.text_)

				local var_15_21 = 24
				local var_15_22 = utf8.len(var_15_20)
				local var_15_23 = var_15_21 <= 0 and var_15_17 or var_15_17 * (var_15_22 / var_15_21)

				if var_15_23 > 0 and var_15_17 < var_15_23 then
					arg_12_1.talkMaxDuration = var_15_23

					if var_15_23 + var_15_16 > arg_12_1.duration_ then
						arg_12_1.duration_ = var_15_23 + var_15_16
					end
				end

				arg_12_1.text_.text = var_15_20
				arg_12_1.typewritter.percent = 0

				arg_12_1.typewritter:SetDirty()
				arg_12_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_325731", "325731003", "story_v_out_325731.awb") ~= 0 then
					local var_15_24 = manager.audio:GetVoiceLength("story_v_out_325731", "325731003", "story_v_out_325731.awb") / 1000

					if var_15_24 + var_15_16 > arg_12_1.duration_ then
						arg_12_1.duration_ = var_15_24 + var_15_16
					end

					if var_15_19.prefab_name ~= "" and arg_12_1.actors_[var_15_19.prefab_name] ~= nil then
						local var_15_25 = LuaForUtil.PlayVoiceWithCriLipsync(arg_12_1.actors_[var_15_19.prefab_name].transform, "story_v_out_325731", "325731003", "story_v_out_325731.awb")

						arg_12_1:RecordAudio("325731003", var_15_25)
						arg_12_1:RecordAudio("325731003", var_15_25)
					else
						arg_12_1:AudioAction("play", "voice", "story_v_out_325731", "325731003", "story_v_out_325731.awb")
					end

					arg_12_1:RecordHistoryTalkVoice("story_v_out_325731", "325731003", "story_v_out_325731.awb")
				end

				arg_12_1:RecordContent(arg_12_1.text_.text)
			end

			local var_15_26 = math.max(var_15_17, arg_12_1.talkMaxDuration)

			if var_15_16 <= arg_12_1.time_ and arg_12_1.time_ < var_15_16 + var_15_26 then
				arg_12_1.typewritter.percent = (arg_12_1.time_ - var_15_16) / var_15_26

				arg_12_1.typewritter:SetDirty()
			end

			if arg_12_1.time_ >= var_15_16 + var_15_26 and arg_12_1.time_ < var_15_16 + var_15_26 + arg_15_0 then
				arg_12_1.typewritter.percent = 1

				arg_12_1.typewritter:SetDirty()
				arg_12_1:ShowNextGo(true)
			end
		end

		arg_12_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1077ui_story",
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
	Play325731004 = function(arg_16_0, arg_16_1)
		arg_16_1.time_ = 0
		arg_16_1.frameCnt_ = 0
		arg_16_1.state_ = "playing"
		arg_16_1.curTalkId_ = 325731004
		arg_16_1.duration_ = 5

		SetActive(arg_16_1.tipsGo_, false)

		function arg_16_1.onSingleLineFinish_()
			arg_16_1.onSingleLineUpdate_ = nil
			arg_16_1.onSingleLineFinish_ = nil
			arg_16_1.state_ = "waiting"
		end

		function arg_16_1.playNext_(arg_18_0)
			if arg_18_0 == 1 then
				arg_16_0:Play325731005(arg_16_1)
			end
		end

		function arg_16_1.onSingleLineUpdate_(arg_19_0)
			local var_19_0 = arg_16_1.actors_["1077ui_story"].transform
			local var_19_1 = 0

			if var_19_1 < arg_16_1.time_ and arg_16_1.time_ <= var_19_1 + arg_19_0 then
				arg_16_1.var_.moveOldPos1077ui_story = var_19_0.localPosition

				local var_19_2 = GameObjectTools.GetOrAddComponent(var_19_0.gameObject, typeof(DynamicBoneHelper))

				if var_19_2 then
					var_19_2:EnableDynamicBone(false)
				end
			end

			local var_19_3 = 0.001

			if var_19_1 <= arg_16_1.time_ and arg_16_1.time_ < var_19_1 + var_19_3 then
				local var_19_4 = (arg_16_1.time_ - var_19_1) / var_19_3
				local var_19_5 = Vector3.New(0, 100, 0)

				var_19_0.localPosition = Vector3.Lerp(arg_16_1.var_.moveOldPos1077ui_story, var_19_5, var_19_4)

				local var_19_6 = manager.ui.mainCamera.transform.position - var_19_0.position

				var_19_0.forward = Vector3.New(var_19_6.x, var_19_6.y, var_19_6.z)

				local var_19_7 = var_19_0.localEulerAngles

				var_19_7.z = 0
				var_19_7.x = 0
				var_19_0.localEulerAngles = var_19_7
			end

			if arg_16_1.time_ >= var_19_1 + var_19_3 and arg_16_1.time_ < var_19_1 + var_19_3 + arg_19_0 then
				var_19_0.localPosition = Vector3.New(0, 100, 0)

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

			local var_19_11 = arg_16_1.actors_["1077ui_story"]
			local var_19_12 = 0

			if var_19_12 < arg_16_1.time_ and arg_16_1.time_ <= var_19_12 + arg_19_0 and not isNil(var_19_11) and arg_16_1.var_.characterEffect1077ui_story == nil then
				arg_16_1.var_.characterEffect1077ui_story = var_19_11:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_19_13 = 0.200000002980232

			if var_19_12 <= arg_16_1.time_ and arg_16_1.time_ < var_19_12 + var_19_13 and not isNil(var_19_11) then
				local var_19_14 = (arg_16_1.time_ - var_19_12) / var_19_13

				if arg_16_1.var_.characterEffect1077ui_story and not isNil(var_19_11) then
					local var_19_15 = Mathf.Lerp(0, 0.5, var_19_14)

					arg_16_1.var_.characterEffect1077ui_story.fillFlat = true
					arg_16_1.var_.characterEffect1077ui_story.fillRatio = var_19_15
				end
			end

			if arg_16_1.time_ >= var_19_12 + var_19_13 and arg_16_1.time_ < var_19_12 + var_19_13 + arg_19_0 and not isNil(var_19_11) and arg_16_1.var_.characterEffect1077ui_story then
				local var_19_16 = 0.5

				arg_16_1.var_.characterEffect1077ui_story.fillFlat = true
				arg_16_1.var_.characterEffect1077ui_story.fillRatio = var_19_16
			end

			local var_19_17 = 0
			local var_19_18 = 0.65

			if var_19_17 < arg_16_1.time_ and arg_16_1.time_ <= var_19_17 + arg_19_0 then
				arg_16_1.talkMaxDuration = 0
				arg_16_1.dialogCg_.alpha = 1

				arg_16_1.dialog_:SetActive(true)
				SetActive(arg_16_1.leftNameGo_, false)

				arg_16_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_16_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_16_1:RecordName(arg_16_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_16_1.iconTrs_.gameObject, false)
				arg_16_1.callingController_:SetSelectedState("normal")

				local var_19_19 = arg_16_1:GetWordFromCfg(325731004)
				local var_19_20 = arg_16_1:FormatText(var_19_19.content)

				arg_16_1.text_.text = var_19_20

				LuaForUtil.ClearLinePrefixSymbol(arg_16_1.text_)

				local var_19_21 = 26
				local var_19_22 = utf8.len(var_19_20)
				local var_19_23 = var_19_21 <= 0 and var_19_18 or var_19_18 * (var_19_22 / var_19_21)

				if var_19_23 > 0 and var_19_18 < var_19_23 then
					arg_16_1.talkMaxDuration = var_19_23

					if var_19_23 + var_19_17 > arg_16_1.duration_ then
						arg_16_1.duration_ = var_19_23 + var_19_17
					end
				end

				arg_16_1.text_.text = var_19_20
				arg_16_1.typewritter.percent = 0

				arg_16_1.typewritter:SetDirty()
				arg_16_1:ShowNextGo(false)
				arg_16_1:RecordContent(arg_16_1.text_.text)
			end

			local var_19_24 = math.max(var_19_18, arg_16_1.talkMaxDuration)

			if var_19_17 <= arg_16_1.time_ and arg_16_1.time_ < var_19_17 + var_19_24 then
				arg_16_1.typewritter.percent = (arg_16_1.time_ - var_19_17) / var_19_24

				arg_16_1.typewritter:SetDirty()
			end

			if arg_16_1.time_ >= var_19_17 + var_19_24 and arg_16_1.time_ < var_19_17 + var_19_24 + arg_19_0 then
				arg_16_1.typewritter.percent = 1

				arg_16_1.typewritter:SetDirty()
				arg_16_1:ShowNextGo(true)
			end
		end

		arg_16_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1077ui_story",
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
	Play325731005 = function(arg_20_0, arg_20_1)
		arg_20_1.time_ = 0
		arg_20_1.frameCnt_ = 0
		arg_20_1.state_ = "playing"
		arg_20_1.curTalkId_ = 325731005
		arg_20_1.duration_ = 7.52

		SetActive(arg_20_1.tipsGo_, false)

		function arg_20_1.onSingleLineFinish_()
			arg_20_1.onSingleLineUpdate_ = nil
			arg_20_1.onSingleLineFinish_ = nil
			arg_20_1.state_ = "waiting"
		end

		function arg_20_1.playNext_(arg_22_0)
			if arg_22_0 == 1 then
				arg_20_0:Play325731006(arg_20_1)
			end
		end

		function arg_20_1.onSingleLineUpdate_(arg_23_0)
			local var_23_0 = "ST40"

			if arg_20_1.bgs_[var_23_0] == nil then
				local var_23_1 = Object.Instantiate(arg_20_1.paintGo_)

				var_23_1:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. var_23_0)
				var_23_1.name = var_23_0
				var_23_1.transform.parent = arg_20_1.stage_.transform
				var_23_1.transform.localPosition = Vector3.New(0, 100, 0)
				arg_20_1.bgs_[var_23_0] = var_23_1
			end

			local var_23_2 = 1.39347279630601

			if var_23_2 < arg_20_1.time_ and arg_20_1.time_ <= var_23_2 + arg_23_0 then
				local var_23_3 = manager.ui.mainCamera.transform.localPosition
				local var_23_4 = Vector3.New(0, 0, 10) + Vector3.New(var_23_3.x, var_23_3.y, 0)
				local var_23_5 = arg_20_1.bgs_.ST40

				var_23_5.transform.localPosition = var_23_4
				var_23_5.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_23_6 = var_23_5:GetComponent("SpriteRenderer")

				if var_23_6 and var_23_6.sprite then
					local var_23_7 = (var_23_5.transform.localPosition - var_23_3).z
					local var_23_8 = manager.ui.mainCameraCom_
					local var_23_9 = 2 * var_23_7 * Mathf.Tan(var_23_8.fieldOfView * 0.5 * Mathf.Deg2Rad)
					local var_23_10 = var_23_9 * var_23_8.aspect
					local var_23_11 = var_23_6.sprite.bounds.size.x
					local var_23_12 = var_23_6.sprite.bounds.size.y
					local var_23_13 = var_23_10 / var_23_11
					local var_23_14 = var_23_9 / var_23_12
					local var_23_15 = var_23_14 < var_23_13 and var_23_13 or var_23_14

					var_23_5.transform.localScale = Vector3.New(var_23_15, var_23_15, 0)
				end

				for iter_23_0, iter_23_1 in pairs(arg_20_1.bgs_) do
					if iter_23_0 ~= "ST40" then
						iter_23_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_23_16 = 0

			if var_23_16 < arg_20_1.time_ and arg_20_1.time_ <= var_23_16 + arg_23_0 then
				arg_20_1.allBtn_.enabled = false
			end

			local var_23_17 = 0.3

			if arg_20_1.time_ >= var_23_16 + var_23_17 and arg_20_1.time_ < var_23_16 + var_23_17 + arg_23_0 then
				arg_20_1.allBtn_.enabled = true
			end

			local var_23_18 = 0

			if var_23_18 < arg_20_1.time_ and arg_20_1.time_ <= var_23_18 + arg_23_0 then
				arg_20_1.mask_.enabled = true
				arg_20_1.mask_.raycastTarget = true

				arg_20_1:SetGaussion(false)
			end

			local var_23_19 = 1.39347279630601

			if var_23_18 <= arg_20_1.time_ and arg_20_1.time_ < var_23_18 + var_23_19 then
				local var_23_20 = (arg_20_1.time_ - var_23_18) / var_23_19
				local var_23_21 = Color.New(0, 0, 0)

				var_23_21.a = Mathf.Lerp(0, 1, var_23_20)
				arg_20_1.mask_.color = var_23_21
			end

			if arg_20_1.time_ >= var_23_18 + var_23_19 and arg_20_1.time_ < var_23_18 + var_23_19 + arg_23_0 then
				local var_23_22 = Color.New(0, 0, 0)

				var_23_22.a = 1
				arg_20_1.mask_.color = var_23_22
			end

			local var_23_23 = 1.39347279630601

			if var_23_23 < arg_20_1.time_ and arg_20_1.time_ <= var_23_23 + arg_23_0 then
				arg_20_1.mask_.enabled = true
				arg_20_1.mask_.raycastTarget = true

				arg_20_1:SetGaussion(false)
			end

			local var_23_24 = 1.39347279630601

			if var_23_23 <= arg_20_1.time_ and arg_20_1.time_ < var_23_23 + var_23_24 then
				local var_23_25 = (arg_20_1.time_ - var_23_23) / var_23_24
				local var_23_26 = Color.New(0, 0, 0)

				var_23_26.a = Mathf.Lerp(1, 0, var_23_25)
				arg_20_1.mask_.color = var_23_26
			end

			if arg_20_1.time_ >= var_23_23 + var_23_24 and arg_20_1.time_ < var_23_23 + var_23_24 + arg_23_0 then
				local var_23_27 = Color.New(0, 0, 0)
				local var_23_28 = 0

				arg_20_1.mask_.enabled = false
				var_23_27.a = var_23_28
				arg_20_1.mask_.color = var_23_27
			end

			if arg_20_1.frameCnt_ <= 1 then
				arg_20_1.dialog_:SetActive(false)
			end

			local var_23_29 = 2.51847279630601
			local var_23_30 = 0.875

			if var_23_29 < arg_20_1.time_ and arg_20_1.time_ <= var_23_29 + arg_23_0 then
				arg_20_1.talkMaxDuration = 0

				arg_20_1.dialog_:SetActive(true)

				arg_20_1.dialogCg_.alpha = 0

				local var_23_31 = LeanTween.value(arg_20_1.dialog_, 0, 1, 0.3)

				var_23_31:setOnUpdate(LuaHelper.FloatAction(function(arg_24_0)
					arg_20_1.dialogCg_.alpha = arg_24_0
				end))
				var_23_31:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_20_1.dialog_)
					var_23_31:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_20_1.duration_ = arg_20_1.duration_ + 0.3

				SetActive(arg_20_1.leftNameGo_, false)

				arg_20_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_20_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_20_1:RecordName(arg_20_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_20_1.iconTrs_.gameObject, false)
				arg_20_1.callingController_:SetSelectedState("normal")

				local var_23_32 = arg_20_1:GetWordFromCfg(325731005)
				local var_23_33 = arg_20_1:FormatText(var_23_32.content)

				arg_20_1.text_.text = var_23_33

				LuaForUtil.ClearLinePrefixSymbol(arg_20_1.text_)

				local var_23_34 = 35
				local var_23_35 = utf8.len(var_23_33)
				local var_23_36 = var_23_34 <= 0 and var_23_30 or var_23_30 * (var_23_35 / var_23_34)

				if var_23_36 > 0 and var_23_30 < var_23_36 then
					arg_20_1.talkMaxDuration = var_23_36
					var_23_29 = var_23_29 + 0.3

					if var_23_36 + var_23_29 > arg_20_1.duration_ then
						arg_20_1.duration_ = var_23_36 + var_23_29
					end
				end

				arg_20_1.text_.text = var_23_33
				arg_20_1.typewritter.percent = 0

				arg_20_1.typewritter:SetDirty()
				arg_20_1:ShowNextGo(false)
				arg_20_1:RecordContent(arg_20_1.text_.text)
			end

			local var_23_37 = var_23_29 + 0.3
			local var_23_38 = math.max(var_23_30, arg_20_1.talkMaxDuration)

			if var_23_37 <= arg_20_1.time_ and arg_20_1.time_ < var_23_37 + var_23_38 then
				arg_20_1.typewritter.percent = (arg_20_1.time_ - var_23_37) / var_23_38

				arg_20_1.typewritter:SetDirty()
			end

			if arg_20_1.time_ >= var_23_37 + var_23_38 and arg_20_1.time_ < var_23_37 + var_23_38 + arg_23_0 then
				arg_20_1.typewritter.percent = 1

				arg_20_1.typewritter:SetDirty()
				arg_20_1:ShowNextGo(true)
			end
		end

		arg_20_1.nodeConfigList_ = {}

		arg_20_1:InitPlayNodeList()
	end,
	Play325731006 = function(arg_26_0, arg_26_1)
		arg_26_1.time_ = 0
		arg_26_1.frameCnt_ = 0
		arg_26_1.state_ = "playing"
		arg_26_1.curTalkId_ = 325731006
		arg_26_1.duration_ = 5

		SetActive(arg_26_1.tipsGo_, false)

		function arg_26_1.onSingleLineFinish_()
			arg_26_1.onSingleLineUpdate_ = nil
			arg_26_1.onSingleLineFinish_ = nil
			arg_26_1.state_ = "waiting"
		end

		function arg_26_1.playNext_(arg_28_0)
			if arg_28_0 == 1 then
				arg_26_0:Play325731007(arg_26_1)
			end
		end

		function arg_26_1.onSingleLineUpdate_(arg_29_0)
			local var_29_0 = 0
			local var_29_1 = 0.875

			if var_29_0 < arg_26_1.time_ and arg_26_1.time_ <= var_29_0 + arg_29_0 then
				arg_26_1.talkMaxDuration = 0
				arg_26_1.dialogCg_.alpha = 1

				arg_26_1.dialog_:SetActive(true)
				SetActive(arg_26_1.leftNameGo_, false)

				arg_26_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_26_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_26_1:RecordName(arg_26_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_26_1.iconTrs_.gameObject, false)
				arg_26_1.callingController_:SetSelectedState("normal")

				local var_29_2 = arg_26_1:GetWordFromCfg(325731006)
				local var_29_3 = arg_26_1:FormatText(var_29_2.content)

				arg_26_1.text_.text = var_29_3

				LuaForUtil.ClearLinePrefixSymbol(arg_26_1.text_)

				local var_29_4 = 35
				local var_29_5 = utf8.len(var_29_3)
				local var_29_6 = var_29_4 <= 0 and var_29_1 or var_29_1 * (var_29_5 / var_29_4)

				if var_29_6 > 0 and var_29_1 < var_29_6 then
					arg_26_1.talkMaxDuration = var_29_6

					if var_29_6 + var_29_0 > arg_26_1.duration_ then
						arg_26_1.duration_ = var_29_6 + var_29_0
					end
				end

				arg_26_1.text_.text = var_29_3
				arg_26_1.typewritter.percent = 0

				arg_26_1.typewritter:SetDirty()
				arg_26_1:ShowNextGo(false)
				arg_26_1:RecordContent(arg_26_1.text_.text)
			end

			local var_29_7 = math.max(var_29_1, arg_26_1.talkMaxDuration)

			if var_29_0 <= arg_26_1.time_ and arg_26_1.time_ < var_29_0 + var_29_7 then
				arg_26_1.typewritter.percent = (arg_26_1.time_ - var_29_0) / var_29_7

				arg_26_1.typewritter:SetDirty()
			end

			if arg_26_1.time_ >= var_29_0 + var_29_7 and arg_26_1.time_ < var_29_0 + var_29_7 + arg_29_0 then
				arg_26_1.typewritter.percent = 1

				arg_26_1.typewritter:SetDirty()
				arg_26_1:ShowNextGo(true)
			end
		end

		arg_26_1.nodeConfigList_ = {}

		arg_26_1:InitPlayNodeList()
	end,
	Play325731007 = function(arg_30_0, arg_30_1)
		arg_30_1.time_ = 0
		arg_30_1.frameCnt_ = 0
		arg_30_1.state_ = "playing"
		arg_30_1.curTalkId_ = 325731007
		arg_30_1.duration_ = 5.1

		local var_30_0 = {
			zh = 3.933,
			ja = 5.1
		}
		local var_30_1 = manager.audio:GetLocalizationFlag()

		if var_30_0[var_30_1] ~= nil then
			arg_30_1.duration_ = var_30_0[var_30_1]
		end

		SetActive(arg_30_1.tipsGo_, false)

		function arg_30_1.onSingleLineFinish_()
			arg_30_1.onSingleLineUpdate_ = nil
			arg_30_1.onSingleLineFinish_ = nil
			arg_30_1.state_ = "waiting"
		end

		function arg_30_1.playNext_(arg_32_0)
			if arg_32_0 == 1 then
				arg_30_0:Play325731008(arg_30_1)
			end
		end

		function arg_30_1.onSingleLineUpdate_(arg_33_0)
			local var_33_0 = 0
			local var_33_1 = 0.5

			if var_33_0 < arg_30_1.time_ and arg_30_1.time_ <= var_33_0 + arg_33_0 then
				arg_30_1.talkMaxDuration = 0
				arg_30_1.dialogCg_.alpha = 1

				arg_30_1.dialog_:SetActive(true)
				SetActive(arg_30_1.leftNameGo_, true)

				local var_33_2 = arg_30_1:FormatText(StoryNameCfg[999].name)

				arg_30_1.leftNameTxt_.text = var_33_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_30_1.leftNameTxt_.transform)

				arg_30_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_30_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_30_1:RecordName(arg_30_1.leftNameTxt_.text)
				SetActive(arg_30_1.iconTrs_.gameObject, true)
				arg_30_1.iconController_:SetSelectedState("hero")

				arg_30_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_xh_citizenmb")

				arg_30_1.callingController_:SetSelectedState("normal")

				arg_30_1.keyicon_.color = Color.New(1, 1, 1)
				arg_30_1.icon_.color = Color.New(1, 1, 1)

				local var_33_3 = arg_30_1:GetWordFromCfg(325731007)
				local var_33_4 = arg_30_1:FormatText(var_33_3.content)

				arg_30_1.text_.text = var_33_4

				LuaForUtil.ClearLinePrefixSymbol(arg_30_1.text_)

				local var_33_5 = 20
				local var_33_6 = utf8.len(var_33_4)
				local var_33_7 = var_33_5 <= 0 and var_33_1 or var_33_1 * (var_33_6 / var_33_5)

				if var_33_7 > 0 and var_33_1 < var_33_7 then
					arg_30_1.talkMaxDuration = var_33_7

					if var_33_7 + var_33_0 > arg_30_1.duration_ then
						arg_30_1.duration_ = var_33_7 + var_33_0
					end
				end

				arg_30_1.text_.text = var_33_4
				arg_30_1.typewritter.percent = 0

				arg_30_1.typewritter:SetDirty()
				arg_30_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_325731", "325731007", "story_v_out_325731.awb") ~= 0 then
					local var_33_8 = manager.audio:GetVoiceLength("story_v_out_325731", "325731007", "story_v_out_325731.awb") / 1000

					if var_33_8 + var_33_0 > arg_30_1.duration_ then
						arg_30_1.duration_ = var_33_8 + var_33_0
					end

					if var_33_3.prefab_name ~= "" and arg_30_1.actors_[var_33_3.prefab_name] ~= nil then
						local var_33_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_30_1.actors_[var_33_3.prefab_name].transform, "story_v_out_325731", "325731007", "story_v_out_325731.awb")

						arg_30_1:RecordAudio("325731007", var_33_9)
						arg_30_1:RecordAudio("325731007", var_33_9)
					else
						arg_30_1:AudioAction("play", "voice", "story_v_out_325731", "325731007", "story_v_out_325731.awb")
					end

					arg_30_1:RecordHistoryTalkVoice("story_v_out_325731", "325731007", "story_v_out_325731.awb")
				end

				arg_30_1:RecordContent(arg_30_1.text_.text)
			end

			local var_33_10 = math.max(var_33_1, arg_30_1.talkMaxDuration)

			if var_33_0 <= arg_30_1.time_ and arg_30_1.time_ < var_33_0 + var_33_10 then
				arg_30_1.typewritter.percent = (arg_30_1.time_ - var_33_0) / var_33_10

				arg_30_1.typewritter:SetDirty()
			end

			if arg_30_1.time_ >= var_33_0 + var_33_10 and arg_30_1.time_ < var_33_0 + var_33_10 + arg_33_0 then
				arg_30_1.typewritter.percent = 1

				arg_30_1.typewritter:SetDirty()
				arg_30_1:ShowNextGo(true)
			end
		end

		arg_30_1.nodeConfigList_ = {}

		arg_30_1:InitPlayNodeList()
	end,
	Play325731008 = function(arg_34_0, arg_34_1)
		arg_34_1.time_ = 0
		arg_34_1.frameCnt_ = 0
		arg_34_1.state_ = "playing"
		arg_34_1.curTalkId_ = 325731008
		arg_34_1.duration_ = 2.03

		local var_34_0 = {
			zh = 1.4,
			ja = 2.033
		}
		local var_34_1 = manager.audio:GetLocalizationFlag()

		if var_34_0[var_34_1] ~= nil then
			arg_34_1.duration_ = var_34_0[var_34_1]
		end

		SetActive(arg_34_1.tipsGo_, false)

		function arg_34_1.onSingleLineFinish_()
			arg_34_1.onSingleLineUpdate_ = nil
			arg_34_1.onSingleLineFinish_ = nil
			arg_34_1.state_ = "waiting"
		end

		function arg_34_1.playNext_(arg_36_0)
			if arg_36_0 == 1 then
				arg_34_0:Play325731009(arg_34_1)
			end
		end

		function arg_34_1.onSingleLineUpdate_(arg_37_0)
			local var_37_0 = arg_34_1.actors_["1077ui_story"].transform
			local var_37_1 = 0

			if var_37_1 < arg_34_1.time_ and arg_34_1.time_ <= var_37_1 + arg_37_0 then
				arg_34_1.var_.moveOldPos1077ui_story = var_37_0.localPosition

				local var_37_2 = GameObjectTools.GetOrAddComponent(var_37_0.gameObject, typeof(DynamicBoneHelper))

				if var_37_2 then
					var_37_2:EnableDynamicBone(false)
				end
			end

			local var_37_3 = 0.001

			if var_37_1 <= arg_34_1.time_ and arg_34_1.time_ < var_37_1 + var_37_3 then
				local var_37_4 = (arg_34_1.time_ - var_37_1) / var_37_3
				local var_37_5 = Vector3.New(-0.03, -1.02, -5.92)

				var_37_0.localPosition = Vector3.Lerp(arg_34_1.var_.moveOldPos1077ui_story, var_37_5, var_37_4)

				local var_37_6 = manager.ui.mainCamera.transform.position - var_37_0.position

				var_37_0.forward = Vector3.New(var_37_6.x, var_37_6.y, var_37_6.z)

				local var_37_7 = var_37_0.localEulerAngles

				var_37_7.z = 0
				var_37_7.x = 0
				var_37_0.localEulerAngles = var_37_7
			end

			if arg_34_1.time_ >= var_37_1 + var_37_3 and arg_34_1.time_ < var_37_1 + var_37_3 + arg_37_0 then
				var_37_0.localPosition = Vector3.New(-0.03, -1.02, -5.92)

				local var_37_8 = manager.ui.mainCamera.transform.position - var_37_0.position

				var_37_0.forward = Vector3.New(var_37_8.x, var_37_8.y, var_37_8.z)

				local var_37_9 = var_37_0.localEulerAngles

				var_37_9.z = 0
				var_37_9.x = 0
				var_37_0.localEulerAngles = var_37_9

				local var_37_10 = GameObjectTools.GetOrAddComponent(var_37_0.gameObject, typeof(DynamicBoneHelper))

				if var_37_10 then
					var_37_10:EnableDynamicBone(true)
				end
			end

			local var_37_11 = arg_34_1.actors_["1077ui_story"]
			local var_37_12 = 0

			if var_37_12 < arg_34_1.time_ and arg_34_1.time_ <= var_37_12 + arg_37_0 and not isNil(var_37_11) and arg_34_1.var_.characterEffect1077ui_story == nil then
				arg_34_1.var_.characterEffect1077ui_story = var_37_11:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_37_13 = 0.200000002980232

			if var_37_12 <= arg_34_1.time_ and arg_34_1.time_ < var_37_12 + var_37_13 and not isNil(var_37_11) then
				local var_37_14 = (arg_34_1.time_ - var_37_12) / var_37_13

				if arg_34_1.var_.characterEffect1077ui_story and not isNil(var_37_11) then
					arg_34_1.var_.characterEffect1077ui_story.fillFlat = false
				end
			end

			if arg_34_1.time_ >= var_37_12 + var_37_13 and arg_34_1.time_ < var_37_12 + var_37_13 + arg_37_0 and not isNil(var_37_11) and arg_34_1.var_.characterEffect1077ui_story then
				arg_34_1.var_.characterEffect1077ui_story.fillFlat = false
			end

			local var_37_15 = 0

			if var_37_15 < arg_34_1.time_ and arg_34_1.time_ <= var_37_15 + arg_37_0 then
				arg_34_1:PlayTimeline("1077ui_story", "StoryTimeline/CharAction/story1077/story1077action/1077action1_1")
			end

			local var_37_16 = 0

			if var_37_16 < arg_34_1.time_ and arg_34_1.time_ <= var_37_16 + arg_37_0 then
				arg_34_1:PlayTimeline("1077ui_story", "StoryTimeline/CharAction/public_expression/expr_kuaileA_weixiao", "EmotionTimelineAnimator")
			end

			local var_37_17 = 0
			local var_37_18 = 0.125

			if var_37_17 < arg_34_1.time_ and arg_34_1.time_ <= var_37_17 + arg_37_0 then
				arg_34_1.talkMaxDuration = 0
				arg_34_1.dialogCg_.alpha = 1

				arg_34_1.dialog_:SetActive(true)
				SetActive(arg_34_1.leftNameGo_, true)

				local var_37_19 = arg_34_1:FormatText(StoryNameCfg[1467].name)

				arg_34_1.leftNameTxt_.text = var_37_19

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_34_1.leftNameTxt_.transform)

				arg_34_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_34_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_34_1:RecordName(arg_34_1.leftNameTxt_.text)
				SetActive(arg_34_1.iconTrs_.gameObject, false)
				arg_34_1.callingController_:SetSelectedState("normal")

				local var_37_20 = arg_34_1:GetWordFromCfg(325731008)
				local var_37_21 = arg_34_1:FormatText(var_37_20.content)

				arg_34_1.text_.text = var_37_21

				LuaForUtil.ClearLinePrefixSymbol(arg_34_1.text_)

				local var_37_22 = 5
				local var_37_23 = utf8.len(var_37_21)
				local var_37_24 = var_37_22 <= 0 and var_37_18 or var_37_18 * (var_37_23 / var_37_22)

				if var_37_24 > 0 and var_37_18 < var_37_24 then
					arg_34_1.talkMaxDuration = var_37_24

					if var_37_24 + var_37_17 > arg_34_1.duration_ then
						arg_34_1.duration_ = var_37_24 + var_37_17
					end
				end

				arg_34_1.text_.text = var_37_21
				arg_34_1.typewritter.percent = 0

				arg_34_1.typewritter:SetDirty()
				arg_34_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_325731", "325731008", "story_v_out_325731.awb") ~= 0 then
					local var_37_25 = manager.audio:GetVoiceLength("story_v_out_325731", "325731008", "story_v_out_325731.awb") / 1000

					if var_37_25 + var_37_17 > arg_34_1.duration_ then
						arg_34_1.duration_ = var_37_25 + var_37_17
					end

					if var_37_20.prefab_name ~= "" and arg_34_1.actors_[var_37_20.prefab_name] ~= nil then
						local var_37_26 = LuaForUtil.PlayVoiceWithCriLipsync(arg_34_1.actors_[var_37_20.prefab_name].transform, "story_v_out_325731", "325731008", "story_v_out_325731.awb")

						arg_34_1:RecordAudio("325731008", var_37_26)
						arg_34_1:RecordAudio("325731008", var_37_26)
					else
						arg_34_1:AudioAction("play", "voice", "story_v_out_325731", "325731008", "story_v_out_325731.awb")
					end

					arg_34_1:RecordHistoryTalkVoice("story_v_out_325731", "325731008", "story_v_out_325731.awb")
				end

				arg_34_1:RecordContent(arg_34_1.text_.text)
			end

			local var_37_27 = math.max(var_37_18, arg_34_1.talkMaxDuration)

			if var_37_17 <= arg_34_1.time_ and arg_34_1.time_ < var_37_17 + var_37_27 then
				arg_34_1.typewritter.percent = (arg_34_1.time_ - var_37_17) / var_37_27

				arg_34_1.typewritter:SetDirty()
			end

			if arg_34_1.time_ >= var_37_17 + var_37_27 and arg_34_1.time_ < var_37_17 + var_37_27 + arg_37_0 then
				arg_34_1.typewritter.percent = 1

				arg_34_1.typewritter:SetDirty()
				arg_34_1:ShowNextGo(true)
			end
		end

		arg_34_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1077ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_34_1:InitPlayNodeList()
	end,
	Play325731009 = function(arg_38_0, arg_38_1)
		arg_38_1.time_ = 0
		arg_38_1.frameCnt_ = 0
		arg_38_1.state_ = "playing"
		arg_38_1.curTalkId_ = 325731009
		arg_38_1.duration_ = 3.9

		local var_38_0 = {
			zh = 3.9,
			ja = 3.066
		}
		local var_38_1 = manager.audio:GetLocalizationFlag()

		if var_38_0[var_38_1] ~= nil then
			arg_38_1.duration_ = var_38_0[var_38_1]
		end

		SetActive(arg_38_1.tipsGo_, false)

		function arg_38_1.onSingleLineFinish_()
			arg_38_1.onSingleLineUpdate_ = nil
			arg_38_1.onSingleLineFinish_ = nil
			arg_38_1.state_ = "waiting"
		end

		function arg_38_1.playNext_(arg_40_0)
			if arg_40_0 == 1 then
				arg_38_0:Play325731010(arg_38_1)
			end
		end

		function arg_38_1.onSingleLineUpdate_(arg_41_0)
			local var_41_0 = arg_38_1.actors_["1077ui_story"]
			local var_41_1 = 0

			if var_41_1 < arg_38_1.time_ and arg_38_1.time_ <= var_41_1 + arg_41_0 and not isNil(var_41_0) and arg_38_1.var_.characterEffect1077ui_story == nil then
				arg_38_1.var_.characterEffect1077ui_story = var_41_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_41_2 = 0.200000002980232

			if var_41_1 <= arg_38_1.time_ and arg_38_1.time_ < var_41_1 + var_41_2 and not isNil(var_41_0) then
				local var_41_3 = (arg_38_1.time_ - var_41_1) / var_41_2

				if arg_38_1.var_.characterEffect1077ui_story and not isNil(var_41_0) then
					local var_41_4 = Mathf.Lerp(0, 0.5, var_41_3)

					arg_38_1.var_.characterEffect1077ui_story.fillFlat = true
					arg_38_1.var_.characterEffect1077ui_story.fillRatio = var_41_4
				end
			end

			if arg_38_1.time_ >= var_41_1 + var_41_2 and arg_38_1.time_ < var_41_1 + var_41_2 + arg_41_0 and not isNil(var_41_0) and arg_38_1.var_.characterEffect1077ui_story then
				local var_41_5 = 0.5

				arg_38_1.var_.characterEffect1077ui_story.fillFlat = true
				arg_38_1.var_.characterEffect1077ui_story.fillRatio = var_41_5
			end

			local var_41_6 = 0
			local var_41_7 = 0.4

			if var_41_6 < arg_38_1.time_ and arg_38_1.time_ <= var_41_6 + arg_41_0 then
				arg_38_1.talkMaxDuration = 0
				arg_38_1.dialogCg_.alpha = 1

				arg_38_1.dialog_:SetActive(true)
				SetActive(arg_38_1.leftNameGo_, true)

				local var_41_8 = arg_38_1:FormatText(StoryNameCfg[999].name)

				arg_38_1.leftNameTxt_.text = var_41_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_38_1.leftNameTxt_.transform)

				arg_38_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_38_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_38_1:RecordName(arg_38_1.leftNameTxt_.text)
				SetActive(arg_38_1.iconTrs_.gameObject, true)
				arg_38_1.iconController_:SetSelectedState("hero")

				arg_38_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_xh_citizenmb")

				arg_38_1.callingController_:SetSelectedState("normal")

				arg_38_1.keyicon_.color = Color.New(1, 1, 1)
				arg_38_1.icon_.color = Color.New(1, 1, 1)

				local var_41_9 = arg_38_1:GetWordFromCfg(325731009)
				local var_41_10 = arg_38_1:FormatText(var_41_9.content)

				arg_38_1.text_.text = var_41_10

				LuaForUtil.ClearLinePrefixSymbol(arg_38_1.text_)

				local var_41_11 = 16
				local var_41_12 = utf8.len(var_41_10)
				local var_41_13 = var_41_11 <= 0 and var_41_7 or var_41_7 * (var_41_12 / var_41_11)

				if var_41_13 > 0 and var_41_7 < var_41_13 then
					arg_38_1.talkMaxDuration = var_41_13

					if var_41_13 + var_41_6 > arg_38_1.duration_ then
						arg_38_1.duration_ = var_41_13 + var_41_6
					end
				end

				arg_38_1.text_.text = var_41_10
				arg_38_1.typewritter.percent = 0

				arg_38_1.typewritter:SetDirty()
				arg_38_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_325731", "325731009", "story_v_out_325731.awb") ~= 0 then
					local var_41_14 = manager.audio:GetVoiceLength("story_v_out_325731", "325731009", "story_v_out_325731.awb") / 1000

					if var_41_14 + var_41_6 > arg_38_1.duration_ then
						arg_38_1.duration_ = var_41_14 + var_41_6
					end

					if var_41_9.prefab_name ~= "" and arg_38_1.actors_[var_41_9.prefab_name] ~= nil then
						local var_41_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_38_1.actors_[var_41_9.prefab_name].transform, "story_v_out_325731", "325731009", "story_v_out_325731.awb")

						arg_38_1:RecordAudio("325731009", var_41_15)
						arg_38_1:RecordAudio("325731009", var_41_15)
					else
						arg_38_1:AudioAction("play", "voice", "story_v_out_325731", "325731009", "story_v_out_325731.awb")
					end

					arg_38_1:RecordHistoryTalkVoice("story_v_out_325731", "325731009", "story_v_out_325731.awb")
				end

				arg_38_1:RecordContent(arg_38_1.text_.text)
			end

			local var_41_16 = math.max(var_41_7, arg_38_1.talkMaxDuration)

			if var_41_6 <= arg_38_1.time_ and arg_38_1.time_ < var_41_6 + var_41_16 then
				arg_38_1.typewritter.percent = (arg_38_1.time_ - var_41_6) / var_41_16

				arg_38_1.typewritter:SetDirty()
			end

			if arg_38_1.time_ >= var_41_6 + var_41_16 and arg_38_1.time_ < var_41_6 + var_41_16 + arg_41_0 then
				arg_38_1.typewritter.percent = 1

				arg_38_1.typewritter:SetDirty()
				arg_38_1:ShowNextGo(true)
			end
		end

		arg_38_1.nodeConfigList_ = {}

		arg_38_1:InitPlayNodeList()
	end,
	Play325731010 = function(arg_42_0, arg_42_1)
		arg_42_1.time_ = 0
		arg_42_1.frameCnt_ = 0
		arg_42_1.state_ = "playing"
		arg_42_1.curTalkId_ = 325731010
		arg_42_1.duration_ = 10.73

		local var_42_0 = {
			zh = 5.666,
			ja = 10.733
		}
		local var_42_1 = manager.audio:GetLocalizationFlag()

		if var_42_0[var_42_1] ~= nil then
			arg_42_1.duration_ = var_42_0[var_42_1]
		end

		SetActive(arg_42_1.tipsGo_, false)

		function arg_42_1.onSingleLineFinish_()
			arg_42_1.onSingleLineUpdate_ = nil
			arg_42_1.onSingleLineFinish_ = nil
			arg_42_1.state_ = "waiting"
		end

		function arg_42_1.playNext_(arg_44_0)
			if arg_44_0 == 1 then
				arg_42_0:Play325731011(arg_42_1)
			end
		end

		function arg_42_1.onSingleLineUpdate_(arg_45_0)
			local var_45_0 = 0
			local var_45_1 = 0.65

			if var_45_0 < arg_42_1.time_ and arg_42_1.time_ <= var_45_0 + arg_45_0 then
				arg_42_1.talkMaxDuration = 0
				arg_42_1.dialogCg_.alpha = 1

				arg_42_1.dialog_:SetActive(true)
				SetActive(arg_42_1.leftNameGo_, true)

				local var_45_2 = arg_42_1:FormatText(StoryNameCfg[999].name)

				arg_42_1.leftNameTxt_.text = var_45_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_42_1.leftNameTxt_.transform)

				arg_42_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_42_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_42_1:RecordName(arg_42_1.leftNameTxt_.text)
				SetActive(arg_42_1.iconTrs_.gameObject, true)
				arg_42_1.iconController_:SetSelectedState("hero")

				arg_42_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_xh_citizenmb")

				arg_42_1.callingController_:SetSelectedState("normal")

				arg_42_1.keyicon_.color = Color.New(1, 1, 1)
				arg_42_1.icon_.color = Color.New(1, 1, 1)

				local var_45_3 = arg_42_1:GetWordFromCfg(325731010)
				local var_45_4 = arg_42_1:FormatText(var_45_3.content)

				arg_42_1.text_.text = var_45_4

				LuaForUtil.ClearLinePrefixSymbol(arg_42_1.text_)

				local var_45_5 = 26
				local var_45_6 = utf8.len(var_45_4)
				local var_45_7 = var_45_5 <= 0 and var_45_1 or var_45_1 * (var_45_6 / var_45_5)

				if var_45_7 > 0 and var_45_1 < var_45_7 then
					arg_42_1.talkMaxDuration = var_45_7

					if var_45_7 + var_45_0 > arg_42_1.duration_ then
						arg_42_1.duration_ = var_45_7 + var_45_0
					end
				end

				arg_42_1.text_.text = var_45_4
				arg_42_1.typewritter.percent = 0

				arg_42_1.typewritter:SetDirty()
				arg_42_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_325731", "325731010", "story_v_out_325731.awb") ~= 0 then
					local var_45_8 = manager.audio:GetVoiceLength("story_v_out_325731", "325731010", "story_v_out_325731.awb") / 1000

					if var_45_8 + var_45_0 > arg_42_1.duration_ then
						arg_42_1.duration_ = var_45_8 + var_45_0
					end

					if var_45_3.prefab_name ~= "" and arg_42_1.actors_[var_45_3.prefab_name] ~= nil then
						local var_45_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_42_1.actors_[var_45_3.prefab_name].transform, "story_v_out_325731", "325731010", "story_v_out_325731.awb")

						arg_42_1:RecordAudio("325731010", var_45_9)
						arg_42_1:RecordAudio("325731010", var_45_9)
					else
						arg_42_1:AudioAction("play", "voice", "story_v_out_325731", "325731010", "story_v_out_325731.awb")
					end

					arg_42_1:RecordHistoryTalkVoice("story_v_out_325731", "325731010", "story_v_out_325731.awb")
				end

				arg_42_1:RecordContent(arg_42_1.text_.text)
			end

			local var_45_10 = math.max(var_45_1, arg_42_1.talkMaxDuration)

			if var_45_0 <= arg_42_1.time_ and arg_42_1.time_ < var_45_0 + var_45_10 then
				arg_42_1.typewritter.percent = (arg_42_1.time_ - var_45_0) / var_45_10

				arg_42_1.typewritter:SetDirty()
			end

			if arg_42_1.time_ >= var_45_0 + var_45_10 and arg_42_1.time_ < var_45_0 + var_45_10 + arg_45_0 then
				arg_42_1.typewritter.percent = 1

				arg_42_1.typewritter:SetDirty()
				arg_42_1:ShowNextGo(true)
			end
		end

		arg_42_1.nodeConfigList_ = {}

		arg_42_1:InitPlayNodeList()
	end,
	Play325731011 = function(arg_46_0, arg_46_1)
		arg_46_1.time_ = 0
		arg_46_1.frameCnt_ = 0
		arg_46_1.state_ = "playing"
		arg_46_1.curTalkId_ = 325731011
		arg_46_1.duration_ = 1.6

		local var_46_0 = {
			zh = 1.2,
			ja = 1.6
		}
		local var_46_1 = manager.audio:GetLocalizationFlag()

		if var_46_0[var_46_1] ~= nil then
			arg_46_1.duration_ = var_46_0[var_46_1]
		end

		SetActive(arg_46_1.tipsGo_, false)

		function arg_46_1.onSingleLineFinish_()
			arg_46_1.onSingleLineUpdate_ = nil
			arg_46_1.onSingleLineFinish_ = nil
			arg_46_1.state_ = "waiting"
		end

		function arg_46_1.playNext_(arg_48_0)
			if arg_48_0 == 1 then
				arg_46_0:Play325731012(arg_46_1)
			end
		end

		function arg_46_1.onSingleLineUpdate_(arg_49_0)
			local var_49_0 = arg_46_1.actors_["1077ui_story"]
			local var_49_1 = 0

			if var_49_1 < arg_46_1.time_ and arg_46_1.time_ <= var_49_1 + arg_49_0 and not isNil(var_49_0) and arg_46_1.var_.characterEffect1077ui_story == nil then
				arg_46_1.var_.characterEffect1077ui_story = var_49_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_49_2 = 0.200000002980232

			if var_49_1 <= arg_46_1.time_ and arg_46_1.time_ < var_49_1 + var_49_2 and not isNil(var_49_0) then
				local var_49_3 = (arg_46_1.time_ - var_49_1) / var_49_2

				if arg_46_1.var_.characterEffect1077ui_story and not isNil(var_49_0) then
					arg_46_1.var_.characterEffect1077ui_story.fillFlat = false
				end
			end

			if arg_46_1.time_ >= var_49_1 + var_49_2 and arg_46_1.time_ < var_49_1 + var_49_2 + arg_49_0 and not isNil(var_49_0) and arg_46_1.var_.characterEffect1077ui_story then
				arg_46_1.var_.characterEffect1077ui_story.fillFlat = false
			end

			local var_49_4 = 0
			local var_49_5 = 0.075

			if var_49_4 < arg_46_1.time_ and arg_46_1.time_ <= var_49_4 + arg_49_0 then
				arg_46_1.talkMaxDuration = 0
				arg_46_1.dialogCg_.alpha = 1

				arg_46_1.dialog_:SetActive(true)
				SetActive(arg_46_1.leftNameGo_, true)

				local var_49_6 = arg_46_1:FormatText(StoryNameCfg[1467].name)

				arg_46_1.leftNameTxt_.text = var_49_6

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_46_1.leftNameTxt_.transform)

				arg_46_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_46_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_46_1:RecordName(arg_46_1.leftNameTxt_.text)
				SetActive(arg_46_1.iconTrs_.gameObject, false)
				arg_46_1.callingController_:SetSelectedState("normal")

				local var_49_7 = arg_46_1:GetWordFromCfg(325731011)
				local var_49_8 = arg_46_1:FormatText(var_49_7.content)

				arg_46_1.text_.text = var_49_8

				LuaForUtil.ClearLinePrefixSymbol(arg_46_1.text_)

				local var_49_9 = 3
				local var_49_10 = utf8.len(var_49_8)
				local var_49_11 = var_49_9 <= 0 and var_49_5 or var_49_5 * (var_49_10 / var_49_9)

				if var_49_11 > 0 and var_49_5 < var_49_11 then
					arg_46_1.talkMaxDuration = var_49_11

					if var_49_11 + var_49_4 > arg_46_1.duration_ then
						arg_46_1.duration_ = var_49_11 + var_49_4
					end
				end

				arg_46_1.text_.text = var_49_8
				arg_46_1.typewritter.percent = 0

				arg_46_1.typewritter:SetDirty()
				arg_46_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_325731", "325731011", "story_v_out_325731.awb") ~= 0 then
					local var_49_12 = manager.audio:GetVoiceLength("story_v_out_325731", "325731011", "story_v_out_325731.awb") / 1000

					if var_49_12 + var_49_4 > arg_46_1.duration_ then
						arg_46_1.duration_ = var_49_12 + var_49_4
					end

					if var_49_7.prefab_name ~= "" and arg_46_1.actors_[var_49_7.prefab_name] ~= nil then
						local var_49_13 = LuaForUtil.PlayVoiceWithCriLipsync(arg_46_1.actors_[var_49_7.prefab_name].transform, "story_v_out_325731", "325731011", "story_v_out_325731.awb")

						arg_46_1:RecordAudio("325731011", var_49_13)
						arg_46_1:RecordAudio("325731011", var_49_13)
					else
						arg_46_1:AudioAction("play", "voice", "story_v_out_325731", "325731011", "story_v_out_325731.awb")
					end

					arg_46_1:RecordHistoryTalkVoice("story_v_out_325731", "325731011", "story_v_out_325731.awb")
				end

				arg_46_1:RecordContent(arg_46_1.text_.text)
			end

			local var_49_14 = math.max(var_49_5, arg_46_1.talkMaxDuration)

			if var_49_4 <= arg_46_1.time_ and arg_46_1.time_ < var_49_4 + var_49_14 then
				arg_46_1.typewritter.percent = (arg_46_1.time_ - var_49_4) / var_49_14

				arg_46_1.typewritter:SetDirty()
			end

			if arg_46_1.time_ >= var_49_4 + var_49_14 and arg_46_1.time_ < var_49_4 + var_49_14 + arg_49_0 then
				arg_46_1.typewritter.percent = 1

				arg_46_1.typewritter:SetDirty()
				arg_46_1:ShowNextGo(true)
			end
		end

		arg_46_1.nodeConfigList_ = {}

		arg_46_1:InitPlayNodeList()
	end,
	Play325731012 = function(arg_50_0, arg_50_1)
		arg_50_1.time_ = 0
		arg_50_1.frameCnt_ = 0
		arg_50_1.state_ = "playing"
		arg_50_1.curTalkId_ = 325731012
		arg_50_1.duration_ = 3.47

		local var_50_0 = {
			zh = 2.066,
			ja = 3.466
		}
		local var_50_1 = manager.audio:GetLocalizationFlag()

		if var_50_0[var_50_1] ~= nil then
			arg_50_1.duration_ = var_50_0[var_50_1]
		end

		SetActive(arg_50_1.tipsGo_, false)

		function arg_50_1.onSingleLineFinish_()
			arg_50_1.onSingleLineUpdate_ = nil
			arg_50_1.onSingleLineFinish_ = nil
			arg_50_1.state_ = "waiting"
		end

		function arg_50_1.playNext_(arg_52_0)
			if arg_52_0 == 1 then
				arg_50_0:Play325731013(arg_50_1)
			end
		end

		function arg_50_1.onSingleLineUpdate_(arg_53_0)
			local var_53_0 = arg_50_1.actors_["1077ui_story"]
			local var_53_1 = 0

			if var_53_1 < arg_50_1.time_ and arg_50_1.time_ <= var_53_1 + arg_53_0 and not isNil(var_53_0) and arg_50_1.var_.characterEffect1077ui_story == nil then
				arg_50_1.var_.characterEffect1077ui_story = var_53_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_53_2 = 0.200000002980232

			if var_53_1 <= arg_50_1.time_ and arg_50_1.time_ < var_53_1 + var_53_2 and not isNil(var_53_0) then
				local var_53_3 = (arg_50_1.time_ - var_53_1) / var_53_2

				if arg_50_1.var_.characterEffect1077ui_story and not isNil(var_53_0) then
					local var_53_4 = Mathf.Lerp(0, 0.5, var_53_3)

					arg_50_1.var_.characterEffect1077ui_story.fillFlat = true
					arg_50_1.var_.characterEffect1077ui_story.fillRatio = var_53_4
				end
			end

			if arg_50_1.time_ >= var_53_1 + var_53_2 and arg_50_1.time_ < var_53_1 + var_53_2 + arg_53_0 and not isNil(var_53_0) and arg_50_1.var_.characterEffect1077ui_story then
				local var_53_5 = 0.5

				arg_50_1.var_.characterEffect1077ui_story.fillFlat = true
				arg_50_1.var_.characterEffect1077ui_story.fillRatio = var_53_5
			end

			local var_53_6 = 0
			local var_53_7 = 0.175

			if var_53_6 < arg_50_1.time_ and arg_50_1.time_ <= var_53_6 + arg_53_0 then
				arg_50_1.talkMaxDuration = 0
				arg_50_1.dialogCg_.alpha = 1

				arg_50_1.dialog_:SetActive(true)
				SetActive(arg_50_1.leftNameGo_, true)

				local var_53_8 = arg_50_1:FormatText(StoryNameCfg[999].name)

				arg_50_1.leftNameTxt_.text = var_53_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_50_1.leftNameTxt_.transform)

				arg_50_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_50_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_50_1:RecordName(arg_50_1.leftNameTxt_.text)
				SetActive(arg_50_1.iconTrs_.gameObject, true)
				arg_50_1.iconController_:SetSelectedState("hero")

				arg_50_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_xh_citizenmb")

				arg_50_1.callingController_:SetSelectedState("normal")

				arg_50_1.keyicon_.color = Color.New(1, 1, 1)
				arg_50_1.icon_.color = Color.New(1, 1, 1)

				local var_53_9 = arg_50_1:GetWordFromCfg(325731012)
				local var_53_10 = arg_50_1:FormatText(var_53_9.content)

				arg_50_1.text_.text = var_53_10

				LuaForUtil.ClearLinePrefixSymbol(arg_50_1.text_)

				local var_53_11 = 7
				local var_53_12 = utf8.len(var_53_10)
				local var_53_13 = var_53_11 <= 0 and var_53_7 or var_53_7 * (var_53_12 / var_53_11)

				if var_53_13 > 0 and var_53_7 < var_53_13 then
					arg_50_1.talkMaxDuration = var_53_13

					if var_53_13 + var_53_6 > arg_50_1.duration_ then
						arg_50_1.duration_ = var_53_13 + var_53_6
					end
				end

				arg_50_1.text_.text = var_53_10
				arg_50_1.typewritter.percent = 0

				arg_50_1.typewritter:SetDirty()
				arg_50_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_325731", "325731012", "story_v_out_325731.awb") ~= 0 then
					local var_53_14 = manager.audio:GetVoiceLength("story_v_out_325731", "325731012", "story_v_out_325731.awb") / 1000

					if var_53_14 + var_53_6 > arg_50_1.duration_ then
						arg_50_1.duration_ = var_53_14 + var_53_6
					end

					if var_53_9.prefab_name ~= "" and arg_50_1.actors_[var_53_9.prefab_name] ~= nil then
						local var_53_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_50_1.actors_[var_53_9.prefab_name].transform, "story_v_out_325731", "325731012", "story_v_out_325731.awb")

						arg_50_1:RecordAudio("325731012", var_53_15)
						arg_50_1:RecordAudio("325731012", var_53_15)
					else
						arg_50_1:AudioAction("play", "voice", "story_v_out_325731", "325731012", "story_v_out_325731.awb")
					end

					arg_50_1:RecordHistoryTalkVoice("story_v_out_325731", "325731012", "story_v_out_325731.awb")
				end

				arg_50_1:RecordContent(arg_50_1.text_.text)
			end

			local var_53_16 = math.max(var_53_7, arg_50_1.talkMaxDuration)

			if var_53_6 <= arg_50_1.time_ and arg_50_1.time_ < var_53_6 + var_53_16 then
				arg_50_1.typewritter.percent = (arg_50_1.time_ - var_53_6) / var_53_16

				arg_50_1.typewritter:SetDirty()
			end

			if arg_50_1.time_ >= var_53_6 + var_53_16 and arg_50_1.time_ < var_53_6 + var_53_16 + arg_53_0 then
				arg_50_1.typewritter.percent = 1

				arg_50_1.typewritter:SetDirty()
				arg_50_1:ShowNextGo(true)
			end
		end

		arg_50_1.nodeConfigList_ = {}

		arg_50_1:InitPlayNodeList()
	end,
	Play325731013 = function(arg_54_0, arg_54_1)
		arg_54_1.time_ = 0
		arg_54_1.frameCnt_ = 0
		arg_54_1.state_ = "playing"
		arg_54_1.curTalkId_ = 325731013
		arg_54_1.duration_ = 2.67

		local var_54_0 = {
			zh = 2.266,
			ja = 2.666
		}
		local var_54_1 = manager.audio:GetLocalizationFlag()

		if var_54_0[var_54_1] ~= nil then
			arg_54_1.duration_ = var_54_0[var_54_1]
		end

		SetActive(arg_54_1.tipsGo_, false)

		function arg_54_1.onSingleLineFinish_()
			arg_54_1.onSingleLineUpdate_ = nil
			arg_54_1.onSingleLineFinish_ = nil
			arg_54_1.state_ = "waiting"
		end

		function arg_54_1.playNext_(arg_56_0)
			if arg_56_0 == 1 then
				arg_54_0:Play325731014(arg_54_1)
			end
		end

		function arg_54_1.onSingleLineUpdate_(arg_57_0)
			local var_57_0 = arg_54_1.actors_["1077ui_story"]
			local var_57_1 = 0

			if var_57_1 < arg_54_1.time_ and arg_54_1.time_ <= var_57_1 + arg_57_0 and not isNil(var_57_0) and arg_54_1.var_.characterEffect1077ui_story == nil then
				arg_54_1.var_.characterEffect1077ui_story = var_57_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_57_2 = 0.200000002980232

			if var_57_1 <= arg_54_1.time_ and arg_54_1.time_ < var_57_1 + var_57_2 and not isNil(var_57_0) then
				local var_57_3 = (arg_54_1.time_ - var_57_1) / var_57_2

				if arg_54_1.var_.characterEffect1077ui_story and not isNil(var_57_0) then
					arg_54_1.var_.characterEffect1077ui_story.fillFlat = false
				end
			end

			if arg_54_1.time_ >= var_57_1 + var_57_2 and arg_54_1.time_ < var_57_1 + var_57_2 + arg_57_0 and not isNil(var_57_0) and arg_54_1.var_.characterEffect1077ui_story then
				arg_54_1.var_.characterEffect1077ui_story.fillFlat = false
			end

			local var_57_4 = 0

			if var_57_4 < arg_54_1.time_ and arg_54_1.time_ <= var_57_4 + arg_57_0 then
				arg_54_1:PlayTimeline("1077ui_story", "StoryTimeline/CharAction/story1077/story1077action/1077action6_1")
			end

			local var_57_5 = 0

			if var_57_5 < arg_54_1.time_ and arg_54_1.time_ <= var_57_5 + arg_57_0 then
				arg_54_1:PlayTimeline("1077ui_story", "StoryTimeline/CharAction/public_expression/expr_kuaileA_weixiao", "EmotionTimelineAnimator")
			end

			local var_57_6 = 0
			local var_57_7 = 0.25

			if var_57_6 < arg_54_1.time_ and arg_54_1.time_ <= var_57_6 + arg_57_0 then
				arg_54_1.talkMaxDuration = 0
				arg_54_1.dialogCg_.alpha = 1

				arg_54_1.dialog_:SetActive(true)
				SetActive(arg_54_1.leftNameGo_, true)

				local var_57_8 = arg_54_1:FormatText(StoryNameCfg[1467].name)

				arg_54_1.leftNameTxt_.text = var_57_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_54_1.leftNameTxt_.transform)

				arg_54_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_54_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_54_1:RecordName(arg_54_1.leftNameTxt_.text)
				SetActive(arg_54_1.iconTrs_.gameObject, false)
				arg_54_1.callingController_:SetSelectedState("normal")

				local var_57_9 = arg_54_1:GetWordFromCfg(325731013)
				local var_57_10 = arg_54_1:FormatText(var_57_9.content)

				arg_54_1.text_.text = var_57_10

				LuaForUtil.ClearLinePrefixSymbol(arg_54_1.text_)

				local var_57_11 = 10
				local var_57_12 = utf8.len(var_57_10)
				local var_57_13 = var_57_11 <= 0 and var_57_7 or var_57_7 * (var_57_12 / var_57_11)

				if var_57_13 > 0 and var_57_7 < var_57_13 then
					arg_54_1.talkMaxDuration = var_57_13

					if var_57_13 + var_57_6 > arg_54_1.duration_ then
						arg_54_1.duration_ = var_57_13 + var_57_6
					end
				end

				arg_54_1.text_.text = var_57_10
				arg_54_1.typewritter.percent = 0

				arg_54_1.typewritter:SetDirty()
				arg_54_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_325731", "325731013", "story_v_out_325731.awb") ~= 0 then
					local var_57_14 = manager.audio:GetVoiceLength("story_v_out_325731", "325731013", "story_v_out_325731.awb") / 1000

					if var_57_14 + var_57_6 > arg_54_1.duration_ then
						arg_54_1.duration_ = var_57_14 + var_57_6
					end

					if var_57_9.prefab_name ~= "" and arg_54_1.actors_[var_57_9.prefab_name] ~= nil then
						local var_57_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_54_1.actors_[var_57_9.prefab_name].transform, "story_v_out_325731", "325731013", "story_v_out_325731.awb")

						arg_54_1:RecordAudio("325731013", var_57_15)
						arg_54_1:RecordAudio("325731013", var_57_15)
					else
						arg_54_1:AudioAction("play", "voice", "story_v_out_325731", "325731013", "story_v_out_325731.awb")
					end

					arg_54_1:RecordHistoryTalkVoice("story_v_out_325731", "325731013", "story_v_out_325731.awb")
				end

				arg_54_1:RecordContent(arg_54_1.text_.text)
			end

			local var_57_16 = math.max(var_57_7, arg_54_1.talkMaxDuration)

			if var_57_6 <= arg_54_1.time_ and arg_54_1.time_ < var_57_6 + var_57_16 then
				arg_54_1.typewritter.percent = (arg_54_1.time_ - var_57_6) / var_57_16

				arg_54_1.typewritter:SetDirty()
			end

			if arg_54_1.time_ >= var_57_6 + var_57_16 and arg_54_1.time_ < var_57_6 + var_57_16 + arg_57_0 then
				arg_54_1.typewritter.percent = 1

				arg_54_1.typewritter:SetDirty()
				arg_54_1:ShowNextGo(true)
			end
		end

		arg_54_1.nodeConfigList_ = {}

		arg_54_1:InitPlayNodeList()
	end,
	Play325731014 = function(arg_58_0, arg_58_1)
		arg_58_1.time_ = 0
		arg_58_1.frameCnt_ = 0
		arg_58_1.state_ = "playing"
		arg_58_1.curTalkId_ = 325731014
		arg_58_1.duration_ = 7.4

		local var_58_0 = {
			zh = 7.366,
			ja = 7.4
		}
		local var_58_1 = manager.audio:GetLocalizationFlag()

		if var_58_0[var_58_1] ~= nil then
			arg_58_1.duration_ = var_58_0[var_58_1]
		end

		SetActive(arg_58_1.tipsGo_, false)

		function arg_58_1.onSingleLineFinish_()
			arg_58_1.onSingleLineUpdate_ = nil
			arg_58_1.onSingleLineFinish_ = nil
			arg_58_1.state_ = "waiting"
		end

		function arg_58_1.playNext_(arg_60_0)
			if arg_60_0 == 1 then
				arg_58_0:Play325731015(arg_58_1)
			end
		end

		function arg_58_1.onSingleLineUpdate_(arg_61_0)
			local var_61_0 = arg_58_1.actors_["1077ui_story"]
			local var_61_1 = 0

			if var_61_1 < arg_58_1.time_ and arg_58_1.time_ <= var_61_1 + arg_61_0 and not isNil(var_61_0) and arg_58_1.var_.characterEffect1077ui_story == nil then
				arg_58_1.var_.characterEffect1077ui_story = var_61_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_61_2 = 0.200000002980232

			if var_61_1 <= arg_58_1.time_ and arg_58_1.time_ < var_61_1 + var_61_2 and not isNil(var_61_0) then
				local var_61_3 = (arg_58_1.time_ - var_61_1) / var_61_2

				if arg_58_1.var_.characterEffect1077ui_story and not isNil(var_61_0) then
					local var_61_4 = Mathf.Lerp(0, 0.5, var_61_3)

					arg_58_1.var_.characterEffect1077ui_story.fillFlat = true
					arg_58_1.var_.characterEffect1077ui_story.fillRatio = var_61_4
				end
			end

			if arg_58_1.time_ >= var_61_1 + var_61_2 and arg_58_1.time_ < var_61_1 + var_61_2 + arg_61_0 and not isNil(var_61_0) and arg_58_1.var_.characterEffect1077ui_story then
				local var_61_5 = 0.5

				arg_58_1.var_.characterEffect1077ui_story.fillFlat = true
				arg_58_1.var_.characterEffect1077ui_story.fillRatio = var_61_5
			end

			local var_61_6 = 0
			local var_61_7 = 0.9

			if var_61_6 < arg_58_1.time_ and arg_58_1.time_ <= var_61_6 + arg_61_0 then
				arg_58_1.talkMaxDuration = 0
				arg_58_1.dialogCg_.alpha = 1

				arg_58_1.dialog_:SetActive(true)
				SetActive(arg_58_1.leftNameGo_, true)

				local var_61_8 = arg_58_1:FormatText(StoryNameCfg[999].name)

				arg_58_1.leftNameTxt_.text = var_61_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_58_1.leftNameTxt_.transform)

				arg_58_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_58_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_58_1:RecordName(arg_58_1.leftNameTxt_.text)
				SetActive(arg_58_1.iconTrs_.gameObject, true)
				arg_58_1.iconController_:SetSelectedState("hero")

				arg_58_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_xh_citizenmb")

				arg_58_1.callingController_:SetSelectedState("normal")

				arg_58_1.keyicon_.color = Color.New(1, 1, 1)
				arg_58_1.icon_.color = Color.New(1, 1, 1)

				local var_61_9 = arg_58_1:GetWordFromCfg(325731014)
				local var_61_10 = arg_58_1:FormatText(var_61_9.content)

				arg_58_1.text_.text = var_61_10

				LuaForUtil.ClearLinePrefixSymbol(arg_58_1.text_)

				local var_61_11 = 36
				local var_61_12 = utf8.len(var_61_10)
				local var_61_13 = var_61_11 <= 0 and var_61_7 or var_61_7 * (var_61_12 / var_61_11)

				if var_61_13 > 0 and var_61_7 < var_61_13 then
					arg_58_1.talkMaxDuration = var_61_13

					if var_61_13 + var_61_6 > arg_58_1.duration_ then
						arg_58_1.duration_ = var_61_13 + var_61_6
					end
				end

				arg_58_1.text_.text = var_61_10
				arg_58_1.typewritter.percent = 0

				arg_58_1.typewritter:SetDirty()
				arg_58_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_325731", "325731014", "story_v_out_325731.awb") ~= 0 then
					local var_61_14 = manager.audio:GetVoiceLength("story_v_out_325731", "325731014", "story_v_out_325731.awb") / 1000

					if var_61_14 + var_61_6 > arg_58_1.duration_ then
						arg_58_1.duration_ = var_61_14 + var_61_6
					end

					if var_61_9.prefab_name ~= "" and arg_58_1.actors_[var_61_9.prefab_name] ~= nil then
						local var_61_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_58_1.actors_[var_61_9.prefab_name].transform, "story_v_out_325731", "325731014", "story_v_out_325731.awb")

						arg_58_1:RecordAudio("325731014", var_61_15)
						arg_58_1:RecordAudio("325731014", var_61_15)
					else
						arg_58_1:AudioAction("play", "voice", "story_v_out_325731", "325731014", "story_v_out_325731.awb")
					end

					arg_58_1:RecordHistoryTalkVoice("story_v_out_325731", "325731014", "story_v_out_325731.awb")
				end

				arg_58_1:RecordContent(arg_58_1.text_.text)
			end

			local var_61_16 = math.max(var_61_7, arg_58_1.talkMaxDuration)

			if var_61_6 <= arg_58_1.time_ and arg_58_1.time_ < var_61_6 + var_61_16 then
				arg_58_1.typewritter.percent = (arg_58_1.time_ - var_61_6) / var_61_16

				arg_58_1.typewritter:SetDirty()
			end

			if arg_58_1.time_ >= var_61_6 + var_61_16 and arg_58_1.time_ < var_61_6 + var_61_16 + arg_61_0 then
				arg_58_1.typewritter.percent = 1

				arg_58_1.typewritter:SetDirty()
				arg_58_1:ShowNextGo(true)
			end
		end

		arg_58_1.nodeConfigList_ = {}

		arg_58_1:InitPlayNodeList()
	end,
	Play325731015 = function(arg_62_0, arg_62_1)
		arg_62_1.time_ = 0
		arg_62_1.frameCnt_ = 0
		arg_62_1.state_ = "playing"
		arg_62_1.curTalkId_ = 325731015
		arg_62_1.duration_ = 7.9

		local var_62_0 = {
			zh = 6.2,
			ja = 7.9
		}
		local var_62_1 = manager.audio:GetLocalizationFlag()

		if var_62_0[var_62_1] ~= nil then
			arg_62_1.duration_ = var_62_0[var_62_1]
		end

		SetActive(arg_62_1.tipsGo_, false)

		function arg_62_1.onSingleLineFinish_()
			arg_62_1.onSingleLineUpdate_ = nil
			arg_62_1.onSingleLineFinish_ = nil
			arg_62_1.state_ = "waiting"
		end

		function arg_62_1.playNext_(arg_64_0)
			if arg_64_0 == 1 then
				arg_62_0:Play325731016(arg_62_1)
			end
		end

		function arg_62_1.onSingleLineUpdate_(arg_65_0)
			local var_65_0 = arg_62_1.actors_["1077ui_story"]
			local var_65_1 = 0

			if var_65_1 < arg_62_1.time_ and arg_62_1.time_ <= var_65_1 + arg_65_0 and not isNil(var_65_0) and arg_62_1.var_.characterEffect1077ui_story == nil then
				arg_62_1.var_.characterEffect1077ui_story = var_65_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_65_2 = 0.200000002980232

			if var_65_1 <= arg_62_1.time_ and arg_62_1.time_ < var_65_1 + var_65_2 and not isNil(var_65_0) then
				local var_65_3 = (arg_62_1.time_ - var_65_1) / var_65_2

				if arg_62_1.var_.characterEffect1077ui_story and not isNil(var_65_0) then
					arg_62_1.var_.characterEffect1077ui_story.fillFlat = false
				end
			end

			if arg_62_1.time_ >= var_65_1 + var_65_2 and arg_62_1.time_ < var_65_1 + var_65_2 + arg_65_0 and not isNil(var_65_0) and arg_62_1.var_.characterEffect1077ui_story then
				arg_62_1.var_.characterEffect1077ui_story.fillFlat = false
			end

			local var_65_4 = 0

			if var_65_4 < arg_62_1.time_ and arg_62_1.time_ <= var_65_4 + arg_65_0 then
				arg_62_1:PlayTimeline("1077ui_story", "StoryTimeline/CharAction/story1077/story1077action/1077action6_2")
			end

			local var_65_5 = 0
			local var_65_6 = 0.825

			if var_65_5 < arg_62_1.time_ and arg_62_1.time_ <= var_65_5 + arg_65_0 then
				arg_62_1.talkMaxDuration = 0
				arg_62_1.dialogCg_.alpha = 1

				arg_62_1.dialog_:SetActive(true)
				SetActive(arg_62_1.leftNameGo_, true)

				local var_65_7 = arg_62_1:FormatText(StoryNameCfg[1467].name)

				arg_62_1.leftNameTxt_.text = var_65_7

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_62_1.leftNameTxt_.transform)

				arg_62_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_62_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_62_1:RecordName(arg_62_1.leftNameTxt_.text)
				SetActive(arg_62_1.iconTrs_.gameObject, false)
				arg_62_1.callingController_:SetSelectedState("normal")

				local var_65_8 = arg_62_1:GetWordFromCfg(325731015)
				local var_65_9 = arg_62_1:FormatText(var_65_8.content)

				arg_62_1.text_.text = var_65_9

				LuaForUtil.ClearLinePrefixSymbol(arg_62_1.text_)

				local var_65_10 = 33
				local var_65_11 = utf8.len(var_65_9)
				local var_65_12 = var_65_10 <= 0 and var_65_6 or var_65_6 * (var_65_11 / var_65_10)

				if var_65_12 > 0 and var_65_6 < var_65_12 then
					arg_62_1.talkMaxDuration = var_65_12

					if var_65_12 + var_65_5 > arg_62_1.duration_ then
						arg_62_1.duration_ = var_65_12 + var_65_5
					end
				end

				arg_62_1.text_.text = var_65_9
				arg_62_1.typewritter.percent = 0

				arg_62_1.typewritter:SetDirty()
				arg_62_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_325731", "325731015", "story_v_out_325731.awb") ~= 0 then
					local var_65_13 = manager.audio:GetVoiceLength("story_v_out_325731", "325731015", "story_v_out_325731.awb") / 1000

					if var_65_13 + var_65_5 > arg_62_1.duration_ then
						arg_62_1.duration_ = var_65_13 + var_65_5
					end

					if var_65_8.prefab_name ~= "" and arg_62_1.actors_[var_65_8.prefab_name] ~= nil then
						local var_65_14 = LuaForUtil.PlayVoiceWithCriLipsync(arg_62_1.actors_[var_65_8.prefab_name].transform, "story_v_out_325731", "325731015", "story_v_out_325731.awb")

						arg_62_1:RecordAudio("325731015", var_65_14)
						arg_62_1:RecordAudio("325731015", var_65_14)
					else
						arg_62_1:AudioAction("play", "voice", "story_v_out_325731", "325731015", "story_v_out_325731.awb")
					end

					arg_62_1:RecordHistoryTalkVoice("story_v_out_325731", "325731015", "story_v_out_325731.awb")
				end

				arg_62_1:RecordContent(arg_62_1.text_.text)
			end

			local var_65_15 = math.max(var_65_6, arg_62_1.talkMaxDuration)

			if var_65_5 <= arg_62_1.time_ and arg_62_1.time_ < var_65_5 + var_65_15 then
				arg_62_1.typewritter.percent = (arg_62_1.time_ - var_65_5) / var_65_15

				arg_62_1.typewritter:SetDirty()
			end

			if arg_62_1.time_ >= var_65_5 + var_65_15 and arg_62_1.time_ < var_65_5 + var_65_15 + arg_65_0 then
				arg_62_1.typewritter.percent = 1

				arg_62_1.typewritter:SetDirty()
				arg_62_1:ShowNextGo(true)
			end
		end

		arg_62_1.nodeConfigList_ = {}

		arg_62_1:InitPlayNodeList()
	end,
	Play325731016 = function(arg_66_0, arg_66_1)
		arg_66_1.time_ = 0
		arg_66_1.frameCnt_ = 0
		arg_66_1.state_ = "playing"
		arg_66_1.curTalkId_ = 325731016
		arg_66_1.duration_ = 5.73

		local var_66_0 = {
			zh = 5.733,
			ja = 5.533
		}
		local var_66_1 = manager.audio:GetLocalizationFlag()

		if var_66_0[var_66_1] ~= nil then
			arg_66_1.duration_ = var_66_0[var_66_1]
		end

		SetActive(arg_66_1.tipsGo_, false)

		function arg_66_1.onSingleLineFinish_()
			arg_66_1.onSingleLineUpdate_ = nil
			arg_66_1.onSingleLineFinish_ = nil
			arg_66_1.state_ = "waiting"
		end

		function arg_66_1.playNext_(arg_68_0)
			if arg_68_0 == 1 then
				arg_66_0:Play325731017(arg_66_1)
			end
		end

		function arg_66_1.onSingleLineUpdate_(arg_69_0)
			local var_69_0 = arg_66_1.actors_["1077ui_story"]
			local var_69_1 = 0

			if var_69_1 < arg_66_1.time_ and arg_66_1.time_ <= var_69_1 + arg_69_0 and not isNil(var_69_0) and arg_66_1.var_.characterEffect1077ui_story == nil then
				arg_66_1.var_.characterEffect1077ui_story = var_69_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_69_2 = 0.200000002980232

			if var_69_1 <= arg_66_1.time_ and arg_66_1.time_ < var_69_1 + var_69_2 and not isNil(var_69_0) then
				local var_69_3 = (arg_66_1.time_ - var_69_1) / var_69_2

				if arg_66_1.var_.characterEffect1077ui_story and not isNil(var_69_0) then
					local var_69_4 = Mathf.Lerp(0, 0.5, var_69_3)

					arg_66_1.var_.characterEffect1077ui_story.fillFlat = true
					arg_66_1.var_.characterEffect1077ui_story.fillRatio = var_69_4
				end
			end

			if arg_66_1.time_ >= var_69_1 + var_69_2 and arg_66_1.time_ < var_69_1 + var_69_2 + arg_69_0 and not isNil(var_69_0) and arg_66_1.var_.characterEffect1077ui_story then
				local var_69_5 = 0.5

				arg_66_1.var_.characterEffect1077ui_story.fillFlat = true
				arg_66_1.var_.characterEffect1077ui_story.fillRatio = var_69_5
			end

			local var_69_6 = 0
			local var_69_7 = 0.7

			if var_69_6 < arg_66_1.time_ and arg_66_1.time_ <= var_69_6 + arg_69_0 then
				arg_66_1.talkMaxDuration = 0
				arg_66_1.dialogCg_.alpha = 1

				arg_66_1.dialog_:SetActive(true)
				SetActive(arg_66_1.leftNameGo_, true)

				local var_69_8 = arg_66_1:FormatText(StoryNameCfg[999].name)

				arg_66_1.leftNameTxt_.text = var_69_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_66_1.leftNameTxt_.transform)

				arg_66_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_66_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_66_1:RecordName(arg_66_1.leftNameTxt_.text)
				SetActive(arg_66_1.iconTrs_.gameObject, true)
				arg_66_1.iconController_:SetSelectedState("hero")

				arg_66_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_xh_citizenmb")

				arg_66_1.callingController_:SetSelectedState("normal")

				arg_66_1.keyicon_.color = Color.New(1, 1, 1)
				arg_66_1.icon_.color = Color.New(1, 1, 1)

				local var_69_9 = arg_66_1:GetWordFromCfg(325731016)
				local var_69_10 = arg_66_1:FormatText(var_69_9.content)

				arg_66_1.text_.text = var_69_10

				LuaForUtil.ClearLinePrefixSymbol(arg_66_1.text_)

				local var_69_11 = 28
				local var_69_12 = utf8.len(var_69_10)
				local var_69_13 = var_69_11 <= 0 and var_69_7 or var_69_7 * (var_69_12 / var_69_11)

				if var_69_13 > 0 and var_69_7 < var_69_13 then
					arg_66_1.talkMaxDuration = var_69_13

					if var_69_13 + var_69_6 > arg_66_1.duration_ then
						arg_66_1.duration_ = var_69_13 + var_69_6
					end
				end

				arg_66_1.text_.text = var_69_10
				arg_66_1.typewritter.percent = 0

				arg_66_1.typewritter:SetDirty()
				arg_66_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_325731", "325731016", "story_v_out_325731.awb") ~= 0 then
					local var_69_14 = manager.audio:GetVoiceLength("story_v_out_325731", "325731016", "story_v_out_325731.awb") / 1000

					if var_69_14 + var_69_6 > arg_66_1.duration_ then
						arg_66_1.duration_ = var_69_14 + var_69_6
					end

					if var_69_9.prefab_name ~= "" and arg_66_1.actors_[var_69_9.prefab_name] ~= nil then
						local var_69_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_66_1.actors_[var_69_9.prefab_name].transform, "story_v_out_325731", "325731016", "story_v_out_325731.awb")

						arg_66_1:RecordAudio("325731016", var_69_15)
						arg_66_1:RecordAudio("325731016", var_69_15)
					else
						arg_66_1:AudioAction("play", "voice", "story_v_out_325731", "325731016", "story_v_out_325731.awb")
					end

					arg_66_1:RecordHistoryTalkVoice("story_v_out_325731", "325731016", "story_v_out_325731.awb")
				end

				arg_66_1:RecordContent(arg_66_1.text_.text)
			end

			local var_69_16 = math.max(var_69_7, arg_66_1.talkMaxDuration)

			if var_69_6 <= arg_66_1.time_ and arg_66_1.time_ < var_69_6 + var_69_16 then
				arg_66_1.typewritter.percent = (arg_66_1.time_ - var_69_6) / var_69_16

				arg_66_1.typewritter:SetDirty()
			end

			if arg_66_1.time_ >= var_69_6 + var_69_16 and arg_66_1.time_ < var_69_6 + var_69_16 + arg_69_0 then
				arg_66_1.typewritter.percent = 1

				arg_66_1.typewritter:SetDirty()
				arg_66_1:ShowNextGo(true)
			end
		end

		arg_66_1.nodeConfigList_ = {}

		arg_66_1:InitPlayNodeList()
	end,
	Play325731017 = function(arg_70_0, arg_70_1)
		arg_70_1.time_ = 0
		arg_70_1.frameCnt_ = 0
		arg_70_1.state_ = "playing"
		arg_70_1.curTalkId_ = 325731017
		arg_70_1.duration_ = 8

		local var_70_0 = {
			zh = 5.9,
			ja = 8
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
				arg_70_0:Play325731018(arg_70_1)
			end
		end

		function arg_70_1.onSingleLineUpdate_(arg_73_0)
			local var_73_0 = 0
			local var_73_1 = 0.725

			if var_73_0 < arg_70_1.time_ and arg_70_1.time_ <= var_73_0 + arg_73_0 then
				arg_70_1.talkMaxDuration = 0
				arg_70_1.dialogCg_.alpha = 1

				arg_70_1.dialog_:SetActive(true)
				SetActive(arg_70_1.leftNameGo_, true)

				local var_73_2 = arg_70_1:FormatText(StoryNameCfg[999].name)

				arg_70_1.leftNameTxt_.text = var_73_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_70_1.leftNameTxt_.transform)

				arg_70_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_70_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_70_1:RecordName(arg_70_1.leftNameTxt_.text)
				SetActive(arg_70_1.iconTrs_.gameObject, true)
				arg_70_1.iconController_:SetSelectedState("hero")

				arg_70_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_xh_citizenmb")

				arg_70_1.callingController_:SetSelectedState("normal")

				arg_70_1.keyicon_.color = Color.New(1, 1, 1)
				arg_70_1.icon_.color = Color.New(1, 1, 1)

				local var_73_3 = arg_70_1:GetWordFromCfg(325731017)
				local var_73_4 = arg_70_1:FormatText(var_73_3.content)

				arg_70_1.text_.text = var_73_4

				LuaForUtil.ClearLinePrefixSymbol(arg_70_1.text_)

				local var_73_5 = 29
				local var_73_6 = utf8.len(var_73_4)
				local var_73_7 = var_73_5 <= 0 and var_73_1 or var_73_1 * (var_73_6 / var_73_5)

				if var_73_7 > 0 and var_73_1 < var_73_7 then
					arg_70_1.talkMaxDuration = var_73_7

					if var_73_7 + var_73_0 > arg_70_1.duration_ then
						arg_70_1.duration_ = var_73_7 + var_73_0
					end
				end

				arg_70_1.text_.text = var_73_4
				arg_70_1.typewritter.percent = 0

				arg_70_1.typewritter:SetDirty()
				arg_70_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_325731", "325731017", "story_v_out_325731.awb") ~= 0 then
					local var_73_8 = manager.audio:GetVoiceLength("story_v_out_325731", "325731017", "story_v_out_325731.awb") / 1000

					if var_73_8 + var_73_0 > arg_70_1.duration_ then
						arg_70_1.duration_ = var_73_8 + var_73_0
					end

					if var_73_3.prefab_name ~= "" and arg_70_1.actors_[var_73_3.prefab_name] ~= nil then
						local var_73_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_70_1.actors_[var_73_3.prefab_name].transform, "story_v_out_325731", "325731017", "story_v_out_325731.awb")

						arg_70_1:RecordAudio("325731017", var_73_9)
						arg_70_1:RecordAudio("325731017", var_73_9)
					else
						arg_70_1:AudioAction("play", "voice", "story_v_out_325731", "325731017", "story_v_out_325731.awb")
					end

					arg_70_1:RecordHistoryTalkVoice("story_v_out_325731", "325731017", "story_v_out_325731.awb")
				end

				arg_70_1:RecordContent(arg_70_1.text_.text)
			end

			local var_73_10 = math.max(var_73_1, arg_70_1.talkMaxDuration)

			if var_73_0 <= arg_70_1.time_ and arg_70_1.time_ < var_73_0 + var_73_10 then
				arg_70_1.typewritter.percent = (arg_70_1.time_ - var_73_0) / var_73_10

				arg_70_1.typewritter:SetDirty()
			end

			if arg_70_1.time_ >= var_73_0 + var_73_10 and arg_70_1.time_ < var_73_0 + var_73_10 + arg_73_0 then
				arg_70_1.typewritter.percent = 1

				arg_70_1.typewritter:SetDirty()
				arg_70_1:ShowNextGo(true)
			end
		end

		arg_70_1.nodeConfigList_ = {}

		arg_70_1:InitPlayNodeList()
	end,
	Play325731018 = function(arg_74_0, arg_74_1)
		arg_74_1.time_ = 0
		arg_74_1.frameCnt_ = 0
		arg_74_1.state_ = "playing"
		arg_74_1.curTalkId_ = 325731018
		arg_74_1.duration_ = 7.2

		local var_74_0 = {
			zh = 4.8,
			ja = 7.2
		}
		local var_74_1 = manager.audio:GetLocalizationFlag()

		if var_74_0[var_74_1] ~= nil then
			arg_74_1.duration_ = var_74_0[var_74_1]
		end

		SetActive(arg_74_1.tipsGo_, false)

		function arg_74_1.onSingleLineFinish_()
			arg_74_1.onSingleLineUpdate_ = nil
			arg_74_1.onSingleLineFinish_ = nil
			arg_74_1.state_ = "waiting"
		end

		function arg_74_1.playNext_(arg_76_0)
			if arg_76_0 == 1 then
				arg_74_0:Play325731019(arg_74_1)
			end
		end

		function arg_74_1.onSingleLineUpdate_(arg_77_0)
			local var_77_0 = arg_74_1.actors_["1077ui_story"]
			local var_77_1 = 0

			if var_77_1 < arg_74_1.time_ and arg_74_1.time_ <= var_77_1 + arg_77_0 and not isNil(var_77_0) and arg_74_1.var_.characterEffect1077ui_story == nil then
				arg_74_1.var_.characterEffect1077ui_story = var_77_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_77_2 = 0.200000002980232

			if var_77_1 <= arg_74_1.time_ and arg_74_1.time_ < var_77_1 + var_77_2 and not isNil(var_77_0) then
				local var_77_3 = (arg_74_1.time_ - var_77_1) / var_77_2

				if arg_74_1.var_.characterEffect1077ui_story and not isNil(var_77_0) then
					arg_74_1.var_.characterEffect1077ui_story.fillFlat = false
				end
			end

			if arg_74_1.time_ >= var_77_1 + var_77_2 and arg_74_1.time_ < var_77_1 + var_77_2 + arg_77_0 and not isNil(var_77_0) and arg_74_1.var_.characterEffect1077ui_story then
				arg_74_1.var_.characterEffect1077ui_story.fillFlat = false
			end

			local var_77_4 = 0
			local var_77_5 = 0.6

			if var_77_4 < arg_74_1.time_ and arg_74_1.time_ <= var_77_4 + arg_77_0 then
				arg_74_1.talkMaxDuration = 0
				arg_74_1.dialogCg_.alpha = 1

				arg_74_1.dialog_:SetActive(true)
				SetActive(arg_74_1.leftNameGo_, true)

				local var_77_6 = arg_74_1:FormatText(StoryNameCfg[1467].name)

				arg_74_1.leftNameTxt_.text = var_77_6

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_74_1.leftNameTxt_.transform)

				arg_74_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_74_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_74_1:RecordName(arg_74_1.leftNameTxt_.text)
				SetActive(arg_74_1.iconTrs_.gameObject, false)
				arg_74_1.callingController_:SetSelectedState("normal")

				local var_77_7 = arg_74_1:GetWordFromCfg(325731018)
				local var_77_8 = arg_74_1:FormatText(var_77_7.content)

				arg_74_1.text_.text = var_77_8

				LuaForUtil.ClearLinePrefixSymbol(arg_74_1.text_)

				local var_77_9 = 24
				local var_77_10 = utf8.len(var_77_8)
				local var_77_11 = var_77_9 <= 0 and var_77_5 or var_77_5 * (var_77_10 / var_77_9)

				if var_77_11 > 0 and var_77_5 < var_77_11 then
					arg_74_1.talkMaxDuration = var_77_11

					if var_77_11 + var_77_4 > arg_74_1.duration_ then
						arg_74_1.duration_ = var_77_11 + var_77_4
					end
				end

				arg_74_1.text_.text = var_77_8
				arg_74_1.typewritter.percent = 0

				arg_74_1.typewritter:SetDirty()
				arg_74_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_325731", "325731018", "story_v_out_325731.awb") ~= 0 then
					local var_77_12 = manager.audio:GetVoiceLength("story_v_out_325731", "325731018", "story_v_out_325731.awb") / 1000

					if var_77_12 + var_77_4 > arg_74_1.duration_ then
						arg_74_1.duration_ = var_77_12 + var_77_4
					end

					if var_77_7.prefab_name ~= "" and arg_74_1.actors_[var_77_7.prefab_name] ~= nil then
						local var_77_13 = LuaForUtil.PlayVoiceWithCriLipsync(arg_74_1.actors_[var_77_7.prefab_name].transform, "story_v_out_325731", "325731018", "story_v_out_325731.awb")

						arg_74_1:RecordAudio("325731018", var_77_13)
						arg_74_1:RecordAudio("325731018", var_77_13)
					else
						arg_74_1:AudioAction("play", "voice", "story_v_out_325731", "325731018", "story_v_out_325731.awb")
					end

					arg_74_1:RecordHistoryTalkVoice("story_v_out_325731", "325731018", "story_v_out_325731.awb")
				end

				arg_74_1:RecordContent(arg_74_1.text_.text)
			end

			local var_77_14 = math.max(var_77_5, arg_74_1.talkMaxDuration)

			if var_77_4 <= arg_74_1.time_ and arg_74_1.time_ < var_77_4 + var_77_14 then
				arg_74_1.typewritter.percent = (arg_74_1.time_ - var_77_4) / var_77_14

				arg_74_1.typewritter:SetDirty()
			end

			if arg_74_1.time_ >= var_77_4 + var_77_14 and arg_74_1.time_ < var_77_4 + var_77_14 + arg_77_0 then
				arg_74_1.typewritter.percent = 1

				arg_74_1.typewritter:SetDirty()
				arg_74_1:ShowNextGo(true)
			end
		end

		arg_74_1.nodeConfigList_ = {}

		arg_74_1:InitPlayNodeList()
	end,
	Play325731019 = function(arg_78_0, arg_78_1)
		arg_78_1.time_ = 0
		arg_78_1.frameCnt_ = 0
		arg_78_1.state_ = "playing"
		arg_78_1.curTalkId_ = 325731019
		arg_78_1.duration_ = 5

		SetActive(arg_78_1.tipsGo_, false)

		function arg_78_1.onSingleLineFinish_()
			arg_78_1.onSingleLineUpdate_ = nil
			arg_78_1.onSingleLineFinish_ = nil
			arg_78_1.state_ = "waiting"
		end

		function arg_78_1.playNext_(arg_80_0)
			if arg_80_0 == 1 then
				arg_78_0:Play325731020(arg_78_1)
			end
		end

		function arg_78_1.onSingleLineUpdate_(arg_81_0)
			local var_81_0 = arg_78_1.actors_["1077ui_story"]
			local var_81_1 = 0

			if var_81_1 < arg_78_1.time_ and arg_78_1.time_ <= var_81_1 + arg_81_0 and not isNil(var_81_0) and arg_78_1.var_.characterEffect1077ui_story == nil then
				arg_78_1.var_.characterEffect1077ui_story = var_81_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_81_2 = 0.200000002980232

			if var_81_1 <= arg_78_1.time_ and arg_78_1.time_ < var_81_1 + var_81_2 and not isNil(var_81_0) then
				local var_81_3 = (arg_78_1.time_ - var_81_1) / var_81_2

				if arg_78_1.var_.characterEffect1077ui_story and not isNil(var_81_0) then
					local var_81_4 = Mathf.Lerp(0, 0.5, var_81_3)

					arg_78_1.var_.characterEffect1077ui_story.fillFlat = true
					arg_78_1.var_.characterEffect1077ui_story.fillRatio = var_81_4
				end
			end

			if arg_78_1.time_ >= var_81_1 + var_81_2 and arg_78_1.time_ < var_81_1 + var_81_2 + arg_81_0 and not isNil(var_81_0) and arg_78_1.var_.characterEffect1077ui_story then
				local var_81_5 = 0.5

				arg_78_1.var_.characterEffect1077ui_story.fillFlat = true
				arg_78_1.var_.characterEffect1077ui_story.fillRatio = var_81_5
			end

			local var_81_6 = 0
			local var_81_7 = 0.45

			if var_81_6 < arg_78_1.time_ and arg_78_1.time_ <= var_81_6 + arg_81_0 then
				arg_78_1.talkMaxDuration = 0
				arg_78_1.dialogCg_.alpha = 1

				arg_78_1.dialog_:SetActive(true)
				SetActive(arg_78_1.leftNameGo_, false)

				arg_78_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_78_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_78_1:RecordName(arg_78_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_78_1.iconTrs_.gameObject, false)
				arg_78_1.callingController_:SetSelectedState("normal")

				local var_81_8 = arg_78_1:GetWordFromCfg(325731019)
				local var_81_9 = arg_78_1:FormatText(var_81_8.content)

				arg_78_1.text_.text = var_81_9

				LuaForUtil.ClearLinePrefixSymbol(arg_78_1.text_)

				local var_81_10 = 18
				local var_81_11 = utf8.len(var_81_9)
				local var_81_12 = var_81_10 <= 0 and var_81_7 or var_81_7 * (var_81_11 / var_81_10)

				if var_81_12 > 0 and var_81_7 < var_81_12 then
					arg_78_1.talkMaxDuration = var_81_12

					if var_81_12 + var_81_6 > arg_78_1.duration_ then
						arg_78_1.duration_ = var_81_12 + var_81_6
					end
				end

				arg_78_1.text_.text = var_81_9
				arg_78_1.typewritter.percent = 0

				arg_78_1.typewritter:SetDirty()
				arg_78_1:ShowNextGo(false)
				arg_78_1:RecordContent(arg_78_1.text_.text)
			end

			local var_81_13 = math.max(var_81_7, arg_78_1.talkMaxDuration)

			if var_81_6 <= arg_78_1.time_ and arg_78_1.time_ < var_81_6 + var_81_13 then
				arg_78_1.typewritter.percent = (arg_78_1.time_ - var_81_6) / var_81_13

				arg_78_1.typewritter:SetDirty()
			end

			if arg_78_1.time_ >= var_81_6 + var_81_13 and arg_78_1.time_ < var_81_6 + var_81_13 + arg_81_0 then
				arg_78_1.typewritter.percent = 1

				arg_78_1.typewritter:SetDirty()
				arg_78_1:ShowNextGo(true)
			end
		end

		arg_78_1.nodeConfigList_ = {}

		arg_78_1:InitPlayNodeList()
	end,
	Play325731020 = function(arg_82_0, arg_82_1)
		arg_82_1.time_ = 0
		arg_82_1.frameCnt_ = 0
		arg_82_1.state_ = "playing"
		arg_82_1.curTalkId_ = 325731020
		arg_82_1.duration_ = 6.4

		local var_82_0 = {
			zh = 6.4,
			ja = 4.7
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
				arg_82_0:Play325731021(arg_82_1)
			end
		end

		function arg_82_1.onSingleLineUpdate_(arg_85_0)
			local var_85_0 = 0
			local var_85_1 = 0.825

			if var_85_0 < arg_82_1.time_ and arg_82_1.time_ <= var_85_0 + arg_85_0 then
				arg_82_1.talkMaxDuration = 0
				arg_82_1.dialogCg_.alpha = 1

				arg_82_1.dialog_:SetActive(true)
				SetActive(arg_82_1.leftNameGo_, true)

				local var_85_2 = arg_82_1:FormatText(StoryNameCfg[999].name)

				arg_82_1.leftNameTxt_.text = var_85_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_82_1.leftNameTxt_.transform)

				arg_82_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_82_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_82_1:RecordName(arg_82_1.leftNameTxt_.text)
				SetActive(arg_82_1.iconTrs_.gameObject, true)
				arg_82_1.iconController_:SetSelectedState("hero")

				arg_82_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_xh_citizenmb")

				arg_82_1.callingController_:SetSelectedState("normal")

				arg_82_1.keyicon_.color = Color.New(1, 1, 1)
				arg_82_1.icon_.color = Color.New(1, 1, 1)

				local var_85_3 = arg_82_1:GetWordFromCfg(325731020)
				local var_85_4 = arg_82_1:FormatText(var_85_3.content)

				arg_82_1.text_.text = var_85_4

				LuaForUtil.ClearLinePrefixSymbol(arg_82_1.text_)

				local var_85_5 = 33
				local var_85_6 = utf8.len(var_85_4)
				local var_85_7 = var_85_5 <= 0 and var_85_1 or var_85_1 * (var_85_6 / var_85_5)

				if var_85_7 > 0 and var_85_1 < var_85_7 then
					arg_82_1.talkMaxDuration = var_85_7

					if var_85_7 + var_85_0 > arg_82_1.duration_ then
						arg_82_1.duration_ = var_85_7 + var_85_0
					end
				end

				arg_82_1.text_.text = var_85_4
				arg_82_1.typewritter.percent = 0

				arg_82_1.typewritter:SetDirty()
				arg_82_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_325731", "325731020", "story_v_out_325731.awb") ~= 0 then
					local var_85_8 = manager.audio:GetVoiceLength("story_v_out_325731", "325731020", "story_v_out_325731.awb") / 1000

					if var_85_8 + var_85_0 > arg_82_1.duration_ then
						arg_82_1.duration_ = var_85_8 + var_85_0
					end

					if var_85_3.prefab_name ~= "" and arg_82_1.actors_[var_85_3.prefab_name] ~= nil then
						local var_85_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_82_1.actors_[var_85_3.prefab_name].transform, "story_v_out_325731", "325731020", "story_v_out_325731.awb")

						arg_82_1:RecordAudio("325731020", var_85_9)
						arg_82_1:RecordAudio("325731020", var_85_9)
					else
						arg_82_1:AudioAction("play", "voice", "story_v_out_325731", "325731020", "story_v_out_325731.awb")
					end

					arg_82_1:RecordHistoryTalkVoice("story_v_out_325731", "325731020", "story_v_out_325731.awb")
				end

				arg_82_1:RecordContent(arg_82_1.text_.text)
			end

			local var_85_10 = math.max(var_85_1, arg_82_1.talkMaxDuration)

			if var_85_0 <= arg_82_1.time_ and arg_82_1.time_ < var_85_0 + var_85_10 then
				arg_82_1.typewritter.percent = (arg_82_1.time_ - var_85_0) / var_85_10

				arg_82_1.typewritter:SetDirty()
			end

			if arg_82_1.time_ >= var_85_0 + var_85_10 and arg_82_1.time_ < var_85_0 + var_85_10 + arg_85_0 then
				arg_82_1.typewritter.percent = 1

				arg_82_1.typewritter:SetDirty()
				arg_82_1:ShowNextGo(true)
			end
		end

		arg_82_1.nodeConfigList_ = {}

		arg_82_1:InitPlayNodeList()
	end,
	Play325731021 = function(arg_86_0, arg_86_1)
		arg_86_1.time_ = 0
		arg_86_1.frameCnt_ = 0
		arg_86_1.state_ = "playing"
		arg_86_1.curTalkId_ = 325731021
		arg_86_1.duration_ = 12.5

		local var_86_0 = {
			zh = 4.366,
			ja = 12.5
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
				arg_86_0:Play325731022(arg_86_1)
			end
		end

		function arg_86_1.onSingleLineUpdate_(arg_89_0)
			local var_89_0 = 0
			local var_89_1 = 0.575

			if var_89_0 < arg_86_1.time_ and arg_86_1.time_ <= var_89_0 + arg_89_0 then
				arg_86_1.talkMaxDuration = 0
				arg_86_1.dialogCg_.alpha = 1

				arg_86_1.dialog_:SetActive(true)
				SetActive(arg_86_1.leftNameGo_, true)

				local var_89_2 = arg_86_1:FormatText(StoryNameCfg[999].name)

				arg_86_1.leftNameTxt_.text = var_89_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_86_1.leftNameTxt_.transform)

				arg_86_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_86_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_86_1:RecordName(arg_86_1.leftNameTxt_.text)
				SetActive(arg_86_1.iconTrs_.gameObject, true)
				arg_86_1.iconController_:SetSelectedState("hero")

				arg_86_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_xh_citizenmb")

				arg_86_1.callingController_:SetSelectedState("normal")

				arg_86_1.keyicon_.color = Color.New(1, 1, 1)
				arg_86_1.icon_.color = Color.New(1, 1, 1)

				local var_89_3 = arg_86_1:GetWordFromCfg(325731021)
				local var_89_4 = arg_86_1:FormatText(var_89_3.content)

				arg_86_1.text_.text = var_89_4

				LuaForUtil.ClearLinePrefixSymbol(arg_86_1.text_)

				local var_89_5 = 23
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

				if manager.audio:GetVoiceLength("story_v_out_325731", "325731021", "story_v_out_325731.awb") ~= 0 then
					local var_89_8 = manager.audio:GetVoiceLength("story_v_out_325731", "325731021", "story_v_out_325731.awb") / 1000

					if var_89_8 + var_89_0 > arg_86_1.duration_ then
						arg_86_1.duration_ = var_89_8 + var_89_0
					end

					if var_89_3.prefab_name ~= "" and arg_86_1.actors_[var_89_3.prefab_name] ~= nil then
						local var_89_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_86_1.actors_[var_89_3.prefab_name].transform, "story_v_out_325731", "325731021", "story_v_out_325731.awb")

						arg_86_1:RecordAudio("325731021", var_89_9)
						arg_86_1:RecordAudio("325731021", var_89_9)
					else
						arg_86_1:AudioAction("play", "voice", "story_v_out_325731", "325731021", "story_v_out_325731.awb")
					end

					arg_86_1:RecordHistoryTalkVoice("story_v_out_325731", "325731021", "story_v_out_325731.awb")
				end

				arg_86_1:RecordContent(arg_86_1.text_.text)
			end

			local var_89_10 = math.max(var_89_1, arg_86_1.talkMaxDuration)

			if var_89_0 <= arg_86_1.time_ and arg_86_1.time_ < var_89_0 + var_89_10 then
				arg_86_1.typewritter.percent = (arg_86_1.time_ - var_89_0) / var_89_10

				arg_86_1.typewritter:SetDirty()
			end

			if arg_86_1.time_ >= var_89_0 + var_89_10 and arg_86_1.time_ < var_89_0 + var_89_10 + arg_89_0 then
				arg_86_1.typewritter.percent = 1

				arg_86_1.typewritter:SetDirty()
				arg_86_1:ShowNextGo(true)
			end
		end

		arg_86_1.nodeConfigList_ = {}

		arg_86_1:InitPlayNodeList()
	end,
	Play325731022 = function(arg_90_0, arg_90_1)
		arg_90_1.time_ = 0
		arg_90_1.frameCnt_ = 0
		arg_90_1.state_ = "playing"
		arg_90_1.curTalkId_ = 325731022
		arg_90_1.duration_ = 7.57

		local var_90_0 = {
			zh = 7.566,
			ja = 6.9
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
				arg_90_0:Play325731023(arg_90_1)
			end
		end

		function arg_90_1.onSingleLineUpdate_(arg_93_0)
			local var_93_0 = arg_90_1.actors_["1077ui_story"]
			local var_93_1 = 0

			if var_93_1 < arg_90_1.time_ and arg_90_1.time_ <= var_93_1 + arg_93_0 and not isNil(var_93_0) and arg_90_1.var_.characterEffect1077ui_story == nil then
				arg_90_1.var_.characterEffect1077ui_story = var_93_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_93_2 = 0.200000002980232

			if var_93_1 <= arg_90_1.time_ and arg_90_1.time_ < var_93_1 + var_93_2 and not isNil(var_93_0) then
				local var_93_3 = (arg_90_1.time_ - var_93_1) / var_93_2

				if arg_90_1.var_.characterEffect1077ui_story and not isNil(var_93_0) then
					arg_90_1.var_.characterEffect1077ui_story.fillFlat = false
				end
			end

			if arg_90_1.time_ >= var_93_1 + var_93_2 and arg_90_1.time_ < var_93_1 + var_93_2 + arg_93_0 and not isNil(var_93_0) and arg_90_1.var_.characterEffect1077ui_story then
				arg_90_1.var_.characterEffect1077ui_story.fillFlat = false
			end

			local var_93_4 = 0

			if var_93_4 < arg_90_1.time_ and arg_90_1.time_ <= var_93_4 + arg_93_0 then
				arg_90_1:PlayTimeline("1077ui_story", "StoryTimeline/CharAction/story1077/story1077action/1077action8_1")
			end

			local var_93_5 = 0
			local var_93_6 = 0.775

			if var_93_5 < arg_90_1.time_ and arg_90_1.time_ <= var_93_5 + arg_93_0 then
				arg_90_1.talkMaxDuration = 0
				arg_90_1.dialogCg_.alpha = 1

				arg_90_1.dialog_:SetActive(true)
				SetActive(arg_90_1.leftNameGo_, true)

				local var_93_7 = arg_90_1:FormatText(StoryNameCfg[1467].name)

				arg_90_1.leftNameTxt_.text = var_93_7

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_90_1.leftNameTxt_.transform)

				arg_90_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_90_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_90_1:RecordName(arg_90_1.leftNameTxt_.text)
				SetActive(arg_90_1.iconTrs_.gameObject, false)
				arg_90_1.callingController_:SetSelectedState("normal")

				local var_93_8 = arg_90_1:GetWordFromCfg(325731022)
				local var_93_9 = arg_90_1:FormatText(var_93_8.content)

				arg_90_1.text_.text = var_93_9

				LuaForUtil.ClearLinePrefixSymbol(arg_90_1.text_)

				local var_93_10 = 31
				local var_93_11 = utf8.len(var_93_9)
				local var_93_12 = var_93_10 <= 0 and var_93_6 or var_93_6 * (var_93_11 / var_93_10)

				if var_93_12 > 0 and var_93_6 < var_93_12 then
					arg_90_1.talkMaxDuration = var_93_12

					if var_93_12 + var_93_5 > arg_90_1.duration_ then
						arg_90_1.duration_ = var_93_12 + var_93_5
					end
				end

				arg_90_1.text_.text = var_93_9
				arg_90_1.typewritter.percent = 0

				arg_90_1.typewritter:SetDirty()
				arg_90_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_325731", "325731022", "story_v_out_325731.awb") ~= 0 then
					local var_93_13 = manager.audio:GetVoiceLength("story_v_out_325731", "325731022", "story_v_out_325731.awb") / 1000

					if var_93_13 + var_93_5 > arg_90_1.duration_ then
						arg_90_1.duration_ = var_93_13 + var_93_5
					end

					if var_93_8.prefab_name ~= "" and arg_90_1.actors_[var_93_8.prefab_name] ~= nil then
						local var_93_14 = LuaForUtil.PlayVoiceWithCriLipsync(arg_90_1.actors_[var_93_8.prefab_name].transform, "story_v_out_325731", "325731022", "story_v_out_325731.awb")

						arg_90_1:RecordAudio("325731022", var_93_14)
						arg_90_1:RecordAudio("325731022", var_93_14)
					else
						arg_90_1:AudioAction("play", "voice", "story_v_out_325731", "325731022", "story_v_out_325731.awb")
					end

					arg_90_1:RecordHistoryTalkVoice("story_v_out_325731", "325731022", "story_v_out_325731.awb")
				end

				arg_90_1:RecordContent(arg_90_1.text_.text)
			end

			local var_93_15 = math.max(var_93_6, arg_90_1.talkMaxDuration)

			if var_93_5 <= arg_90_1.time_ and arg_90_1.time_ < var_93_5 + var_93_15 then
				arg_90_1.typewritter.percent = (arg_90_1.time_ - var_93_5) / var_93_15

				arg_90_1.typewritter:SetDirty()
			end

			if arg_90_1.time_ >= var_93_5 + var_93_15 and arg_90_1.time_ < var_93_5 + var_93_15 + arg_93_0 then
				arg_90_1.typewritter.percent = 1

				arg_90_1.typewritter:SetDirty()
				arg_90_1:ShowNextGo(true)
			end
		end

		arg_90_1.nodeConfigList_ = {}

		arg_90_1:InitPlayNodeList()
	end,
	Play325731023 = function(arg_94_0, arg_94_1)
		arg_94_1.time_ = 0
		arg_94_1.frameCnt_ = 0
		arg_94_1.state_ = "playing"
		arg_94_1.curTalkId_ = 325731023
		arg_94_1.duration_ = 13.4

		local var_94_0 = {
			zh = 11,
			ja = 13.4
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
				arg_94_0:Play325731024(arg_94_1)
			end
		end

		function arg_94_1.onSingleLineUpdate_(arg_97_0)
			local var_97_0 = arg_94_1.actors_["1077ui_story"]
			local var_97_1 = 0

			if var_97_1 < arg_94_1.time_ and arg_94_1.time_ <= var_97_1 + arg_97_0 and not isNil(var_97_0) and arg_94_1.var_.characterEffect1077ui_story == nil then
				arg_94_1.var_.characterEffect1077ui_story = var_97_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_97_2 = 0.200000002980232

			if var_97_1 <= arg_94_1.time_ and arg_94_1.time_ < var_97_1 + var_97_2 and not isNil(var_97_0) then
				local var_97_3 = (arg_94_1.time_ - var_97_1) / var_97_2

				if arg_94_1.var_.characterEffect1077ui_story and not isNil(var_97_0) then
					local var_97_4 = Mathf.Lerp(0, 0.5, var_97_3)

					arg_94_1.var_.characterEffect1077ui_story.fillFlat = true
					arg_94_1.var_.characterEffect1077ui_story.fillRatio = var_97_4
				end
			end

			if arg_94_1.time_ >= var_97_1 + var_97_2 and arg_94_1.time_ < var_97_1 + var_97_2 + arg_97_0 and not isNil(var_97_0) and arg_94_1.var_.characterEffect1077ui_story then
				local var_97_5 = 0.5

				arg_94_1.var_.characterEffect1077ui_story.fillFlat = true
				arg_94_1.var_.characterEffect1077ui_story.fillRatio = var_97_5
			end

			local var_97_6 = 0
			local var_97_7 = 1.45

			if var_97_6 < arg_94_1.time_ and arg_94_1.time_ <= var_97_6 + arg_97_0 then
				arg_94_1.talkMaxDuration = 0
				arg_94_1.dialogCg_.alpha = 1

				arg_94_1.dialog_:SetActive(true)
				SetActive(arg_94_1.leftNameGo_, true)

				local var_97_8 = arg_94_1:FormatText(StoryNameCfg[999].name)

				arg_94_1.leftNameTxt_.text = var_97_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_94_1.leftNameTxt_.transform)

				arg_94_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_94_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_94_1:RecordName(arg_94_1.leftNameTxt_.text)
				SetActive(arg_94_1.iconTrs_.gameObject, true)
				arg_94_1.iconController_:SetSelectedState("hero")

				arg_94_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_xh_citizenmb")

				arg_94_1.callingController_:SetSelectedState("normal")

				arg_94_1.keyicon_.color = Color.New(1, 1, 1)
				arg_94_1.icon_.color = Color.New(1, 1, 1)

				local var_97_9 = arg_94_1:GetWordFromCfg(325731023)
				local var_97_10 = arg_94_1:FormatText(var_97_9.content)

				arg_94_1.text_.text = var_97_10

				LuaForUtil.ClearLinePrefixSymbol(arg_94_1.text_)

				local var_97_11 = 58
				local var_97_12 = utf8.len(var_97_10)
				local var_97_13 = var_97_11 <= 0 and var_97_7 or var_97_7 * (var_97_12 / var_97_11)

				if var_97_13 > 0 and var_97_7 < var_97_13 then
					arg_94_1.talkMaxDuration = var_97_13

					if var_97_13 + var_97_6 > arg_94_1.duration_ then
						arg_94_1.duration_ = var_97_13 + var_97_6
					end
				end

				arg_94_1.text_.text = var_97_10
				arg_94_1.typewritter.percent = 0

				arg_94_1.typewritter:SetDirty()
				arg_94_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_325731", "325731023", "story_v_out_325731.awb") ~= 0 then
					local var_97_14 = manager.audio:GetVoiceLength("story_v_out_325731", "325731023", "story_v_out_325731.awb") / 1000

					if var_97_14 + var_97_6 > arg_94_1.duration_ then
						arg_94_1.duration_ = var_97_14 + var_97_6
					end

					if var_97_9.prefab_name ~= "" and arg_94_1.actors_[var_97_9.prefab_name] ~= nil then
						local var_97_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_94_1.actors_[var_97_9.prefab_name].transform, "story_v_out_325731", "325731023", "story_v_out_325731.awb")

						arg_94_1:RecordAudio("325731023", var_97_15)
						arg_94_1:RecordAudio("325731023", var_97_15)
					else
						arg_94_1:AudioAction("play", "voice", "story_v_out_325731", "325731023", "story_v_out_325731.awb")
					end

					arg_94_1:RecordHistoryTalkVoice("story_v_out_325731", "325731023", "story_v_out_325731.awb")
				end

				arg_94_1:RecordContent(arg_94_1.text_.text)
			end

			local var_97_16 = math.max(var_97_7, arg_94_1.talkMaxDuration)

			if var_97_6 <= arg_94_1.time_ and arg_94_1.time_ < var_97_6 + var_97_16 then
				arg_94_1.typewritter.percent = (arg_94_1.time_ - var_97_6) / var_97_16

				arg_94_1.typewritter:SetDirty()
			end

			if arg_94_1.time_ >= var_97_6 + var_97_16 and arg_94_1.time_ < var_97_6 + var_97_16 + arg_97_0 then
				arg_94_1.typewritter.percent = 1

				arg_94_1.typewritter:SetDirty()
				arg_94_1:ShowNextGo(true)
			end
		end

		arg_94_1.nodeConfigList_ = {}

		arg_94_1:InitPlayNodeList()
	end,
	Play325731024 = function(arg_98_0, arg_98_1)
		arg_98_1.time_ = 0
		arg_98_1.frameCnt_ = 0
		arg_98_1.state_ = "playing"
		arg_98_1.curTalkId_ = 325731024
		arg_98_1.duration_ = 4.27

		local var_98_0 = {
			zh = 4.266,
			ja = 3.066
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
				arg_98_0:Play325731025(arg_98_1)
			end
		end

		function arg_98_1.onSingleLineUpdate_(arg_101_0)
			local var_101_0 = 0
			local var_101_1 = 0.475

			if var_101_0 < arg_98_1.time_ and arg_98_1.time_ <= var_101_0 + arg_101_0 then
				arg_98_1.talkMaxDuration = 0
				arg_98_1.dialogCg_.alpha = 1

				arg_98_1.dialog_:SetActive(true)
				SetActive(arg_98_1.leftNameGo_, true)

				local var_101_2 = arg_98_1:FormatText(StoryNameCfg[999].name)

				arg_98_1.leftNameTxt_.text = var_101_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_98_1.leftNameTxt_.transform)

				arg_98_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_98_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_98_1:RecordName(arg_98_1.leftNameTxt_.text)
				SetActive(arg_98_1.iconTrs_.gameObject, true)
				arg_98_1.iconController_:SetSelectedState("hero")

				arg_98_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_xh_citizenmb")

				arg_98_1.callingController_:SetSelectedState("normal")

				arg_98_1.keyicon_.color = Color.New(1, 1, 1)
				arg_98_1.icon_.color = Color.New(1, 1, 1)

				local var_101_3 = arg_98_1:GetWordFromCfg(325731024)
				local var_101_4 = arg_98_1:FormatText(var_101_3.content)

				arg_98_1.text_.text = var_101_4

				LuaForUtil.ClearLinePrefixSymbol(arg_98_1.text_)

				local var_101_5 = 19
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

				if manager.audio:GetVoiceLength("story_v_out_325731", "325731024", "story_v_out_325731.awb") ~= 0 then
					local var_101_8 = manager.audio:GetVoiceLength("story_v_out_325731", "325731024", "story_v_out_325731.awb") / 1000

					if var_101_8 + var_101_0 > arg_98_1.duration_ then
						arg_98_1.duration_ = var_101_8 + var_101_0
					end

					if var_101_3.prefab_name ~= "" and arg_98_1.actors_[var_101_3.prefab_name] ~= nil then
						local var_101_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_98_1.actors_[var_101_3.prefab_name].transform, "story_v_out_325731", "325731024", "story_v_out_325731.awb")

						arg_98_1:RecordAudio("325731024", var_101_9)
						arg_98_1:RecordAudio("325731024", var_101_9)
					else
						arg_98_1:AudioAction("play", "voice", "story_v_out_325731", "325731024", "story_v_out_325731.awb")
					end

					arg_98_1:RecordHistoryTalkVoice("story_v_out_325731", "325731024", "story_v_out_325731.awb")
				end

				arg_98_1:RecordContent(arg_98_1.text_.text)
			end

			local var_101_10 = math.max(var_101_1, arg_98_1.talkMaxDuration)

			if var_101_0 <= arg_98_1.time_ and arg_98_1.time_ < var_101_0 + var_101_10 then
				arg_98_1.typewritter.percent = (arg_98_1.time_ - var_101_0) / var_101_10

				arg_98_1.typewritter:SetDirty()
			end

			if arg_98_1.time_ >= var_101_0 + var_101_10 and arg_98_1.time_ < var_101_0 + var_101_10 + arg_101_0 then
				arg_98_1.typewritter.percent = 1

				arg_98_1.typewritter:SetDirty()
				arg_98_1:ShowNextGo(true)
			end
		end

		arg_98_1.nodeConfigList_ = {}

		arg_98_1:InitPlayNodeList()
	end,
	Play325731025 = function(arg_102_0, arg_102_1)
		arg_102_1.time_ = 0
		arg_102_1.frameCnt_ = 0
		arg_102_1.state_ = "playing"
		arg_102_1.curTalkId_ = 325731025
		arg_102_1.duration_ = 4.6

		local var_102_0 = {
			zh = 2.366,
			ja = 4.6
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
				arg_102_0:Play325731026(arg_102_1)
			end
		end

		function arg_102_1.onSingleLineUpdate_(arg_105_0)
			local var_105_0 = arg_102_1.actors_["1077ui_story"]
			local var_105_1 = 0

			if var_105_1 < arg_102_1.time_ and arg_102_1.time_ <= var_105_1 + arg_105_0 and not isNil(var_105_0) and arg_102_1.var_.characterEffect1077ui_story == nil then
				arg_102_1.var_.characterEffect1077ui_story = var_105_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_105_2 = 0.200000002980232

			if var_105_1 <= arg_102_1.time_ and arg_102_1.time_ < var_105_1 + var_105_2 and not isNil(var_105_0) then
				local var_105_3 = (arg_102_1.time_ - var_105_1) / var_105_2

				if arg_102_1.var_.characterEffect1077ui_story and not isNil(var_105_0) then
					arg_102_1.var_.characterEffect1077ui_story.fillFlat = false
				end
			end

			if arg_102_1.time_ >= var_105_1 + var_105_2 and arg_102_1.time_ < var_105_1 + var_105_2 + arg_105_0 and not isNil(var_105_0) and arg_102_1.var_.characterEffect1077ui_story then
				arg_102_1.var_.characterEffect1077ui_story.fillFlat = false
			end

			local var_105_4 = 0

			if var_105_4 < arg_102_1.time_ and arg_102_1.time_ <= var_105_4 + arg_105_0 then
				arg_102_1:PlayTimeline("1077ui_story", "StoryTimeline/CharAction/story1077/story1077action/1077action8_2")
			end

			local var_105_5 = 0

			if var_105_5 < arg_102_1.time_ and arg_102_1.time_ <= var_105_5 + arg_105_0 then
				arg_102_1:PlayTimeline("1077ui_story", "StoryTimeline/CharAction/public_expression/expr_haixiuA", "EmotionTimelineAnimator")
			end

			local var_105_6 = 0

			if var_105_6 < arg_102_1.time_ and arg_102_1.time_ <= var_105_6 + arg_105_0 then
				arg_102_1.allBtn_.enabled = false
			end

			local var_105_7 = 0.85

			if arg_102_1.time_ >= var_105_6 + var_105_7 and arg_102_1.time_ < var_105_6 + var_105_7 + arg_105_0 then
				arg_102_1.allBtn_.enabled = true
			end

			if arg_102_1.frameCnt_ <= 1 then
				arg_102_1.dialog_:SetActive(false)
			end

			local var_105_8 = 0.7
			local var_105_9 = 0.15

			if var_105_8 < arg_102_1.time_ and arg_102_1.time_ <= var_105_8 + arg_105_0 then
				arg_102_1.talkMaxDuration = 0

				arg_102_1.dialog_:SetActive(true)

				arg_102_1.dialogCg_.alpha = 0

				local var_105_10 = LeanTween.value(arg_102_1.dialog_, 0, 1, 0.3)

				var_105_10:setOnUpdate(LuaHelper.FloatAction(function(arg_106_0)
					arg_102_1.dialogCg_.alpha = arg_106_0
				end))
				var_105_10:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_102_1.dialog_)
					var_105_10:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_102_1.duration_ = arg_102_1.duration_ + 0.3

				SetActive(arg_102_1.leftNameGo_, true)

				local var_105_11 = arg_102_1:FormatText(StoryNameCfg[1467].name)

				arg_102_1.leftNameTxt_.text = var_105_11

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_102_1.leftNameTxt_.transform)

				arg_102_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_102_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_102_1:RecordName(arg_102_1.leftNameTxt_.text)
				SetActive(arg_102_1.iconTrs_.gameObject, false)
				arg_102_1.callingController_:SetSelectedState("normal")

				local var_105_12 = arg_102_1:GetWordFromCfg(325731025)
				local var_105_13 = arg_102_1:FormatText(var_105_12.content)

				arg_102_1.text_.text = var_105_13

				LuaForUtil.ClearLinePrefixSymbol(arg_102_1.text_)

				local var_105_14 = 6
				local var_105_15 = utf8.len(var_105_13)
				local var_105_16 = var_105_14 <= 0 and var_105_9 or var_105_9 * (var_105_15 / var_105_14)

				if var_105_16 > 0 and var_105_9 < var_105_16 then
					arg_102_1.talkMaxDuration = var_105_16
					var_105_8 = var_105_8 + 0.3

					if var_105_16 + var_105_8 > arg_102_1.duration_ then
						arg_102_1.duration_ = var_105_16 + var_105_8
					end
				end

				arg_102_1.text_.text = var_105_13
				arg_102_1.typewritter.percent = 0

				arg_102_1.typewritter:SetDirty()
				arg_102_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_325731", "325731025", "story_v_out_325731.awb") ~= 0 then
					local var_105_17 = manager.audio:GetVoiceLength("story_v_out_325731", "325731025", "story_v_out_325731.awb") / 1000

					if var_105_17 + var_105_8 > arg_102_1.duration_ then
						arg_102_1.duration_ = var_105_17 + var_105_8
					end

					if var_105_12.prefab_name ~= "" and arg_102_1.actors_[var_105_12.prefab_name] ~= nil then
						local var_105_18 = LuaForUtil.PlayVoiceWithCriLipsync(arg_102_1.actors_[var_105_12.prefab_name].transform, "story_v_out_325731", "325731025", "story_v_out_325731.awb")

						arg_102_1:RecordAudio("325731025", var_105_18)
						arg_102_1:RecordAudio("325731025", var_105_18)
					else
						arg_102_1:AudioAction("play", "voice", "story_v_out_325731", "325731025", "story_v_out_325731.awb")
					end

					arg_102_1:RecordHistoryTalkVoice("story_v_out_325731", "325731025", "story_v_out_325731.awb")
				end

				arg_102_1:RecordContent(arg_102_1.text_.text)
			end

			local var_105_19 = var_105_8 + 0.3
			local var_105_20 = math.max(var_105_9, arg_102_1.talkMaxDuration)

			if var_105_19 <= arg_102_1.time_ and arg_102_1.time_ < var_105_19 + var_105_20 then
				arg_102_1.typewritter.percent = (arg_102_1.time_ - var_105_19) / var_105_20

				arg_102_1.typewritter:SetDirty()
			end

			if arg_102_1.time_ >= var_105_19 + var_105_20 and arg_102_1.time_ < var_105_19 + var_105_20 + arg_105_0 then
				arg_102_1.typewritter.percent = 1

				arg_102_1.typewritter:SetDirty()
				arg_102_1:ShowNextGo(true)
			end
		end

		arg_102_1.nodeConfigList_ = {}

		arg_102_1:InitPlayNodeList()
	end,
	Play325731026 = function(arg_108_0, arg_108_1)
		arg_108_1.time_ = 0
		arg_108_1.frameCnt_ = 0
		arg_108_1.state_ = "playing"
		arg_108_1.curTalkId_ = 325731026
		arg_108_1.duration_ = 5

		SetActive(arg_108_1.tipsGo_, false)

		function arg_108_1.onSingleLineFinish_()
			arg_108_1.onSingleLineUpdate_ = nil
			arg_108_1.onSingleLineFinish_ = nil
			arg_108_1.state_ = "waiting"
		end

		function arg_108_1.playNext_(arg_110_0)
			if arg_110_0 == 1 then
				arg_108_0:Play325731027(arg_108_1)
			end
		end

		function arg_108_1.onSingleLineUpdate_(arg_111_0)
			local var_111_0 = arg_108_1.actors_["1077ui_story"]
			local var_111_1 = 0

			if var_111_1 < arg_108_1.time_ and arg_108_1.time_ <= var_111_1 + arg_111_0 and not isNil(var_111_0) and arg_108_1.var_.characterEffect1077ui_story == nil then
				arg_108_1.var_.characterEffect1077ui_story = var_111_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_111_2 = 0.200000002980232

			if var_111_1 <= arg_108_1.time_ and arg_108_1.time_ < var_111_1 + var_111_2 and not isNil(var_111_0) then
				local var_111_3 = (arg_108_1.time_ - var_111_1) / var_111_2

				if arg_108_1.var_.characterEffect1077ui_story and not isNil(var_111_0) then
					local var_111_4 = Mathf.Lerp(0, 0.5, var_111_3)

					arg_108_1.var_.characterEffect1077ui_story.fillFlat = true
					arg_108_1.var_.characterEffect1077ui_story.fillRatio = var_111_4
				end
			end

			if arg_108_1.time_ >= var_111_1 + var_111_2 and arg_108_1.time_ < var_111_1 + var_111_2 + arg_111_0 and not isNil(var_111_0) and arg_108_1.var_.characterEffect1077ui_story then
				local var_111_5 = 0.5

				arg_108_1.var_.characterEffect1077ui_story.fillFlat = true
				arg_108_1.var_.characterEffect1077ui_story.fillRatio = var_111_5
			end

			local var_111_6 = 0
			local var_111_7 = 0.625

			if var_111_6 < arg_108_1.time_ and arg_108_1.time_ <= var_111_6 + arg_111_0 then
				arg_108_1.talkMaxDuration = 0
				arg_108_1.dialogCg_.alpha = 1

				arg_108_1.dialog_:SetActive(true)
				SetActive(arg_108_1.leftNameGo_, false)

				arg_108_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_108_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_108_1:RecordName(arg_108_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_108_1.iconTrs_.gameObject, false)
				arg_108_1.callingController_:SetSelectedState("normal")

				local var_111_8 = arg_108_1:GetWordFromCfg(325731026)
				local var_111_9 = arg_108_1:FormatText(var_111_8.content)

				arg_108_1.text_.text = var_111_9

				LuaForUtil.ClearLinePrefixSymbol(arg_108_1.text_)

				local var_111_10 = 25
				local var_111_11 = utf8.len(var_111_9)
				local var_111_12 = var_111_10 <= 0 and var_111_7 or var_111_7 * (var_111_11 / var_111_10)

				if var_111_12 > 0 and var_111_7 < var_111_12 then
					arg_108_1.talkMaxDuration = var_111_12

					if var_111_12 + var_111_6 > arg_108_1.duration_ then
						arg_108_1.duration_ = var_111_12 + var_111_6
					end
				end

				arg_108_1.text_.text = var_111_9
				arg_108_1.typewritter.percent = 0

				arg_108_1.typewritter:SetDirty()
				arg_108_1:ShowNextGo(false)
				arg_108_1:RecordContent(arg_108_1.text_.text)
			end

			local var_111_13 = math.max(var_111_7, arg_108_1.talkMaxDuration)

			if var_111_6 <= arg_108_1.time_ and arg_108_1.time_ < var_111_6 + var_111_13 then
				arg_108_1.typewritter.percent = (arg_108_1.time_ - var_111_6) / var_111_13

				arg_108_1.typewritter:SetDirty()
			end

			if arg_108_1.time_ >= var_111_6 + var_111_13 and arg_108_1.time_ < var_111_6 + var_111_13 + arg_111_0 then
				arg_108_1.typewritter.percent = 1

				arg_108_1.typewritter:SetDirty()
				arg_108_1:ShowNextGo(true)
			end
		end

		arg_108_1.nodeConfigList_ = {}

		arg_108_1:InitPlayNodeList()
	end,
	Play325731027 = function(arg_112_0, arg_112_1)
		arg_112_1.time_ = 0
		arg_112_1.frameCnt_ = 0
		arg_112_1.state_ = "playing"
		arg_112_1.curTalkId_ = 325731027
		arg_112_1.duration_ = 7.77

		local var_112_0 = {
			zh = 7.766,
			ja = 4.566
		}
		local var_112_1 = manager.audio:GetLocalizationFlag()

		if var_112_0[var_112_1] ~= nil then
			arg_112_1.duration_ = var_112_0[var_112_1]
		end

		SetActive(arg_112_1.tipsGo_, false)

		function arg_112_1.onSingleLineFinish_()
			arg_112_1.onSingleLineUpdate_ = nil
			arg_112_1.onSingleLineFinish_ = nil
			arg_112_1.state_ = "waiting"
		end

		function arg_112_1.playNext_(arg_114_0)
			if arg_114_0 == 1 then
				arg_112_0:Play325731028(arg_112_1)
			end
		end

		function arg_112_1.onSingleLineUpdate_(arg_115_0)
			local var_115_0 = 0
			local var_115_1 = 0.925

			if var_115_0 < arg_112_1.time_ and arg_112_1.time_ <= var_115_0 + arg_115_0 then
				arg_112_1.talkMaxDuration = 0
				arg_112_1.dialogCg_.alpha = 1

				arg_112_1.dialog_:SetActive(true)
				SetActive(arg_112_1.leftNameGo_, true)

				local var_115_2 = arg_112_1:FormatText(StoryNameCfg[999].name)

				arg_112_1.leftNameTxt_.text = var_115_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_112_1.leftNameTxt_.transform)

				arg_112_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_112_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_112_1:RecordName(arg_112_1.leftNameTxt_.text)
				SetActive(arg_112_1.iconTrs_.gameObject, true)
				arg_112_1.iconController_:SetSelectedState("hero")

				arg_112_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_xh_citizenmb")

				arg_112_1.callingController_:SetSelectedState("normal")

				arg_112_1.keyicon_.color = Color.New(1, 1, 1)
				arg_112_1.icon_.color = Color.New(1, 1, 1)

				local var_115_3 = arg_112_1:GetWordFromCfg(325731027)
				local var_115_4 = arg_112_1:FormatText(var_115_3.content)

				arg_112_1.text_.text = var_115_4

				LuaForUtil.ClearLinePrefixSymbol(arg_112_1.text_)

				local var_115_5 = 37
				local var_115_6 = utf8.len(var_115_4)
				local var_115_7 = var_115_5 <= 0 and var_115_1 or var_115_1 * (var_115_6 / var_115_5)

				if var_115_7 > 0 and var_115_1 < var_115_7 then
					arg_112_1.talkMaxDuration = var_115_7

					if var_115_7 + var_115_0 > arg_112_1.duration_ then
						arg_112_1.duration_ = var_115_7 + var_115_0
					end
				end

				arg_112_1.text_.text = var_115_4
				arg_112_1.typewritter.percent = 0

				arg_112_1.typewritter:SetDirty()
				arg_112_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_325731", "325731027", "story_v_out_325731.awb") ~= 0 then
					local var_115_8 = manager.audio:GetVoiceLength("story_v_out_325731", "325731027", "story_v_out_325731.awb") / 1000

					if var_115_8 + var_115_0 > arg_112_1.duration_ then
						arg_112_1.duration_ = var_115_8 + var_115_0
					end

					if var_115_3.prefab_name ~= "" and arg_112_1.actors_[var_115_3.prefab_name] ~= nil then
						local var_115_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_112_1.actors_[var_115_3.prefab_name].transform, "story_v_out_325731", "325731027", "story_v_out_325731.awb")

						arg_112_1:RecordAudio("325731027", var_115_9)
						arg_112_1:RecordAudio("325731027", var_115_9)
					else
						arg_112_1:AudioAction("play", "voice", "story_v_out_325731", "325731027", "story_v_out_325731.awb")
					end

					arg_112_1:RecordHistoryTalkVoice("story_v_out_325731", "325731027", "story_v_out_325731.awb")
				end

				arg_112_1:RecordContent(arg_112_1.text_.text)
			end

			local var_115_10 = math.max(var_115_1, arg_112_1.talkMaxDuration)

			if var_115_0 <= arg_112_1.time_ and arg_112_1.time_ < var_115_0 + var_115_10 then
				arg_112_1.typewritter.percent = (arg_112_1.time_ - var_115_0) / var_115_10

				arg_112_1.typewritter:SetDirty()
			end

			if arg_112_1.time_ >= var_115_0 + var_115_10 and arg_112_1.time_ < var_115_0 + var_115_10 + arg_115_0 then
				arg_112_1.typewritter.percent = 1

				arg_112_1.typewritter:SetDirty()
				arg_112_1:ShowNextGo(true)
			end
		end

		arg_112_1.nodeConfigList_ = {}

		arg_112_1:InitPlayNodeList()
	end,
	Play325731028 = function(arg_116_0, arg_116_1)
		arg_116_1.time_ = 0
		arg_116_1.frameCnt_ = 0
		arg_116_1.state_ = "playing"
		arg_116_1.curTalkId_ = 325731028
		arg_116_1.duration_ = 5

		SetActive(arg_116_1.tipsGo_, false)

		function arg_116_1.onSingleLineFinish_()
			arg_116_1.onSingleLineUpdate_ = nil
			arg_116_1.onSingleLineFinish_ = nil
			arg_116_1.state_ = "waiting"
		end

		function arg_116_1.playNext_(arg_118_0)
			if arg_118_0 == 1 then
				arg_116_0:Play325731029(arg_116_1)
			end
		end

		function arg_116_1.onSingleLineUpdate_(arg_119_0)
			local var_119_0 = arg_116_1.actors_["1077ui_story"].transform
			local var_119_1 = 0

			if var_119_1 < arg_116_1.time_ and arg_116_1.time_ <= var_119_1 + arg_119_0 then
				arg_116_1.var_.moveOldPos1077ui_story = var_119_0.localPosition

				local var_119_2 = GameObjectTools.GetOrAddComponent(var_119_0.gameObject, typeof(DynamicBoneHelper))

				if var_119_2 then
					var_119_2:EnableDynamicBone(false)
				end
			end

			local var_119_3 = 0.001

			if var_119_1 <= arg_116_1.time_ and arg_116_1.time_ < var_119_1 + var_119_3 then
				local var_119_4 = (arg_116_1.time_ - var_119_1) / var_119_3
				local var_119_5 = Vector3.New(0, 100, 0)

				var_119_0.localPosition = Vector3.Lerp(arg_116_1.var_.moveOldPos1077ui_story, var_119_5, var_119_4)

				local var_119_6 = manager.ui.mainCamera.transform.position - var_119_0.position

				var_119_0.forward = Vector3.New(var_119_6.x, var_119_6.y, var_119_6.z)

				local var_119_7 = var_119_0.localEulerAngles

				var_119_7.z = 0
				var_119_7.x = 0
				var_119_0.localEulerAngles = var_119_7
			end

			if arg_116_1.time_ >= var_119_1 + var_119_3 and arg_116_1.time_ < var_119_1 + var_119_3 + arg_119_0 then
				var_119_0.localPosition = Vector3.New(0, 100, 0)

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

			local var_119_11 = 0
			local var_119_12 = 0.875

			if var_119_11 < arg_116_1.time_ and arg_116_1.time_ <= var_119_11 + arg_119_0 then
				arg_116_1.talkMaxDuration = 0
				arg_116_1.dialogCg_.alpha = 1

				arg_116_1.dialog_:SetActive(true)
				SetActive(arg_116_1.leftNameGo_, false)

				arg_116_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_116_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_116_1:RecordName(arg_116_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_116_1.iconTrs_.gameObject, false)
				arg_116_1.callingController_:SetSelectedState("normal")

				local var_119_13 = arg_116_1:GetWordFromCfg(325731028)
				local var_119_14 = arg_116_1:FormatText(var_119_13.content)

				arg_116_1.text_.text = var_119_14

				LuaForUtil.ClearLinePrefixSymbol(arg_116_1.text_)

				local var_119_15 = 35
				local var_119_16 = utf8.len(var_119_14)
				local var_119_17 = var_119_15 <= 0 and var_119_12 or var_119_12 * (var_119_16 / var_119_15)

				if var_119_17 > 0 and var_119_12 < var_119_17 then
					arg_116_1.talkMaxDuration = var_119_17

					if var_119_17 + var_119_11 > arg_116_1.duration_ then
						arg_116_1.duration_ = var_119_17 + var_119_11
					end
				end

				arg_116_1.text_.text = var_119_14
				arg_116_1.typewritter.percent = 0

				arg_116_1.typewritter:SetDirty()
				arg_116_1:ShowNextGo(false)
				arg_116_1:RecordContent(arg_116_1.text_.text)
			end

			local var_119_18 = math.max(var_119_12, arg_116_1.talkMaxDuration)

			if var_119_11 <= arg_116_1.time_ and arg_116_1.time_ < var_119_11 + var_119_18 then
				arg_116_1.typewritter.percent = (arg_116_1.time_ - var_119_11) / var_119_18

				arg_116_1.typewritter:SetDirty()
			end

			if arg_116_1.time_ >= var_119_11 + var_119_18 and arg_116_1.time_ < var_119_11 + var_119_18 + arg_119_0 then
				arg_116_1.typewritter.percent = 1

				arg_116_1.typewritter:SetDirty()
				arg_116_1:ShowNextGo(true)
			end
		end

		arg_116_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1077ui_story",
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
	Play325731029 = function(arg_120_0, arg_120_1)
		arg_120_1.time_ = 0
		arg_120_1.frameCnt_ = 0
		arg_120_1.state_ = "playing"
		arg_120_1.curTalkId_ = 325731029
		arg_120_1.duration_ = 6.1

		local var_120_0 = {
			zh = 5,
			ja = 6.1
		}
		local var_120_1 = manager.audio:GetLocalizationFlag()

		if var_120_0[var_120_1] ~= nil then
			arg_120_1.duration_ = var_120_0[var_120_1]
		end

		SetActive(arg_120_1.tipsGo_, false)

		function arg_120_1.onSingleLineFinish_()
			arg_120_1.onSingleLineUpdate_ = nil
			arg_120_1.onSingleLineFinish_ = nil
			arg_120_1.state_ = "waiting"
		end

		function arg_120_1.playNext_(arg_122_0)
			if arg_122_0 == 1 then
				arg_120_0:Play325731030(arg_120_1)
			end
		end

		function arg_120_1.onSingleLineUpdate_(arg_123_0)
			local var_123_0 = arg_120_1.actors_["1077ui_story"].transform
			local var_123_1 = 0

			if var_123_1 < arg_120_1.time_ and arg_120_1.time_ <= var_123_1 + arg_123_0 then
				arg_120_1.var_.moveOldPos1077ui_story = var_123_0.localPosition

				local var_123_2 = GameObjectTools.GetOrAddComponent(var_123_0.gameObject, typeof(DynamicBoneHelper))

				if var_123_2 then
					var_123_2:EnableDynamicBone(false)
				end
			end

			local var_123_3 = 0.001

			if var_123_1 <= arg_120_1.time_ and arg_120_1.time_ < var_123_1 + var_123_3 then
				local var_123_4 = (arg_120_1.time_ - var_123_1) / var_123_3
				local var_123_5 = Vector3.New(-0.03, -1.02, -5.92)

				var_123_0.localPosition = Vector3.Lerp(arg_120_1.var_.moveOldPos1077ui_story, var_123_5, var_123_4)

				local var_123_6 = manager.ui.mainCamera.transform.position - var_123_0.position

				var_123_0.forward = Vector3.New(var_123_6.x, var_123_6.y, var_123_6.z)

				local var_123_7 = var_123_0.localEulerAngles

				var_123_7.z = 0
				var_123_7.x = 0
				var_123_0.localEulerAngles = var_123_7
			end

			if arg_120_1.time_ >= var_123_1 + var_123_3 and arg_120_1.time_ < var_123_1 + var_123_3 + arg_123_0 then
				var_123_0.localPosition = Vector3.New(-0.03, -1.02, -5.92)

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

			local var_123_11 = arg_120_1.actors_["1077ui_story"]
			local var_123_12 = 0

			if var_123_12 < arg_120_1.time_ and arg_120_1.time_ <= var_123_12 + arg_123_0 and not isNil(var_123_11) and arg_120_1.var_.characterEffect1077ui_story == nil then
				arg_120_1.var_.characterEffect1077ui_story = var_123_11:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_123_13 = 0.200000002980232

			if var_123_12 <= arg_120_1.time_ and arg_120_1.time_ < var_123_12 + var_123_13 and not isNil(var_123_11) then
				local var_123_14 = (arg_120_1.time_ - var_123_12) / var_123_13

				if arg_120_1.var_.characterEffect1077ui_story and not isNil(var_123_11) then
					arg_120_1.var_.characterEffect1077ui_story.fillFlat = false
				end
			end

			if arg_120_1.time_ >= var_123_12 + var_123_13 and arg_120_1.time_ < var_123_12 + var_123_13 + arg_123_0 and not isNil(var_123_11) and arg_120_1.var_.characterEffect1077ui_story then
				arg_120_1.var_.characterEffect1077ui_story.fillFlat = false
			end

			local var_123_15 = 0
			local var_123_16 = 0.525

			if var_123_15 < arg_120_1.time_ and arg_120_1.time_ <= var_123_15 + arg_123_0 then
				arg_120_1.talkMaxDuration = 0
				arg_120_1.dialogCg_.alpha = 1

				arg_120_1.dialog_:SetActive(true)
				SetActive(arg_120_1.leftNameGo_, true)

				local var_123_17 = arg_120_1:FormatText(StoryNameCfg[1467].name)

				arg_120_1.leftNameTxt_.text = var_123_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_120_1.leftNameTxt_.transform)

				arg_120_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_120_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_120_1:RecordName(arg_120_1.leftNameTxt_.text)
				SetActive(arg_120_1.iconTrs_.gameObject, false)
				arg_120_1.callingController_:SetSelectedState("normal")

				local var_123_18 = arg_120_1:GetWordFromCfg(325731029)
				local var_123_19 = arg_120_1:FormatText(var_123_18.content)

				arg_120_1.text_.text = var_123_19

				LuaForUtil.ClearLinePrefixSymbol(arg_120_1.text_)

				local var_123_20 = 21
				local var_123_21 = utf8.len(var_123_19)
				local var_123_22 = var_123_20 <= 0 and var_123_16 or var_123_16 * (var_123_21 / var_123_20)

				if var_123_22 > 0 and var_123_16 < var_123_22 then
					arg_120_1.talkMaxDuration = var_123_22

					if var_123_22 + var_123_15 > arg_120_1.duration_ then
						arg_120_1.duration_ = var_123_22 + var_123_15
					end
				end

				arg_120_1.text_.text = var_123_19
				arg_120_1.typewritter.percent = 0

				arg_120_1.typewritter:SetDirty()
				arg_120_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_325731", "325731029", "story_v_out_325731.awb") ~= 0 then
					local var_123_23 = manager.audio:GetVoiceLength("story_v_out_325731", "325731029", "story_v_out_325731.awb") / 1000

					if var_123_23 + var_123_15 > arg_120_1.duration_ then
						arg_120_1.duration_ = var_123_23 + var_123_15
					end

					if var_123_18.prefab_name ~= "" and arg_120_1.actors_[var_123_18.prefab_name] ~= nil then
						local var_123_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_120_1.actors_[var_123_18.prefab_name].transform, "story_v_out_325731", "325731029", "story_v_out_325731.awb")

						arg_120_1:RecordAudio("325731029", var_123_24)
						arg_120_1:RecordAudio("325731029", var_123_24)
					else
						arg_120_1:AudioAction("play", "voice", "story_v_out_325731", "325731029", "story_v_out_325731.awb")
					end

					arg_120_1:RecordHistoryTalkVoice("story_v_out_325731", "325731029", "story_v_out_325731.awb")
				end

				arg_120_1:RecordContent(arg_120_1.text_.text)
			end

			local var_123_25 = math.max(var_123_16, arg_120_1.talkMaxDuration)

			if var_123_15 <= arg_120_1.time_ and arg_120_1.time_ < var_123_15 + var_123_25 then
				arg_120_1.typewritter.percent = (arg_120_1.time_ - var_123_15) / var_123_25

				arg_120_1.typewritter:SetDirty()
			end

			if arg_120_1.time_ >= var_123_15 + var_123_25 and arg_120_1.time_ < var_123_15 + var_123_25 + arg_123_0 then
				arg_120_1.typewritter.percent = 1

				arg_120_1.typewritter:SetDirty()
				arg_120_1:ShowNextGo(true)
			end
		end

		arg_120_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1077ui_story",
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
	Play325731030 = function(arg_124_0, arg_124_1)
		arg_124_1.time_ = 0
		arg_124_1.frameCnt_ = 0
		arg_124_1.state_ = "playing"
		arg_124_1.curTalkId_ = 325731030
		arg_124_1.duration_ = 5.1

		local var_124_0 = {
			zh = 5.1,
			ja = 4.2
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
				arg_124_0:Play325731031(arg_124_1)
			end
		end

		function arg_124_1.onSingleLineUpdate_(arg_127_0)
			local var_127_0 = arg_124_1.actors_["1077ui_story"]
			local var_127_1 = 0

			if var_127_1 < arg_124_1.time_ and arg_124_1.time_ <= var_127_1 + arg_127_0 and not isNil(var_127_0) and arg_124_1.var_.characterEffect1077ui_story == nil then
				arg_124_1.var_.characterEffect1077ui_story = var_127_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_127_2 = 0.200000002980232

			if var_127_1 <= arg_124_1.time_ and arg_124_1.time_ < var_127_1 + var_127_2 and not isNil(var_127_0) then
				local var_127_3 = (arg_124_1.time_ - var_127_1) / var_127_2

				if arg_124_1.var_.characterEffect1077ui_story and not isNil(var_127_0) then
					local var_127_4 = Mathf.Lerp(0, 0.5, var_127_3)

					arg_124_1.var_.characterEffect1077ui_story.fillFlat = true
					arg_124_1.var_.characterEffect1077ui_story.fillRatio = var_127_4
				end
			end

			if arg_124_1.time_ >= var_127_1 + var_127_2 and arg_124_1.time_ < var_127_1 + var_127_2 + arg_127_0 and not isNil(var_127_0) and arg_124_1.var_.characterEffect1077ui_story then
				local var_127_5 = 0.5

				arg_124_1.var_.characterEffect1077ui_story.fillFlat = true
				arg_124_1.var_.characterEffect1077ui_story.fillRatio = var_127_5
			end

			local var_127_6 = 0
			local var_127_7 = 0.675

			if var_127_6 < arg_124_1.time_ and arg_124_1.time_ <= var_127_6 + arg_127_0 then
				arg_124_1.talkMaxDuration = 0
				arg_124_1.dialogCg_.alpha = 1

				arg_124_1.dialog_:SetActive(true)
				SetActive(arg_124_1.leftNameGo_, true)

				local var_127_8 = arg_124_1:FormatText(StoryNameCfg[999].name)

				arg_124_1.leftNameTxt_.text = var_127_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_124_1.leftNameTxt_.transform)

				arg_124_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_124_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_124_1:RecordName(arg_124_1.leftNameTxt_.text)
				SetActive(arg_124_1.iconTrs_.gameObject, true)
				arg_124_1.iconController_:SetSelectedState("hero")

				arg_124_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_xh_citizenmb")

				arg_124_1.callingController_:SetSelectedState("normal")

				arg_124_1.keyicon_.color = Color.New(1, 1, 1)
				arg_124_1.icon_.color = Color.New(1, 1, 1)

				local var_127_9 = arg_124_1:GetWordFromCfg(325731030)
				local var_127_10 = arg_124_1:FormatText(var_127_9.content)

				arg_124_1.text_.text = var_127_10

				LuaForUtil.ClearLinePrefixSymbol(arg_124_1.text_)

				local var_127_11 = 27
				local var_127_12 = utf8.len(var_127_10)
				local var_127_13 = var_127_11 <= 0 and var_127_7 or var_127_7 * (var_127_12 / var_127_11)

				if var_127_13 > 0 and var_127_7 < var_127_13 then
					arg_124_1.talkMaxDuration = var_127_13

					if var_127_13 + var_127_6 > arg_124_1.duration_ then
						arg_124_1.duration_ = var_127_13 + var_127_6
					end
				end

				arg_124_1.text_.text = var_127_10
				arg_124_1.typewritter.percent = 0

				arg_124_1.typewritter:SetDirty()
				arg_124_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_325731", "325731030", "story_v_out_325731.awb") ~= 0 then
					local var_127_14 = manager.audio:GetVoiceLength("story_v_out_325731", "325731030", "story_v_out_325731.awb") / 1000

					if var_127_14 + var_127_6 > arg_124_1.duration_ then
						arg_124_1.duration_ = var_127_14 + var_127_6
					end

					if var_127_9.prefab_name ~= "" and arg_124_1.actors_[var_127_9.prefab_name] ~= nil then
						local var_127_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_124_1.actors_[var_127_9.prefab_name].transform, "story_v_out_325731", "325731030", "story_v_out_325731.awb")

						arg_124_1:RecordAudio("325731030", var_127_15)
						arg_124_1:RecordAudio("325731030", var_127_15)
					else
						arg_124_1:AudioAction("play", "voice", "story_v_out_325731", "325731030", "story_v_out_325731.awb")
					end

					arg_124_1:RecordHistoryTalkVoice("story_v_out_325731", "325731030", "story_v_out_325731.awb")
				end

				arg_124_1:RecordContent(arg_124_1.text_.text)
			end

			local var_127_16 = math.max(var_127_7, arg_124_1.talkMaxDuration)

			if var_127_6 <= arg_124_1.time_ and arg_124_1.time_ < var_127_6 + var_127_16 then
				arg_124_1.typewritter.percent = (arg_124_1.time_ - var_127_6) / var_127_16

				arg_124_1.typewritter:SetDirty()
			end

			if arg_124_1.time_ >= var_127_6 + var_127_16 and arg_124_1.time_ < var_127_6 + var_127_16 + arg_127_0 then
				arg_124_1.typewritter.percent = 1

				arg_124_1.typewritter:SetDirty()
				arg_124_1:ShowNextGo(true)
			end
		end

		arg_124_1.nodeConfigList_ = {}

		arg_124_1:InitPlayNodeList()
	end,
	Play325731031 = function(arg_128_0, arg_128_1)
		arg_128_1.time_ = 0
		arg_128_1.frameCnt_ = 0
		arg_128_1.state_ = "playing"
		arg_128_1.curTalkId_ = 325731031
		arg_128_1.duration_ = 14.87

		local var_128_0 = {
			zh = 9.233,
			ja = 14.866
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
			arg_128_1.auto_ = false
		end

		function arg_128_1.playNext_(arg_130_0)
			arg_128_1.onStoryFinished_()
		end

		function arg_128_1.onSingleLineUpdate_(arg_131_0)
			local var_131_0 = 0
			local var_131_1 = 1

			if var_131_0 < arg_128_1.time_ and arg_128_1.time_ <= var_131_0 + arg_131_0 then
				local var_131_2 = "play"
				local var_131_3 = "effect"

				arg_128_1:AudioAction(var_131_2, var_131_3, "ui_battle", "ui_battle_stopbgm", "")
			end

			local var_131_4 = 0
			local var_131_5 = 1.25

			if var_131_4 < arg_128_1.time_ and arg_128_1.time_ <= var_131_4 + arg_131_0 then
				arg_128_1.talkMaxDuration = 0
				arg_128_1.dialogCg_.alpha = 1

				arg_128_1.dialog_:SetActive(true)
				SetActive(arg_128_1.leftNameGo_, true)

				local var_131_6 = arg_128_1:FormatText(StoryNameCfg[999].name)

				arg_128_1.leftNameTxt_.text = var_131_6

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_128_1.leftNameTxt_.transform)

				arg_128_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_128_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_128_1:RecordName(arg_128_1.leftNameTxt_.text)
				SetActive(arg_128_1.iconTrs_.gameObject, true)
				arg_128_1.iconController_:SetSelectedState("hero")

				arg_128_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_xh_citizenmb")

				arg_128_1.callingController_:SetSelectedState("normal")

				arg_128_1.keyicon_.color = Color.New(1, 1, 1)
				arg_128_1.icon_.color = Color.New(1, 1, 1)

				local var_131_7 = arg_128_1:GetWordFromCfg(325731031)
				local var_131_8 = arg_128_1:FormatText(var_131_7.content)

				arg_128_1.text_.text = var_131_8

				LuaForUtil.ClearLinePrefixSymbol(arg_128_1.text_)

				local var_131_9 = 50
				local var_131_10 = utf8.len(var_131_8)
				local var_131_11 = var_131_9 <= 0 and var_131_5 or var_131_5 * (var_131_10 / var_131_9)

				if var_131_11 > 0 and var_131_5 < var_131_11 then
					arg_128_1.talkMaxDuration = var_131_11

					if var_131_11 + var_131_4 > arg_128_1.duration_ then
						arg_128_1.duration_ = var_131_11 + var_131_4
					end
				end

				arg_128_1.text_.text = var_131_8
				arg_128_1.typewritter.percent = 0

				arg_128_1.typewritter:SetDirty()
				arg_128_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_325731", "325731031", "story_v_out_325731.awb") ~= 0 then
					local var_131_12 = manager.audio:GetVoiceLength("story_v_out_325731", "325731031", "story_v_out_325731.awb") / 1000

					if var_131_12 + var_131_4 > arg_128_1.duration_ then
						arg_128_1.duration_ = var_131_12 + var_131_4
					end

					if var_131_7.prefab_name ~= "" and arg_128_1.actors_[var_131_7.prefab_name] ~= nil then
						local var_131_13 = LuaForUtil.PlayVoiceWithCriLipsync(arg_128_1.actors_[var_131_7.prefab_name].transform, "story_v_out_325731", "325731031", "story_v_out_325731.awb")

						arg_128_1:RecordAudio("325731031", var_131_13)
						arg_128_1:RecordAudio("325731031", var_131_13)
					else
						arg_128_1:AudioAction("play", "voice", "story_v_out_325731", "325731031", "story_v_out_325731.awb")
					end

					arg_128_1:RecordHistoryTalkVoice("story_v_out_325731", "325731031", "story_v_out_325731.awb")
				end

				arg_128_1:RecordContent(arg_128_1.text_.text)
			end

			local var_131_14 = math.max(var_131_5, arg_128_1.talkMaxDuration)

			if var_131_4 <= arg_128_1.time_ and arg_128_1.time_ < var_131_4 + var_131_14 then
				arg_128_1.typewritter.percent = (arg_128_1.time_ - var_131_4) / var_131_14

				arg_128_1.typewritter:SetDirty()
			end

			if arg_128_1.time_ >= var_131_4 + var_131_14 and arg_128_1.time_ < var_131_4 + var_131_14 + arg_131_0 then
				arg_128_1.typewritter.percent = 1

				arg_128_1.typewritter:SetDirty()
				arg_128_1:ShowNextGo(true)
			end
		end

		arg_128_1.nodeConfigList_ = {}

		arg_128_1:InitPlayNodeList()
	end,
	assets = {
		"TextureConfig/Background/ST31",
		"TextureConfig/Background/ST40"
	},
	voices = {
		"story_v_out_325731.awb"
	}
}
