return {
	Play319501001 = function(arg_1_0, arg_1_1)
		arg_1_1.time_ = 0
		arg_1_1.frameCnt_ = 0
		arg_1_1.state_ = "playing"
		arg_1_1.curTalkId_ = 319501001
		arg_1_1.duration_ = 10.3

		local var_1_0 = {
			zh = 9.233,
			ja = 10.3
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
				arg_1_0:Play319501002(arg_1_1)
			end
		end

		function arg_1_1.onSingleLineUpdate_(arg_4_0)
			local var_4_0 = "ST72"

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
				local var_4_5 = arg_1_1.bgs_.ST72

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
					if iter_4_0 ~= "ST72" then
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

			local var_4_22 = "10069ui_story"

			if arg_1_1.actors_[var_4_22] == nil then
				local var_4_23 = Asset.Load("Char/" .. "10069ui_story")

				if not isNil(var_4_23) then
					local var_4_24 = Object.Instantiate(Asset.Load("Char/" .. "10069ui_story"), arg_1_1.stage_.transform)

					var_4_24.name = var_4_22
					var_4_24.transform.localPosition = Vector3.New(0, 100, 0)
					arg_1_1.actors_[var_4_22] = var_4_24

					local var_4_25 = var_4_24:GetComponentInChildren(typeof(CharacterEffect))

					var_4_25.enabled = true

					local var_4_26 = GameObjectTools.GetOrAddComponent(var_4_24, typeof(DynamicBoneHelper))

					if var_4_26 then
						var_4_26:EnableDynamicBone(false)
					end

					arg_1_1:ShowWeapon(var_4_25.transform, false)

					arg_1_1.var_[var_4_22 .. "Animator"] = var_4_25.gameObject:GetComponent(typeof(UnityEngine.Animator))
					arg_1_1.var_[var_4_22 .. "Animator"].applyRootMotion = true
					arg_1_1.var_[var_4_22 .. "LipSync"] = var_4_25.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
				end
			end

			local var_4_27 = arg_1_1.actors_["10069ui_story"].transform
			local var_4_28 = 1.8

			if var_4_28 < arg_1_1.time_ and arg_1_1.time_ <= var_4_28 + arg_4_0 then
				arg_1_1.var_.moveOldPos10069ui_story = var_4_27.localPosition
			end

			local var_4_29 = 0.001

			if var_4_28 <= arg_1_1.time_ and arg_1_1.time_ < var_4_28 + var_4_29 then
				local var_4_30 = (arg_1_1.time_ - var_4_28) / var_4_29
				local var_4_31 = Vector3.New(0, -1.08, -6.33)

				var_4_27.localPosition = Vector3.Lerp(arg_1_1.var_.moveOldPos10069ui_story, var_4_31, var_4_30)

				local var_4_32 = manager.ui.mainCamera.transform.position - var_4_27.position

				var_4_27.forward = Vector3.New(var_4_32.x, var_4_32.y, var_4_32.z)

				local var_4_33 = var_4_27.localEulerAngles

				var_4_33.z = 0
				var_4_33.x = 0
				var_4_27.localEulerAngles = var_4_33
			end

			if arg_1_1.time_ >= var_4_28 + var_4_29 and arg_1_1.time_ < var_4_28 + var_4_29 + arg_4_0 then
				var_4_27.localPosition = Vector3.New(0, -1.08, -6.33)

				local var_4_34 = manager.ui.mainCamera.transform.position - var_4_27.position

				var_4_27.forward = Vector3.New(var_4_34.x, var_4_34.y, var_4_34.z)

				local var_4_35 = var_4_27.localEulerAngles

				var_4_35.z = 0
				var_4_35.x = 0
				var_4_27.localEulerAngles = var_4_35
			end

			local var_4_36 = arg_1_1.actors_["10069ui_story"]
			local var_4_37 = 1.8

			if var_4_37 < arg_1_1.time_ and arg_1_1.time_ <= var_4_37 + arg_4_0 and not isNil(var_4_36) and arg_1_1.var_.characterEffect10069ui_story == nil then
				arg_1_1.var_.characterEffect10069ui_story = var_4_36:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_4_38 = 0.200000002980232

			if var_4_37 <= arg_1_1.time_ and arg_1_1.time_ < var_4_37 + var_4_38 and not isNil(var_4_36) then
				local var_4_39 = (arg_1_1.time_ - var_4_37) / var_4_38

				if arg_1_1.var_.characterEffect10069ui_story and not isNil(var_4_36) then
					arg_1_1.var_.characterEffect10069ui_story.fillFlat = false
				end
			end

			if arg_1_1.time_ >= var_4_37 + var_4_38 and arg_1_1.time_ < var_4_37 + var_4_38 + arg_4_0 and not isNil(var_4_36) and arg_1_1.var_.characterEffect10069ui_story then
				arg_1_1.var_.characterEffect10069ui_story.fillFlat = false
			end

			local var_4_40 = 1.8

			if var_4_40 < arg_1_1.time_ and arg_1_1.time_ <= var_4_40 + arg_4_0 then
				arg_1_1:PlayTimeline("10069ui_story", "StoryTimeline/CharAction/story10056/story10056action/10056action1_1")
			end

			local var_4_41 = 1.8

			if var_4_41 < arg_1_1.time_ and arg_1_1.time_ <= var_4_41 + arg_4_0 then
				arg_1_1:PlayTimeline("10069ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_4_42 = 0
			local var_4_43 = 0.0666666666666667

			if var_4_42 < arg_1_1.time_ and arg_1_1.time_ <= var_4_42 + arg_4_0 then
				local var_4_44 = "play"
				local var_4_45 = "music"

				arg_1_1:AudioAction(var_4_44, var_4_45, "ui_battle", "ui_battle_stopbgm", "")

				local var_4_46 = ""
				local var_4_47 = manager.audio:GetAudioName("ui_battle", "ui_battle_stopbgm")

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

			local var_4_48 = 0.1
			local var_4_49 = 1

			if var_4_48 < arg_1_1.time_ and arg_1_1.time_ <= var_4_48 + arg_4_0 then
				local var_4_50 = "play"
				local var_4_51 = "music"

				arg_1_1:AudioAction(var_4_50, var_4_51, "bgm_activity_3_0_story_hospital", "bgm_activity_3_0_story_hospital", "bgm_activity_3_0_story_hospital.awb")

				local var_4_52 = ""
				local var_4_53 = manager.audio:GetAudioName("bgm_activity_3_0_story_hospital", "bgm_activity_3_0_story_hospital")

				if var_4_53 ~= "" then
					if arg_1_1.bgmTxt_.text ~= var_4_53 and arg_1_1.bgmTxt_.text ~= "" then
						if arg_1_1.bgmTxt2_.text ~= "" then
							arg_1_1.bgmTxt_.text = arg_1_1.bgmTxt2_.text
						end

						arg_1_1.bgmTxt2_.text = var_4_53

						arg_1_1.musicChangeAnimator_:Play("music_change", 0, 0)
					else
						arg_1_1.bgmTxt_.text = var_4_53
						arg_1_1.bgmTxt2_.text = var_4_53
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

			local var_4_54 = 1.8
			local var_4_55 = 1.05

			if var_4_54 < arg_1_1.time_ and arg_1_1.time_ <= var_4_54 + arg_4_0 then
				arg_1_1.talkMaxDuration = 0

				arg_1_1.dialog_:SetActive(true)

				arg_1_1.dialogCg_.alpha = 0

				local var_4_56 = LeanTween.value(arg_1_1.dialog_, 0, 1, 0.3)

				var_4_56:setOnUpdate(LuaHelper.FloatAction(function(arg_7_0)
					arg_1_1.dialogCg_.alpha = arg_7_0
				end))
				var_4_56:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_1_1.dialog_)
					var_4_56:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_1_1.duration_ = arg_1_1.duration_ + 0.3

				SetActive(arg_1_1.leftNameGo_, true)

				local var_4_57 = arg_1_1:FormatText(StoryNameCfg[693].name)

				arg_1_1.leftNameTxt_.text = var_4_57

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_1_1.leftNameTxt_.transform)

				arg_1_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_1_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_1_1:RecordName(arg_1_1.leftNameTxt_.text)
				SetActive(arg_1_1.iconTrs_.gameObject, false)
				arg_1_1.callingController_:SetSelectedState("normal")

				local var_4_58 = arg_1_1:GetWordFromCfg(319501001)
				local var_4_59 = arg_1_1:FormatText(var_4_58.content)

				arg_1_1.text_.text = var_4_59

				LuaForUtil.ClearLinePrefixSymbol(arg_1_1.text_)

				local var_4_60 = 41
				local var_4_61 = utf8.len(var_4_59)
				local var_4_62 = var_4_60 <= 0 and var_4_55 or var_4_55 * (var_4_61 / var_4_60)

				if var_4_62 > 0 and var_4_55 < var_4_62 then
					arg_1_1.talkMaxDuration = var_4_62
					var_4_54 = var_4_54 + 0.3

					if var_4_62 + var_4_54 > arg_1_1.duration_ then
						arg_1_1.duration_ = var_4_62 + var_4_54
					end
				end

				arg_1_1.text_.text = var_4_59
				arg_1_1.typewritter.percent = 0

				arg_1_1.typewritter:SetDirty()
				arg_1_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_319501", "319501001", "story_v_out_319501.awb") ~= 0 then
					local var_4_63 = manager.audio:GetVoiceLength("story_v_out_319501", "319501001", "story_v_out_319501.awb") / 1000

					if var_4_63 + var_4_54 > arg_1_1.duration_ then
						arg_1_1.duration_ = var_4_63 + var_4_54
					end

					if var_4_58.prefab_name ~= "" and arg_1_1.actors_[var_4_58.prefab_name] ~= nil then
						local var_4_64 = LuaForUtil.PlayVoiceWithCriLipsync(arg_1_1.actors_[var_4_58.prefab_name].transform, "story_v_out_319501", "319501001", "story_v_out_319501.awb")

						arg_1_1:RecordAudio("319501001", var_4_64)
						arg_1_1:RecordAudio("319501001", var_4_64)
					else
						arg_1_1:AudioAction("play", "voice", "story_v_out_319501", "319501001", "story_v_out_319501.awb")
					end

					arg_1_1:RecordHistoryTalkVoice("story_v_out_319501", "319501001", "story_v_out_319501.awb")
				end

				arg_1_1:RecordContent(arg_1_1.text_.text)
			end

			local var_4_65 = var_4_54 + 0.3
			local var_4_66 = math.max(var_4_55, arg_1_1.talkMaxDuration)

			if var_4_65 <= arg_1_1.time_ and arg_1_1.time_ < var_4_65 + var_4_66 then
				arg_1_1.typewritter.percent = (arg_1_1.time_ - var_4_65) / var_4_66

				arg_1_1.typewritter:SetDirty()
			end

			if arg_1_1.time_ >= var_4_65 + var_4_66 and arg_1_1.time_ < var_4_65 + var_4_66 + arg_4_0 then
				arg_1_1.typewritter.percent = 1

				arg_1_1.typewritter:SetDirty()
				arg_1_1:ShowNextGo(true)
			end
		end

		arg_1_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10069ui_story",
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
	Play319501002 = function(arg_9_0, arg_9_1)
		arg_9_1.time_ = 0
		arg_9_1.frameCnt_ = 0
		arg_9_1.state_ = "playing"
		arg_9_1.curTalkId_ = 319501002
		arg_9_1.duration_ = 5.5

		local var_9_0 = {
			zh = 4.266,
			ja = 5.5
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
				arg_9_0:Play319501003(arg_9_1)
			end
		end

		function arg_9_1.onSingleLineUpdate_(arg_12_0)
			local var_12_0 = "1084ui_story"

			if arg_9_1.actors_[var_12_0] == nil then
				local var_12_1 = Asset.Load("Char/" .. "1084ui_story")

				if not isNil(var_12_1) then
					local var_12_2 = Object.Instantiate(Asset.Load("Char/" .. "1084ui_story"), arg_9_1.stage_.transform)

					var_12_2.name = var_12_0
					var_12_2.transform.localPosition = Vector3.New(0, 100, 0)
					arg_9_1.actors_[var_12_0] = var_12_2

					local var_12_3 = var_12_2:GetComponentInChildren(typeof(CharacterEffect))

					var_12_3.enabled = true

					local var_12_4 = GameObjectTools.GetOrAddComponent(var_12_2, typeof(DynamicBoneHelper))

					if var_12_4 then
						var_12_4:EnableDynamicBone(false)
					end

					arg_9_1:ShowWeapon(var_12_3.transform, false)

					arg_9_1.var_[var_12_0 .. "Animator"] = var_12_3.gameObject:GetComponent(typeof(UnityEngine.Animator))
					arg_9_1.var_[var_12_0 .. "Animator"].applyRootMotion = true
					arg_9_1.var_[var_12_0 .. "LipSync"] = var_12_3.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
				end
			end

			local var_12_5 = arg_9_1.actors_["1084ui_story"].transform
			local var_12_6 = 0

			if var_12_6 < arg_9_1.time_ and arg_9_1.time_ <= var_12_6 + arg_12_0 then
				arg_9_1.var_.moveOldPos1084ui_story = var_12_5.localPosition
			end

			local var_12_7 = 0.001

			if var_12_6 <= arg_9_1.time_ and arg_9_1.time_ < var_12_6 + var_12_7 then
				local var_12_8 = (arg_9_1.time_ - var_12_6) / var_12_7
				local var_12_9 = Vector3.New(0.7, -0.97, -6)

				var_12_5.localPosition = Vector3.Lerp(arg_9_1.var_.moveOldPos1084ui_story, var_12_9, var_12_8)

				local var_12_10 = manager.ui.mainCamera.transform.position - var_12_5.position

				var_12_5.forward = Vector3.New(var_12_10.x, var_12_10.y, var_12_10.z)

				local var_12_11 = var_12_5.localEulerAngles

				var_12_11.z = 0
				var_12_11.x = 0
				var_12_5.localEulerAngles = var_12_11
			end

			if arg_9_1.time_ >= var_12_6 + var_12_7 and arg_9_1.time_ < var_12_6 + var_12_7 + arg_12_0 then
				var_12_5.localPosition = Vector3.New(0.7, -0.97, -6)

				local var_12_12 = manager.ui.mainCamera.transform.position - var_12_5.position

				var_12_5.forward = Vector3.New(var_12_12.x, var_12_12.y, var_12_12.z)

				local var_12_13 = var_12_5.localEulerAngles

				var_12_13.z = 0
				var_12_13.x = 0
				var_12_5.localEulerAngles = var_12_13
			end

			local var_12_14 = arg_9_1.actors_["1084ui_story"]
			local var_12_15 = 0

			if var_12_15 < arg_9_1.time_ and arg_9_1.time_ <= var_12_15 + arg_12_0 and not isNil(var_12_14) and arg_9_1.var_.characterEffect1084ui_story == nil then
				arg_9_1.var_.characterEffect1084ui_story = var_12_14:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_12_16 = 0.200000002980232

			if var_12_15 <= arg_9_1.time_ and arg_9_1.time_ < var_12_15 + var_12_16 and not isNil(var_12_14) then
				local var_12_17 = (arg_9_1.time_ - var_12_15) / var_12_16

				if arg_9_1.var_.characterEffect1084ui_story and not isNil(var_12_14) then
					arg_9_1.var_.characterEffect1084ui_story.fillFlat = false
				end
			end

			if arg_9_1.time_ >= var_12_15 + var_12_16 and arg_9_1.time_ < var_12_15 + var_12_16 + arg_12_0 and not isNil(var_12_14) and arg_9_1.var_.characterEffect1084ui_story then
				arg_9_1.var_.characterEffect1084ui_story.fillFlat = false
			end

			local var_12_18 = 0

			if var_12_18 < arg_9_1.time_ and arg_9_1.time_ <= var_12_18 + arg_12_0 then
				arg_9_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/story1084/story1084action/1084action1_1")
			end

			local var_12_19 = 0

			if var_12_19 < arg_9_1.time_ and arg_9_1.time_ <= var_12_19 + arg_12_0 then
				arg_9_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_12_20 = arg_9_1.actors_["10069ui_story"].transform
			local var_12_21 = 0

			if var_12_21 < arg_9_1.time_ and arg_9_1.time_ <= var_12_21 + arg_12_0 then
				arg_9_1.var_.moveOldPos10069ui_story = var_12_20.localPosition
			end

			local var_12_22 = 0.001

			if var_12_21 <= arg_9_1.time_ and arg_9_1.time_ < var_12_21 + var_12_22 then
				local var_12_23 = (arg_9_1.time_ - var_12_21) / var_12_22
				local var_12_24 = Vector3.New(-0.7, -1.08, -6.33)

				var_12_20.localPosition = Vector3.Lerp(arg_9_1.var_.moveOldPos10069ui_story, var_12_24, var_12_23)

				local var_12_25 = manager.ui.mainCamera.transform.position - var_12_20.position

				var_12_20.forward = Vector3.New(var_12_25.x, var_12_25.y, var_12_25.z)

				local var_12_26 = var_12_20.localEulerAngles

				var_12_26.z = 0
				var_12_26.x = 0
				var_12_20.localEulerAngles = var_12_26
			end

			if arg_9_1.time_ >= var_12_21 + var_12_22 and arg_9_1.time_ < var_12_21 + var_12_22 + arg_12_0 then
				var_12_20.localPosition = Vector3.New(-0.7, -1.08, -6.33)

				local var_12_27 = manager.ui.mainCamera.transform.position - var_12_20.position

				var_12_20.forward = Vector3.New(var_12_27.x, var_12_27.y, var_12_27.z)

				local var_12_28 = var_12_20.localEulerAngles

				var_12_28.z = 0
				var_12_28.x = 0
				var_12_20.localEulerAngles = var_12_28
			end

			local var_12_29 = arg_9_1.actors_["10069ui_story"]
			local var_12_30 = 0

			if var_12_30 < arg_9_1.time_ and arg_9_1.time_ <= var_12_30 + arg_12_0 and not isNil(var_12_29) and arg_9_1.var_.characterEffect10069ui_story == nil then
				arg_9_1.var_.characterEffect10069ui_story = var_12_29:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_12_31 = 0.200000002980232

			if var_12_30 <= arg_9_1.time_ and arg_9_1.time_ < var_12_30 + var_12_31 and not isNil(var_12_29) then
				local var_12_32 = (arg_9_1.time_ - var_12_30) / var_12_31

				if arg_9_1.var_.characterEffect10069ui_story and not isNil(var_12_29) then
					local var_12_33 = Mathf.Lerp(0, 0.5, var_12_32)

					arg_9_1.var_.characterEffect10069ui_story.fillFlat = true
					arg_9_1.var_.characterEffect10069ui_story.fillRatio = var_12_33
				end
			end

			if arg_9_1.time_ >= var_12_30 + var_12_31 and arg_9_1.time_ < var_12_30 + var_12_31 + arg_12_0 and not isNil(var_12_29) and arg_9_1.var_.characterEffect10069ui_story then
				local var_12_34 = 0.5

				arg_9_1.var_.characterEffect10069ui_story.fillFlat = true
				arg_9_1.var_.characterEffect10069ui_story.fillRatio = var_12_34
			end

			local var_12_35 = 0
			local var_12_36 = 0.45

			if var_12_35 < arg_9_1.time_ and arg_9_1.time_ <= var_12_35 + arg_12_0 then
				arg_9_1.talkMaxDuration = 0
				arg_9_1.dialogCg_.alpha = 1

				arg_9_1.dialog_:SetActive(true)
				SetActive(arg_9_1.leftNameGo_, true)

				local var_12_37 = arg_9_1:FormatText(StoryNameCfg[6].name)

				arg_9_1.leftNameTxt_.text = var_12_37

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_9_1.leftNameTxt_.transform)

				arg_9_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_9_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_9_1:RecordName(arg_9_1.leftNameTxt_.text)
				SetActive(arg_9_1.iconTrs_.gameObject, false)
				arg_9_1.callingController_:SetSelectedState("normal")

				local var_12_38 = arg_9_1:GetWordFromCfg(319501002)
				local var_12_39 = arg_9_1:FormatText(var_12_38.content)

				arg_9_1.text_.text = var_12_39

				LuaForUtil.ClearLinePrefixSymbol(arg_9_1.text_)

				local var_12_40 = 18
				local var_12_41 = utf8.len(var_12_39)
				local var_12_42 = var_12_40 <= 0 and var_12_36 or var_12_36 * (var_12_41 / var_12_40)

				if var_12_42 > 0 and var_12_36 < var_12_42 then
					arg_9_1.talkMaxDuration = var_12_42

					if var_12_42 + var_12_35 > arg_9_1.duration_ then
						arg_9_1.duration_ = var_12_42 + var_12_35
					end
				end

				arg_9_1.text_.text = var_12_39
				arg_9_1.typewritter.percent = 0

				arg_9_1.typewritter:SetDirty()
				arg_9_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_319501", "319501002", "story_v_out_319501.awb") ~= 0 then
					local var_12_43 = manager.audio:GetVoiceLength("story_v_out_319501", "319501002", "story_v_out_319501.awb") / 1000

					if var_12_43 + var_12_35 > arg_9_1.duration_ then
						arg_9_1.duration_ = var_12_43 + var_12_35
					end

					if var_12_38.prefab_name ~= "" and arg_9_1.actors_[var_12_38.prefab_name] ~= nil then
						local var_12_44 = LuaForUtil.PlayVoiceWithCriLipsync(arg_9_1.actors_[var_12_38.prefab_name].transform, "story_v_out_319501", "319501002", "story_v_out_319501.awb")

						arg_9_1:RecordAudio("319501002", var_12_44)
						arg_9_1:RecordAudio("319501002", var_12_44)
					else
						arg_9_1:AudioAction("play", "voice", "story_v_out_319501", "319501002", "story_v_out_319501.awb")
					end

					arg_9_1:RecordHistoryTalkVoice("story_v_out_319501", "319501002", "story_v_out_319501.awb")
				end

				arg_9_1:RecordContent(arg_9_1.text_.text)
			end

			local var_12_45 = math.max(var_12_36, arg_9_1.talkMaxDuration)

			if var_12_35 <= arg_9_1.time_ and arg_9_1.time_ < var_12_35 + var_12_45 then
				arg_9_1.typewritter.percent = (arg_9_1.time_ - var_12_35) / var_12_45

				arg_9_1.typewritter:SetDirty()
			end

			if arg_9_1.time_ >= var_12_35 + var_12_45 and arg_9_1.time_ < var_12_35 + var_12_45 + arg_12_0 then
				arg_9_1.typewritter.percent = 1

				arg_9_1.typewritter:SetDirty()
				arg_9_1:ShowNextGo(true)
			end
		end

		arg_9_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1084ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "10069ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_9_1:InitPlayNodeList()
	end,
	Play319501003 = function(arg_13_0, arg_13_1)
		arg_13_1.time_ = 0
		arg_13_1.frameCnt_ = 0
		arg_13_1.state_ = "playing"
		arg_13_1.curTalkId_ = 319501003
		arg_13_1.duration_ = 3.7

		local var_13_0 = {
			zh = 1.466,
			ja = 3.7
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
				arg_13_0:Play319501004(arg_13_1)
			end
		end

		function arg_13_1.onSingleLineUpdate_(arg_16_0)
			local var_16_0 = 0
			local var_16_1 = 0.125

			if var_16_0 < arg_13_1.time_ and arg_13_1.time_ <= var_16_0 + arg_16_0 then
				arg_13_1.talkMaxDuration = 0
				arg_13_1.dialogCg_.alpha = 1

				arg_13_1.dialog_:SetActive(true)
				SetActive(arg_13_1.leftNameGo_, true)

				local var_16_2 = arg_13_1:FormatText(StoryNameCfg[6].name)

				arg_13_1.leftNameTxt_.text = var_16_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_13_1.leftNameTxt_.transform)

				arg_13_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_13_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_13_1:RecordName(arg_13_1.leftNameTxt_.text)
				SetActive(arg_13_1.iconTrs_.gameObject, false)
				arg_13_1.callingController_:SetSelectedState("normal")

				local var_16_3 = arg_13_1:GetWordFromCfg(319501003)
				local var_16_4 = arg_13_1:FormatText(var_16_3.content)

				arg_13_1.text_.text = var_16_4

				LuaForUtil.ClearLinePrefixSymbol(arg_13_1.text_)

				local var_16_5 = 5
				local var_16_6 = utf8.len(var_16_4)
				local var_16_7 = var_16_5 <= 0 and var_16_1 or var_16_1 * (var_16_6 / var_16_5)

				if var_16_7 > 0 and var_16_1 < var_16_7 then
					arg_13_1.talkMaxDuration = var_16_7

					if var_16_7 + var_16_0 > arg_13_1.duration_ then
						arg_13_1.duration_ = var_16_7 + var_16_0
					end
				end

				arg_13_1.text_.text = var_16_4
				arg_13_1.typewritter.percent = 0

				arg_13_1.typewritter:SetDirty()
				arg_13_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_319501", "319501003", "story_v_out_319501.awb") ~= 0 then
					local var_16_8 = manager.audio:GetVoiceLength("story_v_out_319501", "319501003", "story_v_out_319501.awb") / 1000

					if var_16_8 + var_16_0 > arg_13_1.duration_ then
						arg_13_1.duration_ = var_16_8 + var_16_0
					end

					if var_16_3.prefab_name ~= "" and arg_13_1.actors_[var_16_3.prefab_name] ~= nil then
						local var_16_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_13_1.actors_[var_16_3.prefab_name].transform, "story_v_out_319501", "319501003", "story_v_out_319501.awb")

						arg_13_1:RecordAudio("319501003", var_16_9)
						arg_13_1:RecordAudio("319501003", var_16_9)
					else
						arg_13_1:AudioAction("play", "voice", "story_v_out_319501", "319501003", "story_v_out_319501.awb")
					end

					arg_13_1:RecordHistoryTalkVoice("story_v_out_319501", "319501003", "story_v_out_319501.awb")
				end

				arg_13_1:RecordContent(arg_13_1.text_.text)
			end

			local var_16_10 = math.max(var_16_1, arg_13_1.talkMaxDuration)

			if var_16_0 <= arg_13_1.time_ and arg_13_1.time_ < var_16_0 + var_16_10 then
				arg_13_1.typewritter.percent = (arg_13_1.time_ - var_16_0) / var_16_10

				arg_13_1.typewritter:SetDirty()
			end

			if arg_13_1.time_ >= var_16_0 + var_16_10 and arg_13_1.time_ < var_16_0 + var_16_10 + arg_16_0 then
				arg_13_1.typewritter.percent = 1

				arg_13_1.typewritter:SetDirty()
				arg_13_1:ShowNextGo(true)
			end
		end

		arg_13_1.nodeConfigList_ = {}

		arg_13_1:InitPlayNodeList()
	end,
	Play319501004 = function(arg_17_0, arg_17_1)
		arg_17_1.time_ = 0
		arg_17_1.frameCnt_ = 0
		arg_17_1.state_ = "playing"
		arg_17_1.curTalkId_ = 319501004
		arg_17_1.duration_ = 5

		SetActive(arg_17_1.tipsGo_, false)

		function arg_17_1.onSingleLineFinish_()
			arg_17_1.onSingleLineUpdate_ = nil
			arg_17_1.onSingleLineFinish_ = nil
			arg_17_1.state_ = "waiting"
		end

		function arg_17_1.playNext_(arg_19_0)
			if arg_19_0 == 1 then
				arg_17_0:Play319501005(arg_17_1)
			end
		end

		function arg_17_1.onSingleLineUpdate_(arg_20_0)
			local var_20_0 = arg_17_1.actors_["1084ui_story"]
			local var_20_1 = 0

			if var_20_1 < arg_17_1.time_ and arg_17_1.time_ <= var_20_1 + arg_20_0 and not isNil(var_20_0) and arg_17_1.var_.characterEffect1084ui_story == nil then
				arg_17_1.var_.characterEffect1084ui_story = var_20_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_20_2 = 0.200000002980232

			if var_20_1 <= arg_17_1.time_ and arg_17_1.time_ < var_20_1 + var_20_2 and not isNil(var_20_0) then
				local var_20_3 = (arg_17_1.time_ - var_20_1) / var_20_2

				if arg_17_1.var_.characterEffect1084ui_story and not isNil(var_20_0) then
					local var_20_4 = Mathf.Lerp(0, 0.5, var_20_3)

					arg_17_1.var_.characterEffect1084ui_story.fillFlat = true
					arg_17_1.var_.characterEffect1084ui_story.fillRatio = var_20_4
				end
			end

			if arg_17_1.time_ >= var_20_1 + var_20_2 and arg_17_1.time_ < var_20_1 + var_20_2 + arg_20_0 and not isNil(var_20_0) and arg_17_1.var_.characterEffect1084ui_story then
				local var_20_5 = 0.5

				arg_17_1.var_.characterEffect1084ui_story.fillFlat = true
				arg_17_1.var_.characterEffect1084ui_story.fillRatio = var_20_5
			end

			local var_20_6 = 0
			local var_20_7 = 0.9

			if var_20_6 < arg_17_1.time_ and arg_17_1.time_ <= var_20_6 + arg_20_0 then
				arg_17_1.talkMaxDuration = 0
				arg_17_1.dialogCg_.alpha = 1

				arg_17_1.dialog_:SetActive(true)
				SetActive(arg_17_1.leftNameGo_, false)

				arg_17_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_17_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_17_1:RecordName(arg_17_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_17_1.iconTrs_.gameObject, false)
				arg_17_1.callingController_:SetSelectedState("normal")

				local var_20_8 = arg_17_1:GetWordFromCfg(319501004)
				local var_20_9 = arg_17_1:FormatText(var_20_8.content)

				arg_17_1.text_.text = var_20_9

				LuaForUtil.ClearLinePrefixSymbol(arg_17_1.text_)

				local var_20_10 = 36
				local var_20_11 = utf8.len(var_20_9)
				local var_20_12 = var_20_10 <= 0 and var_20_7 or var_20_7 * (var_20_11 / var_20_10)

				if var_20_12 > 0 and var_20_7 < var_20_12 then
					arg_17_1.talkMaxDuration = var_20_12

					if var_20_12 + var_20_6 > arg_17_1.duration_ then
						arg_17_1.duration_ = var_20_12 + var_20_6
					end
				end

				arg_17_1.text_.text = var_20_9
				arg_17_1.typewritter.percent = 0

				arg_17_1.typewritter:SetDirty()
				arg_17_1:ShowNextGo(false)
				arg_17_1:RecordContent(arg_17_1.text_.text)
			end

			local var_20_13 = math.max(var_20_7, arg_17_1.talkMaxDuration)

			if var_20_6 <= arg_17_1.time_ and arg_17_1.time_ < var_20_6 + var_20_13 then
				arg_17_1.typewritter.percent = (arg_17_1.time_ - var_20_6) / var_20_13

				arg_17_1.typewritter:SetDirty()
			end

			if arg_17_1.time_ >= var_20_6 + var_20_13 and arg_17_1.time_ < var_20_6 + var_20_13 + arg_20_0 then
				arg_17_1.typewritter.percent = 1

				arg_17_1.typewritter:SetDirty()
				arg_17_1:ShowNextGo(true)
			end
		end

		arg_17_1.nodeConfigList_ = {}

		arg_17_1:InitPlayNodeList()
	end,
	Play319501005 = function(arg_21_0, arg_21_1)
		arg_21_1.time_ = 0
		arg_21_1.frameCnt_ = 0
		arg_21_1.state_ = "playing"
		arg_21_1.curTalkId_ = 319501005
		arg_21_1.duration_ = 10.6

		local var_21_0 = {
			zh = 3.533,
			ja = 10.6
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
				arg_21_0:Play319501006(arg_21_1)
			end
		end

		function arg_21_1.onSingleLineUpdate_(arg_24_0)
			local var_24_0 = arg_21_1.actors_["10069ui_story"]
			local var_24_1 = 0

			if var_24_1 < arg_21_1.time_ and arg_21_1.time_ <= var_24_1 + arg_24_0 and not isNil(var_24_0) and arg_21_1.var_.characterEffect10069ui_story == nil then
				arg_21_1.var_.characterEffect10069ui_story = var_24_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_24_2 = 0.200000002980232

			if var_24_1 <= arg_21_1.time_ and arg_21_1.time_ < var_24_1 + var_24_2 and not isNil(var_24_0) then
				local var_24_3 = (arg_21_1.time_ - var_24_1) / var_24_2

				if arg_21_1.var_.characterEffect10069ui_story and not isNil(var_24_0) then
					arg_21_1.var_.characterEffect10069ui_story.fillFlat = false
				end
			end

			if arg_21_1.time_ >= var_24_1 + var_24_2 and arg_21_1.time_ < var_24_1 + var_24_2 + arg_24_0 and not isNil(var_24_0) and arg_21_1.var_.characterEffect10069ui_story then
				arg_21_1.var_.characterEffect10069ui_story.fillFlat = false
			end

			local var_24_4 = 0
			local var_24_5 = 0.425

			if var_24_4 < arg_21_1.time_ and arg_21_1.time_ <= var_24_4 + arg_24_0 then
				arg_21_1.talkMaxDuration = 0
				arg_21_1.dialogCg_.alpha = 1

				arg_21_1.dialog_:SetActive(true)
				SetActive(arg_21_1.leftNameGo_, true)

				local var_24_6 = arg_21_1:FormatText(StoryNameCfg[693].name)

				arg_21_1.leftNameTxt_.text = var_24_6

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_21_1.leftNameTxt_.transform)

				arg_21_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_21_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_21_1:RecordName(arg_21_1.leftNameTxt_.text)
				SetActive(arg_21_1.iconTrs_.gameObject, false)
				arg_21_1.callingController_:SetSelectedState("normal")

				local var_24_7 = arg_21_1:GetWordFromCfg(319501005)
				local var_24_8 = arg_21_1:FormatText(var_24_7.content)

				arg_21_1.text_.text = var_24_8

				LuaForUtil.ClearLinePrefixSymbol(arg_21_1.text_)

				local var_24_9 = 17
				local var_24_10 = utf8.len(var_24_8)
				local var_24_11 = var_24_9 <= 0 and var_24_5 or var_24_5 * (var_24_10 / var_24_9)

				if var_24_11 > 0 and var_24_5 < var_24_11 then
					arg_21_1.talkMaxDuration = var_24_11

					if var_24_11 + var_24_4 > arg_21_1.duration_ then
						arg_21_1.duration_ = var_24_11 + var_24_4
					end
				end

				arg_21_1.text_.text = var_24_8
				arg_21_1.typewritter.percent = 0

				arg_21_1.typewritter:SetDirty()
				arg_21_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_319501", "319501005", "story_v_out_319501.awb") ~= 0 then
					local var_24_12 = manager.audio:GetVoiceLength("story_v_out_319501", "319501005", "story_v_out_319501.awb") / 1000

					if var_24_12 + var_24_4 > arg_21_1.duration_ then
						arg_21_1.duration_ = var_24_12 + var_24_4
					end

					if var_24_7.prefab_name ~= "" and arg_21_1.actors_[var_24_7.prefab_name] ~= nil then
						local var_24_13 = LuaForUtil.PlayVoiceWithCriLipsync(arg_21_1.actors_[var_24_7.prefab_name].transform, "story_v_out_319501", "319501005", "story_v_out_319501.awb")

						arg_21_1:RecordAudio("319501005", var_24_13)
						arg_21_1:RecordAudio("319501005", var_24_13)
					else
						arg_21_1:AudioAction("play", "voice", "story_v_out_319501", "319501005", "story_v_out_319501.awb")
					end

					arg_21_1:RecordHistoryTalkVoice("story_v_out_319501", "319501005", "story_v_out_319501.awb")
				end

				arg_21_1:RecordContent(arg_21_1.text_.text)
			end

			local var_24_14 = math.max(var_24_5, arg_21_1.talkMaxDuration)

			if var_24_4 <= arg_21_1.time_ and arg_21_1.time_ < var_24_4 + var_24_14 then
				arg_21_1.typewritter.percent = (arg_21_1.time_ - var_24_4) / var_24_14

				arg_21_1.typewritter:SetDirty()
			end

			if arg_21_1.time_ >= var_24_4 + var_24_14 and arg_21_1.time_ < var_24_4 + var_24_14 + arg_24_0 then
				arg_21_1.typewritter.percent = 1

				arg_21_1.typewritter:SetDirty()
				arg_21_1:ShowNextGo(true)
			end
		end

		arg_21_1.nodeConfigList_ = {}

		arg_21_1:InitPlayNodeList()
	end,
	Play319501006 = function(arg_25_0, arg_25_1)
		arg_25_1.time_ = 0
		arg_25_1.frameCnt_ = 0
		arg_25_1.state_ = "playing"
		arg_25_1.curTalkId_ = 319501006
		arg_25_1.duration_ = 2.4

		local var_25_0 = {
			zh = 1.999999999999,
			ja = 2.4
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
				arg_25_0:Play319501007(arg_25_1)
			end
		end

		function arg_25_1.onSingleLineUpdate_(arg_28_0)
			local var_28_0 = arg_25_1.actors_["1084ui_story"]
			local var_28_1 = 0

			if var_28_1 < arg_25_1.time_ and arg_25_1.time_ <= var_28_1 + arg_28_0 and not isNil(var_28_0) and arg_25_1.var_.characterEffect1084ui_story == nil then
				arg_25_1.var_.characterEffect1084ui_story = var_28_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_28_2 = 0.200000002980232

			if var_28_1 <= arg_25_1.time_ and arg_25_1.time_ < var_28_1 + var_28_2 and not isNil(var_28_0) then
				local var_28_3 = (arg_25_1.time_ - var_28_1) / var_28_2

				if arg_25_1.var_.characterEffect1084ui_story and not isNil(var_28_0) then
					arg_25_1.var_.characterEffect1084ui_story.fillFlat = false
				end
			end

			if arg_25_1.time_ >= var_28_1 + var_28_2 and arg_25_1.time_ < var_28_1 + var_28_2 + arg_28_0 and not isNil(var_28_0) and arg_25_1.var_.characterEffect1084ui_story then
				arg_25_1.var_.characterEffect1084ui_story.fillFlat = false
			end

			local var_28_4 = 0

			if var_28_4 < arg_25_1.time_ and arg_25_1.time_ <= var_28_4 + arg_28_0 then
				arg_25_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/story1084/story1084action/1084action4_1")
			end

			local var_28_5 = 0

			if var_28_5 < arg_25_1.time_ and arg_25_1.time_ <= var_28_5 + arg_28_0 then
				arg_25_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface2101cva")
			end

			local var_28_6 = arg_25_1.actors_["10069ui_story"]
			local var_28_7 = 0

			if var_28_7 < arg_25_1.time_ and arg_25_1.time_ <= var_28_7 + arg_28_0 and not isNil(var_28_6) and arg_25_1.var_.characterEffect10069ui_story == nil then
				arg_25_1.var_.characterEffect10069ui_story = var_28_6:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_28_8 = 0.200000002980232

			if var_28_7 <= arg_25_1.time_ and arg_25_1.time_ < var_28_7 + var_28_8 and not isNil(var_28_6) then
				local var_28_9 = (arg_25_1.time_ - var_28_7) / var_28_8

				if arg_25_1.var_.characterEffect10069ui_story and not isNil(var_28_6) then
					local var_28_10 = Mathf.Lerp(0, 0.5, var_28_9)

					arg_25_1.var_.characterEffect10069ui_story.fillFlat = true
					arg_25_1.var_.characterEffect10069ui_story.fillRatio = var_28_10
				end
			end

			if arg_25_1.time_ >= var_28_7 + var_28_8 and arg_25_1.time_ < var_28_7 + var_28_8 + arg_28_0 and not isNil(var_28_6) and arg_25_1.var_.characterEffect10069ui_story then
				local var_28_11 = 0.5

				arg_25_1.var_.characterEffect10069ui_story.fillFlat = true
				arg_25_1.var_.characterEffect10069ui_story.fillRatio = var_28_11
			end

			local var_28_12 = 0
			local var_28_13 = 0.1

			if var_28_12 < arg_25_1.time_ and arg_25_1.time_ <= var_28_12 + arg_28_0 then
				arg_25_1.talkMaxDuration = 0
				arg_25_1.dialogCg_.alpha = 1

				arg_25_1.dialog_:SetActive(true)
				SetActive(arg_25_1.leftNameGo_, true)

				local var_28_14 = arg_25_1:FormatText(StoryNameCfg[6].name)

				arg_25_1.leftNameTxt_.text = var_28_14

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_25_1.leftNameTxt_.transform)

				arg_25_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_25_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_25_1:RecordName(arg_25_1.leftNameTxt_.text)
				SetActive(arg_25_1.iconTrs_.gameObject, false)
				arg_25_1.callingController_:SetSelectedState("normal")

				local var_28_15 = arg_25_1:GetWordFromCfg(319501006)
				local var_28_16 = arg_25_1:FormatText(var_28_15.content)

				arg_25_1.text_.text = var_28_16

				LuaForUtil.ClearLinePrefixSymbol(arg_25_1.text_)

				local var_28_17 = 4
				local var_28_18 = utf8.len(var_28_16)
				local var_28_19 = var_28_17 <= 0 and var_28_13 or var_28_13 * (var_28_18 / var_28_17)

				if var_28_19 > 0 and var_28_13 < var_28_19 then
					arg_25_1.talkMaxDuration = var_28_19

					if var_28_19 + var_28_12 > arg_25_1.duration_ then
						arg_25_1.duration_ = var_28_19 + var_28_12
					end
				end

				arg_25_1.text_.text = var_28_16
				arg_25_1.typewritter.percent = 0

				arg_25_1.typewritter:SetDirty()
				arg_25_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_319501", "319501006", "story_v_out_319501.awb") ~= 0 then
					local var_28_20 = manager.audio:GetVoiceLength("story_v_out_319501", "319501006", "story_v_out_319501.awb") / 1000

					if var_28_20 + var_28_12 > arg_25_1.duration_ then
						arg_25_1.duration_ = var_28_20 + var_28_12
					end

					if var_28_15.prefab_name ~= "" and arg_25_1.actors_[var_28_15.prefab_name] ~= nil then
						local var_28_21 = LuaForUtil.PlayVoiceWithCriLipsync(arg_25_1.actors_[var_28_15.prefab_name].transform, "story_v_out_319501", "319501006", "story_v_out_319501.awb")

						arg_25_1:RecordAudio("319501006", var_28_21)
						arg_25_1:RecordAudio("319501006", var_28_21)
					else
						arg_25_1:AudioAction("play", "voice", "story_v_out_319501", "319501006", "story_v_out_319501.awb")
					end

					arg_25_1:RecordHistoryTalkVoice("story_v_out_319501", "319501006", "story_v_out_319501.awb")
				end

				arg_25_1:RecordContent(arg_25_1.text_.text)
			end

			local var_28_22 = math.max(var_28_13, arg_25_1.talkMaxDuration)

			if var_28_12 <= arg_25_1.time_ and arg_25_1.time_ < var_28_12 + var_28_22 then
				arg_25_1.typewritter.percent = (arg_25_1.time_ - var_28_12) / var_28_22

				arg_25_1.typewritter:SetDirty()
			end

			if arg_25_1.time_ >= var_28_12 + var_28_22 and arg_25_1.time_ < var_28_12 + var_28_22 + arg_28_0 then
				arg_25_1.typewritter.percent = 1

				arg_25_1.typewritter:SetDirty()
				arg_25_1:ShowNextGo(true)
			end
		end

		arg_25_1.nodeConfigList_ = {}

		arg_25_1:InitPlayNodeList()
	end,
	Play319501007 = function(arg_29_0, arg_29_1)
		arg_29_1.time_ = 0
		arg_29_1.frameCnt_ = 0
		arg_29_1.state_ = "playing"
		arg_29_1.curTalkId_ = 319501007
		arg_29_1.duration_ = 2

		SetActive(arg_29_1.tipsGo_, false)

		function arg_29_1.onSingleLineFinish_()
			arg_29_1.onSingleLineUpdate_ = nil
			arg_29_1.onSingleLineFinish_ = nil
			arg_29_1.state_ = "waiting"
		end

		function arg_29_1.playNext_(arg_31_0)
			if arg_31_0 == 1 then
				arg_29_0:Play319501008(arg_29_1)
			end
		end

		function arg_29_1.onSingleLineUpdate_(arg_32_0)
			local var_32_0 = arg_29_1.actors_["1084ui_story"]
			local var_32_1 = 0

			if var_32_1 < arg_29_1.time_ and arg_29_1.time_ <= var_32_1 + arg_32_0 and not isNil(var_32_0) and arg_29_1.var_.characterEffect1084ui_story == nil then
				arg_29_1.var_.characterEffect1084ui_story = var_32_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_32_2 = 0.200000002980232

			if var_32_1 <= arg_29_1.time_ and arg_29_1.time_ < var_32_1 + var_32_2 and not isNil(var_32_0) then
				local var_32_3 = (arg_29_1.time_ - var_32_1) / var_32_2

				if arg_29_1.var_.characterEffect1084ui_story and not isNil(var_32_0) then
					local var_32_4 = Mathf.Lerp(0, 0.5, var_32_3)

					arg_29_1.var_.characterEffect1084ui_story.fillFlat = true
					arg_29_1.var_.characterEffect1084ui_story.fillRatio = var_32_4
				end
			end

			if arg_29_1.time_ >= var_32_1 + var_32_2 and arg_29_1.time_ < var_32_1 + var_32_2 + arg_32_0 and not isNil(var_32_0) and arg_29_1.var_.characterEffect1084ui_story then
				local var_32_5 = 0.5

				arg_29_1.var_.characterEffect1084ui_story.fillFlat = true
				arg_29_1.var_.characterEffect1084ui_story.fillRatio = var_32_5
			end

			local var_32_6 = 0

			if var_32_6 < arg_29_1.time_ and arg_29_1.time_ <= var_32_6 + arg_32_0 then
				arg_29_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/story1084/story1084action/1084action4_2")
			end

			local var_32_7 = arg_29_1.actors_["10069ui_story"]
			local var_32_8 = 0

			if var_32_8 < arg_29_1.time_ and arg_29_1.time_ <= var_32_8 + arg_32_0 and not isNil(var_32_7) and arg_29_1.var_.characterEffect10069ui_story == nil then
				arg_29_1.var_.characterEffect10069ui_story = var_32_7:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_32_9 = 0.200000002980232

			if var_32_8 <= arg_29_1.time_ and arg_29_1.time_ < var_32_8 + var_32_9 and not isNil(var_32_7) then
				local var_32_10 = (arg_29_1.time_ - var_32_8) / var_32_9

				if arg_29_1.var_.characterEffect10069ui_story and not isNil(var_32_7) then
					arg_29_1.var_.characterEffect10069ui_story.fillFlat = false
				end
			end

			if arg_29_1.time_ >= var_32_8 + var_32_9 and arg_29_1.time_ < var_32_8 + var_32_9 + arg_32_0 and not isNil(var_32_7) and arg_29_1.var_.characterEffect10069ui_story then
				arg_29_1.var_.characterEffect10069ui_story.fillFlat = false
			end

			local var_32_11 = 0
			local var_32_12 = 0.175

			if var_32_11 < arg_29_1.time_ and arg_29_1.time_ <= var_32_11 + arg_32_0 then
				arg_29_1.talkMaxDuration = 0
				arg_29_1.dialogCg_.alpha = 1

				arg_29_1.dialog_:SetActive(true)
				SetActive(arg_29_1.leftNameGo_, true)

				local var_32_13 = arg_29_1:FormatText(StoryNameCfg[693].name)

				arg_29_1.leftNameTxt_.text = var_32_13

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_29_1.leftNameTxt_.transform)

				arg_29_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_29_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_29_1:RecordName(arg_29_1.leftNameTxt_.text)
				SetActive(arg_29_1.iconTrs_.gameObject, false)
				arg_29_1.callingController_:SetSelectedState("normal")

				local var_32_14 = arg_29_1:GetWordFromCfg(319501007)
				local var_32_15 = arg_29_1:FormatText(var_32_14.content)

				arg_29_1.text_.text = var_32_15

				LuaForUtil.ClearLinePrefixSymbol(arg_29_1.text_)

				local var_32_16 = 7
				local var_32_17 = utf8.len(var_32_15)
				local var_32_18 = var_32_16 <= 0 and var_32_12 or var_32_12 * (var_32_17 / var_32_16)

				if var_32_18 > 0 and var_32_12 < var_32_18 then
					arg_29_1.talkMaxDuration = var_32_18

					if var_32_18 + var_32_11 > arg_29_1.duration_ then
						arg_29_1.duration_ = var_32_18 + var_32_11
					end
				end

				arg_29_1.text_.text = var_32_15
				arg_29_1.typewritter.percent = 0

				arg_29_1.typewritter:SetDirty()
				arg_29_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_319501", "319501007", "story_v_out_319501.awb") ~= 0 then
					local var_32_19 = manager.audio:GetVoiceLength("story_v_out_319501", "319501007", "story_v_out_319501.awb") / 1000

					if var_32_19 + var_32_11 > arg_29_1.duration_ then
						arg_29_1.duration_ = var_32_19 + var_32_11
					end

					if var_32_14.prefab_name ~= "" and arg_29_1.actors_[var_32_14.prefab_name] ~= nil then
						local var_32_20 = LuaForUtil.PlayVoiceWithCriLipsync(arg_29_1.actors_[var_32_14.prefab_name].transform, "story_v_out_319501", "319501007", "story_v_out_319501.awb")

						arg_29_1:RecordAudio("319501007", var_32_20)
						arg_29_1:RecordAudio("319501007", var_32_20)
					else
						arg_29_1:AudioAction("play", "voice", "story_v_out_319501", "319501007", "story_v_out_319501.awb")
					end

					arg_29_1:RecordHistoryTalkVoice("story_v_out_319501", "319501007", "story_v_out_319501.awb")
				end

				arg_29_1:RecordContent(arg_29_1.text_.text)
			end

			local var_32_21 = math.max(var_32_12, arg_29_1.talkMaxDuration)

			if var_32_11 <= arg_29_1.time_ and arg_29_1.time_ < var_32_11 + var_32_21 then
				arg_29_1.typewritter.percent = (arg_29_1.time_ - var_32_11) / var_32_21

				arg_29_1.typewritter:SetDirty()
			end

			if arg_29_1.time_ >= var_32_11 + var_32_21 and arg_29_1.time_ < var_32_11 + var_32_21 + arg_32_0 then
				arg_29_1.typewritter.percent = 1

				arg_29_1.typewritter:SetDirty()
				arg_29_1:ShowNextGo(true)
			end
		end

		arg_29_1.nodeConfigList_ = {}

		arg_29_1:InitPlayNodeList()
	end,
	Play319501008 = function(arg_33_0, arg_33_1)
		arg_33_1.time_ = 0
		arg_33_1.frameCnt_ = 0
		arg_33_1.state_ = "playing"
		arg_33_1.curTalkId_ = 319501008
		arg_33_1.duration_ = 4.4

		local var_33_0 = {
			zh = 3.3,
			ja = 4.4
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
				arg_33_0:Play319501009(arg_33_1)
			end
		end

		function arg_33_1.onSingleLineUpdate_(arg_36_0)
			local var_36_0 = arg_33_1.actors_["1084ui_story"]
			local var_36_1 = 0

			if var_36_1 < arg_33_1.time_ and arg_33_1.time_ <= var_36_1 + arg_36_0 and not isNil(var_36_0) and arg_33_1.var_.characterEffect1084ui_story == nil then
				arg_33_1.var_.characterEffect1084ui_story = var_36_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_36_2 = 0.200000002980232

			if var_36_1 <= arg_33_1.time_ and arg_33_1.time_ < var_36_1 + var_36_2 and not isNil(var_36_0) then
				local var_36_3 = (arg_33_1.time_ - var_36_1) / var_36_2

				if arg_33_1.var_.characterEffect1084ui_story and not isNil(var_36_0) then
					arg_33_1.var_.characterEffect1084ui_story.fillFlat = false
				end
			end

			if arg_33_1.time_ >= var_36_1 + var_36_2 and arg_33_1.time_ < var_36_1 + var_36_2 + arg_36_0 and not isNil(var_36_0) and arg_33_1.var_.characterEffect1084ui_story then
				arg_33_1.var_.characterEffect1084ui_story.fillFlat = false
			end

			local var_36_4 = 0

			if var_36_4 < arg_33_1.time_ and arg_33_1.time_ <= var_36_4 + arg_36_0 then
				arg_33_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_36_5 = arg_33_1.actors_["10069ui_story"]
			local var_36_6 = 0

			if var_36_6 < arg_33_1.time_ and arg_33_1.time_ <= var_36_6 + arg_36_0 and not isNil(var_36_5) and arg_33_1.var_.characterEffect10069ui_story == nil then
				arg_33_1.var_.characterEffect10069ui_story = var_36_5:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_36_7 = 0.200000002980232

			if var_36_6 <= arg_33_1.time_ and arg_33_1.time_ < var_36_6 + var_36_7 and not isNil(var_36_5) then
				local var_36_8 = (arg_33_1.time_ - var_36_6) / var_36_7

				if arg_33_1.var_.characterEffect10069ui_story and not isNil(var_36_5) then
					local var_36_9 = Mathf.Lerp(0, 0.5, var_36_8)

					arg_33_1.var_.characterEffect10069ui_story.fillFlat = true
					arg_33_1.var_.characterEffect10069ui_story.fillRatio = var_36_9
				end
			end

			if arg_33_1.time_ >= var_36_6 + var_36_7 and arg_33_1.time_ < var_36_6 + var_36_7 + arg_36_0 and not isNil(var_36_5) and arg_33_1.var_.characterEffect10069ui_story then
				local var_36_10 = 0.5

				arg_33_1.var_.characterEffect10069ui_story.fillFlat = true
				arg_33_1.var_.characterEffect10069ui_story.fillRatio = var_36_10
			end

			local var_36_11 = 0
			local var_36_12 = 0.35

			if var_36_11 < arg_33_1.time_ and arg_33_1.time_ <= var_36_11 + arg_36_0 then
				arg_33_1.talkMaxDuration = 0
				arg_33_1.dialogCg_.alpha = 1

				arg_33_1.dialog_:SetActive(true)
				SetActive(arg_33_1.leftNameGo_, true)

				local var_36_13 = arg_33_1:FormatText(StoryNameCfg[6].name)

				arg_33_1.leftNameTxt_.text = var_36_13

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_33_1.leftNameTxt_.transform)

				arg_33_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_33_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_33_1:RecordName(arg_33_1.leftNameTxt_.text)
				SetActive(arg_33_1.iconTrs_.gameObject, false)
				arg_33_1.callingController_:SetSelectedState("normal")

				local var_36_14 = arg_33_1:GetWordFromCfg(319501008)
				local var_36_15 = arg_33_1:FormatText(var_36_14.content)

				arg_33_1.text_.text = var_36_15

				LuaForUtil.ClearLinePrefixSymbol(arg_33_1.text_)

				local var_36_16 = 14
				local var_36_17 = utf8.len(var_36_15)
				local var_36_18 = var_36_16 <= 0 and var_36_12 or var_36_12 * (var_36_17 / var_36_16)

				if var_36_18 > 0 and var_36_12 < var_36_18 then
					arg_33_1.talkMaxDuration = var_36_18

					if var_36_18 + var_36_11 > arg_33_1.duration_ then
						arg_33_1.duration_ = var_36_18 + var_36_11
					end
				end

				arg_33_1.text_.text = var_36_15
				arg_33_1.typewritter.percent = 0

				arg_33_1.typewritter:SetDirty()
				arg_33_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_319501", "319501008", "story_v_out_319501.awb") ~= 0 then
					local var_36_19 = manager.audio:GetVoiceLength("story_v_out_319501", "319501008", "story_v_out_319501.awb") / 1000

					if var_36_19 + var_36_11 > arg_33_1.duration_ then
						arg_33_1.duration_ = var_36_19 + var_36_11
					end

					if var_36_14.prefab_name ~= "" and arg_33_1.actors_[var_36_14.prefab_name] ~= nil then
						local var_36_20 = LuaForUtil.PlayVoiceWithCriLipsync(arg_33_1.actors_[var_36_14.prefab_name].transform, "story_v_out_319501", "319501008", "story_v_out_319501.awb")

						arg_33_1:RecordAudio("319501008", var_36_20)
						arg_33_1:RecordAudio("319501008", var_36_20)
					else
						arg_33_1:AudioAction("play", "voice", "story_v_out_319501", "319501008", "story_v_out_319501.awb")
					end

					arg_33_1:RecordHistoryTalkVoice("story_v_out_319501", "319501008", "story_v_out_319501.awb")
				end

				arg_33_1:RecordContent(arg_33_1.text_.text)
			end

			local var_36_21 = math.max(var_36_12, arg_33_1.talkMaxDuration)

			if var_36_11 <= arg_33_1.time_ and arg_33_1.time_ < var_36_11 + var_36_21 then
				arg_33_1.typewritter.percent = (arg_33_1.time_ - var_36_11) / var_36_21

				arg_33_1.typewritter:SetDirty()
			end

			if arg_33_1.time_ >= var_36_11 + var_36_21 and arg_33_1.time_ < var_36_11 + var_36_21 + arg_36_0 then
				arg_33_1.typewritter.percent = 1

				arg_33_1.typewritter:SetDirty()
				arg_33_1:ShowNextGo(true)
			end
		end

		arg_33_1.nodeConfigList_ = {}

		arg_33_1:InitPlayNodeList()
	end,
	Play319501009 = function(arg_37_0, arg_37_1)
		arg_37_1.time_ = 0
		arg_37_1.frameCnt_ = 0
		arg_37_1.state_ = "playing"
		arg_37_1.curTalkId_ = 319501009
		arg_37_1.duration_ = 5.5

		local var_37_0 = {
			zh = 5.5,
			ja = 3.7
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
				arg_37_0:Play319501010(arg_37_1)
			end
		end

		function arg_37_1.onSingleLineUpdate_(arg_40_0)
			local var_40_0 = 0

			if var_40_0 < arg_37_1.time_ and arg_37_1.time_ <= var_40_0 + arg_40_0 then
				arg_37_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/story1084/story1084action/1084action1_1")
			end

			local var_40_1 = 0

			if var_40_1 < arg_37_1.time_ and arg_37_1.time_ <= var_40_1 + arg_40_0 then
				arg_37_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_40_2 = 0
			local var_40_3 = 0.575

			if var_40_2 < arg_37_1.time_ and arg_37_1.time_ <= var_40_2 + arg_40_0 then
				arg_37_1.talkMaxDuration = 0
				arg_37_1.dialogCg_.alpha = 1

				arg_37_1.dialog_:SetActive(true)
				SetActive(arg_37_1.leftNameGo_, true)

				local var_40_4 = arg_37_1:FormatText(StoryNameCfg[6].name)

				arg_37_1.leftNameTxt_.text = var_40_4

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_37_1.leftNameTxt_.transform)

				arg_37_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_37_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_37_1:RecordName(arg_37_1.leftNameTxt_.text)
				SetActive(arg_37_1.iconTrs_.gameObject, false)
				arg_37_1.callingController_:SetSelectedState("normal")

				local var_40_5 = arg_37_1:GetWordFromCfg(319501009)
				local var_40_6 = arg_37_1:FormatText(var_40_5.content)

				arg_37_1.text_.text = var_40_6

				LuaForUtil.ClearLinePrefixSymbol(arg_37_1.text_)

				local var_40_7 = 23
				local var_40_8 = utf8.len(var_40_6)
				local var_40_9 = var_40_7 <= 0 and var_40_3 or var_40_3 * (var_40_8 / var_40_7)

				if var_40_9 > 0 and var_40_3 < var_40_9 then
					arg_37_1.talkMaxDuration = var_40_9

					if var_40_9 + var_40_2 > arg_37_1.duration_ then
						arg_37_1.duration_ = var_40_9 + var_40_2
					end
				end

				arg_37_1.text_.text = var_40_6
				arg_37_1.typewritter.percent = 0

				arg_37_1.typewritter:SetDirty()
				arg_37_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_319501", "319501009", "story_v_out_319501.awb") ~= 0 then
					local var_40_10 = manager.audio:GetVoiceLength("story_v_out_319501", "319501009", "story_v_out_319501.awb") / 1000

					if var_40_10 + var_40_2 > arg_37_1.duration_ then
						arg_37_1.duration_ = var_40_10 + var_40_2
					end

					if var_40_5.prefab_name ~= "" and arg_37_1.actors_[var_40_5.prefab_name] ~= nil then
						local var_40_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_37_1.actors_[var_40_5.prefab_name].transform, "story_v_out_319501", "319501009", "story_v_out_319501.awb")

						arg_37_1:RecordAudio("319501009", var_40_11)
						arg_37_1:RecordAudio("319501009", var_40_11)
					else
						arg_37_1:AudioAction("play", "voice", "story_v_out_319501", "319501009", "story_v_out_319501.awb")
					end

					arg_37_1:RecordHistoryTalkVoice("story_v_out_319501", "319501009", "story_v_out_319501.awb")
				end

				arg_37_1:RecordContent(arg_37_1.text_.text)
			end

			local var_40_12 = math.max(var_40_3, arg_37_1.talkMaxDuration)

			if var_40_2 <= arg_37_1.time_ and arg_37_1.time_ < var_40_2 + var_40_12 then
				arg_37_1.typewritter.percent = (arg_37_1.time_ - var_40_2) / var_40_12

				arg_37_1.typewritter:SetDirty()
			end

			if arg_37_1.time_ >= var_40_2 + var_40_12 and arg_37_1.time_ < var_40_2 + var_40_12 + arg_40_0 then
				arg_37_1.typewritter.percent = 1

				arg_37_1.typewritter:SetDirty()
				arg_37_1:ShowNextGo(true)
			end
		end

		arg_37_1.nodeConfigList_ = {}

		arg_37_1:InitPlayNodeList()
	end,
	Play319501010 = function(arg_41_0, arg_41_1)
		arg_41_1.time_ = 0
		arg_41_1.frameCnt_ = 0
		arg_41_1.state_ = "playing"
		arg_41_1.curTalkId_ = 319501010
		arg_41_1.duration_ = 9.03

		local var_41_0 = {
			zh = 9.033,
			ja = 6.466
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
				arg_41_0:Play319501011(arg_41_1)
			end
		end

		function arg_41_1.onSingleLineUpdate_(arg_44_0)
			local var_44_0 = arg_41_1.actors_["10069ui_story"]
			local var_44_1 = 0

			if var_44_1 < arg_41_1.time_ and arg_41_1.time_ <= var_44_1 + arg_44_0 and not isNil(var_44_0) and arg_41_1.var_.characterEffect10069ui_story == nil then
				arg_41_1.var_.characterEffect10069ui_story = var_44_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_44_2 = 0.200000002980232

			if var_44_1 <= arg_41_1.time_ and arg_41_1.time_ < var_44_1 + var_44_2 and not isNil(var_44_0) then
				local var_44_3 = (arg_41_1.time_ - var_44_1) / var_44_2

				if arg_41_1.var_.characterEffect10069ui_story and not isNil(var_44_0) then
					arg_41_1.var_.characterEffect10069ui_story.fillFlat = false
				end
			end

			if arg_41_1.time_ >= var_44_1 + var_44_2 and arg_41_1.time_ < var_44_1 + var_44_2 + arg_44_0 and not isNil(var_44_0) and arg_41_1.var_.characterEffect10069ui_story then
				arg_41_1.var_.characterEffect10069ui_story.fillFlat = false
			end

			local var_44_4 = 0

			if var_44_4 < arg_41_1.time_ and arg_41_1.time_ <= var_44_4 + arg_44_0 then
				arg_41_1:PlayTimeline("10069ui_story", "StoryTimeline/CharAction/story10056/story10056action/10056action1_1")
			end

			local var_44_5 = 0

			if var_44_5 < arg_41_1.time_ and arg_41_1.time_ <= var_44_5 + arg_44_0 then
				arg_41_1:PlayTimeline("10069ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_44_6 = arg_41_1.actors_["1084ui_story"]
			local var_44_7 = 0

			if var_44_7 < arg_41_1.time_ and arg_41_1.time_ <= var_44_7 + arg_44_0 and not isNil(var_44_6) and arg_41_1.var_.characterEffect1084ui_story == nil then
				arg_41_1.var_.characterEffect1084ui_story = var_44_6:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_44_8 = 0.200000002980232

			if var_44_7 <= arg_41_1.time_ and arg_41_1.time_ < var_44_7 + var_44_8 and not isNil(var_44_6) then
				local var_44_9 = (arg_41_1.time_ - var_44_7) / var_44_8

				if arg_41_1.var_.characterEffect1084ui_story and not isNil(var_44_6) then
					local var_44_10 = Mathf.Lerp(0, 0.5, var_44_9)

					arg_41_1.var_.characterEffect1084ui_story.fillFlat = true
					arg_41_1.var_.characterEffect1084ui_story.fillRatio = var_44_10
				end
			end

			if arg_41_1.time_ >= var_44_7 + var_44_8 and arg_41_1.time_ < var_44_7 + var_44_8 + arg_44_0 and not isNil(var_44_6) and arg_41_1.var_.characterEffect1084ui_story then
				local var_44_11 = 0.5

				arg_41_1.var_.characterEffect1084ui_story.fillFlat = true
				arg_41_1.var_.characterEffect1084ui_story.fillRatio = var_44_11
			end

			local var_44_12 = 0
			local var_44_13 = 1.025

			if var_44_12 < arg_41_1.time_ and arg_41_1.time_ <= var_44_12 + arg_44_0 then
				arg_41_1.talkMaxDuration = 0
				arg_41_1.dialogCg_.alpha = 1

				arg_41_1.dialog_:SetActive(true)
				SetActive(arg_41_1.leftNameGo_, true)

				local var_44_14 = arg_41_1:FormatText(StoryNameCfg[693].name)

				arg_41_1.leftNameTxt_.text = var_44_14

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_41_1.leftNameTxt_.transform)

				arg_41_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_41_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_41_1:RecordName(arg_41_1.leftNameTxt_.text)
				SetActive(arg_41_1.iconTrs_.gameObject, false)
				arg_41_1.callingController_:SetSelectedState("normal")

				local var_44_15 = arg_41_1:GetWordFromCfg(319501010)
				local var_44_16 = arg_41_1:FormatText(var_44_15.content)

				arg_41_1.text_.text = var_44_16

				LuaForUtil.ClearLinePrefixSymbol(arg_41_1.text_)

				local var_44_17 = 41
				local var_44_18 = utf8.len(var_44_16)
				local var_44_19 = var_44_17 <= 0 and var_44_13 or var_44_13 * (var_44_18 / var_44_17)

				if var_44_19 > 0 and var_44_13 < var_44_19 then
					arg_41_1.talkMaxDuration = var_44_19

					if var_44_19 + var_44_12 > arg_41_1.duration_ then
						arg_41_1.duration_ = var_44_19 + var_44_12
					end
				end

				arg_41_1.text_.text = var_44_16
				arg_41_1.typewritter.percent = 0

				arg_41_1.typewritter:SetDirty()
				arg_41_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_319501", "319501010", "story_v_out_319501.awb") ~= 0 then
					local var_44_20 = manager.audio:GetVoiceLength("story_v_out_319501", "319501010", "story_v_out_319501.awb") / 1000

					if var_44_20 + var_44_12 > arg_41_1.duration_ then
						arg_41_1.duration_ = var_44_20 + var_44_12
					end

					if var_44_15.prefab_name ~= "" and arg_41_1.actors_[var_44_15.prefab_name] ~= nil then
						local var_44_21 = LuaForUtil.PlayVoiceWithCriLipsync(arg_41_1.actors_[var_44_15.prefab_name].transform, "story_v_out_319501", "319501010", "story_v_out_319501.awb")

						arg_41_1:RecordAudio("319501010", var_44_21)
						arg_41_1:RecordAudio("319501010", var_44_21)
					else
						arg_41_1:AudioAction("play", "voice", "story_v_out_319501", "319501010", "story_v_out_319501.awb")
					end

					arg_41_1:RecordHistoryTalkVoice("story_v_out_319501", "319501010", "story_v_out_319501.awb")
				end

				arg_41_1:RecordContent(arg_41_1.text_.text)
			end

			local var_44_22 = math.max(var_44_13, arg_41_1.talkMaxDuration)

			if var_44_12 <= arg_41_1.time_ and arg_41_1.time_ < var_44_12 + var_44_22 then
				arg_41_1.typewritter.percent = (arg_41_1.time_ - var_44_12) / var_44_22

				arg_41_1.typewritter:SetDirty()
			end

			if arg_41_1.time_ >= var_44_12 + var_44_22 and arg_41_1.time_ < var_44_12 + var_44_22 + arg_44_0 then
				arg_41_1.typewritter.percent = 1

				arg_41_1.typewritter:SetDirty()
				arg_41_1:ShowNextGo(true)
			end
		end

		arg_41_1.nodeConfigList_ = {}

		arg_41_1:InitPlayNodeList()
	end,
	Play319501011 = function(arg_45_0, arg_45_1)
		arg_45_1.time_ = 0
		arg_45_1.frameCnt_ = 0
		arg_45_1.state_ = "playing"
		arg_45_1.curTalkId_ = 319501011
		arg_45_1.duration_ = 8.73

		local var_45_0 = {
			zh = 8.733,
			ja = 8.166
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
				arg_45_0:Play319501012(arg_45_1)
			end
		end

		function arg_45_1.onSingleLineUpdate_(arg_48_0)
			local var_48_0 = arg_45_1.actors_["1084ui_story"]
			local var_48_1 = 0

			if var_48_1 < arg_45_1.time_ and arg_45_1.time_ <= var_48_1 + arg_48_0 and not isNil(var_48_0) and arg_45_1.var_.characterEffect1084ui_story == nil then
				arg_45_1.var_.characterEffect1084ui_story = var_48_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_48_2 = 0.200000002980232

			if var_48_1 <= arg_45_1.time_ and arg_45_1.time_ < var_48_1 + var_48_2 and not isNil(var_48_0) then
				local var_48_3 = (arg_45_1.time_ - var_48_1) / var_48_2

				if arg_45_1.var_.characterEffect1084ui_story and not isNil(var_48_0) then
					arg_45_1.var_.characterEffect1084ui_story.fillFlat = false
				end
			end

			if arg_45_1.time_ >= var_48_1 + var_48_2 and arg_45_1.time_ < var_48_1 + var_48_2 + arg_48_0 and not isNil(var_48_0) and arg_45_1.var_.characterEffect1084ui_story then
				arg_45_1.var_.characterEffect1084ui_story.fillFlat = false
			end

			local var_48_4 = 0

			if var_48_4 < arg_45_1.time_ and arg_45_1.time_ <= var_48_4 + arg_48_0 then
				arg_45_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/story1084/story1084action/1084action7_1")
			end

			local var_48_5 = 0

			if var_48_5 < arg_45_1.time_ and arg_45_1.time_ <= var_48_5 + arg_48_0 then
				arg_45_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface2101cva")
			end

			local var_48_6 = arg_45_1.actors_["10069ui_story"]
			local var_48_7 = 0

			if var_48_7 < arg_45_1.time_ and arg_45_1.time_ <= var_48_7 + arg_48_0 and not isNil(var_48_6) and arg_45_1.var_.characterEffect10069ui_story == nil then
				arg_45_1.var_.characterEffect10069ui_story = var_48_6:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_48_8 = 0.200000002980232

			if var_48_7 <= arg_45_1.time_ and arg_45_1.time_ < var_48_7 + var_48_8 and not isNil(var_48_6) then
				local var_48_9 = (arg_45_1.time_ - var_48_7) / var_48_8

				if arg_45_1.var_.characterEffect10069ui_story and not isNil(var_48_6) then
					local var_48_10 = Mathf.Lerp(0, 0.5, var_48_9)

					arg_45_1.var_.characterEffect10069ui_story.fillFlat = true
					arg_45_1.var_.characterEffect10069ui_story.fillRatio = var_48_10
				end
			end

			if arg_45_1.time_ >= var_48_7 + var_48_8 and arg_45_1.time_ < var_48_7 + var_48_8 + arg_48_0 and not isNil(var_48_6) and arg_45_1.var_.characterEffect10069ui_story then
				local var_48_11 = 0.5

				arg_45_1.var_.characterEffect10069ui_story.fillFlat = true
				arg_45_1.var_.characterEffect10069ui_story.fillRatio = var_48_11
			end

			local var_48_12 = 0
			local var_48_13 = 0.925

			if var_48_12 < arg_45_1.time_ and arg_45_1.time_ <= var_48_12 + arg_48_0 then
				arg_45_1.talkMaxDuration = 0
				arg_45_1.dialogCg_.alpha = 1

				arg_45_1.dialog_:SetActive(true)
				SetActive(arg_45_1.leftNameGo_, true)

				local var_48_14 = arg_45_1:FormatText(StoryNameCfg[6].name)

				arg_45_1.leftNameTxt_.text = var_48_14

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_45_1.leftNameTxt_.transform)

				arg_45_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_45_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_45_1:RecordName(arg_45_1.leftNameTxt_.text)
				SetActive(arg_45_1.iconTrs_.gameObject, false)
				arg_45_1.callingController_:SetSelectedState("normal")

				local var_48_15 = arg_45_1:GetWordFromCfg(319501011)
				local var_48_16 = arg_45_1:FormatText(var_48_15.content)

				arg_45_1.text_.text = var_48_16

				LuaForUtil.ClearLinePrefixSymbol(arg_45_1.text_)

				local var_48_17 = 37
				local var_48_18 = utf8.len(var_48_16)
				local var_48_19 = var_48_17 <= 0 and var_48_13 or var_48_13 * (var_48_18 / var_48_17)

				if var_48_19 > 0 and var_48_13 < var_48_19 then
					arg_45_1.talkMaxDuration = var_48_19

					if var_48_19 + var_48_12 > arg_45_1.duration_ then
						arg_45_1.duration_ = var_48_19 + var_48_12
					end
				end

				arg_45_1.text_.text = var_48_16
				arg_45_1.typewritter.percent = 0

				arg_45_1.typewritter:SetDirty()
				arg_45_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_319501", "319501011", "story_v_out_319501.awb") ~= 0 then
					local var_48_20 = manager.audio:GetVoiceLength("story_v_out_319501", "319501011", "story_v_out_319501.awb") / 1000

					if var_48_20 + var_48_12 > arg_45_1.duration_ then
						arg_45_1.duration_ = var_48_20 + var_48_12
					end

					if var_48_15.prefab_name ~= "" and arg_45_1.actors_[var_48_15.prefab_name] ~= nil then
						local var_48_21 = LuaForUtil.PlayVoiceWithCriLipsync(arg_45_1.actors_[var_48_15.prefab_name].transform, "story_v_out_319501", "319501011", "story_v_out_319501.awb")

						arg_45_1:RecordAudio("319501011", var_48_21)
						arg_45_1:RecordAudio("319501011", var_48_21)
					else
						arg_45_1:AudioAction("play", "voice", "story_v_out_319501", "319501011", "story_v_out_319501.awb")
					end

					arg_45_1:RecordHistoryTalkVoice("story_v_out_319501", "319501011", "story_v_out_319501.awb")
				end

				arg_45_1:RecordContent(arg_45_1.text_.text)
			end

			local var_48_22 = math.max(var_48_13, arg_45_1.talkMaxDuration)

			if var_48_12 <= arg_45_1.time_ and arg_45_1.time_ < var_48_12 + var_48_22 then
				arg_45_1.typewritter.percent = (arg_45_1.time_ - var_48_12) / var_48_22

				arg_45_1.typewritter:SetDirty()
			end

			if arg_45_1.time_ >= var_48_12 + var_48_22 and arg_45_1.time_ < var_48_12 + var_48_22 + arg_48_0 then
				arg_45_1.typewritter.percent = 1

				arg_45_1.typewritter:SetDirty()
				arg_45_1:ShowNextGo(true)
			end
		end

		arg_45_1.nodeConfigList_ = {}

		arg_45_1:InitPlayNodeList()
	end,
	Play319501012 = function(arg_49_0, arg_49_1)
		arg_49_1.time_ = 0
		arg_49_1.frameCnt_ = 0
		arg_49_1.state_ = "playing"
		arg_49_1.curTalkId_ = 319501012
		arg_49_1.duration_ = 7.37

		local var_49_0 = {
			zh = 2.033,
			ja = 7.366
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
				arg_49_0:Play319501013(arg_49_1)
			end
		end

		function arg_49_1.onSingleLineUpdate_(arg_52_0)
			local var_52_0 = arg_49_1.actors_["1084ui_story"]
			local var_52_1 = 0

			if var_52_1 < arg_49_1.time_ and arg_49_1.time_ <= var_52_1 + arg_52_0 and not isNil(var_52_0) and arg_49_1.var_.characterEffect1084ui_story == nil then
				arg_49_1.var_.characterEffect1084ui_story = var_52_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_52_2 = 0.200000002980232

			if var_52_1 <= arg_49_1.time_ and arg_49_1.time_ < var_52_1 + var_52_2 and not isNil(var_52_0) then
				local var_52_3 = (arg_49_1.time_ - var_52_1) / var_52_2

				if arg_49_1.var_.characterEffect1084ui_story and not isNil(var_52_0) then
					local var_52_4 = Mathf.Lerp(0, 0.5, var_52_3)

					arg_49_1.var_.characterEffect1084ui_story.fillFlat = true
					arg_49_1.var_.characterEffect1084ui_story.fillRatio = var_52_4
				end
			end

			if arg_49_1.time_ >= var_52_1 + var_52_2 and arg_49_1.time_ < var_52_1 + var_52_2 + arg_52_0 and not isNil(var_52_0) and arg_49_1.var_.characterEffect1084ui_story then
				local var_52_5 = 0.5

				arg_49_1.var_.characterEffect1084ui_story.fillFlat = true
				arg_49_1.var_.characterEffect1084ui_story.fillRatio = var_52_5
			end

			local var_52_6 = arg_49_1.actors_["10069ui_story"]
			local var_52_7 = 0

			if var_52_7 < arg_49_1.time_ and arg_49_1.time_ <= var_52_7 + arg_52_0 and not isNil(var_52_6) and arg_49_1.var_.characterEffect10069ui_story == nil then
				arg_49_1.var_.characterEffect10069ui_story = var_52_6:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_52_8 = 0.200000002980232

			if var_52_7 <= arg_49_1.time_ and arg_49_1.time_ < var_52_7 + var_52_8 and not isNil(var_52_6) then
				local var_52_9 = (arg_49_1.time_ - var_52_7) / var_52_8

				if arg_49_1.var_.characterEffect10069ui_story and not isNil(var_52_6) then
					arg_49_1.var_.characterEffect10069ui_story.fillFlat = false
				end
			end

			if arg_49_1.time_ >= var_52_7 + var_52_8 and arg_49_1.time_ < var_52_7 + var_52_8 + arg_52_0 and not isNil(var_52_6) and arg_49_1.var_.characterEffect10069ui_story then
				arg_49_1.var_.characterEffect10069ui_story.fillFlat = false
			end

			local var_52_10 = 0
			local var_52_11 = 0.225

			if var_52_10 < arg_49_1.time_ and arg_49_1.time_ <= var_52_10 + arg_52_0 then
				arg_49_1.talkMaxDuration = 0
				arg_49_1.dialogCg_.alpha = 1

				arg_49_1.dialog_:SetActive(true)
				SetActive(arg_49_1.leftNameGo_, true)

				local var_52_12 = arg_49_1:FormatText(StoryNameCfg[693].name)

				arg_49_1.leftNameTxt_.text = var_52_12

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_49_1.leftNameTxt_.transform)

				arg_49_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_49_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_49_1:RecordName(arg_49_1.leftNameTxt_.text)
				SetActive(arg_49_1.iconTrs_.gameObject, false)
				arg_49_1.callingController_:SetSelectedState("normal")

				local var_52_13 = arg_49_1:GetWordFromCfg(319501012)
				local var_52_14 = arg_49_1:FormatText(var_52_13.content)

				arg_49_1.text_.text = var_52_14

				LuaForUtil.ClearLinePrefixSymbol(arg_49_1.text_)

				local var_52_15 = 9
				local var_52_16 = utf8.len(var_52_14)
				local var_52_17 = var_52_15 <= 0 and var_52_11 or var_52_11 * (var_52_16 / var_52_15)

				if var_52_17 > 0 and var_52_11 < var_52_17 then
					arg_49_1.talkMaxDuration = var_52_17

					if var_52_17 + var_52_10 > arg_49_1.duration_ then
						arg_49_1.duration_ = var_52_17 + var_52_10
					end
				end

				arg_49_1.text_.text = var_52_14
				arg_49_1.typewritter.percent = 0

				arg_49_1.typewritter:SetDirty()
				arg_49_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_319501", "319501012", "story_v_out_319501.awb") ~= 0 then
					local var_52_18 = manager.audio:GetVoiceLength("story_v_out_319501", "319501012", "story_v_out_319501.awb") / 1000

					if var_52_18 + var_52_10 > arg_49_1.duration_ then
						arg_49_1.duration_ = var_52_18 + var_52_10
					end

					if var_52_13.prefab_name ~= "" and arg_49_1.actors_[var_52_13.prefab_name] ~= nil then
						local var_52_19 = LuaForUtil.PlayVoiceWithCriLipsync(arg_49_1.actors_[var_52_13.prefab_name].transform, "story_v_out_319501", "319501012", "story_v_out_319501.awb")

						arg_49_1:RecordAudio("319501012", var_52_19)
						arg_49_1:RecordAudio("319501012", var_52_19)
					else
						arg_49_1:AudioAction("play", "voice", "story_v_out_319501", "319501012", "story_v_out_319501.awb")
					end

					arg_49_1:RecordHistoryTalkVoice("story_v_out_319501", "319501012", "story_v_out_319501.awb")
				end

				arg_49_1:RecordContent(arg_49_1.text_.text)
			end

			local var_52_20 = math.max(var_52_11, arg_49_1.talkMaxDuration)

			if var_52_10 <= arg_49_1.time_ and arg_49_1.time_ < var_52_10 + var_52_20 then
				arg_49_1.typewritter.percent = (arg_49_1.time_ - var_52_10) / var_52_20

				arg_49_1.typewritter:SetDirty()
			end

			if arg_49_1.time_ >= var_52_10 + var_52_20 and arg_49_1.time_ < var_52_10 + var_52_20 + arg_52_0 then
				arg_49_1.typewritter.percent = 1

				arg_49_1.typewritter:SetDirty()
				arg_49_1:ShowNextGo(true)
			end
		end

		arg_49_1.nodeConfigList_ = {}

		arg_49_1:InitPlayNodeList()
	end,
	Play319501013 = function(arg_53_0, arg_53_1)
		arg_53_1.time_ = 0
		arg_53_1.frameCnt_ = 0
		arg_53_1.state_ = "playing"
		arg_53_1.curTalkId_ = 319501013
		arg_53_1.duration_ = 7.4

		local var_53_0 = {
			zh = 4.366,
			ja = 7.4
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
				arg_53_0:Play319501014(arg_53_1)
			end
		end

		function arg_53_1.onSingleLineUpdate_(arg_56_0)
			local var_56_0 = arg_53_1.actors_["1084ui_story"]
			local var_56_1 = 0

			if var_56_1 < arg_53_1.time_ and arg_53_1.time_ <= var_56_1 + arg_56_0 and not isNil(var_56_0) and arg_53_1.var_.characterEffect1084ui_story == nil then
				arg_53_1.var_.characterEffect1084ui_story = var_56_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_56_2 = 0.200000002980232

			if var_56_1 <= arg_53_1.time_ and arg_53_1.time_ < var_56_1 + var_56_2 and not isNil(var_56_0) then
				local var_56_3 = (arg_53_1.time_ - var_56_1) / var_56_2

				if arg_53_1.var_.characterEffect1084ui_story and not isNil(var_56_0) then
					arg_53_1.var_.characterEffect1084ui_story.fillFlat = false
				end
			end

			if arg_53_1.time_ >= var_56_1 + var_56_2 and arg_53_1.time_ < var_56_1 + var_56_2 + arg_56_0 and not isNil(var_56_0) and arg_53_1.var_.characterEffect1084ui_story then
				arg_53_1.var_.characterEffect1084ui_story.fillFlat = false
			end

			local var_56_4 = 0

			if var_56_4 < arg_53_1.time_ and arg_53_1.time_ <= var_56_4 + arg_56_0 then
				arg_53_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/story1084/story1084action/1084action7_2")
			end

			local var_56_5 = 0

			if var_56_5 < arg_53_1.time_ and arg_53_1.time_ <= var_56_5 + arg_56_0 then
				arg_53_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_56_6 = arg_53_1.actors_["10069ui_story"]
			local var_56_7 = 0

			if var_56_7 < arg_53_1.time_ and arg_53_1.time_ <= var_56_7 + arg_56_0 and not isNil(var_56_6) and arg_53_1.var_.characterEffect10069ui_story == nil then
				arg_53_1.var_.characterEffect10069ui_story = var_56_6:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_56_8 = 0.200000002980232

			if var_56_7 <= arg_53_1.time_ and arg_53_1.time_ < var_56_7 + var_56_8 and not isNil(var_56_6) then
				local var_56_9 = (arg_53_1.time_ - var_56_7) / var_56_8

				if arg_53_1.var_.characterEffect10069ui_story and not isNil(var_56_6) then
					local var_56_10 = Mathf.Lerp(0, 0.5, var_56_9)

					arg_53_1.var_.characterEffect10069ui_story.fillFlat = true
					arg_53_1.var_.characterEffect10069ui_story.fillRatio = var_56_10
				end
			end

			if arg_53_1.time_ >= var_56_7 + var_56_8 and arg_53_1.time_ < var_56_7 + var_56_8 + arg_56_0 and not isNil(var_56_6) and arg_53_1.var_.characterEffect10069ui_story then
				local var_56_11 = 0.5

				arg_53_1.var_.characterEffect10069ui_story.fillFlat = true
				arg_53_1.var_.characterEffect10069ui_story.fillRatio = var_56_11
			end

			local var_56_12 = 0
			local var_56_13 = 0.5

			if var_56_12 < arg_53_1.time_ and arg_53_1.time_ <= var_56_12 + arg_56_0 then
				arg_53_1.talkMaxDuration = 0
				arg_53_1.dialogCg_.alpha = 1

				arg_53_1.dialog_:SetActive(true)
				SetActive(arg_53_1.leftNameGo_, true)

				local var_56_14 = arg_53_1:FormatText(StoryNameCfg[6].name)

				arg_53_1.leftNameTxt_.text = var_56_14

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_53_1.leftNameTxt_.transform)

				arg_53_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_53_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_53_1:RecordName(arg_53_1.leftNameTxt_.text)
				SetActive(arg_53_1.iconTrs_.gameObject, false)
				arg_53_1.callingController_:SetSelectedState("normal")

				local var_56_15 = arg_53_1:GetWordFromCfg(319501013)
				local var_56_16 = arg_53_1:FormatText(var_56_15.content)

				arg_53_1.text_.text = var_56_16

				LuaForUtil.ClearLinePrefixSymbol(arg_53_1.text_)

				local var_56_17 = 20
				local var_56_18 = utf8.len(var_56_16)
				local var_56_19 = var_56_17 <= 0 and var_56_13 or var_56_13 * (var_56_18 / var_56_17)

				if var_56_19 > 0 and var_56_13 < var_56_19 then
					arg_53_1.talkMaxDuration = var_56_19

					if var_56_19 + var_56_12 > arg_53_1.duration_ then
						arg_53_1.duration_ = var_56_19 + var_56_12
					end
				end

				arg_53_1.text_.text = var_56_16
				arg_53_1.typewritter.percent = 0

				arg_53_1.typewritter:SetDirty()
				arg_53_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_319501", "319501013", "story_v_out_319501.awb") ~= 0 then
					local var_56_20 = manager.audio:GetVoiceLength("story_v_out_319501", "319501013", "story_v_out_319501.awb") / 1000

					if var_56_20 + var_56_12 > arg_53_1.duration_ then
						arg_53_1.duration_ = var_56_20 + var_56_12
					end

					if var_56_15.prefab_name ~= "" and arg_53_1.actors_[var_56_15.prefab_name] ~= nil then
						local var_56_21 = LuaForUtil.PlayVoiceWithCriLipsync(arg_53_1.actors_[var_56_15.prefab_name].transform, "story_v_out_319501", "319501013", "story_v_out_319501.awb")

						arg_53_1:RecordAudio("319501013", var_56_21)
						arg_53_1:RecordAudio("319501013", var_56_21)
					else
						arg_53_1:AudioAction("play", "voice", "story_v_out_319501", "319501013", "story_v_out_319501.awb")
					end

					arg_53_1:RecordHistoryTalkVoice("story_v_out_319501", "319501013", "story_v_out_319501.awb")
				end

				arg_53_1:RecordContent(arg_53_1.text_.text)
			end

			local var_56_22 = math.max(var_56_13, arg_53_1.talkMaxDuration)

			if var_56_12 <= arg_53_1.time_ and arg_53_1.time_ < var_56_12 + var_56_22 then
				arg_53_1.typewritter.percent = (arg_53_1.time_ - var_56_12) / var_56_22

				arg_53_1.typewritter:SetDirty()
			end

			if arg_53_1.time_ >= var_56_12 + var_56_22 and arg_53_1.time_ < var_56_12 + var_56_22 + arg_56_0 then
				arg_53_1.typewritter.percent = 1

				arg_53_1.typewritter:SetDirty()
				arg_53_1:ShowNextGo(true)
			end
		end

		arg_53_1.nodeConfigList_ = {}

		arg_53_1:InitPlayNodeList()
	end,
	Play319501014 = function(arg_57_0, arg_57_1)
		arg_57_1.time_ = 0
		arg_57_1.frameCnt_ = 0
		arg_57_1.state_ = "playing"
		arg_57_1.curTalkId_ = 319501014
		arg_57_1.duration_ = 5.7

		local var_57_0 = {
			zh = 5.7,
			ja = 4.633
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
				arg_57_0:Play319501015(arg_57_1)
			end
		end

		function arg_57_1.onSingleLineUpdate_(arg_60_0)
			local var_60_0 = 0
			local var_60_1 = 0.65

			if var_60_0 < arg_57_1.time_ and arg_57_1.time_ <= var_60_0 + arg_60_0 then
				arg_57_1.talkMaxDuration = 0
				arg_57_1.dialogCg_.alpha = 1

				arg_57_1.dialog_:SetActive(true)
				SetActive(arg_57_1.leftNameGo_, true)

				local var_60_2 = arg_57_1:FormatText(StoryNameCfg[6].name)

				arg_57_1.leftNameTxt_.text = var_60_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_57_1.leftNameTxt_.transform)

				arg_57_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_57_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_57_1:RecordName(arg_57_1.leftNameTxt_.text)
				SetActive(arg_57_1.iconTrs_.gameObject, false)
				arg_57_1.callingController_:SetSelectedState("normal")

				local var_60_3 = arg_57_1:GetWordFromCfg(319501014)
				local var_60_4 = arg_57_1:FormatText(var_60_3.content)

				arg_57_1.text_.text = var_60_4

				LuaForUtil.ClearLinePrefixSymbol(arg_57_1.text_)

				local var_60_5 = 26
				local var_60_6 = utf8.len(var_60_4)
				local var_60_7 = var_60_5 <= 0 and var_60_1 or var_60_1 * (var_60_6 / var_60_5)

				if var_60_7 > 0 and var_60_1 < var_60_7 then
					arg_57_1.talkMaxDuration = var_60_7

					if var_60_7 + var_60_0 > arg_57_1.duration_ then
						arg_57_1.duration_ = var_60_7 + var_60_0
					end
				end

				arg_57_1.text_.text = var_60_4
				arg_57_1.typewritter.percent = 0

				arg_57_1.typewritter:SetDirty()
				arg_57_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_319501", "319501014", "story_v_out_319501.awb") ~= 0 then
					local var_60_8 = manager.audio:GetVoiceLength("story_v_out_319501", "319501014", "story_v_out_319501.awb") / 1000

					if var_60_8 + var_60_0 > arg_57_1.duration_ then
						arg_57_1.duration_ = var_60_8 + var_60_0
					end

					if var_60_3.prefab_name ~= "" and arg_57_1.actors_[var_60_3.prefab_name] ~= nil then
						local var_60_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_57_1.actors_[var_60_3.prefab_name].transform, "story_v_out_319501", "319501014", "story_v_out_319501.awb")

						arg_57_1:RecordAudio("319501014", var_60_9)
						arg_57_1:RecordAudio("319501014", var_60_9)
					else
						arg_57_1:AudioAction("play", "voice", "story_v_out_319501", "319501014", "story_v_out_319501.awb")
					end

					arg_57_1:RecordHistoryTalkVoice("story_v_out_319501", "319501014", "story_v_out_319501.awb")
				end

				arg_57_1:RecordContent(arg_57_1.text_.text)
			end

			local var_60_10 = math.max(var_60_1, arg_57_1.talkMaxDuration)

			if var_60_0 <= arg_57_1.time_ and arg_57_1.time_ < var_60_0 + var_60_10 then
				arg_57_1.typewritter.percent = (arg_57_1.time_ - var_60_0) / var_60_10

				arg_57_1.typewritter:SetDirty()
			end

			if arg_57_1.time_ >= var_60_0 + var_60_10 and arg_57_1.time_ < var_60_0 + var_60_10 + arg_60_0 then
				arg_57_1.typewritter.percent = 1

				arg_57_1.typewritter:SetDirty()
				arg_57_1:ShowNextGo(true)
			end
		end

		arg_57_1.nodeConfigList_ = {}

		arg_57_1:InitPlayNodeList()
	end,
	Play319501015 = function(arg_61_0, arg_61_1)
		arg_61_1.time_ = 0
		arg_61_1.frameCnt_ = 0
		arg_61_1.state_ = "playing"
		arg_61_1.curTalkId_ = 319501015
		arg_61_1.duration_ = 2

		SetActive(arg_61_1.tipsGo_, false)

		function arg_61_1.onSingleLineFinish_()
			arg_61_1.onSingleLineUpdate_ = nil
			arg_61_1.onSingleLineFinish_ = nil
			arg_61_1.state_ = "waiting"
		end

		function arg_61_1.playNext_(arg_63_0)
			if arg_63_0 == 1 then
				arg_61_0:Play319501016(arg_61_1)
			end
		end

		function arg_61_1.onSingleLineUpdate_(arg_64_0)
			local var_64_0 = arg_61_1.actors_["10069ui_story"]
			local var_64_1 = 0

			if var_64_1 < arg_61_1.time_ and arg_61_1.time_ <= var_64_1 + arg_64_0 and not isNil(var_64_0) and arg_61_1.var_.characterEffect10069ui_story == nil then
				arg_61_1.var_.characterEffect10069ui_story = var_64_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_64_2 = 0.200000002980232

			if var_64_1 <= arg_61_1.time_ and arg_61_1.time_ < var_64_1 + var_64_2 and not isNil(var_64_0) then
				local var_64_3 = (arg_61_1.time_ - var_64_1) / var_64_2

				if arg_61_1.var_.characterEffect10069ui_story and not isNil(var_64_0) then
					arg_61_1.var_.characterEffect10069ui_story.fillFlat = false
				end
			end

			if arg_61_1.time_ >= var_64_1 + var_64_2 and arg_61_1.time_ < var_64_1 + var_64_2 + arg_64_0 and not isNil(var_64_0) and arg_61_1.var_.characterEffect10069ui_story then
				arg_61_1.var_.characterEffect10069ui_story.fillFlat = false
			end

			local var_64_4 = 0

			if var_64_4 < arg_61_1.time_ and arg_61_1.time_ <= var_64_4 + arg_64_0 then
				arg_61_1:PlayTimeline("10069ui_story", "StoryTimeline/CharAction/story10056/story10056action/10056action1_1")
			end

			local var_64_5 = 0

			if var_64_5 < arg_61_1.time_ and arg_61_1.time_ <= var_64_5 + arg_64_0 then
				arg_61_1:PlayTimeline("10069ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_64_6 = arg_61_1.actors_["1084ui_story"]
			local var_64_7 = 0

			if var_64_7 < arg_61_1.time_ and arg_61_1.time_ <= var_64_7 + arg_64_0 and not isNil(var_64_6) and arg_61_1.var_.characterEffect1084ui_story == nil then
				arg_61_1.var_.characterEffect1084ui_story = var_64_6:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_64_8 = 0.200000002980232

			if var_64_7 <= arg_61_1.time_ and arg_61_1.time_ < var_64_7 + var_64_8 and not isNil(var_64_6) then
				local var_64_9 = (arg_61_1.time_ - var_64_7) / var_64_8

				if arg_61_1.var_.characterEffect1084ui_story and not isNil(var_64_6) then
					local var_64_10 = Mathf.Lerp(0, 0.5, var_64_9)

					arg_61_1.var_.characterEffect1084ui_story.fillFlat = true
					arg_61_1.var_.characterEffect1084ui_story.fillRatio = var_64_10
				end
			end

			if arg_61_1.time_ >= var_64_7 + var_64_8 and arg_61_1.time_ < var_64_7 + var_64_8 + arg_64_0 and not isNil(var_64_6) and arg_61_1.var_.characterEffect1084ui_story then
				local var_64_11 = 0.5

				arg_61_1.var_.characterEffect1084ui_story.fillFlat = true
				arg_61_1.var_.characterEffect1084ui_story.fillRatio = var_64_11
			end

			local var_64_12 = 0
			local var_64_13 = 0.15

			if var_64_12 < arg_61_1.time_ and arg_61_1.time_ <= var_64_12 + arg_64_0 then
				arg_61_1.talkMaxDuration = 0
				arg_61_1.dialogCg_.alpha = 1

				arg_61_1.dialog_:SetActive(true)
				SetActive(arg_61_1.leftNameGo_, true)

				local var_64_14 = arg_61_1:FormatText(StoryNameCfg[693].name)

				arg_61_1.leftNameTxt_.text = var_64_14

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_61_1.leftNameTxt_.transform)

				arg_61_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_61_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_61_1:RecordName(arg_61_1.leftNameTxt_.text)
				SetActive(arg_61_1.iconTrs_.gameObject, false)
				arg_61_1.callingController_:SetSelectedState("normal")

				local var_64_15 = arg_61_1:GetWordFromCfg(319501015)
				local var_64_16 = arg_61_1:FormatText(var_64_15.content)

				arg_61_1.text_.text = var_64_16

				LuaForUtil.ClearLinePrefixSymbol(arg_61_1.text_)

				local var_64_17 = 6
				local var_64_18 = utf8.len(var_64_16)
				local var_64_19 = var_64_17 <= 0 and var_64_13 or var_64_13 * (var_64_18 / var_64_17)

				if var_64_19 > 0 and var_64_13 < var_64_19 then
					arg_61_1.talkMaxDuration = var_64_19

					if var_64_19 + var_64_12 > arg_61_1.duration_ then
						arg_61_1.duration_ = var_64_19 + var_64_12
					end
				end

				arg_61_1.text_.text = var_64_16
				arg_61_1.typewritter.percent = 0

				arg_61_1.typewritter:SetDirty()
				arg_61_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_319501", "319501015", "story_v_out_319501.awb") ~= 0 then
					local var_64_20 = manager.audio:GetVoiceLength("story_v_out_319501", "319501015", "story_v_out_319501.awb") / 1000

					if var_64_20 + var_64_12 > arg_61_1.duration_ then
						arg_61_1.duration_ = var_64_20 + var_64_12
					end

					if var_64_15.prefab_name ~= "" and arg_61_1.actors_[var_64_15.prefab_name] ~= nil then
						local var_64_21 = LuaForUtil.PlayVoiceWithCriLipsync(arg_61_1.actors_[var_64_15.prefab_name].transform, "story_v_out_319501", "319501015", "story_v_out_319501.awb")

						arg_61_1:RecordAudio("319501015", var_64_21)
						arg_61_1:RecordAudio("319501015", var_64_21)
					else
						arg_61_1:AudioAction("play", "voice", "story_v_out_319501", "319501015", "story_v_out_319501.awb")
					end

					arg_61_1:RecordHistoryTalkVoice("story_v_out_319501", "319501015", "story_v_out_319501.awb")
				end

				arg_61_1:RecordContent(arg_61_1.text_.text)
			end

			local var_64_22 = math.max(var_64_13, arg_61_1.talkMaxDuration)

			if var_64_12 <= arg_61_1.time_ and arg_61_1.time_ < var_64_12 + var_64_22 then
				arg_61_1.typewritter.percent = (arg_61_1.time_ - var_64_12) / var_64_22

				arg_61_1.typewritter:SetDirty()
			end

			if arg_61_1.time_ >= var_64_12 + var_64_22 and arg_61_1.time_ < var_64_12 + var_64_22 + arg_64_0 then
				arg_61_1.typewritter.percent = 1

				arg_61_1.typewritter:SetDirty()
				arg_61_1:ShowNextGo(true)
			end
		end

		arg_61_1.nodeConfigList_ = {}

		arg_61_1:InitPlayNodeList()
	end,
	Play319501016 = function(arg_65_0, arg_65_1)
		arg_65_1.time_ = 0
		arg_65_1.frameCnt_ = 0
		arg_65_1.state_ = "playing"
		arg_65_1.curTalkId_ = 319501016
		arg_65_1.duration_ = 5.57

		local var_65_0 = {
			zh = 2.533,
			ja = 5.566
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
				arg_65_0:Play319501017(arg_65_1)
			end
		end

		function arg_65_1.onSingleLineUpdate_(arg_68_0)
			local var_68_0 = arg_65_1.actors_["1084ui_story"]
			local var_68_1 = 0

			if var_68_1 < arg_65_1.time_ and arg_65_1.time_ <= var_68_1 + arg_68_0 and not isNil(var_68_0) and arg_65_1.var_.characterEffect1084ui_story == nil then
				arg_65_1.var_.characterEffect1084ui_story = var_68_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_68_2 = 0.200000002980232

			if var_68_1 <= arg_65_1.time_ and arg_65_1.time_ < var_68_1 + var_68_2 and not isNil(var_68_0) then
				local var_68_3 = (arg_65_1.time_ - var_68_1) / var_68_2

				if arg_65_1.var_.characterEffect1084ui_story and not isNil(var_68_0) then
					arg_65_1.var_.characterEffect1084ui_story.fillFlat = false
				end
			end

			if arg_65_1.time_ >= var_68_1 + var_68_2 and arg_65_1.time_ < var_68_1 + var_68_2 + arg_68_0 and not isNil(var_68_0) and arg_65_1.var_.characterEffect1084ui_story then
				arg_65_1.var_.characterEffect1084ui_story.fillFlat = false
			end

			local var_68_4 = 0

			if var_68_4 < arg_65_1.time_ and arg_65_1.time_ <= var_68_4 + arg_68_0 then
				arg_65_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/story1084/story1084action/1084action3_1")
			end

			local var_68_5 = 0

			if var_68_5 < arg_65_1.time_ and arg_65_1.time_ <= var_68_5 + arg_68_0 then
				arg_65_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface2101cva")
			end

			local var_68_6 = arg_65_1.actors_["10069ui_story"]
			local var_68_7 = 0

			if var_68_7 < arg_65_1.time_ and arg_65_1.time_ <= var_68_7 + arg_68_0 and not isNil(var_68_6) and arg_65_1.var_.characterEffect10069ui_story == nil then
				arg_65_1.var_.characterEffect10069ui_story = var_68_6:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_68_8 = 0.200000002980232

			if var_68_7 <= arg_65_1.time_ and arg_65_1.time_ < var_68_7 + var_68_8 and not isNil(var_68_6) then
				local var_68_9 = (arg_65_1.time_ - var_68_7) / var_68_8

				if arg_65_1.var_.characterEffect10069ui_story and not isNil(var_68_6) then
					local var_68_10 = Mathf.Lerp(0, 0.5, var_68_9)

					arg_65_1.var_.characterEffect10069ui_story.fillFlat = true
					arg_65_1.var_.characterEffect10069ui_story.fillRatio = var_68_10
				end
			end

			if arg_65_1.time_ >= var_68_7 + var_68_8 and arg_65_1.time_ < var_68_7 + var_68_8 + arg_68_0 and not isNil(var_68_6) and arg_65_1.var_.characterEffect10069ui_story then
				local var_68_11 = 0.5

				arg_65_1.var_.characterEffect10069ui_story.fillFlat = true
				arg_65_1.var_.characterEffect10069ui_story.fillRatio = var_68_11
			end

			local var_68_12 = 0
			local var_68_13 = 0.3

			if var_68_12 < arg_65_1.time_ and arg_65_1.time_ <= var_68_12 + arg_68_0 then
				arg_65_1.talkMaxDuration = 0
				arg_65_1.dialogCg_.alpha = 1

				arg_65_1.dialog_:SetActive(true)
				SetActive(arg_65_1.leftNameGo_, true)

				local var_68_14 = arg_65_1:FormatText(StoryNameCfg[6].name)

				arg_65_1.leftNameTxt_.text = var_68_14

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_65_1.leftNameTxt_.transform)

				arg_65_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_65_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_65_1:RecordName(arg_65_1.leftNameTxt_.text)
				SetActive(arg_65_1.iconTrs_.gameObject, false)
				arg_65_1.callingController_:SetSelectedState("normal")

				local var_68_15 = arg_65_1:GetWordFromCfg(319501016)
				local var_68_16 = arg_65_1:FormatText(var_68_15.content)

				arg_65_1.text_.text = var_68_16

				LuaForUtil.ClearLinePrefixSymbol(arg_65_1.text_)

				local var_68_17 = 12
				local var_68_18 = utf8.len(var_68_16)
				local var_68_19 = var_68_17 <= 0 and var_68_13 or var_68_13 * (var_68_18 / var_68_17)

				if var_68_19 > 0 and var_68_13 < var_68_19 then
					arg_65_1.talkMaxDuration = var_68_19

					if var_68_19 + var_68_12 > arg_65_1.duration_ then
						arg_65_1.duration_ = var_68_19 + var_68_12
					end
				end

				arg_65_1.text_.text = var_68_16
				arg_65_1.typewritter.percent = 0

				arg_65_1.typewritter:SetDirty()
				arg_65_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_319501", "319501016", "story_v_out_319501.awb") ~= 0 then
					local var_68_20 = manager.audio:GetVoiceLength("story_v_out_319501", "319501016", "story_v_out_319501.awb") / 1000

					if var_68_20 + var_68_12 > arg_65_1.duration_ then
						arg_65_1.duration_ = var_68_20 + var_68_12
					end

					if var_68_15.prefab_name ~= "" and arg_65_1.actors_[var_68_15.prefab_name] ~= nil then
						local var_68_21 = LuaForUtil.PlayVoiceWithCriLipsync(arg_65_1.actors_[var_68_15.prefab_name].transform, "story_v_out_319501", "319501016", "story_v_out_319501.awb")

						arg_65_1:RecordAudio("319501016", var_68_21)
						arg_65_1:RecordAudio("319501016", var_68_21)
					else
						arg_65_1:AudioAction("play", "voice", "story_v_out_319501", "319501016", "story_v_out_319501.awb")
					end

					arg_65_1:RecordHistoryTalkVoice("story_v_out_319501", "319501016", "story_v_out_319501.awb")
				end

				arg_65_1:RecordContent(arg_65_1.text_.text)
			end

			local var_68_22 = math.max(var_68_13, arg_65_1.talkMaxDuration)

			if var_68_12 <= arg_65_1.time_ and arg_65_1.time_ < var_68_12 + var_68_22 then
				arg_65_1.typewritter.percent = (arg_65_1.time_ - var_68_12) / var_68_22

				arg_65_1.typewritter:SetDirty()
			end

			if arg_65_1.time_ >= var_68_12 + var_68_22 and arg_65_1.time_ < var_68_12 + var_68_22 + arg_68_0 then
				arg_65_1.typewritter.percent = 1

				arg_65_1.typewritter:SetDirty()
				arg_65_1:ShowNextGo(true)
			end
		end

		arg_65_1.nodeConfigList_ = {}

		arg_65_1:InitPlayNodeList()
	end,
	Play319501017 = function(arg_69_0, arg_69_1)
		arg_69_1.time_ = 0
		arg_69_1.frameCnt_ = 0
		arg_69_1.state_ = "playing"
		arg_69_1.curTalkId_ = 319501017
		arg_69_1.duration_ = 8.7

		local var_69_0 = {
			zh = 7.533,
			ja = 8.7
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
				arg_69_0:Play319501018(arg_69_1)
			end
		end

		function arg_69_1.onSingleLineUpdate_(arg_72_0)
			local var_72_0 = arg_69_1.actors_["1084ui_story"]
			local var_72_1 = 0

			if var_72_1 < arg_69_1.time_ and arg_69_1.time_ <= var_72_1 + arg_72_0 and not isNil(var_72_0) and arg_69_1.var_.characterEffect1084ui_story == nil then
				arg_69_1.var_.characterEffect1084ui_story = var_72_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_72_2 = 0.200000002980232

			if var_72_1 <= arg_69_1.time_ and arg_69_1.time_ < var_72_1 + var_72_2 and not isNil(var_72_0) then
				local var_72_3 = (arg_69_1.time_ - var_72_1) / var_72_2

				if arg_69_1.var_.characterEffect1084ui_story and not isNil(var_72_0) then
					local var_72_4 = Mathf.Lerp(0, 0.5, var_72_3)

					arg_69_1.var_.characterEffect1084ui_story.fillFlat = true
					arg_69_1.var_.characterEffect1084ui_story.fillRatio = var_72_4
				end
			end

			if arg_69_1.time_ >= var_72_1 + var_72_2 and arg_69_1.time_ < var_72_1 + var_72_2 + arg_72_0 and not isNil(var_72_0) and arg_69_1.var_.characterEffect1084ui_story then
				local var_72_5 = 0.5

				arg_69_1.var_.characterEffect1084ui_story.fillFlat = true
				arg_69_1.var_.characterEffect1084ui_story.fillRatio = var_72_5
			end

			local var_72_6 = arg_69_1.actors_["10069ui_story"]
			local var_72_7 = 0

			if var_72_7 < arg_69_1.time_ and arg_69_1.time_ <= var_72_7 + arg_72_0 and not isNil(var_72_6) and arg_69_1.var_.characterEffect10069ui_story == nil then
				arg_69_1.var_.characterEffect10069ui_story = var_72_6:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_72_8 = 0.200000002980232

			if var_72_7 <= arg_69_1.time_ and arg_69_1.time_ < var_72_7 + var_72_8 and not isNil(var_72_6) then
				local var_72_9 = (arg_69_1.time_ - var_72_7) / var_72_8

				if arg_69_1.var_.characterEffect10069ui_story and not isNil(var_72_6) then
					arg_69_1.var_.characterEffect10069ui_story.fillFlat = false
				end
			end

			if arg_69_1.time_ >= var_72_7 + var_72_8 and arg_69_1.time_ < var_72_7 + var_72_8 + arg_72_0 and not isNil(var_72_6) and arg_69_1.var_.characterEffect10069ui_story then
				arg_69_1.var_.characterEffect10069ui_story.fillFlat = false
			end

			local var_72_10 = 0
			local var_72_11 = 0.875

			if var_72_10 < arg_69_1.time_ and arg_69_1.time_ <= var_72_10 + arg_72_0 then
				arg_69_1.talkMaxDuration = 0
				arg_69_1.dialogCg_.alpha = 1

				arg_69_1.dialog_:SetActive(true)
				SetActive(arg_69_1.leftNameGo_, true)

				local var_72_12 = arg_69_1:FormatText(StoryNameCfg[693].name)

				arg_69_1.leftNameTxt_.text = var_72_12

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_69_1.leftNameTxt_.transform)

				arg_69_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_69_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_69_1:RecordName(arg_69_1.leftNameTxt_.text)
				SetActive(arg_69_1.iconTrs_.gameObject, false)
				arg_69_1.callingController_:SetSelectedState("normal")

				local var_72_13 = arg_69_1:GetWordFromCfg(319501017)
				local var_72_14 = arg_69_1:FormatText(var_72_13.content)

				arg_69_1.text_.text = var_72_14

				LuaForUtil.ClearLinePrefixSymbol(arg_69_1.text_)

				local var_72_15 = 35
				local var_72_16 = utf8.len(var_72_14)
				local var_72_17 = var_72_15 <= 0 and var_72_11 or var_72_11 * (var_72_16 / var_72_15)

				if var_72_17 > 0 and var_72_11 < var_72_17 then
					arg_69_1.talkMaxDuration = var_72_17

					if var_72_17 + var_72_10 > arg_69_1.duration_ then
						arg_69_1.duration_ = var_72_17 + var_72_10
					end
				end

				arg_69_1.text_.text = var_72_14
				arg_69_1.typewritter.percent = 0

				arg_69_1.typewritter:SetDirty()
				arg_69_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_319501", "319501017", "story_v_out_319501.awb") ~= 0 then
					local var_72_18 = manager.audio:GetVoiceLength("story_v_out_319501", "319501017", "story_v_out_319501.awb") / 1000

					if var_72_18 + var_72_10 > arg_69_1.duration_ then
						arg_69_1.duration_ = var_72_18 + var_72_10
					end

					if var_72_13.prefab_name ~= "" and arg_69_1.actors_[var_72_13.prefab_name] ~= nil then
						local var_72_19 = LuaForUtil.PlayVoiceWithCriLipsync(arg_69_1.actors_[var_72_13.prefab_name].transform, "story_v_out_319501", "319501017", "story_v_out_319501.awb")

						arg_69_1:RecordAudio("319501017", var_72_19)
						arg_69_1:RecordAudio("319501017", var_72_19)
					else
						arg_69_1:AudioAction("play", "voice", "story_v_out_319501", "319501017", "story_v_out_319501.awb")
					end

					arg_69_1:RecordHistoryTalkVoice("story_v_out_319501", "319501017", "story_v_out_319501.awb")
				end

				arg_69_1:RecordContent(arg_69_1.text_.text)
			end

			local var_72_20 = math.max(var_72_11, arg_69_1.talkMaxDuration)

			if var_72_10 <= arg_69_1.time_ and arg_69_1.time_ < var_72_10 + var_72_20 then
				arg_69_1.typewritter.percent = (arg_69_1.time_ - var_72_10) / var_72_20

				arg_69_1.typewritter:SetDirty()
			end

			if arg_69_1.time_ >= var_72_10 + var_72_20 and arg_69_1.time_ < var_72_10 + var_72_20 + arg_72_0 then
				arg_69_1.typewritter.percent = 1

				arg_69_1.typewritter:SetDirty()
				arg_69_1:ShowNextGo(true)
			end
		end

		arg_69_1.nodeConfigList_ = {}

		arg_69_1:InitPlayNodeList()
	end,
	Play319501018 = function(arg_73_0, arg_73_1)
		arg_73_1.time_ = 0
		arg_73_1.frameCnt_ = 0
		arg_73_1.state_ = "playing"
		arg_73_1.curTalkId_ = 319501018
		arg_73_1.duration_ = 5

		SetActive(arg_73_1.tipsGo_, false)

		function arg_73_1.onSingleLineFinish_()
			arg_73_1.onSingleLineUpdate_ = nil
			arg_73_1.onSingleLineFinish_ = nil
			arg_73_1.state_ = "waiting"
		end

		function arg_73_1.playNext_(arg_75_0)
			if arg_75_0 == 1 then
				arg_73_0:Play319501019(arg_73_1)
			end
		end

		function arg_73_1.onSingleLineUpdate_(arg_76_0)
			local var_76_0 = arg_73_1.actors_["10069ui_story"]
			local var_76_1 = 0

			if var_76_1 < arg_73_1.time_ and arg_73_1.time_ <= var_76_1 + arg_76_0 and not isNil(var_76_0) and arg_73_1.var_.characterEffect10069ui_story == nil then
				arg_73_1.var_.characterEffect10069ui_story = var_76_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_76_2 = 0.200000002980232

			if var_76_1 <= arg_73_1.time_ and arg_73_1.time_ < var_76_1 + var_76_2 and not isNil(var_76_0) then
				local var_76_3 = (arg_73_1.time_ - var_76_1) / var_76_2

				if arg_73_1.var_.characterEffect10069ui_story and not isNil(var_76_0) then
					local var_76_4 = Mathf.Lerp(0, 0.5, var_76_3)

					arg_73_1.var_.characterEffect10069ui_story.fillFlat = true
					arg_73_1.var_.characterEffect10069ui_story.fillRatio = var_76_4
				end
			end

			if arg_73_1.time_ >= var_76_1 + var_76_2 and arg_73_1.time_ < var_76_1 + var_76_2 + arg_76_0 and not isNil(var_76_0) and arg_73_1.var_.characterEffect10069ui_story then
				local var_76_5 = 0.5

				arg_73_1.var_.characterEffect10069ui_story.fillFlat = true
				arg_73_1.var_.characterEffect10069ui_story.fillRatio = var_76_5
			end

			local var_76_6 = 0

			if var_76_6 < arg_73_1.time_ and arg_73_1.time_ <= var_76_6 + arg_76_0 then
				arg_73_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/story1084/story1084action/1084action3_2")
			end

			local var_76_7 = 0

			if var_76_7 < arg_73_1.time_ and arg_73_1.time_ <= var_76_7 + arg_76_0 then
				arg_73_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3201cva")
			end

			local var_76_8 = 0
			local var_76_9 = 1.575

			if var_76_8 < arg_73_1.time_ and arg_73_1.time_ <= var_76_8 + arg_76_0 then
				arg_73_1.talkMaxDuration = 0
				arg_73_1.dialogCg_.alpha = 1

				arg_73_1.dialog_:SetActive(true)
				SetActive(arg_73_1.leftNameGo_, false)

				arg_73_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_73_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_73_1:RecordName(arg_73_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_73_1.iconTrs_.gameObject, false)
				arg_73_1.callingController_:SetSelectedState("normal")

				local var_76_10 = arg_73_1:GetWordFromCfg(319501018)
				local var_76_11 = arg_73_1:FormatText(var_76_10.content)

				arg_73_1.text_.text = var_76_11

				LuaForUtil.ClearLinePrefixSymbol(arg_73_1.text_)

				local var_76_12 = 63
				local var_76_13 = utf8.len(var_76_11)
				local var_76_14 = var_76_12 <= 0 and var_76_9 or var_76_9 * (var_76_13 / var_76_12)

				if var_76_14 > 0 and var_76_9 < var_76_14 then
					arg_73_1.talkMaxDuration = var_76_14

					if var_76_14 + var_76_8 > arg_73_1.duration_ then
						arg_73_1.duration_ = var_76_14 + var_76_8
					end
				end

				arg_73_1.text_.text = var_76_11
				arg_73_1.typewritter.percent = 0

				arg_73_1.typewritter:SetDirty()
				arg_73_1:ShowNextGo(false)
				arg_73_1:RecordContent(arg_73_1.text_.text)
			end

			local var_76_15 = math.max(var_76_9, arg_73_1.talkMaxDuration)

			if var_76_8 <= arg_73_1.time_ and arg_73_1.time_ < var_76_8 + var_76_15 then
				arg_73_1.typewritter.percent = (arg_73_1.time_ - var_76_8) / var_76_15

				arg_73_1.typewritter:SetDirty()
			end

			if arg_73_1.time_ >= var_76_8 + var_76_15 and arg_73_1.time_ < var_76_8 + var_76_15 + arg_76_0 then
				arg_73_1.typewritter.percent = 1

				arg_73_1.typewritter:SetDirty()
				arg_73_1:ShowNextGo(true)
			end
		end

		arg_73_1.nodeConfigList_ = {}

		arg_73_1:InitPlayNodeList()
	end,
	Play319501019 = function(arg_77_0, arg_77_1)
		arg_77_1.time_ = 0
		arg_77_1.frameCnt_ = 0
		arg_77_1.state_ = "playing"
		arg_77_1.curTalkId_ = 319501019
		arg_77_1.duration_ = 5

		SetActive(arg_77_1.tipsGo_, false)

		function arg_77_1.onSingleLineFinish_()
			arg_77_1.onSingleLineUpdate_ = nil
			arg_77_1.onSingleLineFinish_ = nil
			arg_77_1.state_ = "waiting"
		end

		function arg_77_1.playNext_(arg_79_0)
			if arg_79_0 == 1 then
				arg_77_0:Play319501020(arg_77_1)
			end
		end

		function arg_77_1.onSingleLineUpdate_(arg_80_0)
			local var_80_0 = 0
			local var_80_1 = 1.025

			if var_80_0 < arg_77_1.time_ and arg_77_1.time_ <= var_80_0 + arg_80_0 then
				arg_77_1.talkMaxDuration = 0
				arg_77_1.dialogCg_.alpha = 1

				arg_77_1.dialog_:SetActive(true)
				SetActive(arg_77_1.leftNameGo_, false)

				arg_77_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_77_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_77_1:RecordName(arg_77_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_77_1.iconTrs_.gameObject, false)
				arg_77_1.callingController_:SetSelectedState("normal")

				local var_80_2 = arg_77_1:GetWordFromCfg(319501019)
				local var_80_3 = arg_77_1:FormatText(var_80_2.content)

				arg_77_1.text_.text = var_80_3

				LuaForUtil.ClearLinePrefixSymbol(arg_77_1.text_)

				local var_80_4 = 41
				local var_80_5 = utf8.len(var_80_3)
				local var_80_6 = var_80_4 <= 0 and var_80_1 or var_80_1 * (var_80_5 / var_80_4)

				if var_80_6 > 0 and var_80_1 < var_80_6 then
					arg_77_1.talkMaxDuration = var_80_6

					if var_80_6 + var_80_0 > arg_77_1.duration_ then
						arg_77_1.duration_ = var_80_6 + var_80_0
					end
				end

				arg_77_1.text_.text = var_80_3
				arg_77_1.typewritter.percent = 0

				arg_77_1.typewritter:SetDirty()
				arg_77_1:ShowNextGo(false)
				arg_77_1:RecordContent(arg_77_1.text_.text)
			end

			local var_80_7 = math.max(var_80_1, arg_77_1.talkMaxDuration)

			if var_80_0 <= arg_77_1.time_ and arg_77_1.time_ < var_80_0 + var_80_7 then
				arg_77_1.typewritter.percent = (arg_77_1.time_ - var_80_0) / var_80_7

				arg_77_1.typewritter:SetDirty()
			end

			if arg_77_1.time_ >= var_80_0 + var_80_7 and arg_77_1.time_ < var_80_0 + var_80_7 + arg_80_0 then
				arg_77_1.typewritter.percent = 1

				arg_77_1.typewritter:SetDirty()
				arg_77_1:ShowNextGo(true)
			end
		end

		arg_77_1.nodeConfigList_ = {}

		arg_77_1:InitPlayNodeList()
	end,
	Play319501020 = function(arg_81_0, arg_81_1)
		arg_81_1.time_ = 0
		arg_81_1.frameCnt_ = 0
		arg_81_1.state_ = "playing"
		arg_81_1.curTalkId_ = 319501020
		arg_81_1.duration_ = 6.67

		local var_81_0 = {
			zh = 3.766,
			ja = 6.666
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
				arg_81_0:Play319501021(arg_81_1)
			end
		end

		function arg_81_1.onSingleLineUpdate_(arg_84_0)
			local var_84_0 = arg_81_1.actors_["1084ui_story"]
			local var_84_1 = 0

			if var_84_1 < arg_81_1.time_ and arg_81_1.time_ <= var_84_1 + arg_84_0 and not isNil(var_84_0) and arg_81_1.var_.characterEffect1084ui_story == nil then
				arg_81_1.var_.characterEffect1084ui_story = var_84_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_84_2 = 0.200000002980232

			if var_84_1 <= arg_81_1.time_ and arg_81_1.time_ < var_84_1 + var_84_2 and not isNil(var_84_0) then
				local var_84_3 = (arg_81_1.time_ - var_84_1) / var_84_2

				if arg_81_1.var_.characterEffect1084ui_story and not isNil(var_84_0) then
					arg_81_1.var_.characterEffect1084ui_story.fillFlat = false
				end
			end

			if arg_81_1.time_ >= var_84_1 + var_84_2 and arg_81_1.time_ < var_84_1 + var_84_2 + arg_84_0 and not isNil(var_84_0) and arg_81_1.var_.characterEffect1084ui_story then
				arg_81_1.var_.characterEffect1084ui_story.fillFlat = false
			end

			local var_84_4 = 0

			if var_84_4 < arg_81_1.time_ and arg_81_1.time_ <= var_84_4 + arg_84_0 then
				arg_81_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/story1084/story1084action/1084action1_1")
			end

			local var_84_5 = 0

			if var_84_5 < arg_81_1.time_ and arg_81_1.time_ <= var_84_5 + arg_84_0 then
				arg_81_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0101cva")
			end

			local var_84_6 = 0
			local var_84_7 = 0.375

			if var_84_6 < arg_81_1.time_ and arg_81_1.time_ <= var_84_6 + arg_84_0 then
				arg_81_1.talkMaxDuration = 0
				arg_81_1.dialogCg_.alpha = 1

				arg_81_1.dialog_:SetActive(true)
				SetActive(arg_81_1.leftNameGo_, true)

				local var_84_8 = arg_81_1:FormatText(StoryNameCfg[6].name)

				arg_81_1.leftNameTxt_.text = var_84_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_81_1.leftNameTxt_.transform)

				arg_81_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_81_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_81_1:RecordName(arg_81_1.leftNameTxt_.text)
				SetActive(arg_81_1.iconTrs_.gameObject, false)
				arg_81_1.callingController_:SetSelectedState("normal")

				local var_84_9 = arg_81_1:GetWordFromCfg(319501020)
				local var_84_10 = arg_81_1:FormatText(var_84_9.content)

				arg_81_1.text_.text = var_84_10

				LuaForUtil.ClearLinePrefixSymbol(arg_81_1.text_)

				local var_84_11 = 15
				local var_84_12 = utf8.len(var_84_10)
				local var_84_13 = var_84_11 <= 0 and var_84_7 or var_84_7 * (var_84_12 / var_84_11)

				if var_84_13 > 0 and var_84_7 < var_84_13 then
					arg_81_1.talkMaxDuration = var_84_13

					if var_84_13 + var_84_6 > arg_81_1.duration_ then
						arg_81_1.duration_ = var_84_13 + var_84_6
					end
				end

				arg_81_1.text_.text = var_84_10
				arg_81_1.typewritter.percent = 0

				arg_81_1.typewritter:SetDirty()
				arg_81_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_319501", "319501020", "story_v_out_319501.awb") ~= 0 then
					local var_84_14 = manager.audio:GetVoiceLength("story_v_out_319501", "319501020", "story_v_out_319501.awb") / 1000

					if var_84_14 + var_84_6 > arg_81_1.duration_ then
						arg_81_1.duration_ = var_84_14 + var_84_6
					end

					if var_84_9.prefab_name ~= "" and arg_81_1.actors_[var_84_9.prefab_name] ~= nil then
						local var_84_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_81_1.actors_[var_84_9.prefab_name].transform, "story_v_out_319501", "319501020", "story_v_out_319501.awb")

						arg_81_1:RecordAudio("319501020", var_84_15)
						arg_81_1:RecordAudio("319501020", var_84_15)
					else
						arg_81_1:AudioAction("play", "voice", "story_v_out_319501", "319501020", "story_v_out_319501.awb")
					end

					arg_81_1:RecordHistoryTalkVoice("story_v_out_319501", "319501020", "story_v_out_319501.awb")
				end

				arg_81_1:RecordContent(arg_81_1.text_.text)
			end

			local var_84_16 = math.max(var_84_7, arg_81_1.talkMaxDuration)

			if var_84_6 <= arg_81_1.time_ and arg_81_1.time_ < var_84_6 + var_84_16 then
				arg_81_1.typewritter.percent = (arg_81_1.time_ - var_84_6) / var_84_16

				arg_81_1.typewritter:SetDirty()
			end

			if arg_81_1.time_ >= var_84_6 + var_84_16 and arg_81_1.time_ < var_84_6 + var_84_16 + arg_84_0 then
				arg_81_1.typewritter.percent = 1

				arg_81_1.typewritter:SetDirty()
				arg_81_1:ShowNextGo(true)
			end
		end

		arg_81_1.nodeConfigList_ = {}

		arg_81_1:InitPlayNodeList()
	end,
	Play319501021 = function(arg_85_0, arg_85_1)
		arg_85_1.time_ = 0
		arg_85_1.frameCnt_ = 0
		arg_85_1.state_ = "playing"
		arg_85_1.curTalkId_ = 319501021
		arg_85_1.duration_ = 5.5

		local var_85_0 = {
			zh = 4.266,
			ja = 5.5
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
				arg_85_0:Play319501022(arg_85_1)
			end
		end

		function arg_85_1.onSingleLineUpdate_(arg_88_0)
			local var_88_0 = arg_85_1.actors_["1084ui_story"]
			local var_88_1 = 0

			if var_88_1 < arg_85_1.time_ and arg_85_1.time_ <= var_88_1 + arg_88_0 and not isNil(var_88_0) and arg_85_1.var_.characterEffect1084ui_story == nil then
				arg_85_1.var_.characterEffect1084ui_story = var_88_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_88_2 = 0.200000002980232

			if var_88_1 <= arg_85_1.time_ and arg_85_1.time_ < var_88_1 + var_88_2 and not isNil(var_88_0) then
				local var_88_3 = (arg_85_1.time_ - var_88_1) / var_88_2

				if arg_85_1.var_.characterEffect1084ui_story and not isNil(var_88_0) then
					local var_88_4 = Mathf.Lerp(0, 0.5, var_88_3)

					arg_85_1.var_.characterEffect1084ui_story.fillFlat = true
					arg_85_1.var_.characterEffect1084ui_story.fillRatio = var_88_4
				end
			end

			if arg_85_1.time_ >= var_88_1 + var_88_2 and arg_85_1.time_ < var_88_1 + var_88_2 + arg_88_0 and not isNil(var_88_0) and arg_85_1.var_.characterEffect1084ui_story then
				local var_88_5 = 0.5

				arg_85_1.var_.characterEffect1084ui_story.fillFlat = true
				arg_85_1.var_.characterEffect1084ui_story.fillRatio = var_88_5
			end

			local var_88_6 = arg_85_1.actors_["10069ui_story"]
			local var_88_7 = 0

			if var_88_7 < arg_85_1.time_ and arg_85_1.time_ <= var_88_7 + arg_88_0 and not isNil(var_88_6) and arg_85_1.var_.characterEffect10069ui_story == nil then
				arg_85_1.var_.characterEffect10069ui_story = var_88_6:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_88_8 = 0.200000002980232

			if var_88_7 <= arg_85_1.time_ and arg_85_1.time_ < var_88_7 + var_88_8 and not isNil(var_88_6) then
				local var_88_9 = (arg_85_1.time_ - var_88_7) / var_88_8

				if arg_85_1.var_.characterEffect10069ui_story and not isNil(var_88_6) then
					arg_85_1.var_.characterEffect10069ui_story.fillFlat = false
				end
			end

			if arg_85_1.time_ >= var_88_7 + var_88_8 and arg_85_1.time_ < var_88_7 + var_88_8 + arg_88_0 and not isNil(var_88_6) and arg_85_1.var_.characterEffect10069ui_story then
				arg_85_1.var_.characterEffect10069ui_story.fillFlat = false
			end

			local var_88_10 = 0
			local var_88_11 = 0.55

			if var_88_10 < arg_85_1.time_ and arg_85_1.time_ <= var_88_10 + arg_88_0 then
				arg_85_1.talkMaxDuration = 0
				arg_85_1.dialogCg_.alpha = 1

				arg_85_1.dialog_:SetActive(true)
				SetActive(arg_85_1.leftNameGo_, true)

				local var_88_12 = arg_85_1:FormatText(StoryNameCfg[693].name)

				arg_85_1.leftNameTxt_.text = var_88_12

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_85_1.leftNameTxt_.transform)

				arg_85_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_85_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_85_1:RecordName(arg_85_1.leftNameTxt_.text)
				SetActive(arg_85_1.iconTrs_.gameObject, false)
				arg_85_1.callingController_:SetSelectedState("normal")

				local var_88_13 = arg_85_1:GetWordFromCfg(319501021)
				local var_88_14 = arg_85_1:FormatText(var_88_13.content)

				arg_85_1.text_.text = var_88_14

				LuaForUtil.ClearLinePrefixSymbol(arg_85_1.text_)

				local var_88_15 = 22
				local var_88_16 = utf8.len(var_88_14)
				local var_88_17 = var_88_15 <= 0 and var_88_11 or var_88_11 * (var_88_16 / var_88_15)

				if var_88_17 > 0 and var_88_11 < var_88_17 then
					arg_85_1.talkMaxDuration = var_88_17

					if var_88_17 + var_88_10 > arg_85_1.duration_ then
						arg_85_1.duration_ = var_88_17 + var_88_10
					end
				end

				arg_85_1.text_.text = var_88_14
				arg_85_1.typewritter.percent = 0

				arg_85_1.typewritter:SetDirty()
				arg_85_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_319501", "319501021", "story_v_out_319501.awb") ~= 0 then
					local var_88_18 = manager.audio:GetVoiceLength("story_v_out_319501", "319501021", "story_v_out_319501.awb") / 1000

					if var_88_18 + var_88_10 > arg_85_1.duration_ then
						arg_85_1.duration_ = var_88_18 + var_88_10
					end

					if var_88_13.prefab_name ~= "" and arg_85_1.actors_[var_88_13.prefab_name] ~= nil then
						local var_88_19 = LuaForUtil.PlayVoiceWithCriLipsync(arg_85_1.actors_[var_88_13.prefab_name].transform, "story_v_out_319501", "319501021", "story_v_out_319501.awb")

						arg_85_1:RecordAudio("319501021", var_88_19)
						arg_85_1:RecordAudio("319501021", var_88_19)
					else
						arg_85_1:AudioAction("play", "voice", "story_v_out_319501", "319501021", "story_v_out_319501.awb")
					end

					arg_85_1:RecordHistoryTalkVoice("story_v_out_319501", "319501021", "story_v_out_319501.awb")
				end

				arg_85_1:RecordContent(arg_85_1.text_.text)
			end

			local var_88_20 = math.max(var_88_11, arg_85_1.talkMaxDuration)

			if var_88_10 <= arg_85_1.time_ and arg_85_1.time_ < var_88_10 + var_88_20 then
				arg_85_1.typewritter.percent = (arg_85_1.time_ - var_88_10) / var_88_20

				arg_85_1.typewritter:SetDirty()
			end

			if arg_85_1.time_ >= var_88_10 + var_88_20 and arg_85_1.time_ < var_88_10 + var_88_20 + arg_88_0 then
				arg_85_1.typewritter.percent = 1

				arg_85_1.typewritter:SetDirty()
				arg_85_1:ShowNextGo(true)
			end
		end

		arg_85_1.nodeConfigList_ = {}

		arg_85_1:InitPlayNodeList()
	end,
	Play319501022 = function(arg_89_0, arg_89_1)
		arg_89_1.time_ = 0
		arg_89_1.frameCnt_ = 0
		arg_89_1.state_ = "playing"
		arg_89_1.curTalkId_ = 319501022
		arg_89_1.duration_ = 5

		SetActive(arg_89_1.tipsGo_, false)

		function arg_89_1.onSingleLineFinish_()
			arg_89_1.onSingleLineUpdate_ = nil
			arg_89_1.onSingleLineFinish_ = nil
			arg_89_1.state_ = "waiting"
		end

		function arg_89_1.playNext_(arg_91_0)
			if arg_91_0 == 1 then
				arg_89_0:Play319501023(arg_89_1)
			end
		end

		function arg_89_1.onSingleLineUpdate_(arg_92_0)
			local var_92_0 = arg_89_1.actors_["10069ui_story"]
			local var_92_1 = 0

			if var_92_1 < arg_89_1.time_ and arg_89_1.time_ <= var_92_1 + arg_92_0 and not isNil(var_92_0) and arg_89_1.var_.characterEffect10069ui_story == nil then
				arg_89_1.var_.characterEffect10069ui_story = var_92_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_92_2 = 0.200000002980232

			if var_92_1 <= arg_89_1.time_ and arg_89_1.time_ < var_92_1 + var_92_2 and not isNil(var_92_0) then
				local var_92_3 = (arg_89_1.time_ - var_92_1) / var_92_2

				if arg_89_1.var_.characterEffect10069ui_story and not isNil(var_92_0) then
					local var_92_4 = Mathf.Lerp(0, 0.5, var_92_3)

					arg_89_1.var_.characterEffect10069ui_story.fillFlat = true
					arg_89_1.var_.characterEffect10069ui_story.fillRatio = var_92_4
				end
			end

			if arg_89_1.time_ >= var_92_1 + var_92_2 and arg_89_1.time_ < var_92_1 + var_92_2 + arg_92_0 and not isNil(var_92_0) and arg_89_1.var_.characterEffect10069ui_story then
				local var_92_5 = 0.5

				arg_89_1.var_.characterEffect10069ui_story.fillFlat = true
				arg_89_1.var_.characterEffect10069ui_story.fillRatio = var_92_5
			end

			local var_92_6 = 0
			local var_92_7 = 0.6

			if var_92_6 < arg_89_1.time_ and arg_89_1.time_ <= var_92_6 + arg_92_0 then
				arg_89_1.talkMaxDuration = 0
				arg_89_1.dialogCg_.alpha = 1

				arg_89_1.dialog_:SetActive(true)
				SetActive(arg_89_1.leftNameGo_, false)

				arg_89_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_89_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_89_1:RecordName(arg_89_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_89_1.iconTrs_.gameObject, false)
				arg_89_1.callingController_:SetSelectedState("normal")

				local var_92_8 = arg_89_1:GetWordFromCfg(319501022)
				local var_92_9 = arg_89_1:FormatText(var_92_8.content)

				arg_89_1.text_.text = var_92_9

				LuaForUtil.ClearLinePrefixSymbol(arg_89_1.text_)

				local var_92_10 = 24
				local var_92_11 = utf8.len(var_92_9)
				local var_92_12 = var_92_10 <= 0 and var_92_7 or var_92_7 * (var_92_11 / var_92_10)

				if var_92_12 > 0 and var_92_7 < var_92_12 then
					arg_89_1.talkMaxDuration = var_92_12

					if var_92_12 + var_92_6 > arg_89_1.duration_ then
						arg_89_1.duration_ = var_92_12 + var_92_6
					end
				end

				arg_89_1.text_.text = var_92_9
				arg_89_1.typewritter.percent = 0

				arg_89_1.typewritter:SetDirty()
				arg_89_1:ShowNextGo(false)
				arg_89_1:RecordContent(arg_89_1.text_.text)
			end

			local var_92_13 = math.max(var_92_7, arg_89_1.talkMaxDuration)

			if var_92_6 <= arg_89_1.time_ and arg_89_1.time_ < var_92_6 + var_92_13 then
				arg_89_1.typewritter.percent = (arg_89_1.time_ - var_92_6) / var_92_13

				arg_89_1.typewritter:SetDirty()
			end

			if arg_89_1.time_ >= var_92_6 + var_92_13 and arg_89_1.time_ < var_92_6 + var_92_13 + arg_92_0 then
				arg_89_1.typewritter.percent = 1

				arg_89_1.typewritter:SetDirty()
				arg_89_1:ShowNextGo(true)
			end
		end

		arg_89_1.nodeConfigList_ = {}

		arg_89_1:InitPlayNodeList()
	end,
	Play319501023 = function(arg_93_0, arg_93_1)
		arg_93_1.time_ = 0
		arg_93_1.frameCnt_ = 0
		arg_93_1.state_ = "playing"
		arg_93_1.curTalkId_ = 319501023
		arg_93_1.duration_ = 5

		SetActive(arg_93_1.tipsGo_, false)

		function arg_93_1.onSingleLineFinish_()
			arg_93_1.onSingleLineUpdate_ = nil
			arg_93_1.onSingleLineFinish_ = nil
			arg_93_1.state_ = "waiting"
		end

		function arg_93_1.playNext_(arg_95_0)
			if arg_95_0 == 1 then
				arg_93_0:Play319501024(arg_93_1)
			end
		end

		function arg_93_1.onSingleLineUpdate_(arg_96_0)
			local var_96_0 = 0
			local var_96_1 = 0.875

			if var_96_0 < arg_93_1.time_ and arg_93_1.time_ <= var_96_0 + arg_96_0 then
				arg_93_1.talkMaxDuration = 0
				arg_93_1.dialogCg_.alpha = 1

				arg_93_1.dialog_:SetActive(true)
				SetActive(arg_93_1.leftNameGo_, false)

				arg_93_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_93_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_93_1:RecordName(arg_93_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_93_1.iconTrs_.gameObject, false)
				arg_93_1.callingController_:SetSelectedState("normal")

				local var_96_2 = arg_93_1:GetWordFromCfg(319501023)
				local var_96_3 = arg_93_1:FormatText(var_96_2.content)

				arg_93_1.text_.text = var_96_3

				LuaForUtil.ClearLinePrefixSymbol(arg_93_1.text_)

				local var_96_4 = 35
				local var_96_5 = utf8.len(var_96_3)
				local var_96_6 = var_96_4 <= 0 and var_96_1 or var_96_1 * (var_96_5 / var_96_4)

				if var_96_6 > 0 and var_96_1 < var_96_6 then
					arg_93_1.talkMaxDuration = var_96_6

					if var_96_6 + var_96_0 > arg_93_1.duration_ then
						arg_93_1.duration_ = var_96_6 + var_96_0
					end
				end

				arg_93_1.text_.text = var_96_3
				arg_93_1.typewritter.percent = 0

				arg_93_1.typewritter:SetDirty()
				arg_93_1:ShowNextGo(false)
				arg_93_1:RecordContent(arg_93_1.text_.text)
			end

			local var_96_7 = math.max(var_96_1, arg_93_1.talkMaxDuration)

			if var_96_0 <= arg_93_1.time_ and arg_93_1.time_ < var_96_0 + var_96_7 then
				arg_93_1.typewritter.percent = (arg_93_1.time_ - var_96_0) / var_96_7

				arg_93_1.typewritter:SetDirty()
			end

			if arg_93_1.time_ >= var_96_0 + var_96_7 and arg_93_1.time_ < var_96_0 + var_96_7 + arg_96_0 then
				arg_93_1.typewritter.percent = 1

				arg_93_1.typewritter:SetDirty()
				arg_93_1:ShowNextGo(true)
			end
		end

		arg_93_1.nodeConfigList_ = {}

		arg_93_1:InitPlayNodeList()
	end,
	Play319501024 = function(arg_97_0, arg_97_1)
		arg_97_1.time_ = 0
		arg_97_1.frameCnt_ = 0
		arg_97_1.state_ = "playing"
		arg_97_1.curTalkId_ = 319501024
		arg_97_1.duration_ = 5.53

		local var_97_0 = {
			zh = 1.999999999999,
			ja = 5.533
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
				arg_97_0:Play319501025(arg_97_1)
			end
		end

		function arg_97_1.onSingleLineUpdate_(arg_100_0)
			local var_100_0 = arg_97_1.actors_["1084ui_story"]
			local var_100_1 = 0

			if var_100_1 < arg_97_1.time_ and arg_97_1.time_ <= var_100_1 + arg_100_0 and not isNil(var_100_0) and arg_97_1.var_.characterEffect1084ui_story == nil then
				arg_97_1.var_.characterEffect1084ui_story = var_100_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_100_2 = 0.200000002980232

			if var_100_1 <= arg_97_1.time_ and arg_97_1.time_ < var_100_1 + var_100_2 and not isNil(var_100_0) then
				local var_100_3 = (arg_97_1.time_ - var_100_1) / var_100_2

				if arg_97_1.var_.characterEffect1084ui_story and not isNil(var_100_0) then
					arg_97_1.var_.characterEffect1084ui_story.fillFlat = false
				end
			end

			if arg_97_1.time_ >= var_100_1 + var_100_2 and arg_97_1.time_ < var_100_1 + var_100_2 + arg_100_0 and not isNil(var_100_0) and arg_97_1.var_.characterEffect1084ui_story then
				arg_97_1.var_.characterEffect1084ui_story.fillFlat = false
			end

			local var_100_4 = 0

			if var_100_4 < arg_97_1.time_ and arg_97_1.time_ <= var_100_4 + arg_100_0 then
				arg_97_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/story1084/story1084action/1084action4_1")
			end

			local var_100_5 = 0

			if var_100_5 < arg_97_1.time_ and arg_97_1.time_ <= var_100_5 + arg_100_0 then
				arg_97_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3201cva")
			end

			local var_100_6 = 0
			local var_100_7 = 0.275

			if var_100_6 < arg_97_1.time_ and arg_97_1.time_ <= var_100_6 + arg_100_0 then
				arg_97_1.talkMaxDuration = 0
				arg_97_1.dialogCg_.alpha = 1

				arg_97_1.dialog_:SetActive(true)
				SetActive(arg_97_1.leftNameGo_, true)

				local var_100_8 = arg_97_1:FormatText(StoryNameCfg[6].name)

				arg_97_1.leftNameTxt_.text = var_100_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_97_1.leftNameTxt_.transform)

				arg_97_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_97_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_97_1:RecordName(arg_97_1.leftNameTxt_.text)
				SetActive(arg_97_1.iconTrs_.gameObject, false)
				arg_97_1.callingController_:SetSelectedState("normal")

				local var_100_9 = arg_97_1:GetWordFromCfg(319501024)
				local var_100_10 = arg_97_1:FormatText(var_100_9.content)

				arg_97_1.text_.text = var_100_10

				LuaForUtil.ClearLinePrefixSymbol(arg_97_1.text_)

				local var_100_11 = 11
				local var_100_12 = utf8.len(var_100_10)
				local var_100_13 = var_100_11 <= 0 and var_100_7 or var_100_7 * (var_100_12 / var_100_11)

				if var_100_13 > 0 and var_100_7 < var_100_13 then
					arg_97_1.talkMaxDuration = var_100_13

					if var_100_13 + var_100_6 > arg_97_1.duration_ then
						arg_97_1.duration_ = var_100_13 + var_100_6
					end
				end

				arg_97_1.text_.text = var_100_10
				arg_97_1.typewritter.percent = 0

				arg_97_1.typewritter:SetDirty()
				arg_97_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_319501", "319501024", "story_v_out_319501.awb") ~= 0 then
					local var_100_14 = manager.audio:GetVoiceLength("story_v_out_319501", "319501024", "story_v_out_319501.awb") / 1000

					if var_100_14 + var_100_6 > arg_97_1.duration_ then
						arg_97_1.duration_ = var_100_14 + var_100_6
					end

					if var_100_9.prefab_name ~= "" and arg_97_1.actors_[var_100_9.prefab_name] ~= nil then
						local var_100_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_97_1.actors_[var_100_9.prefab_name].transform, "story_v_out_319501", "319501024", "story_v_out_319501.awb")

						arg_97_1:RecordAudio("319501024", var_100_15)
						arg_97_1:RecordAudio("319501024", var_100_15)
					else
						arg_97_1:AudioAction("play", "voice", "story_v_out_319501", "319501024", "story_v_out_319501.awb")
					end

					arg_97_1:RecordHistoryTalkVoice("story_v_out_319501", "319501024", "story_v_out_319501.awb")
				end

				arg_97_1:RecordContent(arg_97_1.text_.text)
			end

			local var_100_16 = math.max(var_100_7, arg_97_1.talkMaxDuration)

			if var_100_6 <= arg_97_1.time_ and arg_97_1.time_ < var_100_6 + var_100_16 then
				arg_97_1.typewritter.percent = (arg_97_1.time_ - var_100_6) / var_100_16

				arg_97_1.typewritter:SetDirty()
			end

			if arg_97_1.time_ >= var_100_6 + var_100_16 and arg_97_1.time_ < var_100_6 + var_100_16 + arg_100_0 then
				arg_97_1.typewritter.percent = 1

				arg_97_1.typewritter:SetDirty()
				arg_97_1:ShowNextGo(true)
			end
		end

		arg_97_1.nodeConfigList_ = {}

		arg_97_1:InitPlayNodeList()
	end,
	Play319501025 = function(arg_101_0, arg_101_1)
		arg_101_1.time_ = 0
		arg_101_1.frameCnt_ = 0
		arg_101_1.state_ = "playing"
		arg_101_1.curTalkId_ = 319501025
		arg_101_1.duration_ = 13

		local var_101_0 = {
			zh = 6.166,
			ja = 13
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
				arg_101_0:Play319501026(arg_101_1)
			end
		end

		function arg_101_1.onSingleLineUpdate_(arg_104_0)
			local var_104_0 = arg_101_1.actors_["10069ui_story"]
			local var_104_1 = 0

			if var_104_1 < arg_101_1.time_ and arg_101_1.time_ <= var_104_1 + arg_104_0 and not isNil(var_104_0) and arg_101_1.var_.characterEffect10069ui_story == nil then
				arg_101_1.var_.characterEffect10069ui_story = var_104_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_104_2 = 0.200000002980232

			if var_104_1 <= arg_101_1.time_ and arg_101_1.time_ < var_104_1 + var_104_2 and not isNil(var_104_0) then
				local var_104_3 = (arg_101_1.time_ - var_104_1) / var_104_2

				if arg_101_1.var_.characterEffect10069ui_story and not isNil(var_104_0) then
					arg_101_1.var_.characterEffect10069ui_story.fillFlat = false
				end
			end

			if arg_101_1.time_ >= var_104_1 + var_104_2 and arg_101_1.time_ < var_104_1 + var_104_2 + arg_104_0 and not isNil(var_104_0) and arg_101_1.var_.characterEffect10069ui_story then
				arg_101_1.var_.characterEffect10069ui_story.fillFlat = false
			end

			local var_104_4 = 0

			if var_104_4 < arg_101_1.time_ and arg_101_1.time_ <= var_104_4 + arg_104_0 then
				arg_101_1:PlayTimeline("10069ui_story", "StoryTimeline/CharAction/story10056/story10056action/10056action1_1")
			end

			local var_104_5 = 0

			if var_104_5 < arg_101_1.time_ and arg_101_1.time_ <= var_104_5 + arg_104_0 then
				arg_101_1:PlayTimeline("10069ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_104_6 = arg_101_1.actors_["1084ui_story"]
			local var_104_7 = 0

			if var_104_7 < arg_101_1.time_ and arg_101_1.time_ <= var_104_7 + arg_104_0 and not isNil(var_104_6) and arg_101_1.var_.characterEffect1084ui_story == nil then
				arg_101_1.var_.characterEffect1084ui_story = var_104_6:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_104_8 = 0.200000002980232

			if var_104_7 <= arg_101_1.time_ and arg_101_1.time_ < var_104_7 + var_104_8 and not isNil(var_104_6) then
				local var_104_9 = (arg_101_1.time_ - var_104_7) / var_104_8

				if arg_101_1.var_.characterEffect1084ui_story and not isNil(var_104_6) then
					local var_104_10 = Mathf.Lerp(0, 0.5, var_104_9)

					arg_101_1.var_.characterEffect1084ui_story.fillFlat = true
					arg_101_1.var_.characterEffect1084ui_story.fillRatio = var_104_10
				end
			end

			if arg_101_1.time_ >= var_104_7 + var_104_8 and arg_101_1.time_ < var_104_7 + var_104_8 + arg_104_0 and not isNil(var_104_6) and arg_101_1.var_.characterEffect1084ui_story then
				local var_104_11 = 0.5

				arg_101_1.var_.characterEffect1084ui_story.fillFlat = true
				arg_101_1.var_.characterEffect1084ui_story.fillRatio = var_104_11
			end

			local var_104_12 = 0
			local var_104_13 = 0.675

			if var_104_12 < arg_101_1.time_ and arg_101_1.time_ <= var_104_12 + arg_104_0 then
				arg_101_1.talkMaxDuration = 0
				arg_101_1.dialogCg_.alpha = 1

				arg_101_1.dialog_:SetActive(true)
				SetActive(arg_101_1.leftNameGo_, true)

				local var_104_14 = arg_101_1:FormatText(StoryNameCfg[693].name)

				arg_101_1.leftNameTxt_.text = var_104_14

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_101_1.leftNameTxt_.transform)

				arg_101_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_101_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_101_1:RecordName(arg_101_1.leftNameTxt_.text)
				SetActive(arg_101_1.iconTrs_.gameObject, false)
				arg_101_1.callingController_:SetSelectedState("normal")

				local var_104_15 = arg_101_1:GetWordFromCfg(319501025)
				local var_104_16 = arg_101_1:FormatText(var_104_15.content)

				arg_101_1.text_.text = var_104_16

				LuaForUtil.ClearLinePrefixSymbol(arg_101_1.text_)

				local var_104_17 = 27
				local var_104_18 = utf8.len(var_104_16)
				local var_104_19 = var_104_17 <= 0 and var_104_13 or var_104_13 * (var_104_18 / var_104_17)

				if var_104_19 > 0 and var_104_13 < var_104_19 then
					arg_101_1.talkMaxDuration = var_104_19

					if var_104_19 + var_104_12 > arg_101_1.duration_ then
						arg_101_1.duration_ = var_104_19 + var_104_12
					end
				end

				arg_101_1.text_.text = var_104_16
				arg_101_1.typewritter.percent = 0

				arg_101_1.typewritter:SetDirty()
				arg_101_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_319501", "319501025", "story_v_out_319501.awb") ~= 0 then
					local var_104_20 = manager.audio:GetVoiceLength("story_v_out_319501", "319501025", "story_v_out_319501.awb") / 1000

					if var_104_20 + var_104_12 > arg_101_1.duration_ then
						arg_101_1.duration_ = var_104_20 + var_104_12
					end

					if var_104_15.prefab_name ~= "" and arg_101_1.actors_[var_104_15.prefab_name] ~= nil then
						local var_104_21 = LuaForUtil.PlayVoiceWithCriLipsync(arg_101_1.actors_[var_104_15.prefab_name].transform, "story_v_out_319501", "319501025", "story_v_out_319501.awb")

						arg_101_1:RecordAudio("319501025", var_104_21)
						arg_101_1:RecordAudio("319501025", var_104_21)
					else
						arg_101_1:AudioAction("play", "voice", "story_v_out_319501", "319501025", "story_v_out_319501.awb")
					end

					arg_101_1:RecordHistoryTalkVoice("story_v_out_319501", "319501025", "story_v_out_319501.awb")
				end

				arg_101_1:RecordContent(arg_101_1.text_.text)
			end

			local var_104_22 = math.max(var_104_13, arg_101_1.talkMaxDuration)

			if var_104_12 <= arg_101_1.time_ and arg_101_1.time_ < var_104_12 + var_104_22 then
				arg_101_1.typewritter.percent = (arg_101_1.time_ - var_104_12) / var_104_22

				arg_101_1.typewritter:SetDirty()
			end

			if arg_101_1.time_ >= var_104_12 + var_104_22 and arg_101_1.time_ < var_104_12 + var_104_22 + arg_104_0 then
				arg_101_1.typewritter.percent = 1

				arg_101_1.typewritter:SetDirty()
				arg_101_1:ShowNextGo(true)
			end
		end

		arg_101_1.nodeConfigList_ = {}

		arg_101_1:InitPlayNodeList()
	end,
	Play319501026 = function(arg_105_0, arg_105_1)
		arg_105_1.time_ = 0
		arg_105_1.frameCnt_ = 0
		arg_105_1.state_ = "playing"
		arg_105_1.curTalkId_ = 319501026
		arg_105_1.duration_ = 9.97

		local var_105_0 = {
			zh = 6.066,
			ja = 9.966
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
				arg_105_0:Play319501027(arg_105_1)
			end
		end

		function arg_105_1.onSingleLineUpdate_(arg_108_0)
			local var_108_0 = 0
			local var_108_1 = 0.825

			if var_108_0 < arg_105_1.time_ and arg_105_1.time_ <= var_108_0 + arg_108_0 then
				arg_105_1.talkMaxDuration = 0
				arg_105_1.dialogCg_.alpha = 1

				arg_105_1.dialog_:SetActive(true)
				SetActive(arg_105_1.leftNameGo_, true)

				local var_108_2 = arg_105_1:FormatText(StoryNameCfg[693].name)

				arg_105_1.leftNameTxt_.text = var_108_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_105_1.leftNameTxt_.transform)

				arg_105_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_105_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_105_1:RecordName(arg_105_1.leftNameTxt_.text)
				SetActive(arg_105_1.iconTrs_.gameObject, false)
				arg_105_1.callingController_:SetSelectedState("normal")

				local var_108_3 = arg_105_1:GetWordFromCfg(319501026)
				local var_108_4 = arg_105_1:FormatText(var_108_3.content)

				arg_105_1.text_.text = var_108_4

				LuaForUtil.ClearLinePrefixSymbol(arg_105_1.text_)

				local var_108_5 = 33
				local var_108_6 = utf8.len(var_108_4)
				local var_108_7 = var_108_5 <= 0 and var_108_1 or var_108_1 * (var_108_6 / var_108_5)

				if var_108_7 > 0 and var_108_1 < var_108_7 then
					arg_105_1.talkMaxDuration = var_108_7

					if var_108_7 + var_108_0 > arg_105_1.duration_ then
						arg_105_1.duration_ = var_108_7 + var_108_0
					end
				end

				arg_105_1.text_.text = var_108_4
				arg_105_1.typewritter.percent = 0

				arg_105_1.typewritter:SetDirty()
				arg_105_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_319501", "319501026", "story_v_out_319501.awb") ~= 0 then
					local var_108_8 = manager.audio:GetVoiceLength("story_v_out_319501", "319501026", "story_v_out_319501.awb") / 1000

					if var_108_8 + var_108_0 > arg_105_1.duration_ then
						arg_105_1.duration_ = var_108_8 + var_108_0
					end

					if var_108_3.prefab_name ~= "" and arg_105_1.actors_[var_108_3.prefab_name] ~= nil then
						local var_108_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_105_1.actors_[var_108_3.prefab_name].transform, "story_v_out_319501", "319501026", "story_v_out_319501.awb")

						arg_105_1:RecordAudio("319501026", var_108_9)
						arg_105_1:RecordAudio("319501026", var_108_9)
					else
						arg_105_1:AudioAction("play", "voice", "story_v_out_319501", "319501026", "story_v_out_319501.awb")
					end

					arg_105_1:RecordHistoryTalkVoice("story_v_out_319501", "319501026", "story_v_out_319501.awb")
				end

				arg_105_1:RecordContent(arg_105_1.text_.text)
			end

			local var_108_10 = math.max(var_108_1, arg_105_1.talkMaxDuration)

			if var_108_0 <= arg_105_1.time_ and arg_105_1.time_ < var_108_0 + var_108_10 then
				arg_105_1.typewritter.percent = (arg_105_1.time_ - var_108_0) / var_108_10

				arg_105_1.typewritter:SetDirty()
			end

			if arg_105_1.time_ >= var_108_0 + var_108_10 and arg_105_1.time_ < var_108_0 + var_108_10 + arg_108_0 then
				arg_105_1.typewritter.percent = 1

				arg_105_1.typewritter:SetDirty()
				arg_105_1:ShowNextGo(true)
			end
		end

		arg_105_1.nodeConfigList_ = {}

		arg_105_1:InitPlayNodeList()
	end,
	Play319501027 = function(arg_109_0, arg_109_1)
		arg_109_1.time_ = 0
		arg_109_1.frameCnt_ = 0
		arg_109_1.state_ = "playing"
		arg_109_1.curTalkId_ = 319501027
		arg_109_1.duration_ = 3.33

		local var_109_0 = {
			zh = 2.2,
			ja = 3.333
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
				arg_109_0:Play319501028(arg_109_1)
			end
		end

		function arg_109_1.onSingleLineUpdate_(arg_112_0)
			local var_112_0 = arg_109_1.actors_["1084ui_story"]
			local var_112_1 = 0

			if var_112_1 < arg_109_1.time_ and arg_109_1.time_ <= var_112_1 + arg_112_0 and not isNil(var_112_0) and arg_109_1.var_.characterEffect1084ui_story == nil then
				arg_109_1.var_.characterEffect1084ui_story = var_112_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_112_2 = 0.200000002980232

			if var_112_1 <= arg_109_1.time_ and arg_109_1.time_ < var_112_1 + var_112_2 and not isNil(var_112_0) then
				local var_112_3 = (arg_109_1.time_ - var_112_1) / var_112_2

				if arg_109_1.var_.characterEffect1084ui_story and not isNil(var_112_0) then
					arg_109_1.var_.characterEffect1084ui_story.fillFlat = false
				end
			end

			if arg_109_1.time_ >= var_112_1 + var_112_2 and arg_109_1.time_ < var_112_1 + var_112_2 + arg_112_0 and not isNil(var_112_0) and arg_109_1.var_.characterEffect1084ui_story then
				arg_109_1.var_.characterEffect1084ui_story.fillFlat = false
			end

			local var_112_4 = 0

			if var_112_4 < arg_109_1.time_ and arg_109_1.time_ <= var_112_4 + arg_112_0 then
				arg_109_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/story1084/story1084action/1084action4_2")
			end

			local var_112_5 = 0

			if var_112_5 < arg_109_1.time_ and arg_109_1.time_ <= var_112_5 + arg_112_0 then
				arg_109_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_112_6 = arg_109_1.actors_["10069ui_story"]
			local var_112_7 = 0

			if var_112_7 < arg_109_1.time_ and arg_109_1.time_ <= var_112_7 + arg_112_0 and not isNil(var_112_6) and arg_109_1.var_.characterEffect10069ui_story == nil then
				arg_109_1.var_.characterEffect10069ui_story = var_112_6:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_112_8 = 0.200000002980232

			if var_112_7 <= arg_109_1.time_ and arg_109_1.time_ < var_112_7 + var_112_8 and not isNil(var_112_6) then
				local var_112_9 = (arg_109_1.time_ - var_112_7) / var_112_8

				if arg_109_1.var_.characterEffect10069ui_story and not isNil(var_112_6) then
					local var_112_10 = Mathf.Lerp(0, 0.5, var_112_9)

					arg_109_1.var_.characterEffect10069ui_story.fillFlat = true
					arg_109_1.var_.characterEffect10069ui_story.fillRatio = var_112_10
				end
			end

			if arg_109_1.time_ >= var_112_7 + var_112_8 and arg_109_1.time_ < var_112_7 + var_112_8 + arg_112_0 and not isNil(var_112_6) and arg_109_1.var_.characterEffect10069ui_story then
				local var_112_11 = 0.5

				arg_109_1.var_.characterEffect10069ui_story.fillFlat = true
				arg_109_1.var_.characterEffect10069ui_story.fillRatio = var_112_11
			end

			local var_112_12 = 0
			local var_112_13 = 0.25

			if var_112_12 < arg_109_1.time_ and arg_109_1.time_ <= var_112_12 + arg_112_0 then
				arg_109_1.talkMaxDuration = 0
				arg_109_1.dialogCg_.alpha = 1

				arg_109_1.dialog_:SetActive(true)
				SetActive(arg_109_1.leftNameGo_, true)

				local var_112_14 = arg_109_1:FormatText(StoryNameCfg[6].name)

				arg_109_1.leftNameTxt_.text = var_112_14

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_109_1.leftNameTxt_.transform)

				arg_109_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_109_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_109_1:RecordName(arg_109_1.leftNameTxt_.text)
				SetActive(arg_109_1.iconTrs_.gameObject, false)
				arg_109_1.callingController_:SetSelectedState("normal")

				local var_112_15 = arg_109_1:GetWordFromCfg(319501027)
				local var_112_16 = arg_109_1:FormatText(var_112_15.content)

				arg_109_1.text_.text = var_112_16

				LuaForUtil.ClearLinePrefixSymbol(arg_109_1.text_)

				local var_112_17 = 10
				local var_112_18 = utf8.len(var_112_16)
				local var_112_19 = var_112_17 <= 0 and var_112_13 or var_112_13 * (var_112_18 / var_112_17)

				if var_112_19 > 0 and var_112_13 < var_112_19 then
					arg_109_1.talkMaxDuration = var_112_19

					if var_112_19 + var_112_12 > arg_109_1.duration_ then
						arg_109_1.duration_ = var_112_19 + var_112_12
					end
				end

				arg_109_1.text_.text = var_112_16
				arg_109_1.typewritter.percent = 0

				arg_109_1.typewritter:SetDirty()
				arg_109_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_319501", "319501027", "story_v_out_319501.awb") ~= 0 then
					local var_112_20 = manager.audio:GetVoiceLength("story_v_out_319501", "319501027", "story_v_out_319501.awb") / 1000

					if var_112_20 + var_112_12 > arg_109_1.duration_ then
						arg_109_1.duration_ = var_112_20 + var_112_12
					end

					if var_112_15.prefab_name ~= "" and arg_109_1.actors_[var_112_15.prefab_name] ~= nil then
						local var_112_21 = LuaForUtil.PlayVoiceWithCriLipsync(arg_109_1.actors_[var_112_15.prefab_name].transform, "story_v_out_319501", "319501027", "story_v_out_319501.awb")

						arg_109_1:RecordAudio("319501027", var_112_21)
						arg_109_1:RecordAudio("319501027", var_112_21)
					else
						arg_109_1:AudioAction("play", "voice", "story_v_out_319501", "319501027", "story_v_out_319501.awb")
					end

					arg_109_1:RecordHistoryTalkVoice("story_v_out_319501", "319501027", "story_v_out_319501.awb")
				end

				arg_109_1:RecordContent(arg_109_1.text_.text)
			end

			local var_112_22 = math.max(var_112_13, arg_109_1.talkMaxDuration)

			if var_112_12 <= arg_109_1.time_ and arg_109_1.time_ < var_112_12 + var_112_22 then
				arg_109_1.typewritter.percent = (arg_109_1.time_ - var_112_12) / var_112_22

				arg_109_1.typewritter:SetDirty()
			end

			if arg_109_1.time_ >= var_112_12 + var_112_22 and arg_109_1.time_ < var_112_12 + var_112_22 + arg_112_0 then
				arg_109_1.typewritter.percent = 1

				arg_109_1.typewritter:SetDirty()
				arg_109_1:ShowNextGo(true)
			end
		end

		arg_109_1.nodeConfigList_ = {}

		arg_109_1:InitPlayNodeList()
	end,
	Play319501028 = function(arg_113_0, arg_113_1)
		arg_113_1.time_ = 0
		arg_113_1.frameCnt_ = 0
		arg_113_1.state_ = "playing"
		arg_113_1.curTalkId_ = 319501028
		arg_113_1.duration_ = 6.5

		local var_113_0 = {
			zh = 2.833,
			ja = 6.5
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
				arg_113_0:Play319501029(arg_113_1)
			end
		end

		function arg_113_1.onSingleLineUpdate_(arg_116_0)
			local var_116_0 = arg_113_1.actors_["1084ui_story"]
			local var_116_1 = 0

			if var_116_1 < arg_113_1.time_ and arg_113_1.time_ <= var_116_1 + arg_116_0 and not isNil(var_116_0) and arg_113_1.var_.characterEffect1084ui_story == nil then
				arg_113_1.var_.characterEffect1084ui_story = var_116_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_116_2 = 0.200000002980232

			if var_116_1 <= arg_113_1.time_ and arg_113_1.time_ < var_116_1 + var_116_2 and not isNil(var_116_0) then
				local var_116_3 = (arg_113_1.time_ - var_116_1) / var_116_2

				if arg_113_1.var_.characterEffect1084ui_story and not isNil(var_116_0) then
					local var_116_4 = Mathf.Lerp(0, 0.5, var_116_3)

					arg_113_1.var_.characterEffect1084ui_story.fillFlat = true
					arg_113_1.var_.characterEffect1084ui_story.fillRatio = var_116_4
				end
			end

			if arg_113_1.time_ >= var_116_1 + var_116_2 and arg_113_1.time_ < var_116_1 + var_116_2 + arg_116_0 and not isNil(var_116_0) and arg_113_1.var_.characterEffect1084ui_story then
				local var_116_5 = 0.5

				arg_113_1.var_.characterEffect1084ui_story.fillFlat = true
				arg_113_1.var_.characterEffect1084ui_story.fillRatio = var_116_5
			end

			local var_116_6 = arg_113_1.actors_["10069ui_story"]
			local var_116_7 = 0

			if var_116_7 < arg_113_1.time_ and arg_113_1.time_ <= var_116_7 + arg_116_0 and not isNil(var_116_6) and arg_113_1.var_.characterEffect10069ui_story == nil then
				arg_113_1.var_.characterEffect10069ui_story = var_116_6:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_116_8 = 0.200000002980232

			if var_116_7 <= arg_113_1.time_ and arg_113_1.time_ < var_116_7 + var_116_8 and not isNil(var_116_6) then
				local var_116_9 = (arg_113_1.time_ - var_116_7) / var_116_8

				if arg_113_1.var_.characterEffect10069ui_story and not isNil(var_116_6) then
					arg_113_1.var_.characterEffect10069ui_story.fillFlat = false
				end
			end

			if arg_113_1.time_ >= var_116_7 + var_116_8 and arg_113_1.time_ < var_116_7 + var_116_8 + arg_116_0 and not isNil(var_116_6) and arg_113_1.var_.characterEffect10069ui_story then
				arg_113_1.var_.characterEffect10069ui_story.fillFlat = false
			end

			local var_116_10 = 0
			local var_116_11 = 0.3

			if var_116_10 < arg_113_1.time_ and arg_113_1.time_ <= var_116_10 + arg_116_0 then
				arg_113_1.talkMaxDuration = 0
				arg_113_1.dialogCg_.alpha = 1

				arg_113_1.dialog_:SetActive(true)
				SetActive(arg_113_1.leftNameGo_, true)

				local var_116_12 = arg_113_1:FormatText(StoryNameCfg[693].name)

				arg_113_1.leftNameTxt_.text = var_116_12

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_113_1.leftNameTxt_.transform)

				arg_113_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_113_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_113_1:RecordName(arg_113_1.leftNameTxt_.text)
				SetActive(arg_113_1.iconTrs_.gameObject, false)
				arg_113_1.callingController_:SetSelectedState("normal")

				local var_116_13 = arg_113_1:GetWordFromCfg(319501028)
				local var_116_14 = arg_113_1:FormatText(var_116_13.content)

				arg_113_1.text_.text = var_116_14

				LuaForUtil.ClearLinePrefixSymbol(arg_113_1.text_)

				local var_116_15 = 12
				local var_116_16 = utf8.len(var_116_14)
				local var_116_17 = var_116_15 <= 0 and var_116_11 or var_116_11 * (var_116_16 / var_116_15)

				if var_116_17 > 0 and var_116_11 < var_116_17 then
					arg_113_1.talkMaxDuration = var_116_17

					if var_116_17 + var_116_10 > arg_113_1.duration_ then
						arg_113_1.duration_ = var_116_17 + var_116_10
					end
				end

				arg_113_1.text_.text = var_116_14
				arg_113_1.typewritter.percent = 0

				arg_113_1.typewritter:SetDirty()
				arg_113_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_319501", "319501028", "story_v_out_319501.awb") ~= 0 then
					local var_116_18 = manager.audio:GetVoiceLength("story_v_out_319501", "319501028", "story_v_out_319501.awb") / 1000

					if var_116_18 + var_116_10 > arg_113_1.duration_ then
						arg_113_1.duration_ = var_116_18 + var_116_10
					end

					if var_116_13.prefab_name ~= "" and arg_113_1.actors_[var_116_13.prefab_name] ~= nil then
						local var_116_19 = LuaForUtil.PlayVoiceWithCriLipsync(arg_113_1.actors_[var_116_13.prefab_name].transform, "story_v_out_319501", "319501028", "story_v_out_319501.awb")

						arg_113_1:RecordAudio("319501028", var_116_19)
						arg_113_1:RecordAudio("319501028", var_116_19)
					else
						arg_113_1:AudioAction("play", "voice", "story_v_out_319501", "319501028", "story_v_out_319501.awb")
					end

					arg_113_1:RecordHistoryTalkVoice("story_v_out_319501", "319501028", "story_v_out_319501.awb")
				end

				arg_113_1:RecordContent(arg_113_1.text_.text)
			end

			local var_116_20 = math.max(var_116_11, arg_113_1.talkMaxDuration)

			if var_116_10 <= arg_113_1.time_ and arg_113_1.time_ < var_116_10 + var_116_20 then
				arg_113_1.typewritter.percent = (arg_113_1.time_ - var_116_10) / var_116_20

				arg_113_1.typewritter:SetDirty()
			end

			if arg_113_1.time_ >= var_116_10 + var_116_20 and arg_113_1.time_ < var_116_10 + var_116_20 + arg_116_0 then
				arg_113_1.typewritter.percent = 1

				arg_113_1.typewritter:SetDirty()
				arg_113_1:ShowNextGo(true)
			end
		end

		arg_113_1.nodeConfigList_ = {}

		arg_113_1:InitPlayNodeList()
	end,
	Play319501029 = function(arg_117_0, arg_117_1)
		arg_117_1.time_ = 0
		arg_117_1.frameCnt_ = 0
		arg_117_1.state_ = "playing"
		arg_117_1.curTalkId_ = 319501029
		arg_117_1.duration_ = 11.97

		local var_117_0 = {
			zh = 6.8,
			ja = 11.966
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
				arg_117_0:Play319501030(arg_117_1)
			end
		end

		function arg_117_1.onSingleLineUpdate_(arg_120_0)
			local var_120_0 = 0
			local var_120_1 = 0.825

			if var_120_0 < arg_117_1.time_ and arg_117_1.time_ <= var_120_0 + arg_120_0 then
				arg_117_1.talkMaxDuration = 0
				arg_117_1.dialogCg_.alpha = 1

				arg_117_1.dialog_:SetActive(true)
				SetActive(arg_117_1.leftNameGo_, true)

				local var_120_2 = arg_117_1:FormatText(StoryNameCfg[693].name)

				arg_117_1.leftNameTxt_.text = var_120_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_117_1.leftNameTxt_.transform)

				arg_117_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_117_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_117_1:RecordName(arg_117_1.leftNameTxt_.text)
				SetActive(arg_117_1.iconTrs_.gameObject, false)
				arg_117_1.callingController_:SetSelectedState("normal")

				local var_120_3 = arg_117_1:GetWordFromCfg(319501029)
				local var_120_4 = arg_117_1:FormatText(var_120_3.content)

				arg_117_1.text_.text = var_120_4

				LuaForUtil.ClearLinePrefixSymbol(arg_117_1.text_)

				local var_120_5 = 33
				local var_120_6 = utf8.len(var_120_4)
				local var_120_7 = var_120_5 <= 0 and var_120_1 or var_120_1 * (var_120_6 / var_120_5)

				if var_120_7 > 0 and var_120_1 < var_120_7 then
					arg_117_1.talkMaxDuration = var_120_7

					if var_120_7 + var_120_0 > arg_117_1.duration_ then
						arg_117_1.duration_ = var_120_7 + var_120_0
					end
				end

				arg_117_1.text_.text = var_120_4
				arg_117_1.typewritter.percent = 0

				arg_117_1.typewritter:SetDirty()
				arg_117_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_319501", "319501029", "story_v_out_319501.awb") ~= 0 then
					local var_120_8 = manager.audio:GetVoiceLength("story_v_out_319501", "319501029", "story_v_out_319501.awb") / 1000

					if var_120_8 + var_120_0 > arg_117_1.duration_ then
						arg_117_1.duration_ = var_120_8 + var_120_0
					end

					if var_120_3.prefab_name ~= "" and arg_117_1.actors_[var_120_3.prefab_name] ~= nil then
						local var_120_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_117_1.actors_[var_120_3.prefab_name].transform, "story_v_out_319501", "319501029", "story_v_out_319501.awb")

						arg_117_1:RecordAudio("319501029", var_120_9)
						arg_117_1:RecordAudio("319501029", var_120_9)
					else
						arg_117_1:AudioAction("play", "voice", "story_v_out_319501", "319501029", "story_v_out_319501.awb")
					end

					arg_117_1:RecordHistoryTalkVoice("story_v_out_319501", "319501029", "story_v_out_319501.awb")
				end

				arg_117_1:RecordContent(arg_117_1.text_.text)
			end

			local var_120_10 = math.max(var_120_1, arg_117_1.talkMaxDuration)

			if var_120_0 <= arg_117_1.time_ and arg_117_1.time_ < var_120_0 + var_120_10 then
				arg_117_1.typewritter.percent = (arg_117_1.time_ - var_120_0) / var_120_10

				arg_117_1.typewritter:SetDirty()
			end

			if arg_117_1.time_ >= var_120_0 + var_120_10 and arg_117_1.time_ < var_120_0 + var_120_10 + arg_120_0 then
				arg_117_1.typewritter.percent = 1

				arg_117_1.typewritter:SetDirty()
				arg_117_1:ShowNextGo(true)
			end
		end

		arg_117_1.nodeConfigList_ = {}

		arg_117_1:InitPlayNodeList()
	end,
	Play319501030 = function(arg_121_0, arg_121_1)
		arg_121_1.time_ = 0
		arg_121_1.frameCnt_ = 0
		arg_121_1.state_ = "playing"
		arg_121_1.curTalkId_ = 319501030
		arg_121_1.duration_ = 7.47

		local var_121_0 = {
			zh = 1.999999999999,
			ja = 7.466
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
				arg_121_0:Play319501031(arg_121_1)
			end
		end

		function arg_121_1.onSingleLineUpdate_(arg_124_0)
			local var_124_0 = arg_121_1.actors_["1084ui_story"]
			local var_124_1 = 0

			if var_124_1 < arg_121_1.time_ and arg_121_1.time_ <= var_124_1 + arg_124_0 and not isNil(var_124_0) and arg_121_1.var_.characterEffect1084ui_story == nil then
				arg_121_1.var_.characterEffect1084ui_story = var_124_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_124_2 = 0.200000002980232

			if var_124_1 <= arg_121_1.time_ and arg_121_1.time_ < var_124_1 + var_124_2 and not isNil(var_124_0) then
				local var_124_3 = (arg_121_1.time_ - var_124_1) / var_124_2

				if arg_121_1.var_.characterEffect1084ui_story and not isNil(var_124_0) then
					arg_121_1.var_.characterEffect1084ui_story.fillFlat = false
				end
			end

			if arg_121_1.time_ >= var_124_1 + var_124_2 and arg_121_1.time_ < var_124_1 + var_124_2 + arg_124_0 and not isNil(var_124_0) and arg_121_1.var_.characterEffect1084ui_story then
				arg_121_1.var_.characterEffect1084ui_story.fillFlat = false
			end

			local var_124_4 = 0

			if var_124_4 < arg_121_1.time_ and arg_121_1.time_ <= var_124_4 + arg_124_0 then
				arg_121_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/story1084/story1084action/1084action13_1")
			end

			local var_124_5 = 0

			if var_124_5 < arg_121_1.time_ and arg_121_1.time_ <= var_124_5 + arg_124_0 then
				arg_121_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_124_6 = arg_121_1.actors_["10069ui_story"]
			local var_124_7 = 0

			if var_124_7 < arg_121_1.time_ and arg_121_1.time_ <= var_124_7 + arg_124_0 and not isNil(var_124_6) and arg_121_1.var_.characterEffect10069ui_story == nil then
				arg_121_1.var_.characterEffect10069ui_story = var_124_6:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_124_8 = 0.200000002980232

			if var_124_7 <= arg_121_1.time_ and arg_121_1.time_ < var_124_7 + var_124_8 and not isNil(var_124_6) then
				local var_124_9 = (arg_121_1.time_ - var_124_7) / var_124_8

				if arg_121_1.var_.characterEffect10069ui_story and not isNil(var_124_6) then
					local var_124_10 = Mathf.Lerp(0, 0.5, var_124_9)

					arg_121_1.var_.characterEffect10069ui_story.fillFlat = true
					arg_121_1.var_.characterEffect10069ui_story.fillRatio = var_124_10
				end
			end

			if arg_121_1.time_ >= var_124_7 + var_124_8 and arg_121_1.time_ < var_124_7 + var_124_8 + arg_124_0 and not isNil(var_124_6) and arg_121_1.var_.characterEffect10069ui_story then
				local var_124_11 = 0.5

				arg_121_1.var_.characterEffect10069ui_story.fillFlat = true
				arg_121_1.var_.characterEffect10069ui_story.fillRatio = var_124_11
			end

			local var_124_12 = 0
			local var_124_13 = 0.125

			if var_124_12 < arg_121_1.time_ and arg_121_1.time_ <= var_124_12 + arg_124_0 then
				arg_121_1.talkMaxDuration = 0
				arg_121_1.dialogCg_.alpha = 1

				arg_121_1.dialog_:SetActive(true)
				SetActive(arg_121_1.leftNameGo_, true)

				local var_124_14 = arg_121_1:FormatText(StoryNameCfg[6].name)

				arg_121_1.leftNameTxt_.text = var_124_14

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_121_1.leftNameTxt_.transform)

				arg_121_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_121_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_121_1:RecordName(arg_121_1.leftNameTxt_.text)
				SetActive(arg_121_1.iconTrs_.gameObject, false)
				arg_121_1.callingController_:SetSelectedState("normal")

				local var_124_15 = arg_121_1:GetWordFromCfg(319501030)
				local var_124_16 = arg_121_1:FormatText(var_124_15.content)

				arg_121_1.text_.text = var_124_16

				LuaForUtil.ClearLinePrefixSymbol(arg_121_1.text_)

				local var_124_17 = 5
				local var_124_18 = utf8.len(var_124_16)
				local var_124_19 = var_124_17 <= 0 and var_124_13 or var_124_13 * (var_124_18 / var_124_17)

				if var_124_19 > 0 and var_124_13 < var_124_19 then
					arg_121_1.talkMaxDuration = var_124_19

					if var_124_19 + var_124_12 > arg_121_1.duration_ then
						arg_121_1.duration_ = var_124_19 + var_124_12
					end
				end

				arg_121_1.text_.text = var_124_16
				arg_121_1.typewritter.percent = 0

				arg_121_1.typewritter:SetDirty()
				arg_121_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_319501", "319501030", "story_v_out_319501.awb") ~= 0 then
					local var_124_20 = manager.audio:GetVoiceLength("story_v_out_319501", "319501030", "story_v_out_319501.awb") / 1000

					if var_124_20 + var_124_12 > arg_121_1.duration_ then
						arg_121_1.duration_ = var_124_20 + var_124_12
					end

					if var_124_15.prefab_name ~= "" and arg_121_1.actors_[var_124_15.prefab_name] ~= nil then
						local var_124_21 = LuaForUtil.PlayVoiceWithCriLipsync(arg_121_1.actors_[var_124_15.prefab_name].transform, "story_v_out_319501", "319501030", "story_v_out_319501.awb")

						arg_121_1:RecordAudio("319501030", var_124_21)
						arg_121_1:RecordAudio("319501030", var_124_21)
					else
						arg_121_1:AudioAction("play", "voice", "story_v_out_319501", "319501030", "story_v_out_319501.awb")
					end

					arg_121_1:RecordHistoryTalkVoice("story_v_out_319501", "319501030", "story_v_out_319501.awb")
				end

				arg_121_1:RecordContent(arg_121_1.text_.text)
			end

			local var_124_22 = math.max(var_124_13, arg_121_1.talkMaxDuration)

			if var_124_12 <= arg_121_1.time_ and arg_121_1.time_ < var_124_12 + var_124_22 then
				arg_121_1.typewritter.percent = (arg_121_1.time_ - var_124_12) / var_124_22

				arg_121_1.typewritter:SetDirty()
			end

			if arg_121_1.time_ >= var_124_12 + var_124_22 and arg_121_1.time_ < var_124_12 + var_124_22 + arg_124_0 then
				arg_121_1.typewritter.percent = 1

				arg_121_1.typewritter:SetDirty()
				arg_121_1:ShowNextGo(true)
			end
		end

		arg_121_1.nodeConfigList_ = {}

		arg_121_1:InitPlayNodeList()
	end,
	Play319501031 = function(arg_125_0, arg_125_1)
		arg_125_1.time_ = 0
		arg_125_1.frameCnt_ = 0
		arg_125_1.state_ = "playing"
		arg_125_1.curTalkId_ = 319501031
		arg_125_1.duration_ = 5

		SetActive(arg_125_1.tipsGo_, false)

		function arg_125_1.onSingleLineFinish_()
			arg_125_1.onSingleLineUpdate_ = nil
			arg_125_1.onSingleLineFinish_ = nil
			arg_125_1.state_ = "waiting"
		end

		function arg_125_1.playNext_(arg_127_0)
			if arg_127_0 == 1 then
				arg_125_0:Play319501032(arg_125_1)
			end
		end

		function arg_125_1.onSingleLineUpdate_(arg_128_0)
			local var_128_0 = arg_125_1.actors_["1084ui_story"]
			local var_128_1 = 0

			if var_128_1 < arg_125_1.time_ and arg_125_1.time_ <= var_128_1 + arg_128_0 and not isNil(var_128_0) and arg_125_1.var_.characterEffect1084ui_story == nil then
				arg_125_1.var_.characterEffect1084ui_story = var_128_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_128_2 = 0.200000002980232

			if var_128_1 <= arg_125_1.time_ and arg_125_1.time_ < var_128_1 + var_128_2 and not isNil(var_128_0) then
				local var_128_3 = (arg_125_1.time_ - var_128_1) / var_128_2

				if arg_125_1.var_.characterEffect1084ui_story and not isNil(var_128_0) then
					local var_128_4 = Mathf.Lerp(0, 0.5, var_128_3)

					arg_125_1.var_.characterEffect1084ui_story.fillFlat = true
					arg_125_1.var_.characterEffect1084ui_story.fillRatio = var_128_4
				end
			end

			if arg_125_1.time_ >= var_128_1 + var_128_2 and arg_125_1.time_ < var_128_1 + var_128_2 + arg_128_0 and not isNil(var_128_0) and arg_125_1.var_.characterEffect1084ui_story then
				local var_128_5 = 0.5

				arg_125_1.var_.characterEffect1084ui_story.fillFlat = true
				arg_125_1.var_.characterEffect1084ui_story.fillRatio = var_128_5
			end

			local var_128_6 = 0
			local var_128_7 = 0.925

			if var_128_6 < arg_125_1.time_ and arg_125_1.time_ <= var_128_6 + arg_128_0 then
				arg_125_1.talkMaxDuration = 0
				arg_125_1.dialogCg_.alpha = 1

				arg_125_1.dialog_:SetActive(true)
				SetActive(arg_125_1.leftNameGo_, false)

				arg_125_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_125_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_125_1:RecordName(arg_125_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_125_1.iconTrs_.gameObject, false)
				arg_125_1.callingController_:SetSelectedState("normal")

				local var_128_8 = arg_125_1:GetWordFromCfg(319501031)
				local var_128_9 = arg_125_1:FormatText(var_128_8.content)

				arg_125_1.text_.text = var_128_9

				LuaForUtil.ClearLinePrefixSymbol(arg_125_1.text_)

				local var_128_10 = 37
				local var_128_11 = utf8.len(var_128_9)
				local var_128_12 = var_128_10 <= 0 and var_128_7 or var_128_7 * (var_128_11 / var_128_10)

				if var_128_12 > 0 and var_128_7 < var_128_12 then
					arg_125_1.talkMaxDuration = var_128_12

					if var_128_12 + var_128_6 > arg_125_1.duration_ then
						arg_125_1.duration_ = var_128_12 + var_128_6
					end
				end

				arg_125_1.text_.text = var_128_9
				arg_125_1.typewritter.percent = 0

				arg_125_1.typewritter:SetDirty()
				arg_125_1:ShowNextGo(false)
				arg_125_1:RecordContent(arg_125_1.text_.text)
			end

			local var_128_13 = math.max(var_128_7, arg_125_1.talkMaxDuration)

			if var_128_6 <= arg_125_1.time_ and arg_125_1.time_ < var_128_6 + var_128_13 then
				arg_125_1.typewritter.percent = (arg_125_1.time_ - var_128_6) / var_128_13

				arg_125_1.typewritter:SetDirty()
			end

			if arg_125_1.time_ >= var_128_6 + var_128_13 and arg_125_1.time_ < var_128_6 + var_128_13 + arg_128_0 then
				arg_125_1.typewritter.percent = 1

				arg_125_1.typewritter:SetDirty()
				arg_125_1:ShowNextGo(true)
			end
		end

		arg_125_1.nodeConfigList_ = {}

		arg_125_1:InitPlayNodeList()
	end,
	Play319501032 = function(arg_129_0, arg_129_1)
		arg_129_1.time_ = 0
		arg_129_1.frameCnt_ = 0
		arg_129_1.state_ = "playing"
		arg_129_1.curTalkId_ = 319501032
		arg_129_1.duration_ = 4.72

		SetActive(arg_129_1.tipsGo_, false)

		function arg_129_1.onSingleLineFinish_()
			arg_129_1.onSingleLineUpdate_ = nil
			arg_129_1.onSingleLineFinish_ = nil
			arg_129_1.state_ = "waiting"
		end

		function arg_129_1.playNext_(arg_131_0)
			if arg_131_0 == 1 then
				arg_129_0:Play319501033(arg_129_1)
			end
		end

		function arg_129_1.onSingleLineUpdate_(arg_132_0)
			local var_132_0 = "STblack"

			if arg_129_1.bgs_[var_132_0] == nil then
				local var_132_1 = Object.Instantiate(arg_129_1.paintGo_)

				var_132_1:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. var_132_0)
				var_132_1.name = var_132_0
				var_132_1.transform.parent = arg_129_1.stage_.transform
				var_132_1.transform.localPosition = Vector3.New(0, 100, 0)
				arg_129_1.bgs_[var_132_0] = var_132_1
			end

			local var_132_2 = 2

			if var_132_2 < arg_129_1.time_ and arg_129_1.time_ <= var_132_2 + arg_132_0 then
				local var_132_3 = manager.ui.mainCamera.transform.localPosition
				local var_132_4 = Vector3.New(0, 0, 10) + Vector3.New(var_132_3.x, var_132_3.y, 0)
				local var_132_5 = arg_129_1.bgs_.STblack

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
					if iter_132_0 ~= "STblack" then
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

			local var_132_17 = 2

			if var_132_16 <= arg_129_1.time_ and arg_129_1.time_ < var_132_16 + var_132_17 then
				local var_132_18 = (arg_129_1.time_ - var_132_16) / var_132_17
				local var_132_19 = Color.New(0, 0, 0)

				var_132_19.a = Mathf.Lerp(0, 1, var_132_18)
				arg_129_1.mask_.color = var_132_19
			end

			if arg_129_1.time_ >= var_132_16 + var_132_17 and arg_129_1.time_ < var_132_16 + var_132_17 + arg_132_0 then
				local var_132_20 = Color.New(0, 0, 0)

				var_132_20.a = 1
				arg_129_1.mask_.color = var_132_20
			end

			local var_132_21 = 2

			if var_132_21 < arg_129_1.time_ and arg_129_1.time_ <= var_132_21 + arg_132_0 then
				arg_129_1.mask_.enabled = true
				arg_129_1.mask_.raycastTarget = true

				arg_129_1:SetGaussion(false)
			end

			local var_132_22 = 2

			if var_132_21 <= arg_129_1.time_ and arg_129_1.time_ < var_132_21 + var_132_22 then
				local var_132_23 = (arg_129_1.time_ - var_132_21) / var_132_22
				local var_132_24 = Color.New(0, 0, 0)

				var_132_24.a = Mathf.Lerp(1, 0, var_132_23)
				arg_129_1.mask_.color = var_132_24
			end

			if arg_129_1.time_ >= var_132_21 + var_132_22 and arg_129_1.time_ < var_132_21 + var_132_22 + arg_132_0 then
				local var_132_25 = Color.New(0, 0, 0)
				local var_132_26 = 0

				arg_129_1.mask_.enabled = false
				var_132_25.a = var_132_26
				arg_129_1.mask_.color = var_132_25
			end

			local var_132_27 = arg_129_1.actors_["1084ui_story"].transform
			local var_132_28 = 1.96599999815226

			if var_132_28 < arg_129_1.time_ and arg_129_1.time_ <= var_132_28 + arg_132_0 then
				arg_129_1.var_.moveOldPos1084ui_story = var_132_27.localPosition
			end

			local var_132_29 = 0.001

			if var_132_28 <= arg_129_1.time_ and arg_129_1.time_ < var_132_28 + var_132_29 then
				local var_132_30 = (arg_129_1.time_ - var_132_28) / var_132_29
				local var_132_31 = Vector3.New(0, 100, 0)

				var_132_27.localPosition = Vector3.Lerp(arg_129_1.var_.moveOldPos1084ui_story, var_132_31, var_132_30)

				local var_132_32 = manager.ui.mainCamera.transform.position - var_132_27.position

				var_132_27.forward = Vector3.New(var_132_32.x, var_132_32.y, var_132_32.z)

				local var_132_33 = var_132_27.localEulerAngles

				var_132_33.z = 0
				var_132_33.x = 0
				var_132_27.localEulerAngles = var_132_33
			end

			if arg_129_1.time_ >= var_132_28 + var_132_29 and arg_129_1.time_ < var_132_28 + var_132_29 + arg_132_0 then
				var_132_27.localPosition = Vector3.New(0, 100, 0)

				local var_132_34 = manager.ui.mainCamera.transform.position - var_132_27.position

				var_132_27.forward = Vector3.New(var_132_34.x, var_132_34.y, var_132_34.z)

				local var_132_35 = var_132_27.localEulerAngles

				var_132_35.z = 0
				var_132_35.x = 0
				var_132_27.localEulerAngles = var_132_35
			end

			local var_132_36 = arg_129_1.actors_["1084ui_story"]
			local var_132_37 = 1.96599999815226

			if var_132_37 < arg_129_1.time_ and arg_129_1.time_ <= var_132_37 + arg_132_0 and not isNil(var_132_36) and arg_129_1.var_.characterEffect1084ui_story == nil then
				arg_129_1.var_.characterEffect1084ui_story = var_132_36:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_132_38 = 0.034000001847744

			if var_132_37 <= arg_129_1.time_ and arg_129_1.time_ < var_132_37 + var_132_38 and not isNil(var_132_36) then
				local var_132_39 = (arg_129_1.time_ - var_132_37) / var_132_38

				if arg_129_1.var_.characterEffect1084ui_story and not isNil(var_132_36) then
					local var_132_40 = Mathf.Lerp(0, 0.5, var_132_39)

					arg_129_1.var_.characterEffect1084ui_story.fillFlat = true
					arg_129_1.var_.characterEffect1084ui_story.fillRatio = var_132_40
				end
			end

			if arg_129_1.time_ >= var_132_37 + var_132_38 and arg_129_1.time_ < var_132_37 + var_132_38 + arg_132_0 and not isNil(var_132_36) and arg_129_1.var_.characterEffect1084ui_story then
				local var_132_41 = 0.5

				arg_129_1.var_.characterEffect1084ui_story.fillFlat = true
				arg_129_1.var_.characterEffect1084ui_story.fillRatio = var_132_41
			end

			local var_132_42 = arg_129_1.actors_["10069ui_story"].transform
			local var_132_43 = 1.96599999815226

			if var_132_43 < arg_129_1.time_ and arg_129_1.time_ <= var_132_43 + arg_132_0 then
				arg_129_1.var_.moveOldPos10069ui_story = var_132_42.localPosition
			end

			local var_132_44 = 0.001

			if var_132_43 <= arg_129_1.time_ and arg_129_1.time_ < var_132_43 + var_132_44 then
				local var_132_45 = (arg_129_1.time_ - var_132_43) / var_132_44
				local var_132_46 = Vector3.New(0, 100, 0)

				var_132_42.localPosition = Vector3.Lerp(arg_129_1.var_.moveOldPos10069ui_story, var_132_46, var_132_45)

				local var_132_47 = manager.ui.mainCamera.transform.position - var_132_42.position

				var_132_42.forward = Vector3.New(var_132_47.x, var_132_47.y, var_132_47.z)

				local var_132_48 = var_132_42.localEulerAngles

				var_132_48.z = 0
				var_132_48.x = 0
				var_132_42.localEulerAngles = var_132_48
			end

			if arg_129_1.time_ >= var_132_43 + var_132_44 and arg_129_1.time_ < var_132_43 + var_132_44 + arg_132_0 then
				var_132_42.localPosition = Vector3.New(0, 100, 0)

				local var_132_49 = manager.ui.mainCamera.transform.position - var_132_42.position

				var_132_42.forward = Vector3.New(var_132_49.x, var_132_49.y, var_132_49.z)

				local var_132_50 = var_132_42.localEulerAngles

				var_132_50.z = 0
				var_132_50.x = 0
				var_132_42.localEulerAngles = var_132_50
			end

			local var_132_51 = arg_129_1.actors_["10069ui_story"]
			local var_132_52 = 1.96599999815226

			if var_132_52 < arg_129_1.time_ and arg_129_1.time_ <= var_132_52 + arg_132_0 and not isNil(var_132_51) and arg_129_1.var_.characterEffect10069ui_story == nil then
				arg_129_1.var_.characterEffect10069ui_story = var_132_51:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_132_53 = 0.034000001847744

			if var_132_52 <= arg_129_1.time_ and arg_129_1.time_ < var_132_52 + var_132_53 and not isNil(var_132_51) then
				local var_132_54 = (arg_129_1.time_ - var_132_52) / var_132_53

				if arg_129_1.var_.characterEffect10069ui_story and not isNil(var_132_51) then
					local var_132_55 = Mathf.Lerp(0, 0.5, var_132_54)

					arg_129_1.var_.characterEffect10069ui_story.fillFlat = true
					arg_129_1.var_.characterEffect10069ui_story.fillRatio = var_132_55
				end
			end

			if arg_129_1.time_ >= var_132_52 + var_132_53 and arg_129_1.time_ < var_132_52 + var_132_53 + arg_132_0 and not isNil(var_132_51) and arg_129_1.var_.characterEffect10069ui_story then
				local var_132_56 = 0.5

				arg_129_1.var_.characterEffect10069ui_story.fillFlat = true
				arg_129_1.var_.characterEffect10069ui_story.fillRatio = var_132_56
			end

			local var_132_57 = 1.96599999815226

			if var_132_57 < arg_129_1.time_ and arg_129_1.time_ <= var_132_57 + arg_132_0 then
				arg_129_1.fswbg_:SetActive(true)
				arg_129_1.dialog_:SetActive(false)

				arg_129_1.fswtw_.percent = 0

				local var_132_58 = arg_129_1:GetWordFromCfg(319501032)
				local var_132_59 = arg_129_1:FormatText(var_132_58.content)

				arg_129_1.fswt_.text = var_132_59

				LuaForUtil.ClearLinePrefixSymbol(arg_129_1.fswt_)

				arg_129_1.fswt_:GetComponent("Text").color = Color(1, 1, 1)
				arg_129_1.fswbg_.transform:Find("textbox/bg"):GetComponent("Image").enabled = false

				arg_129_1.fswtw_:SetDirty()

				arg_129_1.typewritterCharCountI18N = 0

				SetActive(arg_129_1.fswtw_.transform.parent.parent:Find("bg/line").gameObject, false)
				arg_129_1:ShowNextGo(false)
			end

			local var_132_60 = 1.98266666481892

			if var_132_60 < arg_129_1.time_ and arg_129_1.time_ <= var_132_60 + arg_132_0 then
				arg_129_1.var_.oldValueTypewriter = arg_129_1.fswtw_.percent

				SetActive(arg_129_1.fswtw_.transform.parent.parent:Find("bg/line").gameObject, false)
				arg_129_1:ShowNextGo(false)
			end

			local var_132_61 = 41
			local var_132_62 = 2.73333333333333
			local var_132_63 = arg_129_1:GetWordFromCfg(319501032)
			local var_132_64 = arg_129_1:FormatText(var_132_63.content)
			local var_132_65, var_132_66 = arg_129_1:GetPercentByPara(var_132_64, 1)

			if var_132_60 < arg_129_1.time_ and arg_129_1.time_ <= var_132_60 + arg_132_0 then
				arg_129_1.talkMaxDuration = 0

				local var_132_67 = var_132_61 <= 0 and var_132_62 or var_132_62 * ((var_132_66 - arg_129_1.typewritterCharCountI18N) / var_132_61)

				if var_132_67 > 0 and var_132_62 < var_132_67 then
					arg_129_1.talkMaxDuration = var_132_67

					if var_132_67 + var_132_60 > arg_129_1.duration_ then
						arg_129_1.duration_ = var_132_67 + var_132_60
					end
				end
			end

			local var_132_68 = 2.73333333333333
			local var_132_69 = math.max(var_132_68, arg_129_1.talkMaxDuration)

			if var_132_60 <= arg_129_1.time_ and arg_129_1.time_ < var_132_60 + var_132_69 then
				local var_132_70 = (arg_129_1.time_ - var_132_60) / var_132_69

				arg_129_1.fswtw_.percent = Mathf.Lerp(arg_129_1.var_.oldValueTypewriter, var_132_65, var_132_70)
				arg_129_1.fswt_:GetComponent("Text").color = Color(1, 1, 1)

				arg_129_1.fswtw_:SetDirty()
			end

			if arg_129_1.time_ >= var_132_60 + var_132_69 and arg_129_1.time_ < var_132_60 + var_132_69 + arg_132_0 then
				arg_129_1.fswtw_.percent = var_132_65

				arg_129_1.fswtw_:SetDirty()
				arg_129_1:ShowNextGo(true)

				arg_129_1.typewritterCharCountI18N = var_132_66
			end

			local var_132_71 = 1.96599999815226

			if var_132_71 < arg_129_1.time_ and arg_129_1.time_ <= var_132_71 + arg_132_0 then
				local var_132_72 = arg_129_1.fswbg_.transform:Find("textbox/adapt/content") or arg_129_1.fswbg_.transform:Find("textbox/content")
				local var_132_73 = arg_129_1.fswbg_.transform:Find("textbox/bg"):GetComponent("Image")
				local var_132_74 = var_132_72:GetComponent("Text")
				local var_132_75 = var_132_72:GetComponent("RectTransform")

				var_132_74.alignment = UnityEngine.TextAnchor.MiddleCenter
				var_132_75.offsetMin = Vector2.New(0, 0)
				var_132_75.offsetMax = Vector2.New(0, 0)
			end
		end

		arg_129_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1084ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 1.96599999815226,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "10069ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 1.96599999815226,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_129_1:InitPlayNodeList()
	end,
	Play319501033 = function(arg_133_0, arg_133_1)
		arg_133_1.time_ = 0
		arg_133_1.frameCnt_ = 0
		arg_133_1.state_ = "playing"
		arg_133_1.curTalkId_ = 319501033
		arg_133_1.duration_ = 8.23

		local var_133_0 = {
			zh = 6.6,
			ja = 8.233
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
				arg_133_0:Play319501034(arg_133_1)
			end
		end

		function arg_133_1.onSingleLineUpdate_(arg_136_0)
			local var_136_0 = 2.00000000298023

			if var_136_0 < arg_133_1.time_ and arg_133_1.time_ <= var_136_0 + arg_136_0 then
				local var_136_1 = manager.ui.mainCamera.transform.localPosition
				local var_136_2 = Vector3.New(0, 0, 10) + Vector3.New(var_136_1.x, var_136_1.y, 0)
				local var_136_3 = arg_133_1.bgs_.ST72

				var_136_3.transform.localPosition = var_136_2
				var_136_3.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_136_4 = var_136_3:GetComponent("SpriteRenderer")

				if var_136_4 and var_136_4.sprite then
					local var_136_5 = (var_136_3.transform.localPosition - var_136_1).z
					local var_136_6 = manager.ui.mainCameraCom_
					local var_136_7 = 2 * var_136_5 * Mathf.Tan(var_136_6.fieldOfView * 0.5 * Mathf.Deg2Rad)
					local var_136_8 = var_136_7 * var_136_6.aspect
					local var_136_9 = var_136_4.sprite.bounds.size.x
					local var_136_10 = var_136_4.sprite.bounds.size.y
					local var_136_11 = var_136_8 / var_136_9
					local var_136_12 = var_136_7 / var_136_10
					local var_136_13 = var_136_12 < var_136_11 and var_136_11 or var_136_12

					var_136_3.transform.localScale = Vector3.New(var_136_13, var_136_13, 0)
				end

				for iter_136_0, iter_136_1 in pairs(arg_133_1.bgs_) do
					if iter_136_0 ~= "ST72" then
						iter_136_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_136_14 = 0

			if var_136_14 < arg_133_1.time_ and arg_133_1.time_ <= var_136_14 + arg_136_0 then
				arg_133_1.mask_.enabled = true
				arg_133_1.mask_.raycastTarget = true

				arg_133_1:SetGaussion(false)
			end

			local var_136_15 = 2

			if var_136_14 <= arg_133_1.time_ and arg_133_1.time_ < var_136_14 + var_136_15 then
				local var_136_16 = (arg_133_1.time_ - var_136_14) / var_136_15
				local var_136_17 = Color.New(0, 0, 0)

				var_136_17.a = Mathf.Lerp(0, 1, var_136_16)
				arg_133_1.mask_.color = var_136_17
			end

			if arg_133_1.time_ >= var_136_14 + var_136_15 and arg_133_1.time_ < var_136_14 + var_136_15 + arg_136_0 then
				local var_136_18 = Color.New(0, 0, 0)

				var_136_18.a = 1
				arg_133_1.mask_.color = var_136_18
			end

			local var_136_19 = 2

			if var_136_19 < arg_133_1.time_ and arg_133_1.time_ <= var_136_19 + arg_136_0 then
				arg_133_1.mask_.enabled = true
				arg_133_1.mask_.raycastTarget = true

				arg_133_1:SetGaussion(false)
			end

			local var_136_20 = 2

			if var_136_19 <= arg_133_1.time_ and arg_133_1.time_ < var_136_19 + var_136_20 then
				local var_136_21 = (arg_133_1.time_ - var_136_19) / var_136_20
				local var_136_22 = Color.New(0, 0, 0)

				var_136_22.a = Mathf.Lerp(1, 0, var_136_21)
				arg_133_1.mask_.color = var_136_22
			end

			if arg_133_1.time_ >= var_136_19 + var_136_20 and arg_133_1.time_ < var_136_19 + var_136_20 + arg_136_0 then
				local var_136_23 = Color.New(0, 0, 0)
				local var_136_24 = 0

				arg_133_1.mask_.enabled = false
				var_136_23.a = var_136_24
				arg_133_1.mask_.color = var_136_23
			end

			local var_136_25 = arg_133_1.actors_["1084ui_story"].transform
			local var_136_26 = 3.8

			if var_136_26 < arg_133_1.time_ and arg_133_1.time_ <= var_136_26 + arg_136_0 then
				arg_133_1.var_.moveOldPos1084ui_story = var_136_25.localPosition
			end

			local var_136_27 = 0.001

			if var_136_26 <= arg_133_1.time_ and arg_133_1.time_ < var_136_26 + var_136_27 then
				local var_136_28 = (arg_133_1.time_ - var_136_26) / var_136_27
				local var_136_29 = Vector3.New(0, -0.97, -6)

				var_136_25.localPosition = Vector3.Lerp(arg_133_1.var_.moveOldPos1084ui_story, var_136_29, var_136_28)

				local var_136_30 = manager.ui.mainCamera.transform.position - var_136_25.position

				var_136_25.forward = Vector3.New(var_136_30.x, var_136_30.y, var_136_30.z)

				local var_136_31 = var_136_25.localEulerAngles

				var_136_31.z = 0
				var_136_31.x = 0
				var_136_25.localEulerAngles = var_136_31
			end

			if arg_133_1.time_ >= var_136_26 + var_136_27 and arg_133_1.time_ < var_136_26 + var_136_27 + arg_136_0 then
				var_136_25.localPosition = Vector3.New(0, -0.97, -6)

				local var_136_32 = manager.ui.mainCamera.transform.position - var_136_25.position

				var_136_25.forward = Vector3.New(var_136_32.x, var_136_32.y, var_136_32.z)

				local var_136_33 = var_136_25.localEulerAngles

				var_136_33.z = 0
				var_136_33.x = 0
				var_136_25.localEulerAngles = var_136_33
			end

			local var_136_34 = arg_133_1.actors_["1084ui_story"]
			local var_136_35 = 3.8

			if var_136_35 < arg_133_1.time_ and arg_133_1.time_ <= var_136_35 + arg_136_0 and not isNil(var_136_34) and arg_133_1.var_.characterEffect1084ui_story == nil then
				arg_133_1.var_.characterEffect1084ui_story = var_136_34:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_136_36 = 0.200000002980232

			if var_136_35 <= arg_133_1.time_ and arg_133_1.time_ < var_136_35 + var_136_36 and not isNil(var_136_34) then
				local var_136_37 = (arg_133_1.time_ - var_136_35) / var_136_36

				if arg_133_1.var_.characterEffect1084ui_story and not isNil(var_136_34) then
					arg_133_1.var_.characterEffect1084ui_story.fillFlat = false
				end
			end

			if arg_133_1.time_ >= var_136_35 + var_136_36 and arg_133_1.time_ < var_136_35 + var_136_36 + arg_136_0 and not isNil(var_136_34) and arg_133_1.var_.characterEffect1084ui_story then
				arg_133_1.var_.characterEffect1084ui_story.fillFlat = false
			end

			local var_136_38 = 3.8

			if var_136_38 < arg_133_1.time_ and arg_133_1.time_ <= var_136_38 + arg_136_0 then
				arg_133_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/story1084/story1084action/1084action1_1")
			end

			local var_136_39 = 3.8

			if var_136_39 < arg_133_1.time_ and arg_133_1.time_ <= var_136_39 + arg_136_0 then
				arg_133_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_136_40 = 2.00000000298023

			if var_136_40 < arg_133_1.time_ and arg_133_1.time_ <= var_136_40 + arg_136_0 then
				arg_133_1.fswbg_:SetActive(false)
				arg_133_1.dialog_:SetActive(false)
				SetActive(arg_133_1.fswtw_.transform.parent.parent:Find("bg/line").gameObject, true)
				arg_133_1:ShowNextGo(false)
			end

			if arg_133_1.frameCnt_ <= 1 then
				arg_133_1.dialog_:SetActive(false)
			end

			local var_136_41 = 4
			local var_136_42 = 0.25

			if var_136_41 < arg_133_1.time_ and arg_133_1.time_ <= var_136_41 + arg_136_0 then
				arg_133_1.talkMaxDuration = 0

				arg_133_1.dialog_:SetActive(true)

				arg_133_1.dialogCg_.alpha = 0

				local var_136_43 = LeanTween.value(arg_133_1.dialog_, 0, 1, 0.3)

				var_136_43:setOnUpdate(LuaHelper.FloatAction(function(arg_137_0)
					arg_133_1.dialogCg_.alpha = arg_137_0
				end))
				var_136_43:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_133_1.dialog_)
					var_136_43:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_133_1.duration_ = arg_133_1.duration_ + 0.3

				SetActive(arg_133_1.leftNameGo_, true)

				local var_136_44 = arg_133_1:FormatText(StoryNameCfg[6].name)

				arg_133_1.leftNameTxt_.text = var_136_44

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_133_1.leftNameTxt_.transform)

				arg_133_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_133_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_133_1:RecordName(arg_133_1.leftNameTxt_.text)
				SetActive(arg_133_1.iconTrs_.gameObject, false)
				arg_133_1.callingController_:SetSelectedState("normal")

				local var_136_45 = arg_133_1:GetWordFromCfg(319501033)
				local var_136_46 = arg_133_1:FormatText(var_136_45.content)

				arg_133_1.text_.text = var_136_46

				LuaForUtil.ClearLinePrefixSymbol(arg_133_1.text_)

				local var_136_47 = 10
				local var_136_48 = utf8.len(var_136_46)
				local var_136_49 = var_136_47 <= 0 and var_136_42 or var_136_42 * (var_136_48 / var_136_47)

				if var_136_49 > 0 and var_136_42 < var_136_49 then
					arg_133_1.talkMaxDuration = var_136_49
					var_136_41 = var_136_41 + 0.3

					if var_136_49 + var_136_41 > arg_133_1.duration_ then
						arg_133_1.duration_ = var_136_49 + var_136_41
					end
				end

				arg_133_1.text_.text = var_136_46
				arg_133_1.typewritter.percent = 0

				arg_133_1.typewritter:SetDirty()
				arg_133_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_319501", "319501033", "story_v_out_319501.awb") ~= 0 then
					local var_136_50 = manager.audio:GetVoiceLength("story_v_out_319501", "319501033", "story_v_out_319501.awb") / 1000

					if var_136_50 + var_136_41 > arg_133_1.duration_ then
						arg_133_1.duration_ = var_136_50 + var_136_41
					end

					if var_136_45.prefab_name ~= "" and arg_133_1.actors_[var_136_45.prefab_name] ~= nil then
						local var_136_51 = LuaForUtil.PlayVoiceWithCriLipsync(arg_133_1.actors_[var_136_45.prefab_name].transform, "story_v_out_319501", "319501033", "story_v_out_319501.awb")

						arg_133_1:RecordAudio("319501033", var_136_51)
						arg_133_1:RecordAudio("319501033", var_136_51)
					else
						arg_133_1:AudioAction("play", "voice", "story_v_out_319501", "319501033", "story_v_out_319501.awb")
					end

					arg_133_1:RecordHistoryTalkVoice("story_v_out_319501", "319501033", "story_v_out_319501.awb")
				end

				arg_133_1:RecordContent(arg_133_1.text_.text)
			end

			local var_136_52 = var_136_41 + 0.3
			local var_136_53 = math.max(var_136_42, arg_133_1.talkMaxDuration)

			if var_136_52 <= arg_133_1.time_ and arg_133_1.time_ < var_136_52 + var_136_53 then
				arg_133_1.typewritter.percent = (arg_133_1.time_ - var_136_52) / var_136_53

				arg_133_1.typewritter:SetDirty()
			end

			if arg_133_1.time_ >= var_136_52 + var_136_53 and arg_133_1.time_ < var_136_52 + var_136_53 + arg_136_0 then
				arg_133_1.typewritter.percent = 1

				arg_133_1.typewritter:SetDirty()
				arg_133_1:ShowNextGo(true)
			end
		end

		arg_133_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1084ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 3.8,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_133_1:InitPlayNodeList()
	end,
	Play319501034 = function(arg_139_0, arg_139_1)
		arg_139_1.time_ = 0
		arg_139_1.frameCnt_ = 0
		arg_139_1.state_ = "playing"
		arg_139_1.curTalkId_ = 319501034
		arg_139_1.duration_ = 11.8

		local var_139_0 = {
			zh = 3.7,
			ja = 11.8
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
				arg_139_0:Play319501035(arg_139_1)
			end
		end

		function arg_139_1.onSingleLineUpdate_(arg_142_0)
			local var_142_0 = arg_139_1.actors_["10069ui_story"].transform
			local var_142_1 = 0

			if var_142_1 < arg_139_1.time_ and arg_139_1.time_ <= var_142_1 + arg_142_0 then
				arg_139_1.var_.moveOldPos10069ui_story = var_142_0.localPosition
			end

			local var_142_2 = 0.001

			if var_142_1 <= arg_139_1.time_ and arg_139_1.time_ < var_142_1 + var_142_2 then
				local var_142_3 = (arg_139_1.time_ - var_142_1) / var_142_2
				local var_142_4 = Vector3.New(0.7, -1.08, -6.33)

				var_142_0.localPosition = Vector3.Lerp(arg_139_1.var_.moveOldPos10069ui_story, var_142_4, var_142_3)

				local var_142_5 = manager.ui.mainCamera.transform.position - var_142_0.position

				var_142_0.forward = Vector3.New(var_142_5.x, var_142_5.y, var_142_5.z)

				local var_142_6 = var_142_0.localEulerAngles

				var_142_6.z = 0
				var_142_6.x = 0
				var_142_0.localEulerAngles = var_142_6
			end

			if arg_139_1.time_ >= var_142_1 + var_142_2 and arg_139_1.time_ < var_142_1 + var_142_2 + arg_142_0 then
				var_142_0.localPosition = Vector3.New(0.7, -1.08, -6.33)

				local var_142_7 = manager.ui.mainCamera.transform.position - var_142_0.position

				var_142_0.forward = Vector3.New(var_142_7.x, var_142_7.y, var_142_7.z)

				local var_142_8 = var_142_0.localEulerAngles

				var_142_8.z = 0
				var_142_8.x = 0
				var_142_0.localEulerAngles = var_142_8
			end

			local var_142_9 = arg_139_1.actors_["10069ui_story"]
			local var_142_10 = 0

			if var_142_10 < arg_139_1.time_ and arg_139_1.time_ <= var_142_10 + arg_142_0 and not isNil(var_142_9) and arg_139_1.var_.characterEffect10069ui_story == nil then
				arg_139_1.var_.characterEffect10069ui_story = var_142_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_142_11 = 0.200000002980232

			if var_142_10 <= arg_139_1.time_ and arg_139_1.time_ < var_142_10 + var_142_11 and not isNil(var_142_9) then
				local var_142_12 = (arg_139_1.time_ - var_142_10) / var_142_11

				if arg_139_1.var_.characterEffect10069ui_story and not isNil(var_142_9) then
					arg_139_1.var_.characterEffect10069ui_story.fillFlat = false
				end
			end

			if arg_139_1.time_ >= var_142_10 + var_142_11 and arg_139_1.time_ < var_142_10 + var_142_11 + arg_142_0 and not isNil(var_142_9) and arg_139_1.var_.characterEffect10069ui_story then
				arg_139_1.var_.characterEffect10069ui_story.fillFlat = false
			end

			local var_142_13 = 0

			if var_142_13 < arg_139_1.time_ and arg_139_1.time_ <= var_142_13 + arg_142_0 then
				arg_139_1:PlayTimeline("10069ui_story", "StoryTimeline/CharAction/story10056/story10056action/10056action1_1")
			end

			local var_142_14 = 0

			if var_142_14 < arg_139_1.time_ and arg_139_1.time_ <= var_142_14 + arg_142_0 then
				arg_139_1:PlayTimeline("10069ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_142_15 = arg_139_1.actors_["1084ui_story"].transform
			local var_142_16 = 0

			if var_142_16 < arg_139_1.time_ and arg_139_1.time_ <= var_142_16 + arg_142_0 then
				arg_139_1.var_.moveOldPos1084ui_story = var_142_15.localPosition
			end

			local var_142_17 = 0.001

			if var_142_16 <= arg_139_1.time_ and arg_139_1.time_ < var_142_16 + var_142_17 then
				local var_142_18 = (arg_139_1.time_ - var_142_16) / var_142_17
				local var_142_19 = Vector3.New(-0.7, -0.97, -6)

				var_142_15.localPosition = Vector3.Lerp(arg_139_1.var_.moveOldPos1084ui_story, var_142_19, var_142_18)

				local var_142_20 = manager.ui.mainCamera.transform.position - var_142_15.position

				var_142_15.forward = Vector3.New(var_142_20.x, var_142_20.y, var_142_20.z)

				local var_142_21 = var_142_15.localEulerAngles

				var_142_21.z = 0
				var_142_21.x = 0
				var_142_15.localEulerAngles = var_142_21
			end

			if arg_139_1.time_ >= var_142_16 + var_142_17 and arg_139_1.time_ < var_142_16 + var_142_17 + arg_142_0 then
				var_142_15.localPosition = Vector3.New(-0.7, -0.97, -6)

				local var_142_22 = manager.ui.mainCamera.transform.position - var_142_15.position

				var_142_15.forward = Vector3.New(var_142_22.x, var_142_22.y, var_142_22.z)

				local var_142_23 = var_142_15.localEulerAngles

				var_142_23.z = 0
				var_142_23.x = 0
				var_142_15.localEulerAngles = var_142_23
			end

			local var_142_24 = arg_139_1.actors_["1084ui_story"]
			local var_142_25 = 0

			if var_142_25 < arg_139_1.time_ and arg_139_1.time_ <= var_142_25 + arg_142_0 and not isNil(var_142_24) and arg_139_1.var_.characterEffect1084ui_story == nil then
				arg_139_1.var_.characterEffect1084ui_story = var_142_24:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_142_26 = 0.200000002980232

			if var_142_25 <= arg_139_1.time_ and arg_139_1.time_ < var_142_25 + var_142_26 and not isNil(var_142_24) then
				local var_142_27 = (arg_139_1.time_ - var_142_25) / var_142_26

				if arg_139_1.var_.characterEffect1084ui_story and not isNil(var_142_24) then
					local var_142_28 = Mathf.Lerp(0, 0.5, var_142_27)

					arg_139_1.var_.characterEffect1084ui_story.fillFlat = true
					arg_139_1.var_.characterEffect1084ui_story.fillRatio = var_142_28
				end
			end

			if arg_139_1.time_ >= var_142_25 + var_142_26 and arg_139_1.time_ < var_142_25 + var_142_26 + arg_142_0 and not isNil(var_142_24) and arg_139_1.var_.characterEffect1084ui_story then
				local var_142_29 = 0.5

				arg_139_1.var_.characterEffect1084ui_story.fillFlat = true
				arg_139_1.var_.characterEffect1084ui_story.fillRatio = var_142_29
			end

			local var_142_30 = 0
			local var_142_31 = 0.425

			if var_142_30 < arg_139_1.time_ and arg_139_1.time_ <= var_142_30 + arg_142_0 then
				arg_139_1.talkMaxDuration = 0
				arg_139_1.dialogCg_.alpha = 1

				arg_139_1.dialog_:SetActive(true)
				SetActive(arg_139_1.leftNameGo_, true)

				local var_142_32 = arg_139_1:FormatText(StoryNameCfg[693].name)

				arg_139_1.leftNameTxt_.text = var_142_32

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_139_1.leftNameTxt_.transform)

				arg_139_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_139_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_139_1:RecordName(arg_139_1.leftNameTxt_.text)
				SetActive(arg_139_1.iconTrs_.gameObject, false)
				arg_139_1.callingController_:SetSelectedState("normal")

				local var_142_33 = arg_139_1:GetWordFromCfg(319501034)
				local var_142_34 = arg_139_1:FormatText(var_142_33.content)

				arg_139_1.text_.text = var_142_34

				LuaForUtil.ClearLinePrefixSymbol(arg_139_1.text_)

				local var_142_35 = 17
				local var_142_36 = utf8.len(var_142_34)
				local var_142_37 = var_142_35 <= 0 and var_142_31 or var_142_31 * (var_142_36 / var_142_35)

				if var_142_37 > 0 and var_142_31 < var_142_37 then
					arg_139_1.talkMaxDuration = var_142_37

					if var_142_37 + var_142_30 > arg_139_1.duration_ then
						arg_139_1.duration_ = var_142_37 + var_142_30
					end
				end

				arg_139_1.text_.text = var_142_34
				arg_139_1.typewritter.percent = 0

				arg_139_1.typewritter:SetDirty()
				arg_139_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_319501", "319501034", "story_v_out_319501.awb") ~= 0 then
					local var_142_38 = manager.audio:GetVoiceLength("story_v_out_319501", "319501034", "story_v_out_319501.awb") / 1000

					if var_142_38 + var_142_30 > arg_139_1.duration_ then
						arg_139_1.duration_ = var_142_38 + var_142_30
					end

					if var_142_33.prefab_name ~= "" and arg_139_1.actors_[var_142_33.prefab_name] ~= nil then
						local var_142_39 = LuaForUtil.PlayVoiceWithCriLipsync(arg_139_1.actors_[var_142_33.prefab_name].transform, "story_v_out_319501", "319501034", "story_v_out_319501.awb")

						arg_139_1:RecordAudio("319501034", var_142_39)
						arg_139_1:RecordAudio("319501034", var_142_39)
					else
						arg_139_1:AudioAction("play", "voice", "story_v_out_319501", "319501034", "story_v_out_319501.awb")
					end

					arg_139_1:RecordHistoryTalkVoice("story_v_out_319501", "319501034", "story_v_out_319501.awb")
				end

				arg_139_1:RecordContent(arg_139_1.text_.text)
			end

			local var_142_40 = math.max(var_142_31, arg_139_1.talkMaxDuration)

			if var_142_30 <= arg_139_1.time_ and arg_139_1.time_ < var_142_30 + var_142_40 then
				arg_139_1.typewritter.percent = (arg_139_1.time_ - var_142_30) / var_142_40

				arg_139_1.typewritter:SetDirty()
			end

			if arg_139_1.time_ >= var_142_30 + var_142_40 and arg_139_1.time_ < var_142_30 + var_142_40 + arg_142_0 then
				arg_139_1.typewritter.percent = 1

				arg_139_1.typewritter:SetDirty()
				arg_139_1:ShowNextGo(true)
			end
		end

		arg_139_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10069ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1084ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_139_1:InitPlayNodeList()
	end,
	Play319501035 = function(arg_143_0, arg_143_1)
		arg_143_1.time_ = 0
		arg_143_1.frameCnt_ = 0
		arg_143_1.state_ = "playing"
		arg_143_1.curTalkId_ = 319501035
		arg_143_1.duration_ = 5

		SetActive(arg_143_1.tipsGo_, false)

		function arg_143_1.onSingleLineFinish_()
			arg_143_1.onSingleLineUpdate_ = nil
			arg_143_1.onSingleLineFinish_ = nil
			arg_143_1.state_ = "waiting"
		end

		function arg_143_1.playNext_(arg_145_0)
			if arg_145_0 == 1 then
				arg_143_0:Play319501036(arg_143_1)
			end
		end

		function arg_143_1.onSingleLineUpdate_(arg_146_0)
			local var_146_0 = arg_143_1.actors_["10069ui_story"]
			local var_146_1 = 0

			if var_146_1 < arg_143_1.time_ and arg_143_1.time_ <= var_146_1 + arg_146_0 and not isNil(var_146_0) and arg_143_1.var_.characterEffect10069ui_story == nil then
				arg_143_1.var_.characterEffect10069ui_story = var_146_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_146_2 = 0.200000002980232

			if var_146_1 <= arg_143_1.time_ and arg_143_1.time_ < var_146_1 + var_146_2 and not isNil(var_146_0) then
				local var_146_3 = (arg_143_1.time_ - var_146_1) / var_146_2

				if arg_143_1.var_.characterEffect10069ui_story and not isNil(var_146_0) then
					local var_146_4 = Mathf.Lerp(0, 0.5, var_146_3)

					arg_143_1.var_.characterEffect10069ui_story.fillFlat = true
					arg_143_1.var_.characterEffect10069ui_story.fillRatio = var_146_4
				end
			end

			if arg_143_1.time_ >= var_146_1 + var_146_2 and arg_143_1.time_ < var_146_1 + var_146_2 + arg_146_0 and not isNil(var_146_0) and arg_143_1.var_.characterEffect10069ui_story then
				local var_146_5 = 0.5

				arg_143_1.var_.characterEffect10069ui_story.fillFlat = true
				arg_143_1.var_.characterEffect10069ui_story.fillRatio = var_146_5
			end

			local var_146_6 = 0
			local var_146_7 = 0.925

			if var_146_6 < arg_143_1.time_ and arg_143_1.time_ <= var_146_6 + arg_146_0 then
				arg_143_1.talkMaxDuration = 0
				arg_143_1.dialogCg_.alpha = 1

				arg_143_1.dialog_:SetActive(true)
				SetActive(arg_143_1.leftNameGo_, false)

				arg_143_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_143_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_143_1:RecordName(arg_143_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_143_1.iconTrs_.gameObject, false)
				arg_143_1.callingController_:SetSelectedState("normal")

				local var_146_8 = arg_143_1:GetWordFromCfg(319501035)
				local var_146_9 = arg_143_1:FormatText(var_146_8.content)

				arg_143_1.text_.text = var_146_9

				LuaForUtil.ClearLinePrefixSymbol(arg_143_1.text_)

				local var_146_10 = 37
				local var_146_11 = utf8.len(var_146_9)
				local var_146_12 = var_146_10 <= 0 and var_146_7 or var_146_7 * (var_146_11 / var_146_10)

				if var_146_12 > 0 and var_146_7 < var_146_12 then
					arg_143_1.talkMaxDuration = var_146_12

					if var_146_12 + var_146_6 > arg_143_1.duration_ then
						arg_143_1.duration_ = var_146_12 + var_146_6
					end
				end

				arg_143_1.text_.text = var_146_9
				arg_143_1.typewritter.percent = 0

				arg_143_1.typewritter:SetDirty()
				arg_143_1:ShowNextGo(false)
				arg_143_1:RecordContent(arg_143_1.text_.text)
			end

			local var_146_13 = math.max(var_146_7, arg_143_1.talkMaxDuration)

			if var_146_6 <= arg_143_1.time_ and arg_143_1.time_ < var_146_6 + var_146_13 then
				arg_143_1.typewritter.percent = (arg_143_1.time_ - var_146_6) / var_146_13

				arg_143_1.typewritter:SetDirty()
			end

			if arg_143_1.time_ >= var_146_6 + var_146_13 and arg_143_1.time_ < var_146_6 + var_146_13 + arg_146_0 then
				arg_143_1.typewritter.percent = 1

				arg_143_1.typewritter:SetDirty()
				arg_143_1:ShowNextGo(true)
			end
		end

		arg_143_1.nodeConfigList_ = {}

		arg_143_1:InitPlayNodeList()
	end,
	Play319501036 = function(arg_147_0, arg_147_1)
		arg_147_1.time_ = 0
		arg_147_1.frameCnt_ = 0
		arg_147_1.state_ = "playing"
		arg_147_1.curTalkId_ = 319501036
		arg_147_1.duration_ = 5.2

		local var_147_0 = {
			zh = 4.433,
			ja = 5.2
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
				arg_147_0:Play319501037(arg_147_1)
			end
		end

		function arg_147_1.onSingleLineUpdate_(arg_150_0)
			local var_150_0 = arg_147_1.actors_["1084ui_story"].transform
			local var_150_1 = 0

			if var_150_1 < arg_147_1.time_ and arg_147_1.time_ <= var_150_1 + arg_150_0 then
				arg_147_1.var_.moveOldPos1084ui_story = var_150_0.localPosition
			end

			local var_150_2 = 0.001

			if var_150_1 <= arg_147_1.time_ and arg_147_1.time_ < var_150_1 + var_150_2 then
				local var_150_3 = (arg_147_1.time_ - var_150_1) / var_150_2
				local var_150_4 = Vector3.New(-0.7, -0.97, -6)

				var_150_0.localPosition = Vector3.Lerp(arg_147_1.var_.moveOldPos1084ui_story, var_150_4, var_150_3)

				local var_150_5 = manager.ui.mainCamera.transform.position - var_150_0.position

				var_150_0.forward = Vector3.New(var_150_5.x, var_150_5.y, var_150_5.z)

				local var_150_6 = var_150_0.localEulerAngles

				var_150_6.z = 0
				var_150_6.x = 0
				var_150_0.localEulerAngles = var_150_6
			end

			if arg_147_1.time_ >= var_150_1 + var_150_2 and arg_147_1.time_ < var_150_1 + var_150_2 + arg_150_0 then
				var_150_0.localPosition = Vector3.New(-0.7, -0.97, -6)

				local var_150_7 = manager.ui.mainCamera.transform.position - var_150_0.position

				var_150_0.forward = Vector3.New(var_150_7.x, var_150_7.y, var_150_7.z)

				local var_150_8 = var_150_0.localEulerAngles

				var_150_8.z = 0
				var_150_8.x = 0
				var_150_0.localEulerAngles = var_150_8
			end

			local var_150_9 = arg_147_1.actors_["1084ui_story"]
			local var_150_10 = 0

			if var_150_10 < arg_147_1.time_ and arg_147_1.time_ <= var_150_10 + arg_150_0 and not isNil(var_150_9) and arg_147_1.var_.characterEffect1084ui_story == nil then
				arg_147_1.var_.characterEffect1084ui_story = var_150_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_150_11 = 0.200000002980232

			if var_150_10 <= arg_147_1.time_ and arg_147_1.time_ < var_150_10 + var_150_11 and not isNil(var_150_9) then
				local var_150_12 = (arg_147_1.time_ - var_150_10) / var_150_11

				if arg_147_1.var_.characterEffect1084ui_story and not isNil(var_150_9) then
					arg_147_1.var_.characterEffect1084ui_story.fillFlat = false
				end
			end

			if arg_147_1.time_ >= var_150_10 + var_150_11 and arg_147_1.time_ < var_150_10 + var_150_11 + arg_150_0 and not isNil(var_150_9) and arg_147_1.var_.characterEffect1084ui_story then
				arg_147_1.var_.characterEffect1084ui_story.fillFlat = false
			end

			local var_150_13 = 0

			if var_150_13 < arg_147_1.time_ and arg_147_1.time_ <= var_150_13 + arg_150_0 then
				arg_147_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/story1084/story1084action/1084action8_1")
			end

			local var_150_14 = 0

			if var_150_14 < arg_147_1.time_ and arg_147_1.time_ <= var_150_14 + arg_150_0 then
				arg_147_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_150_15 = 0
			local var_150_16 = 0.55

			if var_150_15 < arg_147_1.time_ and arg_147_1.time_ <= var_150_15 + arg_150_0 then
				arg_147_1.talkMaxDuration = 0
				arg_147_1.dialogCg_.alpha = 1

				arg_147_1.dialog_:SetActive(true)
				SetActive(arg_147_1.leftNameGo_, true)

				local var_150_17 = arg_147_1:FormatText(StoryNameCfg[6].name)

				arg_147_1.leftNameTxt_.text = var_150_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_147_1.leftNameTxt_.transform)

				arg_147_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_147_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_147_1:RecordName(arg_147_1.leftNameTxt_.text)
				SetActive(arg_147_1.iconTrs_.gameObject, false)
				arg_147_1.callingController_:SetSelectedState("normal")

				local var_150_18 = arg_147_1:GetWordFromCfg(319501036)
				local var_150_19 = arg_147_1:FormatText(var_150_18.content)

				arg_147_1.text_.text = var_150_19

				LuaForUtil.ClearLinePrefixSymbol(arg_147_1.text_)

				local var_150_20 = 22
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

				if manager.audio:GetVoiceLength("story_v_out_319501", "319501036", "story_v_out_319501.awb") ~= 0 then
					local var_150_23 = manager.audio:GetVoiceLength("story_v_out_319501", "319501036", "story_v_out_319501.awb") / 1000

					if var_150_23 + var_150_15 > arg_147_1.duration_ then
						arg_147_1.duration_ = var_150_23 + var_150_15
					end

					if var_150_18.prefab_name ~= "" and arg_147_1.actors_[var_150_18.prefab_name] ~= nil then
						local var_150_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_147_1.actors_[var_150_18.prefab_name].transform, "story_v_out_319501", "319501036", "story_v_out_319501.awb")

						arg_147_1:RecordAudio("319501036", var_150_24)
						arg_147_1:RecordAudio("319501036", var_150_24)
					else
						arg_147_1:AudioAction("play", "voice", "story_v_out_319501", "319501036", "story_v_out_319501.awb")
					end

					arg_147_1:RecordHistoryTalkVoice("story_v_out_319501", "319501036", "story_v_out_319501.awb")
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
				actorName = "1084ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_147_1:InitPlayNodeList()
	end,
	Play319501037 = function(arg_151_0, arg_151_1)
		arg_151_1.time_ = 0
		arg_151_1.frameCnt_ = 0
		arg_151_1.state_ = "playing"
		arg_151_1.curTalkId_ = 319501037
		arg_151_1.duration_ = 3.8

		local var_151_0 = {
			zh = 2.266,
			ja = 3.8
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
				arg_151_0:Play319501038(arg_151_1)
			end
		end

		function arg_151_1.onSingleLineUpdate_(arg_154_0)
			local var_154_0 = arg_151_1.actors_["1084ui_story"]
			local var_154_1 = 0

			if var_154_1 < arg_151_1.time_ and arg_151_1.time_ <= var_154_1 + arg_154_0 and not isNil(var_154_0) and arg_151_1.var_.characterEffect1084ui_story == nil then
				arg_151_1.var_.characterEffect1084ui_story = var_154_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_154_2 = 0.200000002980232

			if var_154_1 <= arg_151_1.time_ and arg_151_1.time_ < var_154_1 + var_154_2 and not isNil(var_154_0) then
				local var_154_3 = (arg_151_1.time_ - var_154_1) / var_154_2

				if arg_151_1.var_.characterEffect1084ui_story and not isNil(var_154_0) then
					local var_154_4 = Mathf.Lerp(0, 0.5, var_154_3)

					arg_151_1.var_.characterEffect1084ui_story.fillFlat = true
					arg_151_1.var_.characterEffect1084ui_story.fillRatio = var_154_4
				end
			end

			if arg_151_1.time_ >= var_154_1 + var_154_2 and arg_151_1.time_ < var_154_1 + var_154_2 + arg_154_0 and not isNil(var_154_0) and arg_151_1.var_.characterEffect1084ui_story then
				local var_154_5 = 0.5

				arg_151_1.var_.characterEffect1084ui_story.fillFlat = true
				arg_151_1.var_.characterEffect1084ui_story.fillRatio = var_154_5
			end

			local var_154_6 = arg_151_1.actors_["10069ui_story"]
			local var_154_7 = 0

			if var_154_7 < arg_151_1.time_ and arg_151_1.time_ <= var_154_7 + arg_154_0 and not isNil(var_154_6) and arg_151_1.var_.characterEffect10069ui_story == nil then
				arg_151_1.var_.characterEffect10069ui_story = var_154_6:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_154_8 = 0.200000002980232

			if var_154_7 <= arg_151_1.time_ and arg_151_1.time_ < var_154_7 + var_154_8 and not isNil(var_154_6) then
				local var_154_9 = (arg_151_1.time_ - var_154_7) / var_154_8

				if arg_151_1.var_.characterEffect10069ui_story and not isNil(var_154_6) then
					arg_151_1.var_.characterEffect10069ui_story.fillFlat = false
				end
			end

			if arg_151_1.time_ >= var_154_7 + var_154_8 and arg_151_1.time_ < var_154_7 + var_154_8 + arg_154_0 and not isNil(var_154_6) and arg_151_1.var_.characterEffect10069ui_story then
				arg_151_1.var_.characterEffect10069ui_story.fillFlat = false
			end

			local var_154_10 = 0
			local var_154_11 = 0.2

			if var_154_10 < arg_151_1.time_ and arg_151_1.time_ <= var_154_10 + arg_154_0 then
				arg_151_1.talkMaxDuration = 0
				arg_151_1.dialogCg_.alpha = 1

				arg_151_1.dialog_:SetActive(true)
				SetActive(arg_151_1.leftNameGo_, true)

				local var_154_12 = arg_151_1:FormatText(StoryNameCfg[693].name)

				arg_151_1.leftNameTxt_.text = var_154_12

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_151_1.leftNameTxt_.transform)

				arg_151_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_151_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_151_1:RecordName(arg_151_1.leftNameTxt_.text)
				SetActive(arg_151_1.iconTrs_.gameObject, false)
				arg_151_1.callingController_:SetSelectedState("normal")

				local var_154_13 = arg_151_1:GetWordFromCfg(319501037)
				local var_154_14 = arg_151_1:FormatText(var_154_13.content)

				arg_151_1.text_.text = var_154_14

				LuaForUtil.ClearLinePrefixSymbol(arg_151_1.text_)

				local var_154_15 = 8
				local var_154_16 = utf8.len(var_154_14)
				local var_154_17 = var_154_15 <= 0 and var_154_11 or var_154_11 * (var_154_16 / var_154_15)

				if var_154_17 > 0 and var_154_11 < var_154_17 then
					arg_151_1.talkMaxDuration = var_154_17

					if var_154_17 + var_154_10 > arg_151_1.duration_ then
						arg_151_1.duration_ = var_154_17 + var_154_10
					end
				end

				arg_151_1.text_.text = var_154_14
				arg_151_1.typewritter.percent = 0

				arg_151_1.typewritter:SetDirty()
				arg_151_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_319501", "319501037", "story_v_out_319501.awb") ~= 0 then
					local var_154_18 = manager.audio:GetVoiceLength("story_v_out_319501", "319501037", "story_v_out_319501.awb") / 1000

					if var_154_18 + var_154_10 > arg_151_1.duration_ then
						arg_151_1.duration_ = var_154_18 + var_154_10
					end

					if var_154_13.prefab_name ~= "" and arg_151_1.actors_[var_154_13.prefab_name] ~= nil then
						local var_154_19 = LuaForUtil.PlayVoiceWithCriLipsync(arg_151_1.actors_[var_154_13.prefab_name].transform, "story_v_out_319501", "319501037", "story_v_out_319501.awb")

						arg_151_1:RecordAudio("319501037", var_154_19)
						arg_151_1:RecordAudio("319501037", var_154_19)
					else
						arg_151_1:AudioAction("play", "voice", "story_v_out_319501", "319501037", "story_v_out_319501.awb")
					end

					arg_151_1:RecordHistoryTalkVoice("story_v_out_319501", "319501037", "story_v_out_319501.awb")
				end

				arg_151_1:RecordContent(arg_151_1.text_.text)
			end

			local var_154_20 = math.max(var_154_11, arg_151_1.talkMaxDuration)

			if var_154_10 <= arg_151_1.time_ and arg_151_1.time_ < var_154_10 + var_154_20 then
				arg_151_1.typewritter.percent = (arg_151_1.time_ - var_154_10) / var_154_20

				arg_151_1.typewritter:SetDirty()
			end

			if arg_151_1.time_ >= var_154_10 + var_154_20 and arg_151_1.time_ < var_154_10 + var_154_20 + arg_154_0 then
				arg_151_1.typewritter.percent = 1

				arg_151_1.typewritter:SetDirty()
				arg_151_1:ShowNextGo(true)
			end
		end

		arg_151_1.nodeConfigList_ = {}

		arg_151_1:InitPlayNodeList()
	end,
	Play319501038 = function(arg_155_0, arg_155_1)
		arg_155_1.time_ = 0
		arg_155_1.frameCnt_ = 0
		arg_155_1.state_ = "playing"
		arg_155_1.curTalkId_ = 319501038
		arg_155_1.duration_ = 9

		SetActive(arg_155_1.tipsGo_, false)

		function arg_155_1.onSingleLineFinish_()
			arg_155_1.onSingleLineUpdate_ = nil
			arg_155_1.onSingleLineFinish_ = nil
			arg_155_1.state_ = "waiting"
		end

		function arg_155_1.playNext_(arg_157_0)
			if arg_157_0 == 1 then
				arg_155_0:Play319501039(arg_155_1)
			end
		end

		function arg_155_1.onSingleLineUpdate_(arg_158_0)
			local var_158_0 = 2

			if var_158_0 < arg_155_1.time_ and arg_155_1.time_ <= var_158_0 + arg_158_0 then
				local var_158_1 = manager.ui.mainCamera.transform.localPosition
				local var_158_2 = Vector3.New(0, 0, 10) + Vector3.New(var_158_1.x, var_158_1.y, 0)
				local var_158_3 = arg_155_1.bgs_.ST72

				var_158_3.transform.localPosition = var_158_2
				var_158_3.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_158_4 = var_158_3:GetComponent("SpriteRenderer")

				if var_158_4 and var_158_4.sprite then
					local var_158_5 = (var_158_3.transform.localPosition - var_158_1).z
					local var_158_6 = manager.ui.mainCameraCom_
					local var_158_7 = 2 * var_158_5 * Mathf.Tan(var_158_6.fieldOfView * 0.5 * Mathf.Deg2Rad)
					local var_158_8 = var_158_7 * var_158_6.aspect
					local var_158_9 = var_158_4.sprite.bounds.size.x
					local var_158_10 = var_158_4.sprite.bounds.size.y
					local var_158_11 = var_158_8 / var_158_9
					local var_158_12 = var_158_7 / var_158_10
					local var_158_13 = var_158_12 < var_158_11 and var_158_11 or var_158_12

					var_158_3.transform.localScale = Vector3.New(var_158_13, var_158_13, 0)
				end

				for iter_158_0, iter_158_1 in pairs(arg_155_1.bgs_) do
					if iter_158_0 ~= "ST72" then
						iter_158_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_158_14 = 0

			if var_158_14 < arg_155_1.time_ and arg_155_1.time_ <= var_158_14 + arg_158_0 then
				arg_155_1.mask_.enabled = true
				arg_155_1.mask_.raycastTarget = true

				arg_155_1:SetGaussion(false)
			end

			local var_158_15 = 2

			if var_158_14 <= arg_155_1.time_ and arg_155_1.time_ < var_158_14 + var_158_15 then
				local var_158_16 = (arg_155_1.time_ - var_158_14) / var_158_15
				local var_158_17 = Color.New(0, 0, 0)

				var_158_17.a = Mathf.Lerp(0, 1, var_158_16)
				arg_155_1.mask_.color = var_158_17
			end

			if arg_155_1.time_ >= var_158_14 + var_158_15 and arg_155_1.time_ < var_158_14 + var_158_15 + arg_158_0 then
				local var_158_18 = Color.New(0, 0, 0)

				var_158_18.a = 1
				arg_155_1.mask_.color = var_158_18
			end

			local var_158_19 = 2

			if var_158_19 < arg_155_1.time_ and arg_155_1.time_ <= var_158_19 + arg_158_0 then
				arg_155_1.mask_.enabled = true
				arg_155_1.mask_.raycastTarget = true

				arg_155_1:SetGaussion(false)
			end

			local var_158_20 = 2

			if var_158_19 <= arg_155_1.time_ and arg_155_1.time_ < var_158_19 + var_158_20 then
				local var_158_21 = (arg_155_1.time_ - var_158_19) / var_158_20
				local var_158_22 = Color.New(0, 0, 0)

				var_158_22.a = Mathf.Lerp(1, 0, var_158_21)
				arg_155_1.mask_.color = var_158_22
			end

			if arg_155_1.time_ >= var_158_19 + var_158_20 and arg_155_1.time_ < var_158_19 + var_158_20 + arg_158_0 then
				local var_158_23 = Color.New(0, 0, 0)
				local var_158_24 = 0

				arg_155_1.mask_.enabled = false
				var_158_23.a = var_158_24
				arg_155_1.mask_.color = var_158_23
			end

			local var_158_25 = arg_155_1.actors_["1084ui_story"].transform
			local var_158_26 = 1.966

			if var_158_26 < arg_155_1.time_ and arg_155_1.time_ <= var_158_26 + arg_158_0 then
				arg_155_1.var_.moveOldPos1084ui_story = var_158_25.localPosition
			end

			local var_158_27 = 0.001

			if var_158_26 <= arg_155_1.time_ and arg_155_1.time_ < var_158_26 + var_158_27 then
				local var_158_28 = (arg_155_1.time_ - var_158_26) / var_158_27
				local var_158_29 = Vector3.New(0, 100, 0)

				var_158_25.localPosition = Vector3.Lerp(arg_155_1.var_.moveOldPos1084ui_story, var_158_29, var_158_28)

				local var_158_30 = manager.ui.mainCamera.transform.position - var_158_25.position

				var_158_25.forward = Vector3.New(var_158_30.x, var_158_30.y, var_158_30.z)

				local var_158_31 = var_158_25.localEulerAngles

				var_158_31.z = 0
				var_158_31.x = 0
				var_158_25.localEulerAngles = var_158_31
			end

			if arg_155_1.time_ >= var_158_26 + var_158_27 and arg_155_1.time_ < var_158_26 + var_158_27 + arg_158_0 then
				var_158_25.localPosition = Vector3.New(0, 100, 0)

				local var_158_32 = manager.ui.mainCamera.transform.position - var_158_25.position

				var_158_25.forward = Vector3.New(var_158_32.x, var_158_32.y, var_158_32.z)

				local var_158_33 = var_158_25.localEulerAngles

				var_158_33.z = 0
				var_158_33.x = 0
				var_158_25.localEulerAngles = var_158_33
			end

			local var_158_34 = arg_155_1.actors_["10069ui_story"].transform
			local var_158_35 = 1.966

			if var_158_35 < arg_155_1.time_ and arg_155_1.time_ <= var_158_35 + arg_158_0 then
				arg_155_1.var_.moveOldPos10069ui_story = var_158_34.localPosition
			end

			local var_158_36 = 0.001

			if var_158_35 <= arg_155_1.time_ and arg_155_1.time_ < var_158_35 + var_158_36 then
				local var_158_37 = (arg_155_1.time_ - var_158_35) / var_158_36
				local var_158_38 = Vector3.New(0, 100, 0)

				var_158_34.localPosition = Vector3.Lerp(arg_155_1.var_.moveOldPos10069ui_story, var_158_38, var_158_37)

				local var_158_39 = manager.ui.mainCamera.transform.position - var_158_34.position

				var_158_34.forward = Vector3.New(var_158_39.x, var_158_39.y, var_158_39.z)

				local var_158_40 = var_158_34.localEulerAngles

				var_158_40.z = 0
				var_158_40.x = 0
				var_158_34.localEulerAngles = var_158_40
			end

			if arg_155_1.time_ >= var_158_35 + var_158_36 and arg_155_1.time_ < var_158_35 + var_158_36 + arg_158_0 then
				var_158_34.localPosition = Vector3.New(0, 100, 0)

				local var_158_41 = manager.ui.mainCamera.transform.position - var_158_34.position

				var_158_34.forward = Vector3.New(var_158_41.x, var_158_41.y, var_158_41.z)

				local var_158_42 = var_158_34.localEulerAngles

				var_158_42.z = 0
				var_158_42.x = 0
				var_158_34.localEulerAngles = var_158_42
			end

			if arg_155_1.frameCnt_ <= 1 then
				arg_155_1.dialog_:SetActive(false)
			end

			local var_158_43 = 4
			local var_158_44 = 1.05

			if var_158_43 < arg_155_1.time_ and arg_155_1.time_ <= var_158_43 + arg_158_0 then
				arg_155_1.talkMaxDuration = 0

				arg_155_1.dialog_:SetActive(true)

				arg_155_1.dialogCg_.alpha = 0

				local var_158_45 = LeanTween.value(arg_155_1.dialog_, 0, 1, 0.3)

				var_158_45:setOnUpdate(LuaHelper.FloatAction(function(arg_159_0)
					arg_155_1.dialogCg_.alpha = arg_159_0
				end))
				var_158_45:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_155_1.dialog_)
					var_158_45:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_155_1.duration_ = arg_155_1.duration_ + 0.3

				SetActive(arg_155_1.leftNameGo_, false)

				arg_155_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_155_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_155_1:RecordName(arg_155_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_155_1.iconTrs_.gameObject, false)
				arg_155_1.callingController_:SetSelectedState("normal")

				local var_158_46 = arg_155_1:GetWordFromCfg(319501038)
				local var_158_47 = arg_155_1:FormatText(var_158_46.content)

				arg_155_1.text_.text = var_158_47

				LuaForUtil.ClearLinePrefixSymbol(arg_155_1.text_)

				local var_158_48 = 42
				local var_158_49 = utf8.len(var_158_47)
				local var_158_50 = var_158_48 <= 0 and var_158_44 or var_158_44 * (var_158_49 / var_158_48)

				if var_158_50 > 0 and var_158_44 < var_158_50 then
					arg_155_1.talkMaxDuration = var_158_50
					var_158_43 = var_158_43 + 0.3

					if var_158_50 + var_158_43 > arg_155_1.duration_ then
						arg_155_1.duration_ = var_158_50 + var_158_43
					end
				end

				arg_155_1.text_.text = var_158_47
				arg_155_1.typewritter.percent = 0

				arg_155_1.typewritter:SetDirty()
				arg_155_1:ShowNextGo(false)
				arg_155_1:RecordContent(arg_155_1.text_.text)
			end

			local var_158_51 = var_158_43 + 0.3
			local var_158_52 = math.max(var_158_44, arg_155_1.talkMaxDuration)

			if var_158_51 <= arg_155_1.time_ and arg_155_1.time_ < var_158_51 + var_158_52 then
				arg_155_1.typewritter.percent = (arg_155_1.time_ - var_158_51) / var_158_52

				arg_155_1.typewritter:SetDirty()
			end

			if arg_155_1.time_ >= var_158_51 + var_158_52 and arg_155_1.time_ < var_158_51 + var_158_52 + arg_158_0 then
				arg_155_1.typewritter.percent = 1

				arg_155_1.typewritter:SetDirty()
				arg_155_1:ShowNextGo(true)
			end
		end

		arg_155_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1084ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 1.966,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "10069ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 1.966,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_155_1:InitPlayNodeList()
	end,
	Play319501039 = function(arg_161_0, arg_161_1)
		arg_161_1.time_ = 0
		arg_161_1.frameCnt_ = 0
		arg_161_1.state_ = "playing"
		arg_161_1.curTalkId_ = 319501039
		arg_161_1.duration_ = 5

		SetActive(arg_161_1.tipsGo_, false)

		function arg_161_1.onSingleLineFinish_()
			arg_161_1.onSingleLineUpdate_ = nil
			arg_161_1.onSingleLineFinish_ = nil
			arg_161_1.state_ = "waiting"
		end

		function arg_161_1.playNext_(arg_163_0)
			if arg_163_0 == 1 then
				arg_161_0:Play319501040(arg_161_1)
			end
		end

		function arg_161_1.onSingleLineUpdate_(arg_164_0)
			local var_164_0 = 0
			local var_164_1 = 1.775

			if var_164_0 < arg_161_1.time_ and arg_161_1.time_ <= var_164_0 + arg_164_0 then
				arg_161_1.talkMaxDuration = 0
				arg_161_1.dialogCg_.alpha = 1

				arg_161_1.dialog_:SetActive(true)
				SetActive(arg_161_1.leftNameGo_, false)

				arg_161_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_161_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_161_1:RecordName(arg_161_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_161_1.iconTrs_.gameObject, false)
				arg_161_1.callingController_:SetSelectedState("normal")

				local var_164_2 = arg_161_1:GetWordFromCfg(319501039)
				local var_164_3 = arg_161_1:FormatText(var_164_2.content)

				arg_161_1.text_.text = var_164_3

				LuaForUtil.ClearLinePrefixSymbol(arg_161_1.text_)

				local var_164_4 = 71
				local var_164_5 = utf8.len(var_164_3)
				local var_164_6 = var_164_4 <= 0 and var_164_1 or var_164_1 * (var_164_5 / var_164_4)

				if var_164_6 > 0 and var_164_1 < var_164_6 then
					arg_161_1.talkMaxDuration = var_164_6

					if var_164_6 + var_164_0 > arg_161_1.duration_ then
						arg_161_1.duration_ = var_164_6 + var_164_0
					end
				end

				arg_161_1.text_.text = var_164_3
				arg_161_1.typewritter.percent = 0

				arg_161_1.typewritter:SetDirty()
				arg_161_1:ShowNextGo(false)
				arg_161_1:RecordContent(arg_161_1.text_.text)
			end

			local var_164_7 = math.max(var_164_1, arg_161_1.talkMaxDuration)

			if var_164_0 <= arg_161_1.time_ and arg_161_1.time_ < var_164_0 + var_164_7 then
				arg_161_1.typewritter.percent = (arg_161_1.time_ - var_164_0) / var_164_7

				arg_161_1.typewritter:SetDirty()
			end

			if arg_161_1.time_ >= var_164_0 + var_164_7 and arg_161_1.time_ < var_164_0 + var_164_7 + arg_164_0 then
				arg_161_1.typewritter.percent = 1

				arg_161_1.typewritter:SetDirty()
				arg_161_1:ShowNextGo(true)
			end
		end

		arg_161_1.nodeConfigList_ = {}

		arg_161_1:InitPlayNodeList()
	end,
	Play319501040 = function(arg_165_0, arg_165_1)
		arg_165_1.time_ = 0
		arg_165_1.frameCnt_ = 0
		arg_165_1.state_ = "playing"
		arg_165_1.curTalkId_ = 319501040
		arg_165_1.duration_ = 5

		SetActive(arg_165_1.tipsGo_, false)

		function arg_165_1.onSingleLineFinish_()
			arg_165_1.onSingleLineUpdate_ = nil
			arg_165_1.onSingleLineFinish_ = nil
			arg_165_1.state_ = "waiting"
		end

		function arg_165_1.playNext_(arg_167_0)
			if arg_167_0 == 1 then
				arg_165_0:Play319501041(arg_165_1)
			end
		end

		function arg_165_1.onSingleLineUpdate_(arg_168_0)
			local var_168_0 = 0
			local var_168_1 = 1.05

			if var_168_0 < arg_165_1.time_ and arg_165_1.time_ <= var_168_0 + arg_168_0 then
				arg_165_1.talkMaxDuration = 0
				arg_165_1.dialogCg_.alpha = 1

				arg_165_1.dialog_:SetActive(true)
				SetActive(arg_165_1.leftNameGo_, false)

				arg_165_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_165_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_165_1:RecordName(arg_165_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_165_1.iconTrs_.gameObject, false)
				arg_165_1.callingController_:SetSelectedState("normal")

				local var_168_2 = arg_165_1:GetWordFromCfg(319501040)
				local var_168_3 = arg_165_1:FormatText(var_168_2.content)

				arg_165_1.text_.text = var_168_3

				LuaForUtil.ClearLinePrefixSymbol(arg_165_1.text_)

				local var_168_4 = 42
				local var_168_5 = utf8.len(var_168_3)
				local var_168_6 = var_168_4 <= 0 and var_168_1 or var_168_1 * (var_168_5 / var_168_4)

				if var_168_6 > 0 and var_168_1 < var_168_6 then
					arg_165_1.talkMaxDuration = var_168_6

					if var_168_6 + var_168_0 > arg_165_1.duration_ then
						arg_165_1.duration_ = var_168_6 + var_168_0
					end
				end

				arg_165_1.text_.text = var_168_3
				arg_165_1.typewritter.percent = 0

				arg_165_1.typewritter:SetDirty()
				arg_165_1:ShowNextGo(false)
				arg_165_1:RecordContent(arg_165_1.text_.text)
			end

			local var_168_7 = math.max(var_168_1, arg_165_1.talkMaxDuration)

			if var_168_0 <= arg_165_1.time_ and arg_165_1.time_ < var_168_0 + var_168_7 then
				arg_165_1.typewritter.percent = (arg_165_1.time_ - var_168_0) / var_168_7

				arg_165_1.typewritter:SetDirty()
			end

			if arg_165_1.time_ >= var_168_0 + var_168_7 and arg_165_1.time_ < var_168_0 + var_168_7 + arg_168_0 then
				arg_165_1.typewritter.percent = 1

				arg_165_1.typewritter:SetDirty()
				arg_165_1:ShowNextGo(true)
			end
		end

		arg_165_1.nodeConfigList_ = {}

		arg_165_1:InitPlayNodeList()
	end,
	Play319501041 = function(arg_169_0, arg_169_1)
		arg_169_1.time_ = 0
		arg_169_1.frameCnt_ = 0
		arg_169_1.state_ = "playing"
		arg_169_1.curTalkId_ = 319501041
		arg_169_1.duration_ = 3.4

		local var_169_0 = {
			zh = 2,
			ja = 3.4
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
				arg_169_0:Play319501042(arg_169_1)
			end
		end

		function arg_169_1.onSingleLineUpdate_(arg_172_0)
			local var_172_0 = arg_169_1.actors_["10069ui_story"].transform
			local var_172_1 = 0

			if var_172_1 < arg_169_1.time_ and arg_169_1.time_ <= var_172_1 + arg_172_0 then
				arg_169_1.var_.moveOldPos10069ui_story = var_172_0.localPosition
			end

			local var_172_2 = 0.001

			if var_172_1 <= arg_169_1.time_ and arg_169_1.time_ < var_172_1 + var_172_2 then
				local var_172_3 = (arg_169_1.time_ - var_172_1) / var_172_2
				local var_172_4 = Vector3.New(0, -1.08, -6.33)

				var_172_0.localPosition = Vector3.Lerp(arg_169_1.var_.moveOldPos10069ui_story, var_172_4, var_172_3)

				local var_172_5 = manager.ui.mainCamera.transform.position - var_172_0.position

				var_172_0.forward = Vector3.New(var_172_5.x, var_172_5.y, var_172_5.z)

				local var_172_6 = var_172_0.localEulerAngles

				var_172_6.z = 0
				var_172_6.x = 0
				var_172_0.localEulerAngles = var_172_6
			end

			if arg_169_1.time_ >= var_172_1 + var_172_2 and arg_169_1.time_ < var_172_1 + var_172_2 + arg_172_0 then
				var_172_0.localPosition = Vector3.New(0, -1.08, -6.33)

				local var_172_7 = manager.ui.mainCamera.transform.position - var_172_0.position

				var_172_0.forward = Vector3.New(var_172_7.x, var_172_7.y, var_172_7.z)

				local var_172_8 = var_172_0.localEulerAngles

				var_172_8.z = 0
				var_172_8.x = 0
				var_172_0.localEulerAngles = var_172_8
			end

			local var_172_9 = 0

			if var_172_9 < arg_169_1.time_ and arg_169_1.time_ <= var_172_9 + arg_172_0 then
				arg_169_1:PlayTimeline("10069ui_story", "StoryTimeline/CharAction/story10069/story10069action/10069action1_1")
			end

			local var_172_10 = 0
			local var_172_11 = 0.2

			if var_172_10 < arg_169_1.time_ and arg_169_1.time_ <= var_172_10 + arg_172_0 then
				arg_169_1.talkMaxDuration = 0
				arg_169_1.dialogCg_.alpha = 1

				arg_169_1.dialog_:SetActive(true)
				SetActive(arg_169_1.leftNameGo_, true)

				local var_172_12 = arg_169_1:FormatText(StoryNameCfg[693].name)

				arg_169_1.leftNameTxt_.text = var_172_12

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_169_1.leftNameTxt_.transform)

				arg_169_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_169_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_169_1:RecordName(arg_169_1.leftNameTxt_.text)
				SetActive(arg_169_1.iconTrs_.gameObject, false)
				arg_169_1.callingController_:SetSelectedState("normal")

				local var_172_13 = arg_169_1:GetWordFromCfg(319501041)
				local var_172_14 = arg_169_1:FormatText(var_172_13.content)

				arg_169_1.text_.text = var_172_14

				LuaForUtil.ClearLinePrefixSymbol(arg_169_1.text_)

				local var_172_15 = 8
				local var_172_16 = utf8.len(var_172_14)
				local var_172_17 = var_172_15 <= 0 and var_172_11 or var_172_11 * (var_172_16 / var_172_15)

				if var_172_17 > 0 and var_172_11 < var_172_17 then
					arg_169_1.talkMaxDuration = var_172_17

					if var_172_17 + var_172_10 > arg_169_1.duration_ then
						arg_169_1.duration_ = var_172_17 + var_172_10
					end
				end

				arg_169_1.text_.text = var_172_14
				arg_169_1.typewritter.percent = 0

				arg_169_1.typewritter:SetDirty()
				arg_169_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_319501", "319501041", "story_v_out_319501.awb") ~= 0 then
					local var_172_18 = manager.audio:GetVoiceLength("story_v_out_319501", "319501041", "story_v_out_319501.awb") / 1000

					if var_172_18 + var_172_10 > arg_169_1.duration_ then
						arg_169_1.duration_ = var_172_18 + var_172_10
					end

					if var_172_13.prefab_name ~= "" and arg_169_1.actors_[var_172_13.prefab_name] ~= nil then
						local var_172_19 = LuaForUtil.PlayVoiceWithCriLipsync(arg_169_1.actors_[var_172_13.prefab_name].transform, "story_v_out_319501", "319501041", "story_v_out_319501.awb")

						arg_169_1:RecordAudio("319501041", var_172_19)
						arg_169_1:RecordAudio("319501041", var_172_19)
					else
						arg_169_1:AudioAction("play", "voice", "story_v_out_319501", "319501041", "story_v_out_319501.awb")
					end

					arg_169_1:RecordHistoryTalkVoice("story_v_out_319501", "319501041", "story_v_out_319501.awb")
				end

				arg_169_1:RecordContent(arg_169_1.text_.text)
			end

			local var_172_20 = math.max(var_172_11, arg_169_1.talkMaxDuration)

			if var_172_10 <= arg_169_1.time_ and arg_169_1.time_ < var_172_10 + var_172_20 then
				arg_169_1.typewritter.percent = (arg_169_1.time_ - var_172_10) / var_172_20

				arg_169_1.typewritter:SetDirty()
			end

			if arg_169_1.time_ >= var_172_10 + var_172_20 and arg_169_1.time_ < var_172_10 + var_172_20 + arg_172_0 then
				arg_169_1.typewritter.percent = 1

				arg_169_1.typewritter:SetDirty()
				arg_169_1:ShowNextGo(true)
			end
		end

		arg_169_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10069ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_169_1:InitPlayNodeList()
	end,
	Play319501042 = function(arg_173_0, arg_173_1)
		arg_173_1.time_ = 0
		arg_173_1.frameCnt_ = 0
		arg_173_1.state_ = "playing"
		arg_173_1.curTalkId_ = 319501042
		arg_173_1.duration_ = 5

		SetActive(arg_173_1.tipsGo_, false)

		function arg_173_1.onSingleLineFinish_()
			arg_173_1.onSingleLineUpdate_ = nil
			arg_173_1.onSingleLineFinish_ = nil
			arg_173_1.state_ = "waiting"
		end

		function arg_173_1.playNext_(arg_175_0)
			if arg_175_0 == 1 then
				arg_173_0:Play319501043(arg_173_1)
			end
		end

		function arg_173_1.onSingleLineUpdate_(arg_176_0)
			local var_176_0 = arg_173_1.actors_["10069ui_story"].transform
			local var_176_1 = 0

			if var_176_1 < arg_173_1.time_ and arg_173_1.time_ <= var_176_1 + arg_176_0 then
				arg_173_1.var_.moveOldPos10069ui_story = var_176_0.localPosition
			end

			local var_176_2 = 0.001

			if var_176_1 <= arg_173_1.time_ and arg_173_1.time_ < var_176_1 + var_176_2 then
				local var_176_3 = (arg_173_1.time_ - var_176_1) / var_176_2
				local var_176_4 = Vector3.New(0, 100, 0)

				var_176_0.localPosition = Vector3.Lerp(arg_173_1.var_.moveOldPos10069ui_story, var_176_4, var_176_3)

				local var_176_5 = manager.ui.mainCamera.transform.position - var_176_0.position

				var_176_0.forward = Vector3.New(var_176_5.x, var_176_5.y, var_176_5.z)

				local var_176_6 = var_176_0.localEulerAngles

				var_176_6.z = 0
				var_176_6.x = 0
				var_176_0.localEulerAngles = var_176_6
			end

			if arg_173_1.time_ >= var_176_1 + var_176_2 and arg_173_1.time_ < var_176_1 + var_176_2 + arg_176_0 then
				var_176_0.localPosition = Vector3.New(0, 100, 0)

				local var_176_7 = manager.ui.mainCamera.transform.position - var_176_0.position

				var_176_0.forward = Vector3.New(var_176_7.x, var_176_7.y, var_176_7.z)

				local var_176_8 = var_176_0.localEulerAngles

				var_176_8.z = 0
				var_176_8.x = 0
				var_176_0.localEulerAngles = var_176_8
			end

			local var_176_9 = 0
			local var_176_10 = 1.425

			if var_176_9 < arg_173_1.time_ and arg_173_1.time_ <= var_176_9 + arg_176_0 then
				arg_173_1.talkMaxDuration = 0
				arg_173_1.dialogCg_.alpha = 1

				arg_173_1.dialog_:SetActive(true)
				SetActive(arg_173_1.leftNameGo_, false)

				arg_173_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_173_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_173_1:RecordName(arg_173_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_173_1.iconTrs_.gameObject, false)
				arg_173_1.callingController_:SetSelectedState("normal")

				local var_176_11 = arg_173_1:GetWordFromCfg(319501042)
				local var_176_12 = arg_173_1:FormatText(var_176_11.content)

				arg_173_1.text_.text = var_176_12

				LuaForUtil.ClearLinePrefixSymbol(arg_173_1.text_)

				local var_176_13 = 57
				local var_176_14 = utf8.len(var_176_12)
				local var_176_15 = var_176_13 <= 0 and var_176_10 or var_176_10 * (var_176_14 / var_176_13)

				if var_176_15 > 0 and var_176_10 < var_176_15 then
					arg_173_1.talkMaxDuration = var_176_15

					if var_176_15 + var_176_9 > arg_173_1.duration_ then
						arg_173_1.duration_ = var_176_15 + var_176_9
					end
				end

				arg_173_1.text_.text = var_176_12
				arg_173_1.typewritter.percent = 0

				arg_173_1.typewritter:SetDirty()
				arg_173_1:ShowNextGo(false)
				arg_173_1:RecordContent(arg_173_1.text_.text)
			end

			local var_176_16 = math.max(var_176_10, arg_173_1.talkMaxDuration)

			if var_176_9 <= arg_173_1.time_ and arg_173_1.time_ < var_176_9 + var_176_16 then
				arg_173_1.typewritter.percent = (arg_173_1.time_ - var_176_9) / var_176_16

				arg_173_1.typewritter:SetDirty()
			end

			if arg_173_1.time_ >= var_176_9 + var_176_16 and arg_173_1.time_ < var_176_9 + var_176_16 + arg_176_0 then
				arg_173_1.typewritter.percent = 1

				arg_173_1.typewritter:SetDirty()
				arg_173_1:ShowNextGo(true)
			end
		end

		arg_173_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10069ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_173_1:InitPlayNodeList()
	end,
	Play319501043 = function(arg_177_0, arg_177_1)
		arg_177_1.time_ = 0
		arg_177_1.frameCnt_ = 0
		arg_177_1.state_ = "playing"
		arg_177_1.curTalkId_ = 319501043
		arg_177_1.duration_ = 4.53

		local var_177_0 = {
			zh = 2.9,
			ja = 4.533
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
				arg_177_0:Play319501044(arg_177_1)
			end
		end

		function arg_177_1.onSingleLineUpdate_(arg_180_0)
			local var_180_0 = arg_177_1.actors_["1084ui_story"].transform
			local var_180_1 = 0

			if var_180_1 < arg_177_1.time_ and arg_177_1.time_ <= var_180_1 + arg_180_0 then
				arg_177_1.var_.moveOldPos1084ui_story = var_180_0.localPosition
			end

			local var_180_2 = 0.001

			if var_180_1 <= arg_177_1.time_ and arg_177_1.time_ < var_180_1 + var_180_2 then
				local var_180_3 = (arg_177_1.time_ - var_180_1) / var_180_2
				local var_180_4 = Vector3.New(0, -0.97, -6)

				var_180_0.localPosition = Vector3.Lerp(arg_177_1.var_.moveOldPos1084ui_story, var_180_4, var_180_3)

				local var_180_5 = manager.ui.mainCamera.transform.position - var_180_0.position

				var_180_0.forward = Vector3.New(var_180_5.x, var_180_5.y, var_180_5.z)

				local var_180_6 = var_180_0.localEulerAngles

				var_180_6.z = 0
				var_180_6.x = 0
				var_180_0.localEulerAngles = var_180_6
			end

			if arg_177_1.time_ >= var_180_1 + var_180_2 and arg_177_1.time_ < var_180_1 + var_180_2 + arg_180_0 then
				var_180_0.localPosition = Vector3.New(0, -0.97, -6)

				local var_180_7 = manager.ui.mainCamera.transform.position - var_180_0.position

				var_180_0.forward = Vector3.New(var_180_7.x, var_180_7.y, var_180_7.z)

				local var_180_8 = var_180_0.localEulerAngles

				var_180_8.z = 0
				var_180_8.x = 0
				var_180_0.localEulerAngles = var_180_8
			end

			local var_180_9 = arg_177_1.actors_["1084ui_story"]
			local var_180_10 = 0

			if var_180_10 < arg_177_1.time_ and arg_177_1.time_ <= var_180_10 + arg_180_0 and not isNil(var_180_9) and arg_177_1.var_.characterEffect1084ui_story == nil then
				arg_177_1.var_.characterEffect1084ui_story = var_180_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_180_11 = 0.200000002980232

			if var_180_10 <= arg_177_1.time_ and arg_177_1.time_ < var_180_10 + var_180_11 and not isNil(var_180_9) then
				local var_180_12 = (arg_177_1.time_ - var_180_10) / var_180_11

				if arg_177_1.var_.characterEffect1084ui_story and not isNil(var_180_9) then
					arg_177_1.var_.characterEffect1084ui_story.fillFlat = false
				end
			end

			if arg_177_1.time_ >= var_180_10 + var_180_11 and arg_177_1.time_ < var_180_10 + var_180_11 + arg_180_0 and not isNil(var_180_9) and arg_177_1.var_.characterEffect1084ui_story then
				arg_177_1.var_.characterEffect1084ui_story.fillFlat = false
			end

			local var_180_13 = 0

			if var_180_13 < arg_177_1.time_ and arg_177_1.time_ <= var_180_13 + arg_180_0 then
				arg_177_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/story1084/story1084action/1084action13_1")
			end

			local var_180_14 = 0

			if var_180_14 < arg_177_1.time_ and arg_177_1.time_ <= var_180_14 + arg_180_0 then
				arg_177_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface2101cva")
			end

			local var_180_15 = 0
			local var_180_16 = 0.25

			if var_180_15 < arg_177_1.time_ and arg_177_1.time_ <= var_180_15 + arg_180_0 then
				arg_177_1.talkMaxDuration = 0
				arg_177_1.dialogCg_.alpha = 1

				arg_177_1.dialog_:SetActive(true)
				SetActive(arg_177_1.leftNameGo_, true)

				local var_180_17 = arg_177_1:FormatText(StoryNameCfg[6].name)

				arg_177_1.leftNameTxt_.text = var_180_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_177_1.leftNameTxt_.transform)

				arg_177_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_177_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_177_1:RecordName(arg_177_1.leftNameTxt_.text)
				SetActive(arg_177_1.iconTrs_.gameObject, false)
				arg_177_1.callingController_:SetSelectedState("normal")

				local var_180_18 = arg_177_1:GetWordFromCfg(319501043)
				local var_180_19 = arg_177_1:FormatText(var_180_18.content)

				arg_177_1.text_.text = var_180_19

				LuaForUtil.ClearLinePrefixSymbol(arg_177_1.text_)

				local var_180_20 = 10
				local var_180_21 = utf8.len(var_180_19)
				local var_180_22 = var_180_20 <= 0 and var_180_16 or var_180_16 * (var_180_21 / var_180_20)

				if var_180_22 > 0 and var_180_16 < var_180_22 then
					arg_177_1.talkMaxDuration = var_180_22

					if var_180_22 + var_180_15 > arg_177_1.duration_ then
						arg_177_1.duration_ = var_180_22 + var_180_15
					end
				end

				arg_177_1.text_.text = var_180_19
				arg_177_1.typewritter.percent = 0

				arg_177_1.typewritter:SetDirty()
				arg_177_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_319501", "319501043", "story_v_out_319501.awb") ~= 0 then
					local var_180_23 = manager.audio:GetVoiceLength("story_v_out_319501", "319501043", "story_v_out_319501.awb") / 1000

					if var_180_23 + var_180_15 > arg_177_1.duration_ then
						arg_177_1.duration_ = var_180_23 + var_180_15
					end

					if var_180_18.prefab_name ~= "" and arg_177_1.actors_[var_180_18.prefab_name] ~= nil then
						local var_180_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_177_1.actors_[var_180_18.prefab_name].transform, "story_v_out_319501", "319501043", "story_v_out_319501.awb")

						arg_177_1:RecordAudio("319501043", var_180_24)
						arg_177_1:RecordAudio("319501043", var_180_24)
					else
						arg_177_1:AudioAction("play", "voice", "story_v_out_319501", "319501043", "story_v_out_319501.awb")
					end

					arg_177_1:RecordHistoryTalkVoice("story_v_out_319501", "319501043", "story_v_out_319501.awb")
				end

				arg_177_1:RecordContent(arg_177_1.text_.text)
			end

			local var_180_25 = math.max(var_180_16, arg_177_1.talkMaxDuration)

			if var_180_15 <= arg_177_1.time_ and arg_177_1.time_ < var_180_15 + var_180_25 then
				arg_177_1.typewritter.percent = (arg_177_1.time_ - var_180_15) / var_180_25

				arg_177_1.typewritter:SetDirty()
			end

			if arg_177_1.time_ >= var_180_15 + var_180_25 and arg_177_1.time_ < var_180_15 + var_180_25 + arg_180_0 then
				arg_177_1.typewritter.percent = 1

				arg_177_1.typewritter:SetDirty()
				arg_177_1:ShowNextGo(true)
			end
		end

		arg_177_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1084ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_177_1:InitPlayNodeList()
	end,
	Play319501044 = function(arg_181_0, arg_181_1)
		arg_181_1.time_ = 0
		arg_181_1.frameCnt_ = 0
		arg_181_1.state_ = "playing"
		arg_181_1.curTalkId_ = 319501044
		arg_181_1.duration_ = 5

		SetActive(arg_181_1.tipsGo_, false)

		function arg_181_1.onSingleLineFinish_()
			arg_181_1.onSingleLineUpdate_ = nil
			arg_181_1.onSingleLineFinish_ = nil
			arg_181_1.state_ = "waiting"
		end

		function arg_181_1.playNext_(arg_183_0)
			if arg_183_0 == 1 then
				arg_181_0:Play319501045(arg_181_1)
			end
		end

		function arg_181_1.onSingleLineUpdate_(arg_184_0)
			local var_184_0 = arg_181_1.actors_["1084ui_story"]
			local var_184_1 = 0

			if var_184_1 < arg_181_1.time_ and arg_181_1.time_ <= var_184_1 + arg_184_0 and not isNil(var_184_0) and arg_181_1.var_.characterEffect1084ui_story == nil then
				arg_181_1.var_.characterEffect1084ui_story = var_184_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_184_2 = 0.200000002980232

			if var_184_1 <= arg_181_1.time_ and arg_181_1.time_ < var_184_1 + var_184_2 and not isNil(var_184_0) then
				local var_184_3 = (arg_181_1.time_ - var_184_1) / var_184_2

				if arg_181_1.var_.characterEffect1084ui_story and not isNil(var_184_0) then
					local var_184_4 = Mathf.Lerp(0, 0.5, var_184_3)

					arg_181_1.var_.characterEffect1084ui_story.fillFlat = true
					arg_181_1.var_.characterEffect1084ui_story.fillRatio = var_184_4
				end
			end

			if arg_181_1.time_ >= var_184_1 + var_184_2 and arg_181_1.time_ < var_184_1 + var_184_2 + arg_184_0 and not isNil(var_184_0) and arg_181_1.var_.characterEffect1084ui_story then
				local var_184_5 = 0.5

				arg_181_1.var_.characterEffect1084ui_story.fillFlat = true
				arg_181_1.var_.characterEffect1084ui_story.fillRatio = var_184_5
			end

			local var_184_6 = 0
			local var_184_7 = 0.775

			if var_184_6 < arg_181_1.time_ and arg_181_1.time_ <= var_184_6 + arg_184_0 then
				arg_181_1.talkMaxDuration = 0
				arg_181_1.dialogCg_.alpha = 1

				arg_181_1.dialog_:SetActive(true)
				SetActive(arg_181_1.leftNameGo_, false)

				arg_181_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_181_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_181_1:RecordName(arg_181_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_181_1.iconTrs_.gameObject, false)
				arg_181_1.callingController_:SetSelectedState("normal")

				local var_184_8 = arg_181_1:GetWordFromCfg(319501044)
				local var_184_9 = arg_181_1:FormatText(var_184_8.content)

				arg_181_1.text_.text = var_184_9

				LuaForUtil.ClearLinePrefixSymbol(arg_181_1.text_)

				local var_184_10 = 31
				local var_184_11 = utf8.len(var_184_9)
				local var_184_12 = var_184_10 <= 0 and var_184_7 or var_184_7 * (var_184_11 / var_184_10)

				if var_184_12 > 0 and var_184_7 < var_184_12 then
					arg_181_1.talkMaxDuration = var_184_12

					if var_184_12 + var_184_6 > arg_181_1.duration_ then
						arg_181_1.duration_ = var_184_12 + var_184_6
					end
				end

				arg_181_1.text_.text = var_184_9
				arg_181_1.typewritter.percent = 0

				arg_181_1.typewritter:SetDirty()
				arg_181_1:ShowNextGo(false)
				arg_181_1:RecordContent(arg_181_1.text_.text)
			end

			local var_184_13 = math.max(var_184_7, arg_181_1.talkMaxDuration)

			if var_184_6 <= arg_181_1.time_ and arg_181_1.time_ < var_184_6 + var_184_13 then
				arg_181_1.typewritter.percent = (arg_181_1.time_ - var_184_6) / var_184_13

				arg_181_1.typewritter:SetDirty()
			end

			if arg_181_1.time_ >= var_184_6 + var_184_13 and arg_181_1.time_ < var_184_6 + var_184_13 + arg_184_0 then
				arg_181_1.typewritter.percent = 1

				arg_181_1.typewritter:SetDirty()
				arg_181_1:ShowNextGo(true)
			end
		end

		arg_181_1.nodeConfigList_ = {}

		arg_181_1:InitPlayNodeList()
	end,
	Play319501045 = function(arg_185_0, arg_185_1)
		arg_185_1.time_ = 0
		arg_185_1.frameCnt_ = 0
		arg_185_1.state_ = "playing"
		arg_185_1.curTalkId_ = 319501045
		arg_185_1.duration_ = 2

		SetActive(arg_185_1.tipsGo_, false)

		function arg_185_1.onSingleLineFinish_()
			arg_185_1.onSingleLineUpdate_ = nil
			arg_185_1.onSingleLineFinish_ = nil
			arg_185_1.state_ = "waiting"
		end

		function arg_185_1.playNext_(arg_187_0)
			if arg_187_0 == 1 then
				arg_185_0:Play319501046(arg_185_1)
			end
		end

		function arg_185_1.onSingleLineUpdate_(arg_188_0)
			local var_188_0 = 0

			if var_188_0 < arg_185_1.time_ and arg_185_1.time_ <= var_188_0 + arg_188_0 then
				arg_185_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/story1084/story1084action/1084action13_2")
			end

			local var_188_1 = 0

			if var_188_1 < arg_185_1.time_ and arg_185_1.time_ <= var_188_1 + arg_188_0 then
				arg_185_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface2101cva")
			end

			local var_188_2 = arg_185_1.actors_["1084ui_story"]
			local var_188_3 = 0

			if var_188_3 < arg_185_1.time_ and arg_185_1.time_ <= var_188_3 + arg_188_0 and not isNil(var_188_2) and arg_185_1.var_.characterEffect1084ui_story == nil then
				arg_185_1.var_.characterEffect1084ui_story = var_188_2:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_188_4 = 0.200000002980232

			if var_188_3 <= arg_185_1.time_ and arg_185_1.time_ < var_188_3 + var_188_4 and not isNil(var_188_2) then
				local var_188_5 = (arg_185_1.time_ - var_188_3) / var_188_4

				if arg_185_1.var_.characterEffect1084ui_story and not isNil(var_188_2) then
					arg_185_1.var_.characterEffect1084ui_story.fillFlat = false
				end
			end

			if arg_185_1.time_ >= var_188_3 + var_188_4 and arg_185_1.time_ < var_188_3 + var_188_4 + arg_188_0 and not isNil(var_188_2) and arg_185_1.var_.characterEffect1084ui_story then
				arg_185_1.var_.characterEffect1084ui_story.fillFlat = false
			end

			local var_188_6 = 0
			local var_188_7 = 0.1

			if var_188_6 < arg_185_1.time_ and arg_185_1.time_ <= var_188_6 + arg_188_0 then
				arg_185_1.talkMaxDuration = 0
				arg_185_1.dialogCg_.alpha = 1

				arg_185_1.dialog_:SetActive(true)
				SetActive(arg_185_1.leftNameGo_, true)

				local var_188_8 = arg_185_1:FormatText(StoryNameCfg[6].name)

				arg_185_1.leftNameTxt_.text = var_188_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_185_1.leftNameTxt_.transform)

				arg_185_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_185_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_185_1:RecordName(arg_185_1.leftNameTxt_.text)
				SetActive(arg_185_1.iconTrs_.gameObject, false)
				arg_185_1.callingController_:SetSelectedState("normal")

				local var_188_9 = arg_185_1:GetWordFromCfg(319501045)
				local var_188_10 = arg_185_1:FormatText(var_188_9.content)

				arg_185_1.text_.text = var_188_10

				LuaForUtil.ClearLinePrefixSymbol(arg_185_1.text_)

				local var_188_11 = 4
				local var_188_12 = utf8.len(var_188_10)
				local var_188_13 = var_188_11 <= 0 and var_188_7 or var_188_7 * (var_188_12 / var_188_11)

				if var_188_13 > 0 and var_188_7 < var_188_13 then
					arg_185_1.talkMaxDuration = var_188_13

					if var_188_13 + var_188_6 > arg_185_1.duration_ then
						arg_185_1.duration_ = var_188_13 + var_188_6
					end
				end

				arg_185_1.text_.text = var_188_10
				arg_185_1.typewritter.percent = 0

				arg_185_1.typewritter:SetDirty()
				arg_185_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_319501", "319501045", "story_v_out_319501.awb") ~= 0 then
					local var_188_14 = manager.audio:GetVoiceLength("story_v_out_319501", "319501045", "story_v_out_319501.awb") / 1000

					if var_188_14 + var_188_6 > arg_185_1.duration_ then
						arg_185_1.duration_ = var_188_14 + var_188_6
					end

					if var_188_9.prefab_name ~= "" and arg_185_1.actors_[var_188_9.prefab_name] ~= nil then
						local var_188_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_185_1.actors_[var_188_9.prefab_name].transform, "story_v_out_319501", "319501045", "story_v_out_319501.awb")

						arg_185_1:RecordAudio("319501045", var_188_15)
						arg_185_1:RecordAudio("319501045", var_188_15)
					else
						arg_185_1:AudioAction("play", "voice", "story_v_out_319501", "319501045", "story_v_out_319501.awb")
					end

					arg_185_1:RecordHistoryTalkVoice("story_v_out_319501", "319501045", "story_v_out_319501.awb")
				end

				arg_185_1:RecordContent(arg_185_1.text_.text)
			end

			local var_188_16 = math.max(var_188_7, arg_185_1.talkMaxDuration)

			if var_188_6 <= arg_185_1.time_ and arg_185_1.time_ < var_188_6 + var_188_16 then
				arg_185_1.typewritter.percent = (arg_185_1.time_ - var_188_6) / var_188_16

				arg_185_1.typewritter:SetDirty()
			end

			if arg_185_1.time_ >= var_188_6 + var_188_16 and arg_185_1.time_ < var_188_6 + var_188_16 + arg_188_0 then
				arg_185_1.typewritter.percent = 1

				arg_185_1.typewritter:SetDirty()
				arg_185_1:ShowNextGo(true)
			end
		end

		arg_185_1.nodeConfigList_ = {}

		arg_185_1:InitPlayNodeList()
	end,
	Play319501046 = function(arg_189_0, arg_189_1)
		arg_189_1.time_ = 0
		arg_189_1.frameCnt_ = 0
		arg_189_1.state_ = "playing"
		arg_189_1.curTalkId_ = 319501046
		arg_189_1.duration_ = 5

		SetActive(arg_189_1.tipsGo_, false)

		function arg_189_1.onSingleLineFinish_()
			arg_189_1.onSingleLineUpdate_ = nil
			arg_189_1.onSingleLineFinish_ = nil
			arg_189_1.state_ = "waiting"
		end

		function arg_189_1.playNext_(arg_191_0)
			if arg_191_0 == 1 then
				arg_189_0:Play319501047(arg_189_1)
			end
		end

		function arg_189_1.onSingleLineUpdate_(arg_192_0)
			local var_192_0 = arg_189_1.actors_["1084ui_story"]
			local var_192_1 = 0

			if var_192_1 < arg_189_1.time_ and arg_189_1.time_ <= var_192_1 + arg_192_0 and not isNil(var_192_0) and arg_189_1.var_.characterEffect1084ui_story == nil then
				arg_189_1.var_.characterEffect1084ui_story = var_192_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_192_2 = 0.200000002980232

			if var_192_1 <= arg_189_1.time_ and arg_189_1.time_ < var_192_1 + var_192_2 and not isNil(var_192_0) then
				local var_192_3 = (arg_189_1.time_ - var_192_1) / var_192_2

				if arg_189_1.var_.characterEffect1084ui_story and not isNil(var_192_0) then
					local var_192_4 = Mathf.Lerp(0, 0.5, var_192_3)

					arg_189_1.var_.characterEffect1084ui_story.fillFlat = true
					arg_189_1.var_.characterEffect1084ui_story.fillRatio = var_192_4
				end
			end

			if arg_189_1.time_ >= var_192_1 + var_192_2 and arg_189_1.time_ < var_192_1 + var_192_2 + arg_192_0 and not isNil(var_192_0) and arg_189_1.var_.characterEffect1084ui_story then
				local var_192_5 = 0.5

				arg_189_1.var_.characterEffect1084ui_story.fillFlat = true
				arg_189_1.var_.characterEffect1084ui_story.fillRatio = var_192_5
			end

			local var_192_6 = 0
			local var_192_7 = 0.825

			if var_192_6 < arg_189_1.time_ and arg_189_1.time_ <= var_192_6 + arg_192_0 then
				arg_189_1.talkMaxDuration = 0
				arg_189_1.dialogCg_.alpha = 1

				arg_189_1.dialog_:SetActive(true)
				SetActive(arg_189_1.leftNameGo_, false)

				arg_189_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_189_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_189_1:RecordName(arg_189_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_189_1.iconTrs_.gameObject, false)
				arg_189_1.callingController_:SetSelectedState("normal")

				local var_192_8 = arg_189_1:GetWordFromCfg(319501046)
				local var_192_9 = arg_189_1:FormatText(var_192_8.content)

				arg_189_1.text_.text = var_192_9

				LuaForUtil.ClearLinePrefixSymbol(arg_189_1.text_)

				local var_192_10 = 33
				local var_192_11 = utf8.len(var_192_9)
				local var_192_12 = var_192_10 <= 0 and var_192_7 or var_192_7 * (var_192_11 / var_192_10)

				if var_192_12 > 0 and var_192_7 < var_192_12 then
					arg_189_1.talkMaxDuration = var_192_12

					if var_192_12 + var_192_6 > arg_189_1.duration_ then
						arg_189_1.duration_ = var_192_12 + var_192_6
					end
				end

				arg_189_1.text_.text = var_192_9
				arg_189_1.typewritter.percent = 0

				arg_189_1.typewritter:SetDirty()
				arg_189_1:ShowNextGo(false)
				arg_189_1:RecordContent(arg_189_1.text_.text)
			end

			local var_192_13 = math.max(var_192_7, arg_189_1.talkMaxDuration)

			if var_192_6 <= arg_189_1.time_ and arg_189_1.time_ < var_192_6 + var_192_13 then
				arg_189_1.typewritter.percent = (arg_189_1.time_ - var_192_6) / var_192_13

				arg_189_1.typewritter:SetDirty()
			end

			if arg_189_1.time_ >= var_192_6 + var_192_13 and arg_189_1.time_ < var_192_6 + var_192_13 + arg_192_0 then
				arg_189_1.typewritter.percent = 1

				arg_189_1.typewritter:SetDirty()
				arg_189_1:ShowNextGo(true)
			end
		end

		arg_189_1.nodeConfigList_ = {}

		arg_189_1:InitPlayNodeList()
	end,
	Play319501047 = function(arg_193_0, arg_193_1)
		arg_193_1.time_ = 0
		arg_193_1.frameCnt_ = 0
		arg_193_1.state_ = "playing"
		arg_193_1.curTalkId_ = 319501047
		arg_193_1.duration_ = 6.6

		local var_193_0 = {
			zh = 5.666,
			ja = 6.6
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
				arg_193_0:Play319501048(arg_193_1)
			end
		end

		function arg_193_1.onSingleLineUpdate_(arg_196_0)
			local var_196_0 = 0
			local var_196_1 = 0.766666666666667

			if var_196_0 < arg_193_1.time_ and arg_193_1.time_ <= var_196_0 + arg_196_0 then
				local var_196_2 = "play"
				local var_196_3 = "music"

				arg_193_1:AudioAction(var_196_2, var_196_3, "ui_battle", "ui_battle_stopbgm", "")

				local var_196_4 = ""
				local var_196_5 = manager.audio:GetAudioName("ui_battle", "ui_battle_stopbgm")

				if var_196_5 ~= "" then
					if arg_193_1.bgmTxt_.text ~= var_196_5 and arg_193_1.bgmTxt_.text ~= "" then
						if arg_193_1.bgmTxt2_.text ~= "" then
							arg_193_1.bgmTxt_.text = arg_193_1.bgmTxt2_.text
						end

						arg_193_1.bgmTxt2_.text = var_196_5

						arg_193_1.musicChangeAnimator_:Play("music_change", 0, 0)
					else
						arg_193_1.bgmTxt_.text = var_196_5
						arg_193_1.bgmTxt2_.text = var_196_5
					end

					if arg_193_1.bgmTimer then
						arg_193_1.bgmTimer:Stop()

						arg_193_1.bgmTimer = nil
					end

					if arg_193_1.settingData.show_music_name == 1 then
						arg_193_1.musicController:SetSelectedState("show")
						arg_193_1.musicAnimator_:Play("open", 0, 0)

						if arg_193_1.settingData.music_time ~= 0 then
							arg_193_1.bgmTimer = TimeTools.StartAfterSeconds(tonumber(arg_193_1.settingData.music_time), function()
								if arg_193_1 == nil or isNil(arg_193_1.bgmTxt_) then
									return
								end

								arg_193_1.musicController:SetSelectedState("hide")
								arg_193_1.musicAnimator_:Play("back", 0, 0)
							end, {})
						end
					end
				end
			end

			local var_196_6 = arg_193_1.actors_["1084ui_story"]
			local var_196_7 = 0

			if var_196_7 < arg_193_1.time_ and arg_193_1.time_ <= var_196_7 + arg_196_0 and not isNil(var_196_6) and arg_193_1.var_.characterEffect1084ui_story == nil then
				arg_193_1.var_.characterEffect1084ui_story = var_196_6:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_196_8 = 0.200000002980232

			if var_196_7 <= arg_193_1.time_ and arg_193_1.time_ < var_196_7 + var_196_8 and not isNil(var_196_6) then
				local var_196_9 = (arg_193_1.time_ - var_196_7) / var_196_8

				if arg_193_1.var_.characterEffect1084ui_story and not isNil(var_196_6) then
					arg_193_1.var_.characterEffect1084ui_story.fillFlat = false
				end
			end

			if arg_193_1.time_ >= var_196_7 + var_196_8 and arg_193_1.time_ < var_196_7 + var_196_8 + arg_196_0 and not isNil(var_196_6) and arg_193_1.var_.characterEffect1084ui_story then
				arg_193_1.var_.characterEffect1084ui_story.fillFlat = false
			end

			local var_196_10 = 0
			local var_196_11 = 0.625

			if var_196_10 < arg_193_1.time_ and arg_193_1.time_ <= var_196_10 + arg_196_0 then
				arg_193_1.talkMaxDuration = 0
				arg_193_1.dialogCg_.alpha = 1

				arg_193_1.dialog_:SetActive(true)
				SetActive(arg_193_1.leftNameGo_, true)

				local var_196_12 = arg_193_1:FormatText(StoryNameCfg[6].name)

				arg_193_1.leftNameTxt_.text = var_196_12

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_193_1.leftNameTxt_.transform)

				arg_193_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_193_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_193_1:RecordName(arg_193_1.leftNameTxt_.text)
				SetActive(arg_193_1.iconTrs_.gameObject, false)
				arg_193_1.callingController_:SetSelectedState("normal")

				local var_196_13 = arg_193_1:GetWordFromCfg(319501047)
				local var_196_14 = arg_193_1:FormatText(var_196_13.content)

				arg_193_1.text_.text = var_196_14

				LuaForUtil.ClearLinePrefixSymbol(arg_193_1.text_)

				local var_196_15 = 25
				local var_196_16 = utf8.len(var_196_14)
				local var_196_17 = var_196_15 <= 0 and var_196_11 or var_196_11 * (var_196_16 / var_196_15)

				if var_196_17 > 0 and var_196_11 < var_196_17 then
					arg_193_1.talkMaxDuration = var_196_17

					if var_196_17 + var_196_10 > arg_193_1.duration_ then
						arg_193_1.duration_ = var_196_17 + var_196_10
					end
				end

				arg_193_1.text_.text = var_196_14
				arg_193_1.typewritter.percent = 0

				arg_193_1.typewritter:SetDirty()
				arg_193_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_319501", "319501047", "story_v_out_319501.awb") ~= 0 then
					local var_196_18 = manager.audio:GetVoiceLength("story_v_out_319501", "319501047", "story_v_out_319501.awb") / 1000

					if var_196_18 + var_196_10 > arg_193_1.duration_ then
						arg_193_1.duration_ = var_196_18 + var_196_10
					end

					if var_196_13.prefab_name ~= "" and arg_193_1.actors_[var_196_13.prefab_name] ~= nil then
						local var_196_19 = LuaForUtil.PlayVoiceWithCriLipsync(arg_193_1.actors_[var_196_13.prefab_name].transform, "story_v_out_319501", "319501047", "story_v_out_319501.awb")

						arg_193_1:RecordAudio("319501047", var_196_19)
						arg_193_1:RecordAudio("319501047", var_196_19)
					else
						arg_193_1:AudioAction("play", "voice", "story_v_out_319501", "319501047", "story_v_out_319501.awb")
					end

					arg_193_1:RecordHistoryTalkVoice("story_v_out_319501", "319501047", "story_v_out_319501.awb")
				end

				arg_193_1:RecordContent(arg_193_1.text_.text)
			end

			local var_196_20 = math.max(var_196_11, arg_193_1.talkMaxDuration)

			if var_196_10 <= arg_193_1.time_ and arg_193_1.time_ < var_196_10 + var_196_20 then
				arg_193_1.typewritter.percent = (arg_193_1.time_ - var_196_10) / var_196_20

				arg_193_1.typewritter:SetDirty()
			end

			if arg_193_1.time_ >= var_196_10 + var_196_20 and arg_193_1.time_ < var_196_10 + var_196_20 + arg_196_0 then
				arg_193_1.typewritter.percent = 1

				arg_193_1.typewritter:SetDirty()
				arg_193_1:ShowNextGo(true)
			end
		end

		arg_193_1.nodeConfigList_ = {}

		arg_193_1:InitPlayNodeList()
	end,
	Play319501048 = function(arg_198_0, arg_198_1)
		arg_198_1.time_ = 0
		arg_198_1.frameCnt_ = 0
		arg_198_1.state_ = "playing"
		arg_198_1.curTalkId_ = 319501048
		arg_198_1.duration_ = 7.13

		local var_198_0 = {
			zh = 3.033,
			ja = 7.133
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
				arg_198_0:Play319501049(arg_198_1)
			end
		end

		function arg_198_1.onSingleLineUpdate_(arg_201_0)
			local var_201_0 = 0
			local var_201_1 = 0.45

			if var_201_0 < arg_198_1.time_ and arg_198_1.time_ <= var_201_0 + arg_201_0 then
				arg_198_1.talkMaxDuration = 0
				arg_198_1.dialogCg_.alpha = 1

				arg_198_1.dialog_:SetActive(true)
				SetActive(arg_198_1.leftNameGo_, true)

				local var_201_2 = arg_198_1:FormatText(StoryNameCfg[6].name)

				arg_198_1.leftNameTxt_.text = var_201_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_198_1.leftNameTxt_.transform)

				arg_198_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_198_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_198_1:RecordName(arg_198_1.leftNameTxt_.text)
				SetActive(arg_198_1.iconTrs_.gameObject, false)
				arg_198_1.callingController_:SetSelectedState("normal")

				local var_201_3 = arg_198_1:GetWordFromCfg(319501048)
				local var_201_4 = arg_198_1:FormatText(var_201_3.content)

				arg_198_1.text_.text = var_201_4

				LuaForUtil.ClearLinePrefixSymbol(arg_198_1.text_)

				local var_201_5 = 18
				local var_201_6 = utf8.len(var_201_4)
				local var_201_7 = var_201_5 <= 0 and var_201_1 or var_201_1 * (var_201_6 / var_201_5)

				if var_201_7 > 0 and var_201_1 < var_201_7 then
					arg_198_1.talkMaxDuration = var_201_7

					if var_201_7 + var_201_0 > arg_198_1.duration_ then
						arg_198_1.duration_ = var_201_7 + var_201_0
					end
				end

				arg_198_1.text_.text = var_201_4
				arg_198_1.typewritter.percent = 0

				arg_198_1.typewritter:SetDirty()
				arg_198_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_319501", "319501048", "story_v_out_319501.awb") ~= 0 then
					local var_201_8 = manager.audio:GetVoiceLength("story_v_out_319501", "319501048", "story_v_out_319501.awb") / 1000

					if var_201_8 + var_201_0 > arg_198_1.duration_ then
						arg_198_1.duration_ = var_201_8 + var_201_0
					end

					if var_201_3.prefab_name ~= "" and arg_198_1.actors_[var_201_3.prefab_name] ~= nil then
						local var_201_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_198_1.actors_[var_201_3.prefab_name].transform, "story_v_out_319501", "319501048", "story_v_out_319501.awb")

						arg_198_1:RecordAudio("319501048", var_201_9)
						arg_198_1:RecordAudio("319501048", var_201_9)
					else
						arg_198_1:AudioAction("play", "voice", "story_v_out_319501", "319501048", "story_v_out_319501.awb")
					end

					arg_198_1:RecordHistoryTalkVoice("story_v_out_319501", "319501048", "story_v_out_319501.awb")
				end

				arg_198_1:RecordContent(arg_198_1.text_.text)
			end

			local var_201_10 = math.max(var_201_1, arg_198_1.talkMaxDuration)

			if var_201_0 <= arg_198_1.time_ and arg_198_1.time_ < var_201_0 + var_201_10 then
				arg_198_1.typewritter.percent = (arg_198_1.time_ - var_201_0) / var_201_10

				arg_198_1.typewritter:SetDirty()
			end

			if arg_198_1.time_ >= var_201_0 + var_201_10 and arg_198_1.time_ < var_201_0 + var_201_10 + arg_201_0 then
				arg_198_1.typewritter.percent = 1

				arg_198_1.typewritter:SetDirty()
				arg_198_1:ShowNextGo(true)
			end
		end

		arg_198_1.nodeConfigList_ = {}

		arg_198_1:InitPlayNodeList()
	end,
	Play319501049 = function(arg_202_0, arg_202_1)
		arg_202_1.time_ = 0
		arg_202_1.frameCnt_ = 0
		arg_202_1.state_ = "playing"
		arg_202_1.curTalkId_ = 319501049
		arg_202_1.duration_ = 5

		SetActive(arg_202_1.tipsGo_, false)

		function arg_202_1.onSingleLineFinish_()
			arg_202_1.onSingleLineUpdate_ = nil
			arg_202_1.onSingleLineFinish_ = nil
			arg_202_1.state_ = "waiting"
		end

		function arg_202_1.playNext_(arg_204_0)
			if arg_204_0 == 1 then
				arg_202_0:Play319501050(arg_202_1)
			end
		end

		function arg_202_1.onSingleLineUpdate_(arg_205_0)
			local var_205_0 = arg_202_1.actors_["1084ui_story"].transform
			local var_205_1 = 0

			if var_205_1 < arg_202_1.time_ and arg_202_1.time_ <= var_205_1 + arg_205_0 then
				arg_202_1.var_.moveOldPos1084ui_story = var_205_0.localPosition
			end

			local var_205_2 = 0.001

			if var_205_1 <= arg_202_1.time_ and arg_202_1.time_ < var_205_1 + var_205_2 then
				local var_205_3 = (arg_202_1.time_ - var_205_1) / var_205_2
				local var_205_4 = Vector3.New(0, 100, 0)

				var_205_0.localPosition = Vector3.Lerp(arg_202_1.var_.moveOldPos1084ui_story, var_205_4, var_205_3)

				local var_205_5 = manager.ui.mainCamera.transform.position - var_205_0.position

				var_205_0.forward = Vector3.New(var_205_5.x, var_205_5.y, var_205_5.z)

				local var_205_6 = var_205_0.localEulerAngles

				var_205_6.z = 0
				var_205_6.x = 0
				var_205_0.localEulerAngles = var_205_6
			end

			if arg_202_1.time_ >= var_205_1 + var_205_2 and arg_202_1.time_ < var_205_1 + var_205_2 + arg_205_0 then
				var_205_0.localPosition = Vector3.New(0, 100, 0)

				local var_205_7 = manager.ui.mainCamera.transform.position - var_205_0.position

				var_205_0.forward = Vector3.New(var_205_7.x, var_205_7.y, var_205_7.z)

				local var_205_8 = var_205_0.localEulerAngles

				var_205_8.z = 0
				var_205_8.x = 0
				var_205_0.localEulerAngles = var_205_8
			end

			local var_205_9 = arg_202_1.actors_["1084ui_story"]
			local var_205_10 = 0

			if var_205_10 < arg_202_1.time_ and arg_202_1.time_ <= var_205_10 + arg_205_0 and not isNil(var_205_9) and arg_202_1.var_.characterEffect1084ui_story == nil then
				arg_202_1.var_.characterEffect1084ui_story = var_205_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_205_11 = 0.200000002980232

			if var_205_10 <= arg_202_1.time_ and arg_202_1.time_ < var_205_10 + var_205_11 and not isNil(var_205_9) then
				local var_205_12 = (arg_202_1.time_ - var_205_10) / var_205_11

				if arg_202_1.var_.characterEffect1084ui_story and not isNil(var_205_9) then
					local var_205_13 = Mathf.Lerp(0, 0.5, var_205_12)

					arg_202_1.var_.characterEffect1084ui_story.fillFlat = true
					arg_202_1.var_.characterEffect1084ui_story.fillRatio = var_205_13
				end
			end

			if arg_202_1.time_ >= var_205_10 + var_205_11 and arg_202_1.time_ < var_205_10 + var_205_11 + arg_205_0 and not isNil(var_205_9) and arg_202_1.var_.characterEffect1084ui_story then
				local var_205_14 = 0.5

				arg_202_1.var_.characterEffect1084ui_story.fillFlat = true
				arg_202_1.var_.characterEffect1084ui_story.fillRatio = var_205_14
			end

			local var_205_15 = arg_202_1.actors_["10069ui_story"].transform
			local var_205_16 = 0

			if var_205_16 < arg_202_1.time_ and arg_202_1.time_ <= var_205_16 + arg_205_0 then
				arg_202_1.var_.moveOldPos10069ui_story = var_205_15.localPosition
			end

			local var_205_17 = 0.001

			if var_205_16 <= arg_202_1.time_ and arg_202_1.time_ < var_205_16 + var_205_17 then
				local var_205_18 = (arg_202_1.time_ - var_205_16) / var_205_17
				local var_205_19 = Vector3.New(0, 100, 0)

				var_205_15.localPosition = Vector3.Lerp(arg_202_1.var_.moveOldPos10069ui_story, var_205_19, var_205_18)

				local var_205_20 = manager.ui.mainCamera.transform.position - var_205_15.position

				var_205_15.forward = Vector3.New(var_205_20.x, var_205_20.y, var_205_20.z)

				local var_205_21 = var_205_15.localEulerAngles

				var_205_21.z = 0
				var_205_21.x = 0
				var_205_15.localEulerAngles = var_205_21
			end

			if arg_202_1.time_ >= var_205_16 + var_205_17 and arg_202_1.time_ < var_205_16 + var_205_17 + arg_205_0 then
				var_205_15.localPosition = Vector3.New(0, 100, 0)

				local var_205_22 = manager.ui.mainCamera.transform.position - var_205_15.position

				var_205_15.forward = Vector3.New(var_205_22.x, var_205_22.y, var_205_22.z)

				local var_205_23 = var_205_15.localEulerAngles

				var_205_23.z = 0
				var_205_23.x = 0
				var_205_15.localEulerAngles = var_205_23
			end

			local var_205_24 = arg_202_1.actors_["10069ui_story"]
			local var_205_25 = 0

			if var_205_25 < arg_202_1.time_ and arg_202_1.time_ <= var_205_25 + arg_205_0 and not isNil(var_205_24) and arg_202_1.var_.characterEffect10069ui_story == nil then
				arg_202_1.var_.characterEffect10069ui_story = var_205_24:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_205_26 = 0.200000002980232

			if var_205_25 <= arg_202_1.time_ and arg_202_1.time_ < var_205_25 + var_205_26 and not isNil(var_205_24) then
				local var_205_27 = (arg_202_1.time_ - var_205_25) / var_205_26

				if arg_202_1.var_.characterEffect10069ui_story and not isNil(var_205_24) then
					local var_205_28 = Mathf.Lerp(0, 0.5, var_205_27)

					arg_202_1.var_.characterEffect10069ui_story.fillFlat = true
					arg_202_1.var_.characterEffect10069ui_story.fillRatio = var_205_28
				end
			end

			if arg_202_1.time_ >= var_205_25 + var_205_26 and arg_202_1.time_ < var_205_25 + var_205_26 + arg_205_0 and not isNil(var_205_24) and arg_202_1.var_.characterEffect10069ui_story then
				local var_205_29 = 0.5

				arg_202_1.var_.characterEffect10069ui_story.fillFlat = true
				arg_202_1.var_.characterEffect10069ui_story.fillRatio = var_205_29
			end

			local var_205_30 = 0
			local var_205_31 = 1

			if var_205_30 < arg_202_1.time_ and arg_202_1.time_ <= var_205_30 + arg_205_0 then
				local var_205_32 = "play"
				local var_205_33 = "effect"

				arg_202_1:AudioAction(var_205_32, var_205_33, "se_story_130", "se_story_130__knock", "")
			end

			local var_205_34 = 0
			local var_205_35 = 1.075

			if var_205_34 < arg_202_1.time_ and arg_202_1.time_ <= var_205_34 + arg_205_0 then
				arg_202_1.talkMaxDuration = 0
				arg_202_1.dialogCg_.alpha = 1

				arg_202_1.dialog_:SetActive(true)
				SetActive(arg_202_1.leftNameGo_, false)

				arg_202_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_202_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_202_1:RecordName(arg_202_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_202_1.iconTrs_.gameObject, false)
				arg_202_1.callingController_:SetSelectedState("normal")

				local var_205_36 = arg_202_1:GetWordFromCfg(319501049)
				local var_205_37 = arg_202_1:FormatText(var_205_36.content)

				arg_202_1.text_.text = var_205_37

				LuaForUtil.ClearLinePrefixSymbol(arg_202_1.text_)

				local var_205_38 = 43
				local var_205_39 = utf8.len(var_205_37)
				local var_205_40 = var_205_38 <= 0 and var_205_35 or var_205_35 * (var_205_39 / var_205_38)

				if var_205_40 > 0 and var_205_35 < var_205_40 then
					arg_202_1.talkMaxDuration = var_205_40

					if var_205_40 + var_205_34 > arg_202_1.duration_ then
						arg_202_1.duration_ = var_205_40 + var_205_34
					end
				end

				arg_202_1.text_.text = var_205_37
				arg_202_1.typewritter.percent = 0

				arg_202_1.typewritter:SetDirty()
				arg_202_1:ShowNextGo(false)
				arg_202_1:RecordContent(arg_202_1.text_.text)
			end

			local var_205_41 = math.max(var_205_35, arg_202_1.talkMaxDuration)

			if var_205_34 <= arg_202_1.time_ and arg_202_1.time_ < var_205_34 + var_205_41 then
				arg_202_1.typewritter.percent = (arg_202_1.time_ - var_205_34) / var_205_41

				arg_202_1.typewritter:SetDirty()
			end

			if arg_202_1.time_ >= var_205_34 + var_205_41 and arg_202_1.time_ < var_205_34 + var_205_41 + arg_205_0 then
				arg_202_1.typewritter.percent = 1

				arg_202_1.typewritter:SetDirty()
				arg_202_1:ShowNextGo(true)
			end
		end

		arg_202_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1084ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "10069ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_202_1:InitPlayNodeList()
	end,
	Play319501050 = function(arg_206_0, arg_206_1)
		arg_206_1.time_ = 0
		arg_206_1.frameCnt_ = 0
		arg_206_1.state_ = "playing"
		arg_206_1.curTalkId_ = 319501050
		arg_206_1.duration_ = 7

		SetActive(arg_206_1.tipsGo_, false)

		function arg_206_1.onSingleLineFinish_()
			arg_206_1.onSingleLineUpdate_ = nil
			arg_206_1.onSingleLineFinish_ = nil
			arg_206_1.state_ = "waiting"
		end

		function arg_206_1.playNext_(arg_208_0)
			if arg_208_0 == 1 then
				arg_206_0:Play319501051(arg_206_1)
			end
		end

		function arg_206_1.onSingleLineUpdate_(arg_209_0)
			local var_209_0 = "ST71"

			if arg_206_1.bgs_[var_209_0] == nil then
				local var_209_1 = Object.Instantiate(arg_206_1.paintGo_)

				var_209_1:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. var_209_0)
				var_209_1.name = var_209_0
				var_209_1.transform.parent = arg_206_1.stage_.transform
				var_209_1.transform.localPosition = Vector3.New(0, 100, 0)
				arg_206_1.bgs_[var_209_0] = var_209_1
			end

			local var_209_2 = 0

			if var_209_2 < arg_206_1.time_ and arg_206_1.time_ <= var_209_2 + arg_209_0 then
				local var_209_3 = manager.ui.mainCamera.transform.localPosition
				local var_209_4 = Vector3.New(0, 0, 10) + Vector3.New(var_209_3.x, var_209_3.y, 0)
				local var_209_5 = arg_206_1.bgs_.ST71

				var_209_5.transform.localPosition = var_209_4
				var_209_5.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_209_6 = var_209_5:GetComponent("SpriteRenderer")

				if var_209_6 and var_209_6.sprite then
					local var_209_7 = (var_209_5.transform.localPosition - var_209_3).z
					local var_209_8 = manager.ui.mainCameraCom_
					local var_209_9 = 2 * var_209_7 * Mathf.Tan(var_209_8.fieldOfView * 0.5 * Mathf.Deg2Rad)
					local var_209_10 = var_209_9 * var_209_8.aspect
					local var_209_11 = var_209_6.sprite.bounds.size.x
					local var_209_12 = var_209_6.sprite.bounds.size.y
					local var_209_13 = var_209_10 / var_209_11
					local var_209_14 = var_209_9 / var_209_12
					local var_209_15 = var_209_14 < var_209_13 and var_209_13 or var_209_14

					var_209_5.transform.localScale = Vector3.New(var_209_15, var_209_15, 0)
				end

				for iter_209_0, iter_209_1 in pairs(arg_206_1.bgs_) do
					if iter_209_0 ~= "ST71" then
						iter_209_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_209_16 = 2

			if var_209_16 < arg_206_1.time_ and arg_206_1.time_ <= var_209_16 + arg_209_0 then
				arg_206_1.allBtn_.enabled = false
			end

			local var_209_17 = 0.3

			if arg_206_1.time_ >= var_209_16 + var_209_17 and arg_206_1.time_ < var_209_16 + var_209_17 + arg_209_0 then
				arg_206_1.allBtn_.enabled = true
			end

			local var_209_18 = 0

			if var_209_18 < arg_206_1.time_ and arg_206_1.time_ <= var_209_18 + arg_209_0 then
				arg_206_1.mask_.enabled = true
				arg_206_1.mask_.raycastTarget = true

				arg_206_1:SetGaussion(false)
			end

			local var_209_19 = 2

			if var_209_18 <= arg_206_1.time_ and arg_206_1.time_ < var_209_18 + var_209_19 then
				local var_209_20 = (arg_206_1.time_ - var_209_18) / var_209_19
				local var_209_21 = Color.New(1, 1, 1)

				var_209_21.a = Mathf.Lerp(1, 0, var_209_20)
				arg_206_1.mask_.color = var_209_21
			end

			if arg_206_1.time_ >= var_209_18 + var_209_19 and arg_206_1.time_ < var_209_18 + var_209_19 + arg_209_0 then
				local var_209_22 = Color.New(1, 1, 1)
				local var_209_23 = 0

				arg_206_1.mask_.enabled = false
				var_209_22.a = var_209_23
				arg_206_1.mask_.color = var_209_22
			end

			if arg_206_1.frameCnt_ <= 1 then
				arg_206_1.dialog_:SetActive(false)
			end

			local var_209_24 = 2
			local var_209_25 = 1.825

			if var_209_24 < arg_206_1.time_ and arg_206_1.time_ <= var_209_24 + arg_209_0 then
				arg_206_1.talkMaxDuration = 0

				arg_206_1.dialog_:SetActive(true)

				arg_206_1.dialogCg_.alpha = 0

				local var_209_26 = LeanTween.value(arg_206_1.dialog_, 0, 1, 0.3)

				var_209_26:setOnUpdate(LuaHelper.FloatAction(function(arg_210_0)
					arg_206_1.dialogCg_.alpha = arg_210_0
				end))
				var_209_26:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_206_1.dialog_)
					var_209_26:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_206_1.duration_ = arg_206_1.duration_ + 0.3

				SetActive(arg_206_1.leftNameGo_, false)

				arg_206_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_206_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_206_1:RecordName(arg_206_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_206_1.iconTrs_.gameObject, false)
				arg_206_1.callingController_:SetSelectedState("normal")

				local var_209_27 = arg_206_1:GetWordFromCfg(319501050)
				local var_209_28 = arg_206_1:FormatText(var_209_27.content)

				arg_206_1.text_.text = var_209_28

				LuaForUtil.ClearLinePrefixSymbol(arg_206_1.text_)

				local var_209_29 = 73
				local var_209_30 = utf8.len(var_209_28)
				local var_209_31 = var_209_29 <= 0 and var_209_25 or var_209_25 * (var_209_30 / var_209_29)

				if var_209_31 > 0 and var_209_25 < var_209_31 then
					arg_206_1.talkMaxDuration = var_209_31
					var_209_24 = var_209_24 + 0.3

					if var_209_31 + var_209_24 > arg_206_1.duration_ then
						arg_206_1.duration_ = var_209_31 + var_209_24
					end
				end

				arg_206_1.text_.text = var_209_28
				arg_206_1.typewritter.percent = 0

				arg_206_1.typewritter:SetDirty()
				arg_206_1:ShowNextGo(false)
				arg_206_1:RecordContent(arg_206_1.text_.text)
			end

			local var_209_32 = var_209_24 + 0.3
			local var_209_33 = math.max(var_209_25, arg_206_1.talkMaxDuration)

			if var_209_32 <= arg_206_1.time_ and arg_206_1.time_ < var_209_32 + var_209_33 then
				arg_206_1.typewritter.percent = (arg_206_1.time_ - var_209_32) / var_209_33

				arg_206_1.typewritter:SetDirty()
			end

			if arg_206_1.time_ >= var_209_32 + var_209_33 and arg_206_1.time_ < var_209_32 + var_209_33 + arg_209_0 then
				arg_206_1.typewritter.percent = 1

				arg_206_1.typewritter:SetDirty()
				arg_206_1:ShowNextGo(true)
			end
		end

		arg_206_1.nodeConfigList_ = {}

		arg_206_1:InitPlayNodeList()
	end,
	Play319501051 = function(arg_212_0, arg_212_1)
		arg_212_1.time_ = 0
		arg_212_1.frameCnt_ = 0
		arg_212_1.state_ = "playing"
		arg_212_1.curTalkId_ = 319501051
		arg_212_1.duration_ = 5

		SetActive(arg_212_1.tipsGo_, false)

		function arg_212_1.onSingleLineFinish_()
			arg_212_1.onSingleLineUpdate_ = nil
			arg_212_1.onSingleLineFinish_ = nil
			arg_212_1.state_ = "waiting"
		end

		function arg_212_1.playNext_(arg_214_0)
			if arg_214_0 == 1 then
				arg_212_0:Play319501052(arg_212_1)
			end
		end

		function arg_212_1.onSingleLineUpdate_(arg_215_0)
			local var_215_0 = 0
			local var_215_1 = 1.175

			if var_215_0 < arg_212_1.time_ and arg_212_1.time_ <= var_215_0 + arg_215_0 then
				arg_212_1.talkMaxDuration = 0
				arg_212_1.dialogCg_.alpha = 1

				arg_212_1.dialog_:SetActive(true)
				SetActive(arg_212_1.leftNameGo_, false)

				arg_212_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_212_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_212_1:RecordName(arg_212_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_212_1.iconTrs_.gameObject, false)
				arg_212_1.callingController_:SetSelectedState("normal")

				local var_215_2 = arg_212_1:GetWordFromCfg(319501051)
				local var_215_3 = arg_212_1:FormatText(var_215_2.content)

				arg_212_1.text_.text = var_215_3

				LuaForUtil.ClearLinePrefixSymbol(arg_212_1.text_)

				local var_215_4 = 47
				local var_215_5 = utf8.len(var_215_3)
				local var_215_6 = var_215_4 <= 0 and var_215_1 or var_215_1 * (var_215_5 / var_215_4)

				if var_215_6 > 0 and var_215_1 < var_215_6 then
					arg_212_1.talkMaxDuration = var_215_6

					if var_215_6 + var_215_0 > arg_212_1.duration_ then
						arg_212_1.duration_ = var_215_6 + var_215_0
					end
				end

				arg_212_1.text_.text = var_215_3
				arg_212_1.typewritter.percent = 0

				arg_212_1.typewritter:SetDirty()
				arg_212_1:ShowNextGo(false)
				arg_212_1:RecordContent(arg_212_1.text_.text)
			end

			local var_215_7 = math.max(var_215_1, arg_212_1.talkMaxDuration)

			if var_215_0 <= arg_212_1.time_ and arg_212_1.time_ < var_215_0 + var_215_7 then
				arg_212_1.typewritter.percent = (arg_212_1.time_ - var_215_0) / var_215_7

				arg_212_1.typewritter:SetDirty()
			end

			if arg_212_1.time_ >= var_215_0 + var_215_7 and arg_212_1.time_ < var_215_0 + var_215_7 + arg_215_0 then
				arg_212_1.typewritter.percent = 1

				arg_212_1.typewritter:SetDirty()
				arg_212_1:ShowNextGo(true)
			end
		end

		arg_212_1.nodeConfigList_ = {}

		arg_212_1:InitPlayNodeList()
	end,
	Play319501052 = function(arg_216_0, arg_216_1)
		arg_216_1.time_ = 0
		arg_216_1.frameCnt_ = 0
		arg_216_1.state_ = "playing"
		arg_216_1.curTalkId_ = 319501052
		arg_216_1.duration_ = 5

		SetActive(arg_216_1.tipsGo_, false)

		function arg_216_1.onSingleLineFinish_()
			arg_216_1.onSingleLineUpdate_ = nil
			arg_216_1.onSingleLineFinish_ = nil
			arg_216_1.state_ = "waiting"
		end

		function arg_216_1.playNext_(arg_218_0)
			if arg_218_0 == 1 then
				arg_216_0:Play319501053(arg_216_1)
			end
		end

		function arg_216_1.onSingleLineUpdate_(arg_219_0)
			local var_219_0 = 0
			local var_219_1 = 1.425

			if var_219_0 < arg_216_1.time_ and arg_216_1.time_ <= var_219_0 + arg_219_0 then
				arg_216_1.talkMaxDuration = 0
				arg_216_1.dialogCg_.alpha = 1

				arg_216_1.dialog_:SetActive(true)
				SetActive(arg_216_1.leftNameGo_, false)

				arg_216_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_216_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_216_1:RecordName(arg_216_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_216_1.iconTrs_.gameObject, false)
				arg_216_1.callingController_:SetSelectedState("normal")

				local var_219_2 = arg_216_1:GetWordFromCfg(319501052)
				local var_219_3 = arg_216_1:FormatText(var_219_2.content)

				arg_216_1.text_.text = var_219_3

				LuaForUtil.ClearLinePrefixSymbol(arg_216_1.text_)

				local var_219_4 = 57
				local var_219_5 = utf8.len(var_219_3)
				local var_219_6 = var_219_4 <= 0 and var_219_1 or var_219_1 * (var_219_5 / var_219_4)

				if var_219_6 > 0 and var_219_1 < var_219_6 then
					arg_216_1.talkMaxDuration = var_219_6

					if var_219_6 + var_219_0 > arg_216_1.duration_ then
						arg_216_1.duration_ = var_219_6 + var_219_0
					end
				end

				arg_216_1.text_.text = var_219_3
				arg_216_1.typewritter.percent = 0

				arg_216_1.typewritter:SetDirty()
				arg_216_1:ShowNextGo(false)
				arg_216_1:RecordContent(arg_216_1.text_.text)
			end

			local var_219_7 = math.max(var_219_1, arg_216_1.talkMaxDuration)

			if var_219_0 <= arg_216_1.time_ and arg_216_1.time_ < var_219_0 + var_219_7 then
				arg_216_1.typewritter.percent = (arg_216_1.time_ - var_219_0) / var_219_7

				arg_216_1.typewritter:SetDirty()
			end

			if arg_216_1.time_ >= var_219_0 + var_219_7 and arg_216_1.time_ < var_219_0 + var_219_7 + arg_219_0 then
				arg_216_1.typewritter.percent = 1

				arg_216_1.typewritter:SetDirty()
				arg_216_1:ShowNextGo(true)
			end
		end

		arg_216_1.nodeConfigList_ = {}

		arg_216_1:InitPlayNodeList()
	end,
	Play319501053 = function(arg_220_0, arg_220_1)
		arg_220_1.time_ = 0
		arg_220_1.frameCnt_ = 0
		arg_220_1.state_ = "playing"
		arg_220_1.curTalkId_ = 319501053
		arg_220_1.duration_ = 2.6

		local var_220_0 = {
			zh = 1.233,
			ja = 2.6
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
				arg_220_0:Play319501054(arg_220_1)
			end
		end

		function arg_220_1.onSingleLineUpdate_(arg_223_0)
			local var_223_0 = arg_220_1.actors_["1084ui_story"].transform
			local var_223_1 = 0

			if var_223_1 < arg_220_1.time_ and arg_220_1.time_ <= var_223_1 + arg_223_0 then
				arg_220_1.var_.moveOldPos1084ui_story = var_223_0.localPosition
			end

			local var_223_2 = 0.001

			if var_223_1 <= arg_220_1.time_ and arg_220_1.time_ < var_223_1 + var_223_2 then
				local var_223_3 = (arg_220_1.time_ - var_223_1) / var_223_2
				local var_223_4 = Vector3.New(0, -0.97, -6)

				var_223_0.localPosition = Vector3.Lerp(arg_220_1.var_.moveOldPos1084ui_story, var_223_4, var_223_3)

				local var_223_5 = manager.ui.mainCamera.transform.position - var_223_0.position

				var_223_0.forward = Vector3.New(var_223_5.x, var_223_5.y, var_223_5.z)

				local var_223_6 = var_223_0.localEulerAngles

				var_223_6.z = 0
				var_223_6.x = 0
				var_223_0.localEulerAngles = var_223_6
			end

			if arg_220_1.time_ >= var_223_1 + var_223_2 and arg_220_1.time_ < var_223_1 + var_223_2 + arg_223_0 then
				var_223_0.localPosition = Vector3.New(0, -0.97, -6)

				local var_223_7 = manager.ui.mainCamera.transform.position - var_223_0.position

				var_223_0.forward = Vector3.New(var_223_7.x, var_223_7.y, var_223_7.z)

				local var_223_8 = var_223_0.localEulerAngles

				var_223_8.z = 0
				var_223_8.x = 0
				var_223_0.localEulerAngles = var_223_8
			end

			local var_223_9 = arg_220_1.actors_["1084ui_story"]
			local var_223_10 = 0

			if var_223_10 < arg_220_1.time_ and arg_220_1.time_ <= var_223_10 + arg_223_0 and not isNil(var_223_9) and arg_220_1.var_.characterEffect1084ui_story == nil then
				arg_220_1.var_.characterEffect1084ui_story = var_223_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_223_11 = 0.200000002980232

			if var_223_10 <= arg_220_1.time_ and arg_220_1.time_ < var_223_10 + var_223_11 and not isNil(var_223_9) then
				local var_223_12 = (arg_220_1.time_ - var_223_10) / var_223_11

				if arg_220_1.var_.characterEffect1084ui_story and not isNil(var_223_9) then
					arg_220_1.var_.characterEffect1084ui_story.fillFlat = false
				end
			end

			if arg_220_1.time_ >= var_223_10 + var_223_11 and arg_220_1.time_ < var_223_10 + var_223_11 + arg_223_0 and not isNil(var_223_9) and arg_220_1.var_.characterEffect1084ui_story then
				arg_220_1.var_.characterEffect1084ui_story.fillFlat = false
			end

			local var_223_13 = 0

			if var_223_13 < arg_220_1.time_ and arg_220_1.time_ <= var_223_13 + arg_223_0 then
				arg_220_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/story1084/story1084action/1084action1_1")
			end

			local var_223_14 = 0

			if var_223_14 < arg_220_1.time_ and arg_220_1.time_ <= var_223_14 + arg_223_0 then
				arg_220_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_223_15 = 0
			local var_223_16 = 0.125

			if var_223_15 < arg_220_1.time_ and arg_220_1.time_ <= var_223_15 + arg_223_0 then
				arg_220_1.talkMaxDuration = 0
				arg_220_1.dialogCg_.alpha = 1

				arg_220_1.dialog_:SetActive(true)
				SetActive(arg_220_1.leftNameGo_, true)

				local var_223_17 = arg_220_1:FormatText(StoryNameCfg[6].name)

				arg_220_1.leftNameTxt_.text = var_223_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_220_1.leftNameTxt_.transform)

				arg_220_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_220_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_220_1:RecordName(arg_220_1.leftNameTxt_.text)
				SetActive(arg_220_1.iconTrs_.gameObject, false)
				arg_220_1.callingController_:SetSelectedState("normal")

				local var_223_18 = arg_220_1:GetWordFromCfg(319501053)
				local var_223_19 = arg_220_1:FormatText(var_223_18.content)

				arg_220_1.text_.text = var_223_19

				LuaForUtil.ClearLinePrefixSymbol(arg_220_1.text_)

				local var_223_20 = 5
				local var_223_21 = utf8.len(var_223_19)
				local var_223_22 = var_223_20 <= 0 and var_223_16 or var_223_16 * (var_223_21 / var_223_20)

				if var_223_22 > 0 and var_223_16 < var_223_22 then
					arg_220_1.talkMaxDuration = var_223_22

					if var_223_22 + var_223_15 > arg_220_1.duration_ then
						arg_220_1.duration_ = var_223_22 + var_223_15
					end
				end

				arg_220_1.text_.text = var_223_19
				arg_220_1.typewritter.percent = 0

				arg_220_1.typewritter:SetDirty()
				arg_220_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_319501", "319501053", "story_v_out_319501.awb") ~= 0 then
					local var_223_23 = manager.audio:GetVoiceLength("story_v_out_319501", "319501053", "story_v_out_319501.awb") / 1000

					if var_223_23 + var_223_15 > arg_220_1.duration_ then
						arg_220_1.duration_ = var_223_23 + var_223_15
					end

					if var_223_18.prefab_name ~= "" and arg_220_1.actors_[var_223_18.prefab_name] ~= nil then
						local var_223_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_220_1.actors_[var_223_18.prefab_name].transform, "story_v_out_319501", "319501053", "story_v_out_319501.awb")

						arg_220_1:RecordAudio("319501053", var_223_24)
						arg_220_1:RecordAudio("319501053", var_223_24)
					else
						arg_220_1:AudioAction("play", "voice", "story_v_out_319501", "319501053", "story_v_out_319501.awb")
					end

					arg_220_1:RecordHistoryTalkVoice("story_v_out_319501", "319501053", "story_v_out_319501.awb")
				end

				arg_220_1:RecordContent(arg_220_1.text_.text)
			end

			local var_223_25 = math.max(var_223_16, arg_220_1.talkMaxDuration)

			if var_223_15 <= arg_220_1.time_ and arg_220_1.time_ < var_223_15 + var_223_25 then
				arg_220_1.typewritter.percent = (arg_220_1.time_ - var_223_15) / var_223_25

				arg_220_1.typewritter:SetDirty()
			end

			if arg_220_1.time_ >= var_223_15 + var_223_25 and arg_220_1.time_ < var_223_15 + var_223_25 + arg_223_0 then
				arg_220_1.typewritter.percent = 1

				arg_220_1.typewritter:SetDirty()
				arg_220_1:ShowNextGo(true)
			end
		end

		arg_220_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1084ui_story",
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
	Play319501054 = function(arg_224_0, arg_224_1)
		arg_224_1.time_ = 0
		arg_224_1.frameCnt_ = 0
		arg_224_1.state_ = "playing"
		arg_224_1.curTalkId_ = 319501054
		arg_224_1.duration_ = 2

		SetActive(arg_224_1.tipsGo_, false)

		function arg_224_1.onSingleLineFinish_()
			arg_224_1.onSingleLineUpdate_ = nil
			arg_224_1.onSingleLineFinish_ = nil
			arg_224_1.state_ = "waiting"
		end

		function arg_224_1.playNext_(arg_226_0)
			if arg_226_0 == 1 then
				arg_224_0:Play319501055(arg_224_1)
			end
		end

		function arg_224_1.onSingleLineUpdate_(arg_227_0)
			local var_227_0 = "10068ui_story"

			if arg_224_1.actors_[var_227_0] == nil then
				local var_227_1 = Asset.Load("Char/" .. "10068ui_story")

				if not isNil(var_227_1) then
					local var_227_2 = Object.Instantiate(Asset.Load("Char/" .. "10068ui_story"), arg_224_1.stage_.transform)

					var_227_2.name = var_227_0
					var_227_2.transform.localPosition = Vector3.New(0, 100, 0)
					arg_224_1.actors_[var_227_0] = var_227_2

					local var_227_3 = var_227_2:GetComponentInChildren(typeof(CharacterEffect))

					var_227_3.enabled = true

					local var_227_4 = GameObjectTools.GetOrAddComponent(var_227_2, typeof(DynamicBoneHelper))

					if var_227_4 then
						var_227_4:EnableDynamicBone(false)
					end

					arg_224_1:ShowWeapon(var_227_3.transform, false)

					arg_224_1.var_[var_227_0 .. "Animator"] = var_227_3.gameObject:GetComponent(typeof(UnityEngine.Animator))
					arg_224_1.var_[var_227_0 .. "Animator"].applyRootMotion = true
					arg_224_1.var_[var_227_0 .. "LipSync"] = var_227_3.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
				end
			end

			local var_227_5 = arg_224_1.actors_["10068ui_story"].transform
			local var_227_6 = 0

			if var_227_6 < arg_224_1.time_ and arg_224_1.time_ <= var_227_6 + arg_227_0 then
				arg_224_1.var_.moveOldPos10068ui_story = var_227_5.localPosition
			end

			local var_227_7 = 0.001

			if var_227_6 <= arg_224_1.time_ and arg_224_1.time_ < var_227_6 + var_227_7 then
				local var_227_8 = (arg_224_1.time_ - var_227_6) / var_227_7
				local var_227_9 = Vector3.New(0.7, -0.75, -6.18)

				var_227_5.localPosition = Vector3.Lerp(arg_224_1.var_.moveOldPos10068ui_story, var_227_9, var_227_8)

				local var_227_10 = manager.ui.mainCamera.transform.position - var_227_5.position

				var_227_5.forward = Vector3.New(var_227_10.x, var_227_10.y, var_227_10.z)

				local var_227_11 = var_227_5.localEulerAngles

				var_227_11.z = 0
				var_227_11.x = 0
				var_227_5.localEulerAngles = var_227_11
			end

			if arg_224_1.time_ >= var_227_6 + var_227_7 and arg_224_1.time_ < var_227_6 + var_227_7 + arg_227_0 then
				var_227_5.localPosition = Vector3.New(0.7, -0.75, -6.18)

				local var_227_12 = manager.ui.mainCamera.transform.position - var_227_5.position

				var_227_5.forward = Vector3.New(var_227_12.x, var_227_12.y, var_227_12.z)

				local var_227_13 = var_227_5.localEulerAngles

				var_227_13.z = 0
				var_227_13.x = 0
				var_227_5.localEulerAngles = var_227_13
			end

			local var_227_14 = arg_224_1.actors_["10068ui_story"]
			local var_227_15 = 0

			if var_227_15 < arg_224_1.time_ and arg_224_1.time_ <= var_227_15 + arg_227_0 and not isNil(var_227_14) and arg_224_1.var_.characterEffect10068ui_story == nil then
				arg_224_1.var_.characterEffect10068ui_story = var_227_14:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_227_16 = 0.200000002980232

			if var_227_15 <= arg_224_1.time_ and arg_224_1.time_ < var_227_15 + var_227_16 and not isNil(var_227_14) then
				local var_227_17 = (arg_224_1.time_ - var_227_15) / var_227_16

				if arg_224_1.var_.characterEffect10068ui_story and not isNil(var_227_14) then
					arg_224_1.var_.characterEffect10068ui_story.fillFlat = false
				end
			end

			if arg_224_1.time_ >= var_227_15 + var_227_16 and arg_224_1.time_ < var_227_15 + var_227_16 + arg_227_0 and not isNil(var_227_14) and arg_224_1.var_.characterEffect10068ui_story then
				arg_224_1.var_.characterEffect10068ui_story.fillFlat = false
			end

			local var_227_18 = 0

			if var_227_18 < arg_224_1.time_ and arg_224_1.time_ <= var_227_18 + arg_227_0 then
				arg_224_1:PlayTimeline("10068ui_story", "StoryTimeline/CharAction/story10068/story10068action/10068action2_1")
			end

			local var_227_19 = 0

			if var_227_19 < arg_224_1.time_ and arg_224_1.time_ <= var_227_19 + arg_227_0 then
				arg_224_1:PlayTimeline("10068ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3201cva")
			end

			local var_227_20 = arg_224_1.actors_["1084ui_story"].transform
			local var_227_21 = 0

			if var_227_21 < arg_224_1.time_ and arg_224_1.time_ <= var_227_21 + arg_227_0 then
				arg_224_1.var_.moveOldPos1084ui_story = var_227_20.localPosition
			end

			local var_227_22 = 0.001

			if var_227_21 <= arg_224_1.time_ and arg_224_1.time_ < var_227_21 + var_227_22 then
				local var_227_23 = (arg_224_1.time_ - var_227_21) / var_227_22
				local var_227_24 = Vector3.New(-0.7, -0.97, -6)

				var_227_20.localPosition = Vector3.Lerp(arg_224_1.var_.moveOldPos1084ui_story, var_227_24, var_227_23)

				local var_227_25 = manager.ui.mainCamera.transform.position - var_227_20.position

				var_227_20.forward = Vector3.New(var_227_25.x, var_227_25.y, var_227_25.z)

				local var_227_26 = var_227_20.localEulerAngles

				var_227_26.z = 0
				var_227_26.x = 0
				var_227_20.localEulerAngles = var_227_26
			end

			if arg_224_1.time_ >= var_227_21 + var_227_22 and arg_224_1.time_ < var_227_21 + var_227_22 + arg_227_0 then
				var_227_20.localPosition = Vector3.New(-0.7, -0.97, -6)

				local var_227_27 = manager.ui.mainCamera.transform.position - var_227_20.position

				var_227_20.forward = Vector3.New(var_227_27.x, var_227_27.y, var_227_27.z)

				local var_227_28 = var_227_20.localEulerAngles

				var_227_28.z = 0
				var_227_28.x = 0
				var_227_20.localEulerAngles = var_227_28
			end

			local var_227_29 = arg_224_1.actors_["1084ui_story"]
			local var_227_30 = 0

			if var_227_30 < arg_224_1.time_ and arg_224_1.time_ <= var_227_30 + arg_227_0 and not isNil(var_227_29) and arg_224_1.var_.characterEffect1084ui_story == nil then
				arg_224_1.var_.characterEffect1084ui_story = var_227_29:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_227_31 = 0.200000002980232

			if var_227_30 <= arg_224_1.time_ and arg_224_1.time_ < var_227_30 + var_227_31 and not isNil(var_227_29) then
				local var_227_32 = (arg_224_1.time_ - var_227_30) / var_227_31

				if arg_224_1.var_.characterEffect1084ui_story and not isNil(var_227_29) then
					local var_227_33 = Mathf.Lerp(0, 0.5, var_227_32)

					arg_224_1.var_.characterEffect1084ui_story.fillFlat = true
					arg_224_1.var_.characterEffect1084ui_story.fillRatio = var_227_33
				end
			end

			if arg_224_1.time_ >= var_227_30 + var_227_31 and arg_224_1.time_ < var_227_30 + var_227_31 + arg_227_0 and not isNil(var_227_29) and arg_224_1.var_.characterEffect1084ui_story then
				local var_227_34 = 0.5

				arg_224_1.var_.characterEffect1084ui_story.fillFlat = true
				arg_224_1.var_.characterEffect1084ui_story.fillRatio = var_227_34
			end

			local var_227_35 = 0
			local var_227_36 = 0.0666666666666667

			if var_227_35 < arg_224_1.time_ and arg_224_1.time_ <= var_227_35 + arg_227_0 then
				local var_227_37 = "play"
				local var_227_38 = "music"

				arg_224_1:AudioAction(var_227_37, var_227_38, "ui_battle", "ui_battle_stopbgm", "")

				local var_227_39 = ""
				local var_227_40 = manager.audio:GetAudioName("ui_battle", "ui_battle_stopbgm")

				if var_227_40 ~= "" then
					if arg_224_1.bgmTxt_.text ~= var_227_40 and arg_224_1.bgmTxt_.text ~= "" then
						if arg_224_1.bgmTxt2_.text ~= "" then
							arg_224_1.bgmTxt_.text = arg_224_1.bgmTxt2_.text
						end

						arg_224_1.bgmTxt2_.text = var_227_40

						arg_224_1.musicChangeAnimator_:Play("music_change", 0, 0)
					else
						arg_224_1.bgmTxt_.text = var_227_40
						arg_224_1.bgmTxt2_.text = var_227_40
					end

					if arg_224_1.bgmTimer then
						arg_224_1.bgmTimer:Stop()

						arg_224_1.bgmTimer = nil
					end

					if arg_224_1.settingData.show_music_name == 1 then
						arg_224_1.musicController:SetSelectedState("show")
						arg_224_1.musicAnimator_:Play("open", 0, 0)

						if arg_224_1.settingData.music_time ~= 0 then
							arg_224_1.bgmTimer = TimeTools.StartAfterSeconds(tonumber(arg_224_1.settingData.music_time), function()
								if arg_224_1 == nil or isNil(arg_224_1.bgmTxt_) then
									return
								end

								arg_224_1.musicController:SetSelectedState("hide")
								arg_224_1.musicAnimator_:Play("back", 0, 0)
							end, {})
						end
					end
				end
			end

			local var_227_41 = 0.1
			local var_227_42 = 1

			if var_227_41 < arg_224_1.time_ and arg_224_1.time_ <= var_227_41 + arg_227_0 then
				local var_227_43 = "play"
				local var_227_44 = "music"

				arg_224_1:AudioAction(var_227_43, var_227_44, "bgm_activity_3_0_story_theme_orgel", "bgm_activity_3_0_story_theme_orgel", "bgm_activity_3_0_story_theme_orgel.awb")

				local var_227_45 = ""
				local var_227_46 = manager.audio:GetAudioName("bgm_activity_3_0_story_theme_orgel", "bgm_activity_3_0_story_theme_orgel")

				if var_227_46 ~= "" then
					if arg_224_1.bgmTxt_.text ~= var_227_46 and arg_224_1.bgmTxt_.text ~= "" then
						if arg_224_1.bgmTxt2_.text ~= "" then
							arg_224_1.bgmTxt_.text = arg_224_1.bgmTxt2_.text
						end

						arg_224_1.bgmTxt2_.text = var_227_46

						arg_224_1.musicChangeAnimator_:Play("music_change", 0, 0)
					else
						arg_224_1.bgmTxt_.text = var_227_46
						arg_224_1.bgmTxt2_.text = var_227_46
					end

					if arg_224_1.bgmTimer then
						arg_224_1.bgmTimer:Stop()

						arg_224_1.bgmTimer = nil
					end

					if arg_224_1.settingData.show_music_name == 1 then
						arg_224_1.musicController:SetSelectedState("show")
						arg_224_1.musicAnimator_:Play("open", 0, 0)

						if arg_224_1.settingData.music_time ~= 0 then
							arg_224_1.bgmTimer = TimeTools.StartAfterSeconds(tonumber(arg_224_1.settingData.music_time), function()
								if arg_224_1 == nil or isNil(arg_224_1.bgmTxt_) then
									return
								end

								arg_224_1.musicController:SetSelectedState("hide")
								arg_224_1.musicAnimator_:Play("back", 0, 0)
							end, {})
						end
					end
				end
			end

			local var_227_47 = 0
			local var_227_48 = 0.05

			if var_227_47 < arg_224_1.time_ and arg_224_1.time_ <= var_227_47 + arg_227_0 then
				arg_224_1.talkMaxDuration = 0
				arg_224_1.dialogCg_.alpha = 1

				arg_224_1.dialog_:SetActive(true)
				SetActive(arg_224_1.leftNameGo_, true)

				local var_227_49 = arg_224_1:FormatText(StoryNameCfg[697].name)

				arg_224_1.leftNameTxt_.text = var_227_49

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_224_1.leftNameTxt_.transform)

				arg_224_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_224_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_224_1:RecordName(arg_224_1.leftNameTxt_.text)
				SetActive(arg_224_1.iconTrs_.gameObject, false)
				arg_224_1.callingController_:SetSelectedState("normal")

				local var_227_50 = arg_224_1:GetWordFromCfg(319501054)
				local var_227_51 = arg_224_1:FormatText(var_227_50.content)

				arg_224_1.text_.text = var_227_51

				LuaForUtil.ClearLinePrefixSymbol(arg_224_1.text_)

				local var_227_52 = 2
				local var_227_53 = utf8.len(var_227_51)
				local var_227_54 = var_227_52 <= 0 and var_227_48 or var_227_48 * (var_227_53 / var_227_52)

				if var_227_54 > 0 and var_227_48 < var_227_54 then
					arg_224_1.talkMaxDuration = var_227_54

					if var_227_54 + var_227_47 > arg_224_1.duration_ then
						arg_224_1.duration_ = var_227_54 + var_227_47
					end
				end

				arg_224_1.text_.text = var_227_51
				arg_224_1.typewritter.percent = 0

				arg_224_1.typewritter:SetDirty()
				arg_224_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_319501", "319501054", "story_v_out_319501.awb") ~= 0 then
					local var_227_55 = manager.audio:GetVoiceLength("story_v_out_319501", "319501054", "story_v_out_319501.awb") / 1000

					if var_227_55 + var_227_47 > arg_224_1.duration_ then
						arg_224_1.duration_ = var_227_55 + var_227_47
					end

					if var_227_50.prefab_name ~= "" and arg_224_1.actors_[var_227_50.prefab_name] ~= nil then
						local var_227_56 = LuaForUtil.PlayVoiceWithCriLipsync(arg_224_1.actors_[var_227_50.prefab_name].transform, "story_v_out_319501", "319501054", "story_v_out_319501.awb")

						arg_224_1:RecordAudio("319501054", var_227_56)
						arg_224_1:RecordAudio("319501054", var_227_56)
					else
						arg_224_1:AudioAction("play", "voice", "story_v_out_319501", "319501054", "story_v_out_319501.awb")
					end

					arg_224_1:RecordHistoryTalkVoice("story_v_out_319501", "319501054", "story_v_out_319501.awb")
				end

				arg_224_1:RecordContent(arg_224_1.text_.text)
			end

			local var_227_57 = math.max(var_227_48, arg_224_1.talkMaxDuration)

			if var_227_47 <= arg_224_1.time_ and arg_224_1.time_ < var_227_47 + var_227_57 then
				arg_224_1.typewritter.percent = (arg_224_1.time_ - var_227_47) / var_227_57

				arg_224_1.typewritter:SetDirty()
			end

			if arg_224_1.time_ >= var_227_47 + var_227_57 and arg_224_1.time_ < var_227_47 + var_227_57 + arg_227_0 then
				arg_224_1.typewritter.percent = 1

				arg_224_1.typewritter:SetDirty()
				arg_224_1:ShowNextGo(true)
			end
		end

		arg_224_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10068ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1084ui_story",
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
	Play319501055 = function(arg_230_0, arg_230_1)
		arg_230_1.time_ = 0
		arg_230_1.frameCnt_ = 0
		arg_230_1.state_ = "playing"
		arg_230_1.curTalkId_ = 319501055
		arg_230_1.duration_ = 5.87

		local var_230_0 = {
			zh = 1.8,
			ja = 5.866
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
				arg_230_0:Play319501056(arg_230_1)
			end
		end

		function arg_230_1.onSingleLineUpdate_(arg_233_0)
			local var_233_0 = 0
			local var_233_1 = 0.175

			if var_233_0 < arg_230_1.time_ and arg_230_1.time_ <= var_233_0 + arg_233_0 then
				arg_230_1.talkMaxDuration = 0
				arg_230_1.dialogCg_.alpha = 1

				arg_230_1.dialog_:SetActive(true)
				SetActive(arg_230_1.leftNameGo_, true)

				local var_233_2 = arg_230_1:FormatText(StoryNameCfg[697].name)

				arg_230_1.leftNameTxt_.text = var_233_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_230_1.leftNameTxt_.transform)

				arg_230_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_230_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_230_1:RecordName(arg_230_1.leftNameTxt_.text)
				SetActive(arg_230_1.iconTrs_.gameObject, false)
				arg_230_1.callingController_:SetSelectedState("normal")

				local var_233_3 = arg_230_1:GetWordFromCfg(319501055)
				local var_233_4 = arg_230_1:FormatText(var_233_3.content)

				arg_230_1.text_.text = var_233_4

				LuaForUtil.ClearLinePrefixSymbol(arg_230_1.text_)

				local var_233_5 = 7
				local var_233_6 = utf8.len(var_233_4)
				local var_233_7 = var_233_5 <= 0 and var_233_1 or var_233_1 * (var_233_6 / var_233_5)

				if var_233_7 > 0 and var_233_1 < var_233_7 then
					arg_230_1.talkMaxDuration = var_233_7

					if var_233_7 + var_233_0 > arg_230_1.duration_ then
						arg_230_1.duration_ = var_233_7 + var_233_0
					end
				end

				arg_230_1.text_.text = var_233_4
				arg_230_1.typewritter.percent = 0

				arg_230_1.typewritter:SetDirty()
				arg_230_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_319501", "319501055", "story_v_out_319501.awb") ~= 0 then
					local var_233_8 = manager.audio:GetVoiceLength("story_v_out_319501", "319501055", "story_v_out_319501.awb") / 1000

					if var_233_8 + var_233_0 > arg_230_1.duration_ then
						arg_230_1.duration_ = var_233_8 + var_233_0
					end

					if var_233_3.prefab_name ~= "" and arg_230_1.actors_[var_233_3.prefab_name] ~= nil then
						local var_233_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_230_1.actors_[var_233_3.prefab_name].transform, "story_v_out_319501", "319501055", "story_v_out_319501.awb")

						arg_230_1:RecordAudio("319501055", var_233_9)
						arg_230_1:RecordAudio("319501055", var_233_9)
					else
						arg_230_1:AudioAction("play", "voice", "story_v_out_319501", "319501055", "story_v_out_319501.awb")
					end

					arg_230_1:RecordHistoryTalkVoice("story_v_out_319501", "319501055", "story_v_out_319501.awb")
				end

				arg_230_1:RecordContent(arg_230_1.text_.text)
			end

			local var_233_10 = math.max(var_233_1, arg_230_1.talkMaxDuration)

			if var_233_0 <= arg_230_1.time_ and arg_230_1.time_ < var_233_0 + var_233_10 then
				arg_230_1.typewritter.percent = (arg_230_1.time_ - var_233_0) / var_233_10

				arg_230_1.typewritter:SetDirty()
			end

			if arg_230_1.time_ >= var_233_0 + var_233_10 and arg_230_1.time_ < var_233_0 + var_233_10 + arg_233_0 then
				arg_230_1.typewritter.percent = 1

				arg_230_1.typewritter:SetDirty()
				arg_230_1:ShowNextGo(true)
			end
		end

		arg_230_1.nodeConfigList_ = {}

		arg_230_1:InitPlayNodeList()
	end,
	Play319501056 = function(arg_234_0, arg_234_1)
		arg_234_1.time_ = 0
		arg_234_1.frameCnt_ = 0
		arg_234_1.state_ = "playing"
		arg_234_1.curTalkId_ = 319501056
		arg_234_1.duration_ = 5

		SetActive(arg_234_1.tipsGo_, false)

		function arg_234_1.onSingleLineFinish_()
			arg_234_1.onSingleLineUpdate_ = nil
			arg_234_1.onSingleLineFinish_ = nil
			arg_234_1.state_ = "waiting"
		end

		function arg_234_1.playNext_(arg_236_0)
			if arg_236_0 == 1 then
				arg_234_0:Play319501057(arg_234_1)
			end
		end

		function arg_234_1.onSingleLineUpdate_(arg_237_0)
			local var_237_0 = arg_234_1.actors_["10068ui_story"]
			local var_237_1 = 0

			if var_237_1 < arg_234_1.time_ and arg_234_1.time_ <= var_237_1 + arg_237_0 and not isNil(var_237_0) and arg_234_1.var_.characterEffect10068ui_story == nil then
				arg_234_1.var_.characterEffect10068ui_story = var_237_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_237_2 = 0.200000002980232

			if var_237_1 <= arg_234_1.time_ and arg_234_1.time_ < var_237_1 + var_237_2 and not isNil(var_237_0) then
				local var_237_3 = (arg_234_1.time_ - var_237_1) / var_237_2

				if arg_234_1.var_.characterEffect10068ui_story and not isNil(var_237_0) then
					local var_237_4 = Mathf.Lerp(0, 0.5, var_237_3)

					arg_234_1.var_.characterEffect10068ui_story.fillFlat = true
					arg_234_1.var_.characterEffect10068ui_story.fillRatio = var_237_4
				end
			end

			if arg_234_1.time_ >= var_237_1 + var_237_2 and arg_234_1.time_ < var_237_1 + var_237_2 + arg_237_0 and not isNil(var_237_0) and arg_234_1.var_.characterEffect10068ui_story then
				local var_237_5 = 0.5

				arg_234_1.var_.characterEffect10068ui_story.fillFlat = true
				arg_234_1.var_.characterEffect10068ui_story.fillRatio = var_237_5
			end

			local var_237_6 = 0
			local var_237_7 = 1.1

			if var_237_6 < arg_234_1.time_ and arg_234_1.time_ <= var_237_6 + arg_237_0 then
				arg_234_1.talkMaxDuration = 0
				arg_234_1.dialogCg_.alpha = 1

				arg_234_1.dialog_:SetActive(true)
				SetActive(arg_234_1.leftNameGo_, false)

				arg_234_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_234_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_234_1:RecordName(arg_234_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_234_1.iconTrs_.gameObject, false)
				arg_234_1.callingController_:SetSelectedState("normal")

				local var_237_8 = arg_234_1:GetWordFromCfg(319501056)
				local var_237_9 = arg_234_1:FormatText(var_237_8.content)

				arg_234_1.text_.text = var_237_9

				LuaForUtil.ClearLinePrefixSymbol(arg_234_1.text_)

				local var_237_10 = 44
				local var_237_11 = utf8.len(var_237_9)
				local var_237_12 = var_237_10 <= 0 and var_237_7 or var_237_7 * (var_237_11 / var_237_10)

				if var_237_12 > 0 and var_237_7 < var_237_12 then
					arg_234_1.talkMaxDuration = var_237_12

					if var_237_12 + var_237_6 > arg_234_1.duration_ then
						arg_234_1.duration_ = var_237_12 + var_237_6
					end
				end

				arg_234_1.text_.text = var_237_9
				arg_234_1.typewritter.percent = 0

				arg_234_1.typewritter:SetDirty()
				arg_234_1:ShowNextGo(false)
				arg_234_1:RecordContent(arg_234_1.text_.text)
			end

			local var_237_13 = math.max(var_237_7, arg_234_1.talkMaxDuration)

			if var_237_6 <= arg_234_1.time_ and arg_234_1.time_ < var_237_6 + var_237_13 then
				arg_234_1.typewritter.percent = (arg_234_1.time_ - var_237_6) / var_237_13

				arg_234_1.typewritter:SetDirty()
			end

			if arg_234_1.time_ >= var_237_6 + var_237_13 and arg_234_1.time_ < var_237_6 + var_237_13 + arg_237_0 then
				arg_234_1.typewritter.percent = 1

				arg_234_1.typewritter:SetDirty()
				arg_234_1:ShowNextGo(true)
			end
		end

		arg_234_1.nodeConfigList_ = {}

		arg_234_1:InitPlayNodeList()
	end,
	Play319501057 = function(arg_238_0, arg_238_1)
		arg_238_1.time_ = 0
		arg_238_1.frameCnt_ = 0
		arg_238_1.state_ = "playing"
		arg_238_1.curTalkId_ = 319501057
		arg_238_1.duration_ = 14.87

		local var_238_0 = {
			zh = 6.166,
			ja = 14.866
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
				arg_238_0:Play319501058(arg_238_1)
			end
		end

		function arg_238_1.onSingleLineUpdate_(arg_241_0)
			local var_241_0 = arg_238_1.actors_["1084ui_story"].transform
			local var_241_1 = 0

			if var_241_1 < arg_238_1.time_ and arg_238_1.time_ <= var_241_1 + arg_241_0 then
				arg_238_1.var_.moveOldPos1084ui_story = var_241_0.localPosition
			end

			local var_241_2 = 0.001

			if var_241_1 <= arg_238_1.time_ and arg_238_1.time_ < var_241_1 + var_241_2 then
				local var_241_3 = (arg_238_1.time_ - var_241_1) / var_241_2
				local var_241_4 = Vector3.New(-0.7, -0.97, -6)

				var_241_0.localPosition = Vector3.Lerp(arg_238_1.var_.moveOldPos1084ui_story, var_241_4, var_241_3)

				local var_241_5 = manager.ui.mainCamera.transform.position - var_241_0.position

				var_241_0.forward = Vector3.New(var_241_5.x, var_241_5.y, var_241_5.z)

				local var_241_6 = var_241_0.localEulerAngles

				var_241_6.z = 0
				var_241_6.x = 0
				var_241_0.localEulerAngles = var_241_6
			end

			if arg_238_1.time_ >= var_241_1 + var_241_2 and arg_238_1.time_ < var_241_1 + var_241_2 + arg_241_0 then
				var_241_0.localPosition = Vector3.New(-0.7, -0.97, -6)

				local var_241_7 = manager.ui.mainCamera.transform.position - var_241_0.position

				var_241_0.forward = Vector3.New(var_241_7.x, var_241_7.y, var_241_7.z)

				local var_241_8 = var_241_0.localEulerAngles

				var_241_8.z = 0
				var_241_8.x = 0
				var_241_0.localEulerAngles = var_241_8
			end

			local var_241_9 = arg_238_1.actors_["1084ui_story"]
			local var_241_10 = 0

			if var_241_10 < arg_238_1.time_ and arg_238_1.time_ <= var_241_10 + arg_241_0 and not isNil(var_241_9) and arg_238_1.var_.characterEffect1084ui_story == nil then
				arg_238_1.var_.characterEffect1084ui_story = var_241_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_241_11 = 0.200000002980232

			if var_241_10 <= arg_238_1.time_ and arg_238_1.time_ < var_241_10 + var_241_11 and not isNil(var_241_9) then
				local var_241_12 = (arg_238_1.time_ - var_241_10) / var_241_11

				if arg_238_1.var_.characterEffect1084ui_story and not isNil(var_241_9) then
					arg_238_1.var_.characterEffect1084ui_story.fillFlat = false
				end
			end

			if arg_238_1.time_ >= var_241_10 + var_241_11 and arg_238_1.time_ < var_241_10 + var_241_11 + arg_241_0 and not isNil(var_241_9) and arg_238_1.var_.characterEffect1084ui_story then
				arg_238_1.var_.characterEffect1084ui_story.fillFlat = false
			end

			local var_241_13 = 0

			if var_241_13 < arg_238_1.time_ and arg_238_1.time_ <= var_241_13 + arg_241_0 then
				arg_238_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/story1084/story1084action/1084action1_1")
			end

			local var_241_14 = 0

			if var_241_14 < arg_238_1.time_ and arg_238_1.time_ <= var_241_14 + arg_241_0 then
				arg_238_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_241_15 = 0
			local var_241_16 = 0.675

			if var_241_15 < arg_238_1.time_ and arg_238_1.time_ <= var_241_15 + arg_241_0 then
				arg_238_1.talkMaxDuration = 0
				arg_238_1.dialogCg_.alpha = 1

				arg_238_1.dialog_:SetActive(true)
				SetActive(arg_238_1.leftNameGo_, true)

				local var_241_17 = arg_238_1:FormatText(StoryNameCfg[6].name)

				arg_238_1.leftNameTxt_.text = var_241_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_238_1.leftNameTxt_.transform)

				arg_238_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_238_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_238_1:RecordName(arg_238_1.leftNameTxt_.text)
				SetActive(arg_238_1.iconTrs_.gameObject, false)
				arg_238_1.callingController_:SetSelectedState("normal")

				local var_241_18 = arg_238_1:GetWordFromCfg(319501057)
				local var_241_19 = arg_238_1:FormatText(var_241_18.content)

				arg_238_1.text_.text = var_241_19

				LuaForUtil.ClearLinePrefixSymbol(arg_238_1.text_)

				local var_241_20 = 27
				local var_241_21 = utf8.len(var_241_19)
				local var_241_22 = var_241_20 <= 0 and var_241_16 or var_241_16 * (var_241_21 / var_241_20)

				if var_241_22 > 0 and var_241_16 < var_241_22 then
					arg_238_1.talkMaxDuration = var_241_22

					if var_241_22 + var_241_15 > arg_238_1.duration_ then
						arg_238_1.duration_ = var_241_22 + var_241_15
					end
				end

				arg_238_1.text_.text = var_241_19
				arg_238_1.typewritter.percent = 0

				arg_238_1.typewritter:SetDirty()
				arg_238_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_319501", "319501057", "story_v_out_319501.awb") ~= 0 then
					local var_241_23 = manager.audio:GetVoiceLength("story_v_out_319501", "319501057", "story_v_out_319501.awb") / 1000

					if var_241_23 + var_241_15 > arg_238_1.duration_ then
						arg_238_1.duration_ = var_241_23 + var_241_15
					end

					if var_241_18.prefab_name ~= "" and arg_238_1.actors_[var_241_18.prefab_name] ~= nil then
						local var_241_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_238_1.actors_[var_241_18.prefab_name].transform, "story_v_out_319501", "319501057", "story_v_out_319501.awb")

						arg_238_1:RecordAudio("319501057", var_241_24)
						arg_238_1:RecordAudio("319501057", var_241_24)
					else
						arg_238_1:AudioAction("play", "voice", "story_v_out_319501", "319501057", "story_v_out_319501.awb")
					end

					arg_238_1:RecordHistoryTalkVoice("story_v_out_319501", "319501057", "story_v_out_319501.awb")
				end

				arg_238_1:RecordContent(arg_238_1.text_.text)
			end

			local var_241_25 = math.max(var_241_16, arg_238_1.talkMaxDuration)

			if var_241_15 <= arg_238_1.time_ and arg_238_1.time_ < var_241_15 + var_241_25 then
				arg_238_1.typewritter.percent = (arg_238_1.time_ - var_241_15) / var_241_25

				arg_238_1.typewritter:SetDirty()
			end

			if arg_238_1.time_ >= var_241_15 + var_241_25 and arg_238_1.time_ < var_241_15 + var_241_25 + arg_241_0 then
				arg_238_1.typewritter.percent = 1

				arg_238_1.typewritter:SetDirty()
				arg_238_1:ShowNextGo(true)
			end
		end

		arg_238_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1084ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_238_1:InitPlayNodeList()
	end,
	Play319501058 = function(arg_242_0, arg_242_1)
		arg_242_1.time_ = 0
		arg_242_1.frameCnt_ = 0
		arg_242_1.state_ = "playing"
		arg_242_1.curTalkId_ = 319501058
		arg_242_1.duration_ = 4.77

		local var_242_0 = {
			zh = 1.866,
			ja = 4.766
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
				arg_242_0:Play319501059(arg_242_1)
			end
		end

		function arg_242_1.onSingleLineUpdate_(arg_245_0)
			local var_245_0 = 0
			local var_245_1 = 0.225

			if var_245_0 < arg_242_1.time_ and arg_242_1.time_ <= var_245_0 + arg_245_0 then
				arg_242_1.talkMaxDuration = 0
				arg_242_1.dialogCg_.alpha = 1

				arg_242_1.dialog_:SetActive(true)
				SetActive(arg_242_1.leftNameGo_, true)

				local var_245_2 = arg_242_1:FormatText(StoryNameCfg[6].name)

				arg_242_1.leftNameTxt_.text = var_245_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_242_1.leftNameTxt_.transform)

				arg_242_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_242_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_242_1:RecordName(arg_242_1.leftNameTxt_.text)
				SetActive(arg_242_1.iconTrs_.gameObject, false)
				arg_242_1.callingController_:SetSelectedState("normal")

				local var_245_3 = arg_242_1:GetWordFromCfg(319501058)
				local var_245_4 = arg_242_1:FormatText(var_245_3.content)

				arg_242_1.text_.text = var_245_4

				LuaForUtil.ClearLinePrefixSymbol(arg_242_1.text_)

				local var_245_5 = 9
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

				if manager.audio:GetVoiceLength("story_v_out_319501", "319501058", "story_v_out_319501.awb") ~= 0 then
					local var_245_8 = manager.audio:GetVoiceLength("story_v_out_319501", "319501058", "story_v_out_319501.awb") / 1000

					if var_245_8 + var_245_0 > arg_242_1.duration_ then
						arg_242_1.duration_ = var_245_8 + var_245_0
					end

					if var_245_3.prefab_name ~= "" and arg_242_1.actors_[var_245_3.prefab_name] ~= nil then
						local var_245_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_242_1.actors_[var_245_3.prefab_name].transform, "story_v_out_319501", "319501058", "story_v_out_319501.awb")

						arg_242_1:RecordAudio("319501058", var_245_9)
						arg_242_1:RecordAudio("319501058", var_245_9)
					else
						arg_242_1:AudioAction("play", "voice", "story_v_out_319501", "319501058", "story_v_out_319501.awb")
					end

					arg_242_1:RecordHistoryTalkVoice("story_v_out_319501", "319501058", "story_v_out_319501.awb")
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
	Play319501059 = function(arg_246_0, arg_246_1)
		arg_246_1.time_ = 0
		arg_246_1.frameCnt_ = 0
		arg_246_1.state_ = "playing"
		arg_246_1.curTalkId_ = 319501059
		arg_246_1.duration_ = 5

		SetActive(arg_246_1.tipsGo_, false)

		function arg_246_1.onSingleLineFinish_()
			arg_246_1.onSingleLineUpdate_ = nil
			arg_246_1.onSingleLineFinish_ = nil
			arg_246_1.state_ = "waiting"
		end

		function arg_246_1.playNext_(arg_248_0)
			if arg_248_0 == 1 then
				arg_246_0:Play319501060(arg_246_1)
			end
		end

		function arg_246_1.onSingleLineUpdate_(arg_249_0)
			local var_249_0 = arg_246_1.actors_["1084ui_story"]
			local var_249_1 = 0

			if var_249_1 < arg_246_1.time_ and arg_246_1.time_ <= var_249_1 + arg_249_0 and not isNil(var_249_0) and arg_246_1.var_.characterEffect1084ui_story == nil then
				arg_246_1.var_.characterEffect1084ui_story = var_249_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_249_2 = 0.200000002980232

			if var_249_1 <= arg_246_1.time_ and arg_246_1.time_ < var_249_1 + var_249_2 and not isNil(var_249_0) then
				local var_249_3 = (arg_246_1.time_ - var_249_1) / var_249_2

				if arg_246_1.var_.characterEffect1084ui_story and not isNil(var_249_0) then
					local var_249_4 = Mathf.Lerp(0, 0.5, var_249_3)

					arg_246_1.var_.characterEffect1084ui_story.fillFlat = true
					arg_246_1.var_.characterEffect1084ui_story.fillRatio = var_249_4
				end
			end

			if arg_246_1.time_ >= var_249_1 + var_249_2 and arg_246_1.time_ < var_249_1 + var_249_2 + arg_249_0 and not isNil(var_249_0) and arg_246_1.var_.characterEffect1084ui_story then
				local var_249_5 = 0.5

				arg_246_1.var_.characterEffect1084ui_story.fillFlat = true
				arg_246_1.var_.characterEffect1084ui_story.fillRatio = var_249_5
			end

			local var_249_6 = 0
			local var_249_7 = 1.1

			if var_249_6 < arg_246_1.time_ and arg_246_1.time_ <= var_249_6 + arg_249_0 then
				arg_246_1.talkMaxDuration = 0
				arg_246_1.dialogCg_.alpha = 1

				arg_246_1.dialog_:SetActive(true)
				SetActive(arg_246_1.leftNameGo_, false)

				arg_246_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_246_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_246_1:RecordName(arg_246_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_246_1.iconTrs_.gameObject, false)
				arg_246_1.callingController_:SetSelectedState("normal")

				local var_249_8 = arg_246_1:GetWordFromCfg(319501059)
				local var_249_9 = arg_246_1:FormatText(var_249_8.content)

				arg_246_1.text_.text = var_249_9

				LuaForUtil.ClearLinePrefixSymbol(arg_246_1.text_)

				local var_249_10 = 51
				local var_249_11 = utf8.len(var_249_9)
				local var_249_12 = var_249_10 <= 0 and var_249_7 or var_249_7 * (var_249_11 / var_249_10)

				if var_249_12 > 0 and var_249_7 < var_249_12 then
					arg_246_1.talkMaxDuration = var_249_12

					if var_249_12 + var_249_6 > arg_246_1.duration_ then
						arg_246_1.duration_ = var_249_12 + var_249_6
					end
				end

				arg_246_1.text_.text = var_249_9
				arg_246_1.typewritter.percent = 0

				arg_246_1.typewritter:SetDirty()
				arg_246_1:ShowNextGo(false)
				arg_246_1:RecordContent(arg_246_1.text_.text)
			end

			local var_249_13 = math.max(var_249_7, arg_246_1.talkMaxDuration)

			if var_249_6 <= arg_246_1.time_ and arg_246_1.time_ < var_249_6 + var_249_13 then
				arg_246_1.typewritter.percent = (arg_246_1.time_ - var_249_6) / var_249_13

				arg_246_1.typewritter:SetDirty()
			end

			if arg_246_1.time_ >= var_249_6 + var_249_13 and arg_246_1.time_ < var_249_6 + var_249_13 + arg_249_0 then
				arg_246_1.typewritter.percent = 1

				arg_246_1.typewritter:SetDirty()
				arg_246_1:ShowNextGo(true)
			end
		end

		arg_246_1.nodeConfigList_ = {}

		arg_246_1:InitPlayNodeList()
	end,
	Play319501060 = function(arg_250_0, arg_250_1)
		arg_250_1.time_ = 0
		arg_250_1.frameCnt_ = 0
		arg_250_1.state_ = "playing"
		arg_250_1.curTalkId_ = 319501060
		arg_250_1.duration_ = 5

		SetActive(arg_250_1.tipsGo_, false)

		function arg_250_1.onSingleLineFinish_()
			arg_250_1.onSingleLineUpdate_ = nil
			arg_250_1.onSingleLineFinish_ = nil
			arg_250_1.state_ = "waiting"
		end

		function arg_250_1.playNext_(arg_252_0)
			if arg_252_0 == 1 then
				arg_250_0:Play319501061(arg_250_1)
			end
		end

		function arg_250_1.onSingleLineUpdate_(arg_253_0)
			local var_253_0 = 0
			local var_253_1 = 0.775

			if var_253_0 < arg_250_1.time_ and arg_250_1.time_ <= var_253_0 + arg_253_0 then
				arg_250_1.talkMaxDuration = 0
				arg_250_1.dialogCg_.alpha = 1

				arg_250_1.dialog_:SetActive(true)
				SetActive(arg_250_1.leftNameGo_, false)

				arg_250_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_250_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_250_1:RecordName(arg_250_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_250_1.iconTrs_.gameObject, false)
				arg_250_1.callingController_:SetSelectedState("normal")

				local var_253_2 = arg_250_1:GetWordFromCfg(319501060)
				local var_253_3 = arg_250_1:FormatText(var_253_2.content)

				arg_250_1.text_.text = var_253_3

				LuaForUtil.ClearLinePrefixSymbol(arg_250_1.text_)

				local var_253_4 = 31
				local var_253_5 = utf8.len(var_253_3)
				local var_253_6 = var_253_4 <= 0 and var_253_1 or var_253_1 * (var_253_5 / var_253_4)

				if var_253_6 > 0 and var_253_1 < var_253_6 then
					arg_250_1.talkMaxDuration = var_253_6

					if var_253_6 + var_253_0 > arg_250_1.duration_ then
						arg_250_1.duration_ = var_253_6 + var_253_0
					end
				end

				arg_250_1.text_.text = var_253_3
				arg_250_1.typewritter.percent = 0

				arg_250_1.typewritter:SetDirty()
				arg_250_1:ShowNextGo(false)
				arg_250_1:RecordContent(arg_250_1.text_.text)
			end

			local var_253_7 = math.max(var_253_1, arg_250_1.talkMaxDuration)

			if var_253_0 <= arg_250_1.time_ and arg_250_1.time_ < var_253_0 + var_253_7 then
				arg_250_1.typewritter.percent = (arg_250_1.time_ - var_253_0) / var_253_7

				arg_250_1.typewritter:SetDirty()
			end

			if arg_250_1.time_ >= var_253_0 + var_253_7 and arg_250_1.time_ < var_253_0 + var_253_7 + arg_253_0 then
				arg_250_1.typewritter.percent = 1

				arg_250_1.typewritter:SetDirty()
				arg_250_1:ShowNextGo(true)
			end
		end

		arg_250_1.nodeConfigList_ = {}

		arg_250_1:InitPlayNodeList()
	end,
	Play319501061 = function(arg_254_0, arg_254_1)
		arg_254_1.time_ = 0
		arg_254_1.frameCnt_ = 0
		arg_254_1.state_ = "playing"
		arg_254_1.curTalkId_ = 319501061
		arg_254_1.duration_ = 2.5

		SetActive(arg_254_1.tipsGo_, false)

		function arg_254_1.onSingleLineFinish_()
			arg_254_1.onSingleLineUpdate_ = nil
			arg_254_1.onSingleLineFinish_ = nil
			arg_254_1.state_ = "waiting"
		end

		function arg_254_1.playNext_(arg_256_0)
			if arg_256_0 == 1 then
				arg_254_0:Play319501062(arg_254_1)
			end
		end

		function arg_254_1.onSingleLineUpdate_(arg_257_0)
			local var_257_0 = arg_254_1.actors_["10068ui_story"]
			local var_257_1 = 0

			if var_257_1 < arg_254_1.time_ and arg_254_1.time_ <= var_257_1 + arg_257_0 and not isNil(var_257_0) and arg_254_1.var_.characterEffect10068ui_story == nil then
				arg_254_1.var_.characterEffect10068ui_story = var_257_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_257_2 = 0.200000002980232

			if var_257_1 <= arg_254_1.time_ and arg_254_1.time_ < var_257_1 + var_257_2 and not isNil(var_257_0) then
				local var_257_3 = (arg_254_1.time_ - var_257_1) / var_257_2

				if arg_254_1.var_.characterEffect10068ui_story and not isNil(var_257_0) then
					arg_254_1.var_.characterEffect10068ui_story.fillFlat = false
				end
			end

			if arg_254_1.time_ >= var_257_1 + var_257_2 and arg_254_1.time_ < var_257_1 + var_257_2 + arg_257_0 and not isNil(var_257_0) and arg_254_1.var_.characterEffect10068ui_story then
				arg_254_1.var_.characterEffect10068ui_story.fillFlat = false
			end

			local var_257_4 = 0

			if var_257_4 < arg_254_1.time_ and arg_254_1.time_ <= var_257_4 + arg_257_0 then
				arg_254_1:PlayTimeline("10068ui_story", "StoryTimeline/CharAction/story10068/story10068action/10068action2_2")
			end

			local var_257_5 = 0

			if var_257_5 < arg_254_1.time_ and arg_254_1.time_ <= var_257_5 + arg_257_0 then
				arg_254_1:PlayTimeline("10068ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface2101cva")
			end

			local var_257_6 = 0
			local var_257_7 = 0.125

			if var_257_6 < arg_254_1.time_ and arg_254_1.time_ <= var_257_6 + arg_257_0 then
				arg_254_1.talkMaxDuration = 0
				arg_254_1.dialogCg_.alpha = 1

				arg_254_1.dialog_:SetActive(true)
				SetActive(arg_254_1.leftNameGo_, true)

				local var_257_8 = arg_254_1:FormatText(StoryNameCfg[697].name)

				arg_254_1.leftNameTxt_.text = var_257_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_254_1.leftNameTxt_.transform)

				arg_254_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_254_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_254_1:RecordName(arg_254_1.leftNameTxt_.text)
				SetActive(arg_254_1.iconTrs_.gameObject, false)
				arg_254_1.callingController_:SetSelectedState("normal")

				local var_257_9 = arg_254_1:GetWordFromCfg(319501061)
				local var_257_10 = arg_254_1:FormatText(var_257_9.content)

				arg_254_1.text_.text = var_257_10

				LuaForUtil.ClearLinePrefixSymbol(arg_254_1.text_)

				local var_257_11 = 5
				local var_257_12 = utf8.len(var_257_10)
				local var_257_13 = var_257_11 <= 0 and var_257_7 or var_257_7 * (var_257_12 / var_257_11)

				if var_257_13 > 0 and var_257_7 < var_257_13 then
					arg_254_1.talkMaxDuration = var_257_13

					if var_257_13 + var_257_6 > arg_254_1.duration_ then
						arg_254_1.duration_ = var_257_13 + var_257_6
					end
				end

				arg_254_1.text_.text = var_257_10
				arg_254_1.typewritter.percent = 0

				arg_254_1.typewritter:SetDirty()
				arg_254_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_319501", "319501061", "story_v_out_319501.awb") ~= 0 then
					local var_257_14 = manager.audio:GetVoiceLength("story_v_out_319501", "319501061", "story_v_out_319501.awb") / 1000

					if var_257_14 + var_257_6 > arg_254_1.duration_ then
						arg_254_1.duration_ = var_257_14 + var_257_6
					end

					if var_257_9.prefab_name ~= "" and arg_254_1.actors_[var_257_9.prefab_name] ~= nil then
						local var_257_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_254_1.actors_[var_257_9.prefab_name].transform, "story_v_out_319501", "319501061", "story_v_out_319501.awb")

						arg_254_1:RecordAudio("319501061", var_257_15)
						arg_254_1:RecordAudio("319501061", var_257_15)
					else
						arg_254_1:AudioAction("play", "voice", "story_v_out_319501", "319501061", "story_v_out_319501.awb")
					end

					arg_254_1:RecordHistoryTalkVoice("story_v_out_319501", "319501061", "story_v_out_319501.awb")
				end

				arg_254_1:RecordContent(arg_254_1.text_.text)
			end

			local var_257_16 = math.max(var_257_7, arg_254_1.talkMaxDuration)

			if var_257_6 <= arg_254_1.time_ and arg_254_1.time_ < var_257_6 + var_257_16 then
				arg_254_1.typewritter.percent = (arg_254_1.time_ - var_257_6) / var_257_16

				arg_254_1.typewritter:SetDirty()
			end

			if arg_254_1.time_ >= var_257_6 + var_257_16 and arg_254_1.time_ < var_257_6 + var_257_16 + arg_257_0 then
				arg_254_1.typewritter.percent = 1

				arg_254_1.typewritter:SetDirty()
				arg_254_1:ShowNextGo(true)
			end
		end

		arg_254_1.nodeConfigList_ = {}

		arg_254_1:InitPlayNodeList()
	end,
	Play319501062 = function(arg_258_0, arg_258_1)
		arg_258_1.time_ = 0
		arg_258_1.frameCnt_ = 0
		arg_258_1.state_ = "playing"
		arg_258_1.curTalkId_ = 319501062
		arg_258_1.duration_ = 5.93

		local var_258_0 = {
			zh = 3.4,
			ja = 5.933
		}
		local var_258_1 = manager.audio:GetLocalizationFlag()

		if var_258_0[var_258_1] ~= nil then
			arg_258_1.duration_ = var_258_0[var_258_1]
		end

		SetActive(arg_258_1.tipsGo_, false)

		function arg_258_1.onSingleLineFinish_()
			arg_258_1.onSingleLineUpdate_ = nil
			arg_258_1.onSingleLineFinish_ = nil
			arg_258_1.state_ = "waiting"
		end

		function arg_258_1.playNext_(arg_260_0)
			if arg_260_0 == 1 then
				arg_258_0:Play319501063(arg_258_1)
			end
		end

		function arg_258_1.onSingleLineUpdate_(arg_261_0)
			local var_261_0 = arg_258_1.actors_["10068ui_story"]
			local var_261_1 = 0

			if var_261_1 < arg_258_1.time_ and arg_258_1.time_ <= var_261_1 + arg_261_0 and not isNil(var_261_0) and arg_258_1.var_.characterEffect10068ui_story == nil then
				arg_258_1.var_.characterEffect10068ui_story = var_261_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_261_2 = 0.200000002980232

			if var_261_1 <= arg_258_1.time_ and arg_258_1.time_ < var_261_1 + var_261_2 and not isNil(var_261_0) then
				local var_261_3 = (arg_258_1.time_ - var_261_1) / var_261_2

				if arg_258_1.var_.characterEffect10068ui_story and not isNil(var_261_0) then
					local var_261_4 = Mathf.Lerp(0, 0.5, var_261_3)

					arg_258_1.var_.characterEffect10068ui_story.fillFlat = true
					arg_258_1.var_.characterEffect10068ui_story.fillRatio = var_261_4
				end
			end

			if arg_258_1.time_ >= var_261_1 + var_261_2 and arg_258_1.time_ < var_261_1 + var_261_2 + arg_261_0 and not isNil(var_261_0) and arg_258_1.var_.characterEffect10068ui_story then
				local var_261_5 = 0.5

				arg_258_1.var_.characterEffect10068ui_story.fillFlat = true
				arg_258_1.var_.characterEffect10068ui_story.fillRatio = var_261_5
			end

			local var_261_6 = arg_258_1.actors_["1084ui_story"]
			local var_261_7 = 0

			if var_261_7 < arg_258_1.time_ and arg_258_1.time_ <= var_261_7 + arg_261_0 and not isNil(var_261_6) and arg_258_1.var_.characterEffect1084ui_story == nil then
				arg_258_1.var_.characterEffect1084ui_story = var_261_6:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_261_8 = 0.200000002980232

			if var_261_7 <= arg_258_1.time_ and arg_258_1.time_ < var_261_7 + var_261_8 and not isNil(var_261_6) then
				local var_261_9 = (arg_258_1.time_ - var_261_7) / var_261_8

				if arg_258_1.var_.characterEffect1084ui_story and not isNil(var_261_6) then
					arg_258_1.var_.characterEffect1084ui_story.fillFlat = false
				end
			end

			if arg_258_1.time_ >= var_261_7 + var_261_8 and arg_258_1.time_ < var_261_7 + var_261_8 + arg_261_0 and not isNil(var_261_6) and arg_258_1.var_.characterEffect1084ui_story then
				arg_258_1.var_.characterEffect1084ui_story.fillFlat = false
			end

			local var_261_10 = 0
			local var_261_11 = 0.35

			if var_261_10 < arg_258_1.time_ and arg_258_1.time_ <= var_261_10 + arg_261_0 then
				arg_258_1.talkMaxDuration = 0
				arg_258_1.dialogCg_.alpha = 1

				arg_258_1.dialog_:SetActive(true)
				SetActive(arg_258_1.leftNameGo_, true)

				local var_261_12 = arg_258_1:FormatText(StoryNameCfg[6].name)

				arg_258_1.leftNameTxt_.text = var_261_12

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_258_1.leftNameTxt_.transform)

				arg_258_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_258_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_258_1:RecordName(arg_258_1.leftNameTxt_.text)
				SetActive(arg_258_1.iconTrs_.gameObject, false)
				arg_258_1.callingController_:SetSelectedState("normal")

				local var_261_13 = arg_258_1:GetWordFromCfg(319501062)
				local var_261_14 = arg_258_1:FormatText(var_261_13.content)

				arg_258_1.text_.text = var_261_14

				LuaForUtil.ClearLinePrefixSymbol(arg_258_1.text_)

				local var_261_15 = 14
				local var_261_16 = utf8.len(var_261_14)
				local var_261_17 = var_261_15 <= 0 and var_261_11 or var_261_11 * (var_261_16 / var_261_15)

				if var_261_17 > 0 and var_261_11 < var_261_17 then
					arg_258_1.talkMaxDuration = var_261_17

					if var_261_17 + var_261_10 > arg_258_1.duration_ then
						arg_258_1.duration_ = var_261_17 + var_261_10
					end
				end

				arg_258_1.text_.text = var_261_14
				arg_258_1.typewritter.percent = 0

				arg_258_1.typewritter:SetDirty()
				arg_258_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_319501", "319501062", "story_v_out_319501.awb") ~= 0 then
					local var_261_18 = manager.audio:GetVoiceLength("story_v_out_319501", "319501062", "story_v_out_319501.awb") / 1000

					if var_261_18 + var_261_10 > arg_258_1.duration_ then
						arg_258_1.duration_ = var_261_18 + var_261_10
					end

					if var_261_13.prefab_name ~= "" and arg_258_1.actors_[var_261_13.prefab_name] ~= nil then
						local var_261_19 = LuaForUtil.PlayVoiceWithCriLipsync(arg_258_1.actors_[var_261_13.prefab_name].transform, "story_v_out_319501", "319501062", "story_v_out_319501.awb")

						arg_258_1:RecordAudio("319501062", var_261_19)
						arg_258_1:RecordAudio("319501062", var_261_19)
					else
						arg_258_1:AudioAction("play", "voice", "story_v_out_319501", "319501062", "story_v_out_319501.awb")
					end

					arg_258_1:RecordHistoryTalkVoice("story_v_out_319501", "319501062", "story_v_out_319501.awb")
				end

				arg_258_1:RecordContent(arg_258_1.text_.text)
			end

			local var_261_20 = math.max(var_261_11, arg_258_1.talkMaxDuration)

			if var_261_10 <= arg_258_1.time_ and arg_258_1.time_ < var_261_10 + var_261_20 then
				arg_258_1.typewritter.percent = (arg_258_1.time_ - var_261_10) / var_261_20

				arg_258_1.typewritter:SetDirty()
			end

			if arg_258_1.time_ >= var_261_10 + var_261_20 and arg_258_1.time_ < var_261_10 + var_261_20 + arg_261_0 then
				arg_258_1.typewritter.percent = 1

				arg_258_1.typewritter:SetDirty()
				arg_258_1:ShowNextGo(true)
			end
		end

		arg_258_1.nodeConfigList_ = {}

		arg_258_1:InitPlayNodeList()
	end,
	Play319501063 = function(arg_262_0, arg_262_1)
		arg_262_1.time_ = 0
		arg_262_1.frameCnt_ = 0
		arg_262_1.state_ = "playing"
		arg_262_1.curTalkId_ = 319501063
		arg_262_1.duration_ = 4.1

		local var_262_0 = {
			zh = 2.8,
			ja = 4.1
		}
		local var_262_1 = manager.audio:GetLocalizationFlag()

		if var_262_0[var_262_1] ~= nil then
			arg_262_1.duration_ = var_262_0[var_262_1]
		end

		SetActive(arg_262_1.tipsGo_, false)

		function arg_262_1.onSingleLineFinish_()
			arg_262_1.onSingleLineUpdate_ = nil
			arg_262_1.onSingleLineFinish_ = nil
			arg_262_1.state_ = "waiting"
		end

		function arg_262_1.playNext_(arg_264_0)
			if arg_264_0 == 1 then
				arg_262_0:Play319501064(arg_262_1)
			end
		end

		function arg_262_1.onSingleLineUpdate_(arg_265_0)
			local var_265_0 = arg_262_1.actors_["10068ui_story"]
			local var_265_1 = 0

			if var_265_1 < arg_262_1.time_ and arg_262_1.time_ <= var_265_1 + arg_265_0 and not isNil(var_265_0) and arg_262_1.var_.characterEffect10068ui_story == nil then
				arg_262_1.var_.characterEffect10068ui_story = var_265_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_265_2 = 0.200000002980232

			if var_265_1 <= arg_262_1.time_ and arg_262_1.time_ < var_265_1 + var_265_2 and not isNil(var_265_0) then
				local var_265_3 = (arg_262_1.time_ - var_265_1) / var_265_2

				if arg_262_1.var_.characterEffect10068ui_story and not isNil(var_265_0) then
					arg_262_1.var_.characterEffect10068ui_story.fillFlat = false
				end
			end

			if arg_262_1.time_ >= var_265_1 + var_265_2 and arg_262_1.time_ < var_265_1 + var_265_2 + arg_265_0 and not isNil(var_265_0) and arg_262_1.var_.characterEffect10068ui_story then
				arg_262_1.var_.characterEffect10068ui_story.fillFlat = false
			end

			local var_265_4 = arg_262_1.actors_["1084ui_story"]
			local var_265_5 = 0

			if var_265_5 < arg_262_1.time_ and arg_262_1.time_ <= var_265_5 + arg_265_0 and not isNil(var_265_4) and arg_262_1.var_.characterEffect1084ui_story == nil then
				arg_262_1.var_.characterEffect1084ui_story = var_265_4:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_265_6 = 0.200000002980232

			if var_265_5 <= arg_262_1.time_ and arg_262_1.time_ < var_265_5 + var_265_6 and not isNil(var_265_4) then
				local var_265_7 = (arg_262_1.time_ - var_265_5) / var_265_6

				if arg_262_1.var_.characterEffect1084ui_story and not isNil(var_265_4) then
					local var_265_8 = Mathf.Lerp(0, 0.5, var_265_7)

					arg_262_1.var_.characterEffect1084ui_story.fillFlat = true
					arg_262_1.var_.characterEffect1084ui_story.fillRatio = var_265_8
				end
			end

			if arg_262_1.time_ >= var_265_5 + var_265_6 and arg_262_1.time_ < var_265_5 + var_265_6 + arg_265_0 and not isNil(var_265_4) and arg_262_1.var_.characterEffect1084ui_story then
				local var_265_9 = 0.5

				arg_262_1.var_.characterEffect1084ui_story.fillFlat = true
				arg_262_1.var_.characterEffect1084ui_story.fillRatio = var_265_9
			end

			local var_265_10 = 0
			local var_265_11 = 0.2

			if var_265_10 < arg_262_1.time_ and arg_262_1.time_ <= var_265_10 + arg_265_0 then
				arg_262_1.talkMaxDuration = 0
				arg_262_1.dialogCg_.alpha = 1

				arg_262_1.dialog_:SetActive(true)
				SetActive(arg_262_1.leftNameGo_, true)

				local var_265_12 = arg_262_1:FormatText(StoryNameCfg[697].name)

				arg_262_1.leftNameTxt_.text = var_265_12

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_262_1.leftNameTxt_.transform)

				arg_262_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_262_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_262_1:RecordName(arg_262_1.leftNameTxt_.text)
				SetActive(arg_262_1.iconTrs_.gameObject, false)
				arg_262_1.callingController_:SetSelectedState("normal")

				local var_265_13 = arg_262_1:GetWordFromCfg(319501063)
				local var_265_14 = arg_262_1:FormatText(var_265_13.content)

				arg_262_1.text_.text = var_265_14

				LuaForUtil.ClearLinePrefixSymbol(arg_262_1.text_)

				local var_265_15 = 8
				local var_265_16 = utf8.len(var_265_14)
				local var_265_17 = var_265_15 <= 0 and var_265_11 or var_265_11 * (var_265_16 / var_265_15)

				if var_265_17 > 0 and var_265_11 < var_265_17 then
					arg_262_1.talkMaxDuration = var_265_17

					if var_265_17 + var_265_10 > arg_262_1.duration_ then
						arg_262_1.duration_ = var_265_17 + var_265_10
					end
				end

				arg_262_1.text_.text = var_265_14
				arg_262_1.typewritter.percent = 0

				arg_262_1.typewritter:SetDirty()
				arg_262_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_319501", "319501063", "story_v_out_319501.awb") ~= 0 then
					local var_265_18 = manager.audio:GetVoiceLength("story_v_out_319501", "319501063", "story_v_out_319501.awb") / 1000

					if var_265_18 + var_265_10 > arg_262_1.duration_ then
						arg_262_1.duration_ = var_265_18 + var_265_10
					end

					if var_265_13.prefab_name ~= "" and arg_262_1.actors_[var_265_13.prefab_name] ~= nil then
						local var_265_19 = LuaForUtil.PlayVoiceWithCriLipsync(arg_262_1.actors_[var_265_13.prefab_name].transform, "story_v_out_319501", "319501063", "story_v_out_319501.awb")

						arg_262_1:RecordAudio("319501063", var_265_19)
						arg_262_1:RecordAudio("319501063", var_265_19)
					else
						arg_262_1:AudioAction("play", "voice", "story_v_out_319501", "319501063", "story_v_out_319501.awb")
					end

					arg_262_1:RecordHistoryTalkVoice("story_v_out_319501", "319501063", "story_v_out_319501.awb")
				end

				arg_262_1:RecordContent(arg_262_1.text_.text)
			end

			local var_265_20 = math.max(var_265_11, arg_262_1.talkMaxDuration)

			if var_265_10 <= arg_262_1.time_ and arg_262_1.time_ < var_265_10 + var_265_20 then
				arg_262_1.typewritter.percent = (arg_262_1.time_ - var_265_10) / var_265_20

				arg_262_1.typewritter:SetDirty()
			end

			if arg_262_1.time_ >= var_265_10 + var_265_20 and arg_262_1.time_ < var_265_10 + var_265_20 + arg_265_0 then
				arg_262_1.typewritter.percent = 1

				arg_262_1.typewritter:SetDirty()
				arg_262_1:ShowNextGo(true)
			end
		end

		arg_262_1.nodeConfigList_ = {}

		arg_262_1:InitPlayNodeList()
	end,
	Play319501064 = function(arg_266_0, arg_266_1)
		arg_266_1.time_ = 0
		arg_266_1.frameCnt_ = 0
		arg_266_1.state_ = "playing"
		arg_266_1.curTalkId_ = 319501064
		arg_266_1.duration_ = 14.67

		local var_266_0 = {
			zh = 8.266,
			ja = 14.666
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
				arg_266_0:Play319501065(arg_266_1)
			end
		end

		function arg_266_1.onSingleLineUpdate_(arg_269_0)
			local var_269_0 = arg_266_1.actors_["10068ui_story"]
			local var_269_1 = 0

			if var_269_1 < arg_266_1.time_ and arg_266_1.time_ <= var_269_1 + arg_269_0 and not isNil(var_269_0) and arg_266_1.var_.characterEffect10068ui_story == nil then
				arg_266_1.var_.characterEffect10068ui_story = var_269_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_269_2 = 0.200000002980232

			if var_269_1 <= arg_266_1.time_ and arg_266_1.time_ < var_269_1 + var_269_2 and not isNil(var_269_0) then
				local var_269_3 = (arg_266_1.time_ - var_269_1) / var_269_2

				if arg_266_1.var_.characterEffect10068ui_story and not isNil(var_269_0) then
					local var_269_4 = Mathf.Lerp(0, 0.5, var_269_3)

					arg_266_1.var_.characterEffect10068ui_story.fillFlat = true
					arg_266_1.var_.characterEffect10068ui_story.fillRatio = var_269_4
				end
			end

			if arg_266_1.time_ >= var_269_1 + var_269_2 and arg_266_1.time_ < var_269_1 + var_269_2 + arg_269_0 and not isNil(var_269_0) and arg_266_1.var_.characterEffect10068ui_story then
				local var_269_5 = 0.5

				arg_266_1.var_.characterEffect10068ui_story.fillFlat = true
				arg_266_1.var_.characterEffect10068ui_story.fillRatio = var_269_5
			end

			local var_269_6 = arg_266_1.actors_["1084ui_story"]
			local var_269_7 = 0

			if var_269_7 < arg_266_1.time_ and arg_266_1.time_ <= var_269_7 + arg_269_0 and not isNil(var_269_6) and arg_266_1.var_.characterEffect1084ui_story == nil then
				arg_266_1.var_.characterEffect1084ui_story = var_269_6:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_269_8 = 0.200000002980232

			if var_269_7 <= arg_266_1.time_ and arg_266_1.time_ < var_269_7 + var_269_8 and not isNil(var_269_6) then
				local var_269_9 = (arg_266_1.time_ - var_269_7) / var_269_8

				if arg_266_1.var_.characterEffect1084ui_story and not isNil(var_269_6) then
					arg_266_1.var_.characterEffect1084ui_story.fillFlat = false
				end
			end

			if arg_266_1.time_ >= var_269_7 + var_269_8 and arg_266_1.time_ < var_269_7 + var_269_8 + arg_269_0 and not isNil(var_269_6) and arg_266_1.var_.characterEffect1084ui_story then
				arg_266_1.var_.characterEffect1084ui_story.fillFlat = false
			end

			local var_269_10 = 0
			local var_269_11 = 1.025

			if var_269_10 < arg_266_1.time_ and arg_266_1.time_ <= var_269_10 + arg_269_0 then
				arg_266_1.talkMaxDuration = 0
				arg_266_1.dialogCg_.alpha = 1

				arg_266_1.dialog_:SetActive(true)
				SetActive(arg_266_1.leftNameGo_, true)

				local var_269_12 = arg_266_1:FormatText(StoryNameCfg[6].name)

				arg_266_1.leftNameTxt_.text = var_269_12

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_266_1.leftNameTxt_.transform)

				arg_266_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_266_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_266_1:RecordName(arg_266_1.leftNameTxt_.text)
				SetActive(arg_266_1.iconTrs_.gameObject, false)
				arg_266_1.callingController_:SetSelectedState("normal")

				local var_269_13 = arg_266_1:GetWordFromCfg(319501064)
				local var_269_14 = arg_266_1:FormatText(var_269_13.content)

				arg_266_1.text_.text = var_269_14

				LuaForUtil.ClearLinePrefixSymbol(arg_266_1.text_)

				local var_269_15 = 41
				local var_269_16 = utf8.len(var_269_14)
				local var_269_17 = var_269_15 <= 0 and var_269_11 or var_269_11 * (var_269_16 / var_269_15)

				if var_269_17 > 0 and var_269_11 < var_269_17 then
					arg_266_1.talkMaxDuration = var_269_17

					if var_269_17 + var_269_10 > arg_266_1.duration_ then
						arg_266_1.duration_ = var_269_17 + var_269_10
					end
				end

				arg_266_1.text_.text = var_269_14
				arg_266_1.typewritter.percent = 0

				arg_266_1.typewritter:SetDirty()
				arg_266_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_319501", "319501064", "story_v_out_319501.awb") ~= 0 then
					local var_269_18 = manager.audio:GetVoiceLength("story_v_out_319501", "319501064", "story_v_out_319501.awb") / 1000

					if var_269_18 + var_269_10 > arg_266_1.duration_ then
						arg_266_1.duration_ = var_269_18 + var_269_10
					end

					if var_269_13.prefab_name ~= "" and arg_266_1.actors_[var_269_13.prefab_name] ~= nil then
						local var_269_19 = LuaForUtil.PlayVoiceWithCriLipsync(arg_266_1.actors_[var_269_13.prefab_name].transform, "story_v_out_319501", "319501064", "story_v_out_319501.awb")

						arg_266_1:RecordAudio("319501064", var_269_19)
						arg_266_1:RecordAudio("319501064", var_269_19)
					else
						arg_266_1:AudioAction("play", "voice", "story_v_out_319501", "319501064", "story_v_out_319501.awb")
					end

					arg_266_1:RecordHistoryTalkVoice("story_v_out_319501", "319501064", "story_v_out_319501.awb")
				end

				arg_266_1:RecordContent(arg_266_1.text_.text)
			end

			local var_269_20 = math.max(var_269_11, arg_266_1.talkMaxDuration)

			if var_269_10 <= arg_266_1.time_ and arg_266_1.time_ < var_269_10 + var_269_20 then
				arg_266_1.typewritter.percent = (arg_266_1.time_ - var_269_10) / var_269_20

				arg_266_1.typewritter:SetDirty()
			end

			if arg_266_1.time_ >= var_269_10 + var_269_20 and arg_266_1.time_ < var_269_10 + var_269_20 + arg_269_0 then
				arg_266_1.typewritter.percent = 1

				arg_266_1.typewritter:SetDirty()
				arg_266_1:ShowNextGo(true)
			end
		end

		arg_266_1.nodeConfigList_ = {}

		arg_266_1:InitPlayNodeList()
	end,
	Play319501065 = function(arg_270_0, arg_270_1)
		arg_270_1.time_ = 0
		arg_270_1.frameCnt_ = 0
		arg_270_1.state_ = "playing"
		arg_270_1.curTalkId_ = 319501065
		arg_270_1.duration_ = 5

		SetActive(arg_270_1.tipsGo_, false)

		function arg_270_1.onSingleLineFinish_()
			arg_270_1.onSingleLineUpdate_ = nil
			arg_270_1.onSingleLineFinish_ = nil
			arg_270_1.state_ = "waiting"
		end

		function arg_270_1.playNext_(arg_272_0)
			if arg_272_0 == 1 then
				arg_270_0:Play319501066(arg_270_1)
			end
		end

		function arg_270_1.onSingleLineUpdate_(arg_273_0)
			local var_273_0 = arg_270_1.actors_["1084ui_story"]
			local var_273_1 = 0

			if var_273_1 < arg_270_1.time_ and arg_270_1.time_ <= var_273_1 + arg_273_0 and not isNil(var_273_0) and arg_270_1.var_.characterEffect1084ui_story == nil then
				arg_270_1.var_.characterEffect1084ui_story = var_273_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_273_2 = 0.200000002980232

			if var_273_1 <= arg_270_1.time_ and arg_270_1.time_ < var_273_1 + var_273_2 and not isNil(var_273_0) then
				local var_273_3 = (arg_270_1.time_ - var_273_1) / var_273_2

				if arg_270_1.var_.characterEffect1084ui_story and not isNil(var_273_0) then
					local var_273_4 = Mathf.Lerp(0, 0.5, var_273_3)

					arg_270_1.var_.characterEffect1084ui_story.fillFlat = true
					arg_270_1.var_.characterEffect1084ui_story.fillRatio = var_273_4
				end
			end

			if arg_270_1.time_ >= var_273_1 + var_273_2 and arg_270_1.time_ < var_273_1 + var_273_2 + arg_273_0 and not isNil(var_273_0) and arg_270_1.var_.characterEffect1084ui_story then
				local var_273_5 = 0.5

				arg_270_1.var_.characterEffect1084ui_story.fillFlat = true
				arg_270_1.var_.characterEffect1084ui_story.fillRatio = var_273_5
			end

			local var_273_6 = 0
			local var_273_7 = 1.75

			if var_273_6 < arg_270_1.time_ and arg_270_1.time_ <= var_273_6 + arg_273_0 then
				arg_270_1.talkMaxDuration = 0
				arg_270_1.dialogCg_.alpha = 1

				arg_270_1.dialog_:SetActive(true)
				SetActive(arg_270_1.leftNameGo_, false)

				arg_270_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_270_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_270_1:RecordName(arg_270_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_270_1.iconTrs_.gameObject, false)
				arg_270_1.callingController_:SetSelectedState("normal")

				local var_273_8 = arg_270_1:GetWordFromCfg(319501065)
				local var_273_9 = arg_270_1:FormatText(var_273_8.content)

				arg_270_1.text_.text = var_273_9

				LuaForUtil.ClearLinePrefixSymbol(arg_270_1.text_)

				local var_273_10 = 69
				local var_273_11 = utf8.len(var_273_9)
				local var_273_12 = var_273_10 <= 0 and var_273_7 or var_273_7 * (var_273_11 / var_273_10)

				if var_273_12 > 0 and var_273_7 < var_273_12 then
					arg_270_1.talkMaxDuration = var_273_12

					if var_273_12 + var_273_6 > arg_270_1.duration_ then
						arg_270_1.duration_ = var_273_12 + var_273_6
					end
				end

				arg_270_1.text_.text = var_273_9
				arg_270_1.typewritter.percent = 0

				arg_270_1.typewritter:SetDirty()
				arg_270_1:ShowNextGo(false)
				arg_270_1:RecordContent(arg_270_1.text_.text)
			end

			local var_273_13 = math.max(var_273_7, arg_270_1.talkMaxDuration)

			if var_273_6 <= arg_270_1.time_ and arg_270_1.time_ < var_273_6 + var_273_13 then
				arg_270_1.typewritter.percent = (arg_270_1.time_ - var_273_6) / var_273_13

				arg_270_1.typewritter:SetDirty()
			end

			if arg_270_1.time_ >= var_273_6 + var_273_13 and arg_270_1.time_ < var_273_6 + var_273_13 + arg_273_0 then
				arg_270_1.typewritter.percent = 1

				arg_270_1.typewritter:SetDirty()
				arg_270_1:ShowNextGo(true)
			end
		end

		arg_270_1.nodeConfigList_ = {}

		arg_270_1:InitPlayNodeList()
	end,
	Play319501066 = function(arg_274_0, arg_274_1)
		arg_274_1.time_ = 0
		arg_274_1.frameCnt_ = 0
		arg_274_1.state_ = "playing"
		arg_274_1.curTalkId_ = 319501066
		arg_274_1.duration_ = 14.77

		local var_274_0 = {
			zh = 6.966,
			ja = 14.766
		}
		local var_274_1 = manager.audio:GetLocalizationFlag()

		if var_274_0[var_274_1] ~= nil then
			arg_274_1.duration_ = var_274_0[var_274_1]
		end

		SetActive(arg_274_1.tipsGo_, false)

		function arg_274_1.onSingleLineFinish_()
			arg_274_1.onSingleLineUpdate_ = nil
			arg_274_1.onSingleLineFinish_ = nil
			arg_274_1.state_ = "waiting"
		end

		function arg_274_1.playNext_(arg_276_0)
			if arg_276_0 == 1 then
				arg_274_0:Play319501067(arg_274_1)
			end
		end

		function arg_274_1.onSingleLineUpdate_(arg_277_0)
			local var_277_0 = arg_274_1.actors_["1084ui_story"]
			local var_277_1 = 0

			if var_277_1 < arg_274_1.time_ and arg_274_1.time_ <= var_277_1 + arg_277_0 and not isNil(var_277_0) and arg_274_1.var_.characterEffect1084ui_story == nil then
				arg_274_1.var_.characterEffect1084ui_story = var_277_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_277_2 = 0.200000002980232

			if var_277_1 <= arg_274_1.time_ and arg_274_1.time_ < var_277_1 + var_277_2 and not isNil(var_277_0) then
				local var_277_3 = (arg_274_1.time_ - var_277_1) / var_277_2

				if arg_274_1.var_.characterEffect1084ui_story and not isNil(var_277_0) then
					arg_274_1.var_.characterEffect1084ui_story.fillFlat = false
				end
			end

			if arg_274_1.time_ >= var_277_1 + var_277_2 and arg_274_1.time_ < var_277_1 + var_277_2 + arg_277_0 and not isNil(var_277_0) and arg_274_1.var_.characterEffect1084ui_story then
				arg_274_1.var_.characterEffect1084ui_story.fillFlat = false
			end

			local var_277_4 = 0
			local var_277_5 = 0.825

			if var_277_4 < arg_274_1.time_ and arg_274_1.time_ <= var_277_4 + arg_277_0 then
				arg_274_1.talkMaxDuration = 0
				arg_274_1.dialogCg_.alpha = 1

				arg_274_1.dialog_:SetActive(true)
				SetActive(arg_274_1.leftNameGo_, true)

				local var_277_6 = arg_274_1:FormatText(StoryNameCfg[6].name)

				arg_274_1.leftNameTxt_.text = var_277_6

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_274_1.leftNameTxt_.transform)

				arg_274_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_274_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_274_1:RecordName(arg_274_1.leftNameTxt_.text)
				SetActive(arg_274_1.iconTrs_.gameObject, false)
				arg_274_1.callingController_:SetSelectedState("normal")

				local var_277_7 = arg_274_1:GetWordFromCfg(319501066)
				local var_277_8 = arg_274_1:FormatText(var_277_7.content)

				arg_274_1.text_.text = var_277_8

				LuaForUtil.ClearLinePrefixSymbol(arg_274_1.text_)

				local var_277_9 = 33
				local var_277_10 = utf8.len(var_277_8)
				local var_277_11 = var_277_9 <= 0 and var_277_5 or var_277_5 * (var_277_10 / var_277_9)

				if var_277_11 > 0 and var_277_5 < var_277_11 then
					arg_274_1.talkMaxDuration = var_277_11

					if var_277_11 + var_277_4 > arg_274_1.duration_ then
						arg_274_1.duration_ = var_277_11 + var_277_4
					end
				end

				arg_274_1.text_.text = var_277_8
				arg_274_1.typewritter.percent = 0

				arg_274_1.typewritter:SetDirty()
				arg_274_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_319501", "319501066", "story_v_out_319501.awb") ~= 0 then
					local var_277_12 = manager.audio:GetVoiceLength("story_v_out_319501", "319501066", "story_v_out_319501.awb") / 1000

					if var_277_12 + var_277_4 > arg_274_1.duration_ then
						arg_274_1.duration_ = var_277_12 + var_277_4
					end

					if var_277_7.prefab_name ~= "" and arg_274_1.actors_[var_277_7.prefab_name] ~= nil then
						local var_277_13 = LuaForUtil.PlayVoiceWithCriLipsync(arg_274_1.actors_[var_277_7.prefab_name].transform, "story_v_out_319501", "319501066", "story_v_out_319501.awb")

						arg_274_1:RecordAudio("319501066", var_277_13)
						arg_274_1:RecordAudio("319501066", var_277_13)
					else
						arg_274_1:AudioAction("play", "voice", "story_v_out_319501", "319501066", "story_v_out_319501.awb")
					end

					arg_274_1:RecordHistoryTalkVoice("story_v_out_319501", "319501066", "story_v_out_319501.awb")
				end

				arg_274_1:RecordContent(arg_274_1.text_.text)
			end

			local var_277_14 = math.max(var_277_5, arg_274_1.talkMaxDuration)

			if var_277_4 <= arg_274_1.time_ and arg_274_1.time_ < var_277_4 + var_277_14 then
				arg_274_1.typewritter.percent = (arg_274_1.time_ - var_277_4) / var_277_14

				arg_274_1.typewritter:SetDirty()
			end

			if arg_274_1.time_ >= var_277_4 + var_277_14 and arg_274_1.time_ < var_277_4 + var_277_14 + arg_277_0 then
				arg_274_1.typewritter.percent = 1

				arg_274_1.typewritter:SetDirty()
				arg_274_1:ShowNextGo(true)
			end
		end

		arg_274_1.nodeConfigList_ = {}

		arg_274_1:InitPlayNodeList()
	end,
	Play319501067 = function(arg_278_0, arg_278_1)
		arg_278_1.time_ = 0
		arg_278_1.frameCnt_ = 0
		arg_278_1.state_ = "playing"
		arg_278_1.curTalkId_ = 319501067
		arg_278_1.duration_ = 10.2

		local var_278_0 = {
			zh = 3.633,
			ja = 10.2
		}
		local var_278_1 = manager.audio:GetLocalizationFlag()

		if var_278_0[var_278_1] ~= nil then
			arg_278_1.duration_ = var_278_0[var_278_1]
		end

		SetActive(arg_278_1.tipsGo_, false)

		function arg_278_1.onSingleLineFinish_()
			arg_278_1.onSingleLineUpdate_ = nil
			arg_278_1.onSingleLineFinish_ = nil
			arg_278_1.state_ = "waiting"
		end

		function arg_278_1.playNext_(arg_280_0)
			if arg_280_0 == 1 then
				arg_278_0:Play319501068(arg_278_1)
			end
		end

		function arg_278_1.onSingleLineUpdate_(arg_281_0)
			local var_281_0 = 0

			if var_281_0 < arg_278_1.time_ and arg_278_1.time_ <= var_281_0 + arg_281_0 then
				arg_278_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/story1084/story1084action/1084action7_1")
			end

			local var_281_1 = 0

			if var_281_1 < arg_278_1.time_ and arg_278_1.time_ <= var_281_1 + arg_281_0 then
				arg_278_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface2101cva")
			end

			local var_281_2 = 0
			local var_281_3 = 0.425

			if var_281_2 < arg_278_1.time_ and arg_278_1.time_ <= var_281_2 + arg_281_0 then
				arg_278_1.talkMaxDuration = 0
				arg_278_1.dialogCg_.alpha = 1

				arg_278_1.dialog_:SetActive(true)
				SetActive(arg_278_1.leftNameGo_, true)

				local var_281_4 = arg_278_1:FormatText(StoryNameCfg[6].name)

				arg_278_1.leftNameTxt_.text = var_281_4

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_278_1.leftNameTxt_.transform)

				arg_278_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_278_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_278_1:RecordName(arg_278_1.leftNameTxt_.text)
				SetActive(arg_278_1.iconTrs_.gameObject, false)
				arg_278_1.callingController_:SetSelectedState("normal")

				local var_281_5 = arg_278_1:GetWordFromCfg(319501067)
				local var_281_6 = arg_278_1:FormatText(var_281_5.content)

				arg_278_1.text_.text = var_281_6

				LuaForUtil.ClearLinePrefixSymbol(arg_278_1.text_)

				local var_281_7 = 17
				local var_281_8 = utf8.len(var_281_6)
				local var_281_9 = var_281_7 <= 0 and var_281_3 or var_281_3 * (var_281_8 / var_281_7)

				if var_281_9 > 0 and var_281_3 < var_281_9 then
					arg_278_1.talkMaxDuration = var_281_9

					if var_281_9 + var_281_2 > arg_278_1.duration_ then
						arg_278_1.duration_ = var_281_9 + var_281_2
					end
				end

				arg_278_1.text_.text = var_281_6
				arg_278_1.typewritter.percent = 0

				arg_278_1.typewritter:SetDirty()
				arg_278_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_319501", "319501067", "story_v_out_319501.awb") ~= 0 then
					local var_281_10 = manager.audio:GetVoiceLength("story_v_out_319501", "319501067", "story_v_out_319501.awb") / 1000

					if var_281_10 + var_281_2 > arg_278_1.duration_ then
						arg_278_1.duration_ = var_281_10 + var_281_2
					end

					if var_281_5.prefab_name ~= "" and arg_278_1.actors_[var_281_5.prefab_name] ~= nil then
						local var_281_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_278_1.actors_[var_281_5.prefab_name].transform, "story_v_out_319501", "319501067", "story_v_out_319501.awb")

						arg_278_1:RecordAudio("319501067", var_281_11)
						arg_278_1:RecordAudio("319501067", var_281_11)
					else
						arg_278_1:AudioAction("play", "voice", "story_v_out_319501", "319501067", "story_v_out_319501.awb")
					end

					arg_278_1:RecordHistoryTalkVoice("story_v_out_319501", "319501067", "story_v_out_319501.awb")
				end

				arg_278_1:RecordContent(arg_278_1.text_.text)
			end

			local var_281_12 = math.max(var_281_3, arg_278_1.talkMaxDuration)

			if var_281_2 <= arg_278_1.time_ and arg_278_1.time_ < var_281_2 + var_281_12 then
				arg_278_1.typewritter.percent = (arg_278_1.time_ - var_281_2) / var_281_12

				arg_278_1.typewritter:SetDirty()
			end

			if arg_278_1.time_ >= var_281_2 + var_281_12 and arg_278_1.time_ < var_281_2 + var_281_12 + arg_281_0 then
				arg_278_1.typewritter.percent = 1

				arg_278_1.typewritter:SetDirty()
				arg_278_1:ShowNextGo(true)
			end
		end

		arg_278_1.nodeConfigList_ = {}

		arg_278_1:InitPlayNodeList()
	end,
	Play319501068 = function(arg_282_0, arg_282_1)
		arg_282_1.time_ = 0
		arg_282_1.frameCnt_ = 0
		arg_282_1.state_ = "playing"
		arg_282_1.curTalkId_ = 319501068
		arg_282_1.duration_ = 2

		SetActive(arg_282_1.tipsGo_, false)

		function arg_282_1.onSingleLineFinish_()
			arg_282_1.onSingleLineUpdate_ = nil
			arg_282_1.onSingleLineFinish_ = nil
			arg_282_1.state_ = "waiting"
		end

		function arg_282_1.playNext_(arg_284_0)
			if arg_284_0 == 1 then
				arg_282_0:Play319501069(arg_282_1)
			end
		end

		function arg_282_1.onSingleLineUpdate_(arg_285_0)
			local var_285_0 = arg_282_1.actors_["10068ui_story"]
			local var_285_1 = 0

			if var_285_1 < arg_282_1.time_ and arg_282_1.time_ <= var_285_1 + arg_285_0 and not isNil(var_285_0) and arg_282_1.var_.characterEffect10068ui_story == nil then
				arg_282_1.var_.characterEffect10068ui_story = var_285_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_285_2 = 0.200000002980232

			if var_285_1 <= arg_282_1.time_ and arg_282_1.time_ < var_285_1 + var_285_2 and not isNil(var_285_0) then
				local var_285_3 = (arg_282_1.time_ - var_285_1) / var_285_2

				if arg_282_1.var_.characterEffect10068ui_story and not isNil(var_285_0) then
					arg_282_1.var_.characterEffect10068ui_story.fillFlat = false
				end
			end

			if arg_282_1.time_ >= var_285_1 + var_285_2 and arg_282_1.time_ < var_285_1 + var_285_2 + arg_285_0 and not isNil(var_285_0) and arg_282_1.var_.characterEffect10068ui_story then
				arg_282_1.var_.characterEffect10068ui_story.fillFlat = false
			end

			local var_285_4 = 0

			if var_285_4 < arg_282_1.time_ and arg_282_1.time_ <= var_285_4 + arg_285_0 then
				arg_282_1:PlayTimeline("10068ui_story", "StoryTimeline/CharAction/story10068/story10068action/10068action4_1")
			end

			local var_285_5 = 0

			if var_285_5 < arg_282_1.time_ and arg_282_1.time_ <= var_285_5 + arg_285_0 then
				arg_282_1:PlayTimeline("10068ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_285_6 = arg_282_1.actors_["1084ui_story"]
			local var_285_7 = 0

			if var_285_7 < arg_282_1.time_ and arg_282_1.time_ <= var_285_7 + arg_285_0 and not isNil(var_285_6) and arg_282_1.var_.characterEffect1084ui_story == nil then
				arg_282_1.var_.characterEffect1084ui_story = var_285_6:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_285_8 = 0.200000002980232

			if var_285_7 <= arg_282_1.time_ and arg_282_1.time_ < var_285_7 + var_285_8 and not isNil(var_285_6) then
				local var_285_9 = (arg_282_1.time_ - var_285_7) / var_285_8

				if arg_282_1.var_.characterEffect1084ui_story and not isNil(var_285_6) then
					local var_285_10 = Mathf.Lerp(0, 0.5, var_285_9)

					arg_282_1.var_.characterEffect1084ui_story.fillFlat = true
					arg_282_1.var_.characterEffect1084ui_story.fillRatio = var_285_10
				end
			end

			if arg_282_1.time_ >= var_285_7 + var_285_8 and arg_282_1.time_ < var_285_7 + var_285_8 + arg_285_0 and not isNil(var_285_6) and arg_282_1.var_.characterEffect1084ui_story then
				local var_285_11 = 0.5

				arg_282_1.var_.characterEffect1084ui_story.fillFlat = true
				arg_282_1.var_.characterEffect1084ui_story.fillRatio = var_285_11
			end

			local var_285_12 = 0
			local var_285_13 = 0.2

			if var_285_12 < arg_282_1.time_ and arg_282_1.time_ <= var_285_12 + arg_285_0 then
				arg_282_1.talkMaxDuration = 0
				arg_282_1.dialogCg_.alpha = 1

				arg_282_1.dialog_:SetActive(true)
				SetActive(arg_282_1.leftNameGo_, true)

				local var_285_14 = arg_282_1:FormatText(StoryNameCfg[697].name)

				arg_282_1.leftNameTxt_.text = var_285_14

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_282_1.leftNameTxt_.transform)

				arg_282_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_282_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_282_1:RecordName(arg_282_1.leftNameTxt_.text)
				SetActive(arg_282_1.iconTrs_.gameObject, false)
				arg_282_1.callingController_:SetSelectedState("normal")

				local var_285_15 = arg_282_1:GetWordFromCfg(319501068)
				local var_285_16 = arg_282_1:FormatText(var_285_15.content)

				arg_282_1.text_.text = var_285_16

				LuaForUtil.ClearLinePrefixSymbol(arg_282_1.text_)

				local var_285_17 = 8
				local var_285_18 = utf8.len(var_285_16)
				local var_285_19 = var_285_17 <= 0 and var_285_13 or var_285_13 * (var_285_18 / var_285_17)

				if var_285_19 > 0 and var_285_13 < var_285_19 then
					arg_282_1.talkMaxDuration = var_285_19

					if var_285_19 + var_285_12 > arg_282_1.duration_ then
						arg_282_1.duration_ = var_285_19 + var_285_12
					end
				end

				arg_282_1.text_.text = var_285_16
				arg_282_1.typewritter.percent = 0

				arg_282_1.typewritter:SetDirty()
				arg_282_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_319501", "319501068", "story_v_out_319501.awb") ~= 0 then
					local var_285_20 = manager.audio:GetVoiceLength("story_v_out_319501", "319501068", "story_v_out_319501.awb") / 1000

					if var_285_20 + var_285_12 > arg_282_1.duration_ then
						arg_282_1.duration_ = var_285_20 + var_285_12
					end

					if var_285_15.prefab_name ~= "" and arg_282_1.actors_[var_285_15.prefab_name] ~= nil then
						local var_285_21 = LuaForUtil.PlayVoiceWithCriLipsync(arg_282_1.actors_[var_285_15.prefab_name].transform, "story_v_out_319501", "319501068", "story_v_out_319501.awb")

						arg_282_1:RecordAudio("319501068", var_285_21)
						arg_282_1:RecordAudio("319501068", var_285_21)
					else
						arg_282_1:AudioAction("play", "voice", "story_v_out_319501", "319501068", "story_v_out_319501.awb")
					end

					arg_282_1:RecordHistoryTalkVoice("story_v_out_319501", "319501068", "story_v_out_319501.awb")
				end

				arg_282_1:RecordContent(arg_282_1.text_.text)
			end

			local var_285_22 = math.max(var_285_13, arg_282_1.talkMaxDuration)

			if var_285_12 <= arg_282_1.time_ and arg_282_1.time_ < var_285_12 + var_285_22 then
				arg_282_1.typewritter.percent = (arg_282_1.time_ - var_285_12) / var_285_22

				arg_282_1.typewritter:SetDirty()
			end

			if arg_282_1.time_ >= var_285_12 + var_285_22 and arg_282_1.time_ < var_285_12 + var_285_22 + arg_285_0 then
				arg_282_1.typewritter.percent = 1

				arg_282_1.typewritter:SetDirty()
				arg_282_1:ShowNextGo(true)
			end
		end

		arg_282_1.nodeConfigList_ = {}

		arg_282_1:InitPlayNodeList()
	end,
	Play319501069 = function(arg_286_0, arg_286_1)
		arg_286_1.time_ = 0
		arg_286_1.frameCnt_ = 0
		arg_286_1.state_ = "playing"
		arg_286_1.curTalkId_ = 319501069
		arg_286_1.duration_ = 5

		SetActive(arg_286_1.tipsGo_, false)

		function arg_286_1.onSingleLineFinish_()
			arg_286_1.onSingleLineUpdate_ = nil
			arg_286_1.onSingleLineFinish_ = nil
			arg_286_1.state_ = "waiting"
		end

		function arg_286_1.playNext_(arg_288_0)
			if arg_288_0 == 1 then
				arg_286_0:Play319501070(arg_286_1)
			end
		end

		function arg_286_1.onSingleLineUpdate_(arg_289_0)
			local var_289_0 = arg_286_1.actors_["10068ui_story"]
			local var_289_1 = 0

			if var_289_1 < arg_286_1.time_ and arg_286_1.time_ <= var_289_1 + arg_289_0 and not isNil(var_289_0) and arg_286_1.var_.characterEffect10068ui_story == nil then
				arg_286_1.var_.characterEffect10068ui_story = var_289_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_289_2 = 0.200000002980232

			if var_289_1 <= arg_286_1.time_ and arg_286_1.time_ < var_289_1 + var_289_2 and not isNil(var_289_0) then
				local var_289_3 = (arg_286_1.time_ - var_289_1) / var_289_2

				if arg_286_1.var_.characterEffect10068ui_story and not isNil(var_289_0) then
					local var_289_4 = Mathf.Lerp(0, 0.5, var_289_3)

					arg_286_1.var_.characterEffect10068ui_story.fillFlat = true
					arg_286_1.var_.characterEffect10068ui_story.fillRatio = var_289_4
				end
			end

			if arg_286_1.time_ >= var_289_1 + var_289_2 and arg_286_1.time_ < var_289_1 + var_289_2 + arg_289_0 and not isNil(var_289_0) and arg_286_1.var_.characterEffect10068ui_story then
				local var_289_5 = 0.5

				arg_286_1.var_.characterEffect10068ui_story.fillFlat = true
				arg_286_1.var_.characterEffect10068ui_story.fillRatio = var_289_5
			end

			local var_289_6 = 0
			local var_289_7 = 1.475

			if var_289_6 < arg_286_1.time_ and arg_286_1.time_ <= var_289_6 + arg_289_0 then
				arg_286_1.talkMaxDuration = 0
				arg_286_1.dialogCg_.alpha = 1

				arg_286_1.dialog_:SetActive(true)
				SetActive(arg_286_1.leftNameGo_, false)

				arg_286_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_286_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_286_1:RecordName(arg_286_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_286_1.iconTrs_.gameObject, false)
				arg_286_1.callingController_:SetSelectedState("normal")

				local var_289_8 = arg_286_1:GetWordFromCfg(319501069)
				local var_289_9 = arg_286_1:FormatText(var_289_8.content)

				arg_286_1.text_.text = var_289_9

				LuaForUtil.ClearLinePrefixSymbol(arg_286_1.text_)

				local var_289_10 = 59
				local var_289_11 = utf8.len(var_289_9)
				local var_289_12 = var_289_10 <= 0 and var_289_7 or var_289_7 * (var_289_11 / var_289_10)

				if var_289_12 > 0 and var_289_7 < var_289_12 then
					arg_286_1.talkMaxDuration = var_289_12

					if var_289_12 + var_289_6 > arg_286_1.duration_ then
						arg_286_1.duration_ = var_289_12 + var_289_6
					end
				end

				arg_286_1.text_.text = var_289_9
				arg_286_1.typewritter.percent = 0

				arg_286_1.typewritter:SetDirty()
				arg_286_1:ShowNextGo(false)
				arg_286_1:RecordContent(arg_286_1.text_.text)
			end

			local var_289_13 = math.max(var_289_7, arg_286_1.talkMaxDuration)

			if var_289_6 <= arg_286_1.time_ and arg_286_1.time_ < var_289_6 + var_289_13 then
				arg_286_1.typewritter.percent = (arg_286_1.time_ - var_289_6) / var_289_13

				arg_286_1.typewritter:SetDirty()
			end

			if arg_286_1.time_ >= var_289_6 + var_289_13 and arg_286_1.time_ < var_289_6 + var_289_13 + arg_289_0 then
				arg_286_1.typewritter.percent = 1

				arg_286_1.typewritter:SetDirty()
				arg_286_1:ShowNextGo(true)
			end
		end

		arg_286_1.nodeConfigList_ = {}

		arg_286_1:InitPlayNodeList()
	end,
	Play319501070 = function(arg_290_0, arg_290_1)
		arg_290_1.time_ = 0
		arg_290_1.frameCnt_ = 0
		arg_290_1.state_ = "playing"
		arg_290_1.curTalkId_ = 319501070
		arg_290_1.duration_ = 8.17

		local var_290_0 = {
			zh = 3.7,
			ja = 8.166
		}
		local var_290_1 = manager.audio:GetLocalizationFlag()

		if var_290_0[var_290_1] ~= nil then
			arg_290_1.duration_ = var_290_0[var_290_1]
		end

		SetActive(arg_290_1.tipsGo_, false)

		function arg_290_1.onSingleLineFinish_()
			arg_290_1.onSingleLineUpdate_ = nil
			arg_290_1.onSingleLineFinish_ = nil
			arg_290_1.state_ = "waiting"
		end

		function arg_290_1.playNext_(arg_292_0)
			if arg_292_0 == 1 then
				arg_290_0:Play319501071(arg_290_1)
			end
		end

		function arg_290_1.onSingleLineUpdate_(arg_293_0)
			local var_293_0 = arg_290_1.actors_["1084ui_story"]
			local var_293_1 = 0

			if var_293_1 < arg_290_1.time_ and arg_290_1.time_ <= var_293_1 + arg_293_0 and not isNil(var_293_0) and arg_290_1.var_.characterEffect1084ui_story == nil then
				arg_290_1.var_.characterEffect1084ui_story = var_293_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_293_2 = 0.200000002980232

			if var_293_1 <= arg_290_1.time_ and arg_290_1.time_ < var_293_1 + var_293_2 and not isNil(var_293_0) then
				local var_293_3 = (arg_290_1.time_ - var_293_1) / var_293_2

				if arg_290_1.var_.characterEffect1084ui_story and not isNil(var_293_0) then
					arg_290_1.var_.characterEffect1084ui_story.fillFlat = false
				end
			end

			if arg_290_1.time_ >= var_293_1 + var_293_2 and arg_290_1.time_ < var_293_1 + var_293_2 + arg_293_0 and not isNil(var_293_0) and arg_290_1.var_.characterEffect1084ui_story then
				arg_290_1.var_.characterEffect1084ui_story.fillFlat = false
			end

			local var_293_4 = 0

			if var_293_4 < arg_290_1.time_ and arg_290_1.time_ <= var_293_4 + arg_293_0 then
				arg_290_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/story1084/story1084action/1084action7_2")
			end

			local var_293_5 = 0

			if var_293_5 < arg_290_1.time_ and arg_290_1.time_ <= var_293_5 + arg_293_0 then
				arg_290_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_293_6 = 0
			local var_293_7 = 0.5

			if var_293_6 < arg_290_1.time_ and arg_290_1.time_ <= var_293_6 + arg_293_0 then
				arg_290_1.talkMaxDuration = 0
				arg_290_1.dialogCg_.alpha = 1

				arg_290_1.dialog_:SetActive(true)
				SetActive(arg_290_1.leftNameGo_, true)

				local var_293_8 = arg_290_1:FormatText(StoryNameCfg[6].name)

				arg_290_1.leftNameTxt_.text = var_293_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_290_1.leftNameTxt_.transform)

				arg_290_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_290_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_290_1:RecordName(arg_290_1.leftNameTxt_.text)
				SetActive(arg_290_1.iconTrs_.gameObject, false)
				arg_290_1.callingController_:SetSelectedState("normal")

				local var_293_9 = arg_290_1:GetWordFromCfg(319501070)
				local var_293_10 = arg_290_1:FormatText(var_293_9.content)

				arg_290_1.text_.text = var_293_10

				LuaForUtil.ClearLinePrefixSymbol(arg_290_1.text_)

				local var_293_11 = 20
				local var_293_12 = utf8.len(var_293_10)
				local var_293_13 = var_293_11 <= 0 and var_293_7 or var_293_7 * (var_293_12 / var_293_11)

				if var_293_13 > 0 and var_293_7 < var_293_13 then
					arg_290_1.talkMaxDuration = var_293_13

					if var_293_13 + var_293_6 > arg_290_1.duration_ then
						arg_290_1.duration_ = var_293_13 + var_293_6
					end
				end

				arg_290_1.text_.text = var_293_10
				arg_290_1.typewritter.percent = 0

				arg_290_1.typewritter:SetDirty()
				arg_290_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_319501", "319501070", "story_v_out_319501.awb") ~= 0 then
					local var_293_14 = manager.audio:GetVoiceLength("story_v_out_319501", "319501070", "story_v_out_319501.awb") / 1000

					if var_293_14 + var_293_6 > arg_290_1.duration_ then
						arg_290_1.duration_ = var_293_14 + var_293_6
					end

					if var_293_9.prefab_name ~= "" and arg_290_1.actors_[var_293_9.prefab_name] ~= nil then
						local var_293_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_290_1.actors_[var_293_9.prefab_name].transform, "story_v_out_319501", "319501070", "story_v_out_319501.awb")

						arg_290_1:RecordAudio("319501070", var_293_15)
						arg_290_1:RecordAudio("319501070", var_293_15)
					else
						arg_290_1:AudioAction("play", "voice", "story_v_out_319501", "319501070", "story_v_out_319501.awb")
					end

					arg_290_1:RecordHistoryTalkVoice("story_v_out_319501", "319501070", "story_v_out_319501.awb")
				end

				arg_290_1:RecordContent(arg_290_1.text_.text)
			end

			local var_293_16 = math.max(var_293_7, arg_290_1.talkMaxDuration)

			if var_293_6 <= arg_290_1.time_ and arg_290_1.time_ < var_293_6 + var_293_16 then
				arg_290_1.typewritter.percent = (arg_290_1.time_ - var_293_6) / var_293_16

				arg_290_1.typewritter:SetDirty()
			end

			if arg_290_1.time_ >= var_293_6 + var_293_16 and arg_290_1.time_ < var_293_6 + var_293_16 + arg_293_0 then
				arg_290_1.typewritter.percent = 1

				arg_290_1.typewritter:SetDirty()
				arg_290_1:ShowNextGo(true)
			end
		end

		arg_290_1.nodeConfigList_ = {}

		arg_290_1:InitPlayNodeList()
	end,
	Play319501071 = function(arg_294_0, arg_294_1)
		arg_294_1.time_ = 0
		arg_294_1.frameCnt_ = 0
		arg_294_1.state_ = "playing"
		arg_294_1.curTalkId_ = 319501071
		arg_294_1.duration_ = 6.2

		local var_294_0 = {
			zh = 4.433,
			ja = 6.2
		}
		local var_294_1 = manager.audio:GetLocalizationFlag()

		if var_294_0[var_294_1] ~= nil then
			arg_294_1.duration_ = var_294_0[var_294_1]
		end

		SetActive(arg_294_1.tipsGo_, false)

		function arg_294_1.onSingleLineFinish_()
			arg_294_1.onSingleLineUpdate_ = nil
			arg_294_1.onSingleLineFinish_ = nil
			arg_294_1.state_ = "waiting"
		end

		function arg_294_1.playNext_(arg_296_0)
			if arg_296_0 == 1 then
				arg_294_0:Play319501072(arg_294_1)
			end
		end

		function arg_294_1.onSingleLineUpdate_(arg_297_0)
			local var_297_0 = arg_294_1.actors_["10068ui_story"].transform
			local var_297_1 = 0

			if var_297_1 < arg_294_1.time_ and arg_294_1.time_ <= var_297_1 + arg_297_0 then
				arg_294_1.var_.moveOldPos10068ui_story = var_297_0.localPosition
			end

			local var_297_2 = 0.001

			if var_297_1 <= arg_294_1.time_ and arg_294_1.time_ < var_297_1 + var_297_2 then
				local var_297_3 = (arg_294_1.time_ - var_297_1) / var_297_2
				local var_297_4 = Vector3.New(0.7, -0.75, -6.18)

				var_297_0.localPosition = Vector3.Lerp(arg_294_1.var_.moveOldPos10068ui_story, var_297_4, var_297_3)

				local var_297_5 = manager.ui.mainCamera.transform.position - var_297_0.position

				var_297_0.forward = Vector3.New(var_297_5.x, var_297_5.y, var_297_5.z)

				local var_297_6 = var_297_0.localEulerAngles

				var_297_6.z = 0
				var_297_6.x = 0
				var_297_0.localEulerAngles = var_297_6
			end

			if arg_294_1.time_ >= var_297_1 + var_297_2 and arg_294_1.time_ < var_297_1 + var_297_2 + arg_297_0 then
				var_297_0.localPosition = Vector3.New(0.7, -0.75, -6.18)

				local var_297_7 = manager.ui.mainCamera.transform.position - var_297_0.position

				var_297_0.forward = Vector3.New(var_297_7.x, var_297_7.y, var_297_7.z)

				local var_297_8 = var_297_0.localEulerAngles

				var_297_8.z = 0
				var_297_8.x = 0
				var_297_0.localEulerAngles = var_297_8
			end

			local var_297_9 = arg_294_1.actors_["10068ui_story"]
			local var_297_10 = 0

			if var_297_10 < arg_294_1.time_ and arg_294_1.time_ <= var_297_10 + arg_297_0 and not isNil(var_297_9) and arg_294_1.var_.characterEffect10068ui_story == nil then
				arg_294_1.var_.characterEffect10068ui_story = var_297_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_297_11 = 0.200000002980232

			if var_297_10 <= arg_294_1.time_ and arg_294_1.time_ < var_297_10 + var_297_11 and not isNil(var_297_9) then
				local var_297_12 = (arg_294_1.time_ - var_297_10) / var_297_11

				if arg_294_1.var_.characterEffect10068ui_story and not isNil(var_297_9) then
					arg_294_1.var_.characterEffect10068ui_story.fillFlat = false
				end
			end

			if arg_294_1.time_ >= var_297_10 + var_297_11 and arg_294_1.time_ < var_297_10 + var_297_11 + arg_297_0 and not isNil(var_297_9) and arg_294_1.var_.characterEffect10068ui_story then
				arg_294_1.var_.characterEffect10068ui_story.fillFlat = false
			end

			local var_297_13 = 0

			if var_297_13 < arg_294_1.time_ and arg_294_1.time_ <= var_297_13 + arg_297_0 then
				arg_294_1:PlayTimeline("10068ui_story", "StoryTimeline/CharAction/story10068/story10068action/10068action1_1")
			end

			local var_297_14 = 0

			if var_297_14 < arg_294_1.time_ and arg_294_1.time_ <= var_297_14 + arg_297_0 then
				arg_294_1:PlayTimeline("10068ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_297_15 = arg_294_1.actors_["1084ui_story"]
			local var_297_16 = 0

			if var_297_16 < arg_294_1.time_ and arg_294_1.time_ <= var_297_16 + arg_297_0 and not isNil(var_297_15) and arg_294_1.var_.characterEffect1084ui_story == nil then
				arg_294_1.var_.characterEffect1084ui_story = var_297_15:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_297_17 = 0.200000002980232

			if var_297_16 <= arg_294_1.time_ and arg_294_1.time_ < var_297_16 + var_297_17 and not isNil(var_297_15) then
				local var_297_18 = (arg_294_1.time_ - var_297_16) / var_297_17

				if arg_294_1.var_.characterEffect1084ui_story and not isNil(var_297_15) then
					local var_297_19 = Mathf.Lerp(0, 0.5, var_297_18)

					arg_294_1.var_.characterEffect1084ui_story.fillFlat = true
					arg_294_1.var_.characterEffect1084ui_story.fillRatio = var_297_19
				end
			end

			if arg_294_1.time_ >= var_297_16 + var_297_17 and arg_294_1.time_ < var_297_16 + var_297_17 + arg_297_0 and not isNil(var_297_15) and arg_294_1.var_.characterEffect1084ui_story then
				local var_297_20 = 0.5

				arg_294_1.var_.characterEffect1084ui_story.fillFlat = true
				arg_294_1.var_.characterEffect1084ui_story.fillRatio = var_297_20
			end

			local var_297_21 = 0
			local var_297_22 = 0.45

			if var_297_21 < arg_294_1.time_ and arg_294_1.time_ <= var_297_21 + arg_297_0 then
				arg_294_1.talkMaxDuration = 0
				arg_294_1.dialogCg_.alpha = 1

				arg_294_1.dialog_:SetActive(true)
				SetActive(arg_294_1.leftNameGo_, true)

				local var_297_23 = arg_294_1:FormatText(StoryNameCfg[697].name)

				arg_294_1.leftNameTxt_.text = var_297_23

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_294_1.leftNameTxt_.transform)

				arg_294_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_294_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_294_1:RecordName(arg_294_1.leftNameTxt_.text)
				SetActive(arg_294_1.iconTrs_.gameObject, false)
				arg_294_1.callingController_:SetSelectedState("normal")

				local var_297_24 = arg_294_1:GetWordFromCfg(319501071)
				local var_297_25 = arg_294_1:FormatText(var_297_24.content)

				arg_294_1.text_.text = var_297_25

				LuaForUtil.ClearLinePrefixSymbol(arg_294_1.text_)

				local var_297_26 = 18
				local var_297_27 = utf8.len(var_297_25)
				local var_297_28 = var_297_26 <= 0 and var_297_22 or var_297_22 * (var_297_27 / var_297_26)

				if var_297_28 > 0 and var_297_22 < var_297_28 then
					arg_294_1.talkMaxDuration = var_297_28

					if var_297_28 + var_297_21 > arg_294_1.duration_ then
						arg_294_1.duration_ = var_297_28 + var_297_21
					end
				end

				arg_294_1.text_.text = var_297_25
				arg_294_1.typewritter.percent = 0

				arg_294_1.typewritter:SetDirty()
				arg_294_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_319501", "319501071", "story_v_out_319501.awb") ~= 0 then
					local var_297_29 = manager.audio:GetVoiceLength("story_v_out_319501", "319501071", "story_v_out_319501.awb") / 1000

					if var_297_29 + var_297_21 > arg_294_1.duration_ then
						arg_294_1.duration_ = var_297_29 + var_297_21
					end

					if var_297_24.prefab_name ~= "" and arg_294_1.actors_[var_297_24.prefab_name] ~= nil then
						local var_297_30 = LuaForUtil.PlayVoiceWithCriLipsync(arg_294_1.actors_[var_297_24.prefab_name].transform, "story_v_out_319501", "319501071", "story_v_out_319501.awb")

						arg_294_1:RecordAudio("319501071", var_297_30)
						arg_294_1:RecordAudio("319501071", var_297_30)
					else
						arg_294_1:AudioAction("play", "voice", "story_v_out_319501", "319501071", "story_v_out_319501.awb")
					end

					arg_294_1:RecordHistoryTalkVoice("story_v_out_319501", "319501071", "story_v_out_319501.awb")
				end

				arg_294_1:RecordContent(arg_294_1.text_.text)
			end

			local var_297_31 = math.max(var_297_22, arg_294_1.talkMaxDuration)

			if var_297_21 <= arg_294_1.time_ and arg_294_1.time_ < var_297_21 + var_297_31 then
				arg_294_1.typewritter.percent = (arg_294_1.time_ - var_297_21) / var_297_31

				arg_294_1.typewritter:SetDirty()
			end

			if arg_294_1.time_ >= var_297_21 + var_297_31 and arg_294_1.time_ < var_297_21 + var_297_31 + arg_297_0 then
				arg_294_1.typewritter.percent = 1

				arg_294_1.typewritter:SetDirty()
				arg_294_1:ShowNextGo(true)
			end
		end

		arg_294_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10068ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_294_1:InitPlayNodeList()
	end,
	Play319501072 = function(arg_298_0, arg_298_1)
		arg_298_1.time_ = 0
		arg_298_1.frameCnt_ = 0
		arg_298_1.state_ = "playing"
		arg_298_1.curTalkId_ = 319501072
		arg_298_1.duration_ = 3.67

		local var_298_0 = {
			zh = 2.5,
			ja = 3.666
		}
		local var_298_1 = manager.audio:GetLocalizationFlag()

		if var_298_0[var_298_1] ~= nil then
			arg_298_1.duration_ = var_298_0[var_298_1]
		end

		SetActive(arg_298_1.tipsGo_, false)

		function arg_298_1.onSingleLineFinish_()
			arg_298_1.onSingleLineUpdate_ = nil
			arg_298_1.onSingleLineFinish_ = nil
			arg_298_1.state_ = "waiting"
		end

		function arg_298_1.playNext_(arg_300_0)
			if arg_300_0 == 1 then
				arg_298_0:Play319501073(arg_298_1)
			end
		end

		function arg_298_1.onSingleLineUpdate_(arg_301_0)
			local var_301_0 = 0
			local var_301_1 = 0.3

			if var_301_0 < arg_298_1.time_ and arg_298_1.time_ <= var_301_0 + arg_301_0 then
				arg_298_1.talkMaxDuration = 0
				arg_298_1.dialogCg_.alpha = 1

				arg_298_1.dialog_:SetActive(true)
				SetActive(arg_298_1.leftNameGo_, true)

				local var_301_2 = arg_298_1:FormatText(StoryNameCfg[697].name)

				arg_298_1.leftNameTxt_.text = var_301_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_298_1.leftNameTxt_.transform)

				arg_298_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_298_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_298_1:RecordName(arg_298_1.leftNameTxt_.text)
				SetActive(arg_298_1.iconTrs_.gameObject, false)
				arg_298_1.callingController_:SetSelectedState("normal")

				local var_301_3 = arg_298_1:GetWordFromCfg(319501072)
				local var_301_4 = arg_298_1:FormatText(var_301_3.content)

				arg_298_1.text_.text = var_301_4

				LuaForUtil.ClearLinePrefixSymbol(arg_298_1.text_)

				local var_301_5 = 12
				local var_301_6 = utf8.len(var_301_4)
				local var_301_7 = var_301_5 <= 0 and var_301_1 or var_301_1 * (var_301_6 / var_301_5)

				if var_301_7 > 0 and var_301_1 < var_301_7 then
					arg_298_1.talkMaxDuration = var_301_7

					if var_301_7 + var_301_0 > arg_298_1.duration_ then
						arg_298_1.duration_ = var_301_7 + var_301_0
					end
				end

				arg_298_1.text_.text = var_301_4
				arg_298_1.typewritter.percent = 0

				arg_298_1.typewritter:SetDirty()
				arg_298_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_319501", "319501072", "story_v_out_319501.awb") ~= 0 then
					local var_301_8 = manager.audio:GetVoiceLength("story_v_out_319501", "319501072", "story_v_out_319501.awb") / 1000

					if var_301_8 + var_301_0 > arg_298_1.duration_ then
						arg_298_1.duration_ = var_301_8 + var_301_0
					end

					if var_301_3.prefab_name ~= "" and arg_298_1.actors_[var_301_3.prefab_name] ~= nil then
						local var_301_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_298_1.actors_[var_301_3.prefab_name].transform, "story_v_out_319501", "319501072", "story_v_out_319501.awb")

						arg_298_1:RecordAudio("319501072", var_301_9)
						arg_298_1:RecordAudio("319501072", var_301_9)
					else
						arg_298_1:AudioAction("play", "voice", "story_v_out_319501", "319501072", "story_v_out_319501.awb")
					end

					arg_298_1:RecordHistoryTalkVoice("story_v_out_319501", "319501072", "story_v_out_319501.awb")
				end

				arg_298_1:RecordContent(arg_298_1.text_.text)
			end

			local var_301_10 = math.max(var_301_1, arg_298_1.talkMaxDuration)

			if var_301_0 <= arg_298_1.time_ and arg_298_1.time_ < var_301_0 + var_301_10 then
				arg_298_1.typewritter.percent = (arg_298_1.time_ - var_301_0) / var_301_10

				arg_298_1.typewritter:SetDirty()
			end

			if arg_298_1.time_ >= var_301_0 + var_301_10 and arg_298_1.time_ < var_301_0 + var_301_10 + arg_301_0 then
				arg_298_1.typewritter.percent = 1

				arg_298_1.typewritter:SetDirty()
				arg_298_1:ShowNextGo(true)
			end
		end

		arg_298_1.nodeConfigList_ = {}

		arg_298_1:InitPlayNodeList()
	end,
	Play319501073 = function(arg_302_0, arg_302_1)
		arg_302_1.time_ = 0
		arg_302_1.frameCnt_ = 0
		arg_302_1.state_ = "playing"
		arg_302_1.curTalkId_ = 319501073
		arg_302_1.duration_ = 14.17

		local var_302_0 = {
			zh = 8.033,
			ja = 14.166
		}
		local var_302_1 = manager.audio:GetLocalizationFlag()

		if var_302_0[var_302_1] ~= nil then
			arg_302_1.duration_ = var_302_0[var_302_1]
		end

		SetActive(arg_302_1.tipsGo_, false)

		function arg_302_1.onSingleLineFinish_()
			arg_302_1.onSingleLineUpdate_ = nil
			arg_302_1.onSingleLineFinish_ = nil
			arg_302_1.state_ = "waiting"
		end

		function arg_302_1.playNext_(arg_304_0)
			if arg_304_0 == 1 then
				arg_302_0:Play319501074(arg_302_1)
			end
		end

		function arg_302_1.onSingleLineUpdate_(arg_305_0)
			local var_305_0 = arg_302_1.actors_["1084ui_story"].transform
			local var_305_1 = 0

			if var_305_1 < arg_302_1.time_ and arg_302_1.time_ <= var_305_1 + arg_305_0 then
				arg_302_1.var_.moveOldPos1084ui_story = var_305_0.localPosition
			end

			local var_305_2 = 0.001

			if var_305_1 <= arg_302_1.time_ and arg_302_1.time_ < var_305_1 + var_305_2 then
				local var_305_3 = (arg_302_1.time_ - var_305_1) / var_305_2
				local var_305_4 = Vector3.New(-0.7, -0.97, -6)

				var_305_0.localPosition = Vector3.Lerp(arg_302_1.var_.moveOldPos1084ui_story, var_305_4, var_305_3)

				local var_305_5 = manager.ui.mainCamera.transform.position - var_305_0.position

				var_305_0.forward = Vector3.New(var_305_5.x, var_305_5.y, var_305_5.z)

				local var_305_6 = var_305_0.localEulerAngles

				var_305_6.z = 0
				var_305_6.x = 0
				var_305_0.localEulerAngles = var_305_6
			end

			if arg_302_1.time_ >= var_305_1 + var_305_2 and arg_302_1.time_ < var_305_1 + var_305_2 + arg_305_0 then
				var_305_0.localPosition = Vector3.New(-0.7, -0.97, -6)

				local var_305_7 = manager.ui.mainCamera.transform.position - var_305_0.position

				var_305_0.forward = Vector3.New(var_305_7.x, var_305_7.y, var_305_7.z)

				local var_305_8 = var_305_0.localEulerAngles

				var_305_8.z = 0
				var_305_8.x = 0
				var_305_0.localEulerAngles = var_305_8
			end

			local var_305_9 = arg_302_1.actors_["1084ui_story"]
			local var_305_10 = 0

			if var_305_10 < arg_302_1.time_ and arg_302_1.time_ <= var_305_10 + arg_305_0 and not isNil(var_305_9) and arg_302_1.var_.characterEffect1084ui_story == nil then
				arg_302_1.var_.characterEffect1084ui_story = var_305_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_305_11 = 0.200000002980232

			if var_305_10 <= arg_302_1.time_ and arg_302_1.time_ < var_305_10 + var_305_11 and not isNil(var_305_9) then
				local var_305_12 = (arg_302_1.time_ - var_305_10) / var_305_11

				if arg_302_1.var_.characterEffect1084ui_story and not isNil(var_305_9) then
					arg_302_1.var_.characterEffect1084ui_story.fillFlat = false
				end
			end

			if arg_302_1.time_ >= var_305_10 + var_305_11 and arg_302_1.time_ < var_305_10 + var_305_11 + arg_305_0 and not isNil(var_305_9) and arg_302_1.var_.characterEffect1084ui_story then
				arg_302_1.var_.characterEffect1084ui_story.fillFlat = false
			end

			local var_305_13 = 0

			if var_305_13 < arg_302_1.time_ and arg_302_1.time_ <= var_305_13 + arg_305_0 then
				arg_302_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/story1084/story1084action/1084action3_1")
			end

			local var_305_14 = 0

			if var_305_14 < arg_302_1.time_ and arg_302_1.time_ <= var_305_14 + arg_305_0 then
				arg_302_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1101cva")
			end

			local var_305_15 = arg_302_1.actors_["10068ui_story"]
			local var_305_16 = 0

			if var_305_16 < arg_302_1.time_ and arg_302_1.time_ <= var_305_16 + arg_305_0 and not isNil(var_305_15) and arg_302_1.var_.characterEffect10068ui_story == nil then
				arg_302_1.var_.characterEffect10068ui_story = var_305_15:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_305_17 = 0.200000002980232

			if var_305_16 <= arg_302_1.time_ and arg_302_1.time_ < var_305_16 + var_305_17 and not isNil(var_305_15) then
				local var_305_18 = (arg_302_1.time_ - var_305_16) / var_305_17

				if arg_302_1.var_.characterEffect10068ui_story and not isNil(var_305_15) then
					local var_305_19 = Mathf.Lerp(0, 0.5, var_305_18)

					arg_302_1.var_.characterEffect10068ui_story.fillFlat = true
					arg_302_1.var_.characterEffect10068ui_story.fillRatio = var_305_19
				end
			end

			if arg_302_1.time_ >= var_305_16 + var_305_17 and arg_302_1.time_ < var_305_16 + var_305_17 + arg_305_0 and not isNil(var_305_15) and arg_302_1.var_.characterEffect10068ui_story then
				local var_305_20 = 0.5

				arg_302_1.var_.characterEffect10068ui_story.fillFlat = true
				arg_302_1.var_.characterEffect10068ui_story.fillRatio = var_305_20
			end

			local var_305_21 = 0
			local var_305_22 = 1.025

			if var_305_21 < arg_302_1.time_ and arg_302_1.time_ <= var_305_21 + arg_305_0 then
				arg_302_1.talkMaxDuration = 0
				arg_302_1.dialogCg_.alpha = 1

				arg_302_1.dialog_:SetActive(true)
				SetActive(arg_302_1.leftNameGo_, true)

				local var_305_23 = arg_302_1:FormatText(StoryNameCfg[6].name)

				arg_302_1.leftNameTxt_.text = var_305_23

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_302_1.leftNameTxt_.transform)

				arg_302_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_302_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_302_1:RecordName(arg_302_1.leftNameTxt_.text)
				SetActive(arg_302_1.iconTrs_.gameObject, false)
				arg_302_1.callingController_:SetSelectedState("normal")

				local var_305_24 = arg_302_1:GetWordFromCfg(319501073)
				local var_305_25 = arg_302_1:FormatText(var_305_24.content)

				arg_302_1.text_.text = var_305_25

				LuaForUtil.ClearLinePrefixSymbol(arg_302_1.text_)

				local var_305_26 = 41
				local var_305_27 = utf8.len(var_305_25)
				local var_305_28 = var_305_26 <= 0 and var_305_22 or var_305_22 * (var_305_27 / var_305_26)

				if var_305_28 > 0 and var_305_22 < var_305_28 then
					arg_302_1.talkMaxDuration = var_305_28

					if var_305_28 + var_305_21 > arg_302_1.duration_ then
						arg_302_1.duration_ = var_305_28 + var_305_21
					end
				end

				arg_302_1.text_.text = var_305_25
				arg_302_1.typewritter.percent = 0

				arg_302_1.typewritter:SetDirty()
				arg_302_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_319501", "319501073", "story_v_out_319501.awb") ~= 0 then
					local var_305_29 = manager.audio:GetVoiceLength("story_v_out_319501", "319501073", "story_v_out_319501.awb") / 1000

					if var_305_29 + var_305_21 > arg_302_1.duration_ then
						arg_302_1.duration_ = var_305_29 + var_305_21
					end

					if var_305_24.prefab_name ~= "" and arg_302_1.actors_[var_305_24.prefab_name] ~= nil then
						local var_305_30 = LuaForUtil.PlayVoiceWithCriLipsync(arg_302_1.actors_[var_305_24.prefab_name].transform, "story_v_out_319501", "319501073", "story_v_out_319501.awb")

						arg_302_1:RecordAudio("319501073", var_305_30)
						arg_302_1:RecordAudio("319501073", var_305_30)
					else
						arg_302_1:AudioAction("play", "voice", "story_v_out_319501", "319501073", "story_v_out_319501.awb")
					end

					arg_302_1:RecordHistoryTalkVoice("story_v_out_319501", "319501073", "story_v_out_319501.awb")
				end

				arg_302_1:RecordContent(arg_302_1.text_.text)
			end

			local var_305_31 = math.max(var_305_22, arg_302_1.talkMaxDuration)

			if var_305_21 <= arg_302_1.time_ and arg_302_1.time_ < var_305_21 + var_305_31 then
				arg_302_1.typewritter.percent = (arg_302_1.time_ - var_305_21) / var_305_31

				arg_302_1.typewritter:SetDirty()
			end

			if arg_302_1.time_ >= var_305_21 + var_305_31 and arg_302_1.time_ < var_305_21 + var_305_31 + arg_305_0 then
				arg_302_1.typewritter.percent = 1

				arg_302_1.typewritter:SetDirty()
				arg_302_1:ShowNextGo(true)
			end
		end

		arg_302_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1084ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_302_1:InitPlayNodeList()
	end,
	Play319501074 = function(arg_306_0, arg_306_1)
		arg_306_1.time_ = 0
		arg_306_1.frameCnt_ = 0
		arg_306_1.state_ = "playing"
		arg_306_1.curTalkId_ = 319501074
		arg_306_1.duration_ = 6.67

		local var_306_0 = {
			zh = 3.266,
			ja = 6.666
		}
		local var_306_1 = manager.audio:GetLocalizationFlag()

		if var_306_0[var_306_1] ~= nil then
			arg_306_1.duration_ = var_306_0[var_306_1]
		end

		SetActive(arg_306_1.tipsGo_, false)

		function arg_306_1.onSingleLineFinish_()
			arg_306_1.onSingleLineUpdate_ = nil
			arg_306_1.onSingleLineFinish_ = nil
			arg_306_1.state_ = "waiting"
		end

		function arg_306_1.playNext_(arg_308_0)
			if arg_308_0 == 1 then
				arg_306_0:Play319501075(arg_306_1)
			end
		end

		function arg_306_1.onSingleLineUpdate_(arg_309_0)
			local var_309_0 = arg_306_1.actors_["10068ui_story"]
			local var_309_1 = 0

			if var_309_1 < arg_306_1.time_ and arg_306_1.time_ <= var_309_1 + arg_309_0 and not isNil(var_309_0) and arg_306_1.var_.characterEffect10068ui_story == nil then
				arg_306_1.var_.characterEffect10068ui_story = var_309_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_309_2 = 0.200000002980232

			if var_309_1 <= arg_306_1.time_ and arg_306_1.time_ < var_309_1 + var_309_2 and not isNil(var_309_0) then
				local var_309_3 = (arg_306_1.time_ - var_309_1) / var_309_2

				if arg_306_1.var_.characterEffect10068ui_story and not isNil(var_309_0) then
					arg_306_1.var_.characterEffect10068ui_story.fillFlat = false
				end
			end

			if arg_306_1.time_ >= var_309_1 + var_309_2 and arg_306_1.time_ < var_309_1 + var_309_2 + arg_309_0 and not isNil(var_309_0) and arg_306_1.var_.characterEffect10068ui_story then
				arg_306_1.var_.characterEffect10068ui_story.fillFlat = false
			end

			local var_309_4 = 0

			if var_309_4 < arg_306_1.time_ and arg_306_1.time_ <= var_309_4 + arg_309_0 then
				arg_306_1:PlayTimeline("10068ui_story", "StoryTimeline/CharAction/story10068/story10068action/10068action1_1")
			end

			local var_309_5 = 0

			if var_309_5 < arg_306_1.time_ and arg_306_1.time_ <= var_309_5 + arg_309_0 then
				arg_306_1:PlayTimeline("10068ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3201cva")
			end

			local var_309_6 = arg_306_1.actors_["1084ui_story"]
			local var_309_7 = 0

			if var_309_7 < arg_306_1.time_ and arg_306_1.time_ <= var_309_7 + arg_309_0 and not isNil(var_309_6) and arg_306_1.var_.characterEffect1084ui_story == nil then
				arg_306_1.var_.characterEffect1084ui_story = var_309_6:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_309_8 = 0.200000002980232

			if var_309_7 <= arg_306_1.time_ and arg_306_1.time_ < var_309_7 + var_309_8 and not isNil(var_309_6) then
				local var_309_9 = (arg_306_1.time_ - var_309_7) / var_309_8

				if arg_306_1.var_.characterEffect1084ui_story and not isNil(var_309_6) then
					local var_309_10 = Mathf.Lerp(0, 0.5, var_309_9)

					arg_306_1.var_.characterEffect1084ui_story.fillFlat = true
					arg_306_1.var_.characterEffect1084ui_story.fillRatio = var_309_10
				end
			end

			if arg_306_1.time_ >= var_309_7 + var_309_8 and arg_306_1.time_ < var_309_7 + var_309_8 + arg_309_0 and not isNil(var_309_6) and arg_306_1.var_.characterEffect1084ui_story then
				local var_309_11 = 0.5

				arg_306_1.var_.characterEffect1084ui_story.fillFlat = true
				arg_306_1.var_.characterEffect1084ui_story.fillRatio = var_309_11
			end

			local var_309_12 = 0
			local var_309_13 = 0.325

			if var_309_12 < arg_306_1.time_ and arg_306_1.time_ <= var_309_12 + arg_309_0 then
				arg_306_1.talkMaxDuration = 0
				arg_306_1.dialogCg_.alpha = 1

				arg_306_1.dialog_:SetActive(true)
				SetActive(arg_306_1.leftNameGo_, true)

				local var_309_14 = arg_306_1:FormatText(StoryNameCfg[697].name)

				arg_306_1.leftNameTxt_.text = var_309_14

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_306_1.leftNameTxt_.transform)

				arg_306_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_306_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_306_1:RecordName(arg_306_1.leftNameTxt_.text)
				SetActive(arg_306_1.iconTrs_.gameObject, false)
				arg_306_1.callingController_:SetSelectedState("normal")

				local var_309_15 = arg_306_1:GetWordFromCfg(319501074)
				local var_309_16 = arg_306_1:FormatText(var_309_15.content)

				arg_306_1.text_.text = var_309_16

				LuaForUtil.ClearLinePrefixSymbol(arg_306_1.text_)

				local var_309_17 = 13
				local var_309_18 = utf8.len(var_309_16)
				local var_309_19 = var_309_17 <= 0 and var_309_13 or var_309_13 * (var_309_18 / var_309_17)

				if var_309_19 > 0 and var_309_13 < var_309_19 then
					arg_306_1.talkMaxDuration = var_309_19

					if var_309_19 + var_309_12 > arg_306_1.duration_ then
						arg_306_1.duration_ = var_309_19 + var_309_12
					end
				end

				arg_306_1.text_.text = var_309_16
				arg_306_1.typewritter.percent = 0

				arg_306_1.typewritter:SetDirty()
				arg_306_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_319501", "319501074", "story_v_out_319501.awb") ~= 0 then
					local var_309_20 = manager.audio:GetVoiceLength("story_v_out_319501", "319501074", "story_v_out_319501.awb") / 1000

					if var_309_20 + var_309_12 > arg_306_1.duration_ then
						arg_306_1.duration_ = var_309_20 + var_309_12
					end

					if var_309_15.prefab_name ~= "" and arg_306_1.actors_[var_309_15.prefab_name] ~= nil then
						local var_309_21 = LuaForUtil.PlayVoiceWithCriLipsync(arg_306_1.actors_[var_309_15.prefab_name].transform, "story_v_out_319501", "319501074", "story_v_out_319501.awb")

						arg_306_1:RecordAudio("319501074", var_309_21)
						arg_306_1:RecordAudio("319501074", var_309_21)
					else
						arg_306_1:AudioAction("play", "voice", "story_v_out_319501", "319501074", "story_v_out_319501.awb")
					end

					arg_306_1:RecordHistoryTalkVoice("story_v_out_319501", "319501074", "story_v_out_319501.awb")
				end

				arg_306_1:RecordContent(arg_306_1.text_.text)
			end

			local var_309_22 = math.max(var_309_13, arg_306_1.talkMaxDuration)

			if var_309_12 <= arg_306_1.time_ and arg_306_1.time_ < var_309_12 + var_309_22 then
				arg_306_1.typewritter.percent = (arg_306_1.time_ - var_309_12) / var_309_22

				arg_306_1.typewritter:SetDirty()
			end

			if arg_306_1.time_ >= var_309_12 + var_309_22 and arg_306_1.time_ < var_309_12 + var_309_22 + arg_309_0 then
				arg_306_1.typewritter.percent = 1

				arg_306_1.typewritter:SetDirty()
				arg_306_1:ShowNextGo(true)
			end
		end

		arg_306_1.nodeConfigList_ = {}

		arg_306_1:InitPlayNodeList()
	end,
	Play319501075 = function(arg_310_0, arg_310_1)
		arg_310_1.time_ = 0
		arg_310_1.frameCnt_ = 0
		arg_310_1.state_ = "playing"
		arg_310_1.curTalkId_ = 319501075
		arg_310_1.duration_ = 9.93

		local var_310_0 = {
			zh = 5.733,
			ja = 9.933
		}
		local var_310_1 = manager.audio:GetLocalizationFlag()

		if var_310_0[var_310_1] ~= nil then
			arg_310_1.duration_ = var_310_0[var_310_1]
		end

		SetActive(arg_310_1.tipsGo_, false)

		function arg_310_1.onSingleLineFinish_()
			arg_310_1.onSingleLineUpdate_ = nil
			arg_310_1.onSingleLineFinish_ = nil
			arg_310_1.state_ = "waiting"
		end

		function arg_310_1.playNext_(arg_312_0)
			if arg_312_0 == 1 then
				arg_310_0:Play319501076(arg_310_1)
			end
		end

		function arg_310_1.onSingleLineUpdate_(arg_313_0)
			local var_313_0 = arg_310_1.actors_["10068ui_story"]
			local var_313_1 = 0

			if var_313_1 < arg_310_1.time_ and arg_310_1.time_ <= var_313_1 + arg_313_0 and not isNil(var_313_0) and arg_310_1.var_.characterEffect10068ui_story == nil then
				arg_310_1.var_.characterEffect10068ui_story = var_313_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_313_2 = 0.200000002980232

			if var_313_1 <= arg_310_1.time_ and arg_310_1.time_ < var_313_1 + var_313_2 and not isNil(var_313_0) then
				local var_313_3 = (arg_310_1.time_ - var_313_1) / var_313_2

				if arg_310_1.var_.characterEffect10068ui_story and not isNil(var_313_0) then
					local var_313_4 = Mathf.Lerp(0, 0.5, var_313_3)

					arg_310_1.var_.characterEffect10068ui_story.fillFlat = true
					arg_310_1.var_.characterEffect10068ui_story.fillRatio = var_313_4
				end
			end

			if arg_310_1.time_ >= var_313_1 + var_313_2 and arg_310_1.time_ < var_313_1 + var_313_2 + arg_313_0 and not isNil(var_313_0) and arg_310_1.var_.characterEffect10068ui_story then
				local var_313_5 = 0.5

				arg_310_1.var_.characterEffect10068ui_story.fillFlat = true
				arg_310_1.var_.characterEffect10068ui_story.fillRatio = var_313_5
			end

			local var_313_6 = arg_310_1.actors_["1084ui_story"]
			local var_313_7 = 0

			if var_313_7 < arg_310_1.time_ and arg_310_1.time_ <= var_313_7 + arg_313_0 and not isNil(var_313_6) and arg_310_1.var_.characterEffect1084ui_story == nil then
				arg_310_1.var_.characterEffect1084ui_story = var_313_6:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_313_8 = 0.200000002980232

			if var_313_7 <= arg_310_1.time_ and arg_310_1.time_ < var_313_7 + var_313_8 and not isNil(var_313_6) then
				local var_313_9 = (arg_310_1.time_ - var_313_7) / var_313_8

				if arg_310_1.var_.characterEffect1084ui_story and not isNil(var_313_6) then
					arg_310_1.var_.characterEffect1084ui_story.fillFlat = false
				end
			end

			if arg_310_1.time_ >= var_313_7 + var_313_8 and arg_310_1.time_ < var_313_7 + var_313_8 + arg_313_0 and not isNil(var_313_6) and arg_310_1.var_.characterEffect1084ui_story then
				arg_310_1.var_.characterEffect1084ui_story.fillFlat = false
			end

			local var_313_10 = 0
			local var_313_11 = 0.7

			if var_313_10 < arg_310_1.time_ and arg_310_1.time_ <= var_313_10 + arg_313_0 then
				arg_310_1.talkMaxDuration = 0
				arg_310_1.dialogCg_.alpha = 1

				arg_310_1.dialog_:SetActive(true)
				SetActive(arg_310_1.leftNameGo_, true)

				local var_313_12 = arg_310_1:FormatText(StoryNameCfg[6].name)

				arg_310_1.leftNameTxt_.text = var_313_12

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_310_1.leftNameTxt_.transform)

				arg_310_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_310_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_310_1:RecordName(arg_310_1.leftNameTxt_.text)
				SetActive(arg_310_1.iconTrs_.gameObject, false)
				arg_310_1.callingController_:SetSelectedState("normal")

				local var_313_13 = arg_310_1:GetWordFromCfg(319501075)
				local var_313_14 = arg_310_1:FormatText(var_313_13.content)

				arg_310_1.text_.text = var_313_14

				LuaForUtil.ClearLinePrefixSymbol(arg_310_1.text_)

				local var_313_15 = 28
				local var_313_16 = utf8.len(var_313_14)
				local var_313_17 = var_313_15 <= 0 and var_313_11 or var_313_11 * (var_313_16 / var_313_15)

				if var_313_17 > 0 and var_313_11 < var_313_17 then
					arg_310_1.talkMaxDuration = var_313_17

					if var_313_17 + var_313_10 > arg_310_1.duration_ then
						arg_310_1.duration_ = var_313_17 + var_313_10
					end
				end

				arg_310_1.text_.text = var_313_14
				arg_310_1.typewritter.percent = 0

				arg_310_1.typewritter:SetDirty()
				arg_310_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_319501", "319501075", "story_v_out_319501.awb") ~= 0 then
					local var_313_18 = manager.audio:GetVoiceLength("story_v_out_319501", "319501075", "story_v_out_319501.awb") / 1000

					if var_313_18 + var_313_10 > arg_310_1.duration_ then
						arg_310_1.duration_ = var_313_18 + var_313_10
					end

					if var_313_13.prefab_name ~= "" and arg_310_1.actors_[var_313_13.prefab_name] ~= nil then
						local var_313_19 = LuaForUtil.PlayVoiceWithCriLipsync(arg_310_1.actors_[var_313_13.prefab_name].transform, "story_v_out_319501", "319501075", "story_v_out_319501.awb")

						arg_310_1:RecordAudio("319501075", var_313_19)
						arg_310_1:RecordAudio("319501075", var_313_19)
					else
						arg_310_1:AudioAction("play", "voice", "story_v_out_319501", "319501075", "story_v_out_319501.awb")
					end

					arg_310_1:RecordHistoryTalkVoice("story_v_out_319501", "319501075", "story_v_out_319501.awb")
				end

				arg_310_1:RecordContent(arg_310_1.text_.text)
			end

			local var_313_20 = math.max(var_313_11, arg_310_1.talkMaxDuration)

			if var_313_10 <= arg_310_1.time_ and arg_310_1.time_ < var_313_10 + var_313_20 then
				arg_310_1.typewritter.percent = (arg_310_1.time_ - var_313_10) / var_313_20

				arg_310_1.typewritter:SetDirty()
			end

			if arg_310_1.time_ >= var_313_10 + var_313_20 and arg_310_1.time_ < var_313_10 + var_313_20 + arg_313_0 then
				arg_310_1.typewritter.percent = 1

				arg_310_1.typewritter:SetDirty()
				arg_310_1:ShowNextGo(true)
			end
		end

		arg_310_1.nodeConfigList_ = {}

		arg_310_1:InitPlayNodeList()
	end,
	Play319501076 = function(arg_314_0, arg_314_1)
		arg_314_1.time_ = 0
		arg_314_1.frameCnt_ = 0
		arg_314_1.state_ = "playing"
		arg_314_1.curTalkId_ = 319501076
		arg_314_1.duration_ = 2.27

		local var_314_0 = {
			zh = 1.6,
			ja = 2.266
		}
		local var_314_1 = manager.audio:GetLocalizationFlag()

		if var_314_0[var_314_1] ~= nil then
			arg_314_1.duration_ = var_314_0[var_314_1]
		end

		SetActive(arg_314_1.tipsGo_, false)

		function arg_314_1.onSingleLineFinish_()
			arg_314_1.onSingleLineUpdate_ = nil
			arg_314_1.onSingleLineFinish_ = nil
			arg_314_1.state_ = "waiting"
		end

		function arg_314_1.playNext_(arg_316_0)
			if arg_316_0 == 1 then
				arg_314_0:Play319501077(arg_314_1)
			end
		end

		function arg_314_1.onSingleLineUpdate_(arg_317_0)
			local var_317_0 = arg_314_1.actors_["10068ui_story"]
			local var_317_1 = 0

			if var_317_1 < arg_314_1.time_ and arg_314_1.time_ <= var_317_1 + arg_317_0 and not isNil(var_317_0) and arg_314_1.var_.characterEffect10068ui_story == nil then
				arg_314_1.var_.characterEffect10068ui_story = var_317_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_317_2 = 0.200000002980232

			if var_317_1 <= arg_314_1.time_ and arg_314_1.time_ < var_317_1 + var_317_2 and not isNil(var_317_0) then
				local var_317_3 = (arg_314_1.time_ - var_317_1) / var_317_2

				if arg_314_1.var_.characterEffect10068ui_story and not isNil(var_317_0) then
					arg_314_1.var_.characterEffect10068ui_story.fillFlat = false
				end
			end

			if arg_314_1.time_ >= var_317_1 + var_317_2 and arg_314_1.time_ < var_317_1 + var_317_2 + arg_317_0 and not isNil(var_317_0) and arg_314_1.var_.characterEffect10068ui_story then
				arg_314_1.var_.characterEffect10068ui_story.fillFlat = false
			end

			local var_317_4 = arg_314_1.actors_["1084ui_story"]
			local var_317_5 = 0

			if var_317_5 < arg_314_1.time_ and arg_314_1.time_ <= var_317_5 + arg_317_0 and not isNil(var_317_4) and arg_314_1.var_.characterEffect1084ui_story == nil then
				arg_314_1.var_.characterEffect1084ui_story = var_317_4:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_317_6 = 0.200000002980232

			if var_317_5 <= arg_314_1.time_ and arg_314_1.time_ < var_317_5 + var_317_6 and not isNil(var_317_4) then
				local var_317_7 = (arg_314_1.time_ - var_317_5) / var_317_6

				if arg_314_1.var_.characterEffect1084ui_story and not isNil(var_317_4) then
					local var_317_8 = Mathf.Lerp(0, 0.5, var_317_7)

					arg_314_1.var_.characterEffect1084ui_story.fillFlat = true
					arg_314_1.var_.characterEffect1084ui_story.fillRatio = var_317_8
				end
			end

			if arg_314_1.time_ >= var_317_5 + var_317_6 and arg_314_1.time_ < var_317_5 + var_317_6 + arg_317_0 and not isNil(var_317_4) and arg_314_1.var_.characterEffect1084ui_story then
				local var_317_9 = 0.5

				arg_314_1.var_.characterEffect1084ui_story.fillFlat = true
				arg_314_1.var_.characterEffect1084ui_story.fillRatio = var_317_9
			end

			local var_317_10 = 0
			local var_317_11 = 0.1

			if var_317_10 < arg_314_1.time_ and arg_314_1.time_ <= var_317_10 + arg_317_0 then
				arg_314_1.talkMaxDuration = 0
				arg_314_1.dialogCg_.alpha = 1

				arg_314_1.dialog_:SetActive(true)
				SetActive(arg_314_1.leftNameGo_, true)

				local var_317_12 = arg_314_1:FormatText(StoryNameCfg[697].name)

				arg_314_1.leftNameTxt_.text = var_317_12

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_314_1.leftNameTxt_.transform)

				arg_314_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_314_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_314_1:RecordName(arg_314_1.leftNameTxt_.text)
				SetActive(arg_314_1.iconTrs_.gameObject, false)
				arg_314_1.callingController_:SetSelectedState("normal")

				local var_317_13 = arg_314_1:GetWordFromCfg(319501076)
				local var_317_14 = arg_314_1:FormatText(var_317_13.content)

				arg_314_1.text_.text = var_317_14

				LuaForUtil.ClearLinePrefixSymbol(arg_314_1.text_)

				local var_317_15 = 4
				local var_317_16 = utf8.len(var_317_14)
				local var_317_17 = var_317_15 <= 0 and var_317_11 or var_317_11 * (var_317_16 / var_317_15)

				if var_317_17 > 0 and var_317_11 < var_317_17 then
					arg_314_1.talkMaxDuration = var_317_17

					if var_317_17 + var_317_10 > arg_314_1.duration_ then
						arg_314_1.duration_ = var_317_17 + var_317_10
					end
				end

				arg_314_1.text_.text = var_317_14
				arg_314_1.typewritter.percent = 0

				arg_314_1.typewritter:SetDirty()
				arg_314_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_319501", "319501076", "story_v_out_319501.awb") ~= 0 then
					local var_317_18 = manager.audio:GetVoiceLength("story_v_out_319501", "319501076", "story_v_out_319501.awb") / 1000

					if var_317_18 + var_317_10 > arg_314_1.duration_ then
						arg_314_1.duration_ = var_317_18 + var_317_10
					end

					if var_317_13.prefab_name ~= "" and arg_314_1.actors_[var_317_13.prefab_name] ~= nil then
						local var_317_19 = LuaForUtil.PlayVoiceWithCriLipsync(arg_314_1.actors_[var_317_13.prefab_name].transform, "story_v_out_319501", "319501076", "story_v_out_319501.awb")

						arg_314_1:RecordAudio("319501076", var_317_19)
						arg_314_1:RecordAudio("319501076", var_317_19)
					else
						arg_314_1:AudioAction("play", "voice", "story_v_out_319501", "319501076", "story_v_out_319501.awb")
					end

					arg_314_1:RecordHistoryTalkVoice("story_v_out_319501", "319501076", "story_v_out_319501.awb")
				end

				arg_314_1:RecordContent(arg_314_1.text_.text)
			end

			local var_317_20 = math.max(var_317_11, arg_314_1.talkMaxDuration)

			if var_317_10 <= arg_314_1.time_ and arg_314_1.time_ < var_317_10 + var_317_20 then
				arg_314_1.typewritter.percent = (arg_314_1.time_ - var_317_10) / var_317_20

				arg_314_1.typewritter:SetDirty()
			end

			if arg_314_1.time_ >= var_317_10 + var_317_20 and arg_314_1.time_ < var_317_10 + var_317_20 + arg_317_0 then
				arg_314_1.typewritter.percent = 1

				arg_314_1.typewritter:SetDirty()
				arg_314_1:ShowNextGo(true)
			end
		end

		arg_314_1.nodeConfigList_ = {}

		arg_314_1:InitPlayNodeList()
	end,
	Play319501077 = function(arg_318_0, arg_318_1)
		arg_318_1.time_ = 0
		arg_318_1.frameCnt_ = 0
		arg_318_1.state_ = "playing"
		arg_318_1.curTalkId_ = 319501077
		arg_318_1.duration_ = 5

		SetActive(arg_318_1.tipsGo_, false)

		function arg_318_1.onSingleLineFinish_()
			arg_318_1.onSingleLineUpdate_ = nil
			arg_318_1.onSingleLineFinish_ = nil
			arg_318_1.state_ = "waiting"
		end

		function arg_318_1.playNext_(arg_320_0)
			if arg_320_0 == 1 then
				arg_318_0:Play319501078(arg_318_1)
			end
		end

		function arg_318_1.onSingleLineUpdate_(arg_321_0)
			local var_321_0 = arg_318_1.actors_["10068ui_story"]
			local var_321_1 = 0

			if var_321_1 < arg_318_1.time_ and arg_318_1.time_ <= var_321_1 + arg_321_0 and not isNil(var_321_0) and arg_318_1.var_.characterEffect10068ui_story == nil then
				arg_318_1.var_.characterEffect10068ui_story = var_321_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_321_2 = 0.200000002980232

			if var_321_1 <= arg_318_1.time_ and arg_318_1.time_ < var_321_1 + var_321_2 and not isNil(var_321_0) then
				local var_321_3 = (arg_318_1.time_ - var_321_1) / var_321_2

				if arg_318_1.var_.characterEffect10068ui_story and not isNil(var_321_0) then
					local var_321_4 = Mathf.Lerp(0, 0.5, var_321_3)

					arg_318_1.var_.characterEffect10068ui_story.fillFlat = true
					arg_318_1.var_.characterEffect10068ui_story.fillRatio = var_321_4
				end
			end

			if arg_318_1.time_ >= var_321_1 + var_321_2 and arg_318_1.time_ < var_321_1 + var_321_2 + arg_321_0 and not isNil(var_321_0) and arg_318_1.var_.characterEffect10068ui_story then
				local var_321_5 = 0.5

				arg_318_1.var_.characterEffect10068ui_story.fillFlat = true
				arg_318_1.var_.characterEffect10068ui_story.fillRatio = var_321_5
			end

			local var_321_6 = 0
			local var_321_7 = 1.05

			if var_321_6 < arg_318_1.time_ and arg_318_1.time_ <= var_321_6 + arg_321_0 then
				arg_318_1.talkMaxDuration = 0
				arg_318_1.dialogCg_.alpha = 1

				arg_318_1.dialog_:SetActive(true)
				SetActive(arg_318_1.leftNameGo_, false)

				arg_318_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_318_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_318_1:RecordName(arg_318_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_318_1.iconTrs_.gameObject, false)
				arg_318_1.callingController_:SetSelectedState("normal")

				local var_321_8 = arg_318_1:GetWordFromCfg(319501077)
				local var_321_9 = arg_318_1:FormatText(var_321_8.content)

				arg_318_1.text_.text = var_321_9

				LuaForUtil.ClearLinePrefixSymbol(arg_318_1.text_)

				local var_321_10 = 42
				local var_321_11 = utf8.len(var_321_9)
				local var_321_12 = var_321_10 <= 0 and var_321_7 or var_321_7 * (var_321_11 / var_321_10)

				if var_321_12 > 0 and var_321_7 < var_321_12 then
					arg_318_1.talkMaxDuration = var_321_12

					if var_321_12 + var_321_6 > arg_318_1.duration_ then
						arg_318_1.duration_ = var_321_12 + var_321_6
					end
				end

				arg_318_1.text_.text = var_321_9
				arg_318_1.typewritter.percent = 0

				arg_318_1.typewritter:SetDirty()
				arg_318_1:ShowNextGo(false)
				arg_318_1:RecordContent(arg_318_1.text_.text)
			end

			local var_321_13 = math.max(var_321_7, arg_318_1.talkMaxDuration)

			if var_321_6 <= arg_318_1.time_ and arg_318_1.time_ < var_321_6 + var_321_13 then
				arg_318_1.typewritter.percent = (arg_318_1.time_ - var_321_6) / var_321_13

				arg_318_1.typewritter:SetDirty()
			end

			if arg_318_1.time_ >= var_321_6 + var_321_13 and arg_318_1.time_ < var_321_6 + var_321_13 + arg_321_0 then
				arg_318_1.typewritter.percent = 1

				arg_318_1.typewritter:SetDirty()
				arg_318_1:ShowNextGo(true)
			end
		end

		arg_318_1.nodeConfigList_ = {}

		arg_318_1:InitPlayNodeList()
	end,
	Play319501078 = function(arg_322_0, arg_322_1)
		arg_322_1.time_ = 0
		arg_322_1.frameCnt_ = 0
		arg_322_1.state_ = "playing"
		arg_322_1.curTalkId_ = 319501078
		arg_322_1.duration_ = 5

		SetActive(arg_322_1.tipsGo_, false)

		function arg_322_1.onSingleLineFinish_()
			arg_322_1.onSingleLineUpdate_ = nil
			arg_322_1.onSingleLineFinish_ = nil
			arg_322_1.state_ = "waiting"
		end

		function arg_322_1.playNext_(arg_324_0)
			if arg_324_0 == 1 then
				arg_322_0:Play319501079(arg_322_1)
			end
		end

		function arg_322_1.onSingleLineUpdate_(arg_325_0)
			local var_325_0 = 0
			local var_325_1 = 1.125

			if var_325_0 < arg_322_1.time_ and arg_322_1.time_ <= var_325_0 + arg_325_0 then
				arg_322_1.talkMaxDuration = 0
				arg_322_1.dialogCg_.alpha = 1

				arg_322_1.dialog_:SetActive(true)
				SetActive(arg_322_1.leftNameGo_, false)

				arg_322_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_322_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_322_1:RecordName(arg_322_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_322_1.iconTrs_.gameObject, false)
				arg_322_1.callingController_:SetSelectedState("normal")

				local var_325_2 = arg_322_1:GetWordFromCfg(319501078)
				local var_325_3 = arg_322_1:FormatText(var_325_2.content)

				arg_322_1.text_.text = var_325_3

				LuaForUtil.ClearLinePrefixSymbol(arg_322_1.text_)

				local var_325_4 = 45
				local var_325_5 = utf8.len(var_325_3)
				local var_325_6 = var_325_4 <= 0 and var_325_1 or var_325_1 * (var_325_5 / var_325_4)

				if var_325_6 > 0 and var_325_1 < var_325_6 then
					arg_322_1.talkMaxDuration = var_325_6

					if var_325_6 + var_325_0 > arg_322_1.duration_ then
						arg_322_1.duration_ = var_325_6 + var_325_0
					end
				end

				arg_322_1.text_.text = var_325_3
				arg_322_1.typewritter.percent = 0

				arg_322_1.typewritter:SetDirty()
				arg_322_1:ShowNextGo(false)
				arg_322_1:RecordContent(arg_322_1.text_.text)
			end

			local var_325_7 = math.max(var_325_1, arg_322_1.talkMaxDuration)

			if var_325_0 <= arg_322_1.time_ and arg_322_1.time_ < var_325_0 + var_325_7 then
				arg_322_1.typewritter.percent = (arg_322_1.time_ - var_325_0) / var_325_7

				arg_322_1.typewritter:SetDirty()
			end

			if arg_322_1.time_ >= var_325_0 + var_325_7 and arg_322_1.time_ < var_325_0 + var_325_7 + arg_325_0 then
				arg_322_1.typewritter.percent = 1

				arg_322_1.typewritter:SetDirty()
				arg_322_1:ShowNextGo(true)
			end
		end

		arg_322_1.nodeConfigList_ = {}

		arg_322_1:InitPlayNodeList()
	end,
	Play319501079 = function(arg_326_0, arg_326_1)
		arg_326_1.time_ = 0
		arg_326_1.frameCnt_ = 0
		arg_326_1.state_ = "playing"
		arg_326_1.curTalkId_ = 319501079
		arg_326_1.duration_ = 5

		SetActive(arg_326_1.tipsGo_, false)

		function arg_326_1.onSingleLineFinish_()
			arg_326_1.onSingleLineUpdate_ = nil
			arg_326_1.onSingleLineFinish_ = nil
			arg_326_1.state_ = "waiting"
		end

		function arg_326_1.playNext_(arg_328_0)
			if arg_328_0 == 1 then
				arg_326_0:Play319501080(arg_326_1)
			end
		end

		function arg_326_1.onSingleLineUpdate_(arg_329_0)
			local var_329_0 = 0
			local var_329_1 = 0.925

			if var_329_0 < arg_326_1.time_ and arg_326_1.time_ <= var_329_0 + arg_329_0 then
				arg_326_1.talkMaxDuration = 0
				arg_326_1.dialogCg_.alpha = 1

				arg_326_1.dialog_:SetActive(true)
				SetActive(arg_326_1.leftNameGo_, false)

				arg_326_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_326_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_326_1:RecordName(arg_326_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_326_1.iconTrs_.gameObject, false)
				arg_326_1.callingController_:SetSelectedState("normal")

				local var_329_2 = arg_326_1:GetWordFromCfg(319501079)
				local var_329_3 = arg_326_1:FormatText(var_329_2.content)

				arg_326_1.text_.text = var_329_3

				LuaForUtil.ClearLinePrefixSymbol(arg_326_1.text_)

				local var_329_4 = 37
				local var_329_5 = utf8.len(var_329_3)
				local var_329_6 = var_329_4 <= 0 and var_329_1 or var_329_1 * (var_329_5 / var_329_4)

				if var_329_6 > 0 and var_329_1 < var_329_6 then
					arg_326_1.talkMaxDuration = var_329_6

					if var_329_6 + var_329_0 > arg_326_1.duration_ then
						arg_326_1.duration_ = var_329_6 + var_329_0
					end
				end

				arg_326_1.text_.text = var_329_3
				arg_326_1.typewritter.percent = 0

				arg_326_1.typewritter:SetDirty()
				arg_326_1:ShowNextGo(false)
				arg_326_1:RecordContent(arg_326_1.text_.text)
			end

			local var_329_7 = math.max(var_329_1, arg_326_1.talkMaxDuration)

			if var_329_0 <= arg_326_1.time_ and arg_326_1.time_ < var_329_0 + var_329_7 then
				arg_326_1.typewritter.percent = (arg_326_1.time_ - var_329_0) / var_329_7

				arg_326_1.typewritter:SetDirty()
			end

			if arg_326_1.time_ >= var_329_0 + var_329_7 and arg_326_1.time_ < var_329_0 + var_329_7 + arg_329_0 then
				arg_326_1.typewritter.percent = 1

				arg_326_1.typewritter:SetDirty()
				arg_326_1:ShowNextGo(true)
			end
		end

		arg_326_1.nodeConfigList_ = {}

		arg_326_1:InitPlayNodeList()
	end,
	Play319501080 = function(arg_330_0, arg_330_1)
		arg_330_1.time_ = 0
		arg_330_1.frameCnt_ = 0
		arg_330_1.state_ = "playing"
		arg_330_1.curTalkId_ = 319501080
		arg_330_1.duration_ = 5

		SetActive(arg_330_1.tipsGo_, false)

		function arg_330_1.onSingleLineFinish_()
			arg_330_1.onSingleLineUpdate_ = nil
			arg_330_1.onSingleLineFinish_ = nil
			arg_330_1.state_ = "waiting"
		end

		function arg_330_1.playNext_(arg_332_0)
			if arg_332_0 == 1 then
				arg_330_0:Play319501081(arg_330_1)
			end
		end

		function arg_330_1.onSingleLineUpdate_(arg_333_0)
			local var_333_0 = 0
			local var_333_1 = 0.95

			if var_333_0 < arg_330_1.time_ and arg_330_1.time_ <= var_333_0 + arg_333_0 then
				arg_330_1.talkMaxDuration = 0
				arg_330_1.dialogCg_.alpha = 1

				arg_330_1.dialog_:SetActive(true)
				SetActive(arg_330_1.leftNameGo_, false)

				arg_330_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_330_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_330_1:RecordName(arg_330_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_330_1.iconTrs_.gameObject, false)
				arg_330_1.callingController_:SetSelectedState("normal")

				local var_333_2 = arg_330_1:GetWordFromCfg(319501080)
				local var_333_3 = arg_330_1:FormatText(var_333_2.content)

				arg_330_1.text_.text = var_333_3

				LuaForUtil.ClearLinePrefixSymbol(arg_330_1.text_)

				local var_333_4 = 38
				local var_333_5 = utf8.len(var_333_3)
				local var_333_6 = var_333_4 <= 0 and var_333_1 or var_333_1 * (var_333_5 / var_333_4)

				if var_333_6 > 0 and var_333_1 < var_333_6 then
					arg_330_1.talkMaxDuration = var_333_6

					if var_333_6 + var_333_0 > arg_330_1.duration_ then
						arg_330_1.duration_ = var_333_6 + var_333_0
					end
				end

				arg_330_1.text_.text = var_333_3
				arg_330_1.typewritter.percent = 0

				arg_330_1.typewritter:SetDirty()
				arg_330_1:ShowNextGo(false)
				arg_330_1:RecordContent(arg_330_1.text_.text)
			end

			local var_333_7 = math.max(var_333_1, arg_330_1.talkMaxDuration)

			if var_333_0 <= arg_330_1.time_ and arg_330_1.time_ < var_333_0 + var_333_7 then
				arg_330_1.typewritter.percent = (arg_330_1.time_ - var_333_0) / var_333_7

				arg_330_1.typewritter:SetDirty()
			end

			if arg_330_1.time_ >= var_333_0 + var_333_7 and arg_330_1.time_ < var_333_0 + var_333_7 + arg_333_0 then
				arg_330_1.typewritter.percent = 1

				arg_330_1.typewritter:SetDirty()
				arg_330_1:ShowNextGo(true)
			end
		end

		arg_330_1.nodeConfigList_ = {}

		arg_330_1:InitPlayNodeList()
	end,
	Play319501081 = function(arg_334_0, arg_334_1)
		arg_334_1.time_ = 0
		arg_334_1.frameCnt_ = 0
		arg_334_1.state_ = "playing"
		arg_334_1.curTalkId_ = 319501081
		arg_334_1.duration_ = 6.73

		local var_334_0 = {
			zh = 5.5,
			ja = 6.733
		}
		local var_334_1 = manager.audio:GetLocalizationFlag()

		if var_334_0[var_334_1] ~= nil then
			arg_334_1.duration_ = var_334_0[var_334_1]
		end

		SetActive(arg_334_1.tipsGo_, false)

		function arg_334_1.onSingleLineFinish_()
			arg_334_1.onSingleLineUpdate_ = nil
			arg_334_1.onSingleLineFinish_ = nil
			arg_334_1.state_ = "waiting"
		end

		function arg_334_1.playNext_(arg_336_0)
			if arg_336_0 == 1 then
				arg_334_0:Play319501082(arg_334_1)
			end
		end

		function arg_334_1.onSingleLineUpdate_(arg_337_0)
			local var_337_0 = "ML0105"

			if arg_334_1.bgs_[var_337_0] == nil then
				local var_337_1 = Object.Instantiate(arg_334_1.paintGo_)

				var_337_1:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. var_337_0)
				var_337_1.name = var_337_0
				var_337_1.transform.parent = arg_334_1.stage_.transform
				var_337_1.transform.localPosition = Vector3.New(0, 100, 0)
				arg_334_1.bgs_[var_337_0] = var_337_1
			end

			local var_337_2 = 0

			if var_337_2 < arg_334_1.time_ and arg_334_1.time_ <= var_337_2 + arg_337_0 then
				local var_337_3 = manager.ui.mainCamera.transform.localPosition
				local var_337_4 = Vector3.New(0, 0, 10) + Vector3.New(var_337_3.x, var_337_3.y, 0)
				local var_337_5 = arg_334_1.bgs_.ML0105

				var_337_5.transform.localPosition = var_337_4
				var_337_5.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_337_6 = var_337_5:GetComponent("SpriteRenderer")

				if var_337_6 and var_337_6.sprite then
					local var_337_7 = (var_337_5.transform.localPosition - var_337_3).z
					local var_337_8 = manager.ui.mainCameraCom_
					local var_337_9 = 2 * var_337_7 * Mathf.Tan(var_337_8.fieldOfView * 0.5 * Mathf.Deg2Rad)
					local var_337_10 = var_337_9 * var_337_8.aspect
					local var_337_11 = var_337_6.sprite.bounds.size.x
					local var_337_12 = var_337_6.sprite.bounds.size.y
					local var_337_13 = var_337_10 / var_337_11
					local var_337_14 = var_337_9 / var_337_12
					local var_337_15 = var_337_14 < var_337_13 and var_337_13 or var_337_14

					var_337_5.transform.localScale = Vector3.New(var_337_15, var_337_15, 0)
				end

				for iter_337_0, iter_337_1 in pairs(arg_334_1.bgs_) do
					if iter_337_0 ~= "ML0105" then
						iter_337_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_337_16 = 3

			if var_337_16 < arg_334_1.time_ and arg_334_1.time_ <= var_337_16 + arg_337_0 then
				arg_334_1.allBtn_.enabled = false
			end

			local var_337_17 = 0.3

			if arg_334_1.time_ >= var_337_16 + var_337_17 and arg_334_1.time_ < var_337_16 + var_337_17 + arg_337_0 then
				arg_334_1.allBtn_.enabled = true
			end

			local var_337_18 = 0

			if var_337_18 < arg_334_1.time_ and arg_334_1.time_ <= var_337_18 + arg_337_0 then
				arg_334_1.mask_.enabled = true
				arg_334_1.mask_.raycastTarget = true

				arg_334_1:SetGaussion(false)
			end

			local var_337_19 = 3

			if var_337_18 <= arg_334_1.time_ and arg_334_1.time_ < var_337_18 + var_337_19 then
				local var_337_20 = (arg_334_1.time_ - var_337_18) / var_337_19
				local var_337_21 = Color.New(1, 1, 1)

				var_337_21.a = Mathf.Lerp(1, 0, var_337_20)
				arg_334_1.mask_.color = var_337_21
			end

			if arg_334_1.time_ >= var_337_18 + var_337_19 and arg_334_1.time_ < var_337_18 + var_337_19 + arg_337_0 then
				local var_337_22 = Color.New(1, 1, 1)
				local var_337_23 = 0

				arg_334_1.mask_.enabled = false
				var_337_22.a = var_337_23
				arg_334_1.mask_.color = var_337_22
			end

			local var_337_24 = arg_334_1.actors_["10068ui_story"].transform
			local var_337_25 = 0

			if var_337_25 < arg_334_1.time_ and arg_334_1.time_ <= var_337_25 + arg_337_0 then
				arg_334_1.var_.moveOldPos10068ui_story = var_337_24.localPosition
			end

			local var_337_26 = 0.001

			if var_337_25 <= arg_334_1.time_ and arg_334_1.time_ < var_337_25 + var_337_26 then
				local var_337_27 = (arg_334_1.time_ - var_337_25) / var_337_26
				local var_337_28 = Vector3.New(0, 100, 0)

				var_337_24.localPosition = Vector3.Lerp(arg_334_1.var_.moveOldPos10068ui_story, var_337_28, var_337_27)

				local var_337_29 = manager.ui.mainCamera.transform.position - var_337_24.position

				var_337_24.forward = Vector3.New(var_337_29.x, var_337_29.y, var_337_29.z)

				local var_337_30 = var_337_24.localEulerAngles

				var_337_30.z = 0
				var_337_30.x = 0
				var_337_24.localEulerAngles = var_337_30
			end

			if arg_334_1.time_ >= var_337_25 + var_337_26 and arg_334_1.time_ < var_337_25 + var_337_26 + arg_337_0 then
				var_337_24.localPosition = Vector3.New(0, 100, 0)

				local var_337_31 = manager.ui.mainCamera.transform.position - var_337_24.position

				var_337_24.forward = Vector3.New(var_337_31.x, var_337_31.y, var_337_31.z)

				local var_337_32 = var_337_24.localEulerAngles

				var_337_32.z = 0
				var_337_32.x = 0
				var_337_24.localEulerAngles = var_337_32
			end

			local var_337_33 = arg_334_1.actors_["10068ui_story"]
			local var_337_34 = 0

			if var_337_34 < arg_334_1.time_ and arg_334_1.time_ <= var_337_34 + arg_337_0 and not isNil(var_337_33) and arg_334_1.var_.characterEffect10068ui_story == nil then
				arg_334_1.var_.characterEffect10068ui_story = var_337_33:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_337_35 = 0.034000001847744

			if var_337_34 <= arg_334_1.time_ and arg_334_1.time_ < var_337_34 + var_337_35 and not isNil(var_337_33) then
				local var_337_36 = (arg_334_1.time_ - var_337_34) / var_337_35

				if arg_334_1.var_.characterEffect10068ui_story and not isNil(var_337_33) then
					local var_337_37 = Mathf.Lerp(0, 0.5, var_337_36)

					arg_334_1.var_.characterEffect10068ui_story.fillFlat = true
					arg_334_1.var_.characterEffect10068ui_story.fillRatio = var_337_37
				end
			end

			if arg_334_1.time_ >= var_337_34 + var_337_35 and arg_334_1.time_ < var_337_34 + var_337_35 + arg_337_0 and not isNil(var_337_33) and arg_334_1.var_.characterEffect10068ui_story then
				local var_337_38 = 0.5

				arg_334_1.var_.characterEffect10068ui_story.fillFlat = true
				arg_334_1.var_.characterEffect10068ui_story.fillRatio = var_337_38
			end

			local var_337_39 = arg_334_1.actors_["1084ui_story"].transform
			local var_337_40 = 0

			if var_337_40 < arg_334_1.time_ and arg_334_1.time_ <= var_337_40 + arg_337_0 then
				arg_334_1.var_.moveOldPos1084ui_story = var_337_39.localPosition
			end

			local var_337_41 = 0.001

			if var_337_40 <= arg_334_1.time_ and arg_334_1.time_ < var_337_40 + var_337_41 then
				local var_337_42 = (arg_334_1.time_ - var_337_40) / var_337_41
				local var_337_43 = Vector3.New(0, 100, 0)

				var_337_39.localPosition = Vector3.Lerp(arg_334_1.var_.moveOldPos1084ui_story, var_337_43, var_337_42)

				local var_337_44 = manager.ui.mainCamera.transform.position - var_337_39.position

				var_337_39.forward = Vector3.New(var_337_44.x, var_337_44.y, var_337_44.z)

				local var_337_45 = var_337_39.localEulerAngles

				var_337_45.z = 0
				var_337_45.x = 0
				var_337_39.localEulerAngles = var_337_45
			end

			if arg_334_1.time_ >= var_337_40 + var_337_41 and arg_334_1.time_ < var_337_40 + var_337_41 + arg_337_0 then
				var_337_39.localPosition = Vector3.New(0, 100, 0)

				local var_337_46 = manager.ui.mainCamera.transform.position - var_337_39.position

				var_337_39.forward = Vector3.New(var_337_46.x, var_337_46.y, var_337_46.z)

				local var_337_47 = var_337_39.localEulerAngles

				var_337_47.z = 0
				var_337_47.x = 0
				var_337_39.localEulerAngles = var_337_47
			end

			local var_337_48 = arg_334_1.actors_["1084ui_story"]
			local var_337_49 = 0

			if var_337_49 < arg_334_1.time_ and arg_334_1.time_ <= var_337_49 + arg_337_0 and not isNil(var_337_48) and arg_334_1.var_.characterEffect1084ui_story == nil then
				arg_334_1.var_.characterEffect1084ui_story = var_337_48:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_337_50 = 0.034000001847744

			if var_337_49 <= arg_334_1.time_ and arg_334_1.time_ < var_337_49 + var_337_50 and not isNil(var_337_48) then
				local var_337_51 = (arg_334_1.time_ - var_337_49) / var_337_50

				if arg_334_1.var_.characterEffect1084ui_story and not isNil(var_337_48) then
					arg_334_1.var_.characterEffect1084ui_story.fillFlat = false
				end
			end

			if arg_334_1.time_ >= var_337_49 + var_337_50 and arg_334_1.time_ < var_337_49 + var_337_50 + arg_337_0 and not isNil(var_337_48) and arg_334_1.var_.characterEffect1084ui_story then
				arg_334_1.var_.characterEffect1084ui_story.fillFlat = false
			end

			local var_337_52 = arg_334_1.bgs_.ML0105.transform
			local var_337_53 = 0

			if var_337_53 < arg_334_1.time_ and arg_334_1.time_ <= var_337_53 + arg_337_0 then
				arg_334_1.var_.moveOldPosML0105 = var_337_52.localPosition
			end

			local var_337_54 = 0.001

			if var_337_53 <= arg_334_1.time_ and arg_334_1.time_ < var_337_53 + var_337_54 then
				local var_337_55 = (arg_334_1.time_ - var_337_53) / var_337_54
				local var_337_56 = Vector3.New(0, 2, 5)

				var_337_52.localPosition = Vector3.Lerp(arg_334_1.var_.moveOldPosML0105, var_337_56, var_337_55)
			end

			if arg_334_1.time_ >= var_337_53 + var_337_54 and arg_334_1.time_ < var_337_53 + var_337_54 + arg_337_0 then
				var_337_52.localPosition = Vector3.New(0, 2, 5)
			end

			local var_337_57 = arg_334_1.bgs_.ML0105.transform
			local var_337_58 = 0.0166666666666667

			if var_337_58 < arg_334_1.time_ and arg_334_1.time_ <= var_337_58 + arg_337_0 then
				arg_334_1.var_.moveOldPosML0105 = var_337_57.localPosition
			end

			local var_337_59 = 4.5

			if var_337_58 <= arg_334_1.time_ and arg_334_1.time_ < var_337_58 + var_337_59 then
				local var_337_60 = (arg_334_1.time_ - var_337_58) / var_337_59
				local var_337_61 = Vector3.New(0, 1.5, 5)

				var_337_57.localPosition = Vector3.Lerp(arg_334_1.var_.moveOldPosML0105, var_337_61, var_337_60)
			end

			if arg_334_1.time_ >= var_337_58 + var_337_59 and arg_334_1.time_ < var_337_58 + var_337_59 + arg_337_0 then
				var_337_57.localPosition = Vector3.New(0, 1.5, 5)
			end

			if arg_334_1.frameCnt_ <= 1 then
				arg_334_1.dialog_:SetActive(false)
			end

			local var_337_62 = 3
			local var_337_63 = 0.25

			if var_337_62 < arg_334_1.time_ and arg_334_1.time_ <= var_337_62 + arg_337_0 then
				arg_334_1.talkMaxDuration = 0

				arg_334_1.dialog_:SetActive(true)

				arg_334_1.dialogCg_.alpha = 0

				local var_337_64 = LeanTween.value(arg_334_1.dialog_, 0, 1, 0.3)

				var_337_64:setOnUpdate(LuaHelper.FloatAction(function(arg_338_0)
					arg_334_1.dialogCg_.alpha = arg_338_0
				end))
				var_337_64:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_334_1.dialog_)
					var_337_64:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_334_1.duration_ = arg_334_1.duration_ + 0.3

				SetActive(arg_334_1.leftNameGo_, true)

				local var_337_65 = arg_334_1:FormatText(StoryNameCfg[6].name)

				arg_334_1.leftNameTxt_.text = var_337_65

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_334_1.leftNameTxt_.transform)

				arg_334_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_334_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_334_1:RecordName(arg_334_1.leftNameTxt_.text)
				SetActive(arg_334_1.iconTrs_.gameObject, false)
				arg_334_1.callingController_:SetSelectedState("normal")

				local var_337_66 = arg_334_1:GetWordFromCfg(319501081)
				local var_337_67 = arg_334_1:FormatText(var_337_66.content)

				arg_334_1.text_.text = var_337_67

				LuaForUtil.ClearLinePrefixSymbol(arg_334_1.text_)

				local var_337_68 = 10
				local var_337_69 = utf8.len(var_337_67)
				local var_337_70 = var_337_68 <= 0 and var_337_63 or var_337_63 * (var_337_69 / var_337_68)

				if var_337_70 > 0 and var_337_63 < var_337_70 then
					arg_334_1.talkMaxDuration = var_337_70
					var_337_62 = var_337_62 + 0.3

					if var_337_70 + var_337_62 > arg_334_1.duration_ then
						arg_334_1.duration_ = var_337_70 + var_337_62
					end
				end

				arg_334_1.text_.text = var_337_67
				arg_334_1.typewritter.percent = 0

				arg_334_1.typewritter:SetDirty()
				arg_334_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_319501", "319501081", "story_v_out_319501.awb") ~= 0 then
					local var_337_71 = manager.audio:GetVoiceLength("story_v_out_319501", "319501081", "story_v_out_319501.awb") / 1000

					if var_337_71 + var_337_62 > arg_334_1.duration_ then
						arg_334_1.duration_ = var_337_71 + var_337_62
					end

					if var_337_66.prefab_name ~= "" and arg_334_1.actors_[var_337_66.prefab_name] ~= nil then
						local var_337_72 = LuaForUtil.PlayVoiceWithCriLipsync(arg_334_1.actors_[var_337_66.prefab_name].transform, "story_v_out_319501", "319501081", "story_v_out_319501.awb")

						arg_334_1:RecordAudio("319501081", var_337_72)
						arg_334_1:RecordAudio("319501081", var_337_72)
					else
						arg_334_1:AudioAction("play", "voice", "story_v_out_319501", "319501081", "story_v_out_319501.awb")
					end

					arg_334_1:RecordHistoryTalkVoice("story_v_out_319501", "319501081", "story_v_out_319501.awb")
				end

				arg_334_1:RecordContent(arg_334_1.text_.text)
			end

			local var_337_73 = var_337_62 + 0.3
			local var_337_74 = math.max(var_337_63, arg_334_1.talkMaxDuration)

			if var_337_73 <= arg_334_1.time_ and arg_334_1.time_ < var_337_73 + var_337_74 then
				arg_334_1.typewritter.percent = (arg_334_1.time_ - var_337_73) / var_337_74

				arg_334_1.typewritter:SetDirty()
			end

			if arg_334_1.time_ >= var_337_73 + var_337_74 and arg_334_1.time_ < var_337_73 + var_337_74 + arg_337_0 then
				arg_334_1.typewritter.percent = 1

				arg_334_1.typewritter:SetDirty()
				arg_334_1:ShowNextGo(true)
			end
		end

		arg_334_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10068ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1084ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "ML0105",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.0166666666666667,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Background
			},
			{
				assetPath = "",
				actorName = "ML0105",
				changeDisplayLayer = false,
				needEase = false,
				duration = 4.5,
				className = "StoryMoveNode",
				startTime = 0.0166666666666667,
				actorType = StoryPlayerConst.ACTOR_TYPE.Background
			}
		}

		arg_334_1:InitPlayNodeList()
	end,
	Play319501082 = function(arg_340_0, arg_340_1)
		arg_340_1.time_ = 0
		arg_340_1.frameCnt_ = 0
		arg_340_1.state_ = "playing"
		arg_340_1.curTalkId_ = 319501082
		arg_340_1.duration_ = 2.13

		local var_340_0 = {
			zh = 1.766,
			ja = 2.133
		}
		local var_340_1 = manager.audio:GetLocalizationFlag()

		if var_340_0[var_340_1] ~= nil then
			arg_340_1.duration_ = var_340_0[var_340_1]
		end

		SetActive(arg_340_1.tipsGo_, false)

		function arg_340_1.onSingleLineFinish_()
			arg_340_1.onSingleLineUpdate_ = nil
			arg_340_1.onSingleLineFinish_ = nil
			arg_340_1.state_ = "waiting"
		end

		function arg_340_1.playNext_(arg_342_0)
			if arg_342_0 == 1 then
				arg_340_0:Play319501083(arg_340_1)
			end
		end

		function arg_340_1.onSingleLineUpdate_(arg_343_0)
			local var_343_0 = arg_340_1.actors_["1084ui_story"]
			local var_343_1 = 0

			if var_343_1 < arg_340_1.time_ and arg_340_1.time_ <= var_343_1 + arg_343_0 and not isNil(var_343_0) and arg_340_1.var_.characterEffect1084ui_story == nil then
				arg_340_1.var_.characterEffect1084ui_story = var_343_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_343_2 = 0.200000002980232

			if var_343_1 <= arg_340_1.time_ and arg_340_1.time_ < var_343_1 + var_343_2 and not isNil(var_343_0) then
				local var_343_3 = (arg_340_1.time_ - var_343_1) / var_343_2

				if arg_340_1.var_.characterEffect1084ui_story and not isNil(var_343_0) then
					local var_343_4 = Mathf.Lerp(0, 0.5, var_343_3)

					arg_340_1.var_.characterEffect1084ui_story.fillFlat = true
					arg_340_1.var_.characterEffect1084ui_story.fillRatio = var_343_4
				end
			end

			if arg_340_1.time_ >= var_343_1 + var_343_2 and arg_340_1.time_ < var_343_1 + var_343_2 + arg_343_0 and not isNil(var_343_0) and arg_340_1.var_.characterEffect1084ui_story then
				local var_343_5 = 0.5

				arg_340_1.var_.characterEffect1084ui_story.fillFlat = true
				arg_340_1.var_.characterEffect1084ui_story.fillRatio = var_343_5
			end

			local var_343_6 = 0
			local var_343_7 = 0.175

			if var_343_6 < arg_340_1.time_ and arg_340_1.time_ <= var_343_6 + arg_343_0 then
				arg_340_1.talkMaxDuration = 0
				arg_340_1.dialogCg_.alpha = 1

				arg_340_1.dialog_:SetActive(true)
				SetActive(arg_340_1.leftNameGo_, true)

				local var_343_8 = arg_340_1:FormatText(StoryNameCfg[697].name)

				arg_340_1.leftNameTxt_.text = var_343_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_340_1.leftNameTxt_.transform)

				arg_340_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_340_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_340_1:RecordName(arg_340_1.leftNameTxt_.text)
				SetActive(arg_340_1.iconTrs_.gameObject, false)
				arg_340_1.callingController_:SetSelectedState("normal")

				local var_343_9 = arg_340_1:GetWordFromCfg(319501082)
				local var_343_10 = arg_340_1:FormatText(var_343_9.content)

				arg_340_1.text_.text = var_343_10

				LuaForUtil.ClearLinePrefixSymbol(arg_340_1.text_)

				local var_343_11 = 7
				local var_343_12 = utf8.len(var_343_10)
				local var_343_13 = var_343_11 <= 0 and var_343_7 or var_343_7 * (var_343_12 / var_343_11)

				if var_343_13 > 0 and var_343_7 < var_343_13 then
					arg_340_1.talkMaxDuration = var_343_13

					if var_343_13 + var_343_6 > arg_340_1.duration_ then
						arg_340_1.duration_ = var_343_13 + var_343_6
					end
				end

				arg_340_1.text_.text = var_343_10
				arg_340_1.typewritter.percent = 0

				arg_340_1.typewritter:SetDirty()
				arg_340_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_319501", "319501082", "story_v_out_319501.awb") ~= 0 then
					local var_343_14 = manager.audio:GetVoiceLength("story_v_out_319501", "319501082", "story_v_out_319501.awb") / 1000

					if var_343_14 + var_343_6 > arg_340_1.duration_ then
						arg_340_1.duration_ = var_343_14 + var_343_6
					end

					if var_343_9.prefab_name ~= "" and arg_340_1.actors_[var_343_9.prefab_name] ~= nil then
						local var_343_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_340_1.actors_[var_343_9.prefab_name].transform, "story_v_out_319501", "319501082", "story_v_out_319501.awb")

						arg_340_1:RecordAudio("319501082", var_343_15)
						arg_340_1:RecordAudio("319501082", var_343_15)
					else
						arg_340_1:AudioAction("play", "voice", "story_v_out_319501", "319501082", "story_v_out_319501.awb")
					end

					arg_340_1:RecordHistoryTalkVoice("story_v_out_319501", "319501082", "story_v_out_319501.awb")
				end

				arg_340_1:RecordContent(arg_340_1.text_.text)
			end

			local var_343_16 = math.max(var_343_7, arg_340_1.talkMaxDuration)

			if var_343_6 <= arg_340_1.time_ and arg_340_1.time_ < var_343_6 + var_343_16 then
				arg_340_1.typewritter.percent = (arg_340_1.time_ - var_343_6) / var_343_16

				arg_340_1.typewritter:SetDirty()
			end

			if arg_340_1.time_ >= var_343_6 + var_343_16 and arg_340_1.time_ < var_343_6 + var_343_16 + arg_343_0 then
				arg_340_1.typewritter.percent = 1

				arg_340_1.typewritter:SetDirty()
				arg_340_1:ShowNextGo(true)
			end
		end

		arg_340_1.nodeConfigList_ = {}

		arg_340_1:InitPlayNodeList()
	end,
	Play319501083 = function(arg_344_0, arg_344_1)
		arg_344_1.time_ = 0
		arg_344_1.frameCnt_ = 0
		arg_344_1.state_ = "playing"
		arg_344_1.curTalkId_ = 319501083
		arg_344_1.duration_ = 4.67

		local var_344_0 = {
			zh = 4.433,
			ja = 4.666
		}
		local var_344_1 = manager.audio:GetLocalizationFlag()

		if var_344_0[var_344_1] ~= nil then
			arg_344_1.duration_ = var_344_0[var_344_1]
		end

		SetActive(arg_344_1.tipsGo_, false)

		function arg_344_1.onSingleLineFinish_()
			arg_344_1.onSingleLineUpdate_ = nil
			arg_344_1.onSingleLineFinish_ = nil
			arg_344_1.state_ = "waiting"
		end

		function arg_344_1.playNext_(arg_346_0)
			if arg_346_0 == 1 then
				arg_344_0:Play319501084(arg_344_1)
			end
		end

		function arg_344_1.onSingleLineUpdate_(arg_347_0)
			local var_347_0 = 0
			local var_347_1 = 0.475

			if var_347_0 < arg_344_1.time_ and arg_344_1.time_ <= var_347_0 + arg_347_0 then
				arg_344_1.talkMaxDuration = 0
				arg_344_1.dialogCg_.alpha = 1

				arg_344_1.dialog_:SetActive(true)
				SetActive(arg_344_1.leftNameGo_, true)

				local var_347_2 = arg_344_1:FormatText(StoryNameCfg[6].name)

				arg_344_1.leftNameTxt_.text = var_347_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_344_1.leftNameTxt_.transform)

				arg_344_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_344_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_344_1:RecordName(arg_344_1.leftNameTxt_.text)
				SetActive(arg_344_1.iconTrs_.gameObject, false)
				arg_344_1.callingController_:SetSelectedState("normal")

				local var_347_3 = arg_344_1:GetWordFromCfg(319501083)
				local var_347_4 = arg_344_1:FormatText(var_347_3.content)

				arg_344_1.text_.text = var_347_4

				LuaForUtil.ClearLinePrefixSymbol(arg_344_1.text_)

				local var_347_5 = 19
				local var_347_6 = utf8.len(var_347_4)
				local var_347_7 = var_347_5 <= 0 and var_347_1 or var_347_1 * (var_347_6 / var_347_5)

				if var_347_7 > 0 and var_347_1 < var_347_7 then
					arg_344_1.talkMaxDuration = var_347_7

					if var_347_7 + var_347_0 > arg_344_1.duration_ then
						arg_344_1.duration_ = var_347_7 + var_347_0
					end
				end

				arg_344_1.text_.text = var_347_4
				arg_344_1.typewritter.percent = 0

				arg_344_1.typewritter:SetDirty()
				arg_344_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_319501", "319501083", "story_v_out_319501.awb") ~= 0 then
					local var_347_8 = manager.audio:GetVoiceLength("story_v_out_319501", "319501083", "story_v_out_319501.awb") / 1000

					if var_347_8 + var_347_0 > arg_344_1.duration_ then
						arg_344_1.duration_ = var_347_8 + var_347_0
					end

					if var_347_3.prefab_name ~= "" and arg_344_1.actors_[var_347_3.prefab_name] ~= nil then
						local var_347_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_344_1.actors_[var_347_3.prefab_name].transform, "story_v_out_319501", "319501083", "story_v_out_319501.awb")

						arg_344_1:RecordAudio("319501083", var_347_9)
						arg_344_1:RecordAudio("319501083", var_347_9)
					else
						arg_344_1:AudioAction("play", "voice", "story_v_out_319501", "319501083", "story_v_out_319501.awb")
					end

					arg_344_1:RecordHistoryTalkVoice("story_v_out_319501", "319501083", "story_v_out_319501.awb")
				end

				arg_344_1:RecordContent(arg_344_1.text_.text)
			end

			local var_347_10 = math.max(var_347_1, arg_344_1.talkMaxDuration)

			if var_347_0 <= arg_344_1.time_ and arg_344_1.time_ < var_347_0 + var_347_10 then
				arg_344_1.typewritter.percent = (arg_344_1.time_ - var_347_0) / var_347_10

				arg_344_1.typewritter:SetDirty()
			end

			if arg_344_1.time_ >= var_347_0 + var_347_10 and arg_344_1.time_ < var_347_0 + var_347_10 + arg_347_0 then
				arg_344_1.typewritter.percent = 1

				arg_344_1.typewritter:SetDirty()
				arg_344_1:ShowNextGo(true)
			end
		end

		arg_344_1.nodeConfigList_ = {}

		arg_344_1:InitPlayNodeList()
	end,
	Play319501084 = function(arg_348_0, arg_348_1)
		arg_348_1.time_ = 0
		arg_348_1.frameCnt_ = 0
		arg_348_1.state_ = "playing"
		arg_348_1.curTalkId_ = 319501084
		arg_348_1.duration_ = 4.43

		local var_348_0 = {
			zh = 3.5,
			ja = 4.433
		}
		local var_348_1 = manager.audio:GetLocalizationFlag()

		if var_348_0[var_348_1] ~= nil then
			arg_348_1.duration_ = var_348_0[var_348_1]
		end

		SetActive(arg_348_1.tipsGo_, false)

		function arg_348_1.onSingleLineFinish_()
			arg_348_1.onSingleLineUpdate_ = nil
			arg_348_1.onSingleLineFinish_ = nil
			arg_348_1.state_ = "waiting"
		end

		function arg_348_1.playNext_(arg_350_0)
			if arg_350_0 == 1 then
				arg_348_0:Play319501085(arg_348_1)
			end
		end

		function arg_348_1.onSingleLineUpdate_(arg_351_0)
			local var_351_0 = 0
			local var_351_1 = 0.425

			if var_351_0 < arg_348_1.time_ and arg_348_1.time_ <= var_351_0 + arg_351_0 then
				arg_348_1.talkMaxDuration = 0
				arg_348_1.dialogCg_.alpha = 1

				arg_348_1.dialog_:SetActive(true)
				SetActive(arg_348_1.leftNameGo_, true)

				local var_351_2 = arg_348_1:FormatText(StoryNameCfg[6].name)

				arg_348_1.leftNameTxt_.text = var_351_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_348_1.leftNameTxt_.transform)

				arg_348_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_348_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_348_1:RecordName(arg_348_1.leftNameTxt_.text)
				SetActive(arg_348_1.iconTrs_.gameObject, false)
				arg_348_1.callingController_:SetSelectedState("normal")

				local var_351_3 = arg_348_1:GetWordFromCfg(319501084)
				local var_351_4 = arg_348_1:FormatText(var_351_3.content)

				arg_348_1.text_.text = var_351_4

				LuaForUtil.ClearLinePrefixSymbol(arg_348_1.text_)

				local var_351_5 = 17
				local var_351_6 = utf8.len(var_351_4)
				local var_351_7 = var_351_5 <= 0 and var_351_1 or var_351_1 * (var_351_6 / var_351_5)

				if var_351_7 > 0 and var_351_1 < var_351_7 then
					arg_348_1.talkMaxDuration = var_351_7

					if var_351_7 + var_351_0 > arg_348_1.duration_ then
						arg_348_1.duration_ = var_351_7 + var_351_0
					end
				end

				arg_348_1.text_.text = var_351_4
				arg_348_1.typewritter.percent = 0

				arg_348_1.typewritter:SetDirty()
				arg_348_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_319501", "319501084", "story_v_out_319501.awb") ~= 0 then
					local var_351_8 = manager.audio:GetVoiceLength("story_v_out_319501", "319501084", "story_v_out_319501.awb") / 1000

					if var_351_8 + var_351_0 > arg_348_1.duration_ then
						arg_348_1.duration_ = var_351_8 + var_351_0
					end

					if var_351_3.prefab_name ~= "" and arg_348_1.actors_[var_351_3.prefab_name] ~= nil then
						local var_351_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_348_1.actors_[var_351_3.prefab_name].transform, "story_v_out_319501", "319501084", "story_v_out_319501.awb")

						arg_348_1:RecordAudio("319501084", var_351_9)
						arg_348_1:RecordAudio("319501084", var_351_9)
					else
						arg_348_1:AudioAction("play", "voice", "story_v_out_319501", "319501084", "story_v_out_319501.awb")
					end

					arg_348_1:RecordHistoryTalkVoice("story_v_out_319501", "319501084", "story_v_out_319501.awb")
				end

				arg_348_1:RecordContent(arg_348_1.text_.text)
			end

			local var_351_10 = math.max(var_351_1, arg_348_1.talkMaxDuration)

			if var_351_0 <= arg_348_1.time_ and arg_348_1.time_ < var_351_0 + var_351_10 then
				arg_348_1.typewritter.percent = (arg_348_1.time_ - var_351_0) / var_351_10

				arg_348_1.typewritter:SetDirty()
			end

			if arg_348_1.time_ >= var_351_0 + var_351_10 and arg_348_1.time_ < var_351_0 + var_351_10 + arg_351_0 then
				arg_348_1.typewritter.percent = 1

				arg_348_1.typewritter:SetDirty()
				arg_348_1:ShowNextGo(true)
			end
		end

		arg_348_1.nodeConfigList_ = {}

		arg_348_1:InitPlayNodeList()
	end,
	Play319501085 = function(arg_352_0, arg_352_1)
		arg_352_1.time_ = 0
		arg_352_1.frameCnt_ = 0
		arg_352_1.state_ = "playing"
		arg_352_1.curTalkId_ = 319501085
		arg_352_1.duration_ = 1.9

		local var_352_0 = {
			zh = 1.6,
			ja = 1.9
		}
		local var_352_1 = manager.audio:GetLocalizationFlag()

		if var_352_0[var_352_1] ~= nil then
			arg_352_1.duration_ = var_352_0[var_352_1]
		end

		SetActive(arg_352_1.tipsGo_, false)

		function arg_352_1.onSingleLineFinish_()
			arg_352_1.onSingleLineUpdate_ = nil
			arg_352_1.onSingleLineFinish_ = nil
			arg_352_1.state_ = "waiting"
		end

		function arg_352_1.playNext_(arg_354_0)
			if arg_354_0 == 1 then
				arg_352_0:Play319501086(arg_352_1)
			end
		end

		function arg_352_1.onSingleLineUpdate_(arg_355_0)
			local var_355_0 = 0
			local var_355_1 = 0.05

			if var_355_0 < arg_352_1.time_ and arg_352_1.time_ <= var_355_0 + arg_355_0 then
				arg_352_1.talkMaxDuration = 0
				arg_352_1.dialogCg_.alpha = 1

				arg_352_1.dialog_:SetActive(true)
				SetActive(arg_352_1.leftNameGo_, true)

				local var_355_2 = arg_352_1:FormatText(StoryNameCfg[697].name)

				arg_352_1.leftNameTxt_.text = var_355_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_352_1.leftNameTxt_.transform)

				arg_352_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_352_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_352_1:RecordName(arg_352_1.leftNameTxt_.text)
				SetActive(arg_352_1.iconTrs_.gameObject, false)
				arg_352_1.callingController_:SetSelectedState("normal")

				local var_355_3 = arg_352_1:GetWordFromCfg(319501085)
				local var_355_4 = arg_352_1:FormatText(var_355_3.content)

				arg_352_1.text_.text = var_355_4

				LuaForUtil.ClearLinePrefixSymbol(arg_352_1.text_)

				local var_355_5 = 2
				local var_355_6 = utf8.len(var_355_4)
				local var_355_7 = var_355_5 <= 0 and var_355_1 or var_355_1 * (var_355_6 / var_355_5)

				if var_355_7 > 0 and var_355_1 < var_355_7 then
					arg_352_1.talkMaxDuration = var_355_7

					if var_355_7 + var_355_0 > arg_352_1.duration_ then
						arg_352_1.duration_ = var_355_7 + var_355_0
					end
				end

				arg_352_1.text_.text = var_355_4
				arg_352_1.typewritter.percent = 0

				arg_352_1.typewritter:SetDirty()
				arg_352_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_319501", "319501085", "story_v_out_319501.awb") ~= 0 then
					local var_355_8 = manager.audio:GetVoiceLength("story_v_out_319501", "319501085", "story_v_out_319501.awb") / 1000

					if var_355_8 + var_355_0 > arg_352_1.duration_ then
						arg_352_1.duration_ = var_355_8 + var_355_0
					end

					if var_355_3.prefab_name ~= "" and arg_352_1.actors_[var_355_3.prefab_name] ~= nil then
						local var_355_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_352_1.actors_[var_355_3.prefab_name].transform, "story_v_out_319501", "319501085", "story_v_out_319501.awb")

						arg_352_1:RecordAudio("319501085", var_355_9)
						arg_352_1:RecordAudio("319501085", var_355_9)
					else
						arg_352_1:AudioAction("play", "voice", "story_v_out_319501", "319501085", "story_v_out_319501.awb")
					end

					arg_352_1:RecordHistoryTalkVoice("story_v_out_319501", "319501085", "story_v_out_319501.awb")
				end

				arg_352_1:RecordContent(arg_352_1.text_.text)
			end

			local var_355_10 = math.max(var_355_1, arg_352_1.talkMaxDuration)

			if var_355_0 <= arg_352_1.time_ and arg_352_1.time_ < var_355_0 + var_355_10 then
				arg_352_1.typewritter.percent = (arg_352_1.time_ - var_355_0) / var_355_10

				arg_352_1.typewritter:SetDirty()
			end

			if arg_352_1.time_ >= var_355_0 + var_355_10 and arg_352_1.time_ < var_355_0 + var_355_10 + arg_355_0 then
				arg_352_1.typewritter.percent = 1

				arg_352_1.typewritter:SetDirty()
				arg_352_1:ShowNextGo(true)
			end
		end

		arg_352_1.nodeConfigList_ = {}

		arg_352_1:InitPlayNodeList()
	end,
	Play319501086 = function(arg_356_0, arg_356_1)
		arg_356_1.time_ = 0
		arg_356_1.frameCnt_ = 0
		arg_356_1.state_ = "playing"
		arg_356_1.curTalkId_ = 319501086
		arg_356_1.duration_ = 5

		SetActive(arg_356_1.tipsGo_, false)

		function arg_356_1.onSingleLineFinish_()
			arg_356_1.onSingleLineUpdate_ = nil
			arg_356_1.onSingleLineFinish_ = nil
			arg_356_1.state_ = "waiting"
		end

		function arg_356_1.playNext_(arg_358_0)
			if arg_358_0 == 1 then
				arg_356_0:Play319501087(arg_356_1)
			end
		end

		function arg_356_1.onSingleLineUpdate_(arg_359_0)
			local var_359_0 = 0
			local var_359_1 = 1.45

			if var_359_0 < arg_356_1.time_ and arg_356_1.time_ <= var_359_0 + arg_359_0 then
				arg_356_1.talkMaxDuration = 0
				arg_356_1.dialogCg_.alpha = 1

				arg_356_1.dialog_:SetActive(true)
				SetActive(arg_356_1.leftNameGo_, false)

				arg_356_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_356_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_356_1:RecordName(arg_356_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_356_1.iconTrs_.gameObject, false)
				arg_356_1.callingController_:SetSelectedState("normal")

				local var_359_2 = arg_356_1:GetWordFromCfg(319501086)
				local var_359_3 = arg_356_1:FormatText(var_359_2.content)

				arg_356_1.text_.text = var_359_3

				LuaForUtil.ClearLinePrefixSymbol(arg_356_1.text_)

				local var_359_4 = 57
				local var_359_5 = utf8.len(var_359_3)
				local var_359_6 = var_359_4 <= 0 and var_359_1 or var_359_1 * (var_359_5 / var_359_4)

				if var_359_6 > 0 and var_359_1 < var_359_6 then
					arg_356_1.talkMaxDuration = var_359_6

					if var_359_6 + var_359_0 > arg_356_1.duration_ then
						arg_356_1.duration_ = var_359_6 + var_359_0
					end
				end

				arg_356_1.text_.text = var_359_3
				arg_356_1.typewritter.percent = 0

				arg_356_1.typewritter:SetDirty()
				arg_356_1:ShowNextGo(false)
				arg_356_1:RecordContent(arg_356_1.text_.text)
			end

			local var_359_7 = math.max(var_359_1, arg_356_1.talkMaxDuration)

			if var_359_0 <= arg_356_1.time_ and arg_356_1.time_ < var_359_0 + var_359_7 then
				arg_356_1.typewritter.percent = (arg_356_1.time_ - var_359_0) / var_359_7

				arg_356_1.typewritter:SetDirty()
			end

			if arg_356_1.time_ >= var_359_0 + var_359_7 and arg_356_1.time_ < var_359_0 + var_359_7 + arg_359_0 then
				arg_356_1.typewritter.percent = 1

				arg_356_1.typewritter:SetDirty()
				arg_356_1:ShowNextGo(true)
			end
		end

		arg_356_1.nodeConfigList_ = {}

		arg_356_1:InitPlayNodeList()
	end,
	Play319501087 = function(arg_360_0, arg_360_1)
		arg_360_1.time_ = 0
		arg_360_1.frameCnt_ = 0
		arg_360_1.state_ = "playing"
		arg_360_1.curTalkId_ = 319501087
		arg_360_1.duration_ = 5

		SetActive(arg_360_1.tipsGo_, false)

		function arg_360_1.onSingleLineFinish_()
			arg_360_1.onSingleLineUpdate_ = nil
			arg_360_1.onSingleLineFinish_ = nil
			arg_360_1.state_ = "waiting"
		end

		function arg_360_1.playNext_(arg_362_0)
			if arg_362_0 == 1 then
				arg_360_0:Play319501088(arg_360_1)
			end
		end

		function arg_360_1.onSingleLineUpdate_(arg_363_0)
			local var_363_0 = 0
			local var_363_1 = 1.3

			if var_363_0 < arg_360_1.time_ and arg_360_1.time_ <= var_363_0 + arg_363_0 then
				arg_360_1.talkMaxDuration = 0
				arg_360_1.dialogCg_.alpha = 1

				arg_360_1.dialog_:SetActive(true)
				SetActive(arg_360_1.leftNameGo_, false)

				arg_360_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_360_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_360_1:RecordName(arg_360_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_360_1.iconTrs_.gameObject, false)
				arg_360_1.callingController_:SetSelectedState("normal")

				local var_363_2 = arg_360_1:GetWordFromCfg(319501087)
				local var_363_3 = arg_360_1:FormatText(var_363_2.content)

				arg_360_1.text_.text = var_363_3

				LuaForUtil.ClearLinePrefixSymbol(arg_360_1.text_)

				local var_363_4 = 52
				local var_363_5 = utf8.len(var_363_3)
				local var_363_6 = var_363_4 <= 0 and var_363_1 or var_363_1 * (var_363_5 / var_363_4)

				if var_363_6 > 0 and var_363_1 < var_363_6 then
					arg_360_1.talkMaxDuration = var_363_6

					if var_363_6 + var_363_0 > arg_360_1.duration_ then
						arg_360_1.duration_ = var_363_6 + var_363_0
					end
				end

				arg_360_1.text_.text = var_363_3
				arg_360_1.typewritter.percent = 0

				arg_360_1.typewritter:SetDirty()
				arg_360_1:ShowNextGo(false)
				arg_360_1:RecordContent(arg_360_1.text_.text)
			end

			local var_363_7 = math.max(var_363_1, arg_360_1.talkMaxDuration)

			if var_363_0 <= arg_360_1.time_ and arg_360_1.time_ < var_363_0 + var_363_7 then
				arg_360_1.typewritter.percent = (arg_360_1.time_ - var_363_0) / var_363_7

				arg_360_1.typewritter:SetDirty()
			end

			if arg_360_1.time_ >= var_363_0 + var_363_7 and arg_360_1.time_ < var_363_0 + var_363_7 + arg_363_0 then
				arg_360_1.typewritter.percent = 1

				arg_360_1.typewritter:SetDirty()
				arg_360_1:ShowNextGo(true)
			end
		end

		arg_360_1.nodeConfigList_ = {}

		arg_360_1:InitPlayNodeList()
	end,
	Play319501088 = function(arg_364_0, arg_364_1)
		arg_364_1.time_ = 0
		arg_364_1.frameCnt_ = 0
		arg_364_1.state_ = "playing"
		arg_364_1.curTalkId_ = 319501088
		arg_364_1.duration_ = 9.27

		local var_364_0 = {
			zh = 9.266,
			ja = 6.8
		}
		local var_364_1 = manager.audio:GetLocalizationFlag()

		if var_364_0[var_364_1] ~= nil then
			arg_364_1.duration_ = var_364_0[var_364_1]
		end

		SetActive(arg_364_1.tipsGo_, false)

		function arg_364_1.onSingleLineFinish_()
			arg_364_1.onSingleLineUpdate_ = nil
			arg_364_1.onSingleLineFinish_ = nil
			arg_364_1.state_ = "waiting"
		end

		function arg_364_1.playNext_(arg_366_0)
			if arg_366_0 == 1 then
				arg_364_0:Play319501089(arg_364_1)
			end
		end

		function arg_364_1.onSingleLineUpdate_(arg_367_0)
			local var_367_0 = 0
			local var_367_1 = 1

			if var_367_0 < arg_364_1.time_ and arg_364_1.time_ <= var_367_0 + arg_367_0 then
				arg_364_1.talkMaxDuration = 0
				arg_364_1.dialogCg_.alpha = 1

				arg_364_1.dialog_:SetActive(true)
				SetActive(arg_364_1.leftNameGo_, true)

				local var_367_2 = arg_364_1:FormatText(StoryNameCfg[6].name)

				arg_364_1.leftNameTxt_.text = var_367_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_364_1.leftNameTxt_.transform)

				arg_364_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_364_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_364_1:RecordName(arg_364_1.leftNameTxt_.text)
				SetActive(arg_364_1.iconTrs_.gameObject, false)
				arg_364_1.callingController_:SetSelectedState("normal")

				local var_367_3 = arg_364_1:GetWordFromCfg(319501088)
				local var_367_4 = arg_364_1:FormatText(var_367_3.content)

				arg_364_1.text_.text = var_367_4

				LuaForUtil.ClearLinePrefixSymbol(arg_364_1.text_)

				local var_367_5 = 40
				local var_367_6 = utf8.len(var_367_4)
				local var_367_7 = var_367_5 <= 0 and var_367_1 or var_367_1 * (var_367_6 / var_367_5)

				if var_367_7 > 0 and var_367_1 < var_367_7 then
					arg_364_1.talkMaxDuration = var_367_7

					if var_367_7 + var_367_0 > arg_364_1.duration_ then
						arg_364_1.duration_ = var_367_7 + var_367_0
					end
				end

				arg_364_1.text_.text = var_367_4
				arg_364_1.typewritter.percent = 0

				arg_364_1.typewritter:SetDirty()
				arg_364_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_319501", "319501088", "story_v_out_319501.awb") ~= 0 then
					local var_367_8 = manager.audio:GetVoiceLength("story_v_out_319501", "319501088", "story_v_out_319501.awb") / 1000

					if var_367_8 + var_367_0 > arg_364_1.duration_ then
						arg_364_1.duration_ = var_367_8 + var_367_0
					end

					if var_367_3.prefab_name ~= "" and arg_364_1.actors_[var_367_3.prefab_name] ~= nil then
						local var_367_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_364_1.actors_[var_367_3.prefab_name].transform, "story_v_out_319501", "319501088", "story_v_out_319501.awb")

						arg_364_1:RecordAudio("319501088", var_367_9)
						arg_364_1:RecordAudio("319501088", var_367_9)
					else
						arg_364_1:AudioAction("play", "voice", "story_v_out_319501", "319501088", "story_v_out_319501.awb")
					end

					arg_364_1:RecordHistoryTalkVoice("story_v_out_319501", "319501088", "story_v_out_319501.awb")
				end

				arg_364_1:RecordContent(arg_364_1.text_.text)
			end

			local var_367_10 = math.max(var_367_1, arg_364_1.talkMaxDuration)

			if var_367_0 <= arg_364_1.time_ and arg_364_1.time_ < var_367_0 + var_367_10 then
				arg_364_1.typewritter.percent = (arg_364_1.time_ - var_367_0) / var_367_10

				arg_364_1.typewritter:SetDirty()
			end

			if arg_364_1.time_ >= var_367_0 + var_367_10 and arg_364_1.time_ < var_367_0 + var_367_10 + arg_367_0 then
				arg_364_1.typewritter.percent = 1

				arg_364_1.typewritter:SetDirty()
				arg_364_1:ShowNextGo(true)
			end
		end

		arg_364_1.nodeConfigList_ = {}

		arg_364_1:InitPlayNodeList()
	end,
	Play319501089 = function(arg_368_0, arg_368_1)
		arg_368_1.time_ = 0
		arg_368_1.frameCnt_ = 0
		arg_368_1.state_ = "playing"
		arg_368_1.curTalkId_ = 319501089
		arg_368_1.duration_ = 16.93

		local var_368_0 = {
			zh = 9.833,
			ja = 16.933
		}
		local var_368_1 = manager.audio:GetLocalizationFlag()

		if var_368_0[var_368_1] ~= nil then
			arg_368_1.duration_ = var_368_0[var_368_1]
		end

		SetActive(arg_368_1.tipsGo_, false)

		function arg_368_1.onSingleLineFinish_()
			arg_368_1.onSingleLineUpdate_ = nil
			arg_368_1.onSingleLineFinish_ = nil
			arg_368_1.state_ = "waiting"
		end

		function arg_368_1.playNext_(arg_370_0)
			if arg_370_0 == 1 then
				arg_368_0:Play319501090(arg_368_1)
			end
		end

		function arg_368_1.onSingleLineUpdate_(arg_371_0)
			local var_371_0 = 0
			local var_371_1 = 1.025

			if var_371_0 < arg_368_1.time_ and arg_368_1.time_ <= var_371_0 + arg_371_0 then
				arg_368_1.talkMaxDuration = 0
				arg_368_1.dialogCg_.alpha = 1

				arg_368_1.dialog_:SetActive(true)
				SetActive(arg_368_1.leftNameGo_, true)

				local var_371_2 = arg_368_1:FormatText(StoryNameCfg[6].name)

				arg_368_1.leftNameTxt_.text = var_371_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_368_1.leftNameTxt_.transform)

				arg_368_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_368_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_368_1:RecordName(arg_368_1.leftNameTxt_.text)
				SetActive(arg_368_1.iconTrs_.gameObject, false)
				arg_368_1.callingController_:SetSelectedState("normal")

				local var_371_3 = arg_368_1:GetWordFromCfg(319501089)
				local var_371_4 = arg_368_1:FormatText(var_371_3.content)

				arg_368_1.text_.text = var_371_4

				LuaForUtil.ClearLinePrefixSymbol(arg_368_1.text_)

				local var_371_5 = 41
				local var_371_6 = utf8.len(var_371_4)
				local var_371_7 = var_371_5 <= 0 and var_371_1 or var_371_1 * (var_371_6 / var_371_5)

				if var_371_7 > 0 and var_371_1 < var_371_7 then
					arg_368_1.talkMaxDuration = var_371_7

					if var_371_7 + var_371_0 > arg_368_1.duration_ then
						arg_368_1.duration_ = var_371_7 + var_371_0
					end
				end

				arg_368_1.text_.text = var_371_4
				arg_368_1.typewritter.percent = 0

				arg_368_1.typewritter:SetDirty()
				arg_368_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_319501", "319501089", "story_v_out_319501.awb") ~= 0 then
					local var_371_8 = manager.audio:GetVoiceLength("story_v_out_319501", "319501089", "story_v_out_319501.awb") / 1000

					if var_371_8 + var_371_0 > arg_368_1.duration_ then
						arg_368_1.duration_ = var_371_8 + var_371_0
					end

					if var_371_3.prefab_name ~= "" and arg_368_1.actors_[var_371_3.prefab_name] ~= nil then
						local var_371_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_368_1.actors_[var_371_3.prefab_name].transform, "story_v_out_319501", "319501089", "story_v_out_319501.awb")

						arg_368_1:RecordAudio("319501089", var_371_9)
						arg_368_1:RecordAudio("319501089", var_371_9)
					else
						arg_368_1:AudioAction("play", "voice", "story_v_out_319501", "319501089", "story_v_out_319501.awb")
					end

					arg_368_1:RecordHistoryTalkVoice("story_v_out_319501", "319501089", "story_v_out_319501.awb")
				end

				arg_368_1:RecordContent(arg_368_1.text_.text)
			end

			local var_371_10 = math.max(var_371_1, arg_368_1.talkMaxDuration)

			if var_371_0 <= arg_368_1.time_ and arg_368_1.time_ < var_371_0 + var_371_10 then
				arg_368_1.typewritter.percent = (arg_368_1.time_ - var_371_0) / var_371_10

				arg_368_1.typewritter:SetDirty()
			end

			if arg_368_1.time_ >= var_371_0 + var_371_10 and arg_368_1.time_ < var_371_0 + var_371_10 + arg_371_0 then
				arg_368_1.typewritter.percent = 1

				arg_368_1.typewritter:SetDirty()
				arg_368_1:ShowNextGo(true)
			end
		end

		arg_368_1.nodeConfigList_ = {}

		arg_368_1:InitPlayNodeList()
	end,
	Play319501090 = function(arg_372_0, arg_372_1)
		arg_372_1.time_ = 0
		arg_372_1.frameCnt_ = 0
		arg_372_1.state_ = "playing"
		arg_372_1.curTalkId_ = 319501090
		arg_372_1.duration_ = 8.57

		local var_372_0 = {
			zh = 4.566,
			ja = 8.566
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
				arg_372_0:Play319501091(arg_372_1)
			end
		end

		function arg_372_1.onSingleLineUpdate_(arg_375_0)
			local var_375_0 = 0
			local var_375_1 = 0.375

			if var_375_0 < arg_372_1.time_ and arg_372_1.time_ <= var_375_0 + arg_375_0 then
				arg_372_1.talkMaxDuration = 0
				arg_372_1.dialogCg_.alpha = 1

				arg_372_1.dialog_:SetActive(true)
				SetActive(arg_372_1.leftNameGo_, true)

				local var_375_2 = arg_372_1:FormatText(StoryNameCfg[6].name)

				arg_372_1.leftNameTxt_.text = var_375_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_372_1.leftNameTxt_.transform)

				arg_372_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_372_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_372_1:RecordName(arg_372_1.leftNameTxt_.text)
				SetActive(arg_372_1.iconTrs_.gameObject, false)
				arg_372_1.callingController_:SetSelectedState("normal")

				local var_375_3 = arg_372_1:GetWordFromCfg(319501090)
				local var_375_4 = arg_372_1:FormatText(var_375_3.content)

				arg_372_1.text_.text = var_375_4

				LuaForUtil.ClearLinePrefixSymbol(arg_372_1.text_)

				local var_375_5 = 15
				local var_375_6 = utf8.len(var_375_4)
				local var_375_7 = var_375_5 <= 0 and var_375_1 or var_375_1 * (var_375_6 / var_375_5)

				if var_375_7 > 0 and var_375_1 < var_375_7 then
					arg_372_1.talkMaxDuration = var_375_7

					if var_375_7 + var_375_0 > arg_372_1.duration_ then
						arg_372_1.duration_ = var_375_7 + var_375_0
					end
				end

				arg_372_1.text_.text = var_375_4
				arg_372_1.typewritter.percent = 0

				arg_372_1.typewritter:SetDirty()
				arg_372_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_319501", "319501090", "story_v_out_319501.awb") ~= 0 then
					local var_375_8 = manager.audio:GetVoiceLength("story_v_out_319501", "319501090", "story_v_out_319501.awb") / 1000

					if var_375_8 + var_375_0 > arg_372_1.duration_ then
						arg_372_1.duration_ = var_375_8 + var_375_0
					end

					if var_375_3.prefab_name ~= "" and arg_372_1.actors_[var_375_3.prefab_name] ~= nil then
						local var_375_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_372_1.actors_[var_375_3.prefab_name].transform, "story_v_out_319501", "319501090", "story_v_out_319501.awb")

						arg_372_1:RecordAudio("319501090", var_375_9)
						arg_372_1:RecordAudio("319501090", var_375_9)
					else
						arg_372_1:AudioAction("play", "voice", "story_v_out_319501", "319501090", "story_v_out_319501.awb")
					end

					arg_372_1:RecordHistoryTalkVoice("story_v_out_319501", "319501090", "story_v_out_319501.awb")
				end

				arg_372_1:RecordContent(arg_372_1.text_.text)
			end

			local var_375_10 = math.max(var_375_1, arg_372_1.talkMaxDuration)

			if var_375_0 <= arg_372_1.time_ and arg_372_1.time_ < var_375_0 + var_375_10 then
				arg_372_1.typewritter.percent = (arg_372_1.time_ - var_375_0) / var_375_10

				arg_372_1.typewritter:SetDirty()
			end

			if arg_372_1.time_ >= var_375_0 + var_375_10 and arg_372_1.time_ < var_375_0 + var_375_10 + arg_375_0 then
				arg_372_1.typewritter.percent = 1

				arg_372_1.typewritter:SetDirty()
				arg_372_1:ShowNextGo(true)
			end
		end

		arg_372_1.nodeConfigList_ = {}

		arg_372_1:InitPlayNodeList()
	end,
	Play319501091 = function(arg_376_0, arg_376_1)
		arg_376_1.time_ = 0
		arg_376_1.frameCnt_ = 0
		arg_376_1.state_ = "playing"
		arg_376_1.curTalkId_ = 319501091
		arg_376_1.duration_ = 1

		local var_376_0 = {
			zh = 0.999999999999,
			ja = 1
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
				arg_376_0:Play319501092(arg_376_1)
			end
		end

		function arg_376_1.onSingleLineUpdate_(arg_379_0)
			local var_379_0 = 0
			local var_379_1 = 0.1

			if var_379_0 < arg_376_1.time_ and arg_376_1.time_ <= var_379_0 + arg_379_0 then
				arg_376_1.talkMaxDuration = 0
				arg_376_1.dialogCg_.alpha = 1

				arg_376_1.dialog_:SetActive(true)
				SetActive(arg_376_1.leftNameGo_, true)

				local var_379_2 = arg_376_1:FormatText(StoryNameCfg[697].name)

				arg_376_1.leftNameTxt_.text = var_379_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_376_1.leftNameTxt_.transform)

				arg_376_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_376_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_376_1:RecordName(arg_376_1.leftNameTxt_.text)
				SetActive(arg_376_1.iconTrs_.gameObject, false)
				arg_376_1.callingController_:SetSelectedState("normal")

				local var_379_3 = arg_376_1:GetWordFromCfg(319501091)
				local var_379_4 = arg_376_1:FormatText(var_379_3.content)

				arg_376_1.text_.text = var_379_4

				LuaForUtil.ClearLinePrefixSymbol(arg_376_1.text_)

				local var_379_5 = 4
				local var_379_6 = utf8.len(var_379_4)
				local var_379_7 = var_379_5 <= 0 and var_379_1 or var_379_1 * (var_379_6 / var_379_5)

				if var_379_7 > 0 and var_379_1 < var_379_7 then
					arg_376_1.talkMaxDuration = var_379_7

					if var_379_7 + var_379_0 > arg_376_1.duration_ then
						arg_376_1.duration_ = var_379_7 + var_379_0
					end
				end

				arg_376_1.text_.text = var_379_4
				arg_376_1.typewritter.percent = 0

				arg_376_1.typewritter:SetDirty()
				arg_376_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_319501", "319501091", "story_v_out_319501.awb") ~= 0 then
					local var_379_8 = manager.audio:GetVoiceLength("story_v_out_319501", "319501091", "story_v_out_319501.awb") / 1000

					if var_379_8 + var_379_0 > arg_376_1.duration_ then
						arg_376_1.duration_ = var_379_8 + var_379_0
					end

					if var_379_3.prefab_name ~= "" and arg_376_1.actors_[var_379_3.prefab_name] ~= nil then
						local var_379_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_376_1.actors_[var_379_3.prefab_name].transform, "story_v_out_319501", "319501091", "story_v_out_319501.awb")

						arg_376_1:RecordAudio("319501091", var_379_9)
						arg_376_1:RecordAudio("319501091", var_379_9)
					else
						arg_376_1:AudioAction("play", "voice", "story_v_out_319501", "319501091", "story_v_out_319501.awb")
					end

					arg_376_1:RecordHistoryTalkVoice("story_v_out_319501", "319501091", "story_v_out_319501.awb")
				end

				arg_376_1:RecordContent(arg_376_1.text_.text)
			end

			local var_379_10 = math.max(var_379_1, arg_376_1.talkMaxDuration)

			if var_379_0 <= arg_376_1.time_ and arg_376_1.time_ < var_379_0 + var_379_10 then
				arg_376_1.typewritter.percent = (arg_376_1.time_ - var_379_0) / var_379_10

				arg_376_1.typewritter:SetDirty()
			end

			if arg_376_1.time_ >= var_379_0 + var_379_10 and arg_376_1.time_ < var_379_0 + var_379_10 + arg_379_0 then
				arg_376_1.typewritter.percent = 1

				arg_376_1.typewritter:SetDirty()
				arg_376_1:ShowNextGo(true)
			end
		end

		arg_376_1.nodeConfigList_ = {}

		arg_376_1:InitPlayNodeList()
	end,
	Play319501092 = function(arg_380_0, arg_380_1)
		arg_380_1.time_ = 0
		arg_380_1.frameCnt_ = 0
		arg_380_1.state_ = "playing"
		arg_380_1.curTalkId_ = 319501092
		arg_380_1.duration_ = 5

		SetActive(arg_380_1.tipsGo_, false)

		function arg_380_1.onSingleLineFinish_()
			arg_380_1.onSingleLineUpdate_ = nil
			arg_380_1.onSingleLineFinish_ = nil
			arg_380_1.state_ = "waiting"
		end

		function arg_380_1.playNext_(arg_382_0)
			if arg_382_0 == 1 then
				arg_380_0:Play319501093(arg_380_1)
			end
		end

		function arg_380_1.onSingleLineUpdate_(arg_383_0)
			local var_383_0 = 0
			local var_383_1 = 1.225

			if var_383_0 < arg_380_1.time_ and arg_380_1.time_ <= var_383_0 + arg_383_0 then
				arg_380_1.talkMaxDuration = 0
				arg_380_1.dialogCg_.alpha = 1

				arg_380_1.dialog_:SetActive(true)
				SetActive(arg_380_1.leftNameGo_, false)

				arg_380_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_380_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_380_1:RecordName(arg_380_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_380_1.iconTrs_.gameObject, false)
				arg_380_1.callingController_:SetSelectedState("normal")

				local var_383_2 = arg_380_1:GetWordFromCfg(319501092)
				local var_383_3 = arg_380_1:FormatText(var_383_2.content)

				arg_380_1.text_.text = var_383_3

				LuaForUtil.ClearLinePrefixSymbol(arg_380_1.text_)

				local var_383_4 = 49
				local var_383_5 = utf8.len(var_383_3)
				local var_383_6 = var_383_4 <= 0 and var_383_1 or var_383_1 * (var_383_5 / var_383_4)

				if var_383_6 > 0 and var_383_1 < var_383_6 then
					arg_380_1.talkMaxDuration = var_383_6

					if var_383_6 + var_383_0 > arg_380_1.duration_ then
						arg_380_1.duration_ = var_383_6 + var_383_0
					end
				end

				arg_380_1.text_.text = var_383_3
				arg_380_1.typewritter.percent = 0

				arg_380_1.typewritter:SetDirty()
				arg_380_1:ShowNextGo(false)
				arg_380_1:RecordContent(arg_380_1.text_.text)
			end

			local var_383_7 = math.max(var_383_1, arg_380_1.talkMaxDuration)

			if var_383_0 <= arg_380_1.time_ and arg_380_1.time_ < var_383_0 + var_383_7 then
				arg_380_1.typewritter.percent = (arg_380_1.time_ - var_383_0) / var_383_7

				arg_380_1.typewritter:SetDirty()
			end

			if arg_380_1.time_ >= var_383_0 + var_383_7 and arg_380_1.time_ < var_383_0 + var_383_7 + arg_383_0 then
				arg_380_1.typewritter.percent = 1

				arg_380_1.typewritter:SetDirty()
				arg_380_1:ShowNextGo(true)
			end
		end

		arg_380_1.nodeConfigList_ = {}

		arg_380_1:InitPlayNodeList()
	end,
	Play319501093 = function(arg_384_0, arg_384_1)
		arg_384_1.time_ = 0
		arg_384_1.frameCnt_ = 0
		arg_384_1.state_ = "playing"
		arg_384_1.curTalkId_ = 319501093
		arg_384_1.duration_ = 10.97

		local var_384_0 = {
			zh = 6.733,
			ja = 10.966
		}
		local var_384_1 = manager.audio:GetLocalizationFlag()

		if var_384_0[var_384_1] ~= nil then
			arg_384_1.duration_ = var_384_0[var_384_1]
		end

		SetActive(arg_384_1.tipsGo_, false)

		function arg_384_1.onSingleLineFinish_()
			arg_384_1.onSingleLineUpdate_ = nil
			arg_384_1.onSingleLineFinish_ = nil
			arg_384_1.state_ = "waiting"
		end

		function arg_384_1.playNext_(arg_386_0)
			if arg_386_0 == 1 then
				arg_384_0:Play319501094(arg_384_1)
			end
		end

		function arg_384_1.onSingleLineUpdate_(arg_387_0)
			local var_387_0 = 0
			local var_387_1 = 0.75

			if var_387_0 < arg_384_1.time_ and arg_384_1.time_ <= var_387_0 + arg_387_0 then
				arg_384_1.talkMaxDuration = 0
				arg_384_1.dialogCg_.alpha = 1

				arg_384_1.dialog_:SetActive(true)
				SetActive(arg_384_1.leftNameGo_, true)

				local var_387_2 = arg_384_1:FormatText(StoryNameCfg[6].name)

				arg_384_1.leftNameTxt_.text = var_387_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_384_1.leftNameTxt_.transform)

				arg_384_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_384_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_384_1:RecordName(arg_384_1.leftNameTxt_.text)
				SetActive(arg_384_1.iconTrs_.gameObject, false)
				arg_384_1.callingController_:SetSelectedState("normal")

				local var_387_3 = arg_384_1:GetWordFromCfg(319501093)
				local var_387_4 = arg_384_1:FormatText(var_387_3.content)

				arg_384_1.text_.text = var_387_4

				LuaForUtil.ClearLinePrefixSymbol(arg_384_1.text_)

				local var_387_5 = 30
				local var_387_6 = utf8.len(var_387_4)
				local var_387_7 = var_387_5 <= 0 and var_387_1 or var_387_1 * (var_387_6 / var_387_5)

				if var_387_7 > 0 and var_387_1 < var_387_7 then
					arg_384_1.talkMaxDuration = var_387_7

					if var_387_7 + var_387_0 > arg_384_1.duration_ then
						arg_384_1.duration_ = var_387_7 + var_387_0
					end
				end

				arg_384_1.text_.text = var_387_4
				arg_384_1.typewritter.percent = 0

				arg_384_1.typewritter:SetDirty()
				arg_384_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_319501", "319501093", "story_v_out_319501.awb") ~= 0 then
					local var_387_8 = manager.audio:GetVoiceLength("story_v_out_319501", "319501093", "story_v_out_319501.awb") / 1000

					if var_387_8 + var_387_0 > arg_384_1.duration_ then
						arg_384_1.duration_ = var_387_8 + var_387_0
					end

					if var_387_3.prefab_name ~= "" and arg_384_1.actors_[var_387_3.prefab_name] ~= nil then
						local var_387_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_384_1.actors_[var_387_3.prefab_name].transform, "story_v_out_319501", "319501093", "story_v_out_319501.awb")

						arg_384_1:RecordAudio("319501093", var_387_9)
						arg_384_1:RecordAudio("319501093", var_387_9)
					else
						arg_384_1:AudioAction("play", "voice", "story_v_out_319501", "319501093", "story_v_out_319501.awb")
					end

					arg_384_1:RecordHistoryTalkVoice("story_v_out_319501", "319501093", "story_v_out_319501.awb")
				end

				arg_384_1:RecordContent(arg_384_1.text_.text)
			end

			local var_387_10 = math.max(var_387_1, arg_384_1.talkMaxDuration)

			if var_387_0 <= arg_384_1.time_ and arg_384_1.time_ < var_387_0 + var_387_10 then
				arg_384_1.typewritter.percent = (arg_384_1.time_ - var_387_0) / var_387_10

				arg_384_1.typewritter:SetDirty()
			end

			if arg_384_1.time_ >= var_387_0 + var_387_10 and arg_384_1.time_ < var_387_0 + var_387_10 + arg_387_0 then
				arg_384_1.typewritter.percent = 1

				arg_384_1.typewritter:SetDirty()
				arg_384_1:ShowNextGo(true)
			end
		end

		arg_384_1.nodeConfigList_ = {}

		arg_384_1:InitPlayNodeList()
	end,
	Play319501094 = function(arg_388_0, arg_388_1)
		arg_388_1.time_ = 0
		arg_388_1.frameCnt_ = 0
		arg_388_1.state_ = "playing"
		arg_388_1.curTalkId_ = 319501094
		arg_388_1.duration_ = 6.83

		local var_388_0 = {
			zh = 6.833,
			ja = 6.233
		}
		local var_388_1 = manager.audio:GetLocalizationFlag()

		if var_388_0[var_388_1] ~= nil then
			arg_388_1.duration_ = var_388_0[var_388_1]
		end

		SetActive(arg_388_1.tipsGo_, false)

		function arg_388_1.onSingleLineFinish_()
			arg_388_1.onSingleLineUpdate_ = nil
			arg_388_1.onSingleLineFinish_ = nil
			arg_388_1.state_ = "waiting"
		end

		function arg_388_1.playNext_(arg_390_0)
			if arg_390_0 == 1 then
				arg_388_0:Play319501095(arg_388_1)
			end
		end

		function arg_388_1.onSingleLineUpdate_(arg_391_0)
			local var_391_0 = 0
			local var_391_1 = 0.725

			if var_391_0 < arg_388_1.time_ and arg_388_1.time_ <= var_391_0 + arg_391_0 then
				arg_388_1.talkMaxDuration = 0
				arg_388_1.dialogCg_.alpha = 1

				arg_388_1.dialog_:SetActive(true)
				SetActive(arg_388_1.leftNameGo_, true)

				local var_391_2 = arg_388_1:FormatText(StoryNameCfg[6].name)

				arg_388_1.leftNameTxt_.text = var_391_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_388_1.leftNameTxt_.transform)

				arg_388_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_388_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_388_1:RecordName(arg_388_1.leftNameTxt_.text)
				SetActive(arg_388_1.iconTrs_.gameObject, false)
				arg_388_1.callingController_:SetSelectedState("normal")

				local var_391_3 = arg_388_1:GetWordFromCfg(319501094)
				local var_391_4 = arg_388_1:FormatText(var_391_3.content)

				arg_388_1.text_.text = var_391_4

				LuaForUtil.ClearLinePrefixSymbol(arg_388_1.text_)

				local var_391_5 = 29
				local var_391_6 = utf8.len(var_391_4)
				local var_391_7 = var_391_5 <= 0 and var_391_1 or var_391_1 * (var_391_6 / var_391_5)

				if var_391_7 > 0 and var_391_1 < var_391_7 then
					arg_388_1.talkMaxDuration = var_391_7

					if var_391_7 + var_391_0 > arg_388_1.duration_ then
						arg_388_1.duration_ = var_391_7 + var_391_0
					end
				end

				arg_388_1.text_.text = var_391_4
				arg_388_1.typewritter.percent = 0

				arg_388_1.typewritter:SetDirty()
				arg_388_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_319501", "319501094", "story_v_out_319501.awb") ~= 0 then
					local var_391_8 = manager.audio:GetVoiceLength("story_v_out_319501", "319501094", "story_v_out_319501.awb") / 1000

					if var_391_8 + var_391_0 > arg_388_1.duration_ then
						arg_388_1.duration_ = var_391_8 + var_391_0
					end

					if var_391_3.prefab_name ~= "" and arg_388_1.actors_[var_391_3.prefab_name] ~= nil then
						local var_391_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_388_1.actors_[var_391_3.prefab_name].transform, "story_v_out_319501", "319501094", "story_v_out_319501.awb")

						arg_388_1:RecordAudio("319501094", var_391_9)
						arg_388_1:RecordAudio("319501094", var_391_9)
					else
						arg_388_1:AudioAction("play", "voice", "story_v_out_319501", "319501094", "story_v_out_319501.awb")
					end

					arg_388_1:RecordHistoryTalkVoice("story_v_out_319501", "319501094", "story_v_out_319501.awb")
				end

				arg_388_1:RecordContent(arg_388_1.text_.text)
			end

			local var_391_10 = math.max(var_391_1, arg_388_1.talkMaxDuration)

			if var_391_0 <= arg_388_1.time_ and arg_388_1.time_ < var_391_0 + var_391_10 then
				arg_388_1.typewritter.percent = (arg_388_1.time_ - var_391_0) / var_391_10

				arg_388_1.typewritter:SetDirty()
			end

			if arg_388_1.time_ >= var_391_0 + var_391_10 and arg_388_1.time_ < var_391_0 + var_391_10 + arg_391_0 then
				arg_388_1.typewritter.percent = 1

				arg_388_1.typewritter:SetDirty()
				arg_388_1:ShowNextGo(true)
			end
		end

		arg_388_1.nodeConfigList_ = {}

		arg_388_1:InitPlayNodeList()
	end,
	Play319501095 = function(arg_392_0, arg_392_1)
		arg_392_1.time_ = 0
		arg_392_1.frameCnt_ = 0
		arg_392_1.state_ = "playing"
		arg_392_1.curTalkId_ = 319501095
		arg_392_1.duration_ = 16.37

		local var_392_0 = {
			zh = 12.066,
			ja = 16.366
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
				arg_392_0:Play319501096(arg_392_1)
			end
		end

		function arg_392_1.onSingleLineUpdate_(arg_395_0)
			local var_395_0 = 0
			local var_395_1 = 1.275

			if var_395_0 < arg_392_1.time_ and arg_392_1.time_ <= var_395_0 + arg_395_0 then
				arg_392_1.talkMaxDuration = 0
				arg_392_1.dialogCg_.alpha = 1

				arg_392_1.dialog_:SetActive(true)
				SetActive(arg_392_1.leftNameGo_, true)

				local var_395_2 = arg_392_1:FormatText(StoryNameCfg[6].name)

				arg_392_1.leftNameTxt_.text = var_395_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_392_1.leftNameTxt_.transform)

				arg_392_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_392_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_392_1:RecordName(arg_392_1.leftNameTxt_.text)
				SetActive(arg_392_1.iconTrs_.gameObject, false)
				arg_392_1.callingController_:SetSelectedState("normal")

				local var_395_3 = arg_392_1:GetWordFromCfg(319501095)
				local var_395_4 = arg_392_1:FormatText(var_395_3.content)

				arg_392_1.text_.text = var_395_4

				LuaForUtil.ClearLinePrefixSymbol(arg_392_1.text_)

				local var_395_5 = 51
				local var_395_6 = utf8.len(var_395_4)
				local var_395_7 = var_395_5 <= 0 and var_395_1 or var_395_1 * (var_395_6 / var_395_5)

				if var_395_7 > 0 and var_395_1 < var_395_7 then
					arg_392_1.talkMaxDuration = var_395_7

					if var_395_7 + var_395_0 > arg_392_1.duration_ then
						arg_392_1.duration_ = var_395_7 + var_395_0
					end
				end

				arg_392_1.text_.text = var_395_4
				arg_392_1.typewritter.percent = 0

				arg_392_1.typewritter:SetDirty()
				arg_392_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_319501", "319501095", "story_v_out_319501.awb") ~= 0 then
					local var_395_8 = manager.audio:GetVoiceLength("story_v_out_319501", "319501095", "story_v_out_319501.awb") / 1000

					if var_395_8 + var_395_0 > arg_392_1.duration_ then
						arg_392_1.duration_ = var_395_8 + var_395_0
					end

					if var_395_3.prefab_name ~= "" and arg_392_1.actors_[var_395_3.prefab_name] ~= nil then
						local var_395_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_392_1.actors_[var_395_3.prefab_name].transform, "story_v_out_319501", "319501095", "story_v_out_319501.awb")

						arg_392_1:RecordAudio("319501095", var_395_9)
						arg_392_1:RecordAudio("319501095", var_395_9)
					else
						arg_392_1:AudioAction("play", "voice", "story_v_out_319501", "319501095", "story_v_out_319501.awb")
					end

					arg_392_1:RecordHistoryTalkVoice("story_v_out_319501", "319501095", "story_v_out_319501.awb")
				end

				arg_392_1:RecordContent(arg_392_1.text_.text)
			end

			local var_395_10 = math.max(var_395_1, arg_392_1.talkMaxDuration)

			if var_395_0 <= arg_392_1.time_ and arg_392_1.time_ < var_395_0 + var_395_10 then
				arg_392_1.typewritter.percent = (arg_392_1.time_ - var_395_0) / var_395_10

				arg_392_1.typewritter:SetDirty()
			end

			if arg_392_1.time_ >= var_395_0 + var_395_10 and arg_392_1.time_ < var_395_0 + var_395_10 + arg_395_0 then
				arg_392_1.typewritter.percent = 1

				arg_392_1.typewritter:SetDirty()
				arg_392_1:ShowNextGo(true)
			end
		end

		arg_392_1.nodeConfigList_ = {}

		arg_392_1:InitPlayNodeList()
	end,
	Play319501096 = function(arg_396_0, arg_396_1)
		arg_396_1.time_ = 0
		arg_396_1.frameCnt_ = 0
		arg_396_1.state_ = "playing"
		arg_396_1.curTalkId_ = 319501096
		arg_396_1.duration_ = 10.73

		local var_396_0 = {
			zh = 7.8,
			ja = 10.733
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
				arg_396_0:Play319501097(arg_396_1)
			end
		end

		function arg_396_1.onSingleLineUpdate_(arg_399_0)
			local var_399_0 = 0
			local var_399_1 = 0.775

			if var_399_0 < arg_396_1.time_ and arg_396_1.time_ <= var_399_0 + arg_399_0 then
				arg_396_1.talkMaxDuration = 0
				arg_396_1.dialogCg_.alpha = 1

				arg_396_1.dialog_:SetActive(true)
				SetActive(arg_396_1.leftNameGo_, true)

				local var_399_2 = arg_396_1:FormatText(StoryNameCfg[6].name)

				arg_396_1.leftNameTxt_.text = var_399_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_396_1.leftNameTxt_.transform)

				arg_396_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_396_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_396_1:RecordName(arg_396_1.leftNameTxt_.text)
				SetActive(arg_396_1.iconTrs_.gameObject, false)
				arg_396_1.callingController_:SetSelectedState("normal")

				local var_399_3 = arg_396_1:GetWordFromCfg(319501096)
				local var_399_4 = arg_396_1:FormatText(var_399_3.content)

				arg_396_1.text_.text = var_399_4

				LuaForUtil.ClearLinePrefixSymbol(arg_396_1.text_)

				local var_399_5 = 31
				local var_399_6 = utf8.len(var_399_4)
				local var_399_7 = var_399_5 <= 0 and var_399_1 or var_399_1 * (var_399_6 / var_399_5)

				if var_399_7 > 0 and var_399_1 < var_399_7 then
					arg_396_1.talkMaxDuration = var_399_7

					if var_399_7 + var_399_0 > arg_396_1.duration_ then
						arg_396_1.duration_ = var_399_7 + var_399_0
					end
				end

				arg_396_1.text_.text = var_399_4
				arg_396_1.typewritter.percent = 0

				arg_396_1.typewritter:SetDirty()
				arg_396_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_319501", "319501096", "story_v_out_319501.awb") ~= 0 then
					local var_399_8 = manager.audio:GetVoiceLength("story_v_out_319501", "319501096", "story_v_out_319501.awb") / 1000

					if var_399_8 + var_399_0 > arg_396_1.duration_ then
						arg_396_1.duration_ = var_399_8 + var_399_0
					end

					if var_399_3.prefab_name ~= "" and arg_396_1.actors_[var_399_3.prefab_name] ~= nil then
						local var_399_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_396_1.actors_[var_399_3.prefab_name].transform, "story_v_out_319501", "319501096", "story_v_out_319501.awb")

						arg_396_1:RecordAudio("319501096", var_399_9)
						arg_396_1:RecordAudio("319501096", var_399_9)
					else
						arg_396_1:AudioAction("play", "voice", "story_v_out_319501", "319501096", "story_v_out_319501.awb")
					end

					arg_396_1:RecordHistoryTalkVoice("story_v_out_319501", "319501096", "story_v_out_319501.awb")
				end

				arg_396_1:RecordContent(arg_396_1.text_.text)
			end

			local var_399_10 = math.max(var_399_1, arg_396_1.talkMaxDuration)

			if var_399_0 <= arg_396_1.time_ and arg_396_1.time_ < var_399_0 + var_399_10 then
				arg_396_1.typewritter.percent = (arg_396_1.time_ - var_399_0) / var_399_10

				arg_396_1.typewritter:SetDirty()
			end

			if arg_396_1.time_ >= var_399_0 + var_399_10 and arg_396_1.time_ < var_399_0 + var_399_10 + arg_399_0 then
				arg_396_1.typewritter.percent = 1

				arg_396_1.typewritter:SetDirty()
				arg_396_1:ShowNextGo(true)
			end
		end

		arg_396_1.nodeConfigList_ = {}

		arg_396_1:InitPlayNodeList()
	end,
	Play319501097 = function(arg_400_0, arg_400_1)
		arg_400_1.time_ = 0
		arg_400_1.frameCnt_ = 0
		arg_400_1.state_ = "playing"
		arg_400_1.curTalkId_ = 319501097
		arg_400_1.duration_ = 14.17

		local var_400_0 = {
			zh = 8.566,
			ja = 14.166
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
				arg_400_0:Play319501098(arg_400_1)
			end
		end

		function arg_400_1.onSingleLineUpdate_(arg_403_0)
			local var_403_0 = 0
			local var_403_1 = 0.925

			if var_403_0 < arg_400_1.time_ and arg_400_1.time_ <= var_403_0 + arg_403_0 then
				arg_400_1.talkMaxDuration = 0
				arg_400_1.dialogCg_.alpha = 1

				arg_400_1.dialog_:SetActive(true)
				SetActive(arg_400_1.leftNameGo_, true)

				local var_403_2 = arg_400_1:FormatText(StoryNameCfg[6].name)

				arg_400_1.leftNameTxt_.text = var_403_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_400_1.leftNameTxt_.transform)

				arg_400_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_400_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_400_1:RecordName(arg_400_1.leftNameTxt_.text)
				SetActive(arg_400_1.iconTrs_.gameObject, false)
				arg_400_1.callingController_:SetSelectedState("normal")

				local var_403_3 = arg_400_1:GetWordFromCfg(319501097)
				local var_403_4 = arg_400_1:FormatText(var_403_3.content)

				arg_400_1.text_.text = var_403_4

				LuaForUtil.ClearLinePrefixSymbol(arg_400_1.text_)

				local var_403_5 = 37
				local var_403_6 = utf8.len(var_403_4)
				local var_403_7 = var_403_5 <= 0 and var_403_1 or var_403_1 * (var_403_6 / var_403_5)

				if var_403_7 > 0 and var_403_1 < var_403_7 then
					arg_400_1.talkMaxDuration = var_403_7

					if var_403_7 + var_403_0 > arg_400_1.duration_ then
						arg_400_1.duration_ = var_403_7 + var_403_0
					end
				end

				arg_400_1.text_.text = var_403_4
				arg_400_1.typewritter.percent = 0

				arg_400_1.typewritter:SetDirty()
				arg_400_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_319501", "319501097", "story_v_out_319501.awb") ~= 0 then
					local var_403_8 = manager.audio:GetVoiceLength("story_v_out_319501", "319501097", "story_v_out_319501.awb") / 1000

					if var_403_8 + var_403_0 > arg_400_1.duration_ then
						arg_400_1.duration_ = var_403_8 + var_403_0
					end

					if var_403_3.prefab_name ~= "" and arg_400_1.actors_[var_403_3.prefab_name] ~= nil then
						local var_403_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_400_1.actors_[var_403_3.prefab_name].transform, "story_v_out_319501", "319501097", "story_v_out_319501.awb")

						arg_400_1:RecordAudio("319501097", var_403_9)
						arg_400_1:RecordAudio("319501097", var_403_9)
					else
						arg_400_1:AudioAction("play", "voice", "story_v_out_319501", "319501097", "story_v_out_319501.awb")
					end

					arg_400_1:RecordHistoryTalkVoice("story_v_out_319501", "319501097", "story_v_out_319501.awb")
				end

				arg_400_1:RecordContent(arg_400_1.text_.text)
			end

			local var_403_10 = math.max(var_403_1, arg_400_1.talkMaxDuration)

			if var_403_0 <= arg_400_1.time_ and arg_400_1.time_ < var_403_0 + var_403_10 then
				arg_400_1.typewritter.percent = (arg_400_1.time_ - var_403_0) / var_403_10

				arg_400_1.typewritter:SetDirty()
			end

			if arg_400_1.time_ >= var_403_0 + var_403_10 and arg_400_1.time_ < var_403_0 + var_403_10 + arg_403_0 then
				arg_400_1.typewritter.percent = 1

				arg_400_1.typewritter:SetDirty()
				arg_400_1:ShowNextGo(true)
			end
		end

		arg_400_1.nodeConfigList_ = {}

		arg_400_1:InitPlayNodeList()
	end,
	Play319501098 = function(arg_404_0, arg_404_1)
		arg_404_1.time_ = 0
		arg_404_1.frameCnt_ = 0
		arg_404_1.state_ = "playing"
		arg_404_1.curTalkId_ = 319501098
		arg_404_1.duration_ = 16.7

		local var_404_0 = {
			zh = 11.3,
			ja = 16.7
		}
		local var_404_1 = manager.audio:GetLocalizationFlag()

		if var_404_0[var_404_1] ~= nil then
			arg_404_1.duration_ = var_404_0[var_404_1]
		end

		SetActive(arg_404_1.tipsGo_, false)

		function arg_404_1.onSingleLineFinish_()
			arg_404_1.onSingleLineUpdate_ = nil
			arg_404_1.onSingleLineFinish_ = nil
			arg_404_1.state_ = "waiting"
		end

		function arg_404_1.playNext_(arg_406_0)
			if arg_406_0 == 1 then
				arg_404_0:Play319501099(arg_404_1)
			end
		end

		function arg_404_1.onSingleLineUpdate_(arg_407_0)
			local var_407_0 = 0
			local var_407_1 = 1.275

			if var_407_0 < arg_404_1.time_ and arg_404_1.time_ <= var_407_0 + arg_407_0 then
				arg_404_1.talkMaxDuration = 0
				arg_404_1.dialogCg_.alpha = 1

				arg_404_1.dialog_:SetActive(true)
				SetActive(arg_404_1.leftNameGo_, true)

				local var_407_2 = arg_404_1:FormatText(StoryNameCfg[6].name)

				arg_404_1.leftNameTxt_.text = var_407_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_404_1.leftNameTxt_.transform)

				arg_404_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_404_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_404_1:RecordName(arg_404_1.leftNameTxt_.text)
				SetActive(arg_404_1.iconTrs_.gameObject, false)
				arg_404_1.callingController_:SetSelectedState("normal")

				local var_407_3 = arg_404_1:GetWordFromCfg(319501098)
				local var_407_4 = arg_404_1:FormatText(var_407_3.content)

				arg_404_1.text_.text = var_407_4

				LuaForUtil.ClearLinePrefixSymbol(arg_404_1.text_)

				local var_407_5 = 51
				local var_407_6 = utf8.len(var_407_4)
				local var_407_7 = var_407_5 <= 0 and var_407_1 or var_407_1 * (var_407_6 / var_407_5)

				if var_407_7 > 0 and var_407_1 < var_407_7 then
					arg_404_1.talkMaxDuration = var_407_7

					if var_407_7 + var_407_0 > arg_404_1.duration_ then
						arg_404_1.duration_ = var_407_7 + var_407_0
					end
				end

				arg_404_1.text_.text = var_407_4
				arg_404_1.typewritter.percent = 0

				arg_404_1.typewritter:SetDirty()
				arg_404_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_319501", "319501098", "story_v_out_319501.awb") ~= 0 then
					local var_407_8 = manager.audio:GetVoiceLength("story_v_out_319501", "319501098", "story_v_out_319501.awb") / 1000

					if var_407_8 + var_407_0 > arg_404_1.duration_ then
						arg_404_1.duration_ = var_407_8 + var_407_0
					end

					if var_407_3.prefab_name ~= "" and arg_404_1.actors_[var_407_3.prefab_name] ~= nil then
						local var_407_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_404_1.actors_[var_407_3.prefab_name].transform, "story_v_out_319501", "319501098", "story_v_out_319501.awb")

						arg_404_1:RecordAudio("319501098", var_407_9)
						arg_404_1:RecordAudio("319501098", var_407_9)
					else
						arg_404_1:AudioAction("play", "voice", "story_v_out_319501", "319501098", "story_v_out_319501.awb")
					end

					arg_404_1:RecordHistoryTalkVoice("story_v_out_319501", "319501098", "story_v_out_319501.awb")
				end

				arg_404_1:RecordContent(arg_404_1.text_.text)
			end

			local var_407_10 = math.max(var_407_1, arg_404_1.talkMaxDuration)

			if var_407_0 <= arg_404_1.time_ and arg_404_1.time_ < var_407_0 + var_407_10 then
				arg_404_1.typewritter.percent = (arg_404_1.time_ - var_407_0) / var_407_10

				arg_404_1.typewritter:SetDirty()
			end

			if arg_404_1.time_ >= var_407_0 + var_407_10 and arg_404_1.time_ < var_407_0 + var_407_10 + arg_407_0 then
				arg_404_1.typewritter.percent = 1

				arg_404_1.typewritter:SetDirty()
				arg_404_1:ShowNextGo(true)
			end
		end

		arg_404_1.nodeConfigList_ = {}

		arg_404_1:InitPlayNodeList()
	end,
	Play319501099 = function(arg_408_0, arg_408_1)
		arg_408_1.time_ = 0
		arg_408_1.frameCnt_ = 0
		arg_408_1.state_ = "playing"
		arg_408_1.curTalkId_ = 319501099
		arg_408_1.duration_ = 11.7

		local var_408_0 = {
			zh = 7.8,
			ja = 11.7
		}
		local var_408_1 = manager.audio:GetLocalizationFlag()

		if var_408_0[var_408_1] ~= nil then
			arg_408_1.duration_ = var_408_0[var_408_1]
		end

		SetActive(arg_408_1.tipsGo_, false)

		function arg_408_1.onSingleLineFinish_()
			arg_408_1.onSingleLineUpdate_ = nil
			arg_408_1.onSingleLineFinish_ = nil
			arg_408_1.state_ = "waiting"
		end

		function arg_408_1.playNext_(arg_410_0)
			if arg_410_0 == 1 then
				arg_408_0:Play319501100(arg_408_1)
			end
		end

		function arg_408_1.onSingleLineUpdate_(arg_411_0)
			local var_411_0 = 0
			local var_411_1 = 0.95

			if var_411_0 < arg_408_1.time_ and arg_408_1.time_ <= var_411_0 + arg_411_0 then
				arg_408_1.talkMaxDuration = 0
				arg_408_1.dialogCg_.alpha = 1

				arg_408_1.dialog_:SetActive(true)
				SetActive(arg_408_1.leftNameGo_, true)

				local var_411_2 = arg_408_1:FormatText(StoryNameCfg[6].name)

				arg_408_1.leftNameTxt_.text = var_411_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_408_1.leftNameTxt_.transform)

				arg_408_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_408_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_408_1:RecordName(arg_408_1.leftNameTxt_.text)
				SetActive(arg_408_1.iconTrs_.gameObject, false)
				arg_408_1.callingController_:SetSelectedState("normal")

				local var_411_3 = arg_408_1:GetWordFromCfg(319501099)
				local var_411_4 = arg_408_1:FormatText(var_411_3.content)

				arg_408_1.text_.text = var_411_4

				LuaForUtil.ClearLinePrefixSymbol(arg_408_1.text_)

				local var_411_5 = 38
				local var_411_6 = utf8.len(var_411_4)
				local var_411_7 = var_411_5 <= 0 and var_411_1 or var_411_1 * (var_411_6 / var_411_5)

				if var_411_7 > 0 and var_411_1 < var_411_7 then
					arg_408_1.talkMaxDuration = var_411_7

					if var_411_7 + var_411_0 > arg_408_1.duration_ then
						arg_408_1.duration_ = var_411_7 + var_411_0
					end
				end

				arg_408_1.text_.text = var_411_4
				arg_408_1.typewritter.percent = 0

				arg_408_1.typewritter:SetDirty()
				arg_408_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_319501", "319501099", "story_v_out_319501.awb") ~= 0 then
					local var_411_8 = manager.audio:GetVoiceLength("story_v_out_319501", "319501099", "story_v_out_319501.awb") / 1000

					if var_411_8 + var_411_0 > arg_408_1.duration_ then
						arg_408_1.duration_ = var_411_8 + var_411_0
					end

					if var_411_3.prefab_name ~= "" and arg_408_1.actors_[var_411_3.prefab_name] ~= nil then
						local var_411_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_408_1.actors_[var_411_3.prefab_name].transform, "story_v_out_319501", "319501099", "story_v_out_319501.awb")

						arg_408_1:RecordAudio("319501099", var_411_9)
						arg_408_1:RecordAudio("319501099", var_411_9)
					else
						arg_408_1:AudioAction("play", "voice", "story_v_out_319501", "319501099", "story_v_out_319501.awb")
					end

					arg_408_1:RecordHistoryTalkVoice("story_v_out_319501", "319501099", "story_v_out_319501.awb")
				end

				arg_408_1:RecordContent(arg_408_1.text_.text)
			end

			local var_411_10 = math.max(var_411_1, arg_408_1.talkMaxDuration)

			if var_411_0 <= arg_408_1.time_ and arg_408_1.time_ < var_411_0 + var_411_10 then
				arg_408_1.typewritter.percent = (arg_408_1.time_ - var_411_0) / var_411_10

				arg_408_1.typewritter:SetDirty()
			end

			if arg_408_1.time_ >= var_411_0 + var_411_10 and arg_408_1.time_ < var_411_0 + var_411_10 + arg_411_0 then
				arg_408_1.typewritter.percent = 1

				arg_408_1.typewritter:SetDirty()
				arg_408_1:ShowNextGo(true)
			end
		end

		arg_408_1.nodeConfigList_ = {}

		arg_408_1:InitPlayNodeList()
	end,
	Play319501100 = function(arg_412_0, arg_412_1)
		arg_412_1.time_ = 0
		arg_412_1.frameCnt_ = 0
		arg_412_1.state_ = "playing"
		arg_412_1.curTalkId_ = 319501100
		arg_412_1.duration_ = 6.8

		local var_412_0 = {
			zh = 5.833,
			ja = 6.8
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
				arg_412_0:Play319501101(arg_412_1)
			end
		end

		function arg_412_1.onSingleLineUpdate_(arg_415_0)
			local var_415_0 = 0
			local var_415_1 = 0.675

			if var_415_0 < arg_412_1.time_ and arg_412_1.time_ <= var_415_0 + arg_415_0 then
				arg_412_1.talkMaxDuration = 0
				arg_412_1.dialogCg_.alpha = 1

				arg_412_1.dialog_:SetActive(true)
				SetActive(arg_412_1.leftNameGo_, true)

				local var_415_2 = arg_412_1:FormatText(StoryNameCfg[6].name)

				arg_412_1.leftNameTxt_.text = var_415_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_412_1.leftNameTxt_.transform)

				arg_412_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_412_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_412_1:RecordName(arg_412_1.leftNameTxt_.text)
				SetActive(arg_412_1.iconTrs_.gameObject, false)
				arg_412_1.callingController_:SetSelectedState("normal")

				local var_415_3 = arg_412_1:GetWordFromCfg(319501100)
				local var_415_4 = arg_412_1:FormatText(var_415_3.content)

				arg_412_1.text_.text = var_415_4

				LuaForUtil.ClearLinePrefixSymbol(arg_412_1.text_)

				local var_415_5 = 27
				local var_415_6 = utf8.len(var_415_4)
				local var_415_7 = var_415_5 <= 0 and var_415_1 or var_415_1 * (var_415_6 / var_415_5)

				if var_415_7 > 0 and var_415_1 < var_415_7 then
					arg_412_1.talkMaxDuration = var_415_7

					if var_415_7 + var_415_0 > arg_412_1.duration_ then
						arg_412_1.duration_ = var_415_7 + var_415_0
					end
				end

				arg_412_1.text_.text = var_415_4
				arg_412_1.typewritter.percent = 0

				arg_412_1.typewritter:SetDirty()
				arg_412_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_319501", "319501100", "story_v_out_319501.awb") ~= 0 then
					local var_415_8 = manager.audio:GetVoiceLength("story_v_out_319501", "319501100", "story_v_out_319501.awb") / 1000

					if var_415_8 + var_415_0 > arg_412_1.duration_ then
						arg_412_1.duration_ = var_415_8 + var_415_0
					end

					if var_415_3.prefab_name ~= "" and arg_412_1.actors_[var_415_3.prefab_name] ~= nil then
						local var_415_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_412_1.actors_[var_415_3.prefab_name].transform, "story_v_out_319501", "319501100", "story_v_out_319501.awb")

						arg_412_1:RecordAudio("319501100", var_415_9)
						arg_412_1:RecordAudio("319501100", var_415_9)
					else
						arg_412_1:AudioAction("play", "voice", "story_v_out_319501", "319501100", "story_v_out_319501.awb")
					end

					arg_412_1:RecordHistoryTalkVoice("story_v_out_319501", "319501100", "story_v_out_319501.awb")
				end

				arg_412_1:RecordContent(arg_412_1.text_.text)
			end

			local var_415_10 = math.max(var_415_1, arg_412_1.talkMaxDuration)

			if var_415_0 <= arg_412_1.time_ and arg_412_1.time_ < var_415_0 + var_415_10 then
				arg_412_1.typewritter.percent = (arg_412_1.time_ - var_415_0) / var_415_10

				arg_412_1.typewritter:SetDirty()
			end

			if arg_412_1.time_ >= var_415_0 + var_415_10 and arg_412_1.time_ < var_415_0 + var_415_10 + arg_415_0 then
				arg_412_1.typewritter.percent = 1

				arg_412_1.typewritter:SetDirty()
				arg_412_1:ShowNextGo(true)
			end
		end

		arg_412_1.nodeConfigList_ = {}

		arg_412_1:InitPlayNodeList()
	end,
	Play319501101 = function(arg_416_0, arg_416_1)
		arg_416_1.time_ = 0
		arg_416_1.frameCnt_ = 0
		arg_416_1.state_ = "playing"
		arg_416_1.curTalkId_ = 319501101
		arg_416_1.duration_ = 2.43

		local var_416_0 = {
			zh = 1.033,
			ja = 2.433
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
				arg_416_0:Play319501102(arg_416_1)
			end
		end

		function arg_416_1.onSingleLineUpdate_(arg_419_0)
			local var_419_0 = 0
			local var_419_1 = 0.1

			if var_419_0 < arg_416_1.time_ and arg_416_1.time_ <= var_419_0 + arg_419_0 then
				arg_416_1.talkMaxDuration = 0
				arg_416_1.dialogCg_.alpha = 1

				arg_416_1.dialog_:SetActive(true)
				SetActive(arg_416_1.leftNameGo_, true)

				local var_419_2 = arg_416_1:FormatText(StoryNameCfg[6].name)

				arg_416_1.leftNameTxt_.text = var_419_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_416_1.leftNameTxt_.transform)

				arg_416_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_416_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_416_1:RecordName(arg_416_1.leftNameTxt_.text)
				SetActive(arg_416_1.iconTrs_.gameObject, false)
				arg_416_1.callingController_:SetSelectedState("normal")

				local var_419_3 = arg_416_1:GetWordFromCfg(319501101)
				local var_419_4 = arg_416_1:FormatText(var_419_3.content)

				arg_416_1.text_.text = var_419_4

				LuaForUtil.ClearLinePrefixSymbol(arg_416_1.text_)

				local var_419_5 = 4
				local var_419_6 = utf8.len(var_419_4)
				local var_419_7 = var_419_5 <= 0 and var_419_1 or var_419_1 * (var_419_6 / var_419_5)

				if var_419_7 > 0 and var_419_1 < var_419_7 then
					arg_416_1.talkMaxDuration = var_419_7

					if var_419_7 + var_419_0 > arg_416_1.duration_ then
						arg_416_1.duration_ = var_419_7 + var_419_0
					end
				end

				arg_416_1.text_.text = var_419_4
				arg_416_1.typewritter.percent = 0

				arg_416_1.typewritter:SetDirty()
				arg_416_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_319501", "319501101", "story_v_out_319501.awb") ~= 0 then
					local var_419_8 = manager.audio:GetVoiceLength("story_v_out_319501", "319501101", "story_v_out_319501.awb") / 1000

					if var_419_8 + var_419_0 > arg_416_1.duration_ then
						arg_416_1.duration_ = var_419_8 + var_419_0
					end

					if var_419_3.prefab_name ~= "" and arg_416_1.actors_[var_419_3.prefab_name] ~= nil then
						local var_419_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_416_1.actors_[var_419_3.prefab_name].transform, "story_v_out_319501", "319501101", "story_v_out_319501.awb")

						arg_416_1:RecordAudio("319501101", var_419_9)
						arg_416_1:RecordAudio("319501101", var_419_9)
					else
						arg_416_1:AudioAction("play", "voice", "story_v_out_319501", "319501101", "story_v_out_319501.awb")
					end

					arg_416_1:RecordHistoryTalkVoice("story_v_out_319501", "319501101", "story_v_out_319501.awb")
				end

				arg_416_1:RecordContent(arg_416_1.text_.text)
			end

			local var_419_10 = math.max(var_419_1, arg_416_1.talkMaxDuration)

			if var_419_0 <= arg_416_1.time_ and arg_416_1.time_ < var_419_0 + var_419_10 then
				arg_416_1.typewritter.percent = (arg_416_1.time_ - var_419_0) / var_419_10

				arg_416_1.typewritter:SetDirty()
			end

			if arg_416_1.time_ >= var_419_0 + var_419_10 and arg_416_1.time_ < var_419_0 + var_419_10 + arg_419_0 then
				arg_416_1.typewritter.percent = 1

				arg_416_1.typewritter:SetDirty()
				arg_416_1:ShowNextGo(true)
			end
		end

		arg_416_1.nodeConfigList_ = {}

		arg_416_1:InitPlayNodeList()
	end,
	Play319501102 = function(arg_420_0, arg_420_1)
		arg_420_1.time_ = 0
		arg_420_1.frameCnt_ = 0
		arg_420_1.state_ = "playing"
		arg_420_1.curTalkId_ = 319501102
		arg_420_1.duration_ = 4.52

		SetActive(arg_420_1.tipsGo_, false)

		function arg_420_1.onSingleLineFinish_()
			arg_420_1.onSingleLineUpdate_ = nil
			arg_420_1.onSingleLineFinish_ = nil
			arg_420_1.state_ = "waiting"
		end

		function arg_420_1.playNext_(arg_422_0)
			if arg_422_0 == 1 then
				arg_420_0:Play319501103(arg_420_1)
			end
		end

		function arg_420_1.onSingleLineUpdate_(arg_423_0)
			local var_423_0 = 0

			if var_423_0 < arg_420_1.time_ and arg_420_1.time_ <= var_423_0 + arg_423_0 then
				arg_420_1.mask_.enabled = true
				arg_420_1.mask_.raycastTarget = true

				arg_420_1:SetGaussion(false)
			end

			local var_423_1 = 2

			if var_423_0 <= arg_420_1.time_ and arg_420_1.time_ < var_423_0 + var_423_1 then
				local var_423_2 = (arg_420_1.time_ - var_423_0) / var_423_1
				local var_423_3 = Color.New(1, 1, 1)

				var_423_3.a = Mathf.Lerp(1, 0, var_423_2)
				arg_420_1.mask_.color = var_423_3
			end

			if arg_420_1.time_ >= var_423_0 + var_423_1 and arg_420_1.time_ < var_423_0 + var_423_1 + arg_423_0 then
				local var_423_4 = Color.New(1, 1, 1)
				local var_423_5 = 0

				arg_420_1.mask_.enabled = false
				var_423_4.a = var_423_5
				arg_420_1.mask_.color = var_423_4
			end

			local var_423_6 = arg_420_1.bgs_.ML0105.transform
			local var_423_7 = 0

			if var_423_7 < arg_420_1.time_ and arg_420_1.time_ <= var_423_7 + arg_423_0 then
				arg_420_1.var_.moveOldPosML0105 = var_423_6.localPosition
			end

			local var_423_8 = 0.001

			if var_423_7 <= arg_420_1.time_ and arg_420_1.time_ < var_423_7 + var_423_8 then
				local var_423_9 = (arg_420_1.time_ - var_423_7) / var_423_8
				local var_423_10 = Vector3.New(0, 1, 9.5)

				var_423_6.localPosition = Vector3.Lerp(arg_420_1.var_.moveOldPosML0105, var_423_10, var_423_9)
			end

			if arg_420_1.time_ >= var_423_7 + var_423_8 and arg_420_1.time_ < var_423_7 + var_423_8 + arg_423_0 then
				var_423_6.localPosition = Vector3.New(0, 1, 9.5)
			end

			local var_423_11 = arg_420_1.bgs_.ML0105.transform
			local var_423_12 = 0.0166666666666667

			if var_423_12 < arg_420_1.time_ and arg_420_1.time_ <= var_423_12 + arg_423_0 then
				arg_420_1.var_.moveOldPosML0105 = var_423_11.localPosition
			end

			local var_423_13 = 4.5

			if var_423_12 <= arg_420_1.time_ and arg_420_1.time_ < var_423_12 + var_423_13 then
				local var_423_14 = (arg_420_1.time_ - var_423_12) / var_423_13
				local var_423_15 = Vector3.New(0, 1, 10)

				var_423_11.localPosition = Vector3.Lerp(arg_420_1.var_.moveOldPosML0105, var_423_15, var_423_14)
			end

			if arg_420_1.time_ >= var_423_12 + var_423_13 and arg_420_1.time_ < var_423_12 + var_423_13 + arg_423_0 then
				var_423_11.localPosition = Vector3.New(0, 1, 10)
			end

			local var_423_16 = 0
			local var_423_17 = 0.4

			if var_423_16 < arg_420_1.time_ and arg_420_1.time_ <= var_423_16 + arg_423_0 then
				arg_420_1.talkMaxDuration = 0
				arg_420_1.dialogCg_.alpha = 1

				arg_420_1.dialog_:SetActive(true)
				SetActive(arg_420_1.leftNameGo_, true)

				local var_423_18 = arg_420_1:FormatText(StoryNameCfg[6].name)

				arg_420_1.leftNameTxt_.text = var_423_18

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_420_1.leftNameTxt_.transform)

				arg_420_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_420_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_420_1:RecordName(arg_420_1.leftNameTxt_.text)
				SetActive(arg_420_1.iconTrs_.gameObject, false)
				arg_420_1.callingController_:SetSelectedState("normal")

				local var_423_19 = arg_420_1:GetWordFromCfg(319501102)
				local var_423_20 = arg_420_1:FormatText(var_423_19.content)

				arg_420_1.text_.text = var_423_20

				LuaForUtil.ClearLinePrefixSymbol(arg_420_1.text_)

				local var_423_21 = 16
				local var_423_22 = utf8.len(var_423_20)
				local var_423_23 = var_423_21 <= 0 and var_423_17 or var_423_17 * (var_423_22 / var_423_21)

				if var_423_23 > 0 and var_423_17 < var_423_23 then
					arg_420_1.talkMaxDuration = var_423_23

					if var_423_23 + var_423_16 > arg_420_1.duration_ then
						arg_420_1.duration_ = var_423_23 + var_423_16
					end
				end

				arg_420_1.text_.text = var_423_20
				arg_420_1.typewritter.percent = 0

				arg_420_1.typewritter:SetDirty()
				arg_420_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_319501", "319501102", "story_v_out_319501.awb") ~= 0 then
					local var_423_24 = manager.audio:GetVoiceLength("story_v_out_319501", "319501102", "story_v_out_319501.awb") / 1000

					if var_423_24 + var_423_16 > arg_420_1.duration_ then
						arg_420_1.duration_ = var_423_24 + var_423_16
					end

					if var_423_19.prefab_name ~= "" and arg_420_1.actors_[var_423_19.prefab_name] ~= nil then
						local var_423_25 = LuaForUtil.PlayVoiceWithCriLipsync(arg_420_1.actors_[var_423_19.prefab_name].transform, "story_v_out_319501", "319501102", "story_v_out_319501.awb")

						arg_420_1:RecordAudio("319501102", var_423_25)
						arg_420_1:RecordAudio("319501102", var_423_25)
					else
						arg_420_1:AudioAction("play", "voice", "story_v_out_319501", "319501102", "story_v_out_319501.awb")
					end

					arg_420_1:RecordHistoryTalkVoice("story_v_out_319501", "319501102", "story_v_out_319501.awb")
				end

				arg_420_1:RecordContent(arg_420_1.text_.text)
			end

			local var_423_26 = math.max(var_423_17, arg_420_1.talkMaxDuration)

			if var_423_16 <= arg_420_1.time_ and arg_420_1.time_ < var_423_16 + var_423_26 then
				arg_420_1.typewritter.percent = (arg_420_1.time_ - var_423_16) / var_423_26

				arg_420_1.typewritter:SetDirty()
			end

			if arg_420_1.time_ >= var_423_16 + var_423_26 and arg_420_1.time_ < var_423_16 + var_423_26 + arg_423_0 then
				arg_420_1.typewritter.percent = 1

				arg_420_1.typewritter:SetDirty()
				arg_420_1:ShowNextGo(true)
			end
		end

		arg_420_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "ML0105",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.0166666666666667,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Background
			},
			{
				assetPath = "",
				actorName = "ML0105",
				changeDisplayLayer = false,
				needEase = false,
				duration = 4.5,
				className = "StoryMoveNode",
				startTime = 0.0166666666666667,
				actorType = StoryPlayerConst.ACTOR_TYPE.Background
			}
		}

		arg_420_1:InitPlayNodeList()
	end,
	Play319501103 = function(arg_424_0, arg_424_1)
		arg_424_1.time_ = 0
		arg_424_1.frameCnt_ = 0
		arg_424_1.state_ = "playing"
		arg_424_1.curTalkId_ = 319501103
		arg_424_1.duration_ = 5.8

		local var_424_0 = {
			zh = 5.8,
			ja = 5.166
		}
		local var_424_1 = manager.audio:GetLocalizationFlag()

		if var_424_0[var_424_1] ~= nil then
			arg_424_1.duration_ = var_424_0[var_424_1]
		end

		SetActive(arg_424_1.tipsGo_, false)

		function arg_424_1.onSingleLineFinish_()
			arg_424_1.onSingleLineUpdate_ = nil
			arg_424_1.onSingleLineFinish_ = nil
			arg_424_1.state_ = "waiting"
		end

		function arg_424_1.playNext_(arg_426_0)
			if arg_426_0 == 1 then
				arg_424_0:Play319501104(arg_424_1)
			end
		end

		function arg_424_1.onSingleLineUpdate_(arg_427_0)
			local var_427_0 = 0
			local var_427_1 = 0.45

			if var_427_0 < arg_424_1.time_ and arg_424_1.time_ <= var_427_0 + arg_427_0 then
				arg_424_1.talkMaxDuration = 0
				arg_424_1.dialogCg_.alpha = 1

				arg_424_1.dialog_:SetActive(true)
				SetActive(arg_424_1.leftNameGo_, true)

				local var_427_2 = arg_424_1:FormatText(StoryNameCfg[6].name)

				arg_424_1.leftNameTxt_.text = var_427_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_424_1.leftNameTxt_.transform)

				arg_424_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_424_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_424_1:RecordName(arg_424_1.leftNameTxt_.text)
				SetActive(arg_424_1.iconTrs_.gameObject, false)
				arg_424_1.callingController_:SetSelectedState("normal")

				local var_427_3 = arg_424_1:GetWordFromCfg(319501103)
				local var_427_4 = arg_424_1:FormatText(var_427_3.content)

				arg_424_1.text_.text = var_427_4

				LuaForUtil.ClearLinePrefixSymbol(arg_424_1.text_)

				local var_427_5 = 18
				local var_427_6 = utf8.len(var_427_4)
				local var_427_7 = var_427_5 <= 0 and var_427_1 or var_427_1 * (var_427_6 / var_427_5)

				if var_427_7 > 0 and var_427_1 < var_427_7 then
					arg_424_1.talkMaxDuration = var_427_7

					if var_427_7 + var_427_0 > arg_424_1.duration_ then
						arg_424_1.duration_ = var_427_7 + var_427_0
					end
				end

				arg_424_1.text_.text = var_427_4
				arg_424_1.typewritter.percent = 0

				arg_424_1.typewritter:SetDirty()
				arg_424_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_319501", "319501103", "story_v_out_319501.awb") ~= 0 then
					local var_427_8 = manager.audio:GetVoiceLength("story_v_out_319501", "319501103", "story_v_out_319501.awb") / 1000

					if var_427_8 + var_427_0 > arg_424_1.duration_ then
						arg_424_1.duration_ = var_427_8 + var_427_0
					end

					if var_427_3.prefab_name ~= "" and arg_424_1.actors_[var_427_3.prefab_name] ~= nil then
						local var_427_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_424_1.actors_[var_427_3.prefab_name].transform, "story_v_out_319501", "319501103", "story_v_out_319501.awb")

						arg_424_1:RecordAudio("319501103", var_427_9)
						arg_424_1:RecordAudio("319501103", var_427_9)
					else
						arg_424_1:AudioAction("play", "voice", "story_v_out_319501", "319501103", "story_v_out_319501.awb")
					end

					arg_424_1:RecordHistoryTalkVoice("story_v_out_319501", "319501103", "story_v_out_319501.awb")
				end

				arg_424_1:RecordContent(arg_424_1.text_.text)
			end

			local var_427_10 = math.max(var_427_1, arg_424_1.talkMaxDuration)

			if var_427_0 <= arg_424_1.time_ and arg_424_1.time_ < var_427_0 + var_427_10 then
				arg_424_1.typewritter.percent = (arg_424_1.time_ - var_427_0) / var_427_10

				arg_424_1.typewritter:SetDirty()
			end

			if arg_424_1.time_ >= var_427_0 + var_427_10 and arg_424_1.time_ < var_427_0 + var_427_10 + arg_427_0 then
				arg_424_1.typewritter.percent = 1

				arg_424_1.typewritter:SetDirty()
				arg_424_1:ShowNextGo(true)
			end
		end

		arg_424_1.nodeConfigList_ = {}

		arg_424_1:InitPlayNodeList()
	end,
	Play319501104 = function(arg_428_0, arg_428_1)
		arg_428_1.time_ = 0
		arg_428_1.frameCnt_ = 0
		arg_428_1.state_ = "playing"
		arg_428_1.curTalkId_ = 319501104
		arg_428_1.duration_ = 9

		SetActive(arg_428_1.tipsGo_, false)

		function arg_428_1.onSingleLineFinish_()
			arg_428_1.onSingleLineUpdate_ = nil
			arg_428_1.onSingleLineFinish_ = nil
			arg_428_1.state_ = "waiting"
		end

		function arg_428_1.playNext_(arg_430_0)
			if arg_430_0 == 1 then
				arg_428_0:Play319501105(arg_428_1)
			end
		end

		function arg_428_1.onSingleLineUpdate_(arg_431_0)
			local var_431_0 = 2

			if var_431_0 < arg_428_1.time_ and arg_428_1.time_ <= var_431_0 + arg_431_0 then
				local var_431_1 = manager.ui.mainCamera.transform.localPosition
				local var_431_2 = Vector3.New(0, 0, 10) + Vector3.New(var_431_1.x, var_431_1.y, 0)
				local var_431_3 = arg_428_1.bgs_.ST71

				var_431_3.transform.localPosition = var_431_2
				var_431_3.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_431_4 = var_431_3:GetComponent("SpriteRenderer")

				if var_431_4 and var_431_4.sprite then
					local var_431_5 = (var_431_3.transform.localPosition - var_431_1).z
					local var_431_6 = manager.ui.mainCameraCom_
					local var_431_7 = 2 * var_431_5 * Mathf.Tan(var_431_6.fieldOfView * 0.5 * Mathf.Deg2Rad)
					local var_431_8 = var_431_7 * var_431_6.aspect
					local var_431_9 = var_431_4.sprite.bounds.size.x
					local var_431_10 = var_431_4.sprite.bounds.size.y
					local var_431_11 = var_431_8 / var_431_9
					local var_431_12 = var_431_7 / var_431_10
					local var_431_13 = var_431_12 < var_431_11 and var_431_11 or var_431_12

					var_431_3.transform.localScale = Vector3.New(var_431_13, var_431_13, 0)
				end

				for iter_431_0, iter_431_1 in pairs(arg_428_1.bgs_) do
					if iter_431_0 ~= "ST71" then
						iter_431_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_431_14 = 4

			if var_431_14 < arg_428_1.time_ and arg_428_1.time_ <= var_431_14 + arg_431_0 then
				arg_428_1.allBtn_.enabled = false
			end

			local var_431_15 = 0.3

			if arg_428_1.time_ >= var_431_14 + var_431_15 and arg_428_1.time_ < var_431_14 + var_431_15 + arg_431_0 then
				arg_428_1.allBtn_.enabled = true
			end

			local var_431_16 = 0

			if var_431_16 < arg_428_1.time_ and arg_428_1.time_ <= var_431_16 + arg_431_0 then
				arg_428_1.mask_.enabled = true
				arg_428_1.mask_.raycastTarget = true

				arg_428_1:SetGaussion(false)
			end

			local var_431_17 = 2

			if var_431_16 <= arg_428_1.time_ and arg_428_1.time_ < var_431_16 + var_431_17 then
				local var_431_18 = (arg_428_1.time_ - var_431_16) / var_431_17
				local var_431_19 = Color.New(0, 0, 0)

				var_431_19.a = Mathf.Lerp(0, 1, var_431_18)
				arg_428_1.mask_.color = var_431_19
			end

			if arg_428_1.time_ >= var_431_16 + var_431_17 and arg_428_1.time_ < var_431_16 + var_431_17 + arg_431_0 then
				local var_431_20 = Color.New(0, 0, 0)

				var_431_20.a = 1
				arg_428_1.mask_.color = var_431_20
			end

			local var_431_21 = 2

			if var_431_21 < arg_428_1.time_ and arg_428_1.time_ <= var_431_21 + arg_431_0 then
				arg_428_1.mask_.enabled = true
				arg_428_1.mask_.raycastTarget = true

				arg_428_1:SetGaussion(false)
			end

			local var_431_22 = 2

			if var_431_21 <= arg_428_1.time_ and arg_428_1.time_ < var_431_21 + var_431_22 then
				local var_431_23 = (arg_428_1.time_ - var_431_21) / var_431_22
				local var_431_24 = Color.New(0, 0, 0)

				var_431_24.a = Mathf.Lerp(1, 0, var_431_23)
				arg_428_1.mask_.color = var_431_24
			end

			if arg_428_1.time_ >= var_431_21 + var_431_22 and arg_428_1.time_ < var_431_21 + var_431_22 + arg_431_0 then
				local var_431_25 = Color.New(0, 0, 0)
				local var_431_26 = 0

				arg_428_1.mask_.enabled = false
				var_431_25.a = var_431_26
				arg_428_1.mask_.color = var_431_25
			end

			if arg_428_1.frameCnt_ <= 1 then
				arg_428_1.dialog_:SetActive(false)
			end

			local var_431_27 = 4
			local var_431_28 = 1.525

			if var_431_27 < arg_428_1.time_ and arg_428_1.time_ <= var_431_27 + arg_431_0 then
				arg_428_1.talkMaxDuration = 0

				arg_428_1.dialog_:SetActive(true)

				arg_428_1.dialogCg_.alpha = 0

				local var_431_29 = LeanTween.value(arg_428_1.dialog_, 0, 1, 0.3)

				var_431_29:setOnUpdate(LuaHelper.FloatAction(function(arg_432_0)
					arg_428_1.dialogCg_.alpha = arg_432_0
				end))
				var_431_29:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_428_1.dialog_)
					var_431_29:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_428_1.duration_ = arg_428_1.duration_ + 0.3

				SetActive(arg_428_1.leftNameGo_, false)

				arg_428_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_428_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_428_1:RecordName(arg_428_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_428_1.iconTrs_.gameObject, false)
				arg_428_1.callingController_:SetSelectedState("normal")

				local var_431_30 = arg_428_1:GetWordFromCfg(319501104)
				local var_431_31 = arg_428_1:FormatText(var_431_30.content)

				arg_428_1.text_.text = var_431_31

				LuaForUtil.ClearLinePrefixSymbol(arg_428_1.text_)

				local var_431_32 = 61
				local var_431_33 = utf8.len(var_431_31)
				local var_431_34 = var_431_32 <= 0 and var_431_28 or var_431_28 * (var_431_33 / var_431_32)

				if var_431_34 > 0 and var_431_28 < var_431_34 then
					arg_428_1.talkMaxDuration = var_431_34
					var_431_27 = var_431_27 + 0.3

					if var_431_34 + var_431_27 > arg_428_1.duration_ then
						arg_428_1.duration_ = var_431_34 + var_431_27
					end
				end

				arg_428_1.text_.text = var_431_31
				arg_428_1.typewritter.percent = 0

				arg_428_1.typewritter:SetDirty()
				arg_428_1:ShowNextGo(false)
				arg_428_1:RecordContent(arg_428_1.text_.text)
			end

			local var_431_35 = var_431_27 + 0.3
			local var_431_36 = math.max(var_431_28, arg_428_1.talkMaxDuration)

			if var_431_35 <= arg_428_1.time_ and arg_428_1.time_ < var_431_35 + var_431_36 then
				arg_428_1.typewritter.percent = (arg_428_1.time_ - var_431_35) / var_431_36

				arg_428_1.typewritter:SetDirty()
			end

			if arg_428_1.time_ >= var_431_35 + var_431_36 and arg_428_1.time_ < var_431_35 + var_431_36 + arg_431_0 then
				arg_428_1.typewritter.percent = 1

				arg_428_1.typewritter:SetDirty()
				arg_428_1:ShowNextGo(true)
			end
		end

		arg_428_1.nodeConfigList_ = {}

		arg_428_1:InitPlayNodeList()
	end,
	Play319501105 = function(arg_434_0, arg_434_1)
		arg_434_1.time_ = 0
		arg_434_1.frameCnt_ = 0
		arg_434_1.state_ = "playing"
		arg_434_1.curTalkId_ = 319501105
		arg_434_1.duration_ = 5

		SetActive(arg_434_1.tipsGo_, false)

		function arg_434_1.onSingleLineFinish_()
			arg_434_1.onSingleLineUpdate_ = nil
			arg_434_1.onSingleLineFinish_ = nil
			arg_434_1.state_ = "waiting"
		end

		function arg_434_1.playNext_(arg_436_0)
			if arg_436_0 == 1 then
				arg_434_0:Play319501106(arg_434_1)
			end
		end

		function arg_434_1.onSingleLineUpdate_(arg_437_0)
			local var_437_0 = 0
			local var_437_1 = 1.525

			if var_437_0 < arg_434_1.time_ and arg_434_1.time_ <= var_437_0 + arg_437_0 then
				arg_434_1.talkMaxDuration = 0
				arg_434_1.dialogCg_.alpha = 1

				arg_434_1.dialog_:SetActive(true)
				SetActive(arg_434_1.leftNameGo_, false)

				arg_434_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_434_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_434_1:RecordName(arg_434_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_434_1.iconTrs_.gameObject, false)
				arg_434_1.callingController_:SetSelectedState("normal")

				local var_437_2 = arg_434_1:GetWordFromCfg(319501105)
				local var_437_3 = arg_434_1:FormatText(var_437_2.content)

				arg_434_1.text_.text = var_437_3

				LuaForUtil.ClearLinePrefixSymbol(arg_434_1.text_)

				local var_437_4 = 61
				local var_437_5 = utf8.len(var_437_3)
				local var_437_6 = var_437_4 <= 0 and var_437_1 or var_437_1 * (var_437_5 / var_437_4)

				if var_437_6 > 0 and var_437_1 < var_437_6 then
					arg_434_1.talkMaxDuration = var_437_6

					if var_437_6 + var_437_0 > arg_434_1.duration_ then
						arg_434_1.duration_ = var_437_6 + var_437_0
					end
				end

				arg_434_1.text_.text = var_437_3
				arg_434_1.typewritter.percent = 0

				arg_434_1.typewritter:SetDirty()
				arg_434_1:ShowNextGo(false)
				arg_434_1:RecordContent(arg_434_1.text_.text)
			end

			local var_437_7 = math.max(var_437_1, arg_434_1.talkMaxDuration)

			if var_437_0 <= arg_434_1.time_ and arg_434_1.time_ < var_437_0 + var_437_7 then
				arg_434_1.typewritter.percent = (arg_434_1.time_ - var_437_0) / var_437_7

				arg_434_1.typewritter:SetDirty()
			end

			if arg_434_1.time_ >= var_437_0 + var_437_7 and arg_434_1.time_ < var_437_0 + var_437_7 + arg_437_0 then
				arg_434_1.typewritter.percent = 1

				arg_434_1.typewritter:SetDirty()
				arg_434_1:ShowNextGo(true)
			end
		end

		arg_434_1.nodeConfigList_ = {}

		arg_434_1:InitPlayNodeList()
	end,
	Play319501106 = function(arg_438_0, arg_438_1)
		arg_438_1.time_ = 0
		arg_438_1.frameCnt_ = 0
		arg_438_1.state_ = "playing"
		arg_438_1.curTalkId_ = 319501106
		arg_438_1.duration_ = 5.9

		local var_438_0 = {
			zh = 1.833,
			ja = 5.9
		}
		local var_438_1 = manager.audio:GetLocalizationFlag()

		if var_438_0[var_438_1] ~= nil then
			arg_438_1.duration_ = var_438_0[var_438_1]
		end

		SetActive(arg_438_1.tipsGo_, false)

		function arg_438_1.onSingleLineFinish_()
			arg_438_1.onSingleLineUpdate_ = nil
			arg_438_1.onSingleLineFinish_ = nil
			arg_438_1.state_ = "waiting"
		end

		function arg_438_1.playNext_(arg_440_0)
			if arg_440_0 == 1 then
				arg_438_0:Play319501107(arg_438_1)
			end
		end

		function arg_438_1.onSingleLineUpdate_(arg_441_0)
			local var_441_0 = arg_438_1.actors_["1084ui_story"].transform
			local var_441_1 = 0

			if var_441_1 < arg_438_1.time_ and arg_438_1.time_ <= var_441_1 + arg_441_0 then
				arg_438_1.var_.moveOldPos1084ui_story = var_441_0.localPosition
			end

			local var_441_2 = 0.001

			if var_441_1 <= arg_438_1.time_ and arg_438_1.time_ < var_441_1 + var_441_2 then
				local var_441_3 = (arg_438_1.time_ - var_441_1) / var_441_2
				local var_441_4 = Vector3.New(0, -0.97, -6)

				var_441_0.localPosition = Vector3.Lerp(arg_438_1.var_.moveOldPos1084ui_story, var_441_4, var_441_3)

				local var_441_5 = manager.ui.mainCamera.transform.position - var_441_0.position

				var_441_0.forward = Vector3.New(var_441_5.x, var_441_5.y, var_441_5.z)

				local var_441_6 = var_441_0.localEulerAngles

				var_441_6.z = 0
				var_441_6.x = 0
				var_441_0.localEulerAngles = var_441_6
			end

			if arg_438_1.time_ >= var_441_1 + var_441_2 and arg_438_1.time_ < var_441_1 + var_441_2 + arg_441_0 then
				var_441_0.localPosition = Vector3.New(0, -0.97, -6)

				local var_441_7 = manager.ui.mainCamera.transform.position - var_441_0.position

				var_441_0.forward = Vector3.New(var_441_7.x, var_441_7.y, var_441_7.z)

				local var_441_8 = var_441_0.localEulerAngles

				var_441_8.z = 0
				var_441_8.x = 0
				var_441_0.localEulerAngles = var_441_8
			end

			local var_441_9 = arg_438_1.actors_["1084ui_story"]
			local var_441_10 = 0

			if var_441_10 < arg_438_1.time_ and arg_438_1.time_ <= var_441_10 + arg_441_0 and not isNil(var_441_9) and arg_438_1.var_.characterEffect1084ui_story == nil then
				arg_438_1.var_.characterEffect1084ui_story = var_441_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_441_11 = 0.200000002980232

			if var_441_10 <= arg_438_1.time_ and arg_438_1.time_ < var_441_10 + var_441_11 and not isNil(var_441_9) then
				local var_441_12 = (arg_438_1.time_ - var_441_10) / var_441_11

				if arg_438_1.var_.characterEffect1084ui_story and not isNil(var_441_9) then
					arg_438_1.var_.characterEffect1084ui_story.fillFlat = false
				end
			end

			if arg_438_1.time_ >= var_441_10 + var_441_11 and arg_438_1.time_ < var_441_10 + var_441_11 + arg_441_0 and not isNil(var_441_9) and arg_438_1.var_.characterEffect1084ui_story then
				arg_438_1.var_.characterEffect1084ui_story.fillFlat = false
			end

			local var_441_13 = 0

			if var_441_13 < arg_438_1.time_ and arg_438_1.time_ <= var_441_13 + arg_441_0 then
				arg_438_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/story1084/story1084action/1084action1_1")
			end

			local var_441_14 = 0

			if var_441_14 < arg_438_1.time_ and arg_438_1.time_ <= var_441_14 + arg_441_0 then
				arg_438_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_441_15 = 0
			local var_441_16 = 0.175

			if var_441_15 < arg_438_1.time_ and arg_438_1.time_ <= var_441_15 + arg_441_0 then
				arg_438_1.talkMaxDuration = 0
				arg_438_1.dialogCg_.alpha = 1

				arg_438_1.dialog_:SetActive(true)
				SetActive(arg_438_1.leftNameGo_, true)

				local var_441_17 = arg_438_1:FormatText(StoryNameCfg[6].name)

				arg_438_1.leftNameTxt_.text = var_441_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_438_1.leftNameTxt_.transform)

				arg_438_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_438_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_438_1:RecordName(arg_438_1.leftNameTxt_.text)
				SetActive(arg_438_1.iconTrs_.gameObject, false)
				arg_438_1.callingController_:SetSelectedState("normal")

				local var_441_18 = arg_438_1:GetWordFromCfg(319501106)
				local var_441_19 = arg_438_1:FormatText(var_441_18.content)

				arg_438_1.text_.text = var_441_19

				LuaForUtil.ClearLinePrefixSymbol(arg_438_1.text_)

				local var_441_20 = 7
				local var_441_21 = utf8.len(var_441_19)
				local var_441_22 = var_441_20 <= 0 and var_441_16 or var_441_16 * (var_441_21 / var_441_20)

				if var_441_22 > 0 and var_441_16 < var_441_22 then
					arg_438_1.talkMaxDuration = var_441_22

					if var_441_22 + var_441_15 > arg_438_1.duration_ then
						arg_438_1.duration_ = var_441_22 + var_441_15
					end
				end

				arg_438_1.text_.text = var_441_19
				arg_438_1.typewritter.percent = 0

				arg_438_1.typewritter:SetDirty()
				arg_438_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_319501", "319501106", "story_v_out_319501.awb") ~= 0 then
					local var_441_23 = manager.audio:GetVoiceLength("story_v_out_319501", "319501106", "story_v_out_319501.awb") / 1000

					if var_441_23 + var_441_15 > arg_438_1.duration_ then
						arg_438_1.duration_ = var_441_23 + var_441_15
					end

					if var_441_18.prefab_name ~= "" and arg_438_1.actors_[var_441_18.prefab_name] ~= nil then
						local var_441_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_438_1.actors_[var_441_18.prefab_name].transform, "story_v_out_319501", "319501106", "story_v_out_319501.awb")

						arg_438_1:RecordAudio("319501106", var_441_24)
						arg_438_1:RecordAudio("319501106", var_441_24)
					else
						arg_438_1:AudioAction("play", "voice", "story_v_out_319501", "319501106", "story_v_out_319501.awb")
					end

					arg_438_1:RecordHistoryTalkVoice("story_v_out_319501", "319501106", "story_v_out_319501.awb")
				end

				arg_438_1:RecordContent(arg_438_1.text_.text)
			end

			local var_441_25 = math.max(var_441_16, arg_438_1.talkMaxDuration)

			if var_441_15 <= arg_438_1.time_ and arg_438_1.time_ < var_441_15 + var_441_25 then
				arg_438_1.typewritter.percent = (arg_438_1.time_ - var_441_15) / var_441_25

				arg_438_1.typewritter:SetDirty()
			end

			if arg_438_1.time_ >= var_441_15 + var_441_25 and arg_438_1.time_ < var_441_15 + var_441_25 + arg_441_0 then
				arg_438_1.typewritter.percent = 1

				arg_438_1.typewritter:SetDirty()
				arg_438_1:ShowNextGo(true)
			end
		end

		arg_438_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1084ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_438_1:InitPlayNodeList()
	end,
	Play319501107 = function(arg_442_0, arg_442_1)
		arg_442_1.time_ = 0
		arg_442_1.frameCnt_ = 0
		arg_442_1.state_ = "playing"
		arg_442_1.curTalkId_ = 319501107
		arg_442_1.duration_ = 1.67

		local var_442_0 = {
			zh = 1.566,
			ja = 1.666
		}
		local var_442_1 = manager.audio:GetLocalizationFlag()

		if var_442_0[var_442_1] ~= nil then
			arg_442_1.duration_ = var_442_0[var_442_1]
		end

		SetActive(arg_442_1.tipsGo_, false)

		function arg_442_1.onSingleLineFinish_()
			arg_442_1.onSingleLineUpdate_ = nil
			arg_442_1.onSingleLineFinish_ = nil
			arg_442_1.state_ = "waiting"
		end

		function arg_442_1.playNext_(arg_444_0)
			if arg_444_0 == 1 then
				arg_442_0:Play319501108(arg_442_1)
			end
		end

		function arg_442_1.onSingleLineUpdate_(arg_445_0)
			local var_445_0 = arg_442_1.actors_["10068ui_story"].transform
			local var_445_1 = 0

			if var_445_1 < arg_442_1.time_ and arg_442_1.time_ <= var_445_1 + arg_445_0 then
				arg_442_1.var_.moveOldPos10068ui_story = var_445_0.localPosition
			end

			local var_445_2 = 0.001

			if var_445_1 <= arg_442_1.time_ and arg_442_1.time_ < var_445_1 + var_445_2 then
				local var_445_3 = (arg_442_1.time_ - var_445_1) / var_445_2
				local var_445_4 = Vector3.New(0.7, -0.75, -6.18)

				var_445_0.localPosition = Vector3.Lerp(arg_442_1.var_.moveOldPos10068ui_story, var_445_4, var_445_3)

				local var_445_5 = manager.ui.mainCamera.transform.position - var_445_0.position

				var_445_0.forward = Vector3.New(var_445_5.x, var_445_5.y, var_445_5.z)

				local var_445_6 = var_445_0.localEulerAngles

				var_445_6.z = 0
				var_445_6.x = 0
				var_445_0.localEulerAngles = var_445_6
			end

			if arg_442_1.time_ >= var_445_1 + var_445_2 and arg_442_1.time_ < var_445_1 + var_445_2 + arg_445_0 then
				var_445_0.localPosition = Vector3.New(0.7, -0.75, -6.18)

				local var_445_7 = manager.ui.mainCamera.transform.position - var_445_0.position

				var_445_0.forward = Vector3.New(var_445_7.x, var_445_7.y, var_445_7.z)

				local var_445_8 = var_445_0.localEulerAngles

				var_445_8.z = 0
				var_445_8.x = 0
				var_445_0.localEulerAngles = var_445_8
			end

			local var_445_9 = arg_442_1.actors_["10068ui_story"]
			local var_445_10 = 0

			if var_445_10 < arg_442_1.time_ and arg_442_1.time_ <= var_445_10 + arg_445_0 and not isNil(var_445_9) and arg_442_1.var_.characterEffect10068ui_story == nil then
				arg_442_1.var_.characterEffect10068ui_story = var_445_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_445_11 = 0.200000002980232

			if var_445_10 <= arg_442_1.time_ and arg_442_1.time_ < var_445_10 + var_445_11 and not isNil(var_445_9) then
				local var_445_12 = (arg_442_1.time_ - var_445_10) / var_445_11

				if arg_442_1.var_.characterEffect10068ui_story and not isNil(var_445_9) then
					arg_442_1.var_.characterEffect10068ui_story.fillFlat = false
				end
			end

			if arg_442_1.time_ >= var_445_10 + var_445_11 and arg_442_1.time_ < var_445_10 + var_445_11 + arg_445_0 and not isNil(var_445_9) and arg_442_1.var_.characterEffect10068ui_story then
				arg_442_1.var_.characterEffect10068ui_story.fillFlat = false
			end

			local var_445_13 = 0

			if var_445_13 < arg_442_1.time_ and arg_442_1.time_ <= var_445_13 + arg_445_0 then
				arg_442_1:PlayTimeline("10068ui_story", "StoryTimeline/CharAction/story10068/story10068action/10068action1_1")
			end

			local var_445_14 = 0

			if var_445_14 < arg_442_1.time_ and arg_442_1.time_ <= var_445_14 + arg_445_0 then
				arg_442_1:PlayTimeline("10068ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_445_15 = arg_442_1.actors_["1084ui_story"].transform
			local var_445_16 = 0

			if var_445_16 < arg_442_1.time_ and arg_442_1.time_ <= var_445_16 + arg_445_0 then
				arg_442_1.var_.moveOldPos1084ui_story = var_445_15.localPosition
			end

			local var_445_17 = 0.001

			if var_445_16 <= arg_442_1.time_ and arg_442_1.time_ < var_445_16 + var_445_17 then
				local var_445_18 = (arg_442_1.time_ - var_445_16) / var_445_17
				local var_445_19 = Vector3.New(-0.7, -0.97, -6)

				var_445_15.localPosition = Vector3.Lerp(arg_442_1.var_.moveOldPos1084ui_story, var_445_19, var_445_18)

				local var_445_20 = manager.ui.mainCamera.transform.position - var_445_15.position

				var_445_15.forward = Vector3.New(var_445_20.x, var_445_20.y, var_445_20.z)

				local var_445_21 = var_445_15.localEulerAngles

				var_445_21.z = 0
				var_445_21.x = 0
				var_445_15.localEulerAngles = var_445_21
			end

			if arg_442_1.time_ >= var_445_16 + var_445_17 and arg_442_1.time_ < var_445_16 + var_445_17 + arg_445_0 then
				var_445_15.localPosition = Vector3.New(-0.7, -0.97, -6)

				local var_445_22 = manager.ui.mainCamera.transform.position - var_445_15.position

				var_445_15.forward = Vector3.New(var_445_22.x, var_445_22.y, var_445_22.z)

				local var_445_23 = var_445_15.localEulerAngles

				var_445_23.z = 0
				var_445_23.x = 0
				var_445_15.localEulerAngles = var_445_23
			end

			local var_445_24 = arg_442_1.actors_["1084ui_story"]
			local var_445_25 = 0

			if var_445_25 < arg_442_1.time_ and arg_442_1.time_ <= var_445_25 + arg_445_0 and not isNil(var_445_24) and arg_442_1.var_.characterEffect1084ui_story == nil then
				arg_442_1.var_.characterEffect1084ui_story = var_445_24:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_445_26 = 0.200000002980232

			if var_445_25 <= arg_442_1.time_ and arg_442_1.time_ < var_445_25 + var_445_26 and not isNil(var_445_24) then
				local var_445_27 = (arg_442_1.time_ - var_445_25) / var_445_26

				if arg_442_1.var_.characterEffect1084ui_story and not isNil(var_445_24) then
					local var_445_28 = Mathf.Lerp(0, 0.5, var_445_27)

					arg_442_1.var_.characterEffect1084ui_story.fillFlat = true
					arg_442_1.var_.characterEffect1084ui_story.fillRatio = var_445_28
				end
			end

			if arg_442_1.time_ >= var_445_25 + var_445_26 and arg_442_1.time_ < var_445_25 + var_445_26 + arg_445_0 and not isNil(var_445_24) and arg_442_1.var_.characterEffect1084ui_story then
				local var_445_29 = 0.5

				arg_442_1.var_.characterEffect1084ui_story.fillFlat = true
				arg_442_1.var_.characterEffect1084ui_story.fillRatio = var_445_29
			end

			local var_445_30 = 0
			local var_445_31 = 0.1

			if var_445_30 < arg_442_1.time_ and arg_442_1.time_ <= var_445_30 + arg_445_0 then
				arg_442_1.talkMaxDuration = 0
				arg_442_1.dialogCg_.alpha = 1

				arg_442_1.dialog_:SetActive(true)
				SetActive(arg_442_1.leftNameGo_, true)

				local var_445_32 = arg_442_1:FormatText(StoryNameCfg[697].name)

				arg_442_1.leftNameTxt_.text = var_445_32

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_442_1.leftNameTxt_.transform)

				arg_442_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_442_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_442_1:RecordName(arg_442_1.leftNameTxt_.text)
				SetActive(arg_442_1.iconTrs_.gameObject, false)
				arg_442_1.callingController_:SetSelectedState("normal")

				local var_445_33 = arg_442_1:GetWordFromCfg(319501107)
				local var_445_34 = arg_442_1:FormatText(var_445_33.content)

				arg_442_1.text_.text = var_445_34

				LuaForUtil.ClearLinePrefixSymbol(arg_442_1.text_)

				local var_445_35 = 4
				local var_445_36 = utf8.len(var_445_34)
				local var_445_37 = var_445_35 <= 0 and var_445_31 or var_445_31 * (var_445_36 / var_445_35)

				if var_445_37 > 0 and var_445_31 < var_445_37 then
					arg_442_1.talkMaxDuration = var_445_37

					if var_445_37 + var_445_30 > arg_442_1.duration_ then
						arg_442_1.duration_ = var_445_37 + var_445_30
					end
				end

				arg_442_1.text_.text = var_445_34
				arg_442_1.typewritter.percent = 0

				arg_442_1.typewritter:SetDirty()
				arg_442_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_319501", "319501107", "story_v_out_319501.awb") ~= 0 then
					local var_445_38 = manager.audio:GetVoiceLength("story_v_out_319501", "319501107", "story_v_out_319501.awb") / 1000

					if var_445_38 + var_445_30 > arg_442_1.duration_ then
						arg_442_1.duration_ = var_445_38 + var_445_30
					end

					if var_445_33.prefab_name ~= "" and arg_442_1.actors_[var_445_33.prefab_name] ~= nil then
						local var_445_39 = LuaForUtil.PlayVoiceWithCriLipsync(arg_442_1.actors_[var_445_33.prefab_name].transform, "story_v_out_319501", "319501107", "story_v_out_319501.awb")

						arg_442_1:RecordAudio("319501107", var_445_39)
						arg_442_1:RecordAudio("319501107", var_445_39)
					else
						arg_442_1:AudioAction("play", "voice", "story_v_out_319501", "319501107", "story_v_out_319501.awb")
					end

					arg_442_1:RecordHistoryTalkVoice("story_v_out_319501", "319501107", "story_v_out_319501.awb")
				end

				arg_442_1:RecordContent(arg_442_1.text_.text)
			end

			local var_445_40 = math.max(var_445_31, arg_442_1.talkMaxDuration)

			if var_445_30 <= arg_442_1.time_ and arg_442_1.time_ < var_445_30 + var_445_40 then
				arg_442_1.typewritter.percent = (arg_442_1.time_ - var_445_30) / var_445_40

				arg_442_1.typewritter:SetDirty()
			end

			if arg_442_1.time_ >= var_445_30 + var_445_40 and arg_442_1.time_ < var_445_30 + var_445_40 + arg_445_0 then
				arg_442_1.typewritter.percent = 1

				arg_442_1.typewritter:SetDirty()
				arg_442_1:ShowNextGo(true)
			end
		end

		arg_442_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10068ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1084ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_442_1:InitPlayNodeList()
	end,
	Play319501108 = function(arg_446_0, arg_446_1)
		arg_446_1.time_ = 0
		arg_446_1.frameCnt_ = 0
		arg_446_1.state_ = "playing"
		arg_446_1.curTalkId_ = 319501108
		arg_446_1.duration_ = 6.1

		local var_446_0 = {
			zh = 5.366,
			ja = 6.1
		}
		local var_446_1 = manager.audio:GetLocalizationFlag()

		if var_446_0[var_446_1] ~= nil then
			arg_446_1.duration_ = var_446_0[var_446_1]
		end

		SetActive(arg_446_1.tipsGo_, false)

		function arg_446_1.onSingleLineFinish_()
			arg_446_1.onSingleLineUpdate_ = nil
			arg_446_1.onSingleLineFinish_ = nil
			arg_446_1.state_ = "waiting"
		end

		function arg_446_1.playNext_(arg_448_0)
			if arg_448_0 == 1 then
				arg_446_0:Play319501109(arg_446_1)
			end
		end

		function arg_446_1.onSingleLineUpdate_(arg_449_0)
			local var_449_0 = arg_446_1.actors_["10068ui_story"]
			local var_449_1 = 0

			if var_449_1 < arg_446_1.time_ and arg_446_1.time_ <= var_449_1 + arg_449_0 and not isNil(var_449_0) and arg_446_1.var_.characterEffect10068ui_story == nil then
				arg_446_1.var_.characterEffect10068ui_story = var_449_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_449_2 = 0.200000002980232

			if var_449_1 <= arg_446_1.time_ and arg_446_1.time_ < var_449_1 + var_449_2 and not isNil(var_449_0) then
				local var_449_3 = (arg_446_1.time_ - var_449_1) / var_449_2

				if arg_446_1.var_.characterEffect10068ui_story and not isNil(var_449_0) then
					local var_449_4 = Mathf.Lerp(0, 0.5, var_449_3)

					arg_446_1.var_.characterEffect10068ui_story.fillFlat = true
					arg_446_1.var_.characterEffect10068ui_story.fillRatio = var_449_4
				end
			end

			if arg_446_1.time_ >= var_449_1 + var_449_2 and arg_446_1.time_ < var_449_1 + var_449_2 + arg_449_0 and not isNil(var_449_0) and arg_446_1.var_.characterEffect10068ui_story then
				local var_449_5 = 0.5

				arg_446_1.var_.characterEffect10068ui_story.fillFlat = true
				arg_446_1.var_.characterEffect10068ui_story.fillRatio = var_449_5
			end

			local var_449_6 = arg_446_1.actors_["1084ui_story"]
			local var_449_7 = 0

			if var_449_7 < arg_446_1.time_ and arg_446_1.time_ <= var_449_7 + arg_449_0 and not isNil(var_449_6) and arg_446_1.var_.characterEffect1084ui_story == nil then
				arg_446_1.var_.characterEffect1084ui_story = var_449_6:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_449_8 = 0.200000002980232

			if var_449_7 <= arg_446_1.time_ and arg_446_1.time_ < var_449_7 + var_449_8 and not isNil(var_449_6) then
				local var_449_9 = (arg_446_1.time_ - var_449_7) / var_449_8

				if arg_446_1.var_.characterEffect1084ui_story and not isNil(var_449_6) then
					arg_446_1.var_.characterEffect1084ui_story.fillFlat = false
				end
			end

			if arg_446_1.time_ >= var_449_7 + var_449_8 and arg_446_1.time_ < var_449_7 + var_449_8 + arg_449_0 and not isNil(var_449_6) and arg_446_1.var_.characterEffect1084ui_story then
				arg_446_1.var_.characterEffect1084ui_story.fillFlat = false
			end

			local var_449_10 = 0
			local var_449_11 = 0.5

			if var_449_10 < arg_446_1.time_ and arg_446_1.time_ <= var_449_10 + arg_449_0 then
				arg_446_1.talkMaxDuration = 0
				arg_446_1.dialogCg_.alpha = 1

				arg_446_1.dialog_:SetActive(true)
				SetActive(arg_446_1.leftNameGo_, true)

				local var_449_12 = arg_446_1:FormatText(StoryNameCfg[6].name)

				arg_446_1.leftNameTxt_.text = var_449_12

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_446_1.leftNameTxt_.transform)

				arg_446_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_446_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_446_1:RecordName(arg_446_1.leftNameTxt_.text)
				SetActive(arg_446_1.iconTrs_.gameObject, false)
				arg_446_1.callingController_:SetSelectedState("normal")

				local var_449_13 = arg_446_1:GetWordFromCfg(319501108)
				local var_449_14 = arg_446_1:FormatText(var_449_13.content)

				arg_446_1.text_.text = var_449_14

				LuaForUtil.ClearLinePrefixSymbol(arg_446_1.text_)

				local var_449_15 = 20
				local var_449_16 = utf8.len(var_449_14)
				local var_449_17 = var_449_15 <= 0 and var_449_11 or var_449_11 * (var_449_16 / var_449_15)

				if var_449_17 > 0 and var_449_11 < var_449_17 then
					arg_446_1.talkMaxDuration = var_449_17

					if var_449_17 + var_449_10 > arg_446_1.duration_ then
						arg_446_1.duration_ = var_449_17 + var_449_10
					end
				end

				arg_446_1.text_.text = var_449_14
				arg_446_1.typewritter.percent = 0

				arg_446_1.typewritter:SetDirty()
				arg_446_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_319501", "319501108", "story_v_out_319501.awb") ~= 0 then
					local var_449_18 = manager.audio:GetVoiceLength("story_v_out_319501", "319501108", "story_v_out_319501.awb") / 1000

					if var_449_18 + var_449_10 > arg_446_1.duration_ then
						arg_446_1.duration_ = var_449_18 + var_449_10
					end

					if var_449_13.prefab_name ~= "" and arg_446_1.actors_[var_449_13.prefab_name] ~= nil then
						local var_449_19 = LuaForUtil.PlayVoiceWithCriLipsync(arg_446_1.actors_[var_449_13.prefab_name].transform, "story_v_out_319501", "319501108", "story_v_out_319501.awb")

						arg_446_1:RecordAudio("319501108", var_449_19)
						arg_446_1:RecordAudio("319501108", var_449_19)
					else
						arg_446_1:AudioAction("play", "voice", "story_v_out_319501", "319501108", "story_v_out_319501.awb")
					end

					arg_446_1:RecordHistoryTalkVoice("story_v_out_319501", "319501108", "story_v_out_319501.awb")
				end

				arg_446_1:RecordContent(arg_446_1.text_.text)
			end

			local var_449_20 = math.max(var_449_11, arg_446_1.talkMaxDuration)

			if var_449_10 <= arg_446_1.time_ and arg_446_1.time_ < var_449_10 + var_449_20 then
				arg_446_1.typewritter.percent = (arg_446_1.time_ - var_449_10) / var_449_20

				arg_446_1.typewritter:SetDirty()
			end

			if arg_446_1.time_ >= var_449_10 + var_449_20 and arg_446_1.time_ < var_449_10 + var_449_20 + arg_449_0 then
				arg_446_1.typewritter.percent = 1

				arg_446_1.typewritter:SetDirty()
				arg_446_1:ShowNextGo(true)
			end
		end

		arg_446_1.nodeConfigList_ = {}

		arg_446_1:InitPlayNodeList()
	end,
	Play319501109 = function(arg_450_0, arg_450_1)
		arg_450_1.time_ = 0
		arg_450_1.frameCnt_ = 0
		arg_450_1.state_ = "playing"
		arg_450_1.curTalkId_ = 319501109
		arg_450_1.duration_ = 5

		SetActive(arg_450_1.tipsGo_, false)

		function arg_450_1.onSingleLineFinish_()
			arg_450_1.onSingleLineUpdate_ = nil
			arg_450_1.onSingleLineFinish_ = nil
			arg_450_1.state_ = "waiting"
		end

		function arg_450_1.playNext_(arg_452_0)
			if arg_452_0 == 1 then
				arg_450_0:Play319501110(arg_450_1)
			end
		end

		function arg_450_1.onSingleLineUpdate_(arg_453_0)
			local var_453_0 = arg_450_1.actors_["1084ui_story"]
			local var_453_1 = 0

			if var_453_1 < arg_450_1.time_ and arg_450_1.time_ <= var_453_1 + arg_453_0 and not isNil(var_453_0) and arg_450_1.var_.characterEffect1084ui_story == nil then
				arg_450_1.var_.characterEffect1084ui_story = var_453_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_453_2 = 0.200000002980232

			if var_453_1 <= arg_450_1.time_ and arg_450_1.time_ < var_453_1 + var_453_2 and not isNil(var_453_0) then
				local var_453_3 = (arg_450_1.time_ - var_453_1) / var_453_2

				if arg_450_1.var_.characterEffect1084ui_story and not isNil(var_453_0) then
					local var_453_4 = Mathf.Lerp(0, 0.5, var_453_3)

					arg_450_1.var_.characterEffect1084ui_story.fillFlat = true
					arg_450_1.var_.characterEffect1084ui_story.fillRatio = var_453_4
				end
			end

			if arg_450_1.time_ >= var_453_1 + var_453_2 and arg_450_1.time_ < var_453_1 + var_453_2 + arg_453_0 and not isNil(var_453_0) and arg_450_1.var_.characterEffect1084ui_story then
				local var_453_5 = 0.5

				arg_450_1.var_.characterEffect1084ui_story.fillFlat = true
				arg_450_1.var_.characterEffect1084ui_story.fillRatio = var_453_5
			end

			local var_453_6 = 0
			local var_453_7 = 0.975

			if var_453_6 < arg_450_1.time_ and arg_450_1.time_ <= var_453_6 + arg_453_0 then
				arg_450_1.talkMaxDuration = 0
				arg_450_1.dialogCg_.alpha = 1

				arg_450_1.dialog_:SetActive(true)
				SetActive(arg_450_1.leftNameGo_, false)

				arg_450_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_450_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_450_1:RecordName(arg_450_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_450_1.iconTrs_.gameObject, false)
				arg_450_1.callingController_:SetSelectedState("normal")

				local var_453_8 = arg_450_1:GetWordFromCfg(319501109)
				local var_453_9 = arg_450_1:FormatText(var_453_8.content)

				arg_450_1.text_.text = var_453_9

				LuaForUtil.ClearLinePrefixSymbol(arg_450_1.text_)

				local var_453_10 = 39
				local var_453_11 = utf8.len(var_453_9)
				local var_453_12 = var_453_10 <= 0 and var_453_7 or var_453_7 * (var_453_11 / var_453_10)

				if var_453_12 > 0 and var_453_7 < var_453_12 then
					arg_450_1.talkMaxDuration = var_453_12

					if var_453_12 + var_453_6 > arg_450_1.duration_ then
						arg_450_1.duration_ = var_453_12 + var_453_6
					end
				end

				arg_450_1.text_.text = var_453_9
				arg_450_1.typewritter.percent = 0

				arg_450_1.typewritter:SetDirty()
				arg_450_1:ShowNextGo(false)
				arg_450_1:RecordContent(arg_450_1.text_.text)
			end

			local var_453_13 = math.max(var_453_7, arg_450_1.talkMaxDuration)

			if var_453_6 <= arg_450_1.time_ and arg_450_1.time_ < var_453_6 + var_453_13 then
				arg_450_1.typewritter.percent = (arg_450_1.time_ - var_453_6) / var_453_13

				arg_450_1.typewritter:SetDirty()
			end

			if arg_450_1.time_ >= var_453_6 + var_453_13 and arg_450_1.time_ < var_453_6 + var_453_13 + arg_453_0 then
				arg_450_1.typewritter.percent = 1

				arg_450_1.typewritter:SetDirty()
				arg_450_1:ShowNextGo(true)
			end
		end

		arg_450_1.nodeConfigList_ = {}

		arg_450_1:InitPlayNodeList()
	end,
	Play319501110 = function(arg_454_0, arg_454_1)
		arg_454_1.time_ = 0
		arg_454_1.frameCnt_ = 0
		arg_454_1.state_ = "playing"
		arg_454_1.curTalkId_ = 319501110
		arg_454_1.duration_ = 2.87

		SetActive(arg_454_1.tipsGo_, false)

		function arg_454_1.onSingleLineFinish_()
			arg_454_1.onSingleLineUpdate_ = nil
			arg_454_1.onSingleLineFinish_ = nil
			arg_454_1.state_ = "waiting"
		end

		function arg_454_1.playNext_(arg_456_0)
			if arg_456_0 == 1 then
				arg_454_0:Play319501111(arg_454_1)
			end
		end

		function arg_454_1.onSingleLineUpdate_(arg_457_0)
			local var_457_0 = 0

			if var_457_0 < arg_454_1.time_ and arg_454_1.time_ <= var_457_0 + arg_457_0 then
				local var_457_1 = manager.ui.mainCamera.transform.localPosition
				local var_457_2 = Vector3.New(0, 0, 10) + Vector3.New(var_457_1.x, var_457_1.y, 0)
				local var_457_3 = arg_454_1.bgs_.STblack

				var_457_3.transform.localPosition = var_457_2
				var_457_3.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_457_4 = var_457_3:GetComponent("SpriteRenderer")

				if var_457_4 and var_457_4.sprite then
					local var_457_5 = (var_457_3.transform.localPosition - var_457_1).z
					local var_457_6 = manager.ui.mainCameraCom_
					local var_457_7 = 2 * var_457_5 * Mathf.Tan(var_457_6.fieldOfView * 0.5 * Mathf.Deg2Rad)
					local var_457_8 = var_457_7 * var_457_6.aspect
					local var_457_9 = var_457_4.sprite.bounds.size.x
					local var_457_10 = var_457_4.sprite.bounds.size.y
					local var_457_11 = var_457_8 / var_457_9
					local var_457_12 = var_457_7 / var_457_10
					local var_457_13 = var_457_12 < var_457_11 and var_457_11 or var_457_12

					var_457_3.transform.localScale = Vector3.New(var_457_13, var_457_13, 0)
				end

				for iter_457_0, iter_457_1 in pairs(arg_454_1.bgs_) do
					if iter_457_0 ~= "STblack" then
						iter_457_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_457_14 = 0

			if var_457_14 < arg_454_1.time_ and arg_454_1.time_ <= var_457_14 + arg_457_0 then
				local var_457_15 = arg_454_1.fswbg_.transform:Find("textbox/adapt/content") or arg_454_1.fswbg_.transform:Find("textbox/content")
				local var_457_16 = arg_454_1.fswbg_.transform:Find("textbox/bg"):GetComponent("Image")
				local var_457_17 = var_457_15:GetComponent("Text")
				local var_457_18 = var_457_15:GetComponent("RectTransform")

				var_457_17.alignment = UnityEngine.TextAnchor.LowerCenter
				var_457_18.offsetMin = Vector2.New(0, 0)
				var_457_18.offsetMax = Vector2.New(0, 0)
			end

			local var_457_19 = 0

			if var_457_19 < arg_454_1.time_ and arg_454_1.time_ <= var_457_19 + arg_457_0 then
				arg_454_1.fswbg_:SetActive(true)
				arg_454_1.dialog_:SetActive(false)

				arg_454_1.fswtw_.percent = 0

				local var_457_20 = arg_454_1:GetWordFromCfg(319501110)
				local var_457_21 = arg_454_1:FormatText(var_457_20.content)

				arg_454_1.fswt_.text = var_457_21

				LuaForUtil.ClearLinePrefixSymbol(arg_454_1.fswt_)

				arg_454_1.fswt_:GetComponent("Text").color = Color(1, 1, 1)
				arg_454_1.fswbg_.transform:Find("textbox/bg"):GetComponent("Image").enabled = false

				arg_454_1.fswtw_:SetDirty()

				arg_454_1.typewritterCharCountI18N = 0

				SetActive(arg_454_1.fswtw_.transform.parent.parent:Find("bg/line").gameObject, false)
				arg_454_1:ShowNextGo(false)
			end

			local var_457_22 = 0.466666666666667

			if var_457_22 < arg_454_1.time_ and arg_454_1.time_ <= var_457_22 + arg_457_0 then
				arg_454_1.var_.oldValueTypewriter = arg_454_1.fswtw_.percent

				SetActive(arg_454_1.fswtw_.transform.parent.parent:Find("bg/line").gameObject, false)
				arg_454_1:ShowNextGo(false)
			end

			local var_457_23 = 9
			local var_457_24 = 0.6
			local var_457_25 = arg_454_1:GetWordFromCfg(319501110)
			local var_457_26 = arg_454_1:FormatText(var_457_25.content)
			local var_457_27, var_457_28 = arg_454_1:GetPercentByPara(var_457_26, 1)

			if var_457_22 < arg_454_1.time_ and arg_454_1.time_ <= var_457_22 + arg_457_0 then
				arg_454_1.talkMaxDuration = 0

				local var_457_29 = var_457_23 <= 0 and var_457_24 or var_457_24 * ((var_457_28 - arg_454_1.typewritterCharCountI18N) / var_457_23)

				if var_457_29 > 0 and var_457_24 < var_457_29 then
					arg_454_1.talkMaxDuration = var_457_29

					if var_457_29 + var_457_22 > arg_454_1.duration_ then
						arg_454_1.duration_ = var_457_29 + var_457_22
					end
				end
			end

			local var_457_30 = 0.6
			local var_457_31 = math.max(var_457_30, arg_454_1.talkMaxDuration)

			if var_457_22 <= arg_454_1.time_ and arg_454_1.time_ < var_457_22 + var_457_31 then
				local var_457_32 = (arg_454_1.time_ - var_457_22) / var_457_31

				arg_454_1.fswtw_.percent = Mathf.Lerp(arg_454_1.var_.oldValueTypewriter, var_457_27, var_457_32)
				arg_454_1.fswt_:GetComponent("Text").color = Color(1, 1, 1)

				arg_454_1.fswtw_:SetDirty()
			end

			if arg_454_1.time_ >= var_457_22 + var_457_31 and arg_454_1.time_ < var_457_22 + var_457_31 + arg_457_0 then
				arg_454_1.fswtw_.percent = var_457_27

				arg_454_1.fswtw_:SetDirty()
				arg_454_1:ShowNextGo(true)

				arg_454_1.typewritterCharCountI18N = var_457_28
			end

			local var_457_33 = 0

			if var_457_33 < arg_454_1.time_ and arg_454_1.time_ <= var_457_33 + arg_457_0 then
				arg_454_1.cswbg_:SetActive(true)

				local var_457_34 = arg_454_1.cswt_:GetComponent("RectTransform")

				arg_454_1.cswt_.alignment = UnityEngine.TextAnchor.MiddleCenter
				var_457_34.offsetMin = Vector2.New(410, 330)
				var_457_34.offsetMax = Vector2.New(-400, -175)

				local var_457_35 = arg_454_1:GetWordFromCfg(419025)
				local var_457_36 = arg_454_1:FormatText(var_457_35.content)

				arg_454_1.cswt_.text = var_457_36

				LuaForUtil.ClearLinePrefixSymbol(arg_454_1.cswt_)

				arg_454_1.cswt_.fontSize = 180
				arg_454_1.cswt_:GetComponent("Text").color = Color(1, 1, 1)

				arg_454_1.cswt_:GetComponent("I18NTextKeyToValue"):SetFontPath("Fonts/SourceHanSerifCN-Bold-3.0")

				arg_454_1.cswt_.font = Asset.Load("Fonts/SourceHanSerifCN-Bold-3.0")
			end

			local var_457_37 = arg_454_1.actors_["10068ui_story"].transform
			local var_457_38 = 0

			if var_457_38 < arg_454_1.time_ and arg_454_1.time_ <= var_457_38 + arg_457_0 then
				arg_454_1.var_.moveOldPos10068ui_story = var_457_37.localPosition
			end

			local var_457_39 = 0.001

			if var_457_38 <= arg_454_1.time_ and arg_454_1.time_ < var_457_38 + var_457_39 then
				local var_457_40 = (arg_454_1.time_ - var_457_38) / var_457_39
				local var_457_41 = Vector3.New(0, 100, 0)

				var_457_37.localPosition = Vector3.Lerp(arg_454_1.var_.moveOldPos10068ui_story, var_457_41, var_457_40)

				local var_457_42 = manager.ui.mainCamera.transform.position - var_457_37.position

				var_457_37.forward = Vector3.New(var_457_42.x, var_457_42.y, var_457_42.z)

				local var_457_43 = var_457_37.localEulerAngles

				var_457_43.z = 0
				var_457_43.x = 0
				var_457_37.localEulerAngles = var_457_43
			end

			if arg_454_1.time_ >= var_457_38 + var_457_39 and arg_454_1.time_ < var_457_38 + var_457_39 + arg_457_0 then
				var_457_37.localPosition = Vector3.New(0, 100, 0)

				local var_457_44 = manager.ui.mainCamera.transform.position - var_457_37.position

				var_457_37.forward = Vector3.New(var_457_44.x, var_457_44.y, var_457_44.z)

				local var_457_45 = var_457_37.localEulerAngles

				var_457_45.z = 0
				var_457_45.x = 0
				var_457_37.localEulerAngles = var_457_45
			end

			local var_457_46 = arg_454_1.actors_["1084ui_story"].transform
			local var_457_47 = 0

			if var_457_47 < arg_454_1.time_ and arg_454_1.time_ <= var_457_47 + arg_457_0 then
				arg_454_1.var_.moveOldPos1084ui_story = var_457_46.localPosition
			end

			local var_457_48 = 0.001

			if var_457_47 <= arg_454_1.time_ and arg_454_1.time_ < var_457_47 + var_457_48 then
				local var_457_49 = (arg_454_1.time_ - var_457_47) / var_457_48
				local var_457_50 = Vector3.New(0, 100, 0)

				var_457_46.localPosition = Vector3.Lerp(arg_454_1.var_.moveOldPos1084ui_story, var_457_50, var_457_49)

				local var_457_51 = manager.ui.mainCamera.transform.position - var_457_46.position

				var_457_46.forward = Vector3.New(var_457_51.x, var_457_51.y, var_457_51.z)

				local var_457_52 = var_457_46.localEulerAngles

				var_457_52.z = 0
				var_457_52.x = 0
				var_457_46.localEulerAngles = var_457_52
			end

			if arg_454_1.time_ >= var_457_47 + var_457_48 and arg_454_1.time_ < var_457_47 + var_457_48 + arg_457_0 then
				var_457_46.localPosition = Vector3.New(0, 100, 0)

				local var_457_53 = manager.ui.mainCamera.transform.position - var_457_46.position

				var_457_46.forward = Vector3.New(var_457_53.x, var_457_53.y, var_457_53.z)

				local var_457_54 = var_457_46.localEulerAngles

				var_457_54.z = 0
				var_457_54.x = 0
				var_457_46.localEulerAngles = var_457_54
			end

			local var_457_55 = 0.466666666666667
			local var_457_56 = 2.4
			local var_457_57 = manager.audio:GetVoiceLength("story_v_out_319501", "319501110", "story_v_out_319501.awb") / 1000

			if var_457_57 > 0 and var_457_56 < var_457_57 and var_457_57 + var_457_55 > arg_454_1.duration_ then
				local var_457_58 = var_457_57

				arg_454_1.duration_ = var_457_57 + var_457_55
			end

			if var_457_55 < arg_454_1.time_ and arg_454_1.time_ <= var_457_55 + arg_457_0 then
				local var_457_59 = "play"
				local var_457_60 = "voice"

				arg_454_1:AudioAction(var_457_59, var_457_60, "story_v_out_319501", "319501110", "story_v_out_319501.awb")
			end
		end

		arg_454_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10068ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1084ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_454_1:InitPlayNodeList()
	end,
	Play319501111 = function(arg_458_0, arg_458_1)
		arg_458_1.time_ = 0
		arg_458_1.frameCnt_ = 0
		arg_458_1.state_ = "playing"
		arg_458_1.curTalkId_ = 319501111
		arg_458_1.duration_ = 3.13

		SetActive(arg_458_1.tipsGo_, false)

		function arg_458_1.onSingleLineFinish_()
			arg_458_1.onSingleLineUpdate_ = nil
			arg_458_1.onSingleLineFinish_ = nil
			arg_458_1.state_ = "waiting"
		end

		function arg_458_1.playNext_(arg_460_0)
			if arg_460_0 == 1 then
				arg_458_0:Play319501112(arg_458_1)
			end
		end

		function arg_458_1.onSingleLineUpdate_(arg_461_0)
			local var_461_0 = 0

			if var_461_0 < arg_458_1.time_ and arg_458_1.time_ <= var_461_0 + arg_461_0 then
				arg_458_1.fswbg_:SetActive(true)
				arg_458_1.dialog_:SetActive(false)

				arg_458_1.fswtw_.percent = 0

				local var_461_1 = arg_458_1:GetWordFromCfg(319501111)
				local var_461_2 = arg_458_1:FormatText(var_461_1.content)

				arg_458_1.fswt_.text = var_461_2

				LuaForUtil.ClearLinePrefixSymbol(arg_458_1.fswt_)

				arg_458_1.fswt_:GetComponent("Text").color = Color(1, 1, 1)
				arg_458_1.fswbg_.transform:Find("textbox/bg"):GetComponent("Image").enabled = false

				arg_458_1.fswtw_:SetDirty()

				arg_458_1.typewritterCharCountI18N = 0

				SetActive(arg_458_1.fswtw_.transform.parent.parent:Find("bg/line").gameObject, false)
				arg_458_1:ShowNextGo(false)
			end

			local var_461_3 = 0.2

			if var_461_3 < arg_458_1.time_ and arg_458_1.time_ <= var_461_3 + arg_461_0 then
				arg_458_1.var_.oldValueTypewriter = arg_458_1.fswtw_.percent

				SetActive(arg_458_1.fswtw_.transform.parent.parent:Find("bg/line").gameObject, false)
				arg_458_1:ShowNextGo(false)
			end

			local var_461_4 = 44
			local var_461_5 = 2.93333333333333
			local var_461_6 = arg_458_1:GetWordFromCfg(319501111)
			local var_461_7 = arg_458_1:FormatText(var_461_6.content)
			local var_461_8, var_461_9 = arg_458_1:GetPercentByPara(var_461_7, 1)

			if var_461_3 < arg_458_1.time_ and arg_458_1.time_ <= var_461_3 + arg_461_0 then
				arg_458_1.talkMaxDuration = 0

				local var_461_10 = var_461_4 <= 0 and var_461_5 or var_461_5 * ((var_461_9 - arg_458_1.typewritterCharCountI18N) / var_461_4)

				if var_461_10 > 0 and var_461_5 < var_461_10 then
					arg_458_1.talkMaxDuration = var_461_10

					if var_461_10 + var_461_3 > arg_458_1.duration_ then
						arg_458_1.duration_ = var_461_10 + var_461_3
					end
				end
			end

			local var_461_11 = 2.93333333333333
			local var_461_12 = math.max(var_461_11, arg_458_1.talkMaxDuration)

			if var_461_3 <= arg_458_1.time_ and arg_458_1.time_ < var_461_3 + var_461_12 then
				local var_461_13 = (arg_458_1.time_ - var_461_3) / var_461_12

				arg_458_1.fswtw_.percent = Mathf.Lerp(arg_458_1.var_.oldValueTypewriter, var_461_8, var_461_13)
				arg_458_1.fswt_:GetComponent("Text").color = Color(1, 1, 1)

				arg_458_1.fswtw_:SetDirty()
			end

			if arg_458_1.time_ >= var_461_3 + var_461_12 and arg_458_1.time_ < var_461_3 + var_461_12 + arg_461_0 then
				arg_458_1.fswtw_.percent = var_461_8

				arg_458_1.fswtw_:SetDirty()
				arg_458_1:ShowNextGo(true)

				arg_458_1.typewritterCharCountI18N = var_461_9
			end

			local var_461_14 = 0.2
			local var_461_15 = 0.266666666666667
			local var_461_16 = manager.audio:GetVoiceLength("story_v_out_319501", "319501111", "story_v_out_319501.awb") / 1000

			if var_461_16 > 0 and var_461_15 < var_461_16 and var_461_16 + var_461_14 > arg_458_1.duration_ then
				local var_461_17 = var_461_16

				arg_458_1.duration_ = var_461_16 + var_461_14
			end

			if var_461_14 < arg_458_1.time_ and arg_458_1.time_ <= var_461_14 + arg_461_0 then
				local var_461_18 = "play"
				local var_461_19 = "voice"

				arg_458_1:AudioAction(var_461_18, var_461_19, "story_v_out_319501", "319501111", "story_v_out_319501.awb")
			end
		end

		arg_458_1.nodeConfigList_ = {}

		arg_458_1:InitPlayNodeList()
	end,
	Play319501112 = function(arg_462_0, arg_462_1)
		arg_462_1.time_ = 0
		arg_462_1.frameCnt_ = 0
		arg_462_1.state_ = "playing"
		arg_462_1.curTalkId_ = 319501112
		arg_462_1.duration_ = 1

		SetActive(arg_462_1.tipsGo_, false)

		function arg_462_1.onSingleLineFinish_()
			arg_462_1.onSingleLineUpdate_ = nil
			arg_462_1.onSingleLineFinish_ = nil
			arg_462_1.state_ = "waiting"
		end

		function arg_462_1.playNext_(arg_464_0)
			if arg_464_0 == 1 then
				arg_462_0:Play319501113(arg_462_1)
			end
		end

		function arg_462_1.onSingleLineUpdate_(arg_465_0)
			local var_465_0 = 0

			if var_465_0 < arg_462_1.time_ and arg_462_1.time_ <= var_465_0 + arg_465_0 then
				arg_462_1.fswbg_:SetActive(true)
				arg_462_1.dialog_:SetActive(false)

				arg_462_1.fswtw_.percent = 0

				local var_465_1 = arg_462_1:GetWordFromCfg(319501112)
				local var_465_2 = arg_462_1:FormatText(var_465_1.content)

				arg_462_1.fswt_.text = var_465_2

				LuaForUtil.ClearLinePrefixSymbol(arg_462_1.fswt_)

				arg_462_1.fswt_:GetComponent("Text").color = Color(1, 1, 1)
				arg_462_1.fswbg_.transform:Find("textbox/bg"):GetComponent("Image").enabled = false

				arg_462_1.fswtw_:SetDirty()

				arg_462_1.typewritterCharCountI18N = 0

				SetActive(arg_462_1.fswtw_.transform.parent.parent:Find("bg/line").gameObject, false)
				arg_462_1:ShowNextGo(false)
			end

			local var_465_3 = 0.2

			if var_465_3 < arg_462_1.time_ and arg_462_1.time_ <= var_465_3 + arg_465_0 then
				arg_462_1.var_.oldValueTypewriter = arg_462_1.fswtw_.percent

				SetActive(arg_462_1.fswtw_.transform.parent.parent:Find("bg/line").gameObject, false)
				arg_462_1:ShowNextGo(false)
			end

			local var_465_4 = 11
			local var_465_5 = 0.733333333333333
			local var_465_6 = arg_462_1:GetWordFromCfg(319501112)
			local var_465_7 = arg_462_1:FormatText(var_465_6.content)
			local var_465_8, var_465_9 = arg_462_1:GetPercentByPara(var_465_7, 1)

			if var_465_3 < arg_462_1.time_ and arg_462_1.time_ <= var_465_3 + arg_465_0 then
				arg_462_1.talkMaxDuration = 0

				local var_465_10 = var_465_4 <= 0 and var_465_5 or var_465_5 * ((var_465_9 - arg_462_1.typewritterCharCountI18N) / var_465_4)

				if var_465_10 > 0 and var_465_5 < var_465_10 then
					arg_462_1.talkMaxDuration = var_465_10

					if var_465_10 + var_465_3 > arg_462_1.duration_ then
						arg_462_1.duration_ = var_465_10 + var_465_3
					end
				end
			end

			local var_465_11 = 0.733333333333333
			local var_465_12 = math.max(var_465_11, arg_462_1.talkMaxDuration)

			if var_465_3 <= arg_462_1.time_ and arg_462_1.time_ < var_465_3 + var_465_12 then
				local var_465_13 = (arg_462_1.time_ - var_465_3) / var_465_12

				arg_462_1.fswtw_.percent = Mathf.Lerp(arg_462_1.var_.oldValueTypewriter, var_465_8, var_465_13)
				arg_462_1.fswt_:GetComponent("Text").color = Color(1, 1, 1)

				arg_462_1.fswtw_:SetDirty()
			end

			if arg_462_1.time_ >= var_465_3 + var_465_12 and arg_462_1.time_ < var_465_3 + var_465_12 + arg_465_0 then
				arg_462_1.fswtw_.percent = var_465_8

				arg_462_1.fswtw_:SetDirty()
				arg_462_1:ShowNextGo(true)

				arg_462_1.typewritterCharCountI18N = var_465_9
			end

			local var_465_14 = 0.2
			local var_465_15 = 0.266666666666667
			local var_465_16 = manager.audio:GetVoiceLength("story_v_out_319501", "319501112", "story_v_out_319501.awb") / 1000

			if var_465_16 > 0 and var_465_15 < var_465_16 and var_465_16 + var_465_14 > arg_462_1.duration_ then
				local var_465_17 = var_465_16

				arg_462_1.duration_ = var_465_16 + var_465_14
			end

			if var_465_14 < arg_462_1.time_ and arg_462_1.time_ <= var_465_14 + arg_465_0 then
				local var_465_18 = "play"
				local var_465_19 = "voice"

				arg_462_1:AudioAction(var_465_18, var_465_19, "story_v_out_319501", "319501112", "story_v_out_319501.awb")
			end
		end

		arg_462_1.nodeConfigList_ = {}

		arg_462_1:InitPlayNodeList()
	end,
	Play319501113 = function(arg_466_0, arg_466_1)
		arg_466_1.time_ = 0
		arg_466_1.frameCnt_ = 0
		arg_466_1.state_ = "playing"
		arg_466_1.curTalkId_ = 319501113
		arg_466_1.duration_ = 1

		SetActive(arg_466_1.tipsGo_, false)

		function arg_466_1.onSingleLineFinish_()
			arg_466_1.onSingleLineUpdate_ = nil
			arg_466_1.onSingleLineFinish_ = nil
			arg_466_1.state_ = "waiting"
		end

		function arg_466_1.playNext_(arg_468_0)
			if arg_468_0 == 1 then
				arg_466_0:Play319501114(arg_466_1)
			end
		end

		function arg_466_1.onSingleLineUpdate_(arg_469_0)
			local var_469_0 = 0

			if var_469_0 < arg_466_1.time_ and arg_466_1.time_ <= var_469_0 + arg_469_0 then
				arg_466_1.fswbg_:SetActive(true)
				arg_466_1.dialog_:SetActive(false)

				arg_466_1.fswtw_.percent = 0

				local var_469_1 = arg_466_1:GetWordFromCfg(319501113)
				local var_469_2 = arg_466_1:FormatText(var_469_1.content)

				arg_466_1.fswt_.text = var_469_2

				LuaForUtil.ClearLinePrefixSymbol(arg_466_1.fswt_)

				arg_466_1.fswt_:GetComponent("Text").color = Color(1, 1, 1)
				arg_466_1.fswbg_.transform:Find("textbox/bg"):GetComponent("Image").enabled = false

				arg_466_1.fswtw_:SetDirty()

				arg_466_1.typewritterCharCountI18N = 0

				SetActive(arg_466_1.fswtw_.transform.parent.parent:Find("bg/line").gameObject, false)
				arg_466_1:ShowNextGo(false)
			end

			local var_469_3 = 0.2

			if var_469_3 < arg_466_1.time_ and arg_466_1.time_ <= var_469_3 + arg_469_0 then
				arg_466_1.var_.oldValueTypewriter = arg_466_1.fswtw_.percent

				SetActive(arg_466_1.fswtw_.transform.parent.parent:Find("bg/line").gameObject, false)
				arg_466_1:ShowNextGo(false)
			end

			local var_469_4 = 9
			local var_469_5 = 0.6
			local var_469_6 = arg_466_1:GetWordFromCfg(319501113)
			local var_469_7 = arg_466_1:FormatText(var_469_6.content)
			local var_469_8, var_469_9 = arg_466_1:GetPercentByPara(var_469_7, 1)

			if var_469_3 < arg_466_1.time_ and arg_466_1.time_ <= var_469_3 + arg_469_0 then
				arg_466_1.talkMaxDuration = 0

				local var_469_10 = var_469_4 <= 0 and var_469_5 or var_469_5 * ((var_469_9 - arg_466_1.typewritterCharCountI18N) / var_469_4)

				if var_469_10 > 0 and var_469_5 < var_469_10 then
					arg_466_1.talkMaxDuration = var_469_10

					if var_469_10 + var_469_3 > arg_466_1.duration_ then
						arg_466_1.duration_ = var_469_10 + var_469_3
					end
				end
			end

			local var_469_11 = 0.6
			local var_469_12 = math.max(var_469_11, arg_466_1.talkMaxDuration)

			if var_469_3 <= arg_466_1.time_ and arg_466_1.time_ < var_469_3 + var_469_12 then
				local var_469_13 = (arg_466_1.time_ - var_469_3) / var_469_12

				arg_466_1.fswtw_.percent = Mathf.Lerp(arg_466_1.var_.oldValueTypewriter, var_469_8, var_469_13)
				arg_466_1.fswt_:GetComponent("Text").color = Color(1, 1, 1)

				arg_466_1.fswtw_:SetDirty()
			end

			if arg_466_1.time_ >= var_469_3 + var_469_12 and arg_466_1.time_ < var_469_3 + var_469_12 + arg_469_0 then
				arg_466_1.fswtw_.percent = var_469_8

				arg_466_1.fswtw_:SetDirty()
				arg_466_1:ShowNextGo(true)

				arg_466_1.typewritterCharCountI18N = var_469_9
			end

			local var_469_14 = 0.2
			local var_469_15 = 0.266666666666667
			local var_469_16 = manager.audio:GetVoiceLength("story_v_out_319501", "319501113", "story_v_out_319501.awb") / 1000

			if var_469_16 > 0 and var_469_15 < var_469_16 and var_469_16 + var_469_14 > arg_466_1.duration_ then
				local var_469_17 = var_469_16

				arg_466_1.duration_ = var_469_16 + var_469_14
			end

			if var_469_14 < arg_466_1.time_ and arg_466_1.time_ <= var_469_14 + arg_469_0 then
				local var_469_18 = "play"
				local var_469_19 = "voice"

				arg_466_1:AudioAction(var_469_18, var_469_19, "story_v_out_319501", "319501113", "story_v_out_319501.awb")
			end
		end

		arg_466_1.nodeConfigList_ = {}

		arg_466_1:InitPlayNodeList()
	end,
	Play319501114 = function(arg_470_0, arg_470_1)
		arg_470_1.time_ = 0
		arg_470_1.frameCnt_ = 0
		arg_470_1.state_ = "playing"
		arg_470_1.curTalkId_ = 319501114
		arg_470_1.duration_ = 11.48

		local var_470_0 = {
			zh = 5.85,
			ja = 11.483
		}
		local var_470_1 = manager.audio:GetLocalizationFlag()

		if var_470_0[var_470_1] ~= nil then
			arg_470_1.duration_ = var_470_0[var_470_1]
		end

		SetActive(arg_470_1.tipsGo_, false)

		function arg_470_1.onSingleLineFinish_()
			arg_470_1.onSingleLineUpdate_ = nil
			arg_470_1.onSingleLineFinish_ = nil
			arg_470_1.state_ = "waiting"
		end

		function arg_470_1.playNext_(arg_472_0)
			if arg_472_0 == 1 then
				arg_470_0:Play319501115(arg_470_1)
			end
		end

		function arg_470_1.onSingleLineUpdate_(arg_473_0)
			local var_473_0 = 0

			if var_473_0 < arg_470_1.time_ and arg_470_1.time_ <= var_473_0 + arg_473_0 then
				local var_473_1 = manager.ui.mainCamera.transform.localPosition
				local var_473_2 = Vector3.New(0, 0, 10) + Vector3.New(var_473_1.x, var_473_1.y, 0)
				local var_473_3 = arg_470_1.bgs_.ST71

				var_473_3.transform.localPosition = var_473_2
				var_473_3.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_473_4 = var_473_3:GetComponent("SpriteRenderer")

				if var_473_4 and var_473_4.sprite then
					local var_473_5 = (var_473_3.transform.localPosition - var_473_1).z
					local var_473_6 = manager.ui.mainCameraCom_
					local var_473_7 = 2 * var_473_5 * Mathf.Tan(var_473_6.fieldOfView * 0.5 * Mathf.Deg2Rad)
					local var_473_8 = var_473_7 * var_473_6.aspect
					local var_473_9 = var_473_4.sprite.bounds.size.x
					local var_473_10 = var_473_4.sprite.bounds.size.y
					local var_473_11 = var_473_8 / var_473_9
					local var_473_12 = var_473_7 / var_473_10
					local var_473_13 = var_473_12 < var_473_11 and var_473_11 or var_473_12

					var_473_3.transform.localScale = Vector3.New(var_473_13, var_473_13, 0)
				end

				for iter_473_0, iter_473_1 in pairs(arg_470_1.bgs_) do
					if iter_473_0 ~= "ST71" then
						iter_473_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_473_14 = 0

			if var_473_14 < arg_470_1.time_ and arg_470_1.time_ <= var_473_14 + arg_473_0 then
				arg_470_1.fswbg_:SetActive(false)
				arg_470_1.dialog_:SetActive(false)
				SetActive(arg_470_1.fswtw_.transform.parent.parent:Find("bg/line").gameObject, false)
				arg_470_1:ShowNextGo(false)
			end

			local var_473_15 = 0

			if var_473_15 < arg_470_1.time_ and arg_470_1.time_ <= var_473_15 + arg_473_0 then
				arg_470_1.cswbg_:SetActive(false)
			end

			local var_473_16 = arg_470_1.actors_["1084ui_story"].transform
			local var_473_17 = 1.35

			if var_473_17 < arg_470_1.time_ and arg_470_1.time_ <= var_473_17 + arg_473_0 then
				arg_470_1.var_.moveOldPos1084ui_story = var_473_16.localPosition
			end

			local var_473_18 = 0.001

			if var_473_17 <= arg_470_1.time_ and arg_470_1.time_ < var_473_17 + var_473_18 then
				local var_473_19 = (arg_470_1.time_ - var_473_17) / var_473_18
				local var_473_20 = Vector3.New(-0.7, -0.97, -6)

				var_473_16.localPosition = Vector3.Lerp(arg_470_1.var_.moveOldPos1084ui_story, var_473_20, var_473_19)

				local var_473_21 = manager.ui.mainCamera.transform.position - var_473_16.position

				var_473_16.forward = Vector3.New(var_473_21.x, var_473_21.y, var_473_21.z)

				local var_473_22 = var_473_16.localEulerAngles

				var_473_22.z = 0
				var_473_22.x = 0
				var_473_16.localEulerAngles = var_473_22
			end

			if arg_470_1.time_ >= var_473_17 + var_473_18 and arg_470_1.time_ < var_473_17 + var_473_18 + arg_473_0 then
				var_473_16.localPosition = Vector3.New(-0.7, -0.97, -6)

				local var_473_23 = manager.ui.mainCamera.transform.position - var_473_16.position

				var_473_16.forward = Vector3.New(var_473_23.x, var_473_23.y, var_473_23.z)

				local var_473_24 = var_473_16.localEulerAngles

				var_473_24.z = 0
				var_473_24.x = 0
				var_473_16.localEulerAngles = var_473_24
			end

			local var_473_25 = 1.35

			if var_473_25 < arg_470_1.time_ and arg_470_1.time_ <= var_473_25 + arg_473_0 then
				arg_470_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/story1084/story1084action/1084action1_1")
			end

			local var_473_26 = 1.35

			if var_473_26 < arg_470_1.time_ and arg_470_1.time_ <= var_473_26 + arg_473_0 then
				arg_470_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1101cva")
			end

			local var_473_27 = arg_470_1.actors_["1084ui_story"]
			local var_473_28 = 1.35

			if var_473_28 < arg_470_1.time_ and arg_470_1.time_ <= var_473_28 + arg_473_0 and not isNil(var_473_27) and arg_470_1.var_.characterEffect1084ui_story == nil then
				arg_470_1.var_.characterEffect1084ui_story = var_473_27:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_473_29 = 0.2

			if var_473_28 <= arg_470_1.time_ and arg_470_1.time_ < var_473_28 + var_473_29 and not isNil(var_473_27) then
				local var_473_30 = (arg_470_1.time_ - var_473_28) / var_473_29

				if arg_470_1.var_.characterEffect1084ui_story and not isNil(var_473_27) then
					arg_470_1.var_.characterEffect1084ui_story.fillFlat = false
				end
			end

			if arg_470_1.time_ >= var_473_28 + var_473_29 and arg_470_1.time_ < var_473_28 + var_473_29 + arg_473_0 and not isNil(var_473_27) and arg_470_1.var_.characterEffect1084ui_story then
				arg_470_1.var_.characterEffect1084ui_story.fillFlat = false
			end

			local var_473_31 = arg_470_1.actors_["10068ui_story"].transform
			local var_473_32 = 1.35

			if var_473_32 < arg_470_1.time_ and arg_470_1.time_ <= var_473_32 + arg_473_0 then
				arg_470_1.var_.moveOldPos10068ui_story = var_473_31.localPosition
			end

			local var_473_33 = 0.001

			if var_473_32 <= arg_470_1.time_ and arg_470_1.time_ < var_473_32 + var_473_33 then
				local var_473_34 = (arg_470_1.time_ - var_473_32) / var_473_33
				local var_473_35 = Vector3.New(0.7, -0.75, -6.18)

				var_473_31.localPosition = Vector3.Lerp(arg_470_1.var_.moveOldPos10068ui_story, var_473_35, var_473_34)

				local var_473_36 = manager.ui.mainCamera.transform.position - var_473_31.position

				var_473_31.forward = Vector3.New(var_473_36.x, var_473_36.y, var_473_36.z)

				local var_473_37 = var_473_31.localEulerAngles

				var_473_37.z = 0
				var_473_37.x = 0
				var_473_31.localEulerAngles = var_473_37
			end

			if arg_470_1.time_ >= var_473_32 + var_473_33 and arg_470_1.time_ < var_473_32 + var_473_33 + arg_473_0 then
				var_473_31.localPosition = Vector3.New(0.7, -0.75, -6.18)

				local var_473_38 = manager.ui.mainCamera.transform.position - var_473_31.position

				var_473_31.forward = Vector3.New(var_473_38.x, var_473_38.y, var_473_38.z)

				local var_473_39 = var_473_31.localEulerAngles

				var_473_39.z = 0
				var_473_39.x = 0
				var_473_31.localEulerAngles = var_473_39
			end

			local var_473_40 = arg_470_1.actors_["10068ui_story"]
			local var_473_41 = 1.35

			if var_473_41 < arg_470_1.time_ and arg_470_1.time_ <= var_473_41 + arg_473_0 and not isNil(var_473_40) and arg_470_1.var_.characterEffect10068ui_story == nil then
				arg_470_1.var_.characterEffect10068ui_story = var_473_40:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_473_42 = 0.2

			if var_473_41 <= arg_470_1.time_ and arg_470_1.time_ < var_473_41 + var_473_42 and not isNil(var_473_40) then
				local var_473_43 = (arg_470_1.time_ - var_473_41) / var_473_42

				if arg_470_1.var_.characterEffect10068ui_story and not isNil(var_473_40) then
					local var_473_44 = Mathf.Lerp(0, 0.5, var_473_43)

					arg_470_1.var_.characterEffect10068ui_story.fillFlat = true
					arg_470_1.var_.characterEffect10068ui_story.fillRatio = var_473_44
				end
			end

			if arg_470_1.time_ >= var_473_41 + var_473_42 and arg_470_1.time_ < var_473_41 + var_473_42 + arg_473_0 and not isNil(var_473_40) and arg_470_1.var_.characterEffect10068ui_story then
				local var_473_45 = 0.5

				arg_470_1.var_.characterEffect10068ui_story.fillFlat = true
				arg_470_1.var_.characterEffect10068ui_story.fillRatio = var_473_45
			end

			local var_473_46 = 1.35
			local var_473_47 = 0.65

			if var_473_46 < arg_470_1.time_ and arg_470_1.time_ <= var_473_46 + arg_473_0 then
				arg_470_1.talkMaxDuration = 0
				arg_470_1.dialogCg_.alpha = 1

				arg_470_1.dialog_:SetActive(true)
				SetActive(arg_470_1.leftNameGo_, true)

				local var_473_48 = arg_470_1:FormatText(StoryNameCfg[6].name)

				arg_470_1.leftNameTxt_.text = var_473_48

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_470_1.leftNameTxt_.transform)

				arg_470_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_470_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_470_1:RecordName(arg_470_1.leftNameTxt_.text)
				SetActive(arg_470_1.iconTrs_.gameObject, false)
				arg_470_1.callingController_:SetSelectedState("normal")

				local var_473_49 = arg_470_1:GetWordFromCfg(319501114)
				local var_473_50 = arg_470_1:FormatText(var_473_49.content)

				arg_470_1.text_.text = var_473_50

				LuaForUtil.ClearLinePrefixSymbol(arg_470_1.text_)

				local var_473_51 = 26
				local var_473_52 = utf8.len(var_473_50)
				local var_473_53 = var_473_51 <= 0 and var_473_47 or var_473_47 * (var_473_52 / var_473_51)

				if var_473_53 > 0 and var_473_47 < var_473_53 then
					arg_470_1.talkMaxDuration = var_473_53

					if var_473_53 + var_473_46 > arg_470_1.duration_ then
						arg_470_1.duration_ = var_473_53 + var_473_46
					end
				end

				arg_470_1.text_.text = var_473_50
				arg_470_1.typewritter.percent = 0

				arg_470_1.typewritter:SetDirty()
				arg_470_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_319501", "319501114", "story_v_out_319501.awb") ~= 0 then
					local var_473_54 = manager.audio:GetVoiceLength("story_v_out_319501", "319501114", "story_v_out_319501.awb") / 1000

					if var_473_54 + var_473_46 > arg_470_1.duration_ then
						arg_470_1.duration_ = var_473_54 + var_473_46
					end

					if var_473_49.prefab_name ~= "" and arg_470_1.actors_[var_473_49.prefab_name] ~= nil then
						local var_473_55 = LuaForUtil.PlayVoiceWithCriLipsync(arg_470_1.actors_[var_473_49.prefab_name].transform, "story_v_out_319501", "319501114", "story_v_out_319501.awb")

						arg_470_1:RecordAudio("319501114", var_473_55)
						arg_470_1:RecordAudio("319501114", var_473_55)
					else
						arg_470_1:AudioAction("play", "voice", "story_v_out_319501", "319501114", "story_v_out_319501.awb")
					end

					arg_470_1:RecordHistoryTalkVoice("story_v_out_319501", "319501114", "story_v_out_319501.awb")
				end

				arg_470_1:RecordContent(arg_470_1.text_.text)
			end

			local var_473_56 = math.max(var_473_47, arg_470_1.talkMaxDuration)

			if var_473_46 <= arg_470_1.time_ and arg_470_1.time_ < var_473_46 + var_473_56 then
				arg_470_1.typewritter.percent = (arg_470_1.time_ - var_473_46) / var_473_56

				arg_470_1.typewritter:SetDirty()
			end

			if arg_470_1.time_ >= var_473_46 + var_473_56 and arg_470_1.time_ < var_473_46 + var_473_56 + arg_473_0 then
				arg_470_1.typewritter.percent = 1

				arg_470_1.typewritter:SetDirty()
				arg_470_1:ShowNextGo(true)
			end
		end

		arg_470_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1084ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 1.35,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "10068ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 1.35,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_470_1:InitPlayNodeList()
	end,
	Play319501115 = function(arg_474_0, arg_474_1)
		arg_474_1.time_ = 0
		arg_474_1.frameCnt_ = 0
		arg_474_1.state_ = "playing"
		arg_474_1.curTalkId_ = 319501115
		arg_474_1.duration_ = 20.1

		local var_474_0 = {
			zh = 12.2,
			ja = 20.1
		}
		local var_474_1 = manager.audio:GetLocalizationFlag()

		if var_474_0[var_474_1] ~= nil then
			arg_474_1.duration_ = var_474_0[var_474_1]
		end

		SetActive(arg_474_1.tipsGo_, false)

		function arg_474_1.onSingleLineFinish_()
			arg_474_1.onSingleLineUpdate_ = nil
			arg_474_1.onSingleLineFinish_ = nil
			arg_474_1.state_ = "waiting"
		end

		function arg_474_1.playNext_(arg_476_0)
			if arg_476_0 == 1 then
				arg_474_0:Play319501116(arg_474_1)
			end
		end

		function arg_474_1.onSingleLineUpdate_(arg_477_0)
			local var_477_0 = 0

			if var_477_0 < arg_474_1.time_ and arg_474_1.time_ <= var_477_0 + arg_477_0 then
				arg_474_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/story1084/story1084action/1084action8_1")
			end

			local var_477_1 = 0

			if var_477_1 < arg_474_1.time_ and arg_474_1.time_ <= var_477_1 + arg_477_0 then
				arg_474_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3101cva")
			end

			local var_477_2 = 0
			local var_477_3 = 1.325

			if var_477_2 < arg_474_1.time_ and arg_474_1.time_ <= var_477_2 + arg_477_0 then
				arg_474_1.talkMaxDuration = 0
				arg_474_1.dialogCg_.alpha = 1

				arg_474_1.dialog_:SetActive(true)
				SetActive(arg_474_1.leftNameGo_, true)

				local var_477_4 = arg_474_1:FormatText(StoryNameCfg[6].name)

				arg_474_1.leftNameTxt_.text = var_477_4

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_474_1.leftNameTxt_.transform)

				arg_474_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_474_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_474_1:RecordName(arg_474_1.leftNameTxt_.text)
				SetActive(arg_474_1.iconTrs_.gameObject, false)
				arg_474_1.callingController_:SetSelectedState("normal")

				local var_477_5 = arg_474_1:GetWordFromCfg(319501115)
				local var_477_6 = arg_474_1:FormatText(var_477_5.content)

				arg_474_1.text_.text = var_477_6

				LuaForUtil.ClearLinePrefixSymbol(arg_474_1.text_)

				local var_477_7 = 53
				local var_477_8 = utf8.len(var_477_6)
				local var_477_9 = var_477_7 <= 0 and var_477_3 or var_477_3 * (var_477_8 / var_477_7)

				if var_477_9 > 0 and var_477_3 < var_477_9 then
					arg_474_1.talkMaxDuration = var_477_9

					if var_477_9 + var_477_2 > arg_474_1.duration_ then
						arg_474_1.duration_ = var_477_9 + var_477_2
					end
				end

				arg_474_1.text_.text = var_477_6
				arg_474_1.typewritter.percent = 0

				arg_474_1.typewritter:SetDirty()
				arg_474_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_319501", "319501115", "story_v_out_319501.awb") ~= 0 then
					local var_477_10 = manager.audio:GetVoiceLength("story_v_out_319501", "319501115", "story_v_out_319501.awb") / 1000

					if var_477_10 + var_477_2 > arg_474_1.duration_ then
						arg_474_1.duration_ = var_477_10 + var_477_2
					end

					if var_477_5.prefab_name ~= "" and arg_474_1.actors_[var_477_5.prefab_name] ~= nil then
						local var_477_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_474_1.actors_[var_477_5.prefab_name].transform, "story_v_out_319501", "319501115", "story_v_out_319501.awb")

						arg_474_1:RecordAudio("319501115", var_477_11)
						arg_474_1:RecordAudio("319501115", var_477_11)
					else
						arg_474_1:AudioAction("play", "voice", "story_v_out_319501", "319501115", "story_v_out_319501.awb")
					end

					arg_474_1:RecordHistoryTalkVoice("story_v_out_319501", "319501115", "story_v_out_319501.awb")
				end

				arg_474_1:RecordContent(arg_474_1.text_.text)
			end

			local var_477_12 = math.max(var_477_3, arg_474_1.talkMaxDuration)

			if var_477_2 <= arg_474_1.time_ and arg_474_1.time_ < var_477_2 + var_477_12 then
				arg_474_1.typewritter.percent = (arg_474_1.time_ - var_477_2) / var_477_12

				arg_474_1.typewritter:SetDirty()
			end

			if arg_474_1.time_ >= var_477_2 + var_477_12 and arg_474_1.time_ < var_477_2 + var_477_12 + arg_477_0 then
				arg_474_1.typewritter.percent = 1

				arg_474_1.typewritter:SetDirty()
				arg_474_1:ShowNextGo(true)
			end
		end

		arg_474_1.nodeConfigList_ = {}

		arg_474_1:InitPlayNodeList()
	end,
	Play319501116 = function(arg_478_0, arg_478_1)
		arg_478_1.time_ = 0
		arg_478_1.frameCnt_ = 0
		arg_478_1.state_ = "playing"
		arg_478_1.curTalkId_ = 319501116
		arg_478_1.duration_ = 4.83

		local var_478_0 = {
			zh = 4.366,
			ja = 4.833
		}
		local var_478_1 = manager.audio:GetLocalizationFlag()

		if var_478_0[var_478_1] ~= nil then
			arg_478_1.duration_ = var_478_0[var_478_1]
		end

		SetActive(arg_478_1.tipsGo_, false)

		function arg_478_1.onSingleLineFinish_()
			arg_478_1.onSingleLineUpdate_ = nil
			arg_478_1.onSingleLineFinish_ = nil
			arg_478_1.state_ = "waiting"
		end

		function arg_478_1.playNext_(arg_480_0)
			if arg_480_0 == 1 then
				arg_478_0:Play319501117(arg_478_1)
			end
		end

		function arg_478_1.onSingleLineUpdate_(arg_481_0)
			local var_481_0 = arg_478_1.actors_["10068ui_story"]
			local var_481_1 = 0

			if var_481_1 < arg_478_1.time_ and arg_478_1.time_ <= var_481_1 + arg_481_0 and not isNil(var_481_0) and arg_478_1.var_.characterEffect10068ui_story == nil then
				arg_478_1.var_.characterEffect10068ui_story = var_481_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_481_2 = 0.200000002980232

			if var_481_1 <= arg_478_1.time_ and arg_478_1.time_ < var_481_1 + var_481_2 and not isNil(var_481_0) then
				local var_481_3 = (arg_478_1.time_ - var_481_1) / var_481_2

				if arg_478_1.var_.characterEffect10068ui_story and not isNil(var_481_0) then
					arg_478_1.var_.characterEffect10068ui_story.fillFlat = false
				end
			end

			if arg_478_1.time_ >= var_481_1 + var_481_2 and arg_478_1.time_ < var_481_1 + var_481_2 + arg_481_0 and not isNil(var_481_0) and arg_478_1.var_.characterEffect10068ui_story then
				arg_478_1.var_.characterEffect10068ui_story.fillFlat = false
			end

			local var_481_4 = 0

			if var_481_4 < arg_478_1.time_ and arg_478_1.time_ <= var_481_4 + arg_481_0 then
				arg_478_1:PlayTimeline("10068ui_story", "StoryTimeline/CharAction/story10068/story10068action/10068action2_1")
			end

			local var_481_5 = 0

			if var_481_5 < arg_478_1.time_ and arg_478_1.time_ <= var_481_5 + arg_481_0 then
				arg_478_1:PlayTimeline("10068ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface2101cva")
			end

			local var_481_6 = arg_478_1.actors_["1084ui_story"]
			local var_481_7 = 0

			if var_481_7 < arg_478_1.time_ and arg_478_1.time_ <= var_481_7 + arg_481_0 and not isNil(var_481_6) and arg_478_1.var_.characterEffect1084ui_story == nil then
				arg_478_1.var_.characterEffect1084ui_story = var_481_6:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_481_8 = 0.200000002980232

			if var_481_7 <= arg_478_1.time_ and arg_478_1.time_ < var_481_7 + var_481_8 and not isNil(var_481_6) then
				local var_481_9 = (arg_478_1.time_ - var_481_7) / var_481_8

				if arg_478_1.var_.characterEffect1084ui_story and not isNil(var_481_6) then
					local var_481_10 = Mathf.Lerp(0, 0.5, var_481_9)

					arg_478_1.var_.characterEffect1084ui_story.fillFlat = true
					arg_478_1.var_.characterEffect1084ui_story.fillRatio = var_481_10
				end
			end

			if arg_478_1.time_ >= var_481_7 + var_481_8 and arg_478_1.time_ < var_481_7 + var_481_8 + arg_481_0 and not isNil(var_481_6) and arg_478_1.var_.characterEffect1084ui_story then
				local var_481_11 = 0.5

				arg_478_1.var_.characterEffect1084ui_story.fillFlat = true
				arg_478_1.var_.characterEffect1084ui_story.fillRatio = var_481_11
			end

			local var_481_12 = 0
			local var_481_13 = 0.325

			if var_481_12 < arg_478_1.time_ and arg_478_1.time_ <= var_481_12 + arg_481_0 then
				arg_478_1.talkMaxDuration = 0
				arg_478_1.dialogCg_.alpha = 1

				arg_478_1.dialog_:SetActive(true)
				SetActive(arg_478_1.leftNameGo_, true)

				local var_481_14 = arg_478_1:FormatText(StoryNameCfg[697].name)

				arg_478_1.leftNameTxt_.text = var_481_14

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_478_1.leftNameTxt_.transform)

				arg_478_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_478_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_478_1:RecordName(arg_478_1.leftNameTxt_.text)
				SetActive(arg_478_1.iconTrs_.gameObject, false)
				arg_478_1.callingController_:SetSelectedState("normal")

				local var_481_15 = arg_478_1:GetWordFromCfg(319501116)
				local var_481_16 = arg_478_1:FormatText(var_481_15.content)

				arg_478_1.text_.text = var_481_16

				LuaForUtil.ClearLinePrefixSymbol(arg_478_1.text_)

				local var_481_17 = 13
				local var_481_18 = utf8.len(var_481_16)
				local var_481_19 = var_481_17 <= 0 and var_481_13 or var_481_13 * (var_481_18 / var_481_17)

				if var_481_19 > 0 and var_481_13 < var_481_19 then
					arg_478_1.talkMaxDuration = var_481_19

					if var_481_19 + var_481_12 > arg_478_1.duration_ then
						arg_478_1.duration_ = var_481_19 + var_481_12
					end
				end

				arg_478_1.text_.text = var_481_16
				arg_478_1.typewritter.percent = 0

				arg_478_1.typewritter:SetDirty()
				arg_478_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_319501", "319501116", "story_v_out_319501.awb") ~= 0 then
					local var_481_20 = manager.audio:GetVoiceLength("story_v_out_319501", "319501116", "story_v_out_319501.awb") / 1000

					if var_481_20 + var_481_12 > arg_478_1.duration_ then
						arg_478_1.duration_ = var_481_20 + var_481_12
					end

					if var_481_15.prefab_name ~= "" and arg_478_1.actors_[var_481_15.prefab_name] ~= nil then
						local var_481_21 = LuaForUtil.PlayVoiceWithCriLipsync(arg_478_1.actors_[var_481_15.prefab_name].transform, "story_v_out_319501", "319501116", "story_v_out_319501.awb")

						arg_478_1:RecordAudio("319501116", var_481_21)
						arg_478_1:RecordAudio("319501116", var_481_21)
					else
						arg_478_1:AudioAction("play", "voice", "story_v_out_319501", "319501116", "story_v_out_319501.awb")
					end

					arg_478_1:RecordHistoryTalkVoice("story_v_out_319501", "319501116", "story_v_out_319501.awb")
				end

				arg_478_1:RecordContent(arg_478_1.text_.text)
			end

			local var_481_22 = math.max(var_481_13, arg_478_1.talkMaxDuration)

			if var_481_12 <= arg_478_1.time_ and arg_478_1.time_ < var_481_12 + var_481_22 then
				arg_478_1.typewritter.percent = (arg_478_1.time_ - var_481_12) / var_481_22

				arg_478_1.typewritter:SetDirty()
			end

			if arg_478_1.time_ >= var_481_12 + var_481_22 and arg_478_1.time_ < var_481_12 + var_481_22 + arg_481_0 then
				arg_478_1.typewritter.percent = 1

				arg_478_1.typewritter:SetDirty()
				arg_478_1:ShowNextGo(true)
			end
		end

		arg_478_1.nodeConfigList_ = {}

		arg_478_1:InitPlayNodeList()
	end,
	Play319501117 = function(arg_482_0, arg_482_1)
		arg_482_1.time_ = 0
		arg_482_1.frameCnt_ = 0
		arg_482_1.state_ = "playing"
		arg_482_1.curTalkId_ = 319501117
		arg_482_1.duration_ = 8.07

		local var_482_0 = {
			zh = 3.1,
			ja = 8.066
		}
		local var_482_1 = manager.audio:GetLocalizationFlag()

		if var_482_0[var_482_1] ~= nil then
			arg_482_1.duration_ = var_482_0[var_482_1]
		end

		SetActive(arg_482_1.tipsGo_, false)

		function arg_482_1.onSingleLineFinish_()
			arg_482_1.onSingleLineUpdate_ = nil
			arg_482_1.onSingleLineFinish_ = nil
			arg_482_1.state_ = "waiting"
		end

		function arg_482_1.playNext_(arg_484_0)
			if arg_484_0 == 1 then
				arg_482_0:Play319501118(arg_482_1)
			end
		end

		function arg_482_1.onSingleLineUpdate_(arg_485_0)
			local var_485_0 = arg_482_1.actors_["10068ui_story"]
			local var_485_1 = 0

			if var_485_1 < arg_482_1.time_ and arg_482_1.time_ <= var_485_1 + arg_485_0 and not isNil(var_485_0) and arg_482_1.var_.characterEffect10068ui_story == nil then
				arg_482_1.var_.characterEffect10068ui_story = var_485_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_485_2 = 0.200000002980232

			if var_485_1 <= arg_482_1.time_ and arg_482_1.time_ < var_485_1 + var_485_2 and not isNil(var_485_0) then
				local var_485_3 = (arg_482_1.time_ - var_485_1) / var_485_2

				if arg_482_1.var_.characterEffect10068ui_story and not isNil(var_485_0) then
					local var_485_4 = Mathf.Lerp(0, 0.5, var_485_3)

					arg_482_1.var_.characterEffect10068ui_story.fillFlat = true
					arg_482_1.var_.characterEffect10068ui_story.fillRatio = var_485_4
				end
			end

			if arg_482_1.time_ >= var_485_1 + var_485_2 and arg_482_1.time_ < var_485_1 + var_485_2 + arg_485_0 and not isNil(var_485_0) and arg_482_1.var_.characterEffect10068ui_story then
				local var_485_5 = 0.5

				arg_482_1.var_.characterEffect10068ui_story.fillFlat = true
				arg_482_1.var_.characterEffect10068ui_story.fillRatio = var_485_5
			end

			local var_485_6 = arg_482_1.actors_["1084ui_story"]
			local var_485_7 = 0

			if var_485_7 < arg_482_1.time_ and arg_482_1.time_ <= var_485_7 + arg_485_0 and not isNil(var_485_6) and arg_482_1.var_.characterEffect1084ui_story == nil then
				arg_482_1.var_.characterEffect1084ui_story = var_485_6:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_485_8 = 0.200000002980232

			if var_485_7 <= arg_482_1.time_ and arg_482_1.time_ < var_485_7 + var_485_8 and not isNil(var_485_6) then
				local var_485_9 = (arg_482_1.time_ - var_485_7) / var_485_8

				if arg_482_1.var_.characterEffect1084ui_story and not isNil(var_485_6) then
					arg_482_1.var_.characterEffect1084ui_story.fillFlat = false
				end
			end

			if arg_482_1.time_ >= var_485_7 + var_485_8 and arg_482_1.time_ < var_485_7 + var_485_8 + arg_485_0 and not isNil(var_485_6) and arg_482_1.var_.characterEffect1084ui_story then
				arg_482_1.var_.characterEffect1084ui_story.fillFlat = false
			end

			local var_485_10 = 0

			if var_485_10 < arg_482_1.time_ and arg_482_1.time_ <= var_485_10 + arg_485_0 then
				arg_482_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/story1084/story1084action/1084action8_2")
			end

			local var_485_11 = 0

			if var_485_11 < arg_482_1.time_ and arg_482_1.time_ <= var_485_11 + arg_485_0 then
				arg_482_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface2101cva")
			end

			local var_485_12 = 0
			local var_485_13 = 0.25

			if var_485_12 < arg_482_1.time_ and arg_482_1.time_ <= var_485_12 + arg_485_0 then
				arg_482_1.talkMaxDuration = 0
				arg_482_1.dialogCg_.alpha = 1

				arg_482_1.dialog_:SetActive(true)
				SetActive(arg_482_1.leftNameGo_, true)

				local var_485_14 = arg_482_1:FormatText(StoryNameCfg[6].name)

				arg_482_1.leftNameTxt_.text = var_485_14

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_482_1.leftNameTxt_.transform)

				arg_482_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_482_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_482_1:RecordName(arg_482_1.leftNameTxt_.text)
				SetActive(arg_482_1.iconTrs_.gameObject, false)
				arg_482_1.callingController_:SetSelectedState("normal")

				local var_485_15 = arg_482_1:GetWordFromCfg(319501117)
				local var_485_16 = arg_482_1:FormatText(var_485_15.content)

				arg_482_1.text_.text = var_485_16

				LuaForUtil.ClearLinePrefixSymbol(arg_482_1.text_)

				local var_485_17 = 10
				local var_485_18 = utf8.len(var_485_16)
				local var_485_19 = var_485_17 <= 0 and var_485_13 or var_485_13 * (var_485_18 / var_485_17)

				if var_485_19 > 0 and var_485_13 < var_485_19 then
					arg_482_1.talkMaxDuration = var_485_19

					if var_485_19 + var_485_12 > arg_482_1.duration_ then
						arg_482_1.duration_ = var_485_19 + var_485_12
					end
				end

				arg_482_1.text_.text = var_485_16
				arg_482_1.typewritter.percent = 0

				arg_482_1.typewritter:SetDirty()
				arg_482_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_319501", "319501117", "story_v_out_319501.awb") ~= 0 then
					local var_485_20 = manager.audio:GetVoiceLength("story_v_out_319501", "319501117", "story_v_out_319501.awb") / 1000

					if var_485_20 + var_485_12 > arg_482_1.duration_ then
						arg_482_1.duration_ = var_485_20 + var_485_12
					end

					if var_485_15.prefab_name ~= "" and arg_482_1.actors_[var_485_15.prefab_name] ~= nil then
						local var_485_21 = LuaForUtil.PlayVoiceWithCriLipsync(arg_482_1.actors_[var_485_15.prefab_name].transform, "story_v_out_319501", "319501117", "story_v_out_319501.awb")

						arg_482_1:RecordAudio("319501117", var_485_21)
						arg_482_1:RecordAudio("319501117", var_485_21)
					else
						arg_482_1:AudioAction("play", "voice", "story_v_out_319501", "319501117", "story_v_out_319501.awb")
					end

					arg_482_1:RecordHistoryTalkVoice("story_v_out_319501", "319501117", "story_v_out_319501.awb")
				end

				arg_482_1:RecordContent(arg_482_1.text_.text)
			end

			local var_485_22 = math.max(var_485_13, arg_482_1.talkMaxDuration)

			if var_485_12 <= arg_482_1.time_ and arg_482_1.time_ < var_485_12 + var_485_22 then
				arg_482_1.typewritter.percent = (arg_482_1.time_ - var_485_12) / var_485_22

				arg_482_1.typewritter:SetDirty()
			end

			if arg_482_1.time_ >= var_485_12 + var_485_22 and arg_482_1.time_ < var_485_12 + var_485_22 + arg_485_0 then
				arg_482_1.typewritter.percent = 1

				arg_482_1.typewritter:SetDirty()
				arg_482_1:ShowNextGo(true)
			end
		end

		arg_482_1.nodeConfigList_ = {}

		arg_482_1:InitPlayNodeList()
	end,
	Play319501118 = function(arg_486_0, arg_486_1)
		arg_486_1.time_ = 0
		arg_486_1.frameCnt_ = 0
		arg_486_1.state_ = "playing"
		arg_486_1.curTalkId_ = 319501118
		arg_486_1.duration_ = 5

		SetActive(arg_486_1.tipsGo_, false)

		function arg_486_1.onSingleLineFinish_()
			arg_486_1.onSingleLineUpdate_ = nil
			arg_486_1.onSingleLineFinish_ = nil
			arg_486_1.state_ = "waiting"
		end

		function arg_486_1.playNext_(arg_488_0)
			if arg_488_0 == 1 then
				arg_486_0:Play319501119(arg_486_1)
			end
		end

		function arg_486_1.onSingleLineUpdate_(arg_489_0)
			local var_489_0 = 0

			if var_489_0 < arg_486_1.time_ and arg_486_1.time_ <= var_489_0 + arg_489_0 then
				arg_486_1:PlayTimeline("10068ui_story", "StoryTimeline/CharAction/story10068/story10068action/10068action2_2")
			end

			local var_489_1 = 0

			if var_489_1 < arg_486_1.time_ and arg_486_1.time_ <= var_489_1 + arg_489_0 then
				arg_486_1:PlayTimeline("10068ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3201cva")
			end

			local var_489_2 = arg_486_1.actors_["1084ui_story"]
			local var_489_3 = 0

			if var_489_3 < arg_486_1.time_ and arg_486_1.time_ <= var_489_3 + arg_489_0 and not isNil(var_489_2) and arg_486_1.var_.characterEffect1084ui_story == nil then
				arg_486_1.var_.characterEffect1084ui_story = var_489_2:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_489_4 = 0.200000002980232

			if var_489_3 <= arg_486_1.time_ and arg_486_1.time_ < var_489_3 + var_489_4 and not isNil(var_489_2) then
				local var_489_5 = (arg_486_1.time_ - var_489_3) / var_489_4

				if arg_486_1.var_.characterEffect1084ui_story and not isNil(var_489_2) then
					local var_489_6 = Mathf.Lerp(0, 0.5, var_489_5)

					arg_486_1.var_.characterEffect1084ui_story.fillFlat = true
					arg_486_1.var_.characterEffect1084ui_story.fillRatio = var_489_6
				end
			end

			if arg_486_1.time_ >= var_489_3 + var_489_4 and arg_486_1.time_ < var_489_3 + var_489_4 + arg_489_0 and not isNil(var_489_2) and arg_486_1.var_.characterEffect1084ui_story then
				local var_489_7 = 0.5

				arg_486_1.var_.characterEffect1084ui_story.fillFlat = true
				arg_486_1.var_.characterEffect1084ui_story.fillRatio = var_489_7
			end

			local var_489_8 = 0
			local var_489_9 = 0.65

			if var_489_8 < arg_486_1.time_ and arg_486_1.time_ <= var_489_8 + arg_489_0 then
				arg_486_1.talkMaxDuration = 0
				arg_486_1.dialogCg_.alpha = 1

				arg_486_1.dialog_:SetActive(true)
				SetActive(arg_486_1.leftNameGo_, false)

				arg_486_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_486_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_486_1:RecordName(arg_486_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_486_1.iconTrs_.gameObject, false)
				arg_486_1.callingController_:SetSelectedState("normal")

				local var_489_10 = arg_486_1:GetWordFromCfg(319501118)
				local var_489_11 = arg_486_1:FormatText(var_489_10.content)

				arg_486_1.text_.text = var_489_11

				LuaForUtil.ClearLinePrefixSymbol(arg_486_1.text_)

				local var_489_12 = 26
				local var_489_13 = utf8.len(var_489_11)
				local var_489_14 = var_489_12 <= 0 and var_489_9 or var_489_9 * (var_489_13 / var_489_12)

				if var_489_14 > 0 and var_489_9 < var_489_14 then
					arg_486_1.talkMaxDuration = var_489_14

					if var_489_14 + var_489_8 > arg_486_1.duration_ then
						arg_486_1.duration_ = var_489_14 + var_489_8
					end
				end

				arg_486_1.text_.text = var_489_11
				arg_486_1.typewritter.percent = 0

				arg_486_1.typewritter:SetDirty()
				arg_486_1:ShowNextGo(false)
				arg_486_1:RecordContent(arg_486_1.text_.text)
			end

			local var_489_15 = math.max(var_489_9, arg_486_1.talkMaxDuration)

			if var_489_8 <= arg_486_1.time_ and arg_486_1.time_ < var_489_8 + var_489_15 then
				arg_486_1.typewritter.percent = (arg_486_1.time_ - var_489_8) / var_489_15

				arg_486_1.typewritter:SetDirty()
			end

			if arg_486_1.time_ >= var_489_8 + var_489_15 and arg_486_1.time_ < var_489_8 + var_489_15 + arg_489_0 then
				arg_486_1.typewritter.percent = 1

				arg_486_1.typewritter:SetDirty()
				arg_486_1:ShowNextGo(true)
			end
		end

		arg_486_1.nodeConfigList_ = {}

		arg_486_1:InitPlayNodeList()
	end,
	Play319501119 = function(arg_490_0, arg_490_1)
		arg_490_1.time_ = 0
		arg_490_1.frameCnt_ = 0
		arg_490_1.state_ = "playing"
		arg_490_1.curTalkId_ = 319501119
		arg_490_1.duration_ = 5

		SetActive(arg_490_1.tipsGo_, false)

		function arg_490_1.onSingleLineFinish_()
			arg_490_1.onSingleLineUpdate_ = nil
			arg_490_1.onSingleLineFinish_ = nil
			arg_490_1.state_ = "waiting"
		end

		function arg_490_1.playNext_(arg_492_0)
			if arg_492_0 == 1 then
				arg_490_0:Play319501120(arg_490_1)
			end
		end

		function arg_490_1.onSingleLineUpdate_(arg_493_0)
			local var_493_0 = 0
			local var_493_1 = 1

			if var_493_0 < arg_490_1.time_ and arg_490_1.time_ <= var_493_0 + arg_493_0 then
				local var_493_2 = "play"
				local var_493_3 = "effect"

				arg_490_1:AudioAction(var_493_2, var_493_3, "se_story_130", "se_story_130_didi", "")
			end

			local var_493_4 = 0

			if var_493_4 < arg_490_1.time_ and arg_490_1.time_ <= var_493_4 + arg_493_0 then
				arg_490_1:PlayTimeline("10068ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1101cva")
			end

			local var_493_5 = 0

			if var_493_5 < arg_490_1.time_ and arg_490_1.time_ <= var_493_5 + arg_493_0 then
				arg_490_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1101cva")
			end

			local var_493_6 = 0
			local var_493_7 = 1.475

			if var_493_6 < arg_490_1.time_ and arg_490_1.time_ <= var_493_6 + arg_493_0 then
				arg_490_1.talkMaxDuration = 0
				arg_490_1.dialogCg_.alpha = 1

				arg_490_1.dialog_:SetActive(true)
				SetActive(arg_490_1.leftNameGo_, false)

				arg_490_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_490_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_490_1:RecordName(arg_490_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_490_1.iconTrs_.gameObject, false)
				arg_490_1.callingController_:SetSelectedState("normal")

				local var_493_8 = arg_490_1:GetWordFromCfg(319501119)
				local var_493_9 = arg_490_1:FormatText(var_493_8.content)

				arg_490_1.text_.text = var_493_9

				LuaForUtil.ClearLinePrefixSymbol(arg_490_1.text_)

				local var_493_10 = 59
				local var_493_11 = utf8.len(var_493_9)
				local var_493_12 = var_493_10 <= 0 and var_493_7 or var_493_7 * (var_493_11 / var_493_10)

				if var_493_12 > 0 and var_493_7 < var_493_12 then
					arg_490_1.talkMaxDuration = var_493_12

					if var_493_12 + var_493_6 > arg_490_1.duration_ then
						arg_490_1.duration_ = var_493_12 + var_493_6
					end
				end

				arg_490_1.text_.text = var_493_9
				arg_490_1.typewritter.percent = 0

				arg_490_1.typewritter:SetDirty()
				arg_490_1:ShowNextGo(false)
				arg_490_1:RecordContent(arg_490_1.text_.text)
			end

			local var_493_13 = math.max(var_493_7, arg_490_1.talkMaxDuration)

			if var_493_6 <= arg_490_1.time_ and arg_490_1.time_ < var_493_6 + var_493_13 then
				arg_490_1.typewritter.percent = (arg_490_1.time_ - var_493_6) / var_493_13

				arg_490_1.typewritter:SetDirty()
			end

			if arg_490_1.time_ >= var_493_6 + var_493_13 and arg_490_1.time_ < var_493_6 + var_493_13 + arg_493_0 then
				arg_490_1.typewritter.percent = 1

				arg_490_1.typewritter:SetDirty()
				arg_490_1:ShowNextGo(true)
			end
		end

		arg_490_1.nodeConfigList_ = {}

		arg_490_1:InitPlayNodeList()
	end,
	Play319501120 = function(arg_494_0, arg_494_1)
		arg_494_1.time_ = 0
		arg_494_1.frameCnt_ = 0
		arg_494_1.state_ = "playing"
		arg_494_1.curTalkId_ = 319501120
		arg_494_1.duration_ = 8.5

		local var_494_0 = {
			zh = 5.5,
			ja = 8.5
		}
		local var_494_1 = manager.audio:GetLocalizationFlag()

		if var_494_0[var_494_1] ~= nil then
			arg_494_1.duration_ = var_494_0[var_494_1]
		end

		SetActive(arg_494_1.tipsGo_, false)

		function arg_494_1.onSingleLineFinish_()
			arg_494_1.onSingleLineUpdate_ = nil
			arg_494_1.onSingleLineFinish_ = nil
			arg_494_1.state_ = "waiting"
		end

		function arg_494_1.playNext_(arg_496_0)
			if arg_496_0 == 1 then
				arg_494_0:Play319501121(arg_494_1)
			end
		end

		function arg_494_1.onSingleLineUpdate_(arg_497_0)
			local var_497_0 = arg_494_1.actors_["1084ui_story"]
			local var_497_1 = 0

			if var_497_1 < arg_494_1.time_ and arg_494_1.time_ <= var_497_1 + arg_497_0 and not isNil(var_497_0) and arg_494_1.var_.characterEffect1084ui_story == nil then
				arg_494_1.var_.characterEffect1084ui_story = var_497_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_497_2 = 0.200000002980232

			if var_497_1 <= arg_494_1.time_ and arg_494_1.time_ < var_497_1 + var_497_2 and not isNil(var_497_0) then
				local var_497_3 = (arg_494_1.time_ - var_497_1) / var_497_2

				if arg_494_1.var_.characterEffect1084ui_story and not isNil(var_497_0) then
					arg_494_1.var_.characterEffect1084ui_story.fillFlat = false
				end
			end

			if arg_494_1.time_ >= var_497_1 + var_497_2 and arg_494_1.time_ < var_497_1 + var_497_2 + arg_497_0 and not isNil(var_497_0) and arg_494_1.var_.characterEffect1084ui_story then
				arg_494_1.var_.characterEffect1084ui_story.fillFlat = false
			end

			local var_497_4 = 0

			if var_497_4 < arg_494_1.time_ and arg_494_1.time_ <= var_497_4 + arg_497_0 then
				arg_494_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/story1084/story1084action/1084action6_1")
			end

			local var_497_5 = 0

			if var_497_5 < arg_494_1.time_ and arg_494_1.time_ <= var_497_5 + arg_497_0 then
				arg_494_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface2101cva")
			end

			local var_497_6 = 0
			local var_497_7 = 1

			if var_497_6 < arg_494_1.time_ and arg_494_1.time_ <= var_497_6 + arg_497_0 then
				local var_497_8 = "stop"
				local var_497_9 = "effect"

				arg_494_1:AudioAction(var_497_8, var_497_9, "se_story_130", "se_story_130_didi", "")
			end

			local var_497_10 = 0
			local var_497_11 = 0.575

			if var_497_10 < arg_494_1.time_ and arg_494_1.time_ <= var_497_10 + arg_497_0 then
				arg_494_1.talkMaxDuration = 0
				arg_494_1.dialogCg_.alpha = 1

				arg_494_1.dialog_:SetActive(true)
				SetActive(arg_494_1.leftNameGo_, true)

				local var_497_12 = arg_494_1:FormatText(StoryNameCfg[6].name)

				arg_494_1.leftNameTxt_.text = var_497_12

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_494_1.leftNameTxt_.transform)

				arg_494_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_494_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_494_1:RecordName(arg_494_1.leftNameTxt_.text)
				SetActive(arg_494_1.iconTrs_.gameObject, false)
				arg_494_1.callingController_:SetSelectedState("normal")

				local var_497_13 = arg_494_1:GetWordFromCfg(319501120)
				local var_497_14 = arg_494_1:FormatText(var_497_13.content)

				arg_494_1.text_.text = var_497_14

				LuaForUtil.ClearLinePrefixSymbol(arg_494_1.text_)

				local var_497_15 = 23
				local var_497_16 = utf8.len(var_497_14)
				local var_497_17 = var_497_15 <= 0 and var_497_11 or var_497_11 * (var_497_16 / var_497_15)

				if var_497_17 > 0 and var_497_11 < var_497_17 then
					arg_494_1.talkMaxDuration = var_497_17

					if var_497_17 + var_497_10 > arg_494_1.duration_ then
						arg_494_1.duration_ = var_497_17 + var_497_10
					end
				end

				arg_494_1.text_.text = var_497_14
				arg_494_1.typewritter.percent = 0

				arg_494_1.typewritter:SetDirty()
				arg_494_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_319501", "319501120", "story_v_out_319501.awb") ~= 0 then
					local var_497_18 = manager.audio:GetVoiceLength("story_v_out_319501", "319501120", "story_v_out_319501.awb") / 1000

					if var_497_18 + var_497_10 > arg_494_1.duration_ then
						arg_494_1.duration_ = var_497_18 + var_497_10
					end

					if var_497_13.prefab_name ~= "" and arg_494_1.actors_[var_497_13.prefab_name] ~= nil then
						local var_497_19 = LuaForUtil.PlayVoiceWithCriLipsync(arg_494_1.actors_[var_497_13.prefab_name].transform, "story_v_out_319501", "319501120", "story_v_out_319501.awb")

						arg_494_1:RecordAudio("319501120", var_497_19)
						arg_494_1:RecordAudio("319501120", var_497_19)
					else
						arg_494_1:AudioAction("play", "voice", "story_v_out_319501", "319501120", "story_v_out_319501.awb")
					end

					arg_494_1:RecordHistoryTalkVoice("story_v_out_319501", "319501120", "story_v_out_319501.awb")
				end

				arg_494_1:RecordContent(arg_494_1.text_.text)
			end

			local var_497_20 = math.max(var_497_11, arg_494_1.talkMaxDuration)

			if var_497_10 <= arg_494_1.time_ and arg_494_1.time_ < var_497_10 + var_497_20 then
				arg_494_1.typewritter.percent = (arg_494_1.time_ - var_497_10) / var_497_20

				arg_494_1.typewritter:SetDirty()
			end

			if arg_494_1.time_ >= var_497_10 + var_497_20 and arg_494_1.time_ < var_497_10 + var_497_20 + arg_497_0 then
				arg_494_1.typewritter.percent = 1

				arg_494_1.typewritter:SetDirty()
				arg_494_1:ShowNextGo(true)
			end
		end

		arg_494_1.nodeConfigList_ = {}

		arg_494_1:InitPlayNodeList()
	end,
	Play319501121 = function(arg_498_0, arg_498_1)
		arg_498_1.time_ = 0
		arg_498_1.frameCnt_ = 0
		arg_498_1.state_ = "playing"
		arg_498_1.curTalkId_ = 319501121
		arg_498_1.duration_ = 3.8

		local var_498_0 = {
			zh = 1.999999999999,
			ja = 3.8
		}
		local var_498_1 = manager.audio:GetLocalizationFlag()

		if var_498_0[var_498_1] ~= nil then
			arg_498_1.duration_ = var_498_0[var_498_1]
		end

		SetActive(arg_498_1.tipsGo_, false)

		function arg_498_1.onSingleLineFinish_()
			arg_498_1.onSingleLineUpdate_ = nil
			arg_498_1.onSingleLineFinish_ = nil
			arg_498_1.state_ = "waiting"
		end

		function arg_498_1.playNext_(arg_500_0)
			if arg_500_0 == 1 then
				arg_498_0:Play319501122(arg_498_1)
			end
		end

		function arg_498_1.onSingleLineUpdate_(arg_501_0)
			local var_501_0 = arg_498_1.actors_["1084ui_story"]
			local var_501_1 = 0

			if var_501_1 < arg_498_1.time_ and arg_498_1.time_ <= var_501_1 + arg_501_0 and not isNil(var_501_0) and arg_498_1.var_.characterEffect1084ui_story == nil then
				arg_498_1.var_.characterEffect1084ui_story = var_501_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_501_2 = 0.200000002980232

			if var_501_1 <= arg_498_1.time_ and arg_498_1.time_ < var_501_1 + var_501_2 and not isNil(var_501_0) then
				local var_501_3 = (arg_498_1.time_ - var_501_1) / var_501_2

				if arg_498_1.var_.characterEffect1084ui_story and not isNil(var_501_0) then
					local var_501_4 = Mathf.Lerp(0, 0.5, var_501_3)

					arg_498_1.var_.characterEffect1084ui_story.fillFlat = true
					arg_498_1.var_.characterEffect1084ui_story.fillRatio = var_501_4
				end
			end

			if arg_498_1.time_ >= var_501_1 + var_501_2 and arg_498_1.time_ < var_501_1 + var_501_2 + arg_501_0 and not isNil(var_501_0) and arg_498_1.var_.characterEffect1084ui_story then
				local var_501_5 = 0.5

				arg_498_1.var_.characterEffect1084ui_story.fillFlat = true
				arg_498_1.var_.characterEffect1084ui_story.fillRatio = var_501_5
			end

			local var_501_6 = 0

			if var_501_6 < arg_498_1.time_ and arg_498_1.time_ <= var_501_6 + arg_501_0 then
				arg_498_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/story1084/story1084action/1084action6_2")
			end

			local var_501_7 = 0

			if var_501_7 < arg_498_1.time_ and arg_498_1.time_ <= var_501_7 + arg_501_0 then
				arg_498_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0101cva")
			end

			local var_501_8 = arg_498_1.actors_["10068ui_story"]
			local var_501_9 = 0

			if var_501_9 < arg_498_1.time_ and arg_498_1.time_ <= var_501_9 + arg_501_0 and not isNil(var_501_8) and arg_498_1.var_.characterEffect10068ui_story == nil then
				arg_498_1.var_.characterEffect10068ui_story = var_501_8:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_501_10 = 0.200000002980232

			if var_501_9 <= arg_498_1.time_ and arg_498_1.time_ < var_501_9 + var_501_10 and not isNil(var_501_8) then
				local var_501_11 = (arg_498_1.time_ - var_501_9) / var_501_10

				if arg_498_1.var_.characterEffect10068ui_story and not isNil(var_501_8) then
					arg_498_1.var_.characterEffect10068ui_story.fillFlat = false
				end
			end

			if arg_498_1.time_ >= var_501_9 + var_501_10 and arg_498_1.time_ < var_501_9 + var_501_10 + arg_501_0 and not isNil(var_501_8) and arg_498_1.var_.characterEffect10068ui_story then
				arg_498_1.var_.characterEffect10068ui_story.fillFlat = false
			end

			local var_501_12 = 0
			local var_501_13 = 0.125

			if var_501_12 < arg_498_1.time_ and arg_498_1.time_ <= var_501_12 + arg_501_0 then
				arg_498_1.talkMaxDuration = 0
				arg_498_1.dialogCg_.alpha = 1

				arg_498_1.dialog_:SetActive(true)
				SetActive(arg_498_1.leftNameGo_, true)

				local var_501_14 = arg_498_1:FormatText(StoryNameCfg[697].name)

				arg_498_1.leftNameTxt_.text = var_501_14

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_498_1.leftNameTxt_.transform)

				arg_498_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_498_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_498_1:RecordName(arg_498_1.leftNameTxt_.text)
				SetActive(arg_498_1.iconTrs_.gameObject, false)
				arg_498_1.callingController_:SetSelectedState("normal")

				local var_501_15 = arg_498_1:GetWordFromCfg(319501121)
				local var_501_16 = arg_498_1:FormatText(var_501_15.content)

				arg_498_1.text_.text = var_501_16

				LuaForUtil.ClearLinePrefixSymbol(arg_498_1.text_)

				local var_501_17 = 5
				local var_501_18 = utf8.len(var_501_16)
				local var_501_19 = var_501_17 <= 0 and var_501_13 or var_501_13 * (var_501_18 / var_501_17)

				if var_501_19 > 0 and var_501_13 < var_501_19 then
					arg_498_1.talkMaxDuration = var_501_19

					if var_501_19 + var_501_12 > arg_498_1.duration_ then
						arg_498_1.duration_ = var_501_19 + var_501_12
					end
				end

				arg_498_1.text_.text = var_501_16
				arg_498_1.typewritter.percent = 0

				arg_498_1.typewritter:SetDirty()
				arg_498_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_319501", "319501121", "story_v_out_319501.awb") ~= 0 then
					local var_501_20 = manager.audio:GetVoiceLength("story_v_out_319501", "319501121", "story_v_out_319501.awb") / 1000

					if var_501_20 + var_501_12 > arg_498_1.duration_ then
						arg_498_1.duration_ = var_501_20 + var_501_12
					end

					if var_501_15.prefab_name ~= "" and arg_498_1.actors_[var_501_15.prefab_name] ~= nil then
						local var_501_21 = LuaForUtil.PlayVoiceWithCriLipsync(arg_498_1.actors_[var_501_15.prefab_name].transform, "story_v_out_319501", "319501121", "story_v_out_319501.awb")

						arg_498_1:RecordAudio("319501121", var_501_21)
						arg_498_1:RecordAudio("319501121", var_501_21)
					else
						arg_498_1:AudioAction("play", "voice", "story_v_out_319501", "319501121", "story_v_out_319501.awb")
					end

					arg_498_1:RecordHistoryTalkVoice("story_v_out_319501", "319501121", "story_v_out_319501.awb")
				end

				arg_498_1:RecordContent(arg_498_1.text_.text)
			end

			local var_501_22 = math.max(var_501_13, arg_498_1.talkMaxDuration)

			if var_501_12 <= arg_498_1.time_ and arg_498_1.time_ < var_501_12 + var_501_22 then
				arg_498_1.typewritter.percent = (arg_498_1.time_ - var_501_12) / var_501_22

				arg_498_1.typewritter:SetDirty()
			end

			if arg_498_1.time_ >= var_501_12 + var_501_22 and arg_498_1.time_ < var_501_12 + var_501_22 + arg_501_0 then
				arg_498_1.typewritter.percent = 1

				arg_498_1.typewritter:SetDirty()
				arg_498_1:ShowNextGo(true)
			end
		end

		arg_498_1.nodeConfigList_ = {}

		arg_498_1:InitPlayNodeList()
	end,
	Play319501122 = function(arg_502_0, arg_502_1)
		arg_502_1.time_ = 0
		arg_502_1.frameCnt_ = 0
		arg_502_1.state_ = "playing"
		arg_502_1.curTalkId_ = 319501122
		arg_502_1.duration_ = 2.57

		local var_502_0 = {
			zh = 1.633,
			ja = 2.566
		}
		local var_502_1 = manager.audio:GetLocalizationFlag()

		if var_502_0[var_502_1] ~= nil then
			arg_502_1.duration_ = var_502_0[var_502_1]
		end

		SetActive(arg_502_1.tipsGo_, false)

		function arg_502_1.onSingleLineFinish_()
			arg_502_1.onSingleLineUpdate_ = nil
			arg_502_1.onSingleLineFinish_ = nil
			arg_502_1.state_ = "waiting"
		end

		function arg_502_1.playNext_(arg_504_0)
			if arg_504_0 == 1 then
				arg_502_0:Play319501123(arg_502_1)
			end
		end

		function arg_502_1.onSingleLineUpdate_(arg_505_0)
			local var_505_0 = arg_502_1.actors_["1084ui_story"]
			local var_505_1 = 0

			if var_505_1 < arg_502_1.time_ and arg_502_1.time_ <= var_505_1 + arg_505_0 and not isNil(var_505_0) and arg_502_1.var_.characterEffect1084ui_story == nil then
				arg_502_1.var_.characterEffect1084ui_story = var_505_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_505_2 = 0.200000002980232

			if var_505_1 <= arg_502_1.time_ and arg_502_1.time_ < var_505_1 + var_505_2 and not isNil(var_505_0) then
				local var_505_3 = (arg_502_1.time_ - var_505_1) / var_505_2

				if arg_502_1.var_.characterEffect1084ui_story and not isNil(var_505_0) then
					arg_502_1.var_.characterEffect1084ui_story.fillFlat = false
				end
			end

			if arg_502_1.time_ >= var_505_1 + var_505_2 and arg_502_1.time_ < var_505_1 + var_505_2 + arg_505_0 and not isNil(var_505_0) and arg_502_1.var_.characterEffect1084ui_story then
				arg_502_1.var_.characterEffect1084ui_story.fillFlat = false
			end

			local var_505_4 = arg_502_1.actors_["10068ui_story"]
			local var_505_5 = 0

			if var_505_5 < arg_502_1.time_ and arg_502_1.time_ <= var_505_5 + arg_505_0 and not isNil(var_505_4) and arg_502_1.var_.characterEffect10068ui_story == nil then
				arg_502_1.var_.characterEffect10068ui_story = var_505_4:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_505_6 = 0.200000002980232

			if var_505_5 <= arg_502_1.time_ and arg_502_1.time_ < var_505_5 + var_505_6 and not isNil(var_505_4) then
				local var_505_7 = (arg_502_1.time_ - var_505_5) / var_505_6

				if arg_502_1.var_.characterEffect10068ui_story and not isNil(var_505_4) then
					local var_505_8 = Mathf.Lerp(0, 0.5, var_505_7)

					arg_502_1.var_.characterEffect10068ui_story.fillFlat = true
					arg_502_1.var_.characterEffect10068ui_story.fillRatio = var_505_8
				end
			end

			if arg_502_1.time_ >= var_505_5 + var_505_6 and arg_502_1.time_ < var_505_5 + var_505_6 + arg_505_0 and not isNil(var_505_4) and arg_502_1.var_.characterEffect10068ui_story then
				local var_505_9 = 0.5

				arg_502_1.var_.characterEffect10068ui_story.fillFlat = true
				arg_502_1.var_.characterEffect10068ui_story.fillRatio = var_505_9
			end

			local var_505_10 = 0
			local var_505_11 = 0.15

			if var_505_10 < arg_502_1.time_ and arg_502_1.time_ <= var_505_10 + arg_505_0 then
				arg_502_1.talkMaxDuration = 0
				arg_502_1.dialogCg_.alpha = 1

				arg_502_1.dialog_:SetActive(true)
				SetActive(arg_502_1.leftNameGo_, true)

				local var_505_12 = arg_502_1:FormatText(StoryNameCfg[6].name)

				arg_502_1.leftNameTxt_.text = var_505_12

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_502_1.leftNameTxt_.transform)

				arg_502_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_502_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_502_1:RecordName(arg_502_1.leftNameTxt_.text)
				SetActive(arg_502_1.iconTrs_.gameObject, false)
				arg_502_1.callingController_:SetSelectedState("normal")

				local var_505_13 = arg_502_1:GetWordFromCfg(319501122)
				local var_505_14 = arg_502_1:FormatText(var_505_13.content)

				arg_502_1.text_.text = var_505_14

				LuaForUtil.ClearLinePrefixSymbol(arg_502_1.text_)

				local var_505_15 = 6
				local var_505_16 = utf8.len(var_505_14)
				local var_505_17 = var_505_15 <= 0 and var_505_11 or var_505_11 * (var_505_16 / var_505_15)

				if var_505_17 > 0 and var_505_11 < var_505_17 then
					arg_502_1.talkMaxDuration = var_505_17

					if var_505_17 + var_505_10 > arg_502_1.duration_ then
						arg_502_1.duration_ = var_505_17 + var_505_10
					end
				end

				arg_502_1.text_.text = var_505_14
				arg_502_1.typewritter.percent = 0

				arg_502_1.typewritter:SetDirty()
				arg_502_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_319501", "319501122", "story_v_out_319501.awb") ~= 0 then
					local var_505_18 = manager.audio:GetVoiceLength("story_v_out_319501", "319501122", "story_v_out_319501.awb") / 1000

					if var_505_18 + var_505_10 > arg_502_1.duration_ then
						arg_502_1.duration_ = var_505_18 + var_505_10
					end

					if var_505_13.prefab_name ~= "" and arg_502_1.actors_[var_505_13.prefab_name] ~= nil then
						local var_505_19 = LuaForUtil.PlayVoiceWithCriLipsync(arg_502_1.actors_[var_505_13.prefab_name].transform, "story_v_out_319501", "319501122", "story_v_out_319501.awb")

						arg_502_1:RecordAudio("319501122", var_505_19)
						arg_502_1:RecordAudio("319501122", var_505_19)
					else
						arg_502_1:AudioAction("play", "voice", "story_v_out_319501", "319501122", "story_v_out_319501.awb")
					end

					arg_502_1:RecordHistoryTalkVoice("story_v_out_319501", "319501122", "story_v_out_319501.awb")
				end

				arg_502_1:RecordContent(arg_502_1.text_.text)
			end

			local var_505_20 = math.max(var_505_11, arg_502_1.talkMaxDuration)

			if var_505_10 <= arg_502_1.time_ and arg_502_1.time_ < var_505_10 + var_505_20 then
				arg_502_1.typewritter.percent = (arg_502_1.time_ - var_505_10) / var_505_20

				arg_502_1.typewritter:SetDirty()
			end

			if arg_502_1.time_ >= var_505_10 + var_505_20 and arg_502_1.time_ < var_505_10 + var_505_20 + arg_505_0 then
				arg_502_1.typewritter.percent = 1

				arg_502_1.typewritter:SetDirty()
				arg_502_1:ShowNextGo(true)
			end
		end

		arg_502_1.nodeConfigList_ = {}

		arg_502_1:InitPlayNodeList()
	end,
	Play319501123 = function(arg_506_0, arg_506_1)
		arg_506_1.time_ = 0
		arg_506_1.frameCnt_ = 0
		arg_506_1.state_ = "playing"
		arg_506_1.curTalkId_ = 319501123
		arg_506_1.duration_ = 3.83

		local var_506_0 = {
			zh = 3.466,
			ja = 3.833
		}
		local var_506_1 = manager.audio:GetLocalizationFlag()

		if var_506_0[var_506_1] ~= nil then
			arg_506_1.duration_ = var_506_0[var_506_1]
		end

		SetActive(arg_506_1.tipsGo_, false)

		function arg_506_1.onSingleLineFinish_()
			arg_506_1.onSingleLineUpdate_ = nil
			arg_506_1.onSingleLineFinish_ = nil
			arg_506_1.state_ = "waiting"
		end

		function arg_506_1.playNext_(arg_508_0)
			if arg_508_0 == 1 then
				arg_506_0:Play319501124(arg_506_1)
			end
		end

		function arg_506_1.onSingleLineUpdate_(arg_509_0)
			local var_509_0 = arg_506_1.actors_["1084ui_story"]
			local var_509_1 = 0

			if var_509_1 < arg_506_1.time_ and arg_506_1.time_ <= var_509_1 + arg_509_0 and not isNil(var_509_0) and arg_506_1.var_.characterEffect1084ui_story == nil then
				arg_506_1.var_.characterEffect1084ui_story = var_509_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_509_2 = 0.200000002980232

			if var_509_1 <= arg_506_1.time_ and arg_506_1.time_ < var_509_1 + var_509_2 and not isNil(var_509_0) then
				local var_509_3 = (arg_506_1.time_ - var_509_1) / var_509_2

				if arg_506_1.var_.characterEffect1084ui_story and not isNil(var_509_0) then
					local var_509_4 = Mathf.Lerp(0, 0.5, var_509_3)

					arg_506_1.var_.characterEffect1084ui_story.fillFlat = true
					arg_506_1.var_.characterEffect1084ui_story.fillRatio = var_509_4
				end
			end

			if arg_506_1.time_ >= var_509_1 + var_509_2 and arg_506_1.time_ < var_509_1 + var_509_2 + arg_509_0 and not isNil(var_509_0) and arg_506_1.var_.characterEffect1084ui_story then
				local var_509_5 = 0.5

				arg_506_1.var_.characterEffect1084ui_story.fillFlat = true
				arg_506_1.var_.characterEffect1084ui_story.fillRatio = var_509_5
			end

			local var_509_6 = arg_506_1.actors_["10068ui_story"]
			local var_509_7 = 0

			if var_509_7 < arg_506_1.time_ and arg_506_1.time_ <= var_509_7 + arg_509_0 and not isNil(var_509_6) and arg_506_1.var_.characterEffect10068ui_story == nil then
				arg_506_1.var_.characterEffect10068ui_story = var_509_6:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_509_8 = 0.200000002980232

			if var_509_7 <= arg_506_1.time_ and arg_506_1.time_ < var_509_7 + var_509_8 and not isNil(var_509_6) then
				local var_509_9 = (arg_506_1.time_ - var_509_7) / var_509_8

				if arg_506_1.var_.characterEffect10068ui_story and not isNil(var_509_6) then
					arg_506_1.var_.characterEffect10068ui_story.fillFlat = false
				end
			end

			if arg_506_1.time_ >= var_509_7 + var_509_8 and arg_506_1.time_ < var_509_7 + var_509_8 + arg_509_0 and not isNil(var_509_6) and arg_506_1.var_.characterEffect10068ui_story then
				arg_506_1.var_.characterEffect10068ui_story.fillFlat = false
			end

			local var_509_10 = 0
			local var_509_11 = 0.225

			if var_509_10 < arg_506_1.time_ and arg_506_1.time_ <= var_509_10 + arg_509_0 then
				arg_506_1.talkMaxDuration = 0
				arg_506_1.dialogCg_.alpha = 1

				arg_506_1.dialog_:SetActive(true)
				SetActive(arg_506_1.leftNameGo_, true)

				local var_509_12 = arg_506_1:FormatText(StoryNameCfg[697].name)

				arg_506_1.leftNameTxt_.text = var_509_12

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_506_1.leftNameTxt_.transform)

				arg_506_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_506_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_506_1:RecordName(arg_506_1.leftNameTxt_.text)
				SetActive(arg_506_1.iconTrs_.gameObject, false)
				arg_506_1.callingController_:SetSelectedState("normal")

				local var_509_13 = arg_506_1:GetWordFromCfg(319501123)
				local var_509_14 = arg_506_1:FormatText(var_509_13.content)

				arg_506_1.text_.text = var_509_14

				LuaForUtil.ClearLinePrefixSymbol(arg_506_1.text_)

				local var_509_15 = 9
				local var_509_16 = utf8.len(var_509_14)
				local var_509_17 = var_509_15 <= 0 and var_509_11 or var_509_11 * (var_509_16 / var_509_15)

				if var_509_17 > 0 and var_509_11 < var_509_17 then
					arg_506_1.talkMaxDuration = var_509_17

					if var_509_17 + var_509_10 > arg_506_1.duration_ then
						arg_506_1.duration_ = var_509_17 + var_509_10
					end
				end

				arg_506_1.text_.text = var_509_14
				arg_506_1.typewritter.percent = 0

				arg_506_1.typewritter:SetDirty()
				arg_506_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_319501", "319501123", "story_v_out_319501.awb") ~= 0 then
					local var_509_18 = manager.audio:GetVoiceLength("story_v_out_319501", "319501123", "story_v_out_319501.awb") / 1000

					if var_509_18 + var_509_10 > arg_506_1.duration_ then
						arg_506_1.duration_ = var_509_18 + var_509_10
					end

					if var_509_13.prefab_name ~= "" and arg_506_1.actors_[var_509_13.prefab_name] ~= nil then
						local var_509_19 = LuaForUtil.PlayVoiceWithCriLipsync(arg_506_1.actors_[var_509_13.prefab_name].transform, "story_v_out_319501", "319501123", "story_v_out_319501.awb")

						arg_506_1:RecordAudio("319501123", var_509_19)
						arg_506_1:RecordAudio("319501123", var_509_19)
					else
						arg_506_1:AudioAction("play", "voice", "story_v_out_319501", "319501123", "story_v_out_319501.awb")
					end

					arg_506_1:RecordHistoryTalkVoice("story_v_out_319501", "319501123", "story_v_out_319501.awb")
				end

				arg_506_1:RecordContent(arg_506_1.text_.text)
			end

			local var_509_20 = math.max(var_509_11, arg_506_1.talkMaxDuration)

			if var_509_10 <= arg_506_1.time_ and arg_506_1.time_ < var_509_10 + var_509_20 then
				arg_506_1.typewritter.percent = (arg_506_1.time_ - var_509_10) / var_509_20

				arg_506_1.typewritter:SetDirty()
			end

			if arg_506_1.time_ >= var_509_10 + var_509_20 and arg_506_1.time_ < var_509_10 + var_509_20 + arg_509_0 then
				arg_506_1.typewritter.percent = 1

				arg_506_1.typewritter:SetDirty()
				arg_506_1:ShowNextGo(true)
			end
		end

		arg_506_1.nodeConfigList_ = {}

		arg_506_1:InitPlayNodeList()
	end,
	Play319501124 = function(arg_510_0, arg_510_1)
		arg_510_1.time_ = 0
		arg_510_1.frameCnt_ = 0
		arg_510_1.state_ = "playing"
		arg_510_1.curTalkId_ = 319501124
		arg_510_1.duration_ = 5

		SetActive(arg_510_1.tipsGo_, false)

		function arg_510_1.onSingleLineFinish_()
			arg_510_1.onSingleLineUpdate_ = nil
			arg_510_1.onSingleLineFinish_ = nil
			arg_510_1.state_ = "waiting"
		end

		function arg_510_1.playNext_(arg_512_0)
			if arg_512_0 == 1 then
				arg_510_0:Play319501125(arg_510_1)
			end
		end

		function arg_510_1.onSingleLineUpdate_(arg_513_0)
			local var_513_0 = arg_510_1.actors_["10068ui_story"]
			local var_513_1 = 0

			if var_513_1 < arg_510_1.time_ and arg_510_1.time_ <= var_513_1 + arg_513_0 and not isNil(var_513_0) and arg_510_1.var_.characterEffect10068ui_story == nil then
				arg_510_1.var_.characterEffect10068ui_story = var_513_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_513_2 = 0.200000002980232

			if var_513_1 <= arg_510_1.time_ and arg_510_1.time_ < var_513_1 + var_513_2 and not isNil(var_513_0) then
				local var_513_3 = (arg_510_1.time_ - var_513_1) / var_513_2

				if arg_510_1.var_.characterEffect10068ui_story and not isNil(var_513_0) then
					local var_513_4 = Mathf.Lerp(0, 0.5, var_513_3)

					arg_510_1.var_.characterEffect10068ui_story.fillFlat = true
					arg_510_1.var_.characterEffect10068ui_story.fillRatio = var_513_4
				end
			end

			if arg_510_1.time_ >= var_513_1 + var_513_2 and arg_510_1.time_ < var_513_1 + var_513_2 + arg_513_0 and not isNil(var_513_0) and arg_510_1.var_.characterEffect10068ui_story then
				local var_513_5 = 0.5

				arg_510_1.var_.characterEffect10068ui_story.fillFlat = true
				arg_510_1.var_.characterEffect10068ui_story.fillRatio = var_513_5
			end

			local var_513_6 = 0

			if var_513_6 < arg_510_1.time_ and arg_510_1.time_ <= var_513_6 + arg_513_0 then
				arg_510_1:PlayTimeline("10068ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface2101cva")
			end

			local var_513_7 = 0
			local var_513_8 = 1.15

			if var_513_7 < arg_510_1.time_ and arg_510_1.time_ <= var_513_7 + arg_513_0 then
				arg_510_1.talkMaxDuration = 0
				arg_510_1.dialogCg_.alpha = 1

				arg_510_1.dialog_:SetActive(true)
				SetActive(arg_510_1.leftNameGo_, false)

				arg_510_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_510_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_510_1:RecordName(arg_510_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_510_1.iconTrs_.gameObject, false)
				arg_510_1.callingController_:SetSelectedState("normal")

				local var_513_9 = arg_510_1:GetWordFromCfg(319501124)
				local var_513_10 = arg_510_1:FormatText(var_513_9.content)

				arg_510_1.text_.text = var_513_10

				LuaForUtil.ClearLinePrefixSymbol(arg_510_1.text_)

				local var_513_11 = 46
				local var_513_12 = utf8.len(var_513_10)
				local var_513_13 = var_513_11 <= 0 and var_513_8 or var_513_8 * (var_513_12 / var_513_11)

				if var_513_13 > 0 and var_513_8 < var_513_13 then
					arg_510_1.talkMaxDuration = var_513_13

					if var_513_13 + var_513_7 > arg_510_1.duration_ then
						arg_510_1.duration_ = var_513_13 + var_513_7
					end
				end

				arg_510_1.text_.text = var_513_10
				arg_510_1.typewritter.percent = 0

				arg_510_1.typewritter:SetDirty()
				arg_510_1:ShowNextGo(false)
				arg_510_1:RecordContent(arg_510_1.text_.text)
			end

			local var_513_14 = math.max(var_513_8, arg_510_1.talkMaxDuration)

			if var_513_7 <= arg_510_1.time_ and arg_510_1.time_ < var_513_7 + var_513_14 then
				arg_510_1.typewritter.percent = (arg_510_1.time_ - var_513_7) / var_513_14

				arg_510_1.typewritter:SetDirty()
			end

			if arg_510_1.time_ >= var_513_7 + var_513_14 and arg_510_1.time_ < var_513_7 + var_513_14 + arg_513_0 then
				arg_510_1.typewritter.percent = 1

				arg_510_1.typewritter:SetDirty()
				arg_510_1:ShowNextGo(true)
			end
		end

		arg_510_1.nodeConfigList_ = {}

		arg_510_1:InitPlayNodeList()
	end,
	Play319501125 = function(arg_514_0, arg_514_1)
		arg_514_1.time_ = 0
		arg_514_1.frameCnt_ = 0
		arg_514_1.state_ = "playing"
		arg_514_1.curTalkId_ = 319501125
		arg_514_1.duration_ = 5.9

		local var_514_0 = {
			zh = 2.766,
			ja = 5.9
		}
		local var_514_1 = manager.audio:GetLocalizationFlag()

		if var_514_0[var_514_1] ~= nil then
			arg_514_1.duration_ = var_514_0[var_514_1]
		end

		SetActive(arg_514_1.tipsGo_, false)

		function arg_514_1.onSingleLineFinish_()
			arg_514_1.onSingleLineUpdate_ = nil
			arg_514_1.onSingleLineFinish_ = nil
			arg_514_1.state_ = "waiting"
		end

		function arg_514_1.playNext_(arg_516_0)
			if arg_516_0 == 1 then
				arg_514_0:Play319501126(arg_514_1)
			end
		end

		function arg_514_1.onSingleLineUpdate_(arg_517_0)
			local var_517_0 = arg_514_1.actors_["1084ui_story"]
			local var_517_1 = 0

			if var_517_1 < arg_514_1.time_ and arg_514_1.time_ <= var_517_1 + arg_517_0 and not isNil(var_517_0) and arg_514_1.var_.characterEffect1084ui_story == nil then
				arg_514_1.var_.characterEffect1084ui_story = var_517_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_517_2 = 0.200000002980232

			if var_517_1 <= arg_514_1.time_ and arg_514_1.time_ < var_517_1 + var_517_2 and not isNil(var_517_0) then
				local var_517_3 = (arg_514_1.time_ - var_517_1) / var_517_2

				if arg_514_1.var_.characterEffect1084ui_story and not isNil(var_517_0) then
					arg_514_1.var_.characterEffect1084ui_story.fillFlat = false
				end
			end

			if arg_514_1.time_ >= var_517_1 + var_517_2 and arg_514_1.time_ < var_517_1 + var_517_2 + arg_517_0 and not isNil(var_517_0) and arg_514_1.var_.characterEffect1084ui_story then
				arg_514_1.var_.characterEffect1084ui_story.fillFlat = false
			end

			local var_517_4 = 0
			local var_517_5 = 0.3

			if var_517_4 < arg_514_1.time_ and arg_514_1.time_ <= var_517_4 + arg_517_0 then
				arg_514_1.talkMaxDuration = 0
				arg_514_1.dialogCg_.alpha = 1

				arg_514_1.dialog_:SetActive(true)
				SetActive(arg_514_1.leftNameGo_, true)

				local var_517_6 = arg_514_1:FormatText(StoryNameCfg[6].name)

				arg_514_1.leftNameTxt_.text = var_517_6

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_514_1.leftNameTxt_.transform)

				arg_514_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_514_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_514_1:RecordName(arg_514_1.leftNameTxt_.text)
				SetActive(arg_514_1.iconTrs_.gameObject, false)
				arg_514_1.callingController_:SetSelectedState("normal")

				local var_517_7 = arg_514_1:GetWordFromCfg(319501125)
				local var_517_8 = arg_514_1:FormatText(var_517_7.content)

				arg_514_1.text_.text = var_517_8

				LuaForUtil.ClearLinePrefixSymbol(arg_514_1.text_)

				local var_517_9 = 12
				local var_517_10 = utf8.len(var_517_8)
				local var_517_11 = var_517_9 <= 0 and var_517_5 or var_517_5 * (var_517_10 / var_517_9)

				if var_517_11 > 0 and var_517_5 < var_517_11 then
					arg_514_1.talkMaxDuration = var_517_11

					if var_517_11 + var_517_4 > arg_514_1.duration_ then
						arg_514_1.duration_ = var_517_11 + var_517_4
					end
				end

				arg_514_1.text_.text = var_517_8
				arg_514_1.typewritter.percent = 0

				arg_514_1.typewritter:SetDirty()
				arg_514_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_319501", "319501125", "story_v_out_319501.awb") ~= 0 then
					local var_517_12 = manager.audio:GetVoiceLength("story_v_out_319501", "319501125", "story_v_out_319501.awb") / 1000

					if var_517_12 + var_517_4 > arg_514_1.duration_ then
						arg_514_1.duration_ = var_517_12 + var_517_4
					end

					if var_517_7.prefab_name ~= "" and arg_514_1.actors_[var_517_7.prefab_name] ~= nil then
						local var_517_13 = LuaForUtil.PlayVoiceWithCriLipsync(arg_514_1.actors_[var_517_7.prefab_name].transform, "story_v_out_319501", "319501125", "story_v_out_319501.awb")

						arg_514_1:RecordAudio("319501125", var_517_13)
						arg_514_1:RecordAudio("319501125", var_517_13)
					else
						arg_514_1:AudioAction("play", "voice", "story_v_out_319501", "319501125", "story_v_out_319501.awb")
					end

					arg_514_1:RecordHistoryTalkVoice("story_v_out_319501", "319501125", "story_v_out_319501.awb")
				end

				arg_514_1:RecordContent(arg_514_1.text_.text)
			end

			local var_517_14 = math.max(var_517_5, arg_514_1.talkMaxDuration)

			if var_517_4 <= arg_514_1.time_ and arg_514_1.time_ < var_517_4 + var_517_14 then
				arg_514_1.typewritter.percent = (arg_514_1.time_ - var_517_4) / var_517_14

				arg_514_1.typewritter:SetDirty()
			end

			if arg_514_1.time_ >= var_517_4 + var_517_14 and arg_514_1.time_ < var_517_4 + var_517_14 + arg_517_0 then
				arg_514_1.typewritter.percent = 1

				arg_514_1.typewritter:SetDirty()
				arg_514_1:ShowNextGo(true)
			end
		end

		arg_514_1.nodeConfigList_ = {}

		arg_514_1:InitPlayNodeList()
	end,
	Play319501126 = function(arg_518_0, arg_518_1)
		arg_518_1.time_ = 0
		arg_518_1.frameCnt_ = 0
		arg_518_1.state_ = "playing"
		arg_518_1.curTalkId_ = 319501126
		arg_518_1.duration_ = 5.9

		local var_518_0 = {
			zh = 2.6,
			ja = 5.9
		}
		local var_518_1 = manager.audio:GetLocalizationFlag()

		if var_518_0[var_518_1] ~= nil then
			arg_518_1.duration_ = var_518_0[var_518_1]
		end

		SetActive(arg_518_1.tipsGo_, false)

		function arg_518_1.onSingleLineFinish_()
			arg_518_1.onSingleLineUpdate_ = nil
			arg_518_1.onSingleLineFinish_ = nil
			arg_518_1.state_ = "waiting"
		end

		function arg_518_1.playNext_(arg_520_0)
			if arg_520_0 == 1 then
				arg_518_0:Play319501127(arg_518_1)
			end
		end

		function arg_518_1.onSingleLineUpdate_(arg_521_0)
			local var_521_0 = arg_518_1.actors_["10068ui_story"]
			local var_521_1 = 0

			if var_521_1 < arg_518_1.time_ and arg_518_1.time_ <= var_521_1 + arg_521_0 and not isNil(var_521_0) and arg_518_1.var_.characterEffect10068ui_story == nil then
				arg_518_1.var_.characterEffect10068ui_story = var_521_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_521_2 = 0.200000002980232

			if var_521_1 <= arg_518_1.time_ and arg_518_1.time_ < var_521_1 + var_521_2 and not isNil(var_521_0) then
				local var_521_3 = (arg_518_1.time_ - var_521_1) / var_521_2

				if arg_518_1.var_.characterEffect10068ui_story and not isNil(var_521_0) then
					arg_518_1.var_.characterEffect10068ui_story.fillFlat = false
				end
			end

			if arg_518_1.time_ >= var_521_1 + var_521_2 and arg_518_1.time_ < var_521_1 + var_521_2 + arg_521_0 and not isNil(var_521_0) and arg_518_1.var_.characterEffect10068ui_story then
				arg_518_1.var_.characterEffect10068ui_story.fillFlat = false
			end

			local var_521_4 = 0

			if var_521_4 < arg_518_1.time_ and arg_518_1.time_ <= var_521_4 + arg_521_0 then
				arg_518_1:PlayTimeline("10068ui_story", "StoryTimeline/CharAction/story10068/story10068action/10068action2_1")
			end

			local var_521_5 = 0

			if var_521_5 < arg_518_1.time_ and arg_518_1.time_ <= var_521_5 + arg_521_0 then
				arg_518_1:PlayTimeline("10068ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface2101cva")
			end

			local var_521_6 = arg_518_1.actors_["1084ui_story"]
			local var_521_7 = 0

			if var_521_7 < arg_518_1.time_ and arg_518_1.time_ <= var_521_7 + arg_521_0 and not isNil(var_521_6) and arg_518_1.var_.characterEffect1084ui_story == nil then
				arg_518_1.var_.characterEffect1084ui_story = var_521_6:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_521_8 = 0.200000002980232

			if var_521_7 <= arg_518_1.time_ and arg_518_1.time_ < var_521_7 + var_521_8 and not isNil(var_521_6) then
				local var_521_9 = (arg_518_1.time_ - var_521_7) / var_521_8

				if arg_518_1.var_.characterEffect1084ui_story and not isNil(var_521_6) then
					local var_521_10 = Mathf.Lerp(0, 0.5, var_521_9)

					arg_518_1.var_.characterEffect1084ui_story.fillFlat = true
					arg_518_1.var_.characterEffect1084ui_story.fillRatio = var_521_10
				end
			end

			if arg_518_1.time_ >= var_521_7 + var_521_8 and arg_518_1.time_ < var_521_7 + var_521_8 + arg_521_0 and not isNil(var_521_6) and arg_518_1.var_.characterEffect1084ui_story then
				local var_521_11 = 0.5

				arg_518_1.var_.characterEffect1084ui_story.fillFlat = true
				arg_518_1.var_.characterEffect1084ui_story.fillRatio = var_521_11
			end

			local var_521_12 = 0
			local var_521_13 = 0.225

			if var_521_12 < arg_518_1.time_ and arg_518_1.time_ <= var_521_12 + arg_521_0 then
				arg_518_1.talkMaxDuration = 0
				arg_518_1.dialogCg_.alpha = 1

				arg_518_1.dialog_:SetActive(true)
				SetActive(arg_518_1.leftNameGo_, true)

				local var_521_14 = arg_518_1:FormatText(StoryNameCfg[697].name)

				arg_518_1.leftNameTxt_.text = var_521_14

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_518_1.leftNameTxt_.transform)

				arg_518_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_518_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_518_1:RecordName(arg_518_1.leftNameTxt_.text)
				SetActive(arg_518_1.iconTrs_.gameObject, false)
				arg_518_1.callingController_:SetSelectedState("normal")

				local var_521_15 = arg_518_1:GetWordFromCfg(319501126)
				local var_521_16 = arg_518_1:FormatText(var_521_15.content)

				arg_518_1.text_.text = var_521_16

				LuaForUtil.ClearLinePrefixSymbol(arg_518_1.text_)

				local var_521_17 = 9
				local var_521_18 = utf8.len(var_521_16)
				local var_521_19 = var_521_17 <= 0 and var_521_13 or var_521_13 * (var_521_18 / var_521_17)

				if var_521_19 > 0 and var_521_13 < var_521_19 then
					arg_518_1.talkMaxDuration = var_521_19

					if var_521_19 + var_521_12 > arg_518_1.duration_ then
						arg_518_1.duration_ = var_521_19 + var_521_12
					end
				end

				arg_518_1.text_.text = var_521_16
				arg_518_1.typewritter.percent = 0

				arg_518_1.typewritter:SetDirty()
				arg_518_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_319501", "319501126", "story_v_out_319501.awb") ~= 0 then
					local var_521_20 = manager.audio:GetVoiceLength("story_v_out_319501", "319501126", "story_v_out_319501.awb") / 1000

					if var_521_20 + var_521_12 > arg_518_1.duration_ then
						arg_518_1.duration_ = var_521_20 + var_521_12
					end

					if var_521_15.prefab_name ~= "" and arg_518_1.actors_[var_521_15.prefab_name] ~= nil then
						local var_521_21 = LuaForUtil.PlayVoiceWithCriLipsync(arg_518_1.actors_[var_521_15.prefab_name].transform, "story_v_out_319501", "319501126", "story_v_out_319501.awb")

						arg_518_1:RecordAudio("319501126", var_521_21)
						arg_518_1:RecordAudio("319501126", var_521_21)
					else
						arg_518_1:AudioAction("play", "voice", "story_v_out_319501", "319501126", "story_v_out_319501.awb")
					end

					arg_518_1:RecordHistoryTalkVoice("story_v_out_319501", "319501126", "story_v_out_319501.awb")
				end

				arg_518_1:RecordContent(arg_518_1.text_.text)
			end

			local var_521_22 = math.max(var_521_13, arg_518_1.talkMaxDuration)

			if var_521_12 <= arg_518_1.time_ and arg_518_1.time_ < var_521_12 + var_521_22 then
				arg_518_1.typewritter.percent = (arg_518_1.time_ - var_521_12) / var_521_22

				arg_518_1.typewritter:SetDirty()
			end

			if arg_518_1.time_ >= var_521_12 + var_521_22 and arg_518_1.time_ < var_521_12 + var_521_22 + arg_521_0 then
				arg_518_1.typewritter.percent = 1

				arg_518_1.typewritter:SetDirty()
				arg_518_1:ShowNextGo(true)
			end
		end

		arg_518_1.nodeConfigList_ = {}

		arg_518_1:InitPlayNodeList()
	end,
	Play319501127 = function(arg_522_0, arg_522_1)
		arg_522_1.time_ = 0
		arg_522_1.frameCnt_ = 0
		arg_522_1.state_ = "playing"
		arg_522_1.curTalkId_ = 319501127
		arg_522_1.duration_ = 13.2

		local var_522_0 = {
			zh = 5.1,
			ja = 13.2
		}
		local var_522_1 = manager.audio:GetLocalizationFlag()

		if var_522_0[var_522_1] ~= nil then
			arg_522_1.duration_ = var_522_0[var_522_1]
		end

		SetActive(arg_522_1.tipsGo_, false)

		function arg_522_1.onSingleLineFinish_()
			arg_522_1.onSingleLineUpdate_ = nil
			arg_522_1.onSingleLineFinish_ = nil
			arg_522_1.state_ = "waiting"
		end

		function arg_522_1.playNext_(arg_524_0)
			if arg_524_0 == 1 then
				arg_522_0:Play319501128(arg_522_1)
			end
		end

		function arg_522_1.onSingleLineUpdate_(arg_525_0)
			local var_525_0 = arg_522_1.actors_["1084ui_story"]
			local var_525_1 = 0

			if var_525_1 < arg_522_1.time_ and arg_522_1.time_ <= var_525_1 + arg_525_0 and not isNil(var_525_0) and arg_522_1.var_.characterEffect1084ui_story == nil then
				arg_522_1.var_.characterEffect1084ui_story = var_525_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_525_2 = 0.200000002980232

			if var_525_1 <= arg_522_1.time_ and arg_522_1.time_ < var_525_1 + var_525_2 and not isNil(var_525_0) then
				local var_525_3 = (arg_522_1.time_ - var_525_1) / var_525_2

				if arg_522_1.var_.characterEffect1084ui_story and not isNil(var_525_0) then
					arg_522_1.var_.characterEffect1084ui_story.fillFlat = false
				end
			end

			if arg_522_1.time_ >= var_525_1 + var_525_2 and arg_522_1.time_ < var_525_1 + var_525_2 + arg_525_0 and not isNil(var_525_0) and arg_522_1.var_.characterEffect1084ui_story then
				arg_522_1.var_.characterEffect1084ui_story.fillFlat = false
			end

			local var_525_4 = 0

			if var_525_4 < arg_522_1.time_ and arg_522_1.time_ <= var_525_4 + arg_525_0 then
				arg_522_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/story1084/story1084action/1084action1_1")
			end

			local var_525_5 = 0

			if var_525_5 < arg_522_1.time_ and arg_522_1.time_ <= var_525_5 + arg_525_0 then
				arg_522_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_525_6 = arg_522_1.actors_["10068ui_story"]
			local var_525_7 = 0

			if var_525_7 < arg_522_1.time_ and arg_522_1.time_ <= var_525_7 + arg_525_0 and not isNil(var_525_6) and arg_522_1.var_.characterEffect10068ui_story == nil then
				arg_522_1.var_.characterEffect10068ui_story = var_525_6:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_525_8 = 0.200000002980232

			if var_525_7 <= arg_522_1.time_ and arg_522_1.time_ < var_525_7 + var_525_8 and not isNil(var_525_6) then
				local var_525_9 = (arg_522_1.time_ - var_525_7) / var_525_8

				if arg_522_1.var_.characterEffect10068ui_story and not isNil(var_525_6) then
					local var_525_10 = Mathf.Lerp(0, 0.5, var_525_9)

					arg_522_1.var_.characterEffect10068ui_story.fillFlat = true
					arg_522_1.var_.characterEffect10068ui_story.fillRatio = var_525_10
				end
			end

			if arg_522_1.time_ >= var_525_7 + var_525_8 and arg_522_1.time_ < var_525_7 + var_525_8 + arg_525_0 and not isNil(var_525_6) and arg_522_1.var_.characterEffect10068ui_story then
				local var_525_11 = 0.5

				arg_522_1.var_.characterEffect10068ui_story.fillFlat = true
				arg_522_1.var_.characterEffect10068ui_story.fillRatio = var_525_11
			end

			local var_525_12 = 0
			local var_525_13 = 0.65

			if var_525_12 < arg_522_1.time_ and arg_522_1.time_ <= var_525_12 + arg_525_0 then
				arg_522_1.talkMaxDuration = 0
				arg_522_1.dialogCg_.alpha = 1

				arg_522_1.dialog_:SetActive(true)
				SetActive(arg_522_1.leftNameGo_, true)

				local var_525_14 = arg_522_1:FormatText(StoryNameCfg[6].name)

				arg_522_1.leftNameTxt_.text = var_525_14

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_522_1.leftNameTxt_.transform)

				arg_522_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_522_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_522_1:RecordName(arg_522_1.leftNameTxt_.text)
				SetActive(arg_522_1.iconTrs_.gameObject, false)
				arg_522_1.callingController_:SetSelectedState("normal")

				local var_525_15 = arg_522_1:GetWordFromCfg(319501127)
				local var_525_16 = arg_522_1:FormatText(var_525_15.content)

				arg_522_1.text_.text = var_525_16

				LuaForUtil.ClearLinePrefixSymbol(arg_522_1.text_)

				local var_525_17 = 26
				local var_525_18 = utf8.len(var_525_16)
				local var_525_19 = var_525_17 <= 0 and var_525_13 or var_525_13 * (var_525_18 / var_525_17)

				if var_525_19 > 0 and var_525_13 < var_525_19 then
					arg_522_1.talkMaxDuration = var_525_19

					if var_525_19 + var_525_12 > arg_522_1.duration_ then
						arg_522_1.duration_ = var_525_19 + var_525_12
					end
				end

				arg_522_1.text_.text = var_525_16
				arg_522_1.typewritter.percent = 0

				arg_522_1.typewritter:SetDirty()
				arg_522_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_319501", "319501127", "story_v_out_319501.awb") ~= 0 then
					local var_525_20 = manager.audio:GetVoiceLength("story_v_out_319501", "319501127", "story_v_out_319501.awb") / 1000

					if var_525_20 + var_525_12 > arg_522_1.duration_ then
						arg_522_1.duration_ = var_525_20 + var_525_12
					end

					if var_525_15.prefab_name ~= "" and arg_522_1.actors_[var_525_15.prefab_name] ~= nil then
						local var_525_21 = LuaForUtil.PlayVoiceWithCriLipsync(arg_522_1.actors_[var_525_15.prefab_name].transform, "story_v_out_319501", "319501127", "story_v_out_319501.awb")

						arg_522_1:RecordAudio("319501127", var_525_21)
						arg_522_1:RecordAudio("319501127", var_525_21)
					else
						arg_522_1:AudioAction("play", "voice", "story_v_out_319501", "319501127", "story_v_out_319501.awb")
					end

					arg_522_1:RecordHistoryTalkVoice("story_v_out_319501", "319501127", "story_v_out_319501.awb")
				end

				arg_522_1:RecordContent(arg_522_1.text_.text)
			end

			local var_525_22 = math.max(var_525_13, arg_522_1.talkMaxDuration)

			if var_525_12 <= arg_522_1.time_ and arg_522_1.time_ < var_525_12 + var_525_22 then
				arg_522_1.typewritter.percent = (arg_522_1.time_ - var_525_12) / var_525_22

				arg_522_1.typewritter:SetDirty()
			end

			if arg_522_1.time_ >= var_525_12 + var_525_22 and arg_522_1.time_ < var_525_12 + var_525_22 + arg_525_0 then
				arg_522_1.typewritter.percent = 1

				arg_522_1.typewritter:SetDirty()
				arg_522_1:ShowNextGo(true)
			end
		end

		arg_522_1.nodeConfigList_ = {}

		arg_522_1:InitPlayNodeList()
	end,
	Play319501128 = function(arg_526_0, arg_526_1)
		arg_526_1.time_ = 0
		arg_526_1.frameCnt_ = 0
		arg_526_1.state_ = "playing"
		arg_526_1.curTalkId_ = 319501128
		arg_526_1.duration_ = 5.73

		local var_526_0 = {
			zh = 3,
			ja = 5.733
		}
		local var_526_1 = manager.audio:GetLocalizationFlag()

		if var_526_0[var_526_1] ~= nil then
			arg_526_1.duration_ = var_526_0[var_526_1]
		end

		SetActive(arg_526_1.tipsGo_, false)

		function arg_526_1.onSingleLineFinish_()
			arg_526_1.onSingleLineUpdate_ = nil
			arg_526_1.onSingleLineFinish_ = nil
			arg_526_1.state_ = "waiting"
		end

		function arg_526_1.playNext_(arg_528_0)
			if arg_528_0 == 1 then
				arg_526_0:Play319501129(arg_526_1)
			end
		end

		function arg_526_1.onSingleLineUpdate_(arg_529_0)
			local var_529_0 = 0

			if var_529_0 < arg_526_1.time_ and arg_526_1.time_ <= var_529_0 + arg_529_0 then
				arg_526_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/story1084/story1084action/1084action8_1")
			end

			local var_529_1 = 0

			if var_529_1 < arg_526_1.time_ and arg_526_1.time_ <= var_529_1 + arg_529_0 then
				arg_526_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1101cva")
			end

			local var_529_2 = 0
			local var_529_3 = 0.35

			if var_529_2 < arg_526_1.time_ and arg_526_1.time_ <= var_529_2 + arg_529_0 then
				arg_526_1.talkMaxDuration = 0
				arg_526_1.dialogCg_.alpha = 1

				arg_526_1.dialog_:SetActive(true)
				SetActive(arg_526_1.leftNameGo_, true)

				local var_529_4 = arg_526_1:FormatText(StoryNameCfg[6].name)

				arg_526_1.leftNameTxt_.text = var_529_4

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_526_1.leftNameTxt_.transform)

				arg_526_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_526_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_526_1:RecordName(arg_526_1.leftNameTxt_.text)
				SetActive(arg_526_1.iconTrs_.gameObject, false)
				arg_526_1.callingController_:SetSelectedState("normal")

				local var_529_5 = arg_526_1:GetWordFromCfg(319501128)
				local var_529_6 = arg_526_1:FormatText(var_529_5.content)

				arg_526_1.text_.text = var_529_6

				LuaForUtil.ClearLinePrefixSymbol(arg_526_1.text_)

				local var_529_7 = 14
				local var_529_8 = utf8.len(var_529_6)
				local var_529_9 = var_529_7 <= 0 and var_529_3 or var_529_3 * (var_529_8 / var_529_7)

				if var_529_9 > 0 and var_529_3 < var_529_9 then
					arg_526_1.talkMaxDuration = var_529_9

					if var_529_9 + var_529_2 > arg_526_1.duration_ then
						arg_526_1.duration_ = var_529_9 + var_529_2
					end
				end

				arg_526_1.text_.text = var_529_6
				arg_526_1.typewritter.percent = 0

				arg_526_1.typewritter:SetDirty()
				arg_526_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_319501", "319501128", "story_v_out_319501.awb") ~= 0 then
					local var_529_10 = manager.audio:GetVoiceLength("story_v_out_319501", "319501128", "story_v_out_319501.awb") / 1000

					if var_529_10 + var_529_2 > arg_526_1.duration_ then
						arg_526_1.duration_ = var_529_10 + var_529_2
					end

					if var_529_5.prefab_name ~= "" and arg_526_1.actors_[var_529_5.prefab_name] ~= nil then
						local var_529_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_526_1.actors_[var_529_5.prefab_name].transform, "story_v_out_319501", "319501128", "story_v_out_319501.awb")

						arg_526_1:RecordAudio("319501128", var_529_11)
						arg_526_1:RecordAudio("319501128", var_529_11)
					else
						arg_526_1:AudioAction("play", "voice", "story_v_out_319501", "319501128", "story_v_out_319501.awb")
					end

					arg_526_1:RecordHistoryTalkVoice("story_v_out_319501", "319501128", "story_v_out_319501.awb")
				end

				arg_526_1:RecordContent(arg_526_1.text_.text)
			end

			local var_529_12 = math.max(var_529_3, arg_526_1.talkMaxDuration)

			if var_529_2 <= arg_526_1.time_ and arg_526_1.time_ < var_529_2 + var_529_12 then
				arg_526_1.typewritter.percent = (arg_526_1.time_ - var_529_2) / var_529_12

				arg_526_1.typewritter:SetDirty()
			end

			if arg_526_1.time_ >= var_529_2 + var_529_12 and arg_526_1.time_ < var_529_2 + var_529_12 + arg_529_0 then
				arg_526_1.typewritter.percent = 1

				arg_526_1.typewritter:SetDirty()
				arg_526_1:ShowNextGo(true)
			end
		end

		arg_526_1.nodeConfigList_ = {}

		arg_526_1:InitPlayNodeList()
	end,
	Play319501129 = function(arg_530_0, arg_530_1)
		arg_530_1.time_ = 0
		arg_530_1.frameCnt_ = 0
		arg_530_1.state_ = "playing"
		arg_530_1.curTalkId_ = 319501129
		arg_530_1.duration_ = 5

		SetActive(arg_530_1.tipsGo_, false)

		function arg_530_1.onSingleLineFinish_()
			arg_530_1.onSingleLineUpdate_ = nil
			arg_530_1.onSingleLineFinish_ = nil
			arg_530_1.state_ = "waiting"
		end

		function arg_530_1.playNext_(arg_532_0)
			if arg_532_0 == 1 then
				arg_530_0:Play319501130(arg_530_1)
			end
		end

		function arg_530_1.onSingleLineUpdate_(arg_533_0)
			local var_533_0 = arg_530_1.actors_["1084ui_story"]
			local var_533_1 = 0

			if var_533_1 < arg_530_1.time_ and arg_530_1.time_ <= var_533_1 + arg_533_0 and not isNil(var_533_0) and arg_530_1.var_.characterEffect1084ui_story == nil then
				arg_530_1.var_.characterEffect1084ui_story = var_533_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_533_2 = 0.200000002980232

			if var_533_1 <= arg_530_1.time_ and arg_530_1.time_ < var_533_1 + var_533_2 and not isNil(var_533_0) then
				local var_533_3 = (arg_530_1.time_ - var_533_1) / var_533_2

				if arg_530_1.var_.characterEffect1084ui_story and not isNil(var_533_0) then
					local var_533_4 = Mathf.Lerp(0, 0.5, var_533_3)

					arg_530_1.var_.characterEffect1084ui_story.fillFlat = true
					arg_530_1.var_.characterEffect1084ui_story.fillRatio = var_533_4
				end
			end

			if arg_530_1.time_ >= var_533_1 + var_533_2 and arg_530_1.time_ < var_533_1 + var_533_2 + arg_533_0 and not isNil(var_533_0) and arg_530_1.var_.characterEffect1084ui_story then
				local var_533_5 = 0.5

				arg_530_1.var_.characterEffect1084ui_story.fillFlat = true
				arg_530_1.var_.characterEffect1084ui_story.fillRatio = var_533_5
			end

			local var_533_6 = 0
			local var_533_7 = 0.8

			if var_533_6 < arg_530_1.time_ and arg_530_1.time_ <= var_533_6 + arg_533_0 then
				arg_530_1.talkMaxDuration = 0
				arg_530_1.dialogCg_.alpha = 1

				arg_530_1.dialog_:SetActive(true)
				SetActive(arg_530_1.leftNameGo_, false)

				arg_530_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_530_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_530_1:RecordName(arg_530_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_530_1.iconTrs_.gameObject, false)
				arg_530_1.callingController_:SetSelectedState("normal")

				local var_533_8 = arg_530_1:GetWordFromCfg(319501129)
				local var_533_9 = arg_530_1:FormatText(var_533_8.content)

				arg_530_1.text_.text = var_533_9

				LuaForUtil.ClearLinePrefixSymbol(arg_530_1.text_)

				local var_533_10 = 32
				local var_533_11 = utf8.len(var_533_9)
				local var_533_12 = var_533_10 <= 0 and var_533_7 or var_533_7 * (var_533_11 / var_533_10)

				if var_533_12 > 0 and var_533_7 < var_533_12 then
					arg_530_1.talkMaxDuration = var_533_12

					if var_533_12 + var_533_6 > arg_530_1.duration_ then
						arg_530_1.duration_ = var_533_12 + var_533_6
					end
				end

				arg_530_1.text_.text = var_533_9
				arg_530_1.typewritter.percent = 0

				arg_530_1.typewritter:SetDirty()
				arg_530_1:ShowNextGo(false)
				arg_530_1:RecordContent(arg_530_1.text_.text)
			end

			local var_533_13 = math.max(var_533_7, arg_530_1.talkMaxDuration)

			if var_533_6 <= arg_530_1.time_ and arg_530_1.time_ < var_533_6 + var_533_13 then
				arg_530_1.typewritter.percent = (arg_530_1.time_ - var_533_6) / var_533_13

				arg_530_1.typewritter:SetDirty()
			end

			if arg_530_1.time_ >= var_533_6 + var_533_13 and arg_530_1.time_ < var_533_6 + var_533_13 + arg_533_0 then
				arg_530_1.typewritter.percent = 1

				arg_530_1.typewritter:SetDirty()
				arg_530_1:ShowNextGo(true)
			end
		end

		arg_530_1.nodeConfigList_ = {}

		arg_530_1:InitPlayNodeList()
	end,
	Play319501130 = function(arg_534_0, arg_534_1)
		arg_534_1.time_ = 0
		arg_534_1.frameCnt_ = 0
		arg_534_1.state_ = "playing"
		arg_534_1.curTalkId_ = 319501130
		arg_534_1.duration_ = 5

		SetActive(arg_534_1.tipsGo_, false)

		function arg_534_1.onSingleLineFinish_()
			arg_534_1.onSingleLineUpdate_ = nil
			arg_534_1.onSingleLineFinish_ = nil
			arg_534_1.state_ = "waiting"
		end

		function arg_534_1.playNext_(arg_536_0)
			if arg_536_0 == 1 then
				arg_534_0:Play319501131(arg_534_1)
			end
		end

		function arg_534_1.onSingleLineUpdate_(arg_537_0)
			local var_537_0 = 0
			local var_537_1 = 0.75

			if var_537_0 < arg_534_1.time_ and arg_534_1.time_ <= var_537_0 + arg_537_0 then
				arg_534_1.talkMaxDuration = 0
				arg_534_1.dialogCg_.alpha = 1

				arg_534_1.dialog_:SetActive(true)
				SetActive(arg_534_1.leftNameGo_, false)

				arg_534_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_534_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_534_1:RecordName(arg_534_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_534_1.iconTrs_.gameObject, false)
				arg_534_1.callingController_:SetSelectedState("normal")

				local var_537_2 = arg_534_1:GetWordFromCfg(319501130)
				local var_537_3 = arg_534_1:FormatText(var_537_2.content)

				arg_534_1.text_.text = var_537_3

				LuaForUtil.ClearLinePrefixSymbol(arg_534_1.text_)

				local var_537_4 = 30
				local var_537_5 = utf8.len(var_537_3)
				local var_537_6 = var_537_4 <= 0 and var_537_1 or var_537_1 * (var_537_5 / var_537_4)

				if var_537_6 > 0 and var_537_1 < var_537_6 then
					arg_534_1.talkMaxDuration = var_537_6

					if var_537_6 + var_537_0 > arg_534_1.duration_ then
						arg_534_1.duration_ = var_537_6 + var_537_0
					end
				end

				arg_534_1.text_.text = var_537_3
				arg_534_1.typewritter.percent = 0

				arg_534_1.typewritter:SetDirty()
				arg_534_1:ShowNextGo(false)
				arg_534_1:RecordContent(arg_534_1.text_.text)
			end

			local var_537_7 = math.max(var_537_1, arg_534_1.talkMaxDuration)

			if var_537_0 <= arg_534_1.time_ and arg_534_1.time_ < var_537_0 + var_537_7 then
				arg_534_1.typewritter.percent = (arg_534_1.time_ - var_537_0) / var_537_7

				arg_534_1.typewritter:SetDirty()
			end

			if arg_534_1.time_ >= var_537_0 + var_537_7 and arg_534_1.time_ < var_537_0 + var_537_7 + arg_537_0 then
				arg_534_1.typewritter.percent = 1

				arg_534_1.typewritter:SetDirty()
				arg_534_1:ShowNextGo(true)
			end
		end

		arg_534_1.nodeConfigList_ = {}

		arg_534_1:InitPlayNodeList()
	end,
	Play319501131 = function(arg_538_0, arg_538_1)
		arg_538_1.time_ = 0
		arg_538_1.frameCnt_ = 0
		arg_538_1.state_ = "playing"
		arg_538_1.curTalkId_ = 319501131
		arg_538_1.duration_ = 2.1

		local var_538_0 = {
			zh = 2.1,
			ja = 1.999999999999
		}
		local var_538_1 = manager.audio:GetLocalizationFlag()

		if var_538_0[var_538_1] ~= nil then
			arg_538_1.duration_ = var_538_0[var_538_1]
		end

		SetActive(arg_538_1.tipsGo_, false)

		function arg_538_1.onSingleLineFinish_()
			arg_538_1.onSingleLineUpdate_ = nil
			arg_538_1.onSingleLineFinish_ = nil
			arg_538_1.state_ = "waiting"
		end

		function arg_538_1.playNext_(arg_540_0)
			if arg_540_0 == 1 then
				arg_538_0:Play319501132(arg_538_1)
			end
		end

		function arg_538_1.onSingleLineUpdate_(arg_541_0)
			local var_541_0 = arg_538_1.actors_["10068ui_story"]
			local var_541_1 = 0

			if var_541_1 < arg_538_1.time_ and arg_538_1.time_ <= var_541_1 + arg_541_0 and not isNil(var_541_0) and arg_538_1.var_.characterEffect10068ui_story == nil then
				arg_538_1.var_.characterEffect10068ui_story = var_541_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_541_2 = 0.200000002980232

			if var_541_1 <= arg_538_1.time_ and arg_538_1.time_ < var_541_1 + var_541_2 and not isNil(var_541_0) then
				local var_541_3 = (arg_538_1.time_ - var_541_1) / var_541_2

				if arg_538_1.var_.characterEffect10068ui_story and not isNil(var_541_0) then
					arg_538_1.var_.characterEffect10068ui_story.fillFlat = false
				end
			end

			if arg_538_1.time_ >= var_541_1 + var_541_2 and arg_538_1.time_ < var_541_1 + var_541_2 + arg_541_0 and not isNil(var_541_0) and arg_538_1.var_.characterEffect10068ui_story then
				arg_538_1.var_.characterEffect10068ui_story.fillFlat = false
			end

			local var_541_4 = 0

			if var_541_4 < arg_538_1.time_ and arg_538_1.time_ <= var_541_4 + arg_541_0 then
				arg_538_1:PlayTimeline("10068ui_story", "StoryTimeline/CharAction/story10068/story10068action/10068action2_2")
			end

			local var_541_5 = 0

			if var_541_5 < arg_538_1.time_ and arg_538_1.time_ <= var_541_5 + arg_541_0 then
				arg_538_1:PlayTimeline("10068ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_541_6 = 0

			if var_541_6 < arg_538_1.time_ and arg_538_1.time_ <= var_541_6 + arg_541_0 then
				arg_538_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3201cva")
			end

			local var_541_7 = 0
			local var_541_8 = 0.15

			if var_541_7 < arg_538_1.time_ and arg_538_1.time_ <= var_541_7 + arg_541_0 then
				arg_538_1.talkMaxDuration = 0
				arg_538_1.dialogCg_.alpha = 1

				arg_538_1.dialog_:SetActive(true)
				SetActive(arg_538_1.leftNameGo_, true)

				local var_541_9 = arg_538_1:FormatText(StoryNameCfg[697].name)

				arg_538_1.leftNameTxt_.text = var_541_9

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_538_1.leftNameTxt_.transform)

				arg_538_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_538_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_538_1:RecordName(arg_538_1.leftNameTxt_.text)
				SetActive(arg_538_1.iconTrs_.gameObject, false)
				arg_538_1.callingController_:SetSelectedState("normal")

				local var_541_10 = arg_538_1:GetWordFromCfg(319501131)
				local var_541_11 = arg_538_1:FormatText(var_541_10.content)

				arg_538_1.text_.text = var_541_11

				LuaForUtil.ClearLinePrefixSymbol(arg_538_1.text_)

				local var_541_12 = 6
				local var_541_13 = utf8.len(var_541_11)
				local var_541_14 = var_541_12 <= 0 and var_541_8 or var_541_8 * (var_541_13 / var_541_12)

				if var_541_14 > 0 and var_541_8 < var_541_14 then
					arg_538_1.talkMaxDuration = var_541_14

					if var_541_14 + var_541_7 > arg_538_1.duration_ then
						arg_538_1.duration_ = var_541_14 + var_541_7
					end
				end

				arg_538_1.text_.text = var_541_11
				arg_538_1.typewritter.percent = 0

				arg_538_1.typewritter:SetDirty()
				arg_538_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_319501", "319501131", "story_v_out_319501.awb") ~= 0 then
					local var_541_15 = manager.audio:GetVoiceLength("story_v_out_319501", "319501131", "story_v_out_319501.awb") / 1000

					if var_541_15 + var_541_7 > arg_538_1.duration_ then
						arg_538_1.duration_ = var_541_15 + var_541_7
					end

					if var_541_10.prefab_name ~= "" and arg_538_1.actors_[var_541_10.prefab_name] ~= nil then
						local var_541_16 = LuaForUtil.PlayVoiceWithCriLipsync(arg_538_1.actors_[var_541_10.prefab_name].transform, "story_v_out_319501", "319501131", "story_v_out_319501.awb")

						arg_538_1:RecordAudio("319501131", var_541_16)
						arg_538_1:RecordAudio("319501131", var_541_16)
					else
						arg_538_1:AudioAction("play", "voice", "story_v_out_319501", "319501131", "story_v_out_319501.awb")
					end

					arg_538_1:RecordHistoryTalkVoice("story_v_out_319501", "319501131", "story_v_out_319501.awb")
				end

				arg_538_1:RecordContent(arg_538_1.text_.text)
			end

			local var_541_17 = math.max(var_541_8, arg_538_1.talkMaxDuration)

			if var_541_7 <= arg_538_1.time_ and arg_538_1.time_ < var_541_7 + var_541_17 then
				arg_538_1.typewritter.percent = (arg_538_1.time_ - var_541_7) / var_541_17

				arg_538_1.typewritter:SetDirty()
			end

			if arg_538_1.time_ >= var_541_7 + var_541_17 and arg_538_1.time_ < var_541_7 + var_541_17 + arg_541_0 then
				arg_538_1.typewritter.percent = 1

				arg_538_1.typewritter:SetDirty()
				arg_538_1:ShowNextGo(true)
			end
		end

		arg_538_1.nodeConfigList_ = {}

		arg_538_1:InitPlayNodeList()
	end,
	Play319501132 = function(arg_542_0, arg_542_1)
		arg_542_1.time_ = 0
		arg_542_1.frameCnt_ = 0
		arg_542_1.state_ = "playing"
		arg_542_1.curTalkId_ = 319501132
		arg_542_1.duration_ = 16.47

		local var_542_0 = {
			zh = 9.766,
			ja = 16.466
		}
		local var_542_1 = manager.audio:GetLocalizationFlag()

		if var_542_0[var_542_1] ~= nil then
			arg_542_1.duration_ = var_542_0[var_542_1]
		end

		SetActive(arg_542_1.tipsGo_, false)

		function arg_542_1.onSingleLineFinish_()
			arg_542_1.onSingleLineUpdate_ = nil
			arg_542_1.onSingleLineFinish_ = nil
			arg_542_1.state_ = "waiting"
		end

		function arg_542_1.playNext_(arg_544_0)
			if arg_544_0 == 1 then
				arg_542_0:Play319501133(arg_542_1)
			end
		end

		function arg_542_1.onSingleLineUpdate_(arg_545_0)
			local var_545_0 = 0
			local var_545_1 = 0.925

			if var_545_0 < arg_542_1.time_ and arg_542_1.time_ <= var_545_0 + arg_545_0 then
				arg_542_1.talkMaxDuration = 0
				arg_542_1.dialogCg_.alpha = 1

				arg_542_1.dialog_:SetActive(true)
				SetActive(arg_542_1.leftNameGo_, true)

				local var_545_2 = arg_542_1:FormatText(StoryNameCfg[697].name)

				arg_542_1.leftNameTxt_.text = var_545_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_542_1.leftNameTxt_.transform)

				arg_542_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_542_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_542_1:RecordName(arg_542_1.leftNameTxt_.text)
				SetActive(arg_542_1.iconTrs_.gameObject, false)
				arg_542_1.callingController_:SetSelectedState("normal")

				local var_545_3 = arg_542_1:GetWordFromCfg(319501132)
				local var_545_4 = arg_542_1:FormatText(var_545_3.content)

				arg_542_1.text_.text = var_545_4

				LuaForUtil.ClearLinePrefixSymbol(arg_542_1.text_)

				local var_545_5 = 37
				local var_545_6 = utf8.len(var_545_4)
				local var_545_7 = var_545_5 <= 0 and var_545_1 or var_545_1 * (var_545_6 / var_545_5)

				if var_545_7 > 0 and var_545_1 < var_545_7 then
					arg_542_1.talkMaxDuration = var_545_7

					if var_545_7 + var_545_0 > arg_542_1.duration_ then
						arg_542_1.duration_ = var_545_7 + var_545_0
					end
				end

				arg_542_1.text_.text = var_545_4
				arg_542_1.typewritter.percent = 0

				arg_542_1.typewritter:SetDirty()
				arg_542_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_319501", "319501132", "story_v_out_319501.awb") ~= 0 then
					local var_545_8 = manager.audio:GetVoiceLength("story_v_out_319501", "319501132", "story_v_out_319501.awb") / 1000

					if var_545_8 + var_545_0 > arg_542_1.duration_ then
						arg_542_1.duration_ = var_545_8 + var_545_0
					end

					if var_545_3.prefab_name ~= "" and arg_542_1.actors_[var_545_3.prefab_name] ~= nil then
						local var_545_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_542_1.actors_[var_545_3.prefab_name].transform, "story_v_out_319501", "319501132", "story_v_out_319501.awb")

						arg_542_1:RecordAudio("319501132", var_545_9)
						arg_542_1:RecordAudio("319501132", var_545_9)
					else
						arg_542_1:AudioAction("play", "voice", "story_v_out_319501", "319501132", "story_v_out_319501.awb")
					end

					arg_542_1:RecordHistoryTalkVoice("story_v_out_319501", "319501132", "story_v_out_319501.awb")
				end

				arg_542_1:RecordContent(arg_542_1.text_.text)
			end

			local var_545_10 = math.max(var_545_1, arg_542_1.talkMaxDuration)

			if var_545_0 <= arg_542_1.time_ and arg_542_1.time_ < var_545_0 + var_545_10 then
				arg_542_1.typewritter.percent = (arg_542_1.time_ - var_545_0) / var_545_10

				arg_542_1.typewritter:SetDirty()
			end

			if arg_542_1.time_ >= var_545_0 + var_545_10 and arg_542_1.time_ < var_545_0 + var_545_10 + arg_545_0 then
				arg_542_1.typewritter.percent = 1

				arg_542_1.typewritter:SetDirty()
				arg_542_1:ShowNextGo(true)
			end
		end

		arg_542_1.nodeConfigList_ = {}

		arg_542_1:InitPlayNodeList()
	end,
	Play319501133 = function(arg_546_0, arg_546_1)
		arg_546_1.time_ = 0
		arg_546_1.frameCnt_ = 0
		arg_546_1.state_ = "playing"
		arg_546_1.curTalkId_ = 319501133
		arg_546_1.duration_ = 4.47

		local var_546_0 = {
			zh = 1.999999999999,
			ja = 4.466
		}
		local var_546_1 = manager.audio:GetLocalizationFlag()

		if var_546_0[var_546_1] ~= nil then
			arg_546_1.duration_ = var_546_0[var_546_1]
		end

		SetActive(arg_546_1.tipsGo_, false)

		function arg_546_1.onSingleLineFinish_()
			arg_546_1.onSingleLineUpdate_ = nil
			arg_546_1.onSingleLineFinish_ = nil
			arg_546_1.state_ = "waiting"
		end

		function arg_546_1.playNext_(arg_548_0)
			if arg_548_0 == 1 then
				arg_546_0:Play319501134(arg_546_1)
			end
		end

		function arg_546_1.onSingleLineUpdate_(arg_549_0)
			local var_549_0 = arg_546_1.actors_["1084ui_story"]
			local var_549_1 = 0

			if var_549_1 < arg_546_1.time_ and arg_546_1.time_ <= var_549_1 + arg_549_0 and not isNil(var_549_0) and arg_546_1.var_.characterEffect1084ui_story == nil then
				arg_546_1.var_.characterEffect1084ui_story = var_549_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_549_2 = 0.200000002980232

			if var_549_1 <= arg_546_1.time_ and arg_546_1.time_ < var_549_1 + var_549_2 and not isNil(var_549_0) then
				local var_549_3 = (arg_546_1.time_ - var_549_1) / var_549_2

				if arg_546_1.var_.characterEffect1084ui_story and not isNil(var_549_0) then
					arg_546_1.var_.characterEffect1084ui_story.fillFlat = false
				end
			end

			if arg_546_1.time_ >= var_549_1 + var_549_2 and arg_546_1.time_ < var_549_1 + var_549_2 + arg_549_0 and not isNil(var_549_0) and arg_546_1.var_.characterEffect1084ui_story then
				arg_546_1.var_.characterEffect1084ui_story.fillFlat = false
			end

			local var_549_4 = 0

			if var_549_4 < arg_546_1.time_ and arg_546_1.time_ <= var_549_4 + arg_549_0 then
				arg_546_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/story1084/story1084action/1084action1_1")
			end

			local var_549_5 = 0

			if var_549_5 < arg_546_1.time_ and arg_546_1.time_ <= var_549_5 + arg_549_0 then
				arg_546_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1101cva")
			end

			local var_549_6 = arg_546_1.actors_["10068ui_story"]
			local var_549_7 = 0

			if var_549_7 < arg_546_1.time_ and arg_546_1.time_ <= var_549_7 + arg_549_0 and not isNil(var_549_6) and arg_546_1.var_.characterEffect10068ui_story == nil then
				arg_546_1.var_.characterEffect10068ui_story = var_549_6:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_549_8 = 0.200000002980232

			if var_549_7 <= arg_546_1.time_ and arg_546_1.time_ < var_549_7 + var_549_8 and not isNil(var_549_6) then
				local var_549_9 = (arg_546_1.time_ - var_549_7) / var_549_8

				if arg_546_1.var_.characterEffect10068ui_story and not isNil(var_549_6) then
					local var_549_10 = Mathf.Lerp(0, 0.5, var_549_9)

					arg_546_1.var_.characterEffect10068ui_story.fillFlat = true
					arg_546_1.var_.characterEffect10068ui_story.fillRatio = var_549_10
				end
			end

			if arg_546_1.time_ >= var_549_7 + var_549_8 and arg_546_1.time_ < var_549_7 + var_549_8 + arg_549_0 and not isNil(var_549_6) and arg_546_1.var_.characterEffect10068ui_story then
				local var_549_11 = 0.5

				arg_546_1.var_.characterEffect10068ui_story.fillFlat = true
				arg_546_1.var_.characterEffect10068ui_story.fillRatio = var_549_11
			end

			local var_549_12 = 0
			local var_549_13 = 0.15

			if var_549_12 < arg_546_1.time_ and arg_546_1.time_ <= var_549_12 + arg_549_0 then
				arg_546_1.talkMaxDuration = 0
				arg_546_1.dialogCg_.alpha = 1

				arg_546_1.dialog_:SetActive(true)
				SetActive(arg_546_1.leftNameGo_, true)

				local var_549_14 = arg_546_1:FormatText(StoryNameCfg[6].name)

				arg_546_1.leftNameTxt_.text = var_549_14

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_546_1.leftNameTxt_.transform)

				arg_546_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_546_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_546_1:RecordName(arg_546_1.leftNameTxt_.text)
				SetActive(arg_546_1.iconTrs_.gameObject, false)
				arg_546_1.callingController_:SetSelectedState("normal")

				local var_549_15 = arg_546_1:GetWordFromCfg(319501133)
				local var_549_16 = arg_546_1:FormatText(var_549_15.content)

				arg_546_1.text_.text = var_549_16

				LuaForUtil.ClearLinePrefixSymbol(arg_546_1.text_)

				local var_549_17 = 6
				local var_549_18 = utf8.len(var_549_16)
				local var_549_19 = var_549_17 <= 0 and var_549_13 or var_549_13 * (var_549_18 / var_549_17)

				if var_549_19 > 0 and var_549_13 < var_549_19 then
					arg_546_1.talkMaxDuration = var_549_19

					if var_549_19 + var_549_12 > arg_546_1.duration_ then
						arg_546_1.duration_ = var_549_19 + var_549_12
					end
				end

				arg_546_1.text_.text = var_549_16
				arg_546_1.typewritter.percent = 0

				arg_546_1.typewritter:SetDirty()
				arg_546_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_319501", "319501133", "story_v_out_319501.awb") ~= 0 then
					local var_549_20 = manager.audio:GetVoiceLength("story_v_out_319501", "319501133", "story_v_out_319501.awb") / 1000

					if var_549_20 + var_549_12 > arg_546_1.duration_ then
						arg_546_1.duration_ = var_549_20 + var_549_12
					end

					if var_549_15.prefab_name ~= "" and arg_546_1.actors_[var_549_15.prefab_name] ~= nil then
						local var_549_21 = LuaForUtil.PlayVoiceWithCriLipsync(arg_546_1.actors_[var_549_15.prefab_name].transform, "story_v_out_319501", "319501133", "story_v_out_319501.awb")

						arg_546_1:RecordAudio("319501133", var_549_21)
						arg_546_1:RecordAudio("319501133", var_549_21)
					else
						arg_546_1:AudioAction("play", "voice", "story_v_out_319501", "319501133", "story_v_out_319501.awb")
					end

					arg_546_1:RecordHistoryTalkVoice("story_v_out_319501", "319501133", "story_v_out_319501.awb")
				end

				arg_546_1:RecordContent(arg_546_1.text_.text)
			end

			local var_549_22 = math.max(var_549_13, arg_546_1.talkMaxDuration)

			if var_549_12 <= arg_546_1.time_ and arg_546_1.time_ < var_549_12 + var_549_22 then
				arg_546_1.typewritter.percent = (arg_546_1.time_ - var_549_12) / var_549_22

				arg_546_1.typewritter:SetDirty()
			end

			if arg_546_1.time_ >= var_549_12 + var_549_22 and arg_546_1.time_ < var_549_12 + var_549_22 + arg_549_0 then
				arg_546_1.typewritter.percent = 1

				arg_546_1.typewritter:SetDirty()
				arg_546_1:ShowNextGo(true)
			end
		end

		arg_546_1.nodeConfigList_ = {}

		arg_546_1:InitPlayNodeList()
	end,
	Play319501134 = function(arg_550_0, arg_550_1)
		arg_550_1.time_ = 0
		arg_550_1.frameCnt_ = 0
		arg_550_1.state_ = "playing"
		arg_550_1.curTalkId_ = 319501134
		arg_550_1.duration_ = 5

		SetActive(arg_550_1.tipsGo_, false)

		function arg_550_1.onSingleLineFinish_()
			arg_550_1.onSingleLineUpdate_ = nil
			arg_550_1.onSingleLineFinish_ = nil
			arg_550_1.state_ = "waiting"
		end

		function arg_550_1.playNext_(arg_552_0)
			if arg_552_0 == 1 then
				arg_550_0:Play319501135(arg_550_1)
			end
		end

		function arg_550_1.onSingleLineUpdate_(arg_553_0)
			local var_553_0 = arg_550_1.actors_["1084ui_story"]
			local var_553_1 = 0

			if var_553_1 < arg_550_1.time_ and arg_550_1.time_ <= var_553_1 + arg_553_0 and not isNil(var_553_0) and arg_550_1.var_.characterEffect1084ui_story == nil then
				arg_550_1.var_.characterEffect1084ui_story = var_553_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_553_2 = 0.200000002980232

			if var_553_1 <= arg_550_1.time_ and arg_550_1.time_ < var_553_1 + var_553_2 and not isNil(var_553_0) then
				local var_553_3 = (arg_550_1.time_ - var_553_1) / var_553_2

				if arg_550_1.var_.characterEffect1084ui_story and not isNil(var_553_0) then
					local var_553_4 = Mathf.Lerp(0, 0.5, var_553_3)

					arg_550_1.var_.characterEffect1084ui_story.fillFlat = true
					arg_550_1.var_.characterEffect1084ui_story.fillRatio = var_553_4
				end
			end

			if arg_550_1.time_ >= var_553_1 + var_553_2 and arg_550_1.time_ < var_553_1 + var_553_2 + arg_553_0 and not isNil(var_553_0) and arg_550_1.var_.characterEffect1084ui_story then
				local var_553_5 = 0.5

				arg_550_1.var_.characterEffect1084ui_story.fillFlat = true
				arg_550_1.var_.characterEffect1084ui_story.fillRatio = var_553_5
			end

			local var_553_6 = 0
			local var_553_7 = 0.825

			if var_553_6 < arg_550_1.time_ and arg_550_1.time_ <= var_553_6 + arg_553_0 then
				arg_550_1.talkMaxDuration = 0
				arg_550_1.dialogCg_.alpha = 1

				arg_550_1.dialog_:SetActive(true)
				SetActive(arg_550_1.leftNameGo_, false)

				arg_550_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_550_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_550_1:RecordName(arg_550_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_550_1.iconTrs_.gameObject, false)
				arg_550_1.callingController_:SetSelectedState("normal")

				local var_553_8 = arg_550_1:GetWordFromCfg(319501134)
				local var_553_9 = arg_550_1:FormatText(var_553_8.content)

				arg_550_1.text_.text = var_553_9

				LuaForUtil.ClearLinePrefixSymbol(arg_550_1.text_)

				local var_553_10 = 33
				local var_553_11 = utf8.len(var_553_9)
				local var_553_12 = var_553_10 <= 0 and var_553_7 or var_553_7 * (var_553_11 / var_553_10)

				if var_553_12 > 0 and var_553_7 < var_553_12 then
					arg_550_1.talkMaxDuration = var_553_12

					if var_553_12 + var_553_6 > arg_550_1.duration_ then
						arg_550_1.duration_ = var_553_12 + var_553_6
					end
				end

				arg_550_1.text_.text = var_553_9
				arg_550_1.typewritter.percent = 0

				arg_550_1.typewritter:SetDirty()
				arg_550_1:ShowNextGo(false)
				arg_550_1:RecordContent(arg_550_1.text_.text)
			end

			local var_553_13 = math.max(var_553_7, arg_550_1.talkMaxDuration)

			if var_553_6 <= arg_550_1.time_ and arg_550_1.time_ < var_553_6 + var_553_13 then
				arg_550_1.typewritter.percent = (arg_550_1.time_ - var_553_6) / var_553_13

				arg_550_1.typewritter:SetDirty()
			end

			if arg_550_1.time_ >= var_553_6 + var_553_13 and arg_550_1.time_ < var_553_6 + var_553_13 + arg_553_0 then
				arg_550_1.typewritter.percent = 1

				arg_550_1.typewritter:SetDirty()
				arg_550_1:ShowNextGo(true)
			end
		end

		arg_550_1.nodeConfigList_ = {}

		arg_550_1:InitPlayNodeList()
	end,
	Play319501135 = function(arg_554_0, arg_554_1)
		arg_554_1.time_ = 0
		arg_554_1.frameCnt_ = 0
		arg_554_1.state_ = "playing"
		arg_554_1.curTalkId_ = 319501135
		arg_554_1.duration_ = 9.1

		local var_554_0 = {
			zh = 4.733,
			ja = 9.1
		}
		local var_554_1 = manager.audio:GetLocalizationFlag()

		if var_554_0[var_554_1] ~= nil then
			arg_554_1.duration_ = var_554_0[var_554_1]
		end

		SetActive(arg_554_1.tipsGo_, false)

		function arg_554_1.onSingleLineFinish_()
			arg_554_1.onSingleLineUpdate_ = nil
			arg_554_1.onSingleLineFinish_ = nil
			arg_554_1.state_ = "waiting"
		end

		function arg_554_1.playNext_(arg_556_0)
			if arg_556_0 == 1 then
				arg_554_0:Play319501136(arg_554_1)
			end
		end

		function arg_554_1.onSingleLineUpdate_(arg_557_0)
			local var_557_0 = arg_554_1.actors_["1084ui_story"]
			local var_557_1 = 0

			if var_557_1 < arg_554_1.time_ and arg_554_1.time_ <= var_557_1 + arg_557_0 and not isNil(var_557_0) and arg_554_1.var_.characterEffect1084ui_story == nil then
				arg_554_1.var_.characterEffect1084ui_story = var_557_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_557_2 = 0.200000002980232

			if var_557_1 <= arg_554_1.time_ and arg_554_1.time_ < var_557_1 + var_557_2 and not isNil(var_557_0) then
				local var_557_3 = (arg_554_1.time_ - var_557_1) / var_557_2

				if arg_554_1.var_.characterEffect1084ui_story and not isNil(var_557_0) then
					arg_554_1.var_.characterEffect1084ui_story.fillFlat = false
				end
			end

			if arg_554_1.time_ >= var_557_1 + var_557_2 and arg_554_1.time_ < var_557_1 + var_557_2 + arg_557_0 and not isNil(var_557_0) and arg_554_1.var_.characterEffect1084ui_story then
				arg_554_1.var_.characterEffect1084ui_story.fillFlat = false
			end

			local var_557_4 = 0
			local var_557_5 = 0.6

			if var_557_4 < arg_554_1.time_ and arg_554_1.time_ <= var_557_4 + arg_557_0 then
				arg_554_1.talkMaxDuration = 0
				arg_554_1.dialogCg_.alpha = 1

				arg_554_1.dialog_:SetActive(true)
				SetActive(arg_554_1.leftNameGo_, true)

				local var_557_6 = arg_554_1:FormatText(StoryNameCfg[6].name)

				arg_554_1.leftNameTxt_.text = var_557_6

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_554_1.leftNameTxt_.transform)

				arg_554_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_554_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_554_1:RecordName(arg_554_1.leftNameTxt_.text)
				SetActive(arg_554_1.iconTrs_.gameObject, false)
				arg_554_1.callingController_:SetSelectedState("normal")

				local var_557_7 = arg_554_1:GetWordFromCfg(319501135)
				local var_557_8 = arg_554_1:FormatText(var_557_7.content)

				arg_554_1.text_.text = var_557_8

				LuaForUtil.ClearLinePrefixSymbol(arg_554_1.text_)

				local var_557_9 = 24
				local var_557_10 = utf8.len(var_557_8)
				local var_557_11 = var_557_9 <= 0 and var_557_5 or var_557_5 * (var_557_10 / var_557_9)

				if var_557_11 > 0 and var_557_5 < var_557_11 then
					arg_554_1.talkMaxDuration = var_557_11

					if var_557_11 + var_557_4 > arg_554_1.duration_ then
						arg_554_1.duration_ = var_557_11 + var_557_4
					end
				end

				arg_554_1.text_.text = var_557_8
				arg_554_1.typewritter.percent = 0

				arg_554_1.typewritter:SetDirty()
				arg_554_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_319501", "319501135", "story_v_out_319501.awb") ~= 0 then
					local var_557_12 = manager.audio:GetVoiceLength("story_v_out_319501", "319501135", "story_v_out_319501.awb") / 1000

					if var_557_12 + var_557_4 > arg_554_1.duration_ then
						arg_554_1.duration_ = var_557_12 + var_557_4
					end

					if var_557_7.prefab_name ~= "" and arg_554_1.actors_[var_557_7.prefab_name] ~= nil then
						local var_557_13 = LuaForUtil.PlayVoiceWithCriLipsync(arg_554_1.actors_[var_557_7.prefab_name].transform, "story_v_out_319501", "319501135", "story_v_out_319501.awb")

						arg_554_1:RecordAudio("319501135", var_557_13)
						arg_554_1:RecordAudio("319501135", var_557_13)
					else
						arg_554_1:AudioAction("play", "voice", "story_v_out_319501", "319501135", "story_v_out_319501.awb")
					end

					arg_554_1:RecordHistoryTalkVoice("story_v_out_319501", "319501135", "story_v_out_319501.awb")
				end

				arg_554_1:RecordContent(arg_554_1.text_.text)
			end

			local var_557_14 = math.max(var_557_5, arg_554_1.talkMaxDuration)

			if var_557_4 <= arg_554_1.time_ and arg_554_1.time_ < var_557_4 + var_557_14 then
				arg_554_1.typewritter.percent = (arg_554_1.time_ - var_557_4) / var_557_14

				arg_554_1.typewritter:SetDirty()
			end

			if arg_554_1.time_ >= var_557_4 + var_557_14 and arg_554_1.time_ < var_557_4 + var_557_14 + arg_557_0 then
				arg_554_1.typewritter.percent = 1

				arg_554_1.typewritter:SetDirty()
				arg_554_1:ShowNextGo(true)
			end
		end

		arg_554_1.nodeConfigList_ = {}

		arg_554_1:InitPlayNodeList()
	end,
	Play319501136 = function(arg_558_0, arg_558_1)
		arg_558_1.time_ = 0
		arg_558_1.frameCnt_ = 0
		arg_558_1.state_ = "playing"
		arg_558_1.curTalkId_ = 319501136
		arg_558_1.duration_ = 9.97

		local var_558_0 = {
			zh = 5.9,
			ja = 9.966
		}
		local var_558_1 = manager.audio:GetLocalizationFlag()

		if var_558_0[var_558_1] ~= nil then
			arg_558_1.duration_ = var_558_0[var_558_1]
		end

		SetActive(arg_558_1.tipsGo_, false)

		function arg_558_1.onSingleLineFinish_()
			arg_558_1.onSingleLineUpdate_ = nil
			arg_558_1.onSingleLineFinish_ = nil
			arg_558_1.state_ = "waiting"
			arg_558_1.auto_ = false
		end

		function arg_558_1.playNext_(arg_560_0)
			arg_558_1.onStoryFinished_()
		end

		function arg_558_1.onSingleLineUpdate_(arg_561_0)
			local var_561_0 = 0
			local var_561_1 = 0.725

			if var_561_0 < arg_558_1.time_ and arg_558_1.time_ <= var_561_0 + arg_561_0 then
				arg_558_1.talkMaxDuration = 0
				arg_558_1.dialogCg_.alpha = 1

				arg_558_1.dialog_:SetActive(true)
				SetActive(arg_558_1.leftNameGo_, true)

				local var_561_2 = arg_558_1:FormatText(StoryNameCfg[6].name)

				arg_558_1.leftNameTxt_.text = var_561_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_558_1.leftNameTxt_.transform)

				arg_558_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_558_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_558_1:RecordName(arg_558_1.leftNameTxt_.text)
				SetActive(arg_558_1.iconTrs_.gameObject, false)
				arg_558_1.callingController_:SetSelectedState("normal")

				local var_561_3 = arg_558_1:GetWordFromCfg(319501136)
				local var_561_4 = arg_558_1:FormatText(var_561_3.content)

				arg_558_1.text_.text = var_561_4

				LuaForUtil.ClearLinePrefixSymbol(arg_558_1.text_)

				local var_561_5 = 29
				local var_561_6 = utf8.len(var_561_4)
				local var_561_7 = var_561_5 <= 0 and var_561_1 or var_561_1 * (var_561_6 / var_561_5)

				if var_561_7 > 0 and var_561_1 < var_561_7 then
					arg_558_1.talkMaxDuration = var_561_7

					if var_561_7 + var_561_0 > arg_558_1.duration_ then
						arg_558_1.duration_ = var_561_7 + var_561_0
					end
				end

				arg_558_1.text_.text = var_561_4
				arg_558_1.typewritter.percent = 0

				arg_558_1.typewritter:SetDirty()
				arg_558_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_319501", "319501136", "story_v_out_319501.awb") ~= 0 then
					local var_561_8 = manager.audio:GetVoiceLength("story_v_out_319501", "319501136", "story_v_out_319501.awb") / 1000

					if var_561_8 + var_561_0 > arg_558_1.duration_ then
						arg_558_1.duration_ = var_561_8 + var_561_0
					end

					if var_561_3.prefab_name ~= "" and arg_558_1.actors_[var_561_3.prefab_name] ~= nil then
						local var_561_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_558_1.actors_[var_561_3.prefab_name].transform, "story_v_out_319501", "319501136", "story_v_out_319501.awb")

						arg_558_1:RecordAudio("319501136", var_561_9)
						arg_558_1:RecordAudio("319501136", var_561_9)
					else
						arg_558_1:AudioAction("play", "voice", "story_v_out_319501", "319501136", "story_v_out_319501.awb")
					end

					arg_558_1:RecordHistoryTalkVoice("story_v_out_319501", "319501136", "story_v_out_319501.awb")
				end

				arg_558_1:RecordContent(arg_558_1.text_.text)
			end

			local var_561_10 = math.max(var_561_1, arg_558_1.talkMaxDuration)

			if var_561_0 <= arg_558_1.time_ and arg_558_1.time_ < var_561_0 + var_561_10 then
				arg_558_1.typewritter.percent = (arg_558_1.time_ - var_561_0) / var_561_10

				arg_558_1.typewritter:SetDirty()
			end

			if arg_558_1.time_ >= var_561_0 + var_561_10 and arg_558_1.time_ < var_561_0 + var_561_10 + arg_561_0 then
				arg_558_1.typewritter.percent = 1

				arg_558_1.typewritter:SetDirty()
				arg_558_1:ShowNextGo(true)
			end
		end

		arg_558_1.nodeConfigList_ = {}

		arg_558_1:InitPlayNodeList()
	end,
	assets = {
		"TextureConfig/Background/ST72",
		"TextureConfig/Background/STblack",
		"TextureConfig/Background/ST71",
		"TextureConfig/Background/ML0105"
	},
	voices = {
		"story_v_out_319501.awb"
	}
}
