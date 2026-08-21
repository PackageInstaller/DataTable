return {
	Play104112001 = function(arg_1_0, arg_1_1)
		arg_1_1.time_ = 0
		arg_1_1.frameCnt_ = 0
		arg_1_1.state_ = "playing"
		arg_1_1.curTalkId_ = 104112001
		arg_1_1.duration_ = 11.97

		local var_1_0 = {
			ja = 11.966,
			ko = 9.7,
			zh = 8.433,
			en = 8.633
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
				arg_1_0:Play104112002(arg_1_1)
			end
		end

		function arg_1_1.onSingleLineUpdate_(arg_4_0)
			local var_4_0 = 0
			local var_4_1 = 1

			if var_4_0 < arg_1_1.time_ and arg_1_1.time_ <= var_4_0 + arg_4_0 then
				local var_4_2 = "play"
				local var_4_3 = "music"

				arg_1_1:AudioAction(var_4_2, var_4_3, "bgm_story_v1_battleground_2", "bgm_story_v1_battleground_2", "bgm_story_v1_battleground_2")

				local var_4_4 = ""
				local var_4_5 = manager.audio:GetAudioName("bgm_story_v1_battleground_2", "bgm_story_v1_battleground_2")

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

			local var_4_6 = "1148ui_story"

			if arg_1_1.actors_[var_4_6] == nil then
				local var_4_7 = Asset.Load("Char/" .. "1148ui_story")

				if not isNil(var_4_7) then
					local var_4_8 = Object.Instantiate(Asset.Load("Char/" .. "1148ui_story"), arg_1_1.stage_.transform)

					var_4_8.name = var_4_6
					var_4_8.transform.localPosition = Vector3.New(0, 100, 0)
					arg_1_1.actors_[var_4_6] = var_4_8

					local var_4_9 = var_4_8:GetComponentInChildren(typeof(CharacterEffect))

					var_4_9.enabled = true

					local var_4_10 = GameObjectTools.GetOrAddComponent(var_4_8, typeof(DynamicBoneHelper))

					if var_4_10 then
						var_4_10:EnableDynamicBone(false)
					end

					arg_1_1:ShowWeapon(var_4_9.transform, false)

					arg_1_1.var_[var_4_6 .. "Animator"] = var_4_9.gameObject:GetComponent(typeof(UnityEngine.Animator))
					arg_1_1.var_[var_4_6 .. "Animator"].applyRootMotion = true
					arg_1_1.var_[var_4_6 .. "LipSync"] = var_4_9.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
				end
			end

			local var_4_11 = arg_1_1.actors_["1148ui_story"]
			local var_4_12 = 2

			if var_4_12 < arg_1_1.time_ and arg_1_1.time_ <= var_4_12 + arg_4_0 and not isNil(var_4_11) and arg_1_1.var_.characterEffect1148ui_story == nil then
				arg_1_1.var_.characterEffect1148ui_story = var_4_11:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_4_13 = 0.1

			if var_4_12 <= arg_1_1.time_ and arg_1_1.time_ < var_4_12 + var_4_13 and not isNil(var_4_11) then
				local var_4_14 = (arg_1_1.time_ - var_4_12) / var_4_13

				if arg_1_1.var_.characterEffect1148ui_story and not isNil(var_4_11) then
					arg_1_1.var_.characterEffect1148ui_story.fillFlat = false
				end
			end

			if arg_1_1.time_ >= var_4_12 + var_4_13 and arg_1_1.time_ < var_4_12 + var_4_13 + arg_4_0 and not isNil(var_4_11) and arg_1_1.var_.characterEffect1148ui_story then
				arg_1_1.var_.characterEffect1148ui_story.fillFlat = false
			end

			local var_4_15 = "B14"

			if arg_1_1.bgs_[var_4_15] == nil then
				local var_4_16 = Object.Instantiate(arg_1_1.paintGo_)

				var_4_16:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. var_4_15)
				var_4_16.name = var_4_15
				var_4_16.transform.parent = arg_1_1.stage_.transform
				var_4_16.transform.localPosition = Vector3.New(0, 100, 0)
				arg_1_1.bgs_[var_4_15] = var_4_16
			end

			local var_4_17 = arg_1_1.bgs_.B14
			local var_4_18 = 0

			if var_4_18 < arg_1_1.time_ and arg_1_1.time_ <= var_4_18 + arg_4_0 then
				local var_4_19 = var_4_17:GetComponent("SpriteRenderer")

				if var_4_19 then
					arg_1_1.var_.alphaOldValueB14 = var_4_19.color.a
					arg_1_1.var_.alphaMatValueB14 = var_4_19
				end

				arg_1_1.var_.alphaOldValueB14 = 0
			end

			local var_4_20 = 1.5

			if var_4_18 <= arg_1_1.time_ and arg_1_1.time_ < var_4_18 + var_4_20 then
				local var_4_21 = (arg_1_1.time_ - var_4_18) / var_4_20
				local var_4_22 = Mathf.Lerp(arg_1_1.var_.alphaOldValueB14, 1, var_4_21)

				if arg_1_1.var_.alphaMatValueB14 then
					local var_4_23 = arg_1_1.var_.alphaMatValueB14.color

					var_4_23.a = var_4_22
					arg_1_1.var_.alphaMatValueB14.color = var_4_23
				end
			end

			if arg_1_1.time_ >= var_4_18 + var_4_20 and arg_1_1.time_ < var_4_18 + var_4_20 + arg_4_0 and arg_1_1.var_.alphaMatValueB14 then
				local var_4_24 = arg_1_1.var_.alphaMatValueB14
				local var_4_25 = var_4_24.color

				var_4_25.a = 1
				var_4_24.color = var_4_25
			end

			local var_4_26 = 0

			if var_4_26 < arg_1_1.time_ and arg_1_1.time_ <= var_4_26 + arg_4_0 then
				local var_4_27 = manager.ui.mainCamera.transform.localPosition
				local var_4_28 = Vector3.New(0, 0, 10) + Vector3.New(var_4_27.x, var_4_27.y, 0)
				local var_4_29 = arg_1_1.bgs_.B14

				var_4_29.transform.localPosition = var_4_28
				var_4_29.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_4_30 = var_4_29:GetComponent("SpriteRenderer")

				if var_4_30 and var_4_30.sprite then
					local var_4_31 = (var_4_29.transform.localPosition - var_4_27).z
					local var_4_32 = manager.ui.mainCameraCom_
					local var_4_33 = 2 * var_4_31 * Mathf.Tan(var_4_32.fieldOfView * 0.5 * Mathf.Deg2Rad)
					local var_4_34 = var_4_33 * var_4_32.aspect
					local var_4_35 = var_4_30.sprite.bounds.size.x
					local var_4_36 = var_4_30.sprite.bounds.size.y
					local var_4_37 = var_4_34 / var_4_35
					local var_4_38 = var_4_33 / var_4_36
					local var_4_39 = var_4_38 < var_4_37 and var_4_37 or var_4_38

					var_4_29.transform.localScale = Vector3.New(var_4_39, var_4_39, 0)
				end

				for iter_4_0, iter_4_1 in pairs(arg_1_1.bgs_) do
					if iter_4_0 ~= "B14" then
						iter_4_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_4_40 = arg_1_1.actors_["1148ui_story"].transform
			local var_4_41 = 1.79999995231628

			if var_4_41 < arg_1_1.time_ and arg_1_1.time_ <= var_4_41 + arg_4_0 then
				arg_1_1.var_.moveOldPos1148ui_story = var_4_40.localPosition
			end

			local var_4_42 = 0.001

			if var_4_41 <= arg_1_1.time_ and arg_1_1.time_ < var_4_41 + var_4_42 then
				local var_4_43 = (arg_1_1.time_ - var_4_41) / var_4_42
				local var_4_44 = Vector3.New(-0.7, -0.8, -6.2)

				var_4_40.localPosition = Vector3.Lerp(arg_1_1.var_.moveOldPos1148ui_story, var_4_44, var_4_43)

				local var_4_45 = manager.ui.mainCamera.transform.position - var_4_40.position

				var_4_40.forward = Vector3.New(var_4_45.x, var_4_45.y, var_4_45.z)

				local var_4_46 = var_4_40.localEulerAngles

				var_4_46.z = 0
				var_4_46.x = 0
				var_4_40.localEulerAngles = var_4_46
			end

			if arg_1_1.time_ >= var_4_41 + var_4_42 and arg_1_1.time_ < var_4_41 + var_4_42 + arg_4_0 then
				var_4_40.localPosition = Vector3.New(-0.7, -0.8, -6.2)

				local var_4_47 = manager.ui.mainCamera.transform.position - var_4_40.position

				var_4_40.forward = Vector3.New(var_4_47.x, var_4_47.y, var_4_47.z)

				local var_4_48 = var_4_40.localEulerAngles

				var_4_48.z = 0
				var_4_48.x = 0
				var_4_40.localEulerAngles = var_4_48
			end

			local var_4_49 = 0

			if var_4_49 < arg_1_1.time_ and arg_1_1.time_ <= var_4_49 + arg_4_0 then
				arg_1_1:PlayTimeline("1148ui_story", "StoryTimeline/CharAction/story1148/story1148action/1148action5_1")
			end

			local var_4_50 = 0

			if var_4_50 < arg_1_1.time_ and arg_1_1.time_ <= var_4_50 + arg_4_0 then
				arg_1_1.allBtn_.enabled = false
			end

			local var_4_51 = 2

			if arg_1_1.time_ >= var_4_50 + var_4_51 and arg_1_1.time_ < var_4_50 + var_4_51 + arg_4_0 then
				arg_1_1.allBtn_.enabled = true
			end

			local var_4_52 = 0

			if var_4_52 < arg_1_1.time_ and arg_1_1.time_ <= var_4_52 + arg_4_0 then
				arg_1_1:PlayTimeline("1148ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3104cva")
			end

			if arg_1_1.frameCnt_ <= 1 then
				arg_1_1.dialog_:SetActive(false)
			end

			local var_4_53 = 2
			local var_4_54 = 0.875

			if var_4_53 < arg_1_1.time_ and arg_1_1.time_ <= var_4_53 + arg_4_0 then
				arg_1_1.talkMaxDuration = 0

				arg_1_1.dialog_:SetActive(true)

				arg_1_1.dialogCg_.alpha = 0

				local var_4_55 = LeanTween.value(arg_1_1.dialog_, 0, 1, 0.3)

				var_4_55:setOnUpdate(LuaHelper.FloatAction(function(arg_6_0)
					arg_1_1.dialogCg_.alpha = arg_6_0
				end))
				var_4_55:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_1_1.dialog_)
					var_4_55:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_1_1.duration_ = arg_1_1.duration_ + 0.3

				SetActive(arg_1_1.leftNameGo_, true)

				local var_4_56 = arg_1_1:FormatText(StoryNameCfg[8].name)

				arg_1_1.leftNameTxt_.text = var_4_56

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_1_1.leftNameTxt_.transform)

				arg_1_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_1_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_1_1:RecordName(arg_1_1.leftNameTxt_.text)
				SetActive(arg_1_1.iconTrs_.gameObject, false)
				arg_1_1.callingController_:SetSelectedState("normal")

				local var_4_57 = arg_1_1:GetWordFromCfg(104112001)
				local var_4_58 = arg_1_1:FormatText(var_4_57.content)

				arg_1_1.text_.text = var_4_58

				LuaForUtil.ClearLinePrefixSymbol(arg_1_1.text_)

				local var_4_59 = 35
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

				if manager.audio:GetVoiceLength("story_v_out_104112", "104112001", "story_v_out_104112.awb") ~= 0 then
					local var_4_62 = manager.audio:GetVoiceLength("story_v_out_104112", "104112001", "story_v_out_104112.awb") / 1000

					if var_4_62 + var_4_53 > arg_1_1.duration_ then
						arg_1_1.duration_ = var_4_62 + var_4_53
					end

					if var_4_57.prefab_name ~= "" and arg_1_1.actors_[var_4_57.prefab_name] ~= nil then
						local var_4_63 = LuaForUtil.PlayVoiceWithCriLipsync(arg_1_1.actors_[var_4_57.prefab_name].transform, "story_v_out_104112", "104112001", "story_v_out_104112.awb")

						arg_1_1:RecordAudio("104112001", var_4_63)
						arg_1_1:RecordAudio("104112001", var_4_63)
					else
						arg_1_1:AudioAction("play", "voice", "story_v_out_104112", "104112001", "story_v_out_104112.awb")
					end

					arg_1_1:RecordHistoryTalkVoice("story_v_out_104112", "104112001", "story_v_out_104112.awb")
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
				actorName = "1148ui_story",
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
	Play104112002 = function(arg_8_0, arg_8_1)
		arg_8_1.time_ = 0
		arg_8_1.frameCnt_ = 0
		arg_8_1.state_ = "playing"
		arg_8_1.curTalkId_ = 104112002
		arg_8_1.duration_ = 10.4

		local var_8_0 = {
			ja = 8.533,
			ko = 7,
			zh = 10.4,
			en = 8.7
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
				arg_8_0:Play104112003(arg_8_1)
			end
		end

		function arg_8_1.onSingleLineUpdate_(arg_11_0)
			local var_11_0 = "1059ui_story"

			if arg_8_1.actors_[var_11_0] == nil then
				local var_11_1 = Asset.Load("Char/" .. "1059ui_story")

				if not isNil(var_11_1) then
					local var_11_2 = Object.Instantiate(Asset.Load("Char/" .. "1059ui_story"), arg_8_1.stage_.transform)

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

			local var_11_5 = arg_8_1.actors_["1059ui_story"]
			local var_11_6 = 0

			if var_11_6 < arg_8_1.time_ and arg_8_1.time_ <= var_11_6 + arg_11_0 and not isNil(var_11_5) and arg_8_1.var_.characterEffect1059ui_story == nil then
				arg_8_1.var_.characterEffect1059ui_story = var_11_5:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_11_7 = 0.1

			if var_11_6 <= arg_8_1.time_ and arg_8_1.time_ < var_11_6 + var_11_7 and not isNil(var_11_5) then
				local var_11_8 = (arg_8_1.time_ - var_11_6) / var_11_7

				if arg_8_1.var_.characterEffect1059ui_story and not isNil(var_11_5) then
					arg_8_1.var_.characterEffect1059ui_story.fillFlat = false
				end
			end

			if arg_8_1.time_ >= var_11_6 + var_11_7 and arg_8_1.time_ < var_11_6 + var_11_7 + arg_11_0 and not isNil(var_11_5) and arg_8_1.var_.characterEffect1059ui_story then
				arg_8_1.var_.characterEffect1059ui_story.fillFlat = false
			end

			local var_11_9 = arg_8_1.actors_["1148ui_story"]
			local var_11_10 = 0

			if var_11_10 < arg_8_1.time_ and arg_8_1.time_ <= var_11_10 + arg_11_0 and not isNil(var_11_9) and arg_8_1.var_.characterEffect1148ui_story == nil then
				arg_8_1.var_.characterEffect1148ui_story = var_11_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_11_11 = 0.1

			if var_11_10 <= arg_8_1.time_ and arg_8_1.time_ < var_11_10 + var_11_11 and not isNil(var_11_9) then
				local var_11_12 = (arg_8_1.time_ - var_11_10) / var_11_11

				if arg_8_1.var_.characterEffect1148ui_story and not isNil(var_11_9) then
					local var_11_13 = Mathf.Lerp(0, 0.5, var_11_12)

					arg_8_1.var_.characterEffect1148ui_story.fillFlat = true
					arg_8_1.var_.characterEffect1148ui_story.fillRatio = var_11_13
				end
			end

			if arg_8_1.time_ >= var_11_10 + var_11_11 and arg_8_1.time_ < var_11_10 + var_11_11 + arg_11_0 and not isNil(var_11_9) and arg_8_1.var_.characterEffect1148ui_story then
				local var_11_14 = 0.5

				arg_8_1.var_.characterEffect1148ui_story.fillFlat = true
				arg_8_1.var_.characterEffect1148ui_story.fillRatio = var_11_14
			end

			local var_11_15 = arg_8_1.actors_["1059ui_story"].transform
			local var_11_16 = 0

			if var_11_16 < arg_8_1.time_ and arg_8_1.time_ <= var_11_16 + arg_11_0 then
				arg_8_1.var_.moveOldPos1059ui_story = var_11_15.localPosition
			end

			local var_11_17 = 0.001

			if var_11_16 <= arg_8_1.time_ and arg_8_1.time_ < var_11_16 + var_11_17 then
				local var_11_18 = (arg_8_1.time_ - var_11_16) / var_11_17
				local var_11_19 = Vector3.New(0.7, -1.05, -6)

				var_11_15.localPosition = Vector3.Lerp(arg_8_1.var_.moveOldPos1059ui_story, var_11_19, var_11_18)

				local var_11_20 = manager.ui.mainCamera.transform.position - var_11_15.position

				var_11_15.forward = Vector3.New(var_11_20.x, var_11_20.y, var_11_20.z)

				local var_11_21 = var_11_15.localEulerAngles

				var_11_21.z = 0
				var_11_21.x = 0
				var_11_15.localEulerAngles = var_11_21
			end

			if arg_8_1.time_ >= var_11_16 + var_11_17 and arg_8_1.time_ < var_11_16 + var_11_17 + arg_11_0 then
				var_11_15.localPosition = Vector3.New(0.7, -1.05, -6)

				local var_11_22 = manager.ui.mainCamera.transform.position - var_11_15.position

				var_11_15.forward = Vector3.New(var_11_22.x, var_11_22.y, var_11_22.z)

				local var_11_23 = var_11_15.localEulerAngles

				var_11_23.z = 0
				var_11_23.x = 0
				var_11_15.localEulerAngles = var_11_23
			end

			local var_11_24 = 0

			if var_11_24 < arg_8_1.time_ and arg_8_1.time_ <= var_11_24 + arg_11_0 then
				arg_8_1:PlayTimeline("1059ui_story", "StoryTimeline/CharAction/story1059/story1059action/1059action3_1")
			end

			local var_11_25 = 0

			if var_11_25 < arg_8_1.time_ and arg_8_1.time_ <= var_11_25 + arg_11_0 then
				arg_8_1:PlayTimeline("1059ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0203cva")
			end

			local var_11_26 = 0
			local var_11_27 = 1

			if var_11_26 < arg_8_1.time_ and arg_8_1.time_ <= var_11_26 + arg_11_0 then
				arg_8_1.talkMaxDuration = 0
				arg_8_1.dialogCg_.alpha = 1

				arg_8_1.dialog_:SetActive(true)
				SetActive(arg_8_1.leftNameGo_, true)

				local var_11_28 = arg_8_1:FormatText(StoryNameCfg[28].name)

				arg_8_1.leftNameTxt_.text = var_11_28

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_8_1.leftNameTxt_.transform)

				arg_8_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_8_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_8_1:RecordName(arg_8_1.leftNameTxt_.text)
				SetActive(arg_8_1.iconTrs_.gameObject, false)
				arg_8_1.callingController_:SetSelectedState("normal")

				local var_11_29 = arg_8_1:GetWordFromCfg(104112002)
				local var_11_30 = arg_8_1:FormatText(var_11_29.content)

				arg_8_1.text_.text = var_11_30

				LuaForUtil.ClearLinePrefixSymbol(arg_8_1.text_)

				local var_11_31 = 42
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

				if manager.audio:GetVoiceLength("story_v_out_104112", "104112002", "story_v_out_104112.awb") ~= 0 then
					local var_11_34 = manager.audio:GetVoiceLength("story_v_out_104112", "104112002", "story_v_out_104112.awb") / 1000

					if var_11_34 + var_11_26 > arg_8_1.duration_ then
						arg_8_1.duration_ = var_11_34 + var_11_26
					end

					if var_11_29.prefab_name ~= "" and arg_8_1.actors_[var_11_29.prefab_name] ~= nil then
						local var_11_35 = LuaForUtil.PlayVoiceWithCriLipsync(arg_8_1.actors_[var_11_29.prefab_name].transform, "story_v_out_104112", "104112002", "story_v_out_104112.awb")

						arg_8_1:RecordAudio("104112002", var_11_35)
						arg_8_1:RecordAudio("104112002", var_11_35)
					else
						arg_8_1:AudioAction("play", "voice", "story_v_out_104112", "104112002", "story_v_out_104112.awb")
					end

					arg_8_1:RecordHistoryTalkVoice("story_v_out_104112", "104112002", "story_v_out_104112.awb")
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
				actorName = "1059ui_story",
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
	Play104112003 = function(arg_12_0, arg_12_1)
		arg_12_1.time_ = 0
		arg_12_1.frameCnt_ = 0
		arg_12_1.state_ = "playing"
		arg_12_1.curTalkId_ = 104112003
		arg_12_1.duration_ = 11.57

		local var_12_0 = {
			ja = 11.566,
			ko = 9.766,
			zh = 11.1,
			en = 10.433
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
				arg_12_0:Play104112004(arg_12_1)
			end
		end

		function arg_12_1.onSingleLineUpdate_(arg_15_0)
			local var_15_0 = 0

			if var_15_0 < arg_12_1.time_ and arg_12_1.time_ <= var_15_0 + arg_15_0 then
				arg_12_1:PlayTimeline("1059ui_story", "StoryTimeline/CharAction/story1059/story1059actionlink/1059action434")
			end

			local var_15_1 = 0

			if var_15_1 < arg_12_1.time_ and arg_12_1.time_ <= var_15_1 + arg_15_0 then
				arg_12_1:PlayTimeline("1059ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3204cva")
			end

			local var_15_2 = 0
			local var_15_3 = 1.175

			if var_15_2 < arg_12_1.time_ and arg_12_1.time_ <= var_15_2 + arg_15_0 then
				arg_12_1.talkMaxDuration = 0
				arg_12_1.dialogCg_.alpha = 1

				arg_12_1.dialog_:SetActive(true)
				SetActive(arg_12_1.leftNameGo_, true)

				local var_15_4 = arg_12_1:FormatText(StoryNameCfg[28].name)

				arg_12_1.leftNameTxt_.text = var_15_4

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_12_1.leftNameTxt_.transform)

				arg_12_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_12_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_12_1:RecordName(arg_12_1.leftNameTxt_.text)
				SetActive(arg_12_1.iconTrs_.gameObject, false)
				arg_12_1.callingController_:SetSelectedState("normal")

				local var_15_5 = arg_12_1:GetWordFromCfg(104112003)
				local var_15_6 = arg_12_1:FormatText(var_15_5.content)

				arg_12_1.text_.text = var_15_6

				LuaForUtil.ClearLinePrefixSymbol(arg_12_1.text_)

				local var_15_7 = 46
				local var_15_8 = utf8.len(var_15_6)
				local var_15_9 = var_15_7 <= 0 and var_15_3 or var_15_3 * (var_15_8 / var_15_7)

				if var_15_9 > 0 and var_15_3 < var_15_9 then
					arg_12_1.talkMaxDuration = var_15_9

					if var_15_9 + var_15_2 > arg_12_1.duration_ then
						arg_12_1.duration_ = var_15_9 + var_15_2
					end
				end

				arg_12_1.text_.text = var_15_6
				arg_12_1.typewritter.percent = 0

				arg_12_1.typewritter:SetDirty()
				arg_12_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_104112", "104112003", "story_v_out_104112.awb") ~= 0 then
					local var_15_10 = manager.audio:GetVoiceLength("story_v_out_104112", "104112003", "story_v_out_104112.awb") / 1000

					if var_15_10 + var_15_2 > arg_12_1.duration_ then
						arg_12_1.duration_ = var_15_10 + var_15_2
					end

					if var_15_5.prefab_name ~= "" and arg_12_1.actors_[var_15_5.prefab_name] ~= nil then
						local var_15_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_12_1.actors_[var_15_5.prefab_name].transform, "story_v_out_104112", "104112003", "story_v_out_104112.awb")

						arg_12_1:RecordAudio("104112003", var_15_11)
						arg_12_1:RecordAudio("104112003", var_15_11)
					else
						arg_12_1:AudioAction("play", "voice", "story_v_out_104112", "104112003", "story_v_out_104112.awb")
					end

					arg_12_1:RecordHistoryTalkVoice("story_v_out_104112", "104112003", "story_v_out_104112.awb")
				end

				arg_12_1:RecordContent(arg_12_1.text_.text)
			end

			local var_15_12 = math.max(var_15_3, arg_12_1.talkMaxDuration)

			if var_15_2 <= arg_12_1.time_ and arg_12_1.time_ < var_15_2 + var_15_12 then
				arg_12_1.typewritter.percent = (arg_12_1.time_ - var_15_2) / var_15_12

				arg_12_1.typewritter:SetDirty()
			end

			if arg_12_1.time_ >= var_15_2 + var_15_12 and arg_12_1.time_ < var_15_2 + var_15_12 + arg_15_0 then
				arg_12_1.typewritter.percent = 1

				arg_12_1.typewritter:SetDirty()
				arg_12_1:ShowNextGo(true)
			end
		end

		arg_12_1.nodeConfigList_ = {}

		arg_12_1:InitPlayNodeList()
	end,
	Play104112004 = function(arg_16_0, arg_16_1)
		arg_16_1.time_ = 0
		arg_16_1.frameCnt_ = 0
		arg_16_1.state_ = "playing"
		arg_16_1.curTalkId_ = 104112004
		arg_16_1.duration_ = 6.3

		local var_16_0 = {
			ja = 6.3,
			ko = 3.8,
			zh = 5.566,
			en = 4.4
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
				arg_16_0:Play104112005(arg_16_1)
			end
		end

		function arg_16_1.onSingleLineUpdate_(arg_19_0)
			local var_19_0 = "1027ui_story"

			if arg_16_1.actors_[var_19_0] == nil then
				local var_19_1 = Asset.Load("Char/" .. "1027ui_story")

				if not isNil(var_19_1) then
					local var_19_2 = Object.Instantiate(Asset.Load("Char/" .. "1027ui_story"), arg_16_1.stage_.transform)

					var_19_2.name = var_19_0
					var_19_2.transform.localPosition = Vector3.New(0, 100, 0)
					arg_16_1.actors_[var_19_0] = var_19_2

					local var_19_3 = var_19_2:GetComponentInChildren(typeof(CharacterEffect))

					var_19_3.enabled = true

					local var_19_4 = GameObjectTools.GetOrAddComponent(var_19_2, typeof(DynamicBoneHelper))

					if var_19_4 then
						var_19_4:EnableDynamicBone(false)
					end

					arg_16_1:ShowWeapon(var_19_3.transform, false)

					arg_16_1.var_[var_19_0 .. "Animator"] = var_19_3.gameObject:GetComponent(typeof(UnityEngine.Animator))
					arg_16_1.var_[var_19_0 .. "Animator"].applyRootMotion = true
					arg_16_1.var_[var_19_0 .. "LipSync"] = var_19_3.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
				end
			end

			local var_19_5 = arg_16_1.actors_["1027ui_story"]
			local var_19_6 = 0

			if var_19_6 < arg_16_1.time_ and arg_16_1.time_ <= var_19_6 + arg_19_0 and not isNil(var_19_5) and arg_16_1.var_.characterEffect1027ui_story == nil then
				arg_16_1.var_.characterEffect1027ui_story = var_19_5:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_19_7 = 0.1

			if var_19_6 <= arg_16_1.time_ and arg_16_1.time_ < var_19_6 + var_19_7 and not isNil(var_19_5) then
				local var_19_8 = (arg_16_1.time_ - var_19_6) / var_19_7

				if arg_16_1.var_.characterEffect1027ui_story and not isNil(var_19_5) then
					arg_16_1.var_.characterEffect1027ui_story.fillFlat = false
				end
			end

			if arg_16_1.time_ >= var_19_6 + var_19_7 and arg_16_1.time_ < var_19_6 + var_19_7 + arg_19_0 and not isNil(var_19_5) and arg_16_1.var_.characterEffect1027ui_story then
				arg_16_1.var_.characterEffect1027ui_story.fillFlat = false
			end

			local var_19_9 = arg_16_1.actors_["1059ui_story"]
			local var_19_10 = 0

			if var_19_10 < arg_16_1.time_ and arg_16_1.time_ <= var_19_10 + arg_19_0 and not isNil(var_19_9) and arg_16_1.var_.characterEffect1059ui_story == nil then
				arg_16_1.var_.characterEffect1059ui_story = var_19_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_19_11 = 0.1

			if var_19_10 <= arg_16_1.time_ and arg_16_1.time_ < var_19_10 + var_19_11 and not isNil(var_19_9) then
				local var_19_12 = (arg_16_1.time_ - var_19_10) / var_19_11

				if arg_16_1.var_.characterEffect1059ui_story and not isNil(var_19_9) then
					local var_19_13 = Mathf.Lerp(0, 0.5, var_19_12)

					arg_16_1.var_.characterEffect1059ui_story.fillFlat = true
					arg_16_1.var_.characterEffect1059ui_story.fillRatio = var_19_13
				end
			end

			if arg_16_1.time_ >= var_19_10 + var_19_11 and arg_16_1.time_ < var_19_10 + var_19_11 + arg_19_0 and not isNil(var_19_9) and arg_16_1.var_.characterEffect1059ui_story then
				local var_19_14 = 0.5

				arg_16_1.var_.characterEffect1059ui_story.fillFlat = true
				arg_16_1.var_.characterEffect1059ui_story.fillRatio = var_19_14
			end

			local var_19_15 = arg_16_1.actors_["1059ui_story"].transform
			local var_19_16 = 0

			if var_19_16 < arg_16_1.time_ and arg_16_1.time_ <= var_19_16 + arg_19_0 then
				arg_16_1.var_.moveOldPos1059ui_story = var_19_15.localPosition
			end

			local var_19_17 = 0.001

			if var_19_16 <= arg_16_1.time_ and arg_16_1.time_ < var_19_16 + var_19_17 then
				local var_19_18 = (arg_16_1.time_ - var_19_16) / var_19_17
				local var_19_19 = Vector3.New(0, 100, 0)

				var_19_15.localPosition = Vector3.Lerp(arg_16_1.var_.moveOldPos1059ui_story, var_19_19, var_19_18)

				local var_19_20 = manager.ui.mainCamera.transform.position - var_19_15.position

				var_19_15.forward = Vector3.New(var_19_20.x, var_19_20.y, var_19_20.z)

				local var_19_21 = var_19_15.localEulerAngles

				var_19_21.z = 0
				var_19_21.x = 0
				var_19_15.localEulerAngles = var_19_21
			end

			if arg_16_1.time_ >= var_19_16 + var_19_17 and arg_16_1.time_ < var_19_16 + var_19_17 + arg_19_0 then
				var_19_15.localPosition = Vector3.New(0, 100, 0)

				local var_19_22 = manager.ui.mainCamera.transform.position - var_19_15.position

				var_19_15.forward = Vector3.New(var_19_22.x, var_19_22.y, var_19_22.z)

				local var_19_23 = var_19_15.localEulerAngles

				var_19_23.z = 0
				var_19_23.x = 0
				var_19_15.localEulerAngles = var_19_23
			end

			local var_19_24 = arg_16_1.actors_["1148ui_story"].transform
			local var_19_25 = 0

			if var_19_25 < arg_16_1.time_ and arg_16_1.time_ <= var_19_25 + arg_19_0 then
				arg_16_1.var_.moveOldPos1148ui_story = var_19_24.localPosition
			end

			local var_19_26 = 0.001

			if var_19_25 <= arg_16_1.time_ and arg_16_1.time_ < var_19_25 + var_19_26 then
				local var_19_27 = (arg_16_1.time_ - var_19_25) / var_19_26
				local var_19_28 = Vector3.New(0, 100, 0)

				var_19_24.localPosition = Vector3.Lerp(arg_16_1.var_.moveOldPos1148ui_story, var_19_28, var_19_27)

				local var_19_29 = manager.ui.mainCamera.transform.position - var_19_24.position

				var_19_24.forward = Vector3.New(var_19_29.x, var_19_29.y, var_19_29.z)

				local var_19_30 = var_19_24.localEulerAngles

				var_19_30.z = 0
				var_19_30.x = 0
				var_19_24.localEulerAngles = var_19_30
			end

			if arg_16_1.time_ >= var_19_25 + var_19_26 and arg_16_1.time_ < var_19_25 + var_19_26 + arg_19_0 then
				var_19_24.localPosition = Vector3.New(0, 100, 0)

				local var_19_31 = manager.ui.mainCamera.transform.position - var_19_24.position

				var_19_24.forward = Vector3.New(var_19_31.x, var_19_31.y, var_19_31.z)

				local var_19_32 = var_19_24.localEulerAngles

				var_19_32.z = 0
				var_19_32.x = 0
				var_19_24.localEulerAngles = var_19_32
			end

			local var_19_33 = arg_16_1.actors_["1027ui_story"].transform
			local var_19_34 = 0

			if var_19_34 < arg_16_1.time_ and arg_16_1.time_ <= var_19_34 + arg_19_0 then
				arg_16_1.var_.moveOldPos1027ui_story = var_19_33.localPosition
			end

			local var_19_35 = 0.001

			if var_19_34 <= arg_16_1.time_ and arg_16_1.time_ < var_19_34 + var_19_35 then
				local var_19_36 = (arg_16_1.time_ - var_19_34) / var_19_35
				local var_19_37 = Vector3.New(-0.7, -0.81, -5.8)

				var_19_33.localPosition = Vector3.Lerp(arg_16_1.var_.moveOldPos1027ui_story, var_19_37, var_19_36)

				local var_19_38 = manager.ui.mainCamera.transform.position - var_19_33.position

				var_19_33.forward = Vector3.New(var_19_38.x, var_19_38.y, var_19_38.z)

				local var_19_39 = var_19_33.localEulerAngles

				var_19_39.z = 0
				var_19_39.x = 0
				var_19_33.localEulerAngles = var_19_39
			end

			if arg_16_1.time_ >= var_19_34 + var_19_35 and arg_16_1.time_ < var_19_34 + var_19_35 + arg_19_0 then
				var_19_33.localPosition = Vector3.New(-0.7, -0.81, -5.8)

				local var_19_40 = manager.ui.mainCamera.transform.position - var_19_33.position

				var_19_33.forward = Vector3.New(var_19_40.x, var_19_40.y, var_19_40.z)

				local var_19_41 = var_19_33.localEulerAngles

				var_19_41.z = 0
				var_19_41.x = 0
				var_19_33.localEulerAngles = var_19_41
			end

			local var_19_42 = 0

			if var_19_42 < arg_16_1.time_ and arg_16_1.time_ <= var_19_42 + arg_19_0 then
				arg_16_1:PlayTimeline("1027ui_story", "StoryTimeline/CharAction/story1027/story1027action/1027action3_1")
			end

			local var_19_43 = "1080ui_story"

			if arg_16_1.actors_[var_19_43] == nil then
				local var_19_44 = Asset.Load("Char/" .. "1080ui_story")

				if not isNil(var_19_44) then
					local var_19_45 = Object.Instantiate(Asset.Load("Char/" .. "1080ui_story"), arg_16_1.stage_.transform)

					var_19_45.name = var_19_43
					var_19_45.transform.localPosition = Vector3.New(0, 100, 0)
					arg_16_1.actors_[var_19_43] = var_19_45

					local var_19_46 = var_19_45:GetComponentInChildren(typeof(CharacterEffect))

					var_19_46.enabled = true

					local var_19_47 = GameObjectTools.GetOrAddComponent(var_19_45, typeof(DynamicBoneHelper))

					if var_19_47 then
						var_19_47:EnableDynamicBone(false)
					end

					arg_16_1:ShowWeapon(var_19_46.transform, false)

					arg_16_1.var_[var_19_43 .. "Animator"] = var_19_46.gameObject:GetComponent(typeof(UnityEngine.Animator))
					arg_16_1.var_[var_19_43 .. "Animator"].applyRootMotion = true
					arg_16_1.var_[var_19_43 .. "LipSync"] = var_19_46.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
				end
			end

			local var_19_48 = 0

			if var_19_48 < arg_16_1.time_ and arg_16_1.time_ <= var_19_48 + arg_19_0 then
				arg_16_1:PlayTimeline("1080ui_story", "StoryTimeline/CharAction/story1080/story1080action/1080action7_1")
			end

			local var_19_49 = 0

			if var_19_49 < arg_16_1.time_ and arg_16_1.time_ <= var_19_49 + arg_19_0 then
				arg_16_1:PlayTimeline("1027ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface2102cva")
			end

			local var_19_50 = 0
			local var_19_51 = 0.5

			if var_19_50 < arg_16_1.time_ and arg_16_1.time_ <= var_19_50 + arg_19_0 then
				arg_16_1.talkMaxDuration = 0
				arg_16_1.dialogCg_.alpha = 1

				arg_16_1.dialog_:SetActive(true)
				SetActive(arg_16_1.leftNameGo_, true)

				local var_19_52 = arg_16_1:FormatText(StoryNameCfg[56].name)

				arg_16_1.leftNameTxt_.text = var_19_52

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_16_1.leftNameTxt_.transform)

				arg_16_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_16_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_16_1:RecordName(arg_16_1.leftNameTxt_.text)
				SetActive(arg_16_1.iconTrs_.gameObject, false)
				arg_16_1.callingController_:SetSelectedState("normal")

				local var_19_53 = arg_16_1:GetWordFromCfg(104112004)
				local var_19_54 = arg_16_1:FormatText(var_19_53.content)

				arg_16_1.text_.text = var_19_54

				LuaForUtil.ClearLinePrefixSymbol(arg_16_1.text_)

				local var_19_55 = 20
				local var_19_56 = utf8.len(var_19_54)
				local var_19_57 = var_19_55 <= 0 and var_19_51 or var_19_51 * (var_19_56 / var_19_55)

				if var_19_57 > 0 and var_19_51 < var_19_57 then
					arg_16_1.talkMaxDuration = var_19_57

					if var_19_57 + var_19_50 > arg_16_1.duration_ then
						arg_16_1.duration_ = var_19_57 + var_19_50
					end
				end

				arg_16_1.text_.text = var_19_54
				arg_16_1.typewritter.percent = 0

				arg_16_1.typewritter:SetDirty()
				arg_16_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_104112", "104112004", "story_v_out_104112.awb") ~= 0 then
					local var_19_58 = manager.audio:GetVoiceLength("story_v_out_104112", "104112004", "story_v_out_104112.awb") / 1000

					if var_19_58 + var_19_50 > arg_16_1.duration_ then
						arg_16_1.duration_ = var_19_58 + var_19_50
					end

					if var_19_53.prefab_name ~= "" and arg_16_1.actors_[var_19_53.prefab_name] ~= nil then
						local var_19_59 = LuaForUtil.PlayVoiceWithCriLipsync(arg_16_1.actors_[var_19_53.prefab_name].transform, "story_v_out_104112", "104112004", "story_v_out_104112.awb")

						arg_16_1:RecordAudio("104112004", var_19_59)
						arg_16_1:RecordAudio("104112004", var_19_59)
					else
						arg_16_1:AudioAction("play", "voice", "story_v_out_104112", "104112004", "story_v_out_104112.awb")
					end

					arg_16_1:RecordHistoryTalkVoice("story_v_out_104112", "104112004", "story_v_out_104112.awb")
				end

				arg_16_1:RecordContent(arg_16_1.text_.text)
			end

			local var_19_60 = math.max(var_19_51, arg_16_1.talkMaxDuration)

			if var_19_50 <= arg_16_1.time_ and arg_16_1.time_ < var_19_50 + var_19_60 then
				arg_16_1.typewritter.percent = (arg_16_1.time_ - var_19_50) / var_19_60

				arg_16_1.typewritter:SetDirty()
			end

			if arg_16_1.time_ >= var_19_50 + var_19_60 and arg_16_1.time_ < var_19_50 + var_19_60 + arg_19_0 then
				arg_16_1.typewritter.percent = 1

				arg_16_1.typewritter:SetDirty()
				arg_16_1:ShowNextGo(true)
			end
		end

		arg_16_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1059ui_story",
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
			},
			{
				assetPath = "",
				actorName = "1027ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.033,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_16_1:InitPlayNodeList()
	end,
	Play104112005 = function(arg_20_0, arg_20_1)
		arg_20_1.time_ = 0
		arg_20_1.frameCnt_ = 0
		arg_20_1.state_ = "playing"
		arg_20_1.curTalkId_ = 104112005
		arg_20_1.duration_ = 8.97

		local var_20_0 = {
			ja = 8.966,
			ko = 6.5,
			zh = 5.233,
			en = 6.066
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
				arg_20_0:Play104112006(arg_20_1)
			end
		end

		function arg_20_1.onSingleLineUpdate_(arg_23_0)
			local var_23_0 = arg_20_1.actors_["1080ui_story"]
			local var_23_1 = 0

			if var_23_1 < arg_20_1.time_ and arg_20_1.time_ <= var_23_1 + arg_23_0 and not isNil(var_23_0) and arg_20_1.var_.characterEffect1080ui_story == nil then
				arg_20_1.var_.characterEffect1080ui_story = var_23_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_23_2 = 0.1

			if var_23_1 <= arg_20_1.time_ and arg_20_1.time_ < var_23_1 + var_23_2 and not isNil(var_23_0) then
				local var_23_3 = (arg_20_1.time_ - var_23_1) / var_23_2

				if arg_20_1.var_.characterEffect1080ui_story and not isNil(var_23_0) then
					arg_20_1.var_.characterEffect1080ui_story.fillFlat = false
				end
			end

			if arg_20_1.time_ >= var_23_1 + var_23_2 and arg_20_1.time_ < var_23_1 + var_23_2 + arg_23_0 and not isNil(var_23_0) and arg_20_1.var_.characterEffect1080ui_story then
				arg_20_1.var_.characterEffect1080ui_story.fillFlat = false
			end

			local var_23_4 = arg_20_1.actors_["1027ui_story"]
			local var_23_5 = 0

			if var_23_5 < arg_20_1.time_ and arg_20_1.time_ <= var_23_5 + arg_23_0 and not isNil(var_23_4) and arg_20_1.var_.characterEffect1027ui_story == nil then
				arg_20_1.var_.characterEffect1027ui_story = var_23_4:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_23_6 = 0.1

			if var_23_5 <= arg_20_1.time_ and arg_20_1.time_ < var_23_5 + var_23_6 and not isNil(var_23_4) then
				local var_23_7 = (arg_20_1.time_ - var_23_5) / var_23_6

				if arg_20_1.var_.characterEffect1027ui_story and not isNil(var_23_4) then
					local var_23_8 = Mathf.Lerp(0, 0.5, var_23_7)

					arg_20_1.var_.characterEffect1027ui_story.fillFlat = true
					arg_20_1.var_.characterEffect1027ui_story.fillRatio = var_23_8
				end
			end

			if arg_20_1.time_ >= var_23_5 + var_23_6 and arg_20_1.time_ < var_23_5 + var_23_6 + arg_23_0 and not isNil(var_23_4) and arg_20_1.var_.characterEffect1027ui_story then
				local var_23_9 = 0.5

				arg_20_1.var_.characterEffect1027ui_story.fillFlat = true
				arg_20_1.var_.characterEffect1027ui_story.fillRatio = var_23_9
			end

			local var_23_10 = arg_20_1.actors_["1080ui_story"].transform
			local var_23_11 = 0

			if var_23_11 < arg_20_1.time_ and arg_20_1.time_ <= var_23_11 + arg_23_0 then
				arg_20_1.var_.moveOldPos1080ui_story = var_23_10.localPosition
			end

			local var_23_12 = 0.001

			if var_23_11 <= arg_20_1.time_ and arg_20_1.time_ < var_23_11 + var_23_12 then
				local var_23_13 = (arg_20_1.time_ - var_23_11) / var_23_12
				local var_23_14 = Vector3.New(0.7, -1.01, -6.05)

				var_23_10.localPosition = Vector3.Lerp(arg_20_1.var_.moveOldPos1080ui_story, var_23_14, var_23_13)

				local var_23_15 = manager.ui.mainCamera.transform.position - var_23_10.position

				var_23_10.forward = Vector3.New(var_23_15.x, var_23_15.y, var_23_15.z)

				local var_23_16 = var_23_10.localEulerAngles

				var_23_16.z = 0
				var_23_16.x = 0
				var_23_10.localEulerAngles = var_23_16
			end

			if arg_20_1.time_ >= var_23_11 + var_23_12 and arg_20_1.time_ < var_23_11 + var_23_12 + arg_23_0 then
				var_23_10.localPosition = Vector3.New(0.7, -1.01, -6.05)

				local var_23_17 = manager.ui.mainCamera.transform.position - var_23_10.position

				var_23_10.forward = Vector3.New(var_23_17.x, var_23_17.y, var_23_17.z)

				local var_23_18 = var_23_10.localEulerAngles

				var_23_18.z = 0
				var_23_18.x = 0
				var_23_10.localEulerAngles = var_23_18
			end

			local var_23_19 = 0

			if var_23_19 < arg_20_1.time_ and arg_20_1.time_ <= var_23_19 + arg_23_0 then
				arg_20_1:PlayTimeline("1080ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_23_20 = 0
			local var_23_21 = 0.725

			if var_23_20 < arg_20_1.time_ and arg_20_1.time_ <= var_23_20 + arg_23_0 then
				arg_20_1.talkMaxDuration = 0
				arg_20_1.dialogCg_.alpha = 1

				arg_20_1.dialog_:SetActive(true)
				SetActive(arg_20_1.leftNameGo_, true)

				local var_23_22 = arg_20_1:FormatText(StoryNameCfg[55].name)

				arg_20_1.leftNameTxt_.text = var_23_22

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_20_1.leftNameTxt_.transform)

				arg_20_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_20_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_20_1:RecordName(arg_20_1.leftNameTxt_.text)
				SetActive(arg_20_1.iconTrs_.gameObject, false)
				arg_20_1.callingController_:SetSelectedState("normal")

				local var_23_23 = arg_20_1:GetWordFromCfg(104112005)
				local var_23_24 = arg_20_1:FormatText(var_23_23.content)

				arg_20_1.text_.text = var_23_24

				LuaForUtil.ClearLinePrefixSymbol(arg_20_1.text_)

				local var_23_25 = 29
				local var_23_26 = utf8.len(var_23_24)
				local var_23_27 = var_23_25 <= 0 and var_23_21 or var_23_21 * (var_23_26 / var_23_25)

				if var_23_27 > 0 and var_23_21 < var_23_27 then
					arg_20_1.talkMaxDuration = var_23_27

					if var_23_27 + var_23_20 > arg_20_1.duration_ then
						arg_20_1.duration_ = var_23_27 + var_23_20
					end
				end

				arg_20_1.text_.text = var_23_24
				arg_20_1.typewritter.percent = 0

				arg_20_1.typewritter:SetDirty()
				arg_20_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_104112", "104112005", "story_v_out_104112.awb") ~= 0 then
					local var_23_28 = manager.audio:GetVoiceLength("story_v_out_104112", "104112005", "story_v_out_104112.awb") / 1000

					if var_23_28 + var_23_20 > arg_20_1.duration_ then
						arg_20_1.duration_ = var_23_28 + var_23_20
					end

					if var_23_23.prefab_name ~= "" and arg_20_1.actors_[var_23_23.prefab_name] ~= nil then
						local var_23_29 = LuaForUtil.PlayVoiceWithCriLipsync(arg_20_1.actors_[var_23_23.prefab_name].transform, "story_v_out_104112", "104112005", "story_v_out_104112.awb")

						arg_20_1:RecordAudio("104112005", var_23_29)
						arg_20_1:RecordAudio("104112005", var_23_29)
					else
						arg_20_1:AudioAction("play", "voice", "story_v_out_104112", "104112005", "story_v_out_104112.awb")
					end

					arg_20_1:RecordHistoryTalkVoice("story_v_out_104112", "104112005", "story_v_out_104112.awb")
				end

				arg_20_1:RecordContent(arg_20_1.text_.text)
			end

			local var_23_30 = math.max(var_23_21, arg_20_1.talkMaxDuration)

			if var_23_20 <= arg_20_1.time_ and arg_20_1.time_ < var_23_20 + var_23_30 then
				arg_20_1.typewritter.percent = (arg_20_1.time_ - var_23_20) / var_23_30

				arg_20_1.typewritter:SetDirty()
			end

			if arg_20_1.time_ >= var_23_20 + var_23_30 and arg_20_1.time_ < var_23_20 + var_23_30 + arg_23_0 then
				arg_20_1.typewritter.percent = 1

				arg_20_1.typewritter:SetDirty()
				arg_20_1:ShowNextGo(true)
			end
		end

		arg_20_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1080ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.033,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_20_1:InitPlayNodeList()
	end,
	Play104112006 = function(arg_24_0, arg_24_1)
		arg_24_1.time_ = 0
		arg_24_1.frameCnt_ = 0
		arg_24_1.state_ = "playing"
		arg_24_1.curTalkId_ = 104112006
		arg_24_1.duration_ = 3.8

		local var_24_0 = {
			ja = 3.133,
			ko = 2.7,
			zh = 3.8,
			en = 2.966
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
				arg_24_0:Play104112007(arg_24_1)
			end
		end

		function arg_24_1.onSingleLineUpdate_(arg_27_0)
			local var_27_0 = arg_24_1.actors_["1059ui_story"]
			local var_27_1 = 0

			if var_27_1 < arg_24_1.time_ and arg_24_1.time_ <= var_27_1 + arg_27_0 and not isNil(var_27_0) and arg_24_1.var_.characterEffect1059ui_story == nil then
				arg_24_1.var_.characterEffect1059ui_story = var_27_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_27_2 = 0.1

			if var_27_1 <= arg_24_1.time_ and arg_24_1.time_ < var_27_1 + var_27_2 and not isNil(var_27_0) then
				local var_27_3 = (arg_24_1.time_ - var_27_1) / var_27_2

				if arg_24_1.var_.characterEffect1059ui_story and not isNil(var_27_0) then
					arg_24_1.var_.characterEffect1059ui_story.fillFlat = false
				end
			end

			if arg_24_1.time_ >= var_27_1 + var_27_2 and arg_24_1.time_ < var_27_1 + var_27_2 + arg_27_0 and not isNil(var_27_0) and arg_24_1.var_.characterEffect1059ui_story then
				arg_24_1.var_.characterEffect1059ui_story.fillFlat = false
			end

			local var_27_4 = arg_24_1.actors_["1080ui_story"]
			local var_27_5 = 0

			if var_27_5 < arg_24_1.time_ and arg_24_1.time_ <= var_27_5 + arg_27_0 and not isNil(var_27_4) and arg_24_1.var_.characterEffect1080ui_story == nil then
				arg_24_1.var_.characterEffect1080ui_story = var_27_4:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_27_6 = 0.1

			if var_27_5 <= arg_24_1.time_ and arg_24_1.time_ < var_27_5 + var_27_6 and not isNil(var_27_4) then
				local var_27_7 = (arg_24_1.time_ - var_27_5) / var_27_6

				if arg_24_1.var_.characterEffect1080ui_story and not isNil(var_27_4) then
					local var_27_8 = Mathf.Lerp(0, 0.5, var_27_7)

					arg_24_1.var_.characterEffect1080ui_story.fillFlat = true
					arg_24_1.var_.characterEffect1080ui_story.fillRatio = var_27_8
				end
			end

			if arg_24_1.time_ >= var_27_5 + var_27_6 and arg_24_1.time_ < var_27_5 + var_27_6 + arg_27_0 and not isNil(var_27_4) and arg_24_1.var_.characterEffect1080ui_story then
				local var_27_9 = 0.5

				arg_24_1.var_.characterEffect1080ui_story.fillFlat = true
				arg_24_1.var_.characterEffect1080ui_story.fillRatio = var_27_9
			end

			local var_27_10 = arg_24_1.actors_["1080ui_story"].transform
			local var_27_11 = 0

			if var_27_11 < arg_24_1.time_ and arg_24_1.time_ <= var_27_11 + arg_27_0 then
				arg_24_1.var_.moveOldPos1080ui_story = var_27_10.localPosition
			end

			local var_27_12 = 0.001

			if var_27_11 <= arg_24_1.time_ and arg_24_1.time_ < var_27_11 + var_27_12 then
				local var_27_13 = (arg_24_1.time_ - var_27_11) / var_27_12
				local var_27_14 = Vector3.New(0, 100, 0)

				var_27_10.localPosition = Vector3.Lerp(arg_24_1.var_.moveOldPos1080ui_story, var_27_14, var_27_13)

				local var_27_15 = manager.ui.mainCamera.transform.position - var_27_10.position

				var_27_10.forward = Vector3.New(var_27_15.x, var_27_15.y, var_27_15.z)

				local var_27_16 = var_27_10.localEulerAngles

				var_27_16.z = 0
				var_27_16.x = 0
				var_27_10.localEulerAngles = var_27_16
			end

			if arg_24_1.time_ >= var_27_11 + var_27_12 and arg_24_1.time_ < var_27_11 + var_27_12 + arg_27_0 then
				var_27_10.localPosition = Vector3.New(0, 100, 0)

				local var_27_17 = manager.ui.mainCamera.transform.position - var_27_10.position

				var_27_10.forward = Vector3.New(var_27_17.x, var_27_17.y, var_27_17.z)

				local var_27_18 = var_27_10.localEulerAngles

				var_27_18.z = 0
				var_27_18.x = 0
				var_27_10.localEulerAngles = var_27_18
			end

			local var_27_19 = arg_24_1.actors_["1027ui_story"].transform
			local var_27_20 = 0

			if var_27_20 < arg_24_1.time_ and arg_24_1.time_ <= var_27_20 + arg_27_0 then
				arg_24_1.var_.moveOldPos1027ui_story = var_27_19.localPosition
			end

			local var_27_21 = 0.001

			if var_27_20 <= arg_24_1.time_ and arg_24_1.time_ < var_27_20 + var_27_21 then
				local var_27_22 = (arg_24_1.time_ - var_27_20) / var_27_21
				local var_27_23 = Vector3.New(0, 100, 0)

				var_27_19.localPosition = Vector3.Lerp(arg_24_1.var_.moveOldPos1027ui_story, var_27_23, var_27_22)

				local var_27_24 = manager.ui.mainCamera.transform.position - var_27_19.position

				var_27_19.forward = Vector3.New(var_27_24.x, var_27_24.y, var_27_24.z)

				local var_27_25 = var_27_19.localEulerAngles

				var_27_25.z = 0
				var_27_25.x = 0
				var_27_19.localEulerAngles = var_27_25
			end

			if arg_24_1.time_ >= var_27_20 + var_27_21 and arg_24_1.time_ < var_27_20 + var_27_21 + arg_27_0 then
				var_27_19.localPosition = Vector3.New(0, 100, 0)

				local var_27_26 = manager.ui.mainCamera.transform.position - var_27_19.position

				var_27_19.forward = Vector3.New(var_27_26.x, var_27_26.y, var_27_26.z)

				local var_27_27 = var_27_19.localEulerAngles

				var_27_27.z = 0
				var_27_27.x = 0
				var_27_19.localEulerAngles = var_27_27
			end

			local var_27_28 = arg_24_1.actors_["1059ui_story"].transform
			local var_27_29 = 0

			if var_27_29 < arg_24_1.time_ and arg_24_1.time_ <= var_27_29 + arg_27_0 then
				arg_24_1.var_.moveOldPos1059ui_story = var_27_28.localPosition
			end

			local var_27_30 = 0.001

			if var_27_29 <= arg_24_1.time_ and arg_24_1.time_ < var_27_29 + var_27_30 then
				local var_27_31 = (arg_24_1.time_ - var_27_29) / var_27_30
				local var_27_32 = Vector3.New(0, -1.05, -6)

				var_27_28.localPosition = Vector3.Lerp(arg_24_1.var_.moveOldPos1059ui_story, var_27_32, var_27_31)

				local var_27_33 = manager.ui.mainCamera.transform.position - var_27_28.position

				var_27_28.forward = Vector3.New(var_27_33.x, var_27_33.y, var_27_33.z)

				local var_27_34 = var_27_28.localEulerAngles

				var_27_34.z = 0
				var_27_34.x = 0
				var_27_28.localEulerAngles = var_27_34
			end

			if arg_24_1.time_ >= var_27_29 + var_27_30 and arg_24_1.time_ < var_27_29 + var_27_30 + arg_27_0 then
				var_27_28.localPosition = Vector3.New(0, -1.05, -6)

				local var_27_35 = manager.ui.mainCamera.transform.position - var_27_28.position

				var_27_28.forward = Vector3.New(var_27_35.x, var_27_35.y, var_27_35.z)

				local var_27_36 = var_27_28.localEulerAngles

				var_27_36.z = 0
				var_27_36.x = 0
				var_27_28.localEulerAngles = var_27_36
			end

			local var_27_37 = 0

			if var_27_37 < arg_24_1.time_ and arg_24_1.time_ <= var_27_37 + arg_27_0 then
				arg_24_1:PlayTimeline("1059ui_story", "StoryTimeline/CharAction/story1059/story1059action/1059action4_1")
			end

			local var_27_38 = 0

			if var_27_38 < arg_24_1.time_ and arg_24_1.time_ <= var_27_38 + arg_27_0 then
				arg_24_1:PlayTimeline("1059ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1204cva")
			end

			local var_27_39 = 0
			local var_27_40 = 0.475

			if var_27_39 < arg_24_1.time_ and arg_24_1.time_ <= var_27_39 + arg_27_0 then
				arg_24_1.talkMaxDuration = 0
				arg_24_1.dialogCg_.alpha = 1

				arg_24_1.dialog_:SetActive(true)
				SetActive(arg_24_1.leftNameGo_, true)

				local var_27_41 = arg_24_1:FormatText(StoryNameCfg[28].name)

				arg_24_1.leftNameTxt_.text = var_27_41

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_24_1.leftNameTxt_.transform)

				arg_24_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_24_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_24_1:RecordName(arg_24_1.leftNameTxt_.text)
				SetActive(arg_24_1.iconTrs_.gameObject, false)
				arg_24_1.callingController_:SetSelectedState("normal")

				local var_27_42 = arg_24_1:GetWordFromCfg(104112006)
				local var_27_43 = arg_24_1:FormatText(var_27_42.content)

				arg_24_1.text_.text = var_27_43

				LuaForUtil.ClearLinePrefixSymbol(arg_24_1.text_)

				local var_27_44 = 19
				local var_27_45 = utf8.len(var_27_43)
				local var_27_46 = var_27_44 <= 0 and var_27_40 or var_27_40 * (var_27_45 / var_27_44)

				if var_27_46 > 0 and var_27_40 < var_27_46 then
					arg_24_1.talkMaxDuration = var_27_46

					if var_27_46 + var_27_39 > arg_24_1.duration_ then
						arg_24_1.duration_ = var_27_46 + var_27_39
					end
				end

				arg_24_1.text_.text = var_27_43
				arg_24_1.typewritter.percent = 0

				arg_24_1.typewritter:SetDirty()
				arg_24_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_104112", "104112006", "story_v_out_104112.awb") ~= 0 then
					local var_27_47 = manager.audio:GetVoiceLength("story_v_out_104112", "104112006", "story_v_out_104112.awb") / 1000

					if var_27_47 + var_27_39 > arg_24_1.duration_ then
						arg_24_1.duration_ = var_27_47 + var_27_39
					end

					if var_27_42.prefab_name ~= "" and arg_24_1.actors_[var_27_42.prefab_name] ~= nil then
						local var_27_48 = LuaForUtil.PlayVoiceWithCriLipsync(arg_24_1.actors_[var_27_42.prefab_name].transform, "story_v_out_104112", "104112006", "story_v_out_104112.awb")

						arg_24_1:RecordAudio("104112006", var_27_48)
						arg_24_1:RecordAudio("104112006", var_27_48)
					else
						arg_24_1:AudioAction("play", "voice", "story_v_out_104112", "104112006", "story_v_out_104112.awb")
					end

					arg_24_1:RecordHistoryTalkVoice("story_v_out_104112", "104112006", "story_v_out_104112.awb")
				end

				arg_24_1:RecordContent(arg_24_1.text_.text)
			end

			local var_27_49 = math.max(var_27_40, arg_24_1.talkMaxDuration)

			if var_27_39 <= arg_24_1.time_ and arg_24_1.time_ < var_27_39 + var_27_49 then
				arg_24_1.typewritter.percent = (arg_24_1.time_ - var_27_39) / var_27_49

				arg_24_1.typewritter:SetDirty()
			end

			if arg_24_1.time_ >= var_27_39 + var_27_49 and arg_24_1.time_ < var_27_39 + var_27_49 + arg_27_0 then
				arg_24_1.typewritter.percent = 1

				arg_24_1.typewritter:SetDirty()
				arg_24_1:ShowNextGo(true)
			end
		end

		arg_24_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1080ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.033,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1027ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.033,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1059ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.033,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_24_1:InitPlayNodeList()
	end,
	Play104112007 = function(arg_28_0, arg_28_1)
		arg_28_1.time_ = 0
		arg_28_1.frameCnt_ = 0
		arg_28_1.state_ = "playing"
		arg_28_1.curTalkId_ = 104112007
		arg_28_1.duration_ = 9.6

		local var_28_0 = {
			ja = 9.6,
			ko = 4.5,
			zh = 4.933,
			en = 4.7
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
				arg_28_0:Play104112008(arg_28_1)
			end
		end

		function arg_28_1.onSingleLineUpdate_(arg_31_0)
			local var_31_0 = 0

			if var_31_0 < arg_28_1.time_ and arg_28_1.time_ <= var_31_0 + arg_31_0 then
				arg_28_1:PlayTimeline("1059ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_31_1 = 0
			local var_31_2 = 0.55

			if var_31_1 < arg_28_1.time_ and arg_28_1.time_ <= var_31_1 + arg_31_0 then
				arg_28_1.talkMaxDuration = 0
				arg_28_1.dialogCg_.alpha = 1

				arg_28_1.dialog_:SetActive(true)
				SetActive(arg_28_1.leftNameGo_, true)

				local var_31_3 = arg_28_1:FormatText(StoryNameCfg[28].name)

				arg_28_1.leftNameTxt_.text = var_31_3

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_28_1.leftNameTxt_.transform)

				arg_28_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_28_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_28_1:RecordName(arg_28_1.leftNameTxt_.text)
				SetActive(arg_28_1.iconTrs_.gameObject, false)
				arg_28_1.callingController_:SetSelectedState("normal")

				local var_31_4 = arg_28_1:GetWordFromCfg(104112007)
				local var_31_5 = arg_28_1:FormatText(var_31_4.content)

				arg_28_1.text_.text = var_31_5

				LuaForUtil.ClearLinePrefixSymbol(arg_28_1.text_)

				local var_31_6 = 22
				local var_31_7 = utf8.len(var_31_5)
				local var_31_8 = var_31_6 <= 0 and var_31_2 or var_31_2 * (var_31_7 / var_31_6)

				if var_31_8 > 0 and var_31_2 < var_31_8 then
					arg_28_1.talkMaxDuration = var_31_8

					if var_31_8 + var_31_1 > arg_28_1.duration_ then
						arg_28_1.duration_ = var_31_8 + var_31_1
					end
				end

				arg_28_1.text_.text = var_31_5
				arg_28_1.typewritter.percent = 0

				arg_28_1.typewritter:SetDirty()
				arg_28_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_104112", "104112007", "story_v_out_104112.awb") ~= 0 then
					local var_31_9 = manager.audio:GetVoiceLength("story_v_out_104112", "104112007", "story_v_out_104112.awb") / 1000

					if var_31_9 + var_31_1 > arg_28_1.duration_ then
						arg_28_1.duration_ = var_31_9 + var_31_1
					end

					if var_31_4.prefab_name ~= "" and arg_28_1.actors_[var_31_4.prefab_name] ~= nil then
						local var_31_10 = LuaForUtil.PlayVoiceWithCriLipsync(arg_28_1.actors_[var_31_4.prefab_name].transform, "story_v_out_104112", "104112007", "story_v_out_104112.awb")

						arg_28_1:RecordAudio("104112007", var_31_10)
						arg_28_1:RecordAudio("104112007", var_31_10)
					else
						arg_28_1:AudioAction("play", "voice", "story_v_out_104112", "104112007", "story_v_out_104112.awb")
					end

					arg_28_1:RecordHistoryTalkVoice("story_v_out_104112", "104112007", "story_v_out_104112.awb")
				end

				arg_28_1:RecordContent(arg_28_1.text_.text)
			end

			local var_31_11 = math.max(var_31_2, arg_28_1.talkMaxDuration)

			if var_31_1 <= arg_28_1.time_ and arg_28_1.time_ < var_31_1 + var_31_11 then
				arg_28_1.typewritter.percent = (arg_28_1.time_ - var_31_1) / var_31_11

				arg_28_1.typewritter:SetDirty()
			end

			if arg_28_1.time_ >= var_31_1 + var_31_11 and arg_28_1.time_ < var_31_1 + var_31_11 + arg_31_0 then
				arg_28_1.typewritter.percent = 1

				arg_28_1.typewritter:SetDirty()
				arg_28_1:ShowNextGo(true)
			end
		end

		arg_28_1.nodeConfigList_ = {}

		arg_28_1:InitPlayNodeList()
	end,
	Play104112008 = function(arg_32_0, arg_32_1)
		arg_32_1.time_ = 0
		arg_32_1.frameCnt_ = 0
		arg_32_1.state_ = "playing"
		arg_32_1.curTalkId_ = 104112008
		arg_32_1.duration_ = 3.7

		local var_32_0 = {
			ja = 3.7,
			ko = 2.3,
			zh = 2.533,
			en = 2.333
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
				arg_32_0:Play104112009(arg_32_1)
			end
		end

		function arg_32_1.onSingleLineUpdate_(arg_35_0)
			local var_35_0 = 0
			local var_35_1 = 1

			if var_35_0 < arg_32_1.time_ and arg_32_1.time_ <= var_35_0 + arg_35_0 then
				local var_35_2 = "play"
				local var_35_3 = "effect"

				arg_32_1:AudioAction(var_35_2, var_35_3, "se_story", "se_story_robot_short", "")
			end

			local var_35_4 = "3005_tpose"

			if arg_32_1.actors_[var_35_4] == nil then
				local var_35_5 = Asset.Load("Char/" .. "3005_tpose")

				if not isNil(var_35_5) then
					local var_35_6 = Object.Instantiate(Asset.Load("Char/" .. "3005_tpose"), arg_32_1.stage_.transform)

					var_35_6.name = var_35_4
					var_35_6.transform.localPosition = Vector3.New(0, 100, 0)
					arg_32_1.actors_[var_35_4] = var_35_6

					local var_35_7 = var_35_6:GetComponentInChildren(typeof(CharacterEffect))

					var_35_7.enabled = true

					local var_35_8 = GameObjectTools.GetOrAddComponent(var_35_6, typeof(DynamicBoneHelper))

					if var_35_8 then
						var_35_8:EnableDynamicBone(false)
					end

					arg_32_1:ShowWeapon(var_35_7.transform, false)

					arg_32_1.var_[var_35_4 .. "Animator"] = var_35_7.gameObject:GetComponent(typeof(UnityEngine.Animator))
					arg_32_1.var_[var_35_4 .. "Animator"].applyRootMotion = true
					arg_32_1.var_[var_35_4 .. "LipSync"] = var_35_7.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
				end
			end

			local var_35_9 = arg_32_1.actors_["3005_tpose"]
			local var_35_10 = 0

			if var_35_10 < arg_32_1.time_ and arg_32_1.time_ <= var_35_10 + arg_35_0 and not isNil(var_35_9) and arg_32_1.var_.characterEffect3005_tpose == nil then
				arg_32_1.var_.characterEffect3005_tpose = var_35_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_35_11 = 0.1

			if var_35_10 <= arg_32_1.time_ and arg_32_1.time_ < var_35_10 + var_35_11 and not isNil(var_35_9) then
				local var_35_12 = (arg_32_1.time_ - var_35_10) / var_35_11

				if arg_32_1.var_.characterEffect3005_tpose and not isNil(var_35_9) then
					arg_32_1.var_.characterEffect3005_tpose.fillFlat = false
				end
			end

			if arg_32_1.time_ >= var_35_10 + var_35_11 and arg_32_1.time_ < var_35_10 + var_35_11 + arg_35_0 and not isNil(var_35_9) and arg_32_1.var_.characterEffect3005_tpose then
				arg_32_1.var_.characterEffect3005_tpose.fillFlat = false
			end

			local var_35_13 = arg_32_1.actors_["1059ui_story"]
			local var_35_14 = 0

			if var_35_14 < arg_32_1.time_ and arg_32_1.time_ <= var_35_14 + arg_35_0 and not isNil(var_35_13) and arg_32_1.var_.characterEffect1059ui_story == nil then
				arg_32_1.var_.characterEffect1059ui_story = var_35_13:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_35_15 = 0.1

			if var_35_14 <= arg_32_1.time_ and arg_32_1.time_ < var_35_14 + var_35_15 and not isNil(var_35_13) then
				local var_35_16 = (arg_32_1.time_ - var_35_14) / var_35_15

				if arg_32_1.var_.characterEffect1059ui_story and not isNil(var_35_13) then
					local var_35_17 = Mathf.Lerp(0, 0.5, var_35_16)

					arg_32_1.var_.characterEffect1059ui_story.fillFlat = true
					arg_32_1.var_.characterEffect1059ui_story.fillRatio = var_35_17
				end
			end

			if arg_32_1.time_ >= var_35_14 + var_35_15 and arg_32_1.time_ < var_35_14 + var_35_15 + arg_35_0 and not isNil(var_35_13) and arg_32_1.var_.characterEffect1059ui_story then
				local var_35_18 = 0.5

				arg_32_1.var_.characterEffect1059ui_story.fillFlat = true
				arg_32_1.var_.characterEffect1059ui_story.fillRatio = var_35_18
			end

			local var_35_19 = arg_32_1.actors_["1059ui_story"].transform
			local var_35_20 = 0

			if var_35_20 < arg_32_1.time_ and arg_32_1.time_ <= var_35_20 + arg_35_0 then
				arg_32_1.var_.moveOldPos1059ui_story = var_35_19.localPosition
			end

			local var_35_21 = 0.001

			if var_35_20 <= arg_32_1.time_ and arg_32_1.time_ < var_35_20 + var_35_21 then
				local var_35_22 = (arg_32_1.time_ - var_35_20) / var_35_21
				local var_35_23 = Vector3.New(0, 100, 0)

				var_35_19.localPosition = Vector3.Lerp(arg_32_1.var_.moveOldPos1059ui_story, var_35_23, var_35_22)

				local var_35_24 = manager.ui.mainCamera.transform.position - var_35_19.position

				var_35_19.forward = Vector3.New(var_35_24.x, var_35_24.y, var_35_24.z)

				local var_35_25 = var_35_19.localEulerAngles

				var_35_25.z = 0
				var_35_25.x = 0
				var_35_19.localEulerAngles = var_35_25
			end

			if arg_32_1.time_ >= var_35_20 + var_35_21 and arg_32_1.time_ < var_35_20 + var_35_21 + arg_35_0 then
				var_35_19.localPosition = Vector3.New(0, 100, 0)

				local var_35_26 = manager.ui.mainCamera.transform.position - var_35_19.position

				var_35_19.forward = Vector3.New(var_35_26.x, var_35_26.y, var_35_26.z)

				local var_35_27 = var_35_19.localEulerAngles

				var_35_27.z = 0
				var_35_27.x = 0
				var_35_19.localEulerAngles = var_35_27
			end

			local var_35_28 = arg_32_1.actors_["3005_tpose"].transform
			local var_35_29 = 0

			if var_35_29 < arg_32_1.time_ and arg_32_1.time_ <= var_35_29 + arg_35_0 then
				arg_32_1.var_.moveOldPos3005_tpose = var_35_28.localPosition

				local var_35_30 = GameObjectTools.GetOrAddComponent(var_35_28.gameObject, typeof(DynamicBoneHelper))

				if var_35_30 then
					var_35_30:EnableDynamicBone(false)
				end
			end

			local var_35_31 = 0.001

			if var_35_29 <= arg_32_1.time_ and arg_32_1.time_ < var_35_29 + var_35_31 then
				local var_35_32 = (arg_32_1.time_ - var_35_29) / var_35_31
				local var_35_33 = Vector3.New(0, -1.95, -2.63)

				var_35_28.localPosition = Vector3.Lerp(arg_32_1.var_.moveOldPos3005_tpose, var_35_33, var_35_32)

				local var_35_34 = manager.ui.mainCamera.transform.position - var_35_28.position

				var_35_28.forward = Vector3.New(var_35_34.x, var_35_34.y, var_35_34.z)

				local var_35_35 = var_35_28.localEulerAngles

				var_35_35.z = 0
				var_35_35.x = 0
				var_35_28.localEulerAngles = var_35_35
			end

			if arg_32_1.time_ >= var_35_29 + var_35_31 and arg_32_1.time_ < var_35_29 + var_35_31 + arg_35_0 then
				var_35_28.localPosition = Vector3.New(0, -1.95, -2.63)

				local var_35_36 = manager.ui.mainCamera.transform.position - var_35_28.position

				var_35_28.forward = Vector3.New(var_35_36.x, var_35_36.y, var_35_36.z)

				local var_35_37 = var_35_28.localEulerAngles

				var_35_37.z = 0
				var_35_37.x = 0
				var_35_28.localEulerAngles = var_35_37

				local var_35_38 = GameObjectTools.GetOrAddComponent(var_35_28.gameObject, typeof(DynamicBoneHelper))

				if var_35_38 then
					var_35_38:EnableDynamicBone(true)
				end
			end

			local var_35_39 = 0

			if var_35_39 < arg_32_1.time_ and arg_32_1.time_ <= var_35_39 + arg_35_0 then
				arg_32_1:PlayTimeline("3005_tpose", "StoryTimeline/CharAction/story3005/story3005action/3005action1_1")
			end

			local var_35_40 = 0
			local var_35_41 = 0.175

			if var_35_40 < arg_32_1.time_ and arg_32_1.time_ <= var_35_40 + arg_35_0 then
				arg_32_1.talkMaxDuration = 0
				arg_32_1.dialogCg_.alpha = 1

				arg_32_1.dialog_:SetActive(true)
				SetActive(arg_32_1.leftNameGo_, true)

				local var_35_42 = arg_32_1:FormatText(StoryNameCfg[58].name)

				arg_32_1.leftNameTxt_.text = var_35_42

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_32_1.leftNameTxt_.transform)

				arg_32_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_32_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_32_1:RecordName(arg_32_1.leftNameTxt_.text)
				SetActive(arg_32_1.iconTrs_.gameObject, false)
				arg_32_1.callingController_:SetSelectedState("normal")

				local var_35_43 = arg_32_1:GetWordFromCfg(104112008)
				local var_35_44 = arg_32_1:FormatText(var_35_43.content)

				arg_32_1.text_.text = var_35_44

				LuaForUtil.ClearLinePrefixSymbol(arg_32_1.text_)

				local var_35_45 = 7
				local var_35_46 = utf8.len(var_35_44)
				local var_35_47 = var_35_45 <= 0 and var_35_41 or var_35_41 * (var_35_46 / var_35_45)

				if var_35_47 > 0 and var_35_41 < var_35_47 then
					arg_32_1.talkMaxDuration = var_35_47

					if var_35_47 + var_35_40 > arg_32_1.duration_ then
						arg_32_1.duration_ = var_35_47 + var_35_40
					end
				end

				arg_32_1.text_.text = var_35_44
				arg_32_1.typewritter.percent = 0

				arg_32_1.typewritter:SetDirty()
				arg_32_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_104112", "104112008", "story_v_out_104112.awb") ~= 0 then
					local var_35_48 = manager.audio:GetVoiceLength("story_v_out_104112", "104112008", "story_v_out_104112.awb") / 1000

					if var_35_48 + var_35_40 > arg_32_1.duration_ then
						arg_32_1.duration_ = var_35_48 + var_35_40
					end

					if var_35_43.prefab_name ~= "" and arg_32_1.actors_[var_35_43.prefab_name] ~= nil then
						local var_35_49 = LuaForUtil.PlayVoiceWithCriLipsync(arg_32_1.actors_[var_35_43.prefab_name].transform, "story_v_out_104112", "104112008", "story_v_out_104112.awb")

						arg_32_1:RecordAudio("104112008", var_35_49)
						arg_32_1:RecordAudio("104112008", var_35_49)
					else
						arg_32_1:AudioAction("play", "voice", "story_v_out_104112", "104112008", "story_v_out_104112.awb")
					end

					arg_32_1:RecordHistoryTalkVoice("story_v_out_104112", "104112008", "story_v_out_104112.awb")
				end

				arg_32_1:RecordContent(arg_32_1.text_.text)
			end

			local var_35_50 = math.max(var_35_41, arg_32_1.talkMaxDuration)

			if var_35_40 <= arg_32_1.time_ and arg_32_1.time_ < var_35_40 + var_35_50 then
				arg_32_1.typewritter.percent = (arg_32_1.time_ - var_35_40) / var_35_50

				arg_32_1.typewritter:SetDirty()
			end

			if arg_32_1.time_ >= var_35_40 + var_35_50 and arg_32_1.time_ < var_35_40 + var_35_50 + arg_35_0 then
				arg_32_1.typewritter.percent = 1

				arg_32_1.typewritter:SetDirty()
				arg_32_1:ShowNextGo(true)
			end
		end

		arg_32_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1059ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.033,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "3005_tpose",
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
	Play104112009 = function(arg_36_0, arg_36_1)
		arg_36_1.time_ = 0
		arg_36_1.frameCnt_ = 0
		arg_36_1.state_ = "playing"
		arg_36_1.curTalkId_ = 104112009
		arg_36_1.duration_ = 6.23

		local var_36_0 = {
			ja = 5.466,
			ko = 3.9,
			zh = 4.666,
			en = 6.233
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
				arg_36_0:Play104112010(arg_36_1)
			end
		end

		function arg_36_1.onSingleLineUpdate_(arg_39_0)
			local var_39_0 = arg_36_1.actors_["1027ui_story"]
			local var_39_1 = 0

			if var_39_1 < arg_36_1.time_ and arg_36_1.time_ <= var_39_1 + arg_39_0 and not isNil(var_39_0) and arg_36_1.var_.characterEffect1027ui_story == nil then
				arg_36_1.var_.characterEffect1027ui_story = var_39_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_39_2 = 0.1

			if var_39_1 <= arg_36_1.time_ and arg_36_1.time_ < var_39_1 + var_39_2 and not isNil(var_39_0) then
				local var_39_3 = (arg_36_1.time_ - var_39_1) / var_39_2

				if arg_36_1.var_.characterEffect1027ui_story and not isNil(var_39_0) then
					arg_36_1.var_.characterEffect1027ui_story.fillFlat = false
				end
			end

			if arg_36_1.time_ >= var_39_1 + var_39_2 and arg_36_1.time_ < var_39_1 + var_39_2 + arg_39_0 and not isNil(var_39_0) and arg_36_1.var_.characterEffect1027ui_story then
				arg_36_1.var_.characterEffect1027ui_story.fillFlat = false
			end

			local var_39_4 = arg_36_1.actors_["3005_tpose"]
			local var_39_5 = 0

			if var_39_5 < arg_36_1.time_ and arg_36_1.time_ <= var_39_5 + arg_39_0 and not isNil(var_39_4) and arg_36_1.var_.characterEffect3005_tpose == nil then
				arg_36_1.var_.characterEffect3005_tpose = var_39_4:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_39_6 = 0.1

			if var_39_5 <= arg_36_1.time_ and arg_36_1.time_ < var_39_5 + var_39_6 and not isNil(var_39_4) then
				local var_39_7 = (arg_36_1.time_ - var_39_5) / var_39_6

				if arg_36_1.var_.characterEffect3005_tpose and not isNil(var_39_4) then
					local var_39_8 = Mathf.Lerp(0, 0.5, var_39_7)

					arg_36_1.var_.characterEffect3005_tpose.fillFlat = true
					arg_36_1.var_.characterEffect3005_tpose.fillRatio = var_39_8
				end
			end

			if arg_36_1.time_ >= var_39_5 + var_39_6 and arg_36_1.time_ < var_39_5 + var_39_6 + arg_39_0 and not isNil(var_39_4) and arg_36_1.var_.characterEffect3005_tpose then
				local var_39_9 = 0.5

				arg_36_1.var_.characterEffect3005_tpose.fillFlat = true
				arg_36_1.var_.characterEffect3005_tpose.fillRatio = var_39_9
			end

			local var_39_10 = arg_36_1.actors_["3005_tpose"].transform
			local var_39_11 = 0

			if var_39_11 < arg_36_1.time_ and arg_36_1.time_ <= var_39_11 + arg_39_0 then
				arg_36_1.var_.moveOldPos3005_tpose = var_39_10.localPosition

				local var_39_12 = GameObjectTools.GetOrAddComponent(var_39_10.gameObject, typeof(DynamicBoneHelper))

				if var_39_12 then
					var_39_12:EnableDynamicBone(false)
				end
			end

			local var_39_13 = 0.001

			if var_39_11 <= arg_36_1.time_ and arg_36_1.time_ < var_39_11 + var_39_13 then
				local var_39_14 = (arg_36_1.time_ - var_39_11) / var_39_13
				local var_39_15 = Vector3.New(0, 100, 0)

				var_39_10.localPosition = Vector3.Lerp(arg_36_1.var_.moveOldPos3005_tpose, var_39_15, var_39_14)

				local var_39_16 = manager.ui.mainCamera.transform.position - var_39_10.position

				var_39_10.forward = Vector3.New(var_39_16.x, var_39_16.y, var_39_16.z)

				local var_39_17 = var_39_10.localEulerAngles

				var_39_17.z = 0
				var_39_17.x = 0
				var_39_10.localEulerAngles = var_39_17
			end

			if arg_36_1.time_ >= var_39_11 + var_39_13 and arg_36_1.time_ < var_39_11 + var_39_13 + arg_39_0 then
				var_39_10.localPosition = Vector3.New(0, 100, 0)

				local var_39_18 = manager.ui.mainCamera.transform.position - var_39_10.position

				var_39_10.forward = Vector3.New(var_39_18.x, var_39_18.y, var_39_18.z)

				local var_39_19 = var_39_10.localEulerAngles

				var_39_19.z = 0
				var_39_19.x = 0
				var_39_10.localEulerAngles = var_39_19

				local var_39_20 = GameObjectTools.GetOrAddComponent(var_39_10.gameObject, typeof(DynamicBoneHelper))

				if var_39_20 then
					var_39_20:EnableDynamicBone(true)
				end
			end

			local var_39_21 = 0

			if var_39_21 < arg_36_1.time_ and arg_36_1.time_ <= var_39_21 + arg_39_0 then
				arg_36_1:PlayTimeline("1027ui_story", "StoryTimeline/CharAction/story1027/story1027action/1027action4_1")
			end

			local var_39_22 = arg_36_1.actors_["1027ui_story"].transform
			local var_39_23 = 0

			if var_39_23 < arg_36_1.time_ and arg_36_1.time_ <= var_39_23 + arg_39_0 then
				arg_36_1.var_.moveOldPos1027ui_story = var_39_22.localPosition
			end

			local var_39_24 = 0.001

			if var_39_23 <= arg_36_1.time_ and arg_36_1.time_ < var_39_23 + var_39_24 then
				local var_39_25 = (arg_36_1.time_ - var_39_23) / var_39_24
				local var_39_26 = Vector3.New(0, -0.81, -5.8)

				var_39_22.localPosition = Vector3.Lerp(arg_36_1.var_.moveOldPos1027ui_story, var_39_26, var_39_25)

				local var_39_27 = manager.ui.mainCamera.transform.position - var_39_22.position

				var_39_22.forward = Vector3.New(var_39_27.x, var_39_27.y, var_39_27.z)

				local var_39_28 = var_39_22.localEulerAngles

				var_39_28.z = 0
				var_39_28.x = 0
				var_39_22.localEulerAngles = var_39_28
			end

			if arg_36_1.time_ >= var_39_23 + var_39_24 and arg_36_1.time_ < var_39_23 + var_39_24 + arg_39_0 then
				var_39_22.localPosition = Vector3.New(0, -0.81, -5.8)

				local var_39_29 = manager.ui.mainCamera.transform.position - var_39_22.position

				var_39_22.forward = Vector3.New(var_39_29.x, var_39_29.y, var_39_29.z)

				local var_39_30 = var_39_22.localEulerAngles

				var_39_30.z = 0
				var_39_30.x = 0
				var_39_22.localEulerAngles = var_39_30
			end

			local var_39_31 = 0

			if var_39_31 < arg_36_1.time_ and arg_36_1.time_ <= var_39_31 + arg_39_0 then
				arg_36_1:PlayTimeline("1027ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3102cva")
			end

			local var_39_32 = 0
			local var_39_33 = 0.55

			if var_39_32 < arg_36_1.time_ and arg_36_1.time_ <= var_39_32 + arg_39_0 then
				arg_36_1.talkMaxDuration = 0
				arg_36_1.dialogCg_.alpha = 1

				arg_36_1.dialog_:SetActive(true)
				SetActive(arg_36_1.leftNameGo_, true)

				local var_39_34 = arg_36_1:FormatText(StoryNameCfg[56].name)

				arg_36_1.leftNameTxt_.text = var_39_34

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_36_1.leftNameTxt_.transform)

				arg_36_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_36_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_36_1:RecordName(arg_36_1.leftNameTxt_.text)
				SetActive(arg_36_1.iconTrs_.gameObject, false)
				arg_36_1.callingController_:SetSelectedState("normal")

				local var_39_35 = arg_36_1:GetWordFromCfg(104112009)
				local var_39_36 = arg_36_1:FormatText(var_39_35.content)

				arg_36_1.text_.text = var_39_36

				LuaForUtil.ClearLinePrefixSymbol(arg_36_1.text_)

				local var_39_37 = 22
				local var_39_38 = utf8.len(var_39_36)
				local var_39_39 = var_39_37 <= 0 and var_39_33 or var_39_33 * (var_39_38 / var_39_37)

				if var_39_39 > 0 and var_39_33 < var_39_39 then
					arg_36_1.talkMaxDuration = var_39_39

					if var_39_39 + var_39_32 > arg_36_1.duration_ then
						arg_36_1.duration_ = var_39_39 + var_39_32
					end
				end

				arg_36_1.text_.text = var_39_36
				arg_36_1.typewritter.percent = 0

				arg_36_1.typewritter:SetDirty()
				arg_36_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_104112", "104112009", "story_v_out_104112.awb") ~= 0 then
					local var_39_40 = manager.audio:GetVoiceLength("story_v_out_104112", "104112009", "story_v_out_104112.awb") / 1000

					if var_39_40 + var_39_32 > arg_36_1.duration_ then
						arg_36_1.duration_ = var_39_40 + var_39_32
					end

					if var_39_35.prefab_name ~= "" and arg_36_1.actors_[var_39_35.prefab_name] ~= nil then
						local var_39_41 = LuaForUtil.PlayVoiceWithCriLipsync(arg_36_1.actors_[var_39_35.prefab_name].transform, "story_v_out_104112", "104112009", "story_v_out_104112.awb")

						arg_36_1:RecordAudio("104112009", var_39_41)
						arg_36_1:RecordAudio("104112009", var_39_41)
					else
						arg_36_1:AudioAction("play", "voice", "story_v_out_104112", "104112009", "story_v_out_104112.awb")
					end

					arg_36_1:RecordHistoryTalkVoice("story_v_out_104112", "104112009", "story_v_out_104112.awb")
				end

				arg_36_1:RecordContent(arg_36_1.text_.text)
			end

			local var_39_42 = math.max(var_39_33, arg_36_1.talkMaxDuration)

			if var_39_32 <= arg_36_1.time_ and arg_36_1.time_ < var_39_32 + var_39_42 then
				arg_36_1.typewritter.percent = (arg_36_1.time_ - var_39_32) / var_39_42

				arg_36_1.typewritter:SetDirty()
			end

			if arg_36_1.time_ >= var_39_32 + var_39_42 and arg_36_1.time_ < var_39_32 + var_39_42 + arg_39_0 then
				arg_36_1.typewritter.percent = 1

				arg_36_1.typewritter:SetDirty()
				arg_36_1:ShowNextGo(true)
			end
		end

		arg_36_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "3005_tpose",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.033,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1027ui_story",
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
	Play104112010 = function(arg_40_0, arg_40_1)
		arg_40_1.time_ = 0
		arg_40_1.frameCnt_ = 0
		arg_40_1.state_ = "playing"
		arg_40_1.curTalkId_ = 104112010
		arg_40_1.duration_ = 2.3

		local var_40_0 = {
			ja = 2.3,
			ko = 1,
			zh = 1.5,
			en = 1.033
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
				arg_40_0:Play104112011(arg_40_1)
			end
		end

		function arg_40_1.onSingleLineUpdate_(arg_43_0)
			local var_43_0 = arg_40_1.actors_["1027ui_story"].transform
			local var_43_1 = 0

			if var_43_1 < arg_40_1.time_ and arg_40_1.time_ <= var_43_1 + arg_43_0 then
				arg_40_1.var_.moveOldPos1027ui_story = var_43_0.localPosition
			end

			local var_43_2 = 0.001

			if var_43_1 <= arg_40_1.time_ and arg_40_1.time_ < var_43_1 + var_43_2 then
				local var_43_3 = (arg_40_1.time_ - var_43_1) / var_43_2
				local var_43_4 = Vector3.New(0, 100, 0)

				var_43_0.localPosition = Vector3.Lerp(arg_40_1.var_.moveOldPos1027ui_story, var_43_4, var_43_3)

				local var_43_5 = manager.ui.mainCamera.transform.position - var_43_0.position

				var_43_0.forward = Vector3.New(var_43_5.x, var_43_5.y, var_43_5.z)

				local var_43_6 = var_43_0.localEulerAngles

				var_43_6.z = 0
				var_43_6.x = 0
				var_43_0.localEulerAngles = var_43_6
			end

			if arg_40_1.time_ >= var_43_1 + var_43_2 and arg_40_1.time_ < var_43_1 + var_43_2 + arg_43_0 then
				var_43_0.localPosition = Vector3.New(0, 100, 0)

				local var_43_7 = manager.ui.mainCamera.transform.position - var_43_0.position

				var_43_0.forward = Vector3.New(var_43_7.x, var_43_7.y, var_43_7.z)

				local var_43_8 = var_43_0.localEulerAngles

				var_43_8.z = 0
				var_43_8.x = 0
				var_43_0.localEulerAngles = var_43_8
			end

			local var_43_9 = 0
			local var_43_10 = 0.075

			if var_43_9 < arg_40_1.time_ and arg_40_1.time_ <= var_43_9 + arg_43_0 then
				arg_40_1.talkMaxDuration = 0
				arg_40_1.dialogCg_.alpha = 1

				arg_40_1.dialog_:SetActive(true)
				SetActive(arg_40_1.leftNameGo_, true)

				local var_43_11 = arg_40_1:FormatText(StoryNameCfg[55].name)

				arg_40_1.leftNameTxt_.text = var_43_11

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_40_1.leftNameTxt_.transform)

				arg_40_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_40_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_40_1:RecordName(arg_40_1.leftNameTxt_.text)
				SetActive(arg_40_1.iconTrs_.gameObject, true)
				arg_40_1.iconController_:SetSelectedState("hero")

				arg_40_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_1080")

				arg_40_1.callingController_:SetSelectedState("normal")

				arg_40_1.keyicon_.color = Color.New(1, 1, 1)
				arg_40_1.icon_.color = Color.New(1, 1, 1)

				local var_43_12 = arg_40_1:GetWordFromCfg(104112010)
				local var_43_13 = arg_40_1:FormatText(var_43_12.content)

				arg_40_1.text_.text = var_43_13

				LuaForUtil.ClearLinePrefixSymbol(arg_40_1.text_)

				local var_43_14 = 3
				local var_43_15 = utf8.len(var_43_13)
				local var_43_16 = var_43_14 <= 0 and var_43_10 or var_43_10 * (var_43_15 / var_43_14)

				if var_43_16 > 0 and var_43_10 < var_43_16 then
					arg_40_1.talkMaxDuration = var_43_16

					if var_43_16 + var_43_9 > arg_40_1.duration_ then
						arg_40_1.duration_ = var_43_16 + var_43_9
					end
				end

				arg_40_1.text_.text = var_43_13
				arg_40_1.typewritter.percent = 0

				arg_40_1.typewritter:SetDirty()
				arg_40_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_104112", "104112010", "story_v_out_104112.awb") ~= 0 then
					local var_43_17 = manager.audio:GetVoiceLength("story_v_out_104112", "104112010", "story_v_out_104112.awb") / 1000

					if var_43_17 + var_43_9 > arg_40_1.duration_ then
						arg_40_1.duration_ = var_43_17 + var_43_9
					end

					if var_43_12.prefab_name ~= "" and arg_40_1.actors_[var_43_12.prefab_name] ~= nil then
						local var_43_18 = LuaForUtil.PlayVoiceWithCriLipsync(arg_40_1.actors_[var_43_12.prefab_name].transform, "story_v_out_104112", "104112010", "story_v_out_104112.awb")

						arg_40_1:RecordAudio("104112010", var_43_18)
						arg_40_1:RecordAudio("104112010", var_43_18)
					else
						arg_40_1:AudioAction("play", "voice", "story_v_out_104112", "104112010", "story_v_out_104112.awb")
					end

					arg_40_1:RecordHistoryTalkVoice("story_v_out_104112", "104112010", "story_v_out_104112.awb")
				end

				arg_40_1:RecordContent(arg_40_1.text_.text)
			end

			local var_43_19 = math.max(var_43_10, arg_40_1.talkMaxDuration)

			if var_43_9 <= arg_40_1.time_ and arg_40_1.time_ < var_43_9 + var_43_19 then
				arg_40_1.typewritter.percent = (arg_40_1.time_ - var_43_9) / var_43_19

				arg_40_1.typewritter:SetDirty()
			end

			if arg_40_1.time_ >= var_43_9 + var_43_19 and arg_40_1.time_ < var_43_9 + var_43_19 + arg_43_0 then
				arg_40_1.typewritter.percent = 1

				arg_40_1.typewritter:SetDirty()
				arg_40_1:ShowNextGo(true)
			end
		end

		arg_40_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1027ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.033,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_40_1:InitPlayNodeList()
	end,
	Play104112011 = function(arg_44_0, arg_44_1)
		arg_44_1.time_ = 0
		arg_44_1.frameCnt_ = 0
		arg_44_1.state_ = "playing"
		arg_44_1.curTalkId_ = 104112011
		arg_44_1.duration_ = 5

		SetActive(arg_44_1.tipsGo_, false)

		function arg_44_1.onSingleLineFinish_()
			arg_44_1.onSingleLineUpdate_ = nil
			arg_44_1.onSingleLineFinish_ = nil
			arg_44_1.state_ = "waiting"
		end

		function arg_44_1.playNext_(arg_46_0)
			if arg_46_0 == 1 then
				arg_44_0:Play104112012(arg_44_1)
			end
		end

		function arg_44_1.onSingleLineUpdate_(arg_47_0)
			local var_47_0 = 0
			local var_47_1 = 0.7

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

				local var_47_2 = arg_44_1:GetWordFromCfg(104112011)
				local var_47_3 = arg_44_1:FormatText(var_47_2.content)

				arg_44_1.text_.text = var_47_3

				LuaForUtil.ClearLinePrefixSymbol(arg_44_1.text_)

				local var_47_4 = 28
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
	Play104112012 = function(arg_48_0, arg_48_1)
		arg_48_1.time_ = 0
		arg_48_1.frameCnt_ = 0
		arg_48_1.state_ = "playing"
		arg_48_1.curTalkId_ = 104112012
		arg_48_1.duration_ = 7.7

		local var_48_0 = {
			ja = 7.7,
			ko = 5.066,
			zh = 6.433,
			en = 7.166
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
				arg_48_0:Play104112013(arg_48_1)
			end
		end

		function arg_48_1.onSingleLineUpdate_(arg_51_0)
			local var_51_0 = arg_48_1.actors_["1027ui_story"]
			local var_51_1 = 0

			if var_51_1 < arg_48_1.time_ and arg_48_1.time_ <= var_51_1 + arg_51_0 and not isNil(var_51_0) and arg_48_1.var_.characterEffect1027ui_story == nil then
				arg_48_1.var_.characterEffect1027ui_story = var_51_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_51_2 = 0.1

			if var_51_1 <= arg_48_1.time_ and arg_48_1.time_ < var_51_1 + var_51_2 and not isNil(var_51_0) then
				local var_51_3 = (arg_48_1.time_ - var_51_1) / var_51_2

				if arg_48_1.var_.characterEffect1027ui_story and not isNil(var_51_0) then
					arg_48_1.var_.characterEffect1027ui_story.fillFlat = false
				end
			end

			if arg_48_1.time_ >= var_51_1 + var_51_2 and arg_48_1.time_ < var_51_1 + var_51_2 + arg_51_0 and not isNil(var_51_0) and arg_48_1.var_.characterEffect1027ui_story then
				arg_48_1.var_.characterEffect1027ui_story.fillFlat = false
			end

			local var_51_4 = arg_48_1.actors_["1027ui_story"].transform
			local var_51_5 = 0

			if var_51_5 < arg_48_1.time_ and arg_48_1.time_ <= var_51_5 + arg_51_0 then
				arg_48_1.var_.moveOldPos1027ui_story = var_51_4.localPosition
			end

			local var_51_6 = 0.001

			if var_51_5 <= arg_48_1.time_ and arg_48_1.time_ < var_51_5 + var_51_6 then
				local var_51_7 = (arg_48_1.time_ - var_51_5) / var_51_6
				local var_51_8 = Vector3.New(-0.7, -0.81, -5.8)

				var_51_4.localPosition = Vector3.Lerp(arg_48_1.var_.moveOldPos1027ui_story, var_51_8, var_51_7)

				local var_51_9 = manager.ui.mainCamera.transform.position - var_51_4.position

				var_51_4.forward = Vector3.New(var_51_9.x, var_51_9.y, var_51_9.z)

				local var_51_10 = var_51_4.localEulerAngles

				var_51_10.z = 0
				var_51_10.x = 0
				var_51_4.localEulerAngles = var_51_10
			end

			if arg_48_1.time_ >= var_51_5 + var_51_6 and arg_48_1.time_ < var_51_5 + var_51_6 + arg_51_0 then
				var_51_4.localPosition = Vector3.New(-0.7, -0.81, -5.8)

				local var_51_11 = manager.ui.mainCamera.transform.position - var_51_4.position

				var_51_4.forward = Vector3.New(var_51_11.x, var_51_11.y, var_51_11.z)

				local var_51_12 = var_51_4.localEulerAngles

				var_51_12.z = 0
				var_51_12.x = 0
				var_51_4.localEulerAngles = var_51_12
			end

			local var_51_13 = 0

			if var_51_13 < arg_48_1.time_ and arg_48_1.time_ <= var_51_13 + arg_51_0 then
				arg_48_1:PlayTimeline("1027ui_story", "StoryTimeline/CharAction/story1027/story1027action/1027action6_1")
			end

			local var_51_14 = 0

			if var_51_14 < arg_48_1.time_ and arg_48_1.time_ <= var_51_14 + arg_51_0 then
				arg_48_1:PlayTimeline("1027ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3202cva")
			end

			local var_51_15 = 0
			local var_51_16 = 0.75

			if var_51_15 < arg_48_1.time_ and arg_48_1.time_ <= var_51_15 + arg_51_0 then
				arg_48_1.talkMaxDuration = 0
				arg_48_1.dialogCg_.alpha = 1

				arg_48_1.dialog_:SetActive(true)
				SetActive(arg_48_1.leftNameGo_, true)

				local var_51_17 = arg_48_1:FormatText(StoryNameCfg[56].name)

				arg_48_1.leftNameTxt_.text = var_51_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_48_1.leftNameTxt_.transform)

				arg_48_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_48_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_48_1:RecordName(arg_48_1.leftNameTxt_.text)
				SetActive(arg_48_1.iconTrs_.gameObject, false)
				arg_48_1.callingController_:SetSelectedState("normal")

				local var_51_18 = arg_48_1:GetWordFromCfg(104112012)
				local var_51_19 = arg_48_1:FormatText(var_51_18.content)

				arg_48_1.text_.text = var_51_19

				LuaForUtil.ClearLinePrefixSymbol(arg_48_1.text_)

				local var_51_20 = 30
				local var_51_21 = utf8.len(var_51_19)
				local var_51_22 = var_51_20 <= 0 and var_51_16 or var_51_16 * (var_51_21 / var_51_20)

				if var_51_22 > 0 and var_51_16 < var_51_22 then
					arg_48_1.talkMaxDuration = var_51_22

					if var_51_22 + var_51_15 > arg_48_1.duration_ then
						arg_48_1.duration_ = var_51_22 + var_51_15
					end
				end

				arg_48_1.text_.text = var_51_19
				arg_48_1.typewritter.percent = 0

				arg_48_1.typewritter:SetDirty()
				arg_48_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_104112", "104112012", "story_v_out_104112.awb") ~= 0 then
					local var_51_23 = manager.audio:GetVoiceLength("story_v_out_104112", "104112012", "story_v_out_104112.awb") / 1000

					if var_51_23 + var_51_15 > arg_48_1.duration_ then
						arg_48_1.duration_ = var_51_23 + var_51_15
					end

					if var_51_18.prefab_name ~= "" and arg_48_1.actors_[var_51_18.prefab_name] ~= nil then
						local var_51_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_48_1.actors_[var_51_18.prefab_name].transform, "story_v_out_104112", "104112012", "story_v_out_104112.awb")

						arg_48_1:RecordAudio("104112012", var_51_24)
						arg_48_1:RecordAudio("104112012", var_51_24)
					else
						arg_48_1:AudioAction("play", "voice", "story_v_out_104112", "104112012", "story_v_out_104112.awb")
					end

					arg_48_1:RecordHistoryTalkVoice("story_v_out_104112", "104112012", "story_v_out_104112.awb")
				end

				arg_48_1:RecordContent(arg_48_1.text_.text)
			end

			local var_51_25 = math.max(var_51_16, arg_48_1.talkMaxDuration)

			if var_51_15 <= arg_48_1.time_ and arg_48_1.time_ < var_51_15 + var_51_25 then
				arg_48_1.typewritter.percent = (arg_48_1.time_ - var_51_15) / var_51_25

				arg_48_1.typewritter:SetDirty()
			end

			if arg_48_1.time_ >= var_51_15 + var_51_25 and arg_48_1.time_ < var_51_15 + var_51_25 + arg_51_0 then
				arg_48_1.typewritter.percent = 1

				arg_48_1.typewritter:SetDirty()
				arg_48_1:ShowNextGo(true)
			end
		end

		arg_48_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1027ui_story",
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
	Play104112013 = function(arg_52_0, arg_52_1)
		arg_52_1.time_ = 0
		arg_52_1.frameCnt_ = 0
		arg_52_1.state_ = "playing"
		arg_52_1.curTalkId_ = 104112013
		arg_52_1.duration_ = 1.73

		local var_52_0 = {
			ja = 1.733,
			ko = 1.1,
			zh = 1.466,
			en = 0.7
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
				arg_52_0:Play104112014(arg_52_1)
			end
		end

		function arg_52_1.onSingleLineUpdate_(arg_55_0)
			local var_55_0 = arg_52_1.actors_["1027ui_story"].transform
			local var_55_1 = 0

			if var_55_1 < arg_52_1.time_ and arg_52_1.time_ <= var_55_1 + arg_55_0 then
				arg_52_1.var_.moveOldPos1027ui_story = var_55_0.localPosition
			end

			local var_55_2 = 0.001

			if var_55_1 <= arg_52_1.time_ and arg_52_1.time_ < var_55_1 + var_55_2 then
				local var_55_3 = (arg_52_1.time_ - var_55_1) / var_55_2
				local var_55_4 = Vector3.New(0, 100, 0)

				var_55_0.localPosition = Vector3.Lerp(arg_52_1.var_.moveOldPos1027ui_story, var_55_4, var_55_3)

				local var_55_5 = manager.ui.mainCamera.transform.position - var_55_0.position

				var_55_0.forward = Vector3.New(var_55_5.x, var_55_5.y, var_55_5.z)

				local var_55_6 = var_55_0.localEulerAngles

				var_55_6.z = 0
				var_55_6.x = 0
				var_55_0.localEulerAngles = var_55_6
			end

			if arg_52_1.time_ >= var_55_1 + var_55_2 and arg_52_1.time_ < var_55_1 + var_55_2 + arg_55_0 then
				var_55_0.localPosition = Vector3.New(0, 100, 0)

				local var_55_7 = manager.ui.mainCamera.transform.position - var_55_0.position

				var_55_0.forward = Vector3.New(var_55_7.x, var_55_7.y, var_55_7.z)

				local var_55_8 = var_55_0.localEulerAngles

				var_55_8.z = 0
				var_55_8.x = 0
				var_55_0.localEulerAngles = var_55_8
			end

			local var_55_9 = 0
			local var_55_10 = 0.05

			if var_55_9 < arg_52_1.time_ and arg_52_1.time_ <= var_55_9 + arg_55_0 then
				arg_52_1.talkMaxDuration = 0
				arg_52_1.dialogCg_.alpha = 1

				arg_52_1.dialog_:SetActive(true)
				SetActive(arg_52_1.leftNameGo_, true)

				local var_55_11 = arg_52_1:FormatText(StoryNameCfg[55].name)

				arg_52_1.leftNameTxt_.text = var_55_11

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_52_1.leftNameTxt_.transform)

				arg_52_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_52_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_52_1:RecordName(arg_52_1.leftNameTxt_.text)
				SetActive(arg_52_1.iconTrs_.gameObject, true)
				arg_52_1.iconController_:SetSelectedState("hero")

				arg_52_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_1080")

				arg_52_1.callingController_:SetSelectedState("normal")

				arg_52_1.keyicon_.color = Color.New(1, 1, 1)
				arg_52_1.icon_.color = Color.New(1, 1, 1)

				local var_55_12 = arg_52_1:GetWordFromCfg(104112013)
				local var_55_13 = arg_52_1:FormatText(var_55_12.content)

				arg_52_1.text_.text = var_55_13

				LuaForUtil.ClearLinePrefixSymbol(arg_52_1.text_)

				local var_55_14 = 2
				local var_55_15 = utf8.len(var_55_13)
				local var_55_16 = var_55_14 <= 0 and var_55_10 or var_55_10 * (var_55_15 / var_55_14)

				if var_55_16 > 0 and var_55_10 < var_55_16 then
					arg_52_1.talkMaxDuration = var_55_16

					if var_55_16 + var_55_9 > arg_52_1.duration_ then
						arg_52_1.duration_ = var_55_16 + var_55_9
					end
				end

				arg_52_1.text_.text = var_55_13
				arg_52_1.typewritter.percent = 0

				arg_52_1.typewritter:SetDirty()
				arg_52_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_104112", "104112013", "story_v_out_104112.awb") ~= 0 then
					local var_55_17 = manager.audio:GetVoiceLength("story_v_out_104112", "104112013", "story_v_out_104112.awb") / 1000

					if var_55_17 + var_55_9 > arg_52_1.duration_ then
						arg_52_1.duration_ = var_55_17 + var_55_9
					end

					if var_55_12.prefab_name ~= "" and arg_52_1.actors_[var_55_12.prefab_name] ~= nil then
						local var_55_18 = LuaForUtil.PlayVoiceWithCriLipsync(arg_52_1.actors_[var_55_12.prefab_name].transform, "story_v_out_104112", "104112013", "story_v_out_104112.awb")

						arg_52_1:RecordAudio("104112013", var_55_18)
						arg_52_1:RecordAudio("104112013", var_55_18)
					else
						arg_52_1:AudioAction("play", "voice", "story_v_out_104112", "104112013", "story_v_out_104112.awb")
					end

					arg_52_1:RecordHistoryTalkVoice("story_v_out_104112", "104112013", "story_v_out_104112.awb")
				end

				arg_52_1:RecordContent(arg_52_1.text_.text)
			end

			local var_55_19 = math.max(var_55_10, arg_52_1.talkMaxDuration)

			if var_55_9 <= arg_52_1.time_ and arg_52_1.time_ < var_55_9 + var_55_19 then
				arg_52_1.typewritter.percent = (arg_52_1.time_ - var_55_9) / var_55_19

				arg_52_1.typewritter:SetDirty()
			end

			if arg_52_1.time_ >= var_55_9 + var_55_19 and arg_52_1.time_ < var_55_9 + var_55_19 + arg_55_0 then
				arg_52_1.typewritter.percent = 1

				arg_52_1.typewritter:SetDirty()
				arg_52_1:ShowNextGo(true)
			end
		end

		arg_52_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1027ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.033,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_52_1:InitPlayNodeList()
	end,
	Play104112014 = function(arg_56_0, arg_56_1)
		arg_56_1.time_ = 0
		arg_56_1.frameCnt_ = 0
		arg_56_1.state_ = "playing"
		arg_56_1.curTalkId_ = 104112014
		arg_56_1.duration_ = 9

		SetActive(arg_56_1.tipsGo_, false)

		function arg_56_1.onSingleLineFinish_()
			arg_56_1.onSingleLineUpdate_ = nil
			arg_56_1.onSingleLineFinish_ = nil
			arg_56_1.state_ = "waiting"
		end

		function arg_56_1.playNext_(arg_58_0)
			if arg_58_0 == 1 then
				arg_56_0:Play104112015(arg_56_1)
			end
		end

		function arg_56_1.onSingleLineUpdate_(arg_59_0)
			local var_59_0 = 0

			if var_59_0 < arg_56_1.time_ and arg_56_1.time_ <= var_59_0 + arg_59_0 then
				arg_56_1.mask_.enabled = true
				arg_56_1.mask_.raycastTarget = true

				arg_56_1:SetGaussion(false)
			end

			local var_59_1 = 2

			if var_59_0 <= arg_56_1.time_ and arg_56_1.time_ < var_59_0 + var_59_1 then
				local var_59_2 = (arg_56_1.time_ - var_59_0) / var_59_1
				local var_59_3 = Color.New(0, 0, 0)

				var_59_3.a = Mathf.Lerp(0, 1, var_59_2)
				arg_56_1.mask_.color = var_59_3
			end

			if arg_56_1.time_ >= var_59_0 + var_59_1 and arg_56_1.time_ < var_59_0 + var_59_1 + arg_59_0 then
				local var_59_4 = Color.New(0, 0, 0)

				var_59_4.a = 1
				arg_56_1.mask_.color = var_59_4
			end

			local var_59_5 = 2

			if var_59_5 < arg_56_1.time_ and arg_56_1.time_ <= var_59_5 + arg_59_0 then
				arg_56_1.mask_.enabled = true
				arg_56_1.mask_.raycastTarget = true

				arg_56_1:SetGaussion(false)
			end

			local var_59_6 = 2

			if var_59_5 <= arg_56_1.time_ and arg_56_1.time_ < var_59_5 + var_59_6 then
				local var_59_7 = (arg_56_1.time_ - var_59_5) / var_59_6
				local var_59_8 = Color.New(0, 0, 0)

				var_59_8.a = Mathf.Lerp(1, 0, var_59_7)
				arg_56_1.mask_.color = var_59_8
			end

			if arg_56_1.time_ >= var_59_5 + var_59_6 and arg_56_1.time_ < var_59_5 + var_59_6 + arg_59_0 then
				local var_59_9 = Color.New(0, 0, 0)
				local var_59_10 = 0

				arg_56_1.mask_.enabled = false
				var_59_9.a = var_59_10
				arg_56_1.mask_.color = var_59_9
			end

			if arg_56_1.frameCnt_ <= 1 then
				arg_56_1.dialog_:SetActive(false)
			end

			local var_59_11 = 4
			local var_59_12 = 0.375

			if var_59_11 < arg_56_1.time_ and arg_56_1.time_ <= var_59_11 + arg_59_0 then
				arg_56_1.talkMaxDuration = 0

				arg_56_1.dialog_:SetActive(true)

				arg_56_1.dialogCg_.alpha = 0

				local var_59_13 = LeanTween.value(arg_56_1.dialog_, 0, 1, 0.3)

				var_59_13:setOnUpdate(LuaHelper.FloatAction(function(arg_60_0)
					arg_56_1.dialogCg_.alpha = arg_60_0
				end))
				var_59_13:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_56_1.dialog_)
					var_59_13:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_56_1.duration_ = arg_56_1.duration_ + 0.3

				SetActive(arg_56_1.leftNameGo_, false)

				arg_56_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_56_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_56_1:RecordName(arg_56_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_56_1.iconTrs_.gameObject, false)
				arg_56_1.callingController_:SetSelectedState("normal")

				local var_59_14 = arg_56_1:GetWordFromCfg(104112014)
				local var_59_15 = arg_56_1:FormatText(var_59_14.content)

				arg_56_1.text_.text = var_59_15

				LuaForUtil.ClearLinePrefixSymbol(arg_56_1.text_)

				local var_59_16 = 15
				local var_59_17 = utf8.len(var_59_15)
				local var_59_18 = var_59_16 <= 0 and var_59_12 or var_59_12 * (var_59_17 / var_59_16)

				if var_59_18 > 0 and var_59_12 < var_59_18 then
					arg_56_1.talkMaxDuration = var_59_18
					var_59_11 = var_59_11 + 0.3

					if var_59_18 + var_59_11 > arg_56_1.duration_ then
						arg_56_1.duration_ = var_59_18 + var_59_11
					end
				end

				arg_56_1.text_.text = var_59_15
				arg_56_1.typewritter.percent = 0

				arg_56_1.typewritter:SetDirty()
				arg_56_1:ShowNextGo(false)
				arg_56_1:RecordContent(arg_56_1.text_.text)
			end

			local var_59_19 = var_59_11 + 0.3
			local var_59_20 = math.max(var_59_12, arg_56_1.talkMaxDuration)

			if var_59_19 <= arg_56_1.time_ and arg_56_1.time_ < var_59_19 + var_59_20 then
				arg_56_1.typewritter.percent = (arg_56_1.time_ - var_59_19) / var_59_20

				arg_56_1.typewritter:SetDirty()
			end

			if arg_56_1.time_ >= var_59_19 + var_59_20 and arg_56_1.time_ < var_59_19 + var_59_20 + arg_59_0 then
				arg_56_1.typewritter.percent = 1

				arg_56_1.typewritter:SetDirty()
				arg_56_1:ShowNextGo(true)
			end
		end

		arg_56_1.nodeConfigList_ = {}

		arg_56_1:InitPlayNodeList()
	end,
	Play104112015 = function(arg_62_0, arg_62_1)
		arg_62_1.time_ = 0
		arg_62_1.frameCnt_ = 0
		arg_62_1.state_ = "playing"
		arg_62_1.curTalkId_ = 104112015
		arg_62_1.duration_ = 8.5

		local var_62_0 = {
			ja = 8.5,
			ko = 5.9,
			zh = 6.8,
			en = 5.633
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
				arg_62_0:Play104112016(arg_62_1)
			end
		end

		function arg_62_1.onSingleLineUpdate_(arg_65_0)
			local var_65_0 = "3008ui_story"

			if arg_62_1.actors_[var_65_0] == nil then
				local var_65_1 = Asset.Load("Char/" .. "3008ui_story")

				if not isNil(var_65_1) then
					local var_65_2 = Object.Instantiate(Asset.Load("Char/" .. "3008ui_story"), arg_62_1.stage_.transform)

					var_65_2.name = var_65_0
					var_65_2.transform.localPosition = Vector3.New(0, 100, 0)
					arg_62_1.actors_[var_65_0] = var_65_2

					local var_65_3 = var_65_2:GetComponentInChildren(typeof(CharacterEffect))

					var_65_3.enabled = true

					local var_65_4 = GameObjectTools.GetOrAddComponent(var_65_2, typeof(DynamicBoneHelper))

					if var_65_4 then
						var_65_4:EnableDynamicBone(false)
					end

					arg_62_1:ShowWeapon(var_65_3.transform, false)

					arg_62_1.var_[var_65_0 .. "Animator"] = var_65_3.gameObject:GetComponent(typeof(UnityEngine.Animator))
					arg_62_1.var_[var_65_0 .. "Animator"].applyRootMotion = true
					arg_62_1.var_[var_65_0 .. "LipSync"] = var_65_3.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
				end
			end

			local var_65_5 = arg_62_1.actors_["3008ui_story"]
			local var_65_6 = 0

			if var_65_6 < arg_62_1.time_ and arg_62_1.time_ <= var_65_6 + arg_65_0 and not isNil(var_65_5) and arg_62_1.var_.characterEffect3008ui_story == nil then
				arg_62_1.var_.characterEffect3008ui_story = var_65_5:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_65_7 = 0.1

			if var_65_6 <= arg_62_1.time_ and arg_62_1.time_ < var_65_6 + var_65_7 and not isNil(var_65_5) then
				local var_65_8 = (arg_62_1.time_ - var_65_6) / var_65_7

				if arg_62_1.var_.characterEffect3008ui_story and not isNil(var_65_5) then
					arg_62_1.var_.characterEffect3008ui_story.fillFlat = false
				end
			end

			if arg_62_1.time_ >= var_65_6 + var_65_7 and arg_62_1.time_ < var_65_6 + var_65_7 + arg_65_0 and not isNil(var_65_5) and arg_62_1.var_.characterEffect3008ui_story then
				arg_62_1.var_.characterEffect3008ui_story.fillFlat = false
			end

			local var_65_9 = "1035ui_story"

			if arg_62_1.actors_[var_65_9] == nil then
				local var_65_10 = Asset.Load("Char/" .. "1035ui_story")

				if not isNil(var_65_10) then
					local var_65_11 = Object.Instantiate(Asset.Load("Char/" .. "1035ui_story"), arg_62_1.stage_.transform)

					var_65_11.name = var_65_9
					var_65_11.transform.localPosition = Vector3.New(0, 100, 0)
					arg_62_1.actors_[var_65_9] = var_65_11

					local var_65_12 = var_65_11:GetComponentInChildren(typeof(CharacterEffect))

					var_65_12.enabled = true

					local var_65_13 = GameObjectTools.GetOrAddComponent(var_65_11, typeof(DynamicBoneHelper))

					if var_65_13 then
						var_65_13:EnableDynamicBone(false)
					end

					arg_62_1:ShowWeapon(var_65_12.transform, false)

					arg_62_1.var_[var_65_9 .. "Animator"] = var_65_12.gameObject:GetComponent(typeof(UnityEngine.Animator))
					arg_62_1.var_[var_65_9 .. "Animator"].applyRootMotion = true
					arg_62_1.var_[var_65_9 .. "LipSync"] = var_65_12.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
				end
			end

			local var_65_14 = arg_62_1.actors_["1035ui_story"]
			local var_65_15 = 0

			if var_65_15 < arg_62_1.time_ and arg_62_1.time_ <= var_65_15 + arg_65_0 and not isNil(var_65_14) and arg_62_1.var_.characterEffect1035ui_story == nil then
				arg_62_1.var_.characterEffect1035ui_story = var_65_14:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_65_16 = 0.1

			if var_65_15 <= arg_62_1.time_ and arg_62_1.time_ < var_65_15 + var_65_16 and not isNil(var_65_14) then
				local var_65_17 = (arg_62_1.time_ - var_65_15) / var_65_16

				if arg_62_1.var_.characterEffect1035ui_story and not isNil(var_65_14) then
					local var_65_18 = Mathf.Lerp(0, 0.5, var_65_17)

					arg_62_1.var_.characterEffect1035ui_story.fillFlat = true
					arg_62_1.var_.characterEffect1035ui_story.fillRatio = var_65_18
				end
			end

			if arg_62_1.time_ >= var_65_15 + var_65_16 and arg_62_1.time_ < var_65_15 + var_65_16 + arg_65_0 and not isNil(var_65_14) and arg_62_1.var_.characterEffect1035ui_story then
				local var_65_19 = 0.5

				arg_62_1.var_.characterEffect1035ui_story.fillFlat = true
				arg_62_1.var_.characterEffect1035ui_story.fillRatio = var_65_19
			end

			local var_65_20 = arg_62_1.actors_["3008ui_story"].transform
			local var_65_21 = 0

			if var_65_21 < arg_62_1.time_ and arg_62_1.time_ <= var_65_21 + arg_65_0 then
				arg_62_1.var_.moveOldPos3008ui_story = var_65_20.localPosition
			end

			local var_65_22 = 0.001

			if var_65_21 <= arg_62_1.time_ and arg_62_1.time_ < var_65_21 + var_65_22 then
				local var_65_23 = (arg_62_1.time_ - var_65_21) / var_65_22
				local var_65_24 = Vector3.New(0.7, -1.51, -4.3)

				var_65_20.localPosition = Vector3.Lerp(arg_62_1.var_.moveOldPos3008ui_story, var_65_24, var_65_23)

				local var_65_25 = manager.ui.mainCamera.transform.position - var_65_20.position

				var_65_20.forward = Vector3.New(var_65_25.x, var_65_25.y, var_65_25.z)

				local var_65_26 = var_65_20.localEulerAngles

				var_65_26.z = 0
				var_65_26.x = 0
				var_65_20.localEulerAngles = var_65_26
			end

			if arg_62_1.time_ >= var_65_21 + var_65_22 and arg_62_1.time_ < var_65_21 + var_65_22 + arg_65_0 then
				var_65_20.localPosition = Vector3.New(0.7, -1.51, -4.3)

				local var_65_27 = manager.ui.mainCamera.transform.position - var_65_20.position

				var_65_20.forward = Vector3.New(var_65_27.x, var_65_27.y, var_65_27.z)

				local var_65_28 = var_65_20.localEulerAngles

				var_65_28.z = 0
				var_65_28.x = 0
				var_65_20.localEulerAngles = var_65_28
			end

			local var_65_29 = arg_62_1.actors_["1035ui_story"].transform
			local var_65_30 = 0

			if var_65_30 < arg_62_1.time_ and arg_62_1.time_ <= var_65_30 + arg_65_0 then
				arg_62_1.var_.moveOldPos1035ui_story = var_65_29.localPosition
			end

			local var_65_31 = 0.001

			if var_65_30 <= arg_62_1.time_ and arg_62_1.time_ < var_65_30 + var_65_31 then
				local var_65_32 = (arg_62_1.time_ - var_65_30) / var_65_31
				local var_65_33 = Vector3.New(-0.7, -1.05, -5.6)

				var_65_29.localPosition = Vector3.Lerp(arg_62_1.var_.moveOldPos1035ui_story, var_65_33, var_65_32)

				local var_65_34 = manager.ui.mainCamera.transform.position - var_65_29.position

				var_65_29.forward = Vector3.New(var_65_34.x, var_65_34.y, var_65_34.z)

				local var_65_35 = var_65_29.localEulerAngles

				var_65_35.z = 0
				var_65_35.x = 0
				var_65_29.localEulerAngles = var_65_35
			end

			if arg_62_1.time_ >= var_65_30 + var_65_31 and arg_62_1.time_ < var_65_30 + var_65_31 + arg_65_0 then
				var_65_29.localPosition = Vector3.New(-0.7, -1.05, -5.6)

				local var_65_36 = manager.ui.mainCamera.transform.position - var_65_29.position

				var_65_29.forward = Vector3.New(var_65_36.x, var_65_36.y, var_65_36.z)

				local var_65_37 = var_65_29.localEulerAngles

				var_65_37.z = 0
				var_65_37.x = 0
				var_65_29.localEulerAngles = var_65_37
			end

			local var_65_38 = 0

			if var_65_38 < arg_62_1.time_ and arg_62_1.time_ <= var_65_38 + arg_65_0 then
				arg_62_1:PlayTimeline("3008ui_story", "StoryTimeline/CharAction/story3008/story3008action/3008action4_1")
			end

			local var_65_39 = 0

			if var_65_39 < arg_62_1.time_ and arg_62_1.time_ <= var_65_39 + arg_65_0 then
				arg_62_1:PlayTimeline("1035ui_story", "StoryTimeline/CharAction/story1035/story1035action/1035action1_1")
			end

			local var_65_40 = 0

			if var_65_40 < arg_62_1.time_ and arg_62_1.time_ <= var_65_40 + arg_65_0 then
				arg_62_1:PlayTimeline("3008ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface2104cva")
			end

			local var_65_41 = 0
			local var_65_42 = 0.55

			if var_65_41 < arg_62_1.time_ and arg_62_1.time_ <= var_65_41 + arg_65_0 then
				arg_62_1.talkMaxDuration = 0
				arg_62_1.dialogCg_.alpha = 1

				arg_62_1.dialog_:SetActive(true)
				SetActive(arg_62_1.leftNameGo_, true)

				local var_65_43 = arg_62_1:FormatText(StoryNameCfg[20].name)

				arg_62_1.leftNameTxt_.text = var_65_43

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_62_1.leftNameTxt_.transform)

				arg_62_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_62_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_62_1:RecordName(arg_62_1.leftNameTxt_.text)
				SetActive(arg_62_1.iconTrs_.gameObject, false)
				arg_62_1.callingController_:SetSelectedState("normal")

				local var_65_44 = arg_62_1:GetWordFromCfg(104112015)
				local var_65_45 = arg_62_1:FormatText(var_65_44.content)

				arg_62_1.text_.text = var_65_45

				LuaForUtil.ClearLinePrefixSymbol(arg_62_1.text_)

				local var_65_46 = 21
				local var_65_47 = utf8.len(var_65_45)
				local var_65_48 = var_65_46 <= 0 and var_65_42 or var_65_42 * (var_65_47 / var_65_46)

				if var_65_48 > 0 and var_65_42 < var_65_48 then
					arg_62_1.talkMaxDuration = var_65_48

					if var_65_48 + var_65_41 > arg_62_1.duration_ then
						arg_62_1.duration_ = var_65_48 + var_65_41
					end
				end

				arg_62_1.text_.text = var_65_45
				arg_62_1.typewritter.percent = 0

				arg_62_1.typewritter:SetDirty()
				arg_62_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_104112", "104112015", "story_v_out_104112.awb") ~= 0 then
					local var_65_49 = manager.audio:GetVoiceLength("story_v_out_104112", "104112015", "story_v_out_104112.awb") / 1000

					if var_65_49 + var_65_41 > arg_62_1.duration_ then
						arg_62_1.duration_ = var_65_49 + var_65_41
					end

					if var_65_44.prefab_name ~= "" and arg_62_1.actors_[var_65_44.prefab_name] ~= nil then
						local var_65_50 = LuaForUtil.PlayVoiceWithCriLipsync(arg_62_1.actors_[var_65_44.prefab_name].transform, "story_v_out_104112", "104112015", "story_v_out_104112.awb")

						arg_62_1:RecordAudio("104112015", var_65_50)
						arg_62_1:RecordAudio("104112015", var_65_50)
					else
						arg_62_1:AudioAction("play", "voice", "story_v_out_104112", "104112015", "story_v_out_104112.awb")
					end

					arg_62_1:RecordHistoryTalkVoice("story_v_out_104112", "104112015", "story_v_out_104112.awb")
				end

				arg_62_1:RecordContent(arg_62_1.text_.text)
			end

			local var_65_51 = math.max(var_65_42, arg_62_1.talkMaxDuration)

			if var_65_41 <= arg_62_1.time_ and arg_62_1.time_ < var_65_41 + var_65_51 then
				arg_62_1.typewritter.percent = (arg_62_1.time_ - var_65_41) / var_65_51

				arg_62_1.typewritter:SetDirty()
			end

			if arg_62_1.time_ >= var_65_41 + var_65_51 and arg_62_1.time_ < var_65_41 + var_65_51 + arg_65_0 then
				arg_62_1.typewritter.percent = 1

				arg_62_1.typewritter:SetDirty()
				arg_62_1:ShowNextGo(true)
			end
		end

		arg_62_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "3008ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.033,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1035ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_62_1:InitPlayNodeList()
	end,
	Play104112016 = function(arg_66_0, arg_66_1)
		arg_66_1.time_ = 0
		arg_66_1.frameCnt_ = 0
		arg_66_1.state_ = "playing"
		arg_66_1.curTalkId_ = 104112016
		arg_66_1.duration_ = 9.2

		local var_66_0 = {
			ja = 7.1,
			ko = 4.533,
			zh = 9.2,
			en = 6.733
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
				arg_66_0:Play104112017(arg_66_1)
			end
		end

		function arg_66_1.onSingleLineUpdate_(arg_69_0)
			local var_69_0 = arg_66_1.actors_["3008ui_story"]
			local var_69_1 = 0

			if var_69_1 < arg_66_1.time_ and arg_66_1.time_ <= var_69_1 + arg_69_0 and not isNil(var_69_0) and arg_66_1.var_.characterEffect3008ui_story == nil then
				arg_66_1.var_.characterEffect3008ui_story = var_69_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_69_2 = 0.1

			if var_69_1 <= arg_66_1.time_ and arg_66_1.time_ < var_69_1 + var_69_2 and not isNil(var_69_0) then
				local var_69_3 = (arg_66_1.time_ - var_69_1) / var_69_2

				if arg_66_1.var_.characterEffect3008ui_story and not isNil(var_69_0) then
					local var_69_4 = Mathf.Lerp(0, 0.5, var_69_3)

					arg_66_1.var_.characterEffect3008ui_story.fillFlat = true
					arg_66_1.var_.characterEffect3008ui_story.fillRatio = var_69_4
				end
			end

			if arg_66_1.time_ >= var_69_1 + var_69_2 and arg_66_1.time_ < var_69_1 + var_69_2 + arg_69_0 and not isNil(var_69_0) and arg_66_1.var_.characterEffect3008ui_story then
				local var_69_5 = 0.5

				arg_66_1.var_.characterEffect3008ui_story.fillFlat = true
				arg_66_1.var_.characterEffect3008ui_story.fillRatio = var_69_5
			end

			local var_69_6 = arg_66_1.actors_["1035ui_story"]
			local var_69_7 = 0

			if var_69_7 < arg_66_1.time_ and arg_66_1.time_ <= var_69_7 + arg_69_0 and not isNil(var_69_6) and arg_66_1.var_.characterEffect1035ui_story == nil then
				arg_66_1.var_.characterEffect1035ui_story = var_69_6:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_69_8 = 0.1

			if var_69_7 <= arg_66_1.time_ and arg_66_1.time_ < var_69_7 + var_69_8 and not isNil(var_69_6) then
				local var_69_9 = (arg_66_1.time_ - var_69_7) / var_69_8

				if arg_66_1.var_.characterEffect1035ui_story and not isNil(var_69_6) then
					arg_66_1.var_.characterEffect1035ui_story.fillFlat = false
				end
			end

			if arg_66_1.time_ >= var_69_7 + var_69_8 and arg_66_1.time_ < var_69_7 + var_69_8 + arg_69_0 and not isNil(var_69_6) and arg_66_1.var_.characterEffect1035ui_story then
				arg_66_1.var_.characterEffect1035ui_story.fillFlat = false
			end

			local var_69_10 = 0

			if var_69_10 < arg_66_1.time_ and arg_66_1.time_ <= var_69_10 + arg_69_0 then
				arg_66_1:PlayTimeline("1035ui_story", "StoryTimeline/CharAction/story1035/story1035action/1035action9_1")
			end

			local var_69_11 = 0
			local var_69_12 = 0.625

			if var_69_11 < arg_66_1.time_ and arg_66_1.time_ <= var_69_11 + arg_69_0 then
				arg_66_1.talkMaxDuration = 0
				arg_66_1.dialogCg_.alpha = 1

				arg_66_1.dialog_:SetActive(true)
				SetActive(arg_66_1.leftNameGo_, true)

				local var_69_13 = arg_66_1:FormatText(StoryNameCfg[21].name)

				arg_66_1.leftNameTxt_.text = var_69_13

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_66_1.leftNameTxt_.transform)

				arg_66_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_66_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_66_1:RecordName(arg_66_1.leftNameTxt_.text)
				SetActive(arg_66_1.iconTrs_.gameObject, false)
				arg_66_1.callingController_:SetSelectedState("normal")

				local var_69_14 = arg_66_1:GetWordFromCfg(104112016)
				local var_69_15 = arg_66_1:FormatText(var_69_14.content)

				arg_66_1.text_.text = var_69_15

				LuaForUtil.ClearLinePrefixSymbol(arg_66_1.text_)

				local var_69_16 = 24
				local var_69_17 = utf8.len(var_69_15)
				local var_69_18 = var_69_16 <= 0 and var_69_12 or var_69_12 * (var_69_17 / var_69_16)

				if var_69_18 > 0 and var_69_12 < var_69_18 then
					arg_66_1.talkMaxDuration = var_69_18

					if var_69_18 + var_69_11 > arg_66_1.duration_ then
						arg_66_1.duration_ = var_69_18 + var_69_11
					end
				end

				arg_66_1.text_.text = var_69_15
				arg_66_1.typewritter.percent = 0

				arg_66_1.typewritter:SetDirty()
				arg_66_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_104112", "104112016", "story_v_out_104112.awb") ~= 0 then
					local var_69_19 = manager.audio:GetVoiceLength("story_v_out_104112", "104112016", "story_v_out_104112.awb") / 1000

					if var_69_19 + var_69_11 > arg_66_1.duration_ then
						arg_66_1.duration_ = var_69_19 + var_69_11
					end

					if var_69_14.prefab_name ~= "" and arg_66_1.actors_[var_69_14.prefab_name] ~= nil then
						local var_69_20 = LuaForUtil.PlayVoiceWithCriLipsync(arg_66_1.actors_[var_69_14.prefab_name].transform, "story_v_out_104112", "104112016", "story_v_out_104112.awb")

						arg_66_1:RecordAudio("104112016", var_69_20)
						arg_66_1:RecordAudio("104112016", var_69_20)
					else
						arg_66_1:AudioAction("play", "voice", "story_v_out_104112", "104112016", "story_v_out_104112.awb")
					end

					arg_66_1:RecordHistoryTalkVoice("story_v_out_104112", "104112016", "story_v_out_104112.awb")
				end

				arg_66_1:RecordContent(arg_66_1.text_.text)
			end

			local var_69_21 = math.max(var_69_12, arg_66_1.talkMaxDuration)

			if var_69_11 <= arg_66_1.time_ and arg_66_1.time_ < var_69_11 + var_69_21 then
				arg_66_1.typewritter.percent = (arg_66_1.time_ - var_69_11) / var_69_21

				arg_66_1.typewritter:SetDirty()
			end

			if arg_66_1.time_ >= var_69_11 + var_69_21 and arg_66_1.time_ < var_69_11 + var_69_21 + arg_69_0 then
				arg_66_1.typewritter.percent = 1

				arg_66_1.typewritter:SetDirty()
				arg_66_1:ShowNextGo(true)
			end
		end

		arg_66_1.nodeConfigList_ = {}

		arg_66_1:InitPlayNodeList()
	end,
	Play104112017 = function(arg_70_0, arg_70_1)
		arg_70_1.time_ = 0
		arg_70_1.frameCnt_ = 0
		arg_70_1.state_ = "playing"
		arg_70_1.curTalkId_ = 104112017
		arg_70_1.duration_ = 9.1

		local var_70_0 = {
			ja = 9.1,
			ko = 4.3,
			zh = 5.833,
			en = 5
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
				arg_70_0:Play104112018(arg_70_1)
			end
		end

		function arg_70_1.onSingleLineUpdate_(arg_73_0)
			local var_73_0 = arg_70_1.actors_["3008ui_story"]
			local var_73_1 = 0

			if var_73_1 < arg_70_1.time_ and arg_70_1.time_ <= var_73_1 + arg_73_0 and not isNil(var_73_0) and arg_70_1.var_.characterEffect3008ui_story == nil then
				arg_70_1.var_.characterEffect3008ui_story = var_73_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_73_2 = 0.1

			if var_73_1 <= arg_70_1.time_ and arg_70_1.time_ < var_73_1 + var_73_2 and not isNil(var_73_0) then
				local var_73_3 = (arg_70_1.time_ - var_73_1) / var_73_2

				if arg_70_1.var_.characterEffect3008ui_story and not isNil(var_73_0) then
					arg_70_1.var_.characterEffect3008ui_story.fillFlat = false
				end
			end

			if arg_70_1.time_ >= var_73_1 + var_73_2 and arg_70_1.time_ < var_73_1 + var_73_2 + arg_73_0 and not isNil(var_73_0) and arg_70_1.var_.characterEffect3008ui_story then
				arg_70_1.var_.characterEffect3008ui_story.fillFlat = false
			end

			local var_73_4 = arg_70_1.actors_["1035ui_story"]
			local var_73_5 = 0

			if var_73_5 < arg_70_1.time_ and arg_70_1.time_ <= var_73_5 + arg_73_0 and not isNil(var_73_4) and arg_70_1.var_.characterEffect1035ui_story == nil then
				arg_70_1.var_.characterEffect1035ui_story = var_73_4:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_73_6 = 0.1

			if var_73_5 <= arg_70_1.time_ and arg_70_1.time_ < var_73_5 + var_73_6 and not isNil(var_73_4) then
				local var_73_7 = (arg_70_1.time_ - var_73_5) / var_73_6

				if arg_70_1.var_.characterEffect1035ui_story and not isNil(var_73_4) then
					local var_73_8 = Mathf.Lerp(0, 0.5, var_73_7)

					arg_70_1.var_.characterEffect1035ui_story.fillFlat = true
					arg_70_1.var_.characterEffect1035ui_story.fillRatio = var_73_8
				end
			end

			if arg_70_1.time_ >= var_73_5 + var_73_6 and arg_70_1.time_ < var_73_5 + var_73_6 + arg_73_0 and not isNil(var_73_4) and arg_70_1.var_.characterEffect1035ui_story then
				local var_73_9 = 0.5

				arg_70_1.var_.characterEffect1035ui_story.fillFlat = true
				arg_70_1.var_.characterEffect1035ui_story.fillRatio = var_73_9
			end

			local var_73_10 = 0

			if var_73_10 < arg_70_1.time_ and arg_70_1.time_ <= var_73_10 + arg_73_0 then
				arg_70_1:PlayTimeline("3008ui_story", "StoryTimeline/CharAction/story3008/story3008actionlink/3008action442")
			end

			local var_73_11 = 0

			if var_73_11 < arg_70_1.time_ and arg_70_1.time_ <= var_73_11 + arg_73_0 then
				arg_70_1:PlayTimeline("3008ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3104cva")
			end

			local var_73_12 = 0
			local var_73_13 = 0.525

			if var_73_12 < arg_70_1.time_ and arg_70_1.time_ <= var_73_12 + arg_73_0 then
				arg_70_1.talkMaxDuration = 0
				arg_70_1.dialogCg_.alpha = 1

				arg_70_1.dialog_:SetActive(true)
				SetActive(arg_70_1.leftNameGo_, true)

				local var_73_14 = arg_70_1:FormatText(StoryNameCfg[20].name)

				arg_70_1.leftNameTxt_.text = var_73_14

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_70_1.leftNameTxt_.transform)

				arg_70_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_70_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_70_1:RecordName(arg_70_1.leftNameTxt_.text)
				SetActive(arg_70_1.iconTrs_.gameObject, false)
				arg_70_1.callingController_:SetSelectedState("normal")

				local var_73_15 = arg_70_1:GetWordFromCfg(104112017)
				local var_73_16 = arg_70_1:FormatText(var_73_15.content)

				arg_70_1.text_.text = var_73_16

				LuaForUtil.ClearLinePrefixSymbol(arg_70_1.text_)

				local var_73_17 = 21
				local var_73_18 = utf8.len(var_73_16)
				local var_73_19 = var_73_17 <= 0 and var_73_13 or var_73_13 * (var_73_18 / var_73_17)

				if var_73_19 > 0 and var_73_13 < var_73_19 then
					arg_70_1.talkMaxDuration = var_73_19

					if var_73_19 + var_73_12 > arg_70_1.duration_ then
						arg_70_1.duration_ = var_73_19 + var_73_12
					end
				end

				arg_70_1.text_.text = var_73_16
				arg_70_1.typewritter.percent = 0

				arg_70_1.typewritter:SetDirty()
				arg_70_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_104112", "104112017", "story_v_out_104112.awb") ~= 0 then
					local var_73_20 = manager.audio:GetVoiceLength("story_v_out_104112", "104112017", "story_v_out_104112.awb") / 1000

					if var_73_20 + var_73_12 > arg_70_1.duration_ then
						arg_70_1.duration_ = var_73_20 + var_73_12
					end

					if var_73_15.prefab_name ~= "" and arg_70_1.actors_[var_73_15.prefab_name] ~= nil then
						local var_73_21 = LuaForUtil.PlayVoiceWithCriLipsync(arg_70_1.actors_[var_73_15.prefab_name].transform, "story_v_out_104112", "104112017", "story_v_out_104112.awb")

						arg_70_1:RecordAudio("104112017", var_73_21)
						arg_70_1:RecordAudio("104112017", var_73_21)
					else
						arg_70_1:AudioAction("play", "voice", "story_v_out_104112", "104112017", "story_v_out_104112.awb")
					end

					arg_70_1:RecordHistoryTalkVoice("story_v_out_104112", "104112017", "story_v_out_104112.awb")
				end

				arg_70_1:RecordContent(arg_70_1.text_.text)
			end

			local var_73_22 = math.max(var_73_13, arg_70_1.talkMaxDuration)

			if var_73_12 <= arg_70_1.time_ and arg_70_1.time_ < var_73_12 + var_73_22 then
				arg_70_1.typewritter.percent = (arg_70_1.time_ - var_73_12) / var_73_22

				arg_70_1.typewritter:SetDirty()
			end

			if arg_70_1.time_ >= var_73_12 + var_73_22 and arg_70_1.time_ < var_73_12 + var_73_22 + arg_73_0 then
				arg_70_1.typewritter.percent = 1

				arg_70_1.typewritter:SetDirty()
				arg_70_1:ShowNextGo(true)
			end
		end

		arg_70_1.nodeConfigList_ = {}

		arg_70_1:InitPlayNodeList()
	end,
	Play104112018 = function(arg_74_0, arg_74_1)
		arg_74_1.time_ = 0
		arg_74_1.frameCnt_ = 0
		arg_74_1.state_ = "playing"
		arg_74_1.curTalkId_ = 104112018
		arg_74_1.duration_ = 3.27

		local var_74_0 = {
			ja = 1.999999999999,
			ko = 1.999999999999,
			zh = 3.266,
			en = 2.366
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
				arg_74_0:Play104112019(arg_74_1)
			end
		end

		function arg_74_1.onSingleLineUpdate_(arg_77_0)
			local var_77_0 = arg_74_1.actors_["3008ui_story"]
			local var_77_1 = 0

			if var_77_1 < arg_74_1.time_ and arg_74_1.time_ <= var_77_1 + arg_77_0 and not isNil(var_77_0) and arg_74_1.var_.characterEffect3008ui_story == nil then
				arg_74_1.var_.characterEffect3008ui_story = var_77_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_77_2 = 0.1

			if var_77_1 <= arg_74_1.time_ and arg_74_1.time_ < var_77_1 + var_77_2 and not isNil(var_77_0) then
				local var_77_3 = (arg_74_1.time_ - var_77_1) / var_77_2

				if arg_74_1.var_.characterEffect3008ui_story and not isNil(var_77_0) then
					local var_77_4 = Mathf.Lerp(0, 0.5, var_77_3)

					arg_74_1.var_.characterEffect3008ui_story.fillFlat = true
					arg_74_1.var_.characterEffect3008ui_story.fillRatio = var_77_4
				end
			end

			if arg_74_1.time_ >= var_77_1 + var_77_2 and arg_74_1.time_ < var_77_1 + var_77_2 + arg_77_0 and not isNil(var_77_0) and arg_74_1.var_.characterEffect3008ui_story then
				local var_77_5 = 0.5

				arg_74_1.var_.characterEffect3008ui_story.fillFlat = true
				arg_74_1.var_.characterEffect3008ui_story.fillRatio = var_77_5
			end

			local var_77_6 = arg_74_1.actors_["1035ui_story"]
			local var_77_7 = 0

			if var_77_7 < arg_74_1.time_ and arg_74_1.time_ <= var_77_7 + arg_77_0 and not isNil(var_77_6) and arg_74_1.var_.characterEffect1035ui_story == nil then
				arg_74_1.var_.characterEffect1035ui_story = var_77_6:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_77_8 = 0.1

			if var_77_7 <= arg_74_1.time_ and arg_74_1.time_ < var_77_7 + var_77_8 and not isNil(var_77_6) then
				local var_77_9 = (arg_74_1.time_ - var_77_7) / var_77_8

				if arg_74_1.var_.characterEffect1035ui_story and not isNil(var_77_6) then
					arg_74_1.var_.characterEffect1035ui_story.fillFlat = false
				end
			end

			if arg_74_1.time_ >= var_77_7 + var_77_8 and arg_74_1.time_ < var_77_7 + var_77_8 + arg_77_0 and not isNil(var_77_6) and arg_74_1.var_.characterEffect1035ui_story then
				arg_74_1.var_.characterEffect1035ui_story.fillFlat = false
			end

			local var_77_10 = 0

			if var_77_10 < arg_74_1.time_ and arg_74_1.time_ <= var_77_10 + arg_77_0 then
				arg_74_1:PlayTimeline("1035ui_story", "StoryTimeline/CharAction/story1035/story1035actionlink/1035action494")
			end

			local var_77_11 = 0
			local var_77_12 = 0.1

			if var_77_11 < arg_74_1.time_ and arg_74_1.time_ <= var_77_11 + arg_77_0 then
				arg_74_1.talkMaxDuration = 0
				arg_74_1.dialogCg_.alpha = 1

				arg_74_1.dialog_:SetActive(true)
				SetActive(arg_74_1.leftNameGo_, true)

				local var_77_13 = arg_74_1:FormatText(StoryNameCfg[21].name)

				arg_74_1.leftNameTxt_.text = var_77_13

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_74_1.leftNameTxt_.transform)

				arg_74_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_74_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_74_1:RecordName(arg_74_1.leftNameTxt_.text)
				SetActive(arg_74_1.iconTrs_.gameObject, false)
				arg_74_1.callingController_:SetSelectedState("normal")

				local var_77_14 = arg_74_1:GetWordFromCfg(104112018)
				local var_77_15 = arg_74_1:FormatText(var_77_14.content)

				arg_74_1.text_.text = var_77_15

				LuaForUtil.ClearLinePrefixSymbol(arg_74_1.text_)

				local var_77_16 = 4
				local var_77_17 = utf8.len(var_77_15)
				local var_77_18 = var_77_16 <= 0 and var_77_12 or var_77_12 * (var_77_17 / var_77_16)

				if var_77_18 > 0 and var_77_12 < var_77_18 then
					arg_74_1.talkMaxDuration = var_77_18

					if var_77_18 + var_77_11 > arg_74_1.duration_ then
						arg_74_1.duration_ = var_77_18 + var_77_11
					end
				end

				arg_74_1.text_.text = var_77_15
				arg_74_1.typewritter.percent = 0

				arg_74_1.typewritter:SetDirty()
				arg_74_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_104112", "104112018", "story_v_out_104112.awb") ~= 0 then
					local var_77_19 = manager.audio:GetVoiceLength("story_v_out_104112", "104112018", "story_v_out_104112.awb") / 1000

					if var_77_19 + var_77_11 > arg_74_1.duration_ then
						arg_74_1.duration_ = var_77_19 + var_77_11
					end

					if var_77_14.prefab_name ~= "" and arg_74_1.actors_[var_77_14.prefab_name] ~= nil then
						local var_77_20 = LuaForUtil.PlayVoiceWithCriLipsync(arg_74_1.actors_[var_77_14.prefab_name].transform, "story_v_out_104112", "104112018", "story_v_out_104112.awb")

						arg_74_1:RecordAudio("104112018", var_77_20)
						arg_74_1:RecordAudio("104112018", var_77_20)
					else
						arg_74_1:AudioAction("play", "voice", "story_v_out_104112", "104112018", "story_v_out_104112.awb")
					end

					arg_74_1:RecordHistoryTalkVoice("story_v_out_104112", "104112018", "story_v_out_104112.awb")
				end

				arg_74_1:RecordContent(arg_74_1.text_.text)
			end

			local var_77_21 = math.max(var_77_12, arg_74_1.talkMaxDuration)

			if var_77_11 <= arg_74_1.time_ and arg_74_1.time_ < var_77_11 + var_77_21 then
				arg_74_1.typewritter.percent = (arg_74_1.time_ - var_77_11) / var_77_21

				arg_74_1.typewritter:SetDirty()
			end

			if arg_74_1.time_ >= var_77_11 + var_77_21 and arg_74_1.time_ < var_77_11 + var_77_21 + arg_77_0 then
				arg_74_1.typewritter.percent = 1

				arg_74_1.typewritter:SetDirty()
				arg_74_1:ShowNextGo(true)
			end
		end

		arg_74_1.nodeConfigList_ = {}

		arg_74_1:InitPlayNodeList()
	end,
	Play104112019 = function(arg_78_0, arg_78_1)
		arg_78_1.time_ = 0
		arg_78_1.frameCnt_ = 0
		arg_78_1.state_ = "playing"
		arg_78_1.curTalkId_ = 104112019
		arg_78_1.duration_ = 5

		SetActive(arg_78_1.tipsGo_, false)

		function arg_78_1.onSingleLineFinish_()
			arg_78_1.onSingleLineUpdate_ = nil
			arg_78_1.onSingleLineFinish_ = nil
			arg_78_1.state_ = "waiting"
		end

		function arg_78_1.playNext_(arg_80_0)
			if arg_80_0 == 1 then
				arg_78_0:Play104112020(arg_78_1)
			end
		end

		function arg_78_1.onSingleLineUpdate_(arg_81_0)
			local var_81_0 = arg_78_1.actors_["3008ui_story"].transform
			local var_81_1 = 0

			if var_81_1 < arg_78_1.time_ and arg_78_1.time_ <= var_81_1 + arg_81_0 then
				arg_78_1.var_.moveOldPos3008ui_story = var_81_0.localPosition
			end

			local var_81_2 = 0.001

			if var_81_1 <= arg_78_1.time_ and arg_78_1.time_ < var_81_1 + var_81_2 then
				local var_81_3 = (arg_78_1.time_ - var_81_1) / var_81_2
				local var_81_4 = Vector3.New(0, 100, 0)

				var_81_0.localPosition = Vector3.Lerp(arg_78_1.var_.moveOldPos3008ui_story, var_81_4, var_81_3)

				local var_81_5 = manager.ui.mainCamera.transform.position - var_81_0.position

				var_81_0.forward = Vector3.New(var_81_5.x, var_81_5.y, var_81_5.z)

				local var_81_6 = var_81_0.localEulerAngles

				var_81_6.z = 0
				var_81_6.x = 0
				var_81_0.localEulerAngles = var_81_6
			end

			if arg_78_1.time_ >= var_81_1 + var_81_2 and arg_78_1.time_ < var_81_1 + var_81_2 + arg_81_0 then
				var_81_0.localPosition = Vector3.New(0, 100, 0)

				local var_81_7 = manager.ui.mainCamera.transform.position - var_81_0.position

				var_81_0.forward = Vector3.New(var_81_7.x, var_81_7.y, var_81_7.z)

				local var_81_8 = var_81_0.localEulerAngles

				var_81_8.z = 0
				var_81_8.x = 0
				var_81_0.localEulerAngles = var_81_8
			end

			local var_81_9 = arg_78_1.actors_["1035ui_story"].transform
			local var_81_10 = 0

			if var_81_10 < arg_78_1.time_ and arg_78_1.time_ <= var_81_10 + arg_81_0 then
				arg_78_1.var_.moveOldPos1035ui_story = var_81_9.localPosition
			end

			local var_81_11 = 0.001

			if var_81_10 <= arg_78_1.time_ and arg_78_1.time_ < var_81_10 + var_81_11 then
				local var_81_12 = (arg_78_1.time_ - var_81_10) / var_81_11
				local var_81_13 = Vector3.New(0, 100, 0)

				var_81_9.localPosition = Vector3.Lerp(arg_78_1.var_.moveOldPos1035ui_story, var_81_13, var_81_12)

				local var_81_14 = manager.ui.mainCamera.transform.position - var_81_9.position

				var_81_9.forward = Vector3.New(var_81_14.x, var_81_14.y, var_81_14.z)

				local var_81_15 = var_81_9.localEulerAngles

				var_81_15.z = 0
				var_81_15.x = 0
				var_81_9.localEulerAngles = var_81_15
			end

			if arg_78_1.time_ >= var_81_10 + var_81_11 and arg_78_1.time_ < var_81_10 + var_81_11 + arg_81_0 then
				var_81_9.localPosition = Vector3.New(0, 100, 0)

				local var_81_16 = manager.ui.mainCamera.transform.position - var_81_9.position

				var_81_9.forward = Vector3.New(var_81_16.x, var_81_16.y, var_81_16.z)

				local var_81_17 = var_81_9.localEulerAngles

				var_81_17.z = 0
				var_81_17.x = 0
				var_81_9.localEulerAngles = var_81_17
			end

			local var_81_18 = 0
			local var_81_19 = 0.475

			if var_81_18 < arg_78_1.time_ and arg_78_1.time_ <= var_81_18 + arg_81_0 then
				arg_78_1.talkMaxDuration = 0
				arg_78_1.dialogCg_.alpha = 1

				arg_78_1.dialog_:SetActive(true)
				SetActive(arg_78_1.leftNameGo_, false)

				arg_78_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_78_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_78_1:RecordName(arg_78_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_78_1.iconTrs_.gameObject, false)
				arg_78_1.callingController_:SetSelectedState("normal")

				local var_81_20 = arg_78_1:GetWordFromCfg(104112019)
				local var_81_21 = arg_78_1:FormatText(var_81_20.content)

				arg_78_1.text_.text = var_81_21

				LuaForUtil.ClearLinePrefixSymbol(arg_78_1.text_)

				local var_81_22 = 19
				local var_81_23 = utf8.len(var_81_21)
				local var_81_24 = var_81_22 <= 0 and var_81_19 or var_81_19 * (var_81_23 / var_81_22)

				if var_81_24 > 0 and var_81_19 < var_81_24 then
					arg_78_1.talkMaxDuration = var_81_24

					if var_81_24 + var_81_18 > arg_78_1.duration_ then
						arg_78_1.duration_ = var_81_24 + var_81_18
					end
				end

				arg_78_1.text_.text = var_81_21
				arg_78_1.typewritter.percent = 0

				arg_78_1.typewritter:SetDirty()
				arg_78_1:ShowNextGo(false)
				arg_78_1:RecordContent(arg_78_1.text_.text)
			end

			local var_81_25 = math.max(var_81_19, arg_78_1.talkMaxDuration)

			if var_81_18 <= arg_78_1.time_ and arg_78_1.time_ < var_81_18 + var_81_25 then
				arg_78_1.typewritter.percent = (arg_78_1.time_ - var_81_18) / var_81_25

				arg_78_1.typewritter:SetDirty()
			end

			if arg_78_1.time_ >= var_81_18 + var_81_25 and arg_78_1.time_ < var_81_18 + var_81_25 + arg_81_0 then
				arg_78_1.typewritter.percent = 1

				arg_78_1.typewritter:SetDirty()
				arg_78_1:ShowNextGo(true)
			end
		end

		arg_78_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "3008ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.033,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1035ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.033,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_78_1:InitPlayNodeList()
	end,
	Play104112020 = function(arg_82_0, arg_82_1)
		arg_82_1.time_ = 0
		arg_82_1.frameCnt_ = 0
		arg_82_1.state_ = "playing"
		arg_82_1.curTalkId_ = 104112020
		arg_82_1.duration_ = 10.13

		local var_82_0 = {
			ja = 10.133,
			ko = 6.166,
			zh = 7.366,
			en = 6.3
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
				arg_82_0:Play104112021(arg_82_1)
			end
		end

		function arg_82_1.onSingleLineUpdate_(arg_85_0)
			local var_85_0 = "4010ui_story"

			if arg_82_1.actors_[var_85_0] == nil then
				local var_85_1 = Asset.Load("Char/" .. "4010ui_story")

				if not isNil(var_85_1) then
					local var_85_2 = Object.Instantiate(Asset.Load("Char/" .. "4010ui_story"), arg_82_1.stage_.transform)

					var_85_2.name = var_85_0
					var_85_2.transform.localPosition = Vector3.New(0, 100, 0)
					arg_82_1.actors_[var_85_0] = var_85_2

					local var_85_3 = var_85_2:GetComponentInChildren(typeof(CharacterEffect))

					var_85_3.enabled = true

					local var_85_4 = GameObjectTools.GetOrAddComponent(var_85_2, typeof(DynamicBoneHelper))

					if var_85_4 then
						var_85_4:EnableDynamicBone(false)
					end

					arg_82_1:ShowWeapon(var_85_3.transform, false)

					arg_82_1.var_[var_85_0 .. "Animator"] = var_85_3.gameObject:GetComponent(typeof(UnityEngine.Animator))
					arg_82_1.var_[var_85_0 .. "Animator"].applyRootMotion = true
					arg_82_1.var_[var_85_0 .. "LipSync"] = var_85_3.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
				end
			end

			local var_85_5 = arg_82_1.actors_["4010ui_story"]
			local var_85_6 = 0

			if var_85_6 < arg_82_1.time_ and arg_82_1.time_ <= var_85_6 + arg_85_0 and not isNil(var_85_5) and arg_82_1.var_.characterEffect4010ui_story == nil then
				arg_82_1.var_.characterEffect4010ui_story = var_85_5:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_85_7 = 0.1

			if var_85_6 <= arg_82_1.time_ and arg_82_1.time_ < var_85_6 + var_85_7 and not isNil(var_85_5) then
				local var_85_8 = (arg_82_1.time_ - var_85_6) / var_85_7

				if arg_82_1.var_.characterEffect4010ui_story and not isNil(var_85_5) then
					arg_82_1.var_.characterEffect4010ui_story.fillFlat = false
				end
			end

			if arg_82_1.time_ >= var_85_6 + var_85_7 and arg_82_1.time_ < var_85_6 + var_85_7 + arg_85_0 and not isNil(var_85_5) and arg_82_1.var_.characterEffect4010ui_story then
				arg_82_1.var_.characterEffect4010ui_story.fillFlat = false
			end

			local var_85_9 = arg_82_1.actors_["4010ui_story"].transform
			local var_85_10 = 0

			if var_85_10 < arg_82_1.time_ and arg_82_1.time_ <= var_85_10 + arg_85_0 then
				arg_82_1.var_.moveOldPos4010ui_story = var_85_9.localPosition
			end

			local var_85_11 = 0.001

			if var_85_10 <= arg_82_1.time_ and arg_82_1.time_ < var_85_10 + var_85_11 then
				local var_85_12 = (arg_82_1.time_ - var_85_10) / var_85_11
				local var_85_13 = Vector3.New(-0.7, -1.59, -5.2)

				var_85_9.localPosition = Vector3.Lerp(arg_82_1.var_.moveOldPos4010ui_story, var_85_13, var_85_12)

				local var_85_14 = manager.ui.mainCamera.transform.position - var_85_9.position

				var_85_9.forward = Vector3.New(var_85_14.x, var_85_14.y, var_85_14.z)

				local var_85_15 = var_85_9.localEulerAngles

				var_85_15.z = 0
				var_85_15.x = 0
				var_85_9.localEulerAngles = var_85_15
			end

			if arg_82_1.time_ >= var_85_10 + var_85_11 and arg_82_1.time_ < var_85_10 + var_85_11 + arg_85_0 then
				var_85_9.localPosition = Vector3.New(-0.7, -1.59, -5.2)

				local var_85_16 = manager.ui.mainCamera.transform.position - var_85_9.position

				var_85_9.forward = Vector3.New(var_85_16.x, var_85_16.y, var_85_16.z)

				local var_85_17 = var_85_9.localEulerAngles

				var_85_17.z = 0
				var_85_17.x = 0
				var_85_9.localEulerAngles = var_85_17
			end

			local var_85_18 = 0

			if var_85_18 < arg_82_1.time_ and arg_82_1.time_ <= var_85_18 + arg_85_0 then
				arg_82_1:PlayTimeline("4010ui_story", "StoryTimeline/CharAction/story4010/story4010action/4010action4_1")
			end

			local var_85_19 = 0

			if var_85_19 < arg_82_1.time_ and arg_82_1.time_ <= var_85_19 + arg_85_0 then
				arg_82_1:PlayTimeline("4010ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface2104cva")
			end

			local var_85_20 = 0
			local var_85_21 = 0.95

			if var_85_20 < arg_82_1.time_ and arg_82_1.time_ <= var_85_20 + arg_85_0 then
				arg_82_1.talkMaxDuration = 0
				arg_82_1.dialogCg_.alpha = 1

				arg_82_1.dialog_:SetActive(true)
				SetActive(arg_82_1.leftNameGo_, true)

				local var_85_22 = arg_82_1:FormatText(StoryNameCfg[42].name)

				arg_82_1.leftNameTxt_.text = var_85_22

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_82_1.leftNameTxt_.transform)

				arg_82_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_82_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_82_1:RecordName(arg_82_1.leftNameTxt_.text)
				SetActive(arg_82_1.iconTrs_.gameObject, false)
				arg_82_1.callingController_:SetSelectedState("normal")

				local var_85_23 = arg_82_1:GetWordFromCfg(104112020)
				local var_85_24 = arg_82_1:FormatText(var_85_23.content)

				arg_82_1.text_.text = var_85_24

				LuaForUtil.ClearLinePrefixSymbol(arg_82_1.text_)

				local var_85_25 = 38
				local var_85_26 = utf8.len(var_85_24)
				local var_85_27 = var_85_25 <= 0 and var_85_21 or var_85_21 * (var_85_26 / var_85_25)

				if var_85_27 > 0 and var_85_21 < var_85_27 then
					arg_82_1.talkMaxDuration = var_85_27

					if var_85_27 + var_85_20 > arg_82_1.duration_ then
						arg_82_1.duration_ = var_85_27 + var_85_20
					end
				end

				arg_82_1.text_.text = var_85_24
				arg_82_1.typewritter.percent = 0

				arg_82_1.typewritter:SetDirty()
				arg_82_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_104112", "104112020", "story_v_out_104112.awb") ~= 0 then
					local var_85_28 = manager.audio:GetVoiceLength("story_v_out_104112", "104112020", "story_v_out_104112.awb") / 1000

					if var_85_28 + var_85_20 > arg_82_1.duration_ then
						arg_82_1.duration_ = var_85_28 + var_85_20
					end

					if var_85_23.prefab_name ~= "" and arg_82_1.actors_[var_85_23.prefab_name] ~= nil then
						local var_85_29 = LuaForUtil.PlayVoiceWithCriLipsync(arg_82_1.actors_[var_85_23.prefab_name].transform, "story_v_out_104112", "104112020", "story_v_out_104112.awb")

						arg_82_1:RecordAudio("104112020", var_85_29)
						arg_82_1:RecordAudio("104112020", var_85_29)
					else
						arg_82_1:AudioAction("play", "voice", "story_v_out_104112", "104112020", "story_v_out_104112.awb")
					end

					arg_82_1:RecordHistoryTalkVoice("story_v_out_104112", "104112020", "story_v_out_104112.awb")
				end

				arg_82_1:RecordContent(arg_82_1.text_.text)
			end

			local var_85_30 = math.max(var_85_21, arg_82_1.talkMaxDuration)

			if var_85_20 <= arg_82_1.time_ and arg_82_1.time_ < var_85_20 + var_85_30 then
				arg_82_1.typewritter.percent = (arg_82_1.time_ - var_85_20) / var_85_30

				arg_82_1.typewritter:SetDirty()
			end

			if arg_82_1.time_ >= var_85_20 + var_85_30 and arg_82_1.time_ < var_85_20 + var_85_30 + arg_85_0 then
				arg_82_1.typewritter.percent = 1

				arg_82_1.typewritter:SetDirty()
				arg_82_1:ShowNextGo(true)
			end
		end

		arg_82_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "4010ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.033,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_82_1:InitPlayNodeList()
	end,
	Play104112021 = function(arg_86_0, arg_86_1)
		arg_86_1.time_ = 0
		arg_86_1.frameCnt_ = 0
		arg_86_1.state_ = "playing"
		arg_86_1.curTalkId_ = 104112021
		arg_86_1.duration_ = 5.5

		local var_86_0 = {
			ja = 5.5,
			ko = 4.6,
			zh = 4.733,
			en = 5.433
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
				arg_86_0:Play104112022(arg_86_1)
			end
		end

		function arg_86_1.onSingleLineUpdate_(arg_89_0)
			local var_89_0 = "3009ui_story"

			if arg_86_1.actors_[var_89_0] == nil then
				local var_89_1 = Asset.Load("Char/" .. "3009ui_story")

				if not isNil(var_89_1) then
					local var_89_2 = Object.Instantiate(Asset.Load("Char/" .. "3009ui_story"), arg_86_1.stage_.transform)

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

			local var_89_5 = arg_86_1.actors_["3009ui_story"]
			local var_89_6 = 0

			if var_89_6 < arg_86_1.time_ and arg_86_1.time_ <= var_89_6 + arg_89_0 and not isNil(var_89_5) and arg_86_1.var_.characterEffect3009ui_story == nil then
				arg_86_1.var_.characterEffect3009ui_story = var_89_5:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_89_7 = 0.1

			if var_89_6 <= arg_86_1.time_ and arg_86_1.time_ < var_89_6 + var_89_7 and not isNil(var_89_5) then
				local var_89_8 = (arg_86_1.time_ - var_89_6) / var_89_7

				if arg_86_1.var_.characterEffect3009ui_story and not isNil(var_89_5) then
					arg_86_1.var_.characterEffect3009ui_story.fillFlat = false
				end
			end

			if arg_86_1.time_ >= var_89_6 + var_89_7 and arg_86_1.time_ < var_89_6 + var_89_7 + arg_89_0 and not isNil(var_89_5) and arg_86_1.var_.characterEffect3009ui_story then
				arg_86_1.var_.characterEffect3009ui_story.fillFlat = false
			end

			local var_89_9 = arg_86_1.actors_["4010ui_story"]
			local var_89_10 = 0

			if var_89_10 < arg_86_1.time_ and arg_86_1.time_ <= var_89_10 + arg_89_0 and not isNil(var_89_9) and arg_86_1.var_.characterEffect4010ui_story == nil then
				arg_86_1.var_.characterEffect4010ui_story = var_89_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_89_11 = 0.1

			if var_89_10 <= arg_86_1.time_ and arg_86_1.time_ < var_89_10 + var_89_11 and not isNil(var_89_9) then
				local var_89_12 = (arg_86_1.time_ - var_89_10) / var_89_11

				if arg_86_1.var_.characterEffect4010ui_story and not isNil(var_89_9) then
					local var_89_13 = Mathf.Lerp(0, 0.5, var_89_12)

					arg_86_1.var_.characterEffect4010ui_story.fillFlat = true
					arg_86_1.var_.characterEffect4010ui_story.fillRatio = var_89_13
				end
			end

			if arg_86_1.time_ >= var_89_10 + var_89_11 and arg_86_1.time_ < var_89_10 + var_89_11 + arg_89_0 and not isNil(var_89_9) and arg_86_1.var_.characterEffect4010ui_story then
				local var_89_14 = 0.5

				arg_86_1.var_.characterEffect4010ui_story.fillFlat = true
				arg_86_1.var_.characterEffect4010ui_story.fillRatio = var_89_14
			end

			local var_89_15 = arg_86_1.actors_["3009ui_story"].transform
			local var_89_16 = 0

			if var_89_16 < arg_86_1.time_ and arg_86_1.time_ <= var_89_16 + arg_89_0 then
				arg_86_1.var_.moveOldPos3009ui_story = var_89_15.localPosition

				local var_89_17 = "3009ui_story"

				arg_86_1:ShowWeapon(arg_86_1.var_[var_89_17 .. "Animator"].transform, true)
			end

			local var_89_18 = 0.001

			if var_89_16 <= arg_86_1.time_ and arg_86_1.time_ < var_89_16 + var_89_18 then
				local var_89_19 = (arg_86_1.time_ - var_89_16) / var_89_18
				local var_89_20 = Vector3.New(0.7, -1.75, -4.8)

				var_89_15.localPosition = Vector3.Lerp(arg_86_1.var_.moveOldPos3009ui_story, var_89_20, var_89_19)

				local var_89_21 = manager.ui.mainCamera.transform.position - var_89_15.position

				var_89_15.forward = Vector3.New(var_89_21.x, var_89_21.y, var_89_21.z)

				local var_89_22 = var_89_15.localEulerAngles

				var_89_22.z = 0
				var_89_22.x = 0
				var_89_15.localEulerAngles = var_89_22
			end

			if arg_86_1.time_ >= var_89_16 + var_89_18 and arg_86_1.time_ < var_89_16 + var_89_18 + arg_89_0 then
				var_89_15.localPosition = Vector3.New(0.7, -1.75, -4.8)

				local var_89_23 = manager.ui.mainCamera.transform.position - var_89_15.position

				var_89_15.forward = Vector3.New(var_89_23.x, var_89_23.y, var_89_23.z)

				local var_89_24 = var_89_15.localEulerAngles

				var_89_24.z = 0
				var_89_24.x = 0
				var_89_15.localEulerAngles = var_89_24
			end

			local var_89_25 = 0

			if var_89_25 < arg_86_1.time_ and arg_86_1.time_ <= var_89_25 + arg_89_0 then
				arg_86_1:PlayTimeline("3009ui_story", "StoryTimeline/CharAction/story3009/story3009action/3009action1_1")
			end

			local var_89_26 = 0

			if var_89_26 < arg_86_1.time_ and arg_86_1.time_ <= var_89_26 + arg_89_0 then
				arg_86_1:PlayTimeline("3009ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0104cva")
			end

			local var_89_27 = 0
			local var_89_28 = 0.65

			if var_89_27 < arg_86_1.time_ and arg_86_1.time_ <= var_89_27 + arg_89_0 then
				arg_86_1.talkMaxDuration = 0
				arg_86_1.dialogCg_.alpha = 1

				arg_86_1.dialog_:SetActive(true)
				SetActive(arg_86_1.leftNameGo_, true)

				local var_89_29 = arg_86_1:FormatText(StoryNameCfg[43].name)

				arg_86_1.leftNameTxt_.text = var_89_29

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_86_1.leftNameTxt_.transform)

				arg_86_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_86_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_86_1:RecordName(arg_86_1.leftNameTxt_.text)
				SetActive(arg_86_1.iconTrs_.gameObject, false)
				arg_86_1.callingController_:SetSelectedState("normal")

				local var_89_30 = arg_86_1:GetWordFromCfg(104112021)
				local var_89_31 = arg_86_1:FormatText(var_89_30.content)

				arg_86_1.text_.text = var_89_31

				LuaForUtil.ClearLinePrefixSymbol(arg_86_1.text_)

				local var_89_32 = 26
				local var_89_33 = utf8.len(var_89_31)
				local var_89_34 = var_89_32 <= 0 and var_89_28 or var_89_28 * (var_89_33 / var_89_32)

				if var_89_34 > 0 and var_89_28 < var_89_34 then
					arg_86_1.talkMaxDuration = var_89_34

					if var_89_34 + var_89_27 > arg_86_1.duration_ then
						arg_86_1.duration_ = var_89_34 + var_89_27
					end
				end

				arg_86_1.text_.text = var_89_31
				arg_86_1.typewritter.percent = 0

				arg_86_1.typewritter:SetDirty()
				arg_86_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_104112", "104112021", "story_v_out_104112.awb") ~= 0 then
					local var_89_35 = manager.audio:GetVoiceLength("story_v_out_104112", "104112021", "story_v_out_104112.awb") / 1000

					if var_89_35 + var_89_27 > arg_86_1.duration_ then
						arg_86_1.duration_ = var_89_35 + var_89_27
					end

					if var_89_30.prefab_name ~= "" and arg_86_1.actors_[var_89_30.prefab_name] ~= nil then
						local var_89_36 = LuaForUtil.PlayVoiceWithCriLipsync(arg_86_1.actors_[var_89_30.prefab_name].transform, "story_v_out_104112", "104112021", "story_v_out_104112.awb")

						arg_86_1:RecordAudio("104112021", var_89_36)
						arg_86_1:RecordAudio("104112021", var_89_36)
					else
						arg_86_1:AudioAction("play", "voice", "story_v_out_104112", "104112021", "story_v_out_104112.awb")
					end

					arg_86_1:RecordHistoryTalkVoice("story_v_out_104112", "104112021", "story_v_out_104112.awb")
				end

				arg_86_1:RecordContent(arg_86_1.text_.text)
			end

			local var_89_37 = math.max(var_89_28, arg_86_1.talkMaxDuration)

			if var_89_27 <= arg_86_1.time_ and arg_86_1.time_ < var_89_27 + var_89_37 then
				arg_86_1.typewritter.percent = (arg_86_1.time_ - var_89_27) / var_89_37

				arg_86_1.typewritter:SetDirty()
			end

			if arg_86_1.time_ >= var_89_27 + var_89_37 and arg_86_1.time_ < var_89_27 + var_89_37 + arg_89_0 then
				arg_86_1.typewritter.percent = 1

				arg_86_1.typewritter:SetDirty()
				arg_86_1:ShowNextGo(true)
			end
		end

		arg_86_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "3009ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.033,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_86_1:InitPlayNodeList()
	end,
	Play104112022 = function(arg_90_0, arg_90_1)
		arg_90_1.time_ = 0
		arg_90_1.frameCnt_ = 0
		arg_90_1.state_ = "playing"
		arg_90_1.curTalkId_ = 104112022
		arg_90_1.duration_ = 4.43

		local var_90_0 = {
			ja = 4.433,
			ko = 2.633,
			zh = 2.599999999999,
			en = 2.599999999999
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
				arg_90_0:Play104112023(arg_90_1)
			end
		end

		function arg_90_1.onSingleLineUpdate_(arg_93_0)
			local var_93_0 = arg_90_1.actors_["4010ui_story"]
			local var_93_1 = 0

			if var_93_1 < arg_90_1.time_ and arg_90_1.time_ <= var_93_1 + arg_93_0 and not isNil(var_93_0) and arg_90_1.var_.characterEffect4010ui_story == nil then
				arg_90_1.var_.characterEffect4010ui_story = var_93_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_93_2 = 0.1

			if var_93_1 <= arg_90_1.time_ and arg_90_1.time_ < var_93_1 + var_93_2 and not isNil(var_93_0) then
				local var_93_3 = (arg_90_1.time_ - var_93_1) / var_93_2

				if arg_90_1.var_.characterEffect4010ui_story and not isNil(var_93_0) then
					arg_90_1.var_.characterEffect4010ui_story.fillFlat = false
				end
			end

			if arg_90_1.time_ >= var_93_1 + var_93_2 and arg_90_1.time_ < var_93_1 + var_93_2 + arg_93_0 and not isNil(var_93_0) and arg_90_1.var_.characterEffect4010ui_story then
				arg_90_1.var_.characterEffect4010ui_story.fillFlat = false
			end

			local var_93_4 = 0

			if var_93_4 < arg_90_1.time_ and arg_90_1.time_ <= var_93_4 + arg_93_0 then
				arg_90_1:PlayTimeline("4010ui_story", "StoryTimeline/CharAction/story4010/story4010action/4010action4_2")
			end

			local var_93_5 = 0

			if var_93_5 < arg_90_1.time_ and arg_90_1.time_ <= var_93_5 + arg_93_0 then
				arg_90_1:PlayTimeline("4010ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3104cva")
			end

			local var_93_6 = arg_90_1.actors_["3009ui_story"]
			local var_93_7 = 0

			if var_93_7 < arg_90_1.time_ and arg_90_1.time_ <= var_93_7 + arg_93_0 and not isNil(var_93_6) and arg_90_1.var_.characterEffect3009ui_story == nil then
				arg_90_1.var_.characterEffect3009ui_story = var_93_6:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_93_8 = 0.1

			if var_93_7 <= arg_90_1.time_ and arg_90_1.time_ < var_93_7 + var_93_8 and not isNil(var_93_6) then
				local var_93_9 = (arg_90_1.time_ - var_93_7) / var_93_8

				if arg_90_1.var_.characterEffect3009ui_story and not isNil(var_93_6) then
					local var_93_10 = Mathf.Lerp(0, 0.5, var_93_9)

					arg_90_1.var_.characterEffect3009ui_story.fillFlat = true
					arg_90_1.var_.characterEffect3009ui_story.fillRatio = var_93_10
				end
			end

			if arg_90_1.time_ >= var_93_7 + var_93_8 and arg_90_1.time_ < var_93_7 + var_93_8 + arg_93_0 and not isNil(var_93_6) and arg_90_1.var_.characterEffect3009ui_story then
				local var_93_11 = 0.5

				arg_90_1.var_.characterEffect3009ui_story.fillFlat = true
				arg_90_1.var_.characterEffect3009ui_story.fillRatio = var_93_11
			end

			local var_93_12 = 0
			local var_93_13 = 0.275

			if var_93_12 < arg_90_1.time_ and arg_90_1.time_ <= var_93_12 + arg_93_0 then
				arg_90_1.talkMaxDuration = 0
				arg_90_1.dialogCg_.alpha = 1

				arg_90_1.dialog_:SetActive(true)
				SetActive(arg_90_1.leftNameGo_, true)

				local var_93_14 = arg_90_1:FormatText(StoryNameCfg[42].name)

				arg_90_1.leftNameTxt_.text = var_93_14

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_90_1.leftNameTxt_.transform)

				arg_90_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_90_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_90_1:RecordName(arg_90_1.leftNameTxt_.text)
				SetActive(arg_90_1.iconTrs_.gameObject, false)
				arg_90_1.callingController_:SetSelectedState("normal")

				local var_93_15 = arg_90_1:GetWordFromCfg(104112022)
				local var_93_16 = arg_90_1:FormatText(var_93_15.content)

				arg_90_1.text_.text = var_93_16

				LuaForUtil.ClearLinePrefixSymbol(arg_90_1.text_)

				local var_93_17 = 11
				local var_93_18 = utf8.len(var_93_16)
				local var_93_19 = var_93_17 <= 0 and var_93_13 or var_93_13 * (var_93_18 / var_93_17)

				if var_93_19 > 0 and var_93_13 < var_93_19 then
					arg_90_1.talkMaxDuration = var_93_19

					if var_93_19 + var_93_12 > arg_90_1.duration_ then
						arg_90_1.duration_ = var_93_19 + var_93_12
					end
				end

				arg_90_1.text_.text = var_93_16
				arg_90_1.typewritter.percent = 0

				arg_90_1.typewritter:SetDirty()
				arg_90_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_104112", "104112022", "story_v_out_104112.awb") ~= 0 then
					local var_93_20 = manager.audio:GetVoiceLength("story_v_out_104112", "104112022", "story_v_out_104112.awb") / 1000

					if var_93_20 + var_93_12 > arg_90_1.duration_ then
						arg_90_1.duration_ = var_93_20 + var_93_12
					end

					if var_93_15.prefab_name ~= "" and arg_90_1.actors_[var_93_15.prefab_name] ~= nil then
						local var_93_21 = LuaForUtil.PlayVoiceWithCriLipsync(arg_90_1.actors_[var_93_15.prefab_name].transform, "story_v_out_104112", "104112022", "story_v_out_104112.awb")

						arg_90_1:RecordAudio("104112022", var_93_21)
						arg_90_1:RecordAudio("104112022", var_93_21)
					else
						arg_90_1:AudioAction("play", "voice", "story_v_out_104112", "104112022", "story_v_out_104112.awb")
					end

					arg_90_1:RecordHistoryTalkVoice("story_v_out_104112", "104112022", "story_v_out_104112.awb")
				end

				arg_90_1:RecordContent(arg_90_1.text_.text)
			end

			local var_93_22 = math.max(var_93_13, arg_90_1.talkMaxDuration)

			if var_93_12 <= arg_90_1.time_ and arg_90_1.time_ < var_93_12 + var_93_22 then
				arg_90_1.typewritter.percent = (arg_90_1.time_ - var_93_12) / var_93_22

				arg_90_1.typewritter:SetDirty()
			end

			if arg_90_1.time_ >= var_93_12 + var_93_22 and arg_90_1.time_ < var_93_12 + var_93_22 + arg_93_0 then
				arg_90_1.typewritter.percent = 1

				arg_90_1.typewritter:SetDirty()
				arg_90_1:ShowNextGo(true)
			end
		end

		arg_90_1.nodeConfigList_ = {}

		arg_90_1:InitPlayNodeList()
	end,
	Play104112023 = function(arg_94_0, arg_94_1)
		arg_94_1.time_ = 0
		arg_94_1.frameCnt_ = 0
		arg_94_1.state_ = "playing"
		arg_94_1.curTalkId_ = 104112023
		arg_94_1.duration_ = 6.2

		local var_94_0 = {
			ja = 6.2,
			ko = 4.9,
			zh = 5.5,
			en = 5.2
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
				arg_94_0:Play104112024(arg_94_1)
			end
		end

		function arg_94_1.onSingleLineUpdate_(arg_97_0)
			local var_97_0 = arg_94_1.actors_["3009ui_story"]
			local var_97_1 = 0

			if var_97_1 < arg_94_1.time_ and arg_94_1.time_ <= var_97_1 + arg_97_0 and not isNil(var_97_0) and arg_94_1.var_.characterEffect3009ui_story == nil then
				arg_94_1.var_.characterEffect3009ui_story = var_97_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_97_2 = 0.1

			if var_97_1 <= arg_94_1.time_ and arg_94_1.time_ < var_97_1 + var_97_2 and not isNil(var_97_0) then
				local var_97_3 = (arg_94_1.time_ - var_97_1) / var_97_2

				if arg_94_1.var_.characterEffect3009ui_story and not isNil(var_97_0) then
					arg_94_1.var_.characterEffect3009ui_story.fillFlat = false
				end
			end

			if arg_94_1.time_ >= var_97_1 + var_97_2 and arg_94_1.time_ < var_97_1 + var_97_2 + arg_97_0 and not isNil(var_97_0) and arg_94_1.var_.characterEffect3009ui_story then
				arg_94_1.var_.characterEffect3009ui_story.fillFlat = false
			end

			local var_97_4 = arg_94_1.actors_["4010ui_story"]
			local var_97_5 = 0

			if var_97_5 < arg_94_1.time_ and arg_94_1.time_ <= var_97_5 + arg_97_0 and not isNil(var_97_4) and arg_94_1.var_.characterEffect4010ui_story == nil then
				arg_94_1.var_.characterEffect4010ui_story = var_97_4:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_97_6 = 0.1

			if var_97_5 <= arg_94_1.time_ and arg_94_1.time_ < var_97_5 + var_97_6 and not isNil(var_97_4) then
				local var_97_7 = (arg_94_1.time_ - var_97_5) / var_97_6

				if arg_94_1.var_.characterEffect4010ui_story and not isNil(var_97_4) then
					local var_97_8 = Mathf.Lerp(0, 0.5, var_97_7)

					arg_94_1.var_.characterEffect4010ui_story.fillFlat = true
					arg_94_1.var_.characterEffect4010ui_story.fillRatio = var_97_8
				end
			end

			if arg_94_1.time_ >= var_97_5 + var_97_6 and arg_94_1.time_ < var_97_5 + var_97_6 + arg_97_0 and not isNil(var_97_4) and arg_94_1.var_.characterEffect4010ui_story then
				local var_97_9 = 0.5

				arg_94_1.var_.characterEffect4010ui_story.fillFlat = true
				arg_94_1.var_.characterEffect4010ui_story.fillRatio = var_97_9
			end

			local var_97_10 = 0

			if var_97_10 < arg_94_1.time_ and arg_94_1.time_ <= var_97_10 + arg_97_0 then
				arg_94_1:PlayTimeline("3009ui_story", "StoryTimeline/CharAction/story3009/story3009action/3009action1_1")
			end

			local var_97_11 = 0

			if var_97_11 < arg_94_1.time_ and arg_94_1.time_ <= var_97_11 + arg_97_0 then
				arg_94_1:PlayTimeline("3009ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0104cva")
			end

			local var_97_12 = 0
			local var_97_13 = 0.675

			if var_97_12 < arg_94_1.time_ and arg_94_1.time_ <= var_97_12 + arg_97_0 then
				arg_94_1.talkMaxDuration = 0
				arg_94_1.dialogCg_.alpha = 1

				arg_94_1.dialog_:SetActive(true)
				SetActive(arg_94_1.leftNameGo_, true)

				local var_97_14 = arg_94_1:FormatText(StoryNameCfg[43].name)

				arg_94_1.leftNameTxt_.text = var_97_14

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_94_1.leftNameTxt_.transform)

				arg_94_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_94_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_94_1:RecordName(arg_94_1.leftNameTxt_.text)
				SetActive(arg_94_1.iconTrs_.gameObject, false)
				arg_94_1.callingController_:SetSelectedState("normal")

				local var_97_15 = arg_94_1:GetWordFromCfg(104112023)
				local var_97_16 = arg_94_1:FormatText(var_97_15.content)

				arg_94_1.text_.text = var_97_16

				LuaForUtil.ClearLinePrefixSymbol(arg_94_1.text_)

				local var_97_17 = 27
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

				if manager.audio:GetVoiceLength("story_v_out_104112", "104112023", "story_v_out_104112.awb") ~= 0 then
					local var_97_20 = manager.audio:GetVoiceLength("story_v_out_104112", "104112023", "story_v_out_104112.awb") / 1000

					if var_97_20 + var_97_12 > arg_94_1.duration_ then
						arg_94_1.duration_ = var_97_20 + var_97_12
					end

					if var_97_15.prefab_name ~= "" and arg_94_1.actors_[var_97_15.prefab_name] ~= nil then
						local var_97_21 = LuaForUtil.PlayVoiceWithCriLipsync(arg_94_1.actors_[var_97_15.prefab_name].transform, "story_v_out_104112", "104112023", "story_v_out_104112.awb")

						arg_94_1:RecordAudio("104112023", var_97_21)
						arg_94_1:RecordAudio("104112023", var_97_21)
					else
						arg_94_1:AudioAction("play", "voice", "story_v_out_104112", "104112023", "story_v_out_104112.awb")
					end

					arg_94_1:RecordHistoryTalkVoice("story_v_out_104112", "104112023", "story_v_out_104112.awb")
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
	Play104112024 = function(arg_98_0, arg_98_1)
		arg_98_1.time_ = 0
		arg_98_1.frameCnt_ = 0
		arg_98_1.state_ = "playing"
		arg_98_1.curTalkId_ = 104112024
		arg_98_1.duration_ = 3.43

		local var_98_0 = {
			ja = 3.433,
			ko = 2.733,
			zh = 3,
			en = 3.4
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
				arg_98_0:Play104112025(arg_98_1)
			end
		end

		function arg_98_1.onSingleLineUpdate_(arg_101_0)
			local var_101_0 = arg_98_1.actors_["4010ui_story"]
			local var_101_1 = 0

			if var_101_1 < arg_98_1.time_ and arg_98_1.time_ <= var_101_1 + arg_101_0 and not isNil(var_101_0) and arg_98_1.var_.characterEffect4010ui_story == nil then
				arg_98_1.var_.characterEffect4010ui_story = var_101_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_101_2 = 0.1

			if var_101_1 <= arg_98_1.time_ and arg_98_1.time_ < var_101_1 + var_101_2 and not isNil(var_101_0) then
				local var_101_3 = (arg_98_1.time_ - var_101_1) / var_101_2

				if arg_98_1.var_.characterEffect4010ui_story and not isNil(var_101_0) then
					arg_98_1.var_.characterEffect4010ui_story.fillFlat = false
				end
			end

			if arg_98_1.time_ >= var_101_1 + var_101_2 and arg_98_1.time_ < var_101_1 + var_101_2 + arg_101_0 and not isNil(var_101_0) and arg_98_1.var_.characterEffect4010ui_story then
				arg_98_1.var_.characterEffect4010ui_story.fillFlat = false
			end

			local var_101_4 = arg_98_1.actors_["3009ui_story"]
			local var_101_5 = 0

			if var_101_5 < arg_98_1.time_ and arg_98_1.time_ <= var_101_5 + arg_101_0 and not isNil(var_101_4) and arg_98_1.var_.characterEffect3009ui_story == nil then
				arg_98_1.var_.characterEffect3009ui_story = var_101_4:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_101_6 = 0.1

			if var_101_5 <= arg_98_1.time_ and arg_98_1.time_ < var_101_5 + var_101_6 and not isNil(var_101_4) then
				local var_101_7 = (arg_98_1.time_ - var_101_5) / var_101_6

				if arg_98_1.var_.characterEffect3009ui_story and not isNil(var_101_4) then
					local var_101_8 = Mathf.Lerp(0, 0.5, var_101_7)

					arg_98_1.var_.characterEffect3009ui_story.fillFlat = true
					arg_98_1.var_.characterEffect3009ui_story.fillRatio = var_101_8
				end
			end

			if arg_98_1.time_ >= var_101_5 + var_101_6 and arg_98_1.time_ < var_101_5 + var_101_6 + arg_101_0 and not isNil(var_101_4) and arg_98_1.var_.characterEffect3009ui_story then
				local var_101_9 = 0.5

				arg_98_1.var_.characterEffect3009ui_story.fillFlat = true
				arg_98_1.var_.characterEffect3009ui_story.fillRatio = var_101_9
			end

			local var_101_10 = 0

			if var_101_10 < arg_98_1.time_ and arg_98_1.time_ <= var_101_10 + arg_101_0 then
				arg_98_1:PlayTimeline("4010ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3104cva")
			end

			local var_101_11 = 0
			local var_101_12 = 0.3

			if var_101_11 < arg_98_1.time_ and arg_98_1.time_ <= var_101_11 + arg_101_0 then
				arg_98_1.talkMaxDuration = 0
				arg_98_1.dialogCg_.alpha = 1

				arg_98_1.dialog_:SetActive(true)
				SetActive(arg_98_1.leftNameGo_, true)

				local var_101_13 = arg_98_1:FormatText(StoryNameCfg[42].name)

				arg_98_1.leftNameTxt_.text = var_101_13

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_98_1.leftNameTxt_.transform)

				arg_98_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_98_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_98_1:RecordName(arg_98_1.leftNameTxt_.text)
				SetActive(arg_98_1.iconTrs_.gameObject, false)
				arg_98_1.callingController_:SetSelectedState("normal")

				local var_101_14 = arg_98_1:GetWordFromCfg(104112024)
				local var_101_15 = arg_98_1:FormatText(var_101_14.content)

				arg_98_1.text_.text = var_101_15

				LuaForUtil.ClearLinePrefixSymbol(arg_98_1.text_)

				local var_101_16 = 12
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

				if manager.audio:GetVoiceLength("story_v_out_104112", "104112024", "story_v_out_104112.awb") ~= 0 then
					local var_101_19 = manager.audio:GetVoiceLength("story_v_out_104112", "104112024", "story_v_out_104112.awb") / 1000

					if var_101_19 + var_101_11 > arg_98_1.duration_ then
						arg_98_1.duration_ = var_101_19 + var_101_11
					end

					if var_101_14.prefab_name ~= "" and arg_98_1.actors_[var_101_14.prefab_name] ~= nil then
						local var_101_20 = LuaForUtil.PlayVoiceWithCriLipsync(arg_98_1.actors_[var_101_14.prefab_name].transform, "story_v_out_104112", "104112024", "story_v_out_104112.awb")

						arg_98_1:RecordAudio("104112024", var_101_20)
						arg_98_1:RecordAudio("104112024", var_101_20)
					else
						arg_98_1:AudioAction("play", "voice", "story_v_out_104112", "104112024", "story_v_out_104112.awb")
					end

					arg_98_1:RecordHistoryTalkVoice("story_v_out_104112", "104112024", "story_v_out_104112.awb")
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
	Play104112025 = function(arg_102_0, arg_102_1)
		arg_102_1.time_ = 0
		arg_102_1.frameCnt_ = 0
		arg_102_1.state_ = "playing"
		arg_102_1.curTalkId_ = 104112025
		arg_102_1.duration_ = 5

		SetActive(arg_102_1.tipsGo_, false)

		function arg_102_1.onSingleLineFinish_()
			arg_102_1.onSingleLineUpdate_ = nil
			arg_102_1.onSingleLineFinish_ = nil
			arg_102_1.state_ = "waiting"
		end

		function arg_102_1.playNext_(arg_104_0)
			if arg_104_0 == 1 then
				arg_102_0:Play104112026(arg_102_1)
			end
		end

		function arg_102_1.onSingleLineUpdate_(arg_105_0)
			local var_105_0 = arg_102_1.actors_["4010ui_story"]
			local var_105_1 = 0

			if var_105_1 < arg_102_1.time_ and arg_102_1.time_ <= var_105_1 + arg_105_0 and not isNil(var_105_0) and arg_102_1.var_.characterEffect4010ui_story == nil then
				arg_102_1.var_.characterEffect4010ui_story = var_105_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_105_2 = 0.1

			if var_105_1 <= arg_102_1.time_ and arg_102_1.time_ < var_105_1 + var_105_2 and not isNil(var_105_0) then
				local var_105_3 = (arg_102_1.time_ - var_105_1) / var_105_2

				if arg_102_1.var_.characterEffect4010ui_story and not isNil(var_105_0) then
					local var_105_4 = Mathf.Lerp(0, 0.5, var_105_3)

					arg_102_1.var_.characterEffect4010ui_story.fillFlat = true
					arg_102_1.var_.characterEffect4010ui_story.fillRatio = var_105_4
				end
			end

			if arg_102_1.time_ >= var_105_1 + var_105_2 and arg_102_1.time_ < var_105_1 + var_105_2 + arg_105_0 and not isNil(var_105_0) and arg_102_1.var_.characterEffect4010ui_story then
				local var_105_5 = 0.5

				arg_102_1.var_.characterEffect4010ui_story.fillFlat = true
				arg_102_1.var_.characterEffect4010ui_story.fillRatio = var_105_5
			end

			local var_105_6 = arg_102_1.actors_["4010ui_story"].transform
			local var_105_7 = 0

			if var_105_7 < arg_102_1.time_ and arg_102_1.time_ <= var_105_7 + arg_105_0 then
				arg_102_1.var_.moveOldPos4010ui_story = var_105_6.localPosition
			end

			local var_105_8 = 0.001

			if var_105_7 <= arg_102_1.time_ and arg_102_1.time_ < var_105_7 + var_105_8 then
				local var_105_9 = (arg_102_1.time_ - var_105_7) / var_105_8
				local var_105_10 = Vector3.New(0, 100, 0)

				var_105_6.localPosition = Vector3.Lerp(arg_102_1.var_.moveOldPos4010ui_story, var_105_10, var_105_9)

				local var_105_11 = manager.ui.mainCamera.transform.position - var_105_6.position

				var_105_6.forward = Vector3.New(var_105_11.x, var_105_11.y, var_105_11.z)

				local var_105_12 = var_105_6.localEulerAngles

				var_105_12.z = 0
				var_105_12.x = 0
				var_105_6.localEulerAngles = var_105_12
			end

			if arg_102_1.time_ >= var_105_7 + var_105_8 and arg_102_1.time_ < var_105_7 + var_105_8 + arg_105_0 then
				var_105_6.localPosition = Vector3.New(0, 100, 0)

				local var_105_13 = manager.ui.mainCamera.transform.position - var_105_6.position

				var_105_6.forward = Vector3.New(var_105_13.x, var_105_13.y, var_105_13.z)

				local var_105_14 = var_105_6.localEulerAngles

				var_105_14.z = 0
				var_105_14.x = 0
				var_105_6.localEulerAngles = var_105_14
			end

			local var_105_15 = arg_102_1.actors_["3009ui_story"].transform
			local var_105_16 = 0

			if var_105_16 < arg_102_1.time_ and arg_102_1.time_ <= var_105_16 + arg_105_0 then
				arg_102_1.var_.moveOldPos3009ui_story = var_105_15.localPosition
			end

			local var_105_17 = 0.001

			if var_105_16 <= arg_102_1.time_ and arg_102_1.time_ < var_105_16 + var_105_17 then
				local var_105_18 = (arg_102_1.time_ - var_105_16) / var_105_17
				local var_105_19 = Vector3.New(0, 100, 0)

				var_105_15.localPosition = Vector3.Lerp(arg_102_1.var_.moveOldPos3009ui_story, var_105_19, var_105_18)

				local var_105_20 = manager.ui.mainCamera.transform.position - var_105_15.position

				var_105_15.forward = Vector3.New(var_105_20.x, var_105_20.y, var_105_20.z)

				local var_105_21 = var_105_15.localEulerAngles

				var_105_21.z = 0
				var_105_21.x = 0
				var_105_15.localEulerAngles = var_105_21
			end

			if arg_102_1.time_ >= var_105_16 + var_105_17 and arg_102_1.time_ < var_105_16 + var_105_17 + arg_105_0 then
				var_105_15.localPosition = Vector3.New(0, 100, 0)

				local var_105_22 = manager.ui.mainCamera.transform.position - var_105_15.position

				var_105_15.forward = Vector3.New(var_105_22.x, var_105_22.y, var_105_22.z)

				local var_105_23 = var_105_15.localEulerAngles

				var_105_23.z = 0
				var_105_23.x = 0
				var_105_15.localEulerAngles = var_105_23
			end

			local var_105_24 = 0
			local var_105_25 = 0.7

			if var_105_24 < arg_102_1.time_ and arg_102_1.time_ <= var_105_24 + arg_105_0 then
				arg_102_1.talkMaxDuration = 0
				arg_102_1.dialogCg_.alpha = 1

				arg_102_1.dialog_:SetActive(true)
				SetActive(arg_102_1.leftNameGo_, false)

				arg_102_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_102_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_102_1:RecordName(arg_102_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_102_1.iconTrs_.gameObject, false)
				arg_102_1.callingController_:SetSelectedState("normal")

				local var_105_26 = arg_102_1:GetWordFromCfg(104112025)
				local var_105_27 = arg_102_1:FormatText(var_105_26.content)

				arg_102_1.text_.text = var_105_27

				LuaForUtil.ClearLinePrefixSymbol(arg_102_1.text_)

				local var_105_28 = 28
				local var_105_29 = utf8.len(var_105_27)
				local var_105_30 = var_105_28 <= 0 and var_105_25 or var_105_25 * (var_105_29 / var_105_28)

				if var_105_30 > 0 and var_105_25 < var_105_30 then
					arg_102_1.talkMaxDuration = var_105_30

					if var_105_30 + var_105_24 > arg_102_1.duration_ then
						arg_102_1.duration_ = var_105_30 + var_105_24
					end
				end

				arg_102_1.text_.text = var_105_27
				arg_102_1.typewritter.percent = 0

				arg_102_1.typewritter:SetDirty()
				arg_102_1:ShowNextGo(false)
				arg_102_1:RecordContent(arg_102_1.text_.text)
			end

			local var_105_31 = math.max(var_105_25, arg_102_1.talkMaxDuration)

			if var_105_24 <= arg_102_1.time_ and arg_102_1.time_ < var_105_24 + var_105_31 then
				arg_102_1.typewritter.percent = (arg_102_1.time_ - var_105_24) / var_105_31

				arg_102_1.typewritter:SetDirty()
			end

			if arg_102_1.time_ >= var_105_24 + var_105_31 and arg_102_1.time_ < var_105_24 + var_105_31 + arg_105_0 then
				arg_102_1.typewritter.percent = 1

				arg_102_1.typewritter:SetDirty()
				arg_102_1:ShowNextGo(true)
			end
		end

		arg_102_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "4010ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.033,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "3009ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.033,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_102_1:InitPlayNodeList()
	end,
	Play104112026 = function(arg_106_0, arg_106_1)
		arg_106_1.time_ = 0
		arg_106_1.frameCnt_ = 0
		arg_106_1.state_ = "playing"
		arg_106_1.curTalkId_ = 104112026
		arg_106_1.duration_ = 18.73

		local var_106_0 = {
			ja = 14.833,
			ko = 12.3,
			zh = 12.833,
			en = 18.733
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
				arg_106_0:Play104112027(arg_106_1)
			end
		end

		function arg_106_1.onSingleLineUpdate_(arg_109_0)
			local var_109_0 = arg_106_1.actors_["4010ui_story"]
			local var_109_1 = 0

			if var_109_1 < arg_106_1.time_ and arg_106_1.time_ <= var_109_1 + arg_109_0 and not isNil(var_109_0) and arg_106_1.var_.characterEffect4010ui_story == nil then
				arg_106_1.var_.characterEffect4010ui_story = var_109_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_109_2 = 0.1

			if var_109_1 <= arg_106_1.time_ and arg_106_1.time_ < var_109_1 + var_109_2 and not isNil(var_109_0) then
				local var_109_3 = (arg_106_1.time_ - var_109_1) / var_109_2

				if arg_106_1.var_.characterEffect4010ui_story and not isNil(var_109_0) then
					arg_106_1.var_.characterEffect4010ui_story.fillFlat = false
				end
			end

			if arg_106_1.time_ >= var_109_1 + var_109_2 and arg_106_1.time_ < var_109_1 + var_109_2 + arg_109_0 and not isNil(var_109_0) and arg_106_1.var_.characterEffect4010ui_story then
				arg_106_1.var_.characterEffect4010ui_story.fillFlat = false
			end

			local var_109_4 = arg_106_1.actors_["4010ui_story"].transform
			local var_109_5 = 0

			if var_109_5 < arg_106_1.time_ and arg_106_1.time_ <= var_109_5 + arg_109_0 then
				arg_106_1.var_.moveOldPos4010ui_story = var_109_4.localPosition
			end

			local var_109_6 = 0.001

			if var_109_5 <= arg_106_1.time_ and arg_106_1.time_ < var_109_5 + var_109_6 then
				local var_109_7 = (arg_106_1.time_ - var_109_5) / var_109_6
				local var_109_8 = Vector3.New(0, -1.59, -5.2)

				var_109_4.localPosition = Vector3.Lerp(arg_106_1.var_.moveOldPos4010ui_story, var_109_8, var_109_7)

				local var_109_9 = manager.ui.mainCamera.transform.position - var_109_4.position

				var_109_4.forward = Vector3.New(var_109_9.x, var_109_9.y, var_109_9.z)

				local var_109_10 = var_109_4.localEulerAngles

				var_109_10.z = 0
				var_109_10.x = 0
				var_109_4.localEulerAngles = var_109_10
			end

			if arg_106_1.time_ >= var_109_5 + var_109_6 and arg_106_1.time_ < var_109_5 + var_109_6 + arg_109_0 then
				var_109_4.localPosition = Vector3.New(0, -1.59, -5.2)

				local var_109_11 = manager.ui.mainCamera.transform.position - var_109_4.position

				var_109_4.forward = Vector3.New(var_109_11.x, var_109_11.y, var_109_11.z)

				local var_109_12 = var_109_4.localEulerAngles

				var_109_12.z = 0
				var_109_12.x = 0
				var_109_4.localEulerAngles = var_109_12
			end

			local var_109_13 = 0

			if var_109_13 < arg_106_1.time_ and arg_106_1.time_ <= var_109_13 + arg_109_0 then
				arg_106_1:PlayTimeline("4010ui_story", "StoryTimeline/CharAction/story4010/story4010action/4010action1_1")
			end

			local var_109_14 = 0

			if var_109_14 < arg_106_1.time_ and arg_106_1.time_ <= var_109_14 + arg_109_0 then
				arg_106_1:PlayTimeline("4010ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0104cva")
			end

			local var_109_15 = 0
			local var_109_16 = 1.3

			if var_109_15 < arg_106_1.time_ and arg_106_1.time_ <= var_109_15 + arg_109_0 then
				arg_106_1.talkMaxDuration = 0
				arg_106_1.dialogCg_.alpha = 1

				arg_106_1.dialog_:SetActive(true)
				SetActive(arg_106_1.leftNameGo_, true)

				local var_109_17 = arg_106_1:FormatText(StoryNameCfg[42].name)

				arg_106_1.leftNameTxt_.text = var_109_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_106_1.leftNameTxt_.transform)

				arg_106_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_106_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_106_1:RecordName(arg_106_1.leftNameTxt_.text)
				SetActive(arg_106_1.iconTrs_.gameObject, false)
				arg_106_1.callingController_:SetSelectedState("normal")

				local var_109_18 = arg_106_1:GetWordFromCfg(104112026)
				local var_109_19 = arg_106_1:FormatText(var_109_18.content)

				arg_106_1.text_.text = var_109_19

				LuaForUtil.ClearLinePrefixSymbol(arg_106_1.text_)

				local var_109_20 = 52
				local var_109_21 = utf8.len(var_109_19)
				local var_109_22 = var_109_20 <= 0 and var_109_16 or var_109_16 * (var_109_21 / var_109_20)

				if var_109_22 > 0 and var_109_16 < var_109_22 then
					arg_106_1.talkMaxDuration = var_109_22

					if var_109_22 + var_109_15 > arg_106_1.duration_ then
						arg_106_1.duration_ = var_109_22 + var_109_15
					end
				end

				arg_106_1.text_.text = var_109_19
				arg_106_1.typewritter.percent = 0

				arg_106_1.typewritter:SetDirty()
				arg_106_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_104112", "104112026", "story_v_out_104112.awb") ~= 0 then
					local var_109_23 = manager.audio:GetVoiceLength("story_v_out_104112", "104112026", "story_v_out_104112.awb") / 1000

					if var_109_23 + var_109_15 > arg_106_1.duration_ then
						arg_106_1.duration_ = var_109_23 + var_109_15
					end

					if var_109_18.prefab_name ~= "" and arg_106_1.actors_[var_109_18.prefab_name] ~= nil then
						local var_109_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_106_1.actors_[var_109_18.prefab_name].transform, "story_v_out_104112", "104112026", "story_v_out_104112.awb")

						arg_106_1:RecordAudio("104112026", var_109_24)
						arg_106_1:RecordAudio("104112026", var_109_24)
					else
						arg_106_1:AudioAction("play", "voice", "story_v_out_104112", "104112026", "story_v_out_104112.awb")
					end

					arg_106_1:RecordHistoryTalkVoice("story_v_out_104112", "104112026", "story_v_out_104112.awb")
				end

				arg_106_1:RecordContent(arg_106_1.text_.text)
			end

			local var_109_25 = math.max(var_109_16, arg_106_1.talkMaxDuration)

			if var_109_15 <= arg_106_1.time_ and arg_106_1.time_ < var_109_15 + var_109_25 then
				arg_106_1.typewritter.percent = (arg_106_1.time_ - var_109_15) / var_109_25

				arg_106_1.typewritter:SetDirty()
			end

			if arg_106_1.time_ >= var_109_15 + var_109_25 and arg_106_1.time_ < var_109_15 + var_109_25 + arg_109_0 then
				arg_106_1.typewritter.percent = 1

				arg_106_1.typewritter:SetDirty()
				arg_106_1:ShowNextGo(true)
			end
		end

		arg_106_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "4010ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.033,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_106_1:InitPlayNodeList()
	end,
	Play104112027 = function(arg_110_0, arg_110_1)
		arg_110_1.time_ = 0
		arg_110_1.frameCnt_ = 0
		arg_110_1.state_ = "playing"
		arg_110_1.curTalkId_ = 104112027
		arg_110_1.duration_ = 5.03

		local var_110_0 = {
			ja = 5.033,
			ko = 3.566,
			zh = 3.666,
			en = 2.866
		}
		local var_110_1 = manager.audio:GetLocalizationFlag()

		if var_110_0[var_110_1] ~= nil then
			arg_110_1.duration_ = var_110_0[var_110_1]
		end

		SetActive(arg_110_1.tipsGo_, false)

		function arg_110_1.onSingleLineFinish_()
			arg_110_1.onSingleLineUpdate_ = nil
			arg_110_1.onSingleLineFinish_ = nil
			arg_110_1.state_ = "waiting"
		end

		function arg_110_1.playNext_(arg_112_0)
			if arg_112_0 == 1 then
				arg_110_0:Play104112028(arg_110_1)
			end
		end

		function arg_110_1.onSingleLineUpdate_(arg_113_0)
			local var_113_0 = "2020_tpose"

			if arg_110_1.actors_[var_113_0] == nil then
				local var_113_1 = Asset.Load("Char/" .. "2020_tpose")

				if not isNil(var_113_1) then
					local var_113_2 = Object.Instantiate(Asset.Load("Char/" .. "2020_tpose"), arg_110_1.stage_.transform)

					var_113_2.name = var_113_0
					var_113_2.transform.localPosition = Vector3.New(0, 100, 0)
					arg_110_1.actors_[var_113_0] = var_113_2

					local var_113_3 = var_113_2:GetComponentInChildren(typeof(CharacterEffect))

					var_113_3.enabled = true

					local var_113_4 = GameObjectTools.GetOrAddComponent(var_113_2, typeof(DynamicBoneHelper))

					if var_113_4 then
						var_113_4:EnableDynamicBone(false)
					end

					arg_110_1:ShowWeapon(var_113_3.transform, false)

					arg_110_1.var_[var_113_0 .. "Animator"] = var_113_3.gameObject:GetComponent(typeof(UnityEngine.Animator))
					arg_110_1.var_[var_113_0 .. "Animator"].applyRootMotion = true
					arg_110_1.var_[var_113_0 .. "LipSync"] = var_113_3.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
				end
			end

			local var_113_5 = arg_110_1.actors_["2020_tpose"]
			local var_113_6 = 0

			if var_113_6 < arg_110_1.time_ and arg_110_1.time_ <= var_113_6 + arg_113_0 and not isNil(var_113_5) and arg_110_1.var_.characterEffect2020_tpose == nil then
				arg_110_1.var_.characterEffect2020_tpose = var_113_5:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_113_7 = 0.1

			if var_113_6 <= arg_110_1.time_ and arg_110_1.time_ < var_113_6 + var_113_7 and not isNil(var_113_5) then
				local var_113_8 = (arg_110_1.time_ - var_113_6) / var_113_7

				if arg_110_1.var_.characterEffect2020_tpose and not isNil(var_113_5) then
					arg_110_1.var_.characterEffect2020_tpose.fillFlat = false
				end
			end

			if arg_110_1.time_ >= var_113_6 + var_113_7 and arg_110_1.time_ < var_113_6 + var_113_7 + arg_113_0 and not isNil(var_113_5) and arg_110_1.var_.characterEffect2020_tpose then
				arg_110_1.var_.characterEffect2020_tpose.fillFlat = false
			end

			local var_113_9 = arg_110_1.actors_["4010ui_story"]
			local var_113_10 = 0

			if var_113_10 < arg_110_1.time_ and arg_110_1.time_ <= var_113_10 + arg_113_0 and not isNil(var_113_9) and arg_110_1.var_.characterEffect4010ui_story == nil then
				arg_110_1.var_.characterEffect4010ui_story = var_113_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_113_11 = 0.1

			if var_113_10 <= arg_110_1.time_ and arg_110_1.time_ < var_113_10 + var_113_11 and not isNil(var_113_9) then
				local var_113_12 = (arg_110_1.time_ - var_113_10) / var_113_11

				if arg_110_1.var_.characterEffect4010ui_story and not isNil(var_113_9) then
					local var_113_13 = Mathf.Lerp(0, 0.5, var_113_12)

					arg_110_1.var_.characterEffect4010ui_story.fillFlat = true
					arg_110_1.var_.characterEffect4010ui_story.fillRatio = var_113_13
				end
			end

			if arg_110_1.time_ >= var_113_10 + var_113_11 and arg_110_1.time_ < var_113_10 + var_113_11 + arg_113_0 and not isNil(var_113_9) and arg_110_1.var_.characterEffect4010ui_story then
				local var_113_14 = 0.5

				arg_110_1.var_.characterEffect4010ui_story.fillFlat = true
				arg_110_1.var_.characterEffect4010ui_story.fillRatio = var_113_14
			end

			local var_113_15 = arg_110_1.actors_["4010ui_story"].transform
			local var_113_16 = 0

			if var_113_16 < arg_110_1.time_ and arg_110_1.time_ <= var_113_16 + arg_113_0 then
				arg_110_1.var_.moveOldPos4010ui_story = var_113_15.localPosition
			end

			local var_113_17 = 0.001

			if var_113_16 <= arg_110_1.time_ and arg_110_1.time_ < var_113_16 + var_113_17 then
				local var_113_18 = (arg_110_1.time_ - var_113_16) / var_113_17
				local var_113_19 = Vector3.New(0, 100, 0)

				var_113_15.localPosition = Vector3.Lerp(arg_110_1.var_.moveOldPos4010ui_story, var_113_19, var_113_18)

				local var_113_20 = manager.ui.mainCamera.transform.position - var_113_15.position

				var_113_15.forward = Vector3.New(var_113_20.x, var_113_20.y, var_113_20.z)

				local var_113_21 = var_113_15.localEulerAngles

				var_113_21.z = 0
				var_113_21.x = 0
				var_113_15.localEulerAngles = var_113_21
			end

			if arg_110_1.time_ >= var_113_16 + var_113_17 and arg_110_1.time_ < var_113_16 + var_113_17 + arg_113_0 then
				var_113_15.localPosition = Vector3.New(0, 100, 0)

				local var_113_22 = manager.ui.mainCamera.transform.position - var_113_15.position

				var_113_15.forward = Vector3.New(var_113_22.x, var_113_22.y, var_113_22.z)

				local var_113_23 = var_113_15.localEulerAngles

				var_113_23.z = 0
				var_113_23.x = 0
				var_113_15.localEulerAngles = var_113_23
			end

			local var_113_24 = 0
			local var_113_25 = 0.4

			if var_113_24 < arg_110_1.time_ and arg_110_1.time_ <= var_113_24 + arg_113_0 then
				arg_110_1.talkMaxDuration = 0
				arg_110_1.dialogCg_.alpha = 1

				arg_110_1.dialog_:SetActive(true)
				SetActive(arg_110_1.leftNameGo_, true)

				local var_113_26 = arg_110_1:FormatText(StoryNameCfg[19].name)

				arg_110_1.leftNameTxt_.text = var_113_26

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_110_1.leftNameTxt_.transform)

				arg_110_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_110_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_110_1:RecordName(arg_110_1.leftNameTxt_.text)
				SetActive(arg_110_1.iconTrs_.gameObject, true)
				arg_110_1.iconController_:SetSelectedState("hero")

				arg_110_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_20301")

				arg_110_1.callingController_:SetSelectedState("normal")

				arg_110_1.keyicon_.color = Color.New(1, 1, 1)
				arg_110_1.icon_.color = Color.New(1, 1, 1)

				local var_113_27 = arg_110_1:GetWordFromCfg(104112027)
				local var_113_28 = arg_110_1:FormatText(var_113_27.content)

				arg_110_1.text_.text = var_113_28

				LuaForUtil.ClearLinePrefixSymbol(arg_110_1.text_)

				local var_113_29 = 16
				local var_113_30 = utf8.len(var_113_28)
				local var_113_31 = var_113_29 <= 0 and var_113_25 or var_113_25 * (var_113_30 / var_113_29)

				if var_113_31 > 0 and var_113_25 < var_113_31 then
					arg_110_1.talkMaxDuration = var_113_31

					if var_113_31 + var_113_24 > arg_110_1.duration_ then
						arg_110_1.duration_ = var_113_31 + var_113_24
					end
				end

				arg_110_1.text_.text = var_113_28
				arg_110_1.typewritter.percent = 0

				arg_110_1.typewritter:SetDirty()
				arg_110_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_104112", "104112027", "story_v_out_104112.awb") ~= 0 then
					local var_113_32 = manager.audio:GetVoiceLength("story_v_out_104112", "104112027", "story_v_out_104112.awb") / 1000

					if var_113_32 + var_113_24 > arg_110_1.duration_ then
						arg_110_1.duration_ = var_113_32 + var_113_24
					end

					if var_113_27.prefab_name ~= "" and arg_110_1.actors_[var_113_27.prefab_name] ~= nil then
						local var_113_33 = LuaForUtil.PlayVoiceWithCriLipsync(arg_110_1.actors_[var_113_27.prefab_name].transform, "story_v_out_104112", "104112027", "story_v_out_104112.awb")

						arg_110_1:RecordAudio("104112027", var_113_33)
						arg_110_1:RecordAudio("104112027", var_113_33)
					else
						arg_110_1:AudioAction("play", "voice", "story_v_out_104112", "104112027", "story_v_out_104112.awb")
					end

					arg_110_1:RecordHistoryTalkVoice("story_v_out_104112", "104112027", "story_v_out_104112.awb")
				end

				arg_110_1:RecordContent(arg_110_1.text_.text)
			end

			local var_113_34 = math.max(var_113_25, arg_110_1.talkMaxDuration)

			if var_113_24 <= arg_110_1.time_ and arg_110_1.time_ < var_113_24 + var_113_34 then
				arg_110_1.typewritter.percent = (arg_110_1.time_ - var_113_24) / var_113_34

				arg_110_1.typewritter:SetDirty()
			end

			if arg_110_1.time_ >= var_113_24 + var_113_34 and arg_110_1.time_ < var_113_24 + var_113_34 + arg_113_0 then
				arg_110_1.typewritter.percent = 1

				arg_110_1.typewritter:SetDirty()
				arg_110_1:ShowNextGo(true)
			end
		end

		arg_110_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "4010ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.033,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_110_1:InitPlayNodeList()
	end,
	Play104112028 = function(arg_114_0, arg_114_1)
		arg_114_1.time_ = 0
		arg_114_1.frameCnt_ = 0
		arg_114_1.state_ = "playing"
		arg_114_1.curTalkId_ = 104112028
		arg_114_1.duration_ = 5

		SetActive(arg_114_1.tipsGo_, false)

		function arg_114_1.onSingleLineFinish_()
			arg_114_1.onSingleLineUpdate_ = nil
			arg_114_1.onSingleLineFinish_ = nil
			arg_114_1.state_ = "waiting"
		end

		function arg_114_1.playNext_(arg_116_0)
			if arg_116_0 == 1 then
				arg_114_0:Play104112029(arg_114_1)
			end
		end

		function arg_114_1.onSingleLineUpdate_(arg_117_0)
			local var_117_0 = arg_114_1.actors_["2020_tpose"]
			local var_117_1 = 0

			if var_117_1 < arg_114_1.time_ and arg_114_1.time_ <= var_117_1 + arg_117_0 and not isNil(var_117_0) and arg_114_1.var_.characterEffect2020_tpose == nil then
				arg_114_1.var_.characterEffect2020_tpose = var_117_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_117_2 = 0.1

			if var_117_1 <= arg_114_1.time_ and arg_114_1.time_ < var_117_1 + var_117_2 and not isNil(var_117_0) then
				local var_117_3 = (arg_114_1.time_ - var_117_1) / var_117_2

				if arg_114_1.var_.characterEffect2020_tpose and not isNil(var_117_0) then
					local var_117_4 = Mathf.Lerp(0, 0.5, var_117_3)

					arg_114_1.var_.characterEffect2020_tpose.fillFlat = true
					arg_114_1.var_.characterEffect2020_tpose.fillRatio = var_117_4
				end
			end

			if arg_114_1.time_ >= var_117_1 + var_117_2 and arg_114_1.time_ < var_117_1 + var_117_2 + arg_117_0 and not isNil(var_117_0) and arg_114_1.var_.characterEffect2020_tpose then
				local var_117_5 = 0.5

				arg_114_1.var_.characterEffect2020_tpose.fillFlat = true
				arg_114_1.var_.characterEffect2020_tpose.fillRatio = var_117_5
			end

			local var_117_6 = arg_114_1.actors_["4010ui_story"].transform
			local var_117_7 = 0

			if var_117_7 < arg_114_1.time_ and arg_114_1.time_ <= var_117_7 + arg_117_0 then
				arg_114_1.var_.moveOldPos4010ui_story = var_117_6.localPosition
			end

			local var_117_8 = 0.001

			if var_117_7 <= arg_114_1.time_ and arg_114_1.time_ < var_117_7 + var_117_8 then
				local var_117_9 = (arg_114_1.time_ - var_117_7) / var_117_8
				local var_117_10 = Vector3.New(0, 100, 0)

				var_117_6.localPosition = Vector3.Lerp(arg_114_1.var_.moveOldPos4010ui_story, var_117_10, var_117_9)

				local var_117_11 = manager.ui.mainCamera.transform.position - var_117_6.position

				var_117_6.forward = Vector3.New(var_117_11.x, var_117_11.y, var_117_11.z)

				local var_117_12 = var_117_6.localEulerAngles

				var_117_12.z = 0
				var_117_12.x = 0
				var_117_6.localEulerAngles = var_117_12
			end

			if arg_114_1.time_ >= var_117_7 + var_117_8 and arg_114_1.time_ < var_117_7 + var_117_8 + arg_117_0 then
				var_117_6.localPosition = Vector3.New(0, 100, 0)

				local var_117_13 = manager.ui.mainCamera.transform.position - var_117_6.position

				var_117_6.forward = Vector3.New(var_117_13.x, var_117_13.y, var_117_13.z)

				local var_117_14 = var_117_6.localEulerAngles

				var_117_14.z = 0
				var_117_14.x = 0
				var_117_6.localEulerAngles = var_117_14
			end

			local var_117_15 = 0
			local var_117_16 = 0.225

			if var_117_15 < arg_114_1.time_ and arg_114_1.time_ <= var_117_15 + arg_117_0 then
				arg_114_1.talkMaxDuration = 0
				arg_114_1.dialogCg_.alpha = 1

				arg_114_1.dialog_:SetActive(true)
				SetActive(arg_114_1.leftNameGo_, false)

				arg_114_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_114_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_114_1:RecordName(arg_114_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_114_1.iconTrs_.gameObject, false)
				arg_114_1.callingController_:SetSelectedState("normal")

				local var_117_17 = arg_114_1:GetWordFromCfg(104112028)
				local var_117_18 = arg_114_1:FormatText(var_117_17.content)

				arg_114_1.text_.text = var_117_18

				LuaForUtil.ClearLinePrefixSymbol(arg_114_1.text_)

				local var_117_19 = 9
				local var_117_20 = utf8.len(var_117_18)
				local var_117_21 = var_117_19 <= 0 and var_117_16 or var_117_16 * (var_117_20 / var_117_19)

				if var_117_21 > 0 and var_117_16 < var_117_21 then
					arg_114_1.talkMaxDuration = var_117_21

					if var_117_21 + var_117_15 > arg_114_1.duration_ then
						arg_114_1.duration_ = var_117_21 + var_117_15
					end
				end

				arg_114_1.text_.text = var_117_18
				arg_114_1.typewritter.percent = 0

				arg_114_1.typewritter:SetDirty()
				arg_114_1:ShowNextGo(false)
				arg_114_1:RecordContent(arg_114_1.text_.text)
			end

			local var_117_22 = math.max(var_117_16, arg_114_1.talkMaxDuration)

			if var_117_15 <= arg_114_1.time_ and arg_114_1.time_ < var_117_15 + var_117_22 then
				arg_114_1.typewritter.percent = (arg_114_1.time_ - var_117_15) / var_117_22

				arg_114_1.typewritter:SetDirty()
			end

			if arg_114_1.time_ >= var_117_15 + var_117_22 and arg_114_1.time_ < var_117_15 + var_117_22 + arg_117_0 then
				arg_114_1.typewritter.percent = 1

				arg_114_1.typewritter:SetDirty()
				arg_114_1:ShowNextGo(true)
			end
		end

		arg_114_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "4010ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.033,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_114_1:InitPlayNodeList()
	end,
	Play104112029 = function(arg_118_0, arg_118_1)
		arg_118_1.time_ = 0
		arg_118_1.frameCnt_ = 0
		arg_118_1.state_ = "playing"
		arg_118_1.curTalkId_ = 104112029
		arg_118_1.duration_ = 3.83

		local var_118_0 = {
			ja = 3.833,
			ko = 3.433,
			zh = 2.633,
			en = 3.066
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
				arg_118_0:Play104112030(arg_118_1)
			end
		end

		function arg_118_1.onSingleLineUpdate_(arg_121_0)
			local var_121_0 = "2030_tpose"

			if arg_118_1.actors_[var_121_0] == nil then
				local var_121_1 = Asset.Load("Char/" .. "2030_tpose")

				if not isNil(var_121_1) then
					local var_121_2 = Object.Instantiate(Asset.Load("Char/" .. "2030_tpose"), arg_118_1.stage_.transform)

					var_121_2.name = var_121_0
					var_121_2.transform.localPosition = Vector3.New(0, 100, 0)
					arg_118_1.actors_[var_121_0] = var_121_2

					local var_121_3 = var_121_2:GetComponentInChildren(typeof(CharacterEffect))

					var_121_3.enabled = true

					local var_121_4 = GameObjectTools.GetOrAddComponent(var_121_2, typeof(DynamicBoneHelper))

					if var_121_4 then
						var_121_4:EnableDynamicBone(false)
					end

					arg_118_1:ShowWeapon(var_121_3.transform, false)

					arg_118_1.var_[var_121_0 .. "Animator"] = var_121_3.gameObject:GetComponent(typeof(UnityEngine.Animator))
					arg_118_1.var_[var_121_0 .. "Animator"].applyRootMotion = true
					arg_118_1.var_[var_121_0 .. "LipSync"] = var_121_3.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
				end
			end

			local var_121_5 = arg_118_1.actors_["2030_tpose"]
			local var_121_6 = 0

			if var_121_6 < arg_118_1.time_ and arg_118_1.time_ <= var_121_6 + arg_121_0 and not isNil(var_121_5) and arg_118_1.var_.characterEffect2030_tpose == nil then
				arg_118_1.var_.characterEffect2030_tpose = var_121_5:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_121_7 = 0.1

			if var_121_6 <= arg_118_1.time_ and arg_118_1.time_ < var_121_6 + var_121_7 and not isNil(var_121_5) then
				local var_121_8 = (arg_118_1.time_ - var_121_6) / var_121_7

				if arg_118_1.var_.characterEffect2030_tpose and not isNil(var_121_5) then
					arg_118_1.var_.characterEffect2030_tpose.fillFlat = false
				end
			end

			if arg_118_1.time_ >= var_121_6 + var_121_7 and arg_118_1.time_ < var_121_6 + var_121_7 + arg_121_0 and not isNil(var_121_5) and arg_118_1.var_.characterEffect2030_tpose then
				arg_118_1.var_.characterEffect2030_tpose.fillFlat = false
			end

			local var_121_9 = arg_118_1.actors_["2030_tpose"].transform
			local var_121_10 = 0

			if var_121_10 < arg_118_1.time_ and arg_118_1.time_ <= var_121_10 + arg_121_0 then
				arg_118_1.var_.moveOldPos2030_tpose = var_121_9.localPosition

				local var_121_11 = GameObjectTools.GetOrAddComponent(var_121_9.gameObject, typeof(DynamicBoneHelper))

				if var_121_11 then
					var_121_11:EnableDynamicBone(false)
				end
			end

			local var_121_12 = 0.001

			if var_121_10 <= arg_118_1.time_ and arg_118_1.time_ < var_121_10 + var_121_12 then
				local var_121_13 = (arg_118_1.time_ - var_121_10) / var_121_12
				local var_121_14 = Vector3.New(0, 100, 0)

				var_121_9.localPosition = Vector3.Lerp(arg_118_1.var_.moveOldPos2030_tpose, var_121_14, var_121_13)

				local var_121_15 = manager.ui.mainCamera.transform.position - var_121_9.position

				var_121_9.forward = Vector3.New(var_121_15.x, var_121_15.y, var_121_15.z)

				local var_121_16 = var_121_9.localEulerAngles

				var_121_16.z = 0
				var_121_16.x = 0
				var_121_9.localEulerAngles = var_121_16
			end

			if arg_118_1.time_ >= var_121_10 + var_121_12 and arg_118_1.time_ < var_121_10 + var_121_12 + arg_121_0 then
				var_121_9.localPosition = Vector3.New(0, 100, 0)

				local var_121_17 = manager.ui.mainCamera.transform.position - var_121_9.position

				var_121_9.forward = Vector3.New(var_121_17.x, var_121_17.y, var_121_17.z)

				local var_121_18 = var_121_9.localEulerAngles

				var_121_18.z = 0
				var_121_18.x = 0
				var_121_9.localEulerAngles = var_121_18

				local var_121_19 = GameObjectTools.GetOrAddComponent(var_121_9.gameObject, typeof(DynamicBoneHelper))

				if var_121_19 then
					var_121_19:EnableDynamicBone(true)
				end
			end

			local var_121_20 = 0

			if var_121_20 < arg_118_1.time_ and arg_118_1.time_ <= var_121_20 + arg_121_0 then
				arg_118_1:PlayTimeline("2030_tpose", "StoryTimeline/CharAction/story2030/story2030action/2030action1_1")
			end

			local var_121_21 = 0
			local var_121_22 = 0.325

			if var_121_21 < arg_118_1.time_ and arg_118_1.time_ <= var_121_21 + arg_121_0 then
				arg_118_1.talkMaxDuration = 0
				arg_118_1.dialogCg_.alpha = 1

				arg_118_1.dialog_:SetActive(true)
				SetActive(arg_118_1.leftNameGo_, true)

				local var_121_23 = arg_118_1:FormatText(StoryNameCfg[33].name)

				arg_118_1.leftNameTxt_.text = var_121_23

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_118_1.leftNameTxt_.transform)

				arg_118_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_118_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_118_1:RecordName(arg_118_1.leftNameTxt_.text)
				SetActive(arg_118_1.iconTrs_.gameObject, false)
				arg_118_1.callingController_:SetSelectedState("normal")

				local var_121_24 = arg_118_1:GetWordFromCfg(104112029)
				local var_121_25 = arg_118_1:FormatText(var_121_24.content)

				arg_118_1.text_.text = var_121_25

				LuaForUtil.ClearLinePrefixSymbol(arg_118_1.text_)

				local var_121_26 = 13
				local var_121_27 = utf8.len(var_121_25)
				local var_121_28 = var_121_26 <= 0 and var_121_22 or var_121_22 * (var_121_27 / var_121_26)

				if var_121_28 > 0 and var_121_22 < var_121_28 then
					arg_118_1.talkMaxDuration = var_121_28

					if var_121_28 + var_121_21 > arg_118_1.duration_ then
						arg_118_1.duration_ = var_121_28 + var_121_21
					end
				end

				arg_118_1.text_.text = var_121_25
				arg_118_1.typewritter.percent = 0

				arg_118_1.typewritter:SetDirty()
				arg_118_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_104112", "104112029", "story_v_out_104112.awb") ~= 0 then
					local var_121_29 = manager.audio:GetVoiceLength("story_v_out_104112", "104112029", "story_v_out_104112.awb") / 1000

					if var_121_29 + var_121_21 > arg_118_1.duration_ then
						arg_118_1.duration_ = var_121_29 + var_121_21
					end

					if var_121_24.prefab_name ~= "" and arg_118_1.actors_[var_121_24.prefab_name] ~= nil then
						local var_121_30 = LuaForUtil.PlayVoiceWithCriLipsync(arg_118_1.actors_[var_121_24.prefab_name].transform, "story_v_out_104112", "104112029", "story_v_out_104112.awb")

						arg_118_1:RecordAudio("104112029", var_121_30)
						arg_118_1:RecordAudio("104112029", var_121_30)
					else
						arg_118_1:AudioAction("play", "voice", "story_v_out_104112", "104112029", "story_v_out_104112.awb")
					end

					arg_118_1:RecordHistoryTalkVoice("story_v_out_104112", "104112029", "story_v_out_104112.awb")
				end

				arg_118_1:RecordContent(arg_118_1.text_.text)
			end

			local var_121_31 = math.max(var_121_22, arg_118_1.talkMaxDuration)

			if var_121_21 <= arg_118_1.time_ and arg_118_1.time_ < var_121_21 + var_121_31 then
				arg_118_1.typewritter.percent = (arg_118_1.time_ - var_121_21) / var_121_31

				arg_118_1.typewritter:SetDirty()
			end

			if arg_118_1.time_ >= var_121_21 + var_121_31 and arg_118_1.time_ < var_121_21 + var_121_31 + arg_121_0 then
				arg_118_1.typewritter.percent = 1

				arg_118_1.typewritter:SetDirty()
				arg_118_1:ShowNextGo(true)
			end
		end

		arg_118_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "2030_tpose",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.033,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_118_1:InitPlayNodeList()
	end,
	Play104112030 = function(arg_122_0, arg_122_1)
		arg_122_1.time_ = 0
		arg_122_1.frameCnt_ = 0
		arg_122_1.state_ = "playing"
		arg_122_1.curTalkId_ = 104112030
		arg_122_1.duration_ = 7.33

		local var_122_0 = {
			ja = 7.333,
			ko = 2.766,
			zh = 2.6,
			en = 3
		}
		local var_122_1 = manager.audio:GetLocalizationFlag()

		if var_122_0[var_122_1] ~= nil then
			arg_122_1.duration_ = var_122_0[var_122_1]
		end

		SetActive(arg_122_1.tipsGo_, false)

		function arg_122_1.onSingleLineFinish_()
			arg_122_1.onSingleLineUpdate_ = nil
			arg_122_1.onSingleLineFinish_ = nil
			arg_122_1.state_ = "waiting"
		end

		function arg_122_1.playNext_(arg_124_0)
			if arg_124_0 == 1 then
				arg_122_0:Play104112031(arg_122_1)
			end
		end

		function arg_122_1.onSingleLineUpdate_(arg_125_0)
			local var_125_0 = arg_122_1.actors_["2020_tpose"]
			local var_125_1 = 0

			if var_125_1 < arg_122_1.time_ and arg_122_1.time_ <= var_125_1 + arg_125_0 and not isNil(var_125_0) and arg_122_1.var_.characterEffect2020_tpose == nil then
				arg_122_1.var_.characterEffect2020_tpose = var_125_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_125_2 = 0.1

			if var_125_1 <= arg_122_1.time_ and arg_122_1.time_ < var_125_1 + var_125_2 and not isNil(var_125_0) then
				local var_125_3 = (arg_122_1.time_ - var_125_1) / var_125_2

				if arg_122_1.var_.characterEffect2020_tpose and not isNil(var_125_0) then
					arg_122_1.var_.characterEffect2020_tpose.fillFlat = false
				end
			end

			if arg_122_1.time_ >= var_125_1 + var_125_2 and arg_122_1.time_ < var_125_1 + var_125_2 + arg_125_0 and not isNil(var_125_0) and arg_122_1.var_.characterEffect2020_tpose then
				arg_122_1.var_.characterEffect2020_tpose.fillFlat = false
			end

			local var_125_4 = arg_122_1.actors_["2030_tpose"]
			local var_125_5 = 0

			if var_125_5 < arg_122_1.time_ and arg_122_1.time_ <= var_125_5 + arg_125_0 and not isNil(var_125_4) and arg_122_1.var_.characterEffect2030_tpose == nil then
				arg_122_1.var_.characterEffect2030_tpose = var_125_4:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_125_6 = 0.1

			if var_125_5 <= arg_122_1.time_ and arg_122_1.time_ < var_125_5 + var_125_6 and not isNil(var_125_4) then
				local var_125_7 = (arg_122_1.time_ - var_125_5) / var_125_6

				if arg_122_1.var_.characterEffect2030_tpose and not isNil(var_125_4) then
					local var_125_8 = Mathf.Lerp(0, 0.5, var_125_7)

					arg_122_1.var_.characterEffect2030_tpose.fillFlat = true
					arg_122_1.var_.characterEffect2030_tpose.fillRatio = var_125_8
				end
			end

			if arg_122_1.time_ >= var_125_5 + var_125_6 and arg_122_1.time_ < var_125_5 + var_125_6 + arg_125_0 and not isNil(var_125_4) and arg_122_1.var_.characterEffect2030_tpose then
				local var_125_9 = 0.5

				arg_122_1.var_.characterEffect2030_tpose.fillFlat = true
				arg_122_1.var_.characterEffect2030_tpose.fillRatio = var_125_9
			end

			local var_125_10 = arg_122_1.actors_["2020_tpose"].transform
			local var_125_11 = 0

			if var_125_11 < arg_122_1.time_ and arg_122_1.time_ <= var_125_11 + arg_125_0 then
				arg_122_1.var_.moveOldPos2020_tpose = var_125_10.localPosition

				local var_125_12 = GameObjectTools.GetOrAddComponent(var_125_10.gameObject, typeof(DynamicBoneHelper))

				if var_125_12 then
					var_125_12:EnableDynamicBone(false)
				end
			end

			local var_125_13 = 0.001

			if var_125_11 <= arg_122_1.time_ and arg_122_1.time_ < var_125_11 + var_125_13 then
				local var_125_14 = (arg_122_1.time_ - var_125_11) / var_125_13
				local var_125_15 = Vector3.New(0.7, -1.2, -4.1)

				var_125_10.localPosition = Vector3.Lerp(arg_122_1.var_.moveOldPos2020_tpose, var_125_15, var_125_14)

				local var_125_16 = manager.ui.mainCamera.transform.position - var_125_10.position

				var_125_10.forward = Vector3.New(var_125_16.x, var_125_16.y, var_125_16.z)

				local var_125_17 = var_125_10.localEulerAngles

				var_125_17.z = 0
				var_125_17.x = 0
				var_125_10.localEulerAngles = var_125_17
			end

			if arg_122_1.time_ >= var_125_11 + var_125_13 and arg_122_1.time_ < var_125_11 + var_125_13 + arg_125_0 then
				var_125_10.localPosition = Vector3.New(0.7, -1.2, -4.1)

				local var_125_18 = manager.ui.mainCamera.transform.position - var_125_10.position

				var_125_10.forward = Vector3.New(var_125_18.x, var_125_18.y, var_125_18.z)

				local var_125_19 = var_125_10.localEulerAngles

				var_125_19.z = 0
				var_125_19.x = 0
				var_125_10.localEulerAngles = var_125_19

				local var_125_20 = GameObjectTools.GetOrAddComponent(var_125_10.gameObject, typeof(DynamicBoneHelper))

				if var_125_20 then
					var_125_20:EnableDynamicBone(true)
				end
			end

			local var_125_21 = 0

			if var_125_21 < arg_122_1.time_ and arg_122_1.time_ <= var_125_21 + arg_125_0 then
				arg_122_1:PlayTimeline("2020_tpose", "StoryTimeline/CharAction/story2020/story2020action/2020action1_1")
			end

			local var_125_22 = 0
			local var_125_23 = 0.3

			if var_125_22 < arg_122_1.time_ and arg_122_1.time_ <= var_125_22 + arg_125_0 then
				arg_122_1.talkMaxDuration = 0
				arg_122_1.dialogCg_.alpha = 1

				arg_122_1.dialog_:SetActive(true)
				SetActive(arg_122_1.leftNameGo_, true)

				local var_125_24 = arg_122_1:FormatText(StoryNameCfg[65].name)

				arg_122_1.leftNameTxt_.text = var_125_24

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_122_1.leftNameTxt_.transform)

				arg_122_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_122_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_122_1:RecordName(arg_122_1.leftNameTxt_.text)
				SetActive(arg_122_1.iconTrs_.gameObject, false)
				arg_122_1.callingController_:SetSelectedState("normal")

				local var_125_25 = arg_122_1:GetWordFromCfg(104112030)
				local var_125_26 = arg_122_1:FormatText(var_125_25.content)

				arg_122_1.text_.text = var_125_26

				LuaForUtil.ClearLinePrefixSymbol(arg_122_1.text_)

				local var_125_27 = 12
				local var_125_28 = utf8.len(var_125_26)
				local var_125_29 = var_125_27 <= 0 and var_125_23 or var_125_23 * (var_125_28 / var_125_27)

				if var_125_29 > 0 and var_125_23 < var_125_29 then
					arg_122_1.talkMaxDuration = var_125_29

					if var_125_29 + var_125_22 > arg_122_1.duration_ then
						arg_122_1.duration_ = var_125_29 + var_125_22
					end
				end

				arg_122_1.text_.text = var_125_26
				arg_122_1.typewritter.percent = 0

				arg_122_1.typewritter:SetDirty()
				arg_122_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_104112", "104112030", "story_v_out_104112.awb") ~= 0 then
					local var_125_30 = manager.audio:GetVoiceLength("story_v_out_104112", "104112030", "story_v_out_104112.awb") / 1000

					if var_125_30 + var_125_22 > arg_122_1.duration_ then
						arg_122_1.duration_ = var_125_30 + var_125_22
					end

					if var_125_25.prefab_name ~= "" and arg_122_1.actors_[var_125_25.prefab_name] ~= nil then
						local var_125_31 = LuaForUtil.PlayVoiceWithCriLipsync(arg_122_1.actors_[var_125_25.prefab_name].transform, "story_v_out_104112", "104112030", "story_v_out_104112.awb")

						arg_122_1:RecordAudio("104112030", var_125_31)
						arg_122_1:RecordAudio("104112030", var_125_31)
					else
						arg_122_1:AudioAction("play", "voice", "story_v_out_104112", "104112030", "story_v_out_104112.awb")
					end

					arg_122_1:RecordHistoryTalkVoice("story_v_out_104112", "104112030", "story_v_out_104112.awb")
				end

				arg_122_1:RecordContent(arg_122_1.text_.text)
			end

			local var_125_32 = math.max(var_125_23, arg_122_1.talkMaxDuration)

			if var_125_22 <= arg_122_1.time_ and arg_122_1.time_ < var_125_22 + var_125_32 then
				arg_122_1.typewritter.percent = (arg_122_1.time_ - var_125_22) / var_125_32

				arg_122_1.typewritter:SetDirty()
			end

			if arg_122_1.time_ >= var_125_22 + var_125_32 and arg_122_1.time_ < var_125_22 + var_125_32 + arg_125_0 then
				arg_122_1.typewritter.percent = 1

				arg_122_1.typewritter:SetDirty()
				arg_122_1:ShowNextGo(true)
			end
		end

		arg_122_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "2020_tpose",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.033,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_122_1:InitPlayNodeList()
	end,
	Play104112031 = function(arg_126_0, arg_126_1)
		arg_126_1.time_ = 0
		arg_126_1.frameCnt_ = 0
		arg_126_1.state_ = "playing"
		arg_126_1.curTalkId_ = 104112031
		arg_126_1.duration_ = 6.17

		local var_126_0 = {
			ja = 4.366,
			ko = 4.9,
			zh = 6.166,
			en = 5.533
		}
		local var_126_1 = manager.audio:GetLocalizationFlag()

		if var_126_0[var_126_1] ~= nil then
			arg_126_1.duration_ = var_126_0[var_126_1]
		end

		SetActive(arg_126_1.tipsGo_, false)

		function arg_126_1.onSingleLineFinish_()
			arg_126_1.onSingleLineUpdate_ = nil
			arg_126_1.onSingleLineFinish_ = nil
			arg_126_1.state_ = "waiting"
		end

		function arg_126_1.playNext_(arg_128_0)
			if arg_128_0 == 1 then
				arg_126_0:Play104112032(arg_126_1)
			end
		end

		function arg_126_1.onSingleLineUpdate_(arg_129_0)
			local var_129_0 = arg_126_1.actors_["4010ui_story"]
			local var_129_1 = 0

			if var_129_1 < arg_126_1.time_ and arg_126_1.time_ <= var_129_1 + arg_129_0 and not isNil(var_129_0) and arg_126_1.var_.characterEffect4010ui_story == nil then
				arg_126_1.var_.characterEffect4010ui_story = var_129_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_129_2 = 0.1

			if var_129_1 <= arg_126_1.time_ and arg_126_1.time_ < var_129_1 + var_129_2 and not isNil(var_129_0) then
				local var_129_3 = (arg_126_1.time_ - var_129_1) / var_129_2

				if arg_126_1.var_.characterEffect4010ui_story and not isNil(var_129_0) then
					arg_126_1.var_.characterEffect4010ui_story.fillFlat = false
				end
			end

			if arg_126_1.time_ >= var_129_1 + var_129_2 and arg_126_1.time_ < var_129_1 + var_129_2 + arg_129_0 and not isNil(var_129_0) and arg_126_1.var_.characterEffect4010ui_story then
				arg_126_1.var_.characterEffect4010ui_story.fillFlat = false
			end

			local var_129_4 = arg_126_1.actors_["2020_tpose"]
			local var_129_5 = 0

			if var_129_5 < arg_126_1.time_ and arg_126_1.time_ <= var_129_5 + arg_129_0 and not isNil(var_129_4) and arg_126_1.var_.characterEffect2020_tpose == nil then
				arg_126_1.var_.characterEffect2020_tpose = var_129_4:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_129_6 = 0.1

			if var_129_5 <= arg_126_1.time_ and arg_126_1.time_ < var_129_5 + var_129_6 and not isNil(var_129_4) then
				local var_129_7 = (arg_126_1.time_ - var_129_5) / var_129_6

				if arg_126_1.var_.characterEffect2020_tpose and not isNil(var_129_4) then
					local var_129_8 = Mathf.Lerp(0, 0.5, var_129_7)

					arg_126_1.var_.characterEffect2020_tpose.fillFlat = true
					arg_126_1.var_.characterEffect2020_tpose.fillRatio = var_129_8
				end
			end

			if arg_126_1.time_ >= var_129_5 + var_129_6 and arg_126_1.time_ < var_129_5 + var_129_6 + arg_129_0 and not isNil(var_129_4) and arg_126_1.var_.characterEffect2020_tpose then
				local var_129_9 = 0.5

				arg_126_1.var_.characterEffect2020_tpose.fillFlat = true
				arg_126_1.var_.characterEffect2020_tpose.fillRatio = var_129_9
			end

			local var_129_10 = arg_126_1.actors_["2020_tpose"].transform
			local var_129_11 = 0

			if var_129_11 < arg_126_1.time_ and arg_126_1.time_ <= var_129_11 + arg_129_0 then
				arg_126_1.var_.moveOldPos2020_tpose = var_129_10.localPosition

				local var_129_12 = GameObjectTools.GetOrAddComponent(var_129_10.gameObject, typeof(DynamicBoneHelper))

				if var_129_12 then
					var_129_12:EnableDynamicBone(false)
				end
			end

			local var_129_13 = 0.001

			if var_129_11 <= arg_126_1.time_ and arg_126_1.time_ < var_129_11 + var_129_13 then
				local var_129_14 = (arg_126_1.time_ - var_129_11) / var_129_13
				local var_129_15 = Vector3.New(0, 100, 0)

				var_129_10.localPosition = Vector3.Lerp(arg_126_1.var_.moveOldPos2020_tpose, var_129_15, var_129_14)

				local var_129_16 = manager.ui.mainCamera.transform.position - var_129_10.position

				var_129_10.forward = Vector3.New(var_129_16.x, var_129_16.y, var_129_16.z)

				local var_129_17 = var_129_10.localEulerAngles

				var_129_17.z = 0
				var_129_17.x = 0
				var_129_10.localEulerAngles = var_129_17
			end

			if arg_126_1.time_ >= var_129_11 + var_129_13 and arg_126_1.time_ < var_129_11 + var_129_13 + arg_129_0 then
				var_129_10.localPosition = Vector3.New(0, 100, 0)

				local var_129_18 = manager.ui.mainCamera.transform.position - var_129_10.position

				var_129_10.forward = Vector3.New(var_129_18.x, var_129_18.y, var_129_18.z)

				local var_129_19 = var_129_10.localEulerAngles

				var_129_19.z = 0
				var_129_19.x = 0
				var_129_10.localEulerAngles = var_129_19

				local var_129_20 = GameObjectTools.GetOrAddComponent(var_129_10.gameObject, typeof(DynamicBoneHelper))

				if var_129_20 then
					var_129_20:EnableDynamicBone(true)
				end
			end

			local var_129_21 = arg_126_1.actors_["2030_tpose"].transform
			local var_129_22 = 0

			if var_129_22 < arg_126_1.time_ and arg_126_1.time_ <= var_129_22 + arg_129_0 then
				arg_126_1.var_.moveOldPos2030_tpose = var_129_21.localPosition

				local var_129_23 = GameObjectTools.GetOrAddComponent(var_129_21.gameObject, typeof(DynamicBoneHelper))

				if var_129_23 then
					var_129_23:EnableDynamicBone(false)
				end
			end

			local var_129_24 = 0.001

			if var_129_22 <= arg_126_1.time_ and arg_126_1.time_ < var_129_22 + var_129_24 then
				local var_129_25 = (arg_126_1.time_ - var_129_22) / var_129_24
				local var_129_26 = Vector3.New(0, 100, 0)

				var_129_21.localPosition = Vector3.Lerp(arg_126_1.var_.moveOldPos2030_tpose, var_129_26, var_129_25)

				local var_129_27 = manager.ui.mainCamera.transform.position - var_129_21.position

				var_129_21.forward = Vector3.New(var_129_27.x, var_129_27.y, var_129_27.z)

				local var_129_28 = var_129_21.localEulerAngles

				var_129_28.z = 0
				var_129_28.x = 0
				var_129_21.localEulerAngles = var_129_28
			end

			if arg_126_1.time_ >= var_129_22 + var_129_24 and arg_126_1.time_ < var_129_22 + var_129_24 + arg_129_0 then
				var_129_21.localPosition = Vector3.New(0, 100, 0)

				local var_129_29 = manager.ui.mainCamera.transform.position - var_129_21.position

				var_129_21.forward = Vector3.New(var_129_29.x, var_129_29.y, var_129_29.z)

				local var_129_30 = var_129_21.localEulerAngles

				var_129_30.z = 0
				var_129_30.x = 0
				var_129_21.localEulerAngles = var_129_30

				local var_129_31 = GameObjectTools.GetOrAddComponent(var_129_21.gameObject, typeof(DynamicBoneHelper))

				if var_129_31 then
					var_129_31:EnableDynamicBone(true)
				end
			end

			local var_129_32 = arg_126_1.actors_["4010ui_story"].transform
			local var_129_33 = 0

			if var_129_33 < arg_126_1.time_ and arg_126_1.time_ <= var_129_33 + arg_129_0 then
				arg_126_1.var_.moveOldPos4010ui_story = var_129_32.localPosition
			end

			local var_129_34 = 0.001

			if var_129_33 <= arg_126_1.time_ and arg_126_1.time_ < var_129_33 + var_129_34 then
				local var_129_35 = (arg_126_1.time_ - var_129_33) / var_129_34
				local var_129_36 = Vector3.New(0, -1.59, -5.2)

				var_129_32.localPosition = Vector3.Lerp(arg_126_1.var_.moveOldPos4010ui_story, var_129_36, var_129_35)

				local var_129_37 = manager.ui.mainCamera.transform.position - var_129_32.position

				var_129_32.forward = Vector3.New(var_129_37.x, var_129_37.y, var_129_37.z)

				local var_129_38 = var_129_32.localEulerAngles

				var_129_38.z = 0
				var_129_38.x = 0
				var_129_32.localEulerAngles = var_129_38
			end

			if arg_126_1.time_ >= var_129_33 + var_129_34 and arg_126_1.time_ < var_129_33 + var_129_34 + arg_129_0 then
				var_129_32.localPosition = Vector3.New(0, -1.59, -5.2)

				local var_129_39 = manager.ui.mainCamera.transform.position - var_129_32.position

				var_129_32.forward = Vector3.New(var_129_39.x, var_129_39.y, var_129_39.z)

				local var_129_40 = var_129_32.localEulerAngles

				var_129_40.z = 0
				var_129_40.x = 0
				var_129_32.localEulerAngles = var_129_40
			end

			local var_129_41 = 0

			if var_129_41 < arg_126_1.time_ and arg_126_1.time_ <= var_129_41 + arg_129_0 then
				arg_126_1:PlayTimeline("4010ui_story", "StoryTimeline/CharAction/story4010/story4010action/4010action4_1")
			end

			local var_129_42 = 0

			if var_129_42 < arg_126_1.time_ and arg_126_1.time_ <= var_129_42 + arg_129_0 then
				arg_126_1:PlayTimeline("4010ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0104cva")
			end

			local var_129_43 = 0
			local var_129_44 = 0.475

			if var_129_43 < arg_126_1.time_ and arg_126_1.time_ <= var_129_43 + arg_129_0 then
				arg_126_1.talkMaxDuration = 0
				arg_126_1.dialogCg_.alpha = 1

				arg_126_1.dialog_:SetActive(true)
				SetActive(arg_126_1.leftNameGo_, true)

				local var_129_45 = arg_126_1:FormatText(StoryNameCfg[42].name)

				arg_126_1.leftNameTxt_.text = var_129_45

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_126_1.leftNameTxt_.transform)

				arg_126_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_126_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_126_1:RecordName(arg_126_1.leftNameTxt_.text)
				SetActive(arg_126_1.iconTrs_.gameObject, false)
				arg_126_1.callingController_:SetSelectedState("normal")

				local var_129_46 = arg_126_1:GetWordFromCfg(104112031)
				local var_129_47 = arg_126_1:FormatText(var_129_46.content)

				arg_126_1.text_.text = var_129_47

				LuaForUtil.ClearLinePrefixSymbol(arg_126_1.text_)

				local var_129_48 = 19
				local var_129_49 = utf8.len(var_129_47)
				local var_129_50 = var_129_48 <= 0 and var_129_44 or var_129_44 * (var_129_49 / var_129_48)

				if var_129_50 > 0 and var_129_44 < var_129_50 then
					arg_126_1.talkMaxDuration = var_129_50

					if var_129_50 + var_129_43 > arg_126_1.duration_ then
						arg_126_1.duration_ = var_129_50 + var_129_43
					end
				end

				arg_126_1.text_.text = var_129_47
				arg_126_1.typewritter.percent = 0

				arg_126_1.typewritter:SetDirty()
				arg_126_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_104112", "104112031", "story_v_out_104112.awb") ~= 0 then
					local var_129_51 = manager.audio:GetVoiceLength("story_v_out_104112", "104112031", "story_v_out_104112.awb") / 1000

					if var_129_51 + var_129_43 > arg_126_1.duration_ then
						arg_126_1.duration_ = var_129_51 + var_129_43
					end

					if var_129_46.prefab_name ~= "" and arg_126_1.actors_[var_129_46.prefab_name] ~= nil then
						local var_129_52 = LuaForUtil.PlayVoiceWithCriLipsync(arg_126_1.actors_[var_129_46.prefab_name].transform, "story_v_out_104112", "104112031", "story_v_out_104112.awb")

						arg_126_1:RecordAudio("104112031", var_129_52)
						arg_126_1:RecordAudio("104112031", var_129_52)
					else
						arg_126_1:AudioAction("play", "voice", "story_v_out_104112", "104112031", "story_v_out_104112.awb")
					end

					arg_126_1:RecordHistoryTalkVoice("story_v_out_104112", "104112031", "story_v_out_104112.awb")
				end

				arg_126_1:RecordContent(arg_126_1.text_.text)
			end

			local var_129_53 = math.max(var_129_44, arg_126_1.talkMaxDuration)

			if var_129_43 <= arg_126_1.time_ and arg_126_1.time_ < var_129_43 + var_129_53 then
				arg_126_1.typewritter.percent = (arg_126_1.time_ - var_129_43) / var_129_53

				arg_126_1.typewritter:SetDirty()
			end

			if arg_126_1.time_ >= var_129_43 + var_129_53 and arg_126_1.time_ < var_129_43 + var_129_53 + arg_129_0 then
				arg_126_1.typewritter.percent = 1

				arg_126_1.typewritter:SetDirty()
				arg_126_1:ShowNextGo(true)
			end
		end

		arg_126_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "2020_tpose",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.033,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "2030_tpose",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.033,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "4010ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.033,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_126_1:InitPlayNodeList()
	end,
	Play104112032 = function(arg_130_0, arg_130_1)
		arg_130_1.time_ = 0
		arg_130_1.frameCnt_ = 0
		arg_130_1.state_ = "playing"
		arg_130_1.curTalkId_ = 104112032
		arg_130_1.duration_ = 5

		SetActive(arg_130_1.tipsGo_, false)

		function arg_130_1.onSingleLineFinish_()
			arg_130_1.onSingleLineUpdate_ = nil
			arg_130_1.onSingleLineFinish_ = nil
			arg_130_1.state_ = "waiting"
		end

		function arg_130_1.playNext_(arg_132_0)
			if arg_132_0 == 1 then
				arg_130_0:Play104112033(arg_130_1)
			end
		end

		function arg_130_1.onSingleLineUpdate_(arg_133_0)
			local var_133_0 = arg_130_1.actors_["4010ui_story"]
			local var_133_1 = 0

			if var_133_1 < arg_130_1.time_ and arg_130_1.time_ <= var_133_1 + arg_133_0 and not isNil(var_133_0) and arg_130_1.var_.characterEffect4010ui_story == nil then
				arg_130_1.var_.characterEffect4010ui_story = var_133_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_133_2 = 0.1

			if var_133_1 <= arg_130_1.time_ and arg_130_1.time_ < var_133_1 + var_133_2 and not isNil(var_133_0) then
				local var_133_3 = (arg_130_1.time_ - var_133_1) / var_133_2

				if arg_130_1.var_.characterEffect4010ui_story and not isNil(var_133_0) then
					local var_133_4 = Mathf.Lerp(0, 0.5, var_133_3)

					arg_130_1.var_.characterEffect4010ui_story.fillFlat = true
					arg_130_1.var_.characterEffect4010ui_story.fillRatio = var_133_4
				end
			end

			if arg_130_1.time_ >= var_133_1 + var_133_2 and arg_130_1.time_ < var_133_1 + var_133_2 + arg_133_0 and not isNil(var_133_0) and arg_130_1.var_.characterEffect4010ui_story then
				local var_133_5 = 0.5

				arg_130_1.var_.characterEffect4010ui_story.fillFlat = true
				arg_130_1.var_.characterEffect4010ui_story.fillRatio = var_133_5
			end

			local var_133_6 = 0
			local var_133_7 = 0.4

			if var_133_6 < arg_130_1.time_ and arg_130_1.time_ <= var_133_6 + arg_133_0 then
				arg_130_1.talkMaxDuration = 0
				arg_130_1.dialogCg_.alpha = 1

				arg_130_1.dialog_:SetActive(true)
				SetActive(arg_130_1.leftNameGo_, false)

				arg_130_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_130_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_130_1:RecordName(arg_130_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_130_1.iconTrs_.gameObject, false)
				arg_130_1.callingController_:SetSelectedState("normal")

				local var_133_8 = arg_130_1:GetWordFromCfg(104112032)
				local var_133_9 = arg_130_1:FormatText(var_133_8.content)

				arg_130_1.text_.text = var_133_9

				LuaForUtil.ClearLinePrefixSymbol(arg_130_1.text_)

				local var_133_10 = 16
				local var_133_11 = utf8.len(var_133_9)
				local var_133_12 = var_133_10 <= 0 and var_133_7 or var_133_7 * (var_133_11 / var_133_10)

				if var_133_12 > 0 and var_133_7 < var_133_12 then
					arg_130_1.talkMaxDuration = var_133_12

					if var_133_12 + var_133_6 > arg_130_1.duration_ then
						arg_130_1.duration_ = var_133_12 + var_133_6
					end
				end

				arg_130_1.text_.text = var_133_9
				arg_130_1.typewritter.percent = 0

				arg_130_1.typewritter:SetDirty()
				arg_130_1:ShowNextGo(false)
				arg_130_1:RecordContent(arg_130_1.text_.text)
			end

			local var_133_13 = math.max(var_133_7, arg_130_1.talkMaxDuration)

			if var_133_6 <= arg_130_1.time_ and arg_130_1.time_ < var_133_6 + var_133_13 then
				arg_130_1.typewritter.percent = (arg_130_1.time_ - var_133_6) / var_133_13

				arg_130_1.typewritter:SetDirty()
			end

			if arg_130_1.time_ >= var_133_6 + var_133_13 and arg_130_1.time_ < var_133_6 + var_133_13 + arg_133_0 then
				arg_130_1.typewritter.percent = 1

				arg_130_1.typewritter:SetDirty()
				arg_130_1:ShowNextGo(true)
			end
		end

		arg_130_1.nodeConfigList_ = {}

		arg_130_1:InitPlayNodeList()
	end,
	Play104112033 = function(arg_134_0, arg_134_1)
		arg_134_1.time_ = 0
		arg_134_1.frameCnt_ = 0
		arg_134_1.state_ = "playing"
		arg_134_1.curTalkId_ = 104112033
		arg_134_1.duration_ = 18.97

		local var_134_0 = {
			ja = 13.033,
			ko = 12.733,
			zh = 14.5,
			en = 18.966
		}
		local var_134_1 = manager.audio:GetLocalizationFlag()

		if var_134_0[var_134_1] ~= nil then
			arg_134_1.duration_ = var_134_0[var_134_1]
		end

		SetActive(arg_134_1.tipsGo_, false)

		function arg_134_1.onSingleLineFinish_()
			arg_134_1.onSingleLineUpdate_ = nil
			arg_134_1.onSingleLineFinish_ = nil
			arg_134_1.state_ = "waiting"
		end

		function arg_134_1.playNext_(arg_136_0)
			if arg_136_0 == 1 then
				arg_134_0:Play104112034(arg_134_1)
			end
		end

		function arg_134_1.onSingleLineUpdate_(arg_137_0)
			local var_137_0 = arg_134_1.actors_["4010ui_story"]
			local var_137_1 = 0

			if var_137_1 < arg_134_1.time_ and arg_134_1.time_ <= var_137_1 + arg_137_0 and not isNil(var_137_0) and arg_134_1.var_.characterEffect4010ui_story == nil then
				arg_134_1.var_.characterEffect4010ui_story = var_137_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_137_2 = 0.1

			if var_137_1 <= arg_134_1.time_ and arg_134_1.time_ < var_137_1 + var_137_2 and not isNil(var_137_0) then
				local var_137_3 = (arg_134_1.time_ - var_137_1) / var_137_2

				if arg_134_1.var_.characterEffect4010ui_story and not isNil(var_137_0) then
					arg_134_1.var_.characterEffect4010ui_story.fillFlat = false
				end
			end

			if arg_134_1.time_ >= var_137_1 + var_137_2 and arg_134_1.time_ < var_137_1 + var_137_2 + arg_137_0 and not isNil(var_137_0) and arg_134_1.var_.characterEffect4010ui_story then
				arg_134_1.var_.characterEffect4010ui_story.fillFlat = false
			end

			local var_137_4 = 0

			if var_137_4 < arg_134_1.time_ and arg_134_1.time_ <= var_137_4 + arg_137_0 then
				arg_134_1:PlayTimeline("4010ui_story", "StoryTimeline/CharAction/story4010/story4010action/4010action4_2")
			end

			local var_137_5 = 0

			if var_137_5 < arg_134_1.time_ and arg_134_1.time_ <= var_137_5 + arg_137_0 then
				arg_134_1:PlayTimeline("4010ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3104cva")
			end

			local var_137_6 = 0
			local var_137_7 = 1.55

			if var_137_6 < arg_134_1.time_ and arg_134_1.time_ <= var_137_6 + arg_137_0 then
				arg_134_1.talkMaxDuration = 0
				arg_134_1.dialogCg_.alpha = 1

				arg_134_1.dialog_:SetActive(true)
				SetActive(arg_134_1.leftNameGo_, true)

				local var_137_8 = arg_134_1:FormatText(StoryNameCfg[42].name)

				arg_134_1.leftNameTxt_.text = var_137_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_134_1.leftNameTxt_.transform)

				arg_134_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_134_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_134_1:RecordName(arg_134_1.leftNameTxt_.text)
				SetActive(arg_134_1.iconTrs_.gameObject, false)
				arg_134_1.callingController_:SetSelectedState("normal")

				local var_137_9 = arg_134_1:GetWordFromCfg(104112033)
				local var_137_10 = arg_134_1:FormatText(var_137_9.content)

				arg_134_1.text_.text = var_137_10

				LuaForUtil.ClearLinePrefixSymbol(arg_134_1.text_)

				local var_137_11 = 61
				local var_137_12 = utf8.len(var_137_10)
				local var_137_13 = var_137_11 <= 0 and var_137_7 or var_137_7 * (var_137_12 / var_137_11)

				if var_137_13 > 0 and var_137_7 < var_137_13 then
					arg_134_1.talkMaxDuration = var_137_13

					if var_137_13 + var_137_6 > arg_134_1.duration_ then
						arg_134_1.duration_ = var_137_13 + var_137_6
					end
				end

				arg_134_1.text_.text = var_137_10
				arg_134_1.typewritter.percent = 0

				arg_134_1.typewritter:SetDirty()
				arg_134_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_104112", "104112033", "story_v_out_104112.awb") ~= 0 then
					local var_137_14 = manager.audio:GetVoiceLength("story_v_out_104112", "104112033", "story_v_out_104112.awb") / 1000

					if var_137_14 + var_137_6 > arg_134_1.duration_ then
						arg_134_1.duration_ = var_137_14 + var_137_6
					end

					if var_137_9.prefab_name ~= "" and arg_134_1.actors_[var_137_9.prefab_name] ~= nil then
						local var_137_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_134_1.actors_[var_137_9.prefab_name].transform, "story_v_out_104112", "104112033", "story_v_out_104112.awb")

						arg_134_1:RecordAudio("104112033", var_137_15)
						arg_134_1:RecordAudio("104112033", var_137_15)
					else
						arg_134_1:AudioAction("play", "voice", "story_v_out_104112", "104112033", "story_v_out_104112.awb")
					end

					arg_134_1:RecordHistoryTalkVoice("story_v_out_104112", "104112033", "story_v_out_104112.awb")
				end

				arg_134_1:RecordContent(arg_134_1.text_.text)
			end

			local var_137_16 = math.max(var_137_7, arg_134_1.talkMaxDuration)

			if var_137_6 <= arg_134_1.time_ and arg_134_1.time_ < var_137_6 + var_137_16 then
				arg_134_1.typewritter.percent = (arg_134_1.time_ - var_137_6) / var_137_16

				arg_134_1.typewritter:SetDirty()
			end

			if arg_134_1.time_ >= var_137_6 + var_137_16 and arg_134_1.time_ < var_137_6 + var_137_16 + arg_137_0 then
				arg_134_1.typewritter.percent = 1

				arg_134_1.typewritter:SetDirty()
				arg_134_1:ShowNextGo(true)
			end
		end

		arg_134_1.nodeConfigList_ = {}

		arg_134_1:InitPlayNodeList()
	end,
	Play104112034 = function(arg_138_0, arg_138_1)
		arg_138_1.time_ = 0
		arg_138_1.frameCnt_ = 0
		arg_138_1.state_ = "playing"
		arg_138_1.curTalkId_ = 104112034
		arg_138_1.duration_ = 10.73

		local var_138_0 = {
			ja = 10.533,
			ko = 9.066,
			zh = 10.266,
			en = 10.733
		}
		local var_138_1 = manager.audio:GetLocalizationFlag()

		if var_138_0[var_138_1] ~= nil then
			arg_138_1.duration_ = var_138_0[var_138_1]
		end

		SetActive(arg_138_1.tipsGo_, false)

		function arg_138_1.onSingleLineFinish_()
			arg_138_1.onSingleLineUpdate_ = nil
			arg_138_1.onSingleLineFinish_ = nil
			arg_138_1.state_ = "waiting"
		end

		function arg_138_1.playNext_(arg_140_0)
			if arg_140_0 == 1 then
				arg_138_0:Play104112035(arg_138_1)
			end
		end

		function arg_138_1.onSingleLineUpdate_(arg_141_0)
			local var_141_0 = 0

			if var_141_0 < arg_138_1.time_ and arg_138_1.time_ <= var_141_0 + arg_141_0 then
				arg_138_1:PlayTimeline("4010ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3104cva")
			end

			local var_141_1 = 0
			local var_141_2 = 0.975

			if var_141_1 < arg_138_1.time_ and arg_138_1.time_ <= var_141_1 + arg_141_0 then
				arg_138_1.talkMaxDuration = 0
				arg_138_1.dialogCg_.alpha = 1

				arg_138_1.dialog_:SetActive(true)
				SetActive(arg_138_1.leftNameGo_, true)

				local var_141_3 = arg_138_1:FormatText(StoryNameCfg[42].name)

				arg_138_1.leftNameTxt_.text = var_141_3

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_138_1.leftNameTxt_.transform)

				arg_138_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_138_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_138_1:RecordName(arg_138_1.leftNameTxt_.text)
				SetActive(arg_138_1.iconTrs_.gameObject, false)
				arg_138_1.callingController_:SetSelectedState("normal")

				local var_141_4 = arg_138_1:GetWordFromCfg(104112034)
				local var_141_5 = arg_138_1:FormatText(var_141_4.content)

				arg_138_1.text_.text = var_141_5

				LuaForUtil.ClearLinePrefixSymbol(arg_138_1.text_)

				local var_141_6 = 39
				local var_141_7 = utf8.len(var_141_5)
				local var_141_8 = var_141_6 <= 0 and var_141_2 or var_141_2 * (var_141_7 / var_141_6)

				if var_141_8 > 0 and var_141_2 < var_141_8 then
					arg_138_1.talkMaxDuration = var_141_8

					if var_141_8 + var_141_1 > arg_138_1.duration_ then
						arg_138_1.duration_ = var_141_8 + var_141_1
					end
				end

				arg_138_1.text_.text = var_141_5
				arg_138_1.typewritter.percent = 0

				arg_138_1.typewritter:SetDirty()
				arg_138_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_104112", "104112034", "story_v_out_104112.awb") ~= 0 then
					local var_141_9 = manager.audio:GetVoiceLength("story_v_out_104112", "104112034", "story_v_out_104112.awb") / 1000

					if var_141_9 + var_141_1 > arg_138_1.duration_ then
						arg_138_1.duration_ = var_141_9 + var_141_1
					end

					if var_141_4.prefab_name ~= "" and arg_138_1.actors_[var_141_4.prefab_name] ~= nil then
						local var_141_10 = LuaForUtil.PlayVoiceWithCriLipsync(arg_138_1.actors_[var_141_4.prefab_name].transform, "story_v_out_104112", "104112034", "story_v_out_104112.awb")

						arg_138_1:RecordAudio("104112034", var_141_10)
						arg_138_1:RecordAudio("104112034", var_141_10)
					else
						arg_138_1:AudioAction("play", "voice", "story_v_out_104112", "104112034", "story_v_out_104112.awb")
					end

					arg_138_1:RecordHistoryTalkVoice("story_v_out_104112", "104112034", "story_v_out_104112.awb")
				end

				arg_138_1:RecordContent(arg_138_1.text_.text)
			end

			local var_141_11 = math.max(var_141_2, arg_138_1.talkMaxDuration)

			if var_141_1 <= arg_138_1.time_ and arg_138_1.time_ < var_141_1 + var_141_11 then
				arg_138_1.typewritter.percent = (arg_138_1.time_ - var_141_1) / var_141_11

				arg_138_1.typewritter:SetDirty()
			end

			if arg_138_1.time_ >= var_141_1 + var_141_11 and arg_138_1.time_ < var_141_1 + var_141_11 + arg_141_0 then
				arg_138_1.typewritter.percent = 1

				arg_138_1.typewritter:SetDirty()
				arg_138_1:ShowNextGo(true)
			end
		end

		arg_138_1.nodeConfigList_ = {}

		arg_138_1:InitPlayNodeList()
	end,
	Play104112035 = function(arg_142_0, arg_142_1)
		arg_142_1.time_ = 0
		arg_142_1.frameCnt_ = 0
		arg_142_1.state_ = "playing"
		arg_142_1.curTalkId_ = 104112035
		arg_142_1.duration_ = 12.9

		local var_142_0 = {
			ja = 11.8,
			ko = 10.933,
			zh = 12.9,
			en = 11.9
		}
		local var_142_1 = manager.audio:GetLocalizationFlag()

		if var_142_0[var_142_1] ~= nil then
			arg_142_1.duration_ = var_142_0[var_142_1]
		end

		SetActive(arg_142_1.tipsGo_, false)

		function arg_142_1.onSingleLineFinish_()
			arg_142_1.onSingleLineUpdate_ = nil
			arg_142_1.onSingleLineFinish_ = nil
			arg_142_1.state_ = "waiting"
		end

		function arg_142_1.playNext_(arg_144_0)
			if arg_144_0 == 1 then
				arg_142_0:Play104112036(arg_142_1)
			end
		end

		function arg_142_1.onSingleLineUpdate_(arg_145_0)
			local var_145_0 = 0

			if var_145_0 < arg_142_1.time_ and arg_142_1.time_ <= var_145_0 + arg_145_0 then
				arg_142_1:PlayTimeline("4010ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3104cva")
			end

			local var_145_1 = 0

			if var_145_1 < arg_142_1.time_ and arg_142_1.time_ <= var_145_1 + arg_145_0 then
				arg_142_1:PlayTimeline("4010ui_story", "StoryTimeline/CharAction/story4010/story4010action/4010action6_1")
			end

			local var_145_2 = 0
			local var_145_3 = 1.125

			if var_145_2 < arg_142_1.time_ and arg_142_1.time_ <= var_145_2 + arg_145_0 then
				arg_142_1.talkMaxDuration = 0
				arg_142_1.dialogCg_.alpha = 1

				arg_142_1.dialog_:SetActive(true)
				SetActive(arg_142_1.leftNameGo_, true)

				local var_145_4 = arg_142_1:FormatText(StoryNameCfg[42].name)

				arg_142_1.leftNameTxt_.text = var_145_4

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_142_1.leftNameTxt_.transform)

				arg_142_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_142_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_142_1:RecordName(arg_142_1.leftNameTxt_.text)
				SetActive(arg_142_1.iconTrs_.gameObject, false)
				arg_142_1.callingController_:SetSelectedState("normal")

				local var_145_5 = arg_142_1:GetWordFromCfg(104112035)
				local var_145_6 = arg_142_1:FormatText(var_145_5.content)

				arg_142_1.text_.text = var_145_6

				LuaForUtil.ClearLinePrefixSymbol(arg_142_1.text_)

				local var_145_7 = 45
				local var_145_8 = utf8.len(var_145_6)
				local var_145_9 = var_145_7 <= 0 and var_145_3 or var_145_3 * (var_145_8 / var_145_7)

				if var_145_9 > 0 and var_145_3 < var_145_9 then
					arg_142_1.talkMaxDuration = var_145_9

					if var_145_9 + var_145_2 > arg_142_1.duration_ then
						arg_142_1.duration_ = var_145_9 + var_145_2
					end
				end

				arg_142_1.text_.text = var_145_6
				arg_142_1.typewritter.percent = 0

				arg_142_1.typewritter:SetDirty()
				arg_142_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_104112", "104112035", "story_v_out_104112.awb") ~= 0 then
					local var_145_10 = manager.audio:GetVoiceLength("story_v_out_104112", "104112035", "story_v_out_104112.awb") / 1000

					if var_145_10 + var_145_2 > arg_142_1.duration_ then
						arg_142_1.duration_ = var_145_10 + var_145_2
					end

					if var_145_5.prefab_name ~= "" and arg_142_1.actors_[var_145_5.prefab_name] ~= nil then
						local var_145_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_142_1.actors_[var_145_5.prefab_name].transform, "story_v_out_104112", "104112035", "story_v_out_104112.awb")

						arg_142_1:RecordAudio("104112035", var_145_11)
						arg_142_1:RecordAudio("104112035", var_145_11)
					else
						arg_142_1:AudioAction("play", "voice", "story_v_out_104112", "104112035", "story_v_out_104112.awb")
					end

					arg_142_1:RecordHistoryTalkVoice("story_v_out_104112", "104112035", "story_v_out_104112.awb")
				end

				arg_142_1:RecordContent(arg_142_1.text_.text)
			end

			local var_145_12 = math.max(var_145_3, arg_142_1.talkMaxDuration)

			if var_145_2 <= arg_142_1.time_ and arg_142_1.time_ < var_145_2 + var_145_12 then
				arg_142_1.typewritter.percent = (arg_142_1.time_ - var_145_2) / var_145_12

				arg_142_1.typewritter:SetDirty()
			end

			if arg_142_1.time_ >= var_145_2 + var_145_12 and arg_142_1.time_ < var_145_2 + var_145_12 + arg_145_0 then
				arg_142_1.typewritter.percent = 1

				arg_142_1.typewritter:SetDirty()
				arg_142_1:ShowNextGo(true)
			end
		end

		arg_142_1.nodeConfigList_ = {}

		arg_142_1:InitPlayNodeList()
	end,
	Play104112036 = function(arg_146_0, arg_146_1)
		arg_146_1.time_ = 0
		arg_146_1.frameCnt_ = 0
		arg_146_1.state_ = "playing"
		arg_146_1.curTalkId_ = 104112036
		arg_146_1.duration_ = 5.1

		local var_146_0 = {
			ja = 5.1,
			ko = 1.999999999999,
			zh = 2.166,
			en = 2.366
		}
		local var_146_1 = manager.audio:GetLocalizationFlag()

		if var_146_0[var_146_1] ~= nil then
			arg_146_1.duration_ = var_146_0[var_146_1]
		end

		SetActive(arg_146_1.tipsGo_, false)

		function arg_146_1.onSingleLineFinish_()
			arg_146_1.onSingleLineUpdate_ = nil
			arg_146_1.onSingleLineFinish_ = nil
			arg_146_1.state_ = "waiting"
		end

		function arg_146_1.playNext_(arg_148_0)
			if arg_148_0 == 1 then
				arg_146_0:Play104112037(arg_146_1)
			end
		end

		function arg_146_1.onSingleLineUpdate_(arg_149_0)
			local var_149_0 = arg_146_1.actors_["2020_tpose"]
			local var_149_1 = 0

			if var_149_1 < arg_146_1.time_ and arg_146_1.time_ <= var_149_1 + arg_149_0 and not isNil(var_149_0) and arg_146_1.var_.characterEffect2020_tpose == nil then
				arg_146_1.var_.characterEffect2020_tpose = var_149_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_149_2 = 0.1

			if var_149_1 <= arg_146_1.time_ and arg_146_1.time_ < var_149_1 + var_149_2 and not isNil(var_149_0) then
				local var_149_3 = (arg_146_1.time_ - var_149_1) / var_149_2

				if arg_146_1.var_.characterEffect2020_tpose and not isNil(var_149_0) then
					arg_146_1.var_.characterEffect2020_tpose.fillFlat = false
				end
			end

			if arg_146_1.time_ >= var_149_1 + var_149_2 and arg_146_1.time_ < var_149_1 + var_149_2 + arg_149_0 and not isNil(var_149_0) and arg_146_1.var_.characterEffect2020_tpose then
				arg_146_1.var_.characterEffect2020_tpose.fillFlat = false
			end

			local var_149_4 = arg_146_1.actors_["4010ui_story"]
			local var_149_5 = 0

			if var_149_5 < arg_146_1.time_ and arg_146_1.time_ <= var_149_5 + arg_149_0 and not isNil(var_149_4) and arg_146_1.var_.characterEffect4010ui_story == nil then
				arg_146_1.var_.characterEffect4010ui_story = var_149_4:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_149_6 = 0.1

			if var_149_5 <= arg_146_1.time_ and arg_146_1.time_ < var_149_5 + var_149_6 and not isNil(var_149_4) then
				local var_149_7 = (arg_146_1.time_ - var_149_5) / var_149_6

				if arg_146_1.var_.characterEffect4010ui_story and not isNil(var_149_4) then
					local var_149_8 = Mathf.Lerp(0, 0.5, var_149_7)

					arg_146_1.var_.characterEffect4010ui_story.fillFlat = true
					arg_146_1.var_.characterEffect4010ui_story.fillRatio = var_149_8
				end
			end

			if arg_146_1.time_ >= var_149_5 + var_149_6 and arg_146_1.time_ < var_149_5 + var_149_6 + arg_149_0 and not isNil(var_149_4) and arg_146_1.var_.characterEffect4010ui_story then
				local var_149_9 = 0.5

				arg_146_1.var_.characterEffect4010ui_story.fillFlat = true
				arg_146_1.var_.characterEffect4010ui_story.fillRatio = var_149_9
			end

			local var_149_10 = arg_146_1.actors_["4010ui_story"].transform
			local var_149_11 = 0

			if var_149_11 < arg_146_1.time_ and arg_146_1.time_ <= var_149_11 + arg_149_0 then
				arg_146_1.var_.moveOldPos4010ui_story = var_149_10.localPosition
			end

			local var_149_12 = 0.001

			if var_149_11 <= arg_146_1.time_ and arg_146_1.time_ < var_149_11 + var_149_12 then
				local var_149_13 = (arg_146_1.time_ - var_149_11) / var_149_12
				local var_149_14 = Vector3.New(0, 100, 0)

				var_149_10.localPosition = Vector3.Lerp(arg_146_1.var_.moveOldPos4010ui_story, var_149_14, var_149_13)

				local var_149_15 = manager.ui.mainCamera.transform.position - var_149_10.position

				var_149_10.forward = Vector3.New(var_149_15.x, var_149_15.y, var_149_15.z)

				local var_149_16 = var_149_10.localEulerAngles

				var_149_16.z = 0
				var_149_16.x = 0
				var_149_10.localEulerAngles = var_149_16
			end

			if arg_146_1.time_ >= var_149_11 + var_149_12 and arg_146_1.time_ < var_149_11 + var_149_12 + arg_149_0 then
				var_149_10.localPosition = Vector3.New(0, 100, 0)

				local var_149_17 = manager.ui.mainCamera.transform.position - var_149_10.position

				var_149_10.forward = Vector3.New(var_149_17.x, var_149_17.y, var_149_17.z)

				local var_149_18 = var_149_10.localEulerAngles

				var_149_18.z = 0
				var_149_18.x = 0
				var_149_10.localEulerAngles = var_149_18
			end

			local var_149_19 = arg_146_1.actors_["2020_tpose"].transform
			local var_149_20 = 0

			if var_149_20 < arg_146_1.time_ and arg_146_1.time_ <= var_149_20 + arg_149_0 then
				arg_146_1.var_.moveOldPos2020_tpose = var_149_19.localPosition

				local var_149_21 = GameObjectTools.GetOrAddComponent(var_149_19.gameObject, typeof(DynamicBoneHelper))

				if var_149_21 then
					var_149_21:EnableDynamicBone(false)
				end
			end

			local var_149_22 = 0.001

			if var_149_20 <= arg_146_1.time_ and arg_146_1.time_ < var_149_20 + var_149_22 then
				local var_149_23 = (arg_146_1.time_ - var_149_20) / var_149_22
				local var_149_24 = Vector3.New(-0.7, -1.2, -4.1)

				var_149_19.localPosition = Vector3.Lerp(arg_146_1.var_.moveOldPos2020_tpose, var_149_24, var_149_23)

				local var_149_25 = manager.ui.mainCamera.transform.position - var_149_19.position

				var_149_19.forward = Vector3.New(var_149_25.x, var_149_25.y, var_149_25.z)

				local var_149_26 = var_149_19.localEulerAngles

				var_149_26.z = 0
				var_149_26.x = 0
				var_149_19.localEulerAngles = var_149_26
			end

			if arg_146_1.time_ >= var_149_20 + var_149_22 and arg_146_1.time_ < var_149_20 + var_149_22 + arg_149_0 then
				var_149_19.localPosition = Vector3.New(-0.7, -1.2, -4.1)

				local var_149_27 = manager.ui.mainCamera.transform.position - var_149_19.position

				var_149_19.forward = Vector3.New(var_149_27.x, var_149_27.y, var_149_27.z)

				local var_149_28 = var_149_19.localEulerAngles

				var_149_28.z = 0
				var_149_28.x = 0
				var_149_19.localEulerAngles = var_149_28

				local var_149_29 = GameObjectTools.GetOrAddComponent(var_149_19.gameObject, typeof(DynamicBoneHelper))

				if var_149_29 then
					var_149_29:EnableDynamicBone(true)
				end
			end

			local var_149_30 = 0

			if var_149_30 < arg_146_1.time_ and arg_146_1.time_ <= var_149_30 + arg_149_0 then
				arg_146_1:PlayTimeline("2020_tpose", "StoryTimeline/CharAction/story2020/story2020action/2020action1_1")
			end

			local var_149_31 = 0
			local var_149_32 = 0.125

			if var_149_31 < arg_146_1.time_ and arg_146_1.time_ <= var_149_31 + arg_149_0 then
				arg_146_1.talkMaxDuration = 0
				arg_146_1.dialogCg_.alpha = 1

				arg_146_1.dialog_:SetActive(true)
				SetActive(arg_146_1.leftNameGo_, true)

				local var_149_33 = arg_146_1:FormatText(StoryNameCfg[19].name)

				arg_146_1.leftNameTxt_.text = var_149_33

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_146_1.leftNameTxt_.transform)

				arg_146_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_146_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_146_1:RecordName(arg_146_1.leftNameTxt_.text)
				SetActive(arg_146_1.iconTrs_.gameObject, false)
				arg_146_1.callingController_:SetSelectedState("normal")

				local var_149_34 = arg_146_1:GetWordFromCfg(104112036)
				local var_149_35 = arg_146_1:FormatText(var_149_34.content)

				arg_146_1.text_.text = var_149_35

				LuaForUtil.ClearLinePrefixSymbol(arg_146_1.text_)

				local var_149_36 = 5
				local var_149_37 = utf8.len(var_149_35)
				local var_149_38 = var_149_36 <= 0 and var_149_32 or var_149_32 * (var_149_37 / var_149_36)

				if var_149_38 > 0 and var_149_32 < var_149_38 then
					arg_146_1.talkMaxDuration = var_149_38

					if var_149_38 + var_149_31 > arg_146_1.duration_ then
						arg_146_1.duration_ = var_149_38 + var_149_31
					end
				end

				arg_146_1.text_.text = var_149_35
				arg_146_1.typewritter.percent = 0

				arg_146_1.typewritter:SetDirty()
				arg_146_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_104112", "104112036", "story_v_out_104112.awb") ~= 0 then
					local var_149_39 = manager.audio:GetVoiceLength("story_v_out_104112", "104112036", "story_v_out_104112.awb") / 1000

					if var_149_39 + var_149_31 > arg_146_1.duration_ then
						arg_146_1.duration_ = var_149_39 + var_149_31
					end

					if var_149_34.prefab_name ~= "" and arg_146_1.actors_[var_149_34.prefab_name] ~= nil then
						local var_149_40 = LuaForUtil.PlayVoiceWithCriLipsync(arg_146_1.actors_[var_149_34.prefab_name].transform, "story_v_out_104112", "104112036", "story_v_out_104112.awb")

						arg_146_1:RecordAudio("104112036", var_149_40)
						arg_146_1:RecordAudio("104112036", var_149_40)
					else
						arg_146_1:AudioAction("play", "voice", "story_v_out_104112", "104112036", "story_v_out_104112.awb")
					end

					arg_146_1:RecordHistoryTalkVoice("story_v_out_104112", "104112036", "story_v_out_104112.awb")
				end

				arg_146_1:RecordContent(arg_146_1.text_.text)
			end

			local var_149_41 = math.max(var_149_32, arg_146_1.talkMaxDuration)

			if var_149_31 <= arg_146_1.time_ and arg_146_1.time_ < var_149_31 + var_149_41 then
				arg_146_1.typewritter.percent = (arg_146_1.time_ - var_149_31) / var_149_41

				arg_146_1.typewritter:SetDirty()
			end

			if arg_146_1.time_ >= var_149_31 + var_149_41 and arg_146_1.time_ < var_149_31 + var_149_41 + arg_149_0 then
				arg_146_1.typewritter.percent = 1

				arg_146_1.typewritter:SetDirty()
				arg_146_1:ShowNextGo(true)
			end
		end

		arg_146_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "4010ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.033,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "2020_tpose",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.033,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_146_1:InitPlayNodeList()
	end,
	Play104112037 = function(arg_150_0, arg_150_1)
		arg_150_1.time_ = 0
		arg_150_1.frameCnt_ = 0
		arg_150_1.state_ = "playing"
		arg_150_1.curTalkId_ = 104112037
		arg_150_1.duration_ = 3.3

		local var_150_0 = {
			ja = 3.3,
			ko = 1.999999999999,
			zh = 1.999999999999,
			en = 1.999999999999
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
				arg_150_0:Play104112038(arg_150_1)
			end
		end

		function arg_150_1.onSingleLineUpdate_(arg_153_0)
			local var_153_0 = arg_150_1.actors_["2030_tpose"]
			local var_153_1 = 0

			if var_153_1 < arg_150_1.time_ and arg_150_1.time_ <= var_153_1 + arg_153_0 and not isNil(var_153_0) and arg_150_1.var_.characterEffect2030_tpose == nil then
				arg_150_1.var_.characterEffect2030_tpose = var_153_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_153_2 = 0.1

			if var_153_1 <= arg_150_1.time_ and arg_150_1.time_ < var_153_1 + var_153_2 and not isNil(var_153_0) then
				local var_153_3 = (arg_150_1.time_ - var_153_1) / var_153_2

				if arg_150_1.var_.characterEffect2030_tpose and not isNil(var_153_0) then
					arg_150_1.var_.characterEffect2030_tpose.fillFlat = false
				end
			end

			if arg_150_1.time_ >= var_153_1 + var_153_2 and arg_150_1.time_ < var_153_1 + var_153_2 + arg_153_0 and not isNil(var_153_0) and arg_150_1.var_.characterEffect2030_tpose then
				arg_150_1.var_.characterEffect2030_tpose.fillFlat = false
			end

			local var_153_4 = arg_150_1.actors_["2020_tpose"]
			local var_153_5 = 0

			if var_153_5 < arg_150_1.time_ and arg_150_1.time_ <= var_153_5 + arg_153_0 and not isNil(var_153_4) and arg_150_1.var_.characterEffect2020_tpose == nil then
				arg_150_1.var_.characterEffect2020_tpose = var_153_4:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_153_6 = 0.1

			if var_153_5 <= arg_150_1.time_ and arg_150_1.time_ < var_153_5 + var_153_6 and not isNil(var_153_4) then
				local var_153_7 = (arg_150_1.time_ - var_153_5) / var_153_6

				if arg_150_1.var_.characterEffect2020_tpose and not isNil(var_153_4) then
					local var_153_8 = Mathf.Lerp(0, 0.5, var_153_7)

					arg_150_1.var_.characterEffect2020_tpose.fillFlat = true
					arg_150_1.var_.characterEffect2020_tpose.fillRatio = var_153_8
				end
			end

			if arg_150_1.time_ >= var_153_5 + var_153_6 and arg_150_1.time_ < var_153_5 + var_153_6 + arg_153_0 and not isNil(var_153_4) and arg_150_1.var_.characterEffect2020_tpose then
				local var_153_9 = 0.5

				arg_150_1.var_.characterEffect2020_tpose.fillFlat = true
				arg_150_1.var_.characterEffect2020_tpose.fillRatio = var_153_9
			end

			local var_153_10 = arg_150_1.actors_["2030_tpose"].transform
			local var_153_11 = 0

			if var_153_11 < arg_150_1.time_ and arg_150_1.time_ <= var_153_11 + arg_153_0 then
				arg_150_1.var_.moveOldPos2030_tpose = var_153_10.localPosition

				local var_153_12 = GameObjectTools.GetOrAddComponent(var_153_10.gameObject, typeof(DynamicBoneHelper))

				if var_153_12 then
					var_153_12:EnableDynamicBone(false)
				end
			end

			local var_153_13 = 0.001

			if var_153_11 <= arg_150_1.time_ and arg_150_1.time_ < var_153_11 + var_153_13 then
				local var_153_14 = (arg_150_1.time_ - var_153_11) / var_153_13
				local var_153_15 = Vector3.New(0.7, -1.2, -4.2)

				var_153_10.localPosition = Vector3.Lerp(arg_150_1.var_.moveOldPos2030_tpose, var_153_15, var_153_14)

				local var_153_16 = manager.ui.mainCamera.transform.position - var_153_10.position

				var_153_10.forward = Vector3.New(var_153_16.x, var_153_16.y, var_153_16.z)

				local var_153_17 = var_153_10.localEulerAngles

				var_153_17.z = 0
				var_153_17.x = 0
				var_153_10.localEulerAngles = var_153_17
			end

			if arg_150_1.time_ >= var_153_11 + var_153_13 and arg_150_1.time_ < var_153_11 + var_153_13 + arg_153_0 then
				var_153_10.localPosition = Vector3.New(0.7, -1.2, -4.2)

				local var_153_18 = manager.ui.mainCamera.transform.position - var_153_10.position

				var_153_10.forward = Vector3.New(var_153_18.x, var_153_18.y, var_153_18.z)

				local var_153_19 = var_153_10.localEulerAngles

				var_153_19.z = 0
				var_153_19.x = 0
				var_153_10.localEulerAngles = var_153_19

				local var_153_20 = GameObjectTools.GetOrAddComponent(var_153_10.gameObject, typeof(DynamicBoneHelper))

				if var_153_20 then
					var_153_20:EnableDynamicBone(true)
				end
			end

			local var_153_21 = 0

			if var_153_21 < arg_150_1.time_ and arg_150_1.time_ <= var_153_21 + arg_153_0 then
				arg_150_1:PlayTimeline("2030_tpose", "StoryTimeline/CharAction/story2030/story2030action/2030action1_1")
			end

			local var_153_22 = 0
			local var_153_23 = 0.2

			if var_153_22 < arg_150_1.time_ and arg_150_1.time_ <= var_153_22 + arg_153_0 then
				arg_150_1.talkMaxDuration = 0
				arg_150_1.dialogCg_.alpha = 1

				arg_150_1.dialog_:SetActive(true)
				SetActive(arg_150_1.leftNameGo_, true)

				local var_153_24 = arg_150_1:FormatText(StoryNameCfg[33].name)

				arg_150_1.leftNameTxt_.text = var_153_24

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_150_1.leftNameTxt_.transform)

				arg_150_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_150_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_150_1:RecordName(arg_150_1.leftNameTxt_.text)
				SetActive(arg_150_1.iconTrs_.gameObject, false)
				arg_150_1.callingController_:SetSelectedState("normal")

				local var_153_25 = arg_150_1:GetWordFromCfg(104112037)
				local var_153_26 = arg_150_1:FormatText(var_153_25.content)

				arg_150_1.text_.text = var_153_26

				LuaForUtil.ClearLinePrefixSymbol(arg_150_1.text_)

				local var_153_27 = 8
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

				if manager.audio:GetVoiceLength("story_v_out_104112", "104112037", "story_v_out_104112.awb") ~= 0 then
					local var_153_30 = manager.audio:GetVoiceLength("story_v_out_104112", "104112037", "story_v_out_104112.awb") / 1000

					if var_153_30 + var_153_22 > arg_150_1.duration_ then
						arg_150_1.duration_ = var_153_30 + var_153_22
					end

					if var_153_25.prefab_name ~= "" and arg_150_1.actors_[var_153_25.prefab_name] ~= nil then
						local var_153_31 = LuaForUtil.PlayVoiceWithCriLipsync(arg_150_1.actors_[var_153_25.prefab_name].transform, "story_v_out_104112", "104112037", "story_v_out_104112.awb")

						arg_150_1:RecordAudio("104112037", var_153_31)
						arg_150_1:RecordAudio("104112037", var_153_31)
					else
						arg_150_1:AudioAction("play", "voice", "story_v_out_104112", "104112037", "story_v_out_104112.awb")
					end

					arg_150_1:RecordHistoryTalkVoice("story_v_out_104112", "104112037", "story_v_out_104112.awb")
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
				actorName = "2030_tpose",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.033,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_150_1:InitPlayNodeList()
	end,
	Play104112038 = function(arg_154_0, arg_154_1)
		arg_154_1.time_ = 0
		arg_154_1.frameCnt_ = 0
		arg_154_1.state_ = "playing"
		arg_154_1.curTalkId_ = 104112038
		arg_154_1.duration_ = 4.1

		local var_154_0 = {
			ja = 4.1,
			ko = 2,
			zh = 2.366,
			en = 1.833
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
				arg_154_0:Play104112039(arg_154_1)
			end
		end

		function arg_154_1.onSingleLineUpdate_(arg_157_0)
			local var_157_0 = arg_154_1.actors_["2020_tpose"]
			local var_157_1 = 0

			if var_157_1 < arg_154_1.time_ and arg_154_1.time_ <= var_157_1 + arg_157_0 and not isNil(var_157_0) and arg_154_1.var_.characterEffect2020_tpose == nil then
				arg_154_1.var_.characterEffect2020_tpose = var_157_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_157_2 = 0.1

			if var_157_1 <= arg_154_1.time_ and arg_154_1.time_ < var_157_1 + var_157_2 and not isNil(var_157_0) then
				local var_157_3 = (arg_154_1.time_ - var_157_1) / var_157_2

				if arg_154_1.var_.characterEffect2020_tpose and not isNil(var_157_0) then
					arg_154_1.var_.characterEffect2020_tpose.fillFlat = false
				end
			end

			if arg_154_1.time_ >= var_157_1 + var_157_2 and arg_154_1.time_ < var_157_1 + var_157_2 + arg_157_0 and not isNil(var_157_0) and arg_154_1.var_.characterEffect2020_tpose then
				arg_154_1.var_.characterEffect2020_tpose.fillFlat = false
			end

			local var_157_4 = arg_154_1.actors_["2030_tpose"]
			local var_157_5 = 0

			if var_157_5 < arg_154_1.time_ and arg_154_1.time_ <= var_157_5 + arg_157_0 and not isNil(var_157_4) and arg_154_1.var_.characterEffect2030_tpose == nil then
				arg_154_1.var_.characterEffect2030_tpose = var_157_4:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_157_6 = 0.1

			if var_157_5 <= arg_154_1.time_ and arg_154_1.time_ < var_157_5 + var_157_6 and not isNil(var_157_4) then
				local var_157_7 = (arg_154_1.time_ - var_157_5) / var_157_6

				if arg_154_1.var_.characterEffect2030_tpose and not isNil(var_157_4) then
					local var_157_8 = Mathf.Lerp(0, 0.5, var_157_7)

					arg_154_1.var_.characterEffect2030_tpose.fillFlat = true
					arg_154_1.var_.characterEffect2030_tpose.fillRatio = var_157_8
				end
			end

			if arg_154_1.time_ >= var_157_5 + var_157_6 and arg_154_1.time_ < var_157_5 + var_157_6 + arg_157_0 and not isNil(var_157_4) and arg_154_1.var_.characterEffect2030_tpose then
				local var_157_9 = 0.5

				arg_154_1.var_.characterEffect2030_tpose.fillFlat = true
				arg_154_1.var_.characterEffect2030_tpose.fillRatio = var_157_9
			end

			local var_157_10 = 0
			local var_157_11 = 0.25

			if var_157_10 < arg_154_1.time_ and arg_154_1.time_ <= var_157_10 + arg_157_0 then
				arg_154_1.talkMaxDuration = 0
				arg_154_1.dialogCg_.alpha = 1

				arg_154_1.dialog_:SetActive(true)
				SetActive(arg_154_1.leftNameGo_, true)

				local var_157_12 = arg_154_1:FormatText(StoryNameCfg[19].name)

				arg_154_1.leftNameTxt_.text = var_157_12

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_154_1.leftNameTxt_.transform)

				arg_154_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_154_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_154_1:RecordName(arg_154_1.leftNameTxt_.text)
				SetActive(arg_154_1.iconTrs_.gameObject, false)
				arg_154_1.callingController_:SetSelectedState("normal")

				local var_157_13 = arg_154_1:GetWordFromCfg(104112038)
				local var_157_14 = arg_154_1:FormatText(var_157_13.content)

				arg_154_1.text_.text = var_157_14

				LuaForUtil.ClearLinePrefixSymbol(arg_154_1.text_)

				local var_157_15 = 10
				local var_157_16 = utf8.len(var_157_14)
				local var_157_17 = var_157_15 <= 0 and var_157_11 or var_157_11 * (var_157_16 / var_157_15)

				if var_157_17 > 0 and var_157_11 < var_157_17 then
					arg_154_1.talkMaxDuration = var_157_17

					if var_157_17 + var_157_10 > arg_154_1.duration_ then
						arg_154_1.duration_ = var_157_17 + var_157_10
					end
				end

				arg_154_1.text_.text = var_157_14
				arg_154_1.typewritter.percent = 0

				arg_154_1.typewritter:SetDirty()
				arg_154_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_104112", "104112038", "story_v_out_104112.awb") ~= 0 then
					local var_157_18 = manager.audio:GetVoiceLength("story_v_out_104112", "104112038", "story_v_out_104112.awb") / 1000

					if var_157_18 + var_157_10 > arg_154_1.duration_ then
						arg_154_1.duration_ = var_157_18 + var_157_10
					end

					if var_157_13.prefab_name ~= "" and arg_154_1.actors_[var_157_13.prefab_name] ~= nil then
						local var_157_19 = LuaForUtil.PlayVoiceWithCriLipsync(arg_154_1.actors_[var_157_13.prefab_name].transform, "story_v_out_104112", "104112038", "story_v_out_104112.awb")

						arg_154_1:RecordAudio("104112038", var_157_19)
						arg_154_1:RecordAudio("104112038", var_157_19)
					else
						arg_154_1:AudioAction("play", "voice", "story_v_out_104112", "104112038", "story_v_out_104112.awb")
					end

					arg_154_1:RecordHistoryTalkVoice("story_v_out_104112", "104112038", "story_v_out_104112.awb")
				end

				arg_154_1:RecordContent(arg_154_1.text_.text)
			end

			local var_157_20 = math.max(var_157_11, arg_154_1.talkMaxDuration)

			if var_157_10 <= arg_154_1.time_ and arg_154_1.time_ < var_157_10 + var_157_20 then
				arg_154_1.typewritter.percent = (arg_154_1.time_ - var_157_10) / var_157_20

				arg_154_1.typewritter:SetDirty()
			end

			if arg_154_1.time_ >= var_157_10 + var_157_20 and arg_154_1.time_ < var_157_10 + var_157_20 + arg_157_0 then
				arg_154_1.typewritter.percent = 1

				arg_154_1.typewritter:SetDirty()
				arg_154_1:ShowNextGo(true)
			end
		end

		arg_154_1.nodeConfigList_ = {}

		arg_154_1:InitPlayNodeList()
	end,
	Play104112039 = function(arg_158_0, arg_158_1)
		arg_158_1.time_ = 0
		arg_158_1.frameCnt_ = 0
		arg_158_1.state_ = "playing"
		arg_158_1.curTalkId_ = 104112039
		arg_158_1.duration_ = 2

		local var_158_0 = {
			ja = 1.999999999999,
			ko = 1.999999999999,
			zh = 2,
			en = 1.999999999999
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
				arg_158_0:Play104112040(arg_158_1)
			end
		end

		function arg_158_1.onSingleLineUpdate_(arg_161_0)
			local var_161_0 = arg_158_1.actors_["4010ui_story"]
			local var_161_1 = 0

			if var_161_1 < arg_158_1.time_ and arg_158_1.time_ <= var_161_1 + arg_161_0 and not isNil(var_161_0) and arg_158_1.var_.characterEffect4010ui_story == nil then
				arg_158_1.var_.characterEffect4010ui_story = var_161_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_161_2 = 0.1

			if var_161_1 <= arg_158_1.time_ and arg_158_1.time_ < var_161_1 + var_161_2 and not isNil(var_161_0) then
				local var_161_3 = (arg_158_1.time_ - var_161_1) / var_161_2

				if arg_158_1.var_.characterEffect4010ui_story and not isNil(var_161_0) then
					arg_158_1.var_.characterEffect4010ui_story.fillFlat = false
				end
			end

			if arg_158_1.time_ >= var_161_1 + var_161_2 and arg_158_1.time_ < var_161_1 + var_161_2 + arg_161_0 and not isNil(var_161_0) and arg_158_1.var_.characterEffect4010ui_story then
				arg_158_1.var_.characterEffect4010ui_story.fillFlat = false
			end

			local var_161_4 = arg_158_1.actors_["2020_tpose"]
			local var_161_5 = 0

			if var_161_5 < arg_158_1.time_ and arg_158_1.time_ <= var_161_5 + arg_161_0 and not isNil(var_161_4) and arg_158_1.var_.characterEffect2020_tpose == nil then
				arg_158_1.var_.characterEffect2020_tpose = var_161_4:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_161_6 = 0.1

			if var_161_5 <= arg_158_1.time_ and arg_158_1.time_ < var_161_5 + var_161_6 and not isNil(var_161_4) then
				local var_161_7 = (arg_158_1.time_ - var_161_5) / var_161_6

				if arg_158_1.var_.characterEffect2020_tpose and not isNil(var_161_4) then
					local var_161_8 = Mathf.Lerp(0, 0.5, var_161_7)

					arg_158_1.var_.characterEffect2020_tpose.fillFlat = true
					arg_158_1.var_.characterEffect2020_tpose.fillRatio = var_161_8
				end
			end

			if arg_158_1.time_ >= var_161_5 + var_161_6 and arg_158_1.time_ < var_161_5 + var_161_6 + arg_161_0 and not isNil(var_161_4) and arg_158_1.var_.characterEffect2020_tpose then
				local var_161_9 = 0.5

				arg_158_1.var_.characterEffect2020_tpose.fillFlat = true
				arg_158_1.var_.characterEffect2020_tpose.fillRatio = var_161_9
			end

			local var_161_10 = arg_158_1.actors_["2030_tpose"].transform
			local var_161_11 = 0

			if var_161_11 < arg_158_1.time_ and arg_158_1.time_ <= var_161_11 + arg_161_0 then
				arg_158_1.var_.moveOldPos2030_tpose = var_161_10.localPosition

				local var_161_12 = GameObjectTools.GetOrAddComponent(var_161_10.gameObject, typeof(DynamicBoneHelper))

				if var_161_12 then
					var_161_12:EnableDynamicBone(false)
				end
			end

			local var_161_13 = 0.001

			if var_161_11 <= arg_158_1.time_ and arg_158_1.time_ < var_161_11 + var_161_13 then
				local var_161_14 = (arg_158_1.time_ - var_161_11) / var_161_13
				local var_161_15 = Vector3.New(0, 100, 0)

				var_161_10.localPosition = Vector3.Lerp(arg_158_1.var_.moveOldPos2030_tpose, var_161_15, var_161_14)

				local var_161_16 = manager.ui.mainCamera.transform.position - var_161_10.position

				var_161_10.forward = Vector3.New(var_161_16.x, var_161_16.y, var_161_16.z)

				local var_161_17 = var_161_10.localEulerAngles

				var_161_17.z = 0
				var_161_17.x = 0
				var_161_10.localEulerAngles = var_161_17
			end

			if arg_158_1.time_ >= var_161_11 + var_161_13 and arg_158_1.time_ < var_161_11 + var_161_13 + arg_161_0 then
				var_161_10.localPosition = Vector3.New(0, 100, 0)

				local var_161_18 = manager.ui.mainCamera.transform.position - var_161_10.position

				var_161_10.forward = Vector3.New(var_161_18.x, var_161_18.y, var_161_18.z)

				local var_161_19 = var_161_10.localEulerAngles

				var_161_19.z = 0
				var_161_19.x = 0
				var_161_10.localEulerAngles = var_161_19

				local var_161_20 = GameObjectTools.GetOrAddComponent(var_161_10.gameObject, typeof(DynamicBoneHelper))

				if var_161_20 then
					var_161_20:EnableDynamicBone(true)
				end
			end

			local var_161_21 = arg_158_1.actors_["2020_tpose"].transform
			local var_161_22 = 0

			if var_161_22 < arg_158_1.time_ and arg_158_1.time_ <= var_161_22 + arg_161_0 then
				arg_158_1.var_.moveOldPos2020_tpose = var_161_21.localPosition

				local var_161_23 = GameObjectTools.GetOrAddComponent(var_161_21.gameObject, typeof(DynamicBoneHelper))

				if var_161_23 then
					var_161_23:EnableDynamicBone(false)
				end
			end

			local var_161_24 = 0.001

			if var_161_22 <= arg_158_1.time_ and arg_158_1.time_ < var_161_22 + var_161_24 then
				local var_161_25 = (arg_158_1.time_ - var_161_22) / var_161_24
				local var_161_26 = Vector3.New(0, 100, 0)

				var_161_21.localPosition = Vector3.Lerp(arg_158_1.var_.moveOldPos2020_tpose, var_161_26, var_161_25)

				local var_161_27 = manager.ui.mainCamera.transform.position - var_161_21.position

				var_161_21.forward = Vector3.New(var_161_27.x, var_161_27.y, var_161_27.z)

				local var_161_28 = var_161_21.localEulerAngles

				var_161_28.z = 0
				var_161_28.x = 0
				var_161_21.localEulerAngles = var_161_28
			end

			if arg_158_1.time_ >= var_161_22 + var_161_24 and arg_158_1.time_ < var_161_22 + var_161_24 + arg_161_0 then
				var_161_21.localPosition = Vector3.New(0, 100, 0)

				local var_161_29 = manager.ui.mainCamera.transform.position - var_161_21.position

				var_161_21.forward = Vector3.New(var_161_29.x, var_161_29.y, var_161_29.z)

				local var_161_30 = var_161_21.localEulerAngles

				var_161_30.z = 0
				var_161_30.x = 0
				var_161_21.localEulerAngles = var_161_30

				local var_161_31 = GameObjectTools.GetOrAddComponent(var_161_21.gameObject, typeof(DynamicBoneHelper))

				if var_161_31 then
					var_161_31:EnableDynamicBone(true)
				end
			end

			local var_161_32 = arg_158_1.actors_["4010ui_story"].transform
			local var_161_33 = 0

			if var_161_33 < arg_158_1.time_ and arg_158_1.time_ <= var_161_33 + arg_161_0 then
				arg_158_1.var_.moveOldPos4010ui_story = var_161_32.localPosition
			end

			local var_161_34 = 0.001

			if var_161_33 <= arg_158_1.time_ and arg_158_1.time_ < var_161_33 + var_161_34 then
				local var_161_35 = (arg_158_1.time_ - var_161_33) / var_161_34
				local var_161_36 = Vector3.New(0, -1.59, -5.2)

				var_161_32.localPosition = Vector3.Lerp(arg_158_1.var_.moveOldPos4010ui_story, var_161_36, var_161_35)

				local var_161_37 = manager.ui.mainCamera.transform.position - var_161_32.position

				var_161_32.forward = Vector3.New(var_161_37.x, var_161_37.y, var_161_37.z)

				local var_161_38 = var_161_32.localEulerAngles

				var_161_38.z = 0
				var_161_38.x = 0
				var_161_32.localEulerAngles = var_161_38
			end

			if arg_158_1.time_ >= var_161_33 + var_161_34 and arg_158_1.time_ < var_161_33 + var_161_34 + arg_161_0 then
				var_161_32.localPosition = Vector3.New(0, -1.59, -5.2)

				local var_161_39 = manager.ui.mainCamera.transform.position - var_161_32.position

				var_161_32.forward = Vector3.New(var_161_39.x, var_161_39.y, var_161_39.z)

				local var_161_40 = var_161_32.localEulerAngles

				var_161_40.z = 0
				var_161_40.x = 0
				var_161_32.localEulerAngles = var_161_40
			end

			local var_161_41 = 0

			if var_161_41 < arg_158_1.time_ and arg_158_1.time_ <= var_161_41 + arg_161_0 then
				arg_158_1:PlayTimeline("4010ui_story", "StoryTimeline/CharAction/story4010/story4010action/4010action1_1")
			end

			local var_161_42 = 0

			if var_161_42 < arg_158_1.time_ and arg_158_1.time_ <= var_161_42 + arg_161_0 then
				arg_158_1:PlayTimeline("4010ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1101cva")
			end

			local var_161_43 = 0
			local var_161_44 = 0.075

			if var_161_43 < arg_158_1.time_ and arg_158_1.time_ <= var_161_43 + arg_161_0 then
				arg_158_1.talkMaxDuration = 0
				arg_158_1.dialogCg_.alpha = 1

				arg_158_1.dialog_:SetActive(true)
				SetActive(arg_158_1.leftNameGo_, true)

				local var_161_45 = arg_158_1:FormatText(StoryNameCfg[42].name)

				arg_158_1.leftNameTxt_.text = var_161_45

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_158_1.leftNameTxt_.transform)

				arg_158_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_158_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_158_1:RecordName(arg_158_1.leftNameTxt_.text)
				SetActive(arg_158_1.iconTrs_.gameObject, false)
				arg_158_1.callingController_:SetSelectedState("normal")

				local var_161_46 = arg_158_1:GetWordFromCfg(104112039)
				local var_161_47 = arg_158_1:FormatText(var_161_46.content)

				arg_158_1.text_.text = var_161_47

				LuaForUtil.ClearLinePrefixSymbol(arg_158_1.text_)

				local var_161_48 = 3
				local var_161_49 = utf8.len(var_161_47)
				local var_161_50 = var_161_48 <= 0 and var_161_44 or var_161_44 * (var_161_49 / var_161_48)

				if var_161_50 > 0 and var_161_44 < var_161_50 then
					arg_158_1.talkMaxDuration = var_161_50

					if var_161_50 + var_161_43 > arg_158_1.duration_ then
						arg_158_1.duration_ = var_161_50 + var_161_43
					end
				end

				arg_158_1.text_.text = var_161_47
				arg_158_1.typewritter.percent = 0

				arg_158_1.typewritter:SetDirty()
				arg_158_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_104112", "104112039", "story_v_out_104112.awb") ~= 0 then
					local var_161_51 = manager.audio:GetVoiceLength("story_v_out_104112", "104112039", "story_v_out_104112.awb") / 1000

					if var_161_51 + var_161_43 > arg_158_1.duration_ then
						arg_158_1.duration_ = var_161_51 + var_161_43
					end

					if var_161_46.prefab_name ~= "" and arg_158_1.actors_[var_161_46.prefab_name] ~= nil then
						local var_161_52 = LuaForUtil.PlayVoiceWithCriLipsync(arg_158_1.actors_[var_161_46.prefab_name].transform, "story_v_out_104112", "104112039", "story_v_out_104112.awb")

						arg_158_1:RecordAudio("104112039", var_161_52)
						arg_158_1:RecordAudio("104112039", var_161_52)
					else
						arg_158_1:AudioAction("play", "voice", "story_v_out_104112", "104112039", "story_v_out_104112.awb")
					end

					arg_158_1:RecordHistoryTalkVoice("story_v_out_104112", "104112039", "story_v_out_104112.awb")
				end

				arg_158_1:RecordContent(arg_158_1.text_.text)
			end

			local var_161_53 = math.max(var_161_44, arg_158_1.talkMaxDuration)

			if var_161_43 <= arg_158_1.time_ and arg_158_1.time_ < var_161_43 + var_161_53 then
				arg_158_1.typewritter.percent = (arg_158_1.time_ - var_161_43) / var_161_53

				arg_158_1.typewritter:SetDirty()
			end

			if arg_158_1.time_ >= var_161_43 + var_161_53 and arg_158_1.time_ < var_161_43 + var_161_53 + arg_161_0 then
				arg_158_1.typewritter.percent = 1

				arg_158_1.typewritter:SetDirty()
				arg_158_1:ShowNextGo(true)
			end
		end

		arg_158_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "2030_tpose",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.033,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "2020_tpose",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.033,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "4010ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.033,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_158_1:InitPlayNodeList()
	end,
	Play104112040 = function(arg_162_0, arg_162_1)
		arg_162_1.time_ = 0
		arg_162_1.frameCnt_ = 0
		arg_162_1.state_ = "playing"
		arg_162_1.curTalkId_ = 104112040
		arg_162_1.duration_ = 5

		SetActive(arg_162_1.tipsGo_, false)

		function arg_162_1.onSingleLineFinish_()
			arg_162_1.onSingleLineUpdate_ = nil
			arg_162_1.onSingleLineFinish_ = nil
			arg_162_1.state_ = "waiting"
		end

		function arg_162_1.playNext_(arg_164_0)
			if arg_164_0 == 1 then
				arg_162_0:Play104112041(arg_162_1)
			end
		end

		function arg_162_1.onSingleLineUpdate_(arg_165_0)
			local var_165_0 = arg_162_1.actors_["4010ui_story"]
			local var_165_1 = 0

			if var_165_1 < arg_162_1.time_ and arg_162_1.time_ <= var_165_1 + arg_165_0 and not isNil(var_165_0) and arg_162_1.var_.characterEffect4010ui_story == nil then
				arg_162_1.var_.characterEffect4010ui_story = var_165_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_165_2 = 0.1

			if var_165_1 <= arg_162_1.time_ and arg_162_1.time_ < var_165_1 + var_165_2 and not isNil(var_165_0) then
				local var_165_3 = (arg_162_1.time_ - var_165_1) / var_165_2

				if arg_162_1.var_.characterEffect4010ui_story and not isNil(var_165_0) then
					local var_165_4 = Mathf.Lerp(0, 0.5, var_165_3)

					arg_162_1.var_.characterEffect4010ui_story.fillFlat = true
					arg_162_1.var_.characterEffect4010ui_story.fillRatio = var_165_4
				end
			end

			if arg_162_1.time_ >= var_165_1 + var_165_2 and arg_162_1.time_ < var_165_1 + var_165_2 + arg_165_0 and not isNil(var_165_0) and arg_162_1.var_.characterEffect4010ui_story then
				local var_165_5 = 0.5

				arg_162_1.var_.characterEffect4010ui_story.fillFlat = true
				arg_162_1.var_.characterEffect4010ui_story.fillRatio = var_165_5
			end

			local var_165_6 = 0
			local var_165_7 = 0.675

			if var_165_6 < arg_162_1.time_ and arg_162_1.time_ <= var_165_6 + arg_165_0 then
				arg_162_1.talkMaxDuration = 0
				arg_162_1.dialogCg_.alpha = 1

				arg_162_1.dialog_:SetActive(true)
				SetActive(arg_162_1.leftNameGo_, false)

				arg_162_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_162_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_162_1:RecordName(arg_162_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_162_1.iconTrs_.gameObject, false)
				arg_162_1.callingController_:SetSelectedState("normal")

				local var_165_8 = arg_162_1:GetWordFromCfg(104112040)
				local var_165_9 = arg_162_1:FormatText(var_165_8.content)

				arg_162_1.text_.text = var_165_9

				LuaForUtil.ClearLinePrefixSymbol(arg_162_1.text_)

				local var_165_10 = 27
				local var_165_11 = utf8.len(var_165_9)
				local var_165_12 = var_165_10 <= 0 and var_165_7 or var_165_7 * (var_165_11 / var_165_10)

				if var_165_12 > 0 and var_165_7 < var_165_12 then
					arg_162_1.talkMaxDuration = var_165_12

					if var_165_12 + var_165_6 > arg_162_1.duration_ then
						arg_162_1.duration_ = var_165_12 + var_165_6
					end
				end

				arg_162_1.text_.text = var_165_9
				arg_162_1.typewritter.percent = 0

				arg_162_1.typewritter:SetDirty()
				arg_162_1:ShowNextGo(false)
				arg_162_1:RecordContent(arg_162_1.text_.text)
			end

			local var_165_13 = math.max(var_165_7, arg_162_1.talkMaxDuration)

			if var_165_6 <= arg_162_1.time_ and arg_162_1.time_ < var_165_6 + var_165_13 then
				arg_162_1.typewritter.percent = (arg_162_1.time_ - var_165_6) / var_165_13

				arg_162_1.typewritter:SetDirty()
			end

			if arg_162_1.time_ >= var_165_6 + var_165_13 and arg_162_1.time_ < var_165_6 + var_165_13 + arg_165_0 then
				arg_162_1.typewritter.percent = 1

				arg_162_1.typewritter:SetDirty()
				arg_162_1:ShowNextGo(true)
			end
		end

		arg_162_1.nodeConfigList_ = {}

		arg_162_1:InitPlayNodeList()
	end,
	Play104112041 = function(arg_166_0, arg_166_1)
		arg_166_1.time_ = 0
		arg_166_1.frameCnt_ = 0
		arg_166_1.state_ = "playing"
		arg_166_1.curTalkId_ = 104112041
		arg_166_1.duration_ = 8.1

		local var_166_0 = {
			ja = 8.1,
			ko = 6.9,
			zh = 6.566,
			en = 7.766
		}
		local var_166_1 = manager.audio:GetLocalizationFlag()

		if var_166_0[var_166_1] ~= nil then
			arg_166_1.duration_ = var_166_0[var_166_1]
		end

		SetActive(arg_166_1.tipsGo_, false)

		function arg_166_1.onSingleLineFinish_()
			arg_166_1.onSingleLineUpdate_ = nil
			arg_166_1.onSingleLineFinish_ = nil
			arg_166_1.state_ = "waiting"
		end

		function arg_166_1.playNext_(arg_168_0)
			if arg_168_0 == 1 then
				arg_166_0:Play104112042(arg_166_1)
			end
		end

		function arg_166_1.onSingleLineUpdate_(arg_169_0)
			local var_169_0 = arg_166_1.actors_["4010ui_story"]
			local var_169_1 = 0

			if var_169_1 < arg_166_1.time_ and arg_166_1.time_ <= var_169_1 + arg_169_0 and not isNil(var_169_0) and arg_166_1.var_.characterEffect4010ui_story == nil then
				arg_166_1.var_.characterEffect4010ui_story = var_169_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_169_2 = 0.1

			if var_169_1 <= arg_166_1.time_ and arg_166_1.time_ < var_169_1 + var_169_2 and not isNil(var_169_0) then
				local var_169_3 = (arg_166_1.time_ - var_169_1) / var_169_2

				if arg_166_1.var_.characterEffect4010ui_story and not isNil(var_169_0) then
					arg_166_1.var_.characterEffect4010ui_story.fillFlat = false
				end
			end

			if arg_166_1.time_ >= var_169_1 + var_169_2 and arg_166_1.time_ < var_169_1 + var_169_2 + arg_169_0 and not isNil(var_169_0) and arg_166_1.var_.characterEffect4010ui_story then
				arg_166_1.var_.characterEffect4010ui_story.fillFlat = false
			end

			local var_169_4 = 0

			if var_169_4 < arg_166_1.time_ and arg_166_1.time_ <= var_169_4 + arg_169_0 then
				arg_166_1:PlayTimeline("4010ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0104cva")
			end

			local var_169_5 = 0
			local var_169_6 = 0.65

			if var_169_5 < arg_166_1.time_ and arg_166_1.time_ <= var_169_5 + arg_169_0 then
				arg_166_1.talkMaxDuration = 0
				arg_166_1.dialogCg_.alpha = 1

				arg_166_1.dialog_:SetActive(true)
				SetActive(arg_166_1.leftNameGo_, true)

				local var_169_7 = arg_166_1:FormatText(StoryNameCfg[42].name)

				arg_166_1.leftNameTxt_.text = var_169_7

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_166_1.leftNameTxt_.transform)

				arg_166_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_166_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_166_1:RecordName(arg_166_1.leftNameTxt_.text)
				SetActive(arg_166_1.iconTrs_.gameObject, false)
				arg_166_1.callingController_:SetSelectedState("normal")

				local var_169_8 = arg_166_1:GetWordFromCfg(104112041)
				local var_169_9 = arg_166_1:FormatText(var_169_8.content)

				arg_166_1.text_.text = var_169_9

				LuaForUtil.ClearLinePrefixSymbol(arg_166_1.text_)

				local var_169_10 = 26
				local var_169_11 = utf8.len(var_169_9)
				local var_169_12 = var_169_10 <= 0 and var_169_6 or var_169_6 * (var_169_11 / var_169_10)

				if var_169_12 > 0 and var_169_6 < var_169_12 then
					arg_166_1.talkMaxDuration = var_169_12

					if var_169_12 + var_169_5 > arg_166_1.duration_ then
						arg_166_1.duration_ = var_169_12 + var_169_5
					end
				end

				arg_166_1.text_.text = var_169_9
				arg_166_1.typewritter.percent = 0

				arg_166_1.typewritter:SetDirty()
				arg_166_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_104112", "104112041", "story_v_out_104112.awb") ~= 0 then
					local var_169_13 = manager.audio:GetVoiceLength("story_v_out_104112", "104112041", "story_v_out_104112.awb") / 1000

					if var_169_13 + var_169_5 > arg_166_1.duration_ then
						arg_166_1.duration_ = var_169_13 + var_169_5
					end

					if var_169_8.prefab_name ~= "" and arg_166_1.actors_[var_169_8.prefab_name] ~= nil then
						local var_169_14 = LuaForUtil.PlayVoiceWithCriLipsync(arg_166_1.actors_[var_169_8.prefab_name].transform, "story_v_out_104112", "104112041", "story_v_out_104112.awb")

						arg_166_1:RecordAudio("104112041", var_169_14)
						arg_166_1:RecordAudio("104112041", var_169_14)
					else
						arg_166_1:AudioAction("play", "voice", "story_v_out_104112", "104112041", "story_v_out_104112.awb")
					end

					arg_166_1:RecordHistoryTalkVoice("story_v_out_104112", "104112041", "story_v_out_104112.awb")
				end

				arg_166_1:RecordContent(arg_166_1.text_.text)
			end

			local var_169_15 = math.max(var_169_6, arg_166_1.talkMaxDuration)

			if var_169_5 <= arg_166_1.time_ and arg_166_1.time_ < var_169_5 + var_169_15 then
				arg_166_1.typewritter.percent = (arg_166_1.time_ - var_169_5) / var_169_15

				arg_166_1.typewritter:SetDirty()
			end

			if arg_166_1.time_ >= var_169_5 + var_169_15 and arg_166_1.time_ < var_169_5 + var_169_15 + arg_169_0 then
				arg_166_1.typewritter.percent = 1

				arg_166_1.typewritter:SetDirty()
				arg_166_1:ShowNextGo(true)
			end
		end

		arg_166_1.nodeConfigList_ = {}

		arg_166_1:InitPlayNodeList()
	end,
	Play104112042 = function(arg_170_0, arg_170_1)
		arg_170_1.time_ = 0
		arg_170_1.frameCnt_ = 0
		arg_170_1.state_ = "playing"
		arg_170_1.curTalkId_ = 104112042
		arg_170_1.duration_ = 9.77

		local var_170_0 = {
			ja = 8.933,
			ko = 9.333,
			zh = 8.833,
			en = 9.766
		}
		local var_170_1 = manager.audio:GetLocalizationFlag()

		if var_170_0[var_170_1] ~= nil then
			arg_170_1.duration_ = var_170_0[var_170_1]
		end

		SetActive(arg_170_1.tipsGo_, false)

		function arg_170_1.onSingleLineFinish_()
			arg_170_1.onSingleLineUpdate_ = nil
			arg_170_1.onSingleLineFinish_ = nil
			arg_170_1.state_ = "waiting"
		end

		function arg_170_1.playNext_(arg_172_0)
			if arg_172_0 == 1 then
				arg_170_0:Play104112043(arg_170_1)
			end
		end

		function arg_170_1.onSingleLineUpdate_(arg_173_0)
			local var_173_0 = 0

			if var_173_0 < arg_170_1.time_ and arg_170_1.time_ <= var_173_0 + arg_173_0 then
				arg_170_1:PlayTimeline("4010ui_story", "StoryTimeline/CharAction/story4010/story4010action/4010action2_1")
			end

			local var_173_1 = 0

			if var_173_1 < arg_170_1.time_ and arg_170_1.time_ <= var_173_1 + arg_173_0 then
				arg_170_1:PlayTimeline("4010ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0104cva")
			end

			local var_173_2 = 0
			local var_173_3 = 1

			if var_173_2 < arg_170_1.time_ and arg_170_1.time_ <= var_173_2 + arg_173_0 then
				arg_170_1.talkMaxDuration = 0
				arg_170_1.dialogCg_.alpha = 1

				arg_170_1.dialog_:SetActive(true)
				SetActive(arg_170_1.leftNameGo_, true)

				local var_173_4 = arg_170_1:FormatText(StoryNameCfg[42].name)

				arg_170_1.leftNameTxt_.text = var_173_4

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_170_1.leftNameTxt_.transform)

				arg_170_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_170_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_170_1:RecordName(arg_170_1.leftNameTxt_.text)
				SetActive(arg_170_1.iconTrs_.gameObject, false)
				arg_170_1.callingController_:SetSelectedState("normal")

				local var_173_5 = arg_170_1:GetWordFromCfg(104112042)
				local var_173_6 = arg_170_1:FormatText(var_173_5.content)

				arg_170_1.text_.text = var_173_6

				LuaForUtil.ClearLinePrefixSymbol(arg_170_1.text_)

				local var_173_7 = 40
				local var_173_8 = utf8.len(var_173_6)
				local var_173_9 = var_173_7 <= 0 and var_173_3 or var_173_3 * (var_173_8 / var_173_7)

				if var_173_9 > 0 and var_173_3 < var_173_9 then
					arg_170_1.talkMaxDuration = var_173_9

					if var_173_9 + var_173_2 > arg_170_1.duration_ then
						arg_170_1.duration_ = var_173_9 + var_173_2
					end
				end

				arg_170_1.text_.text = var_173_6
				arg_170_1.typewritter.percent = 0

				arg_170_1.typewritter:SetDirty()
				arg_170_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_104112", "104112042", "story_v_out_104112.awb") ~= 0 then
					local var_173_10 = manager.audio:GetVoiceLength("story_v_out_104112", "104112042", "story_v_out_104112.awb") / 1000

					if var_173_10 + var_173_2 > arg_170_1.duration_ then
						arg_170_1.duration_ = var_173_10 + var_173_2
					end

					if var_173_5.prefab_name ~= "" and arg_170_1.actors_[var_173_5.prefab_name] ~= nil then
						local var_173_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_170_1.actors_[var_173_5.prefab_name].transform, "story_v_out_104112", "104112042", "story_v_out_104112.awb")

						arg_170_1:RecordAudio("104112042", var_173_11)
						arg_170_1:RecordAudio("104112042", var_173_11)
					else
						arg_170_1:AudioAction("play", "voice", "story_v_out_104112", "104112042", "story_v_out_104112.awb")
					end

					arg_170_1:RecordHistoryTalkVoice("story_v_out_104112", "104112042", "story_v_out_104112.awb")
				end

				arg_170_1:RecordContent(arg_170_1.text_.text)
			end

			local var_173_12 = math.max(var_173_3, arg_170_1.talkMaxDuration)

			if var_173_2 <= arg_170_1.time_ and arg_170_1.time_ < var_173_2 + var_173_12 then
				arg_170_1.typewritter.percent = (arg_170_1.time_ - var_173_2) / var_173_12

				arg_170_1.typewritter:SetDirty()
			end

			if arg_170_1.time_ >= var_173_2 + var_173_12 and arg_170_1.time_ < var_173_2 + var_173_12 + arg_173_0 then
				arg_170_1.typewritter.percent = 1

				arg_170_1.typewritter:SetDirty()
				arg_170_1:ShowNextGo(true)
			end
		end

		arg_170_1.nodeConfigList_ = {}

		arg_170_1:InitPlayNodeList()
	end,
	Play104112043 = function(arg_174_0, arg_174_1)
		arg_174_1.time_ = 0
		arg_174_1.frameCnt_ = 0
		arg_174_1.state_ = "playing"
		arg_174_1.curTalkId_ = 104112043
		arg_174_1.duration_ = 4.9

		local var_174_0 = {
			ja = 4.9,
			ko = 2.6,
			zh = 3.333,
			en = 2.6
		}
		local var_174_1 = manager.audio:GetLocalizationFlag()

		if var_174_0[var_174_1] ~= nil then
			arg_174_1.duration_ = var_174_0[var_174_1]
		end

		SetActive(arg_174_1.tipsGo_, false)

		function arg_174_1.onSingleLineFinish_()
			arg_174_1.onSingleLineUpdate_ = nil
			arg_174_1.onSingleLineFinish_ = nil
			arg_174_1.state_ = "waiting"
		end

		function arg_174_1.playNext_(arg_176_0)
			if arg_176_0 == 1 then
				arg_174_0:Play104112044(arg_174_1)
			end
		end

		function arg_174_1.onSingleLineUpdate_(arg_177_0)
			local var_177_0 = arg_174_1.actors_["4010ui_story"]
			local var_177_1 = 0

			if var_177_1 < arg_174_1.time_ and arg_174_1.time_ <= var_177_1 + arg_177_0 and not isNil(var_177_0) and arg_174_1.var_.characterEffect4010ui_story == nil then
				arg_174_1.var_.characterEffect4010ui_story = var_177_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_177_2 = 0.1

			if var_177_1 <= arg_174_1.time_ and arg_174_1.time_ < var_177_1 + var_177_2 and not isNil(var_177_0) then
				local var_177_3 = (arg_174_1.time_ - var_177_1) / var_177_2

				if arg_174_1.var_.characterEffect4010ui_story and not isNil(var_177_0) then
					local var_177_4 = Mathf.Lerp(0, 0.5, var_177_3)

					arg_174_1.var_.characterEffect4010ui_story.fillFlat = true
					arg_174_1.var_.characterEffect4010ui_story.fillRatio = var_177_4
				end
			end

			if arg_174_1.time_ >= var_177_1 + var_177_2 and arg_174_1.time_ < var_177_1 + var_177_2 + arg_177_0 and not isNil(var_177_0) and arg_174_1.var_.characterEffect4010ui_story then
				local var_177_5 = 0.5

				arg_174_1.var_.characterEffect4010ui_story.fillFlat = true
				arg_174_1.var_.characterEffect4010ui_story.fillRatio = var_177_5
			end

			local var_177_6 = arg_174_1.actors_["4010ui_story"].transform
			local var_177_7 = 0

			if var_177_7 < arg_174_1.time_ and arg_174_1.time_ <= var_177_7 + arg_177_0 then
				arg_174_1.var_.moveOldPos4010ui_story = var_177_6.localPosition
			end

			local var_177_8 = 0.001

			if var_177_7 <= arg_174_1.time_ and arg_174_1.time_ < var_177_7 + var_177_8 then
				local var_177_9 = (arg_174_1.time_ - var_177_7) / var_177_8
				local var_177_10 = Vector3.New(0, 100, 0)

				var_177_6.localPosition = Vector3.Lerp(arg_174_1.var_.moveOldPos4010ui_story, var_177_10, var_177_9)

				local var_177_11 = manager.ui.mainCamera.transform.position - var_177_6.position

				var_177_6.forward = Vector3.New(var_177_11.x, var_177_11.y, var_177_11.z)

				local var_177_12 = var_177_6.localEulerAngles

				var_177_12.z = 0
				var_177_12.x = 0
				var_177_6.localEulerAngles = var_177_12
			end

			if arg_174_1.time_ >= var_177_7 + var_177_8 and arg_174_1.time_ < var_177_7 + var_177_8 + arg_177_0 then
				var_177_6.localPosition = Vector3.New(0, 100, 0)

				local var_177_13 = manager.ui.mainCamera.transform.position - var_177_6.position

				var_177_6.forward = Vector3.New(var_177_13.x, var_177_13.y, var_177_13.z)

				local var_177_14 = var_177_6.localEulerAngles

				var_177_14.z = 0
				var_177_14.x = 0
				var_177_6.localEulerAngles = var_177_14
			end

			local var_177_15 = 0
			local var_177_16 = 0.3

			if var_177_15 < arg_174_1.time_ and arg_174_1.time_ <= var_177_15 + arg_177_0 then
				arg_174_1.talkMaxDuration = 0
				arg_174_1.dialogCg_.alpha = 1

				arg_174_1.dialog_:SetActive(true)
				SetActive(arg_174_1.leftNameGo_, true)

				local var_177_17 = arg_174_1:FormatText(StoryNameCfg[19].name)

				arg_174_1.leftNameTxt_.text = var_177_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_174_1.leftNameTxt_.transform)

				arg_174_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_174_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_174_1:RecordName(arg_174_1.leftNameTxt_.text)
				SetActive(arg_174_1.iconTrs_.gameObject, true)
				arg_174_1.iconController_:SetSelectedState("hero")

				arg_174_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_20301")

				arg_174_1.callingController_:SetSelectedState("normal")

				arg_174_1.keyicon_.color = Color.New(1, 1, 1)
				arg_174_1.icon_.color = Color.New(1, 1, 1)

				local var_177_18 = arg_174_1:GetWordFromCfg(104112043)
				local var_177_19 = arg_174_1:FormatText(var_177_18.content)

				arg_174_1.text_.text = var_177_19

				LuaForUtil.ClearLinePrefixSymbol(arg_174_1.text_)

				local var_177_20 = 12
				local var_177_21 = utf8.len(var_177_19)
				local var_177_22 = var_177_20 <= 0 and var_177_16 or var_177_16 * (var_177_21 / var_177_20)

				if var_177_22 > 0 and var_177_16 < var_177_22 then
					arg_174_1.talkMaxDuration = var_177_22

					if var_177_22 + var_177_15 > arg_174_1.duration_ then
						arg_174_1.duration_ = var_177_22 + var_177_15
					end
				end

				arg_174_1.text_.text = var_177_19
				arg_174_1.typewritter.percent = 0

				arg_174_1.typewritter:SetDirty()
				arg_174_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_104112", "104112043", "story_v_out_104112.awb") ~= 0 then
					local var_177_23 = manager.audio:GetVoiceLength("story_v_out_104112", "104112043", "story_v_out_104112.awb") / 1000

					if var_177_23 + var_177_15 > arg_174_1.duration_ then
						arg_174_1.duration_ = var_177_23 + var_177_15
					end

					if var_177_18.prefab_name ~= "" and arg_174_1.actors_[var_177_18.prefab_name] ~= nil then
						local var_177_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_174_1.actors_[var_177_18.prefab_name].transform, "story_v_out_104112", "104112043", "story_v_out_104112.awb")

						arg_174_1:RecordAudio("104112043", var_177_24)
						arg_174_1:RecordAudio("104112043", var_177_24)
					else
						arg_174_1:AudioAction("play", "voice", "story_v_out_104112", "104112043", "story_v_out_104112.awb")
					end

					arg_174_1:RecordHistoryTalkVoice("story_v_out_104112", "104112043", "story_v_out_104112.awb")
				end

				arg_174_1:RecordContent(arg_174_1.text_.text)
			end

			local var_177_25 = math.max(var_177_16, arg_174_1.talkMaxDuration)

			if var_177_15 <= arg_174_1.time_ and arg_174_1.time_ < var_177_15 + var_177_25 then
				arg_174_1.typewritter.percent = (arg_174_1.time_ - var_177_15) / var_177_25

				arg_174_1.typewritter:SetDirty()
			end

			if arg_174_1.time_ >= var_177_15 + var_177_25 and arg_174_1.time_ < var_177_15 + var_177_25 + arg_177_0 then
				arg_174_1.typewritter.percent = 1

				arg_174_1.typewritter:SetDirty()
				arg_174_1:ShowNextGo(true)
			end
		end

		arg_174_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "4010ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.033,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_174_1:InitPlayNodeList()
	end,
	Play104112044 = function(arg_178_0, arg_178_1)
		arg_178_1.time_ = 0
		arg_178_1.frameCnt_ = 0
		arg_178_1.state_ = "playing"
		arg_178_1.curTalkId_ = 104112044
		arg_178_1.duration_ = 8.1

		local var_178_0 = {
			ja = 6.2,
			ko = 8.1,
			zh = 7.166,
			en = 6.333
		}
		local var_178_1 = manager.audio:GetLocalizationFlag()

		if var_178_0[var_178_1] ~= nil then
			arg_178_1.duration_ = var_178_0[var_178_1]
		end

		SetActive(arg_178_1.tipsGo_, false)

		function arg_178_1.onSingleLineFinish_()
			arg_178_1.onSingleLineUpdate_ = nil
			arg_178_1.onSingleLineFinish_ = nil
			arg_178_1.state_ = "waiting"
		end

		function arg_178_1.playNext_(arg_180_0)
			if arg_180_0 == 1 then
				arg_178_0:Play104112045(arg_178_1)
			end
		end

		function arg_178_1.onSingleLineUpdate_(arg_181_0)
			local var_181_0 = 0
			local var_181_1 = 0.95

			if var_181_0 < arg_178_1.time_ and arg_178_1.time_ <= var_181_0 + arg_181_0 then
				arg_178_1.talkMaxDuration = 0
				arg_178_1.dialogCg_.alpha = 1

				arg_178_1.dialog_:SetActive(true)
				SetActive(arg_178_1.leftNameGo_, true)

				local var_181_2 = arg_178_1:FormatText(StoryNameCfg[33].name)

				arg_178_1.leftNameTxt_.text = var_181_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_178_1.leftNameTxt_.transform)

				arg_178_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_178_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_178_1:RecordName(arg_178_1.leftNameTxt_.text)
				SetActive(arg_178_1.iconTrs_.gameObject, true)
				arg_178_1.iconController_:SetSelectedState("hero")

				arg_178_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_20302")

				arg_178_1.callingController_:SetSelectedState("normal")

				arg_178_1.keyicon_.color = Color.New(1, 1, 1)
				arg_178_1.icon_.color = Color.New(1, 1, 1)

				local var_181_3 = arg_178_1:GetWordFromCfg(104112044)
				local var_181_4 = arg_178_1:FormatText(var_181_3.content)

				arg_178_1.text_.text = var_181_4

				LuaForUtil.ClearLinePrefixSymbol(arg_178_1.text_)

				local var_181_5 = 39
				local var_181_6 = utf8.len(var_181_4)
				local var_181_7 = var_181_5 <= 0 and var_181_1 or var_181_1 * (var_181_6 / var_181_5)

				if var_181_7 > 0 and var_181_1 < var_181_7 then
					arg_178_1.talkMaxDuration = var_181_7

					if var_181_7 + var_181_0 > arg_178_1.duration_ then
						arg_178_1.duration_ = var_181_7 + var_181_0
					end
				end

				arg_178_1.text_.text = var_181_4
				arg_178_1.typewritter.percent = 0

				arg_178_1.typewritter:SetDirty()
				arg_178_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_104112", "104112044", "story_v_out_104112.awb") ~= 0 then
					local var_181_8 = manager.audio:GetVoiceLength("story_v_out_104112", "104112044", "story_v_out_104112.awb") / 1000

					if var_181_8 + var_181_0 > arg_178_1.duration_ then
						arg_178_1.duration_ = var_181_8 + var_181_0
					end

					if var_181_3.prefab_name ~= "" and arg_178_1.actors_[var_181_3.prefab_name] ~= nil then
						local var_181_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_178_1.actors_[var_181_3.prefab_name].transform, "story_v_out_104112", "104112044", "story_v_out_104112.awb")

						arg_178_1:RecordAudio("104112044", var_181_9)
						arg_178_1:RecordAudio("104112044", var_181_9)
					else
						arg_178_1:AudioAction("play", "voice", "story_v_out_104112", "104112044", "story_v_out_104112.awb")
					end

					arg_178_1:RecordHistoryTalkVoice("story_v_out_104112", "104112044", "story_v_out_104112.awb")
				end

				arg_178_1:RecordContent(arg_178_1.text_.text)
			end

			local var_181_10 = math.max(var_181_1, arg_178_1.talkMaxDuration)

			if var_181_0 <= arg_178_1.time_ and arg_178_1.time_ < var_181_0 + var_181_10 then
				arg_178_1.typewritter.percent = (arg_178_1.time_ - var_181_0) / var_181_10

				arg_178_1.typewritter:SetDirty()
			end

			if arg_178_1.time_ >= var_181_0 + var_181_10 and arg_178_1.time_ < var_181_0 + var_181_10 + arg_181_0 then
				arg_178_1.typewritter.percent = 1

				arg_178_1.typewritter:SetDirty()
				arg_178_1:ShowNextGo(true)
			end
		end

		arg_178_1.nodeConfigList_ = {}

		arg_178_1:InitPlayNodeList()
	end,
	Play104112045 = function(arg_182_0, arg_182_1)
		arg_182_1.time_ = 0
		arg_182_1.frameCnt_ = 0
		arg_182_1.state_ = "playing"
		arg_182_1.curTalkId_ = 104112045
		arg_182_1.duration_ = 5.1

		local var_182_0 = {
			ja = 3.1,
			ko = 3.066,
			zh = 3.733,
			en = 5.1
		}
		local var_182_1 = manager.audio:GetLocalizationFlag()

		if var_182_0[var_182_1] ~= nil then
			arg_182_1.duration_ = var_182_0[var_182_1]
		end

		SetActive(arg_182_1.tipsGo_, false)

		function arg_182_1.onSingleLineFinish_()
			arg_182_1.onSingleLineUpdate_ = nil
			arg_182_1.onSingleLineFinish_ = nil
			arg_182_1.state_ = "waiting"
		end

		function arg_182_1.playNext_(arg_184_0)
			if arg_184_0 == 1 then
				arg_182_0:Play104112046(arg_182_1)
			end
		end

		function arg_182_1.onSingleLineUpdate_(arg_185_0)
			local var_185_0 = 0
			local var_185_1 = 0.425

			if var_185_0 < arg_182_1.time_ and arg_182_1.time_ <= var_185_0 + arg_185_0 then
				arg_182_1.talkMaxDuration = 0
				arg_182_1.dialogCg_.alpha = 1

				arg_182_1.dialog_:SetActive(true)
				SetActive(arg_182_1.leftNameGo_, true)

				local var_185_2 = arg_182_1:FormatText(StoryNameCfg[65].name)

				arg_182_1.leftNameTxt_.text = var_185_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_182_1.leftNameTxt_.transform)

				arg_182_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_182_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_182_1:RecordName(arg_182_1.leftNameTxt_.text)
				SetActive(arg_182_1.iconTrs_.gameObject, true)
				arg_182_1.iconController_:SetSelectedState("hero")

				arg_182_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_20301")

				arg_182_1.callingController_:SetSelectedState("normal")

				arg_182_1.keyicon_.color = Color.New(1, 1, 1)
				arg_182_1.icon_.color = Color.New(1, 1, 1)

				local var_185_3 = arg_182_1:GetWordFromCfg(104112045)
				local var_185_4 = arg_182_1:FormatText(var_185_3.content)

				arg_182_1.text_.text = var_185_4

				LuaForUtil.ClearLinePrefixSymbol(arg_182_1.text_)

				local var_185_5 = 17
				local var_185_6 = utf8.len(var_185_4)
				local var_185_7 = var_185_5 <= 0 and var_185_1 or var_185_1 * (var_185_6 / var_185_5)

				if var_185_7 > 0 and var_185_1 < var_185_7 then
					arg_182_1.talkMaxDuration = var_185_7

					if var_185_7 + var_185_0 > arg_182_1.duration_ then
						arg_182_1.duration_ = var_185_7 + var_185_0
					end
				end

				arg_182_1.text_.text = var_185_4
				arg_182_1.typewritter.percent = 0

				arg_182_1.typewritter:SetDirty()
				arg_182_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_104112", "104112045", "story_v_out_104112.awb") ~= 0 then
					local var_185_8 = manager.audio:GetVoiceLength("story_v_out_104112", "104112045", "story_v_out_104112.awb") / 1000

					if var_185_8 + var_185_0 > arg_182_1.duration_ then
						arg_182_1.duration_ = var_185_8 + var_185_0
					end

					if var_185_3.prefab_name ~= "" and arg_182_1.actors_[var_185_3.prefab_name] ~= nil then
						local var_185_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_182_1.actors_[var_185_3.prefab_name].transform, "story_v_out_104112", "104112045", "story_v_out_104112.awb")

						arg_182_1:RecordAudio("104112045", var_185_9)
						arg_182_1:RecordAudio("104112045", var_185_9)
					else
						arg_182_1:AudioAction("play", "voice", "story_v_out_104112", "104112045", "story_v_out_104112.awb")
					end

					arg_182_1:RecordHistoryTalkVoice("story_v_out_104112", "104112045", "story_v_out_104112.awb")
				end

				arg_182_1:RecordContent(arg_182_1.text_.text)
			end

			local var_185_10 = math.max(var_185_1, arg_182_1.talkMaxDuration)

			if var_185_0 <= arg_182_1.time_ and arg_182_1.time_ < var_185_0 + var_185_10 then
				arg_182_1.typewritter.percent = (arg_182_1.time_ - var_185_0) / var_185_10

				arg_182_1.typewritter:SetDirty()
			end

			if arg_182_1.time_ >= var_185_0 + var_185_10 and arg_182_1.time_ < var_185_0 + var_185_10 + arg_185_0 then
				arg_182_1.typewritter.percent = 1

				arg_182_1.typewritter:SetDirty()
				arg_182_1:ShowNextGo(true)
			end
		end

		arg_182_1.nodeConfigList_ = {}

		arg_182_1:InitPlayNodeList()
	end,
	Play104112046 = function(arg_186_0, arg_186_1)
		arg_186_1.time_ = 0
		arg_186_1.frameCnt_ = 0
		arg_186_1.state_ = "playing"
		arg_186_1.curTalkId_ = 104112046
		arg_186_1.duration_ = 7.83

		local var_186_0 = {
			ja = 4.166,
			ko = 2.833,
			zh = 1.999999999999,
			en = 7.833
		}
		local var_186_1 = manager.audio:GetLocalizationFlag()

		if var_186_0[var_186_1] ~= nil then
			arg_186_1.duration_ = var_186_0[var_186_1]
		end

		SetActive(arg_186_1.tipsGo_, false)

		function arg_186_1.onSingleLineFinish_()
			arg_186_1.onSingleLineUpdate_ = nil
			arg_186_1.onSingleLineFinish_ = nil
			arg_186_1.state_ = "waiting"
		end

		function arg_186_1.playNext_(arg_188_0)
			if arg_188_0 == 1 then
				arg_186_0:Play104112047(arg_186_1)
			end
		end

		function arg_186_1.onSingleLineUpdate_(arg_189_0)
			local var_189_0 = 0
			local var_189_1 = 1

			if var_189_0 < arg_186_1.time_ and arg_186_1.time_ <= var_189_0 + arg_189_0 then
				local var_189_2 = "play"
				local var_189_3 = "effect"

				arg_186_1:AudioAction(var_189_2, var_189_3, "se_story", "se_story_robot_short", "")
			end

			local var_189_4 = "2043_tpose"

			if arg_186_1.actors_[var_189_4] == nil then
				local var_189_5 = Asset.Load("Char/" .. "2043_tpose")

				if not isNil(var_189_5) then
					local var_189_6 = Object.Instantiate(Asset.Load("Char/" .. "2043_tpose"), arg_186_1.stage_.transform)

					var_189_6.name = var_189_4
					var_189_6.transform.localPosition = Vector3.New(0, 100, 0)
					arg_186_1.actors_[var_189_4] = var_189_6

					local var_189_7 = var_189_6:GetComponentInChildren(typeof(CharacterEffect))

					var_189_7.enabled = true

					local var_189_8 = GameObjectTools.GetOrAddComponent(var_189_6, typeof(DynamicBoneHelper))

					if var_189_8 then
						var_189_8:EnableDynamicBone(false)
					end

					arg_186_1:ShowWeapon(var_189_7.transform, false)

					arg_186_1.var_[var_189_4 .. "Animator"] = var_189_7.gameObject:GetComponent(typeof(UnityEngine.Animator))
					arg_186_1.var_[var_189_4 .. "Animator"].applyRootMotion = true
					arg_186_1.var_[var_189_4 .. "LipSync"] = var_189_7.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
				end
			end

			local var_189_9 = arg_186_1.actors_["2043_tpose"]
			local var_189_10 = 0

			if var_189_10 < arg_186_1.time_ and arg_186_1.time_ <= var_189_10 + arg_189_0 and not isNil(var_189_9) and arg_186_1.var_.characterEffect2043_tpose == nil then
				arg_186_1.var_.characterEffect2043_tpose = var_189_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_189_11 = 0.1

			if var_189_10 <= arg_186_1.time_ and arg_186_1.time_ < var_189_10 + var_189_11 and not isNil(var_189_9) then
				local var_189_12 = (arg_186_1.time_ - var_189_10) / var_189_11

				if arg_186_1.var_.characterEffect2043_tpose and not isNil(var_189_9) then
					arg_186_1.var_.characterEffect2043_tpose.fillFlat = false
				end
			end

			if arg_186_1.time_ >= var_189_10 + var_189_11 and arg_186_1.time_ < var_189_10 + var_189_11 + arg_189_0 and not isNil(var_189_9) and arg_186_1.var_.characterEffect2043_tpose then
				arg_186_1.var_.characterEffect2043_tpose.fillFlat = false
			end

			local var_189_13 = arg_186_1.actors_["2043_tpose"].transform
			local var_189_14 = 0

			if var_189_14 < arg_186_1.time_ and arg_186_1.time_ <= var_189_14 + arg_189_0 then
				arg_186_1.var_.moveOldPos2043_tpose = var_189_13.localPosition

				local var_189_15 = GameObjectTools.GetOrAddComponent(var_189_13.gameObject, typeof(DynamicBoneHelper))

				if var_189_15 then
					var_189_15:EnableDynamicBone(false)
				end
			end

			local var_189_16 = 0.001

			if var_189_14 <= arg_186_1.time_ and arg_186_1.time_ < var_189_14 + var_189_16 then
				local var_189_17 = (arg_186_1.time_ - var_189_14) / var_189_16
				local var_189_18 = Vector3.New(0, -0.95, -3.2)

				var_189_13.localPosition = Vector3.Lerp(arg_186_1.var_.moveOldPos2043_tpose, var_189_18, var_189_17)

				local var_189_19 = manager.ui.mainCamera.transform.position - var_189_13.position

				var_189_13.forward = Vector3.New(var_189_19.x, var_189_19.y, var_189_19.z)

				local var_189_20 = var_189_13.localEulerAngles

				var_189_20.z = 0
				var_189_20.x = 0
				var_189_13.localEulerAngles = var_189_20
			end

			if arg_186_1.time_ >= var_189_14 + var_189_16 and arg_186_1.time_ < var_189_14 + var_189_16 + arg_189_0 then
				var_189_13.localPosition = Vector3.New(0, -0.95, -3.2)

				local var_189_21 = manager.ui.mainCamera.transform.position - var_189_13.position

				var_189_13.forward = Vector3.New(var_189_21.x, var_189_21.y, var_189_21.z)

				local var_189_22 = var_189_13.localEulerAngles

				var_189_22.z = 0
				var_189_22.x = 0
				var_189_13.localEulerAngles = var_189_22

				local var_189_23 = GameObjectTools.GetOrAddComponent(var_189_13.gameObject, typeof(DynamicBoneHelper))

				if var_189_23 then
					var_189_23:EnableDynamicBone(true)
				end
			end

			local var_189_24 = 0

			if var_189_24 < arg_186_1.time_ and arg_186_1.time_ <= var_189_24 + arg_189_0 then
				arg_186_1:PlayTimeline("2043_tpose", "StoryTimeline/CharAction/story2043/story2043action/2043action1_1")
			end

			local var_189_25 = 0
			local var_189_26 = 0.225

			if var_189_25 < arg_186_1.time_ and arg_186_1.time_ <= var_189_25 + arg_189_0 then
				arg_186_1.talkMaxDuration = 0
				arg_186_1.dialogCg_.alpha = 1

				arg_186_1.dialog_:SetActive(true)
				SetActive(arg_186_1.leftNameGo_, true)

				local var_189_27 = arg_186_1:FormatText(StoryNameCfg[29].name)

				arg_186_1.leftNameTxt_.text = var_189_27

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_186_1.leftNameTxt_.transform)

				arg_186_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_186_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_186_1:RecordName(arg_186_1.leftNameTxt_.text)
				SetActive(arg_186_1.iconTrs_.gameObject, false)
				arg_186_1.callingController_:SetSelectedState("normal")

				local var_189_28 = arg_186_1:GetWordFromCfg(104112046)
				local var_189_29 = arg_186_1:FormatText(var_189_28.content)

				arg_186_1.text_.text = var_189_29

				LuaForUtil.ClearLinePrefixSymbol(arg_186_1.text_)

				local var_189_30 = 9
				local var_189_31 = utf8.len(var_189_29)
				local var_189_32 = var_189_30 <= 0 and var_189_26 or var_189_26 * (var_189_31 / var_189_30)

				if var_189_32 > 0 and var_189_26 < var_189_32 then
					arg_186_1.talkMaxDuration = var_189_32

					if var_189_32 + var_189_25 > arg_186_1.duration_ then
						arg_186_1.duration_ = var_189_32 + var_189_25
					end
				end

				arg_186_1.text_.text = var_189_29
				arg_186_1.typewritter.percent = 0

				arg_186_1.typewritter:SetDirty()
				arg_186_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_104112", "104112046", "story_v_out_104112.awb") ~= 0 then
					local var_189_33 = manager.audio:GetVoiceLength("story_v_out_104112", "104112046", "story_v_out_104112.awb") / 1000

					if var_189_33 + var_189_25 > arg_186_1.duration_ then
						arg_186_1.duration_ = var_189_33 + var_189_25
					end

					if var_189_28.prefab_name ~= "" and arg_186_1.actors_[var_189_28.prefab_name] ~= nil then
						local var_189_34 = LuaForUtil.PlayVoiceWithCriLipsync(arg_186_1.actors_[var_189_28.prefab_name].transform, "story_v_out_104112", "104112046", "story_v_out_104112.awb")

						arg_186_1:RecordAudio("104112046", var_189_34)
						arg_186_1:RecordAudio("104112046", var_189_34)
					else
						arg_186_1:AudioAction("play", "voice", "story_v_out_104112", "104112046", "story_v_out_104112.awb")
					end

					arg_186_1:RecordHistoryTalkVoice("story_v_out_104112", "104112046", "story_v_out_104112.awb")
				end

				arg_186_1:RecordContent(arg_186_1.text_.text)
			end

			local var_189_35 = math.max(var_189_26, arg_186_1.talkMaxDuration)

			if var_189_25 <= arg_186_1.time_ and arg_186_1.time_ < var_189_25 + var_189_35 then
				arg_186_1.typewritter.percent = (arg_186_1.time_ - var_189_25) / var_189_35

				arg_186_1.typewritter:SetDirty()
			end

			if arg_186_1.time_ >= var_189_25 + var_189_35 and arg_186_1.time_ < var_189_25 + var_189_35 + arg_189_0 then
				arg_186_1.typewritter.percent = 1

				arg_186_1.typewritter:SetDirty()
				arg_186_1:ShowNextGo(true)
			end
		end

		arg_186_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "2043_tpose",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.033,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_186_1:InitPlayNodeList()
	end,
	Play104112047 = function(arg_190_0, arg_190_1)
		arg_190_1.time_ = 0
		arg_190_1.frameCnt_ = 0
		arg_190_1.state_ = "playing"
		arg_190_1.curTalkId_ = 104112047
		arg_190_1.duration_ = 3.4

		local var_190_0 = {
			ja = 3.4,
			ko = 3.1,
			zh = 3.333,
			en = 2.833
		}
		local var_190_1 = manager.audio:GetLocalizationFlag()

		if var_190_0[var_190_1] ~= nil then
			arg_190_1.duration_ = var_190_0[var_190_1]
		end

		SetActive(arg_190_1.tipsGo_, false)

		function arg_190_1.onSingleLineFinish_()
			arg_190_1.onSingleLineUpdate_ = nil
			arg_190_1.onSingleLineFinish_ = nil
			arg_190_1.state_ = "waiting"
		end

		function arg_190_1.playNext_(arg_192_0)
			if arg_192_0 == 1 then
				arg_190_0:Play104112048(arg_190_1)
			end
		end

		function arg_190_1.onSingleLineUpdate_(arg_193_0)
			local var_193_0 = arg_190_1.actors_["3009ui_story"]
			local var_193_1 = 0

			if var_193_1 < arg_190_1.time_ and arg_190_1.time_ <= var_193_1 + arg_193_0 and not isNil(var_193_0) and arg_190_1.var_.characterEffect3009ui_story == nil then
				arg_190_1.var_.characterEffect3009ui_story = var_193_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_193_2 = 0.1

			if var_193_1 <= arg_190_1.time_ and arg_190_1.time_ < var_193_1 + var_193_2 and not isNil(var_193_0) then
				local var_193_3 = (arg_190_1.time_ - var_193_1) / var_193_2

				if arg_190_1.var_.characterEffect3009ui_story and not isNil(var_193_0) then
					arg_190_1.var_.characterEffect3009ui_story.fillFlat = false
				end
			end

			if arg_190_1.time_ >= var_193_1 + var_193_2 and arg_190_1.time_ < var_193_1 + var_193_2 + arg_193_0 and not isNil(var_193_0) and arg_190_1.var_.characterEffect3009ui_story then
				arg_190_1.var_.characterEffect3009ui_story.fillFlat = false
			end

			local var_193_4 = arg_190_1.actors_["2043_tpose"]
			local var_193_5 = 0

			if var_193_5 < arg_190_1.time_ and arg_190_1.time_ <= var_193_5 + arg_193_0 and not isNil(var_193_4) and arg_190_1.var_.characterEffect2043_tpose == nil then
				arg_190_1.var_.characterEffect2043_tpose = var_193_4:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_193_6 = 0.1

			if var_193_5 <= arg_190_1.time_ and arg_190_1.time_ < var_193_5 + var_193_6 and not isNil(var_193_4) then
				local var_193_7 = (arg_190_1.time_ - var_193_5) / var_193_6

				if arg_190_1.var_.characterEffect2043_tpose and not isNil(var_193_4) then
					local var_193_8 = Mathf.Lerp(0, 0.5, var_193_7)

					arg_190_1.var_.characterEffect2043_tpose.fillFlat = true
					arg_190_1.var_.characterEffect2043_tpose.fillRatio = var_193_8
				end
			end

			if arg_190_1.time_ >= var_193_5 + var_193_6 and arg_190_1.time_ < var_193_5 + var_193_6 + arg_193_0 and not isNil(var_193_4) and arg_190_1.var_.characterEffect2043_tpose then
				local var_193_9 = 0.5

				arg_190_1.var_.characterEffect2043_tpose.fillFlat = true
				arg_190_1.var_.characterEffect2043_tpose.fillRatio = var_193_9
			end

			local var_193_10 = arg_190_1.actors_["2043_tpose"].transform
			local var_193_11 = 0

			if var_193_11 < arg_190_1.time_ and arg_190_1.time_ <= var_193_11 + arg_193_0 then
				arg_190_1.var_.moveOldPos2043_tpose = var_193_10.localPosition

				local var_193_12 = GameObjectTools.GetOrAddComponent(var_193_10.gameObject, typeof(DynamicBoneHelper))

				if var_193_12 then
					var_193_12:EnableDynamicBone(false)
				end
			end

			local var_193_13 = 0.001

			if var_193_11 <= arg_190_1.time_ and arg_190_1.time_ < var_193_11 + var_193_13 then
				local var_193_14 = (arg_190_1.time_ - var_193_11) / var_193_13
				local var_193_15 = Vector3.New(0, 100, 0)

				var_193_10.localPosition = Vector3.Lerp(arg_190_1.var_.moveOldPos2043_tpose, var_193_15, var_193_14)

				local var_193_16 = manager.ui.mainCamera.transform.position - var_193_10.position

				var_193_10.forward = Vector3.New(var_193_16.x, var_193_16.y, var_193_16.z)

				local var_193_17 = var_193_10.localEulerAngles

				var_193_17.z = 0
				var_193_17.x = 0
				var_193_10.localEulerAngles = var_193_17
			end

			if arg_190_1.time_ >= var_193_11 + var_193_13 and arg_190_1.time_ < var_193_11 + var_193_13 + arg_193_0 then
				var_193_10.localPosition = Vector3.New(0, 100, 0)

				local var_193_18 = manager.ui.mainCamera.transform.position - var_193_10.position

				var_193_10.forward = Vector3.New(var_193_18.x, var_193_18.y, var_193_18.z)

				local var_193_19 = var_193_10.localEulerAngles

				var_193_19.z = 0
				var_193_19.x = 0
				var_193_10.localEulerAngles = var_193_19

				local var_193_20 = GameObjectTools.GetOrAddComponent(var_193_10.gameObject, typeof(DynamicBoneHelper))

				if var_193_20 then
					var_193_20:EnableDynamicBone(true)
				end
			end

			local var_193_21 = arg_190_1.actors_["3009ui_story"].transform
			local var_193_22 = 0

			if var_193_22 < arg_190_1.time_ and arg_190_1.time_ <= var_193_22 + arg_193_0 then
				arg_190_1.var_.moveOldPos3009ui_story = var_193_21.localPosition

				local var_193_23 = "3009ui_story"

				arg_190_1:ShowWeapon(arg_190_1.var_[var_193_23 .. "Animator"].transform, true)
			end

			local var_193_24 = 0.001

			if var_193_22 <= arg_190_1.time_ and arg_190_1.time_ < var_193_22 + var_193_24 then
				local var_193_25 = (arg_190_1.time_ - var_193_22) / var_193_24
				local var_193_26 = Vector3.New(0.7, -1.75, -4.8)

				var_193_21.localPosition = Vector3.Lerp(arg_190_1.var_.moveOldPos3009ui_story, var_193_26, var_193_25)

				local var_193_27 = manager.ui.mainCamera.transform.position - var_193_21.position

				var_193_21.forward = Vector3.New(var_193_27.x, var_193_27.y, var_193_27.z)

				local var_193_28 = var_193_21.localEulerAngles

				var_193_28.z = 0
				var_193_28.x = 0
				var_193_21.localEulerAngles = var_193_28
			end

			if arg_190_1.time_ >= var_193_22 + var_193_24 and arg_190_1.time_ < var_193_22 + var_193_24 + arg_193_0 then
				var_193_21.localPosition = Vector3.New(0.7, -1.75, -4.8)

				local var_193_29 = manager.ui.mainCamera.transform.position - var_193_21.position

				var_193_21.forward = Vector3.New(var_193_29.x, var_193_29.y, var_193_29.z)

				local var_193_30 = var_193_21.localEulerAngles

				var_193_30.z = 0
				var_193_30.x = 0
				var_193_21.localEulerAngles = var_193_30
			end

			local var_193_31 = 0

			if var_193_31 < arg_190_1.time_ and arg_190_1.time_ <= var_193_31 + arg_193_0 then
				arg_190_1:PlayTimeline("3009ui_story", "StoryTimeline/CharAction/story3009/story3009action/3009action1_1")
			end

			local var_193_32 = 0

			if var_193_32 < arg_190_1.time_ and arg_190_1.time_ <= var_193_32 + arg_193_0 then
				arg_190_1:PlayTimeline("3009ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0104cva")
			end

			local var_193_33 = 0
			local var_193_34 = 0.35

			if var_193_33 < arg_190_1.time_ and arg_190_1.time_ <= var_193_33 + arg_193_0 then
				arg_190_1.talkMaxDuration = 0
				arg_190_1.dialogCg_.alpha = 1

				arg_190_1.dialog_:SetActive(true)
				SetActive(arg_190_1.leftNameGo_, true)

				local var_193_35 = arg_190_1:FormatText(StoryNameCfg[43].name)

				arg_190_1.leftNameTxt_.text = var_193_35

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_190_1.leftNameTxt_.transform)

				arg_190_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_190_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_190_1:RecordName(arg_190_1.leftNameTxt_.text)
				SetActive(arg_190_1.iconTrs_.gameObject, false)
				arg_190_1.callingController_:SetSelectedState("normal")

				local var_193_36 = arg_190_1:GetWordFromCfg(104112047)
				local var_193_37 = arg_190_1:FormatText(var_193_36.content)

				arg_190_1.text_.text = var_193_37

				LuaForUtil.ClearLinePrefixSymbol(arg_190_1.text_)

				local var_193_38 = 14
				local var_193_39 = utf8.len(var_193_37)
				local var_193_40 = var_193_38 <= 0 and var_193_34 or var_193_34 * (var_193_39 / var_193_38)

				if var_193_40 > 0 and var_193_34 < var_193_40 then
					arg_190_1.talkMaxDuration = var_193_40

					if var_193_40 + var_193_33 > arg_190_1.duration_ then
						arg_190_1.duration_ = var_193_40 + var_193_33
					end
				end

				arg_190_1.text_.text = var_193_37
				arg_190_1.typewritter.percent = 0

				arg_190_1.typewritter:SetDirty()
				arg_190_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_104112", "104112047", "story_v_out_104112.awb") ~= 0 then
					local var_193_41 = manager.audio:GetVoiceLength("story_v_out_104112", "104112047", "story_v_out_104112.awb") / 1000

					if var_193_41 + var_193_33 > arg_190_1.duration_ then
						arg_190_1.duration_ = var_193_41 + var_193_33
					end

					if var_193_36.prefab_name ~= "" and arg_190_1.actors_[var_193_36.prefab_name] ~= nil then
						local var_193_42 = LuaForUtil.PlayVoiceWithCriLipsync(arg_190_1.actors_[var_193_36.prefab_name].transform, "story_v_out_104112", "104112047", "story_v_out_104112.awb")

						arg_190_1:RecordAudio("104112047", var_193_42)
						arg_190_1:RecordAudio("104112047", var_193_42)
					else
						arg_190_1:AudioAction("play", "voice", "story_v_out_104112", "104112047", "story_v_out_104112.awb")
					end

					arg_190_1:RecordHistoryTalkVoice("story_v_out_104112", "104112047", "story_v_out_104112.awb")
				end

				arg_190_1:RecordContent(arg_190_1.text_.text)
			end

			local var_193_43 = math.max(var_193_34, arg_190_1.talkMaxDuration)

			if var_193_33 <= arg_190_1.time_ and arg_190_1.time_ < var_193_33 + var_193_43 then
				arg_190_1.typewritter.percent = (arg_190_1.time_ - var_193_33) / var_193_43

				arg_190_1.typewritter:SetDirty()
			end

			if arg_190_1.time_ >= var_193_33 + var_193_43 and arg_190_1.time_ < var_193_33 + var_193_43 + arg_193_0 then
				arg_190_1.typewritter.percent = 1

				arg_190_1.typewritter:SetDirty()
				arg_190_1:ShowNextGo(true)
			end
		end

		arg_190_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "2043_tpose",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.033,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "3009ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.033,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_190_1:InitPlayNodeList()
	end,
	Play104112048 = function(arg_194_0, arg_194_1)
		arg_194_1.time_ = 0
		arg_194_1.frameCnt_ = 0
		arg_194_1.state_ = "playing"
		arg_194_1.curTalkId_ = 104112048
		arg_194_1.duration_ = 9.93

		local var_194_0 = {
			ja = 9.933,
			ko = 4.366,
			zh = 6.5,
			en = 3.966
		}
		local var_194_1 = manager.audio:GetLocalizationFlag()

		if var_194_0[var_194_1] ~= nil then
			arg_194_1.duration_ = var_194_0[var_194_1]
		end

		SetActive(arg_194_1.tipsGo_, false)

		function arg_194_1.onSingleLineFinish_()
			arg_194_1.onSingleLineUpdate_ = nil
			arg_194_1.onSingleLineFinish_ = nil
			arg_194_1.state_ = "waiting"
		end

		function arg_194_1.playNext_(arg_196_0)
			if arg_196_0 == 1 then
				arg_194_0:Play104112049(arg_194_1)
			end
		end

		function arg_194_1.onSingleLineUpdate_(arg_197_0)
			local var_197_0 = arg_194_1.actors_["4010ui_story"]
			local var_197_1 = 0

			if var_197_1 < arg_194_1.time_ and arg_194_1.time_ <= var_197_1 + arg_197_0 and not isNil(var_197_0) and arg_194_1.var_.characterEffect4010ui_story == nil then
				arg_194_1.var_.characterEffect4010ui_story = var_197_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_197_2 = 0.1

			if var_197_1 <= arg_194_1.time_ and arg_194_1.time_ < var_197_1 + var_197_2 and not isNil(var_197_0) then
				local var_197_3 = (arg_194_1.time_ - var_197_1) / var_197_2

				if arg_194_1.var_.characterEffect4010ui_story and not isNil(var_197_0) then
					arg_194_1.var_.characterEffect4010ui_story.fillFlat = false
				end
			end

			if arg_194_1.time_ >= var_197_1 + var_197_2 and arg_194_1.time_ < var_197_1 + var_197_2 + arg_197_0 and not isNil(var_197_0) and arg_194_1.var_.characterEffect4010ui_story then
				arg_194_1.var_.characterEffect4010ui_story.fillFlat = false
			end

			local var_197_4 = arg_194_1.actors_["3009ui_story"]
			local var_197_5 = 0

			if var_197_5 < arg_194_1.time_ and arg_194_1.time_ <= var_197_5 + arg_197_0 and not isNil(var_197_4) and arg_194_1.var_.characterEffect3009ui_story == nil then
				arg_194_1.var_.characterEffect3009ui_story = var_197_4:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_197_6 = 0.1

			if var_197_5 <= arg_194_1.time_ and arg_194_1.time_ < var_197_5 + var_197_6 and not isNil(var_197_4) then
				local var_197_7 = (arg_194_1.time_ - var_197_5) / var_197_6

				if arg_194_1.var_.characterEffect3009ui_story and not isNil(var_197_4) then
					local var_197_8 = Mathf.Lerp(0, 0.5, var_197_7)

					arg_194_1.var_.characterEffect3009ui_story.fillFlat = true
					arg_194_1.var_.characterEffect3009ui_story.fillRatio = var_197_8
				end
			end

			if arg_194_1.time_ >= var_197_5 + var_197_6 and arg_194_1.time_ < var_197_5 + var_197_6 + arg_197_0 and not isNil(var_197_4) and arg_194_1.var_.characterEffect3009ui_story then
				local var_197_9 = 0.5

				arg_194_1.var_.characterEffect3009ui_story.fillFlat = true
				arg_194_1.var_.characterEffect3009ui_story.fillRatio = var_197_9
			end

			local var_197_10 = arg_194_1.actors_["4010ui_story"].transform
			local var_197_11 = 0

			if var_197_11 < arg_194_1.time_ and arg_194_1.time_ <= var_197_11 + arg_197_0 then
				arg_194_1.var_.moveOldPos4010ui_story = var_197_10.localPosition
			end

			local var_197_12 = 0.001

			if var_197_11 <= arg_194_1.time_ and arg_194_1.time_ < var_197_11 + var_197_12 then
				local var_197_13 = (arg_194_1.time_ - var_197_11) / var_197_12
				local var_197_14 = Vector3.New(-0.7, -1.59, -5.2)

				var_197_10.localPosition = Vector3.Lerp(arg_194_1.var_.moveOldPos4010ui_story, var_197_14, var_197_13)

				local var_197_15 = manager.ui.mainCamera.transform.position - var_197_10.position

				var_197_10.forward = Vector3.New(var_197_15.x, var_197_15.y, var_197_15.z)

				local var_197_16 = var_197_10.localEulerAngles

				var_197_16.z = 0
				var_197_16.x = 0
				var_197_10.localEulerAngles = var_197_16
			end

			if arg_194_1.time_ >= var_197_11 + var_197_12 and arg_194_1.time_ < var_197_11 + var_197_12 + arg_197_0 then
				var_197_10.localPosition = Vector3.New(-0.7, -1.59, -5.2)

				local var_197_17 = manager.ui.mainCamera.transform.position - var_197_10.position

				var_197_10.forward = Vector3.New(var_197_17.x, var_197_17.y, var_197_17.z)

				local var_197_18 = var_197_10.localEulerAngles

				var_197_18.z = 0
				var_197_18.x = 0
				var_197_10.localEulerAngles = var_197_18
			end

			local var_197_19 = 0

			if var_197_19 < arg_194_1.time_ and arg_194_1.time_ <= var_197_19 + arg_197_0 then
				arg_194_1:PlayTimeline("4010ui_story", "StoryTimeline/CharAction/story4010/story4010action/4010action1_1")
			end

			local var_197_20 = 0

			if var_197_20 < arg_194_1.time_ and arg_194_1.time_ <= var_197_20 + arg_197_0 then
				arg_194_1:PlayTimeline("4010ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1104cva")
			end

			local var_197_21 = 0
			local var_197_22 = 0.525

			if var_197_21 < arg_194_1.time_ and arg_194_1.time_ <= var_197_21 + arg_197_0 then
				arg_194_1.talkMaxDuration = 0
				arg_194_1.dialogCg_.alpha = 1

				arg_194_1.dialog_:SetActive(true)
				SetActive(arg_194_1.leftNameGo_, true)

				local var_197_23 = arg_194_1:FormatText(StoryNameCfg[42].name)

				arg_194_1.leftNameTxt_.text = var_197_23

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_194_1.leftNameTxt_.transform)

				arg_194_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_194_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_194_1:RecordName(arg_194_1.leftNameTxt_.text)
				SetActive(arg_194_1.iconTrs_.gameObject, false)
				arg_194_1.callingController_:SetSelectedState("normal")

				local var_197_24 = arg_194_1:GetWordFromCfg(104112048)
				local var_197_25 = arg_194_1:FormatText(var_197_24.content)

				arg_194_1.text_.text = var_197_25

				LuaForUtil.ClearLinePrefixSymbol(arg_194_1.text_)

				local var_197_26 = 21
				local var_197_27 = utf8.len(var_197_25)
				local var_197_28 = var_197_26 <= 0 and var_197_22 or var_197_22 * (var_197_27 / var_197_26)

				if var_197_28 > 0 and var_197_22 < var_197_28 then
					arg_194_1.talkMaxDuration = var_197_28

					if var_197_28 + var_197_21 > arg_194_1.duration_ then
						arg_194_1.duration_ = var_197_28 + var_197_21
					end
				end

				arg_194_1.text_.text = var_197_25
				arg_194_1.typewritter.percent = 0

				arg_194_1.typewritter:SetDirty()
				arg_194_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_104112", "104112048", "story_v_out_104112.awb") ~= 0 then
					local var_197_29 = manager.audio:GetVoiceLength("story_v_out_104112", "104112048", "story_v_out_104112.awb") / 1000

					if var_197_29 + var_197_21 > arg_194_1.duration_ then
						arg_194_1.duration_ = var_197_29 + var_197_21
					end

					if var_197_24.prefab_name ~= "" and arg_194_1.actors_[var_197_24.prefab_name] ~= nil then
						local var_197_30 = LuaForUtil.PlayVoiceWithCriLipsync(arg_194_1.actors_[var_197_24.prefab_name].transform, "story_v_out_104112", "104112048", "story_v_out_104112.awb")

						arg_194_1:RecordAudio("104112048", var_197_30)
						arg_194_1:RecordAudio("104112048", var_197_30)
					else
						arg_194_1:AudioAction("play", "voice", "story_v_out_104112", "104112048", "story_v_out_104112.awb")
					end

					arg_194_1:RecordHistoryTalkVoice("story_v_out_104112", "104112048", "story_v_out_104112.awb")
				end

				arg_194_1:RecordContent(arg_194_1.text_.text)
			end

			local var_197_31 = math.max(var_197_22, arg_194_1.talkMaxDuration)

			if var_197_21 <= arg_194_1.time_ and arg_194_1.time_ < var_197_21 + var_197_31 then
				arg_194_1.typewritter.percent = (arg_194_1.time_ - var_197_21) / var_197_31

				arg_194_1.typewritter:SetDirty()
			end

			if arg_194_1.time_ >= var_197_21 + var_197_31 and arg_194_1.time_ < var_197_21 + var_197_31 + arg_197_0 then
				arg_194_1.typewritter.percent = 1

				arg_194_1.typewritter:SetDirty()
				arg_194_1:ShowNextGo(true)
			end
		end

		arg_194_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "4010ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.033,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_194_1:InitPlayNodeList()
	end,
	Play104112049 = function(arg_198_0, arg_198_1)
		arg_198_1.time_ = 0
		arg_198_1.frameCnt_ = 0
		arg_198_1.state_ = "playing"
		arg_198_1.curTalkId_ = 104112049
		arg_198_1.duration_ = 5.6

		local var_198_0 = {
			ja = 5.6,
			ko = 3.133,
			zh = 5.033,
			en = 5
		}
		local var_198_1 = manager.audio:GetLocalizationFlag()

		if var_198_0[var_198_1] ~= nil then
			arg_198_1.duration_ = var_198_0[var_198_1]
		end

		SetActive(arg_198_1.tipsGo_, false)

		function arg_198_1.onSingleLineFinish_()
			arg_198_1.onSingleLineUpdate_ = nil
			arg_198_1.onSingleLineFinish_ = nil
			arg_198_1.state_ = "waiting"
		end

		function arg_198_1.playNext_(arg_200_0)
			if arg_200_0 == 1 then
				arg_198_0:Play104112050(arg_198_1)
			end
		end

		function arg_198_1.onSingleLineUpdate_(arg_201_0)
			local var_201_0 = arg_198_1.actors_["3009ui_story"]
			local var_201_1 = 0

			if var_201_1 < arg_198_1.time_ and arg_198_1.time_ <= var_201_1 + arg_201_0 and not isNil(var_201_0) and arg_198_1.var_.characterEffect3009ui_story == nil then
				arg_198_1.var_.characterEffect3009ui_story = var_201_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_201_2 = 0.1

			if var_201_1 <= arg_198_1.time_ and arg_198_1.time_ < var_201_1 + var_201_2 and not isNil(var_201_0) then
				local var_201_3 = (arg_198_1.time_ - var_201_1) / var_201_2

				if arg_198_1.var_.characterEffect3009ui_story and not isNil(var_201_0) then
					arg_198_1.var_.characterEffect3009ui_story.fillFlat = false
				end
			end

			if arg_198_1.time_ >= var_201_1 + var_201_2 and arg_198_1.time_ < var_201_1 + var_201_2 + arg_201_0 and not isNil(var_201_0) and arg_198_1.var_.characterEffect3009ui_story then
				arg_198_1.var_.characterEffect3009ui_story.fillFlat = false
			end

			local var_201_4 = arg_198_1.actors_["4010ui_story"]
			local var_201_5 = 0

			if var_201_5 < arg_198_1.time_ and arg_198_1.time_ <= var_201_5 + arg_201_0 and not isNil(var_201_4) and arg_198_1.var_.characterEffect4010ui_story == nil then
				arg_198_1.var_.characterEffect4010ui_story = var_201_4:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_201_6 = 0.1

			if var_201_5 <= arg_198_1.time_ and arg_198_1.time_ < var_201_5 + var_201_6 and not isNil(var_201_4) then
				local var_201_7 = (arg_198_1.time_ - var_201_5) / var_201_6

				if arg_198_1.var_.characterEffect4010ui_story and not isNil(var_201_4) then
					local var_201_8 = Mathf.Lerp(0, 0.5, var_201_7)

					arg_198_1.var_.characterEffect4010ui_story.fillFlat = true
					arg_198_1.var_.characterEffect4010ui_story.fillRatio = var_201_8
				end
			end

			if arg_198_1.time_ >= var_201_5 + var_201_6 and arg_198_1.time_ < var_201_5 + var_201_6 + arg_201_0 and not isNil(var_201_4) and arg_198_1.var_.characterEffect4010ui_story then
				local var_201_9 = 0.5

				arg_198_1.var_.characterEffect4010ui_story.fillFlat = true
				arg_198_1.var_.characterEffect4010ui_story.fillRatio = var_201_9
			end

			local var_201_10 = 0

			if var_201_10 < arg_198_1.time_ and arg_198_1.time_ <= var_201_10 + arg_201_0 then
				arg_198_1:PlayTimeline("3009ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3104cva")
			end

			local var_201_11 = 0

			if var_201_11 < arg_198_1.time_ and arg_198_1.time_ <= var_201_11 + arg_201_0 then
				arg_198_1:PlayTimeline("3009ui_story", "StoryTimeline/CharAction/story3009/story3009action/3009action2_1")
			end

			local var_201_12 = 0
			local var_201_13 = 0.525

			if var_201_12 < arg_198_1.time_ and arg_198_1.time_ <= var_201_12 + arg_201_0 then
				arg_198_1.talkMaxDuration = 0
				arg_198_1.dialogCg_.alpha = 1

				arg_198_1.dialog_:SetActive(true)
				SetActive(arg_198_1.leftNameGo_, true)

				local var_201_14 = arg_198_1:FormatText(StoryNameCfg[43].name)

				arg_198_1.leftNameTxt_.text = var_201_14

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_198_1.leftNameTxt_.transform)

				arg_198_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_198_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_198_1:RecordName(arg_198_1.leftNameTxt_.text)
				SetActive(arg_198_1.iconTrs_.gameObject, false)
				arg_198_1.callingController_:SetSelectedState("normal")

				local var_201_15 = arg_198_1:GetWordFromCfg(104112049)
				local var_201_16 = arg_198_1:FormatText(var_201_15.content)

				arg_198_1.text_.text = var_201_16

				LuaForUtil.ClearLinePrefixSymbol(arg_198_1.text_)

				local var_201_17 = 28
				local var_201_18 = utf8.len(var_201_16)
				local var_201_19 = var_201_17 <= 0 and var_201_13 or var_201_13 * (var_201_18 / var_201_17)

				if var_201_19 > 0 and var_201_13 < var_201_19 then
					arg_198_1.talkMaxDuration = var_201_19

					if var_201_19 + var_201_12 > arg_198_1.duration_ then
						arg_198_1.duration_ = var_201_19 + var_201_12
					end
				end

				arg_198_1.text_.text = var_201_16
				arg_198_1.typewritter.percent = 0

				arg_198_1.typewritter:SetDirty()
				arg_198_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_104112", "104112049", "story_v_out_104112.awb") ~= 0 then
					local var_201_20 = manager.audio:GetVoiceLength("story_v_out_104112", "104112049", "story_v_out_104112.awb") / 1000

					if var_201_20 + var_201_12 > arg_198_1.duration_ then
						arg_198_1.duration_ = var_201_20 + var_201_12
					end

					if var_201_15.prefab_name ~= "" and arg_198_1.actors_[var_201_15.prefab_name] ~= nil then
						local var_201_21 = LuaForUtil.PlayVoiceWithCriLipsync(arg_198_1.actors_[var_201_15.prefab_name].transform, "story_v_out_104112", "104112049", "story_v_out_104112.awb")

						arg_198_1:RecordAudio("104112049", var_201_21)
						arg_198_1:RecordAudio("104112049", var_201_21)
					else
						arg_198_1:AudioAction("play", "voice", "story_v_out_104112", "104112049", "story_v_out_104112.awb")
					end

					arg_198_1:RecordHistoryTalkVoice("story_v_out_104112", "104112049", "story_v_out_104112.awb")
				end

				arg_198_1:RecordContent(arg_198_1.text_.text)
			end

			local var_201_22 = math.max(var_201_13, arg_198_1.talkMaxDuration)

			if var_201_12 <= arg_198_1.time_ and arg_198_1.time_ < var_201_12 + var_201_22 then
				arg_198_1.typewritter.percent = (arg_198_1.time_ - var_201_12) / var_201_22

				arg_198_1.typewritter:SetDirty()
			end

			if arg_198_1.time_ >= var_201_12 + var_201_22 and arg_198_1.time_ < var_201_12 + var_201_22 + arg_201_0 then
				arg_198_1.typewritter.percent = 1

				arg_198_1.typewritter:SetDirty()
				arg_198_1:ShowNextGo(true)
			end
		end

		arg_198_1.nodeConfigList_ = {}

		arg_198_1:InitPlayNodeList()
	end,
	Play104112050 = function(arg_202_0, arg_202_1)
		arg_202_1.time_ = 0
		arg_202_1.frameCnt_ = 0
		arg_202_1.state_ = "playing"
		arg_202_1.curTalkId_ = 104112050
		arg_202_1.duration_ = 7.47

		local var_202_0 = {
			ja = 5.833,
			ko = 5.9,
			zh = 7.466,
			en = 5.066
		}
		local var_202_1 = manager.audio:GetLocalizationFlag()

		if var_202_0[var_202_1] ~= nil then
			arg_202_1.duration_ = var_202_0[var_202_1]
		end

		SetActive(arg_202_1.tipsGo_, false)

		function arg_202_1.onSingleLineFinish_()
			arg_202_1.onSingleLineUpdate_ = nil
			arg_202_1.onSingleLineFinish_ = nil
			arg_202_1.state_ = "waiting"
			arg_202_1.auto_ = false
		end

		function arg_202_1.playNext_(arg_204_0)
			arg_202_1.onStoryFinished_()
		end

		function arg_202_1.onSingleLineUpdate_(arg_205_0)
			local var_205_0 = arg_202_1.actors_["4010ui_story"]
			local var_205_1 = 0

			if var_205_1 < arg_202_1.time_ and arg_202_1.time_ <= var_205_1 + arg_205_0 and not isNil(var_205_0) and arg_202_1.var_.characterEffect4010ui_story == nil then
				arg_202_1.var_.characterEffect4010ui_story = var_205_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_205_2 = 0.1

			if var_205_1 <= arg_202_1.time_ and arg_202_1.time_ < var_205_1 + var_205_2 and not isNil(var_205_0) then
				local var_205_3 = (arg_202_1.time_ - var_205_1) / var_205_2

				if arg_202_1.var_.characterEffect4010ui_story and not isNil(var_205_0) then
					arg_202_1.var_.characterEffect4010ui_story.fillFlat = false
				end
			end

			if arg_202_1.time_ >= var_205_1 + var_205_2 and arg_202_1.time_ < var_205_1 + var_205_2 + arg_205_0 and not isNil(var_205_0) and arg_202_1.var_.characterEffect4010ui_story then
				arg_202_1.var_.characterEffect4010ui_story.fillFlat = false
			end

			local var_205_4 = arg_202_1.actors_["3009ui_story"]
			local var_205_5 = 0

			if var_205_5 < arg_202_1.time_ and arg_202_1.time_ <= var_205_5 + arg_205_0 and not isNil(var_205_4) and arg_202_1.var_.characterEffect3009ui_story == nil then
				arg_202_1.var_.characterEffect3009ui_story = var_205_4:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_205_6 = 0.1

			if var_205_5 <= arg_202_1.time_ and arg_202_1.time_ < var_205_5 + var_205_6 and not isNil(var_205_4) then
				local var_205_7 = (arg_202_1.time_ - var_205_5) / var_205_6

				if arg_202_1.var_.characterEffect3009ui_story and not isNil(var_205_4) then
					local var_205_8 = Mathf.Lerp(0, 0.5, var_205_7)

					arg_202_1.var_.characterEffect3009ui_story.fillFlat = true
					arg_202_1.var_.characterEffect3009ui_story.fillRatio = var_205_8
				end
			end

			if arg_202_1.time_ >= var_205_5 + var_205_6 and arg_202_1.time_ < var_205_5 + var_205_6 + arg_205_0 and not isNil(var_205_4) and arg_202_1.var_.characterEffect3009ui_story then
				local var_205_9 = 0.5

				arg_202_1.var_.characterEffect3009ui_story.fillFlat = true
				arg_202_1.var_.characterEffect3009ui_story.fillRatio = var_205_9
			end

			local var_205_10 = 0

			if var_205_10 < arg_202_1.time_ and arg_202_1.time_ <= var_205_10 + arg_205_0 then
				arg_202_1:PlayTimeline("4010ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1104cva")
			end

			local var_205_11 = 0

			if var_205_11 < arg_202_1.time_ and arg_202_1.time_ <= var_205_11 + arg_205_0 then
				arg_202_1:PlayTimeline("4010ui_story", "StoryTimeline/CharAction/story4010/story4010action/4010action4_1")
			end

			local var_205_12 = 0
			local var_205_13 = 0.55

			if var_205_12 < arg_202_1.time_ and arg_202_1.time_ <= var_205_12 + arg_205_0 then
				arg_202_1.talkMaxDuration = 0
				arg_202_1.dialogCg_.alpha = 1

				arg_202_1.dialog_:SetActive(true)
				SetActive(arg_202_1.leftNameGo_, true)

				local var_205_14 = arg_202_1:FormatText(StoryNameCfg[42].name)

				arg_202_1.leftNameTxt_.text = var_205_14

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_202_1.leftNameTxt_.transform)

				arg_202_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_202_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_202_1:RecordName(arg_202_1.leftNameTxt_.text)
				SetActive(arg_202_1.iconTrs_.gameObject, false)
				arg_202_1.callingController_:SetSelectedState("normal")

				local var_205_15 = arg_202_1:GetWordFromCfg(104112050)
				local var_205_16 = arg_202_1:FormatText(var_205_15.content)

				arg_202_1.text_.text = var_205_16

				LuaForUtil.ClearLinePrefixSymbol(arg_202_1.text_)

				local var_205_17 = 22
				local var_205_18 = utf8.len(var_205_16)
				local var_205_19 = var_205_17 <= 0 and var_205_13 or var_205_13 * (var_205_18 / var_205_17)

				if var_205_19 > 0 and var_205_13 < var_205_19 then
					arg_202_1.talkMaxDuration = var_205_19

					if var_205_19 + var_205_12 > arg_202_1.duration_ then
						arg_202_1.duration_ = var_205_19 + var_205_12
					end
				end

				arg_202_1.text_.text = var_205_16
				arg_202_1.typewritter.percent = 0

				arg_202_1.typewritter:SetDirty()
				arg_202_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_104112", "104112050", "story_v_out_104112.awb") ~= 0 then
					local var_205_20 = manager.audio:GetVoiceLength("story_v_out_104112", "104112050", "story_v_out_104112.awb") / 1000

					if var_205_20 + var_205_12 > arg_202_1.duration_ then
						arg_202_1.duration_ = var_205_20 + var_205_12
					end

					if var_205_15.prefab_name ~= "" and arg_202_1.actors_[var_205_15.prefab_name] ~= nil then
						local var_205_21 = LuaForUtil.PlayVoiceWithCriLipsync(arg_202_1.actors_[var_205_15.prefab_name].transform, "story_v_out_104112", "104112050", "story_v_out_104112.awb")

						arg_202_1:RecordAudio("104112050", var_205_21)
						arg_202_1:RecordAudio("104112050", var_205_21)
					else
						arg_202_1:AudioAction("play", "voice", "story_v_out_104112", "104112050", "story_v_out_104112.awb")
					end

					arg_202_1:RecordHistoryTalkVoice("story_v_out_104112", "104112050", "story_v_out_104112.awb")
				end

				arg_202_1:RecordContent(arg_202_1.text_.text)
			end

			local var_205_22 = math.max(var_205_13, arg_202_1.talkMaxDuration)

			if var_205_12 <= arg_202_1.time_ and arg_202_1.time_ < var_205_12 + var_205_22 then
				arg_202_1.typewritter.percent = (arg_202_1.time_ - var_205_12) / var_205_22

				arg_202_1.typewritter:SetDirty()
			end

			if arg_202_1.time_ >= var_205_12 + var_205_22 and arg_202_1.time_ < var_205_12 + var_205_22 + arg_205_0 then
				arg_202_1.typewritter.percent = 1

				arg_202_1.typewritter:SetDirty()
				arg_202_1:ShowNextGo(true)
			end
		end

		arg_202_1.nodeConfigList_ = {}

		arg_202_1:InitPlayNodeList()
	end,
	assets = {
		"TextureConfig/Background/B14"
	},
	voices = {
		"story_v_out_104112.awb"
	}
}
