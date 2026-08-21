return {
	Play100032001 = function(arg_1_0, arg_1_1)
		arg_1_1.time_ = 0
		arg_1_1.frameCnt_ = 0
		arg_1_1.state_ = "playing"
		arg_1_1.curTalkId_ = 100032001
		arg_1_1.duration_ = 7.8

		local var_1_0 = {
			ja = 7.8,
			ko = 6.166,
			zh = 5.666,
			en = 6.933
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
				arg_1_0:Play100032002(arg_1_1)
			end
		end

		function arg_1_1.onSingleLineUpdate_(arg_4_0)
			local var_4_0 = 0
			local var_4_1 = 1

			if var_4_0 < arg_1_1.time_ and arg_1_1.time_ <= var_4_0 + arg_4_0 then
				local var_4_2 = "play"
				local var_4_3 = "music"

				arg_1_1:AudioAction(var_4_2, var_4_3, "bgm_story_v0_battleground", "bgm_story_v0_battleground", "bgm_story_v0_battleground")

				local var_4_4 = ""
				local var_4_5 = manager.audio:GetAudioName("bgm_story_v0_battleground", "bgm_story_v0_battleground")

				if var_4_5 ~= "" then
					if arg_1_1.bgmTxt_.text ~= var_4_5 and arg_1_1.bgmTxt_.text ~= "" then
						if arg_1_1.bgmTxt2_.text ~= "" then
							arg_1_1.bgmTxt_.text = arg_1_1.bgmTxt2_.text
						end

						arg_1_1.bgmTxt2_.text = var_4_5

						arg_1_1.musicChangeAnimator_:Play("music_change", 0, 0)
					else
						arg_1_1.bgmTxt_.text = var_4_5
						arg_1_1.bgmTxt2_.text = var_4_5
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

			local var_4_6 = 0
			local var_4_7 = 1

			if var_4_6 < arg_1_1.time_ and arg_1_1.time_ <= var_4_6 + arg_4_0 then
				local var_4_8 = "play"
				local var_4_9 = "effect"

				arg_1_1:AudioAction(var_4_8, var_4_9, "se_story_v0_environment_source", "se_story_v0_environment_source", "se_story_v0_environment_source")
			end

			local var_4_10 = "1084ui_story"

			if arg_1_1.actors_[var_4_10] == nil then
				local var_4_11 = Asset.Load("Char/" .. "1084ui_story")

				if not isNil(var_4_11) then
					local var_4_12 = Object.Instantiate(Asset.Load("Char/" .. "1084ui_story"), arg_1_1.stage_.transform)

					var_4_12.name = var_4_10
					var_4_12.transform.localPosition = Vector3.New(0, 100, 0)
					arg_1_1.actors_[var_4_10] = var_4_12

					local var_4_13 = var_4_12:GetComponentInChildren(typeof(CharacterEffect))

					var_4_13.enabled = true

					local var_4_14 = GameObjectTools.GetOrAddComponent(var_4_12, typeof(DynamicBoneHelper))

					if var_4_14 then
						var_4_14:EnableDynamicBone(false)
					end

					arg_1_1:ShowWeapon(var_4_13.transform, false)

					arg_1_1.var_[var_4_10 .. "Animator"] = var_4_13.gameObject:GetComponent(typeof(UnityEngine.Animator))
					arg_1_1.var_[var_4_10 .. "Animator"].applyRootMotion = true
					arg_1_1.var_[var_4_10 .. "LipSync"] = var_4_13.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
				end
			end

			local var_4_15 = arg_1_1.actors_["1084ui_story"]
			local var_4_16 = 2

			if var_4_16 < arg_1_1.time_ and arg_1_1.time_ <= var_4_16 + arg_4_0 and not isNil(var_4_15) and arg_1_1.var_.characterEffect1084ui_story == nil then
				arg_1_1.var_.characterEffect1084ui_story = var_4_15:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_4_17 = 0.1

			if var_4_16 <= arg_1_1.time_ and arg_1_1.time_ < var_4_16 + var_4_17 and not isNil(var_4_15) then
				local var_4_18 = (arg_1_1.time_ - var_4_16) / var_4_17

				if arg_1_1.var_.characterEffect1084ui_story and not isNil(var_4_15) then
					arg_1_1.var_.characterEffect1084ui_story.fillFlat = false
				end
			end

			if arg_1_1.time_ >= var_4_16 + var_4_17 and arg_1_1.time_ < var_4_16 + var_4_17 + arg_4_0 and not isNil(var_4_15) and arg_1_1.var_.characterEffect1084ui_story then
				arg_1_1.var_.characterEffect1084ui_story.fillFlat = false
			end

			local var_4_19 = "A06"

			if arg_1_1.bgs_[var_4_19] == nil then
				local var_4_20 = Object.Instantiate(arg_1_1.paintGo_)

				var_4_20:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. var_4_19)
				var_4_20.name = var_4_19
				var_4_20.transform.parent = arg_1_1.stage_.transform
				var_4_20.transform.localPosition = Vector3.New(0, 100, 0)
				arg_1_1.bgs_[var_4_19] = var_4_20
			end

			local var_4_21 = arg_1_1.bgs_.A06
			local var_4_22 = 0

			if var_4_22 < arg_1_1.time_ and arg_1_1.time_ <= var_4_22 + arg_4_0 then
				local var_4_23 = var_4_21:GetComponent("SpriteRenderer")

				if var_4_23 then
					arg_1_1.var_.alphaOldValueA06 = var_4_23.color.a
					arg_1_1.var_.alphaMatValueA06 = var_4_23
				end

				arg_1_1.var_.alphaOldValueA06 = 0
			end

			local var_4_24 = 1.5

			if var_4_22 <= arg_1_1.time_ and arg_1_1.time_ < var_4_22 + var_4_24 then
				local var_4_25 = (arg_1_1.time_ - var_4_22) / var_4_24
				local var_4_26 = Mathf.Lerp(arg_1_1.var_.alphaOldValueA06, 1, var_4_25)

				if arg_1_1.var_.alphaMatValueA06 then
					local var_4_27 = arg_1_1.var_.alphaMatValueA06.color

					var_4_27.a = var_4_26
					arg_1_1.var_.alphaMatValueA06.color = var_4_27
				end
			end

			if arg_1_1.time_ >= var_4_22 + var_4_24 and arg_1_1.time_ < var_4_22 + var_4_24 + arg_4_0 and arg_1_1.var_.alphaMatValueA06 then
				local var_4_28 = arg_1_1.var_.alphaMatValueA06
				local var_4_29 = var_4_28.color

				var_4_29.a = 1
				var_4_28.color = var_4_29
			end

			local var_4_30 = 0

			if var_4_30 < arg_1_1.time_ and arg_1_1.time_ <= var_4_30 + arg_4_0 then
				local var_4_31 = manager.ui.mainCamera.transform.localPosition
				local var_4_32 = Vector3.New(0, 0, 10) + Vector3.New(var_4_31.x, var_4_31.y, 0)
				local var_4_33 = arg_1_1.bgs_.A06

				var_4_33.transform.localPosition = var_4_32
				var_4_33.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_4_34 = var_4_33:GetComponent("SpriteRenderer")

				if var_4_34 and var_4_34.sprite then
					local var_4_35 = (var_4_33.transform.localPosition - var_4_31).z
					local var_4_36 = manager.ui.mainCameraCom_
					local var_4_37 = 2 * var_4_35 * Mathf.Tan(var_4_36.fieldOfView * 0.5 * Mathf.Deg2Rad)
					local var_4_38 = var_4_37 * var_4_36.aspect
					local var_4_39 = var_4_34.sprite.bounds.size.x
					local var_4_40 = var_4_34.sprite.bounds.size.y
					local var_4_41 = var_4_38 / var_4_39
					local var_4_42 = var_4_37 / var_4_40
					local var_4_43 = var_4_42 < var_4_41 and var_4_41 or var_4_42

					var_4_33.transform.localScale = Vector3.New(var_4_43, var_4_43, 0)
				end

				for iter_4_0, iter_4_1 in pairs(arg_1_1.bgs_) do
					if iter_4_0 ~= "A06" then
						iter_4_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_4_44 = arg_1_1.actors_["1084ui_story"].transform
			local var_4_45 = 1.79999995231628

			if var_4_45 < arg_1_1.time_ and arg_1_1.time_ <= var_4_45 + arg_4_0 then
				arg_1_1.var_.moveOldPos1084ui_story = var_4_44.localPosition
			end

			local var_4_46 = 0.001

			if var_4_45 <= arg_1_1.time_ and arg_1_1.time_ < var_4_45 + var_4_46 then
				local var_4_47 = (arg_1_1.time_ - var_4_45) / var_4_46
				local var_4_48 = Vector3.New(-0.7, -0.97, -6)

				var_4_44.localPosition = Vector3.Lerp(arg_1_1.var_.moveOldPos1084ui_story, var_4_48, var_4_47)

				local var_4_49 = manager.ui.mainCamera.transform.position - var_4_44.position

				var_4_44.forward = Vector3.New(var_4_49.x, var_4_49.y, var_4_49.z)

				local var_4_50 = var_4_44.localEulerAngles

				var_4_50.z = 0
				var_4_50.x = 0
				var_4_44.localEulerAngles = var_4_50
			end

			if arg_1_1.time_ >= var_4_45 + var_4_46 and arg_1_1.time_ < var_4_45 + var_4_46 + arg_4_0 then
				var_4_44.localPosition = Vector3.New(-0.7, -0.97, -6)

				local var_4_51 = manager.ui.mainCamera.transform.position - var_4_44.position

				var_4_44.forward = Vector3.New(var_4_51.x, var_4_51.y, var_4_51.z)

				local var_4_52 = var_4_44.localEulerAngles

				var_4_52.z = 0
				var_4_52.x = 0
				var_4_44.localEulerAngles = var_4_52
			end

			local var_4_53 = 1.79999995231628

			if var_4_53 < arg_1_1.time_ and arg_1_1.time_ <= var_4_53 + arg_4_0 then
				arg_1_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/story1084/story1084action/1084action6_1")
			end

			local var_4_54 = 0

			if var_4_54 < arg_1_1.time_ and arg_1_1.time_ <= var_4_54 + arg_4_0 then
				arg_1_1.allBtn_.enabled = false
			end

			local var_4_55 = 1.79999995231628

			if arg_1_1.time_ >= var_4_54 + var_4_55 and arg_1_1.time_ < var_4_54 + var_4_55 + arg_4_0 then
				arg_1_1.allBtn_.enabled = true
			end

			local var_4_56 = 0

			if var_4_56 < arg_1_1.time_ and arg_1_1.time_ <= var_4_56 + arg_4_0 then
				arg_1_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3204cva")
			end

			if arg_1_1.frameCnt_ <= 1 then
				arg_1_1.dialog_:SetActive(false)
			end

			local var_4_57 = 2
			local var_4_58 = 0.35

			if var_4_57 < arg_1_1.time_ and arg_1_1.time_ <= var_4_57 + arg_4_0 then
				arg_1_1.talkMaxDuration = 0

				arg_1_1.dialog_:SetActive(true)

				arg_1_1.dialogCg_.alpha = 0

				local var_4_59 = LeanTween.value(arg_1_1.dialog_, 0, 1, 0.3)

				var_4_59:setOnUpdate(LuaHelper.FloatAction(function(arg_6_0)
					arg_1_1.dialogCg_.alpha = arg_6_0
				end))
				var_4_59:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_1_1.dialog_)
					var_4_59:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_1_1.duration_ = arg_1_1.duration_ + 0.3

				SetActive(arg_1_1.leftNameGo_, true)

				local var_4_60 = arg_1_1:FormatText(StoryNameCfg[6].name)

				arg_1_1.leftNameTxt_.text = var_4_60

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_1_1.leftNameTxt_.transform)

				arg_1_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_1_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_1_1:RecordName(arg_1_1.leftNameTxt_.text)
				SetActive(arg_1_1.iconTrs_.gameObject, false)
				arg_1_1.callingController_:SetSelectedState("normal")

				local var_4_61 = arg_1_1:GetWordFromCfg(100032001)
				local var_4_62 = arg_1_1:FormatText(var_4_61.content)

				arg_1_1.text_.text = var_4_62

				LuaForUtil.ClearLinePrefixSymbol(arg_1_1.text_)

				local var_4_63 = 14
				local var_4_64 = utf8.len(var_4_62)
				local var_4_65 = var_4_63 <= 0 and var_4_58 or var_4_58 * (var_4_64 / var_4_63)

				if var_4_65 > 0 and var_4_58 < var_4_65 then
					arg_1_1.talkMaxDuration = var_4_65
					var_4_57 = var_4_57 + 0.3

					if var_4_65 + var_4_57 > arg_1_1.duration_ then
						arg_1_1.duration_ = var_4_65 + var_4_57
					end
				end

				arg_1_1.text_.text = var_4_62
				arg_1_1.typewritter.percent = 0

				arg_1_1.typewritter:SetDirty()
				arg_1_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_100032", "100032001", "story_v_out_100032.awb") ~= 0 then
					local var_4_66 = manager.audio:GetVoiceLength("story_v_out_100032", "100032001", "story_v_out_100032.awb") / 1000

					if var_4_66 + var_4_57 > arg_1_1.duration_ then
						arg_1_1.duration_ = var_4_66 + var_4_57
					end

					if var_4_61.prefab_name ~= "" and arg_1_1.actors_[var_4_61.prefab_name] ~= nil then
						local var_4_67 = LuaForUtil.PlayVoiceWithCriLipsync(arg_1_1.actors_[var_4_61.prefab_name].transform, "story_v_out_100032", "100032001", "story_v_out_100032.awb")

						arg_1_1:RecordAudio("100032001", var_4_67)
						arg_1_1:RecordAudio("100032001", var_4_67)
					else
						arg_1_1:AudioAction("play", "voice", "story_v_out_100032", "100032001", "story_v_out_100032.awb")
					end

					arg_1_1:RecordHistoryTalkVoice("story_v_out_100032", "100032001", "story_v_out_100032.awb")
				end

				arg_1_1:RecordContent(arg_1_1.text_.text)
			end

			local var_4_68 = var_4_57 + 0.3
			local var_4_69 = math.max(var_4_58, arg_1_1.talkMaxDuration)

			if var_4_68 <= arg_1_1.time_ and arg_1_1.time_ < var_4_68 + var_4_69 then
				arg_1_1.typewritter.percent = (arg_1_1.time_ - var_4_68) / var_4_69

				arg_1_1.typewritter:SetDirty()
			end

			if arg_1_1.time_ >= var_4_68 + var_4_69 and arg_1_1.time_ < var_4_68 + var_4_69 + arg_4_0 then
				arg_1_1.typewritter.percent = 1

				arg_1_1.typewritter:SetDirty()
				arg_1_1:ShowNextGo(true)
			end
		end

		arg_1_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1084ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.033,
				className = "StoryMoveNode",
				startTime = 1.79999995231628,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_1_1:InitPlayNodeList()
	end,
	Play100032002 = function(arg_8_0, arg_8_1)
		arg_8_1.time_ = 0
		arg_8_1.frameCnt_ = 0
		arg_8_1.state_ = "playing"
		arg_8_1.curTalkId_ = 100032002
		arg_8_1.duration_ = 11.97

		local var_8_0 = {
			ja = 11.966,
			ko = 7.4,
			zh = 6.333,
			en = 10.066
		}
		local var_8_1 = manager.audio:GetLocalizationFlag()

		if var_8_0[var_8_1] ~= nil then
			arg_8_1.duration_ = var_8_0[var_8_1]
		end

		SetActive(arg_8_1.tipsGo_, false)

		function arg_8_1.onSingleLineFinish_()
			arg_8_1.onSingleLineUpdate_ = nil
			arg_8_1.onSingleLineFinish_ = nil
			arg_8_1.state_ = "waiting"
		end

		function arg_8_1.playNext_(arg_10_0)
			if arg_10_0 == 1 then
				arg_8_0:Play100032003(arg_8_1)
			end
		end

		function arg_8_1.onSingleLineUpdate_(arg_11_0)
			local var_11_0 = "1148ui_story"

			if arg_8_1.actors_[var_11_0] == nil then
				local var_11_1 = Asset.Load("Char/" .. "1148ui_story")

				if not isNil(var_11_1) then
					local var_11_2 = Object.Instantiate(Asset.Load("Char/" .. "1148ui_story"), arg_8_1.stage_.transform)

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

			local var_11_5 = arg_8_1.actors_["1148ui_story"]
			local var_11_6 = 0

			if var_11_6 < arg_8_1.time_ and arg_8_1.time_ <= var_11_6 + arg_11_0 and not isNil(var_11_5) and arg_8_1.var_.characterEffect1148ui_story == nil then
				arg_8_1.var_.characterEffect1148ui_story = var_11_5:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_11_7 = 0.1

			if var_11_6 <= arg_8_1.time_ and arg_8_1.time_ < var_11_6 + var_11_7 and not isNil(var_11_5) then
				local var_11_8 = (arg_8_1.time_ - var_11_6) / var_11_7

				if arg_8_1.var_.characterEffect1148ui_story and not isNil(var_11_5) then
					arg_8_1.var_.characterEffect1148ui_story.fillFlat = false
				end
			end

			if arg_8_1.time_ >= var_11_6 + var_11_7 and arg_8_1.time_ < var_11_6 + var_11_7 + arg_11_0 and not isNil(var_11_5) and arg_8_1.var_.characterEffect1148ui_story then
				arg_8_1.var_.characterEffect1148ui_story.fillFlat = false
			end

			local var_11_9 = arg_8_1.actors_["1084ui_story"]
			local var_11_10 = 0

			if var_11_10 < arg_8_1.time_ and arg_8_1.time_ <= var_11_10 + arg_11_0 and not isNil(var_11_9) and arg_8_1.var_.characterEffect1084ui_story == nil then
				arg_8_1.var_.characterEffect1084ui_story = var_11_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_11_11 = 0.1

			if var_11_10 <= arg_8_1.time_ and arg_8_1.time_ < var_11_10 + var_11_11 and not isNil(var_11_9) then
				local var_11_12 = (arg_8_1.time_ - var_11_10) / var_11_11

				if arg_8_1.var_.characterEffect1084ui_story and not isNil(var_11_9) then
					local var_11_13 = Mathf.Lerp(0, 0.5, var_11_12)

					arg_8_1.var_.characterEffect1084ui_story.fillFlat = true
					arg_8_1.var_.characterEffect1084ui_story.fillRatio = var_11_13
				end
			end

			if arg_8_1.time_ >= var_11_10 + var_11_11 and arg_8_1.time_ < var_11_10 + var_11_11 + arg_11_0 and not isNil(var_11_9) and arg_8_1.var_.characterEffect1084ui_story then
				local var_11_14 = 0.5

				arg_8_1.var_.characterEffect1084ui_story.fillFlat = true
				arg_8_1.var_.characterEffect1084ui_story.fillRatio = var_11_14
			end

			local var_11_15 = arg_8_1.actors_["1148ui_story"].transform
			local var_11_16 = 0

			if var_11_16 < arg_8_1.time_ and arg_8_1.time_ <= var_11_16 + arg_11_0 then
				arg_8_1.var_.moveOldPos1148ui_story = var_11_15.localPosition
			end

			local var_11_17 = 0.001

			if var_11_16 <= arg_8_1.time_ and arg_8_1.time_ < var_11_16 + var_11_17 then
				local var_11_18 = (arg_8_1.time_ - var_11_16) / var_11_17
				local var_11_19 = Vector3.New(0.7, -0.8, -6.2)

				var_11_15.localPosition = Vector3.Lerp(arg_8_1.var_.moveOldPos1148ui_story, var_11_19, var_11_18)

				local var_11_20 = manager.ui.mainCamera.transform.position - var_11_15.position

				var_11_15.forward = Vector3.New(var_11_20.x, var_11_20.y, var_11_20.z)

				local var_11_21 = var_11_15.localEulerAngles

				var_11_21.z = 0
				var_11_21.x = 0
				var_11_15.localEulerAngles = var_11_21
			end

			if arg_8_1.time_ >= var_11_16 + var_11_17 and arg_8_1.time_ < var_11_16 + var_11_17 + arg_11_0 then
				var_11_15.localPosition = Vector3.New(0.7, -0.8, -6.2)

				local var_11_22 = manager.ui.mainCamera.transform.position - var_11_15.position

				var_11_15.forward = Vector3.New(var_11_22.x, var_11_22.y, var_11_22.z)

				local var_11_23 = var_11_15.localEulerAngles

				var_11_23.z = 0
				var_11_23.x = 0
				var_11_15.localEulerAngles = var_11_23
			end

			local var_11_24 = 0

			if var_11_24 < arg_8_1.time_ and arg_8_1.time_ <= var_11_24 + arg_11_0 then
				arg_8_1:PlayTimeline("1148ui_story", "StoryTimeline/CharAction/story1148/story1148action/1148action4_1")
			end

			local var_11_25 = 0

			if var_11_25 < arg_8_1.time_ and arg_8_1.time_ <= var_11_25 + arg_11_0 then
				arg_8_1:PlayTimeline("1148ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0104cva")
			end

			local var_11_26 = 0
			local var_11_27 = 0.875

			if var_11_26 < arg_8_1.time_ and arg_8_1.time_ <= var_11_26 + arg_11_0 then
				arg_8_1.talkMaxDuration = 0
				arg_8_1.dialogCg_.alpha = 1

				arg_8_1.dialog_:SetActive(true)
				SetActive(arg_8_1.leftNameGo_, true)

				local var_11_28 = arg_8_1:FormatText(StoryNameCfg[8].name)

				arg_8_1.leftNameTxt_.text = var_11_28

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_8_1.leftNameTxt_.transform)

				arg_8_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_8_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_8_1:RecordName(arg_8_1.leftNameTxt_.text)
				SetActive(arg_8_1.iconTrs_.gameObject, false)
				arg_8_1.callingController_:SetSelectedState("normal")

				local var_11_29 = arg_8_1:GetWordFromCfg(100032002)
				local var_11_30 = arg_8_1:FormatText(var_11_29.content)

				arg_8_1.text_.text = var_11_30

				LuaForUtil.ClearLinePrefixSymbol(arg_8_1.text_)

				local var_11_31 = 35
				local var_11_32 = utf8.len(var_11_30)
				local var_11_33 = var_11_31 <= 0 and var_11_27 or var_11_27 * (var_11_32 / var_11_31)

				if var_11_33 > 0 and var_11_27 < var_11_33 then
					arg_8_1.talkMaxDuration = var_11_33

					if var_11_33 + var_11_26 > arg_8_1.duration_ then
						arg_8_1.duration_ = var_11_33 + var_11_26
					end
				end

				arg_8_1.text_.text = var_11_30
				arg_8_1.typewritter.percent = 0

				arg_8_1.typewritter:SetDirty()
				arg_8_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_100032", "100032002", "story_v_out_100032.awb") ~= 0 then
					local var_11_34 = manager.audio:GetVoiceLength("story_v_out_100032", "100032002", "story_v_out_100032.awb") / 1000

					if var_11_34 + var_11_26 > arg_8_1.duration_ then
						arg_8_1.duration_ = var_11_34 + var_11_26
					end

					if var_11_29.prefab_name ~= "" and arg_8_1.actors_[var_11_29.prefab_name] ~= nil then
						local var_11_35 = LuaForUtil.PlayVoiceWithCriLipsync(arg_8_1.actors_[var_11_29.prefab_name].transform, "story_v_out_100032", "100032002", "story_v_out_100032.awb")

						arg_8_1:RecordAudio("100032002", var_11_35)
						arg_8_1:RecordAudio("100032002", var_11_35)
					else
						arg_8_1:AudioAction("play", "voice", "story_v_out_100032", "100032002", "story_v_out_100032.awb")
					end

					arg_8_1:RecordHistoryTalkVoice("story_v_out_100032", "100032002", "story_v_out_100032.awb")
				end

				arg_8_1:RecordContent(arg_8_1.text_.text)
			end

			local var_11_36 = math.max(var_11_27, arg_8_1.talkMaxDuration)

			if var_11_26 <= arg_8_1.time_ and arg_8_1.time_ < var_11_26 + var_11_36 then
				arg_8_1.typewritter.percent = (arg_8_1.time_ - var_11_26) / var_11_36

				arg_8_1.typewritter:SetDirty()
			end

			if arg_8_1.time_ >= var_11_26 + var_11_36 and arg_8_1.time_ < var_11_26 + var_11_36 + arg_11_0 then
				arg_8_1.typewritter.percent = 1

				arg_8_1.typewritter:SetDirty()
				arg_8_1:ShowNextGo(true)
			end
		end

		arg_8_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1148ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.033,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_8_1:InitPlayNodeList()
	end,
	Play100032003 = function(arg_12_0, arg_12_1)
		arg_12_1.time_ = 0
		arg_12_1.frameCnt_ = 0
		arg_12_1.state_ = "playing"
		arg_12_1.curTalkId_ = 100032003
		arg_12_1.duration_ = 5.13

		local var_12_0 = {
			ja = 4.333,
			ko = 5.133,
			zh = 4.3,
			en = 4.066
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
				arg_12_0:Play100032004(arg_12_1)
			end
		end

		function arg_12_1.onSingleLineUpdate_(arg_15_0)
			local var_15_0 = arg_12_1.actors_["1084ui_story"]
			local var_15_1 = 0

			if var_15_1 < arg_12_1.time_ and arg_12_1.time_ <= var_15_1 + arg_15_0 and not isNil(var_15_0) and arg_12_1.var_.characterEffect1084ui_story == nil then
				arg_12_1.var_.characterEffect1084ui_story = var_15_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_15_2 = 0.1

			if var_15_1 <= arg_12_1.time_ and arg_12_1.time_ < var_15_1 + var_15_2 and not isNil(var_15_0) then
				local var_15_3 = (arg_12_1.time_ - var_15_1) / var_15_2

				if arg_12_1.var_.characterEffect1084ui_story and not isNil(var_15_0) then
					arg_12_1.var_.characterEffect1084ui_story.fillFlat = false
				end
			end

			if arg_12_1.time_ >= var_15_1 + var_15_2 and arg_12_1.time_ < var_15_1 + var_15_2 + arg_15_0 and not isNil(var_15_0) and arg_12_1.var_.characterEffect1084ui_story then
				arg_12_1.var_.characterEffect1084ui_story.fillFlat = false
			end

			local var_15_4 = arg_12_1.actors_["1148ui_story"]
			local var_15_5 = 0

			if var_15_5 < arg_12_1.time_ and arg_12_1.time_ <= var_15_5 + arg_15_0 and not isNil(var_15_4) and arg_12_1.var_.characterEffect1148ui_story == nil then
				arg_12_1.var_.characterEffect1148ui_story = var_15_4:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_15_6 = 0.1

			if var_15_5 <= arg_12_1.time_ and arg_12_1.time_ < var_15_5 + var_15_6 and not isNil(var_15_4) then
				local var_15_7 = (arg_12_1.time_ - var_15_5) / var_15_6

				if arg_12_1.var_.characterEffect1148ui_story and not isNil(var_15_4) then
					local var_15_8 = Mathf.Lerp(0, 0.5, var_15_7)

					arg_12_1.var_.characterEffect1148ui_story.fillFlat = true
					arg_12_1.var_.characterEffect1148ui_story.fillRatio = var_15_8
				end
			end

			if arg_12_1.time_ >= var_15_5 + var_15_6 and arg_12_1.time_ < var_15_5 + var_15_6 + arg_15_0 and not isNil(var_15_4) and arg_12_1.var_.characterEffect1148ui_story then
				local var_15_9 = 0.5

				arg_12_1.var_.characterEffect1148ui_story.fillFlat = true
				arg_12_1.var_.characterEffect1148ui_story.fillRatio = var_15_9
			end

			local var_15_10 = 0

			if var_15_10 < arg_12_1.time_ and arg_12_1.time_ <= var_15_10 + arg_15_0 then
				arg_12_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/story1084/story1084actionlink/1084action465")
			end

			local var_15_11 = 0

			if var_15_11 < arg_12_1.time_ and arg_12_1.time_ <= var_15_11 + arg_15_0 then
				arg_12_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1204cva")
			end

			local var_15_12 = 0
			local var_15_13 = 0.425

			if var_15_12 < arg_12_1.time_ and arg_12_1.time_ <= var_15_12 + arg_15_0 then
				arg_12_1.talkMaxDuration = 0
				arg_12_1.dialogCg_.alpha = 1

				arg_12_1.dialog_:SetActive(true)
				SetActive(arg_12_1.leftNameGo_, true)

				local var_15_14 = arg_12_1:FormatText(StoryNameCfg[6].name)

				arg_12_1.leftNameTxt_.text = var_15_14

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_12_1.leftNameTxt_.transform)

				arg_12_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_12_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_12_1:RecordName(arg_12_1.leftNameTxt_.text)
				SetActive(arg_12_1.iconTrs_.gameObject, false)
				arg_12_1.callingController_:SetSelectedState("normal")

				local var_15_15 = arg_12_1:GetWordFromCfg(100032003)
				local var_15_16 = arg_12_1:FormatText(var_15_15.content)

				arg_12_1.text_.text = var_15_16

				LuaForUtil.ClearLinePrefixSymbol(arg_12_1.text_)

				local var_15_17 = 17
				local var_15_18 = utf8.len(var_15_16)
				local var_15_19 = var_15_17 <= 0 and var_15_13 or var_15_13 * (var_15_18 / var_15_17)

				if var_15_19 > 0 and var_15_13 < var_15_19 then
					arg_12_1.talkMaxDuration = var_15_19

					if var_15_19 + var_15_12 > arg_12_1.duration_ then
						arg_12_1.duration_ = var_15_19 + var_15_12
					end
				end

				arg_12_1.text_.text = var_15_16
				arg_12_1.typewritter.percent = 0

				arg_12_1.typewritter:SetDirty()
				arg_12_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_100032", "100032003", "story_v_out_100032.awb") ~= 0 then
					local var_15_20 = manager.audio:GetVoiceLength("story_v_out_100032", "100032003", "story_v_out_100032.awb") / 1000

					if var_15_20 + var_15_12 > arg_12_1.duration_ then
						arg_12_1.duration_ = var_15_20 + var_15_12
					end

					if var_15_15.prefab_name ~= "" and arg_12_1.actors_[var_15_15.prefab_name] ~= nil then
						local var_15_21 = LuaForUtil.PlayVoiceWithCriLipsync(arg_12_1.actors_[var_15_15.prefab_name].transform, "story_v_out_100032", "100032003", "story_v_out_100032.awb")

						arg_12_1:RecordAudio("100032003", var_15_21)
						arg_12_1:RecordAudio("100032003", var_15_21)
					else
						arg_12_1:AudioAction("play", "voice", "story_v_out_100032", "100032003", "story_v_out_100032.awb")
					end

					arg_12_1:RecordHistoryTalkVoice("story_v_out_100032", "100032003", "story_v_out_100032.awb")
				end

				arg_12_1:RecordContent(arg_12_1.text_.text)
			end

			local var_15_22 = math.max(var_15_13, arg_12_1.talkMaxDuration)

			if var_15_12 <= arg_12_1.time_ and arg_12_1.time_ < var_15_12 + var_15_22 then
				arg_12_1.typewritter.percent = (arg_12_1.time_ - var_15_12) / var_15_22

				arg_12_1.typewritter:SetDirty()
			end

			if arg_12_1.time_ >= var_15_12 + var_15_22 and arg_12_1.time_ < var_15_12 + var_15_22 + arg_15_0 then
				arg_12_1.typewritter.percent = 1

				arg_12_1.typewritter:SetDirty()
				arg_12_1:ShowNextGo(true)
			end
		end

		arg_12_1.nodeConfigList_ = {}

		arg_12_1:InitPlayNodeList()
	end,
	Play100032004 = function(arg_16_0, arg_16_1)
		arg_16_1.time_ = 0
		arg_16_1.frameCnt_ = 0
		arg_16_1.state_ = "playing"
		arg_16_1.curTalkId_ = 100032004
		arg_16_1.duration_ = 4.6

		local var_16_0 = {
			ja = 3.166,
			ko = 3.766,
			zh = 4.6,
			en = 4.233
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
				arg_16_0:Play100032005(arg_16_1)
			end
		end

		function arg_16_1.onSingleLineUpdate_(arg_19_0)
			local var_19_0 = arg_16_1.actors_["1148ui_story"]
			local var_19_1 = 0

			if var_19_1 < arg_16_1.time_ and arg_16_1.time_ <= var_19_1 + arg_19_0 and not isNil(var_19_0) and arg_16_1.var_.characterEffect1148ui_story == nil then
				arg_16_1.var_.characterEffect1148ui_story = var_19_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_19_2 = 0.1

			if var_19_1 <= arg_16_1.time_ and arg_16_1.time_ < var_19_1 + var_19_2 and not isNil(var_19_0) then
				local var_19_3 = (arg_16_1.time_ - var_19_1) / var_19_2

				if arg_16_1.var_.characterEffect1148ui_story and not isNil(var_19_0) then
					arg_16_1.var_.characterEffect1148ui_story.fillFlat = false
				end
			end

			if arg_16_1.time_ >= var_19_1 + var_19_2 and arg_16_1.time_ < var_19_1 + var_19_2 + arg_19_0 and not isNil(var_19_0) and arg_16_1.var_.characterEffect1148ui_story then
				arg_16_1.var_.characterEffect1148ui_story.fillFlat = false
			end

			local var_19_4 = arg_16_1.actors_["1084ui_story"]
			local var_19_5 = 0

			if var_19_5 < arg_16_1.time_ and arg_16_1.time_ <= var_19_5 + arg_19_0 and not isNil(var_19_4) and arg_16_1.var_.characterEffect1084ui_story == nil then
				arg_16_1.var_.characterEffect1084ui_story = var_19_4:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_19_6 = 0.1

			if var_19_5 <= arg_16_1.time_ and arg_16_1.time_ < var_19_5 + var_19_6 and not isNil(var_19_4) then
				local var_19_7 = (arg_16_1.time_ - var_19_5) / var_19_6

				if arg_16_1.var_.characterEffect1084ui_story and not isNil(var_19_4) then
					local var_19_8 = Mathf.Lerp(0, 0.5, var_19_7)

					arg_16_1.var_.characterEffect1084ui_story.fillFlat = true
					arg_16_1.var_.characterEffect1084ui_story.fillRatio = var_19_8
				end
			end

			if arg_16_1.time_ >= var_19_5 + var_19_6 and arg_16_1.time_ < var_19_5 + var_19_6 + arg_19_0 and not isNil(var_19_4) and arg_16_1.var_.characterEffect1084ui_story then
				local var_19_9 = 0.5

				arg_16_1.var_.characterEffect1084ui_story.fillFlat = true
				arg_16_1.var_.characterEffect1084ui_story.fillRatio = var_19_9
			end

			local var_19_10 = 0

			if var_19_10 < arg_16_1.time_ and arg_16_1.time_ <= var_19_10 + arg_19_0 then
				arg_16_1:PlayTimeline("1148ui_story", "StoryTimeline/CharAction/story1148/story1148actionlink/1148action442")
			end

			local var_19_11 = 0

			if var_19_11 < arg_16_1.time_ and arg_16_1.time_ <= var_19_11 + arg_19_0 then
				arg_16_1:PlayTimeline("1148ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1204cva")
			end

			local var_19_12 = 0
			local var_19_13 = 0.525

			if var_19_12 < arg_16_1.time_ and arg_16_1.time_ <= var_19_12 + arg_19_0 then
				arg_16_1.talkMaxDuration = 0
				arg_16_1.dialogCg_.alpha = 1

				arg_16_1.dialog_:SetActive(true)
				SetActive(arg_16_1.leftNameGo_, true)

				local var_19_14 = arg_16_1:FormatText(StoryNameCfg[8].name)

				arg_16_1.leftNameTxt_.text = var_19_14

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_16_1.leftNameTxt_.transform)

				arg_16_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_16_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_16_1:RecordName(arg_16_1.leftNameTxt_.text)
				SetActive(arg_16_1.iconTrs_.gameObject, false)
				arg_16_1.callingController_:SetSelectedState("normal")

				local var_19_15 = arg_16_1:GetWordFromCfg(100032004)
				local var_19_16 = arg_16_1:FormatText(var_19_15.content)

				arg_16_1.text_.text = var_19_16

				LuaForUtil.ClearLinePrefixSymbol(arg_16_1.text_)

				local var_19_17 = 20
				local var_19_18 = utf8.len(var_19_16)
				local var_19_19 = var_19_17 <= 0 and var_19_13 or var_19_13 * (var_19_18 / var_19_17)

				if var_19_19 > 0 and var_19_13 < var_19_19 then
					arg_16_1.talkMaxDuration = var_19_19

					if var_19_19 + var_19_12 > arg_16_1.duration_ then
						arg_16_1.duration_ = var_19_19 + var_19_12
					end
				end

				arg_16_1.text_.text = var_19_16
				arg_16_1.typewritter.percent = 0

				arg_16_1.typewritter:SetDirty()
				arg_16_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_100032", "100032004", "story_v_out_100032.awb") ~= 0 then
					local var_19_20 = manager.audio:GetVoiceLength("story_v_out_100032", "100032004", "story_v_out_100032.awb") / 1000

					if var_19_20 + var_19_12 > arg_16_1.duration_ then
						arg_16_1.duration_ = var_19_20 + var_19_12
					end

					if var_19_15.prefab_name ~= "" and arg_16_1.actors_[var_19_15.prefab_name] ~= nil then
						local var_19_21 = LuaForUtil.PlayVoiceWithCriLipsync(arg_16_1.actors_[var_19_15.prefab_name].transform, "story_v_out_100032", "100032004", "story_v_out_100032.awb")

						arg_16_1:RecordAudio("100032004", var_19_21)
						arg_16_1:RecordAudio("100032004", var_19_21)
					else
						arg_16_1:AudioAction("play", "voice", "story_v_out_100032", "100032004", "story_v_out_100032.awb")
					end

					arg_16_1:RecordHistoryTalkVoice("story_v_out_100032", "100032004", "story_v_out_100032.awb")
				end

				arg_16_1:RecordContent(arg_16_1.text_.text)
			end

			local var_19_22 = math.max(var_19_13, arg_16_1.talkMaxDuration)

			if var_19_12 <= arg_16_1.time_ and arg_16_1.time_ < var_19_12 + var_19_22 then
				arg_16_1.typewritter.percent = (arg_16_1.time_ - var_19_12) / var_19_22

				arg_16_1.typewritter:SetDirty()
			end

			if arg_16_1.time_ >= var_19_12 + var_19_22 and arg_16_1.time_ < var_19_12 + var_19_22 + arg_19_0 then
				arg_16_1.typewritter.percent = 1

				arg_16_1.typewritter:SetDirty()
				arg_16_1:ShowNextGo(true)
			end
		end

		arg_16_1.nodeConfigList_ = {}

		arg_16_1:InitPlayNodeList()
	end,
	Play100032005 = function(arg_20_0, arg_20_1)
		arg_20_1.time_ = 0
		arg_20_1.frameCnt_ = 0
		arg_20_1.state_ = "playing"
		arg_20_1.curTalkId_ = 100032005
		arg_20_1.duration_ = 6.1

		local var_20_0 = {
			ja = 6.1,
			ko = 4.3,
			zh = 3.466,
			en = 6.033
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
				arg_20_0:Play100032006(arg_20_1)
			end
		end

		function arg_20_1.onSingleLineUpdate_(arg_23_0)
			local var_23_0 = arg_20_1.actors_["1148ui_story"]
			local var_23_1 = 0

			if var_23_1 < arg_20_1.time_ and arg_20_1.time_ <= var_23_1 + arg_23_0 and not isNil(var_23_0) and arg_20_1.var_.characterEffect1148ui_story == nil then
				arg_20_1.var_.characterEffect1148ui_story = var_23_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_23_2 = 0.1

			if var_23_1 <= arg_20_1.time_ and arg_20_1.time_ < var_23_1 + var_23_2 and not isNil(var_23_0) then
				local var_23_3 = (arg_20_1.time_ - var_23_1) / var_23_2

				if arg_20_1.var_.characterEffect1148ui_story and not isNil(var_23_0) then
					local var_23_4 = Mathf.Lerp(0, 0.5, var_23_3)

					arg_20_1.var_.characterEffect1148ui_story.fillFlat = true
					arg_20_1.var_.characterEffect1148ui_story.fillRatio = var_23_4
				end
			end

			if arg_20_1.time_ >= var_23_1 + var_23_2 and arg_20_1.time_ < var_23_1 + var_23_2 + arg_23_0 and not isNil(var_23_0) and arg_20_1.var_.characterEffect1148ui_story then
				local var_23_5 = 0.5

				arg_20_1.var_.characterEffect1148ui_story.fillFlat = true
				arg_20_1.var_.characterEffect1148ui_story.fillRatio = var_23_5
			end

			local var_23_6 = 0
			local var_23_7 = 0.55

			if var_23_6 < arg_20_1.time_ and arg_20_1.time_ <= var_23_6 + arg_23_0 then
				arg_20_1.talkMaxDuration = 0
				arg_20_1.dialogCg_.alpha = 1

				arg_20_1.dialog_:SetActive(true)
				SetActive(arg_20_1.leftNameGo_, true)

				local var_23_8 = arg_20_1:FormatText(StoryNameCfg[5].name)

				arg_20_1.leftNameTxt_.text = var_23_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_20_1.leftNameTxt_.transform)

				arg_20_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_20_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_20_1:RecordName(arg_20_1.leftNameTxt_.text)
				SetActive(arg_20_1.iconTrs_.gameObject, true)
				arg_20_1.iconController_:SetSelectedState("hero")

				arg_20_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_1036")

				arg_20_1.callingController_:SetSelectedState("normal")

				arg_20_1.keyicon_.color = Color.New(1, 1, 1)
				arg_20_1.icon_.color = Color.New(1, 1, 1)

				local var_23_9 = arg_20_1:GetWordFromCfg(100032005)
				local var_23_10 = arg_20_1:FormatText(var_23_9.content)

				arg_20_1.text_.text = var_23_10

				LuaForUtil.ClearLinePrefixSymbol(arg_20_1.text_)

				local var_23_11 = 20
				local var_23_12 = utf8.len(var_23_10)
				local var_23_13 = var_23_11 <= 0 and var_23_7 or var_23_7 * (var_23_12 / var_23_11)

				if var_23_13 > 0 and var_23_7 < var_23_13 then
					arg_20_1.talkMaxDuration = var_23_13

					if var_23_13 + var_23_6 > arg_20_1.duration_ then
						arg_20_1.duration_ = var_23_13 + var_23_6
					end
				end

				arg_20_1.text_.text = var_23_10
				arg_20_1.typewritter.percent = 0

				arg_20_1.typewritter:SetDirty()
				arg_20_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_100032", "100032005", "story_v_out_100032.awb") ~= 0 then
					local var_23_14 = manager.audio:GetVoiceLength("story_v_out_100032", "100032005", "story_v_out_100032.awb") / 1000

					if var_23_14 + var_23_6 > arg_20_1.duration_ then
						arg_20_1.duration_ = var_23_14 + var_23_6
					end

					if var_23_9.prefab_name ~= "" and arg_20_1.actors_[var_23_9.prefab_name] ~= nil then
						local var_23_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_20_1.actors_[var_23_9.prefab_name].transform, "story_v_out_100032", "100032005", "story_v_out_100032.awb")

						arg_20_1:RecordAudio("100032005", var_23_15)
						arg_20_1:RecordAudio("100032005", var_23_15)
					else
						arg_20_1:AudioAction("play", "voice", "story_v_out_100032", "100032005", "story_v_out_100032.awb")
					end

					arg_20_1:RecordHistoryTalkVoice("story_v_out_100032", "100032005", "story_v_out_100032.awb")
				end

				arg_20_1:RecordContent(arg_20_1.text_.text)
			end

			local var_23_16 = math.max(var_23_7, arg_20_1.talkMaxDuration)

			if var_23_6 <= arg_20_1.time_ and arg_20_1.time_ < var_23_6 + var_23_16 then
				arg_20_1.typewritter.percent = (arg_20_1.time_ - var_23_6) / var_23_16

				arg_20_1.typewritter:SetDirty()
			end

			if arg_20_1.time_ >= var_23_6 + var_23_16 and arg_20_1.time_ < var_23_6 + var_23_16 + arg_23_0 then
				arg_20_1.typewritter.percent = 1

				arg_20_1.typewritter:SetDirty()
				arg_20_1:ShowNextGo(true)
			end
		end

		arg_20_1.nodeConfigList_ = {}

		arg_20_1:InitPlayNodeList()
	end,
	Play100032006 = function(arg_24_0, arg_24_1)
		arg_24_1.time_ = 0
		arg_24_1.frameCnt_ = 0
		arg_24_1.state_ = "playing"
		arg_24_1.curTalkId_ = 100032006
		arg_24_1.duration_ = 2

		SetActive(arg_24_1.tipsGo_, false)

		function arg_24_1.onSingleLineFinish_()
			arg_24_1.onSingleLineUpdate_ = nil
			arg_24_1.onSingleLineFinish_ = nil
			arg_24_1.state_ = "waiting"
		end

		function arg_24_1.playNext_(arg_26_0)
			if arg_26_0 == 1 then
				arg_24_0:Play100032007(arg_24_1)
			end
		end

		function arg_24_1.onSingleLineUpdate_(arg_27_0)
			local var_27_0 = arg_24_1.actors_["1148ui_story"]
			local var_27_1 = 0

			if var_27_1 < arg_24_1.time_ and arg_24_1.time_ <= var_27_1 + arg_27_0 and not isNil(var_27_0) and arg_24_1.var_.characterEffect1148ui_story == nil then
				arg_24_1.var_.characterEffect1148ui_story = var_27_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_27_2 = 0.1

			if var_27_1 <= arg_24_1.time_ and arg_24_1.time_ < var_27_1 + var_27_2 and not isNil(var_27_0) then
				local var_27_3 = (arg_24_1.time_ - var_27_1) / var_27_2

				if arg_24_1.var_.characterEffect1148ui_story and not isNil(var_27_0) then
					arg_24_1.var_.characterEffect1148ui_story.fillFlat = false
				end
			end

			if arg_24_1.time_ >= var_27_1 + var_27_2 and arg_24_1.time_ < var_27_1 + var_27_2 + arg_27_0 and not isNil(var_27_0) and arg_24_1.var_.characterEffect1148ui_story then
				arg_24_1.var_.characterEffect1148ui_story.fillFlat = false
			end

			local var_27_4 = arg_24_1.actors_["1084ui_story"]
			local var_27_5 = 0

			if var_27_5 < arg_24_1.time_ and arg_24_1.time_ <= var_27_5 + arg_27_0 and not isNil(var_27_4) and arg_24_1.var_.characterEffect1084ui_story == nil then
				arg_24_1.var_.characterEffect1084ui_story = var_27_4:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_27_6 = 0.1

			if var_27_5 <= arg_24_1.time_ and arg_24_1.time_ < var_27_5 + var_27_6 and not isNil(var_27_4) then
				local var_27_7 = (arg_24_1.time_ - var_27_5) / var_27_6

				if arg_24_1.var_.characterEffect1084ui_story and not isNil(var_27_4) then
					arg_24_1.var_.characterEffect1084ui_story.fillFlat = false
				end
			end

			if arg_24_1.time_ >= var_27_5 + var_27_6 and arg_24_1.time_ < var_27_5 + var_27_6 + arg_27_0 and not isNil(var_27_4) and arg_24_1.var_.characterEffect1084ui_story then
				arg_24_1.var_.characterEffect1084ui_story.fillFlat = false
			end

			local var_27_8 = 0

			if var_27_8 < arg_24_1.time_ and arg_24_1.time_ <= var_27_8 + arg_27_0 then
				arg_24_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/story1084/story1084actionlink/1084action454")
			end

			local var_27_9 = 0

			if var_27_9 < arg_24_1.time_ and arg_24_1.time_ <= var_27_9 + arg_27_0 then
				arg_24_1:PlayTimeline("1148ui_story", "StoryTimeline/CharAction/story1148/story1148actionlink/1148action425")
			end

			local var_27_10 = 0

			if var_27_10 < arg_24_1.time_ and arg_24_1.time_ <= var_27_10 + arg_27_0 then
				arg_24_1:PlayTimeline("1148ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3204cva")
			end

			local var_27_11 = 0

			if var_27_11 < arg_24_1.time_ and arg_24_1.time_ <= var_27_11 + arg_27_0 then
				arg_24_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3202cva")
			end

			local var_27_12 = 0
			local var_27_13 = 0.075

			if var_27_12 < arg_24_1.time_ and arg_24_1.time_ <= var_27_12 + arg_27_0 then
				arg_24_1.talkMaxDuration = 0
				arg_24_1.dialogCg_.alpha = 1

				arg_24_1.dialog_:SetActive(true)
				SetActive(arg_24_1.leftNameGo_, true)

				local var_27_14 = arg_24_1:FormatText(StoryNameCfg[11].name)

				arg_24_1.leftNameTxt_.text = var_27_14

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_24_1.leftNameTxt_.transform)

				arg_24_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_24_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_24_1:RecordName(arg_24_1.leftNameTxt_.text)
				SetActive(arg_24_1.iconTrs_.gameObject, false)
				arg_24_1.callingController_:SetSelectedState("normal")

				local var_27_15 = arg_24_1:GetWordFromCfg(100032006)
				local var_27_16 = arg_24_1:FormatText(var_27_15.content)

				arg_24_1.text_.text = var_27_16

				LuaForUtil.ClearLinePrefixSymbol(arg_24_1.text_)

				local var_27_17 = 3
				local var_27_18 = utf8.len(var_27_16)
				local var_27_19 = var_27_17 <= 0 and var_27_13 or var_27_13 * (var_27_18 / var_27_17)

				if var_27_19 > 0 and var_27_13 < var_27_19 then
					arg_24_1.talkMaxDuration = var_27_19

					if var_27_19 + var_27_12 > arg_24_1.duration_ then
						arg_24_1.duration_ = var_27_19 + var_27_12
					end
				end

				arg_24_1.text_.text = var_27_16
				arg_24_1.typewritter.percent = 0

				arg_24_1.typewritter:SetDirty()
				arg_24_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_100032", "100032006", "story_v_out_100032.awb") ~= 0 then
					local var_27_20 = manager.audio:GetVoiceLength("story_v_out_100032", "100032006", "story_v_out_100032.awb") / 1000

					if var_27_20 + var_27_12 > arg_24_1.duration_ then
						arg_24_1.duration_ = var_27_20 + var_27_12
					end

					if var_27_15.prefab_name ~= "" and arg_24_1.actors_[var_27_15.prefab_name] ~= nil then
						local var_27_21 = LuaForUtil.PlayVoiceWithCriLipsync(arg_24_1.actors_[var_27_15.prefab_name].transform, "story_v_out_100032", "100032006", "story_v_out_100032.awb")

						arg_24_1:RecordAudio("100032006", var_27_21)
						arg_24_1:RecordAudio("100032006", var_27_21)
					else
						arg_24_1:AudioAction("play", "voice", "story_v_out_100032", "100032006", "story_v_out_100032.awb")
					end

					arg_24_1:RecordHistoryTalkVoice("story_v_out_100032", "100032006", "story_v_out_100032.awb")
				end

				arg_24_1:RecordContent(arg_24_1.text_.text)
			end

			local var_27_22 = math.max(var_27_13, arg_24_1.talkMaxDuration)

			if var_27_12 <= arg_24_1.time_ and arg_24_1.time_ < var_27_12 + var_27_22 then
				arg_24_1.typewritter.percent = (arg_24_1.time_ - var_27_12) / var_27_22

				arg_24_1.typewritter:SetDirty()
			end

			if arg_24_1.time_ >= var_27_12 + var_27_22 and arg_24_1.time_ < var_27_12 + var_27_22 + arg_27_0 then
				arg_24_1.typewritter.percent = 1

				arg_24_1.typewritter:SetDirty()
				arg_24_1:ShowNextGo(true)
			end
		end

		arg_24_1.nodeConfigList_ = {}

		arg_24_1:InitPlayNodeList()
	end,
	Play100032007 = function(arg_28_0, arg_28_1)
		arg_28_1.time_ = 0
		arg_28_1.frameCnt_ = 0
		arg_28_1.state_ = "playing"
		arg_28_1.curTalkId_ = 100032007
		arg_28_1.duration_ = 5

		SetActive(arg_28_1.tipsGo_, false)

		function arg_28_1.onSingleLineFinish_()
			arg_28_1.onSingleLineUpdate_ = nil
			arg_28_1.onSingleLineFinish_ = nil
			arg_28_1.state_ = "waiting"
		end

		function arg_28_1.playNext_(arg_30_0)
			if arg_30_0 == 1 then
				arg_28_0:Play100032008(arg_28_1)
			end
		end

		function arg_28_1.onSingleLineUpdate_(arg_31_0)
			local var_31_0 = 0
			local var_31_1 = 1

			if var_31_0 < arg_28_1.time_ and arg_28_1.time_ <= var_31_0 + arg_31_0 then
				local var_31_2 = "play"
				local var_31_3 = "effect"

				arg_28_1:AudioAction(var_31_2, var_31_3, "se_story_0", "se_story_0_wings_stones", "")
			end

			local var_31_4 = arg_28_1.actors_["1084ui_story"].transform
			local var_31_5 = 0

			if var_31_5 < arg_28_1.time_ and arg_28_1.time_ <= var_31_5 + arg_31_0 then
				arg_28_1.var_.moveOldPos1084ui_story = var_31_4.localPosition
			end

			local var_31_6 = 0.001

			if var_31_5 <= arg_28_1.time_ and arg_28_1.time_ < var_31_5 + var_31_6 then
				local var_31_7 = (arg_28_1.time_ - var_31_5) / var_31_6
				local var_31_8 = Vector3.New(0, 100, 0)

				var_31_4.localPosition = Vector3.Lerp(arg_28_1.var_.moveOldPos1084ui_story, var_31_8, var_31_7)

				local var_31_9 = manager.ui.mainCamera.transform.position - var_31_4.position

				var_31_4.forward = Vector3.New(var_31_9.x, var_31_9.y, var_31_9.z)

				local var_31_10 = var_31_4.localEulerAngles

				var_31_10.z = 0
				var_31_10.x = 0
				var_31_4.localEulerAngles = var_31_10
			end

			if arg_28_1.time_ >= var_31_5 + var_31_6 and arg_28_1.time_ < var_31_5 + var_31_6 + arg_31_0 then
				var_31_4.localPosition = Vector3.New(0, 100, 0)

				local var_31_11 = manager.ui.mainCamera.transform.position - var_31_4.position

				var_31_4.forward = Vector3.New(var_31_11.x, var_31_11.y, var_31_11.z)

				local var_31_12 = var_31_4.localEulerAngles

				var_31_12.z = 0
				var_31_12.x = 0
				var_31_4.localEulerAngles = var_31_12
			end

			local var_31_13 = arg_28_1.actors_["1148ui_story"].transform
			local var_31_14 = 0

			if var_31_14 < arg_28_1.time_ and arg_28_1.time_ <= var_31_14 + arg_31_0 then
				arg_28_1.var_.moveOldPos1148ui_story = var_31_13.localPosition
			end

			local var_31_15 = 0.001

			if var_31_14 <= arg_28_1.time_ and arg_28_1.time_ < var_31_14 + var_31_15 then
				local var_31_16 = (arg_28_1.time_ - var_31_14) / var_31_15
				local var_31_17 = Vector3.New(0, 100, 0)

				var_31_13.localPosition = Vector3.Lerp(arg_28_1.var_.moveOldPos1148ui_story, var_31_17, var_31_16)

				local var_31_18 = manager.ui.mainCamera.transform.position - var_31_13.position

				var_31_13.forward = Vector3.New(var_31_18.x, var_31_18.y, var_31_18.z)

				local var_31_19 = var_31_13.localEulerAngles

				var_31_19.z = 0
				var_31_19.x = 0
				var_31_13.localEulerAngles = var_31_19
			end

			if arg_28_1.time_ >= var_31_14 + var_31_15 and arg_28_1.time_ < var_31_14 + var_31_15 + arg_31_0 then
				var_31_13.localPosition = Vector3.New(0, 100, 0)

				local var_31_20 = manager.ui.mainCamera.transform.position - var_31_13.position

				var_31_13.forward = Vector3.New(var_31_20.x, var_31_20.y, var_31_20.z)

				local var_31_21 = var_31_13.localEulerAngles

				var_31_21.z = 0
				var_31_21.x = 0
				var_31_13.localEulerAngles = var_31_21
			end

			local var_31_22 = 0
			local var_31_23 = 0.675

			if var_31_22 < arg_28_1.time_ and arg_28_1.time_ <= var_31_22 + arg_31_0 then
				arg_28_1.talkMaxDuration = 0
				arg_28_1.dialogCg_.alpha = 1

				arg_28_1.dialog_:SetActive(true)
				SetActive(arg_28_1.leftNameGo_, false)

				arg_28_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_28_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_28_1:RecordName(arg_28_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_28_1.iconTrs_.gameObject, false)
				arg_28_1.callingController_:SetSelectedState("normal")

				local var_31_24 = arg_28_1:GetWordFromCfg(100032007)
				local var_31_25 = arg_28_1:FormatText(var_31_24.content)

				arg_28_1.text_.text = var_31_25

				LuaForUtil.ClearLinePrefixSymbol(arg_28_1.text_)

				local var_31_26 = 27
				local var_31_27 = utf8.len(var_31_25)
				local var_31_28 = var_31_26 <= 0 and var_31_23 or var_31_23 * (var_31_27 / var_31_26)

				if var_31_28 > 0 and var_31_23 < var_31_28 then
					arg_28_1.talkMaxDuration = var_31_28

					if var_31_28 + var_31_22 > arg_28_1.duration_ then
						arg_28_1.duration_ = var_31_28 + var_31_22
					end
				end

				arg_28_1.text_.text = var_31_25
				arg_28_1.typewritter.percent = 0

				arg_28_1.typewritter:SetDirty()
				arg_28_1:ShowNextGo(false)
				arg_28_1:RecordContent(arg_28_1.text_.text)
			end

			local var_31_29 = math.max(var_31_23, arg_28_1.talkMaxDuration)

			if var_31_22 <= arg_28_1.time_ and arg_28_1.time_ < var_31_22 + var_31_29 then
				arg_28_1.typewritter.percent = (arg_28_1.time_ - var_31_22) / var_31_29

				arg_28_1.typewritter:SetDirty()
			end

			if arg_28_1.time_ >= var_31_22 + var_31_29 and arg_28_1.time_ < var_31_22 + var_31_29 + arg_31_0 then
				arg_28_1.typewritter.percent = 1

				arg_28_1.typewritter:SetDirty()
				arg_28_1:ShowNextGo(true)
			end
		end

		arg_28_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1084ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.033,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1148ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.033,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_28_1:InitPlayNodeList()
	end,
	Play100032008 = function(arg_32_0, arg_32_1)
		arg_32_1.time_ = 0
		arg_32_1.frameCnt_ = 0
		arg_32_1.state_ = "playing"
		arg_32_1.curTalkId_ = 100032008
		arg_32_1.duration_ = 4.2

		local var_32_0 = {
			ja = 4.2,
			ko = 2.833,
			zh = 2.266,
			en = 1.999999999999
		}
		local var_32_1 = manager.audio:GetLocalizationFlag()

		if var_32_0[var_32_1] ~= nil then
			arg_32_1.duration_ = var_32_0[var_32_1]
		end

		SetActive(arg_32_1.tipsGo_, false)

		function arg_32_1.onSingleLineFinish_()
			arg_32_1.onSingleLineUpdate_ = nil
			arg_32_1.onSingleLineFinish_ = nil
			arg_32_1.state_ = "waiting"
		end

		function arg_32_1.playNext_(arg_34_0)
			if arg_34_0 == 1 then
				arg_32_0:Play100032009(arg_32_1)
			end
		end

		function arg_32_1.onSingleLineUpdate_(arg_35_0)
			local var_35_0 = arg_32_1.actors_["1084ui_story"]
			local var_35_1 = 0

			if var_35_1 < arg_32_1.time_ and arg_32_1.time_ <= var_35_1 + arg_35_0 and not isNil(var_35_0) and arg_32_1.var_.characterEffect1084ui_story == nil then
				arg_32_1.var_.characterEffect1084ui_story = var_35_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_35_2 = 0.1

			if var_35_1 <= arg_32_1.time_ and arg_32_1.time_ < var_35_1 + var_35_2 and not isNil(var_35_0) then
				local var_35_3 = (arg_32_1.time_ - var_35_1) / var_35_2

				if arg_32_1.var_.characterEffect1084ui_story and not isNil(var_35_0) then
					arg_32_1.var_.characterEffect1084ui_story.fillFlat = false
				end
			end

			if arg_32_1.time_ >= var_35_1 + var_35_2 and arg_32_1.time_ < var_35_1 + var_35_2 + arg_35_0 and not isNil(var_35_0) and arg_32_1.var_.characterEffect1084ui_story then
				arg_32_1.var_.characterEffect1084ui_story.fillFlat = false
			end

			local var_35_4 = arg_32_1.actors_["1084ui_story"].transform
			local var_35_5 = 0

			if var_35_5 < arg_32_1.time_ and arg_32_1.time_ <= var_35_5 + arg_35_0 then
				arg_32_1.var_.moveOldPos1084ui_story = var_35_4.localPosition
			end

			local var_35_6 = 0.001

			if var_35_5 <= arg_32_1.time_ and arg_32_1.time_ < var_35_5 + var_35_6 then
				local var_35_7 = (arg_32_1.time_ - var_35_5) / var_35_6
				local var_35_8 = Vector3.New(-0.7, -0.97, -6)

				var_35_4.localPosition = Vector3.Lerp(arg_32_1.var_.moveOldPos1084ui_story, var_35_8, var_35_7)

				local var_35_9 = manager.ui.mainCamera.transform.position - var_35_4.position

				var_35_4.forward = Vector3.New(var_35_9.x, var_35_9.y, var_35_9.z)

				local var_35_10 = var_35_4.localEulerAngles

				var_35_10.z = 0
				var_35_10.x = 0
				var_35_4.localEulerAngles = var_35_10
			end

			if arg_32_1.time_ >= var_35_5 + var_35_6 and arg_32_1.time_ < var_35_5 + var_35_6 + arg_35_0 then
				var_35_4.localPosition = Vector3.New(-0.7, -0.97, -6)

				local var_35_11 = manager.ui.mainCamera.transform.position - var_35_4.position

				var_35_4.forward = Vector3.New(var_35_11.x, var_35_11.y, var_35_11.z)

				local var_35_12 = var_35_4.localEulerAngles

				var_35_12.z = 0
				var_35_12.x = 0
				var_35_4.localEulerAngles = var_35_12
			end

			local var_35_13 = 0

			if var_35_13 < arg_32_1.time_ and arg_32_1.time_ <= var_35_13 + arg_35_0 then
				arg_32_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/story1084/story1084action/1084action13_1")
			end

			local var_35_14 = 0

			if var_35_14 < arg_32_1.time_ and arg_32_1.time_ <= var_35_14 + arg_35_0 then
				arg_32_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3204cva")
			end

			local var_35_15 = 0
			local var_35_16 = 0.15

			if var_35_15 < arg_32_1.time_ and arg_32_1.time_ <= var_35_15 + arg_35_0 then
				arg_32_1.talkMaxDuration = 0
				arg_32_1.dialogCg_.alpha = 1

				arg_32_1.dialog_:SetActive(true)
				SetActive(arg_32_1.leftNameGo_, true)

				local var_35_17 = arg_32_1:FormatText(StoryNameCfg[6].name)

				arg_32_1.leftNameTxt_.text = var_35_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_32_1.leftNameTxt_.transform)

				arg_32_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_32_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_32_1:RecordName(arg_32_1.leftNameTxt_.text)
				SetActive(arg_32_1.iconTrs_.gameObject, false)
				arg_32_1.callingController_:SetSelectedState("normal")

				local var_35_18 = arg_32_1:GetWordFromCfg(100032008)
				local var_35_19 = arg_32_1:FormatText(var_35_18.content)

				arg_32_1.text_.text = var_35_19

				LuaForUtil.ClearLinePrefixSymbol(arg_32_1.text_)

				local var_35_20 = 6
				local var_35_21 = utf8.len(var_35_19)
				local var_35_22 = var_35_20 <= 0 and var_35_16 or var_35_16 * (var_35_21 / var_35_20)

				if var_35_22 > 0 and var_35_16 < var_35_22 then
					arg_32_1.talkMaxDuration = var_35_22

					if var_35_22 + var_35_15 > arg_32_1.duration_ then
						arg_32_1.duration_ = var_35_22 + var_35_15
					end
				end

				arg_32_1.text_.text = var_35_19
				arg_32_1.typewritter.percent = 0

				arg_32_1.typewritter:SetDirty()
				arg_32_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_100032", "100032008", "story_v_out_100032.awb") ~= 0 then
					local var_35_23 = manager.audio:GetVoiceLength("story_v_out_100032", "100032008", "story_v_out_100032.awb") / 1000

					if var_35_23 + var_35_15 > arg_32_1.duration_ then
						arg_32_1.duration_ = var_35_23 + var_35_15
					end

					if var_35_18.prefab_name ~= "" and arg_32_1.actors_[var_35_18.prefab_name] ~= nil then
						local var_35_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_32_1.actors_[var_35_18.prefab_name].transform, "story_v_out_100032", "100032008", "story_v_out_100032.awb")

						arg_32_1:RecordAudio("100032008", var_35_24)
						arg_32_1:RecordAudio("100032008", var_35_24)
					else
						arg_32_1:AudioAction("play", "voice", "story_v_out_100032", "100032008", "story_v_out_100032.awb")
					end

					arg_32_1:RecordHistoryTalkVoice("story_v_out_100032", "100032008", "story_v_out_100032.awb")
				end

				arg_32_1:RecordContent(arg_32_1.text_.text)
			end

			local var_35_25 = math.max(var_35_16, arg_32_1.talkMaxDuration)

			if var_35_15 <= arg_32_1.time_ and arg_32_1.time_ < var_35_15 + var_35_25 then
				arg_32_1.typewritter.percent = (arg_32_1.time_ - var_35_15) / var_35_25

				arg_32_1.typewritter:SetDirty()
			end

			if arg_32_1.time_ >= var_35_15 + var_35_25 and arg_32_1.time_ < var_35_15 + var_35_25 + arg_35_0 then
				arg_32_1.typewritter.percent = 1

				arg_32_1.typewritter:SetDirty()
				arg_32_1:ShowNextGo(true)
			end
		end

		arg_32_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1084ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.033,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_32_1:InitPlayNodeList()
	end,
	Play100032009 = function(arg_36_0, arg_36_1)
		arg_36_1.time_ = 0
		arg_36_1.frameCnt_ = 0
		arg_36_1.state_ = "playing"
		arg_36_1.curTalkId_ = 100032009
		arg_36_1.duration_ = 4.5

		local var_36_0 = {
			ja = 4.5,
			ko = 2.2,
			zh = 1.999999999999,
			en = 2.433
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
				arg_36_0:Play100032010(arg_36_1)
			end
		end

		function arg_36_1.onSingleLineUpdate_(arg_39_0)
			local var_39_0 = arg_36_1.actors_["1148ui_story"]
			local var_39_1 = 0

			if var_39_1 < arg_36_1.time_ and arg_36_1.time_ <= var_39_1 + arg_39_0 and not isNil(var_39_0) and arg_36_1.var_.characterEffect1148ui_story == nil then
				arg_36_1.var_.characterEffect1148ui_story = var_39_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_39_2 = 0.1

			if var_39_1 <= arg_36_1.time_ and arg_36_1.time_ < var_39_1 + var_39_2 and not isNil(var_39_0) then
				local var_39_3 = (arg_36_1.time_ - var_39_1) / var_39_2

				if arg_36_1.var_.characterEffect1148ui_story and not isNil(var_39_0) then
					arg_36_1.var_.characterEffect1148ui_story.fillFlat = false
				end
			end

			if arg_36_1.time_ >= var_39_1 + var_39_2 and arg_36_1.time_ < var_39_1 + var_39_2 + arg_39_0 and not isNil(var_39_0) and arg_36_1.var_.characterEffect1148ui_story then
				arg_36_1.var_.characterEffect1148ui_story.fillFlat = false
			end

			local var_39_4 = arg_36_1.actors_["1084ui_story"]
			local var_39_5 = 0

			if var_39_5 < arg_36_1.time_ and arg_36_1.time_ <= var_39_5 + arg_39_0 and not isNil(var_39_4) and arg_36_1.var_.characterEffect1084ui_story == nil then
				arg_36_1.var_.characterEffect1084ui_story = var_39_4:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_39_6 = 0.1

			if var_39_5 <= arg_36_1.time_ and arg_36_1.time_ < var_39_5 + var_39_6 and not isNil(var_39_4) then
				local var_39_7 = (arg_36_1.time_ - var_39_5) / var_39_6

				if arg_36_1.var_.characterEffect1084ui_story and not isNil(var_39_4) then
					local var_39_8 = Mathf.Lerp(0, 0.5, var_39_7)

					arg_36_1.var_.characterEffect1084ui_story.fillFlat = true
					arg_36_1.var_.characterEffect1084ui_story.fillRatio = var_39_8
				end
			end

			if arg_36_1.time_ >= var_39_5 + var_39_6 and arg_36_1.time_ < var_39_5 + var_39_6 + arg_39_0 and not isNil(var_39_4) and arg_36_1.var_.characterEffect1084ui_story then
				local var_39_9 = 0.5

				arg_36_1.var_.characterEffect1084ui_story.fillFlat = true
				arg_36_1.var_.characterEffect1084ui_story.fillRatio = var_39_9
			end

			local var_39_10 = arg_36_1.actors_["1148ui_story"].transform
			local var_39_11 = 0

			if var_39_11 < arg_36_1.time_ and arg_36_1.time_ <= var_39_11 + arg_39_0 then
				arg_36_1.var_.moveOldPos1148ui_story = var_39_10.localPosition
			end

			local var_39_12 = 0.001

			if var_39_11 <= arg_36_1.time_ and arg_36_1.time_ < var_39_11 + var_39_12 then
				local var_39_13 = (arg_36_1.time_ - var_39_11) / var_39_12
				local var_39_14 = Vector3.New(0.7, -0.8, -6.2)

				var_39_10.localPosition = Vector3.Lerp(arg_36_1.var_.moveOldPos1148ui_story, var_39_14, var_39_13)

				local var_39_15 = manager.ui.mainCamera.transform.position - var_39_10.position

				var_39_10.forward = Vector3.New(var_39_15.x, var_39_15.y, var_39_15.z)

				local var_39_16 = var_39_10.localEulerAngles

				var_39_16.z = 0
				var_39_16.x = 0
				var_39_10.localEulerAngles = var_39_16
			end

			if arg_36_1.time_ >= var_39_11 + var_39_12 and arg_36_1.time_ < var_39_11 + var_39_12 + arg_39_0 then
				var_39_10.localPosition = Vector3.New(0.7, -0.8, -6.2)

				local var_39_17 = manager.ui.mainCamera.transform.position - var_39_10.position

				var_39_10.forward = Vector3.New(var_39_17.x, var_39_17.y, var_39_17.z)

				local var_39_18 = var_39_10.localEulerAngles

				var_39_18.z = 0
				var_39_18.x = 0
				var_39_10.localEulerAngles = var_39_18
			end

			local var_39_19 = 0

			if var_39_19 < arg_36_1.time_ and arg_36_1.time_ <= var_39_19 + arg_39_0 then
				arg_36_1:PlayTimeline("1148ui_story", "StoryTimeline/CharAction/story1148/story1148action/1148action3_1")
			end

			local var_39_20 = 0

			if var_39_20 < arg_36_1.time_ and arg_36_1.time_ <= var_39_20 + arg_39_0 then
				arg_36_1:PlayTimeline("1148ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3104cva")
			end

			local var_39_21 = 0
			local var_39_22 = 0.175

			if var_39_21 < arg_36_1.time_ and arg_36_1.time_ <= var_39_21 + arg_39_0 then
				arg_36_1.talkMaxDuration = 0
				arg_36_1.dialogCg_.alpha = 1

				arg_36_1.dialog_:SetActive(true)
				SetActive(arg_36_1.leftNameGo_, true)

				local var_39_23 = arg_36_1:FormatText(StoryNameCfg[8].name)

				arg_36_1.leftNameTxt_.text = var_39_23

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_36_1.leftNameTxt_.transform)

				arg_36_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_36_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_36_1:RecordName(arg_36_1.leftNameTxt_.text)
				SetActive(arg_36_1.iconTrs_.gameObject, false)
				arg_36_1.callingController_:SetSelectedState("normal")

				local var_39_24 = arg_36_1:GetWordFromCfg(100032009)
				local var_39_25 = arg_36_1:FormatText(var_39_24.content)

				arg_36_1.text_.text = var_39_25

				LuaForUtil.ClearLinePrefixSymbol(arg_36_1.text_)

				local var_39_26 = 7
				local var_39_27 = utf8.len(var_39_25)
				local var_39_28 = var_39_26 <= 0 and var_39_22 or var_39_22 * (var_39_27 / var_39_26)

				if var_39_28 > 0 and var_39_22 < var_39_28 then
					arg_36_1.talkMaxDuration = var_39_28

					if var_39_28 + var_39_21 > arg_36_1.duration_ then
						arg_36_1.duration_ = var_39_28 + var_39_21
					end
				end

				arg_36_1.text_.text = var_39_25
				arg_36_1.typewritter.percent = 0

				arg_36_1.typewritter:SetDirty()
				arg_36_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_100032", "100032009", "story_v_out_100032.awb") ~= 0 then
					local var_39_29 = manager.audio:GetVoiceLength("story_v_out_100032", "100032009", "story_v_out_100032.awb") / 1000

					if var_39_29 + var_39_21 > arg_36_1.duration_ then
						arg_36_1.duration_ = var_39_29 + var_39_21
					end

					if var_39_24.prefab_name ~= "" and arg_36_1.actors_[var_39_24.prefab_name] ~= nil then
						local var_39_30 = LuaForUtil.PlayVoiceWithCriLipsync(arg_36_1.actors_[var_39_24.prefab_name].transform, "story_v_out_100032", "100032009", "story_v_out_100032.awb")

						arg_36_1:RecordAudio("100032009", var_39_30)
						arg_36_1:RecordAudio("100032009", var_39_30)
					else
						arg_36_1:AudioAction("play", "voice", "story_v_out_100032", "100032009", "story_v_out_100032.awb")
					end

					arg_36_1:RecordHistoryTalkVoice("story_v_out_100032", "100032009", "story_v_out_100032.awb")
				end

				arg_36_1:RecordContent(arg_36_1.text_.text)
			end

			local var_39_31 = math.max(var_39_22, arg_36_1.talkMaxDuration)

			if var_39_21 <= arg_36_1.time_ and arg_36_1.time_ < var_39_21 + var_39_31 then
				arg_36_1.typewritter.percent = (arg_36_1.time_ - var_39_21) / var_39_31

				arg_36_1.typewritter:SetDirty()
			end

			if arg_36_1.time_ >= var_39_21 + var_39_31 and arg_36_1.time_ < var_39_21 + var_39_31 + arg_39_0 then
				arg_36_1.typewritter.percent = 1

				arg_36_1.typewritter:SetDirty()
				arg_36_1:ShowNextGo(true)
			end
		end

		arg_36_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1148ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.033,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_36_1:InitPlayNodeList()
	end,
	Play100032010 = function(arg_40_0, arg_40_1)
		arg_40_1.time_ = 0
		arg_40_1.frameCnt_ = 0
		arg_40_1.state_ = "playing"
		arg_40_1.curTalkId_ = 100032010
		arg_40_1.duration_ = 5

		SetActive(arg_40_1.tipsGo_, false)

		function arg_40_1.onSingleLineFinish_()
			arg_40_1.onSingleLineUpdate_ = nil
			arg_40_1.onSingleLineFinish_ = nil
			arg_40_1.state_ = "waiting"
		end

		function arg_40_1.playNext_(arg_42_0)
			if arg_42_0 == 1 then
				arg_40_0:Play100032011(arg_40_1)
			end
		end

		function arg_40_1.onSingleLineUpdate_(arg_43_0)
			local var_43_0 = 0
			local var_43_1 = 1

			if var_43_0 < arg_40_1.time_ and arg_40_1.time_ <= var_43_0 + arg_43_0 then
				local var_43_2 = "play"
				local var_43_3 = "effect"

				arg_40_1:AudioAction(var_43_2, var_43_3, "se_story", "se_story_enemy_activity", "")
			end

			local var_43_4 = arg_40_1.actors_["1148ui_story"]
			local var_43_5 = 0

			if var_43_5 < arg_40_1.time_ and arg_40_1.time_ <= var_43_5 + arg_43_0 and not isNil(var_43_4) and arg_40_1.var_.characterEffect1148ui_story == nil then
				arg_40_1.var_.characterEffect1148ui_story = var_43_4:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_43_6 = 0.1

			if var_43_5 <= arg_40_1.time_ and arg_40_1.time_ < var_43_5 + var_43_6 and not isNil(var_43_4) then
				local var_43_7 = (arg_40_1.time_ - var_43_5) / var_43_6

				if arg_40_1.var_.characterEffect1148ui_story and not isNil(var_43_4) then
					local var_43_8 = Mathf.Lerp(0, 0.5, var_43_7)

					arg_40_1.var_.characterEffect1148ui_story.fillFlat = true
					arg_40_1.var_.characterEffect1148ui_story.fillRatio = var_43_8
				end
			end

			if arg_40_1.time_ >= var_43_5 + var_43_6 and arg_40_1.time_ < var_43_5 + var_43_6 + arg_43_0 and not isNil(var_43_4) and arg_40_1.var_.characterEffect1148ui_story then
				local var_43_9 = 0.5

				arg_40_1.var_.characterEffect1148ui_story.fillFlat = true
				arg_40_1.var_.characterEffect1148ui_story.fillRatio = var_43_9
			end

			local var_43_10 = 0
			local var_43_11 = 0.2

			if var_43_10 < arg_40_1.time_ and arg_40_1.time_ <= var_43_10 + arg_43_0 then
				arg_40_1.talkMaxDuration = 0
				arg_40_1.dialogCg_.alpha = 1

				arg_40_1.dialog_:SetActive(true)
				SetActive(arg_40_1.leftNameGo_, true)

				local var_43_12 = arg_40_1:FormatText(StoryNameCfg[12].name)

				arg_40_1.leftNameTxt_.text = var_43_12

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_40_1.leftNameTxt_.transform)

				arg_40_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_40_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_40_1:RecordName(arg_40_1.leftNameTxt_.text)
				SetActive(arg_40_1.iconTrs_.gameObject, true)
				arg_40_1.iconController_:SetSelectedState("hero")

				arg_40_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_3016")

				arg_40_1.callingController_:SetSelectedState("normal")

				arg_40_1.keyicon_.color = Color.New(1, 1, 1)
				arg_40_1.icon_.color = Color.New(1, 1, 1)

				local var_43_13 = arg_40_1:GetWordFromCfg(100032010)
				local var_43_14 = arg_40_1:FormatText(var_43_13.content)

				arg_40_1.text_.text = var_43_14

				LuaForUtil.ClearLinePrefixSymbol(arg_40_1.text_)

				local var_43_15 = 8
				local var_43_16 = utf8.len(var_43_14)
				local var_43_17 = var_43_15 <= 0 and var_43_11 or var_43_11 * (var_43_16 / var_43_15)

				if var_43_17 > 0 and var_43_11 < var_43_17 then
					arg_40_1.talkMaxDuration = var_43_17

					if var_43_17 + var_43_10 > arg_40_1.duration_ then
						arg_40_1.duration_ = var_43_17 + var_43_10
					end
				end

				arg_40_1.text_.text = var_43_14
				arg_40_1.typewritter.percent = 0

				arg_40_1.typewritter:SetDirty()
				arg_40_1:ShowNextGo(false)
				arg_40_1:RecordContent(arg_40_1.text_.text)
			end

			local var_43_18 = math.max(var_43_11, arg_40_1.talkMaxDuration)

			if var_43_10 <= arg_40_1.time_ and arg_40_1.time_ < var_43_10 + var_43_18 then
				arg_40_1.typewritter.percent = (arg_40_1.time_ - var_43_10) / var_43_18

				arg_40_1.typewritter:SetDirty()
			end

			if arg_40_1.time_ >= var_43_10 + var_43_18 and arg_40_1.time_ < var_43_10 + var_43_18 + arg_43_0 then
				arg_40_1.typewritter.percent = 1

				arg_40_1.typewritter:SetDirty()
				arg_40_1:ShowNextGo(true)
			end
		end

		arg_40_1.nodeConfigList_ = {}

		arg_40_1:InitPlayNodeList()
	end,
	Play100032011 = function(arg_44_0, arg_44_1)
		arg_44_1.time_ = 0
		arg_44_1.frameCnt_ = 0
		arg_44_1.state_ = "playing"
		arg_44_1.curTalkId_ = 100032011
		arg_44_1.duration_ = 2.83

		local var_44_0 = {
			ja = 2.833,
			ko = 2.366,
			zh = 2.6,
			en = 2.566
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
				arg_44_0:Play100032012(arg_44_1)
			end
		end

		function arg_44_1.onSingleLineUpdate_(arg_47_0)
			local var_47_0 = arg_44_1.actors_["1148ui_story"]
			local var_47_1 = 0

			if var_47_1 < arg_44_1.time_ and arg_44_1.time_ <= var_47_1 + arg_47_0 and not isNil(var_47_0) and arg_44_1.var_.characterEffect1148ui_story == nil then
				arg_44_1.var_.characterEffect1148ui_story = var_47_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_47_2 = 0.1

			if var_47_1 <= arg_44_1.time_ and arg_44_1.time_ < var_47_1 + var_47_2 and not isNil(var_47_0) then
				local var_47_3 = (arg_44_1.time_ - var_47_1) / var_47_2

				if arg_44_1.var_.characterEffect1148ui_story and not isNil(var_47_0) then
					arg_44_1.var_.characterEffect1148ui_story.fillFlat = false
				end
			end

			if arg_44_1.time_ >= var_47_1 + var_47_2 and arg_44_1.time_ < var_47_1 + var_47_2 + arg_47_0 and not isNil(var_47_0) and arg_44_1.var_.characterEffect1148ui_story then
				arg_44_1.var_.characterEffect1148ui_story.fillFlat = false
			end

			local var_47_4 = 0

			if var_47_4 < arg_44_1.time_ and arg_44_1.time_ <= var_47_4 + arg_47_0 then
				arg_44_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/story1084/story1084action/1084action11_1")
			end

			local var_47_5 = 0

			if var_47_5 < arg_44_1.time_ and arg_44_1.time_ <= var_47_5 + arg_47_0 then
				arg_44_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3104cva")
			end

			local var_47_6 = arg_44_1.actors_["1084ui_story"].transform
			local var_47_7 = 0

			if var_47_7 < arg_44_1.time_ and arg_44_1.time_ <= var_47_7 + arg_47_0 then
				arg_44_1.var_.moveOldPos1084ui_story = var_47_6.localPosition

				local var_47_8 = "1084ui_story"

				arg_44_1:ShowWeapon(arg_44_1.var_[var_47_8 .. "Animator"].transform, true)
			end

			local var_47_9 = 0.001

			if var_47_7 <= arg_44_1.time_ and arg_44_1.time_ < var_47_7 + var_47_9 then
				local var_47_10 = (arg_44_1.time_ - var_47_7) / var_47_9
				local var_47_11 = Vector3.New(-0.7, -0.97, -6)

				var_47_6.localPosition = Vector3.Lerp(arg_44_1.var_.moveOldPos1084ui_story, var_47_11, var_47_10)

				local var_47_12 = manager.ui.mainCamera.transform.position - var_47_6.position

				var_47_6.forward = Vector3.New(var_47_12.x, var_47_12.y, var_47_12.z)

				local var_47_13 = var_47_6.localEulerAngles

				var_47_13.z = 0
				var_47_13.x = 0
				var_47_6.localEulerAngles = var_47_13
			end

			if arg_44_1.time_ >= var_47_7 + var_47_9 and arg_44_1.time_ < var_47_7 + var_47_9 + arg_47_0 then
				var_47_6.localPosition = Vector3.New(-0.7, -0.97, -6)

				local var_47_14 = manager.ui.mainCamera.transform.position - var_47_6.position

				var_47_6.forward = Vector3.New(var_47_14.x, var_47_14.y, var_47_14.z)

				local var_47_15 = var_47_6.localEulerAngles

				var_47_15.z = 0
				var_47_15.x = 0
				var_47_6.localEulerAngles = var_47_15
			end

			local var_47_16 = 0
			local var_47_17 = 0.25

			if var_47_16 < arg_44_1.time_ and arg_44_1.time_ <= var_47_16 + arg_47_0 then
				arg_44_1.talkMaxDuration = 0
				arg_44_1.dialogCg_.alpha = 1

				arg_44_1.dialog_:SetActive(true)
				SetActive(arg_44_1.leftNameGo_, true)

				local var_47_18 = arg_44_1:FormatText(StoryNameCfg[6].name)

				arg_44_1.leftNameTxt_.text = var_47_18

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_44_1.leftNameTxt_.transform)

				arg_44_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_44_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_44_1:RecordName(arg_44_1.leftNameTxt_.text)
				SetActive(arg_44_1.iconTrs_.gameObject, false)
				arg_44_1.callingController_:SetSelectedState("normal")

				local var_47_19 = arg_44_1:GetWordFromCfg(100032011)
				local var_47_20 = arg_44_1:FormatText(var_47_19.content)

				arg_44_1.text_.text = var_47_20

				LuaForUtil.ClearLinePrefixSymbol(arg_44_1.text_)

				local var_47_21 = 10
				local var_47_22 = utf8.len(var_47_20)
				local var_47_23 = var_47_21 <= 0 and var_47_17 or var_47_17 * (var_47_22 / var_47_21)

				if var_47_23 > 0 and var_47_17 < var_47_23 then
					arg_44_1.talkMaxDuration = var_47_23

					if var_47_23 + var_47_16 > arg_44_1.duration_ then
						arg_44_1.duration_ = var_47_23 + var_47_16
					end
				end

				arg_44_1.text_.text = var_47_20
				arg_44_1.typewritter.percent = 0

				arg_44_1.typewritter:SetDirty()
				arg_44_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_100032", "100032011", "story_v_out_100032.awb") ~= 0 then
					local var_47_24 = manager.audio:GetVoiceLength("story_v_out_100032", "100032011", "story_v_out_100032.awb") / 1000

					if var_47_24 + var_47_16 > arg_44_1.duration_ then
						arg_44_1.duration_ = var_47_24 + var_47_16
					end

					if var_47_19.prefab_name ~= "" and arg_44_1.actors_[var_47_19.prefab_name] ~= nil then
						local var_47_25 = LuaForUtil.PlayVoiceWithCriLipsync(arg_44_1.actors_[var_47_19.prefab_name].transform, "story_v_out_100032", "100032011", "story_v_out_100032.awb")

						arg_44_1:RecordAudio("100032011", var_47_25)
						arg_44_1:RecordAudio("100032011", var_47_25)
					else
						arg_44_1:AudioAction("play", "voice", "story_v_out_100032", "100032011", "story_v_out_100032.awb")
					end

					arg_44_1:RecordHistoryTalkVoice("story_v_out_100032", "100032011", "story_v_out_100032.awb")
				end

				arg_44_1:RecordContent(arg_44_1.text_.text)
			end

			local var_47_26 = math.max(var_47_17, arg_44_1.talkMaxDuration)

			if var_47_16 <= arg_44_1.time_ and arg_44_1.time_ < var_47_16 + var_47_26 then
				arg_44_1.typewritter.percent = (arg_44_1.time_ - var_47_16) / var_47_26

				arg_44_1.typewritter:SetDirty()
			end

			if arg_44_1.time_ >= var_47_16 + var_47_26 and arg_44_1.time_ < var_47_16 + var_47_26 + arg_47_0 then
				arg_44_1.typewritter.percent = 1

				arg_44_1.typewritter:SetDirty()
				arg_44_1:ShowNextGo(true)
			end
		end

		arg_44_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1084ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.0166666666666667,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_44_1:InitPlayNodeList()
	end,
	Play100032012 = function(arg_48_0, arg_48_1)
		arg_48_1.time_ = 0
		arg_48_1.frameCnt_ = 0
		arg_48_1.state_ = "playing"
		arg_48_1.curTalkId_ = 100032012
		arg_48_1.duration_ = 4.77

		local var_48_0 = {
			ja = 4.766,
			ko = 3.8,
			zh = 3.066,
			en = 3.7
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
				arg_48_0:Play100032013(arg_48_1)
			end
		end

		function arg_48_1.onSingleLineUpdate_(arg_51_0)
			local var_51_0 = "1039ui_story"

			if arg_48_1.actors_[var_51_0] == nil then
				local var_51_1 = Asset.Load("Char/" .. "1039ui_story")

				if not isNil(var_51_1) then
					local var_51_2 = Object.Instantiate(Asset.Load("Char/" .. "1039ui_story"), arg_48_1.stage_.transform)

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

			local var_51_5 = arg_48_1.actors_["1039ui_story"]
			local var_51_6 = 0

			if var_51_6 < arg_48_1.time_ and arg_48_1.time_ <= var_51_6 + arg_51_0 and not isNil(var_51_5) and arg_48_1.var_.characterEffect1039ui_story == nil then
				arg_48_1.var_.characterEffect1039ui_story = var_51_5:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_51_7 = 0.1

			if var_51_6 <= arg_48_1.time_ and arg_48_1.time_ < var_51_6 + var_51_7 and not isNil(var_51_5) then
				local var_51_8 = (arg_48_1.time_ - var_51_6) / var_51_7

				if arg_48_1.var_.characterEffect1039ui_story and not isNil(var_51_5) then
					arg_48_1.var_.characterEffect1039ui_story.fillFlat = false
				end
			end

			if arg_48_1.time_ >= var_51_6 + var_51_7 and arg_48_1.time_ < var_51_6 + var_51_7 + arg_51_0 and not isNil(var_51_5) and arg_48_1.var_.characterEffect1039ui_story then
				arg_48_1.var_.characterEffect1039ui_story.fillFlat = false
			end

			local var_51_9 = arg_48_1.actors_["1148ui_story"]
			local var_51_10 = 0

			if var_51_10 < arg_48_1.time_ and arg_48_1.time_ <= var_51_10 + arg_51_0 and not isNil(var_51_9) and arg_48_1.var_.characterEffect1148ui_story == nil then
				arg_48_1.var_.characterEffect1148ui_story = var_51_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_51_11 = 0.1

			if var_51_10 <= arg_48_1.time_ and arg_48_1.time_ < var_51_10 + var_51_11 and not isNil(var_51_9) then
				local var_51_12 = (arg_48_1.time_ - var_51_10) / var_51_11

				if arg_48_1.var_.characterEffect1148ui_story and not isNil(var_51_9) then
					local var_51_13 = Mathf.Lerp(0, 0.5, var_51_12)

					arg_48_1.var_.characterEffect1148ui_story.fillFlat = true
					arg_48_1.var_.characterEffect1148ui_story.fillRatio = var_51_13
				end
			end

			if arg_48_1.time_ >= var_51_10 + var_51_11 and arg_48_1.time_ < var_51_10 + var_51_11 + arg_51_0 and not isNil(var_51_9) and arg_48_1.var_.characterEffect1148ui_story then
				local var_51_14 = 0.5

				arg_48_1.var_.characterEffect1148ui_story.fillFlat = true
				arg_48_1.var_.characterEffect1148ui_story.fillRatio = var_51_14
			end

			local var_51_15 = arg_48_1.actors_["1148ui_story"].transform
			local var_51_16 = 0

			if var_51_16 < arg_48_1.time_ and arg_48_1.time_ <= var_51_16 + arg_51_0 then
				arg_48_1.var_.moveOldPos1148ui_story = var_51_15.localPosition
			end

			local var_51_17 = 0.001

			if var_51_16 <= arg_48_1.time_ and arg_48_1.time_ < var_51_16 + var_51_17 then
				local var_51_18 = (arg_48_1.time_ - var_51_16) / var_51_17
				local var_51_19 = Vector3.New(0, 100, 0)

				var_51_15.localPosition = Vector3.Lerp(arg_48_1.var_.moveOldPos1148ui_story, var_51_19, var_51_18)

				local var_51_20 = manager.ui.mainCamera.transform.position - var_51_15.position

				var_51_15.forward = Vector3.New(var_51_20.x, var_51_20.y, var_51_20.z)

				local var_51_21 = var_51_15.localEulerAngles

				var_51_21.z = 0
				var_51_21.x = 0
				var_51_15.localEulerAngles = var_51_21
			end

			if arg_48_1.time_ >= var_51_16 + var_51_17 and arg_48_1.time_ < var_51_16 + var_51_17 + arg_51_0 then
				var_51_15.localPosition = Vector3.New(0, 100, 0)

				local var_51_22 = manager.ui.mainCamera.transform.position - var_51_15.position

				var_51_15.forward = Vector3.New(var_51_22.x, var_51_22.y, var_51_22.z)

				local var_51_23 = var_51_15.localEulerAngles

				var_51_23.z = 0
				var_51_23.x = 0
				var_51_15.localEulerAngles = var_51_23
			end

			local var_51_24 = arg_48_1.actors_["1039ui_story"].transform
			local var_51_25 = 0

			if var_51_25 < arg_48_1.time_ and arg_48_1.time_ <= var_51_25 + arg_51_0 then
				arg_48_1.var_.moveOldPos1039ui_story = var_51_24.localPosition
			end

			local var_51_26 = 0.001

			if var_51_25 <= arg_48_1.time_ and arg_48_1.time_ < var_51_25 + var_51_26 then
				local var_51_27 = (arg_48_1.time_ - var_51_25) / var_51_26
				local var_51_28 = Vector3.New(0.7, -1.01, -5.9)

				var_51_24.localPosition = Vector3.Lerp(arg_48_1.var_.moveOldPos1039ui_story, var_51_28, var_51_27)

				local var_51_29 = manager.ui.mainCamera.transform.position - var_51_24.position

				var_51_24.forward = Vector3.New(var_51_29.x, var_51_29.y, var_51_29.z)

				local var_51_30 = var_51_24.localEulerAngles

				var_51_30.z = 0
				var_51_30.x = 0
				var_51_24.localEulerAngles = var_51_30
			end

			if arg_48_1.time_ >= var_51_25 + var_51_26 and arg_48_1.time_ < var_51_25 + var_51_26 + arg_51_0 then
				var_51_24.localPosition = Vector3.New(0.7, -1.01, -5.9)

				local var_51_31 = manager.ui.mainCamera.transform.position - var_51_24.position

				var_51_24.forward = Vector3.New(var_51_31.x, var_51_31.y, var_51_31.z)

				local var_51_32 = var_51_24.localEulerAngles

				var_51_32.z = 0
				var_51_32.x = 0
				var_51_24.localEulerAngles = var_51_32
			end

			local var_51_33 = 0

			if var_51_33 < arg_48_1.time_ and arg_48_1.time_ <= var_51_33 + arg_51_0 then
				arg_48_1:PlayTimeline("1039ui_story", "StoryTimeline/CharAction/story1039/story1039action/1039action5_1")
			end

			local var_51_34 = 0

			if var_51_34 < arg_48_1.time_ and arg_48_1.time_ <= var_51_34 + arg_51_0 then
				arg_48_1:PlayTimeline("1039ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3104cva")
			end

			local var_51_35 = 0
			local var_51_36 = 0.475

			if var_51_35 < arg_48_1.time_ and arg_48_1.time_ <= var_51_35 + arg_51_0 then
				arg_48_1.talkMaxDuration = 0
				arg_48_1.dialogCg_.alpha = 1

				arg_48_1.dialog_:SetActive(true)
				SetActive(arg_48_1.leftNameGo_, true)

				local var_51_37 = arg_48_1:FormatText(StoryNameCfg[9].name)

				arg_48_1.leftNameTxt_.text = var_51_37

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_48_1.leftNameTxt_.transform)

				arg_48_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_48_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_48_1:RecordName(arg_48_1.leftNameTxt_.text)
				SetActive(arg_48_1.iconTrs_.gameObject, false)
				arg_48_1.callingController_:SetSelectedState("normal")

				local var_51_38 = arg_48_1:GetWordFromCfg(100032012)
				local var_51_39 = arg_48_1:FormatText(var_51_38.content)

				arg_48_1.text_.text = var_51_39

				LuaForUtil.ClearLinePrefixSymbol(arg_48_1.text_)

				local var_51_40 = 19
				local var_51_41 = utf8.len(var_51_39)
				local var_51_42 = var_51_40 <= 0 and var_51_36 or var_51_36 * (var_51_41 / var_51_40)

				if var_51_42 > 0 and var_51_36 < var_51_42 then
					arg_48_1.talkMaxDuration = var_51_42

					if var_51_42 + var_51_35 > arg_48_1.duration_ then
						arg_48_1.duration_ = var_51_42 + var_51_35
					end
				end

				arg_48_1.text_.text = var_51_39
				arg_48_1.typewritter.percent = 0

				arg_48_1.typewritter:SetDirty()
				arg_48_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_100032", "100032012", "story_v_out_100032.awb") ~= 0 then
					local var_51_43 = manager.audio:GetVoiceLength("story_v_out_100032", "100032012", "story_v_out_100032.awb") / 1000

					if var_51_43 + var_51_35 > arg_48_1.duration_ then
						arg_48_1.duration_ = var_51_43 + var_51_35
					end

					if var_51_38.prefab_name ~= "" and arg_48_1.actors_[var_51_38.prefab_name] ~= nil then
						local var_51_44 = LuaForUtil.PlayVoiceWithCriLipsync(arg_48_1.actors_[var_51_38.prefab_name].transform, "story_v_out_100032", "100032012", "story_v_out_100032.awb")

						arg_48_1:RecordAudio("100032012", var_51_44)
						arg_48_1:RecordAudio("100032012", var_51_44)
					else
						arg_48_1:AudioAction("play", "voice", "story_v_out_100032", "100032012", "story_v_out_100032.awb")
					end

					arg_48_1:RecordHistoryTalkVoice("story_v_out_100032", "100032012", "story_v_out_100032.awb")
				end

				arg_48_1:RecordContent(arg_48_1.text_.text)
			end

			local var_51_45 = math.max(var_51_36, arg_48_1.talkMaxDuration)

			if var_51_35 <= arg_48_1.time_ and arg_48_1.time_ < var_51_35 + var_51_45 then
				arg_48_1.typewritter.percent = (arg_48_1.time_ - var_51_35) / var_51_45

				arg_48_1.typewritter:SetDirty()
			end

			if arg_48_1.time_ >= var_51_35 + var_51_45 and arg_48_1.time_ < var_51_35 + var_51_45 + arg_51_0 then
				arg_48_1.typewritter.percent = 1

				arg_48_1.typewritter:SetDirty()
				arg_48_1:ShowNextGo(true)
			end
		end

		arg_48_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1148ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.033,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1039ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.033,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_48_1:InitPlayNodeList()
	end,
	Play100032013 = function(arg_52_0, arg_52_1)
		arg_52_1.time_ = 0
		arg_52_1.frameCnt_ = 0
		arg_52_1.state_ = "playing"
		arg_52_1.curTalkId_ = 100032013
		arg_52_1.duration_ = 4.2

		local var_52_0 = {
			ja = 4.2,
			ko = 1.999999999999,
			zh = 2.133,
			en = 1.999999999999
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
			arg_52_1.auto_ = false
		end

		function arg_52_1.playNext_(arg_54_0)
			arg_52_1.onStoryFinished_()
		end

		function arg_52_1.onSingleLineUpdate_(arg_55_0)
			local var_55_0 = 0
			local var_55_1 = 1

			if var_55_0 < arg_52_1.time_ and arg_52_1.time_ <= var_55_0 + arg_55_0 then
				local var_55_2 = "play"
				local var_55_3 = "music"

				arg_52_1:AudioAction(var_55_2, var_55_3, "se_story_ui", "se_story_stopenv", "")

				local var_55_4 = ""
				local var_55_5 = manager.audio:GetAudioName("se_story_ui", "se_story_stopenv")

				if var_55_5 ~= "" then
					if arg_52_1.bgmTxt_.text ~= var_55_5 and arg_52_1.bgmTxt_.text ~= "" then
						if arg_52_1.bgmTxt2_.text ~= "" then
							arg_52_1.bgmTxt_.text = arg_52_1.bgmTxt2_.text
						end

						arg_52_1.bgmTxt2_.text = var_55_5

						arg_52_1.musicChangeAnimator_:Play("music_change", 0, 0)
					else
						arg_52_1.bgmTxt_.text = var_55_5
						arg_52_1.bgmTxt2_.text = var_55_5
					end

					if arg_52_1.bgmTimer then
						arg_52_1.bgmTimer:Stop()

						arg_52_1.bgmTimer = nil
					end

					if arg_52_1.settingData.show_music_name == 1 then
						arg_52_1.musicController:SetSelectedState("show")
						arg_52_1.musicAnimator_:Play("open", 0, 0)

						if arg_52_1.settingData.music_time ~= 0 then
							arg_52_1.bgmTimer = TimeTools.StartAfterSeconds(tonumber(arg_52_1.settingData.music_time), function()
								if arg_52_1 == nil or isNil(arg_52_1.bgmTxt_) then
									return
								end

								arg_52_1.musicController:SetSelectedState("hide")
								arg_52_1.musicAnimator_:Play("back", 0, 0)
							end, {})
						end
					end
				end
			end

			local var_55_6 = arg_52_1.actors_["1084ui_story"]
			local var_55_7 = 0

			if var_55_7 < arg_52_1.time_ and arg_52_1.time_ <= var_55_7 + arg_55_0 and not isNil(var_55_6) and arg_52_1.var_.characterEffect1084ui_story == nil then
				arg_52_1.var_.characterEffect1084ui_story = var_55_6:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_55_8 = 0.1

			if var_55_7 <= arg_52_1.time_ and arg_52_1.time_ < var_55_7 + var_55_8 and not isNil(var_55_6) then
				local var_55_9 = (arg_52_1.time_ - var_55_7) / var_55_8

				if arg_52_1.var_.characterEffect1084ui_story and not isNil(var_55_6) then
					arg_52_1.var_.characterEffect1084ui_story.fillFlat = false
				end
			end

			if arg_52_1.time_ >= var_55_7 + var_55_8 and arg_52_1.time_ < var_55_7 + var_55_8 + arg_55_0 and not isNil(var_55_6) and arg_52_1.var_.characterEffect1084ui_story then
				arg_52_1.var_.characterEffect1084ui_story.fillFlat = false
			end

			local var_55_10 = arg_52_1.actors_["1039ui_story"]
			local var_55_11 = 0

			if var_55_11 < arg_52_1.time_ and arg_52_1.time_ <= var_55_11 + arg_55_0 and not isNil(var_55_10) and arg_52_1.var_.characterEffect1039ui_story == nil then
				arg_52_1.var_.characterEffect1039ui_story = var_55_10:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_55_12 = 0.1

			if var_55_11 <= arg_52_1.time_ and arg_52_1.time_ < var_55_11 + var_55_12 and not isNil(var_55_10) then
				local var_55_13 = (arg_52_1.time_ - var_55_11) / var_55_12

				if arg_52_1.var_.characterEffect1039ui_story and not isNil(var_55_10) then
					local var_55_14 = Mathf.Lerp(0, 0.5, var_55_13)

					arg_52_1.var_.characterEffect1039ui_story.fillFlat = true
					arg_52_1.var_.characterEffect1039ui_story.fillRatio = var_55_14
				end
			end

			if arg_52_1.time_ >= var_55_11 + var_55_12 and arg_52_1.time_ < var_55_11 + var_55_12 + arg_55_0 and not isNil(var_55_10) and arg_52_1.var_.characterEffect1039ui_story then
				local var_55_15 = 0.5

				arg_52_1.var_.characterEffect1039ui_story.fillFlat = true
				arg_52_1.var_.characterEffect1039ui_story.fillRatio = var_55_15
			end

			local var_55_16 = 0

			if var_55_16 < arg_52_1.time_ and arg_52_1.time_ <= var_55_16 + arg_55_0 then
				arg_52_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3204cva")
			end

			local var_55_17 = 0
			local var_55_18 = 0.175

			if var_55_17 < arg_52_1.time_ and arg_52_1.time_ <= var_55_17 + arg_55_0 then
				arg_52_1.talkMaxDuration = 0
				arg_52_1.dialogCg_.alpha = 1

				arg_52_1.dialog_:SetActive(true)
				SetActive(arg_52_1.leftNameGo_, true)

				local var_55_19 = arg_52_1:FormatText(StoryNameCfg[6].name)

				arg_52_1.leftNameTxt_.text = var_55_19

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_52_1.leftNameTxt_.transform)

				arg_52_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_52_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_52_1:RecordName(arg_52_1.leftNameTxt_.text)
				SetActive(arg_52_1.iconTrs_.gameObject, false)
				arg_52_1.callingController_:SetSelectedState("normal")

				local var_55_20 = arg_52_1:GetWordFromCfg(100032013)
				local var_55_21 = arg_52_1:FormatText(var_55_20.content)

				arg_52_1.text_.text = var_55_21

				LuaForUtil.ClearLinePrefixSymbol(arg_52_1.text_)

				local var_55_22 = 7
				local var_55_23 = utf8.len(var_55_21)
				local var_55_24 = var_55_22 <= 0 and var_55_18 or var_55_18 * (var_55_23 / var_55_22)

				if var_55_24 > 0 and var_55_18 < var_55_24 then
					arg_52_1.talkMaxDuration = var_55_24

					if var_55_24 + var_55_17 > arg_52_1.duration_ then
						arg_52_1.duration_ = var_55_24 + var_55_17
					end
				end

				arg_52_1.text_.text = var_55_21
				arg_52_1.typewritter.percent = 0

				arg_52_1.typewritter:SetDirty()
				arg_52_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_100032", "100032013", "story_v_out_100032.awb") ~= 0 then
					local var_55_25 = manager.audio:GetVoiceLength("story_v_out_100032", "100032013", "story_v_out_100032.awb") / 1000

					if var_55_25 + var_55_17 > arg_52_1.duration_ then
						arg_52_1.duration_ = var_55_25 + var_55_17
					end

					if var_55_20.prefab_name ~= "" and arg_52_1.actors_[var_55_20.prefab_name] ~= nil then
						local var_55_26 = LuaForUtil.PlayVoiceWithCriLipsync(arg_52_1.actors_[var_55_20.prefab_name].transform, "story_v_out_100032", "100032013", "story_v_out_100032.awb")

						arg_52_1:RecordAudio("100032013", var_55_26)
						arg_52_1:RecordAudio("100032013", var_55_26)
					else
						arg_52_1:AudioAction("play", "voice", "story_v_out_100032", "100032013", "story_v_out_100032.awb")
					end

					arg_52_1:RecordHistoryTalkVoice("story_v_out_100032", "100032013", "story_v_out_100032.awb")
				end

				arg_52_1:RecordContent(arg_52_1.text_.text)
			end

			local var_55_27 = math.max(var_55_18, arg_52_1.talkMaxDuration)

			if var_55_17 <= arg_52_1.time_ and arg_52_1.time_ < var_55_17 + var_55_27 then
				arg_52_1.typewritter.percent = (arg_52_1.time_ - var_55_17) / var_55_27

				arg_52_1.typewritter:SetDirty()
			end

			if arg_52_1.time_ >= var_55_17 + var_55_27 and arg_52_1.time_ < var_55_17 + var_55_27 + arg_55_0 then
				arg_52_1.typewritter.percent = 1

				arg_52_1.typewritter:SetDirty()
				arg_52_1:ShowNextGo(true)
			end
		end

		arg_52_1.nodeConfigList_ = {}

		arg_52_1:InitPlayNodeList()
	end,
	assets = {
		"TextureConfig/Background/A06"
	},
	voices = {
		"story_v_out_100032.awb"
	}
}
