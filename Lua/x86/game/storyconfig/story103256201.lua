return {
	Play325621001 = function(arg_1_0, arg_1_1)
		arg_1_1.time_ = 0
		arg_1_1.frameCnt_ = 0
		arg_1_1.state_ = "playing"
		arg_1_1.curTalkId_ = 325621001
		arg_1_1.duration_ = 7.1

		local var_1_0 = {
			zh = 5.99933333333333,
			ja = 7.09933333333333
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
				arg_1_0:Play325621002(arg_1_1)
			end
		end

		function arg_1_1.onSingleLineUpdate_(arg_4_0)
			local var_4_0 = "ST2013"

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
				local var_4_5 = arg_1_1.bgs_.ST2013

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
					if iter_4_0 ~= "ST2013" then
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

			local var_4_24 = "10165ui_story"

			if arg_1_1.actors_[var_4_24] == nil then
				local var_4_25 = Asset.Load("Char/" .. "10165ui_story")

				if not isNil(var_4_25) then
					local var_4_26 = Object.Instantiate(Asset.Load("Char/" .. "10165ui_story"), arg_1_1.stage_.transform)

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

			local var_4_29 = arg_1_1.actors_["10165ui_story"].transform
			local var_4_30 = 0

			if var_4_30 < arg_1_1.time_ and arg_1_1.time_ <= var_4_30 + arg_4_0 then
				arg_1_1.var_.moveOldPos10165ui_story = var_4_29.localPosition

				local var_4_31 = GameObjectTools.GetOrAddComponent(var_4_29.gameObject, typeof(DynamicBoneHelper))

				if var_4_31 then
					var_4_31:EnableDynamicBone(false)
				end
			end

			local var_4_32 = 0.001

			if var_4_30 <= arg_1_1.time_ and arg_1_1.time_ < var_4_30 + var_4_32 then
				local var_4_33 = (arg_1_1.time_ - var_4_30) / var_4_32
				local var_4_34 = Vector3.New(0, 100, 0)

				var_4_29.localPosition = Vector3.Lerp(arg_1_1.var_.moveOldPos10165ui_story, var_4_34, var_4_33)

				local var_4_35 = manager.ui.mainCamera.transform.position - var_4_29.position

				var_4_29.forward = Vector3.New(var_4_35.x, var_4_35.y, var_4_35.z)

				local var_4_36 = var_4_29.localEulerAngles

				var_4_36.z = 0
				var_4_36.x = 0
				var_4_29.localEulerAngles = var_4_36
			end

			if arg_1_1.time_ >= var_4_30 + var_4_32 and arg_1_1.time_ < var_4_30 + var_4_32 + arg_4_0 then
				var_4_29.localPosition = Vector3.New(0, 100, 0)

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

			local var_4_40 = arg_1_1.actors_["10165ui_story"]
			local var_4_41 = 0

			if var_4_41 < arg_1_1.time_ and arg_1_1.time_ <= var_4_41 + arg_4_0 and not isNil(var_4_40) and arg_1_1.var_.characterEffect10165ui_story == nil then
				arg_1_1.var_.characterEffect10165ui_story = var_4_40:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_4_42 = 0.200000002980232

			if var_4_41 <= arg_1_1.time_ and arg_1_1.time_ < var_4_41 + var_4_42 and not isNil(var_4_40) then
				local var_4_43 = (arg_1_1.time_ - var_4_41) / var_4_42

				if arg_1_1.var_.characterEffect10165ui_story and not isNil(var_4_40) then
					arg_1_1.var_.characterEffect10165ui_story.fillFlat = false
				end
			end

			if arg_1_1.time_ >= var_4_41 + var_4_42 and arg_1_1.time_ < var_4_41 + var_4_42 + arg_4_0 and not isNil(var_4_40) and arg_1_1.var_.characterEffect10165ui_story then
				arg_1_1.var_.characterEffect10165ui_story.fillFlat = false
			end

			local var_4_44 = 0

			if var_4_44 < arg_1_1.time_ and arg_1_1.time_ <= var_4_44 + arg_4_0 then
				arg_1_1:PlayTimeline("10165ui_story", "StoryTimeline/CharAction/story10162/story10162action/10162action1_1")
			end

			local var_4_45 = 0

			if var_4_45 < arg_1_1.time_ and arg_1_1.time_ <= var_4_45 + arg_4_0 then
				arg_1_1:PlayTimeline("10165ui_story", "StoryTimeline/CharAction/public_expression/expr_shengqiA", "EmotionTimelineAnimator")
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

				arg_1_1:AudioAction(var_4_52, var_4_53, "bgm_activity_4_8_story_dahuang_daily", "bgm_activity_4_8_story_dahuang_daily", "bgm_activity_4_8_story_dahuang_daily.awb")

				local var_4_54 = ""
				local var_4_55 = manager.audio:GetAudioName("bgm_activity_4_8_story_dahuang_daily", "bgm_activity_4_8_story_dahuang_daily")

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

			local var_4_56 = 1.33333333333333
			local var_4_57 = 0.35

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

				local var_4_59 = arg_1_1:FormatText(StoryNameCfg[1446].name)

				arg_1_1.leftNameTxt_.text = var_4_59

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_1_1.leftNameTxt_.transform)

				arg_1_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_1_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_1_1:RecordName(arg_1_1.leftNameTxt_.text)
				SetActive(arg_1_1.iconTrs_.gameObject, true)
				arg_1_1.iconController_:SetSelectedState("hero")

				arg_1_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_10165")

				arg_1_1.callingController_:SetSelectedState("normal")

				arg_1_1.keyicon_.color = Color.New(1, 1, 1)
				arg_1_1.icon_.color = Color.New(1, 1, 1)

				local var_4_60 = arg_1_1:GetWordFromCfg(325621001)
				local var_4_61 = arg_1_1:FormatText(var_4_60.content)

				arg_1_1.text_.text = var_4_61

				LuaForUtil.ClearLinePrefixSymbol(arg_1_1.text_)

				local var_4_62 = 14
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

				if manager.audio:GetVoiceLength("story_v_out_325621", "325621001", "story_v_out_325621.awb") ~= 0 then
					local var_4_65 = manager.audio:GetVoiceLength("story_v_out_325621", "325621001", "story_v_out_325621.awb") / 1000

					if var_4_65 + var_4_56 > arg_1_1.duration_ then
						arg_1_1.duration_ = var_4_65 + var_4_56
					end

					if var_4_60.prefab_name ~= "" and arg_1_1.actors_[var_4_60.prefab_name] ~= nil then
						local var_4_66 = LuaForUtil.PlayVoiceWithCriLipsync(arg_1_1.actors_[var_4_60.prefab_name].transform, "story_v_out_325621", "325621001", "story_v_out_325621.awb")

						arg_1_1:RecordAudio("325621001", var_4_66)
						arg_1_1:RecordAudio("325621001", var_4_66)
					else
						arg_1_1:AudioAction("play", "voice", "story_v_out_325621", "325621001", "story_v_out_325621.awb")
					end

					arg_1_1:RecordHistoryTalkVoice("story_v_out_325621", "325621001", "story_v_out_325621.awb")
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
				actorName = "10165ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_1_1:InitPlayNodeList()
	end,
	Play325621002 = function(arg_8_0, arg_8_1)
		arg_8_1.time_ = 0
		arg_8_1.frameCnt_ = 0
		arg_8_1.state_ = "playing"
		arg_8_1.curTalkId_ = 325621002
		arg_8_1.duration_ = 5

		SetActive(arg_8_1.tipsGo_, false)

		function arg_8_1.onSingleLineFinish_()
			arg_8_1.onSingleLineUpdate_ = nil
			arg_8_1.onSingleLineFinish_ = nil
			arg_8_1.state_ = "waiting"
		end

		function arg_8_1.playNext_(arg_10_0)
			if arg_10_0 == 1 then
				arg_8_0:Play325621003(arg_8_1)
			end
		end

		function arg_8_1.onSingleLineUpdate_(arg_11_0)
			local var_11_0 = arg_8_1.actors_["10165ui_story"].transform
			local var_11_1 = 0

			if var_11_1 < arg_8_1.time_ and arg_8_1.time_ <= var_11_1 + arg_11_0 then
				arg_8_1.var_.moveOldPos10165ui_story = var_11_0.localPosition

				local var_11_2 = GameObjectTools.GetOrAddComponent(var_11_0.gameObject, typeof(DynamicBoneHelper))

				if var_11_2 then
					var_11_2:EnableDynamicBone(false)
				end
			end

			local var_11_3 = 0.001

			if var_11_1 <= arg_8_1.time_ and arg_8_1.time_ < var_11_1 + var_11_3 then
				local var_11_4 = (arg_8_1.time_ - var_11_1) / var_11_3
				local var_11_5 = Vector3.New(0, 100, 0)

				var_11_0.localPosition = Vector3.Lerp(arg_8_1.var_.moveOldPos10165ui_story, var_11_5, var_11_4)

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

			local var_11_11 = arg_8_1.actors_["10165ui_story"]
			local var_11_12 = 0

			if var_11_12 < arg_8_1.time_ and arg_8_1.time_ <= var_11_12 + arg_11_0 and not isNil(var_11_11) and arg_8_1.var_.characterEffect10165ui_story == nil then
				arg_8_1.var_.characterEffect10165ui_story = var_11_11:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_11_13 = 0.200000002980232

			if var_11_12 <= arg_8_1.time_ and arg_8_1.time_ < var_11_12 + var_11_13 and not isNil(var_11_11) then
				local var_11_14 = (arg_8_1.time_ - var_11_12) / var_11_13

				if arg_8_1.var_.characterEffect10165ui_story and not isNil(var_11_11) then
					local var_11_15 = Mathf.Lerp(0, 0.5, var_11_14)

					arg_8_1.var_.characterEffect10165ui_story.fillFlat = true
					arg_8_1.var_.characterEffect10165ui_story.fillRatio = var_11_15
				end
			end

			if arg_8_1.time_ >= var_11_12 + var_11_13 and arg_8_1.time_ < var_11_12 + var_11_13 + arg_11_0 and not isNil(var_11_11) and arg_8_1.var_.characterEffect10165ui_story then
				local var_11_16 = 0.5

				arg_8_1.var_.characterEffect10165ui_story.fillFlat = true
				arg_8_1.var_.characterEffect10165ui_story.fillRatio = var_11_16
			end

			local var_11_17 = 0.1
			local var_11_18 = 1

			if var_11_17 < arg_8_1.time_ and arg_8_1.time_ <= var_11_17 + arg_11_0 then
				local var_11_19 = "stop"
				local var_11_20 = "effect"

				arg_8_1:AudioAction(var_11_19, var_11_20, "se_story_141", "se_story_141_amb_crowd_escape", "")
			end

			local var_11_21 = 0
			local var_11_22 = 1.05

			if var_11_21 < arg_8_1.time_ and arg_8_1.time_ <= var_11_21 + arg_11_0 then
				arg_8_1.talkMaxDuration = 0
				arg_8_1.dialogCg_.alpha = 1

				arg_8_1.dialog_:SetActive(true)
				SetActive(arg_8_1.leftNameGo_, false)

				arg_8_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_8_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_8_1:RecordName(arg_8_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_8_1.iconTrs_.gameObject, false)
				arg_8_1.callingController_:SetSelectedState("normal")

				local var_11_23 = arg_8_1:GetWordFromCfg(325621002)
				local var_11_24 = arg_8_1:FormatText(var_11_23.content)

				arg_8_1.text_.text = var_11_24

				LuaForUtil.ClearLinePrefixSymbol(arg_8_1.text_)

				local var_11_25 = 42
				local var_11_26 = utf8.len(var_11_24)
				local var_11_27 = var_11_25 <= 0 and var_11_22 or var_11_22 * (var_11_26 / var_11_25)

				if var_11_27 > 0 and var_11_22 < var_11_27 then
					arg_8_1.talkMaxDuration = var_11_27

					if var_11_27 + var_11_21 > arg_8_1.duration_ then
						arg_8_1.duration_ = var_11_27 + var_11_21
					end
				end

				arg_8_1.text_.text = var_11_24
				arg_8_1.typewritter.percent = 0

				arg_8_1.typewritter:SetDirty()
				arg_8_1:ShowNextGo(false)
				arg_8_1:RecordContent(arg_8_1.text_.text)
			end

			local var_11_28 = math.max(var_11_22, arg_8_1.talkMaxDuration)

			if var_11_21 <= arg_8_1.time_ and arg_8_1.time_ < var_11_21 + var_11_28 then
				arg_8_1.typewritter.percent = (arg_8_1.time_ - var_11_21) / var_11_28

				arg_8_1.typewritter:SetDirty()
			end

			if arg_8_1.time_ >= var_11_21 + var_11_28 and arg_8_1.time_ < var_11_21 + var_11_28 + arg_11_0 then
				arg_8_1.typewritter.percent = 1

				arg_8_1.typewritter:SetDirty()
				arg_8_1:ShowNextGo(true)
			end
		end

		arg_8_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10165ui_story",
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
	Play325621003 = function(arg_12_0, arg_12_1)
		arg_12_1.time_ = 0
		arg_12_1.frameCnt_ = 0
		arg_12_1.state_ = "playing"
		arg_12_1.curTalkId_ = 325621003
		arg_12_1.duration_ = 5

		SetActive(arg_12_1.tipsGo_, false)

		function arg_12_1.onSingleLineFinish_()
			arg_12_1.onSingleLineUpdate_ = nil
			arg_12_1.onSingleLineFinish_ = nil
			arg_12_1.state_ = "waiting"
		end

		function arg_12_1.playNext_(arg_14_0)
			if arg_14_0 == 1 then
				arg_12_0:Play325621004(arg_12_1)
			end
		end

		function arg_12_1.onSingleLineUpdate_(arg_15_0)
			local var_15_0 = 0
			local var_15_1 = 1.15

			if var_15_0 < arg_12_1.time_ and arg_12_1.time_ <= var_15_0 + arg_15_0 then
				arg_12_1.talkMaxDuration = 0
				arg_12_1.dialogCg_.alpha = 1

				arg_12_1.dialog_:SetActive(true)
				SetActive(arg_12_1.leftNameGo_, false)

				arg_12_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_12_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_12_1:RecordName(arg_12_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_12_1.iconTrs_.gameObject, false)
				arg_12_1.callingController_:SetSelectedState("normal")

				local var_15_2 = arg_12_1:GetWordFromCfg(325621003)
				local var_15_3 = arg_12_1:FormatText(var_15_2.content)

				arg_12_1.text_.text = var_15_3

				LuaForUtil.ClearLinePrefixSymbol(arg_12_1.text_)

				local var_15_4 = 46
				local var_15_5 = utf8.len(var_15_3)
				local var_15_6 = var_15_4 <= 0 and var_15_1 or var_15_1 * (var_15_5 / var_15_4)

				if var_15_6 > 0 and var_15_1 < var_15_6 then
					arg_12_1.talkMaxDuration = var_15_6

					if var_15_6 + var_15_0 > arg_12_1.duration_ then
						arg_12_1.duration_ = var_15_6 + var_15_0
					end
				end

				arg_12_1.text_.text = var_15_3
				arg_12_1.typewritter.percent = 0

				arg_12_1.typewritter:SetDirty()
				arg_12_1:ShowNextGo(false)
				arg_12_1:RecordContent(arg_12_1.text_.text)
			end

			local var_15_7 = math.max(var_15_1, arg_12_1.talkMaxDuration)

			if var_15_0 <= arg_12_1.time_ and arg_12_1.time_ < var_15_0 + var_15_7 then
				arg_12_1.typewritter.percent = (arg_12_1.time_ - var_15_0) / var_15_7

				arg_12_1.typewritter:SetDirty()
			end

			if arg_12_1.time_ >= var_15_0 + var_15_7 and arg_12_1.time_ < var_15_0 + var_15_7 + arg_15_0 then
				arg_12_1.typewritter.percent = 1

				arg_12_1.typewritter:SetDirty()
				arg_12_1:ShowNextGo(true)
			end
		end

		arg_12_1.nodeConfigList_ = {}

		arg_12_1:InitPlayNodeList()
	end,
	Play325621004 = function(arg_16_0, arg_16_1)
		arg_16_1.time_ = 0
		arg_16_1.frameCnt_ = 0
		arg_16_1.state_ = "playing"
		arg_16_1.curTalkId_ = 325621004
		arg_16_1.duration_ = 5.4

		local var_16_0 = {
			zh = 3.033,
			ja = 5.4
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
				arg_16_0:Play325621005(arg_16_1)
			end
		end

		function arg_16_1.onSingleLineUpdate_(arg_19_0)
			local var_19_0 = arg_16_1.actors_["10165ui_story"].transform
			local var_19_1 = 0

			if var_19_1 < arg_16_1.time_ and arg_16_1.time_ <= var_19_1 + arg_19_0 then
				arg_16_1.var_.moveOldPos10165ui_story = var_19_0.localPosition

				local var_19_2 = GameObjectTools.GetOrAddComponent(var_19_0.gameObject, typeof(DynamicBoneHelper))

				if var_19_2 then
					var_19_2:EnableDynamicBone(false)
				end
			end

			local var_19_3 = 0.001

			if var_19_1 <= arg_16_1.time_ and arg_16_1.time_ < var_19_1 + var_19_3 then
				local var_19_4 = (arg_16_1.time_ - var_19_1) / var_19_3
				local var_19_5 = Vector3.New(0, -1.08, -5.83)

				var_19_0.localPosition = Vector3.Lerp(arg_16_1.var_.moveOldPos10165ui_story, var_19_5, var_19_4)

				local var_19_6 = manager.ui.mainCamera.transform.position - var_19_0.position

				var_19_0.forward = Vector3.New(var_19_6.x, var_19_6.y, var_19_6.z)

				local var_19_7 = var_19_0.localEulerAngles

				var_19_7.z = 0
				var_19_7.x = 0
				var_19_0.localEulerAngles = var_19_7
			end

			if arg_16_1.time_ >= var_19_1 + var_19_3 and arg_16_1.time_ < var_19_1 + var_19_3 + arg_19_0 then
				var_19_0.localPosition = Vector3.New(0, -1.08, -5.83)

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

			local var_19_11 = arg_16_1.actors_["10165ui_story"]
			local var_19_12 = 0

			if var_19_12 < arg_16_1.time_ and arg_16_1.time_ <= var_19_12 + arg_19_0 and not isNil(var_19_11) and arg_16_1.var_.characterEffect10165ui_story == nil then
				arg_16_1.var_.characterEffect10165ui_story = var_19_11:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_19_13 = 0.200000002980232

			if var_19_12 <= arg_16_1.time_ and arg_16_1.time_ < var_19_12 + var_19_13 and not isNil(var_19_11) then
				local var_19_14 = (arg_16_1.time_ - var_19_12) / var_19_13

				if arg_16_1.var_.characterEffect10165ui_story and not isNil(var_19_11) then
					arg_16_1.var_.characterEffect10165ui_story.fillFlat = false
				end
			end

			if arg_16_1.time_ >= var_19_12 + var_19_13 and arg_16_1.time_ < var_19_12 + var_19_13 + arg_19_0 and not isNil(var_19_11) and arg_16_1.var_.characterEffect10165ui_story then
				arg_16_1.var_.characterEffect10165ui_story.fillFlat = false
			end

			local var_19_15 = arg_16_1.actors_["10165ui_story"]
			local var_19_16 = 0

			if var_19_16 < arg_16_1.time_ and arg_16_1.time_ <= var_19_16 + arg_19_0 and not isNil(var_19_15) and arg_16_1.var_.characterEffect10165ui_story == nil then
				arg_16_1.var_.characterEffect10165ui_story = var_19_15:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_19_17 = 0.200000002980232

			if var_19_16 <= arg_16_1.time_ and arg_16_1.time_ < var_19_16 + var_19_17 and not isNil(var_19_15) then
				local var_19_18 = (arg_16_1.time_ - var_19_16) / var_19_17

				if arg_16_1.var_.characterEffect10165ui_story and not isNil(var_19_15) then
					arg_16_1.var_.characterEffect10165ui_story.fillFlat = false
				end
			end

			if arg_16_1.time_ >= var_19_16 + var_19_17 and arg_16_1.time_ < var_19_16 + var_19_17 + arg_19_0 and not isNil(var_19_15) and arg_16_1.var_.characterEffect10165ui_story then
				arg_16_1.var_.characterEffect10165ui_story.fillFlat = false
			end

			local var_19_19 = 0

			if var_19_19 < arg_16_1.time_ and arg_16_1.time_ <= var_19_19 + arg_19_0 then
				arg_16_1:PlayTimeline("10165ui_story", "StoryTimeline/CharAction/story10162/story10162action/10162action15_1")
			end

			local var_19_20 = 0

			if var_19_20 < arg_16_1.time_ and arg_16_1.time_ <= var_19_20 + arg_19_0 then
				arg_16_1:PlayTimeline("10165ui_story", "StoryTimeline/CharAction/public_expression/expr_kuaileA_weixiao", "EmotionTimelineAnimator")
			end

			local var_19_21 = 0
			local var_19_22 = 0.25

			if var_19_21 < arg_16_1.time_ and arg_16_1.time_ <= var_19_21 + arg_19_0 then
				arg_16_1.talkMaxDuration = 0
				arg_16_1.dialogCg_.alpha = 1

				arg_16_1.dialog_:SetActive(true)
				SetActive(arg_16_1.leftNameGo_, true)

				local var_19_23 = arg_16_1:FormatText(StoryNameCfg[1446].name)

				arg_16_1.leftNameTxt_.text = var_19_23

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_16_1.leftNameTxt_.transform)

				arg_16_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_16_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_16_1:RecordName(arg_16_1.leftNameTxt_.text)
				SetActive(arg_16_1.iconTrs_.gameObject, false)
				arg_16_1.callingController_:SetSelectedState("normal")

				local var_19_24 = arg_16_1:GetWordFromCfg(325621004)
				local var_19_25 = arg_16_1:FormatText(var_19_24.content)

				arg_16_1.text_.text = var_19_25

				LuaForUtil.ClearLinePrefixSymbol(arg_16_1.text_)

				local var_19_26 = 10
				local var_19_27 = utf8.len(var_19_25)
				local var_19_28 = var_19_26 <= 0 and var_19_22 or var_19_22 * (var_19_27 / var_19_26)

				if var_19_28 > 0 and var_19_22 < var_19_28 then
					arg_16_1.talkMaxDuration = var_19_28

					if var_19_28 + var_19_21 > arg_16_1.duration_ then
						arg_16_1.duration_ = var_19_28 + var_19_21
					end
				end

				arg_16_1.text_.text = var_19_25
				arg_16_1.typewritter.percent = 0

				arg_16_1.typewritter:SetDirty()
				arg_16_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_325621", "325621004", "story_v_out_325621.awb") ~= 0 then
					local var_19_29 = manager.audio:GetVoiceLength("story_v_out_325621", "325621004", "story_v_out_325621.awb") / 1000

					if var_19_29 + var_19_21 > arg_16_1.duration_ then
						arg_16_1.duration_ = var_19_29 + var_19_21
					end

					if var_19_24.prefab_name ~= "" and arg_16_1.actors_[var_19_24.prefab_name] ~= nil then
						local var_19_30 = LuaForUtil.PlayVoiceWithCriLipsync(arg_16_1.actors_[var_19_24.prefab_name].transform, "story_v_out_325621", "325621004", "story_v_out_325621.awb")

						arg_16_1:RecordAudio("325621004", var_19_30)
						arg_16_1:RecordAudio("325621004", var_19_30)
					else
						arg_16_1:AudioAction("play", "voice", "story_v_out_325621", "325621004", "story_v_out_325621.awb")
					end

					arg_16_1:RecordHistoryTalkVoice("story_v_out_325621", "325621004", "story_v_out_325621.awb")
				end

				arg_16_1:RecordContent(arg_16_1.text_.text)
			end

			local var_19_31 = math.max(var_19_22, arg_16_1.talkMaxDuration)

			if var_19_21 <= arg_16_1.time_ and arg_16_1.time_ < var_19_21 + var_19_31 then
				arg_16_1.typewritter.percent = (arg_16_1.time_ - var_19_21) / var_19_31

				arg_16_1.typewritter:SetDirty()
			end

			if arg_16_1.time_ >= var_19_21 + var_19_31 and arg_16_1.time_ < var_19_21 + var_19_31 + arg_19_0 then
				arg_16_1.typewritter.percent = 1

				arg_16_1.typewritter:SetDirty()
				arg_16_1:ShowNextGo(true)
			end
		end

		arg_16_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10165ui_story",
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
	Play325621005 = function(arg_20_0, arg_20_1)
		arg_20_1.time_ = 0
		arg_20_1.frameCnt_ = 0
		arg_20_1.state_ = "playing"
		arg_20_1.curTalkId_ = 325621005
		arg_20_1.duration_ = 5

		SetActive(arg_20_1.tipsGo_, false)

		function arg_20_1.onSingleLineFinish_()
			arg_20_1.onSingleLineUpdate_ = nil
			arg_20_1.onSingleLineFinish_ = nil
			arg_20_1.state_ = "waiting"
		end

		function arg_20_1.playNext_(arg_22_0)
			if arg_22_0 == 1 then
				arg_20_0:Play325621006(arg_20_1)
			end
		end

		function arg_20_1.onSingleLineUpdate_(arg_23_0)
			local var_23_0 = arg_20_1.actors_["10165ui_story"].transform
			local var_23_1 = 0

			if var_23_1 < arg_20_1.time_ and arg_20_1.time_ <= var_23_1 + arg_23_0 then
				arg_20_1.var_.moveOldPos10165ui_story = var_23_0.localPosition

				local var_23_2 = GameObjectTools.GetOrAddComponent(var_23_0.gameObject, typeof(DynamicBoneHelper))

				if var_23_2 then
					var_23_2:EnableDynamicBone(false)
				end
			end

			local var_23_3 = 0.001

			if var_23_1 <= arg_20_1.time_ and arg_20_1.time_ < var_23_1 + var_23_3 then
				local var_23_4 = (arg_20_1.time_ - var_23_1) / var_23_3
				local var_23_5 = Vector3.New(0, 100, 0)

				var_23_0.localPosition = Vector3.Lerp(arg_20_1.var_.moveOldPos10165ui_story, var_23_5, var_23_4)

				local var_23_6 = manager.ui.mainCamera.transform.position - var_23_0.position

				var_23_0.forward = Vector3.New(var_23_6.x, var_23_6.y, var_23_6.z)

				local var_23_7 = var_23_0.localEulerAngles

				var_23_7.z = 0
				var_23_7.x = 0
				var_23_0.localEulerAngles = var_23_7
			end

			if arg_20_1.time_ >= var_23_1 + var_23_3 and arg_20_1.time_ < var_23_1 + var_23_3 + arg_23_0 then
				var_23_0.localPosition = Vector3.New(0, 100, 0)

				local var_23_8 = manager.ui.mainCamera.transform.position - var_23_0.position

				var_23_0.forward = Vector3.New(var_23_8.x, var_23_8.y, var_23_8.z)

				local var_23_9 = var_23_0.localEulerAngles

				var_23_9.z = 0
				var_23_9.x = 0
				var_23_0.localEulerAngles = var_23_9

				local var_23_10 = GameObjectTools.GetOrAddComponent(var_23_0.gameObject, typeof(DynamicBoneHelper))

				if var_23_10 then
					var_23_10:EnableDynamicBone(true)
				end
			end

			local var_23_11 = arg_20_1.actors_["10165ui_story"]
			local var_23_12 = 0

			if var_23_12 < arg_20_1.time_ and arg_20_1.time_ <= var_23_12 + arg_23_0 and not isNil(var_23_11) and arg_20_1.var_.characterEffect10165ui_story == nil then
				arg_20_1.var_.characterEffect10165ui_story = var_23_11:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_23_13 = 0.200000002980232

			if var_23_12 <= arg_20_1.time_ and arg_20_1.time_ < var_23_12 + var_23_13 and not isNil(var_23_11) then
				local var_23_14 = (arg_20_1.time_ - var_23_12) / var_23_13

				if arg_20_1.var_.characterEffect10165ui_story and not isNil(var_23_11) then
					local var_23_15 = Mathf.Lerp(0, 0.5, var_23_14)

					arg_20_1.var_.characterEffect10165ui_story.fillFlat = true
					arg_20_1.var_.characterEffect10165ui_story.fillRatio = var_23_15
				end
			end

			if arg_20_1.time_ >= var_23_12 + var_23_13 and arg_20_1.time_ < var_23_12 + var_23_13 + arg_23_0 and not isNil(var_23_11) and arg_20_1.var_.characterEffect10165ui_story then
				local var_23_16 = 0.5

				arg_20_1.var_.characterEffect10165ui_story.fillFlat = true
				arg_20_1.var_.characterEffect10165ui_story.fillRatio = var_23_16
			end

			local var_23_17 = 0
			local var_23_18 = 0.8

			if var_23_17 < arg_20_1.time_ and arg_20_1.time_ <= var_23_17 + arg_23_0 then
				arg_20_1.talkMaxDuration = 0
				arg_20_1.dialogCg_.alpha = 1

				arg_20_1.dialog_:SetActive(true)
				SetActive(arg_20_1.leftNameGo_, false)

				arg_20_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_20_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_20_1:RecordName(arg_20_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_20_1.iconTrs_.gameObject, false)
				arg_20_1.callingController_:SetSelectedState("normal")

				local var_23_19 = arg_20_1:GetWordFromCfg(325621005)
				local var_23_20 = arg_20_1:FormatText(var_23_19.content)

				arg_20_1.text_.text = var_23_20

				LuaForUtil.ClearLinePrefixSymbol(arg_20_1.text_)

				local var_23_21 = 32
				local var_23_22 = utf8.len(var_23_20)
				local var_23_23 = var_23_21 <= 0 and var_23_18 or var_23_18 * (var_23_22 / var_23_21)

				if var_23_23 > 0 and var_23_18 < var_23_23 then
					arg_20_1.talkMaxDuration = var_23_23

					if var_23_23 + var_23_17 > arg_20_1.duration_ then
						arg_20_1.duration_ = var_23_23 + var_23_17
					end
				end

				arg_20_1.text_.text = var_23_20
				arg_20_1.typewritter.percent = 0

				arg_20_1.typewritter:SetDirty()
				arg_20_1:ShowNextGo(false)
				arg_20_1:RecordContent(arg_20_1.text_.text)
			end

			local var_23_24 = math.max(var_23_18, arg_20_1.talkMaxDuration)

			if var_23_17 <= arg_20_1.time_ and arg_20_1.time_ < var_23_17 + var_23_24 then
				arg_20_1.typewritter.percent = (arg_20_1.time_ - var_23_17) / var_23_24

				arg_20_1.typewritter:SetDirty()
			end

			if arg_20_1.time_ >= var_23_17 + var_23_24 and arg_20_1.time_ < var_23_17 + var_23_24 + arg_23_0 then
				arg_20_1.typewritter.percent = 1

				arg_20_1.typewritter:SetDirty()
				arg_20_1:ShowNextGo(true)
			end
		end

		arg_20_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10165ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_20_1:InitPlayNodeList()
	end,
	Play325621006 = function(arg_24_0, arg_24_1)
		arg_24_1.time_ = 0
		arg_24_1.frameCnt_ = 0
		arg_24_1.state_ = "playing"
		arg_24_1.curTalkId_ = 325621006
		arg_24_1.duration_ = 6.67

		local var_24_0 = {
			zh = 6.133,
			ja = 6.666
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
				arg_24_0:Play325621007(arg_24_1)
			end
		end

		function arg_24_1.onSingleLineUpdate_(arg_27_0)
			local var_27_0 = "10167ui_story"

			if arg_24_1.actors_[var_27_0] == nil then
				local var_27_1 = Asset.Load("Char/" .. "10167ui_story")

				if not isNil(var_27_1) then
					local var_27_2 = Object.Instantiate(Asset.Load("Char/" .. "10167ui_story"), arg_24_1.stage_.transform)

					var_27_2.name = var_27_0
					var_27_2.transform.localPosition = Vector3.New(0, 100, 0)
					arg_24_1.actors_[var_27_0] = var_27_2

					local var_27_3 = var_27_2:GetComponentInChildren(typeof(CharacterEffect))

					var_27_3.enabled = true

					local var_27_4 = GameObjectTools.GetOrAddComponent(var_27_2, typeof(DynamicBoneHelper))

					if var_27_4 then
						var_27_4:EnableDynamicBone(false)
					end

					arg_24_1:ShowWeapon(var_27_3.transform, false)

					arg_24_1.var_[var_27_0 .. "Animator"] = var_27_3.gameObject:GetComponent(typeof(UnityEngine.Animator))
					arg_24_1.var_[var_27_0 .. "Animator"].applyRootMotion = true
					arg_24_1.var_[var_27_0 .. "LipSync"] = var_27_3.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
				end
			end

			local var_27_5 = arg_24_1.actors_["10167ui_story"].transform
			local var_27_6 = 0

			if var_27_6 < arg_24_1.time_ and arg_24_1.time_ <= var_27_6 + arg_27_0 then
				arg_24_1.var_.moveOldPos10167ui_story = var_27_5.localPosition

				local var_27_7 = GameObjectTools.GetOrAddComponent(var_27_5.gameObject, typeof(DynamicBoneHelper))

				if var_27_7 then
					var_27_7:EnableDynamicBone(false)
				end
			end

			local var_27_8 = 0.001

			if var_27_6 <= arg_24_1.time_ and arg_24_1.time_ < var_27_6 + var_27_8 then
				local var_27_9 = (arg_24_1.time_ - var_27_6) / var_27_8
				local var_27_10 = Vector3.New(0, -1.28, -5.73)

				var_27_5.localPosition = Vector3.Lerp(arg_24_1.var_.moveOldPos10167ui_story, var_27_10, var_27_9)

				local var_27_11 = manager.ui.mainCamera.transform.position - var_27_5.position

				var_27_5.forward = Vector3.New(var_27_11.x, var_27_11.y, var_27_11.z)

				local var_27_12 = var_27_5.localEulerAngles

				var_27_12.z = 0
				var_27_12.x = 0
				var_27_5.localEulerAngles = var_27_12
			end

			if arg_24_1.time_ >= var_27_6 + var_27_8 and arg_24_1.time_ < var_27_6 + var_27_8 + arg_27_0 then
				var_27_5.localPosition = Vector3.New(0, -1.28, -5.73)

				local var_27_13 = manager.ui.mainCamera.transform.position - var_27_5.position

				var_27_5.forward = Vector3.New(var_27_13.x, var_27_13.y, var_27_13.z)

				local var_27_14 = var_27_5.localEulerAngles

				var_27_14.z = 0
				var_27_14.x = 0
				var_27_5.localEulerAngles = var_27_14

				local var_27_15 = GameObjectTools.GetOrAddComponent(var_27_5.gameObject, typeof(DynamicBoneHelper))

				if var_27_15 then
					var_27_15:EnableDynamicBone(true)
				end
			end

			local var_27_16 = arg_24_1.actors_["10167ui_story"]
			local var_27_17 = 0

			if var_27_17 < arg_24_1.time_ and arg_24_1.time_ <= var_27_17 + arg_27_0 and not isNil(var_27_16) and arg_24_1.var_.characterEffect10167ui_story == nil then
				arg_24_1.var_.characterEffect10167ui_story = var_27_16:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_27_18 = 0.200000002980232

			if var_27_17 <= arg_24_1.time_ and arg_24_1.time_ < var_27_17 + var_27_18 and not isNil(var_27_16) then
				local var_27_19 = (arg_24_1.time_ - var_27_17) / var_27_18

				if arg_24_1.var_.characterEffect10167ui_story and not isNil(var_27_16) then
					arg_24_1.var_.characterEffect10167ui_story.fillFlat = false
				end
			end

			if arg_24_1.time_ >= var_27_17 + var_27_18 and arg_24_1.time_ < var_27_17 + var_27_18 + arg_27_0 and not isNil(var_27_16) and arg_24_1.var_.characterEffect10167ui_story then
				arg_24_1.var_.characterEffect10167ui_story.fillFlat = false
			end

			local var_27_20 = 0

			if var_27_20 < arg_24_1.time_ and arg_24_1.time_ <= var_27_20 + arg_27_0 then
				arg_24_1:PlayTimeline("10167ui_story", "StoryTimeline/CharAction/story10166/story10166action/10166action3_1")
			end

			local var_27_21 = 0

			if var_27_21 < arg_24_1.time_ and arg_24_1.time_ <= var_27_21 + arg_27_0 then
				arg_24_1:PlayTimeline("10167ui_story", "StoryTimeline/CharAction/public_expression/expr_kuaileA_weixiao", "EmotionTimelineAnimator")
			end

			local var_27_22 = 0
			local var_27_23 = 0.5

			if var_27_22 < arg_24_1.time_ and arg_24_1.time_ <= var_27_22 + arg_27_0 then
				arg_24_1.talkMaxDuration = 0
				arg_24_1.dialogCg_.alpha = 1

				arg_24_1.dialog_:SetActive(true)
				SetActive(arg_24_1.leftNameGo_, true)

				local var_27_24 = arg_24_1:FormatText(StoryNameCfg[1447].name)

				arg_24_1.leftNameTxt_.text = var_27_24

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_24_1.leftNameTxt_.transform)

				arg_24_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_24_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_24_1:RecordName(arg_24_1.leftNameTxt_.text)
				SetActive(arg_24_1.iconTrs_.gameObject, false)
				arg_24_1.callingController_:SetSelectedState("normal")

				local var_27_25 = arg_24_1:GetWordFromCfg(325621006)
				local var_27_26 = arg_24_1:FormatText(var_27_25.content)

				arg_24_1.text_.text = var_27_26

				LuaForUtil.ClearLinePrefixSymbol(arg_24_1.text_)

				local var_27_27 = 20
				local var_27_28 = utf8.len(var_27_26)
				local var_27_29 = var_27_27 <= 0 and var_27_23 or var_27_23 * (var_27_28 / var_27_27)

				if var_27_29 > 0 and var_27_23 < var_27_29 then
					arg_24_1.talkMaxDuration = var_27_29

					if var_27_29 + var_27_22 > arg_24_1.duration_ then
						arg_24_1.duration_ = var_27_29 + var_27_22
					end
				end

				arg_24_1.text_.text = var_27_26
				arg_24_1.typewritter.percent = 0

				arg_24_1.typewritter:SetDirty()
				arg_24_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_325621", "325621006", "story_v_out_325621.awb") ~= 0 then
					local var_27_30 = manager.audio:GetVoiceLength("story_v_out_325621", "325621006", "story_v_out_325621.awb") / 1000

					if var_27_30 + var_27_22 > arg_24_1.duration_ then
						arg_24_1.duration_ = var_27_30 + var_27_22
					end

					if var_27_25.prefab_name ~= "" and arg_24_1.actors_[var_27_25.prefab_name] ~= nil then
						local var_27_31 = LuaForUtil.PlayVoiceWithCriLipsync(arg_24_1.actors_[var_27_25.prefab_name].transform, "story_v_out_325621", "325621006", "story_v_out_325621.awb")

						arg_24_1:RecordAudio("325621006", var_27_31)
						arg_24_1:RecordAudio("325621006", var_27_31)
					else
						arg_24_1:AudioAction("play", "voice", "story_v_out_325621", "325621006", "story_v_out_325621.awb")
					end

					arg_24_1:RecordHistoryTalkVoice("story_v_out_325621", "325621006", "story_v_out_325621.awb")
				end

				arg_24_1:RecordContent(arg_24_1.text_.text)
			end

			local var_27_32 = math.max(var_27_23, arg_24_1.talkMaxDuration)

			if var_27_22 <= arg_24_1.time_ and arg_24_1.time_ < var_27_22 + var_27_32 then
				arg_24_1.typewritter.percent = (arg_24_1.time_ - var_27_22) / var_27_32

				arg_24_1.typewritter:SetDirty()
			end

			if arg_24_1.time_ >= var_27_22 + var_27_32 and arg_24_1.time_ < var_27_22 + var_27_32 + arg_27_0 then
				arg_24_1.typewritter.percent = 1

				arg_24_1.typewritter:SetDirty()
				arg_24_1:ShowNextGo(true)
			end
		end

		arg_24_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10167ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_24_1:InitPlayNodeList()
	end,
	Play325621007 = function(arg_28_0, arg_28_1)
		arg_28_1.time_ = 0
		arg_28_1.frameCnt_ = 0
		arg_28_1.state_ = "playing"
		arg_28_1.curTalkId_ = 325621007
		arg_28_1.duration_ = 5

		SetActive(arg_28_1.tipsGo_, false)

		function arg_28_1.onSingleLineFinish_()
			arg_28_1.onSingleLineUpdate_ = nil
			arg_28_1.onSingleLineFinish_ = nil
			arg_28_1.state_ = "waiting"
		end

		function arg_28_1.playNext_(arg_30_0)
			if arg_30_0 == 1 then
				arg_28_0:Play325621008(arg_28_1)
			end
		end

		function arg_28_1.onSingleLineUpdate_(arg_31_0)
			local var_31_0 = arg_28_1.actors_["10167ui_story"].transform
			local var_31_1 = 0

			if var_31_1 < arg_28_1.time_ and arg_28_1.time_ <= var_31_1 + arg_31_0 then
				arg_28_1.var_.moveOldPos10167ui_story = var_31_0.localPosition

				local var_31_2 = GameObjectTools.GetOrAddComponent(var_31_0.gameObject, typeof(DynamicBoneHelper))

				if var_31_2 then
					var_31_2:EnableDynamicBone(false)
				end
			end

			local var_31_3 = 0.001

			if var_31_1 <= arg_28_1.time_ and arg_28_1.time_ < var_31_1 + var_31_3 then
				local var_31_4 = (arg_28_1.time_ - var_31_1) / var_31_3
				local var_31_5 = Vector3.New(0, 100, 0)

				var_31_0.localPosition = Vector3.Lerp(arg_28_1.var_.moveOldPos10167ui_story, var_31_5, var_31_4)

				local var_31_6 = manager.ui.mainCamera.transform.position - var_31_0.position

				var_31_0.forward = Vector3.New(var_31_6.x, var_31_6.y, var_31_6.z)

				local var_31_7 = var_31_0.localEulerAngles

				var_31_7.z = 0
				var_31_7.x = 0
				var_31_0.localEulerAngles = var_31_7
			end

			if arg_28_1.time_ >= var_31_1 + var_31_3 and arg_28_1.time_ < var_31_1 + var_31_3 + arg_31_0 then
				var_31_0.localPosition = Vector3.New(0, 100, 0)

				local var_31_8 = manager.ui.mainCamera.transform.position - var_31_0.position

				var_31_0.forward = Vector3.New(var_31_8.x, var_31_8.y, var_31_8.z)

				local var_31_9 = var_31_0.localEulerAngles

				var_31_9.z = 0
				var_31_9.x = 0
				var_31_0.localEulerAngles = var_31_9

				local var_31_10 = GameObjectTools.GetOrAddComponent(var_31_0.gameObject, typeof(DynamicBoneHelper))

				if var_31_10 then
					var_31_10:EnableDynamicBone(true)
				end
			end

			local var_31_11 = arg_28_1.actors_["10167ui_story"]
			local var_31_12 = 0

			if var_31_12 < arg_28_1.time_ and arg_28_1.time_ <= var_31_12 + arg_31_0 and not isNil(var_31_11) and arg_28_1.var_.characterEffect10167ui_story == nil then
				arg_28_1.var_.characterEffect10167ui_story = var_31_11:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_31_13 = 0.200000002980232

			if var_31_12 <= arg_28_1.time_ and arg_28_1.time_ < var_31_12 + var_31_13 and not isNil(var_31_11) then
				local var_31_14 = (arg_28_1.time_ - var_31_12) / var_31_13

				if arg_28_1.var_.characterEffect10167ui_story and not isNil(var_31_11) then
					local var_31_15 = Mathf.Lerp(0, 0.5, var_31_14)

					arg_28_1.var_.characterEffect10167ui_story.fillFlat = true
					arg_28_1.var_.characterEffect10167ui_story.fillRatio = var_31_15
				end
			end

			if arg_28_1.time_ >= var_31_12 + var_31_13 and arg_28_1.time_ < var_31_12 + var_31_13 + arg_31_0 and not isNil(var_31_11) and arg_28_1.var_.characterEffect10167ui_story then
				local var_31_16 = 0.5

				arg_28_1.var_.characterEffect10167ui_story.fillFlat = true
				arg_28_1.var_.characterEffect10167ui_story.fillRatio = var_31_16
			end

			local var_31_17 = 0
			local var_31_18 = 1.65

			if var_31_17 < arg_28_1.time_ and arg_28_1.time_ <= var_31_17 + arg_31_0 then
				arg_28_1.talkMaxDuration = 0
				arg_28_1.dialogCg_.alpha = 1

				arg_28_1.dialog_:SetActive(true)
				SetActive(arg_28_1.leftNameGo_, false)

				arg_28_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_28_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_28_1:RecordName(arg_28_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_28_1.iconTrs_.gameObject, false)
				arg_28_1.callingController_:SetSelectedState("normal")

				local var_31_19 = arg_28_1:GetWordFromCfg(325621007)
				local var_31_20 = arg_28_1:FormatText(var_31_19.content)

				arg_28_1.text_.text = var_31_20

				LuaForUtil.ClearLinePrefixSymbol(arg_28_1.text_)

				local var_31_21 = 66
				local var_31_22 = utf8.len(var_31_20)
				local var_31_23 = var_31_21 <= 0 and var_31_18 or var_31_18 * (var_31_22 / var_31_21)

				if var_31_23 > 0 and var_31_18 < var_31_23 then
					arg_28_1.talkMaxDuration = var_31_23

					if var_31_23 + var_31_17 > arg_28_1.duration_ then
						arg_28_1.duration_ = var_31_23 + var_31_17
					end
				end

				arg_28_1.text_.text = var_31_20
				arg_28_1.typewritter.percent = 0

				arg_28_1.typewritter:SetDirty()
				arg_28_1:ShowNextGo(false)
				arg_28_1:RecordContent(arg_28_1.text_.text)
			end

			local var_31_24 = math.max(var_31_18, arg_28_1.talkMaxDuration)

			if var_31_17 <= arg_28_1.time_ and arg_28_1.time_ < var_31_17 + var_31_24 then
				arg_28_1.typewritter.percent = (arg_28_1.time_ - var_31_17) / var_31_24

				arg_28_1.typewritter:SetDirty()
			end

			if arg_28_1.time_ >= var_31_17 + var_31_24 and arg_28_1.time_ < var_31_17 + var_31_24 + arg_31_0 then
				arg_28_1.typewritter.percent = 1

				arg_28_1.typewritter:SetDirty()
				arg_28_1:ShowNextGo(true)
			end
		end

		arg_28_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10167ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_28_1:InitPlayNodeList()
	end,
	Play325621008 = function(arg_32_0, arg_32_1)
		arg_32_1.time_ = 0
		arg_32_1.frameCnt_ = 0
		arg_32_1.state_ = "playing"
		arg_32_1.curTalkId_ = 325621008
		arg_32_1.duration_ = 2

		SetActive(arg_32_1.tipsGo_, false)

		function arg_32_1.onSingleLineFinish_()
			arg_32_1.onSingleLineUpdate_ = nil
			arg_32_1.onSingleLineFinish_ = nil
			arg_32_1.state_ = "waiting"
		end

		function arg_32_1.playNext_(arg_34_0)
			if arg_34_0 == 1 then
				arg_32_0:Play325621009(arg_32_1)
			end
		end

		function arg_32_1.onSingleLineUpdate_(arg_35_0)
			local var_35_0 = arg_32_1.actors_["10167ui_story"].transform
			local var_35_1 = 0

			if var_35_1 < arg_32_1.time_ and arg_32_1.time_ <= var_35_1 + arg_35_0 then
				arg_32_1.var_.moveOldPos10167ui_story = var_35_0.localPosition

				local var_35_2 = GameObjectTools.GetOrAddComponent(var_35_0.gameObject, typeof(DynamicBoneHelper))

				if var_35_2 then
					var_35_2:EnableDynamicBone(false)
				end
			end

			local var_35_3 = 0.001

			if var_35_1 <= arg_32_1.time_ and arg_32_1.time_ < var_35_1 + var_35_3 then
				local var_35_4 = (arg_32_1.time_ - var_35_1) / var_35_3
				local var_35_5 = Vector3.New(0, -1.28, -5.73)

				var_35_0.localPosition = Vector3.Lerp(arg_32_1.var_.moveOldPos10167ui_story, var_35_5, var_35_4)

				local var_35_6 = manager.ui.mainCamera.transform.position - var_35_0.position

				var_35_0.forward = Vector3.New(var_35_6.x, var_35_6.y, var_35_6.z)

				local var_35_7 = var_35_0.localEulerAngles

				var_35_7.z = 0
				var_35_7.x = 0
				var_35_0.localEulerAngles = var_35_7
			end

			if arg_32_1.time_ >= var_35_1 + var_35_3 and arg_32_1.time_ < var_35_1 + var_35_3 + arg_35_0 then
				var_35_0.localPosition = Vector3.New(0, -1.28, -5.73)

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

			local var_35_11 = arg_32_1.actors_["10167ui_story"]
			local var_35_12 = 0

			if var_35_12 < arg_32_1.time_ and arg_32_1.time_ <= var_35_12 + arg_35_0 and not isNil(var_35_11) and arg_32_1.var_.characterEffect10167ui_story == nil then
				arg_32_1.var_.characterEffect10167ui_story = var_35_11:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_35_13 = 0.200000002980232

			if var_35_12 <= arg_32_1.time_ and arg_32_1.time_ < var_35_12 + var_35_13 and not isNil(var_35_11) then
				local var_35_14 = (arg_32_1.time_ - var_35_12) / var_35_13

				if arg_32_1.var_.characterEffect10167ui_story and not isNil(var_35_11) then
					arg_32_1.var_.characterEffect10167ui_story.fillFlat = false
				end
			end

			if arg_32_1.time_ >= var_35_12 + var_35_13 and arg_32_1.time_ < var_35_12 + var_35_13 + arg_35_0 and not isNil(var_35_11) and arg_32_1.var_.characterEffect10167ui_story then
				arg_32_1.var_.characterEffect10167ui_story.fillFlat = false
			end

			local var_35_15 = 0

			if var_35_15 < arg_32_1.time_ and arg_32_1.time_ <= var_35_15 + arg_35_0 then
				arg_32_1:PlayTimeline("10167ui_story", "StoryTimeline/CharAction/story10166/story10166action/10166action3_2")
			end

			local var_35_16 = 0

			if var_35_16 < arg_32_1.time_ and arg_32_1.time_ <= var_35_16 + arg_35_0 then
				arg_32_1:PlayTimeline("10167ui_story", "StoryTimeline/CharAction/public_expression/expr_haixiuA", "EmotionTimelineAnimator")
			end

			local var_35_17 = 0
			local var_35_18 = 0.15

			if var_35_17 < arg_32_1.time_ and arg_32_1.time_ <= var_35_17 + arg_35_0 then
				arg_32_1.talkMaxDuration = 0
				arg_32_1.dialogCg_.alpha = 1

				arg_32_1.dialog_:SetActive(true)
				SetActive(arg_32_1.leftNameGo_, true)

				local var_35_19 = arg_32_1:FormatText(StoryNameCfg[1447].name)

				arg_32_1.leftNameTxt_.text = var_35_19

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_32_1.leftNameTxt_.transform)

				arg_32_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_32_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_32_1:RecordName(arg_32_1.leftNameTxt_.text)
				SetActive(arg_32_1.iconTrs_.gameObject, false)
				arg_32_1.callingController_:SetSelectedState("normal")

				local var_35_20 = arg_32_1:GetWordFromCfg(325621008)
				local var_35_21 = arg_32_1:FormatText(var_35_20.content)

				arg_32_1.text_.text = var_35_21

				LuaForUtil.ClearLinePrefixSymbol(arg_32_1.text_)

				local var_35_22 = 6
				local var_35_23 = utf8.len(var_35_21)
				local var_35_24 = var_35_22 <= 0 and var_35_18 or var_35_18 * (var_35_23 / var_35_22)

				if var_35_24 > 0 and var_35_18 < var_35_24 then
					arg_32_1.talkMaxDuration = var_35_24

					if var_35_24 + var_35_17 > arg_32_1.duration_ then
						arg_32_1.duration_ = var_35_24 + var_35_17
					end
				end

				arg_32_1.text_.text = var_35_21
				arg_32_1.typewritter.percent = 0

				arg_32_1.typewritter:SetDirty()
				arg_32_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_325621", "325621008", "story_v_out_325621.awb") ~= 0 then
					local var_35_25 = manager.audio:GetVoiceLength("story_v_out_325621", "325621008", "story_v_out_325621.awb") / 1000

					if var_35_25 + var_35_17 > arg_32_1.duration_ then
						arg_32_1.duration_ = var_35_25 + var_35_17
					end

					if var_35_20.prefab_name ~= "" and arg_32_1.actors_[var_35_20.prefab_name] ~= nil then
						local var_35_26 = LuaForUtil.PlayVoiceWithCriLipsync(arg_32_1.actors_[var_35_20.prefab_name].transform, "story_v_out_325621", "325621008", "story_v_out_325621.awb")

						arg_32_1:RecordAudio("325621008", var_35_26)
						arg_32_1:RecordAudio("325621008", var_35_26)
					else
						arg_32_1:AudioAction("play", "voice", "story_v_out_325621", "325621008", "story_v_out_325621.awb")
					end

					arg_32_1:RecordHistoryTalkVoice("story_v_out_325621", "325621008", "story_v_out_325621.awb")
				end

				arg_32_1:RecordContent(arg_32_1.text_.text)
			end

			local var_35_27 = math.max(var_35_18, arg_32_1.talkMaxDuration)

			if var_35_17 <= arg_32_1.time_ and arg_32_1.time_ < var_35_17 + var_35_27 then
				arg_32_1.typewritter.percent = (arg_32_1.time_ - var_35_17) / var_35_27

				arg_32_1.typewritter:SetDirty()
			end

			if arg_32_1.time_ >= var_35_17 + var_35_27 and arg_32_1.time_ < var_35_17 + var_35_27 + arg_35_0 then
				arg_32_1.typewritter.percent = 1

				arg_32_1.typewritter:SetDirty()
				arg_32_1:ShowNextGo(true)
			end
		end

		arg_32_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10167ui_story",
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
	Play325621009 = function(arg_36_0, arg_36_1)
		arg_36_1.time_ = 0
		arg_36_1.frameCnt_ = 0
		arg_36_1.state_ = "playing"
		arg_36_1.curTalkId_ = 325621009
		arg_36_1.duration_ = 3.9

		local var_36_0 = {
			zh = 3.366,
			ja = 3.9
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
				arg_36_0:Play325621010(arg_36_1)
			end
		end

		function arg_36_1.onSingleLineUpdate_(arg_39_0)
			local var_39_0 = arg_36_1.actors_["10167ui_story"].transform
			local var_39_1 = 0

			if var_39_1 < arg_36_1.time_ and arg_36_1.time_ <= var_39_1 + arg_39_0 then
				arg_36_1.var_.moveOldPos10167ui_story = var_39_0.localPosition

				local var_39_2 = GameObjectTools.GetOrAddComponent(var_39_0.gameObject, typeof(DynamicBoneHelper))

				if var_39_2 then
					var_39_2:EnableDynamicBone(false)
				end
			end

			local var_39_3 = 0.001

			if var_39_1 <= arg_36_1.time_ and arg_36_1.time_ < var_39_1 + var_39_3 then
				local var_39_4 = (arg_36_1.time_ - var_39_1) / var_39_3
				local var_39_5 = Vector3.New(0, 100, 0)

				var_39_0.localPosition = Vector3.Lerp(arg_36_1.var_.moveOldPos10167ui_story, var_39_5, var_39_4)

				local var_39_6 = manager.ui.mainCamera.transform.position - var_39_0.position

				var_39_0.forward = Vector3.New(var_39_6.x, var_39_6.y, var_39_6.z)

				local var_39_7 = var_39_0.localEulerAngles

				var_39_7.z = 0
				var_39_7.x = 0
				var_39_0.localEulerAngles = var_39_7
			end

			if arg_36_1.time_ >= var_39_1 + var_39_3 and arg_36_1.time_ < var_39_1 + var_39_3 + arg_39_0 then
				var_39_0.localPosition = Vector3.New(0, 100, 0)

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

			local var_39_11 = arg_36_1.actors_["10165ui_story"].transform
			local var_39_12 = 0

			if var_39_12 < arg_36_1.time_ and arg_36_1.time_ <= var_39_12 + arg_39_0 then
				arg_36_1.var_.moveOldPos10165ui_story = var_39_11.localPosition

				local var_39_13 = GameObjectTools.GetOrAddComponent(var_39_11.gameObject, typeof(DynamicBoneHelper))

				if var_39_13 then
					var_39_13:EnableDynamicBone(false)
				end
			end

			local var_39_14 = 0.001

			if var_39_12 <= arg_36_1.time_ and arg_36_1.time_ < var_39_12 + var_39_14 then
				local var_39_15 = (arg_36_1.time_ - var_39_12) / var_39_14
				local var_39_16 = Vector3.New(0, -1.08, -5.83)

				var_39_11.localPosition = Vector3.Lerp(arg_36_1.var_.moveOldPos10165ui_story, var_39_16, var_39_15)

				local var_39_17 = manager.ui.mainCamera.transform.position - var_39_11.position

				var_39_11.forward = Vector3.New(var_39_17.x, var_39_17.y, var_39_17.z)

				local var_39_18 = var_39_11.localEulerAngles

				var_39_18.z = 0
				var_39_18.x = 0
				var_39_11.localEulerAngles = var_39_18
			end

			if arg_36_1.time_ >= var_39_12 + var_39_14 and arg_36_1.time_ < var_39_12 + var_39_14 + arg_39_0 then
				var_39_11.localPosition = Vector3.New(0, -1.08, -5.83)

				local var_39_19 = manager.ui.mainCamera.transform.position - var_39_11.position

				var_39_11.forward = Vector3.New(var_39_19.x, var_39_19.y, var_39_19.z)

				local var_39_20 = var_39_11.localEulerAngles

				var_39_20.z = 0
				var_39_20.x = 0
				var_39_11.localEulerAngles = var_39_20

				local var_39_21 = GameObjectTools.GetOrAddComponent(var_39_11.gameObject, typeof(DynamicBoneHelper))

				if var_39_21 then
					var_39_21:EnableDynamicBone(true)
				end
			end

			local var_39_22 = arg_36_1.actors_["10165ui_story"]
			local var_39_23 = 0

			if var_39_23 < arg_36_1.time_ and arg_36_1.time_ <= var_39_23 + arg_39_0 and not isNil(var_39_22) and arg_36_1.var_.characterEffect10165ui_story == nil then
				arg_36_1.var_.characterEffect10165ui_story = var_39_22:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_39_24 = 0.200000002980232

			if var_39_23 <= arg_36_1.time_ and arg_36_1.time_ < var_39_23 + var_39_24 and not isNil(var_39_22) then
				local var_39_25 = (arg_36_1.time_ - var_39_23) / var_39_24

				if arg_36_1.var_.characterEffect10165ui_story and not isNil(var_39_22) then
					arg_36_1.var_.characterEffect10165ui_story.fillFlat = false
				end
			end

			if arg_36_1.time_ >= var_39_23 + var_39_24 and arg_36_1.time_ < var_39_23 + var_39_24 + arg_39_0 and not isNil(var_39_22) and arg_36_1.var_.characterEffect10165ui_story then
				arg_36_1.var_.characterEffect10165ui_story.fillFlat = false
			end

			local var_39_26 = arg_36_1.actors_["10167ui_story"]
			local var_39_27 = 0

			if var_39_27 < arg_36_1.time_ and arg_36_1.time_ <= var_39_27 + arg_39_0 and not isNil(var_39_26) and arg_36_1.var_.characterEffect10167ui_story == nil then
				arg_36_1.var_.characterEffect10167ui_story = var_39_26:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_39_28 = 0.200000002980232

			if var_39_27 <= arg_36_1.time_ and arg_36_1.time_ < var_39_27 + var_39_28 and not isNil(var_39_26) then
				local var_39_29 = (arg_36_1.time_ - var_39_27) / var_39_28

				if arg_36_1.var_.characterEffect10167ui_story and not isNil(var_39_26) then
					local var_39_30 = Mathf.Lerp(0, 0.5, var_39_29)

					arg_36_1.var_.characterEffect10167ui_story.fillFlat = true
					arg_36_1.var_.characterEffect10167ui_story.fillRatio = var_39_30
				end
			end

			if arg_36_1.time_ >= var_39_27 + var_39_28 and arg_36_1.time_ < var_39_27 + var_39_28 + arg_39_0 and not isNil(var_39_26) and arg_36_1.var_.characterEffect10167ui_story then
				local var_39_31 = 0.5

				arg_36_1.var_.characterEffect10167ui_story.fillFlat = true
				arg_36_1.var_.characterEffect10167ui_story.fillRatio = var_39_31
			end

			local var_39_32 = 0

			if var_39_32 < arg_36_1.time_ and arg_36_1.time_ <= var_39_32 + arg_39_0 then
				arg_36_1:PlayTimeline("10165ui_story", "StoryTimeline/CharAction/story10162/story10162action/10162action15_2")
			end

			local var_39_33 = 0

			if var_39_33 < arg_36_1.time_ and arg_36_1.time_ <= var_39_33 + arg_39_0 then
				arg_36_1:PlayTimeline("10165ui_story", "StoryTimeline/CharAction/public_expression/expr_nanguoA", "EmotionTimelineAnimator")
			end

			local var_39_34 = 0
			local var_39_35 = 0.175

			if var_39_34 < arg_36_1.time_ and arg_36_1.time_ <= var_39_34 + arg_39_0 then
				arg_36_1.talkMaxDuration = 0
				arg_36_1.dialogCg_.alpha = 1

				arg_36_1.dialog_:SetActive(true)
				SetActive(arg_36_1.leftNameGo_, true)

				local var_39_36 = arg_36_1:FormatText(StoryNameCfg[1446].name)

				arg_36_1.leftNameTxt_.text = var_39_36

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_36_1.leftNameTxt_.transform)

				arg_36_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_36_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_36_1:RecordName(arg_36_1.leftNameTxt_.text)
				SetActive(arg_36_1.iconTrs_.gameObject, false)
				arg_36_1.callingController_:SetSelectedState("normal")

				local var_39_37 = arg_36_1:GetWordFromCfg(325621009)
				local var_39_38 = arg_36_1:FormatText(var_39_37.content)

				arg_36_1.text_.text = var_39_38

				LuaForUtil.ClearLinePrefixSymbol(arg_36_1.text_)

				local var_39_39 = 7
				local var_39_40 = utf8.len(var_39_38)
				local var_39_41 = var_39_39 <= 0 and var_39_35 or var_39_35 * (var_39_40 / var_39_39)

				if var_39_41 > 0 and var_39_35 < var_39_41 then
					arg_36_1.talkMaxDuration = var_39_41

					if var_39_41 + var_39_34 > arg_36_1.duration_ then
						arg_36_1.duration_ = var_39_41 + var_39_34
					end
				end

				arg_36_1.text_.text = var_39_38
				arg_36_1.typewritter.percent = 0

				arg_36_1.typewritter:SetDirty()
				arg_36_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_325621", "325621009", "story_v_out_325621.awb") ~= 0 then
					local var_39_42 = manager.audio:GetVoiceLength("story_v_out_325621", "325621009", "story_v_out_325621.awb") / 1000

					if var_39_42 + var_39_34 > arg_36_1.duration_ then
						arg_36_1.duration_ = var_39_42 + var_39_34
					end

					if var_39_37.prefab_name ~= "" and arg_36_1.actors_[var_39_37.prefab_name] ~= nil then
						local var_39_43 = LuaForUtil.PlayVoiceWithCriLipsync(arg_36_1.actors_[var_39_37.prefab_name].transform, "story_v_out_325621", "325621009", "story_v_out_325621.awb")

						arg_36_1:RecordAudio("325621009", var_39_43)
						arg_36_1:RecordAudio("325621009", var_39_43)
					else
						arg_36_1:AudioAction("play", "voice", "story_v_out_325621", "325621009", "story_v_out_325621.awb")
					end

					arg_36_1:RecordHistoryTalkVoice("story_v_out_325621", "325621009", "story_v_out_325621.awb")
				end

				arg_36_1:RecordContent(arg_36_1.text_.text)
			end

			local var_39_44 = math.max(var_39_35, arg_36_1.talkMaxDuration)

			if var_39_34 <= arg_36_1.time_ and arg_36_1.time_ < var_39_34 + var_39_44 then
				arg_36_1.typewritter.percent = (arg_36_1.time_ - var_39_34) / var_39_44

				arg_36_1.typewritter:SetDirty()
			end

			if arg_36_1.time_ >= var_39_34 + var_39_44 and arg_36_1.time_ < var_39_34 + var_39_44 + arg_39_0 then
				arg_36_1.typewritter.percent = 1

				arg_36_1.typewritter:SetDirty()
				arg_36_1:ShowNextGo(true)
			end
		end

		arg_36_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10167ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "10165ui_story",
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
	Play325621010 = function(arg_40_0, arg_40_1)
		arg_40_1.time_ = 0
		arg_40_1.frameCnt_ = 0
		arg_40_1.state_ = "playing"
		arg_40_1.curTalkId_ = 325621010
		arg_40_1.duration_ = 5

		SetActive(arg_40_1.tipsGo_, false)

		function arg_40_1.onSingleLineFinish_()
			arg_40_1.onSingleLineUpdate_ = nil
			arg_40_1.onSingleLineFinish_ = nil
			arg_40_1.state_ = "waiting"
		end

		function arg_40_1.playNext_(arg_42_0)
			if arg_42_0 == 1 then
				arg_40_0:Play325621011(arg_40_1)
			end
		end

		function arg_40_1.onSingleLineUpdate_(arg_43_0)
			local var_43_0 = arg_40_1.actors_["10165ui_story"].transform
			local var_43_1 = 0

			if var_43_1 < arg_40_1.time_ and arg_40_1.time_ <= var_43_1 + arg_43_0 then
				arg_40_1.var_.moveOldPos10165ui_story = var_43_0.localPosition

				local var_43_2 = GameObjectTools.GetOrAddComponent(var_43_0.gameObject, typeof(DynamicBoneHelper))

				if var_43_2 then
					var_43_2:EnableDynamicBone(false)
				end
			end

			local var_43_3 = 0.001

			if var_43_1 <= arg_40_1.time_ and arg_40_1.time_ < var_43_1 + var_43_3 then
				local var_43_4 = (arg_40_1.time_ - var_43_1) / var_43_3
				local var_43_5 = Vector3.New(0, 100, 0)

				var_43_0.localPosition = Vector3.Lerp(arg_40_1.var_.moveOldPos10165ui_story, var_43_5, var_43_4)

				local var_43_6 = manager.ui.mainCamera.transform.position - var_43_0.position

				var_43_0.forward = Vector3.New(var_43_6.x, var_43_6.y, var_43_6.z)

				local var_43_7 = var_43_0.localEulerAngles

				var_43_7.z = 0
				var_43_7.x = 0
				var_43_0.localEulerAngles = var_43_7
			end

			if arg_40_1.time_ >= var_43_1 + var_43_3 and arg_40_1.time_ < var_43_1 + var_43_3 + arg_43_0 then
				var_43_0.localPosition = Vector3.New(0, 100, 0)

				local var_43_8 = manager.ui.mainCamera.transform.position - var_43_0.position

				var_43_0.forward = Vector3.New(var_43_8.x, var_43_8.y, var_43_8.z)

				local var_43_9 = var_43_0.localEulerAngles

				var_43_9.z = 0
				var_43_9.x = 0
				var_43_0.localEulerAngles = var_43_9

				local var_43_10 = GameObjectTools.GetOrAddComponent(var_43_0.gameObject, typeof(DynamicBoneHelper))

				if var_43_10 then
					var_43_10:EnableDynamicBone(true)
				end
			end

			local var_43_11 = arg_40_1.actors_["10165ui_story"]
			local var_43_12 = 0

			if var_43_12 < arg_40_1.time_ and arg_40_1.time_ <= var_43_12 + arg_43_0 and not isNil(var_43_11) and arg_40_1.var_.characterEffect10165ui_story == nil then
				arg_40_1.var_.characterEffect10165ui_story = var_43_11:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_43_13 = 0.200000002980232

			if var_43_12 <= arg_40_1.time_ and arg_40_1.time_ < var_43_12 + var_43_13 and not isNil(var_43_11) then
				local var_43_14 = (arg_40_1.time_ - var_43_12) / var_43_13

				if arg_40_1.var_.characterEffect10165ui_story and not isNil(var_43_11) then
					local var_43_15 = Mathf.Lerp(0, 0.5, var_43_14)

					arg_40_1.var_.characterEffect10165ui_story.fillFlat = true
					arg_40_1.var_.characterEffect10165ui_story.fillRatio = var_43_15
				end
			end

			if arg_40_1.time_ >= var_43_12 + var_43_13 and arg_40_1.time_ < var_43_12 + var_43_13 + arg_43_0 and not isNil(var_43_11) and arg_40_1.var_.characterEffect10165ui_story then
				local var_43_16 = 0.5

				arg_40_1.var_.characterEffect10165ui_story.fillFlat = true
				arg_40_1.var_.characterEffect10165ui_story.fillRatio = var_43_16
			end

			local var_43_17 = 0
			local var_43_18 = 0.85

			if var_43_17 < arg_40_1.time_ and arg_40_1.time_ <= var_43_17 + arg_43_0 then
				arg_40_1.talkMaxDuration = 0
				arg_40_1.dialogCg_.alpha = 1

				arg_40_1.dialog_:SetActive(true)
				SetActive(arg_40_1.leftNameGo_, false)

				arg_40_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_40_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_40_1:RecordName(arg_40_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_40_1.iconTrs_.gameObject, false)
				arg_40_1.callingController_:SetSelectedState("normal")

				local var_43_19 = arg_40_1:GetWordFromCfg(325621010)
				local var_43_20 = arg_40_1:FormatText(var_43_19.content)

				arg_40_1.text_.text = var_43_20

				LuaForUtil.ClearLinePrefixSymbol(arg_40_1.text_)

				local var_43_21 = 34
				local var_43_22 = utf8.len(var_43_20)
				local var_43_23 = var_43_21 <= 0 and var_43_18 or var_43_18 * (var_43_22 / var_43_21)

				if var_43_23 > 0 and var_43_18 < var_43_23 then
					arg_40_1.talkMaxDuration = var_43_23

					if var_43_23 + var_43_17 > arg_40_1.duration_ then
						arg_40_1.duration_ = var_43_23 + var_43_17
					end
				end

				arg_40_1.text_.text = var_43_20
				arg_40_1.typewritter.percent = 0

				arg_40_1.typewritter:SetDirty()
				arg_40_1:ShowNextGo(false)
				arg_40_1:RecordContent(arg_40_1.text_.text)
			end

			local var_43_24 = math.max(var_43_18, arg_40_1.talkMaxDuration)

			if var_43_17 <= arg_40_1.time_ and arg_40_1.time_ < var_43_17 + var_43_24 then
				arg_40_1.typewritter.percent = (arg_40_1.time_ - var_43_17) / var_43_24

				arg_40_1.typewritter:SetDirty()
			end

			if arg_40_1.time_ >= var_43_17 + var_43_24 and arg_40_1.time_ < var_43_17 + var_43_24 + arg_43_0 then
				arg_40_1.typewritter.percent = 1

				arg_40_1.typewritter:SetDirty()
				arg_40_1:ShowNextGo(true)
			end
		end

		arg_40_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10165ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_40_1:InitPlayNodeList()
	end,
	Play325621011 = function(arg_44_0, arg_44_1)
		arg_44_1.time_ = 0
		arg_44_1.frameCnt_ = 0
		arg_44_1.state_ = "playing"
		arg_44_1.curTalkId_ = 325621011
		arg_44_1.duration_ = 5

		SetActive(arg_44_1.tipsGo_, false)

		function arg_44_1.onSingleLineFinish_()
			arg_44_1.onSingleLineUpdate_ = nil
			arg_44_1.onSingleLineFinish_ = nil
			arg_44_1.state_ = "waiting"
		end

		function arg_44_1.playNext_(arg_46_0)
			if arg_46_0 == 1 then
				arg_44_0:Play325621012(arg_44_1)
			end
		end

		function arg_44_1.onSingleLineUpdate_(arg_47_0)
			local var_47_0 = 0
			local var_47_1 = 1.075

			if var_47_0 < arg_44_1.time_ and arg_44_1.time_ <= var_47_0 + arg_47_0 then
				arg_44_1.talkMaxDuration = 0
				arg_44_1.dialogCg_.alpha = 1

				arg_44_1.dialog_:SetActive(true)
				SetActive(arg_44_1.leftNameGo_, true)

				local var_47_2 = arg_44_1:FormatText(StoryNameCfg[7].name)

				arg_44_1.leftNameTxt_.text = var_47_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_44_1.leftNameTxt_.transform)

				arg_44_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_44_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_44_1:RecordName(arg_44_1.leftNameTxt_.text)
				SetActive(arg_44_1.iconTrs_.gameObject, true)
				arg_44_1.iconController_:SetSelectedState("hero")

				arg_44_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_44_1.callingController_:SetSelectedState("normal")

				arg_44_1.keyicon_.color = Color.New(1, 1, 1)
				arg_44_1.icon_.color = Color.New(1, 1, 1)

				local var_47_3 = arg_44_1:GetWordFromCfg(325621011)
				local var_47_4 = arg_44_1:FormatText(var_47_3.content)

				arg_44_1.text_.text = var_47_4

				LuaForUtil.ClearLinePrefixSymbol(arg_44_1.text_)

				local var_47_5 = 43
				local var_47_6 = utf8.len(var_47_4)
				local var_47_7 = var_47_5 <= 0 and var_47_1 or var_47_1 * (var_47_6 / var_47_5)

				if var_47_7 > 0 and var_47_1 < var_47_7 then
					arg_44_1.talkMaxDuration = var_47_7

					if var_47_7 + var_47_0 > arg_44_1.duration_ then
						arg_44_1.duration_ = var_47_7 + var_47_0
					end
				end

				arg_44_1.text_.text = var_47_4
				arg_44_1.typewritter.percent = 0

				arg_44_1.typewritter:SetDirty()
				arg_44_1:ShowNextGo(false)
				arg_44_1:RecordContent(arg_44_1.text_.text)
			end

			local var_47_8 = math.max(var_47_1, arg_44_1.talkMaxDuration)

			if var_47_0 <= arg_44_1.time_ and arg_44_1.time_ < var_47_0 + var_47_8 then
				arg_44_1.typewritter.percent = (arg_44_1.time_ - var_47_0) / var_47_8

				arg_44_1.typewritter:SetDirty()
			end

			if arg_44_1.time_ >= var_47_0 + var_47_8 and arg_44_1.time_ < var_47_0 + var_47_8 + arg_47_0 then
				arg_44_1.typewritter.percent = 1

				arg_44_1.typewritter:SetDirty()
				arg_44_1:ShowNextGo(true)
			end
		end

		arg_44_1.nodeConfigList_ = {}

		arg_44_1:InitPlayNodeList()
	end,
	Play325621012 = function(arg_48_0, arg_48_1)
		arg_48_1.time_ = 0
		arg_48_1.frameCnt_ = 0
		arg_48_1.state_ = "playing"
		arg_48_1.curTalkId_ = 325621012
		arg_48_1.duration_ = 7.53

		local var_48_0 = {
			zh = 6.566,
			ja = 7.533
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
				arg_48_0:Play325621013(arg_48_1)
			end
		end

		function arg_48_1.onSingleLineUpdate_(arg_51_0)
			local var_51_0 = "1170ui_story"

			if arg_48_1.actors_[var_51_0] == nil then
				local var_51_1 = Asset.Load("Char/" .. "1170ui_story")

				if not isNil(var_51_1) then
					local var_51_2 = Object.Instantiate(Asset.Load("Char/" .. "1170ui_story"), arg_48_1.stage_.transform)

					var_51_2.name = var_51_0
					var_51_2.transform.localPosition = Vector3.New(0, 100, 0)
					arg_48_1.actors_[var_51_0] = var_51_2

					local var_51_3 = var_51_2:GetComponentInChildren(typeof(CharacterEffect))

					var_51_3.enabled = true

					local var_51_4 = GameObjectTools.GetOrAddComponent(var_51_2, typeof(DynamicBoneHelper))

					if var_51_4 then
						var_51_4:EnableDynamicBone(false)
					end

					arg_48_1:ShowWeapon(var_51_3.transform, false)

					arg_48_1.var_[var_51_0 .. "Animator"] = var_51_3.gameObject:GetComponent(typeof(UnityEngine.Animator))
					arg_48_1.var_[var_51_0 .. "Animator"].applyRootMotion = true
					arg_48_1.var_[var_51_0 .. "LipSync"] = var_51_3.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
				end
			end

			local var_51_5 = arg_48_1.actors_["1170ui_story"].transform
			local var_51_6 = 0

			if var_51_6 < arg_48_1.time_ and arg_48_1.time_ <= var_51_6 + arg_51_0 then
				arg_48_1.var_.moveOldPos1170ui_story = var_51_5.localPosition

				local var_51_7 = GameObjectTools.GetOrAddComponent(var_51_5.gameObject, typeof(DynamicBoneHelper))

				if var_51_7 then
					var_51_7:EnableDynamicBone(false)
				end
			end

			local var_51_8 = 0.001

			if var_51_6 <= arg_48_1.time_ and arg_48_1.time_ < var_51_6 + var_51_8 then
				local var_51_9 = (arg_48_1.time_ - var_51_6) / var_51_8
				local var_51_10 = Vector3.New(0.03, -0.95, -6.08)

				var_51_5.localPosition = Vector3.Lerp(arg_48_1.var_.moveOldPos1170ui_story, var_51_10, var_51_9)

				local var_51_11 = manager.ui.mainCamera.transform.position - var_51_5.position

				var_51_5.forward = Vector3.New(var_51_11.x, var_51_11.y, var_51_11.z)

				local var_51_12 = var_51_5.localEulerAngles

				var_51_12.z = 0
				var_51_12.x = 0
				var_51_5.localEulerAngles = var_51_12
			end

			if arg_48_1.time_ >= var_51_6 + var_51_8 and arg_48_1.time_ < var_51_6 + var_51_8 + arg_51_0 then
				var_51_5.localPosition = Vector3.New(0.03, -0.95, -6.08)

				local var_51_13 = manager.ui.mainCamera.transform.position - var_51_5.position

				var_51_5.forward = Vector3.New(var_51_13.x, var_51_13.y, var_51_13.z)

				local var_51_14 = var_51_5.localEulerAngles

				var_51_14.z = 0
				var_51_14.x = 0
				var_51_5.localEulerAngles = var_51_14

				local var_51_15 = GameObjectTools.GetOrAddComponent(var_51_5.gameObject, typeof(DynamicBoneHelper))

				if var_51_15 then
					var_51_15:EnableDynamicBone(true)
				end
			end

			local var_51_16 = arg_48_1.actors_["1170ui_story"]
			local var_51_17 = 0

			if var_51_17 < arg_48_1.time_ and arg_48_1.time_ <= var_51_17 + arg_51_0 and not isNil(var_51_16) and arg_48_1.var_.characterEffect1170ui_story == nil then
				arg_48_1.var_.characterEffect1170ui_story = var_51_16:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_51_18 = 0.200000002980232

			if var_51_17 <= arg_48_1.time_ and arg_48_1.time_ < var_51_17 + var_51_18 and not isNil(var_51_16) then
				local var_51_19 = (arg_48_1.time_ - var_51_17) / var_51_18

				if arg_48_1.var_.characterEffect1170ui_story and not isNil(var_51_16) then
					arg_48_1.var_.characterEffect1170ui_story.fillFlat = false
				end
			end

			if arg_48_1.time_ >= var_51_17 + var_51_18 and arg_48_1.time_ < var_51_17 + var_51_18 + arg_51_0 and not isNil(var_51_16) and arg_48_1.var_.characterEffect1170ui_story then
				arg_48_1.var_.characterEffect1170ui_story.fillFlat = false
			end

			local var_51_20 = 0

			if var_51_20 < arg_48_1.time_ and arg_48_1.time_ <= var_51_20 + arg_51_0 then
				arg_48_1:PlayTimeline("1170ui_story", "StoryTimeline/CharAction/story1170/story1170action/1170action3_1")
			end

			local var_51_21 = 0

			if var_51_21 < arg_48_1.time_ and arg_48_1.time_ <= var_51_21 + arg_51_0 then
				arg_48_1:PlayTimeline("1170ui_story", "StoryTimeline/CharAction/public_expression/expr_kuaileA_weixiao", "EmotionTimelineAnimator")
			end

			local var_51_22 = 0
			local var_51_23 = 0.6

			if var_51_22 < arg_48_1.time_ and arg_48_1.time_ <= var_51_22 + arg_51_0 then
				arg_48_1.talkMaxDuration = 0
				arg_48_1.dialogCg_.alpha = 1

				arg_48_1.dialog_:SetActive(true)
				SetActive(arg_48_1.leftNameGo_, true)

				local var_51_24 = arg_48_1:FormatText(StoryNameCfg[318].name)

				arg_48_1.leftNameTxt_.text = var_51_24

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_48_1.leftNameTxt_.transform)

				arg_48_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_48_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_48_1:RecordName(arg_48_1.leftNameTxt_.text)
				SetActive(arg_48_1.iconTrs_.gameObject, false)
				arg_48_1.callingController_:SetSelectedState("normal")

				local var_51_25 = arg_48_1:GetWordFromCfg(325621012)
				local var_51_26 = arg_48_1:FormatText(var_51_25.content)

				arg_48_1.text_.text = var_51_26

				LuaForUtil.ClearLinePrefixSymbol(arg_48_1.text_)

				local var_51_27 = 23
				local var_51_28 = utf8.len(var_51_26)
				local var_51_29 = var_51_27 <= 0 and var_51_23 or var_51_23 * (var_51_28 / var_51_27)

				if var_51_29 > 0 and var_51_23 < var_51_29 then
					arg_48_1.talkMaxDuration = var_51_29

					if var_51_29 + var_51_22 > arg_48_1.duration_ then
						arg_48_1.duration_ = var_51_29 + var_51_22
					end
				end

				arg_48_1.text_.text = var_51_26
				arg_48_1.typewritter.percent = 0

				arg_48_1.typewritter:SetDirty()
				arg_48_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_325621", "325621012", "story_v_out_325621.awb") ~= 0 then
					local var_51_30 = manager.audio:GetVoiceLength("story_v_out_325621", "325621012", "story_v_out_325621.awb") / 1000

					if var_51_30 + var_51_22 > arg_48_1.duration_ then
						arg_48_1.duration_ = var_51_30 + var_51_22
					end

					if var_51_25.prefab_name ~= "" and arg_48_1.actors_[var_51_25.prefab_name] ~= nil then
						local var_51_31 = LuaForUtil.PlayVoiceWithCriLipsync(arg_48_1.actors_[var_51_25.prefab_name].transform, "story_v_out_325621", "325621012", "story_v_out_325621.awb")

						arg_48_1:RecordAudio("325621012", var_51_31)
						arg_48_1:RecordAudio("325621012", var_51_31)
					else
						arg_48_1:AudioAction("play", "voice", "story_v_out_325621", "325621012", "story_v_out_325621.awb")
					end

					arg_48_1:RecordHistoryTalkVoice("story_v_out_325621", "325621012", "story_v_out_325621.awb")
				end

				arg_48_1:RecordContent(arg_48_1.text_.text)
			end

			local var_51_32 = math.max(var_51_23, arg_48_1.talkMaxDuration)

			if var_51_22 <= arg_48_1.time_ and arg_48_1.time_ < var_51_22 + var_51_32 then
				arg_48_1.typewritter.percent = (arg_48_1.time_ - var_51_22) / var_51_32

				arg_48_1.typewritter:SetDirty()
			end

			if arg_48_1.time_ >= var_51_22 + var_51_32 and arg_48_1.time_ < var_51_22 + var_51_32 + arg_51_0 then
				arg_48_1.typewritter.percent = 1

				arg_48_1.typewritter:SetDirty()
				arg_48_1:ShowNextGo(true)
			end
		end

		arg_48_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1170ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_48_1:InitPlayNodeList()
	end,
	Play325621013 = function(arg_52_0, arg_52_1)
		arg_52_1.time_ = 0
		arg_52_1.frameCnt_ = 0
		arg_52_1.state_ = "playing"
		arg_52_1.curTalkId_ = 325621013
		arg_52_1.duration_ = 5

		SetActive(arg_52_1.tipsGo_, false)

		function arg_52_1.onSingleLineFinish_()
			arg_52_1.onSingleLineUpdate_ = nil
			arg_52_1.onSingleLineFinish_ = nil
			arg_52_1.state_ = "waiting"
		end

		function arg_52_1.playNext_(arg_54_0)
			if arg_54_0 == 1 then
				arg_52_0:Play325621014(arg_52_1)
			end
		end

		function arg_52_1.onSingleLineUpdate_(arg_55_0)
			local var_55_0 = arg_52_1.actors_["1170ui_story"]
			local var_55_1 = 0

			if var_55_1 < arg_52_1.time_ and arg_52_1.time_ <= var_55_1 + arg_55_0 and not isNil(var_55_0) and arg_52_1.var_.characterEffect1170ui_story == nil then
				arg_52_1.var_.characterEffect1170ui_story = var_55_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_55_2 = 0.200000002980232

			if var_55_1 <= arg_52_1.time_ and arg_52_1.time_ < var_55_1 + var_55_2 and not isNil(var_55_0) then
				local var_55_3 = (arg_52_1.time_ - var_55_1) / var_55_2

				if arg_52_1.var_.characterEffect1170ui_story and not isNil(var_55_0) then
					local var_55_4 = Mathf.Lerp(0, 0.5, var_55_3)

					arg_52_1.var_.characterEffect1170ui_story.fillFlat = true
					arg_52_1.var_.characterEffect1170ui_story.fillRatio = var_55_4
				end
			end

			if arg_52_1.time_ >= var_55_1 + var_55_2 and arg_52_1.time_ < var_55_1 + var_55_2 + arg_55_0 and not isNil(var_55_0) and arg_52_1.var_.characterEffect1170ui_story then
				local var_55_5 = 0.5

				arg_52_1.var_.characterEffect1170ui_story.fillFlat = true
				arg_52_1.var_.characterEffect1170ui_story.fillRatio = var_55_5
			end

			local var_55_6 = 0
			local var_55_7 = 0.275

			if var_55_6 < arg_52_1.time_ and arg_52_1.time_ <= var_55_6 + arg_55_0 then
				arg_52_1.talkMaxDuration = 0
				arg_52_1.dialogCg_.alpha = 1

				arg_52_1.dialog_:SetActive(true)
				SetActive(arg_52_1.leftNameGo_, true)

				local var_55_8 = arg_52_1:FormatText(StoryNameCfg[7].name)

				arg_52_1.leftNameTxt_.text = var_55_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_52_1.leftNameTxt_.transform)

				arg_52_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_52_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_52_1:RecordName(arg_52_1.leftNameTxt_.text)
				SetActive(arg_52_1.iconTrs_.gameObject, true)
				arg_52_1.iconController_:SetSelectedState("hero")

				arg_52_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_52_1.callingController_:SetSelectedState("normal")

				arg_52_1.keyicon_.color = Color.New(1, 1, 1)
				arg_52_1.icon_.color = Color.New(1, 1, 1)

				local var_55_9 = arg_52_1:GetWordFromCfg(325621013)
				local var_55_10 = arg_52_1:FormatText(var_55_9.content)

				arg_52_1.text_.text = var_55_10

				LuaForUtil.ClearLinePrefixSymbol(arg_52_1.text_)

				local var_55_11 = 11
				local var_55_12 = utf8.len(var_55_10)
				local var_55_13 = var_55_11 <= 0 and var_55_7 or var_55_7 * (var_55_12 / var_55_11)

				if var_55_13 > 0 and var_55_7 < var_55_13 then
					arg_52_1.talkMaxDuration = var_55_13

					if var_55_13 + var_55_6 > arg_52_1.duration_ then
						arg_52_1.duration_ = var_55_13 + var_55_6
					end
				end

				arg_52_1.text_.text = var_55_10
				arg_52_1.typewritter.percent = 0

				arg_52_1.typewritter:SetDirty()
				arg_52_1:ShowNextGo(false)
				arg_52_1:RecordContent(arg_52_1.text_.text)
			end

			local var_55_14 = math.max(var_55_7, arg_52_1.talkMaxDuration)

			if var_55_6 <= arg_52_1.time_ and arg_52_1.time_ < var_55_6 + var_55_14 then
				arg_52_1.typewritter.percent = (arg_52_1.time_ - var_55_6) / var_55_14

				arg_52_1.typewritter:SetDirty()
			end

			if arg_52_1.time_ >= var_55_6 + var_55_14 and arg_52_1.time_ < var_55_6 + var_55_14 + arg_55_0 then
				arg_52_1.typewritter.percent = 1

				arg_52_1.typewritter:SetDirty()
				arg_52_1:ShowNextGo(true)
			end
		end

		arg_52_1.nodeConfigList_ = {}

		arg_52_1:InitPlayNodeList()
	end,
	Play325621014 = function(arg_56_0, arg_56_1)
		arg_56_1.time_ = 0
		arg_56_1.frameCnt_ = 0
		arg_56_1.state_ = "playing"
		arg_56_1.curTalkId_ = 325621014
		arg_56_1.duration_ = 5

		SetActive(arg_56_1.tipsGo_, false)

		function arg_56_1.onSingleLineFinish_()
			arg_56_1.onSingleLineUpdate_ = nil
			arg_56_1.onSingleLineFinish_ = nil
			arg_56_1.state_ = "waiting"
		end

		function arg_56_1.playNext_(arg_58_0)
			if arg_58_0 == 1 then
				arg_56_0:Play325621015(arg_56_1)
			end
		end

		function arg_56_1.onSingleLineUpdate_(arg_59_0)
			local var_59_0 = arg_56_1.actors_["1170ui_story"].transform
			local var_59_1 = 0

			if var_59_1 < arg_56_1.time_ and arg_56_1.time_ <= var_59_1 + arg_59_0 then
				arg_56_1.var_.moveOldPos1170ui_story = var_59_0.localPosition

				local var_59_2 = GameObjectTools.GetOrAddComponent(var_59_0.gameObject, typeof(DynamicBoneHelper))

				if var_59_2 then
					var_59_2:EnableDynamicBone(false)
				end
			end

			local var_59_3 = 0.001

			if var_59_1 <= arg_56_1.time_ and arg_56_1.time_ < var_59_1 + var_59_3 then
				local var_59_4 = (arg_56_1.time_ - var_59_1) / var_59_3
				local var_59_5 = Vector3.New(0, 100, 0)

				var_59_0.localPosition = Vector3.Lerp(arg_56_1.var_.moveOldPos1170ui_story, var_59_5, var_59_4)

				local var_59_6 = manager.ui.mainCamera.transform.position - var_59_0.position

				var_59_0.forward = Vector3.New(var_59_6.x, var_59_6.y, var_59_6.z)

				local var_59_7 = var_59_0.localEulerAngles

				var_59_7.z = 0
				var_59_7.x = 0
				var_59_0.localEulerAngles = var_59_7
			end

			if arg_56_1.time_ >= var_59_1 + var_59_3 and arg_56_1.time_ < var_59_1 + var_59_3 + arg_59_0 then
				var_59_0.localPosition = Vector3.New(0, 100, 0)

				local var_59_8 = manager.ui.mainCamera.transform.position - var_59_0.position

				var_59_0.forward = Vector3.New(var_59_8.x, var_59_8.y, var_59_8.z)

				local var_59_9 = var_59_0.localEulerAngles

				var_59_9.z = 0
				var_59_9.x = 0
				var_59_0.localEulerAngles = var_59_9

				local var_59_10 = GameObjectTools.GetOrAddComponent(var_59_0.gameObject, typeof(DynamicBoneHelper))

				if var_59_10 then
					var_59_10:EnableDynamicBone(true)
				end
			end

			local var_59_11 = 0
			local var_59_12 = 0.925

			if var_59_11 < arg_56_1.time_ and arg_56_1.time_ <= var_59_11 + arg_59_0 then
				arg_56_1.talkMaxDuration = 0
				arg_56_1.dialogCg_.alpha = 1

				arg_56_1.dialog_:SetActive(true)
				SetActive(arg_56_1.leftNameGo_, false)

				arg_56_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_56_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_56_1:RecordName(arg_56_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_56_1.iconTrs_.gameObject, false)
				arg_56_1.callingController_:SetSelectedState("normal")

				local var_59_13 = arg_56_1:GetWordFromCfg(325621014)
				local var_59_14 = arg_56_1:FormatText(var_59_13.content)

				arg_56_1.text_.text = var_59_14

				LuaForUtil.ClearLinePrefixSymbol(arg_56_1.text_)

				local var_59_15 = 37
				local var_59_16 = utf8.len(var_59_14)
				local var_59_17 = var_59_15 <= 0 and var_59_12 or var_59_12 * (var_59_16 / var_59_15)

				if var_59_17 > 0 and var_59_12 < var_59_17 then
					arg_56_1.talkMaxDuration = var_59_17

					if var_59_17 + var_59_11 > arg_56_1.duration_ then
						arg_56_1.duration_ = var_59_17 + var_59_11
					end
				end

				arg_56_1.text_.text = var_59_14
				arg_56_1.typewritter.percent = 0

				arg_56_1.typewritter:SetDirty()
				arg_56_1:ShowNextGo(false)
				arg_56_1:RecordContent(arg_56_1.text_.text)
			end

			local var_59_18 = math.max(var_59_12, arg_56_1.talkMaxDuration)

			if var_59_11 <= arg_56_1.time_ and arg_56_1.time_ < var_59_11 + var_59_18 then
				arg_56_1.typewritter.percent = (arg_56_1.time_ - var_59_11) / var_59_18

				arg_56_1.typewritter:SetDirty()
			end

			if arg_56_1.time_ >= var_59_11 + var_59_18 and arg_56_1.time_ < var_59_11 + var_59_18 + arg_59_0 then
				arg_56_1.typewritter.percent = 1

				arg_56_1.typewritter:SetDirty()
				arg_56_1:ShowNextGo(true)
			end
		end

		arg_56_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1170ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_56_1:InitPlayNodeList()
	end,
	Play325621015 = function(arg_60_0, arg_60_1)
		arg_60_1.time_ = 0
		arg_60_1.frameCnt_ = 0
		arg_60_1.state_ = "playing"
		arg_60_1.curTalkId_ = 325621015
		arg_60_1.duration_ = 7.6

		SetActive(arg_60_1.tipsGo_, false)

		function arg_60_1.onSingleLineFinish_()
			arg_60_1.onSingleLineUpdate_ = nil
			arg_60_1.onSingleLineFinish_ = nil
			arg_60_1.state_ = "waiting"
		end

		function arg_60_1.playNext_(arg_62_0)
			if arg_62_0 == 1 then
				arg_60_0:Play325621016(arg_60_1)
			end
		end

		function arg_60_1.onSingleLineUpdate_(arg_63_0)
			local var_63_0 = 1.3

			if var_63_0 < arg_60_1.time_ and arg_60_1.time_ <= var_63_0 + arg_63_0 then
				local var_63_1 = manager.ui.mainCamera.transform.localPosition
				local var_63_2 = Vector3.New(0, 0, 10) + Vector3.New(var_63_1.x, var_63_1.y, 0)
				local var_63_3 = arg_60_1.bgs_.ST2013

				var_63_3.transform.localPosition = var_63_2
				var_63_3.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_63_4 = var_63_3:GetComponent("SpriteRenderer")

				if var_63_4 and var_63_4.sprite then
					local var_63_5 = (var_63_3.transform.localPosition - var_63_1).z
					local var_63_6 = manager.ui.mainCameraCom_
					local var_63_7 = 2 * var_63_5 * Mathf.Tan(var_63_6.fieldOfView * 0.5 * Mathf.Deg2Rad)
					local var_63_8 = var_63_7 * var_63_6.aspect
					local var_63_9 = var_63_4.sprite.bounds.size.x
					local var_63_10 = var_63_4.sprite.bounds.size.y
					local var_63_11 = var_63_8 / var_63_9
					local var_63_12 = var_63_7 / var_63_10
					local var_63_13 = var_63_12 < var_63_11 and var_63_11 or var_63_12

					var_63_3.transform.localScale = Vector3.New(var_63_13, var_63_13, 0)
				end

				for iter_63_0, iter_63_1 in pairs(arg_60_1.bgs_) do
					if iter_63_0 ~= "ST2013" then
						iter_63_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_63_14 = 0

			if var_63_14 < arg_60_1.time_ and arg_60_1.time_ <= var_63_14 + arg_63_0 then
				arg_60_1.allBtn_.enabled = false
			end

			local var_63_15 = 0.3

			if arg_60_1.time_ >= var_63_14 + var_63_15 and arg_60_1.time_ < var_63_14 + var_63_15 + arg_63_0 then
				arg_60_1.allBtn_.enabled = true
			end

			local var_63_16 = 0

			if var_63_16 < arg_60_1.time_ and arg_60_1.time_ <= var_63_16 + arg_63_0 then
				arg_60_1.mask_.enabled = true
				arg_60_1.mask_.raycastTarget = true

				arg_60_1:SetGaussion(false)
			end

			local var_63_17 = 1.3

			if var_63_16 <= arg_60_1.time_ and arg_60_1.time_ < var_63_16 + var_63_17 then
				local var_63_18 = (arg_60_1.time_ - var_63_16) / var_63_17
				local var_63_19 = Color.New(0, 0, 0)

				var_63_19.a = Mathf.Lerp(0, 1, var_63_18)
				arg_60_1.mask_.color = var_63_19
			end

			if arg_60_1.time_ >= var_63_16 + var_63_17 and arg_60_1.time_ < var_63_16 + var_63_17 + arg_63_0 then
				local var_63_20 = Color.New(0, 0, 0)

				var_63_20.a = 1
				arg_60_1.mask_.color = var_63_20
			end

			local var_63_21 = 1.3

			if var_63_21 < arg_60_1.time_ and arg_60_1.time_ <= var_63_21 + arg_63_0 then
				arg_60_1.mask_.enabled = true
				arg_60_1.mask_.raycastTarget = true

				arg_60_1:SetGaussion(false)
			end

			local var_63_22 = 1.6

			if var_63_21 <= arg_60_1.time_ and arg_60_1.time_ < var_63_21 + var_63_22 then
				local var_63_23 = (arg_60_1.time_ - var_63_21) / var_63_22
				local var_63_24 = Color.New(0, 0, 0)

				var_63_24.a = Mathf.Lerp(1, 0, var_63_23)
				arg_60_1.mask_.color = var_63_24
			end

			if arg_60_1.time_ >= var_63_21 + var_63_22 and arg_60_1.time_ < var_63_21 + var_63_22 + arg_63_0 then
				local var_63_25 = Color.New(0, 0, 0)
				local var_63_26 = 0

				arg_60_1.mask_.enabled = false
				var_63_25.a = var_63_26
				arg_60_1.mask_.color = var_63_25
			end

			if arg_60_1.frameCnt_ <= 1 then
				arg_60_1.dialog_:SetActive(false)
			end

			local var_63_27 = 2.6
			local var_63_28 = 1.2

			if var_63_27 < arg_60_1.time_ and arg_60_1.time_ <= var_63_27 + arg_63_0 then
				arg_60_1.talkMaxDuration = 0

				arg_60_1.dialog_:SetActive(true)

				arg_60_1.dialogCg_.alpha = 0

				local var_63_29 = LeanTween.value(arg_60_1.dialog_, 0, 1, 0.3)

				var_63_29:setOnUpdate(LuaHelper.FloatAction(function(arg_64_0)
					arg_60_1.dialogCg_.alpha = arg_64_0
				end))
				var_63_29:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_60_1.dialog_)
					var_63_29:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_60_1.duration_ = arg_60_1.duration_ + 0.3

				SetActive(arg_60_1.leftNameGo_, false)

				arg_60_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_60_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_60_1:RecordName(arg_60_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_60_1.iconTrs_.gameObject, false)
				arg_60_1.callingController_:SetSelectedState("normal")

				local var_63_30 = arg_60_1:GetWordFromCfg(325621015)
				local var_63_31 = arg_60_1:FormatText(var_63_30.content)

				arg_60_1.text_.text = var_63_31

				LuaForUtil.ClearLinePrefixSymbol(arg_60_1.text_)

				local var_63_32 = 48
				local var_63_33 = utf8.len(var_63_31)
				local var_63_34 = var_63_32 <= 0 and var_63_28 or var_63_28 * (var_63_33 / var_63_32)

				if var_63_34 > 0 and var_63_28 < var_63_34 then
					arg_60_1.talkMaxDuration = var_63_34
					var_63_27 = var_63_27 + 0.3

					if var_63_34 + var_63_27 > arg_60_1.duration_ then
						arg_60_1.duration_ = var_63_34 + var_63_27
					end
				end

				arg_60_1.text_.text = var_63_31
				arg_60_1.typewritter.percent = 0

				arg_60_1.typewritter:SetDirty()
				arg_60_1:ShowNextGo(false)
				arg_60_1:RecordContent(arg_60_1.text_.text)
			end

			local var_63_35 = var_63_27 + 0.3
			local var_63_36 = math.max(var_63_28, arg_60_1.talkMaxDuration)

			if var_63_35 <= arg_60_1.time_ and arg_60_1.time_ < var_63_35 + var_63_36 then
				arg_60_1.typewritter.percent = (arg_60_1.time_ - var_63_35) / var_63_36

				arg_60_1.typewritter:SetDirty()
			end

			if arg_60_1.time_ >= var_63_35 + var_63_36 and arg_60_1.time_ < var_63_35 + var_63_36 + arg_63_0 then
				arg_60_1.typewritter.percent = 1

				arg_60_1.typewritter:SetDirty()
				arg_60_1:ShowNextGo(true)
			end
		end

		arg_60_1.nodeConfigList_ = {}

		arg_60_1:InitPlayNodeList()
	end,
	Play325621016 = function(arg_66_0, arg_66_1)
		arg_66_1.time_ = 0
		arg_66_1.frameCnt_ = 0
		arg_66_1.state_ = "playing"
		arg_66_1.curTalkId_ = 325621016
		arg_66_1.duration_ = 5

		SetActive(arg_66_1.tipsGo_, false)

		function arg_66_1.onSingleLineFinish_()
			arg_66_1.onSingleLineUpdate_ = nil
			arg_66_1.onSingleLineFinish_ = nil
			arg_66_1.state_ = "waiting"
		end

		function arg_66_1.playNext_(arg_68_0)
			if arg_68_0 == 1 then
				arg_66_0:Play325621017(arg_66_1)
			end
		end

		function arg_66_1.onSingleLineUpdate_(arg_69_0)
			local var_69_0 = 0
			local var_69_1 = 0.45

			if var_69_0 < arg_66_1.time_ and arg_66_1.time_ <= var_69_0 + arg_69_0 then
				arg_66_1.talkMaxDuration = 0
				arg_66_1.dialogCg_.alpha = 1

				arg_66_1.dialog_:SetActive(true)
				SetActive(arg_66_1.leftNameGo_, true)

				local var_69_2 = arg_66_1:FormatText(StoryNameCfg[7].name)

				arg_66_1.leftNameTxt_.text = var_69_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_66_1.leftNameTxt_.transform)

				arg_66_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_66_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_66_1:RecordName(arg_66_1.leftNameTxt_.text)
				SetActive(arg_66_1.iconTrs_.gameObject, true)
				arg_66_1.iconController_:SetSelectedState("hero")

				arg_66_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_66_1.callingController_:SetSelectedState("normal")

				arg_66_1.keyicon_.color = Color.New(1, 1, 1)
				arg_66_1.icon_.color = Color.New(1, 1, 1)

				local var_69_3 = arg_66_1:GetWordFromCfg(325621016)
				local var_69_4 = arg_66_1:FormatText(var_69_3.content)

				arg_66_1.text_.text = var_69_4

				LuaForUtil.ClearLinePrefixSymbol(arg_66_1.text_)

				local var_69_5 = 18
				local var_69_6 = utf8.len(var_69_4)
				local var_69_7 = var_69_5 <= 0 and var_69_1 or var_69_1 * (var_69_6 / var_69_5)

				if var_69_7 > 0 and var_69_1 < var_69_7 then
					arg_66_1.talkMaxDuration = var_69_7

					if var_69_7 + var_69_0 > arg_66_1.duration_ then
						arg_66_1.duration_ = var_69_7 + var_69_0
					end
				end

				arg_66_1.text_.text = var_69_4
				arg_66_1.typewritter.percent = 0

				arg_66_1.typewritter:SetDirty()
				arg_66_1:ShowNextGo(false)
				arg_66_1:RecordContent(arg_66_1.text_.text)
			end

			local var_69_8 = math.max(var_69_1, arg_66_1.talkMaxDuration)

			if var_69_0 <= arg_66_1.time_ and arg_66_1.time_ < var_69_0 + var_69_8 then
				arg_66_1.typewritter.percent = (arg_66_1.time_ - var_69_0) / var_69_8

				arg_66_1.typewritter:SetDirty()
			end

			if arg_66_1.time_ >= var_69_0 + var_69_8 and arg_66_1.time_ < var_69_0 + var_69_8 + arg_69_0 then
				arg_66_1.typewritter.percent = 1

				arg_66_1.typewritter:SetDirty()
				arg_66_1:ShowNextGo(true)
			end
		end

		arg_66_1.nodeConfigList_ = {}

		arg_66_1:InitPlayNodeList()
	end,
	Play325621017 = function(arg_70_0, arg_70_1)
		arg_70_1.time_ = 0
		arg_70_1.frameCnt_ = 0
		arg_70_1.state_ = "playing"
		arg_70_1.curTalkId_ = 325621017
		arg_70_1.duration_ = 12.4

		local var_70_0 = {
			zh = 5.666,
			ja = 12.4
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
				arg_70_0:Play325621018(arg_70_1)
			end
		end

		function arg_70_1.onSingleLineUpdate_(arg_73_0)
			local var_73_0 = arg_70_1.actors_["1170ui_story"].transform
			local var_73_1 = 0

			if var_73_1 < arg_70_1.time_ and arg_70_1.time_ <= var_73_1 + arg_73_0 then
				arg_70_1.var_.moveOldPos1170ui_story = var_73_0.localPosition

				local var_73_2 = GameObjectTools.GetOrAddComponent(var_73_0.gameObject, typeof(DynamicBoneHelper))

				if var_73_2 then
					var_73_2:EnableDynamicBone(false)
				end
			end

			local var_73_3 = 0.001

			if var_73_1 <= arg_70_1.time_ and arg_70_1.time_ < var_73_1 + var_73_3 then
				local var_73_4 = (arg_70_1.time_ - var_73_1) / var_73_3
				local var_73_5 = Vector3.New(0.03, -0.95, -6.08)

				var_73_0.localPosition = Vector3.Lerp(arg_70_1.var_.moveOldPos1170ui_story, var_73_5, var_73_4)

				local var_73_6 = manager.ui.mainCamera.transform.position - var_73_0.position

				var_73_0.forward = Vector3.New(var_73_6.x, var_73_6.y, var_73_6.z)

				local var_73_7 = var_73_0.localEulerAngles

				var_73_7.z = 0
				var_73_7.x = 0
				var_73_0.localEulerAngles = var_73_7
			end

			if arg_70_1.time_ >= var_73_1 + var_73_3 and arg_70_1.time_ < var_73_1 + var_73_3 + arg_73_0 then
				var_73_0.localPosition = Vector3.New(0.03, -0.95, -6.08)

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

			local var_73_11 = arg_70_1.actors_["1170ui_story"]
			local var_73_12 = 0

			if var_73_12 < arg_70_1.time_ and arg_70_1.time_ <= var_73_12 + arg_73_0 and not isNil(var_73_11) and arg_70_1.var_.characterEffect1170ui_story == nil then
				arg_70_1.var_.characterEffect1170ui_story = var_73_11:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_73_13 = 0.200000002980232

			if var_73_12 <= arg_70_1.time_ and arg_70_1.time_ < var_73_12 + var_73_13 and not isNil(var_73_11) then
				local var_73_14 = (arg_70_1.time_ - var_73_12) / var_73_13

				if arg_70_1.var_.characterEffect1170ui_story and not isNil(var_73_11) then
					arg_70_1.var_.characterEffect1170ui_story.fillFlat = false
				end
			end

			if arg_70_1.time_ >= var_73_12 + var_73_13 and arg_70_1.time_ < var_73_12 + var_73_13 + arg_73_0 and not isNil(var_73_11) and arg_70_1.var_.characterEffect1170ui_story then
				arg_70_1.var_.characterEffect1170ui_story.fillFlat = false
			end

			local var_73_15 = 0

			if var_73_15 < arg_70_1.time_ and arg_70_1.time_ <= var_73_15 + arg_73_0 then
				arg_70_1:PlayTimeline("1170ui_story", "StoryTimeline/CharAction/story1170/story1170actionlink/1170action438")
			end

			local var_73_16 = 0
			local var_73_17 = 0.775

			if var_73_16 < arg_70_1.time_ and arg_70_1.time_ <= var_73_16 + arg_73_0 then
				arg_70_1.talkMaxDuration = 0
				arg_70_1.dialogCg_.alpha = 1

				arg_70_1.dialog_:SetActive(true)
				SetActive(arg_70_1.leftNameGo_, true)

				local var_73_18 = arg_70_1:FormatText(StoryNameCfg[318].name)

				arg_70_1.leftNameTxt_.text = var_73_18

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_70_1.leftNameTxt_.transform)

				arg_70_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_70_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_70_1:RecordName(arg_70_1.leftNameTxt_.text)
				SetActive(arg_70_1.iconTrs_.gameObject, false)
				arg_70_1.callingController_:SetSelectedState("normal")

				local var_73_19 = arg_70_1:GetWordFromCfg(325621017)
				local var_73_20 = arg_70_1:FormatText(var_73_19.content)

				arg_70_1.text_.text = var_73_20

				LuaForUtil.ClearLinePrefixSymbol(arg_70_1.text_)

				local var_73_21 = 31
				local var_73_22 = utf8.len(var_73_20)
				local var_73_23 = var_73_21 <= 0 and var_73_17 or var_73_17 * (var_73_22 / var_73_21)

				if var_73_23 > 0 and var_73_17 < var_73_23 then
					arg_70_1.talkMaxDuration = var_73_23

					if var_73_23 + var_73_16 > arg_70_1.duration_ then
						arg_70_1.duration_ = var_73_23 + var_73_16
					end
				end

				arg_70_1.text_.text = var_73_20
				arg_70_1.typewritter.percent = 0

				arg_70_1.typewritter:SetDirty()
				arg_70_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_325621", "325621017", "story_v_out_325621.awb") ~= 0 then
					local var_73_24 = manager.audio:GetVoiceLength("story_v_out_325621", "325621017", "story_v_out_325621.awb") / 1000

					if var_73_24 + var_73_16 > arg_70_1.duration_ then
						arg_70_1.duration_ = var_73_24 + var_73_16
					end

					if var_73_19.prefab_name ~= "" and arg_70_1.actors_[var_73_19.prefab_name] ~= nil then
						local var_73_25 = LuaForUtil.PlayVoiceWithCriLipsync(arg_70_1.actors_[var_73_19.prefab_name].transform, "story_v_out_325621", "325621017", "story_v_out_325621.awb")

						arg_70_1:RecordAudio("325621017", var_73_25)
						arg_70_1:RecordAudio("325621017", var_73_25)
					else
						arg_70_1:AudioAction("play", "voice", "story_v_out_325621", "325621017", "story_v_out_325621.awb")
					end

					arg_70_1:RecordHistoryTalkVoice("story_v_out_325621", "325621017", "story_v_out_325621.awb")
				end

				arg_70_1:RecordContent(arg_70_1.text_.text)
			end

			local var_73_26 = math.max(var_73_17, arg_70_1.talkMaxDuration)

			if var_73_16 <= arg_70_1.time_ and arg_70_1.time_ < var_73_16 + var_73_26 then
				arg_70_1.typewritter.percent = (arg_70_1.time_ - var_73_16) / var_73_26

				arg_70_1.typewritter:SetDirty()
			end

			if arg_70_1.time_ >= var_73_16 + var_73_26 and arg_70_1.time_ < var_73_16 + var_73_26 + arg_73_0 then
				arg_70_1.typewritter.percent = 1

				arg_70_1.typewritter:SetDirty()
				arg_70_1:ShowNextGo(true)
			end
		end

		arg_70_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1170ui_story",
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
	Play325621018 = function(arg_74_0, arg_74_1)
		arg_74_1.time_ = 0
		arg_74_1.frameCnt_ = 0
		arg_74_1.state_ = "playing"
		arg_74_1.curTalkId_ = 325621018
		arg_74_1.duration_ = 5

		SetActive(arg_74_1.tipsGo_, false)

		function arg_74_1.onSingleLineFinish_()
			arg_74_1.onSingleLineUpdate_ = nil
			arg_74_1.onSingleLineFinish_ = nil
			arg_74_1.state_ = "waiting"
		end

		function arg_74_1.playNext_(arg_76_0)
			if arg_76_0 == 1 then
				arg_74_0:Play325621019(arg_74_1)
			end
		end

		function arg_74_1.onSingleLineUpdate_(arg_77_0)
			local var_77_0 = arg_74_1.actors_["1170ui_story"]
			local var_77_1 = 0

			if var_77_1 < arg_74_1.time_ and arg_74_1.time_ <= var_77_1 + arg_77_0 and not isNil(var_77_0) and arg_74_1.var_.characterEffect1170ui_story == nil then
				arg_74_1.var_.characterEffect1170ui_story = var_77_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_77_2 = 0.200000002980232

			if var_77_1 <= arg_74_1.time_ and arg_74_1.time_ < var_77_1 + var_77_2 and not isNil(var_77_0) then
				local var_77_3 = (arg_74_1.time_ - var_77_1) / var_77_2

				if arg_74_1.var_.characterEffect1170ui_story and not isNil(var_77_0) then
					local var_77_4 = Mathf.Lerp(0, 0.5, var_77_3)

					arg_74_1.var_.characterEffect1170ui_story.fillFlat = true
					arg_74_1.var_.characterEffect1170ui_story.fillRatio = var_77_4
				end
			end

			if arg_74_1.time_ >= var_77_1 + var_77_2 and arg_74_1.time_ < var_77_1 + var_77_2 + arg_77_0 and not isNil(var_77_0) and arg_74_1.var_.characterEffect1170ui_story then
				local var_77_5 = 0.5

				arg_74_1.var_.characterEffect1170ui_story.fillFlat = true
				arg_74_1.var_.characterEffect1170ui_story.fillRatio = var_77_5
			end

			local var_77_6 = 0
			local var_77_7 = 0.275

			if var_77_6 < arg_74_1.time_ and arg_74_1.time_ <= var_77_6 + arg_77_0 then
				arg_74_1.talkMaxDuration = 0
				arg_74_1.dialogCg_.alpha = 1

				arg_74_1.dialog_:SetActive(true)
				SetActive(arg_74_1.leftNameGo_, true)

				local var_77_8 = arg_74_1:FormatText(StoryNameCfg[7].name)

				arg_74_1.leftNameTxt_.text = var_77_8

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

				local var_77_9 = arg_74_1:GetWordFromCfg(325621018)
				local var_77_10 = arg_74_1:FormatText(var_77_9.content)

				arg_74_1.text_.text = var_77_10

				LuaForUtil.ClearLinePrefixSymbol(arg_74_1.text_)

				local var_77_11 = 11
				local var_77_12 = utf8.len(var_77_10)
				local var_77_13 = var_77_11 <= 0 and var_77_7 or var_77_7 * (var_77_12 / var_77_11)

				if var_77_13 > 0 and var_77_7 < var_77_13 then
					arg_74_1.talkMaxDuration = var_77_13

					if var_77_13 + var_77_6 > arg_74_1.duration_ then
						arg_74_1.duration_ = var_77_13 + var_77_6
					end
				end

				arg_74_1.text_.text = var_77_10
				arg_74_1.typewritter.percent = 0

				arg_74_1.typewritter:SetDirty()
				arg_74_1:ShowNextGo(false)
				arg_74_1:RecordContent(arg_74_1.text_.text)
			end

			local var_77_14 = math.max(var_77_7, arg_74_1.talkMaxDuration)

			if var_77_6 <= arg_74_1.time_ and arg_74_1.time_ < var_77_6 + var_77_14 then
				arg_74_1.typewritter.percent = (arg_74_1.time_ - var_77_6) / var_77_14

				arg_74_1.typewritter:SetDirty()
			end

			if arg_74_1.time_ >= var_77_6 + var_77_14 and arg_74_1.time_ < var_77_6 + var_77_14 + arg_77_0 then
				arg_74_1.typewritter.percent = 1

				arg_74_1.typewritter:SetDirty()
				arg_74_1:ShowNextGo(true)
			end
		end

		arg_74_1.nodeConfigList_ = {}

		arg_74_1:InitPlayNodeList()
	end,
	Play325621019 = function(arg_78_0, arg_78_1)
		arg_78_1.time_ = 0
		arg_78_1.frameCnt_ = 0
		arg_78_1.state_ = "playing"
		arg_78_1.curTalkId_ = 325621019
		arg_78_1.duration_ = 5

		SetActive(arg_78_1.tipsGo_, false)

		function arg_78_1.onSingleLineFinish_()
			arg_78_1.onSingleLineUpdate_ = nil
			arg_78_1.onSingleLineFinish_ = nil
			arg_78_1.state_ = "waiting"
		end

		function arg_78_1.playNext_(arg_80_0)
			if arg_80_0 == 1 then
				arg_78_0:Play325621020(arg_78_1)
			end
		end

		function arg_78_1.onSingleLineUpdate_(arg_81_0)
			local var_81_0 = arg_78_1.actors_["1170ui_story"].transform
			local var_81_1 = 0

			if var_81_1 < arg_78_1.time_ and arg_78_1.time_ <= var_81_1 + arg_81_0 then
				arg_78_1.var_.moveOldPos1170ui_story = var_81_0.localPosition

				local var_81_2 = GameObjectTools.GetOrAddComponent(var_81_0.gameObject, typeof(DynamicBoneHelper))

				if var_81_2 then
					var_81_2:EnableDynamicBone(false)
				end
			end

			local var_81_3 = 0.001

			if var_81_1 <= arg_78_1.time_ and arg_78_1.time_ < var_81_1 + var_81_3 then
				local var_81_4 = (arg_78_1.time_ - var_81_1) / var_81_3
				local var_81_5 = Vector3.New(0, 100, 0)

				var_81_0.localPosition = Vector3.Lerp(arg_78_1.var_.moveOldPos1170ui_story, var_81_5, var_81_4)

				local var_81_6 = manager.ui.mainCamera.transform.position - var_81_0.position

				var_81_0.forward = Vector3.New(var_81_6.x, var_81_6.y, var_81_6.z)

				local var_81_7 = var_81_0.localEulerAngles

				var_81_7.z = 0
				var_81_7.x = 0
				var_81_0.localEulerAngles = var_81_7
			end

			if arg_78_1.time_ >= var_81_1 + var_81_3 and arg_78_1.time_ < var_81_1 + var_81_3 + arg_81_0 then
				var_81_0.localPosition = Vector3.New(0, 100, 0)

				local var_81_8 = manager.ui.mainCamera.transform.position - var_81_0.position

				var_81_0.forward = Vector3.New(var_81_8.x, var_81_8.y, var_81_8.z)

				local var_81_9 = var_81_0.localEulerAngles

				var_81_9.z = 0
				var_81_9.x = 0
				var_81_0.localEulerAngles = var_81_9

				local var_81_10 = GameObjectTools.GetOrAddComponent(var_81_0.gameObject, typeof(DynamicBoneHelper))

				if var_81_10 then
					var_81_10:EnableDynamicBone(true)
				end
			end

			local var_81_11 = 0
			local var_81_12 = 0.95

			if var_81_11 < arg_78_1.time_ and arg_78_1.time_ <= var_81_11 + arg_81_0 then
				arg_78_1.talkMaxDuration = 0
				arg_78_1.dialogCg_.alpha = 1

				arg_78_1.dialog_:SetActive(true)
				SetActive(arg_78_1.leftNameGo_, false)

				arg_78_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_78_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_78_1:RecordName(arg_78_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_78_1.iconTrs_.gameObject, false)
				arg_78_1.callingController_:SetSelectedState("normal")

				local var_81_13 = arg_78_1:GetWordFromCfg(325621019)
				local var_81_14 = arg_78_1:FormatText(var_81_13.content)

				arg_78_1.text_.text = var_81_14

				LuaForUtil.ClearLinePrefixSymbol(arg_78_1.text_)

				local var_81_15 = 38
				local var_81_16 = utf8.len(var_81_14)
				local var_81_17 = var_81_15 <= 0 and var_81_12 or var_81_12 * (var_81_16 / var_81_15)

				if var_81_17 > 0 and var_81_12 < var_81_17 then
					arg_78_1.talkMaxDuration = var_81_17

					if var_81_17 + var_81_11 > arg_78_1.duration_ then
						arg_78_1.duration_ = var_81_17 + var_81_11
					end
				end

				arg_78_1.text_.text = var_81_14
				arg_78_1.typewritter.percent = 0

				arg_78_1.typewritter:SetDirty()
				arg_78_1:ShowNextGo(false)
				arg_78_1:RecordContent(arg_78_1.text_.text)
			end

			local var_81_18 = math.max(var_81_12, arg_78_1.talkMaxDuration)

			if var_81_11 <= arg_78_1.time_ and arg_78_1.time_ < var_81_11 + var_81_18 then
				arg_78_1.typewritter.percent = (arg_78_1.time_ - var_81_11) / var_81_18

				arg_78_1.typewritter:SetDirty()
			end

			if arg_78_1.time_ >= var_81_11 + var_81_18 and arg_78_1.time_ < var_81_11 + var_81_18 + arg_81_0 then
				arg_78_1.typewritter.percent = 1

				arg_78_1.typewritter:SetDirty()
				arg_78_1:ShowNextGo(true)
			end
		end

		arg_78_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1170ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_78_1:InitPlayNodeList()
	end,
	Play325621020 = function(arg_82_0, arg_82_1)
		arg_82_1.time_ = 0
		arg_82_1.frameCnt_ = 0
		arg_82_1.state_ = "playing"
		arg_82_1.curTalkId_ = 325621020
		arg_82_1.duration_ = 5

		SetActive(arg_82_1.tipsGo_, false)

		function arg_82_1.onSingleLineFinish_()
			arg_82_1.onSingleLineUpdate_ = nil
			arg_82_1.onSingleLineFinish_ = nil
			arg_82_1.state_ = "waiting"
		end

		function arg_82_1.playNext_(arg_84_0)
			if arg_84_0 == 1 then
				arg_82_0:Play325621021(arg_82_1)
			end
		end

		function arg_82_1.onSingleLineUpdate_(arg_85_0)
			local var_85_0 = 0
			local var_85_1 = 0.275

			if var_85_0 < arg_82_1.time_ and arg_82_1.time_ <= var_85_0 + arg_85_0 then
				arg_82_1.talkMaxDuration = 0
				arg_82_1.dialogCg_.alpha = 1

				arg_82_1.dialog_:SetActive(true)
				SetActive(arg_82_1.leftNameGo_, true)

				local var_85_2 = arg_82_1:FormatText(StoryNameCfg[7].name)

				arg_82_1.leftNameTxt_.text = var_85_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_82_1.leftNameTxt_.transform)

				arg_82_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_82_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_82_1:RecordName(arg_82_1.leftNameTxt_.text)
				SetActive(arg_82_1.iconTrs_.gameObject, true)
				arg_82_1.iconController_:SetSelectedState("hero")

				arg_82_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_82_1.callingController_:SetSelectedState("normal")

				arg_82_1.keyicon_.color = Color.New(1, 1, 1)
				arg_82_1.icon_.color = Color.New(1, 1, 1)

				local var_85_3 = arg_82_1:GetWordFromCfg(325621020)
				local var_85_4 = arg_82_1:FormatText(var_85_3.content)

				arg_82_1.text_.text = var_85_4

				LuaForUtil.ClearLinePrefixSymbol(arg_82_1.text_)

				local var_85_5 = 11
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
				arg_82_1:RecordContent(arg_82_1.text_.text)
			end

			local var_85_8 = math.max(var_85_1, arg_82_1.talkMaxDuration)

			if var_85_0 <= arg_82_1.time_ and arg_82_1.time_ < var_85_0 + var_85_8 then
				arg_82_1.typewritter.percent = (arg_82_1.time_ - var_85_0) / var_85_8

				arg_82_1.typewritter:SetDirty()
			end

			if arg_82_1.time_ >= var_85_0 + var_85_8 and arg_82_1.time_ < var_85_0 + var_85_8 + arg_85_0 then
				arg_82_1.typewritter.percent = 1

				arg_82_1.typewritter:SetDirty()
				arg_82_1:ShowNextGo(true)
			end
		end

		arg_82_1.nodeConfigList_ = {}

		arg_82_1:InitPlayNodeList()
	end,
	Play325621021 = function(arg_86_0, arg_86_1)
		arg_86_1.time_ = 0
		arg_86_1.frameCnt_ = 0
		arg_86_1.state_ = "playing"
		arg_86_1.curTalkId_ = 325621021
		arg_86_1.duration_ = 3.3

		local var_86_0 = {
			zh = 2.066,
			ja = 3.3
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
				arg_86_0:Play325621022(arg_86_1)
			end
		end

		function arg_86_1.onSingleLineUpdate_(arg_89_0)
			local var_89_0 = "1012ui_story"

			if arg_86_1.actors_[var_89_0] == nil then
				local var_89_1 = Asset.Load("Char/" .. "1012ui_story")

				if not isNil(var_89_1) then
					local var_89_2 = Object.Instantiate(Asset.Load("Char/" .. "1012ui_story"), arg_86_1.stage_.transform)

					var_89_2.name = var_89_0
					var_89_2.transform.localPosition = Vector3.New(0, 100, 0)
					arg_86_1.actors_[var_89_0] = var_89_2

					local var_89_3 = var_89_2:GetComponentInChildren(typeof(CharacterEffect))

					var_89_3.enabled = true

					local var_89_4 = GameObjectTools.GetOrAddComponent(var_89_2, typeof(DynamicBoneHelper))

					if var_89_4 then
						var_89_4:EnableDynamicBone(false)
					end

					arg_86_1:ShowWeapon(var_89_3.transform, false)

					arg_86_1.var_[var_89_0 .. "Animator"] = var_89_3.gameObject:GetComponent(typeof(UnityEngine.Animator))
					arg_86_1.var_[var_89_0 .. "Animator"].applyRootMotion = true
					arg_86_1.var_[var_89_0 .. "LipSync"] = var_89_3.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
				end
			end

			local var_89_5 = arg_86_1.actors_["1012ui_story"].transform
			local var_89_6 = 0

			if var_89_6 < arg_86_1.time_ and arg_86_1.time_ <= var_89_6 + arg_89_0 then
				arg_86_1.var_.moveOldPos1012ui_story = var_89_5.localPosition
			end

			local var_89_7 = 0.001

			if var_89_6 <= arg_86_1.time_ and arg_86_1.time_ < var_89_6 + var_89_7 then
				local var_89_8 = (arg_86_1.time_ - var_89_6) / var_89_7
				local var_89_9 = Vector3.New(0, -1.05, -6.24)

				var_89_5.localPosition = Vector3.Lerp(arg_86_1.var_.moveOldPos1012ui_story, var_89_9, var_89_8)

				local var_89_10 = manager.ui.mainCamera.transform.position - var_89_5.position

				var_89_5.forward = Vector3.New(var_89_10.x, var_89_10.y, var_89_10.z)

				local var_89_11 = var_89_5.localEulerAngles

				var_89_11.z = 0
				var_89_11.x = 0
				var_89_5.localEulerAngles = var_89_11
			end

			if arg_86_1.time_ >= var_89_6 + var_89_7 and arg_86_1.time_ < var_89_6 + var_89_7 + arg_89_0 then
				var_89_5.localPosition = Vector3.New(0, -1.05, -6.24)

				local var_89_12 = manager.ui.mainCamera.transform.position - var_89_5.position

				var_89_5.forward = Vector3.New(var_89_12.x, var_89_12.y, var_89_12.z)

				local var_89_13 = var_89_5.localEulerAngles

				var_89_13.z = 0
				var_89_13.x = 0
				var_89_5.localEulerAngles = var_89_13
			end

			local var_89_14 = arg_86_1.actors_["1012ui_story"]
			local var_89_15 = 0

			if var_89_15 < arg_86_1.time_ and arg_86_1.time_ <= var_89_15 + arg_89_0 and not isNil(var_89_14) and arg_86_1.var_.characterEffect1012ui_story == nil then
				arg_86_1.var_.characterEffect1012ui_story = var_89_14:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_89_16 = 0.200000002980232

			if var_89_15 <= arg_86_1.time_ and arg_86_1.time_ < var_89_15 + var_89_16 and not isNil(var_89_14) then
				local var_89_17 = (arg_86_1.time_ - var_89_15) / var_89_16

				if arg_86_1.var_.characterEffect1012ui_story and not isNil(var_89_14) then
					arg_86_1.var_.characterEffect1012ui_story.fillFlat = false
				end
			end

			if arg_86_1.time_ >= var_89_15 + var_89_16 and arg_86_1.time_ < var_89_15 + var_89_16 + arg_89_0 and not isNil(var_89_14) and arg_86_1.var_.characterEffect1012ui_story then
				arg_86_1.var_.characterEffect1012ui_story.fillFlat = false
			end

			local var_89_18 = 0

			if var_89_18 < arg_86_1.time_ and arg_86_1.time_ <= var_89_18 + arg_89_0 then
				arg_86_1:PlayTimeline("1012ui_story", "StoryTimeline/CharAction/story1012/story1012action/1012action2_1")
			end

			local var_89_19 = 0

			if var_89_19 < arg_86_1.time_ and arg_86_1.time_ <= var_89_19 + arg_89_0 then
				arg_86_1:PlayTimeline("1012ui_story", "StoryTimeline/CharAction/public_expression/expr_kuaileA_weixiao", "EmotionTimelineAnimator")
			end

			local var_89_20 = 0
			local var_89_21 = 0.45

			if var_89_20 < arg_86_1.time_ and arg_86_1.time_ <= var_89_20 + arg_89_0 then
				arg_86_1.talkMaxDuration = 0
				arg_86_1.dialogCg_.alpha = 1

				arg_86_1.dialog_:SetActive(true)
				SetActive(arg_86_1.leftNameGo_, true)

				local var_89_22 = arg_86_1:FormatText(StoryNameCfg[595].name)

				arg_86_1.leftNameTxt_.text = var_89_22

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_86_1.leftNameTxt_.transform)

				arg_86_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_86_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_86_1:RecordName(arg_86_1.leftNameTxt_.text)
				SetActive(arg_86_1.iconTrs_.gameObject, false)
				arg_86_1.callingController_:SetSelectedState("normal")

				local var_89_23 = arg_86_1:GetWordFromCfg(325621021)
				local var_89_24 = arg_86_1:FormatText(var_89_23.content)

				arg_86_1.text_.text = var_89_24

				LuaForUtil.ClearLinePrefixSymbol(arg_86_1.text_)

				local var_89_25 = 18
				local var_89_26 = utf8.len(var_89_24)
				local var_89_27 = var_89_25 <= 0 and var_89_21 or var_89_21 * (var_89_26 / var_89_25)

				if var_89_27 > 0 and var_89_21 < var_89_27 then
					arg_86_1.talkMaxDuration = var_89_27

					if var_89_27 + var_89_20 > arg_86_1.duration_ then
						arg_86_1.duration_ = var_89_27 + var_89_20
					end
				end

				arg_86_1.text_.text = var_89_24
				arg_86_1.typewritter.percent = 0

				arg_86_1.typewritter:SetDirty()
				arg_86_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_325621", "325621021", "story_v_out_325621.awb") ~= 0 then
					local var_89_28 = manager.audio:GetVoiceLength("story_v_out_325621", "325621021", "story_v_out_325621.awb") / 1000

					if var_89_28 + var_89_20 > arg_86_1.duration_ then
						arg_86_1.duration_ = var_89_28 + var_89_20
					end

					if var_89_23.prefab_name ~= "" and arg_86_1.actors_[var_89_23.prefab_name] ~= nil then
						local var_89_29 = LuaForUtil.PlayVoiceWithCriLipsync(arg_86_1.actors_[var_89_23.prefab_name].transform, "story_v_out_325621", "325621021", "story_v_out_325621.awb")

						arg_86_1:RecordAudio("325621021", var_89_29)
						arg_86_1:RecordAudio("325621021", var_89_29)
					else
						arg_86_1:AudioAction("play", "voice", "story_v_out_325621", "325621021", "story_v_out_325621.awb")
					end

					arg_86_1:RecordHistoryTalkVoice("story_v_out_325621", "325621021", "story_v_out_325621.awb")
				end

				arg_86_1:RecordContent(arg_86_1.text_.text)
			end

			local var_89_30 = math.max(var_89_21, arg_86_1.talkMaxDuration)

			if var_89_20 <= arg_86_1.time_ and arg_86_1.time_ < var_89_20 + var_89_30 then
				arg_86_1.typewritter.percent = (arg_86_1.time_ - var_89_20) / var_89_30

				arg_86_1.typewritter:SetDirty()
			end

			if arg_86_1.time_ >= var_89_20 + var_89_30 and arg_86_1.time_ < var_89_20 + var_89_30 + arg_89_0 then
				arg_86_1.typewritter.percent = 1

				arg_86_1.typewritter:SetDirty()
				arg_86_1:ShowNextGo(true)
			end
		end

		arg_86_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1012ui_story",
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
	Play325621022 = function(arg_90_0, arg_90_1)
		arg_90_1.time_ = 0
		arg_90_1.frameCnt_ = 0
		arg_90_1.state_ = "playing"
		arg_90_1.curTalkId_ = 325621022
		arg_90_1.duration_ = 9.7

		local var_90_0 = {
			zh = 7.733,
			ja = 9.7
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
				arg_90_0:Play325621023(arg_90_1)
			end
		end

		function arg_90_1.onSingleLineUpdate_(arg_93_0)
			local var_93_0 = 0
			local var_93_1 = 0.975

			if var_93_0 < arg_90_1.time_ and arg_90_1.time_ <= var_93_0 + arg_93_0 then
				arg_90_1.talkMaxDuration = 0
				arg_90_1.dialogCg_.alpha = 1

				arg_90_1.dialog_:SetActive(true)
				SetActive(arg_90_1.leftNameGo_, true)

				local var_93_2 = arg_90_1:FormatText(StoryNameCfg[595].name)

				arg_90_1.leftNameTxt_.text = var_93_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_90_1.leftNameTxt_.transform)

				arg_90_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_90_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_90_1:RecordName(arg_90_1.leftNameTxt_.text)
				SetActive(arg_90_1.iconTrs_.gameObject, false)
				arg_90_1.callingController_:SetSelectedState("normal")

				local var_93_3 = arg_90_1:GetWordFromCfg(325621022)
				local var_93_4 = arg_90_1:FormatText(var_93_3.content)

				arg_90_1.text_.text = var_93_4

				LuaForUtil.ClearLinePrefixSymbol(arg_90_1.text_)

				local var_93_5 = 39
				local var_93_6 = utf8.len(var_93_4)
				local var_93_7 = var_93_5 <= 0 and var_93_1 or var_93_1 * (var_93_6 / var_93_5)

				if var_93_7 > 0 and var_93_1 < var_93_7 then
					arg_90_1.talkMaxDuration = var_93_7

					if var_93_7 + var_93_0 > arg_90_1.duration_ then
						arg_90_1.duration_ = var_93_7 + var_93_0
					end
				end

				arg_90_1.text_.text = var_93_4
				arg_90_1.typewritter.percent = 0

				arg_90_1.typewritter:SetDirty()
				arg_90_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_325621", "325621022", "story_v_out_325621.awb") ~= 0 then
					local var_93_8 = manager.audio:GetVoiceLength("story_v_out_325621", "325621022", "story_v_out_325621.awb") / 1000

					if var_93_8 + var_93_0 > arg_90_1.duration_ then
						arg_90_1.duration_ = var_93_8 + var_93_0
					end

					if var_93_3.prefab_name ~= "" and arg_90_1.actors_[var_93_3.prefab_name] ~= nil then
						local var_93_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_90_1.actors_[var_93_3.prefab_name].transform, "story_v_out_325621", "325621022", "story_v_out_325621.awb")

						arg_90_1:RecordAudio("325621022", var_93_9)
						arg_90_1:RecordAudio("325621022", var_93_9)
					else
						arg_90_1:AudioAction("play", "voice", "story_v_out_325621", "325621022", "story_v_out_325621.awb")
					end

					arg_90_1:RecordHistoryTalkVoice("story_v_out_325621", "325621022", "story_v_out_325621.awb")
				end

				arg_90_1:RecordContent(arg_90_1.text_.text)
			end

			local var_93_10 = math.max(var_93_1, arg_90_1.talkMaxDuration)

			if var_93_0 <= arg_90_1.time_ and arg_90_1.time_ < var_93_0 + var_93_10 then
				arg_90_1.typewritter.percent = (arg_90_1.time_ - var_93_0) / var_93_10

				arg_90_1.typewritter:SetDirty()
			end

			if arg_90_1.time_ >= var_93_0 + var_93_10 and arg_90_1.time_ < var_93_0 + var_93_10 + arg_93_0 then
				arg_90_1.typewritter.percent = 1

				arg_90_1.typewritter:SetDirty()
				arg_90_1:ShowNextGo(true)
			end
		end

		arg_90_1.nodeConfigList_ = {}

		arg_90_1:InitPlayNodeList()
	end,
	Play325621023 = function(arg_94_0, arg_94_1)
		arg_94_1.time_ = 0
		arg_94_1.frameCnt_ = 0
		arg_94_1.state_ = "playing"
		arg_94_1.curTalkId_ = 325621023
		arg_94_1.duration_ = 5

		SetActive(arg_94_1.tipsGo_, false)

		function arg_94_1.onSingleLineFinish_()
			arg_94_1.onSingleLineUpdate_ = nil
			arg_94_1.onSingleLineFinish_ = nil
			arg_94_1.state_ = "waiting"
		end

		function arg_94_1.playNext_(arg_96_0)
			if arg_96_0 == 1 then
				arg_94_0:Play325621024(arg_94_1)
			end
		end

		function arg_94_1.onSingleLineUpdate_(arg_97_0)
			local var_97_0 = arg_94_1.actors_["1012ui_story"]
			local var_97_1 = 0

			if var_97_1 < arg_94_1.time_ and arg_94_1.time_ <= var_97_1 + arg_97_0 and not isNil(var_97_0) and arg_94_1.var_.characterEffect1012ui_story == nil then
				arg_94_1.var_.characterEffect1012ui_story = var_97_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_97_2 = 0.200000002980232

			if var_97_1 <= arg_94_1.time_ and arg_94_1.time_ < var_97_1 + var_97_2 and not isNil(var_97_0) then
				local var_97_3 = (arg_94_1.time_ - var_97_1) / var_97_2

				if arg_94_1.var_.characterEffect1012ui_story and not isNil(var_97_0) then
					local var_97_4 = Mathf.Lerp(0, 0.5, var_97_3)

					arg_94_1.var_.characterEffect1012ui_story.fillFlat = true
					arg_94_1.var_.characterEffect1012ui_story.fillRatio = var_97_4
				end
			end

			if arg_94_1.time_ >= var_97_1 + var_97_2 and arg_94_1.time_ < var_97_1 + var_97_2 + arg_97_0 and not isNil(var_97_0) and arg_94_1.var_.characterEffect1012ui_story then
				local var_97_5 = 0.5

				arg_94_1.var_.characterEffect1012ui_story.fillFlat = true
				arg_94_1.var_.characterEffect1012ui_story.fillRatio = var_97_5
			end

			local var_97_6 = 0
			local var_97_7 = 0.7

			if var_97_6 < arg_94_1.time_ and arg_94_1.time_ <= var_97_6 + arg_97_0 then
				arg_94_1.talkMaxDuration = 0
				arg_94_1.dialogCg_.alpha = 1

				arg_94_1.dialog_:SetActive(true)
				SetActive(arg_94_1.leftNameGo_, true)

				local var_97_8 = arg_94_1:FormatText(StoryNameCfg[7].name)

				arg_94_1.leftNameTxt_.text = var_97_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_94_1.leftNameTxt_.transform)

				arg_94_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_94_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_94_1:RecordName(arg_94_1.leftNameTxt_.text)
				SetActive(arg_94_1.iconTrs_.gameObject, true)
				arg_94_1.iconController_:SetSelectedState("hero")

				arg_94_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_94_1.callingController_:SetSelectedState("normal")

				arg_94_1.keyicon_.color = Color.New(1, 1, 1)
				arg_94_1.icon_.color = Color.New(1, 1, 1)

				local var_97_9 = arg_94_1:GetWordFromCfg(325621023)
				local var_97_10 = arg_94_1:FormatText(var_97_9.content)

				arg_94_1.text_.text = var_97_10

				LuaForUtil.ClearLinePrefixSymbol(arg_94_1.text_)

				local var_97_11 = 28
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
				arg_94_1:RecordContent(arg_94_1.text_.text)
			end

			local var_97_14 = math.max(var_97_7, arg_94_1.talkMaxDuration)

			if var_97_6 <= arg_94_1.time_ and arg_94_1.time_ < var_97_6 + var_97_14 then
				arg_94_1.typewritter.percent = (arg_94_1.time_ - var_97_6) / var_97_14

				arg_94_1.typewritter:SetDirty()
			end

			if arg_94_1.time_ >= var_97_6 + var_97_14 and arg_94_1.time_ < var_97_6 + var_97_14 + arg_97_0 then
				arg_94_1.typewritter.percent = 1

				arg_94_1.typewritter:SetDirty()
				arg_94_1:ShowNextGo(true)
			end
		end

		arg_94_1.nodeConfigList_ = {}

		arg_94_1:InitPlayNodeList()
	end,
	Play325621024 = function(arg_98_0, arg_98_1)
		arg_98_1.time_ = 0
		arg_98_1.frameCnt_ = 0
		arg_98_1.state_ = "playing"
		arg_98_1.curTalkId_ = 325621024
		arg_98_1.duration_ = 3.5

		local var_98_0 = {
			zh = 1.999999999999,
			ja = 3.5
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
				arg_98_0:Play325621025(arg_98_1)
			end
		end

		function arg_98_1.onSingleLineUpdate_(arg_101_0)
			local var_101_0 = arg_98_1.actors_["1012ui_story"]
			local var_101_1 = 0

			if var_101_1 < arg_98_1.time_ and arg_98_1.time_ <= var_101_1 + arg_101_0 and not isNil(var_101_0) and arg_98_1.var_.characterEffect1012ui_story == nil then
				arg_98_1.var_.characterEffect1012ui_story = var_101_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_101_2 = 0.200000002980232

			if var_101_1 <= arg_98_1.time_ and arg_98_1.time_ < var_101_1 + var_101_2 and not isNil(var_101_0) then
				local var_101_3 = (arg_98_1.time_ - var_101_1) / var_101_2

				if arg_98_1.var_.characterEffect1012ui_story and not isNil(var_101_0) then
					arg_98_1.var_.characterEffect1012ui_story.fillFlat = false
				end
			end

			if arg_98_1.time_ >= var_101_1 + var_101_2 and arg_98_1.time_ < var_101_1 + var_101_2 + arg_101_0 and not isNil(var_101_0) and arg_98_1.var_.characterEffect1012ui_story then
				arg_98_1.var_.characterEffect1012ui_story.fillFlat = false
			end

			local var_101_4 = 0

			if var_101_4 < arg_98_1.time_ and arg_98_1.time_ <= var_101_4 + arg_101_0 then
				arg_98_1:PlayTimeline("1012ui_story", "StoryTimeline/CharAction/story1012/story1012action/1012action2_2")
			end

			local var_101_5 = 0
			local var_101_6 = 0.175

			if var_101_5 < arg_98_1.time_ and arg_98_1.time_ <= var_101_5 + arg_101_0 then
				arg_98_1.talkMaxDuration = 0
				arg_98_1.dialogCg_.alpha = 1

				arg_98_1.dialog_:SetActive(true)
				SetActive(arg_98_1.leftNameGo_, true)

				local var_101_7 = arg_98_1:FormatText(StoryNameCfg[595].name)

				arg_98_1.leftNameTxt_.text = var_101_7

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_98_1.leftNameTxt_.transform)

				arg_98_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_98_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_98_1:RecordName(arg_98_1.leftNameTxt_.text)
				SetActive(arg_98_1.iconTrs_.gameObject, false)
				arg_98_1.callingController_:SetSelectedState("normal")

				local var_101_8 = arg_98_1:GetWordFromCfg(325621024)
				local var_101_9 = arg_98_1:FormatText(var_101_8.content)

				arg_98_1.text_.text = var_101_9

				LuaForUtil.ClearLinePrefixSymbol(arg_98_1.text_)

				local var_101_10 = 7
				local var_101_11 = utf8.len(var_101_9)
				local var_101_12 = var_101_10 <= 0 and var_101_6 or var_101_6 * (var_101_11 / var_101_10)

				if var_101_12 > 0 and var_101_6 < var_101_12 then
					arg_98_1.talkMaxDuration = var_101_12

					if var_101_12 + var_101_5 > arg_98_1.duration_ then
						arg_98_1.duration_ = var_101_12 + var_101_5
					end
				end

				arg_98_1.text_.text = var_101_9
				arg_98_1.typewritter.percent = 0

				arg_98_1.typewritter:SetDirty()
				arg_98_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_325621", "325621024", "story_v_out_325621.awb") ~= 0 then
					local var_101_13 = manager.audio:GetVoiceLength("story_v_out_325621", "325621024", "story_v_out_325621.awb") / 1000

					if var_101_13 + var_101_5 > arg_98_1.duration_ then
						arg_98_1.duration_ = var_101_13 + var_101_5
					end

					if var_101_8.prefab_name ~= "" and arg_98_1.actors_[var_101_8.prefab_name] ~= nil then
						local var_101_14 = LuaForUtil.PlayVoiceWithCriLipsync(arg_98_1.actors_[var_101_8.prefab_name].transform, "story_v_out_325621", "325621024", "story_v_out_325621.awb")

						arg_98_1:RecordAudio("325621024", var_101_14)
						arg_98_1:RecordAudio("325621024", var_101_14)
					else
						arg_98_1:AudioAction("play", "voice", "story_v_out_325621", "325621024", "story_v_out_325621.awb")
					end

					arg_98_1:RecordHistoryTalkVoice("story_v_out_325621", "325621024", "story_v_out_325621.awb")
				end

				arg_98_1:RecordContent(arg_98_1.text_.text)
			end

			local var_101_15 = math.max(var_101_6, arg_98_1.talkMaxDuration)

			if var_101_5 <= arg_98_1.time_ and arg_98_1.time_ < var_101_5 + var_101_15 then
				arg_98_1.typewritter.percent = (arg_98_1.time_ - var_101_5) / var_101_15

				arg_98_1.typewritter:SetDirty()
			end

			if arg_98_1.time_ >= var_101_5 + var_101_15 and arg_98_1.time_ < var_101_5 + var_101_15 + arg_101_0 then
				arg_98_1.typewritter.percent = 1

				arg_98_1.typewritter:SetDirty()
				arg_98_1:ShowNextGo(true)
			end
		end

		arg_98_1.nodeConfigList_ = {}

		arg_98_1:InitPlayNodeList()
	end,
	Play325621025 = function(arg_102_0, arg_102_1)
		arg_102_1.time_ = 0
		arg_102_1.frameCnt_ = 0
		arg_102_1.state_ = "playing"
		arg_102_1.curTalkId_ = 325621025
		arg_102_1.duration_ = 5

		SetActive(arg_102_1.tipsGo_, false)

		function arg_102_1.onSingleLineFinish_()
			arg_102_1.onSingleLineUpdate_ = nil
			arg_102_1.onSingleLineFinish_ = nil
			arg_102_1.state_ = "waiting"
		end

		function arg_102_1.playNext_(arg_104_0)
			if arg_104_0 == 1 then
				arg_102_0:Play325621026(arg_102_1)
			end
		end

		function arg_102_1.onSingleLineUpdate_(arg_105_0)
			local var_105_0 = arg_102_1.actors_["1012ui_story"]
			local var_105_1 = 0

			if var_105_1 < arg_102_1.time_ and arg_102_1.time_ <= var_105_1 + arg_105_0 and not isNil(var_105_0) and arg_102_1.var_.characterEffect1012ui_story == nil then
				arg_102_1.var_.characterEffect1012ui_story = var_105_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_105_2 = 0.200000002980232

			if var_105_1 <= arg_102_1.time_ and arg_102_1.time_ < var_105_1 + var_105_2 and not isNil(var_105_0) then
				local var_105_3 = (arg_102_1.time_ - var_105_1) / var_105_2

				if arg_102_1.var_.characterEffect1012ui_story and not isNil(var_105_0) then
					local var_105_4 = Mathf.Lerp(0, 0.5, var_105_3)

					arg_102_1.var_.characterEffect1012ui_story.fillFlat = true
					arg_102_1.var_.characterEffect1012ui_story.fillRatio = var_105_4
				end
			end

			if arg_102_1.time_ >= var_105_1 + var_105_2 and arg_102_1.time_ < var_105_1 + var_105_2 + arg_105_0 and not isNil(var_105_0) and arg_102_1.var_.characterEffect1012ui_story then
				local var_105_5 = 0.5

				arg_102_1.var_.characterEffect1012ui_story.fillFlat = true
				arg_102_1.var_.characterEffect1012ui_story.fillRatio = var_105_5
			end

			local var_105_6 = 0
			local var_105_7 = 0.5

			if var_105_6 < arg_102_1.time_ and arg_102_1.time_ <= var_105_6 + arg_105_0 then
				arg_102_1.talkMaxDuration = 0
				arg_102_1.dialogCg_.alpha = 1

				arg_102_1.dialog_:SetActive(true)
				SetActive(arg_102_1.leftNameGo_, true)

				local var_105_8 = arg_102_1:FormatText(StoryNameCfg[7].name)

				arg_102_1.leftNameTxt_.text = var_105_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_102_1.leftNameTxt_.transform)

				arg_102_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_102_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_102_1:RecordName(arg_102_1.leftNameTxt_.text)
				SetActive(arg_102_1.iconTrs_.gameObject, true)
				arg_102_1.iconController_:SetSelectedState("hero")

				arg_102_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_102_1.callingController_:SetSelectedState("normal")

				arg_102_1.keyicon_.color = Color.New(1, 1, 1)
				arg_102_1.icon_.color = Color.New(1, 1, 1)

				local var_105_9 = arg_102_1:GetWordFromCfg(325621025)
				local var_105_10 = arg_102_1:FormatText(var_105_9.content)

				arg_102_1.text_.text = var_105_10

				LuaForUtil.ClearLinePrefixSymbol(arg_102_1.text_)

				local var_105_11 = 20
				local var_105_12 = utf8.len(var_105_10)
				local var_105_13 = var_105_11 <= 0 and var_105_7 or var_105_7 * (var_105_12 / var_105_11)

				if var_105_13 > 0 and var_105_7 < var_105_13 then
					arg_102_1.talkMaxDuration = var_105_13

					if var_105_13 + var_105_6 > arg_102_1.duration_ then
						arg_102_1.duration_ = var_105_13 + var_105_6
					end
				end

				arg_102_1.text_.text = var_105_10
				arg_102_1.typewritter.percent = 0

				arg_102_1.typewritter:SetDirty()
				arg_102_1:ShowNextGo(false)
				arg_102_1:RecordContent(arg_102_1.text_.text)
			end

			local var_105_14 = math.max(var_105_7, arg_102_1.talkMaxDuration)

			if var_105_6 <= arg_102_1.time_ and arg_102_1.time_ < var_105_6 + var_105_14 then
				arg_102_1.typewritter.percent = (arg_102_1.time_ - var_105_6) / var_105_14

				arg_102_1.typewritter:SetDirty()
			end

			if arg_102_1.time_ >= var_105_6 + var_105_14 and arg_102_1.time_ < var_105_6 + var_105_14 + arg_105_0 then
				arg_102_1.typewritter.percent = 1

				arg_102_1.typewritter:SetDirty()
				arg_102_1:ShowNextGo(true)
			end
		end

		arg_102_1.nodeConfigList_ = {}

		arg_102_1:InitPlayNodeList()
	end,
	Play325621026 = function(arg_106_0, arg_106_1)
		arg_106_1.time_ = 0
		arg_106_1.frameCnt_ = 0
		arg_106_1.state_ = "playing"
		arg_106_1.curTalkId_ = 325621026
		arg_106_1.duration_ = 6.5

		local var_106_0 = {
			zh = 3.1,
			ja = 6.5
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
				arg_106_0:Play325621027(arg_106_1)
			end
		end

		function arg_106_1.onSingleLineUpdate_(arg_109_0)
			local var_109_0 = arg_106_1.actors_["1012ui_story"]
			local var_109_1 = 0

			if var_109_1 < arg_106_1.time_ and arg_106_1.time_ <= var_109_1 + arg_109_0 and not isNil(var_109_0) and arg_106_1.var_.characterEffect1012ui_story == nil then
				arg_106_1.var_.characterEffect1012ui_story = var_109_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_109_2 = 0.200000002980232

			if var_109_1 <= arg_106_1.time_ and arg_106_1.time_ < var_109_1 + var_109_2 and not isNil(var_109_0) then
				local var_109_3 = (arg_106_1.time_ - var_109_1) / var_109_2

				if arg_106_1.var_.characterEffect1012ui_story and not isNil(var_109_0) then
					arg_106_1.var_.characterEffect1012ui_story.fillFlat = false
				end
			end

			if arg_106_1.time_ >= var_109_1 + var_109_2 and arg_106_1.time_ < var_109_1 + var_109_2 + arg_109_0 and not isNil(var_109_0) and arg_106_1.var_.characterEffect1012ui_story then
				arg_106_1.var_.characterEffect1012ui_story.fillFlat = false
			end

			local var_109_4 = 0
			local var_109_5 = 0.375

			if var_109_4 < arg_106_1.time_ and arg_106_1.time_ <= var_109_4 + arg_109_0 then
				arg_106_1.talkMaxDuration = 0
				arg_106_1.dialogCg_.alpha = 1

				arg_106_1.dialog_:SetActive(true)
				SetActive(arg_106_1.leftNameGo_, true)

				local var_109_6 = arg_106_1:FormatText(StoryNameCfg[595].name)

				arg_106_1.leftNameTxt_.text = var_109_6

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_106_1.leftNameTxt_.transform)

				arg_106_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_106_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_106_1:RecordName(arg_106_1.leftNameTxt_.text)
				SetActive(arg_106_1.iconTrs_.gameObject, false)
				arg_106_1.callingController_:SetSelectedState("normal")

				local var_109_7 = arg_106_1:GetWordFromCfg(325621026)
				local var_109_8 = arg_106_1:FormatText(var_109_7.content)

				arg_106_1.text_.text = var_109_8

				LuaForUtil.ClearLinePrefixSymbol(arg_106_1.text_)

				local var_109_9 = 15
				local var_109_10 = utf8.len(var_109_8)
				local var_109_11 = var_109_9 <= 0 and var_109_5 or var_109_5 * (var_109_10 / var_109_9)

				if var_109_11 > 0 and var_109_5 < var_109_11 then
					arg_106_1.talkMaxDuration = var_109_11

					if var_109_11 + var_109_4 > arg_106_1.duration_ then
						arg_106_1.duration_ = var_109_11 + var_109_4
					end
				end

				arg_106_1.text_.text = var_109_8
				arg_106_1.typewritter.percent = 0

				arg_106_1.typewritter:SetDirty()
				arg_106_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_325621", "325621026", "story_v_out_325621.awb") ~= 0 then
					local var_109_12 = manager.audio:GetVoiceLength("story_v_out_325621", "325621026", "story_v_out_325621.awb") / 1000

					if var_109_12 + var_109_4 > arg_106_1.duration_ then
						arg_106_1.duration_ = var_109_12 + var_109_4
					end

					if var_109_7.prefab_name ~= "" and arg_106_1.actors_[var_109_7.prefab_name] ~= nil then
						local var_109_13 = LuaForUtil.PlayVoiceWithCriLipsync(arg_106_1.actors_[var_109_7.prefab_name].transform, "story_v_out_325621", "325621026", "story_v_out_325621.awb")

						arg_106_1:RecordAudio("325621026", var_109_13)
						arg_106_1:RecordAudio("325621026", var_109_13)
					else
						arg_106_1:AudioAction("play", "voice", "story_v_out_325621", "325621026", "story_v_out_325621.awb")
					end

					arg_106_1:RecordHistoryTalkVoice("story_v_out_325621", "325621026", "story_v_out_325621.awb")
				end

				arg_106_1:RecordContent(arg_106_1.text_.text)
			end

			local var_109_14 = math.max(var_109_5, arg_106_1.talkMaxDuration)

			if var_109_4 <= arg_106_1.time_ and arg_106_1.time_ < var_109_4 + var_109_14 then
				arg_106_1.typewritter.percent = (arg_106_1.time_ - var_109_4) / var_109_14

				arg_106_1.typewritter:SetDirty()
			end

			if arg_106_1.time_ >= var_109_4 + var_109_14 and arg_106_1.time_ < var_109_4 + var_109_14 + arg_109_0 then
				arg_106_1.typewritter.percent = 1

				arg_106_1.typewritter:SetDirty()
				arg_106_1:ShowNextGo(true)
			end
		end

		arg_106_1.nodeConfigList_ = {}

		arg_106_1:InitPlayNodeList()
	end,
	Play325621027 = function(arg_110_0, arg_110_1)
		arg_110_1.time_ = 0
		arg_110_1.frameCnt_ = 0
		arg_110_1.state_ = "playing"
		arg_110_1.curTalkId_ = 325621027
		arg_110_1.duration_ = 5

		SetActive(arg_110_1.tipsGo_, false)

		function arg_110_1.onSingleLineFinish_()
			arg_110_1.onSingleLineUpdate_ = nil
			arg_110_1.onSingleLineFinish_ = nil
			arg_110_1.state_ = "waiting"
		end

		function arg_110_1.playNext_(arg_112_0)
			if arg_112_0 == 1 then
				arg_110_0:Play325621028(arg_110_1)
			end
		end

		function arg_110_1.onSingleLineUpdate_(arg_113_0)
			local var_113_0 = arg_110_1.actors_["1012ui_story"]
			local var_113_1 = 0

			if var_113_1 < arg_110_1.time_ and arg_110_1.time_ <= var_113_1 + arg_113_0 and not isNil(var_113_0) and arg_110_1.var_.characterEffect1012ui_story == nil then
				arg_110_1.var_.characterEffect1012ui_story = var_113_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_113_2 = 0.200000002980232

			if var_113_1 <= arg_110_1.time_ and arg_110_1.time_ < var_113_1 + var_113_2 and not isNil(var_113_0) then
				local var_113_3 = (arg_110_1.time_ - var_113_1) / var_113_2

				if arg_110_1.var_.characterEffect1012ui_story and not isNil(var_113_0) then
					local var_113_4 = Mathf.Lerp(0, 0.5, var_113_3)

					arg_110_1.var_.characterEffect1012ui_story.fillFlat = true
					arg_110_1.var_.characterEffect1012ui_story.fillRatio = var_113_4
				end
			end

			if arg_110_1.time_ >= var_113_1 + var_113_2 and arg_110_1.time_ < var_113_1 + var_113_2 + arg_113_0 and not isNil(var_113_0) and arg_110_1.var_.characterEffect1012ui_story then
				local var_113_5 = 0.5

				arg_110_1.var_.characterEffect1012ui_story.fillFlat = true
				arg_110_1.var_.characterEffect1012ui_story.fillRatio = var_113_5
			end

			local var_113_6 = 0
			local var_113_7 = 0.05

			if var_113_6 < arg_110_1.time_ and arg_110_1.time_ <= var_113_6 + arg_113_0 then
				arg_110_1.talkMaxDuration = 0
				arg_110_1.dialogCg_.alpha = 1

				arg_110_1.dialog_:SetActive(true)
				SetActive(arg_110_1.leftNameGo_, true)

				local var_113_8 = arg_110_1:FormatText(StoryNameCfg[7].name)

				arg_110_1.leftNameTxt_.text = var_113_8

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

				local var_113_9 = arg_110_1:GetWordFromCfg(325621027)
				local var_113_10 = arg_110_1:FormatText(var_113_9.content)

				arg_110_1.text_.text = var_113_10

				LuaForUtil.ClearLinePrefixSymbol(arg_110_1.text_)

				local var_113_11 = 2
				local var_113_12 = utf8.len(var_113_10)
				local var_113_13 = var_113_11 <= 0 and var_113_7 or var_113_7 * (var_113_12 / var_113_11)

				if var_113_13 > 0 and var_113_7 < var_113_13 then
					arg_110_1.talkMaxDuration = var_113_13

					if var_113_13 + var_113_6 > arg_110_1.duration_ then
						arg_110_1.duration_ = var_113_13 + var_113_6
					end
				end

				arg_110_1.text_.text = var_113_10
				arg_110_1.typewritter.percent = 0

				arg_110_1.typewritter:SetDirty()
				arg_110_1:ShowNextGo(false)
				arg_110_1:RecordContent(arg_110_1.text_.text)
			end

			local var_113_14 = math.max(var_113_7, arg_110_1.talkMaxDuration)

			if var_113_6 <= arg_110_1.time_ and arg_110_1.time_ < var_113_6 + var_113_14 then
				arg_110_1.typewritter.percent = (arg_110_1.time_ - var_113_6) / var_113_14

				arg_110_1.typewritter:SetDirty()
			end

			if arg_110_1.time_ >= var_113_6 + var_113_14 and arg_110_1.time_ < var_113_6 + var_113_14 + arg_113_0 then
				arg_110_1.typewritter.percent = 1

				arg_110_1.typewritter:SetDirty()
				arg_110_1:ShowNextGo(true)
			end
		end

		arg_110_1.nodeConfigList_ = {}

		arg_110_1:InitPlayNodeList()
	end,
	Play325621028 = function(arg_114_0, arg_114_1)
		arg_114_1.time_ = 0
		arg_114_1.frameCnt_ = 0
		arg_114_1.state_ = "playing"
		arg_114_1.curTalkId_ = 325621028
		arg_114_1.duration_ = 10.67

		local var_114_0 = {
			zh = 6.566,
			ja = 10.666
		}
		local var_114_1 = manager.audio:GetLocalizationFlag()

		if var_114_0[var_114_1] ~= nil then
			arg_114_1.duration_ = var_114_0[var_114_1]
		end

		SetActive(arg_114_1.tipsGo_, false)

		function arg_114_1.onSingleLineFinish_()
			arg_114_1.onSingleLineUpdate_ = nil
			arg_114_1.onSingleLineFinish_ = nil
			arg_114_1.state_ = "waiting"
		end

		function arg_114_1.playNext_(arg_116_0)
			if arg_116_0 == 1 then
				arg_114_0:Play325621029(arg_114_1)
			end
		end

		function arg_114_1.onSingleLineUpdate_(arg_117_0)
			local var_117_0 = arg_114_1.actors_["1012ui_story"]
			local var_117_1 = 0

			if var_117_1 < arg_114_1.time_ and arg_114_1.time_ <= var_117_1 + arg_117_0 and not isNil(var_117_0) and arg_114_1.var_.characterEffect1012ui_story == nil then
				arg_114_1.var_.characterEffect1012ui_story = var_117_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_117_2 = 0.200000002980232

			if var_117_1 <= arg_114_1.time_ and arg_114_1.time_ < var_117_1 + var_117_2 and not isNil(var_117_0) then
				local var_117_3 = (arg_114_1.time_ - var_117_1) / var_117_2

				if arg_114_1.var_.characterEffect1012ui_story and not isNil(var_117_0) then
					arg_114_1.var_.characterEffect1012ui_story.fillFlat = false
				end
			end

			if arg_114_1.time_ >= var_117_1 + var_117_2 and arg_114_1.time_ < var_117_1 + var_117_2 + arg_117_0 and not isNil(var_117_0) and arg_114_1.var_.characterEffect1012ui_story then
				arg_114_1.var_.characterEffect1012ui_story.fillFlat = false
			end

			local var_117_4 = 0

			if var_117_4 < arg_114_1.time_ and arg_114_1.time_ <= var_117_4 + arg_117_0 then
				arg_114_1:PlayTimeline("1012ui_story", "StoryTimeline/CharAction/story1012/story1012action/1012action5_1")
			end

			local var_117_5 = 0
			local var_117_6 = 0.8

			if var_117_5 < arg_114_1.time_ and arg_114_1.time_ <= var_117_5 + arg_117_0 then
				arg_114_1.talkMaxDuration = 0
				arg_114_1.dialogCg_.alpha = 1

				arg_114_1.dialog_:SetActive(true)
				SetActive(arg_114_1.leftNameGo_, true)

				local var_117_7 = arg_114_1:FormatText(StoryNameCfg[595].name)

				arg_114_1.leftNameTxt_.text = var_117_7

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_114_1.leftNameTxt_.transform)

				arg_114_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_114_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_114_1:RecordName(arg_114_1.leftNameTxt_.text)
				SetActive(arg_114_1.iconTrs_.gameObject, false)
				arg_114_1.callingController_:SetSelectedState("normal")

				local var_117_8 = arg_114_1:GetWordFromCfg(325621028)
				local var_117_9 = arg_114_1:FormatText(var_117_8.content)

				arg_114_1.text_.text = var_117_9

				LuaForUtil.ClearLinePrefixSymbol(arg_114_1.text_)

				local var_117_10 = 32
				local var_117_11 = utf8.len(var_117_9)
				local var_117_12 = var_117_10 <= 0 and var_117_6 or var_117_6 * (var_117_11 / var_117_10)

				if var_117_12 > 0 and var_117_6 < var_117_12 then
					arg_114_1.talkMaxDuration = var_117_12

					if var_117_12 + var_117_5 > arg_114_1.duration_ then
						arg_114_1.duration_ = var_117_12 + var_117_5
					end
				end

				arg_114_1.text_.text = var_117_9
				arg_114_1.typewritter.percent = 0

				arg_114_1.typewritter:SetDirty()
				arg_114_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_325621", "325621028", "story_v_out_325621.awb") ~= 0 then
					local var_117_13 = manager.audio:GetVoiceLength("story_v_out_325621", "325621028", "story_v_out_325621.awb") / 1000

					if var_117_13 + var_117_5 > arg_114_1.duration_ then
						arg_114_1.duration_ = var_117_13 + var_117_5
					end

					if var_117_8.prefab_name ~= "" and arg_114_1.actors_[var_117_8.prefab_name] ~= nil then
						local var_117_14 = LuaForUtil.PlayVoiceWithCriLipsync(arg_114_1.actors_[var_117_8.prefab_name].transform, "story_v_out_325621", "325621028", "story_v_out_325621.awb")

						arg_114_1:RecordAudio("325621028", var_117_14)
						arg_114_1:RecordAudio("325621028", var_117_14)
					else
						arg_114_1:AudioAction("play", "voice", "story_v_out_325621", "325621028", "story_v_out_325621.awb")
					end

					arg_114_1:RecordHistoryTalkVoice("story_v_out_325621", "325621028", "story_v_out_325621.awb")
				end

				arg_114_1:RecordContent(arg_114_1.text_.text)
			end

			local var_117_15 = math.max(var_117_6, arg_114_1.talkMaxDuration)

			if var_117_5 <= arg_114_1.time_ and arg_114_1.time_ < var_117_5 + var_117_15 then
				arg_114_1.typewritter.percent = (arg_114_1.time_ - var_117_5) / var_117_15

				arg_114_1.typewritter:SetDirty()
			end

			if arg_114_1.time_ >= var_117_5 + var_117_15 and arg_114_1.time_ < var_117_5 + var_117_15 + arg_117_0 then
				arg_114_1.typewritter.percent = 1

				arg_114_1.typewritter:SetDirty()
				arg_114_1:ShowNextGo(true)
			end
		end

		arg_114_1.nodeConfigList_ = {}

		arg_114_1:InitPlayNodeList()
	end,
	Play325621029 = function(arg_118_0, arg_118_1)
		arg_118_1.time_ = 0
		arg_118_1.frameCnt_ = 0
		arg_118_1.state_ = "playing"
		arg_118_1.curTalkId_ = 325621029
		arg_118_1.duration_ = 9.8

		local var_118_0 = {
			zh = 5.633,
			ja = 9.8
		}
		local var_118_1 = manager.audio:GetLocalizationFlag()

		if var_118_0[var_118_1] ~= nil then
			arg_118_1.duration_ = var_118_0[var_118_1]
		end

		SetActive(arg_118_1.tipsGo_, false)

		function arg_118_1.onSingleLineFinish_()
			arg_118_1.onSingleLineUpdate_ = nil
			arg_118_1.onSingleLineFinish_ = nil
			arg_118_1.state_ = "waiting"
		end

		function arg_118_1.playNext_(arg_120_0)
			if arg_120_0 == 1 then
				arg_118_0:Play325621030(arg_118_1)
			end
		end

		function arg_118_1.onSingleLineUpdate_(arg_121_0)
			local var_121_0 = 0
			local var_121_1 = 0.775

			if var_121_0 < arg_118_1.time_ and arg_118_1.time_ <= var_121_0 + arg_121_0 then
				arg_118_1.talkMaxDuration = 0
				arg_118_1.dialogCg_.alpha = 1

				arg_118_1.dialog_:SetActive(true)
				SetActive(arg_118_1.leftNameGo_, true)

				local var_121_2 = arg_118_1:FormatText(StoryNameCfg[595].name)

				arg_118_1.leftNameTxt_.text = var_121_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_118_1.leftNameTxt_.transform)

				arg_118_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_118_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_118_1:RecordName(arg_118_1.leftNameTxt_.text)
				SetActive(arg_118_1.iconTrs_.gameObject, false)
				arg_118_1.callingController_:SetSelectedState("normal")

				local var_121_3 = arg_118_1:GetWordFromCfg(325621029)
				local var_121_4 = arg_118_1:FormatText(var_121_3.content)

				arg_118_1.text_.text = var_121_4

				LuaForUtil.ClearLinePrefixSymbol(arg_118_1.text_)

				local var_121_5 = 31
				local var_121_6 = utf8.len(var_121_4)
				local var_121_7 = var_121_5 <= 0 and var_121_1 or var_121_1 * (var_121_6 / var_121_5)

				if var_121_7 > 0 and var_121_1 < var_121_7 then
					arg_118_1.talkMaxDuration = var_121_7

					if var_121_7 + var_121_0 > arg_118_1.duration_ then
						arg_118_1.duration_ = var_121_7 + var_121_0
					end
				end

				arg_118_1.text_.text = var_121_4
				arg_118_1.typewritter.percent = 0

				arg_118_1.typewritter:SetDirty()
				arg_118_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_325621", "325621029", "story_v_out_325621.awb") ~= 0 then
					local var_121_8 = manager.audio:GetVoiceLength("story_v_out_325621", "325621029", "story_v_out_325621.awb") / 1000

					if var_121_8 + var_121_0 > arg_118_1.duration_ then
						arg_118_1.duration_ = var_121_8 + var_121_0
					end

					if var_121_3.prefab_name ~= "" and arg_118_1.actors_[var_121_3.prefab_name] ~= nil then
						local var_121_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_118_1.actors_[var_121_3.prefab_name].transform, "story_v_out_325621", "325621029", "story_v_out_325621.awb")

						arg_118_1:RecordAudio("325621029", var_121_9)
						arg_118_1:RecordAudio("325621029", var_121_9)
					else
						arg_118_1:AudioAction("play", "voice", "story_v_out_325621", "325621029", "story_v_out_325621.awb")
					end

					arg_118_1:RecordHistoryTalkVoice("story_v_out_325621", "325621029", "story_v_out_325621.awb")
				end

				arg_118_1:RecordContent(arg_118_1.text_.text)
			end

			local var_121_10 = math.max(var_121_1, arg_118_1.talkMaxDuration)

			if var_121_0 <= arg_118_1.time_ and arg_118_1.time_ < var_121_0 + var_121_10 then
				arg_118_1.typewritter.percent = (arg_118_1.time_ - var_121_0) / var_121_10

				arg_118_1.typewritter:SetDirty()
			end

			if arg_118_1.time_ >= var_121_0 + var_121_10 and arg_118_1.time_ < var_121_0 + var_121_10 + arg_121_0 then
				arg_118_1.typewritter.percent = 1

				arg_118_1.typewritter:SetDirty()
				arg_118_1:ShowNextGo(true)
			end
		end

		arg_118_1.nodeConfigList_ = {}

		arg_118_1:InitPlayNodeList()
	end,
	Play325621030 = function(arg_122_0, arg_122_1)
		arg_122_1.time_ = 0
		arg_122_1.frameCnt_ = 0
		arg_122_1.state_ = "playing"
		arg_122_1.curTalkId_ = 325621030
		arg_122_1.duration_ = 5

		SetActive(arg_122_1.tipsGo_, false)

		function arg_122_1.onSingleLineFinish_()
			arg_122_1.onSingleLineUpdate_ = nil
			arg_122_1.onSingleLineFinish_ = nil
			arg_122_1.state_ = "waiting"
		end

		function arg_122_1.playNext_(arg_124_0)
			if arg_124_0 == 1 then
				arg_122_0:Play325621031(arg_122_1)
			end
		end

		function arg_122_1.onSingleLineUpdate_(arg_125_0)
			local var_125_0 = arg_122_1.actors_["1012ui_story"]
			local var_125_1 = 0

			if var_125_1 < arg_122_1.time_ and arg_122_1.time_ <= var_125_1 + arg_125_0 and not isNil(var_125_0) and arg_122_1.var_.characterEffect1012ui_story == nil then
				arg_122_1.var_.characterEffect1012ui_story = var_125_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_125_2 = 0.200000002980232

			if var_125_1 <= arg_122_1.time_ and arg_122_1.time_ < var_125_1 + var_125_2 and not isNil(var_125_0) then
				local var_125_3 = (arg_122_1.time_ - var_125_1) / var_125_2

				if arg_122_1.var_.characterEffect1012ui_story and not isNil(var_125_0) then
					local var_125_4 = Mathf.Lerp(0, 0.5, var_125_3)

					arg_122_1.var_.characterEffect1012ui_story.fillFlat = true
					arg_122_1.var_.characterEffect1012ui_story.fillRatio = var_125_4
				end
			end

			if arg_122_1.time_ >= var_125_1 + var_125_2 and arg_122_1.time_ < var_125_1 + var_125_2 + arg_125_0 and not isNil(var_125_0) and arg_122_1.var_.characterEffect1012ui_story then
				local var_125_5 = 0.5

				arg_122_1.var_.characterEffect1012ui_story.fillFlat = true
				arg_122_1.var_.characterEffect1012ui_story.fillRatio = var_125_5
			end

			local var_125_6 = 0
			local var_125_7 = 0.05

			if var_125_6 < arg_122_1.time_ and arg_122_1.time_ <= var_125_6 + arg_125_0 then
				arg_122_1.talkMaxDuration = 0
				arg_122_1.dialogCg_.alpha = 1

				arg_122_1.dialog_:SetActive(true)
				SetActive(arg_122_1.leftNameGo_, true)

				local var_125_8 = arg_122_1:FormatText(StoryNameCfg[7].name)

				arg_122_1.leftNameTxt_.text = var_125_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_122_1.leftNameTxt_.transform)

				arg_122_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_122_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_122_1:RecordName(arg_122_1.leftNameTxt_.text)
				SetActive(arg_122_1.iconTrs_.gameObject, true)
				arg_122_1.iconController_:SetSelectedState("hero")

				arg_122_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_122_1.callingController_:SetSelectedState("normal")

				arg_122_1.keyicon_.color = Color.New(1, 1, 1)
				arg_122_1.icon_.color = Color.New(1, 1, 1)

				local var_125_9 = arg_122_1:GetWordFromCfg(325621030)
				local var_125_10 = arg_122_1:FormatText(var_125_9.content)

				arg_122_1.text_.text = var_125_10

				LuaForUtil.ClearLinePrefixSymbol(arg_122_1.text_)

				local var_125_11 = 2
				local var_125_12 = utf8.len(var_125_10)
				local var_125_13 = var_125_11 <= 0 and var_125_7 or var_125_7 * (var_125_12 / var_125_11)

				if var_125_13 > 0 and var_125_7 < var_125_13 then
					arg_122_1.talkMaxDuration = var_125_13

					if var_125_13 + var_125_6 > arg_122_1.duration_ then
						arg_122_1.duration_ = var_125_13 + var_125_6
					end
				end

				arg_122_1.text_.text = var_125_10
				arg_122_1.typewritter.percent = 0

				arg_122_1.typewritter:SetDirty()
				arg_122_1:ShowNextGo(false)
				arg_122_1:RecordContent(arg_122_1.text_.text)
			end

			local var_125_14 = math.max(var_125_7, arg_122_1.talkMaxDuration)

			if var_125_6 <= arg_122_1.time_ and arg_122_1.time_ < var_125_6 + var_125_14 then
				arg_122_1.typewritter.percent = (arg_122_1.time_ - var_125_6) / var_125_14

				arg_122_1.typewritter:SetDirty()
			end

			if arg_122_1.time_ >= var_125_6 + var_125_14 and arg_122_1.time_ < var_125_6 + var_125_14 + arg_125_0 then
				arg_122_1.typewritter.percent = 1

				arg_122_1.typewritter:SetDirty()
				arg_122_1:ShowNextGo(true)
			end
		end

		arg_122_1.nodeConfigList_ = {}

		arg_122_1:InitPlayNodeList()
	end,
	Play325621031 = function(arg_126_0, arg_126_1)
		arg_126_1.time_ = 0
		arg_126_1.frameCnt_ = 0
		arg_126_1.state_ = "playing"
		arg_126_1.curTalkId_ = 325621031
		arg_126_1.duration_ = 5

		SetActive(arg_126_1.tipsGo_, false)

		function arg_126_1.onSingleLineFinish_()
			arg_126_1.onSingleLineUpdate_ = nil
			arg_126_1.onSingleLineFinish_ = nil
			arg_126_1.state_ = "waiting"
		end

		function arg_126_1.playNext_(arg_128_0)
			if arg_128_0 == 1 then
				arg_126_0:Play325621032(arg_126_1)
			end
		end

		function arg_126_1.onSingleLineUpdate_(arg_129_0)
			local var_129_0 = 0
			local var_129_1 = 0.475

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

				local var_129_3 = arg_126_1:GetWordFromCfg(325621031)
				local var_129_4 = arg_126_1:FormatText(var_129_3.content)

				arg_126_1.text_.text = var_129_4

				LuaForUtil.ClearLinePrefixSymbol(arg_126_1.text_)

				local var_129_5 = 19
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
	Play325621032 = function(arg_130_0, arg_130_1)
		arg_130_1.time_ = 0
		arg_130_1.frameCnt_ = 0
		arg_130_1.state_ = "playing"
		arg_130_1.curTalkId_ = 325621032
		arg_130_1.duration_ = 8

		SetActive(arg_130_1.tipsGo_, false)

		function arg_130_1.onSingleLineFinish_()
			arg_130_1.onSingleLineUpdate_ = nil
			arg_130_1.onSingleLineFinish_ = nil
			arg_130_1.state_ = "waiting"
		end

		function arg_130_1.playNext_(arg_132_0)
			if arg_132_0 == 1 then
				arg_130_0:Play325621033(arg_130_1)
			end
		end

		function arg_130_1.onSingleLineUpdate_(arg_133_0)
			local var_133_0 = "J21h"

			if arg_130_1.bgs_[var_133_0] == nil then
				local var_133_1 = Object.Instantiate(arg_130_1.paintGo_)

				var_133_1:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. var_133_0)
				var_133_1.name = var_133_0
				var_133_1.transform.parent = arg_130_1.stage_.transform
				var_133_1.transform.localPosition = Vector3.New(0, 100, 0)
				arg_130_1.bgs_[var_133_0] = var_133_1
			end

			local var_133_2 = 1.2

			if var_133_2 < arg_130_1.time_ and arg_130_1.time_ <= var_133_2 + arg_133_0 then
				local var_133_3 = manager.ui.mainCamera.transform.localPosition
				local var_133_4 = Vector3.New(0, 0, 10) + Vector3.New(var_133_3.x, var_133_3.y, 0)
				local var_133_5 = arg_130_1.bgs_.J21h

				var_133_5.transform.localPosition = var_133_4
				var_133_5.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_133_6 = var_133_5:GetComponent("SpriteRenderer")

				if var_133_6 and var_133_6.sprite then
					local var_133_7 = (var_133_5.transform.localPosition - var_133_3).z
					local var_133_8 = manager.ui.mainCameraCom_
					local var_133_9 = 2 * var_133_7 * Mathf.Tan(var_133_8.fieldOfView * 0.5 * Mathf.Deg2Rad)
					local var_133_10 = var_133_9 * var_133_8.aspect
					local var_133_11 = var_133_6.sprite.bounds.size.x
					local var_133_12 = var_133_6.sprite.bounds.size.y
					local var_133_13 = var_133_10 / var_133_11
					local var_133_14 = var_133_9 / var_133_12
					local var_133_15 = var_133_14 < var_133_13 and var_133_13 or var_133_14

					var_133_5.transform.localScale = Vector3.New(var_133_15, var_133_15, 0)
				end

				for iter_133_0, iter_133_1 in pairs(arg_130_1.bgs_) do
					if iter_133_0 ~= "J21h" then
						iter_133_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_133_16 = 1.2

			if var_133_16 < arg_130_1.time_ and arg_130_1.time_ <= var_133_16 + arg_133_0 then
				arg_130_1.allBtn_.enabled = false
			end

			local var_133_17 = 0.3

			if arg_130_1.time_ >= var_133_16 + var_133_17 and arg_130_1.time_ < var_133_16 + var_133_17 + arg_133_0 then
				arg_130_1.allBtn_.enabled = true
			end

			local var_133_18 = 0

			if var_133_18 < arg_130_1.time_ and arg_130_1.time_ <= var_133_18 + arg_133_0 then
				arg_130_1.mask_.enabled = true
				arg_130_1.mask_.raycastTarget = true

				arg_130_1:SetGaussion(false)
			end

			local var_133_19 = 1.2

			if var_133_18 <= arg_130_1.time_ and arg_130_1.time_ < var_133_18 + var_133_19 then
				local var_133_20 = (arg_130_1.time_ - var_133_18) / var_133_19
				local var_133_21 = Color.New(0, 0, 0)

				var_133_21.a = Mathf.Lerp(0, 1, var_133_20)
				arg_130_1.mask_.color = var_133_21
			end

			if arg_130_1.time_ >= var_133_18 + var_133_19 and arg_130_1.time_ < var_133_18 + var_133_19 + arg_133_0 then
				local var_133_22 = Color.New(0, 0, 0)

				var_133_22.a = 1
				arg_130_1.mask_.color = var_133_22
			end

			local var_133_23 = 1.2

			if var_133_23 < arg_130_1.time_ and arg_130_1.time_ <= var_133_23 + arg_133_0 then
				arg_130_1.mask_.enabled = true
				arg_130_1.mask_.raycastTarget = true

				arg_130_1:SetGaussion(false)
			end

			local var_133_24 = 2

			if var_133_23 <= arg_130_1.time_ and arg_130_1.time_ < var_133_23 + var_133_24 then
				local var_133_25 = (arg_130_1.time_ - var_133_23) / var_133_24
				local var_133_26 = Color.New(0, 0, 0)

				var_133_26.a = Mathf.Lerp(1, 0, var_133_25)
				arg_130_1.mask_.color = var_133_26
			end

			if arg_130_1.time_ >= var_133_23 + var_133_24 and arg_130_1.time_ < var_133_23 + var_133_24 + arg_133_0 then
				local var_133_27 = Color.New(0, 0, 0)
				local var_133_28 = 0

				arg_130_1.mask_.enabled = false
				var_133_27.a = var_133_28
				arg_130_1.mask_.color = var_133_27
			end

			local var_133_29 = arg_130_1.actors_["1012ui_story"].transform
			local var_133_30 = 1.2

			if var_133_30 < arg_130_1.time_ and arg_130_1.time_ <= var_133_30 + arg_133_0 then
				arg_130_1.var_.moveOldPos1012ui_story = var_133_29.localPosition
			end

			local var_133_31 = 0.001

			if var_133_30 <= arg_130_1.time_ and arg_130_1.time_ < var_133_30 + var_133_31 then
				local var_133_32 = (arg_130_1.time_ - var_133_30) / var_133_31
				local var_133_33 = Vector3.New(0, 100, 0)

				var_133_29.localPosition = Vector3.Lerp(arg_130_1.var_.moveOldPos1012ui_story, var_133_33, var_133_32)

				local var_133_34 = manager.ui.mainCamera.transform.position - var_133_29.position

				var_133_29.forward = Vector3.New(var_133_34.x, var_133_34.y, var_133_34.z)

				local var_133_35 = var_133_29.localEulerAngles

				var_133_35.z = 0
				var_133_35.x = 0
				var_133_29.localEulerAngles = var_133_35
			end

			if arg_130_1.time_ >= var_133_30 + var_133_31 and arg_130_1.time_ < var_133_30 + var_133_31 + arg_133_0 then
				var_133_29.localPosition = Vector3.New(0, 100, 0)

				local var_133_36 = manager.ui.mainCamera.transform.position - var_133_29.position

				var_133_29.forward = Vector3.New(var_133_36.x, var_133_36.y, var_133_36.z)

				local var_133_37 = var_133_29.localEulerAngles

				var_133_37.z = 0
				var_133_37.x = 0
				var_133_29.localEulerAngles = var_133_37
			end

			if arg_130_1.frameCnt_ <= 1 then
				arg_130_1.dialog_:SetActive(false)
			end

			local var_133_38 = 3
			local var_133_39 = 0.925

			if var_133_38 < arg_130_1.time_ and arg_130_1.time_ <= var_133_38 + arg_133_0 then
				arg_130_1.talkMaxDuration = 0

				arg_130_1.dialog_:SetActive(true)

				arg_130_1.dialogCg_.alpha = 0

				local var_133_40 = LeanTween.value(arg_130_1.dialog_, 0, 1, 0.3)

				var_133_40:setOnUpdate(LuaHelper.FloatAction(function(arg_134_0)
					arg_130_1.dialogCg_.alpha = arg_134_0
				end))
				var_133_40:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_130_1.dialog_)
					var_133_40:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_130_1.duration_ = arg_130_1.duration_ + 0.3

				SetActive(arg_130_1.leftNameGo_, false)

				arg_130_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_130_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_130_1:RecordName(arg_130_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_130_1.iconTrs_.gameObject, false)
				arg_130_1.callingController_:SetSelectedState("normal")

				local var_133_41 = arg_130_1:GetWordFromCfg(325621032)
				local var_133_42 = arg_130_1:FormatText(var_133_41.content)

				arg_130_1.text_.text = var_133_42

				LuaForUtil.ClearLinePrefixSymbol(arg_130_1.text_)

				local var_133_43 = 37
				local var_133_44 = utf8.len(var_133_42)
				local var_133_45 = var_133_43 <= 0 and var_133_39 or var_133_39 * (var_133_44 / var_133_43)

				if var_133_45 > 0 and var_133_39 < var_133_45 then
					arg_130_1.talkMaxDuration = var_133_45
					var_133_38 = var_133_38 + 0.3

					if var_133_45 + var_133_38 > arg_130_1.duration_ then
						arg_130_1.duration_ = var_133_45 + var_133_38
					end
				end

				arg_130_1.text_.text = var_133_42
				arg_130_1.typewritter.percent = 0

				arg_130_1.typewritter:SetDirty()
				arg_130_1:ShowNextGo(false)
				arg_130_1:RecordContent(arg_130_1.text_.text)
			end

			local var_133_46 = var_133_38 + 0.3
			local var_133_47 = math.max(var_133_39, arg_130_1.talkMaxDuration)

			if var_133_46 <= arg_130_1.time_ and arg_130_1.time_ < var_133_46 + var_133_47 then
				arg_130_1.typewritter.percent = (arg_130_1.time_ - var_133_46) / var_133_47

				arg_130_1.typewritter:SetDirty()
			end

			if arg_130_1.time_ >= var_133_46 + var_133_47 and arg_130_1.time_ < var_133_46 + var_133_47 + arg_133_0 then
				arg_130_1.typewritter.percent = 1

				arg_130_1.typewritter:SetDirty()
				arg_130_1:ShowNextGo(true)
			end
		end

		arg_130_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1012ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 1.2,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_130_1:InitPlayNodeList()
	end,
	Play325621033 = function(arg_136_0, arg_136_1)
		arg_136_1.time_ = 0
		arg_136_1.frameCnt_ = 0
		arg_136_1.state_ = "playing"
		arg_136_1.curTalkId_ = 325621033
		arg_136_1.duration_ = 5

		SetActive(arg_136_1.tipsGo_, false)

		function arg_136_1.onSingleLineFinish_()
			arg_136_1.onSingleLineUpdate_ = nil
			arg_136_1.onSingleLineFinish_ = nil
			arg_136_1.state_ = "waiting"
		end

		function arg_136_1.playNext_(arg_138_0)
			if arg_138_0 == 1 then
				arg_136_0:Play325621034(arg_136_1)
			end
		end

		function arg_136_1.onSingleLineUpdate_(arg_139_0)
			local var_139_0 = 0
			local var_139_1 = 1.05

			if var_139_0 < arg_136_1.time_ and arg_136_1.time_ <= var_139_0 + arg_139_0 then
				arg_136_1.talkMaxDuration = 0
				arg_136_1.dialogCg_.alpha = 1

				arg_136_1.dialog_:SetActive(true)
				SetActive(arg_136_1.leftNameGo_, false)

				arg_136_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_136_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_136_1:RecordName(arg_136_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_136_1.iconTrs_.gameObject, false)
				arg_136_1.callingController_:SetSelectedState("normal")

				local var_139_2 = arg_136_1:GetWordFromCfg(325621033)
				local var_139_3 = arg_136_1:FormatText(var_139_2.content)

				arg_136_1.text_.text = var_139_3

				LuaForUtil.ClearLinePrefixSymbol(arg_136_1.text_)

				local var_139_4 = 42
				local var_139_5 = utf8.len(var_139_3)
				local var_139_6 = var_139_4 <= 0 and var_139_1 or var_139_1 * (var_139_5 / var_139_4)

				if var_139_6 > 0 and var_139_1 < var_139_6 then
					arg_136_1.talkMaxDuration = var_139_6

					if var_139_6 + var_139_0 > arg_136_1.duration_ then
						arg_136_1.duration_ = var_139_6 + var_139_0
					end
				end

				arg_136_1.text_.text = var_139_3
				arg_136_1.typewritter.percent = 0

				arg_136_1.typewritter:SetDirty()
				arg_136_1:ShowNextGo(false)
				arg_136_1:RecordContent(arg_136_1.text_.text)
			end

			local var_139_7 = math.max(var_139_1, arg_136_1.talkMaxDuration)

			if var_139_0 <= arg_136_1.time_ and arg_136_1.time_ < var_139_0 + var_139_7 then
				arg_136_1.typewritter.percent = (arg_136_1.time_ - var_139_0) / var_139_7

				arg_136_1.typewritter:SetDirty()
			end

			if arg_136_1.time_ >= var_139_0 + var_139_7 and arg_136_1.time_ < var_139_0 + var_139_7 + arg_139_0 then
				arg_136_1.typewritter.percent = 1

				arg_136_1.typewritter:SetDirty()
				arg_136_1:ShowNextGo(true)
			end
		end

		arg_136_1.nodeConfigList_ = {}

		arg_136_1:InitPlayNodeList()
	end,
	Play325621034 = function(arg_140_0, arg_140_1)
		arg_140_1.time_ = 0
		arg_140_1.frameCnt_ = 0
		arg_140_1.state_ = "playing"
		arg_140_1.curTalkId_ = 325621034
		arg_140_1.duration_ = 5

		SetActive(arg_140_1.tipsGo_, false)

		function arg_140_1.onSingleLineFinish_()
			arg_140_1.onSingleLineUpdate_ = nil
			arg_140_1.onSingleLineFinish_ = nil
			arg_140_1.state_ = "waiting"
		end

		function arg_140_1.playNext_(arg_142_0)
			if arg_142_0 == 1 then
				arg_140_0:Play325621035(arg_140_1)
			end
		end

		function arg_140_1.onSingleLineUpdate_(arg_143_0)
			local var_143_0 = 0
			local var_143_1 = 0.15

			if var_143_0 < arg_140_1.time_ and arg_140_1.time_ <= var_143_0 + arg_143_0 then
				arg_140_1.talkMaxDuration = 0
				arg_140_1.dialogCg_.alpha = 1

				arg_140_1.dialog_:SetActive(true)
				SetActive(arg_140_1.leftNameGo_, true)

				local var_143_2 = arg_140_1:FormatText(StoryNameCfg[7].name)

				arg_140_1.leftNameTxt_.text = var_143_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_140_1.leftNameTxt_.transform)

				arg_140_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_140_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_140_1:RecordName(arg_140_1.leftNameTxt_.text)
				SetActive(arg_140_1.iconTrs_.gameObject, true)
				arg_140_1.iconController_:SetSelectedState("hero")

				arg_140_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_140_1.callingController_:SetSelectedState("normal")

				arg_140_1.keyicon_.color = Color.New(1, 1, 1)
				arg_140_1.icon_.color = Color.New(1, 1, 1)

				local var_143_3 = arg_140_1:GetWordFromCfg(325621034)
				local var_143_4 = arg_140_1:FormatText(var_143_3.content)

				arg_140_1.text_.text = var_143_4

				LuaForUtil.ClearLinePrefixSymbol(arg_140_1.text_)

				local var_143_5 = 6
				local var_143_6 = utf8.len(var_143_4)
				local var_143_7 = var_143_5 <= 0 and var_143_1 or var_143_1 * (var_143_6 / var_143_5)

				if var_143_7 > 0 and var_143_1 < var_143_7 then
					arg_140_1.talkMaxDuration = var_143_7

					if var_143_7 + var_143_0 > arg_140_1.duration_ then
						arg_140_1.duration_ = var_143_7 + var_143_0
					end
				end

				arg_140_1.text_.text = var_143_4
				arg_140_1.typewritter.percent = 0

				arg_140_1.typewritter:SetDirty()
				arg_140_1:ShowNextGo(false)
				arg_140_1:RecordContent(arg_140_1.text_.text)
			end

			local var_143_8 = math.max(var_143_1, arg_140_1.talkMaxDuration)

			if var_143_0 <= arg_140_1.time_ and arg_140_1.time_ < var_143_0 + var_143_8 then
				arg_140_1.typewritter.percent = (arg_140_1.time_ - var_143_0) / var_143_8

				arg_140_1.typewritter:SetDirty()
			end

			if arg_140_1.time_ >= var_143_0 + var_143_8 and arg_140_1.time_ < var_143_0 + var_143_8 + arg_143_0 then
				arg_140_1.typewritter.percent = 1

				arg_140_1.typewritter:SetDirty()
				arg_140_1:ShowNextGo(true)
			end
		end

		arg_140_1.nodeConfigList_ = {}

		arg_140_1:InitPlayNodeList()
	end,
	Play325621035 = function(arg_144_0, arg_144_1)
		arg_144_1.time_ = 0
		arg_144_1.frameCnt_ = 0
		arg_144_1.state_ = "playing"
		arg_144_1.curTalkId_ = 325621035
		arg_144_1.duration_ = 7.4

		local var_144_0 = {
			zh = 4.8,
			ja = 7.4
		}
		local var_144_1 = manager.audio:GetLocalizationFlag()

		if var_144_0[var_144_1] ~= nil then
			arg_144_1.duration_ = var_144_0[var_144_1]
		end

		SetActive(arg_144_1.tipsGo_, false)

		function arg_144_1.onSingleLineFinish_()
			arg_144_1.onSingleLineUpdate_ = nil
			arg_144_1.onSingleLineFinish_ = nil
			arg_144_1.state_ = "waiting"
		end

		function arg_144_1.playNext_(arg_146_0)
			if arg_146_0 == 1 then
				arg_144_0:Play325621036(arg_144_1)
			end
		end

		function arg_144_1.onSingleLineUpdate_(arg_147_0)
			local var_147_0 = "10170ui_story"

			if arg_144_1.actors_[var_147_0] == nil then
				local var_147_1 = Asset.Load("Char/" .. "10170ui_story")

				if not isNil(var_147_1) then
					local var_147_2 = Object.Instantiate(Asset.Load("Char/" .. "10170ui_story"), arg_144_1.stage_.transform)

					var_147_2.name = var_147_0
					var_147_2.transform.localPosition = Vector3.New(0, 100, 0)
					arg_144_1.actors_[var_147_0] = var_147_2

					local var_147_3 = var_147_2:GetComponentInChildren(typeof(CharacterEffect))

					var_147_3.enabled = true

					local var_147_4 = GameObjectTools.GetOrAddComponent(var_147_2, typeof(DynamicBoneHelper))

					if var_147_4 then
						var_147_4:EnableDynamicBone(false)
					end

					arg_144_1:ShowWeapon(var_147_3.transform, false)

					arg_144_1.var_[var_147_0 .. "Animator"] = var_147_3.gameObject:GetComponent(typeof(UnityEngine.Animator))
					arg_144_1.var_[var_147_0 .. "Animator"].applyRootMotion = true
					arg_144_1.var_[var_147_0 .. "LipSync"] = var_147_3.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
				end
			end

			local var_147_5 = arg_144_1.actors_["10170ui_story"].transform
			local var_147_6 = 0

			if var_147_6 < arg_144_1.time_ and arg_144_1.time_ <= var_147_6 + arg_147_0 then
				arg_144_1.var_.moveOldPos10170ui_story = var_147_5.localPosition

				local var_147_7 = GameObjectTools.GetOrAddComponent(var_147_5.gameObject, typeof(DynamicBoneHelper))

				if var_147_7 then
					var_147_7:EnableDynamicBone(false)
				end
			end

			local var_147_8 = 0.001

			if var_147_6 <= arg_144_1.time_ and arg_144_1.time_ < var_147_6 + var_147_8 then
				local var_147_9 = (arg_144_1.time_ - var_147_6) / var_147_8
				local var_147_10 = Vector3.New(0, -1.03, -6.05)

				var_147_5.localPosition = Vector3.Lerp(arg_144_1.var_.moveOldPos10170ui_story, var_147_10, var_147_9)

				local var_147_11 = manager.ui.mainCamera.transform.position - var_147_5.position

				var_147_5.forward = Vector3.New(var_147_11.x, var_147_11.y, var_147_11.z)

				local var_147_12 = var_147_5.localEulerAngles

				var_147_12.z = 0
				var_147_12.x = 0
				var_147_5.localEulerAngles = var_147_12
			end

			if arg_144_1.time_ >= var_147_6 + var_147_8 and arg_144_1.time_ < var_147_6 + var_147_8 + arg_147_0 then
				var_147_5.localPosition = Vector3.New(0, -1.03, -6.05)

				local var_147_13 = manager.ui.mainCamera.transform.position - var_147_5.position

				var_147_5.forward = Vector3.New(var_147_13.x, var_147_13.y, var_147_13.z)

				local var_147_14 = var_147_5.localEulerAngles

				var_147_14.z = 0
				var_147_14.x = 0
				var_147_5.localEulerAngles = var_147_14

				local var_147_15 = GameObjectTools.GetOrAddComponent(var_147_5.gameObject, typeof(DynamicBoneHelper))

				if var_147_15 then
					var_147_15:EnableDynamicBone(true)
				end
			end

			local var_147_16 = arg_144_1.actors_["10170ui_story"]
			local var_147_17 = 0

			if var_147_17 < arg_144_1.time_ and arg_144_1.time_ <= var_147_17 + arg_147_0 and not isNil(var_147_16) and arg_144_1.var_.characterEffect10170ui_story == nil then
				arg_144_1.var_.characterEffect10170ui_story = var_147_16:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_147_18 = 0.200000002980232

			if var_147_17 <= arg_144_1.time_ and arg_144_1.time_ < var_147_17 + var_147_18 and not isNil(var_147_16) then
				local var_147_19 = (arg_144_1.time_ - var_147_17) / var_147_18

				if arg_144_1.var_.characterEffect10170ui_story and not isNil(var_147_16) then
					arg_144_1.var_.characterEffect10170ui_story.fillFlat = false
				end
			end

			if arg_144_1.time_ >= var_147_17 + var_147_18 and arg_144_1.time_ < var_147_17 + var_147_18 + arg_147_0 and not isNil(var_147_16) and arg_144_1.var_.characterEffect10170ui_story then
				arg_144_1.var_.characterEffect10170ui_story.fillFlat = false
			end

			local var_147_20 = 0

			if var_147_20 < arg_144_1.time_ and arg_144_1.time_ <= var_147_20 + arg_147_0 then
				arg_144_1:PlayTimeline("10170ui_story", "StoryTimeline/CharAction/story10170/story10170action/10170action2_1")
			end

			local var_147_21 = "1033ui_story"

			if arg_144_1.actors_[var_147_21] == nil then
				local var_147_22 = Asset.Load("Char/" .. "1033ui_story")

				if not isNil(var_147_22) then
					local var_147_23 = Object.Instantiate(Asset.Load("Char/" .. "1033ui_story"), arg_144_1.stage_.transform)

					var_147_23.name = var_147_21
					var_147_23.transform.localPosition = Vector3.New(0, 100, 0)
					arg_144_1.actors_[var_147_21] = var_147_23

					local var_147_24 = var_147_23:GetComponentInChildren(typeof(CharacterEffect))

					var_147_24.enabled = true

					local var_147_25 = GameObjectTools.GetOrAddComponent(var_147_23, typeof(DynamicBoneHelper))

					if var_147_25 then
						var_147_25:EnableDynamicBone(false)
					end

					arg_144_1:ShowWeapon(var_147_24.transform, false)

					arg_144_1.var_[var_147_21 .. "Animator"] = var_147_24.gameObject:GetComponent(typeof(UnityEngine.Animator))
					arg_144_1.var_[var_147_21 .. "Animator"].applyRootMotion = true
					arg_144_1.var_[var_147_21 .. "LipSync"] = var_147_24.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
				end
			end

			local var_147_26 = 0

			if var_147_26 < arg_144_1.time_ and arg_144_1.time_ <= var_147_26 + arg_147_0 then
				arg_144_1:PlayTimeline("1033ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva", "EmotionTimelineAnimator")
			end

			local var_147_27 = 0
			local var_147_28 = 0.425

			if var_147_27 < arg_144_1.time_ and arg_144_1.time_ <= var_147_27 + arg_147_0 then
				arg_144_1.talkMaxDuration = 0
				arg_144_1.dialogCg_.alpha = 1

				arg_144_1.dialog_:SetActive(true)
				SetActive(arg_144_1.leftNameGo_, true)

				local var_147_29 = arg_144_1:FormatText(StoryNameCfg[1450].name)

				arg_144_1.leftNameTxt_.text = var_147_29

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_144_1.leftNameTxt_.transform)

				arg_144_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_144_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_144_1:RecordName(arg_144_1.leftNameTxt_.text)
				SetActive(arg_144_1.iconTrs_.gameObject, false)
				arg_144_1.callingController_:SetSelectedState("normal")

				local var_147_30 = arg_144_1:GetWordFromCfg(325621035)
				local var_147_31 = arg_144_1:FormatText(var_147_30.content)

				arg_144_1.text_.text = var_147_31

				LuaForUtil.ClearLinePrefixSymbol(arg_144_1.text_)

				local var_147_32 = 17
				local var_147_33 = utf8.len(var_147_31)
				local var_147_34 = var_147_32 <= 0 and var_147_28 or var_147_28 * (var_147_33 / var_147_32)

				if var_147_34 > 0 and var_147_28 < var_147_34 then
					arg_144_1.talkMaxDuration = var_147_34

					if var_147_34 + var_147_27 > arg_144_1.duration_ then
						arg_144_1.duration_ = var_147_34 + var_147_27
					end
				end

				arg_144_1.text_.text = var_147_31
				arg_144_1.typewritter.percent = 0

				arg_144_1.typewritter:SetDirty()
				arg_144_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_325621", "325621035", "story_v_out_325621.awb") ~= 0 then
					local var_147_35 = manager.audio:GetVoiceLength("story_v_out_325621", "325621035", "story_v_out_325621.awb") / 1000

					if var_147_35 + var_147_27 > arg_144_1.duration_ then
						arg_144_1.duration_ = var_147_35 + var_147_27
					end

					if var_147_30.prefab_name ~= "" and arg_144_1.actors_[var_147_30.prefab_name] ~= nil then
						local var_147_36 = LuaForUtil.PlayVoiceWithCriLipsync(arg_144_1.actors_[var_147_30.prefab_name].transform, "story_v_out_325621", "325621035", "story_v_out_325621.awb")

						arg_144_1:RecordAudio("325621035", var_147_36)
						arg_144_1:RecordAudio("325621035", var_147_36)
					else
						arg_144_1:AudioAction("play", "voice", "story_v_out_325621", "325621035", "story_v_out_325621.awb")
					end

					arg_144_1:RecordHistoryTalkVoice("story_v_out_325621", "325621035", "story_v_out_325621.awb")
				end

				arg_144_1:RecordContent(arg_144_1.text_.text)
			end

			local var_147_37 = math.max(var_147_28, arg_144_1.talkMaxDuration)

			if var_147_27 <= arg_144_1.time_ and arg_144_1.time_ < var_147_27 + var_147_37 then
				arg_144_1.typewritter.percent = (arg_144_1.time_ - var_147_27) / var_147_37

				arg_144_1.typewritter:SetDirty()
			end

			if arg_144_1.time_ >= var_147_27 + var_147_37 and arg_144_1.time_ < var_147_27 + var_147_37 + arg_147_0 then
				arg_144_1.typewritter.percent = 1

				arg_144_1.typewritter:SetDirty()
				arg_144_1:ShowNextGo(true)
			end
		end

		arg_144_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10170ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_144_1:InitPlayNodeList()
	end,
	Play325621036 = function(arg_148_0, arg_148_1)
		arg_148_1.time_ = 0
		arg_148_1.frameCnt_ = 0
		arg_148_1.state_ = "playing"
		arg_148_1.curTalkId_ = 325621036
		arg_148_1.duration_ = 5

		SetActive(arg_148_1.tipsGo_, false)

		function arg_148_1.onSingleLineFinish_()
			arg_148_1.onSingleLineUpdate_ = nil
			arg_148_1.onSingleLineFinish_ = nil
			arg_148_1.state_ = "waiting"
		end

		function arg_148_1.playNext_(arg_150_0)
			if arg_150_0 == 1 then
				arg_148_0:Play325621037(arg_148_1)
			end
		end

		function arg_148_1.onSingleLineUpdate_(arg_151_0)
			local var_151_0 = arg_148_1.actors_["10170ui_story"]
			local var_151_1 = 0

			if var_151_1 < arg_148_1.time_ and arg_148_1.time_ <= var_151_1 + arg_151_0 and not isNil(var_151_0) and arg_148_1.var_.characterEffect10170ui_story == nil then
				arg_148_1.var_.characterEffect10170ui_story = var_151_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_151_2 = 0.200000002980232

			if var_151_1 <= arg_148_1.time_ and arg_148_1.time_ < var_151_1 + var_151_2 and not isNil(var_151_0) then
				local var_151_3 = (arg_148_1.time_ - var_151_1) / var_151_2

				if arg_148_1.var_.characterEffect10170ui_story and not isNil(var_151_0) then
					local var_151_4 = Mathf.Lerp(0, 0.5, var_151_3)

					arg_148_1.var_.characterEffect10170ui_story.fillFlat = true
					arg_148_1.var_.characterEffect10170ui_story.fillRatio = var_151_4
				end
			end

			if arg_148_1.time_ >= var_151_1 + var_151_2 and arg_148_1.time_ < var_151_1 + var_151_2 + arg_151_0 and not isNil(var_151_0) and arg_148_1.var_.characterEffect10170ui_story then
				local var_151_5 = 0.5

				arg_148_1.var_.characterEffect10170ui_story.fillFlat = true
				arg_148_1.var_.characterEffect10170ui_story.fillRatio = var_151_5
			end

			local var_151_6 = 0
			local var_151_7 = 0.95

			if var_151_6 < arg_148_1.time_ and arg_148_1.time_ <= var_151_6 + arg_151_0 then
				arg_148_1.talkMaxDuration = 0
				arg_148_1.dialogCg_.alpha = 1

				arg_148_1.dialog_:SetActive(true)
				SetActive(arg_148_1.leftNameGo_, true)

				local var_151_8 = arg_148_1:FormatText(StoryNameCfg[7].name)

				arg_148_1.leftNameTxt_.text = var_151_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_148_1.leftNameTxt_.transform)

				arg_148_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_148_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_148_1:RecordName(arg_148_1.leftNameTxt_.text)
				SetActive(arg_148_1.iconTrs_.gameObject, true)
				arg_148_1.iconController_:SetSelectedState("hero")

				arg_148_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_148_1.callingController_:SetSelectedState("normal")

				arg_148_1.keyicon_.color = Color.New(1, 1, 1)
				arg_148_1.icon_.color = Color.New(1, 1, 1)

				local var_151_9 = arg_148_1:GetWordFromCfg(325621036)
				local var_151_10 = arg_148_1:FormatText(var_151_9.content)

				arg_148_1.text_.text = var_151_10

				LuaForUtil.ClearLinePrefixSymbol(arg_148_1.text_)

				local var_151_11 = 38
				local var_151_12 = utf8.len(var_151_10)
				local var_151_13 = var_151_11 <= 0 and var_151_7 or var_151_7 * (var_151_12 / var_151_11)

				if var_151_13 > 0 and var_151_7 < var_151_13 then
					arg_148_1.talkMaxDuration = var_151_13

					if var_151_13 + var_151_6 > arg_148_1.duration_ then
						arg_148_1.duration_ = var_151_13 + var_151_6
					end
				end

				arg_148_1.text_.text = var_151_10
				arg_148_1.typewritter.percent = 0

				arg_148_1.typewritter:SetDirty()
				arg_148_1:ShowNextGo(false)
				arg_148_1:RecordContent(arg_148_1.text_.text)
			end

			local var_151_14 = math.max(var_151_7, arg_148_1.talkMaxDuration)

			if var_151_6 <= arg_148_1.time_ and arg_148_1.time_ < var_151_6 + var_151_14 then
				arg_148_1.typewritter.percent = (arg_148_1.time_ - var_151_6) / var_151_14

				arg_148_1.typewritter:SetDirty()
			end

			if arg_148_1.time_ >= var_151_6 + var_151_14 and arg_148_1.time_ < var_151_6 + var_151_14 + arg_151_0 then
				arg_148_1.typewritter.percent = 1

				arg_148_1.typewritter:SetDirty()
				arg_148_1:ShowNextGo(true)
			end
		end

		arg_148_1.nodeConfigList_ = {}

		arg_148_1:InitPlayNodeList()
	end,
	Play325621037 = function(arg_152_0, arg_152_1)
		arg_152_1.time_ = 0
		arg_152_1.frameCnt_ = 0
		arg_152_1.state_ = "playing"
		arg_152_1.curTalkId_ = 325621037
		arg_152_1.duration_ = 5

		SetActive(arg_152_1.tipsGo_, false)

		function arg_152_1.onSingleLineFinish_()
			arg_152_1.onSingleLineUpdate_ = nil
			arg_152_1.onSingleLineFinish_ = nil
			arg_152_1.state_ = "waiting"
		end

		function arg_152_1.playNext_(arg_154_0)
			if arg_154_0 == 1 then
				arg_152_0:Play325621038(arg_152_1)
			end
		end

		function arg_152_1.onSingleLineUpdate_(arg_155_0)
			local var_155_0 = 0
			local var_155_1 = 1.325

			if var_155_0 < arg_152_1.time_ and arg_152_1.time_ <= var_155_0 + arg_155_0 then
				arg_152_1.talkMaxDuration = 0
				arg_152_1.dialogCg_.alpha = 1

				arg_152_1.dialog_:SetActive(true)
				SetActive(arg_152_1.leftNameGo_, true)

				local var_155_2 = arg_152_1:FormatText(StoryNameCfg[7].name)

				arg_152_1.leftNameTxt_.text = var_155_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_152_1.leftNameTxt_.transform)

				arg_152_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_152_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_152_1:RecordName(arg_152_1.leftNameTxt_.text)
				SetActive(arg_152_1.iconTrs_.gameObject, true)
				arg_152_1.iconController_:SetSelectedState("hero")

				arg_152_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_152_1.callingController_:SetSelectedState("normal")

				arg_152_1.keyicon_.color = Color.New(1, 1, 1)
				arg_152_1.icon_.color = Color.New(1, 1, 1)

				local var_155_3 = arg_152_1:GetWordFromCfg(325621037)
				local var_155_4 = arg_152_1:FormatText(var_155_3.content)

				arg_152_1.text_.text = var_155_4

				LuaForUtil.ClearLinePrefixSymbol(arg_152_1.text_)

				local var_155_5 = 53
				local var_155_6 = utf8.len(var_155_4)
				local var_155_7 = var_155_5 <= 0 and var_155_1 or var_155_1 * (var_155_6 / var_155_5)

				if var_155_7 > 0 and var_155_1 < var_155_7 then
					arg_152_1.talkMaxDuration = var_155_7

					if var_155_7 + var_155_0 > arg_152_1.duration_ then
						arg_152_1.duration_ = var_155_7 + var_155_0
					end
				end

				arg_152_1.text_.text = var_155_4
				arg_152_1.typewritter.percent = 0

				arg_152_1.typewritter:SetDirty()
				arg_152_1:ShowNextGo(false)
				arg_152_1:RecordContent(arg_152_1.text_.text)
			end

			local var_155_8 = math.max(var_155_1, arg_152_1.talkMaxDuration)

			if var_155_0 <= arg_152_1.time_ and arg_152_1.time_ < var_155_0 + var_155_8 then
				arg_152_1.typewritter.percent = (arg_152_1.time_ - var_155_0) / var_155_8

				arg_152_1.typewritter:SetDirty()
			end

			if arg_152_1.time_ >= var_155_0 + var_155_8 and arg_152_1.time_ < var_155_0 + var_155_8 + arg_155_0 then
				arg_152_1.typewritter.percent = 1

				arg_152_1.typewritter:SetDirty()
				arg_152_1:ShowNextGo(true)
			end
		end

		arg_152_1.nodeConfigList_ = {}

		arg_152_1:InitPlayNodeList()
	end,
	Play325621038 = function(arg_156_0, arg_156_1)
		arg_156_1.time_ = 0
		arg_156_1.frameCnt_ = 0
		arg_156_1.state_ = "playing"
		arg_156_1.curTalkId_ = 325621038
		arg_156_1.duration_ = 2

		SetActive(arg_156_1.tipsGo_, false)

		function arg_156_1.onSingleLineFinish_()
			arg_156_1.onSingleLineUpdate_ = nil
			arg_156_1.onSingleLineFinish_ = nil
			arg_156_1.state_ = "waiting"
		end

		function arg_156_1.playNext_(arg_158_0)
			if arg_158_0 == 1 then
				arg_156_0:Play325621039(arg_156_1)
			end
		end

		function arg_156_1.onSingleLineUpdate_(arg_159_0)
			local var_159_0 = arg_156_1.actors_["10170ui_story"]
			local var_159_1 = 0

			if var_159_1 < arg_156_1.time_ and arg_156_1.time_ <= var_159_1 + arg_159_0 and not isNil(var_159_0) and arg_156_1.var_.characterEffect10170ui_story == nil then
				arg_156_1.var_.characterEffect10170ui_story = var_159_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_159_2 = 0.200000002980232

			if var_159_1 <= arg_156_1.time_ and arg_156_1.time_ < var_159_1 + var_159_2 and not isNil(var_159_0) then
				local var_159_3 = (arg_156_1.time_ - var_159_1) / var_159_2

				if arg_156_1.var_.characterEffect10170ui_story and not isNil(var_159_0) then
					arg_156_1.var_.characterEffect10170ui_story.fillFlat = false
				end
			end

			if arg_156_1.time_ >= var_159_1 + var_159_2 and arg_156_1.time_ < var_159_1 + var_159_2 + arg_159_0 and not isNil(var_159_0) and arg_156_1.var_.characterEffect10170ui_story then
				arg_156_1.var_.characterEffect10170ui_story.fillFlat = false
			end

			local var_159_4 = 0

			if var_159_4 < arg_156_1.time_ and arg_156_1.time_ <= var_159_4 + arg_159_0 then
				arg_156_1:PlayTimeline("10170ui_story", "StoryTimeline/CharAction/story10170/story10170actionlink/10170action4215")
			end

			local var_159_5 = 0
			local var_159_6 = 0.075

			if var_159_5 < arg_156_1.time_ and arg_156_1.time_ <= var_159_5 + arg_159_0 then
				arg_156_1.talkMaxDuration = 0
				arg_156_1.dialogCg_.alpha = 1

				arg_156_1.dialog_:SetActive(true)
				SetActive(arg_156_1.leftNameGo_, true)

				local var_159_7 = arg_156_1:FormatText(StoryNameCfg[1450].name)

				arg_156_1.leftNameTxt_.text = var_159_7

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_156_1.leftNameTxt_.transform)

				arg_156_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_156_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_156_1:RecordName(arg_156_1.leftNameTxt_.text)
				SetActive(arg_156_1.iconTrs_.gameObject, false)
				arg_156_1.callingController_:SetSelectedState("normal")

				local var_159_8 = arg_156_1:GetWordFromCfg(325621038)
				local var_159_9 = arg_156_1:FormatText(var_159_8.content)

				arg_156_1.text_.text = var_159_9

				LuaForUtil.ClearLinePrefixSymbol(arg_156_1.text_)

				local var_159_10 = 3
				local var_159_11 = utf8.len(var_159_9)
				local var_159_12 = var_159_10 <= 0 and var_159_6 or var_159_6 * (var_159_11 / var_159_10)

				if var_159_12 > 0 and var_159_6 < var_159_12 then
					arg_156_1.talkMaxDuration = var_159_12

					if var_159_12 + var_159_5 > arg_156_1.duration_ then
						arg_156_1.duration_ = var_159_12 + var_159_5
					end
				end

				arg_156_1.text_.text = var_159_9
				arg_156_1.typewritter.percent = 0

				arg_156_1.typewritter:SetDirty()
				arg_156_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_325621", "325621038", "story_v_out_325621.awb") ~= 0 then
					local var_159_13 = manager.audio:GetVoiceLength("story_v_out_325621", "325621038", "story_v_out_325621.awb") / 1000

					if var_159_13 + var_159_5 > arg_156_1.duration_ then
						arg_156_1.duration_ = var_159_13 + var_159_5
					end

					if var_159_8.prefab_name ~= "" and arg_156_1.actors_[var_159_8.prefab_name] ~= nil then
						local var_159_14 = LuaForUtil.PlayVoiceWithCriLipsync(arg_156_1.actors_[var_159_8.prefab_name].transform, "story_v_out_325621", "325621038", "story_v_out_325621.awb")

						arg_156_1:RecordAudio("325621038", var_159_14)
						arg_156_1:RecordAudio("325621038", var_159_14)
					else
						arg_156_1:AudioAction("play", "voice", "story_v_out_325621", "325621038", "story_v_out_325621.awb")
					end

					arg_156_1:RecordHistoryTalkVoice("story_v_out_325621", "325621038", "story_v_out_325621.awb")
				end

				arg_156_1:RecordContent(arg_156_1.text_.text)
			end

			local var_159_15 = math.max(var_159_6, arg_156_1.talkMaxDuration)

			if var_159_5 <= arg_156_1.time_ and arg_156_1.time_ < var_159_5 + var_159_15 then
				arg_156_1.typewritter.percent = (arg_156_1.time_ - var_159_5) / var_159_15

				arg_156_1.typewritter:SetDirty()
			end

			if arg_156_1.time_ >= var_159_5 + var_159_15 and arg_156_1.time_ < var_159_5 + var_159_15 + arg_159_0 then
				arg_156_1.typewritter.percent = 1

				arg_156_1.typewritter:SetDirty()
				arg_156_1:ShowNextGo(true)
			end
		end

		arg_156_1.nodeConfigList_ = {}

		arg_156_1:InitPlayNodeList()
	end,
	Play325621039 = function(arg_160_0, arg_160_1)
		arg_160_1.time_ = 0
		arg_160_1.frameCnt_ = 0
		arg_160_1.state_ = "playing"
		arg_160_1.curTalkId_ = 325621039
		arg_160_1.duration_ = 5

		SetActive(arg_160_1.tipsGo_, false)

		function arg_160_1.onSingleLineFinish_()
			arg_160_1.onSingleLineUpdate_ = nil
			arg_160_1.onSingleLineFinish_ = nil
			arg_160_1.state_ = "waiting"
		end

		function arg_160_1.playNext_(arg_162_0)
			if arg_162_0 == 1 then
				arg_160_0:Play325621040(arg_160_1)
			end
		end

		function arg_160_1.onSingleLineUpdate_(arg_163_0)
			local var_163_0 = arg_160_1.actors_["10170ui_story"].transform
			local var_163_1 = 0

			if var_163_1 < arg_160_1.time_ and arg_160_1.time_ <= var_163_1 + arg_163_0 then
				arg_160_1.var_.moveOldPos10170ui_story = var_163_0.localPosition

				local var_163_2 = GameObjectTools.GetOrAddComponent(var_163_0.gameObject, typeof(DynamicBoneHelper))

				if var_163_2 then
					var_163_2:EnableDynamicBone(false)
				end
			end

			local var_163_3 = 0.001

			if var_163_1 <= arg_160_1.time_ and arg_160_1.time_ < var_163_1 + var_163_3 then
				local var_163_4 = (arg_160_1.time_ - var_163_1) / var_163_3
				local var_163_5 = Vector3.New(0, 100, 0)

				var_163_0.localPosition = Vector3.Lerp(arg_160_1.var_.moveOldPos10170ui_story, var_163_5, var_163_4)

				local var_163_6 = manager.ui.mainCamera.transform.position - var_163_0.position

				var_163_0.forward = Vector3.New(var_163_6.x, var_163_6.y, var_163_6.z)

				local var_163_7 = var_163_0.localEulerAngles

				var_163_7.z = 0
				var_163_7.x = 0
				var_163_0.localEulerAngles = var_163_7
			end

			if arg_160_1.time_ >= var_163_1 + var_163_3 and arg_160_1.time_ < var_163_1 + var_163_3 + arg_163_0 then
				var_163_0.localPosition = Vector3.New(0, 100, 0)

				local var_163_8 = manager.ui.mainCamera.transform.position - var_163_0.position

				var_163_0.forward = Vector3.New(var_163_8.x, var_163_8.y, var_163_8.z)

				local var_163_9 = var_163_0.localEulerAngles

				var_163_9.z = 0
				var_163_9.x = 0
				var_163_0.localEulerAngles = var_163_9

				local var_163_10 = GameObjectTools.GetOrAddComponent(var_163_0.gameObject, typeof(DynamicBoneHelper))

				if var_163_10 then
					var_163_10:EnableDynamicBone(true)
				end
			end

			local var_163_11 = arg_160_1.actors_["10170ui_story"]
			local var_163_12 = 0

			if var_163_12 < arg_160_1.time_ and arg_160_1.time_ <= var_163_12 + arg_163_0 and not isNil(var_163_11) and arg_160_1.var_.characterEffect10170ui_story == nil then
				arg_160_1.var_.characterEffect10170ui_story = var_163_11:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_163_13 = 0.200000002980232

			if var_163_12 <= arg_160_1.time_ and arg_160_1.time_ < var_163_12 + var_163_13 and not isNil(var_163_11) then
				local var_163_14 = (arg_160_1.time_ - var_163_12) / var_163_13

				if arg_160_1.var_.characterEffect10170ui_story and not isNil(var_163_11) then
					local var_163_15 = Mathf.Lerp(0, 0.5, var_163_14)

					arg_160_1.var_.characterEffect10170ui_story.fillFlat = true
					arg_160_1.var_.characterEffect10170ui_story.fillRatio = var_163_15
				end
			end

			if arg_160_1.time_ >= var_163_12 + var_163_13 and arg_160_1.time_ < var_163_12 + var_163_13 + arg_163_0 and not isNil(var_163_11) and arg_160_1.var_.characterEffect10170ui_story then
				local var_163_16 = 0.5

				arg_160_1.var_.characterEffect10170ui_story.fillFlat = true
				arg_160_1.var_.characterEffect10170ui_story.fillRatio = var_163_16
			end

			local var_163_17 = 0.1
			local var_163_18 = 1

			if var_163_17 < arg_160_1.time_ and arg_160_1.time_ <= var_163_17 + arg_163_0 then
				local var_163_19 = "stop"
				local var_163_20 = "effect"

				arg_160_1:AudioAction(var_163_19, var_163_20, "se_story_side_128402", "se_story_side_128402_footstep_gravel", "")
			end

			local var_163_21 = 0
			local var_163_22 = 1.3

			if var_163_21 < arg_160_1.time_ and arg_160_1.time_ <= var_163_21 + arg_163_0 then
				arg_160_1.talkMaxDuration = 0
				arg_160_1.dialogCg_.alpha = 1

				arg_160_1.dialog_:SetActive(true)
				SetActive(arg_160_1.leftNameGo_, false)

				arg_160_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_160_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_160_1:RecordName(arg_160_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_160_1.iconTrs_.gameObject, false)
				arg_160_1.callingController_:SetSelectedState("normal")

				local var_163_23 = arg_160_1:GetWordFromCfg(325621039)
				local var_163_24 = arg_160_1:FormatText(var_163_23.content)

				arg_160_1.text_.text = var_163_24

				LuaForUtil.ClearLinePrefixSymbol(arg_160_1.text_)

				local var_163_25 = 52
				local var_163_26 = utf8.len(var_163_24)
				local var_163_27 = var_163_25 <= 0 and var_163_22 or var_163_22 * (var_163_26 / var_163_25)

				if var_163_27 > 0 and var_163_22 < var_163_27 then
					arg_160_1.talkMaxDuration = var_163_27

					if var_163_27 + var_163_21 > arg_160_1.duration_ then
						arg_160_1.duration_ = var_163_27 + var_163_21
					end
				end

				arg_160_1.text_.text = var_163_24
				arg_160_1.typewritter.percent = 0

				arg_160_1.typewritter:SetDirty()
				arg_160_1:ShowNextGo(false)
				arg_160_1:RecordContent(arg_160_1.text_.text)
			end

			local var_163_28 = math.max(var_163_22, arg_160_1.talkMaxDuration)

			if var_163_21 <= arg_160_1.time_ and arg_160_1.time_ < var_163_21 + var_163_28 then
				arg_160_1.typewritter.percent = (arg_160_1.time_ - var_163_21) / var_163_28

				arg_160_1.typewritter:SetDirty()
			end

			if arg_160_1.time_ >= var_163_21 + var_163_28 and arg_160_1.time_ < var_163_21 + var_163_28 + arg_163_0 then
				arg_160_1.typewritter.percent = 1

				arg_160_1.typewritter:SetDirty()
				arg_160_1:ShowNextGo(true)
			end
		end

		arg_160_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10170ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_160_1:InitPlayNodeList()
	end,
	Play325621040 = function(arg_164_0, arg_164_1)
		arg_164_1.time_ = 0
		arg_164_1.frameCnt_ = 0
		arg_164_1.state_ = "playing"
		arg_164_1.curTalkId_ = 325621040
		arg_164_1.duration_ = 5

		SetActive(arg_164_1.tipsGo_, false)

		function arg_164_1.onSingleLineFinish_()
			arg_164_1.onSingleLineUpdate_ = nil
			arg_164_1.onSingleLineFinish_ = nil
			arg_164_1.state_ = "waiting"
		end

		function arg_164_1.playNext_(arg_166_0)
			if arg_166_0 == 1 then
				arg_164_0:Play325621041(arg_164_1)
			end
		end

		function arg_164_1.onSingleLineUpdate_(arg_167_0)
			local var_167_0 = 0
			local var_167_1 = 1.175

			if var_167_0 < arg_164_1.time_ and arg_164_1.time_ <= var_167_0 + arg_167_0 then
				arg_164_1.talkMaxDuration = 0
				arg_164_1.dialogCg_.alpha = 1

				arg_164_1.dialog_:SetActive(true)
				SetActive(arg_164_1.leftNameGo_, false)

				arg_164_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_164_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_164_1:RecordName(arg_164_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_164_1.iconTrs_.gameObject, false)
				arg_164_1.callingController_:SetSelectedState("normal")

				local var_167_2 = arg_164_1:GetWordFromCfg(325621040)
				local var_167_3 = arg_164_1:FormatText(var_167_2.content)

				arg_164_1.text_.text = var_167_3

				LuaForUtil.ClearLinePrefixSymbol(arg_164_1.text_)

				local var_167_4 = 47
				local var_167_5 = utf8.len(var_167_3)
				local var_167_6 = var_167_4 <= 0 and var_167_1 or var_167_1 * (var_167_5 / var_167_4)

				if var_167_6 > 0 and var_167_1 < var_167_6 then
					arg_164_1.talkMaxDuration = var_167_6

					if var_167_6 + var_167_0 > arg_164_1.duration_ then
						arg_164_1.duration_ = var_167_6 + var_167_0
					end
				end

				arg_164_1.text_.text = var_167_3
				arg_164_1.typewritter.percent = 0

				arg_164_1.typewritter:SetDirty()
				arg_164_1:ShowNextGo(false)
				arg_164_1:RecordContent(arg_164_1.text_.text)
			end

			local var_167_7 = math.max(var_167_1, arg_164_1.talkMaxDuration)

			if var_167_0 <= arg_164_1.time_ and arg_164_1.time_ < var_167_0 + var_167_7 then
				arg_164_1.typewritter.percent = (arg_164_1.time_ - var_167_0) / var_167_7

				arg_164_1.typewritter:SetDirty()
			end

			if arg_164_1.time_ >= var_167_0 + var_167_7 and arg_164_1.time_ < var_167_0 + var_167_7 + arg_167_0 then
				arg_164_1.typewritter.percent = 1

				arg_164_1.typewritter:SetDirty()
				arg_164_1:ShowNextGo(true)
			end
		end

		arg_164_1.nodeConfigList_ = {}

		arg_164_1:InitPlayNodeList()
	end,
	Play325621041 = function(arg_168_0, arg_168_1)
		arg_168_1.time_ = 0
		arg_168_1.frameCnt_ = 0
		arg_168_1.state_ = "playing"
		arg_168_1.curTalkId_ = 325621041
		arg_168_1.duration_ = 8.53

		local var_168_0 = {
			zh = 8.2,
			ja = 8.533
		}
		local var_168_1 = manager.audio:GetLocalizationFlag()

		if var_168_0[var_168_1] ~= nil then
			arg_168_1.duration_ = var_168_0[var_168_1]
		end

		SetActive(arg_168_1.tipsGo_, false)

		function arg_168_1.onSingleLineFinish_()
			arg_168_1.onSingleLineUpdate_ = nil
			arg_168_1.onSingleLineFinish_ = nil
			arg_168_1.state_ = "waiting"
		end

		function arg_168_1.playNext_(arg_170_0)
			if arg_170_0 == 1 then
				arg_168_0:Play325621042(arg_168_1)
			end
		end

		function arg_168_1.onSingleLineUpdate_(arg_171_0)
			local var_171_0 = arg_168_1.actors_["10167ui_story"].transform
			local var_171_1 = 0

			if var_171_1 < arg_168_1.time_ and arg_168_1.time_ <= var_171_1 + arg_171_0 then
				arg_168_1.var_.moveOldPos10167ui_story = var_171_0.localPosition

				local var_171_2 = GameObjectTools.GetOrAddComponent(var_171_0.gameObject, typeof(DynamicBoneHelper))

				if var_171_2 then
					var_171_2:EnableDynamicBone(false)
				end
			end

			local var_171_3 = 0.001

			if var_171_1 <= arg_168_1.time_ and arg_168_1.time_ < var_171_1 + var_171_3 then
				local var_171_4 = (arg_168_1.time_ - var_171_1) / var_171_3
				local var_171_5 = Vector3.New(0, -1.28, -5.73)

				var_171_0.localPosition = Vector3.Lerp(arg_168_1.var_.moveOldPos10167ui_story, var_171_5, var_171_4)

				local var_171_6 = manager.ui.mainCamera.transform.position - var_171_0.position

				var_171_0.forward = Vector3.New(var_171_6.x, var_171_6.y, var_171_6.z)

				local var_171_7 = var_171_0.localEulerAngles

				var_171_7.z = 0
				var_171_7.x = 0
				var_171_0.localEulerAngles = var_171_7
			end

			if arg_168_1.time_ >= var_171_1 + var_171_3 and arg_168_1.time_ < var_171_1 + var_171_3 + arg_171_0 then
				var_171_0.localPosition = Vector3.New(0, -1.28, -5.73)

				local var_171_8 = manager.ui.mainCamera.transform.position - var_171_0.position

				var_171_0.forward = Vector3.New(var_171_8.x, var_171_8.y, var_171_8.z)

				local var_171_9 = var_171_0.localEulerAngles

				var_171_9.z = 0
				var_171_9.x = 0
				var_171_0.localEulerAngles = var_171_9

				local var_171_10 = GameObjectTools.GetOrAddComponent(var_171_0.gameObject, typeof(DynamicBoneHelper))

				if var_171_10 then
					var_171_10:EnableDynamicBone(true)
				end
			end

			local var_171_11 = arg_168_1.actors_["10167ui_story"]
			local var_171_12 = 0

			if var_171_12 < arg_168_1.time_ and arg_168_1.time_ <= var_171_12 + arg_171_0 and not isNil(var_171_11) and arg_168_1.var_.characterEffect10167ui_story == nil then
				arg_168_1.var_.characterEffect10167ui_story = var_171_11:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_171_13 = 0.200000002980232

			if var_171_12 <= arg_168_1.time_ and arg_168_1.time_ < var_171_12 + var_171_13 and not isNil(var_171_11) then
				local var_171_14 = (arg_168_1.time_ - var_171_12) / var_171_13

				if arg_168_1.var_.characterEffect10167ui_story and not isNil(var_171_11) then
					arg_168_1.var_.characterEffect10167ui_story.fillFlat = false
				end
			end

			if arg_168_1.time_ >= var_171_12 + var_171_13 and arg_168_1.time_ < var_171_12 + var_171_13 + arg_171_0 and not isNil(var_171_11) and arg_168_1.var_.characterEffect10167ui_story then
				arg_168_1.var_.characterEffect10167ui_story.fillFlat = false
			end

			local var_171_15 = 0

			if var_171_15 < arg_168_1.time_ and arg_168_1.time_ <= var_171_15 + arg_171_0 then
				arg_168_1:PlayTimeline("10167ui_story", "StoryTimeline/CharAction/public_expression/expr_wubiaoqing", "EmotionTimelineAnimator")
			end

			local var_171_16 = 0

			if var_171_16 < arg_168_1.time_ and arg_168_1.time_ <= var_171_16 + arg_171_0 then
				arg_168_1:PlayTimeline("10167ui_story", "StoryTimeline/CharAction/story10166/story10166action/10166action16_1")
			end

			local var_171_17 = 0
			local var_171_18 = 0.7

			if var_171_17 < arg_168_1.time_ and arg_168_1.time_ <= var_171_17 + arg_171_0 then
				arg_168_1.talkMaxDuration = 0
				arg_168_1.dialogCg_.alpha = 1

				arg_168_1.dialog_:SetActive(true)
				SetActive(arg_168_1.leftNameGo_, true)

				local var_171_19 = arg_168_1:FormatText(StoryNameCfg[1447].name)

				arg_168_1.leftNameTxt_.text = var_171_19

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_168_1.leftNameTxt_.transform)

				arg_168_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_168_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_168_1:RecordName(arg_168_1.leftNameTxt_.text)
				SetActive(arg_168_1.iconTrs_.gameObject, false)
				arg_168_1.callingController_:SetSelectedState("normal")

				local var_171_20 = arg_168_1:GetWordFromCfg(325621041)
				local var_171_21 = arg_168_1:FormatText(var_171_20.content)

				arg_168_1.text_.text = var_171_21

				LuaForUtil.ClearLinePrefixSymbol(arg_168_1.text_)

				local var_171_22 = 28
				local var_171_23 = utf8.len(var_171_21)
				local var_171_24 = var_171_22 <= 0 and var_171_18 or var_171_18 * (var_171_23 / var_171_22)

				if var_171_24 > 0 and var_171_18 < var_171_24 then
					arg_168_1.talkMaxDuration = var_171_24

					if var_171_24 + var_171_17 > arg_168_1.duration_ then
						arg_168_1.duration_ = var_171_24 + var_171_17
					end
				end

				arg_168_1.text_.text = var_171_21
				arg_168_1.typewritter.percent = 0

				arg_168_1.typewritter:SetDirty()
				arg_168_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_325621", "325621041", "story_v_out_325621.awb") ~= 0 then
					local var_171_25 = manager.audio:GetVoiceLength("story_v_out_325621", "325621041", "story_v_out_325621.awb") / 1000

					if var_171_25 + var_171_17 > arg_168_1.duration_ then
						arg_168_1.duration_ = var_171_25 + var_171_17
					end

					if var_171_20.prefab_name ~= "" and arg_168_1.actors_[var_171_20.prefab_name] ~= nil then
						local var_171_26 = LuaForUtil.PlayVoiceWithCriLipsync(arg_168_1.actors_[var_171_20.prefab_name].transform, "story_v_out_325621", "325621041", "story_v_out_325621.awb")

						arg_168_1:RecordAudio("325621041", var_171_26)
						arg_168_1:RecordAudio("325621041", var_171_26)
					else
						arg_168_1:AudioAction("play", "voice", "story_v_out_325621", "325621041", "story_v_out_325621.awb")
					end

					arg_168_1:RecordHistoryTalkVoice("story_v_out_325621", "325621041", "story_v_out_325621.awb")
				end

				arg_168_1:RecordContent(arg_168_1.text_.text)
			end

			local var_171_27 = math.max(var_171_18, arg_168_1.talkMaxDuration)

			if var_171_17 <= arg_168_1.time_ and arg_168_1.time_ < var_171_17 + var_171_27 then
				arg_168_1.typewritter.percent = (arg_168_1.time_ - var_171_17) / var_171_27

				arg_168_1.typewritter:SetDirty()
			end

			if arg_168_1.time_ >= var_171_17 + var_171_27 and arg_168_1.time_ < var_171_17 + var_171_27 + arg_171_0 then
				arg_168_1.typewritter.percent = 1

				arg_168_1.typewritter:SetDirty()
				arg_168_1:ShowNextGo(true)
			end
		end

		arg_168_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10167ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_168_1:InitPlayNodeList()
	end,
	Play325621042 = function(arg_172_0, arg_172_1)
		arg_172_1.time_ = 0
		arg_172_1.frameCnt_ = 0
		arg_172_1.state_ = "playing"
		arg_172_1.curTalkId_ = 325621042
		arg_172_1.duration_ = 5

		SetActive(arg_172_1.tipsGo_, false)

		function arg_172_1.onSingleLineFinish_()
			arg_172_1.onSingleLineUpdate_ = nil
			arg_172_1.onSingleLineFinish_ = nil
			arg_172_1.state_ = "waiting"
		end

		function arg_172_1.playNext_(arg_174_0)
			if arg_174_0 == 1 then
				arg_172_0:Play325621043(arg_172_1)
			end
		end

		function arg_172_1.onSingleLineUpdate_(arg_175_0)
			local var_175_0 = arg_172_1.actors_["10167ui_story"].transform
			local var_175_1 = 0

			if var_175_1 < arg_172_1.time_ and arg_172_1.time_ <= var_175_1 + arg_175_0 then
				arg_172_1.var_.moveOldPos10167ui_story = var_175_0.localPosition

				local var_175_2 = GameObjectTools.GetOrAddComponent(var_175_0.gameObject, typeof(DynamicBoneHelper))

				if var_175_2 then
					var_175_2:EnableDynamicBone(false)
				end
			end

			local var_175_3 = 0.001

			if var_175_1 <= arg_172_1.time_ and arg_172_1.time_ < var_175_1 + var_175_3 then
				local var_175_4 = (arg_172_1.time_ - var_175_1) / var_175_3
				local var_175_5 = Vector3.New(0, 100, 0)

				var_175_0.localPosition = Vector3.Lerp(arg_172_1.var_.moveOldPos10167ui_story, var_175_5, var_175_4)

				local var_175_6 = manager.ui.mainCamera.transform.position - var_175_0.position

				var_175_0.forward = Vector3.New(var_175_6.x, var_175_6.y, var_175_6.z)

				local var_175_7 = var_175_0.localEulerAngles

				var_175_7.z = 0
				var_175_7.x = 0
				var_175_0.localEulerAngles = var_175_7
			end

			if arg_172_1.time_ >= var_175_1 + var_175_3 and arg_172_1.time_ < var_175_1 + var_175_3 + arg_175_0 then
				var_175_0.localPosition = Vector3.New(0, 100, 0)

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

			local var_175_11 = arg_172_1.actors_["10167ui_story"]
			local var_175_12 = 0

			if var_175_12 < arg_172_1.time_ and arg_172_1.time_ <= var_175_12 + arg_175_0 and not isNil(var_175_11) and arg_172_1.var_.characterEffect10167ui_story == nil then
				arg_172_1.var_.characterEffect10167ui_story = var_175_11:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_175_13 = 0.200000002980232

			if var_175_12 <= arg_172_1.time_ and arg_172_1.time_ < var_175_12 + var_175_13 and not isNil(var_175_11) then
				local var_175_14 = (arg_172_1.time_ - var_175_12) / var_175_13

				if arg_172_1.var_.characterEffect10167ui_story and not isNil(var_175_11) then
					local var_175_15 = Mathf.Lerp(0, 0.5, var_175_14)

					arg_172_1.var_.characterEffect10167ui_story.fillFlat = true
					arg_172_1.var_.characterEffect10167ui_story.fillRatio = var_175_15
				end
			end

			if arg_172_1.time_ >= var_175_12 + var_175_13 and arg_172_1.time_ < var_175_12 + var_175_13 + arg_175_0 and not isNil(var_175_11) and arg_172_1.var_.characterEffect10167ui_story then
				local var_175_16 = 0.5

				arg_172_1.var_.characterEffect10167ui_story.fillFlat = true
				arg_172_1.var_.characterEffect10167ui_story.fillRatio = var_175_16
			end

			local var_175_17 = 0
			local var_175_18 = 0.625

			if var_175_17 < arg_172_1.time_ and arg_172_1.time_ <= var_175_17 + arg_175_0 then
				arg_172_1.talkMaxDuration = 0
				arg_172_1.dialogCg_.alpha = 1

				arg_172_1.dialog_:SetActive(true)
				SetActive(arg_172_1.leftNameGo_, false)

				arg_172_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_172_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_172_1:RecordName(arg_172_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_172_1.iconTrs_.gameObject, false)
				arg_172_1.callingController_:SetSelectedState("normal")

				local var_175_19 = arg_172_1:GetWordFromCfg(325621042)
				local var_175_20 = arg_172_1:FormatText(var_175_19.content)

				arg_172_1.text_.text = var_175_20

				LuaForUtil.ClearLinePrefixSymbol(arg_172_1.text_)

				local var_175_21 = 25
				local var_175_22 = utf8.len(var_175_20)
				local var_175_23 = var_175_21 <= 0 and var_175_18 or var_175_18 * (var_175_22 / var_175_21)

				if var_175_23 > 0 and var_175_18 < var_175_23 then
					arg_172_1.talkMaxDuration = var_175_23

					if var_175_23 + var_175_17 > arg_172_1.duration_ then
						arg_172_1.duration_ = var_175_23 + var_175_17
					end
				end

				arg_172_1.text_.text = var_175_20
				arg_172_1.typewritter.percent = 0

				arg_172_1.typewritter:SetDirty()
				arg_172_1:ShowNextGo(false)
				arg_172_1:RecordContent(arg_172_1.text_.text)
			end

			local var_175_24 = math.max(var_175_18, arg_172_1.talkMaxDuration)

			if var_175_17 <= arg_172_1.time_ and arg_172_1.time_ < var_175_17 + var_175_24 then
				arg_172_1.typewritter.percent = (arg_172_1.time_ - var_175_17) / var_175_24

				arg_172_1.typewritter:SetDirty()
			end

			if arg_172_1.time_ >= var_175_17 + var_175_24 and arg_172_1.time_ < var_175_17 + var_175_24 + arg_175_0 then
				arg_172_1.typewritter.percent = 1

				arg_172_1.typewritter:SetDirty()
				arg_172_1:ShowNextGo(true)
			end
		end

		arg_172_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10167ui_story",
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
	Play325621043 = function(arg_176_0, arg_176_1)
		arg_176_1.time_ = 0
		arg_176_1.frameCnt_ = 0
		arg_176_1.state_ = "playing"
		arg_176_1.curTalkId_ = 325621043
		arg_176_1.duration_ = 16.5

		local var_176_0 = {
			zh = 11.1,
			ja = 16.5
		}
		local var_176_1 = manager.audio:GetLocalizationFlag()

		if var_176_0[var_176_1] ~= nil then
			arg_176_1.duration_ = var_176_0[var_176_1]
		end

		SetActive(arg_176_1.tipsGo_, false)

		function arg_176_1.onSingleLineFinish_()
			arg_176_1.onSingleLineUpdate_ = nil
			arg_176_1.onSingleLineFinish_ = nil
			arg_176_1.state_ = "waiting"
		end

		function arg_176_1.playNext_(arg_178_0)
			if arg_178_0 == 1 then
				arg_176_0:Play325621044(arg_176_1)
			end
		end

		function arg_176_1.onSingleLineUpdate_(arg_179_0)
			local var_179_0 = arg_176_1.actors_["10167ui_story"].transform
			local var_179_1 = 0

			if var_179_1 < arg_176_1.time_ and arg_176_1.time_ <= var_179_1 + arg_179_0 then
				arg_176_1.var_.moveOldPos10167ui_story = var_179_0.localPosition

				local var_179_2 = GameObjectTools.GetOrAddComponent(var_179_0.gameObject, typeof(DynamicBoneHelper))

				if var_179_2 then
					var_179_2:EnableDynamicBone(false)
				end
			end

			local var_179_3 = 0.001

			if var_179_1 <= arg_176_1.time_ and arg_176_1.time_ < var_179_1 + var_179_3 then
				local var_179_4 = (arg_176_1.time_ - var_179_1) / var_179_3
				local var_179_5 = Vector3.New(0, -1.28, -5.73)

				var_179_0.localPosition = Vector3.Lerp(arg_176_1.var_.moveOldPos10167ui_story, var_179_5, var_179_4)

				local var_179_6 = manager.ui.mainCamera.transform.position - var_179_0.position

				var_179_0.forward = Vector3.New(var_179_6.x, var_179_6.y, var_179_6.z)

				local var_179_7 = var_179_0.localEulerAngles

				var_179_7.z = 0
				var_179_7.x = 0
				var_179_0.localEulerAngles = var_179_7
			end

			if arg_176_1.time_ >= var_179_1 + var_179_3 and arg_176_1.time_ < var_179_1 + var_179_3 + arg_179_0 then
				var_179_0.localPosition = Vector3.New(0, -1.28, -5.73)

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

			local var_179_11 = arg_176_1.actors_["10167ui_story"]
			local var_179_12 = 0

			if var_179_12 < arg_176_1.time_ and arg_176_1.time_ <= var_179_12 + arg_179_0 and not isNil(var_179_11) and arg_176_1.var_.characterEffect10167ui_story == nil then
				arg_176_1.var_.characterEffect10167ui_story = var_179_11:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_179_13 = 0.200000002980232

			if var_179_12 <= arg_176_1.time_ and arg_176_1.time_ < var_179_12 + var_179_13 and not isNil(var_179_11) then
				local var_179_14 = (arg_176_1.time_ - var_179_12) / var_179_13

				if arg_176_1.var_.characterEffect10167ui_story and not isNil(var_179_11) then
					arg_176_1.var_.characterEffect10167ui_story.fillFlat = false
				end
			end

			if arg_176_1.time_ >= var_179_12 + var_179_13 and arg_176_1.time_ < var_179_12 + var_179_13 + arg_179_0 and not isNil(var_179_11) and arg_176_1.var_.characterEffect10167ui_story then
				arg_176_1.var_.characterEffect10167ui_story.fillFlat = false
			end

			local var_179_15 = 0
			local var_179_16 = 0.6

			if var_179_15 < arg_176_1.time_ and arg_176_1.time_ <= var_179_15 + arg_179_0 then
				arg_176_1.talkMaxDuration = 0
				arg_176_1.dialogCg_.alpha = 1

				arg_176_1.dialog_:SetActive(true)
				SetActive(arg_176_1.leftNameGo_, true)

				local var_179_17 = arg_176_1:FormatText(StoryNameCfg[1447].name)

				arg_176_1.leftNameTxt_.text = var_179_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_176_1.leftNameTxt_.transform)

				arg_176_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_176_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_176_1:RecordName(arg_176_1.leftNameTxt_.text)
				SetActive(arg_176_1.iconTrs_.gameObject, false)
				arg_176_1.callingController_:SetSelectedState("normal")

				local var_179_18 = arg_176_1:GetWordFromCfg(325621043)
				local var_179_19 = arg_176_1:FormatText(var_179_18.content)

				arg_176_1.text_.text = var_179_19

				LuaForUtil.ClearLinePrefixSymbol(arg_176_1.text_)

				local var_179_20 = 24
				local var_179_21 = utf8.len(var_179_19)
				local var_179_22 = var_179_20 <= 0 and var_179_16 or var_179_16 * (var_179_21 / var_179_20)

				if var_179_22 > 0 and var_179_16 < var_179_22 then
					arg_176_1.talkMaxDuration = var_179_22

					if var_179_22 + var_179_15 > arg_176_1.duration_ then
						arg_176_1.duration_ = var_179_22 + var_179_15
					end
				end

				arg_176_1.text_.text = var_179_19
				arg_176_1.typewritter.percent = 0

				arg_176_1.typewritter:SetDirty()
				arg_176_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_325621", "325621043", "story_v_out_325621.awb") ~= 0 then
					local var_179_23 = manager.audio:GetVoiceLength("story_v_out_325621", "325621043", "story_v_out_325621.awb") / 1000

					if var_179_23 + var_179_15 > arg_176_1.duration_ then
						arg_176_1.duration_ = var_179_23 + var_179_15
					end

					if var_179_18.prefab_name ~= "" and arg_176_1.actors_[var_179_18.prefab_name] ~= nil then
						local var_179_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_176_1.actors_[var_179_18.prefab_name].transform, "story_v_out_325621", "325621043", "story_v_out_325621.awb")

						arg_176_1:RecordAudio("325621043", var_179_24)
						arg_176_1:RecordAudio("325621043", var_179_24)
					else
						arg_176_1:AudioAction("play", "voice", "story_v_out_325621", "325621043", "story_v_out_325621.awb")
					end

					arg_176_1:RecordHistoryTalkVoice("story_v_out_325621", "325621043", "story_v_out_325621.awb")
				end

				arg_176_1:RecordContent(arg_176_1.text_.text)
			end

			local var_179_25 = math.max(var_179_16, arg_176_1.talkMaxDuration)

			if var_179_15 <= arg_176_1.time_ and arg_176_1.time_ < var_179_15 + var_179_25 then
				arg_176_1.typewritter.percent = (arg_176_1.time_ - var_179_15) / var_179_25

				arg_176_1.typewritter:SetDirty()
			end

			if arg_176_1.time_ >= var_179_15 + var_179_25 and arg_176_1.time_ < var_179_15 + var_179_25 + arg_179_0 then
				arg_176_1.typewritter.percent = 1

				arg_176_1.typewritter:SetDirty()
				arg_176_1:ShowNextGo(true)
			end
		end

		arg_176_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10167ui_story",
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
	Play325621044 = function(arg_180_0, arg_180_1)
		arg_180_1.time_ = 0
		arg_180_1.frameCnt_ = 0
		arg_180_1.state_ = "playing"
		arg_180_1.curTalkId_ = 325621044
		arg_180_1.duration_ = 14.13

		local var_180_0 = {
			zh = 13.533,
			ja = 14.133
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
				arg_180_0:Play325621045(arg_180_1)
			end
		end

		function arg_180_1.onSingleLineUpdate_(arg_183_0)
			local var_183_0 = 0

			if var_183_0 < arg_180_1.time_ and arg_180_1.time_ <= var_183_0 + arg_183_0 then
				arg_180_1:PlayTimeline("10167ui_story", "StoryTimeline/CharAction/story10166/story10166action/10166action16_2")
			end

			local var_183_1 = 0
			local var_183_2 = 1.1

			if var_183_1 < arg_180_1.time_ and arg_180_1.time_ <= var_183_1 + arg_183_0 then
				arg_180_1.talkMaxDuration = 0
				arg_180_1.dialogCg_.alpha = 1

				arg_180_1.dialog_:SetActive(true)
				SetActive(arg_180_1.leftNameGo_, true)

				local var_183_3 = arg_180_1:FormatText(StoryNameCfg[1447].name)

				arg_180_1.leftNameTxt_.text = var_183_3

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_180_1.leftNameTxt_.transform)

				arg_180_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_180_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_180_1:RecordName(arg_180_1.leftNameTxt_.text)
				SetActive(arg_180_1.iconTrs_.gameObject, false)
				arg_180_1.callingController_:SetSelectedState("normal")

				local var_183_4 = arg_180_1:GetWordFromCfg(325621044)
				local var_183_5 = arg_180_1:FormatText(var_183_4.content)

				arg_180_1.text_.text = var_183_5

				LuaForUtil.ClearLinePrefixSymbol(arg_180_1.text_)

				local var_183_6 = 44
				local var_183_7 = utf8.len(var_183_5)
				local var_183_8 = var_183_6 <= 0 and var_183_2 or var_183_2 * (var_183_7 / var_183_6)

				if var_183_8 > 0 and var_183_2 < var_183_8 then
					arg_180_1.talkMaxDuration = var_183_8

					if var_183_8 + var_183_1 > arg_180_1.duration_ then
						arg_180_1.duration_ = var_183_8 + var_183_1
					end
				end

				arg_180_1.text_.text = var_183_5
				arg_180_1.typewritter.percent = 0

				arg_180_1.typewritter:SetDirty()
				arg_180_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_325621", "325621044", "story_v_out_325621.awb") ~= 0 then
					local var_183_9 = manager.audio:GetVoiceLength("story_v_out_325621", "325621044", "story_v_out_325621.awb") / 1000

					if var_183_9 + var_183_1 > arg_180_1.duration_ then
						arg_180_1.duration_ = var_183_9 + var_183_1
					end

					if var_183_4.prefab_name ~= "" and arg_180_1.actors_[var_183_4.prefab_name] ~= nil then
						local var_183_10 = LuaForUtil.PlayVoiceWithCriLipsync(arg_180_1.actors_[var_183_4.prefab_name].transform, "story_v_out_325621", "325621044", "story_v_out_325621.awb")

						arg_180_1:RecordAudio("325621044", var_183_10)
						arg_180_1:RecordAudio("325621044", var_183_10)
					else
						arg_180_1:AudioAction("play", "voice", "story_v_out_325621", "325621044", "story_v_out_325621.awb")
					end

					arg_180_1:RecordHistoryTalkVoice("story_v_out_325621", "325621044", "story_v_out_325621.awb")
				end

				arg_180_1:RecordContent(arg_180_1.text_.text)
			end

			local var_183_11 = math.max(var_183_2, arg_180_1.talkMaxDuration)

			if var_183_1 <= arg_180_1.time_ and arg_180_1.time_ < var_183_1 + var_183_11 then
				arg_180_1.typewritter.percent = (arg_180_1.time_ - var_183_1) / var_183_11

				arg_180_1.typewritter:SetDirty()
			end

			if arg_180_1.time_ >= var_183_1 + var_183_11 and arg_180_1.time_ < var_183_1 + var_183_11 + arg_183_0 then
				arg_180_1.typewritter.percent = 1

				arg_180_1.typewritter:SetDirty()
				arg_180_1:ShowNextGo(true)
			end
		end

		arg_180_1.nodeConfigList_ = {}

		arg_180_1:InitPlayNodeList()
	end,
	Play325621045 = function(arg_184_0, arg_184_1)
		arg_184_1.time_ = 0
		arg_184_1.frameCnt_ = 0
		arg_184_1.state_ = "playing"
		arg_184_1.curTalkId_ = 325621045
		arg_184_1.duration_ = 15.3

		local var_184_0 = {
			zh = 13.333,
			ja = 15.3
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
				arg_184_0:Play325621046(arg_184_1)
			end
		end

		function arg_184_1.onSingleLineUpdate_(arg_187_0)
			local var_187_0 = 0
			local var_187_1 = 1.125

			if var_187_0 < arg_184_1.time_ and arg_184_1.time_ <= var_187_0 + arg_187_0 then
				arg_184_1.talkMaxDuration = 0
				arg_184_1.dialogCg_.alpha = 1

				arg_184_1.dialog_:SetActive(true)
				SetActive(arg_184_1.leftNameGo_, true)

				local var_187_2 = arg_184_1:FormatText(StoryNameCfg[1447].name)

				arg_184_1.leftNameTxt_.text = var_187_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_184_1.leftNameTxt_.transform)

				arg_184_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_184_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_184_1:RecordName(arg_184_1.leftNameTxt_.text)
				SetActive(arg_184_1.iconTrs_.gameObject, false)
				arg_184_1.callingController_:SetSelectedState("normal")

				local var_187_3 = arg_184_1:GetWordFromCfg(325621045)
				local var_187_4 = arg_184_1:FormatText(var_187_3.content)

				arg_184_1.text_.text = var_187_4

				LuaForUtil.ClearLinePrefixSymbol(arg_184_1.text_)

				local var_187_5 = 45
				local var_187_6 = utf8.len(var_187_4)
				local var_187_7 = var_187_5 <= 0 and var_187_1 or var_187_1 * (var_187_6 / var_187_5)

				if var_187_7 > 0 and var_187_1 < var_187_7 then
					arg_184_1.talkMaxDuration = var_187_7

					if var_187_7 + var_187_0 > arg_184_1.duration_ then
						arg_184_1.duration_ = var_187_7 + var_187_0
					end
				end

				arg_184_1.text_.text = var_187_4
				arg_184_1.typewritter.percent = 0

				arg_184_1.typewritter:SetDirty()
				arg_184_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_325621", "325621045", "story_v_out_325621.awb") ~= 0 then
					local var_187_8 = manager.audio:GetVoiceLength("story_v_out_325621", "325621045", "story_v_out_325621.awb") / 1000

					if var_187_8 + var_187_0 > arg_184_1.duration_ then
						arg_184_1.duration_ = var_187_8 + var_187_0
					end

					if var_187_3.prefab_name ~= "" and arg_184_1.actors_[var_187_3.prefab_name] ~= nil then
						local var_187_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_184_1.actors_[var_187_3.prefab_name].transform, "story_v_out_325621", "325621045", "story_v_out_325621.awb")

						arg_184_1:RecordAudio("325621045", var_187_9)
						arg_184_1:RecordAudio("325621045", var_187_9)
					else
						arg_184_1:AudioAction("play", "voice", "story_v_out_325621", "325621045", "story_v_out_325621.awb")
					end

					arg_184_1:RecordHistoryTalkVoice("story_v_out_325621", "325621045", "story_v_out_325621.awb")
				end

				arg_184_1:RecordContent(arg_184_1.text_.text)
			end

			local var_187_10 = math.max(var_187_1, arg_184_1.talkMaxDuration)

			if var_187_0 <= arg_184_1.time_ and arg_184_1.time_ < var_187_0 + var_187_10 then
				arg_184_1.typewritter.percent = (arg_184_1.time_ - var_187_0) / var_187_10

				arg_184_1.typewritter:SetDirty()
			end

			if arg_184_1.time_ >= var_187_0 + var_187_10 and arg_184_1.time_ < var_187_0 + var_187_10 + arg_187_0 then
				arg_184_1.typewritter.percent = 1

				arg_184_1.typewritter:SetDirty()
				arg_184_1:ShowNextGo(true)
			end
		end

		arg_184_1.nodeConfigList_ = {}

		arg_184_1:InitPlayNodeList()
	end,
	Play325621046 = function(arg_188_0, arg_188_1)
		arg_188_1.time_ = 0
		arg_188_1.frameCnt_ = 0
		arg_188_1.state_ = "playing"
		arg_188_1.curTalkId_ = 325621046
		arg_188_1.duration_ = 12.03

		local var_188_0 = {
			zh = 11.3,
			ja = 12.033
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
				arg_188_0:Play325621047(arg_188_1)
			end
		end

		function arg_188_1.onSingleLineUpdate_(arg_191_0)
			local var_191_0 = 0

			if var_191_0 < arg_188_1.time_ and arg_188_1.time_ <= var_191_0 + arg_191_0 then
				arg_188_1:PlayTimeline("10167ui_story", "StoryTimeline/CharAction/public_expression/expr_haixiuA", "EmotionTimelineAnimator")
			end

			local var_191_1 = 0
			local var_191_2 = 0.875

			if var_191_1 < arg_188_1.time_ and arg_188_1.time_ <= var_191_1 + arg_191_0 then
				arg_188_1.talkMaxDuration = 0
				arg_188_1.dialogCg_.alpha = 1

				arg_188_1.dialog_:SetActive(true)
				SetActive(arg_188_1.leftNameGo_, true)

				local var_191_3 = arg_188_1:FormatText(StoryNameCfg[1447].name)

				arg_188_1.leftNameTxt_.text = var_191_3

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_188_1.leftNameTxt_.transform)

				arg_188_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_188_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_188_1:RecordName(arg_188_1.leftNameTxt_.text)
				SetActive(arg_188_1.iconTrs_.gameObject, false)
				arg_188_1.callingController_:SetSelectedState("normal")

				local var_191_4 = arg_188_1:GetWordFromCfg(325621046)
				local var_191_5 = arg_188_1:FormatText(var_191_4.content)

				arg_188_1.text_.text = var_191_5

				LuaForUtil.ClearLinePrefixSymbol(arg_188_1.text_)

				local var_191_6 = 36
				local var_191_7 = utf8.len(var_191_5)
				local var_191_8 = var_191_6 <= 0 and var_191_2 or var_191_2 * (var_191_7 / var_191_6)

				if var_191_8 > 0 and var_191_2 < var_191_8 then
					arg_188_1.talkMaxDuration = var_191_8

					if var_191_8 + var_191_1 > arg_188_1.duration_ then
						arg_188_1.duration_ = var_191_8 + var_191_1
					end
				end

				arg_188_1.text_.text = var_191_5
				arg_188_1.typewritter.percent = 0

				arg_188_1.typewritter:SetDirty()
				arg_188_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_325621", "325621046", "story_v_out_325621.awb") ~= 0 then
					local var_191_9 = manager.audio:GetVoiceLength("story_v_out_325621", "325621046", "story_v_out_325621.awb") / 1000

					if var_191_9 + var_191_1 > arg_188_1.duration_ then
						arg_188_1.duration_ = var_191_9 + var_191_1
					end

					if var_191_4.prefab_name ~= "" and arg_188_1.actors_[var_191_4.prefab_name] ~= nil then
						local var_191_10 = LuaForUtil.PlayVoiceWithCriLipsync(arg_188_1.actors_[var_191_4.prefab_name].transform, "story_v_out_325621", "325621046", "story_v_out_325621.awb")

						arg_188_1:RecordAudio("325621046", var_191_10)
						arg_188_1:RecordAudio("325621046", var_191_10)
					else
						arg_188_1:AudioAction("play", "voice", "story_v_out_325621", "325621046", "story_v_out_325621.awb")
					end

					arg_188_1:RecordHistoryTalkVoice("story_v_out_325621", "325621046", "story_v_out_325621.awb")
				end

				arg_188_1:RecordContent(arg_188_1.text_.text)
			end

			local var_191_11 = math.max(var_191_2, arg_188_1.talkMaxDuration)

			if var_191_1 <= arg_188_1.time_ and arg_188_1.time_ < var_191_1 + var_191_11 then
				arg_188_1.typewritter.percent = (arg_188_1.time_ - var_191_1) / var_191_11

				arg_188_1.typewritter:SetDirty()
			end

			if arg_188_1.time_ >= var_191_1 + var_191_11 and arg_188_1.time_ < var_191_1 + var_191_11 + arg_191_0 then
				arg_188_1.typewritter.percent = 1

				arg_188_1.typewritter:SetDirty()
				arg_188_1:ShowNextGo(true)
			end
		end

		arg_188_1.nodeConfigList_ = {}

		arg_188_1:InitPlayNodeList()
	end,
	Play325621047 = function(arg_192_0, arg_192_1)
		arg_192_1.time_ = 0
		arg_192_1.frameCnt_ = 0
		arg_192_1.state_ = "playing"
		arg_192_1.curTalkId_ = 325621047
		arg_192_1.duration_ = 15.07

		local var_192_0 = {
			zh = 14.933,
			ja = 15.066
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
				arg_192_0:Play325621048(arg_192_1)
			end
		end

		function arg_192_1.onSingleLineUpdate_(arg_195_0)
			local var_195_0 = 0
			local var_195_1 = 1.075

			if var_195_0 < arg_192_1.time_ and arg_192_1.time_ <= var_195_0 + arg_195_0 then
				arg_192_1.talkMaxDuration = 0
				arg_192_1.dialogCg_.alpha = 1

				arg_192_1.dialog_:SetActive(true)
				SetActive(arg_192_1.leftNameGo_, true)

				local var_195_2 = arg_192_1:FormatText(StoryNameCfg[1447].name)

				arg_192_1.leftNameTxt_.text = var_195_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_192_1.leftNameTxt_.transform)

				arg_192_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_192_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_192_1:RecordName(arg_192_1.leftNameTxt_.text)
				SetActive(arg_192_1.iconTrs_.gameObject, false)
				arg_192_1.callingController_:SetSelectedState("normal")

				local var_195_3 = arg_192_1:GetWordFromCfg(325621047)
				local var_195_4 = arg_192_1:FormatText(var_195_3.content)

				arg_192_1.text_.text = var_195_4

				LuaForUtil.ClearLinePrefixSymbol(arg_192_1.text_)

				local var_195_5 = 43
				local var_195_6 = utf8.len(var_195_4)
				local var_195_7 = var_195_5 <= 0 and var_195_1 or var_195_1 * (var_195_6 / var_195_5)

				if var_195_7 > 0 and var_195_1 < var_195_7 then
					arg_192_1.talkMaxDuration = var_195_7

					if var_195_7 + var_195_0 > arg_192_1.duration_ then
						arg_192_1.duration_ = var_195_7 + var_195_0
					end
				end

				arg_192_1.text_.text = var_195_4
				arg_192_1.typewritter.percent = 0

				arg_192_1.typewritter:SetDirty()
				arg_192_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_325621", "325621047", "story_v_out_325621.awb") ~= 0 then
					local var_195_8 = manager.audio:GetVoiceLength("story_v_out_325621", "325621047", "story_v_out_325621.awb") / 1000

					if var_195_8 + var_195_0 > arg_192_1.duration_ then
						arg_192_1.duration_ = var_195_8 + var_195_0
					end

					if var_195_3.prefab_name ~= "" and arg_192_1.actors_[var_195_3.prefab_name] ~= nil then
						local var_195_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_192_1.actors_[var_195_3.prefab_name].transform, "story_v_out_325621", "325621047", "story_v_out_325621.awb")

						arg_192_1:RecordAudio("325621047", var_195_9)
						arg_192_1:RecordAudio("325621047", var_195_9)
					else
						arg_192_1:AudioAction("play", "voice", "story_v_out_325621", "325621047", "story_v_out_325621.awb")
					end

					arg_192_1:RecordHistoryTalkVoice("story_v_out_325621", "325621047", "story_v_out_325621.awb")
				end

				arg_192_1:RecordContent(arg_192_1.text_.text)
			end

			local var_195_10 = math.max(var_195_1, arg_192_1.talkMaxDuration)

			if var_195_0 <= arg_192_1.time_ and arg_192_1.time_ < var_195_0 + var_195_10 then
				arg_192_1.typewritter.percent = (arg_192_1.time_ - var_195_0) / var_195_10

				arg_192_1.typewritter:SetDirty()
			end

			if arg_192_1.time_ >= var_195_0 + var_195_10 and arg_192_1.time_ < var_195_0 + var_195_10 + arg_195_0 then
				arg_192_1.typewritter.percent = 1

				arg_192_1.typewritter:SetDirty()
				arg_192_1:ShowNextGo(true)
			end
		end

		arg_192_1.nodeConfigList_ = {}

		arg_192_1:InitPlayNodeList()
	end,
	Play325621048 = function(arg_196_0, arg_196_1)
		arg_196_1.time_ = 0
		arg_196_1.frameCnt_ = 0
		arg_196_1.state_ = "playing"
		arg_196_1.curTalkId_ = 325621048
		arg_196_1.duration_ = 7.03

		local var_196_0 = {
			zh = 5.833,
			ja = 7.033
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
				arg_196_0:Play325621049(arg_196_1)
			end
		end

		function arg_196_1.onSingleLineUpdate_(arg_199_0)
			local var_199_0 = 0
			local var_199_1 = 0.375

			if var_199_0 < arg_196_1.time_ and arg_196_1.time_ <= var_199_0 + arg_199_0 then
				arg_196_1.talkMaxDuration = 0
				arg_196_1.dialogCg_.alpha = 1

				arg_196_1.dialog_:SetActive(true)
				SetActive(arg_196_1.leftNameGo_, true)

				local var_199_2 = arg_196_1:FormatText(StoryNameCfg[1447].name)

				arg_196_1.leftNameTxt_.text = var_199_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_196_1.leftNameTxt_.transform)

				arg_196_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_196_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_196_1:RecordName(arg_196_1.leftNameTxt_.text)
				SetActive(arg_196_1.iconTrs_.gameObject, false)
				arg_196_1.callingController_:SetSelectedState("normal")

				local var_199_3 = arg_196_1:GetWordFromCfg(325621048)
				local var_199_4 = arg_196_1:FormatText(var_199_3.content)

				arg_196_1.text_.text = var_199_4

				LuaForUtil.ClearLinePrefixSymbol(arg_196_1.text_)

				local var_199_5 = 15
				local var_199_6 = utf8.len(var_199_4)
				local var_199_7 = var_199_5 <= 0 and var_199_1 or var_199_1 * (var_199_6 / var_199_5)

				if var_199_7 > 0 and var_199_1 < var_199_7 then
					arg_196_1.talkMaxDuration = var_199_7

					if var_199_7 + var_199_0 > arg_196_1.duration_ then
						arg_196_1.duration_ = var_199_7 + var_199_0
					end
				end

				arg_196_1.text_.text = var_199_4
				arg_196_1.typewritter.percent = 0

				arg_196_1.typewritter:SetDirty()
				arg_196_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_325621", "325621048", "story_v_out_325621.awb") ~= 0 then
					local var_199_8 = manager.audio:GetVoiceLength("story_v_out_325621", "325621048", "story_v_out_325621.awb") / 1000

					if var_199_8 + var_199_0 > arg_196_1.duration_ then
						arg_196_1.duration_ = var_199_8 + var_199_0
					end

					if var_199_3.prefab_name ~= "" and arg_196_1.actors_[var_199_3.prefab_name] ~= nil then
						local var_199_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_196_1.actors_[var_199_3.prefab_name].transform, "story_v_out_325621", "325621048", "story_v_out_325621.awb")

						arg_196_1:RecordAudio("325621048", var_199_9)
						arg_196_1:RecordAudio("325621048", var_199_9)
					else
						arg_196_1:AudioAction("play", "voice", "story_v_out_325621", "325621048", "story_v_out_325621.awb")
					end

					arg_196_1:RecordHistoryTalkVoice("story_v_out_325621", "325621048", "story_v_out_325621.awb")
				end

				arg_196_1:RecordContent(arg_196_1.text_.text)
			end

			local var_199_10 = math.max(var_199_1, arg_196_1.talkMaxDuration)

			if var_199_0 <= arg_196_1.time_ and arg_196_1.time_ < var_199_0 + var_199_10 then
				arg_196_1.typewritter.percent = (arg_196_1.time_ - var_199_0) / var_199_10

				arg_196_1.typewritter:SetDirty()
			end

			if arg_196_1.time_ >= var_199_0 + var_199_10 and arg_196_1.time_ < var_199_0 + var_199_10 + arg_199_0 then
				arg_196_1.typewritter.percent = 1

				arg_196_1.typewritter:SetDirty()
				arg_196_1:ShowNextGo(true)
			end
		end

		arg_196_1.nodeConfigList_ = {}

		arg_196_1:InitPlayNodeList()
	end,
	Play325621049 = function(arg_200_0, arg_200_1)
		arg_200_1.time_ = 0
		arg_200_1.frameCnt_ = 0
		arg_200_1.state_ = "playing"
		arg_200_1.curTalkId_ = 325621049
		arg_200_1.duration_ = 5.83

		SetActive(arg_200_1.tipsGo_, false)

		function arg_200_1.onSingleLineFinish_()
			arg_200_1.onSingleLineUpdate_ = nil
			arg_200_1.onSingleLineFinish_ = nil
			arg_200_1.state_ = "waiting"
		end

		function arg_200_1.playNext_(arg_202_0)
			if arg_202_0 == 1 then
				arg_200_0:Play325621050(arg_200_1)
			end
		end

		function arg_200_1.onSingleLineUpdate_(arg_203_0)
			local var_203_0 = arg_200_1.actors_["10167ui_story"].transform
			local var_203_1 = 0

			if var_203_1 < arg_200_1.time_ and arg_200_1.time_ <= var_203_1 + arg_203_0 then
				arg_200_1.var_.moveOldPos10167ui_story = var_203_0.localPosition

				local var_203_2 = GameObjectTools.GetOrAddComponent(var_203_0.gameObject, typeof(DynamicBoneHelper))

				if var_203_2 then
					var_203_2:EnableDynamicBone(false)
				end
			end

			local var_203_3 = 0.001

			if var_203_1 <= arg_200_1.time_ and arg_200_1.time_ < var_203_1 + var_203_3 then
				local var_203_4 = (arg_200_1.time_ - var_203_1) / var_203_3
				local var_203_5 = Vector3.New(0, 100, 0)

				var_203_0.localPosition = Vector3.Lerp(arg_200_1.var_.moveOldPos10167ui_story, var_203_5, var_203_4)

				local var_203_6 = manager.ui.mainCamera.transform.position - var_203_0.position

				var_203_0.forward = Vector3.New(var_203_6.x, var_203_6.y, var_203_6.z)

				local var_203_7 = var_203_0.localEulerAngles

				var_203_7.z = 0
				var_203_7.x = 0
				var_203_0.localEulerAngles = var_203_7
			end

			if arg_200_1.time_ >= var_203_1 + var_203_3 and arg_200_1.time_ < var_203_1 + var_203_3 + arg_203_0 then
				var_203_0.localPosition = Vector3.New(0, 100, 0)

				local var_203_8 = manager.ui.mainCamera.transform.position - var_203_0.position

				var_203_0.forward = Vector3.New(var_203_8.x, var_203_8.y, var_203_8.z)

				local var_203_9 = var_203_0.localEulerAngles

				var_203_9.z = 0
				var_203_9.x = 0
				var_203_0.localEulerAngles = var_203_9

				local var_203_10 = GameObjectTools.GetOrAddComponent(var_203_0.gameObject, typeof(DynamicBoneHelper))

				if var_203_10 then
					var_203_10:EnableDynamicBone(true)
				end
			end

			local var_203_11 = arg_200_1.actors_["10167ui_story"]
			local var_203_12 = 0

			if var_203_12 < arg_200_1.time_ and arg_200_1.time_ <= var_203_12 + arg_203_0 and not isNil(var_203_11) and arg_200_1.var_.characterEffect10167ui_story == nil then
				arg_200_1.var_.characterEffect10167ui_story = var_203_11:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_203_13 = 0.200000002980232

			if var_203_12 <= arg_200_1.time_ and arg_200_1.time_ < var_203_12 + var_203_13 and not isNil(var_203_11) then
				local var_203_14 = (arg_200_1.time_ - var_203_12) / var_203_13

				if arg_200_1.var_.characterEffect10167ui_story and not isNil(var_203_11) then
					local var_203_15 = Mathf.Lerp(0, 0.5, var_203_14)

					arg_200_1.var_.characterEffect10167ui_story.fillFlat = true
					arg_200_1.var_.characterEffect10167ui_story.fillRatio = var_203_15
				end
			end

			if arg_200_1.time_ >= var_203_12 + var_203_13 and arg_200_1.time_ < var_203_12 + var_203_13 + arg_203_0 and not isNil(var_203_11) and arg_200_1.var_.characterEffect10167ui_story then
				local var_203_16 = 0.5

				arg_200_1.var_.characterEffect10167ui_story.fillFlat = true
				arg_200_1.var_.characterEffect10167ui_story.fillRatio = var_203_16
			end

			local var_203_17 = manager.ui.mainCamera.transform
			local var_203_18 = 0

			if var_203_18 < arg_200_1.time_ and arg_200_1.time_ <= var_203_18 + arg_203_0 then
				local var_203_19 = arg_200_1.var_.effect42432
				local var_203_20
				local var_203_21 = var_203_17

				if not var_203_19 then
					var_203_19 = Object.Instantiate(Asset.Load("Effect/Scene/fx_uistory_qiliu_in_keep"), var_203_21)
					var_203_19.name = "42432"
					arg_200_1.var_.effect42432 = var_203_19
				else
					var_203_19.transform:SetParent(var_203_21)
				end

				var_203_19.transform.localPosition = Vector3.New(0, 0, 0)
				var_203_19.transform.localRotation = Quaternion.Euler(0, 0, 0)
			end

			local var_203_22 = 0

			if var_203_22 < arg_200_1.time_ and arg_200_1.time_ <= var_203_22 + arg_203_0 then
				arg_200_1.allBtn_.enabled = false
			end

			local var_203_23 = 1

			if arg_200_1.time_ >= var_203_22 + var_203_23 and arg_200_1.time_ < var_203_22 + var_203_23 + arg_203_0 then
				arg_200_1.allBtn_.enabled = true
			end

			if arg_200_1.frameCnt_ <= 1 then
				arg_200_1.dialog_:SetActive(false)
			end

			local var_203_24 = 0.833333333333333
			local var_203_25 = 1.35

			if var_203_24 < arg_200_1.time_ and arg_200_1.time_ <= var_203_24 + arg_203_0 then
				arg_200_1.talkMaxDuration = 0

				arg_200_1.dialog_:SetActive(true)

				arg_200_1.dialogCg_.alpha = 0

				local var_203_26 = LeanTween.value(arg_200_1.dialog_, 0, 1, 0.3)

				var_203_26:setOnUpdate(LuaHelper.FloatAction(function(arg_204_0)
					arg_200_1.dialogCg_.alpha = arg_204_0
				end))
				var_203_26:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_200_1.dialog_)
					var_203_26:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_200_1.duration_ = arg_200_1.duration_ + 0.3

				SetActive(arg_200_1.leftNameGo_, false)

				arg_200_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_200_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_200_1:RecordName(arg_200_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_200_1.iconTrs_.gameObject, false)
				arg_200_1.callingController_:SetSelectedState("normal")

				local var_203_27 = arg_200_1:GetWordFromCfg(325621049)
				local var_203_28 = arg_200_1:FormatText(var_203_27.content)

				arg_200_1.text_.text = var_203_28

				LuaForUtil.ClearLinePrefixSymbol(arg_200_1.text_)

				local var_203_29 = 54
				local var_203_30 = utf8.len(var_203_28)
				local var_203_31 = var_203_29 <= 0 and var_203_25 or var_203_25 * (var_203_30 / var_203_29)

				if var_203_31 > 0 and var_203_25 < var_203_31 then
					arg_200_1.talkMaxDuration = var_203_31
					var_203_24 = var_203_24 + 0.3

					if var_203_31 + var_203_24 > arg_200_1.duration_ then
						arg_200_1.duration_ = var_203_31 + var_203_24
					end
				end

				arg_200_1.text_.text = var_203_28
				arg_200_1.typewritter.percent = 0

				arg_200_1.typewritter:SetDirty()
				arg_200_1:ShowNextGo(false)
				arg_200_1:RecordContent(arg_200_1.text_.text)
			end

			local var_203_32 = var_203_24 + 0.3
			local var_203_33 = math.max(var_203_25, arg_200_1.talkMaxDuration)

			if var_203_32 <= arg_200_1.time_ and arg_200_1.time_ < var_203_32 + var_203_33 then
				arg_200_1.typewritter.percent = (arg_200_1.time_ - var_203_32) / var_203_33

				arg_200_1.typewritter:SetDirty()
			end

			if arg_200_1.time_ >= var_203_32 + var_203_33 and arg_200_1.time_ < var_203_32 + var_203_33 + arg_203_0 then
				arg_200_1.typewritter.percent = 1

				arg_200_1.typewritter:SetDirty()
				arg_200_1:ShowNextGo(true)
			end
		end

		arg_200_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10167ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_200_1:InitPlayNodeList()
	end,
	Play325621050 = function(arg_206_0, arg_206_1)
		arg_206_1.time_ = 0
		arg_206_1.frameCnt_ = 0
		arg_206_1.state_ = "playing"
		arg_206_1.curTalkId_ = 325621050
		arg_206_1.duration_ = 18.7

		local var_206_0 = {
			zh = 17,
			ja = 18.7
		}
		local var_206_1 = manager.audio:GetLocalizationFlag()

		if var_206_0[var_206_1] ~= nil then
			arg_206_1.duration_ = var_206_0[var_206_1]
		end

		SetActive(arg_206_1.tipsGo_, false)

		function arg_206_1.onSingleLineFinish_()
			arg_206_1.onSingleLineUpdate_ = nil
			arg_206_1.onSingleLineFinish_ = nil
			arg_206_1.state_ = "waiting"
		end

		function arg_206_1.playNext_(arg_208_0)
			if arg_208_0 == 1 then
				arg_206_0:Play325621051(arg_206_1)
			end
		end

		function arg_206_1.onSingleLineUpdate_(arg_209_0)
			local var_209_0 = arg_206_1.actors_["10167ui_story"].transform
			local var_209_1 = 0

			if var_209_1 < arg_206_1.time_ and arg_206_1.time_ <= var_209_1 + arg_209_0 then
				arg_206_1.var_.moveOldPos10167ui_story = var_209_0.localPosition

				local var_209_2 = GameObjectTools.GetOrAddComponent(var_209_0.gameObject, typeof(DynamicBoneHelper))

				if var_209_2 then
					var_209_2:EnableDynamicBone(false)
				end
			end

			local var_209_3 = 0.001

			if var_209_1 <= arg_206_1.time_ and arg_206_1.time_ < var_209_1 + var_209_3 then
				local var_209_4 = (arg_206_1.time_ - var_209_1) / var_209_3
				local var_209_5 = Vector3.New(0, -1.28, -5.73)

				var_209_0.localPosition = Vector3.Lerp(arg_206_1.var_.moveOldPos10167ui_story, var_209_5, var_209_4)

				local var_209_6 = manager.ui.mainCamera.transform.position - var_209_0.position

				var_209_0.forward = Vector3.New(var_209_6.x, var_209_6.y, var_209_6.z)

				local var_209_7 = var_209_0.localEulerAngles

				var_209_7.z = 0
				var_209_7.x = 0
				var_209_0.localEulerAngles = var_209_7
			end

			if arg_206_1.time_ >= var_209_1 + var_209_3 and arg_206_1.time_ < var_209_1 + var_209_3 + arg_209_0 then
				var_209_0.localPosition = Vector3.New(0, -1.28, -5.73)

				local var_209_8 = manager.ui.mainCamera.transform.position - var_209_0.position

				var_209_0.forward = Vector3.New(var_209_8.x, var_209_8.y, var_209_8.z)

				local var_209_9 = var_209_0.localEulerAngles

				var_209_9.z = 0
				var_209_9.x = 0
				var_209_0.localEulerAngles = var_209_9

				local var_209_10 = GameObjectTools.GetOrAddComponent(var_209_0.gameObject, typeof(DynamicBoneHelper))

				if var_209_10 then
					var_209_10:EnableDynamicBone(true)
				end
			end

			local var_209_11 = arg_206_1.actors_["10167ui_story"]
			local var_209_12 = 0

			if var_209_12 < arg_206_1.time_ and arg_206_1.time_ <= var_209_12 + arg_209_0 and not isNil(var_209_11) and arg_206_1.var_.characterEffect10167ui_story == nil then
				arg_206_1.var_.characterEffect10167ui_story = var_209_11:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_209_13 = 0.200000002980232

			if var_209_12 <= arg_206_1.time_ and arg_206_1.time_ < var_209_12 + var_209_13 and not isNil(var_209_11) then
				local var_209_14 = (arg_206_1.time_ - var_209_12) / var_209_13

				if arg_206_1.var_.characterEffect10167ui_story and not isNil(var_209_11) then
					arg_206_1.var_.characterEffect10167ui_story.fillFlat = false
				end
			end

			if arg_206_1.time_ >= var_209_12 + var_209_13 and arg_206_1.time_ < var_209_12 + var_209_13 + arg_209_0 and not isNil(var_209_11) and arg_206_1.var_.characterEffect10167ui_story then
				arg_206_1.var_.characterEffect10167ui_story.fillFlat = false
			end

			local var_209_15 = 0
			local var_209_16 = 1.275

			if var_209_15 < arg_206_1.time_ and arg_206_1.time_ <= var_209_15 + arg_209_0 then
				arg_206_1.talkMaxDuration = 0
				arg_206_1.dialogCg_.alpha = 1

				arg_206_1.dialog_:SetActive(true)
				SetActive(arg_206_1.leftNameGo_, true)

				local var_209_17 = arg_206_1:FormatText(StoryNameCfg[1447].name)

				arg_206_1.leftNameTxt_.text = var_209_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_206_1.leftNameTxt_.transform)

				arg_206_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_206_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_206_1:RecordName(arg_206_1.leftNameTxt_.text)
				SetActive(arg_206_1.iconTrs_.gameObject, false)
				arg_206_1.callingController_:SetSelectedState("normal")

				local var_209_18 = arg_206_1:GetWordFromCfg(325621050)
				local var_209_19 = arg_206_1:FormatText(var_209_18.content)

				arg_206_1.text_.text = var_209_19

				LuaForUtil.ClearLinePrefixSymbol(arg_206_1.text_)

				local var_209_20 = 51
				local var_209_21 = utf8.len(var_209_19)
				local var_209_22 = var_209_20 <= 0 and var_209_16 or var_209_16 * (var_209_21 / var_209_20)

				if var_209_22 > 0 and var_209_16 < var_209_22 then
					arg_206_1.talkMaxDuration = var_209_22

					if var_209_22 + var_209_15 > arg_206_1.duration_ then
						arg_206_1.duration_ = var_209_22 + var_209_15
					end
				end

				arg_206_1.text_.text = var_209_19
				arg_206_1.typewritter.percent = 0

				arg_206_1.typewritter:SetDirty()
				arg_206_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_325621", "325621050", "story_v_out_325621.awb") ~= 0 then
					local var_209_23 = manager.audio:GetVoiceLength("story_v_out_325621", "325621050", "story_v_out_325621.awb") / 1000

					if var_209_23 + var_209_15 > arg_206_1.duration_ then
						arg_206_1.duration_ = var_209_23 + var_209_15
					end

					if var_209_18.prefab_name ~= "" and arg_206_1.actors_[var_209_18.prefab_name] ~= nil then
						local var_209_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_206_1.actors_[var_209_18.prefab_name].transform, "story_v_out_325621", "325621050", "story_v_out_325621.awb")

						arg_206_1:RecordAudio("325621050", var_209_24)
						arg_206_1:RecordAudio("325621050", var_209_24)
					else
						arg_206_1:AudioAction("play", "voice", "story_v_out_325621", "325621050", "story_v_out_325621.awb")
					end

					arg_206_1:RecordHistoryTalkVoice("story_v_out_325621", "325621050", "story_v_out_325621.awb")
				end

				arg_206_1:RecordContent(arg_206_1.text_.text)
			end

			local var_209_25 = math.max(var_209_16, arg_206_1.talkMaxDuration)

			if var_209_15 <= arg_206_1.time_ and arg_206_1.time_ < var_209_15 + var_209_25 then
				arg_206_1.typewritter.percent = (arg_206_1.time_ - var_209_15) / var_209_25

				arg_206_1.typewritter:SetDirty()
			end

			if arg_206_1.time_ >= var_209_15 + var_209_25 and arg_206_1.time_ < var_209_15 + var_209_25 + arg_209_0 then
				arg_206_1.typewritter.percent = 1

				arg_206_1.typewritter:SetDirty()
				arg_206_1:ShowNextGo(true)
			end
		end

		arg_206_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10167ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_206_1:InitPlayNodeList()
	end,
	Play325621051 = function(arg_210_0, arg_210_1)
		arg_210_1.time_ = 0
		arg_210_1.frameCnt_ = 0
		arg_210_1.state_ = "playing"
		arg_210_1.curTalkId_ = 325621051
		arg_210_1.duration_ = 14.3

		local var_210_0 = {
			zh = 12.233,
			ja = 14.3
		}
		local var_210_1 = manager.audio:GetLocalizationFlag()

		if var_210_0[var_210_1] ~= nil then
			arg_210_1.duration_ = var_210_0[var_210_1]
		end

		SetActive(arg_210_1.tipsGo_, false)

		function arg_210_1.onSingleLineFinish_()
			arg_210_1.onSingleLineUpdate_ = nil
			arg_210_1.onSingleLineFinish_ = nil
			arg_210_1.state_ = "waiting"
		end

		function arg_210_1.playNext_(arg_212_0)
			if arg_212_0 == 1 then
				arg_210_0:Play325621052(arg_210_1)
			end
		end

		function arg_210_1.onSingleLineUpdate_(arg_213_0)
			local var_213_0 = 0

			if var_213_0 < arg_210_1.time_ and arg_210_1.time_ <= var_213_0 + arg_213_0 then
				arg_210_1:PlayTimeline("10167ui_story", "StoryTimeline/CharAction/story10166/story10166action/10166action12_1")
			end

			local var_213_1 = 0
			local var_213_2 = 0.925

			if var_213_1 < arg_210_1.time_ and arg_210_1.time_ <= var_213_1 + arg_213_0 then
				arg_210_1.talkMaxDuration = 0
				arg_210_1.dialogCg_.alpha = 1

				arg_210_1.dialog_:SetActive(true)
				SetActive(arg_210_1.leftNameGo_, true)

				local var_213_3 = arg_210_1:FormatText(StoryNameCfg[1447].name)

				arg_210_1.leftNameTxt_.text = var_213_3

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_210_1.leftNameTxt_.transform)

				arg_210_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_210_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_210_1:RecordName(arg_210_1.leftNameTxt_.text)
				SetActive(arg_210_1.iconTrs_.gameObject, false)
				arg_210_1.callingController_:SetSelectedState("normal")

				local var_213_4 = arg_210_1:GetWordFromCfg(325621051)
				local var_213_5 = arg_210_1:FormatText(var_213_4.content)

				arg_210_1.text_.text = var_213_5

				LuaForUtil.ClearLinePrefixSymbol(arg_210_1.text_)

				local var_213_6 = 37
				local var_213_7 = utf8.len(var_213_5)
				local var_213_8 = var_213_6 <= 0 and var_213_2 or var_213_2 * (var_213_7 / var_213_6)

				if var_213_8 > 0 and var_213_2 < var_213_8 then
					arg_210_1.talkMaxDuration = var_213_8

					if var_213_8 + var_213_1 > arg_210_1.duration_ then
						arg_210_1.duration_ = var_213_8 + var_213_1
					end
				end

				arg_210_1.text_.text = var_213_5
				arg_210_1.typewritter.percent = 0

				arg_210_1.typewritter:SetDirty()
				arg_210_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_325621", "325621051", "story_v_out_325621.awb") ~= 0 then
					local var_213_9 = manager.audio:GetVoiceLength("story_v_out_325621", "325621051", "story_v_out_325621.awb") / 1000

					if var_213_9 + var_213_1 > arg_210_1.duration_ then
						arg_210_1.duration_ = var_213_9 + var_213_1
					end

					if var_213_4.prefab_name ~= "" and arg_210_1.actors_[var_213_4.prefab_name] ~= nil then
						local var_213_10 = LuaForUtil.PlayVoiceWithCriLipsync(arg_210_1.actors_[var_213_4.prefab_name].transform, "story_v_out_325621", "325621051", "story_v_out_325621.awb")

						arg_210_1:RecordAudio("325621051", var_213_10)
						arg_210_1:RecordAudio("325621051", var_213_10)
					else
						arg_210_1:AudioAction("play", "voice", "story_v_out_325621", "325621051", "story_v_out_325621.awb")
					end

					arg_210_1:RecordHistoryTalkVoice("story_v_out_325621", "325621051", "story_v_out_325621.awb")
				end

				arg_210_1:RecordContent(arg_210_1.text_.text)
			end

			local var_213_11 = math.max(var_213_2, arg_210_1.talkMaxDuration)

			if var_213_1 <= arg_210_1.time_ and arg_210_1.time_ < var_213_1 + var_213_11 then
				arg_210_1.typewritter.percent = (arg_210_1.time_ - var_213_1) / var_213_11

				arg_210_1.typewritter:SetDirty()
			end

			if arg_210_1.time_ >= var_213_1 + var_213_11 and arg_210_1.time_ < var_213_1 + var_213_11 + arg_213_0 then
				arg_210_1.typewritter.percent = 1

				arg_210_1.typewritter:SetDirty()
				arg_210_1:ShowNextGo(true)
			end
		end

		arg_210_1.nodeConfigList_ = {}

		arg_210_1:InitPlayNodeList()
	end,
	Play325621052 = function(arg_214_0, arg_214_1)
		arg_214_1.time_ = 0
		arg_214_1.frameCnt_ = 0
		arg_214_1.state_ = "playing"
		arg_214_1.curTalkId_ = 325621052
		arg_214_1.duration_ = 13.93

		local var_214_0 = {
			zh = 12.866,
			ja = 13.933
		}
		local var_214_1 = manager.audio:GetLocalizationFlag()

		if var_214_0[var_214_1] ~= nil then
			arg_214_1.duration_ = var_214_0[var_214_1]
		end

		SetActive(arg_214_1.tipsGo_, false)

		function arg_214_1.onSingleLineFinish_()
			arg_214_1.onSingleLineUpdate_ = nil
			arg_214_1.onSingleLineFinish_ = nil
			arg_214_1.state_ = "waiting"
		end

		function arg_214_1.playNext_(arg_216_0)
			if arg_216_0 == 1 then
				arg_214_0:Play325621053(arg_214_1)
			end
		end

		function arg_214_1.onSingleLineUpdate_(arg_217_0)
			local var_217_0 = 0
			local var_217_1 = 1

			if var_217_0 < arg_214_1.time_ and arg_214_1.time_ <= var_217_0 + arg_217_0 then
				arg_214_1.talkMaxDuration = 0
				arg_214_1.dialogCg_.alpha = 1

				arg_214_1.dialog_:SetActive(true)
				SetActive(arg_214_1.leftNameGo_, true)

				local var_217_2 = arg_214_1:FormatText(StoryNameCfg[1447].name)

				arg_214_1.leftNameTxt_.text = var_217_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_214_1.leftNameTxt_.transform)

				arg_214_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_214_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_214_1:RecordName(arg_214_1.leftNameTxt_.text)
				SetActive(arg_214_1.iconTrs_.gameObject, false)
				arg_214_1.callingController_:SetSelectedState("normal")

				local var_217_3 = arg_214_1:GetWordFromCfg(325621052)
				local var_217_4 = arg_214_1:FormatText(var_217_3.content)

				arg_214_1.text_.text = var_217_4

				LuaForUtil.ClearLinePrefixSymbol(arg_214_1.text_)

				local var_217_5 = 40
				local var_217_6 = utf8.len(var_217_4)
				local var_217_7 = var_217_5 <= 0 and var_217_1 or var_217_1 * (var_217_6 / var_217_5)

				if var_217_7 > 0 and var_217_1 < var_217_7 then
					arg_214_1.talkMaxDuration = var_217_7

					if var_217_7 + var_217_0 > arg_214_1.duration_ then
						arg_214_1.duration_ = var_217_7 + var_217_0
					end
				end

				arg_214_1.text_.text = var_217_4
				arg_214_1.typewritter.percent = 0

				arg_214_1.typewritter:SetDirty()
				arg_214_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_325621", "325621052", "story_v_out_325621.awb") ~= 0 then
					local var_217_8 = manager.audio:GetVoiceLength("story_v_out_325621", "325621052", "story_v_out_325621.awb") / 1000

					if var_217_8 + var_217_0 > arg_214_1.duration_ then
						arg_214_1.duration_ = var_217_8 + var_217_0
					end

					if var_217_3.prefab_name ~= "" and arg_214_1.actors_[var_217_3.prefab_name] ~= nil then
						local var_217_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_214_1.actors_[var_217_3.prefab_name].transform, "story_v_out_325621", "325621052", "story_v_out_325621.awb")

						arg_214_1:RecordAudio("325621052", var_217_9)
						arg_214_1:RecordAudio("325621052", var_217_9)
					else
						arg_214_1:AudioAction("play", "voice", "story_v_out_325621", "325621052", "story_v_out_325621.awb")
					end

					arg_214_1:RecordHistoryTalkVoice("story_v_out_325621", "325621052", "story_v_out_325621.awb")
				end

				arg_214_1:RecordContent(arg_214_1.text_.text)
			end

			local var_217_10 = math.max(var_217_1, arg_214_1.talkMaxDuration)

			if var_217_0 <= arg_214_1.time_ and arg_214_1.time_ < var_217_0 + var_217_10 then
				arg_214_1.typewritter.percent = (arg_214_1.time_ - var_217_0) / var_217_10

				arg_214_1.typewritter:SetDirty()
			end

			if arg_214_1.time_ >= var_217_0 + var_217_10 and arg_214_1.time_ < var_217_0 + var_217_10 + arg_217_0 then
				arg_214_1.typewritter.percent = 1

				arg_214_1.typewritter:SetDirty()
				arg_214_1:ShowNextGo(true)
			end
		end

		arg_214_1.nodeConfigList_ = {}

		arg_214_1:InitPlayNodeList()
	end,
	Play325621053 = function(arg_218_0, arg_218_1)
		arg_218_1.time_ = 0
		arg_218_1.frameCnt_ = 0
		arg_218_1.state_ = "playing"
		arg_218_1.curTalkId_ = 325621053
		arg_218_1.duration_ = 9.5

		local var_218_0 = {
			zh = 5.666,
			ja = 9.5
		}
		local var_218_1 = manager.audio:GetLocalizationFlag()

		if var_218_0[var_218_1] ~= nil then
			arg_218_1.duration_ = var_218_0[var_218_1]
		end

		SetActive(arg_218_1.tipsGo_, false)

		function arg_218_1.onSingleLineFinish_()
			arg_218_1.onSingleLineUpdate_ = nil
			arg_218_1.onSingleLineFinish_ = nil
			arg_218_1.state_ = "waiting"
		end

		function arg_218_1.playNext_(arg_220_0)
			if arg_220_0 == 1 then
				arg_218_0:Play325621054(arg_218_1)
			end
		end

		function arg_218_1.onSingleLineUpdate_(arg_221_0)
			local var_221_0 = 0

			if var_221_0 < arg_218_1.time_ and arg_218_1.time_ <= var_221_0 + arg_221_0 then
				arg_218_1:PlayTimeline("10167ui_story", "StoryTimeline/CharAction/story10166/story10166actionlink/10166action4128")
			end

			local var_221_1 = 0

			if var_221_1 < arg_218_1.time_ and arg_218_1.time_ <= var_221_1 + arg_221_0 then
				arg_218_1:PlayTimeline("10167ui_story", "StoryTimeline/CharAction/public_expression/expr_wubiaoqing", "EmotionTimelineAnimator")
			end

			local var_221_2 = 0
			local var_221_3 = 0.475

			if var_221_2 < arg_218_1.time_ and arg_218_1.time_ <= var_221_2 + arg_221_0 then
				arg_218_1.talkMaxDuration = 0
				arg_218_1.dialogCg_.alpha = 1

				arg_218_1.dialog_:SetActive(true)
				SetActive(arg_218_1.leftNameGo_, true)

				local var_221_4 = arg_218_1:FormatText(StoryNameCfg[1447].name)

				arg_218_1.leftNameTxt_.text = var_221_4

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_218_1.leftNameTxt_.transform)

				arg_218_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_218_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_218_1:RecordName(arg_218_1.leftNameTxt_.text)
				SetActive(arg_218_1.iconTrs_.gameObject, false)
				arg_218_1.callingController_:SetSelectedState("normal")

				local var_221_5 = arg_218_1:GetWordFromCfg(325621053)
				local var_221_6 = arg_218_1:FormatText(var_221_5.content)

				arg_218_1.text_.text = var_221_6

				LuaForUtil.ClearLinePrefixSymbol(arg_218_1.text_)

				local var_221_7 = 19
				local var_221_8 = utf8.len(var_221_6)
				local var_221_9 = var_221_7 <= 0 and var_221_3 or var_221_3 * (var_221_8 / var_221_7)

				if var_221_9 > 0 and var_221_3 < var_221_9 then
					arg_218_1.talkMaxDuration = var_221_9

					if var_221_9 + var_221_2 > arg_218_1.duration_ then
						arg_218_1.duration_ = var_221_9 + var_221_2
					end
				end

				arg_218_1.text_.text = var_221_6
				arg_218_1.typewritter.percent = 0

				arg_218_1.typewritter:SetDirty()
				arg_218_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_325621", "325621053", "story_v_out_325621.awb") ~= 0 then
					local var_221_10 = manager.audio:GetVoiceLength("story_v_out_325621", "325621053", "story_v_out_325621.awb") / 1000

					if var_221_10 + var_221_2 > arg_218_1.duration_ then
						arg_218_1.duration_ = var_221_10 + var_221_2
					end

					if var_221_5.prefab_name ~= "" and arg_218_1.actors_[var_221_5.prefab_name] ~= nil then
						local var_221_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_218_1.actors_[var_221_5.prefab_name].transform, "story_v_out_325621", "325621053", "story_v_out_325621.awb")

						arg_218_1:RecordAudio("325621053", var_221_11)
						arg_218_1:RecordAudio("325621053", var_221_11)
					else
						arg_218_1:AudioAction("play", "voice", "story_v_out_325621", "325621053", "story_v_out_325621.awb")
					end

					arg_218_1:RecordHistoryTalkVoice("story_v_out_325621", "325621053", "story_v_out_325621.awb")
				end

				arg_218_1:RecordContent(arg_218_1.text_.text)
			end

			local var_221_12 = math.max(var_221_3, arg_218_1.talkMaxDuration)

			if var_221_2 <= arg_218_1.time_ and arg_218_1.time_ < var_221_2 + var_221_12 then
				arg_218_1.typewritter.percent = (arg_218_1.time_ - var_221_2) / var_221_12

				arg_218_1.typewritter:SetDirty()
			end

			if arg_218_1.time_ >= var_221_2 + var_221_12 and arg_218_1.time_ < var_221_2 + var_221_12 + arg_221_0 then
				arg_218_1.typewritter.percent = 1

				arg_218_1.typewritter:SetDirty()
				arg_218_1:ShowNextGo(true)
			end
		end

		arg_218_1.nodeConfigList_ = {}

		arg_218_1:InitPlayNodeList()
	end,
	Play325621054 = function(arg_222_0, arg_222_1)
		arg_222_1.time_ = 0
		arg_222_1.frameCnt_ = 0
		arg_222_1.state_ = "playing"
		arg_222_1.curTalkId_ = 325621054
		arg_222_1.duration_ = 16.03

		local var_222_0 = {
			zh = 12.233,
			ja = 16.033
		}
		local var_222_1 = manager.audio:GetLocalizationFlag()

		if var_222_0[var_222_1] ~= nil then
			arg_222_1.duration_ = var_222_0[var_222_1]
		end

		SetActive(arg_222_1.tipsGo_, false)

		function arg_222_1.onSingleLineFinish_()
			arg_222_1.onSingleLineUpdate_ = nil
			arg_222_1.onSingleLineFinish_ = nil
			arg_222_1.state_ = "waiting"
		end

		function arg_222_1.playNext_(arg_224_0)
			if arg_224_0 == 1 then
				arg_222_0:Play325621055(arg_222_1)
			end
		end

		function arg_222_1.onSingleLineUpdate_(arg_225_0)
			local var_225_0 = 0
			local var_225_1 = 1

			if var_225_0 < arg_222_1.time_ and arg_222_1.time_ <= var_225_0 + arg_225_0 then
				arg_222_1.talkMaxDuration = 0
				arg_222_1.dialogCg_.alpha = 1

				arg_222_1.dialog_:SetActive(true)
				SetActive(arg_222_1.leftNameGo_, true)

				local var_225_2 = arg_222_1:FormatText(StoryNameCfg[1447].name)

				arg_222_1.leftNameTxt_.text = var_225_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_222_1.leftNameTxt_.transform)

				arg_222_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_222_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_222_1:RecordName(arg_222_1.leftNameTxt_.text)
				SetActive(arg_222_1.iconTrs_.gameObject, false)
				arg_222_1.callingController_:SetSelectedState("normal")

				local var_225_3 = arg_222_1:GetWordFromCfg(325621054)
				local var_225_4 = arg_222_1:FormatText(var_225_3.content)

				arg_222_1.text_.text = var_225_4

				LuaForUtil.ClearLinePrefixSymbol(arg_222_1.text_)

				local var_225_5 = 40
				local var_225_6 = utf8.len(var_225_4)
				local var_225_7 = var_225_5 <= 0 and var_225_1 or var_225_1 * (var_225_6 / var_225_5)

				if var_225_7 > 0 and var_225_1 < var_225_7 then
					arg_222_1.talkMaxDuration = var_225_7

					if var_225_7 + var_225_0 > arg_222_1.duration_ then
						arg_222_1.duration_ = var_225_7 + var_225_0
					end
				end

				arg_222_1.text_.text = var_225_4
				arg_222_1.typewritter.percent = 0

				arg_222_1.typewritter:SetDirty()
				arg_222_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_325621", "325621054", "story_v_out_325621.awb") ~= 0 then
					local var_225_8 = manager.audio:GetVoiceLength("story_v_out_325621", "325621054", "story_v_out_325621.awb") / 1000

					if var_225_8 + var_225_0 > arg_222_1.duration_ then
						arg_222_1.duration_ = var_225_8 + var_225_0
					end

					if var_225_3.prefab_name ~= "" and arg_222_1.actors_[var_225_3.prefab_name] ~= nil then
						local var_225_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_222_1.actors_[var_225_3.prefab_name].transform, "story_v_out_325621", "325621054", "story_v_out_325621.awb")

						arg_222_1:RecordAudio("325621054", var_225_9)
						arg_222_1:RecordAudio("325621054", var_225_9)
					else
						arg_222_1:AudioAction("play", "voice", "story_v_out_325621", "325621054", "story_v_out_325621.awb")
					end

					arg_222_1:RecordHistoryTalkVoice("story_v_out_325621", "325621054", "story_v_out_325621.awb")
				end

				arg_222_1:RecordContent(arg_222_1.text_.text)
			end

			local var_225_10 = math.max(var_225_1, arg_222_1.talkMaxDuration)

			if var_225_0 <= arg_222_1.time_ and arg_222_1.time_ < var_225_0 + var_225_10 then
				arg_222_1.typewritter.percent = (arg_222_1.time_ - var_225_0) / var_225_10

				arg_222_1.typewritter:SetDirty()
			end

			if arg_222_1.time_ >= var_225_0 + var_225_10 and arg_222_1.time_ < var_225_0 + var_225_10 + arg_225_0 then
				arg_222_1.typewritter.percent = 1

				arg_222_1.typewritter:SetDirty()
				arg_222_1:ShowNextGo(true)
			end
		end

		arg_222_1.nodeConfigList_ = {}

		arg_222_1:InitPlayNodeList()
	end,
	Play325621055 = function(arg_226_0, arg_226_1)
		arg_226_1.time_ = 0
		arg_226_1.frameCnt_ = 0
		arg_226_1.state_ = "playing"
		arg_226_1.curTalkId_ = 325621055
		arg_226_1.duration_ = 5

		SetActive(arg_226_1.tipsGo_, false)

		function arg_226_1.onSingleLineFinish_()
			arg_226_1.onSingleLineUpdate_ = nil
			arg_226_1.onSingleLineFinish_ = nil
			arg_226_1.state_ = "waiting"
		end

		function arg_226_1.playNext_(arg_228_0)
			if arg_228_0 == 1 then
				arg_226_0:Play325621056(arg_226_1)
			end
		end

		function arg_226_1.onSingleLineUpdate_(arg_229_0)
			local var_229_0 = arg_226_1.actors_["10167ui_story"].transform
			local var_229_1 = 0

			if var_229_1 < arg_226_1.time_ and arg_226_1.time_ <= var_229_1 + arg_229_0 then
				arg_226_1.var_.moveOldPos10167ui_story = var_229_0.localPosition

				local var_229_2 = GameObjectTools.GetOrAddComponent(var_229_0.gameObject, typeof(DynamicBoneHelper))

				if var_229_2 then
					var_229_2:EnableDynamicBone(false)
				end
			end

			local var_229_3 = 0.001

			if var_229_1 <= arg_226_1.time_ and arg_226_1.time_ < var_229_1 + var_229_3 then
				local var_229_4 = (arg_226_1.time_ - var_229_1) / var_229_3
				local var_229_5 = Vector3.New(0, 100, 0)

				var_229_0.localPosition = Vector3.Lerp(arg_226_1.var_.moveOldPos10167ui_story, var_229_5, var_229_4)

				local var_229_6 = manager.ui.mainCamera.transform.position - var_229_0.position

				var_229_0.forward = Vector3.New(var_229_6.x, var_229_6.y, var_229_6.z)

				local var_229_7 = var_229_0.localEulerAngles

				var_229_7.z = 0
				var_229_7.x = 0
				var_229_0.localEulerAngles = var_229_7
			end

			if arg_226_1.time_ >= var_229_1 + var_229_3 and arg_226_1.time_ < var_229_1 + var_229_3 + arg_229_0 then
				var_229_0.localPosition = Vector3.New(0, 100, 0)

				local var_229_8 = manager.ui.mainCamera.transform.position - var_229_0.position

				var_229_0.forward = Vector3.New(var_229_8.x, var_229_8.y, var_229_8.z)

				local var_229_9 = var_229_0.localEulerAngles

				var_229_9.z = 0
				var_229_9.x = 0
				var_229_0.localEulerAngles = var_229_9

				local var_229_10 = GameObjectTools.GetOrAddComponent(var_229_0.gameObject, typeof(DynamicBoneHelper))

				if var_229_10 then
					var_229_10:EnableDynamicBone(true)
				end
			end

			local var_229_11 = arg_226_1.actors_["10167ui_story"]
			local var_229_12 = 0

			if var_229_12 < arg_226_1.time_ and arg_226_1.time_ <= var_229_12 + arg_229_0 and not isNil(var_229_11) and arg_226_1.var_.characterEffect10167ui_story == nil then
				arg_226_1.var_.characterEffect10167ui_story = var_229_11:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_229_13 = 0.200000002980232

			if var_229_12 <= arg_226_1.time_ and arg_226_1.time_ < var_229_12 + var_229_13 and not isNil(var_229_11) then
				local var_229_14 = (arg_226_1.time_ - var_229_12) / var_229_13

				if arg_226_1.var_.characterEffect10167ui_story and not isNil(var_229_11) then
					local var_229_15 = Mathf.Lerp(0, 0.5, var_229_14)

					arg_226_1.var_.characterEffect10167ui_story.fillFlat = true
					arg_226_1.var_.characterEffect10167ui_story.fillRatio = var_229_15
				end
			end

			if arg_226_1.time_ >= var_229_12 + var_229_13 and arg_226_1.time_ < var_229_12 + var_229_13 + arg_229_0 and not isNil(var_229_11) and arg_226_1.var_.characterEffect10167ui_story then
				local var_229_16 = 0.5

				arg_226_1.var_.characterEffect10167ui_story.fillFlat = true
				arg_226_1.var_.characterEffect10167ui_story.fillRatio = var_229_16
			end

			local var_229_17 = 0
			local var_229_18 = 0.725

			if var_229_17 < arg_226_1.time_ and arg_226_1.time_ <= var_229_17 + arg_229_0 then
				arg_226_1.talkMaxDuration = 0
				arg_226_1.dialogCg_.alpha = 1

				arg_226_1.dialog_:SetActive(true)
				SetActive(arg_226_1.leftNameGo_, false)

				arg_226_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_226_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_226_1:RecordName(arg_226_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_226_1.iconTrs_.gameObject, false)
				arg_226_1.callingController_:SetSelectedState("normal")

				local var_229_19 = arg_226_1:GetWordFromCfg(325621055)
				local var_229_20 = arg_226_1:FormatText(var_229_19.content)

				arg_226_1.text_.text = var_229_20

				LuaForUtil.ClearLinePrefixSymbol(arg_226_1.text_)

				local var_229_21 = 29
				local var_229_22 = utf8.len(var_229_20)
				local var_229_23 = var_229_21 <= 0 and var_229_18 or var_229_18 * (var_229_22 / var_229_21)

				if var_229_23 > 0 and var_229_18 < var_229_23 then
					arg_226_1.talkMaxDuration = var_229_23

					if var_229_23 + var_229_17 > arg_226_1.duration_ then
						arg_226_1.duration_ = var_229_23 + var_229_17
					end
				end

				arg_226_1.text_.text = var_229_20
				arg_226_1.typewritter.percent = 0

				arg_226_1.typewritter:SetDirty()
				arg_226_1:ShowNextGo(false)
				arg_226_1:RecordContent(arg_226_1.text_.text)
			end

			local var_229_24 = math.max(var_229_18, arg_226_1.talkMaxDuration)

			if var_229_17 <= arg_226_1.time_ and arg_226_1.time_ < var_229_17 + var_229_24 then
				arg_226_1.typewritter.percent = (arg_226_1.time_ - var_229_17) / var_229_24

				arg_226_1.typewritter:SetDirty()
			end

			if arg_226_1.time_ >= var_229_17 + var_229_24 and arg_226_1.time_ < var_229_17 + var_229_24 + arg_229_0 then
				arg_226_1.typewritter.percent = 1

				arg_226_1.typewritter:SetDirty()
				arg_226_1:ShowNextGo(true)
			end
		end

		arg_226_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10167ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_226_1:InitPlayNodeList()
	end,
	Play325621056 = function(arg_230_0, arg_230_1)
		arg_230_1.time_ = 0
		arg_230_1.frameCnt_ = 0
		arg_230_1.state_ = "playing"
		arg_230_1.curTalkId_ = 325621056
		arg_230_1.duration_ = 8.1

		local var_230_0 = {
			zh = 8.1,
			ja = 7.7
		}
		local var_230_1 = manager.audio:GetLocalizationFlag()

		if var_230_0[var_230_1] ~= nil then
			arg_230_1.duration_ = var_230_0[var_230_1]
		end

		SetActive(arg_230_1.tipsGo_, false)

		function arg_230_1.onSingleLineFinish_()
			arg_230_1.onSingleLineUpdate_ = nil
			arg_230_1.onSingleLineFinish_ = nil
			arg_230_1.state_ = "waiting"
		end

		function arg_230_1.playNext_(arg_232_0)
			if arg_232_0 == 1 then
				arg_230_0:Play325621057(arg_230_1)
			end
		end

		function arg_230_1.onSingleLineUpdate_(arg_233_0)
			local var_233_0 = arg_230_1.actors_["10167ui_story"].transform
			local var_233_1 = 0

			if var_233_1 < arg_230_1.time_ and arg_230_1.time_ <= var_233_1 + arg_233_0 then
				arg_230_1.var_.moveOldPos10167ui_story = var_233_0.localPosition

				local var_233_2 = GameObjectTools.GetOrAddComponent(var_233_0.gameObject, typeof(DynamicBoneHelper))

				if var_233_2 then
					var_233_2:EnableDynamicBone(false)
				end
			end

			local var_233_3 = 0.001

			if var_233_1 <= arg_230_1.time_ and arg_230_1.time_ < var_233_1 + var_233_3 then
				local var_233_4 = (arg_230_1.time_ - var_233_1) / var_233_3
				local var_233_5 = Vector3.New(0, -1.28, -5.73)

				var_233_0.localPosition = Vector3.Lerp(arg_230_1.var_.moveOldPos10167ui_story, var_233_5, var_233_4)

				local var_233_6 = manager.ui.mainCamera.transform.position - var_233_0.position

				var_233_0.forward = Vector3.New(var_233_6.x, var_233_6.y, var_233_6.z)

				local var_233_7 = var_233_0.localEulerAngles

				var_233_7.z = 0
				var_233_7.x = 0
				var_233_0.localEulerAngles = var_233_7
			end

			if arg_230_1.time_ >= var_233_1 + var_233_3 and arg_230_1.time_ < var_233_1 + var_233_3 + arg_233_0 then
				var_233_0.localPosition = Vector3.New(0, -1.28, -5.73)

				local var_233_8 = manager.ui.mainCamera.transform.position - var_233_0.position

				var_233_0.forward = Vector3.New(var_233_8.x, var_233_8.y, var_233_8.z)

				local var_233_9 = var_233_0.localEulerAngles

				var_233_9.z = 0
				var_233_9.x = 0
				var_233_0.localEulerAngles = var_233_9

				local var_233_10 = GameObjectTools.GetOrAddComponent(var_233_0.gameObject, typeof(DynamicBoneHelper))

				if var_233_10 then
					var_233_10:EnableDynamicBone(true)
				end
			end

			local var_233_11 = arg_230_1.actors_["10167ui_story"]
			local var_233_12 = 0

			if var_233_12 < arg_230_1.time_ and arg_230_1.time_ <= var_233_12 + arg_233_0 and not isNil(var_233_11) and arg_230_1.var_.characterEffect10167ui_story == nil then
				arg_230_1.var_.characterEffect10167ui_story = var_233_11:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_233_13 = 0.200000002980232

			if var_233_12 <= arg_230_1.time_ and arg_230_1.time_ < var_233_12 + var_233_13 and not isNil(var_233_11) then
				local var_233_14 = (arg_230_1.time_ - var_233_12) / var_233_13

				if arg_230_1.var_.characterEffect10167ui_story and not isNil(var_233_11) then
					arg_230_1.var_.characterEffect10167ui_story.fillFlat = false
				end
			end

			if arg_230_1.time_ >= var_233_12 + var_233_13 and arg_230_1.time_ < var_233_12 + var_233_13 + arg_233_0 and not isNil(var_233_11) and arg_230_1.var_.characterEffect10167ui_story then
				arg_230_1.var_.characterEffect10167ui_story.fillFlat = false
			end

			local var_233_15 = 0

			if var_233_15 < arg_230_1.time_ and arg_230_1.time_ <= var_233_15 + arg_233_0 then
				arg_230_1:PlayTimeline("10167ui_story", "StoryTimeline/CharAction/public_expression/expr_wubiaoqing", "EmotionTimelineAnimator")
			end

			local var_233_16 = 0

			if var_233_16 < arg_230_1.time_ and arg_230_1.time_ <= var_233_16 + arg_233_0 then
				arg_230_1:PlayTimeline("10167ui_story", "StoryTimeline/CharAction/story10166/story10166action/10166action8_2")
			end

			local var_233_17 = 0
			local var_233_18 = 0.6

			if var_233_17 < arg_230_1.time_ and arg_230_1.time_ <= var_233_17 + arg_233_0 then
				arg_230_1.talkMaxDuration = 0
				arg_230_1.dialogCg_.alpha = 1

				arg_230_1.dialog_:SetActive(true)
				SetActive(arg_230_1.leftNameGo_, true)

				local var_233_19 = arg_230_1:FormatText(StoryNameCfg[1447].name)

				arg_230_1.leftNameTxt_.text = var_233_19

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_230_1.leftNameTxt_.transform)

				arg_230_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_230_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_230_1:RecordName(arg_230_1.leftNameTxt_.text)
				SetActive(arg_230_1.iconTrs_.gameObject, false)
				arg_230_1.callingController_:SetSelectedState("normal")

				local var_233_20 = arg_230_1:GetWordFromCfg(325621056)
				local var_233_21 = arg_230_1:FormatText(var_233_20.content)

				arg_230_1.text_.text = var_233_21

				LuaForUtil.ClearLinePrefixSymbol(arg_230_1.text_)

				local var_233_22 = 24
				local var_233_23 = utf8.len(var_233_21)
				local var_233_24 = var_233_22 <= 0 and var_233_18 or var_233_18 * (var_233_23 / var_233_22)

				if var_233_24 > 0 and var_233_18 < var_233_24 then
					arg_230_1.talkMaxDuration = var_233_24

					if var_233_24 + var_233_17 > arg_230_1.duration_ then
						arg_230_1.duration_ = var_233_24 + var_233_17
					end
				end

				arg_230_1.text_.text = var_233_21
				arg_230_1.typewritter.percent = 0

				arg_230_1.typewritter:SetDirty()
				arg_230_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_325621", "325621056", "story_v_out_325621.awb") ~= 0 then
					local var_233_25 = manager.audio:GetVoiceLength("story_v_out_325621", "325621056", "story_v_out_325621.awb") / 1000

					if var_233_25 + var_233_17 > arg_230_1.duration_ then
						arg_230_1.duration_ = var_233_25 + var_233_17
					end

					if var_233_20.prefab_name ~= "" and arg_230_1.actors_[var_233_20.prefab_name] ~= nil then
						local var_233_26 = LuaForUtil.PlayVoiceWithCriLipsync(arg_230_1.actors_[var_233_20.prefab_name].transform, "story_v_out_325621", "325621056", "story_v_out_325621.awb")

						arg_230_1:RecordAudio("325621056", var_233_26)
						arg_230_1:RecordAudio("325621056", var_233_26)
					else
						arg_230_1:AudioAction("play", "voice", "story_v_out_325621", "325621056", "story_v_out_325621.awb")
					end

					arg_230_1:RecordHistoryTalkVoice("story_v_out_325621", "325621056", "story_v_out_325621.awb")
				end

				arg_230_1:RecordContent(arg_230_1.text_.text)
			end

			local var_233_27 = math.max(var_233_18, arg_230_1.talkMaxDuration)

			if var_233_17 <= arg_230_1.time_ and arg_230_1.time_ < var_233_17 + var_233_27 then
				arg_230_1.typewritter.percent = (arg_230_1.time_ - var_233_17) / var_233_27

				arg_230_1.typewritter:SetDirty()
			end

			if arg_230_1.time_ >= var_233_17 + var_233_27 and arg_230_1.time_ < var_233_17 + var_233_27 + arg_233_0 then
				arg_230_1.typewritter.percent = 1

				arg_230_1.typewritter:SetDirty()
				arg_230_1:ShowNextGo(true)
			end
		end

		arg_230_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10167ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_230_1:InitPlayNodeList()
	end,
	Play325621057 = function(arg_234_0, arg_234_1)
		arg_234_1.time_ = 0
		arg_234_1.frameCnt_ = 0
		arg_234_1.state_ = "playing"
		arg_234_1.curTalkId_ = 325621057
		arg_234_1.duration_ = 15.97

		local var_234_0 = {
			zh = 14.4,
			ja = 15.966
		}
		local var_234_1 = manager.audio:GetLocalizationFlag()

		if var_234_0[var_234_1] ~= nil then
			arg_234_1.duration_ = var_234_0[var_234_1]
		end

		SetActive(arg_234_1.tipsGo_, false)

		function arg_234_1.onSingleLineFinish_()
			arg_234_1.onSingleLineUpdate_ = nil
			arg_234_1.onSingleLineFinish_ = nil
			arg_234_1.state_ = "waiting"
		end

		function arg_234_1.playNext_(arg_236_0)
			if arg_236_0 == 1 then
				arg_234_0:Play325621058(arg_234_1)
			end
		end

		function arg_234_1.onSingleLineUpdate_(arg_237_0)
			local var_237_0 = 0
			local var_237_1 = 1.15

			if var_237_0 < arg_234_1.time_ and arg_234_1.time_ <= var_237_0 + arg_237_0 then
				arg_234_1.talkMaxDuration = 0
				arg_234_1.dialogCg_.alpha = 1

				arg_234_1.dialog_:SetActive(true)
				SetActive(arg_234_1.leftNameGo_, true)

				local var_237_2 = arg_234_1:FormatText(StoryNameCfg[1447].name)

				arg_234_1.leftNameTxt_.text = var_237_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_234_1.leftNameTxt_.transform)

				arg_234_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_234_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_234_1:RecordName(arg_234_1.leftNameTxt_.text)
				SetActive(arg_234_1.iconTrs_.gameObject, false)
				arg_234_1.callingController_:SetSelectedState("normal")

				local var_237_3 = arg_234_1:GetWordFromCfg(325621057)
				local var_237_4 = arg_234_1:FormatText(var_237_3.content)

				arg_234_1.text_.text = var_237_4

				LuaForUtil.ClearLinePrefixSymbol(arg_234_1.text_)

				local var_237_5 = 46
				local var_237_6 = utf8.len(var_237_4)
				local var_237_7 = var_237_5 <= 0 and var_237_1 or var_237_1 * (var_237_6 / var_237_5)

				if var_237_7 > 0 and var_237_1 < var_237_7 then
					arg_234_1.talkMaxDuration = var_237_7

					if var_237_7 + var_237_0 > arg_234_1.duration_ then
						arg_234_1.duration_ = var_237_7 + var_237_0
					end
				end

				arg_234_1.text_.text = var_237_4
				arg_234_1.typewritter.percent = 0

				arg_234_1.typewritter:SetDirty()
				arg_234_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_325621", "325621057", "story_v_out_325621.awb") ~= 0 then
					local var_237_8 = manager.audio:GetVoiceLength("story_v_out_325621", "325621057", "story_v_out_325621.awb") / 1000

					if var_237_8 + var_237_0 > arg_234_1.duration_ then
						arg_234_1.duration_ = var_237_8 + var_237_0
					end

					if var_237_3.prefab_name ~= "" and arg_234_1.actors_[var_237_3.prefab_name] ~= nil then
						local var_237_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_234_1.actors_[var_237_3.prefab_name].transform, "story_v_out_325621", "325621057", "story_v_out_325621.awb")

						arg_234_1:RecordAudio("325621057", var_237_9)
						arg_234_1:RecordAudio("325621057", var_237_9)
					else
						arg_234_1:AudioAction("play", "voice", "story_v_out_325621", "325621057", "story_v_out_325621.awb")
					end

					arg_234_1:RecordHistoryTalkVoice("story_v_out_325621", "325621057", "story_v_out_325621.awb")
				end

				arg_234_1:RecordContent(arg_234_1.text_.text)
			end

			local var_237_10 = math.max(var_237_1, arg_234_1.talkMaxDuration)

			if var_237_0 <= arg_234_1.time_ and arg_234_1.time_ < var_237_0 + var_237_10 then
				arg_234_1.typewritter.percent = (arg_234_1.time_ - var_237_0) / var_237_10

				arg_234_1.typewritter:SetDirty()
			end

			if arg_234_1.time_ >= var_237_0 + var_237_10 and arg_234_1.time_ < var_237_0 + var_237_10 + arg_237_0 then
				arg_234_1.typewritter.percent = 1

				arg_234_1.typewritter:SetDirty()
				arg_234_1:ShowNextGo(true)
			end
		end

		arg_234_1.nodeConfigList_ = {}

		arg_234_1:InitPlayNodeList()
	end,
	Play325621058 = function(arg_238_0, arg_238_1)
		arg_238_1.time_ = 0
		arg_238_1.frameCnt_ = 0
		arg_238_1.state_ = "playing"
		arg_238_1.curTalkId_ = 325621058
		arg_238_1.duration_ = 17

		local var_238_0 = {
			zh = 14.066,
			ja = 17
		}
		local var_238_1 = manager.audio:GetLocalizationFlag()

		if var_238_0[var_238_1] ~= nil then
			arg_238_1.duration_ = var_238_0[var_238_1]
		end

		SetActive(arg_238_1.tipsGo_, false)

		function arg_238_1.onSingleLineFinish_()
			arg_238_1.onSingleLineUpdate_ = nil
			arg_238_1.onSingleLineFinish_ = nil
			arg_238_1.state_ = "waiting"
		end

		function arg_238_1.playNext_(arg_240_0)
			if arg_240_0 == 1 then
				arg_238_0:Play325621059(arg_238_1)
			end
		end

		function arg_238_1.onSingleLineUpdate_(arg_241_0)
			local var_241_0 = 0

			if var_241_0 < arg_238_1.time_ and arg_238_1.time_ <= var_241_0 + arg_241_0 then
				arg_238_1:PlayTimeline("10167ui_story", "StoryTimeline/CharAction/story10166/story10166action/10166action15_1")
			end

			local var_241_1 = 0

			if var_241_1 < arg_238_1.time_ and arg_238_1.time_ <= var_241_1 + arg_241_0 then
				arg_238_1:PlayTimeline("10167ui_story", "StoryTimeline/CharAction/public_expression/expr_wubiaoqing", "EmotionTimelineAnimator")
			end

			local var_241_2 = 0
			local var_241_3 = 1.1

			if var_241_2 < arg_238_1.time_ and arg_238_1.time_ <= var_241_2 + arg_241_0 then
				arg_238_1.talkMaxDuration = 0
				arg_238_1.dialogCg_.alpha = 1

				arg_238_1.dialog_:SetActive(true)
				SetActive(arg_238_1.leftNameGo_, true)

				local var_241_4 = arg_238_1:FormatText(StoryNameCfg[1447].name)

				arg_238_1.leftNameTxt_.text = var_241_4

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_238_1.leftNameTxt_.transform)

				arg_238_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_238_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_238_1:RecordName(arg_238_1.leftNameTxt_.text)
				SetActive(arg_238_1.iconTrs_.gameObject, false)
				arg_238_1.callingController_:SetSelectedState("normal")

				local var_241_5 = arg_238_1:GetWordFromCfg(325621058)
				local var_241_6 = arg_238_1:FormatText(var_241_5.content)

				arg_238_1.text_.text = var_241_6

				LuaForUtil.ClearLinePrefixSymbol(arg_238_1.text_)

				local var_241_7 = 44
				local var_241_8 = utf8.len(var_241_6)
				local var_241_9 = var_241_7 <= 0 and var_241_3 or var_241_3 * (var_241_8 / var_241_7)

				if var_241_9 > 0 and var_241_3 < var_241_9 then
					arg_238_1.talkMaxDuration = var_241_9

					if var_241_9 + var_241_2 > arg_238_1.duration_ then
						arg_238_1.duration_ = var_241_9 + var_241_2
					end
				end

				arg_238_1.text_.text = var_241_6
				arg_238_1.typewritter.percent = 0

				arg_238_1.typewritter:SetDirty()
				arg_238_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_325621", "325621058", "story_v_out_325621.awb") ~= 0 then
					local var_241_10 = manager.audio:GetVoiceLength("story_v_out_325621", "325621058", "story_v_out_325621.awb") / 1000

					if var_241_10 + var_241_2 > arg_238_1.duration_ then
						arg_238_1.duration_ = var_241_10 + var_241_2
					end

					if var_241_5.prefab_name ~= "" and arg_238_1.actors_[var_241_5.prefab_name] ~= nil then
						local var_241_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_238_1.actors_[var_241_5.prefab_name].transform, "story_v_out_325621", "325621058", "story_v_out_325621.awb")

						arg_238_1:RecordAudio("325621058", var_241_11)
						arg_238_1:RecordAudio("325621058", var_241_11)
					else
						arg_238_1:AudioAction("play", "voice", "story_v_out_325621", "325621058", "story_v_out_325621.awb")
					end

					arg_238_1:RecordHistoryTalkVoice("story_v_out_325621", "325621058", "story_v_out_325621.awb")
				end

				arg_238_1:RecordContent(arg_238_1.text_.text)
			end

			local var_241_12 = math.max(var_241_3, arg_238_1.talkMaxDuration)

			if var_241_2 <= arg_238_1.time_ and arg_238_1.time_ < var_241_2 + var_241_12 then
				arg_238_1.typewritter.percent = (arg_238_1.time_ - var_241_2) / var_241_12

				arg_238_1.typewritter:SetDirty()
			end

			if arg_238_1.time_ >= var_241_2 + var_241_12 and arg_238_1.time_ < var_241_2 + var_241_12 + arg_241_0 then
				arg_238_1.typewritter.percent = 1

				arg_238_1.typewritter:SetDirty()
				arg_238_1:ShowNextGo(true)
			end
		end

		arg_238_1.nodeConfigList_ = {}

		arg_238_1:InitPlayNodeList()
	end,
	Play325621059 = function(arg_242_0, arg_242_1)
		arg_242_1.time_ = 0
		arg_242_1.frameCnt_ = 0
		arg_242_1.state_ = "playing"
		arg_242_1.curTalkId_ = 325621059
		arg_242_1.duration_ = 20.63

		local var_242_0 = {
			zh = 18.233,
			ja = 20.633
		}
		local var_242_1 = manager.audio:GetLocalizationFlag()

		if var_242_0[var_242_1] ~= nil then
			arg_242_1.duration_ = var_242_0[var_242_1]
		end

		SetActive(arg_242_1.tipsGo_, false)

		function arg_242_1.onSingleLineFinish_()
			arg_242_1.onSingleLineUpdate_ = nil
			arg_242_1.onSingleLineFinish_ = nil
			arg_242_1.state_ = "waiting"
		end

		function arg_242_1.playNext_(arg_244_0)
			if arg_244_0 == 1 then
				arg_242_0:Play325621060(arg_242_1)
			end
		end

		function arg_242_1.onSingleLineUpdate_(arg_245_0)
			local var_245_0 = 0
			local var_245_1 = 1.325

			if var_245_0 < arg_242_1.time_ and arg_242_1.time_ <= var_245_0 + arg_245_0 then
				arg_242_1.talkMaxDuration = 0
				arg_242_1.dialogCg_.alpha = 1

				arg_242_1.dialog_:SetActive(true)
				SetActive(arg_242_1.leftNameGo_, true)

				local var_245_2 = arg_242_1:FormatText(StoryNameCfg[1447].name)

				arg_242_1.leftNameTxt_.text = var_245_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_242_1.leftNameTxt_.transform)

				arg_242_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_242_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_242_1:RecordName(arg_242_1.leftNameTxt_.text)
				SetActive(arg_242_1.iconTrs_.gameObject, false)
				arg_242_1.callingController_:SetSelectedState("normal")

				local var_245_3 = arg_242_1:GetWordFromCfg(325621059)
				local var_245_4 = arg_242_1:FormatText(var_245_3.content)

				arg_242_1.text_.text = var_245_4

				LuaForUtil.ClearLinePrefixSymbol(arg_242_1.text_)

				local var_245_5 = 53
				local var_245_6 = utf8.len(var_245_4)
				local var_245_7 = var_245_5 <= 0 and var_245_1 or var_245_1 * (var_245_6 / var_245_5)

				if var_245_7 > 0 and var_245_1 < var_245_7 then
					arg_242_1.talkMaxDuration = var_245_7

					if var_245_7 + var_245_0 > arg_242_1.duration_ then
						arg_242_1.duration_ = var_245_7 + var_245_0
					end
				end

				arg_242_1.text_.text = var_245_4
				arg_242_1.typewritter.percent = 0

				arg_242_1.typewritter:SetDirty()
				arg_242_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_325621", "325621059", "story_v_out_325621.awb") ~= 0 then
					local var_245_8 = manager.audio:GetVoiceLength("story_v_out_325621", "325621059", "story_v_out_325621.awb") / 1000

					if var_245_8 + var_245_0 > arg_242_1.duration_ then
						arg_242_1.duration_ = var_245_8 + var_245_0
					end

					if var_245_3.prefab_name ~= "" and arg_242_1.actors_[var_245_3.prefab_name] ~= nil then
						local var_245_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_242_1.actors_[var_245_3.prefab_name].transform, "story_v_out_325621", "325621059", "story_v_out_325621.awb")

						arg_242_1:RecordAudio("325621059", var_245_9)
						arg_242_1:RecordAudio("325621059", var_245_9)
					else
						arg_242_1:AudioAction("play", "voice", "story_v_out_325621", "325621059", "story_v_out_325621.awb")
					end

					arg_242_1:RecordHistoryTalkVoice("story_v_out_325621", "325621059", "story_v_out_325621.awb")
				end

				arg_242_1:RecordContent(arg_242_1.text_.text)
			end

			local var_245_10 = math.max(var_245_1, arg_242_1.talkMaxDuration)

			if var_245_0 <= arg_242_1.time_ and arg_242_1.time_ < var_245_0 + var_245_10 then
				arg_242_1.typewritter.percent = (arg_242_1.time_ - var_245_0) / var_245_10

				arg_242_1.typewritter:SetDirty()
			end

			if arg_242_1.time_ >= var_245_0 + var_245_10 and arg_242_1.time_ < var_245_0 + var_245_10 + arg_245_0 then
				arg_242_1.typewritter.percent = 1

				arg_242_1.typewritter:SetDirty()
				arg_242_1:ShowNextGo(true)
			end
		end

		arg_242_1.nodeConfigList_ = {}

		arg_242_1:InitPlayNodeList()
	end,
	Play325621060 = function(arg_246_0, arg_246_1)
		arg_246_1.time_ = 0
		arg_246_1.frameCnt_ = 0
		arg_246_1.state_ = "playing"
		arg_246_1.curTalkId_ = 325621060
		arg_246_1.duration_ = 20.23

		local var_246_0 = {
			zh = 18.1,
			ja = 20.233
		}
		local var_246_1 = manager.audio:GetLocalizationFlag()

		if var_246_0[var_246_1] ~= nil then
			arg_246_1.duration_ = var_246_0[var_246_1]
		end

		SetActive(arg_246_1.tipsGo_, false)

		function arg_246_1.onSingleLineFinish_()
			arg_246_1.onSingleLineUpdate_ = nil
			arg_246_1.onSingleLineFinish_ = nil
			arg_246_1.state_ = "waiting"
		end

		function arg_246_1.playNext_(arg_248_0)
			if arg_248_0 == 1 then
				arg_246_0:Play325621061(arg_246_1)
			end
		end

		function arg_246_1.onSingleLineUpdate_(arg_249_0)
			local var_249_0 = 0

			if var_249_0 < arg_246_1.time_ and arg_246_1.time_ <= var_249_0 + arg_249_0 then
				arg_246_1:PlayTimeline("10167ui_story", "StoryTimeline/CharAction/story10166/story10166action/10166action15_2")
			end

			local var_249_1 = 0

			if var_249_1 < arg_246_1.time_ and arg_246_1.time_ <= var_249_1 + arg_249_0 then
				arg_246_1:PlayTimeline("10167ui_story", "StoryTimeline/CharAction/public_expression/expr_wubiaoqing", "EmotionTimelineAnimator")
			end

			local var_249_2 = 0
			local var_249_3 = 1.5

			if var_249_2 < arg_246_1.time_ and arg_246_1.time_ <= var_249_2 + arg_249_0 then
				arg_246_1.talkMaxDuration = 0
				arg_246_1.dialogCg_.alpha = 1

				arg_246_1.dialog_:SetActive(true)
				SetActive(arg_246_1.leftNameGo_, true)

				local var_249_4 = arg_246_1:FormatText(StoryNameCfg[1447].name)

				arg_246_1.leftNameTxt_.text = var_249_4

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_246_1.leftNameTxt_.transform)

				arg_246_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_246_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_246_1:RecordName(arg_246_1.leftNameTxt_.text)
				SetActive(arg_246_1.iconTrs_.gameObject, false)
				arg_246_1.callingController_:SetSelectedState("normal")

				local var_249_5 = arg_246_1:GetWordFromCfg(325621060)
				local var_249_6 = arg_246_1:FormatText(var_249_5.content)

				arg_246_1.text_.text = var_249_6

				LuaForUtil.ClearLinePrefixSymbol(arg_246_1.text_)

				local var_249_7 = 60
				local var_249_8 = utf8.len(var_249_6)
				local var_249_9 = var_249_7 <= 0 and var_249_3 or var_249_3 * (var_249_8 / var_249_7)

				if var_249_9 > 0 and var_249_3 < var_249_9 then
					arg_246_1.talkMaxDuration = var_249_9

					if var_249_9 + var_249_2 > arg_246_1.duration_ then
						arg_246_1.duration_ = var_249_9 + var_249_2
					end
				end

				arg_246_1.text_.text = var_249_6
				arg_246_1.typewritter.percent = 0

				arg_246_1.typewritter:SetDirty()
				arg_246_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_325621", "325621060", "story_v_out_325621.awb") ~= 0 then
					local var_249_10 = manager.audio:GetVoiceLength("story_v_out_325621", "325621060", "story_v_out_325621.awb") / 1000

					if var_249_10 + var_249_2 > arg_246_1.duration_ then
						arg_246_1.duration_ = var_249_10 + var_249_2
					end

					if var_249_5.prefab_name ~= "" and arg_246_1.actors_[var_249_5.prefab_name] ~= nil then
						local var_249_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_246_1.actors_[var_249_5.prefab_name].transform, "story_v_out_325621", "325621060", "story_v_out_325621.awb")

						arg_246_1:RecordAudio("325621060", var_249_11)
						arg_246_1:RecordAudio("325621060", var_249_11)
					else
						arg_246_1:AudioAction("play", "voice", "story_v_out_325621", "325621060", "story_v_out_325621.awb")
					end

					arg_246_1:RecordHistoryTalkVoice("story_v_out_325621", "325621060", "story_v_out_325621.awb")
				end

				arg_246_1:RecordContent(arg_246_1.text_.text)
			end

			local var_249_12 = math.max(var_249_3, arg_246_1.talkMaxDuration)

			if var_249_2 <= arg_246_1.time_ and arg_246_1.time_ < var_249_2 + var_249_12 then
				arg_246_1.typewritter.percent = (arg_246_1.time_ - var_249_2) / var_249_12

				arg_246_1.typewritter:SetDirty()
			end

			if arg_246_1.time_ >= var_249_2 + var_249_12 and arg_246_1.time_ < var_249_2 + var_249_12 + arg_249_0 then
				arg_246_1.typewritter.percent = 1

				arg_246_1.typewritter:SetDirty()
				arg_246_1:ShowNextGo(true)
			end
		end

		arg_246_1.nodeConfigList_ = {}

		arg_246_1:InitPlayNodeList()
	end,
	Play325621061 = function(arg_250_0, arg_250_1)
		arg_250_1.time_ = 0
		arg_250_1.frameCnt_ = 0
		arg_250_1.state_ = "playing"
		arg_250_1.curTalkId_ = 325621061
		arg_250_1.duration_ = 10.3

		local var_250_0 = {
			zh = 10.3,
			ja = 10.033
		}
		local var_250_1 = manager.audio:GetLocalizationFlag()

		if var_250_0[var_250_1] ~= nil then
			arg_250_1.duration_ = var_250_0[var_250_1]
		end

		SetActive(arg_250_1.tipsGo_, false)

		function arg_250_1.onSingleLineFinish_()
			arg_250_1.onSingleLineUpdate_ = nil
			arg_250_1.onSingleLineFinish_ = nil
			arg_250_1.state_ = "waiting"
		end

		function arg_250_1.playNext_(arg_252_0)
			if arg_252_0 == 1 then
				arg_250_0:Play325621062(arg_250_1)
			end
		end

		function arg_250_1.onSingleLineUpdate_(arg_253_0)
			local var_253_0 = 0
			local var_253_1 = 0.75

			if var_253_0 < arg_250_1.time_ and arg_250_1.time_ <= var_253_0 + arg_253_0 then
				arg_250_1.talkMaxDuration = 0
				arg_250_1.dialogCg_.alpha = 1

				arg_250_1.dialog_:SetActive(true)
				SetActive(arg_250_1.leftNameGo_, true)

				local var_253_2 = arg_250_1:FormatText(StoryNameCfg[1447].name)

				arg_250_1.leftNameTxt_.text = var_253_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_250_1.leftNameTxt_.transform)

				arg_250_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_250_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_250_1:RecordName(arg_250_1.leftNameTxt_.text)
				SetActive(arg_250_1.iconTrs_.gameObject, false)
				arg_250_1.callingController_:SetSelectedState("normal")

				local var_253_3 = arg_250_1:GetWordFromCfg(325621061)
				local var_253_4 = arg_250_1:FormatText(var_253_3.content)

				arg_250_1.text_.text = var_253_4

				LuaForUtil.ClearLinePrefixSymbol(arg_250_1.text_)

				local var_253_5 = 30
				local var_253_6 = utf8.len(var_253_4)
				local var_253_7 = var_253_5 <= 0 and var_253_1 or var_253_1 * (var_253_6 / var_253_5)

				if var_253_7 > 0 and var_253_1 < var_253_7 then
					arg_250_1.talkMaxDuration = var_253_7

					if var_253_7 + var_253_0 > arg_250_1.duration_ then
						arg_250_1.duration_ = var_253_7 + var_253_0
					end
				end

				arg_250_1.text_.text = var_253_4
				arg_250_1.typewritter.percent = 0

				arg_250_1.typewritter:SetDirty()
				arg_250_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_325621", "325621061", "story_v_out_325621.awb") ~= 0 then
					local var_253_8 = manager.audio:GetVoiceLength("story_v_out_325621", "325621061", "story_v_out_325621.awb") / 1000

					if var_253_8 + var_253_0 > arg_250_1.duration_ then
						arg_250_1.duration_ = var_253_8 + var_253_0
					end

					if var_253_3.prefab_name ~= "" and arg_250_1.actors_[var_253_3.prefab_name] ~= nil then
						local var_253_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_250_1.actors_[var_253_3.prefab_name].transform, "story_v_out_325621", "325621061", "story_v_out_325621.awb")

						arg_250_1:RecordAudio("325621061", var_253_9)
						arg_250_1:RecordAudio("325621061", var_253_9)
					else
						arg_250_1:AudioAction("play", "voice", "story_v_out_325621", "325621061", "story_v_out_325621.awb")
					end

					arg_250_1:RecordHistoryTalkVoice("story_v_out_325621", "325621061", "story_v_out_325621.awb")
				end

				arg_250_1:RecordContent(arg_250_1.text_.text)
			end

			local var_253_10 = math.max(var_253_1, arg_250_1.talkMaxDuration)

			if var_253_0 <= arg_250_1.time_ and arg_250_1.time_ < var_253_0 + var_253_10 then
				arg_250_1.typewritter.percent = (arg_250_1.time_ - var_253_0) / var_253_10

				arg_250_1.typewritter:SetDirty()
			end

			if arg_250_1.time_ >= var_253_0 + var_253_10 and arg_250_1.time_ < var_253_0 + var_253_10 + arg_253_0 then
				arg_250_1.typewritter.percent = 1

				arg_250_1.typewritter:SetDirty()
				arg_250_1:ShowNextGo(true)
			end
		end

		arg_250_1.nodeConfigList_ = {}

		arg_250_1:InitPlayNodeList()
	end,
	Play325621062 = function(arg_254_0, arg_254_1)
		arg_254_1.time_ = 0
		arg_254_1.frameCnt_ = 0
		arg_254_1.state_ = "playing"
		arg_254_1.curTalkId_ = 325621062
		arg_254_1.duration_ = 11.5

		local var_254_0 = {
			zh = 11.5,
			ja = 6.2
		}
		local var_254_1 = manager.audio:GetLocalizationFlag()

		if var_254_0[var_254_1] ~= nil then
			arg_254_1.duration_ = var_254_0[var_254_1]
		end

		SetActive(arg_254_1.tipsGo_, false)

		function arg_254_1.onSingleLineFinish_()
			arg_254_1.onSingleLineUpdate_ = nil
			arg_254_1.onSingleLineFinish_ = nil
			arg_254_1.state_ = "waiting"
		end

		function arg_254_1.playNext_(arg_256_0)
			if arg_256_0 == 1 then
				arg_254_0:Play325621063(arg_254_1)
			end
		end

		function arg_254_1.onSingleLineUpdate_(arg_257_0)
			local var_257_0 = 0
			local var_257_1 = 0.625

			if var_257_0 < arg_254_1.time_ and arg_254_1.time_ <= var_257_0 + arg_257_0 then
				arg_254_1.talkMaxDuration = 0
				arg_254_1.dialogCg_.alpha = 1

				arg_254_1.dialog_:SetActive(true)
				SetActive(arg_254_1.leftNameGo_, true)

				local var_257_2 = arg_254_1:FormatText(StoryNameCfg[1447].name)

				arg_254_1.leftNameTxt_.text = var_257_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_254_1.leftNameTxt_.transform)

				arg_254_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_254_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_254_1:RecordName(arg_254_1.leftNameTxt_.text)
				SetActive(arg_254_1.iconTrs_.gameObject, false)
				arg_254_1.callingController_:SetSelectedState("normal")

				local var_257_3 = arg_254_1:GetWordFromCfg(325621062)
				local var_257_4 = arg_254_1:FormatText(var_257_3.content)

				arg_254_1.text_.text = var_257_4

				LuaForUtil.ClearLinePrefixSymbol(arg_254_1.text_)

				local var_257_5 = 25
				local var_257_6 = utf8.len(var_257_4)
				local var_257_7 = var_257_5 <= 0 and var_257_1 or var_257_1 * (var_257_6 / var_257_5)

				if var_257_7 > 0 and var_257_1 < var_257_7 then
					arg_254_1.talkMaxDuration = var_257_7

					if var_257_7 + var_257_0 > arg_254_1.duration_ then
						arg_254_1.duration_ = var_257_7 + var_257_0
					end
				end

				arg_254_1.text_.text = var_257_4
				arg_254_1.typewritter.percent = 0

				arg_254_1.typewritter:SetDirty()
				arg_254_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_325621", "325621062", "story_v_out_325621.awb") ~= 0 then
					local var_257_8 = manager.audio:GetVoiceLength("story_v_out_325621", "325621062", "story_v_out_325621.awb") / 1000

					if var_257_8 + var_257_0 > arg_254_1.duration_ then
						arg_254_1.duration_ = var_257_8 + var_257_0
					end

					if var_257_3.prefab_name ~= "" and arg_254_1.actors_[var_257_3.prefab_name] ~= nil then
						local var_257_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_254_1.actors_[var_257_3.prefab_name].transform, "story_v_out_325621", "325621062", "story_v_out_325621.awb")

						arg_254_1:RecordAudio("325621062", var_257_9)
						arg_254_1:RecordAudio("325621062", var_257_9)
					else
						arg_254_1:AudioAction("play", "voice", "story_v_out_325621", "325621062", "story_v_out_325621.awb")
					end

					arg_254_1:RecordHistoryTalkVoice("story_v_out_325621", "325621062", "story_v_out_325621.awb")
				end

				arg_254_1:RecordContent(arg_254_1.text_.text)
			end

			local var_257_10 = math.max(var_257_1, arg_254_1.talkMaxDuration)

			if var_257_0 <= arg_254_1.time_ and arg_254_1.time_ < var_257_0 + var_257_10 then
				arg_254_1.typewritter.percent = (arg_254_1.time_ - var_257_0) / var_257_10

				arg_254_1.typewritter:SetDirty()
			end

			if arg_254_1.time_ >= var_257_0 + var_257_10 and arg_254_1.time_ < var_257_0 + var_257_10 + arg_257_0 then
				arg_254_1.typewritter.percent = 1

				arg_254_1.typewritter:SetDirty()
				arg_254_1:ShowNextGo(true)
			end
		end

		arg_254_1.nodeConfigList_ = {}

		arg_254_1:InitPlayNodeList()
	end,
	Play325621063 = function(arg_258_0, arg_258_1)
		arg_258_1.time_ = 0
		arg_258_1.frameCnt_ = 0
		arg_258_1.state_ = "playing"
		arg_258_1.curTalkId_ = 325621063
		arg_258_1.duration_ = 5

		SetActive(arg_258_1.tipsGo_, false)

		function arg_258_1.onSingleLineFinish_()
			arg_258_1.onSingleLineUpdate_ = nil
			arg_258_1.onSingleLineFinish_ = nil
			arg_258_1.state_ = "waiting"
		end

		function arg_258_1.playNext_(arg_260_0)
			if arg_260_0 == 1 then
				arg_258_0:Play325621064(arg_258_1)
			end
		end

		function arg_258_1.onSingleLineUpdate_(arg_261_0)
			local var_261_0 = arg_258_1.actors_["10167ui_story"].transform
			local var_261_1 = 0

			if var_261_1 < arg_258_1.time_ and arg_258_1.time_ <= var_261_1 + arg_261_0 then
				arg_258_1.var_.moveOldPos10167ui_story = var_261_0.localPosition

				local var_261_2 = GameObjectTools.GetOrAddComponent(var_261_0.gameObject, typeof(DynamicBoneHelper))

				if var_261_2 then
					var_261_2:EnableDynamicBone(false)
				end
			end

			local var_261_3 = 0.001

			if var_261_1 <= arg_258_1.time_ and arg_258_1.time_ < var_261_1 + var_261_3 then
				local var_261_4 = (arg_258_1.time_ - var_261_1) / var_261_3
				local var_261_5 = Vector3.New(0, 100, 0)

				var_261_0.localPosition = Vector3.Lerp(arg_258_1.var_.moveOldPos10167ui_story, var_261_5, var_261_4)

				local var_261_6 = manager.ui.mainCamera.transform.position - var_261_0.position

				var_261_0.forward = Vector3.New(var_261_6.x, var_261_6.y, var_261_6.z)

				local var_261_7 = var_261_0.localEulerAngles

				var_261_7.z = 0
				var_261_7.x = 0
				var_261_0.localEulerAngles = var_261_7
			end

			if arg_258_1.time_ >= var_261_1 + var_261_3 and arg_258_1.time_ < var_261_1 + var_261_3 + arg_261_0 then
				var_261_0.localPosition = Vector3.New(0, 100, 0)

				local var_261_8 = manager.ui.mainCamera.transform.position - var_261_0.position

				var_261_0.forward = Vector3.New(var_261_8.x, var_261_8.y, var_261_8.z)

				local var_261_9 = var_261_0.localEulerAngles

				var_261_9.z = 0
				var_261_9.x = 0
				var_261_0.localEulerAngles = var_261_9

				local var_261_10 = GameObjectTools.GetOrAddComponent(var_261_0.gameObject, typeof(DynamicBoneHelper))

				if var_261_10 then
					var_261_10:EnableDynamicBone(true)
				end
			end

			local var_261_11 = arg_258_1.actors_["10167ui_story"]
			local var_261_12 = 0

			if var_261_12 < arg_258_1.time_ and arg_258_1.time_ <= var_261_12 + arg_261_0 and not isNil(var_261_11) and arg_258_1.var_.characterEffect10167ui_story == nil then
				arg_258_1.var_.characterEffect10167ui_story = var_261_11:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_261_13 = 0.200000002980232

			if var_261_12 <= arg_258_1.time_ and arg_258_1.time_ < var_261_12 + var_261_13 and not isNil(var_261_11) then
				local var_261_14 = (arg_258_1.time_ - var_261_12) / var_261_13

				if arg_258_1.var_.characterEffect10167ui_story and not isNil(var_261_11) then
					local var_261_15 = Mathf.Lerp(0, 0.5, var_261_14)

					arg_258_1.var_.characterEffect10167ui_story.fillFlat = true
					arg_258_1.var_.characterEffect10167ui_story.fillRatio = var_261_15
				end
			end

			if arg_258_1.time_ >= var_261_12 + var_261_13 and arg_258_1.time_ < var_261_12 + var_261_13 + arg_261_0 and not isNil(var_261_11) and arg_258_1.var_.characterEffect10167ui_story then
				local var_261_16 = 0.5

				arg_258_1.var_.characterEffect10167ui_story.fillFlat = true
				arg_258_1.var_.characterEffect10167ui_story.fillRatio = var_261_16
			end

			local var_261_17 = 0.1
			local var_261_18 = 1

			if var_261_17 < arg_258_1.time_ and arg_258_1.time_ <= var_261_17 + arg_261_0 then
				local var_261_19 = "play"
				local var_261_20 = "effect"

				arg_258_1:AudioAction(var_261_19, var_261_20, "se_story_123_01", "se_story_123_01_whoosh", "")
			end

			local var_261_21 = 0
			local var_261_22 = 1.05

			if var_261_21 < arg_258_1.time_ and arg_258_1.time_ <= var_261_21 + arg_261_0 then
				arg_258_1.talkMaxDuration = 0
				arg_258_1.dialogCg_.alpha = 1

				arg_258_1.dialog_:SetActive(true)
				SetActive(arg_258_1.leftNameGo_, false)

				arg_258_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_258_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_258_1:RecordName(arg_258_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_258_1.iconTrs_.gameObject, false)
				arg_258_1.callingController_:SetSelectedState("normal")

				local var_261_23 = arg_258_1:GetWordFromCfg(325621063)
				local var_261_24 = arg_258_1:FormatText(var_261_23.content)

				arg_258_1.text_.text = var_261_24

				LuaForUtil.ClearLinePrefixSymbol(arg_258_1.text_)

				local var_261_25 = 42
				local var_261_26 = utf8.len(var_261_24)
				local var_261_27 = var_261_25 <= 0 and var_261_22 or var_261_22 * (var_261_26 / var_261_25)

				if var_261_27 > 0 and var_261_22 < var_261_27 then
					arg_258_1.talkMaxDuration = var_261_27

					if var_261_27 + var_261_21 > arg_258_1.duration_ then
						arg_258_1.duration_ = var_261_27 + var_261_21
					end
				end

				arg_258_1.text_.text = var_261_24
				arg_258_1.typewritter.percent = 0

				arg_258_1.typewritter:SetDirty()
				arg_258_1:ShowNextGo(false)
				arg_258_1:RecordContent(arg_258_1.text_.text)
			end

			local var_261_28 = math.max(var_261_22, arg_258_1.talkMaxDuration)

			if var_261_21 <= arg_258_1.time_ and arg_258_1.time_ < var_261_21 + var_261_28 then
				arg_258_1.typewritter.percent = (arg_258_1.time_ - var_261_21) / var_261_28

				arg_258_1.typewritter:SetDirty()
			end

			if arg_258_1.time_ >= var_261_21 + var_261_28 and arg_258_1.time_ < var_261_21 + var_261_28 + arg_261_0 then
				arg_258_1.typewritter.percent = 1

				arg_258_1.typewritter:SetDirty()
				arg_258_1:ShowNextGo(true)
			end
		end

		arg_258_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10167ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_258_1:InitPlayNodeList()
	end,
	Play325621064 = function(arg_262_0, arg_262_1)
		arg_262_1.time_ = 0
		arg_262_1.frameCnt_ = 0
		arg_262_1.state_ = "playing"
		arg_262_1.curTalkId_ = 325621064
		arg_262_1.duration_ = 5

		SetActive(arg_262_1.tipsGo_, false)

		function arg_262_1.onSingleLineFinish_()
			arg_262_1.onSingleLineUpdate_ = nil
			arg_262_1.onSingleLineFinish_ = nil
			arg_262_1.state_ = "waiting"
		end

		function arg_262_1.playNext_(arg_264_0)
			if arg_264_0 == 1 then
				arg_262_0:Play325621065(arg_262_1)
			end
		end

		function arg_262_1.onSingleLineUpdate_(arg_265_0)
			local var_265_0 = 0
			local var_265_1 = 1.05

			if var_265_0 < arg_262_1.time_ and arg_262_1.time_ <= var_265_0 + arg_265_0 then
				arg_262_1.talkMaxDuration = 0
				arg_262_1.dialogCg_.alpha = 1

				arg_262_1.dialog_:SetActive(true)
				SetActive(arg_262_1.leftNameGo_, false)

				arg_262_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_262_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_262_1:RecordName(arg_262_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_262_1.iconTrs_.gameObject, false)
				arg_262_1.callingController_:SetSelectedState("normal")

				local var_265_2 = arg_262_1:GetWordFromCfg(325621064)
				local var_265_3 = arg_262_1:FormatText(var_265_2.content)

				arg_262_1.text_.text = var_265_3

				LuaForUtil.ClearLinePrefixSymbol(arg_262_1.text_)

				local var_265_4 = 42
				local var_265_5 = utf8.len(var_265_3)
				local var_265_6 = var_265_4 <= 0 and var_265_1 or var_265_1 * (var_265_5 / var_265_4)

				if var_265_6 > 0 and var_265_1 < var_265_6 then
					arg_262_1.talkMaxDuration = var_265_6

					if var_265_6 + var_265_0 > arg_262_1.duration_ then
						arg_262_1.duration_ = var_265_6 + var_265_0
					end
				end

				arg_262_1.text_.text = var_265_3
				arg_262_1.typewritter.percent = 0

				arg_262_1.typewritter:SetDirty()
				arg_262_1:ShowNextGo(false)
				arg_262_1:RecordContent(arg_262_1.text_.text)
			end

			local var_265_7 = math.max(var_265_1, arg_262_1.talkMaxDuration)

			if var_265_0 <= arg_262_1.time_ and arg_262_1.time_ < var_265_0 + var_265_7 then
				arg_262_1.typewritter.percent = (arg_262_1.time_ - var_265_0) / var_265_7

				arg_262_1.typewritter:SetDirty()
			end

			if arg_262_1.time_ >= var_265_0 + var_265_7 and arg_262_1.time_ < var_265_0 + var_265_7 + arg_265_0 then
				arg_262_1.typewritter.percent = 1

				arg_262_1.typewritter:SetDirty()
				arg_262_1:ShowNextGo(true)
			end
		end

		arg_262_1.nodeConfigList_ = {}

		arg_262_1:InitPlayNodeList()
	end,
	Play325621065 = function(arg_266_0, arg_266_1)
		arg_266_1.time_ = 0
		arg_266_1.frameCnt_ = 0
		arg_266_1.state_ = "playing"
		arg_266_1.curTalkId_ = 325621065
		arg_266_1.duration_ = 9.07

		local var_266_0 = {
			zh = 8.7,
			ja = 9.066
		}
		local var_266_1 = manager.audio:GetLocalizationFlag()

		if var_266_0[var_266_1] ~= nil then
			arg_266_1.duration_ = var_266_0[var_266_1]
		end

		SetActive(arg_266_1.tipsGo_, false)

		function arg_266_1.onSingleLineFinish_()
			arg_266_1.onSingleLineUpdate_ = nil
			arg_266_1.onSingleLineFinish_ = nil
			arg_266_1.state_ = "waiting"
		end

		function arg_266_1.playNext_(arg_268_0)
			if arg_268_0 == 1 then
				arg_266_0:Play325621066(arg_266_1)
			end
		end

		function arg_266_1.onSingleLineUpdate_(arg_269_0)
			local var_269_0 = arg_266_1.actors_["10167ui_story"].transform
			local var_269_1 = 0

			if var_269_1 < arg_266_1.time_ and arg_266_1.time_ <= var_269_1 + arg_269_0 then
				arg_266_1.var_.moveOldPos10167ui_story = var_269_0.localPosition

				local var_269_2 = GameObjectTools.GetOrAddComponent(var_269_0.gameObject, typeof(DynamicBoneHelper))

				if var_269_2 then
					var_269_2:EnableDynamicBone(false)
				end
			end

			local var_269_3 = 0.001

			if var_269_1 <= arg_266_1.time_ and arg_266_1.time_ < var_269_1 + var_269_3 then
				local var_269_4 = (arg_266_1.time_ - var_269_1) / var_269_3
				local var_269_5 = Vector3.New(0, -1.28, -5.73)

				var_269_0.localPosition = Vector3.Lerp(arg_266_1.var_.moveOldPos10167ui_story, var_269_5, var_269_4)

				local var_269_6 = manager.ui.mainCamera.transform.position - var_269_0.position

				var_269_0.forward = Vector3.New(var_269_6.x, var_269_6.y, var_269_6.z)

				local var_269_7 = var_269_0.localEulerAngles

				var_269_7.z = 0
				var_269_7.x = 0
				var_269_0.localEulerAngles = var_269_7
			end

			if arg_266_1.time_ >= var_269_1 + var_269_3 and arg_266_1.time_ < var_269_1 + var_269_3 + arg_269_0 then
				var_269_0.localPosition = Vector3.New(0, -1.28, -5.73)

				local var_269_8 = manager.ui.mainCamera.transform.position - var_269_0.position

				var_269_0.forward = Vector3.New(var_269_8.x, var_269_8.y, var_269_8.z)

				local var_269_9 = var_269_0.localEulerAngles

				var_269_9.z = 0
				var_269_9.x = 0
				var_269_0.localEulerAngles = var_269_9

				local var_269_10 = GameObjectTools.GetOrAddComponent(var_269_0.gameObject, typeof(DynamicBoneHelper))

				if var_269_10 then
					var_269_10:EnableDynamicBone(true)
				end
			end

			local var_269_11 = arg_266_1.actors_["10167ui_story"]
			local var_269_12 = 0

			if var_269_12 < arg_266_1.time_ and arg_266_1.time_ <= var_269_12 + arg_269_0 and not isNil(var_269_11) and arg_266_1.var_.characterEffect10167ui_story == nil then
				arg_266_1.var_.characterEffect10167ui_story = var_269_11:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_269_13 = 0.200000002980232

			if var_269_12 <= arg_266_1.time_ and arg_266_1.time_ < var_269_12 + var_269_13 and not isNil(var_269_11) then
				local var_269_14 = (arg_266_1.time_ - var_269_12) / var_269_13

				if arg_266_1.var_.characterEffect10167ui_story and not isNil(var_269_11) then
					arg_266_1.var_.characterEffect10167ui_story.fillFlat = false
				end
			end

			if arg_266_1.time_ >= var_269_12 + var_269_13 and arg_266_1.time_ < var_269_12 + var_269_13 + arg_269_0 and not isNil(var_269_11) and arg_266_1.var_.characterEffect10167ui_story then
				arg_266_1.var_.characterEffect10167ui_story.fillFlat = false
			end

			local var_269_15 = 0

			if var_269_15 < arg_266_1.time_ and arg_266_1.time_ <= var_269_15 + arg_269_0 then
				arg_266_1:PlayTimeline("10167ui_story", "StoryTimeline/CharAction/public_expression/expr_shengqiA", "EmotionTimelineAnimator")
			end

			local var_269_16 = 0
			local var_269_17 = 0.55

			if var_269_16 < arg_266_1.time_ and arg_266_1.time_ <= var_269_16 + arg_269_0 then
				arg_266_1.talkMaxDuration = 0
				arg_266_1.dialogCg_.alpha = 1

				arg_266_1.dialog_:SetActive(true)
				SetActive(arg_266_1.leftNameGo_, true)

				local var_269_18 = arg_266_1:FormatText(StoryNameCfg[1447].name)

				arg_266_1.leftNameTxt_.text = var_269_18

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_266_1.leftNameTxt_.transform)

				arg_266_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_266_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_266_1:RecordName(arg_266_1.leftNameTxt_.text)
				SetActive(arg_266_1.iconTrs_.gameObject, false)
				arg_266_1.callingController_:SetSelectedState("normal")

				local var_269_19 = arg_266_1:GetWordFromCfg(325621065)
				local var_269_20 = arg_266_1:FormatText(var_269_19.content)

				arg_266_1.text_.text = var_269_20

				LuaForUtil.ClearLinePrefixSymbol(arg_266_1.text_)

				local var_269_21 = 22
				local var_269_22 = utf8.len(var_269_20)
				local var_269_23 = var_269_21 <= 0 and var_269_17 or var_269_17 * (var_269_22 / var_269_21)

				if var_269_23 > 0 and var_269_17 < var_269_23 then
					arg_266_1.talkMaxDuration = var_269_23

					if var_269_23 + var_269_16 > arg_266_1.duration_ then
						arg_266_1.duration_ = var_269_23 + var_269_16
					end
				end

				arg_266_1.text_.text = var_269_20
				arg_266_1.typewritter.percent = 0

				arg_266_1.typewritter:SetDirty()
				arg_266_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_325621", "325621065", "story_v_out_325621.awb") ~= 0 then
					local var_269_24 = manager.audio:GetVoiceLength("story_v_out_325621", "325621065", "story_v_out_325621.awb") / 1000

					if var_269_24 + var_269_16 > arg_266_1.duration_ then
						arg_266_1.duration_ = var_269_24 + var_269_16
					end

					if var_269_19.prefab_name ~= "" and arg_266_1.actors_[var_269_19.prefab_name] ~= nil then
						local var_269_25 = LuaForUtil.PlayVoiceWithCriLipsync(arg_266_1.actors_[var_269_19.prefab_name].transform, "story_v_out_325621", "325621065", "story_v_out_325621.awb")

						arg_266_1:RecordAudio("325621065", var_269_25)
						arg_266_1:RecordAudio("325621065", var_269_25)
					else
						arg_266_1:AudioAction("play", "voice", "story_v_out_325621", "325621065", "story_v_out_325621.awb")
					end

					arg_266_1:RecordHistoryTalkVoice("story_v_out_325621", "325621065", "story_v_out_325621.awb")
				end

				arg_266_1:RecordContent(arg_266_1.text_.text)
			end

			local var_269_26 = math.max(var_269_17, arg_266_1.talkMaxDuration)

			if var_269_16 <= arg_266_1.time_ and arg_266_1.time_ < var_269_16 + var_269_26 then
				arg_266_1.typewritter.percent = (arg_266_1.time_ - var_269_16) / var_269_26

				arg_266_1.typewritter:SetDirty()
			end

			if arg_266_1.time_ >= var_269_16 + var_269_26 and arg_266_1.time_ < var_269_16 + var_269_26 + arg_269_0 then
				arg_266_1.typewritter.percent = 1

				arg_266_1.typewritter:SetDirty()
				arg_266_1:ShowNextGo(true)
			end
		end

		arg_266_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10167ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_266_1:InitPlayNodeList()
	end,
	Play325621066 = function(arg_270_0, arg_270_1)
		arg_270_1.time_ = 0
		arg_270_1.frameCnt_ = 0
		arg_270_1.state_ = "playing"
		arg_270_1.curTalkId_ = 325621066
		arg_270_1.duration_ = 8.53

		local var_270_0 = {
			zh = 8.533,
			ja = 7.833
		}
		local var_270_1 = manager.audio:GetLocalizationFlag()

		if var_270_0[var_270_1] ~= nil then
			arg_270_1.duration_ = var_270_0[var_270_1]
		end

		SetActive(arg_270_1.tipsGo_, false)

		function arg_270_1.onSingleLineFinish_()
			arg_270_1.onSingleLineUpdate_ = nil
			arg_270_1.onSingleLineFinish_ = nil
			arg_270_1.state_ = "waiting"
			arg_270_1.auto_ = false
		end

		function arg_270_1.playNext_(arg_272_0)
			arg_270_1.onStoryFinished_()
		end

		function arg_270_1.onSingleLineUpdate_(arg_273_0)
			local var_273_0 = 0
			local var_273_1 = 1

			if var_273_0 < arg_270_1.time_ and arg_270_1.time_ <= var_273_0 + arg_273_0 then
				local var_273_2 = "play"
				local var_273_3 = "effect"

				arg_270_1:AudioAction(var_273_2, var_273_3, "ui_battle", "ui_battle_stopbgm", "")
			end

			local var_273_4 = 0
			local var_273_5 = 0.4

			if var_273_4 < arg_270_1.time_ and arg_270_1.time_ <= var_273_4 + arg_273_0 then
				arg_270_1.talkMaxDuration = 0
				arg_270_1.dialogCg_.alpha = 1

				arg_270_1.dialog_:SetActive(true)
				SetActive(arg_270_1.leftNameGo_, true)

				local var_273_6 = arg_270_1:FormatText(StoryNameCfg[1447].name)

				arg_270_1.leftNameTxt_.text = var_273_6

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_270_1.leftNameTxt_.transform)

				arg_270_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_270_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_270_1:RecordName(arg_270_1.leftNameTxt_.text)
				SetActive(arg_270_1.iconTrs_.gameObject, false)
				arg_270_1.callingController_:SetSelectedState("normal")

				local var_273_7 = arg_270_1:GetWordFromCfg(325621066)
				local var_273_8 = arg_270_1:FormatText(var_273_7.content)

				arg_270_1.text_.text = var_273_8

				LuaForUtil.ClearLinePrefixSymbol(arg_270_1.text_)

				local var_273_9 = 16
				local var_273_10 = utf8.len(var_273_8)
				local var_273_11 = var_273_9 <= 0 and var_273_5 or var_273_5 * (var_273_10 / var_273_9)

				if var_273_11 > 0 and var_273_5 < var_273_11 then
					arg_270_1.talkMaxDuration = var_273_11

					if var_273_11 + var_273_4 > arg_270_1.duration_ then
						arg_270_1.duration_ = var_273_11 + var_273_4
					end
				end

				arg_270_1.text_.text = var_273_8
				arg_270_1.typewritter.percent = 0

				arg_270_1.typewritter:SetDirty()
				arg_270_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_325621", "325621066", "story_v_out_325621.awb") ~= 0 then
					local var_273_12 = manager.audio:GetVoiceLength("story_v_out_325621", "325621066", "story_v_out_325621.awb") / 1000

					if var_273_12 + var_273_4 > arg_270_1.duration_ then
						arg_270_1.duration_ = var_273_12 + var_273_4
					end

					if var_273_7.prefab_name ~= "" and arg_270_1.actors_[var_273_7.prefab_name] ~= nil then
						local var_273_13 = LuaForUtil.PlayVoiceWithCriLipsync(arg_270_1.actors_[var_273_7.prefab_name].transform, "story_v_out_325621", "325621066", "story_v_out_325621.awb")

						arg_270_1:RecordAudio("325621066", var_273_13)
						arg_270_1:RecordAudio("325621066", var_273_13)
					else
						arg_270_1:AudioAction("play", "voice", "story_v_out_325621", "325621066", "story_v_out_325621.awb")
					end

					arg_270_1:RecordHistoryTalkVoice("story_v_out_325621", "325621066", "story_v_out_325621.awb")
				end

				arg_270_1:RecordContent(arg_270_1.text_.text)
			end

			local var_273_14 = math.max(var_273_5, arg_270_1.talkMaxDuration)

			if var_273_4 <= arg_270_1.time_ and arg_270_1.time_ < var_273_4 + var_273_14 then
				arg_270_1.typewritter.percent = (arg_270_1.time_ - var_273_4) / var_273_14

				arg_270_1.typewritter:SetDirty()
			end

			if arg_270_1.time_ >= var_273_4 + var_273_14 and arg_270_1.time_ < var_273_4 + var_273_14 + arg_273_0 then
				arg_270_1.typewritter.percent = 1

				arg_270_1.typewritter:SetDirty()
				arg_270_1:ShowNextGo(true)
			end
		end

		arg_270_1.nodeConfigList_ = {}

		arg_270_1:InitPlayNodeList()
	end,
	assets = {
		"TextureConfig/Background/ST2013",
		"TextureConfig/Background/J21h"
	},
	voices = {
		"story_v_out_325621.awb"
	}
}
